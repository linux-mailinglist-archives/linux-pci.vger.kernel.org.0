Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922295AF48F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 21:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIFTlY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 15:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiIFTlX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 15:41:23 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2252A80B6A;
        Tue,  6 Sep 2022 12:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMoMldP/IF7728bFP0KesUfF955eK0gZ+oOn1k1gFJtO1O0K+ow2WRPvF45nANvam1QfWbHLTOWICA2fOb95VVszbgNsEbZ10dV+k0Cmf1YcC03NqYQwrc3LpyIZTeopt4ZUdtIr+MZsdhCNiuYjvjJIHPTC7GqJpqFMresGAaXotkvKWd1RIumIVfQwmYumqxtTH2zY/0d1lhftZ4UAc0GJjEU+Z5F2cI2pNLCBuNMD0hACrsMD+m9xvm1Bn8oT4UOTxxxFRLkTGyYsZP2G7sE4nps96rfJf3Qy25wFJot5+wO0g9GhAoOCUckJzyKZncaff8FpM9kWzAvjv2MU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=nxyCGyRAgNaastNErCTC2xwzrqeSpRwRHhAE1xj/YBo2Fx9ZgA+dE40Bzs9+8zmgijHaNrfTLyF7FJnhO51xhsV8V1T3D+pJsnt6plVg1jE2yBoqwLk8AgGt4UAI7/G2MDGiTUEBIsF34delXlcJ/qCBpCtSR3EmjQzfLDJj1oG5k5GS+kC54Lnm9BuYaMYprfJIId7VmUI0QHX+ieOoWmJ1v4oDx1D/o33AsiFWFk3SyFr2HJ7WaopCBpPOkVP4L9ruBjJmghbTNxY4ViDIX/TDLWhKmOaRsy23pAhnCjZ7nN6daEOS2919lGUQ2lQj9ca9KHXBxZCpnVSl9W4BPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=Tgk158fR3SMw9dVgmROs3Ns9r7InTwJ2/O1jUgM99F7Ou7cSX2cShJYTbKYUhPJ0by8hJmsAr9X88o1J/fuvwM7JeEkUGx6vQ0DunetcdGhmFDI3sD4gM6W+zEP/1p+GzLIZOSlnGWVDjSCHMizCuTt75g/1dJSOYfKg+Gz4iLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by DB6PR0401MB2358.eurprd04.prod.outlook.com (2603:10a6:4:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 19:41:19 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Tue, 6 Sep 2022
 19:41:19 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev
Subject: [PATCH v8 1/4] irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
Date:   Tue,  6 Sep 2022 14:40:49 -0500
Message-Id: <20220906194052.3079599-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906194052.3079599-1-Frank.Li@nxp.com>
References: <20220906194052.3079599-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|DB6PR0401MB2358:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3962b6-a10c-44bc-e601-08da903fc534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7ei2ktQGTPrgxtaSYyAtkHb2tLavfM+Am6eY8vO7zk7STddx3nfn6ky6EvZY+Hor9NoQdjJOdbTvplO7rAvUqTScj4p50kgl3GxfwUqLi1lEsQnONdwU/RKxieuLKbQEd+PTMshaJTiwm3zi/ReVPk9g/RgovMCJTLqAMDPuxRvej6I5WB6VBr/NRUVwFVVeg+o4jWGOTS1Gi0ujVvYKuW4kbyLaMzJfmaHAhY+yEChSNvtfyPJ4uVpYhcB0/6w7l82/jR8Y4lBmv5N564DK1+mrLEne8KcULiKquDspt8yyjIjVJMfcB9JVe6GlIEcNlq/9o5j4tTIFCx5UvhahExMUMuj4W92HP6n/23WkoviEwHiY7LEaa6/aLlPJfWgKeL86d/9Etucuks16UNolLV3EyShax6ZkYXUDgRfvaHJzaxTryIBdP2CRIDQdlb77uo/RpKdM2fp9SOF1cUiYuCRoyzmvY5u9bNthDY2N6dqD2Pkd+qEYNjIciE8tOFuJLaN08n6jAlx67oOpM7uyVJdeeib+fpM0b+vELlrM5QuPgErV0BYLUhFf0GLY+TEXdy8Rcudul0TDxlUdCEOSPVs2Zt7NgLmCsRzuN0fGeacZDY+Grw2WE9ixKylmujH7G1ut3HAgk5zA4tZxOC56zWkUtyMVEjxlifCUYsdqEEg8nNuoaID8wPTtNhJQvY/L7yd/ehz4O+vzsnJa0lXycuADueftQzaTOuJ/FS4EHorNDiyWkR1VEKH2JiLaVUGtPyBFMvZffJV4j6W3Buzc+VIr2NI2FVWYtJknHV+jhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(41300700001)(52116002)(26005)(6512007)(6506007)(6666004)(6486002)(478600001)(83380400001)(2616005)(186003)(1076003)(2906002)(7416002)(8936002)(5660300002)(66476007)(66946007)(4326008)(8676002)(66556008)(38350700002)(316002)(38100700002)(36756003)(86362001)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rV8nELxtFQBjk6vhn9y6l23UCRFS6ttIm5jKs4ATRtwsMgtfEb44FIfQyu9C?=
 =?us-ascii?Q?Txlh/XJO78H+BkUd2SjROBiDsvMCLQkfXvUB0LKyluxfFiR5NNER1QsDtCF+?=
 =?us-ascii?Q?Mvrh3UQC/wlt9iCRVWW1KQDXDlSAmiiNIBeeZzP9ChuSaONJuyI07krSeKsn?=
 =?us-ascii?Q?5zlVOh1ujLPNNMZQ0Ci/SKk9cvfC5hvu69icAoDpPDifvDN2+1IqsP1aEzci?=
 =?us-ascii?Q?YLnONT8GcaQ+mkohYz/oXrZ0iUTXnZgftMUQ2nACOYWCr8WnFC3AvVgJUe+V?=
 =?us-ascii?Q?Uhv82n2c/D+AbGIuVqZ7Kj7HQJTW10S5PsVdVyvL9qA9r0S6umANQk2dAL5+?=
 =?us-ascii?Q?YT67MTZ7Qb11JQ7axy533V1yB4KAuyTKyZGvDlk1URx2PmtDuudQLu1oEIwm?=
 =?us-ascii?Q?cm0RXbOpKxHv+IVlAO9YaRytH6EjFJZp1c0KqRFv6qG70Ek8IrVWQXuk33oi?=
 =?us-ascii?Q?5xHgXCgkwQuoM0y7reuvpnWBgA1cCeFxDVp9mD8IqdafXBLX8GleM9b2rcdV?=
 =?us-ascii?Q?85o58Rp55j8HG8/RcUroZwtikg3Wsyuen3pjznLDdmRNh00LhZI9cQriG3AW?=
 =?us-ascii?Q?3EcYyaVEJAp6fmIs/MFLyzTPA4MS+dR0spOBsJM2fKggtI0OYJbJjLn0eIBu?=
 =?us-ascii?Q?R91Wo4NDesRgOCkWxlYQW3JEpIlPos2LQKh85W/vqcPSErtc8OaX6jmCJzpL?=
 =?us-ascii?Q?0qOsHh/rQLsMdYyOSx4pTO+Cgql/TDY3r4Jepd79QDa/X/hEjl9QcJjDaaxb?=
 =?us-ascii?Q?2eeZM4UjrCY0tNbTSUoiIBCZj+jq2NY9jaS3nFRGBnwUt/p6ZB8oTg+zZ7aD?=
 =?us-ascii?Q?7wljwbVJqjmHiF5OFPrOvUrp510sBKCwaROvbkWMlmtkqxGRZgUsDSGMQWkL?=
 =?us-ascii?Q?XqAcboIGwmnq9DZptTHtk/D9oqywbyQMnpd2cUG4lcIhdy29XLSkKroaCRwq?=
 =?us-ascii?Q?MJPi3t3JLbMZk81+jwmuRjkd+vYAV1dcVSy9qLSp/yrmsHwhFYmpDGecBHAN?=
 =?us-ascii?Q?7pDV3g4BL0YSXxLUSKJ0EDsLaoCSEwaP1dU7NcEZ7fvyqzndXJbTsvXzwyx2?=
 =?us-ascii?Q?5Ui08rfSD1tG29Tm5Y3my9unODzIkByOvZNSVLp7OXierAyhwYPjTUUkiJrP?=
 =?us-ascii?Q?oMMDIS4yFtZF/ZWwghaV6EKfpJOslC84q/11AYgQ9ZlWVJzIeakIFmkl5WOe?=
 =?us-ascii?Q?3S4SxXjRmzZMKscFEgSTRjhKJ2Xd2hAcc5fGII36yUDfgSC9SQBMJsOdRTxa?=
 =?us-ascii?Q?aEXf13P4YvA0oiThK5lTmaxq8w1Jd9lYWAB6RKvnB9MaxyJxeQ5SEqWQydR1?=
 =?us-ascii?Q?Q0k7C+eM5Suhl1QrW5W9gOCrfX6bXTuPoVLO6XTqphQnwmaSCiVC1sv+e6Pq?=
 =?us-ascii?Q?Hc5bWFZ/m3MeriJV39XOc8yRuFCvHRAH0j4gwTvHCwoFPrXzwa/8p0MMhhaC?=
 =?us-ascii?Q?8kHO3YkdvyuYW4mZ0XiKvlCyh0keiPv1evvMS+5FgrpCP+xYu97kCYv0a8SM?=
 =?us-ascii?Q?0p1wd3cBbgmtQubNifjJRF16WBD1v3C0PI0gI8Z+BbesO/6T5y1glYOMs7pt?=
 =?us-ascii?Q?pXFN63AC+NvYF3koK7EGXYxKMbf3zLu7HrX8iRVb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3962b6-a10c-44bc-e601-08da903fc534
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 19:41:19.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hWNKxJRKCYFTd5ZI1GHMmOUZUQE6yQvB+8Bmp3O243E6OLB7U0cQie4lejAUzACnMHiKwttOlImvwFUEVa6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2358
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

