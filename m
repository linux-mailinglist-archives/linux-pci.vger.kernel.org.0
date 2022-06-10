Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FF75468DC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiFJOzd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 10:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiFJOzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 10:55:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF45F25F8
        for <linux-pci@vger.kernel.org>; Fri, 10 Jun 2022 07:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dytRCMqHg6d9GZkM3bILPVZop4zya9BnTKRpllF+VcaxeppgRGvVQcChK3oB4aAZzdTwbCr6hrtPmX4aIbFIqakWUEdHnJjtocYzbnQ/yTK0A2RIHIPO+tN3QY9JMKX4DJJlQyyPfvJu+RJXFC7/6P9ACTGj9hC4FGFQ077eL851awxaIcofdjPO2dRDtqM+ryPpjTo/S1cDJ+T/LE6fRJVijQXHLrz9LmEo43VepIS7/bQqW1XJKfovbvBF3pHbRx9iQ+pA17je4Qkkvffpt9GecZNz8Ew0fRkR/5BKF0hfQqRuNHfJvIB94n9oRgtkIt9y4egX2Coq+nE0SbDwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmpFHX+pI0kjhgXBAiSX7QWAhS/uUj0iaDLMP0UJkvo=;
 b=Lg4ajzqyb0jQriRvj4EvZv0av50PJeA77//owyERrOehUY2/fryFdRgmC6iX46BEEE/qpxFyOrOvc9/WseN+Ejjum2QHqhmNz02Jw3w0BuMomttKjYGxDDtL3OvlYbtKGm7//oldp9jCahsau0p3rKF37Dq9qyPJ8yeI9paL3g4pzBx2jVrVkLbB2nfGz91KxLoN/DccFFhcx6Vm23OATz+b+yisHIBO/4VyYgRVzwPN70tZn55vtSW3VZEP1MY1Vov4hLpsPz/iWb+J45P4sRhgapsseJzag168vMPntRX2Rveu/fQO9k34TnqwSp8EEvw2Qh4zN5znZD53W+xIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmpFHX+pI0kjhgXBAiSX7QWAhS/uUj0iaDLMP0UJkvo=;
 b=giIgjMDOzTrTlkEgXtcwp1R0NHwLa3wjENKWIRV5G0S4GMQ9/xBtDCT/cksnfzHEUN9k7uA4YHIlqNu53VGVhxcpMBqu8MtAwMGv1ezH4GWpqH2YKlPfEQjmQBNrlrIVrnHRNXb6u2Esw1MBfjIS0xp2uEWxPS3yy/Sw8wFrzpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AM0PR04MB5346.eurprd04.prod.outlook.com (2603:10a6:208:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 14:55:28 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::2d0f:3953:b23a:9210]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::2d0f:3953:b23a:9210%4]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 14:55:28 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] PCI: Align MPS to upstream bridge for SAFE and PERFORMANCE mode
Date:   Fri, 10 Jun 2022 23:01:31 +0800
Message-Id: <20220610150131.6256-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To DB9PR04MB9236.eurprd04.prod.outlook.com
 (2603:10a6:10:370::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf45b7c-9ffd-49bf-98c8-08da4af141d5
X-MS-TrafficTypeDiagnostic: AM0PR04MB5346:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB534685B14D16F50675C337D384A69@AM0PR04MB5346.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jJJaaJPCRWej2KPLSgvwDsxSmZaPjetO1z0Sxnzq9g1/IfzzQqfum/DXu1QvGXuHfolqRPSHKnAUYxCqBSX2G5EXEf4jlhg0PcCwY50UxKyJcJxTRAUF6wufPUs2fiv9UlXzuXKHggApZiT4BIUp8803h6+HvnD+Bw8q2gdZGhM0yyFwTME/3phoGJ+8Ck7YvW2Z8+1XXLddfvwfNybw+FhGziQVcrZnil6Sld7w6EgbhhNa3QVXfzdRhlwvv3CxlLklu1jEZ9hjLeaAC0zsRW/DOdjBu8iSlD+AohjnTsSrFg3lNYaBwn7NA0McTGQ5nnBs1MQY3wVoPAT/Iflng2HOwNrZaqZJ7AsNTUfDQpi7Q7xA2vG7/QhNglBQPVmIKdXY4fB5Ansxrb0b72I9hdF0NLdXaGGqH84R2JAvbBUQFbrOrpAEvjPuZko2a7ZNQN1s2O7Bo3qdW8b7zb4qFSlx7lLKh03H9R9jhO0CGllvbnS3L9X37R5/hsz60ko+dULVDJCu+jHQ9QncbIFOUdsZF12jafClYB9X/JIjfzACzHSsPqg60ROmwB8Nzd+9RdY2i+EOScI7laJsiCiuacZ7mUCy32NUTU2aGGLkt6TUia2BRQuiHJg+smkl6WfVdCRzf2JvXHvxcUKpNjXO52lJW9t/9Noe36ai/PgoylBTR6QU+MADPFFILaNO6Z9ST9O/3mnvgNA55pydnP53Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9236.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(186003)(1076003)(38100700002)(52116002)(38350700002)(2616005)(26005)(86362001)(6512007)(36756003)(66476007)(4326008)(5660300002)(83380400001)(66556008)(8936002)(66946007)(8676002)(2906002)(6506007)(316002)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nf7ev/ga+36SnDMbEq6+HVlsPXB3JKeo4OJ8KgBdzTT5Y78AD7uuaKo58XNM?=
 =?us-ascii?Q?VwrqJeGcMbdva78CKqGUNnz81SYnymlXW8xKJ2VWCTbDK2BU3nsRJ58vMaGc?=
 =?us-ascii?Q?GqRCnIb3XgWesxQ4ETg+84C25Eg5R0xBsAG7eOayqLAh7vu7m188/7RWm23C?=
 =?us-ascii?Q?bp6qulqs7OrW/Pms6LHN+Rj4qMEjLNrxsjMy0v6FH+YjCcA4bzSzdXa3HR+v?=
 =?us-ascii?Q?ItyPSb/vqP32smAUF+Ansf+sODgfqLjXc9dITqAF6Z5hkCa45Fy04S/h5RJL?=
 =?us-ascii?Q?vV5r2pMB0phpgTAXhE411VXRqN7zMXM5OVNZx/GhW+/IebGg3P+zhKi+gZjE?=
 =?us-ascii?Q?IUzV6Ti6DCDvoJkFX/ZAUIKfnNhTau0HSOkeRTaWCxWW9BSlq+eEiTMt3b98?=
 =?us-ascii?Q?gMfExFvL1MgNjvlS2hQVv35JBjOqgYQUtvn0Qfvz5/MMW9ZIa9fpc8m+fNoe?=
 =?us-ascii?Q?VWB48tJfK88nNkgfheRogCi1rbAZWjTohb3mp3FNWGMRQ5EHUc3q2pWLZRkN?=
 =?us-ascii?Q?BoSthlhjxccJUKRyH2SgD7WdYsPt724k8D6Di4k3hnpOa3RewYoVNR570qjr?=
 =?us-ascii?Q?Mke3deBYGXhJfDv3As1SL6Bbm4x9fgfohyIPeMCCpe0QknrO5UBrYMIUzwt9?=
 =?us-ascii?Q?B6M+kI/viEKCba1X0v51wSLSoeU/Kt/IopXJiCtPkK1jdHR9GOjXhcLCNki0?=
 =?us-ascii?Q?UWc4nKm2ToSuzqWDEE6t09Js/2+j8+nLVcxLw5xeieEj61330h529thVx/e9?=
 =?us-ascii?Q?yFYanN6XGhuxtLcA6vBGvj8tjnasihCd5iGna8d6Sm0Q+hBqNOtRuyoA/PD8?=
 =?us-ascii?Q?hoX2amFkwk7z+1O3cM/R3be0e5BgPjVkBbAdcKxqRU8QN6++PWgruN7NeLQ9?=
 =?us-ascii?Q?3/Wf9ab95PuzcS9leWokUv/2QiONLFJwU26fQtK8W7UDShAiAcTWDbiTU2VT?=
 =?us-ascii?Q?yvKYrxsJLKiNnUtv6aMbx8MmQlhXIOomV8AeP/g75GbWtfc+ZM63NpH+CwN9?=
 =?us-ascii?Q?YCBTHc42CMPiKLBh9H29sfsT9+kyrJ8+PI5emO3w16Emf+rMZs/ZOIAsSuxI?=
 =?us-ascii?Q?Nz6LQUtbpuoJoRImyCV78cU9HsnU5/oNfUz3XfDIqBlZKXSjG4m13nQ9BWWb?=
 =?us-ascii?Q?zUk+4ZOSZLZ0IQy/uTPnFqVxgaZcLCspD7E8RpbP4d8TVBw3kUoRKzDPsfjk?=
 =?us-ascii?Q?8CWA2NZOf9gt5/TrZZGxHIHL1NNA3jLfB52kdI8Skl59c9rD+EUfOg+rnMwP?=
 =?us-ascii?Q?vYD5HO81Nl4Dp70JyLL2DKU2BItvVn9zK3t9DjVLc1G8hZscf8ODE2Cywt0W?=
 =?us-ascii?Q?IMvpOBLy4d5ztxH+XGo//IwpxpQ2rgQvoaXO5hqcH61OTneMNBTAzBFEDLkZ?=
 =?us-ascii?Q?fWmqxmHTgqTi6JWECKiFsl9cLZB9M3WmfIwjraP3iIt9Cv9g976Fb5kgFEKW?=
 =?us-ascii?Q?2/VowpV5APC8Kg5FAkLHZJADge1PuwfO7DbzCCNU+UpUtoPqviKWvOsTzrYD?=
 =?us-ascii?Q?qryJ13F0LuRZWcg3SG2j7E/lQ1kjOvl1Dw9y2cn4QozyM9g0mXNJCkbTrQAI?=
 =?us-ascii?Q?8jb4dYeyjI7/VhmUqU8BEpeJ6LkHMNwjdYJ/jwDuT41m9BMKfiNN6pSjVe/v?=
 =?us-ascii?Q?3Hfu4eemrP56Yf1F1hU213WV7SfDSONsL1vMGf/naXUU5MWQOHvavF7W+BAN?=
 =?us-ascii?Q?ZkwVmPKqFLVUxvDGmDmTY11NNoUlb12hG6nnTzYvIG51U4o4rRQ8sf2wyNyx?=
 =?us-ascii?Q?EEReXixmdw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf45b7c-9ffd-49bf-98c8-08da4af141d5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 14:55:28.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuVot88RRp+18DliXz5L0VYv4gqTXsGC+pER6C3eaHXaGG3q08h7rOdwQSKfhPQfi3MrPN3otwqYDYIWIKqHdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
made the device's MPS matches upstream bridge for PCIE_BUS_DEFAULT
mode, so that it's more likely that a hot-added device will work in
a system with an optimized MPS configuration.

Obviously, the Linux itself optimizes the MPS settings in the
PCIE_BUS_SAFE and PCIE_BUS_PERFORMANCE mode, so let's do this also
for these modes.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/probe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..2c5a1aefd9cb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2034,7 +2034,9 @@ static void pci_configure_mps(struct pci_dev *dev)
 	 * Fancier MPS configuration is done later by
 	 * pcie_bus_configure_settings()
 	 */
-	if (pcie_bus_config != PCIE_BUS_DEFAULT)
+	if (pcie_bus_config != PCIE_BUS_DEFAULT &&
+	    pcie_bus_config != PCIE_BUS_SAFE &&
+	    pcie_bus_config != PCIE_BUS_PERFORMANCE)
 		return;
 
 	mpss = 128 << dev->pcie_mpss;
@@ -2047,7 +2049,7 @@ static void pci_configure_mps(struct pci_dev *dev)
 
 	rc = pcie_set_mps(dev, p_mps);
 	if (rc) {
-		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
+		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_peer2peer\" and report a bug\n",
 			 p_mps);
 		return;
 	}
-- 
2.17.1

