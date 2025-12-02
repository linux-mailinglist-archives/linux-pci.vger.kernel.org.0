Return-Path: <linux-pci+bounces-42516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA0C9C8E6
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 19:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51EC3A42A9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD22C21C6;
	Tue,  2 Dec 2025 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tgvr7URa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A733E29BDBF;
	Tue,  2 Dec 2025 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699149; cv=none; b=KziG+fl0v50MzbtfCQDLYLs9WqMxkQrJI0f3cxuKilTkovqIfzPY1SNb8PSz9jd8hSgUaDR3/s+BZCVUbP+Cmz4vQXnUuCylBh4t6fzw9+vU0p6PKoohUFweNa9z5uh903bNr/bSoopuEQSZcodIbokcHISzgbiLBHkBm+OXxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699149; c=relaxed/simple;
	bh=1HuM9qJaws2GmyGZwkys+MVrv3q15fGptUGeF+uLitE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXyEQWZFWDeKBFWzd9/IuHv4z7irhAdtJ3B6LC1NLFd8xbphPKhI4jSnFu8clwDpaypPilKMaJLVMw74rHN8x9QFQP8ce98Bl5RMcFb5mA671yk1p6acIfa1Nn3OK6obQ1zGRcbzbKqnpwwlxMoKes1FUobslys9n61YrhTB+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tgvr7URa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2AjkGq005729;
	Tue, 2 Dec 2025 18:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eGFHFT
	DyR7GXYxRu0mfTEjBnEovYErAKSscDA0pOW5U=; b=tgvr7URakwth3fE2VEz8JB
	Y2evq1VvKMsnZ29+pMn8Xgc1RAKKnJ/T8DQxJTse8V4cF2b9WQjOnCWa3eMhUGcg
	fsvGlfJiJLbmk7nm13DafZGa7dxI6gORUIDbMxqId+iUCbDiPXeDzaT1XQOdAovk
	m3470xGVLydMphXRGy0KvM54WcEeanAUHOWoZft+BXWRrKt4AAMi4f613yY27kNG
	FfpHre+di7BIjDskb4XSv0hsH+FKZVTCLqc5xLA9CbsaholpICFDr6rGHDU3U943
	NZSZaBozQ9sWo/elrhovAyZ6ak1MyRKQ0XvyYyWaUtqi0Wxq6L3hobcNp1xyW5Tw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg6rkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 18:12:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2I8Yx2003891;
	Tue, 2 Dec 2025 18:12:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcjnq3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 18:12:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2IC3iG17957464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 18:12:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B2E158057;
	Tue,  2 Dec 2025 18:12:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ABB258065;
	Tue,  2 Dec 2025 18:12:17 +0000 (GMT)
Received: from [9.61.252.247] (unknown [9.61.252.247])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 18:12:17 +0000 (GMT)
Message-ID: <8ac8ac53-1b53-4cb0-9d85-d8b6896a610a@linux.ibm.com>
Date: Tue, 2 Dec 2025 10:12:15 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] PCI: Avoid saving config space state if
 inaccessible
To: Niklas Schnelle <schnelle@linux.ibm.com>, helgaas@kernel.org,
        lukas@wunner.de, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
        mjrosato@linux.ibm.com
References: <20251201220823.3350-1-alifm@linux.ibm.com>
 <20251201220823.3350-4-alifm@linux.ibm.com>
 <2940d7cd662aed9d8b60f7c8fec9ced44f059166.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <2940d7cd662aed9d8b60f7c8fec9ced44f059166.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NpmhpJ2U7QOvUOCYzjr2tl8HVAaGNPB-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfXwadt2qIEpr8e
 s1iVkdVOGu1US3tPTokU0Sj6htZGOHAN1oDRveiXe7SV7KQ523iHCGIjPH6EGQFYrtXlyKbGpZE
 GyZ0oGJNv7KhSp0RQZrcL/WKIF4MYR9xYpIJVEFvpGobEMJWfByPnky2i7Qb4s1vgWLoblYEFxc
 EiKjITgSBaNK7SQYp97pm2FPcx7w+7i4hpwnxsUqRMp6KfLyRQjeFhSb696ZtBwVGkO9MkFYe+A
 RQ31oYldeF0ZaNTvoTjLdM/43yCLrAY8dV3+XL9PkOIHwvsGQVE8ASuX59OtY+BW5dUkrwmQN7N
 ohtx9uQiXJxdgc6/bAbo/heIY9TZV3bZr4ElKYMmSM3WyO/vch4GpZnJ2dkNTXEXfMs2HPvftqM
 90D1nTQp8xeTr8Gfno/QTN7CEWQ1Og==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692f2c04 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pKAynnjCjeUSSpGqxDMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NpmhpJ2U7QOvUOCYzjr2tl8HVAaGNPB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016


On 12/2/2025 4:20 AM, Niklas Schnelle wrote:
> On Mon, 2025-12-01 at 14:08 -0800, Farhan Ali wrote:
>> The current reset process saves the device's config space state before
>> reset and restores it afterward. However, errors may occur unexpectedly,
>> and the device may become inaccessible or the config space itself may
>> be corrupted. This results in saving corrupted values that get
>> written back to the device during state restoration.
>>
>> With a reset we want to recover/restore the device into a functional
>> state. So avoid saving the state of the config space when the
>> device config space is inaccessible/corrupted.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> I think the commit message needs more focus. Specifically I think the
> main point is the case that Lukas mentioned in the following quote from
> the cover letter of his "PCI: Universal error recoverability of
> devices" series:
>
> "However errors may occur unexpectedly and it may then be impossible
> to save Config Space because the device may be inaccessible (e.g. DPC)
> or Config Space may be corrupted. So it must be saved ahead of time."

I agree, I can add this bit verbatim to the commit message.


>
> That case will inevitably happen when state save / reset happens while
> a PCI device is in the error state on a platform like s390, POWER, or
> with DPC where Config Space will be inaccessible.
>
> Moreover, I'd like to stress that this is an issue independent from the
> rest of your series. As we've seen in your experiments this can be
> triggered today when a vfio-pci user process blocks recovery, e.g. by
> not handling the eventfd, and then the user tries to mitigate the
> situation by performing a reset through sysfs, which then saves the
> 0xff bytes from inaccessible config space which may subsequently kill
> the device on restore.
>
>> ---
>>   drivers/pci/pci.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 608d64900fee..28c6b9e7f526 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5105,6 +5105,7 @@ EXPORT_SYMBOL_GPL(pci_dev_unlock);
>>   
>>   static void pci_dev_save_and_disable(struct pci_dev *dev)
>>   {
>> +	u32 val;
>>   	const struct pci_error_handlers *err_handler =
>>   			dev->driver ? dev->driver->err_handler : NULL;
>>   
>> @@ -5125,6 +5126,12 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>>   	 */
>>   	pci_set_power_state(dev, PCI_D0);
>>   
>> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
>> +	if (PCI_POSSIBLE_ERROR(val)) {
>> +		pci_warn(dev, "Device config space inaccessible\n");
>> +		return;
>> +	}
>> +
> Can you explain your reasoning for not using pci_channel_offline()
> here? This was suggested by Lukas in a previous iteration (link below)
> and I would tend to prefer that as well.
>
> https://lore.kernel.org/all/aOZoWDQV0TNh-NiM@wunner.de/

AFAICT the error_state flag (checked in pci_channel_offline()) is set by 
error recovery code, when we get an error. I think using 
pci_channel_offline() creates a small window where the device may have 
already gone into an error state and thus the config space is 
inaccessible, but the error recovery code might not have set the flag. 
This can happen for example if we try to reset a device (with an ioctl 
like VFIO_DEVICE_PCI_HOT_RESET), and an error happens while we are in 
this function, in the middle of handling the reset.

I think reading directly from the config space, might be better 
indicator of device's state?

Thanks

Farhan

>
>>   	pci_save_state(dev);
>>   	/*
>>   	 * Disable the device by clearing the Command register, except for

