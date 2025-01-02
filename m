Return-Path: <linux-pci+bounces-19169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B389FFAFA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45051883CD8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20711B3950;
	Thu,  2 Jan 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFQ3BMRY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4841B4124;
	Thu,  2 Jan 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735831617; cv=none; b=W/9LS0vjyP/KUje+0wGrFk58RhHkC6d08x5fqhUb+fZx+RMgWbPfDpWZn/9I/zhTVIBrSWzsKXToxnvbhBH2dzW9wvO4z5TaPqHglYEtiKWMXLtzcbozkCY59b99qhcA1ehBXh2RNVisqChZQ9K+fX19iuQD+gw2dwS7R7ZrrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735831617; c=relaxed/simple;
	bh=ch3lPgpH9FqpWF5yhIl3KdS/BSZwVZLBNQlPIEZ73z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GnYBJZWRxBkpWC6uPQ/aiS/ciipgIBnRzzlbOT678Xr7xI3cwY35hwR2/wPc+CrUkoXMbrsHiLnWXLOJHLbDbux0wEXtf6sBMlbi4Hcb1HoZfewMwDaNbLCNvu4GOUFNVoTflaPlTodFS94UZqC514m9bjXPWjC8I0QjQeH41Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFQ3BMRY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2162c0f6a39so163813625ad.0;
        Thu, 02 Jan 2025 07:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735831615; x=1736436415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnUJdLyMGBvO/hIllptp513IAD0oBTKPE00WpFD+Cy8=;
        b=gFQ3BMRYdCG4ZhyVx0kSKgw3wrwwF8VEwXOF9YU6wOFCp0rdRiY68auIKeXxRq649v
         24z9Ml1S7UFRs7se8KML3VEa0GOBvtWd71qeW9P7UoJoNFkwgV4GWBfurZe4Lqaee1ZB
         nrrisO/G8QgQHRDh3RMGJgfMQlldfU6AUvIH4E18NEziUsFD/yIIXj6Y4R1OlQCHwQAq
         4XaVXFDmCVi70jRfg4orW97RK5NKWoUaMZfZ6shUrlyngrx4JWuwvvg5WJBCWDdhX5b5
         HyWBXUu+5oi75Cg7e67a7pwhRm+6lupcai4TF2x16fcYAOKd/4JnBbpYTdFRyzZ6Lwut
         dErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735831615; x=1736436415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnUJdLyMGBvO/hIllptp513IAD0oBTKPE00WpFD+Cy8=;
        b=vTlOwzOvEVHLem7HEmUMBPAJ1UcqBql4xV8e353GWWAInebmfkeHFj1lJVw+HLb0jH
         HDxHzzYa7XoT863Ga9vZaH76bn8AtHsnhKZ2GX47wfcFyPb6y1dPYz/sOl2ZO9ghZobR
         gdm7ivsveWJN5hp1DDn9jUVq3Y9ma1HyOscFlZhN2bSe3fK9qX9HpvDH4uDtrYNCHtnx
         iX6IP40vkycK93gd26O4jmW7ABsOMptprrMfjN2nmB0pnCQSU6bS0HQPdpEKF+Hy9Ylq
         Wbs8YoJP7/tjO3Hy6LK5qjrppF95p8Xwbh9PJoztaG/8NwTxrgG5CLV9NSbTyvO04HHM
         CjXA==
X-Forwarded-Encrypted: i=1; AJvYcCVzDsOFD9E8Xv7m39R3hRUVv6Z91sQVY/RvGcVL9dOjnNSYyF73T/S8A3R9qruRCH92phDCTAmB+VCB@vger.kernel.org, AJvYcCWUtuNZSdl8xrhWSsU7rdnc+Kr0B2NNDP77GZM6J23ljIm6q1KQ6DSbCUteaXSQtUD4/6h2psAWIUlSPxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAw7uMrifZWewtxcoFDzI0VEgemPrrzMt7yKvMJN6zcYwOoWA1
	55V7VD6ewxVG1thsAB1q1QqhDoN00sBqmZiATmuRxa7s3q54Y1d+
X-Gm-Gg: ASbGncsG0zBqkuO4EIwAHl7SwHxia7yG8sOfQdOkKgB8//aN5IsVvhVLZinfVSdXAbB
	15GD3e+LCLJ1BycrXKIKvU0KUcPIItYN20TZW1SV8EnPqwRrG3+Cl4xeBDay/gEhzdezsx7UksN
	zCHcH5GbOLNGU51txQ+7lNek8AqPGj0a/dAhzq2Zmn+CHP2hHzhpqcI9j/zK8CQZmdfeAf7vu4o
	rdey5AaUgLepRXpagE5KKEBIxAsZ4EF6AvcDwBcNYV9ukJrniO4KVcD21mYGEEg7w==
X-Google-Smtp-Source: AGHT+IEQUELGCjkbYFRRfwJqqdSmc30qlqIgUmKS185gO4X6UQKJbnkeIYHbKnbNCcsUSviUOm2qvg==
X-Received: by 2002:a05:6a21:3382:b0:1e1:9e9f:ae4 with SMTP id adf61e73a8af0-1e5e1e87c5bmr56816161637.13.1735831615327;
        Thu, 02 Jan 2025 07:26:55 -0800 (PST)
Received: from linuxsimoes.. ([187.120.134.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842e32f6aa2sm22377156a12.75.2025.01.02.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 07:26:55 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] PCI: cpci: remove unused fields
Date: Thu,  2 Jan 2025 12:26:46 -0300
Message-Id: <20250102152646.359624-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `get_power()` and `set_power()` function pointers in the
`cpci_hp_controller ops` struct were declared but never implemented by
any driver. To improve code readability and reduce resource usage,
remove this pointers and replace with a `flags` field.

Use the new `flags` field in `enable_slot()`, `disable_slot()`, and
`cpci_get_power_s atus()` to track the slot's power state using the
`SLOT_ENABLED` macro.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/pci/hotplug/cpci_hotplug.h      |  3 +--
 drivers/pci/hotplug/cpci_hotplug_core.c | 21 +++++++--------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
index 03fa39ab0c88..c5cb12cad2b4 100644
--- a/drivers/pci/hotplug/cpci_hotplug.h
+++ b/drivers/pci/hotplug/cpci_hotplug.h
@@ -44,8 +44,7 @@ struct cpci_hp_controller_ops {
 	int (*enable_irq)(void);
 	int (*disable_irq)(void);
 	int (*check_irq)(void *dev_id);
-	u8  (*get_power)(struct slot *slot);
-	int (*set_power)(struct slot *slot, int value);
+	int flags;
 };
 
 struct cpci_hp_controller {
diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index d0559d2faf50..87a743c2a5f1 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -27,6 +27,8 @@
 #define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
 #define DRIVER_DESC	"CompactPCI Hot Plug Core"
 
+#define SLOT_ENABLED 0x00000001
+
 #define MY_NAME	"cpci_hotplug"
 
 #define dbg(format, arg...)					\
@@ -71,13 +73,12 @@ static int
 enable_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct slot *slot = to_slot(hotplug_slot);
-	int retval = 0;
 
 	dbg("%s - physical_slot = %s", __func__, slot_name(slot));
 
-	if (controller->ops->set_power)
-		retval = controller->ops->set_power(slot, 1);
-	return retval;
+	controller->ops->flags |= SLOT_ENABLED;
+
+	return 0;
 }
 
 static int
@@ -109,11 +110,7 @@ disable_slot(struct hotplug_slot *hotplug_slot)
 	}
 	cpci_led_on(slot);
 
-	if (controller->ops->set_power) {
-		retval = controller->ops->set_power(slot, 0);
-		if (retval)
-			goto disable_error;
-	}
+	controller->ops->flags &= ~SLOT_ENABLED;
 
 	slot->adapter_status = 0;
 
@@ -129,11 +126,7 @@ disable_slot(struct hotplug_slot *hotplug_slot)
 static u8
 cpci_get_power_status(struct slot *slot)
 {
-	u8 power = 1;
-
-	if (controller->ops->get_power)
-		power = controller->ops->get_power(slot);
-	return power;
+	return controller->ops->flags & SLOT_ENABLED;
 }
 
 static int
-- 
2.34.1


