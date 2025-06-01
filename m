Return-Path: <linux-pci+bounces-28780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EC8AC9EFF
	for <lists+linux-pci@lfdr.de>; Sun,  1 Jun 2025 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837DA7A19AB
	for <lists+linux-pci@lfdr.de>; Sun,  1 Jun 2025 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64318E1A;
	Sun,  1 Jun 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeS/IFUm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4FF288CC
	for <linux-pci@vger.kernel.org>; Sun,  1 Jun 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748791430; cv=none; b=sK6kUkhUpAMNsdpw1nWmMZLAhxRx7yFbwr5XaG6N1qLvjEl8sEc70G2dKgufnVfSEOOEFajfP+k08f+zqYJ0Nh4Iiyfdvr2WS0IgrxqVt2OAdGmIF6F8kKeYYPmf533uyA+WcJfC43wHucyqq8qVqhIv72Nd5T7X4GIug5NgbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748791430; c=relaxed/simple;
	bh=awDyxNK92htKl6XKtbeqgZ2v4gNXbHrZXkiiIbRovzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvXi0TJY1PKx3uLd382mTHaAviVXwhvg8+cGLAc4WyOyMsIiqdj4Qkd20/gIcUyeRqdrAwx3MYMoRVimFtW0+FMaWrqY+zGM+XwAJJ8OJKThJP65R/OrwuMsGKine+Z21qedU1dHfCfijSe+4LpaXdAMDvvOQlQcfKZcKT3Ghck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AeS/IFUm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234fcadde3eso43201525ad.0
        for <linux-pci@vger.kernel.org>; Sun, 01 Jun 2025 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748791429; x=1749396229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/HdCnbvcFFV1hX8QFWwdms9CXcq6ISLWHzT3pbdzBT4=;
        b=AeS/IFUmW15Eq65Yq8GWUwbfEHdZCgE0VOxnWyr4zkQ38LBSL3lP7gcM7729kDz5PG
         CdJsGxMcRkmVLtAZAogouKe1nb6gRZgx01xH2dHuHuFXwjlBEVO4LjZDXQeF7Jx4XPF3
         Y4cBQ0y1S9vW4iF7xOhlojfuiSn6oAIGT5PVLzgJfth4Q5skwgrgDiasfuekl6uAHSP6
         DGLz1GUZ7u192gDlg30fjBZHokXL01ajwe3o5STl6tetMvD6/qqMJgmc6GKKBXCl7LCk
         Q5G01VI4T3p4eYaoQP9VN46WOZMvSlmpf9QGNA/vgDx/zcH1nQJ9RsPuPXUBFfeTZOac
         p/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748791429; x=1749396229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HdCnbvcFFV1hX8QFWwdms9CXcq6ISLWHzT3pbdzBT4=;
        b=spxTq9o96IauvlIZiHzmVlKncQUCzX/4HuLr93aFeP1k8z0uP3at4wqQRpwTq9H2bQ
         bgUnrEICrqX7k87kxVsNjqNZoaG41gqrP9YGEGHeiwb9JdNU4udgHlb/Ns+sU+nd74gh
         NuCHwYSSaZYovn6gH9CirSbc/sIKzmZNLsIPyAFAGvzU/4ea7Q4O1dTKMB33gIddk5EP
         bvDp+tVpSV3Rhf8D3DMk3HFydLsgyYgR3cI6ydi3flK/5kxh14KSEJ2mIcoekbn6CSp1
         jZQ1T7Kg4OqwMBWXtnsrGMwjYmc98J8p+BpGvpznP8nHjmxWGtk+FPJ/p28SgOmVW+pF
         +28A==
X-Forwarded-Encrypted: i=1; AJvYcCU+pqDWRviM4qQjZohVP583pW12OfHV000aCHbE0Vaqh6Dam8eRCMFj+adFph3IWUMHGP7Munym4Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXv6B+Y1cffwQmGYwFLJ4uL51nNrqJoTz0Tcry66cHEhQB/pIn
	VJeOKrIJ2i8yLbDMk8wktTOLMbyfbJctpeleAN8CaWVdLI+Y4sWsOuokmR97tc4vqTES+CGRgRm
	H9+A=
X-Gm-Gg: ASbGncvJEk5S9CQb5xGbyd37UHhcZh+BrPhy/ZRtVQVynItFglF4DC0FTvUUc0hHS/+
	E7uIe/WeXKvEpMi7cjO9XwKh7woQoRTtNgDsoQk5UcLvMpGF5Nm06SliYL+93jAfiK+3cI3jis2
	QkjcoRUWH9QbYZKEj9Lzn7C0Iz3ibeRMiin47s6ac9B7039YsVnNDot10MMG0V7dHPmILzwMiCi
	UXIwgGzCr9XHcc760JFgXdU0M1lzJrrd3+Hg81zX+M9REE/C/kfHls1587pZP3A2tJ9KK3/gKcU
	c+k12mEqSzHy5N6y4kk7cr0ICqFkMVejP08my/DYXuoQYG3KrZ8DB3E14rQcvs7RHfeUV6n2Tg=
	=
X-Google-Smtp-Source: AGHT+IGUdxmEKcnjoqEdCbuH6KK9aWHG/KH7U1DjnF6q5AY9MZlPYni+3+TOgk8U92OpiYvQCGwyQA==
X-Received: by 2002:a17:902:e842:b0:234:9670:cc8a with SMTP id d9443c01a7336-2355f9dca47mr79764925ad.24.1748791428646;
        Sun, 01 Jun 2025 08:23:48 -0700 (PDT)
Received: from thinkpad ([120.56.205.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf53a9sm56361895ad.196.2025.06.01.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 08:23:48 -0700 (PDT)
Date: Sun, 1 Jun 2025 20:53:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sc7280: Add wake GPIO
Message-ID: <wjduwhkgroqvzo25dwcspgrogz3orqab4tjosamxodvye47i4a@vd6cgknvx4nh>
References: <20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com>
 <20250419-wake_irq_support-v2-1-06baed9a87a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419-wake_irq_support-v2-1-06baed9a87a1@oss.qualcomm.com>

On Sat, Apr 19, 2025 at 11:13:03AM +0530, Krishna Chaitanya Chundru wrote:
> Add wake gpio which is needed to bring PCIe device state from D3cold to D0.

WAKE# GPIO

> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 1 +
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 1 +
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index f54db6345b7af6f77bde496d4a07b857bf9d5f6e..ebfe2c5347be02ea730039e61401633fa49479d2 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -711,6 +711,7 @@ &mdss_edp_phy {
>  
>  &pcieport1 {
>  	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
>  };
>  
>  &pcie1 {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 60b3cf50ea1d61dd5e8b573b5f1c6faa1c291eee..d435db860625d52842bf8e92d6223f67343121db 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -477,6 +477,7 @@ &pcie1 {
>  
>  &pcieport1 {
>  	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
>  };
>  
>  &pm8350c_pwm {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 19910670fc3a74628e6def6b8faf2fa17991d576..e107ae0d62460d0d0909c7351c17b0b15f99a235 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -416,6 +416,7 @@ &lpass_va_macro {
>  
>  &pcieport1 {
>  	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
>  };
>  
>  &pcie1 {
> 
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

