Return-Path: <linux-pci+bounces-12219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F795FAA4
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 22:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263671F22377
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747119AA46;
	Mon, 26 Aug 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BrBl68Uc"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0CF19AD6C;
	Mon, 26 Aug 2024 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704082; cv=fail; b=F7QJs+NXvMp5vHa/jqb4tjpoewL2RchzEO7qhOCSWLRp/4UVpPjaBBmezNGF9dtclPMFc756VzBF6JFtzQxACcRSyNcoNCx1vzxA3w5vzEWU1np9jsE4EST46KAEFT1F+dTs/M9IhwBdwDqdmq0sPCK9nCIYkU/v0Kiu6k3WY+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704082; c=relaxed/simple;
	bh=MOO1sbWOunpyiYvzybQe2Trk74BCleQX3Gt3VRzPywo=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u4N60qt1gOSQDRG1JDNJfdKvfo1z6yk7gJWYqWcJnZuT3cN33EyjZ2Yxse4H0bcCLo0ytBECjYgUZF/vQ2aX6VwIIfhUDHQ+x0yBEMirpwp+w9LS9Btw9KiQqARnZbjD5ElrJ+saTP4Jeu6gNrvmp6C2B8kzR15/H30o94paS7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BrBl68Uc; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKScIPN8mEiD6hEKmtJTUmBVHw7HlbE7twiG3BpteHOv1EAV6ZUw1L0E4xdzQvun9K9MgeJlQRf5wtsyRt8L7GcbIMj3JKSP8nw12TiDuItl0//Jem29tDSBPdPzFacg2gzHXv9BRCEoTaS+gxiucAsUJ8W33bl6HuOEF6/n+NypDgjFHxrItodpLBUjVvwUh+TtU6CZd2HofiCE0EJLFw6m8GQamO7ecq13jfx1zdRZSU5W0gN39c31NitN8RAk/vNF2sVGT4WlEBDYrm55JBuXBf3vR7dloT8QPAO3iucGqmWjpgiLLaX2ucSpfusHum6vXIOSyFTr8E3yHjvglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZBfK04apAEDPAl+o5RXtN/HcPKWVBHl6E8E5+3Ygo4=;
 b=Z1nQXMOB8p+Y4RCkz9hlK47XB2tRlSUdEzctLZWz/LEHXKLwf1Q4AysPYY0ygaLKfXwSZLLHlTs+BJiXL0bK4gH+ZZlzXcvFQA3GEX4nePaT4xj9aMr+gNz2RS5pm9jHRU1xREHgtTtowiVQV8SPI/DrBgBl21nFPrRIfiiq1igQMeB5rIQiN4fVpbNb4rRqNmf7VvvdTMbuj9RDDJbFa1aCRBeYz2PxloGsT5pNYPRnAoUd/IdYHIVbckNawcuSL52Ni/akwAmgmp5cFPEHiYmg5oQO8pTj+PZMHq4qWaTufhUdWJOoA5M+R12tz5pfa7HSC7l19quJGKrebvP/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZBfK04apAEDPAl+o5RXtN/HcPKWVBHl6E8E5+3Ygo4=;
 b=BrBl68UcCtU3+aOWXptIT8EEYHV1kVFiF9AmZQ4UdCMYEFS+Qe1lAxieV9XdJSvV/tMvELkitd2jatmF4bmQY4Gjyqaw4VEMUeMEpJWc3G/HyiT4B8FKIdLd5LAERAcDNkMW4KWI0/wMLbfpa2Q/2TX6OafmDUOkjalYseAnGXYlKFeRPRoBp5YNMpN/3IWDM+6S4JbLOtlf6loPgb9/l3FmoZik+6x4igG+/H9e+dZXvNHK3px+EC/ehmKeVeDLXBU+e+wx0ryDc6oaPRK6DvBeCJmTG4B3OhCCV5xZdJ2rSFVBk2qZXgq10B3rohvDJaonxj+BA+303qU3hi315Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11031.eurprd04.prod.outlook.com (2603:10a6:10:592::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 20:27:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 20:27:57 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR IMX6),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR IMX6),
	imx@lists.linux.dev (open list:PCI DRIVER FOR IMX6),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] MAINTAINERS: PCI: Add mail list imx@lists.linux.dev for NXP PCI controller
Date: Mon, 26 Aug 2024 16:27:39 -0400
Message-Id: <20240826202740.970015-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5c0a14-9176-45d0-8fe5-08dcc60d922c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n+ouAMRXxt4ldhWSLJuAYAPEZtZ35/JuU4IXldgYa9nEKPKrVD8Om1WzdRN6?=
 =?us-ascii?Q?DllWivW5ZP/ZrO8/+gv8EfW8uH0YwcyZQ+nhgE9FwWyW3XYV1TbrbuZ9kTxG?=
 =?us-ascii?Q?gSJuhLs2VUs3qQ3EDgu5EU4CPlEC1Ykz5FS3rmPdsfzhnAlqNcpYnvDu/Cex?=
 =?us-ascii?Q?Eczl3hQ0J/dUCw9ZG6nZk3C9RWu9pzqKPEbcn9wn3Rst/lTe+YNe6J5d1rmJ?=
 =?us-ascii?Q?KPJ25+QcjeE+3rML6UJpXuMyMSarljTqCIKQF1FcnSI0hN48E3U8WosPMxEe?=
 =?us-ascii?Q?n0bMcMMygVjHk3twPSFy2tMLgGVnVGFtk+cmy6Mm46hX2pZmqWpVHsdfzcdk?=
 =?us-ascii?Q?6za+Ual/447Z7CY7OBxHMRaB29+gDPsKHnqsi6za3zRXIj5EvmzStYsrbIcH?=
 =?us-ascii?Q?z4OUsE/UulNypyjJDrEnsF/1iwwONCmPUV/wzvNnEwzX6dWVmyN0Gu45g4e1?=
 =?us-ascii?Q?gNuI9efnU2mlQjCGlfmq3OANl88xGVmW8rl05FZE24ONtPsOOQw8GVj0zJNl?=
 =?us-ascii?Q?7jSWT776r9tCbZ031i0v76gAENQthTya1rsJ+ngH9CTouaH6A4ClZAysypf5?=
 =?us-ascii?Q?8TvxR5RYJQEqV+01f1h75A4n9YunAyLbKJbQvkAskK3JiwRXJiq6AzeKBjYW?=
 =?us-ascii?Q?cH0s2uXli8JqE7/YV/ixuzp+6qND2QujQHq/Ui4hQp3FJI8POCcjxFWlOxCM?=
 =?us-ascii?Q?tAWF4ShwD3poKI+0V1GDBGBDynuf3ZqBG122huPm+Yg/zX9bN3OfEIXy1kk+?=
 =?us-ascii?Q?VF4EVtNhs/LWNeMTEoVjHjSLHfFNhvu69iMK6ninYRwdtrUPM8+1RVCkw1HV?=
 =?us-ascii?Q?MSKHq7kISh+7ahTFfybPX3nB4fkndkYn/9TEoOZN04NjJieHJ+KrUzatHg9y?=
 =?us-ascii?Q?H9PLv3Iw3hBJO6REvaXgZXNKCl7TpLTXcG2B4cHhybsUnSqRLNwm4N6r1yjr?=
 =?us-ascii?Q?uBNR6v+GS26Vti3bkG16+p5FaT3VcBtg3puunia9PdEOqe0j5zoBuFFZpOy2?=
 =?us-ascii?Q?VetSydoxqOUKkMSsDJeVnsaRFyp3rTp5BiBYGhn8Y3V6snnVvLODW1iVgB9O?=
 =?us-ascii?Q?nJuOZsfcV57/MY/WgKi82fQGTKLlACAdP3g9kWJGTezBhGmrs7fxJVDtRkbL?=
 =?us-ascii?Q?dXeHoaT6kJaFuokB4+aWnBnun5yAxL9FoK2ocwPprgK9DIKbCV1f2r9UX9a4?=
 =?us-ascii?Q?fGO0UAcJcOVH0Vlox31UI9A+tkZrZlzNwb97bn7ASz6WqShIqfB5o6QZUDui?=
 =?us-ascii?Q?gABifX8Wj2UbzFycle0LUYQ2BthEL9d1MsaAF/z49UvZ1iYSF4w9DvPfDJRV?=
 =?us-ascii?Q?N7aiHzD4FCgSLRlCo1aUx0OUfX/VzTUAEamnEyG7ixsg1uxyLEkCO5zZp4f9?=
 =?us-ascii?Q?hYneOc4RR3f9a9HtiNyIMP36aw3z0Bucv7sMKUofMVvfxtAs/dMqY65IqYb2?=
 =?us-ascii?Q?sZJX2pgV5Fc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X28tZDy4QGq+ML6facSQU9vo5FG+mk0nfIJ+lvQtWRuZstaaM5TKMmBgeOE9?=
 =?us-ascii?Q?/x56Yfg4/UhK/M2Mz0GFPqiGX4DHRsj+jbhpdlC9PeN2HV/B7ALbemRaT1An?=
 =?us-ascii?Q?ilR7irZcEPkj0BOe0u3TJ2Iai5KdEAum8XsCLYB7/PHLIocqIiQj4AhPu829?=
 =?us-ascii?Q?6PxOxZz6PHqXsfS7MT9xixz3wI/fTJn+2E1twx4Tt93UfJBLHpWNFI5jn31X?=
 =?us-ascii?Q?Yrs3O13AFQIp+X5/pxJmYrZ3LRXI34s+6xBcPhtYbY3/Gt0FDbaBtiBV66wH?=
 =?us-ascii?Q?UBHPRnCJABKa/zlDMNmeLzv/r2yOEcw86aJEf8SrsHh/XbbYBHvdauPvwVjs?=
 =?us-ascii?Q?Cw2ptfF1wU/cdDQrIk5U1YRkhMaO5gxhQzjh7jFKhdi5MCnDMqPovwrceM7m?=
 =?us-ascii?Q?dlvCTtnbYzdU9xCaQFcfaOamfKnZYSuI6JkMILH2GR5L0xtoBvED0bpw7sM4?=
 =?us-ascii?Q?QqhlI+kgg/GildvAyljP7xyeBwjYLmZtdGsfaznft85aY3iPiyLY+4H0LqMf?=
 =?us-ascii?Q?tmp4Q/t7HzHcAWVnlq/6EN/J/UO9vVdf+vReYeTc0EXa5+40P/zpSb0+kfM+?=
 =?us-ascii?Q?XLY2OzzwQl3ed2pQtClcKE2PlOf1VoRBsOU4HKj92yLpC2vAD9ibj9TI5g3i?=
 =?us-ascii?Q?L1PgR1mThVeJJ6VKL2kxtM8d+YZtQaMvukC3ZvfWi522WC0S8hqRTRJNKTbM?=
 =?us-ascii?Q?hGAc04uRlx/fJELPb0ecMSC6K8T0q+idgGEcVR5zWHa3IeZierbInQqhv7QN?=
 =?us-ascii?Q?iZWrlMsuY2tPaFotmhny1jEShSgq32qDMIaswg8oXvXPWAaAyCuRV/AiUgeg?=
 =?us-ascii?Q?+FgiHPOx/1QCoCqb/7mlhw5u0sQ1O2bmDJndTkRAG0vyuOVv0Z61UT/ATvKK?=
 =?us-ascii?Q?S3n+fRgC8w3LIqHSn/LmxKZag7uU55/12wO9xdmXSIBGA8KDqzkKw396wWGW?=
 =?us-ascii?Q?rSXtHIPbDBK0y5URlf18ZuohOMx2fJPzZIwuPlS65M4RxN0OhcZ9kD26fO0f?=
 =?us-ascii?Q?5vSDaw/E6IUsqOTLmEmQ+Vvjc8YMfC3JZoeh8GCNpHHGx+HFkb2POD0WT5tp?=
 =?us-ascii?Q?P/5IN4pb4UrfWT+w1hDj/QwDVZZZM86siUzF4xVIs4xuh4Kfi0LSdpEp+4ff?=
 =?us-ascii?Q?EQZ5g3voBXIoc4DXKDvtdo6xLKneOShlQovyhyGumvBPopib10G8MRcDvPVq?=
 =?us-ascii?Q?EtTJJQjQtYevwnySzNK2eggS/0S1MnWzFguluLZflkKDGip41AQfAez7oI+L?=
 =?us-ascii?Q?dFUO4GhaUrvdfSBFfps30DWZ+cyq5eJLkIqV2oKAvUGVKZpAHFn4eCV+Bktr?=
 =?us-ascii?Q?+aba442jK93KPn+kGlZPrgjKxUzIiwMpBFNb+tbRaFamXbGR2PylECkKejXL?=
 =?us-ascii?Q?mo1f/stTnFeOmr6b7LQiUataK5OkXfTFC55W7nSsTk7uY9r4esJ/P7Dx7Ub2?=
 =?us-ascii?Q?2p4z44E4r9O6urABvOm2Fr2+jV5RrAcCg3iEfw4CxthNh84wABHe0z1OX7fX?=
 =?us-ascii?Q?nUaoARNRxrIH81V4GLiQ2bs5Obw1DzF/EirNaDbB2kJ1lttxeTCbaAm1x5UL?=
 =?us-ascii?Q?52M0AZU0Dydo2C3eo/4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5c0a14-9176-45d0-8fe5-08dcc60d922c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 20:27:57.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dk5aUzKp/0x90aQ6cMqTIOllHtYBH9d1wl0o6Hh7SZA+aO6UGMPFHAfJCZFU2HexbKqLdh5Gcx2b24qijbu/bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11031

Add imx mail list imx@lists.linux.dev for PCI controller of NXP chips
(Layerscape and iMX).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 11272143484ca..22125a392251b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17545,6 +17545,7 @@ M:	Roy Zang <roy.zang@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	drivers/pci/controller/dwc/*layerscape*
 
@@ -17571,6 +17572,7 @@ M:	Richard Zhu <hongxing.zhu@nxp.com>
 M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
-- 
2.34.1


