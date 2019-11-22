Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7525B106C4B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 11:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfKVKvA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 05:51:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37446 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfKVKu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:50:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so8060977wrv.4
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRDncnEv4s95CgSa1yvYrULV0iuYi2jZhVWKJTRAVu0=;
        b=YNEi/CQbRXtkAwf0pPEyl5prqRn8u5HZ5xYtYrRJWWkt3EHX92cjZa+ZJIy6EgzQMY
         JomcQEQZ9aHxpyPv5xUr8gzpIvqxnMSJDzlZzKuglBou7QBJ8izCjPyAp5gagAMgiSTy
         8/Tp82wscT0Sev3YneHxCoFu66z2uQW1GImKYPrOPHwBJ+eCbINzD7/G0fD3TYBod7yi
         cXSfkjUy19kRIUpzuBATTRkMQ1lFky+4zyrQkjA9B+Fb+7/32I9fa7POnzm7YS7U86Ce
         NYiXSZoHwEnBnTVK2qCqhRV3tiLJKL/mgFahWAwg2v9n6ttfmUegZHJDqNkVa8wtqyzH
         PvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRDncnEv4s95CgSa1yvYrULV0iuYi2jZhVWKJTRAVu0=;
        b=UmIo07u8RXt4jAkOh3Ms6Gf+qgYewYjVjm6nQ14J2TVMQ373VOCeTAwoqGjgWb/+Sy
         OxSjPjwiK7hqbGP8RDzo9Fv2TIFxRmNoqPUx31gX9qcnhGDVJ4aivntSyr9ptyIT0W2s
         CN8hNbXAgis4Ns+jM1IDHNHYXFQcra29obudXZXAsfPjQ4XB/Sxd/yqZiFHp5A29l6v/
         ua0nyJCwPJvWj14NsH7iXSdliXYyBSWNsGZeF9iYSOWi3CKIAw4r8H++og9QPUN5LJmk
         bnVIZjIMIjjTOgVA2FDWcY1KiL5SmPaGvZcKWpFOm0rym0FDySBygrd/JH8a9qBOW5E2
         D9hg==
X-Gm-Message-State: APjAAAXOZNYQXbwtpfJckX7pjaLJ4wtOwU4d3aFbHmCdxP9pmBncvo1d
        xqjZrY5VlAegFChxZilO32AtQw==
X-Google-Smtp-Source: APXvYqzXiSDh39VIufdE8cTUkRB2hfptRNr1/jdFpr07MvIngTSRR794NgxmfjDCLcPXZDKMLSVPnQ==
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr10152262wrs.226.1574419857729;
        Fri, 22 Nov 2019 02:50:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:50:57 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: [RFC 05/13] ACPI/IORT: Support VIOT virtio-mmio node
Date:   Fri, 22 Nov 2019 11:49:52 +0100
Message-Id: <20191122105000.800410-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new type of node to the IORT driver, that describes a virtio-iommu
device based on the virtio-mmio transport. The node is only available
when the IORT is a sub-table of the VIOT.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/iort.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 1d43fbc0001f..adc5953fffa5 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -43,7 +43,8 @@ static bool iort_type_matches(u8 type, enum iort_node_category category)
 	switch (category) {
 	case IORT_IOMMU_TYPE:
 		return type == ACPI_IORT_NODE_SMMU ||
-		       type == ACPI_IORT_NODE_SMMU_V3;
+		       type == ACPI_IORT_NODE_SMMU_V3 ||
+		       type == ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU;
 	case IORT_MSI_TYPE:
 		return type == ACPI_IORT_NODE_ITS_GROUP;
 	default:
@@ -868,8 +869,10 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
 	case ACPI_IORT_NODE_SMMU:
 		return IS_BUILTIN(CONFIG_ARM_SMMU);
+	case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+		return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
 	default:
-		pr_warn("IORT node type %u does not describe an SMMU\n", type);
+		pr_warn("IORT node type %u does not describe an IOMMU\n", type);
 		return false;
 	}
 }
@@ -1408,6 +1411,46 @@ static int __init arm_smmu_v3_pmcg_add_platdata(struct platform_device *pdev)
 	return platform_device_add_data(pdev, &model, sizeof(model));
 }
 
+static int __init viommu_mmio_count_resources(struct acpi_iort_node *node)
+{
+	/* Mem + IRQ */
+	return 2;
+}
+
+static void __init viommu_mmio_init_resources(struct resource *res,
+					   struct acpi_iort_node *node)
+{
+	int hw_irq, trigger;
+	struct acpi_viot_iort_virtio_mmio_iommu *viommu;
+
+	viommu = (struct acpi_viot_iort_virtio_mmio_iommu *)node->node_data;
+
+	res[0].start = viommu->base_address;
+	res[0].end = viommu->base_address + viommu->span - 1;
+	res[0].flags = IORESOURCE_MEM;
+
+	hw_irq = IORT_IRQ_MASK(viommu->interrupt);
+	trigger = IORT_IRQ_TRIGGER_MASK(viommu->interrupt);
+	acpi_iort_register_irq(hw_irq, "viommu", trigger, res + 1);
+}
+
+static void __init viommu_mmio_dma_configure(struct device *dev,
+					  struct acpi_iort_node *node)
+{
+	enum dev_dma_attr attr;
+	struct acpi_viot_iort_virtio_mmio_iommu *viommu;
+
+	viommu = (struct acpi_viot_iort_virtio_mmio_iommu *)node->node_data;
+
+	attr = (viommu->flags & ACPI_VIOT_IORT_VIRTIO_MMIO_IOMMU_CACHE_COHERENT) ?
+		DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
+
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	/* Configure DMA for the page table walker */
+	acpi_dma_configure(dev, attr);
+}
+
 struct iort_dev_config {
 	const char *name;
 	int (*dev_init)(struct acpi_iort_node *node);
@@ -1443,6 +1486,14 @@ static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
 	.dev_add_platdata = arm_smmu_v3_pmcg_add_platdata,
 };
 
+static const struct iort_dev_config iort_viommu_mmio_cfg __initconst = {
+	/* Probe with the generic virtio-mmio driver */
+	.name = "virtio-mmio",
+	.dev_dma_configure = viommu_mmio_dma_configure,
+	.dev_count_resources = viommu_mmio_count_resources,
+	.dev_init_resources = viommu_mmio_init_resources,
+};
+
 static __init const struct iort_dev_config *iort_get_dev_cfg(
 			struct acpi_iort_node *node)
 {
@@ -1453,9 +1504,16 @@ static __init const struct iort_dev_config *iort_get_dev_cfg(
 		return &iort_arm_smmu_cfg;
 	case ACPI_IORT_NODE_PMCG:
 		return &iort_arm_smmu_v3_pmcg_cfg;
-	default:
-		return NULL;
 	}
+
+	if (iort_table_source == IORT_SOURCE_VIOT) {
+		switch (node->type) {
+		case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+			return &iort_viommu_mmio_cfg;
+		}
+	}
+
+	return NULL;
 }
 
 /**
-- 
2.24.0

