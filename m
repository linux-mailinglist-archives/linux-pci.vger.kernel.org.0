Return-Path: <linux-pci+bounces-2435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97900837157
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 19:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50CE28EE6B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C1B4D114;
	Mon, 22 Jan 2024 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbF57wLp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE24D10E;
	Mon, 22 Jan 2024 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947977; cv=none; b=m04GXNAyYGtrC+z93+dE6i2lm9nM8txf3aByv7nwd+ZbPTtupdfX1zU//SGHxgAVPeMO8dBDkGIr4or+50peMJZHqzP2mCnRLu7RsOZLTcif/sgejgmBac6rgeEFZxQts6soaL0HAWOZgTEBsDVtv2futT4qqzHorP/nAJSe/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947977; c=relaxed/simple;
	bh=xqaElstZ6Be2KexYuJuX9vmqnmJZ8Y7gmDJsiNOQ56Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wo/96XAL3APwKThy/wSaTZmAjibcnyquk1LWdobjDYwgPU4sCmVaCwsBOgK9XE2U2QL0NcOuTYtw0NmmNwpAjD++qSaJZxatxH6AVMhwoYq1xUAGqtzFctdh2onVX4zF/YcatYXWpZ81oBEGxYa4pkCKrvBHHAQtTQNo8X1n3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbF57wLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1769C433C7;
	Mon, 22 Jan 2024 18:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947977;
	bh=xqaElstZ6Be2KexYuJuX9vmqnmJZ8Y7gmDJsiNOQ56Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sbF57wLpzO4Po/5GpjgYQjSECzQjLbxSiNv/RKB8wRHfNNYDrfybv1BM0T+rwpu13
	 WXBW4KZf0YWrt1XaNQpp3Hl67mdkmKjBMm10UrSe1YtlB/jlWvemQbqfZuLtOPugV7
	 w7zmscDHsgJyt9pCLUdy4K+WKwdOJJpQ3FOQmgSkL2jGVV98ELA1IJyO15yK9on5jV
	 VC9xEDPpXQjYMabsXM2bkSsDb+HZW462zvO1CPzN+F7m0wmEkizHIv1x1NG7IONcso
	 8MTlsPoksu0gnKedabN5/EDAjZJhLwQE5iKmSugXt0ALOpa2XjuZhtiIBNbXTIbBTi
	 EA0XaD5Y4jSgA==
Date: Mon, 22 Jan 2024 12:26:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Michael Schaller <michael@5challer.de>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org,
	regressions@leemhuis.info
Subject: Re: PCI/ASPM locking regression in 6.7-final (was: Re: [PATCH]
 Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()")
Message-ID: <20240122182615.GA277100@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za5JLxRC-K20sIfG@hovoldconsulting.com>

On Mon, Jan 22, 2024 at 11:53:35AM +0100, Johan Hovold wrote:
> Hi Bjorn,
> 
> I never got a reply to this one so resending with updated Subject in
> case it got buried in your inbox.

I did see it but decided it was better to fix the problem with resume
causing an unintended reboot, even though fixing that meant breaking
lockdep again, since I don't think we have user reports of the
potential deadlock lockdep finds.

08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") was a
start at fixing other problems and also improving the ASPM style, so I
hope somebody steps up to fix both it and the lockdep issue.  I
haven't looked at it enough to have a preference for *how* to fix it.

Bjorn

> On Mon, Jan 08, 2024 at 09:39:07AM +0100, Johan Hovold wrote:
>  
> > On Tue, Jan 02, 2024 at 05:25:50PM -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > This reverts commit 08d0cc5f34265d1a1e3031f319f594bd1970976c.
> > > 
> > > Michael reported that when attempting to resume from suspend to RAM on ASUS
> > > mini PC PN51-BB757MDE1 (DMI model: MINIPC PN51-E1), 08d0cc5f3426
> > > ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") caused a 12-second delay
> > > with no output, followed by a reboot.
> > > 
> > > Workarounds include:
> > > 
> > >   - Reverting 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
> > >   - Booting with "pcie_aspm=off"
> > >   - Booting with "pcie_aspm.policy=performance"
> > >   - "echo 0 | sudo tee /sys/bus/pci/devices/0000:03:00.0/link/l1_aspm"
> > >     before suspending
> > >   - Connecting a USB flash drive
> > > 
> > > Fixes: 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
> > > Reported-by: Michael Schaller <michael@5challer.de>
> > > Link: https://lore.kernel.org/r/76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: <stable@vger.kernel.org>
> > > ---
> >  
> > > +/* @pdev: the root port or switch downstream port */
> > > +void pcie_aspm_pm_state_change(struct pci_dev *pdev)
> > > +{
> > > +	struct pcie_link_state *link = pdev->link_state;
> > > +
> > > +	if (aspm_disabled || !link)
> > > +		return;
> > > +	/*
> > > +	 * Devices changed PM state, we should recheck if latency
> > > +	 * meets all functions' requirement
> > > +	 */
> > > +	down_read(&pci_bus_sem);
> > > +	mutex_lock(&aspm_lock);
> > > +	pcie_update_aspm_capable(link->root);
> > > +	pcie_config_aspm_path(link);
> > > +	mutex_unlock(&aspm_lock);
> > > +	up_read(&pci_bus_sem);
> > > +}
> > 
> > This function is now restored in 6.7 final and is called in paths which
> > already hold the pci_bus_sem as reported by lockdep (see splat below).
> > 
> > This can potentially lead to a deadlock and specifically prevents using
> > lockdep on Qualcomm platforms.
> > 
> > Not sure if you want to propagate whether the bus semaphore is held to
> > pcie_aspm_pm_state_change() or if there was some alternative to
> > restoring this function which should be explored instead.
> 
> So to summarise, this patch, which is now commit
> 
> 	f93e71aea6c6 ("Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"")
> 
> introduced a regression in 6.7-final for Qualcomm platforms (and some
> Intel platforms) similar to the one recently fixed by commit
> 
> 	f352ce999260 ("PCI: qcom: Fix potential deadlock when enabling ASPM").
> 
> Johan
> 
> 
> #regzbot introduced: f93e71aea6c6
> 
> >    ============================================
> >    WARNING: possible recursive locking detected
> >    6.7.0 #40 Not tainted
> >    --------------------------------------------
> >    kworker/u16:5/90 is trying to acquire lock:
> >    ffffacfa78ced000 (pci_bus_sem){++++}-{3:3}, at: pcie_aspm_pm_state_change+0x58/0xdc
> >    pcieport 0002:00:00.0: PME: Signaling with IRQ 197
> >    
> >                but task is already holding lock:
> >    ffffacfa78ced000 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x34/0xbc
> >    
> >                other info that might help us debug this:
> >     Possible unsafe locking scenario:
> > 
> >           CPU0
> >           ----
> >      lock(pci_bus_sem);
> >      lock(pci_bus_sem);
> >    
> >                 *** DEADLOCK ***
> > 
> >     May be due to missing lock nesting notation
> > 
> >    4 locks held by kworker/u16:5/90:
> >     #0: ffff06c5c0008d38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x150/0x53c
> >     #1: ffff800081c0bdd0 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x150/0x53c
> >     #2: ffff06c5c0b7d0f8 (&dev->mutex){....}-{3:3}, at: __driver_attach_async_helper+0x3c/0xf4
> >     #3: ffffacfa78ced000 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x34/0xbc
> >    
> >                stack backtrace:
> >    CPU: 1 PID: 90 Comm: kworker/u16:5 Not tainted 6.7.0 #40
> >    Hardware name: LENOVO 21BYZ9SRUS/21BYZ9SRUS, BIOS N3HET53W (1.25 ) 10/12/2022
> >    Workqueue: events_unbound async_run_entry_fn
> >    Call trace:
> >     dump_backtrace+0x9c/0x11c
> >     show_stack+0x18/0x24
> >     dump_stack_lvl+0x60/0xac
> >     dump_stack+0x18/0x24
> >     print_deadlock_bug+0x25c/0x348
> >     __lock_acquire+0x10a4/0x2064
> >     lock_acquire+0x1e8/0x318
> >     down_read+0x60/0x184
> >     pcie_aspm_pm_state_change+0x58/0xdc
> >     pci_set_full_power_state+0xa8/0x114
> >     pci_set_power_state+0xc4/0x120
> >     qcom_pcie_enable_aspm+0x1c/0x3c [pcie_qcom]
> >     pci_walk_bus+0x64/0xbc
> >     qcom_pcie_host_post_init_2_7_0+0x28/0x34 [pcie_qcom]

