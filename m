Return-Path: <linux-pci+bounces-6181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A576D8A2C5C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE221F22BC1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 10:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845942BB10;
	Fri, 12 Apr 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OyiPuYbg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A342C9D;
	Fri, 12 Apr 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917996; cv=none; b=mMxpTzf/xpUtuZkuKOnJHxzenoo4C/YM9pk6/bs6J6b+qEeDDJzh+iHyc/xQHkNdtRM81kd+/cw5k183SyFjFrALuw1CgXzfKgXSCDEBQPkY8f/YL5VLF+qxJB6yLSCc5cOL04hktfku5LXCD1yw4nvJySEj0n0pvpFmPUwWHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917996; c=relaxed/simple;
	bh=j60ZienQWmR5jY6YPYgpGQu2B+rtEXgDO2YyuUT+SbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ABYqnpT7E6gUj6AhxjaAYKvroa+3Uu4DfxiDACAJZ66uoHnf8W0RhsxMkMCdNT0p/FwKD4eylsqQ7l24dRY+V9z7LXh9R7QCs1MbQDeDFjwR3EcRB9inEsEsB6KOX11TqdGFOVxp6V+EsxG5/1Cz4KqjTN1irQL+D1wVDeIM0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OyiPuYbg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C7ocfR031970;
	Fri, 12 Apr 2024 10:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VAt9X2Zg1/67O0zEcb2kEAucsDv6Pj/+QvQmv8yAuqI=; b=Oy
	iPuYbgy0+YAYnnZ0wmtSVwRySnQbK4pDAgn5GKdWYhTNvsqTQXFUaiRVBAQ6djWN
	FxOoHNqUmwgG7kICQWSN45l/I1BHC19odzchrvb0ME6mzOPw2GCgTEvi3qx3kQ7e
	yHoOM40tls3ood5Ccgxhi91mseP8bQn0dJry/MTtfj3ahtIs0lb8IQwB5qdJjB75
	WhfmfvLqYnTIScwBWvxT2rGj5rMOz58miTtw9M3Gy/SRcS7SfWOAsV3MxxdD9VlI
	dIMpNpLkxXoCrsaPVHYBWe12CnQSvuEu6aS9ENvglTAIgGt8Cv6zn+RPG1DNXYKl
	F2aOSSR+kWv8c4ChpF2g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xer1tsc41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 10:32:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CAWuB9004146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 10:32:56 GMT
Received: from [10.216.39.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 03:32:51 -0700
Message-ID: <5b7ab46f-3448-f212-fe26-fc7019ce63d3@quicinc.com>
Date: Fri, 12 Apr 2024 16:02:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] PCI: dwc: Enable runtime pm of the host bridge
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas
	<helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240319111148.GF52500@thinkpad>
 <20240322220456.GA1379507@bhelgaas> <20240325110959.GC2938@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240325110959.GC2938@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NmWCEZe8krh45bg65Xs_naY-Xjvd3k2l
X-Proofpoint-GUID: NmWCEZe8krh45bg65Xs_naY-Xjvd3k2l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120075



On 3/25/2024 4:39 PM, Manivannan Sadhasivam wrote:
> On Fri, Mar 22, 2024 at 05:04:56PM -0500, Bjorn Helgaas wrote:
>> On Tue, Mar 19, 2024 at 04:41:48PM +0530, Manivannan Sadhasivam wrote:
>>> On Fri, Mar 08, 2024 at 11:12:48AM -0600, Bjorn Helgaas wrote:
>>>> On Fri, Mar 08, 2024 at 08:38:52AM +0530, Krishna Chaitanya Chundru wrote:
>>>>> On 3/8/2024 3:25 AM, Bjorn Helgaas wrote:
>>>>>> [+to Rafael, sorry, another runtime PM question, beginning of thread:
>>>>>> https://lore.kernel.org/r/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com]
>>>>>>
>>>>>> On Thu, Mar 07, 2024 at 07:28:54AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>> On 3/6/2024 1:27 AM, Bjorn Helgaas wrote:
>>>>>>>> On Tue, Mar 05, 2024 at 03:19:01PM +0530, Krishna chaitanya chundru wrote:
>>>>>>>>> The Controller driver is the parent device of the PCIe host bridge,
>>>>>>>>> PCI-PCI bridge and PCIe endpoint as shown below.
>>>>>>>>>
>>>>>>>>> 	PCIe controller(Top level parent & parent of host bridge)
>>>>>>>>> 			|
>>>>>>>>> 			v
>>>>>>>>> 	PCIe Host bridge(Parent of PCI-PCI bridge)
>>>>>>>>> 			|
>>>>>>>>> 			v
>>>>>>>>> 	PCI-PCI bridge(Parent of endpoint driver)
>>>>>>>>> 			|
>>>>>>>>> 			v
>>>>>>>>> 		PCIe endpoint driver
>>>>>>>>>
>>>>>>>>> Since runtime PM is disabled for host bridge, the state of the child
>>>>>>>>> devices under the host bridge is not taken into account by PM framework
>>>>>>>>> for the top level parent, PCIe controller. So PM framework, allows
>>>>>>>>> the controller driver to enter runtime PM irrespective of the state
>>>>>>>>> of the devices under the host bridge.
>>>>>>>>
>>>>>>>> IIUC this says that we runtime suspend the controller even though
>>>>>>>> runtime PM is disabled for the host bridge?  I have a hard time
>>>>>>>> parsing this; can you cite a function that does this or some relevant
>>>>>>>> documentation about how this part of runtime PM works?
>>>>>>>>
>>>>>>> Generally controller should go to runtime suspend when endpoint client
>>>>>>> drivers and pci-pci host bridge drivers goes to runtime suspend as the
>>>>>>> controller driver is the parent, but we are observing controller driver
>>>>>>> goes to runtime suspend even when client drivers and PCI-PCI bridge are
>>>>>>> in active state.
>>>>>>
>>>>>> It surprises me that a device could be suspended while children are
>>>>>> active.  A PCI-PCI bridge must be in D0 for any devices below it to be
>>>>>> active.  The controller is a platform device, not a PCI device, but I
>>>>>> am similarly surprised that we would suspend it when children are
>>>>>> active, which makes me think we didn't set the hierarchy up correctly.
>>>>>>
>>>>>> It doesn't seem like we should need to enable runtime PM for a parent
>>>>>> to keep it from being suspended when children are active.
>>>>>
>>>>> Here we are not enabling runtime PM of the controller device, we are
>>>>> enabling runtime PM for the bridge device which is maintained by the
>>>>> PCIe framework. The bridge device is the parent of the PCI-PCI
>>>>> bridge and child of the controller device. As the bridge device's
>>>>> runtime PM is not enabled the PM framework is ignoring the child's
>>>>> runtime status.
>>>>
>>>> OK, it's the host bridge, not the controller.
>>>>
>>>> I'm still surprised that the PM framework will runtime suspend a
>>>> device when child devices are active.
>>>
>>> There is a catch here. Even though the child devices are funtionally
>>> active, PM framework will only consider their runtime_pm state,
>>> which is initially set to 'disabled' for all devices. It is upto the
>>> device drivers to enable it when required.
>>>
>>> Here is the initial runtime PM status of each device post boot:
>>>
>>> Controller device -> disabled initially but enabled by pcie-qcom.c
>>> Host bridge -> disabled initially
>>> PCIe bridge -> disabled initially but conditionally enabled by portdrv.c
>>> PCIe devices -> disabled initially but enabled by respective drivers like WLAN
>>>
>>> Now, when the controller device goes to runtime suspend, PM
>>> framework will check the runtime PM state of the child device (host
>>> bridge) and will find it to be disabled. So it will allow the parent
>>> (controller device) to go to runtime suspend. Only if the child
>>> device's state was 'active' it will prevent the parent to get
>>> suspended.
>>>
>>> But you may wonder if this is ideal? IMO NO. But we cannot blame the
>>> PM framework here. The responsibility is within the device drivers
>>> to handle the PM state based on the usecase. Ideally, the host
>>> bridge driver should've handled runtime PM state during the probe
>>> time. Otherwise, PM framework wouldn't know when would be the best
>>> time to suspend the devices.
>>
>> My expectation is that adding new functionality should only require
>> changes in drivers that want to take advantage of it.  For example, if
>> we add runtime PM support in the controller driver, the result should
>> be functionally correct even if we don't update drivers for downstream
>> devices.
>>
> 
> Well, IMO PM framework should disable runtime PM for the parent if the child's
> runtime PM state is disabled.
> 
> It'd be good to get the opinion of Rafael.
>
Hi Rafeal,

can you please comment on this.

> - Mani
> 
>> If that's not the way it works, I suggest that would be a problem in
>> the PM framework.
>>
>> The host bridge might be a special case because we don't have a
>> separate "host bridge" driver; that code is kind of integrated with
>> the controller drivers.  So maybe it's OK to do controller + host
>> bridge runtime PM support at the same time, as long as any time we add
>> runtime PM to a controller, we sure it's also set up for the host
>> bridge.
>>
>> Bjorn
> 

