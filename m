Return-Path: <linux-pci+bounces-10902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E393E822
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A6D1F214C0
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D915F3F0;
	Sun, 28 Jul 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5z8uFBo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FC815F3E6;
	Sun, 28 Jul 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182930; cv=none; b=n8772/Dld3z4W4zdLdh8zAF4aPbp91q1Zlu60/FolX8vsoZmQsBA3ddsdWmis8S4mW6h7T0Fdv7VgTdZKKb1xlbQ1okPDqR7YHFbzwIcmYFzs7wPzGvqho2usrRdcKa6WHmNGGzUbG9PjhCbMYEyoflu4CwjCw1b8B7wRzE/Alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182930; c=relaxed/simple;
	bh=AJmEPH33FrWe+f3WPuMEtoSocShVAGWSHROoTdVM6ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVj8Lo2wRUlWw1/RI4mOzS8Y9BLoBGzdWEXnLdKdgwA5BR+GpvV9laAdUQ/0ZZjQiuT0tGtSKBzO/bmv90X1glnq4J6KBsMKsRszeCt9e9CdH5GAl+e4G6I0BGydz8ouLDyL6CRB6rO1jYZiWsK2Xmhs/eJ7LT0KJ4Ti0HwPs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5z8uFBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31622C32782;
	Sun, 28 Jul 2024 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182929;
	bh=AJmEPH33FrWe+f3WPuMEtoSocShVAGWSHROoTdVM6ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5z8uFBongTyklrSuNYdXHh6MW42v2E3sTHghYrCefElapNGhVfSkEHnsfmUy2Y+e
	 j5BcFp+WvZBUtev8SlNfdH8e7oWHp0U73wa/B6Q8cb/xND8VjWlWb1Y03SuV5QcD56
	 k6uk1o0DdincJLdKLm3UytGOt7MvIyPwEqzG2sNBh94O+W3jaHslTLwYT1YBgDtAeb
	 aEDLOeKnFqRdp/lprOsSAQ319tt4dtZVV23gvB+OTXhd4j+bXCbvyXLI3EiZ6LLKEo
	 fU3UftOcgWu+wZP8BNw5j30xbCAt0NIdZkH++mOnEc2yqqwFRKA25NbbyMeEpScmym
	 Nq6L8NQyIu3xQ==
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
Subject: [PATCH AUTOSEL 6.1 13/15] PCI: vmd: Create domain symlink before pci_bus_add_devices()
Date: Sun, 28 Jul 2024 12:07:57 -0400
Message-ID: <20240728160813.2053107-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160813.2053107-1-sashal@kernel.org>
References: <20240728160813.2053107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 5c35884c226e6..a1dd614bdc324 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -870,6 +870,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		dev_set_msi_domain(&vmd->bus->dev,
 				   dev_get_msi_domain(&vmd->dev->dev));
 
+	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
+			       "domain"), "Can't create symlink to domain\n");
+
 	vmd_acpi_begin();
 
 	pci_scan_child_bus(vmd->bus);
@@ -907,9 +910,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_bus_add_devices(vmd->bus);
 
 	vmd_acpi_end();
-
-	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
-			       "domain"), "Can't create symlink to domain\n");
 	return 0;
 }
 
@@ -985,8 +985,8 @@ static void vmd_remove(struct pci_dev *dev)
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


