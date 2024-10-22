Return-Path: <linux-pci+bounces-14982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97D9A9960
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE87D1F210A3
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50914146A63;
	Tue, 22 Oct 2024 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E9WY5zNI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380D18593C;
	Tue, 22 Oct 2024 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577315; cv=fail; b=c+4vHwhDGInLQmrHACkaEjdxOMlPuu/5wsx/GNet8HflDKMHEu2I9gAt5Eo+8SwT5A8E08SisiTj4KyAVf1aO+j14vn04YeCAqyDqBQs36O0og6AwxiXGbkSe8pWSxZXhYCs2hP8foszd05N4u/D2cMgecveF7R6WGkYcvoJ9cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577315; c=relaxed/simple;
	bh=yVAAHcHHtRX6Bsmh63eZVVCTgbAvgGdeH/W9RESeMgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LhjoCAVt2P7YY83svY6k2s1QsFgwJNTK8f2n36mCMqsaaF3/fWS7jhrisQk58rTEi4LeBTyzNksECgQVLlbCJv6q0MxqeizYJrVp6pqDzOx7KwemuE5w0vO27BsyCQmTy6QCOma5LS6rzhKBrncHJTUCdjO8jwPxBhdFM5J61J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E9WY5zNI; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkXyQ8+xaOws5Ice3Ql91K7X+4j77u/b5CVUpYrtQR704uwSxGIH0OwENABFlGD4od40a/WPRUzP2img7nN64dN7qfY4i/IJ66uYndqXH8bQ1y6W/LuEkoY1rZsxzFtGKRiNBS478iLWLgY4ruIqg48HcIsJ4Hjp69Via+reota0rGhM87hn9fWddrVmpwWs28rOcFWLsH26Wss/qQKff1ASe7B6x8e6+JGfQEN1sqbuFYlQSf8XEdBv3vKwsb+KPlPNeQlqIoXU713u9StQ0yrxydtv575oVdaR4Q1pDQPlyXUR005S7cigMDkL9BKk4+ECB4QPRQBjC7psHXWA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tN8ij26V4eZHVADKtxTxTbo5Z3CV4Oy5E4MAWJEEjY=;
 b=ax++bLPngCHTGOg+baQvT8bGaWdDJHUO2qHGSCrOYbE0/+gjSDsodxQQeRrslLbLlXKNBOuL1MIeIMIPcD3mqYMOisGs3/fCuir8v1leP0lQPYxFT4XZbWWpma46Ym8Rpns8IWfL0Z5pIyjZFxg31FkZm1Nfa4GzZPtkgRBeGnu95XGYEhetW+aBTO0geJ3vES0SLAHyCzFGiLOUfJKbLfqHns1cjc2anLxoLe5HqzduYCBeHQdDDptxJFMXThnZDiuNAYB5mUJfFwmmXZvdDONyKcvB86XwNQ7Qq3j1PPvXISPTtfolz89ZAtVhOqDNbopuiYhoJFteItSNm/xfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tN8ij26V4eZHVADKtxTxTbo5Z3CV4Oy5E4MAWJEEjY=;
 b=E9WY5zNIU8StiDKY88H+4gu5CFTL32V+HJA5wd4kGb3KB8jEuDf31QZd7itkVR+HkgrNnRRsWq3lBs+0SBQJASh7lJMoSj5bWNPpvIviTbGUM8CoRxj4mnsX1ih36WUh/AkkpdnOSxSbNT/CO9KmV/mvboPDdckCJ4CzfQoET81uZ2WRwrD9Bnowe654gS/SshjnZ/CjAgmhBtXzg+VF/zThquCmnsOeFRXkoxX4iStLjDlB6E+L408dCa80jqwBDbYSMVolDwDBn7KTFDzIVvlYN6ypu2D3j8OWwIOy1BkJqAmVMLYW1Ar293oKu3xXPcAC9Pp6mrzaJB4Kl4SE8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:08:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:08:30 +0000
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
Subject: [PATCH v4 net-next 10/13] net: enetc: extract enetc_int_vector_init/destroy() from enetc_alloc_msix()
Date: Tue, 22 Oct 2024 13:52:20 +0800
Message-Id: <20241022055223.382277-11-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20e80055-d207-429c-e1dc-08dcf25ff34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hRURA9dom5f2ehreafm/wgAIgqVaN6G6cgfJrh9eo2hCaRX7ddlJrjqzaukv?=
 =?us-ascii?Q?ofvrhJTUm4qP0+Rzvp9cMoVc6Ww279+t5h83HeeRta/TYVYNdk3Nqx4g35+f?=
 =?us-ascii?Q?T43hwNI+tZ0DIdLbc/bp/RbMW87RdfKAog+Z/NM3cmrq83nS3UauhfXufah4?=
 =?us-ascii?Q?A1y1SZeAMgCLgcFp3e9tEVPeqg3xdV3OokZ6/pJR8fBlBNSSt7KB8YulGADN?=
 =?us-ascii?Q?0mKhnwS+axezB8AElHM/W2nlvb1KHCIZxORjvoxXNM9MvHqf+qIC3pzrORe0?=
 =?us-ascii?Q?3UKpCs+CqdAmQ8VzB7ZQbSKMaxCXvhHy2/9nZwh0L+a2GNzd7NutbLqty1ro?=
 =?us-ascii?Q?rX2XKilOOo7xcxuMs4zPubBnZzWULcsy+LXutlEv0iw0focvhjAHTE5x3mUR?=
 =?us-ascii?Q?1cqf1FVMgWh4pNJjOfeaIsrwbwVEtSgzPKFTp+xDywdeCwvZTfKY34y86W3H?=
 =?us-ascii?Q?g74i00nvVlO+z4XSc/L1teqozy8U0kDEbV6wGclakV76sE3i621lomuY20oJ?=
 =?us-ascii?Q?fsgsROY7l/iAN1gc2U7vqCXjXpnHHOsekQKp1k2J5GM2cKh7l7np6jPjtwJz?=
 =?us-ascii?Q?53C8PTtQfTaU8LOik5R0jlcY+6ji5HhZDnmpgXgIDCDUGd0sUq2OwHn5GsEA?=
 =?us-ascii?Q?0VsML9JY/RUzKjOKDsrhBq5dcTwslSzwA9pvcfK0kUpr73Dg9/I6W82LDBRU?=
 =?us-ascii?Q?FsOUwIct7XddHvhuv/5a7oaFZI4OlT6fywpTc4s5UUAl5nbEHgXOQWzVNFwu?=
 =?us-ascii?Q?Wbm5/h1j1IjU1yjWIfDBtNoo3AJnU2MilUMlIwocYR/t1y835sGWIcNXF8RB?=
 =?us-ascii?Q?D9zpkKJIAIW4K0vx4fBB5YhipvWP23l+4qfFJtgUw1Hl5jBf5qCeRnxugK+1?=
 =?us-ascii?Q?AsvWucfjStuVw9+HtdekN7LL4WL3Hp0JrlYLmWUyT+19TZujAwzVRcSZF01E?=
 =?us-ascii?Q?HhTwYj4f5OT7rhygiYwUJly9Ihy7adROoVeM7sW8Ayv8aypQr1ZtGmDyMtYM?=
 =?us-ascii?Q?5WIT4uVNZY993EZ7I0sr7Y5YRSqTrtqIFP0+GGfUC1/6GWJGagQVPPjGJCnv?=
 =?us-ascii?Q?2z3AqT8MMXButPV3mHnwUo9TJp8eeolwjPUw/9VQtd42WdHbHrUJ5wwBCGrj?=
 =?us-ascii?Q?1s1nGvKY7CF6JQsUkh93kVtBs8CF25YwFrXbm5CEH+pQQAJUDyIpUKPInwxe?=
 =?us-ascii?Q?Ld0pu9BtKOfx1/4DX81x4xD9xkuDC4Ascx/Dyhjllm+t+ds0deTmfW89EqsV?=
 =?us-ascii?Q?nCCD2rOQDqQlCA8UAnwZR3high++5vRolcIw3tyiWjjUFRRKd+cphyjHWHHy?=
 =?us-ascii?Q?jUD7SZt2kD3k1QOIsqmJI3WVQji0pHsPwZDHqX/5VbFhw9V4UAu/qHIVK6J2?=
 =?us-ascii?Q?xzaYcFmwN9zm8oLhV12kFansUz2u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YEyaHb8qIZhSIHPS88dzUhGPOL0x47Dh1oJ1eBWRnVz6ZukfXcrqLlPQUZ0t?=
 =?us-ascii?Q?eWc+acMLBudlzTqjXrwmbU5lRsApfVL2uoMDPFkjAoxkkRVTjAqBsq9RrZbl?=
 =?us-ascii?Q?FNtk8JBYte5rmjdO4gLdFsY8W2XVkbtPcHHVg4SoTiOkNqTBK+MsT20In/+W?=
 =?us-ascii?Q?xeHC9mkkAhXytnOcNrbUeC3w6jXeIvssO6MSXEmgA7TIFS6s//y5VVpUWKk2?=
 =?us-ascii?Q?CXf8awb7TIypjkLnTgat7q9Pct1bb/1IjJzjW+AXxQG1C8OtDVnfOZtb4Ijr?=
 =?us-ascii?Q?5Q+7ehqP722iE786T84aoD/N3lkcajTmRHkTSSeojf0yGvW1vTGn066LkbpE?=
 =?us-ascii?Q?MR0F7oYlvpSBaPVsyQ0w9JCDxaZj+69bnz4q3mctJR2BY3wM74Borbs/WaBn?=
 =?us-ascii?Q?igyPCHCO9fpRw8DWgAziD/hpFQq9X14qmwMzBDggp5jgtAOYHNAhdwrK8uXL?=
 =?us-ascii?Q?Mb8fFDhCuX/Q4eujKpwmqygGAL3ZTTIFTFWPEUwZ+9hr36dXY1scT1h1R5bJ?=
 =?us-ascii?Q?iPg6RxxVc/CCYj7Uf8vr10kT5mWUn+GNovIJd21wOPBc+kOYtO/QNmv+i821?=
 =?us-ascii?Q?XFR3V4x7VjTs+ag4zizwq5mIHZW2Od6zBkxKh24VmiO8sl1+CPMX2gkGe/w8?=
 =?us-ascii?Q?d+5WJQ9mRBTRHxSKY0x+YiynQjNDDIwGNI6KNbByTV6GeUWSEK8f4HkBvlmG?=
 =?us-ascii?Q?V6Bfovq0FURQxow60oPpALanchvObljFiI4HPi1e7vPX8JbQATuKTczWd3r3?=
 =?us-ascii?Q?JrgyAf3sqh877TBQvaGRH4s6Vv1Uq77VVDaIeumUE+lSgSQ5ahyQkal2z6ef?=
 =?us-ascii?Q?Tk5F+6m+X2Y73S1LHBKcOyIarAr1O4BaH7Q+VfpZQ70zuJxp+XiIhrGH7WoG?=
 =?us-ascii?Q?xoACNnoxTDEmGI2TiBEnD/Ki0JVHBU5SXVHz3cdqPahp2uVB3IToMEMdgowH?=
 =?us-ascii?Q?AwqfFwLPPIsEyAgeGBGJVB657Fjfo+dTMzpIHkBaldxZsRLstypMLFPfq1V9?=
 =?us-ascii?Q?r6xcHWA+kAc3mYnuYlV83t3xyZNJK/ejTY1AmOzzcYTnjhm/j/t6Yqf9J1XW?=
 =?us-ascii?Q?nDlmltr6IzNM5LflLLyP86+oulhaMxGI10aKIfg2W+TQT1esWTH3ZazrVTPi?=
 =?us-ascii?Q?l3MGafH4cRtNKUmyHXITjt5t6I85CkyfV6QGAc21s12OkyAwPyl0BP8ZocjX?=
 =?us-ascii?Q?ahuPFOogAnYRPftS8PvH9HxBrEXCI2STF9WBhu8bSLwinrpgb4LMwG19GxB7?=
 =?us-ascii?Q?2nAtWc8sUmfen1c5fHl2BPKTvT/einOHDfT4zsKIu/jUFUeIsFnlWUi2V/PM?=
 =?us-ascii?Q?mnd3eBIYJ+Gzkut8OAxl0CZa2UrFS0QfS8vlU+fGyhtax/FGToO4ZAAJi7iT?=
 =?us-ascii?Q?Wjg7jgU/FzX7ik8JrUIItqf0A6eOPfYWwOjWKATtch3bg5HKSsqPP3tx+UB+?=
 =?us-ascii?Q?5IM3FILnwECBr+tbwHPs+KIwWpbJv5zNJXnGtAIc0X/8qJ1KoMabGMVdkirp?=
 =?us-ascii?Q?B/H16R1lKgbDn9PbwxOTdNIc1QSd8RMG42OllHts6R0QCcY8DHU+IpMHbITQ?=
 =?us-ascii?Q?1cltoEL7ivThPux/gra0IH9Cxs3cqAUo6e9VkTmf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e80055-d207-429c-e1dc-08dcf25ff34f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:08:30.2590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwF/euFdESp+GGEtgOlFS4hImGZ/aLmJILQbj66LDMq1C466FiuK5EvSFfVj2j6bM0w0faHe+XsVoE/r/PPMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

From: Clark Wang <xiaoning.wang@nxp.com>

Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
enetc_alloc_msix() so that the code is more concise and readable. In
addition, slightly different from before, the cleanup helper function
is used to manage dynamically allocated memory resources.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 9 ("net: enetc: optimize the
allocation of tx_bdr"). Separate enetc_int_vector_init() from the
original patch. In addition, add new help function
enetc_int_vector_destroy().
v3 changes:
1. Add the description of cleanup helper function used
enetc_int_vector_init() to the commit message.
2. Fix the 'err' uninitialized issue when enetc_int_vector_init()
returns error.
v4: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 172 ++++++++++---------
 1 file changed, 87 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 032d8eadd003..bd725561b8a2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2965,6 +2965,87 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 }
 EXPORT_SYMBOL_GPL(enetc_ioctl);
 
+static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
+				 int v_tx_rings)
+{
+	struct enetc_int_vector *v __free(kfree);
+	struct enetc_bdr *bdr;
+	int j, err;
+
+	v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
+	if (!v)
+		return -ENOMEM;
+
+	bdr = &v->rx_ring;
+	bdr->index = i;
+	bdr->ndev = priv->ndev;
+	bdr->dev = priv->dev;
+	bdr->bd_count = priv->rx_bd_count;
+	bdr->buffer_offset = ENETC_RXB_PAD;
+	priv->rx_ring[i] = bdr;
+
+	err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
+	if (err)
+		return err;
+
+	err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
+					 MEM_TYPE_PAGE_SHARED, NULL);
+	if (err) {
+		xdp_rxq_info_unreg(&bdr->xdp.rxq);
+		return err;
+	}
+
+	/* init defaults for adaptive IC */
+	if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
+		v->rx_ictt = 0x1;
+		v->rx_dim_en = true;
+	}
+
+	INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
+	netif_napi_add(priv->ndev, &v->napi, enetc_poll);
+	v->count_tx_rings = v_tx_rings;
+
+	for (j = 0; j < v_tx_rings; j++) {
+		int idx;
+
+		/* default tx ring mapping policy */
+		idx = priv->bdr_int_num * j + i;
+		__set_bit(idx, &v->tx_rings_map);
+		bdr = &v->tx_ring[j];
+		bdr->index = idx;
+		bdr->ndev = priv->ndev;
+		bdr->dev = priv->dev;
+		bdr->bd_count = priv->tx_bd_count;
+		priv->tx_ring[idx] = bdr;
+	}
+
+	priv->int_vector[i] = no_free_ptr(v);
+
+	return 0;
+}
+
+static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
+{
+	struct enetc_int_vector *v = priv->int_vector[i];
+	struct enetc_bdr *rx_ring = &v->rx_ring;
+	int j, tx_ring_index;
+
+	xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
+	xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
+	netif_napi_del(&v->napi);
+	cancel_work_sync(&v->rx_dim.work);
+
+	priv->rx_ring[i] = NULL;
+
+	for (j = 0; j < v->count_tx_rings; j++) {
+		tx_ring_index = priv->bdr_int_num * j + i;
+		priv->tx_ring[tx_ring_index] = NULL;
+	}
+
+	kfree(v);
+	priv->int_vector[i] = NULL;
+}
+
 int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 {
 	struct pci_dev *pdev = priv->si->pdev;
@@ -2987,62 +3068,9 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
 
 	for (i = 0; i < priv->bdr_int_num; i++) {
-		struct enetc_int_vector *v;
-		struct enetc_bdr *bdr;
-		int j;
-
-		v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
-		if (!v) {
-			err = -ENOMEM;
-			goto fail;
-		}
-
-		priv->int_vector[i] = v;
-
-		bdr = &v->rx_ring;
-		bdr->index = i;
-		bdr->ndev = priv->ndev;
-		bdr->dev = priv->dev;
-		bdr->bd_count = priv->rx_bd_count;
-		bdr->buffer_offset = ENETC_RXB_PAD;
-		priv->rx_ring[i] = bdr;
-
-		err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
-		if (err) {
-			kfree(v);
-			goto fail;
-		}
-
-		err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
-						 MEM_TYPE_PAGE_SHARED, NULL);
-		if (err) {
-			xdp_rxq_info_unreg(&bdr->xdp.rxq);
-			kfree(v);
+		err = enetc_int_vector_init(priv, i, v_tx_rings);
+		if (err)
 			goto fail;
-		}
-
-		/* init defaults for adaptive IC */
-		if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
-			v->rx_ictt = 0x1;
-			v->rx_dim_en = true;
-		}
-		INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
-		netif_napi_add(priv->ndev, &v->napi, enetc_poll);
-		v->count_tx_rings = v_tx_rings;
-
-		for (j = 0; j < v_tx_rings; j++) {
-			int idx;
-
-			/* default tx ring mapping policy */
-			idx = priv->bdr_int_num * j + i;
-			__set_bit(idx, &v->tx_rings_map);
-			bdr = &v->tx_ring[j];
-			bdr->index = idx;
-			bdr->ndev = priv->ndev;
-			bdr->dev = priv->dev;
-			bdr->bd_count = priv->tx_bd_count;
-			priv->tx_ring[idx] = bdr;
-		}
 	}
 
 	num_stack_tx_queues = enetc_num_stack_tx_queues(priv);
@@ -3062,16 +3090,8 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 	return 0;
 
 fail:
-	while (i--) {
-		struct enetc_int_vector *v = priv->int_vector[i];
-		struct enetc_bdr *rx_ring = &v->rx_ring;
-
-		xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
-		xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
-		netif_napi_del(&v->napi);
-		cancel_work_sync(&v->rx_dim.work);
-		kfree(v);
-	}
+	while (i--)
+		enetc_int_vector_destroy(priv, i);
 
 	pci_free_irq_vectors(pdev);
 
@@ -3083,26 +3103,8 @@ void enetc_free_msix(struct enetc_ndev_priv *priv)
 {
 	int i;
 
-	for (i = 0; i < priv->bdr_int_num; i++) {
-		struct enetc_int_vector *v = priv->int_vector[i];
-		struct enetc_bdr *rx_ring = &v->rx_ring;
-
-		xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
-		xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
-		netif_napi_del(&v->napi);
-		cancel_work_sync(&v->rx_dim.work);
-	}
-
-	for (i = 0; i < priv->num_rx_rings; i++)
-		priv->rx_ring[i] = NULL;
-
-	for (i = 0; i < priv->num_tx_rings; i++)
-		priv->tx_ring[i] = NULL;
-
-	for (i = 0; i < priv->bdr_int_num; i++) {
-		kfree(priv->int_vector[i]);
-		priv->int_vector[i] = NULL;
-	}
+	for (i = 0; i < priv->bdr_int_num; i++)
+		enetc_int_vector_destroy(priv, i);
 
 	/* disable all MSIX for this device */
 	pci_free_irq_vectors(priv->si->pdev);
-- 
2.34.1


