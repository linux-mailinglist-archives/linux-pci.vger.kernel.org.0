Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB36678DB68
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbjH3SjI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242889AbjH3Jzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 05:55:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47451B0;
        Wed, 30 Aug 2023 02:55:52 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qbHvQ-0002P7-2Q; Wed, 30 Aug 2023 11:55:48 +0200
Message-ID: <8a737241-f216-169a-8bd3-d0832439b99e@leemhuis.info>
Date:   Wed, 30 Aug 2023 11:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression v6.5-rc1] PCI: comm "swapper/0" leaking memory
Content-Language: en-US, de-DE
To:     Kalle Valo <kvalo@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org, regressions@lists.linux.dev
References: <878r9sga1t.fsf@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <878r9sga1t.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693389352;552f9eec;
X-HE-SMSGID: 1qbHvQ-0002P7-2Q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Partially
top-posting for once, to make this easily accessible to everyone.

Thx for the report. To quote one aspect:

> v6.4 has no leaks.

I pretty sure you mean stock 6.4 here. But FWIW, the culprit was
backported to 6.4.y and 6.1.y, so they latest versions might be affected
as well.

For the rest of this mail:

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 30.08.23 11:21, Kalle Valo wrote:
> 
> I noticed that starting from v6.5-rc1 my ath11k tests reported several
> memory leaks from swapper/0:
> 
> unreferenced object 0xffff88810a02b7a8 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>   hex dump (first 32 bytes):
>     80 b8 02 0a 81 88 ff ff b8 72 07 00 00 c9 ff ff  .........r......
>     c8 b7 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>   backtrace:
> unreferenced object 0xffff88810a02b880 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>   hex dump (first 32 bytes):
>     58 b9 02 0a 81 88 ff ff a8 b7 02 0a 81 88 ff ff  X...............
>     a0 b8 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>   backtrace:
> unreferenced object 0xffff88810a02b958 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>   hex dump (first 32 bytes):
>     30 ba 02 0a 81 88 ff ff 80 b8 02 0a 81 88 ff ff  0...............
>     78 b9 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  x...............
>   backtrace:
> unreferenced object 0xffff88810a02ba30 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>   hex dump (first 32 bytes):
>     08 bb 02 0a 81 88 ff ff 58 b9 02 0a 81 88 ff ff  ........X.......
>     50 ba 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  P...............
>   backtrace:
> unreferenced object 0xffff88810a02bb08 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>   hex dump (first 32 bytes):
>     e0 bb 02 0a 81 88 ff ff 30 ba 02 0a 81 88 ff ff  ........0.......
>     28 bb 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  (...............
>   backtrace:
> 
> I can easily reproduce this by doing a simple insmod and rmmod of ath11k
> and it's dependencies (mac80211, MHI etc). I can reliability reproduce
> the leaks but I only see them once after a boot, I need to reboot the
> host to see the leaks again. v6.4 has no leaks.
> 
> I did a bisect and found the commit below. I verified reverting the
> commit makes the leaks go away.
> 
> commit e54223275ba1bc6f704a6bab015fcd2ae4f72572
> Author:     Ross Lagerwall <ross.lagerwall@citrix.com>
> AuthorDate: Thu May 25 16:32:48 2023 +0100
> Commit:     Bjorn Helgaas <bhelgaas@google.com>
> CommitDate: Fri Jun 9 15:06:16 2023 -0500
> 
>     PCI: Release resource invalidated by coalescing

To be sure the issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced e54223275ba1bc6f704a6bab015fcd2ae4f72572
#regzbot title PCI: comm "swapper/0" leaking memory
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
