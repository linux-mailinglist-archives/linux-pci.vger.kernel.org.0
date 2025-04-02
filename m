Return-Path: <linux-pci+bounces-25113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BB8A7882E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 08:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515F17A3892
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 06:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE684231CAE;
	Wed,  2 Apr 2025 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upFT+f07"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB020C03A
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743575798; cv=none; b=MtpmRaBN3k9lB3eFsKmIDJpqWuz6/gnh01nUGvG2fi0+KKLdRvOxLGoZzkN1qbwRVRmAETnrUZqdJPdGOGLZENNZ+/b0FRJ94ZDzhZMfseSAeMgpLAWRntAKq0DPifJE/aSSv2cTlBuuAQi9cYNZx+YBuSar2H/Pg0zezl5y9i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743575798; c=relaxed/simple;
	bh=9KYkwa9YJk15TN8slptE6dFITwCH+aL/RFH8C4B55u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzAVFBtsZjDiV0pXPDDnOFp8vuZJ8n9IWqMQ3OUnc3Sx05tvLwBuD+eOMVwbbuBEFSiIBxJfqPSD3tcKLm//UhB9bhvVIt9XqK/dS+cYmpQlzk5AMsAb8EhYwzozI9lUb/LGijnWtBbNjke5Gi16J/MXqRtQDcqWDvuiXieHZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=upFT+f07; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22423adf751so118512245ad.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Apr 2025 23:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743575796; x=1744180596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QBpFdjJKRK2wPZJQzSRTw4eJ4hUT7j61gGfvcZ13EGg=;
        b=upFT+f077M/6VA80GMK93JOTwJoR4oCz1TM9UU/XMFSHpjRM/RAUzg176gX0/OxDXi
         5ZQ5LL+K0mnV9w1s83JlV+whXwxq6Mf2kW0ke/dfqswd1+ZmdZuEiLQ3CxgkrrnOL3if
         7G1YzAiWRdfrtAXJlP1jmiU1PZzmPsdUA+taNmJi38FnF6c4KC6qiB6JS26LJY/sPCIz
         DXzx7C2RN7UbAYNelSyLg2AloDGVFsDio9htVw7IEBRWVvI7Z2D4xxXNy/pvFVyaqcvy
         aGYKGsOwbS0NIdR4giiQdNRrk1vXgz2eikEmwwNx++NpY8yh4y6wQY4+gHwACJfYmaE3
         jDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743575796; x=1744180596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBpFdjJKRK2wPZJQzSRTw4eJ4hUT7j61gGfvcZ13EGg=;
        b=sJKBzu9Ga5TWmRuZNUlAYMxE4cJMY9vqeQuD1gScQaW6u1PK+pWawRttFYCaefnJr4
         Ao3/1BQnqQ8JKdQZVGtkxMNkXV3srCI44WFW20K/eqDGo2nfxr5vr/CgwP/LuYP08JC8
         MU64cDLzRN7R3rKSjDYqyzJa522eAnLLiG+FX8uQ45PU0XR+gSBrTeAVvy49JFKek2cB
         80f+GA5kP2twlGIQaiPqDTEtiNbmmWUdN75uxqFkvqMwl/B3L6VRTR3yqaIqbVwqT2mj
         ALx4FMucH5m1Dxf+ULCpo7rwThJVABwZOiNbwaG1j92xPAadhz0aTgr509Y9Ttw3XlKI
         3Fhw==
X-Forwarded-Encrypted: i=1; AJvYcCWALsv3xSuz7NfkGbYG+eXXmXucJhNhvfB9QML3PXTHVL6jPExYhXRb+aPD4mkosRHdRil1rB97v0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIh+qUEappRgSrICjLd3+cuinm4OmRcavulz25yBtTjfLtusTT
	iIu+J3HlY3ED+qsyM5/oaxyFsB395Bz23d+xtgHK9nrl2lALwkZIFYP6MOIkoQ==
X-Gm-Gg: ASbGncuQ1/5JFP7y/XP+DQGQEigxW7oy4mfu6SBCvAmrupBSq4dR/Td8DGm+wIs0R67
	ZcvQKdEE5uruSBl33Nq70Tp2desmpkMukzFQl/01usOmAEl0lecoJ6q1D22Xkq9Z055WdG/GWlM
	+4TvJCqJg+CnDBi0JV21lvKUXb4jPk5AsQwLUpYc6qdT1S6tw1YWPxxgWSNJjI/5jpwWD6mf9fK
	1nlmUK/Yjua/MbSYtMlpyF0F83Z8Qg3Eo592PswAOIswbU5P80H9pJDDQFc9EH+u+I7EU9dB6BF
	OL2whGRt2yAMeu8q2qklYGy3WXd/UKLwW/R6hxy6Yg3scOShPND1Hb2J
X-Google-Smtp-Source: AGHT+IE6fEQRPpZTuVLgYtn/kGTPJXOscRmOwPKgic6LUNeFQjJDmRybRlM29Dg7FxrNgKq/c8uH3g==
X-Received: by 2002:a05:6a00:1704:b0:736:51ab:7ae1 with SMTP id d2e1a72fcca58-739b60fb6a5mr7052602b3a.16.1743575796230;
        Tue, 01 Apr 2025 23:36:36 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e22356sm10115837b3a.39.2025.04.01.23.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:36:35 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:06:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Message-ID: <fatfobrf53l3ngps3rl67gayhnlsqncgd2tabgcspac3n3o4xt@a4yrmtvaitai>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328030213.1650990-3-hongxing.zhu@nxp.com>

On Fri, Mar 28, 2025 at 11:02:09AM +0800, Richard Zhu wrote:
> Add the cold reset toggle for i.MX95 PCIe to align PHY's power up sequency.

What do you mean by 'cold' reset? Is it 'core' reset? I see both terminologies
used in the code.

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 57aa777231ae..6051b3b5928f 100644
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

Is this really COLD reset? Or CORE reset?

> +		/*
> +		 * To make sure delay enough time, do regmap_read_bypassed
> +		 * before udelay(). Since udelay() might not use MMIO, and cause
> +		 * delay time less than setting value.
> +		 */

This comment could be rephrased:

		/*
		 * Make sure the write to IMX95_PCIE_RST_CTRL is flushed to the
		 * hardware by doing a read. Otherwise, there is no guarantee
		 * that the write has reached the hardware before udelay().
		 */

- Mani

-- 
மணிவண்ணன் சதாசிவம்

