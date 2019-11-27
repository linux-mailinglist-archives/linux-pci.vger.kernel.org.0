Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FC310A805
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 02:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfK0BgR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 20:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:32978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfK0BgQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 20:36:16 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C5F2075C;
        Wed, 27 Nov 2019 01:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574818576;
        bh=PtrJiqBjDc3rtnxMlcXBxBsaFk0bKWUIMRupAqH/g2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sjrOU+jOy+/woZ6WbwBIpQAhvP51U5A9H0p72S/lP6s0CO3b1sqdLycRXDKdqwfV8
         /3ZwN2QAp7qYtYFawpAHcW3SwqG5efV4J500UqQzNK4vPlygxXO1iYhFYc3xUt6uge
         ERymIeZwWyCj5SoCOHH4JA6YWc6uTMS+doTgJaQs=
Date:   Tue, 26 Nov 2019 19:36:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v4 1/3] PCI: pciehp: Add support for disabling in-band
 presence
Message-ID: <20191127013613.GA233706@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025190047.38130-2-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 25, 2019 at 03:00:45PM -0400, Stuart Hayes wrote:
> From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> The presence detect state (PDS) is normally a logical or of in-band and
> out-of-band presence. As of PCIe 4.0, there is the option to disable
> in-band presence so that the PDS bit always reflects the state of the
> out-of-band presence.
> 
> The recommendation of the PCIe spec is to disable in-band presence
> whenever supported.

I think I'm fine with this patch, but I would like to include the
specific reference for this recommendation.  If you have it handy, I
can just insert it.

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp.h     | 1 +
>  drivers/pci/hotplug/pciehp_hpc.c | 9 ++++++++-
>  include/uapi/linux/pci_regs.h    | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 654c972b8ea0..27e4cd6529b0 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -83,6 +83,7 @@ struct controller {
>  	struct pcie_device *pcie;
>  
>  	u32 slot_cap;				/* capabilities and quirks */
> +	unsigned int inband_presence_disabled:1;
>  
>  	u16 slot_ctrl;				/* control register access */
>  	struct mutex ctrl_lock;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 1a522c1c4177..dc109d521f30 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -811,7 +811,7 @@ static inline void dbg_ctrl(struct controller *ctrl)
>  struct controller *pcie_init(struct pcie_device *dev)
>  {
>  	struct controller *ctrl;
> -	u32 slot_cap, link_cap;
> +	u32 slot_cap, slot_cap2, link_cap;
>  	u8 poweron;
>  	struct pci_dev *pdev = dev->port;
>  	struct pci_bus *subordinate = pdev->subordinate;
> @@ -869,6 +869,13 @@ struct controller *pcie_init(struct pcie_device *dev)
>  		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
>  		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
>  
> +	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP2, &slot_cap2);
> +	if (slot_cap2 & PCI_EXP_SLTCAP2_IBPD) {
> +		pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_IBPD_DISABLE,
> +				      PCI_EXP_SLTCTL_IBPD_DISABLE);
> +		ctrl->inband_presence_disabled = 1;
> +	}
> +
>  	/*
>  	 * If empty slot's power status is on, turn power off.  The IRQ isn't
>  	 * requested yet, so avoid triggering a notification with this command.
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 29d6e93fd15e..ea1cf9546e4d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -604,6 +604,7 @@
>  #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
>  #define  PCI_EXP_SLTCTL_EIC	0x0800	/* Electromechanical Interlock Control */
>  #define  PCI_EXP_SLTCTL_DLLSCE	0x1000	/* Data Link Layer State Changed Enable */
> +#define  PCI_EXP_SLTCTL_IBPD_DISABLE	0x4000 /* In-band PD disable */
>  #define PCI_EXP_SLTSTA		26	/* Slot Status */
>  #define  PCI_EXP_SLTSTA_ABP	0x0001	/* Attention Button Pressed */
>  #define  PCI_EXP_SLTSTA_PFD	0x0002	/* Power Fault Detected */
> @@ -676,6 +677,7 @@
>  #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
>  #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
>  #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
> +#define  PCI_EXP_SLTCAP2_IBPD	0x0001	/* In-band PD Disable Supported */
>  #define PCI_EXP_SLTCTL2		56	/* Slot Control 2 */
>  #define PCI_EXP_SLTSTA2		58	/* Slot Status 2 */
>  
> -- 
> 2.18.1
> 
