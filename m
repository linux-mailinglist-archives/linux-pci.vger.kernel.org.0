Return-Path: <linux-pci+bounces-20112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F0A160B8
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 08:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4898E1886869
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 07:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1741632E6;
	Sun, 19 Jan 2025 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiBYwuzW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1638143888;
	Sun, 19 Jan 2025 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737271690; cv=none; b=VZF96ivak1UYNn9n8LwV2S1jCQx5M6l9ahRJc1f29rTwTawR96Y6ONCLehfYBfuQM7IUs9Rl2spUmUophKgrSYR6VLvBZjA6LD7SjlLR2e26Md9eFlX2/GqA6w3kGJ+GoTAwcLzPfFn0MCwmq+fyoELMBFjexIoLYuB1EOGRJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737271690; c=relaxed/simple;
	bh=vyuqq862oTZFHsXsWE32eHjyKNnZNBjzLLQ1+k0W1yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXtmHW9QXRK2HiY+LFkLIqQrV/QKY62kIoU5H+GMxC1POi0eg23MmJOemcw2V/3qsqMu291JEIYXQWPv6cSUYtnDBEKSt5QfUSEv9NBGW65lazOZajgGuiniBIwofkkv4hOLMI8j2TNGSg63BIFXM9mCDSuZjNLv/RPQKGyiXaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiBYwuzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB621C4CED6;
	Sun, 19 Jan 2025 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737271689;
	bh=vyuqq862oTZFHsXsWE32eHjyKNnZNBjzLLQ1+k0W1yA=;
	h=From:To:Cc:Subject:Date:From;
	b=hiBYwuzW9awygvQMjoTkoB15QUXgn2LxPEfi3HQWH0qSrEXE0UJEQ3IVSWnho/gsV
	 G6o4xJV7JGilKdTR8JFfHXmu9n7JPYDjFmZ57ZtwYsFh1ZJeKK1JqC3J3j6kVMgwHn
	 mqaxXr/ow2q/Z76g1z9Sf9PKuyYXDFvPlfg2IHGzOWStI1ZPfIu/6bij2lJJB2u1Z4
	 D+vGC3+HC5tsOuavbK3ZGyLY1o6joXmAmckMcEVeW42v+jt+gdpsSx5qeipL/KvCRc
	 6BCkiqJHk5lum83VNXiRj+Q9cwxpLNG1w7PEqtP+wZzVBBBClCBjC5xcWAooFTEqDO
	 KKCfUXarGIL+Q==
From: Leon Romanovsky <leon@kernel.org>
To: 
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org,
	Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>,
	Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jean Delvare <jdelvare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4] PCI/sysfs: Change read permissions for VPD attributes
Date: Sun, 19 Jan 2025 09:27:54 +0200
Message-ID: <c93a253b24701513dbeeb307cb2b9e3afd4c74b5.1737271118.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The Vital Product Data (VPD) attribute is not readable by regular
user without root permissions. Such restriction is not needed at
all for Mellanox devices, as data presented in that VPD is not
sensitive and access to the HW is safe and well tested.

This change changes the permissions of the VPD attribute to be accessible
for read by all users for Mellanox devices, while write continue to be
restricted to root only.

The main use case is to remove need to have root/setuid permissions
while using monitoring library [1].

[leonro@vm ~]$ lspci |grep nox
00:09.0 Ethernet controller: Mellanox Technologies MT2910 Family [ConnectX-7]

Before:
[leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
-rw------- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
After:
[leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
-rw-r--r-- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd

[1] https://developer.nvidia.com/management-library-nvml
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v4:
 * Change comment to the variant suggested by Stephen
v3: https://lore.kernel.org/all/18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org
 * Used | to change file attributes
 * Remove WARN_ON
v2: https://lore.kernel.org/all/61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org
 * Another implementation to make sure that user is presented with
   correct permissions without need for driver intervention.
v1: https://lore.kernel.org/all/cover.1731005223.git.leonro@nvidia.com
 * Changed implementation from open-read-to-everyone to be opt-in
 * Removed stable and Fixes tags, as it seems like feature now.
v0: https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
---
 drivers/pci/vpd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index a469bcbc0da7..c873ab47526b 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -332,6 +332,13 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
 	if (!pdev->vpd.cap)
 		return 0;
 
+	/*
+	 * On Mellanox devices reading VPD is safe for unprivileged users,
+	 * so just add needed bits to allow read.
+	 */
+	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
+		return a->attr.mode | 0044;
+
 	return a->attr.mode;
 }
 
-- 
2.47.1


