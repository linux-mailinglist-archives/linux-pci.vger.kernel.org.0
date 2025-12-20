Return-Path: <linux-pci+bounces-43468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C9374CD2F57
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 13:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40C553001638
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270D42C0F6E;
	Sat, 20 Dec 2025 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MBEdrc2I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074A2868B5;
	Sat, 20 Dec 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235399; cv=none; b=FULXE7td0pO+AvRPOkfKhx5sQVHO4l7jCXNG0lIL7owtFk7MuGxKh3l3shlL10/ODWvDOKq4WM2AmPnOpdCi7sbfMtrlcIqJX/aWaQBPo5Ahn/upmSYwZhxzYH3CVKIDCmeQND7L63/MkYqwpqYPsHD46G2QLTli4lAp6YeLu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235399; c=relaxed/simple;
	bh=DTtjE613QiiA4LOQH/o5hyII0YD4/2llytps4ywmHdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0egkM6mmWkFv0gnm/gwQVrMSdYC3ruexu8l0h+U99CPC+KOTTZhVqH7Cz5pVxO6E4OTzxofKdUXQKVCMIdp0FjEhqHyAkeVPqDKyjVg/xvEnpllBufUB6kfpPE9blwXO5iDPwkV8NhDCFInQo2EZZrwzhzK7DzFs7hlMA18zZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MBEdrc2I; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766235394; x=1766840194; i=w_armin@gmx.de;
	bh=cGALsiA8EdYSVM7tilht/zZBX0ADaj+GOMQzKPAj4uI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MBEdrc2I63UPwEYgb+FspW31FfQMXJiz1r2Iu2wwaIm5SDzCfHIHnzbNa4Dnf+ZY
	 d+vYlrdttR1N1DV6swXAcywoOAstTsyK7Ivh4R2JIW6r2GWaXV3t3bYdlyqJbucpP
	 QdVe7uBmJgQvWZnUkOSi7qEQwA4dUE64iBhxQWAw4tLLSyVoO9+yjuAJu+OJDQAF5
	 j5blVY2ymUH5grWIULK2OJky/lLyCIznxGmq1OW40VpZQnyerkQGlPZ5OEWcwcFNn
	 VG1V2k7k5/DmyMHaekk7VVjIDRx2hhOQ0+5yy3xlHVr0NhhXol8FETzx8/A6xem4p
	 md1pSp+XkVNAbaguXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1wKa5M477F-00nTmY; Sat, 20
 Dec 2025 13:56:34 +0100
Message-ID: <9681a1f6-9c1a-4299-b4f1-dc451bc418ee@gmx.de>
Date: Sat, 20 Dec 2025 13:56:32 +0100
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
 <2ec8cf4c-62b2-4448-b4d6-563f519fd947@gmx.de>
 <CAJZ5v0h5jWx4vvxTXus80290zu7OjQY_FobLFHqYF205WadDOQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0h5jWx4vvxTXus80290zu7OjQY_FobLFHqYF205WadDOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8NLE0BXYk/2GNOt0ec/OQ4ESpUIiD0Sisz92CjAKRrg0qScVOwH
 2pXmfFHi7IOuuSGvpuVz5Y+WCCZJoRuQJ2jdcyQoR7PXJb/9GEYhv2iGHaPr+ETDDMD1MPN
 kg9v8WKljdn15yMLRdQsZah5fo/L7C2iaSMN3g9x7PaCsFJtHkkKmSMsLylYyMTPbPEMzBS
 SrPOt7dvqedBH+hfs2//g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ObH6B1zsIeY=;YGjGZky1MVZEk98JaK52gShpl8u
 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
 XGJyzguOmDFfhQYiPi2I

Am 10.12.25 um 02:56 schrieb Rafael J. Wysocki:

> On Wed, Dec 10, 2025 at 1:29=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 09.12.25 um 23:18 schrieb Rafael J. Wysocki:
>>
>>> On Tue, Dec 9, 2025 at 11:00=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
>>>> Am 09.12.25 um 14:56 schrieb Armin Wolf:
>>>>
>>>>> Am 09.12.25 um 12:31 schrieb Rafael J. Wysocki:
>>>>>
>>>>>> On Mon, Dec 8, 2025 at 9:01=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> =
wrote:
>>>>>>> Am 08.12.25 um 13:09 schrieb Rafael J. Wysocki:
>>>>>>>
>>>>>>>> Hi All,
>>>>>>>>
>>>>>>>> Patch [1/2] updates the registration of PCI root bus wakeup
>>>>>>>> notification setup
>>>>>>>> in order to simplify code in pci_acpi_wake_bus() and to prepare f=
or
>>>>>>>> the other
>>>>>>>> change.  This is not expected to affect functionality.
>>>>>>>>
>>>>>>>> Patch [2/2] modifies the ACPI PM notifier registration to add
>>>>>>>> wakeup sources
>>>>>>>> under devices that are going to be affected by wakeup handling
>>>>>>>> instead of
>>>>>>>> registering them under ACPI companions of those devices (rational=
e
>>>>>>>> explained
>>>>>>>> in the patch changelog).  This will change the sysfs layout (wake=
up
>>>>>>>> source
>>>>>>>> devices associated with PCI wakeup are now going to appear under
>>>>>>>> PCI devices
>>>>>>>> and the host bridge device), but it is not expected to affect use=
r
>>>>>>>> space
>>>>>>>> adversely.
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>> I tested both patches, and the sysfs layout changes as expected:
>>>>>>>
>>>>>>> $ readlink /sys/class/wakeup/wakeup*/device
>>>>>>> ../../../device:00
>>>>>>> ../../../device:1a
>>>>>>> ../../../device:1f
>>>>>>> ../../../device:20
>>>>>>> ../../../0000:00:08.1
>>>>>>> ../../../device:36
>>>>>>> ../../../device:31
>>>>>>> ../../../device:32
>>>>>>> ../../../device:3c
>>>>>>> ../../../0000:01:00.0
>>>>>>> ../../../device:3d
>>>>>>> ../../../PNP0C02:00
>>>>>>> ../../../0000:02:00.0
>>>>>>> ../../../device:3e
>>>>>>> ../../../device:3f
>>>>>>> ../../../device:46
>>>>>>> ../../../0000:04:00.0
>>>>>>> ../../../device:47
>>>>>>> ../../../0000:05:00.0
>>>>>>> ../../../device:57
>>>>>>> ../../../0000:05:08.0
>>>>>>> ../../../device:59
>>>>>>> ../../../device:01
>>>>>>> ../../../0000:05:09.0
>>>>>>> ../../../device:5b
>>>>>>> ../../../0000:05:0a.0
>>>>>>> ../../../device:5d
>>>>>>> ../../../0000:05:0b.0
>>>>>>> ../../../device:5f
>>>>>>> ../../../0000:05:0c.0
>>>>>>> ../../../device:74
>>>>>>> ../../../0000:05:0d.0
>>>>>>> ../../../device:5a
>>>>>>> ../../../device:3a
>>>>>>> ../../../device:5c
>>>>>>> ../../../device:60
>>>>>>> ../../../device:75
>>>>>>> ../../../LNXVIDEO:00
>>>>>>> ../../../device:22
>>>>>>> ../../../PNP0C02:02
>>>>>>> ../../../device:25
>>>>>>> ../../../device:2b
>>>>>>> ../../../device:24
>>>>>>> ../../../device:37
>>>>>>> ../../../0000:00:01.1
>>>>>>> ../../../PNP0A08:00
>>>>>>> ../../../LNXPWRBN:00
>>>>>>> ../../../AMDI0010:00
>>>>>>> ../../../AMDI0030:00
>>>>>>> ../../../00:02
>>>>>>> ../../../alarmtimer.0.auto
>>>>>>> ../../../PNP0C0C:00
>>>>>>> ../../../0000:0b:00.0
>>>>>>> ../../../AMDIF031:00
>>>>>>> ../../../PNP0C14:00
>>>>>>> ../../../device:0a
>>>>>>> ../../../PNP0C14:01
>>>>>>> ../../../PNP0C14:02
>>>>>>> ../../../PNP0C14:03
>>>>>>> ../../../0000:0e:00.3
>>>>>>> ../../../0000:0e:00.4
>>>>>>> ../../../0000:0f:00.0
>>>>>>> ../../../5-2
>>>>>>> ../../../1-5.3
>>>>>>> ../../hidpp_battery_0
>>>>>>> ../../../device:44
>>>>>>> ../../../0000:00:02.1
>>>>>>> ../../../device:76
>>>>>>> ../../../device:0b
>>>>>>>
>>>>>>> turns into:
>>>>>>>
>>>>>>> $ readlink /sys/class/wakeup/wakeup*/device
>>>>>>> ../../../0000:00:00.0
>>>>>>> ../../../0000:00:04.0
>>>>>>> ../../../0000:00:08.0
>>>>>>> ../../../0000:00:08.1
>>>>>>> ../../../0000:00:08.1
>>>>>>> ../../../0000:00:08.3
>>>>>>> ../../../0000:00:14.0
>>>>>>> ../../../0000:00:14.3
>>>>>>> ../../../0000:01:00.0
>>>>>>> ../../../0000:01:00.0
>>>>>>> ../../../0000:02:00.0
>>>>>>> ../../../0000:00:00.2
>>>>>>> ../../../0000:02:00.0
>>>>>>> ../../../0000:03:00.0
>>>>>>> ../../../0000:03:00.1
>>>>>>> ../../../0000:04:00.0
>>>>>>> ../../../0000:04:00.0
>>>>>>> ../../../0000:05:00.0
>>>>>>> ../../../0000:05:00.0
>>>>>>> ../../../0000:05:08.0
>>>>>>> ../../../0000:05:08.0
>>>>>>> ../../../0000:05:09.0
>>>>>>> ../../../0000:00:01.0
>>>>>>> ../../../0000:05:09.0
>>>>>>> ../../../0000:05:0a.0
>>>>>>> ../../../0000:05:0a.0
>>>>>>> ../../../0000:05:0b.0
>>>>>>> ../../../0000:05:0b.0
>>>>>>> ../../../0000:05:0c.0
>>>>>>> ../../../0000:05:0c.0
>>>>>>> ../../../0000:05:0d.0
>>>>>>> ../../../0000:05:0d.0
>>>>>>> ../../../0000:08:00.0
>>>>>>> ../../../0000:00:01.1
>>>>>>> ../../../0000:09:00.0
>>>>>>> ../../../0000:0b:00.0
>>>>>>> ../../../0000:0c:00.0
>>>>>>> ../../../0000:0e:00.0
>>>>>>> ../../../0000:0e:00.1
>>>>>>> ../../../0000:0e:00.2
>>>>>>> ../../../0000:0e:00.3
>>>>>>> ../../../0000:0e:00.4
>>>>>>> ../../../0000:0e:00.6
>>>>>>> ../../../0000:0f:00.0
>>>>>>> ../../../0000:00:01.1
>>>>>>> ../../../pci0000:00
>>>>>>> ../../../LNXPWRBN:00
>>>>>>> ../../../AMDI0010:00
>>>>>>> ../../../AMDI0030:00
>>>>>>> ../../../00:02
>>>>>>> ../../../alarmtimer.0.auto
>>>>>>> ../../../PNP0C0C:00
>>>>>>> ../../../0000:0b:00.0
>>>>>>> ../../../AMDIF031:00
>>>>>>> ../../../PNP0C14:00
>>>>>>> ../../../0000:00:02.0
>>>>>>> ../../../PNP0C14:01
>>>>>>> ../../../PNP0C14:02
>>>>>>> ../../../PNP0C14:03
>>>>>>> ../../../0000:0e:00.3
>>>>>>> ../../../0000:0e:00.4
>>>>>>> ../../../0000:0f:00.0
>>>>>>> ../../../5-2
>>>>>>> ../../../1-5.3
>>>>>>> ../../hidpp_battery_0
>>>>>>> ../../../0000:00:02.1
>>>>>>> ../../../0000:00:02.1
>>>>>>> ../../../0000:00:02.2
>>>>>>> ../../../0000:00:03.0
>>>>>>>
>>>>>>> The remaining ACPI devices are likely caused by device drivers bas=
ed
>>>>>>> upon struct acpi_driver.
>>>>>>> I was unable to test the wakeup itself since suspend is currently
>>>>>>> broken due to issues with
>>>>>>> cpuidle,
>>>>>> Have you reported those?  What cpuidle driver is involved?
>>>>>>
>>>>>> If you happen to be using the ACPI idle driver, there is a regressi=
on
>>>>>> between 6.18-rc7 and final 6.18 due to a missing revert, but final
>>>>>> 6.18 should be as expected.
>>>>> If i remember correctly the official 6.18 kernel was not affected by
>>>>> this, i used the the bleeding-edge
>>>>> branch when building the test kernel.
>>>>>
>>>>> I will do some further debugging once i am back home.
>>>>>
>>>>> Thanks,
>>>>> Armin Wolf
>>>>>
>>>> Well, it turned out that the cpuidle driver was not involved in this,=
 i just got confused
>>>> by a separate stacktrace caused by the hid-roccat driver (i already r=
eported that).
>>>>
>>>> This seems to be the real issue:
>>>>
>>>> [  514.910759] ACPI Error: Aborting method \M402 due to previous erro=
r (AE_AML_LOOP_TIMEOUT) (20250807/psparse-529)
>>>> [  514.910810] ACPI Error: Aborting method \_SB.PCI0.GPP0.M241 due to=
 previous error (AE_AML_LOOP_TIMEOUT) (20250807/psparse-529)
>>>> [  514.910890] ACPI Error: Aborting method \_SB.PCI0.GPP0.M237._OFF d=
ue to previous error (AE_AML_LOOP_TIMEOUT) (20250807/psparse-529)
>>> It looks like there is a problem with turning a power resource off.
>>>
>>>> Sleeping itself works, it just takes a long time for the machine to a=
ctually suspend due to the timeout.
>>>> I attached the acpidump of the affected machine in case you are inter=
ested.
>>>>
>>>> Since 6.18 is not affected by this i will wait till 6.19-rc1 is relea=
sed before i start debugging this issue.
>>>> Do you think that this approach is OK?
>>> It should be fine although you may as well check my pm-6.19-rc1,
>>> acpi-6.19-rc1 and thermal-6.19-rc1 tags on top of 6.18.  If the
>>> problem is in one of them, it should be possible to find it quicker
>>> than by dealing with the entire 6.19-rc1.
>> I tested all three tags atop of 6.18, and all can suspend just fine. I =
will thus wait for 6.19-rc1
>> before doing any further debugging.
> Sounds reasonable to me.

Well, after two failed bisects caused by the fact that the resulting kerne=
l unexpectedly changed his name,
i will try again later. Sorry for taking so long, but i am quite inexperie=
nced when it comes to performing
such a large bisect.

Thanks,
Armin Wolf


