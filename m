Return-Path: <linux-pci+bounces-10028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD37992C810
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 03:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1EE1C21F99
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 01:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128484C91;
	Wed, 10 Jul 2024 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OQuOXysx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E47B647;
	Wed, 10 Jul 2024 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576086; cv=none; b=J6ShYEp5yWTDU/qzHxwqI9Dw9NWjsWp/I7rdY0+D1FcuO8vF+QmI8HAz69+F6z4dL+Inr9eGdmZ+EneQAMVktP0ZO9OnBaaXDbw/Ib2LnrsQtuBDP/3YJ1iOrJxZT0s6uTA6X798M8rRcQSu9yTw1s1lR/da6XDHFNtcA2TPMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576086; c=relaxed/simple;
	bh=vD2sV5W0bYeBHvrmPBn3ILNAFY37y/wzNJt1a7Ii+18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ij7XUG5jRg1914ESn2tU0wLlfQC1DURCbpXWmw6AWHYoyaPix8pJchvtTfsEKXXrU2k9rg+Jkz59RfmsonZMJS7t5OSMVSsCk2bAMc0EBlU45T4sTG5UtW12PDxE9euaEALcwKuIhr0DQfmdHbugWMQqwIVmWTUiyoMQaj9gEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OQuOXysx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A0clsu007187;
	Wed, 10 Jul 2024 01:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JiA0RxQryTXBcCfDA4FDOuiea7ag/p3qvsCr1kY0UcI=; b=OQuOXysx4ck9keOZ
	YlTHy5CpDlKKzyn4UVmuh1e4xYSpKFb+kcN4ovqMdZPgn+Ms7G+6MO2D14DXxLk4
	sY+FHOuz9ty4+RjjJV/gYjpVUGu2VHf/aMbXtwMZGYbklquTdYPGJaPGYZWqT/JV
	podrY72sia5mL3dJ+XiS59WE5vVfXJupbciwrnKp+qaswbOGlxJDZnjnVXxZ1k6s
	EwnFP1ASePMIT2qO/SLqI9kiNTjOJSPLwx1AQp0Qe79sDDDpoViaHZcm3nc+d9Rg
	c9cs8ynD1SXNksMbtxg3LPuAsRk4nVwD2xistSNv85JKd/nQUrpIoZVg+L9xRpWR
	6WwU8Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x5185ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 01:47:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A1luCN011288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 01:47:56 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 18:47:49 -0700
Message-ID: <1fafb584-fc49-45be-a8a4-4027739eba32@quicinc.com>
Date: Wed, 10 Jul 2024 09:47:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI: qcom: Add QCS9100 PCIe compatible
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>
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
	<andersson@kernel.org>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240709-add_qcs9100_pcie_compatible-v2-0-04f1e85c8a48@quicinc.com>
 <20240709175823.GB44420@thinkpad>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240709175823.GB44420@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bK-Zf2hMVrVzkh2iqgT_an2tFVH64yjs
X-Proofpoint-ORIG-GUID: bK-Zf2hMVrVzkh2iqgT_an2tFVH64yjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_12,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=964 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100012



On 7/10/2024 1:58 AM, Manivannan Sadhasivam wrote:
> On Tue, Jul 09, 2024 at 10:59:28PM +0800, Tengfei Fan wrote:
>> Introduce support for the QCS9100 SoC device tree (DTSI) and the
>> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
>> While the QCS9100 platform is still in the early design stage, the
>> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
>> mounts the QCS9100 SoC instead of the SA8775p SoC.
>>
>> The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
>> all the compatible strings will be updated from "SA8775p" to "QCS9100".
>> The QCS9100 device tree patches will be pushed after all the device tree
>> bindings and device driver patches are reviewed.
>>
> 
> Are you going to remove SA8775p compatible from all drivers as well?

SA8775p compatible and corresponding scmi solutions for the driver will
be taken care from auto team, currently IOT team is adding QCS9100
support only. Auto team have a dependency on the current QCS9100(IOT
non-scmi solution) and SA8775p(AUTO SCMI solution) device tree splitting
effort.

More background and information can be referenced from [1].
[1] v1:
https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> 
> - Mani
> 
>> The final dtsi will like:
>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/
>>
>> The detailed cover letter reference:
>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>> Changes in v2:
>>   - Split huge patch series into different patch series according to
>>     subsytems
>>   - Update patch commit message
>>
>> prevous disscussion here:
>> [1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>>
>> ---
>> Tengfei Fan (2):
>>       dt-bindings: PCI: Document compatible for QCS9100
>>       PCI: qcom: Add support for QCS9100 SoC
>>
>>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 5 ++++-
>>  drivers/pci/controller/dwc/pcie-qcom.c                       | 1 +
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>> ---
>> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
>> change-id: 20240709-add_qcs9100_pcie_compatible-ceec013a335d
>>
>> Best regards,
>> -- 
>> Tengfei Fan <quic_tengfan@quicinc.com>
>>
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

