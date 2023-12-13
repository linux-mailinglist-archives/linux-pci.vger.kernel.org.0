Return-Path: <linux-pci+bounces-849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F17810D6D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D0C2816EE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F37F200D9;
	Wed, 13 Dec 2023 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l2lVBEfy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1447C10B;
	Wed, 13 Dec 2023 01:29:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU8Yln7yfwOMTfZhisWzCYgYtaj0cn50Y1uCi2M71aY0cMf23F5o78oKN0rGOix9D5Z7K+z2KJkf2z6Bgcef2R8fy3ecoPKBPUBkhDC4Vp+Gvn+zI0KEUFQZFQ9EVlBK8SDHRmZ5Qm8D+Ap9+zKCdfn0fEuBJpxBC84eqRa9qVTqXg/UsvewJUAjzUt3LI4W9Eu8AKXVuOelqMFPIecgWkOqILK0JtPE0soKHGTtixVQHArfkNIuPp6SNpXB5QV4tleF88/XLkynrB9jaAosA3YT+AgmaFOpt7HJEP0jeo1es1SlXl/gLShd3AZYxaqdn4VV1insWTTrVkxf89jTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoGfmhiQWI/PSQLmPJdRfBLiVcEEYs92wNByii4Vz0Q=;
 b=O9mb4XF6xT+MUGkLwlVnRO+eNKOnkWZG9mZj9TZqjisaLZcG3g3ezbnGcBHfDBWejdemnWUrYrm0yEHw5hEIQog97TuYPBsKXWNlUo186W5xur9emfTgudayvXRHTxwev1KlJSHD+9cJMxXOMnfJA4lCD3o9n6UNwnYiuatWxRkYGcWmjKOzBbqi16/OCbspvnnwrM2zAEbeL00fz7URO9l/cBz791wXjk3qfMy169hIuucGtQWYq2jykgU/HgHEo/2LE0sFJ0C+dg1qb3ABiymCPpjiS+OSrS324Otpjdt1/tIQDx8nTQGzPtoUadCankZP+EX+sHkZDAQjIpa05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoGfmhiQWI/PSQLmPJdRfBLiVcEEYs92wNByii4Vz0Q=;
 b=l2lVBEfyFYxK451l6zV8XQv+hlUV1o4IaBguxIMy7a7TgV8TqQWFDR/JjquU+pqfccitfT5yWJUNH2yaD+PjDNoZt3/dEMId6rMym7BAmKkebkakUpMNup5uz6GhiVImKYu40ql1IJaPliyOvVb+IWRwRX9NJ7mJrvLifZQV5Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:28:57 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:28:57 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-imx@nxp.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/4] arm64: dts: imx8mq-evk: add wake-gpios property for pci bus
Date: Wed, 13 Dec 2023 17:28:50 +0800
Message-Id: <20231213092850.1706042-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213092850.1706042-1-sherry.sun@nxp.com>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: cf469b71-a09d-4c92-58d4-08dbfbbdee40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qc+ooaVxw44hWKMZtxYEmcXQQYtoaq+fm7QnxhSkbPfmPJfq8E46n2QxKXf/UiQDexn0+yGipRJcX4s7Pha9gXK5dV52BTlUCiRL6eOcWH7dV8Ey0iaiIzkvJ5a9XDWtv0rBKxI8gvOHN8br22pNEeNV4+/+sjRQWQidTTy9J43NShA8buFCJlo8Pb++j8Jcr3J3/I80KlAgIp8WizT0Pf/LwpX6ajQqqH35eTPVxaB0X3pEL8pyyEyVA7ipP38ZOO4MeTffeMK3oVeFWOGcB/TPY9yaOYOoqqnWFGbR3aNzDhWqXXMJhdJ9zODmmKILjZyZPS4fhzXb2xSWMNxVCX1+FrPBNZ1Cw1nm8PE9DaX6xrTtUvXESYzf8ZCfNWee5jKQy57vQGpt/vg/rXa9BfqM+9LQ23hnxcuyGcwkwU2pCuIGpPhEBYf77iY9gIhwTNwfpALV8oagA4fkD0fELE2VGfFqrm8J2GfykVkhh66yM+eaNVl0V7HZInR8LiKmutN7ENcfXFYzXBbdZ/mJzXaV+Vi9k804WFsMppX6QiOjknCuP5AIh9Qm/dieCOtARfrOscLWUGCjKvbW1c0NrwdIJOTbBdWc8SDY0migRX19TBYbh+hGKQ7QfLKC/eHEcydz+VyJoZ3iikz0vMbP/aT94ZBfCFo1+rwtW7RK6y6lbwOl+5xgIg208hE1d9f+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(921008)(38350700005)(26005)(2616005)(1076003)(6666004)(2906002)(478600001)(6486002)(6506007)(66946007)(4326008)(8676002)(8936002)(66556008)(52116002)(316002)(6512007)(66476007)(7416002)(38100700002)(5660300002)(44832011)(83380400001)(41300700001)(86362001)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5u+5GNTFBSLboJ/mJcM/U8ECtMuYd+aBdDkl8FjKAJELhjxAIxJMK8GPyfhj?=
 =?us-ascii?Q?lzjbldgnZygKSE0Yn//BHq/cJoZHBVUiMXwEywX4NdvzDf+gdjCW7uu4/U84?=
 =?us-ascii?Q?1DfsbUkuk2jo/xzodM/5267xXz5EMQJKTlpX0eqbBJCy4oUgwG0EplWMAVk4?=
 =?us-ascii?Q?mYxciSpFNlqd8R4zi84gyZoMH9YNqp6G8hTJ82YNP2RyzuuVDjVrlHboouk1?=
 =?us-ascii?Q?wP8Ffvo6OmVNA5/v/07AiTOSN0T01GI+Lm4yVsXm4tfkLi+UgPFuprwQ32oi?=
 =?us-ascii?Q?VHXR/xQzTFA8dYoytjY5wZ1WtEszz8E+aZgSxQSB0vzp8tNfgQErcGG/HukC?=
 =?us-ascii?Q?V/z1/GU8Id3YHYNXKAUV5+j/fP2RPV5VvOPfTVJXo8/z6rzNlIAGkHfda5EK?=
 =?us-ascii?Q?iJ5fJXN9/AJt70J1Jo7BlzkQYYk7cghG01t7F3zpDt0rgelf7CMIPoOcjU8d?=
 =?us-ascii?Q?FYiwX+2RxHQkV6XUSozyNFEeTHIaSANmz88xOHwnH5nd191oEXsd5GUUDDuX?=
 =?us-ascii?Q?DK/jPlscBfZ1QWbKH4ulfV2ukGjzFpvkpPCb/EIMsjwIeOCl3AD4hpiZ734V?=
 =?us-ascii?Q?Cgny1KJ+jfDRuKbxihECRlkwA2gZTRh6689l0lbsq5D5xXVHE9mpsp+1JmFI?=
 =?us-ascii?Q?iAxbe+T5VKJb9QRan8GD0eNGclJWalJXwnKdjE+k1bRCMzPKxmsZGyxLIrUi?=
 =?us-ascii?Q?XxbVv5FTGdfuz+7jHj2bPkjTmGo6WuxrNnoP5ZEHKZSCnye5zfevexswzF2E?=
 =?us-ascii?Q?pT37EFjXT/7puRffQ019ga6vNouHzoD3eF2aR97u+xz4U/I8IOdtquynB9RT?=
 =?us-ascii?Q?EhVoCwF0RSEpLLTyARaTUMqKV4yzgCScenQDBHiNOdSQuVdCrcjS4QSeEk6R?=
 =?us-ascii?Q?xwrh+usipraiQDRDqvt+hsE1gyyrUI28+5oapEiQZcthxqnso4EGJJHgKqZ1?=
 =?us-ascii?Q?Kz5JR1IZ4s22PeRLoU0WpIpOJ96expAkeSrmrHA8B0Zlec0/rZ/QjoyBILEH?=
 =?us-ascii?Q?hRbpayoFvYP3hLjLbXMyjwi3AOzOwAC2urKmMp7kxoW2FIBSlrNo2bnqwFHC?=
 =?us-ascii?Q?Vv8BE5mwZJuZy45C93VEvEeGCoeV9nH3zo51CggI3yDOjdsOHrhpJ8Kla2j8?=
 =?us-ascii?Q?bC0CPGhAnL9w7PPu/AWbKua3aKwvR6QpgB2Y935vQOV4daEpl9rUeIPtaa8W?=
 =?us-ascii?Q?ZUupjV4YsnNT6QjR8caxrjpbWYz9w53bzQb3v8VJgpFAIGLPn7JPyAstAYmy?=
 =?us-ascii?Q?BotkjkoxHEvjVLZf2sQw9/WIP7wgqSZx4WfrMvdIGO74kjEUdWqD3hHafG9S?=
 =?us-ascii?Q?VCaQxreglMFAKi+3IWsJiKAQfoL2XIx1EnmOSsWe2HIQqf6ZeUP7CfGhX5Ei?=
 =?us-ascii?Q?YgEtc5cEIdFv+FguLM4lKuvEi8Wbs9/tb2owC9AXUw2w1rrkmjKpK6dDFmMK?=
 =?us-ascii?Q?OrT8wTH353oB/XK/gm3P7SemX1yTo28IBY721Z04cHnH3qFpOAYlfBNSiIG8?=
 =?us-ascii?Q?Iusrt6E+TjCEYFk9vf0CISurLZV2pxkWKLd3hn/TkTNX1OOH3j9nf6q6UU1/?=
 =?us-ascii?Q?ISQExwFCQKV2eaXNdLwfkuPcsBuN/ngqvCGDJ2zp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf469b71-a09d-4c92-58d4-08dbfbbdee40
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:28:57.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeKmWv4IpBPnO/cvLcFSDCqsV7QVBfuqIw1oK7tQXZsXiq3fNL7LNaGa/UVdFUWoi659SUDl1P4dbRcyCtvxDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

The host wake pin is a standard feature in the PCIe bus specification,
so we add this property under PCI dts node to enable the host wake
function.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 7507548cdb16..b8463ef230c5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -367,6 +367,7 @@ &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie1>;
 	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie0_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
@@ -545,6 +546,7 @@ pinctrl_pcie1: pcie1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_I2C4_SDA_PCIE2_CLKREQ_B		0x76
 			MX8MQ_IOMUXC_ECSPI2_MISO_GPIO5_IO12		0x16
+			MX8MQ_IOMUXC_ECSPI2_MOSI_GPIO5_IO11		0x41
 		>;
 	};
 
-- 
2.34.1


