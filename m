Return-Path: <linux-pci+bounces-14073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89514996696
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8EBBB2172D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F99192B85;
	Wed,  9 Oct 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IPFJrVEd"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CC1925B3;
	Wed,  9 Oct 2024 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468433; cv=fail; b=uSMuQoKZCGm58Wfxq14pQBKFEIO+IsjD7xIewiWv4KtgVWzlZW9/qnhqYvrmWux88pOnLBiKFVWbcnZSZI3o4TcDOXnKyArpqMMv5TRGOnWz66Qu5846sOdtHEGDeit8lnvUeGCU1akl7oo1gpqQIPHSUMt0Wia4ieOW9eINjoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468433; c=relaxed/simple;
	bh=HgdiGxu0YyPBHtGQm/HNdj44RjqX8TRi3UJ8UwrI3LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NAIYUhm0z59/E2zvr3w/HHc6648RNdG1/QJAfYUXMBYArH8w/jQUobpNHggkfhZwKOQMpoExwIEuRV86h1QQB8YcywaSs3vjrGwyKOQKkJEJkJ2dvgAamJrzMWNZYIa/SpCoUrzC30wqbEeOOgkyPvjAMODeMtHZPX1q8HfjPVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IPFJrVEd; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itWMPJ3f5isIJ6muBYsv+x2PMK/KKoaqpendTIRNdXVNlrW6IakUOVLOrh8ljhjXIXa6AZRPDxxFVbg3It9HPsgmdeheP64iJc8wyOZ2eAkU88u4pBdOf6l9/4KTUr+h4ErNqeSmi0tbTmHOnzTWyHUbvx+0vHqqI0wACnvb1HJE9TVX3ZFGNbNfDWSGVVt8I26N0Du/XDZ/iaZNGJu9bK4bbsrXAM+Je8NwHkQH0Nc9g0waiYFYTNHSMumKtLw8tAOdFOaF7lIB4Wvp6uG3NRQVJfeWZNP2lVqQnXG++SKqUftTjsoxgbUoVG+cMzd/qHnEUnrP8DrueB8SVojuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lMC+55lOI7/5/l9WvM/rktTuysWxbj9m15WnWyNdUM=;
 b=Xj16GTv314hCnPUCulRsWtwxu7wi7Ew7S1E7LNOUwOvkT6PrcPKDjjWpFHuuHvAR2Lvw3YO7fC+gytLTqGN5RleXqL4UpTKYzHbrKS9kxupNoBsMZlBmu/Vj+7faSHxAgepHYpzXPBsPC+Mml3o7M9GbjHIBVw6X7ftjGddkwn8haqHw4WiY5TbB44HazHkDIQ/M+GhxCZvs+KdEpKai9FU2PClPc+nXPqmY9GiU/00sxK2vooxJHBCsqr5BhqRd+NuHWL6VWsUnCnkmo0ziU4kGmfVDBZen5Dmv+JCKKjW2ubPi+hjmGRcEDDxodO41c4vPHikuCqgC6b1q7gN7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lMC+55lOI7/5/l9WvM/rktTuysWxbj9m15WnWyNdUM=;
 b=IPFJrVEdxJpI7KpJMvtCfbf5RDoshvmQuHK8Ik1NbN7lIVI0vq4s4fLHaJaFKniAOR0wFJp/deToLWSic2p4MB2NjOa0S18xx4SqtQlKKNXqfDR0yanF3QT/xP5EBTDxlnMAF5JWeEGmCWG4Mc7WA4jFa9ZFkNUwObyo6vMSi8PHB7UnClXwUTbFPwe4lCBTQr6cUkGB0AcuLPamSzb2u84QKXwzBJ1I/6iDtXAjaTVwX650TgMV6YD3z8nKKl9gNox6Qe9CZWBteVoKiTu/liIeJl/ZzU2w8rDkXArAiZFzA7XVBFxnnTH8MeRF5rRbpG8NQfGfUM1Qrpba0L+stQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10154.eurprd04.prod.outlook.com (2603:10a6:150:1ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 10:07:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:07:07 +0000
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
	bhelgaas@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 09/11] net: enetc: optimize the allocation of tx_bdr
Date: Wed,  9 Oct 2024 17:51:14 +0800
Message-Id: <20241009095116.147412-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009095116.147412-1-wei.fang@nxp.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV1PR04MB10154:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdf895e-832a-45ff-53be-08dce84a218b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+B8Y+QJxMW1I7kJ7WUpac0ir6hPm4YAtRnlbUOZKfD1bkjKMTtnYJtc/+/26?=
 =?us-ascii?Q?vHTDpFGlwmLbKKvfQhYqRq70JYDDcm7rWvQexcqFP3B5KN1F/Uu8fAefP5Gp?=
 =?us-ascii?Q?SXuZIGQN3vqmoKU04VL0yTWFFKZz8PqJ61TyNrQFnMcObA2fdoZWVYDu0FIG?=
 =?us-ascii?Q?b9DNeGMeCdAxJuMkGecBOmg28/W9Fxg37v6Sz6AVVr1Y7FpTB9BBHIaQzzUd?=
 =?us-ascii?Q?IjUqeWV09nY84Qv9bW+h4JPkNw8k2k3fDySTgXKu5KnkabZOYI/W8pTSONvV?=
 =?us-ascii?Q?z1/lSPKAyTQElluft+OSMVZM8OfgetZnK+zt33B29FIUh6Qe2HL8ZqFVeFI5?=
 =?us-ascii?Q?Ij1kHOj0zfb216WsCBj30ltAN/A6h/YPJML35CztOYfSDnQNR9ws/wqGwm06?=
 =?us-ascii?Q?T9rp2JN6Ftrci3St7xXsFJu9JiPJ6gndSxzHb8QyJmTMz42fZ6UORInIYHJP?=
 =?us-ascii?Q?FSYrc7ybkI2p6X5vWYeI1QKUou6ZTUU0w7EY6de6datUyWX/6KSt1hDoG9jI?=
 =?us-ascii?Q?o9Smrz6BWf3bVNqe4kPtL8zj3T9fZGAGaInnfZ8jYyuaICKUHbNz+N0PJoSN?=
 =?us-ascii?Q?NIhUF5uNPbGLnxNAmpy3mGaSOaDE6EGnhnOpP8vbyRGEKPuxIUqYM4ew9Kxz?=
 =?us-ascii?Q?mxvSX4B8D9sSNbciy74oLaXl8X5htaH3wXDUdOsBXDS+DhMqMS6/og6uDuW4?=
 =?us-ascii?Q?fzIk5b7RZjLvcqOJHSWnUOw0X17VGx6NBh1ISjf2HUhwonTTAXZe9rYbILKD?=
 =?us-ascii?Q?3FuGfYCt45vANDOLDgC2aJ7rlO4EAjbL2IIfLkanlhrBHAgwI2A4WQ/fdxUh?=
 =?us-ascii?Q?pUSH7L6XVQmmastwhNEFi3C2rB4Doz8/QBlbRIjC7edAQUYXoSbSyW01qYjt?=
 =?us-ascii?Q?NkozovUS4KsTPKQ02VL2aZGWOBkK+KoDXTnKXwQyfKZI9/80lihk+hN0r7BO?=
 =?us-ascii?Q?9z52sdLdU26JEyYmnpRfJ9LKnIY39QPE5WTPIkhZoC9nXSHxHQ8s48mhAnEV?=
 =?us-ascii?Q?nqW8ab6fSJxYTJp9V5Wbw3TZxg7HB462em7TVpVPgBkOj8ZOmZCk1mZPSZNF?=
 =?us-ascii?Q?9uTdemaEroQzsFBisE46aYhnDqsQ4dlTgcooXUSwq5F5ha/SgShYDMM2uRdZ?=
 =?us-ascii?Q?YKgBneJfT+Kt8sjQks//XvwTWUTzFCckFEe2pm7IpuspiUgooGbqbQVSRxsF?=
 =?us-ascii?Q?8Z5MiDXYIeyC/A/b0f0zYt5P7MAEaKNXBFfrtjl5/95KrTDz26guh1Zw0aI7?=
 =?us-ascii?Q?NjvYJdkC2mNivCFLWazLIKAMM4DZ5ojEp3zJ5IpkFrDDfOIeug3J1aQuWTx1?=
 =?us-ascii?Q?HhKkd4BL8vHz0g3/pdYgWe3uAk7SVsoDTfW67MJQFJQK5/zfyNS0SkEVi0pf?=
 =?us-ascii?Q?04F1yaE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E55gQ+aEe7LdK/JGckQpoH8Kg7palifI0F6MVVYq3t6z+O5wSZn/JY3ik53x?=
 =?us-ascii?Q?JxdMl/neAFsiWqh26zcQw3ErkYN7jV3wAzPv3cbOrRKjYR7vYsJOM5luRDVj?=
 =?us-ascii?Q?rbhoYubu/Syh9tyZBsgKQ2AlkoxliHMUre2W9KjRjMRbJEcEFzDWZ90su5GU?=
 =?us-ascii?Q?AwClO3zOOlBqXZMovLXQWqptzh4EmgFyAclHSZjU31BY/1h9/GTkLyeRkSpf?=
 =?us-ascii?Q?5+fI3MJ5S7gXPKw5b4Q0tGqjTJ8LOElAw/v09BSOvQuCl0qBCSPWvq21YcW+?=
 =?us-ascii?Q?7vKK/PlvZBBm9sUEX3SzjSAAKnr5a+S5RrK+U5vQ2VfP8zOp5tRjPftAC5oi?=
 =?us-ascii?Q?g6LDWcfN21Xi2mgvMNJeYFTN5YWzUydFPB4vv08Yg7ZidJZPSH2dmktv+W9h?=
 =?us-ascii?Q?Rf/MfyTM/fzPrT/genpLjYx+RlZUKXK4j11hbTOfIjXL5661Mbm0G343vjBr?=
 =?us-ascii?Q?qCvk5pyq7dgGEbZ022KZhfomlnW332MKCrg02THUoICsBJMN5w4qeQTYtQ2N?=
 =?us-ascii?Q?6rKaEsl4oPpWTHqqUM1m/j9GV5zlPQXpJS3ZL1bPcVG74T1odKDI2PRwmhyL?=
 =?us-ascii?Q?y9nj2AYuOmB1yxQsUu0FKfGYTAYxtXwL2UHBCTFbG843ONika3Scg5Ajbc0m?=
 =?us-ascii?Q?lSPaSEbc1bxhlQ+C6HLMILO1Ciih5fwGeRy/YioMcgI5e2iRslt4dKdcdEdf?=
 =?us-ascii?Q?OMLbkCFBcqN0vSe3aE+j8xb1ywnGjSubZypdWR78+Yixe/bNPyjqOU+K0iiG?=
 =?us-ascii?Q?//Y3OxNg8Ap66Wfu+P3ba4p9+1qXxYIfNN/2jbrSsGTW0SqP8c7Oecz+soeV?=
 =?us-ascii?Q?mzTsagBBlqZAjN7IBXXWFAvzUl4DbbQH4klZqkqnZpt78tnSBryZP3ds/6jI?=
 =?us-ascii?Q?Mzk17vD+z7JUFRV2vPNMLF57nCjLhdg7yRcFtAyCXZRAzEsZhxDDfWz/bUz2?=
 =?us-ascii?Q?UcHkQeUH8jf2BJtDGP8HuTDPP8e8DLxmk/BS8XArN99fFT3Ppf9huAe1QJo4?=
 =?us-ascii?Q?7JlZASV2gK7VFVD9krEzUIRtgelDVSj7dIBgoLwtwCfyQMgNumsZVqm1fe/5?=
 =?us-ascii?Q?GO2jRed6SZ3TmvYevWhnF3InCS4mKvgDMfy9qNHBjNSsa+0rmlg8r+Ilt66C?=
 =?us-ascii?Q?VdU1PTmcxtiG/FqTrtAr1ZXkaP5T/CJsWA8PYXtuGsFYxxtDMqXd/E3ODcZk?=
 =?us-ascii?Q?crbLiUkyV0KP5gsuN9ekjD0HG16gUt9M0JU+roEkDsmds0SNsW0rvKZjh2Uz?=
 =?us-ascii?Q?0bqnjycXOedPILS+O5ivcwqEna9cZ89yShEST1PYcv+UkNA/73Pwc/7Cv5e/?=
 =?us-ascii?Q?Jgm6GTFNVV2wFpJBfAaIUdqmCu8JMTVQfg64p2jhHRc65rcwnjrPBFwC+/r9?=
 =?us-ascii?Q?DSlk3KUCGyzx6GoUU3e1ef5uSwm8TwzCSA1glvqB2TMuxIxO5nKRlNn78Bm3?=
 =?us-ascii?Q?9TJ3TRsoeIlmiRyVlESB656KxtTmFpq3eIkMtzr8NOPEXngszrrbqPShCM0t?=
 =?us-ascii?Q?LardYATNUA7XY+ZotkltY7GfK9Wdj9a8iY0lGbb/BiK0S1gxe+m9AqThKSUJ?=
 =?us-ascii?Q?ri4WhzS9V00jX5wAkIg7n+SA9mIrzY3P1uyefW03?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdf895e-832a-45ff-53be-08dce84a218b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:07:06.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM9jar9RHu381CyZO0q5+uweXZejFSSkJHNnW+VYxrKXzAobpez/QkgMLV7FxOk3n9LDjJQV5ErCnocuiQqPmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10154

From: Clark Wang <xiaoning.wang@nxp.com>

There is a situation where num_tx_rings cannot be divided by
bdr_int_num. For example, num_tx_rings is 8 and bdr_int_num
is 3. According to the previous logic, this results in two
tx_bdr corresponding memories not being allocated, so when
sending packets to tx BD ring 6 or 7, wild pointers will be
accessed. Of course, this issue does not exist for LS1028A,
because its num_tx_rings is 8, and bdr_int_num is either 1
or 2. So there is no situation where it cannot be divided.
However, there is a risk for the upcoming i.MX95, so the
allocation of tx_bdr is optimized to ensure that each tx_bdr
can be allocated to the corresponding memory.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 121 ++++++++++---------
 1 file changed, 62 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 032d8eadd003..b84c88a76762 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2965,13 +2965,70 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 }
 EXPORT_SYMBOL_GPL(enetc_ioctl);
 
+static int enetc_bdr_init(struct enetc_ndev_priv *priv, int i, int v_tx_rings)
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
@@ -2985,65 +3042,11 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 
 	/* # of tx rings per int vector */
 	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
+	v_remainder = priv->num_tx_rings % priv->bdr_int_num;
 
-	for (i = 0; i < priv->bdr_int_num; i++) {
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
-			goto fail;
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
-	}
+	for (i = 0; i < priv->bdr_int_num; i++)
+		enetc_bdr_init(priv, i,
+			       i < v_remainder ? v_tx_rings + 1 : v_tx_rings);
 
 	num_stack_tx_queues = enetc_num_stack_tx_queues(priv);
 
-- 
2.34.1


