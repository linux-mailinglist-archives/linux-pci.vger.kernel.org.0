Return-Path: <linux-pci+bounces-19214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580D2A006F7
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 10:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CDF162A7A
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 09:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3181CD1E1;
	Fri,  3 Jan 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E+7p/7rM"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747EB1B140D;
	Fri,  3 Jan 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896555; cv=none; b=eFQJJiJtOL9/c1QTnuyrG5K2yZR8D8F2kWoBqCaBF9WTQIqTHdZtYbZ1VCqmQlcJqJJy480UxpSA6nxbWvEpfW357M0fhW31kTcaplOVr8v7mXtLVcUkghPvg60VO1ihEETn74EfoOzUnGhbYHESuaKk5s+FIVnOUymDxzfrQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896555; c=relaxed/simple;
	bh=1EkZCsAiRqfDtZ/Tc5fh3hJ4LLDdivzPZL9UBgudwok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sK5DOhV+7yPmyEutAXdHmeOeoWs/zNKaBzesjtNsrqwejjF7CtBUdY2eRiCFaloPGMGXQ7jEqPMY8Kr2D1dl/sBiYlHHjHMAVZa64Q3NgNId35ccvx+buRCs1XTSnGrMk2naaItcXzn9OZT0j2X2YA4mXjyyligwOkKPiwSfaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E+7p/7rM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735896551;
	bh=1EkZCsAiRqfDtZ/Tc5fh3hJ4LLDdivzPZL9UBgudwok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E+7p/7rMe4PAa4LM0kSw8xzFdN+zGRyjxWOn0lMCpc6E2VjQmqMlsSsOc7ZPoq9p7
	 QUcSdel8jDfuhfVtd44c9joi+Wq+hISPPU9BC3DaukPhTW74UzwDaLgfAUfBhgxkfn
	 Vv+Vi3todqQ+24cPdz8kCtZyMH5zJHqkxycW3vD/lTRzAV+QL398IA3lGEUW/ABchI
	 XWuakUiYXp8JUy58jU2HjH+gCDtRrTlfGAtdL7o88vJ0ed86/sbpeLsuNsbY4mguOr
	 XbsLLfU04ChKG2u56OUE7A09nqHbPuqhs0zn0dZeM0xinU1kdbiamAT7d6HY9qcnQq
	 FDX9X3i/53UEg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A6ED217E153E;
	Fri,  3 Jan 2025 10:29:10 +0100 (CET)
Message-ID: <9a874a5b-c698-4185-bb7f-f17245381af1@collabora.com>
Date: Fri, 3 Jan 2025 10:29:10 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] PCI: mediatek-gen3: Don't reply AXI slave error
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
 <20250103060035.30688-5-jianjun.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250103060035.30688-5-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/01/25 07:00, Jianjun Wang ha scritto:
> There are some circumstances where the EP device will not respond to
> non-posted access from the root port (e.g., MMIO read). In such cases,
> the root port will reply with an AXI slave error, which will be treated
> as a System Error (SError), causing a kernel panic and preventing us
> from obtaining any useful information for further debugging.
> 
> We have added a new bit in the PCIE_AXI_IF_CTRL_REG register to prevent
> PCIe AXI0 from replying with a slave error. Setting this bit on an older
> platform that does not support this feature will have no effect.
> 
> By preventing AXI0 from replying with a slave error, we can keep the
> kernel alive and debug using the information from AER.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 4bd3b39eebe2..48f83c2d91f7 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -87,6 +87,9 @@
>   #define PCIE_LOW_POWER_CTRL_REG		0x194
>   #define PCIE_FORCE_DIS_L0S		BIT(8)
>   
> +#define PCIE_AXI_IF_CTRL_REG		0x1a8
> +#define PCIE_AXI0_SLV_RESP_MASK		BIT(12)
> +
>   #define PCIE_PIPE4_PIE8_REG		0x338
>   #define PCIE_K_FINETUNE_MAX		GENMASK(5, 0)
>   #define PCIE_K_FINETUNE_ERR		GENMASK(7, 6)
> @@ -469,6 +472,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>   	val |= PCIE_FORCE_DIS_L0S;
>   	writel_relaxed(val, pcie->base + PCIE_LOW_POWER_CTRL_REG);
>   
> +	/*
> +	 * Prevent PCIe AXI0 from replying a slave error, as it will cause kernel panic
> +	 * and prevent us from getting useful information.
> +	 * Keep the kernel alive and debug using the information from AER.
> +	 */

Isn't it safer if we set this bit at the beginning of mtk_pcie_startup_port()
instead?

Cheers,
Angelo

> +	val = readl_relaxed(pcie->base + PCIE_AXI_IF_CTRL_REG);
> +	val |= PCIE_AXI0_SLV_RESP_MASK;
> +	writel_relaxed(val, pcie->base + PCIE_AXI_IF_CTRL_REG);
> +
>   	/* Disable DVFSRC voltage request */
>   	val = readl_relaxed(pcie->base + PCIE_MISC_CTRL_REG);
>   	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;




