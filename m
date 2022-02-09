Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322664AEDC1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 10:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiBIJNx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 04:13:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiBIJNw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 04:13:52 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2B3E081A03;
        Wed,  9 Feb 2022 01:13:46 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nHj2Q-0001iT-6y; Wed, 09 Feb 2022 10:13:22 +0100
Message-ID: <d2b054b6-0c32-ef04-134d-51f116d3e1d3@leemhuis.info>
Date:   Wed, 9 Feb 2022 10:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [5.17 regression] "x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems" breaks suspend/resume
Content-Language: en-BS
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1644398026;7fca3f53;
X-HE-SMSGID: 1nHj2Q-0001iT-6y
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker speaking.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 7f7b4236f204
#regzbot title x86/PCI: "x86/PCI: Ignore E820 reservations for bridge
windows on newer systems" breaks suspend/resume
#regzbot ignore-activity

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. This allows the bot to connect
the report with any patches posted or committed to fix the issue; this
again allows the bot to show the current status of regressions and
automatically resolve the issue when the fix hits the right tree.

I'm sending this to everyone that got the initial report, to make them
aware of the tracking. I also hope that messages like this motivate
people to directly get at least the regression mailing list and ideally
even regzbot involved when dealing with regressions, as messages like
this wouldn't be needed then.

Don't worry, I'll send further messages wrt to this regression just to
the lists (with a tag in the subject so people can filter them away), if
they are relevant just for regzbot. With a bit of luck no such messages
will be needed anyway.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

On 08.02.22 16:25, Hans de Goede wrote:
> Hi All,
> 
> Unfortunately I've just learned that commit 7f7b4236f204 ("x86/PCI:
> Ignore E820 reservations for bridge windows on newer systems"):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f7b4236f2040d19df1ddaf30047128b41e78de7
> 
> breaks suspend/resume on at least one laptop model, the Lenovo ThinkPad
> X1 gen 2, see:
> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> 
> This regression was actually caught be Fedora already carrying this
> patch for a while now and as such it has been reproduced with 5.15
> with an older version of the patch which still allowed turning the
> new behavior of by adding "pci=use_e820". Dmesg output with and
> without the option has just been attached to the bug, I've not
> analyzed this any further yet.
> 
> I guess that for now this means that we need to revert commit
> 7f7b4236f204. Rafael, I'll send you a revert with a commit msg
> explaining why this needs to be reverted tomorrow.
> 
> More interesting IMHO is finding out another solution. Both the touchpad
> problem which got me looking into this:
> https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> 
> As well as the thunderbolt hotplug issue Mika was looking at:
> https://bugzilla.kernel.org/show_bug.cgi?id=206459
> 
> both are cases where we fail to find a memory-window for a
> BAR which has not been setup yet.
> 
> So I see a couple of options here:
> 
> 1. Detect that the e820 reservations fully cover (one of)
> the PCI bridge main 32 bit memory windows and if that happens
> ignore them. This actually was my first plan when I started
> working on this. In the end I choose the other option
> because Bjorn indicated that in hindsight honoring the e820
> reservations might have been a mistake and maybe we should
> get rid of honoring them all together.
> 
> 2. Have a flag which, when we fail to alloc a 32 bit
> (or 64 bit) memory PCI BAR, is set if not already set
> and then retry the alloc. And make the e820 reservation
> carve-out get skipped in this case.
> 
> 3. When booting with pci=nocrs as a workaround for
> the touchpad case a 64 but memory window ends up getting
> used. There already is some special handling for some
> AMD bridges where if there are no 64 bit memory Windows
> in the _CRS for the bridge, one gets added. Maybe we need
> to do the same for Intel bridges ?
> 
> Please let me know which of these options you think I should
> try to implement next; of course alternative ideas for fixing
> this are also welcome.
> 
> Regards,
> 
> Hans
> 

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
