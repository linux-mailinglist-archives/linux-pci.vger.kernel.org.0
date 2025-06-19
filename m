Return-Path: <linux-pci+bounces-30171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB013AE0188
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0BE5A4FE8
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288DC261390;
	Thu, 19 Jun 2025 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I544dBfQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B842673BD;
	Thu, 19 Jun 2025 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324471; cv=fail; b=qhIpfu8AFrhbexlKYsb3HfA1li/2AR4bWjBdlpM9bX9WKfj6GAKr4WagDVC7cEYpHHlcJZMvX5HJdJoXuTdTI0SCI5+uModSnzoj68EB/Ev4izh6cy2kj/OiZ6/2PusG2e7CX4EteRDZcG4zYprjgYh/1jOpcWjgbcC1Q5e5k08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324471; c=relaxed/simple;
	bh=zfu54HCXl/1OT21VFfC0fzTFwxkWioWa0xTe1UwVLrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYj7Yuv+xLfQ8swp3YNrEVFLU+xvTchLtl717r9NRIJmY0aWlfK6xQXshWEi/kKkv+w/CrdyCbFs2zJAd3TJmux0Or4nVdGx07fZBz9oR3Le7Qe+AEbduAag3+rr7gGlG5euaNaVzGDnh0Rk3U3qrnVdpkAUo59qgYloClUP1xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I544dBfQ; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufjcihkSUCoEKzWufu0fqFrDovzLLulRx9Yezqmua3zo8A3ebcBi6n+7RdZdxcjkrYUFmh0eqdM+v+fDQadqboh88CS/TknQWSzBy83Gu4R41Q2zch1twraz2R+uT5l2l8RYz7F/w2gMQRrQ4HhB+tNEnQNgnwFUPLQNNoqApBjj5myZZlmtX5MVPcJMWgJ2p0W4Ff4OL7VbHwdTgl14CtET37E2rQFHZuRpEAHMq+CjY20lqHVb4wTMUSusfTK0gx1Mtz3YOc5AeLDZgBvIVqoleAet4l9wpA+GIwAQOh6nWoQqZx0NSNpga1dsM15NjAijJNyJDAs0hjPi4wLyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTMvzB/EsyVGyMym+l4MxGNuLFj8Q5x+lfAjXjfIsmo=;
 b=F2cNrAhYNHjPftcS27hRqayz/Hp2X2bT78M1PbhZu98sYjTrqsF0kX6fwwFK7UFMRPYIhJcoQ9QMnOakoBXLjzpODd6pptiEwirVpjEhxu4gc3f/TXZXzBgc7eNGMQ5Qu9TCVa65PDi3nkVafd6Tu//0WMhEh8NriDJ7/3V3BOQeoZNGKuMnOAYz1RQ0aGYBbZw8R/L+OE3JT2myP8I2AoPOBiBrTPhhYSRrAN/9k8S2Wbpm1h18wHUHBB+LUWJHk23uTBxUhUIOeoGwIlFszEHMtbf0aTPOzCiDCdT3pgweQl2gbW926hTF6jcQJM9Q5vYk/nBZfSi1waiWCpIbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTMvzB/EsyVGyMym+l4MxGNuLFj8Q5x+lfAjXjfIsmo=;
 b=I544dBfQdSitfhMJtynetwUrZoxLTbiBi7LclOqgdpWkjaGVkmbagC+q3vpHFL9foudVWvwhySqFSsBhAkSAminuNVzKKFaaYWA51g9Q4INHpJZloyaL4cJ1NyF/ZDAzMo4r3d7ca5SG+2x5YDHEgv4pXo4gyNHtKIOXSVPG3eFxNm4hmzp+TC1AaUCRptgv1D+EI2t0D+lKpmOqYaxFgshmKAGdpC32UhBF0ruCHbV+SEGqiEeGj5c8we1RHcjm8wtgevD3xtRui22Kcs4ibQzF8GMp/Qze5Kv8oPLfHUPTx6XDzP4Lq/zeE9OzAtqEB+J2ethf5FIb8Fg5VqSBkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7021.eurprd04.prod.outlook.com (2603:10a6:800:127::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 09:14:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 09:14:25 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 2/5] PCI: imx6: Don't poll LTSSM state of i.MX6QP PCIe in PM operations
Date: Thu, 19 Jun 2025 17:12:11 +0800
Message-Id: <20250619091214.400222-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250619091214.400222-1-hongxing.zhu@nxp.com>
References: <20250619091214.400222-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 326c85c6-0b9b-434a-ce9d-08ddaf11afae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GnlAw/B9nX1oGMVsdBDHSJ3l3JOqU7dBFbuweyG1RipNBjybTj6cgZssD8RF?=
 =?us-ascii?Q?UfCIEdnLnHyBYnxjkTof8rKw6lRD9EfXMyuvBGO9IKJRrTiP4b3PhlFP/KdO?=
 =?us-ascii?Q?DXO6vVFNSULkEB58I6WXxZOLpDuUH4Su5JuaVp87P4wm7PSre0O7tDf/7cKY?=
 =?us-ascii?Q?nyr3W5jo9BaimkT/L5Z83y69NSTxzVpDZMt/loHrlVbr+d/NHsuswGRKaR4h?=
 =?us-ascii?Q?cqxdhgHJlmOMUpfI+4Guv0hRUPIRvguXs0UuXAuV3VIKQDK83V9v9e73ffbE?=
 =?us-ascii?Q?tezE8KxfiSJqOrHTNYUzeGdKHEKXl/9P3FyGZCZDO3XgyapN/nLtyycmFqmG?=
 =?us-ascii?Q?AbqW+SSAyURoIKa5i/sdSlUfENc02+9S/5b9L4Ef2jp3Lzd49nIuXYEs8k0t?=
 =?us-ascii?Q?0ftBF07Ebwz01rziLuCe3sYa/dojuyrhRiiSCOuSH0XNzm2Y33hyXrzZ/JNF?=
 =?us-ascii?Q?towgEvFx/vUhaDckSiMyeKzwKznq3ESOeEvY9BlZL49urcpMZvwIkJ1i70TY?=
 =?us-ascii?Q?qBQUIfh+ldmSN4q/FGXnwqqLAW22TTioaoXfqtqR+4CEEJ+rS6Ylo1Yqkq2T?=
 =?us-ascii?Q?qhmw5EEvxZK6TSUdTXn4BxsWbW+Gs6uRPchyLvmeI58d91aH86pSTexR048R?=
 =?us-ascii?Q?IsF2MmSoa9VQ29m2e762Ehoc4GmFQZ53uWij7hENcMXgKaBeJvk3oQ6xMfK8?=
 =?us-ascii?Q?S9rMXbI/uOqnp2U6+Uq4A4+O+XOC+J66c4UVaCdGLPjm2X07qfwKTh1j86hY?=
 =?us-ascii?Q?Ar478rCq4OTnSovPCbT+BCGe88/LI2Yv4JNV5tuzxDYVY+xFaL9g/fchAwjY?=
 =?us-ascii?Q?RTX+w80YtTR1Pq6lUPc/Td1h4cVxDcLIw/W4sbTcgrCDXffkbImlWPMpMHMf?=
 =?us-ascii?Q?NKNYJIN1PonTOAF/xmsmlKss/1I0vhLEnFNloAqCE68AWdYODRdcTrZhXRt+?=
 =?us-ascii?Q?EwtYyArjyJWSUB1/ik/QgtpuvfFqpLe3IoXj3csNhtNesp9Fod3xE4dbrTd3?=
 =?us-ascii?Q?Hg5wTH8vgqonH+oQj1TiZfzufz1KUc9ZJCng3zzkNjk0K4cUoo/N4UC/8Joa?=
 =?us-ascii?Q?84nx85xkLURwu+WawX0aitTxZxFNbqLc6jEXow++sGuUF12dwer7AERPT4ZV?=
 =?us-ascii?Q?IWpK0nQWhAU3F1Ct+vkFft1Pvgbuuk9AAtpiE8oT7p91U/DFjZ5TIbHOTytZ?=
 =?us-ascii?Q?TD+EHt1fowiVY8QUshtK7P46sE0dsRxB/sO6gTjvIE875vnmTcTBfr95gxaM?=
 =?us-ascii?Q?V7KXIOLGMXVTRLxJHr0h249koFRGiKoFgVrjvkLMkEQQuw8VMD6kIr1TlIau?=
 =?us-ascii?Q?fW60JOi0AMTLjPhevS1kpqm48gx92CPLGPajkAt5qfYyzaHfjPA+6iJHcd16?=
 =?us-ascii?Q?R6NqvOJ6NL4k8Zo2PafTfizY6HIOwgKk8TYlOOLOh0sBNWZV2IVRrnV/tdVF?=
 =?us-ascii?Q?fxpzEMFK1jzA54btOe3KaO3c4JV2cXwrAjtFPSNHfOegoeDWl/FwNchDl/id?=
 =?us-ascii?Q?Q/3f1nT0CRRmxAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QjjnuRr8ZB2YbWOBcv+o3QU89oVPG8ku9pFr8NHttFTVYFTIqNT1GlDcKQeX?=
 =?us-ascii?Q?s7m5dqKIVurwNSWYWcXfJDlSCQZabljly9yixRpsXM0AKARPVTyFFIw3lJwn?=
 =?us-ascii?Q?7XUbl3vDdz6oXbMboXNKJ2TOt7ezHyqfAy5M8fz63kIzSZzTuRE2xy2VWELN?=
 =?us-ascii?Q?2jikyla/Ol/Lg6HbFfbpF4GVbavQEyrOdP+uaINWBY73UW+0i0ORTrNi0O8S?=
 =?us-ascii?Q?5I1V0mSOm7ywWYjZgYyqTRBkRz+Ld6H8Z0aaFgO+DIWvecTJpOzSdpUTqaId?=
 =?us-ascii?Q?Mz+F1TPuN3iWmkJSDQF7w3o4FU+HcDKFKFXrrZbBq1n+rwCXCTnK7YJDJF47?=
 =?us-ascii?Q?jIg6ROrN13dZXCk/E9phuUV0jj66dwoGCkheQKP7ZEOFVyRvxFhJsJtdwL3k?=
 =?us-ascii?Q?wFSKiCe6eipGwEzlxRHo/6QzzvzqpNtNcBr3qNJUFTjuYnS/vdeHw4DSKdJm?=
 =?us-ascii?Q?pGmtzFfEX8+lav+RpGmQOeOvugusGZcbAaMIkd8KJwFcNqCNh/Kc4HdNGeSk?=
 =?us-ascii?Q?O2o1TGuKPehcEDvTWqJTOGZ3G3n04xI3lOw7+2RqwahSsP5A+gFWKgtojnkM?=
 =?us-ascii?Q?qKqgjFi+izEhkHu5WD1kWOAHS6MX7Qvofd+xyp9V/5zJuudEVBMm9+rx9Gv0?=
 =?us-ascii?Q?G6axmX1ZmDzktwMqfmW3vDs89oZRh+tyEwvHD7VTSzPuogUhnnL9GvIc3wDX?=
 =?us-ascii?Q?rEONuE9nXXn9L1NDbKn+UbyGysaWaZgBlpHPbynCQs1MLut9h3UEnTN/32Hs?=
 =?us-ascii?Q?oYgj+WnppRiM3KmtacSg3uzHtO4IO+4Q1cgneQ7OubUCakdIdbjbtJ1jm3su?=
 =?us-ascii?Q?H6k5hQZhc5ciswHlKr3u0o3qOkjfogDYUwrA50ZDacKay9ekRxoztCqiI9cH?=
 =?us-ascii?Q?hS6ihLv+E7rNzWXFsO3IAVjxtpLu7nj1AUaPbOuZPnQ38MkiOPHrtsDz4QSF?=
 =?us-ascii?Q?oiZMUWqfqworQCQErFUNmr8Q2/Bxv85j0RmIupIsicC/UqICwqyn4ZZAEioy?=
 =?us-ascii?Q?RYZpUfit3IeyIYg3UQkenlVOS2qzaow11uTwB+zcuEpxHmi8J4Fur1b8Mpbs?=
 =?us-ascii?Q?nntI5PXpzhmvokWqae+47IWddMK1B76QTycCWdwUpltBmZTkn5lQEGOFw9T9?=
 =?us-ascii?Q?9bBWxYSi3YnQpfR0kG4X2UOKEAqRbzkmygFs/iZa9nzjQtIxbNKyYVa5r3v7?=
 =?us-ascii?Q?HX51umvdpq6nj2V249No5nfTd/5ZBy5GMnE9Oqk0h4Sqr6byxESyAjykTmzQ?=
 =?us-ascii?Q?54kKTKpBrf2qSi8alSANJWsZVYPy3aEpFXPwvTC2wjfweyHlzgdyRZj09qpw?=
 =?us-ascii?Q?NP8F/sVH/uDwH1/Mt9hymXq/4DPEqpLBoe3ieZ/D9GH39g5ZmmevU8pJImRN?=
 =?us-ascii?Q?P7NaHrJQQ9crkuz0pjZ/Xw9U15K8NVf2IBTciiGKMjN/Aw9nvQGnaRJcuOJZ?=
 =?us-ascii?Q?WZDznWRadrfMvcl0JKbKWboya65Dce+S8F7ayTUQspGMjum0/Qry2lZwrlLf?=
 =?us-ascii?Q?LYvLt6ZBP+Fthei6/W+hs35u95NOUSFdrACHEK/CllpafDdSJwvTi075KNLz?=
 =?us-ascii?Q?5JZmrJZ5Ur+W+6LyVO8G8MyuZbW6Upk+msf4CZ7r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326c85c6-0b9b-434a-ce9d-08ddaf11afae
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:14:25.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trM49lWIa13+xd1wzL8/0zTAJOcXaSLrLljVKIM89ApSWySXD72JKEi11DsI5ceXrLto/uD3sPcnMtFLCwITmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7021

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..8b7daaf36fef 100644
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
@@ -1759,6 +1760,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->quirk_flag = imx_pcie->drvdata->quirk;
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
@@ -1837,6 +1839,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.37.1


