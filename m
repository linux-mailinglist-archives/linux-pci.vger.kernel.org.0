Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE576A74E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 05:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjHADGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 23:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHADG3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 23:06:29 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE81981;
        Mon, 31 Jul 2023 20:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsf23220s/SMmPHUDhp8z/ksNnF5sNNyBBVsVROLAU0DX/TH4yABqW0g63CgbfpI5zxJzgc3hYULlJf3GDWtdeGJ8HvkfnTmN/L6h0pOMMo93anOxxsrT/ImRWvVAS1KcEhZ+DgKyHm8BbR2sJC3Bsm1eap9UaTjJ2zwSd5BvH5JXT3D9WTcf/ITjK6SJr7wGW6Awm/hpVggYE6FBuy0TM9/tlk3shZ0fvyF8Y7/fzGNFwlqWE0zx1dTip4d9daQGx3IElwgGV7o0fmSo/NLBgm9uOuoQNpi1adExIksR/vftYzBDlaF+S9VCM8bf2ua4/fA21QrPJNECZ2oCsdKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLlTVY9beN+n89Vm/NX3+CULy2FLLN2//sNLZgMO1KA=;
 b=erBj6EfVHwD5nM1UqB94l/iEzkWBS1nDJr/bMUK19tmZx27U8fUeejvL4t8TKRN6rkRzLfUHnjWNCuoPnmM1L3gXqNdBl313E0KuzAO6GMpQvM1Ik9HdpM8NGW2jlNIBu7r38bMHKXlepCDqAdytjgykoKk5TC8Ktb8P90G5CUngVNLCm0kxlpB2L3tdn0mwpY1Qhi49hEh5KpY/q01V1WtDqGXkLTvnlhG4gUj1mHuQHTrX/1OT3K4v8e+Ob41o3hMW5e4AyV8VoEV5M9kgl3GzgFJbMuj5QIE01TzjY9XI9Bawd0Jwbd4Y3S2PlWrL6nm7pTGILRCyhtYJ11vaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLlTVY9beN+n89Vm/NX3+CULy2FLLN2//sNLZgMO1KA=;
 b=CxqfoJNGAkQhhS5Yi8RfyMG2Dx/BjToKGWF2NlaxN0KdoMHhnimxMYY9oVr1RVzFBWQ3FmAhHwoCZOM1b5oxV9/vt/YDkC1mXADc6BxHQd2YoAQouqEH2fcyf4CeUzHVvESGu0n2WWVhUwXYuDmFiuzceR/VBJ9UMDnG7hek/m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by DBAPR04MB7272.eurprd04.prod.outlook.com (2603:10a6:10:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 03:06:25 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::2dbf:8d49:6daa:dda]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::2dbf:8d49:6daa:dda%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 03:06:25 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jindong.yue@nxp.com
Subject: [PATCH v2] PCI: imx6: Support building it as a module
Date:   Tue,  1 Aug 2023 11:13:14 +0800
Message-Id: <20230801031314.3820228-1-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|DBAPR04MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5dc36a-c6d4-4128-fa3d-08db923c4a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qL4a1d96DjYQhvIMXsmOTbrYKXI9HibRLTiRsi1q16sCEAV4Yy72qyC1cz6r6pb7JwuhO4dbDwkwfuBxQkFmf7aMT5DLxIiPG3QGu+pBIHulfCo8TGgbjl8M4vXe59zvGKPT1rigUS2KTlfvwpZZ+EsSkkofEwncoGWtW16uxb8XIldMfILwlk7IQwoaBjsZgMP/ipM2wVIAgNwYuBpyZqsZKjIIqQMeO7f986Zg5pgKFjnkh+VRlTgiLdlyg8lrinW6YjBTtKSRXQHvFEe9KLS+H/rRjs7wEnAjL2yxJ94X23AUt1Ngw0WZ8XLhNpzOs+0uZ6n4XTQZ9pU3SbCi057+RpfPFPE3IMI2HLYfahTLoMDq31KQqcuAN7VScN80wRTXyIQoyd6oTHM/6uRJpqpPnTLZdWLik6xLvB1vYpUoUIoVRdAussnHwzTcuoS3zDHdYGMKgitsBzXCw5CeGEkoBCUxBmRM4IM516374PzqLmTLauPnx8EG6yEvAg5lfJD20l4UvuhgzhemVEnzxqjVyRnE0U9Mfnop+jsgJSPYC9P3lX2LB7nJwb8WIAftDEd2jA97E2/Q7unnAHNfBN80MaCYu2Yl0+Mg3k5ngbjuv8RN9Uu7DBUV60YuOq2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(44832011)(6512007)(6486002)(52116002)(36756003)(2616005)(6506007)(26005)(1076003)(83380400001)(186003)(66946007)(66556008)(41300700001)(38350700002)(38100700002)(86362001)(66476007)(316002)(5660300002)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z4rLoU3QovMN2vCX3CcuANT3KG9oaUagWMLHdhfcG1o7vn3KzK9Ynyj9QF3D?=
 =?us-ascii?Q?aYy0pT/zFnm0RdqgsN+Xo5gBWmspDnGhZFRW60MHqmQ7Mktsp+MOXgaBaacM?=
 =?us-ascii?Q?QveW4xgu/c5FrR59f8xco2Qgr0HT1aByhqUKYvW+ioEmo+0rSeMBfUkPXo7c?=
 =?us-ascii?Q?iayy7bHEWqDx3SfpLJdbZvBKHABbS8oyqdKeNxScPBP4yKMWPaCzhplsi/CG?=
 =?us-ascii?Q?3KIH6BTZmnvpD1pPuHsPgV8/D0E5IKsCboGqnoKlSAxqnxSe7QunLurzwU3G?=
 =?us-ascii?Q?xDGevm7L6wNGhIY1r0MdDxactWMMOAy8EWop2M444BHYCItzqj17dz8rrTx0?=
 =?us-ascii?Q?5FRDRWJbqAOzDKvHgFLBlLu24texNhYGAYyh99rydEwOlLHp5sMhesquiDhQ?=
 =?us-ascii?Q?vWACNosM6dxEXAv4a8dAeDfUMilTJier3y/GY2Aq45iRjCV4p4UD85ACGEgV?=
 =?us-ascii?Q?52B0tDOCPCQ8i2T+iHqNyl7dW5BhzVeDlxDOZp5A9ikL0nUgY/eGG0BDBxfZ?=
 =?us-ascii?Q?vyDjEoLjO/8/eYb/fX9mfOqMo2qZmfjTS4cTluO5cOLKXILVS5F8fUvWSvPG?=
 =?us-ascii?Q?5QftnSIqMfaYci63Daz/xaH3Vp8wpSvvfCKD5DsjfCTs50DiJ0ZBW4pyvaCP?=
 =?us-ascii?Q?OzCezmyczoBxK5C+m/UGNCTvDr30kVOqiy8NyO9K5/zy01JuNmxrJcqOsWVb?=
 =?us-ascii?Q?0QKM44rp5WjDAGawVFkMtWUX9DJkuDlUQjHxdcuYQ/FeqQq6NFuPl4Cy3ijZ?=
 =?us-ascii?Q?GNwGpR3c/l7SCOSpES/uXmNUzIAjrHTk9ueDssdCG+XLf7q28taRvGfzol/r?=
 =?us-ascii?Q?fO2bbZi5AcdqUg762Xw327LYqMUk1hvQ1kX1nmdFEwqu2THdJYAah8HWAaNw?=
 =?us-ascii?Q?XR6JCAPCMGHjoYdQghLF4Xye7dtpM+yXSmUT50jv63filBE2LDWgBeipU5dM?=
 =?us-ascii?Q?OvGXUzsr9JHEIatJJmhpiUZvZ1vT44QdtIjKdIYpAa6zuD7XpjxzZ07qdxsj?=
 =?us-ascii?Q?wRhLxv0MZ5QvYOeWftANbuHQHeKDzTs9BKbzvldznyVlvBnpJ/59qgxB4gCt?=
 =?us-ascii?Q?N4APg/6HYUaPgmt4ne13w95CoP5EuYqTvg0as7l6RWDbiAXjv3jGzKl7wnyF?=
 =?us-ascii?Q?oLhK29UFmjI5g/SoJ6jjGhrwqR0Zoj5i+jpayseTqaTtn31JcNIkZTNyuHc6?=
 =?us-ascii?Q?j3WxORUFhLOyogfmOXhVE+thRynnjSxPhVbjIIBbMNaQiuYY9OlpDBVdDVd4?=
 =?us-ascii?Q?vKE6X07J0ykscOemkERF36BjmaTG4N9833sr2ZLbxbI5nVfnpsyHaYR+k9W8?=
 =?us-ascii?Q?NZB1SxEaAFnFhCriw6ZuWGrUGH/c2SS8bNoRY9QY8Nkrtv9SrVa4fHNH05Xz?=
 =?us-ascii?Q?5xo9Qza6it/1LOmnrTqMhqYWHqan2F3qz4mTn5CtpN6rLpZAVqKz1QQ/bf69?=
 =?us-ascii?Q?h5a0P0US4i6Q5eXsyLODjl/tMI/hx6fZRiTYZjUkL0iNqoDFdgYFzbv5jVhJ?=
 =?us-ascii?Q?MTe3KmIsiUkbfLZJrnLgNoxZRUlQIrzpJG/rcMsBdLvRhxSXaGabcGM8nxO6?=
 =?us-ascii?Q?w2mH9kgy6wfQxo4ylo5gJW9EJBMnSkccumzNtgjQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5dc36a-c6d4-4128-fa3d-08db923c4a79
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 03:06:25.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCSu8px7046amIgyorRvPJPdRHmqMVSe+EYpgz8SM9NWVKsJeQPlYFZINasvgCQ/VdTrr03w3eGHeFb4oTIHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change config from bool to tristate and add MODULE_LICENSE to support
building pci-imx6 as a module.

Also export dw_pcie_ep_raise_msix_irq() to fix build error when
CONFIG_PCIE_DW_EP=y is set:
  ERROR: modpost: "dw_pcie_ep_raise_msix_irq"
  [drivers/pci/controller/dwc/pci-imx6.ko] undefined!
This error was found by kernel test robot <lkp@intel.com>.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
v1 -> v2:
  Export dw_pcie_ep_raise_msix_irq to fix build error
---
 drivers/pci/controller/dwc/Kconfig              | 6 +++---
 drivers/pci/controller/dwc/pci-imx6.c           | 1 +
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ab96da43e0c2..db96cff8b11f 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -71,10 +71,10 @@ config PCIE_BT1
 	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
 
 config PCI_IMX6
-	bool
+	tristate
 
 config PCI_IMX6_HOST
-	bool "Freescale i.MX6/7/8 PCIe controller (host mode)"
+	tristate "Freescale i.MX6/7/8 PCIe controller (host mode)"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -86,7 +86,7 @@ config PCI_IMX6_HOST
 	  DesignWare core functions to implement the driver.
 
 config PCI_IMX6_EP
-	bool "Freescale i.MX6/7/8 PCIe controller (endpoint mode)"
+	tristate "Freescale i.MX6/7/8 PCIe controller (endpoint mode)"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 235ead4c807f..1050149ac9ad 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1609,3 +1609,4 @@ static int __init imx6_pcie_init(void)
 	return platform_driver_register(&imx6_pcie_driver);
 }
 device_initcall(imx6_pcie_init);
+MODULE_LICENSE("GPL");
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9182f8d552f..ec1b024a758e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -609,6 +609,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_msix_irq);
 
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
-- 
2.36.0

