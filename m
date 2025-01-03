Return-Path: <linux-pci+bounces-19212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E0A006A1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 10:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01F9162941
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662E1D0F50;
	Fri,  3 Jan 2025 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rq/Nee+j"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C61BEF93;
	Fri,  3 Jan 2025 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895823; cv=none; b=ItZ4X1mV+A292HQGi7sC3N0wgpc8wCiV/qTTWz5NhJ+jzdB+ClobjX9a46uKwwYD1EUp1AwNAJ8SomwdsHJT+rW9pZjXJ+htzFe3m7crBUmsuIHla46J9gEX/Fe4IPOHdADFytD9V5oZX8g79HoMkWx9OdDDmx3ooNj1cFNG+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895823; c=relaxed/simple;
	bh=1CnyMTeJ8ysgXUP5VxJNbzr0U48clwMyqfioLg6cdpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyg8KuaCKuXHMfDjfOYKh2XoHVcYxInqjNQql6ue2V6QEPdqAPfV6hmOEVRgHodWEpwKFVUGtuWlpylvD5+n+ZYlOIDdRp/QEaJG2rpgmobHRZUlW3xhAxbewZCwQvpeHN8JEvXRUgU8LikceMxZYQLnnbCBBmu+DuKe0Fckc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rq/Nee+j; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735895818;
	bh=1CnyMTeJ8ysgXUP5VxJNbzr0U48clwMyqfioLg6cdpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rq/Nee+jtD2JzgIstOTpzkS/hKkhH/BELuLz/reyl2Bas2hdhWhNTn2+WVSkJ2lLh
	 ryty4opmx5b5fWCZaw5P/lzmb7MqAgzR4sXg3OzArCAN84oJ4vMPUpB3UI3VUC3RBa
	 2bI6LEglW+hrdrHG3ShD+fF/yHNFc79hSPcd5lnqUp/xkOUipI4GMQcoPgjzh5Mmzh
	 zEzV7kYa0we8dyup5CItvJhgouOxTD1tj3XXJddRgwJ9sUWjg6KD7nksY24eqRi4Vz
	 7IEdDdjzn1dY9Idtawa+WIFMGiVgsCGzfkM7KU75Zdpcrqo5QeQhVGpHkwEOosnH/C
	 sUlJfoSNgdL0w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1554817E1542;
	Fri,  3 Jan 2025 10:16:58 +0100 (CET)
Message-ID: <b5ef9501-e07d-4150-9518-dd982518919e@collabora.com>
Date: Fri, 3 Jan 2025 10:16:57 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
To: Jianjun Wang <jianjun.wang@mediatek.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Xavier Chang <Xavier.Chang@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
 <20250103060035.30688-4-jianjun.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250103060035.30688-4-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/01/25 07:00, Jianjun Wang ha scritto:
> Disable ASPM L0s support because it does not significantly save power
> but impacts performance.
> 

That may be a good idea but, without numbers to support your statement, it's a bit
difficult to say.

How much power does ASPM L0s save on MediaTek SoCs, in microwatts?
How is the performance impacted, and on which specific device(s) on the PCIe bus?

Cheers,
Angelo

> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index ed3c0614486c..4bd3b39eebe2 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -84,6 +84,9 @@
>   #define PCIE_MSI_SET_ENABLE_REG		0x190
>   #define PCIE_MSI_SET_ENABLE		GENMASK(PCIE_MSI_SET_NUM - 1, 0)
>   
> +#define PCIE_LOW_POWER_CTRL_REG		0x194
> +#define PCIE_FORCE_DIS_L0S		BIT(8)
> +
>   #define PCIE_PIPE4_PIE8_REG		0x338
>   #define PCIE_K_FINETUNE_MAX		GENMASK(5, 0)
>   #define PCIE_K_FINETUNE_ERR		GENMASK(7, 6)
> @@ -458,6 +461,14 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>   	val &= ~PCIE_INTX_ENABLE;
>   	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
>   
> +	/*
> +	 * Disable L0s support because it does not significantly save power
> +	 * but impacts performance.
> +	 */
> +	val = readl_relaxed(pcie->base + PCIE_LOW_POWER_CTRL_REG);
> +	val |= PCIE_FORCE_DIS_L0S;
> +	writel_relaxed(val, pcie->base + PCIE_LOW_POWER_CTRL_REG);
> +
>   	/* Disable DVFSRC voltage request */
>   	val = readl_relaxed(pcie->base + PCIE_MISC_CTRL_REG);
>   	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;



