Return-Path: <linux-pci+bounces-6300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE08A5E53
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 01:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04A41F21D05
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 23:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B306159905;
	Mon, 15 Apr 2024 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e/uogkw/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619C3E48F;
	Mon, 15 Apr 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223873; cv=none; b=KFiLHvBFg/g9UX37xIYW1HAvzXAgd9gLvByfcKTgU5JiPZWqirLmmjLd+NPVav0Fukw96WRsxex+n5H0QkkYSOWnzSomJoK/zdFWyu7qUo1Vi5PvnT2+A0L82RRYDo47OPRvUFdQuAyB/9zam9aTfaLDKMxQlX4FCy0Hh4kXekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223873; c=relaxed/simple;
	bh=Ozqw81J6Cm7EIm7S9/9fhN/jyCcOAPejuOm/ULKeqgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fGPaRc7pbOrpSUYPfNGAWDkwetBms2QvQLjAlu5cXBNDaJwjhKrCs34JkWoDQtYYqQiDdKDMtW4Fn53MKvc++mG0AwG7sNNPeSAJz3CgOaSVnJGMB45rJyHohnrck4oCILlpifc7yJP++M7nWjWmfcgaULUmIWfODE9m4cBSo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e/uogkw/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FMw3Xn003994;
	Mon, 15 Apr 2024 23:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bBP6L1aZea7WJ/01FBS0Qvao0QV2TFtDmz1tmopxE38=; b=e/
	uogkw/EBkdOFmchRLIrMAbqgXcyL60Jhk5MqoOhxb4pTfXr30qLlJz6RnhZ2JrJA
	/Nyr9NYthhzjGNmQOMtdoXWQKNXj/qtQ99AX754iqdrf8fZPDR8wvm65KpmFB/1k
	N7F+LTWCoMG9IoRO5aGM3odZELzr7vnbFcw5ZBaASO2Fp7w+2iOcGjbIS/FD8p3w
	b0LU+ntwx2P1ClOUKX6623MUQdZP6xudcQG42vcsr7XfvtcUnfftXWlAXmoecILL
	LnEORjURiPDt1RXY7jskzgeepRXvwc1rXTX6oLpTypP3PRIJKXtrQj+dmOYw/KR5
	tQaRX7MZPcBmUAyOtFow==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xha8y8d2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 23:31:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FNUxYE018125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 23:30:59 GMT
Received: from [10.110.122.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 16:30:58 -0700
Message-ID: <c623951e-1b47-4e0b-bfa4-338672a5eeb9@quicinc.com>
Date: Mon, 15 Apr 2024 16:30:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] PCI: Add Qualcomm PCIe ECAM root complex driver
To: Rob Herring <robh@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
 <1712257884-23841-3-git-send-email-quic_mrana@quicinc.com>
 <20240405052918.GA2953@thinkpad>
 <e2ff3031-bd71-4df7-a3a4-cec9c2339eaa@quicinc.com>
 <20240406041717.GD2678@thinkpad>
 <0b738556-0042-43ab-80f2-d78ed3b432f7@quicinc.com>
 <20240410165829.GA418382-robh@kernel.org>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240410165829.GA418382-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B6GBLqjdRmKNY-gl3PLAcn2kxvenlyI3
X-Proofpoint-ORIG-GUID: B6GBLqjdRmKNY-gl3PLAcn2kxvenlyI3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150157

Hi Rob

Excuse me for late response on this (was OOO).
On 4/10/2024 9:58 AM, Rob Herring wrote:
> On Mon, Apr 08, 2024 at 11:57:58AM -0700, Mayank Rana wrote:
>> Hi Mani
>>
>> On 4/5/2024 9:17 PM, Manivannan Sadhasivam wrote:
>>> On Fri, Apr 05, 2024 at 10:41:15AM -0700, Mayank Rana wrote:
>>>> Hi Mani
>>>>
>>>> On 4/4/2024 10:30 PM, Manivannan Sadhasivam wrote:
>>>>> On Thu, Apr 04, 2024 at 12:11:24PM -0700, Mayank Rana wrote:
>>>>>> On some of Qualcomm platform, firmware configures PCIe controller into
>>>>>> ECAM mode allowing static memory allocation for configuration space of
>>>>>> supported bus range. Firmware also takes care of bringing up PCIe PHY
>>>>>> and performing required operation to bring PCIe link into D0. Firmware
>>>>>> also manages system resources (e.g. clocks/regulators/resets/ bus voting).
>>>>>> Hence add Qualcomm PCIe ECAM root complex driver which enumerates PCIe
>>>>>> root complex and connected PCIe devices. Firmware won't be enumerating
>>>>>> or powering up PCIe root complex until this driver invokes power domain
>>>>>> based notification to bring PCIe link into D0/D3cold mode.
>>>>>>
>>>>>
>>>>> Is this an in-house PCIe IP of Qualcomm or the same DWC IP that is used in other
>>>>> SoCs?
>>>>>
>>>>> - Mani
>>>> Driver is validated on SA8775p-ride platform using PCIe DWC IP for
>>>> now.Although this driver doesn't need to know used PCIe controller and PHY
>>>> IP as well programming sequence as that would be taken care by firmware.
>>>>
>>>
>>> Ok, so it is the same IP but firmware is controlling the resources now. This
>>> information should be present in the commit message.
>>>
>>> Btw, there is an existing generic ECAM host controller driver:
>>> drivers/pci/controller/pci-host-generic.c
>>>
>>> This driver is already being used by several vendors as well. So we should try
>>> to extend it for Qcom usecase also.
> 
> I would take it a bit further and say if you need your own driver, then
> just use the default QCom driver. Perhaps extend it to support ECAM.
> Better yet, copy your firmware setup and always configure the QCom h/w
> to use ECAM.
Good suggestion. Although here we are having 2 set of requirements:
1. ECAM configuration
2. Managing PCIe controller and PHY resources and programming from 
firmware as well
Hence it is not feasible to use default QCOM driver.
> If you want to extend the generic driver, that's fine, but we don't need
> a 3rd.
I did consider this part before coming up with new driver. Although I 
felt that
below mentioned functionality may not look more generic to be part of 
pci-host-generic.c driver.
>> I did review pci-host-generic.c driver for usage. although there are more
>> functionalityneeded for use case purpose as below:
>> 1. MSI functionality
> 
> Pretty sure the generic driver already supports that.
I don't find any MSI support with pci-host-generic.c driver.
>> 2. Suspend/Resume
> 
> Others might want that to work as well.
Others firmware won't have way to handle D3cold and D0 functionality 
handling as
needed here for supporting suspend/resume as I don't find any interface 
for pci-host-generic.c driver to notify firmware. here we are having way 
to talk to firmware using GenPD based power domain usage to communicate 
with firmware.

>> 3. Wakeup Functionality (not part of current change, but would be added
>> later)
> 
> Others might want that to work as well.
possible if suspend/resume support is available or used.
>> 4. Here this driver provides way to virtualized PCIe controller. So VMs only
>> talk to a generic ECAM whereas HW is only directed accessed by service VM.
> 
> That's the existing driver. If if doesn't work for a VM, fix the VM.
Correct.
>> 5. Adding more Auto based safety use cases related implementation
> 
> Now that's just hand waving.
Here I am trying to provide new set of changes plan to be added as part 
of required functionality.

>> Hence keeping pci-host-generic.c as generic driver where above functionality
>> may not be needed.
> 
> Duplicating things to avoid touching existing drivers is not how kernel
> development works.
I shall try your suggestion and see how it looks in terms of code 
changes. Perhaps then we can have more clarity in terms of adding more
functionality into generic or having separate driver.
> Rob
Regards,
Mayank

