Return-Path: <linux-pci+bounces-19818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DD9A11971
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CEE188B446
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 06:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA47A22E419;
	Wed, 15 Jan 2025 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mjuq66HM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0A22F170;
	Wed, 15 Jan 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736921429; cv=none; b=HUb/sieOn3WXY77mxV+1ym1HCWDxgn0+jcQ4aY9cM+PTldWimbFlZe+k8/Tpo8hvPSO8JZY6V4kkUCUp/xUrbaerFKJIGxUGaAOiqIqMRSwQn9sLioS4az4REQ6VrnylGAMTbH7FfIfH4O26sF7J2hUaC9L7D96gRHRKA0QwHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736921429; c=relaxed/simple;
	bh=z4VHK5uGowUa8n6Wog/xwzapsHoZeeV3ojloTxWM0GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iBGu24MEr9pJW1IoeejZzLjnqGYvAwHjxUxFoIBffFN9d3B1Wv9nSQRFCU2WMV097KX86fytOy7RvOjim0m4K8yS6lCqYcSLSS96Z6bcX58jMbng5j4xb3G9a/ETBgfp0V9U4eQxrB5SdEMzLsOkMBW1lh83Z+PigO9Mu/HbK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mjuq66HM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F1tdxs027718;
	Wed, 15 Jan 2025 06:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+wZ9OFW6Tocm/ovdJVpmpMjm4fWamKruQF9KhEGEvys=; b=Mjuq66HM4wiSIAag
	AaPNNDHXCkLYyISdbidG27oa8U2bplL0Ssk3Kk/iO57rbCU1EGXx2bPREk6KmMVs
	a3x4Mbqj/6bKxJ7VH8dBZZTwvD4disQYyGm7MqM30gxiyp5pDpgAHE05FtE1OV7g
	yqacfl/Xle3NEscABuuT2m228E157NeV8Ot77TDIM4iCAtvU7iibAZqxBL+OO48n
	4esSuRzURythA42+Hs98eMCCwrDZc7llKk/hzN6WVI5OQIrXTQs8R5vQP4ZwvnDr
	jDCmWFGFLr2ylSkgtpbdgcnPkJhANWYrgCQeWzGM1e0ahbppHtqtAphR795ojypd
	dCrigQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4463sm0g8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:10:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F6ADsi021363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:10:14 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 22:10:08 -0800
Message-ID: <de564e46-4a6e-4393-b754-34b35bae5599@quicinc.com>
Date: Wed, 15 Jan 2025 11:40:05 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq5424: Enable PCIe PHYs and
 controllers
To: Varadarajan Narayanan <quic_varada@quicinc.com>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_srichara@quicinc.com>
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-5-quic_mmanikan@quicinc.com>
 <Z3eJQyJXSBG+oFF4@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <Z3eJQyJXSBG+oFF4@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3_2duaB9QtO-ValdXUL5KxjW83haJFRj
X-Proofpoint-ORIG-GUID: 3_2duaB9QtO-ValdXUL5KxjW83haJFRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=713
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150043



On 1/3/2025 12:22 PM, Varadarajan Narayanan wrote:
> On Fri, Dec 13, 2024 at 07:19:50PM +0530, Manikanta Mylavarapu wrote:
> 
> [ .  .  . ]
> 
>> +&pcie2_phy {
>> +	status = "okay";
>> +};
>> +
>> +&pcie2 {
>> +	pinctrl-0 = <&pcie2_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	perst-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +};
> 
> pcie2 should come before pcie2_phy
> 

Okay, i will update in the next version.

>> +
>> +&pcie3_phy {
>> +	status = "okay";
>> +};
>> +
>> +&pcie3 {
>> +	pinctrl-0 = <&pcie3_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	perst-gpios = <&tlmm 34 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +};
> 
> same here.

Okay, i will update in the next version.

Thanks & Regards,
Manikanta.

