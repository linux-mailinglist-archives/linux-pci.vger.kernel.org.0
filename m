Return-Path: <linux-pci+bounces-17863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876AC9E758F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485AB289675
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFF620E31D;
	Fri,  6 Dec 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbzAwjVn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCF20E31F;
	Fri,  6 Dec 2024 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501596; cv=none; b=tVL2ZTkBeJPH5kPwgYyoAQN1qe0+XvqBEe0s70oWfUkweb7iKmbKufFDM9pJqPOAgWngDtg1YOAriPZjWFB86DGEv8xYdIxPGPWBfhZLoNdTkhTa84MkTirOv8GrUXfkBjUZKeIMu+KS9HWLVM95XQPjXax/vDhspzCnK7/mHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501596; c=relaxed/simple;
	bh=7xX9xunhDWYThtkuyLxpEVRd0oYFNAG4+kAX1CnrpkA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gu4q7wyQbfQU2YubkK+SSIt6I4B0b+36wcMDSF+OysKBedV3QTZuUtBMLJA5HwsFfIwjAFFkNWL85OKg4hSV4Wd9cs7Wy+3i0mcQpIuaPE11EqakhBn6v/PNhTvMrHZ/EjpRwDIPVPsRYaXRmmypBfn5Ogmpc25f4v6XgFrs8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbzAwjVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92360C4CED1;
	Fri,  6 Dec 2024 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733501595;
	bh=7xX9xunhDWYThtkuyLxpEVRd0oYFNAG4+kAX1CnrpkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hbzAwjVnWEBKO/pyb0qY0q+eNbTUC724gOX99stimvj3OCPYrqLCM7WzmFkjz9yTW
	 YezhL3BTlK/ZNCTe4UqGmxBW7Js5udBk54LS3A2iN/Sa6WMEFOP11Fdk8XEJFvH0gQ
	 gXYxBaO2vU9zQODBJQIGPY1rWfkRSls/KzcnevL/5D4rtTyFnFLo5i6FUmDAsvyeXp
	 xvghpxDgk5G1eObcNq190TGMqdz/oNLhPPURBPpQTE94pqLvHnZSr6Yjj4UQttB6Mm
	 3v+s7u414y/LJL8Zqnl4ljFr0sE51v1bx6IIBE4SiAq0KV+1gIqBMq74wV27sMDm8D
	 YS1o8ulXG5wkA==
Date: Fri, 6 Dec 2024 10:13:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <20241206161314.GA3101322@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206074456.17401-2-shradha.t@samsung.com>

On Fri, Dec 06, 2024 at 01:14:55PM +0530, Shradha Todi wrote:
> Add vendor specific extended configuration space capability search API
> using struct dw_pcie pointer for DW controllers.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 6d6cbc8b5b2c..41230c5e4a53 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -277,6 +277,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
>  	return 0;
>  }
>  
> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)

To make sure that we find a VSEC ID that corresponds to the expected
vendor, I think this interface needs to be the same as
pci_find_vsec_capability().  In particular, it needs to take a "u16
vendor" and a "u16 vsec_cap".

(pci_find_vsec_capability() takes an "int cap", but I don't think
that's quite right).

> +{
> +	u16 vsec = 0;
> +	u32 header;
> +
> +	while (vsec = dw_pcie_find_next_ext_capability(pci, vsec,
> +					PCI_EXT_CAP_ID_VNDR)) {
> +		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
> +		if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
> +			return vsec;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);
> +
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>  {
>  	return dw_pcie_find_next_ext_capability(pci, 0, cap);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..98a057820bc7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -476,6 +476,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
>  
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap);
>  
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> -- 
> 2.17.1
> 

