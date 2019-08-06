Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D311836B4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbfHFQ2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 12:28:15 -0400
Received: from foss.arm.com ([217.140.110.172]:36370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbfHFQ2P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 12:28:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C489344;
        Tue,  6 Aug 2019 09:28:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A1443F575;
        Tue,  6 Aug 2019 09:28:13 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:28:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Fix PCI_EXP_RTCTL register
 configuration
Message-ID: <20190806162811.GB15498@e121166-lin.cambridge.arm.com>
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

Thomas, are you OK with this patch ?

Thanks,
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
