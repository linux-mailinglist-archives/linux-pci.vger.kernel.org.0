Return-Path: <linux-pci+bounces-13478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF79851BA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41431F23B10
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 04:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A719D14B087;
	Wed, 25 Sep 2024 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GHd0LQyF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12630139E;
	Wed, 25 Sep 2024 04:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727236987; cv=none; b=oLs3BY+1Hy4rx+AxfSHsvopWEN02xYikr6N7zjUmrK3tZ0VqzP3rBBsahtnMzHt3fKzoo7rtIw1+XKxVfGSivSXDky5Z5YnSelqmVsarz7CfYSHYVyviePkDLAFhvcHfM9EEZV7Zf9DYcMqFD2Hz0CuUPvXWmq7NXNkhwmvfNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727236987; c=relaxed/simple;
	bh=nnMJ8ZsVCMfTBY1eyD2Aj+vaNa+xXrAG+zjbQEsS3KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JnpeA9yafN1/AsQ+C6h5vJSM4IU0JMpmtjX7VF8Ta2B0/3d/TIsjrYcDEAzr8NgxyCJ3t6vFUmoOCT8TpVz0dcNbC7nq59dea5pvhg9QTdVFZixa7s0lGSkCXlWUrHnewH7EwkmVFpcd2pQODpg3JZTBUhROU6njf2WJ/Ktu0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GHd0LQyF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OI1RQp010270;
	Wed, 25 Sep 2024 04:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	slT8Sd9LJZ2z5SOve/68VvpoSI30eIm8vsmxGXJZdLA=; b=GHd0LQyFUhqGxk8i
	M+3hFv9nir1jIGv08YniJijUurWIZqVWnyPDUbzUv45EwKsoCincNafFEE7V92zr
	N3VVnU9gP6YRyyhZWuJQFZUdWFfG4qyrghgzFduqdGeexbO6WAHwxTXrCveOmU/r
	uwdL1jqQFTsUuk0I6n1Yl2/vHmGsUWX7eEl6r5YUKccFpT8gVvO82p2UsPhELoqo
	ggwS0Z2n36ZnxFtN24up/XlRB4sApZVQ+HgdQ5KVmlnx96sYjH1yESCaceoIP4HX
	5s8FeJPbNKBATfKnH+n8bMOyR4Hfo/2U5iCOA5xjhxSkI+jys+BMRcVJ+ZFCpycD
	nzbKSQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sp7ujxkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 04:02:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P42mw3030419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 04:02:48 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 21:02:45 -0700
Message-ID: <f3e31284-09d0-4a30-be74-34d33efe8535@quicinc.com>
Date: Wed, 25 Sep 2024 12:02:43 +0800
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
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <5012908a-9ece-4c16-9d01-2633df740fbb@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MSkfOwIvr3oxqKlKPxVY_RGDRw7xCvau
X-Proofpoint-ORIG-GUID: MSkfOwIvr3oxqKlKPxVY_RGDRw7xCvau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409250028



On 9/25/2024 11:46 AM, Mario Limonciello wrote:
> On 9/24/2024 21:18, Baochen Qiang wrote:
>>>
>>> Yeah that's what it looks like to me too.  The easiest way to confirm this (without a schematic that is) is to look at the _AEI / _EVT in the SSDT and see what is notified when this is active.
>> seems GPP6 is notified, does this mean GPIO18 is NOT bound to WLAN wakeup pin? but instead it is bound to the PCIe root port?
> 
> There is a concept in AMD machines called "GPIO mirroring" where the status of a GPIO pin is mirrored into a GPE.
> 
> Particularly GPE 0xE is often mirroring AMD GPIO 18.  This can be changed by BIOS though, so Lenovo would have to confirm it is the case or not.
this does not make sense to me because in the test where ath11k kernel module is removed, the GPE 0xE is active but GPIO 18 is not. if GPE 0xE mirrors GPIO 18, should I expect GPIO 18 and GPE 0xE to be in same status? I mean both active or both inactive?

> 
> But it could explain why you see GPE active.
> 
> 
>>>
>>>> [  899.306089] ACPI: GPE event 0x0e //GPE 0x0e triggered for the 2nd time
>>>> [  899.333158] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
>>>> [  899.333190] ath11k_pci 0000:03:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>>>> ...
>>>> [  899.826378] PM: suspend exit
>>>>
>>>>
>>>> But I don;t think it is the wakeup source, it is just toggled during WLAN reinitialize AFTER system wakeup. actually even with ath11k module removed I can also see this GPE wakeup, but without GPIO 18 toggled:
>>>
>>> I don't believe that just removing the kernel module is enough.  Can you physically remove the hardware?
>> not possible, it is soldered, not a M.2 module
> 
> Ah this makes it a lot harder for a debugging.  Is there option in BIOS to disable it?
I will check that. But to make it clear, by 'disable' you are meaning disable wakeup function of WLAN?

> 
>>>
>>>>
>>>> [ 2640.849342] PM: suspend entry (s2idle)
>>>> ...
>>>> [ 2650.806234] PM: Triggering wakeup from IRQ 9
>>>> ...
>>>> [ 2651.467653] PM: noirq resume of devices complete after 558.943 msecs
>>>> [ 2651.467880] ACPI: GPE event 0x07
>>>> [ 2651.467961] ACPI: GPE event 0x0e
>>>> ...
>>>> [ 2651.848848] PM: suspend exit
>>>>
>>>>
>>>>
>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219286
>>>>
>>>
>>> Is it possible for you to put a scope on the GPIO and/or PCIe analzyer on the bus?
>> it is hard to me -- for the GPIO I need the schematic which is not available, and for the PCIe analyzer we need hardware rework for that, but I will try.
> 
> At least from WLAN perspective, it should be well known pin for GPIO even without board schematic, right?  So should be relatively easy to look at with a scope.
Ah, you remind me. We can check it with WLAN wakeup pin.

> 
>>
>>>
>>> It sounds to me that most likely what's going on is PME being asserted from WLAN controller.
>> But I don;t see a PME interrupt fired on the root port:
> 
> Hmm.  I think then understanding what is happening to that GPIO over this suspend cycle when and how that maps to your expectations from the driver and firmware will be key.
OK, so seems I have no option but to scope the GPIO.

> 
> 


