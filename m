Return-Path: <linux-pci+bounces-12416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A0963F8D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1414A1C2438D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D46818C025;
	Thu, 29 Aug 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFeu46MM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B418C926
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922608; cv=none; b=GUO09lCEMW69UHRrV98KGP+2ODV3EhmEy+bG4QrRZrw1BD3Dgm0THwIjhDo/2jXxgGuzmLV4eyK6o90uuK/IZqUD34X2/aRcfpwz80+SKpexHM1cwj15AU6ff4KJhUNFLwgLQZlWZj2A+hvY6VXe97xoWLdS2d8qsbcGZfqR38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922608; c=relaxed/simple;
	bh=tYHbZEyPmka4Yivy4HduNryMYDS8i6bX02kvNnY6E60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMuznenrXKGVVFraBn/voCYs9hFVgrz3jq9ltofnjCIYUHSuu6kpPU/7HGg/ZbPUgIsAnDNT7sQF6xulYchX+poifSzUw+43SPV+zGUaV2Qgof8yyrF8d0/kRusyq2azKJildBqzr5AmRGeEPpXGmAr4yn4bLnMToQZnAdD2jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFeu46MM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5343e75c642so538016e87.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724922604; x=1725527404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6NBn/HAssV3X2fUR8nleuDhVgAPEyHrLktSv5/fXyE=;
        b=kFeu46MMO6icQAvijxpfRGAQP3wq8BZnztYdcxKH2HTqfwCy1/Ek3nUFE8MMfEy8hb
         uiWDGQj+y/UTT6srut4r+o8CfbfsB+/Sk5FRKQ35tJj7dVabqkdZ8KHQfhZ9PjpQu+Gz
         IrBHVn3hj3unhNdhPSfa1P3BAF2K1WeXs+q6wp59jk3AN0G1w3a34Kcd/ZWFCVa4UFUT
         iPOKkEGcb+SaM3wMJhooQjntVn13K2h/YpUT6Tq7ZjoyFYx3Nbck5zrLNDDSNJfGPoBy
         vrhwu9+2BTwzxrJGycXsJalYX4rz8pVFSkX3NEKOhauLT9EQNPJnWE4WUyun6ZpW3uzT
         mWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922604; x=1725527404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6NBn/HAssV3X2fUR8nleuDhVgAPEyHrLktSv5/fXyE=;
        b=h9WOJ2vVSYh5XTyizmjrWoMIZzAM+Mu3KAbhfSes3nNYMTP1D63OoakfmQ+fyedawd
         OV/ITPuVsb+Kr/nMFLJbSbqL5GgBAHk12x3szmPuIP4O9FULfWuKKAp2wRp0D8J5N7nY
         uh0JeePBFWkmF1Kmmspzhw4JLDQBnKiwsuR6VSO+qvnEgl8Gh0S3v+Og2Tmo5GFiEno2
         bB1pfNeQeTUA6Fb6rVPWWXZkMe/NEq0u1OWT4BNZowjpxfJSgaSjTbD36FJO82gfYRD0
         4+y1l8CyqJpokfYrDeJWjRkpSY+SkVj43WOOcKkbwNNCN0bg2ZYkbdkTZFIo/aEuI4mo
         ExMA==
X-Forwarded-Encrypted: i=1; AJvYcCVqyzXSKM9BO10WSLvQkdkp8k/8LGm8idujlzYKPZw/rcv56LERTUwVjGpjX2yLH5qv+BgDs54/1UA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7aXtRw2VstY9Mz7m0y9ZNunCGON7nT5hGsn/BC+ropuL80fzk
	jH8AMnl30I6LkeyEZdkfwx6qIrOxNZvupqcowO9wgW+uRr2gCjCR5hQT11DnuJw=
X-Google-Smtp-Source: AGHT+IFvfk0TEfgAeIuX5KuN0s5sCC0/zMMfp6eawrjxG3Ca1XvBQuxc+Kts21vRxC+bjEIR5246Ww==
X-Received: by 2002:a05:6512:3d9f:b0:533:4820:275a with SMTP id 2adb3069b0e04-5353e5bf517mr1240266e87.52.1724922603591;
        Thu, 29 Aug 2024 02:10:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540827b28sm100441e87.140.2024.08.29.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:10:03 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:10:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, robimarko@gmail.com
Subject: Re: [PATCH V2 6/6] arm64: dts: qcom: ipq5018: Enable PCIe
Message-ID: <nut3ru5rdjf3k3np47gqbpuczvpsuoismx6hp55ivc5mqmdglz@zyzbra46i6iz>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
 <20240827045757.1101194-7-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827045757.1101194-7-quic_srichara@quicinc.com>

On Tue, Aug 27, 2024 at 10:27:57AM GMT, Sricharan R wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Enable the PCIe controller and PHY nodes for RDP 432-c2.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v2] Moved status as last property
> 
>  arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> index 8460b538eb6a..2b253da7f776 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> @@ -28,6 +28,15 @@ &blsp1_uart1 {
>  	status = "okay";
>  };
>  
> +&pcie1 {
> +	perst-gpios = <&tlmm 15 GPIO_ACTIVE_LOW>;

pinctrl? wake-gpios?

> +	status = "okay";
> +};
> +
> +&pcie_x2phy {
> +	status = "okay";
> +};
> +
>  &sdhc_1 {
>  	pinctrl-0 = <&sdc_default_state>;
>  	pinctrl-names = "default";
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

