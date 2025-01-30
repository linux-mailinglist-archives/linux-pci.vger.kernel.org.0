Return-Path: <linux-pci+bounces-20577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F0A22E81
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 15:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403EB188A6F1
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BA01E98E7;
	Thu, 30 Jan 2025 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0axnlpw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29121E7C08;
	Thu, 30 Jan 2025 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245701; cv=none; b=essETly2E3/AVSpyMjBDLlhPBLefXOcb/UVqDCDBNVjy5eplkg2Dqp85o8ohPqzrMcegaH3MXgnJvopRZOd3XEy8pbyOgu51zgRcDlJFd3yYaKXPOP6yGPYiTuFgitYaE8BFCTdG2xm6njpd4x8udsd/UR7cRar6ePAxOdGgjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245701; c=relaxed/simple;
	bh=ch3lPgpH9FqpWF5yhIl3KdS/BSZwVZLBNQlPIEZ73z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d6DxQnXUIJuuSutQ9m47KMCYpzuN2zstPnfje1zf7J6duG9gJMs0A8fFybpYsIHXw/SyhEMieFd2h7U0ndV3HWS2DhcVGRKM/5/j5rILITXhRD9fHP8w6N8l3EaEvWhcYNyQN1AHFpP5byZOtOE3iRnzTHSMn43KD5ql7Ht2BJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0axnlpw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21669fd5c7cso13685955ad.3;
        Thu, 30 Jan 2025 06:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738245699; x=1738850499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnUJdLyMGBvO/hIllptp513IAD0oBTKPE00WpFD+Cy8=;
        b=Z0axnlpw9IHmmkrrUU6R8FLxPEbI4Nktv2a/tv1rwZbSA6woBYDSQcZknh+23o2FeL
         z3G6Ugirq/WJIv8wfn64BJYL/xPpMmSSBPstIy8Hr7ROPnkB+Wgwg1l+8DzoP7Oiph7I
         7IsZgqZ+b7CBvU9JNjyqDYwqtrRFhKBAUp7otkPF88bbKIRo78rLX6iPnvEFTmhqcPXl
         vuGHe1t5oGbhEnsCP121nOQ1OiIxX7o1grQPhwTy6i2CMiNEjGzrhuQkw24cQWDtaT2P
         YepKVExDffQsq4hePKorApWNw7qI7VwnFbZdypWDG2Kgs9q4RR/9aTXWHVjyi5UTR8m8
         fS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738245699; x=1738850499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnUJdLyMGBvO/hIllptp513IAD0oBTKPE00WpFD+Cy8=;
        b=VH4/1G+JfrEq8Hxk0JmSF4RHI9CrHJW7OTqlkvGu1ZKTBF1sFH5l7irEHGoSx/CGrA
         1G0XOakA/4mcAu4M3ewLoroHC8okg3YJQrQ4Ubxc5tjNHMzujwBllKIHVbDTHQxhSOgt
         AnCp7I54KCWdcZsJvQ/rUQEPeOmMSDT6PYnpMFTvG8ThVEDzo7XeRqUhI99EhT07I7Bn
         X8+sXCs3cTYLvxkSDP4hXOPXgt9YGFMZQHxDNjV8KBoGK4k1m5xU3i6EoyQPeCOLM8KD
         ZLVRLxH4mVvvGcvGduDu8EKUv+POQnxdKd4Cm4nhKXV606S75uql+gpd6vSKSFRTJOPp
         CemA==
X-Forwarded-Encrypted: i=1; AJvYcCV1u3juS/Wm+C/mCX2loUVb8BPgf8XzyWJjc1OBQOpcQkmnX2oSHa7j6b2b8bNtKGpG+wuTof7lZK8uhZA=@vger.kernel.org, AJvYcCWRRmQzmTQMCNoT6/gntNuRSf9LqRRR/2xx82b813PH/csCJJrJjyXaUMlM9wSRUooMyRYOD0Mjzism@vger.kernel.org
X-Gm-Message-State: AOJu0YyPdDXegECE6j1e5BUFnon7eVhYhfjXix2MRklc432jxSlxkkQa
	mR6PuhwSJMHigaJJkLSLn4tVH7pRLT6PS7HUCRGpIp3SIKStMWJO
X-Gm-Gg: ASbGncuhWI/3Fqm97DxHHdILjaqw9VYGtmpake7Hb4hAEEN+JIj5Jc+8MD824TQBuIS
	FJKIVzBMLTZat2Y5kPC+98VLm4aznC6zBv5Zuy6VWfr5TGrGyExwXt3pveEZ23B2LLuJd1LOSDs
	Cewfo5c9bNUnEpj8u51K2MWU4bao0JiziIvcyO6RrfR7ExlaRuMZemWDoUJxFwoLqale4Li2VfE
	znTQsGoGH/XpGu4WnjFQbK7VmpwtCV3/s3rjTpIGwVJOE1CAHS/B/3oSq4P9+a2Vlvl61uJuOXk
	yDOy6wmqW/8vq5osqSd41EhS
X-Google-Smtp-Source: AGHT+IHv9lGQn/s3vid5X1TDdjdBDQ1OqgW5b6PvrqI4oNlN3OUgEh429QSJ8PIvXZrIzok1AEsKXA==
X-Received: by 2002:a17:902:da8c:b0:215:b468:1a33 with SMTP id d9443c01a7336-21dd7c356fcmr113793145ad.4.1738245698703;
        Thu, 30 Jan 2025 06:01:38 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3300880sm14139635ad.168.2025.01.30.06.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:01:38 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] PCI: cpci: remove unused fields
Date: Thu, 30 Jan 2025 11:01:29 -0300
Message-Id: <20250130140129.19756-1-trintaeoitogc@gmail.com>
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


