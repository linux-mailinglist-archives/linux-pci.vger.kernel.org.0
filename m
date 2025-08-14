Return-Path: <linux-pci+bounces-34036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1420B26014
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 11:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5C47A8C0B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6142F0C45;
	Thu, 14 Aug 2025 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AS3fnhz9"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48022EFD8D;
	Thu, 14 Aug 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162014; cv=fail; b=Y2gagH7aGP2aNS47KOmfpCZpLzoaoGZZTK/SxUd8CK9dG/wAGlg8zmDewqJaQCcsJ0bACg7MIxsQlkhzdcrokFlHL6M4t/I59/kFNM21jYRsz4J5/pveOq/0ZvpXgYVFq2NwYyKCyFh35aMarv11qpHn1/q8hc5F03s3o/s0bws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162014; c=relaxed/simple;
	bh=Cmctnoyu1ucU1T++zibhfaXn1SVz2ujgn7X1XyA4MZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FxIg8c+PUtXIDuhg2mHLdZD+8sa0KpLux+zNepROPULckwnSCD2m0vTZ4JmsAjamIlJrsk7GfLM9W0yz3dV7SnRbJRCvALG15J3p2r02VmF7xOfDVBP/TLrvIuuGdT/fHQIcb9xiLzp/zlBmMeb1vJhe9W2ZD8hCbr1c8qAQLUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AS3fnhz9; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJX8wnXrbccT+HX7/oc4kHZzwLZPXthgzgmo9ZywCUzSMSBG734MKNAn/s5Poo+EFuNCdhlh1t1FLlt/d9h6GpnZDFOriSovJ5QcrydaCrX3m12nvnlrSy8R2KXPk/JpfxbHx/2YlMG5et38W/Sq3kycOC3DztWpMqXrkHxoXuAeYo59O6gB8ZY2mIv5O+UhL1tcR7aceRaZ/4VocWoU0e5oojkeGuys0suBUr93cZ/6OXZSJc2qqXmx8EvwGEahXIV3iXWJFFcMSJ+hNUXxzxd7h27FHVd6c1oNggPZ32a84zDlKhZ5x+uIawazOwWWZF3IkCvHIKV/dfSD3t9q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLgVtPkbgrz2T9FOHhc4NCDYqgmk6y2CpZY7wFZxp1c=;
 b=d287EECVArxxs3vxAOaS1CXHCibPxCYdRYS0T+aY3m8Y47Qtz25e8WTBZ8lLGLn1yb1kwJYClcY5Kv/diFn8vM1pPr6UA90XdUNw3XdlPcBisjxqImhCoXO1BQipFKlO1PtSrKIQ0Y7NOY9Q/BgeFwV9kJzSdVNKY+D3zX3vSeCaIMPVuDrHx097uotJYly1iM8ELk3Q/8EZKj1Y7pX45ChOBbrkBgZP6RwQs+sjV8sC+q+Aw0eIdhG/eCUj4jgT6IceglH13ojZ3skUSZdGKXiFYKzrk6vjJdQkscFYWBWaBOg4yU+vqwt+XFlyPA7HAHGl4sypC/GcAOXbz1I9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLgVtPkbgrz2T9FOHhc4NCDYqgmk6y2CpZY7wFZxp1c=;
 b=AS3fnhz9GftkOLuqcVcTcrghWx3k7ybI1UycIcJPlKrUX6eB6iZ10viXu64r700deT+N5ZVq3QsWwEJFAR9lwkXSRqkhnm77RhBq1rwephwWTY1/xDWJp1hSDqxn0tk/ixrPHhE75Ur90o7Yd1dOXgK3f/ujuJClvno3WfL7qxJDPD+ryuxa418VXIu35xyz28Z39olTkAugVwRmvu+VrApQkncubQsxMB/bHbnWZP7YVV+wXT1Lbzy2Cb+zMl/ZZ0Uu/yIJtBEN1ZIzewwJXT2jILKAx16WomQ4yDW7NgIReLP1jWX69k563FcBRThzApqLqns03wukLIHtv+GR3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PR3PR04MB7484.eurprd04.prod.outlook.com (2603:10a6:102:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 09:00:10 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:00:10 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 2/2] PCI: imx6: Enable the vaux regulator when fetch it
Date: Thu, 14 Aug 2025 16:59:20 +0800
Message-Id: <20250814085920.590101-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250814085920.590101-1-hongxing.zhu@nxp.com>
References: <20250814085920.590101-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PR3PR04MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: d24144d4-b685-4dfa-1077-08dddb10f8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wCqS6Ldt22ojzN+32f9T0bkAFXxt2pwYNhm7V6I0e1IMFsb/X+55J5dRKego?=
 =?us-ascii?Q?9ZB343uQgYXE379IyS/sXJvOkYppTVUXMgmxvmgd7NPUF59l7H/M/1dETBfV?=
 =?us-ascii?Q?RcUoLctoGZX/qDfesaIhMppeJGCq4a0MQ/nU6ngrGBziwwEMapdwB2U9h6Kh?=
 =?us-ascii?Q?LuIkWVfXY4W4e60gbgx2F0FiIKx2hyTRoGsnzWqozXvQCIsgnu1VTJFmeJWd?=
 =?us-ascii?Q?bnmNPOrwUmJ5dfgpdR0uVRgzsm3cCj88ImcA3LmeS/Xzin71jHxru3uesOHg?=
 =?us-ascii?Q?kaD3pVBGyivfPQFaEDQ/sMvI18y1DB4n0XfiMKWdec+6dbHxHp4Cgsy7ZLC1?=
 =?us-ascii?Q?wZGSsk6QBz4PHNO6E5SwWjFerkfDpaqT4BX4CHYxfpoQnwPCNA5nsNQ0gNLd?=
 =?us-ascii?Q?dUtG7V/4q2V3QoZUL5Bj9j+wqdp98aH3B/2szb7k6AZjnNR3EE8AzuOL0sWQ?=
 =?us-ascii?Q?xyMdZMEqVIe6AB9cu46GJb+loh/pbO70kjhy49mc+YH8f9PGwbtZONeyBhR3?=
 =?us-ascii?Q?kU4cy3MMLOn3UU9BTbovrWgkHpgjxmRtDRIL2oyLsUtlAg/vLMoej86Dzstu?=
 =?us-ascii?Q?LInbxtLq3n8BpXGhNLESoT9NeFI/c1sypCUIPO2BWBPI7NfZ+LFXFaAkEM+7?=
 =?us-ascii?Q?iY+dw50U2/us4CsXsGLKv+W9AskFVyMAcINuRzMxiK7jGB0Ou+NoeudlQY/z?=
 =?us-ascii?Q?vytV1irY6a8D0xcQaLydPTMfV20aQ7m5w2F4NWV0v7kBjLTsqMSjKGxDVtsT?=
 =?us-ascii?Q?nn2USLDUZFw8Rw0TyNS+5KZx1mzWFWMSMmzQIRfRgf53JpIjr8aEdebbDZuE?=
 =?us-ascii?Q?/moKtuIyiGMEeZEZjcFP7p5uazyh8bxTcIxHFDPOFg0MM19hnmfroel7aVD9?=
 =?us-ascii?Q?Hhj5DEyKPvcNUmPUrRIzlPrjQ0fmsTYIxWL8fpg5DvBBFYbENfQYf3VXlzDx?=
 =?us-ascii?Q?B2VWERuyaTsOHvlbH1VU8xxP7aLmhu9+g8mJFJIHXpAwvNuWUTDwHasbxgZw?=
 =?us-ascii?Q?Fhki5QQMnuOkcJnO95wCwLKZjHEoX8dM/Y7uD1hm+3uW0A2FTQqgtLCg5v9g?=
 =?us-ascii?Q?s12gKnvY/9S/7W98IF52NqUZPx40Nyz30B8xIT/Bsu7WhjG81iFWSwszeLoL?=
 =?us-ascii?Q?kqkbqdL4lAdFi3jqNgywniMzmDm4aq3nU3UFbkBRJ6zTLvR0DLt0TSMQv1uN?=
 =?us-ascii?Q?ny0jtT3JovVv2FEVDWibOyFW51MGdwqYD3sFkfF9xrA2ILtG48NWsRAkft4l?=
 =?us-ascii?Q?hZZpqmS05/pC62eS2P0Dc6vqEIfA15GkoadB9xtibJgRH7tlakiryOLbLoxY?=
 =?us-ascii?Q?hBoW3cnrWVXELvgKac6oU3YpK6gOmiN+rD6tG/44Oz3HRKI0fRYnhmaaeS18?=
 =?us-ascii?Q?0m9em391w62Q6zMnZ4cajWKxg5LyeNkiOmTAmQrdIdXzjl8+puxy8qgpOKQ3?=
 =?us-ascii?Q?DXclQtU/Fy/O7VK4mt/vxSw7vFYISf63/C7fYyJTedeLsuEVOWTAscC+Qz6G?=
 =?us-ascii?Q?EFMk0SPEQpjd3/k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CIpuuOG0ls6ga5pWiKkDFMJkPSooe+P3GZoJ5knnjovBq+41rK8nbTKMKme5?=
 =?us-ascii?Q?/+m18/wgdSx8+JFXe0V/lDKjLdaxHwVGkXchZsa1JyuMtvgW09rKfrl5KkgI?=
 =?us-ascii?Q?FTJ2q9hNPCp5nl79VPOHH0Mw4r2sBNYJomHVmnih62iBtB2txrWudWk3TwwD?=
 =?us-ascii?Q?lQjUIBUxxuIcKbwbqpTtR0R265k+KfuhoBVnYGaTba9ofXUDL93SNElV26gl?=
 =?us-ascii?Q?nd126IiMa083HGAxYnzCmxR6pjRErvwWDJCJW1s9ecNSNE4BMPo38CS4WdRB?=
 =?us-ascii?Q?g8pe/hLgK1leQ1ZXuwPZbGm65Y/YiTHoR+C79SudBMLt8rM8sHJu+vJWmDbi?=
 =?us-ascii?Q?uh70NbyL7UJARxa5oAppMYh7X09+ev32bh+ggyhuYQ/TZrAlIVKQOUNNPbaD?=
 =?us-ascii?Q?Q5NXHvaiJ8/j0XXq6k9v1jbYTcwUojJZR8eC585S2aEkPmAd8sZy9oAa1UNe?=
 =?us-ascii?Q?L5a5tjvEtdkpJHTIBi1TPNiWKS/vruQT1VyEPDJ3VAE0IzoZUMBeM0AIcXML?=
 =?us-ascii?Q?gZ1CDt4PXoumaXIj2IIUeRay3KZoFGvWJviLghhvAG+xvTNJKCW5HHcjJR5/?=
 =?us-ascii?Q?ToSCdALw3lmrCTzeTNZgXYHzzz6z3M6HaeevUhOoSfJeN/6diEgYTwBq6Rob?=
 =?us-ascii?Q?HgoPyfY+ndV0prcvYZLZBy2/HVCnZAyI/OowwlNNX1ki1ZdI3ZBtdh15jvQe?=
 =?us-ascii?Q?yonDNup7S0YJ8/+n+p5uk4waXNtQrLnbZzaFqztF7V8mL9tz1OeLUwf+W2f/?=
 =?us-ascii?Q?ZEZ+8W5+x1oIGPZeE6WQG+gaMO/WiQfcZD/ZB6iKw+mAFLoXcBWlXZgPEMtD?=
 =?us-ascii?Q?oyliATRXUwkH3Wv+VP8HM1fgC11h2UOl71vqiLSi+gpoaxF1shXT/hYXTeyC?=
 =?us-ascii?Q?w3P9pHwPWCCmiItXnZP8T8rXJNkDTokFrx0xT+oQiBOcWkADPf1uQjm71OJf?=
 =?us-ascii?Q?aLCLQ3v/AKYkaINkFqzg3spQ8Jr6+n6PednB9hT9/iXxDIgi9SOYJK4ca8ZV?=
 =?us-ascii?Q?inArC4NWPmEoJ12DGshWvO0BuuNF0Z76+l7B6OpPRqueYYd15ktwMBYiF8k6?=
 =?us-ascii?Q?0DauSL+002KfHZr6UoiXyVYOqQ+58n4ssMVTRqoWjLvG0HbJB3y+nOLwzJSM?=
 =?us-ascii?Q?stUsTrqLSlqle/WD7rAVu7SUK0s4/RwjVokV435qc8C0Xh69XQRQWXwGlCNX?=
 =?us-ascii?Q?RhKC7xS0bfQ3u939CNg4A2QR6UNH9+CGZX8JNntDlk96CPAfrbQn2UR/9GCm?=
 =?us-ascii?Q?suTe6V+Dc1p+L9ngaCOmbwOVGj09RVipVjdrnDwetn9nGNUSjvVLCkXlEcJA?=
 =?us-ascii?Q?cHiF+yU92gzH2pgLqhTp8P0d8W0qyZV+ehD8lAysOfTkwHNVnGT29DTtyJyv?=
 =?us-ascii?Q?Ou/YurN3dC4qLDfDkOSw/lcywQ9U/CTfS6MVwYEfN+uqTzNpM0bmtjtAamjC?=
 =?us-ascii?Q?yTqBcnb/AA1RE+9BNFTkU4Hnuu49St/153MTAXChUQDJl4etnAzRy7l/LMAl?=
 =?us-ascii?Q?jvLPnarPfxlJTJ8firHHkGBTcNVh7Q3DWKYRFIm2JEKmzrky+kR5poaF6pE2?=
 =?us-ascii?Q?uSoIxbl9KMu+Cq+kEN38peggLICBn6ruzSJMqzAo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24144d4-b685-4dfa-1077-08dddb10f8f5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:00:10.1610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8B+mCGHMd5QgoOJfAxzzAY1iRSgyoOIeXxxz7XMoSomS2fB1DXcX6Fl/DMHRAVxRbOrk6CPaca04Q9r7UqJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7484

Enable the vaux regulator at probe time and keep it enabled for the
entire PCIe controller lifecycle. This ensures support for outbound
wake-up mechanism such as WAKE# signaling.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b1..1c1dce2d87e44 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -159,6 +159,7 @@ struct imx_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
+	struct regulator	*vaux;
 	struct regulator	*vpcie;
 	struct regulator	*vph;
 	void __iomem		*phy_base;
@@ -1739,6 +1740,20 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 
+	/*
+	 * Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
+	 * asserted by the Add-in Card when all its functions are in D3Cold
+	 * state and at least one of its functions is enabled for wakeup
+	 * generation. The 3.3V auxiliary power (+3.3Vaux) must be present and
+	 * used for wakeup process. Since the main power supply would be gated
+	 * off to let Add-in Card to be in D3Cold, get the vaux and keep it
+	 * enabled to power up WAKE# circuit for the entire PCIe controller
+	 * lifecycle when WAKE# is supported.
+	 */
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vaux");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable vaux");
+
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
 		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
-- 
2.37.1


