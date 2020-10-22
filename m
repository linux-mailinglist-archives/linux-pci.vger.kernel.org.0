Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA78E2966DA
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 00:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372588AbgJVWAl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 18:00:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41904 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372585AbgJVWAk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 18:00:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id q136so3504299oic.8
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 15:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IoFl3GITcnswlh5OUrkBxbgli8ySiTTs8ZkUeA0TduU=;
        b=SU2AX16/w2NNdXwBOj8q1jHk+1zdC+brGWlZDL4K70Bma5sSDhUWZGiwVmFo0Eq7WQ
         r1no/YCk3vaetcoFYNuTnKzDVUMfABDg16IfZxxhneRSH1x8NgYPAvFS/NlMXSaVtiWi
         Ce9K7k+3fDO7KZMBb2X03LGAtH8TH+/etp3ZZWL1BTrjJa9b04RPcpKmVh4mAlfE4caE
         0hMdYVZdJVy9gZePSqYDBrvoTlahKwCkKJgTz6Ft0L1UABunDooZXUKNeJCrcczPO+SJ
         vgle8F02dH746LwURF0M+7QcFGaGeL16KYi3CgKJWoz4J6JCWN5Mn+iCSqXTSDshBbCE
         xXmA==
X-Gm-Message-State: AOAM532K6zS9FGRaTegAtyyCmnHU7uN2Y22hYu/YT3W9insQLh+4XoPr
        tqsoOalQGwTuH3TMuOLzKg==
X-Google-Smtp-Source: ABdhPJzWFKIlh9P3AEU0+4XryfwxvwvRBAEVW8oU1nMwz3M/OOdyQKqUJAQB3QOsNwILkNSH5JSGKA==
X-Received: by 2002:a05:6808:9a9:: with SMTP id e9mr2789799oig.37.1603404040201;
        Thu, 22 Oct 2020 15:00:40 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a16sm766092otk.39.2020.10.22.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 15:00:39 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     vtolkm@googlemail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: mvebu: Fix duplicate resource requests
Date:   Thu, 22 Oct 2020 17:00:38 -0500
Message-Id: <20201022220038.1339854-1-robh@kernel.org>
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
Untested, please test.

 drivers/pci/controller/pci-mvebu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index c39978b750ec..c6fc8bd5e77f 100644
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
+		ret = devm_request_resource(dev, &iomem_resource, &pcie->realio);
+		if (ret)
+			return ret;
 	}
 
-	return devm_request_pci_bus_resources(dev, &bridge->windows);
+	return 0;
 }
 
 /*
-- 
2.25.1

