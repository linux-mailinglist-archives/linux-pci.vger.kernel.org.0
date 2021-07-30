Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB253DC022
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 23:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhG3VT1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 17:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230310AbhG3VT0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 17:19:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B4BB60F3A;
        Fri, 30 Jul 2021 21:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627679961;
        bh=Op3nvalDjgMdvEstOymF2Gr1xf2QP7olCV3VbUQFwFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YesZ7C4g914eD6AYzERy3CbRmWCtBCKNpD4hj6u6wyoAUXMI9zaH6EAYYTlAGBNub
         tDSYqfibs6bppbTMEGANwN2kdw7ZXb1/jf9UVBARnaraRK1fpvg7NSAfi9APz0D5xD
         NPTzudaV7bS8AADscFGo5LIx4xUGcJ/WpBgPapMEbrdVh/O3889wVNWgCBgNVCXatj
         Rw1e+bWsQ72VFMEQMIwxtHq7QSSpab+tCXJBSkyELslZETPoSu3IM71fjpDgGGaMmk
         5HeJEmx4056vJPv/R7sJtM1ILziKjWwabtPnApxGY+BjU2Ia92dOrFMgIKx7nklh6L
         F5yqE4uj91onA==
Date:   Fri, 30 Jul 2021 16:19:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/pci: Add missing forward declaration for
 pci_numachip_init()
Message-ID: <20210730211920.GA1099849@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729234059.1509820-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 11:40:59PM +0000, Krzysztof Wilczyński wrote:
> At the moment, the function pci_numachip_init() is defined in the
> numachip.c file.  Since this function has users outside of this file,
> add missing foward declaration to the pci_x86.h file.
> 
> This resolves the following sparse and compile time warning:
> 
>   arch/x86/pci/numachip.c:108:12: warning: no previous prototype for function 'pci_numachip_init' [-Wmissing-prototypes]
>   arch/x86/pci/numachip.c:108:12: warning: symbol 'pci_numachip_init' was not declared. Should it be static?

Thanks for worrying about warnings like this.  They're small but
important.

What should be done with the pci_numachip_init() declaration in
arch/x86/include/asm/numachip/numachip.h?  It doesn't seem like we
should have *two* declarations.

The one in arch/x86/include/asm/numachip/numachip.h is:

  extern int __init pci_numachip_init(void);

I'm not enough of a C language lawyer to know whether "__init" in a
declaration is useful.  It doesn't *seem* like it would be useful
since this is not a definition and the compiler isn't generating code
here.  But "git grep __init include/ arch/*/include" finds quite a few
of them.

> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  arch/x86/include/asm/pci_x86.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 490411dba438..906f40cae3fc 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -50,6 +50,10 @@ enum pci_bf_sort_state {
>  	pci_dmi_bf,
>  };
>  
> +/* numachip.c */
> +
> +int pci_numachip_init(void);
> +
>  /* pci-i386.c */
>  
>  void pcibios_resource_survey(void);
> -- 
> 2.32.0
> 
