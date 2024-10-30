Return-Path: <linux-pci+bounces-15579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDC89B5F84
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D6D283920
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F71EB9EE;
	Wed, 30 Oct 2024 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cWKdImBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083F1EABDC;
	Wed, 30 Oct 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282150; cv=fail; b=ICIJf9PI8hWhlLIUxJl0+/QxFO96UYUGDWSyif49O+ms8yCINa8ngaZHjjTw7OuPBIeN9SLMKFPH4VJRlx0XI/murKLWxx3J1oVP5e4xps8KNIvw+NaUI5pW5MzL/vZpPKsKg47FyMiCrwT+LqjgYZ2imRuBI3NOaWgN3PYA6AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282150; c=relaxed/simple;
	bh=HoBm1EzDooAKHys1FjB6qVsFv9CMTg4Qgxw1LVvF0Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y+ZbgrO/7jgJD47ACw/yC4rv/uzutfBuwstGWbEX/yDD0bL5bF2CWQHOxzW6rCiuLUZ3EwHABhf8v34aZc8WfHRk6zEFDLip70cqCzGO3CzgI6fBOJUZimNw9FeTiOPS9p/CJln4MRNgP1haaUcv1ezlGOvfL0oBJJJXZrr5kwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cWKdImBI; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQPm+ZDXwhKAA/WLv0GnYyWWhxuYqGJ9iaF4hXS4t+vxOtz3J53UoyuYA1W7/BUnKnwfgyK/HfA3Co8hXQEHlrAkiTMkOmGaq3WDJ556adqkPW8P3iU2mBjKMnudDOfIpHAvGDmNBU2wrGXc4cGJ6BE7XdsEV6PVoij7Js+gE55fvKvFaeGmX6wlz2ZJnBlPmlPJv3njNFYRzW2tQMWi/D/pmZ+qZf64zAG3y/8UALnhQPvbc9RTqdQT+oNLb9dFGr3CavSLHpUnCScQR5jHjqGzR5gHjXhzFD3syEVhEts9RYKiVCAxsKnfPscvyPGcRVkHvSEhK5PxzK2hBuRFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCq20NAtgk0hyXkMNIIn0r67H4ms8Djwh3AFS5QawQs=;
 b=bHgrvUkcO/VRTS72lp/UfideXnOA9aznPXsBbdQQyFTw58b/P/HbFGSFmqPslhCEyiF5hCsBi0NUiWDpC7bqcIQJHY3fbFeRKeU/90dC66r3AIyLJDmjYvMz/bDPbBD2pNCTTA0kZ4RBzkdptfavA4o+qWxrYLh6UOawRjcRKUqFqjwTt3K9aJrTJrK9vS/dVHt/VYZipFqu4lHGcEW/rMt59TwLnoN4VrdDC/88fwnWjPiEdUaqP8pmAnrF129NAcJxuLnFm+PXlUEcpE2au0gNOHqmOIwzef1M/efwas/NHuekIr/SKNGmWFtZfk3OjLSjCJ/EiWyLfiK+ATm0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCq20NAtgk0hyXkMNIIn0r67H4ms8Djwh3AFS5QawQs=;
 b=cWKdImBIgJM13nCoUfYSs55GnngHVPPe4cyRtm8cL4F1Q2ljSPGKL7Gi2atZNh6N12z1maNFQ2OKqPD+YL2JHabAaPKmlZXnV1Iv3sMIJ4TrF/OLR15KbQ0vOvJUu8g5rxvLGyKurhMfTfL//SLvtgnUGNN8y2NZ/mkknOWPa4j7BMJQpl2rue82SGbTb9gO118eBmjdYE8t7eBLgWwoJeMM9J//ZnRqdJ3/t4o3bj9OUuVyVd2gvf9pFHkfBz14RuxaJBR4THwvJyYRkDOGlh9Juf/VeB1CleInIAHiZU/RvG3N26sj4wQAabfSD7ZVLooLAvXLQfrji4kYh7XPbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 09:55:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:55:44 +0000
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
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v6 net-next 10/12] net: enetc: optimize the allocation of tx_bdr
Date: Wed, 30 Oct 2024 17:39:21 +0800
Message-Id: <20241030093924.1251343-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030093924.1251343-1-wei.fang@nxp.com>
References: <20241030093924.1251343-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c2dcc4-7e37-4a04-d197-08dcf8c90595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lYinEs4DKPoMnmXmWcKdqEfUeTEcOBACqFtS+uVyX2kodH/gZ+di5pNrrbg5?=
 =?us-ascii?Q?AsxgSGtK0vT3tYEQAzX8fDXSnJKjj9dgJAzpxuHVEfCRzniFp0GY8EIGusyp?=
 =?us-ascii?Q?+aQ7rVlbT/xqazCEGB/YH6C0ZX6Ft6hvph99cLUSO3iBXCvJVU1dqHFSWAuX?=
 =?us-ascii?Q?THB3luHFfrMLlT0Aqj4+11I5ZlYMncgXI0K07udK110GHWR48O8Mz210UdE4?=
 =?us-ascii?Q?rMLfN3rQU++AOMKmeRRMqx3XfVgzqUH9vav9L/kVF3g4XOqIxa+OqbPrzB74?=
 =?us-ascii?Q?daCe7mOju7AffNIvT6fUV+sRnnRSs9blNcU0ca6DWUSKgjCAiwOlT4xOGF+/?=
 =?us-ascii?Q?PgIQ3qd8ACYithEOoPZcKMWVM2VVWQCEZ/L3E3H534c4eAyV+CzvmlU4L/J6?=
 =?us-ascii?Q?f0C5yPPk/CqXuJgNMFNTEjql7FbM/Ln/dITbmFfqVYMvJ3KkREMDI5Dx272H?=
 =?us-ascii?Q?v6R2Jtc4N6udj7XuLZa8VIeqWLDi0mkGd0yBjCdN08YGtJvktPR7WgQ++JLG?=
 =?us-ascii?Q?oWyw5BmNSY1A50eIvpgTcapWh4brnE2JEAMAEmq6aHCj9tUgcAM/dTd7YZh7?=
 =?us-ascii?Q?JV36tclXBO1jq3JEfwcQX4IHYgfbZ98aUypTHtA1oX7Sat+ISLHcO0x011kj?=
 =?us-ascii?Q?EdqodXCk3swRYege8hTaOMpyzFA8vMCDpVtPm4hXHNVDU+ViOmSjwTLupaXL?=
 =?us-ascii?Q?E9/QjYWfYCL/x+krVLR53b/vyUQtgqtFGm2mSnSYqVsiHHHGV4/CWEWopjce?=
 =?us-ascii?Q?Fjgt81fKH9ipgy/BUiJOTbAW1/AqAXD77NS8/gJti4MHukPZP4NaA5F4gWfQ?=
 =?us-ascii?Q?7hrkmuB6ftmW7/YhpVhOekxxdcX88KqyDCry47U9nMLvsFQBLC2VPVyTBn99?=
 =?us-ascii?Q?KH8lT4HeqsCYMzDufVId5MRP8fljdrSgRGh96VoYqfPrJX701aPYRGiOz4fO?=
 =?us-ascii?Q?4okzvJ7t8h3Bd7JZ8kyIEXwviha0JYf5v/0fze6+MOL+FDOtRGyb99wWv6Iv?=
 =?us-ascii?Q?Qdmjl6pEBHK2sWkej8bZPZh5zYSAk2rlTql2C+MpthPB8ODinI3c0nUAl490?=
 =?us-ascii?Q?aBKVrXt3k0tHvL1GPSnTvXXnkay8V/uxNnFy9rHU1vy4pO9RVNmBUSnpTMT0?=
 =?us-ascii?Q?HMF88wvFyLHovvlNKz8tbuHH9h3A4EK13B318MHY9hjz3p2yZ/EiyhKUtNgr?=
 =?us-ascii?Q?h+m32nWhUfTMizhkN/Pf7aq6Y3oCZFgD16i4s0bwxgPM8+uoZ37m72MGzbJW?=
 =?us-ascii?Q?p4SYbCnu8n44P+kpWOiUEHrgUgqiQfv2zKLANK07UfrtNBlnCdC2zrbIdwzR?=
 =?us-ascii?Q?cFOTmLZSAphG71onrj8yohpdVru1Cfw2DXqVjwz6JMDiP5m9Y+P/EQ4cIz84?=
 =?us-ascii?Q?OJtK7Sa2IvXM6R7dEIz+w56VcAPA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xC3mkSs7xLfBQif7vfS2d1jRCOyaapXDOn7YM1HzOnp9fyzR3F7+Knx9nH3n?=
 =?us-ascii?Q?MB/9tctV33Ex8QYBhRz3R9Dz2N+7B2UFnOZyC2gGEk2x2VvP0C0ngVmqSbcu?=
 =?us-ascii?Q?EOHVYX3uxFkxxAPOdJ5U8/nYdbezfWF0/cpvcBB7KSCm99DIeCuWNCrePbld?=
 =?us-ascii?Q?BsajRuHzd+K08jzS57G20u1lGYdMVwRTwalDySTfCDXo58i+tPEcq2iDTKpP?=
 =?us-ascii?Q?RilY2Ol4ioqHJ+eMCqbcH3Hs99iKgURKPXDMAqbSlY2xaUZdSNC6ll04Vu0A?=
 =?us-ascii?Q?P7imvFdnZwRuNUo63zygaKPgRU15OzuSJUxXZPtmV2QAy/0hYnTl/bKw9r7a?=
 =?us-ascii?Q?2Zy/owmntte16830dNiRltWpM+LTCx/gg7ZZR18YE32bsPA72geWYS4F7SfF?=
 =?us-ascii?Q?0L9O5TWpRihmN8c79XwGrRI5G37wWXCKVJJCqJiQq8+ujL06KqFok0UVawj3?=
 =?us-ascii?Q?uk1Rgq/YHS6HfAlpdsCkS6empC52Tg7ojzur7aaborTy61bTIvucvddiPhKv?=
 =?us-ascii?Q?U8FoZwreDMLuM1PESz+goVR2gvkqKDrPEEjJs4dnkOA9dniknH6m1BwzmGl/?=
 =?us-ascii?Q?URIcjb9YKEChbBAppat8zchURZx3GQhc10YOOfu1kTTjS9/5gNBqVFNBMs2N?=
 =?us-ascii?Q?QnzWkCykHcmKUyrFqiQsChU17F3WSBkTJMDrmBtzcjx7noXZ9E/ESPZEOrsY?=
 =?us-ascii?Q?sHcAwCSuUVXct8yb0Tmb0x5g4rzU4+eeP2v/ebVPHw2fmjohrmYF3u/PJBXT?=
 =?us-ascii?Q?hz44ehZIDg49hsgd2uQiGbMFEEONEF0rXmGD6Xk0Y2hkv1xs2HIJJ3qwOKA8?=
 =?us-ascii?Q?MKGOiNykhlUcp/kMUpetfZlMiq9dMBb+YFXQ1hfGZvAXY7MmGILuZ6nRt88w?=
 =?us-ascii?Q?/D4rLmNv79mJFfT4WwfDowCcoVKIMn1Gsq6VJaRtpKESDwXCkOkiHDRAWt9Y?=
 =?us-ascii?Q?D7IX7+X/6IzmisLcwzf4M5gv/6Z921v8OjU+JlEhuQHmy8zcEvLbLmyen8IS?=
 =?us-ascii?Q?ZWUN9y7Im/rEO6xwspVJZXSWyDHDzAY6P8ttvtHXBsXtBpwxzm0YGkb7wIEO?=
 =?us-ascii?Q?VFoD/0kyqFIiafwDD468H36hb/vR+5mUnN/4YieY1jjGq3aS1UYXGXhWTmc+?=
 =?us-ascii?Q?G2/ZeY5yohp9d1JANNRSrdP1ZM+ePB7qmqkXOxE92WbccXiTm1kaJcCwt3yK?=
 =?us-ascii?Q?lwFU8jaJN0LbdBy4tsgrG6M4400NmxEVcM5S6J41UrFj5eWAjqiIRrpHMw0Z?=
 =?us-ascii?Q?WIsTJiKDK4Dm0EF0+bGhr8o0KQjWelLMLAqNf8m+PCGqHx7BneNMBhiI94oG?=
 =?us-ascii?Q?H8h6u2bYfzt92Bih9ojClYA/hWBi4hlbaycBWEnhDYT9tJybb7jXXWZcAp8O?=
 =?us-ascii?Q?qOqiWm9u4boiBx4HwwdVomfkRA0J10wUB5D0s94JksAfUTLr188CVtG/xFoW?=
 =?us-ascii?Q?ma466nZ3XSf+Md/yrKPai4Ko+LeViLJXbsjkshuaQnIi2Juhzyt3vZ2MWlWL?=
 =?us-ascii?Q?H7AH6hTuXLr6PTwQ7qKaDTJuKL3wK90ZyVlzquEuj7EfJYBZKZddV0Ec2Dp5?=
 =?us-ascii?Q?CC+7qxuXnDO/zICF4w3psqEd6hUj/zPBqfcO5SeP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c2dcc4-7e37-4a04-d197-08dcf8c90595
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:55:44.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzvj64BcERSAWlYkr1qA93pCJgzY5i1tvAJIXlAcrdXgZG2xyjhYeyyYbFK4SZwKGIf0CZmcswbBYSqb2RftKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8912

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
v6: only add a opening comment in the code
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index f292c5ef27b7..89d919c713df 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3084,10 +3084,10 @@ static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
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
@@ -3101,9 +3101,15 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 
 	/* # of tx rings per int vector */
 	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
+	v_remainder = priv->num_tx_rings % priv->bdr_int_num;
 
 	for (i = 0; i < priv->bdr_int_num; i++) {
-		err = enetc_int_vector_init(priv, i, v_tx_rings);
+		/* Distribute the remaining TX rings to the first v_remainder
+		 * interrupt vectors
+		 */
+		int num_tx_rings = i < v_remainder ? v_tx_rings + 1 : v_tx_rings;
+
+		err = enetc_int_vector_init(priv, i, num_tx_rings);
 		if (err)
 			goto fail;
 	}
-- 
2.34.1


