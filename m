Return-Path: <linux-pci+bounces-30160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA3BADFEA0
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3879B3A40D7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5F2494F5;
	Thu, 19 Jun 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nvsT5ZKN"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC1158DAC;
	Thu, 19 Jun 2025 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318007; cv=fail; b=d1XLol1MYL27Gzm3Ax6/rLVHnR4QYxPm/Vv2eZ06tQFkSOTKrPFk1lZHPWAJJYk7eTvKoVfntlYq0wBRYNC461YoYV3EkHn7RRqOOM68coQ4C8OFP/0YHPjsNBsadFHWtTWsCrDS0qCmzTE+8ZwjHMzCzM8ZgFviRWhLW6g/e70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318007; c=relaxed/simple;
	bh=F/vwH5+An6syJF6uMfIMrysxrcUl3rAyWeDA3QlxjP8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zl//i/3P1SF0ZYi0twfxr1PgUgUlqKP8GjLit+BtLycCih6EryVrycAlACuLucKUymJ0uVAGTZC2jmpVFWI+LZHNBzHxXSz/EoKNO9iTJtr5Ul4rqXtOCusdFcBSx6e7wQklnbtCUJbSOinEwo+F5hqPGWbdHh04XOT9B1OiRsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nvsT5ZKN; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufTxdMsi6RLuO04LULocRlRj8RY5sAc89XvN6leJLfHQAyhdwh7GZVFDFmlnzE9YGNH87QtYEfZktR2lPUCAZRVtVEMFAsjtpGJc/KSp9wtTcOCsKQsHTk4l9TZm6wu7M1VSfMGtw3eFwXuIkgRX+ChkcIM6HcZ527r5TkaNJBw/fqiQWyoQUNgajM81eMuv1jQj1JbVmjavjXYJnuK9aHpLRQulsVHKJ35W60rbOnD95lwWsjczvR8vEkmex5eqZwmYW0EpuAUR63ie2IOeQDOPUpHMkZJOxwDXcMGhsvLJIRtxMzrb8U6AzOvXZcz2tF6b9Xe2dYvPKvrSDYPMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww55woVnfg7uUpReHT1QZ3yzV0HniQehPDTLTkbG6u4=;
 b=zMQr9zotysxTksdclCfdd/JhugC+ZM0PrnM8EclpNtvVa4mbhOuuJhcZyey4fgIWvDUP0uHa0gWaN8eOGSyyU9TinTpOj2bfzDlrfCix9bQGeXll5I5/LC3GkvqwBtwxX2C/lAdBEeJTUA5ur/hQ0Wjfx+VrcfBkdlMhV+cuQSkVXXBHJXI3xFXC1hc3EEHMHaSG5cm1bPxTSz54Xv54rXDqiopmWT/zGV7oL9fVRmFNuwkAFs5WxpyMgR8rzE9tDfAYYWOfqMp2NuV28VJwKuiVpPZaXRbJhhBkzLPdmAVCmHH54I3D5B340H1GbyRh/AX9+C5JvhV/hS+N0sBiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww55woVnfg7uUpReHT1QZ3yzV0HniQehPDTLTkbG6u4=;
 b=nvsT5ZKNsRdLYwGTzcP2UdMnNVufbanStFcytWR7s4J9z1vEHBPhhjLQLG3b0WbL4fngSLqRpgVPtciHlVolXVPCkw8chwjVyLIH2nkW4voS6+f/0SFSA8WUBNzqHsH/UcXy0E/p9VxgwIxg4iwp/yVvPpMtu4jVB3TcpRMb19NOdonhDhdKZmKuqaEHZKpSfEaHdFlpDKOt9GZi+A0HZkkzg2Sgs3gUOsm9ccZfWyMMWXQIiW+5JnyuzRut2/KaGigx7aeaemblAlDk8ZNWAx2/Is4JiYXLsEnil73WEs7Zbul07rL2um6oVlGRzoIO1vsgoEr8KOR2GXmkjHcVRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 07:26:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 07:26:41 +0000
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
Subject: [PATCH v2] PCI: imx6: Enable the vpcie regulator when fetch it
Date: Thu, 19 Jun 2025 15:24:38 +0800
Message-Id: <20250619072438.125921-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: aa71a0cb-7a71-40f0-9c8b-08ddaf02a28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vIgNLsNiPr8kjlRpLqlPXS6nYRXg3eeTzeWR9qH0Ih9So7OqjNyUvmejEJ5m?=
 =?us-ascii?Q?h85iZ3qvqeK1eMgxJqfLZINReDGsjIzLl9WjrZYK0Z+Fi+GcV3CUJn0YWqXb?=
 =?us-ascii?Q?utzQy5Lia/Kur0pJachKELZKf1Y0qFTNBBb/HH65dtGEPNHJXtlYywdDv4en?=
 =?us-ascii?Q?Z24OuMikHdL6PdktU7yN9Ed927WXv3kMbI8cE/l3us9I6QqnnnQctZciAyvp?=
 =?us-ascii?Q?qXMHKr7B5w5BmmJlHQtnFkmMGACYuRTyAHKLH0JJP78a6WhpXS5RFoMJwU3E?=
 =?us-ascii?Q?cjoxuMIclp0PLf6QsuqR3Cz2rx2rCu+ZU+X4vopIjL05iKVPTG4bj3LkI4e+?=
 =?us-ascii?Q?uTMry1aXqxuw+W2gIBz8hrtTpPr8PsQ17u9zddzK1J8YcIWVI0LG2N6czM6I?=
 =?us-ascii?Q?EvMbgRwSJ2K8EfCeRUZnlcyrDsM/euFPsxS5wAWFnBdKAu+V3t6y2mWmJ3bO?=
 =?us-ascii?Q?ldh4vG2DTgOUTg9AFdZy0ewplu/3cm/UMfKrpGj5jLRM9LYZm6X6/3ZCkz1S?=
 =?us-ascii?Q?//+rJ6iN6Av8eqNShQ17NkeyJ16d/zbHUIXpEpmgKzJkgPJ23Y/leBGCxHX7?=
 =?us-ascii?Q?ZiL+6O7OLAwOpuSDk8hmOknjqEVrnYFFjRC+96EPadMvsddGYxUFpBYUi1Up?=
 =?us-ascii?Q?oJPc2rDOGtpjq2oIi8zo2zbmtsey0ZLi8s5BNrPxJzh8ONn3qhtlhWeId1Tf?=
 =?us-ascii?Q?kggFhs7DA1JQQOAdCUddH+sstaNWB+LUu766GTm6qp10jspM17pZxUfX8Sd8?=
 =?us-ascii?Q?ZHvg2VrWjGe1HItWCfuJ1V0MCQXCCP5VSSYVrcYbDlBkUEafpSdCHyYKetC/?=
 =?us-ascii?Q?L/TiXDpkPV+FffqDWxoyah8b35ALw1JhYPpAUnXu2Lscwpu+LWBSt42gtCF0?=
 =?us-ascii?Q?TCQMyRi+XA0wjLvd2ytwT4aNLloTxutoT9yJV8QCWyjCxJ+E6EKhFbD4ve6O?=
 =?us-ascii?Q?JpzFHOdAt/VlmEbBR2eY/LCsCGZ2OZG/ItOfuDaY9W5OzOIWO2zGIbe9vu0M?=
 =?us-ascii?Q?QZ7mKdFsVLY0hhNMY6NpoPX6L0LuvMNuIvrR/3yD9teQrivnjEHvl1KlsUKl?=
 =?us-ascii?Q?9gf/PaKZnr3ENuFHboL+USqcwYH/ntvuwKOHIQfBFR+NgPP16ehX9rLYtwMV?=
 =?us-ascii?Q?08Bw8803eV37g8Aj/A6Sp2nCuXcAWe1pkYPAGRI8jdpDfH1UGnwGB9CP6HjQ?=
 =?us-ascii?Q?/d3HTaFHibxIvtVsuUvDCrjx641l1kKPjNB1+EXW9eNtnG1LJGMxTu+htRkq?=
 =?us-ascii?Q?P4SkzBpItA/4X5tKEmIB1RQ0s9Aju6XWBQQiFwt6PLOPcFvb3alCOjSdF1x+?=
 =?us-ascii?Q?fu2krA+koFbKlKmpgeBaomQo9U56QsCnMJGa4V7TelkMbnt5+L9RF/SEWzGz?=
 =?us-ascii?Q?HjyAQ8zRxTBwatIJKirdIs4laFRWNAA9z0f9O3PKyE8Dx3rwZLuXJIfA2q19?=
 =?us-ascii?Q?UBCLNCJEHbPm83psUOOa8m98nKvKD/GzyCMgx5Tz9K1Nt377GV6R2INkKg1/?=
 =?us-ascii?Q?gCUw/jJM7TTHuEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Mstq7h4KXGC5yOyw+Vem8VdICzc36BvbBYlElN1wWtGxhtHE2IbmoPe48es?=
 =?us-ascii?Q?A7i+69bBICaFOsf16ww5VvoV7EVMdvDXAxmvmGmi4yzPu9Wtyemzap0sFDce?=
 =?us-ascii?Q?sVEupxBsVuUtphka3dZ8s9iGy1I4Zu1RlmkInBa9nV9vSVeMWkG9HBCDotRf?=
 =?us-ascii?Q?7xYVO6vBELUbtOZW46C4fYZeq3+REFNLuyVty3iCiAMMtJjvN1EJbGe+XWI7?=
 =?us-ascii?Q?Ac7dq7IPGkJiJMIh0cx1PK2h9s8Hk69v6qITuipVPK+Jw+7Gh6BSrFPyoDbS?=
 =?us-ascii?Q?j7yN4yyxvQzyrLNVXelQrX2xDbU41P/TDbk5Fvr3ZFcrcrtOaVbIlI9ZrhoD?=
 =?us-ascii?Q?557H5Lj1SX75LNhs4OXEGScUVyBRT65igoYZqzpYM5IyPtYXg+c3Q3eeQA4V?=
 =?us-ascii?Q?QOYO33u+tAG2KEes5M9qxYLpNwupThLB7ssC0oYDUxHQPh49dPNypkfo8gp3?=
 =?us-ascii?Q?pHjbX3cJ61VnaUtVRI0HTHpj8khgO8AdRLSW0ODFPggJl+tUX4gRO+vQBGWr?=
 =?us-ascii?Q?LExUrRfegHAOnCKXNQQBrA+YsB5T5jGffs+XDwjwPFbTO6mM2tBVKeS2XnTc?=
 =?us-ascii?Q?lDMZS76IGCI84g4YrTAwceuFp7OsoqTppXFqu8r7Qaqd/grVHSXHP8IpANFH?=
 =?us-ascii?Q?+WcM+4FfTRfahJewuhRcHfUl3jzVhkQug4KqXjldwO+JaQp//moWB1PRhphT?=
 =?us-ascii?Q?eLlMhSpro62HPAp4ZbIYUxyL6QmYTfBJMt++5dLdo78TLKWZ0yCZgm7FuRub?=
 =?us-ascii?Q?C2tE+EasQ1x4iftByBktaKI4xydynzTvUb1F0OwF50AHKcXWXaTkLqmyqyHa?=
 =?us-ascii?Q?g235aNyKfQ75/WkwKVCzBS4Zxx7e3AlJXYaJp+0p4tzLealEJKDkY5dZ5kkr?=
 =?us-ascii?Q?4eElYFZ+r+ks10ylwEKZ7QyVI9WYQw7D8amzwrnn9gP1eAPERHqzJGZBKZON?=
 =?us-ascii?Q?7qT2a+2i1JJkq20DvUgLCBGXHCoOOR4uBSthSiR7RD8C+UmK8U34K0Rbm79g?=
 =?us-ascii?Q?3yJkZ/nshOZqPr08olX2jJHPmN7EYec8p3ilEvjDcARqbd8Z4L8E7OKCWfco?=
 =?us-ascii?Q?HbXQ1jJdZcVpRdXbL5wUWWCO9kdnSfC4p6QLqBDZ/8CoWn3FVYWl1WPGjvYo?=
 =?us-ascii?Q?/7siQBHL0OUsUBgPJypLtmxsqIaULcPel+j7Vuf1NK1RLPzGyfDYN7KvUKTX?=
 =?us-ascii?Q?EKY2vyrredENgzrlLPSiJWFi5coOStNtoUAJW/Ygq+PscIi0FcIcAGsoxlr7?=
 =?us-ascii?Q?mjpoldMF0McUnUI+EcloA2loyAxCDJ9+55GwPs7L8xKdCHkT3U3ImHRcFb6+?=
 =?us-ascii?Q?Kj/Ixcs29JJcueTX9pKHDwcuwQyt1RXnn0IG2VX5tGO8yNiQPsxgt4qHtVQr?=
 =?us-ascii?Q?puohMtPyFSkCUB58mSE3MMvsysit708TB9Sfc8gnoHV+/n3YlRquTZi3N2+F?=
 =?us-ascii?Q?5ku8J+xtYsrcntJ2gEqd/t/FKttPHZOg3RM5c648tUfj5ZeUjN1rvX0vp7+E?=
 =?us-ascii?Q?GQYGjf/TBYGfmrdehWXKFv1cyhkM0YHtQ2d+aJI6G9Q6kVRD+d+bIHcaI+zR?=
 =?us-ascii?Q?Fy/nXvl4i4GOufbk6fpIze8cE4srL9xTALVY3oaQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa71a0cb-7a71-40f0-9c8b-08ddaf02a28f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:26:41.0767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaBBteW50WhNv7ucL8PzVIlipMKg2ofJCtOukG2BaRQw2EzpKFjSuTIhMG5iT7x2nLDhmUC/jn6o74yZbt+tIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

Enable the vpcie regulator at probe time and keep it enabled for the
entire PCIe controller lifecycle. This ensures support for outbound
wake-up mechanism such as WAKE# signaling.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..7cab4bcfae56 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -159,7 +159,6 @@ struct imx_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
-	struct regulator	*vpcie;
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
@@ -1198,15 +1197,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	int ret;
 
-	if (imx_pcie->vpcie) {
-		ret = regulator_enable(imx_pcie->vpcie);
-		if (ret) {
-			dev_err(dev, "failed to enable vpcie regulator: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
 	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
 		pp->bridge->enable_device = imx_pcie_enable_device;
 		pp->bridge->disable_device = imx_pcie_disable_device;
@@ -1222,7 +1212,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	ret = imx_pcie_clk_enable(imx_pcie);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
-		goto err_reg_disable;
+		return ret;
 	}
 
 	if (imx_pcie->phy) {
@@ -1269,9 +1259,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	phy_exit(imx_pcie->phy);
 err_clk_disable:
 	imx_pcie_clk_disable(imx_pcie);
-err_reg_disable:
-	if (imx_pcie->vpcie)
-		regulator_disable(imx_pcie->vpcie);
 	return ret;
 }
 
@@ -1286,9 +1273,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		phy_exit(imx_pcie->phy);
 	}
 	imx_pcie_clk_disable(imx_pcie);
-
-	if (imx_pcie->vpcie)
-		regulator_disable(imx_pcie->vpcie);
 }
 
 static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
@@ -1739,12 +1723,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 
-	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
-	if (IS_ERR(imx_pcie->vpcie)) {
-		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
-			return PTR_ERR(imx_pcie->vpcie);
-		imx_pcie->vpcie = NULL;
-	}
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable vpcie");
 
 	imx_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
 	if (IS_ERR(imx_pcie->vph)) {
-- 
2.37.1


