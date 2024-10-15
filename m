Return-Path: <linux-pci+bounces-14546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A7C99EC48
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F3EB20AE7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE672296C4;
	Tue, 15 Oct 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DqKhyXWi"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0DD22910F;
	Tue, 15 Oct 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998070; cv=fail; b=bAK/tTgOBDvwr4b1qTvgLlai02MxDTYKaoSCGfPwOCFs8+nZ3lPPI+zzsyLOhPQRb6GYFaXOXyqlyhLpxED4Ld6tHt6z7AM6N7dsCPlbrFeJm+IhKd+9vakOIoqt6N3QHyjWxeX7UhWUCvZgZc5lmmdU3USBilYk3G9r4nq0Hu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998070; c=relaxed/simple;
	bh=GL44PGLq9yRdyT5n1FeI9TLm5RBPksdUP8Yn6Lzks3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ESpoKj6G/5+ncG7WMr/Aw3BZVhgFPKk4p4p1k2KrFr583JBzY0TuGhkXjUFgBCeX1TaY4BwuNHKDfD47/tVPS/syF6UZmMvj/BOEMKraH7yKUavx9JRJD2Acl486te017Ir8OUyey0dxMYFNnfUWRQc6sldBjuAthwHX4PIM4A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DqKhyXWi; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehsd7+9rlOMqd3qsCXygL3NKlF/Ry72TfBD3yijGg5baS5YqG+RDS7fmjZwyxMSclPSl8jdpyEAG12WIIX8QFhUqdELZK/d7NGNPDv3637SzFFyu2tBTzaNDceA7dJa6Mf55qfKVZHsVGJ5NvNR4DclljrBP+V72Yt8OQDDjIP5YcNdT8BiynJz1NYl52t2v+728Yrrkx59cQIYyHka7WKSG9sorfuqf/FXC9pY0XuX++TewFlNOmfsN7yn+ZqIb01zRLkQ6ftVD7lpIrQEovQtQFOCR+xFGtjexMEMzJTD6YQH1xHZamHH8IkcBnzZFIoUh16WtuSKhrYtCrBDbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmQbl/5l7dj9TKEuA4IXc+GLMs+sn/8OKVJuh29x5tw=;
 b=O5B7n71CLXhCnnEXrv3/TMryroiNAiTwt92pS98DHWIaQQE8VJ5f6xbwpxeTKtOeqdkeHOmtwyzdGIll17FTEQgP1RgHAhqjUFXfkAxAMTJhe9xsVWyzBSEC7V4fErdA11khlO036zHIHFj0ACRWPcuha5R7j9qCv6WpqRu2ps5wJQ0joMWEvZp6XnM4i0KcibEwUm7iu2nDlm5yG+Gvr4b3arTyowWgjJUO01Wgtpq/i59RVbvPyTmpdVFM418+8TStZiN/67iNpMG4bOSvgH5W0FnaogtGt9BQO+YlWgew8/TxHkJduMVtK1uWc04YhfTQr8/iJ/9mUkj0zejv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmQbl/5l7dj9TKEuA4IXc+GLMs+sn/8OKVJuh29x5tw=;
 b=DqKhyXWiLZWcWXztXSojmw71w+uadDcI2/q5UcHVUf2Hg2xeFq2rSLCOy3Onj2W9tQQMnsT/AlJSPxvuNiFs8PJ28n6MdNKp6fy8B5XdZ6ksbSO/13Rf7EoV/N6qaqLoMTW99jfU+0Ng4ZNkOLwd1GkwWKSlPdRZY+QaZRTDG0F09D9KIcRt/K1pjX3imBlNhyED5Nzdb8c9CldJd5Kuwry6znP94fQBACI4/dhw+zMiYj+ATmfJhQOXRv3WIxQTshfm4IYCJbp+PRhIPhWMR21rTjdbHUSiT/ma2qKIvlzFJHGF73Pheo+ToOQh0XsgHmvl9ge9KD4z2bRq6TqdEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB9876.eurprd04.prod.outlook.com (2603:10a6:20b:678::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 13:14:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:14:24 +0000
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
Subject: [PATCH v2 net-next 09/13] net: enetc: add i.MX95 EMDIO support
Date: Tue, 15 Oct 2024 20:58:37 +0800
Message-Id: <20241015125841.1075560-10-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS5PR04MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: b60fcb81-0f4e-42e0-330d-08dced1b49f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LzyxAUKzMVInM+DxX9tTruz97+ngBIwmZzy+CmB4JcJvzFS6FdgZC/imPfSE?=
 =?us-ascii?Q?MZ/caNcTXbf+1jBDQVpKycoLRUUciqeM1r4qjlDn3ypmF4eO3O4ejj7OgGVZ?=
 =?us-ascii?Q?hMQnznNa4u+flnIHNzx6QvaNwclcfjHS1u7pCNV4dPz5rVG3clDlwV4/oAWc?=
 =?us-ascii?Q?dQ059+IRTcQKY7GaiH700X8K0GzWVYisW5LfR4YLddUtlZlP7xV143h8W6Un?=
 =?us-ascii?Q?lP8aM27xN/MvFuDa9bqaDSTBMyWICuggOkyFBFS2CZ5TdNgvW0ie5vufDkPS?=
 =?us-ascii?Q?lHENT7utq3Rva8asb7IpnYiKe30x/uhc32Eho0JuRmOkZDYDS06kz8DoIQMj?=
 =?us-ascii?Q?SRZlaSls4BhQdzCrITt+/z27NJy+honHs1MRCL1FFPFb4dTmIFZ/TVwXepyR?=
 =?us-ascii?Q?XV9w0JwDgrszkYcbzM/uVrkGvygnKuFgTsdRxIfGLxo2svBj9KNTVFKMRfsh?=
 =?us-ascii?Q?ewU90o4Q1if9DMyonOK4vitqAJVsUlDuvXYdIN2f0sKLFuZIIaxbRegnTfXS?=
 =?us-ascii?Q?H1KvLjz1uEW3uh2sWQbUCiricQAQA8Iy2AkpFRi3BRsCfNiVFYEntQJNn+Su?=
 =?us-ascii?Q?sxqH7NnuiQyURqJDQ+8E/M+AUWk+ZAgRHPFu8a0w0m7B31P0f82MRii1ffIf?=
 =?us-ascii?Q?FNIf7x3FPApmRnMC22kb1M8Vv2D09mU8baEApioOKJDkJsGqoWKO60D/2CSv?=
 =?us-ascii?Q?/P9mHH/j4foCcXDCX/oZoT3akFlPuLrSbdew2sJ3nNJ4kbEi1byIoYIQFb8X?=
 =?us-ascii?Q?o9v5hfWBqKrEf9wqwF/M34PLGyqKbUXxGNFaJnMUESsox3RlVbBy4oZiDW2s?=
 =?us-ascii?Q?8lUEICJCmNmKQlU20FEQooHLl4Fe9CoHnXoFANuRvbeObagshB+YmhxnjYT3?=
 =?us-ascii?Q?ehY7+ip1jIrYdyMAq+FWQyTbKZVcn2VbA2OEc8GQztgB9vbm6cWmHoa0dFY3?=
 =?us-ascii?Q?Ap+Zt/SXuIn3u/ocBzEtSHjIYxAFDcjV1kMG5eWJ+OD2WqcX+M0Wjx+c8Skn?=
 =?us-ascii?Q?Ih1pbkiRDehOGEuiJJEMWTipmXMtJN4gWEpxKp98uYQ3X5vdurhtRp2wD/nF?=
 =?us-ascii?Q?AiI+VeGiSswjKtmSxz3uYA+rNjQJKi09yebzSjFsymFafyt2g1HR9Sm/ME0e?=
 =?us-ascii?Q?gyAgK7/jMxSyX+PP0Kw6PGfH3qF3KW5Xbt+yjQPOmGEo5qaCWg60SnSXfa1z?=
 =?us-ascii?Q?ri6HIC9ImCgKWIFREwKAxVXIIOfjvpciY3Bno19PhFWqD3hwdvjPIoa5VIhl?=
 =?us-ascii?Q?W0stjRuIKdDe22MF1ADG1ZfckXuyK5+Ro9qEI2DLbz4xNYHLKmmUl5VJ5bUP?=
 =?us-ascii?Q?rGhM2i7Mor3DYhH+Nx9kgM7hSoOKTR+r/F4EaMuuJX3F64ZSRokYnPgzxVKY?=
 =?us-ascii?Q?SdDKehE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/PzalbG4Q/mJyQ+KgbeD0uLV+tzA5CZFWR7I+EqW9EZfMtKAUEAijlyOzkHR?=
 =?us-ascii?Q?ARpSLXdo9jTy5YoUDUwQ0lvtpKKAqzXH/pLedxmZseV+PzVhYyCDJW+5WgAP?=
 =?us-ascii?Q?OzFLa6uKNtVbCxFi1746ZmxqFpOWECsWNuy74Jg7woB2qN9oW+qdmC57Rx2d?=
 =?us-ascii?Q?A9PJvGAxn32tY1242OjKdr2tS8OkX/S8pKksUXCX0hDVhBPQnXKXOK/M0Fct?=
 =?us-ascii?Q?PlCRVrT8hSe4iNvhTQOgoJojxy2kpRY/9Im29j7gmgQ+id0I1EmYvMs+RuSc?=
 =?us-ascii?Q?X57Rhz9ZD2OnwU1a9sxRcAy5kwpCollWKBZB0z8nYZ3pVWrBPp10ks66dh9p?=
 =?us-ascii?Q?rLCTX17Zltc+1yXej57u8NGhrkpKS8mZEA79zLUQVxOr+vGrkpypt1RC/knH?=
 =?us-ascii?Q?Wmbds7DrEq0aludDIFdMtZa0iOatrdb2L8V/XEgaL2Ld2kSEKiqiB8UT73Q8?=
 =?us-ascii?Q?zyny+8gkJSCGk6xMkoKm50ev+aSH1JsRxCHPhdG/1t/oXyVx1/eGeSw38k6T?=
 =?us-ascii?Q?Gqwbf9uAvu2x4hZfZsR3FJWiaWUWo3tF07kD1zu6ll/BSY+NxFyE9u4aqdrZ?=
 =?us-ascii?Q?0O+Tj/Js2Pc+vyFOfxgl/3BSQiWaX2yKW8J2NwGbuEKP3/jrp680kiBb+xm3?=
 =?us-ascii?Q?aeMrAqgUugmmYqsjo/yfv0qBc2TVddrG1ERR13JZv8U61gMHnHoGTrQa7mpm?=
 =?us-ascii?Q?FC5Ar7grAnSrHugIEUwro+a8e/67XLeeE7A0bmtbp0JL4cUBxYxCRGT73xYa?=
 =?us-ascii?Q?JyS5HTIproNFuIsMPgfz6lkNvfsL7ohqY7il2VH1uO65BIz9c8TAvLWWVPoy?=
 =?us-ascii?Q?Bj7k/dp4UU4fGU3lyeWlEPIYou8zM6pSghU8r3GgrBvXq2ZQZRNl5XcMdgmQ?=
 =?us-ascii?Q?TeZL1fXccNjBRDrt24pM1XaUnJjaZnUXbipexZBNAgwCPBYEN4XymiNuo5HT?=
 =?us-ascii?Q?ytpZF68kQxvz/fo9IGlH9Gx5hsmfrzM2YwlOf31bq+nSxBb8hSTGyGjKcIrV?=
 =?us-ascii?Q?5GXUxA++E+49rUdc2wBryoErUGTBGWKYDntBrV6/F5uO8E0aMgXMIF1QWvJ6?=
 =?us-ascii?Q?/AGaXHxnkBDY6zIITBCLCDvnD2BvWQY9dbFqewuuk1CCslvIJc47MP85OjUU?=
 =?us-ascii?Q?h3MceYBtjdMemW9UyM97vodoo5AX7cyGLhgAbEk/d56ct4uKLU/AgauahMxv?=
 =?us-ascii?Q?TXAMquR+WLMDKU5v4a2QZaaH0cD3Yc6Cf3qDNiaQiH35PZfrFSLK4lBnUWom?=
 =?us-ascii?Q?IqUkIGPZdsdwxGux8CyMorzlKh8LFuCYReBiIoFwK1SGttv9SWCJEToMHE2r?=
 =?us-ascii?Q?SNDGmEpABmT4oP8DBp41Xyoh2EHawYe+fZc/s5uzYir1ew+GksMNefNhl4rc?=
 =?us-ascii?Q?Xxb4VDX1g/aA6n7CsvMvgX8KaQmOLFllJRH3ycBCGSbHS1CZQPut35hy4Hk3?=
 =?us-ascii?Q?Ui2+/uokp7E45m+zDPcYn2ps3iALLBJxp1uIDQQjFTgxJtEXVS22DapSlekb?=
 =?us-ascii?Q?RMBQwLNi704EC9XEehDIa3qKrRD4+1rbwu4jRUNCR3+75/+UfYYordY6s7ke?=
 =?us-ascii?Q?28BnaTVbeQJ+uheMUqK3ddy9BtjwPo3TqV/u2Ajl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60fcb81-0f4e-42e0-330d-08dced1b49f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:14:24.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXQunXfSPujnKC6KsUXiakOn5LJC3NmOEPro8x1uNO8w3cM7peuOBmJxBAGzShF1MHEnoH7hcRmlKZUZVPXIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876

The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
EMDIO, so add new vendor ID and device ID to pci_device_id table to
support i.MX95 EMDIO. And the i.MX95 EMDIO has two pins that need to be
controlled, namely MDC and MDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index 2445e35a764a..9968a1e9b5ef 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -2,6 +2,7 @@
 /* Copyright 2019 NXP */
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
+#include <linux/pinctrl/consumer.h>
 #include "enetc_pf.h"
 
 #define ENETC_MDIO_DEV_ID	0xee01
@@ -71,6 +72,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
 	}
 
+	pinctrl_pm_select_default_state(dev);
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -113,6 +116,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_pci_mdio_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_NETC_EMDIO) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
-- 
2.34.1


