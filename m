Return-Path: <linux-pci+bounces-23922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB25A64C7B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 12:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D39188DCC0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A408236A72;
	Mon, 17 Mar 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TwE+G+m9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B32356D1
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210837; cv=none; b=TjtR8ju0NPadBFRrTd0Ys4MYviF3KwmEAhtX+r7k59lYdFzE2UgKXux2uX8LlXfOgXoDMYmwmWhwnVX65tge9wP0fPiOWEX2YyF2fGPEbTIgGkGO5LuX2FCrKqQgTjI7fILqsvrrZVKMFX0B9dc4JWuNtno5QoeC9Fu9zml2gvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210837; c=relaxed/simple;
	bh=6UA2N1HycAzHdyBXj2hV0Vkl4hYOXqBQ8IHT1SkQ+8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqSS9irrmHQzm/Q7V0oPJVe5LDfHuCZ3RBV3UKtOyOf8PEbxkmE9i4R2JMhxavsPcvXAPcKqcW9u2FRD026TDbj7yoOjeQjSjeUlJ6k/ImQbb81bYgvPc3o71wGMAwRsiqOaoBrhQUo1UC+CbFGm6TE4qpjc9NV+VZ2eSHnLCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TwE+G+m9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HANnIW008664
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 11:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Xf6yYkUoom6JXgMS3bWVu0Y+
	wfVh+BbrIZCIrGujekA=; b=TwE+G+m9VUBMtiI1WzArZBSpve8xV4izfWSxTYTP
	Su5R0Op9Pcco0qbsf/0wlKhAIgy2StdarDwdA1QWiQK7nAu+JHeHAb5L+f5cHXCp
	Eekl4hZ4KZSc27ZQyb2HbFn2/Llb996Q0ppxghos6Z03Bf5XKHfn9w56tZpKCjBy
	ZL2tM3U4rrqpCGr6I7f0xnqC5JOUmIYnDBwA62BEkwmj7WJmb75Qg3nb0U0y7I2H
	V5iAnK7mQ9yT2CXjWG/7Hzut3/lWC+zjWXFkqg8J7fs5U8rMCL+Y1JPNtKH1yKFG
	PvM+6b6v1JsYnDCw8qBiJIbnSunRHzpVIjBq2eW365qDcw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1tx4fq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 11:27:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8a04e1f91so130860586d6.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 04:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210832; x=1742815632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf6yYkUoom6JXgMS3bWVu0Y+wfVh+BbrIZCIrGujekA=;
        b=MiCQKx8GwN9cB5Gy3Y2B4vSc712IZXreDwlcQlYCFaw3bQsk0Nnqn/eq93qxsu9mG6
         ymgt+FmD1VFOkVBvo08kSDhcO7F76C2xz3m38bJajC5AluWkWGstx94UAGmKj/znHrD+
         q5QbUktbouybP1ucqStMDOYNF9TjybgWvfWLatvvmDEw5CHUHFu3H/c9451yYw6a51xn
         gyJPpPWLQPMoug2Boo8uLHkNdhIvk8NzM3YaQh2yrdvXTUuyb0BOmJcAkGZ9pL/Iiops
         weHv31tY5NFXwehGvVOem8+i8E+tuNoh+GWU/4gOSE854FUG20hREPpL/T9VCE7akaEC
         dnGg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Yiplxaofgyi4HzjsQ5l3P+wNahgqeIL2/du4mzP+PsYS0HVsEZGOvheOSBbmlk/y22JwUcC1vdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1g65oZQcXsOioJdaT+AJV4Rry4pUQKi+sJvv2YmkJmii7ZHIf
	wKOxcwyLSoaw0TfhMBkKSDB7kOWb78tC+dJbFYkT9Z/JO7Y1DlSZVPtBqO8buYai05lnW17ecNX
	em6vRAg6mLYaD7cuZPf0l7RE7qDTN1ZdwnFoCD12Hk72WErCwUX2ERQaliGM=
X-Gm-Gg: ASbGnct2UODneaVFtJIWgFiWgQPUPNnwRf+1lzdnvQUsRAZ2afIBqM1uL55Z4h6aQLT
	oUN2GGDlwfqgSNeH0ybK/sfJoXW3RwjlSW9vObP3sh1IfKgkqahCnJczLv5dU+NaSmnZv7aV/Nq
	O0Kd//8anD3bv6DgbMEXIv1UDCZeAloPf7B3n1pmDOuC35pffsAqhp38XLP7esrgAnFSpPhOCmO
	JbQmhw1chz0va0bW1c4k+4d1xqwU/NACinNOW5Uoijo59Q/Y2jVxLbM6vJ+KayOxDz2LSY+6xcS
	AP9fYWH97U6P2CDgwkCGjveFC0+70diPNgOmooeAIyCQabNLPGaXrrjViOIo/hfo7exUXVVU2KK
	TzmI=
X-Received: by 2002:ad4:5aac:0:b0:6e6:6c18:3ab7 with SMTP id 6a1803df08f44-6eaeaa79941mr187578456d6.27.1742210832499;
        Mon, 17 Mar 2025 04:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoLNZ+Ry/9fQ258pDNw/xw5XCzWAjsof6YNZ7L23EBqp0aDuy+yUy9BVnW3t9pBQNs7ZX+kw==
X-Received: by 2002:ad4:5aac:0:b0:6e6:6c18:3ab7 with SMTP id 6a1803df08f44-6eaeaa79941mr187578156d6.27.1742210832168;
        Mon, 17 Mar 2025 04:27:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0e936fsm15484991fa.30.2025.03.17.04.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:27:10 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:27:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Message-ID: <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=W/I4VQWk c=1 sm=1 tr=0 ts=67d80711 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=HWuFypcHGqLN_zhzHr8A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Rz4SyIlN5bFkajP1qwbfkP97pee7JD9A
X-Proofpoint-ORIG-GUID: Rz4SyIlN5bFkajP1qwbfkP97pee7JD9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170084

On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
> Add a node for the TC956x PCIe switch, which has three downstream ports.
> Two embedded Ethernet devices are present on one of the downstream ports.
> 
> Power to the TC956x is supplied through two LDO regulators, controlled by
> two GPIOs, which are added as fixed regulators. Configure the TC956x
> through I2C.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>  2 files changed, 117 insertions(+), 1 deletion(-)
> 
> @@ -735,6 +760,75 @@ &pcie1_phy {
>  	status = "okay";
>  };
>  
> +&pcie1_port {
> +	pcie@0,0 {
> +		compatible = "pci1179,0623", "pciclass,0604";
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		device_type = "pci";
> +		ranges;
> +		bus-range = <0x2 0xff>;
> +
> +		vddc-supply = <&vdd_ntn_0p9>;
> +		vdd18-supply = <&vdd_ntn_1p8>;
> +		vdd09-supply = <&vdd_ntn_0p9>;
> +		vddio1-supply = <&vdd_ntn_1p8>;
> +		vddio2-supply = <&vdd_ntn_1p8>;
> +		vddio18-supply = <&vdd_ntn_1p8>;
> +
> +		i2c-parent = <&i2c0 0x77>;
> +
> +		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
> +

I think I've responded here, but I'm not sure where the message went:
please add pinctrl entry for this pin.

-- 
With best wishes
Dmitry

