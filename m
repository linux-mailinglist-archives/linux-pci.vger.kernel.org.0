Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E5AB37DE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 12:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfIPKPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 06:15:47 -0400
Received: from foss.arm.com ([217.140.110.172]:42904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbfIPKPq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 06:15:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54C851000;
        Mon, 16 Sep 2019 03:15:46 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C16263F59C;
        Mon, 16 Sep 2019 03:15:45 -0700 (PDT)
Date:   Mon, 16 Sep 2019 11:15:44 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Pankaj Dubey <pankaj.dubey@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: Re: [PATCH v2] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Message-ID: <20190916101543.GM9720@e119886-lin.cambridge.arm.com>
References: <CGME20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14@epcas5p3.samsung.com>
 <1568371190-14590-1-git-send-email-pankaj.dubey@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568371190-14590-1-git-send-email-pankaj.dubey@samsung.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 13, 2019 at 04:09:50PM +0530, Pankaj Dubey wrote:
> From: Anvesh Salveru <anvesh.s@samsung.com>
> 
> In some platforms, PCIe PHY may have issues which will prevent linkup
> to happen in GEN3 or higher speed. In case equalization fails, link will
> fallback to GEN1.
> 
> DesignWare controller gives flexibility to disable GEN3 equalization
> completely or only phase 2 and 3 of equalization.
> 
> This patch enables the DesignWare driver to disable the PCIe GEN3
> equalization by enabling one of the following quirks:
>  - DWC_EQUALIZATION_DISABLE: To disable GEN3 equalization all phases
>  - DWC_EQ_PHASE_2_3_DISABLE: To disable GEN3 equalization phase 2 & 3
> 
> Platform drivers can set these quirks via "quirk" variable of "dw_pcie"
> struct.
> 
> Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
> Patchset v1 can be found at:
>  - 1/2: https://lkml.org/lkml/2019/9/10/443
>  - 2/2: https://lkml.org/lkml/2019/9/10/444
> 
> Changes w.r.t v1:
>  - Squashed two patches from v1 into one as suggested by Gustavo
>  - Addressed review comments from Andrew
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  9 +++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 7d25102..97fb18d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -466,4 +466,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		break;
>  	}
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +
> +	if (pci->quirk & DWC_EQUALIZATION_DISABLE) {
> +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> +		val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> +	}
> +
> +	if (pci->quirk & DWC_EQ_PHASE_2_3_DISABLE) {
> +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> +		val |= PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> +	}
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ffed084..e428b62 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -29,6 +29,10 @@
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
>  #define LINK_WAIT_IATU			9
>  
> +/* Parameters for GEN3 related quirks */
> +#define DWC_EQUALIZATION_DISABLE	BIT(1)
> +#define DWC_EQ_PHASE_2_3_DISABLE	BIT(2)
> +
>  /* Synopsys-specific PCIe configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710
>  #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
> @@ -60,6 +64,10 @@
>  #define PCIE_MSI_INTR0_MASK		0x82C
>  #define PCIE_MSI_INTR0_STATUS		0x830
>  
> +#define PCIE_PORT_GEN3_RELATED		0x890

I hadn't noticed this in the previous version - what is the proper
name for this register? Does it end in _RELATED?

Thanks,

Andrew Murray

> +#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
> +#define PORT_LOGIC_GEN3_EQ_DISABLE		BIT(16)
> +
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> @@ -244,6 +252,7 @@ struct dw_pcie {
>  	struct dw_pcie_ep	ep;
>  	const struct dw_pcie_ops *ops;
>  	unsigned int		version;
> +	unsigned int		quirk;
>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> -- 
> 2.7.4
> 
