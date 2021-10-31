Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA52440EF1
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 16:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhJaPJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 11:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhJaPJn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 11:09:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81FA260F46;
        Sun, 31 Oct 2021 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635692831;
        bh=pu+nuuiYf3vFkm8I+mielJIumq1y5NXzzcjEOc9xynM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcHN4YvC0zWHvNsPeMq1plBp4V937Qq4e8uD3KmwQtRY8DrP6wl9D2PdmYrvp0CO3
         OkLbCc6VN7guQXNlUsV7jZmoJDQeRcHXZpMk1HrKeCoJF1jpd0p1Vkt7eUhB+ivfDs
         hYzwSmpAONK0LclUyjPcORusPyg3nt2qWBbzJEiWopCyBClpP3iIHNvcu0nUQ97ais
         arfpQSQoH5qgYVcH1ZJg3+0iDJ/2vE958Ca+rXktCT1TZPSOC5EwRFlLa6mpTibI04
         P4yx1Wxfi5IOLPgqdySqd1ffJK8MQCbGjpZxDyRlTcKNjUHtY9zavOcUErZJDApphy
         V4GEtwyXaDSRg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH dt + pci 2/2] PCI: Add function for parsing `slot-power-limit-milliwatt` DT property
Date:   Sun, 31 Oct 2021 16:07:06 +0100
Message-Id: <20211031150706.27873-2-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211031150706.27873-1-kabel@kernel.org>
References: <20211031150706.27873-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Add function of_pci_get_slot_power_limit(), which parses the
`slot-power-limit-milliwatt` DT property, returning the value in
milliwatts and in format ready for the PCIe Slot Capabilities Register.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h | 15 +++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index d84381ce82b5..9c1a38d5dd99 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -627,3 +627,67 @@ int of_pci_get_max_link_speed(struct device_node *node)
 	return max_link_speed;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
+
+/**
+ * of_pci_get_slot_power_limit - Parses the "slot-power-limit-milliwatt"
+ *				 property.
+ *
+ * @node: device tree node with the slot power limit information
+ * @slot_power_limit_value: pointer where the value should be stored in PCIe
+ *			    Slot Capabilities Register format
+ * @slot_power_limit_scale: pointer where the scale should be stored in PCIe
+ *			    Slot Capabilities Register format
+ *
+ * Returns the slot power limit in milliwatts and if @slot_power_limit_value
+ * and @slot_power_limit_scale pointers are non-NULL, fills in the value and
+ * scale in format used by PCIe Slot Capabilities Register.
+ *
+ * If the property is not found or is invalid, returns 0.
+ */
+u32 of_pci_get_slot_power_limit(struct device_node *node,
+				u8 *slot_power_limit_value,
+				u8 *slot_power_limit_scale)
+{
+	u32 slot_power_limit;
+	u8 value, scale;
+
+	if (of_property_read_u32(node, "slot-power-limit-milliwatt",
+				 &slot_power_limit))
+		slot_power_limit = 0;
+
+	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
+	if (slot_power_limit == 0) {
+		value = 0x00;
+		scale = 0;
+	} else if (slot_power_limit <= 255) {
+		value = slot_power_limit;
+		scale = 3;
+	} else if (slot_power_limit <= 255*10) {
+		value = slot_power_limit / 10;
+		scale = 2;
+	} else if (slot_power_limit <= 255*100) {
+		value = slot_power_limit / 100;
+		scale = 1;
+	} else if (slot_power_limit <= 239*1000) {
+		value = slot_power_limit / 1000;
+		scale = 0;
+	} else if (slot_power_limit <= 250*1000) {
+		value = 0xF0;
+		scale = 0;
+	} else if (slot_power_limit <= 275*1000) {
+		value = 0xF1;
+		scale = 0;
+	} else {
+		value = 0xF2;
+		scale = 0;
+	}
+
+	if (slot_power_limit_value)
+		*slot_power_limit_value = value;
+
+	if (slot_power_limit_scale)
+		*slot_power_limit_scale = scale;
+
+	return slot_power_limit;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1cce56c2aea0..9352278141be 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -665,6 +665,9 @@ struct device_node;
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
+u32 of_pci_get_slot_power_limit(struct device_node *node,
+				u8 *slot_power_limit_value,
+				u8 *slot_power_limit_scale);
 void pci_set_of_node(struct pci_dev *dev);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
@@ -691,6 +694,18 @@ of_pci_get_max_link_speed(struct device_node *node)
 	return -EINVAL;
 }
 
+static inline u32
+of_pci_get_slot_power_limit(struct device_node *node,
+			    u8 *slot_power_limit_value,
+			    u8 *slot_power_limit_scale)
+{
+	if (slot_power_limit_value)
+		*slot_power_limit_value = 0;
+	if (slot_power_limit_scale)
+		*slot_power_limit_scale = 0;
+	return 0;
+}
+
 static inline void pci_set_of_node(struct pci_dev *dev) { }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
-- 
2.32.0

