Return-Path: <linux-pci+bounces-21095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CCBA2F414
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D8A3A3A7A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09262586FD;
	Mon, 10 Feb 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JWbBk9pb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2EA2586E3
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205997; cv=none; b=sMXhAXXqwXHQTYDFLi+bG0m7ahDE5AnSn+WcWChke+pRGaZy6orwADQbK4W5K4imnuvFWDkhbWU2oXfzD5UxCzZtFMd7kuaSZfyoYUf4UWzApL134KXq/n/x2iQ9AE3nFuAltnz1/xsBhSItcVx1jsmdrJvD0cA+nZrec3nASlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205997; c=relaxed/simple;
	bh=rKZw9/AKjfdQiq23x4NLYpX5kYPR93R2a5K51O1yLjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwINPnrftCIwbxr271EzDQtRLR0HsVN93XO1Jwdu6jcC+J6k1DKquqqXyP0/kGDTb/MUqerEn2mPnLKBPTa/PH5uexj3rUJ9XvctWsHCJ4EsppIxvx6oxCXvD03ujsTfIInSj/5fP0V5PUgBDyQ0uNVysfyYCBzgnj1w2NCHM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JWbBk9pb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AF22Ri010515
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 16:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y02jPbtLlP48pca9Ds9PgtZCslYqg667QI/2JrWgP0M=; b=JWbBk9pbvszFDg0U
	UJ82sgOtdmTdFLPJpoAyCry5hPN3ORtxq0IagFpOuZCxPiwKKrN/9IopwiZGPQ48
	oxY85SmdYEbtlNq1ajb7ZoGq1Z9kRq2RYghxPXny/dyGITibFm3tyPsk4uGG5vbA
	yzLP540xJCB4vXBvrzM2t6BktakjG+Reo6dhOufBDvTr4ZCpFVvh54Z7Qj6rKDR4
	ymdNMxnc5523e+uLQio8ssmAizTJzBPbUFTYK/0SEPtkVaSErURwym9IfbcOmIRW
	vKHf8mYDwrUgjEDCKy33HMFsn/WmA1x9oanKXSUlJoe1qdKMgz9D110owJ20Uo6X
	Hua5oA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qcs59k6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 16:46:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46e78a271d3so7310281cf.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 08:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739205993; x=1739810793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y02jPbtLlP48pca9Ds9PgtZCslYqg667QI/2JrWgP0M=;
        b=pBbxpgr1qkQgWKmOlzhvjSQlH4HFb6TABxEpj7vnhSU+WgChRBsh781SED3eTFrSL9
         ph+4de9/3lMBPwiy5BCzXxB+LSFvJORWBd5nSP0CoZuFQUrWHbBgmOLsMngUV3wzAsHF
         gD+3Z777bVcxhgFS76XMXy9szIuj6a4CsZC18rLy4w4XXo6PNq4EDDmlHSPFMJz54RUZ
         wDfmdSJi/3ycaybemqkuXVOAJiXGkCLqJbeMyD4atXzkDJ/y0VIn9SJpfTt7VurZMD3y
         8F1qm6B/sQ2RaYibFH4GwBCzH5DfnBBPsTttA4pnQoUHn8fEDHHQqZJXzyOPwEkKnQI6
         6Geg==
X-Forwarded-Encrypted: i=1; AJvYcCU9sHZqADr6KJZl3qLftdIGf3T32JYAltPVy8wyYzeqrz5iWRpPdXx27Em4rQhLvtIwqnyxCWzeLEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzEPecSSX2WZHz0MuVmgv3VlNSYwFjyBuEOAkEn6Tx7fC5p2F
	kAyGAn5Ziot6ndt2Vk3JRZG4Ugw/47TGqCjOAAwpCENL2IQQOEfN0U3sbIR3cEuIbIGRKm+v3Vb
	b6TURlQ6EHxFYIL4k9+w/Lbahx1P/vBIe5l4o3jJGBRHXOJZJ6vG+eMALMUs=
X-Gm-Gg: ASbGncvObIDfTbYUNYyZemrwVPzuKt0wn5IldPRalgicAjontmoLl5hT+/51OPnBxdy
	3ZrHd0SttnrNzS5JL8oFuStbjt5MXQQmk1jU/o/ictaFit6rU5X6e8flXTpd9kO6oEohGqE7Wt6
	hgS7y8yMLgdbYrqIlZhyzahOdBLPmlE2hm4GAQ6+T7rFVYa5FVtFHHq9RCOy1LlLcKTsbWUP4Ti
	bysCLGQszta/MxdxxK8Jkba7v6zbQ+2wrbXh2MZ6rLhPH0i64Qu/BxTWZ+ThVEnfqKRV67dMzCN
	NeCvFmJ0YYSVHauETx02hfw/zjajEmO7X6MzuvtoMiT5+jP2DVTmBTwqns4=
X-Received: by 2002:a05:622a:60d:b0:471:98d7:6f47 with SMTP id d75a77b69052e-47198d77128mr15699831cf.13.1739205993249;
        Mon, 10 Feb 2025 08:46:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQv3ndFWNiqtnFsxi5Czn9IPWmkOJNsq8JxW9IbnF/jsyhP6VDiNCnxRnuxRJAlSvYtv5woQ==
X-Received: by 2002:a05:622a:60d:b0:471:98d7:6f47 with SMTP id d75a77b69052e-47198d77128mr15699571cf.13.1739205992922;
        Mon, 10 Feb 2025 08:46:32 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7809a2ec4sm829406966b.116.2025.02.10.08.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 08:46:32 -0800 (PST)
Message-ID: <45a83048-24cd-4895-93b7-7f8b22841ccc@oss.qualcomm.com>
Date: Mon, 10 Feb 2025 17:46:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
 <20250210-preset_v6-v6-1-cbd837d0028d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250210-preset_v6-v6-1-cbd837d0028d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ky0SUbh0ngTOpMc9coyim40Dvvj_KAW4
X-Proofpoint-GUID: Ky0SUbh0ngTOpMc9coyim40Dvvj_KAW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_09,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=745 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502100138

On 10.02.2025 8:30 AM, Krishna Chaitanya Chundru wrote:
> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
> rates used in lane equalization procedure.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> This patch depends on the this dt binding pull request which got recently
> merged: https://github.com/devicetree-org/dt-schema/pull/146
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

