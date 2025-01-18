Return-Path: <linux-pci+bounces-20096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D12A15DDC
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 16:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6806C162C3A
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD8B194147;
	Sat, 18 Jan 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTkF5yqs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139C1422A8;
	Sat, 18 Jan 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215969; cv=none; b=qipdyGrR3mS/Zy0TmGtNgsv6Wvns/DuoTAqXUYoGBgIxGaKvDfTwvcXwahuzX3AFpvwtfzK2ks7hrobdKAzkcV6cVaC219jhGlPVFwCAAXnotERUF3B7MXsL28IOoVowrM+bxyvEZLM/3o6ggKeYKUDOxrPHm8rX43z2G7DEJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215969; c=relaxed/simple;
	bh=IaiMji2J+wNsi+lZF9jRgBbHV0fmgZ5Rfl2G9E8eLog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzA4iPOqN/x7OSE5eAou7kEwcyCsoSD3oX6zvInNUlZHlT2EEOqTAk/wejjxeUPOfxxsJxZQLRJun7BR99cMajzq7+5xPid0sv80cNFIFUvFGftqo5rvYpzRfHhDKPyXJ1M/VcfC2b1W2ifaYThxZf4Yyg4OPk+A7YyBADxqoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTkF5yqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D378C4CEE2;
	Sat, 18 Jan 2025 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737215969;
	bh=IaiMji2J+wNsi+lZF9jRgBbHV0fmgZ5Rfl2G9E8eLog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTkF5yqsyfeRrQm301uBUPxhaSQuHtzFBfEVrQAg7/21BZDHf7rj7f4pi6vhzojPh
	 B32/5BE0XLVoaLvHOQdlx2OaA6txzIhURWVuhuUd1Ihlj6X//hQmoI1x5AxW60lVaH
	 S1hb3zvx+zWEqqNkas1PXHcfU4ouTixJU3mpL94nE2L4zNHtIiv+GR800dOVVcJ+Cr
	 wd7Qe4x48pqUf7rQpB9NEdPL1v/SYSd7VrZ1uu/lde9SaBlmHFggEcd85W7KWg7v9w
	 0+8uieX50dWUCOLE6OJ5dQDiGgbR8fFy40dG+t9bNljEhOZcnUYnCwRXFlmhz/bd0/
	 yWdAYmCgIlCdA==
Date: Sat, 18 Jan 2025 16:59:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers for
 EN7581 SoC
Message-ID: <20250118-astonishing-ermine-of-painting-4d3eaa@krzk-bin>
References: <20250115-en7581-pcie-pbus-csr-v1-0-40d8fcb9360f@kernel.org>
 <20250115-en7581-pcie-pbus-csr-v1-2-40d8fcb9360f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115-en7581-pcie-pbus-csr-v1-2-40d8fcb9360f@kernel.org>

On Wed, Jan 15, 2025 at 06:32:31PM +0100, Lorenzo Bianconi wrote:
> Configure PBus base address and address mask in order to allow the hw
> detecting if a given address is on PCIE0, PCIE1 or PCIE2.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..b172a46cf95a9c728291c5b7a88457d3b725681a 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -15,6 +15,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_device.h>
> @@ -24,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  #include <linux/reset.h>
>  
>  #include "../pci.h"
> @@ -127,6 +129,13 @@
>  
>  #define PCIE_MTK_RESET_TIME_US		10
>  
> +#define PCIE_EN7581_PBUS_ADDR(_n)	(0x00 + ((_n) << 3))
> +#define PCIE_EN7581_PBUS_ADDR_MASK(_n)	(0x04 + ((_n) << 3))
> +#define PCIE_EN7581_PBUS_BASE_ADDR(_n)	\
> +	((_n) == 2 ? 0x28000000 :	\
> +	 (_n) == 1 ? 0x24000000 : 0x20000000)
> +#define PCIE_EN7581_PBUS_BASE_ADDR_MASK	GENMASK(31, 26)
> +
>  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
>  #define PCIE_EN7581_RESET_TIME_MS	100
>  
> @@ -931,7 +940,8 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
>  static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> -	int err;
> +	struct regmap *map;
> +	int err, slot;
>  	u32 val;
>  
>  	/*
> @@ -945,6 +955,23 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	/* Wait for the time needed to complete the reset lines assert. */
>  	msleep(PCIE_EN7581_RESET_TIME_MS);
>  
> +	map = syscon_regmap_lookup_by_compatible("airoha,en7581-pbus-csr");

No, don't sprinkle compatibles in other drivers. It does not scale, does
not allow reuse and you kind of try to escape ABI break, but you won't.
This is still clear ABI break without any statement in commit msg and
without explanation.

NAK.

Relationship between devices is expressed with phandles. There are
plenty of examples how to do that with syscon.

Best regards,
Krzysztof


