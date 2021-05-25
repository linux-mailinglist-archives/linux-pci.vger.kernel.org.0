Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C3739017A
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 15:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhEYNCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhEYNCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 09:02:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3506C061574;
        Tue, 25 May 2021 06:00:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r1so7825172pgk.8;
        Tue, 25 May 2021 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvBY3kzaXW/pomhMTbrI9u3YqExiwHEKyhJg+OVmgg4=;
        b=Zfdvo9oKuESll8d9CiLcmhqF5KPhtrgDedQEMYiD4KJxoBADOeH9cxU9OENDpSP1o3
         BSpTScAqkSwcAlvpA9zHYqOzle8OP0VTmen2YB+vgwTl6OfmDSxBMtAL8E3vm7HSqcKm
         XrQI8wz7e6iTad6F8mXuncoWPmt0z/MfN9dQOnSmzvr/8kDpNzHiNELenfOhImhJ8y+H
         5P6KCWUIQ7ggXlLQ5dXRo2eZ2fR1vxQblAvc9LVy+zKnIWWby19GbWoccQhDegHDKOFE
         JoVGiy706RYHXgVghfwYkIWgb3Mi4byz0ZEt50Y3Czf9Bl1PC2IwKYRNiob0LIYvYVA1
         VoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvBY3kzaXW/pomhMTbrI9u3YqExiwHEKyhJg+OVmgg4=;
        b=eIpdlM1sMDK/bMq9B6yT+E4ahwlkxCybMAefUUa3L2CCmYgnzmc5X2vwwA7vaRNdOY
         jGAK6LM9vD5ThSR1/HGZtBEgOlAjw4fA62GR0lETu/kEreWLrDFY5G01We30KNyahFMo
         0bog9NeKC8p6NPKc9f+iGnzBSz5L4bP6dxWL72LeznY7uTJSMFuy1IlosRzULZSTRuyL
         Uq1XJIQAflYzdUHL6tw9Aihhl23wpPPcViqtGjlFmfQwKR35XyTK/+EHgsra8ohyFVtR
         8yZ0S8VudTQEBuvhhPvUgMGZ4xjZRrGFMUP1oF/KDwQg+UlFYgtrHbgbWGrh2bWGohb4
         Dd7A==
X-Gm-Message-State: AOAM533Nf5Yw8XKcrEb6tiInPS2l3XPo25zpQGLA3PxIyHQLZxAP3eG5
        TQEDXgwN9Cyw9SVGDXXnNDU=
X-Google-Smtp-Source: ABdhPJx9gb8y70S1Mi9oL3RZuLF/ZulxiHumxSc0FdoFHO/Co5n/+IwDqfU0B3T9+32h8In0MkI92A==
X-Received: by 2002:a63:f557:: with SMTP id e23mr8724111pgk.55.1621947627439;
        Tue, 25 May 2021 06:00:27 -0700 (PDT)
Received: from lambert.lan ([171.223.192.10])
        by smtp.gmail.com with ESMTPSA id p17sm2168850pjg.54.2021.05.25.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 06:00:26 -0700 (PDT)
From:   Lambert Wang <lambert.q.wang@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lambert Wang <lambert.q.wang@gmail.com>
Subject: [PATCH] pci: add pci_dev_is_alive API
Date:   Tue, 25 May 2021 20:59:25 +0800
Message-Id: <20210525125925.112306-1-lambert.q.wang@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Device drivers use this API to proactively check if the device
is alive or not. It is helpful for some PCI devices to detect
surprise removal and do recovery when Hotplug function is disabled.

Note: Device in power states larger than D0 is also treated not alive
by this function.

Signed-off-by: Lambert Wang <lambert.q.wang@gmail.com>
---
 drivers/pci/pci.c   | 23 +++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..8a7c039b1cd5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4659,6 +4659,29 @@ int pcie_flr(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
+/**
+ * pci_dev_is_alive - check the pci device is alive or not
+ * @pdev: the PCI device
+ *
+ * Device drivers use this API to proactively check if the device
+ * is alive or not. It is helpful for some PCI devices to detect
+ * surprise removal and do recovery when Hotplug function is disabled.
+ *
+ * Note: Device in power state larger than D0 is also treated not alive
+ * by this function.
+ *
+ * Returns true if the device is alive.
+ */
+bool pci_dev_is_alive(struct pci_dev *pdev)
+{
+	u16 vendor;
+
+	pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor);
+
+	return vendor == pdev->vendor;
+}
+EXPORT_SYMBOL(pci_dev_is_alive);
+
 static int pci_af_flr(struct pci_dev *dev, int probe)
 {
 	int pos;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59a57..2a3ba06a7347 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1227,6 +1227,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 void pcie_print_link_status(struct pci_dev *dev);
 bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
+bool pci_dev_is_alive(struct pci_dev *pdev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
-- 
2.30.2

