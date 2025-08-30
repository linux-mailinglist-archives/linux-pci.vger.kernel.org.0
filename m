Return-Path: <linux-pci+bounces-35174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89590B3C947
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 10:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41FA1C22A84
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7317263F5F;
	Sat, 30 Aug 2025 08:28:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C06C2FB;
	Sat, 30 Aug 2025 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756542488; cv=none; b=nY0a028JwuprinPuDK83OmehspTiFMqBCwHIJi7n1gh5rZnzOQtSSlAI3IO8aJRLE8XdmwDs8TWk/xPQHq/nyTIQeyvjzadTXP99bjwOnwSGAPeQatecWcaxVSmOrZdvsg1Iohlnl6oA0ROG+1o7hN6N0j8nv7tlc38630iqbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756542488; c=relaxed/simple;
	bh=kyHaj5RM8oYP6OAVd4RZSwsAl4+SiZIEnIECrfGzPiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZMkoYbphVCeHHnGiLS2ta3dUduE/qREucr+aFDULIaHu1BDfVJup+6ICWTQEbgIjOaWI5GQKdoP5MtpoJpJXdAzd5diGEReBZMHiLlshw/0C8Tt9JHLD2DVyqtjTwXwENG7h3F9KdvYuyFHELBNrVN5A4zoh2wh5wuMpR6p4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7FDE32C01837;
	Sat, 30 Aug 2025 10:28:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6D54935A1AB; Sat, 30 Aug 2025 10:28:02 +0200 (CEST)
Date: Sat, 30 Aug 2025 10:28:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: moubingquan <moubingquan@h-partners.com>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	linux-kernl <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	fanghao <fanghao11@huawei.com>,
	gaozhihao <gaozhihao6@h-partners.com>,
	lujunhua <lujunhua7@h-partners.com>,
	shenyang <shenyang39@huawei.com>,
	wushanping <wushanping@huawei.com>,
	zengtao <prime.zeng@hisilicon.com>, jonathan.cameron@huawei.com,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [BUG] sysfs: duplicate resource file creation during PCIe rescan
Message-ID: <aLK2EmT5kL_AfWim@wunner.de>
References: <b51519d6-ce45-4b6d-8135-c70169bd110e@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51519d6-ce45-4b6d-8135-c70169bd110e@h-partners.com>

On Tue, Jul 29, 2025 at 09:13:19AM +0800, moubingquan wrote:
> When uninstalling the driver on the ARM64 platform and invoking `sriov_disable()`,
> another thread simultaneously performed `echo 1 > /sys/bus/pci/rescan`,
> which resulted in a call trace error (`sysfs: cannot create duplicate filename`) when subsequently loading the driver.
> 
> Under certain multi-threaded scenarios (e.g. VF teardown + PCI rescan triggered in parallel),
> The following sequence may result in files appearing in sysfs that should not exist:
> 
> 1. sriov_disable() uninstalls VFs and removes the corresponding VF files in sysfs.
> 2.At the same time, when rescan_store() rescan the entire PCI device tree,
> there is a possibility that VF files that should have been deleted are added back,
> resulting in VF files in sysfs that should have been removed but were not.

Could you test if this pending series from Niklas (+cc) fixes the issue for you:

https://lore.kernel.org/r/20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com

If it does, could you reply with a Tested-by to his cover letter?

Thanks,

Lukas

> Tested on:
> - Kernel version: Linux version 6.15.0-rc4+ (phisik3@10-50-163-153-ARM-openEuler22-3)
> - Platform: ARM64 (Huawei Kunpeng920)
> - Repro steps:
> 1.Thread A unloads the driver and VF (requires calling sriov_disable()).
> 2.Thread B calls `echo 1 > /sys/bus/pci/rescan `
> 
> The system will report a call trace as follows:
> 
> sysfs: cannot create duplicate filename '/devices/pci0000:3c/0000:3c:01.0/0000:3e:00.2/resource2'
> CPU: 138 UID: 0 PID: 11067 Comm: sh Kdump: loaded Tainted: G      D W  O        6.15.0-rc4+ #1 PREEMPT
> Tainted: [D]=DIE, [W]=WARN, [O]=OOT_MODULE
> Call trace:
>  show_stack+0x20/0x38 (C)
>  dump_stack_lvl+0x80/0xf8
>  dump_stack+0x18/0x28
>  sysfs_warn_dup+0x6c/0x90
>  sysfs_add_bin_file_mode_ns+0x12c/0x178
>  sysfs_create_bin_file+0x7c/0xb8
>  pci_create_attr+0x104/0x1b0
>  pci_create_resource_files.part.0+0x50/0xd0
>  pci_create_sysfs_dev_files+0x30/0x50
>  pci_bus_add_device+0x40/0x120
>  pci_bus_add_devices+0x40/0x98
>  pci_bus_add_devices+0x6c/0x98
>  pci_rescan_bus+0x38/0x58
>  rescan_store+0x80/0xb0
>  bus_attr_store+0x2c/0x48
>  sysfs_kf_write+0x84/0xa8
>  kernfs_fop_write_iter+0x120/0x1b8
>  vfs_write+0x338/0x3f8
>  ksys_write+0x70/0x110
>  __arm64_sys_write+0x24/0x38
>  invoke_syscall+0x50/0x120
>  el0_svc_common.constprop.0+0xc8/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x34/0xf0
>  el0t_64_sync_handler+0xc8/0xd0
>  el0t_64_sync+0x1ac/0x1b0
> 
> The general analysis and corresponding code are as follows:
> 
> drivers/pci/iov.c
> 
> 736 static void sriov_disable(struct pci_dev *dev)
> 737 {
> 738         struct pci_sriov *iov = dev->sriov;
> 739
> 740         if (!iov->num_VFs)
> 741                 return;
> 742
> 743         sriov_del_vfs(dev);
> 744         iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> 745         pci_cfg_access_lock(dev);
> 746         pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> 747         ssleep(1);
> 748         pci_cfg_access_unlock(dev);
> 749
> 750         pcibios_sriov_disable(dev);
> 751
> 752         if (iov->link != dev->devfn)
> 753                 sysfs_remove_link(&dev->dev.kobj, "dep_link");
> 754
> 755         iov->num_VFs = 0;
> 756         pci_iov_set_numvfs(dev, 0);
> 757 }
> 
> sriov_disable() will unload the VF and remove its files from sysfs.
> 
> drivers/pci/pci-sysfs.c
> 
>  435 static ssize_t rescan_store(const struct bus_type *bus, const char *buf, size_t count)
>  436 {
>  437         unsigned long val;
>  438         struct pci_bus *b = NULL;
>  439
>  440         if (kstrtoul(buf, 0, &val) < 0)
>  441                 return -EINVAL;
>  442
>  443         if (val) {
>  444                 pci_lock_rescan_remove();
>  445                 while ((b = pci_find_next_bus(b)) != NULL)
>  446                         pci_rescan_bus(b);
>  447                 pci_unlock_rescan_remove();
>  448         }
>  449         return count;
>  450 }
>  451 static BUS_ATTR_WO(rescan);
> 
> The `rescan_store()` function will scan the entire PCI bus, including the relevant sysfs files for the aforementioned VFs.
> 
> Initially, it seemed that directly adding the pci_lock_rescan_remove() lock to sriov_disable() could solve the problem.
> However, it was later discovered that this might lead to a deadlock issue (because the remove_store() function would call sriov_disable(), causing a deadlock).
> 
> drivers/pci/pci-sysfs.c
> 
>  487 static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>  488                             const char *buf, size_t count)
>  489 {
>  490         unsigned long val;
>  491
>  492         if (kstrtoul(buf, 0, &val) < 0)
>  493                 return -EINVAL;
>  494
>  495         if (val && device_remove_file_self(dev, attr))
>  496
>         //Subsequently, sriov_disable() will be invoked.
>                 pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
>  497         return count;
>  498 }
>  499 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
>  500                                   remove_store);
> 
> The function `pci_stop_and_remove_bus_device_locked()` acquires the `pci_lock_rescan_remove()` lock and subsequently calls `sriov_disable()`.
> If the lock is added within `sriov_disable()`, it could lead to a deadlock.
> 
> Should we add a new lock to address this issue, or are there any other ideas? I would like to consult and discuss this with everyone.
> 
> Thanks,
> Bingquan Mou <moubingquan@h-partners.com>

