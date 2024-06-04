Return-Path: <linux-pci+bounces-8237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2588FB4CB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E96E1C2146E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD9179AF;
	Tue,  4 Jun 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G8xkl4ms"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DC1758E;
	Tue,  4 Jun 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510083; cv=none; b=beIdxLjPRMktuaRwdgJstf7aazCoGzpX8dU/QXYOnwo64cPWTnteGlbkopFXE4wdghwDiqscaDboPl59H/NJGbFK3HFdj39P+L2eonROYnkNxJ/LLd2v+eD6iDWR+Pn6jWmCfbmtcVSkub2yJ4Jz0w/dVrlK7eEh7tAV986zBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510083; c=relaxed/simple;
	bh=z7yEEpK74vp1Pi/nTAMGb9uyRtbHGpKYCmr4Vsd8P2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQNWWeWgyXU708UgdL+R9ywagr6NNZ7CkpyYveA8rct/iy0AksrNacftfYDAFYgrG9Zy38rKVM+cc+SM9vw8UAg35WJAeN6P1n/1pSOmHOXTTJvX9ucfQSoDWxYaaIygp6Ut39kHdFpV09gJ4KOn8oOAHOJMFGt8BmLjBYbHsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G8xkl4ms; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LINxQ
	OPMwvx6YSrPDiJL1/lBlysJrvaDgFr6Q9/0zno=; b=G8xkl4msnSzL2ZK9iYuDS
	4aXzFXOxKkE5kbiOPqYA5CTN9H2efE8GWiUgLIjycwfqMc3DyAju9yff2UomkpFO
	Y+Qc59yMvOU50n6wyR8SIMtJjL2oEzEH3iElnqZPN+9nmjReE8sePzV7+gMeHzG6
	eMxL0Rjta9yV0v2krbVxcM=
Received: from localhost.localdomain (unknown [120.244.62.148])
	by gzga-smtp-mta-g3-3 (Coremail) with SMTP id _____wCXLyL6G19msUX7Cw--.28684S2;
	Tue, 04 Jun 2024 21:51:55 +0800 (CST)
From: Jiwei Sun <sjiwei@163.com>
To: nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev
Cc: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunjw10@lenovo.com,
	sjiwei@163.com,
	ahuang12@lenovo.com
Subject: [PATCH v2] PCI: vmd: Create domain symlink before pci_bus_add_devices()
Date: Tue,  4 Jun 2024 21:51:53 +0800
Message-Id: <20240604135153.9182-1-sjiwei@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXLyL6G19msUX7Cw--.28684S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr13Kr45urW3GF4ruF1DAwb_yoW5Zw4UpF
	4rWa12vrZrGw4fXayDA3y8Xry5Aa1vv34UJ3s8K34Uua98AFyF9rW0grZ8Ar4qyF1qv3W2
	vwsrXF1a93Z8KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piuyIUUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiWx3zmWV4JRGdOwAAsj

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
v2 changes:
 - Add "()" after function names in subject and commit log
 - Move sysfs_create_link() after vmd_attach_resources()

---
 drivers/pci/controller/vmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..d0e33e798bb9 100644
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
 
-- 
2.27.0


