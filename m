Return-Path: <linux-pci+bounces-21832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD99BA3C7A3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A3717E06D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410621519A;
	Wed, 19 Feb 2025 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5NtC7Hm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6821481B;
	Wed, 19 Feb 2025 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989620; cv=none; b=kzUqzRQlCQNK7gW4f6aqoVUP7UCtpkYQinaOwpicHgKlf3fvgBD6ytOI8zVh64X2JK1vlAWRCKuVP56Sddx+ce0/lB8/LcLGOHBptk5LpNFauUVTh13sE9KwdRAs8R+mBG35KwJxCxJQ53O8oMBRIHQitCEHHjkvmZl0Ej1rlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989620; c=relaxed/simple;
	bh=sKmUoYnW4UEhcRUdgQh6f5TeK27U5t+wS+GMuUa4uMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyBybhCgKW8lG9PN7A+CJ1NjHPaMt5GG4dYScxmb6KEOZr7XnGqQKibcsusb1/31KFALDAHXvY/dMGq35mMMOKDRuoaoO40EX5+G6JYgVQQF5Diem9ACHpKxPRUpTX1I4TXCU/JyoVeUCmp+v8dIOSgD6xZcJXD3inrx61jGhuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5NtC7Hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD40C4CED1;
	Wed, 19 Feb 2025 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989619;
	bh=sKmUoYnW4UEhcRUdgQh6f5TeK27U5t+wS+GMuUa4uMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5NtC7HmsBVbNsePYWhw98WxAvLmLuJimdX8lQwOobH0N+jGMNqJhY4ah8sJN9wN3
	 bdRfu10DyAOM+6fUsN6l6J4HWJG9SpdgAbu5Pgk7lSnQTzbD91WqTal4Hw2fgpZsqX
	 QvrhGjy+V922k9ZEoVyObaz/G6qkwaKyOU6hjxxRzlsbfW2K0vGbmrd388umDtJRiE
	 E5GkJ3SbkrqUwvlUp7ktHcXtghhP7M9BDlAklUe8h2IAQXYHQcMpCMghNAPURKQX2i
	 HjdZC16uvcSRUk/wIwS2D+lpGaJl9QGeIkKN2ftPd08rW8cxjD/sinWC4dPKDmPSHL
	 +/2Bp1r4I5ilQ==
Date: Wed, 19 Feb 2025 23:56:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Message-ID: <20250219182650.gxzlbl6ovgbacmkm@thinkpad>
References: <20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org>
 <20250202-en7581-pcie-pbus-csr-v2-2-65dcb201c9a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250202-en7581-pcie-pbus-csr-v2-2-65dcb201c9a9@kernel.org>

On Sun, Feb 02, 2025 at 08:34:24PM +0100, Lorenzo Bianconi wrote:
> Configure PBus base address and address mask to allow the hw
> to detect if a given address is on PCIE0, PCIE1 or PCIE2.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 30 ++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..9c2a592cae959de8fbe9ca5c5c2253f8eadf2c76 100644
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
> @@ -945,6 +955,24 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	/* Wait for the time needed to complete the reset lines assert. */
>  	msleep(PCIE_EN7581_RESET_TIME_MS);
>  
> +	map = syscon_regmap_lookup_by_phandle(dev->of_node,
> +					      "mediatek,pbus-csr");
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	/*
> +	 * Configure PBus base address and address mask to allow the
> +	 * hw to detect if a given address is on PCIE0, PCIE1 or PCIE2.
> +	 */
> +	slot = of_get_pci_domain_nr(dev->of_node);
> +	if (slot < 0)
> +		return slot;
> +
> +	regmap_write(map, PCIE_EN7581_PBUS_ADDR(slot),
> +		     PCIE_EN7581_PBUS_BASE_ADDR(slot));
> +	regmap_write(map, PCIE_EN7581_PBUS_ADDR_MASK(slot),
> +		     PCIE_EN7581_PBUS_BASE_ADDR_MASK);
> +
>  	/*
>  	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
>  	 * requires PHY initialization and power-on before PHY reset deassert.
> 
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

