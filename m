Return-Path: <linux-pci+bounces-16819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5526D9CD7AB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EF61F22B54
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D8E18871E;
	Fri, 15 Nov 2024 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyOdYdH4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24869126C17
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653013; cv=none; b=pcr9pH4/ATr0zdgkQhQzWGTAVxrpAZPjevZ9EOQRFds4oEU/Cm7OUToeLplN4QMuF3A3WIQIqITxfLT3TRvFaNt9bY4cdVETD+kNrgkO2VvAXetB+OEhkw6100ptZaSBzV3ixTUfifF/Ws1fOPTbxomXiUGcYAwE7UKObRU1b9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653013; c=relaxed/simple;
	bh=yFaqn0TM8DwaMrQ+sb2LpKFQLJb2yjVSUuadb+2rd5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovi+z5oAreU7uNHlMgxdenZgIS2MvBq7HgkTTTO3ci3R4FZchThaY5znnE1WUx66KWus1zNHfOBiqnnBhmTrslSGlqBRHpOU3de9XrrLlxIZPCnJKpIHeVoaAwMabAUEamZwGXu+5VsRuYPrn5rgxcMNX/z6+HcZOBCG6tOCePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kyOdYdH4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720d01caa66so398253b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 22:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731653011; x=1732257811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3MYYRbyHSKnkKj/U1ajnAZh9FgwdbjyrEbwmDmiOJ74=;
        b=kyOdYdH4FVy8vMZ56AMJxMs4RtvvScdwPMENwzkxhZccHSGf//BLvjBa+yu23R4Dc3
         yfOOhIA5Sh1+xV01rwVt3iWmYxUsbRvFVK4beqZTPbknq/y4cOrkRpV+9Ob/mFfTzZyS
         WUp0673qb4kYWaZwl6G05bky3lByzWmbrad8hNajaKRII4vUa9uzAlTR4WYGbf3BYm3H
         fDtycpnE4Xn2v8iwJOAP3/Obq1mTdY2pxmcpmjbDMi71opciRjopHIKhG/mIpIpkWYSo
         2mE/akYEFdYHDVT2x71XBU69QW/q/wX2HIyzt8AX6N32wooRpQE9FLOic7ruJ6t0LTyD
         Poug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731653011; x=1732257811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MYYRbyHSKnkKj/U1ajnAZh9FgwdbjyrEbwmDmiOJ74=;
        b=NZJb90CnTIRREjeMUoqF8tHOrNGnqTFBu7L1UfIc3NOBeGtLh+s7OogXJXfmmx+Sy/
         9kzzUmPVwCORU+zDMsVOBjE8L/W1TchEtG7xM/sprnTdwwKiMbJUUxmqWU2VARNA6L0B
         AUVR168t5fo5VRChDZeS2LZccb1b/K0fAZqFTt5NncneRaBRib+fZKsEAilQOsA7r7Q+
         oDKOgJRV+eue0f41thxqyN8ExGTbeqi8whHhfXFJVG2UmrOkir/M14e5t6Ao2NEDf2N2
         OVzBHhxHnkQCSXGLe1A9CR3HE+buaOb4DpihV6rvBym7qxIulnmidcryVyHholIl5irB
         MztQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYgEhV8LJ++l2gY3ahrJbHeMFVB1AEWFvX1IGW6VcJHq/hfCc3+dlE2HMeHJzVxj3oEd//R2pplWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcp/WhtwuKB9kYCmnL6ic1/x07c+5jWZIUfQ0cMunY7XMqLRr8
	UJTgaLSiC5SRB3jaYwb7+AseZiqtIvoZUhs88S0HvjiJ41wjw6NuGxzGHj3e5w==
X-Google-Smtp-Source: AGHT+IHY6v9j5fvHwvuygpXSp/ldJste9oxVxyRTDqgsgbIZ7G245t9I6FYAct4vrO9HjSZAZqBz4Q==
X-Received: by 2002:a05:6a00:22c8:b0:71e:4930:162c with SMTP id d2e1a72fcca58-72476b872c4mr2212375b3a.6.1731653011440;
        Thu, 14 Nov 2024 22:43:31 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee7d3sm673330b3a.38.2024.11.14.22.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:43:31 -0800 (PST)
Date: Fri, 15 Nov 2024 12:13:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, frank.li@nxp.com,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/10] PCI: imx6: Correct controller_id generation
 logic for i.MX7D
Message-ID: <20241115064321.3cuqng7bzmphiomw@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-5-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101070610.1267391-5-hongxing.zhu@nxp.com>

On Fri, Nov 01, 2024 at 03:06:04PM +0800, Richard Zhu wrote:
> i.MX7D only has one PCIe controller, so controller_id should always be 0.
> The previous code is incorrect although yielding the correct result. Fix by
> removing IMX7D from the switch case branch.
> 

Worth adding a fixes tag?

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> "This is just *wrong*. You cannot hardcode the MMIO address in the driver.
> Even though this code is old, you should fix it instead of building on top
> of it.
> 
> - Mani"
> 
> IMX7D here is wrong athough check IMX8MQ_PCIE2_BASE_ADDR is not good
> method. Previously try to use 'linux,pci-domain' to replace this check
> logic. Need more discussion to improve it and keep old compatiblity.
> Let's fix this code error firstly.

I really hope that you'll fix it asap.

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 462decd1d589..996333e9017d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1342,7 +1342,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	switch (imx_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
> -	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx_pcie->controller_id = 1;
>  		break;
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

