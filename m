Return-Path: <linux-pci+bounces-16279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297AE9C0E23
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 19:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 713BAB22EC0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638BA217678;
	Thu,  7 Nov 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld6Ej07D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881E2170D6;
	Thu,  7 Nov 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005834; cv=none; b=SnJ3D1F23249JGOze7ODGCI2gKwSvNML94EefvSWBX/iGYHqM2TFKf+3+dzIkAAy2TXxSpJDtaZD69aEanXxFUUArOsz4CdlRGZ2zV3BieRA8SeKli69ULdxiOEXSkKr2hJZPEoZtcuAuiZugroeykR3hEJwOtt8t0nODDHinuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005834; c=relaxed/simple;
	bh=7paQa5ZsDu1PZxVYxX8jR4ViS0jnHDD2m+t5fDLAccY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRIj1dUSlOe/OoWyeF29PMdVJVP4aI5fPbXoQOGwXDesZCqWAO1txo9yHwSaOxrctUfacmS/BrS0cjspNfqeW7MLnmUtuRCLvXEsje+AOjwy7z92/L39hvgtgYPYLdHaeblJ6oiqkTqaxenAfhwp5G36bzmJ7P5p8b+jxGh6Vgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld6Ej07D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36021C4CECC;
	Thu,  7 Nov 2024 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731005833;
	bh=7paQa5ZsDu1PZxVYxX8jR4ViS0jnHDD2m+t5fDLAccY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ld6Ej07DhUE8JDrF+hEIBh2+d31pwfA3ome9c5Nal+GcUw5Jn/vITYAkStDq5Cb3D
	 7aTH2A5hFZ2DMPXVmZc+8aYyoPq6Nqez+3SyoF3itCNEU6F3NxzlCz71L/DFHiwFV5
	 v3FEJzTxAAnQK1YSXx7BK+btM7MakQ0JeiWpuMtseFgqQqSCnxnIIeAS6k9djwdleq
	 3mDPuHCGBgGUJyINbMRhgmUBkxB06Ek0Nu1c0ex6pgnxCYllF8zPVNya2FkVYFwwqm
	 iK7y++KhwpTPVDQ5UydWfs9UfkCm1cJXG5hWaBm5IChtrsjdv+BO4XZHejYKfn0Alq
	 6E2wpLKYYreOg==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org,
	"Ariel Almog" <ariela@nvidia.com>,
	"Aditya Prabhune" <aprabhune@nvidia.com>,
	"Hannes Reinecke" <hare@suse.de>,
	"Heiner Kallweit" <hkallweit1@gmail.com>,
	"Arun Easi" <aeasi@marvell.com>,
	"Jonathan Chocron" <jonnyc@amazon.com>,
	"Bert Kenward" <bkenward@solarflare.com>,
	"Matt Carlson" <mcarlson@broadcom.com>,
	"Kai-Heng Feng" <kai.heng.feng@canonical.com>,
	"Jean Delvare" <jdelvare@suse.de>,
	"Alex Williamson" <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v1 1/2] PCI/sysfs: Change read permissions for VPD attributes
Date: Thu,  7 Nov 2024 20:56:56 +0200
Message-ID: <f93e6b2393301df6ac960ef6891b1b2812da67f3.1731005223.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731005223.git.leonro@nvidia.com>
References: <cover.1731005223.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The Vital Product Data (VPD) attribute is not readable by regular
user without root permissions. Such restriction is not really needed
for many devices in the world, as data presented in that VPD is not
sensitive and access to the HW is safe and tested.

This change aligns the permissions of the VPD attribute to be accessible
for read by all users, while write being restricted to root only.

For the driver, there is a need to opt-in in order to allow this
functionality.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/vpd.c   | 9 ++++++++-
 include/linux/pci.h | 7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index e4300f5f304f..7c70930abaa0 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -156,6 +156,7 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			    void *arg, bool check_size)
 {
 	struct pci_vpd *vpd = &dev->vpd;
+	struct pci_driver *drv;
 	unsigned int max_len;
 	int ret = 0;
 	loff_t end = pos + count;
@@ -167,6 +168,12 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 	if (pos < 0)
 		return -EINVAL;
 
+	if (!capable(CAP_SYS_ADMIN)) {
+		drv = to_pci_driver(dev->dev.driver);
+		if (!drv || !drv->downgrade_vpd_read)
+			return -EPERM;
+	}
+
 	max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
 
 	if (pos >= max_len)
@@ -317,7 +324,7 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
 
 	return ret;
 }
-static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
+static BIN_ATTR_RW(vpd, 0);
 
 static struct bin_attribute *vpd_attrs[] = {
 	&bin_attr_vpd,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..b8fed74e742e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -943,6 +943,10 @@ struct module;
  *		how to manage the DMA themselves and set this flag so that
  *		the IOMMU layer will allow them to setup and manage their
  *		own I/O address space.
+ * @downgrade_vpd_read: Device doesn't require root permissions from the users
+ *              to read VPD information. The driver doesn't expose any sensitive
+ *              information through that interface and safe to be accessed by
+ *              unprivileged users.
  */
 struct pci_driver {
 	const char		*name;
@@ -960,7 +964,8 @@ struct pci_driver {
 	const struct attribute_group **dev_groups;
 	struct device_driver	driver;
 	struct pci_dynids	dynids;
-	bool driver_managed_dma;
+	bool driver_managed_dma : 1;
+	bool downgrade_vpd_read : 1;
 };
 
 #define to_pci_driver(__drv)	\
-- 
2.47.0


