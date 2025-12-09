Return-Path: <linux-pci+bounces-42844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD17CB01E2
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 14:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ECE43017D9B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD9288C34;
	Tue,  9 Dec 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hJjr6clO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AD13774D;
	Tue,  9 Dec 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288605; cv=none; b=RGhL9xg3AbYyXm2rfAvhppebPVpkOs0ybr4cOjGq3B48B+2FeU3J6OHsqc8atxaA5vIku3qCPhHzrxGgQiyzHelTHtRr+qpf2ooXTuBpRbK9SiK9yOMTLYOIHdHs9UletUGMrQOX1dhLxlIypDssth+MLG1vxBN9+ncLnw+mV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288605; c=relaxed/simple;
	bh=ttKrI/ud2DlVrCezuXKRM0BCeucPO/3RAV3aLAtzE5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzAXAixVgR4eiN7k10IQiS5QJxtOSPbsa1r+WaFlKLNWL1aNST2EY/BHPqP52hv7/3KFeJqtIXpdyp6sras5aNgMoxGn56rMp7Vs7Ikp+TroeEF/qCphfGncqShC867k7MyAEyiVPc0aREC1A80nbPl2rnFOzBbFldoLwT4MFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hJjr6clO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765288597; x=1765893397; i=w_armin@gmx.de;
	bh=EVNMjV3jmVlMTTv94C7Yeg6hKSaSksBzJaCuvJDk5gM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hJjr6clOri5akSM9Lt55wIJMjLX8ujTHuN9pW+TBiV9vUBLMRWp5r8tgfYeSTWyt
	 8vHsy0iz0Qsbld9cxciAY+/eW6ExOvP/rF7aStAEYSF3ra0mq2cYUh3KNn75Zj0NA
	 cb5zcSsf4sv4yB6XiBimWBc8k0j2pNg1zuXdz+5RfSzIUCm1fqF1eadS41apl40Ck
	 bUuMSVlr9HyCqBoZ5uu/wGhej8vJVqVgY80629bF5aN+sjst1D/wvt6crUAIgU2Ni
	 EmsqGShfoN+taesji2Zjn0Q8REYf0+8cAbD6E2huwRW4VLmyDA4X+nCM/yD9j1inG
	 HrLHwwY5E0XewuiIgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.52.96] ([141.76.8.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wGi-1vRrk83zLQ-00CJTg; Tue, 09
 Dec 2025 14:56:37 +0100
Message-ID: <168f173d-0d1a-49b0-9461-72f8fb0fc701@gmx.de>
Date: Tue, 9 Dec 2025 14:56:36 +0100
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
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0jAH9FZrO5AvVF90zgy-0EeM+rsB6Zf8cMf+sR8=FFuDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:phyMCced2GrpYLVojW/Eb8QQ3+xpJK59xcncOgapqorYVJBO5yu
 AJCaTrvFFcPV3P2SO6+y0dphaNhd2Qh6K5vPCiYo504uByFapFZ3q/z9QImxlD+5Fcoj00j
 wd8lajTrRqDoE0chNoSYhNuUNSsw+LWIUjjW9KlNSbWJa2+CB0jyDc+YzyNbUeY0NZX6ifO
 lYvOUY/9sbvnfKGYKAdXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fYV2KyC7SL0=;3NiTnvevZZ79mSGttjIZTzoLoTb
 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

Am 09.12.25 um 12:31 schrieb Rafael J. Wysocki:

> On Mon, Dec 8, 2025 at 9:01=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote=
:
>> Am 08.12.25 um 13:09 schrieb Rafael J. Wysocki:
>>
>>> Hi All,
>>>
>>> Patch [1/2] updates the registration of PCI root bus wakeup notificati=
on setup
>>> in order to simplify code in pci_acpi_wake_bus() and to prepare for th=
e other
>>> change.  This is not expected to affect functionality.
>>>
>>> Patch [2/2] modifies the ACPI PM notifier registration to add wakeup s=
ources
>>> under devices that are going to be affected by wakeup handling instead=
 of
>>> registering them under ACPI companions of those devices (rationale exp=
lained
>>> in the patch changelog).  This will change the sysfs layout (wakeup so=
urce
>>> devices associated with PCI wakeup are now going to appear under PCI d=
evices
>>> and the host bridge device), but it is not expected to affect user spa=
ce
>>> adversely.
>>>
>>> Thanks!
>> I tested both patches, and the sysfs layout changes as expected:
>>
>> $ readlink /sys/class/wakeup/wakeup*/device
>> ../../../device:00
>> ../../../device:1a
>> ../../../device:1f
>> ../../../device:20
>> ../../../0000:00:08.1
>> ../../../device:36
>> ../../../device:31
>> ../../../device:32
>> ../../../device:3c
>> ../../../0000:01:00.0
>> ../../../device:3d
>> ../../../PNP0C02:00
>> ../../../0000:02:00.0
>> ../../../device:3e
>> ../../../device:3f
>> ../../../device:46
>> ../../../0000:04:00.0
>> ../../../device:47
>> ../../../0000:05:00.0
>> ../../../device:57
>> ../../../0000:05:08.0
>> ../../../device:59
>> ../../../device:01
>> ../../../0000:05:09.0
>> ../../../device:5b
>> ../../../0000:05:0a.0
>> ../../../device:5d
>> ../../../0000:05:0b.0
>> ../../../device:5f
>> ../../../0000:05:0c.0
>> ../../../device:74
>> ../../../0000:05:0d.0
>> ../../../device:5a
>> ../../../device:3a
>> ../../../device:5c
>> ../../../device:60
>> ../../../device:75
>> ../../../LNXVIDEO:00
>> ../../../device:22
>> ../../../PNP0C02:02
>> ../../../device:25
>> ../../../device:2b
>> ../../../device:24
>> ../../../device:37
>> ../../../0000:00:01.1
>> ../../../PNP0A08:00
>> ../../../LNXPWRBN:00
>> ../../../AMDI0010:00
>> ../../../AMDI0030:00
>> ../../../00:02
>> ../../../alarmtimer.0.auto
>> ../../../PNP0C0C:00
>> ../../../0000:0b:00.0
>> ../../../AMDIF031:00
>> ../../../PNP0C14:00
>> ../../../device:0a
>> ../../../PNP0C14:01
>> ../../../PNP0C14:02
>> ../../../PNP0C14:03
>> ../../../0000:0e:00.3
>> ../../../0000:0e:00.4
>> ../../../0000:0f:00.0
>> ../../../5-2
>> ../../../1-5.3
>> ../../hidpp_battery_0
>> ../../../device:44
>> ../../../0000:00:02.1
>> ../../../device:76
>> ../../../device:0b
>>
>> turns into:
>>
>> $ readlink /sys/class/wakeup/wakeup*/device
>> ../../../0000:00:00.0
>> ../../../0000:00:04.0
>> ../../../0000:00:08.0
>> ../../../0000:00:08.1
>> ../../../0000:00:08.1
>> ../../../0000:00:08.3
>> ../../../0000:00:14.0
>> ../../../0000:00:14.3
>> ../../../0000:01:00.0
>> ../../../0000:01:00.0
>> ../../../0000:02:00.0
>> ../../../0000:00:00.2
>> ../../../0000:02:00.0
>> ../../../0000:03:00.0
>> ../../../0000:03:00.1
>> ../../../0000:04:00.0
>> ../../../0000:04:00.0
>> ../../../0000:05:00.0
>> ../../../0000:05:00.0
>> ../../../0000:05:08.0
>> ../../../0000:05:08.0
>> ../../../0000:05:09.0
>> ../../../0000:00:01.0
>> ../../../0000:05:09.0
>> ../../../0000:05:0a.0
>> ../../../0000:05:0a.0
>> ../../../0000:05:0b.0
>> ../../../0000:05:0b.0
>> ../../../0000:05:0c.0
>> ../../../0000:05:0c.0
>> ../../../0000:05:0d.0
>> ../../../0000:05:0d.0
>> ../../../0000:08:00.0
>> ../../../0000:00:01.1
>> ../../../0000:09:00.0
>> ../../../0000:0b:00.0
>> ../../../0000:0c:00.0
>> ../../../0000:0e:00.0
>> ../../../0000:0e:00.1
>> ../../../0000:0e:00.2
>> ../../../0000:0e:00.3
>> ../../../0000:0e:00.4
>> ../../../0000:0e:00.6
>> ../../../0000:0f:00.0
>> ../../../0000:00:01.1
>> ../../../pci0000:00
>> ../../../LNXPWRBN:00
>> ../../../AMDI0010:00
>> ../../../AMDI0030:00
>> ../../../00:02
>> ../../../alarmtimer.0.auto
>> ../../../PNP0C0C:00
>> ../../../0000:0b:00.0
>> ../../../AMDIF031:00
>> ../../../PNP0C14:00
>> ../../../0000:00:02.0
>> ../../../PNP0C14:01
>> ../../../PNP0C14:02
>> ../../../PNP0C14:03
>> ../../../0000:0e:00.3
>> ../../../0000:0e:00.4
>> ../../../0000:0f:00.0
>> ../../../5-2
>> ../../../1-5.3
>> ../../hidpp_battery_0
>> ../../../0000:00:02.1
>> ../../../0000:00:02.1
>> ../../../0000:00:02.2
>> ../../../0000:00:03.0
>>
>> The remaining ACPI devices are likely caused by device drivers based up=
on struct acpi_driver.
>> I was unable to test the wakeup itself since suspend is currently broke=
n due to issues with
>> cpuidle,
> Have you reported those?  What cpuidle driver is involved?
>
> If you happen to be using the ACPI idle driver, there is a regression
> between 6.18-rc7 and final 6.18 due to a missing revert, but final
> 6.18 should be as expected.

If i remember correctly the official 6.18 kernel was not affected by this,=
 i used the the bleeding-edge
branch when building the test kernel.

I will do some further debugging once i am back home.

Thanks,
Armin Wolf

>> but i suspect that this has nothing to do with the patch series.
> Right, cpuidle is entirely orthogonal to this.
>
>> So for the whole series:
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Thank you!

