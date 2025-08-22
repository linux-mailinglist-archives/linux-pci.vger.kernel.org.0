Return-Path: <linux-pci+bounces-34537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E2B3123B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 10:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CBF5C8A70
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 08:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191472ECD07;
	Fri, 22 Aug 2025 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HsmR/Otg"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F972F0C7F;
	Fri, 22 Aug 2025 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852300; cv=fail; b=X8WOqbmCR/ITrl0tjlA2GXVg4eypA3/1ck4Mc+2zcELe3zNWtXfFDLkJpscVxveM9ujHzlgO2NoMVkEV7e2qrJSy69JtzmpipZsisRxEQv8fzEov3MK4OBHG+7NpUjTChbUysEdv0tVt2aaI9u8Ea6Wq/R0MYOwtdwaa7T8o6hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852300; c=relaxed/simple;
	bh=kSDs+qlaxQku7tYx0nsgVM2DMtTWCysI0rx/FQoW6R0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIM0sdRdTw4vg1hzOi170Af99d68K+Elff9UxDl4ihLFdgUg9V6DBPBnOre+/WYW46+cUonyS5RA0NDpTi76dLIHfEYEIaFOBKPJtofhX3SKA4AMpOAUfPo6OCBAdshdkLgi0HGZZB8fW3qvs65p92xUdJJIoXHGMdetIA9MZqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HsmR/Otg; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2Nsto3C/09SWlkNPDA4rWQuDf/wetOHDLt3LoqlAby5Qd8ewJ2ksA+Qaa77XVmW8qJZV1pISvQ0JdhoJiATTgmruQ29NDJoByADaFApHTvwWn2n0UCrH1Tg5RHhEvthmDv7dQzlMXGmgXSH7sF8bINRHXlz4eHk9U9G+w1EGAGYkZNXdVEZuCb4HlPABa0Z/cXyG9na82DigyH21sivN34DzmpAsYQl4XQxwfC5TQqFk8pea0nraT0FhNgADPoDL1aM6OimyPrZgPW/6Z255UG8oMB18FteoEeoa3Sd9D8Sw/xbcvSx2aP+rMIHK6hfz+SzVhHU9/uKxqHmCrqbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyIJAX2nMSkvnz2EID+bY0AXw+2Nvbs0Wdm2JplcXsw=;
 b=rQwazHln4DS6yOKd4FvxynhHQA4zsho3kSzsCUKiJZIjAoMAL9uOmP8tIGURz/Z4x5gP3ATBXCIGoDrLfMfuV/Ggp8RglVdSvFqdIZBDOQpvtFD7mD0FxbBjzfwRq0rGKb6/WQXNy7r15aVaEhJP+A8P4sNzLxcImai1Lgjb+TWbWHNovlhnsAqIk17dTm040gtK9RFNBbVZ6KUeTF+T0N1/uX+WTuw9OatssUGC3VjfZjusJ9HoOuSzc8f8LwiqLA+Crl2mYGBbMIX5YAdNkAKkGCxGJMRTUnjFrS38NAACNRVtQfK3W3+IIBFnQWIjK+LRCsN9NlViZi2IujfUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyIJAX2nMSkvnz2EID+bY0AXw+2Nvbs0Wdm2JplcXsw=;
 b=HsmR/Otgc8KGUxZYh51/veswSnZQRtLCX5fTuNcyyizGPE5r/HboB7gPFlp2bmyDEwCWbx5tPeJVJFEJNQDyEI6ZpizvW0afE3G/MWhCacO4QbNLRmFNJs7GPNHJcqh3BxJIayxqpK3EVd8RJ2xD7LwnrK2Fzx8w/4GjkdiaV3MMBagiBIW57spIXHVMrfQjHEf/7W9NlS27PcJRxEH/qgFurSy2nqs9BELf15cJtfoRZa7B9ci7ikL2zmKcfyChtq2SwXx7JtsxzfPBPtIYMMZ+swwKmDx35nDXCoPmpf1xLPdUvCiwP+Ito6ROzZpLsEJCOMZArb8gMUs6cVlo+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 08:44:55 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 08:44:55 +0000
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
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 5/6] PCI: dwc: Skip PME_Turn_Off message if there is no endpoint connected
Date: Fri, 22 Aug 2025 16:43:40 +0800
Message-Id: <20250822084341.3160738-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250822084341.3160738-1-hongxing.zhu@nxp.com>
References: <20250822084341.3160738-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA2PR04MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: a41966e0-8761-4b94-c0e6-08dde1582a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|19092799006|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hs2wXB2Qyzvc/i01gH1gKmuGrvX4GbDYPrKgd+AdYl5fqCcZr3daSigymR9+?=
 =?us-ascii?Q?tPI9mh43/LpC7zp2650Uch0uxx2pvbcygH2awIv4eOVVsvLb9kPwdhh/bRxc?=
 =?us-ascii?Q?g8xcHQhNdSQquvYo7N9X/N5XJNRTTSzL3HcQcQ3u/2uau0QjFtjNnjkZpCUw?=
 =?us-ascii?Q?+3albABFElvRYrC2vpO2zrjjC2Uxt5j5c+shYX7m1Qcfma7cRzDnDK16ET7B?=
 =?us-ascii?Q?8JaL0Qd+FvynjCpRSOM+grG5ip2KKncBYpybN+G8VwYnVVcFFlhoqFCQTuAc?=
 =?us-ascii?Q?5+hwAGZQ9IKjvpJamsmi4fvEUwDaVAFpCUNGvzx5md5PeRBTkBkiH7KtSdIr?=
 =?us-ascii?Q?lYU6ixqQNRn/oTPoVK/aswpeyutYdhaU9NJvpVXkZvnaUodSxJeXduKMzuZ8?=
 =?us-ascii?Q?yX1FL9MuWo9rfcDMyxEGPfamthNYcaRNNFKXjuETZxUKVXqMD3IL4NU1c6P6?=
 =?us-ascii?Q?vSelgHi6VRvf7BZCYduuVDO4Cugf7WCwv1IH7q5IuS1QZO7UVznMfAME8Koc?=
 =?us-ascii?Q?sNLMhUyOAVS5WCq8K45LzlOdVTosX/uqw7b4yn3BOJybM0tSW2CXXx5Xb7E2?=
 =?us-ascii?Q?SiTO5K+0/EBCe/MFd6mNal9usu4HWP5bbEzbi039PFGBl/iuHw/TUT/uIKJG?=
 =?us-ascii?Q?ZrEx2tRka4jMxUo49Bc6FXPoChnt7DhsjJ1WIkynj2XjVIDl02FMSLl7jQHA?=
 =?us-ascii?Q?Q2qnewImpnXTlydnMHEKvejS/IPWK9gfwlfVF+wlp4LHiKigWcFNrKJfCkbA?=
 =?us-ascii?Q?R4STQSKQ4BJ2s2dcUysbjjxyN8I84DbwYgsjkPW3XVZqVbYCfgzEvsr9ueti?=
 =?us-ascii?Q?S5XWfTGu08RhEZ5BpAGt2r1YtIGVvYwvSNa5gfTso8Zsvdzg7OmkUkf9Ud6W?=
 =?us-ascii?Q?8gM9nsT4UjQ9Bh1c1VO2WSh5enT8Evw1OMzvtyIBVLEvpiHMQ7+a9lUGUSB+?=
 =?us-ascii?Q?1fMVeQ8HH5wFF+veXmnOdvI2lcPX/hhJm8ifXISvpijQ1XAGCpQHTOkG0Y5V?=
 =?us-ascii?Q?XRHpBXELc07h+PkjyvUCeXmnBHFA506G98hV0x4nvenpl0WxdMUhzo+puOVM?=
 =?us-ascii?Q?4XHcNzDpaeLQ41RhzW0xiUNPLm/Lxze1dMVmG7x/KY1P7MtXSbJ7HenYGvXL?=
 =?us-ascii?Q?pbwVuAnlMEucPNFwY/CVvyIktBzbzwexqUXaabw2tmTS3iuAFkGO4JDjF96J?=
 =?us-ascii?Q?D1l0G4uGVtt8jJ1zSMFqyvdgQYLWzw+UEfrZlvxJUrgH4jp8XFNLdgyYSaUv?=
 =?us-ascii?Q?wfVRdxNoTn7ybM+l5izGf7gL21tSIExctGRpbprH3QFRVvvHBZYSoMhi8Wub?=
 =?us-ascii?Q?v7zJdDIqT4BD+YSO1bYJsdagAeOBzpjjkpCDsfdqDXMpm2aHprOhSpU2ijXR?=
 =?us-ascii?Q?t6KNb8RCJgrgCD/2FbEINlcKx0Dg7JRj9hen6gkoKye/5uPVDH/NNWyqulwV?=
 =?us-ascii?Q?DdHQS4lcOHnruKQornrbZnHIJ3mIMjg/tPZtxWv8a+C2PivIBDhaBgWMuhkm?=
 =?us-ascii?Q?csdMjO7126VBko8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(19092799006)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4FhPWvf4zeKPQNlH8quV3tIzo4NdiU8UitiraIogF+RRH6DVQgXOGsCvEMqx?=
 =?us-ascii?Q?I1sElolbiCQeC8m/UQucxeoEGWbxh/7xXCoI3sQqFuvU6myqOLgFTH4V4eas?=
 =?us-ascii?Q?i3ZNYoy7d6O/heYyYMLNYg0o/VuW3i2NCFA9ahM0ZltVlh2t4UXJq6M37Tvb?=
 =?us-ascii?Q?krsY1lqwyNNvcO8Vt3hwBw13yBgrATtdGAvW0eAV7kwnYFwWD5zV2WTO8PLM?=
 =?us-ascii?Q?wo3bsLbbSJ9QwNpd9iguTuzFakpHOD1C40tXR1njiGZ1+TADPNTGrlab3ZeW?=
 =?us-ascii?Q?LKEgnen9Yjim6++A4H+BSZ3sZoZsDCv+ncDyVMHkf5GPwQePF6nBTcPLLf/w?=
 =?us-ascii?Q?A/glKFRVdsfxjhtOzGid+4I9xNNbMFbPryXemT7rpicWnaOLOMnwfnaotth2?=
 =?us-ascii?Q?ru3E+OzqsEKTZQi5pVP4Tci+JmbT9T2dMV2BFyeG3PT0iEpWOEgTbqVgAflN?=
 =?us-ascii?Q?SzNPiWnSH7E6nYXlJLQe7/rdnhKmnHr8fWCnYCO7KMU1Um7naNs01AnC96F6?=
 =?us-ascii?Q?8PjnJj6OvD3am+1fxuLHQF6NMuaOYobhwRDjVtxfHD9A/11zRqt60juTOfHU?=
 =?us-ascii?Q?nibVawvhx7GYPcocZdrhsLKVk+4Vba6fu50HbnALXxxVho2iWQrs5Y5t5itq?=
 =?us-ascii?Q?vxXpa7/AD+WjWvLiGN8LmqWnu5syKi1gbJtowYYm7b2sPQB51OTtRa6pxkzw?=
 =?us-ascii?Q?BrSJdef7f0DhQ+Pb8a81k44wO5ANL4PkUzUa9aVTfHHZxPDc7JJbkKcFjIMi?=
 =?us-ascii?Q?iOTWMh1YtXVNb04lOPhSvr1W386PKak7jUcRP2e551yyfJB/Zam9dfkE/pME?=
 =?us-ascii?Q?0Av5qS2fnyj75+C14OsqlGK+mxa08V03w3sBOFO7k8X62d89GcDr2GxmvwDy?=
 =?us-ascii?Q?FsTmnaouzKJW3Qh8uMuB6FGlMYI4FQH/1cDvXIWOw66W5VkxE/Eq3gRumfZs?=
 =?us-ascii?Q?qV6UY520icHkXO5wXcMhX0YAqiPhLkLHGQwZnMQnubvVH4yrGVdlsG04TqVr?=
 =?us-ascii?Q?NJ0gFRiktt004IbB3bOb0U6BFSy/Rant2g7UNqduv5xzZMm0kth2oCIkzmPv?=
 =?us-ascii?Q?xNXoGdfMLCRCzmaTqd39A9Z9amiKpsXEMWHNstwSoKFeEsNWzpRDoKfXYZXF?=
 =?us-ascii?Q?g4WB+oWycn2qqetNDY5Lo1PDTM7qMQI9tEW7GogwIXAhIP1X/Ai31lVXKamy?=
 =?us-ascii?Q?O2eJmRUrhDhW9WmUNwJy/hImKodjkNh1jT/curnocerjY5hyHM1OiCugag8O?=
 =?us-ascii?Q?mgiQE5PsWiqu/TJyMQE8tHVr+koULY3GrPFqDKBFdG1lBS5pAsKYVXbglHFF?=
 =?us-ascii?Q?iuShwYIAsScD6Zli/iVZXIRtJnu7MOinpiCOrWN655VOQrYW3fPQvUCFZB/d?=
 =?us-ascii?Q?IcC2dcGGi4u8GpxtcqXwf+ejVkjuXOZYGw4FzVb+F+gtbePfLhr6jEs9vBX5?=
 =?us-ascii?Q?wo2wm6GkLUi8c5LPeKn1Ca+02fU5ZIS8a2V3k3y4jrdQ3jvw01V+o6bU0w3j?=
 =?us-ascii?Q?geetGKIb7TRDaeVycGFMmpXFcTUpSZWFJ2IHCFBABxLQE6erguuPFl8yhGaV?=
 =?us-ascii?Q?mzXr+351tfCfn2jwwigyAiR9FfgZgE6tz1pYPCcc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41966e0-8761-4b94-c0e6-08dde1582a57
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:44:55.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ScXJPMpcr7PVcW5X4XWe2gbRa8KnTrCSGxUjXBMNPsNmkjrczHA/851bSdZEr4gLLmx5gw3Ms/W3qWaO89sWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187

A chip freeze is observed on i.MX7D when PCIe RC kicks off the PM_PME
message and no any devices are connected on the port.

To workaroud such kind of issue, skip PME_Turn_Off message if there is
no endpoint connected.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 85740400a8d0d..fb5639c73e29f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1009,12 +1009,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	u32 val;
 	int ret;
 
-	if (pci->pp.ops->pme_turn_off) {
-		pci->pp.ops->pme_turn_off(&pci->pp);
-	} else {
-		ret = dw_pcie_pme_turn_off(pci);
-		if (ret)
-			return ret;
+	/* Skip PME_Turn_Off message if there is no endpoint connected */
+	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_WAIT) {
+		if (pci->pp.ops->pme_turn_off) {
+			pci->pp.ops->pme_turn_off(&pci->pp);
+		} else {
+			ret = dw_pcie_pme_turn_off(pci);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
-- 
2.37.1


