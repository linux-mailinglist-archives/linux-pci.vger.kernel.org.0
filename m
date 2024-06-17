Return-Path: <linux-pci+bounces-8878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADF390B932
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E798B1F23E09
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F70C16EB52;
	Mon, 17 Jun 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ku6VU/Ao"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E339B1993A5;
	Mon, 17 Jun 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647780; cv=none; b=Y23/sf3jUZj+K3GQokj0q2J5waljGHCF64jKcxpwd6a7OK1auL6/bayX6vV6ArljZ4f7k54G/ftxO919SI3K3kyMkbOfkNyrp1j0vJLNaF4UJ7/DP6i/lSQdOOyaqaiEwok1u8LbRvqL+yZ8N4KNevGwsGMLF12Nq+JQ1gRlvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647780; c=relaxed/simple;
	bh=BgaGJHJM8e0w3ayyh4Gy75kBov3Jf6uhGK/GjAr+ss4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HIF9BKj0i+9XYw0IgvL14SRaZWtaOft6Poyzdri3hWJ9cRhfgxrCme8ffcGKvUL5PzOcRfVF7VZ+ctfonPTUoiZf2GTJb1dq5kUduhpP9MOJ0gZfxpK/u8cNy5oMYLDbsxJH0ZOvpHz9MvGeIIst3tXxRIXyFJlFmSCRdI2P8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ku6VU/Ao; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAetPo007945;
	Mon, 17 Jun 2024 18:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ib0UBtopQ7Vlu5fIvwkd65iDqdQlVjR9uW1C9htA5NA=; b=Ku6VU/Aozk+Gg6la
	AGOrUAbYcZCpxaJyfVwNKjYlq1+IwXRma0OgmNoQvn5WJLupdg+YAJ8x2LjR8F53
	1vLzztQ1/MVETXu+GiIngbc70KZuKmDYuoMfn1TB1UNqEFaG7rN50fiWEo9p+YbL
	4+c2ZfFMNcLN35JDE4FiiM920umxZ71r3P4JUjStOrLW4VXgpkB51Bu1mouT/ITB
	8n95Qd5/yN2bPQieLdbb9hL/AkAwVCPZ2+HZgblvRlj2KbrYKcK43Luee+YOG8Bk
	bf1sibk4gzZohu2peGvwIM1Q2JKG/ZT8UzPD1aEaCrlk3r5+3cGzBy3365/2v/PG
	8//Yww==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys0nfcqn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 18:09:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HI9MqO018146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 18:09:22 GMT
Received: from [10.110.42.69] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 11:09:21 -0700
Message-ID: <3e45ed90-aacd-46ec-bb8b-408bc1a66883@quicinc.com>
Date: Mon, 17 Jun 2024 11:09:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] PCI: Add Qualcomm PCIe ECAM root complex driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_ramkri@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_shazhuss@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_nitegupt@quicinc.com>
References: <1712257884-23841-3-git-send-email-quic_mrana@quicinc.com>
 <20240405052918.GA2953@thinkpad>
 <e2ff3031-bd71-4df7-a3a4-cec9c2339eaa@quicinc.com>
 <20240406041717.GD2678@thinkpad>
 <0b738556-0042-43ab-80f2-d78ed3b432f7@quicinc.com>
 <20240410165829.GA418382-robh@kernel.org>
 <c623951e-1b47-4e0b-bfa4-338672a5eeb9@quicinc.com>
 <ee4c0b2b-7a3b-43d1-90b6-369be2194a65@quicinc.com>
 <20240606023952.GA3481@thinkpad>
 <ab551d96-c27e-40b7-9534-9e4b3c8a5a3c@quicinc.com>
 <20240612061454.GF2645@thinkpad>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240612061454.GF2645@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ulhjlBKLiFF30fI3tGSGwY1eClQGkPzn
X-Proofpoint-ORIG-GUID: ulhjlBKLiFF30fI3tGSGwY1eClQGkPzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170141



On 6/11/2024 11:14 PM, Manivannan Sadhasivam wrote:
> On Mon, Jun 10, 2024 at 10:17:31AM -0700, Mayank Rana wrote:
>>
>> On 6/5/2024 7:39 PM, Manivannan Sadhasivam wrote:
>>> On Fri, May 31, 2024 at 03:47:24PM -0700, Mayank Rana wrote:
>>>> Hi Rob / Mani
>>>>
>>>> On 4/15/2024 4:30 PM, Mayank Rana wrote:
>>>>> Hi Rob
>>>>>
>>>>> Excuse me for late response on this (was OOO).
>>>>> On 4/10/2024 9:58 AM, Rob Herring wrote:
>>>>>> On Mon, Apr 08, 2024 at 11:57:58AM -0700, Mayank Rana wrote:
>>>>>>> Hi Mani
>>>>>>>
>>>>>>> On 4/5/2024 9:17 PM, Manivannan Sadhasivam wrote:
>>>>>>>> On Fri, Apr 05, 2024 at 10:41:15AM -0700, Mayank Rana wrote:
>>>>>>>>> Hi Mani
>>>>>>>>>
>>>>>>>>> On 4/4/2024 10:30 PM, Manivannan Sadhasivam wrote:
>>>>>>>>>> On Thu, Apr 04, 2024 at 12:11:24PM -0700, Mayank Rana wrote:
>>>>>>>>>>> On some of Qualcomm platform, firmware
>>>>>>>>>>> configures PCIe controller into
>>>>>>>>>>> ECAM mode allowing static memory allocation for
>>>>>>>>>>> configuration space of
>>>>>>>>>>> supported bus range. Firmware also takes care of
>>>>>>>>>>> bringing up PCIe PHY
>>>>>>>>>>> and performing required operation to bring PCIe
>>>>>>>>>>> link into D0. Firmware
>>>>>>>>>>> also manages system resources (e.g.
>>>>>>>>>>> clocks/regulators/resets/ bus voting).
>>>>>>>>>>> Hence add Qualcomm PCIe ECAM root complex driver
>>>>>>>>>>> which enumerates PCIe
>>>>>>>>>>> root complex and connected PCIe devices.
>>>>>>>>>>> Firmware won't be enumerating
>>>>>>>>>>> or powering up PCIe root complex until this
>>>>>>>>>>> driver invokes power domain
>>>>>>>>>>> based notification to bring PCIe link into D0/D3cold mode.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Is this an in-house PCIe IP of Qualcomm or the same
>>>>>>>>>> DWC IP that is used in other
>>>>>>>>>> SoCs?
>>>>>>>>>>
>>>>>>>>>> - Mani
>>>>>>>>> Driver is validated on SA8775p-ride platform using PCIe DWC IP for
>>>>>>>>> now.Although this driver doesn't need to know used PCIe
>>>>>>>>> controller and PHY
>>>>>>>>> IP as well programming sequence as that would be taken
>>>>>>>>> care by firmware.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ok, so it is the same IP but firmware is controlling the
>>>>>>>> resources now. This
>>>>>>>> information should be present in the commit message.
>>>>>>>>
>>>>>>>> Btw, there is an existing generic ECAM host controller driver:
>>>>>>>> drivers/pci/controller/pci-host-generic.c
>>>>>>>>
>>>>>>>> This driver is already being used by several vendors as
>>>>>>>> well. So we should try
>>>>>>>> to extend it for Qcom usecase also.
>>>>>>
>>>>>> I would take it a bit further and say if you need your own driver, then
>>>>>> just use the default QCom driver. Perhaps extend it to support ECAM.
>>>>>> Better yet, copy your firmware setup and always configure the QCom h/w
>>>>>> to use ECAM.
>>>>> Good suggestion. Although here we are having 2 set of requirements:
>>>>> 1. ECAM configuration
>>>>> 2. Managing PCIe controller and PHY resources and programming from
>>>>> firmware as well
>>>>> Hence it is not feasible to use default QCOM driver.
>>>>>> If you want to extend the generic driver, that's fine, but we don't need
>>>>>> a 3rd.
>>>>> I did consider this part before coming up with new driver. Although I
>>>>> felt that
>>>>> below mentioned functionality may not look more generic to be part of
>>>>> pci-host-generic.c driver.
>>>>>>> I did review pci-host-generic.c driver for usage. although there
>>>>>>> are more
>>>>>>> functionalityneeded for use case purpose as below:
>>>>>>> 1. MSI functionality
>>>>>>
>>>>>> Pretty sure the generic driver already supports that.
>>>>> I don't find any MSI support with pci-host-generic.c driver.
>>>>>>> 2. Suspend/Resume
>>>>>>
>>>>>> Others might want that to work as well.
>>>>> Others firmware won't have way to handle D3cold and D0 functionality
>>>>> handling as
>>>>> needed here for supporting suspend/resume as I don't find any interface
>>>>> for pci-host-generic.c driver to notify firmware. here we are having way
>>>>> to talk to firmware using GenPD based power domain usage to communicate
>>>>> with firmware.
>>>>>
>>>>>>> 3. Wakeup Functionality (not part of current change, but would be added
>>>>>>> later)
>>>>>>
>>>>>> Others might want that to work as well.
>>>>> possible if suspend/resume support is available or used.
>>>>>>> 4. Here this driver provides way to virtualized PCIe controller.
>>>>>>> So VMs only
>>>>>>> talk to a generic ECAM whereas HW is only directed accessed by
>>>>>>> service VM.
>>>>>>
>>>>>> That's the existing driver. If if doesn't work for a VM, fix the VM.
>>>>> Correct.
>>>>>>> 5. Adding more Auto based safety use cases related implementation
>>>>>>
>>>>>> Now that's just hand waving.
>>>>> Here I am trying to provide new set of changes plan to be added as part
>>>>> of required functionality.
>>>>>
>>>>>>> Hence keeping pci-host-generic.c as generic driver where above
>>>>>>> functionality
>>>>>>> may not be needed.
>>>>>>
>>>>>> Duplicating things to avoid touching existing drivers is not how kernel
>>>>>> development works.
>>>>> I shall try your suggestion and see how it looks in terms of code
>>>>> changes. Perhaps then we can have more clarity in terms of adding more
>>>>> functionality into generic or having separate driver.
>>>> I just learnt that previously dwc related PCIe ECAM driver and MSI
>>>> controller driver tried out as:
>>>>
>>>> https://lore.kernel.org/linux-pci/20170821192907.8695-1-ard.biesheuvel@linaro.org/
>>>>
>>>> Although there were few concerns at that time. Due to that having dwc
>>>> specific MSI functionality based driver was dropped, and pci-host-generic.c
>>>> driver is being updated using with dwc/snps specific ECAM operation.
>>>>
>>>> In current discussion, it seems that we are discussing to have identical
>>>> approach here.
>>>>
>>>> Atleast on Qualcomm SA8775p platform, I don't have any other way to support
>>>> MSI functionality i.e. extended SPI or ITS/LPI based MSI or using GICv2m
>>>> functionality are not supported.
>>>>
>>>> I don't see any other approach other than MSI based implementation within
>>>> pci-host-generic.c driver for dwc/snps based MSI controller.
>>>>
>>>> Do you have any suggestion on this ?
>>>>
>>>
>>> Since this ECAM driver is going to be used in newer Qcom SoCs, why can't you use
>>> GICv3 for MSI handling?
>> Yes, that is plan further as look like we have limitation on just SA8775.
>> So I see two options here:
>> 1. Update pcie-host-generic.c without MSI based functionality, and leave
>> with MSI functionality differently on SA8775
>> 2. Also possible to make pcie-host-designware.c based MSI functionality as
>> separate driver, and try to use with pcie-host-generic.c driver. That way we
>> would still use existing MSI related code base, and able to use with ECAM
>> driver.
>>
>> Do you see using above option 2 as good way to allow SNPS/DWC based MSI
>> controller functionality with ECAM and Non-ECAM driver ?
>>
> 
> IMO, it is not worth splitting the code just for one platform since you said the
> future ECAM based platforms will not require DWC MSI.
> 
> But if you have a strong requirement to use upstream DWC MSI for SA8775, then
> you can do the split.
I feel it is better to have DWC MSI mechanism available in split fashion 
so other driver like ECAM
driver can utilize. So will update patchset here for review purpose.

> - Mani
> 

