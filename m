Return-Path: <linux-pci+bounces-10573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020589383DD
	for <lists+linux-pci@lfdr.de>; Sun, 21 Jul 2024 09:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B72B1F2141A
	for <lists+linux-pci@lfdr.de>; Sun, 21 Jul 2024 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27C58F6A;
	Sun, 21 Jul 2024 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpKw+WIW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304108F40
	for <linux-pci@vger.kernel.org>; Sun, 21 Jul 2024 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721548646; cv=none; b=UrHhHehIS1UCPxrcq3F24oq5r7J33Hzal3FSayNR2UaN3gDLWn70mfxQzvDJ1iJQFJaJblZN57PW4M9RVaCKvf67Z5t9b6Bx6QFMLgdzZCV0Lg621BzhJ1Fg8qaJJMi1LENq3wdwExXZzEAcoAbW0PDDMGLvYxXbJ6jA3+NEC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721548646; c=relaxed/simple;
	bh=s69hgVRKMH7JDZd2qOJja1UzLIOGXfsO9ijXxL17Huk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTn+vSxuLQ0V1xfOMnQOVHhbu2C5LU5uqKy9N6WbOGfSFu9QU9l0a+Dlw18q220d1tFDnHxD9ZSB6FkPrjc1KsQ1zSbrE1WFgqOnaH6EUH6DwUehKbKKYOuSHjQLvxavLGXp8kgZlSPgxeSN9JGUB9JECW/ZqagpBWcCD53T/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QpKw+WIW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc569440e1so27671605ad.3
        for <linux-pci@vger.kernel.org>; Sun, 21 Jul 2024 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721548644; x=1722153444; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hyQz2Ns66mgvWpxSfqn/FqrN5K/JDuDi/DmSKkr9CpA=;
        b=QpKw+WIWlWrHQmo+t2v27byKa60Mp2h5hpg6NI4vvrpY3kN6TLg00SUN5V4Ffw4qPg
         cD2OhdjtyA8IaFH1XFEoXBnP+kDssVL/sMoxO3OjAyeTbI2U/AG3Bip36lO0d0onS0lh
         DgZoS2s8xmdBFsdetzKBSwXQy/83cQuXVKyV0IqqjQottlyBuVE6xLjUap9L/rffTMn1
         JlR/XIkK8GYmZOXoS8pq4g4oguIVdbyspED5tJ6H5G5KfvbPrKBjw2MDmISwX1QmzOFj
         j9G1kffsntSj8dUvKPhah20APjdBrXKmoQbN+MyaCCii3KkOAG0X52InbXaS6ntXs/QC
         MQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721548644; x=1722153444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyQz2Ns66mgvWpxSfqn/FqrN5K/JDuDi/DmSKkr9CpA=;
        b=aAvepJ0wjRyjg8slxc2u+ydlAMZDxsvpeCTmPg3W40jM5AINEGPrV61nIs2p32I1IQ
         sEVsKiJXm2DxasTjNxUIQG+NM5CP4LLgsSlxyj9RX7DebdRYU56eMguJEUcmTY5Nr/gt
         QmDMU6UVEspIoClhmp0dQohrgfEpO2Ur5ktMZf83vb5h5iNDT/W92d7AxVTp0axf+Wsa
         iXmJUXlns+MHT4rYrcO/uvMFu7l0sK5JeilGTDAzBcg5EFV2Jt9x1MvrWAybuvvoWR1E
         h5YJRferUURmO8pLl+oHm/nStNsAhnym35wAj4dTne2yIr5ab/U5d2zFJrEnN27RoSXQ
         F2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwKOdddiyyuQWUm3Rt7qps5jPgPgo2n3BDwkKM7ejvSRRmVUKjNsUxLlcYcEkgsbNuV/w+nSpqYLQVxWPO+A4FhuSQX3bAQjOm
X-Gm-Message-State: AOJu0Yz53QEQXoi9GbiUULUbWRSRi8elTDfdIO3i2JhvXEh+rOg7CB0V
	GWNsMfr3Oxdq9e8HJ6Mvz5niu8/nkgWHuAlmnMNqzpzhWzUTklBi4ZLcgmZ9rQ==
X-Google-Smtp-Source: AGHT+IERUkgk9IVWEdkvqOOdRMakPjOZKnaunfxav2UdDTQ2WsxGK8Rz6HmUXynq1p6YcDsh3CF0RA==
X-Received: by 2002:a17:902:d50e:b0:1fb:59e6:b0e1 with SMTP id d9443c01a7336-1fd7457e63cmr41518775ad.32.1721548644189;
        Sun, 21 Jul 2024 00:57:24 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2a4801sm32369595ad.113.2024.07.21.00.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 00:57:23 -0700 (PDT)
Date: Sun, 21 Jul 2024 13:27:17 +0530
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
Subject: Re: [PATCH v7 06/10] PCI: imx6: Improve comment for workaround
 ERR010728
Message-ID: <20240721075717.GD1908@thinkpad>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
 <20240708-pci2_upstream-v7-6-ac00b8174f89@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708-pci2_upstream-v7-6-ac00b8174f89@nxp.com>

On Mon, Jul 08, 2024 at 01:08:10PM -0400, Frank Li wrote:
> Improve comment about workaround ERR010728 by using official errata
> document content(https://www.nxp.com/webapp/Download?colCode=IMX7DS_2N09P).
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 2c60858b74a09..2b95c41f8907e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -714,9 +714,26 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  		return 0;
>  
>  	/*
> -	 * Workaround for ERR010728, failure of PCI-e PLL VCO to
> -	 * oscillate, especially when cold. This turns off "Duty-cycle
> -	 * Corrector" and other mysterious undocumented things.
> +	 * Workaround for ERR010728 (IMX7DS_2N09P, Rev. 1.1, 4/2023):
> +	 *
> +	 * PCIe: PLL may fail to lock under corner conditions.
> +	 *
> +	 * Initial VCO oscillation may fail under corner conditions such as
> +	 * cold temperature which will cause the PCIe PLL fail to lock in the
> +	 * initialization phase.
> +	 *
> +	 * The Duty-cycle Corrector calibration must be disabled.
> +	 *
> +	 * 1. De-assert the G_RST signal by clearing
> +	 *    SRC_PCIEPHY_RCR[PCIEPHY_G_RST].
> +	 * 2. De-assert DCC_FB_EN by writing data “0x29” to the register
> +	 *    address 0x306d0014 (PCIE_PHY_CMN_REG4).
> +	 * 3. Assert RX_EQS, RX_EQ_SEL by writing data “0x48” to the register
> +	 *    address 0x306d0090 (PCIE_PHY_CMN_REG24).
> +	 * 4. Assert ATT_MODE by writing data “0xbc” to the register
> +	 *    address 0x306d0098 (PCIE_PHY_CMN_REG26).
> +	 * 5. De-assert the CMN_RST signal by clearing register bit
> +	 *    SRC_PCIEPHY_RCR[PCIEPHY_BTN]
>  	 */
>  
>  	if (likely(imx_pcie->phy_base)) {
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

