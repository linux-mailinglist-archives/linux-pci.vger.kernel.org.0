Return-Path: <linux-pci+bounces-1236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B06E81A82C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2408A28651A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE31495E6;
	Wed, 20 Dec 2023 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OZFoAmfG"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762864B156;
	Wed, 20 Dec 2023 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgRUhI3qmx4mwLKr4Okuj4hZMTP6oP1RZpmxxdImGp9LNKxzip70kcx/BP1qHr62LWLUtN0z1S4SEvi4tVvCXEKzIGDDVskkZEgjQ3noIlbttZhkNOdvBJXCMKMvEk7/KVdTC1W9PpipeHZPLHJ2DS9zsJPA1ngrsY15U16PEZ3jSjA5sNMJPcx825Ei2VtvsEkvF2g4xGzpvriLrgjFmsRlKTIB+tkooqpQEdMtZioXu83hNEC7J6VFNr6tp3vGC+QTScmriHo+mhBKI19tG/twD4vyw6+HzIw25op+tszTD+6YmwZMKEdoyDQU9kWlTPBQUKW61Yw98vUW4WViIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVAseQO96tZOaUPJkfC1eIUfavaK6Xr2U97e7xAjg0U=;
 b=Z1XdQqRUNB+brhmZzQ9kXl/qyjxFIGyI3d/JFNY9o5gphQByKpCniD5vE72EvDNh7sfJJvvQ2eKTzUGSR97jUj+JQSHsoGPimbGF3f4KZWJIoDKNa+UHVdfZRdNg3NwpXCpvPbMSutbarWMxM2vi4T2ZZvU6tBkg5zIKZG8GM/AgO3o+132htdH7NAA9e4JzWAg/i7gEJFpryO4EF/GjfWBmDwkZG/MCpn2IHHXKYkthX2jFvRE2N/+re0AKO4eBUYsZv0qU1GtcI/wSki5jhR+yodP6IqgtxBQNdfp1C9WskOikJIBV5rh3aYEnuHnV8EuMz1xFWcIUFrRbrIyGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVAseQO96tZOaUPJkfC1eIUfavaK6Xr2U97e7xAjg0U=;
 b=OZFoAmfGUHIvhQsMlirlBvVTrQXKID29oRBYAXWcsVn3DZI3CD2MEIpyd8B1KMmNiuYV9IW2dgeKkRwGX6JcyRbnd+o+taZTvguPk5n2XVg0iMrsFhLgiPTCR3g9ua6nNyZl18OWht6cdbb1u9SYOyxM13Vi9XTByukGS7aPYUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:03 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v5 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
Date: Wed, 20 Dec 2023 16:36:03 -0500
Message-Id: <20231220213615.1561528-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220213615.1561528-1-Frank.Li@nxp.com>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:510:4::25) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d851470-3fa6-4dac-bcfa-08dc01a3ce03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sko3Jn/IFPJKJD7GBzyDidKVYQOYvWoTPJ8fRhsAbuazduo2z7aMaSL7IxtDUCLeN+f9j6KCKPte7cvCbvoVsB3x2TekbUR9CjZuCOqHp6itKUrLjZHH99LjVsudZKUgVAUv8wWVcD8AhpuZuJSVCYhmLGacZ2MqN+AZjWa7j6z0oyMu7KwtrWZy8fvHAD8nhjuTxfajkdC0G7CCRmyI8rt+5+EegQBFL9DYV6wLn7+H/Z1vq908Wcq1UnvoCHDk1q3EIN6rjFWPz98FJMqex/plrEVTOuSV4p1QdsIEmc4h5WW1E8uDeYIdmr1BsNbx03n0fu++c1m4u+iodGxn7gtnlS1bn2DFdMexTSEH0cKoUYP9aSc0shkENwgWDatG6ph8HyIxroET2n+KB/eWZFVpT5da+6It9NvvWPbtBAczPBDcxiSVtkndWNSfunW5Xxyq5o6rOxuwDgeadoS9ibXeVyt+BHIXyhbRz44v6WCehzQretU0D35DVlMrwdpLIcLnTaPNUp4t63FuesLowoG7R62XPodxJohjGmvXwypQPBQ/4XicsweNYByoDv5lUtWNSPMaJA6LfsRPivk2yd4a9cINZTDDUbSoTQ6m/kAgs49se+cMomtGADFu2BLupLZ9Mbh1EFmO4ZqrCg59CA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4744005)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?07FJaHelMkfersKeyDN31DriytPAyJ8sDp3gZGVFVl7ECTM9VA07/4dGRFXD?=
 =?us-ascii?Q?rStBPygpsE7N8nEZPO8uumkTu5tci9RHH5rB6N+cHt2anYud7h5Wt4rY/IIA?=
 =?us-ascii?Q?/ZJ4rQ0EUsVNMR7wwZptRYfxCGXe96v8KndTrJazOs+wQe8kYpMk6xbbYgzi?=
 =?us-ascii?Q?V/viSxK1HhDemx8zC2I60Z6iziPp9UuJVSeGMfhC/wk5HoTcFGuqYlkkpSV3?=
 =?us-ascii?Q?4QcSxKzam79EkNg34Pps+OWDbJvIyvX4bhJtw8cQaiNk15lxGqbAKOEStl+9?=
 =?us-ascii?Q?vKJ7OwTMBlK4qqQVHjS1EeV343bzpf1t/8WdbIYxAo0DKSoY5afxn1sWDLjk?=
 =?us-ascii?Q?kJ2EUjzJ0WslUS0vpR/+bFOBD3I9YmTGdDR2h+4crncm6oXp6XCgL06VgmXN?=
 =?us-ascii?Q?qEflgodKHxwPGlxm21DP9yS2OgXcEUrT5ZQ15sbnGmTTbQiRDqZR/Qc/OPv7?=
 =?us-ascii?Q?1WQ5zN8KNqlq8eAjnfhSm1awv/PjBWIk4GnhsBcvl5jdVxu+Cs/pjh/ZJFgV?=
 =?us-ascii?Q?m0ZsdpWFlpuXDG+w2SWXO2dkhbuQvZA6bARu7lH+e/yuak7QnLVPr5fPfYgm?=
 =?us-ascii?Q?a/wmlBzrFMMV5keUevwIryncA4xVDqyMnTggaNNDPG09ytcKuiD8cyaXgINO?=
 =?us-ascii?Q?AsHaE3Vyx+/nzdzQzXMsXYF9ummz4y+9UmPYbNHaz47/y+dtYOmAa5Y0kXs2?=
 =?us-ascii?Q?ae8EURqLJ90NPDKTkA5cDudCdpYJ8lw15FCzsA51/88p+6Jz8Mlq7XIhlEPd?=
 =?us-ascii?Q?URVC81TAxmvbZRbM6kBA8iomVdaeiQjjL3XdJeqb9lJf98G4syu4KTicWos4?=
 =?us-ascii?Q?42ogZ+nfq5D9Kf7UKl1qb/34LZAcSjZrZIuGkX83StOZ4kt7zqexaXj9VUzI?=
 =?us-ascii?Q?pv/FqpbSBe+67n4Vlgo3lyXDAADdCzjGd0JLt8Ut1YmR45AEDNCRDKV0f43i?=
 =?us-ascii?Q?L8FBPFZh0ihFW05ycCn/rZDKiWW4Pjb3Y/32jEGT2T62EHvICkO+0VlCZ5PE?=
 =?us-ascii?Q?IlfWK/sxhzxqi3f7fl3bYafJTGkK4jmP6frT7qlBM0gG8SRbR+xtdGHV8pJw?=
 =?us-ascii?Q?GB/C4Wl4qGsHRV7uLioYrmlOOn8LXvx99HHPDIPXa4L3CgVwS8aujpgGNmGo?=
 =?us-ascii?Q?M7XNYXSOGIk2U0+7SjRtSbaVZLZDgiSQpT9F5SmmShxU/jr3GMaVZnpTPmFc?=
 =?us-ascii?Q?KjBgUkvD43UMqZ4vUwRjYXvKOcQywRbhwXvVktM2gj/irr0l1ewnwO1y168k?=
 =?us-ascii?Q?yVkcgJgt0G2BIhdjFjLcX7A0DGfuCmU8XzeaVl0RQJr4CvD+z+Tf/wgA04vr?=
 =?us-ascii?Q?AUB+/cI1FPrwszMKinj0v57WLCE8G++8osaCWMw/B49mjTI3eYGU+JjrzcjN?=
 =?us-ascii?Q?QCxFZkLA4f0xhuYHci4kFTFiG9W9j8UetAVoHsoOW9XYrNkPiFR5WeDaGACm?=
 =?us-ascii?Q?Q+UH864VB5Z8QEd6A9S+GyrAioCu1iP3nUdgcE9Ad+Ld4npM8l4AdGZy7Rtx?=
 =?us-ascii?Q?PjCfg+6hXQ7OGrX+VA6/eBpEDV8AB4UxYWegej3kaulvKU72AQF+5yVJ8bR+?=
 =?us-ascii?Q?Xx91e2x23qbJTLKt1Ks=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d851470-3fa6-4dac-bcfa-08dc01a3ce03
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:03.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87GIciHPQGz64i00bL2Ogz7NthAYAfK+ZHzeQoe/69j4sfsvEAEVfgditY2KX//TlCJAXSskFqHWV7EZm8QSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
proptery for iMX8MQ to indicate pci controller index.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
    - new patch at v5

 .../bindings/pci/fsl,imx6q-pcie-common.yaml           | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index d91b639ae7ae7..8f39b4e6e8491 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -265,6 +265,17 @@ allOf:
             - const: apps
             - const: turnoff
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8mq-pcie
+              - fsl,imx8mq-pcie-ep
+    then:
+      required:
+        - linux,pci-domain
+
 additionalProperties: true
 
 ...
-- 
2.34.1


