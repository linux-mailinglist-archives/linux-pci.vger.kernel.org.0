Return-Path: <linux-pci+bounces-15575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F34D9B5F71
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629911C21167
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51971E7C22;
	Wed, 30 Oct 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M4fYGNtl"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579361E5016;
	Wed, 30 Oct 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282125; cv=fail; b=dlXBNOzPV7vFE+EdzYyAWNXS8BFeYNMu1QXmpkCjgjCTfc/lnCSt4s7BB2oP3xPiSJl5rsYf35jmyIPNtDHg8HU+N+uVL2n0cduf3ZtoaJ6oKmOOu/2plooGHhfqPG/MswryTDOuyZCEC4xwbX5U/zUcxmI8cN7a5hWPNliqT+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282125; c=relaxed/simple;
	bh=YS2XdplDiXW/5w49ve1q91uIog8nXZXg8WS0hMduREY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mRYL5WCw7tUBMq97I1o8HmeTyeN/G3QFzyfQ525cUySVaDN3Ya/sGwYNzcMmhpbv8gQWdh3UZT8oStYwtvgGVJW3aaudVq7I59FmWAWi5ab5hMUqyCcoypqeVAKFxkaaihqnXzVoFXUGyJt2sqtCNcA0WL8s6/xwR3aGli2N89M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M4fYGNtl; arc=fail smtp.client-ip=40.107.249.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb5nZVpqg7ZrbaH71v3MGU9iOyD+n2lqOkisEtqZa3nwB+zA+3qk99ULB6mQoXKsGTPEOVbQlRdkLQhk9cAnmC5bFN82cuZ6apfMeQVRYBur6qwLOMzxztKeZN7UmziV4+sOx92YTSBPNhoWCm/051fHxUeK0fbDiVwur94Z0BvVbBHLMXGO+VnCkkyK8BkOCteWuBMl7aqFnCr1JoCBoYs7pKjJv0fngcXbArMvZ9rraW2R6yNfz1Yj6qb/xMgqUBrLoh40f+TV5GjmrztOVRuZ0UZXaCqjabMrFHZgk9XchQIZZy3ouyGapKjXKrSmSxFWC+/s+lF60LWmsVwK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJZ2mRnHJXen3PuDRZoqky66nAAg2vjUnvzzmEgF6Nk=;
 b=D9njqXFKps5WWBCAutitdCXFB2MWILghe0LtUeTGwYXEhKlSLEj60eDPRowwZNi3mSgmstIkHfLVQN41pwYMHLRISGkPdKz2JFnvadXcSaW5x4JToowdVWGgqstpthTvuA6uQvy6FM/aN1eP4kRgcBNlvx0//zDeW8viSjv1FSUCzXUToiHiiKUIbNNYxoGvLLYibZLiBnbniW3FI1J0v2+b71Q8Zpo8iuDrjxo+b0omEvrG+5t9Y3knw4ZtbV97qxbE2XD6Da0i3u1DjkWP7CbsJ3vjgBmxqI9WyX21IV7wr++p87DMDJ1sOZDmo1TKwhWZb9y5zuUjelF7QaXfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJZ2mRnHJXen3PuDRZoqky66nAAg2vjUnvzzmEgF6Nk=;
 b=M4fYGNtl+VkdBAw7Rv7MvU0TIHEOIBCvjegaOLjfrh/gBLwADAaILoy+KfyrL+lNh2N0L6sggJwkypYSceCnQExJzN0o9Heje9VkqCXKSrccFG/1cstwg6Ney1nBC3rMPXDL+09bVsfQxGULfkiUx2Xgyn1Xbjjoa09BHaivfUian2L0Z2bLDwhwH+ZBPYWdpl2jFqVOv8HS5TC6fLU66S357OSI0yEYJqwjSAhNNNOf/6zRZNTK5sfRWdmz41d7KezmPOQrCcdYQnWcW8yaL5AX3OMk+OJjK8K7Om5WhsjYzQKn4X3thiqWjGWrHKMlGZsBnszskbqryxGEXiaZbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:55:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:55:19 +0000
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
Subject: [PATCH v6 net-next 06/12] net: enetc: build enetc_pf_common.c as a separate module
Date: Wed, 30 Oct 2024 17:39:17 +0800
Message-Id: <20241030093924.1251343-7-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8108af12-f642-4581-c48c-08dcf8c8f677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/Wux0CLfAVPuNDUZvokCVAlzwaH1dq9AQW7rVwHJtVtEWN47l9wjlEAYmqQ?=
 =?us-ascii?Q?weCzKKcVzh6YZOOASpgaA9LOyQU88sjjdYQcFjxlN7hbxOxuty4J2ZhetpkB?=
 =?us-ascii?Q?OKM+RrFyfHVblfYdNt+DLo/fXrs2kgtqpa94BMJfCLiXeHe24jK9dlcdkqvi?=
 =?us-ascii?Q?WpTDop8YLqT+7oogCHRyXMR5uUJnrfNNnuCjVWPqKjXf2SlNfsJ4lvzXkLNy?=
 =?us-ascii?Q?C2Jnpas5gqMuJFdC9IX5gTfNsWcNqacP7Z79OEqCmChzjhpZeqGRCeV3i+EO?=
 =?us-ascii?Q?xZHyaJ+2ErLdhulCNfejbSK1xyq+yBbCPTn4wtJ+EaB+Kl6CwWOaqKS7oxc2?=
 =?us-ascii?Q?PsCAN0aPmWIs12gb85vks/LsQ5nMF7r/53X7evXmbFmHiLI/+ihsy0kNr9eE?=
 =?us-ascii?Q?xNNzroD/GcKhCXf7j+uD6j18xQRUoUUYGM0EdOSh8QEHQduWUQEtQkvTMf2v?=
 =?us-ascii?Q?CJ9rxIRajMd3b42eLeNcX6zWhenkzUU3ZAy3h18Eqhz/KGVAmwpacowdUj2n?=
 =?us-ascii?Q?wna/0tZd7M9DQj/+tX6nzUhmRWpM6p+qaW7zu7ar1lJEgLJMtbA0FlvFt24M?=
 =?us-ascii?Q?lr/6k3E0ULecNBZ78Z8TW9sSsyOU9Tio1eBzQisKg3RYpnA+g7JkdDOs12YN?=
 =?us-ascii?Q?h5otAdhrKKR1bWw8hcdm5qQjHEP8kRLEFrlEftWRrg091zlDJY2iQx+GeIrr?=
 =?us-ascii?Q?lRTjdc19w47S9zXwVnDt2kyxWmzRQH/jCEGTeqXf7/YLjYJ1S8ru7qSmHaYY?=
 =?us-ascii?Q?DS8WDmhUtlLw4Gu/YVOg8WCmwuDW9hoirEWQRvQHobus8dpbKUOJjurwEaSj?=
 =?us-ascii?Q?yC/fnkH754axNC2Jp+8kFlVPuNpmxRNWAgXMJLmz2AxFdzqbSsbiPV1u3rUO?=
 =?us-ascii?Q?aK3qeYm85Q8O1O8R3iVIW8jxi+db2vqMhLwtQwbbBxcMWlxNlRIm05Ft1U8D?=
 =?us-ascii?Q?YA2ZSDx2tMtIV/7Tjco1zmddU7jU9ZbvXC0y1OL+TszgoiNAS3Tr+V1IOkgY?=
 =?us-ascii?Q?FUhpMFelmyYow1FYkV997upmBp/iiddlslKnPPIVK3f2VusrW33ujqWMP+HX?=
 =?us-ascii?Q?wjiHFtDbgYyTeG6bFkOnAoxgv4OZDx8Zm+Z+sBZ4OGVo4EBMnm+ZVJIqEJ9e?=
 =?us-ascii?Q?KZ0yWPrFkqM8rOmUHYZfR1Np+efzUNWQTMkIqwxawX+LYLOjmGQgFqXRSWIC?=
 =?us-ascii?Q?UWbWatqSttEzkkKHjDPiZLGWCdLRolQ1Rj5Taj4ycAr98yjooH22ttwHlh2i?=
 =?us-ascii?Q?nfUrSr2kuPzahFpYqvn03RRRiQuw/GTazr6b6QvVv2eVo/txNrf4uQZc8EuY?=
 =?us-ascii?Q?7Zc5yO9pmZA87Ir7DCrZT+qjGVyA4OsF0tLuYHRLzsTqpRgoBQrJ4/a0Blp5?=
 =?us-ascii?Q?mMCl7bf3IMQ25vfFh2I2oQ2NQUdx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NjOBQEbHLtJ41uDyAR1bRFvCxO31M8yEF1jWiBVhQVDGaGNXY3LKm6MGdoCb?=
 =?us-ascii?Q?iW8F/6W3TPOxvRqcwDKdN2Gig31bve3j/55YCdo3GiIGQT1FJ8czsJHxAsoM?=
 =?us-ascii?Q?pQjueXEe9Eq8WPGGeRgXgWMndv57TIT/KzKjnvrpDh6kF1Bwia86Zwf4Z8nB?=
 =?us-ascii?Q?kJEwdwq/+vt3uUIGJQ3GGfa+DbhkkGYkPytJhXePiHDpfPZ+gfmmgCNp5u5n?=
 =?us-ascii?Q?Ek0udxh3cO8BXV1PPuuIT0fN4tNXz90nP/oGVe6PoNbc+wF22Mce7mNqwnzp?=
 =?us-ascii?Q?V9LKtr9YhRHQG0xjAwa7JvI8aJTscY6QFc4+b1Rkb3t/bhSUJ0knE1vzXVd6?=
 =?us-ascii?Q?UBeubMUb7uYx4jjkGgJusT7ImH2FTt9oX6ksgHSZo+T6Vl+/4JHrCBi+3V0I?=
 =?us-ascii?Q?d+2w0i0ez2hECAdbFFaJ7EuCwHVXkYhX9hkddPKh5O1WKIknXuiK37RTjlOF?=
 =?us-ascii?Q?QOuuc+HsQpYxX1okJ/PPLLu22eBk9HM54LqaNcwtqfWLHF90qMVmJFKhQl17?=
 =?us-ascii?Q?I8qX4wMzOvrgMJEpNRYnpn2fhUAX+Koxwa/V6k23gwWCiKILPh3VDfdLDpe3?=
 =?us-ascii?Q?8nc6oSo87ph7E0VVHfTH5q5yPfHK8yfEaiWr7ZTYxuoRqxAWP/VternNvCZ/?=
 =?us-ascii?Q?KY4RQ2yM3epYaBCVOrjlA8+W+iejkIGSCk1budB4HsbaYkX2znh1yHv4fsRb?=
 =?us-ascii?Q?MxieBvJ2eAXw7nI1Jqzy09zcq4Kf3MFlB9FtVafJzSdJVDXZ1agbXzhmF7Eq?=
 =?us-ascii?Q?2JIZzb9PgrmPv29PRNXC75QtOaIpcMJHyR/y6ZrYocz0nNY8UZwIltURMZjV?=
 =?us-ascii?Q?BkruPyhQb4ybzadlprbXVDj/nfv+S9Eg89QKTfWZ9WpgSTnyWIfOcT+8lqQn?=
 =?us-ascii?Q?efdEkMHYRnbjGAbFP+VGFTJZC45Y7ahUxVMRgfO27gpHGdQCMJNb05ieV5DA?=
 =?us-ascii?Q?AZvpnpBK0o/aax4w2FCQj8YzEAMZV8rM5FQA/PzhaHY7YLzmyq/bvVuWww6t?=
 =?us-ascii?Q?x+4V2ORQsUK5bQ5j7VBZQgkLaHornb7x9rR5Y0y4T5OI5/OH/45PGbYooNCU?=
 =?us-ascii?Q?1GGoDCCa6IrcvVeFPAK5qQEYBVFvEJW6Z1JO9XCgt5GJF9xBoVx0wkGPVBDt?=
 =?us-ascii?Q?jl3nb/JHWLKCXbfxM+R4xQgFU8EoxcvLwHEeCoe/TccfxDc65TpalDxvOCmG?=
 =?us-ascii?Q?TjMDb+q1Q6gLIsYeJTuolo7OQCcg9//PqBIxckNOtdeJpQ4fg5/1w5myUuN3?=
 =?us-ascii?Q?f10nf33oN5vJjTFQrHeZ/YoboLkB+UCEwr+qivaOLc/i8HyUogD9taGrvjY2?=
 =?us-ascii?Q?DP4Pzhqql9z6xfa/awL8LSedxpbQubvgytGtFZCCAXBAjSF6atY5zmEqygHz?=
 =?us-ascii?Q?OiTruVKbSXy68pK8DQN5ZjM3TzB6N7sz9eKarPh9jmYuEuF8hpiA9DwagjL0?=
 =?us-ascii?Q?mQXtRnKZtXrNAADXhISM5MLsj+78K4F70G2Xrmw7rgeqZ+JWqUOmDOjZqQzF?=
 =?us-ascii?Q?pkDXTyRp2+oIHmsB7KG6HyROapbnIoLLBmJ5JuC8BwEkHIxp4IT1WywJk/oc?=
 =?us-ascii?Q?6WQDNJ6QucaDRYtBnhiTLbwcSP/ThixVpdEtyCIj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8108af12-f642-4581-c48c-08dcf8c8f677
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:55:19.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1lXNS+ETTV50gISGmv7qGA1bf4vsTJanTBRF+JZTqFUTCQ5GUgNZARl6mzXqqyPP419A+EaVVhvVTP3HX9RPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

Compile enetc_pf_common.c as a standalone module to allow shared usage
between ENETC v1 and v4 PF drivers. Add struct enetc_pf_ops to register
different hardware operation interfaces for both ENETC v1 and v4 PF
drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v6:
1. remove enetc_pf_ops_register()
2. do not check enetc_pf_ops::set_si_primary_mac() and
enetc_pf_ops::get_si_primary_mac(), because both enetc v1 and v4 drivers
supports them
3. add enetc_get_si_hw_addr()
4. add dev_err() message if pf->ops->create_pcs() is NULL
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  9 ++++
 drivers/net/ethernet/freescale/enetc/Makefile |  5 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 26 ++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf.h   | 12 +++++
 .../freescale/enetc/enetc_pf_common.c         | 50 +++++++++++++++----
 .../freescale/enetc/enetc_pf_common.h         |  3 --
 6 files changed, 89 insertions(+), 16 deletions(-)

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
index 36fc93725309..1ff9a7a3386c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -12,7 +12,7 @@
 
 #define ENETC_DRV_NAME_STR "ENETC PF driver"
 
-void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
+static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 {
 	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
 	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
@@ -21,8 +21,8 @@ void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 	put_unaligned_le16(lower, addr + 4);
 }
 
-void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-				   const u8 *addr)
+static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+					  const u8 *addr)
 {
 	u32 upper = get_unaligned_le32(addr);
 	u16 lower = get_unaligned_le16(addr + 4);
@@ -31,6 +31,17 @@ void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
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
@@ -971,6 +982,14 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
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
@@ -998,6 +1017,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	pf = enetc_si_priv(si);
 	pf->si = si;
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
+	pf->ops = &enetc_pf_ops;
 
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index c26bd66e4597..53d20752aacf 100644
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
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 925011b16563..e95252e898ae 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -4,29 +4,44 @@
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
-#include <linux/pcs-lynx.h>
 
 #include "enetc_pf_common.h"
 
+static void enetc_set_si_hw_addr(struct enetc_pf *pf, int si,
+				 const u8 *mac_addr)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	pf->ops->set_si_primary_mac(hw, si, mac_addr);
+}
+
+static void enetc_get_si_hw_addr(struct enetc_pf *pf, int si, u8 *mac_addr)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	pf->ops->get_si_primary_mac(hw, si, mac_addr);
+}
+
 int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct sockaddr *saddr = addr;
 
 	if (!is_valid_ether_addr(saddr->sa_data))
 		return -EADDRNOTAVAIL;
 
 	eth_hw_addr_set(ndev, saddr->sa_data);
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
+	enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
 
 static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 				   int si)
 {
 	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_hw *hw = &pf->si->hw;
 	u8 mac_addr[ETH_ALEN] = { 0 };
 	int err;
 
@@ -39,7 +54,7 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 
 	/* (2) bootloader supplied MAC address */
 	if (is_zero_ether_addr(mac_addr))
-		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
+		enetc_get_si_hw_addr(pf, si, mac_addr);
 
 	/* (3) choose a random one */
 	if (is_zero_ether_addr(mac_addr)) {
@@ -48,7 +63,7 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 			 si, mac_addr);
 	}
 
-	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
+	enetc_set_si_hw_addr(pf, si, mac_addr);
 
 	return 0;
 }
@@ -70,11 +85,13 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
 
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
@@ -107,7 +124,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_NDO_XMIT_SG;
 
-	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
+	if (si->hw_features & ENETC_SI_F_PSFP && pf->ops->enable_psfp &&
+	    !pf->ops->enable_psfp(priv)) {
 		priv->active_offloads |= ENETC_F_QCI;
 		ndev->features |= NETIF_F_HW_TC;
 		ndev->hw_features |= NETIF_F_HW_TC;
@@ -116,6 +134,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
+EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
 
 static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 {
@@ -162,6 +181,12 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 	struct mii_bus *bus;
 	int err;
 
+	if (!pf->ops->create_pcs) {
+		dev_err(dev, "Creating PCS is not supported\n");
+
+		return -EOPNOTSUPP;
+	}
+
 	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
 	if (!bus)
 		return -ENOMEM;
@@ -184,7 +209,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 		goto free_mdio_bus;
 	}
 
-	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
+	phylink_pcs = pf->ops->create_pcs(pf, bus);
 	if (IS_ERR(phylink_pcs)) {
 		err = PTR_ERR(phylink_pcs);
 		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
@@ -205,8 +230,8 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 
 static void enetc_imdio_remove(struct enetc_pf *pf)
 {
-	if (pf->pcs)
-		lynx_pcs_destroy(pf->pcs);
+	if (pf->pcs && pf->ops->destroy_pcs)
+		pf->ops->destroy_pcs(pf->pcs);
 
 	if (pf->imdio) {
 		mdiobus_unregister(pf->imdio);
@@ -246,12 +271,14 @@ int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
 
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
@@ -288,8 +315,13 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 
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
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 2ae9c87c8c8a..964d4f53806b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -3,9 +3,6 @@
 
 #include "enetc_pf.h"
 
-void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
-void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-				   const u8 *addr);
 int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
 int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
-- 
2.34.1


