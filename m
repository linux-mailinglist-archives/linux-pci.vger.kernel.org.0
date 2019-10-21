Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7EADEEB1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfJUOEp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 10:04:45 -0400
Received: from [217.140.110.172] ([217.140.110.172]:53572 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfJUOEp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 10:04:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 677711007;
        Mon, 21 Oct 2019 07:04:27 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D46CA3F71F;
        Mon, 21 Oct 2019 07:04:26 -0700 (PDT)
Date:   Mon, 21 Oct 2019 15:04:25 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Anvesh Salveru <anvesh.s@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, lorenzo.pieralisi@arm.com,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH 2/2] PCI: dwc: Add support to handle ZRX-DC Compliant PHYs
Message-ID: <20191021140424.GR47056@e119886-lin.cambridge.arm.com>
References: <CGME20191021123016epcas5p3ab7100162a8d6d803b117976240f20b4@epcas5p3.samsung.com>
 <1571660993-30329-1-git-send-email-anvesh.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571660993-30329-1-git-send-email-anvesh.s@samsung.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 05:59:53PM +0530, Anvesh Salveru wrote:
> Many platforms use DesignWare controller but the PHY can be different in
> different platforms. If the PHY is compliant is to ZRX-DC specification

s/is to/to the/

> it helps in low power consumption during power states.

s/in low/lower/

> 
> If current data rate is 8.0 GT/s or higher and PHY is not compliant to
> ZRX-DC specification, then after every 100ms link should transition to
> recovery state during the low power states.
> 
> DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
> GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.
> 
> Platforms with ZRX-DC compliant PHY can set "snps,phy-zrxdc-compliant"
> property in controller DT node to specify this property to the controller.
> 
> Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
>  drivers/pci/controller/dwc/pcie-designware.h | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 820488dfeaed..6560d9f765d7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -556,4 +556,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		       PCIE_PL_CHK_REG_CHK_REG_START;
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
> +
> +	if (of_property_read_bool(np, "snps,phy-zrxdc-compliant")) {
> +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> +		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> +	}
> +

Given that this duplicates tegra_pcie_prepare_host in pcie-tegra194.c, can
we update that driver to adopt this new binding?

Thanks,

Andrew Murray

>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 5a18e94e52c8..427a55ec43c6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -60,6 +60,9 @@
>  #define PCIE_MSI_INTR0_MASK		0x82C
>  #define PCIE_MSI_INTR0_STATUS		0x830
>  
> +#define PCIE_PORT_GEN3_RELATED		0x890
> +#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL		BIT(0)
> +
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> -- 
> 2.17.1
> 
