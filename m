Return-Path: <linux-pci+bounces-12555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5579671CE
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B80B20D43
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA881171D;
	Sat, 31 Aug 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov0hALNl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB81097B;
	Sat, 31 Aug 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725110920; cv=none; b=UwUx+m7ACECQbNv4tmayNaw029prqN4JweroEXJsM5icO466LN1UKvtTUAym6lPKsiQX5kh9s2WlYzZhSb1fuaE6EKM3vN6s+YYKfm8mNK+oTAe2qoQ1x240blgdCgj3Fz3o/3c/rKnVL53l+Yj9mtFPnV5gdE1Jes7EprPlCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725110920; c=relaxed/simple;
	bh=kdEhp/Kg27kne0vOQ2RDduD1wKCXvRJ42Jc1+k5J+XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYvRBryuVbqgZLWDKwM4BKvUJ/JLKUc+N8u2TpC56nMjCEDnEi+MzbCrEDQvP2qm0cj25WCHaRDJXVyuKi/zDrc6uwBt/n6CfVvDvUVmm56xOlbiGqdmu0ToqRjYIh8ztdqvetrUKgiibyUQ62N8Rfzwu67Y/pxnYZRnB6xpyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov0hALNl; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-277c861d9f6so496185fac.2;
        Sat, 31 Aug 2024 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725110917; x=1725715717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBh1jjPkZpHihQJDhRtC8nDyBpN1Y8R089uuo6Q3AtU=;
        b=Ov0hALNldp4XimpOj5bRM9o+8abVd/IQXPsvdQ8Ky5Ge1Lsh7zAiJCUBGYc0eVQZlE
         wgU399Py9jGF3TnEkK1RFMKw/RvEQlCuxbTSU6Jzw3/Gh7kFwKkXqMugftGBdb2/sImN
         nJeMvs4yFalT0TKWzLVqjzUh1aYZis7kTTj8oHUYayFAV621XcpLAzCo0HtyZh9U/DHB
         maXRWGmpzVXmAXK1DW6Wa7OeXromXQSGQi9xLzd98WUnkgdqWdGLodFASFXmFnphLzv6
         EQOS1G5KmRav/R9e/I8Di2lFml6pee8B29xq9mbwIoAJfpIXvaUUA+Lr4tAijXdVaRqh
         yiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725110917; x=1725715717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBh1jjPkZpHihQJDhRtC8nDyBpN1Y8R089uuo6Q3AtU=;
        b=OHZwTkbg44PlihUaE+lcs7/DGTq5x/qN4u3f5KU9pRD4bkjSLzXDpgvbKCOYliYjs6
         eRzHfEBbhNvJ2Mpge7nHue8stybntSoQ0j+r3r4pgfAShjM7GN+8pEjipmq8hdL7NlW6
         CuSvcGDlMmJV7pAOslLD8ESEWAtbev5qwSn8KyOpIz1oM0/I/sbtMONi1MFCedu3AC8A
         6q7d+utvisg8TXEdEkO/iTYHWCpZR6Pc2z1/EbGYw5tdDpXKaeRpRKx4OgfTpIGzWRMK
         XraFp2AEU1mjkP2UCGXcibWZrqzO8liaRgS6Bev4AzYVjrhfDBKxL+zOqCN0RoBBI5Xf
         11HA==
X-Forwarded-Encrypted: i=1; AJvYcCU0mW5xBaWhyN5BRwhWejF8ubIyOsHn4rx5iB3qQTekqcTaWIlTZlYqH7w9PPElDUC7f74qssQKiaDp@vger.kernel.org, AJvYcCUefv+B3V+Xi55r451pBd/fC9gITziQrgQw1a8vtUAqyVHxtnyVhbEB2GdoHZ9sEze9QElmWtEoehDbW/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEw91sggJLjGqDtpiluNe9QQr02vteL4T6DsgnIGlST0yheK0g
	X6fNzqqMevUL3MeQEkop/H9HQQg5gth40laOY3heO23futg0WfFx
X-Google-Smtp-Source: AGHT+IHDnxfBiDMHwyFYjFI+KMmUnJMWSFedzXZdawqjhoK+iY8KbI1BfjXOe4gEGUcmk+3ZBO1nIA==
X-Received: by 2002:a05:6870:7191:b0:261:164e:d12a with SMTP id 586e51a60fabf-2779013ab01mr9260587fac.22.1725110917437;
        Sat, 31 Aug 2024 06:28:37 -0700 (PDT)
Received: from localhost.localdomain ([187.120.135.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55b9b9esm4354485b3a.95.2024.08.31.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 06:28:37 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	wsa+renesas@sang-engineering.com,
	lukas@wunner.de
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] PCI: hotplug: check the return of hotplug bridge
Date: Sat, 31 Aug 2024 10:28:21 -0300
Message-ID: <20240831132822.22103-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some pci drivers, when the pci bridge is added if the process return an error,
the drivers don't check this and continue your execute normally.
Then, this patch change this drivers for check return of pci_hp_add_bridge(), and
if has an error, then the drivers call goto lable , free your mutex and return the
error for your caller.

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


