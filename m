Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF312FC7
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 16:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfECOGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 10:06:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36771 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfECOGO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 10:06:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so6164132edx.3
        for <linux-pci@vger.kernel.org>; Fri, 03 May 2019 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r4u5O1ZVpfa/NoghF2cTBMxxDl8TKg0sIE8liHJFO9Q=;
        b=ccHpnw/RpgY9kfcH8RVxE+1twK6DE6BPB8HepDw/YqeUPaWmmuQTQ4r/xZPcJ/HS2V
         yXYeLA69ocApJMHE1Lo10gkLx3ejJJ/TPlFxpB0OKRuiXQiNxttte3sdqbpsugKPw1Mp
         jG8eBraDllvceAFhJZ8smmSPHz+e8XhEVxMWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r4u5O1ZVpfa/NoghF2cTBMxxDl8TKg0sIE8liHJFO9Q=;
        b=Ufw0iPY7HmuIJRk4hYoaJXA3AvXTT2jqQ59OUbhfe2oa3zkbgPu7V9zY4EtZvGVwkD
         duyu9956ce0ZfkCysRgaqIyr/qgWDwH0mLitfgEu8I+MDeHOxCY4AYVFZBS7pDYEN6in
         czEbYxUutp5n5X2SO5lEp5nFLwBMBViGRvMBH5ywdhMEq0wSnxiPdqEeLTEbVzsmkbXN
         rIPsHPeBYOyY9ionnT6wIKBjhYZs/uUjtDRWUkNwp+6W9ILmxGwVNmOi/28snZZXWCGq
         kaXS6mxY2j3vf+iBS38tkPRULEivITxI8WVCzUIjTYOAxyLRL3zJs4E5QP0YWyK3HFtr
         fbPw==
X-Gm-Message-State: APjAAAX7TlWL5nArVLaoGqxUzxDKayNtb7p/MNElyd+gWmSfLNiSC8yn
        yJYAP3f9XgIJBIdo+zHk+EoRUA==
X-Google-Smtp-Source: APXvYqxyH2lm/fogXtpK3bsS+Au0kvjIwuk8eQfhakM9r2dOKPKR+UFhrZ/qW0kZyOaxJakoZDInag==
X-Received: by 2002:a17:906:2282:: with SMTP id p2mr6344456eja.283.1556892372220;
        Fri, 03 May 2019 07:06:12 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s53sm605472edb.20.2019.05.03.07.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 May 2019 07:06:11 -0700 (PDT)
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
Subject: [PATCH v6 3/3] PCI: iproc: Add sorted dma ranges resource entries to host bridge
Date:   Fri,  3 May 2019 19:35:34 +0530
Message-Id: <1556892334-16270-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The IPROC host controller allows only a subset of physical address space
as target of inbound PCI memory transactions addresses.

PCIe devices memory transactions targeting memory regions that
are not allowed for inbound transactions in the host controller
are rejected by the host controller and cannot reach the upstream
buses.

Firmware device tree description defines the DMA ranges that are
addressable by devices DMA transactions; parse the device tree
dma-ranges property and add its ranges to the PCI host bridge dma_ranges
list; the iova_reserve_pci_windows() call in the driver will reserve the
IOVA address ranges that are not addressable (ie memory holes in the
dma-ranges set) so that they are not allocated to PCI devices for DMA
transfers.

All allowed address ranges are listed in dma-ranges DT parameter.

Example:

dma-ranges = < \
  0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
  0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
  0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>

In the above example of dma-ranges, memory address from

0x0 - 0x80000000,
0x100000000 - 0x800000000,
0x1000000000 - 0x8000000000 and
0x10000000000 - 0xffffffffffffffff.

are not allowed to be used as inbound addresses.

Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6b..94ba5c0 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1146,11 +1146,43 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
 	return ret;
 }
 
+static int
+iproc_pcie_add_dma_range(struct device *dev, struct list_head *resources,
+			 struct of_pci_range *range)
+{
+	struct resource *res;
+	struct resource_entry *entry, *tmp;
+	struct list_head *head = resources;
+
+	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	resource_list_for_each_entry(tmp, resources) {
+		if (tmp->res->start < range->cpu_addr)
+			head = &tmp->node;
+	}
+
+	res->start = range->cpu_addr;
+	res->end = res->start + range->size - 1;
+
+	entry = resource_list_create_entry(res, 0);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->offset = res->start - range->cpu_addr;
+	resource_list_add(entry, head);
+
+	return 0;
+}
+
 static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 {
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	int ret;
+	LIST_HEAD(resources);
 
 	/* Get the dma-ranges from DT */
 	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
@@ -1158,13 +1190,23 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 		return ret;
 
 	for_each_of_pci_range(&parser, &range) {
+		ret = iproc_pcie_add_dma_range(pcie->dev,
+					       &resources,
+					       &range);
+		if (ret)
+			goto out;
 		/* Each range entry corresponds to an inbound mapping region */
 		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
+	list_splice_init(&resources, &host->dma_ranges);
+
 	return 0;
+out:
+	pci_free_resource_list(&resources);
+	return ret;
 }
 
 static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
-- 
2.7.4

