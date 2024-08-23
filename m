Return-Path: <linux-pci+bounces-12078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8D95C94B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 11:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA921C23173
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F99014F9F7;
	Fri, 23 Aug 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="O4dRrsTJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4B14B963
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405617; cv=none; b=bfvEoeGa0/uN7O/jo8TSFQjS3KyHzf15kbzjfSinmABw0xUi59fFKn+DvQcWl6fPde2VfCcjviKbqGPj0s4kRnFnx3nyqpDJJjNBmewAA+U4bwd73db1do60stxObHd/R1t6BZxkYYLXylpYgfOGkfl6fI0dlKqAa27OgQFJYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405617; c=relaxed/simple;
	bh=SDW+jhpHqOJq3t1ya0ovj2sjAIj5GyPFm3xRSUy/2F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoQcOL6XKiqNdGtc6RNqoU0aEHuo60GDi10w4+fyTAPPgCAQPSi8pG8ie1kBtOn0Kl7VpCXif5Pa1CX3SJAjq4Gyd9qIApIdnL2IyQOsGQK4SZcrMhUaCTIXeZppLT9HQ6aukMxSgXkiRBc35o5icabmMB57ztoFdLVWUgvshrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=O4dRrsTJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso13671425e9.1
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724405614; x=1725010414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UV0kDEyv+rHlN+IT+BwYqyEyzLehqMc19rUT/kqAz5s=;
        b=O4dRrsTJCYE8pGZG+zP/kEpBQUHJLNnc8A6R4ACfr33ts6TqwlnUGekD1iZI+z/XJQ
         OiuEANBDmki6RVSfUI6is0xxiE/JXA6+hVs5X1WrwgQuYkAAvvy2j2d38/8oC0izK3yS
         jJpGNtqYDKzlx2nmITa86WkVQ7BlbvT7Tv26Br9+zyypYoRRN5jRoOE9P7NOlZOA0PRS
         xkkEygVQNrPoofuTjt184TeWLuVDgxexR+xcEybyxMojbbmT2VrbJEp7r/S02CxLNtZk
         WwNojfOwb2v2dZNAIxr9N2KYry2SHKeABwYuxI/ioLCulLi09u8GfbxvHM5EVJ0yy7U6
         5j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724405614; x=1725010414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UV0kDEyv+rHlN+IT+BwYqyEyzLehqMc19rUT/kqAz5s=;
        b=BvZ8EFoKzsH1ERRa36Sak3T6iDwdNuP0UvEqURWkqTbdaEhv4yys5T/7StRxdH6tiG
         1tIqz8vlX5U2YjKD7LkCuF1YYFfd4exlqOCpn+44JO2HPS+XTb5SPHcHzn43ytqJb2gJ
         UQ8yVxd4DLLBy/RRmtOgqQcpulVgJvsTnWuy5301WnOVTj1MNgwo3j2+wMXPUomgDVhP
         RyuKtafU8PmteS8YB8cZrRE+DmR4S1FjcnPtBx8HsScfQnWc1CJj2v35HWzTFGd80d0R
         SJnJ/H7xUyEigMxQNcOWUkceBCAluagH3ZowtTCxVHm+pnpoaJeaDnZTOh5hLgfweruq
         nECQ==
X-Gm-Message-State: AOJu0Yz1spVttyxYTdi9JZC145neJJs5UkC33rxTBUDCwjwWNnYegwPn
	41RqsJSS955NR61NsVzvCVs9IrYiFrTWescIbx3TxO1wsaplmn8LlJgLxhwZMX+PhfUYcLlPQsy
	vqO0=
X-Google-Smtp-Source: AGHT+IEeAv1jnkfW+fOz1SblCfxZMUL3ovR6NdTgXGEH2aaFFKUhFX0IWkYCwyAUiU4W+DH5ULiI6w==
X-Received: by 2002:a05:600c:1c9c:b0:429:e67f:1249 with SMTP id 5b1f17b1804b1-42acc8d525emr12713535e9.3.1724405613016;
        Fri, 23 Aug 2024 02:33:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58fc:2464:50b0:90c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86d5esm87612035e9.15.2024.08.23.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:33:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 1/2] PCI: don't rely on of_platform_depopulate() for reused OF-nodes
Date: Fri, 23 Aug 2024 11:33:22 +0200
Message-ID: <20240823093323.33450-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823093323.33450-1-brgl@bgdev.pl>
References: <20240823093323.33450-1-brgl@bgdev.pl>
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
 drivers/pci/remove.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 910387e5bdbf..4770cb87e3f0 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -14,12 +17,25 @@ static void pci_free_resources(struct pci_dev *dev)
 	}
 }
 
+static int pci_pwrctl_unregister(struct device *dev, void *data)
+{
+	struct device_node *pci_node = data, *plat_node = dev_of_node(dev);
+
+	if (dev_is_platform(dev) && plat_node && plat_node == pci_node) {
+		of_device_unregister(to_platform_device(dev));
+		of_node_clear_flag(plat_node, OF_POPULATED);
+	}
+
+	return 0;
+}
+
 static void pci_stop_dev(struct pci_dev *dev)
 {
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-		of_platform_depopulate(&dev->dev);
+		device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
+				      pci_pwrctl_unregister);
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
-- 
2.43.0


