Return-Path: <linux-pci+bounces-26859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E63A9E2A4
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 13:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86BD3AB30B
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4CD1FF5F9;
	Sun, 27 Apr 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1Z7lpZS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DF19DF6A
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745752560; cv=none; b=hjAoWwP4rzpsmLjzE3falnIQFGJU1U5s0xgqbhGFSxKHkJvJS/soQx+6bgDBr5letnrhTYRqwdSUYQ3ccxIQ6YzfC2+4doqGVYELZvcntuSpEXtKsdjngXDt9XhwcPTIzITNxhchZAsH7cU6P2htnEmfFDZBktBqImn20CZoVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745752560; c=relaxed/simple;
	bh=IuHqjHQKIj4MI9Zg8PVsHK2jscKz451CoRU+37OGLGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWlotKgPMUjVSgI2Yq7b5lFQxir7E8nwsvPbRGjf6qtGhYdmXRIrknBddWLEC0roB5Ucl8XR2+W9h/xUSe4Q5gvgi4vcvicqJqc1Ts9qNQa5fwyzSVnruHDMmIUlHqb//d9y7B//yISRBBn1AVMqxEbjz8gqvQLQRh/gdVr7dKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I1Z7lpZS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso3904692a91.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745752557; x=1746357357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YOn5uDNnmbpz2YvqS/MmIuJTmu3qB5FpprhRLnKlvIE=;
        b=I1Z7lpZSqU63VokoSTJxJj/1srKGZqzxDwk/C74Ow9YEejrV/4RpypPa4XE7eFenVE
         o+yUx48NbA1BwZcMQn1B4qvmmarMxoBLbHBBIkkMxlXEvxVYBGBfB/fPGxKVroZ7uT/+
         uktgRfYYQydeWT6ycnoZE+Nqspry0mNHaz0IKI2RrpIo9+anqnKI/0BOcILqrXVorqZR
         D8ktxKIkUQVM8PX03SkJVygT0LoxJCWc/xPEBTsmeRG3UaGc3vqU2vB/cQVCUL1VDxa9
         DpQogOqireYYz3HRQN5dejQ/Gup7C+rt77j7v02OK86P7BWjiO/gBXIjOiaqWIuqqCTc
         Kfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745752558; x=1746357358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOn5uDNnmbpz2YvqS/MmIuJTmu3qB5FpprhRLnKlvIE=;
        b=KE4Wzyru/Hu8LdCqVVcPSDsbVM7qn6BfEORdJgRK9nGOaGx1RNO10aB5lJzu7KFPzU
         sTOXycdDacNyCEQenqKNfZljWOmRG7isx8Nr6jmprjq/9GMy7K6v2xeFxS8mZyCSe9bf
         pfz1TpvdJUbbb3N1PA2YyAcRWSa6CXQZ4o2IR1nqiYs27dj5I9J1Q0zzm07C3fTc8WfH
         4nBGkmA1SZQr35veh+12L2lKGk2xO7lsOF0BFO439jRVd8kTww31eB/xe3rI6aDOz3Bc
         UMv2eZlTjtPVMBcIGktfUgfBpcneHXwzWosAHRnVZXuKzqyx7X8cvQNLjud2uI7mnKXY
         pi4A==
X-Forwarded-Encrypted: i=1; AJvYcCXO+8kJyvsjnNVbAR5abEcPIVjg618nZfzEgVlHWhBHXLMM0fLjKSivg67GjTxGBLWQHhOb3NQEQtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcNyUPA5+F00+F/3ihOWum7QChZJ59gjjK4HIdVTBopO5RRdE
	CWc1AiHBPBNyxIrayevXavEQlakYeILqlbT4NqhbsX6COTpgv6oWmIEDMp400w==
X-Gm-Gg: ASbGncuP9bw4oypGXxrin+SpgLR+jGlZxfwsDHTJ7dun97eKPZF4A7NruevyvQupMAj
	M0YZniVA7KT14dn3m+uVQGCjTDwRAMzSmY/j7+OWanl5AhsIX4NEJJ5ldGyjLpZrYygZh67ZZy2
	bXONU5occtHxLq/0GOy+8Wwo52Op/C1NJYRpm61xGVGusEHK19OHm2/fYcEuBkohr50eQVO0PJW
	jfeRcRVRPT+n0ACc7/1poG7wsSkAE8tkz7xbHw0vZqCuT58QgOS4r3aLLxByxFFIfDfiX0pml0n
	St5NYZkFpqYY6l5S3ZLTDnl47JmBV5FOfitUMUMfe7cEbMHsENwt+HJIX+at9PM=
X-Google-Smtp-Source: AGHT+IFLgscZ/lYINfuAkkH9jISjtRT3pDQ1Z95sY0g7bHDD7akZs8rvcSaagngpu+qBp7Bz7x7Yig==
X-Received: by 2002:a17:90b:2dca:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-309f7dd8a34mr12567779a91.13.1745752557651;
        Sun, 27 Apr 2025 04:15:57 -0700 (PDT)
Received: from thinkpad ([120.60.143.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7cb2sm62778045ad.112.2025.04.27.04.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 04:15:57 -0700 (PDT)
Date: Sun, 27 Apr 2025 16:45:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v6 4/7] PCI: imx6: Workaround i.MX95 PCIe may not
 exit L23 ready
Message-ID: <4cbv5uzo2vcigrjmpisg5ndovhkp2cpyg5sczpxsde7gmv5fd2@cf4li7yqkxwn>
References: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
 <20250416081314.3929794-5-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416081314.3929794-5-hongxing.zhu@nxp.com>

On Wed, Apr 16, 2025 at 04:13:11PM +0800, Richard Zhu wrote:
> ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
> or PERST# De-assertion
> 
> When the auxiliary power is not available, the controller cannot exit from
> L23 Ready with beacon or PERST# de-assertion when main power is not
> removed.
> 
> Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
> 
> The workaround is irrespective of Vaux presence in remote partner.
> In the other words, this workaround should work whatever the remote
> partner has the Vaux or not.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7c60b712480a..016b86add959 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -48,6 +48,8 @@
>  #define IMX95_PCIE_SS_RW_REG_0			0xf0
>  #define IMX95_PCIE_REF_CLKEN			BIT(23)
>  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> +#define IMX95_PCIE_SS_RW_REG_1			0xf4
> +#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
>  
>  #define IMX95_PE0_GEN_CTRL_1			0x1050
>  #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
> @@ -227,6 +229,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
>  
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
> +	/*
> +	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
> +	 * Through Beacon or PERST# De-assertion
> +	 *
> +	 * When the auxiliary power is not available, the controller
> +	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
> +	 * when main power is not removed.
> +	 *
> +	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
> +	 */
> +	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			IMX95_PCIE_SYS_AUX_PWR_DET);
> +
>  	regmap_update_bits(imx_pcie->iomuxc_gpr,
>  			IMX95_PCIE_SS_RW_REG_0,
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

