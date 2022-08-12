Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707965916DE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 23:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiHLVxM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 17:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiHLVxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 17:53:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E74B2878;
        Fri, 12 Aug 2022 14:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/KBYf1B787dQ5XlppGZDrG7pXcKi9MGwEubbrT2WDHws6H1cmfMdzaAppbbqaIWzIG65gYA1xXlLWnLRilzd79wdsYCrNN0GaHIrBrvDFHi4zMLUAcDCoZRGb+AStH9Rv+zVXXS7m+kKH9EPUNEuWep0NX/nzzxIR0ChuxprdgX1ZRiUg5NQ+/Ql28pxTjQUt6pU6eJddSeHyaSnbBBqEvwZGGD0KoXbyRtWjv5Vbergeo0ODzYMAw5P8IO2sB5GmxNnVt7BO7YNj7foEa2HYSj8iZK10OQNcNzQmPeu7PAnFnmMYZCnCU2amATqXNMIMlwsnZeObl41ddUu/pjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=FoAanTK8OM6a5Wq28b1tHvUMRb3gYaeTFSpC2sLAxpi51tIxxcoUnl8xJQs22FuS1BMCFilLgfj8586nnKNvvQpgMbcpswiev+/HALZbiZpwGpy/bQ5PJlIhwN4XHSnCo0GjNtnqVEMEyd5I27lUThbHvemieI68iRMuvqG6gKxqRSC9nlr07q//F+5RbefJJlmfNBlHOjObSTSKpe+FgPSenqXfgdDtjHYOzy0fy/FpS5whH5tv9DduYXxbuAATomeTw+uMy/Rp+KRSDnnsH+s/h/wHN/icn6U0Xk4bSiTRgE0yUAoMTdWvZpJptKtkmgJpUVDFZkguFY7JY5PgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=MyIEQKoRQTmxCVleJ0vDTiIJCpCFG99w8WDJtp3+/vabNAfmOeUWd46bZ4VU2mqN/OmPLyRXsATqMJ92iB+NGMZS/NN38DvBElVFiOTxLil4N3xUL2tewC4GPHQXFcRMxZ8cxyWfwG1R39CKT2O1IsoXHQ7xMQR9urk79oum2W0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by GV1PR04MB9087.eurprd04.prod.outlook.com (2603:10a6:150:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 21:53:07 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%6]) with mapi id 15.20.5504.023; Fri, 12 Aug 2022
 21:53:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v4 1/4] irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
Date:   Fri, 12 Aug 2022 16:52:39 -0500
Message-Id: <20220812215242.2255824-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812215242.2255824-1-Frank.Li@nxp.com>
References: <20220812215242.2255824-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ed49ab-af50-45bb-b2db-08da7cad0a09
X-MS-TrafficTypeDiagnostic: GV1PR04MB9087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkptXFRglIjPeyeH9S/2WOemrb2wM9espkgrM20/KgIpc2AaM3e5MOpk0ehhUhE18/bWaFnesXGEJ3EwLTCbW20mk02ZMpeTKjw8geStfwJWK6gIkm46POx28BakO1qK9refHSH0qTuz3QQ6DmBSQipwXhjC596o5h5kPkkAa5tYWfpFTQgzyC2HlqBrB0XnC9ZXCzmJIw3tMdG8NXalZ1WSa8bN8MsM+Yxgj3VBlo6xv3c1KYZ61ZtI2A4z1zfVvcFje9X/Zb31n+N/aLmF17oZonDHCIiObQbTK17hS/LrshMrZHXXTcqdinTHwCx+/v9KhAbdxONl89kI6un4s4xtuxI/HVcagcEgYA1EblvIouhsgOEtzRMST3fObvrlhzfebfrwWAqSBhi30eb5iKykOPQ7bgwnQ2WUXQoQhUZmUTQd5WQ95zqLfxRSUvVKdNq9MybTmHLJCLAPLFB+JAJUNZWnfaNk0NO4JNxBB5vczQ+7BvP4UhOBpK9JFPF2x9/ASzNeYBdPBf+OfHeDm489IDvGgqnM+24CW3PdShMPmHPisu78EewqczGHm4Jxidfqi4/RzW9iOtGYYsiPjTSDkCZbajFSlDn92rUeG2hnZwZM3pPjquYYxQSpGrn9z7etot3QMNwZlF2p+ZMehH0rIGZIpdumCgOtst3iiHzWGL7chHJKQcRtBP3J9vYu8//xN+MnEpg9ZnEFShhfH7h5yxUYeqT96kpe5Hd7a+FHViYUdTRWZ9vUG158k0GAq9LnHfHZGuL2A6M7IEWS+hwYrHYLaAXM6aFFKP2s8im/lsTCaGsW5InCmjCE24UE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(1076003)(2616005)(186003)(83380400001)(38100700002)(6486002)(478600001)(38350700002)(316002)(66556008)(41300700001)(6666004)(7416002)(5660300002)(52116002)(2906002)(8936002)(26005)(6512007)(66946007)(8676002)(6506007)(4326008)(66476007)(86362001)(36756003)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ma5q1ICscRcHXm+xCi/g64UnBVutt2+cQLPtAM4Z2EKULXbvCnp15LkDC9TM?=
 =?us-ascii?Q?ch9HsKZ0DpTYX2Q+T6vH7YBTYl3dzDGs8zP0/soRK03yCEvbLPsveSgRBo6d?=
 =?us-ascii?Q?JCYzKk5D3Yt3MfmFg9SFAoHKerGuLCTSbdolhPjlrLd4IBCmvQgxOOPd2fYG?=
 =?us-ascii?Q?35BV9Pi1yk1sGTSMzSoSFzf+3X7UYHd7QC054K+0xrWrXI+/BH4OGLw2hFI9?=
 =?us-ascii?Q?lHpcDG2nqdQYhH1hksomjV6zPZfzuftFWAas5Wh85loC44vIYOnhp82LGJ9r?=
 =?us-ascii?Q?D0ONZv+GZQHlZtX+JvaSKKlTz+WAdyMukg5ZjLEUbOXk0FUpslVSzFiBdre6?=
 =?us-ascii?Q?N4Bb+sjTK30fMI9ThlfMQ0mxal0RoLki7psLfqR+aq2gI+OxaqLAlL2fVChH?=
 =?us-ascii?Q?GB+O26kDtHST9MHdgJN1IfLR3J5I/XBzsuRNLZwx/hEIg8b6eaUHv/RzB8i6?=
 =?us-ascii?Q?orIqO0XHn+5CQmKdDJj3oNVI3NJTmKkoya16oFXraQulw4KLJteqNd8RtnUa?=
 =?us-ascii?Q?POBIX5DXKrUZDMfbpxkRPlzFFBQOIpdJvfSb6ZnW1OVy0SA6bZRHAKiBNZM6?=
 =?us-ascii?Q?pqO2OvcN3SyYcQVGd08rG1E9q9puMpskF54R4yjbzM6yz26aVwEOI6j3xYe2?=
 =?us-ascii?Q?OYM4mFU3dPjCwxJYD0dm78ux3FGXujLt29rvSiyup50DvBV8VaeTx0r1Pnxm?=
 =?us-ascii?Q?erbcmywlK44A7vAAtCXQl+OihHRqvHHZjmp9mGhB0KpGxuMKV/Uz6rX4civ9?=
 =?us-ascii?Q?fSnhiJd0hfFpJ2IwefQ/F1dCXm3aanw8BQe3eOB5meFp0Zy0Jl/MyHxQf97F?=
 =?us-ascii?Q?aEWnR1jvfoWNRJa8PRI0w7FuMuWlA66uef8dYJ+aPCu688Dg62fChAJWhF9j?=
 =?us-ascii?Q?SXLIqvdDCBJThVGlwxXjw8Ne8lotCzr+ZABqHxrpnIwXcAfJ+RUD9x7k2rV6?=
 =?us-ascii?Q?Pl1H1eaT73GM6rt+C25pJtYqDoudt+jnByzkki4JwYf0OXMtJS+oDz8J6M0E?=
 =?us-ascii?Q?JzuezEh9SgaGDrH6cVb6i2X9kIOYQ5UyDwvsZn9S1k4zoNK0KlVHvCkA0p7e?=
 =?us-ascii?Q?DX3KyZKxy+MgQnRFIEHmgIoNc7a1CyA6iZPJQjmkZ2qJHOYjiHWlzldamQ78?=
 =?us-ascii?Q?NmDq8t4v3ugaAin7gersall53zyzsAsGlr3r90FDgWWFETBnG/1xuwDoh4R7?=
 =?us-ascii?Q?xCIbE+zXTMMj9Bs/d8k1y+a2D7toxxLuAiLaVb/C7Sn1HjHdqSYJHQ2ZZlmi?=
 =?us-ascii?Q?wt8JzLt5vF8juj4ypXbGQT/+2LIrhLSzvdrVaUpIlXTLHbwb8U8SDoyeP3fo?=
 =?us-ascii?Q?MD77UgvfgSSm31HDbwbzjdHvehR9sQzoVjJWgXV6L00XGq+chZtCftcot/ee?=
 =?us-ascii?Q?KwnXpCtjuDZIQTCTHGYE9zadz9QMir5Oiipn5ZSxyDHOVYmL9oBYxK8WbSD8?=
 =?us-ascii?Q?v2zRoSPPxoULCj7MJaO57WYgV+8ih/G7/W0g+EdZl4pXjAywA+r2Eoy+yNBd?=
 =?us-ascii?Q?4n5XP4v7hul29Ho2FYclzJDIK4CHSPuiurSV2IKxvaOl+1tTA1JuK6VXOln2?=
 =?us-ascii?Q?1LVDjUYseiX65XnccAc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ed49ab-af50-45bb-b2db-08da7cad0a09
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 21:53:06.8926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arj9Lk9RFI6KgMn0LJY+WYOuiJQsVOHWx/IAzZorl9OmyqXCi9DaPxZq/rYmjcG5Q+FWbulgo3RjyyPb3ieFtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9087
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

