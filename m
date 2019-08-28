Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B720A05B5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfH1PIM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 11:08:12 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48217 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfH1PIM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 11:08:12 -0400
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C528920225535;
        Wed, 28 Aug 2019 17:08:08 +0200 (CEST)
Subject: Re: /proc/vmcore and wrong PAGE_OFFSET
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
References: <c42060b0-12ae-d170-9ad4-03d85919948c@molgen.mpg.de>
Cc:     horms@verge.net.au, kexec@lists.infradead.org
Message-ID: <b208dccd-63d9-e902-28e1-3a6cb44f082f@molgen.mpg.de>
Date:   Wed, 28 Aug 2019 17:08:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c42060b0-12ae-d170-9ad4-03d85919948c@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/20/19 11:21 PM, Donald Buczek wrote:
> Dear Linux folks,
> 
> I'm investigating a problem, that the crash utility fails to work with our crash dumps:
> 
>      buczek@kreios:/mnt$ crash vmlinux crash.vmcore
>      crash 7.2.6
>      Copyright (C) 2002-2019  Red Hat, Inc.
>      Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
>      Copyright (C) 1999-2006  Hewlett-Packard Co
>      Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
>      Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
>      Copyright (C) 2005, 2011  NEC Corporation
>      Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
>      Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
>      This program is free software, covered by the GNU General Public License,
>      and you are welcome to change it and/or distribute copies of it under
>      certain conditions.  Enter "help copying" to see the conditions.
>      This program has absolutely no warranty.  Enter "help warranty" for details.
>      GNU gdb (GDB) 7.6
>      Copyright (C) 2013 Free Software Foundation, Inc.
>      License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
>      This is free software: you are free to change and redistribute it.
>      There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
>      and "show warranty" for details.
>      This GDB was configured as "x86_64-unknown-linux-gnu"...
>      crash: read error: kernel virtual address: ffff89807ff77000  type: "memory section root table"
> 
> The crash file is a copy of /dev/vmcore taken by a crashkernel after a sysctl-forced panic.
> 
> It looks to me, that  0xffff89807ff77000 is not readable, because the virtual addresses stored in the elf header of the dump file are off by 0x0000008000000000:
> 
>      buczek@kreios:/mnt$ readelf -a crash.vmcore | grep LOAD | perl -lane 'printf "%s (%016x)\n",$_,hex($F[2])-hex($F[3])'
>        LOAD           0x000000000000d000 0xffffffff81000000 0x000001007d000000 (fffffeff04000000)
>        LOAD           0x0000000001c33000 0xffff880000001000 0x0000000000001000 (ffff880000000000)
>        LOAD           0x0000000001cc1000 0xffff880000090000 0x0000000000090000 (ffff880000000000)
>        LOAD           0x0000000001cd1000 0xffff880000100000 0x0000000000100000 (ffff880000000000)
>        LOAD           0x0000000001cd2070 0xffff880000100070 0x0000000000100070 (ffff880000000000)
>        LOAD           0x0000000019bd2000 0xffff880038000000 0x0000000038000000 (ffff880000000000)
>        LOAD           0x000000004e6a1000 0xffff88006ffff000 0x000000006ffff000 (ffff880000000000)
>        LOAD           0x000000004e6a2000 0xffff880100000000 0x0000000100000000 (ffff880000000000)
>        LOAD           0x0000001fcda22000 0xffff882080000000 0x0000002080000000 (ffff880000000000)
>        LOAD           0x0000003fcd9a2000 0xffff884080000000 0x0000004080000000 (ffff880000000000)
>        LOAD           0x0000005fcd922000 0xffff886080000000 0x0000006080000000 (ffff880000000000)
>        LOAD           0x0000007fcd8a2000 0xffff888080000000 0x0000008080000000 (ffff880000000000)
>        LOAD           0x0000009fcd822000 0xffff88a080000000 0x000000a080000000 (ffff880000000000)
>        LOAD           0x000000bfcd7a2000 0xffff88c080000000 0x000000c080000000 (ffff880000000000)
>        LOAD           0x000000dfcd722000 0xffff88e080000000 0x000000e080000000 (ffff880000000000)
>        LOAD           0x000000fc4d722000 0xffff88fe00000000 0x000000fe00000000 (ffff880000000000)
> 
> (Columns are File offset, Virtual Address, Physical Address and computed offset).
> 
> I would expect the offset between the virtual and the physical address to be PAGE_OFFSET, which is 0xffff88800000000 on x86_64, not 0xffff880000000000. Unlike /proc/vmcore, /proc/kcore shows the same physical memory (of the last memory section above) with a correct offset:
> 
>      buczek@kreios:/mnt$ sudo readelf -a /proc/kcore | grep 0x000000fe00000000 | perl -lane 'printf "%s (%016x)\n",$_,hex($F[2])-hex($F[3])'
>        LOAD           0x0000097e00004000 0xffff897e00000000 0x000000fe00000000 (ffff888000000000)
> 
> The failing address 0xffff89807ff77000 happens to be at the end of the last memory section. It is the mem_section array, which crash wants to load and which is visible in the running system:
> 
>      buczek@kreios:/mnt$ sudo gdb vmlinux /proc/kcore
>      [...]
>      (gdb) print mem_section
>      $1 = (struct mem_section **) 0xffff89807ff77000
>      (gdb) print *mem_section
>      $2 = (struct mem_section *) 0xffff88a07f37b000
>      (gdb) print **mem_section
>      $3 = {section_mem_map = 18446719884453740551, pageblock_flags = 0xffff88a07f36f040}
> 
> I can read the same information from the crash dump, if I account for the 0x0000008000000000 error:
> 
>      buczek@kreios:/mnt$ gdb vmlinux crash.vmcore
>      [...]
>      (gdb) print mem_section
>      $1 = (struct mem_section **) 0xffff89807ff77000
>      (gdb) print *mem_section
>      Cannot access memory at address 0xffff89807ff77000
>      (gdb) set $t=(struct mem_section **) ((char *)mem_section - 0x0000008000000000)
>      (gdb) print *$t
>      $2 = (struct mem_section *) 0xffff88a07f37b000
>      (gdb) set $s=(struct mem_section *)((char *)*$t - 0x0000008000000000 )
>      (gdb) print *$s
>      $3 = {section_mem_map = 18446719884453740551, pageblock_flags = 0xffff88a07f36f040}
> 
> In the above example, the running kernel, the crashed kernel and the crashkernel are all the same 4.19.57 compilation. But I've tried with several other versions ( crashkernel 4.4, running kernel from 4.0 to linux master) with the same result.
> 
> The machine in the above example has several numa nodes (this is why there are so many LOAD headers). But I've tried this with a small kvm virtual machine and got the same result.
> 
>      buczek@kreios:/mnt/linux-4.19.57-286.x86_64/build$ grep RANDOMIZE_BASE .config
>      # CONFIG_RANDOMIZE_BASE is not set
>      buczek@kreios:/mnt/linux-4.19.57-286.x86_64/build$ grep SPARSEMEM .config
>      CONFIG_ARCH_SPARSEMEM_ENABLE=y
>      CONFIG_ARCH_SPARSEMEM_DEFAULT=y
>      CONFIG_SPARSEMEM_MANUAL=y
>      CONFIG_SPARSEMEM=y
>      CONFIG_SPARSEMEM_EXTREME=y
>      CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
>      CONFIG_SPARSEMEM_VMEMMAP=y
>      buczek@kreios:/mnt/linux-4.19.57-286.x86_64/build$ grep PAGE_TABLE_ISOLATION .config
>      CONFIG_PAGE_TABLE_ISOLATION=y
> 
> Any ideas?
> 
> Donald

To answer my own question for the records:

Our kexec command line is

     /usr/sbin/kexec -p /boot/bzImage.crash --initrd=/boot/grub/initramfs.igz --command-line="root=LABEL=root ro console=ttyS1,115200n8 console=tty0 irqpoll nr_cpus=1 reset_devices panic=5 CRASH"

So we neither gave -s (--kexec-file-syscall) nor -a ( --kexec-syscall-auto ). For this reason, kexec used the kexec_load() syscall instead of the newer kexec_file_load syscall.

With kexec_load(), the elf headers for the crash, which include program header for the old system ram, are not computed by the kernel, but by the userspace program from kexec-tools.

Linux kernel commit d52888aa ("x86/mm: Move LDT remap out of KASLR region on 5-level paging") changed the base of the direct mapping from 0xffff880000000000 to 0xffff888000000000. This was merged into v4.20-rc2.

kexec-tools, however, still has the old address hard coded:

     buczek@avaritia:/scratch/cluster/buczek/kexec-tools (master)$ git grep X86_64_PAGE_OFFSET
     kexec/arch/i386/crashdump-x86.c:                        elf_info->page_offset = X86_64_PAGE_OFFSET_PRE_2_6_27;
     kexec/arch/i386/crashdump-x86.c:                        elf_info->page_offset = X86_64_PAGE_OFFSET;
     kexec/arch/i386/crashdump-x86.h:#define X86_64_PAGE_OFFSET_PRE_2_6_27   0xffff810000000000ULL
     kexec/arch/i386/crashdump-x86.h:#define X86_64_PAGE_OFFSET              0xffff880000000000ULL

Best
   Donald
