Return-Path: <linux-pci+bounces-15182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793C69ADD4E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12341F21235
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38801BC065;
	Thu, 24 Oct 2024 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KQ/+hgnX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70B1B85FA;
	Thu, 24 Oct 2024 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753810; cv=fail; b=J+SZGz6826iRBAfdY008p4EDZDAsyuYmWzOlB3x75YlnpMVmTVBIdXD9nebT666oy78/zwLAdp+FfB+8x6TQdNnboNn5lbsxdjPDLQh2s5GbxXEhu0YHrtoR88tQFy02mbZE+lEymSgnfmp0MO0OIz9iJDbCt9KmlRrlytPJiLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753810; c=relaxed/simple;
	bh=dr9qt+8CLLI5xDCsLLrrWqJCcS32nP8ar1cVbB9DmaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tkDhCdt7502OJ/qGBLNf5sbPrRdcdouX8IoFXbcxkPg02u25Aaq6VL6+gAFECzZYDsmk+g0NCBrmL6FBvtr2Ri/1saMmOIDUN+fkmxSBP0O+hwwh03eTkIWUEy7HkzF27NzD6FpOVa//B/dTavOStxJPKUQ2qovHvwBxLz2Dd74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KQ/+hgnX; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxnwZggDEP7B2yL9w6kXvt1Xt5T3nxNzVa0JwPkmcukM1YaL79A73cEQO3Ml7tWD9DSrCRqDNxUXStzVXG67cVr6NJemLr3N2LEsaJdDAcosYFoLYBLVcNXO9as1gAarj2bmr6NTIuBBwyX9ZSspukzOdcT4AfYkwSSw3NQYT6fhlQ3ooqZQeNBia4nVFP61R0KKwXAjzDVCwsoA0r61eFwXjBcki2MZUnqDsS49PJgJ2xc53MsEy6qzlqTvMebv0votmjFsdWLr5jGU5Bxdmpb/486vVXh8yTPA/FwgUvn+fCbjGW7lDeYjh6DWKdxrhRHvbwQ1NE9OF//zMLOQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KegM9MJzzmghgX6XdsNK37mZZaPEB0COgnQ9VHSsX38=;
 b=bMs1rtGqwCVEAKLqVyUe8GttqI6hSvpKKL6rcJeGyFE7iHSmAvT0EeisLuRvx2VZi9XQL4KTTZodOdKAXNbBEt1yknvtt6KKVcr+tWh20UeV3L9zTTijUjDTliXjVtdc1Kg91jSKfKXwX6mtlqOn4PvWk3q/5Q4S6A9MKBl4Z4kl0d5XOMl+VisnCwpE2fwqrWGHLZh6lzE6E+Kle8tF4jU5uBmqsEqZBUpqA3vE0pzTxdoUzn/Y7jUoGn7qa3gS9tmUlx6G4fqnRbDo5EKW8RjL8/XupfIta/jLXQR/r9DqZ7QacUt4rHdhgA0zgi2ZiAt1crSGi4RXqTXlU0IvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KegM9MJzzmghgX6XdsNK37mZZaPEB0COgnQ9VHSsX38=;
 b=KQ/+hgnXmKTsVyUCxulCe1/u0eK6uQ1PD7kLCkr3hcOEWUOzd3b0sqsC7/vx4qA4ALpjzjt3dGmst40yrHEqszQOQnP5ocgStNu3C4cmTTYxkJapWp0dnVozE/DNLHI6SSFmi/8/x1K4h/HVJ2PRdDeh/ItQ1LNVhsbPqgGlKeALOSBl/gyYOVJ0/sVdj6nJLFgRSb720pDU0JmG2q8y/JIvHr2u02tgcVy1ULtMbLxqC+NUr2BcTnPs+mwXK7/oy4qMtSYpeifAwKh/Gpxss4NURJnGfM2BusvtGIdgblQIdA6be1oxzpyDtizN2WIXaeCBuWWH6jnmzH0KAyOR+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 07:10:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:10:03 +0000
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
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v5 net-next 13/13] MAINTAINERS: update ENETC driver files and maintainers
Date: Thu, 24 Oct 2024 14:53:28 +0800
Message-Id: <20241024065328.521518-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024065328.521518-1-wei.fang@nxp.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 250971d6-7967-423b-004e-08dcf3fae15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xqwHiyE74G5g7ST6HJfB5TsVrXPjeqOD+lcIclcgd6S9SgHUm/nE1/fZHCjy?=
 =?us-ascii?Q?qVhvvyYJmkIRDw7rNQnTDLGBs0XJe0jHWqKVLJutWrJazZuGhyvF8zQCVmsJ?=
 =?us-ascii?Q?BonfiFcCQTS/Ib2cIrph06CIiyKOWumRzHgZwymn60CHWo3voIFqbqLedIf0?=
 =?us-ascii?Q?KLVm3rAI6CT4/VJfmKoJuAM/e8TcaSBHsdvvcuBjY6493+1sn0SNdhgYsCfP?=
 =?us-ascii?Q?kDwwYSH1Ugi3DjiE01LOnUnc9DKD0ZVk8h/NHHmZRvNw1uxYLJ3RnJAhnGwd?=
 =?us-ascii?Q?GFS2d9uAEkQzEd0dSfwei6/hQeJRGt48nxZkIxtg2ESIU2n89RadQI9L73gx?=
 =?us-ascii?Q?Ru80lZphWhz3Y/x8zNWvGx3l7xBRHQHdznQYFCPQGxfKJwDC3yYq6y/S638u?=
 =?us-ascii?Q?PV0w6MhnCWJS0gULbGenj69qbqTd/aC8B0+QFP344yCBAf4wFDnSWDTes4YZ?=
 =?us-ascii?Q?SqZcccZCM7fvi/XaDuWLy8JSPral7gZTG5r6TxlIPBGRTtBwlHhIlWuUh1A9?=
 =?us-ascii?Q?PG0Db23l2ldcwgyM1/aPJmsGWNfBcc2XTLlEqPHoH8SottLr79FkbhgBwIkk?=
 =?us-ascii?Q?R3P2dfvVlUIh4vLsEZeTYyfBuFOmZOmt18GFf6Al9sXGOa+FX31D5l4smG2R?=
 =?us-ascii?Q?HIifmhH+6tDEVc7weOeb/tbjYJC/KEQBb7+91nRbUwaBYCRxv/H4R9WJ9lY2?=
 =?us-ascii?Q?mefgHuL/1SLha64u3LG/QEmO+aQH7AxAk6sHtBfPRBicI2cJhJ0prAWDjueM?=
 =?us-ascii?Q?y8J+DLHxHEM6IxLiUj8ssnxWLxVyOQugSxun6K9GFTkOgrnDFe95aa4fz2Ew?=
 =?us-ascii?Q?yc3RBYhhdcZvkzlfiJc8B08VheAPAY83Wpfj6s89B/Bkz13gtl7QE1Cm7eaE?=
 =?us-ascii?Q?eZR5YoWhq/QWXurv4czbmn1/IfscrPmtlyv+ymC+YeAxZsuGNzjJ7m619eg7?=
 =?us-ascii?Q?WHZQuqmEB3rMfWKeZ4KNQyHLIChFEzOjAcZyHS7EqSdkyoDXZRDCXEd5ChOT?=
 =?us-ascii?Q?ADNNDGwJaOuz0NExX6QnwN/BtvOcvHXKg7JaKiu/Ml+uH7nZEbYsX2f3LuKt?=
 =?us-ascii?Q?FXds32fJtKhw0y4RgvyZ56WmRUL0wD+GjPCulTNd8w5eM7Rt9aHr+osF9GHF?=
 =?us-ascii?Q?bCjj4IG42GvJ5VMxSHv9lfEMgEXkyMBwZjIeRScbjUzm9BSbCIZnYcp9F7zP?=
 =?us-ascii?Q?Zcji5oVT158mmjnxeXegXPtHiOZQVyNXD/i/6t1yske+a1dXNY65h3sN3+Cs?=
 =?us-ascii?Q?lcTIW3tN8x0yjGmC2yv2WAt87wV2Oce9uAEhbuwTf8U1UcnVpiXoDmh6dcaW?=
 =?us-ascii?Q?KXehdROc01x5oWNff36RQ3klTyF0PQzwYLZ31GUkrgihieCUQkQ/KPTt+VUR?=
 =?us-ascii?Q?/xLv4hQPeXBkQOHU4WcQkAOC2OHw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ijrsBoi1fJaZ9yTZXkxm9dy7eTySJ2FDaFF/uCTAW2RrI6CsgyC3ErBioahF?=
 =?us-ascii?Q?8optk+Q2baOlG55Fl4LqyUJrno5k/zHR258VFzuqGFTGETKJjGOMDzfnSjB3?=
 =?us-ascii?Q?Oed3/lSn/TzgNsZkWmOg29WvDikJeuwxhQavGauXUR/S7Gx4nfQwbWI7kNJc?=
 =?us-ascii?Q?hdx0arZ759coHepK4QYzLATKLxlXylfXpvrB+r0D+VwMrU+0RWK+Geuofki4?=
 =?us-ascii?Q?Ic4Arni2bS0mv1lfQEIP81s22w3LCoTGCQ2FwOO3CYbfTorg3QdPUIeEvz8s?=
 =?us-ascii?Q?b+AgfeXJmVP9qOldUKluEjqvyzy6zi9W7JF/b2t2XrBXLDXlb8peTEm/i/17?=
 =?us-ascii?Q?x6heCTN5OFCC1JBVCAn6au6TL5nysMA0qntP8/CaEAyiBZbkWgHeapOEhx4E?=
 =?us-ascii?Q?xTT6JkgDpUKPm7wv/WIwiRQQkVaYg9lfW7zDODSns1YIbA4PVQtqJVMFjW9v?=
 =?us-ascii?Q?LwCB4ZzvwAe11RheFQyv947LyW4S6HU7Kv2EMl5n/TSQglFx+SXzjRi+d24M?=
 =?us-ascii?Q?R53Z/6VqVmfxgd10u8jx0zSHgJWCW0/l1GKe0DVrRoipCKLiAUKTfYx/i9b8?=
 =?us-ascii?Q?+d99Z1W+fu0xtj4KaKC2J6+ydnq9OVJiMjRBUJSUsFBtY0QFD5sJQEJFU2Aj?=
 =?us-ascii?Q?GCDIoyCl3MMcvvMqKtTdq5DZE2yHzLl2Ppc8V7SAg5TZwIuRNIaAdHX0sv08?=
 =?us-ascii?Q?737xKxGytxKvxIIp1a0cgtRkH372a3PaGaKdQuUWP4Nu4Nv8cFNJh0aKdmo4?=
 =?us-ascii?Q?SNfLINKBuNUbtUEeWNce6jRNcuvqgdxMT6xqV33pW3fuRgdnWFB13Kz7KkPR?=
 =?us-ascii?Q?ruXssHkb/TTn8cXVRO+WSGIz5f4/mhacFJOgqRAS1MNvASwB2WH6QCdOthx0?=
 =?us-ascii?Q?MTSFxQh8KAunkp8IeQ7wNFBav/qZN18z43nb0iaZWuUjn8FrqxmPyME3lZ80?=
 =?us-ascii?Q?Zhktr1MZNfbU6rFJZ3dyho/uEY2jRw3E1bqCK4N6VzDK1B21F8EIDLvLQFOR?=
 =?us-ascii?Q?Vb9J14MuihA/wI/3drz40cMMPqeXp2HuLcFEoUkW/Gc+obcelCZ76/0o/6hd?=
 =?us-ascii?Q?7YVk4wXZSMMMakYKMKJXoWZtuDFVlKMN5i0VahV4pAi1+BdDoecZzL7Z6UN0?=
 =?us-ascii?Q?4BI8HSgKiU5S4OpNoZRGuPNHTYf5WHMxtvqvPJzFz1b0no0uYwcwZr8osE64?=
 =?us-ascii?Q?R6Lh6IG3tlFCmm03ay76DGJbF8v8XSww4nU1eHls16Iz0mqXFRY3H2U4nWeZ?=
 =?us-ascii?Q?bSiy1XhXrhmGXISE2zrYPUVRyUgSMD1QZQnKW2m6BsXkM+W4PVP/8Joq6LLb?=
 =?us-ascii?Q?SV1JzgVrRTsIgN5OMQINVyK4liYY4Z98HMMVFmR8ShgcsiDCoaXtvA40yC4e?=
 =?us-ascii?Q?TeOyIRXqgg+5UMLVxBYqbKBF6p9upA9VQ5TgLOZ4vqsR2RZHlngWd+66idaB?=
 =?us-ascii?Q?qZHrCxfjWywLK8d3i2MZr4EfYToRW8s9zEqsnACiMhtmXCCpvtE9GIhdCclc?=
 =?us-ascii?Q?PlZzjiQMl8GhnRBAJMf0AAWoynq4N7bPWg5NFZNUIHn6xWfBRa51zg052iwB?=
 =?us-ascii?Q?4Hap7ul9n0haOrK6b2LTfresjECReF/+kcHKrMzz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250971d6-7967-423b-004e-08dcf3fae15a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:10:03.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUA6Mz69pyk+By6cN9vXzj9mIW82tAaJ48EWhTXT+NRFSBHTSuq8j1ZpQbXpvIDlKnYYvXpIUu6VKxuVyZZpEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627

Add related YAML documentation and header files. Also, add maintainers
from the i.MX side as ENETC starts to be used on i.MX platforms.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v5: no changes
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


