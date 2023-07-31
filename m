Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C637768FF0
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 10:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGaIVT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 04:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjGaIUv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 04:20:51 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF3A2134;
        Mon, 31 Jul 2023 01:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXh0KiTsH0ArV+Pq5ah/fju+4qCF6zUABtbt2Xi2dl5WNhq4U0qf5lfCPgm1uox9dFj+VlNA06LWohv1mUhWaxUCauT/SUaV9v/p0BKr42WNsjYVEX6PgBCiN4N2OGGXQBf6YsyEu3teTeHUCGCJG5RrV+Yhe/tOd1CnZHKQdDvdvern0sCT8qWlto+q7qwoOJsMLHL6e8pverDAWfaYCubkZRVTkyuVbWz/kJnkJ+K+3EUT9Q2dFI374sZSKSVxEepMRnuVz3efrLBA+sBTjxTcVys47JtbCA68z9hd4zFM/bdcHplZDpDeN/7fyBkKyiYGD7CmOMaOgCfI10kh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcbLhzYnWUb2EvIz9K96YqiOo9eAMoMLmHXkXeMndzA=;
 b=d/EmmRxjSWBRpDRFR4n63vgX7Gy1qnmIRcU13e+HZb0uIfBrhjnJABC/lq6ZN4PWmWuFF7Aw5sBZF0p3Sw58yPyTGHynUojcEsSmAk/DGUpp9OLpiigpfhavx56UXnCA3q9nfqXqaAhlqyJxjZ+b3VIo6XNLgkXCSWZqtIo6v60niUsApsQ3I9pi4G0Ye/v5kRyoWJqZJXNWu2Fo7mDVATLzAtHgu77BUzFo11zUmFfxUytf5yLPBS21cVz4cGurOTDIjCgfdVO4HUfRU8+yXlOz+Mia73N7bPjQXp2wbWZZUvmqi+4LroXSPOxm/g5PnmrwvIGrfdQEA2M/mstS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcbLhzYnWUb2EvIz9K96YqiOo9eAMoMLmHXkXeMndzA=;
 b=W2D51UzH/N1yWoD3xgf+TmaOx0gysbud+EX+ZaEdBY/qrByGbDpDq8258UJsKX7x4L4K8opfT5fhHG1LGvGkIFgqgo8MTZXi/FWCZJ749LQ0GlwyLmRTEOM4EAsxuf7If8Qv5yDfYKwuMBGMwNc2VI99W9BNsO18IBPkY4ev8tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by DB9PR04MB9937.eurprd04.prod.outlook.com (2603:10a6:10:4ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 08:19:26 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::2dbf:8d49:6daa:dda]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::2dbf:8d49:6daa:dda%4]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 08:19:26 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: imx6: Support building it as a module
Date:   Mon, 31 Jul 2023 16:26:23 +0800
Message-Id: <20230731082623.975824-1-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|DB9PR04MB9937:EE_
X-MS-Office365-Filtering-Correlation-Id: a75e11a7-3330-4ffa-36ce-08db919edaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+qSvdwuOloiHnHmBGl8kGliAIiaDT7XrOh93s5vPP7bwL+M9gkeumIusX1rYmYhEjxpedfVv6F+T/yJfCoIIQ7EdLTmZ2L0ueIWcuscO+66adVxpVw9V0ICIEiRmKNoaMuD06A5qMoAMfjmYoDlVpYA1vtVMVVCwolygAKil9O818gDcnHTjpjnBkFbzDoNXQjvXhJ2yASEihOy2Z1Wi6K2APRhZOrzeacechcE2QZJanpUjOLEXePFXXqgcqcxVXt7/J9l+auP6M+68v1vFUfnLW4KhUd+YLTR97SV+tVUOTGjH5gflqGjBxiUBcClOYfTUgAn7U8Ca9gOsj7+aBgb/1jQTjYPdsYMGmTKawWwcurmjB13kKoHLr2R2sytgcYN+W/Ink+iIdHVkEr7Y9MzR+7XkMH/A7S47UmVTA14e/UnLdwRfTw91OIHeyBf49JUVEHEo2yY2/XmO9zibul+j9VvxYB3Sa7SuOhf2oM0er5239KXjhLKccvN3Lf2Tnow3us8CqtRkS3mPDxRm8YRw4Z0DXVUf1/E5JVTN07XfW3p99IJdQC2nYaBd8T0wV0CASvois7v0HVx/D3cSAb8IlV1QLzQz4NvlmDxQuq4N+dYMgN8foOAAJQiJ80n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(6512007)(6486002)(52116002)(36756003)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(44832011)(66946007)(66556008)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeU1lbi4/Ab1VXTg6xJ/s/ClsnwaKjKP0fS7sQZ4HfDaB8u58A7hVsIxCdZO?=
 =?us-ascii?Q?MQFMShwry8nZXiGnLwHLW31HxxZlIuQkr0lymoD5rbHME/yujD9pMX4tMQFc?=
 =?us-ascii?Q?EQQF/WhnNuw0DS2mOLePUFBQ8L604AYgWfNa5592LGZudITjqQHfI4tgd72i?=
 =?us-ascii?Q?HOc+1mBcv/Kq1F1syB6nhDWvuwOBv2vlTg5Vt4BvxSZ9tXcSpNZwY9h1MV8p?=
 =?us-ascii?Q?0b7tVt7uFsk83aogPTZbKXa6NHNyrq7nAsIdpleL3mKXnM+6NdtwwZ3dpgV+?=
 =?us-ascii?Q?TICW7v3wlmz5N1WZm2nyneesJIvi2vPNcxKl12VynCFpHCGBbmdzRigSMl57?=
 =?us-ascii?Q?uIEf0pbW1XaQQqK2dHwSYSzoUuQ9i+o/n4ztHGwAmwKA8mZBhNnIMsAFmfPA?=
 =?us-ascii?Q?hwaaUHLa1KaWT1VgbWx1UByPax9EwYnHVvYQk8maoZG+CovZA3dz6IbvFXqV?=
 =?us-ascii?Q?Auivo8EGjH20NPBv1lPaGmfHCDxgksIDZzrrWx1h4dJxH+Lo1Kj58RLhS++P?=
 =?us-ascii?Q?X4mjthl5CnDGZmO9HaewSwtQm8UoNeEieMfrPA15AZe7gsavCXR5zoRA4csp?=
 =?us-ascii?Q?IDrpdUP8TMz5B/A7YRUlhr9XtiazBMHkSF4rNRGWSkD7kuD2SeS5hVSEnIky?=
 =?us-ascii?Q?14b3uNK86s1nSON1XD4inCNIdUoGis2FOytlFnqkFHjiYAz/h8bpYkBCYd1M?=
 =?us-ascii?Q?o6h5O5CgfoD7LEeR1VgWWHmzhVdbOr7RNqZQHAJgZuvzhaiBfQX3tq2nJZIP?=
 =?us-ascii?Q?b/WQ/PS/PZQhS8Ur875qmCtoc6bnK++WG3vVvqz7MuRQUhu+PVOKyHZ5J+UN?=
 =?us-ascii?Q?IHzpFqwXOVH+Uh8wJ60NVmAUOW8WnQ7vLUqb3DOSbDdUz/eVuHLJDA1h9tvm?=
 =?us-ascii?Q?oT2Iv1wyDe+XKIM3qYKMRyPaaSW1v2JMafOHEBRb6n+2cbFTO9yHReJlNN4V?=
 =?us-ascii?Q?s5iZ7PFsGHmG9bdx31M4xJdEeCNkAWaB68Yw9awXPhH4JLd8Xx6ynwi6MEYJ?=
 =?us-ascii?Q?pjj7KfkszfDxzYb/4B9EdT5KHODqVncSYMkn4hPPgkEv/t0UHlqCGzpd4Eq7?=
 =?us-ascii?Q?wTiEVXqRi3C8+41g8e1Pul0L2891VBju0z8X8OD3QfWKk1uXyontsOtD7nBu?=
 =?us-ascii?Q?TLBDTs8SSbces4YsTuSBrougnmcDZhw6P27B/O0qqnPpe5/IoMhOpBl6CYQu?=
 =?us-ascii?Q?YXhPiVQlzy98EXFEgO3qZFHhEjQzYuepTFXMpDxHztYJsf7rY5OVUo//EfGl?=
 =?us-ascii?Q?WLcvV51uvEc9v4uIoH9TAykm0Sq2I73fi1V6O5MvXbd3ph6Hi8X/6Q6vEqiv?=
 =?us-ascii?Q?YWLYE28T0I9koi7/rTdE1G/xZNowTlaxi8K9aH7JVOmQPNxSXmm8N7pxZde2?=
 =?us-ascii?Q?ltlgetHPAKt3VpQ2H8+eIEs5yusKwzFaeBYqIhYkS5W1MjHhbsQcLHf2iWL+?=
 =?us-ascii?Q?HcumV1VKmNC0ULv+XasAJkOmoO3tdiIDiZU4N7tG7pmcxSuyK5Pz7KZHdoY8?=
 =?us-ascii?Q?4/lZ1BNdeKpwZ8XkPmyla+rfZgfZVHL/iNc5nbZRV/LW4e0bSHMhC778wFWC?=
 =?us-ascii?Q?3F7kONASNqz60tT4pYBs40EwIFbvjh/NfH4PJ4mV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75e11a7-3330-4ffa-36ce-08db919edaad
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 08:19:26.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAhA70hlFOCoNOcguI2P5xwMzlkewt6EdqiSvQn1y0Q/bqcMuHPhpa3pkr8rlFqSL3czUpp32I2k9UP+L7LTFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change config from bool to tristate to support
building pci-imx6 as a module.
Add MODULE_LICENSE for it.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/pci/controller/dwc/Kconfig    | 6 +++---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index 27aaa2a6bf39..50cc322e4fdc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1610,3 +1610,4 @@ static int __init imx6_pcie_init(void)
 	return platform_driver_register(&imx6_pcie_driver);
 }
 device_initcall(imx6_pcie_init);
+MODULE_LICENSE("GPL");
-- 
2.36.0

