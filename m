Return-Path: <linux-pci+bounces-16820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55599CD89B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510FE1F23408
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E10418871E;
	Fri, 15 Nov 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KxDKISF6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD763153800
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653552; cv=none; b=KOFkIXWQ4TKHWWykIWI2415CAAW68gALxaoNw6Mk6BiyA2VrWktQcbBf6fvNG32VQGIJkCtUTwlyBi0zOCQKeVkNC+y7eyWTS5QXPj4ZwBQ1LhcXEv8ByzKjzodwoqhToFsV9tqOQiNUdL0JQuy2pkges7vXaR67yvq2FJcnFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653552; c=relaxed/simple;
	bh=CEMXhu2MGYVzDLJ2Eh1N2Pyu48lfVTlo3bSjDF1UB9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJEoR5GPZeQpUNBgJZXNoYQD4cfNizvhDY9MSU01iJBIllwNhUlg2IDeQ7yr1wTh54+sDnYC0Lin0D/040eimfOFb+QDRgNbRPlFKp8r+XLv3kM4DMC/s8pRy5NLjOeFANk87KfuXozBqwypIU0YyzSKAoVTlVtWNM5ZbRMcBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KxDKISF6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-723db2798caso1311941b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 22:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731653550; x=1732258350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4/1UwVe3Qsy2MB0A1h4O60dSR7MLmU1E1u1iWJ0FEAI=;
        b=KxDKISF6z7WtvEguG/bF7HGMPm9QJzwIgENY/iGpjnNCjSZEP0rltrG8nkvjv/VTWf
         /A3rXQTcYWs/YGagPadlomJ6Sw8ztq/mI/9g12x0dvAVL6s6F3EIHRsgjNRuLzSYjlt4
         nkwkkakh/Iwv+L7xbBIwP6LyohQ6ZD2RgVKVfXQqatSlRQ8j8d/yDtNZAu0PH8dYsoMX
         n5rbdCC1MljlkujGrYWwOYizx4U6JckxdhygoRKNDUCZPtjDNiCmFq64SXr1slwDeX4u
         qrmQlZA6O2agC3KA+4BWc5dkWf+QuShrE+Uy18LeSQRl6gGCO0KQeoio5JWbUJ3PyrhH
         bELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731653550; x=1732258350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/1UwVe3Qsy2MB0A1h4O60dSR7MLmU1E1u1iWJ0FEAI=;
        b=kn40q+wJB4ZwEQPuRHpqni7dnVzWFOuGS5VNhJqekOtt14IIrqvGCz/ncU4s9krVDE
         DUD+cUGnVDfGpj4i+3/g8/1FL2R7G/HcKlGy2+uDRAzlHQQMVQ0CnyI2LK6jDfqrZe/I
         LU2uOjZRGWV6LaI6d0xfkLDwuqABRH/R4ByNqU4qc+q9MKbEiJABcYjqDY1XmMXFu2eG
         VxGmN+0+gXB27EtO2+BF7oLwBvoy/T/wtl6kRcmKu9j0kkIHBV7MopC2fP9QTqphIW/v
         jIE8IT6eYfrv3spyFHJzzoDX/cjmsWB0FqeqP1F+8P6vi5gdkOQF4K6YuPaV2Uh8HRwh
         yzhw==
X-Forwarded-Encrypted: i=1; AJvYcCUUOifsXaYWvaLAiQCbOc3BQ5ryJecG0gLWx5RFcEc5okSXbmJ11PX0E2LYssYLEpY/p87ZVAcx8kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/EzVL8lP5bX60sYlB51qViU3yqyZnd1TQyO1ps/EquBlnr7+d
	8+PptpgjwwB0FPgHzO9sn5YGd72SlgoOJpg7r5KVdy5T0HUV7CRLpG0G2xI0tw==
X-Google-Smtp-Source: AGHT+IE/YBLChBCuslucF1k1xTrQEVYs0lhSpDpzi5LeohRmyIqqfR8TDB+1oTszXaCrfQURCH52AQ==
X-Received: by 2002:a05:6a00:998:b0:71e:44f6:6900 with SMTP id d2e1a72fcca58-72476cfc9a9mr1771780b3a.16.1731653550107;
        Thu, 14 Nov 2024 22:52:30 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711c0cfsm690383b3a.51.2024.11.14.22.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:52:29 -0800 (PST)
Date: Fri, 15 Nov 2024 12:22:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, frank.li@nxp.com,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/10] PCI: imx6: Make core reset assertion
 deassertion symmetric
Message-ID: <20241115065221.scfb2chnoetpdzu6@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-6-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101070610.1267391-6-hongxing.zhu@nxp.com>

On Fri, Nov 01, 2024 at 03:06:05PM +0800, Richard Zhu wrote:
> Add apps_reset deassertion in the imx_pcie_deassert_core_reset(). Let it be
> symmetric with imx_pcie_assert_core_reset().
> 
> In the commit first introduced apps_reset, apps_reset is asserted in
> imx6_pcie_assert_core_reset(), but it is de-asserted in another place, in

I'd suggest rewording like below to make it easy to understand,

"PCI: imx6: Deassert apps_reset in imx_pcie_assert_core_reset()

Since the apps_reset is asserted in imx_pcie_assert_core_reset(), it should be
deasserted in imx_pcie_deassert_core_reset()."

> stead of the according symmetric function imx6_pcie_deassert_core_reset().
> 
> Use this patch to fix it, and make core reset assertion deasertion
> symmetric.
> 
> Fixes: 9b3fe6796d7c ("PCI: imx6: Add code to support i.MX7D")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

With above change,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 996333e9017d..54039d2760d5 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -772,6 +772,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_deassert(imx_pcie->pciephy_reset);
> +	reset_control_deassert(imx_pcie->apps_reset);
>  
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, false);
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

