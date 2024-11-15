Return-Path: <linux-pci+bounces-16822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D059CD920
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB432826C3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074441891AB;
	Fri, 15 Nov 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JitGXi/u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B55187FE8
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653832; cv=none; b=stGTcIDCD4sFLhEVhunGcQ+0WHtmdINA9AO7YseG5BvbiJsWcSMnrLVwZLU8emXy6q5ZCpoUJYp9f+qTy8mOMfSSDPXRzSdMet0FE2QcnnvPG5HtAThRHzbqU7uWiefcDryicSVcTpMLuZ2NlXKqoABgm5NyYQJ/QPBXKS1wTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653832; c=relaxed/simple;
	bh=dpza+eGWv/xmHMp57zlEEJfK0Yeu8rMvSSrLh34VFDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh31iH9M2HI8SP/kIQbIHDBd+H/RyY/N2S+5U2Wdj09cmVSUIImamq42oW+blwkuDcSVATY7Wife594B3igD2oz5iLMuFbRHYTrN/3ChgKKFiYXPnmCTmXxBVE+0bzKpcFJu2oUS0x++/tPluH4hbQJacS+DlyZy9b/+btLQPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JitGXi/u; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb7139d9dso15917925ad.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 22:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731653829; x=1732258629; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UUnANkLZ+cRlOTdO0AUsRhtlxHbXsgSkLLst9mQNAEg=;
        b=JitGXi/u/it8tPmt2uOffpcJAhZ1XPE2T9k84e7JbXJstvimJeKlZkKQ1S5PQ3vHmM
         W/3KEvY+l//FOw18pAVM9uw5c6FPbrXQdGcwZAVQurpvVZM5vnouYTXMIyh+dmL8V6Mn
         F32DFDL3kzc6iv3ER2/xl/BH3ok9YCkbBI64Iyfkt0RhGUMTdJyvs5B9Sm7nSTk9vcdJ
         YJ/eWUsbvkkOOJ0RHhdEFh97dmv7rgB0fXUj6JrUIGvTukKkNUQ/xixkF+BQAYOMWju2
         saSv2KvqW19v6AqYkWBaiyzuWuLuSnbOFZIahinCGlAS2ec4FDdYDDiVZ8CghEMouz7s
         M97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731653829; x=1732258629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUnANkLZ+cRlOTdO0AUsRhtlxHbXsgSkLLst9mQNAEg=;
        b=PCIttGvFxe0r5JmcEzD5XzSXGeMXPfXIIWbxckZL9KZrxwzdLAArGOLupI2WOAzKJp
         NIacyEwJGC46wTzuuMFqK+Ox1r8+LwtGza1Gn+25g9AYfcp4QY+yw/GqYLMr03eRzzTx
         sw+5w/pGXOd64OIw4h8FIMce10myfT/VCgF7eazvmgjsiqAg6LLo3eV1avtdkYFmguFU
         /6G/3NWgk2psBi2Y7lCLvCJyZOQnX9DJPRcdfjdJrDOa5iG3VxSPfdoBEP7kjvrS0dw3
         ddj/fc7Grjhhy2GWneWUy4O54TFz8HhX2OZeGGSln1SRoFs+CTLgShqx1OOMAMPIeQ3K
         JU1g==
X-Forwarded-Encrypted: i=1; AJvYcCWD868qVMbRx6ZrC3ZOZgGGgGXf5NE9wvC+5cJwik7Z/njoWpGJx80Yspn8NOUsRyofjYQUpZsaSGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxP1a41EX27t57y6gs3qni1RcNZiXc92/lxakH9ho2cA5HdwA
	Wgh53Wg4kek+jyvL07BSaIBnRIp1TyhORvKVaBitHN3AzuCE0PcRYMEBraoDWw==
X-Google-Smtp-Source: AGHT+IGyxlQ3XKDLt3Kpg+bOwQr2O6U0ym9WxGmFcCu7LdeG9Tf0de/64JRmH23hKPfODvd+Dxxf8w==
X-Received: by 2002:a17:902:d48c:b0:20c:94f6:3e03 with SMTP id d9443c01a7336-211d0ed2e36mr24090375ad.47.1731653829586;
        Thu, 14 Nov 2024 22:57:09 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34698sm6210935ad.133.2024.11.14.22.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:57:08 -0800 (PST)
Date: Fri, 15 Nov 2024 12:27:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, frank.li@nxp.com,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/10] PCI: imx6: Clean up codes by removing
 imx7d_pcie_init_phy()
Message-ID: <20241115065700.gfz7dmoijhh43lhd@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-8-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101070610.1267391-8-hongxing.zhu@nxp.com>

On Fri, Nov 01, 2024 at 03:06:07PM +0800, Richard Zhu wrote:

> Remove the duplicate imx7d_pcie_init_phy() function as it is the same as
> imx7d_pcie_enable_ref_clk().
> 

How about.

"PCI: imx6: Remove imx7d_pcie_init_phy() function"

This function essentially duplicates imx7d_pcie_enable_ref_clk(). So remove it."

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

With above change,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index bb130c84c016..fde2f4eaf804 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -390,13 +390,6 @@ static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
>  	return 0;
>  }
>  
> -static int imx7d_pcie_init_phy(struct imx_pcie *imx_pcie)
> -{
> -	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
> -
> -	return 0;
> -}
> -
>  static int imx_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -1526,7 +1519,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.clks_cnt = ARRAY_SIZE(imx6q_clks),
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> -		.init_phy = imx7d_pcie_init_phy,
>  		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
>  		.core_reset = imx7d_pcie_core_reset,
>  	},
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

