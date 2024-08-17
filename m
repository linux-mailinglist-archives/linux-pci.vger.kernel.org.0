Return-Path: <linux-pci+bounces-11781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7016B955534
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 05:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3DE1C20F22
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 03:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDCE11C83;
	Sat, 17 Aug 2024 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBDMNFmA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845210F7;
	Sat, 17 Aug 2024 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723864715; cv=none; b=Lsy53EaXvkIMhFkRdzM/qzZMFe7d253USo/ndY8u2K6jnlARX7zoRY9I/HVKW8E0V/XJpZLANfOc5h529o+tljlqOJ+EMS2OAwjZBUAh6owGPRfkyEgu+/Kw6qiK+xWk/lSCv58IfixS88lJ+NC7w2r3WY0k6cjWfVUnceofEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723864715; c=relaxed/simple;
	bh=PK1gtm+3JXc0XeI/lpDSKVfzle9AZFrvPpYDWKo8t1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YH6+jK+NK+tcqL6ZCxtjXkIsiRmFupE4I94+cPpUdT0OGs9zm4wQw5lePjDwYS3g9qdM3ExMItAjN6KLfuvB1tT22LrOKg8A+5uF2UCsucBE5eKg3ZVxCflTZqhfq+q1kYSRGGzZ4012zyAIViYTRIol6ywY8h5JcOytnkvQp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBDMNFmA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20227ba378eso51495ad.0;
        Fri, 16 Aug 2024 20:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723864713; x=1724469513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vuEKBbm6jzfUML/VgRcrXFhdwGGxYBzUG3C/0kVpiDc=;
        b=MBDMNFmAqHFsMlbYfG8nTChu6LmRX8CdC2MC09BmVOp1nQnATE1O6Q5Pj86jWawqqE
         0yMb7w6CmNTNXhk6KmNN6708LDsKrb+gGn3kKYWIGWbDjNVJXFfWQWAl3h2ADRIGkfYE
         3ICGNRzyNGUAh50I68GJgvxfqtRXNvuaZBkTHHF4kXLw5WITezmv7ov+fxgPWwWwDBBL
         5GfY4Lg4tJBYt9KWnP7RLGNw5r0gcbIoVxgjIANIPxyvn933nXSxyq47ZPYczlWqcGuO
         S2DYLOUjhatiTsdiPP4VqPW2Z13qtBpnSnCVAq/NxTUpAeZt+76UwQx6BVim0OjV9tlq
         RXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723864713; x=1724469513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuEKBbm6jzfUML/VgRcrXFhdwGGxYBzUG3C/0kVpiDc=;
        b=e+/VVCxawXMozleSzhWPhovVumS/k/hur90TJRxNQm3rviUIaib7xRGBrLu0n5jB3B
         O9zGy7gQQgeF2JDjf73qaslTiYXbSYvPCTWsUc+aX/z7NLGqD+wwn4nirg6EmwrZij2V
         sliYw0cPzZiPowBuKDmhEDL3Crai5RXEVWkeiBRRVAaVUOidyUrHaV+8ZJiZc6PvzU+a
         CQcdYU8BEhprcqyjFWKIzn4oxMygEr7DPtozZFmOQmbfM8iqL4bdirmmH72i1Jzx6X9d
         mLCDTnDK8U0uyRe7571ZycgJtG58QMDXUEOL4fGFYwHSoHQV/cUeU0usbolNZNccPFAY
         jXWw==
X-Forwarded-Encrypted: i=1; AJvYcCVNBpx7ZcEWrFg6B8sErPTu6ezqXEjekNTsH4Bx2vUEt98040Bvemj1D8jBqpqziSHHVeuxffTSY5wJ5t3uJo84Nl7tjWriBRbqzA28QWC/tsm5kqd2QqhGlbJiop9E8rcYLpZzQyWd
X-Gm-Message-State: AOJu0YxrXCkGxae6HtGYseZNQoLTo4SIEog4uAXJfkYsGTawsWB8qxK6
	BnaPKwTiOyecrchbHNWeqiFuzg1tHRsNTOnJX+moXKIWBwOJVIxF
X-Google-Smtp-Source: AGHT+IGBdcnWj3Ytjsg9a2o0sYeEDzfMIbjF4qgKVXw7PBKoef1Y7BS9PViToKtj+Ayv6Ll1r+xUNg==
X-Received: by 2002:a17:902:e752:b0:1fd:684f:ca72 with SMTP id d9443c01a7336-20203ea74a7mr49271445ad.25.1723864712745;
        Fri, 16 Aug 2024 20:18:32 -0700 (PDT)
Received: from localhost.localdomain ([187.120.159.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2020b9ed5bfsm16509505ad.274.2024.08.16.20.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 20:18:32 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	wsa+renesas@sang-engineering.com,
	lukas@wunner.de
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: hotplug: check the return of hotplug bridge In some pci drivers, when the pci bridge is added if the process return an error, the drivers don't check this and continue your execute normally. Then, this patch change this drivers for check return of pci_hp_add_bridge(), and if has an error, then the drivers call goto lable , free your mutex and return the error for your caller.
Date: Sat, 17 Aug 2024 00:18:15 -0300
Message-ID: <20240817031817.6762-1-trintaeoitogc@gmail.com>
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


