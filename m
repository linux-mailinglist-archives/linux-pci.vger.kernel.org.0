Return-Path: <linux-pci+bounces-35932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F75DB53B4E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 20:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36851743CE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 18:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3087135A2BE;
	Thu, 11 Sep 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeHAljJD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA847F4A;
	Thu, 11 Sep 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614861; cv=none; b=hi5SiViCo+uocWIe8skyc4I0SLMe0U/Kzgapni4iPGT5I1VxpynyIjd9+wurNYmcRC22XDqmCQQAn8qBHeKfFksU7UvT/Mb6BsJVmDtapNooGnfamcPhr2+JJrFj7CYA1cgzZDvJe5BQfITZAabDxf1lAoYOTgnFPXwaIKWfIYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614861; c=relaxed/simple;
	bh=o+sxduyxa8P2is/JjSQ9wBtUm8hKM5vkrOVW/URvt50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDIMopsdH+7tGt6hnZqEFtM0Wmkq0k5+v3AMcG5LPwxrp4MJrwnJHK7xRWg7CGrUtObZq6P1/+ao2Iko7v75d218j6VtztvYSH6vtacHBRQAC4wNT3xeNRsQoPCeOVgO8gZNAu10IsTTVieIMyeoYke7Rssw4BRv8iBXjucYwjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeHAljJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAA6C4CEF0;
	Thu, 11 Sep 2025 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757614860;
	bh=o+sxduyxa8P2is/JjSQ9wBtUm8hKM5vkrOVW/URvt50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CeHAljJDzJdup7w9zQX9/GNFkTzX6d6ORTJhqykt+uG10pc8rhwqpixStBAK6ISou
	 9ofRSL0uKG0Ey1N33hqbnSyi8KtF5bgXi0bnndxi51NfUzKhN1OpofUEcehsnq+WHD
	 Yhj9f8iZuSV1iicRNV3S11bcVEwdL7G4DLm4x1mTipYlWLDPeDdeHx5SYwsVjT8LVA
	 RzDQYilJZ8eyw9XgCePXgw7pqpjsDNcjVSFdoRCRU8PNMq0HNWQZVhN/LCwthHbzXs
	 9CMMnKcRX4V6y4qZ7fJO1vLw1w+UbkQ8/k4wOC8XVgOw0PlFam+ljNDWcFTlsKQlwC
	 Egpsg2MIOFmew==
Message-ID: <2833916c-f4e7-4fd3-9d16-f9b544922921@kernel.org>
Date: Thu, 11 Sep 2025 13:20:55 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Move ASUS EHCI workaround out of generic code
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Alan Stern <stern@rowland.harvard.edu>,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Timo Jyrinki <timo.jyrinki@iki.fi>, Ernst Persson <ernstp@gmail.com>,
 Steven Harms <sjharms@gmail.com>, James Ettle <james@ettle.org.uk>,
 Nick Coghlan <ncoghlan@gmail.com>, Weng Xuetian <wengxt@gmail.com>,
 Andrey Rahmatullin <wrar@wrar.name>, Boris Barbour <boris.barbour@ens.fr>,
 Vlastimil Zima <vlastimil.zima@gmail.com>, David Banks <amoebae@gmail.com>,
 Michal Jaegermann <michal@harddata.com>, Chris Moeller <kode54@gmail.com>,
 Daniel Fraga <fragabr@gmail.com>, Javier Marcet <jmarcet@gmail.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
References: <75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de>
 <80980751-64db-4dc2-9516-03046e8b4b31@kernel.org>
 <CAJZ5v0idqEPUpA0uBb_PAaKe0KNqCt0xLskPThPwtsfh3eCdxg@mail.gmail.com>
 <fd9629df-0718-4968-b22b-cad36d870f63@kernel.org>
 <CAJZ5v0hJHxVvyNdvDSZg=Pn9=xEqO79T4Ou9toc0Qofi777NcA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0hJHxVvyNdvDSZg=Pn9=xEqO79T4Ou9toc0Qofi777NcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/25 8:56 AM, Rafael J. Wysocki wrote:
> On Thu, Sep 11, 2025 at 3:46 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 9/11/25 8:43 AM, Rafael J. Wysocki wrote:
>>> On Thu, Sep 11, 2025 at 3:34 PM Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> On 9/11/25 8:11 AM, Lukas Wunner wrote:
>>>>> In 2012, commit dbf0e4c7257f ("PCI: EHCI: fix crash during suspend on ASUS
>>>>> computers") amended pci_pm_suspend_noirq() to work around a BIOS issue by
>>>>> clearing the Command register if the suspended device is a USB EHCI host
>>>>> controller.
>>>>>
>>>>> Commit 0b68c8e2c3af ("PCI: EHCI: Fix crash during hibernation on ASUS
>>>>> computers") subsequently amended pci_pm_poweroff_noirq() to do the same.
>>>>>
>>>>> Two years later, commit 7d2a01b87f16 ("PCI: Add pci_fixup_suspend_late
>>>>> quirk pass") introduced the ability to execute arbitrary quirks
>>>>> specifically in pci_pm_suspend_noirq() and pci_pm_poweroff_noirq().
>>>>>
>>>>> This allows moving the ASUS workaround out of generic code and into a
>>>>> proper quirk to improve maintainability and readability.  Constrain to x86
>>>>> since the ASUS BIOS doesn't seem to have been used on other arches.
>>>>>
>>>>> lspci output of affected EHCI host controllers reveals that the only bits
>>>>> set in the Command register are Memory Space Enable and Bus Master Enable:
>>>>>      https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=658778
>>>>>
>>>>> The latter is cleared by:
>>>>>      hcd_pci_suspend()
>>>>>        suspend_common()
>>>>>          pci_disable_device()
>>>>>
>>>>> pci_disable_device() does not clear I/O and Memory Space Enable, although
>>>>> its name suggests otherwise.
>>>>
>>>> That was my gut reaction as well.
>>>>
>>>>> The kernel has never disabled these bits
>>>>> once they're enabled.  Doing so would avoid the need for the quirk, but it
>>>>> is unclear what will break if this fundamental behavior is changed.
>>>>>
>>>>
>>>> It's too late for this cycle to do so, but how would you feel about
>>>> making this change at the start of the next cycle so it had a whole
>>>> cycle to bake in linux-next and see if there is a problem in doing so?
>>>
>>> One cycle in linux-next may not be sufficient I'm afraid because
>>> linux-next is not tested on the majority of systems running Linux.
>>>
>>> We'd probably learn about the breakage from distro vendors.
>>>
>>>> If there is it could certainly be moved back to a quirk.
>>>
>>> Most likely, it would work on the majority of systems, but there would
>>> be a tail of systems where it would break.  That tail would then need
>>> to be quirked somehow and it may be worse than just one quirk we have
>>> today.
>>
>> But is that a reason not to *try* and rid the tech debt?
>>
>> We could just all agree that *if* there is breakage we revert back to
>> the quirk just for EHCI.
> 
> Well, it's not that simple because how much time do you want to wait?
> 
> The distro installed on the system I'm using right now ships with a
> 6.4-based kernel, so it potentially sees and may report breakage
> introduced into the mainline 2 years ago.
> 
> Will you decide to go back to the EHCI quirk if breakage is reported 2
> years after dropping it?
> 
> IMV, if a decision is made to change the pci_disable_device() behavior
> in this respect, we'll need to stick to it unless the breakage is
> common and overwhelming (which I don't really expect to be the case).

Thanks, I see your point.  We would only know soon if there was major 
breakage from it and thus it is not an easy call that it was successful 
or not.

Bjorn, what are your thoughts here?

