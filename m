Return-Path: <linux-pci+bounces-6311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E87FD8A6993
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 13:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A88B2126A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8685128377;
	Tue, 16 Apr 2024 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LU6S/1bT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA1127B4E
	for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266894; cv=none; b=RD5av53I2lEJrrpgCMyCeSWLsmfkSp1b3VLK5XcVpDmN5AJG3l6ns5KKz5e+8Q8ekCOIxsk2UFXn9CezDwINsUa3p3e+OkL5ie9MwkrA7eDfa7trX/D8vxzbe0R3tVfrVtsiidYiRbkrBRUeKMrFrXi7jzXphbPkJDTlKkLCLEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266894; c=relaxed/simple;
	bh=PPaCYZgU3jMIV/6zWWtOMUY/I7M2S9h+j6BmR3DdglY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH6nKbhu1CJOcn9gbAae/mfenWsSmcYMYOx0PJ6vNtqo7lHiW/A6K87rFZxYcbofvv1ycaJHu7uFBkfpT6Nyj2ubqkkAGAYdGfKs4kV1Kd1riqTsC58KGttNwKYnIMPEWodIybPzgtLJwsV48oNP4FtfaPAESZx4vPsSnFc9XxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LU6S/1bT; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so3284375a12.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2024 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713266893; x=1713871693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zdTNnxpaxrR1ctyKVzJEH9wDta0s4TNTOOwoGZ9Hzm8=;
        b=LU6S/1bTmXcareSI9YYAj9TsE4+nX2wE1MuOSKVK1f2lV+vUa2HdKsNSnxUP8JPQty
         FuTquQqalxWaoptnGtysy0L9tdy9Oh2appEPVGow9CTIFMNVGqU0FjLFjRDCPeEsIuN+
         vdWvSG+dX9JAoX4KXNvKVM8PqL3s+RWCJ7modWBLsO8gwFwcbrELwSF3Hq+s7aJ6cYyI
         06lpoQjvNqqC+3iZzBqDx6yO+441MKxggnd8qh3m5DTIAgACwocfR+I6ybwpVCBsWYzU
         rF99+lysMqfirMfRLbWAlQrGPWqu66jmfOBJa5XkU5BarxIzHRTpj+kR8QNRQtApwzNh
         gl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713266893; x=1713871693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdTNnxpaxrR1ctyKVzJEH9wDta0s4TNTOOwoGZ9Hzm8=;
        b=QSGo1xk65iGBNSSvwrAk2BSi/YWP7LwdC6Ob9XdFsSG2jPuSYc0p1TS4g9vyOtUvCW
         kgG5ka4bt4g1nBGQRETPcraMHScgk8BXlfjmRzcm1Zri+WfHUXS6lZtPjAzcViC8URaw
         p4l6UdrU/tYUbTvM4QCP5mYb55FdTCJdQTIMwtt+nU0wQALohi4x63Vph1VvvTcFW9Rn
         JvyvrLexYH2HNFVMLyoPPBEV0YvCv97Gf64wwKCPz2oPXrNQmPoMnrrF0ctZ6+y/RlwR
         108vsaiiCcs3q+0VEPM0mN6AT/YYezDCkJ/vaqgVxE7ak8E4x2GhEFRCri4kFwCl3E/I
         a3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW12S0ex1nNwfbboCpYwVt89en3LS5ZtkH4IqfijBto2o3I1Jj6SbST7e/FkNqr2T+6Mp6CPkoXJl0+xjSR+N1qh5tYEhdgKHBt
X-Gm-Message-State: AOJu0Yy1w+oh6LFMKQSeenB6YDn0W0wHuMRY5dAFBPLX6/Brm893wsRK
	icekbhMNe7ivtxo7GucvmwLegLvGROtiHJPo8NwimMDAreLTRJ+l4Fph5y+RUw==
X-Google-Smtp-Source: AGHT+IGeuKxJIbqW3XQXNTArgkzHXa2+NyC8omydrI7ODv5FfOAcPf2JI0TAcwL9eO2rQVR1QEDI1g==
X-Received: by 2002:a05:6a20:971a:b0:1a3:57b4:ed1c with SMTP id hr26-20020a056a20971a00b001a357b4ed1cmr9903003pzc.25.1713266892340;
        Tue, 16 Apr 2024 04:28:12 -0700 (PDT)
Received: from thinkpad ([120.56.207.234])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902ea1000b001e27462b988sm9534702plg.61.2024.04.16.04.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:28:11 -0700 (PDT)
Date: Tue, 16 Apr 2024 16:58:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Fix GPIO initialization flag
Message-ID: <20240416112807.GC2454@thinkpad>
References: <20240327152531.814392-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327152531.814392-1-cassel@kernel.org>

On Wed, Mar 27, 2024 at 04:25:31PM +0100, Niklas Cassel wrote:
> PERST is active low according to the PCIe specification.
> 
> However, the existing pcie-dw-rockchip.c driver does:
> gpiod_set_value(..., 0); msleep(100); gpiod_set_value(..., 1);
> When asserting + deasserting PERST.
> 
> This is of course wrong, but because all the device trees for this
> compatible string have also incorrectly marked this GPIO as ACTIVE_HIGH:
> $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3568*
> $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3588*
> 
> The actual toggling of PERST is correct.
> (And we cannot change it anyway, since that would break device tree
> compatibility.)
> 
> However, this driver does request the GPIO to be initialized as
> GPIOD_OUT_HIGH, which does cause a silly sequence where PERST gets
> toggled back and forth for no good reason.
> 
> Fix this by requesting the GPIO to be initialized as GPIOD_OUT_LOW
> (which for this driver means PERST asserted).
> 
> This will avoid an unnecessary signal change where PERST gets deasserted
> (by devm_gpiod_get_optional()) and then gets asserted
> (by rockchip_pcie_start_link()) just a few instructions later.
> 
> Before patch, debug prints on EP side, when booting RC:
> [  845.606810] pci: PERST asserted by host!
> [  852.483985] pci: PERST de-asserted by host!
> [  852.503041] pci: PERST asserted by host!
> [  852.610318] pci: PERST de-asserted by host!
> 
> After patch, debug prints on EP side, when booting RC:
> [  125.107921] pci: PERST asserted by host!
> [  132.111429] pci: PERST de-asserted by host!
> 
> Without this change, there is no guarantee that PERST will be asserted
> while the core is performing a fundamental reset.

There is no 'core' here, are you referring to the device?

> (E.g. if the bootloader would leave PERST deasserted.)
> 

I don't follow this last sentence. But even without that, the commit message
itself is descriptive enough.

> Signed-off-by: Niklas Cassel <cassel@kernel.org>

This is a legitimate bug fix. So you should add the fixes tag and CC stable to
get it backported.

But the patch itself looks fine to me.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index d6842141d384..a909e42b4273 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -240,7 +240,7 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>  		return PTR_ERR(rockchip->apb_base);
>  
>  	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> -						     GPIOD_OUT_HIGH);
> +						     GPIOD_OUT_LOW);
>  	if (IS_ERR(rockchip->rst_gpio))
>  		return PTR_ERR(rockchip->rst_gpio);
>  
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

