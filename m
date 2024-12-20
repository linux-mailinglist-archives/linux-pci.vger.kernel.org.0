Return-Path: <linux-pci+bounces-18896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB3D9F900C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 11:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00330162E46
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C71B1C462D;
	Fri, 20 Dec 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxWqrbI2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BF1C4604
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689827; cv=none; b=bpC64Gb7Mf1666lVOugBLJohvs2FNaDlXpFjJIp5oJ7jXENF0tJuXT8O6lxOUg6NDJaCRll0hi8Y1QFa3H0TcaB/WSfl0wqXyg/NVQIOQvou1fd5+EEjTFFf3dpEaJjmIxQ09fW+3+lrG5iLObjQO5muUnLmRW7PlzrDGMPK6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689827; c=relaxed/simple;
	bh=dpyekRfEEuYHq+Q2cMWXC6HhUthVTFXuEzDEP9ulU2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfqUn2DL2JYwnxlhsXJ779QGPCW1mZFb1nJckvd0LP+rWWNaG4UtAkpUf2Gedf63HvStx8uTQutwJ5nkxbbgAEKXZ/2YW3yO8q5c4zHEW4MlwmamU29OXDdpnNUjke8uoBCswg6ZBFwDmMJPjoLl3yqYAeeFS4aOX0eqT6xF59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxWqrbI2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK6mXAb027725
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 10:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u/mWcyc9PSpD3cCH/0Ahpmf2yDEfveb9OVwcHH2HhT0=; b=DxWqrbI20UOSakCn
	Nsv0liTSK1fHfnSQdkXO1fd7bBjvImRv3tnZQKohnMScfBYEKNfPbfYdQ1z5u4ar
	8kyNdx/Q+NRq6+UgbbokFafkHSydyTqcHxk5feA9rDrZMDCwKwa8IPXLRyevws62
	EHjz8ZL0lgTsztsBs1pAYoeFXjcjAR7Eg1mgH9jgTl4XgonV6VDdVG39NxqBUccR
	rFXuiPp5bzqWleKm8f2UzY0oxfxz+BSbJOXgw2nM3zUsgOWj4JA5Moo5IzvvSrXB
	hA43RP6wGmNE7Nwsgzc3JaMIQMrHkO9DFFFQF3tLFYDfgJNCIsUgQ/Ckp7xbR9hs
	9LYGvw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n3mxrjh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 10:17:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4679af4d6b7so4558151cf.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 02:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734689824; x=1735294624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/mWcyc9PSpD3cCH/0Ahpmf2yDEfveb9OVwcHH2HhT0=;
        b=wdWQDOBofQfWxC1/piMaJu1ZntTFLYRBSans/ZO8jfHVMmqgYk92529i99EPH5N3Og
         D3cSYMwTJ9VdCQ3eh69PVV2U+LpBnscgQZolM/zDjEYDCzYzEEgUiqU0sgXaoSKmMZsR
         k62fuQ/jkx+e3b0Cvj6n0qPuzHoGQtCv4CpJpgz4GyxQdM1hxkAQpIXwFneFh9+fUIJQ
         aQv+IhPfujpSMOYT5tdWJd0ITxh03niIwKNYposGqa0lawCHYBT1P2imA4W9SyCucrGK
         R4XQ1s7CZJzYBOosZyeuD8jVHMDDcA6VmxkLrjuljMPxBqz+qvMZC6J9zMNEGT3ZR80K
         /Vfw==
X-Forwarded-Encrypted: i=1; AJvYcCVoqkY6E8rg3urFalLAxn+d9jYrXMjyRSBbk0rH4dZqnCXjQdfKfOp5si62jc3kb7x5D2yp2bS4+Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPTqrQHfeFyFRMsYYYQPD6vK1a7zJU/FW7JvwNXCKMM8KsUrh
	vDxrE0gfnLVnY/ZhcFIkIMyLlIAcOjNqxDh9cD5gGI9j4LeCV07UXk+F8bNte4Sa/VWwATz9nKd
	VQswwZlC1EJzQiR/Obb7BPBZmEzGto/yWEh7V51CuTCPcRRR0d2gsWHgmwRw=
X-Gm-Gg: ASbGncv82/naF44uKiFVVsKUgmX59Ip0H5/Nmd5CSCHpn0Q03OswcgibJxumlDTwTqb
	RrIRllj32AAQfraoECcdJl/xe15kBQ/+vVi08TykCQajl02nTgH/8T4N5oaAAgN25WMLKLwmDka
	bR+Od2VMJPm2uXbhLNMQBc7W05DLKAFy5tXafT/9dX6+aXuLrSKXOS91+EI73PYIQH9pUhQd0g9
	Mwoha65I9smzSLmAHYSqwEp5FhrKCRLzlrxfWU5EYGZ0ez/jhbeW7V7h08QF0w3AJQzElqlbeX5
	3BNCmv5z2mvm8as8ja6qc3yQhjfBOmNA1i4=
X-Received: by 2002:a05:622a:14d3:b0:46a:312a:54d3 with SMTP id d75a77b69052e-46a4a8cbf47mr14269471cf.4.1734689824247;
        Fri, 20 Dec 2024 02:17:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTTu/4H6/KMrUaTlWO8zj44laXUXuji5sXvxSpCA42Sd1+lO0jgLoRuunnQ5f1OzfWmVhKew==
X-Received: by 2002:a05:622a:14d3:b0:46a:312a:54d3 with SMTP id d75a77b69052e-46a4a8cbf47mr14269401cf.4.1734689823951;
        Fri, 20 Dec 2024 02:17:03 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4922sm158207866b.113.2024.12.20.02.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 02:17:03 -0800 (PST)
Message-ID: <525056b2-09b6-45ef-ae38-718af8d6b76d@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 11:17:00 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] arm64: dts: qcom: qcs8300: enable pcie0 for
 qcs8300 platform
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20241220055239.2744024-1-quic_ziyuzhan@quicinc.com>
 <20241220055239.2744024-7-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241220055239.2744024-7-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eFej7MzCxr7OiEkVTEF8IE-br_B2ci0W
X-Proofpoint-ORIG-GUID: eFej7MzCxr7OiEkVTEF8IE-br_B2ci0W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=696 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412200085

On 20.12.2024 6:52 AM, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe0, board related gpios,
> PMIC regulators, etc.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

