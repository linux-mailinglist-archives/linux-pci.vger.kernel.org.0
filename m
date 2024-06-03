Return-Path: <linux-pci+bounces-8184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A88D8490
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 16:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A28B226C7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEF312CD9D;
	Mon,  3 Jun 2024 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="blspyjEN"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D25115C3;
	Mon,  3 Jun 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423471; cv=none; b=U9zNJzMO93wpg9xtNDFgSo+10BQI/RbxoL+xmG9kbIA5zAKbfCi2y35xpDfiveuiELNkaO6YHNsetJYUsEd7vNVLVDAn1BLJfOPjL+sROmFAstcMdEFUGrRmeLON9oXBPreJKohCFYffHwwW36pxltLeuguxbJygEJVAx12bJgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423471; c=relaxed/simple;
	bh=Xoq1p+b3eBnSukSfe9FWye+UT3Hp7+xp0/RNktg5xCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ja8aFUebqZMiU71jPWvOrXjjLyYiNaZrcGBIiKKeX7kZMFz85sxtqlmVGCvRefPwLj6FjVyCN/Q3au9NpDD7qucT81NTqrAx/892pLeDsz+jDA0TDxXt9BLeH7WN8fXhwTVbOWEXN7uPrmoF3GoHeOCYZhbuu03cREaLb5gMPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=blspyjEN; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iXigc
	K1/rNJxXW9WTe11+jDAKyiolDNuGVVDMYRGuUs=; b=blspyjEN/rpWEKJ0FJsqo
	DuWO8ccEWGP56E3Ld1s6yAGjV6mqCWqrysW42U3RBzmA2ULMctHjQ2ODGKfWyaDR
	U9E7iduQQaDSox1li7vuZit+EBXrRPrWqOuqPS/v+ZNRLyLN/d+Mktyd1UKH44wo
	2xXFpfwqgf8YEBpALnewYs=
Received: from localhost.localdomain (unknown [120.244.62.148])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wDHr3IzzV1mhWbsCQ--.60420S2;
	Mon, 03 Jun 2024 22:03:32 +0800 (CST)
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
Subject: [PATCH] PCI: vmd: Create domain symlink before pci_bus_add_devices
Date: Mon,  3 Jun 2024 22:03:29 +0800
Message-Id: <20240603140329.7222-1-sjiwei@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHr3IzzV1mhWbsCQ--.60420S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr13Kr45urW3GF4ruF1DAwb_yoW5AFyrpF
	4rWay2yr9rGw4fXayDA348X34Yva1qv345J3s8K3429r9xAFyF9rW09rZ8AFWqyF4qka4a
	vwsrXF1S93Z8KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piX_-PUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiWxzymWV4JPg6sQABsn

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

sysfs_create_link is invoked at the end of vmd_enable_domain. However,
this implementation introduces a timing issue, where mdadm might fail
to retrieve the vmd symlink path because the symlink has not been
created yet.

Fix the issue by creating VMD domain symlinks before invoking
pci_bus_add_devices.

Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
Suggested-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/pci/controller/vmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..3f208c5f9ec9 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -961,12 +961,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	list_for_each_entry(child, &vmd->bus->children, node)
 		pcie_bus_configure_settings(child);
 
+	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
+			       "domain"), "Can't create symlink to domain\n");
+
 	pci_bus_add_devices(vmd->bus);
 
 	vmd_acpi_end();
-
-	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
-			       "domain"), "Can't create symlink to domain\n");
 	return 0;
 }
 
-- 
2.27.0


