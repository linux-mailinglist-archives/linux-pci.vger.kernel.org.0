Return-Path: <linux-pci+bounces-16652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1789C7028
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810FC28166E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B861EF955;
	Wed, 13 Nov 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKPmHZ0m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF1189F43;
	Wed, 13 Nov 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502813; cv=none; b=orQRHwgOpz3pb0g75OxRfkUvSANHbV3J0knAJUTzVyKwsIBToivdBttQJit5TqlgQHkBAmrNjDdFmfvyxJlZpeXm7xe37uXO99Po50FinwNy2Eo9PWLI9Zk2jQgjHFIMjMS0put6lDee78F1tcX7ah8u9lHhM7mxf3fVzJmdHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502813; c=relaxed/simple;
	bh=bERcuiTrodbMVz9bZMzqI9+zT+hui4kXno/B68edjJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXPZa9vuCUjWWDxGHbx7F2188Yvae4GGV6q0XuNUm0QSms0CkEm82URfAutPhICnKoSFQuygluMVYDXzdiv8Hpw9LyZqsdDpneOwdS5MHdmji2qgSkwlNNzSbML0GdST/6P//B04Wl66HoWGZWXYyVeFgkDQO4LtYDOMTqUUblg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKPmHZ0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751FFC4CECF;
	Wed, 13 Nov 2024 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731502813;
	bh=bERcuiTrodbMVz9bZMzqI9+zT+hui4kXno/B68edjJk=;
	h=From:To:Cc:Subject:Date:From;
	b=kKPmHZ0mRL/79giaPZBz13U7OYjW/x5l5Ai2oY8fU/kqLgHlU8xHMyaw7f/RxmRSq
	 4jl0uLt5ZV9yDz67FaXggb6aT/0LOvbi5Cv1PAXgR8YjSYv+s4Jd8kJxPp0GsQtesi
	 LqiO6pf0UqKWKQPMsa0Ww9gUksGzj9lfh9RWpoYbifspJH5SNQqymF9aPCWzeQ1W4b
	 8oUE9g3RhAt34v1Ut+7QMoJB9QezZae94FdwYHcVmGYrTUpmlL99uJuFWvigOP7aWV
	 guKyXnv6Uq2Mg0mI37RugA9pBqT1wwQzUjnUMQMLvOvlIn6WVKJ0U15PjHZsaohXL+
	 CDRcjNXWIZpSA==
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
Subject: [PATCH v2] PCI/sysfs: Change read permissions for VPD attributes
Date: Wed, 13 Nov 2024 14:59:58 +0200
Message-ID: <61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
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
v2:
 * Another implementation to make sure that user is presented with
   correct permissions without need for driver intervention.
v1: https://lore.kernel.org/all/cover.1731005223.git.leonro@nvidia.com
 * Changed implementation from open-read-to-everyone to be opt-in
 * Removed stable and Fixes tags, as it seems like feature now.
v0:
https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
---
 drivers/pci/vpd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index e4300f5f304f..9d5a35737abf 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -332,6 +332,14 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
 	if (!pdev->vpd.cap)
 		return 0;
 
+	/*
+	 * Mellanox devices have implementation that allows VPD read by
+	 * unprivileged users, so just add needed bits to allow read.
+	 */
+	WARN_ON_ONCE(a->attr.mode != 0600);
+	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
+		return a->attr.mode + 0044;
+
 	return a->attr.mode;
 }
 
-- 
2.47.0


