Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B85B603F8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfGEKHa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:07:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:32932 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbfGEKHa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 72D771A077B;
        Fri,  5 Jul 2019 12:07:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E9F5B1A0EB9;
        Fri,  5 Jul 2019 12:07:19 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B0AA7402EB;
        Fri,  5 Jul 2019 18:07:09 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 16/28] PCI: mobiveil: Fix the returned error number
Date:   Fri,  5 Jul 2019 17:56:44 +0800
Message-Id: <20190705095656.19191-17-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch modified the returned error number by convention.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V6:
 - Splited from #3 of v5 patches, no functional change.

 drivers/pci/controller/pcie-mobiveil.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 965f89a..51cbe53 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -822,7 +822,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 
 	if (!pcie->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
 
 	raw_spin_lock_init(&pcie->intx_mask_lock);
@@ -848,7 +848,7 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	/* allocate the PCIe port */
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
-		return -ENODEV;
+		return -ENOMEM;
 
 	pcie = pci_host_bridge_priv(bridge);
 	if (!pcie)
@@ -869,7 +869,7 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 						    &pcie->resources, &iobase);
 	if (ret) {
 		dev_err(dev, "Getting bridge resources failed\n");
-		return -ENOMEM;
+		return ret;
 	}
 
 	/*
-- 
1.7.1

