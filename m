Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9D1DCD84
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgEUNAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 09:00:34 -0400
Received: from foss.arm.com ([217.140.110.172]:46130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgEUNAe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 09:00:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62CFDD6E;
        Thu, 21 May 2020 06:00:33 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.29.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE3E83F305;
        Thu, 21 May 2020 06:00:30 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 06/12] of/iommu: Make of_map_rid() PCI agnostic
Date:   Thu, 21 May 2020 14:00:02 +0100
Message-Id: <20200521130008.8266-7-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is nothing PCI specific (other than the RID - requester ID)
in the of_map_rid() implementation, so the same function can be
reused for input/output IDs mapping for other busses just as well.

Rename the RID instances/names to a generic "id" tag and provide
an of_map_rid() wrapper function so that we can leave the existing
(and legitimate) callers unchanged.

No functionality change intended.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/iommu/of_iommu.c |  2 +-
 drivers/of/base.c        | 42 ++++++++++++++++++++--------------------
 include/linux/of.h       | 17 +++++++++++++++-
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 20738aacac89..ad96b87137d6 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -145,7 +145,7 @@ static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
+	err = of_map_id(master_np, mc_dev->icid, "iommu-map",
 			 "iommu-map-mask", &iommu_spec.np,
 			 iommu_spec.args);
 	if (err)
diff --git a/drivers/of/base.c b/drivers/of/base.c
index ae03b1218b06..e000e17bd602 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2201,15 +2201,15 @@ int of_find_last_cache_level(unsigned int cpu)
 }
 
 /**
- * of_map_rid - Translate a requester ID through a downstream mapping.
+ * of_map_id - Translate a requester ID through a downstream mapping.
  * @np: root complex device node.
- * @rid: device requester ID to map.
+ * @id: device ID to map.
  * @map_name: property name of the map to use.
  * @map_mask_name: optional property name of the mask to use.
  * @target: optional pointer to a target device node.
  * @id_out: optional pointer to receive the translated ID.
  *
- * Given a device requester ID, look up the appropriate implementation-defined
+ * Given a device ID, look up the appropriate implementation-defined
  * platform ID and/or the target device which receives transactions on that
  * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
  * @id_out may be NULL if only the other is required. If @target points to
@@ -2219,11 +2219,11 @@ int of_find_last_cache_level(unsigned int cpu)
  *
  * Return: 0 on success or a standard error code on failure.
  */
-int of_map_rid(struct device_node *np, u32 rid,
+int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out)
 {
-	u32 map_mask, masked_rid;
+	u32 map_mask, masked_id;
 	int map_len;
 	const __be32 *map = NULL;
 
@@ -2235,7 +2235,7 @@ int of_map_rid(struct device_node *np, u32 rid,
 		if (target)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
-		*id_out = rid;
+		*id_out = id;
 		return 0;
 	}
 
@@ -2255,22 +2255,22 @@ int of_map_rid(struct device_node *np, u32 rid,
 	if (map_mask_name)
 		of_property_read_u32(np, map_mask_name, &map_mask);
 
-	masked_rid = map_mask & rid;
+	masked_id = map_mask & id;
 	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
 		struct device_node *phandle_node;
-		u32 rid_base = be32_to_cpup(map + 0);
+		u32 id_base = be32_to_cpup(map + 0);
 		u32 phandle = be32_to_cpup(map + 1);
 		u32 out_base = be32_to_cpup(map + 2);
-		u32 rid_len = be32_to_cpup(map + 3);
+		u32 id_len = be32_to_cpup(map + 3);
 
-		if (rid_base & ~map_mask) {
-			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
+		if (id_base & ~map_mask) {
+			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
 				np, map_name, map_name,
-				map_mask, rid_base);
+				map_mask, id_base);
 			return -EFAULT;
 		}
 
-		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
+		if (masked_id < id_base || masked_id >= id_base + id_len)
 			continue;
 
 		phandle_node = of_find_node_by_phandle(phandle);
@@ -2288,20 +2288,20 @@ int of_map_rid(struct device_node *np, u32 rid,
 		}
 
 		if (id_out)
-			*id_out = masked_rid - rid_base + out_base;
+			*id_out = masked_id - id_base + out_base;
 
-		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
-			np, map_name, map_mask, rid_base, out_base,
-			rid_len, rid, masked_rid - rid_base + out_base);
+		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
+			np, map_name, map_mask, id_base, out_base,
+			id_len, id, masked_id - id_base + out_base);
 		return 0;
 	}
 
-	pr_info("%pOF: no %s translation for rid 0x%x on %pOF\n", np, map_name,
-		rid, target && *target ? *target : NULL);
+	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
+		id, target && *target ? *target : NULL);
 
 	/* Bypasses translation */
 	if (id_out)
-		*id_out = rid;
+		*id_out = id;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_map_rid);
+EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/include/linux/of.h b/include/linux/of.h
index c669c0a4732f..b7934566a1aa 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -554,10 +554,18 @@ bool of_console_check(struct device_node *dn, char *name, int index);
 
 extern int of_cpu_node_to_id(struct device_node *np);
 
-int of_map_rid(struct device_node *np, u32 rid,
+int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
+static inline int of_map_rid(struct device_node *np, u32 rid,
+			     const char *map_name,
+			     const char *map_mask_name,
+			     struct device_node **target, u32 *id_out)
+{
+	return of_map_id(np, rid, map_name, map_mask_name, target, id_out);
+}
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
@@ -978,6 +986,13 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 	return -ENODEV;
 }
 
+static inline int of_map_id(struct device_node *np, u32 id,
+			     const char *map_name, const char *map_mask_name,
+			     struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
+
 static inline int of_map_rid(struct device_node *np, u32 rid,
 			     const char *map_name, const char *map_mask_name,
 			     struct device_node **target, u32 *id_out)
-- 
2.26.1

