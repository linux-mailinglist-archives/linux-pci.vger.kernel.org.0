Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9994D18884A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 15:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCQOzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 10:55:09 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:52838
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727228AbgCQOzI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 10:55:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIFsnR/oSAyllJQ52n1rMHH5zr7v0z7yP6h+UryNp11dIlM8ol7GY1HDTrj8LpeahKPZVX1XmP/73LnRYA1n+RftyWCvKHd0ktIExVL/ZusIEqdL4Gr2pSAkdRwKJVjZUQIoIE3B5vQOsEigRaDNtdjqMzVznTK28D58t/AnoJXdNAf5qsbW3Oj2hcBLLfmsux9erc33oXMhyj14VpmLe0OLY7/ooEf68MoZmgObplydgXQpYa3N9udoz5J7KTSLHO3Sm7msxVpx58Kkk1MUTbXk+O3ROIcyMcozBLtl1TpLyLRPfpeekVDRQUjytdMV39DQHmK2t1YCuwjt+8a0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh7zFP7BOUuaYb1xjZcSU6NEYVfZZ6JyKWOYMVSoqiA=;
 b=imywYZyj8gm4Rs2dXhO/O4EGcdJdWOYvuA7voQCIWiZSyQtddaTmD2mc+LV0lC1cSZd9t16GPxIeBOJH5bOW2WrHx/8G/nXtpOnIehEaJuHV/xgideufIY5A0RNZ1tKrqol9mICo+tESCxgtl/lpKnLYOa5/a0TCALQ2ud69RPvSq+zMfMfcisJ/AXcMbbvP4OUCDLvxA/1PvEJQ9sJid0rMrT6zN0KawJrRnuubUgiM9L5O9R6xzPn6UBxQc5LqX5sVXBs4T9W9eRIAeepmY0ZtFsayM5L5zDgBi0pa48ad2EHnDgbri+eOvC/cz/si+RWmuJibaHDx+uvET5Yu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh7zFP7BOUuaYb1xjZcSU6NEYVfZZ6JyKWOYMVSoqiA=;
 b=J48iYt2odxzrJHwbmV7zMiv3OGEOI55udYSHmX1dLANRxrXogDvc4fOcujnpC6LumRUd2w+u9OptqjFoQHdK5OkpNp9CP8IBYp25E2q17wYEmDGa84B6km1yy6bXDJQxHekRIP24/PFlMVlN8dZh373DtASRDwiktSXL6etLUtQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5931.eurprd04.prod.outlook.com (20.179.11.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Tue, 17 Mar 2020 14:55:03 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e%5]) with mapi id 15.20.2814.016; Tue, 17 Mar 2020
 14:55:03 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] PCI: mobiveil: fix different address space warnings of sparse
Date:   Tue, 17 Mar 2020 22:51:25 +0800
Message-Id: <20200317145125.3682-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0126.apcprd06.prod.outlook.com
 (2603:1096:1:1d::28) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0126.apcprd06.prod.outlook.com (2603:1096:1:1d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 14:55:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e152645a-cc0b-4654-6df4-08d7ca832c52
X-MS-TrafficTypeDiagnostic: DB8PR04MB5931:|DB8PR04MB5931:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5931B1C31496CF619B274EA784F60@DB8PR04MB5931.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(66556008)(66476007)(81166006)(66946007)(8676002)(2906002)(81156014)(36756003)(2616005)(6506007)(6512007)(16526019)(6486002)(5660300002)(69590400007)(478600001)(956004)(316002)(52116002)(6666004)(4326008)(86362001)(8936002)(186003)(26005)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5931;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzYTD064Hg6ZoMzsTD4CpOmoDlZZgbcV5znO0nYRZGTgQWrNV9OtHNfN9PQ9GTTH4sUP8E40PvFvUdOdKQXWAYxqmTpPgsrR+oEKHlsGUwVQN2R2ZsVAQyuQm34deQj5e68umkuuPEBYQ71PzuvScBNMQUYda0ByNzYdPUNkd9/jkS0iql1HVitreuLd7Gs4BfkqUGws2+1QBqY23B3Il8u0A2S62lRqNwQU7BehkYGY6ctHkzknpfsgfwac+yunAXcyRsidjRBe30MilvPpV2rkgFA1m7u6Y/WKXAt4lzVyzW3NZO1f36O01Pe9RSBkCF6etwfpDzenfu8TQiOkSTs4IKGKadaU2AZ3S/RYKp3LthBSPG+pLjfQYOpCHIl1RcFdgLu64M6RIprExajeDPIckgQl/c0RvB7vvzlEiuAspuisPAd9syQkgm30Ei/VPl0keBwtrxrrdfhdBR7Jj2wUzM3vgt/NfbXB6cIajhdEAFf0Eu7P1PkGlcCTD173
X-MS-Exchange-AntiSpam-MessageData: dVcodJ4XOYpecMKtwZE1Dbs+fGvqCldQeJH4/AXOF08K04YJY8pLPraRajoTDGCDyM6I7DADX5AvKWMQfKo88YjvGfJI130HiE7qtpoTUoHSoyfqjUlE1CnJJc4HQWK4t6VrlYl1ZWJCjC4AxlYTWA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e152645a-cc0b-4654-6df4-08d7ca832c52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 14:55:03.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zHQuVI9JpDV/lRM6MBeJtyQ9KFOuimkZfbBfsyGdzCgNWlbkQkk2QVEAP2awhGybh6J4SnqeLh8hs8LoZR2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5931
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Fix the sparse warnings below:

drivers/pci/controller/mobiveil/pcie-mobiveil.c:44:49: warning: incorrect type in return expression (different address spaces)
drivers/pci/controller/mobiveil/pcie-mobiveil.c:44:49:    expected void *
drivers/pci/controller/mobiveil/pcie-mobiveil.c:44:49:    got void [noderef] <asn:2> *
drivers/pci/controller/mobiveil/pcie-mobiveil.c:48:41: warning: incorrect type in return expression (different address spaces)
drivers/pci/controller/mobiveil/pcie-mobiveil.c:48:41:    expected void *
drivers/pci/controller/mobiveil/pcie-mobiveil.c:48:41:    got void [noderef] <asn:2> *
drivers/pci/controller/mobiveil/pcie-mobiveil.c:106:34: warning: incorrect type in argument 1 (different address spaces)
drivers/pci/controller/mobiveil/pcie-mobiveil.c:106:34:    expected void [noderef] <asn:2> *addr
drivers/pci/controller/mobiveil/pcie-mobiveil.c:106:34:    got void *[assigned] addr
drivers/pci/controller/mobiveil/pcie-mobiveil.c:121:35: warning: incorrect type in argument 1 (different address spaces)
drivers/pci/controller/mobiveil/pcie-mobiveil.c:121:35:    expected void [noderef] <asn:2> *addr
drivers/pci/controller/mobiveil/pcie-mobiveil.c:121:35:    got void *[assigned] addr

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/pci/controller/mobiveil/pcie-mobiveil.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
index 23ab904989ea..62ecbaeb0a60 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -36,7 +36,8 @@ static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
 	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
 }
 
-static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
+static void __iomem *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie,
+					     u32 off)
 {
 	if (off < PAGED_ADDR_BNDRY) {
 		/* For directly accessed registers, clear the pg_sel field */
@@ -97,7 +98,7 @@ static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
 
 u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
 {
-	void *addr;
+	void __iomem *addr;
 	u32 val;
 	int ret;
 
@@ -113,7 +114,7 @@ u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
 void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
 			       size_t size)
 {
-	void *addr;
+	void __iomem *addr;
 	int ret;
 
 	addr = mobiveil_pcie_comp_addr(pcie, off);
-- 
2.17.1

