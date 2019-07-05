Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6B603DA
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfGEKHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:07:41 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48378 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbfGEKHf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:35 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B444D200044;
        Fri,  5 Jul 2019 12:07:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 35BAC2006F8;
        Fri,  5 Jul 2019 12:07:25 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7C75D4030E;
        Fri,  5 Jul 2019 18:07:14 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 19/28] PCI: mobiveil: Fix the valid check for inbound and outbound window
Date:   Fri,  5 Jul 2019 17:56:47 +0800
Message-Id: <20190705095656.19191-20-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Check window index from the parameter instead of the total
number of initialized windows to determine if the specified
window is valid.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V6:
 - Splited from #9 of v5 patches, no functional change.

 drivers/pci/controller/pcie-mobiveil.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index ccf9bb1..76653d9 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -458,7 +458,7 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
 	u32 value;
 	u64 size64 = ~(size - 1);
 
-	if ((pcie->ib_wins_configured + 1) > pcie->ppio_wins) {
+	if (win_num >= pcie->ppio_wins) {
 		dev_err(&pcie->pdev->dev,
 			"ERROR: max inbound windows reached !\n");
 		return;
@@ -491,7 +491,7 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
 {
 	u64 size64 = ~(size - 1);
 
-	if ((pcie->ob_wins_configured + 1) > pcie->apio_wins) {
+	if (win_num >= pcie->apio_wins) {
 		dev_err(&pcie->pdev->dev,
 			"ERROR: max outbound windows reached !\n");
 		return;
-- 
1.7.1

