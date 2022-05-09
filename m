Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C05451F5A4
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiEIHz1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 03:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbiEIHsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 03:48:36 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB41A18705D
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 00:44:38 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nny4E-0001iO-8Z; Mon, 09 May 2022 09:44:30 +0200
Message-ID: <3aa008b9-e477-3e6d-becb-13e28ea91f10@leemhuis.info>
Date:   Mon, 9 May 2022 09:44:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Bug 215925] New: PCIe regression on Raspberry Pi Compute Module
 4 (CM4) breaks booting
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     kibi@debian.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>, bjorn@helgaas.com
References: <bug-215925-41252@https.bugzilla.kernel.org/>
 <CABhMZUWjZCwK1_qT2ghTSu2dguJBzBTpiTqKohyA72OSGMsaeg@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CABhMZUWjZCwK1_qT2ghTSu2dguJBzBTpiTqKohyA72OSGMsaeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1652082278;0ab4e398;
X-HE-SMSGID: 1nny4E-0001iO-8Z
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Partly top-posting to
mnake this easily accessible.

Jim, what's up here? The regression was reported more than a week ago
and it seems nothing happened since then. Or was there progress and I
just missed it?

Anyway:

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

On 02.05.22 20:38, Bjorn Helgaas wrote:
> On Sat, Apr 30, 2022 at 2:53 PM <bugzilla-daemon@kernel.org> wrote:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=215925
>>
>>             Bug ID: 215925
>>            Summary: PCIe regression on Raspberry Pi Compute Module 4 (CM4)
>>                     breaks booting
>>            Product: Drivers
>>            Version: 2.5
>>     Kernel Version: v5.17-rc1
>>           Hardware: ARM
>>                 OS: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: PCI
>>           Assignee: drivers_pci@kernel-bugs.osdl.org
>>           Reporter: kibi@debian.org
>>         Regression: No
>>
>> Catching up with latest kernel releases in Debian, it turned out that my
>> Raspberry Pi Compute Module 4, mounted on an official Compute Module 4 IO
>> Board,
>> and booting from an SD card, no longer boots: this means a black screen on the
>> HDMI output, and no output on the serial console.
>>
>> Trying various releases, I confirmed that v5.16 was fine, and v5.17-rc1 was the
>> first (pre)release that wasn't.
>>
>> After some git bisect, it turns out the cause seems to be the following commit
>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=830aa6f29f07a4e2f1a947dfa72b3ccddb46dd21):
>>
>> ```
>> commit 830aa6f29f07a4e2f1a947dfa72b3ccddb46dd21
>> Author: Jim Quinlan <jim2101024@gmail.com>
>> Date:   Thu Jan 6 11:03:27 2022 -0500
>>
>>     PCI: brcmstb: Split brcm_pcie_setup() into two funcs
>> ```
>>
>> Starting with this commit, the kernel panics early (before 0.30 seconds), with
>> an `Asynchronous SError Interrupt`. The backtrace references various
>> `brcm_pcie_*` functions; I can share a picture or try and transcribe it
>> manually if that helps (nothing on the serial console…).
>>
>> This commit is part of a branch that was ultimately merged as
>> d0a231f01e5b25bacd23e6edc7c979a18a517b2b; starting with this commit, there's
>> not even a backtrace anymore, the screen stays black after the usual “boot-up
>> rainbow”, and there's still nothing on the serial console.
>>
>> I confirmed that 88db8458086b1dcf20b56682504bdb34d2bca0e2 (on the master side)
>> was still booting properly, and that 87c71931633bd15e9cfd51d4a4d9cd685e8cdb55
>> (from the branch being merged into master) is the last commit showing the
>> panic.
>>
>> Since d0a231f01e5b25bacd23e6edc7c979a18a517b2b is a merge commit that includes
>> conflict resolutions in drivers/pci/controller/pcie-brcmstb.c, I suppose this
>> could be consistent with the initial panic being “upgraded” into an even more
>> serious issue.
>>
>> I've also verified that latest master (v5.18-rc4-396-g57ae8a492116) is still
>> affected by this issue.
>>
>> The regular Raspberry Pi 4 B doesn't seem to be affected by this issue: the
>> exact same image on the same SD card (with latest master) boots fine on it.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

To be sure below issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 830aa6f29f07a4e2f1a
#regzbot title pci: brcmstb: CM4 no longer boots from SD card
#regzbot ignore-activity
#regzbot from: Cyril Brulebois <kibi@debian.org>
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215925

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replied to), as the kernel's
documentation call for; above page explains why this is important for
tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
