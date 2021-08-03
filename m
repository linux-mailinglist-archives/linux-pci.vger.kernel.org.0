Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4F3DF721
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhHCV4e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 17:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhHCV4e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 17:56:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CC8860724;
        Tue,  3 Aug 2021 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628027782;
        bh=CtaBctNlap/TA51MNQzdE8Z4XTDacO9V6XB4566z4OY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n9acgLJETvuySpQhKuaTGNHHDO022gVq6tFNDIgn/na1HiYPq6L21pOnReGAmMSVO
         vQhtRlvDOQA1DLxbDVpZRApimRHDcVhTp95NaW/42nxBoQLucTiVkejeKNP/X6Cswv
         uwsuneTKzo/LrnNWGjOhQ3qILvhJEXuCrB8pabi5wvaWSDqNMF/KnDAVSNWWtgZB5z
         aXfBQUoP6+rjXWSOwbxoT9cwRQyccd00dkTTYqarsJtlY1GMY/HnXwiID+C8+CBarV
         GlnW9EHhn9cU6CsADyyLVgfO41M8fn8e65MMllL/BFDu+aQmXezq07OaDNaYb7d5hm
         jhRNju0zNN3uA==
Date:   Tue, 3 Aug 2021 16:56:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] PCI: Always initialize dev in pciconfig_read
Message-ID: <20210803215621.GA1576408@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803200836.500658-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 03, 2021 at 01:08:36PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/pci/syscall.c:25:6: warning: variable 'dev' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>         if (!capable(CAP_SYS_ADMIN))
>             ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/pci/syscall.c:81:14: note: uninitialized use occurs here
>         pci_dev_put(dev);
>                     ^~~
> drivers/pci/syscall.c:25:2: note: remove the 'if' if its condition is
> always false
>         if (!capable(CAP_SYS_ADMIN))
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/pci/syscall.c:18:21: note: initialize the variable 'dev' to
> silence this warning
>         struct pci_dev *dev;
>                            ^
>                             = NULL
> 1 warning generated.
> 
> pci_dev_put accounts for a NULL pointer so initialize dev to NULL before
> the capability check so that there is no use of uninitialized memory.
> 
> Fixes: 61a6199787d9 ("PCI: Return ~0 data on pciconfig_read() CAP_SYS_ADMIN failure")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Squashed in locally, thanks!

> ---
>  drivers/pci/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
> index 525f16caed1d..61a6fe3cde21 100644
> --- a/drivers/pci/syscall.c
> +++ b/drivers/pci/syscall.c
> @@ -22,6 +22,7 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
>  	int err, cfg_ret;
>  
>  	err = -EPERM;
> +	dev = NULL;
>  	if (!capable(CAP_SYS_ADMIN))
>  		goto error;
>  
> 
> base-commit: 21d8e94253eb09f7c94c4db00dc714efc75b8701
> -- 
> 2.33.0.rc0
> 
