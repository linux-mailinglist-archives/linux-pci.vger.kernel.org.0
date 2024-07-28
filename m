Return-Path: <linux-pci+bounces-10890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB0C93E7BF
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE5B1F22AAF
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30313E032;
	Sun, 28 Jul 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaAkpKqR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98513E021;
	Sun, 28 Jul 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182807; cv=none; b=om0M5hl3R7AEs9HwMTLBwukbJ+6qFcsgVghdeIv1m3iNZonMEZO0814T5vW4k6eG2C2Q7ArSw1gWxImmXf5QUYxX12nLOHhZtlxs+IaYStndcjGe8k0aTC+W6r+r55mJdwbbsZu8AHrkSqoh6D5tgJVhskVmOpqRcdOOaWj+VS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182807; c=relaxed/simple;
	bh=nJWpP4D2fWvNv5iki6UL8RpY+6Z0N9MsvKDPnjVrleU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRRCX6khB1kZi5LBZF/KTYPjRXwsDAVYdMZg6iHRNaJsS17s26XBvevbXn5Jc+X3Nb1MPsEQlgKZRa6C4hdy9yoIl9dHeZdS3MvvuZ9MppI7fdB6dDNmeS+ICksmW0xfBa6lDWvePZZJr+m+uho4uXBRhfHB982Toc3M1A4iWlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaAkpKqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828AAC4AF0E;
	Sun, 28 Jul 2024 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182806;
	bh=nJWpP4D2fWvNv5iki6UL8RpY+6Z0N9MsvKDPnjVrleU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KaAkpKqR0rCJpSjDD1hmDSnJ+yATpzVVjWMLesbiBHRvuQIuC9iwoWdVZ6oaRKUCP
	 74hB0LIPIn+dj3akJGEtYXxxsm1VoV9+JO33Kpg7e7khyOeo8vr02xh+V9O02EyrAw
	 4wMuOuqnseYbSBFdTkwba3++pOHJQ5gUnqBhe3PCbwQYKrtWf+8XT0zLYbRedbn5Fr
	 Vq+63sPZE0oic+H+AnuIzC7z8Wfb/r+7nS8ER5lES/u3UlpQekzwpwH8tlntSAJ0sv
	 t7l2gybnK/cc+ZbUGhEXGKGbCwKcmgnnp7qXPioWWUQD4a8339/YKrJycwPWeOCRG9
	 wuUjbAyyf8kPQ==
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
Subject: [PATCH AUTOSEL 6.10 21/23] PCI: vmd: Create domain symlink before pci_bus_add_devices()
Date: Sun, 28 Jul 2024 12:05:02 -0400
Message-ID: <20240728160538.2051879-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 87b7856f375ab..4e7fe2e13cacb 100644
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


