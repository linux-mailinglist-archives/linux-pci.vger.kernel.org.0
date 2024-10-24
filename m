Return-Path: <linux-pci+bounces-15173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C559ADD2A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F1B2823A5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A15F189F37;
	Thu, 24 Oct 2024 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hHrGS419"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA21ADFFC;
	Thu, 24 Oct 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753751; cv=fail; b=ZYpsYbjexQXwdoxyRBx89EVgaqmTd4NQ/T4a9tCXUufzpGCxTjChTRVf/+9iGsu3uUMzQMNBBypT5Jbb4yLMCaNU6WTDSQ0ioipv04z4qM48ViLg4PbJtqKsx1ghq0ti760IKSqGZWMFE7nHgM05rLri9uRaXCz7ViEOU8Z+AKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753751; c=relaxed/simple;
	bh=yPuogsgYjFUeFfMhMX3jfqdxdBotPkQ2mDy4Th/p/pE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Li8XcNHtcA94u7Q3ToBSBcCFXwd0uWAs0c5ASNcLXwEHv2Jxa+LJNOZiBsIIPIVS3mjDGOBAorAYB6J0v7A222HWMAyVqVkLXeilac/iQZfw5XI/f6QClLZbY+1UHbaWvmfKZ1LdLr+7cwwrnsC2ULGVbNs2oeFwJ4Oa43qA1Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hHrGS419; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbrUmx4uY2p0Sknol9pMsXmzpDCkrKVhvY5k+bcS1J6lvNfaRDnVv9YJO/pLbERLE+ScXQX2SgFrP8mEDC4+/wJr+LK4yn9XUpNJmEmjqiReygJtOVrVpPDSmLsFRIFtFXQv27p7NJB/BKR/lDlDAEEWJyUfNt8YZ9yJy/qIu+v7k4gI3NCr+JIhOt43S+uR39RKdpg9l0CYTT7G54DDsG1z8fr/v8QriVyA8KVvW/Yab7Iw4dNpSpbvtfcqPaphwLub5xjdm7tzQghBMA7HW4GebbFVFf81/8mBr7vWisfDsvHjtN9PmmFi0LLe7UXtouiJ7sx1wbQ+ojo+DpxwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gfRmXiN/FyIvPibliGUJEADqq+hRkV6Yn7534qt+BA=;
 b=fZ4q6whj6fP+xHNWHouBPUyAam65HXIlucWfGobMreLZ+jp1wBodQ8bo3W1qS4ix9RRC4KNIb+CWlsQzlQgL7f32p/l0pg5o3X51mvtfPsKFcY9Qg9udYTBKH0f/hC60JhfYfmcaP5ZdQOT3owgfzu2LSmWHwTDbOC/VFmgok8aZFjD97Sdz/Be9nY17okZClh9E8t62hnaHicC3jIExVpEj+yOzxiEVcC+jrmB9ckL2lgAnDCOXx/Sn4yIlOxTTkgAR1ONPoHHRXYxcfj5TOLChjEllSaRj1v1xK+7CXYo4JZy8MYfkRQWO9qUh3RWW+5nWyIf1crqPu2fdxarKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gfRmXiN/FyIvPibliGUJEADqq+hRkV6Yn7534qt+BA=;
 b=hHrGS419IRbJousJ/4V7WnuQCP0TNhUkXgFWH6xGWlBZI/o98fEFCbHJS4hb/EvKKkoCwqTim3YAngndw3My97xBAJuo3doBJxUYCZWr4Cow9/KdIqD80h2wyUIjFUisR4LCJK4YoaXRXsvVoWPDKwxljk/jcRor8EG8fkATGmJrXiDJVWe3g5DsNQdyT5WAXLSqxbOfmzRNFxlWsA5pwyybtrJDOxdensD2Xe3C7b65non5VmZ3k8ZXLLVAnMjPcgfw/TGNyw1/Da7F0bOB7Xkc9dYIuA6+JqALHKj9ARq9VTE2sVp8GTKohi8Q3rWtnXaaxiBqAeb5Ji1NJb7CIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 24 Oct
 2024 07:09:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:09:03 +0000
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
Subject: [PATCH v5 net-next 04/13] net: enetc: add initial netc-blk-ctrl driver support
Date: Thu, 24 Oct 2024 14:53:19 +0800
Message-Id: <20241024065328.521518-5-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6197d6a8-bd23-4214-6ae9-08dcf3fabd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J5AgH6Oql61S3yocMzWVcPAV4nARDGQk/aHtn3EdXPqtF5P3eB5WzDiVxEXr?=
 =?us-ascii?Q?oziRq7NNxcpKydqm6gVud8Xw3zfcnMUdNwCepcD/Ig1olp3EmYn/FPbucwf8?=
 =?us-ascii?Q?Rmb/o1HylDHtnfzr2P/v7dv0lkhOpTjjEXKRE5kQnfX+vdukWNkow3j/a50Q?=
 =?us-ascii?Q?grZKRJeqYUHTUcL0hSTb3GeStUyP/v7A8qoQH/p3THZVpmjO+7CMX9iootVD?=
 =?us-ascii?Q?6aTGEKRCU/X8sWuymP64UZ0Y2V7TvyA9Qje7Ucd0I7bDMH1VaymJo8tmHCl3?=
 =?us-ascii?Q?qZXnPP3B473HAMid4XLjq6GUxDP3n4LpL3MghS7140FrNikBmsjBKJYkkuf0?=
 =?us-ascii?Q?h/VKLIZo9sQFi+WZL86ow6Pb6ST/xM0HxGa1t2UOlzAmEkHgd9fqIxsSy3hi?=
 =?us-ascii?Q?GkAcoE/cPh1RWBSPMX/2a23CYtSwDLrc2yGGbhzjZWiS4/0xA4cg4eTrUbLg?=
 =?us-ascii?Q?pnbrnz7b1swAsDLtR0p7aQWZJmVTvOf4Xz6s8EzX/bBdRFOcfEOI+fnmVt2c?=
 =?us-ascii?Q?DBgqPsf5YWgmbH2fvfqjc7cNorRSpkgIEqOPhFP5JkP8z+LfBPlB6cH8DaN8?=
 =?us-ascii?Q?boiTCAPPClWE3+7gNItrzmWVfxobJTYc51oxAPbr4sW8m4HHT0nGYaWICI+b?=
 =?us-ascii?Q?BwMrAK//4eJ3Ix/4LPBVXs3EMbSLeXtjAWezRndJ+kJBNFE2L+YFkwA446Xd?=
 =?us-ascii?Q?dWv3c7eSYQrLkMgYpZcAgrooDsrqJtm0KXkzhLFeRqN0AwRICM0P/y4NRtwx?=
 =?us-ascii?Q?Ot6lxpVxkwpSleaatyFiDPhMOCSdInV4+Aohkb7J4d8fVJV7K6Z3nrTG8FtU?=
 =?us-ascii?Q?ZmSvORbTkgBrH7RLoaH3NXZkbHZMZpNYwzd+q2aFb6zmJUa2Rm8J/vuDCzzi?=
 =?us-ascii?Q?Faxkip4FKS/rBiYnFeubljFrvPrBCAD+ftYUOaDWnOyU04twz29MXXDewjsC?=
 =?us-ascii?Q?/xto3OOBtD0C1eFVXpHeS14kRUobeB77GeFnA5FaqSWA1XSYELMrI2ydze0g?=
 =?us-ascii?Q?7ws6nRHEcWEVlZUpBB2TUQoQp3GSEmDwNYtIQBlEYt5DcNaPRXUsNPP2pF7Q?=
 =?us-ascii?Q?6qUUQNTc64ZiW5zzkwvJL/KESW0JghkbtZtnjSR2k3GcOGnPCZppHXKnwndl?=
 =?us-ascii?Q?YRbre5fgICqYb9g9HqGaUgK7YMTUQXjA+5f/NrtRtMbZXrlu5zL304Z2TCb+?=
 =?us-ascii?Q?KVM3UWZ/CnCrr4IGKHvhAX0xMcPxAxMgtSz+ibNhO5WBwyhoWOABBZxpnXP+?=
 =?us-ascii?Q?DaallbDn+u6jIAkQsfF8ZV0pLvzibrD8yiNZTRVqBYD9VEjghXw+oT4cBX3o?=
 =?us-ascii?Q?ekZAyDKG9PdT819ZjFX8K2Q8f+Hutggdkf6Tza2s8M09YsIGe3bogMHJfZbl?=
 =?us-ascii?Q?dSvoq3SAAClPnB132zxv29M8gm5C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cF4r2+GDAiGIl5d75aqFMBbyVy3rgozEpLATo9pwGSe8z9H4Z1TZdWLfbWFw?=
 =?us-ascii?Q?+WMWKVCQ72MSVA4EaJt2/vA+o5IWeGUrIpsln5b2bedGeqoO2DHrNtL2xrwR?=
 =?us-ascii?Q?COMvq7WVF61gUt9OxTtIP1gOW+KGgyu7uTvr1+rN3N2wm0W+vLsByMe8eL0y?=
 =?us-ascii?Q?aW0AHYp7Qo/tubp7IjjNE+Qw5/P1OUjWDHqvbC0+VFXBn08u1uM+SVm4FmuC?=
 =?us-ascii?Q?ngjNDbUd4AfF9CoEJlGr8qnst+I5p8T3UtrczsBpsZGT6kwONWfK653M+4Sq?=
 =?us-ascii?Q?DShFPmloN6cBzyLYT44uwGl+ufmk+5H+tA5mFS8ZlAGUft8jPeDNM9pbMCYA?=
 =?us-ascii?Q?8a/QAF525ONA7WAa2Ur5neQfXtkG+sFHxxKqphUTQGGX4I5ya5VYS3zb83vI?=
 =?us-ascii?Q?+0VHwc+1Qo9JzybtwBdDrDeuOBciexB/Wbimk5+2dmGp5v2A0UcfF9k1qQxr?=
 =?us-ascii?Q?IeLVvtD8pRY/NJjPo1m8CuPlAOWQzoFSSJ8Khn6hV6HCVqRVZcTGu3YHQchM?=
 =?us-ascii?Q?1ZpB7aeGp+NQC3Yv9zx35yjySO5IBorovqMGKw9a9VNPY9NnMOd02JT+aJn7?=
 =?us-ascii?Q?3eHrHrID5ZI/u/nmClgmK61tpUsXQQGh2FlJgUMXoDj86zWUM6WkhNM1BqD5?=
 =?us-ascii?Q?Wkyl1vCBi82oZJtgaF3IZ7FIMN2HnFBCQcgFiPf1Q11+MXE8KuSLao3pgrnD?=
 =?us-ascii?Q?xHl8mfTX2Jhxrlsi7Gxsn8EgZbDdxFQHbs7U3hKaknOFwPAoqgHFCpUf2ct5?=
 =?us-ascii?Q?LcPpqRPsuCkQK7yd/k1uB/gA5DBV5bNv/ucHrgmsqTz+HoqS4rf0sMi6lpAZ?=
 =?us-ascii?Q?0GoLznU3V+QXXFxN1UQto5wpYuMM8eWyYgZZr89DFQMU52/TuK6IFHtTRP4q?=
 =?us-ascii?Q?lxJCdOJeOfx3G4+UHrm083mz3vuqK+cO2/MMZJlTx8Uru5/JQWHRp0KW8ikV?=
 =?us-ascii?Q?R7NqUBSAknb3nUzkLv/Da6traAp+uCYQPHE7+0FmQj/5l8il+fLpLajyeTIm?=
 =?us-ascii?Q?Xx/b5qJVvrdbrPvZz376FO0hWlMv+c1u9kAWjykwUfmKWK9hj5X2177khd4h?=
 =?us-ascii?Q?lQnRx8zL8JrsJA601lwA8pYp3q54Gv08MQAuMJT5cr8Bv1oCnlRUwwegx1M3?=
 =?us-ascii?Q?YOklN8cLz63F/v20cbHBDLMZub/9eNYguqCSAhxAEy7NZMNV3ynq5AFgyzEV?=
 =?us-ascii?Q?tsSA68wK7XyFLZxNc4qWSo9kBpZRNoXMeVDzjcTvf0ahYDKFK4Skgb88EDsG?=
 =?us-ascii?Q?KWLBt+7YfZdNMqZwsmiNkziIw97pyffEeNAYoOr6qa8iErfmGpaZiMIs9Wpf?=
 =?us-ascii?Q?eqK9IB6GVTd5RdVRu03V4hblxqsj2VJC57yMnxEE+0j+DrUs1iysJu9cN+ha?=
 =?us-ascii?Q?X5VPrfb6wr8KOLPM3vbfTCB8v4EV/VS/KcQInKDosZBPD1I0veW+TXi/8HaQ?=
 =?us-ascii?Q?P/HVK3hUFH6E24CBmDkM2Y28QsgtBeuzfRD5yLq0I3dHdBjBw3IfAlTAHGl5?=
 =?us-ascii?Q?6znub3NC4WVvF5T9v3Pf5BB2hdz6e5Kk2aLCGxDvGhF2nn3ENo3N8mzh91IQ?=
 =?us-ascii?Q?Y56jD/MfFwqwXnqGt+RSA5GBPMYFgwrd3zS2wVoh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6197d6a8-bd23-4214-6ae9-08dcf3fabd88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:09:02.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IbNIsxJbm6dOSwGcNA14p882Wkoy8IaqEHrHL7LwxBf6/fmwgpsBDQ7V9uj0VLFgFq+Uknp82EKu6V3HhJX2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153

The netc-blk-ctrl driver is used to configure Integrated Endpoint
Register Block (IERB) and Privileged Register Block (PRB) of NETC.
For i.MX platforms, it is also used to configure the NETCMIX block.

The IERB contains registers that are used for pre-boot initialization,
debug, and non-customer configuration. The PRB controls global reset
and global error handling for NETC. The NETCMIX block is mainly used
to set MII protocol and PCS protocol of the links, it also contains
settings for some other functions.

Note the IERB configuration registers can only be written after being
unlocked by PRB, otherwise, all write operations are inhibited. A warm
reset is performed when the IERB is unlocked, and it results in an FLR
to all NETC devices. Therefore, all NETC device drivers must be probed
or initialized after the warm reset is finished.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v5: no changes
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  14 +
 drivers/net/ethernet/freescale/enetc/Makefile |   3 +
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 438 ++++++++++++++++++
 include/linux/fsl/netc_global.h               |  19 +
 4 files changed, 474 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 include/linux/fsl/netc_global.h

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 4d75e6807e92..51d80ea959d4 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -75,3 +75,17 @@ config FSL_ENETC_QOS
 	  enable/disable from user space via Qos commands(tc). In the kernel
 	  side, it can be loaded by Qos driver. Currently, it is only support
 	  taprio(802.1Qbv) and Credit Based Shaper(802.1Qbu).
+
+config NXP_NETC_BLK_CTRL
+	tristate "NETC blocks control driver"
+	help
+	  This driver configures Integrated Endpoint Register Block (IERB) and
+	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
+	  includes the configuration of NETCMIX block.
+	  The IERB contains registers that are used for pre-boot initialization,
+	  debug, and non-customer configuration. The PRB controls global reset
+	  and global error handling for NETC. The NETCMIX block is mainly used
+	  to set MII protocol and PCS protocol of the links, it also contains
+	  settings for some other functions.
+
+	  If compiled as module (M), the module name is nxp-netc-blk-ctrl.
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index b13cbbabb2ea..737c32f83ea5 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -19,3 +19,6 @@ fsl-enetc-mdio-y := enetc_pci_mdio.o enetc_mdio.o
 
 obj-$(CONFIG_FSL_ENETC_PTP_CLOCK) += fsl-enetc-ptp.o
 fsl-enetc-ptp-y := enetc_ptp.o
+
+obj-$(CONFIG_NXP_NETC_BLK_CTRL) += nxp-netc-blk-ctrl.o
+nxp-netc-blk-ctrl-y := netc_blk_ctrl.o
diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
new file mode 100644
index 000000000000..9bdee15ef013
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC Blocks Control Driver
+ *
+ * Copyright 2024 NXP
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+
+/* NETCMIX registers */
+#define IMX95_CFG_LINK_IO_VAR		0x0
+#define  IO_VAR_16FF_16G_SERDES		0x1
+#define  IO_VAR(port, var)		(((var) & 0xf) << ((port) << 2))
+
+#define IMX95_CFG_LINK_MII_PROT		0x4
+#define CFG_LINK_MII_PORT_0		GENMASK(3, 0)
+#define CFG_LINK_MII_PORT_1		GENMASK(7, 4)
+#define  MII_PROT_MII			0x0
+#define  MII_PROT_RMII			0x1
+#define  MII_PROT_RGMII			0x2
+#define  MII_PROT_SERIAL		0x3
+#define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
+
+#define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
+#define PCS_PROT_1G_SGMII		BIT(0)
+#define PCS_PROT_2500M_SGMII		BIT(1)
+#define PCS_PROT_XFI			BIT(3)
+#define PCS_PROT_SFI			BIT(4)
+#define PCS_PROT_10G_SXGMII		BIT(6)
+
+/* NETC privileged register block register */
+#define PRB_NETCRR			0x100
+#define  NETCRR_SR			BIT(0)
+#define  NETCRR_LOCK			BIT(1)
+
+#define PRB_NETCSR			0x104
+#define  NETCSR_ERROR			BIT(0)
+#define  NETCSR_STATE			BIT(1)
+
+/* NETC integrated endpoint register block register */
+#define IERB_EMDIOFAUXR			0x344
+#define IERB_T0FAUXR			0x444
+#define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
+#define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
+#define FAUXR_LDID			GENMASK(3, 0)
+
+/* Platform information */
+#define IMX95_ENETC0_BUS_DEVFN		0x0
+#define IMX95_ENETC1_BUS_DEVFN		0x40
+#define IMX95_ENETC2_BUS_DEVFN		0x80
+
+/* Flags for different platforms */
+#define NETC_HAS_NETCMIX		BIT(0)
+
+struct netc_devinfo {
+	u32 flags;
+	int (*netcmix_init)(struct platform_device *pdev);
+	int (*ierb_init)(struct platform_device *pdev);
+};
+
+struct netc_blk_ctrl {
+	void __iomem *prb;
+	void __iomem *ierb;
+	void __iomem *netcmix;
+
+	const struct netc_devinfo *devinfo;
+	struct platform_device *pdev;
+	struct dentry *debugfs_root;
+};
+
+static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
+{
+	netc_write(base + offset, val);
+}
+
+static u32 netc_reg_read(void __iomem *base, u32 offset)
+{
+	return netc_read(base + offset);
+}
+
+static int netc_of_pci_get_bus_devfn(struct device_node *np)
+{
+	u32 reg[5];
+	int error;
+
+	error = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
+	if (error)
+		return error;
+
+	return (reg[0] >> 8) & 0xffff;
+}
+
+static int netc_get_link_mii_protocol(phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_MII:
+		return MII_PROT_MII;
+	case PHY_INTERFACE_MODE_RMII:
+		return MII_PROT_RMII;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		return MII_PROT_RGMII;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return MII_PROT_SERIAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx95_netcmix_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	phy_interface_t interface;
+	int bus_devfn, mii_proto;
+	u32 val;
+	int err;
+
+	/* Default setting of MII protocol */
+	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII) |
+	      MII_PROT(2, MII_PROT_SERIAL);
+
+	/* Update the link MII protocol through parsing phy-mode */
+	for_each_available_child_of_node_scoped(np, child) {
+		for_each_available_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return -EINVAL;
+
+			if (bus_devfn == IMX95_ENETC2_BUS_DEVFN)
+				continue;
+
+			err = of_get_phy_mode(gchild, &interface);
+			if (err)
+				continue;
+
+			mii_proto = netc_get_link_mii_protocol(interface);
+			if (mii_proto < 0)
+				return -EINVAL;
+
+			switch (bus_devfn) {
+			case IMX95_ENETC0_BUS_DEVFN:
+				val = u32_replace_bits(val, mii_proto,
+						       CFG_LINK_MII_PORT_0);
+				break;
+			case IMX95_ENETC1_BUS_DEVFN:
+				val = u32_replace_bits(val, mii_proto,
+						       CFG_LINK_MII_PORT_1);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	/* Configure Link I/O variant */
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
+		       IO_VAR(2, IO_VAR_16FF_16G_SERDES));
+	/* Configure Link 2 PCS protocol */
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(2),
+		       PCS_PROT_10G_SXGMII);
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
+
+	return 0;
+}
+
+static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
+{
+	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
+}
+
+static int netc_lock_ierb(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	netc_reg_write(priv->prb, PRB_NETCRR, NETCRR_LOCK);
+
+	return read_poll_timeout(netc_reg_read, val, !(val & NETCSR_STATE),
+				 100, 2000, false, priv->prb, PRB_NETCSR);
+}
+
+static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	netc_reg_write(priv->prb, PRB_NETCRR, 0);
+
+	return read_poll_timeout(netc_reg_read, val, !(val & NETCRR_LOCK),
+				 1000, 100000, true, priv->prb, PRB_NETCRR);
+}
+
+static int imx95_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+
+	/* EMDIO : No MSI-X intterupt */
+	netc_reg_write(priv->ierb, IERB_EMDIOFAUXR, 0);
+	/* ENETC0 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(0), 0);
+	/* ENETC0 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(0), 1);
+	/* ENETC0 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(1), 2);
+	/* ENETC1 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(1), 3);
+	/* ENETC1 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(2), 5);
+	/* ENETC1 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(3), 6);
+	/* ENETC2 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(2), 4);
+	/* ENETC2 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(4), 5);
+	/* ENETC2 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(5), 6);
+	/* NETC TIMER */
+	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
+
+	return 0;
+}
+
+static int netc_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	const struct netc_devinfo *devinfo = priv->devinfo;
+	int err;
+
+	if (netc_ierb_is_locked(priv)) {
+		err = netc_unlock_ierb_with_warm_reset(priv);
+		if (err) {
+			dev_err(&pdev->dev, "Unlock IERB failed.\n");
+			return err;
+		}
+	}
+
+	if (devinfo->ierb_init) {
+		err = devinfo->ierb_init(pdev);
+		if (err)
+			return err;
+	}
+
+	err = netc_lock_ierb(priv);
+	if (err) {
+		dev_err(&pdev->dev, "Lock IERB failed.\n");
+		return err;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static int netc_prb_show(struct seq_file *s, void *data)
+{
+	struct netc_blk_ctrl *priv = s->private;
+	u32 val;
+
+	val = netc_reg_read(priv->prb, PRB_NETCRR);
+	seq_printf(s, "[PRB NETCRR] Lock:%d SR:%d\n",
+		   (val & NETCRR_LOCK) ? 1 : 0,
+		   (val & NETCRR_SR) ? 1 : 0);
+
+	val = netc_reg_read(priv->prb, PRB_NETCSR);
+	seq_printf(s, "[PRB NETCSR] State:%d Error:%d\n",
+		   (val & NETCSR_STATE) ? 1 : 0,
+		   (val & NETCSR_ERROR) ? 1 : 0);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(netc_prb);
+
+static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("netc_blk_ctrl", NULL);
+	if (IS_ERR(root))
+		return;
+
+	priv->debugfs_root = root;
+
+	debugfs_create_file("prb", 0444, root, priv, &netc_prb_fops);
+}
+
+static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
+{
+	debugfs_remove_recursive(priv->debugfs_root);
+	priv->debugfs_root = NULL;
+}
+
+#else
+
+static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
+{
+}
+
+static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
+{
+}
+#endif
+
+static int netc_prb_check_error(struct netc_blk_ctrl *priv)
+{
+	if (netc_reg_read(priv->prb, PRB_NETCSR) & NETCSR_ERROR)
+		return -1;
+
+	return 0;
+}
+
+static const struct netc_devinfo imx95_devinfo = {
+	.flags = NETC_HAS_NETCMIX,
+	.netcmix_init = imx95_netcmix_init,
+	.ierb_init = imx95_ierb_init,
+};
+
+static const struct of_device_id netc_blk_ctrl_match[] = {
+	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
+	{},
+};
+MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
+
+static int netc_blk_ctrl_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	const struct netc_devinfo *devinfo;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *id;
+	struct netc_blk_ctrl *priv;
+	struct clk *ipg_clk;
+	void __iomem *regs;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = pdev;
+	ipg_clk = devm_clk_get_optional_enabled(dev, "ipg");
+	if (IS_ERR(ipg_clk))
+		return dev_err_probe(dev, PTR_ERR(ipg_clk),
+				     "Set ipg clock failed\n");
+
+	id = of_match_device(netc_blk_ctrl_match, dev);
+	if (!id)
+		return dev_err_probe(dev, -EINVAL, "Cannot match device\n");
+
+	devinfo = (struct netc_devinfo *)id->data;
+	if (!devinfo)
+		return dev_err_probe(dev, -EINVAL, "No device information\n");
+
+	priv->devinfo = devinfo;
+	regs = devm_platform_ioremap_resource_byname(pdev, "ierb");
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs),
+				     "Missing IERB resource\n");
+
+	priv->ierb = regs;
+	regs = devm_platform_ioremap_resource_byname(pdev, "prb");
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs),
+				     "Missing PRB resource\n");
+
+	priv->prb = regs;
+	if (devinfo->flags & NETC_HAS_NETCMIX) {
+		regs = devm_platform_ioremap_resource_byname(pdev, "netcmix");
+		if (IS_ERR(regs))
+			return dev_err_probe(dev, PTR_ERR(regs),
+					     "Missing NETCMIX resource\n");
+		priv->netcmix = regs;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	if (devinfo->netcmix_init) {
+		err = devinfo->netcmix_init(pdev);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "Initializing NETCMIX failed\n");
+	}
+
+	err = netc_ierb_init(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Initializing IERB failed\n");
+
+	if (netc_prb_check_error(priv) < 0)
+		dev_warn(dev, "The current IERB configuration is invalid\n");
+
+	netc_blk_ctrl_create_debugfs(priv);
+
+	err = of_platform_populate(node, NULL, NULL, dev);
+	if (err) {
+		netc_blk_ctrl_remove_debugfs(priv);
+		return dev_err_probe(dev, err, "of_platform_populate failed\n");
+	}
+
+	return 0;
+}
+
+static void netc_blk_ctrl_remove(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+
+	of_platform_depopulate(&pdev->dev);
+	netc_blk_ctrl_remove_debugfs(priv);
+}
+
+static struct platform_driver netc_blk_ctrl_driver = {
+	.driver = {
+		.name = "nxp-netc-blk-ctrl",
+		.of_match_table = netc_blk_ctrl_match,
+	},
+	.probe = netc_blk_ctrl_probe,
+	.remove = netc_blk_ctrl_remove,
+};
+
+module_platform_driver(netc_blk_ctrl_driver);
+
+MODULE_DESCRIPTION("NXP NETC Blocks Control Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
new file mode 100644
index 000000000000..fdecca8c90f0
--- /dev/null
+++ b/include/linux/fsl/netc_global.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2024 NXP
+ */
+#ifndef __NETC_GLOBAL_H
+#define __NETC_GLOBAL_H
+
+#include <linux/io.h>
+
+static inline u32 netc_read(void __iomem *reg)
+{
+	return ioread32(reg);
+}
+
+static inline void netc_write(void __iomem *reg, u32 val)
+{
+	iowrite32(val, reg);
+}
+
+#endif
-- 
2.34.1


