Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2900F57674D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 21:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiGOTWx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 15:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGOTWw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 15:22:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC95785A0;
        Fri, 15 Jul 2022 12:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5u9+1/K7gt8cRYGXqC84l4ABQk/XACNGVrnIbSBtH1zn84Bs2wIVKNGkAAvILNoc3baHA/GxYA7tpyB/1CVS/bByhU6Ah8+2m6w0OASNvfaY+i8p0OJYDI69LCe8+vF77kV9OSZzi4wuJAvTqanvJQIapCbHgNmyuBZP1mp631DERLZr/sUCaKPDuNspsJfWRb9Lv67ni4lhQNtsB8jYwp2RfRt7H5z27+TpH2beqV04skrEfKSyEETMaCbG2H96Wi/WIlJRfSrwO6hz2xLx90CKacmiJP4qqSqJII5wSK+i4xgL/nddC8pHenoQvI46AJDdRQVWefqZlRXUmPcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=mBm+znsZLDVRRLHSLryG1AP9ryXaRukVYNCsoMN7g9YTsxVK/thA2AVMc8006cCQ0lJ7BGSvybNHa35ciUplmEMCyQrneldqZ9eqCth77d0nj5AMWTMlySjb6BvYZy1bLIVrckDwJY7386ZQSta7Nm3Tbglhv5cjHm5NBEnahMOSBpNhmorfEIcy4/8p1aBn/V2YyiC3rPSvYWREFJaIdSxAI6jUJ7BYsk60r/YEskky42amZCsnzLLxYcvczZjutGV0k65FW32H124nlxDAAqQOBMFCIACVFwAQiFYbPRUeL/e1H5Gox1us/fa51fxcPGoMgIJO1J1XXgbg/VXNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=TaO4vnjbnUp/RhUZnTMw+TJ7Bjj6TBBzgG/H/Y9eXLKrcWhLAL7kkaNe6hZig8a7iayEnrrC9r5ASQpuqZBUh1yp1cYwel9g7UBA/kdnolz7lO6+1341E/4dp6h3xg486LHtVsyvD2J7Wy9FYakC6sf0XQaSo7+Ve9pi/3O2NFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by HE1PR0401MB2490.eurprd04.prod.outlook.com (2603:10a6:3:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 19:22:47 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%7]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 19:22:47 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH v2 1/4] irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
Date:   Fri, 15 Jul 2022 14:22:16 -0500
Message-Id: <20220715192219.1489403-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220715192219.1489403-1-Frank.Li@nxp.com>
References: <20220715192219.1489403-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5b8d0c5-4929-4f0d-52cb-08da669766a9
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2490:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SracrxzgoaY0iLMC7gxuFwFRLJbLOv1Dz0y0IfAKaJchhOPreu4LebltH//mdn5mjAYEvFVbYk0FQq5tUpAhzn5tHBtxl4T7LE15L1wFDNOKNuiGFgGrVK6tOab1QGyGjwHHkBzGOzrWa05++aOohIK1PwlMstemQu/EVfeDto9PwbJK+TwzjwEqsWun5EADZRdxHRZb7oqlpRyejfxVDDVyP4hPfGEzQq1fqt1gH+qdFt/cnndJsnesvcXxGUASk2y6/jso23gUOLPmF8cUoXRKGM8AtoFvcFgsmwN3LDi9kbVlaT8Rb0gJxl8gCqouavPVP9XCVoW98OKV2vwZM6ndOdqHtV3tj/6uelHtBTgfslITnamW/mpk2dwCPxCq5x3s+dgvdN5pAKSObgPm5nJFQfoOhEWrx4ww7PfPzzYJXDNRLTTxAUySxTIjRmroLzE11w+ms7s17T75pDpmBNA52Nr5jwVUFnmOJnij+YYkneQ9R8UWdafcq04vmmDrdu6IUuwNnW0etiUXw6r0ScvXnMdp7RyJKvgLi2A4h2a6+Iqv5UF7lsynpJ4fiPDyHLWqkTzzRicNvw1cviYqJJBiRd1oUyoTofsF16CYJx9znA7ggSQ7OpyPShp0MmNQVG2OVFhmjKyDVxVydatb+no/KJrLRoxy9Kill0MGyaRNKv36zrN+aMt38ThVpMoFG0xVvtGmugqNzutVaYO0uIp/iAnqiUfAmckj6W+i1WG8t1v/vsfZR9FjxQ6ObZazqgU8F+oYPmwRTaECoguYtiYRU4l4HP/LopGXwq/Qkpu2PU3wB6u9S/DA7gqqtu591H70t7TaQxuuZVqTYIH7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(316002)(186003)(5660300002)(86362001)(8936002)(66476007)(66946007)(1076003)(66556008)(6486002)(4326008)(8676002)(6512007)(2616005)(41300700001)(38100700002)(38350700002)(478600001)(26005)(6666004)(6506007)(52116002)(2906002)(36756003)(7416002)(83380400001)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nkSMbGO3mc3BF2Iw3CUhb01wZq7jfU5SrySqa1oTmMZjTiSR2Q2S6vxfKyR8?=
 =?us-ascii?Q?sZock7qz2OGqpgxzkqzuERRrYFBt439TqILHmbhjUps3MPyyjPA468gnvNdD?=
 =?us-ascii?Q?7eqX/UJLFgPM37YATmwuJ7O0mI+a3ehM/qk2N4cSq8FKJZI4jTFAyfovqtMt?=
 =?us-ascii?Q?WpGbHD2MBn+j4ul2Lxb+aZLpEM2mSx1VsBad10VoQ+SSya55+VvkgjBjVdna?=
 =?us-ascii?Q?s6gqU5KBlv2oO9F3q7aDaS61NjVc/4jD9HIvnWBMAjSR8JJlcIDaIGcQPXtT?=
 =?us-ascii?Q?lhLG29CGCryFOq8NHrUZO/WWv/7nYjmRAACLVjq5J94mfC1F19zk7uhjBzgO?=
 =?us-ascii?Q?yalwPe78B+YM18naO+mn/1/ztu3VJ1Wbny8/K9RCPf+zfEI3fDhG+3nWAPnk?=
 =?us-ascii?Q?zNQLms8wQe7AS5y/ekmcU3DMaNa6miSF+2I+til2wONrDi6yqILJd0KaHwYl?=
 =?us-ascii?Q?cBKBtXETVPARGwaYHcUn9/JldMbhFYqQ1XAdeoEFlDmaG1VqEhqOqDTGzdya?=
 =?us-ascii?Q?KQa1OOsDNkHEiDNJ2CPscLrxhyUFDDspqGqAPdJhLKsq9yMMsdA2WeoU7ptj?=
 =?us-ascii?Q?tP9edNxauFmyG0Lj/KP6tDRb1XibGCCeJcwiCLSyb0Lj3YD1rNqaH4X0byt0?=
 =?us-ascii?Q?10tCqMIdjuxvkAg6JkqDbhqpjBbTdtBgbSqCedavedvFlTvUUYHfsimRslPi?=
 =?us-ascii?Q?yBbUvm3zftgxOZ/LoVXSbe1tWLnDI9P45M/KuMw/PKPHiLAFP6Q/9cpMFxqC?=
 =?us-ascii?Q?RV/KzlOTfXNBK05uDyg9fbJzG5v4PE1R1UW5nCkd52uesa4ImYnt1yVies1f?=
 =?us-ascii?Q?EA2a326T+IUIwdBRj4GXDctkO2MUx3TE+yNWE9L+9Ab56pL93rz6eZiwynJy?=
 =?us-ascii?Q?LJH+te2wU/krhaIV/m9Vu2FZOIlw1SCELnAwYEmglNlMyFc28kdtnkZpiJ4q?=
 =?us-ascii?Q?KDeYR/bkOaCpwEJuZXi+SsBGuad24xqlyPJ35pXErNdF3AqAjIdo9GPZ3X1z?=
 =?us-ascii?Q?bL0rXPS/EDmkPgt2DScebLjPjnd/3+3eQm8aFx0h19vkowA5eb0YoYxVtxy2?=
 =?us-ascii?Q?N49FyvFvJQvRPirNF/yo5DHHaZJ0ITEhvgs1QkDVMFyZ1ZNMLAABViY66sxV?=
 =?us-ascii?Q?78OQJR1VPb7qvMUt8mpVWSKu2z/XwNKcbw9KkbmeKW4mM+i2u4y6Yq2xRgQA?=
 =?us-ascii?Q?Ukm0+PMJxH6StDAmW9cf62bZ1/nfv3YO3cEZgU31zCPZ5aQm+tMiAojCuXYL?=
 =?us-ascii?Q?sU8ToIITXuEuwVHToEgqSbGpo19NHjoLDAulXiI5gEOOnAP7KotxyLT5TSkX?=
 =?us-ascii?Q?NSSBp7/WErrfRa5IMURcnL+u3updmcS6FZ7BqfkkUcIAYFGcrzFSk0llUvj4?=
 =?us-ascii?Q?njDHHqlVH0376atAZx4Qw0z5VkfYMYAGLHW4wJEpvfA2hzrzZ4dvmBgdzBnT?=
 =?us-ascii?Q?W9tk9VAguT6WdchmiwyrxtjUGClSJ5HWTXpfTOemD6cpWiJ001mV/5pS/L3a?=
 =?us-ascii?Q?zmfrn0WuppO98CUls/IL5X4ApHo3BQ5ghZ+Lhxp4TLdrPMCg7Rg81qygHkbS?=
 =?us-ascii?Q?QlLUyZOnwLlPkgTOic8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b8d0c5-4929-4f0d-52cb-08da669766a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 19:22:47.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MTiLpux47U72mA4Z6fHzZTWw9j05REE78NCBcr8I2JaTDQOLEH9Ws03rkEq/Gxw2DNAhGNs4v7frI2SITjECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2490
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IRQCHIP_PLATFORM_DRIVER_* compilation define platform_driver
for irqchip. But can't set .pm field of platform_driver.
Added variadic macros to set .pm field or other field if need.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/irqchip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 3a091d0710ae1..d5e6024cb2a8c 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -44,7 +44,8 @@ static const struct of_device_id drv_name##_irqchip_match_table[] = {
 #define IRQCHIP_MATCH(compat, fn) { .compatible = compat,		\
 				    .data = typecheck_irq_init_cb(fn), },
 
-#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
+
+#define IRQCHIP_PLATFORM_DRIVER_END(drv_name, ...)			\
 	{},								\
 };									\
 MODULE_DEVICE_TABLE(of, drv_name##_irqchip_match_table);		\
@@ -56,6 +57,7 @@ static struct platform_driver drv_name##_driver = {			\
 		.owner = THIS_MODULE,					\
 		.of_match_table = drv_name##_irqchip_match_table,	\
 		.suppress_bind_attrs = true,				\
+		__VA_ARGS__						\
 	},								\
 };									\
 builtin_platform_driver(drv_name##_driver)
-- 
2.35.1

