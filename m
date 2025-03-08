Return-Path: <linux-pci+bounces-23183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55674A57B43
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 15:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57F21889CD5
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F51DC9A3;
	Sat,  8 Mar 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HC2ekB4x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC1140E30
	for <linux-pci@vger.kernel.org>; Sat,  8 Mar 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445568; cv=none; b=JFN9OyixlxfJFVR/kBM9g8dAmR4RMIv8Md5q6vfFy+mxeyR9bNHUtFYWKt1m4gABagbd+VSw1Mzta6yDfF0yiJctDXBCKnJ2SwQLKpos5lcVk2UsOJT4wFhgyQ7x7+FNZGnUvb+4JQ2FdWZXZdI3KqrE3j42hdsAhCyapWiDAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445568; c=relaxed/simple;
	bh=anRYeYF309AXBW25z7R2hL8RDDSJQseUCtoq8QWO5XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hy65luA5ykdbUMuu/tjcbkTfG+RVDB2LrcuI/80zavJ689tLtVZI86EQVPPNtCdXf+lFUekp7ePasSXbplWs/B2VYFWzV/J2iCWYqs2URxgcYbh+PV+X0eKy+2YwptDmGAHeB8CGEXSLE+DpEHmSZdHccMXIllQs1Kh39bJYInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HC2ekB4x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528DUios005114
	for <linux-pci@vger.kernel.org>; Sat, 8 Mar 2025 14:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FRjkl6YhFHYJ1JWEogAn4n+Snf68kuUomS1wUveNVAI=; b=HC2ekB4xQd1nCpfI
	Nk+5TaQfbL8FJuh8JC2aGxlx6o8uX8mjA4UBrdT70LdLdO9he953guW6Q+kswF3d
	DZjB/UW9q8hwE8Kn4pOSq1ZaAbZNNFLTM6bFyBF084Pqh9yYDq+bxFvQyszshd9d
	8L8u5GbB6NJCkIV+XID4xzMa0iIuEOZcgMoVH00dsDYwLpW5cVfowRSDTmZiAWBc
	eyKk1M8uBOsJBSwwQ65G+im2TFBwge0m/qBCzeRZ+t7i8ph1Swdjb+pxjKRYu8Vz
	NcStMfZpXFyzSna07sRSWOxzyCBUyYje1z9azBbpxE4sVqbTMzFlG1YZM749x0wf
	jF0cIA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyt0qbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 14:52:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476718f9369so1320161cf.3
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 06:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741445564; x=1742050364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRjkl6YhFHYJ1JWEogAn4n+Snf68kuUomS1wUveNVAI=;
        b=NFEAUkDA3hGDLABFBl4D3fTr3sgsezjKcAPHS8MXuZnRIP+gtj23HgEWJXxE93ynpe
         7aoAwWsc5RCqtezQ0GgHi9hyCjJKmywMfPNtrw99X8RaPTAVPNfe23gC0+B3d2vH/Qkg
         hvuEUQ8Mwr0qw0PFSkjMSai0tFc6DN4llHi5SG2LccRrRT+QcBs2yh/2JzE5heyFRRpw
         C4Zjnrt5aY9AFxPwnWe+tNBykGrqkBRcIYP+J1uH0oDwE8MuyXc7Y4oJ55TPYT1lMTeB
         tcdAqbOZ0vrOhzUKofhjLf2l3jsqGI+cRYNyJOZRUv923ksry6+Mv746Jvq3woBRjCQ+
         mmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdmyE0I08SfppHVHWpjPeOZ3nGn24NffP22h1Mw0qf38iqyuqDpjeLb4EQMjYT9tMrzAaxpzyUDIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHCSYICnIRvt4c9rgaWnzJ17AM6WDFceqDT23dZir9JgdGh4u
	BbECsFUjT+2JKT8UOuJh94kVvqef01JhfnCveyrUGamdg9B0wU5Jh8LRtNwWuLhM7Fc8i0cpVah
	vckKMc7j9c2jf0ew/GBGW9ZG+DMaS26rkKSh+TVRUrNsB3etpjrgSRtbwbko=
X-Gm-Gg: ASbGncuN9Q9N7++eNHO8xdWfWeaoKE2h5cyiXq7Aqz0u+ZsW5SWE6YFD9nfFiB/RLqK
	9DSjQ3X+kuzbqpoi1H6o+9Sn+zCwrAt2ZwHQDEEERsG+oF6DopKcAGLopTI0IUmfDneBXjT2VUe
	zpVBT9h1EAaQQXP3R1lLKmG37hn13xVWridg8uGpOrX0cW1qVElaACeQOg3MB0JrtD/lTMH0SHw
	6oHFR/pnn4+zWUye28jVDPCaBk9T16D4lSk0leR+x/C8+603/D/+Te2jFgsVOCIdDEMiEQ/V1+j
	C2diC6p+wS2c0mywT43Q2OorCRxg0gbiY9fa5fCRJL4fHAoUXAVi87LO7FDfeu7NccD6eA==
X-Received: by 2002:a05:6214:2502:b0:6e1:8300:54dd with SMTP id 6a1803df08f44-6e908cb83d2mr16970656d6.3.1741445564628;
        Sat, 08 Mar 2025 06:52:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSj4DtwyIyuqnhiEdd/BEFf5BS8fhU04AWxZPyJhZB2pXyHozhGGkjEGML4zezlWGkfpna8A==
X-Received: by 2002:a05:6214:2502:b0:6e1:8300:54dd with SMTP id 6a1803df08f44-6e908cb83d2mr16970516d6.3.1741445564301;
        Sat, 08 Mar 2025 06:52:44 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d1237sm441737066b.164.2025.03.08.06.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 06:52:43 -0800 (PST)
Message-ID: <40eea830-b3b0-4a80-91aa-9acd67e7ab41@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 15:52:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/23] arm64: dts: qcom: ipq8074: Add missing MSI and
 'global' IRQs
To: manivannan.sadhasivam@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-17-2b70a7819d1e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250227-pcie-global-irq-v1-17-2b70a7819d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5MMbxk314JgLDENKKht3eOioJev7hrRe
X-Authority-Analysis: v=2.4 cv=CupFcm4D c=1 sm=1 tr=0 ts=67cc59bd cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=x0-Ntm4DP0gVEan9CnAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5MMbxk314JgLDENKKht3eOioJev7hrRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=635 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080112

On 27.02.2025 2:40 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> IPQ8074 has 8 MSI SPI interrupts and one 'global' interrupt.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

