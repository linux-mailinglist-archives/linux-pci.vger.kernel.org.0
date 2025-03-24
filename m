Return-Path: <linux-pci+bounces-24551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8FBA6E0D6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 18:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C99189290E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4352641F5;
	Mon, 24 Mar 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fmFS7HO9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC52641D6
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837436; cv=none; b=spuBKDXvas2898LBe4TDH9fuU0GVQ+P65ccApkz2uUH827PFRPrASYGe47mlnvnbNO8hQ78Y23I+i5ZTYI7YeyKGTTPG96VeMSV9rkqpSES0pqI3VJuvzEoI3jocqQYIZbxhFpstEgBSj2/TxIv1u0/wi8xEpPCd9NsdzA2r11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837436; c=relaxed/simple;
	bh=lqd9mgW634q7DcTAAmJU4y0Eo6khhw9KVi8woULxoj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/2gAjE6l6v4pWBWpdPQBfiLojjAU0UTq8k9jKOgLPzrzAePeo7LuHxVQl9h6P239RAr3CnnU5H8E/2BipONEi9eq0VlTihBjnhJTW1FSFA23kKz4AFVtDX3J8OteJPPGj7m2orNM9hLbfmnNTd2WaOynCFXeR8DfRPJ7g+8kA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fmFS7HO9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22403cbb47fso89208395ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742837434; x=1743442234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SnroRpadQs+73Z5A9Ek9rLWnGkVNNMMnwyBsGGz461s=;
        b=fmFS7HO97h0edVWVSxDoZv8Al1eZUMdYi5+kBIydGe6uVrYmuuPLI/aD5swL1RtaDK
         fAqMIOqVtHhJkgRp2j4OfXE7dHQRcCZNKXAr9gg64qiuupdxXr8g+5Xp9G7ZwfOH98ML
         lHHBv9LszMtbY8A+Gz21VeFYei5IAlHh34jORjOE3gZI71Lg37SHELNjpI5uiiZFUpFH
         voqDJx2sppMs/Tw+4qRNxEYgf/R+B143HMNI15+ciBCNRcf9pRpRgwxiBs/gBc4ntQx5
         FwOXd4NlVG66VRVswr2VFIpEkEkaVthmWL56IOVDNNzzb0UJhnD7yUy6hwmfG/J/FZnR
         xqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837434; x=1743442234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnroRpadQs+73Z5A9Ek9rLWnGkVNNMMnwyBsGGz461s=;
        b=ASZ6hn4FEl2FzONk29kDPDWWwfucCeDff63G2Ts6hDzb7WeYHKhbSqTFi7KwiLD+PL
         VQca3DNsTivp1xN9SEZN06X8SYuh6fu9Pqdl+b0X8Ikg9EFSDAtpq2cbpKJnj6izdXbQ
         w9FmG00r4TF8S5+ut3o3HuGniBLqbBKkTIRrxcL8LDLncTLqVlga776zZPK+k60USmjH
         hn+tQtysMG6dCQzPEK3lNnnbg1x9ez/AmedNIObrA371zl6dphaOzxULbSvA6rmenAmC
         di8SjcsXy9yN+NMkaSvkr5W6M62ES76Aaqi5ad+B0zpV4HMJg+6QCCHfnb0w9Yr5GejD
         UqzA==
X-Forwarded-Encrypted: i=1; AJvYcCUYHsmBuKnJh7SA/tkPJ+K0h3d3Z0Ey5pCBq4Ki3FlVQbvjCA0RU1VDGKzsYW1HYSvtQV7ha3gPGxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzs8oIyH4ABahAOzQBVyJDJiLHC1j6Zdpjd0oHUbj3xQpRpT7
	nkNBP6POORXNPEodw5jM/sA4sg5HljUyKqQwyX8MaqY5Cv4KTGYbNgyY1WzcSw==
X-Gm-Gg: ASbGnctL6oaZ9U8y1nIAHufQJM+nS6XhwrNYD3oGMLf1C5uksH4NLhvBPmawA83EBSK
	gWcdBMAC7wH70kFJmF1XLi2nbtU6fo5vxWhANww+pnaJgrL8fr5I0aD1ygGiYQPpJMcBzjaWJ3A
	wCxglN5EsCDs5R30MNgGuEDu/pIhPsOnGHlkmMMRJKmCHx2te67y0apUcFWwGzumlfP0mBUDudu
	WyzDhAOvR0lE6EQm6yeEJ40CvtqYROUy4C/snziodSg2scHndABgQ8mPR5lcMmUtG2A2S27HXmj
	GG/dt4YwdNtQUudOyP048P1TyiJ/usr9v/CkqH+TYpI14UyFx+ElIj4=
X-Google-Smtp-Source: AGHT+IFJCOVJt8P803wd2MA7JhfBhloa/XWaXKSzLJsxknH/vt3+SULEZbCYIKyBwnuGPda9wxAY4g==
X-Received: by 2002:a05:6a20:d81b:b0:1f5:67c2:e3e9 with SMTP id adf61e73a8af0-1fe4342cc6emr22747430637.29.1742837433231;
        Mon, 24 Mar 2025 10:30:33 -0700 (PDT)
Received: from thinkpad ([120.60.67.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739061598f2sm8309667b3a.153.2025.03.24.10.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:30:32 -0700 (PDT)
Date: Mon, 24 Mar 2025 23:00:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 06/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
 checking and debug
Message-ID: <x2r2xfxrnkihvpoqiamgjmvppverjugp5r4we7lcfpz6jloxzy@7kdfzxiwv2po>
References: <20250315201548.858189-1-helgaas@kernel.org>
 <20250315201548.858189-7-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250315201548.858189-7-helgaas@kernel.org>

On Sat, Mar 15, 2025 at 03:15:41PM -0500, Bjorn Helgaas wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> dw_pcie_parent_bus_offset() looks up the parent bus address of a PCI
> controller 'reg' property in devicetree.  If implemented, .cpu_addr_fixup()
> is a hard-coded way to get the parent bus address corresponding to a CPU
> physical address.
> 
> Add debug code to compare the address from .cpu_addr_fixup() with the
> address from devicetree.  If they match, warn that .cpu_addr_fixup() is
> redundant and should be removed; if they differ, warn that something is
> wrong with the devicetree.
> 
> If .cpu_addr_fixup() is not implemented, the parent bus address should be
> identical to the CPU physical address because we previously ignored the
> parent bus address from devicetree.  If the devicetree has a different
> parent bus address, warn about it being broken.
> 
> [bhelgaas: split debug to separate patch for easier future revert, commit
> log]
> Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 26 +++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h | 13 ++++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 0a35e36da703..985264c88b92 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	int index;
> -	u64 reg_addr;
> +	u64 reg_addr, fixup_addr;
> +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
>  
>  	/* Look up reg_name address on parent bus */
>  	index = of_property_match_string(np, "reg-names", reg_name);
> @@ -1126,5 +1127,28 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>  
>  	of_property_read_reg(np, index, &reg_addr, NULL);
>  
> +	fixup = pci->ops->cpu_addr_fixup;
> +	if (fixup) {
> +		fixup_addr = fixup(pci, cpu_phy_addr);
> +		if (reg_addr == fixup_addr) {
> +			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> +				 cpu_phy_addr, reg_name, index,
> +				 fixup_addr, fixup);
> +		} else {
> +			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
> +				 cpu_phy_addr, reg_name,
> +				 index, fixup_addr);
> +			reg_addr = fixup_addr;
> +		}
> +	} else if (!pci->use_parent_dt_ranges) {

Is this check still valid? 'use_parent_dt_ranges' is only used here for
validation. Moreover, if the fixup is not available, we should be able to
safely return 'cpu_phy_addr - reg_addr' unconditionally.

> +		if (reg_addr != cpu_phy_addr) {
> +			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
> +				 cpu_phy_addr, reg_addr);
> +			return 0;
> +		}
> +	}
> +
> +	dev_info(dev, "%s parent bus offset is %#010llx\n",
> +		 reg_name, cpu_phy_addr - reg_addr);

This info is useless on platforms having no translation between CPU and PCI
controller. The offset will always be 0.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

