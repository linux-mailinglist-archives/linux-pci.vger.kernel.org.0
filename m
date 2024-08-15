Return-Path: <linux-pci+bounces-11712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1DE9539E2
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 20:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C05D1C23604
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462E770ED;
	Thu, 15 Aug 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e94eP1Rk"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFE15B69E;
	Thu, 15 Aug 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746285; cv=fail; b=P5g3OUJAZzXZNVrnc7fg8sG9Vbjsxj+R9XHvFJJS6NYsssq0pTYBjgIfG7U91nihS/mR+NusuZGv4JzmxwH0rbkI14PVUBznwEvEwlSlj95WvPph4Da4MKm4vxp4/h2pUir7vZvK4YdpHsrcA+ycwlc+4+gXVhCIrPZhvK7rUqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746285; c=relaxed/simple;
	bh=0YM7JTEQ5yzNdQEcx092cVzaF8x29DOoGoWJ1Fr1GQg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ffcn+Mgvt8pN+hWUo4fQPeaGtt6B+RtY7LBH+ooS6kmwp7cET2zOMKuoYy5Q+sz17wlT7C8IFGGNlI70A5OBG21J+bbjB79aUoSMw9rDi3h+PSqeDdERfBv831V2I3vC/TmCHwO2d9gg/xiuPqu3VOPgu3RErMFz1fqe/YRWbmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e94eP1Rk; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdimTbL+3W6qAFnQhdNyJjWVKu1yts2TMh97RU41XuXjrZZXsWM3OG/vKIqkm4VGQJpg/wx9yaeAWSw6VOJLHFKcRkTtu+zP/C+VqhJCyRI9baO8Cbw5XPAx7X1NJrMKRT8+murxYQploeRG3j2pVlxH36u4Cb+7Yh1Le+M/cJT4LNPco28cS6OppeygecG5Tj6249ybTqVnC2LMqW3vBJmWqd9+0IQl1K245C4rCVkj3I5Bnb5wnSFcSo/Qf138DoU1275ETP79uVsa35mGSeBzUEOVMN8zNlpY4CF8RaAPyYV9aa/TrbAY7OE7Mq1+hv7ADNZPzRR8yDuhq6PyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NtYljWgIO+S6vIQTcC/GZM0+4tz0ue+1wyu7vMmLv0=;
 b=Un4m/3aa5XbON28/hM59tn16SLXdW8b1CMV1w2+oUzd8uUKm8RqsWQBkFhtljnTHIL065DfZg3wBdTgkIlD02tXjU33QvTAgiDv6fZe4sHp2Y0nI7gHVB2BzAX1jd6yxRsB7kMH3qBQ8yheBUbcINMpcyxQsVMnH9XE1BNRms6byP5eEPUy+vpuZ7C/bPztTImGbuvVmIjrYZmLjnv4zQF7xCjHqxoMGo64XX021zDAQcDt8kMKPFkB/+Ml/IRirRpOrJB0iMvLtI9ZJloZmoY1CxNu85xsyyECC9B+ikB/Fyx6ipZ9xL0T3huBVVWfw1dhYa6ZiXp3v5XGYoBKHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NtYljWgIO+S6vIQTcC/GZM0+4tz0ue+1wyu7vMmLv0=;
 b=e94eP1RkacR9SYOUxkFdF4Ah+WzDU6/1foYLGVFqyv9/sHF/2VqASsK2eN4x78+vei+TPGmr8uABQTrZLwmO74JKmb5G7AE7vC7F5H9OAhQFThaDMi/KQ9uL3yL+EledGuc/wkynHVsv0WMKQuzXTecbJ91KpeW+icHusgOBxBj3xdKGdX2iDvnPGz/7rml/g/Mv+T0S6Kmhg2gX6ODCbT4pwplDGEIHyTxJ4XzACxJPDPmPcSkuINO3Dq0ex2b1MdC5+LzDRJSH83Z/e5NcvVvjyzgtGNo2i3n73DT6jMGgVeX/lyUH7QlSMU/A3tlo5FRgGh8Ewx5SafjJnu5HDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9584.eurprd04.prod.outlook.com (2603:10a6:20b:473::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 18:24:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 18:24:39 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	Zhiqiang.Hou@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v2 1/1] PCI: mobivel: Mark layerscape gen4 support as Obsolete
Date: Thu, 15 Aug 2024 14:24:20 -0400
Message-Id: <20240815182420.58821-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d4b773-21aa-425a-66f3-08dcbd578665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CKSt81mOa1PCLa0B8EJv64dfNg17l5ZDwW7TIikFbpRpmhgP19CgC03b24P2?=
 =?us-ascii?Q?PxnqedeG9g93PZPRFlCf3pU9unswdGyJICyy4Oc0BLSVheLmTj6+C2fJn5vH?=
 =?us-ascii?Q?hkFua2M5pGuzTjZp6sUj1hK/varsGZipVPL0Gwbelr6oXXW34t8q08F6zoKM?=
 =?us-ascii?Q?aKfPO81LsBhIAsdooPhd1DbmeVWnxuC0Xj+1GT1CQ4SRFs+TCHHH7b8bsWNE?=
 =?us-ascii?Q?I2FIpseM9x4nC/UMfD4bv81Rx883lzZjsV37qXlbX84H4UX/ygNYP1vumJtR?=
 =?us-ascii?Q?qO59OzNO/tyxp010rXypIiZKABon7NfWbjql/ji/sTPvvNgAjjtNvmZ5cq9o?=
 =?us-ascii?Q?JhRUyFVnLqb6olAPvoSVvuYiloNRaGg41lscfUjDXBuO98WEK7dw8v8aKfux?=
 =?us-ascii?Q?6uivCpIQycJbge2df+UMcdj13a1F2OP/MPQdEYSdqggaESjqp5mdTEjJE2FG?=
 =?us-ascii?Q?+lnmWyE+EQVA1BWyFso8NoPHtcj112mAp1cZBCfTGbLVLMSKhZ/XGH7M941d?=
 =?us-ascii?Q?wLOMjjL5Aad9yLAyRsRa1OcW/ZbriNGmJjPqIuBnJE11Lh6Q/KP+82Iz6WRA?=
 =?us-ascii?Q?eZCHyAFucg6SO1IIg3jHEy5aWb8bC0coE+QlhsVUuIhvcCJ7WLMhZmBycbvF?=
 =?us-ascii?Q?1Nt18Bey6dpOdi3N6xx6g5Mw4zYxSW7rC19gFFsc/G+5gsa4AY/9WbvJYTDD?=
 =?us-ascii?Q?N4lDchIhgPIgC8vHutEvFrQHYAHDOYx1CsYa9tFRBMY1zRffLPVsgULEW0WY?=
 =?us-ascii?Q?tFqssDLAc7Ru8QQ1GEsfCCtb1m7sHiasYuhpj1KUxdiNXOi/vMkhJLiHnnlT?=
 =?us-ascii?Q?EbztPFzAeHpJFoBojg8aEycCMCI4bH13jN/rVAmV6aIi3AbaXCrqQNzpjxUp?=
 =?us-ascii?Q?pVvsGqseG2rREcRPyAomLN6sVOluUoWq7ZXZaVou54GH7I4c+jUMXI9kNN5C?=
 =?us-ascii?Q?unnRlPpSm/u1HIb9WsdQOAI640tvxg2LpJwUElgFzxvPyWbdXm6D7mmCinYp?=
 =?us-ascii?Q?Bqv4OONwSTzRb16KdDQeEdKgL1vTC1OF+Jg3ag1aDs/S79z2jyd6a8XI3Ak2?=
 =?us-ascii?Q?vh+Z7yytxo6bDpc5sLiJO+Lx5nFdXBnkIUNV/CcILudCipxqhaLn+8qxbUtd?=
 =?us-ascii?Q?+oAU7wxj0ZBtbjf5ajf59sriMse7xndYm42QQsJy3iJ19bRRK6nOsNku/NDi?=
 =?us-ascii?Q?+ugNLm6DoRcQMxhduerZt3ZDsvT7EN8Yh6Yvn85qqF2a4Y4jWkculI8aEqFB?=
 =?us-ascii?Q?ntIQB2MZgKaDGu/SDgEnlm4+yjXp9aRwfkh7/uqjegKM1rnazZWqmJ41p85Y?=
 =?us-ascii?Q?tpuxpsCkIkQ0GTCRTsobgDZ9+f2rqeXGqVrdwSLaT6V1k55J5OlvtsVeUmT5?=
 =?us-ascii?Q?xEkuY6NuKv3fJWrzJRs6UK4R8m+Ij1fbn0UNYDOyEVoAapHuTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?150R4y0ZlcheV9NjFbfngVWL8YqHatC4z56RAHZRw2/kDBU1ZasEfbAojg4i?=
 =?us-ascii?Q?v7RtYjrzx1tG5Zio5euAdJyzC1Hhd6Pr1s5u7UrVkvbuZAZG7Ky97CcycWEB?=
 =?us-ascii?Q?DcsGtS4G0P454H+0A9yMUtE6bWSVUXZs/artbU/QyfkUeRjMXUJyasWAWlA+?=
 =?us-ascii?Q?UgzZe4qlOBRmvBecLOiUOXSPN+oCKzZTHZkTeHrQT9e9vtXIuFtWtz9rnw4t?=
 =?us-ascii?Q?L/lpp0OET5Y4xUT76RSPbUX1elUs7OtcMUcxNPbUW1n/OUpHmuYVOSAP9p2F?=
 =?us-ascii?Q?7O/SPjMFlbcmWbrf452Hdfz1cvGEWQ89Y1O/aLS9NDKLJxCgM9Au+sA7FuSD?=
 =?us-ascii?Q?xBXzgDOg/p3+8lr1jCFhAEU9612sCYKCN+/zRSNyM7/VcZ4XdYD2ADrW0UMZ?=
 =?us-ascii?Q?bb6W09hrO+/e2lrBizN5OT6FWOpFr+82avU+X6xUGFNR7oThTQO1UOvSzH4C?=
 =?us-ascii?Q?UTgfzs0FA3OZGjZo/MsKg5OWCApLHzTx8KUWcGzRoV3vTBGy7L5JJ7WHXzGk?=
 =?us-ascii?Q?FwJbZtTay5W7RtEeFMnMSKmUcPDINH+JGwxjDQaCHXAxX83B2oJox0G68arE?=
 =?us-ascii?Q?3mtN7fPK49YRcTG36U7p88a3uQtG6o8p5pvc3jcuES98V4hpkqNQ8ld3dVgj?=
 =?us-ascii?Q?FhaQqBrd8Emv7idmdBg7zfqkho8XYno8TA00p8zAQQRYltGnahOkLZXUOgcz?=
 =?us-ascii?Q?L69N+QfsTQLoLxLeRIVDwnQhvAxfHKXmlqNYw/kEbyrUA/DYf2d8CwyzR3l9?=
 =?us-ascii?Q?fjdvu82ZqFe4ZbizEO45BKtf0of1ENkLaeOgGhSX5U1zb3k1qqxq3Iy0Cmsl?=
 =?us-ascii?Q?GaHDZ2Z2R9puITKb3EHJa6zazmLi0+/wG5Q6rCrdTOFVNqSuiK1epyJJL6F/?=
 =?us-ascii?Q?o8hB975hDzglPJDJk+XLO5xW8gk5yfLRS+f3stsujmCqfzvGRJKLtonwGGCA?=
 =?us-ascii?Q?oi84Ak/LognIRV04Hl5qyMjaeAj3L46EYhycc78ub7sa7+0LQ78GVcvelyeD?=
 =?us-ascii?Q?uIdCHOAeWPWN9NwBVD3qZW+IFbjTBPMtQBXeuekI6NKEvtLrMT7upV5IRpQQ?=
 =?us-ascii?Q?4njriO9dcafdFelRK3WHRT7UCnD9uhpgjMk1Gb10VmEa0fXlD7Cry0Tw2nbg?=
 =?us-ascii?Q?uaf75nbw3GhguFCLapy7HELiUnZq6MT5lUHHCmIcMp46vjDPxgvBWOAu/mkV?=
 =?us-ascii?Q?Qa7H8Nzp0A5sbGnwPAzSORum+Equa0VQJ4J4Deh68MwHk+toXyjieumC+c8D?=
 =?us-ascii?Q?EprsG2lRY8cxkKD9SL1qk1cF5CJCxvslbJyzccSCXAcCKv/bUoKAqm+mRhzq?=
 =?us-ascii?Q?pYa4gs00gKH9IrMQFSQHEF99cSELEZQLUtOQHoLASCBhZpD6hP8hmOWyybO0?=
 =?us-ascii?Q?ODzsRcOwd+0ITyOaylnPY9rPa+neeHQRwQQ0I8Cp+pQZcgc9IzxZkDzn6puw?=
 =?us-ascii?Q?fwOrDsJQd/rUeP1t9cV93Bn+yrwbSDGrc+B1xxLNW+WHFtUKVxaDQLC/EWRo?=
 =?us-ascii?Q?gM6n7gPkBD6+bjtEbMEZB/B3Y6k+s7RLkivEsPuTJzU5G2BVHu6t1f44dBBS?=
 =?us-ascii?Q?Rp+JxZ1oU9DW9bd5B70=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d4b773-21aa-425a-66f3-08dcbd578665
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 18:24:39.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 404erZ64dZfB29MLPz3JI3JY12AJRT94nFVlfGXslQkvY7tMfrPyejbezJaWhszJhIsETOpB2lhF2EYA8raltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9584

Only lx2160 rev1 use mobiveil PCIe controller. Rev2 switch to designware
PCIe controller. Rev2 is mass production chip and Rev1 will be not
supported. So mark it as Obsolete at MAINTAINERS and add depericated
information in Kconfig. Only allow COMPILE_TEST can choose it to make
impact more visible.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change v1 to v2
- make as Obsolete and deprecated instead of delete these directly. If no
one complain for some time, then clean up related code.

v1: https://lore.kernel.org/imx/20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com/T/#t
---
 MAINTAINERS                             | 2 +-
 drivers/pci/controller/mobiveil/Kconfig | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde383206..c97ca861abae9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17497,7 +17497,7 @@ PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
+S:	Obsolete
 F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
 
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index 58ce034f701ab..8f95fc831c3fe 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -12,13 +12,14 @@ config PCIE_MOBIVEIL_HOST
 	select PCIE_MOBIVEIL
 
 config PCIE_LAYERSCAPE_GEN4
-	bool "Freescale Layerscape Gen4 PCIe controller"
+	bool "Freescale Layerscape Gen4 PCIe controller (Deprecated)" if COMPILE_TEST
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_MOBIVEIL_HOST
 	help
 	  Say Y here if you want PCIe Gen4 controller support on
-	  Layerscape SoCs.
+	  Layerscape SoCs. It is only used at lx2160a rev1 chip, which is
+	  not mass production. lx2160a rev2 switch to designware version.
 
 config PCIE_MOBIVEIL_PLAT
 	bool "Mobiveil AXI PCIe controller"
-- 
2.34.1


