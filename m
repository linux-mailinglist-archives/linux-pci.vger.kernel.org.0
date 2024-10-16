Return-Path: <linux-pci+bounces-14684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9669A114D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 20:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A0E2862A7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23598212F1B;
	Wed, 16 Oct 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUkHMZCx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43FE20F5C0
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102338; cv=none; b=Urgoj2hGEJl/pf+U2Pl+pGNxU5FGily4Sqob/S/3PC1AqLM2YMl5RZtRcih2CbW8xAaYEUx7vkANnDddbi59gkyH4xrVUSeeMcj9It8uBrg0S9RJe7nNxZdsuK25Nj3qAIZFDNrE0ACPDFEVCcvUtCIi7PnYJ6ulSRsUJE8U9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102338; c=relaxed/simple;
	bh=pjBU7bP0Uk4e/xSSM+yH9JXOnBNOap5sy3aYwNVqicY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQE87rBDPnYC6Je7gfns8O7fATxGMXNyEUtbuT2iheo0Rf1pCmBJfn/aL1a79xSLxSPuX2ubqqkPI7PB0Bir5u5+fiFy9g2V5rgp9Yp1DzrJKVLPtyvkbzTshR6+7tDlDjXEiwTkIEPNxrIGaGrrDr/TxZzaiPS6pfKoiiHoGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qUkHMZCx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca96a155cso735735ad.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729102335; x=1729707135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AGUSxJLSmS2t2McaXLEaoam4uNrhNWjevpowsdK4u6E=;
        b=qUkHMZCx5UFeKeXF7+YL0+1ixLiIjmk8KmhuYnb9ijznA5NmHe6zNBdqakdiRikY1g
         cHbCwRH6CTzEcAtc4n37NSleVWAauU0wUZw+z6+kRMZVFc/v2V+H04ti4lROWmKx48nU
         QGsxwvYmFd3KH1oRMVAFzktI7tWXgGOPuVO+vgWPyVvdWqFPuIHBgMHbZdb6SLGiiXvX
         //OUWaWuMEYKiDqi4Zgs4TI9+Jw22/6fmlMKgts6/H2nhUqS60CxzEO9YQ1zv+HAZRVq
         deKEqRK30ry5e+zhGk71HHunfhS6VRy1Wy2idy4sGTrvLhNxn8hYyCjQoCgdwQZLOcSv
         aB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729102335; x=1729707135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGUSxJLSmS2t2McaXLEaoam4uNrhNWjevpowsdK4u6E=;
        b=aO/bdZFTRkNBHXbI/RVWo6xQCIOzbXXaGSj9Q4TCr4t8/po19QbEwHrOM8v1UsWm7C
         r0hs/9wX818voPl45K90smvM2yDJfLQxWFl1PB0uXb0kqqflxyCOf7FInTDPQk5FyGUj
         AcsgDV4GvB0bb4MYllvvQVr5PllMFqDcuFcBSxkHMqh0wRSf6aUtsUFjWCAshCMtQ3ng
         YO35PGrflmOt2UjgLh+JH8xdQ5A2VKuec2nhGkCXxEZlUaUQxtEQ0ADaa0a1OoU2MNzK
         x4mQzZzAz3cCWDQf3RqganSCMDSUGkf3U6Y61HpWwU4pbQ1SgZRY+TPjb0CGYxNgOLCO
         B0jw==
X-Forwarded-Encrypted: i=1; AJvYcCXxPbAuKA33B6+vzC0RSb0k8ESF7PEMSOMiEc+2TLwKjJSv23s1aL1TzTUlXR4szxbm3YMnIN5YiEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HqIZF2auYrV1JVjrT2egexJNlp4BDp/yhLw+7iCFfyVYd2nG
	FK65W7Mk6ktI1U+i/LRv31JjdC9I/eGHey0Ky3z/SkklucdjxHMAsAV9NiQIyA==
X-Google-Smtp-Source: AGHT+IEC4f0FCA7jD/T3S9Y3FpFfE6YgpsYbswvi8qmMeUEzDMbMadrb3Bae263HJGs3xq7PNu5TDg==
X-Received: by 2002:a05:6a20:d80c:b0:1d9:1c20:4092 with SMTP id adf61e73a8af0-1d91c2047f1mr608016637.16.1729102335093;
        Wed, 16 Oct 2024 11:12:15 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774d2a0csm3376997b3a.181.2024.10.16.11.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:12:14 -0700 (PDT)
Date: Wed, 16 Oct 2024 23:42:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: imx6: Pass correct sub mode when calling
 phy_set_mode_ext()
Message-ID: <20241016181207.qhjkhz266quak6ve@thinkpad>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
 <20240923-pcie_ep_range-v2-3-78d2ea434d9f@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923-pcie_ep_range-v2-3-78d2ea434d9f@nxp.com>

On Mon, Sep 23, 2024 at 02:59:21PM -0400, Frank Li wrote:
> Fix hardcoding to Root Complex (RC) mode by adding a drvdata mode check.
> Pass PHY_MODE_PCIE_EP if the PCI controller operates in Endpoint (EP) mode.
> 

Patch descriptions should fit within 75 columns.

> Fixes: 8026f2d8e8a9 ("PCI: imx6: Call common PHY API to set mode, speed, and submode")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 808d1f1054173..bdc2b372e6c13 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -961,7 +961,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_clk_disable;
>  		}
>  
> -		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> +		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE,
> +				       imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE ?
> +						PHY_MODE_PCIE_EP : PHY_MODE_PCIE_RC);
>  		if (ret) {
>  			dev_err(dev, "unable to set PCIe PHY mode\n");
>  			goto err_phy_exit;
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

