Return-Path: <linux-pci+bounces-19983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE72A13E82
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 16:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40AC18866A3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D8622B5A5;
	Thu, 16 Jan 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjs1AS1x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E5236A9D;
	Thu, 16 Jan 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042945; cv=none; b=meRBEqQBm2YgEi78rELCsDqOzI7HIqJxn4HDVIg2GoJQPquPwf3GjO5rxcLIKkp8iDZ13cpoGm5OtzHzoJVgg5OLtt0xo1o7ABIQc7FoDnq0u1gJSA3SyytUVZOeIx5CylYpxvzS5qA7a7Wy0ZzFYuZjYhpZJMnM49eGBUu6zS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042945; c=relaxed/simple;
	bh=ch3lPgpH9FqpWF5yhIl3KdS/BSZwVZLBNQlPIEZ73z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTdcnwcff9I9gXhj3wNPKAAwpZg+mcJlCy3rPy9wtdnxIU5LPZCnrwU64EQxhjy8GuRHPMUVfWKSKpqrkPLOrmzRSEFzdBujyDQV42tkZRqBcgk6V2UX+UWYT/1syTSsi2koi2maPGdVLheP/+kke4VbuJrXZ2+LVZgtE+G8Ido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sjs1AS1x; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29f88004a92so623799fac.1;
        Thu, 16 Jan 2025 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737042942; x=1737647742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnUJdLyMGBvO/hIllptp513IAD0oBTKPE00WpFD+Cy8=;
        b=Sjs1AS1xHP4bsVN6DY0MGVPeneYybhFV5OAlQ120Q9je8qkZJTZyfhoIOIykHBs6NC
         /9ZCMdpZt3R/qR7Wj7FUJC2gatQS7tZjbvJAQBob5Sy9hkdyxVVi6Yxy9ADidu6UyvdH
         b7Wy/yNcxN7Qsb4SWT4/rcSV0p869sI7CABmgd2vJAHTxuaT4zxMsg2r3V9gQx3TWQKp
         +uFlGRZwy+jK9cW6k03GtdBlwxTD3cN02k4ChuXVkPVvhCCCYS/KYu2hTV/qAR4lA8yE
         abk3eSHedlVbphS+Kam2fLeqWOp3gi9jpoewn07yEF2D5ySOGn+remZ0zX3MBjvOqv9J
         FO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737042942; x=1737647742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnUJdLyMGBvO/hIllptp513IAD0oBTKPE00WpFD+Cy8=;
        b=nm7UhYnv1AWDe6t1SECLH9fCsduyACFHH3EQlXhTion3ZmyP5p7vRf3WjEA7XegLly
         hIkOmfIOsn7HV+zFqbeIkF1YsOXXh7zxrtzck4PTuwBEMjrtX/HZQQUEI4X5ChvaijPn
         nGzsvv29Oglds/QcyNcPpuTm8xpSwFlGnqZs69Qjmg+iBAqOZ1krZeaUlczYyTl8fPXy
         rGYPOq1D/QRdrJln6IhMiKlZ6WGY7e1abKRlTYuoWK8uwiqNiFXa3YA2BWzi119bc+uZ
         X0XG3TIzxDh65fv269jiVDdO3PDeW2xgBcwcLgmFBeC6MpEcAacRTA5ufMvVm1QkgBl2
         174w==
X-Forwarded-Encrypted: i=1; AJvYcCVKjjs7rDpGOsfJjV1xfM9tXs5cHunxHPTJyvKI/QT3x9FfPWCFnlk+qHDXdWwGbEKabbrCbVW+Eb2cgEU=@vger.kernel.org, AJvYcCVjVIsbg1A3xnNdkdxBeihREWLcVJGxB7YfLPlvx8+1XORtIyhRVOcx1Frqq6zRb384em5utbzSNJr2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+VdsXiovGVxW/YzL5N+gzVjnxOmQ3EeFgHsnfr75Q+1oQJMo
	XuGeBdP1isIh4mt1LrGI/rxzMdAZYqYchd0fie31ZVXrB2zgUjpd
X-Gm-Gg: ASbGnct3sB7pLd++yVqPzwzuGbr1VEWeO+tnDypGc1CmwOlwismkcRmuA6asHwoXdMN
	xtmaF74kEhvFzD5jhEp4LR1mvN4cep5wqqD7rvnvHNOB6q8b5tnOXs+ZT9vILNhdBBXhjrj8upJ
	l3hzSEugsJDkGTbL/+CvTo9h5VjCk6EnIBNdKzcLR9pzbr/WTCjf76JkWwGZ4yLum2VHQJozOuu
	ppQDC9TW3FMDR63obakqGAhRyV/MWDl7ucYJhsogA1xw9vCuQfYUneQe3KXNlVoMQ==
X-Google-Smtp-Source: AGHT+IHxIhEUBamRaUpSODjaN7YVprHAk+zl/KRQ5xXZtQBoq+IHwYwJyKH+7xpf19/MRXipFgqmxA==
X-Received: by 2002:a05:6871:a0c8:b0:29d:c6ef:cf1d with SMTP id 586e51a60fabf-2aa06549ec9mr17818663fac.7.1737042942603;
        Thu, 16 Jan 2025 07:55:42 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b8f76937sm161213fac.31.2025.01.16.07.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 07:55:42 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] PCI: cpci: remove unused fields
Date: Thu, 16 Jan 2025 12:55:03 -0300
Message-Id: <20250116155503.1665430-1-trintaeoitogc@gmail.com>
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


