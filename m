Return-Path: <linux-pci+bounces-8329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2CE8FCF2A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 15:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236CC1C20E8F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C411C3700;
	Wed,  5 Jun 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EzLCkWz1"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517451BF91D;
	Wed,  5 Jun 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591783; cv=none; b=jzHztFQIGjnfCsoJNyl0JdtdAWB3zsRWNwZdshi11LcMwX21qffFp/2U63vXtOXZG/rhLy89u+RCHS+6qOO9QsLthubJ31Zs8lp51a7IxCheloAbqFnaG90wauKc7x2GP6VIIw3outX1YXnG0RiGRBdoiBY7jMvTkhYtBwx2OFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591783; c=relaxed/simple;
	bh=lnC6lhwfhZqonMLmQYocGI5DzJnUgP8OC7a1XdWj1YU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Llt0qdX/EOSQ+A/oAAYnS5vC+Fl7+aU4EINHnTxuhKmUt/L10vQb0xIPX/LfDrhmfWUswSyeYfFvantRVgjJiW6YplFrkD/QhyI4toP/SuIhSSgI1UQ2KZAuh+dZ0XxxdDmAh5cbqm+O28oV3AKCc2K0d9n51pyuVnc83QDk5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EzLCkWz1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vNEtL
	v/3kBJEzVxwQt25NOC9mRnmCXCCBtOoDIT636c=; b=EzLCkWz1UrGl4l89eNfgZ
	WsyJuWB8TD+Rc5kDSdVvc94C1PX7Hty+7StfQtbqVOcRPwjizBqTZRoBpQ5yalYD
	HiQPfDMP+xxCPtHWAQk+xGBfh3bjkD7Hh8yuGmcn9cRH55895gYLD4Fn1EXJ6rRL
	tb6ESq+wvahEABwR0TU5f0=
Received: from localhost.localdomain (unknown [120.244.62.148])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDnb4utXmBmCRXTCg--.38636S2;
	Wed, 05 Jun 2024 20:48:46 +0800 (CST)
From: Jiwei Sun <sjiwei@163.com>
To: nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev,
	paul.m.stillwell.jr@intel.com
Cc: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunjw10@lenovo.com,
	sjiwei@163.com,
	ahuang12@lenovo.com
Subject: [PATCH v3] PCI: vmd: Create domain symlink before pci_bus_add_devices()
Date: Wed,  5 Jun 2024 20:48:44 +0800
Message-Id: <20240605124844.24293-1-sjiwei@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnb4utXmBmCRXTCg--.38636S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr13Kr45urW3GF4ruF1DAwb_yoWrJFyxpF
	4rW3WjvrsrGw4fXayDA3y8Wry5Aa1vv34UJ3sxK34a939xAFy09rW0gFZ8Ar4jyFyqv3W2
	vwsrXF1a9wn8KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piX_-PUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiDx30mWVOEWsSDQABsw

From: Jiwei Sun <sunjw10@lenovo.com>

During booting into the kernel, the following error message appears:

  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
  (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.

This symptom prevents the OS from booting successfully.

After a NVMe disk is probed/added by the nvme driver, the udevd executes
some rule scripts by invoking mdadm command to detect if there is a
mdraid associated with this NVMe disk. The mdadm determines if one
NVMe devce is connected to a particular VMD domain by checking the
domain symlink. Here is the root cause:

Thread A                   Thread B             Thread mdadm
vmd_enable_domain
  pci_bus_add_devices
    __driver_probe_device
     ...
     work_on_cpu
       schedule_work_on
       : wakeup Thread B
                           nvme_probe
                           : wakeup scan_work
                             to scan nvme disk
                             and add nvme disk
                             then wakeup udevd
                                                : udevd executes
                                                  mdadm command
       flush_work                               main
       : wait for nvme_probe done                ...
    __driver_probe_device                        find_driver_devices
    : probe next nvme device                     : 1) Detect the domain
    ...                                            symlink; 2) Find the
    ...                                            domain symlink from
    ...                                            vmd sysfs; 3) The
    ...                                            domain symlink is not
    ...                                            created yet, failed
  sysfs_create_link
  : create domain symlink

sysfs_create_link() is invoked at the end of vmd_enable_domain().
However, this implementation introduces a timing issue, where mdadm
might fail to retrieve the vmd symlink path because the symlink has not
been created yet.

Fix the issue by creating VMD domain symlinks before invoking
pci_bus_add_devices().

Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
Suggested-by: Adrian Huang <ahuang12@lenovo.com>
---
v3 changes:
 - Per Paul's comment, move sysfs_remove_link() after
   pci_stop_root_bus()

v2 changes:
 - Add "()" after function names in subject and commit log
 - Move sysfs_create_link() after vmd_attach_resources()

 drivers/pci/controller/vmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..4e7fe2e13cac 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -925,6 +925,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		dev_set_msi_domain(&vmd->bus->dev,
 				   dev_get_msi_domain(&vmd->dev->dev));
 
+	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
+			       "domain"), "Can't create symlink to domain\n");
+
 	vmd_acpi_begin();
 
 	pci_scan_child_bus(vmd->bus);
@@ -964,9 +967,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_bus_add_devices(vmd->bus);
 
 	vmd_acpi_end();
-
-	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
-			       "domain"), "Can't create symlink to domain\n");
 	return 0;
 }
 
@@ -1042,8 +1042,8 @@ static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
-	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
+	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_remove_root_bus(vmd->bus);
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
-- 
2.27.0


