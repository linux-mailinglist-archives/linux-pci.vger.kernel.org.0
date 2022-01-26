Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CCE49C459
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 08:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiAZHb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 02:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiAZHb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 02:31:58 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E788C06161C
        for <linux-pci@vger.kernel.org>; Tue, 25 Jan 2022 23:31:58 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nCcmX-0005nl-FZ; Wed, 26 Jan 2022 08:31:53 +0100
Message-ID: <f6220c47-0593-abc8-6faa-28e8b719fa77@leemhuis.info>
Date:   Wed, 26 Jan 2022 08:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Content-Language: en-BS
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220124214635.GA1553164@bhelgaas>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220124214635.GA1553164@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643182318;bc282c32;
X-HE-SMSGID: 1nCcmX-0005nl-FZ
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


[TLDR: I'm adding this regression to regzbot, the Linux kernel
regression tracking bot; most text you find below is compiled from a few
templates paragraphs some of you might have seen already.]

Hi, this is your Linux kernel regression tracker speaking.

Adding the regression mailing list to the list of recipients, as it
should be in the loop for all regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 24.01.22 22:46, Bjorn Helgaas wrote:
> [+cc linux-pci, Hans, Lukas, Naveen, Keith, Nirmal, Jonathan]
> 
> On Mon, Jan 24, 2022 at 11:46:14AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=215525
>>
>>             Bug ID: 215525
>>            Summary: HotPlug does not work on upstream kernel 5.17.0-rc1
>>            Product: Drivers
>>            Version: 2.5
>>     Kernel Version: 5.17.0-rc1 upstream
>>           Hardware: x86-64
>>                 OS: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: PCI
>>           Assignee: drivers_pci@kernel-bugs.osdl.org
>>           Reporter: blazej.kucman@intel.com
>>         Regression: No
>>
>> Created attachment 300308
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=300308&action=edit
>> dmesg
>>
>> While testing on latest upstream
>> kernel(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/) we
>> noticed that with the merge commit
>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0a231f01e5b25bacd23e6edc7c979a18a517b2b)
>> hotplug and hotunplug of nvme drives stopped working.
>>
>> Rescan PCI does not help.
>> echo "1" > /sys/bus/pci/rescan
>>
>> Issue does not reproduce on a kernel built on an antecedent
>> commit(88db8458086b1dcf20b56682504bdb34d2bca0e2).
>>
>>
>> During hot-remove device does not disappear, however when we try to do I/O on
>> the disk then there is an I/O error, and the device disappears.
>>
>> Before I/O no logs regarding the disk appeared in the dmesg, only after I/O the
>> entries appeared like below:
>> [  177.943703] nvme nvme5: controller is down; will reset: CSTS=0xffffffff,
>> PCI_STATUS=0xffff
>> [  177.971661] nvme 10000:0b:00.0: can't change power state from D3cold to D0
>> (config space inaccessible)
>> [  177.981121] pcieport 10000:00:02.0: can't derive routing for PCI INT A
>> [  177.987749] nvme 10000:0b:00.0: PCI INT A: no GSI
>> [  177.992633] nvme nvme5: Removing after probe failure status: -19
>> [  178.004633] nvme5n1: detected capacity change from 83984375 to 0
>> [  178.004677] I/O error, dev nvme5n1, sector 0 op 0x0:(READ) flags 0x0
>> phys_seg 1 prio class 0
>>
>>
>> OS: RHEL 8.4 GA
>> Platform: Intel Purley
>>
>> The logs are collected on a non-recent upstream kernel, but a issue also occurs
>> on the newest upstream kernel(dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0)
> 
> Apparently worked immediately before merging the PCI changes for
> v5.17 and failed immediately after:
> 
>   good: 88db8458086b ("Merge tag 'exfat-for-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat")
>   bad:  d0a231f01e5b ("Merge tag 'pci-v5.17-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci")
> 
> Only three commits touch pciehp:
> 
>   085a9f43433f ("PCI: pciehp: Use down_read/write_nested(reset_lock) to fix lockdep errors")
>   23584c1ed3e1 ("PCI: pciehp: Fix infinite loop in IRQ handler upon power fault")
>   a3b0f10db148 ("PCI: pciehp: Use PCI_POSSIBLE_ERROR() to check config reads")
> 
> None seems obviously related to me.  Blazej, could you try setting
> CONFIG_DYNAMIC_DEBUG=y and booting with 'dyndbg="file pciehp* +p"' to
> enable more debug messages?

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced: d0a231f01e5b25bacd23e
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215525
#regzbot from: blazej.kucman@intel.com
#regzbot title: pci: HotPlug does not work on upstream kernel 5.17.0-rc1

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

---
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
tell #regzbot about it in the report, as that will ensure the regression
gets on the radar of regzbot and the regression tracker. That's in your
interest, as they will make sure the report won't fall through the
cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include a 'Link:' tag to the report in the commit message, as explained
in Documentation/process/submitting-patches.rst
That aspect was recently was made more explicit in commit 1f57bd42b77c:
https://git.kernel.org/linus/1f57bd42b77c
