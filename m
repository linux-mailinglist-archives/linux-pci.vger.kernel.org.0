Return-Path: <linux-pci+bounces-20584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF4CA23D57
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 12:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFD6188488F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 11:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB931C1AC7;
	Fri, 31 Jan 2025 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+Yp4+Hr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4E148857
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738324347; cv=none; b=Sz/B9AjW3Plb1xeeAn6JsTyPYGYGUcFQBHhJ2smtNk9UOlGoVVDIqp+Gm7HEzulIBZ0b2Z2ri/UtLJWtTeTMTpCJMdDdgHoEc0kPuKDDFWJVoMHOA+ZT2QVs2s/lQJz9BZb2NGfD3ixJRSrqtN+wmW92PJWpaBkRGFWktI8eUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738324347; c=relaxed/simple;
	bh=R7IUm3yNbdUQWx0gZ6ohVDqny0/UW1sc2ej1uPyjdY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1SJbLFpW55OzsQFOu7/G0YNQJ9PUxmaPAXvEqecS+ZW9me8RDBi+/dfCJLH0Tc2Pv2CTdCmoxgFq8Pr53H8VXi8KMSuZiGQp8sYiVfleDBUVEX6rJzqxI5d3Hd6DgT6HeILtmPKpIWkk+vw4uW/oTOZUmTfpPl4TGcXORR1ZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z+Yp4+Hr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f44353649aso2477194a91.0
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 03:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738324345; x=1738929145; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k7vfH4Sgbx8sGmHpacPWSYRXDbwnTm7hjUlAlA09Dfc=;
        b=Z+Yp4+HrXLB2FGy1WpS4cVTavcovAXoSGUGzWUC56kiUV3P0hj7QWvZPiU+4j8ipeT
         D9xrA+0st6EHyQgIctxDFdwakrTChJPiVdr+7+VhyOKM0CpXO91GTGc1T9E30bORGjwE
         QZZV2ngayIInSlJi5pXo7TftodHs1WhGyFCL9hEHOvdSHBDlI44RqPdASVJUGkYVri0p
         FhFRlK/pm4jUrfkrnDzCGUPq2tnUjXt3QwuNVGjN8cvn50ZT1s5ui6DBA347Buu8T73T
         /TmPBdrmVZ6v1yOATUx5NUVNa7i7Rff4wKP29GhhHQECfsfde1pkrU9J7OjwIyTR7zgx
         PbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738324345; x=1738929145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7vfH4Sgbx8sGmHpacPWSYRXDbwnTm7hjUlAlA09Dfc=;
        b=B33kPyCSneO7kDXXjAyBbYpYYfJXJiVFP0Olw6K139xpNj3Fk45XlEFSjsx89SNzz8
         Z7o874aoq5xmQ7UjO3+e69tOQ1fLUIE4IQF1e4Wfef88u4+BZpUOlRPgRbQESFgwnMKd
         2V1V1t2Grtrhre14s202nvobFu2aqOHfYTKNF6Hj9vTQ1uIJpjRvI7LmQgAW58PKAQTw
         LyswBotQvYzQc4+IMQDmEcuUiWwQZnl+iALxYRqGzS6Cd1DNBK6Dfr/rJi044NnbukT9
         Zwqlun8yyJ4PdCyN/Ff97sdbU0ahNPRKlAztThPxN3lzVwgjXDl+Z9OMmAIyogLu27hc
         7GwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpbzLPGCT/lkcRJbGd30d4giXX6qiT1YgO+xS79H/Ms3kS8DVlnmK/ES7xYRxSKRMN0p/EEUUkrCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2y1yJNoL7AwXiXESL6E7F5hCVLrEFsXaEcARgxnxn3JvpGAr4
	8PWx1lIsGFpKENEZhkvZhig+J1SFXMYcZgXl5HTVBfQzmwW+gDGOqs+ndue98g==
X-Gm-Gg: ASbGncugEyu97AGtK9S0+gvPwnXeUbh40gpkIT8CMa4oaIESw61dF17RCywJ68hAM4n
	mz/FIA9jpHWHVwkMzB1qPhBwneyBEwEyJaIzz3Ynf/zwpfjijcERg038FkfKYFs2D0bsUbIqCJj
	oAxduow8vy0wcugIeD0A90uFWk+Sa3ZBTnwUBE7BskBYAlUAr5CGGsCyjB4jnOPm6WgQjC60pmf
	aZOAbCSzW3TuVhJDKNXHk4/TLHrB0/1xcaU5pApb0yr5IH/5JxAqpUNHyn0AiW740bcYF90nCi3
	Cf43ByhPUv252fJMrKj0WnNBlw==
X-Google-Smtp-Source: AGHT+IH8kZTc6caDBWl7vN/cLXEXPX/ziS+zmhHeSacd6exwy3GZEb1SvfXm7pZ6ALinPkamOfpQog==
X-Received: by 2002:a17:90b:520d:b0:2ee:dd9b:e3e8 with SMTP id 98e67ed59e1d1-2f83abd8adfmr15401669a91.8.1738324345440;
        Fri, 31 Jan 2025 03:52:25 -0800 (PST)
Received: from thinkpad ([120.60.68.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d2c20sm3368655a91.22.2025.01.31.03.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 03:52:24 -0800 (PST)
Date: Fri, 31 Jan 2025 17:22:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: brcmstb: Fix for missing of_node_put
Message-ID: <20250131115217.qu4ue4cfmdt7gudf@thinkpad>
References: <20250122222955.1752778-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122222955.1752778-1-svarbanov@suse.de>

On Thu, Jan 23, 2025 at 12:29:55AM +0200, Stanimir Varbanov wrote:
> A call to of_parse_phandle() is incrementing the refcount, of_node_put
> must be called when done the work on it. Add missing of_node_put() after
> the check for msi_np == np and MSI initialization.
> 
> Cc: stable@vger.kernel.org # v5.10+
> Fixes: 40ca1bf580ef ("PCI: brcmstb: Add MSI support")
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v1 -> v2:
>  - Use of_node_put instead of cleanups (Florian).
>  - Sent the patch separately from PCIe 2712 series (Florian).
> 
>  drivers/pci/controller/pcie-brcmstb.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 744fe1a4cf9c..d171ee61eab3 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1844,7 +1844,7 @@ static struct pci_ops brcm7425_pcie_ops = {
>  
>  static int brcm_pcie_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node, *msi_np;
> +	struct device_node *np = pdev->dev.of_node;
>  	struct pci_host_bridge *bridge;
>  	const struct pcie_cfg_data *data;
>  	struct brcm_pcie *pcie;
> @@ -1944,9 +1944,14 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> -	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
> -	if (pci_msi_enabled() && msi_np == pcie->np) {
> -		ret = brcm_pcie_enable_msi(pcie);
> +	if (pci_msi_enabled()) {
> +		struct device_node *msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
> +
> +		if (msi_np == pcie->np)
> +			ret = brcm_pcie_enable_msi(pcie);
> +
> +		of_node_put(msi_np);
> +
>  		if (ret) {
>  			dev_err(pcie->dev, "probe of internal MSI failed");
>  			goto fail;
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

