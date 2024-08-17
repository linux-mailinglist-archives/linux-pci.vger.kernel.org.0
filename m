Return-Path: <linux-pci+bounces-11790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4AE955819
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 15:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87C71C20C42
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA314D28A;
	Sat, 17 Aug 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARmVkq61"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6B14AD1A;
	Sat, 17 Aug 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723901108; cv=none; b=tWY3S9uzZwxfoZB+n+42wMgGIZp8NrJQnqOMnli8ttmwMTvZFCIkdBy2MRgVkZMs1HFtdgElwsVc87d+4who838IIrv+cpG05XzBD6XaWE/EPgbDyLNudpxDvkwak/v0gzfou+SOGF7zUmHGQWGExUaxWkKJgwgqL78/f9Br350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723901108; c=relaxed/simple;
	bh=kdEhp/Kg27kne0vOQ2RDduD1wKCXvRJ42Jc1+k5J+XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFAxmRNgJNd5ZfKj/fuK3y4qSKeZDbw6sd/F5ALZle08UqW5NiTBrJZbFFcVLddazbZMivFNPEEwTkG5+vnvN/+1QeE6kJhTPREklH09NY8sMxa6uaea+cMHl5WRNNs/rJGzK2ObHpLgyz8a2DXSJlbQXyguN90mlu8NK715w1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARmVkq61; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so1777853a12.3;
        Sat, 17 Aug 2024 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723901106; x=1724505906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBh1jjPkZpHihQJDhRtC8nDyBpN1Y8R089uuo6Q3AtU=;
        b=ARmVkq61YpdGz9it2ebGXsxA69GOH58qBhc1mqX+EMgvmREYMKs3ibk/nd8dyqHBE8
         Kt/jZMfTD1oeJmHZ2KFGxZ3dQyJJuBQGrAVXn10+sV32EiYnoQo+xuDDXTda8vV+Ffbe
         USrIP9bsCRPbrNU3ed8q+7NuMjOUyjdlNasJM1ALBn0D90ocwINm++0GkL7ZPEjuJNOq
         9B4ldE1B0+KqwlH91mu+6McMxnJAHMI+SUaLzyc91L8UiZFr0RvlPAiiDGl/5DJUdNVu
         HH2H0dIAIxl5+HN+VdFf8kljKf46KI3ZMhr1iacespaC9m9GR9t2U/zFV1JAWHFi9+gE
         4loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723901106; x=1724505906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBh1jjPkZpHihQJDhRtC8nDyBpN1Y8R089uuo6Q3AtU=;
        b=pmCcJwtBz4CaJAUPVe8Kyiliq3lnh7RQ4mrhVXBr9yOwphZZY+ZQ5hLxi8/P06lvIm
         5mNkBWWFkzKBzd1pGL5lw/l0Az8ZAIzGi05q1g64JUmuDiaBv6R5ud2irQ0tN8ISSVkX
         WlVisvnHneAKlkTv6O/SFusgq/FyGP8JM4KLeH8LzI7d074nmyMdCcTvpbUO1Lc2FLRQ
         q4ti5KzKQoz9KwhfGJf3qe2v5UZ0hu7YdX+TtfJvo881mLIbbl5uTJSbD4tQXYIxvGBC
         XeoFFHmy2jxcmeQOrJd3HwAQCHh8ypZ1lCsFMLdiV8ghIcFL3SQLJ70ouvwhELdd4Vi8
         vNuw==
X-Forwarded-Encrypted: i=1; AJvYcCVRja306dx7CrxFvTIVtq8V/6ywJEyFPFZY2N/rSeZSjuYbH+FyymCza1r3nTXohqHL99I45jf9t63YgFXmbNIGYqh1z88sNCL6T8j4/hC13JUTDG07SnA9RVoRi2jmBJMZeiXmRUT+
X-Gm-Message-State: AOJu0YxEjJnhwY2pEN+20eKLLJlP0XxKh2LJb1Lw03nAVQQpTGCWMdVV
	RUEhVb9RsibrzCA092uC8PysBKV3wEyY4qmBzIx4X6OCD+Oipt0Y
X-Google-Smtp-Source: AGHT+IGSpyfCzSgGAl3qtHqgyJI3xqyFgI5keFIbe7gfV8k0xV72gjZIUiodR5TFVZoh6TN+eqQ7/Q==
X-Received: by 2002:a05:6a21:318b:b0:1c2:8cc4:908f with SMTP id adf61e73a8af0-1c90505277amr6015862637.48.1723901105811;
        Sat, 17 Aug 2024 06:25:05 -0700 (PDT)
Received: from localhost.localdomain ([187.120.159.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c267sm39648455ad.83.2024.08.17.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 06:25:05 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	wsa+renesas@sang-engineering.com,
	lukas@wunner.de
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: hotplug: check the return of hotplug bridge
Date: Sat, 17 Aug 2024 10:24:51 -0300
Message-ID: <20240817132452.8731-1-trintaeoitogc@gmail.com>
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


