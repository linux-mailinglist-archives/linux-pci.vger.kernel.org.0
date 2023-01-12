Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82A2667873
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 16:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbjALPCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 10:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240253AbjALPC3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 10:02:29 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EABE70;
        Thu, 12 Jan 2023 06:48:51 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pFyso-0000Xu-Nn; Thu, 12 Jan 2023 15:48:46 +0100
Message-ID: <9d46a35f-5830-9761-ca2c-eaa640e9cc86@leemhuis.info>
Date:   Thu, 12 Jan 2023 15:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Regression in Kernel 6.0: System partially freezes with "nvme
 controller is down"
Content-Language: en-US, de-DE
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <d5d8d106-acce-e20c-827d-1b37de2b2188@posteo.de>
 <0d3206be-fae8-4bbd-4b6c-a5d1f038356d@posteo.de>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     =?UTF-8?Q?Julian_Gro=c3=9f?= <julian.g@posteo.de>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <0d3206be-fae8-4bbd-4b6c-a5d1f038356d@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673534931;ffc87eac;
X-HE-SMSGID: 1pFyso-0000Xu-Nn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[adding the nvme maintainers and the regressions mailing list to the
list of recipients]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 11.01.23 23:11, Julian Groß wrote:
> Dear Maintainer,
> 
> when running Linux Kernel version 6.0.12, 6.0.10, 6.0-rc7, or 6.1.4, my
> system seemingly randomly freezes due to the file system being set to
> read-only due to an issue with my NVMe controller.
> The issue does *not* appear on Linux Kernel version 5.19.11 or lower.
> 
> Through network logging I am able to catch the issue:
> ```
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259288] nvme nvme0:
> controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Does
> your device have a faulty power saving mode enabled?
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Try
> "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.331360] nvme 0000:01:00.0:
> enabling device (0000 -> 0002)
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.331458] nvme nvme0: Removing
> after probe failure status: -19
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371389] nvme0n1: detected
> capacity change from 1953525168 to 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371389] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371389] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371392] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371394] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371405] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371406] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371411] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371419] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371425] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 10, rd 0, flush 0, corrupt 0,
> gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371426] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 11, rd 0, flush 0, corrupt 0,
> gen 0
> ```
> 
> I have tried the suggestion in the log without luck.
> 
> Attached is a log that includes two system freezes, as well as a list of
> PCI(e) devices created by Debian reportbug.
> The first freeze happens at "Jan  8 04:26:28" and the second freeze
> happens at "Jan  8 14:50:16".
> 
> Currently, I am using git bisect to narrow down the window of possible
> commits, but since the issue appears seemingly random, it will take many
> months to identify the offending commit this way.
> 
> The original Debian bug report is here:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1028309

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced v5.19..v6.0-rc7
#regzbot title nvme: system partially freezes with "nvme controller is down"
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
