Return-Path: <linux-pci+bounces-19564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6AA065EE
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 21:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE841889D1C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 20:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1DF202C3E;
	Wed,  8 Jan 2025 20:18:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA91ABED9;
	Wed,  8 Jan 2025 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367507; cv=none; b=ZbwLbf1sXGHw3avxltW2crD5p9n3jas1xgFBLcnQh6LIrA2f+rAhwv08ocpIXVHtVl/Gs3mncjWBtG/nZEKAzjNb+NUVDVnFQzJ9w5yq+ucRz6Ei/0hMI2D7nDgsxRPRCDepXHZnpoDp1dMQrHjy6kuUJBn5wCoCtrkM6WeOWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367507; c=relaxed/simple;
	bh=eQvOD5oObR9xJhsrh/E1FQya3AOWCKVE8dKE+vvzmTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4Vt1RlfAa6K5RLUAabIqJUKfyvT7C2TFe2odAa+DckagYFgQt2MjI1+Au+e5rTkzSvsRk0JSHH6t6FT5H8cQzED7dR5OZ4Md4JEKfM7nllnfKKPGbLBrvG0+bUcOZbiWb0eZAFw5grMWiiLdt+Jt93tde+O02H+FVl57Nv1XKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1tVcVM-00000005Q2v-1LVe;
	Wed, 08 Jan 2025 21:18:16 +0100
Message-ID: <db2575ca-e287-4911-97f9-50570aeece41@maciej.szmigiero.name>
Date: Wed, 8 Jan 2025 21:18:11 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 M Chetan Kumar <m.chetan.kumar@intel.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-pm@vger.kernel.org
References: <20250108195109.GA224965@bhelgaas>
 <5df4a525-dc5d-405a-be07-5b33e94f5a4f@maciej.szmigiero.name>
 <CAJZ5v0hU8=h2QLQ+JDoTb28uWFH=r=PsCSGjgs+Mv4_ax-rrAg@mail.gmail.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
Disposition-Notification-To: "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
In-Reply-To: <CAJZ5v0hU8=h2QLQ+JDoTb28uWFH=r=PsCSGjgs+Mv4_ax-rrAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: mhej@vps-ovh.mhejs.net

On 8.01.2025 21:17, Rafael J. Wysocki wrote:
> On Wed, Jan 8, 2025 at 9:04 PM Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>>
>> On 8.01.2025 20:51, Bjorn Helgaas wrote:
>>> [+cc Rafael, linux-pm because they *are* PM experts :)]
>>>
>>> On Wed, Jan 08, 2025 at 02:15:28AM +0200, Sergey Ryazanov wrote:
>>>> On 08.01.2025 01:45, Bjorn Helgaas wrote:
>>>>> On Wed, Jan 08, 2025 at 01:13:41AM +0200, Sergey Ryazanov wrote:
>>>>>> On 05.01.2025 19:39, Maciej S. Szmigiero wrote:
>>>>>>> Currently, the driver is seriously broken with respect to the
>>>>>>> hibernation (S4): after image restore the device is back into
>>>>>>> IPC_MEM_EXEC_STAGE_BOOT (which AFAIK means bootloader stage) and needs
>>>>>>> full re-launch of the rest of its firmware, but the driver restore
>>>>>>> handler treats the device as merely sleeping and just sends it a
>>>>>>> wake-up command.
>>>>>>>
>>>>>>> This wake-up command times out but device nodes (/dev/wwan*) remain
>>>>>>> accessible.
>>>>>>> However attempting to use them causes the bootloader to crash and
>>>>>>> enter IPC_MEM_EXEC_STAGE_CD_READY stage (which apparently means "a crash
>>>>>>> dump is ready").
>>>>>>>
>>>>>>> It seems that the device cannot be re-initialized from this crashed
>>>>>>> stage without toggling some reset pin (on my test platform that's
>>>>>>> apparently what the device _RST ACPI method does).
>>>>>>>
>>>>>>> While it would theoretically be possible to rewrite the driver to tear
>>>>>>> down the whole MUX / IPC layers on hibernation (so the bootloader does
>>>>>>> not crash from improper access) and then re-launch the device on
>>>>>>> restore this would require significant refactoring of the driver
>>>>>>> (believe me, I've tried), since there are quite a few assumptions
>>>>>>> hard-coded in the driver about the device never being partially
>>>>>>> de-initialized (like channels other than devlink cannot be closed,
>>>>>>> for example).
>>>>>>> Probably this would also need some programming guide for this hardware.
>>>>>>>
>>>>>>> Considering that the driver seems orphaned [1] and other people are
>>>>>>> hitting this issue too [2] fix it by simply unbinding the PCI driver
>>>>>>> before hibernation and re-binding it after restore, much like
>>>>>>> USB_QUIRK_RESET_RESUME does for USB devices that exhibit a similar
>>>>>>> problem.
>>>>>>>
>>>>>>> Tested on XMM7360 in HP EliteBook 855 G7 both with s2idle (which uses
>>>>>>> the existing suspend / resume handlers) and S4 (which uses the new code).
>>>>>>>
>>>>>>> [1]: https://lore.kernel.org/all/c248f0b4-2114-4c61-905f-466a786bdebb@leemhuis.info/
>>>>>>> [2]:
>>>>>>> https://github.com/xmm7360/xmm7360-pci/issues/211#issuecomment-1804139413
>>>>>>>
>>>>>>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>>>>>>
>>>>>> Generally looks good to me. Lets wait for approval from PCI
>>>>>> maintainers to be sure that there no unexpected side effects.
>>>>>
>>>>> I have nothing useful to contribute here.  Seems like kind of a
>>>>> mess.  But Intel claims to maintain this, so it would be nice if
>>>>> they would step up and make this work nicely.
>>>>
>>>> Suddenly, Intel lost their interest in the modems market and, as
>>>> Maciej mentioned, the driver was abandon for a quite time now. The
>>>> author no more works for Intel. You will see the bounce.
>>>
>>> Well, that's unfortunate :)  Maybe step 0 is to remove the Intel
>>> entry from MAINTAINERS for this driver.
>>>
>>>> Bjorn, could you suggest how to deal easily with the device that is
>>>> incapable to seamlessly recover from hibernation? I am totally
>>>> hopeless regarding the PM topic. Or is the deep driver rework the
>>>> only option?
>>>
>>> I'm pretty PM-illiterate myself.  Based on
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/pm/sleep-states.rst?id=v6.12#n109,
>>> I assume that when we resume after hibernate, devices are in the same
>>> state as after a fresh boot, i.e., the state driver .probe() methods
>>> see.
>>>
>>> So I assume that some combination of dev_pm_ops methods must be able
>>> to do basically the same as .probe() to get the device usable again
>>> after it was completely powered off and back on.
>>
>> You are right that it should be theoretically possible to fix this issue
>> by re-initializing the driver in the hibernation restore/thaw callbacks
>> and I even have tried to do so in the beginning.
>>
>> But as I wrote in this patch description, doing so would need significant
>> refactoring of the driver as it is not currently capable of being
>> de-initialized and re-initialized partially.
>>
>> Hence this patch approach of simply re-binding the driver which also
>> seemed safer in the absence of any real programming docs for this hardware.
> 
> While this may not be elegant, it may actually get the job done.
> 
> Can you please resend the patch with a CC to linux-pm@vger.kernel.org?

Will do.

Thanks,
Maciej


