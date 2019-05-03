Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D564912FC5
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 16:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfECOGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 10:06:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38206 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfECOGH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 10:06:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so6148888edl.5
        for <linux-pci@vger.kernel.org>; Fri, 03 May 2019 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDG9A8vcxSWTc3lAhtot1/d3GbhCCecRqw2WbSyKudk=;
        b=feHZTD51V3Kr5/f8uHGsEm9lvHVjGVHfGjgwWhBBXg8KQhQyWaTT5ocm2pxvOmaA/U
         NHOymXRcp5B4BsHyh/B+1ypKS+hMZQKRMWS54BDSZVMwYYsObRy83TR+APQNE+A7fpTO
         V42S20HGilmypBW2HZg6GJD9e9LMG8JhGKKGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDG9A8vcxSWTc3lAhtot1/d3GbhCCecRqw2WbSyKudk=;
        b=j3czcwgN4RpOYkhjsyZXKYEvrGLtd/C6NK+VDFZCFOxZ1nOlkPy6oskvMZPL4MQWHT
         naDjF93ysSAEjQ2HHCAc1fSUMVsxB5mY3QIRPQsyvdZ1W2QO4kBC4eeUfERk+nhxvF1S
         cXmlJKAVIuCxqK4tBH4Wow3y2g1lA+721Z5bpia4jGPHaobGDqLZHXaQST9MGAZjSNKH
         6Z0ax5dKu4K95YHz9w4Y1AIIxVKwx5z1O4r0g3Fhgms5HuKs6Jo9psQEzn+BXx6DrG52
         F3mNISUiATW0MOoPR6Uxev20xBJUNUsFTml7iy0w/7ItEfrb/+4vUZieQX3lxo9o/GP9
         4bNA==
X-Gm-Message-State: APjAAAWnzCJ7tbQdmLZmV615L/lhT5AMWo8ZSCLSfvjLTaIvKe1C3EtI
        7nYJNlTo7+w9OhLZCp7CJDNP6w==
X-Google-Smtp-Source: APXvYqxdUNO4AAjiICo5DT6ucVOjhvprFFm/2BtoKIfgOXzHwJyKhWHar6DRBfmM7Rt0E3BQHIA7OQ==
X-Received: by 2002:a50:b835:: with SMTP id j50mr8464031ede.63.1556892366022;
        Fri, 03 May 2019 07:06:06 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s53sm605472edb.20.2019.05.03.07.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 May 2019 07:06:05 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
Date:   Fri,  3 May 2019 19:35:33 +0530
Message-Id: <1556892334-16270-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dma_ranges list field of PCI host bridge structure has resource
entries in sorted order representing address ranges allowed for DMA
transfers.

Process the list and reserve IOVA addresses that are not present in its
resource entries (ie DMA memory holes) to prevent allocating IOVA
addresses that cannot be accessed by PCI devices.

Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77aabe6..954ae11 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -206,12 +206,13 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 	return 0;
 }
 
-static void iova_reserve_pci_windows(struct pci_dev *dev,
+static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 	struct resource_entry *window;
 	unsigned long lo, hi;
+	phys_addr_t start = 0, end;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM)
@@ -221,6 +222,31 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* Get reserved DMA windows from host bridge */
+	resource_list_for_each_entry(window, &bridge->dma_ranges) {
+		end = window->res->start - window->offset;
+resv_iova:
+		if (end > start) {
+			lo = iova_pfn(iovad, start);
+			hi = iova_pfn(iovad, end);
+			reserve_iova(iovad, lo, hi);
+		} else {
+			/* dma_ranges list should be sorted */
+			dev_err(&dev->dev, "Failed to reserve IOVA\n");
+			return -EINVAL;
+		}
+
+		start = window->res->end - window->offset + 1;
+		/* If window is last entry */
+		if (window->node.next == &bridge->dma_ranges &&
+		    end != ~(dma_addr_t)0) {
+			end = ~(dma_addr_t)0;
+			goto resv_iova;
+		}
+	}
+
+	return 0;
 }
 
 static int iova_reserve_iommu_regions(struct device *dev,
@@ -232,8 +258,11 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	LIST_HEAD(resv_regions);
 	int ret = 0;
 
-	if (dev_is_pci(dev))
-		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+	if (dev_is_pci(dev)) {
+		ret = iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+		if (ret)
+			return ret;
+	}
 
 	iommu_get_resv_regions(dev, &resv_regions);
 	list_for_each_entry(region, &resv_regions, list) {
-- 
2.7.4

