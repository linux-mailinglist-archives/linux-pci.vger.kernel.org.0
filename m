Return-Path: <linux-pci+bounces-1527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A112C81FC2F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 01:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D310E1C2139B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 00:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEF619A;
	Fri, 29 Dec 2023 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6LHx1w/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C61FA8;
	Fri, 29 Dec 2023 00:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9601AC433C8;
	Fri, 29 Dec 2023 00:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703809585;
	bh=BJohCkA7YHahiDrFNqp4Y7hVOiO71OJmxBQI+pKm+dQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b6LHx1w/cWwRmwoEuzQfGeJOS+0IHMLb8w5VDV6bmYA3yeLCOPBwMUYvWR7Weq1Mb
	 kCESzKnHq3H6YH+NSpi76Da1qUQwszdrNj46tccUZaPR1Z867Fra5EgrwmMa9FgWBX
	 ztyaFKjgs8ywraiT0HCUPakwatG0pT9Jyb8nD+XxI8tDWfddkDCNG4b/6bOsZy1QuB
	 VwvJCA+JPwsc5acNVd4X3vxihOvja6M2vqJSndt8AVNKFmQTn/CABZdaUzFIRrwnRS
	 y+499xMnwR5lSUA+1uNfQ/V+cCV4rAUORL96bNdURCHMkiz9awBZJejf08In72w31b
	 800QgfV56OiRQ==
Date: Thu, 28 Dec 2023 18:26:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Schaller <michael@5challer.de>
Cc: bhelgaas@google.com, kai.heng.feng@canonical.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, macro@orcam.me.uk,
	ajayagarwal@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	gregkh@linuxfoundation.org, hkallweit1@gmail.com,
	michael.a.bottini@linux.intel.com, johan+linaro@kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
Message-ID: <20231229002623.GA1560896@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de>

[+cc David (more details at
https://lore.kernel.org/r/76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de)]

Hi Michael, thank you very much for debugging and reporting this!
Sorry for the major inconvenience.

On Mon, Dec 25, 2023 at 07:29:02PM +0100, Michael Schaller wrote:
> Issue:
> On resume from suspend to RAM there is no output for about 12 seconds, then
> shortly a blinking cursor is visible in the upper left corner on an
> otherwise black screen which is followed by a reboot.
> 
> Setup:
> * Machine: ASUS mini PC PN51-BB757MDE1 (DMI model: MINIPC PN51-E1)
> * Firmware: 0508 (latest; also tested previous 0505)
> * OS: Ubuntu 23.10 (except kernel)
> * Kernel: 6.6.8 (also tested 6.7-rc7; config attached)
> 
> Debugging summary:
> * Kernel 5.10.205 isn’t affected.
> * Bisect identified commit 08d0cc5f34265d1a1e3031f319f594bd1970976c as
> cause.

#regzbot introduced: 08d0cc5f3426^

> * PCI device 0000:03:00.0 (Intel 8265 Wifi) causes resume issues as long as
> ASPM is enabled (default).
> * The commit message indicates that a quirk could be written to mitigate the
> issue but I don’t know how to write such a quirk.
> 
> Confirmed workarounds:
> * Connect a USB flash drive (no clue why; maybe this causes a delay that
> lets the resume succeed)
> * Revert commit 08d0cc5f34265d1a1e3031f319f594bd1970976c (commit seemed
> intentional; a quirk seems to be the preferred solution)
> * pcie_aspm=off
> * pcie_aspm.policy=performance
> * echo 0 | sudo tee /sys/bus/pci/devices/0000:03:00.0/link/l1_aspm
> 
> Debugging details:
> * The resume trigger (power button, keyboard, mouse) doesn’t seem to make
> any difference.
> * Double checked that the kernel is configured to *not* reboot on panic.
> * Double checked that there still isn't any kernel output without quiet and
> splash.
> * The issue doesn’t happen if a USB flash drive is connected. The content of
> the flash drive doesn’t appear to matter. The USB port doesn’t appear to
> matter.
> * No information in any logs after the reboot. I suspect the resume from
> suspend to RAM isn’t getting far enough as that logs could be written.
> * Kernel 5.10.205 isn’t affected. Kernel 5.15.145, 6.6.8 and 6.7-rc7 are
> affected.
> * A kernel bisect has revealed the following commit as cause:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=08d0cc5f34265d1a1e3031f319f594bd1970976c
> * The commit was part of kernel 5.20 and has been backported to 5.15.
> * The commit mentions that a device-specific quirk could be added in case of
> new issues.
> * According to sysfs and lspci only device 0000:03:00.0 (Intel 8265 Wifi)
> has ASPM enabled by default.
> * Disabling ASPM for device 0000:03:00.0 lets the resume from suspend to RAM
> succeed.
> * Enabling ASPM for all devices except 0000:03:00.0 lets the resume from
> suspend to RAM succeed.
> * This would indicate that a quirk is missing for the device 0000:03:00.0
> (Intel 8265 Wifi) but I have no clue how to write such a quirk or how to get
> the specifics for such a quirk.
> * I still have no clue how a USB flash drive plays into all this. Maybe some
> kind of a timing issue where the connected USB flash drive delays something
> long enough so that the resume succeeds. Maybe the code removed by commit
> 08d0cc5f34265d1a1e3031f319f594bd1970976c caused a similar delay. ¯\_(ツ)_/¯

We have some known issues with saving and restoring ASPM state on
suspend/resume, in particular with ASPM L1 Substates, which are
enabled on this device.

David Box has a patch in the works that should fix one of those
issues:
https://lore.kernel.org/r/20231221011250.191599-1-david.e.box@linux.intel.com

It's not merged yet, but it's possible it might fix or at least be
related to this.  If you try it out, please let us know what happens.

> 03:00.0 Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
> 	Capabilities: [40] Express (v2) Endpoint, MSI 00
> 		LnkCap:	Port #6, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L1 <8us
> 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
> 		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
> 			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> 	Capabilities: [14c v1] Latency Tolerance Reporting
> 		Max snoop latency: 1048576ns
> 		Max no snoop latency: 1048576ns
> 	Capabilities: [154 v1] L1 PM Substates
> 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> 			  PortCommonModeRestoreTime=30us PortTPowerOnTime=18us
> 		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> 			   T_CommonMode=0us LTR1.2_Threshold=186368ns
> 		L1SubCtl2: T_PwrOn=150us

> $ grep -F '' /sys/bus/pci/devices/*/link/*pm
> /sys/bus/pci/devices/0000:03:00.0/link/clkpm:1
> /sys/bus/pci/devices/0000:03:00.0/link/l1_1_aspm:1
> /sys/bus/pci/devices/0000:03:00.0/link/l1_1_pcipm:1
> /sys/bus/pci/devices/0000:03:00.0/link/l1_2_aspm:1
> /sys/bus/pci/devices/0000:03:00.0/link/l1_2_pcipm:1
> /sys/bus/pci/devices/0000:03:00.0/link/l1_aspm:1
> /sys/bus/pci/devices/0000:04:00.0/link/clkpm:0
> ...

