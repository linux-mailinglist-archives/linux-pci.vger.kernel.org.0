Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0173895B0D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 11:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfHTJeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 05:34:21 -0400
Received: from foss.arm.com ([217.140.110.172]:37328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbfHTJeU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 05:34:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C41A344;
        Tue, 20 Aug 2019 02:34:18 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE45A3F706;
        Tue, 20 Aug 2019 02:34:17 -0700 (PDT)
Date:   Tue, 20 Aug 2019 10:34:16 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Remove surplus return from a void function
Message-ID: <20190820093415.GF23903@e119886-lin.cambridge.arm.com>
References: <20190820065121.16594-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820065121.16594-1-kw@linux.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 08:51:21AM +0200, Krzysztof Wilczynski wrote:
> Remove unnecessary empty return statement at the end of a void
> function in the arch/x86/kernel/quirks.c.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  arch/x86/kernel/quirks.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index 8451f38ad399..1daf8f2aa21f 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
> @@ -90,8 +90,6 @@ static void ich_force_hpet_resume(void)
>  		BUG();
>  	else
>  		printk(KERN_DEBUG "Force enabled HPET at resume\n");
> -
> -	return;
>  }
>  
>  static void ich_force_enable_hpet(struct pci_dev *dev)
> @@ -448,7 +446,6 @@ static void nvidia_force_enable_hpet(struct pci_dev *dev)
>  	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
>  		force_hpet_address);
>  	cached_dev = dev;
> -	return;
>  }
>  
>  /* ISA Bridges */
> @@ -513,7 +510,6 @@ static void e6xx_force_enable_hpet(struct pci_dev *dev)
>  	force_hpet_resume_type = NONE_FORCE_HPET_RESUME;
>  	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
>  		"0x%lx\n", force_hpet_address);
> -	return;
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_E6XX_CU,
>  			 e6xx_force_enable_hpet);
> -- 

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> 2.22.1
> 
