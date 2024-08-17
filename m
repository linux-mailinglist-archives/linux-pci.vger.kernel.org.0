Return-Path: <linux-pci+bounces-11782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C540955536
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 05:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E1C2822E2
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 03:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA326AED;
	Sat, 17 Aug 2024 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKAq/xkR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C2F507;
	Sat, 17 Aug 2024 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723864964; cv=none; b=iLEe5cWGXedgsSzJT9SF0/hR7LVXpoCeienMc64bXz18+d+cGz2P1og0X+RuscS7Rz+4KpRX1k1BgvAdYRoyALeEkZoNE4+2Ob7djmlN5FO5wB6df/38MK5TKxCXxX6LR4E265dQc2fQ2M72JKLg1hUBqeVEWkiP+vz7c32Nd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723864964; c=relaxed/simple;
	bh=PK1gtm+3JXc0XeI/lpDSKVfzle9AZFrvPpYDWKo8t1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqcoeXr3IR+veUjMBRB1jZICstMjV8QW7WYcNg1nqPpOE/B9juW0beqkcNNMprZq2is24YkmmK99t/h8umilWen8KhZ1a3QP/wpyufYOgA2TNLZH9kxi0eWBFkV+lDyG5Ju19K9Pa0Qt8iPCfxPOiNdHJgfeJ0wHDeO1T8rnahI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKAq/xkR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so1767623b3a.1;
        Fri, 16 Aug 2024 20:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723864962; x=1724469762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vuEKBbm6jzfUML/VgRcrXFhdwGGxYBzUG3C/0kVpiDc=;
        b=IKAq/xkRk/3x8yjI49JuuSO8RnZ0HS5xswTGZmfzd9z4iFWThEzWKVE8/xvtjJpDlF
         BAnOkD1P9QswHsxXUwKwWt/2+dNizjPsvWxghL8G3JhG56ET4zYb1Qifx7ruVwXhzGIe
         52jfGMQsuG/wnQNrqO9UPe4e9076pK9eEjZHJ8Qi8q+Uu+rkJgSu2IsWkote3BD81ois
         I1tijZtlMuf0z1lfYvLjFEpuPOizvLKRcMBsv2Ptm1/bnULMYDvkNVCrKzMsk00UJ1v3
         yPRmX0lFhUKzxqMCvrDJbA+x+gdWhE//jrGxfOTYwQ9NAPb6AsCOVtVJtwVzbyUlwdV/
         GvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723864962; x=1724469762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuEKBbm6jzfUML/VgRcrXFhdwGGxYBzUG3C/0kVpiDc=;
        b=i6nI3ng/CdpGdkaACP2Yl7gJfaVcuZTmG+XRxS/ZCdL9X0/x6o6/SeTDETA5EQuQc2
         9T4dThMzAkcqbMOcwoFbMNM0a2D/2UowHkNbviiKCB/q3iSZ7jJ4godKmzwZY7Hqb2IK
         sOwoiQ8OJHs3n2CYlJiLw7I/MQpLE+BA44slKm4fR6P0JSqmdvR0lARF01cUb9rbiYmD
         n49K6y96ttdchu3p/Mh+O5Szh1/b700GKD/1Lj0WYdK0+9Lla7QhgzEpjiYIPEMMp3Fy
         igTCggVRPGHOXfd2kdDVh05ekzWszn3h0Y1MyjqQSgUcaZG7CCeWswKSqdl5bpjls2vX
         UtJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXewx2APurvGTyEQr7AWBhKO8P0R86b2whYamzr1I9s66bl8eaQSik1xDKVxxOhVkS7/bcJ7syU/xNNBhjqNPFbE4K2mPk/CwPdh2mAnW43xP1tXApemqXDkQgmjpOL+La60CJk/+Bj
X-Gm-Message-State: AOJu0YyxN4SCmhhJvH2j7lksSt+iJikgB4lZRE3GjTBR3Bfm5FuVxZr9
	cBREV6kqMvRGG5/VS9ERPKSlfZONawlAyq35rPkNdqAUpldfvVu62rmsi2Pd
X-Google-Smtp-Source: AGHT+IEbao6TQprQVW2pxjTIigzWQzbzajV9N2mFttq/cDQvfVXiT6BHISHYdHCgFd+zojQOma7g8g==
X-Received: by 2002:a05:6a20:9f04:b0:1c0:f785:b2d4 with SMTP id adf61e73a8af0-1c90504841dmr5448847637.47.1723864962237;
        Fri, 16 Aug 2024 20:22:42 -0700 (PDT)
Received: from localhost.localdomain ([187.120.159.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae07443sm3286878b3a.48.2024.08.16.20.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 20:22:41 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	wsa+renesas@sang-engineering.com,
	lukas@wunner.de
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: hotplug: check the return of hotplug bridge  In some pci drivers, when the pci bridge is added if the process return an error, the drivers don't check this and continue your execute normally. Then, this patch change this drivers for check return of pci_hp_add_bridge(), and if has an error, then the drivers call goto lable , free your mutex and return the error for your caller.
Date: Sat, 17 Aug 2024 00:22:27 -0300
Message-ID: <20240817032228.6844-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/pci/hotplug/cpci_hotplug_pci.c | 7 +++++--
 drivers/pci/hotplug/cpqphp_pci.c       | 9 ++++++---
 drivers/pci/hotplug/ibmphp_core.c      | 8 ++++++--
 drivers/pci/hotplug/pciehp_pci.c       | 7 +++++--
 drivers/pci/hotplug/shpchp_pci.c       | 7 +++++--
 drivers/pci/probe.c                    | 9 ++++++---
 6 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
index 6c48066acb44..2d3256795eab 100644
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -269,8 +269,11 @@ int cpci_configure_slot(struct slot *slot)
 	parent = slot->dev->bus;
 
 	for_each_pci_bridge(dev, parent) {
-		if (PCI_SLOT(dev->devfn) == PCI_SLOT(slot->devfn))
-			pci_hp_add_bridge(dev);
+		if (PCI_SLOT(dev->devfn) == PCI_SLOT(slot->devfn)) {
+			ret = pci_hp_add_bridge(dev);
+			if (ret)
+				goto out;
+		}
 	}
 
 	pci_assign_unassigned_bridge_resources(parent->self);
diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index e9f1fb333a71..5f6ce2c6385a 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -70,7 +70,7 @@ static void __iomem *detect_HRT_floating_pointer(void __iomem *begin, void __iom
 int cpqhp_configure_device(struct controller *ctrl, struct pci_func *func)
 {
 	struct pci_bus *child;
-	int num;
+	int num, ret = 0;
 
 	pci_lock_rescan_remove();
 
@@ -97,7 +97,10 @@ int cpqhp_configure_device(struct controller *ctrl, struct pci_func *func)
 	}
 
 	if (func->pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		pci_hp_add_bridge(func->pci_dev);
+		ret = pci_hp_add_bridge(func->pci_dev);
+		if (ret)
+			goto out;
+
 		child = func->pci_dev->subordinate;
 		if (child)
 			pci_bus_add_devices(child);
@@ -107,7 +110,7 @@ int cpqhp_configure_device(struct controller *ctrl, struct pci_func *func)
 
  out:
 	pci_unlock_rescan_remove();
-	return 0;
+	return ret;
 }
 
 
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 197997e264a2..73a593c2993b 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -663,6 +663,7 @@ static int ibm_configure_device(struct pci_func *func)
 	int num;
 	int flag = 0;	/* this is to make sure we don't double scan the bus,
 					for bridged devices primarily */
+	int ret = 0;
 
 	pci_lock_rescan_remove();
 
@@ -690,7 +691,10 @@ static int ibm_configure_device(struct pci_func *func)
 		}
 	}
 	if (!(flag) && (func->dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
-		pci_hp_add_bridge(func->dev);
+		ret = pci_hp_add_bridge(func->dev);
+		if (ret)
+			goto out;
+
 		child = func->dev->subordinate;
 		if (child)
 			pci_bus_add_devices(child);
@@ -698,7 +702,7 @@ static int ibm_configure_device(struct pci_func *func)
 
  out:
 	pci_unlock_rescan_remove();
-	return 0;
+	return ret;
 }
 
 /*******************************************************
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 65e50bee1a8c..0c4873c2ef3c 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -58,8 +58,11 @@ int pciehp_configure_device(struct controller *ctrl)
 		goto out;
 	}
 
-	for_each_pci_bridge(dev, parent)
-		pci_hp_add_bridge(dev);
+	for_each_pci_bridge(dev, parent) {
+		ret = pci_hp_add_bridge(dev);
+		if (ret)
+			goto out;
+	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index 36db0c3c4ea6..7db0ce966f1d 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -48,8 +48,11 @@ int shpchp_configure_device(struct slot *p_slot)
 	}
 
 	for_each_pci_bridge(dev, parent) {
-		if (PCI_SLOT(dev->devfn) == p_slot->device)
-			pci_hp_add_bridge(dev);
+		if (PCI_SLOT(dev->devfn) == p_slot->device) {
+			ret = pci_hp_add_bridge(dev);
+			if (ret)
+				goto out;
+		}
 	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..2418998820dc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3363,9 +3363,10 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 		if (!pci_find_bus(pci_domain_nr(parent), busnr))
 			break;
 	}
+
 	if (busnr-- > end) {
 		pci_err(dev, "No bus number available for hot-added bridge\n");
-		return -1;
+		return -ENODEV;
 	}
 
 	/* Scan bridges that are already configured */
@@ -3380,8 +3381,10 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 	/* Scan bridges that need to be reconfigured */
 	pci_scan_bridge_extend(parent, dev, busnr, available_buses, 1);
 
-	if (!dev->subordinate)
-		return -1;
+	if (!dev->subordinate) {
+		pci_err(dev, "No dev subordinate\n");
+		return -ENODEV;
+	}
 
 	return 0;
 }
-- 
2.46.0


