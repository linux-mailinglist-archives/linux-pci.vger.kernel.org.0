Return-Path: <linux-pci+bounces-15175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673279ADD34
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32B1B23730
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535221B0F0F;
	Thu, 24 Oct 2024 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HM9L1CR1"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48C18BC13;
	Thu, 24 Oct 2024 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753763; cv=fail; b=cA9G6MBavXbjBZjPZj6O788jhoR8wM5NoKN15Fgl5htK6/lk8bwb7GzpOEqDqA4nhJAT8lGm0Ou97Xmpx9ATb6Q8OPk+/VEGxWuYs5TglYn1c3IzzMpwwyxCV1pmBSNWUUwYnUlqBCWhhPQTzVDob2TESNwmIBHc+RLD+J0uw90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753763; c=relaxed/simple;
	bh=pPfZArAtQg/u9KHB85Rs5lUaKbaXUgfwqV37y/lN6cU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SxVT705m0O8bpk+OV6v9SrhL5EFtlk+sAG6OL3+MHPs6tC5/Kcg0uTm2/65ps00K+HTPHfvkQ/+wugiM2zbodnr/zYgIo5MKiFtHE2YlEKuQKiTM+W/SpgdAObT0Rx7J+Yrq/xeukzU2GrDGNQtl/OcuwYYFVNo5ZKvKm2nHo20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HM9L1CR1; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4r+yefAgkRDhbhYzwqf3NKB8DXOiDu0wI3OH/QAuJ2QXHwZWFD+hDfPf7tHB/0RCZHTF3iG0Xl4VhR+A033pncDUj7fUZmyMP20h3zQmYPN8Rdkqgy/N8KgR9mC7Yk65UDq2jgSaRtZtmTm8VkWobqxmunfXzQtxcIq7mZGED2qA5bObSjvLTprqmgeXPYI8BLsZm02f+BCDIp0KrpoZAZAbX5gX9RdQuI/SN85eqpHywNuxhWnEYqevbnMcJHhaNlK/d2EAMUwYZ+aZstZgQC2hzPQ6gscBikFCLDMBf01IYnYwQo9czKrWKHh3Sm4rN19sz7Z4IwNe4SIhmsttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR9yd7tpAvdaQThHWnTfjjwcJxGvfNY7vaGzd8oJIqg=;
 b=BF/eILnu60vB76e7NlaM4PgbORpSpeYt4yUX/FgMM9rNVNpXaUNHMeF9DoKir4EEPjGzgTVmPUMPAgcV4/fWw93dpFhEDiyF1APvTAL0+e5BXr6+YPVjVY4Ww+EImXlyZ/75DTIZzwdSNrKV0Nhvq1pn6ypWe5cQXTJa//8xozc//oB3fQAe8PiBKgT7y5pf2dvCTWC3V0BjBoZunnTMd/WJO4bl5fdKVGAUn4fI/rV15kdMgPKvjCpQKptbyuYXBflsmMZKdld8J5X7e3/R1Yt4Cjrq2YPvbEWT7IExKYjY5+QuuZEQyOB/p/zf0eTWmOeaFVWgzDCJr7jYYIf+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR9yd7tpAvdaQThHWnTfjjwcJxGvfNY7vaGzd8oJIqg=;
 b=HM9L1CR1seOeyVUvH8TFJk8jdzUfo4MfAiYUJuSMPtA6LWWBYgCbSZLzYRDlNsc4JbjLiRNnTgxl3rKebdmjS5C2YSQfm1yvpfC0oS2iXKRK4gNOYqjmVBQyQNWdhVEnn5F4mgT4NFgIHYKDTFOSOP5Vr99I5MFDuz1Sqqmn2lVCU/KYaZx13bfnBnRCHHpCAOsEH0hEv9BMtzw2fVpoo2VMyc32oKe+L+0oEcY7q1lByh9Kb8bozkrVI3Loh819rtnswKlwTz1FOh0qkqpoaBzQ/XVEGF2z/iwUzGkkXusm6kOMS8F8JG3hg8PpCbH7DLQiBMAj5Ca4rRLlQgWmTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 24 Oct
 2024 07:09:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:09:15 +0000
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
Subject: [PATCH v5 net-next 06/13] net: enetc: build enetc_pf_common.c as a separate module
Date: Thu, 24 Oct 2024 14:53:21 +0800
Message-Id: <20241024065328.521518-7-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1a120f-5911-4bbd-b186-08dcf3fac500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?axCYEbOH5YVJbcuj0X2Zbn7zL3KAVdXmaxW3Ei+LCo0XvvRlDc7wGSYMM3jy?=
 =?us-ascii?Q?R0jg5OoTaNMqDv78houOh9YgDLa8ikuAJDtEd/YADKkRVoO2MHziXr+ubZGz?=
 =?us-ascii?Q?ABaBfvgV3d+QjNlwc0ipi7UFjrpye5SRP7WCZM41KzoXcIz2lKRmecwlqzby?=
 =?us-ascii?Q?4E2CWRaYh7PiaCcMtgrrJmEdHEjDQ6Otox3qUoVmKdVDXr5dXGbHa+2KpLRw?=
 =?us-ascii?Q?vR13+1owN6+ffGmFI2EVp39pZKwEs1kvSdx06mNHowZiYpOm8YKQ6oovntvp?=
 =?us-ascii?Q?CjXrFypAAEYYMxuovyZGFuy2nCJT6WA230q4VwyCSGKx/WgRjD6wFrRUan4y?=
 =?us-ascii?Q?hzZKsoOx9PqCO2wzPMkzdndWZGPSeY1aWJMJ0m0/djRAQ1hua9g422pZ++ob?=
 =?us-ascii?Q?DijXaXJrEYz0ee4bRtQdJsy+1rbEpyEo0714GtsTJ6uW5m2Av/vZV57L+JJ+?=
 =?us-ascii?Q?BgQm/po02I5WVdKRId6A4v3WZ9hgh+knwn6DOi9UQuTZJjJjTXPxp7TMT2Ko?=
 =?us-ascii?Q?51Jm38NUKJ+uT4V3jZEOGo9/fWe8LscM4J5r/vDndCtvrE5z4twjcy9JApF9?=
 =?us-ascii?Q?dzlObP6H7QC4xiVG2IjYDrcc6jlKpAVFfBt5qZfa/OeC4PZxKkfDa6X6KM/9?=
 =?us-ascii?Q?PDAPNNf4qU3hT8jeGs8dUnomnSqGm5D660Y9jgiYLxvo/5w6Cpxp1oHNI8/c?=
 =?us-ascii?Q?rGRWxYTQrGgCzlW45oL8NMaud4fG4ATEcm20rnZ+pQrl8kpmcT0y3z2XrNXa?=
 =?us-ascii?Q?jpslH+s6owQDEiLXuhokrCBQyY/1gvwU0JpUBXKyxSYhwMfCOINJ0ENH5Dek?=
 =?us-ascii?Q?EjRQ0KUtxSbDY4vl2iwqxmrKVBPYt/FulH6KKS+6wZRdQW7JN0iGD9dJkXOL?=
 =?us-ascii?Q?kMku7gssc12cBU5MAW0JSo0GOR6cvyohVLvgcU/C8FUNVjySyo6BMjjWoUou?=
 =?us-ascii?Q?Bgojfz+CXTfOXo2R7+BcomjadolJjUK7i5PZJuJk7pomHzvAmPRd2inHPX7l?=
 =?us-ascii?Q?ZOrJ/l3k/zEsK0mptKYmMbThs4ZXIZsAl5xDsS6XqCPqeaGt1nqppxKfSFCx?=
 =?us-ascii?Q?d0BDnhfpEGE0FxnlbAhQoldn1fLRqr9yCu2MmbfXZMzEG/WXZskeZpJxkUaq?=
 =?us-ascii?Q?rzXu3HggYB68ZyXAoZrrPkYj0d7kPTYzHfrATUCPfSAP8Wh1S5dm6bBR21aF?=
 =?us-ascii?Q?AbNqOFll8WuWdMWQa0uJSxM5Q7Laz/1qBqT0FZAUBJ7MMR10qjCZG8dFSthV?=
 =?us-ascii?Q?eB9XyigSc+03SPpBgzYqCdjPShg/NfLJCFWIhgC7rMUorQPAOzI4x/PtOovT?=
 =?us-ascii?Q?M0c6UBvEkeXi+5JqXdztpcJbBMVrY6QMyDnDcmKF883x3IpRL1BaDBGDu/l/?=
 =?us-ascii?Q?D5f8V/RUnmCkzZBChY0PbxhU72ut?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YxbGsTwuJcMFVSUDd2/D/Of25tg5+RsO3XbmLkJq5KQVSFo5qFmpuubV4Bi4?=
 =?us-ascii?Q?UNHeaJCDM4NvtVF4je7ekAmuNar14/X0VXxrf8+xEEytaZ7WXXTQYIgN3Ybm?=
 =?us-ascii?Q?F4Xz6rZO5Ntab3u6P7hZ2zx9qIxEYHG9LU2nd0MiqFAIXOAWi9AZ3iKVsFz+?=
 =?us-ascii?Q?jNZKErMZJHRhCEhCGaG2b/cbYWewxp7mnVEMfrxdj77GRfGNbXgjBPIHB7dW?=
 =?us-ascii?Q?rxlt6Uq7E2s0gIiZreJxxKlLaDket2kSVR3mqrGACoWzb3Y6SsnZAm7K/clK?=
 =?us-ascii?Q?hCAwcDHVb/lxa47zE0IEzQzp6TKNyQ8CjtQwJxUUbTH/wX00M+MUDePdU54l?=
 =?us-ascii?Q?KYFCI+HW4fGKiAcTyFuZfREmLftVOK3R9xgeGDCkwG80O2+nFGnXiSAMCcyP?=
 =?us-ascii?Q?rtDd2yWp0YIe8f+GNSSRiEkAkxepmGycvgyDbwP9k7g5oNFRJIGrza8ScE9h?=
 =?us-ascii?Q?F6SCRgSHPowvnwBRQ9JaqvSoz86Jx6hBCbWHNOoAlvBHwh8+P0NRXMWtEEff?=
 =?us-ascii?Q?eyohVfSM4d4ElryR3sf240KWH6H2IgKWNuIb69ddzR/n95S3vfC9ZElyQ6aB?=
 =?us-ascii?Q?3E6Zehk2m9OvgOI5ipUMuXkg9eQpwfA1vr2eHmdP7rRIxqdyzCBXm3OPlIiT?=
 =?us-ascii?Q?vMxviM08r2qz5bHVoecQb4gpGHYP9Egi9Kk8RctMjv5b6Ai1qmjqMbO+Lju4?=
 =?us-ascii?Q?0RxlKbNurdWyXHMtBGEWTyAsIae5+pIOPZTji5OR6YJdV/ambSDGThkVIp8e?=
 =?us-ascii?Q?T+b/lA789/YZgX9m1Mt/TlyjiJDd3OKDepidSsm4UnLcbQJQySv4YMFScNpR?=
 =?us-ascii?Q?GSnfF/vziQ2i80uA/zXPmxllM6o8XNRwOMPhQLygRLCGM2XXGCe3xh8hesdr?=
 =?us-ascii?Q?ZtEdSc6N9fCq7/5UFXvdHqb09QeowtWkGdGYeqDaNvi4sD/aW3SSvf1f+ECV?=
 =?us-ascii?Q?ojfKr60/MW5drbDrLe5KJwf4aX9eZAMItZgZ1qixp1U2d8KjWk7tbg6R0ft8?=
 =?us-ascii?Q?nEd7/wBw787ENQWHvdQ6j9tLua5ISEdDsUD9teGtCaDUgI1OJMyzcPIK4gdr?=
 =?us-ascii?Q?hW6nSLW4eUEsDm1oeDljC4K+DidPnqI7gbCdLsRDegLZ4hruyn/HwXtEGggq?=
 =?us-ascii?Q?tWuBAiTENBGL1O05eTb6PD1zG2CXOwaz7w7gvhMQb2Kx6+g33NpCsVqUXJmg?=
 =?us-ascii?Q?T58GmopbfB7v6T3ivbmf372lCmgkprpNNg1LYegffWp2kCCq2k9mDxvtgiVZ?=
 =?us-ascii?Q?OhT26gOb+YrLlpsRMQfO5hARw6xtOrYzFnTHSpX+cRyMMGObFu3ItMkIr2Sd?=
 =?us-ascii?Q?2UlAQOY+eRPHEZJ2YQZoT78SJpeskkyqe6CnnxI3EsFY8n+u1zjzojQGi+8t?=
 =?us-ascii?Q?Ty8/Uln1tXJU0FGSgip1ftjshOcvdUO2rcT2O+rUZXOfB63DIE8YrfFa+7jr?=
 =?us-ascii?Q?8oh+AIdT59/HWG8ZMxQIwpMY3tDZKzBAs5pya8dG8tna6QjBwtK7haFkIl9o?=
 =?us-ascii?Q?Ek58eEF+l6A7pdXejoRdema17Ic+GmquMD+LuGhQp7eQUUoD6i/RPex2zmyE?=
 =?us-ascii?Q?VBXIHV5F3Ee8pkDMtzHiIDikHhSo6O2heJQE/mMN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1a120f-5911-4bbd-b186-08dcf3fac500
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:09:15.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riMJ8jOPMMiAsyL3PRLKmzDd09S6zKRm6r8C8U0m/aWw6SEwmDR2jWIJP83cQjNb2YLg4XCvcl2mBvnrSn8dew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153

Compile enetc_pf_common.c as a standalone module to allow shared usage
between ENETC v1 and v4 PF drivers. Add struct enetc_pf_ops to register
different hardware operation interfaces for both ENETC v1 and v4 PF
drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v5: no changes
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  9 ++++
 drivers/net/ethernet/freescale/enetc/Makefile |  5 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 26 ++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf.h   | 21 ++++++--
 .../freescale/enetc/enetc_pf_common.c         | 50 ++++++++++++++++---
 5 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 51d80ea959d4..e1b151a98b41 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -7,6 +7,14 @@ config FSL_ENETC_CORE
 
 	  If compiled as module (M), the module name is fsl-enetc-core.
 
+config NXP_ENETC_PF_COMMON
+	tristate
+	help
+	  This module supports common functionality between drivers of
+	  different versions of NXP ENETC PF controllers.
+
+	  If compiled as module (M), the module name is nxp-enetc-pf-common.
+
 config FSL_ENETC
 	tristate "ENETC PF driver"
 	depends on PCI_MSI
@@ -14,6 +22,7 @@ config FSL_ENETC
 	select FSL_ENETC_CORE
 	select FSL_ENETC_IERB
 	select FSL_ENETC_MDIO
+	select NXP_ENETC_PF_COMMON
 	select PHYLINK
 	select PCS_LYNX
 	select DIMLIB
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 8f4d8e9c37a0..ebe232673ed4 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -3,8 +3,11 @@
 obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
 fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 
+obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
+nxp-enetc-pf-common-y := enetc_pf_common.o
+
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
-fsl-enetc-y := enetc_pf.o enetc_pf_common.o
+fsl-enetc-y := enetc_pf.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 3cdd149056f9..7522316ddfea 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -11,7 +11,7 @@
 
 #define ENETC_DRV_NAME_STR "ENETC PF driver"
 
-void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
+static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 {
 	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
 	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
@@ -20,8 +20,8 @@ void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 	put_unaligned_le16(lower, addr + 4);
 }
 
-void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-				   const u8 *addr)
+static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+					  const u8 *addr)
 {
 	u32 upper = get_unaligned_le32(addr);
 	u16 lower = get_unaligned_le16(addr + 4);
@@ -30,6 +30,17 @@ void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
 	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
 }
 
+static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
+					       struct mii_bus *bus)
+{
+	return lynx_pcs_create_mdiodev(bus, 0);
+}
+
+static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
+{
+	lynx_pcs_destroy(pcs);
+}
+
 static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
 {
 	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
@@ -970,6 +981,14 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
 	enetc_pci_remove(pdev);
 }
 
+static const struct enetc_pf_ops enetc_pf_ops = {
+	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
+	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
+	.create_pcs = enetc_pf_create_pcs,
+	.destroy_pcs = enetc_pf_destroy_pcs,
+	.enable_psfp = enetc_psfp_enable,
+};
+
 static int enetc_pf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -997,6 +1016,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	pf = enetc_si_priv(si);
 	pf->si = si;
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
+	enetc_pf_ops_register(pf, &enetc_pf_ops);
 
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 92a26b09cf57..39db9d5c2e50 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -28,6 +28,16 @@ struct enetc_vf_state {
 	enum enetc_vf_flags flags;
 };
 
+struct enetc_pf;
+
+struct enetc_pf_ops {
+	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *addr);
+	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
+	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
+	void (*destroy_pcs)(struct phylink_pcs *pcs);
+	int (*enable_psfp)(struct enetc_ndev_priv *priv);
+};
+
 struct enetc_pf {
 	struct enetc_si *si;
 	int num_vfs; /* number of active VFs, after sriov_init */
@@ -50,6 +60,8 @@ struct enetc_pf {
 
 	phy_interface_t if_mode;
 	struct phylink_config phylink_config;
+
+	const struct enetc_pf_ops *ops;
 };
 
 #define phylink_to_enetc_pf(config) \
@@ -59,9 +71,6 @@ int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
 
-void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
-void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-				   const u8 *addr);
 int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
 int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
@@ -71,3 +80,9 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops);
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
+
+static inline void enetc_pf_ops_register(struct enetc_pf *pf,
+					 const struct enetc_pf_ops *ops)
+{
+	pf->ops = ops;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index bce81a4f6f88..94690ed92e3f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -8,19 +8,37 @@
 
 #include "enetc_pf.h"
 
+static int enetc_set_si_hw_addr(struct enetc_pf *pf, int si, u8 *mac_addr)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	if (pf->ops->set_si_primary_mac)
+		pf->ops->set_si_primary_mac(hw, si, mac_addr);
+	else
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct sockaddr *saddr = addr;
+	int err;
 
 	if (!is_valid_ether_addr(saddr->sa_data))
 		return -EADDRNOTAVAIL;
 
+	err = enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
+	if (err)
+		return err;
+
 	eth_hw_addr_set(ndev, saddr->sa_data);
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
 
 static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 				   int si)
@@ -38,8 +56,8 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 	}
 
 	/* (2) bootloader supplied MAC address */
-	if (is_zero_ether_addr(mac_addr))
-		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
+	if (is_zero_ether_addr(mac_addr) && pf->ops->get_si_primary_mac)
+		pf->ops->get_si_primary_mac(hw, si, mac_addr);
 
 	/* (3) choose a random one */
 	if (is_zero_ether_addr(mac_addr)) {
@@ -48,7 +66,9 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 			 si, mac_addr);
 	}
 
-	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
+	err = enetc_set_si_hw_addr(pf, si, mac_addr);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -70,11 +90,13 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
 
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(si);
 
 	SET_NETDEV_DEV(ndev, &si->pdev->dev);
 	priv->ndev = ndev;
@@ -107,7 +129,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_NDO_XMIT_SG;
 
-	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
+	if (si->hw_features & ENETC_SI_F_PSFP && pf->ops->enable_psfp &&
+	    !pf->ops->enable_psfp(priv)) {
 		priv->active_offloads |= ENETC_F_QCI;
 		ndev->features |= NETIF_F_HW_TC;
 		ndev->hw_features |= NETIF_F_HW_TC;
@@ -116,6 +139,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
+EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
 
 static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 {
@@ -162,6 +186,9 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 	struct mii_bus *bus;
 	int err;
 
+	if (!pf->ops->create_pcs)
+		return -EOPNOTSUPP;
+
 	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
 	if (!bus)
 		return -ENOMEM;
@@ -184,7 +211,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 		goto free_mdio_bus;
 	}
 
-	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
+	phylink_pcs = pf->ops->create_pcs(pf, bus);
 	if (IS_ERR(phylink_pcs)) {
 		err = PTR_ERR(phylink_pcs);
 		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
@@ -205,8 +232,8 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 
 static void enetc_imdio_remove(struct enetc_pf *pf)
 {
-	if (pf->pcs)
-		lynx_pcs_destroy(pf->pcs);
+	if (pf->pcs && pf->ops->destroy_pcs)
+		pf->ops->destroy_pcs(pf->pcs);
 
 	if (pf->imdio) {
 		mdiobus_unregister(pf->imdio);
@@ -246,12 +273,14 @@ int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_mdiobus_create);
 
 void enetc_mdiobus_destroy(struct enetc_pf *pf)
 {
 	enetc_mdio_remove(pf);
 	enetc_imdio_remove(pf);
 }
+EXPORT_SYMBOL_GPL(enetc_mdiobus_destroy);
 
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops)
@@ -288,8 +317,13 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_phylink_create);
 
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
 {
 	phylink_destroy(priv->phylink);
 }
+EXPORT_SYMBOL_GPL(enetc_phylink_destroy);
+
+MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


