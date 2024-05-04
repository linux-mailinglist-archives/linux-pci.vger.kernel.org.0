Return-Path: <linux-pci+bounces-7084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 411FA8BBD5D
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 19:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7294F1C20C21
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E15BAFC;
	Sat,  4 May 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXwV275C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1871DDF5
	for <linux-pci@vger.kernel.org>; Sat,  4 May 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714842653; cv=none; b=gWeIrRbm35euNsAr0SsaaJftON3CyjzrOA6iD69R2rG4VrcpdvvvgqO76h4xz1KyOhQEqb1my+UegTiKRFYLGk3DQ6jfytCqzQiFyoxCZgyJS7oQUBq0xgwhJIQWgWCvfYr4krGemm4IYJY6hylcI58YAY8snQKduK60xBvCwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714842653; c=relaxed/simple;
	bh=4zWlB9ELLXciZRFX9WaVQSkVSrpa+SxUQuzk3sSq8wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/vSp0mdAqpXiuHAgiVxUMR1yZa54E3PTlrHYvME23JVqFR9gNTRUfOfZ6erdLvghPlLU1t0Rt8zBgysoYK9PxOPg+OAaAFX/GyZ7h7fj4mVJh9cy5bIj5yV322OMNmxK2IjDZu+E1yvtTliFL2wyPq2gsy0jm6XWHyl4hWFdwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXwV275C; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5af88373b2bso312622eaf.2
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2024 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714842651; x=1715447451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kGU68AItjJq66EYQsay+bIfrsbCqzNm734dFQJXi/jU=;
        b=oXwV275CkwlDUQ4F3CuAKHcIbq1jt4eIfuYlKMJDRW4TU2XjwfQdU3MV4RYEDvMx4s
         RJhB/D5HGOPESOFMggGhs5App2hW3EH3bt1Hleg4XVkQ3zOdmFAK1wRtJKW4HB2KHrtR
         PKjcxISAe2va3WabRJN9/MnPZV7hDmJdp0HNlyk6z+6zTEK6o5UnAEuwlMq57EE+Xuns
         2zOwB4Ux63Mz3emGJYpeNzYM40wvzB6X6KYq6jT37CeoCjKc9N38Ijtrpx9cZieE7uGr
         0hFrabKDWpC2FjXb/pptw3plFILyRzewRKo1ZNUN65IHzAYRnK8zAFoBq/UDA845Fh4m
         Ohiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714842651; x=1715447451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGU68AItjJq66EYQsay+bIfrsbCqzNm734dFQJXi/jU=;
        b=L8ANaySVkr+BGSeAEFVykp4dukBwPBFKYr2WSRGaDzXltnTi9csz5LdIWcvKfPQTo2
         /kW+h24D4z/LIh/i/9GEYcAh2cZEIhhgPN0OgnwFuwxFx5lWxqluu96kb0esmRdlbDd7
         cZaUsfpqyjTeR3y+BkKYfJMntYwNgGWDX5DPEPSFzWLncC/uLxGacdd9WIGGIf2QH8Na
         yAsJKsl/ed4IRJ2iTcC3xE7E+rADSnELWVtSMB0XA1eLS9Q5smD6BMmP69ULXWadpNS8
         0VYxu22QCUfFUznbkzJy+pvuhn4XvAx5N3woImwi0CUZ84mb+7jDLiIXscWYhvhTI6Mz
         uBbg==
X-Forwarded-Encrypted: i=1; AJvYcCUzAtNA+23GQTMIuS9XUyXFaKcTADZ/O0HO2Yo2pqOHBcUeF7GlvR0KHHHckCXzj/WEpX7Pa6nbN4Qgy64EmlC8eR7xiGMTInAK
X-Gm-Message-State: AOJu0Yz6rLWBipR0jIkjNDyjJI8ZqlYzWw+67KFVsllved+25bazL7yp
	JBwEtfBpQnSG4/EoREsTD00TIj+HHsyOnMoTYX+Jj4XS95G/iio1cH6Kig5Xdw==
X-Google-Smtp-Source: AGHT+IFJVDzJg8s7tJ4sBXK2hFo/zSW5S8i9XoOlihWop6UkHNr3AIcAH8pWHiMxlx3VUxjbd0KQ6Q==
X-Received: by 2002:a05:6358:7f9b:b0:186:1128:bca7 with SMTP id c27-20020a0563587f9b00b001861128bca7mr7344848rwo.6.1714842650536;
        Sat, 04 May 2024 10:10:50 -0700 (PDT)
Received: from thinkpad ([220.158.156.237])
        by smtp.gmail.com with ESMTPSA id p11-20020a635b0b000000b005e2b0671987sm5050563pgb.51.2024.05.04.10.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 10:10:50 -0700 (PDT)
Date: Sat, 4 May 2024 22:40:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 07/14] PCI: dw-rockchip: Fix weird indentation
Message-ID: <20240504171043.GD4315@thinkpad>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-7-a0f5ee2a77b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-7-a0f5ee2a77b6@kernel.org>

On Tue, Apr 30, 2024 at 02:01:04PM +0200, Niklas Cassel wrote:
> Fix the indentation of rockchip_pcie_{readl,writel}_apb() parameters to
> match the opening parenthesis.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index d6842141d384..1993c430b90c 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -60,14 +60,13 @@ struct rockchip_pcie {
>  	struct irq_domain		*irq_domain;
>  };
>  
> -static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
> -					     u32 reg)
> +static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
>  {
>  	return readl_relaxed(rockchip->apb_base + reg);
>  }
>  
> -static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
> -						u32 val, u32 reg)
> +static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip, u32 val,
> +				     u32 reg)
>  {
>  	writel_relaxed(val, rockchip->apb_base + reg);
>  }
> 
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

