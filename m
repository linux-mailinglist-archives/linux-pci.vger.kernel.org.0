Return-Path: <linux-pci+bounces-11236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002509469F9
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 16:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F4F1F21679
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5401013635E;
	Sat,  3 Aug 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7uMPDyo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107B1E488;
	Sat,  3 Aug 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722693898; cv=none; b=K256PGaBPE1Y6aW/sTeMEe8x3I0N7OlgVx9vY8tuefQN3pv4pixhg46s/LgDXEFj+OnAZkue7G5eNqNf32tkrgpk1CgstRut8Dx3moaGNaRQQ1n77KBq/hgLkkwoiVuXCnMH0QadfUJEE7loxxq3DndjB0Te2DNCM3PiuLPc4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722693898; c=relaxed/simple;
	bh=GHU1if85X7v2tvAnldi6IuytEaqoJKMMegDnviNTSzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpXvXoM+UsKfaQ9BkUCSeRKHjczcc653wXNgQrZQSLbG7YZVq5vMzoRzcCgqc52EvNlj8WQ5nilgresLFUf5cQiIywO9sHi1gP/I77cGOuMZTLRS8xDjByOTOtHy3QPlyNBVBG6WwEvd6IXkkdiN9RIXVNHS8oCPz8XrnOjZnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7uMPDyo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-71871d5e087so6908214a12.1;
        Sat, 03 Aug 2024 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722693896; x=1723298696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr/sV2/AXwFEYg2C9udoqqnWk4OFTWJ8dnJm+vsqBbw=;
        b=m7uMPDyotOV3esylzGSee8PvSPKjKBeUYpEoGh3x0nIfVrRIFN+lUvZcjl//bQOxGQ
         Qq4Dge7QxHobObWOQ6ZfrebC3K3xXljBVLnXL0wjIyVCi4i2qbrxnE/zbse6GZ2zfqDa
         CZNVUFpuiJajog34E5vQTkfoutztmPD82wHiTdgj6i5xMN3uM41I9gZ56ji8uuz4yPc/
         q3PicRghLwUtuD6p13OybCIpQ9fWm6VXq//4fjgqh4fYCwLukWzw6RGs7GTmhxpmwaE/
         nwjCyTmMskSsBmFoO/F8VYUdyd0P7S1LT6Ud9dYdb2MwqL2gmlK66QeAzNQcCKL3F2Dg
         GD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722693896; x=1723298696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jr/sV2/AXwFEYg2C9udoqqnWk4OFTWJ8dnJm+vsqBbw=;
        b=wDl3ffstxJSNMEk7DxzHDDWW8bFtOwDoDKd6tf65nxaSK0lOz1gnDOquIiI6l9eS4P
         og7VrVv9ZXapSHCFM/EpyDnJY1miJgWfdi29y3pn8C04dOHGjPHf5RC55aMgmb+/OZfs
         9NDrQnNxd6LU+VAqBkbSZZEQACFZUGYgrMROAnzcd5hRL0kFxAl8PJhrfGdTpIMGxGMH
         ufJdixjRQPq5L1DC2X9KxEshPGMSs3HpI+YTjMvBpR4ZZeFHD5XOF/11GDeNmDgXPzeb
         TDHJ1CU/tN3RO4idmQjyqdi9LBsX9wulRPuSYmBrNfAr2h4vRUMOtxZ6nP41kvG7P8BT
         egNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmcxIZrw+l6+1CHS7DDUxPt0Q9ddm9aBO5G1HyPwcj6zcGPMqxb6YTC/XqZ0/mmtNdsYg/o0Oy0SCKZIPbsR78BNr0u82ubEQQ0AFxQZ5WRzSiWNayiJJFKj7XLbgqGuLM95SsEwbR
X-Gm-Message-State: AOJu0YxXNq2EyYZSfDGmn6QDxROyu/OXaeaiRipCQ163SqFRmVix1rG/
	Gk8gFRgrzUJshreZu8K4U9zMahRs4D+8R4z/Yy1b+ZrYx6m+m8kL
X-Google-Smtp-Source: AGHT+IF0cfd9ACZj4Cb8vS1x577iByzKVrNou3KTYOyuIDRyR0fcB6jBePpR5KtwLqyr9yILlkLcuQ==
X-Received: by 2002:a17:90b:4b02:b0:2d0:153f:ce00 with SMTP id 98e67ed59e1d1-2d0153fce83mr1291305a91.41.1722693896129;
        Sat, 03 Aug 2024 07:04:56 -0700 (PDT)
Received: from localhost.localdomain ([177.21.143.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf16bsm6957049a91.44.2024.08.03.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 07:04:55 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: bhelgaas@google.com
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: remove type return
Date: Sat,  3 Aug 2024 11:04:42 -0300
Message-ID: <20240803140443.23036-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I can see that the function pci_hp_add_brigde have a int return propagation.
But in the drivers that pci_hp_add_bridge is called, your return never is
cheked.
This make me a think that the add bridge for pci hotplug drivers is not crucial
for functionaly and your failed only should show a message in logs.

Then, I maked this patch for remove your return propagation for this moment.
---
 drivers/pci/pci.h   | 2 +-
 drivers/pci/probe.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f3938..a35dbfd89961 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -189,7 +189,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 #endif
 
 /* Functions for PCI Hotplug drivers to use */
-int pci_hp_add_bridge(struct pci_dev *dev);
+void pci_hp_add_bridge(struct pci_dev *dev);
 
 #if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
 void pci_create_legacy_files(struct pci_bus *bus);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..b13c4c912eb1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3352,7 +3352,7 @@ void __init pci_sort_breadthfirst(void)
 	bus_sort_breadthfirst(&pci_bus_type, &pci_sort_bf_cmp);
 }
 
-int pci_hp_add_bridge(struct pci_dev *dev)
+void pci_hp_add_bridge(struct pci_dev *dev)
 {
 	struct pci_bus *parent = dev->bus;
 	int busnr, start = parent->busn_res.start;
@@ -3365,7 +3365,7 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 	}
 	if (busnr-- > end) {
 		pci_err(dev, "No bus number available for hot-added bridge\n");
-		return -1;
+		return;
 	}
 
 	/* Scan bridges that are already configured */
@@ -3381,8 +3381,7 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 	pci_scan_bridge_extend(parent, dev, busnr, available_buses, 1);
 
 	if (!dev->subordinate)
-		return -1;
+		pci_err(dev, "No bus subordinate");
 
-	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_hp_add_bridge);
-- 
2.46.0


