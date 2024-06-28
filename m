Return-Path: <linux-pci+bounces-9405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E92591C1A8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABC9286358
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547BE1C6888;
	Fri, 28 Jun 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EB9/G2Pp"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52BE1C233C;
	Fri, 28 Jun 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586166; cv=fail; b=YWNM7/I8QKE9Vodee7+qMegaJ4DyvoF63zNGaRsDQ++34kuyYjoYwD2XyETVgHaMGCwP3nldIqlGAzD30ChGz0bw43d7XeBGtuFIzGv45p5Dn2xaLNXuaQhwgzRnXU9Sgq/bDVytSUkZc+UyxGd2frgaIh2q201Sq70L86knyYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586166; c=relaxed/simple;
	bh=3yQeib2LZZIvLbfSE0DTneIIPMlBBxt43c5GQbK+qEA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Gmi4v8cnph8t5/q/d0n9LQYPnGXZLd68erewI+PCy/f3R2+DMDrvDPYkX9Isg5QtlOHDkTLU1d0+anYQu3W4WVY9dxRcpO2770F1YLRdpOxHrnJKzvrRZdj0gyZgk0PYuCMHpxSVXwcTuzKZzTMerheUsKeIoovIys9P24PF1qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EB9/G2Pp; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG8VEJ3mkyGBTD/3g0hbiyWgYlc4gZI95RkzozZ3yE0nQB20Mih1M/RziW/hbUJHjWpND/igLO8YZqo+PqrUbc8a9DbTAZKRQNC/7eXyn11K05UAv+0tO0hmAT1U+dSsh7bZQLj92IoDjB8CP7+5nFH4vWd4xzNC4qWjxQ3WycWUdK2AwBTpVAGC8rEwsffgCPHip8S6YOozEYkI8DYtqj+IDpP0a2LHGVeVeiMD5hi98d08v411cPR0numQkkcPYgsMQXUWems5UIgJ+/r3PbBwXX/QVWkZNLH3AZTXYF1pyDr3FlRrW5IW7S94Tk0T4p0Lwc81wZmRSaJSIxXYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPfLqJBdsa1z0WzEcRV7ZcKBRqWkfJNRyEPQMC9UMRg=;
 b=HcYwIfwFt1mDPm8MJv++ueP8wWI86m/kDm7qBrot/poeVAZ3DdYJ6BccEhhiawYKp2/K6Bw/gtaZl8Tk6UmgszHdobpVa+iEaPPWxnNWJ4f8Yxdk2AlVxi6O7Yeg+Db4J6a3bco/6jOnIKYFZFapqFt/0fys4MLAtC1yi2aAoy76YaLYswszEw9A0sypB8KawabEKVe5xNYX43dGqrjtWrzPp0Wa7oJvWscKY8tLaWapqJSckn4rMnZCUnLwEzjjplVWC57EiioEMtLmFQYWrXVemUqAFTOWeBZn9MnCGgLhcxYaqgVjUwzIbmLVup/7TMm2jvuq/w6vMOM7tI1wMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPfLqJBdsa1z0WzEcRV7ZcKBRqWkfJNRyEPQMC9UMRg=;
 b=EB9/G2PpEQnAJEJGufZiG48QPrhnC6aKjMHVqW3kN1+DGzsrsgAFBgjrjKSWcxxaOAHup+RJQWmmvwxvb0kqT7ktN/G1iqGu5qcZ68JmmZNXFhdJvIo6IDdwo+eA2pfqVqyIa0CVLHKiLKkZ8vNWBNsWlFmTfLGkJwFrY/DFGZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9130.eurprd04.prod.outlook.com (2603:10a6:10:2f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Fri, 28 Jun
 2024 14:49:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 14:49:19 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: PCI: layerscape-pci: Fix property 'fsl,pcie-scfg' type
Date: Fri, 28 Jun 2024 10:48:57 -0400
Message-Id: <20240628144858.2363300-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8dd709-562d-4a1d-e985-08dc97817d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t33fXLvQjTlhOivF0ArDXXPmxvL1ttWCUWWGft+Und9rYLBXrOrlK/z8YRpM?=
 =?us-ascii?Q?CA1jUV+c9plFEkw9MBx51ZTsveMeP16CKJ4yNMNtsEXuytTP4wh0vtd5urmQ?=
 =?us-ascii?Q?heZ2lANDqV90W2/3hhne6RfwapejbhbL3laQZ2B54Mo8+5p6jKhK3ikSSF8U?=
 =?us-ascii?Q?mkRuGaEIfSZqklU1sk5NL2aj64JFJSEOULxfkwZQwN/zqOJhsrMs8NPfzd2f?=
 =?us-ascii?Q?6Nqm1Ocsf7WNkW8pBZkJ8eAOP6Jq86NSHHLkLMnYbrKtRv3pfVLZRhFA/3z9?=
 =?us-ascii?Q?UTvg2tmwnVc9F/tFKry2luQQHFdUiefMw6QTATFwYJ7fK7JicxYpzEN/hkSo?=
 =?us-ascii?Q?9l1ilITSfeEfskLjJFps2omszk3bpzpODOUzMZLqYTHe/1MAuH7zXjrj0uxP?=
 =?us-ascii?Q?ZWO4p5j9I4so9mlWClvBJpolXo2Hmw8HRHrKPHOPmZQKaa7QPF/8sTStyHVK?=
 =?us-ascii?Q?J+ySUSji97gTI+Q7y443AB2k74zJj1O3Za0+/1vLlmqum/LfFREQnz1mlBE1?=
 =?us-ascii?Q?zBigrgbfpjdHLSGtDt3oPXWtdYYQpmWpB5P2lHzg6gXJCktcuCKMBbNMNxO+?=
 =?us-ascii?Q?2Ahc8RXStl0dczjElQVb44ZgVAy9mGzPbd9Qed7B+Zat69RB/kxRGMCxotWz?=
 =?us-ascii?Q?KDzqAdCu/nIKbPEowZThn9mxB8Egiso0X/gn7vH6yUIWWhe9h0Ch5N7fcVCC?=
 =?us-ascii?Q?tm0reTlIFoHD+yRybqK6T76iSspFqq5ev/ZMSpXutvJXaOKjGPUivYPP30Zr?=
 =?us-ascii?Q?ZjnVEGlP5NVTnDnbi9YsDP4IgG3jI9N1gxz12UJi8hklZU/6TD/dL33DYCmC?=
 =?us-ascii?Q?C7DIC/VUi229jq3u1WBz4DqYShYynp7e3/aUTqnOt/yUmtoaL6/DOxcr0owY?=
 =?us-ascii?Q?QqdEzU52wVy6R56z2HZSVkR2Fc8rpGI162oto1kAs4DOAU2W6bZHOZDwcuz9?=
 =?us-ascii?Q?jJ+Vf6OKrCgjatC1UPpFNktlHtD+FhUCG2VWdPhzB4WurALJ9XIEzcAu7bqp?=
 =?us-ascii?Q?DoTy/UFFNzvnJTo4P1fAZrP+MmU/D4fhvdBc5Yc050sPFGV1tk+BJG14by0v?=
 =?us-ascii?Q?6DqGBulbS/OQshnoN4bdgQNTiheegg3URQTAMROy0NDvG7TwXjQKYdDLRtYp?=
 =?us-ascii?Q?ZD4TXOB9b/7wlWM5mCgJl15jtiJR4CkrP5Ky39+lxkuHTTZFeaGp9KKHfgCt?=
 =?us-ascii?Q?QYDoacQJFwuTfKH6BcpL1ihFH7mWUdmAqXRHim043XuX8ZMovQCKmtBeWNMk?=
 =?us-ascii?Q?RjXKXBuZC68obUCaNJvLtqTBIOB46xIfvNA/KVvkR1K1XIV7hHizFTVkTKBu?=
 =?us-ascii?Q?TzpR6ms03qGyJh/Fa3BAkA9lbcFfc6DlE8IDV6Eus9zzJFeS7K1rm21VEpb/?=
 =?us-ascii?Q?kxG10KE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mSD9GvoCUbVZAYj22ACse+1ZtPbq6v5Omv7J0eOOPJfXFYjOjtswJn3Z9B5l?=
 =?us-ascii?Q?ekicwxPads68Zg+SSqKjHf2IWh4Z7pehUBfjUlBUfttOldI4/z5vkZPePVr5?=
 =?us-ascii?Q?XaiLDu3U2yajD1hrusq0kfIHh7UW6M/nV5ApbtxAaL+8o/4iWJ9sdEGLtaMR?=
 =?us-ascii?Q?VGeE3EJFyal4gCYqxGgOfA47WIq83CmOIduB3JC2wvYlZz4jUHsCeWxfTFzJ?=
 =?us-ascii?Q?8MKL+eUckW8AaxvTtIxDSsfJ2i9EHCKZvUlLNuPXnehcTVd59w6Emc+TiBbj?=
 =?us-ascii?Q?omrjVqJXOHvwbM/LUSkAd6lUEJgtdSrV0T9zHdPCjp81sYmpe1HzbVGL97g7?=
 =?us-ascii?Q?WUHW+w7ap4d51Atfn7X1CAtSITPgSDn2BRrWwV8hV2m9wnSPHnGqzCQTcv4X?=
 =?us-ascii?Q?W5801TpWzRZPBDrKE2RjrKUBk21Q2w51Ln7mnvonV8v2PWWFyo+Qua83p0Ql?=
 =?us-ascii?Q?z+osFffLHoCtKJ4kdP9uDXeo1DGS6r3Qxjn62PjLRWk5+U1mT5jF3A6kHz0y?=
 =?us-ascii?Q?K4+c/YIpvHNbNxSk3haMPR67O+dwQydDa4VagKVEd7fMl14VfTqB9EM23a0x?=
 =?us-ascii?Q?1gsgVSxV831UybWNHDGDYyY5JpxgAunyVqBF7IuMUK09TSRdCUY5mKUNa0og?=
 =?us-ascii?Q?8TR6u3ED6UFT4CP/Dl9FfRI+Vl3rjxl7h7Cpoc5VzV+rzkpTxdHz0uPmoEqD?=
 =?us-ascii?Q?9DfI7QCfr+Xx+jwWmc0GOsDX05/2MLFFaZ7sMykjmcoK7Tq6PL6W6c/2h7xB?=
 =?us-ascii?Q?zW57r3KY5c9JaGtI+4Xh6OFR5Fx4Rg6hj3IG4Hi1ECNRVWAql+nBnEY3fdcZ?=
 =?us-ascii?Q?YBVu9shVB6vMzNoNSX7bGwvjsDrOIZI0sEu1N1ZEMNZo3CVL2RwMXZmtLmMq?=
 =?us-ascii?Q?UIuLSBtuRsqmz+mQe/vSVak4fbtoQsUwXyuFYDvNFeIZhR8LfMrP7FBipubZ?=
 =?us-ascii?Q?yuxq4xOzQY4JmZhesYCPefxTyncMRrdjH23btrID0jdBV5iX00Ucl7qVuiMG?=
 =?us-ascii?Q?vGCygvq5XSjjNxFEMLVC8Q9d5+GEd6S3pv1p4rQ822bEu75VWz9qF/kXNECj?=
 =?us-ascii?Q?9rAecpKRO0BC0/lXFFqe61Fc6epuYU+Gs4kxptGZTTJMSxY2G6muYs16J0PN?=
 =?us-ascii?Q?2/GXsYeU9KvfZT19KoMswyqqoaH4KLB7qZaeLjfpVz0SJDlMFvWRTyFyXGIU?=
 =?us-ascii?Q?Wh2E4f6UdNIrwJx/4/lyMsGiFgNPt1MCTcboIw6z+5cNsqJsQpNS7Uabjv6B?=
 =?us-ascii?Q?P697LxT3y6SsoXZQBen0xlfXcgbhyPTso83hyWLewBY9IUS/bCfJvr84yspx?=
 =?us-ascii?Q?PjgTrOrI2YifzBNUx7xyoR4Ks75K4dUA/89BA+E6JD5AQTj2ln32qPY1lG2l?=
 =?us-ascii?Q?63fYdsB76WZpQZyyKftgjYzMaYSbAIxK318zdwuJd+cnVTZj/TJU28+uhcXt?=
 =?us-ascii?Q?GJ+O3GQYeAJdZtNR4eLCif9fMImpT4OrotVYOK6mbIAUS2FAlZmVJKiwOqKf?=
 =?us-ascii?Q?Ulq/X8i2J5jmWbd7P8DjRsp5rArOGYqzCF6veYVPtyx+Qkp4xMmhwQMVZDjI?=
 =?us-ascii?Q?tbrmv9zm+hnBdfxlOxzGZtwS/vmjU6PXrSkPWmCg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8dd709-562d-4a1d-e985-08dc97817d55
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:49:19.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1c/sDjIKVNoYjAamtRQu1hMHbMq/Fh0/2upeKrHzpkjysa9q3ik3/MzQejQYeC1OUDgN9OTKoSNVCClg27BSxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9130

fsl,pcie-scfg actually need an argument when there are more than one PCIe
instances. Change it to phandle-array and use items to describe each field
means.

Fix below warning.

arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: pcie@3400000: fsl,pcie-scfg:0: [22, 0] is too long
        from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- update commit message.
---
 .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml      | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
index 793986c5af7ff..679c2989de7a2 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -43,10 +43,16 @@ properties:
       - const: config
 
   fsl,pcie-scfg:
-    $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     description: A phandle to the SCFG device node. The second entry is the
       physical PCIe controller index starting from '0'. This is used to get
       SCFG PEXN registers.
+    items:
+      items:
+        - description: A phandle to the SCFG device node
+        - description: PCIe controller index starting from '0'
+      minItems: 1
+    maxItems: 1
 
   big-endian:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.34.1


