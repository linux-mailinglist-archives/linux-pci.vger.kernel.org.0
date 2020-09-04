Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FF425DB9F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 16:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgIDO1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 10:27:22 -0400
Received: from foss.arm.com ([217.140.110.172]:51478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbgIDO1R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 10:27:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AD1C1045;
        Fri,  4 Sep 2020 07:27:17 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.6.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1252B3F71F;
        Fri,  4 Sep 2020 07:27:15 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: xilinx-cpm: Remove leftover bridge initialization
Date:   Fri,  4 Sep 2020 15:27:10 +0100
Message-Id: <20200904142710.8018-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some fields in the host bridge structure are now initialized
by default in the PCI/OF core functions therefore their
initialization in the host controller driver is superfluous.

Remove it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index f3082de44e8a..f92e0152e65e 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -572,12 +572,8 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 		goto err_setup_irq;
 	}
 
-	bridge->dev.parent = dev;
 	bridge->sysdata = port->cfg;
-	bridge->busnr = port->cfg->busr.start;
 	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
-	bridge->map_irq = of_irq_parse_and_map_pci;
-	bridge->swizzle_irq = pci_common_swizzle;
 
 	err = pci_host_probe(bridge);
 	if (err < 0)
-- 
2.26.1

