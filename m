Return-Path: <linux-pci+bounces-5495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6A38940CE
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E64A1C211D1
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 16:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F6B481B8;
	Mon,  1 Apr 2024 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxqpg31C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691D3F8F4
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989275; cv=none; b=dx6TSsZi/dmBIAiPrYWDwEaKEsW7QieTiRnql4u2ILKYxBq1DIU5/Tef2aMoZ2S2vc0wD4ilqrPOIcno1//O4oQFRSN6x1B0F5F79NPFFZo0IXyxlPujKJyPCRWC+Qft6Y7QtYsZZyf1+sqLnuqkI70RLzC15p9ZoLVueqMcn08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989275; c=relaxed/simple;
	bh=eUPutGowJt1raeqUkz6idfgAosZAe5YLjWw+N/1N10g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3jD7KkOdFVu6hLBtic2FMpBbY3DkLttIleHvUG37KO4YS0XcGYvPn1kSl/SLLQnvQkIvFWZ1v97T+C+nVK1vPbKGzDiiGTv7hatGw4Apjkr58yrc3gbTXXJ+ve8Q3VUz9iOzbdGeCeMWHCAieqB5IIgXBYm8TkY1mnpmfDUOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bxqpg31C; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e709e0c123so3619181b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Apr 2024 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711989273; x=1712594073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i2QERqZP+UE+1W3A6WXtVWjA32ukQFrW4fDp6eX7jZw=;
        b=bxqpg31C2OxKkPqaebkA0fvf8FjLCJp6ClblIGHP/VQ4BYAYfwHd52QlOdRNbDXdHd
         QcqWR5L/C3gRu6+hMsJxenLzZfrYy+GK6VZGqrtIZkZ7T8B1wtpjy9G9x+Z0QzSGNE4A
         /0Bz10lrQB4Ohs+wKiXNmyBEP39exGc1tFBvkO96tk9BEYx/7jViMgDuCrCON4KFpCmO
         j2bvQWBEgV8fvw3EYb4w1uByYsBjCJFZixsfZNoVfF95r8JClCNL1koAYoQMyO+P/zm0
         xCSuXgc5q4cN1dHUEyTVJtD/LHucOXYg0/IpErWFj0d1at9VXLVMQIvUVNr/Gokgmoft
         mQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711989273; x=1712594073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2QERqZP+UE+1W3A6WXtVWjA32ukQFrW4fDp6eX7jZw=;
        b=L5MFcKAzndJQPz3xp0+Vq1xP9ZyQauAJ+6e+fmo7+M8rB0i12fgOJanNhwLd5BmhBM
         EleqrXch7buiJGpSaHto38XWywoLhoNa0o1wRPoYPx1v7s+6w4JKlLY7QzUeaAZ3f+bn
         hMD5zuAhNzqy3G4mUuHZ7aYMrd9bFiVDoV/QlDC6RCwla2Yp6CSkPPHPAtSushnvJcyV
         lAV6mY2Vmm6NHH20g05/kPa2mp8IUArHQwODqXFkm4QZF8CjuUQN7XwiWXlSIAICwhOV
         TIou04Onx72b//6gpLSm28NzDKAAhg9Uft8EaFASjRKSt+erzA+6a2V9HlesmnuiSH3V
         GcfA==
X-Forwarded-Encrypted: i=1; AJvYcCU9PkeSz+VVf1dDModnjc10paXTDweqPTJCLjYwA2sWlu+VvqK/d82tMevzTKDOd8HKyFxdWBLpwE+2GqFqzHKRx32LiziodOYP
X-Gm-Message-State: AOJu0YzyKZkBcfv92ANsc3I8sg683TwDVw4zeHYyuXPHon/IiN8oRC8M
	mvKIj+LWGb3GQUQa3fnnwDYJRdx13vl0e7+0AAqzh0mZH8azXeTS767P5Q1Dtw==
X-Google-Smtp-Source: AGHT+IGPBBm1aqeryFso3Y2gTgKOchg5T7HwYiw0HyVJxMXg8KVXD+JO1JrIl2N8hldsrCGX2zz+cQ==
X-Received: by 2002:a05:6a21:9212:b0:1a3:e4fe:f6f1 with SMTP id tl18-20020a056a21921200b001a3e4fef6f1mr9223908pzb.58.1711989273083;
        Mon, 01 Apr 2024 09:34:33 -0700 (PDT)
Received: from thinkpad ([103.246.195.48])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902bb8700b001e0573bbbbdsm9068595pls.218.2024.04.01.09.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 09:34:32 -0700 (PDT)
Date: Mon, 1 Apr 2024 22:04:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 07/11] PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown()
 API to handle Link Down event
Message-ID: <20240401163427.GA2547@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-7-6134e6c1d491@linaro.org>
 <ZgRgJsOT_bzXM1wK@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgRgJsOT_bzXM1wK@ryzen>

On Wed, Mar 27, 2024 at 07:06:30PM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Thu, Mar 14, 2024 at 08:53:46PM +0530, Manivannan Sadhasivam wrote:
> > As per the PCIe base spec r5.0, section 5.2, Link Down event can happen
> > under any of the following circumstances:
> > 
> > 1. Fundamental/Hot reset
> > 2. Link disable transmission by upstream component
> > 3. Moving from L2/L3 to L0
> > 
> > In those cases, Link Down causes some non-sticky DWC registers to loose the
> > state (like REBAR, etc...). So the drivers need to reinitialize them to
> > function properly once the link comes back again.
> > 
> > This is not a problem for drivers supporting PERST# IRQ, since they can
> > reinitialize the registers in the PERST# IRQ callback. But for the drivers
> > not supporting PERST#, there is no way they can reinitialize the registers
> > other than relying on Link Down IRQ received when the link goes down. So
> > let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> > non-sticky registers and also notifies the EPF drivers about link going
> > down.
> > 
> > This API can also be used by the drivers supporting PERST# to handle the
> > scenario (2) mentioned above.
> > 
> > NOTE: For the sake of code organization, move the dw_pcie_ep_linkup()
> > definition just above dw_pcie_ep_linkdown().
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 93 ++++++++++++++++---------
> >  drivers/pci/controller/dwc/pcie-designware.h    |  5 ++
> >  2 files changed, 67 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 3893a8c1a11c..5451057ca74b 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -14,18 +14,6 @@
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> >  
> > -/**
> > - * dw_pcie_ep_linkup - Notify EPF drivers about link up event
> > - * @ep: DWC EP device
> > - */
> > -void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > -{
> > -	struct pci_epc *epc = ep->epc;
> > -
> > -	pci_epc_linkup(epc);
> > -}
> > -EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> > -
> >  /**
> >   * dw_pcie_ep_init_notify - Notify EPF drivers about EPC initialization
> >   *			    complete
> > @@ -672,6 +660,29 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> >  	return 0;
> >  }
> >  
> > +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> > +{
> > +	unsigned int offset;
> > +	unsigned int nbars;
> > +	u32 reg, i;
> > +
> > +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
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
> > +	dw_pcie_setup(pci);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +}
> > +
> >  /**
> >   * dw_pcie_ep_init_registers - Initialize DWC EP specific registers
> >   * @ep: DWC EP device
> > @@ -686,13 +697,11 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> >  	struct dw_pcie_ep_func *ep_func;
> >  	struct device *dev = pci->dev;
> >  	struct pci_epc *epc = ep->epc;
> > -	unsigned int offset, ptm_cap_base;
> > -	unsigned int nbars;
> > +	u32 ptm_cap_base, reg;
> >  	u8 hdr_type;
> >  	u8 func_no;
> > -	int i, ret;
> >  	void *addr;
> > -	u32 reg;
> > +	int ret;
> >  
> >  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> >  		   PCI_HEADER_TYPE_MASK;
> > @@ -755,20 +764,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> >  	if (ep->ops->init)
> >  		ep->ops->init(ep);
> >  
> > -	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> >  	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> >  
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
> >  	/*
> >  	 * PTM responder capability can be disabled only after disabling
> >  	 * PTM root capability.
> > @@ -785,9 +782,6 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> >  		dw_pcie_dbi_ro_wr_dis(pci);
> >  	}
> >  
> > -	dw_pcie_setup(pci);
> > -	dw_pcie_dbi_ro_wr_dis(pci);
> > -
> 
> Your previous series had:
> 
> -       dw_pcie_setup(pci);
> -       dw_pcie_dbi_ro_wr_dis(pci);
> +       dw_pcie_ep_init_non_sticky_registers(pci);
> 
> Here.
> I tested this series, but it did not work for me (the Resizable BARs did
> not get resized) since you removed the call to
> dw_pcie_ep_init_non_sticky_registers().
> 
> By readding the call to dw_pcie_ep_init_non_sticky_registers(),
> the BARs get Resized again.
> 
> 

Ah, looks like rebase has gone bad. Will fix it in v2.

> BTW do you have a git branch with both your series somewhere?
> (Possibly even rebased on
> https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/T/#t
> like you suggested in your other mail.)
> 

There it is: https://git.codelinaro.org/manivannan.sadhasivam/linux/-/tree/b4/pci-epf-rework

- Mani

-- 
மணிவண்ணன் சதாசிவம்

