Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDB669ABA8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 13:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjBQMkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 07:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBQMkB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 07:40:01 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F6F64B23;
        Fri, 17 Feb 2023 04:40:00 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pT01p-00064O-Fl; Fri, 17 Feb 2023 13:39:53 +0100
Message-ID: <f30eae62-c827-f743-acbe-867770714522@leemhuis.info>
Date:   Fri, 17 Feb 2023 13:39:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: Regression in Kernel 6.0: System partially freezes with "nvme
 controller is down"
Content-Language: en-US, de-DE
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Julian_Gro=c3=9f?= <julian.g@posteo.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230112164204.GA1768006@bhelgaas>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230112164204.GA1768006@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676637600;9ab0d86e;
X-HE-SMSGID: 1pT01p-00064O-Fl
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

I might be missing something, but it looks like this discussion stalled.
I wonder why.

Julian, did you ever share the data Bjorn asked for? Or tried a a
bisection, as suggested by Keith? Or did you stop caring for some
reason? Does everything maybe work fine these days?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 12.01.23 17:42, Bjorn Helgaas wrote:
> On Thu, Jan 12, 2023 at 03:48:46PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
>> ...
>> On 11.01.23 23:11, Julian Groß wrote:
>>> Dear Maintainer,
>>>
>>> when running Linux Kernel version 6.0.12, 6.0.10, 6.0-rc7, or 6.1.4, my
>>> system seemingly randomly freezes due to the file system being set to
>>> read-only due to an issue with my NVMe controller.
>>> The issue does *not* appear on Linux Kernel version 5.19.11 or lower.
>>>
>>> Through network logging I am able to catch the issue:
>>> ```
>>> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259288] nvme nvme0:
>>> controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
>>> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Does
>>> your device have a faulty power saving mode enabled?
>>> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Try
>>> "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
>>> Jan  8 14:50:16 x299-desktop kernel: [ 1461.331360] nvme 0000:01:00.0:
>>> enabling device (0000 -> 0002)
>>> ...
>>>
>>> I have tried the suggestion in the log without luck.
>>>
>>> Attached is a log that includes two system freezes, as well as a list of
>>> PCI(e) devices created by Debian reportbug.
>>> The first freeze happens at "Jan  8 04:26:28" and the second freeze
>>> happens at "Jan  8 14:50:16".
>>>
>>> Currently, I am using git bisect to narrow down the window of possible
>>> commits, but since the issue appears seemingly random, it will take many
>>> months to identify the offending commit this way.
>>>
>>> The original Debian bug report is here:
>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1028309
> 
> For some reason the log [1] has very little of the kernel dmesg log.
> It does seem like the freeze is partial (I see messages for hundreds
> or thousands of seconds after the nvme reset), but requires a reboot
> to recover.
> 
> The lspci information [2] shows the 00:1b.0 Root Port leading to the
> 01:00.0 NVMe device.
> 
> Is it possible to collect lspci output after the nvme freeze?  If so,
> please save the output of:
> 
>   sudo lspci -vv -s00:1b.0
>   sudo lspci -vv -s01:00.0
> 
> Make sure to run lspci as root so we can see the error logging
> registers for these devices.
> 
> If you can collect more of the dmesg log after the freeze, e.g., via
> the "dmesg" command, that might be helpful, too.
> 
> Bjorn
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1028309;filename=x299-desktop_crash.log.xz;msg=5
> [2] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=0;bug=1028309;msg=5
> 
> 
