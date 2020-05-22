Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAD71DF32B
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgEVXsh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46654 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbgEVXsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:37 -0400
Received: by mail-io1-f67.google.com with SMTP id j8so13282482iog.13
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4+faHiQpbiKoNArdRYrYzpj6r3I7BpUrWFS3s8f/VI=;
        b=Y7dAEsH8KoK2WqBd756PciJPvnhcCKAjKPaTDqxkJaMmm4p7cFqXmll1jVZbmhbGeD
         4YGxhvVFXn9dW7LB6o1ix3k0onSZE/CgT5Jh7fL4nQTnDHUIUa72zMWAd6xSpR7vQ88R
         u3tgSrRENpaLAiJcXyp5I7sU9WJc+ZEkzrnL7H5tJZ96kn7qG8fdn0mz/efYH1D59x54
         zTNt3t/ACjyZALU+Mb2RocyIC+8ems6stZTgNiyyjGp5cCVnZOrTfPn2kqQFMhTs14vv
         uyA9tnlDXlgsrjEDXV3qxGDl+6cQSUgf6ZaGdr4C7x21SbLAa3vZXZIxhLTiH959wqQI
         YMjw==
X-Gm-Message-State: AOAM531FQGWptoCwa0UzmSd34HqnQl1p7xS82owrelkf20w4iBf8IDq+
        3SAVDRdD7/ZZzFhq2b7JOw==
X-Google-Smtp-Source: ABdhPJzN5mP6wcYyIO0prwZR7WJYYh7QphTWx1pZw96CB3uHi1bA3huv1VVkQoA0SVgvDeTWo4nM+g==
X-Received: by 2002:a6b:5813:: with SMTP id m19mr5015868iob.88.1590191316081;
        Fri, 22 May 2020 16:48:36 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 02/15] PCI: mvebu: Use struct pci_host_bridge.windows list directly
Date:   Fri, 22 May 2020 17:48:19 -0600
Message-Id: <20200522234832.954484-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's no need to create a temporary resource list and then splice it to
struct pci_host_bridge.windows list. Just use pci_host_bridge.windows
directly. The necessary clean-up is already handled by the PCI core.

Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 153a64676bc9..801044523a3d 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -71,7 +71,6 @@ struct mvebu_pcie {
 	struct platform_device *pdev;
 	struct mvebu_pcie_port *ports;
 	struct msi_controller *msi;
-	struct list_head resources;
 	struct resource io;
 	struct resource realio;
 	struct resource mem;
@@ -961,17 +960,16 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	int ret;
 
-	INIT_LIST_HEAD(&pcie->resources);
-
 	/* Get the bus range */
 	ret = of_pci_parse_bus_range(np, &pcie->busn);
 	if (ret) {
 		dev_err(dev, "failed to parse bus-range property: %d\n", ret);
 		return ret;
 	}
-	pci_add_resource(&pcie->resources, &pcie->busn);
+	pci_add_resource(&bridge->windows, &pcie->busn);
 
 	/* Get the PCIe memory aperture */
 	mvebu_mbus_get_pcie_mem_aperture(&pcie->mem);
@@ -981,7 +979,7 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 	}
 
 	pcie->mem.name = "PCI MEM";
-	pci_add_resource(&pcie->resources, &pcie->mem);
+	pci_add_resource(&bridge->windows, &pcie->mem);
 
 	/* Get the PCIe IO aperture */
 	mvebu_mbus_get_pcie_io_aperture(&pcie->io);
@@ -994,10 +992,10 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 					 resource_size(&pcie->io) - 1);
 		pcie->realio.name = "PCI I/O";
 
-		pci_add_resource(&pcie->resources, &pcie->realio);
+		pci_add_resource(&bridge->windows, &pcie->realio);
 	}
 
-	return devm_request_pci_bus_resources(dev, &pcie->resources);
+	return devm_request_pci_bus_resources(dev, &bridge->windows);
 }
 
 /*
@@ -1118,7 +1116,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	pcie->nports = i;
 
-	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = pcie;
 	bridge->busnr = 0;
-- 
2.25.1

