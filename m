Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906A928E9F2
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 03:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbgJOBY4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 21:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732065AbgJOBYj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 21:24:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC61C051118
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 15:58:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c6so486178plr.9
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WUVth3Yi/0Gf6s7eybXLKtt4uMjJ4xi70yGGSwDkLw0=;
        b=R63EBTH6+0dTkzS267+O24BYdxnurWecDwGpDuhGH5wyKY0Pg8ynHUH/iEecP4Gnho
         RfNGPWH3YDit4Wmb0luYZWOyRplddz6hFIgmHH4CLhIZt4IyCFh8a/BvWIZDZQnBcGoK
         FZBeYg7LPlk+kUu4N8sYcxncY/8J8OqwbusLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WUVth3Yi/0Gf6s7eybXLKtt4uMjJ4xi70yGGSwDkLw0=;
        b=Sw2YithJ5bMtdwWjsuQI2UEFRp0Ncdc2dyPWXvy6tU77uNrWY51Qxd55toP5RpsKva
         JLQ6P0VXeDpWLGRH+5/Sd/Z/h6cxRQb64xyVj/FQrXaGleg3Qyp69dX7H/k/xrT88Qbh
         xrue777azMepJ+2ahXzmyfO+9QM5/yvZDHHgulIATTWw2gTgkTF8z1DjbwUYgAc2l8wF
         ZIVB0/w6yBJNCZYXirnFJAlr6BOiTZFMFFr4+jmUpIHZo6SaDqAtOg6jW669Nh/09WWB
         49sbO/+yAAhvKi5rjATLAb+5o/uzr8yMt5ow5+hdNKRbgucpjJfQ5ND6/Cu48R9rcoCT
         Qd1A==
X-Gm-Message-State: AOAM530zK971AvUUb3JV4UK16WLqbJumV5vIZf54MTNfIYfz1fPympgL
        RcLZocURwwiRQVfIhTNCqQhznA==
X-Google-Smtp-Source: ABdhPJzHdqdE46WrFZlw8R7S7F1x+3bND/WLRTw47I4euXQao8J+1ZC4KoSJiwuZcz/FXnt7OEBn6A==
X-Received: by 2002:a17:902:59da:b029:d4:c71a:357a with SMTP id d26-20020a17090259dab02900d4c71a357amr1496188plj.38.1602716293981;
        Wed, 14 Oct 2020 15:58:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g14sm715510pfo.17.2020.10.14.15.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 15:58:13 -0700 (PDT)
Date:   Wed, 14 Oct 2020 15:58:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v6 17/25] PCI: Fix PREL32 relocations for LTO
Message-ID: <202010141556.DC58D913@keescook>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-18-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013003203.4168817-18-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12, 2020 at 05:31:55PM -0700, Sami Tolvanen wrote:
> With Clang's Link Time Optimization (LTO), the compiler can rename
> static functions to avoid global naming collisions. As PCI fixup
> functions are typically static, renaming can break references
> to them in inline assembly. This change adds a global stub to
> DECLARE_PCI_FIXUP_SECTION to fix the issue when PREL32 relocations
> are used.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Another independent patch! :) Bjorn, since you've already Acked this
patch, would be be willing to pick it up for your tree?

-Kees

> ---
>  include/linux/pci.h | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 835530605c0d..4e64421981c7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1909,19 +1909,28 @@ enum pci_fixup_pass {
>  };
>  
>  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> -#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> -				    class_shift, hook)			\
> -	__ADDRESSABLE(hook)						\
> +#define ___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> +				    class_shift, hook, stub)		\
> +	void stub(struct pci_dev *dev);					\
> +	void stub(struct pci_dev *dev)					\
> +	{ 								\
> +		hook(dev); 						\
> +	}								\
>  	asm(".section "	#sec ", \"a\"				\n"	\
>  	    ".balign	16					\n"	\
>  	    ".short "	#vendor ", " #device "			\n"	\
>  	    ".long "	#class ", " #class_shift "		\n"	\
> -	    ".long "	#hook " - .				\n"	\
> +	    ".long "	#stub " - .				\n"	\
>  	    ".previous						\n");
> +
> +#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> +				  class_shift, hook, stub)		\
> +	___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> +				  class_shift, hook, stub)
>  #define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
>  				  class_shift, hook)			\
>  	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> -				  class_shift, hook)
> +				  class_shift, hook, __UNIQUE_ID(hook))
>  #else
>  /* Anonymous variables would be nice... */
>  #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
> -- 
> 2.28.0.1011.ga647a8990f-goog
> 

-- 
Kees Cook
