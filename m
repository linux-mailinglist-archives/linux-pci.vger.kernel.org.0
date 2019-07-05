Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227F7603FC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfGEKHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:07:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48276 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbfGEKHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D6EF7200706;
        Fri,  5 Jul 2019 12:07:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 58AED200044;
        Fri,  5 Jul 2019 12:07:21 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4B4D240332;
        Fri,  5 Jul 2019 18:07:11 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 17/28] PCI: mobiveil: Remove an unnecessary return value check
Date:   Fri,  5 Jul 2019 17:56:45 +0800
Message-Id: <20190705095656.19191-18-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The memory of private structure has been allocated together with the
pci_host_bridge structure in function devm_pci_alloc_host_bridge().
So it is unnecessary to check the return value when get the private
structure pointer.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V6:
 - Splited from #3 of v5 patches, no functional change.

 drivers/pci/controller/pcie-mobiveil.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 51cbe53..ddc20d3 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -851,8 +851,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pcie = pci_host_bridge_priv(bridge);
-	if (!pcie)
-		return -ENOMEM;
 
 	pcie->pdev = pdev;
 
-- 
1.7.1

