Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE9B59C36F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiHVPwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbiHVPv7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 11:51:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ECE2A405;
        Mon, 22 Aug 2022 08:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUs7QL8ZpZxpmGar+Owu6dQtXLU32waQ9iSqEznzP4Hks7vy6ab2hBMb15d2cgHFX9RKgqu0MgfKmEIJKRVYGDckcK4BDA6Gnqk304KqZCNMizBDTagkTlSjdloNEO4Z8lT4C68fmc0Ew3HqjmDw+NsxaCrhqI9j5TpfEFaoFEAky/uYIByqxFctCK9ULZuXG+FAni1aojMZFQIL3PAUeXVXzPBiJ+vDRImwe6MaY/COy5fiO0Xcs0EpMcpIJCUw8SKmxx8Rd4znWcOzxAA3PFMGS3TSpPjxtd+EDoHZfoBjMy+8HmkuXM2KDhoXZV1CO2j651L5yyRWsthdAJ2XqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=Dikqcumkd7XqHEv4EE75dV8DcCGDYPCOl+DFZRjJljsDs+xwwWTLasV/u5aFqdJofO1PP956v3DkTv+cv/4ZtsttloivsY7U5/D07F7EJg4X2WopqgJH3hIRdp49tjQI3M9hu/0v6JXAljrLr+qJYpQGyzZDuyhv5ZTK1F+FBZO2F+GUkLwhuUtFvFdznPFuFrKSM56DwVfNeBqjheN6XupHHoU0ryKBLCQd5I5EAeRCWshR4fb0MxHAU5mLPuosjOQuaTqUwAHcCu/qtU/9Rn0exaBZe8JihJVF8Gny5Ph6Z68Yhdo8+CLGCIz8xcbvozDPNEh07/mO+c9YZOrXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=SJQxXqvLjX+XSHQ5UkT7cEyYAfgweYGFc4WGX6OYDzXgNHa1IiYpOVsnQBCrxkO6bjc4Y+/GG4wu7OHJVwlvSMGfYLjsrUsaAJ5rKNpplpVH5iEy4jBYgVGX71N12lY1dmUFRc63QeDz/vzcJW62fz+d1k7IXjYZC5mZRjkO4+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR04MB3169.eurprd04.prod.outlook.com (2603:10a6:206:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:51:56 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 15:51:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v7 1/4] irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
Date:   Mon, 22 Aug 2022 10:51:27 -0500
Message-Id: <20220822155130.2491006-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220822155130.2491006-1-Frank.Li@nxp.com>
References: <20220822155130.2491006-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::13) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a87240d-ab7f-47d7-ff0e-08da84563d3b
X-MS-TrafficTypeDiagnostic: AM5PR04MB3169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPPIsPsOOERtJWwdaXcDZRmynoSCL/xVRq/C1pS0vzBwYtsIbhlN47GzttE/DkPX/PAhh9z+tDX4c37ZJjeb+2J+p43Xgae2Rs8OvrtWIkxFsks1B9g0D+8o2jmd2xkat+M+49x6B0U94WrP+C5mzypsNySMh+1gL7EHtDixTBb2TSiAM4koBaVHsOgUt1gByfAKqrRoPBeD6MqG602qb8gZAJA6VBCBOCvtGs90Ymtbq2GXPVdzZUUTbEa3E6ELpMJFtmBzDbY88JRKFMRlXg2Mum0mgSoTcDBXpiKNGd1tpaXPGYA/n54HcGoqE+z1OV5wa60z7Pp1f1UXPeNCJTmtYHEbe7ocO6Qe7A2COPZbQsEQKIA1x5ljxLKRne7GBGHPrsjYqCAXPLRnCrVeY4mVNIJ0SwD8zwpwRDD97uobGd1iOcoHiUrsr0paO/ZXMO/lfHX4bft8lxMU4s2WsXMYcxzUiJu9GhhJ92TnA2S7TFcmgnFFqyVH50pbDojcoCBOcGphvRCI3jrugN8dUjNqejv0AMqgO3v2ruDB4o0xS4p2q92Cctb1KRK8nqVm43BT+bXc0aFoyWyhP3fhaD4Y/T3gvi6yjkrgeIwUL5dSx1s2cUH5AxhV0RvsUuVe/zMu+TzYiRZVCGCyNIq3viduv1X7R/HttxkQvuJp0CSjDdqqhPOhd7bOauur557+uMm2slybzo3FuPrgHDQFzCSn8I2DCbYmfVfllWabVflxLtWJj7qxcLzelR06Z89Hx3yYSklXReiVTRduO8wwmNNBQgZnBCqvSjHgJzM6JOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(316002)(86362001)(38100700002)(38350700002)(36756003)(41300700001)(83380400001)(26005)(6506007)(52116002)(6666004)(6486002)(6512007)(478600001)(2906002)(66946007)(66556008)(66476007)(1076003)(8936002)(5660300002)(8676002)(7416002)(2616005)(4326008)(186003)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9if8T1RyeMSLCo5bZJcey4K7cKuWNjYy9L4gBAGhqeAmlBJWSsq0+3FpdZfk?=
 =?us-ascii?Q?F2SWP9IPr6UuqCsks2Nu+gHFpvW9suAnukfeEPOCY/0/pC+zlaVYUuet182W?=
 =?us-ascii?Q?TKc9A0w9JT+efSeQvLNo/JX6+KSgxTBS3lCHkRHV0ZvjGhZx+ofpBGCaQfNv?=
 =?us-ascii?Q?KCCn9qNl3TyOPaQcoaGUDThDPjlAjBbaE1i2DqMvuehJIIQxhxotKbZZ01Bm?=
 =?us-ascii?Q?Sq13DDj1F7DuvTejK0HBR90Yq6yiXsaG95nWy7g6TFG6VUER26UKQluNJyrN?=
 =?us-ascii?Q?nFqWqJ77fGYX8ZlJhzEl2Zb1h6IgZYfEu3R+3emTn+Fp5OP369y4+9jEBUnU?=
 =?us-ascii?Q?7JBbvC8NlDLXp7X0njpX25eUWM9GJQceA3X0hWjBFXK1hQ9J7YXjtlisvr8b?=
 =?us-ascii?Q?U5jTmOYKgkkRS1GkmH6KIumBf6BTXo93dMPnc6R2M7wqNr16DIRAS3Dc4XHT?=
 =?us-ascii?Q?LiOBkxOeTLifjLw2MFBwvAyKQ6TNlmS6LT4owdI3LOm1eZdCDJvJk46g7Slx?=
 =?us-ascii?Q?QCDijARl/W7yg9F8eDd8GOh8hu9V0hUOl9y9ci+yVXo1kNLvM3kGUt3Edc9u?=
 =?us-ascii?Q?0TW35enT+baEycOvegat4SE8iasmTQIifpliAV1p4zDWQfQjtPVfAsuoqZGE?=
 =?us-ascii?Q?CmDxN1obwP78PzJ9UofNVLUe6i4PMcucvScxAJr3CgQRZZKv71zJ0Jq9ImEM?=
 =?us-ascii?Q?5TgSyTfeMvbJCDkEh6oZDemcg5+0impRInP5tG6sn2ZVyHXiw+eXLfqwZuG9?=
 =?us-ascii?Q?8tUujXXzIMzaXICgq5YwV5T/2nPGzfdAzZbI8qcwUPCp9zecqHcX/6X8Sdtf?=
 =?us-ascii?Q?vOxr2mPFyriQ6TA5OxVfLBbn0AxXp9TNbnWmAH9b7Jda8scEt6rOGqBZ0OO0?=
 =?us-ascii?Q?TX2l4AYy0xVRv5EZAQwgO7icVe+wxjAvFKGNa+QnkWuPVZaRPbpt2yFukrYp?=
 =?us-ascii?Q?Gy/xIStgdzzgLrVPwuiG45WMEJ3l36bPnb4RvHtISHa0z7QXEXPmm6YFyRnV?=
 =?us-ascii?Q?R3apCd+RsllKn8FL5iiOKCyqYiB2b+/SZrJpyUUtZbRSdmxkuAHXV1N5l5Do?=
 =?us-ascii?Q?XrSbkpxni+eJOm87ni9SYPjqKOdFqyO1aFl8WLG3Wd/wkQXmzZcYxBHsr9NG?=
 =?us-ascii?Q?g3e34qa7R/k3ibmTpXu80j4VjjMjkmGfuaynYAMGkXwczL97d+eYEy26WZS2?=
 =?us-ascii?Q?ZnO8Kur1DyWDfBwLAVv1EE4O0/eejR7knDsh3eP6EecXCfWbfeTu1NGCcwpH?=
 =?us-ascii?Q?Kn5hFm3VT0CCsDQRoBDEDtFwNcewq28RypdjSaMdrGrxks8XPaWMTgwdTV6y?=
 =?us-ascii?Q?p9s2gvsaZjXXiIsU3yZ/tCfS2ZfLrNtswDJi1FnxJH1/PZiwJuiaduyBlTEP?=
 =?us-ascii?Q?tdZsDiSs+7O6cTHSmPY8UzJX1I+jEifs3nr1XFgcnNCnDqiIaQfM8t7BdHl7?=
 =?us-ascii?Q?u+mvmKfJ7ZBisUDkrq2xNipavt7vw1udvh7bSaFW8WZkLr91hrH2zCnaFvmR?=
 =?us-ascii?Q?fI2tsjZ26igneCAbbw2FXUwESYvD1ydZxmImANA704NBgPbghLIBFlTh5QCl?=
 =?us-ascii?Q?Gm8vCE3FHNeQKApS8uX/EAyvAQTw+5VpCJalS9h1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a87240d-ab7f-47d7-ff0e-08da84563d3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 15:51:55.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKuN8th08wS+6nxbPdi4KgOgOGBGX8T95ja5vsiQV/n4n/DASs1gr9B+uBDe8XuM3BeX3u4MAC77/VQHLB9xrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3169
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

