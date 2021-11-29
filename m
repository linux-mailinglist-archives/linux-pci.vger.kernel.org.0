Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A719461C13
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 17:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345463AbhK2QuF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 11:50:05 -0500
Received: from foss.arm.com ([217.140.110.172]:43430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243195AbhK2QsF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 11:48:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADD3D12FC;
        Mon, 29 Nov 2021 08:44:47 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24E4A3F5A1;
        Mon, 29 Nov 2021 08:44:47 -0800 (PST)
Date:   Mon, 29 Nov 2021 16:44:44 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 2/7] PCI: pci-bridge-emul: Add definitions for missing
 capabilities registers
Message-ID: <20211129164444.GC26244@lpieralisi>
References: <20211031181233.9976-1-kabel@kernel.org>
 <20211031181233.9976-3-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211031181233.9976-3-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 31, 2021 at 07:12:28PM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> pci-bridge-emul driver already allocates buffer for capabilities up to the
> PCI_EXP_SLTSTA2 register, but does not define bit access behavior for these
> registers. Add these missing definitions.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: stable@vger.kernel.org

Is this tag in preparation for something else ? I don't even think this
is a fix per-se.

Lorenzo

> ---
>  drivers/pci/pci-bridge-emul.c | 39 +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index a4af1a533d71..aa3320e3c469 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -251,6 +251,45 @@ struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] =
>  		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
>  		.w1c = PCI_EXP_RTSTA_PME,
>  	},
> +
> +	[PCI_EXP_DEVCAP2 / 4] = {
> +		/* Device capabilities 2 register has reserved bits [30:27]. */
> +		.ro = BIT(31) | GENMASK(26, 0),
> +	},
> +
> +	[PCI_EXP_DEVCTL2 / 4] = {
> +		/*
> +		 * Device control 2 register is RW.
> +		 *
> +		 * Device status 2 register is reserved.
> +		 */
> +		.rw = GENMASK(15, 0),
> +	},
> +
> +	[PCI_EXP_LNKCAP2 / 4] = {
> +		/* Link capabilities 2 register has reserved bits [30:25] and 0. */
> +		.ro = BIT(31) | GENMASK(24, 1),
> +	},
> +
> +	[PCI_EXP_LNKCTL2 / 4] = {
> +		/*
> +		 * Link control 2 register is RW.
> +		 *
> +		 * Link status 2 register has bits 5, 15 W1C;
> +		 * bits 10, 11 reserved and others are RO.
> +		 */
> +		.rw = GENMASK(15, 0),
> +		.w1c = (BIT(15) | BIT(5)) << 16,
> +		.ro = (GENMASK(14, 12) | GENMASK(9, 6) | GENMASK(4, 0)) << 16,
> +	},
> +
> +	[PCI_EXP_SLTCAP2 / 4] = {
> +		/* Slot capabilities 2 register is reserved. */
> +	},
> +
> +	[PCI_EXP_SLTCTL2 / 4] = {
> +		/* Both Slot control 2 and Slot status 2 registers are reserved. */
> +	},
>  };
>  
>  /*
> -- 
> 2.32.0
> 
