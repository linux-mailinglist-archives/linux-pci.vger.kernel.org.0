Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34FED65F8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfJNPN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 11:13:56 -0400
Received: from foss.arm.com ([217.140.110.172]:46638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732397AbfJNPN4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 11:13:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28DFD28;
        Mon, 14 Oct 2019 08:13:55 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4BC83F68E;
        Mon, 14 Oct 2019 08:13:53 -0700 (PDT)
Date:   Mon, 14 Oct 2019 16:13:49 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pankaj Dubey <pankaj.dubey@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, andrew.murray@arm.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        vidyas@nvidia.com, Anvesh Salveru <anvesh.s@samsung.com>
Subject: Re: [PATCH v2] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Message-ID: <20191014151349.GA2928@e121166-lin.cambridge.arm.com>
References: <CGME20191014071838epcas5p2901e45c978e5a9d6dfbdde2dadea6d9d@epcas5p2.samsung.com>
 <1571037509-20284-1-git-send-email-pankaj.dubey@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571037509-20284-1-git-send-email-pankaj.dubey@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 14, 2019 at 12:48:29PM +0530, Pankaj Dubey wrote:
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
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes w.r.t v1:
>  - Rebased on latest linus/master
>  - Added Reviewed-by and Acked-by
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  9 +++++++++
>  2 files changed, 21 insertions(+)

So this is v3 not v2, right ?

Here is v2:

https://patchwork.ozlabs.org/patch/1161958/

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 820488d..e247d6d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -556,4 +556,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		       PCIE_PL_CHK_REG_CHK_REG_START;
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
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
> index 5a18e94..7d3fe6f 100644
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
> +#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
> +#define PORT_LOGIC_GEN3_EQ_DISABLE		BIT(16)
> +
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> @@ -253,6 +261,7 @@ struct dw_pcie {
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
