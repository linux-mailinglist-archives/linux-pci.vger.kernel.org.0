Return-Path: <linux-pci+bounces-39228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C241C042F5
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA20189019F
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C403F26ED31;
	Fri, 24 Oct 2025 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmLJ1C9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B492F265606;
	Fri, 24 Oct 2025 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274625; cv=fail; b=oCE8fnbYy1p0QgieJdZP8VcoHyc8+Gva+8+bF6X2Kc/8ShGYVLHsEo0h7KQzHmp0NqocQUB8sIlWwftCaZ1PV6tdSvYqhcGREB7neFGtDU0p31hr/6BmDGTgknMmKyzJYcznMP4utGJ2wux5I0oJuShNn/BU1k2g/8an9AiCBpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274625; c=relaxed/simple;
	bh=YyX0FWxNAEKwnYRWM0jHPSGteEN+G0Mo1oPDmD6/8RU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHLV3xeAV1gk8L9yNBmDXPT7jNnieR8VDSkmd6qJvvoFUCZJubOeDjyPudpl20vsoxTsyu5XGtgJJ1FYxk0U51a+xjucGx0KGO3O+60bm6QLNcGqTVerBaQ122INkCoW4oQqjiSVezRiGDVft8bqMow+w55sPfRUL7gS4uQ9d0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jmLJ1C9R; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNRFEQQKBhr+UG3e6zu5QVnSvP78hzsFkdqKmPMXyd+pSNhToCRXYPjefWgAqPJEI7jwDpQwgyLeuwbfO36ZFHegO1NEiIqUcwP7g2aq3M6iGvyogrmcxkhrklVD1ziAkH/2Ko7s9plS7cVtVLzmcbNrg8D4hkMHFTtuZnEXOsu4Ixooc7YmXwP+vEGE7aq6p75KZbXMZ8kzcsLIOrG9FSH+zfM0hCk/IdHV7pQK0rhJbPZm0UBR6sLtT4cFrqm2m4gb8NlNWBfHtuD40Q2wUIysnL/L5++MsybIXCm18e72G8Pf7ic4/jn4HKvyLJ67pYudcEnWGlsfQi8BdWyKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyGScTfuLfWoFCc+TpU4/HXvkmBnsmBH0jnPpyyXfpY=;
 b=pO7Mx0JkE/0ou7oKsHP4RPzt2qERvgQTXexilcjqCBL4qUw/50rmMvuSq8fOfZ7tJBx13FIs5RzTbC8FpMLMWC7BugIihxrz8X3c/en5nArlnUhhG3w0o4mf84qgcSG08noCt6KswKxFb9OC0R2d9y1kmRDyIFaNjGht85SO2hHH316Df7XgfIpBeQX3UhO90OcaVT/MV75XCrL9QW1AVFpodZWNYZw2hpiPHxM1o/cpnoDQ8B4VJGFWBOHek5/d23JePJTkPdsG/rWS9hvYDeYQMQ8VynVkNYJQM9sfFXbsVE7BKgAQVx5JQIU9Ui/MCPlS3DYjSliT5O9798L5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyGScTfuLfWoFCc+TpU4/HXvkmBnsmBH0jnPpyyXfpY=;
 b=jmLJ1C9RAtBDK7axlnx/r95jDC6sNH8Xy7uKDrbk9N/ZIOCcqo2oziR2Za23O7pu9+screUu1o/DJ3m5Sqc5Iuq1dzZ1ssvXO3yKxxattHV3ZdwRjC75Mb5dUK7V59WTi7cplCcXKL+vM6KDO4w0EnN0vOJEwuFhVtk7ExcLbFbRRzu8c7fm0M1BePeZRlmXvgtY2O/HbMy2OEcLkuIwJAyjwBG4sKaUyZk/LRJfksqnRt3WkcKlIQwUSRHer4+o3rdkOwK6mekPULzFFei3M7uvN2+1mx3g6s4tBv2kX6OtPnHOTDUk32quUUOdv7J9hzk4GIQ81SN+zbbf1b56pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by FRWPR04MB11150.eurprd04.prod.outlook.com (2603:10a6:d10:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:57:00 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 02:57:00 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
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
Subject: [PATCH v7 1/3] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is existing in suspend
Date: Fri, 24 Oct 2025 10:56:25 +0800
Message-Id: <20251024025627.787833-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024025627.787833-1-hongxing.zhu@nxp.com>
References: <20251024025627.787833-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|FRWPR04MB11150:EE_
X-MS-Office365-Filtering-Correlation-Id: 54799368-1d01-42de-0dd7-08de12a90053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?14UF73LK2GQmmrUEoYXBrAIWTWGJ6qi4kqEzRIIL2GwCq+ZofMq7GLTNhOW2?=
 =?us-ascii?Q?Q2rCZsBcVnoMl31VrJNny7+FFtrsjE3OnTtleB9i6fWDTgSDPUSQTCk27iaY?=
 =?us-ascii?Q?azrVD6CzFtvkHH/tvYwbwihevsbKNEjRK4MaJb207rEXihXScwkzc09SvcQe?=
 =?us-ascii?Q?hzTwrqLFNaNeIat753k33gEIwbO4jY0CHslVae+uiUavv93IPc3HKtQ5zZZx?=
 =?us-ascii?Q?5229BGT5nhPXaRmfFIYKW+st2oJZuVdf0OE45fMeEJoyjove1f2RxYf5+bcZ?=
 =?us-ascii?Q?23AixHa7VWBR3zUaZexY/Ms2Apk/y0wyj13K16WIMNfCGGn4Ezfqs5sDrpTL?=
 =?us-ascii?Q?OOl2KODGPOgQghmGELsVb0IpUDuly+z2u2EKXJd7ay6PVLkGPjU1S1zNeIaj?=
 =?us-ascii?Q?/MTS73il9s1NSGdhksTCb8ZoXtjSOqoISZ++rWB30RZY3a4qr9Q99de6Vnwu?=
 =?us-ascii?Q?gy30N3NRUksbUZkD2r4q0WC8zRDzaqkJ0Znp1VyRIebZRge8ZyO0JJTVljoG?=
 =?us-ascii?Q?BorESysiDeC91RujS5/a15Ao/rHfLbwd2WXawXiUJvAEwi47jaIf/zQTGjse?=
 =?us-ascii?Q?EQ1fL0qGlUUMv6t0izosrSMcunE3JNh0HwucvRRpP3ztFFZ2HAH3/gzoRbq8?=
 =?us-ascii?Q?eMZixsiyeTimBX453tvFYGGyoujiAoUxhgfUogUQJNvyEq5oYw2f06d0xpHw?=
 =?us-ascii?Q?QrXSg+VA/I2Y73179NWVjIDvbg+D8Ar020fWxHFOGnAcSGt0MNxcUEgiqmzr?=
 =?us-ascii?Q?mcaOwv2U+q4ntRgaXin5d98AmO4mc6iFSo5je5WG2Y3l8X6FhMJmY8cTbyKH?=
 =?us-ascii?Q?AdcEgfeFE57yiCD3baUhFYs4vExNleoB/OuOiUcn9TUyP6ZSHTFU6Ut98eQ6?=
 =?us-ascii?Q?C8RRbX671fSHTjn3Imy9s29MavCcWCTKFR0n+k8YSmUI4D0jy4fC6DIn4G/D?=
 =?us-ascii?Q?7mK+LRGMmszLbCxrU5amqBNyPeqbzNe8A+j6wqwtpLWbZyRU6OdI5P68/kzS?=
 =?us-ascii?Q?BWZ77FijMAEeLhF0fCKm1+lftSSb53gSxOkarzjSVupb1dBiGs9Hm/TfrfBb?=
 =?us-ascii?Q?wxi/TLlZLOfR5pl5JemP+d85O6b0KiYjDIT3mF6cNhPZaxEQpR/Fw8wmbIrB?=
 =?us-ascii?Q?sFJ7eaH01grUNk01fj4S4UFzK0AxQxvS8hco5V/wurdZPNSbHzSZNYPqAR4y?=
 =?us-ascii?Q?FU6sFYnta3wkBDsC+31W69cSAm5n+6EAp8+WRaMkjy5ErKKL6EJhMHelOx9k?=
 =?us-ascii?Q?P4m7ThlyokEn+uhAmS3k+KVMbOvytDIdX7ajSIrCaclc8XE+Y15z0j8MN2G0?=
 =?us-ascii?Q?sADIpkDQpATUDTcCijGDfngJ423+dT3EUk5y+2F/f6Yesq80w9kF411Wg9Co?=
 =?us-ascii?Q?zmOee5EpDVEEHH2cUap7JMvVMu6n1ZUiWQ0/2dtRl0EL4DLFl62f0P6VBeXa?=
 =?us-ascii?Q?5syKjjvFVQ79AAXQfVFyO3vOCaE0uG+bKy/zliTvB8E0nYx45isRAOzy5I3U?=
 =?us-ascii?Q?XTLExC1w5QcvVQEowyWjECVONPNYgsvv7Fwxbxjg3RH5tW6Zv8cCdxOk+g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ui5OyWMvKEFGhrinU+sSO7+c720oiUIK4WrZN1LkAC4+6bmw8PT6n6ueksdJ?=
 =?us-ascii?Q?RN0xJTdU4KWSrApntHFQT3liG3PyHeM/1nTwVHrfKfdmTxIrWaQPLBf9IgyI?=
 =?us-ascii?Q?e/mCLp9HlKjt4uFVtRytgVfJrLzW18X/9Xa6bGcI9J8h77tTL3/VzdbW+Q1A?=
 =?us-ascii?Q?yAa4lkDufs4PdJQWPipRLsQ4OylMnErbgQyrYHmimd2UBcoCpG6Il55KZqhl?=
 =?us-ascii?Q?KkF4sUWS2QTv29ENufk1QQW8viOFzg1LatQ9YyB7K9taCjxnFyjdMYIl8BM9?=
 =?us-ascii?Q?ZheaRiOU9+2JkE5EMMZCjifzEwvhKpm+OZJtAUDL50AlkMjpl3gRHp+5nGyx?=
 =?us-ascii?Q?i7EKJ7Fv/Pkjc9HibmU5x/SoiKHOuXUlmLqLB8EKmL0XDYXhuqTpp2zDcskG?=
 =?us-ascii?Q?xMfjRM2D3FxkWIXcx+K3Wt62xZvi9krbGrhFjctzuIYWttXZYx8IFt/9SsYH?=
 =?us-ascii?Q?tc8Cctrqxh+a0HsuL7cHWVyz3N9uglj/nkQrcclOXon14RuTKOb8K3w+lVbp?=
 =?us-ascii?Q?tCEZXQVztsXgfwqOdiP3NAdNmXYuCMHRsVfYD3qAvovTbDQXVgVq2TbLBaAf?=
 =?us-ascii?Q?ECdsEgIlVm4R0bFY2js02WIP0i9MPMTf6fFT7uRtsoJE0uI6ObflEOsW7EGL?=
 =?us-ascii?Q?1+OEjeXbTEn9h5mV6qx4EaRfL56KBR0Z+2XYTtBobN7NBcZC1UcWsm3RUjAc?=
 =?us-ascii?Q?jtVVUfuc1D4+uX/Z1QKKtxpdv4bxk2n5Xu4EKLsCtMt892svLQSJNJ6QEk6b?=
 =?us-ascii?Q?7p5vjGz3P4Iejm55EiWdm073cF3wEReZzq3wFPAf8CrYCXz3Jxeg1Hrz6OJu?=
 =?us-ascii?Q?jFvg21e8LHgYpBlG/+lVusflm0VzltYgzlWX7bkcQ49QnUj/J/mLVENWMCPX?=
 =?us-ascii?Q?QeVaWXWga06KxnVazxtajAIbZrVkOo4/1FoVDzGqn7R7ra4ZKgyH+9wuhVQo?=
 =?us-ascii?Q?ac1xNOgYpFOkzCV+ZoCrWGr6HJWZT7GWTXsSpRuXg8WzG4J6nwR0Oz7L78hO?=
 =?us-ascii?Q?ge6BYI67JRnIrt+rtKKkei7l1UetBqYt+R0tdYlzJJucrmb9c5aDiUh9ax6a?=
 =?us-ascii?Q?vCQgAB3dXWVC5ncoAyFQi0dKOHStAeoJd3jo2FMrKAyJD2zU1JjqeZ97zitV?=
 =?us-ascii?Q?MBteeJJARgjDSJj2WrJqsfptS/JOFtM/2DXrh5Bi8nfZ/aOLIN0tzfjA4PYh?=
 =?us-ascii?Q?aAOCa7lkt7U5VoUZYZkA5TPxfDVFarkCnQGdPcsZfUO9+JJ5JBYmiofLrjst?=
 =?us-ascii?Q?5QIpE4YWfBy38cdk5BJMGC28rUcMgrqqP2Nwyday4rNgI1bCii+hLtV5jznH?=
 =?us-ascii?Q?ickm7avRNWSUp9flRFMdndBH/wgVQ2jFIqi8PvlIZZviPyRvgn1bRYqB2MUx?=
 =?us-ascii?Q?v71rPUcCAt1kY2nYVeUuC5VrGvSzz34c0UVbzTpmjZawLoXayxsuF9PoEP4p?=
 =?us-ascii?Q?2GW8XPmpLLpM+24stJs14PM1rXEMJ7bIXyhlsx1HJ5/S86Wfqc4rOVEP3S/+?=
 =?us-ascii?Q?3L3kL7kYOY8vwggvhDeFKMg/Wcp1jQZ36pVwVaSqSbMlXMR6kRbygvp2CCkR?=
 =?us-ascii?Q?Bov7zNProYrWDrqaZ1XYSYpCNzr0zTCy1AHu58wI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54799368-1d01-42de-0dd7-08de12a90053
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:56:59.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +07l9ojEPVZ3aoHO+VXToZziaKGaY0tPTYEjFc62SHKUwK6w9huRoKO8Y2vHLLGZnJpzbq842DZPOlI4diFWAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11150

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
PME_Turn_Off is sent out.

To support this case, don't poll L2 state and apply a simple delay of
PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the QUIRK_NOL2POLL_IN_PM flag is set
in suspend.

Cc: stable@vger.kernel.org
Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c         |  4 +++
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4668fc9648bff..d84bfcd1079ce 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -125,6 +125,7 @@ struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
+	u32 quirk;
 	int dbi_length;
 	const char *gpr;
 	const u32 ltssm_off;
@@ -1765,6 +1766,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->quirk_flag = imx_pcie->drvdata->quirk;
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
@@ -1849,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1860,6 +1863,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 		.core_reset = imx7d_pcie_core_reset,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4..09b50a5ce19bb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1144,15 +1144,29 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 			return ret;
 	}
 
-	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
-				val == DW_PCIE_LTSSM_L2_IDLE ||
-				val <= DW_PCIE_LTSSM_DETECT_WAIT,
-				PCIE_PME_TO_L2_TIMEOUT_US/10,
-				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-	if (ret) {
-		/* Only log message when LTSSM isn't in DETECT or POLL */
-		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-		return ret;
+	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
+		/*
+		 * Add the QUIRK_NOL2_POLL_IN_PM case to avoid the read hang,
+		 * when LTSSM is not powered in L2/L3/LDn properly.
+		 *
+		 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
+		 * State Flow Diagram. Both L0 and L2/L3 Ready can be
+		 * transferred to LDn directly. On the LTSSM states poll broken
+		 * platforms, add a max 10ms delay refer to PCIe r6.0,
+		 * sec 5.3.3.2.1 PME Synchronization.
+		 */
+		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
+	} else {
+		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+					val == DW_PCIE_LTSSM_L2_IDLE ||
+					val <= DW_PCIE_LTSSM_DETECT_WAIT,
+					PCIE_PME_TO_L2_TIMEOUT_US/10,
+					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+		if (ret) {
+			/* Only log message when LTSSM isn't in DETECT or POLL */
+			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+			return ret;
+		}
 	}
 
 	/*
@@ -1168,7 +1182,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 
 	pci->suspended = true;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ecd..1fdaed1562b7a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -297,6 +297,9 @@
 /* Default eDMA LLP memory size */
 #define DMA_LLP_MEM_SIZE		PAGE_SIZE
 
+#define QUIRK_NOL2POLL_IN_PM		BIT(0)
+#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
+
 struct dw_pcie;
 struct dw_pcie_rp;
 struct dw_pcie_ep;
@@ -511,6 +514,7 @@ struct dw_pcie {
 	const struct dw_pcie_ops *ops;
 	u32			version;
 	u32			type;
+	u32			quirk_flag;
 	unsigned long		caps;
 	int			num_lanes;
 	int			max_link_speed;
-- 
2.37.1


