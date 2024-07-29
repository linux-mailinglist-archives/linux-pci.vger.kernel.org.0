Return-Path: <linux-pci+bounces-10940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35893F226
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24931F222AC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8917F13FD86;
	Mon, 29 Jul 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YdwYepYG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3C78C63;
	Mon, 29 Jul 2024 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247639; cv=none; b=kDsUe7T8u31hA3IDa1+0P4cemQRv3aYDfJ4tR8AdzJLuPzUVFPTXlOOCXWRufJQp97irqhZ0Op+YHzKinQ3yBPmdhOK39+CrV8F0SXhuZ7SbVGaaXapRY6MEcej0xLS2ndYpHgGYUe3ZN6vCDZwcbzWLV+UIcWXaIjc9cJ7dgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247639; c=relaxed/simple;
	bh=H2bbkLXxQWLb3spXbowaS4YurXgRB01fch+OZdybhjU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=nYf0ObMt3Vsnd4DOptSOH/n6kPqW3OeuTIe9uLens67fUK1onihiPBFK75ETtlgG7jKNY5ftjy166dT9NI+MBQXclqwxUZRgdiNa8+XL9w6GqMB6gWZjMX+dYbElT+DCM1pxfIoh3xEum5NO5v+YO1d9UScfGlFcGxnYto4z6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YdwYepYG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T0QDil028233;
	Mon, 29 Jul 2024 10:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YEtMD+ch5mMrzzG4L3S6ezFGTmgtLUcaVld4xkvMheI=; b=YdwYepYGOUo+Xozu
	CClYQxkCRC+kSIHiD6fhHzUWkvnZ5E0+xVgVFlV59AkGfYwsrmEDt+vFg6dT8yL8
	ppLGziXres/KmAM4sQHO6NnaMfeg4ZUVIuP4PV0sFD+zvz5lDuknMN1bPASosk/6
	3tIOAbk/4FThLbtFH6KHZMLXPgJbuZ/Wb3ofq3OJt2A2PU8PWreaGUj7lwsdsPdH
	loKpX6WigP+sdwCoSlduX5/43F0ijAS+zLUKPQIRQaCaMR9HwFPCCw1XnkO0J+3O
	W+GOrjy65L9Y5MoKyGwtdtoPX+w+aH64TQnHocSNZJygjDCITXmc0nlDK9EOxIZh
	Nbwqdg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mqw73tg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:07:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TA74iU012851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:07:04 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 03:06:58 -0700
Message-ID: <48dd103d-1794-4a0b-b6ce-b10050d8d349@quicinc.com>
Date: Mon, 29 Jul 2024 18:06:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add support for QCS9100 SoC
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240709162616.GA175928@bhelgaas>
 <82254f66-33ac-4737-a2bc-d606bc9b7486@quicinc.com>
In-Reply-To: <82254f66-33ac-4737-a2bc-d606bc9b7486@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6rtflwYqsGAQETGg0WFrJpSzN00U_wLe
X-Proofpoint-GUID: 6rtflwYqsGAQETGg0WFrJpSzN00U_wLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=958 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290068



On 7/10/2024 2:38 PM, Tengfei Fan wrote:
> 
> 
> On 7/10/2024 12:26 AM, Bjorn Helgaas wrote:
>> Add blank line here if this is a paragraph break.
> 
> A blank line will be added in the next verion patch series.

After considering the feedback provided on the subject, We have decided
to keep current SA8775p compatible and ABI compatibility in drivers.
Let's close this session and ignore all the current patches here.
Thank you for your input.

> 
> 

-- 
Thx and BRs,
Tengfei Fan

