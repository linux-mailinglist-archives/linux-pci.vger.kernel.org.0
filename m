Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF0FE106F8D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfKVKvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 05:51:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40684 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbfKVKvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:51:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id y5so7036810wmi.5
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmQroTy0ZSrB9+ytyBw658P0+bfjBqqeFkyQrRlY2fc=;
        b=R/GX7GpncHdtpCGTNb9LZDYyir4t0PAmFjI7FlT5nol5eGqh3g9UoW1PBFoTNplogC
         SVaBaD4hexSWM3jfSYqGTKlvokoECPyser6aGFmjBzeKT2/KrCawSXcvu8mgYtMRxIMj
         tjqCar++xgaYfLYaRy3XdgFwRtpRlR7HYSWpL7hpbcrnKLQ/CT50WIpJ4qwVNNF+zNZc
         UXwNi6d2mNmRLawPvPUm7CP8glqP2G8DYGV8VDXJ3clmTzacXVLkJQNgq1AhzYbkUbhk
         G7dh/PVGzK1sEon1bwZfxl1rMOZ3neP3I9WNi3BrtVhqN5GNfDY+HDZVheLdZIq1uKyx
         Bdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmQroTy0ZSrB9+ytyBw658P0+bfjBqqeFkyQrRlY2fc=;
        b=qxTn1nX6kR3Wgm+JMZcDHVDABxKQLTKXZEcVh3rwgh1hZZr21taeN2Y3QW78sfqGVB
         GYQBm9SWbhqwefKjWS1EG0YjsF/OOyIpBR+KW8cCT1st8YA+jOWx+mmtHuAxZ7TNkr6I
         FuFXwuZOmykWxYFbW7PYmaxGBbqqaeTOSM2lS7vZAvCZkHDHZn8rS/Mn875D443zWC/y
         SkUhxo54d4P/2/UWtGnOOdFrWD2pn1QjUUT3k2TvpLpjZ+q3ov8QmpsqnNV3teAKVLAx
         8z+M/SgzWZHGzvIVbUSjlnSTKBmVm/FfCjDKY2/kJsI1xQLHXFfO8cIdAIOq+LYq31T3
         r4tg==
X-Gm-Message-State: APjAAAVHEbFwCxq4N9Md6g2oe2zz/fR45HylnB6QO1t5vbpe0JubVp99
        3n9QLrI19mJAeU5xA/bMwVqS+Q==
X-Google-Smtp-Source: APXvYqzQ0kK55WM+AUAEgoOeMQBtZwacsLjY81F9irulPCIeYc5srmqzEv2GsM8DeS2tetqh0occ7Q==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr8729559wmh.157.1574419861629;
        Fri, 22 Nov 2019 02:51:01 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:51:01 -0800 (PST)
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
Subject: [RFC 08/13] ACPI/IORT: Add callback to update a device's fwnode
Date:   Fri, 22 Nov 2019 11:49:55 +0100
Message-Id: <20191122105000.800410-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For a PCI-based IOMMU, IORT isn't in charge of allocating a fwnode. Let
the IOMMU driver update the fwnode associated to an IORT node when
available.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/iort.c       | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h |  4 ++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index f08f72d8af78..8263ab275b2b 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -1038,11 +1038,49 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 
 	return ops;
 }
+
+/**
+ * iort_iommu_update_fwnode - update fwnode of a PCI IOMMU
+ * @dev: the IOMMU device
+ * @fwnode: the fwnode, or NULL to remove an existing fwnode
+ *
+ * A PCI device isn't instantiated by the IORT driver. The IOMMU driver sets or
+ * removes its fwnode using this function.
+ */
+void iort_iommu_update_fwnode(struct device *dev, struct fwnode_handle *fwnode)
+{
+	struct pci_dev *pdev;
+	struct iort_fwnode *curr;
+	struct iort_pci_devid *devid;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	pdev = to_pci_dev(dev);
+
+	spin_lock(&iort_fwnode_lock);
+	list_for_each_entry(curr, &iort_fwnode_list, list) {
+		devid = curr->pci_devid;
+		if (devid &&
+		    pci_domain_nr(pdev->bus) == devid->segment &&
+		    pdev->bus->number == devid->bus &&
+		    pdev->devfn == devid->devfn) {
+			WARN_ON(fwnode && curr->fwnode);
+			curr->fwnode = fwnode;
+			break;
+		}
+	}
+	spin_unlock(&iort_fwnode_lock);
+}
+EXPORT_SYMBOL_GPL(iort_iommu_update_fwnode);
 #else
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
+static void iort_iommu_update_fwnode(struct device *dev,
+				     struct fwnode_handle *fwnode)
+{ }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index f4db5fff07cf..840635e40d9d 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -43,6 +43,7 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
+void iort_iommu_update_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 #else
 static void acpi_iort_register_table(struct acpi_table_header *table,
 				     enum iort_table_source source)
@@ -63,6 +64,9 @@ static inline const struct iommu_ops *iort_iommu_configure(
 static inline
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
+static void iort_iommu_update_fwnode(struct device *dev,
+				     struct fwnode_handle *fwnode)
+{ }
 #endif
 
 #endif /* __ACPI_IORT_H__ */
-- 
2.24.0

