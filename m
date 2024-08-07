Return-Path: <linux-pci+bounces-11409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74729949E00
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 05:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95E81F221AA
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 03:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260C11C27;
	Wed,  7 Aug 2024 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUaT/j2i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4F1E495
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722999916; cv=none; b=S76sHJSp269XUBPh8nLRTrYudyEWSeUy5i055Bdu6kHTI7y+lYlGH/QTXn1UEoq7YsG15J2betMJPHswAbweXmH3rBjOzsb4okRDGatPjd4fnhMzmM/BC3AM6A0PYsMuHsxdAUZt1EpQUKN+xaAUAifTgLiw/CtjU+RNq7lxJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722999916; c=relaxed/simple;
	bh=IAFfJ1Li8XPBsF74nZL5cGbdPLoi9/uMZjoWpQfZvG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyIHDe5ax0eZ9teV9fbFqMDSNtXrfZW2ER37DNG+C/dczlfM5egZGyjd4tNM6ZcgQ0Mu744fE3e153kY53NGpDKYHKn7pVkJmm+hAWBJnMCLgCLUmoPzq0tslFLEKv8U8dTXn1SRuqBkj41S4uJHk3qyAlnc/CChmQ3peqoR57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUaT/j2i; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so949991b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 20:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722999914; x=1723604714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ktkwfuDEJhx5sflfI2OvQPuNv1Een1+08srx34A5940=;
        b=eUaT/j2iqmTe3DvqIWjTwkLHVaweo3IKD03oUUampQxO4EiftxeHSd2pBfUGJvvOrs
         q2SID8gxFFTkf78AHX9z5vk1tlUkc4GbX4qpEl98y+dXkZ+RvAXNxz707QFMfA+UnhQ/
         VL1xzFDco2aycXYaY39nzYlsURWjOc9YWlCj5QEHca8WqIEnoIjYkWu8QjyoFb1VxUbk
         qtC403b8TSdo1ezSzjPx4FimLYeR1BcB5lV2KBjzjHpd3cdQN/Ee+k8XYAgmxgCVXa/r
         BnWQOh+88V5I9ijDDZVyUT0MTYAgPuarVjvLXB7Cv1iXjtqe5LqeSIoR4MP4FoehDVrO
         kjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722999914; x=1723604714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktkwfuDEJhx5sflfI2OvQPuNv1Een1+08srx34A5940=;
        b=dJnGYtKZ6XGFuAkwY2OV/mwQaerUhRxmRnvKLdp7k7914+Vldkp9L2VQch00837+Vx
         fmlmoZBVoVMD5qe+L5kDj2uFEwnW+NkDzTCJmqDpEepWJDLrdooslyHHi4CUPnzy1Tz1
         WIL4zAd5tGSfoDO9u7BLMWpbbvt+p/lOr1lTgUYE9qvSSrurMG/GEePyQGCWbnLg8kgH
         suFJwKe5Ppw/sDYHAgW1hN2LBF+YNhw5f0deF6WjZXeLrpKnSqWel1kONWV9zGM+Z364
         DJvv2/D8N+L20u7z3w9ElVAR4YOATvlhabLyJLWlY8cLVrztGNcx7uK9+P0C/yDjmAUJ
         espw==
X-Gm-Message-State: AOJu0Yy+9zj4lCdciHMlFHVPhmntb2RmMp9dOqXeOl6+PTyNgaxlbfSk
	/CXPJ4h+Fftozoka4Q9PqCdXsMsQGwyZy3qsd7MeagOd7+96d92/Cq2D6Sl7pA==
X-Google-Smtp-Source: AGHT+IHeBBB9HZdLy26QExMAW0qOHs0KBnu6vbFxqKF47qSsZ46yR0Ql9vqC7kMPYTC0pjfebwTrUA==
X-Received: by 2002:a05:6a00:170b:b0:710:bd4b:8b96 with SMTP id d2e1a72fcca58-710bd4b964emr856276b3a.28.1722999913813;
        Tue, 06 Aug 2024 20:05:13 -0700 (PDT)
Received: from thinkpad ([120.60.72.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5cdsm7616512a12.2.2024.08.06.20.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 20:05:13 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:35:02 +0530
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
Subject: Re: [PATCH v5 08/12] PCI: brcmstb: Don't conflate the reset rescal
 with phy ctrl
Message-ID: <20240807030502.GI3412@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-9-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731222831.14895-9-james.quinlan@broadcom.com>

On Wed, Jul 31, 2024 at 06:28:22PM -0400, Jim Quinlan wrote:
> Add a "has_phy" field indicating that the internal phy has SW control that
> requires configuration.  Some previous chips only required the firing of
> the "rescal" reset controller.  This change requires us to give the 7216
> SoC its own cfg_data structure.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 1ae66c639186..4659208ae8da 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -222,6 +222,7 @@ enum pcie_type {
>  struct pcie_cfg_data {
>  	const int *offsets;
>  	const enum pcie_type type;
> +	const bool has_phy;
>  	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  };
> @@ -272,6 +273,7 @@ struct brcm_pcie {
>  	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
> +	bool			has_phy;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -1311,12 +1313,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
>  
>  static inline int brcm_phy_start(struct brcm_pcie *pcie)
>  {
> -	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
> +	return pcie->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
>  }
>  
>  static inline int brcm_phy_stop(struct brcm_pcie *pcie)
>  {
> -	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
> +	return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
>  }
>  
>  static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> @@ -1559,12 +1561,20 @@ static const struct pcie_cfg_data bcm2711_cfg = {
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
>  
> +static const struct pcie_cfg_data bcm7216_cfg = {
> +	.offsets	= pcie_offset_bcm7278,
> +	.type		= BCM7278,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
> +	.has_phy	= true,
> +};
> +
>  static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
>  	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
> -	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
> +	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
>  	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
>  	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
> @@ -1612,6 +1622,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->type = data->type;
>  	pcie->perst_set = data->perst_set;
>  	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
> +	pcie->has_phy = data->has_phy;
>  
>  	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

