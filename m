Return-Path: <linux-pci+bounces-25976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E62A8B009
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B963BB84C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E322D4C7;
	Wed, 16 Apr 2025 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g1vYZaB4"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208C22D7A5;
	Wed, 16 Apr 2025 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783770; cv=fail; b=YcfVO6qln8myhvPKiqabbRu0eNxXJ7gpy+8q9RelK/lYmx64SFu3npu5qJMypXphUvULPGHISVFZbtoEk1sMapb0yIBE+cjxEG5eDsnpABvO+yKsFmhYmmercllRkXkWr6Co6cGkjMksnh2bjp4PMfKYNwnT3Vwoj4lWtT6OZZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783770; c=relaxed/simple;
	bh=WaqQmKsfvH/WeOZN3jVoSkWGQBlGBnJA10N2WlCTpa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K/7mo6B/vivwtXV6elyIUSP9HcrMvvBYMc6xXs8FjF0/7K/MmsVLuOSucRuK8dOjz3guk1hH73BseaaZILYjNJpI9+bKgmojWeDBY923Ny/l0YKFa4zakUiPdxvDyKHTQyKxlq7HcFtYm6GGQKZDXqqkcR0gCkOhiRN5qn74poM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g1vYZaB4; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmufXeuJDWjTR820S2UG+K1SM875HDEu2h9J2iZlGUSyLQmdaCdWHdYDULivRqDodLCEIiuTXsBNvzqFNyFOH6gGQqRZTHbnv68oIB77qhjzhR9MN/wl+qRkOFVFKx2BW/R5CB1nfwVZ+F1nsVvp/eoEUa7wjXnCsUPPmUhZuOIXB54e1EtDQQaiGJwtVCKodJFt2hPRPeUPpxgpkawZd7qt+VLoel35etAxrur8YN9WCh6QICsoC+EI+hh2/pwcp87WhtDrWSOQ1+TAHxHRIHGt4CgoALGlgfQDJI66VgfCrjr9s/sxdKv/ORpz9NAggEV7SxxA5VRw9mntQyPt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/ZZpQ8LxIFPxxJvrZewL0fh5qESFxQt9iOTACQH02c=;
 b=C9Pp4Y/oCQCMFYDSYhbO+HDXMkf08q+BP9niwIffVGupGXEHJghSwjmLmWRQzGp4Duat7evWiuPKfE1o3fa+rwdNFYTF75bNsyIIlKN+YHX8wbPqYZA9Wui9cBJH2DTXCuQMOHtJ00d0WmBXMmxEJo92HR1jcXyFTQUISd6a1EBqDOcJDm2HM/yQhUOTs4oifTnXZhJDgRys1fe1tdGaTnPUoqUD6hl4LOxFPZAvvkJ5lffRGTTFwSSSiUjZOyszWoG9vXRpyF9OUd12Nqi9DDAhY1UwDpjFhev7wvPFpxkopEQypPY1f8sfg8fKSkxFfsEI89d+KF7NC7t6sl42Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/ZZpQ8LxIFPxxJvrZewL0fh5qESFxQt9iOTACQH02c=;
 b=g1vYZaB4JUNCEj3LAWCSh7bHULhxd6vJ3P4kvyYlkL/oBNgRYUoQ0addAic2TG8BWr4Bu02RMbqPKmtsL6x/EB5u2WHtqchfx7aumADAvaNhvVHfR8pH8C0FNkIrqJIgQ7Uwz2hZyDgaeBTV39pSwRuQ3jKe58R9fpy4pN7NlGGpfNxKBLm4OVy92Hu1gyCZaBujEURIFrJNOxFKmBogBm7ZZmCvr5ZuWZ6yCdc2YI+JKR5S+PVYaM4yEexa4kotnzViFGtvBHofTC2jTdExal7Xxy+ope1cupHwEKxAzncXtdmCOUNWraqmAloo3USScFntDneV7an0usWT7hq6ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 06:09:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:09:25 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
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
Subject: [PATCH v6 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Date: Wed, 16 Apr 2025 14:06:44 +0800
Message-Id: <20250416060648.3628972-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
References: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 8361e8b5-9011-4e66-3df7-08dd7cad3d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xAy1nKsb4V6hnC828RsmwecOdFI9WUCReEppPZ80opqw2YPIbFRlH4nFim85?=
 =?us-ascii?Q?BhrFD43jO5tkGOYP3Im/CXclw8JfHnPo9/DozZ1KRbI3gdp64iE/F+08Cy1D?=
 =?us-ascii?Q?huDt4L4Pwzp+t4Snvl9gjCZIkL3K01psw7cxdMdV45iuLsatFb0aSSJwtYGi?=
 =?us-ascii?Q?EL8VSbVEREmVl+PRDUFAfyck4pFjvT0RoQswqrWdOrnkYrRHAvODEQs+rAhT?=
 =?us-ascii?Q?MdFdMnZ8tm8YqqOfrwaOvRJ44rFxAyXjAObfb6+3pqhIqXYVel7OUhdd+loM?=
 =?us-ascii?Q?RSAaTFOyK0YFMnNQgn7UmIN0oY31TLxzJp1EgR+Fi6Zh9+qWa9RKU/cylKHU?=
 =?us-ascii?Q?zOR1gFdcOzmxrK/GsmQ4KN/pbSMkf9zhpDZkhkVmCKpB3X3Vi694UdXKznwG?=
 =?us-ascii?Q?5FN3vNAOKwp4N2jpmEQyiXHfCc9bLU9fN29qXuPVEhErzXirsrkMpegoTNW7?=
 =?us-ascii?Q?xYT3PR/EisxLgSpISdv9MtFrSbJuUiN1SyTOghPkSbreYzD2th4lvUVN0yvA?=
 =?us-ascii?Q?u7elVDhOynY/PeIzP2I1Z1oO/qZ/Ut/ZiDPtheIX0A6vOss2ih2AXs2yRVvo?=
 =?us-ascii?Q?Z0kALA+lA0M2xceiY54zCWDzwDJdPqKIkdiGPrw9Y4IyVKilvtKV6ThgEEfE?=
 =?us-ascii?Q?XlD5G2RgZXg42bx4xGnFVDykw9+sd5I4OUmMP+gd3LKGtvwtlut4am0STsEw?=
 =?us-ascii?Q?UWnfeTD7CJpl6Zk2Jg3l0ydm4eOYN08CmTEsqE+7Ayp/8sjEAF9bnGbKm/dS?=
 =?us-ascii?Q?c/kMpbEinAkFztPJV/14TJv+TuzZXhRlDOtkzLGgHiK1C0BZ8iEYu2Giiew7?=
 =?us-ascii?Q?j7TeioowHaFTqOJc0O2X8si38y2UxQNpk7caCZwnljP6eVqQkyyXaPbSDm7t?=
 =?us-ascii?Q?UzmFTk9COdlC6HFwnO9ryqZRjQn4HC75/WSFExwZpruP21PYhtJuuJnJ/14q?=
 =?us-ascii?Q?IMPGoLM4cybudCjH2uZe4a8HkSOM5iTfyPTVX0ODRUWhciLZW7hWqaO8IMmE?=
 =?us-ascii?Q?gf0xyFkAl3UoQ+9LvMCgEAiD1C448hmF+KN6rpfsXoayQzEmobJEWqL9mgQV?=
 =?us-ascii?Q?hLg7ugba0F166AplKNZgSoz9Cmu6R73jarrVEoLUgHPEbprlByNob9K2i076?=
 =?us-ascii?Q?VXF2eIWDkt62Pm9ibH7PUTOt49tR6Ay4q8/lquGXUHMLn+JMr2F7ZHWaSaOk?=
 =?us-ascii?Q?uRv7m03FVr8VIcRM2LPWCVKa5D3IZrQ/Bjx6f4RXCKS06HVYOpG+eFly2C92?=
 =?us-ascii?Q?HeLWxDrKaO5XHSsG3aXg7DR/wicsThjiC4XpptV+d9vUYXn1Qk4f3SGro6yg?=
 =?us-ascii?Q?WzBubap+hzyEMnB1WwRaHjbrPHN1azsVV+VPoi6Pg3qOv4I3cleNsIc7dTLG?=
 =?us-ascii?Q?ZwfLLDPYF/oY8yliqIbhntoZmRVKGe4Zw1ZLA6jRMVfEm3YomZ9kvkqhUZys?=
 =?us-ascii?Q?ywj7SAO5yBKc8BVJLt4M7JpucSkIVjpjHurWcLhzUbBC9IdL8W0Ar8+Rql+G?=
 =?us-ascii?Q?iZLtWge5Qkc8ghU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TlFxKwoMrkoCUjqCQ/QGdgRKmgtb303f1WOv0VSpaIKWdVouwfVARQ6tIb6q?=
 =?us-ascii?Q?4KYjqMvYwYzE1ZASLY1IhaEEzyA3x2vokLsNuY975WAGWgN+xb1tqYAcXOrX?=
 =?us-ascii?Q?WgysPvNChfbcqcfPcaVA/GOraN4vxDALzPlzkY9pLrHn7aWcEzvE1BMVT8Dz?=
 =?us-ascii?Q?AI0obP9h3D3qT8vZ+SUnu/sytEnNOhHcqg9mcQO3f3Jy3BYh4qiBUq8p8A3P?=
 =?us-ascii?Q?JfEr5+31LkFa5dj3iSThZv6bsWYwSZM9ejAc5eFBe890ieTvsH5B94LJ2PcQ?=
 =?us-ascii?Q?C86nU2bJCoryGhzsZj6Hy1PYITwgG+Tq39AhE8AO+LK4JP6eRPCvTeQ1raI9?=
 =?us-ascii?Q?1/IJr8sPP7btzlD+BQmOINv8rcR3WdZFpROjTcs/1Yxfw84Y59fXLIVOwOLQ?=
 =?us-ascii?Q?jGylNzcILdYk6USruQfF1ev8IjsDvbpqd8jRbLHBhI0SqvNdra9kkD/K9H0z?=
 =?us-ascii?Q?V5tkljLgt3Do3hDazrS6kJ/icHlLXeNrEiHnrYLyoKfTFicYHtCZdmiE4YsH?=
 =?us-ascii?Q?qcsZ/inBoWW74/zY3DHuDwwBj4B6PkurlA3GFgW6k41htb6GjGZYsncR4Ei2?=
 =?us-ascii?Q?SF9igk/wZz3SGdgEFj81QzdfPCryO0pvUDg1YmVZ8oWtLU3x6TwtzYa1oVkH?=
 =?us-ascii?Q?i/pWo4z2az/OjLKw0VPO41aryat4BBXFlMXQtaJDx7oQ1PypkP1H5Fn6+BJD?=
 =?us-ascii?Q?y+AFGiI6WaHR8Zz9Pzuwh3845pqJgDcpujcjf9umDREuPl0WirqPmJ1U5+Mm?=
 =?us-ascii?Q?m4o0RrRSoSTdBPq246hlg1/SX4Gr54aFVHFtcHXaYOG4vct/a4PIlHJueEd8?=
 =?us-ascii?Q?/x66BI9T4UmMQEFoqAo/91AU2DuMQf/fVX95BFpBsc3MDRooT5nBvIIF7kQA?=
 =?us-ascii?Q?aYIgzfrTumP5e/XAdpDDqZVTDg/PMBTeQPICHOZIJGjsnYzU/lHMBhPw8llp?=
 =?us-ascii?Q?UpQ1hieWPwh+GjS/Tb7wDcUQt8oSZY2hwYBmPg2FZcvd0H6GI/O9eX/5sqRZ?=
 =?us-ascii?Q?tv7dzjCG64BfCk4x+JnIUizGVXcJuzsr5DHUC+zsWIfOuvT9MvaCNGA953dw?=
 =?us-ascii?Q?pB7E6fZrEWjxnvEw6aB7yJmra0dn73rXx4FFPIAXL70zF2xdv6tFD2Yg1bm8?=
 =?us-ascii?Q?wlrZMP44TUgo8bktSQ5DbD+aj1kJqGsP6VnlhKZuBQ/SmjfTR90unmZHDers?=
 =?us-ascii?Q?CnptEXHGOD9SyF9lWo5ycStf2E8mo8iR0mzupVSU+fjXgokjcIGyODlWmjCz?=
 =?us-ascii?Q?rZTjF3oTvs8OtajpcVgIA5bah/uH/Gc+VNwPxKXdAVTzqQOYjZ3b+IQBHXBD?=
 =?us-ascii?Q?BYAZ7tMh/Vr+r7vCwo3syocAGKQC6rs3QSbj9YgFXtb1Nb7qmt0MHZlwKGyW?=
 =?us-ascii?Q?/RT8+qRDyIq835Q4BLD93zVKqA91+Dmu4BhVeCEaAo3muU/iYCncZG8Jv5wB?=
 =?us-ascii?Q?OhaX/q1eQqX6aHfnHqMv+79094lJRmdQ3CmPCXvR/U7kQ+6telI8BwIVa2Y+?=
 =?us-ascii?Q?msSnRknsQ1Ld7KJsGBkzXnj2eI3GdDIRTnpker51Pzk1iNqSkyqfKeMxgapJ?=
 =?us-ascii?Q?PbgnmSKQi0zqtmGP8Ww6CEx+XGArn50QejD5XZSD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8361e8b5-9011-4e66-3df7-08dd7cad3d0d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 06:09:25.3743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vULDA/THOAbOdjKcU4bnu8s0bd002zIFzoR7N7uNeallPU/yPIxkqpu4JVvQOY/qyq1h8lVXdTxmMSaEVktIrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

Add a cold reset toggle for i.MX95 PCIe to align PHY's power-up sequence.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c5871c3d4194..7c60b712480a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -71,6 +71,9 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_PCIE_RST_CTRL			0x3010
+#define IMX95_PCIE_COLD_RST			BIT(0)
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -773,6 +776,43 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	return 0;
 }
 
+static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	u32 val;
+
+	if (assert) {
+		/*
+		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
+		 * should be complete after power-up by the following sequence.
+		 *                 > 10us(at power-up)
+		 *                 > 10ns(warm reset)
+		 *               |<------------>|
+		 *                ______________
+		 * phy_reset ____/              \________________
+		 *                                   ____________
+		 * ref_clk_en_______________________/
+		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
+		 */
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				IMX95_PCIE_COLD_RST);
+		/*
+		 * Make sure the write to IMX95_PCIE_RST_CTRL is flushed to the
+		 * hardware by doing a read. Otherwise, there is no guarantee
+		 * that the write has reached the hardware before udelay().
+		 */
+		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(15);
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				  IMX95_PCIE_COLD_RST);
+		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(10);
+	}
+
+	return 0;
+}
+
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
@@ -1739,6 +1779,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 	},
 	[IMX8MQ_EP] = {
@@ -1792,6 +1833,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.init_phy = imx95_pcie_init_phy,
+		.core_reset = imx95_pcie_core_reset,
 		.epc_features = &imx95_pcie_epc_features,
 		.mode = DW_PCIE_EP_TYPE,
 	},
-- 
2.37.1


