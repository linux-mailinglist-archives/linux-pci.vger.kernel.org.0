Return-Path: <linux-pci+bounces-31748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2ACAFDE5A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 05:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579894E8571
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE921A43B;
	Wed,  9 Jul 2025 03:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wi0iHWMG"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011020.outbound.protection.outlook.com [40.107.130.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C11FBCAA;
	Wed,  9 Jul 2025 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032386; cv=fail; b=EYJeeBfAE59DOKIaxQi6qVzxk2t7fxI1fxYdEZdto71Wm7yUpOTlz4UdNqJ8GOHLZkLwoWAHny132715Q2A/xUPdljYrKVAejSRp30+9NJO62YQZ7odqvFAoIXiUjUQJCK1HCoBXMIyVCMGcd63Q3jd+VL3tE1TaopKoJol6LZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032386; c=relaxed/simple;
	bh=mJZzAgrhR/rmprBD7tJG1OQvEB5joWUiHHh7oqYrlWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eBKerQKCHoY52Sg1zKBpJP3sOH//GKwRftWuAXgscF1fzQalQBoZHH8DPegagkPJsungTuh+5eHTbrOhG6+DkIbOrm0u/Zkcc9r2CEkgG5V/PnBZRzXcpA8UA8UND47dv9ODcSzoUyWYqJGbSPfIJr5rLK265BPrwjKu1BAoPAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wi0iHWMG; arc=fail smtp.client-ip=40.107.130.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rij/VNl0NpeOObxhmpBFUG7j9beRsl26arj3hGcip8ME1AN1+UUtj6o3EbUk6L87iIOtMR5luJPSSA43ttwovQxZwmWSOv4MFnevjZdU8sZk8ogKUyiETe/40JXr00zCGWkGOzuYG/gHG44afp0T65PFTRLk10Hgd2RI64n6+e67Vop/gCuhkk3FpTO/7yJNo1gCW7RFS//gFz2hJoCjBQTmag9bvAVB/aKCg2yL7isp+p9fHM9UFV4T6dB8Qm1y0KyY5rlUE112IuNUvF6nt/3/tkHdFAtWKeZxLq8M4DjhduKxnTPS7MGOsv2BdvYouICWC6WCD75C6+WcC82mow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhLj/8uRPP5LI2FqfyudWUzz+KwxZz627g2sygHttIg=;
 b=sr9z8UxZp0TpZTpJe/Sy/0cHb3dppR0a57uhY9asUog1910nk9VSfnTpFO65vOaTFXR3GxPJ4wUtraL8HbkU/fAuTTNOdv+ukEM/4uLPjD61lgmIffL/qeXG+pez56NfUUa2spXihTDHYO1zRI3s49O3rstBDlk4n4qD17Yz3ZBmoojj59EKIumjlzYmuPKkYKVMKO6x+IETVoD6SvuD1v0yU3VkG39FomY8guM0p1bPUgBC6MtVgvWKpykUYgxa7EjNLLfK+UmXdvIb7/Av6FiEIRaLM5lU5e43n46xqUaDk5Fozok8UKFshjfumYNCsGmix+zI2a3Cg602ucr71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhLj/8uRPP5LI2FqfyudWUzz+KwxZz627g2sygHttIg=;
 b=Wi0iHWMGMC4u7AwBoyokyZSK58FQb6sFBusD8cM6P/Z+1qkHQZvxFwP1CkIN3ytJgGKgsCIXy2XpmccUY88nVcFVHqnO+k0VwuFCyS+ysRczGoOKgPnoVePsDn7EVZZiOZJjOPlJoE/6DWzb/QFzetVu5rMaHRyf4X5xPg/kQS8Z8PFKwqUEqKR0fxGhit2ySRgjyHfsl1RNbbo38cruuXwya3ZIIij4Yr0Za+KdnB5PkhMQ/AbcIIPG8IOwkyDOowzEboC8eNody0wBkRFT/Mc2GMK8WBW4IBvLpzcZoHumEy3LXkHVaxfBnQcRBxK+pp7ilipFvosQsbidYW/a5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 03:39:40 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 03:39:40 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 2/2] PCI: imx6: Align EP link start behavior with documentation
Date: Wed,  9 Jul 2025 11:37:22 +0800
Message-Id: <20250709033722.2924372-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250709033722.2924372-1-hongxing.zhu@nxp.com>
References: <20250709033722.2924372-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS1PR04MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: eb51cc55-bf7f-4934-28ad-08ddbe9a3c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HKSIfqAbtjMHbLcEQPXgIvoCcX8c+grOLi042FvM/J6V0ciG1i8TwdIpDU+L?=
 =?us-ascii?Q?rnm/Vgzthb01fPDrNYQRjgfkGLntOemqg1X1T9DaRL7/BKsQ0uSmPrl+vXxX?=
 =?us-ascii?Q?XzAWyE66mXhTxTXnyetEPB3Zvvyoeqv9CP+jLoJAcKB0+g5eBQOv/qHtiGe9?=
 =?us-ascii?Q?D/lSJ32060MX6TsN1YgCVjHFIuQSlJHLjXrFpFIOuhMNwWUlxo5vkT06D8SZ?=
 =?us-ascii?Q?2FG3X2RxZFvTNSU9nnDMW8Rq6CSGLFkeRxBYGQMyLZPgseMX2aq+Qma4cfHN?=
 =?us-ascii?Q?V8KAukpGKv68uqU9r67dKaqCMRR723U1/fYnRxcN8l/MdlsXYLZUxKvCPAoT?=
 =?us-ascii?Q?SdjUbXBslbYSHf93hRsGV4U0VRhoBI8iidte9toZaynDV9x/Ee7TcYpgLJbJ?=
 =?us-ascii?Q?cpZyZ9gER97OGbN6ywiIaOFD+B3N4oHDt5orpp6JDI1A5MOb1sdVKJd/xTNv?=
 =?us-ascii?Q?l4ZZCzAEgQLpRJZDp9Uzlo7YX8wHS31FPgAMabcGVlDy6O4gNIA71VTFNNgZ?=
 =?us-ascii?Q?za53QPLzbmOpisaZmThC0j6XcawZmYOU2JZPgbJiyBvvou1jNV2yo3DaSG2c?=
 =?us-ascii?Q?qGOMTg3sH7dmOLhAxDEb+bNULBgWDDv7eyb+E6i7oj1QD1TN8YSq5U9YGJgH?=
 =?us-ascii?Q?zsjqSeAATu4CjMaLNXP2awmGjxro6fgSrZLZgtEWPyOI+83Ee96EV/9srGWU?=
 =?us-ascii?Q?HjitCln6V5aBuW5aMb7kDTKZ6U7/Zt9gODLBN9YZKc0HHhaAiWyiJwyQLi57?=
 =?us-ascii?Q?O02+WRbxq6pZybUYRu4y46LUojEPiRlw4i80MLnUj68/P2FBjH6HbSu1en4D?=
 =?us-ascii?Q?rxQ3JdpGyZ6kQto3AYvqkfoG+YqPyuLrQu+JxWMpAfDl97M7deH7GVkViqWa?=
 =?us-ascii?Q?3wk05xwgEqjOhr6gr93yoH7OBKmqb6JW2H+CH8W0zORu2Q7rAiP76DUccrPA?=
 =?us-ascii?Q?SE/ilCbYeYU+zZ8dmf28m2AOF0nDVjw5TOebcn8CAfyT91z/F5mPM02P58vz?=
 =?us-ascii?Q?h0l00MAsMfJ5shgDQrWdi8KJR+J+J/qSWBp/GALC+y+zv8hwzLaIKB1NX7Vw?=
 =?us-ascii?Q?iKPQSiZTQTNdhvIXp+TMqYhCt9VQZaoCOS7jQC40Sa3jRS3Ys8b3D5ryYb+2?=
 =?us-ascii?Q?Rhy40qzQNVDwuMlaD9Uk/W1GjlDn/BsCSCbGq94XmXSJnaUBThTc3TR+k8jn?=
 =?us-ascii?Q?ClBo1pGznt7Cz3Cyd+mmfqReZflJQnfvSLNeR0O4wntEr6mGmHSlFbMaa190?=
 =?us-ascii?Q?DdzZhpXNlHU8MMEcl2O1w/GI0JmdTo214vbYGgvC0BczZ1pbFBOZSzubh+21?=
 =?us-ascii?Q?lboT21mdzPpqNzwF1lO5VU5MJVavyumwoW+zQoyTgl4xhv1172jRq/Bl18Tc?=
 =?us-ascii?Q?AZqT+JI0AH5/Svmmtep9LF4dY3pQGmFSBezqSbf5QY5gDjwXUYjx0qeYo8gd?=
 =?us-ascii?Q?XCY5CAYKci/RegeyhRrZ9ncmDQxg+GD/jXuITsKETy5BCKv5qQWKvaZL+gzD?=
 =?us-ascii?Q?/j8CgSeGInLYG/k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ze9kqiYy1N4PIO/ZDiWPtRDnVlcpZiTaLU/XyNLihu7qoO77V63t8hxXHeq2?=
 =?us-ascii?Q?LlMjq3POz8b7Cro9AFBWJdrXQ618BI38KzSvXqEdPZY8iwUh33WXPurEHw5J?=
 =?us-ascii?Q?hz7YoLuBQ+G1dr5wcgWwrL0PeAviww6LgV5+U5g4C5vXQHpYv6ZVouovCcWD?=
 =?us-ascii?Q?Z0kbpKPyKQxIsQwLLUtkgmnghCUYIx+F+GnHGbvNAR1FiewrwkDMX5GH8Del?=
 =?us-ascii?Q?BA/73mEAmkTlU7zoTai6bsq+CR5hD3nsHTp0EYP1GBzDe7G74H5v9aWQVLG2?=
 =?us-ascii?Q?Jr8dcbPaHmnOcIr+eZx/NsXT7iZLnC6Ux9yb3QlDx35l/QOLRyIcU3yO6mDm?=
 =?us-ascii?Q?cjOhPsThUcElYhr2lc/HqD3nDO8HlGfwxKkwW1n5EMOyXPqqtWsjpUIeTKnR?=
 =?us-ascii?Q?Qv+TpgBkkTEzjsfSp7ppm2nV4tOLoofo76r3wrBHgRR4viM5HOQYGgM0n48u?=
 =?us-ascii?Q?lGiNRBBYvgooFfWY5HAp5T0V3g3Bwy7MoJqKP2n0h9FeAOE4uGseA1mbEQxT?=
 =?us-ascii?Q?McQSui0QuDwk8Pa2uKr1EgzUoACZsi1qAZbqFLSG0SOcF/UeOxtBAXoCkGKp?=
 =?us-ascii?Q?r6pL0p+sLRDhtG7YrT64pEyMb4HZp07WD5veILQl7eUG/QyK8mCdb0Sl1M9Q?=
 =?us-ascii?Q?+aRyAOnt1kmexKN4uHTxiJjbKQclAdGqEuHS2kvLxjCzKKE7bpccVfSSpsaU?=
 =?us-ascii?Q?A3XQ4I2HmqPpBH9OUP/kJewLW3P0x8+Df9w6kgfObacUFgx4JPIZ09djEGwQ?=
 =?us-ascii?Q?fbOySIuj8zjSAeIbF1RjH+Uzt12bcE3j7SHxxTxgvcp0i4sPfptLIe0ekrBk?=
 =?us-ascii?Q?EMfh0/BKcuaFfQpJrTb7oMxQ73QapomyPv1XY6jloMgg1XuLEoo/K+LTFuw1?=
 =?us-ascii?Q?1fgVWiNIkjItk7BFSTU7kNo2AdbPqBRE8mUKQ03hbfYWlb6urCqKN9VYHqm7?=
 =?us-ascii?Q?ftLcwOzzt5Mi6k9PEATIsoWh8ftmnfVjGvmofQMagAmMv618S8T2kP9CFQyz?=
 =?us-ascii?Q?8gXcXfiEzDnwXrwmoH3MStzmEF261yAekLRJ7LbkJlCXyCU0FbhnG7Ul8dRz?=
 =?us-ascii?Q?RtoOWlExOraG/3jfQ7D3K0I0jQh3Odz9PtgY6dC9hxSMEUfGBpRAPjf1BDhf?=
 =?us-ascii?Q?t3pMJTg4sc3AyeQ7kNAWIB+icGr7PljNsTKCFFGoVTo2cJsyY4b4Xc+ypS81?=
 =?us-ascii?Q?Q8M9UVyqNZ6D3CUmj9z5oTVyQSQ3yXqd1PxznaWpawCJlvjy9km1pdRX8+U7?=
 =?us-ascii?Q?OgkE9qi+WvKChj9zUm4j9rdc6Unite8WL8KAGDzIuswiPVZqQIl1V3nrQgVW?=
 =?us-ascii?Q?hIhkDQiwvWsd9qWWhSnF0EKqVIoHwI6qvuh3X+rrbBSq+DFQRBbH4d6OVuAX?=
 =?us-ascii?Q?bmx9xh6lP9AmZMXTXfFU8cDxrz8VLMDs/4zAmf+Bz/Xzk3rhsVqg5eOL7FvB?=
 =?us-ascii?Q?+9QqbWggNILYvOAYTSIkyHrqFPkreQQmeCv9sC3607LjuHacdNZhKfUDZEVU?=
 =?us-ascii?Q?a5FACRwhEPxQFPgc6EnunHTPwpZdIDnkK5OM1ih3IiineCD6ubNc8s2Zzfds?=
 =?us-ascii?Q?XZaadiVsZrblO2hih8309hP4AkaN/fhnkcVI77Po?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb51cc55-bf7f-4934-28ad-08ddbe9a3c7a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 03:39:40.8218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ytr6VeywiFhKmXU/o8DeuMEmUTOycKC/LSUFjgZxEn8KzvVNOc0cf/rdGDblWbzlSL01PZTd9K5e9CQijLU22w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9358

According to PCI/endpoint/pci-endpoint-cfs.rst, the endpoint (EP) should
only link up after `echo 1 > start` is executed.

To match the documented behavior, do not start the link automatically
when adding the EP controller.

Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f5f2ac638f4b..fda03512944d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1468,9 +1468,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 
 	pci_epc_init_notify(ep->epc);
 
-	/* Start LTSSM. */
-	imx_pcie_ltssm_enable(dev);
-
 	return 0;
 }
 
-- 
2.37.1


