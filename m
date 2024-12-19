Return-Path: <linux-pci+bounces-18809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3C29F8386
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 19:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EC9188B498
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A9A19994F;
	Thu, 19 Dec 2024 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9GJgINF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7E41760;
	Thu, 19 Dec 2024 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634199; cv=none; b=T5Fw9ffK8ThVkGXTgFd4sHsBD8tUTk3vFqgaTSfv7K364v/Onao5qtPfVYpBjCbjCAOFTLNW/EVA3Vls0+ZBPJTP23E7nzFmWXV1DsRe1ox4zopznaPeZNW5sc10G+J1Iww8iNFpyTrOZaC1E0pTXiCyQbHjp8i10HHbomz3ijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634199; c=relaxed/simple;
	bh=ch3lPgpH9FqpWF5yhIl3KdS/BSZwVZLBNQlPIEZ73z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i3W+fZXQYXuC/ojitwgAeuBfW6nGcFCfjwlOxZjhk78CVjN4OI6GAl1K18hDclGFRGCH5v9r3fRswst8OrfRRG+dx2v9wgP3Owviiv3d5qybnC46ko5TthprBxXs0UAukfopJV8xCUeS1wQ0DjTr9ltqgyrfhS4WhNAHmhzmH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9GJgINF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725dac69699so1041642b3a.0;
        Thu, 19 Dec 2024 10:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734634197; x=1735238997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnUJdLyMGBvO/hIllptp513IAD0oBTKPE00WpFD+Cy8=;
        b=N9GJgINFu74B+ODh/G40Ix/sfXuUNaw/u1ZRYa2/E12SconZNuGyNHOQcQCJrQyOVu
         AS+6gr+5F28B3Z8X3tT2jKLZDFYNc14Ax4I3gknXRuB5zwWA85XxB2wo+jleRfI4C1NC
         6nULc5ybtMsQxoP6+RLCuxHj+VHts49Znr3lMCehrsUHk7MpLo0jzismehjelkfFaaXf
         WeNTUS6rSkzPg5wG+uCuNAVuvkeeeVRuhED2y0ZlLofAClOr3WJzFKtyi2lzBZTGNQ58
         E1g1POt1CmwHF68tFxSTF+P0kVuTXsfDtMJE+mmy2FBCESSbjAGRAz7WxjeftHINXOD2
         MBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734634197; x=1735238997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnUJdLyMGBvO/hIllptp513IAD0oBTKPE00WpFD+Cy8=;
        b=LJibZ84wwG1kzxfDkTncvfBSrC4E0KAPQ9i7Nq0r18sFbLy43+yt1PPl7K90vPO+2q
         QMgbw3kQ/wG61ZR0yUYQs53MYLlviQ16ybzPoi1aW8+xa34D5YefRdPsxorBFH+dDlTn
         o0QEgh8XdELk1iH9t74B+W7a/yfpZ0NIElo7tbVYG/aFNLc0DIndLmyCcv3Qiz8ca5OR
         JlusDfAgWm5Kh8RwBCCcuJ3sE+j4ItgjYrpTXHZfDFie87WAdnXSbL+JoZW3aw/Io23Y
         fhxICHXB98lrXNyymWPaHlMO/nTTn3Q+cmMmZ4e6L3O6/EG/l2eG5jWN2AQdx/DCovBi
         89fg==
X-Forwarded-Encrypted: i=1; AJvYcCUbTau2qN9KJOrTS3fFVycamx3XAxQ/0YU2WY1oHszGA2Piqu3sjnNmHvj1O46yCXdus+O8m3Ozk4Ol@vger.kernel.org, AJvYcCXv8U7uWfYts9YpfN8hLJRKTMrxc8j2GKjaNoX1z8HayPcwxBj7XfKQLyisxdLNs9HxG89gtK5fSAry2Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPo3Y7mguVTr88A5B6uEjnqb6haH/7aTsxNuHSpUImm+ycvDsM
	reylFvSDJY4sWefTFW4ymjzaFS3tJ35p6doz2SNQjQi4LsuAAWRu
X-Gm-Gg: ASbGnctcxrydaKIUUujaCCFkKFpfdv6/xrfnyvbcqNsq82/Irj38Xk16YyHSc3QF5Kb
	vUODbYRTvTDwdV6PjJ3opnosyfTGbL0J11Sqi8AF7uswjFQbYB9OcOxLHAI0dsGHIW+6ULVSJY3
	zV43arjbEYJhUMihyLUsMpR+B8iw9FFQANKyg4d/xhzM8K2/UxcziKMXZM7KjFjAA5YNMCGYXnw
	02ysuaU4/pnZm4Hslm9W0QIZp8rTQUphQ7nfr3MI9oxaXtxuzgZCyrE9bNdCwo=
X-Google-Smtp-Source: AGHT+IH6rYvta8Ua2PSlcv5o5g2ucu9aUriuiPaLD/4bkbcDQl1avt8iy9eZI6Z/FC+49WJOB325bg==
X-Received: by 2002:a05:6a21:33a8:b0:1e1:70ab:b369 with SMTP id adf61e73a8af0-1e5e04616c6mr285278637.13.1734634197089;
        Thu, 19 Dec 2024 10:49:57 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821da93sm1303799a12.38.2024.12.19.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 10:49:56 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: cpci: remove unused fields
Date: Thu, 19 Dec 2024 15:49:50 -0300
Message-Id: <20241219184950.77704-1-trintaeoitogc@gmail.com>
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


