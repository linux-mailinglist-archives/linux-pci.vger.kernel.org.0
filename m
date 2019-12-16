Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20E01202ED
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 11:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLPKsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 05:48:23 -0500
Received: from foss.arm.com ([217.140.110.172]:49598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfLPKsX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 05:48:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1DBE1FB;
        Mon, 16 Dec 2019 02:48:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57EF93F6CF;
        Mon, 16 Dec 2019 02:48:22 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:48:20 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Anvesh Salveru <anvesh.s@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kishon@ti.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        pankaj.dubey@samsung.com, mark.rutland@arm.com, robh+dt@kernel.org
Subject: Re: [PATCH v6 2/2] PCI: dwc: add support to handle ZRX-DC Compliant
 PHYs
Message-ID: <20191216104820.GQ24359@e119886-lin.cambridge.arm.com>
References: <1576242800-23969-1-git-send-email-anvesh.s@samsung.com>
 <CGME20191213131350epcas5p3c90ec8981639f488b65d8e09b098fa2b@epcas5p3.samsung.com>
 <1576242800-23969-3-git-send-email-anvesh.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576242800-23969-3-git-send-email-anvesh.s@samsung.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 06:43:20PM +0530, Anvesh Salveru wrote:
> Many platforms use DesignWare controller but the PHY can be different in
> different platforms. If the PHY is compliant is to ZRX-DC specification
> it helps in low power consumption during power states.
> 
> If current data rate is 8.0 GT/s or higher and PHY is not compliant to
> ZRX-DC specification, then after every 100ms link should transition to
> recovery state during the low power states.
> 
> DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
> GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.
> 
> Platforms with ZRX-DC compliant PHY can set phy_zrxdc_compliant variable
> to specify this property to the controller.
> 
> Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
> Changes w.r.t v5:
>  - None
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 6 ++++++
>  drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 820488d..36a01b7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -556,4 +556,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		       PCIE_PL_CHK_REG_CHK_REG_START;
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
> +
> +	if (pci->phy_zrxdc_compliant) {

This series doesn't update any DWC drivers to actually test and set the
phy_zrxdc_compliant flag. There isn't good justification for merging this
unless it has a user.

Thanks,

Andrew Murray

> +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> +		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> +	}
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 5accdd6..36f7579 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -60,6 +60,9 @@
>  #define PCIE_MSI_INTR0_MASK		0x82C
>  #define PCIE_MSI_INTR0_STATUS		0x830
>  
> +#define PCIE_PORT_GEN3_RELATED		0x890
> +#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL	BIT(0)
> +
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> @@ -249,6 +252,7 @@ struct dw_pcie {
>  	void __iomem		*atu_base;
>  	u32			num_viewport;
>  	u8			iatu_unroll_enabled;
> +	bool			phy_zrxdc_compliant;
>  	struct pcie_port	pp;
>  	struct dw_pcie_ep	ep;
>  	const struct dw_pcie_ops *ops;
> -- 
> 2.7.4
> 
