Return-Path: <linux-pci+bounces-10054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D868692CF2F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 12:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076CB1C2392B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9B194A7E;
	Wed, 10 Jul 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AHglaftd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBF190068;
	Wed, 10 Jul 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607133; cv=none; b=p0dNA0KRrsFnEAb2waTLKkdReXn2DH1HcEJMe4NhhEoOmkycvr04SE6p/zBEI3lPL7iXUFTTfPqssmA6gV+6IjE3eHXHKWBMXv3DdcM50Mbk+A0HQFIuKhJFealj3P7+cFO9SWnt0I3gGCP0NxfNHIBaY0MWdRWzkyQ7kEKTQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607133; c=relaxed/simple;
	bh=OItdgYZEX6+etxezYKYw3Axjz71HUX1jrCV+j1iDuAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m6dgiOZ7KDRjMkNbNngMPV5009DsRfFJfMO3ku/MY203ibbQMm2JhHya6xrp1U7LcFi6AD088tINmEc7Z4X0dG4Zu5atRGDfCGTtfHUgPnVjhJKccHu5fEhG3p81U88KnFI5YgIryHCul9Gy3OcxH8VoD8JXm6+tLZ4FSAPtchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AHglaftd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A09rNX020426;
	Wed, 10 Jul 2024 10:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zdctES4zj+uyBrijgw6n67vpIT9s/pRBGfdOtGmqDpU=; b=AHglaftdsIH3dMS1
	jZzFvxjz709HafISBtXCg5/PsuHpvC5XdUxGtaMnqSblVlTDLgPE0ztJktU3SgMG
	f8TQ9fjdbsx+Dnd/Hm0sSdmDaqxrMMJHkrVKKhJpt444+4/EMdYrH9c6EVSRpR9d
	jczwdAN1GcT4IF7Cut0dZlklsK56CFdMbRbTKxcc3YJsG3g7k9BJ8tbnzRThgHlT
	aSdjF7HFHR82LJ4Ykec2W8S9TvtYcwcIJuS31Xg7g8NElAl8olxf/Oi5yMxddnRt
	JRv1qzjMbNi7HdeOlO7utnrsk/MznDnT6mGE+IY1M/iZSGPs1lQCl9Z2gZI7mjEG
	aDw8xw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa68x2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 10:25:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AAPHcD022574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 10:25:17 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 03:25:11 -0700
Message-ID: <239f408d-7bab-48c3-bf26-3880012d9098@quicinc.com>
Date: Wed, 10 Jul 2024 18:25:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI: qcom: Add QCS9100 PCIe compatible
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Tengfei Fan <quic_tengfan@quicinc.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240709-add_qcs9100_pcie_compatible-v2-0-04f1e85c8a48@quicinc.com>
 <20240709175823.GB44420@thinkpad>
 <1fafb584-fc49-45be-a8a4-4027739eba32@quicinc.com>
 <20240710070908.GA3731@thinkpad>
Content-Language: en-US
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <20240710070908.GA3731@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YinPFAERX8GE8IkCyCBNZEcX8CC-a0e5
X-Proofpoint-ORIG-GUID: YinPFAERX8GE8IkCyCBNZEcX8CC-a0e5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100071



On 7/10/2024 3:09 PM, Manivannan Sadhasivam wrote:
> On Wed, Jul 10, 2024 at 09:47:47AM +0800, Aiqun Yu (Maria) wrote:
>>
>>
>> On 7/10/2024 1:58 AM, Manivannan Sadhasivam wrote:
>>> On Tue, Jul 09, 2024 at 10:59:28PM +0800, Tengfei Fan wrote:
>>>> Introduce support for the QCS9100 SoC device tree (DTSI) and the
>>>> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
>>>> While the QCS9100 platform is still in the early design stage, the
>>>> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
>>>> mounts the QCS9100 SoC instead of the SA8775p SoC.
>>>>
>>>> The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
>>>> all the compatible strings will be updated from "SA8775p" to "QCS9100".
>>>> The QCS9100 device tree patches will be pushed after all the device tree
>>>> bindings and device driver patches are reviewed.
>>>>
>>>
>>> Are you going to remove SA8775p compatible from all drivers as well?
>>
>> SA8775p compatible and corresponding scmi solutions for the driver will
>> be taken care from auto team, currently IOT team is adding QCS9100
>> support only. Auto team have a dependency on the current QCS9100(IOT
>> non-scmi solution) and SA8775p(AUTO SCMI solution) device tree splitting
>> effort.
>>
>> More background and information can be referenced from [1].
>> [1] v1:
>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> 
> I'm aware of the background, but what I don't understand is, why do you want to
> keep the sa8775p compatible in both the driver and binding? Once you rename the
> DT, these compatibles become meaningless.
> 
> Waiting for Auto team to remove the compatible is not ideal. They may anyway
> modify it based on SCMI design.

Got it. Will remove sa8775p compatible in next patchset version after
discuss with Tengfei.

PCIE driver have a very good shape of resources op api, and when SCMI
resource solution added, "sa8775p" compatible can be added at that time
with correct SCMI resource ops.
> 
> - Mani
> 
>>>
>>> - Mani
>>>
>>>> The final dtsi will like:
>>>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/
>>>>
>>>> The detailed cover letter reference:
>>>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>>>>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>> Changes in v2:
>>>>   - Split huge patch series into different patch series according to
>>>>     subsytems
>>>>   - Update patch commit message
>>>>
>>>> prevous disscussion here:
>>>> [1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>>>>
>>>> ---
>>>> Tengfei Fan (2):
>>>>       dt-bindings: PCI: Document compatible for QCS9100
>>>>       PCI: qcom: Add support for QCS9100 SoC
>>>>
>>>>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 5 ++++-
>>>>  drivers/pci/controller/dwc/pcie-qcom.c                       | 1 +
>>>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>>> ---
>>>> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
>>>> change-id: 20240709-add_qcs9100_pcie_compatible-ceec013a335d
>>>>
>>>> Best regards,
>>>> -- 
>>>> Tengfei Fan <quic_tengfan@quicinc.com>
>>>>
>>>
>>
>> -- 
>> Thx and BRs,
>> Aiqun(Maria) Yu
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

