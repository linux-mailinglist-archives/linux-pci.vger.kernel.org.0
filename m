Return-Path: <linux-pci+bounces-14983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B241F9A9965
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C557B22E12
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C618E76B;
	Tue, 22 Oct 2024 06:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BgeSXHuw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B41474A2;
	Tue, 22 Oct 2024 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577320; cv=fail; b=D4VGzNhtewoZmcfXfC3W2Te5CQQUCli/AvWglIVxtFYwfDbVl7qjFWniS3iQRw/oiHoBdIvl/MIp6MqZ4d6ygHhhg03MGBSHNN1yDODaawGj4ONHD7SjKjYp/NtMSpRXN32NqDi3evt1mkYoNQWUpMFq+WFFTA16XH23TkAj6SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577320; c=relaxed/simple;
	bh=kFgkmMpBlZsN7DM9JNq97B87Lawof9byE9hqTeaxjlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qYjnUxCZeFNlP8GoJ3YHt637DeutVXaRAN8qOYISYXRIpzHLLqCvHVkX8JVL0FQbUcp+p8MLo/pNBVpDPPH3ahKCKaymAUDzoX83nK3KaidtoQtk85LE2xW3VwjEWg8U/fCvYZBV1bXa914IgM2pboGwOyXU0X6LXXpAx1Au4zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BgeSXHuw; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXGIusmVq21RJcGIWkkMcpv0iGUY/KFDcTFhhM4uzAxWlt9oOe60wk8NpPgS0eegctE+wL/Zv2o/0WHdBsSr5U3F/vr5FpRjTkXxqZYyJiIYG/HVx16/kD9N3TrSp8ISm0Ir6AMpaySfQ5s0S4HTUyHDjbClqLLnADelLNk4zAqH6kOHruHFF8ry3a/2TVtaQ4AQM8C4mT9KnbSdG1/n76bqhqdAP/KQLFriWmx7a+WRMuW58WtnWAo2M5dmaH0BEQDtJYGzwl2ELl6s8WP7AQ/LuXS1joB/zP+lrQmlZrDNRDqFojO64vcV3aUHll7Z/Alk5IzoGyuHl0xCuPSniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdAhcwQQmGPB8MZ/CuJSqegdRBokGu2xj4as0U81KXI=;
 b=Ix78J370QEsq8yRN1uexEKoXkaReTybUxQHi6/hHSm1yZEqkJsD6+BkROGpn0JPcIOXlE2ulT1/3GYLCFTsLW5XlSQ+dwzALwLi8OB13w7anBYTnYjgSdZWyvS8S5eD7Gcj9qlHPGjEz9CBHGdAxJ6VMQ4BFhZPJGCVuw9glk7vda1NF/CWHmQ4tZcW8bOnXs7eKHTl97Sj0qkzy8pONr/1vEpSeL5ESWIcipsAs3kaIT4ucNBYxZyi0ZjvLSJM/Cc/z1Hr1BHbi4EWsjAL2jiJTZE73LvX1pvXRR6lPuG+Apm2qi4YXuQ2WZSYWKMsckqfxBLsoVxtzEAvfPQX0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdAhcwQQmGPB8MZ/CuJSqegdRBokGu2xj4as0U81KXI=;
 b=BgeSXHuwEi9ZZr63ZyrgUERXHVIFoD+OSWc0llxLnMPtgMSMYIJht6GV2CnzNd3x5La94bLdqMWZVlwszon48PjCn9XJdk/oTCy6dBf4xTKEhV7ZKJtV+H/5sr1aenBgk6Vv6rLXrs8mnPv6F7ic5XZNRewDbdTt0WHIZxY7ORICbbzHK0EdXpbqJExZ4FygZciI7YoVgcwV53iS0GhNmkz5LpL4quQc1NyJxmo92Xvhrl0r91AeUXaE9qsEeitHrHnMjwVp5VPdor0x6OIIGdUcz0GImzq+XoVysdkaup5BpQqfKtsCtL+bl18ezH/wBLXw8X+V2MVscj0MT4ZEWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:08:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:08:36 +0000
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
Subject: [PATCH v4 net-next 11/13] net: enetc: optimize the allocation of tx_bdr
Date: Tue, 22 Oct 2024 13:52:21 +0800
Message-Id: <20241022055223.382277-12-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea7e4a5e-0173-4ee2-22fc-08dcf25ff720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qjmTH7ZGWILUgAFHMQs6xM2Kt0Ip+mfaWo7Uk1g48HFESIKbi+GdijfixAAu?=
 =?us-ascii?Q?KNRRxOC/JyLeLBrGiZRsB1LTo4a+3psryIB8Y+jUBh+RM4hb1C0ZhUH+P8eS?=
 =?us-ascii?Q?aAKv5v0hDMCXpApEFNwB9gDkumO8xQ2XcbdD8hbcpdHPIUoPy1c49XQhgNf4?=
 =?us-ascii?Q?V2s71Bg93L8EHSlL+N2W2cKcsvJYyb6Twa28gJgGTmf7ucU2um2VKkSexdM2?=
 =?us-ascii?Q?HoaaMxrNBPydOSIM+V6VgT3PgjJJKEGdjyKfeTXRmUSDv0RDg4n60vL3XHNv?=
 =?us-ascii?Q?b7nDixaLuHebyituMg9NRhorUv3yz+NOZ4HXGH2E/ff/6x66YHFxBCgqi+9d?=
 =?us-ascii?Q?tm0MEzpoEBEgrOwt8OB4fB5R1oRNDhZ5dIQyLiQqyi2M4V0suLYo4R9V8aV4?=
 =?us-ascii?Q?GyUTRPU5fK61r8gUUGOwfgFAKuQZRolJIXBYWRYeYv5ds2F+Fr7O5i2eu9Xf?=
 =?us-ascii?Q?uhsPqK7sLn0emcQpDpe9Bixr4mrOgB45/utTALhP+TEJIUfXhWcWc62ug5XZ?=
 =?us-ascii?Q?1VDPCSEVGWzHjBwjM6tu5i0Rp5RN+NGSAVAQZW1tOJ59Zxa0+T1ogXRZCEP+?=
 =?us-ascii?Q?RmcuP+YHWtJORHJxlb8RuyO4JZPeiZnv1QkCFqnVQQG9xi0frY3waHKhzvXh?=
 =?us-ascii?Q?Iz0Lx47rPbgHXEiQcM4F3RwsTjxxzCJe2oRlva/F2l+U485V2a6vjvm3LpqN?=
 =?us-ascii?Q?5sVWgokNkotx8ESHcjPzw2tO92L7Zdj2asXnK8baY4btS8YIij3U9eLwyI20?=
 =?us-ascii?Q?xKeq8m9TBT2x+vYlyL031D7PbiGKDpG6t7WHA4IS4ospQrcXBrRM6wlDytw6?=
 =?us-ascii?Q?kBW6U8vVsSmYN1CGXgk13Gfpd6y4hmzD1hFqZhdmIf+7/ZIPpD0yjlXcgZ08?=
 =?us-ascii?Q?y8scOIKlxChvStltNr2kgpd3h9LqHM4F2hQaynyimJYAlbJSTQrPsmsNLoah?=
 =?us-ascii?Q?iGCRQrojIclXQDKvyv5ak1/LebNOPQkDZxX1XlI230d12LISS3LmyX1cRwN4?=
 =?us-ascii?Q?61ikhA5/j3hB5ecsgS77CTPcKIiuwjnftc3wM0bbWuq/f3h9DtfaUCan0L0i?=
 =?us-ascii?Q?95DfnysSQ7eMt34I25YLsS/+FXFQ87DLSw2o7GyG3R4tIHwyaH1rSZ9Hj6q8?=
 =?us-ascii?Q?en4QO07imk9HKzF9p0laE/pq3ADRKrYGoz2kihuoSzPQJPL3N7l1g7yrH3Hc?=
 =?us-ascii?Q?YLjJ04Wm9ZXrdP/PZ23aT+SU6O4bIk+e48QUpgs8rOMAfQGZvrPPPnj8affa?=
 =?us-ascii?Q?RSLG0lVQMPumNSHK0snnrXmHAQM0iZe5BsRFEohn0/Iwa0zWOlHRmfkUwTOY?=
 =?us-ascii?Q?/qyRmyjuesID0UkK9b38nBYnTcWTXNjMJw9wD9GTMo/gYOnOAMeXtrnZE6a/?=
 =?us-ascii?Q?mrxnF6A8v0UpF/aO1Rxkbwh2f0wj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RaNQ1M/11Z6+ehPmQYZQdzSdRacKY9dIc/oBhWCxo/n064oaShQrZwx7nUok?=
 =?us-ascii?Q?P2e6qxogtt4j06nf2kO19z8OZ8XTDBivvknmAM7uVEG/gy/E8bl8dMAvnY9q?=
 =?us-ascii?Q?qn1jUZe8sCFCQTM2jL8NMqDmXSucufqQ50TT1jwK+ihvDUZtwaFdRVI8lHNn?=
 =?us-ascii?Q?Fywcp8byLcF/PKWC+Zi8OwG140D1E6WboG/K2KLcAV/huhQbH45cuKMGEDvl?=
 =?us-ascii?Q?AfO3qayW/pRWlfDcnVVy/HeX3dw0wQFQX0xjW7j7zdP4e/3DHTpw8SWkVzhI?=
 =?us-ascii?Q?A1wPUBU+sOomPwJqNbrp+uRIL/FOAHJ4cce5xdL1Y0V9AR/jeOXDa0XecuoR?=
 =?us-ascii?Q?6K/ZBOJeWlCG26vWFEgNafc2WssPlL8MvlMp88JnHJCfSqObFWAQ+38+kUnn?=
 =?us-ascii?Q?BjkikB02SYjBsIUzMEkPrrfyxx9eIn6YHtCoPE/7faUye74ZfjsISb+HQ2MY?=
 =?us-ascii?Q?1OB4XzdewaCXP068HQ2V2U9naXzLLPoK+QIjs3NjBy6Ya3rLfX3zcdBBgsHS?=
 =?us-ascii?Q?ngFx9vjckjsh5lJnLg1KRRvQIiFBeE+HTJkBFsON+q87HSpEZ3z5+VUrUmOx?=
 =?us-ascii?Q?MelW6hycaxsWmPM83NDWCmiAmQ5IpHmR+u9DMYibxbUKqZostBW5AnTV51+s?=
 =?us-ascii?Q?qf2Q8sPHUukwX858GEufGWvMVPnLLS1KyWfb7abtlYWeEXSacAbAjSbsCJge?=
 =?us-ascii?Q?JemBXjgOsMq6Szd7s6TCcBsPWnUSuvi355BUO56g44QPMZgic0r4KvfIjxrp?=
 =?us-ascii?Q?gH6bpKCsEbbRc4nNvyaH4gPCjuRuxhuzvHvNpxDzfQrk8L9JciKP/UEdebt2?=
 =?us-ascii?Q?aJl04jtyfxYpbxiVL67LW7QaeNF+CbBe0d+iBTyUPSutJXW1Halh2zxv7dry?=
 =?us-ascii?Q?UmAigf/nK725+lUbgTk86Ltl0ceM29c7E/IKDptmKc69ySyWSZxiYP7R2RQ4?=
 =?us-ascii?Q?oAbPf7nJvgAeSFCIkElHnnD+0hsd357tAnz5rdMKQOrd0R5bjtgZaX5Nv44e?=
 =?us-ascii?Q?HeU+UJDdwnX6jqgMDEezuXHuUiNobmgocfRIlgH7h77JuBvXARJtONNfYfnd?=
 =?us-ascii?Q?aX0VwTlVMYMmFw0xP62ioekOWuQ/WCqUfY/U2Dg+ygWiF0cnFt6Jn2lC1srn?=
 =?us-ascii?Q?a+EGdgUZjX/8x351/9HTu9szLKb/Bp8NK69hNWzvCvfft4Bsyj6qsn/9C7RO?=
 =?us-ascii?Q?9yFQ+8B3+aQ6doVbTsptZU2/vM0XHO/6biaZYnmxPL7s11VaTewJPWGc3Iy3?=
 =?us-ascii?Q?8LERzM+XCgdpoBCXc7WLov2Ox6A/b1tMKvSW9mMCFo6KdFx0WlGaqkIysgAy?=
 =?us-ascii?Q?UCocBXvjcJp2ZhukAFCEihm7O9cqA3GjPIZNEfpuVskbdo6Nntr7Bb5ixub3?=
 =?us-ascii?Q?Ce2i/OIRBPJEdVFIrtsYe068xWeUPyfJ8i6Vx9EpIWsBbpZlnHm0Nix4Yxta?=
 =?us-ascii?Q?wXn7T2WdWBuQFeardRic2+NNAsW97kFXnyXxWmu5HVV5HPeYfOT65KIqvNN1?=
 =?us-ascii?Q?N2Zkcj6TLe0ohW++orTL1iivxRvMgZthFAIONseoQL/FX2ZMsBqVqDsQT2ZW?=
 =?us-ascii?Q?WsxOXnpXWllkntiLl5PghoRbPDwIEUMGACzcK2+K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7e4a5e-0173-4ee2-22fc-08dcf25ff720
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:08:36.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuC3jZH92avA1d2aq9JYFxtpvgdIFxvpHwQCphEeSQefidMdN5sXdojhpv5QOsYqEt781D49SmS7U+knPuhXug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

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
v4: no changes
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


