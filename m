Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C86AD989
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 09:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCGIts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 03:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCGIto (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 03:49:44 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A46C27982;
        Tue,  7 Mar 2023 00:49:39 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pZT0r-0001iT-2m; Tue, 07 Mar 2023 09:49:37 +0100
Message-ID: <fcd30d9e-f391-fe1d-4c09-4691e50e41a8@leemhuis.info>
Date:   Tue, 7 Mar 2023 09:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Szymon Janc <szymon.janc@gmail.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 217106 - Null pointer dereference on dock unplug
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678178980;cbb64792;
X-HE-SMSGID: 1pZT0r-0001iT-2m
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by mail.

To quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217106 :

>  Szymon Janc 2023-03-01 08:16:51 UTC
> 
> On Lenovo Thinkpad X1 when unplugging from Lenovo ThinkPad Thunderbolt 4 dock I get NULL pointer dereference in kernel and system freezes. This is 100% reproducible.
> 
> I'm using Fedora 37 and I don't recall this happen while on 6.0 kernel.
> 
> Attaching photo with kernel log.

See the ticket for more details.

I was a bit unsure whom to forward this to. Heikki, in the end I chose
you. If I chose poorly, please let me known who might be a better choice.

I as usual checked the net for existing reports. And it seems there are
a few:

 * also since 6.1:
https://bbs.archlinux.org/viewtopic.php?id=283562
https://discussion.fedoraproject.org/t/system-freezes-after-pull-usb-mass-storage/70844

 * since 5.19:
https://bugs.archlinux.org/task/75666 (since 5.19)
https://groups.google.com/g/linux.debian.kernel/c/tZSzgRoxZu0?pli=1

 * unknown kernel (I suspect 5.19 from ubuntu):
https://gitlab.gnome.org/GNOME/gnome-shell/-/issues/6001

Many of them (maybe all?) seem to happen on Thinkpads. For
searchability, here is a trace from
https://bbs.archlinux.org/viewtopic.php?id=283562 that looks somewhat
similar to the one from above bugzilla ticket:

> Feb 14 23:30:35 <hostname> kernel: usb 3-5: USB disconnect, device number 14 
> Feb 14 23:30:36 <hostname> kernel: BUG: kernel NULL pointer dereference, address: 0000000000000030
> Feb 14 23:30:36 <hostname> kernel: #PF: supervisor write access in kernel mode
> Feb 14 23:30:36 <hostname> kernel: #PF: error_code(0x0002) - not-present page
> Feb 14 23:30:36 <hostname> kernel: PGD 0 P4D 0  
> Feb 14 23:30:36 <hostname> kernel: Oops: 0002 [#1] PREEMPT SMP NOPTI
> Feb 14 23:30:36 <hostname> kernel: CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.1.11-arch1-1 #1 a4e1ab564378dba05cc0d5c9f99dce3dc67f88f0
> Feb 14 23:30:36 <hostname> kernel: Hardware name: LENOVO 21BWS37K00/21BWS37K00, BIOS N3MET11W (1.10 ) 12/07/2022
> Feb 14 23:30:36 <hostname> kernel: Workqueue: kacpi_notify acpi_os_execute_deferred
> Feb 14 23:30:36 <hostname> kernel: RIP: 0010:queue_work_on+0x19/0x50
> Feb 14 23:30:36 <hostname> kernel: Code: ff e9 c5 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44 00 00 53 9c 58 0f 1f 40 00 48 89 c3 fa 0f 1f 44 00 00 <f0> 48 0f ba 2a 00 73 15 31 c9 80 e7 02 74 06 fb 0f 1f >
> Feb 14 23:30:36 <hostname> kernel: RSP: 0000:ffffbd07400ffe38 EFLAGS: 00010006
> Feb 14 23:30:36 <hostname> kernel: RAX: 0000000000000206 RBX: 0000000000000206 RCX: 0000000000000000
> Feb 14 23:30:36 <hostname> kernel: RDX: 0000000000000030 RSI: ffff9f5a80051000 RDI: 0000000000000140
> Feb 14 23:30:36 <hostname> kernel: RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000080380026
> Feb 14 23:30:36 <hostname> kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff9f61bf43ba00
> Feb 14 23:30:36 <hostname> kernel: R13: 0000000000000000 R14: ffff9f5a80212b40 R15: ffff9f5a86468c98
> Feb 14 23:30:36 <hostname> kernel: FS:  0000000000000000(0000) GS:ffff9f61bf400000(0000) knlGS:0000000000000000
> Feb 14 23:30:36 <hostname> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Feb 14 23:30:36 <hostname> kernel: CR2: 0000000000000030 CR3: 00000004d8210001 CR4: 0000000000f70ef0
> Feb 14 23:30:36 <hostname> kernel: PKRU: 55555554
> Feb 14 23:30:36 <hostname> kernel: Call Trace:
> Feb 14 23:30:36 <hostname> kernel:  <TASK>
> Feb 14 23:30:36 <hostname> kernel:  ucsi_acpi_notify+0xac/0xc0 [ucsi_acpi 9c6a23f21d3ec74e5573e3e6b769395c9b0898ad]
> Feb 14 23:30:36 <hostname> kernel:  acpi_ev_notify_dispatch+0x4b/0x63
> Feb 14 23:30:36 <hostname> kernel:  acpi_os_execute_deferred+0x17/0x30
> Feb 14 23:30:36 <hostname> kernel:  process_one_work+0x1c4/0x380
> Feb 14 23:30:36 <hostname> kernel:  worker_thread+0x51/0x390
> Feb 14 23:30:36 <hostname> kernel:  ? rescuer_thread+0x3b0/0x3b0
> Feb 14 23:30:36 <hostname> kernel:  kthread+0xdb/0x110
> Feb 14 23:30:36 <hostname> kernel:  ? kthread_complete_and_exit+0x20/0x20
> Feb 14 23:30:36 <hostname> kernel:  ret_from_fork+0x1f/0x30
> Feb 14 23:30:36 <hostname> kernel:  </TASK>
> Feb 14 23:30:36 <hostname> kernel: Modules linked in: tls authenc echainiv esp4 ccm rfcomm snd_seq_dummy snd_hrtimer snd_seq cmac algif_hash algif_skcipher af_alg r8153_ecm cdc_ether usbnet r8152 mii snd_usb_audio snd_usbmi>
> Feb 14 23:30:36 <hostname> kernel:  snd_soc_core snd_compress ac97_bus iwlmvm intel_tcc_cooling snd_pcm_dmaengine x86_pkg_temp_thermal i915 intel_powerclamp snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi hid_multitouch c>
> Feb 14 23:30:36 <hostname> kernel:  i2c_hid int3400_thermal intel_hid acpi_tad acpi_pad wmi acpi_thermal_rel sparse_keymap mac_hid crypto_user fuse ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor raid6>
> Feb 14 23:30:36 <hostname> kernel: CR2: 0000000000000030
> Feb 14 23:30:36 <hostname> kernel: ---[ end trace 0000000000000000 ]---
> Feb 14 23:30:36 <hostname> kernel: RIP: 0010:queue_work_on+0x19/0x50
> Feb 14 23:30:36 <hostname> kernel: Code: ff e9 c5 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44 00 00 53 9c 58 0f 1f 40 00 48 89 c3 fa 0f 1f 44 00 00 <f0> 48 0f ba 2a 00 73 15 31 c9 80 e7 02 74 06 fb 0f 1f >
> Feb 14 23:30:36 <hostname> kernel: RSP: 0000:ffffbd07400ffe38 EFLAGS: 00010006
> Feb 14 23:30:36 <hostname> kernel: RAX: 0000000000000206 RBX: 0000000000000206 RCX: 0000000000000000
> Feb 14 23:30:36 <hostname> kernel: RDX: 0000000000000030 RSI: ffff9f5a80051000 RDI: 0000000000000140
> Feb 14 23:30:36 <hostname> kernel: RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000080380026
> Feb 14 23:30:36 <hostname> kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff9f61bf43ba00
> Feb 14 23:30:36 <hostname> kernel: R13: 0000000000000000 R14: ffff9f5a80212b40 R15: ffff9f5a86468c98
> Feb 14 23:30:36 <hostname> kernel: FS:  0000000000000000(0000) GS:ffff9f61bf400000(0000) knlGS:0000000000000000
> Feb 14 23:30:36 <hostname> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Feb 14 23:30:36 <hostname> kernel: CR2: 0000000000000030 CR3: 00000004d8210001 CR4: 0000000000f70ef0
> Feb 14 23:30:36 <hostname> kernel: PKRU: 55555554


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.0..v6.1
https://bugzilla.kernel.org/show_bug.cgi?id=217106
#regzbot title: usb: null pointer dereference on dock unplug
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
