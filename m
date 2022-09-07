Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A965AFAD0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 05:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIGDth (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 23:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIGDtd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 23:49:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE5ABAB;
        Tue,  6 Sep 2022 20:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0gcD/1uL7+YLILB3Os93rADHsI1+TctGxlpQk2JObJQVCq3YMDb2JNJEzmQT5eCaZ+KKRmjbgvfbldf6btNGDd+DefeTugxHajciyRvYioduQesDo9wJ3UE2XWpDh0MgyxFau5D4I0ubuh7xHAj4UuyqWHVq6z6uVZfEIuMiuo+15NbsurtGHmNa++0rx8IwHguyCztyoeKiO35XdYaXggxjtNqk0TMctMfcTuHSm0a9+ilmnnCciuluVPo/4ql6pewhyY91gomDaqXpVPgoaixqHtFu+yPI9VynxIsMJI8cUvVM44VUkHyslfG+yueoIEGzENMzCIdzw3e4f/ehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=PUZ9TQu1iRaJw9DKBN+7MJ+fHIFbBHlbmHMWeTNDc4ujgJqD9A6FO4TqYJp/LrJu1ecZvXcsXMojbiVh2qDL2SYQckZMM0mgEhfhppgD8TfVqfyHj/+EHcB9lQd2z7Eec2jf77SSqsequWoyvFOvvZ4sr08Ba7214tuv1AmBMYVmqBziydjigUE95AiXz5A3nTBcOorPOffl7bn5vw12NzXBm3BJmM/YSghTZg5YXBlhJ60/Z+fjmoJZYlWd79hhj3zkUAq1owAdwfK0uuonXnDEmNAHT2JUjjjKTTKSWpVINykcCRLNoXUZFMzYPsoAhL8ZYX2QP7MnRyUsXDdmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=eHxZH1KYo0fD3oeiKR7HzAndSCSdVKgW3Z4WqKGvKwYxdTHBcNd1acCVY4z69p8wyXY8sZbmjEa5X9mKBIlyou9UM8mbScIsMim0ctFymSG4Qi13blV3rG5L3MV6rVFrvfnVg4RUcLvbR1AMEE4Wc1GfEY0qv/mGvq+OiYl86FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by VE1PR04MB7453.eurprd04.prod.outlook.com (2603:10a6:800:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 03:49:21 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 03:49:21 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v9 1/4] irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
Date:   Tue,  6 Sep 2022 22:48:53 -0500
Message-Id: <20220907034856.3101570-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907034856.3101570-1-Frank.Li@nxp.com>
References: <20220907034856.3101570-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:217::14) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|VE1PR04MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3b0c8a-d60a-4afc-ebbb-08da9083f281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlpbryJx6Og47SN77jrbxzpSsnJLbMhj7NyBtI6IN7tcpRnh6HrSPGOxIp8wFAt3XkSozti3FvljXZAs2wBVK19NGgOLc3ZSL+p2GlDirZEFG5IsPZ3uZ9HpekOjLU2D0Dr8IPkl8M57L3yixezXNPQNTa7alqrv/rfRhpTlocTlG7qU68UIiW+bAuyxx/Kv6tZBaVcgUUkbk3uRWzqCr4aoZip6JHu64R8UjsnLw6LgJx05NMW7jAUdvY0P9QO5E+XNheJjHdJCyVGB9BznL6DACoILV3lW+5yBA//bLgLhgbD2wTBWbx6VWuUHpIp5WMFH1JDgrWozpRTmlq9z+sprfLMVuo1D6wsbdogYlhMJdOK3mvp7tOZsaQL7U1sPbY2psb0/ooijdlCSZ2cXK632PkmVnYrDUEGRq606L2UZ1VhYzeRAabzHzjTaiZcqRZm1+LK2q84zwbpU1Oh4XI8R8tCRez1CsVaMxUMz7ez1shQuVfPsa5oVgvbcXAAZe+PL7LfzgelfNR63r3fwMN4zhBMTCWD7WWKQ0yESYXti+DkaYt3hkQ1fRUhBYlTcXEaWANtjA/QloJ27CXsvMT4T1XHR1WFRZ0kntA9Jtxn9lQuHFAMlycFXfEDASEf3QEZwGaQ2JPAVxsgLYmA9NGuyz2oDePbwsBnEovqR+RYF7wzqoN6pt1UuvQt+8lThv2f+E+SHzc7uYo4EOKpo9tGW3IZOp/Vm3L1i/9CxHsVsJBKWZMNqHAPXnVDGnGFvS7OqwEDmOH2/7r+3pWF6LesW3RRAkSCmNJU4kqwYwJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(86362001)(38100700002)(36756003)(52116002)(316002)(38350700002)(478600001)(4326008)(66946007)(66476007)(8676002)(66556008)(26005)(2906002)(6666004)(83380400001)(1076003)(6506007)(5660300002)(41300700001)(6486002)(186003)(7416002)(6512007)(8936002)(2616005)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dd7VE44AHANcJZMaI+l+cy9VJvxOrrp3h3LKFY6VdMWn5rGTHrxz/RNtPul7?=
 =?us-ascii?Q?axhzj0d1N7Tb11HLncJvYRKNilYeqQM0TUBVCK0+FPG4m/zBhAuwpUUmU53d?=
 =?us-ascii?Q?dzae8uPM0n4yw0YM4U/Zfny9q0Bd3rMWYEOcyBDaHKoxTbFnaxRnG35qbKRN?=
 =?us-ascii?Q?68vT5324plYp6QwTU7VT3dogSvJzVJdPiZ1kg2iLq4CgzEPAVNG4tLQcoQdx?=
 =?us-ascii?Q?zO7dvQDKmzTk72cP2UnwoogQ5QO6aoQlY4jpVhojMZbsKL4ILoqbomzDV6p5?=
 =?us-ascii?Q?V1sryb985Q5UqVcfGP/d5+4teWzxR6o5w0S2nrM7VNDSTOn9f6+zMpiC5ADv?=
 =?us-ascii?Q?cnJPXwVMCLlrbFW+TO831ZOaP8J8t5wyGq03hkMfNqfC6eY5+hJBeyCxpSkb?=
 =?us-ascii?Q?Vb9B6oUCIiW3Yr/QT3jVBZ+os9fpS+P5TQt60TwugHSYlOnLSq2Jvg4aYY+i?=
 =?us-ascii?Q?uJzvT3kwrzYRqNC7VKntE82qGlV/tgsZo4xyXhSu6Gfdek0zdwO2iKtF84r1?=
 =?us-ascii?Q?CRS8xtpYeOpnUFtSya2DMz8x5xfwbfjmdANZK5AXVhuSrjl0UYfmi52jsvTs?=
 =?us-ascii?Q?Gjpj6YTSd6xhCUxIPKUytnZ62EQGpyg1Wm/FmM2oQFAJuR+Rdjsy2y0+GXhv?=
 =?us-ascii?Q?Zg+ucv11VRUh0YIszl0gBE99qchPYNdmJpxdTM3/XSvGRvcoD4OYlPFGNMHs?=
 =?us-ascii?Q?qvDL4s5YbC+TKwuPyAIRqksT30LV5oFfhClFuEliWNX4JbAi3lAl9+6Ock6a?=
 =?us-ascii?Q?rheCEm7VgBjquggvCBhKy4BjAa2WEYzaXtI+jmBWcCPYj003y4Rluzo1ercG?=
 =?us-ascii?Q?vEqVOCxgd5Lx6zT9sw5QdWNQjuckWoWQoqduCg2BjQ47jXWZNJTeN2tyfpTL?=
 =?us-ascii?Q?IpPzaYD3ZYFdtC00BMZCm4DZvoTvWWP4vPw9oXPrGCjhF3oljHo6h1SOvcb9?=
 =?us-ascii?Q?5F7W8g+2DXZl/v0VwTwxYU9YKasMJ3H4nDRHL/iK/LV6ZjpsQO7iZEPvrBIf?=
 =?us-ascii?Q?lTnWu+ktxJCwZtiORg1FUraW8qpIEhmQcIJWEFuaZ3IguBwysLfpOwtxwIfk?=
 =?us-ascii?Q?gVZDhsw/P8wyh1JCVpJUhH01tp74EYLJxobo2/tIxyLiNjW6LKhT8dyQUzeD?=
 =?us-ascii?Q?fcO43vzONloTYlwqaKnboPHiunt2T9TPy7zm2CBmfFPO4urd7soMgJDlt0xa?=
 =?us-ascii?Q?/uck/PNr/WhIM+igqld70lkUx5hTBV7XvPpNJmv7q5KWSYOP8UeCe10IjGd8?=
 =?us-ascii?Q?tUpbIsvo1eOQWp4yKgKA+ra8fpm/W49q7C1EwD6H1aqV9c+fakEAq42t3VL4?=
 =?us-ascii?Q?ORTzyfSILp1obk/aqiI/iQ8slnaH13VDKZE19KJfBH6OUsQGJtSTSzKPjnFu?=
 =?us-ascii?Q?LXEn2IzUVRqj6K4SJL+09Vz9DwALvBZd/FqC8ffPTvKYGsZRcXVH0zV4Q1aw?=
 =?us-ascii?Q?FwpE0ZMRPc2ECxe52T4jxAmihXadlNgU/wFbV1CZ499FWnbnw5cgJ/ilh2OS?=
 =?us-ascii?Q?eGidlNbzLMOK41wqoIfPB3MgnVw2MgC22RNlGBZhJXyeCeoNAW0BSS62sLL9?=
 =?us-ascii?Q?KD6GRg3sMnbF0/Ycnf3v6NNNfiA59Vu0kB3ee5TO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3b0c8a-d60a-4afc-ebbb-08da9083f281
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 03:49:21.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/YsYlKWKwFy60NCEXfTu+yvzatuu7MiI/ZEVocyD7Zzzag7ZlRZQXzsFTrUn2YBicKwYOLPovJAn9wDTeNgTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7453
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

