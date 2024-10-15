Return-Path: <linux-pci+bounces-14550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE92099EC61
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69814280A61
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7B1DD0C3;
	Tue, 15 Oct 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EVQBh0ml"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD1227B86;
	Tue, 15 Oct 2024 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998091; cv=fail; b=ecBEm1G0XwbXO/VU6W4UWVDBRSmFBnHQuvAg/c//y0lZXafAvCnn+DWuTXDsgb6jnGqNyiKRhwTbfRdMTkBHUqXiW7sWNaXBIAWdM5sB2ka9AJf3GXyzsrEqU6vtI0Huw8gshtPye1PGpMr8kt5ffyK2guZFaTgJm3ShiTA/iIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998091; c=relaxed/simple;
	bh=YgZNB/EmSVJPLKDYKi47AleOk5ikPYICbIRo2U2baf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSN/EyN4NFJU+qQfF7I+78yBMF+l8EqHumBySTh7aQxVYLKAGbPCb8YnTe9jSsjFgs24NCWnHfFsPY6forqcfNpReSZ9lPC//bnxIE2mNb5dVs5S3jCWqpUU7VM97G4xk3ev+h+fJIRybLeppgBitTH5nsOK+i9lxC2SfZDXumE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EVQBh0ml; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEre3735zEUkg+KvJ3AC0h+pga26Do6kJ2TzgtJHV59/hYw7diYEth29onTKma59hzPiYMYzYfa3/ONgTOhDLKSdNzRtz3KL8bh/ZjZHN341J39hs0oRlAyBQlNevVj3u4rLRL7XVQN9BaVvS2ATYmbNeYIkSlkLLadgAfb0+GVi8W+FV3YGjeajh7H7lvUVvDa71L2ITSnEuJ2sIll64YOj7nifhliSKlItoV/1DJZhMLfqbLJyMvCaMrglwZHh/d2VMFwAIZscpUf7fQuGUv0PkPOYphGhF4aeKVLmuzWO81wZn/egL+QtxRhVenGL/7eUF1Fk/7I19iZrq+xytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVtYO/fn4p2g/u3b2G4C8Nt+g+55vkATBe26/TZIf1g=;
 b=lIUdfUpoBJr/9aGjSzDaQLBuNymnO+3kZyQewZNVtoO5orRiz9Vi+y0XDFe+mskyGTAolYAJatTeTxsqoSRpFrq8djBwhiDRVZH6bXrqHSV5eY/Jk2MGRb7+uXkkVnsjL+V+ZJeYyMqPSFf5fXQJRad12B7poDX+Wk/++4MUreYcEPOCzgo1FEZN4DO/B9OYzlInw9LlAgkUolg1gX5YJ4aT4wYGOpbGRs/63hKzv0fxQckCq79dBlaPcPqLazBx/XkWEsMLgdcK6GGKbmeCrd+xif7RkaRnQqIW4I51bN0nFxkU+Yrya/CiJXQrbGI6RfuSliRppsauUrQxPpTcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVtYO/fn4p2g/u3b2G4C8Nt+g+55vkATBe26/TZIf1g=;
 b=EVQBh0mlAO9rTofsSkPknL9uyDk9E1Y8EBOubr8KEg2lTa8uGW5WC3w+19gV2VJwAb8ukpswXlNGEHomXERo7mp/dD7Coh1TgsNGMrLzfz51n2iwi8LuewVHHfycH/JxWpBHWLuX/qqF42GqNiIQd4U+Q0P/xx2esovwyxYyp1jYRgKFV46ZMBwx+lMw9IR57ZhQ6WTEcegaWBEqfNhVxkt6JGUolcW1knQsNgpl1toHHh9C8Wt7iYiCW0288n9k3rfmiRp53GfdkNXjPugujUrEzCBCRI4g/wycXqc2NhAOTg8Ly+jfPp5WszHYg6jIq7ms1fBlWzIpuLLMit3hdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:14:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:14:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 net-next 13/13] MAINTAINERS: update ENETC driver files and maintainers
Date: Tue, 15 Oct 2024 20:58:41 +0800
Message-Id: <20241015125841.1075560-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015125841.1075560-1-wei.fang@nxp.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB9988:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f04ea6-d5a0-4f05-8ccd-08dced1b5779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OodAkMIoGsTe3CInzM7/o+L4UePet/S67hVgOvC0ORQ6iJrEpODvbB02KkkL?=
 =?us-ascii?Q?8vKoZeo01e6HFhLBKUa5MLK9XKhB2TZ/Xh6wOEXrlhqtZw4gf5+B+VCS9Hrt?=
 =?us-ascii?Q?MOH49O93XsSiZJt9AgGJ5RFxIBnTY/BA26AwRWBhv/urAxPecirmtrInWPrA?=
 =?us-ascii?Q?OgTC/cNHK14Gg0S/1HeyfdNpiVcpCtGRvHYdrpo31P4D/qjnPMEReGp9okYh?=
 =?us-ascii?Q?1DabMhSb7Eg4FHxHvJbnKS4ce45CJJeKkaGitYVE6MivsDHn/szJIZ9ob+3g?=
 =?us-ascii?Q?NYRtFUrY4nmWfYpcf9zlf60Aqy49sVD80dZI1m8IBgLW+7UYQHXd/+Qaa1pm?=
 =?us-ascii?Q?WgyOvblI65D9lju2W1hi1QxWfpjd3OIO+W25kS5yyKdfyJ1E8tJIQRiF4RIp?=
 =?us-ascii?Q?IG5xFrHTME1cWTITI7fqRj8UYT63uUr1ix0syZuaLhmOmKdQQyL4iBE94UMU?=
 =?us-ascii?Q?uSSwfIGHL0cAPyL+KmHqw324D0bCy2Al4MEzjeF36IfBZipFDwb5usdH2iMu?=
 =?us-ascii?Q?5j9AExm1XNvhjB3iI02jTfYcWpPC+U8oWo4whMQDEpsWnfVy525baK6i3gvH?=
 =?us-ascii?Q?hI0mpvnlZZxGY/xGua45WmZwAW7BogUgqhp994pf+gSAhUqNmH4RsxIzYXo1?=
 =?us-ascii?Q?7iG7JRCJdXqxO950l29jjOEPwGcZt98Z9SLpmz3b3uiFLZ4f9d6+VF39Tmo2?=
 =?us-ascii?Q?P80vISpGbwjsOZ2fqLlnjCeTewHIpXfrprdF6vdwjt7vXPazemf+Sk6DkiRY?=
 =?us-ascii?Q?l84QoJGzolZ4x5wo3Gi/acRaX3nnpKQ7Lq64Qzlr5/ig0zEFqrcRqa3TQHv2?=
 =?us-ascii?Q?WlpUmJOSTZJ22AHg6aQxgsTicIUYUlK7xPP0ExIOTeDArX6XwMfZTsziSKXu?=
 =?us-ascii?Q?S6JL9lLlNWdGajPIWDp1ox1vn8Ejt1P5y4cjzJvgvNGPV1lU/5Odd29rgdIK?=
 =?us-ascii?Q?Q5PwEZ+KpTGo5EWKVLRgs9wEGJHfWu7dY6BS+6xh9pn5du1DJ4mG7HZE651/?=
 =?us-ascii?Q?sm/wEKQavxieuE7rZTrzzRRGCztW+gIvyvKtprkeEopENAj5mpxZ6f60J0EQ?=
 =?us-ascii?Q?eA6jTW2LH1/VJyDBBkIJY85A+rorqb0uatRKg0PXelmd8Sjm4I3w/P99+rly?=
 =?us-ascii?Q?P9YZwJI7NM0cIkLpfyZrJUV80QlPmbePAZ0gFzht1oR1HunCw6FvxiaB5MvC?=
 =?us-ascii?Q?QZ0fIG8eJxWgnFKcDqbxxhTYJjGLw8HOoiS6/Ajgkv+VNRuSUF+odJYNC9vQ?=
 =?us-ascii?Q?R1tTnabrAcborbJQlYTYz6o4M9gmO/2p5Wppom2+KXLEUAzgQ4Of/WzN+8f3?=
 =?us-ascii?Q?84MDJKe15o07y2p8IlqAtt607Tchr3TDpdVGpoLG6d2XQ4i2BOn2fI+gxhxf?=
 =?us-ascii?Q?9Ls7xog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Tfsp1fxMXqnBpOjsMVB2KUTTGY5yFDc6BUe2jut9VCbi3H7dhc7wcDTq2cr?=
 =?us-ascii?Q?5uHOdDsYMOarwn4CVx29+V4crVYQFhxOq+0BktaB+Fq7oncCWm2+LZ22avnk?=
 =?us-ascii?Q?1IUr3zQWewBvMyUcAH25MY3dzRqmZa7jfw1XSVxokN6OpdHf0X1X/N0wq3TA?=
 =?us-ascii?Q?ZE3mMNoPlOB6c48783wyhTwpPDMVNfj929ZK7bJ9OlvPbRYCy7Z0CSUmPFPP?=
 =?us-ascii?Q?ugflla7zG22WpM8tw5bJ4K52NahrFxcwtemsRNtZBS4zP9iAgKTXw2wtNsmd?=
 =?us-ascii?Q?0s5FnyxKMQCZxT5L8eQfIV5ag+ScsMo6jrdocVP8RFg/IfmW4P9rBUTkcofc?=
 =?us-ascii?Q?KT0Jtqs8PH3ppE55l1HOE2jX3HCi/n0BEB5S27lKQl8DbmVhEXrPb5IV7wnG?=
 =?us-ascii?Q?ZoRr2Gm24sNI4ILhLvvCSEe8tEfHysxtfzbwcQdloEXZ/QctzoxZWT3QjlNN?=
 =?us-ascii?Q?gOI8X68Zn41WuiUqz2DmADdLSZcwnrFGnP9TdkbFS5AOkExIdR+SbpPd7cod?=
 =?us-ascii?Q?aRS3mxYxvX5cuapgYxltrmRKZ8fZxxWwuoIFRqCW7VG6O35o/tZErflud65G?=
 =?us-ascii?Q?8RDL+LExcWvi43/N0hniki6KBHZeCpgv93zlGOYakSz/IdHJtpddUjdS6McK?=
 =?us-ascii?Q?BXFWh6JfTJ/PnzwUhkMEMfS2QiWHyRWYbzkxR75Z1bpPT2O8Eesh9ZqtiwWx?=
 =?us-ascii?Q?/+bxL76Vk/uKi88lmfR68bh4FxwOWCUwDMCS60fxHLA3XKV6B9DVmxvgVekF?=
 =?us-ascii?Q?LDdblNzvS8b9U5xMeH9NDn+RdW6Ryu/J39zZBDv00ENJPmgkaERwe7gUIDTV?=
 =?us-ascii?Q?npoA78jTvJNR+G+S3D5rjfKl2ret4S15vuqahirlBB3ug/B3LFIIhhTVXR5P?=
 =?us-ascii?Q?4/R4DpRC4QNGQKN6PkuuqjN4lKFSbLb9lqfDoR7w40StXIyf92OyJ/uIOmRS?=
 =?us-ascii?Q?b1tNGuKbTcjc8SFmkbUdOc1KKhl6Raj4zoCGXUDGxOYIh34aw/7Sufm1K3HP?=
 =?us-ascii?Q?s1yASPh0NsRyg8xh0ske2iLnzL9BU6OUoD1y7EL1B/X+5ioxnXnhAJGiOlwr?=
 =?us-ascii?Q?zpNRWbu6j0X6jtbbol5vScrBoaHLQYfpEmG01vIFVrDpXB2royAv4FdzPIYb?=
 =?us-ascii?Q?d9nSNT+0o2r7bVCb63RqGzPhIiUDZFX+UxJ0U9Mqq2rfbo9/zN2Et5QDHq+F?=
 =?us-ascii?Q?GS7/QAedMo623S4H9bYwhQ/nymax/oM6aQxWA6oRxy6JPolpd1N0LXoGGSCv?=
 =?us-ascii?Q?eBWAo4nAvC2yvJdwl01YGJcOfnSx1o0+WTZg8uPtmRH5Aq97CE8t/etUxXGB?=
 =?us-ascii?Q?Sz7JJOXppSwz81WbhpYt441NQfPdSjQOUc5A9mjSWltkWW2o8m5TpGewOR33?=
 =?us-ascii?Q?N7msbg6D5BPEa7Uwmkqm9X6jQqp1blrw+jZzUbCDK/emdncSD8T4k1wx2Uwf?=
 =?us-ascii?Q?u59aFSAGxSZRQKentlDJLLUqPmkHXK2eoxw6NXj28jUtIGlsdF6mW9fnrDTW?=
 =?us-ascii?Q?x7JF82tsPrLhYCQw6pUDEdNZ8tESTa1rjZHyAwVTiaxXgf9ZrbQSbXbQH4gk?=
 =?us-ascii?Q?g1UaTXI6h3EgrRBr+8wsmYZJcP9DLidcu60vnlTO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f04ea6-d5a0-4f05-8ccd-08dced1b5779
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:14:47.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tq+r9FGnIG621JsA3+qE66Qay1IrBlG6BurOm5CSmu+dzd2g4Ikv2kpP1vgkc3+Jq8MYFAL+xQLzAj3J5HoSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9988

Add related YAML documentation and header files. Also, add maintainers
from the i.MX side as ENETC starts to be used on i.MX platforms.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes: Use regular expressions to match related files.
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 560a65b85297..cf442fcb9b49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9018,9 +9018,16 @@ F:	drivers/dma/fsl-edma*.*
 FREESCALE ENETC ETHERNET DRIVERS
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/fsl,enetc*.yaml
+F:	Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 F:	drivers/net/ethernet/freescale/enetc/
+F:	include/linux/fsl/enetc_mdio.h
+F:	include/linux/fsl/netc_global.h
 
 FREESCALE eTSEC ETHERNET DRIVER (GIANFAR)
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
-- 
2.34.1


