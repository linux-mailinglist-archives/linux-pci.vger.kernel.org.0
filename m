Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69152494EC9
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 14:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359812AbiATNTL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 08:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiATNTL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 08:19:11 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C073C061574
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 05:19:11 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nAXLG-0002vH-Fe; Thu, 20 Jan 2022 14:19:06 +0100
Message-ID: <e8e57b75-bb60-f092-67f7-174b1b3372c4@leemhuis.info>
Date:   Thu, 20 Jan 2022 14:19:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [REGRESSION] 527139d738d7 ("PCI/sysfs: Convert "rom" to static
 attribute")
Content-Language: en-BW
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
References: <YbxqIyrkv3GhZVxx@intel.com> <20211217172928.GA900484@bhelgaas>
 <YbzMyDm+5PCer8Fj@intel.com> <Yb0T79vFgeRcA2OU@rocinante>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Yb0T79vFgeRcA2OU@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1642684751;e1c2e5ed;
X-HE-SMSGID: 1nAXLG-0002vH-Fe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17.12.21 23:49, Krzysztof Wilczyński wrote:
> Hi Ville,
> 
> Thank you for letting us know, and sincere apologies for troubles!
> 
> [...]
>>>> The pci sysfs "rom" file has disappeared for VGA devices.
>>>> Looks to be a regression from commit 527139d738d7 ("PCI/sysfs:
>>>> Convert "rom" to static attribute").
>>>>
>>>> Some kind of ordering issue between the sysfs file creation 
>>>> vs. pci_fixup_video() perhaps?
>>>
>>> Can you attach your complete "lspci -vv" output?  Also, which is the
>>> default device?  I think there's a "boot_vga" sysfs file that shows
>>> this.  "find /sys -name boot_vga | xargs grep ."
>>
>> All I have is Intel iGPUs so it's always 00:02.0. 
>>
>> $ cat /sys/bus/pci/devices/0000\:00\:02.0/boot_vga 
>> 1
>> $ cat /sys/bus/pci/devices/0000\:00\:02.0/rom
>> cat: '/sys/bus/pci/devices/0000:00:02.0/rom': No such file or directory
>>
>> I've attached the full lspci from my IVB laptop, but the problem
>> happens on every machine (with an iGPU at least).
>>
>> I presume with a discrete GPU it might not happen since they
>> actually have a real ROM.
> 
> Admittedly, the automated testing I was running before the patch was released
> didn't catch this.  I primarily focused on trying to catch the race condition
> related to the ROM attribute creation.
> 
> I need to look into how to properly address this problem as if we were to
> revert the ROM attribute changes, then we would introduce the race condition
> we've had back.
> 
> Again, apologies for troubles this caused!

What's the status of this regression and getting it fixed? It looks like
there was no progress for quite a while. Could anyone please provide a
status update?

Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat)

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply, that's in everyone's interest.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

#regzbot poke
