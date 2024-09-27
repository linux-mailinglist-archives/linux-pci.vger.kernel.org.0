Return-Path: <linux-pci+bounces-13588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724EB987D5C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 05:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CC0B20159
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 03:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7FA16FF3B;
	Fri, 27 Sep 2024 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V9Fvw/1j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B59B658;
	Fri, 27 Sep 2024 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409434; cv=none; b=TAUauo90/ajq/vyK1R8Atx0pTo3JNzWcJHeCyjucqMwxSJ2LQCbcj4uxS/O/sV17Xj2nd+BR/O/fcsYZy7ZFqwR28V+JRvVXLgBi4tBNYJ1hH+CKhgpcPLp82KxjnaMjRyu5TLOwjwY9lQtp4qbCmCkVoGJIGlPogIzRjixj/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409434; c=relaxed/simple;
	bh=0VYXZOMHdb97xrJw3Bxek1KAWuBB5y3ij48UdQXQTq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gyT7umJsE1kYYxbJTQhcQE7UUTPizuSRqT9ctYJLCrCyqDx4QxqRqX2lE/o4+A1m/HZ9Z+ZN0NecvUwuV0pZB/uz9Gcx0TIYxJb2zNNouNJgMsUkIzMhS5cjW+Ii2uUeEFsDH+EDha1hAnyAdgKfhcZTepSFjstZJR6UEVHIb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V9Fvw/1j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QG9hmk023021;
	Fri, 27 Sep 2024 03:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WvpeeRsSM5EanVHRP5dl54ylZHK/SV1lTkb/Y1w5qKc=; b=V9Fvw/1jYfX1FlUm
	TFPRHyPryhlLSXSdNoUQw/UehOQ+lT0To3m33Vj+GWGhsgOrsLJOwdPzE89vDCsv
	IrQ5J6EACzgo9VRQNyFmLTZ2by49djrQOHCikEYP2OkofvPHxzARxj4lBMkEbulJ
	FE4iyBsNMeFxkU4ckF74d+FPNDe/8v+etPY+alqpADVFwJ9WjHkv4561295uFqCU
	Bv4lm/Np3HQccPtkSfelTrckqWcgYiVHzp7whZndgZknkDAkG4FOX1rsHV2rzQfK
	5fUuna/NC9kFeQmUqLyXHwkXHbK2Mp1L+T3Gr298tD5nMmLyJM3FNjknmfw2kxZw
	jsafgw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41spwf1d64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 03:57:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48R3v1fF010167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 03:57:02 GMT
Received: from [10.216.42.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Sep
 2024 20:56:54 -0700
Message-ID: <0506433c-62c5-e7c0-8c8a-55744a5e87d6@quicinc.com>
Date: Fri, 27 Sep 2024 09:26:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] PCI: Enable runtime pm of the host bridge
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>,
        Mayank Rana <quic_mrana@quicinc.com>,
        Markus Elfring
	<Markus.Elfring@web.de>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>
References: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>
 <20240816204539.GA73302@bhelgaas>
 <CAJZ5v0j0ck2yKPzisggkdKTFz-AVKG7q+6WnBiiT_43VT4Fbvg@mail.gmail.com>
 <b0d8e51d-cf53-dc75-0e57-4e2e85a14827@quicinc.com>
 <CAJZ5v0jMSrkH7jCk0Ayb21vdXjCnYHHiSqdbifNFwq2OucEMtQ@mail.gmail.com>
 <bfdc6c20-926e-533b-a8e3-0d5a3ef8be8c@quicinc.com>
 <CAJZ5v0gHw=BUGn7MkRaLnAQ9ki-YDOL3SpNxd0X9YmTVG-ofzw@mail.gmail.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAJZ5v0gHw=BUGn7MkRaLnAQ9ki-YDOL3SpNxd0X9YmTVG-ofzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n7_WLklo29El0qDiL1ERIp9snqkwVsOm
X-Proofpoint-ORIG-GUID: n7_WLklo29El0qDiL1ERIp9snqkwVsOm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270025

Hi Bjorn,

when you get time can you look into this.
if there are no further concerns I will respin this patch.

- Krishna Chaitanya.

On 9/12/2024 9:00 PM, Rafael J. Wysocki wrote:
> On Thu, Sep 12, 2024 at 2:13 PM Krishna Chaitanya Chundru
> <quic_krichai@quicinc.com> wrote:
>>
>>
>>
>> On 9/12/2024 5:27 PM, Rafael J. Wysocki wrote:
>>> On Thu, Sep 12, 2024 at 1:52 PM Krishna Chaitanya Chundru
>>> <quic_krichai@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/12/2024 5:12 PM, Rafael J. Wysocki wrote:
>>>>> On Fri, Aug 16, 2024 at 10:45 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>
>>>>>> [+cc Rafael, Mayank, Markus (when people have commented on previous
>>>>>> versions, please cc them on new versions).  I'm still hoping Rafael
>>>>>> will have a chance to chime in]
>>>>>>
>>>>>> On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru wrote:
>>>>>>> The Controller driver is the parent device of the PCIe host bridge,
>>>>>>> PCI-PCI bridge and PCIe endpoint as shown below.
>>>>>>>
>>>>>>>            PCIe controller(Top level parent & parent of host bridge)
>>>>>>>                            |
>>>>>>>                            v
>>>>>>>            PCIe Host bridge(Parent of PCI-PCI bridge)
>>>>>>>                            |
>>>>>>>                            v
>>>>>>>            PCI-PCI bridge(Parent of endpoint driver)
>>>>>>>                            |
>>>>>>>                            v
>>>>>>>                    PCIe endpoint driver
>>>>>>>
>>>>>>> Now, when the controller device goes to runtime suspend, PM framework
>>>>>>> will check the runtime PM state of the child device (host bridge) and
>>>>>>> will find it to be disabled.
>>>>>>
>>>>>> I guess "will find it to be disabled"  means the child (host bridge)
>>>>>> has runtime PM disabled, not that the child device is disabled, right?
>>>>>>
>>>>>>> So it will allow the parent (controller
>>>>>>> device) to go to runtime suspend. Only if the child device's state was
>>>>>>> 'active' it will prevent the parent to get suspended.
>>>>>>
>>>>>> Can we include a hint like the name of the function where the PM
>>>>>> framework decides this?  Maybe this is rpm_check_suspend_allowed()?
>>>>>>
>>>>>> rpm_check_suspend_allowed()  checks ".ignore_children", which sounds
>>>>>> like it could be related, and AFAICS .ignore_children == false here,
>>>>>> so .child_count should be relevant.
>>>>>>
>>>>>> But I'm still confused about why we can runtime suspend a bridge that
>>>>>> leads to devices that are not suspended.
>>>>>
>>>>> That should only be possible if runtime PM is disabled for those devices.
>>>>>
>>>>>>> Since runtime PM is disabled for host bridge, the state of the child
>>>>>>> devices under the host bridge is not taken into account by PM framework
>>>>>>> for the top level parent, PCIe controller. So PM framework, allows
>>>>>>> the controller driver to enter runtime PM irrespective of the state
>>>>>>> of the devices under the host bridge. And this causes the topology
>>>>>>> breakage and also possible PM issues like controller driver goes to
>>>>>>> runtime suspend while endpoint driver is doing some transfers.
>>>>>
>>>>> Why is it a good idea to enable runtime PM for a PCIe controller?
>>>>>
>>>> PCIe controller can do certain actions like keeping low power state,
>>>> remove bandwidth votes etc as part of runtime suspend as when we know
>>>> the client drivers already runtime suspended.
>>>
>>> Surely they can, but enabling runtime PM for devices that have
>>> children with runtime PM disabled and where those children have
>>> children with runtime PM enabled is a bug.
>>>
>> we are trying to enable the runtime PM of host bridge here, so that we
>> can enable runtime PM of the controller.
> 
> So this is a preliminary step.  That was unclear to me.
> 
>> If this change got accepted the child here(host bridge) runtime pm will
>> be enabled then i think there will no issue in enabling the runtime pm
>> of the controller then.
>>>>>> What does "topology breakage" mean?  Do you mean something other than
>>>>>> the fact that an endpoint DMA might fail if the controller is
>>>>>> suspended?
>>>>>>
>>>>>>> So enable runtime PM for the host bridge, so that controller driver
>>>>>>> goes to suspend only when all child devices goes to runtime suspend.
>>>>>
>>>>> This by itself makes sense to me.
>>>>>
>>>>>> IIUC, the one-sentence description here is that previously, the PCI
>>>>>> host controller could be runtime suspended even while an endpoint was
>>>>>> active, which caused DMA failures.  And this patch changes that so the
>>>>>> host controller is only runtime suspended after the entire hierarchy
>>>>>> below it is runtime suspended?  Is that right?
>>>>>>
>>>>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>>>> ---
>>>>>>> Changes in v4:
>>>>>>
>>>>>> (Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
>>>>>> offset).
>>>>>>
>>>>>>> - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
>>>>>>> - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
>>>>>>> Changes in v3:
>>>>>>> - Moved the runtime API call's from the dwc driver to PCI framework
>>>>>>>      as it is applicable for all (suggested by mani)
>>>>>>> - Updated the commit message.
>>>>>>> - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
>>>>>>> Changes in v2:
>>>>>>> - Updated commit message as suggested by mani.
>>>>>>> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
>>>>>>> ---
>>>>>>>
>>>>>>> ---
>>>>>>>     drivers/pci/probe.c | 4 ++++
>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>>>>> index 8e696e547565..fd49563a44d9 100644
>>>>>>> --- a/drivers/pci/probe.c
>>>>>>> +++ b/drivers/pci/probe.c
>>>>>>> @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>>>>>>>          }
>>>>>>>
>>>>>>>          pci_bus_add_devices(bus);
>>>>>>> +
>>>>>>> +     pm_runtime_set_active(&bridge->dev);
>>>>>>> +     devm_pm_runtime_enable(&bridge->dev);
>>>>>>> +
>>>>>>>          return 0;
>>>>>>>     }
>>>>>>>     EXPORT_SYMBOL_GPL(pci_host_probe);
>>>>>
>>>>> This will effectively prevent the host bridge from being
>>>>> runtime-suspended at all IIUC, so the PCIe controller will never
>>>>> suspend too after this change.
>>>>>
>>>> No we are having a different observations here.
>>>> Without this change the PCIe controller driver can go to runtime suspend
>>>> without considering the state of the client drivers i.e even when the
>>>> client drivers are active.
>>>> After adding this change we see the pcie controller is getting runtime
>>>> suspended only after the client drivers are runtime suspended which is
>>>> the expected behaviour.
>>>
>>> OK, but then when and how is it going to be resumed?
>>
>> sorry I am not expert of the pm framework here, what we observed is when
>> client drivers are trying to resume using runtime_get we see the
>> controller driver is also getting resume properly with this change.
>> let me dig in and see in code on how this is happening.
>>
>> Bjorn has this view on this change in previous v2 version[1]
>> "My expectation is that adding new functionality should only require
>> changes in drivers that want to take advantage of it.  For example, if
>> we add runtime PM support in the controller driver, the result should
>> be functionally correct even if we don't update drivers for downstream
>> devices.
>>
>> If that's not the way it works, I suggest that would be a problem in
>> the PM framework.
> 
> You can say so, but that's how it goes.
> 
> If there are any devices with runtime PM disabled in a dependency
> chain, the runtime PM framework cannot follow that chain as a whole.
> If enabling runtime PM for a device leads to this situation, it is not
> correct.
> 
>> The host bridge might be a special case because we don't have a
>> separate "host bridge" driver; that code is kind of integrated with
>> the controller drivers.  So maybe it's OK to do controller + host
>> bridge runtime PM support at the same time, as long as any time we add
>> runtime PM to a controller, we sure it's also set up for the host
>> bridge"
> 
> I think that you can enable runtime PM for host bridge devices in
> general, as long as they don't need to be resumed without resuming any
> of their children.
> 
> If that's the case, resuming one of its children will also cause the
> host bridge to resume and all should be fine, although you also need
> to ensure that system-wide suspend handling is in agreement with this.
> 
> I would suggest calling pm_runtime_no_callbacks() for the host bridge device.
> 
>> [1] https://lore.kernel.org/all/20240307215505.GA632869@bhelgaas/
> 
> And this is the information to put into your patch changelog:
> 
> 1. It is a property of the runtime PM framework that it can only
> follow continuous dependency chains.  That is, if there is a device
> with runtime PM disabled in a dependency chain, runtime PM cannot be
> enabled for devices below it and above it in that chain both at the
> same time.
> 
> 2. Because of the above, in order to enable runtime PM for a PCIe
> controller device, one needs to ensure that runtime PM is enabled for
> all devices in every dependency chain between it and any PCIe endpoint
> (as runtime PM is enabled for PCIe endpoints).
> 
> 3. This means that runtime PM needs to be enabled for the host bridge
> device, which is present in all of these dependency chains.
> 
> 4. After this change, the host bridge device will be runtime-suspended
> by the runtime PM framework automatically after suspending its last
> child and it will be runtime-resumed automatically before resuming its
> first child which will allow the runtime PM framework to track
> dependencies between the host bridge device and all of its
> descendants.
> 
> Thanks!

