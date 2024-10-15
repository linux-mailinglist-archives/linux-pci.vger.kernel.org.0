Return-Path: <linux-pci+bounces-14544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF499EC3A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2BF1C23215
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7222911F;
	Tue, 15 Oct 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TPTpOjXE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA822910F;
	Tue, 15 Oct 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998059; cv=fail; b=JcKGkwgtp0recjmHaE9GVN3+eGQ1Q/VrYGkzd/rUGZJKkjr3/8QTu9qOzEfqobrnEr9esk7wTt8UOU/492F/quyp7dAv0mrceVEoJMxF4ggGKhyYMCRaZoRyYs3Z+Iq6egYguTTHLH+Z5d/wh5mVTnRK3Gpbc+DppWttx5Q7UZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998059; c=relaxed/simple;
	bh=uou1nui+PU10Yj9GprrdFQ8ElRvbPYAB8tO5gcsxj5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hCq66TRBmlUboQQzgAgOL/zmuQfkaZPh+DTtLTTH23Y1tbHMDWQ2gFeABXl/o/G4aG76HeZ3xgVVdB5wKUAsxifyqNBj4QYB/KjaFEa7U4s1HqIlFNxPSJeegm960Yy6yTX97fwCGC2gAvUB4eBHpr9Wqn96Tehne8tihFKcwlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TPTpOjXE; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmyVA9d0OcbDh32m/Sp6vhBckJLwpMjtYr04XNl5ghWm8wt+/GAV4x2XztWMWi8YQjpdt3/sGXMFneaGCFSHslrsEUYIwuWGdhdPyj9yijmcKuTgwh4xbLeNPBUc1sc8mZo88Dw+nXci9jS4A4w9z2qhVyckL6LH2ZJZFjbJJurvYJVx7pkh21RC/zB4dT9jG3UfuDuaofVBJNyidJfcnBobxuoTCGpru1Jd5Kj6Vc3sprYTJXzK1KJSO5LLXaYwOst8XKXf5pShJ+ds9G3qHLvYhS2sucNrpNY+DNiyW/Fp7VV8cV4TZdeuVlCkvEQOc02ztgAEFNhzRaCymuF+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUHeaK/qB1TBP4EDPjCJ+4CfLjC4+VET72XOwMXTzGM=;
 b=mSvYf7xnXzcSPdaxVaf3SpLyXa4OG12qwvczAa3cHSgsniJBtqDGYStA3nCMvFuQdXYsyqQFYJVt0DuJT+q/umiGP28tjL3zShqnSGkZUR4LmtxYlZ+/HH4GjBf1sz8hDpx+9w/Egn7U8xVl3AJ1SY9NJ5WkFWZw0pdNlbgkUUv0H9m/r68fcA1tztc9g23JPteeX3FaF/SBClmRD5J3ru1SiBLidchd2F6jNk3EbAhsGfeo1YfxvnsbkPJILdTyaD1DlvfY0bY8Biv6/V3G28mtCpRkg2JPdP4/vDsAUcnj+BeVy2xSRiLO480bGVUz9//4FpN0sGKTwQYjyEccYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUHeaK/qB1TBP4EDPjCJ+4CfLjC4+VET72XOwMXTzGM=;
 b=TPTpOjXExOO6bTBJbg74zB+OhO6l7rQbgiB2uKzM9RjI+/oBzwvdC/gNs2Nb5z0NgGdPPp7opbWKzWOdWE3EGdwZT+ayAIbNGLj9sJy7WSoVGDq9T+Ew0JxyhlDrVlTVblixG0yXVqeCzCOr4L+a0Td6q3GbjfRFPPa3hYmbYwiDseQFj+glMfcIj0k0SkAqf0IgN9cClIdkjIufNR8ig6SLUMte3+CJ+9QFZIAL0XPBoJaWrRTZMdyyt7tqF9nU6yN6gu2uthV+TsFYE0orfftdID03tXXde3+h8H7AR0P/MC0jJkVxuyyhWd2OyteUHUEhEVKvN0k5m72dyxnzDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB9876.eurprd04.prod.outlook.com (2603:10a6:20b:678::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 13:14:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:14:12 +0000
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
Subject: [PATCH v2 net-next 07/13] net: enetc: only enable ERR050089 workaround on LS1028A
Date: Tue, 15 Oct 2024 20:58:35 +0800
Message-Id: <20241015125841.1075560-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c259396c-df93-47f9-1775-08dced1b4318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?POU/ldv7aPtOTduGmnxaKQKT2hDZv/e/kmCs7UBmoU1Y7DSj1v0zWl3mBNaN?=
 =?us-ascii?Q?7YbTsptkbK1H8x0uJMTtPCcXPZEUzCkabR5iIy/Yz9a8pezLO71doc23bPHF?=
 =?us-ascii?Q?EPU3GiSff95/fQDlSBy8q7BKSXnhChVkNvVa4q7lkLAE06t8dm+XL6pqhc0J?=
 =?us-ascii?Q?OUMWq4YPhJ/bPDqWRthAkv0WBUk6TaQfIXxOGS8vbPdvz2L4+B+8MeB8FZzD?=
 =?us-ascii?Q?ZLFr5HhOXXXc1e3U3S19YZBx2BHY+JT8n4Q8iBgIZurBBIDbgfHhircr2x4w?=
 =?us-ascii?Q?/y3DfanrCHPFppuhmQNqGqM6csorFuiNOl7k0OMbGTCFyXwc8JuPkS4lKbDM?=
 =?us-ascii?Q?82WYNtbiWkFznrlMWpk5F7cBB3KVEMd7v6lJNR6V1HkrRH+qWDa0/uWsXR/6?=
 =?us-ascii?Q?0vUvhGz0+IhD+5g9RVVW6ONOmVrxK2sKqmQhayF98eScO7qnEqFhLAo+7f47?=
 =?us-ascii?Q?v1TnyKPxJstaALx6Mi8bvAnhJN3/8NtsuErfGEzjSgCqpSjbgihbyt9SM5L8?=
 =?us-ascii?Q?oeRQscPR1DNewKPtzjeDUNK0oPdmp5oPl0bQkQOT6itoUlyMuzTlJZ8LCiKq?=
 =?us-ascii?Q?quNjM9wHpLvUyqt8i9eDwLYXPxW7+1xat1A9qWYO8M6ubfyiTOSRPCidnyF4?=
 =?us-ascii?Q?MErQUa7eX17OE/jHvCUFTvISczrtZGjotcBLG8w5gRzuu0h+s0Tj19npIQu/?=
 =?us-ascii?Q?Q9/iK3lUFEzx7ASDtMatMzgcVXgzNGudbP7JXYixmkOEA+TRwMyI13G5Dbbn?=
 =?us-ascii?Q?CaVF4Hkpbv5I2Wc2ZpjAaB1Jpt0S9LKxBteYe7UgFdrWYADUmP5FMbnPF1N7?=
 =?us-ascii?Q?wglwMUmqm7YNz/TA+0d9Zpf+yq/Je4cMBNimd4amRQy0xT93vpTObaqVjYmL?=
 =?us-ascii?Q?qJpnkqTglvJ8D4YAbNsJHXTCAcHQvMSwWla/gyRLRE78QK2Dlesyf7aTK6zJ?=
 =?us-ascii?Q?k9tolYHJQPXOqXw69QzhAe+saafZZKkpTAwv57AwbvDP1q+knK8Pu/caeJag?=
 =?us-ascii?Q?wOrTvqMIghwcD8B4MSasqFAA9yyVOUMaWX51hBkIBpGH5xSWjM4Amu1WhhmY?=
 =?us-ascii?Q?W7nSqsYlNjOqT70jCfEgRiXFLYFllZLMK8qj2iMgTEMIJcthgVRLcnFCx+Hv?=
 =?us-ascii?Q?QFw9ti5yzMgGa+kB4vZgvGlBd+1sCYeihyOJNzhy6K9DbUeur+aPCl04UrlM?=
 =?us-ascii?Q?xvahlwnUPkIEAmpBoPcB+zyGx/d+Z0VeOM/DJ97GwYgy1NG3CfUJ0XiHc2IO?=
 =?us-ascii?Q?Qo30SC9ngA+6AmzkZWbjRVX6aunLzUdbmlXdgDrzfMX2fwPNXqPJXJ1xSlbf?=
 =?us-ascii?Q?eJw1SSDpy1yMbeclaxkrvD1wg1RAiAO/uC18NVtEHdQMCVdjn1Ven+V6ktIM?=
 =?us-ascii?Q?hHudWEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SkQbSukBrW67qcxx7f2B/G4VGcTOYf2CE7yVRA/7lzR6AUXIeZPLhZ58xQkX?=
 =?us-ascii?Q?4vAGBKjTLN3pzTx5sdXDGWI3CSraoPQPvUPzK4i07l3F+1NYGkC6BZ6K/PXs?=
 =?us-ascii?Q?50Xeh9j8x8bC40brE3okj5ynoBWua38BMqVN1B6dSMHCD8AfsoVBDBgkAUxN?=
 =?us-ascii?Q?UpQ8rjXK4HzN7OK0r/JaILv5ycLpSGe3HYXjmsRwfplD+BtzaTJ3Jb8IjQKU?=
 =?us-ascii?Q?MUxbGMWGbXeMmfMMPcEPzYk4cbN1yZDd8acsoNsPCZroQtXAclknO+qb5EZb?=
 =?us-ascii?Q?xx8fUhmkzUvtJaRyM+PwlBCC1QBDvQOFcwWdGophNhvWth+icMZyAaXxE04o?=
 =?us-ascii?Q?3Ts7hyjeeTnmm4cX5LLTGuT1uZN4ouYXpYJPh7sBv7OVjcw4Wj8VePimh4uy?=
 =?us-ascii?Q?j60q7GTG50HnnIc3Vedq0C2pLmhDr3b1lAfGnTWGkTFky7sueNOIfKHFg+Xq?=
 =?us-ascii?Q?luHce/56mzdLsPFT67t939JBzH7EbPN8SfU6cOG/a/OPvEnfYsYqIkl58kfF?=
 =?us-ascii?Q?uokRbgcKDYnqwNLtvyQuOCmLUraxMkpsBkLKPPEdwJNxXfqYV5EEnnItMweA?=
 =?us-ascii?Q?aj2ugNSpLmQgW7hHAbksk0y8eQy77E8J+7dccUZm3b/pMG/5Ac+TtebnV9js?=
 =?us-ascii?Q?nsC68yGLOmHoxkWHbc+c1Ta2kHTO+ebbB4tKtT4NTK3cI1zOM9MahWLj0Y+x?=
 =?us-ascii?Q?A9h13F8ekNSiKL3kAiqL8tpWvLi+0BAvZWPfwtebKHbIoS8j6+UYpTvPkadC?=
 =?us-ascii?Q?meLd1J9cYHnkKK2uLnoURpBomBIiZadQ6efXMkzdAmjTHHaw+xNm+v9NKkz6?=
 =?us-ascii?Q?O7htg5G/Jt/kuE/iD+3eXzI1kDxzDKAvahIRCOth8a8dBtPV0NAsWu7mSdcN?=
 =?us-ascii?Q?ouRpEZ3E1/ZWODoD8LWi+XlK+r2RNaPjF82fd8G705q07QeFiEzHsdFczc7y?=
 =?us-ascii?Q?ljXXQ/t6pNOTMwhFIsyN3SvIlNWNeKoBaHEOEa8NvRGe7DmWZVyobCRDn981?=
 =?us-ascii?Q?GR3xP3bPU/5FXYtYuXeTGjnQMSv1gcpAR5HR69SAkVR83gadlURdKzONhUMh?=
 =?us-ascii?Q?ZnKZOV557Dcw8gDNIZIQ2l8tBIDrkXWLieUabHOWBktuHXC4P+TeARRrkGjE?=
 =?us-ascii?Q?vGz21x/V9eZjeiJA7ByLkSy/GzURKLnpwgPfCneblZV8ncCvPE8LDw1iyrAX?=
 =?us-ascii?Q?hBVDX6SCq/B7POCuOIFIBs0yNUHBDAfTdbLsQVEdtSlb6C26fOzpYBG9Z/xk?=
 =?us-ascii?Q?11ZEkKjuIxw+6RQdy3kMIDsxpAnFSRhMgqbVHBcxP+Sscjw549A7Cm9849yV?=
 =?us-ascii?Q?Gduz2nsDRA78kE0awjIYn6EBdpO01A5joBTaNo12iISPEFO+kG+LatZcoq4X?=
 =?us-ascii?Q?z/pKN3rsk91fzMYm7+AexCxW0s7VdVUiM+gBYMAZRWQ4N6cuILAY63Z2qefE?=
 =?us-ascii?Q?Yj0oLJDFKde5T4RzkfVMsVwKE+iSuqy6LpSKoomj1u69dHex7U6YuyEBfdhU?=
 =?us-ascii?Q?B1MQPv3YI72eYO4JdPOopC4i3+4MblXRaLFcQS3Z64o/qtYZECTFEtLpyzgU?=
 =?us-ascii?Q?7thTNJAZzj7UkfmAT9w14qdoTlnT4X5ljUe6Ef+z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c259396c-df93-47f9-1775-08dced1b4318
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:14:12.7132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebkDMmd48Rg3Xk2QSKvBIIWUHleeEwk4twW5VX2gMaFXgfP8XcknCp1qWdrRZmX9cwfiknOSfAVtDhVgFVRJCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876

From: Vladimir Oltean <vladimir.oltean@nxp.com>

There are performance issues associated with the ERR050089 workaround,
as well as potential functional issues (RCU stalls) under certain
workloads. There is no reason why new SoCs like i.MX95 should even do
anything in enetc_lock_mdio() and enetc_unlock_mdio(), so just use a
static key so that they're compiled out at runtime.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes: no changes
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


