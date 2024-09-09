Return-Path: <linux-pci+bounces-12951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571E1971A17
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 14:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C941F23C84
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8931B86DB;
	Mon,  9 Sep 2024 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3MRwOE5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218071B86D7
	for <linux-pci@vger.kernel.org>; Mon,  9 Sep 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886500; cv=none; b=GkQfRz1HJzlwZEldLaFrzoQFMXJiv+hKz8EAv0Xwn/mHlAArmdixlf9YUeLvzPAH85T4jkGNJr6i5f/WofuxOLGpDPHumgxU9YdkCtjWVqClctbvg96lHR6sUgK7G/dRjOCpkB4fe3D3yyLkPADWHRDBGF7Iiaffy7U00sc67JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886500; c=relaxed/simple;
	bh=UDGhkNI0M7kuGd7p3qibJwxvklGXI2aQI7UyDV0e0gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knF+TLVm8uKCgvhaW21f+1olPby4slddDwnC+rWvvvwMmvmgN2vDMgVpUmG3yU4wvatnNkjSWIvi0pLboFOekLktu9m2VD+xmN1YuF3QiVx27ixPaAUgPnCNzEh7NyvXjcfWv8lC/JkstAmmKcWjd2yp7M8oPARRqQG7ws3F554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E3MRwOE5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53662965a05so2050239e87.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2024 05:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725886497; x=1726491297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aoQfWC0WIgkU+JAyFpv435nDlVdA+1zeJRTTK20PmCM=;
        b=E3MRwOE5lcx68jGoZ/xmXUezUz3PFrVOF0IRXawCioRQ8fJf9i1ZBDM6lZVE9dUhJ9
         TaSQZWEBYH24ppcdkavClIn9oUAukJxWJ0QhP4MT+Xp20Mj5GrEMgL5R8oJd1paSSjbx
         yB50yDaGwCEnDSJd0Yam03jszjYZ0CK/8gLOjIwYOBOIZBV2BU+tx6C71Y+jqTgTl+pe
         ueh5NyqOolFEXMG+vJA5n2Fu4mOpPZ25mSAugV84N3RtIM24df+eZ0+rjLaba4ZMRI/M
         D65nCleFkhjdUJcdDYpAakDoZBQAXvjWJSwrz8C/HNz5qWK1H6fmExBBMclV9vZxUjTH
         8eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886497; x=1726491297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoQfWC0WIgkU+JAyFpv435nDlVdA+1zeJRTTK20PmCM=;
        b=v7dSXlQlhPIeDk4tHk487ns+87sgeW5qjx7OVDvi8HA0PBOkzL93mICMgfgjKrHdZd
         9EO4uOdeGAIeJ6lwDTRp56HgoB0qQdFucXiAusJN4tjjd763Xi5yG1RBdH7lKV4ecWxy
         RaOK8VW1GaLrRD5xN83t3KSPOXtMTNmcHQbdKk69j3fl9gSEnLVY3xOWwG2/4XbYOjgt
         8nbjPpXMnpEGIZaoAWq73Kjm1fTATz8ScYWisNG9VJPx476ATrBGdU60nSc1XRwgvA0d
         ud+VkPe6/YxM4xb+5uW0MHuAvdz9cs9TAunvfibcXPl5PsMWT73KsySWB77MnWwRygt4
         7kkw==
X-Forwarded-Encrypted: i=1; AJvYcCVt7X+jOUbMq8sycPzcE+W+k0PJpU3Eqn33lmcyKEsUL7++S9DoxWb1jJk3oE2xBgu+fXAFnR2HBXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7WneQQENd8Zv/onSMFOpgkWvOUXzPL9doPJI/F9QF+r73IuN
	+HnqqZXWPZROXpo7s2yQWIfk6IeVsiF8M8PV4S9IdAciuTqV6jHE1mBRgFpfM+U=
X-Google-Smtp-Source: AGHT+IHY52MM53GPC09wbzWz1Cyp8hhoW/Xua4ApC2+jwFWkiSNQK0NA6BgYergsTF3VF6CAWDJ8WQ==
X-Received: by 2002:a05:6512:1289:b0:52e:9fda:f18a with SMTP id 2adb3069b0e04-536587f5be1mr8339084e87.44.1725886496363;
        Mon, 09 Sep 2024 05:54:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f90d8c1sm760815e87.292.2024.09.09.05.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 05:54:55 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:54:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, andersson@kernel.org, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 3/8] arm64: dts: qcom: qcs6490-rb3gen2: Add node for
 qps615
Message-ID: <pb3imt73gsa5gecqeazwltwnuiq25jxhppl4wjhmd3dghhtvgz@wovxp2a7t54u>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-3-9560b7c71369@quicinc.com>
 <1932646a-b138-48f3-99bc-17354a773586@linaro.org>
 <6bdfb6fc-f375-bf03-7d39-8711c0bee40e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bdfb6fc-f375-bf03-7d39-8711c0bee40e@quicinc.com>

On Mon, Sep 09, 2024 at 05:21:22PM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 9/9/2024 4:59 PM, Caleb Connolly wrote:
> > Hi Krishna,
> > 
> > On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
> > > Add QPS615 PCIe switch node which has 3 downstream ports and in one
> > > downstream port two embedded ethernet devices are present.
> > > 
> > > Power to the QPS615 is supplied through two LDO regulators, controlled
> > > by two GPIOs, these are added as fixed regulators.
> > > 
> > > Add i2c device node which is used to configure the switch.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 121 +++++++++++++++++++++++++++
> > >   arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
> > >   2 files changed, 122 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > index 0d45662b8028..59d209768636 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > @@ -202,6 +202,30 @@ vph_pwr: vph-pwr-regulator {
> > >   		regulator-min-microvolt = <3700000>;
> > >   		regulator-max-microvolt = <3700000>;
> > >   	};
> > > +
> > > +	vdd_ntn_0p9: regulator-vdd-ntn-0p9 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "VDD_NTN_0P9";
> > > +		gpio = <&pm8350c_gpios 2 GPIO_ACTIVE_HIGH>;
> > > +		regulator-min-microvolt = <899400>;
> > > +		regulator-max-microvolt = <899400>;
> > > +		enable-active-high;
> > > +		pinctrl-0 = <&ntn_0p9_en>;
> > > +		pinctrl-names = "default";
> > > +		regulator-enable-ramp-delay = <4300>;
> > > +	};
> > > +
> > > +	vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "VDD_NTN_1P8";
> > > +		gpio = <&pm8350c_gpios 3 GPIO_ACTIVE_HIGH>;
> > > +		regulator-min-microvolt = <1800000>;
> > > +		regulator-max-microvolt = <1800000>;
> > > +		enable-active-high;
> > > +		pinctrl-0 = <&ntn_1p8_en>;
> > > +		pinctrl-names = "default";
> > > +		regulator-enable-ramp-delay = <10000>;
> > > +	};
> > >   };
> > >   &apps_rsc {
> > > @@ -595,6 +619,12 @@ lt9611_out: endpoint {
> > >   			};
> > >   		};
> > >   	};
> > > +
> > > +	qps615_switch: pcie-switch@77 {
> > > +		compatible = "qcom,qps615";
> > > +		reg = <0x77>;
> > > +		status = "okay";
> > > +	};
> > >   };
> > >   &i2c1 {
> > > @@ -688,6 +718,75 @@ &pmk8350_rtc {
> > >   	status = "okay";
> > >   };
> > > +&pcie1 {
> > > +	status = "okay";
> > > +};
> > 
> > Isn't it also necessary to configure the phy as well? It's also default
> > disabled and has two regulators.
> > 
> There is one more patch series which does this.
> 
> https://lore.kernel.org/linux-arm-msm/20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com/T/
> 
> sorry for this I should have included this in cover letter.
> 
> I will squash those changes to this series or will update the cover
> letter.

It was sent in February, you have received feedback and several
suggestions on how to change it. After that you've never reposted it.

So, no, it is not possible to depend on that series or to include it in
this patchset. Please follow the thread and rework that patch.

> - Krishna Chaitanya.
> 

-- 
With best wishes
Dmitry

