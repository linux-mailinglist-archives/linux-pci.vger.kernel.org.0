Return-Path: <linux-pci+bounces-6502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8968AC0DE
	for <lists+linux-pci@lfdr.de>; Sun, 21 Apr 2024 21:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3EB1F21358
	for <lists+linux-pci@lfdr.de>; Sun, 21 Apr 2024 19:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0896B4317B;
	Sun, 21 Apr 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2uCX7za"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A142ABE;
	Sun, 21 Apr 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726571; cv=none; b=FuHbj7LCtHJNdqsqUq4iODGRPJriCEJBfh/mh6jYorloQFKAwdQP9LukZ8k0z5NXJc4hyYC0pZ5PdictsZ9PvGvGiLQZ44kVqvAEC1wEml7wfvSeCnwlA8nMqK/ipTR287NhAFiyvS/dZGEQggu/nObC5lCyACq1YAcSmp4UK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726571; c=relaxed/simple;
	bh=5b1Rd+c4FpyVTxmhZ/c+aS1Qqo8vTZijXYkHUU+mNds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZC/fz7AG8DP8vWGEjKVYBRnd1OKyumFOZ80kUumu6rXQhjZpGyAJ1l577gsiiSzFaO5IBcFXM8vYQrLZcFaTK9X/yH3HYG6CL4WQRhx1Wx3Ba8T9btlW6ifO4kXkbbg8CgN6b62omAyKBDhMH/FBaqCijqddCU9DXWfdM8AGRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2uCX7za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3909C2BD11;
	Sun, 21 Apr 2024 19:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713726571;
	bh=5b1Rd+c4FpyVTxmhZ/c+aS1Qqo8vTZijXYkHUU+mNds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2uCX7zaTXjwYyn/HQscx0eZQElgdBDcegVeBMyoFW6Ni+fmor0aF/r+A6FlfHyxC
	 Fnmd5OCyvRhDoMHR4NLJ3kEta8jWq+Duf9CwA/1CyA3XQc2npDjsgNP57BdfTPaqZo
	 JL+yNZfOjIarLusj0UH4zrZu/beCz4R+iY+xchmh/nBT+oRSmlDoRWkrIZeZOa9eb0
	 K6cOgaqfPOKf1JE/accZjoJzhYGXFbbyFNAgjQ27n99xtjkO/N/kPmEscxthzbcPFL
	 6RJ4wrkv/pt+LogV3bvcwh63J4n+trLMGcepdbhk/LZowaVdA9k2SrYSMVEk0sr8iC
	 Pc/POnBWBz0ug==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Vidya Sagar <sagar.tv@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7-incomplete 2/3] PCI: of: Add of_pci_preserve_config() for per-host bridge support
Date: Sun, 21 Apr 2024 14:09:13 -0500
Message-Id: <20240421190914.374399-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240421190914.374399-1-helgaas@kernel.org>
References: <20240418174043.3750240-1-vidyas@nvidia.com>
 <20240421190914.374399-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Add of_pci_preserve_config() to look for the "linux,pci-probe-only"
property under a specified node.  If it's not found there, look under
"of_chosen" in addition.

If the caller didn't specify a node, look under "of_chosen".

With a future patch, this will support "linux,pci-probe-only" on a per host
bridge basis based on the presence of the property in the respective PCI
host bridge DT node.

Implement of_pci_check_probe_only() using of_pci_preserve_config().
---
 drivers/pci/of.c  | 60 +++++++++++++++++++++++++++++++++++++----------
 drivers/pci/pci.h |  7 ++++++
 2 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..d21c0bed36f3 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -233,28 +233,62 @@ int of_get_pci_domain_nr(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
 
+/**
+ * of_pci_preserve_config - Return true if the boot configuration needs to
+ *                          be preserved
+ * @node: Device tree node.
+ *
+ * This function looks for "linux,pci-probe-only" property for a given
+ * PCI controller's node and returns true if found. It will also look in the
+ * chosen node if the property is not found in the given controller's node.
+ * Having this property ensures that the kernel doesn't reconfigure the
+ * BARs and bridge windows that are already done by the platform firmware.
+ *
+ * Return: true if the property exists false otherwise.
+ */
+bool of_pci_preserve_config(struct device_node *node)
+{
+	u32 val = 0;
+	int ret;
+
+	if (!node) {
+		pr_warn("device node is NULL, trying with of_chosen\n");
+		node = of_chosen;
+	}
+
+retry:
+	ret = of_property_read_u32(node, "linux,pci-probe-only", &val);
+	if (ret) {
+		if (ret == -ENODATA || ret == -EOVERFLOW) {
+			pr_warn("Incorrect value for linux,pci-probe-only in %pOF, ignoring\n",
+				node);
+			return false;
+		}
+		if (ret == -EINVAL) {
+			if (node == of_chosen)
+				return false;
+
+			node = of_chosen;
+			goto retry;
+		}
+	}
+
+	if (val)
+		return true;
+	else
+		return false;
+}
+
 /**
  * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
  *                           is present and valid
  */
 void of_pci_check_probe_only(void)
 {
-	u32 val;
-	int ret;
-
-	ret = of_property_read_u32(of_chosen, "linux,pci-probe-only", &val);
-	if (ret) {
-		if (ret == -ENODATA || ret == -EOVERFLOW)
-			pr_warn("linux,pci-probe-only without valid value, ignoring\n");
-		return;
-	}
-
-	if (val)
+	if (of_pci_preserve_config(of_chosen))
 		pci_add_flags(PCI_PROBE_ONLY);
 	else
 		pci_clear_flags(PCI_PROBE_ONLY);
-
-	pr_info("PROBE_ONLY %s\n", val ? "enabled" : "disabled");
 }
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 180d3907b543..feedbedd65df 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -650,6 +650,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
 u32 of_pci_get_slot_power_limit(struct device_node *node,
 				u8 *slot_power_limit_value,
 				u8 *slot_power_limit_scale);
+bool of_pci_preserve_config(struct device_node *node);
 int pci_set_of_node(struct pci_dev *dev);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
@@ -688,6 +689,12 @@ of_pci_get_slot_power_limit(struct device_node *node,
 	return 0;
 }
 
+static inline bool
+of_pci_preserve_config(struct device_node *node)
+{
+	return false;
+}
+
 static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
-- 
2.34.1


