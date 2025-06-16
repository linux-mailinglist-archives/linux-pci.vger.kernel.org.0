Return-Path: <linux-pci+bounces-29840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3677CADAAF6
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 10:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0AA16C3B0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69129189F56;
	Mon, 16 Jun 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="di/aNJYu"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CDE26C3B6;
	Mon, 16 Jun 2025 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750063222; cv=fail; b=BsTCPD2k1F/NPeXFzca6sTxAIDOyK29MHp+fC/RtD0cBxlKei93z1yVzw+Hugyy+RLlXUCgtJlf9ydYNEMhgmS/LmpcZwhRZKbgGcj/KANiEgByJ47+WhLbmo4NN8wgj5NOBjdPkjpRyLehW6u4uzRRB4W5pLrsohnc3K95O6PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750063222; c=relaxed/simple;
	bh=KvEmz/Bb1G0kzQ4tpW50CkFNOrnHY88sSX/oqggWU+U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bSXKdHdTdA535XMGJDOxXSDlifwqwWgbgkvl6LGzKxQffnAlu8GaWGJgj2enyR1dyk9qXS8tE2TC5vrLra9d4D+ga5Wx62qZ7v2clhF9uXsDmu4OMqYqNACRbQlIAqFnoGCxHvsHGXSaPVXHkQ2y3rZg7ByWrAMmu5GRdruOFpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=di/aNJYu; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6oY/8+c6GKNWzrh5px7r9SepeMUOrxh+bAjnInAyyBQuxgO0Q8vlA8BpJZpgIhWACZTYgmT9l8D9k4YeiHpdSjTy4hD0vW20+Culhu7AVTXBq7ZGQkkGraLpcFQ0jo3qW+xbszg9N5/GrCEh7g+jLcbS64BH7UJCrijYCRQjE4cnlHX4jxST857ULGgwAI+2NVyEzQPCNCsQUY4yaFbpWQ/ZCr1GbEhxoQt72fJ0M/3cyWjQui8hkNcmXVSq8UiaAvraJkkMzKUcAO0Z4tg05QfEOWo3AoXTgBEecQPUD4Tv6klmi4ty29jXviqbvDLvZcRVhfZyZtp0VsLLBWJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqMblPvKfx4IE9vQ6YPAVX2Mp1AnULS+jubaXHyacis=;
 b=DJr1c+hEmoiIAF/KIwA4Rc0Xx98rzuPEhiQWdtSR8e4kHwDT4uH5V51aUBPNH7PF0HLDK3OaW8bc7gaH3CnH/hHCMpbt5j/QlEau/aCuyE9DrQtQxzrCD9YKsP8BK0l8sEVioXHbDQPL7J+bdRbwpKJqLTu9kz6aBuHLV0jXIPNN+rMs0YC2iY/ULCU/wO2ripXWTiLcZid9Dc91MFBY1632Hmw8U4HLAZTf3ckRfs36qcJmEHbbjuoEhTV/Jdnc6gHQWjEuwtStNVGEMs4eTVQv69o+rX1TisC1ukZVcZVHaMopHfdu9PxqyQsl0ps8c5ffh0ZPLMuajf+cognNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqMblPvKfx4IE9vQ6YPAVX2Mp1AnULS+jubaXHyacis=;
 b=di/aNJYuyUHuGpybnrNyRZLrCuvy+JfnJ5CN1Nwr9BGKut8kvS6TI1V7teHLBHQIFudu9YSb0P4vSOpuu4oylHOrN096spDrX9VYD6vDGUvhqnf9qfei3B9BbktD4oW+ZIhpKHE/M+KJsd7tQU8a6YMZN/TzuZoPXn/mXtYHIpQEha93hS1PRcnfQHU83p377KtbW3tIQnsubqRbZVtOetwZX00rrxfkPdlIjdtP1jnxzSmCfuJpfLREZvFAftgyxdGvaPGuUh+feky/kMxoQ30bXEz1Xa8t/gX1m3x728CeFPkC9OgZEBLDXkR9HG6R8HdVQ5vYUyCZSpvDdCLE7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB10184.eurprd04.prod.outlook.com (2603:10a6:150:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 08:40:14 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 08:40:14 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1] PCI: imx6: Correct the epc feature of i.MX8M chips
Date: Mon, 16 Jun 2025 16:37:44 +0800
Message-Id: <20250616083744.2672632-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GVXPR04MB10184:EE_
X-MS-Office365-Filtering-Correlation-Id: d479c43f-bf5e-496d-df43-08ddacb169a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9YIx11S4iW7v+9HaFbIiuBKDuQwkuEmqQ2ZnaYyd2bQ4irAEF/w4Uz2Znt/S?=
 =?us-ascii?Q?uSJCllAajbJafdf7cZ3uzFEGrlk+/RgRFyaLiA1I+GppjdIVlEDNA3PAl+qp?=
 =?us-ascii?Q?Wt068W1rs1JZ3HXR3WP0li3p2b+P7T8yCDnNAm0kjK2lfES3gAuZGarLWL+2?=
 =?us-ascii?Q?R5lrkNz2e2+R2j9a1cUNtM7dmn/lJ+0BNU5H6LUcuhjU1c3ikkCfX+NvuSy1?=
 =?us-ascii?Q?jZSyfRMwAEE/8XxOaImVJw1PZwn2c1SRky4sf7d2VMxHJX66IlvTa0aAmO93?=
 =?us-ascii?Q?wPVPVqJi1bX1NS7QqmGT99JtvHi9maJSvWA5N8SUAUlKBMaSCoBwuNuPnCKC?=
 =?us-ascii?Q?8kcMVDz0ceBfCFqZuwK0FPCP/kEAwe2qX6AT1d56u9ftGhZxnR75PAUlRkDH?=
 =?us-ascii?Q?zKJ/fiD+MCyv6zjqYFZQyJNjxbDkNgnxabSVM+RrR13H0jrXjMA4KBQlb0f7?=
 =?us-ascii?Q?YfW0FB5x2yy1kaACYeEK4v+gcxxWD6OhzgFwjcvubAnqJ+r1RaYECuflBfz3?=
 =?us-ascii?Q?DpIHyCV9awJ+F3KKmgOdmtgk2RjP0f/BmLj/hY+D0zfvS8m3+AkoMWsC6FR0?=
 =?us-ascii?Q?p5RpWnNO31BusC5+OCXza6U66NhP84BFhdvoL+CCc4AFLdBu+cGx9AowFMZp?=
 =?us-ascii?Q?mE8wME3+MUE20/5t1XId7XT8qFacAlynRKbwSK4ChhtlVz0nzUupgkH9CtrX?=
 =?us-ascii?Q?QR9mIgORrlocx8GM6CUu1w0tBoZGgQGM/dI9SyDOaxdh1vOShJYPv7oo1IxY?=
 =?us-ascii?Q?Tlz0j1iqxlOD8t4HSR8heWl486VOdR4uG1n5+PAar8r7FvF9cCYOJo2HUdOW?=
 =?us-ascii?Q?6nCcLrawEmv5sa8zjxlZj/rR5x6BtkwIYx1iVQ6UgYZ2m67kLMNJ1w4WCl72?=
 =?us-ascii?Q?sibLzXEnuw8psuB8nphNsh2F7AYmQ0NF7HpjAdLp135LniroUr51Y+MFqExi?=
 =?us-ascii?Q?IsKftddHyt+SLhe0gD5eZrrHc10dBG9JCbCrju+pcoZ3VdwuAQU06jHi2syZ?=
 =?us-ascii?Q?co4mOT174rSJ0WBhIgbT/H8w3bjFE5hnC1cgL3nuAgg5YCbruXFRSPbSoLjp?=
 =?us-ascii?Q?uJ2C9HX99ANxS3taXvE1dki7ojpn7rjJ4Q038MwW1+e8vznOnh6Is25f3/TJ?=
 =?us-ascii?Q?yveB8hvuii0pPfzySWgNE4cq4lzrUONciFp0iETVBLgLE/IidtjKBA1zzjv0?=
 =?us-ascii?Q?t7vHYYnOxFB3oZ3cjds1mef48E02E1y7EUwnZEX77jV/UF2T5uaW4bvjAIss?=
 =?us-ascii?Q?Ysx/yq817Wrp+teeThT2ktZZZ0/hzrSRpsPtq9zRwXuFzx2B2rohiFNF3zM9?=
 =?us-ascii?Q?CgM7W8DiGHkuw1KA4IuB2WVcLVKjtJtABztpM5AQyYwg7NQvwKjdcsjlraW5?=
 =?us-ascii?Q?eXwAXezzpKz9WORLRuV1s/jie4kyFw2ObjKV7vILHO2D+BqYrRfmO7HuNRRu?=
 =?us-ascii?Q?S/8WHwXhxT2nuiJ+kDXSepIFu7lw7OBbVgb14xDd4dqcuI5JufY71L50IDST?=
 =?us-ascii?Q?5/6TK0/KyQudKBs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CbIUO+J7lx6YA3VonNGaUw9kIAAux68fZD4I7Ok6u1V+4B2zfyHZGl2GkH/p?=
 =?us-ascii?Q?lySuuR9VlZgRYYldfPkpaZzd2LNCbRYcWUnzSjwOtPTdHdAbsqFcOCisNuST?=
 =?us-ascii?Q?ZdhHxUc4rRA1yz26Txdd2vDA0OxIwFhjDlLPazC9QhhCqpgJLmJQk4k+mdSD?=
 =?us-ascii?Q?kWsgTPT3S4VqxQ3lYR1IyLgJW+CC7S0pH6vez/eovoXYN6+PW1dCaTz2flcQ?=
 =?us-ascii?Q?ETW+lsnX7JBauZzi5mKoA+TuCIvE/rpxxYijC0PkYlR74y3Tc611q6mmszOp?=
 =?us-ascii?Q?SM1TSrKds0+opsam/y1mlQFuReDOWr73Ua0HoGP147NZz1Q7IqYlB4L0nAgK?=
 =?us-ascii?Q?6NdCyUHbt1UinXREO2OVq39tyCn/nGNHJpkr9/wxk6M8QgsD7IHQb4kmSWuh?=
 =?us-ascii?Q?1SFOGDdOCfLkbUweR6v2BTLyPoyil0doC1u/5clTAbGxJliYt0LdCir14iio?=
 =?us-ascii?Q?/DuhGxQP0Qm43CJAL7GhkDzs/nYbzmej032PPjXzOQxaxVRnfbwP1X1Z21YY?=
 =?us-ascii?Q?VP+yoEAtDalVI07lmO4Gi4NiSs02uPf76b6Z5V8OrVLhEa50l9mFZgWjQdYd?=
 =?us-ascii?Q?ccopcU1KeAplZhzV37+0QQsq6T3yjQfiJrSafGMRXCtfjrbDHCW+YQDzj7nu?=
 =?us-ascii?Q?1LbyfQCcJ+kGri0gC/qkgv5QiU+0gkomT0OYKkOERj9F8G7KjWRYLs1/pz2B?=
 =?us-ascii?Q?LZYHAY5N9Ol0WorNWM2QkS4va+laDRBTAuiA82N4/AVAgvK+AXibZc+7qbbS?=
 =?us-ascii?Q?oNy/gX2ACcU1/diu7vq/sclSkWZ9YDQbqDk0XJ7QYSkFZfz2s8zuttevK11p?=
 =?us-ascii?Q?9j8bzDDcf7MVyVBeDTnBjXWMIu0ljnUhcCeZHfiqADRHVXsuQbDdjXS5Cp91?=
 =?us-ascii?Q?QLoYrNese5njSdtyxwLjmBxdtH9o0bE7A0LDJja1lH+/CniJZywjsOlRUpYx?=
 =?us-ascii?Q?22ddRk3X/YIgP3T/3imsFaViziZjabTJBRGNp7eC+oyzKF7ukgCS/QtHo9z+?=
 =?us-ascii?Q?KaFi/QiKQ6Do+wF/V6zkQL3iNyb4sCMwoByKyBLMbzmC60aLQmj31rpZtZCT?=
 =?us-ascii?Q?O8FmX9DhltTqoJz3SzjJQLeuslQejbiHvP/Yt/a+1E3u3U673esa449DVvdT?=
 =?us-ascii?Q?6p6O5ncZ1wrI9SIPbkiXydorfxkrXw9IiT0I/kXbeQTG40BXeszC0N7Kl9Pf?=
 =?us-ascii?Q?3J78i/G2ZDhhVPugYGlyH9JdEMfLJ3jOCn8eVLkxEOKYaXC29onCAqjJBE5G?=
 =?us-ascii?Q?l7ZhD02gjkjs1duY7SVpEMiPVmuTPlwu1nR6rEaVXViyYDw7mDjMdNQx7E2u?=
 =?us-ascii?Q?AMtrZZc5DpzYp8HsFnIFNcrhILYhY+dOEKtOtYGnX0QiQcyn4sRRU/SDUDUo?=
 =?us-ascii?Q?Z0clHFDlw82JEJXq/vp0PK+zAYBqdrb6rkxEC0NnnQLB3ryOWYc62NCsCgLR?=
 =?us-ascii?Q?cX/ocvtW6DYShHnvJpHF1fcy1LU/eguMFhwEsM4UBuU7WncE2cTLytSKyAwR?=
 =?us-ascii?Q?5TTGb7WdcJ47RLJDCbWmpvgqFkXGv/1XcOO4HQVp6i2uEP+cW22G1kcbGxfh?=
 =?us-ascii?Q?Cox/5hjrtWw39poX27mOAKTBvc+w4oENB+l3h7Bo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d479c43f-bf5e-496d-df43-08ddacb169a1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 08:40:14.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6nDcLKDTBKD9QBY9RL29kApBEyOM6HWtUZiOR5jAORRbgo9lMTBR/xYUapDX1QBL9rkogubPlk/x3X3blgX0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10184

i.MX8MQ PCIes have three 64-bit BAR0/2/4 capable and programmable BARs.
But i.MX8MM and i.MX8MP PCIes only have BAR0/BAR2 64bit programmable
BARs, and one 256 bytes size fixed BAR4.

Correct the epc featue for i.MX8MM and i.MX8MP PCIes here.

Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..9754cc6e09b9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1385,6 +1385,8 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_256, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
 	.align = SZ_64K,
 };
 
@@ -1912,7 +1914,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-		.epc_features = &imx8m_pcie_epc_features,
+		.epc_features = &imx8q_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
-- 
2.37.1


