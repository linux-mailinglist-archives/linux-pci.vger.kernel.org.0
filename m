Return-Path: <linux-pci+bounces-15176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10CF9ADD37
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE551F22332
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22951B0F3A;
	Thu, 24 Oct 2024 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Va1cqkU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF61B0F2A;
	Thu, 24 Oct 2024 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753766; cv=fail; b=DCmU9b6PEIfWSDerNMsXY+yQGndjuuyaKrj0/qA48Y/qo4pdlbeYXCeaXh/3J3Inm32QS/M5i/34LP5vb/+TOk2l/id2A/MTFErapPZ3V8n1QRdGlQ+p2auNgZsmGMsJ0XTomJ7Z8QZzG4JbbsjuOCjrs8WAJEcsG9cz0IlW/Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753766; c=relaxed/simple;
	bh=y/0sdgQbo0x3qjgBtUq1yDVfun3M5q+gXtLxJRAS584=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mmSGzWnQyECx5TydgeeGfW2oMl1+uhuTFY7PdiKX7z0U6XlLgEWF3vasq3q31tt9UsOTopUhv+axFobbqvQeLYQ6pEnBwP9elj5p/3kajGafep1EW47a99snSOfzemOcnBeU0fYSAIOVlolgZeYb0gXE8Ln6U2wjDCzWvR4xQ/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Va1cqkU9; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3ra0xwlTOIf8/oVRFNrbsSbwReyAqhFRgAfw24817vTEXm4QVpGWdxCCqXfTwiff7Rp8fI6iVqKQhRUf87HMdLsGyPn6zL5GYJpkEaI2Am7yEEzsalYqUato7/p8I3+iiTJwvhmp8pNCQsBxwBZpA68+C3sMwIyzFwvi72C5nzZWQS+Do69+CsK2C5i1oCWgcV2mWnRe0NcDO2A7YzyGBHqvd/vO3vAWGxprnZxCKFcvLh3RSDrrPbOjDO66r2sQviJV848WUxcaD4wrF6TbAxgwngBnuehBy2C53P56qh+9fBdIhaPcjNk+S7ITJbzZhLCm8jwBS17Cu9mSDEQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E9e5YnqvNdgA+hdfo8BSFOUjWSVVhRH0rAwzu9wJvc=;
 b=cDliL5oUMJlpTkPQjIeftUwKNumi0nL1bvqOoajQKn0ixDuJeojLA8/rDOAOduqzGh1sqRkstuGrCK3WAfAUUSufgoHCITXu6hUY/vLHfl/HT/Bk8gz/k14F5ZR59m7NGODxibX7kMU1U/QEav2Dkziqb+6wiBqOmUsmiFrlCVU30j1auGtYBX3kEV72O2Tvk3Dte41BETDWaDd9QV+MW1kIvviPxlTNUFY3X0LGXMtU1ojEA5cO1rujPqUCESndSOg4HVkbh3l1LLoDChq/BtfQ/vVlQb8sDZPgmo5R/mAoOb8E50hDaUI2dwGdp7LuRQba+O4KI18Hn3984l7AAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E9e5YnqvNdgA+hdfo8BSFOUjWSVVhRH0rAwzu9wJvc=;
 b=Va1cqkU9avvnfP+bmH/ylE0Xqo+BNTmoEWZ5na4NIo6ertTopQCHiAcgaGmI8IovHJEydf2k2zSYAwuLsuglBjEApMkEKNFZSuq6E8CK7ZLIe1lxsURlDsSSjC1M/izu0jswJ5bEWmz+XjO8OpH8J+uKUdwGAerWoUARgxJvhSJ08zcdPP8rR5kdT+IA6Qq/KkvIWHiNTjfsxZoa+YFw2EzKuOwbBmkbtwQI43LiRPk+B+gr7sCXwdzh15jt6tbCQy+bZboEvOoCL74sBBPt4XHazol6Zgr8qUv0nOTlVfSkDW+5u8DdKnuMmMb+KxCdfCDEHR3alK+3dGYcZ/7FzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 07:09:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:09:21 +0000
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
Subject: [PATCH v5 net-next 07/13] net: enetc: remove ERR050089 workaround for i.MX95
Date: Thu, 24 Oct 2024 14:53:22 +0800
Message-Id: <20241024065328.521518-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a6cb4ff8-6f35-4d83-549d-08dcf3fac893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3BEaTsLDar9/0bkBLy2jkXHBc1FZ/QZ+xdAr1awQVy2dYah2k99FuEyXdwQe?=
 =?us-ascii?Q?KByw37vEmpKHl2s6liG8aqXIvkL7EyJLH+9upeyMJPeC9mAjS5rOeugcMrU0?=
 =?us-ascii?Q?FW/T3n1Xl6QdzXiYJelcUFJCOuvJpDhrq5DBVw9FWiUY61eNuJw8xm1NjDr6?=
 =?us-ascii?Q?XprmhndqAyC3Tu9gb5GzQv0gfhHbF7Q0l1N4USw/bCNpGFxxOo2FfTb398GN?=
 =?us-ascii?Q?qLqa5j2nT2+6BFzukOb9iP7iQewXFuxhsQW5wOCUy769qRm3fL8VqQ4QVjBI?=
 =?us-ascii?Q?hZOTSKLe5of9KCJnWjNK8Rqk1IxdVzR2PIhR0pOqjgnMOCu/ZgS8jyTVwkJv?=
 =?us-ascii?Q?3BOP8cIPj+DfkkxZ1PJnnC19ALL4BNgk8ClYMqHs3MEa49tqXCKCxm5ACDQh?=
 =?us-ascii?Q?/BPwlGSg5+ycJCIXG7KXW7a8U47x55Tv21VEAVh7ZgJfa387uWw0sIgwzS2j?=
 =?us-ascii?Q?Z+v4yKbw/A8yvM8gjgqnl+A9vtRHM4uCD773j2kpYA4zd5PKO3zr+64ChBrb?=
 =?us-ascii?Q?4yq0qTd9dAaWrrIB2xQmjxjOt2HccEejc8ZYF0dVE2MdsUkNs6PrF5qPGFK8?=
 =?us-ascii?Q?oLygVYCsIfBX0ZFQJ4nrhYcQ8zEudrdo50YHkTnhNKrOQs931hThGqaMYN1i?=
 =?us-ascii?Q?RQP0X35I5Li0CnCNz5IIH8RMMXfatJNWEesEWe2e14vYXtyqd9rnTuRfpZRe?=
 =?us-ascii?Q?XNm3QDCttSfkdndMLt4GA93Auea5Knz6wq0JC2Pt20f7J5f1zlADpzZjHxHG?=
 =?us-ascii?Q?qQF7do1NU3n2AwyueiToGWDMtOYlHm97lcDWQ0+sX0E9Xn5ONGXcedSmxmML?=
 =?us-ascii?Q?dckBVjAtoR6apxQ1mC3ujLXV/qs5JAOYlfygwErXbNooYapQt4eOINmVE2/L?=
 =?us-ascii?Q?Ra61rnqVJzX4gKef2VkzGOOuIlL7IaUs1W+u96vA98QPqcxpPeXU+YehxC8S?=
 =?us-ascii?Q?un75BB4D+pCCp+qspoBAWRqr7yINPbk8oyYDRZ6TsBHNAz2XcHsjo3iJQVfi?=
 =?us-ascii?Q?46mdidTTXJQ5B2x9NJka2R95W9fKKLdKOmIMcbv0x3R1Obv910txSSAHcwFg?=
 =?us-ascii?Q?HkmiM5cYfILP2ov2c5JB8DYngELhmet9IHsL3DhqMfs4LApLwiqsjsDASeIg?=
 =?us-ascii?Q?Ak9CYyIWbs2mzunIWkVw2XrXFLYliSiJ7EZJ0dpyDKcY+6EY++oAQzvXWuCZ?=
 =?us-ascii?Q?M4pVlnwIuOZV0NhNYsaE4j2FSz8ZguBUp0m4YNi6K7nX5t8b7+1HcRD4OUWF?=
 =?us-ascii?Q?86QMAwnD11FsYyVzTyS+7HBF8MPkt3HNPpLWrpSbqnVO9tcNBEwuJwtiScjG?=
 =?us-ascii?Q?OCixhgmSXxq3ZwLfBhO8A2qkv2Y50bNk9viZRZzcMcOZiiuNUwKL1m/v4Qei?=
 =?us-ascii?Q?iWmZpshyxG3BnDyaBNDAGdJzAjHT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gm9xT5D6WZdKKo5sQmUZz5ScKiG7/t27OZrA0J2W0r8igXFWB3Oo6xgbZTJd?=
 =?us-ascii?Q?2WosqDERH8yExyKYCCLsPt7DDDIwvZFdi1fpslItc0BSHuO/GhwB6Lc69HDR?=
 =?us-ascii?Q?0Jm3PgDRLxDWIjOgxnE5fKF6VrBTkSLL9Em6K3Wi2fwPAynpPgn8PIr/uyZZ?=
 =?us-ascii?Q?7S//bdtr3JkBs9r5Wj23q1IOQmvL8t31Pf18zjNiH5MvtXoUdY+/ae86elRw?=
 =?us-ascii?Q?8HYZroK4GHwJJRy2k5MaMZ8FOun6icoPCnpoRHHYTF5apPcSQY07ilXNXq1n?=
 =?us-ascii?Q?vQ/V4czVn5noJ1zEE7+oD8sKwsI5Fh8bfQn22XJf3QfH2MB2rZXz9MNmm8jN?=
 =?us-ascii?Q?HiT5uKhFLUtJ6LKF5wdWAFOafhqEvKT6YNh6yxOCkbKpOCo0k34OTgDWS4YG?=
 =?us-ascii?Q?4BGjLa+BBAbXl3OlRPLwZWM2WTvx6Yej2qG/gLfXfKpKWaYj9ObFGNpMlFpP?=
 =?us-ascii?Q?yTB7NhPmWCB4bD9ZM+zJXR2K7rcK4Vif3l2EFz4iJgXpz8SlbJ2CeLuYGIxp?=
 =?us-ascii?Q?NZyBKf4DkMtqVUr7n2vV3zY+Cu+EWmwi4UaNvtUVM37cTCpQ/aEKrUdWE9n4?=
 =?us-ascii?Q?rdKU9TjMLEi9MAGIH9LbFN+lsSIG3AeZT1EDj8WmK+PzHlE+5J2G/y/Dstro?=
 =?us-ascii?Q?XFEoEjDQhMrdhlvpmB6FB07ZuJQtsW0BNF/pWakdQawDbXrnx8a/7XmbShbK?=
 =?us-ascii?Q?JCjFZkTjCll7msg9IiuSex7fTg89S0qCOYvaP/Y8LkKDYWVNsrnMAddO7+GJ?=
 =?us-ascii?Q?F2l2SisI5Z3xiyD/q/uiXJvWDCJNCgVbgb5JP91CJBfo6pycUOMnwto622U8?=
 =?us-ascii?Q?kvmtMCH847gtXwpkrklHvdTnzOzWV7mTTQngcLBaxOuIZs659IJwHTv40BF0?=
 =?us-ascii?Q?cRynrwIgVDPZnrKwS783MvrZAwmvtvF1b8ytIbp+IPjlhnYnaq7R9BMF5Vl2?=
 =?us-ascii?Q?Ipxi3CXvS4lBDqks+vYbTI2gH2AjY3JBhzBSGx/VzZVC45Hc3Ja1YwEKyCLt?=
 =?us-ascii?Q?QmYEMdcWSuR+yDE7ezFhQKvsJVqIcOMFhi1v9K6x0jvbXFDtSNVn7XkGxZis?=
 =?us-ascii?Q?mamyjbI68jxR2XcSboc9fkzGOY7oSfMW2c3Kg3c2LR74kYEKvyN5vQn5ciiF?=
 =?us-ascii?Q?AS7VrqSFLnUfHzxwCiZGHaZ2/sxPcUEd5bC8LjbvK17wIICJlhOR78d283lq?=
 =?us-ascii?Q?XKUd8i6bEQF7/eQub4O8EkUnkRc9qcMgxg1lNiVIYseQ+X9BbBzME6UZA7f+?=
 =?us-ascii?Q?meUIJ7C+0BiWCK/3YFP120RUiX71UT0rAInC01to83cZHm2424F0Ngoeb1bk?=
 =?us-ascii?Q?mmCFGEBUh3XJ6JT1BuycTad6I10wo/KTQdRYlcBeGhM+Sf2fx8PurIeCu4b5?=
 =?us-ascii?Q?9x2efdHI4/bPR4AXQuddRojjB9/NfdsX4i3DLqTXrQiFWq0fB0gax+G8kQjw?=
 =?us-ascii?Q?HMrU5OdXfc5OwzcJR2JJ2SNAObsJCAODIZIz2NFVJTGtZVg4uWVJJvmgkgrj?=
 =?us-ascii?Q?Hkk7wTUz9CGmJyyaDGHfvgpXFBHfwdnH8ekN4me4X8tzoe9m3hRlpt1Mr03g?=
 =?us-ascii?Q?M1Rv7VM7qrZ0376+gQADDjAWJOQsTdLF+f+vkm/f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cb4ff8-6f35-4d83-549d-08dcf3fac893
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:09:21.4404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLeZSj4HgnP10p5SKav1I/9m4WB3Wj3Yr3k0x4BAcOK/+nxXSIMgkVvf84jgavvCvaIwjBkrLqdIv6VXYTUGKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The ERR050089 workaround causes performance degradation and potential
functional issues (e.g., RCU stalls) under certain workloads. Since
new SoCs like i.MX95 do not require this workaround, use a static key
to compile out enetc_lock_mdio() and enetc_unlock_mdio() at runtime,
improving performance and avoiding unnecessary logic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v5: no changes
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 34 +++++++++++++------
 .../ethernet/freescale/enetc/enetc_pci_mdio.c | 17 ++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 1619943fb263..6a7b9b75d660 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -396,18 +396,22 @@ struct enetc_hw {
  */
 extern rwlock_t enetc_mdio_lock;
 
+DECLARE_STATIC_KEY_FALSE(enetc_has_err050089);
+
 /* use this locking primitive only on the fast datapath to
  * group together multiple non-MDIO register accesses to
  * minimize the overhead of the lock
  */
 static inline void enetc_lock_mdio(void)
 {
-	read_lock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_lock(&enetc_mdio_lock);
 }
 
 static inline void enetc_unlock_mdio(void)
 {
-	read_unlock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_unlock(&enetc_mdio_lock);
 }
 
 /* use these accessors only on the fast datapath under
@@ -416,14 +420,16 @@ static inline void enetc_unlock_mdio(void)
  */
 static inline u32 enetc_rd_reg_hot(void __iomem *reg)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	return ioread32(reg);
 }
 
 static inline void enetc_wr_reg_hot(void __iomem *reg, u32 val)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	iowrite32(val, reg);
 }
@@ -452,9 +458,13 @@ static inline u32 _enetc_rd_mdio_reg_wa(void __iomem *reg)
 	unsigned long flags;
 	u32 val;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	val = ioread32(reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		val = ioread32(reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		val = ioread32(reg);
+	}
 
 	return val;
 }
@@ -463,9 +473,13 @@ static inline void _enetc_wr_mdio_reg_wa(void __iomem *reg, u32 val)
 {
 	unsigned long flags;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	iowrite32(val, reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		iowrite32(val, reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		iowrite32(val, reg);
+	}
 }
 
 #ifdef ioread64
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index a1b595bd7993..2445e35a764a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -9,6 +9,9 @@
 #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
 #define ENETC_MDIO_DRV_NAME	ENETC_MDIO_DEV_NAME " driver"
 
+DEFINE_STATIC_KEY_FALSE(enetc_has_err050089);
+EXPORT_SYMBOL_GPL(enetc_has_err050089);
+
 static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -62,6 +65,12 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		goto err_pci_mem_reg;
 	}
 
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_inc(&enetc_has_err050089);
+		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
+	}
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -88,6 +97,14 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 	struct enetc_mdio_priv *mdio_priv;
 
 	mdiobus_unregister(bus);
+
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_dec(&enetc_has_err050089);
+		if (!static_key_enabled(&enetc_has_err050089.key))
+			dev_info(&pdev->dev, "Disabled ERR050089 workaround\n");
+	}
+
 	mdio_priv = bus->priv;
 	iounmap(mdio_priv->hw->port);
 	pci_release_region(pdev, 0);
-- 
2.34.1


