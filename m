Return-Path: <linux-pci+bounces-13108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E49768CE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 14:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E8F283D23
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA01A265C;
	Thu, 12 Sep 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d6Xbcw5J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E121A2650;
	Thu, 12 Sep 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143214; cv=none; b=htZjc1VQ07qhYN0wM5hIagZnQAGNidurLu1UzGhWOwm/S+F8n3NZ1Mmdg/nA4g5TGMd8Ylp1Pv93Sz+tIpl0a0ovzK5ft9oAPAxVeOn5VZBOSFCy0wxNVBJnELHIRoYgdZ3PonKNTgDe0iszvEkwbIgIYFKzEjWI7HsoiFY4Jgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143214; c=relaxed/simple;
	bh=v9hJJj+Lm3HHDZGzBY78EYewjEI0M9edp5kp6Dj2Rh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pTm1Tfkzdwek1Msap/eQ/bqS3l0Ir/t2Jon8rrYABAIjkKV/L7gEw1qTqk3+99NRBxCdEHV/q1ksFK8nFDT5tbC0wR27nziXrPftw9wFqYtLz4Cgwp3e/p4YvK1rMrdc3K84xY9vKFAn7G6kkGKCGw9GybEBppJ2CiGgJrkmHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d6Xbcw5J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CC8o4d006281;
	Thu, 12 Sep 2024 12:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wi3V1Yh0Ym6rUeNULoBcA83PUsy97sZxl65J9+9wSs0=; b=d6Xbcw5J27TDzRO3
	2FQIKIB64h3q0+9eQ1u6T7lS+FQNM9oHwXylENkaVS+3gg9g+zpc7F1CLZXBJWFr
	/SAgmey0iTdcQ9LvYl9GGPVMSia/YYyCbVn81s0uUwAiJGEgPIBLEpKaj0rXUPTs
	HyNZWPfr7I+0D3+uooNORmYuBOk3ufz0uonN8QpYldJP1GBUGW6+4al1ysrW5L0J
	Fam3AnonfsHL+vpYn6ShQ73mztRDUyFCWQ/Ag0dEiuVdZb0pLaBi8EQuSsvnXbIu
	uLAmmJlM2RdhUHuSuRKQurAQ8wOiy88ijPAIDZgf8VnHTHSAQ32cYq3+bOukD6vB
	/t0lIw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6pd309-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 12:13:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48CCDFGM030715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 12:13:15 GMT
Received: from [10.216.12.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Sep
 2024 05:13:10 -0700
Message-ID: <bfdc6c20-926e-533b-a8e3-0d5a3ef8be8c@quicinc.com>
Date: Thu, 12 Sep 2024 17:43:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] PCI: Enable runtime pm of the host bridge
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Mayank
 Rana" <quic_mrana@quicinc.com>,
        Markus Elfring <Markus.Elfring@web.de>, <linux-pm@vger.kernel.org>
References: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>
 <20240816204539.GA73302@bhelgaas>
 <CAJZ5v0j0ck2yKPzisggkdKTFz-AVKG7q+6WnBiiT_43VT4Fbvg@mail.gmail.com>
 <b0d8e51d-cf53-dc75-0e57-4e2e85a14827@quicinc.com>
 <CAJZ5v0jMSrkH7jCk0Ayb21vdXjCnYHHiSqdbifNFwq2OucEMtQ@mail.gmail.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAJZ5v0jMSrkH7jCk0Ayb21vdXjCnYHHiSqdbifNFwq2OucEMtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m33EoL0WISfocoJkMbn11VNPZ0iR8lxJ
X-Proofpoint-GUID: m33EoL0WISfocoJkMbn11VNPZ0iR8lxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120087



On 9/12/2024 5:27 PM, Rafael J. Wysocki wrote:
> On Thu, Sep 12, 2024 at 1:52 PM Krishna Chaitanya Chundru
> <quic_krichai@quicinc.com> wrote:
>>
>>
>>
>> On 9/12/2024 5:12 PM, Rafael J. Wysocki wrote:
>>> On Fri, Aug 16, 2024 at 10:45 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>
>>>> [+cc Rafael, Mayank, Markus (when people have commented on previous
>>>> versions, please cc them on new versions).  I'm still hoping Rafael
>>>> will have a chance to chime in]
>>>>
>>>> On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru wrote:
>>>>> The Controller driver is the parent device of the PCIe host bridge,
>>>>> PCI-PCI bridge and PCIe endpoint as shown below.
>>>>>
>>>>>           PCIe controller(Top level parent & parent of host bridge)
>>>>>                           |
>>>>>                           v
>>>>>           PCIe Host bridge(Parent of PCI-PCI bridge)
>>>>>                           |
>>>>>                           v
>>>>>           PCI-PCI bridge(Parent of endpoint driver)
>>>>>                           |
>>>>>                           v
>>>>>                   PCIe endpoint driver
>>>>>
>>>>> Now, when the controller device goes to runtime suspend, PM framework
>>>>> will check the runtime PM state of the child device (host bridge) and
>>>>> will find it to be disabled.
>>>>
>>>> I guess "will find it to be disabled"  means the child (host bridge)
>>>> has runtime PM disabled, not that the child device is disabled, right?
>>>>
>>>>> So it will allow the parent (controller
>>>>> device) to go to runtime suspend. Only if the child device's state was
>>>>> 'active' it will prevent the parent to get suspended.
>>>>
>>>> Can we include a hint like the name of the function where the PM
>>>> framework decides this?  Maybe this is rpm_check_suspend_allowed()?
>>>>
>>>> rpm_check_suspend_allowed()  checks ".ignore_children", which sounds
>>>> like it could be related, and AFAICS .ignore_children == false here,
>>>> so .child_count should be relevant.
>>>>
>>>> But I'm still confused about why we can runtime suspend a bridge that
>>>> leads to devices that are not suspended.
>>>
>>> That should only be possible if runtime PM is disabled for those devices.
>>>
>>>>> Since runtime PM is disabled for host bridge, the state of the child
>>>>> devices under the host bridge is not taken into account by PM framework
>>>>> for the top level parent, PCIe controller. So PM framework, allows
>>>>> the controller driver to enter runtime PM irrespective of the state
>>>>> of the devices under the host bridge. And this causes the topology
>>>>> breakage and also possible PM issues like controller driver goes to
>>>>> runtime suspend while endpoint driver is doing some transfers.
>>>
>>> Why is it a good idea to enable runtime PM for a PCIe controller?
>>>
>> PCIe controller can do certain actions like keeping low power state,
>> remove bandwidth votes etc as part of runtime suspend as when we know
>> the client drivers already runtime suspended.
> 
> Surely they can, but enabling runtime PM for devices that have
> children with runtime PM disabled and where those children have
> children with runtime PM enabled is a bug.
> 
we are trying to enable the runtime PM of host bridge here, so that we
can enable runtime PM of the controller.
If this change got accepted the child here(host bridge) runtime pm will
be enabled then i think there will no issue in enabling the runtime pm
of the controller then.
>>>> What does "topology breakage" mean?  Do you mean something other than
>>>> the fact that an endpoint DMA might fail if the controller is
>>>> suspended?
>>>>
>>>>> So enable runtime PM for the host bridge, so that controller driver
>>>>> goes to suspend only when all child devices goes to runtime suspend.
>>>
>>> This by itself makes sense to me.
>>>
>>>> IIUC, the one-sentence description here is that previously, the PCI
>>>> host controller could be runtime suspended even while an endpoint was
>>>> active, which caused DMA failures.  And this patch changes that so the
>>>> host controller is only runtime suspended after the entire hierarchy
>>>> below it is runtime suspended?  Is that right?
>>>>
>>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>> ---
>>>>> Changes in v4:
>>>>
>>>> (Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
>>>> offset).
>>>>
>>>>> - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
>>>>> - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
>>>>> Changes in v3:
>>>>> - Moved the runtime API call's from the dwc driver to PCI framework
>>>>>     as it is applicable for all (suggested by mani)
>>>>> - Updated the commit message.
>>>>> - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
>>>>> Changes in v2:
>>>>> - Updated commit message as suggested by mani.
>>>>> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
>>>>> ---
>>>>>
>>>>> ---
>>>>>    drivers/pci/probe.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>>> index 8e696e547565..fd49563a44d9 100644
>>>>> --- a/drivers/pci/probe.c
>>>>> +++ b/drivers/pci/probe.c
>>>>> @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>>>>>         }
>>>>>
>>>>>         pci_bus_add_devices(bus);
>>>>> +
>>>>> +     pm_runtime_set_active(&bridge->dev);
>>>>> +     devm_pm_runtime_enable(&bridge->dev);
>>>>> +
>>>>>         return 0;
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(pci_host_probe);
>>>
>>> This will effectively prevent the host bridge from being
>>> runtime-suspended at all IIUC, so the PCIe controller will never
>>> suspend too after this change.
>>>
>> No we are having a different observations here.
>> Without this change the PCIe controller driver can go to runtime suspend
>> without considering the state of the client drivers i.e even when the
>> client drivers are active.
>> After adding this change we see the pcie controller is getting runtime
>> suspended only after the client drivers are runtime suspended which is
>> the expected behaviour.
> 
> OK, but then when and how is it going to be resumed?
sorry I am not expert of the pm framework here, what we observed is when
client drivers are trying to resume using runtime_get we see the 
controller driver is also getting resume properly with this change.
let me dig in and see in code on how this is happening.

Bjorn has this view on this change in previous v2 version[1]
"My expectation is that adding new functionality should only require
changes in drivers that want to take advantage of it.  For example, if
we add runtime PM support in the controller driver, the result should
be functionally correct even if we don't update drivers for downstream
devices.

If that's not the way it works, I suggest that would be a problem in
the PM framework.

The host bridge might be a special case because we don't have a
separate "host bridge" driver; that code is kind of integrated with
the controller drivers.  So maybe it's OK to do controller + host
bridge runtime PM support at the same time, as long as any time we add
runtime PM to a controller, we sure it's also set up for the host
bridge"

[1] https://lore.kernel.org/all/20240307215505.GA632869@bhelgaas/

- Krishna Chaitanya.

