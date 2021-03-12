Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592393383B7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 03:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhCLCkn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 21:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhCLCk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 21:40:27 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDBBC061764
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:40:25 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s7so11215108plg.5
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KiZc8nN5pryJpzXUOJy7bJ2ujYQabS0eWCsV+Q2Fjh8=;
        b=DZqCKeDaA8I99V3+1mZBQymMEqo9f9/pBg9BgWDPK7N3AjBq1yFa1+GBW1jFNRLRd3
         hKf7PNNHeLvoSgyG2ej4hi9xWPV/EzF7hsH79qSSrH3lKG0yD73RGYWaGFHYY5cSqb26
         TiBly3t+H94MBcwBova2NHIfs+27cLe25uxBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KiZc8nN5pryJpzXUOJy7bJ2ujYQabS0eWCsV+Q2Fjh8=;
        b=IyzN1QVoSzbnZwxaBz/ZpsNDrjC6o/cEFr67qklfpQz95e54t8/JievrVUA5S9aVPE
         62wUEMT8OQ8LoX+mp/MhRQJ8D7+vGVxIkZiJz0F7N/8yeIpXPmhbP+mbFgFEO5nWKUvg
         0NvzSu6Dp6l8MWfMzsDPwz97fQVdQGEW74s5AcD06yd96WhAegpRqtLCMs5fFJPbVnef
         gC2/xf5NLY3ZxdCxy1gQoXUr6mpcy1lLRpA2Tg677mRhgmsMlOvPmchwIt3SWeIIUGot
         N8Ucm3UI/Af/ZXOfD2aKYNU2/MByq3D/1ddTZELaQAsR3lB4YfKkBSK3zRS/B1g0hhtO
         iO+w==
X-Gm-Message-State: AOAM5308u3ZGJYggcKQ2T+mI5w3AXjtgV2NEmRP/BxPnEiSqck1j6Fhj
        7woW+ZjirpZ8D3VpJZXi5QppYA==
X-Google-Smtp-Source: ABdhPJz/EQDfMcfGqOziqYaQrc/zqH66k4oqcRejrkalla+YmWjVV7VvtiUOnYrWNhEhKA7Nrnvn7A==
X-Received: by 2002:a17:903:102:b029:e5:fc29:de83 with SMTP id y2-20020a1709030102b02900e5fc29de83mr11286686plc.31.1615516824770;
        Thu, 11 Mar 2021 18:40:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z2sm3590568pfc.8.2021.03.11.18.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:40:24 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:40:23 -0800
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
Subject: Re: [PATCH 02/17] cfi: add __cficanonical
Message-ID: <202103111839.81B67E6@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-3-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:04PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces a function address taken
> in C code with the address of a local jump table entry, which passes
> runtime indirect call checks. However, the compiler won't replace
> addresses taken in assembly code, which will result in a CFI failure
> if we later jump to such an address in instrumented C code. The code
> generated for the non-canonical jump table looks this:
> 
>   <noncanonical.cfi_jt>: /* In C, &noncanonical points here */
> 	jmp noncanonical
>   ...
>   <noncanonical>:        /* function body */
> 	...
> 
> This change adds the __cficanonical attribute, which tells the
> compiler to use a canonical jump table for the function instead. This
> means the compiler will rename the actual function to <function>.cfi
> and points the original symbol to the jump table entry instead:
> 
>   <canonical>:           /* jump table entry */
> 	jmp canonical.cfi
>   ...
>   <canonical.cfi>:       /* function body */
> 	...
> 
> As a result, the address taken in assembly, or other non-instrumented
> code always points to the jump table and therefore, can be used for
> indirect calls in instrumented code without tripping CFI checks.

Thanks for this changelog! Having the explicit examples helps keep this
clear.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  include/linux/compiler-clang.h | 1 +
>  include/linux/compiler_types.h | 4 ++++
>  include/linux/init.h           | 4 ++--
>  include/linux/pci.h            | 4 ++--
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 1ff22bdad992..c275f23ce023 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -57,3 +57,4 @@
>  #endif
>  
>  #define __nocfi		__attribute__((__no_sanitize__("cfi")))
> +#define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 796935a37e37..d29bda7f6ebd 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -246,6 +246,10 @@ struct ftrace_likely_data {
>  # define __nocfi
>  #endif
>  
> +#ifndef __cficanonical
> +# define __cficanonical
> +#endif
> +
>  #ifndef asm_volatile_goto
>  #define asm_volatile_goto(x...) asm goto(x)
>  #endif
> diff --git a/include/linux/init.h b/include/linux/init.h
> index b3ea15348fbd..045ad1650ed1 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -220,8 +220,8 @@ extern bool initcall_debug;
>  	__initcall_name(initstub, __iid, id)
>  
>  #define __define_initcall_stub(__stub, fn)			\
> -	int __init __stub(void);				\
> -	int __init __stub(void)					\
> +	int __init __cficanonical __stub(void);			\
> +	int __init __cficanonical __stub(void)			\
>  	{ 							\
>  		return fn();					\
>  	}							\
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..39684b72db91 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1944,8 +1944,8 @@ enum pci_fixup_pass {
>  #ifdef CONFIG_LTO_CLANG
>  #define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
>  				  class_shift, hook, stub)		\
> -	void stub(struct pci_dev *dev);					\
> -	void stub(struct pci_dev *dev)					\
> +	void __cficanonical stub(struct pci_dev *dev);			\
> +	void __cficanonical stub(struct pci_dev *dev)			\
>  	{ 								\
>  		hook(dev); 						\
>  	}								\
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 

-- 
Kees Cook
