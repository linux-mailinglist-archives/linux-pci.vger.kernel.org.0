Return-Path: <linux-pci+bounces-24008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2FA669AF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 06:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DC7188A793
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 05:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9C21DC05F;
	Tue, 18 Mar 2025 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtmDtES4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D128373
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276587; cv=none; b=e7G+Eh8Z7NQtQJnH1Xw7NOcAiaacxe5o7DCacl645mxX/VEozg+4L8u8OT2TPOtjDC6SkTkjm3IGgihCpBt4LVdiejOtNe1a6JVjljW6vlSrIGv1Zp0bgOKjGXmtOJZ6wP35JZRSs584uY6V/0c6E5NAWkV1FBmVQivPDIRxZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276587; c=relaxed/simple;
	bh=pTkKiqBvzqQ4A08SySDFb1VvCKVdJT+dQzkGmZq4KOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmx9waXlOTRQoyUfUZ25cXDDgWDlQXjgwE/vAmeAaTNHYzahn9iYuiwMNoaK41daco/LrJxiiktahynlocRMP/qKQIAOx7kJEI4/hvG1WDHSJdQFa4jnCwD7RyvKcELyrw0XBrDdhwla5EltvEn1/dyIgDPqKdjkEjGXSj6Bq5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CtmDtES4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225e3002dffso52881545ad.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 22:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742276586; x=1742881386; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FEoinY9MBp6fBxPU4owelu4oiM4ylGd59Qy+F2Dob3M=;
        b=CtmDtES4wZiSXVNIoMq9TQWWn6/XRVk+yRor3HsYaDDurJ77aFbHs3LNxrJMTO4FIq
         AI+g4+MiWbhPrB8dhcb5nnZKZuqFQ7E5DCYZqsgPT2iUh184oUFWHToVn67PYyMEJL0h
         96b+xfhmPKXqdIKtsYAwvxp29PY8wh7wUoHAQlUbD4FbBxjQdT6bK0kZGYgcQVrxWG3r
         cTudyLrAPpEMZiUbeYENd8GqLQWREda3JknLg8v6I4TwwNxH4+NICcaO0VGRA7Um2yAr
         DogmpxI9TOz80lmklqXztiZAkZXXRF3UhXYasybum6OSojuojMSoCO8hiLjGV5SeNew1
         RTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276586; x=1742881386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEoinY9MBp6fBxPU4owelu4oiM4ylGd59Qy+F2Dob3M=;
        b=qySSx20oQ0jgwk07T1fVeaWUOqfZp7kAwtbBX4/9IjlIH+5H/nGIe3ofA4d00vC1BV
         bIWXKcXbohMbhRr8h5oq7yLYikjYAyOoLqhIS4Q33rokmiiIYD235Kr65e47KytuwlgD
         iApv+TFxWkOZ8/4X2GVesZ7JDMhWm5yLRshlAIlRYhavu/hMC7DQJeZIvImYYzrw7p+5
         +sAUyObpNa8PUbw5zb0KCdkVhtjx7cH4Pg1Qs9hCNArldx57eni/w8ZGnLAgt37m2GqN
         tBqTVdLv6z9ad1o3hhXYTjVRy3U+iyo3mDNNP5xe4V4MGbgjKY4bYKK3x1fOT/IRtXQS
         KGPw==
X-Forwarded-Encrypted: i=1; AJvYcCX2pq2x24IyL00F/SU+6AaEgVX/KSzodXlZIobfBtyTEYmI0lzMiQ1b3JHCYx9aDz1xwFAZqIezgZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySIIsl4gO6s/bGWfM6Cs6PxPcLnW8He0U30ltSeQwVKnv9OYCE
	uZa9yP4p6nSbRQeRkUjkynz2yw0jDTC2mET438x+ez9cQm8WX+g1+Nw9cG/Siw==
X-Gm-Gg: ASbGncvJUx8vz+30brLV6i6ETXRepohySRhTzL/qieud4PxxhGudSVWt/cE/rA7Baeo
	FfEJPfLsfyJoVvLKvmhu2BZ4aCfNoHZDa/p51gcQwxLiLhPcJPAfG2iT91I2SW7nydVFmH9TrmD
	rehuXpAvmWzneqjHR4Quw4l7kW7TDRR3c+g0MQmY2RF9dQgqXnpTVYIxm/kTuEo0uWPywGZByvu
	bNqWJ5FM7H1aZelNZs6CzOPkQq79PntfYFdouzNtBWUOTKjpWvCrRJfncohZx6R9gTHwKq3X25W
	nwpCAUPPlnGRgS47JzkabZAAbCDVg1Lt9I6RfZcKl1PC6oWVZupcUvzg
X-Google-Smtp-Source: AGHT+IHFAYycRh8yAvQ6rzKtJ7IEEozCZPfvduhinevYL/RlGjWqSKDVBSpP0w/WLSUpzr4TkOvmSw==
X-Received: by 2002:a05:6a00:98f:b0:730:7600:aeab with SMTP id d2e1a72fcca58-7375723f9afmr2788650b3a.13.1742276585611;
        Mon, 17 Mar 2025 22:43:05 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711578a67sm8596953b3a.78.2025.03.17.22.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:43:05 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:12:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org,
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com,
	johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: qcom: qcs8300: enable pcie0 interface
Message-ID: <20250318054258.roq5zifhqfkjge4e@thinkpad>
References: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
 <20250310063103.3924525-7-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310063103.3924525-7-quic_ziyuzhan@quicinc.com>

On Mon, Mar 10, 2025 at 02:31:01PM +0800, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe0, board related gpios,
> PMIC regulators, etc.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

With subject change mentioned by Dmitry,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 40 +++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index b5c9f89b3435..c3fe3b98b1b6 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -285,6 +285,23 @@ queue3 {
>  	};
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-0 = <&pcie0_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l6a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +
> +	status = "okay";
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -310,6 +327,29 @@ &serdes0 {
>  };
>  
>  &tlmm {
> +	pcie0_default_state: pcie0-default-state {
> +		wake-pins {
> +			pins = "gpio0";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		clkreq-pins {
> +			pins = "gpio1";
> +			function = "pcie0_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +	};
> +
>  	ethernet0_default: ethernet0-default-state {
>  		ethernet0_mdc: ethernet0-mdc-pins {
>  			pins = "gpio5";
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

