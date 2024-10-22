Return-Path: <linux-pci+bounces-14985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8638B9A996B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DFAB22711
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5714B97E;
	Tue, 22 Oct 2024 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N6BkwxKk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A113DDA7;
	Tue, 22 Oct 2024 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577333; cv=fail; b=Jtpabzym3285on9A6r0uK9FEfHgt2P5FAhBUaQGUibM0ocCzXTWaiBT7TVAWuDE283WUPzkCUc0Kn2G+M4cOHQqR0AGogaLjxCQVKDfin6K3+epSFzeNG8HaKryb0LlLHi5DwBmxGn90OirQctOQ8qf/QYg95ayMC6g3fhRxPLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577333; c=relaxed/simple;
	bh=CMR1MTWBRh4PtmuCnZ+YzxacBVOxQaUaEfp6mHI3Jxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlGw2ASlYBSu7CLv/hYDXOz2v4QKCULp7Loh+jxZwn89Qt56iO1w42ouhuJ5U5/JmNTwzmAWmX6gBp0P4p4AE9Z+OYY+06iot+AXNX+HzZfEVNc+3AqJcpP1MbiR+RHiBzL4hIcsyx8XXmA66hXqzZKzgcgc71MSSR/zj6jwc14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N6BkwxKk; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbPKVd4zo36/bV/F87H8fyP6Q1kfSfn7JVJuFFM/MONCWTGnVsyXCE32UnS0OlijBBR4hP9g5jUbWr8HZNktZbs7lNcjWxMiNwT5WypnB/L5OK5zhbSo0VxYlboXY+uIJTZ/CR5q+NKVi+NkIPNgErIlIO3TNnAQVL3XPPxAhGBWkR0uZN/K7h2ehbwAXJ/ORe1+yoJdODVCrYP4CxXnhBNqDbz3kIR0MnGI/O70Ti9xTxsS8K0HgcaGj1jZlH5oPoFwPWi83J4HCMglcEBEYX1NEAY5m5AMn45ZfNPTmdP9Qap6EN9cdhowuxvaVc2ZpSMK7TPM91BF8X4z8kTWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DbjJMH9diPVADu92WgHGlNkPOBTOQUh4eck8ZNZt88=;
 b=wbR9/i83vyO0Jy0a5j2mFg6AKWjBRgTDm4XJhgGTSXlURVnwL8KEH1nXDRMZBy6VaXBGOx7zzp1wFOS7N2hmThgBMjnDYA5G2A2TLEn2tYu87UVsewj95xnxYpmMRWrQvVw53zzdEr0lwP6MwiG9Au0w8CT1a4WIoWfVzKJZCzauyEAp5gLZV+g9yDFEjSo32ZdrkSqzB4MUZxYpKzDlqhhZFaktqutoEM0KY4YP2ivfD5Y4jHnr6Rlz73jByzrMVjzdAgmVOKqMn0jBz1YGb7wuUSn0IynWh6d8gxwcZJIdkznfMusA8MxncCJP6oBG4OgMV5iUYUhQ/QRPce4PEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DbjJMH9diPVADu92WgHGlNkPOBTOQUh4eck8ZNZt88=;
 b=N6BkwxKkpTSlxfxDEngH89e0NabiN3L6xFUiY8GeDAAkBgRLRICQmYO19gcoqCDaYZj4qwM6U7JTUSveEdO3q2KfhOx0eqvmkGFXN3qW+ZxDgRg5xFc6WIzY129gyirrZDPfa0B2Kl+jMNPRrfDe9GazXQ2LhNBtmHLiUYqZXEF5db9+YjCzp5bWKilYcu6gZ5nkItoIxXOllbrqC/4iTMlMVVlt//UcWUZxxIpnNlWDPCMTSOb8Z1mmRpx5DRrNBvjdCI7kGAdEuW3Ew+lNIrsFjWPbZGb0EnD/ZPEG9ytP5m45IRgkYavCgs6l3JHlgfNNEec1TXH4HsL/E859cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:08:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:08:49 +0000
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
Subject: [PATCH v4 net-next 13/13] MAINTAINERS: update ENETC driver files and maintainers
Date: Tue, 22 Oct 2024 13:52:23 +0800
Message-Id: <20241022055223.382277-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022055223.382277-1-wei.fang@nxp.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9d305c-c1db-4d46-1e45-08dcf25ffee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tf7G8O6hZAu3XmLkuW3+YpaTFcKU6JOQs/JMH3BLKyBGCTqbZFn8csAgL/PZ?=
 =?us-ascii?Q?m72FPSC0YeCq4NTOXf2yXbA40xPx6Iwjlv0qJzq0XPDfyHRtwnUisVQlQwCi?=
 =?us-ascii?Q?RsWXqK6UzEiJNU+7teuWW8t0Oysijmqh7QuVRjmnARRw55PzDFypKZzzA8G0?=
 =?us-ascii?Q?b7BBvSzTYpDJSs8zInnyZ4eiee+7RzKEK4SbApFOadFfBW9P57cs8FcHhqH+?=
 =?us-ascii?Q?Cn5/OFStztlcB9zUht+hw5R2Tjwz4Rrj95cEZkP/iOAibOU5MQgiRGZZEHzj?=
 =?us-ascii?Q?WtHXnWxAwhP/X+zLiiuK9hC9KgYHdrQYVaXRANQsjpwAMqcaf5ChzSEHBjas?=
 =?us-ascii?Q?4RAr53sJR1Z9xb/aqXbyH+4ALEWUY5Wv+kitaah3CzbxW3PXuuTC6Ru/Ioqk?=
 =?us-ascii?Q?zCBHxtXl6+QgoN5kLAELnVVksW4TJwIc80YaFLC0MenUMcYjhYNg99ZMr+PX?=
 =?us-ascii?Q?TYVGVYuIhUhBC6qyhOb53qC4XAJ7iA/8ldOmb0oyFmXZx0+ie294UYRByw5R?=
 =?us-ascii?Q?gcahDUYC0MtBwlzpOoIWd0Xu9f4CbxXe7ekyi0VFoz5qXkfpOa0di+mUSXa6?=
 =?us-ascii?Q?AZMXz9MFBsTfehY1I21SHzZEw6gx+ZA75MSmaaaQTx7w2EY0jZEYM2fGOjlQ?=
 =?us-ascii?Q?1wiWf15WKQ5S2fbuoRb6rMITAR3q12e1w8RiBdbAB6d+X6ULpIuI93TTqqAm?=
 =?us-ascii?Q?UsKzhPw1OJ+6mwrGG+IutLgv3+H6gi+0X8Rnwq+on+TaX9zUpQW/0CvLBjki?=
 =?us-ascii?Q?V7MGNFGQ7/F1eo5bEArXZjBlnKeDsExK/idiPu1h088O5bg74Cxb2sagNXNQ?=
 =?us-ascii?Q?6HSS/2T0Uo4cjKlPPV7d2D1pEh3JT/p+LOuXhmoRYmfZ7/QrWumqk56Jk8LF?=
 =?us-ascii?Q?vgA/pSruI9tlQ/FxzSrGnvZl4VmcTrCyqwO1KGV8daY+n/gGrJ478ljDcC1Y?=
 =?us-ascii?Q?gPSkdSsbFROQNn35amu0znu93l7cbvwrMob2YZat89Prvp+6jNqy17GEc7fe?=
 =?us-ascii?Q?1sGEZpk0nlJrfi/2g0BU9ZiVk8fPhTdErySiJVYkbpgxbzCOiWM2oRDCNKAQ?=
 =?us-ascii?Q?MuIZxjV9WSrg78Yu8tnxe7RB6l/dbCAeGtbAtuMJlFFOCKR9b2Ca0tnfQKtD?=
 =?us-ascii?Q?Rcl3Xw0Gis/eNTwON9Il7RT5tvWdAfWdWve2qva6mGHYy4NvVRywU/m7Kdqu?=
 =?us-ascii?Q?GlsPbeZyn7rmEMkd+WOI/Ze1uWi+uP7CsHBrJCNcwmT79n6fSwH5wE0oCqic?=
 =?us-ascii?Q?4F1PQsnInf6bom8PjNSSVHYcxPwgQ0ZUGBQRt9sCC73A3S6xmaVuI4SE/FL+?=
 =?us-ascii?Q?stkQBGyHNeI9uYFIeRCrMhbP5+k78YoHvQuF1Q4sOBBsI6BSwUqOz/OiZwOF?=
 =?us-ascii?Q?2g/5k1eBLil8lr4dbF0keBUif8C6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JzeIiyaQROEGLhX0XpkaPPQGVsxA/JMVBJuAtnaUJQrH5lx8fG/4O3csBFDw?=
 =?us-ascii?Q?bhcZSJAIQ7vnM609ErDk3GL7gXXwkSqpDgtW9oVqd8FoFiCYk7yL269jq2b3?=
 =?us-ascii?Q?EEbwCxnuWxQpXo7czfqQKoUBtGJrGi/V4iU97ENXr0HIEijARhiw0kbEbfjw?=
 =?us-ascii?Q?h714iky2yQXta5PunH9OU4JB9H9ddgVu5tKf4PvCdUIV8nJ+xouF2ntiH3/1?=
 =?us-ascii?Q?slVo1ylslBaQQGvEvIBEl18wkESmg7l7AkNJf76HvNJHPVR4X7Q63yEo7NFe?=
 =?us-ascii?Q?kQ04tit/YJSJzQwyHsGpoXPTe5XkcO8sZGjwoA3OYdzEiAM3DrLmmm7UkuUi?=
 =?us-ascii?Q?KG8c23PhaSoRNF0BC+MCB0WW75TR/xwT3lVNwtSlKssACBYMkzo/udbkQlN7?=
 =?us-ascii?Q?Q/vAOMMz+iJmo6xOc9MNVgtDNa75mBm8htaOpLEc5MfJGg0AuynfVm6MiBVE?=
 =?us-ascii?Q?9y3MsGY4Rwh4wzzdgBGUhi0ToQok/fMSJIzx5RqHLTAJjQLTY6xhm1Zuutla?=
 =?us-ascii?Q?vyfD7cLrK3NgOHO3TVi9Of6r8c/AZhBDe8qkD/QS5x1SdYCVkOVQT8SuxyK+?=
 =?us-ascii?Q?MsLbsLOh+o0Dzx8S40u4vL0g1/2bIQjESikkOGTrVyIuxoBbfb/AUBb4M8wF?=
 =?us-ascii?Q?lcPFwDgdHjus/DF6jh48Ifp6/yIWxW7Gm6vgraB6/NCTMzhVrfLYC+HqqwHk?=
 =?us-ascii?Q?Hk6OWc2gRA1MxRvhkJqHDLY/mj8ReM5FRPraovGD6X/EV6DX+RJJFlS3MdvF?=
 =?us-ascii?Q?fD3fy29/TuLd4GgBndW8zmQcyxDxazBHzJI0VNpFr9NrTI53vOi1/5evdli/?=
 =?us-ascii?Q?NyjgfUVhOQYFjWm2Un0JdjNcYXfgOq+/uIHcSuMsbtKLxjjL/l1nVz+MCutY?=
 =?us-ascii?Q?umhUzI84fNhfojbT1vb0jwlKs00KVVfUSFuzb2GO2TKAkofdJR5I78y2i+vy?=
 =?us-ascii?Q?7isXYsBjjn6xcEJtV/yGylIx9EclLrPu9b7/QeFTCRJmWPTTum66rDRyWgPu?=
 =?us-ascii?Q?FAT1R/mK3xJ59ukAukTYOjLGk+zVTQE5dNNOwN2VM4+tMTvYsfCwPxQsxVJn?=
 =?us-ascii?Q?4ubNbyb+VjsWfiOqz4htze5VHagdIvfhWis1+J6XStQX/2u+lRKPI69t6/bv?=
 =?us-ascii?Q?U+HpQE+1vd4B82z+pOeHfmZgllnJ/4HtUbcdcSM9FAQJJdZH15GLHtwyvqud?=
 =?us-ascii?Q?lJQWyCEwA2e6RLT+RQDeV9xbaKKxupZYzhOZofQd7a8vyO8ZOtkEskeruG9y?=
 =?us-ascii?Q?hEWWD23h6C9Fe+VNQg0OtQZB+AayHZji2Q4uX0EsT5xHaT0jUcs4q7zLQuuP?=
 =?us-ascii?Q?ljogmhsUfoRYcHh8mQDHTdPmaYIxDBrkruCLS1c8pD1jZgM+CAmotjJy7Afk?=
 =?us-ascii?Q?S1mpER4oQPHpjYD7eopC0horvI26W5261DmCFmQjAiVJFalYArLEIm+jFPM/?=
 =?us-ascii?Q?s3sY4LGKNEryWDo+nVMfv70iWgYsqBICNFtf2rlMyP5EYr2TvAV/JA7kHsLp?=
 =?us-ascii?Q?eI/IwnUbCwbzszATyNdx5JQMnuwCGgLgKQHjnGfAHFRhAWfVX3FVreocrLQk?=
 =?us-ascii?Q?U9YW3reKfCpYS7hdJ6q3AMCdwO5RrtZ41aJbcSj+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9d305c-c1db-4d46-1e45-08dcf25ffee3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:08:49.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPum0pumvakuGHtFGoeOCa2/kST+lUgTnhYqRhAvFc02fiugRuXjvqASEnNLucwH9UeaR77/qRSqOO0j85QunA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

Add related YAML documentation and header files. Also, add maintainers
from the i.MX side as ENETC starts to be used on i.MX platforms.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes: Use regular expressions to match related files.
v3: no changes
v4: no changes
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


