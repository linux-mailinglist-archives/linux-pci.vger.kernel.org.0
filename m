Return-Path: <linux-pci+bounces-9818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E1927B52
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 18:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363031C223AC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 16:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3091B29DA;
	Thu,  4 Jul 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YqZU6YS7"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6101AE859;
	Thu,  4 Jul 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111242; cv=fail; b=Fi47XR2lrlxRIAQtXP7HWK1nZPJ5Gs/pcOfmJWq65+EG5f95Mok5hEkmhNoif+fliGUdChLGJ7CJnY/4Zkwhs+A8ZrGNTUtENSCKRHjIkbU6jfG9arzl2cW3KysQibJTCJ5H5cjjqOCGIbxcZ6AzRDWs86Kb+Nn+NiVOdVBgcLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111242; c=relaxed/simple;
	bh=TSrTxfJQEV/vRH41CEqM1AT+jFmUNlsYy3Pjp5EbEgE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PRGBsX8ttwNeT+WA2gEojSl9T5geJGfbUFR1RL7r617lvyiKLyx9qwHUtk/0YDI5x943bWUpNHxxMhikNZ6V2Hj7a3YljICE3dr+DQpKTHBMMG8xrkj5V97HupVavuSJjNGrx3efr5wVYMutB6obZi7XyddlUq/xjOf4ImFTMY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YqZU6YS7; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOEd30xojylZDGVPG6aMnx9EX35JFfEQ1N/I9PAGF+VCrtb0UOyLAEvKVsjY69tBGl+qaEe1SbFvc6//E22C7aRrCQ65CeRmxpVxz20Gj50iiaDyIMgxhmhSTYom39rriAtwSwr6iUlOuxqUWc4cBgS9huu9e4Dx8/pUvvLXUeAN8j6/5S8zQQK3/Tgw/RgZCpfCMeD8oeIpBfqgqMuivk0mknabHLmtlyDRJrpFH4AYGDcRRbQTfV9zzJ5sll5IpjoRzaS0Q3YT+rc5147ZJfDQUX79MLM8kfsvMlypmF7elWfzI/11JAwekTtRrb3Z15VbejjhSdkFUVhJNKe30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD5BwmEM+mJwWfW4Czq3K7L7DWXG2AEbxcy0yyD+/5E=;
 b=ek59qbGX4l+xWlFmyq4L2/6zYyu14/zMLM29DAO0JMATeX5UGurT3l8XUhHtgEFuK2gdpLyxidyz55bMvP0hcp+J3sLAD1wDKXC3sRKAl32fMghmJwiyNPAw6wZQV/Ek4yY0oW27hQPDYjEq5yYzyciLGPJgJDBbWssUM0hg/hIldesQ6aVZMvDOGAweyFv70EerRq84a0LsIqOiewAgtzsfHWLRbqeDfDxQuRpQM4YZwqsDWKK2fVOWe0EXNywa/1f4/D7Jj/3TKtwmfzKgIrxTEKuhjcfj5rdhP3HHa3UNuscSFNck4MG5AYTS9IQd3XXaapJ/TTbZCBeQd6tGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD5BwmEM+mJwWfW4Czq3K7L7DWXG2AEbxcy0yyD+/5E=;
 b=YqZU6YS7CGQ5bpNf2gWC7t2S5gviBIofoVBjPlQKnMYSSP+RlgiwfP72JwfAoJz7Hpwh1Nzbae3L3nAqxtSlv4HtZ/ensCfNN5m1hFa81bUcgnihsvRUS5ZZC8aNKcUI0/iZkQjgAvTzA/LagwGdiobkexqgYdbTs/9s1GB8zxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7915.eurprd04.prod.outlook.com (2603:10a6:10:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 16:40:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 16:40:37 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR GENERIC OF HOSTS),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR GENERIC OF HOSTS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: PCI: host-generic-pci: Drop minItems and maxItems of ranges
Date: Thu,  4 Jul 2024 12:40:19 -0400
Message-Id: <20240704164019.611454-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0071.namprd08.prod.outlook.com
 (2603:10b6:a03:117::48) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e910ccb-9a35-4cf1-5323-08dc9c480896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WAQRMwe/8wcfBUwQIjYaglmsVIDuOqVk2cEhbLlMelpmWp5PftUeOJsw4S4I?=
 =?us-ascii?Q?DJG6IcSH+iIg2j1w/cBiA8eZqZ4LlU23+9njl668CafDWZhzqFiCKT7jT/Ak?=
 =?us-ascii?Q?ZVOHE488ZJUPekqNrWqXlXR4Lnv4fEJeqz8crwJPb8zmhlxyqe+krqlgaq0V?=
 =?us-ascii?Q?jPB2IF8qKdSySVzHjWv3mdz6jFhmMBIYX/FlK8rKTU2C5kaGWQjMdEvtWHPA?=
 =?us-ascii?Q?JpEQIkveYOqyO4MPL4yY/tF0+g/pifSvkbeuV+wB8v3ApemBQ6Q5beTBl4pw?=
 =?us-ascii?Q?HMDzmeH612fUa7MRPVsE58X7xSHLiqRiJ4HwH8E85dHGX6jq6/s7pS0PejnB?=
 =?us-ascii?Q?y70U4yUj4Gp/advPMUxOAgR8ctuX7nsquTnzhy4dVvmXJZFVjfFuTQ73ON7F?=
 =?us-ascii?Q?9kfJ+TLg2ju+a8xeJCKCYPaXib+whVN7cEKuYiRxNvkLWrVJe44U+Ocdsl1r?=
 =?us-ascii?Q?bBgOVbzUbQ4ytFlyNFpIKI38vdtTxMPXq0tQb9tinQfYF86HmB4x7433QRUs?=
 =?us-ascii?Q?/9NLpqTgNal6rgtKfYleo2mK8SR7wdKDEb2cdVPCmPG/fflt/xlg+eL0jHqH?=
 =?us-ascii?Q?VRfujdMt6BgpPsYcuJbJBoWRxtY/T6yW+sEyAF3eIyTYE7Y0M5RgFVSojE8A?=
 =?us-ascii?Q?ePCAOFOB4UV5OgfeEs7LP01Bt9L/dSIbXM2huolPq2dJZo7jZ0lJj71oaqmc?=
 =?us-ascii?Q?RGx5pmwnJFsFH17ggxWOeaSi8Z326/Oji2YYms9p68GCNyp99N5oeGe5HuQW?=
 =?us-ascii?Q?6b08zj2fkcOvXJWx3CPwEOsN+ycpd2jBhR2D1Ci4PcmU0lpJeU1FRkDFLuqu?=
 =?us-ascii?Q?FbQoG4WuGyCjifrzcqBkcD1/mhP24zHR31vhfchXqMh+7XXA2h3zt14YfyfL?=
 =?us-ascii?Q?U1e4wOL2dN4hRkWE0qobLd59a5i65UbQ6mMuzfnxQoiFkrnPdHuS6W3zU6ar?=
 =?us-ascii?Q?/BG4Z93Cg20baCDMAxADPo1goGwvdqOK5nB1NlO8R7L+ks3wm1FCcXw215XN?=
 =?us-ascii?Q?c8klwqycFsFspqxUWtdG7LLmEGsb/IFuaCnVAI24x6UrN9DoID7gl3RmPlMj?=
 =?us-ascii?Q?sV9FNzjg7GjKwpPwoKRaTdp5KRSuyIPQIS0O5eSqtSQr3hmeeU8Iz0rm8oOL?=
 =?us-ascii?Q?iWXUKAugFaYeJtgfEBcUECjxDJoLtil9CcuoD71xpBifENFhIO61eZRt/Zpi?=
 =?us-ascii?Q?wlxeSaZJ5+zwiRPWwrWbAim1Cc9A53Oiqw0N/0fCfIprvmtN2Zu6+VELcbh5?=
 =?us-ascii?Q?kL2BlQtBrpWRXZXRTn21mSGjTKN0+s4ssUuC7cgkTJzXfrnOLwbmi6la0zQM?=
 =?us-ascii?Q?Pvi+8mcfYdOAaNGE7YD7sO+vJN/OWaxT3os8mmdyBjVeCMzlw/nuPWehc4Bm?=
 =?us-ascii?Q?UHb0IvVimbjtYddGvsL37FWN8NjeXvybOA6ZU3ymsCL5hV4OAjYQZE/gKswY?=
 =?us-ascii?Q?dDAAZwmuA28=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+nP/4UXe9D73dmxXR6btC+lHtnlw/UHjRcHgT/6IPtm23/XtR5aRHYCFyaz?=
 =?us-ascii?Q?+PbgnepmMBxQGVp92bkJEGQiZ2ZN7pco1wqfxQ+AQYYEl+/W9dKqKk1yM7b7?=
 =?us-ascii?Q?OJrwTY1Ea7yTCkHP9N1uJn1cGpTI3JMeIuEdSidtObOaX4Qx4pAewgrTLiHH?=
 =?us-ascii?Q?AbCSctCBj422EnUF49IJYWaujByUlpJKeEQbJGPoeeJywkcG32xnkZzYWjyV?=
 =?us-ascii?Q?v+tmp5OBlUJNgvBXEHRRXtzAjp02klTKsOs9FDaF59mVtWkGLuX4UZ1q994J?=
 =?us-ascii?Q?gnsHZ9+5fB0k2lQQkqyTWtjH/lK8smhVaqx2vysbsFyXGPuJIRk6WXLV50Oc?=
 =?us-ascii?Q?W5VieWW8iS6TfkYiCP2oi9siCfl8MeoW2bx0A3VQXMUOnqvCzOsN+Lf3H33J?=
 =?us-ascii?Q?ZRaeCpEUGQ47MaI7EJdxYEDLw/Qr6NARRX0IVtUl0hyQ20V3e/Qf3Isi3+ZP?=
 =?us-ascii?Q?yhPYWfhKW4JekT/rZsLyXrDfaSrgBdtlWksTGDuFGKVBE8WepmA0t+pQq/om?=
 =?us-ascii?Q?ma1GQDL4ogO4/95y2bW5Lbn9BKeYrVFhxHt4vqdXwH5rboHv2osq60ccM5qz?=
 =?us-ascii?Q?zOVCHGBWQYY2yQtyoaVFMXkz8BtlJ66DhzsRNCs53qzkaHncV/Ybk0sc4Cri?=
 =?us-ascii?Q?ydYDyX+DieYO5efSwBKyo8ybLPSCQbkztQn+4G6tnIbwsUBlQ4nSrwIktZAV?=
 =?us-ascii?Q?nrYsPK/UzAyr4Fojb8yy+N1bp0bBLT3wupUusfgmthGDf6AQDnzCHMB6tV1f?=
 =?us-ascii?Q?VffoTAXJ1xREIN0R6Y0BGzutIubnN06SsAgfv7gtnig+YIISU3m5SkM7EnNY?=
 =?us-ascii?Q?kKTSa/2ijpRn208cDVonF1zcbYjGulV+5ayPwq2vG26fvne1lI3n8RhgTeUE?=
 =?us-ascii?Q?ezpT9LMEG4yA6MLP0rPMfjxD/9Z8n82bZfvszX14nhcKb0xfNmzh+cqYvjGI?=
 =?us-ascii?Q?S/fIoMwkokHxwVQqYPMJISpBxbazqNFT1PXpSTgZIfqQAiPFe28yWfkR1WA/?=
 =?us-ascii?Q?9zcdEAN73ABPEQOCIuloLDyGvUHHj3Q0k5khd2nMCO/JcRA/aOpDqjuZh+7F?=
 =?us-ascii?Q?PC7V4I2tUEm12TEVRtTut5I0cq5rrKKnTBOqp6BS6+erHMKJJ2YhArZtLb0O?=
 =?us-ascii?Q?yl4ZesCR3ePDpsddQTVbJGcDfHbeHwwj2kiCQfFHaGVS/Dn0kAvwuNFm4yFy?=
 =?us-ascii?Q?N/1389n8hQFrICaYgdLrJBgiwAUA+KHXAGV1SRf6nrR86GOGsmeJuIAdRiRn?=
 =?us-ascii?Q?3EHH0HFrHvV0v83moDDDTQ2G18LgslrzA5BcnL2DLQjX2oIl1EfHcKzAcLzS?=
 =?us-ascii?Q?vFv23G/oLGeMQ7a8+Qr2Muhx3yCvBevPEUqYROs0WOPspkfWft0v6hE3LZM3?=
 =?us-ascii?Q?KzEN4wt/cqzcn+pZkb4LbMMuhZkapbeZE0Dyj/KDlKcQe/H+bgC3Qihv7pZ7?=
 =?us-ascii?Q?bxpGgpXnBTUB7IDOfvUupE3WByRszzgnQ8xT7t/E2AzaO6hQfT2ukce3d2J0?=
 =?us-ascii?Q?Ozb5mF4rbkN737Fi8V+1KjGB6nvLk8mSMexyoL+DVeEAN2AP1dPSxMKy4rmu?=
 =?us-ascii?Q?2cdKCAdxySWL4STHWRR8qljbdtq50fJLTyQ06VON?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e910ccb-9a35-4cf1-5323-08dc9c480896
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 16:40:37.7652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Pw5Yyq9L5kzo2uu/d5qnIuMj/OLZShhULtb1ytaAdeyAx7/rZj9omqNn0Wy6PGQE3AVx/7kp1pUug1v39bSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7915

The ranges description states that "at least one non-prefetchable memory
and one or both of prefetchable memory and IO space may also be provided."

However, it should not limit the maximum number of ranges to 3.

Freescale LS1028 and iMX95 use more than 3 ranges because the space splits
some discontinuous prefetchable and non-prefetchable segments.

Drop minItems and maxItems. The number of entries will be limited to 32
in pci-bus-common.yaml in dtschema, which should be sufficient.

Fix the below CHECK_DTBS warning.
arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: pcie@1f0000000: ranges: [[2181038080, 1, 4160749568, 1, 4160749568, 0, 1441792], [3254779904, 1, 4162191360, 1, 4162191360, 0, 458752], [2181038080, 1, 4162650112, 1, 4162650112, 0, 131072], [3254779904, 1, 4162781184, 1, 4162781184, 0, 131072], [2181038080, 1, 4162912256, 1, 4162912256, 0, 131072], [3254779904, 1, 4163043328, 1, 4163043328, 0, 131072], [2181038080, 1, 4227858432, 1, 4227858432, 0, 4194304]] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Rework commit message
- drop minItems and maxItems according to Rob's comments.
---
 Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index 3484e0b4b412e..3be1fff411f8d 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -102,8 +102,6 @@ properties:
       As described in IEEE Std 1275-1994, but must provide at least a
       definition of non-prefetchable memory. One or both of prefetchable Memory
       and IO Space may also be provided.
-    minItems: 1
-    maxItems: 3
 
   dma-coherent: true
   iommu-map: true
-- 
2.34.1


