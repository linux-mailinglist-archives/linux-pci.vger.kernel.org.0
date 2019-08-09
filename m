Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E490188153
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 19:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407463AbfHIRe7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 13:34:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41678 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406965AbfHIRe7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 13:34:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so95728406wrm.8;
        Fri, 09 Aug 2019 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpRFDf1on/DMyVvQqiGBbziJaXfyqNwbKQZ77YJ1oLc=;
        b=lgVLHcU6t/UANLeBerf4FK6ryhYJO5aWKZ8aCe122Q0ifADXlBFnzZ1fXcuXKMj9GF
         0QJKQKIOXi9ZOaaxYm4LXcxyXd6mNX0hivcAToMdlZr+P1irCH9TLKOXcshKipHQMSe/
         L1vpbs07tRtxKXMG/ZmiFuKJFGaMbNHlEogsrGFlrRG3NoLSsH5WO0FfAMKh7hxgqN7C
         5qXWzvXirYsIdPaVx62ULUzLhCZmrZGZhWa87yihsbwGBWrljZWmG0XsIwK85DlSCcaa
         MM7eXzRgn1Eo2o39/J55w1UHtZ4LlKGbVWcyfLfbTxF0ogDlG71yb3xtFl7DZghlI4gt
         Yslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpRFDf1on/DMyVvQqiGBbziJaXfyqNwbKQZ77YJ1oLc=;
        b=BxyPKRCebn/OPOctU8CC9jMEsSUZM32NVQaOhUemazjWmwSY5544ATQ8lIFW+cbe3o
         VDyAQIvBqvwv+0YfBV8F/kwLhcNjNpfVgOpsjTUHiAlA4P6C/vy7OKCI4Oj7cDxCg/yk
         iRN+VFFw5ijLuHwDkcvWNRQC1VDo660ayYisxX1rrpO2QH3NyE6zyxj7D8maptEyt727
         vujgaGArWexTYIMi4pGqYrhJDN0FaBGl6S7gkmWtn6dnU3FC1guH7mS9DN5O9WWWz9r9
         j+AhiguQLroMXobfhkTVe2M1dLCH9nRJ4OcQY1FgfcE1m0UvsGVtpYZnoqF/VXEmQP24
         LknQ==
X-Gm-Message-State: APjAAAVrNJU94sMKPHIa19jzUngW3M1uriFJY6bRl9d4O8CvkjYxNhdO
        tC6ovU51rCzOxSpHb44/Ggeccv7V
X-Google-Smtp-Source: APXvYqzCHFdzjIRGNYri3asezhWaK9OnJ/tiCIYb0cC9tN16vAdkDywm74TH8sJiwYKlhOKG9gsyZQ==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr394543wrn.184.1565372095591;
        Fri, 09 Aug 2019 10:34:55 -0700 (PDT)
Received: from chi.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id n14sm189127870wra.75.2019.08.09.10.34.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:34:54 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Oza Pawandeep <oza.oza@broadcom.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] OF/PCI: Export inbound memory interface to PCI RC drivers.
Date:   Fri,  9 Aug 2019 19:34:48 +0200
Message-Id: <20190809173449.20126-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Oza Pawandeep <oza.oza@broadcom.com>

The patch exports interface to PCIe RC drivers so that,
Drivers can get their inbound memory configuration.

It provides basis for IOVA reservations for inbound memory
holes, if RC is not capable of addressing all the host memory,
Specifically when IOMMU is enabled and on ARMv8 where 64bit IOVA
could be allocated.

It handles multiple inbound windows, and returns resources,
and is left to the caller, how it wants to use them.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
 drivers/pci/of.c       | 96 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_pci.h |  7 +++
 2 files changed, 103 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index bc7b27a28795..4018f1a26f6f 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -347,6 +347,102 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
+
+/**
+ * of_pci_get_dma_ranges - Parse PCI host bridge inbound resources from DT
+ * @np: device node of the host bridge having the dma-ranges property
+ * @resources: list where the range of resources will be added after DT parsing
+ *
+ * It is the caller's job to free the @resources list.
+ *
+ * This function will parse the "dma-ranges" property of a
+ * PCI host bridge device node and setup the resource mapping based
+ * on its content.
+ *
+ * It returns zero if the range parsing has been successful or a standard error
+ * value if it failed.
+ */
+
+int of_pci_get_dma_ranges(struct device_node *dn, struct list_head *resources)
+{
+	struct device_node *node = of_node_get(dn);
+	int rlen;
+	int pna = of_n_addr_cells(node);
+	const int na = 3, ns = 2;
+	int np = pna + na + ns;
+	int ret = 0;
+	struct resource *res;
+	const u32 *dma_ranges;
+	struct of_pci_range range;
+
+	if (!node)
+		return -EINVAL;
+
+	while (1) {
+		dma_ranges = of_get_property(node, "dma-ranges", &rlen);
+
+		/* Ignore empty ranges, they imply no translation required. */
+		if (dma_ranges && rlen > 0)
+			break;
+
+		/* no dma-ranges, they imply no translation required. */
+		if (!dma_ranges)
+			break;
+
+		node = of_get_next_parent(node);
+
+		if (!node)
+			break;
+	}
+
+	if (!dma_ranges) {
+		pr_debug("pcie device has no dma-ranges defined for node(%s)\n",
+			  dn->full_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	while ((rlen -= np * 4) >= 0) {
+		range.pci_space = be32_to_cpup((const __be32 *) &dma_ranges[0]);
+		range.pci_addr = of_read_number(dma_ranges + 1, ns);
+		range.cpu_addr = of_translate_dma_address(node,
+							dma_ranges + na);
+		range.size = of_read_number(dma_ranges + pna + na, ns);
+		range.flags = IORESOURCE_MEM;
+
+		dma_ranges += np;
+
+		/*
+		 * If we failed translation or got a zero-sized region
+		 * then skip this range.
+		 */
+		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
+			continue;
+
+		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+		if (!res) {
+			ret = -ENOMEM;
+			goto parse_failed;
+		}
+
+		ret = of_pci_range_to_resource(&range, dn, res);
+		if (ret) {
+			kfree(res);
+			continue;
+		}
+
+		pci_add_resource_offset(resources, res,
+					res->start - range.pci_addr);
+	}
+	return ret;
+
+parse_failed:
+	pci_free_resource_list(resources);
+out:
+	of_node_put(node);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_dma_ranges);
 #endif /* CONFIG_OF_ADDRESS */
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 21a89c4880fa..02bff0587dd2 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -13,6 +13,7 @@ struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
+int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources);
 void of_pci_check_probe_only(void);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
@@ -26,6 +27,12 @@ static inline int of_pci_get_devfn(struct device_node *np)
 	return -EINVAL;
 }
 
+static inline int of_pci_get_dma_ranges(struct device_node *np,
+					struct list_head *resources)
+{
+	return -EINVAL;
+}
+
 static inline void of_pci_check_probe_only(void) { }
 #endif
 
-- 
2.20.1

