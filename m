Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5CF3D19C4
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 00:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhGUVwa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 17:52:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:31984 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhGUVwa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 17:52:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="191802657"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="191802657"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 15:33:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="454537679"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 15:33:05 -0700
Date:   Wed, 21 Jul 2021 15:32:38 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 3/8] PCI/MSI: Enforce that MSI-X table entry is masked
 for update
Message-ID: <20210721223238.GD676232@otc-nc-03>
References: <20210721191126.274946280@linutronix.de>
 <20210721192650.408910288@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721192650.408910288@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 09:11:29PM +0200, Thomas Gleixner wrote:
> The specification states:
> 
>     For MSI-X, a function is permitted to cache Address and Data values
>     from unmasked MSI-X Table entries. However, anytime software unmasks a
>     currently masked MSI-X Table entry either by clearing its Mask bit or
>     by clearing the Function Mask bit, the function must update any Address
>     or Data values that it cached from that entry. If software changes the
>     Address or Data value of an entry while the entry is unmasked, the
>     result is undefined.
> 
> The Linux kernel's MSI-X support never enforced that the entry is masked
> before the entry is modified hence the Fixes tag refers to a commit in:
>       git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> 
> Enforce the entry to be masked across the update.
> 
> There is no point in enforcing this to be handled at all possible call
> sites as this is just pointless code duplication and the common update
> function is the obvious place to enforce this.
> 
> Reported-by: Kevin Tian <kevin.tian@intel.com>
> Fixes: f036d4ea5fa7 ("[PATCH] ia32 Message Signalled Interrupt support")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/msi.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -289,13 +289,28 @@ void __pci_write_msi_msg(struct msi_desc
>  		/* Don't touch the hardware now */
>  	} else if (entry->msi_attrib.is_msix) {
>  		void __iomem *base = pci_msix_desc_addr(entry);
> +		bool unmasked = !(entry->masked & PCI_MSIX_ENTRY_CTRL_MASKBIT);
>  
>  		if (!base)
>  			goto skip;
>  
> +		/*
> +		 * The specification mandates that the entry is masked
> +		 * when the message is modified:
> +		 *
> +		 * "If software changes the Address or Data value of an
> +		 * entry while the entry is unmasked, the result is
> +		 * undefined."
> +		 */
> +		if (unmasked)
> +			__pci_msix_desc_mask_irq(entry, PCI_MSIX_ENTRY_CTRL_MASKBIT);
> +

Is there any locking needs here? say during cpu hotplug and some user-space
setting affinity?

>  		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
>  		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
>  		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
> +
> +		if (unmasked)
> +			__pci_msix_desc_mask_irq(entry, 0);
>  	} else {
>  		int pos = dev->msi_cap;
>  		u16 msgctl;
> 
