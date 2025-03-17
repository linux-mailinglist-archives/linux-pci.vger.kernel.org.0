Return-Path: <linux-pci+bounces-23923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EF5A64C7D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 12:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A31F188DD3A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5332356D1;
	Mon, 17 Mar 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b3xYLOo0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F121A436
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210867; cv=none; b=g57UYBE3gxCrzN9rLi736aZJjlfvdlldeAGEqqdvXppYYMU/yJVQQ/t8BTlmMqiNcW2HJwTr4lnOdCIkC8PeoJyLcw2c1LfVlXQv6pPsP63NS9Jui7Gj7RNfMDdko3clQXi0OA/w7doL3+34HsC8vnq9SmfhNbhJyYFwEtJOEBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210867; c=relaxed/simple;
	bh=JiU79bmCJxOwRp4oAbETla+RO60mQJSftJKMO9L+DTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkHJaX3dRQD1NRq/dRgn6NCbSdvIsZs+bA4oWlRJR4PNon/IzTtGzxjAsnInupJC+40ob+dCAoSqbKRJdpqSy+2bsbc8NAUmIY9oVZnaIl8Kl/0QdT8DcgT/MMeNXF5qiQfgvcc2dPMKOEzQHQ/WgueyQHcaUEs9l6sZdb6cjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b3xYLOo0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H98bF9016450
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 11:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ks6H1Qe4LqVgg5DG9PYOBphr
	rgmZjuWkDZ+NJuoP5cU=; b=b3xYLOo0wdLbXGQr07iIEukKPKy0hFn8wL0YPyNs
	nqGjRcsC2lSNX/7+wXy9tzpxJTvOFc3vENEb+dPZ6j7AA0RIU36UN2aPY4kyDilZ
	Vt8EO1SHDBhS3Uwe5ZSfVSyQhNk5cf5VwQfW+/chuXu+qG0MqZxmwVxnw6NUKy5J
	xm2fXaKR9cYjoJZ832RaQTauti/YNG1MeRcnwQv0644XuX722m6uky8qTqgQOgIp
	aFwrZvg+IxUOm4bUJSmY4qbCDDD8ezeJTsI2fzHQieEfP8dxJuKx86cCDtQKtTwv
	NM/4Ywr/it7G6mJAyGfllLDcYK0/HPOruyuA7uJAl53a8Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2qm4e5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 11:27:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3b8b95029so623828085a.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 04:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210857; x=1742815657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks6H1Qe4LqVgg5DG9PYOBphrrgmZjuWkDZ+NJuoP5cU=;
        b=evJYTOvMWu+KmVjx0mA7tMYIvu5ABNmRl3QETjUg5t0TAZyfX4gauVvMQ1CLv5on8n
         1wJYNe6kXFdf9KumnN10UIrP31qRAHJ28XIuqo4tat/6qzO/xcd5gmy56Y7HUe0SGEGS
         HDyAJerkCzlHlwxd6nXdqdD3mWm69+OlUTbrAVWGCMh7tYbGHQ73+aDj8Tb/XA1HhDHM
         +N1vj0GiaEXccIGcall2l3bJoGZbrJ1fex09WZZrl4KkDi00DG/4qfuDwHfK8d9FLPZe
         WniIiSgWORuZHhuzFQDnSYLiOxi2hF1PSEEmK0BhH4y0Vhyhzi5xqUfCkvTb2SiaYG5z
         rQTw==
X-Forwarded-Encrypted: i=1; AJvYcCVFKnNZFJbVCC8WST/rNQmriP6ZjQdAd1OX+cw6JGQBzuvUfpo9yxGctw9e2XTnH2wvzZU9T9p+RXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2i6Sr3ToMU/aPRrWTyaZUG5XBg31q301Zcy1SFcTfQqVg8rBY
	Ofb03j3FeddoaemIzALgfJihquQtjwzFAQbaYF9tiES5IMDSOteOQXqVjL5kGtwT3XGSwFeC8z2
	HHwH2nZpwdf/1CdgansUTt81Ib4oL7qBmKqGLkBC4QMMdtN4g0RdXdeRy+OY=
X-Gm-Gg: ASbGncszwgtFp8e6/Fz4mVnHtY95JDsOtuyYZ97EGfFticRoglfvPucwpPXjz3MZs2u
	V2ORFJLDcDrxHtkGZc2qgEyWer88HwOsz0KbcID8EoRvuhYjOf/tPrfIPGlHzs8f13Eo3TAttQ5
	5RbQAttc2OFdoVL6vnRPhoQ+f3/VsZTGh6sXG2IO/WR0vbvoHYSZWTmdidGfJHsGNLb09S7BnPT
	+NDJmSLcY09IJeDk1wuYxouU4psuun2oYNZzrjVx12iKQRnLqUa7TT6tJAJH7mdO1YJSVb+0dRY
	LbmjoxQdZZbj52FKNJSuOTPWXLxFKjTZHMQGDmO79z3sSo6bGZEPUfB3M5w+RhtYwzrtjOrz+2V
	oLsw=
X-Received: by 2002:a05:620a:372b:b0:7c5:3df0:48cf with SMTP id af79cd13be357-7c57c7b99edmr1608500685a.3.1742210857635;
        Mon, 17 Mar 2025 04:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgmKbqNlFcHOVK7QmTXPEEAfaypemgHDiFvZ5/SKCUl+uj1n4jhLXU7saD/jBY49l4D08veg==
X-Received: by 2002:a05:620a:372b:b0:7c5:3df0:48cf with SMTP id af79cd13be357-7c57c7b99edmr1608497685a.3.1742210857270;
        Mon, 17 Mar 2025 04:27:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1dbb12sm15187661fa.95.2025.03.17.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:27:35 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:27:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Message-ID: <c4ompv3t256tl4qosapvtt5fkk5wwqxikclwwuyffvvbu6noig@y2y3hhf24mtf>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <ciqgmfi4wkvqpvaf4zsqn3k2nrllsaglbx7ve3g2nbecoj35d6@okgcsvfx27z5>
 <6e51e35f-78c3-5d2b-697e-ce4a7da7b15c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e51e35f-78c3-5d2b-697e-ce4a7da7b15c@quicinc.com>
X-Proofpoint-ORIG-GUID: 6d5dqaApV5m7ZJlUsfg1HurbnCvqXcZw
X-Proofpoint-GUID: 6d5dqaApV5m7ZJlUsfg1HurbnCvqXcZw
X-Authority-Analysis: v=2.4 cv=DLWP4zNb c=1 sm=1 tr=0 ts=67d80730 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=iBLCvXWk7JtlIUnLWUQA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170084

On Mon, Mar 17, 2025 at 03:05:17PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 2/25/2025 5:19 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
> > > Add a node for the TC956x PCIe switch, which has three downstream ports.
> > > Two embedded Ethernet devices are present on one of the downstream ports.
> > > 
> > > Power to the TC956x is supplied through two LDO regulators, controlled by
> > > two GPIOs, which are added as fixed regulators. Configure the TC956x
> > > through I2C.
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
> > >   arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
> > >   2 files changed, 117 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > index 7a36c90ad4ec..13dbb24a3179 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > @@ -218,6 +218,31 @@ vph_pwr: vph-pwr-regulator {
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
> > > +
> > >   };
> > >   &apps_rsc {
> > > @@ -735,6 +760,75 @@ &pcie1_phy {
> > >   	status = "okay";
> > >   };
> > > +&pcie1_port {
> > > +	pcie@0,0 {
> > > +		compatible = "pci1179,0623", "pciclass,0604";
> > > +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> > > +		#address-cells = <3>;
> > > +		#size-cells = <2>;
> > > +
> > > +		device_type = "pci";
> > > +		ranges;
> > > +		bus-range = <0x2 0xff>;
> > > +
> > > +		vddc-supply = <&vdd_ntn_0p9>;
> > > +		vdd18-supply = <&vdd_ntn_1p8>;
> > > +		vdd09-supply = <&vdd_ntn_0p9>;
> > > +		vddio1-supply = <&vdd_ntn_1p8>;
> > > +		vddio2-supply = <&vdd_ntn_1p8>;
> > > +		vddio18-supply = <&vdd_ntn_1p8>;
> > > +
> > > +		i2c-parent = <&i2c0 0x77>;
> > > +
> > > +		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
> > > +
> > > +		pcie@1,0 {
> > 
> > PCIe bus can be autodetected. Is there a reason for describing all the
> > ports and a full topology? If so, it should be stated in the commit
> > message.
> > 
> As these ports are fixed we are defining them here, I will mention this
> in the commit message. It is similar to how we added pcieport for all
> the platforms, I tried to add full topology here. And if we want to
> configure any ports like l0s entry delay, l1 entry delay etc in future
> we need these full topology to be present.

Ack

> 
> - Krishna Chaitanya.
> > > +			reg = <0x20800 0x0 0x0 0x0 0x0>;
> > > +			#address-cells = <3>;
> > > +			#size-cells = <2>;
> > > +
> > > +			device_type = "pci";
> > > +			ranges;
> > > +			bus-range = <0x3 0xff>;
> > > +		};
> > > +
> > > +		pcie@2,0 {
> > > +			reg = <0x21000 0x0 0x0 0x0 0x0>;
> > > +			#address-cells = <3>;
> > > +			#size-cells = <2>;
> > > +
> > > +			device_type = "pci";
> > > +			ranges;
> > > +			bus-range = <0x4 0xff>;
> > > +		};
> > > +
> > > +		pcie@3,0 {
> > 

-- 
With best wishes
Dmitry

