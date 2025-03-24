Return-Path: <linux-pci+bounces-24550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A3AA6E0B6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5FD16579D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66744263F21;
	Mon, 24 Mar 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymqhujPM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E325E461
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836713; cv=none; b=k8iKStEk1ngyuKrIknl1sS2IRisWGlIEBaWsOTYS5O+LAL0eQEUnQgbUEmsyZ/XB6jsoi52g8Cjtky0ySeKNcXTRxmI8cWkwc0vjs0163ipGgYayBrvQG3qMft7ycWsARH2yP8lO4U3lFfP9IS0z8v3ncH9XvvEQeyzLFutue8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836713; c=relaxed/simple;
	bh=OO4f4+Q0rzt9wElVeMHssbBupiD7LRrwqaMbqJE61yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLczxpTTu2qlXtqpkfb7ayTgxO/e3DxxeZBA47rk6kYDOHdZ7fkKSDaT7BQ+K3lIetGeGD8erhzWw14c8Z2DQNz0JIpJ6BDdwbtSSJ+0BKe9fE6mNLQ99t9dx5H/uWTCV4JfGrldJ1qYHiw11dXW6pI42a3qQsQUhNM5Qlrzob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymqhujPM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2254e0b4b79so78920325ad.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742836711; x=1743441511; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZEbKpA1frJBrkSoz9cnFIH7frubQfuf2pOMnH5himQ=;
        b=ymqhujPMejytN3hGhaPOFgEwdmbPFw+LU/ZrxBVZ/zeSR+t9uomiWIdaZ4WeWx1z62
         EDm7IUmJurV+QLTZEFIIFa+lzucxN231CvKPMzCx7QDjb8nJcvD5TBaY2H90uEfl/Y2V
         28ER1h4eI6QdijFjo17/m7KpypX3N7uqBj7ICsZCLv/jTdoUniqHDV4QpdSgjPxltY0B
         tcMI61hjhV7daoeAVc1bjxoYG5vo86I6NXZE1zTbvF0SSAF5Y19ufUxbzFjlNy9AksNB
         Wp3Bo3G3MI52s12Ngvg5OvUck05+BaUbpBt5ZnIquGPe1Rb48ipqFu/g18qqSYTA+gjc
         aB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742836711; x=1743441511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZEbKpA1frJBrkSoz9cnFIH7frubQfuf2pOMnH5himQ=;
        b=X8SzZ2raobb2h6vfrr4bSzTXhYvs3FuEzoh1w16qV9laz6LgtVKtIIznhVXc8OxuCS
         UHJq1G+wm8kR3MjPhiBB84LUsde9hk5+HeaU0JO2UMbqlOkL51qol7vKBzS4bXa2UAdK
         aySc+5L0CLPRTvXLgAo5gpyV3ilNlAXdaZpuyS4MhjrBLR5tk8S1TgUBktiMp0S1TgwE
         gD/WgGtRYR4bG5psGlhcyP/H7jiKiKdK0DBWHxUbhjmbNWXnWz+aBf7IigDGs/0Lx8js
         LvPgjMaINrdKZuYOrdJKT4oLQwfRAdVQrDSY+mcZ4zcg76yJ71Yr0ZztxQqQ9TGqh4Xm
         hVlw==
X-Forwarded-Encrypted: i=1; AJvYcCUy6m1A2Qo22z/02iSwn7dA1q5gy9MfOuVHuCbgdY4/xpNgNevLcv8R+ZZ7KMtmpnlKAC2nv+bo1/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzQAwLC/qNEE8kBkViORNcrZ4IzFPP+OksI7t3PbChL4y2DUF
	2D+DE+CRiE1p0tHOxxin1QXnr4CW4/gvW2s+TsBomdLZeT1XFrUcBY5f1qw+Sw==
X-Gm-Gg: ASbGnctgWPO4GA+uP4JEM+bkt1UfK/T4vl5wV9AIBJ+ko2cSe71vPrjvWaLfVHW3LBR
	HbasSBiDquwb71Ptwkr+aL4Z7QQ70NPEoz0bpWrQ7w5oWX/2oYzy0hifFFAAC4ynIHzGPn9xV14
	HSbv52JWXXsu88ltsRFVHaqljX22PxJZrfYyIJYX62FPkZNx2Vtd7i/uBFjSvCBnyr14EflHIj8
	EGBSa6rPL3RFVhhsa/gD/R0+UZCIiJyuHC21wS9AA4HNgV04YbnaC9oXe6SErxXMO4ToOyVQPk3
	rkavVuLIr7nRzk1O0ZmPqtTFYgmz1YU6h+C3zMDyQi69MvtjcoV39WUNrdsbOnUqsw==
X-Google-Smtp-Source: AGHT+IG/+IMOKh9mdPF7QL4qAJQoeDmcoGNXXl94gtnk4lfwQykOcdsW47jIFy2/Z8VlBPbmIKO/Sg==
X-Received: by 2002:a17:902:f648:b0:224:fa0:36da with SMTP id d9443c01a7336-22780c7c06fmr184562345ad.18.1742836710841;
        Mon, 24 Mar 2025 10:18:30 -0700 (PDT)
Received: from thinkpad ([120.60.67.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3bbedsm73934205ad.3.2025.03.24.10.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:18:30 -0700 (PDT)
Date: Mon, 24 Mar 2025 22:48:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 05/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
Message-ID: <j3qw4zmopulpn3iqq5wsjt6dbs4z3micoeoxkw3354txkx22ml@67ip5sfo6wwd>
References: <20250315201548.858189-1-helgaas@kernel.org>
 <20250315201548.858189-6-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250315201548.858189-6-helgaas@kernel.org>

On Sat, Mar 15, 2025 at 03:15:40PM -0500, Bjorn Helgaas wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Return the offset from CPU physical address to the parent bus address of
> the specified element of the devicetree 'reg' property.
> 
> [bhelgaas: return offset, split .cpu_addr_fixup() checking and debug to
> separate patch]
> Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 23 ++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  3 +++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 9d0a5f75effc..0a35e36da703 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -16,6 +16,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/ioport.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
>  #include <linux/types.h>
> @@ -1105,3 +1106,25 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  
>  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
>  }
> +
> +resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> +					  const char *reg_name,
> +					  resource_size_t cpu_phy_addr)
> +{

s/cpu_phy_addr/cpu_phys_addr/g

'phy' usually refers to the physical layer IP block. So 'cpu_phy_addr' sounds
like the address of the CPU PHY.

> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
> +	int index;
> +	u64 reg_addr;
> +
> +	/* Look up reg_name address on parent bus */

'parent bus' is not accurate as the below code checks for the 'reg_name' in
current PCI controller node.

> +	index = of_property_match_string(np, "reg-names", reg_name);
> +
> +	if (index < 0) {
> +		dev_err(dev, "No %s in devicetree \"reg\" property\n", reg_name);

Both of these callers are checking for the existence of the 'reg_name' property
before calling this API. So this check seems to be redundant (for now).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

