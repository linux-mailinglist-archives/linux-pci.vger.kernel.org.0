Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 090AA10AB85
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 09:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfK0IPz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 03:15:55 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50230 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0IPy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 03:15:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAR8FdDj096811;
        Wed, 27 Nov 2019 02:15:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574842539;
        bh=vfBtNY+xbAV9gXZchLR1PUM9PQyW2elU9lS1sC+Tpkk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Pw69BFmMBBomCTtfL6fhdHtChk6wVo3b2N3aNuorM/l3fox27k/6WrX1k/Tj4SPU6
         ZdvqnU2s2OvDKsyUWCnsJN/47eR95AyCshdijewAfeuREb4YIB82Bdf19yuIMorRC+
         1VVOIRyG3TsfTGu/8+J2sh5OBJdJhbJwYYZc0quU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAR8FdfW030244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Nov 2019 02:15:39 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 27
 Nov 2019 02:15:39 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 27 Nov 2019 02:15:39 -0600
Received: from [10.24.69.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAR8FVqe112349;
        Wed, 27 Nov 2019 02:15:33 -0600
Subject: Re: [PATCH 1/4] PCI: dwc: Add new feature to skip core initialization
To:     Vidya Sagar <vidyas@nvidia.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-2-vidyas@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <973f239f-fdb8-b119-5ca1-b0a6307efe21@ti.com>
Date:   Wed, 27 Nov 2019 13:44:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113090851.26345-2-vidyas@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 13/11/19 2:38 PM, Vidya Sagar wrote:
> Add a new feature 'skip_core_init' that can be set by platform drivers
> of devices that do not have their core registers available until reference
> clock from host is available (Ex:- Tegra194) to indicate DesignWare
> endpoint mode sub-system to not perform core registers initialization.
> Existing dw_pcie_ep_init() is refactored and all the code that touches
> registers is extracted to form a new API dw_pcie_ep_init_complete() that
> can be called later by platform drivers setting 'skip_core_init' to '1'.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 72 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h  |  6 ++
>  include/linux/pci-epc.h                       |  1 +
>  3 files changed, 51 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 3dd2e2697294..06f4379be8a3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -492,19 +492,53 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>  	return 0;
>  }
>  
> -int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> +int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  {
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	unsigned int offset;
> +	unsigned int nbars;
> +	u8 hdr_type;
> +	u32 reg;
>  	int i;
> +
> +	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
> +	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
> +		dev_err(pci->dev,
> +			"PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
> +			hdr_type);
> +		return -EIO;
> +	}
> +
> +	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> +
> +	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
> +
> +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +	if (offset) {
> +		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> +			PCI_REBAR_CTRL_NBAR_SHIFT;
> +
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +
> +	dw_pcie_setup(pci);
> +
> +	return 0;
> +}
> +
> +int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
>  	int ret;
> -	u32 reg;
>  	void *addr;
> -	u8 hdr_type;
> -	unsigned int nbars;
> -	unsigned int offset;
>  	struct pci_epc *epc;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
> +	const struct pci_epc_features *epc_features;
>  
>  	if (!pci->dbi_base || !pci->dbi_base2) {
>  		dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
> @@ -563,13 +597,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (ep->ops->ep_init)
>  		ep->ops->ep_init(ep);
>  
> -	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
> -	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
> -		dev_err(pci->dev, "PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
> -			hdr_type);
> -		return -EIO;
> -	}
> -
>  	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
>  	if (ret < 0)
>  		epc->max_functions = 1;
> @@ -587,23 +614,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
>  		return -ENOMEM;
>  	}
> -	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
>  
> -	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
> -
> -	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> -	if (offset) {
> -		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> -		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> -			PCI_REBAR_CTRL_NBAR_SHIFT;
> -
> -		dw_pcie_dbi_ro_wr_en(pci);
> -		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> -			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> -		dw_pcie_dbi_ro_wr_dis(pci);
> +	if (ep->ops->get_features) {
> +		epc_features = ep->ops->get_features(ep);
> +		if (epc_features->skip_core_init)
> +			return 0;
>  	}
>  
> -	dw_pcie_setup(pci);
> -
> -	return 0;
> +	return dw_pcie_ep_init_complete(ep);
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 5accdd6bc388..340783e9032e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -399,6 +399,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>  #ifdef CONFIG_PCIE_DW_EP
>  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep);
> +int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> @@ -416,6 +417,11 @@ static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	return 0;
>  }
>  
> +static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> +{
> +	return 0;
> +}
> +
>  static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
>  }
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 36644ccd32ac..241e6a6f39fb 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -121,6 +121,7 @@ struct pci_epc_features {
>  	u8	bar_fixed_64bit;
>  	u64	bar_fixed_size[PCI_STD_NUM_BARS];
>  	size_t	align;
> +	bool	skip_core_init;

This looks more like a designware specific change. Why is it added to the core
pci_epc_features?

Thanks
Kishon
