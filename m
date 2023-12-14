Return-Path: <linux-pci+bounces-1024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B8D813D17
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 23:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A7B2838D0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 22:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21998671E8;
	Thu, 14 Dec 2023 22:14:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138C2C690;
	Thu, 14 Dec 2023 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.17.2/8.17.2) with ESMTPS id 3BEMDRxF011590
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 15 Dec 2023 08:43:28 +1030
Date: Fri, 15 Dec 2023 08:43:27 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Igor Mammedov <imammedo@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Regression] Commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
References: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
 <20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Thu, Dec 14, 2023 at 02:32:05PM +0100, Igor Mammedov wrote:
> On Thu, 14 Dec 2023 11:58:20 +1030 Jonathan Woithe wrote:
> > 
> > Following an update from 5.15.72 to 5.15.139 on one of my machines, the
> 
> looks like you are running downstream kernel, can you file bug report
> with distro that you use (with a link posed here as well).

I am running Slackware64 15.0.  The kernels supplied by that distribution
are unmodified kernel.org kernels.

> For now offending patches are being reverted, so downstream bug will help
> with tracking it and reverting it there. 

The patches will be reverted in Slackware as a matter of course when a
kernel.org "-stable" kernel with the fix is adopted.  Slackware does not
apply any patches to kernel.org kernels.  Nevertheless, I will raise a post
in the forum, hopefully later today.

> > console froze part way through the boot process.  The machine still managed
> > to boot: it could be reached via the network and a keyboard-initiated
> > shutdown would do the right thing.  The problem was that the screen remained
> > static the whole time: the X login did not appear.  Only a reboot would
> > restore the display's functionality.
> > 
> > Comparing boot logs between these two kernels showed that 5.15.139 reported
> > the following messages not seen with 5.15.72:
> > 
> >     thunderbolt 0000:04:00.0: interrupt for TX ring 0 is already enabled
> >     WARNING: CPU: 0 PID: 713 at drivers/thunderbolt/nhi.c:139 ring_interrupt_active+0x218/0x270 [thunderbolt]
> > 
> >     thunderbolt 0000:04:00.0: interrupt for RX ring 0 is already enabled
> >     WARNING: CPU: 0 PID: 713 at drivers/thunderbolt/nhi.c:139 ring_interrupt_active+0x218/0x270 [thunderbolt]
> > 
> >     radeon 0000:4b:00.0: Fatal error during GPU init
> >     radeon: probe of 0000:4b:00.0 failed with error -12
> > 
> > The fatal error during GPU initialisation would be the reason behind the
> > frozen screen.  I don't know if the thunderbolt warnings are significant.
> > 
> > A git bisect resulted in the following report:
> > 
> >     d9ce077f8b1f731407e6b612b03bba464fd18d9b is the first bad commit
> >     commit d9ce077f8b1f731407e6b612b03bba464fd18d9b
> >     Author: Igor Mammedov <imammedo@redhat.com>
> >     Date:   Mon Apr 24 21:15:57 2023 +0200
> > 
> >         PCI: acpiphp: Reassign resources on bridge if necessary
> >     
> >         [ Upstream commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 ]
> > 
> > It's taken me a while to work through the bisect process due to limited
> > access to the machine concerned.  I see that in the last few days there have
> > been other reports associated with this commit.  The symptoms on my machine
> > are different to the other reporters.  In particular, I note that I'm
> > running the Linux kernel on bare metal.
> > 
> > For what it's worth, I also experienced the same problem when I tested 6.6.4
> > last week (the most recent kernel at the time of testing).
> > 
> > The output of lspci is given at the end of this post[1].  The CPU is an
> > "Intel(R) Core(TM) i7-5930K CPU @ 3.50GHz" which is not overclocked.  Please
> > let me know if you'd like more information about the affected machine.  I
> > can also perform additional tests if required, although for various reasons
> > these can only be done on Thursdays at present.
> > 
> > The kernel configuration file can easily be supplied if that would be
> > useful.
> 
> full dmesg log and used config might help down the road (preferably with current
> upstream kernel), as I will be looking into fixing related issues.
> 
> Perhaps a better way for taking this issue and collecting logs, will be
> opening a separate bug at https://bugzilla.kernel.org (pls CC me as well)

Sure, will do.  I'll be able to get the dmesg log from my earlier tests and
config easily enough.  Testing with another kernel will have to wait until
next Thursday as that is when I'll next have physical access to the machine.

Which upstream kernel would you like me to test with: the latest "-stable",
or the most recent release?

Regards
  jonathan

> > [1] lspci output
> > 
> > 00:00.0 Host bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2 (rev 02)
> > 00:01.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02)
> > 00:01.1 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02)
> > 00:03.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 3 (rev 02)
> > 00:05.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Address Map, VTd_Misc, System Management (rev 02)
> > 00:05.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Hot Plug (rev 02)
> > 00:05.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 RAS, Control Status and Global Errors (rev 02)
> > 00:11.0 Unassigned class [ff00]: Intel Corporation C610/X99 series chipset SPSR (rev 05)
> > 00:14.0 USB controller: Intel Corporation C610/X99 series chipset USB xHCI Host Controller (rev 05)
> > 00:16.0 Communication controller: Intel Corporation C610/X99 series chipset MEI Controller #1 (rev 05)
> > 00:19.0 Ethernet controller: Intel Corporation Ethernet Connection (2) I218-V (rev 05)
> > 00:1a.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #2 (rev 05)
> > 00:1b.0 Audio device: Intel Corporation C610/X99 series chipset HD Audio Controller (rev 05)
> > 00:1c.0 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #1 (rev d5)
> > 00:1c.3 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #4 (rev d5)
> > 00:1d.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #1 (rev 05)
> > 00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC Controller (rev 05)
> > 00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset 6-Port SATA Controller [AHCI mode] (rev 05)
> > 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller (rev 05)
> > 02:00.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > 03:00.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > 03:01.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > 03:02.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > 03:04.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > 04:00.0 System peripheral: Intel Corporation DSL6540 Thunderbolt 3 NHI [Alpine Ridge 4C 2015]
> > 49:00.0 USB controller: Intel Corporation DSL6540 USB 3.1 Controller [Alpine Ridge]
> > 4b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cedar [Radeon HD 5000/6000/7350/8350 Series]
> > 4b:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI Audio [Radeon HD 5400/6300/7300 Series]
> > 4d:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
> > ff:0b.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> > ff:0b.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> > ff:0b.2 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> > ff:0c.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > ff:0c.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > ff:0c.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > ff:0c.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > ff:0c.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > ff:0c.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > ff:0f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
> > ff:0f.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
> > ff:0f.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> > ff:0f.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> > ff:0f.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> > ff:10.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
> > ff:10.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
> > ff:10.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> > ff:10.6 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> > ff:10.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> > ff:12.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
> > ff:12.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
> > ff:13.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
> > ff:13.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
> > ff:13.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > ff:13.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > ff:13.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > ff:13.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > ff:13.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Channel 0/1 Broadcast (rev 02)
> > ff:13.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
> > ff:14.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 Thermal Control (rev 02)
> > ff:14.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 Thermal Control (rev 02)
> > ff:14.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 ERROR Registers (rev 02)
> > ff:14.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 ERROR Registers (rev 02)
> > ff:14.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > ff:14.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > ff:14.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > ff:14.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > ff:15.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 Thermal Control (rev 02)
> > ff:15.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 Thermal Control (rev 02)
> > ff:15.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 ERROR Registers (rev 02)
> > ff:15.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 ERROR Registers (rev 02)
> > ff:16.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Target Address, Thermal & RAS Registers (rev 02)
> > ff:16.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Channel 2/3 Broadcast (rev 02)
> > ff:16.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
> > ff:17.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Channel 0 Thermal Control (rev 02)
> > ff:17.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > ff:17.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > ff:17.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > ff:17.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > ff:1e.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > ff:1e.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > ff:1e.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > ff:1e.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > ff:1e.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > ff:1f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 VCU (rev 02)
> > ff:1f.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 VCU (rev 02)

