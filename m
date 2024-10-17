Return-Path: <linux-pci+bounces-14742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA1A9A1C5F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E468B23EB7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC631D6DA9;
	Thu, 17 Oct 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NhXSE5vM"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85A1D6DA5;
	Thu, 17 Oct 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152143; cv=fail; b=J4HcoUACwg8smsm+jMec2AOeVN+CIRqyJdla2Vxn1NWm59PIHMmE2FyTMefOlfbj9wBxatknTFvC2OUvmlwvYuPWr/mRT5cDMXtfNln31HAe9OE+/3K+7so3AG9LUbnLyTJ0N6HFhhtPHM6RDXo4bWYkHAOLhJWhTu4Kg6sceKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152143; c=relaxed/simple;
	bh=JrplRBNrTea6jah/04Jq/jP5bBCkdXQmaTYMRS3A3yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wc1AwxI/1CybTLOTae7EZ6FFrH4uKIOKL4IrnEK7gFiz0pSuwdu5GvKXDfh6RPzZ4Usy2oLA2OPbSvRo6uUQa/kGYHqOFfTMvcHKAeqjluZVUl6EsRUq7pbL0xtO9k/LttV21JGXkbyv60Ys5WXP7QZAwLBoDS0UudGxJvkJb08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NhXSE5vM; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEq8fNhH9bKVhrmUoVjVkL1x+lLMWEQi5KClRrJlaWYAxeD8aPq4zFZ8pq0pVYZQcUyLmJWGBZPAtYGjTRg6TRsYtafw+TVH+936ZmTk/7+T8vcJUXj2Dkz+uUZwWLJTQ4v1xJCiNPR8JVGUyWMgJVULv1XE4zDqKSPtpwXqucFOdU+NH6Nz4KU5llH8GGte2TUV7aGIRIF8O8My1CzRGJJ1P+tAz7BiOPw9BPcMAoYBBWAZSpRz/GpbgAjRHmdsq57gDiz0+wpMDR/lytOFRT7N3l8wgEqp+M7/qTnWBjJe3/yBpAl5cfVnjRx6NHn4+fGd9GGUMh3IHATi5gMd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKZG82240EbaAZwBMHCI+vY9zVTa4ZN5oyZI5NQiktc=;
 b=R7AJ2uLSufNorXBRWhzMJxOFIqKmq9G+8rCNQccLgCQQf60WzgrRfbBYOb92+44+DfLPtHd+8psY4jgAmPT9MWE8Ew/70N5FASB+aKz0WBIQ/tEvFw4AzcVihsBdX/JLnZTHIe3Afjh9eG5kJNMsObSSrgxByxrOtjY4+uU4ebffX0hkYt4vfnVXDaqnXKgmajTcekLGMWQl5WLS7Ht7ETUgZDdjj9o/JOXfXmBtuzdYZKbXqbYuz8BQOKy+fyL738f3IGyCfcH4qW32oLVmW6ex8AiBkRZ7dY2JOKtaTZttyxpASouwpTk471Vmu0I1FKZrc/gedmbVEkQzeNL4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKZG82240EbaAZwBMHCI+vY9zVTa4ZN5oyZI5NQiktc=;
 b=NhXSE5vMxd+3Um/5FgtbZLq/hjP38nq5i+0WC0FM9rSPL1wjgL3h+TwfmRISVmzrMx8orqd6iag6eKrwM6gpfJQDq/MSaArXSOJEKsH5eCi22nWw26CGQtMhG9HZKJERwZoNf11B5AKs7WNUuygTRsvlyfBozENu6hEedvgSF9s8+pv1SOKDoYQ40tVwWDRkWv4ya4v5GjcZLIQsYv07NJeep49WdkXp6iG/HV3LskMVis11q91lFos8ZAW2UtJnOzJ5A5toaT1LOUfbABhSQ9ScQKUWXcCoiCJjYI28dalcBRuToQ4FnqSD5eYviqMyrUtl26wilQoi1o17yOoSKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:02:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:02:15 +0000
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
Subject: [PATCH v3 net-next 05/13] net: enetc: extract common ENETC PF parts for LS1028A and i.MX95 platforms
Date: Thu, 17 Oct 2024 15:46:29 +0800
Message-Id: <20241017074637.1265584-6-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37ebb29b-4720-49f6-71f7-08dcee820362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N2szdv7zAsbyoNuKN/KErSh3sU8q5DgxUo1mAOHshnUCS7DeyrULsOf6WIBk?=
 =?us-ascii?Q?+vXYBwtYRdkc9IhTIk8Z281QA6T3caY36nBLHA35nT0HO83DuW/zU9Czw+UF?=
 =?us-ascii?Q?mT1E6YTgJEP64bQBS6cWYe7LxeEhJ6cT6pHlWpAbuXXj5ybZtl0MZyRTsivj?=
 =?us-ascii?Q?ueVclWqQhoT6+BaJeN2CWXQP80BtExNYj85IjMNM3UEjk8rCcx/UnwGKFWw+?=
 =?us-ascii?Q?pZrdeDBQbmITn3dhEeqIfTw2MRHct4KrlMzkp1KfE59jU2A3ttO9RhV9ODpc?=
 =?us-ascii?Q?XI0C71Cy0KggPntmD4NBrJRwvgdbPhTyDOiJwq3nB9/TpMgVTTAwBrShHW+A?=
 =?us-ascii?Q?HMLIXp9XoC4mAuCZEgFuuKuzXykCYoHLH9zWi7LLqNc/xRZzNFnIlqYbA2W6?=
 =?us-ascii?Q?BpJOZhrX4MLboaLcv458c9MJMYGSVOHADz6Eh2KwtMljlhBRHdO0v9YOCVhR?=
 =?us-ascii?Q?75CY02pVSq7Ci51Bj60gtPUVqq3/AMEk98K+tAP44j8i+ycvN8x1Y6IoiAYt?=
 =?us-ascii?Q?PptqG2dAelS/Gkyyb3VQXd+y8GEs9aSleglLOZF7wXUAKSMWeiqk1VGecV9V?=
 =?us-ascii?Q?5iYADXNUFx25z52Jzi8pHWgdV+SFFq26T/EwQNsySLLx9SYsdfoQxk4c2H5y?=
 =?us-ascii?Q?kD/xinLhdaku4fWP5em3szXJ+Pk91u4K+qyV+rPM4kl0oCULVLzDsRKktYQQ?=
 =?us-ascii?Q?cPCvt+pouB5d8++WD7oFl58iYDMXOdLLw75Xq7jE2gRomJHxoK1JYydjXD/D?=
 =?us-ascii?Q?kGb0a9AoOiEcFPdVIvCcILl9jpwxIS75ZPPWzNTmuAbAv9frI3aOddmWq9Uh?=
 =?us-ascii?Q?bh45Y6lPayyoDDmbtFw9psQ3eweQlsxtBqH1auZgTF7DAFfneQH3K7VYg5Np?=
 =?us-ascii?Q?r1VQGs2wHIiMNgUCil8jajY7EAySkWnVBqTzpTfnbWXYi0JyhbW4BEdyuqL4?=
 =?us-ascii?Q?SUKoLHCdZU/YVQhordZ34GPyOS/xMiweMQuR6zsXmpJkuXfCwFAbfj+mATG4?=
 =?us-ascii?Q?n4DzAo3PtpQ1K5qLJJvVk4Qxb/zRz39sNmkZ22e73j8XcAGDLM6zu5Z9z1jv?=
 =?us-ascii?Q?mYN8QixZy2KNHrb0XnrCmTQckrrsR4+GxoCVUkAjFDIlATZSnbQOtGpREvXN?=
 =?us-ascii?Q?RSxC0Qw16LLZEw2ZhgS/MLjFJ4TodBdiUz+uMYUFiYfLBO92LRbVpnF3gWwS?=
 =?us-ascii?Q?6QEAvIkAK1VnUUKzxT7TlWGMG/CWtq6yhcohjjdl28uAoQe7fTVHiKFKOzi9?=
 =?us-ascii?Q?UCenJtHNh5jWzYkbr2z/eA8SUO1+XQK5txKWz3Msbm6CLxyL8Enx6Zrb+ZCJ?=
 =?us-ascii?Q?AKVSAU5HIT6bl2gt8ZQYzTNfE15JNHDFTBN+xL80RE7PjiztC9UvI4vz/nfk?=
 =?us-ascii?Q?lj16he0/2FFegsKAOftCRvBHIO8K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2N6mh1vryb7/vCcMNEwlmHyhvciOb5gTiI7w+VPOZeZFA/qAzHrGaM6WB5HE?=
 =?us-ascii?Q?gj/nH7GPBhLZvm/4viYWpay7vDxtiEIJr0odNVe76bIYyOmwiXOciF2ZWGca?=
 =?us-ascii?Q?N04uAvfoY9Y5I9uVVEHTWOwQXKNCr8HK4CW6T3a2gE/Qt4EErfcKtTRpb9DU?=
 =?us-ascii?Q?hZYPbv4/c9hkMPJn0q45WlUwdypaSuHZ7sq2k7NoQTtQeEI8OqrXoaUf9Kp0?=
 =?us-ascii?Q?VxNjJbDwQmgzTeLlAPjxj7PmkJzJrJ6V1Xql8fx+JyBqjygBhTuqSurwKDMc?=
 =?us-ascii?Q?AkBof3y6S4W+D027s73Avo6ALmNE2wZ9yE3ADE4KX0z+kfE19K2C/GKt0YKp?=
 =?us-ascii?Q?RH3RqJI+e8AFsfD5mBsXpMJIaNMOutse3BfCnOGABlS10AX5JY1ddtaN6ino?=
 =?us-ascii?Q?tJDdnH8lqPlRH03OHWxvNnLZwM6EdRtZ7ZiYvv8+3lN2HVdpaORmjdd3NFbL?=
 =?us-ascii?Q?RwUbtQL8RmIp5QjaC5qGHGTDCF9zlkfFhvaZkBAxcaNKi4lQbzAGvdXP1kWO?=
 =?us-ascii?Q?L5Ltp0q9MCy38kssmc/TFa4Z6iZwure/wgrOU+yJvZh9kYZ+t2kxsTGkMVrS?=
 =?us-ascii?Q?L+b0MVX5mCZIjm6Yc/yP37GRZFtGvGFjfe7KuFmhA585ZFPSP2sYdm8tKd5O?=
 =?us-ascii?Q?McTGOxDekQ0BrALknpq9d2W+Vx3hDljFu78AgWgFDDPy6GmqojErW/fmJ4b8?=
 =?us-ascii?Q?IeAAmtbC6Dch48E5sIL6GAr3845A6xHetBgSU72o+h1QWHzA0dlTrKzdYAeI?=
 =?us-ascii?Q?xnHvZJaRxvocVlGHhir2mlHgPZxAG4VofeTaaP0uCmbJpUH5GBIfMF4wUeJW?=
 =?us-ascii?Q?qcDwtFiVGzOjHFO6pnwoPf2cKMHX5/KI+x1c0YJgWyAFNWe7sS35tWzUUf0O?=
 =?us-ascii?Q?PvN+ZC3jkERcYsxFlDjPhQmM2iUpJAai/jwXuW9iabAlJtEBQFoqAIZXzFLK?=
 =?us-ascii?Q?hooqhEjlo55JdwBYWsH3E0PpdOm2oOWpVF2AnnyUxjxkuBJfnXcqTgaYpXet?=
 =?us-ascii?Q?XMekA/b73yFmoznwpOld7FgEfw8G6IiWUU2bJ/kEs5GQzpTZF2NxC+GPDvtl?=
 =?us-ascii?Q?w/naueSACPFc9d8l8GK+9KpFeQtgw0E96ZOm+l0ME8VdpSgn+9mY8TXvvLKR?=
 =?us-ascii?Q?o340c6Q9+1fUmxU36TCfp4sPdS18D0utB49FHfKDUkcsLfIOnGgKMExajFrV?=
 =?us-ascii?Q?hnIev6dCkkiRsbRjcMVmE2zSzvDlgTMOFLb9KccIYlg6S9NrpXIa5hhdWvSY?=
 =?us-ascii?Q?rP1YMAKiivJC5kD47PrwLaZmpqHxP9ALkUYERKDEYkEG86dqvSasm8y++689?=
 =?us-ascii?Q?HnLnDvPUi/MqOg3gAw/k6V1f+43R6dtgXNW4aasEKGlNG8Rxoo/G5uu27v86?=
 =?us-ascii?Q?OHUpzlxAEgemFqvbb8owOmyWb5sagVbZsneOn25thtvI1FKg9LRkk5uQIdjj?=
 =?us-ascii?Q?Ki47KzP8yu7nYYt2WDfeEC+2OEf3ycLfh0Jo2dd8Sw5Y58ighfXj07TGycZi?=
 =?us-ascii?Q?Umqxtm9/Xaq3pp6u5EldFg4pd3e629XOnnByqrhtvKwfPPgQT1V79WfXuvRT?=
 =?us-ascii?Q?JkduiDSATeSnxDNQ+J9QSzCe2wstGD/DVOsmEJgv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ebb29b-4720-49f6-71f7-08dcee820362
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:02:15.5375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VO4bMD3L+xbUjv9860tJrhrhXnh2V7XJmIbhBoPsf4yqWyP6EQSh++y6Rv0RyaiWq4ib6bnZ1I1PQswkmjrmPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

The ENETC PF driver of LS1028A (rev 1.0) is incompatible with the version
used on the i.MX95 platform (rev 4.1), except for the station interface
(SI) part. To reduce code redundancy and prepare for a new driver for rev
4.1 and later, extract shared interfaces from enetc_pf.c and move them to
enetc_pf_common.c. This refactoring lays the groundwork for compiling
enetc_pf_common.c into a shared driver for both platforms' PF drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
driver support"), it just moved some common functions from enetc_pf.c to
enetc_pf_common.c.
v3 changes:
Change the title and refactor the commit message.
---
 drivers/net/ethernet/freescale/enetc/Makefile |   2 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 297 +-----------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  13 +
 .../freescale/enetc/enetc_pf_common.c         | 295 +++++++++++++++++
 4 files changed, 313 insertions(+), 294 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 5c277910d538..39675e9ff39d 100644
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


