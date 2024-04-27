Return-Path: <linux-pci+bounces-6737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D68B4630
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FD51F26346
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCD4CB5B;
	Sat, 27 Apr 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHmyZQ/y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1431E52C
	for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714217910; cv=none; b=svp8355z/wi2x+4nBncb3m5B4QgU9qU+VcNvHX3ecMAkx54tEW2gajoO/sNQFLszG80OsO+z+RB91ss8g/gI+6dn4MTOlEiIoBd4luna6ix1f+6w2LnxnmFijUR6ADdEBul01YqQruIDcEhE8hEfULueSEcXpZEKQV02sfsoAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714217910; c=relaxed/simple;
	bh=p8O2sAM2IxpLXYnB4aXc6lDvtD3kwwkCCZ0i/MQiGKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQg6G4oqXaxDvZLh7945j9xmERKNJnrqtpdHZ/0bzn1TFJX2vCWnuKHAJa6w4JIGL14j7yy13zahw1JgaQQSPtoqm9mLOOiSXe+/HGcH4sl4bwzEe/3yHHnwSRYTL18wvq72ctnZi3+UzigAJFzbIbHx5udUGNW5ZLDoXEZtEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WHmyZQ/y; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2211207a12.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 04:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714217908; x=1714822708; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Np//FY4PRW7HBHaV5Y9xc/c4l4DQaCwD4Awtz2s21Ww=;
        b=WHmyZQ/yM1AjGbOsKmFc2eXmnX2Heg+JZEZmebwLAGilKJr49+I4ZGkdWOFYiAeYI9
         MXg2KymXYFUta7riUD5r2zwR+koPDCAY6NXpXEx2/7aSP0o/JHFIsuxmMkJRVgk1E7E9
         kW1gJmAYGpgE7pjjd249mJwU0WBjG2jXet2Dd7FHc+7FN8GbBWMPW7q+KDQVoAxecHOs
         WaZfkx7uREGEO8Q5xolXeUGdywH/5DUbQ5OcOZDs2u0mKwt7B5o1N0eZR7vYYuDtpPkU
         4XaDTGN8jX2IteQ3o7c38N9B8qOkU/smw+yZ6v2K4S32T/GFUnlfR6qdHIAeGYC/IYVF
         s1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714217908; x=1714822708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Np//FY4PRW7HBHaV5Y9xc/c4l4DQaCwD4Awtz2s21Ww=;
        b=ej4YzqANKMbc8pAJvhU6XO/kCQWHO1x+m5Wrp59Y2vn6iOcieIByuRLGbVpu44aGJ+
         t3V6vNyjaaWClrvSd8IKpiOKLtHv6HTG0OK+hewB6KCF9d/LIjnge9OQLPth2hce8COR
         bnNXFesPaHXa4EeU/bNh91hlSLx9lZ7CMQOqbE7zUbqLKbqQErxiejazZma4bfFwJ9Yn
         aZGqBDwWIPLSm6wWig3WxajGm+oXnkep4PiMYlIh+5nS0wUbKav0kMWEfXJSo2JeR04g
         3tVsj9KknNaq3lHfDM3Bny5hR7U+WETrgGMDky1mk2N6BKAfTy0VzQxCXHahAxDzH6fA
         vH0g==
X-Forwarded-Encrypted: i=1; AJvYcCV8LN0GTVm32Qnb7OzDIWNVD7w6CVCOYTK1ghjMo8UimScOdGwyt5wOFEMn/LQ/JWEqkarlkyPSKhy1YGKraXJT55m0PmQrxK59
X-Gm-Message-State: AOJu0YzVm1+iDGmzDnf4JcDs/rFLZbDlIA8gDsSuJDHareMigZiQ6s9j
	JEAjhWB/KrbS56hvxVMTu08iXv0QBJESc1mcOq5Q6RXbmwtVvnHnncFE1YPEKQ==
X-Google-Smtp-Source: AGHT+IEF55H/1kS+Cfrgsn1sJ6Q8f7kM2jkzMm6mfROP3v0+pv0LxPc83s4Ah40q/gygS+pPW4uANg==
X-Received: by 2002:a17:90a:c687:b0:2b0:763b:370e with SMTP id n7-20020a17090ac68700b002b0763b370emr3311655pjt.18.1714217907747;
        Sat, 27 Apr 2024 04:38:27 -0700 (PDT)
Received: from thinkpad ([117.213.97.210])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090ae68b00b002adb62b633bsm10608534pjy.43.2024.04.27.04.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 04:38:27 -0700 (PDT)
Date: Sat, 27 Apr 2024 17:08:17 +0530
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
Subject: Re: [PATCH v3 09/11] PCI: imx: Consolidate redundant if-checks
Message-ID: <20240427113817.GN1981@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-9-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-9-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:45AM -0400, Frank Li wrote:
> Consolidated redundant if-checks pertaining to imx_pcie->phy. Instead of
> two separate checks, merged them into one to improve code readability.
> 
> if (imx_pcie->phy) {
> 	... code 1
> }
> 
> if (imx_pcie->phy) {
> 	... code 2
> }
> 
> Merge into one if block.
> 
> if (imx_pcie->phy) {
> 	... code 1
> 	... code 2
> }
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-imx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
> index 653d8e8ee1abc..378808262d16b 100644
> --- a/drivers/pci/controller/dwc/pcie-imx.c
> +++ b/drivers/pci/controller/dwc/pcie-imx.c
> @@ -1103,9 +1103,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  			dev_err(dev, "pcie PHY power up failed\n");
>  			goto err_clk_disable;
>  		}
> -	}
>  
> -	if (imx_pcie->phy) {
>  		ret = phy_power_on(imx_pcie->phy);
>  		if (ret) {
>  			dev_err(dev, "waiting for PHY ready timeout!\n");
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

