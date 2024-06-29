Return-Path: <linux-pci+bounces-9441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243B391CCAF
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 14:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9082A282623
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB322D05D;
	Sat, 29 Jun 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYmf9NGz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507FC7CF18
	for <linux-pci@vger.kernel.org>; Sat, 29 Jun 2024 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719663790; cv=none; b=aerU2tEQl8dEASR4jJrooX+UkRZ+vH2JDSpmc7e2r4nq4P3PEIG1dScDrrmXSRBHgos/rPuu2+CQapoOU7xHdpUja1/9sWaMx59lmna0Z35EfuJwcKfbocbZeGJWIfmb8o3CsFdOW5E4OyFMQuorFwFFld5jwIFxBzcucGNbWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719663790; c=relaxed/simple;
	bh=0y5cSgtBlkamEEyslLX8DfwkBZ+qF4qV5H9+Ndn+Qw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJKeRmmp7OA2RniAIb3k4rh9LsS1zFwlAR6n/pPb2SCX2vchJfd2PmAxSMSd4Ryik9GBG18fn3NkX7gKjaIEj7urRwEk1ZRlkHUc+Obiz/8ab+2NxTaSszEl7C0+McZddR/1EEMkzWvp6/QD6+5Qg0MMFITpgVrRbuLkowz06rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mYmf9NGz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7065a2f4573so1106325b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 29 Jun 2024 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719663789; x=1720268589; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hd/fN6JrXuuparzKe/1dgdm1z2pqZRQTyP5PJ9H207I=;
        b=mYmf9NGz4AEE4ghG7AT/o31qdXDXd3KNh2La/mgNpSBZK+uhD1bBl0P2aRsNV7F5w8
         V4EPYPUts6FTNdH1ccO/G+eY5aCL2N/yg3KGX+iACfSC3OSCcDavfVW7qlEvu85nBEM7
         Kkmla1evBKZilJmj1c9+mTN17J/7rSHxXdezrl8piZ7t0R7gimvm/k1fIZvyrV0NL1Ik
         rwqbBFB+G6WJaB26irForAuStY12KvhoXEXq0+4gMpsmyBR/bdHzmTZOnPwQ0iSjZLl3
         gKOAHr6BxusrHlV1cevYW/YsYb0Ra35D8KbxHUsg2d/WFyAZxpWgJUGfCWOlOG/k+t8O
         jYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719663789; x=1720268589;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd/fN6JrXuuparzKe/1dgdm1z2pqZRQTyP5PJ9H207I=;
        b=Po8CPwR/eP+tCEgjKXeAQdUYswyiFLuuWUJ9hyMnqt5KyFE5CD+cEvVeUkj2KjZhRk
         cpYAemkw8P48UfbI2iEroyJ1HTrfz8xXm9h8ADe7ohuikpdUtXJYVLxBSU9UYDRHRM8O
         P5BlugJ0Of1Rj6ytl3AlDyPzMn1SC/K/6nsuHLxzdn6WgnQ6TXXGffMVCtyupx+eZMj2
         H5xpx//QKGFEafDyPS3mOA6tC6JZGqO8F8OfPJ3+vGT30L4rLfSuQWtsYJHmhuBkoaGL
         kQPJaQVoIv0eKcSsm3Uw/5Q7uMOrFEx2SXBf4oNi6bdk9nYQ7lSppbLhZINDV2lqaKfb
         95Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXxlX6KmQe4UqZtARWi45NMVLuZEmUm9VCKRmDMiBTtBpSulqEYjJQQlqI+46HzoWHPmeZVjwxNiEVHC/L6Rs8o1qkGE7UKPfJo
X-Gm-Message-State: AOJu0Yygat6AiCqsm3x5GRfjuknil/USE/bWaBgGlPoXz7gH/ptfkcMI
	sJPuovkEpxnnWzGvkFTf4l7HeqmZWfBKO//bn8yNGk5MqrZMlHaFgZMcl+VyJA==
X-Google-Smtp-Source: AGHT+IEW0u5OjNVhFbntAWf/v7zidI2Sjsqla8PVFtRXPmZZ7xJh0N+dgrcQ2vSjwdtKDdMLAlmuaw==
X-Received: by 2002:a05:6a00:2e18:b0:706:8066:5cd6 with SMTP id d2e1a72fcca58-70aaaf31a15mr736491b3a.32.1719663788507;
        Sat, 29 Jun 2024 05:23:08 -0700 (PDT)
Received: from thinkpad ([220.158.156.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf70asm3179116b3a.102.2024.06.29.05.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 05:23:08 -0700 (PDT)
Date: Sat, 29 Jun 2024 17:53:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 01/10] PCI: imx6: Fix establish link failure in EP
 mode for iMX8MM and iMX8MP
Message-ID: <20240629122301.GB5608@thinkpad>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-1-e0821238f997@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-pci2_upstream-v6-1-e0821238f997@nxp.com>

On Mon, Jun 17, 2024 at 04:16:37PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add IMX6_PCIE_FLAG_HAS_APP_RESET flag to IMX8MM_EP and IMX8MP_EP drvdata.
> This flag was overlooked during code restructuring. It is crucial to
> release the app-reset from the System Reset Controller before initiating
> LTSSM to rectify the issue
> 
> Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 917c69edee1d5..9a71b8aa09b3c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1578,7 +1578,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> -		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
> +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX6_PCIE_FLAG_HAS_PHYDRV,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
> @@ -1589,7 +1590,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> -		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
> +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX6_PCIE_FLAG_HAS_PHYDRV,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

