Return-Path: <linux-pci+bounces-11742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3919B95425F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 09:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB37D28D75B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 07:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974F684A21;
	Fri, 16 Aug 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfSCbz79"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA178C68
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792108; cv=none; b=XHf03L8irfK8rBqDbuhkC8kry2CNUwKddUfE/REejXddLMfOmMlmYmSK2pWWOs5NYU3bMl08z0xjT8QwfeOO2MAuIpqHa3vznMmpTgSzw447W+uf3UsPUzpbeLgyZw3CUsztZWW7/qPxBb8F+bu9dX5dXzLrXwqcCV8vFEwBnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792108; c=relaxed/simple;
	bh=Rv/OHUhc5LdbTPeulj3MUNAxvxPKVylBO6YuH/ft0gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfwMCpPH4Ab7gdFiR2C9e/Hyxn8Fb9JH1FOfe8n0x9rp9O4mwvW5VjfKENRvE3fiAJk9UWoQCp7CBPZkjLm1Bn9zjrddb1SfMTbedPFOMP/hdK6tEx+Y5Pz6VnjL8ZtDLAUGHcCsQWwxJ8URUsVaClmH/8fhKOtV6CqefHFm64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LfSCbz79; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so1436062b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723792106; x=1724396906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ve53LZasd5GhenfxsqknMts/Bqu17WdDe0sjGg3VIPI=;
        b=LfSCbz79sZQDTvX7EpQW9ts+snaKHB4tpH7V9zoRG1irexyZtTzmaQkJJ+U9MY4uvO
         Oedkj8PXmZgUmQT23SzvPOJnQn7MXtNgA1CxT/lnn5j5fEGWMYFWJAD7mkx8zOc8SWnf
         1iixwNnwlAf609YLrdQJZNDH5FRWPoUKj4WOgGDAd9inu51ObVdjpGYexXccjYQyj4E9
         nR16fzcfzQzdih5udexsvcC583moIXpKjlbQ2dTnfENN6QgSNDBinru6Z7wcFQIepuaU
         1fvYwYb/D+xR4A3vGil1KRmSZ0ukuiafh88M6BnGHWwQycPoMa+WFdNAWA+UnD6KLaVf
         zwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792106; x=1724396906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve53LZasd5GhenfxsqknMts/Bqu17WdDe0sjGg3VIPI=;
        b=DlUesOtIgvA9jW93UhSgFDFGNDPudcoX5dyj4EkX/U5TCPmUZBeuja8+uu68IMjGl2
         X36bmehLF+Hw/XZ+JEfWce3unlUPYRzCbjNUKPw14p5Q6d+gsdtg4F/mc5uBTJZwz5Jk
         lwX5kwPf8kfIhTheirySY4jlDKl5knJn4xFrBKLxyojylRne1ObJWxdtFnthngYqQzP6
         jE6W3WQG0Xt4Ewxq1hGb9GRcXtpYvKBJ+DUKNoE2y4KvQ/MT94NKQB7F4cktD8sQhAbT
         UnOjy08bxgLrqrMChTMdWVNO/0hX5oWh2C0ZOwVcQ6yW8a/pKxOhr6Ipxx4Hd0t7Gu+n
         z+Sw==
X-Gm-Message-State: AOJu0Yxj3uB/1k0OvgL5yHNXURwGEMwHtW38dQS/6Qrv1CYMEUD4RDK4
	Z0hd211eLI4eFQ2crbcvNiiGZWJnrIdZEohM2qx2OB0f+kkfE64349aitoiQPA==
X-Google-Smtp-Source: AGHT+IFIhu3GdVi4RmTqJVC1P3RARmFgEfcXYer0ZF+yIp/ekUj9mGEbkpI/lQd4eLxaKU5b1ekuHA==
X-Received: by 2002:a05:6a20:c896:b0:1c0:f26e:2296 with SMTP id adf61e73a8af0-1c905059c78mr2221508637.48.1723792106317;
        Fri, 16 Aug 2024 00:08:26 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c74e33sm1058237a91.39.2024.08.16.00.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:08:25 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:38:19 +0530
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/13] PCI: brcmstb: Use swinit reset if available
Message-ID: <20240816070819.GK2331@thinkpad>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-7-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815225731.40276-7-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:19PM -0400, Jim Quinlan wrote:
> The 7712 SOC adds a software init reset device for the PCIe HW.
> If found in the DT node, use it.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index af14debd81d0..aa21c4c7b7f7 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -266,6 +266,7 @@ struct brcm_pcie {
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
>  	struct reset_control	*bridge_reset;
> +	struct reset_control	*swinit_reset;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -1633,12 +1634,35 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->bridge_reset))
>  		return PTR_ERR(pcie->bridge_reset);
>  
> +	pcie->swinit_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
> +	if (IS_ERR(pcie->swinit_reset))
> +		return PTR_ERR(pcie->swinit_reset);
> +
>  	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>  
>  	pcie->bridge_sw_init_set(pcie, 0);
>  
> +	if (pcie->swinit_reset) {
> +		ret = reset_control_assert(pcie->swinit_reset);
> +		if (ret) {
> +			clk_disable_unprepare(pcie->clk);
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "could not assert reset 'swinit'\n");
> +		}
> +
> +		/* HW team recommends 1us for proper sync and propagation of reset */
> +		udelay(1);
> +
> +		ret = reset_control_deassert(pcie->swinit_reset);
> +		if (ret) {
> +			clk_disable_unprepare(pcie->clk);
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "could not de-assert reset 'swinit'\n");
> +		}
> +	}
> +
>  	ret = reset_control_reset(pcie->rescal);
>  	if (ret) {
>  		clk_disable_unprepare(pcie->clk);
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

