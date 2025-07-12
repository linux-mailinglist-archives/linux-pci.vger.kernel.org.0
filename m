Return-Path: <linux-pci+bounces-31987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1AB02864
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 02:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9167BACDF
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 00:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B582628D;
	Sat, 12 Jul 2025 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kTJo284F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE46FC3
	for <linux-pci@vger.kernel.org>; Sat, 12 Jul 2025 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281155; cv=none; b=SvX+2wJz5IBq7P/sFzKKFqSPg4goUu7NX/byPyaLHqHZCOyMW9KsUqleWye8OuR9CjT4K/qX9q2jpmVBUVydPLULWz6fc5s4Dx6UkZoSTbgHrG//S3CryJhm1AktUNtlGhmEDNcCQpy1yQv9KUid3I+Nw6lAfKfUkrToCgrn9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281155; c=relaxed/simple;
	bh=wZRC3768sQ4ndPdby3EVXCKB4t0sLad87/suBIYDA80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvcDmF4Io4MmKgCgu4Yw1akuIz3vH+FcHc8cnF1Jr3oDiSbfXM5wXixJAd2KhpM1jGk7+A6oxgPOYkMXG4Eze+RjahRLh+4gVEDzRn4q3/XSUQUCwz00Gd8sl+69z/J//0qXaAVP3ee7++MY2Q64gKy6SC0b4HJoKU7pOMC9Z3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kTJo284F; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2519530b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 17:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752281153; x=1752885953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfQOcwwXOFz4Tmhkh5st/lLbRodZEg2P3q+1wTBDVNk=;
        b=kTJo284FB3KfKplzZURzoTx9MQiSpgFem2sMQ7k/eTHWoWBZUmd5wYkLPAnkNGRSym
         CTgUM8JnS4r4UE0dxrmu43eo63JdNpnuhRGGIx3iRdioRKEQnYU/leJI2QOJdCh/LRkC
         Cj6BiROoIG56h4bIveGAMzUn+AYcLkLQN/BGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281153; x=1752885953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfQOcwwXOFz4Tmhkh5st/lLbRodZEg2P3q+1wTBDVNk=;
        b=YQHzhX2v8US7/75ngOFSrLdpU+JNxmz3rIae2v242MEmyyN3MKP1jjbgnFOPtpRNL8
         u9/JthT3i9ZeK572Ydm1NfG8d8fGOwhWiC63VnfcrxVWhJV1Qxk/zlbJKCeIAwWgSO/Q
         KbNrusrENXtQRZD0lAm74o420xzj9u7mF9yl+scIqyLsGFYNR31NQPcEp1OHOZHZuYyB
         pTNNNofowhifkBym6BruKfTY8NfXB9109DxRP8GB2GxWKs65fRnXpRZlWtyfGSyAe8cw
         /F8o4ml9ikKq9Ki3gCiPuUknXtXjvzH5CU6PZpCIO1fuLtEZWvBEwRJq8xPJcmCeKAxk
         HIYw==
X-Gm-Message-State: AOJu0Ywy0tRKN6qo5FG2oQ1Za6QYFZE3bwWQ4Ah7MMPDV2AYKiUUboWB
	7+Gd44a+bA/Yr52itoZ5pEMJoK/EsvbdXKva+tdOv8EfYGeKAWjsXHVA+GESYG4ODz4Kr4rLKyB
	PQC8=
X-Gm-Gg: ASbGncv4raqEitHXVUqgxXEA7LRZtmDihgQUJcBTBKKEoOGHir9Zi3ppaCS7Zx9+dc/
	NoHAsmT4vT8vwyPD1slju/Ohj/dEjn/wfK6JRslyI3dIrDQmAyzk6U0UonYTXfePAuQ3GtrWHdG
	e/zEPoDY09FptEt5TlljkSHoK+NRL76qOQb5n358xjz5TRQmjGRzDSf7dUM7TVAHgVAyFgqQyfW
	Hw0u5K7Nfm9nD33W9Rn5+DcKW2rru8J5fKHpK1EQytK3ByuYUnFq4dT3JeEiPD1Pspphu9aj55H
	FihxVZ9J+AvQmBsKSDnKtL70vW+7imoLljlDch7zjEOjD7AQwUzyQ9UZ2Vpy8blEQzBNZBeHz6r
	vZLwwZB8UTWJFKKh0wIhvumRv5BH0IIfukfc14ULIL4TsA8CYAUeyf9ntQ2qm
X-Google-Smtp-Source: AGHT+IHCMas8FZrPTmTDPwqlWCfx2VK8RrrP03PCflGylbAOpkHh/rXkv/eBpNJtnprX7KZRpZZ3xQ==
X-Received: by 2002:a05:6a20:7f8e:b0:22b:8f7f:5cb2 with SMTP id adf61e73a8af0-2311dc636b0mr8545683637.8.1752281152755;
        Fri, 11 Jul 2025 17:45:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2386:8bd3:333b:b774])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9e14e8esm6381665b3a.56.2025.07.11.17.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 17:45:51 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI/pwrctrl: Only destroy alongside host bridge
Date: Fri, 11 Jul 2025 17:43:33 -0700
Message-ID: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

We have asymmetry w.r.t. pwrctrl device creation and destruction.
pwrctrl devices are created by the host bridge, as part of scanning for
child devices, but they are destroyed by the child device. This causes
confusing behavior in cases like the following:

1. PCI device is removed (e.g., via /sys/bus/pci/devices/*/remove);
   pwrctrl device is also destroyed
2. pwrctrl driver is removed (e.g., rmmod)
3. pwrctrl driver is reloaded

One could expect #3 to re-bind to the pwrctrl device and re-power the
device; but there's no device to bind to, so it remains off. Instead, we
require a forced rescan (/sys/bus/pci/devices/*/rescan) to recreate the
pwrctrl device(s) and restore power.

This asymmetry isn't required though; it makes more logical sense to
retain the pwrctrl devices even without the PCI device, since pwrctrl is
more of a logical ancestor than a child.

Additionally, Documentation/PCI/sysfs-pci.rst documents the behavior of
step #1 (remove):

  The 'remove' file is used to remove the PCI device, by writing a
  non-zero integer to the file. This does not involve any kind of
  hot-plug functionality, e.g. powering off the device.

Instead, let's destroy a pwrctrl device only when its parent (the host
bridge) is destroyed.

We use of_platform_device_destroy(), since it's the logical inverse of
pwrctrl creation (of_platform_device_create()). It performs more or less
the same things pci_pwrctrl_unregister() did, with some added bonus of
ensuring these are OF_POPULATED devices.

Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/probe.c  |  4 ++++
 drivers/pci/remove.c | 18 ------------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..ad6e7d05b9bc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
@@ -627,6 +628,9 @@ static void pci_release_host_bridge_dev(struct device *dev)
 {
 	struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
 
+	/* Clean up any pwrctrl children. */
+	device_for_each_child(dev, NULL, of_platform_device_destroy);
+
 	if (bridge->release_fn)
 		bridge->release_fn(bridge);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 445afdfa6498..58dbb41c4730 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -17,23 +17,6 @@ static void pci_free_resources(struct pci_dev *dev)
 	}
 }
 
-static void pci_pwrctrl_unregister(struct device *dev)
-{
-	struct device_node *np;
-	struct platform_device *pdev;
-
-	np = dev_of_node(dev);
-	if (!np)
-		return;
-
-	pdev = of_find_device_by_node(np);
-	if (!pdev)
-		return;
-
-	of_device_unregister(pdev);
-	of_node_clear_flag(np, OF_POPULATED);
-}
-
 static void pci_stop_dev(struct pci_dev *dev)
 {
 	pci_pme_active(dev, false);
@@ -64,7 +47,6 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_doe_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
-	pci_pwrctrl_unregister(&dev->dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


