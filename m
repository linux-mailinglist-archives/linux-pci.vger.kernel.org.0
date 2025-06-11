Return-Path: <linux-pci+bounces-29458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78BAD5A86
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363FB16B4F7
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484BD1D130E;
	Wed, 11 Jun 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxAtWI7U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0B10A3E
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655893; cv=none; b=pE1DAOQAAglcAgbXeYaayfhuGQH2u+bUOEzV1FfSGx5QhWysT/2PsExrkwkAzEaVSDwAQOnsJzKsGIaCK8amh73XlOgXjqXT80D6EukCbL3s3LSXAZA8DK7eCdwZ74d1pnxW1c1KBBmr//dJpXOta02XyUR51qADBlcqmEyZqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655893; c=relaxed/simple;
	bh=VZmnhpMNAmXEbbqud23neFBnq7loO8MoNJRWiN7z2uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/p4P+4Zo1YYXT4464EgRp/pxMsXl0rA1nwi87wamQUSsH4CHmyGp32i78AWnyZNvCkB4BaXk+QF8TA+tNdc17b8wkE7sFDN0qBp6zQvRH560o/4C3A+0UFKtmKzHuvZNGau3tca2ti7pXtncS4v75Jc4VyHVdxKLzKCYjTZ250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxAtWI7U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DJvb019835
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 15:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	455gzgu0hHWS67hAKzKZb/nm3WenYkc/X441OZiZOVk=; b=hxAtWI7UUjCGmbMV
	ZivBuX7r1oKK1BmJZQUQovu0xLwD+GkbuX03yAVA1Ts73LM1e/7KUe6Kcqq2MKqm
	z5BfqNh4/mJ8CyyhtFDnuU4gnTBjy9Cnbjd5z9hI6SyHdii6gtqvN+icyd2MaGWN
	xuK2QUVQGC4mHBwWx/Gx0hdUFFVFqR0AQstfpmNm4WV4JW17pg+z7JTUSZWTof+X
	f+KVTgFugyNPC4RmBAnJICVDLK1XIjLuBsum3/a0N2Ks8IYiuFCcRn8lGj2iTZRA
	MGnFIL22jbyCDzCGhKUquxTS+flCpWdjWS8pMgwbx8KAdjU3j3Kp0WJYQjDEGM+J
	KdJPEQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474eqcnevg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 15:31:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6facbe71504so20486d6.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 08:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749655889; x=1750260689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=455gzgu0hHWS67hAKzKZb/nm3WenYkc/X441OZiZOVk=;
        b=HFat5x24Xn3/BYpQPPsyFNETo0bLBe3DIIvV/yfmBNNGnUQEg3GflIJdIzFtODNTQu
         cd2XjefRtLRvC+PTGE7vGS6i4eVkNDaetvEMy1YGFOCpEDe6osqHNePsHm3vM8cg6s9f
         wXUS6lkJSW9I1uQRe7iVzkvYuIEgRKQzCMAH8XWqziViH1R0brNv+0/suLwWoS9YHKGD
         D3GzNwP+bTDTFFqJQpbA4qoAejCXs1Kmn/EGOCQbVL9w6DQid6DN4KtdIkG5O6Ire17L
         /X1n5blJBZCOjKGpS+KaQpzoGGm85eFxprtBRU7RswVWstkJ1yks8z3GDfh9ALAV8L9h
         uzeg==
X-Forwarded-Encrypted: i=1; AJvYcCVh+P1Er/qcSdv5cKS3DZFQjeWEjnBDk0mapsrrqxBrTb4Z+8Fr14B8OuSNheVoaSSI/4Mu6BHksRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2ab5v3V60BaGJo4RUqSE3NmBvc3SjtkcG0ejxdVfD/9RftkB
	gD/1keiTOtjdlyP40jmpQCSMFZBOy3vTH/ExHssZq+d7aHvV/Atuc6WABKrNRBDjiMP9H6VTz4x
	hEZzr/76dEkr1bsgB/IzPhm4VZ9NyJHrsK1LmHZq6UVGVxeLM+lP4fp4/njiogwc=
X-Gm-Gg: ASbGncusS10u2TT7phOptoWQI0NwJWC3jzgvCHNE7K+wd6m15le4HrV/fxW6CyJtBVW
	hmUzbaZ0nTsrNBf0mi46l93fq9gtPMnrkM9PCn4NzHthr0pXvKwGNv1lVdyD3IxOJpHdGl16Kn5
	d+KXIKR7spu93YqK0ERLaz0rGYeot0xnfDvLjNjjb5AqICNQUHY+D7M643rNEcvYcFMq9Lovwo4
	4w9t68GPcZTp5EfBIhcDeXTb6+b4Odgb9TpG9dTs6uyH1fjs3iSXTCFvL0viczQZIK2sqXz448Q
	2kmlIxQ1HSVnbtWoiQXBNgR09nW8sLb+Jg+m8bfNC9/rxPSLSP/sFI4dsYoOO/Jys6MIB3LjLge
	GSJQ=
X-Received: by 2002:a05:620a:43a8:b0:7c0:cc94:46c4 with SMTP id af79cd13be357-7d3a87d34b9mr218669785a.2.1749655889065;
        Wed, 11 Jun 2025 08:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5SyB2UQ9M+HBsZiuY7IxSNchyuOSdndxJp/raWV9Me50SKe7sJUDsLyWN7TOdPxpU9D5OXw==
X-Received: by 2002:a05:620a:43a8:b0:7c0:cc94:46c4 with SMTP id af79cd13be357-7d3a87d34b9mr218665285a.2.1749655888415;
        Wed, 11 Jun 2025 08:31:28 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db55f6bsm906998066b.51.2025.06.11.08.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:31:25 -0700 (PDT)
Message-ID: <c24314dd-229f-4e26-befb-1491a5ca4037@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 17:31:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: qcom: Add equalization settings for 8.0 GT/s
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        dmitry.baryshkov@linaro.org, manivannan.sadhasivam@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250611100319.464803-1-quic_ziyuzhan@quicinc.com>
 <20250611100319.464803-2-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250611100319.464803-2-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzMCBTYWx0ZWRfX4m4A2PQ6UPDW
 ea3VJ9UcpRZvYaeHbSj5/azu99+ztKEmW4cyQLbWFYCUYKPXaEt4m5GUfeyBvfDDGae382l+wYc
 Eq7iC/a11ws1QH3/Bv7xwChh81oaAw/fluFIFb8C3RgWd+N5ynmIQOjYGP/VQhEMtnPjnfHsUBA
 1eRNnsVIXCEQIX366gIWW4uXVppNzAwoRZXaLtnvOLW8N8GKRGw6B0Q9Bl9EBFnGAtIaaj4OAAW
 MYFJXwW1US0IMGKLLALvrnewgB6p1cjJ/fLKzSvCD5FVOSGMX0eWafQeMc2fRwG6Eh+uMcYvyB1
 5sdZ8r9BjesTh2YN1cX43T3t7v+fFDiy0bi4gDldMDxsnrERkm/PI7WGijnYWITZzMsi5RgBsTu
 PmV126tmnwUk1Uns+kiaJu8LqzWcc9mJkPJ4f6utunAm8UbHNTYi6OUY9ThsphQGJf+52Lvp
X-Authority-Analysis: v=2.4 cv=Q7TS452a c=1 sm=1 tr=0 ts=6849a152 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=XRhAMW6oQtNP-qC2JosA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4OLlxFB3XP164tug0d1gS3XHUcxvdr5T
X-Proofpoint-ORIG-GUID: 4OLlxFB3XP164tug0d1gS3XHUcxvdr5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110130

On 6/11/25 12:03 PM, Ziyue Zhang wrote:
> Adding lane equalization setting for 8.0 GT/s to enhance link stability
> and fix AER correctable errors reported on some platforms (eg. SA8775P).
> 
> 8.0 GT/s and 16.0GT/s require the same equalization setting. This setting
> is programmed into a group of shadow registers, which can be switched to
> configure equalization for different GEN speeds by writing 00b, 01b
> to `RATE_SHADOW_SEL`.
> 
> Hence program equalization registers in a loop using link speed as index,
> so that equalization setting can be programmed for both 8.0 GT/s and
> 16.0 GT/s.
> 
> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

[...]

> -void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
> +void qcom_pcie_common_set_equalization(struct dw_pcie *pci)
>  {
>  	u32 reg;
> +	u16 speed, max_speed = PCIE_SPEED_16_0GT;
> +	struct device *dev = pci->dev;
>  
>  	/*
>  	 * GEN3_RELATED_OFF register is repurposed to apply equalization
> @@ -18,33 +20,43 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>  	 * GEN3_EQ_*. The RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
>  	 * determines the data rate for which these equalization settings are
>  	 * applied.
> +	 *
> +	 * TODO:
> +	 * EQ settings need to be added for 32.0 T/s in future
>  	 */
> -	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> -	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> -	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> -	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
> -			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
> -	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
> +	if (pcie_link_speed[pci->max_link_speed] < PCIE_SPEED_32_0GT)
> +		max_speed = pcie_link_speed[pci->max_link_speed];
> +	else
> +		dev_warn(dev, "The target supports 32.0 GT/s, but the EQ setting for 32.0 GT/s is not configured.\n");
>  
> -	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> -	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
> -		GEN3_EQ_FMDC_N_EVALS |
> -		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
> -		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
> -	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
> -		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
> -		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
> -		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
> -	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +	for (speed = PCIE_SPEED_8_0GT; speed <= max_speed; ++speed) {
> +		reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +		reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +		reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +		reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
> +			  speed - PCIE_SPEED_8_0GT);
> +		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
>  
> -	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> -	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> -		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
> -		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
> -		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> -	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> +		reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
> +			GEN3_EQ_FMDC_N_EVALS |
> +			GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
> +			GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
> +		reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
> +			FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
> +			FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
> +			FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
> +		dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +
> +		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +		reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> +			GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
> +			GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
> +			GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> +		dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +	}

this function could receive `speed` as a parameter instead, so that
it's easier to parse

Konrad

