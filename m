Return-Path: <linux-pci+bounces-10896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728F93E7F6
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C55528210B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFBE149C4A;
	Sun, 28 Jul 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUyqYbVw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB691494D5;
	Sun, 28 Jul 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182873; cv=none; b=ec+UwQUeIfJyQ9D7vFN+khCUMo/6gRQyCRwUMNCQdIvJuhaUkW0UeG/a72rSkneLO6ln6XL4NjWTVYmrdCkjd7G6l/vzb4gzOF7IngSJiXBP+UwKGiY4lyRdk5w1pcSLg/4mi9OLXL01DSFzwzS+HcQQE3Sr54Q7xYEtuQn3SO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182873; c=relaxed/simple;
	bh=qOnhw1++BWyJ2X/uSE59EcgFPqdi8NgeYJwgN7VE8IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Scka+jlkt1wnaG2nF/Z7D4A6hUKh7Lns9bD+CRJaSKmgqa8OsaoMnu9fSITQdaUnKUhNeeDMUwIfolUtBuy/hCGqDyIwn1ZSriin4ynF13cB91BTXD+Kqbjv08xRtOlNbZ7xD0ThiPY70JU2FNK7GXl1SNzNXZL1qUELLF9LVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUyqYbVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF7EC4AF0E;
	Sun, 28 Jul 2024 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182873;
	bh=qOnhw1++BWyJ2X/uSE59EcgFPqdi8NgeYJwgN7VE8IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUyqYbVwTi3g34UYD7cP3/g/rQGzumgWoQLipEakrslds89rby0pJRu2n1Qrripd3
	 oFyD0Iz5PfoVxVYlp6mzHeAa8qc91SmalCTJnZ4VR9rIEXBFmuSuDDtU8LqHFGJbR5
	 zmLHBHrvSlLQ6E6gwqMFKK5Yv0lXe5s0z47fh8vDQru2ZgbexsOlQhO+f21/OrGvK3
	 Tl5J5P3hymsjdwv+2b5MBisJmq02cqQIIehXQ8CDiAtDHLAfwGQ/dVrFPN/o8N3VwM
	 AIeaF+7X/BwjXuKWd7toQroM6GeXDDRfn7U0ueNrkOSSL1Y1pF1o0vyUYBgy6Hntln
	 rGbHNO/VWbQmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lpieralisi@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/17] PCI: vmd: Create domain symlink before pci_bus_add_devices()
Date: Sun, 28 Jul 2024 12:06:51 -0400
Message-ID: <20240728160709.2052627-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160709.2052627-1-sashal@kernel.org>
References: <20240728160709.2052627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Jiwei Sun <sunjw10@lenovo.com>

[ Upstream commit f24c9bfcd423e2b2bb0d198456412f614ec2030a ]

The vmd driver creates a "domain" symlink in sysfs for each VMD bridge.
Previously this symlink was created after pci_bus_add_devices() added
devices below the VMD bridge and emitted udev events to announce them to
userspace.

This led to a race between userspace consumers of the udev events and the
kernel creation of the symlink.  One such consumer is mdadm, which
assembles block devices into a RAID array, and for devices below a VMD
bridge, mdadm depends on the "domain" symlink.

If mdadm loses the race, it may be unable to assemble a RAID array, which
may cause a boot failure or other issues, with complaints like this:

  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
  (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.

This symptom prevents the OS from booting successfully.

After a NVMe disk is probed/added by the nvme driver, udevd invokes mdadm
to detect if there is a mdraid associated with this NVMe disk, and mdadm
determines if a NVMe device is connected to a particular VMD domain by
checking the "domain" symlink. For example:

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
      : probe next nvme device                     : 1) Detect domain symlink
      ...                                            2) Find domain symlink
      ...                                               from vmd sysfs
      ...                                            3) Domain symlink not
      ...                                               created yet; failed
    sysfs_create_link
    : create domain symlink

Create the VMD "domain" symlink before invoking pci_bus_add_devices() to
avoid this race.

Suggested-by: Adrian Huang <ahuang12@lenovo.com>
Link: https://lore.kernel.org/linux-pci/20240605124844.24293-1-sjiwei@163.com
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 6ac0afae0ca18..8622d7507c869 100644
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
2.43.0


