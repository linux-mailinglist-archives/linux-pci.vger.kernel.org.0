Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF0C4AD81E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 13:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbiBHMDx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 07:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiBHMDw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 07:03:52 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312DC03FEC0;
        Tue,  8 Feb 2022 04:03:51 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nHPDo-00048U-9h; Tue, 08 Feb 2022 13:03:48 +0100
Message-ID: <31603144-edec-df2d-fb46-283692c67420@leemhuis.info>
Date:   Tue, 8 Feb 2022 13:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-BS
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
References: <b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: 100 ms boot time increase regression in
 acpi_init()/acpi_scan_bus()
In-Reply-To: <b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1644321831;57ba252d;
X-HE-SMSGID: 1nHPDo-00048U-9h
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

Top-posting for once, to make this easy accessible to everyone.

@Rafael or any other @acpi/@pm developer: what's the status here?
Neither in this thread nor in the bug ticket anything happened afaics.
Or is a 100ms boot time increase considered "not a regression"?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot poke

On 10.01.22 12:29, Paul Menzel wrote:
> #regzbot introduced: v5.13..v5.14-rc1
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215419
> 
> 
> Dear Linux folks,
> 
> 
> On the Intel T4500 laptop Acer TravelMate 5735Z with Debian
> sid/unstable, there is a 100 ms introduced between Linux 5.10.46 and
> 5.13.9, and is still present in Linux 5.15.5.
> 
>     [    0.000000] microcode: microcode updated early to revision 0xa0b,
> date = 2010-09-28
>     [    0.000000] Linux version 5.15.0-2-amd64
> (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-13) 11.2.0, GNU
> ld (GNU Binutils for Debian) 2.37) #1 SMP Debian 5.15.5-2 (2021-12-18)
>     [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.15.0-2-amd64
> root=UUID=e17cec4f-d2b8-4cc3-bd39-39a10ed422f4 ro quiet noisapnp
> cryptomgr.notests random.trust_cpu=on initcall_debug log_buf_len=4M
>     […]
>     [    0.262243] calling  acpi_init+0x0/0x487 @ 1
>     […]
>     [    0.281655] ACPI: Enabled 15 GPEs in block 00 to 3F
>     [    0.394855] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>     […]
>     [    0.570908] initcall acpi_init+0x0/0x487 returned 0 after 300781
> usecs
> 
> I attached all the log files to the Kernel.org Bugzilla bug report
> #215419 [1].
> 
> Unfortunately, I am unable to bisect the issue, as it’s not my machine,
> and I do not have a lot of access to it.
> 
> Using ftrace, unfortunately, I didn’t save all of them, I think the path is
> 
>     acpi_init() → acpi_scan_init() → acpi_bus_scan(ACPI_ROOT_OBJECT)
> 
> But this path hasn’t changed as far as I can see. Anyway, from that
> path, somehow
> 
>     acpi_bus_check_add_1() → acpi_bus_check_add() → … →
> acpi_bus_check_add() → acpi_add_single_object() → acpi_bus_get_status()
> 
> is called, and the `acpi_bus_get_status()` call takes 100 ms on the
> system – also the cause for bug #208705 [2] –, but that code path wasn’t
> taken before.
> 
> Do you know from the top of your head, what changed? I am going to have
> short access to the system every two weeks or so, so debugging is
> unfortunately quite hard.
> 
> What is already on my to-do list:
> 
> 1.  Use dynamic debug `drivers/acpi/scan.c`
> 2.  Trace older Linux kernel (5.10.46) to see the differences
> 3.  Booting some GNU/Linux system to test 5.11 (Ubuntu 20.10) and 5.12
> 4.  Unrelated to the regression, but trace `acpi_bus_get_status()` to
> understand the 100 ms delay to solve bug #208705 [2]
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> PS: Do you know of GNU/Linux live systems that are available for all
> Linux kernel releases and have an initrd, that just stores/uploads the
> output of `dmesg`?
> 
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=215419
>      "100 ms regression in boottime before `ACPI: PCI Root Bridge [PCI0]"
> [2]: https://bugzilla.kernel.org/show_bug.cgi?id=208705
>      "boot performance: 100 ms delay in PCI initialization - Acer
> TravelMate 5735Z"
> 
> 
