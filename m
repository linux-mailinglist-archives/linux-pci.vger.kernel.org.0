Return-Path: <linux-pci+bounces-23187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B35A57B74
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 16:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D1E188E082
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CCF1ACECB;
	Sat,  8 Mar 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pm3Q5tMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9E1E1DF9
	for <linux-pci@vger.kernel.org>; Sat,  8 Mar 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741446541; cv=none; b=Wzkhfj63VT4cs/Oqo8T5OO9qFSWEzOR3u6EQVp9YzTEbIhtyqAZTaCblNwwf/xl0wbUtOPkPXdCo2pfveQJbIvRklVQ6rg/wis3b3k/YXqnOaNaCpDNKIJDjthK/Spfnz5u3Jq3/mplX9IJmdJ+ObImFh6AkbQ647nefggX6wT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741446541; c=relaxed/simple;
	bh=3GFm4luup+pqEjZgGHZ7drgx+phEmjUyO+rtAkf0gdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5vylejEAj/Bdu5a4ZdlPLsH6+Kt1nYK1XfK7XeZ8Qq/gir3zKV5jGY7TNBPhY1nv3iRmWjRdN+glofkOb4V4xVsHs2dLePRAiYYG47RmrSiaj/DUUU4987PR4OK6U2eeaJVH8k3k0kwoDmLSZy1RBmbxaj1H1COPJjio03Ud8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pm3Q5tMk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528DTvgC011340
	for <linux-pci@vger.kernel.org>; Sat, 8 Mar 2025 15:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9WvEgSQ6fjLHoWS3Q+wrjvW0AGfYG3GKpopCgkxp6Ro=; b=pm3Q5tMk7TXVfjAr
	voItw4cmezcg4cFw7t8NmsUkDERgQUACEOGihn7lbmphMlWl8PPxm/jQPN/kzsxg
	pv2X4eHso0gs6UXwfFIJI2V+L+hpvTSzOMh5tD9PH1Kr7s8JJd3+vbEelu658R/9
	fENn5xZd63C8/+3exPGG2M04E0i2mJJJAdI0BqLAFLaq2ICqCryftaJmioOePiNg
	dDsmDVoeO/M3hjjvFDz7K8MGAkTFlNWei7No7oHiYGse7an6rhiJBM8QKDJ0OUsI
	BmJV4l9rtJJPLtzeUkBw3qRcZDivDihFbLTRXMlQSiecK+WhGQzAsvLR3Zj8R1Sk
	URtFKw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0prqnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 15:08:58 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8fb83e15fso7257246d6.0
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 07:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741446533; x=1742051333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WvEgSQ6fjLHoWS3Q+wrjvW0AGfYG3GKpopCgkxp6Ro=;
        b=qU+eYaMRRgpI37+ReNaS3S5pFfR+75nY9KiKEDeifvYaBSz5C2hc05eN/Vpu1glYA5
         LPzgXiMU7a/2VLuelWvqRyGg2agvLUTqU325pdMJ9rdwlv7+M4v7fQe1/+qix/vvYvZf
         g2bvxPh444kQLg5egcBf3yGMqWm0OK6c7xWh0yPmq3ge0x27Jm06riI0S0hBUEg2ZyXf
         yy49HY4CQhcHBF2UQOaXWR00H7oIsGaJZagBmi/h4Vbpx/dGLVtLxYvlBwiWT6Nnp2SV
         SKI+cDj3PeKpVhmu+dBPiHgfz1xPF9CZTml3UNwztNQ1TbKShLI0TkRB7n5B7UD3p6yY
         aqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8k6Bf8aUb9X7BXLQkbfI9om8t0+XSWCe68Pi4wVzGM503y7SxPgjiBiy1pTZIaYcx7CrmKp4DHuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk8OxECRSqsTCGC+IoOTdAiyc3XeMmMcOxuarniCGyIEsV1C6F
	YiqHouABiCb4y1/NXf8asQwCyO+4wUAFLg9aSwbLYH4RsizAI8LXwRksHf2WYRuLXcwgtzQ6FOv
	/NvUNLuIeHkObBOgs/0+z7fIKwpaAUcJMJN2MlmKL55rYCV2njbIBiYS1XWw=
X-Gm-Gg: ASbGncsv0TQk+yYZXtcA/N9LwUMlUGCYl/b5Xu53OBJqfXM1ORMaBWf40YY00WS6K+b
	TKj9L2MEdGAIyQEI9oQqRoxr6IK5J04ibC2E+G7oMtP8lBOtuk+fpKJNVU5EjuPrGk/SEJesd49
	onneWjnntYgMHwufar9eIgZ18onADJDy/YiwZOU4/sYz6mYiYj8x/ck9YB1eHNChIdff2zxS3s1
	XZKh1oHeMtNUhFlDQDKlkoJy09bFghr0VIQYZrAQHgy2poEk6KoC1p4DEt6SCiYiOVpLHASZfwO
	eXMEQHo71r2tUaNvqzK/totfiYbIWh3Oint0g+rFAp1R/iSBXnGbd2bCzyDsWuNi3Rz2fA==
X-Received: by 2002:a05:6214:5289:b0:6e4:2975:ce54 with SMTP id 6a1803df08f44-6e908cb5248mr17585376d6.3.1741446533300;
        Sat, 08 Mar 2025 07:08:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7VzZfMJABr9wvGjQaN3mynWkb62I3My6wlogqF3sUcltn/eOJ0ALm9h7T2SCMQYhNBFiMvw==
X-Received: by 2002:a05:6214:5289:b0:6e4:2975:ce54 with SMTP id 6a1803df08f44-6e908cb5248mr17585166d6.3.1741446532965;
        Sat, 08 Mar 2025 07:08:52 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943878csm443575066b.23.2025.03.08.07.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 07:08:52 -0800 (PST)
Message-ID: <aff4fd18-59a2-4378-bfd2-840bcd1a2392@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 16:08:49 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
To: George Moussalem <george.moussalem@outlook.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        kw@linux.com, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
        p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org,
        robimarko@gmail.com, vkoul@kernel.org
Cc: quic_srichara@quicinc.com
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jewb0atPDi3zzdCGh7f6iyjXdVhB05ES
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67cc5d8a cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=UqCG9HQmAAAA:8 a=eQ806-ShdUuXvpoWo40A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: jewb0atPDi3zzdCGh7f6iyjXdVhB05ES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=542
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080114

On 5.03.2025 2:41 PM, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add phy and controller nodes for a 2-lane Gen2 and
> a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
> one global interrupt.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

[...]

> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */

Please all the comments in this patch, they're not very useful

Konrad

