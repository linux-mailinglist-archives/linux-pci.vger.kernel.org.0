Return-Path: <linux-pci+bounces-13431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB149984405
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 12:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2711F24348
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 10:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C9019B3EA;
	Tue, 24 Sep 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaIci6e8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E061F5FF
	for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2024 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175119; cv=none; b=bzYNLelUjxs/Ja7zmD5/cayLU2iCPwgMj8Hy90wwzURH7aK3k3ES8OW3MPjyzmYs2Y6dizpO2V3+zuqAZYEsCVvE4MfIqi/YncZKruNL914Hywu66cDj47vq7O3f+uXkui5H1nA4gtiia44YYFEpzUYcmrEM3r0u/bV/GN59NdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175119; c=relaxed/simple;
	bh=ffkVPnW09kpTisqPvWpEqEydXoPyPzOq59AUO5IrSHw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lYYtgqohEEvJu1WU0dnfLIu5atBhF1xVMnlp3cbJTlheIn268mKlHS+2VMhffwElyEB6EeCTv6InscQy7lB/m5XQayQ3vop9jITSJ4qnkl/k9O27rh/UHQtpdCFAyfYo2mV0+dzCUBm0q9CB52PGyMNohqcTExrYsZUxhjf8kyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaIci6e8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727175117; x=1758711117;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ffkVPnW09kpTisqPvWpEqEydXoPyPzOq59AUO5IrSHw=;
  b=SaIci6e82ZLbbqv7Ne/ul2Zl6a0Qgue9Xu5C914WfFG7D3AMZGWMtBih
   6kXtVVjtJUwIgna9EAfUYrH70jdavGf6U2Ozp+YJD3W/NkTvoN23EZnOa
   17dtwM6Mh9DdcAUlrc6OgZQQerOzLEWrdLFbI6KY7QUoTWhx9IGQh6Eo1
   guh37/zmE+eviRApC98t9kmrGxOeUjYlzFtp/oj+4ymXfwN3XcUu9cXXd
   gCQsPKQkOmNEuWNpzy8xPr8MvodZIntoAQ/V91DVY/FtDi3SN9u+f56qL
   tcX7GWbPJr1aK0convXI4eGuzDH/8xjru8HuAIryTFhOj1mBf1vQRCuqo
   g==;
X-CSE-ConnectionGUID: 8fX+g7qQR8+IbbYVv/OgYQ==
X-CSE-MsgGUID: 3VEJlD3wSzG6BY3r17kYQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26348719"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="26348719"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 03:51:57 -0700
X-CSE-ConnectionGUID: BJuZ/VlGTK+utjpJulANAA==
X-CSE-MsgGUID: Ord2ATMCRu254V2FEV8aoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71451008"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.151])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 03:51:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Sep 2024 13:51:51 +0300 (EEST)
To: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "kbusch@kernel.org" <kbusch@kernel.org>, 
    "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, 
    "mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>, 
    "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, 
    "minipli@grsecurity.net" <minipli@grsecurity.net>, 
    "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: UAF during boot on MTL based devices with attached dock
In-Reply-To: <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
Message-ID: <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com> <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 23 Sep 2024, Wassenberg, Dennis wrote:

> Hi together,
> 
> we did some further analysis on this:
> 
> Because we are working on kernel 6.8.12, I will use some logs from this kernel version, just for demonstration. The
> initial report was based on 6.11.
> 
> After we tried a KASAN build (dmesg-ramoops-kasan) it looks like it is exactly the same pciehp flow which leads to the
> UAF.
> Both going through pciehp_ist -> pciehp_disable_slot -> pciehp_unconfigure_device -> pci_remove_bus_device -> ...
> This means there are two consecutive interrupts, running on CPU 12 and both will execute the same flow.
> At the latest the pci_lock_rescan_remove should be taken in pciehp_unconfigure_device to prevent accessing the pci/bus
> structures in parallel.
> 
> I had a look if there are shared data structures accessed in this code path:
> For me the access to "*parent = ctrl->pcie->port->subordinate;" looks fishy in pciehp_unconfigure_device. The parent ptr
> will be obtained before getting the lock (pci_lock_rescan_remove). Now, if there are two concurrent/consecutive flows
> come into this function, both will get the pointer to the parent bridge/subordinate. One thread will enter the lock and
> the other one is waiting until the lock is gone. The thread which enters the lock at first will completely remove the
> bridge and the subordinate: pciehp_unconfigure_device -> pci_stop_and_remove_bus_device -> pci_remove_bus_device ->
> pci_destroy_dev: This will destroy the pci_dev and the subordinate is a part the this structure as well. Now everything
> is gone below this pci_bus (childs included). In pci_remove_bus_device there is a loop which iterates over all child
> devices and call pci_remove_bus_device again. This means even the child bridges of the current bridge will be deleted.
> In the end: everything is gone below the bridge which is regarded here at first.

Doesn't that end up removing portdrv/hotplug too so pciehp_remove() does 
release ctrl? I'm not sure if ctrl can be safely accessed even if the 
lock is taken first?

-- 
 i.

> After this the thread leaves the lock with pci_unlock_rescan_remove in pciehp_unconfigure_device. Now the second
> thread/ISR will enter the lock. If the second thread belongs to a child bridge of the bridge which was already removed,
> it will run into an UAF. This is because the parent bridge destroys all child bridges as well, but the second thread
> gets the subordinate pointer before accessing the lock. This means it could be possible  hat the second thread uses the
> already destroyed subordinate pointer which makes the subordinate invalid. Accessing the pci_bus structure via this
> subordinate will definitely run into an UAF.
> 
> In addition we looked closer at pci_stop_and_remove_bus_device_locked() and noticed that while pci_stop_bus_device() is
> also walking the ->devices list in reverse order, pci_remove_bus_device() isn't. Maybe it should, to ensure a consistent
> order of destruction?
>
> We addressed both with the following patch: v2-0001-PCI-pcihp-fix-subordinate-access-in-pciehp_unconf.patch
> 
> Whats your thoughts about this?
> 
> 
> After applying this patch on top of 6.8.12 the initial UAF is gone (the one shown in dmesg-ramoops-kasan), but a
> different UAF comes up (dmesg-ramoops-kasan-v2). This new one is more similar to the one which I reported initially on
> Kernel 6.11. I think even though the UAF in dmesg-ramoops-kasan is not easy to reproduce on vanilla 6.11, because an
> other one will happen, it is a valid fix which should be applied anyway because the code in 6.11 and 6.8.18 doesn't
> differ in this area.
> I attached a KASAN log as well where both patches are integrated: (v2-0001-PCI-pcihp-fix-subordinate-access-in-
> pciehp_unconf.patch + PCI: Don't access freed bus in pci_slot_release() from Ilpo (dmesg-ramoops-kasan-v2+patch_ilpo).
> 
> 
> In addition I am currently trying to reproduce this on vanilla 6.11 with activated KASAN but I was not lucky enough to
> catch this until yet (without KASAN it is easy to reproduce for me).
> 
> Thank you & best regards,
> Dennis
> 
> 
> 
> On Thu, 2024-09-19 at 10:06 +0200, Dennis Wassenberg wrote:
> > Hi together,
> > 
> > we are facing into issues which seems to be PCI related and asking for your estimations.
> > 
> > Background:
> > We want to boot up an Intel MeteorLake based system (e.g. Lenovo ThinkPad X13 Gen5) with the Lenovo Thunderbolt 4
> > universal dock attached during boot. On some devices it is nearly 100% reproducible that the boot will fail. Other
> > systems will never show this issue (e.g. older devices based on RaptorLake or AlderLake platform).
> > 
> > We did some debugging on this and came to the conclusion that there is a use-after-free in pci_slot_release.
> > The Thunderbolt 4 Dock will expose a PCI hierarchy at first and shortly after that, due to the device is inaccessible,
> > it will release the additional buses/ports. This seems to end up in a race where pci_slot_release accesses &slot->bus
> > which as already freed:
> > 
> > 0000:00 [root bus]
> >       -> 0000:00:07.0 [bridge to 20-49]
> >                      -> 0000:20:00.0 [bridge to 21-49]
> >                                     -> 0000:21:00.0 [bridge to 22]
> >                                        0000:21:01.0 [bridge to 23-2e]
> >                                        0000:21:02.0 [bridge to 2f-3a]
> >                                        0000:21:03.0 [bridge to 3b-48]
> >                                        0000:21:04.0 [bridge to 49]
> >          0000:00:07.2 [bridge to 50-79]
> > 
> > 
> > We are currently running on kernel 6.8.12. Because this kernel is out of support I tried it on 6.11. This kernel shows
> > exactly the same issue. I attached two log files:
> > dmesg-ramoops-0: Based on kernel 6.11 with added kernel command line option "slab_debug" in order to force a kernel
> > Oops
> > while accessing freed memory.
> > dmesg-ramoops-0-pci_dbg: This it like dmesg-ramoops-0 with additional kernel command line option '"dyndbg=file
> > drivers/pci/* +p" ignore_loglevel' in order to give you more insight whats happening on the pci bus.
> > 
> > I would appreciate any kind of help on this.
> > 
> > Thank you & best regards,
> > Dennis
> > 
> > 
> 
> 

