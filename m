Return-Path: <linux-pci+bounces-17106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB959D3913
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 12:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9BD2855E1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B461A0716;
	Wed, 20 Nov 2024 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6aE34ft"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4B1A01C5
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100635; cv=none; b=dEY9PYB2M3jCaZ9t8ORW3qRo+zkTfX7dgu4lYHO77VvuzlSEGKGwgcy+UeO6uvQyoog03YbzuJ8QMm/O4PJokeSCbLPsd5+jJRjo6Ng+qkV9HYFgCWADT/D0WdWEXn5NiBUqBub/Popki4dYZaDNHdIkedZZPLoKZJXXqG7bZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100635; c=relaxed/simple;
	bh=51da7Scr+wJ8FolwX9QOvLfE708ORLCtlVruNxLQapM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeHtpm71s5PpcwI9XkeuwoJyeV1XRIQ3nm8KANrdrtwtHRlkAmJB3tKGtA5PBuiQTCBLFHwVr7Csj8E86gpdVv4qhMIPrW7G7uOi4jWsHxiisKhcMqc+2eko2Jk4q3X+Slcbn6s1PQUL10uA/URac9qTFXNPbt4GPWfjsuzDfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6aE34ft; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53a097aa3daso3944838e87.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 03:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732100631; x=1732705431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5fy1d8+UghoY4M/hZS/USl87W9iAjgJP2RjsbhXWyo=;
        b=j6aE34ftMr5px7jezEVbBi4LoPZyi0og+m6Jhhl3XYpQGWSIfW2uEVvvuKhsAy+e5q
         NJZEGECEi2cpUp5KnMCm70Z2/mQe9UI5nlRs+6e2KkVyVYEDG7viMJqEsN49Zh4M4r3z
         vmWsrnTmRamY8Wz9HzPuE9gzgHx13DOM+Pl864+LBLCDs36CwZHEjG1KeAb2FWUqsirI
         BBjFKiDoo0srHkkhHajrlTFoVXp4nKekgD7wzLShqIume1UhgJzm2/3YAedsemHwUfWj
         CMCPjYZYI8LsWhdbCg8bF19Fap9tN98DqxeuP8jwbismI7Q3f5gR0zCXPYiPAIWIeBPm
         W/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732100631; x=1732705431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5fy1d8+UghoY4M/hZS/USl87W9iAjgJP2RjsbhXWyo=;
        b=aPQbFQdFzdtyuERNTyPRtnzmhPmXE2v1DwBpchKHoka3jGN6oIqkxP5PWJK2L0M0v/
         +XmJlqqGWJNs3o4RDpDA1jflFVb0l3VH6wLP7pFHR6jzyqwU4TYoZBfC/TKp1xB6zZ9I
         R4wvOTikwngUL76zSxpv2savOJMs0cBY6qbJuQjaR1wNEjY03Y82CdqAQ7YceAa7HfQT
         hz337Sr9rObTs6rm7s3cxAm+fjtteNhevxYgXBfWseLGN4zUoRGYVYjsLrVD8KkG1bC8
         QsOXm/JASeK17vKRbFUsNg0IFt+kJY0g6oBqxkB8AK6L3yvE5Q9NVukbUFx9afAkxsw0
         2+kg==
X-Forwarded-Encrypted: i=1; AJvYcCV/sMaP0e8mwysH/pFkf2yx5/Em47AQcwKpBoPMvc0hVTqpOcUZcyD2wDtDHW+Ye6EE4Ckmolor7lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXsqI65Dl+Ufd4JkPH26F0osmKYzXolesn6HN9Xz7VSVdH27p
	6i3lz0CjH6Uar2lzpg60WQMwBeP8oJoWoQxiF4UYrpWZo1iQbLFUmeL6xsE0LqQ=
X-Google-Smtp-Source: AGHT+IEaeUFk7J0GOx+aGQ6PoppIgZUoJzKx6NLhpJoEcTJX/h29Kv3h4NGGKJ1gX4RNnB6oq96Ipw==
X-Received: by 2002:ac2:494c:0:b0:536:a52d:f94b with SMTP id 2adb3069b0e04-53dc1327ec3mr761273e87.8.1732100631572;
        Wed, 20 Nov 2024 03:03:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd4671fasm593075e87.150.2024.11.20.03.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:03:50 -0800 (PST)
Date: Wed, 20 Nov 2024 13:03:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] arm64: dts: qcom: qcs6490-rb3gen2: Add node for
 qps615
Message-ID: <yjwk3gnxkxmhnw36mawwvnpsckm3eier2smishlo2bdqa23jzu@mexrtjul2qlk>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-2-29a1e98aa2b0@quicinc.com>
 <ngjwfsymvo2sucvzyoanhezjisjqgfgnlixrzjgxjzlfchni7y@lvgrfslpnqmo>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ngjwfsymvo2sucvzyoanhezjisjqgfgnlixrzjgxjzlfchni7y@lvgrfslpnqmo>

On Wed, Nov 20, 2024 at 09:06:03AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Nov 12, 2024 at 08:31:34PM +0530, Krishna chaitanya chundru wrote:
> > Add QPS615 PCIe switch node which has 3 downstream ports and in one
> > downstream port two embedded ethernet devices are present.
> > 
> > Power to the QPS615 is supplied through two LDO regulators, controlled
> > by two GPIOs, these are added as fixed regulators. And the QPS615 is
> > configured through i2c.
> > 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 115 +++++++++++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
> >  2 files changed, 116 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > index 0d45662b8028..0e890841b600 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > @@ -202,6 +202,30 @@ vph_pwr: vph-pwr-regulator {
> >  		regulator-min-microvolt = <3700000>;
> >  		regulator-max-microvolt = <3700000>;
> >  	};
> > +
> > +	vdd_ntn_0p9: regulator-vdd-ntn-0p9 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "VDD_NTN_0P9";
> > +		gpio = <&pm8350c_gpios 2 GPIO_ACTIVE_HIGH>;
> > +		regulator-min-microvolt = <899400>;
> > +		regulator-max-microvolt = <899400>;
> > +		enable-active-high;
> > +		pinctrl-0 = <&ntn_0p9_en>;
> > +		pinctrl-names = "default";
> > +		regulator-enable-ramp-delay = <4300>;
> > +	};
> > +
> > +	vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "VDD_NTN_1P8";
> > +		gpio = <&pm8350c_gpios 3 GPIO_ACTIVE_HIGH>;
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		enable-active-high;
> > +		pinctrl-0 = <&ntn_1p8_en>;
> > +		pinctrl-names = "default";
> > +		regulator-enable-ramp-delay = <10000>;
> > +	};
> >  };
> >  
> >  &apps_rsc {
> > @@ -684,6 +708,75 @@ &mdss_edp_phy {
> >  	status = "okay";
> >  };
> >  
> > +&pcie1_port {
> > +	pcie@0,0 {
> > +		compatible = "pci1179,0623";
> 
> The switch is part of SoC or board? This is confusing, I thought QPS615
> is the SoC.

QCS615 is the SoC, QPS615 is a switch.

> 
> > +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> > +		#address-cells = <3>;
> > +		#size-cells = <2>;
> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry

