Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB2B20038C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgFSIVX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 04:21:23 -0400
Received: from foss.arm.com ([217.140.110.172]:46916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbgFSIUi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jun 2020 04:20:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EEA11396;
        Fri, 19 Jun 2020 01:20:37 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE18A3F71F;
        Fri, 19 Jun 2020 01:20:33 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 03/12] ACPI/IORT: Make iort_msi_map_rid() PCI agnostic
Date:   Fri, 19 Jun 2020 09:20:04 +0100
Message-Id: <20200619082013.13661-4-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is nothing PCI specific in iort_msi_map_rid().

Rename the function using a bus protocol agnostic name,
iort_msi_map_id(), and convert current callers to it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 12 ++++++------
 drivers/pci/msi.c         |  2 +-
 include/linux/acpi_iort.h |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 902e2aaca946..53f9ef515089 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -568,22 +568,22 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
 }
 
 /**
- * iort_msi_map_rid() - Map a MSI requester ID for a device
+ * iort_msi_map_id() - Map a MSI input ID for a device
  * @dev: The device for which the mapping is to be done.
- * @req_id: The device requester ID.
+ * @input_id: The device input ID.
  *
- * Returns: mapped MSI RID on success, input requester ID otherwise
+ * Returns: mapped MSI ID on success, input ID otherwise
  */
-u32 iort_msi_map_rid(struct device *dev, u32 req_id)
+u32 iort_msi_map_id(struct device *dev, u32 input_id)
 {
 	struct acpi_iort_node *node;
 	u32 dev_id;
 
 	node = iort_find_dev_node(dev);
 	if (!node)
-		return req_id;
+		return input_id;
 
-	iort_node_map_id(node, req_id, &dev_id, IORT_MSI_TYPE);
+	iort_node_map_id(node, input_id, &dev_id, IORT_MSI_TYPE);
 	return dev_id;
 }
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 74a91f52ecc0..77f48b95e277 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1536,7 +1536,7 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 
 	of_node = irq_domain_get_of_node(domain);
 	rid = of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
-			iort_msi_map_rid(&pdev->dev, rid);
+			iort_msi_map_id(&pdev->dev, rid);
 
 	return rid;
 }
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 08ec6bd2297f..e51425e083da 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -28,7 +28,7 @@ void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
-u32 iort_msi_map_rid(struct device *dev, u32 req_id);
+u32 iort_msi_map_id(struct device *dev, u32 id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 					  enum irq_domain_bus_token bus_token);
 void acpi_configure_pmsi_domain(struct device *dev);
@@ -39,8 +39,8 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 #else
 static inline void acpi_iort_init(void) { }
-static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
-{ return req_id; }
+static inline u32 iort_msi_map_id(struct device *dev, u32 id)
+{ return id; }
 static inline struct irq_domain *iort_get_device_domain(
 	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
 { return NULL; }
-- 
2.26.1

