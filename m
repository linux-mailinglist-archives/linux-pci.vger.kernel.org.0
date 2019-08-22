Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B6991CE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 13:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbfHVLNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 07:13:19 -0400
Received: from foss.arm.com ([217.140.110.172]:44100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbfHVLNT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 07:13:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 811CF344;
        Thu, 22 Aug 2019 04:13:18 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFA4E3F246;
        Thu, 22 Aug 2019 04:13:17 -0700 (PDT)
Date:   Thu, 22 Aug 2019 12:13:16 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, talel@amazon.com, hanochu@amazon.com,
        hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 7/7] PCI: dwc: Add validation that PCIe core is set to
 correct mode
Message-ID: <20190822111315.GN23903@e119886-lin.cambridge.arm.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
 <20190821154745.31834-3-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821154745.31834-3-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 21, 2019 at 06:47:45PM +0300, Jonathan Chocron wrote:
> Some PCIe controllers can be set to either Host or EP according to some
> early boot FW. To make sure there is no discrepancy (e.g. FW configured
> the port to EP mode while the DT specifies it as a host bridge or vice
> versa), a check has been added for each mode.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 8 ++++++++
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2bf5a35c0570..00e59a134b93 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -531,6 +531,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	int ret;
>  	u32 reg;
>  	void *addr;
> +	u8 hdr_type;
>  	unsigned int nbars;
>  	unsigned int offset;
>  	struct pci_epc *epc;
> @@ -543,6 +544,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return -EINVAL;
>  	}
>  
> +	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
> +	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
> +		dev_err(pci->dev, "PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
> +			hdr_type);
> +		return -EIO;
> +	}
> +
>  	ret = of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
>  	if (ret < 0) {
>  		dev_err(dev, "Unable to read *num-ib-windows* property\n");
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f93252d0da5b..d2ca748e4c85 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -323,6 +323,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct pci_bus *child;
>  	struct pci_host_bridge *bridge;
>  	struct resource *cfg_res;
> +	u8 hdr_type;
>  	int ret;
>  
>  	raw_spin_lock_init(&pci->pp.lock);
> @@ -396,6 +397,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> +	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);

Do we know if it's always safe to read these registers at this point in time?

Later in dw_pcie_host_init we call pp->ops->host_init - looking at the
implementations of .host_init I can see:

 - resets being performed (qcom_ep_reset_assert,
   artpec6_pcie_assert_core_reset, imx6_pcie_assert_core_reset)
 - changes to config space registers (ks_pcie_init_id, dw_pcie_setup_rc)
   including setting PCI_CLASS_DEVICE
 - and clocks being enabled (qcom_pcie_init_1_0_0)

I'm not sure if your changes would cause anything to break for these other
controllers (or future controllers) as I couldn't see any other reads to the
config.

Given that we are reading config space should dw_pcie_rd_own_conf be used?
(For example kirin_pcie_rd_own_conf does something special).

Thanks,

Andrew Murray

> +	if (hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> +		dev_err(pci->dev, "PCIe controller is not set to bridge type (hdr_type: 0x%x)!\n",
> +			hdr_type);
> +		return -EIO;
> +	}
> +
>  	pp->mem_base = pp->mem->start;
>  
>  	if (!pp->va_cfg0_base) {
> -- 
> 2.17.1
> 
