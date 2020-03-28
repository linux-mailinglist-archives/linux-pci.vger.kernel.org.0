Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A0119698E
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 22:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC1Vny (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 17:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1Vny (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 17:43:54 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF6AA20714;
        Sat, 28 Mar 2020 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585431833;
        bh=QaY36iHTP79UXqax0r/o+p3Tdr+Do9OjGBasmRH9CJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LOC7m60ErlmVKIHpqS6IGVg09QIRI+KWlV23XfdE/LDM/AVIzeMQQEtkewcu0w8+K
         9LbrEFqgaK9RJHLEAoVlr/EpRSf4KY5Rjxnij0DxcLrSlubxckNVqB0QJZr6TXuO1v
         Lji//GS8YpneAyl9c7FkuaEVu7wHHSbnrQSF9QBw=
Date:   Sat, 28 Mar 2020 16:43:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC 2/9] PCI: pci-bridge-emul: Eliminate reserved member
Message-ID: <20200328214351.GA129854@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581120007-5280-3-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas, Russell]

On Fri, Feb 07, 2020 at 05:00:00PM -0700, Jon Derrick wrote:
> Assume any bit not in the Read-Only, Read-Write, or Write-1-to-Clear
> behavior masks is a Reserved bit and should return 0 on reads.

This also seems like it makes sense on its own, especially if you can
include a spec citation.

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci-bridge-emul.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index d065c2a..e0567ca 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -24,6 +24,15 @@
>  #define PCI_CAP_PCIE_START	PCI_BRIDGE_CONF_END
>  #define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_EXP_SLTSTA2 + 2)
>  
> +/**
> + * struct pci_bridge_reg_behavior - register bits behaviors
> + * @ro:		Read-Only bits
> + * @rw:		Read-Write bits
> + * @w1c:	Write-1-to-Clear bits
> + *
> + * Reads and Writes will be filtered by specified behavior. All other bits not
> + * declared are assumed 'Reserved' and will return 0 on reads.
> + */
>  struct pci_bridge_reg_behavior {
>  	/* Read-only bits */
>  	u32 ro;
> @@ -33,9 +42,6 @@ struct pci_bridge_reg_behavior {
>  
>  	/* Write-1-to-clear bits */
>  	u32 w1c;
> -
> -	/* Reserved bits (hardwired to 0) */
> -	u32 rsvd;
>  };
>  
>  static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
> @@ -49,7 +55,6 @@ struct pci_bridge_reg_behavior {
>  			PCI_COMMAND_FAST_BACK) |
>  		       (PCI_STATUS_CAP_LIST | PCI_STATUS_66MHZ |
>  			PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MASK) << 16),
> -		.rsvd = GENMASK(15, 10) | ((BIT(6) | GENMASK(3, 0)) << 16),
>  		.w1c = (PCI_STATUS_PARITY |
>  			PCI_STATUS_SIG_TARGET_ABORT |
>  			PCI_STATUS_REC_TARGET_ABORT |
> @@ -106,8 +111,6 @@ struct pci_bridge_reg_behavior {
>  			PCI_STATUS_REC_MASTER_ABORT |
>  			PCI_STATUS_SIG_SYSTEM_ERROR |
>  			PCI_STATUS_DETECTED_PARITY) << 16,
> -
> -		.rsvd = ((BIT(6) | GENMASK(4, 0)) << 16),
>  	},
>  
>  	[PCI_MEMORY_BASE / 4] = {
> @@ -140,12 +143,10 @@ struct pci_bridge_reg_behavior {
>  
>  	[PCI_CAPABILITY_LIST / 4] = {
>  		.ro = GENMASK(7, 0),
> -		.rsvd = GENMASK(31, 8),
>  	},
>  
>  	[PCI_ROM_ADDRESS1 / 4] = {
>  		.rw = GENMASK(31, 11) | BIT(0),
> -		.rsvd = GENMASK(10, 1),
>  	},
>  
>  	/*
> @@ -168,8 +169,6 @@ struct pci_bridge_reg_behavior {
>  		.ro = (GENMASK(15, 8) | ((PCI_BRIDGE_CTL_FAST_BACK) << 16)),
>  
>  		.w1c = BIT(10) << 16,
> -
> -		.rsvd = (GENMASK(15, 12) | BIT(4)) << 16,
>  	},
>  };
>  
> @@ -196,13 +195,11 @@ struct pci_bridge_reg_behavior {
>  		 */
>  		.w1c = (BIT(6) | GENMASK(3, 0)) << 16,
>  		.ro = GENMASK(5, 4) << 16,
> -		.rsvd = GENMASK(15, 7) << 16,
>  	},
>  
>  	[PCI_EXP_LNKCAP / 4] = {
>  		/* All bits are RO, except bit 23 which is reserved */
>  		.ro = lower_32_bits(~BIT(23)),
> -		.rsvd = BIT(23),
>  	},
>  
>  	[PCI_EXP_LNKCTL / 4] = {
> @@ -216,7 +213,6 @@ struct pci_bridge_reg_behavior {
>  		.rw = GENMASK(15, 14) | GENMASK(11, 3) | GENMASK(1, 0),
>  		.ro = GENMASK(13, 0) << 16,
>  		.w1c = GENMASK(15, 14) << 16,
> -		.rsvd = GENMASK(13, 12) | BIT(2),
>  	},
>  
>  	[PCI_EXP_SLTCAP / 4] = {
> @@ -234,7 +230,6 @@ struct pci_bridge_reg_behavior {
>  		.rw = GENMASK(14, 0),
>  		.w1c = (BIT(8) | GENMASK(4, 0)) << 16,
>  		.ro = GENMASK(7, 5) << 16,
> -		.rsvd = BIT(15) | (GENMASK(15, 9) << 16),
>  	},
>  
>  	[PCI_EXP_RTCTL / 4] = {
> @@ -246,7 +241,6 @@ struct pci_bridge_reg_behavior {
>  		 */
>  		.rw = GENMASK(4, 0),
>  		.ro = BIT(0) << 16,
> -		.rsvd = GENMASK(15, 5) | (GENMASK(15, 1) << 16),
>  	},
>  
>  	[PCI_EXP_RTSTA / 4] = {
> @@ -256,7 +250,6 @@ struct pci_bridge_reg_behavior {
>  		 */
>  		.ro = BIT(17) | GENMASK(15, 0),
>  		.w1c = BIT(16),
> -		.rsvd = GENMASK(31, 18),
>  	},
>  };
>  
> @@ -364,7 +357,8 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
>  	 * Make sure we never return any reserved bit with a value
>  	 * different from 0.
>  	 */
> -	*value &= ~behavior[reg / 4].rsvd;
> +	*value &= behavior[reg / 4].ro | behavior[reg / 4].rw |
> +		  behavior[reg / 4].w1c;
>  
>  	if (size == 1)
>  		*value = (*value >> (8 * (where & 3))) & 0xff;
> -- 
> 1.8.3.1
> 
