Return-Path: <linux-pci+bounces-13151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FF6977A74
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 10:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872811F26FD6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36661BD51E;
	Fri, 13 Sep 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiBiF9EM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34EA1BD034;
	Fri, 13 Sep 2024 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214489; cv=none; b=Jdpx7UQrPn2GmTGnd6fUIrmI35ZFjc5VcI3/zHvYwVJfhnjt5jmpb46Vi01SGV99sHAiKYTNfZT8Ni7LSBWRcnSBlcUCaPLaQ72IJ4sEMo+kgDl4WfjY7jIMd0rcf+1s2qRR7osaRP3sKuzjNYg7HHSEjmNuYDBJEkxW4wUsMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214489; c=relaxed/simple;
	bh=QWG+VVSZQCAnN4WdgKruMIQxWPSZdrP6CxHP7hTwAvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1DcdTw+LVR4cNS9+2ytaw848G2Oa/veFc+ds0mmkAE0LmNTchimzAOkwpQsMQcE0ucR+pUlXoMABxR7TpcCa8s48wxKuxMOt5PM+6J4wwLCX2sCX/niYw4qPfN63Dz94g+GTW9w8RAz+hWSBkIhc9i12jeVlGv6yAmn3eKk6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiBiF9EM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726214488; x=1757750488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QWG+VVSZQCAnN4WdgKruMIQxWPSZdrP6CxHP7hTwAvw=;
  b=WiBiF9EMPZo8qbMbAx/9lcsqabgwUqVZWRI766y4FnoEVdwFihN4fV4K
   PiR+hgimeVOXHW9e2KGtACohwPYxIIwKS5bvoP1KZ+E8FAoEGrqgXu6C/
   kaOWwSF4pKgkPjtXEzjRyul9EahRqophK5Jn8YKXRMAJZCngSyczhm5jw
   THC63LTpRZ/mYYA+U89/VaAP08rSe0EkycFQyIGvCisU8mccY67sxqlrw
   dNGZXEHDLFwDY8nBg4qx8uUabrFc/+lDCtqaGtnbif2frIF3csBMh9fWC
   2C9M2ZLhCBWIpgvLSIJN3ypC90bbiSCli9eur2WckRPQ5kcuAI4NFqxJW
   A==;
X-CSE-ConnectionGUID: dcOdySznTci6NiV19MCxsQ==
X-CSE-MsgGUID: SPpYINs3T6SfzOE+FCUGsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="28999557"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="28999557"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:01:27 -0700
X-CSE-ConnectionGUID: K8Kv5Fn2Rnyop7LhK7ZOXQ==
X-CSE-MsgGUID: JIwZoE53QpqhUqQhCjz5oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="105436234"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 13 Sep 2024 01:01:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 960E3334; Fri, 13 Sep 2024 11:01:23 +0300 (EEST)
Date: Fri, 13 Sep 2024 11:01:23 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kai-Heng Feng <kaihengfeng@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
	mario.limonciello@amd.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
Message-ID: <20240913080123.GP275077@black.fi.intel.com>
References: <CAAd53p7vP8TcPj=u5TTuPMXFaWW15hwpJdECCprvXGBhigKD6Q@mail.gmail.com>
 <20240912165709.GA674430@bhelgaas>
 <CAMusMWqxi3s8sb+j0wV251kRj9R9-oqKQUqKscVTk_sktm2m5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMusMWqxi3s8sb+j0wV251kRj9R9-oqKQUqKscVTk_sktm2m5A@mail.gmail.com>

Hi,

On Fri, Sep 13, 2024 at 02:00:58PM +0800, Kai-Heng Feng wrote:
> On Fri, Sep 13, 2024 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Rafael]
> >
> > On Thu, Sep 12, 2024 at 11:00:43AM +0800, Kai-Heng Feng wrote:
> > > On Thu, Sep 12, 2024 at 3:05 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> > > > > Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> > > > > connected.
> > > > >
> > > > > The following error message can be found during shutdown:
> > > > > pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
> > > > > pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> > > > > pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> > > > > pcieport 0000:09:04.0:    [ 7] BadDLLP
> > > > >
> > > > > Calling aer_remove() during shutdown can quiesce the error message,
> > > > > however the spurious wakeup still happens.
> > > > >
> > > > > The issue won't happen if the device is in D3 before system shutdown, so
> > > > > putting device to low power state before shutdown to solve the issue.
> > > > >
> > > > > I don't have a sniffer so this is purely guesswork, however I believe
> > > > > putting device to low power state it's the right thing to do.
> > > >
> > > > My objection here is that we don't have an explanation of why this
> > > > should matter or a pointer to any spec language about this situation,
> > > > so it feels a little bit random.
> > >
> > > I have the same feeling too. The PCIe spec doesn't specify what's the
> > > correct power state for shutdown.
> > > So we can only "logically" think the software should put devices to
> > > low power state during shutdown.
> > >
> > > > I suppose the problem wouldn't happen if AER interrupts were disabled?
> > > > We already do disable them in aer_suspend(), but maybe that's not used
> > > > in the shutdown path?
> > >
> > > That was my first thought, so I modified pcie_port_shutdown_service()
> > > to disable AER interrupt.
> > > That approach didn't work though.
> > >
> > > > My understanding is that .shutdown() should turn off device interrupts
> > > > and stop DMA.  So maybe we need an aer_shutdown() that disables
> > > > interrupts?
> > >
> > > Logically we should do that. However that approach doesn't solve this issue.
> >
> > I'm not completely clear on the semantics of the .shutdown()
> > interface.  The doc at
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/device/driver.h?id=v6.10#n73
> > says "@shutdown: Called at shut-down time to quiesce the device"
> >
> > Turning off device interrupts and DMA *would* fit within the idea of
> > quiescing the device.  Does that also include changing the device
> > power state?  I dunno.  The power state isn't *mentioned* in the
> > .shutdown() context, while it *is* mentioned for .suspend().
> 
> IMO putting a device to low power also qualifies as "quiesce the device".
> 
> >
> > IIUC, this patch and commit log uses "shutdown" to refer to a
> > system-wide *poweroff*, which is a different concept despite using the
> > same "shutdown" name.
> 
> For ACPI based system, there are .suspend for S3/s2idle, .poweroff for
> S4, and .shutdown for S5.
> Unless we want to introduce a new callback for S5, I think the concept
> is quite similar.
> 
> For DT based system, the OS should also perform the same thing, as
> there's no firmware to cleanup the power state.
> 
> We can also move .shutdown to be part of pm_ops, but I don't think
> it's necessary,
> 
> >
> > So should the system poweroff procedure use .suspend()?  Should it use
> > both .shutdown() and .suspend()?  I think it only uses .shutdown()
> > today:
> >
> >   kernel_power_off
> >     kernel_shutdown_prepare(SYSTEM_POWER_OFF)
> >       device_shutdown
> >         while (!list_empty(&devices_kset->list))
> >           dev->bus->shutdown(dev)
> >             pci_device_shutdown
> >
> > There are several driver .shutdown() methods that do things like this:
> >
> >   e1000_shutdown
> >     if (system_state == SYSTEM_POWER_OFF)
> >       pci_set_power_state(pdev, PCI_D3hot)
> >
> > Maybe that's the right thing and should be done by the PCI core, which
> > is similar to what you propose here.  But I think it muddies the
> > definition of .shutdown() a bit by mixing in power management stuff.
> 
> Do you think adding a new "low power state" callback to be called
> after .shutdown a good idea?
> That would make the concept of .shutdown different to .suspend and
> .poweroff. I personally see .suspend, .poweroff and .shutdown the same
> action but target different power states.

I don't mean to confuse you guys but with this one too, I wonder if you
tried to "disable" the device instead of putting it into D3? On another
thread (Mario at least is aware of this) I mentioned that our PCIe SV
folks identified a couple issues in Linux implementation around power
management and one thing that we are missing is to disable I/O and MMIO
upon entering D3.

I know this is about entering S5 (power off) but I wonder if simply
disabling the device (I/O, MMIO and bus mastering) could stop it from
waking up? To my understanding this can be interpreted as quiesce too :)
Something like the below patch (it also includes the runtime suspend
path which should not matter here. This is the similar patch I shared in
another thread).

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f412ef73a6e4..79406814699d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -514,11 +514,9 @@ static void pci_device_shutdown(struct device *dev)
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
 	 * devices in D3cold or unknown states.
-	 * If it is not a kexec reboot, firmware will hit the PCI
-	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
-		pci_clear_master(pci_dev);
+	if (pci_dev->current_state <= PCI_D3hot)
+		pci_disable_device(pci_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1332,6 +1330,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
 
 	if (!pci_dev->state_saved) {
 		pci_save_state(pci_dev);
+		pci_pm_default_suspend(pci_dev);
 		pci_finish_runtime_suspend(pci_dev);
 	}
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ffaaca0978cb..91f4e7a03c94 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2218,6 +2218,13 @@ static void do_pci_disable_device(struct pci_dev *dev)
 		pci_command &= ~PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
+	/*
+	 * PCI PM 1.2 sec 8.2.2 says that when a function is put into D3
+	 * the OS needs to disable I/O and MMIO space in addition to bus
+	 * mastering so do that here.
+	 */
+	pci_command &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
+	pci_write_config_word(dev, PCI_COMMAND, pci_command);
 
 	pcibios_disable_device(dev);
 }

