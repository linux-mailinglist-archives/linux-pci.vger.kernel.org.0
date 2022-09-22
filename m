Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8FF5E682C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiIVQNx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiIVQNm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:13:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F44CE9CC0;
        Thu, 22 Sep 2022 09:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/zmo8Nk6x0zeVyTS2LCv3zy/+gX4aw8l5Al3R+OD8y1KccmFGqMMQKlDt2LRxzqSE7Y1a8HqgQH0aTbcSAVAfhB/U/4rNC1Ih8MmspLJauppdj+RPdiOUod3q+WW7/YUHl1WwyEPdjRNjcfrcAEB8FnNYzKWSk4TurGCjaR7oSd1oxGqKxZ4iEYHsbCGWNwwgTftwInJOtVIjWz3vEBgsnKyNL/3K//j4CVXuaoFWJbUZw7iZAKxyAMjIT7TTMgKuA2PwHcp04OmA9lT9fwPBmGzqGKkem1k5Q1+UB3zTu9jAjpoxY0do94FP5lMPFSmWDesW9nClSlZPHjZ0dTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=lwmFVn1dPzp/4W8qRptzTeZ34eI9wcC+7avtmekKhXQfEeLwe3jeertrZqwttL2eBOPG45qpxzbVn3GNM0ItqDDhWvYrj4heGpqHH97k9RuEkVxApRhbeUwRSvyl0khyRggdp3Ydg7zPx1KymICsibN86VujQfNe7q+27D+DTHKey88Oo/yiA0QF6oCNv3B2UGTRlC0ZoC1Y3WpRwLn7FONniteIbE0DxmOwW6Y7nfR3ePge13h+7wpLV2zD23zGaXbuyoODDwRsFXDJTv7o14itHp99UvuyNfZzjEwGFWSKzLFMwhPoF47NqmlODvlw2yFrLJRX2cy2AMybn8qDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=Gv510G6rttoH24tUin5V31cUqP90ba1iRhuzMoKOxO6sWJrMTVurg3rKb7XcPpoliiCQ5Z342CzfdPjfxcF4uGv6ZXdV/2e7R4NCTtj1w5pG2Ho+JTdrafxf6FIPKE9s04Khe74IC4ZErnmYA2hIb53J3kVhwKZgGbEw/Z3stsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 16:13:37 +0000
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428]) by DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428%5]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 16:13:37 +0000
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
Subject: [PATCH v12 2/6] irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
Date:   Thu, 22 Sep 2022 11:12:42 -0500
Message-Id: <20220922161246.20586-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922161246.20586-1-Frank.Li@nxp.com>
References: <20220922161246.20586-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DU2PR04MB8789.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8789:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 719e01a0-125a-4322-b7ff-08da9cb56752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqkv+tJ5EVWUQq+hpZ0ScwAm4pOWAX/lAjEjunloBGrNIHBatfB7JtOQIiFssTYqSBhnMEhZWr2txJ4A+T10646hblJXT1yzQpT88BfWnj5gsYnVVhRTDJgl8ilC8tF8AvRZa09F3x+qnOuE8kWQj7WljvRLHXHAJfI8aPVB7GLhhQ/B3TFB9ym6GPRQcrer8TzXPX1qVB7zwUoNqifVYXYpTc2mxEUhtN4022nqO+G3nPZwTPcVAXtRJsk2bj8EkvfvJBSqhaR6/6DWpLVtZGOixSA5BNzo4NmeQUbREbv/L2uK+p9e7sU6nE4dQb/3V9pIny6tuuGO2/Hsx4imj21zSfmP6ZkrFptdrLdnaI4P/jsCZViFzO9ju4x1aOXqFAv9hJDcfqWGy9VbvSW9z8mBPdzRl1OjRmr+w4dufTUVt+ONIGmOFinDUH+vaLLlJ+vGbzuSbAQ7ii+NoXWQ96hkzT6b206PP3FttPRqZLSww5lkfduTnHMlUYUvSsMVsI0Dg9Pg2khdCaKW7CwieTxfeRDcvMe3ElHb6VCvC3iRxsycdUmN/o4WwEN7cbmbEicU2woeCgnEwXyNUEryDqRcE5gAlEwxxtrr0nj+vdLiAb4V+JOHmVMwojwugqTNe56AM+H9UlXUr8pE3SruSXX1+SDahjZbFz9AjMotpgczTPUi7bWjY+S2inxLGd0iY7A/fa5gZpS/zmcHm12+vww8zA3ceR1YiSw+bdnJbLRkrczGar1qxCNbVae5i1t8JqvSOHvsB0q8Qit5OmhiBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8789.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(83380400001)(1076003)(2616005)(6512007)(186003)(38100700002)(52116002)(66556008)(38350700002)(66476007)(8936002)(5660300002)(41300700001)(478600001)(2906002)(6506007)(6486002)(26005)(7416002)(6666004)(66946007)(4326008)(8676002)(36756003)(316002)(86362001)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qx7XT1iS+nM4vh1YwVjuPfuZl9pJ/hthUKpjnf2FG2uWx3D9B0RBlSpeYqgT?=
 =?us-ascii?Q?k/UTnh+5QGqUJINmCphx64T52cS58zk3LpGYqy0uNtaJmmHCXG0Ta87y/8Zm?=
 =?us-ascii?Q?O3+bjKGjptkEEmNzQStfVPKTtMHggEJqmCTn2ar+QvOQ0GFMUv2usaL2fJD+?=
 =?us-ascii?Q?9//nCS5bpOMC3NOeXBjGoAiDPm+3FgaoC1WRpEZHHXyud/C6XBiR9MEZFYSA?=
 =?us-ascii?Q?jOjf3R00jQVqu7LL/liB6MIQMTesbwnAAvH1iNB4cl0ALLUsvWY+iJLrg+J1?=
 =?us-ascii?Q?V+6zYmbzLIpn8qsmWgn7RWOktYYlhvBXTiQqAldZDXkzrSKP1UMVo/fH8O5f?=
 =?us-ascii?Q?t+6lGdtdlxQnDwZDnLVL5/NhNzwsBrYP67IemUWmOF/nWVvfW2Y8lsArAnXE?=
 =?us-ascii?Q?/r62xn/xSyW/LqQnsdo6zge5OpKocseHxV+ZW699l1D+AjfGO6VkpjF3WsaH?=
 =?us-ascii?Q?eP2F0Re4Ctz9ZRRUw0IMoWcCxvg+g79Q2iCNSo63N28zf9VV/06IadTQKd7m?=
 =?us-ascii?Q?VsmaZqP3IFKjzUQ5nIcPopVei9wP23XL/ibHKWHq3EHbiUgPJN5TbJfqy+Qs?=
 =?us-ascii?Q?oXouJk8qQ/t+CswPIq0gRs2wDCcLPBBI+4Ue8YZVgp8jc1QSLLRqX1mU6QvD?=
 =?us-ascii?Q?L5TF3n0YGCTpXHU6b1B9OTyhzO1vsjVrQIjiJAejCcPAIVleNfxjLT7gjAv3?=
 =?us-ascii?Q?xdQ96jz1g2gbdDAANVUtn4fEuSbXQL6Zwr7C8bJliNMcVW4+hyUudhBJT7+T?=
 =?us-ascii?Q?+sHL+COzqSI+sWXqP0GOgw7yWRm/Z2P8I4/ctssMzpwSq38bK+8qQWiOSBtj?=
 =?us-ascii?Q?G0kz2+m43co2XaQid9oJPffykmftZIxuGOQnO4fK6XgtMmiSkEFoymc8uNL4?=
 =?us-ascii?Q?kv6HTdaLW8oH20kVKvqepjoodjAbM0+VFt/BdrwhsTVObsPRrZMvHhI7SJ/J?=
 =?us-ascii?Q?kdtbZdXVMTmW7lx64m1tg2vZIER5t5kaWPQa0uZUTcx9UuAuavsfUoQs1PTw?=
 =?us-ascii?Q?rXcSJgjHltLaz2fjRV4PmGiN8uH+FO3m/2QIkKh8fZqsJ7o7/tNAwOJIfwae?=
 =?us-ascii?Q?YXrisODIn/EkGwjG5w52OfMr11lDeccbBnZ5kx+0CEa88jzoHkxgVjjfToC/?=
 =?us-ascii?Q?KKUvp6KotHfu5lRxfmJqvTgTfcd3GmYOtGye8WTJJsPZgajDz6Bqwv/KLKmi?=
 =?us-ascii?Q?QgEUZ2fblELQGpyyy9SZAQyP900ly1l1EqVRQUr6UxpEdRo+H8sEFe7caMIE?=
 =?us-ascii?Q?VrWZK7BUbIyHaUQA9Pv10JwGT+qam38CsUH5LMldzFfcDzIEVW4qFfjGIeOU?=
 =?us-ascii?Q?dXg7OtruXbXki/o/Bg1gKEdpBwNL8R4UPjJ1I4NkReKqc2/L3jFiRGEKKikS?=
 =?us-ascii?Q?lMlAMOda9RLV69yncodqcnJTHxT1tDa30g84gkPISvRGJUwb3qvohfl987Mr?=
 =?us-ascii?Q?clOPpBCfHCOA1M0bqPAy8vCzGJYwdIqagNnz734/ckERTDF+8LIqjMbWJUfk?=
 =?us-ascii?Q?0hWLdNF/hGwq4UOVYpv2tDYVX/WlY8lK3ZfHjMS7vLQsqIgHoRPdOUSFa433?=
 =?us-ascii?Q?zrKvXWJfQ84Q6EKZYTj11JsKcdKK9/dPZmbLFXCO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719e01a0-125a-4322-b7ff-08da9cb56752
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8789.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:13:36.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roD2UeHIRIjoD2yvT04LsLQBure2KsG5l38w7MSghcMXElk4jsKWQum7RnslUIMcvPRdempkrY9IznYIVFDHrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
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

