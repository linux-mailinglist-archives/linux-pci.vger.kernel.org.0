Return-Path: <linux-pci+bounces-8153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08488D6C98
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 00:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D41B23D7E
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CB81ACA;
	Fri, 31 May 2024 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="or/yvX3n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369C8168DA;
	Fri, 31 May 2024 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195660; cv=none; b=U1qUkj6frr09yAvUKok/Gtb5SVrFJh84ef7pfDXgAcpQSMyu5chBtT+mB+pa6Fd/VOVKH3b9XOEKNECsuE+77F2OYmtVPuyFz6NbfGQq3yQcvdscZCyqUmZNlY8/kU1R/+eQbQXpvO6TYPK+p9KnNA2fNBdOyRnwIJ/1wDf3h68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195660; c=relaxed/simple;
	bh=uZKOlUgKnrjSFFxBy8Z8UmPnM3fQN9yKu31pffqOGbw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=mFjdy1wm8mpspcz1xXpsNDE7atvpqm/nBjAufGK18wk5Ax7FVdVuI3UYCiLGzLvKh3XWCZI3b+AMbjQvZJ8RpG+R0BX/YY0C+khhW0UVVLWNXQprr+PfLX7cpUsSPCiggZ1DqPEzWdRbb4roV4TC4ry0RsXTwLj9AfNs4IJoEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=or/yvX3n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VIaxXI010054;
	Fri, 31 May 2024 22:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Da3rV1n7NvWq9s/Mlb7vCLA38mBzYc0YXJJr348YQNw=; b=or/yvX3nTF15fZJ3
	afB6InHxV56SP9YMdKtF2UGPZJFlcw2QpQqYzsqYtzxmQEqJLv9CwK9H8nWhBesy
	b2Y0jFNyoCD8O0aTZFwh34T5dW9JRZClk2uHmpYyrBFuT7z+8DViQQD9a40Xrmpp
	DTcvaXOT0BmaTe/MyUlplSYVaLvDwaYR2G6snFJs/hnmY/bAr7xY5V1Dcd+zhFpX
	jG0L8GovGa+HcRcaNTuc+K7ONwnTUn4zbwcRJM5QlujDEohoSdOacnGZq2cUN8su
	eW0KrQ2fYJBAH8OBggl5uOf2ekv+NweZ+5iNj0rke2w0yKw7iOmtqapYKE7tYaEO
	xZnD8g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2n8f62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 22:47:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VMlPek023550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 22:47:25 GMT
Received: from [10.110.6.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 15:47:24 -0700
Message-ID: <ee4c0b2b-7a3b-43d1-90b6-369be2194a65@quicinc.com>
Date: Fri, 31 May 2024 15:47:24 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] PCI: Add Qualcomm PCIe ECAM root complex driver
From: Mayank Rana <quic_mrana@quicinc.com>
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
 <c623951e-1b47-4e0b-bfa4-338672a5eeb9@quicinc.com>
Content-Language: en-US
In-Reply-To: <c623951e-1b47-4e0b-bfa4-338672a5eeb9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: odsCm4GH8CgZgZN4-1A87uFFHinUvuox
X-Proofpoint-ORIG-GUID: odsCm4GH8CgZgZN4-1A87uFFHinUvuox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310173

Hi Rob / Mani

On 4/15/2024 4:30 PM, Mayank Rana wrote:
> Hi Rob
> 
> Excuse me for late response on this (was OOO).
> On 4/10/2024 9:58 AM, Rob Herring wrote:
>> On Mon, Apr 08, 2024 at 11:57:58AM -0700, Mayank Rana wrote:
>>> Hi Mani
>>>
>>> On 4/5/2024 9:17 PM, Manivannan Sadhasivam wrote:
>>>> On Fri, Apr 05, 2024 at 10:41:15AM -0700, Mayank Rana wrote:
>>>>> Hi Mani
>>>>>
>>>>> On 4/4/2024 10:30 PM, Manivannan Sadhasivam wrote:
>>>>>> On Thu, Apr 04, 2024 at 12:11:24PM -0700, Mayank Rana wrote:
>>>>>>> On some of Qualcomm platform, firmware configures PCIe controller 
>>>>>>> into
>>>>>>> ECAM mode allowing static memory allocation for configuration 
>>>>>>> space of
>>>>>>> supported bus range. Firmware also takes care of bringing up PCIe 
>>>>>>> PHY
>>>>>>> and performing required operation to bring PCIe link into D0. 
>>>>>>> Firmware
>>>>>>> also manages system resources (e.g. clocks/regulators/resets/ bus 
>>>>>>> voting).
>>>>>>> Hence add Qualcomm PCIe ECAM root complex driver which enumerates 
>>>>>>> PCIe
>>>>>>> root complex and connected PCIe devices. Firmware won't be 
>>>>>>> enumerating
>>>>>>> or powering up PCIe root complex until this driver invokes power 
>>>>>>> domain
>>>>>>> based notification to bring PCIe link into D0/D3cold mode.
>>>>>>>
>>>>>>
>>>>>> Is this an in-house PCIe IP of Qualcomm or the same DWC IP that is 
>>>>>> used in other
>>>>>> SoCs?
>>>>>>
>>>>>> - Mani
>>>>> Driver is validated on SA8775p-ride platform using PCIe DWC IP for
>>>>> now.Although this driver doesn't need to know used PCIe controller 
>>>>> and PHY
>>>>> IP as well programming sequence as that would be taken care by 
>>>>> firmware.
>>>>>
>>>>
>>>> Ok, so it is the same IP but firmware is controlling the resources 
>>>> now. This
>>>> information should be present in the commit message.
>>>>
>>>> Btw, there is an existing generic ECAM host controller driver:
>>>> drivers/pci/controller/pci-host-generic.c
>>>>
>>>> This driver is already being used by several vendors as well. So we 
>>>> should try
>>>> to extend it for Qcom usecase also.
>>
>> I would take it a bit further and say if you need your own driver, then
>> just use the default QCom driver. Perhaps extend it to support ECAM.
>> Better yet, copy your firmware setup and always configure the QCom h/w
>> to use ECAM.
> Good suggestion. Although here we are having 2 set of requirements:
> 1. ECAM configuration
> 2. Managing PCIe controller and PHY resources and programming from 
> firmware as well
> Hence it is not feasible to use default QCOM driver.
>> If you want to extend the generic driver, that's fine, but we don't need
>> a 3rd.
> I did consider this part before coming up with new driver. Although I 
> felt that
> below mentioned functionality may not look more generic to be part of 
> pci-host-generic.c driver.
>>> I did review pci-host-generic.c driver for usage. although there are 
>>> more
>>> functionalityneeded for use case purpose as below:
>>> 1. MSI functionality
>>
>> Pretty sure the generic driver already supports that.
> I don't find any MSI support with pci-host-generic.c driver.
>>> 2. Suspend/Resume
>>
>> Others might want that to work as well.
> Others firmware won't have way to handle D3cold and D0 functionality 
> handling as
> needed here for supporting suspend/resume as I don't find any interface 
> for pci-host-generic.c driver to notify firmware. here we are having way 
> to talk to firmware using GenPD based power domain usage to communicate 
> with firmware.
> 
>>> 3. Wakeup Functionality (not part of current change, but would be added
>>> later)
>>
>> Others might want that to work as well.
> possible if suspend/resume support is available or used.
>>> 4. Here this driver provides way to virtualized PCIe controller. So 
>>> VMs only
>>> talk to a generic ECAM whereas HW is only directed accessed by 
>>> service VM.
>>
>> That's the existing driver. If if doesn't work for a VM, fix the VM.
> Correct.
>>> 5. Adding more Auto based safety use cases related implementation
>>
>> Now that's just hand waving.
> Here I am trying to provide new set of changes plan to be added as part 
> of required functionality.
> 
>>> Hence keeping pci-host-generic.c as generic driver where above 
>>> functionality
>>> may not be needed.
>>
>> Duplicating things to avoid touching existing drivers is not how kernel
>> development works.
> I shall try your suggestion and see how it looks in terms of code 
> changes. Perhaps then we can have more clarity in terms of adding more
> functionality into generic or having separate driver.
I just learnt that previously dwc related PCIe ECAM driver and MSI 
controller driver tried out as:

https://lore.kernel.org/linux-pci/20170821192907.8695-1-ard.biesheuvel@linaro.org/

Although there were few concerns at that time. Due to that having dwc 
specific MSI functionality based driver was dropped, and 
pci-host-generic.c driver is being updated using with dwc/snps specific 
ECAM operation.

In current discussion, it seems that we are discussing to have identical 
approach here.

Atleast on Qualcomm SA8775p platform, I don't have any other way to 
support MSI functionality i.e. extended SPI or ITS/LPI based MSI or 
using GICv2m functionality are not supported.

I don't see any other approach other than MSI based implementation 
within pci-host-generic.c driver for dwc/snps based MSI controller.

Do you have any suggestion on this ?

Regards,
Mayank



