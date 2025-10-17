Return-Path: <linux-pci+bounces-38514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0DBEB605
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 21:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B166E4E51AA
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B352FC01A;
	Fri, 17 Oct 2025 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0iThYoP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B92DF3FD
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728927; cv=none; b=je/2m9cApuiewa11nnqH4I/VpYpgWlu63ZYCpNRda4Qmrae+yq6ZQM5AtE5xotMq9j9Jql35QoWTE7bT02fPwAO7qCN3GcXgZqN2hStqdbFqfvL+tON4fWklmW02D4nyJw9ggMBWQL/40ETeVWcOAUM9ixdY7hy1T9mXaCDdw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728927; c=relaxed/simple;
	bh=zSl/sOQ3KBk7i8ADPKh+1Wp21VP6JAJtCm/h3uQYmao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qdVHC3IiCSaO4ct2E++E3Tx8IJDvH4wCw3l5/F3UCa7XLqmIEzUhSyRPRPTLKGSuetWCpoEw3l9VvEMPPPrWXXrsgjy5W1XNgVazNoDbuQmhWcYZgVS0FMPFyVr7WOFfSn3mUy2Kim3HDZtya8W9QjFS9f4t/Ax0rRTHHcORUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z0iThYoP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1894904a12.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760728925; x=1761333725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Zj4VXFFqRvnlzu2xKxM1rLyOed+PBAcmGOJAFPxXKA=;
        b=Z0iThYoPGdm/9OalWx+pvZgYMzSdnMKZaVrz6WG1RY3DE2MdlseR2F8fbjOqIFtCz8
         WmGI071eQBtMl097UEQ6SfOQOQgaA9B4g6J93mU86Vzq5B0cfkasic5q2vgxSVPqsK+S
         GTFUPUakUD519hj7Gum2E3nJe+tchOTOlnLU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728925; x=1761333725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Zj4VXFFqRvnlzu2xKxM1rLyOed+PBAcmGOJAFPxXKA=;
        b=FnJJT2wWnE9qH1HMRpFBzKMUa8FW89tUOweex3P/TyQPhN8QEMn0mGip85lqKIyYyl
         asdBylrP8w9Ycl4TmHG+BPiKPCzqo+Q7KZChH7UiQMyi6YzDw0Ykf9VoQrwfHjRw7tGZ
         N9J4h7COT/jplb2tPup6dAX6L1gqyiJTOI1XQM5lxZbw3nSzx70oYOldr6Y+zQVUCvGD
         rFaq8cTOsB3oiWfK+YzpCe+ilAaGQ5yR7La+SQD7B7C68V42a0PPhgvDroKJzZkPoM1i
         IISxiTDx3NxcfZfo1amcKqe8C7T3C7BczPrhJ7C/crLgq3hVKyAIMKUw1Umf+rQQHQkP
         CtKA==
X-Forwarded-Encrypted: i=1; AJvYcCWHSeZol6v31ysthx3Wm9N7fC2s33E5zyLgkNPKEf32SUrd4KtFv2WvWrg+W4LowNgFmTY59lyMZJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0UGznTtJIqWPN2CYSjNKnMEofOIAfaQX55p4JBbet+PtDPPK
	TBSmhmMwsbcCVt5YdBFguhBNZsjhPg5ASzWCfLAynvshMo4RXnW2PFWjKAtaVmpI+DzeUHvnMNI
	nJIs=
X-Gm-Gg: ASbGnct5JRC73umDLT4nUAkIFFkcJlJ3ZwTTcfYzmTy1csrtMxR8UCWkpn353JK4JdB
	wd5GK29kQLpJGH1/ln4X4S7E6B/HFgbvzi6DpDN+EfCzWhKzl4fV+J5Ytz9wXeZn4snkHqwzWDU
	OkAyU+pOKreLkDam04aDoJLE11/BwRK9N1IkaUYphsNrF8jQHRyPvb88CiqEIkPPO5bCHSGExKS
	zvU9Z8BQkhLO+V8iVHeA7ExRRO+HUSGGpqpQs7fGfcLztwWGKyVezjpyJmKyMbOkqgkxAs97JrK
	/x9staYbDMNesI/RUgSuyftUOkwLIAsKOpjwKh9WDfAwvs8HQE9/EXJZw5JtDXDYI8WrnAhnIO7
	V8jZFbot8m7fH1r80phrSUqvktLWxD2HompZ4ahpjoeqRsMgkzWq5gsTA6UHIPwqanfc81WtWtJ
	e+CUAtVgVmKNdwkMOJOXeO/e2wY6WelaHf/g0IdWtyiSFViqgt
X-Google-Smtp-Source: AGHT+IFAAbkjfr0le6ea1oHImV4kAyDrBstZFai2T458GK8mhda6jZiJODFckP73bHLy/lAnTldVpg==
X-Received: by 2002:a05:6a20:9144:b0:2cc:692a:3a2b with SMTP id adf61e73a8af0-334a85640d4mr6572099637.16.1760728924873;
        Fri, 17 Oct 2025 12:22:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b6a76b33a27sm511259a12.25.2025.10.17.12.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 12:22:04 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] PCI/PM: Prevent runtime suspend before devices are fully initialized
Date: Fri, 17 Oct 2025 12:21:23 -0700
Message-ID: <20251017122123.v2.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Today, it's possible for a PCI device to be created and
runtime-suspended before it is fully initialized. When that happens, the
device will remain in D0, but the suspend process may save an
intermediate version of that device's state -- for example, without
appropriate BAR configuration. When the device later resumes, we'll
restore invalid PCI state and the device may not function.

Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
until we've fully initialized the device.

More details on how exactly this may occur:

1. PCI device is created by pci_scan_slot() or similar
2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; the
   device starts "active" and we initially prevent (pm_runtime_forbid())
   suspend -- but see [*] footnote
3. Underlying 'struct device' is added to the system (device_add());
   runtime PM can now be configured by user space
4. PCI device receives BAR configuration
   (pci_assign_unassigned_bus_resources(), etc.)
5. PCI device is added to the system in pci_bus_add_device()

The device may potentially suspend between #3 and #4.

[*] By default, pm_runtime_forbid() prevents suspending a device; but by
design, this can be overridden by user space policy via

  echo auto > /sys/bus/pci/devices/.../power/control

Thus, the above #3/#4 sequence is racy with user space (udev or
similar).

Notably, many PCI devices are enumerated at subsys_initcall time and so
will not race with user space. However, there are several scenarios
where PCI devices are created later on, such as with hotplug or when
drivers (pwrctrl or controller drivers) are built as modules.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Cc: <stable@vger.kernel.org>
---

Changes in v2:
 * Update CC list
 * Rework problem description
 * Update solution: defer pm_runtime_enable(), instead of trying to
   get()/put()

 drivers/pci/bus.c | 3 +++
 drivers/pci/pci.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index f26aec6ff588..fc66b6cb3a54 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -375,6 +376,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	pm_runtime_enable(&dev->dev);
+
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..f792164fa297 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3226,7 +3226,6 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_set_active(&dev->dev);
-	pm_runtime_enable(&dev->dev);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
-- 
2.51.0.858.gf9c4a03a3a-goog


