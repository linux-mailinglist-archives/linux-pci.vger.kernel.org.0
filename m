Return-Path: <linux-pci+bounces-11649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA90950CEA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 21:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BF81F25532
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3139F19EEA2;
	Tue, 13 Aug 2024 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m9KmNKyi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF211A4F22
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576292; cv=none; b=fMPHqTC+BMlmLL8TRyuET+CvRUo51PEctE6ugjdIziUVlJ1GMEr/NpZafhfm/vcJ6kqZV13Fr5NvJxAtorpfCQbMf3XAp/6SJN/pN9PKEWZjOHAv9OgNg21mbbF+BDiom27xkN7ZW74Edh8+PNwO9T2uolNeNaVmaoKzYN21rEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576292; c=relaxed/simple;
	bh=mWILBLZHbB1X/mnl4rN42BdL76EDoT2h6V0HD1WKzGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfPn63cnsobrOEzsOEaQ9MoQEzZC9XG3WHb1Q/2chi3G7XyW51aaaYxY5991K449Nes53tb/d3Q5zyVLEbo6nvBxVR+lucXf/KEo4oUmV1hUUaL8HANmJ6+icjOEIKlZ3cqAGkDNDsYmcJn2qJeYOVXLKoBGBncWvMoW5kyVL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m9KmNKyi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4281faefea9so43596275e9.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576289; x=1724181089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd+Ltzvt2y78lpUCgzPi2AZ1lJGgupHq0LCVF6fTzhc=;
        b=m9KmNKyih6czKfZE4tEc3ZKhTZNF0ImLMG4+JCdHGsFTjGASYmxhLABdvXUk7iuAXe
         T5gLg4WvsSrE8rCLh+mAirV02I8CEWgDOWBPFrtq9FntBNCZi9p7TRZoAbv6wKUm+KD+
         ISz+f9GTeqwGtpGTLbMQoNMvQIKqtpcSlbCjMoWdKwY9GIf2di3AfqwJlj8fuLhUnunr
         YEC3hY0vjxsFJZHcP3/4FKjX7Lo3BV2DFBn/9iSOvK7OqmQ/O/u3LxbK7dYkUVYD252b
         0b5RiBTH2oaw3D/ulTVAsXGw6tNhwvYjCNPvhclzViP7mVzjqkDNYRxrNCP7crU+G6cy
         ld6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576289; x=1724181089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cd+Ltzvt2y78lpUCgzPi2AZ1lJGgupHq0LCVF6fTzhc=;
        b=PJqteAbFOwhKtHih2bQup9tC0SBSTxm4A0NDXp2x1Wrg3FfCQFMQu+4s6g7i4OtEOb
         HXDjxutb4BcXWFzHOxlaChAR6RkILaBpI15DnBOymuj3M7xcX21foXHNHpHKZWFdXRIk
         9kO88JMcfL59jrGYqfQqYpAJuxFNsmZ64uFm35CAv+AB12SXBrpiF8GesZMK7rXNf1Rr
         a/iu+oQtx+9mO9QWyGlvoVZ0XIQ3R3+0Zsx6uaqDQ6SQKCBUrZOGokcQ7f/wXgIz5twa
         kO5uvn0jAHJzLP2im0cQLxgpV3TzaME+JykafzRpWtlU00fZ5ITSSFJpnNFNnb4zHVAH
         UAgg==
X-Gm-Message-State: AOJu0Yw6pKWKYRMWBpQHG44RDBu2LhHhe3Ig1Oadfwn1M8Z5h8AbHS7/
	3gDhvTQgHxUp4RYovCFSUD5nZW+A5ND/mYnXdcfxWgGpTHWJYZZ3jLS1xMVEkjg=
X-Google-Smtp-Source: AGHT+IGTb4phP4GJdlEPLX/IDQBPfgNuZKbxgy0+kCBn16LjtlKF1r5S3f6vp8AZuv/Z7KuuIe1zxA==
X-Received: by 2002:a05:600c:5116:b0:426:5dd0:a1e4 with SMTP id 5b1f17b1804b1-429dd22f272mr3517245e9.8.1723576288824;
        Tue, 13 Aug 2024 12:11:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7734595sm147511405e9.36.2024.08.13.12.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:11:25 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] PCI: don't rely on of_platform_depopulate() for reused OF-nodes
Date: Tue, 13 Aug 2024 21:11:17 +0200
Message-ID: <20240813191119.155103-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813191119.155103-1-brgl@bgdev.pl>
References: <20240813191119.155103-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

of_platform_depopulate() doesn't play nice with reused OF nodes - it
ignores the ones that are not marked explicitly as populated and it may
happen that the PCI device goes away before the platform device in which
case the PCI core clears the OF_POPULATED bit. We need to
unconditionally unregister the platform devices for child nodes when
stopping the PCI device.

Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/remove.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 910387e5bdbf..7d78d0c0b7e2 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include "pci.h"
 
@@ -16,13 +17,26 @@ static void pci_free_resources(struct pci_dev *dev)
 
 static void pci_stop_dev(struct pci_dev *dev)
 {
+	struct platform_device *pdev;
+	struct device_node *child;
+
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-		of_platform_depopulate(&dev->dev);
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
+
+		if (dev_of_node(&dev->dev)) {
+			for_each_child_of_node(dev_of_node(&dev->dev), child) {
+				pdev = of_find_device_by_node(child);
+				if (pdev) {
+					of_device_unregister(pdev);
+					of_node_clear_flag(child, OF_POPULATED);
+				}
+			}
+		}
+
 		of_pci_remove_node(dev);
 
 		pci_dev_assign_added(dev, false);
-- 
2.43.0


