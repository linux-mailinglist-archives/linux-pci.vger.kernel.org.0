Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64816489772
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 12:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbiAJLad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 06:30:33 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:47375 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244760AbiAJL3t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jan 2022 06:29:49 -0500
Received: from [192.168.0.5] (ip5f5aece2.dynamic.kabel-deutschland.de [95.90.236.226])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 879DE61E5FE02;
        Mon, 10 Jan 2022 12:29:44 +0100 (CET)
Message-ID: <b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de>
Date:   Mon, 10 Jan 2022 12:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: 100 ms boot time increase regression in acpi_init()/acpi_scan_bus()
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

#regzbot introduced: v5.13..v5.14-rc1
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215419


Dear Linux folks,


On the Intel T4500 laptop Acer TravelMate 5735Z with Debian 
sid/unstable, there is a 100 ms introduced between Linux 5.10.46 and 
5.13.9, and is still present in Linux 5.15.5.

     [    0.000000] microcode: microcode updated early to revision 
0xa0b, date = 2010-09-28
     [    0.000000] Linux version 5.15.0-2-amd64 
(debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-13) 11.2.0, GNU 
ld (GNU Binutils for Debian) 2.37) #1 SMP Debian 5.15.5-2 (2021-12-18)
     [    0.000000] Command line: 
BOOT_IMAGE=/boot/vmlinuz-5.15.0-2-amd64 
root=UUID=e17cec4f-d2b8-4cc3-bd39-39a10ed422f4 ro quiet noisapnp 
cryptomgr.notests random.trust_cpu=on initcall_debug log_buf_len=4M
     […]
     [    0.262243] calling  acpi_init+0x0/0x487 @ 1
     […]
     [    0.281655] ACPI: Enabled 15 GPEs in block 00 to 3F
     [    0.394855] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
     […]
     [    0.570908] initcall acpi_init+0x0/0x487 returned 0 after 300781 
usecs

I attached all the log files to the Kernel.org Bugzilla bug report 
#215419 [1].

Unfortunately, I am unable to bisect the issue, as it’s not my machine, 
and I do not have a lot of access to it.

Using ftrace, unfortunately, I didn’t save all of them, I think the path is

     acpi_init() → acpi_scan_init() → acpi_bus_scan(ACPI_ROOT_OBJECT)

But this path hasn’t changed as far as I can see. Anyway, from that 
path, somehow

     acpi_bus_check_add_1() → acpi_bus_check_add() → … → 
acpi_bus_check_add() → acpi_add_single_object() → acpi_bus_get_status()

is called, and the `acpi_bus_get_status()` call takes 100 ms on the 
system – also the cause for bug #208705 [2] –, but that code path wasn’t 
taken before.

Do you know from the top of your head, what changed? I am going to have 
short access to the system every two weeks or so, so debugging is 
unfortunately quite hard.

What is already on my to-do list:

1.  Use dynamic debug `drivers/acpi/scan.c`
2.  Trace older Linux kernel (5.10.46) to see the differences
3.  Booting some GNU/Linux system to test 5.11 (Ubuntu 20.10) and 5.12
4.  Unrelated to the regression, but trace `acpi_bus_get_status()` to 
understand the 100 ms delay to solve bug #208705 [2]


Kind regards,

Paul


PS: Do you know of GNU/Linux live systems that are available for all 
Linux kernel releases and have an initrd, that just stores/uploads the 
output of `dmesg`?


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=215419
      "100 ms regression in boottime before `ACPI: PCI Root Bridge [PCI0]"
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=208705
      "boot performance: 100 ms delay in PCI initialization - Acer 
TravelMate 5735Z"
