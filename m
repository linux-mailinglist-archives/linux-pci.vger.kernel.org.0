Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF923393A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgG3Tq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 15:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3Tq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 15:46:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E13C061574;
        Thu, 30 Jul 2020 12:46:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g19so2546343plq.0;
        Thu, 30 Jul 2020 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgaIxthn1puBKq5OsnNdzrCSJ6RP+oJ4rm4uyB5mI+Y=;
        b=AjSonc7IL5rfQ7w3lEqSQP8K18+9NUodV/DGcD9FBCdZ7Ed1SygHSvTbO1o+R/WDSy
         X/eRZBn/v6s4w6SAyem/x0pb/0dQ8+srw4AeJQ/06yUsMW90aGv49XYSg/6cBtlgVaK2
         I0gVCvACeLC06ROYMx/QqgOVypMpYyOn41A65FU5Voknh+OaZHe1kOhFziv5vX2IBD00
         l32MmgiPEkM9VTiT5l6NIzvpUV590fQ8IVUWWuvzqClq3mhQPSzlMXUhG2kaeOuuqp5h
         qb2K2lhwuDQ1ob5+jGo+9lanKK7uUXr8EV51vMQ4dFg+osK2kLQJRYOqBDF0360UX48K
         HvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgaIxthn1puBKq5OsnNdzrCSJ6RP+oJ4rm4uyB5mI+Y=;
        b=MX9J5qltq5UVJAK9vRPI1uupy8kNHuLwJJCgvF7gv1EcNkmMRxmy+Ihej1BRlSwvwW
         Oj+RwSYSj5GweuisbEQh2t/fhp3zYWqF7vmOe81abKtuBFofXiUk0xxyBufJYoxI6f6X
         6Pmz8h9ltf6WFJlgLmAgOoRGKD0inlClB1TwmtHhZz9qiVcy2ZMvhXIA2NxzFkO2Hd8l
         qmq3+9UGM22CjUwZMglHWDe/AJjU7js5rTUbZFw6pO3A2gO3wl//XIabJPcPbFLxZ/rF
         fJH/DmA9fXoiqo6rZIz5YnbZ0yvfFDVoV1y6NM8BycTT0sfay1a2bK1YubKMJKsCnoBg
         +M1g==
X-Gm-Message-State: AOAM530fM7YjJZNH9Urb08ur5o+oeO5Yy4cfXpM1dB3pGVtkQWMQvmX5
        p5oEAfGSs3It10xdFVNXgWQ=
X-Google-Smtp-Source: ABdhPJznhz91/X42DS0ae6c5s/kxuUr47nB3wp630gI2/juipaicwOy9aIx4DmowiSv2I+dYgYHZwA==
X-Received: by 2002:a63:ee48:: with SMTP id n8mr485520pgk.292.1596138415267;
        Thu, 30 Jul 2020 12:46:55 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id j3sm7075368pfe.102.2020.07.30.12.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 12:46:54 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] PCI: Drop pcibios_pm_ops from the PCI subsystem
Date:   Fri, 31 Jul 2020 01:14:16 +0530
Message-Id: <20200730194416.1029509-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "struct dev_pm_ops pcibios_pm_ops", declared in include/linux/pci.h and
defined in drivers/pci/pci-driver.c, provided arch-specific hooks when a
PCI device was doing a hibernate transisiton.

Although it lost its last usage after
394216275c7d ("s390: remove broken hibernate / power management support")
patch.

After that, instances of it are found only in drivers/pci/pci-driver.c and
include/linux/pci.h, which are now unnecessary. Thus it is safe and
reasonable to remove even that.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/pci/pci-driver.c | 24 ------------------------
 include/linux/pci.h      |  4 ----
 2 files changed, 28 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index da6510af1221..0bebbdf85be8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -966,12 +966,6 @@ static int pci_pm_resume(struct device *dev)
 
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 
-/*
- * pcibios_pm_ops - provide arch-specific hooks when a PCI device is doing
- * a hibernate transition
- */
-struct dev_pm_ops __weak pcibios_pm_ops;
-
 static int pci_pm_freeze(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -1030,9 +1024,6 @@ static int pci_pm_freeze_noirq(struct device *dev)
 
 	pci_pm_set_unknown_state(pci_dev);
 
-	if (pcibios_pm_ops.freeze_noirq)
-		return pcibios_pm_ops.freeze_noirq(dev);
-
 	return 0;
 }
 
@@ -1042,12 +1033,6 @@ static int pci_pm_thaw_noirq(struct device *dev)
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int error;
 
-	if (pcibios_pm_ops.thaw_noirq) {
-		error = pcibios_pm_ops.thaw_noirq(dev);
-		if (error)
-			return error;
-	}
-
 	/*
 	 * The pm->thaw_noirq() callback assumes the device has been
 	 * returned to D0 and its config state has been restored.
@@ -1171,9 +1156,6 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
-	if (pcibios_pm_ops.poweroff_noirq)
-		return pcibios_pm_ops.poweroff_noirq(dev);
-
 	return 0;
 }
 
@@ -1183,12 +1165,6 @@ static int pci_pm_restore_noirq(struct device *dev)
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int error;
 
-	if (pcibios_pm_ops.restore_noirq) {
-		error = pcibios_pm_ops.restore_noirq(dev);
-		if (error)
-			return error;
-	}
-
 	pci_pm_default_resume_early(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 34c1c4f45288..c4900975041c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2034,10 +2034,6 @@ int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
 resource_size_t pcibios_default_alignment(void);
 
-#ifdef CONFIG_HIBERNATE_CALLBACKS
-extern struct dev_pm_ops pcibios_pm_ops;
-#endif
-
 #if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
 void __init pci_mmcfg_early_init(void);
 void __init pci_mmcfg_late_init(void);
-- 
2.27.0

