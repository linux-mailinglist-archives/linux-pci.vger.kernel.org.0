Return-Path: <linux-pci+bounces-13483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC8985230
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 07:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F551C230D8
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611AD153573;
	Wed, 25 Sep 2024 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dU7F8P7Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAFE2F32;
	Wed, 25 Sep 2024 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727241302; cv=none; b=s3FlKCGZ6MCXSRjNWhJmODCAEZExjUf9IlxJ+D4Cf6uzgaLgVudsiA8inmcMof3Fk8Ub9Vb4tHS3k8Nqz2ljX/RNMAjjiyViWvlSBEQWXTVYpfEntL16F2/p5dhCkl4fg1fPpx4OTTtrgf4ZaN1NZvVNzI/KHnSJ75DW7lXaGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727241302; c=relaxed/simple;
	bh=BqcGnXf1vS6ovhP2XVDY480NLmrSKRMxm49twdwHJBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FsgeZ9oRoZDDMlkzCEnPR104L/Skj/pB+QYd9utGs0JphG9RYxTDaZWBkgxufhTMYQ/sV4uSC6WOtaW3FQF3pkkE8Vk8uSJy4xgDwQzGEiAjbWQhPuYIzDE9E0QHkOzEfezOKoWYJCb1wUfQdON/FGMI9OKhbXvVlMGlzPMfApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dU7F8P7Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHGeTX028857;
	Wed, 25 Sep 2024 05:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3WeJE1USe/0dUxdGsgV9jXnMQKmZZilfXp5vTAgVn04=; b=dU7F8P7YGWnyzkxe
	zzg+7kxqRHqNkcyCXZedwI9X3AVuJM5uatn6sjPh/6CR/ZOZU+uEPtiQvQqJx7Px
	6s2KK55zK/nUZRA5sTAHAOAz8kXGqvgf9XJQ7C48pGMtDQC/WUV+gFblt1pCb5p2
	GT3OjImHpopwIkptvj/8OU50DwPQtfxSRbKM2twfh3B5XWn4dYl1V1VI0aSLN9tv
	5RINKPwzxYx25H5QXAqSWJflPxr/LEdpdfuhBjacQzgqkKmE3u/84HQ29431T1VA
	oHAziR+/au6pppNt7b45iyc/mLcKRoKZhBi3D8bEHT4CHP4mX1VM/Frs9IzuUqE6
	dJ777A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfh33vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 05:14:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P5Egfe014851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 05:14:42 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 22:14:39 -0700
Message-ID: <a932719b-5f8a-4af1-a9af-f4adf4e072c5@quicinc.com>
Date: Wed, 25 Sep 2024 13:14:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unexptect ACPI GPE wakeup on Lenovo platforms
To: Mario Limonciello <mario.limonciello@amd.com>, <rafael@kernel.org>,
        <mika.westerberg@linux.intel.com>, <ulf.hansson@linaro.org>,
        <bhelgaas@google.com>, <Basavaraj.Natikar@amd.com>,
        <Shyam-sundar.S-k@amd.com>, <mpearson@lenovo.com>,
        <markpearson@lenovo.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-acpi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
References: <370d023e-ec53-4bf2-a005-48524c9cb4b2@quicinc.com>
 <79d288c6-6042-4f73-b465-0ddcde14509a@amd.com>
 <b51c89f0-035a-4e94-adc3-e1b4fc31dfdd@quicinc.com>
 <91e179ca-ff2e-48b0-813d-7b819e300dca@amd.com>
 <115efc10-60fd-436f-99b6-0b141f9585e7@quicinc.com>
 <5012908a-9ece-4c16-9d01-2633df740fbb@amd.com>
 <f3e31284-09d0-4a30-be74-34d33efe8535@quicinc.com>
 <8a218293-e2d7-4a1c-9a7d-f113a68f1449@amd.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <8a218293-e2d7-4a1c-9a7d-f113a68f1449@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FY_9UekrO_JeWFAuB7qAb09aAxDh8ssc
X-Proofpoint-GUID: FY_9UekrO_JeWFAuB7qAb09aAxDh8ssc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250034



On 9/25/2024 12:08 PM, Mario Limonciello wrote:
> On 9/24/2024 23:02, Baochen Qiang wrote:
>>
>>
>> On 9/25/2024 11:46 AM, Mario Limonciello wrote:
>>> On 9/24/2024 21:18, Baochen Qiang wrote:
>>>>>
>>>>> Yeah that's what it looks like to me too.  The easiest way to confirm this (without a schematic that is) is to look at the _AEI / _EVT in the SSDT and see what is notified when this is active.
>>>> seems GPP6 is notified, does this mean GPIO18 is NOT bound to WLAN wakeup pin? but instead it is bound to the PCIe root port?
>>>
>>> There is a concept in AMD machines called "GPIO mirroring" where the status of a GPIO pin is mirrored into a GPE.
>>>
>>> Particularly GPE 0xE is often mirroring AMD GPIO 18.  This can be changed by BIOS though, so Lenovo would have to confirm it is the case or not.
>> this does not make sense to me because in the test where ath11k kernel module is removed, the GPE 0xE is active but GPIO 18 is not. if GPE 0xE mirrors GPIO 18, should I expect GPIO 18 and GPE 0xE to be in same status? I mean both active or both inactive?
>>
> 
> Hmm, good point.  🤷 for now.
> 
>>>
>>> But it could explain why you see GPE active.
>>>
>>>
>>>>>
>>>>>> [  899.306089] ACPI: GPE event 0x0e //GPE 0x0e triggered for the 2nd time
>>>>>> [  899.333158] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
>>>>>> [  899.333190] ath11k_pci 0000:03:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>>>>>> ...
>>>>>> [  899.826378] PM: suspend exit
>>>>>>
>>>>>>
>>>>>> But I don;t think it is the wakeup source, it is just toggled during WLAN reinitialize AFTER system wakeup. actually even with ath11k module removed I can also see this GPE wakeup, but without GPIO 18 toggled:
>>>>>
>>>>> I don't believe that just removing the kernel module is enough.  Can you physically remove the hardware?
>>>> not possible, it is soldered, not a M.2 module
>>>
>>> Ah this makes it a lot harder for a debugging.  Is there option in BIOS to disable it?
>> I will check that. But to make it clear, by 'disable' you are meaning disable wakeup function of WLAN?
> 
> I'm meaning disable WLAN all together from BIOS.  It will drop off PCI bus.
> 
> I don't know if Lenovo BIOS exposes this, I've seen it on some platforms.
I manged to disable WLAN from BIOS. Now even with lspci I can not see the WLAN device and the PCI bridge to which WLAN is attached. and the GPP6 wakeup functionality is disabled:

# cat /proc/acpi/wakeup
Device  S-state   Status   Sysfs node
...
GPP6      S4    *disabled
...

Now the issue is gone and I don't see any GPE 0xe or GPIO 18 active events during suspend cycle.

> 
>>
>>>
>>>>>
>>>>>>
>>>>>> [ 2640.849342] PM: suspend entry (s2idle)
>>>>>> ...
>>>>>> [ 2650.806234] PM: Triggering wakeup from IRQ 9
>>>>>> ...
>>>>>> [ 2651.467653] PM: noirq resume of devices complete after 558.943 msecs
>>>>>> [ 2651.467880] ACPI: GPE event 0x07
>>>>>> [ 2651.467961] ACPI: GPE event 0x0e
>>>>>> ...
>>>>>> [ 2651.848848] PM: suspend exit
>>>>>>
>>>>>>
>>>>>>
>>>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219286
>>>>>>
>>>>>
>>>>> Is it possible for you to put a scope on the GPIO and/or PCIe analzyer on the bus?
>>>> it is hard to me -- for the GPIO I need the schematic which is not available, and for the PCIe analyzer we need hardware rework for that, but I will try.
>>>
>>> At least from WLAN perspective, it should be well known pin for GPIO even without board schematic, right?  So should be relatively easy to look at with a scope.
>> Ah, you remind me. We can check it with WLAN wakeup pin.
>> OK, so seems I have no option but to scope the GPIO.
> 
> Yeah; unless some other guys on this D/L have any ideas here.


