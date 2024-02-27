Return-Path: <linux-pci+bounces-4125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C42869096
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 13:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141FF1C2521E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0C13A883;
	Tue, 27 Feb 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+kt4G0D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899C1EA7A
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037042; cv=none; b=uwU1LqaHio4RZ4UwzrqqU1adokOUOm5JGNaxVDS70DE6H8sfmv5J0egPSCQ+338RWVyM4mEH33u+ltLv+aABRYL1X8H7ZfFkSiwGmYSWnvso5XbHZg4NhcjQ02nvDRsqZbwobafL5j74UUS/Rsc/qTO/q3YSQhUNMJ47AxHXR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037042; c=relaxed/simple;
	bh=O/kuFE0nhepxHQA2HCwyTojuRxGXcFLyovWl96ySoYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSyLjeBweJKmusbAMJ5FjV4vni2I2sUYtCawwkTvWdT/LwyNF8XEJREGXb4q7inusyw7faURTaaMrpZkS/xL236pYI5JarEugVNH/LPejPlWKu/3NMQqmzOi2kQx6elfELtOwvIiN2X4rTTvZslEZN+mGjHsF+FHfrmUlhY0WoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h+kt4G0D; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so3377952b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 04:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709037040; x=1709641840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wrm6zOCUYamX5/HzD4TWzGE4UW/wSmlHUiwPxwaSkho=;
        b=h+kt4G0DomdcXscyjZtpSRpaMGYwxeUDJ7abrtmMPIh+g4kfrqF8vpK9F4dMtSinmV
         9tXsJQ2L8rPoJT6MeAkCyRgM3hbxLKYze6FZkJQQBX0JBwLhy0A7o5w4T8rDkCzpu59G
         lhkaMoQ8NvElcr5+e2CBbzKWJvkOX0zfp1Sl4vAko+G7uL9ALqrzI/KseTxju/OGA++C
         mpbBgr/pUKys9NbiiqRiarKjHhTxcwbMNEczIdfAOuHszWD+96WWqEcVbPw6K/ah03pf
         FNNGFOhNbf9d6S2Zrq8W2JSr85xEQ38FfpByefST++qpmwpRTDWze3R+6pu3sjCm/G2R
         L5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037040; x=1709641840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrm6zOCUYamX5/HzD4TWzGE4UW/wSmlHUiwPxwaSkho=;
        b=jXYNi4xYhQa5VniPMm+PlgK00zI3oQkUKOLQ/P1J2RK4o+zHJUyaFtHPNVkrgm8o4k
         MgjNi0HAbmyKaqPEcTiurc6OgjwXnSUPZX8hR+qLWsVIz4b5HEKk+AI2vT9WDVSfhsxv
         OF7z7z51hdvpC9QWFC3C+8VKpQcutyQE2S+hpBJZ5KeJ+mAY912qBLNaJZGovtlRQnA7
         OSP23BhlBTU5f145ssQZXpF8d5bYTPjoZA7jNw6ItQta7LarJ2hJCOyNxwS8aZfEjJFf
         DO5pj3i0VGyAVhKpqbF1R1qkwDcoPme4SQpZAFwNMm0BzldOuGcucURrEQwR/CZfdsks
         fHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT2EOaEBJa/JrTB/xXRp5ZkWdi6faz+4IQWlKDCr4Oxq6D5t9e2VpveZgK0rVT0TjE8/RydTANwXO2v3YkWF4+/+m6qhOBbfhV
X-Gm-Message-State: AOJu0Yyo3r3GQ3N5wwOoCx1QRZSw25SORFZdfa1zVWYOSyp2E0d1IxWd
	gRrsJfVpnuVrbD/F2LUN1b3PN5WnJJbtMYmbFNlwMZcgZfaWZ+XJBQ47+L5xKQ==
X-Google-Smtp-Source: AGHT+IF1SucMaGZmVzLO3Vi7Owg0MIIBRBMVFqlTO53r97tXf67o+cg/pWiwgklC+Ex3rLhnBWIXYA==
X-Received: by 2002:aa7:86c2:0:b0:6e4:870c:19b0 with SMTP id h2-20020aa786c2000000b006e4870c19b0mr8383712pfo.24.1709037039619;
        Tue, 27 Feb 2024 04:30:39 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id p19-20020a056a000b5300b006e5003f6e33sm5042416pfo.161.2024.02.27.04.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:30:39 -0800 (PST)
Date: Tue, 27 Feb 2024 18:00:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v8 08/10] PCI: dwc: ep: Add a generic
 dw_pcie_ep_linkdown() API to handle LINK_DOWN event
Message-ID: <20240227123024.GO2587@thinkpad>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-8-64c7fd0cfe64@linaro.org>
 <ZdzH2lOSwBsIp/Jc@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdzH2lOSwBsIp/Jc@lizhi-Precision-Tower-5810>

On Mon, Feb 26, 2024 at 12:18:18PM -0500, Frank Li wrote:
> On Sat, Feb 24, 2024 at 12:24:14PM +0530, Manivannan Sadhasivam wrote:
> > The PCIe link can go to LINK_DOWN state in one of the following scenarios:
> > 
> > 1. Fundamental (PERST#)/hot/warm reset
> > 2. Link transition from L2/L3 to L0
> 
> From L0 to L2/l3
> 

I don't understand what you mean here. Link down won't happen while moving from
L0 to L2/L3, it is the opposite.

> > 
> > In those cases, LINK_DOWN causes some non-sticky DWC registers to loose the
> > state (like REBAR, PTM_CAP etc...). So the drivers need to reinitialize
> > them to function properly once the link comes back again.
> > 
> > This is not a problem for drivers supporting PERST# IRQ, since they can
> > reinitialize the registers in the PERST# IRQ callback. But for the drivers
> > not supporting PERST#, there is no way they can reinitialize the registers
> > other than relying on LINK_DOWN IRQ received when the link goes down. So
> > let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> > non-sticky registers and also notifies the EPF drivers about link going
> > down.
> > 
> > This API can also be used by the drivers supporting PERST# to handle the
> > scenario (2) mentioned above.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 111 ++++++++++++++----------
> >  drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
> >  2 files changed, 72 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 278bdc9b2269..fed4c2936c78 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -14,14 +14,6 @@
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> >  
> > -void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > -{
> > -	struct pci_epc *epc = ep->epc;
> > -
> > -	pci_epc_linkup(epc);
> > -}
> > -EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> > -
> 
> No sure why git remove this block and add these back.
> 

Because, we are adding dw_pcie_ep_linkdown() API way below and it makes sense to
move this API also to keep it ordered. Maybe I should've described it in commit
message.

- Mani

> 
> >  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> >  {
> >  	struct pci_epc *epc = ep->epc;
> > @@ -603,19 +595,56 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> >  	return 0;
> >  }
> >  
> > +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> > +{
> > +	unsigned int offset, ptm_cap_base;
> > +	unsigned int nbars;
> > +	u32 reg, i;
> > +
> > +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > +	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> > +
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +
> > +	if (offset) {
> > +		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> > +		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> > +			PCI_REBAR_CTRL_NBAR_SHIFT;
> > +
> > +		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> > +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> > +	}
> > +
> > +	/*
> > +	 * PTM responder capability can be disabled only after disabling
> > +	 * PTM root capability.
> > +	 */
> > +	if (ptm_cap_base) {
> > +		dw_pcie_dbi_ro_wr_en(pci);
> > +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> > +		reg &= ~PCI_PTM_CAP_ROOT;
> > +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> > +
> > +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> > +		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> > +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> > +		dw_pcie_dbi_ro_wr_dis(pci);
> > +	}
> > +
> > +	dw_pcie_setup(pci);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +}
> > +
> >  int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  	struct dw_pcie_ep_func *ep_func;
> >  	struct device *dev = pci->dev;
> >  	struct pci_epc *epc = ep->epc;
> > -	unsigned int offset, ptm_cap_base;
> > -	unsigned int nbars;
> >  	u8 hdr_type;
> >  	u8 func_no;
> > -	int i, ret;
> >  	void *addr;
> > -	u32 reg;
> > +	int ret;
> >  
> >  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> >  		   PCI_HEADER_TYPE_MASK;
> > @@ -678,38 +707,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> >  	if (ep->ops->init)
> >  		ep->ops->init(ep);
> >  
> > -	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > -	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> > -
> > -	dw_pcie_dbi_ro_wr_en(pci);
> > -
> > -	if (offset) {
> > -		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> > -		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> > -			PCI_REBAR_CTRL_NBAR_SHIFT;
> > -
> > -		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> > -			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> > -	}
> > -
> > -	/*
> > -	 * PTM responder capability can be disabled only after disabling
> > -	 * PTM root capability.
> > -	 */
> > -	if (ptm_cap_base) {
> > -		dw_pcie_dbi_ro_wr_en(pci);
> > -		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> > -		reg &= ~PCI_PTM_CAP_ROOT;
> > -		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> > -
> > -		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> > -		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> > -		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> > -		dw_pcie_dbi_ro_wr_dis(pci);
> > -	}
> > -
> > -	dw_pcie_setup(pci);
> > -	dw_pcie_dbi_ro_wr_dis(pci);
> > +	dw_pcie_ep_init_non_sticky_registers(pci);
> >  
> >  	return 0;
> >  
> > @@ -720,6 +718,31 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_init_registers);
> >  
> > +void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > +{
> > +	struct pci_epc *epc = ep->epc;
> > +
> > +	pci_epc_linkup(epc);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> > +
> > +void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct pci_epc *epc = ep->epc;
> > +
> > +	/*
> > +	 * Initialize the non-sticky DWC registers as they would've reset post
> > +	 * LINK_DOWN. This is specifically needed for drivers not supporting
> > +	 * PERST# as they have no way to reinitialize the registers before the
> > +	 * link comes back again.
> > +	 */
> > +	dw_pcie_ep_init_non_sticky_registers(pci);
> > +
> > +	pci_epc_linkdown(epc);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_ep_linkdown);
> > +
> >  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  {
> >  	int ret;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index f8e5431a207b..152969545b0a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -668,6 +668,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
> >  
> >  #ifdef CONFIG_PCIE_DW_EP
> >  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
> > +void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep);
> >  int dw_pcie_ep_init(struct dw_pcie_ep *ep);
> >  int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
> >  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
> > @@ -688,6 +689,10 @@ static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> >  {
> >  }
> >  
> > +static inline void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
> > +{
> > +}
> > +
> >  static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  {
> >  	return 0;
> > 
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

