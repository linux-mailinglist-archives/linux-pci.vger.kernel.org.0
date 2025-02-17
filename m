Return-Path: <linux-pci+bounces-21668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEF6A38BBF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 19:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF6F16A18F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC823642E;
	Mon, 17 Feb 2025 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn836Kyj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4E137C35;
	Mon, 17 Feb 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818629; cv=none; b=E/Gt3yfH6NXE/EJeUdbDTDAQJp3edkSFJ/tEhWJ+q+3tgLPz/BlXAWOzX5e4mkagyg/53WUDXBdB+DWLs01iM0A4fjUE1yqbwXTUz8pmmEL8sOXrqAiInTlRDPnogmmtLZBGVGoCE5vDl+YDiOvMayJvXA99mLojSth79QB6sMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818629; c=relaxed/simple;
	bh=ybBMECw0YGy4dsTmdwJykp5GlzhNOh0oFywmEilIRwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxnb5sVYHWmoq7BzIi86nHQDlPJmLvvwcGvP1ZWiuCCJmjZjCFBLW/PFV9W9GPk+aoMcvHOLD+lBeBDktsx6tjk+D92Xbn4Ae2W0DSrIvBTd3hmhx5/diKmOOyXMoirlkv5ADKYTU7f4AXQjqRpK7r6swsiizGLzK/n4PyySA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn836Kyj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220f4dd756eso55566475ad.3;
        Mon, 17 Feb 2025 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739818627; x=1740423427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Au02HYyvdD3cDBoAFDGp2IR6X2qTDapqyH1lQuENtSs=;
        b=Fn836KyjTxfEBWtqk/L0Zbz2UwOn1knvtnYWEn2VChlCkZ57F7lkGGM+g2mm22pOLo
         Std8mHpiL85VPiaBL0wCCj9KVx6njK8gW14y0Vi6iNuIjfQguH7GI2aVP9Kh5ot7xS97
         9vDzlcbHw7hqKGZaAJnXeHWo9+mAL9KWIf1PLTv4p1Zu3ZtxQynf9hKi+bRmx/jcyCkk
         6aPUmO/Le4FlD30RsnYBbo1JaaT/1bx4Hq6ujKWuUX/zjCbYTWJxgSw/9WAfEqbJKO5P
         sHPRNlexerooygbla1kfA3TDIa+lXG6JZGG20d2cGIuwKN+TQ8TnFPhiT9MMDq3utp6s
         IFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739818627; x=1740423427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Au02HYyvdD3cDBoAFDGp2IR6X2qTDapqyH1lQuENtSs=;
        b=dHJE0VHnRbzoYnhKmb6IRWBpZdtw909ofQcrWVAuAIL3eoA5O2I/3AEXPDJpUcdxHe
         Fq1Lz4s5f6O06CYo2bAWY3mkWfqSTIuNIqaExFR3OyCxzXJGBlQRWkYnrbXwbP7IJzDZ
         OLndpEqV+4LefwGedViOa0BAKJ6V3vTWZA/4uO5ORoXlnGWsBhyK8BT14LCW0m2VdObJ
         FgeajX0Pvk+fPdSEDzatMsjFX2qvzg/knPtqxfrPFBCF7mxk3U4O6LPxyJBZkeJBcUGG
         M+E64olDWIZCgCOjDLa1Evp21q4ucM1fmp5oKPT3wWRU/z53hsmpFr8trMo/I2D/w1oH
         Cf2g==
X-Forwarded-Encrypted: i=1; AJvYcCWN/Fu+nUiXcCzJi3oZz6cyAA5Tjoiv7axjOSTb0G9unJgSacn+Ro4njV5BXLx+h+3biNE524HHP6k3UEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/ldGOBAg1xtqNN3cHacI3YHP8Z3EAd6qAv0Oj33kB5FIDRNo
	1cqvCF9T4XKxRT6C5Hwapa1wO4VoWTISBBuLz+H7exLF7u08mlEN
X-Gm-Gg: ASbGncvvl/0qvXtWLEH/3IGTkxn80EYKCTBBKFlam54yF72h+9XKPW4IH+3Ya4Xbje4
	F/PVnH9CnCzQeUMODZBBe3Z8TyPFDxA65+Ta/fybNt3YPwGuxnWiUeKyWwRcT9ntnDWo4TuGX3X
	Lc34TkMsgVl//gmNguOmYQkbb1ke5XljPsl40pgQnYCqnPNcgE7qdkO9XP+6KHGWgs/8D/hECpc
	9WFSGMKGuGot/u2SGxaCKve5NxNwmh5YxTD7IRS/UQ9PvO38DCvn35fsQpao0ov19bnHYj0iYIA
	Dxe8jPaMRGnk2HGGKB3QyxwP
X-Google-Smtp-Source: AGHT+IFOhan14Wy2+WrKf8Vdkw6a0PHT8R0sUluOnGYPkceQV6h0yfrC3hG64CDbQCE1wjGC7voV6w==
X-Received: by 2002:a17:903:2cb:b0:21f:6cb2:e949 with SMTP id d9443c01a7336-221040d87c9mr175691245ad.52.1739818626934;
        Mon, 17 Feb 2025 10:57:06 -0800 (PST)
Received: from linuxsimoes.. ([187.120.159.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536b047sm74658515ad.101.2025.02.17.10.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 10:57:06 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: christophe.jaillet@wanadoo.fr,
	bhelgaas@google.com,
	scott@spiteful.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Subject: [PATCH V2] PCI: cpci: remove unused fields
Date: Mon, 17 Feb 2025 15:56:38 -0300
Message-Id: <20250217185638.398925-1-trintaeoitogc@gmail.com>
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
remove this pointers.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
--- 
v2 changes

- Remove uneccessary SLOT_ENABLE constant
- Remove uneccessary flags fields
---
 drivers/pci/hotplug/cpci_hotplug.h      |  2 --
 drivers/pci/hotplug/cpci_hotplug_core.c | 17 ++---------------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
index 03fa39ab0c88..a31d6b62f523 100644
--- a/drivers/pci/hotplug/cpci_hotplug.h
+++ b/drivers/pci/hotplug/cpci_hotplug.h
@@ -44,8 +44,6 @@ struct cpci_hp_controller_ops {
 	int (*enable_irq)(void);
 	int (*disable_irq)(void);
 	int (*check_irq)(void *dev_id);
-	u8  (*get_power)(struct slot *slot);
-	int (*set_power)(struct slot *slot, int value);
 };
 
 struct cpci_hp_controller {
diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index d0559d2faf50..dd93e53ea7c2 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -71,13 +71,10 @@ static int
 enable_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct slot *slot = to_slot(hotplug_slot);
-	int retval = 0;
 
 	dbg("%s - physical_slot = %s", __func__, slot_name(slot));
 
-	if (controller->ops->set_power)
-		retval = controller->ops->set_power(slot, 1);
-	return retval;
+	return 0;
 }
 
 static int
@@ -109,12 +106,6 @@ disable_slot(struct hotplug_slot *hotplug_slot)
 	}
 	cpci_led_on(slot);
 
-	if (controller->ops->set_power) {
-		retval = controller->ops->set_power(slot, 0);
-		if (retval)
-			goto disable_error;
-	}
-
 	slot->adapter_status = 0;
 
 	if (slot->extracting) {
@@ -129,11 +120,7 @@ disable_slot(struct hotplug_slot *hotplug_slot)
 static u8
 cpci_get_power_status(struct slot *slot)
 {
-	u8 power = 1;
-
-	if (controller->ops->get_power)
-		power = controller->ops->get_power(slot);
-	return power;
+	return 1;
 }
 
 static int
-- 
2.34.1


