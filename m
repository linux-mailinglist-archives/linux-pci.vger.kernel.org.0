Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30E3DF725
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 23:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhHCV5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 17:57:14 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:46721 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhHCV5N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 17:57:13 -0400
Received: by mail-io1-f48.google.com with SMTP id z7so115596iog.13
        for <linux-pci@vger.kernel.org>; Tue, 03 Aug 2021 14:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f39+ZfEU0MYphAoUTpkKGDjbwcWbmNZrQnSFOfMBoJk=;
        b=Q5ekeYXamYmUPfd+8pak6IcLH3gAHjqP1gxDIKwE2EJvRfBa+WEX61DvdFNz4F16Ys
         F8vTWq8e8El2iSf1Vxd+YfsXPxk7mYNPnlzp+pAyK3paZfFqU3XlOF/7PN7vFeABPNZ5
         /OQyrtZjQr0D1MmfbbOfCOlgmR6ISz1aegnERkd46rd5JHTQHF1N8DMCnF6Xpjf8Lsu8
         Vp8x+KTxY4IqOPyRyTCTfpKsYhZ3prDZus5sWRf4TR375dEdpFLDPMcKk5bETaJQhMZ1
         +pqaapGL42mSHloF8VWe3f3CwF5hHZ1R36HSIriN4JPZQMjFILp/N8FhxZHiJyOb7xIk
         4lZA==
X-Gm-Message-State: AOAM532VfniWUQQ+sdy49Z8WMmRmFab7jUhr7fUfoVG097moaQKq+Lfj
        ha64uIzULsOe0fejQw9oLA==
X-Google-Smtp-Source: ABdhPJwsMB46UwRyJ09qoIRVfqwOT/0rBTT7rHBROQOuQ6FiPVr2P3+Ye/q9vOS3P4P3APACokQ+OA==
X-Received: by 2002:a05:6602:2099:: with SMTP id a25mr449ioa.143.1628027820973;
        Tue, 03 Aug 2021 14:57:00 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id r24sm221635ioa.31.2021.08.03.14.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 14:57:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 2/2] PCI: iproc: Fix BCMA probe resource handling
Date:   Tue,  3 Aug 2021 15:56:56 -0600
Message-Id: <20210803215656.3803204-2-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803215656.3803204-1-robh@kernel.org>
References: <20210803215656.3803204-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In commit 7ef1c871da16 ("PCI: iproc: Use
pci_parse_request_of_pci_ranges()"), calling
devm_request_pci_bus_resources() was dropped from the common iProc
probe code, but is still needed for BCMA bus probing. Without it, there
will be lots of warnings like this:

pci 0000:00:00.0: BAR 8: no space for [mem size 0x00c00000]
pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x00c00000]

Add back calling devm_request_pci_bus_resources() and adding the
resources to pci_host_bridge.windows for BCMA bus probe.

Fixes: 7ef1c871da16 ("PCI: iproc: Use pci_parse_request_of_pci_ranges()")
Reported-by: Rafał Miłecki <zajec5@gmail.com>
Cc: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Roman Bacik <roman.bacik@broadcom.com>
Cc: Bharat Gooty <bharat.gooty@broadcom.com>
Cc: Abhishek Shah <abhishek.shah@broadcom.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: Ray Jui <ray.jui@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-iproc-bcma.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
index 56b8ee7bf330..f918c713afb0 100644
--- a/drivers/pci/controller/pcie-iproc-bcma.c
+++ b/drivers/pci/controller/pcie-iproc-bcma.c
@@ -35,7 +35,6 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 {
 	struct device *dev = &bdev->dev;
 	struct iproc_pcie *pcie;
-	LIST_HEAD(resources);
 	struct pci_host_bridge *bridge;
 	int ret;
 
@@ -60,19 +59,16 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 	pcie->mem.end = bdev->addr_s[0] + SZ_128M - 1;
 	pcie->mem.name = "PCIe MEM space";
 	pcie->mem.flags = IORESOURCE_MEM;
-	pci_add_resource(&resources, &pcie->mem);
+	pci_add_resource(&bridge->windows, &pcie->mem);
+	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
+	if (ret)
+		return ret;
 
 	pcie->map_irq = iproc_pcie_bcma_map_irq;
 
-	ret = iproc_pcie_setup(pcie, &resources);
-	if (ret) {
-		dev_err(dev, "PCIe controller setup failed\n");
-		pci_free_resource_list(&resources);
-		return ret;
-	}
-
 	bcma_set_drvdata(bdev, pcie);
-	return 0;
+
+	return iproc_pcie_setup(pcie, &bridge->windows);
 }
 
 static void iproc_pcie_bcma_remove(struct bcma_device *bdev)
-- 
2.30.2

