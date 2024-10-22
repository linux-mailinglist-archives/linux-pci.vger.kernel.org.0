Return-Path: <linux-pci+bounces-14977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B69A994B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3591F22790
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1D14D6E1;
	Tue, 22 Oct 2024 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CUttu4+X"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676C14B97E;
	Tue, 22 Oct 2024 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577284; cv=fail; b=SkZp5ogDeG3yeQvSDVVp8UqYHjkGfpM5vRzmoqrahNUYwJRyfxbERJ0UxlOL5AK4W/+3/GOYxsKJVvHfEnEzVwXRzJqUK5nao6VAEHTa1HzPO+naNGIvacuoDBkqb3arPhhODQbzVBmAtUmUFAJK+/6BItCq0OyFGw1QQBDRVl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577284; c=relaxed/simple;
	bh=uYsjQa/qmy7IDvF2d1b3fbMPz4427kXaDv/f3ASQf4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXdhSZApRaKjX/uulDMIOd7PHxJLfY4Z3YpI64hCHypNBA4kv/AZABsFsYlj00fguloRW2NN8q/DtG+0ZrzfOgrMf+6iIAEn0g6L38zhBeafqh19jiFtyH+nrR8iQ4OUo9777ym1xNmIZApzvbGuVMmB39FZETjp7bpGB/GLcgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CUttu4+X; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQBJjDENGrFclqqZ3aJsPLjevy82K8DZtvYwCxgnXkxSiNbzDqoc74g9LjO2WVQHFhlBnJHNZ3IK0/lG3IF1M2mWKkmuwdRsfRI3cx3Ij6v4mJADJ6ytaBS29JOI2SM/9ybdU2GOoMe1QuR2wn3DfSVUtHHpE10eSJZxRG7saaWa6fK2gRqjaq8GBHAIcpp85hOaq8GHqCFM3uWaH98xMaxhKRocQZTQXDUttKA7PLHrSI70OPb5zTt7euMGtfZGhVsT4FKnutlO9A+BFbn9U7ccOe3iLP1nvAdmISbsorBVDa4/cOSjG6Fnh5w8ngmkJfcuQ0BQTf+I7EdHqMeEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBtajx33MVZPH8cRiMapimFej7jojqkw8puUQEkQDRM=;
 b=sgMNe16If8yA+HFx5+DRj7FAyxYp8dcIuzJ6AoqkUWhA/LolR6zuQE7CqQvD6tscfa1yZTWcPzoXEZXraC38GwEyXZKAXTh8JCv/Blm1MDa7DpjKdEvEcI7oVlymnJ4qiZhcafEyPzpVd1g2qGevjg2n+a7SVZGj81dryyLI+u9TAjJoeelDoCt5CQJXYUkLZU8TCGk1UDvmGxct3raT1n0xYrqO6sSDYesBlm8x/9BLAiNmwao7Te956OhPQ6eQux8AKHtm8yp+Cwh75Gpxfls/fhOZQnBC2v8ZbpZ+OHb8SqInDyJSDHFGXGbUsQNOwhaX6JVvIaZjd3rloyVcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBtajx33MVZPH8cRiMapimFej7jojqkw8puUQEkQDRM=;
 b=CUttu4+XQz7iF8WHJjbfEx0boW9KTxYCGbEfnQikrWrgjlswAsQWvK04B4ugsjhDzgdJyaNfyTzw3dHZE2KGFYEMSLY63g5nLpd6giVoduoGOJMoqt379mc5UB7Py+WPqyr+Mxu/SevjrJxn5G2CAdxiFTmCf2LN4WY1lt7UWCJ/p+3RXhOQs+qvMyfoSrRmEJvJQzVfxEIeZtsoROG65UsGzIqGCLSJTYTd3MarhUCXbX5Gc/R8GHHEyeekkfrTjoWwlPXDhmcq57v4NlVdgvSNCJwV5J90RRhVTi6kqDlHAz5RQBHUWUc7wb9vohDdwGksoAg1R6T3Arwl58TSbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:07:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:07:57 +0000
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
Subject: [PATCH v4 net-next 05/13] net: enetc: extract common ENETC PF parts for LS1028A and i.MX95 platforms
Date: Tue, 22 Oct 2024 13:52:15 +0800
Message-Id: <20241022055223.382277-6-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3ddd2098-54fb-422f-79c5-08dcf25fdfd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ijl9KmnGI6VPYEPgirQ8OCEGyFaPGSPhxIw1WNrskr1cGaSyYHAxWTpawgb?=
 =?us-ascii?Q?9t+fr/eew8/R3nSkHzDk7ARra3pWWWt7cJ7UOa0hIOFt1xdLdjkir1wVQZ8h?=
 =?us-ascii?Q?PuAaKy2sUQOo87fG8U5oytzIMT5+6485XV8V1ADO/j6ElvsLNBENblkwdI+x?=
 =?us-ascii?Q?79eNgJf9FUtGuAn5fR6EUQ1iK6PVB6XYkTNUfDduqLR5AKmNXZY6l2qK0wea?=
 =?us-ascii?Q?v6BSeE75hEZPDUEL2xfZ6qkhdkFoh4nq+cC1LW3dgyuQR2Ofn7j1/LhouJnA?=
 =?us-ascii?Q?x1PyNgKobhJ6j3lyewroTstrpXk52K+bA2CjTsRJsxrZi4b73+hSBFpQZho8?=
 =?us-ascii?Q?ax5t74hli5tQuhr4NH7/NfQJSwb7FHZRtQc57r4MQYyBZkxaf1UMPFd2I8up?=
 =?us-ascii?Q?JZM8J3+MAX/v8OKKY6nQZW1tpNy7j7zxORYHRN7Oe0xMDRhhSjY9jvS6Gxz4?=
 =?us-ascii?Q?fD3VnBpROQwS4HXBrCjr0obapAsUY94zZ6g1wo6vGoMdYx9Jkc3uwg9TlNwP?=
 =?us-ascii?Q?YARYJO1aACcODtAP8okYAJqsnjnNnbB4Kp8Ct4dhxWitKdPEfp4KO966bsPY?=
 =?us-ascii?Q?CdGmV8P+6VPKhxwjPO4/N55LthYNSk0+1VXSEoZHt/XbvKxJmsX1N8d68+/y?=
 =?us-ascii?Q?y7SGrv9DDLDCLbTCO6x/LgwYX84DUq6Z6BYTVrJi/PyLyBX6NOuxvOrMV0Ty?=
 =?us-ascii?Q?fIOHRJ5wCJmapC1CfsODDvk2994dVjksxVi57tKt9ELe9hk6TlBIeiUXziUe?=
 =?us-ascii?Q?JbMskikkz2QJoN48ZANL0bYi0lDbcVI6MxCavn2MHGTXkZUf/EQG6mXk8jGN?=
 =?us-ascii?Q?BGBlPB0OrHGvKaFnH+i3SuwScGincgMwyC9RqmZYdScpZwjAXN6nbzCRn5Iz?=
 =?us-ascii?Q?rQQxZWXFcs5H6i7rFAVdMzc187DTwj9560DooajKHep7tx12vonxle36zo2a?=
 =?us-ascii?Q?YCtTGykn1jSeVt3QsJUo3NhCsQ3vB9rb5GxiMcNKky1MPk4mPvSNvY/3iS5e?=
 =?us-ascii?Q?u+xufibIPkhGm8TmA7xBRNPT6T005vpOyB42tG94y24NdemBYVoKIpjmHZMd?=
 =?us-ascii?Q?NX5D2mMjdYmE1IAr7T8iWDQ9ijPrHQQUaUmXqY8rzqvwUWDmc7hE0SWbIXJm?=
 =?us-ascii?Q?3nJMN2lYSihxLU0vGgoHOLQZ206nljCFFT2ofTibp62Z8Pr8oYQK1SY9nlDG?=
 =?us-ascii?Q?75Gx2XRDD+/LpFjeDgsg1C9aGVkrI0ROX1djH7SCKapYliZFfRO3POqA7pLe?=
 =?us-ascii?Q?JxHDU4jta2eA/hfZ1pCbHEZDuiKRDUmvZ7h7tjEjU5aA6bF36ET9+IJxiaNW?=
 =?us-ascii?Q?YYuf7L1Rwr5X7mWghIml9vVrjOOhwwiLs3mKT5iYk/keJzFpWIawzU1YhsHE?=
 =?us-ascii?Q?t2qRpoX1yd88ezQ24KvJ5OqOBAZQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0K1A9ECcVuR1cdGnoFOMOP8C21qfBgWqs8SyWj/rSunPaWQIZdCFDMZcai8?=
 =?us-ascii?Q?I3qIgGJ7qhUVQHIrtsqMLXvCFylOWAaao+7vAcLRCg6cTU7gHGh6iZZoG+J/?=
 =?us-ascii?Q?De9qakPzZPIlJS1m4z8nE1yWWUH1YeGNVzzbpIISWJ/DnhlanRS9mb0/+IqQ?=
 =?us-ascii?Q?aSyn9fEmWwqKTCOWjioDxOWNUWbyDQksS/YneBOqBQWe3zl4t3KiIXHNGcYh?=
 =?us-ascii?Q?GAQk334QzQq88XoHIwCPEWpx4O7OtiO3ElR142EDSBea8j6nO05VYKDx/uyx?=
 =?us-ascii?Q?1w2EuU/lwyygO+NU9zT18sdbGeNTO/xQcs1DqD7cuPENz8eJ/M7sYZ4tchsu?=
 =?us-ascii?Q?AmYBQt8/9jRit81oQgSNTrS0PnjqEiFmUwUw4bshvU/8bZN5JNL8/smKtsuV?=
 =?us-ascii?Q?KZtnmP+5i78Jsb/ldoHt30cf7SOQQf2pQPe71MiLX7dB/uLd+mE7827orE4v?=
 =?us-ascii?Q?JHvZSlG53jdDat9P645TeG90tYyaN0sb74K0uNKzQyKWD1mrcpYafpgs/sqJ?=
 =?us-ascii?Q?IMCD31KsGnKbVHaVQ5/4C/sfsX6FKWQBUPJjuS3FtEg4G5LyXg6ut2MmU25D?=
 =?us-ascii?Q?3GxEn0le9lKEl1+OywdviT+YvN2A3J0SB3bPT4uvKoN4L5wUnz+GM+jlnOMD?=
 =?us-ascii?Q?ZkH5cFV6DLubX4SrzYe9EPoPYODdzITGB2k6qHjV9IHZ768BRIObQNK0tV/c?=
 =?us-ascii?Q?kth4MoKfbX9PVyF3SI84EV4sFdAr31rdYogExORzxuKLWwpoqUIvJIZjlCB6?=
 =?us-ascii?Q?ftd2JR3q5bo2Sf7R2+gksT1mJOvxkMmd04spQlE2UVvrtAQNaBmxumPBOi5d?=
 =?us-ascii?Q?PRnldieBHQSsQJatJJbShh5lahKbGqaq9auM2HCiINw7nwvXxuIMMefsN+Yf?=
 =?us-ascii?Q?GNM9Yjo0z0gNrRgwXZ2j+jykI7aG9QM0s+Ln3TRYn6PVGA9CiPjpgAJ2zhyu?=
 =?us-ascii?Q?TsOpVskUrEbSjoPl1AGZidzhM922C3bdbONVYB3bUzsG31TZIywgqZhLhhXD?=
 =?us-ascii?Q?drzQmrwtqcZcnO8LDaIiLd0YYaccsw3GtkZZGoJK0amfy0uUTuoaQgQEWwvb?=
 =?us-ascii?Q?n83oTQTSBg2tB9GJeH7dqKxg9Dh9b2P903XkB+SqAdds7w40bRBEeYSWsQDf?=
 =?us-ascii?Q?BK5Cav9TEWZCMxjd5bpaa4zceQASRZ8U+6p0cWOnIJk3FeRgEddE0o+thrma?=
 =?us-ascii?Q?4UNpoyO61s5t1i51w8/0rYwdzxR8PN69NwVUmOgr6HZwm7FHwVRZ5Y8GrvAS?=
 =?us-ascii?Q?rojhw3cGxc81YkrKnjSvj83OZs+wTlj3LROVXqGGsQqkPz9B/+/3BRJnrSD/?=
 =?us-ascii?Q?GFUD93pPJG/B6+90f4/L7XxHSz7mWnnpyEAbmy2QsZoKKpXZzz/Bwym39Pa4?=
 =?us-ascii?Q?BjcAbKjZh7RYy52J3Q2Oc9JBO1y1pVYVTzgsrgOvWksysOGiGl7f/i92L+zW?=
 =?us-ascii?Q?aMgN/u2HQzk2ARW2AfdPY+ZzIaYhtxTNiJcyJKJXym6m/m76KVlhZHU5JVZ4?=
 =?us-ascii?Q?T9MIxnSKmR5O18chbhMVitLQRzfUY20CoSKVsHK4IVnY75Jk1maTKBR/JA2P?=
 =?us-ascii?Q?98391CR+WqWxFzH6c5R2EWVF7d9meq0GlDecuNyN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddd2098-54fb-422f-79c5-08dcf25fdfd4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:07:57.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EESOmakpTkxG9bgn4DKnb5f0FaR/f7oUMjmXOk9oOnjkYnf/O98oeRMS50o6xP5HaOWCAMpQlVlRzaXObEnc0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

The ENETC PF driver of LS1028A (rev 1.0) is incompatible with the version
used on the i.MX95 platform (rev 4.1), except for the station interface
(SI) part. To reduce code redundancy and prepare for a new driver for rev
4.1 and later, extract shared interfaces from enetc_pf.c and move them to
enetc_pf_common.c. This refactoring lays the groundwork for compiling
enetc_pf_common.c into a shared driver for both platforms' PF drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
driver support"), it just moved some common functions from enetc_pf.c to
enetc_pf_common.c.
v3 changes:
Change the title and refactor the commit message.
v4: no changes.
---
 drivers/net/ethernet/freescale/enetc/Makefile |   2 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 297 +-----------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  13 +
 .../freescale/enetc/enetc_pf_common.c         | 295 +++++++++++++++++
 4 files changed, 313 insertions(+), 294 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 737c32f83ea5..8f4d8e9c37a0 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
 fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
-fsl-enetc-y := enetc_pf.o
+fsl-enetc-y := enetc_pf.o enetc_pf_common.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 8f6b0bf48139..3cdd149056f9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -2,11 +2,8 @@
 /* Copyright 2017-2019 NXP */
 
 #include <linux/unaligned.h>
-#include <linux/mdio.h>
 #include <linux/module.h>
-#include <linux/fsl/enetc_mdio.h>
 #include <linux/of_platform.h>
-#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/pcs-lynx.h>
 #include "enetc_ierb.h"
@@ -14,7 +11,7 @@
 
 #define ENETC_DRV_NAME_STR "ENETC PF driver"
 
-static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
+void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 {
 	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
 	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
@@ -23,8 +20,8 @@ static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-					  const u8 *addr)
+void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+				   const u8 *addr)
 {
 	u32 upper = get_unaligned_le32(addr);
 	u16 lower = get_unaligned_le16(addr + 4);
@@ -33,20 +30,6 @@ static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
 	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
 }
 
-static int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct sockaddr *saddr = addr;
-
-	if (!is_valid_ether_addr(saddr->sa_data))
-		return -EADDRNOTAVAIL;
-
-	eth_hw_addr_set(ndev, saddr->sa_data);
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
-
-	return 0;
-}
-
 static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
 {
 	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
@@ -393,56 +376,6 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
 	return 0;
 }
 
-static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
-				   int si)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_hw *hw = &pf->si->hw;
-	u8 mac_addr[ETH_ALEN] = { 0 };
-	int err;
-
-	/* (1) try to get the MAC address from the device tree */
-	if (np) {
-		err = of_get_mac_address(np, mac_addr);
-		if (err == -EPROBE_DEFER)
-			return err;
-	}
-
-	/* (2) bootloader supplied MAC address */
-	if (is_zero_ether_addr(mac_addr))
-		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
-
-	/* (3) choose a random one */
-	if (is_zero_ether_addr(mac_addr)) {
-		eth_random_addr(mac_addr);
-		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
-			 si, mac_addr);
-	}
-
-	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
-
-	return 0;
-}
-
-static int enetc_setup_mac_addresses(struct device_node *np,
-				     struct enetc_pf *pf)
-{
-	int err, i;
-
-	/* The PF might take its MAC from the device tree */
-	err = enetc_setup_mac_address(np, pf, 0);
-	if (err)
-		return err;
-
-	for (i = 0; i < pf->total_vfs; i++) {
-		err = enetc_setup_mac_address(NULL, pf, i + 1);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 static void enetc_port_assign_rfs_entries(struct enetc_si *si)
 {
 	struct enetc_pf *pf = enetc_si_priv(si);
@@ -775,187 +708,6 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_xdp_xmit		= enetc_xdp_xmit,
 };
 
-static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
-				  const struct net_device_ops *ndev_ops)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-
-	SET_NETDEV_DEV(ndev, &si->pdev->dev);
-	priv->ndev = ndev;
-	priv->si = si;
-	priv->dev = &si->pdev->dev;
-	si->ndev = ndev;
-
-	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
-	ndev->netdev_ops = ndev_ops;
-	enetc_set_ethtool_ops(ndev);
-	ndev->watchdog_timeo = 5 * HZ;
-	ndev->max_mtu = ENETC_MAX_MTU;
-
-	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
-			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
-	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
-			 NETIF_F_HW_VLAN_CTAG_TX |
-			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
-	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
-			      NETIF_F_TSO | NETIF_F_TSO6;
-
-	if (si->num_rss)
-		ndev->hw_features |= NETIF_F_RXHASH;
-
-	ndev->priv_flags |= IFF_UNICAST_FLT;
-	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-			     NETDEV_XDP_ACT_NDO_XMIT_SG;
-
-	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
-		priv->active_offloads |= ENETC_F_QCI;
-		ndev->features |= NETIF_F_HW_TC;
-		ndev->hw_features |= NETIF_F_HW_TC;
-	}
-
-	/* pick up primary MAC address from SI */
-	enetc_load_primary_mac_addr(&si->hw, ndev);
-}
-
-static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_mdio_priv *mdio_priv;
-	struct mii_bus *bus;
-	int err;
-
-	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "Freescale ENETC MDIO Bus";
-	bus->read = enetc_mdio_read_c22;
-	bus->write = enetc_mdio_write_c22;
-	bus->read_c45 = enetc_mdio_read_c45;
-	bus->write_c45 = enetc_mdio_write_c45;
-	bus->parent = dev;
-	mdio_priv = bus->priv;
-	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
-
-	err = of_mdiobus_register(bus, np);
-	if (err)
-		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
-
-	pf->mdio = bus;
-
-	return 0;
-}
-
-static void enetc_mdio_remove(struct enetc_pf *pf)
-{
-	if (pf->mdio)
-		mdiobus_unregister(pf->mdio);
-}
-
-static int enetc_imdio_create(struct enetc_pf *pf)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_mdio_priv *mdio_priv;
-	struct phylink_pcs *phylink_pcs;
-	struct mii_bus *bus;
-	int err;
-
-	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "Freescale ENETC internal MDIO Bus";
-	bus->read = enetc_mdio_read_c22;
-	bus->write = enetc_mdio_write_c22;
-	bus->read_c45 = enetc_mdio_read_c45;
-	bus->write_c45 = enetc_mdio_write_c45;
-	bus->parent = dev;
-	bus->phy_mask = ~0;
-	mdio_priv = bus->priv;
-	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
-
-	err = mdiobus_register(bus);
-	if (err) {
-		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
-		goto free_mdio_bus;
-	}
-
-	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
-	if (IS_ERR(phylink_pcs)) {
-		err = PTR_ERR(phylink_pcs);
-		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
-		goto unregister_mdiobus;
-	}
-
-	pf->imdio = bus;
-	pf->pcs = phylink_pcs;
-
-	return 0;
-
-unregister_mdiobus:
-	mdiobus_unregister(bus);
-free_mdio_bus:
-	mdiobus_free(bus);
-	return err;
-}
-
-static void enetc_imdio_remove(struct enetc_pf *pf)
-{
-	if (pf->pcs)
-		lynx_pcs_destroy(pf->pcs);
-	if (pf->imdio) {
-		mdiobus_unregister(pf->imdio);
-		mdiobus_free(pf->imdio);
-	}
-}
-
-static bool enetc_port_has_pcs(struct enetc_pf *pf)
-{
-	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
-		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
-}
-
-static int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
-{
-	struct device_node *mdio_np;
-	int err;
-
-	mdio_np = of_get_child_by_name(node, "mdio");
-	if (mdio_np) {
-		err = enetc_mdio_probe(pf, mdio_np);
-
-		of_node_put(mdio_np);
-		if (err)
-			return err;
-	}
-
-	if (enetc_port_has_pcs(pf)) {
-		err = enetc_imdio_create(pf);
-		if (err) {
-			enetc_mdio_remove(pf);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-static void enetc_mdiobus_destroy(struct enetc_pf *pf)
-{
-	enetc_mdio_remove(pf);
-	enetc_imdio_remove(pf);
-}
-
 static struct phylink_pcs *
 enetc_pl_mac_select_pcs(struct phylink_config *config, phy_interface_t iface)
 {
@@ -1101,47 +853,6 @@ static const struct phylink_mac_ops enetc_mac_phylink_ops = {
 	.mac_link_down = enetc_pl_mac_link_down,
 };
 
-static int enetc_phylink_create(struct enetc_ndev_priv *priv,
-				struct device_node *node)
-{
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct phylink *phylink;
-	int err;
-
-	pf->phylink_config.dev = &priv->ndev->dev;
-	pf->phylink_config.type = PHYLINK_NETDEV;
-	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
-
-	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-		  pf->phylink_config.supported_interfaces);
-	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
-
-	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
-				 pf->if_mode, &enetc_mac_phylink_ops);
-	if (IS_ERR(phylink)) {
-		err = PTR_ERR(phylink);
-		return err;
-	}
-
-	priv->phylink = phylink;
-
-	return 0;
-}
-
-static void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
-{
-	phylink_destroy(priv->phylink);
-}
-
 /* Initialize the entire shared memory for the flow steering entries
  * of this port (PF + VFs)
  */
@@ -1338,7 +1049,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_mdiobus_create;
 
-	err = enetc_phylink_create(priv, node);
+	err = enetc_phylink_create(priv, node, &enetc_mac_phylink_ops);
 	if (err)
 		goto err_phylink_create;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index c26bd66e4597..92a26b09cf57 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -58,3 +58,16 @@ struct enetc_pf {
 int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
+
+void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
+void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+				   const u8 *addr);
+int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
+int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
+void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
+			   const struct net_device_ops *ndev_ops);
+int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node);
+void enetc_mdiobus_destroy(struct enetc_pf *pf);
+int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
+			 const struct phylink_mac_ops *ops);
+void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
new file mode 100644
index 000000000000..bce81a4f6f88
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2024 NXP */
+
+#include <linux/fsl/enetc_mdio.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/pcs-lynx.h>
+
+#include "enetc_pf.h"
+
+int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct sockaddr *saddr = addr;
+
+	if (!is_valid_ether_addr(saddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	eth_hw_addr_set(ndev, saddr->sa_data);
+	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
+
+	return 0;
+}
+
+static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
+				   int si)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_hw *hw = &pf->si->hw;
+	u8 mac_addr[ETH_ALEN] = { 0 };
+	int err;
+
+	/* (1) try to get the MAC address from the device tree */
+	if (np) {
+		err = of_get_mac_address(np, mac_addr);
+		if (err == -EPROBE_DEFER)
+			return err;
+	}
+
+	/* (2) bootloader supplied MAC address */
+	if (is_zero_ether_addr(mac_addr))
+		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
+
+	/* (3) choose a random one */
+	if (is_zero_ether_addr(mac_addr)) {
+		eth_random_addr(mac_addr);
+		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
+			 si, mac_addr);
+	}
+
+	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
+
+	return 0;
+}
+
+int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
+{
+	int err, i;
+
+	/* The PF might take its MAC from the device tree */
+	err = enetc_setup_mac_address(np, pf, 0);
+	if (err)
+		return err;
+
+	for (i = 0; i < pf->total_vfs; i++) {
+		err = enetc_setup_mac_address(NULL, pf, i + 1);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
+			   const struct net_device_ops *ndev_ops)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	SET_NETDEV_DEV(ndev, &si->pdev->dev);
+	priv->ndev = ndev;
+	priv->si = si;
+	priv->dev = &si->pdev->dev;
+	si->ndev = ndev;
+
+	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
+	ndev->netdev_ops = ndev_ops;
+	enetc_set_ethtool_ops(ndev);
+	ndev->watchdog_timeo = 5 * HZ;
+	ndev->max_mtu = ENETC_MAX_MTU;
+
+	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
+			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
+			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
+			 NETIF_F_HW_VLAN_CTAG_TX |
+			 NETIF_F_HW_VLAN_CTAG_RX |
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
+			      NETIF_F_TSO | NETIF_F_TSO6;
+
+	if (si->num_rss)
+		ndev->hw_features |= NETIF_F_RXHASH;
+
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
+			     NETDEV_XDP_ACT_NDO_XMIT_SG;
+
+	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
+		priv->active_offloads |= ENETC_F_QCI;
+		ndev->features |= NETIF_F_HW_TC;
+		ndev->hw_features |= NETIF_F_HW_TC;
+	}
+
+	/* pick up primary MAC address from SI */
+	enetc_load_primary_mac_addr(&si->hw, ndev);
+}
+
+static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct mii_bus *bus;
+	int err;
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Freescale ENETC MDIO Bus";
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
+	bus->parent = dev;
+	mdio_priv = bus->priv;
+	mdio_priv->hw = &pf->si->hw;
+	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+
+	err = of_mdiobus_register(bus, np);
+	if (err)
+		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
+
+	pf->mdio = bus;
+
+	return 0;
+}
+
+static void enetc_mdio_remove(struct enetc_pf *pf)
+{
+	if (pf->mdio)
+		mdiobus_unregister(pf->mdio);
+}
+
+static int enetc_imdio_create(struct enetc_pf *pf)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct phylink_pcs *phylink_pcs;
+	struct mii_bus *bus;
+	int err;
+
+	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Freescale ENETC internal MDIO Bus";
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
+	bus->parent = dev;
+	bus->phy_mask = ~0;
+	mdio_priv = bus->priv;
+	mdio_priv->hw = &pf->si->hw;
+	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
+
+	err = mdiobus_register(bus);
+	if (err) {
+		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
+		goto free_mdio_bus;
+	}
+
+	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
+	if (IS_ERR(phylink_pcs)) {
+		err = PTR_ERR(phylink_pcs);
+		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
+		goto unregister_mdiobus;
+	}
+
+	pf->imdio = bus;
+	pf->pcs = phylink_pcs;
+
+	return 0;
+
+unregister_mdiobus:
+	mdiobus_unregister(bus);
+free_mdio_bus:
+	mdiobus_free(bus);
+	return err;
+}
+
+static void enetc_imdio_remove(struct enetc_pf *pf)
+{
+	if (pf->pcs)
+		lynx_pcs_destroy(pf->pcs);
+
+	if (pf->imdio) {
+		mdiobus_unregister(pf->imdio);
+		mdiobus_free(pf->imdio);
+	}
+}
+
+static bool enetc_port_has_pcs(struct enetc_pf *pf)
+{
+	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
+		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
+		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
+		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
+}
+
+int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
+{
+	struct device_node *mdio_np;
+	int err;
+
+	mdio_np = of_get_child_by_name(node, "mdio");
+	if (mdio_np) {
+		err = enetc_mdio_probe(pf, mdio_np);
+
+		of_node_put(mdio_np);
+		if (err)
+			return err;
+	}
+
+	if (enetc_port_has_pcs(pf)) {
+		err = enetc_imdio_create(pf);
+		if (err) {
+			enetc_mdio_remove(pf);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+void enetc_mdiobus_destroy(struct enetc_pf *pf)
+{
+	enetc_mdio_remove(pf);
+	enetc_imdio_remove(pf);
+}
+
+int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
+			 const struct phylink_mac_ops *ops)
+{
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct phylink *phylink;
+	int err;
+
+	pf->phylink_config.dev = &priv->ndev->dev;
+	pf->phylink_config.type = PHYLINK_NETDEV;
+	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
+
+	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_USXGMII,
+		  pf->phylink_config.supported_interfaces);
+	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
+
+	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
+				 pf->if_mode, ops);
+	if (IS_ERR(phylink)) {
+		err = PTR_ERR(phylink);
+		return err;
+	}
+
+	priv->phylink = phylink;
+
+	return 0;
+}
+
+void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
+{
+	phylink_destroy(priv->phylink);
+}
-- 
2.34.1


