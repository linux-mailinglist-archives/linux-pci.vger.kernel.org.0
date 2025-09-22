Return-Path: <linux-pci+bounces-36654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B4BB906C7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DF217014E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686E3306493;
	Mon, 22 Sep 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AZ9Dzssr"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249E305E0C;
	Mon, 22 Sep 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540893; cv=none; b=hzHPFisjdsDUP2BsxhqTfzUggKeqWdpxSG2D2vk9lY/RwvCMWSWNZd+JhnZSCHjsHOlAOSWTd42yFEwKTcrNlvF9qrNGlgvLHAtQPobieuoA+AWwZsvHkBmFcSMDTfv49CPjrhEvhIlVjz7xryWoaD3aySqU0RVlFCuEJwcWC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540893; c=relaxed/simple;
	bh=lb1C8SMfCr+8kDNObsSpByOAWegC7XEjXpe8JDLgUhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YZwF2IPddd/FlXKnshpMC/8NPuy7TwyESbnqVV64IKGO+y620ecpdVDaxUFCZxfJ+8b5awAdTRhZFhPQdk0QGPMyKqT9sopwxtXoUZSZlyIST7xzbcqec9eWNQpvjTmrq1epMf6XynJLSyg++j4NmrysQxKy36iJkp6xxtmt//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AZ9Dzssr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758540889;
	bh=lb1C8SMfCr+8kDNObsSpByOAWegC7XEjXpe8JDLgUhs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AZ9DzssrYUTmn1Uo9lHUGzCIBjiYYVpAGQv0pDxxV6Bb+SQyxj/0UCdSUKl4ikOMF
	 jkPPDkKryJ3P3qLygqe/mNdBDL8Iu6b25uBcaFMmcq/31f70aU+ab3DZfwiFAxN3Zl
	 8+xOhOl38wFxtcaghMOiWQM2tzISz3BE55XdV3Tr0J9Lka3OR2jRTTcx/8ndZwYmca
	 IQ5Fo32hj1wIZI3G/tU5e1IS024gdaMo9f7866CCkCfg9h+aP0skzRGfM9ASA3H9h/
	 shX9j+bhsHCFQEtdCGihs0Yc0qmkjz1Wa+fgyDQa6Tpx0bPVEF3avKIiet7ccrCbQM
	 30ZZUCFCfxYlA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E87717E01CC;
	Mon, 22 Sep 2025 13:34:49 +0200 (CEST)
Message-ID: <1a4b2fbe-3584-48ad-9fce-e1c729862cb5@collabora.com>
Date: Mon, 22 Sep 2025 13:34:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: mediatek-gen3: add support for Airoha AN7583 SoC
To: Christian Marangi <ansuelsmth@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com
References: <20250920092612.21464-1-ansuelsmth@gmail.com>
 <20250920092612.21464-2-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250920092612.21464-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/09/25 11:25, Christian Marangi ha scritto:
> Add support for Airoha AN7583 SoC that implement the same logic of
> Airoha EN7581 with the only difference that only 1 PCIe line is
> supported (for GEN3).
> 
> A dedicated compatible is defined with the pdata struct with the 1 reset
> line.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 75ddb8bee168..db9985375be9 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1360,8 +1360,18 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
>   	.flags = SKIP_PCIE_RSTB,
>   };
>   
> +static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_an7583 = {
> +	.power_up = mtk_pcie_en7581_power_up,
> +	.phy_resets = {
> +		.id[0] = "phy-lane0",
> +		.num_resets = 1,
> +	},
> +	.flags = SKIP_PCIE_RSTB,
> +};
> +
>   static const struct of_device_id mtk_pcie_of_match[] = {
>   	{ .compatible = "airoha,en7581-pcie", .data = &mtk_pcie_soc_en7581 },
> +	{ .compatible = "airoha,an7583-pcie-gen3", .data = &mtk_pcie_soc_an7583 },

Same comments as the dt-bindings review, "an" comes before "en", also rename to
airoha,an7583-pcie.

Cheers,
Angelo

>   	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
>   	{ .compatible = "mediatek,mt8196-pcie", .data = &mtk_pcie_soc_mt8196 },
>   	{},



