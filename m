Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD42F24C089
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 16:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHTOY1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgHTOYZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 10:24:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD947C061385
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2020 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=yaOdd8onww5sWiYJKpVRSo31g6ReGrkblmX6jCKde8g=; b=k91rk+1knalAOHP33CAlyGD4CU
        +rCSrGtUDgYRZwm7lGitIyMRbFo/0z51Qqi+LPWcGL15k6FqnpikI2roslYCE8B+DQ+5R7tAVPanm
        II6jfp+8eOAw9tLJqPOsPKt4+ORQZIc3OZ6blYjZlo8QIN/NxZQMNoVsbzbm3cO8QyGb8vBLzYQNC
        kA8O0ezQyGg7UHdUIIVE43KfYy7/Fpzyhd4H5EVqc8En6STUStQ6umYJiUzpYBSt91sYhdD0TIEwc
        HLa9GWTIcaP6hxKf1jzabDyfaDvB1ljUmHOahI9cyO3bcStTd0QgPnBl3vm91TrwN1z/WdI21+mGp
        54Djti7g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8lUL-0001VB-BA; Thu, 20 Aug 2020 14:24:22 +0000
Subject: Re: [PATCH] x86/pci: don't set acpi stuff if !CONFIG_ACPI
To:     Adam Borowski <kilobyte@angband.pl>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-pci@vger.kernel.org
References: <20200820125320.9967-1-kilobyte@angband.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5429dfd4-0cd0-c84b-f34f-5b5548c5d47a@infradead.org>
Date:   Thu, 20 Aug 2020 07:24:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820125320.9967-1-kilobyte@angband.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/20/20 5:53 AM, Adam Borowski wrote:
> Not that x86 without ACPI sees any real use...
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
> Found by randconfig builds.

Note that
#include <asm/acpi.h>
has a stub for acpi_noirq_set() when ACPI is not set/enabled.
That would be better.  And I have submitted that for
arch/x86/pci/xen.c -- and a different patch for intel_mid_pci.c

But I didn't submit them to the X86 maintainers because the
MAINTAINERS file pointed me to the PCI maintainer and to the
XEN PCI maintainer....


> 
>  arch/x86/pci/intel_mid_pci.c | 2 ++
>  arch/x86/pci/xen.c           | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index 00c62115f39c..f14a911f0d06 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -299,8 +299,10 @@ int __init intel_mid_pci_init(void)
>  	pcibios_disable_irq = intel_mid_pci_irq_disable;
>  	pci_root_ops = intel_mid_pci_ops;
>  	pci_soc_mode = 1;
> +#ifdef CONFIG_ACPI
>  	/* Continue with standard init */
>  	acpi_noirq_set();
> +#endif
>  	return 1;
>  }
>  
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 9f9aad42ccff..681eb5c34c03 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -406,8 +406,10 @@ int __init pci_xen_init(void)
>  	pcibios_enable_irq = xen_pcifront_enable_irq;
>  	pcibios_disable_irq = NULL;
>  
> +#ifdef CONFIG_ACPI
>  	/* Keep ACPI out of the picture */
>  	acpi_noirq_set();
> +#endif
>  
>  #ifdef CONFIG_PCI_MSI
>  	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
