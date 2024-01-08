Return-Path: <linux-pci+bounces-1773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076D182699F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 09:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44AC28258A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29182BA5E;
	Mon,  8 Jan 2024 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPLZNJ5P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42DBA4B;
	Mon,  8 Jan 2024 08:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A65C433C7;
	Mon,  8 Jan 2024 08:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704703152;
	bh=S/rMSRKH43CMn1oKC9RlDlUXo73YSColFYC3uuFnl3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPLZNJ5PRF1mtG1hcmuc32q7U58QIjFbxLhcGygkk+1FJUGi6hTJ7K6aYej03tYKx
	 niO2yLUwph3gPHlv376rzVKbGdDQ1JFaULhsW+sO8f19WjTe9M99QM4hZd66kWtu57
	 Ultytm0lH8GLNhBRn/ycnrQi2GVS2TBRZOnqb5qCGehDKeKIAtG8HkRhN6jMUsY473
	 AY9YzXpQXkJ4dY/nZb4rqt5DvZl4QGBDDSIeZmrMeGUoQaZlsg3u/Ba2mvCMmEThSA
	 nQk2GkkKeaZzIRO+8w9lOejkiqve5tRTHcjvJod/6KhOxFOaZQNkNu3myvZ4hU/d1B
	 fglnISG44KHCw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rMlA3-0008Cl-2I;
	Mon, 08 Jan 2024 09:39:07 +0100
Date: Mon, 8 Jan 2024 09:39:07 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"
Message-ID: <ZZu0qx2cmn7IwTyQ@hovoldconsulting.com>
References: <76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de>
 <20240102232550.1751655-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102232550.1751655-1-helgaas@kernel.org>

Hi Bjorn,

On Tue, Jan 02, 2024 at 05:25:50PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This reverts commit 08d0cc5f34265d1a1e3031f319f594bd1970976c.
> 
> Michael reported that when attempting to resume from suspend to RAM on ASUS
> mini PC PN51-BB757MDE1 (DMI model: MINIPC PN51-E1), 08d0cc5f3426
> ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") caused a 12-second delay
> with no output, followed by a reboot.
> 
> Workarounds include:
> 
>   - Reverting 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
>   - Booting with "pcie_aspm=off"
>   - Booting with "pcie_aspm.policy=performance"
>   - "echo 0 | sudo tee /sys/bus/pci/devices/0000:03:00.0/link/l1_aspm"
>     before suspending
>   - Connecting a USB flash drive
> 
> Fixes: 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
> Reported-by: Michael Schaller <michael@5challer.de>
> Link: https://lore.kernel.org/r/76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <stable@vger.kernel.org>
> ---
 
> +/* @pdev: the root port or switch downstream port */
> +void pcie_aspm_pm_state_change(struct pci_dev *pdev)
> +{
> +	struct pcie_link_state *link = pdev->link_state;
> +
> +	if (aspm_disabled || !link)
> +		return;
> +	/*
> +	 * Devices changed PM state, we should recheck if latency
> +	 * meets all functions' requirement
> +	 */
> +	down_read(&pci_bus_sem);
> +	mutex_lock(&aspm_lock);
> +	pcie_update_aspm_capable(link->root);
> +	pcie_config_aspm_path(link);
> +	mutex_unlock(&aspm_lock);
> +	up_read(&pci_bus_sem);
> +}

This function is now restored in 6.7 final and is called in paths which
already hold the pci_bus_sem as reported by lockdep (see splat below).

This can potentially lead to a deadlock and specifically prevents using
lockdep on Qualcomm platforms.

Not sure if you want to propagate whether the bus semaphore is held to
pcie_aspm_pm_state_change() or if there was some alternative to
restoring this function which should be explored instead.

Johan


   ============================================
   WARNING: possible recursive locking detected
   6.7.0 #40 Not tainted
   --------------------------------------------
   kworker/u16:5/90 is trying to acquire lock:
   ffffacfa78ced000 (pci_bus_sem){++++}-{3:3}, at: pcie_aspm_pm_state_change+0x58/0xdc
   pcieport 0002:00:00.0: PME: Signaling with IRQ 197
   
               but task is already holding lock:
   ffffacfa78ced000
   pcieport 0002:00:00.0: AER: enabled with IRQ 197
    (pci_bus_sem
   nvme nvme0: pci function 0002:01:00.0
   ){++++}-{3:3}
   nvme 0002:01:00.0: enabling device (0000 -> 0002)
   , at: pci_walk_bus+0x34/0xbc
   
               other info that might help us debug this:
    Possible unsafe locking scenario:

          CPU0
          ----
     lock(pci_bus_sem);
     lock(pci_bus_sem);
   
                *** DEADLOCK ***

    May be due to missing lock nesting notation

   4 locks held by kworker/u16:5/90:
    #0: ffff06c5c0008d38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x150/0x53c
    #1: ffff800081c0bdd0 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x150/0x53c
    #2: ffff06c5c0b7d0f8 (&dev->mutex){....}-{3:3}, at: __driver_attach_async_helper+0x3c/0xf4
    #3: ffffacfa78ced000 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x34/0xbc
   
               stack backtrace:
   CPU: 1 PID: 90 Comm: kworker/u16:5 Not tainted 6.7.0 #40
   Hardware name: LENOVO 21BYZ9SRUS/21BYZ9SRUS, BIOS N3HET53W (1.25 ) 10/12/2022
   Workqueue: events_unbound async_run_entry_fn
   Call trace:
    dump_backtrace+0x9c/0x11c
    show_stack+0x18/0x24
    dump_stack_lvl+0x60/0xac
    dump_stack+0x18/0x24
    print_deadlock_bug+0x25c/0x348
    __lock_acquire+0x10a4/0x2064
    lock_acquire+0x1e8/0x318
    down_read+0x60/0x184
    pcie_aspm_pm_state_change+0x58/0xdc
    pci_set_full_power_state+0xa8/0x114
    pci_set_power_state+0xc4/0x120
    qcom_pcie_enable_aspm+0x1c/0x3c [pcie_qcom]
    pci_walk_bus+0x64/0xbc
    qcom_pcie_host_post_init_2_7_0+0x28/0x34 [pcie_qcom]

