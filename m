Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4412971BD
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460749AbgJWOwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 10:52:55 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:38241 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460728AbgJWOwy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 10:52:54 -0400
Received: by mail-oo1-f68.google.com with SMTP id v123so444526ooa.5
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 07:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kOZmGTPLSRVmyf8XY0nbCHbr6Vmsy9fem3E9vULmHU=;
        b=RK7soIYRtwYQx3hlzSL0R5oT90RHzF5pT5ptK5Zcs4EIKLulDp7ayZZQYNiqdZGJZt
         fmG+Kl470Pxl57LMrIr04Y73XR/L8MZLwa+iQ2+nau5A1K0JMoArWtsh4gNXQGRMb3E+
         9LKpLi0jh9hXXbRxO1Un6vYpdiT7Tzsx2ttha0jVxrq0mWtCOc3+8ADkkyu6I7YFvun8
         FTljRIji1ylhlY5uws/MYD9pls7yyFhvsmX9lD5TxmGhCO5EfcV3nrDCK1zLlbDtXtky
         0kcnrLPpp9HhoCbvxXv79SBof1tO68dhjQeLBMf6N6EpkfcDkaL3c7baKlgeUkCcm/aJ
         L6Nw==
X-Gm-Message-State: AOAM532QPVeu77ZnBwz0rHFhJHpc2gWkNsop2QYv//H8VEX04AFz5LrU
        joAvE6G9MekhaFDWGMYqcg==
X-Google-Smtp-Source: ABdhPJzBPjDe/Y0t5lciIvOwGDkq0FSwVmL1F96deGOJx+Do1u3lcK6m/HOwGtUYBZKEXeL2Lq2a0A==
X-Received: by 2002:a4a:c68d:: with SMTP id m13mr1948257ooq.64.1603464773854;
        Fri, 23 Oct 2020 07:52:53 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id v21sm423533oto.65.2020.10.23.07.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:52:53 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     vtolkm@googlemail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] PCI: mvebu: Fix duplicate resource requests
Date:   Fri, 23 Oct 2020 09:52:52 -0500
Message-Id: <20201023145252.2691779-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With commit 669cbc708122 ("PCI: Move DT resource setup into
devm_pci_alloc_host_bridge()"), the DT 'ranges' is parsed and populated
into resources when the host bridge is allocated. The resources are
requested as well, but that happens a 2nd time for the mvebu driver in
mvebu_pcie_parse_request_resources(). We should only be requesting the
additional resources added in mvebu_pcie_parse_request_resources().
These are not added by default because the use custom properties rather
than standard DT address translation.

Also, the bus ranges was also populated by default, so we can remove
it from mvebu_pci_host_probe().

Fixes: 669cbc708122 ("PCI: Move DT resource setup into devm_pci_alloc_host_bridge()")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209729
Reported-by: vtolkm@googlemail.com
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix copy-n-paste error with ioport_resource
---
 drivers/pci/controller/pci-mvebu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index c39978b750ec..653c0b3d2912 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -960,25 +960,16 @@ static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
 }
 
 /*
- * We can't use devm_of_pci_get_host_bridge_resources() because we
- * need to parse our special DT properties encoding the MEM and IO
- * apertures.
+ * devm_of_pci_get_host_bridge_resources() only sets up translateable resources,
+ * so we need extra resource setup parsing our special DT properties encoding
+ * the MEM and IO apertures.
  */
 static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	int ret;
 
-	/* Get the bus range */
-	ret = of_pci_parse_bus_range(np, &pcie->busn);
-	if (ret) {
-		dev_err(dev, "failed to parse bus-range property: %d\n", ret);
-		return ret;
-	}
-	pci_add_resource(&bridge->windows, &pcie->busn);
-
 	/* Get the PCIe memory aperture */
 	mvebu_mbus_get_pcie_mem_aperture(&pcie->mem);
 	if (resource_size(&pcie->mem) == 0) {
@@ -988,6 +979,9 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 
 	pcie->mem.name = "PCI MEM";
 	pci_add_resource(&bridge->windows, &pcie->mem);
+	ret = devm_request_resource(dev, &iomem_resource, &pcie->mem);
+	if (ret)
+		return ret;
 
 	/* Get the PCIe IO aperture */
 	mvebu_mbus_get_pcie_io_aperture(&pcie->io);
@@ -1001,9 +995,12 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 		pcie->realio.name = "PCI I/O";
 
 		pci_add_resource(&bridge->windows, &pcie->realio);
+		ret = devm_request_resource(dev, &ioport_resource, &pcie->realio);
+		if (ret)
+			return ret;
 	}
 
-	return devm_request_pci_bus_resources(dev, &bridge->windows);
+	return 0;
 }
 
 /*
-- 
2.25.1

