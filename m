Return-Path: <linux-pci+bounces-17571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4CC9E1BE8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 13:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D4E2811A7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8441E47D3;
	Tue,  3 Dec 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipPyB05b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E11D88C7;
	Tue,  3 Dec 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228148; cv=none; b=brTXxX48PgODJOfXnUTanntRTmdVw6GLsDGOe6m7yl/SP/NbXUpRz49QrcROTKXCPqFyDAo7Uip4azScylnYVOXFVK/SFQmxFMs+v6TTda4MpzUo8MRi7kp9yxW+Z8wDKxK3prUJ9OruBEAggplWhqqb0n7OM8Q2GLB9MlrsTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228148; c=relaxed/simple;
	bh=6IqNQTlTwVoxcL6WdHE1SoX7Ox5UCYXcPTe4ITJD53s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HruutaOQJ5eJcSd+LQYUFyscxUxO+A2FwKK+mjJ80x2ebKAmsCM0FHNHfWcIVvNbE7Z3zROtpEMi2YUuoLCnKZoIMEhycw+e6kGLallyLNtPV+NOKNnFkRBsaHlv7/j1Hbx/63NvIjlS3nRaJlu8WaNnxB+H5H0nLUbVMiJdzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipPyB05b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5884CC4CECF;
	Tue,  3 Dec 2024 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733228148;
	bh=6IqNQTlTwVoxcL6WdHE1SoX7Ox5UCYXcPTe4ITJD53s=;
	h=From:To:Cc:Subject:Date:From;
	b=ipPyB05b+8RBatEPutLb4AUgYMD8vZ9HfqJfzgQbR/4HDLwid3bTC67d4RHxe7TpB
	 EWExgZRmk4DKxfKZGW4kFBGFeYDFaibNqJeBpAQ2sanIO852zW0FVS/JKDB/SQugYG
	 Zrtzy13t2oARfQ7DeS8rnsvs+bAIim9vzNOT1E3e2eUSfOLoK/QTe0v57QQpiNBlVl
	 p4SDxX3kt1McvSwXUU1/QbsB0V8T1sOuZ4sUAVOF7FmTtv285Pge26NsLojh08Toeh
	 bGbqFPVJozydldQk0LJEj0il4AUNNWBnxwNMrBomy7rCOURZiXQtNIqL3SqUdAI6cw
	 dLQWu4P8gzdGw==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
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
Subject: [PATCH v3] PCI/sysfs: Change read permissions for VPD attributes
Date: Tue,  3 Dec 2024 14:15:28 +0200
Message-ID: <18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v3:
 * Used | to change file attributes
 * Remove WARN_ON
v2: https://lore.kernel.org/all/61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org
 * Another implementation to make sure that user is presented with
   correct permissions without need for driver intervention.
v1: https://lore.kernel.org/all/cover.1731005223.git.leonro@nvidia.com
 * Changed implementation from open-read-to-everyone to be opt-in
 * Removed stable and Fixes tags, as it seems like feature now.
v0:
https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
---
 drivers/pci/vpd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index a469bcbc0da7..a7aa54203321 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -332,6 +332,13 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
 	if (!pdev->vpd.cap)
 		return 0;
 
+	/*
+	 * Mellanox devices have implementation that allows VPD read by
+	 * unprivileged users, so just add needed bits to allow read.
+	 */
+	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
+		return a->attr.mode | 0044;
+
 	return a->attr.mode;
 }
 
-- 
2.47.0


