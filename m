Return-Path: <linux-pci+bounces-38012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D340BD7755
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 07:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18BB64E700A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 05:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788C527815D;
	Tue, 14 Oct 2025 05:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TK3lcttp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2226E6F2
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420361; cv=none; b=BOkixs+vNYljgGQdSA65XR7HCi/9N/mZheyWGlOFf5XNH+DJo948VQX9FCSt4avpNjl4scoxzAyyiwavA+eFZGmlMwjEIQuVX3LWj/Z59upThJQDRm+p+LsGxJjIk2KWwp9JntutA5TLPIEyxIj6rixAkUbvOTG88ITn82uuo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420361; c=relaxed/simple;
	bh=7KgKJc1vvZ2vlF4uE4gLCM9HlQYZ30Nnc5tPPVSSt3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMPYp9sh8Q58I6GnIamM32BKjhsRnTx5xQcG0+Z6mfj+FvUi6ghmS0ypi+wLOHgwOgAYd3sBh/46IR3aFy6SpjQarTwm6xwl4Avpag2kzEspPQlMAATPR5Sr7VQeDjyUXlNtzIDG2MGdyWewwM9mOrgN63cCjP01iKFtda501xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TK3lcttp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHDAaV020713
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 05:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1oMp6ReUGAkcuBWeYGGdepJL5VR/gD4ESMqxea/8SyE=; b=TK3lcttpFIRz3G+U
	v/MwFeIIk6gv4Ykggf78sHebrlnhp5UIjF9NTTQRQfdq5IvFE1DuAGhzB3rMMWRy
	bA9pgKfoB15sDv6UBsN0gVrZd2vFwlNVt1Basj8LD1ZVj9/WlytwEx3xtAk/Wa6D
	jDC+XClOjyXkK0GXgf9S2IcpGgjZaeo1mEEP9GjhCBvyiFDiztPma9lUy4KSdNaV
	DRv5ydspvetHfgMOdwmWTL+1yJJ61q1nDIe2468fbILr0DxTu2V/NDoWvYIn8axx
	Khz8hyYiXqghkYGhsBOzSwaiEdbjz6Wo1ycSa0nmukVHCM0qzviiqRt23Itcwsct
	IpGONg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8yb8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 05:39:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28e538b5f23so95792325ad.3
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 22:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760420358; x=1761025158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oMp6ReUGAkcuBWeYGGdepJL5VR/gD4ESMqxea/8SyE=;
        b=Dyu+5ME+srbs3r2ynE5X0xpUbyAUUCwklc5SRLE0XsNNMInW/Kz/0dNXT0Bv9w+MBL
         XwBhSf0zRDjF91CJ2FXOdq3XPDlOpcbKfQ3gKtOsZ4jcwMjYqw67q4TkMpccKS1XWfQn
         j9hHwdbKJKD/OJo+6wYuXxRLp6+BTfPoxayqQwx8pjlGQJ6QeUu0mVB2160FMBfjN1NQ
         xnw14pFz3KmV7iqtukPLFNyHcZkTm5EzJ2bRUVfl+xGHBud92Eqy4iFB/TK8xVFtRfhM
         fzEhIGdpZwX7WDd5HwYgr8M2rYI0HoOxKlqSu9jDbp9ZZ/SjKE4Eqh2bXvtmV5d4UnHg
         k1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgUAnWnMMIB1K2gge/gH5XPFO0nNal82FQW/nxlAhZn8gZX/oy7VuMxKr4d3Fpq+UlAiQZtjgbpK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQESMYM++ztPRVbMslSe7kDJtgArkB+t1V2nKEC2CiRMsedFi
	JH00bz1Sgtj5spzKOxB++L5sv+mJ4Kl0gUHtmybAlNFAo2jIjIn9dfE+p8Ew3o8qUFnKbTLuR+j
	AMo+VqApiVoQIguZ0coEq4uo+KxmnqRMu3/SMbbh8TBQK3qpLQzhpfgmBjrh2w2U=
X-Gm-Gg: ASbGncvxynV3/qcQe4Ku2/eASkXtZLAgGCEzpUu3OwrF+67FXlYkmGBZEsrEtCzlMVw
	KZ9kVfZDGKKIi1pA2GYRRYvUOpyor+LOCOL54KGaN61tO71gBC4tipmtfSB7WH8bmE03C6o26fn
	m+2jBCogn9ruCZben8/ORUvpBHd1ydUQHmRpv9SS6j/N4NR4eOwPil5NyfCQhfTJB3c8vPo4uq6
	GnyIvzYSmpZh8Wbk2swhtAsw+MNZs+wSnqM66UctoAiT7c1o5ebYbAPsMCrZSqS1ZLdYA63ruEB
	pK7iN9goGE0DN6n4A1iY0FcAtK5uD8H69h/PMkI5X+bDIDcXVsAIHx1OvR08MrC1mGVlBhQWPA=
	=
X-Received: by 2002:a17:902:ce88:b0:26a:8171:daf7 with SMTP id d9443c01a7336-2902723f086mr388952445ad.16.1760420358148;
        Mon, 13 Oct 2025 22:39:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzNWsTvFSwkJcmErpReie+BnX+Tvcx5O8Z7ZWO1k+OYQIw6XA2734NpxW3Pui5uE9foskOWQ==
X-Received: by 2002:a17:902:ce88:b0:26a:8171:daf7 with SMTP id d9443c01a7336-2902723f086mr388951955ad.16.1760420357620;
        Mon, 13 Oct 2025 22:39:17 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f4ae6csm151903735ad.108.2025.10.13.22.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 22:39:17 -0700 (PDT)
Message-ID: <e146e351-ec42-4980-b41e-56bfd7dcc0fd@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 11:09:08 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] arm64: dts: qcom: Add PCIe 5 support for
 HAMOA-IOT-SOM platform
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250922075509.3288419-1-ziyue.zhang@oss.qualcomm.com>
 <20250922075509.3288419-2-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250922075509.3288419-2-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bLdu0oznTCkgJ1YGtxJW9wOB7OH_NX3t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8k3VmNX1yMAN
 +gIC6f2xK6TEG+yKNc+5AVq15KhCjgWb+tFck2HgCJ9S8cn5AywPGKQj/+2XqfyQ6VbTsIoq1UB
 BzUBSQmqjQQH/GZCZ5Hg5ptsAN9lSIvS80DCui/5vZBSmFzka00D6zIKDCd1Wiipeqk43+Nk1T0
 Uw/MHTsOu53TFaSDFWF74d5bCaB31E7evq1863jZPVcAX5dLnJHIcH1Zqz1LIi94+KPeGo/vc8B
 HUIZo4etZKVr9KS1OfA37EmkvPfuJ5ot5FPekazhq64FaZAu/CT22UftXVdz+NdBxyJY+P7qrc7
 DJzEqGVG2ZdaOxvorfgqI5trfzdmrkQdFtw6kI1sAUipOeVvrCuPy5OK1/lCoAYufVTJy3ofTkU
 ynLtCkMIJlE9XEt6j6RaGcS7Vp/t4w==
X-Proofpoint-GUID: bLdu0oznTCkgJ1YGtxJW9wOB7OH_NX3t
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ede207 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=zv_5qE797hUBxoToDSIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 9/22/2025 1:25 PM, Ziyue Zhang wrote:
> Update the HAMOA-IOT-SOM device tree to enable PCIe 5 support. Add perst
> wake and clkreq sideband signals and required regulators in  PCIe5
> controller and PHY device tree node.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

- Krishna Chaitanya.
> ---
>   arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 40 +++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> index 1aead50b8920..0c8ae34c1f37 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> @@ -407,6 +407,23 @@ &pcie4_phy {
>   	status = "okay";
>   };
>   
> +&pcie5 {
> +	perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-0 = <&pcie5_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie5_phy {
> +	vdda-phy-supply = <&vreg_l3i_0p8>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
>   &pcie6a {
>   	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
>   	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
> @@ -477,6 +494,29 @@ wake-n-pins {
>   		};
>   	};
>   
> +	pcie5_default: pcie5-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio150";
> +			function = "pcie5_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio149";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio151";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
>   	pcie6a_default: pcie6a-default-state {
>   		clkreq-n-pins {
>   			pins = "gpio153";

