Return-Path: <linux-pci+bounces-27352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0D9AAD7D6
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 09:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFADC98831D
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 07:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8421CC51;
	Wed,  7 May 2025 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aXbIy/PB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F522153F1;
	Wed,  7 May 2025 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602384; cv=none; b=tWKKtBObQDGHUkLQts2H5v0ugg1xR6d+y4rBZ3GA7GUOdxNQKQTWvrPx1gP1/BraZ4P1lJbN0mpaUlNzmyxvbKcjDVw79Muu3dGCrg/aM7RiMPn89ngLRaNsLG/XE4i46jc+HQCWDprDvfWYFKWp4MOUywU3jm/hywK+E1wp1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602384; c=relaxed/simple;
	bh=ftVCNcHtgCKch/G4YULYoyI3e0eUbqM9nbZeswfJKCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bSW3LIaCoae/7bSF+xm51SQVCI+E2RgWSUcZdB7Y+xtOgdRQ9930DXQiuhSCHfo8Xjm6H3yu9jDZbcYghSjDRBkgjPNhaeOlh7Jf2OA33zYV5bWgqJGtV5fX7DyHhEb073ijtRgGTxlvZFOsrxNuYa95FD7igIPpv9nWJelARZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aXbIy/PB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471Grwg018997;
	Wed, 7 May 2025 07:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GSak/6RCspJolLSOvtTAIV6025PG+X7hMUnK6M4R8yU=; b=aXbIy/PBePDmAHIw
	UB1H7JwheZxWXsE0Yrd+71lRdtKYEzR+/IkiRPcLlP+td23pLdIo0xipsSpDHTzc
	0oCrlauJtBP0tXDZxj117zzv8EAsMJmf6yqnrL86t1dCTxR32Owt8e0bV9B0clsI
	TP+K+2wLBzpRFfEanmcBSx4mY/Wu06Id7GkOGcpqB/4J+xUd7WG641wqXPXNFGor
	P4ACZGVGK7l7s+H8mQ2E0YtgCE37eCEmrvAQDVCMZiuzyBkkbCDzWMoS9ezpITTV
	eJIR1ttRfYNyPpfTOOEu3EKkEvEroztUx391SMxdN4QZeQqQ364fimr8is6jZXxU
	lA00lQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5wg4q03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 07:19:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5477JQi8024774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 May 2025 07:19:31 GMT
Received: from [10.253.13.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 7 May 2025
 00:19:19 -0700
Message-ID: <43e6fc1a-95ac-4eec-9776-fc39ae91a4a8@quicinc.com>
Date: Wed, 7 May 2025 15:18:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for sa8775p
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <neil.armstrong@linaro.org>,
        <abel.vesa@linaro.org>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <quic_qianyu@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
 <20250507031019.4080541-2-quic_ziyuzhan@quicinc.com>
 <20250507-obedient-copperhead-from-arcadia-4b052e@kuoka>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250507-obedient-copperhead-from-arcadia-4b052e@kuoka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2mrKWO7swPWHAhCxNNPTrB6Dtsd2weKv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA2NyBTYWx0ZWRfX3ZLKUTs7ko7+
 /Phgy2NPzkHBR3VLvbslWf7afnqIiQNxoYC9swS+2jkDY8H2NQYRcgJak+oelcyXYatn9r5PxR5
 xOtE87yL5vUJCLqwa+QX8x1Hsv8mKqzVYLF7s8oyNaEY0VEf1pbSXYxahDR6wg+UsxUDjUs+pLf
 VI2o+mKAKRaPDXwIRfO3LWFvUK+RDY0L/QrH45Cui7oEIR/eM7Me935LRCmtfxCs7XjeGZbG6tD
 wCFwSR48lmua0UHYbiwQYEM0zoc8zBDKO/Ptv+lDAeBpEcsxJT8d7lDQm/ya/qPjAe/b9M/X/Cf
 ldcnT7Turx1fLGguVdROzQ3iRMF2rQ7w6y0EQpeJaqtONlNSG1xKgG+sgek6yJSAItOMz/NfZHV
 439BxMdutaRvYIceZZfYxILVUS+Le8WlMgywO6UYAWH6sngWLVxxWwzNuXLOfDkUI7k38RIQ
X-Authority-Analysis: v=2.4 cv=dPemmPZb c=1 sm=1 tr=0 ts=681b0985 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=9Ld5B2VTqtJkQkrtWcQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2mrKWO7swPWHAhCxNNPTrB6Dtsd2weKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070067

Hi Krzysztof

In the first place I upstreamed the dt-bindings for QCS8300 PCIe PHY, I 
did the checking for both DTBs and yaml. The dt-binding patch got 
applied but gcc_aux_clk is recommended to be removed from PCIe PHY 
device tree node, so I need to update the bindings, number of clocks 
required by the PHY is changed to 6 from 7. BRs Ziyue

在 5/7/2025 1:09 PM, Krzysztof Kozlowski 写道:
> On Wed, May 07, 2025 at 11:10:14AM GMT, Ziyue Zhang wrote:
>> qcs8300 pcie1 phy use the same clocks as sa8775p, in the review comments
>> of qcs8300 patches, gcc aux clock should be removed and replace it with
>> phy_aux clock.So move "qcom,sa8775p-qmp-gen4x4-pcie-phy" compatible from
>> 7 clocks' list to 6 clocks' list to solve the dtb check error.
>>
>> qcs8300 pcie phy only use 6 clocks, so move qcs8300 gen4x2 pcie phy
>> compatible from 7 clocks' list to 6 clocks' list.
> I don't understand any of this. You just submitted the bindings not so
> far ago. Does this mean they were never tested?
>
> What does it mean that gcc aux clock should be removed in the review
> comments?
>
> Best regards,
> Krzysztof
>

