Return-Path: <linux-pci+bounces-9511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E9291DD2C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 12:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FC21F22E09
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C624813BC3F;
	Mon,  1 Jul 2024 10:55:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E112C52E;
	Mon,  1 Jul 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831358; cv=none; b=WFT+f50wxE8O1TJgtMJntbLyfzWjEkRd9j2aURJeeQX4yPcAQs28hR82zZJ2ER4gEDL/NF0gX0nD9T4H6loD/ICoYZEW8OFxJI49jY0BaHsoUP05YrWfolgEeirHGHAZSIjTC7bBy/9WrC6KvYzNDT/N8GAlLtotyb9uVEy2L00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831358; c=relaxed/simple;
	bh=QFvDw9N2Wh6HvHYkoYHsnmLrRrXdVnhx1uIqJJG9huc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rF66RI7BAqE+lc8ccy/kEtiwDz3U2QAwnN3lbUhrtgd5iBbcyurNxG0dtjtL5Y8zcF7PNbvVzjrTyCbyy8QEY30B6PT+/TMELlW4VzUsJlDrIWUdj0jl0BPfHFkUf9iyvbmzUZE1FFOyKvfkcU4soBs3zCQC+xLqJeGf+Aa9HnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCNGl1CJ2z6K60r;
	Mon,  1 Jul 2024 18:54:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CFEE1408F9;
	Mon,  1 Jul 2024 18:55:52 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 11:55:51 +0100
Date: Mon, 1 Jul 2024 11:55:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shradha Todi <shradha.t@samsung.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<fancer.lancer@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<conor.dooley@microchip.com>, <pankaj.dubey@samsung.com>,
	<gost.dev@samsung.com>
Subject: Re: [PATCH 1/3] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <20240701115550.00004200@Huawei.com>
In-Reply-To: <20240625093813.112555-2-shradha.t@samsung.com>
References: <20240625093813.112555-1-shradha.t@samsung.com>
	<CGME20240625094438epcas5p2760f4d1537d86541940177543cea5aa8@epcas5p2.samsung.com>
	<20240625093813.112555-2-shradha.t@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 25 Jun 2024 15:08:11 +0530
Shradha Todi <shradha.t@samsung.com> wrote:

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
> index 250cf7f40b85..b74e4a97558e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -275,6 +275,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
>  	return 0;
>  }
>  
> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
> +{
> +	u16 vsec = 0;
> +	u32 header;
> +
> +	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
> +					PCI_EXT_CAP_ID_VNDR))) {

Trivial but one more set of outer brackets than makes sense here.

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
> index f8e5431a207b..77686957a30d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -423,6 +423,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
>  
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap);
>  
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);


