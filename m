Return-Path: <linux-pci+bounces-25729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4965EA87258
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409AC169BEF
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E12D1C5F13;
	Sun, 13 Apr 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGz/YAcm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA591A76DE
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744557516; cv=none; b=WsCndZYYLa1gXNQlGGOYSJpq6otHiiya6SK8wA6d+2zwkGaGubFsKslW/MkUbjEh/Y0s2HbKGY8i73WMviyT1WIW6EWFbOwW+Ii8oe3doN+CC6Yi7e7YNihCaYyLuO4B8VfCAs+dg6HSNh0Yv1uaeXmHGcXrVlH6GckUZKJoJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744557516; c=relaxed/simple;
	bh=zmesPPV9ChE9oRi1yUXnqbMt44Qq+n0tUWnOlfbWAY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoYTL6+2av1+mM/3ayJQ0IbdqcPyR/nQ5d3bFep00RUNgP53oyiqEjsTjpyJlKajPmVv5kxZT4IurXDuEAWVRkIc+daH4Ixmfrc2CSyBb1+wOZMoIXyP/xAfMwSnxmiGBMMiX4Czq0XRSF3rAwHdiuyPdOfb2FOryToRIPbI+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rGz/YAcm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2254e0b4b79so47044655ad.2
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744557514; x=1745162314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5SxyZdFhsBdqIFHmGXVTKr/6RFpFPtSv5Kv+4B1G54=;
        b=rGz/YAcmDcsKvphWpq/UmOnM+VC+MYR+M9AnUTuQ4NEtleW+BcR0iRicQgHhIbJla8
         BvP0qi7zr4/MzH+vw2rHV7ek411fuRSossQVJcEIIXl2I5Z++HaXy33GGbTZoKMhm3R8
         QVv6MuspmN2ca1+EeMkvXMELvGz3pObOZTAsu6dvtM0G+fG3mwNhae8iMfY2KXZj1nRt
         R3jnc+M6AW/9LarLFn0CBbtGMAwBvaUYRpHUR/Hko1g5nI93NMbfuqxubZflJmRWqkbY
         oTkPnGzLLJqcL9qcSk3ZXyLcfrwefY/Zrsc4ouzSxOuPoo4Agmys1nFUL1wBjk/CsaxN
         qXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744557514; x=1745162314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5SxyZdFhsBdqIFHmGXVTKr/6RFpFPtSv5Kv+4B1G54=;
        b=uei3ckwUaZAsPLt9OnIK2ms0ZOHggzynNTzeqqM8v/GjD9tcBa+5jpsLFvjkT/5kDy
         iE5S6jsiY+PaXZ2envIcrsSQWNVlJEAzc+AraG81LKc4j1mrO/FwkV0F23/pJ6Nia0Sm
         GzlGsfVxjzbUzhWH+KNsn4t3zf+/sSRL8+5g8BQabw/tqhzu4URj2u8sg7oBKLEK1HOe
         Q/HGEENV/Fzwxa7jp42li/6mdeG8Os5eVW6ZTKA3Tuze6Rir64cUbDI7kfl/JHezJGuF
         je03eGfmq0Q+0+x7dh5TEd9VItMAJDETE1zGZ14IyLGhaNOuf41xOhumW8OMQRsbuVfT
         u+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUHsJp30E0DCJCgCJcjhqP7VATiB65g7n/Sj+66PlIobAk/XJf2lwtJuT8Eo7J5NoLrqJfe6aInxk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66pYKV0b7s0aA2CEnivm1fo5CHaVxQ7RgKkzepDt9WGh7ZXTv
	pkwwIw/PzBI33JkK14LfI4GOi24nncMBk8/a9ABmL4UFarlvWmT4ATuPWRxLGQ==
X-Gm-Gg: ASbGncv3FnYmPpuLlsmAuZScO3iFLXFnk5EdEjFAytoZ3SDzV94qLf3Xdbkyc23457i
	mb3NV956hlhHFdJIztu1tAkuEQAqdl1io50rSNY9X/apzqGX7pJGcQzaObUmi015lPlm5qxWqTr
	Lywi7G3Pcd4eLAanxKXKYxEU+PGKupbD0csqxXcziRdW5Zzwf/KaIAH92LQyGcefMApjb7GZpDg
	VwNpteu72KJ6fiNDaF1ty5uNlIKTuM32tBYwmMyTdzRuEb9QriKd6NOK1dFPy1w1WTLKSA8Mu65
	WK9oZpqYbTbuA6wjSfqYeRw+rs/QzR+mFhdgML0rL3+kDkEYvGrY
X-Google-Smtp-Source: AGHT+IHDZ8f7JVDhbxKzAwHoGnI3IfIzM3yHwUjNE3PyS9q8zuAZM5A71PAC0QwIseLe1+9XzUcjmQ==
X-Received: by 2002:a17:903:2309:b0:220:c813:dfcc with SMTP id d9443c01a7336-22bea4f1ab1mr152530195ad.40.1744557513757;
        Sun, 13 Apr 2025 08:18:33 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb59a6sm83980095ad.203.2025.04.13.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 08:18:33 -0700 (PDT)
Date: Sun, 13 Apr 2025 20:48:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Message-ID: <pnc2kgveacnox4kbdamggp6p7pjmuyan6lwucdgzyqg3u75uo7@bb6bnsy75e4x>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
 <20250408025930.1863551-4-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408025930.1863551-4-hongxing.zhu@nxp.com>

On Tue, Apr 08, 2025 at 10:59:26AM +0800, Richard Zhu wrote:
> Add the cold reset toggle for i.MX95 PCIe to align PHY's power up sequency.

Please avoid spelling mistakes in the commit messages.

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c5871c3d4194..7c60b712480a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -71,6 +71,9 @@
>  #define IMX95_SID_MASK				GENMASK(5, 0)
>  #define IMX95_MAX_LUT				32
>  
> +#define IMX95_PCIE_RST_CTRL			0x3010
> +#define IMX95_PCIE_COLD_RST			BIT(0)
> +
>  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  enum imx_pcie_variants {
> @@ -773,6 +776,43 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  	return 0;
>  }
>  
> +static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	u32 val;
> +
> +	if (assert) {
> +		/*
> +		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
> +		 * should be complete after power-up by the following sequence.
> +		 *                 > 10us(at power-up)
> +		 *                 > 10ns(warm reset)
> +		 *               |<------------>|
> +		 *                ______________
> +		 * phy_reset ____/              \________________
> +		 *                                   ____________
> +		 * ref_clk_en_______________________/
> +		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
> +		 */
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				IMX95_PCIE_COLD_RST);
> +		/*
> +		 * Make sure the write to IMX95_PCIE_RST_CTRL is flushed to the
> +		 * hardware by doing a read. Otherwise, there is no guarantee
> +		 * that the write has reached the hardware before udelay().
> +		 */
> +		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				     &val);
> +		udelay(15);
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				  IMX95_PCIE_COLD_RST);
> +		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				     &val);
> +		udelay(10);
> +	}
> +
> +	return 0;
> +}
> +
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_assert(imx_pcie->pciephy_reset);
> @@ -1739,6 +1779,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> +		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
>  	},
>  	[IMX8MQ_EP] = {
> @@ -1792,6 +1833,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
>  		.init_phy = imx95_pcie_init_phy,
> +		.core_reset = imx95_pcie_core_reset,
>  		.epc_features = &imx95_pcie_epc_features,
>  		.mode = DW_PCIE_EP_TYPE,
>  	},
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

