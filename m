Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09DA19698C
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 22:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgC1VmV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 17:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1VmV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 17:42:21 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5AF620714;
        Sat, 28 Mar 2020 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585431740;
        bh=EcJTZ6IbK6O9AEakoQvwIc0bXoD/c3hrHluspJ7kC4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aXTr8b4zxmZeoX6DhUXd98NZOKrTtupbvq/mPPi2XMbhRNJMRpNKka8xuhxY6NYhK
         4Vcdep6IQFHkzucZu36WrDHy81Wt/shk+BKCjYCTbeCAHf+usLCZY5ej3VEW5B5oqB
         oTjTgB4oO9IusnjNCRPO0IJFgdwrjdVhMkocQL5E=
Date:   Sat, 28 Mar 2020 16:42:18 -0500
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
Subject: Re: [RFC 1/9] PCI: pci-bridge-emul: Update PCIe register behaviors
Message-ID: <20200328214218.GA129350@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581120007-5280-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas, Russell]

On Fri, Feb 07, 2020 at 04:59:59PM -0700, Jon Derrick wrote:
> Update the PCIe register behaviors and comments for PCIe v5.0.
> Replace the specific bit definitions with BIT and GENMASK to make
> updating easier in the future.

I think this patch makes sense on its own, independent of the rest of
the series.  I *would* like to see it split into (a) a "no changes"
patch that converts to BIT/GENMASK, and (b) another patch that
contains only the PCIe r5.0 updates.

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci-bridge-emul.c | 54 +++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index fffa770..d065c2a 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -191,12 +191,12 @@ struct pci_bridge_reg_behavior {
>  		.rw = GENMASK(15, 0),
>  
>  		/*
> -		 * Device status register has 4 bits W1C, then 2 bits
> -		 * RO, the rest is reserved
> +		 * Device status register has bits 6 and [3:0] W1C, [5:4] RO,
> +		 * the rest is reserved
>  		 */
> -		.w1c = GENMASK(19, 16),
> -		.ro = GENMASK(20, 19),
> -		.rsvd = GENMASK(31, 21),
> +		.w1c = (BIT(6) | GENMASK(3, 0)) << 16,
> +		.ro = GENMASK(5, 4) << 16,
> +		.rsvd = GENMASK(15, 7) << 16,
>  	},
>  
>  	[PCI_EXP_LNKCAP / 4] = {
> @@ -207,15 +207,16 @@ struct pci_bridge_reg_behavior {
>  
>  	[PCI_EXP_LNKCTL / 4] = {
>  		/*
> -		 * Link control has bits [1:0] and [11:3] RW, the
> -		 * other bits are reserved.
> -		 * Link status has bits [13:0] RO, and bits [14:15]
> +		 * Link control has bits [15:14], [11:3] and [1:0] RW, the
> +		 * rest is reserved.
> +		 *
> +		 * Link status has bits [13:0] RO, and bits [15:14]
>  		 * W1C.
>  		 */
> -		.rw = GENMASK(11, 3) | GENMASK(1, 0),
> +		.rw = GENMASK(15, 14) | GENMASK(11, 3) | GENMASK(1, 0),
>  		.ro = GENMASK(13, 0) << 16,
>  		.w1c = GENMASK(15, 14) << 16,
> -		.rsvd = GENMASK(15, 12) | BIT(2),
> +		.rsvd = GENMASK(13, 12) | BIT(2),
>  	},
>  
>  	[PCI_EXP_SLTCAP / 4] = {
> @@ -224,19 +225,16 @@ struct pci_bridge_reg_behavior {
>  
>  	[PCI_EXP_SLTCTL / 4] = {
>  		/*
> -		 * Slot control has bits [12:0] RW, the rest is
> +		 * Slot control has bits [14:0] RW, the rest is
>  		 * reserved.
>  		 *
> -		 * Slot status has a mix of W1C and RO bits, as well
> -		 * as reserved bits.
> +		 * Slot status has bits 8 and [4:0] W1C, bits [7:5] RO, the
> +		 * rest is reserved.
>  		 */
> -		.rw = GENMASK(12, 0),
> -		.w1c = (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> -			PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
> -			PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC) << 16,
> -		.ro = (PCI_EXP_SLTSTA_MRLSS | PCI_EXP_SLTSTA_PDS |
> -		       PCI_EXP_SLTSTA_EIS) << 16,
> -		.rsvd = GENMASK(15, 12) | (GENMASK(15, 9) << 16),
> +		.rw = GENMASK(14, 0),
> +		.w1c = (BIT(8) | GENMASK(4, 0)) << 16,
> +		.ro = GENMASK(7, 5) << 16,
> +		.rsvd = BIT(15) | (GENMASK(15, 9) << 16),
>  	},
>  
>  	[PCI_EXP_RTCTL / 4] = {
> @@ -244,18 +242,20 @@ struct pci_bridge_reg_behavior {
>  		 * Root control has bits [4:0] RW, the rest is
>  		 * reserved.
>  		 *
> -		 * Root status has bit 0 RO, the rest is reserved.
> +		 * Root capabilities has bit 0 RO, the rest is reserved.
>  		 */
> -		.rw = (PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
> -		       PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
> -		       PCI_EXP_RTCTL_CRSSVE),
> -		.ro = PCI_EXP_RTCAP_CRSVIS << 16,
> +		.rw = GENMASK(4, 0),
> +		.ro = BIT(0) << 16,
>  		.rsvd = GENMASK(15, 5) | (GENMASK(15, 1) << 16),
>  	},
>  
>  	[PCI_EXP_RTSTA / 4] = {
> -		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
> -		.w1c = PCI_EXP_RTSTA_PME,
> +		/*
> +		 * Root status has bits 17 and [15:0] RO, bit 16 W1C, the rest
> +		 * is reserved.
> +		 */
> +		.ro = BIT(17) | GENMASK(15, 0),
> +		.w1c = BIT(16),
>  		.rsvd = GENMASK(31, 18),
>  	},
>  };
> -- 
> 1.8.3.1
> 
