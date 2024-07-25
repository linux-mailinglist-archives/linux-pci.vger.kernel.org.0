Return-Path: <linux-pci+bounces-10759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F8593BBEA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9861F212A2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E75318C3B;
	Thu, 25 Jul 2024 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDUsENMV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865111799D
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883576; cv=none; b=g3wr7PDeZ/5xoIj64enitU++aZEfNC/pXRFf1K+5HItpS15ednbNOty543xigkfG/Dl+0r9LACXCfhLNz0NIeOAO2dGkYddnLDGu86siOVIj8GefAMp46BQNEUvwO6f3CkTHwRnx2P9Eh2tEPIMU1DKNL1oWCaL2cpCdD+OcKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883576; c=relaxed/simple;
	bh=lYCeW558nXoKbT0/XRIvKC2MyCW8u8hryqq2BNBKUCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkreMGzWNpLkfH5O58o4H10NXQrS8VDCV/Os6iELtNrr7r5HbkGZaU63EZRIOwnAaCE2lqh5XLD27JDRmdN4Seu44sNpNv4Z8tkprLP8/2sbeNbXiU5v7iI6Gx49CG1YUxuCLa1WB7G1mI6VbGMKPTNWEw0GIcbzOaEETJNmgfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KDUsENMV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a130ae7126so399557a12.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721883574; x=1722488374; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5dcA9JBHUbgUtUGlvPZ+d1i2R/fvuDGRFExDVQlZWo=;
        b=KDUsENMVpzRLGNm4OXFpPiE+T8wl5ghS+mLqTXtLG9X8M2O62UX8sfdbxPI0wHyvZy
         Bm08WYaxp2ptPfjMLe7XLQWS72no8OF8ypYIWtPbk5t7hmlcumaXpd+klzPgGuHmOJse
         hD1i/BzefevTS64UQBWBhRlX+hrBEMrjQHSv4mbCKVrmgAu6ZAMt8LOnUXLnHOuCwuCS
         WOF7PrqYZrrQfmLfpXyniLLAJHF8lkiSC55uAytyqb4gZkw/KpQEy4asgRZyCIiMYML7
         fmPyGYwJ8lnWAzxN8x2ky4frR1SKIbI7VZbFeckSu8cn/jOh+HBxYZ3umrrVZXKl4uMq
         AsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721883574; x=1722488374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5dcA9JBHUbgUtUGlvPZ+d1i2R/fvuDGRFExDVQlZWo=;
        b=OV1jq5OHwzbH8eIslH08jSAc9+MKJU51h4lca1CM7P4oRgfGUXPU2hMRpCO/bRD1kl
         e64uOlfXG+YpVYyEiNrhqrcSDih+NOWu65X+8oxePICNkwBHEWJx3ZSCMJFEV3TOx3ZZ
         0D8drJNkt2Ct7Jqt5X5skkdNRToXiwSzAjibNx8yY4YPiQgizlSomgyL7K6HVuL5NpmU
         nhnOrfrZYO8e4f0fcyW0VYmtfr5buCUiv0XcrrRW0dXw+vN6nq688c+Z3CPlHpcFgUlM
         zY1IAm8pLuyEJPAFJgxP+hP2ua1/sxUwW6aUU98xms11sCHtTh83j6NmsEm2i9PANnF/
         lWBQ==
X-Gm-Message-State: AOJu0YzMB6PJNLGuceYtTzKxPtzXIHLogk3/DGCHhu/oo4j4R0jIsqkl
	Q4Hd+V0f7hjQUZVjbeOguO6xB88MpzOpWyuLPWGuPeAxialNxFjGWaF1NMFoZg==
X-Google-Smtp-Source: AGHT+IGMEfl9npbHWomGeCCHNpA8vlU7101iyR/8qjyjEaFN2MiYxoZZQdRxZ22z7VT+wFZkyHbdoA==
X-Received: by 2002:a17:903:2349:b0:1fb:8890:16b4 with SMTP id d9443c01a7336-1fed933a089mr8658505ad.48.1721883573726;
        Wed, 24 Jul 2024 21:59:33 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9e8fcsm4398215ad.249.2024.07.24.21.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:59:33 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:29:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 12/12] PCI: brcmstb: Enable 7712 SOCs
Message-ID: <20240725045928.GL2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-13-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-13-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:27PM -0400, Jim Quinlan wrote:
> The Broadcom STB 7712 is the sibling chip of the RPi 5 (2712).
> 

Could you please add more info about this SoC? What PCIe Gen it supports, lanes,
IP revision etc...

- Mani

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index fa5616a56383..7debb3599789 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1193,6 +1193,10 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
>  	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
>  	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
>  
> +	/* 7712 does not have this (RGR1) timer */
> +	if (pcie->model == BCM7712)
> +		return;
> +
>  	/* Each unit in timeout register is 1/216,000,000 seconds */
>  	writel(216 * timeout_us, pcie->base + REG_OFFSET);
>  }
> @@ -1664,6 +1668,13 @@ static const int pcie_offsets_bmips_7425[] = {
>  	[PCIE_INTR2_CPU_BASE] = 0x4300,
>  };
>  
> +static const int pcie_offset_bcm7712[] = {
> +	[EXT_CFG_INDEX]  = 0x9000,
> +	[EXT_CFG_DATA]   = 0x9004,
> +	[PCIE_HARD_DEBUG] = 0x4304,
> +	[PCIE_INTR2_CPU_BASE] = 0x4400,
> +};
> +
>  static const struct pcie_cfg_data generic_cfg = {
>  	.offsets	= pcie_offsets,
>  	.model		= GENERIC,
> @@ -1729,6 +1740,14 @@ static const struct pcie_cfg_data bcm7216_cfg = {
>  	.num_inbound	= 3,
>  };
>  
> +static const struct pcie_cfg_data bcm7712_cfg = {
> +	.offsets	= pcie_offset_bcm7712,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.model		= BCM7712,
> +	.num_inbound	= 10,
> +};
> +
>  static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
> @@ -1738,6 +1757,7 @@ static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
>  	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
> +	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
>  	{},
>  };
>  
> -- 
> 2.17.1
> 



-- 
மணிவண்ணன் சதாசிவம்

