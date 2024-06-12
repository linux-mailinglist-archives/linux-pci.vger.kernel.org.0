Return-Path: <linux-pci+bounces-8644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7F0904E00
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062262883FA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5316D9DA;
	Wed, 12 Jun 2024 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Dyb+QMyY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D816D9A1
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180440; cv=none; b=fQnxtY5fl3jNMlpzILyXxqGcqGM7q61hp7HuW6/1l5eQv8RfzAxdoxBTuHyO3bSDRYOAyOvXxBibMUzTgFfRzgNgoxmZuTdxKjEhXTL1r+LqMGKiif6hROMpw8jG9J47MBpt+u7OQqxiP6krJFzzcHY/SBgadADuWe1KUxXzezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180440; c=relaxed/simple;
	bh=7VTZIUP9nLWj7cfEX4XfkS/W4JY/pRDIPDXFaZGz00o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JC4uNYOCxAqs0x3jcjrhbC4Q2+wD2wrwWJQYqzqslqa9ya7wVbimakA4dd6ruMkQxllRJL6/Sx8AkAoSZIlXc50FygUTYFjfHIWxnkOrycfpALXpnVJP7+Q6yR/C5c6IjvgBS6omRP7CVHuORAiMBYcxf+edpQEQx4B9jvl3Rzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Dyb+QMyY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f2c0b7701so376375f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 01:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718180438; x=1718785238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO4KK4ghKfkxpXvlbkG5KB2nyFFgyIDnrF9c5Yq0jtU=;
        b=Dyb+QMyY92SfPQc4JHqfMBQs3TqFOy1etS9uBVK3HHao5f3WdbuZK58pDKlVAQxmWB
         MrxGj57KHCHM6o6R8loD0mjzXQuT1UsonG056sascQXqktRQjeoBFP+r6KsGB+YfM1ct
         ZdYQPEOuq3CGSeb5HTJzEDBTHbvPSWwePpOKXmzakO3qgraIl8Yd+h+8XUzyoHCYGHsI
         siJUbpUygk6MUKaqI/YG6YkJexgSq4l4EZesegQY/2B5Vo/dyNT1FKmLflR4GyBRNtKS
         kOid3v+FYvSIS+7M0+G0fHRRZZv0BN1HI0qBBKVc0MgdWu1YDNhRHFTVjTq1HcThsy4n
         mIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180438; x=1718785238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO4KK4ghKfkxpXvlbkG5KB2nyFFgyIDnrF9c5Yq0jtU=;
        b=msHKEUA87zsSos/nbxcgXKVPpnBzIz/c+CTmPdYoqu0k1j1Fswl54dLtXhwYaohwVJ
         LD/FVHzN7IcQ5g+Q6KDEHJxwpYUMrrUYro2Ez3yVYjAZxXakOFAkk60961EXlOiTRUJj
         fD/6sXYvdaExfbmdbSK/JJecrPKJH8g80fTndwqI8+G/k9Uw7i7R8sPKDvVOm1S6eUQk
         doyGDXvZ7HCorzQGORae+59JwRpX9RwoV6xufO9NMmT/vwxAl+gF1U+WCANV14x5+MTx
         wG9bI6dIpE5MzlotS4CfDxq200++BFO+2VB3zUwg+Db9I8wO+4reyc0us1hKMVWpdmIm
         tuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEIYnCBULOvUiAB7AA0I+QP7KyD8kL4H6nF1O8XagRILZgFezn/o2Vw4FO1zo6imBghL1XZAo4lr9ulCCwOqt/+kw7H6EUcR4b
X-Gm-Message-State: AOJu0Yw/kjxLGTLL3aRAJSDohfugj4svIPvlMgTPAMcWgWXIXkTDtdB0
	s4RAMljmn49HvbAJPbmm9+Tof29pJMi23IDkZOKtKUx97ZUzaU2j4/oLk0SEGfs=
X-Google-Smtp-Source: AGHT+IEKZ9Pm55ZC6EKvZuzsmQYoUGEHjUjFOoy/AGQANYWcyrqioou452tdej8ico1+a6TdVtsKRQ==
X-Received: by 2002:a5d:61c4:0:b0:35f:20a0:db65 with SMTP id ffacd0b85a97d-35f2b3093e7mr4333679f8f.25.1718180437759;
        Wed, 12 Jun 2024 01:20:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229207d1a7sm6011775e9.1.2024.06.12.01.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:20:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v9 3/5] PCI/pwrctl: Create platform devices for child OF nodes of the port node
Date: Wed, 12 Jun 2024 10:20:16 +0200
Message-ID: <20240612082019.19161-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612082019.19161-1-brgl@bgdev.pl>
References: <20240612082019.19161-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In preparation for introducing PCI device power control - a set of
library functions that will allow powering-up of PCI devices before
they're detected on the PCI bus - we need to populate the devices
defined on the device-tree.

We are reusing the platform bus as it provides us with all the
infrastructure we need to match the pwrctl drivers against the
compatibles from OF nodes.

These platform devices will be probed by the driver core and bound to
the PCI pwrctl drivers we'll introduce later.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/bus.c    | 9 +++++++++
 drivers/pci/remove.c | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index dfc99b3cb958..e4735428814d 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -348,6 +349,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
 
 	pci_dev_assign_added(dev, true);
+
+	if (pci_is_bridge(dev)) {
+		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					      &dev->dev);
+		if (retval)
+			pci_err(dev, "failed to populate child OF nodes (%d)\n",
+				retval);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..910387e5bdbf 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -18,7 +19,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-
+		of_platform_depopulate(&dev->dev);
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
-- 
2.40.1


