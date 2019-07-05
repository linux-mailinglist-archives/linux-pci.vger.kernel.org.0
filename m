Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C789603D6
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfGEKH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:07:29 -0400
Received: from inva020.nxp.com ([92.121.34.13]:32888 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbfGEKH3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 208CB1A0EB7;
        Fri,  5 Jul 2019 12:07:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 939521A0EA8;
        Fri,  5 Jul 2019 12:07:18 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2064A4032F;
        Fri,  5 Jul 2019 18:07:08 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 15/28] PCI: mobiveil: Revise the MEM/IO outbound window initialization
Date:   Fri,  5 Jul 2019 17:56:43 +0800
Message-Id: <20190705095656.19191-16-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the resource type check into a if..else block, and only
set up outbound window for MEM and IO resource. No functional
change.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V6:
 - Splited from #2 of v5 patches, no functional change.

 drivers/pci/controller/pcie-mobiveil.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 906299b..965f89a 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -565,7 +565,7 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 
 static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
-	u32 value, pab_ctrl, type = 0;
+	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
 
 	/* setup bus numbers */
@@ -617,18 +617,18 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &pcie->resources) {
-		type = 0;
 		if (resource_type(win->res) == IORESOURCE_MEM)
 			type = MEM_WINDOW_TYPE;
-		if (resource_type(win->res) == IORESOURCE_IO)
+		else if (resource_type(win->res) == IORESOURCE_IO)
 			type = IO_WINDOW_TYPE;
-		if (type) {
-			/* configure outbound translation window */
-			program_ob_windows(pcie, pcie->ob_wins_configured,
-					   win->res->start,
-					   win->res->start - win->offset,
-					   type, resource_size(win->res));
-		}
+		else
+			continue;
+
+		/* configure outbound translation window */
+		program_ob_windows(pcie, pcie->ob_wins_configured,
+				   win->res->start,
+				   win->res->start - win->offset,
+				   type, resource_size(win->res));
 	}
 
 	/* fixup for PCIe class register */
-- 
1.7.1

