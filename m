Return-Path: <linux-pci+bounces-1586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1F68214ED
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 19:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D85D281BDF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD47C12B;
	Mon,  1 Jan 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j52jHwRY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD712C2EE;
	Mon,  1 Jan 2024 18:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0FCC433C8;
	Mon,  1 Jan 2024 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704132830;
	bh=hhp2PoiaJ8C7NYym9a0J8DEeSWibrTvYe4eEPHl4oZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=j52jHwRY+jAc4dZQmyQpxYtwHqlw0+N9FQs3c/+a+wav3nEDn/dZ5D9B4V8m3wjgt
	 jOu4r/+2q6d+IhZJJVteqKKhHByNNwVrL6pTrE3C4nFBv4Nb6PNDa2MkWez+U1t6k7
	 hskiNkgVG70edF9rNnDGmupfa0L0Ei3rBBz1fvlLws4aAAgF2wfT6Kc3w+EcDgBiR3
	 IhgYDzi1WfOAaDYVeDyTmbU6H5vD/9AaLignM0275sBGWIcrVQ+0no9KOY4Tqrx4EJ
	 +Mw6SywsCYgeaoyvMTK4Saqx2ctBffXBQDhgkqVNWADEqm1o/mazvBCFG5c4SV8rza
	 Zmu6Bza1MRXXQ==
Date: Mon, 1 Jan 2024 12:13:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Schaller <michael@5challer.de>
Cc: bhelgaas@google.com, kai.heng.feng@canonical.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, macro@orcam.me.uk,
	ajayagarwal@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	gregkh@linuxfoundation.org, hkallweit1@gmail.com,
	michael.a.bottini@linux.intel.com, johan+linaro@kernel.org
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
Message-ID: <20240101181348.GA1684058@bhelgaas>
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

Hmmm.  08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
appeared in v6.0, released Oct 2, 2022, so it's been there a while.

But I think the best option is to revert it until this issue is
resolved.  Per the commit log, 08d0cc5f3426 solved two problems:

  1) ASPM config changes done via sysfs are lost if the device power
     state is changed, e.g., typically set to D3hot in .suspend() and
     D0 in .resume().

  2) If L1SS is restored during system resume, that restored state
     would be overwritten.

Problem 2) relates to a patch that is currently reverted (a7152be79b62
("Revert "PCI/ASPM: Save L1 PM Substates Capability for
suspend/resume""), so I don't think reverting 08d0cc5f3426 will make
this problem worse.

Reverting 08d0cc5f3426 will make 1) a problem again.  But my guess is
ASPM changes via sysfs are fairly unusual and the device probably
remains functional even though it may use more power because the ASPM
configuration was lost.

So unless somebody has a counter-argument, I plan to queue a revert of
08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") for
v6.7.

Bjorn

