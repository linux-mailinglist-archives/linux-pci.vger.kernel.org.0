Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10E51BCF7
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbfEMSJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:09:43 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13585 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732341AbfEMSJi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:09:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2dd0000>; Mon, 13 May 2019 11:09:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:09:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:09:37 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:37 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:36 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:09:33 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 27/29] PCI: OF: Add of_pci_get_reset_gpio() to parse reset-gpios from DT
Date:   Mon, 13 May 2019 23:37:42 +0530
Message-ID: <20190513180744.16493-28-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770973; bh=OaVNV3zDqdobUqZ9KaxxwhuNDNBZC8FbLgN3Lw/TtHk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=TJ4Ko5XdiUjoXftbv9VJ4ChA6xhuYRTG+sB4nhqWYofN+hvH+XKDfV3rqV0CihTIT
         aCjrxYPcOl7CqV3k9a1HI561HFYbL6P0A61RM2CHpSW/VFWg66kWbB47XjiOXO7gDc
         8VYz6PAnSWAoxXH6/bq4pN7fD/C/UmPqQaZRBbIRHXB766oo/INsLlwut031ATUJmh
         Frovg3xdY1ZxdclhxK7TOsmJ4TAXHfLvXmXMBPgvGxMyaeYVW8dYI4BxIHtBlIqaFP
         IDVxXkGG9K7tnZ1AcbU4koGx2wMSd8Y0Vkuv0OuzP7768e8WFGJIyMLtoL99+jNg56
         UcSanf1TFUJBQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This new helper function could be used by host drivers to get the reset
GPIO descriptor. If the property isn't assigned, it will return NULL to
the caller.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3: New patch to add helper function to parse "reset-gpios"

 drivers/pci/of.c       | 18 ++++++++++++++++++
 include/linux/of_pci.h | 10 ++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 9454c90980c9..2a0282115ff0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt)	"PCI: OF: " fmt
 
+#include <linux/gpio/consumer.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -224,6 +225,23 @@ int of_pci_get_max_link_speed(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
 
+/**
+ * of_pci_get_reset_gpio() - Get PCI reset gpio descriptor.
+ *
+ * @node: device node
+ *
+ * Returns PCI reset gpio descriptor from DT, or an ERR_PTR() if the
+ * required property is invalid.
+ */
+struct gpio_desc *of_pci_get_reset_gpio(struct device *dev,
+					struct device_node *node,
+					int dflags, char *label)
+{
+	return devm_gpiod_get_from_of_node(dev, node, "reset-gpios", 0, dflags,
+					   label);
+}
+EXPORT_SYMBOL_GPL(of_pci_get_reset_gpio);
+
 /**
  * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
  *                           is present and valid
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 21a89c4880fa..230ddc813ef9 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -13,6 +13,9 @@ struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
+struct gpio_desc *of_pci_get_reset_gpio(struct device *dev,
+					struct device_node *np,
+					int dflags, char *label);
 void of_pci_check_probe_only(void);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
@@ -26,6 +29,13 @@ static inline int of_pci_get_devfn(struct device_node *np)
 	return -EINVAL;
 }
 
+static inline struct gpio_desc *of_pci_get_reset_gpio(struct device *dev,
+						      struct device_node *np,
+						      int dflags, char *label)
+{
+	return -EINVAL;
+}
+
 static inline void of_pci_check_probe_only(void) { }
 #endif
 
-- 
2.17.1

