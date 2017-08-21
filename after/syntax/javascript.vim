" Vim syntax file
" Language:   styled-components, graphql (js/ts)
" Maintainer: Jof Arnold <vim@jofarnold.com>
" URL:        https://github.com/jofarnold/vim-literal-indent

if exists("b:current_syntax")
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif

" find import line matching styled-components
let styled_literal = search('styled.*`', 'n')
let gql_literal = search('gql`', 'n')

" if there is such a line in the document
if styled_literal > 0 || gql_literal > 0
  " extend javascript syntax
  runtime! syntax/css.vim
  runtime! syntax/css/*.vim

  " re-implement cssAttrRegion
  syn region customCssAttrRegion start=/[^&]:/ end=/\ze\(,\|;\|)\|{\|}\)/
        \ contained
        \ contains=css.*Attr,cssColor,cssImportant,cssValue.*,cssFunction,
        \          cssString.*,cssURL,cssComment,cssUnicodeEscape,cssVendor,
        \          cssError,cssAttrComma,cssNoise

  " re-define CSS cluster (mainly to omit cssAttrRegion)
  syntax cluster CSS
        \ contains=cssAnimation,cssAnimationAttr,cssAnimationProp,cssAttr,
        \          cssAttrComma,cssAttributeSelector,cssAuralAttr,
        \          cssAuralProp,cssBackgroundAttr,cssBackgroundProp,
        \          cssBorderAttr,cssBorderProp,cssBoxAttr,cssBoxProp,cssBraces,
        \          cssClassName,cssClassNameDot,cssColor,cssColorProp,cssComma,
        \          cssComment,cssCommonAttr,cssContentForPagedMediaAttr,
        \          cssContentForPagedMediaProp,cssDefinition,cssDeprecated,
        \          cssDimensionAttr,cssDimensionProp,cssError,
        \          cssFlexibleBoxAttr,cssFlexibleBoxProp,cssFontAttr,
        \          cssFontDescriptor,cssFontDescriptorAttr,
        \          cssFontDescriptorBlock,cssFontDescriptorFunction,
        \          cssFontDescriptorProp,cssFontProp,cssFunction,
        \          cssFunctionComma,cssFunctionName,cssGeneratedContentAttr,
        \          cssGeneratedContentProp,cssGradientAttr,cssGridAttr,
        \          cssGridProp,cssHacks,cssHyerlinkAttr,cssHyerlinkProp,
        \          cssIEUIAttr,cssIEUIProp,cssIdentifier,cssImportant,
        \          cssInclude,cssIncludeKeyword,cssKeyFrame,
        \          cssKeyFrameSelector,cssKeyFrameWrap,cssLineboxAttr,
        \          cssLineboxProp,cssListAttr,cssListProp,cssMarginAttr,
        \          cssMarqueeAttr,cssMarqueeProp,cssMedia,cssMediaAttr,
        \          cssMediaBlock,cssMediaComma,cssMediaKeyword,cssMediaProp,
        \          cssMediaType,cssMobileTextProp,cssMultiColumnAttr,
        \          cssMultiColumnProp,cssNoise,cssPaddingAttr,cssPage,
        \          cssPageMargin,cssPageProp,cssPagePseudo,cssPageWrap,
        \          cssPagedMediaAttr,cssPagedMediaProp,cssPositioningAttr,
        \          cssPositioningProp,cssPrintAttr,cssPrintProp,cssProp,
        \          cssPseudoClass,cssPseudoClassFn,cssPseudoClassId,
        \          cssPseudoClassLang,cssRenderAttr,cssRenderProp,cssRubyAttr,
        \          cssRubyProp,cssSelectorOp,cssSelectorOp2,cssSpecialCharQ,
        \          cssSpecialCharQQ,cssSpeechAttr,cssSpeechProp,cssStringQ,
        \          cssStringQQ,cssTableAttr,cssTableProp,cssTagName,
        \          cssTextAttr,cssTextProp,cssTransformAttr,cssTransformProp,
        \          cssTransitionAttr,cssTransitionProp,cssUIAttr,cssUIProp,
        \          cssURL,cssUnicodeEscape,cssUnicodeRange,cssUnitDecorators,
        \          cssValueAngle,cssValueFrequency,cssValueInteger,
        \          cssValueLength,cssValueNumber,cssValueTime,cssVend,
        \          customCssAttrRegion

  " allow additional CSS in cssDefinitions
  "   `[^$]` skips "${", so that js template expressions are not considered
  "   cssDefinitions and thus do not contain CSS definitions
  syn region cssDefinition matchgroup=cssBraces start=+[^$]{+ end=+}+
        \ contained transparent fold contains=@CSS

  " extend jsTemplateString syntax
  syntax region jsTemplateString start=+`+ skip=+\\\(`\|$\)+ end=+`+
        \ extend transparent fold contains=@CSS
endif


if exists("s:current_syntax")
  let b:current_syntax=s:current_syntax
endif
