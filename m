Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0512952E485
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 07:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiETFsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 01:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345502AbiETFsK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 01:48:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8314B641
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 22:48:08 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nrvUc-0002ph-OR; Fri, 20 May 2022 07:48:06 +0200
Message-ID: <02950542-6d20-b382-0457-e5912200a2c5@leemhuis.info>
Date:   Fri, 20 May 2022 07:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [Bug 215925] New: PCIe regression on Raspberry Pi Compute Module
 4 (CM4) breaks booting
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Cyril Brulebois <kibi@debian.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>, bjorn@helgaas.com
References: <bug-215925-41252@https.bugzilla.kernel.org/>
 <CABhMZUWjZCwK1_qT2ghTSu2dguJBzBTpiTqKohyA72OSGMsaeg@mail.gmail.com>
 <3aa008b9-e477-3e6d-becb-13e28ea91f10@leemhuis.info>
 <CANCKTBuOjJk6SRTHs+tXXWaC9cGsxkp9PM2rwpf+hs50S+cBfQ@mail.gmail.com>
 <CANCKTBsvL8AJ-O54+Wque_A2O6XZTPZO5Jw+xUoviXC84+8WWw@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CANCKTBsvL8AJ-O54+Wque_A2O6XZTPZO5Jw+xUoviXC84+8WWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1653025689;9b4cfba0;
X-HE-SMSGID: 1nrvUc-0002ph-OR
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18.05.22 21:47, Jim Quinlan wrote:

> I have just sent a pullrequest to linu-pci@vger@kernel.org to address
> this regression.

Great, thx

> Please let me know if I have to do anything else besides addressing
> reviewers concerns
> for this pullreq.

No need to, everything fine. I just have to tell regzbot manually about
the patch (and the commit-id once it landed), as it doesn't handle links
to bugzilla ticket to well yet, but that hopefully should be history in
a week or two (or three).

#regzbot monitor:
https://lore.kernel.org/linux-pci/CANCKTBuz9FG-aGuwM-thFgkAyTi480=1j78DpjWUkgU4UDuurg@mail.gmail.com/

Ciao, Thorsten

> On Mon, May 16, 2022 at 5:05 PM Jim Quinlan <jim2101024@gmail.com> wrote:
>>
>> Hi Bjorn, Thorsten,
>>
>> I apologize -- I did not see this email until now; I think I have to
>> work on my gmail filters and labels.
>>
>> I've just made a post on the Bugzilla website regarding this
>> regression and have ideas on what may be causing the problem.
>> Unfortunately, the error cannot be reproduced on my RPi4 or Broadcom
>> STB version of the 2711.
>> Hopefully Cyril can help me identify the issue.
>>
>> I will try to get a Fixup ASAP.
>>
>> Regards,
>> Jim Quinlan
>> Broadcom STB
>>
>> On Mon, May 9, 2022 at 3:44 AM Thorsten Leemhuis
>> <regressions@leemhuis.info> wrote:
>>>
>>> Hi, this is your Linux kernel regression tracker. Partly top-posting to
>>> mnake this easily accessible.
>>>
>>> Jim, what's up here? The regression was reported more than a week ago
>>> and it seems nothing happened since then. Or was there progress and I
>>> just missed it?
>>>
>>> Anyway:
>>>
>>> [TLDR: I'm adding this regression report to the list of tracked
>>> regressions; all text from me you find below is based on a few templates
>>> paragraphs you might have encountered already already in similar form.]
>>>
>>> On 02.05.22 20:38, Bjorn Helgaas wrote:
>>>> On Sat, Apr 30, 2022 at 2:53 PM <bugzilla-daemon@kernel.org> wrote:
>>>>>
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=215925
>>>>>
>>>>>             Bug ID: 215925
>>>>>            Summary: PCIe regression on Raspberry Pi Compute Module 4 (CM4)
>>>>>                     breaks booting
>>>>>            Product: Drivers
>>>>>            Version: 2.5
>>>>>     Kernel Version: v5.17-rc1
>>>>>           Hardware: ARM
>>>>>                 OS: Linux
>>>>>               Tree: Mainline
>>>>>             Status: NEW
>>>>>           Severity: normal
>>>>>           Priority: P1
>>>>>          Component: PCI
>>>>>           Assignee: drivers_pci@kernel-bugs.osdl.org
>>>>>           Reporter: kibi@debian.org
>>>>>         Regression: No
>>>>>
>>>>> Catching up with latest kernel releases in Debian, it turned out that my
>>>>> Raspberry Pi Compute Module 4, mounted on an official Compute Module 4 IO
>>>>> Board,
>>>>> and booting from an SD card, no longer boots: this means a black screen on the
>>>>> HDMI output, and no output on the serial console.
>>>>>
>>>>> Trying various releases, I confirmed that v5.16 was fine, and v5.17-rc1 was the
>>>>> first (pre)release that wasn't.
>>>>>
>>>>> After some git bisect, it turns out the cause seems to be the following commit
>>>>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=830aa6f29f07a4e2f1a947dfa72b3ccddb46dd21):
>>>>>
>>>>> ```
>>>>> commit 830aa6f29f07a4e2f1a947dfa72b3ccddb46dd21
>>>>> Author: Jim Quinlan <jim2101024@gmail.com>
>>>>> Date:   Thu Jan 6 11:03:27 2022 -0500
>>>>>
>>>>>     PCI: brcmstb: Split brcm_pcie_setup() into two funcs
>>>>> ```
>>>>>
>>>>> Starting with this commit, the kernel panics early (before 0.30 seconds), with
>>>>> an `Asynchronous SError Interrupt`. The backtrace references various
>>>>> `brcm_pcie_*` functions; I can share a picture or try and transcribe it
>>>>> manually if that helps (nothing on the serial console…).
>>>>>
>>>>> This commit is part of a branch that was ultimately merged as
>>>>> d0a231f01e5b25bacd23e6edc7c979a18a517b2b; starting with this commit, there's
>>>>> not even a backtrace anymore, the screen stays black after the usual “boot-up
>>>>> rainbow”, and there's still nothing on the serial console.
>>>>>
>>>>> I confirmed that 88db8458086b1dcf20b56682504bdb34d2bca0e2 (on the master side)
>>>>> was still booting properly, and that 87c71931633bd15e9cfd51d4a4d9cd685e8cdb55
>>>>> (from the branch being merged into master) is the last commit showing the
>>>>> panic.
>>>>>
>>>>> Since d0a231f01e5b25bacd23e6edc7c979a18a517b2b is a merge commit that includes
>>>>> conflict resolutions in drivers/pci/controller/pcie-brcmstb.c, I suppose this
>>>>> could be consistent with the initial panic being “upgraded” into an even more
>>>>> serious issue.
>>>>>
>>>>> I've also verified that latest master (v5.18-rc4-396-g57ae8a492116) is still
>>>>> affected by this issue.
>>>>>
>>>>> The regular Raspberry Pi 4 B doesn't seem to be affected by this issue: the
>>>>> exact same image on the same SD card (with latest master) boots fine on it.
>>>
>>> CCing the regression mailing list, as it should be in the loop for all
>>> regressions, as explained here:
>>> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>>>
>>> To be sure below issue doesn't fall through the cracks unnoticed, I'm
>>> adding it to regzbot, my Linux kernel regression tracking bot:
>>>
>>> #regzbot ^introduced 830aa6f29f07a4e2f1a
>>> #regzbot title pci: brcmstb: CM4 no longer boots from SD card
>>> #regzbot ignore-activity
>>> #regzbot from: Cyril Brulebois <kibi@debian.org>
>>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215925
>>>
>>> This isn't a regression? This issue or a fix for it are already
>>> discussed somewhere else? It was fixed already? You want to clarify when
>>> the regression started to happen? Or point out I got the title or
>>> something else totally wrong? Then just reply -- ideally with also
>>> telling regzbot about it, as explained here:
>>> https://linux-regtracking.leemhuis.info/tracked-regression/
>>>
>>> Reminder for developers: When fixing the issue, add 'Link:' tags
>>> pointing to the report (the mail this one replied to), as the kernel's
>>> documentation call for; above page explains why this is important for
>>> tracked regressions.
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>
>>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
>>> reports and sometimes miss something important when writing mails like
>>> this. If that's the case here, don't hesitate to tell me in a public
>>> reply, it's in everyone's interest to set the public record straight.
> 
