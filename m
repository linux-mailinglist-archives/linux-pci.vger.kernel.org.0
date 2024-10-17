Return-Path: <linux-pci+bounces-14749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A36629A1C7A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16423B264BC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588D1D27B3;
	Thu, 17 Oct 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GCXWIt/s"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9741D95B1;
	Thu, 17 Oct 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152195; cv=fail; b=Y9qgAAdlyxVNGQTpiHOxyKJjlInwTDZbFLSAu5MTVttT51Hxdidp0EDCgkQZyzKgFU4gRfgqndBfvC8Db6ovIONV4PnudifPK1UnRqZpfycoLLG5qSAnUxcoaa22qNxCK669c05XIB/R+Zu7fb1UDbgAtKJt8yAmHNc5SKFlkl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152195; c=relaxed/simple;
	bh=abo+Ldkgms1WGf+D6U/EWtSvOZ8tOEprokNyhD7z0oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c0QjbdQ9347Fny2d/B7Q2gMaqo/vPiA/CLDLkW2r6ttV1vYAxMspG0CLZ+hRkuTFkLKPzYP/tk9O0zE7II1MdI8X54CO+zhszkvPCBbMTrMU8spRth3K3X+g03Jy0Afaf6lcYKek6DLj/38H23sJoA3FYM2rARnLzM0P57SGWMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GCXWIt/s; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM7r7JqK5wTBGRBSkwIm6G7wkUBpHnuE2gnGztrUVKmeXpaCqBrjbZsmkVQ4LvOMx8Vf1aI3OfOprjJ4nwDYVCutB9wcdJHBC989sY9k8ArkQ5cwXztLhm8SjfTDswnFXDjcibfyuaYvKeUAmFhP4V741RNBh18SSnbCadGlTxHy96o/FGaIBbfZ4t8ilPH7uqmlCWCUL+18j6poYrcEKHaxUsPCClCXKyUM5G6kfs5++ngP1NkpgcBH6+UITA9P6byNmC8On4FVKRz7T+uyvCUsckvLq/AUEQKpX4ZWeenE061/OcEh7eN8U52tyT54c9VX/9FYH04brBrgrUlKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4602SH6vdfENeBnV7DfPkDPFj5nafh9EYI2M+Fd++4=;
 b=LaQgdGWzere9yMOJl1ulPxm1UNJyoO9U5zEF5VCwRpN9qoORv2U1+Ht66QWZO0F+jRXjOU19PlNXGYXyabhpd+7hk0bb/i4HRaUhVHB9P2IQRBfwT+eTbOb/bIaxVu63tlRyNLRNIwKvWAp1WChAfepwUibEvrjR/bawbcWEVEpTZbM+2dpdrIWdGAy+QNmhLb+muW7PP/4JhKGTLcXjV+WySH7ay9X6hyIIwXi46g6ooi03I8OtH2fZvBYaZDFYKzfwabBrcdftozUM6ng5+JtI5Pw6cJzHbS8CUefc7GhtxCcztyAxRfikTj2e/MAfg8kuOUKrwzYh8PNrCrgAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4602SH6vdfENeBnV7DfPkDPFj5nafh9EYI2M+Fd++4=;
 b=GCXWIt/s4q6+kyzOfgkVqMqxnuY98fpzQ/KaWd6Y7ZJBzoCVC4lxwgaZEJVETuWa4NEBa/lOD+Rfuhe4poA+Vc9TiyDUQMKCuhQ7WcFmbYV4sRONmikcdQcGCfi6MpvG/lm4yHRrrtxY31QQY8bq6b4ey/fFZmt9i8qCicQSMDxGWjk32YBmybV913nfc9mdVjhGw/isMetiKaPZtIL/CGLdlhYX7I3ODUJFklQxuBUVLnjGBlnPCy4NFVTrD6hQWPkSkzJWvDjoJJkIh69LVTWXIes9yVdpE/+zwElxPN/Q929KzCsvN8WPFRqNnCCfeG0+XklwFy5bjJ5Ucf2bYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:03:09 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:03:09 +0000
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
Subject: [PATCH v3 net-next 11/13] net: enetc: optimize the allocation of tx_bdr
Date: Thu, 17 Oct 2024 15:46:35 +0800
Message-Id: <20241017074637.1265584-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017074637.1265584-1-wei.fang@nxp.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: d110e7b5-4e9f-46f5-1d7f-08dcee822389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BA0o6dDcmHwqoY1FIUW0I+lzV3WGqzWvvbhXIgvAhZC4M503mG/oG66lddwn?=
 =?us-ascii?Q?8V2wiexiUXrZsArFXZlDeQqcXtz9r3rvn6tWeYCfwn1kbw/jn8Ql/g4NiMtC?=
 =?us-ascii?Q?ox8Oz0Nr3Hn+h0HJTyTzmasPwKDWqNbiYL1bI7K+wJN+WYjpCwb3STIFzioK?=
 =?us-ascii?Q?HIQKBvcqcx1usWLrd8EDmbjE6CHlmnPDctTUKEPlnXsTKa0dgR2Y82vy46m6?=
 =?us-ascii?Q?2HO574KW3DDitdeUmu/N8+o86eSVXFl+0MnAcAdckxH3SWoSz/tF4VOT+sFY?=
 =?us-ascii?Q?c2EdzsKTBUXDgfJuQaTaQJ6vxZnzRf5gi5D7Ig1nnda4kR/AO7bU9cGs9PWX?=
 =?us-ascii?Q?tiuhvNZEHnRNt+AF5pIFkQ9wM6rlrhX47p7THw5pRdTjLkPhTHPc1zKEaHDG?=
 =?us-ascii?Q?t3tMqQVoclVN6jiUR5Ko5YA7ET7nVl5pkuWiulxVsEiRjC+97i4hJUoZwOQB?=
 =?us-ascii?Q?hyn8etMP5hVbWFicKDJeXSqnmu65/BeHz18UxR4RF0pIixkPkJb9CBjh9PMk?=
 =?us-ascii?Q?wHimAh0y6+p2H10xrTtes+1hBd7pvR2OBwAcLmaopqpQJfrwJ5jgBDy/NcgC?=
 =?us-ascii?Q?JB8l28qjMs8kI4zjzvCgOTffVZqoiIUGmlYAQk/y9vfKED7bkwlTJv6Ybr+4?=
 =?us-ascii?Q?5ua28PfkDiLIERRLpy0PT3S8Iz4bYIFPUb/VudNjVLQgKDU3KKl0nyIIwP4n?=
 =?us-ascii?Q?r6n5o62jjmMaehy1gtPUDV98BdyktI8hDSGktgg/ud7WPIrUC5OkIEXFQSIL?=
 =?us-ascii?Q?X3euqwYESbXXl+14EZlfeiHoaENztBrTroWUg5EcWkDaxSIYyPmKJr3sY/E6?=
 =?us-ascii?Q?ZtveKw+A8QDm4Ky8K+p4LTGKneQ9KBmpO/RPQFZfGcjEvaXnyP4fIIpmMLR/?=
 =?us-ascii?Q?RMgGC+HFOafKXdq+oe1QpTm+u+mICm7z9r9p+3He9uOCXE9B5gHgSe8lEm+1?=
 =?us-ascii?Q?GX9jS6iCu/w7bPX0RpeEelrEMd0yOSV9HoHuLqq93SJM4L+Y8SR47NBg4hc9?=
 =?us-ascii?Q?JA1cT6cAj6NFlpEUCJdx/7FmIEGOpsMYMD/vrmWVDo2Z/yGOTv84+3eu5DT8?=
 =?us-ascii?Q?l/eGMAsiBmYy6FmjjXxaWQS3FcN2AZ4EGN1Nb9sqFBqAxM8vRk/5OKH5HZZm?=
 =?us-ascii?Q?F1/1eLdVlihUik7fv4VXBGFjR/j8XPqdVgduclf0Y35kKEq3AU9ibtYC8ci0?=
 =?us-ascii?Q?0tSkiTCht+W2GQiwl5U6E9cYtZtzIlyVs8R3vmWpj1cXQY6gzADd7la+Xo22?=
 =?us-ascii?Q?ryne6Tilp9TuJ2SKS2HaVUFvTAmFMXAAjIkaqjWjDKM3QfXezZYAshpcXEBC?=
 =?us-ascii?Q?0KUguurVDdHynwok/Fsyz86oKAp/+rkcEznA7jIYuF68pazIqQjQ29tliA4F?=
 =?us-ascii?Q?Z7pUL6G1Zpv8vOEbjCzFKP+K//+h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rGf7Q5saLr78mNEYDOJVTSiQ4V918+PQ/65SKvpRzugm6EFe05hTuz/4o4F3?=
 =?us-ascii?Q?8hchxZvyISydgEMJH6ry9thHO5Lc1gyLsHTWKnNFQhLGFdYuCIdZMSmM3oSd?=
 =?us-ascii?Q?Y87JYXhoqEeZRbwx7LGToHx2cNM3uLxBC7nI2ugLbMfSwIlsEmgU8SYyHXeh?=
 =?us-ascii?Q?xg5XFkzaYoPd2WanB5UxV3s5RLSSyOb82CHqhSFamOiOJmUOzZBxwqNMtHS0?=
 =?us-ascii?Q?N/roGwKZdnOUhRtdfSq7rOaeKfmc7tCN/f3VjgpSUWBv+ABsnE7LlFNFcgCk?=
 =?us-ascii?Q?mkcKZnavIRc2T951m8jstmk/CkuLpgJl4TcbHuoGRG7K9wgvWqGxmKJUaYyZ?=
 =?us-ascii?Q?en52i/qvpOZanvTKz91Vvezomb0kKxBmkMuhaboe1jQ8HBUoCD2INGGOMn3j?=
 =?us-ascii?Q?ungj7Ar9JeaEgkn5a1ilNjBKP11s5V3NPlXK3jwC2mZWOOJEnnS+0+fdIRbJ?=
 =?us-ascii?Q?du0p6czCNPgFfwWSqmgZ/f1zzLEhNHrOgiLVkYr/qklABbedM3SFqBXBuxzl?=
 =?us-ascii?Q?kozTyhJFHeHH+4NLxJxES4HGa07F8ixa4zLZr+wcko0eYW6ipufTvEHsllEh?=
 =?us-ascii?Q?6b+AM6uYFrXHz5fPivhkir6WwaMQt0i864PqzyBKFo2Gk5KOv6E275EOaTxf?=
 =?us-ascii?Q?ggfyBmaGs2fbZsT6Y2dF5YBY+R9+zs7RwSz9hsOke823WhMYaaEbwVBhFmI9?=
 =?us-ascii?Q?zCStzemLqLa1l0mR8xesmV1/g/Fzyz/k/1l1bQb1bbEHu9s2bCHeVcTyWnlm?=
 =?us-ascii?Q?reqYNizqfo5X1NvPZWPKoYV/hL11KW6ezyZSSygo4gl8dXl9m9q+B+8W93DD?=
 =?us-ascii?Q?qd1g0jZhJVb8XBqZ7mMs9G06H+DxQHXTs8u9epRd1SW/wO4rgduRiZ1nBfv5?=
 =?us-ascii?Q?n1DU9AYNzT4FOQWMOg4LKRtV3KAw+Sjr0JeWC+J6wbakysVKzIc4TtW/reB5?=
 =?us-ascii?Q?aNVaVNHV4/crNXEDCgF/0Dpj59PLGezy2GrpVsOSTA5b3POuHBOn3QEke/lz?=
 =?us-ascii?Q?DeRJdDpXpgazlWDGeofxxl3+huyVXLlq/9j65ZChah1j0RFkKscpCnLRQ9jO?=
 =?us-ascii?Q?P8qXXlOLzj90RK3K0+6f+2m+hfTvqZwR8AIxVeie9gmTMmSdr8JTFyKoiD7o?=
 =?us-ascii?Q?Zi3e+cfd9Yufv63SMBWwSj6bQbRXmUSaD5jIN/Pudq1+h7c3i2xYzRZIMSnb?=
 =?us-ascii?Q?dpvH2TWBhjZzF9kXcA44QP3wvt3gAD3SGYG413WqPx4iUOgGxoB/Z22cxX3J?=
 =?us-ascii?Q?rotJmHfcSkMMm6lZBH4AvqKBrF4/JAEr8DM1T3Vu05UppSJ/vS20VnaiDYcz?=
 =?us-ascii?Q?/POUREtGMB8sY0umu7SRTd1uKZbXt+LBEXGGP//9luKKSTkRzOngsXOnUlXC?=
 =?us-ascii?Q?/2MY689j/YIZk9BCvNgm2iFM6bAM+lvNY4cK99CG4SFBuwn413rJsfQn/PQQ?=
 =?us-ascii?Q?mVu881xaqs15bpvSxEDv3gHtd+/GfYavULXgJqhGLcJUkXXnYRx06B5JZZgQ?=
 =?us-ascii?Q?6YHpAz+DOguZFXPlFd8hUMDNPWgoFKEKK4TQCi8r5/g5Ddo7125hjhsEBki3?=
 =?us-ascii?Q?8Norgk41O2X6THqhhO7p1Bdr0oPUNpZPKyKViGuR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d110e7b5-4e9f-46f5-1d7f-08dcee822389
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:03:09.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YC+DvxTf89wnDtH3BMQbKdYzD/qEIOQHd+rgS+n6PHpL4zmEmPO52aO9pz3jITenwZZaSVt6NA2QCrEgbZiGuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

From: Clark Wang <xiaoning.wang@nxp.com>

There is a situation where num_tx_rings cannot be divided by bdr_int_num.
For example, num_tx_rings is 8 and bdr_int_num is 3. According to the
previous logic, this results in two tx_bdr corresponding memories not
being allocated, so when sending packets to tx ring 6 or 7, wild pointers
will be accessed. Of course, this issue doesn't exist on LS1028A, because
its num_tx_rings is 8, and bdr_int_num is either 1 or 2. However, there
is a risk for the upcoming i.MX95. Therefore, it is necessary to ensure
that each tx_bdr can be allocated to the corresponding memory.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 9 ("net: enetc: optimize the
allocation of tx_bdr"). Only the optimized part is kept.
v3: no changes, just rebase the patch from the previous one.
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index bd725561b8a2..bccbeb1f355c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3049,10 +3049,10 @@ static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
 int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 {
 	struct pci_dev *pdev = priv->si->pdev;
+	int v_tx_rings, v_remainder;
 	int num_stack_tx_queues;
 	int first_xdp_tx_ring;
 	int i, n, err, nvec;
-	int v_tx_rings;
 
 	nvec = ENETC_BDR_INT_BASE_IDX + priv->bdr_int_num;
 	/* allocate MSIX for both messaging and Rx/Tx interrupts */
@@ -3066,9 +3066,12 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 
 	/* # of tx rings per int vector */
 	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
+	v_remainder = priv->num_tx_rings % priv->bdr_int_num;
 
 	for (i = 0; i < priv->bdr_int_num; i++) {
-		err = enetc_int_vector_init(priv, i, v_tx_rings);
+		int num_tx_rings = i < v_remainder ? v_tx_rings + 1 : v_tx_rings;
+
+		err = enetc_int_vector_init(priv, i, num_tx_rings);
 		if (err)
 			goto fail;
 	}
-- 
2.34.1


