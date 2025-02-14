Return-Path: <linux-pci+bounces-21489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E09A36421
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB927188CC72
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39269267AF3;
	Fri, 14 Feb 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbtqQaHd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52322267AF4
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553085; cv=none; b=bgvovNLF0dnTWFP/lhcUfvhe1Xvi7aqVHsMuUNg5POLbGsIzMd0uYSHxBArsvJoGwwt0nHJnUhc8totdGUR/gfLU/j0Tlo63pzLHRx0T/f6g4jqoD5phdq0VFcdJsWzx3EmsOkegPJFesHVPzjDQsnieElrDQxUfxVLI+WSi01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553085; c=relaxed/simple;
	bh=vKhQ0Ejpb1wonsO9UaPSQh12SdPS98KFnEQ3ynt/E84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0Va4lnFB8UlGx/r3hR8ssSii3ZzWOQaAmf9Y7PomN9sUBUm5W9FY6VY7SCh65T5ilmb++Pjd6GYzzZkNt/PopVskdWFCxW9wNGXlKIm/B3oQXbCTr7HTqKvsrAHHuy5PQJEAGrXwwLu1Z5Uhzhfh6MJ2NXYDWFtHNdktGCrQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hbtqQaHd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220e6028214so33589785ad.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739553081; x=1740157881; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5tFVk1CSr4Gjhn3uWBeLqopf2bxAI2GHatmkSuDvmcY=;
        b=hbtqQaHdkNutwcu9QORfpuG3Cz5cDTMaLg+OXRrAF7f7U7uJhNVUmxX85ENAoudiTb
         Bjv/ugb//IjapzJXCFBe8TEOnn6XSUeFCR+ytWM97IbIaWtC16bYzg17RljoWrkpCEyo
         BfoJsRsWQe7lO2EUpmtSPYhJliC3xEstWe8i6RyhrYX1LjszhTOKk3OzOJXR4b7V30o+
         xIbRIezgHW7gWVFIaGt1pLOAUskcTChRo6UlaVlvESlWhcZxzuli0wdFr1vpscPGwMuY
         DgBUrl3wUv+MRjJ/YI/ZqOKQF9ui47P5JSn0KYix8oN4NdlOHM1Htt30Wdkyay20CEUp
         KFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553081; x=1740157881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tFVk1CSr4Gjhn3uWBeLqopf2bxAI2GHatmkSuDvmcY=;
        b=glYh1oqPUrHW50Hindv3lduxBmNPqrdVVX0Ht0kDbdYiKZV+6OXfeRGjyQ7A0GCrfz
         0fmmPuzEQx3AqSqkkMl8ktSe9jv78CaIIKDwOOBUE0h5njz96c+XdEBkmNPXeyCtwZNf
         E+NoiT7S+ICB8kxIIbD2SMy8Q676A0PBdWZYHo3LXxsKY+iO9ooICAWDGDFHyULMiMTT
         8UUqP3mXrW5Z3QHIrXzqy3x3G4lN2ikU/jbDC0WI8d8zB5VLjidgoMCOdkGJ3afU+oxU
         cBxxgXrF5wCqB1/DV7gq0Ucu/taQuynUMQdeVkaKAlJf8HNypFYdmABVW6i9Kb2K6csH
         vSjg==
X-Forwarded-Encrypted: i=1; AJvYcCUGcTMXY0kduOZVdY9MNqZkmn1FCS4eZQCeN/qTETHz3+11pLQ5Tf3rbg+A7YlMMQeVqAaBu0voSv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdE0bpM+ABBftQirnOCPy/Gmp4CZiUhjziKuLvFGhbmF2VtnnJ
	URlSTTP8/7XnjILHbKB9UJ+y4Tu0nufz1TgVfrFm/XIxIUQ+OV1SboGhffUhJw==
X-Gm-Gg: ASbGncu3OLp0oJt/ltNbPyDEmv1txt5ZbXOUhOysuZN1lPIorbCWWBG815/E8/45FxV
	XyxhpPUJVv+J6wEukx/sDclNRHxlatfR9B1V9AEwJFSWS0NNdyaBBLzaqHTxBz12d0nylAAiqbF
	U+sFKxqSFkLWvBcWxiuxgki9h/TgZy3Q+mxtIpl1lbHcisAGKmaWD8NBBgEMlnBsLz7BeNCsOcX
	HQMXbVWI6vagor4X/iVdCfiWYHBtgftpB20It5QTGb5o8H3tG1jBaV5aDC0Qdt1I9YsScyRjJjc
	7+Fv3OM9a7rDfzeWUahViiyuv5U=
X-Google-Smtp-Source: AGHT+IFtRcsC8lGjgRbp1ycQlIbd0zSbe+MhBv3YgVh5mcJFxmhiI53DBGqspGZoSEm1cJUzqXNGXA==
X-Received: by 2002:a17:902:fc8e:b0:215:a05d:fb05 with SMTP id d9443c01a7336-220bdfee6a5mr208218855ad.32.1739553081492;
        Fri, 14 Feb 2025 09:11:21 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d09esm31064135ad.112.2025.02.14.09.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:11:21 -0800 (PST)
Date: Fri, 14 Feb 2025 22:41:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Message-ID: <20250214171106.ul3fwzcwhadhdwhj@thinkpad>
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

So this is going to regress the devicetree's that do not define this syscon
region? But I do not see any devicetree using this 'airoha,en7581-pcie'
compatible, so not sure if this is going to be an issue. Are the downstream
devicetrees used?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

