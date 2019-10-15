Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69770D72AE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfJOKAb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 06:00:31 -0400
Received: from foss.arm.com ([217.140.110.172]:34200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfJOKAb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 06:00:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C203928;
        Tue, 15 Oct 2019 03:00:30 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE93D3F68E;
        Tue, 15 Oct 2019 03:00:29 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:00:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Fix PCI_EXP_RTCTL register
 configuration
Message-ID: <20191015100027.GB32431@e121166-lin.cambridge.arm.com>
References: <20190614101059.1664-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614101059.1664-1-repk@triplefau.lt>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 12:10:59PM +0200, Remi Pommarel wrote:
> PCI_EXP_RTCTL is used to activate PME interrupt only, so writing into it
> should not modify other interrupts' mask. The ISR mask polarity was also
> inverted, when PCI_EXP_RTCTL_PMEIE is set PCIE_MSG_PM_PME_MASK mask bit
> should actually be cleared.
> 
> Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
> Changes since v1:
>  * Improve code readability
>  * Fix mask polarity
>  * PME_MASK shift was off by one
> Changes since v2:
>  * Modify patch title
>  * Change Fixes tag to commit that actually introduces the bug
> ---
>  drivers/pci/controller/pci-aardvark.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied to pci/aardvark, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 134e0306ff00..f6e55c4597b1 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -415,7 +415,7 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
>  
>  	case PCI_EXP_RTCTL: {
>  		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
> -		*value = (val & PCIE_MSG_PM_PME_MASK) ? PCI_EXP_RTCTL_PMEIE : 0;
> +		*value = (val & PCIE_MSG_PM_PME_MASK) ? 0 : PCI_EXP_RTCTL_PMEIE;
>  		return PCI_BRIDGE_EMUL_HANDLED;
>  	}
>  
> @@ -451,10 +451,15 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>  		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
>  		break;
>  
> -	case PCI_EXP_RTCTL:
> -		new = (new & PCI_EXP_RTCTL_PMEIE) << 3;
> -		advk_writel(pcie, new, PCIE_ISR0_MASK_REG);
> +	case PCI_EXP_RTCTL: {
> +		/* Only mask/unmask PME interrupt */
> +		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG) &
> +			~PCIE_MSG_PM_PME_MASK;
> +		if ((new & PCI_EXP_RTCTL_PMEIE) == 0)
> +			val |= PCIE_MSG_PM_PME_MASK;
> +		advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
>  		break;
> +	}
>  
>  	case PCI_EXP_RTSTA:
>  		new = (new & PCI_EXP_RTSTA_PME) >> 9;
> -- 
> 2.20.1
> 
