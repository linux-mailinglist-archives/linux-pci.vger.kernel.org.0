Return-Path: <linux-pci+bounces-42872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C687CB17EA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 01:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFEC730E8E90
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4491A9B24;
	Wed, 10 Dec 2025 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hWbDpYKH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9A188A3A;
	Wed, 10 Dec 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765326561; cv=none; b=EwZW2KHja0NSWpScoPWLxdDE6U674lv0g8Xf+LJFRR0pB35tCY7TTmcbgdF0zxnniCyPmqT1/aXzTfg3DNGjF8Z26AZnpp/fPOA8QTsHNa/U5MPceYqngzBuL6RAzyBwG0aC0bFcuuxP2WVpgRz8RTXHzwgj6PYai4uO0k0Br8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765326561; c=relaxed/simple;
	bh=tsscXXHMpRxVmCME2TLeabzArAwobz6KibXT1gzw5JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6S9OXE9vgEpYfJpstOVhLDrVKuy+BN+sMPrM/JlVaEODaEbnzlaIawtu+qUZK+lsPlIybHJ2Z5nkXFLIqS8FJJLOCX3otiehxu+7d+yrjo4nIDT6vwZz+BGTN5204oGgPc3QsQW4GGvBrSNURzKptzIjAJ1aaCBXCaBGzWRk1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hWbDpYKH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765326551; x=1765931351; i=w_armin@gmx.de;
	bh=nkgBLCA7rBuUoVO+OWr/GL+YtlenSvkZCt4RYFOw8hs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hWbDpYKHhhO2Ov6LOdH2V+yTkeUA56Gap2AtvJDHF5yFcFZ7i2vVFWvXmmnLz2QL
	 P2zm6q7Dhp2mi1hDPK0I+9ko2ScUl1PcUaHhVmDIjAbP+XzwkFe3cJy0Be/buu7pn
	 Mf0vKzbP2uUh6IJaObjaV1bouOUdY01GNZkc1Q34shXAsskmP1B/l9XraL1GZ9uis
	 zxSaOOZeC+3VXoNdox+s8QtbjkkDBHxvEybPviSba5xgFkR7B53N1pCNaZir5PxLI
	 CYD5zX/v90kwK/G802etYlbwiCvY/12WS4i5JK8I0CXVDrntaL/OOKV50psDOzRRc
	 5TiOk9G1fK0noC2OkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1vPXIz3C43-00H3A7; Wed, 10
 Dec 2025 01:29:10 +0100
Message-ID: <2ec8cf4c-62b2-4448-b4d6-563f519fd947@gmx.de>
Date: Wed, 10 Dec 2025 01:29:09 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] PCI: ACPI: PM: Rework root bus wakeup notification
 setup and wakeup source registration
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
References: <2395536.ElGaqSPkdT@rafael.j.wysocki>
 <ab8b770c-08e9-4cf6-bd4f-f36c951fda4c@gmx.de>
 <CAJZ5v0jAH9FZrO5AvVF90zgy-0EeM+rsB6Zf8cMf+sR8=FFuDA@mail.gmail.com>
 <168f173d-0d1a-49b0-9461-72f8fb0fc701@gmx.de>
 <99b0d755-3e18-4bba-b8e7-ab344e6c2592@gmx.de>
 <CAJZ5v0ijOF+nRZrjnub9uqa_Pu54etmudWUUNWmNgiogVAwxFQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0ijOF+nRZrjnub9uqa_Pu54etmudWUUNWmNgiogVAwxFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5hjMrZt7eroIRah5pWkqrnI82O4ElypLcjJf6sSDk6uvQ9wqKIY
 FNW53UC3lJ+LG1BmQoBAx7oO1x7PDIlgahuVT7vTetPg33NSX3KFTXgfD/3j4QoJ5o2AcV3
 lhSu5kN8UlpFIUenMOfhSur9iE2iTZIaVshmNdheccrfF+J2r8mZlmTm/Esa9vyeZKySF0A
 KgAGfzzMZb4v66rgEIt1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+RsnLzTQW9I=;w1mL8O4Y/KtsilmNK0XbzEC9K73
 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

Am 09.12.25 um 23:18 schrieb Rafael J. Wysocki:

> On Tue, Dec 9, 2025 at 11:00=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 09.12.25 um 14:56 schrieb Armin Wolf:
>>
>>> Am 09.12.25 um 12:31 schrieb Rafael J. Wysocki:
>>>
>>>> On Mon, Dec 8, 2025 at 9:01=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
>>>>> Am 08.12.25 um 13:09 schrieb Rafael J. Wysocki:
>>>>>
>>>>>> Hi All,
>>>>>>
>>>>>> Patch [1/2] updates the registration of PCI root bus wakeup
>>>>>> notification setup
>>>>>> in order to simplify code in pci_acpi_wake_bus() and to prepare for
>>>>>> the other
>>>>>> change.  This is not expected to affect functionality.
>>>>>>
>>>>>> Patch [2/2] modifies the ACPI PM notifier registration to add
>>>>>> wakeup sources
>>>>>> under devices that are going to be affected by wakeup handling
>>>>>> instead of
>>>>>> registering them under ACPI companions of those devices (rationale
>>>>>> explained
>>>>>> in the patch changelog).  This will change the sysfs layout (wakeup
>>>>>> source
>>>>>> devices associated with PCI wakeup are now going to appear under
>>>>>> PCI devices
>>>>>> and the host bridge device), but it is not expected to affect user
>>>>>> space
>>>>>> adversely.
>>>>>>
>>>>>> Thanks!
>>>>> I tested both patches, and the sysfs layout changes as expected:
>>>>>
>>>>> $ readlink /sys/class/wakeup/wakeup*/device
>>>>> ../../../device:00
>>>>> ../../../device:1a
>>>>> ../../../device:1f
>>>>> ../../../device:20
>>>>> ../../../0000:00:08.1
>>>>> ../../../device:36
>>>>> ../../../device:31
>>>>> ../../../device:32
>>>>> ../../../device:3c
>>>>> ../../../0000:01:00.0
>>>>> ../../../device:3d
>>>>> ../../../PNP0C02:00
>>>>> ../../../0000:02:00.0
>>>>> ../../../device:3e
>>>>> ../../../device:3f
>>>>> ../../../device:46
>>>>> ../../../0000:04:00.0
>>>>> ../../../device:47
>>>>> ../../../0000:05:00.0
>>>>> ../../../device:57
>>>>> ../../../0000:05:08.0
>>>>> ../../../device:59
>>>>> ../../../device:01
>>>>> ../../../0000:05:09.0
>>>>> ../../../device:5b
>>>>> ../../../0000:05:0a.0
>>>>> ../../../device:5d
>>>>> ../../../0000:05:0b.0
>>>>> ../../../device:5f
>>>>> ../../../0000:05:0c.0
>>>>> ../../../device:74
>>>>> ../../../0000:05:0d.0
>>>>> ../../../device:5a
>>>>> ../../../device:3a
>>>>> ../../../device:5c
>>>>> ../../../device:60
>>>>> ../../../device:75
>>>>> ../../../LNXVIDEO:00
>>>>> ../../../device:22
>>>>> ../../../PNP0C02:02
>>>>> ../../../device:25
>>>>> ../../../device:2b
>>>>> ../../../device:24
>>>>> ../../../device:37
>>>>> ../../../0000:00:01.1
>>>>> ../../../PNP0A08:00
>>>>> ../../../LNXPWRBN:00
>>>>> ../../../AMDI0010:00
>>>>> ../../../AMDI0030:00
>>>>> ../../../00:02
>>>>> ../../../alarmtimer.0.auto
>>>>> ../../../PNP0C0C:00
>>>>> ../../../0000:0b:00.0
>>>>> ../../../AMDIF031:00
>>>>> ../../../PNP0C14:00
>>>>> ../../../device:0a
>>>>> ../../../PNP0C14:01
>>>>> ../../../PNP0C14:02
>>>>> ../../../PNP0C14:03
>>>>> ../../../0000:0e:00.3
>>>>> ../../../0000:0e:00.4
>>>>> ../../../0000:0f:00.0
>>>>> ../../../5-2
>>>>> ../../../1-5.3
>>>>> ../../hidpp_battery_0
>>>>> ../../../device:44
>>>>> ../../../0000:00:02.1
>>>>> ../../../device:76
>>>>> ../../../device:0b
>>>>>
>>>>> turns into:
>>>>>
>>>>> $ readlink /sys/class/wakeup/wakeup*/device
>>>>> ../../../0000:00:00.0
>>>>> ../../../0000:00:04.0
>>>>> ../../../0000:00:08.0
>>>>> ../../../0000:00:08.1
>>>>> ../../../0000:00:08.1
>>>>> ../../../0000:00:08.3
>>>>> ../../../0000:00:14.0
>>>>> ../../../0000:00:14.3
>>>>> ../../../0000:01:00.0
>>>>> ../../../0000:01:00.0
>>>>> ../../../0000:02:00.0
>>>>> ../../../0000:00:00.2
>>>>> ../../../0000:02:00.0
>>>>> ../../../0000:03:00.0
>>>>> ../../../0000:03:00.1
>>>>> ../../../0000:04:00.0
>>>>> ../../../0000:04:00.0
>>>>> ../../../0000:05:00.0
>>>>> ../../../0000:05:00.0
>>>>> ../../../0000:05:08.0
>>>>> ../../../0000:05:08.0
>>>>> ../../../0000:05:09.0
>>>>> ../../../0000:00:01.0
>>>>> ../../../0000:05:09.0
>>>>> ../../../0000:05:0a.0
>>>>> ../../../0000:05:0a.0
>>>>> ../../../0000:05:0b.0
>>>>> ../../../0000:05:0b.0
>>>>> ../../../0000:05:0c.0
>>>>> ../../../0000:05:0c.0
>>>>> ../../../0000:05:0d.0
>>>>> ../../../0000:05:0d.0
>>>>> ../../../0000:08:00.0
>>>>> ../../../0000:00:01.1
>>>>> ../../../0000:09:00.0
>>>>> ../../../0000:0b:00.0
>>>>> ../../../0000:0c:00.0
>>>>> ../../../0000:0e:00.0
>>>>> ../../../0000:0e:00.1
>>>>> ../../../0000:0e:00.2
>>>>> ../../../0000:0e:00.3
>>>>> ../../../0000:0e:00.4
>>>>> ../../../0000:0e:00.6
>>>>> ../../../0000:0f:00.0
>>>>> ../../../0000:00:01.1
>>>>> ../../../pci0000:00
>>>>> ../../../LNXPWRBN:00
>>>>> ../../../AMDI0010:00
>>>>> ../../../AMDI0030:00
>>>>> ../../../00:02
>>>>> ../../../alarmtimer.0.auto
>>>>> ../../../PNP0C0C:00
>>>>> ../../../0000:0b:00.0
>>>>> ../../../AMDIF031:00
>>>>> ../../../PNP0C14:00
>>>>> ../../../0000:00:02.0
>>>>> ../../../PNP0C14:01
>>>>> ../../../PNP0C14:02
>>>>> ../../../PNP0C14:03
>>>>> ../../../0000:0e:00.3
>>>>> ../../../0000:0e:00.4
>>>>> ../../../0000:0f:00.0
>>>>> ../../../5-2
>>>>> ../../../1-5.3
>>>>> ../../hidpp_battery_0
>>>>> ../../../0000:00:02.1
>>>>> ../../../0000:00:02.1
>>>>> ../../../0000:00:02.2
>>>>> ../../../0000:00:03.0
>>>>>
>>>>> The remaining ACPI devices are likely caused by device drivers based
>>>>> upon struct acpi_driver.
>>>>> I was unable to test the wakeup itself since suspend is currently
>>>>> broken due to issues with
>>>>> cpuidle,
>>>> Have you reported those?  What cpuidle driver is involved?
>>>>
>>>> If you happen to be using the ACPI idle driver, there is a regression
>>>> between 6.18-rc7 and final 6.18 due to a missing revert, but final
>>>> 6.18 should be as expected.
>>> If i remember correctly the official 6.18 kernel was not affected by
>>> this, i used the the bleeding-edge
>>> branch when building the test kernel.
>>>
>>> I will do some further debugging once i am back home.
>>>
>>> Thanks,
>>> Armin Wolf
>>>
>> Well, it turned out that the cpuidle driver was not involved in this, i=
 just got confused
>> by a separate stacktrace caused by the hid-roccat driver (i already rep=
orted that).
>>
>> This seems to be the real issue:
>>
>> [  514.910759] ACPI Error: Aborting method \M402 due to previous error =
(AE_AML_LOOP_TIMEOUT) (20250807/psparse-529)
>> [  514.910810] ACPI Error: Aborting method \_SB.PCI0.GPP0.M241 due to p=
revious error (AE_AML_LOOP_TIMEOUT) (20250807/psparse-529)
>> [  514.910890] ACPI Error: Aborting method \_SB.PCI0.GPP0.M237._OFF due=
 to previous error (AE_AML_LOOP_TIMEOUT) (20250807/psparse-529)
> It looks like there is a problem with turning a power resource off.
>
>> Sleeping itself works, it just takes a long time for the machine to act=
ually suspend due to the timeout.
>> I attached the acpidump of the affected machine in case you are interes=
ted.
>>
>> Since 6.18 is not affected by this i will wait till 6.19-rc1 is release=
d before i start debugging this issue.
>> Do you think that this approach is OK?
> It should be fine although you may as well check my pm-6.19-rc1,
> acpi-6.19-rc1 and thermal-6.19-rc1 tags on top of 6.18.  If the
> problem is in one of them, it should be possible to find it quicker
> than by dealing with the entire 6.19-rc1.

I tested all three tags atop of 6.18, and all can suspend just fine. I wil=
l thus wait for 6.19-rc1
before doing any further debugging.

Thanks,
Armin Wolf


