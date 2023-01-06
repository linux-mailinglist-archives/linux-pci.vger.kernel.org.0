Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7708165FE40
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 10:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjAFJqi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 04:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAFJqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 04:46:15 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F98533D61;
        Fri,  6 Jan 2023 01:44:36 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pDjH0-0005Ky-LS; Fri, 06 Jan 2023 10:44:26 +0100
Message-ID: <7d7774d4-cbda-de9e-13f1-fcd734ac2aba@leemhuis.info>
Date:   Fri, 6 Jan 2023 10:44:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Content-Language: en-US, de-DE
To:     "Liang, Kan" <kan.liang@linux.intel.com>, bhelgaas@google.com
Cc:     hdegoede@redhat.com, kernelorg@undead.fr, kjhambrick@gmail.com,
        2lprbe78@duck.com, nicholas.johnson-opensource@outlook.com.au,
        benoitg@coeus.ca, mika.westerberg@linux.intel.com,
        wse@tuxedocomputers.com, mumblingdrunkard@protonmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.e.box@intel.com, yunying.sun@intel.com,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672998276;1b499c23;
X-HE-SMSGID: 1pDjH0-0005Ky-LS
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; all text you find below is based on a few templates
paragraphs you might have encountered already already in similar form.
See link in footer if these mails annoy you.]

On 04.01.23 15:39, Liang, Kan wrote:
> Hi Bjorn,
> 
> Happy new year!
> 
> We found some PCI issues with the latest 6.2-rc2.
> 
> - Using the lspci -xxxx, the extended PCI config space of all PCI
> devices are missed with the latest 6.2-rc2. The system we used had 932
> PCI devices, at least 800 which have extended space as seen when booted
> into a 5.15 kernel. But none of them appeared in 6.2-rc2.
> - The drivers which rely on the information in the extended PCI config
> space don't work anymore. We have confirmed that the perf uncore driver
> (uncore performance monitoring) and Intel VSEC driver (telemetry) don't
> work in 6.2-rc2. There could be more drivers which are impacted.
> 
> After a bisect, we found the regression is caused by the below commit
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").
> After reverting the commit, the issues are gone.
> 
> Could you please take a look at the issues?

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 07eab0901ede
#regzbot title x86/pci:  extended PCI config space is missed
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (see page linked in footer for details).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
