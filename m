Return-Path: <linux-pci+bounces-4451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C96870634
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 16:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DF0281433
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBD147A7A;
	Mon,  4 Mar 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk42QveN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C747793;
	Mon,  4 Mar 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567501; cv=none; b=h2l8FoNhRhW7Jz81BtB09fUi7n+yve4YeJh3uoyjsYws5EFo/UfZygZgoDouMMiaR7EopdYL7Osh3mdtMO1WNh69Y8+eB6dWYVurCU0cV1TpgMW/ZdXa+ip5YcgGeVTvSkSdozXbJKDVlr/i4SK7JOEz+nakUzoBr+vVa26fPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567501; c=relaxed/simple;
	bh=c+8XYXTL4MNDkZflKTWBzR1Wk2Ypz56BlkcuwFEXZhc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F13VxvXhV7E9dx7PLYfP3VrG2UJmoMGEjsG9IdrG3yNOGO3yuLqjMEVq3vFHdDE3PbM/jmJ1w/gqo/J0tLBD9gV7HM8YUC84IV7BlNWV4VchkoeaawVr6GBXohnC9gYOB3MXxytuoNceQG28r1LRFmuiA/5cVFzzH4bmFxYwZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk42QveN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44784C433C7;
	Mon,  4 Mar 2024 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709567500;
	bh=c+8XYXTL4MNDkZflKTWBzR1Wk2Ypz56BlkcuwFEXZhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kk42QveNYWswu6Cne4CcCQ3NKRd8OSuCmtYXC+2wpbtLZf4gPV1H/XXREaZ7AKlLF
	 0uXBJhrkiNJjJnTQGMwP42tFVzNHRauOLuQryNkOgU1dkytxhyzOxGXKZ4LwyqIi6y
	 Cx4qnPxwQVj7T2CeUZqQA/o4MD79tUopgx61rU5eouVPcDPA4/EZwyYdahLRPDFkOV
	 wPA2BPOZWst75iRJrhZ8KSxINI5yI1L28rPcapdSaJys/ZzSM5ABgDiOj+3PTHfUdt
	 QhSBd3EHrKAWIMf7w2Lyn37NLpMQI8Vf4U1jTAesqIfGtJG36hTFnPZF5NXtDFn7ih
	 w9EQBxT4aKofw==
Date: Mon, 4 Mar 2024 09:51:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, gregkh@linuxfoundation.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ricky Wu <ricky_wu@realtek.com>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3] driver core: Cancel scheduled pm_runtime_idle() on
 device removal
Message-ID: <20240304155138.GA482969@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0grDNJkEcgw+34SBmNFL7qhSTz8ydC7BSkM7DiCatkKSA@mail.gmail.com>

On Mon, Mar 04, 2024 at 03:38:38PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 29, 2024 at 7:23 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > When inserting an SD7.0 card to Realtek card reader, the card reader
> > unplugs itself and morph into a NVMe device. The slot Link down on hot
> > unplugged can cause the following error:
> >
> > pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > BUG: unable to handle page fault for address: ffffb24d403e5010
> > PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PTE 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> > Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H370M Pro4, BIOS P3.40 10/25/2018
> > Workqueue: pm pm_runtime_work
> > RIP: 0010:ioread32+0x2e/0x70
> ...
> > Call Trace:
> >  <TASK>
> >  ? show_regs+0x68/0x70
> >  ? __die_body+0x20/0x70
> >  ? __die+0x2b/0x40
> >  ? page_fault_oops+0x160/0x480
> >  ? search_bpf_extables+0x63/0x90
> >  ? ioread32+0x2e/0x70
> >  ? search_exception_tables+0x5f/0x70
> >  ? kernelmode_fixup_or_oops+0xa2/0x120
> >  ? __bad_area_nosemaphore+0x179/0x230
> >  ? bad_area_nosemaphore+0x16/0x20
> >  ? do_kern_addr_fault+0x8b/0xa0
> >  ? exc_page_fault+0xe5/0x180
> >  ? asm_exc_page_fault+0x27/0x30
> >  ? ioread32+0x2e/0x70
> >  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> >  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> >  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> >  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> >  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> >  pci_pm_runtime_idle+0x34/0x70
> >  rpm_idle+0xc4/0x2b0
> >  pm_runtime_work+0x93/0xc0
> >  process_one_work+0x21a/0x430
> >  worker_thread+0x4a/0x3c0
> ...

> > This happens because scheduled pm_runtime_idle() is not cancelled.
> 
> But rpm_resume() changes dev->power.request to RPM_REQ_NONE and if
> pm_runtime_work() sees this, it will not run rpm_idle().
> 
> However, rpm_resume() doesn't deactivate the autosuspend timer if it
> is running (see the comment in rpm_resume() regarding this), so it may
> queue up a runtime PM work later.
> 
> If this is not desirable, you need to stop the autosuspend timer
> explicitly in addition to calling pm_runtime_get_sync().

I don't quite follow all this.  I think the race is between
rtsx_pci_remove() (not resume) and rtsx_pci_runtime_idle().

  rtsx_pci_remove()
  {
    pm_runtime_get_sync()
    pm_runtime_forbid()
    ...

If this is an rtsx bug, what exactly should be added to
rtsx_pci_remove()?

Is there ever a case where we want any runtime PM work to happen
during or after a driver .remove()?  If not, maybe the driver core
should prevent that, which I think is basically what this patch does.

If this is an rtsx driver bug, I'm concerned there may be many other
drivers with a similar issue.  rtsx exercises this path more than most
because the device switches between card reader and NVMe SSD using
hotplug add/remove based on whether an SD card is inserted (see [1]).

[1] https://lore.kernel.org/r/20231019143504.GA25140@wunner.de

> > So before releasing the device, stop all runtime power managements by
> > using pm_runtime_barrier() to fix the issue.
> >
> > Link: https://lore.kernel.org/all/2ce258f371234b1f8a1a470d5488d00e@realtek.com/
> > Cc: Ricky Wu <ricky_wu@realtek.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >   Move the change the device driver core.
> >
> > v2:
> >   Cover more cases than just pciehp.
> >
> >  drivers/base/dd.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 85152537dbf1..38c815e2b3a2 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -1244,6 +1244,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
> >
> >         drv = dev->driver;
> >         if (drv) {
> > +               pm_runtime_barrier(dev);
> 
> This prevents the crash from occurring because pm_runtime_barrier()
> calls pm_runtime_deactivate_timer() unconditionally AFAICS.

