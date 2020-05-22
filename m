Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDDB1DF335
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbgEVXsr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:47 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40029 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgEVXsq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:46 -0400
Received: by mail-il1-f195.google.com with SMTP id m6so12482789ilq.7
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6AdS/TZXzVwZhaj3XeZ8pHwXrcTg21qPzTXuwbZXTY=;
        b=N/AvX3Ocm6Lk+CwzFRSPwCMUOreBCus+qc+CBAjqbDC2D5XMHciTmd6vVl7xImp7qM
         EWUEwLVycln6xDL7fWdwKR8eIJmYLFTv6j/CUU67IgTcG3dGc7it8A4MBhH1VlkcITTm
         BzsYOkeX0kejJBBPsIneaVCC9X4bV5oSjjDjcq5Hd1nO0h+kQIKZGF54oqnjt58E8mk0
         CDacpUiT5Ihfbw1OTSdl+vXCGKNLeekqF/VXmnmPaodCIzXkrA0uw4n7A3vyxs/eCg9c
         utMf3TeoHvpvs8WhZ+RHNbMOmQZAXM3WQuRm7VgIRUcUpHRX/7j95zIyWc07Z52q82Zh
         QJYA==
X-Gm-Message-State: AOAM531ItKvgbu+m2lfs0cP/m/NOeHmS5G+Tqgb7F9D9Rq4uu94SXmx/
        5tXC5aoH8i7n1QPdHWk8Yw==
X-Google-Smtp-Source: ABdhPJx+ueXcTjl20AOza8BrHvDbmua+rc9aHmFgQKv5RD1ZcW5dKvkYfx+vLS94kC3TUkSvYVHV9w==
X-Received: by 2002:a92:aa53:: with SMTP id j80mr15676503ili.299.1590191325856;
        Fri, 22 May 2020 16:48:45 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:45 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 11/15] PCI: iproc: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:28 -0600
Message-Id: <20200522234832.954484-12-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The iproc host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

The only difference is pci_assign_unassigned_bus_resources() was called
instead of pci_bus_size_bridges() and pci_bus_assign_resources(). This
should be the same.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-iproc.c | 18 +++++-------------
 drivers/pci/controller/pcie-iproc.h |  2 --
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 8c7f875acf7f..232fca0754e1 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1470,7 +1470,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 {
 	struct device *dev;
 	int ret;
-	struct pci_bus *child;
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 
 	dev = pcie->dev;
@@ -1531,21 +1530,12 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	host->map_irq = pcie->map_irq;
 	host->swizzle_irq = pci_common_swizzle;
 
-	ret = pci_scan_root_bus_bridge(host);
+	ret = pci_host_probe(host);
 	if (ret < 0) {
 		dev_err(dev, "failed to scan host: %d\n", ret);
 		goto err_power_off_phy;
 	}
 
-	pci_assign_unassigned_bus_resources(host->bus);
-
-	pcie->root_bus = host->bus;
-
-	list_for_each_entry(child, &host->bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(host->bus);
-
 	return 0;
 
 err_power_off_phy:
@@ -1558,8 +1548,10 @@ EXPORT_SYMBOL(iproc_pcie_setup);
 
 int iproc_pcie_remove(struct iproc_pcie *pcie)
 {
-	pci_stop_root_bus(pcie->root_bus);
-	pci_remove_root_bus(pcie->root_bus);
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+
+	pci_stop_root_bus(host->bus);
+	pci_remove_root_bus(host->bus);
 
 	iproc_pcie_msi_disable(pcie);
 
diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
index 4f03ea539805..c2676e442f55 100644
--- a/drivers/pci/controller/pcie-iproc.h
+++ b/drivers/pci/controller/pcie-iproc.h
@@ -54,7 +54,6 @@ struct iproc_msi;
  * @reg_offsets: register offsets
  * @base: PCIe host controller I/O register base
  * @base_addr: PCIe host controller register base physical address
- * @root_bus: pointer to root bus
  * @phy: optional PHY device that controls the Serdes
  * @map_irq: function callback to map interrupts
  * @ep_is_internal: indicates an internal emulated endpoint device is connected
@@ -85,7 +84,6 @@ struct iproc_pcie {
 	void __iomem *base;
 	phys_addr_t base_addr;
 	struct resource mem;
-	struct pci_bus *root_bus;
 	struct phy *phy;
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	bool ep_is_internal;
-- 
2.25.1

