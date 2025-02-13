Return-Path: <linux-pci+bounces-21368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C2A34C21
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 18:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6FE188756A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8562080CE;
	Thu, 13 Feb 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5QuN7Ab"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39792211A36;
	Thu, 13 Feb 2025 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468385; cv=none; b=BQ3+z+QkRnuL8MhtVwg3TpIT3WFLouWTaAwETW5TKCHLNXiqtw/X+z2cBkRtg1AfCPbDO0KXULGp7LsHWUxqvLnXYRxm1vo5L8IXqjoe6f8/TyqDc82pw99Zte1e4sfoZvvnEdUxgrDmsZv7hg1oYqG/93uJSOnNGD7fMoI2kpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468385; c=relaxed/simple;
	bh=ch3lPgpH9FqpWF5yhIl3KdS/BSZwVZLBNQlPIEZ73z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JYXd7Etod5swRcnNEz/wB9zitsDMjXwYd2rL02rRtnvdYWhpymkbsTHZdUCaYyAgInkUaF20mmgUggcYE4Ls3KW3ES6G5aXEK140II9wmFrC9srLMIFiOd2g9ymHFQa7ptij6Xql2g5gLieueCZPVvwvJXYOby83fSfZZHIbJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5QuN7Ab; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-726f943b322so607554a34.3;
        Thu, 13 Feb 2025 09:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739468383; x=1740073183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnUJdLyMGBvO/hIllptp513IAD0oBTKPE00WpFD+Cy8=;
        b=K5QuN7AbsNLTWrY0fhyu++9hNFFcqmRl1zRyDzeanHiWYko0YdXJpsIEf7lgZzVyo4
         nuKJnz6r2CMuactETW1moCoExVaX3jVQgN2DxkR9U22n5Zw3Icm6SCv3lkIjnr1dzg5V
         HvhaqtTTypABWEspTHB6XpjMEwfZJKAcSMmYamXtvbIMYmT0gsVIAyKJ3PAKiX4jGvmo
         7jAG0toa8mIEtITN1G55IJdP5mjOJaNWwJr4YCEHmcUSIqyQRFrGOtXR4HLV8x3sxw+D
         XoHX3kMA44fKaPQj4P5wlCnKaIcIV+W6i9OVUztFWhJx8X1nXaPO5SUPSDtuMQz1bTe6
         GXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468383; x=1740073183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnUJdLyMGBvO/hIllptp513IAD0oBTKPE00WpFD+Cy8=;
        b=tHXxvFqZasPNvEFlxqTMSzvbY2+cf3NoYvkiJdH3hD4GiEhr/9SerEHL9TMDWnkxfo
         ndptVRHjka8zEXS+bRDieVkBzXpXfohJ5UowF5lfmlmnL1mnokFjRjcWNEkyoziQ+3rS
         9j9Y9W1PUdmimNsiDuboG3Fv9i/UCmkte7n5T8gPqaDj1Upo0xbuxQRP3IMLlFepY8Ow
         eDhDF9dPWOrlhfND8serw3/FCrN1cEJYwZZeRzLwHgMn1WHmuYh5QYZor/DNm4SZGmFG
         himprZad37+Up2QwPa0Hyo9tH0ha3itMJZfqMPKjvo3qjWjvx7TsLZbshg63URZTBeMk
         2GOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnbN+gVDs+8eATFBkxxIs2CgvFc2udZ/AmDIGk0pJasjPorLApDntSWzpMvARvupzsBvy/IVDEMigQ@vger.kernel.org, AJvYcCWn2H75TdCKQIZEj427b03+euAVz71WLDE9cYWoTgXh54r4+NK5/S0UXv691C3yfvsp/h+sW6LH3WMvCdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ABeEwX0aWoVLyilZn7VzaCCJUeckHABmSjVnAvwBkP3wxKuC
	Ek/FHeJRzqZ+H36smK13fyq53QuFE66khJdAkAR/y1XvBLssujAA
X-Gm-Gg: ASbGncuoul2fztzf0Y5eZ6pPhVVoMQeXSU0YT2GZ4mSC+EG4Xcwkt8EcNHHnzK0gS/Z
	CfzUMkbuLHuwHTFikVR4Av0FtZD/3ozGDPKIq2W89KMarkuzzc44mO/jlSriwdZLir3LNTEeWwn
	vD1n9LQveGSEc8sBvOKZBeNhCvpFv4L4+iOksI5p32FUoOHHqYB/8eiNPkjWd9GzBe/A74rsQUv
	ZVoc1wAb8zahtj59OhD+DFcV8oTTpGimIIvenAKIkOtVCyq8w+yqnFxee7NJmUIHdAv1RLQcN9t
	TDtgp/4/7dKlcsHxi1M2kGRa
X-Google-Smtp-Source: AGHT+IFvYIB/G0KZILSte8pJfISgj42H0XPT9hPv7ZXXXJSfaRjzTFXXOKVJTFw1PnRxrDQlxNbfnw==
X-Received: by 2002:a05:6830:65c4:b0:726:e951:7b29 with SMTP id 46e09a7af769-726f1cefa51mr5734804a34.18.1739468383260;
        Thu, 13 Feb 2025 09:39:43 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72700257ff7sm758460a34.54.2025.02.13.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:39:42 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] PCI: cpci: remove unused fields
Date: Thu, 13 Feb 2025 14:39:25 -0300
Message-Id: <20250213173925.200404-1-trintaeoitogc@gmail.com>
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


