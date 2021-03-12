Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13B33383A7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 03:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCLCjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 21:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhCLCj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 21:39:26 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1541FC061760
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:39:26 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z5so11225433plg.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=djQZd3ysyoSutQHrswnBnuimUYSb59dZwog3T2MV0T0=;
        b=mLI4wibQX2QDrTDp0g3oVwAnp8g8JH2ZHX3coY+tloIS7hQDHaHg7O3U0tqNyPkaXm
         8rDqn7xBBo4XHsB+a2U3CBHCbqJ61M0ldpB/4IwR6Z3ug6eLs539FiVfed3DGaRV2ZTJ
         k+65bJQ0eM8Sc9pNW/ZbuOFd1znR6iQPephC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=djQZd3ysyoSutQHrswnBnuimUYSb59dZwog3T2MV0T0=;
        b=o5TiOa5Eq9gDyvhwUzGXkGcQw2pCnpp2YhIo/RrkvppkEWiNQUfwy+P0RS/BEyij7L
         KqHry91fiXqbubF1JfRn7n2HDtbaV5mmeXoVPjwJSC0olRhFxJP9YrrLiH89YR1kIoqS
         CfMn+iIvSEI8ZB+0wSdQAIkh6xjY1e3AP4ZaAKjQRwvLhsRWh40T2+HdVg3Ou7+SKyj1
         mgy+yRU7DRO+sFtymUOw6UCAH0uRvcq4NC3bHZb83iFfsBTnCXC5KfccJ04tyMSHuIpI
         2Fc8Hlp69TpKzVEsQhk60E16+ny+Q/6OnnIEkWpUcQTP7e46JGRc7RVCvLVGRD0EqIZo
         w4hQ==
X-Gm-Message-State: AOAM530y7ljYBQF+Ku4GFCORHZy/LjJwyYEbBIoCGIO/o3HblBHgsFKJ
        Gnrbu8g2plYrivnvmlPUiZBBYQ==
X-Google-Smtp-Source: ABdhPJyXid/WhlRRi3IuEn/gj018RDIJnIysnt+MQKHLqWW7jwLJATluPmfQx4YLScgrHSTI05ABow==
X-Received: by 2002:a17:902:344:b029:e4:a7ab:2e55 with SMTP id 62-20020a1709020344b02900e4a7ab2e55mr11594605pld.63.1615516765493;
        Thu, 11 Mar 2021 18:39:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k127sm3858828pfd.63.2021.03.11.18.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:39:24 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:39:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/17] module: cfi: ensure __cfi_check alignment
Message-ID: <202103111837.813997B4@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-5-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:06PM -0800, Sami Tolvanen wrote:
> CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
> aligned and at the beginning of the .text section. While Clang would
> normally align the function correctly, it fails to do so for modules
> with no executable code.
> 
> This change ensures the correct __cfi_check() location and
> alignment. It also discards the .eh_frame section, which Clang can
> generate with certain sanitizers, such as CFI.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=46293
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  scripts/module.lds.S | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 168cd27e6122..552ddb084f76 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -3,10 +3,13 @@
>   * Archs are free to supply their own linker scripts.  ld will
>   * combine them automatically.
>   */
> +#include <asm/page.h>
> +
>  SECTIONS {
>  	/DISCARD/ : {
>  		*(.discard)
>  		*(.discard.*)
> +		*(.eh_frame)
>  	}
>  
>  	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
> @@ -40,7 +43,16 @@ SECTIONS {
>  		*(.rodata..L*)
>  	}
>  
> -	.text : { *(.text .text.[0-9a-zA-Z_]*) }
> +#ifdef CONFIG_CFI_CLANG
> +	/*
> +	 * With CFI_CLANG, ensure __cfi_check is at the beginning of the
> +	 * .text section, and that the section is aligned to page size.
> +	 */
> +	.text : ALIGN(PAGE_SIZE) {
> +		*(.text.__cfi_check)
> +		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
> +	}
> +#endif

Whoops, I think this reverts to the default .text declaration when
CONFIG_CFI_CLANG is unset.

I think the only thing that needs the ifdef is the ALIGN, yes? Perhaps
something like this?

#ifdef CONFIG_CFI_CLANG
# define ALIGN_CFI ALIGN(PAGE_SIZE)
#else
# define ALIGN_CFI
#endif

	.text : ALIGN_CFI {
		*(.text.__cfi_check)
		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
	}


-Kees

>  }
>  
>  /* bring in arch-specific sections */
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 

-- 
Kees Cook
