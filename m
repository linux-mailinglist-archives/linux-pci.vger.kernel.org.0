Return-Path: <linux-pci+bounces-41025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DA7C5498D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 22:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2207B4E42B5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610AF2E03EF;
	Wed, 12 Nov 2025 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YD2SZpP9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AKCvxGLq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506382C0F97
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982227; cv=none; b=dTBbhjGMUslfe23t0fGWwNrbHLw7HXiBHYXu7Igg/FOBFCvydHByRsgbfIzCt5I2QdT0qSTnsdjv5fhukvXhXqmPiMj0vPAxIueT+3eGABqRyBXRDVlzq0QLZNCY1o/juqmywG1w0nLxg56k4ks0ymjOSiS+eza463BpJ9bwh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982227; c=relaxed/simple;
	bh=H1Uoy00p+mpjYySb8hYZmCgXX+v91D1LelskMLIkOm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9YGFv91CIdYvabdulazQkXj0btJW0WHFvAlfgh+iZrVL3vLPQw8bm/gN/J/XNR7VejVTCHEdlAzOo779DXApWNUqPgDaFSl9zubxdjAQkkQ+xm6AXwu18srKLbhpibKu7Ji6wolZeMIWFv/FUe98TYkoJAtcA3z+8BCL4cJpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YD2SZpP9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AKCvxGLq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACGuXYb1002163
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 21:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HzuIoUBS8VbswRplTInLT2fk
	Qljjik4GJUFcI7KziZE=; b=YD2SZpP9HxI4xd8RSogOLslROFGk1bv3B3g0qNlY
	U1nNwWs6NZjyNomvg7eIn/Z9E7su9vAhT8oP8VLEBW43Xni/lVWdb0c1Br8fX30I
	L5zyORK39ylhlHzgg23rruyWS/rop6H8NztWHE49AUQjp/8S+fCMIxyl9dczaNmD
	1xeRW5ZvANN11/eevndnQEnqJsEErYOGhTE++JilTvOKO/oYEM4hJPPwJFHff9zG
	54mgabcGscUaFdhFDyLPpwEoeDXHnQQ8pe3CXSfkjBkdSWA7K/gLkyikzWeT/qyC
	AOcplgixsdeccSbdFH3QdR2DsJS3KQdaaE4fX8t5Djz31A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqq224xc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 21:17:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e88c912928so2754791cf.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 13:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762982222; x=1763587022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzuIoUBS8VbswRplTInLT2fkQljjik4GJUFcI7KziZE=;
        b=AKCvxGLqU1H06mQsd/ngI13jCKl2VtwQFQ3pt55tuIVO6kEwukJT9acgmZA9y2hKP2
         8kqx9mmss7JwCwr09k9K1bEKDs7GKKH41Z/nXs4+Gyrv4Wrj+gNLQmpyrZPCyRB/X9uv
         ukpmwAkD9YIEef/ipBpkdFjnUoS22DzUH1qg4MIOQhDXdhPyyeCXAZiqJHWxOLdJuj6b
         //3VxHRDuBRJ9JNArK8kk9QbgsBiDh3AMKzIws8zM1Y/Z9+0SkWyLoRhJL+VkXZZhEmz
         Vl0a4bXQDWDipm9vQm/bJ03XrskeL85crc8BsJMGsSl2CkPOmtMbdeLXWml6FkF/kgQy
         UqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762982222; x=1763587022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzuIoUBS8VbswRplTInLT2fkQljjik4GJUFcI7KziZE=;
        b=dxS5l3chVnN8MMux+dWoVkbosLaCjc42ed+34s1ftcshDQTwIvtnKRp1EHHfPi2W6f
         EUQze44V94ahCW43K4dBAOWtAmar6HZdvCpVlimfhRoIcDw8yNtVbVx38uiIIasMGhIF
         WjvcAsI5sR2QurWHQ10DcH5TECp0Wy+zj/3GfbtpFa2fToelvloRm70rsyLmOQ9W04qp
         sOV2MYQEaqzDPQb3XIoNZMD30EYhM+Z+DN7hex4t1YQmFSKg+AaPv93JnnpQ3yCLMudP
         EuwsinxeJyI3pqepCe5qN7ecipdZWesVUosuuSRRPUvAbr4T6iak1e91opsp/rsaCQ+D
         jRmg==
X-Forwarded-Encrypted: i=1; AJvYcCWHIUGglv2GJVZJzyV9eM1G8u6uzH3OeuZRWUIO5elHCORMSKVtNquEb4sKWtBAHC7gJUH+enwXaVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3e8g0t5zl7zdpgGH51mANof1wmDaQiz5gijg6TAwi7mag8TdX
	QjH41OQZtmGuMCQ0Kc2yz7HybZCRM8wfwd8n9eYV1i0ysbO9RqJFodggFxK8VmZ+1Vi86Z0VS+B
	UdUAHiflegOqC8hveBWGv8HJk8qj73aiJx/lp1mFAVz+PwFcyDw1CD1mAnBlRMTM=
X-Gm-Gg: ASbGncsqBA/aYmm0bX8neRuQ0RMtkP6uYbkbOwJLy4QWgOnUgEKXSWWQDyTVT4D0Egb
	8WApOPcnnNwk7plo9dPE+NU1BITgaTs3B3qmSRr+cRtalZztrSZst3Ql5L4wm9S2DKPNn1V6Yfa
	fXIeAI5IZpcdHwISpVHAA728WMTetXYswiz59Gm/HW+p+Egfckdl2ydaPttTmgN7bN9LWTTSkIL
	Wv+tZtIsBAZyROguhnqa93bMEbP/66ZK8ekrRX1BvtVuy0Rg+7mMPUJ+w+e8mHqxeljHKdtvmnI
	j/o33H3MFdr977h9WNhtuWR6bp994fYQmP5u/D9V2YoqO3W3gmFVHlRU4dtP9D4dIOTHjse7Wja
	XLDrRUdv18vxLytUvRVpj+QCvhcrZIE09BEtoomonC0RAUyb7P8ir+aDCxVdsiYYu6jdQ32k+P4
	pxTDse8G8OEW9k
X-Received: by 2002:a05:622a:284:b0:4e8:9f18:6e50 with SMTP id d75a77b69052e-4eddbc90f1cmr59530241cf.27.1762982222375;
        Wed, 12 Nov 2025 13:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCwXv5uKswVvfqtUeLVRLnBHhgpN/Be5is8xuttmJyNNQ7C9loD59anpFc707xQWQ7uyj2qw==
X-Received: by 2002:a05:622a:284:b0:4e8:9f18:6e50 with SMTP id d75a77b69052e-4eddbc90f1cmr59529871cf.27.1762982221892;
        Wed, 12 Nov 2025 13:17:01 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013bd8sm6237915e87.1.2025.11.12.13.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:17:01 -0800 (PST)
Date: Wed, 12 Nov 2025 23:16:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, krishna.chundru@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add PCIe3 and PCIe5 regulators
 for HAMAO-IOT-EVK board
Message-ID: <rakvukrdsb3vpr4k22hgvbr2yc65me32uezwrqgn2573kblirt@7q7pgr3nkvso>
References: <20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com>
 <20251112090316.936187-3-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112090316.936187-3-ziyue.zhang@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=EbHFgfmC c=1 sm=1 tr=0 ts=6914f94f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fmVD6mvdgdatrdQPAe4A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: zoGlzS7CKU-hJ0KgQdxKpeiBl1gTh1CJ
X-Proofpoint-GUID: zoGlzS7CKU-hJ0KgQdxKpeiBl1gTh1CJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3MiBTYWx0ZWRfX9ZQcxxcTLp+d
 HtlLJdI1E6aKrwuOlUaNsSFT1j29TsLbXooGiKJby37pv5pyj+Xsun31thKRdoh/+2akUPcRhji
 Y5eOlIAZRcE1a+4DQbGfDXjT3T3QpsnopLcO8InZNPUhEZMSISYmFKZ69HPLj3fakT3bGkYtIZR
 rw61XgRSaLKPyPd3SS+tp66QHDLM7gcmSL2XFrB2ck+dBL5vxgg2QWUB+if7RTvpZ0gmckMSKys
 Jhw7yVaUZHdbO4N0LxlNCLy635QzMlZ5RVG/+7TRR+e6OwQQukWIlPHXmYU1J0XZtYSQxzD6f/3
 IHVFjxcBbQSrbI9+BCibK33uaF7qNxrGBOh81dzuHQCQHDuXBwSkCvCF/4NeKxJMvNtJYpYjKrh
 gRNiDoHqsnFA0LaicHAsF9x7R0qlTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120172

On Wed, Nov 12, 2025 at 05:03:16PM +0800, Ziyue Zhang wrote:
> HAMAO IoT EVK uses PCIe5 to connect an SDX65 module for WWAN functionality
> and PCIe3 to connect a SATA controller. These interfaces require multiple
> voltage rails: PCIe5 needs 3.3V supplied by vreg_wwan, while PCIe3 requires
> 12V, 3.3V, and 3.3V AUX rails, controlled via PMIC GPIOs.
> 
> Add the required fixed regulators with related pin configuration, and
> connect them to the PCIe3 and PCIe5 ports to ensure proper power for the
> SDX65 module and SATA controller.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> +&pmc8380_3_gpios {
> +	pm_sde7_aux_3p3_en: pcie-aux-3p3-default-state {

What is sde7? Other than that:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> +		pins = "gpio8";
> +		function = "normal";
> +		output-enable;
> +		output-high;
> +		bias-pull-down;
> +		power-source = <0>;
> +	};
> +
> +	pm_sde7_main_3p3_en: pcie-main-3p3-default-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		output-enable;
> +		output-high;
> +		bias-pull-down;
> +		power-source = <0>;
> +	};
> +};
> +
>  &pmc8380_5_gpios {
>  	usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
>  		pins = "gpio8";
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

