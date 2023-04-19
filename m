Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9135E6E820F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 21:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjDSTph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjDSTpf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 15:45:35 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3009740F9;
        Wed, 19 Apr 2023 12:45:34 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6a5f8e1f6d1so106762a34.0;
        Wed, 19 Apr 2023 12:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681933533; x=1684525533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/631JTKEftCEl7U0RJYhImjUppejEtL4G7lWmxhVT0k=;
        b=lOVpdG+dgmWSGal+5sb5fZNPGemmycwhU9BSPS/jYeZvutZ/yrM97gQn3lkfO4EfVi
         fNS6FRR4KOMx20BkAO5bfmxbdF1mM9ox4UP1U2LrlXPmVquXobeas79PALwJA8PnLjaa
         UHqRz3AGmkk0IXMsgks8jM5tWzeiXiuJyxKHkX/Bc7StvRe13dCGi6T2S39ao6ntuYre
         dVa6bJFnWn9esZcE4IZSQsAZBRt7TaMmHu+Q7zx93oABQPC0lGQnN5txLB5SyRv36mK9
         8ji805J3I1ubSd+CLmAJo8XkLfzO58AlXBtbqVrFUFurXWRxYwlXMA1EMl5T20qgULFw
         fx1g==
X-Gm-Message-State: AAQBX9elBvCz2me6FAsDj5vdzpwrldhbqNXIaABk1uZMVRDxRrkg7kmD
        JMdSCpoZYkssLtL9Vds/8A==
X-Google-Smtp-Source: AKy350ZhHG7jL9fgTZrKNE0S8W/JtB1boKT5IJduWDlB+oTDDfPakxGs3BL63VwcT51+kXrRt9N15A==
X-Received: by 2002:a05:6830:1e04:b0:6a3:df63:59b4 with SMTP id s4-20020a0568301e0400b006a3df6359b4mr476793otr.14.1681933533325;
        Wed, 19 Apr 2023 12:45:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z10-20020a9d7a4a000000b006a4244d2a7asm6948049otm.9.2023.04.19.12.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 12:45:32 -0700 (PDT)
Received: (nullmailer pid 722598 invoked by uid 1000);
        Wed, 19 Apr 2023 19:45:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Restrict device disabled status check to DT
Date:   Wed, 19 Apr 2023 14:35:13 -0500
Message-Id: <20230419193513.708818-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
checked the firmware device status for both DT and ACPI devices. That
caused a regression in some ACPI systems. The exact reason isn't clear.
It's possibly a firmware bug. For now, at least, refactor the check to
be for DT based systems only.

Note that the original implementation leaked a refcount which is now
correctly handled.

Fixes: 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
Link: https://lore.kernel.org/all/m2fs9lgndw.fsf@gmail.com/
Reported-by: Donald Hunter <donald.hunter@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Liu Peibao <liupeibao@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/of.c    | 30 ++++++++++++++++++++++++------
 drivers/pci/pci.h   |  4 ++--
 drivers/pci/probe.c |  8 ++++----
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 196834ed44fe..4c2ef2e28fb5 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -16,14 +16,32 @@
 #include "pci.h"
 
 #ifdef CONFIG_PCI
-void pci_set_of_node(struct pci_dev *dev)
+/**
+ * pci_set_of_node - Find and set device's DT device_node
+ * @dev: the PCI device structure to fill
+ *
+ * Returns 0 on success with of_node set or when no device is described in the
+ * DT. Returns -ENODEV if the device is present, but disabled in the DT.
+ */
+int pci_set_of_node(struct pci_dev *dev)
 {
+	struct device_node *node;
+
 	if (!dev->bus->dev.of_node)
-		return;
-	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
-						    dev->devfn);
-	if (dev->dev.of_node)
-		dev->dev.fwnode = &dev->dev.of_node->fwnode;
+		return 0;
+
+	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
+	if (!node)
+		return 0;
+
+	if (!of_device_is_available(node)) {
+		of_node_put(node);
+		return -ENODEV;
+	}
+
+	dev->dev.of_node = node;
+	dev->dev.fwnode = &node->fwnode;
+	return 0;
 }
 
 void pci_release_of_node(struct pci_dev *dev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d2c08670a20e..2b48a0aa8008 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -624,7 +624,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
 u32 of_pci_get_slot_power_limit(struct device_node *node,
 				u8 *slot_power_limit_value,
 				u8 *slot_power_limit_scale);
-void pci_set_of_node(struct pci_dev *dev);
+int pci_set_of_node(struct pci_dev *dev);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
@@ -662,7 +662,7 @@ of_pci_get_slot_power_limit(struct device_node *node,
 	return 0;
 }
 
-static inline void pci_set_of_node(struct pci_dev *dev) { }
+static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a3f68b6ba6ac..f96fa83f2627 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1826,7 +1826,7 @@ int pci_setup_device(struct pci_dev *dev)
 	u32 class;
 	u16 cmd;
 	u8 hdr_type;
-	int pos = 0;
+	int err, pos = 0;
 	struct pci_bus_region region;
 	struct resource *res;
 
@@ -1840,10 +1840,10 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->error_state = pci_channel_io_normal;
 	set_pcie_port_type(dev);
 
-	pci_set_of_node(dev);
+	err = pci_set_of_node(dev);
+	if (err)
+		return err;
 	pci_set_acpi_fwnode(dev);
-	if (dev->dev.fwnode && !fwnode_device_is_available(dev->dev.fwnode))
-		return -ENODEV;
 
 	pci_dev_assign_slot(dev);
 
-- 
2.39.2

