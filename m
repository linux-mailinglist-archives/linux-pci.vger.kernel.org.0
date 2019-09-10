Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF27AEC88
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2019 15:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfIJN6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Sep 2019 09:58:17 -0400
Received: from foss.arm.com ([217.140.110.172]:35820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfIJN6R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Sep 2019 09:58:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C15B28;
        Tue, 10 Sep 2019 06:58:16 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7B3E3F59C;
        Tue, 10 Sep 2019 06:58:15 -0700 (PDT)
Date:   Tue, 10 Sep 2019 14:58:13 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Pankaj Dubey <pankaj.dubey@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: Re: [PATCH 1/2] PCI: dwc: Add support to disable GEN3 equalization
Message-ID: <20190910135813.GK9720@e119886-lin.cambridge.arm.com>
References: <CGME20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f@epcas5p4.samsung.com>
 <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 10, 2019 at 05:55:01PM +0530, Pankaj Dubey wrote:
> From: Anvesh Salveru <anvesh.s@samsung.com>
> 
> In some platforms, PCIe PHY may have issues which will prevent linkup
> to happen in GEN3 or high speed. In case equalization fails, link will
> fallback to GEN1.

When you refer to "high speed", do you mean "higher speeds" as in GEN3,
GEN4, etc?

> 
> Designware controller has support for disabling GEN3 equalization if
> required. This patch enables the designware driver to disable the PCIe
> GEN3 equalization by writing into PCIE_PORT_GEN3_RELATED.

Thus limiting to GEN2 speeds max, right?

Is the purpose of PORT_LOGIC_GEN3_EQ_DISABLE to disable GEN3 and above
even though we advertise GEN3 and above speeds? I.e. the IP advertises
GEN3 but the phy can't handle it, we can't change what the IP advertises
and so we disable equalization to limit to GEN2?

I notice many of the other dwc drivers (dra7xx, keystone, tegra194, imx6)
seem to use the device tree to specify a max-link-speed and then impose
that limit by changing the value in PCI_EXP_LNKCAP. Is your
PORT_LOGIC_GEN3_EQ_DISABLE approach and alternative to the PCI_EXP_LNKCAP
approach, or does your approach add something else?

> 
> Platform drivers can disable equalization by setting the dwc_pci_quirk
> flag DWC_EQUALIZATION_DISABLE.
> 
> Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
>  drivers/pci/controller/dwc/pcie-designware.h | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 7d25102..bf82091 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -466,4 +466,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		break;
>  	}
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> +
> +	if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE)
> +		val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> +
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);

The problem here is that even when DWC_EQUALIZATION_DISABLE is not set
the driver will read and write PCIE_PORT_GEN3_RELATED when it is not
needed. How about something like:

> +
> +	if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE) {
> +	        val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> +		val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> +	        dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> +     }

>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ffed084..a1453c5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -29,6 +29,9 @@
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
>  #define LINK_WAIT_IATU			9
>  
> +/* Parameters for PCIe Quirks */
> +#define DWC_EQUALIZATION_DISABLE	0x1

How about using BIT(1) instead? Thus implying that you can combine
quirks.

Thanks,

Andrew Murray

> +
>  /* Synopsys-specific PCIe configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710
>  #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
> @@ -60,6 +63,9 @@
>  #define PCIE_MSI_INTR0_MASK		0x82C
>  #define PCIE_MSI_INTR0_STATUS		0x830
>  
> +#define PCIE_PORT_GEN3_RELATED		0x890
> +#define PORT_LOGIC_GEN3_EQ_DISABLE	BIT(16)
> +
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> @@ -244,6 +250,7 @@ struct dw_pcie {
>  	struct dw_pcie_ep	ep;
>  	const struct dw_pcie_ops *ops;
>  	unsigned int		version;
> +	unsigned int		dwc_pci_quirk;
>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> -- 
> 2.7.4
> 
