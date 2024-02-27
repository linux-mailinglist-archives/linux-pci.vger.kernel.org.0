Return-Path: <linux-pci+bounces-4151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047C0869F84
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 19:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229A01C22351
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474851C33;
	Tue, 27 Feb 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rE2q19TX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438451C34
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059873; cv=none; b=iJ329OaP0VNQQxAgIiGkk93WG+4y+y2iHRQwP1pxFMkN16CQPjHvYbBUMQtN+EbRZucY/AfzoIHTAOCcWgpgNpvR5EoCHTgOxvGutNoMARrIsbNlrF+d1jSkVz/QgrkxTEEZASqnLFKjKn39ryMAYRqDMvXoTrosIVcN7RyPzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059873; c=relaxed/simple;
	bh=m8BCJCDCVjUu1aX9u8678gH0B9TMigZhFp4TpDpGOtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF1Pyos9/K1tCRXvMLYnuZYkZNFvk5k2mkwCDiOoKgZGoNvpuhDj+oVxlrrADlwxDIxH+iLKDZjVnYY4aabdiNOSIflXhSeF7AiHlm3b7qyY14uMS0hkSOWcscGLlkdBB68TcHs7mV1EpSQv351QuYI7ndsReaZE2rLbZNlClyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rE2q19TX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc75972f25so39399075ad.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 10:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709059870; x=1709664670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZzsUzPaeQV0xVaYYOa5fkl+D3bB3KmqWtFdIBMocqZs=;
        b=rE2q19TXF19nFEFo162gIW2eIUbGHpXw3tXaHA4YI4gHEjLslGklZXmA8MZ6sXioWs
         CWT6yQxpjR7nLjbSDZrTtWRbNzJfjuwssWl3V7xhG16yk0ClN7YBrq1DS0MqTBqQHuYV
         9veaVXZykqxeaymfPrMLZk26deeHC+AZVHzQcFq7hnzmztHWuHsn1z2OAEkMnb0D2zex
         P8ALrEboDuyAU7HD49sxq3RIIcOZo6RNDg2WRQAT4d4YX8frXNZCeYRwKUHYJxCuU3hc
         WI2vLjV6KwZYiO9FKo9rXT+Hd6Mr5pQIQH8JWIqR4QELIeLWPTDU7ihrAJ3Udqgz0eTl
         S5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709059870; x=1709664670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzsUzPaeQV0xVaYYOa5fkl+D3bB3KmqWtFdIBMocqZs=;
        b=i1VjR564KXoMXKb3SHCxAgxaC275UwKXWzm+eJ/eqSSzzEpQEL+kNSsxETO9S20itc
         p9q96E+3R02aceKmEGmCaIagf8AHQUttbm7gawEKfjKuLkFjGvB6nwf54pVLkQxXx2Sp
         +1vqErxAJjzKu5LKPUFlMLdRRh/aLvNJ8lGHF3L2qDhADaLtISm3mP3UdpEslpXb9JAp
         8xlCdvr4CIcY2O5ZO3cfD9LZUsRq+1Ycaxzm5GQrgcATlvBo90T/LCFOJ12VZOIlALFR
         72INt2Y0AxJMTgusDshARrPbkRbTUlVyPXR8SDyv2IzpOf2u++yjLKOVYYphjDswJpTM
         0qNw==
X-Forwarded-Encrypted: i=1; AJvYcCWWGTplhtm7J7P/v27IDnV5FKdUV74uH1OxOB7a1LClRrgsuE/AAmQZrB9AvPzZBLIQIkQ/4QKtT6kfnXobnrZAW18Z0sdIp3YW
X-Gm-Message-State: AOJu0YzzwyYFzepb6fsIB/Tu40w6zYh8q0aWcnH6S64qfjYjXwdqkxTF
	4jTWhW4e7z5nbpMR+XF+V/vFOU4AhQBVVRuGJXSEofbaAkuekiDTkSRHp1Kugw==
X-Google-Smtp-Source: AGHT+IFMrquxHELSuk64r8EzaLnPYxdhtlQPf9g7u2EtEZHnTxtPf52KDLuAlSX+ap+F1qbMBmUq7w==
X-Received: by 2002:a17:903:449:b0:1da:2c01:fef5 with SMTP id iw9-20020a170903044900b001da2c01fef5mr10095757plb.56.1709059869792;
        Tue, 27 Feb 2024 10:51:09 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d90300b001db93340f9bsm1828147plz.205.2024.02.27.10.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:51:09 -0800 (PST)
Date: Wed, 28 Feb 2024 00:20:50 +0530
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
Message-ID: <20240227185050.GV2587@thinkpad>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-8-64c7fd0cfe64@linaro.org>
 <ZdzH2lOSwBsIp/Jc@lizhi-Precision-Tower-5810>
 <20240227123024.GO2587@thinkpad>
 <Zd4bLZb2z4TEoR1a@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd4bLZb2z4TEoR1a@lizhi-Precision-Tower-5810>

On Tue, Feb 27, 2024 at 12:26:05PM -0500, Frank Li wrote:
> On Tue, Feb 27, 2024 at 06:00:24PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Feb 26, 2024 at 12:18:18PM -0500, Frank Li wrote:
> > > On Sat, Feb 24, 2024 at 12:24:14PM +0530, Manivannan Sadhasivam wrote:
> > > > The PCIe link can go to LINK_DOWN state in one of the following scenarios:
> > > > 
> > > > 1. Fundamental (PERST#)/hot/warm reset
> > > > 2. Link transition from L2/L3 to L0
> > > 
> > > From L0 to L2/l3
> > > 
> > 
> > I don't understand what you mean here. Link down won't happen while moving from
> > L0 to L2/L3, it is the opposite.
> 
> Strange, why there are not linkdown from L0 to L2/l3. But have linkdown
> from L2/l3 to L0? when linkup happen? Any document show these?
> 

Refer PCIe Spec 5.0, Figure 5-1 Link Power Management State Flow Diagram.

- Mani

> Frank
> 
> > 
> > > > 
> > > > In those cases, LINK_DOWN causes some non-sticky DWC registers to loose the
> > > > state (like REBAR, PTM_CAP etc...). So the drivers need to reinitialize
> > > > them to function properly once the link comes back again.
> > > > 
> > > > This is not a problem for drivers supporting PERST# IRQ, since they can
> > > > reinitialize the registers in the PERST# IRQ callback. But for the drivers
> > > > not supporting PERST#, there is no way they can reinitialize the registers
> > > > other than relying on LINK_DOWN IRQ received when the link goes down. So
> > > > let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> > > > non-sticky registers and also notifies the EPF drivers about link going
> > > > down.
> > > > 
> > > > This API can also be used by the drivers supporting PERST# to handle the
> > > > scenario (2) mentioned above.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 111 ++++++++++++++----------
> > > >  drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
> > > >  2 files changed, 72 insertions(+), 44 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 278bdc9b2269..fed4c2936c78 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -14,14 +14,6 @@
> > > >  #include <linux/pci-epc.h>
> > > >  #include <linux/pci-epf.h>
> > > >  
> > > > -void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > > > -{
> > > > -	struct pci_epc *epc = ep->epc;
> > > > -
> > > > -	pci_epc_linkup(epc);
> > > > -}
> > > > -EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> > > > -
> > > 
> > > No sure why git remove this block and add these back.
> > > 
> > 
> > Because, we are adding dw_pcie_ep_linkdown() API way below and it makes sense to
> > move this API also to keep it ordered. Maybe I should've described it in commit
> > message.
> > 
> > - Mani
> > 
> > > 
> > > >  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> > > >  {
> > > >  	struct pci_epc *epc = ep->epc;
> > > > @@ -603,19 +595,56 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> > > > +{
> > > > +	unsigned int offset, ptm_cap_base;
> > > > +	unsigned int nbars;
> > > > +	u32 reg, i;
> > > > +
> > > > +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > > > +	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> > > > +
> > > > +	dw_pcie_dbi_ro_wr_en(pci);
> > > > +
> > > > +	if (offset) {
> > > > +		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> > > > +		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> > > > +			PCI_REBAR_CTRL_NBAR_SHIFT;
> > > > +
> > > > +		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> > > > +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * PTM responder capability can be disabled only after disabling
> > > > +	 * PTM root capability.
> > > > +	 */
> > > > +	if (ptm_cap_base) {
> > > > +		dw_pcie_dbi_ro_wr_en(pci);
> > > > +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> > > > +		reg &= ~PCI_PTM_CAP_ROOT;
> > > > +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> > > > +
> > > > +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> > > > +		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> > > > +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> > > > +		dw_pcie_dbi_ro_wr_dis(pci);
> > > > +	}
> > > > +
> > > > +	dw_pcie_setup(pci);
> > > > +	dw_pcie_dbi_ro_wr_dis(pci);
> > > > +}
> > > > +
> > > >  int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> > > >  {
> > > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > >  	struct dw_pcie_ep_func *ep_func;
> > > >  	struct device *dev = pci->dev;
> > > >  	struct pci_epc *epc = ep->epc;
> > > > -	unsigned int offset, ptm_cap_base;
> > > > -	unsigned int nbars;
> > > >  	u8 hdr_type;
> > > >  	u8 func_no;
> > > > -	int i, ret;
> > > >  	void *addr;
> > > > -	u32 reg;
> > > > +	int ret;
> > > >  
> > > >  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> > > >  		   PCI_HEADER_TYPE_MASK;
> > > > @@ -678,38 +707,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> > > >  	if (ep->ops->init)
> > > >  		ep->ops->init(ep);
> > > >  
> > > > -	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > > > -	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> > > > -
> > > > -	dw_pcie_dbi_ro_wr_en(pci);
> > > > -
> > > > -	if (offset) {
> > > > -		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> > > > -		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> > > > -			PCI_REBAR_CTRL_NBAR_SHIFT;
> > > > -
> > > > -		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> > > > -			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> > > > -	}
> > > > -
> > > > -	/*
> > > > -	 * PTM responder capability can be disabled only after disabling
> > > > -	 * PTM root capability.
> > > > -	 */
> > > > -	if (ptm_cap_base) {
> > > > -		dw_pcie_dbi_ro_wr_en(pci);
> > > > -		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> > > > -		reg &= ~PCI_PTM_CAP_ROOT;
> > > > -		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> > > > -
> > > > -		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> > > > -		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> > > > -		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> > > > -		dw_pcie_dbi_ro_wr_dis(pci);
> > > > -	}
> > > > -
> > > > -	dw_pcie_setup(pci);
> > > > -	dw_pcie_dbi_ro_wr_dis(pci);
> > > > +	dw_pcie_ep_init_non_sticky_registers(pci);
> > > >  
> > > >  	return 0;
> > > >  
> > > > @@ -720,6 +718,31 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dw_pcie_ep_init_registers);
> > > >  
> > > > +void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > > > +{
> > > > +	struct pci_epc *epc = ep->epc;
> > > > +
> > > > +	pci_epc_linkup(epc);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> > > > +
> > > > +void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
> > > > +{
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > +	struct pci_epc *epc = ep->epc;
> > > > +
> > > > +	/*
> > > > +	 * Initialize the non-sticky DWC registers as they would've reset post
> > > > +	 * LINK_DOWN. This is specifically needed for drivers not supporting
> > > > +	 * PERST# as they have no way to reinitialize the registers before the
> > > > +	 * link comes back again.
> > > > +	 */
> > > > +	dw_pcie_ep_init_non_sticky_registers(pci);
> > > > +
> > > > +	pci_epc_linkdown(epc);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_pcie_ep_linkdown);
> > > > +
> > > >  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  {
> > > >  	int ret;
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index f8e5431a207b..152969545b0a 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -668,6 +668,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
> > > >  
> > > >  #ifdef CONFIG_PCIE_DW_EP
> > > >  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
> > > > +void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep);
> > > >  int dw_pcie_ep_init(struct dw_pcie_ep *ep);
> > > >  int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
> > > >  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
> > > > @@ -688,6 +689,10 @@ static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > > >  {
> > > >  }
> > > >  
> > > > +static inline void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
> > > > +{
> > > > +}
> > > > +
> > > >  static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  {
> > > >  	return 0;
> > > > 
> > > > -- 
> > > > 2.25.1
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

