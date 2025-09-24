Return-Path: <linux-pci+bounces-36835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84209B98834
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 09:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F122F4A51F6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 07:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93109275AE6;
	Wed, 24 Sep 2025 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z6IUKZnm"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827122765D4;
	Wed, 24 Sep 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698646; cv=fail; b=N76YdSL7UiX9gEOkJNnubfiB7C09hE3b8zAK5z+SiGDO2cTyHteeoBgXT68nnBTmrNQxqB98CAyHt1DREHFkeFuKGxiGYW+d1t8NGJLoYzdPF/DIVYLbyBqtFbIVJPcMmW3rPe0T8w/Jrzwj+me4UZVZaREoUAif49rN+exRdo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698646; c=relaxed/simple;
	bh=w2n8ksJIaP0fhqG03nhWey9GFp93qgqDxQ0roMEHdF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGN/P6J+vHWdoeGbFU3rSIvjiXJy4DCyoDRc9jCsqxHsepmcgscluJmitavVwAIofAIIUINARqSNHmHw1URabi73J+CiLbb/ST4Jq90hwDribvtRXGZaRlStwsMd7VG7TSxGQvyRNQM5nBTgtd+sCjVxCnxrOT3ddxB7bhQpA+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z6IUKZnm; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqR3hHdi4REhsiA0DRLAAR72MbuRzmzAnJECu4NuP+tHLUvmv+h3z0sImD9yInMFJIz9YezbUPPEESLcPtXDJiwz2qAcM0Gb+MbOkEbn4d6yefJUpUWcgWC/nQA/0iiWnGesrUY9lIVEMVjUTyJ3Kpt3F3uvpPH2R5WDEdebx76pUjMJjx5YTB9y3q+58DQ72cOn4R77RBnWm/IBwqp1u6LvHzd7x0I9R7LEnN0qQQ9Pz4w2iHdIfG4g7d85PsogIJWYreidWd4XzESyHtRCuubH+kBaQ2kbd/aZRbOWBY8DSv38XWzP22N8RCVRayv3Q445D6U2eWR1fYxSoy2xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8M5LuVs5p+JSSG/ML4HHpQPLvl2gRSCJw8ohmYY9KM=;
 b=Nz/C1ziZk9WTYGixkI+C6pk4t3ga87DbtMGR4LBHlRgXczo8oRGCakN7GItKZrbjdzYv96hBVC9oDDNKlWd7a0FSNOyBBlIK7Vho4Il7ZLzjPk5OhCh1qDgUSMudJQYcHeQWtYbGyWn4YL/C5h2TshtXiV0djlpti4ngLPO4rkiuetqBCOgEjMXdF7Qfr2uWjoLqB1dBCa+BHCDSR5HmE1HlX8SvazAf6HxT1nUO/7eK81sCJzPI53Ap5Ps3rDglnKS8afvO3n3wxxUo3unegnY2I6vINQDO+fs9IjefUqrdalZ0ulVAMFNW6C+P6ZH98NHUI8yFFolXmD8PspYkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8M5LuVs5p+JSSG/ML4HHpQPLvl2gRSCJw8ohmYY9KM=;
 b=Z6IUKZnmA3k+jBq741J1ZOdgqALaC6U2qrCfL+eJ2L8LTNkFwqhvo0qR2TqSevIVldpn4wcRYEfcUafSjRUCvUIiih4HL9WGw36AwnN0aJt8r0wFxF5Jl326zH6rCAaNzk0OiK2oCApRRW+wOpAqdreqWNJKOI4lyNZCNuiKpby9GAm9ztPcnBnqO3P4zJbTqlvuQ+cJ6ymHLra2cX1dzxPbGRSVjeU7s+m82ovY9sRDr4DNLW8vuM3VHXcNm1WHrdTGgNVq1Osc+1KbkWfX83OBLHduzRpzoWNZwanM64Ss+Xrumrt1Bni1Bh/kwHk0mFRuzbTDrBlyJEOBzvV8HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 07:24:01 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 07:24:01 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 2/4] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is existing in suspend
Date: Wed, 24 Sep 2025 15:23:22 +0800
Message-Id: <20250924072324.3046687-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250924072324.3046687-1-hongxing.zhu@nxp.com>
References: <20250924072324.3046687-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d882ea-19c9-479b-9e5f-08ddfb3b553f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bn8LH+ATBXxX6H0ScENSOEcHi5pN70oz31gOdRxeqYDoE5IHvNkMo5qkPRsj?=
 =?us-ascii?Q?jmlk5pB0+4GQ4ykiHqe3PrebHvINIj5/TMF6n8zGQa5nl085v9FqLT8Hzhd6?=
 =?us-ascii?Q?QaafOyFHBTM7wgs2mC9q3FMmI7aNeFSAglaQAENsBstV7dkSQ9JqoCVnpd1p?=
 =?us-ascii?Q?LjLQSqlrN0OtBSandpFzpKfFm3cMBiYfku7cmpMTG5tUPZdevXeMtQw+FQGj?=
 =?us-ascii?Q?NTq5lgSH/QFEwzOvu81DZVNQ8FGX6sJ1L8zPKmTI5PjqNnS92xnUi7VzSIxY?=
 =?us-ascii?Q?W9JDj+qiw3eIPzZT7Jutdg7wXK/wJ+9cYjbHF+I3mm1Y79inTCORPD+vJzKZ?=
 =?us-ascii?Q?I3T+eGIOa/PTvh7zzsnFGdye0UKfEcq2lNK0NkyICh+yy5WdItCHPXkFgFwO?=
 =?us-ascii?Q?DpgmuNdlzxha2HDKFStKmgLibCkrqj6MOi4XpW8XJtxyX9uDwFkSTINmvOZc?=
 =?us-ascii?Q?7gGnkyun2WQGwApk7GjuzEQKN28hHJXTEUkVue3zVDsohKnPdOZe3jgAQeLx?=
 =?us-ascii?Q?STwjMVojzPzXID4ygOqrLOADOYUyj7M4FUI5Q4eVg4k9x8zKXlJXunek/J0K?=
 =?us-ascii?Q?7adT/vHa7tqD/Q5un60UNp/q6GUfuRzH0aDK4BpEoAX8HWVo6uiHUf7iiTH6?=
 =?us-ascii?Q?E5k/Nk4yvM6gFOQou4HGZ11sysEVh7dA1DzwU+kaK1AQi5308tasLy68xIBM?=
 =?us-ascii?Q?/20KP2q6HB6gCgw/6lm+CDKTdHEBDwh0UkBBaAqqh0NRYsigndUKEd4dtOiw?=
 =?us-ascii?Q?u6vRNOV1NxAfgtr+eKVeFLgUPG4cmFax/Ewe9NLHuXIkor0PUTjxgZxL5aCz?=
 =?us-ascii?Q?KjuB38OoAbn0TG3hf1DfCs4Mo/YVmkL0qJW38FLni1us/GsVErWVRmqQStNv?=
 =?us-ascii?Q?+Ml5Agc3XiVPC4oE0E28wT+6E47doFKFzfJ9UAZ8XxKerinrY3atjOgMb4Gy?=
 =?us-ascii?Q?KEW43kN5ZLcGmDGEia/xD5qBVmbuOT6I0ZmBW8wbpQZK5VzOTWsuAQAW62ZU?=
 =?us-ascii?Q?pvjuTGT+ZX7zR8r7LCpQFvuw3RxQGhu/Sc6kP26lPhvIq/zwnV1NJAM3yiaP?=
 =?us-ascii?Q?TCImrkdDzFdEH1lTyjuLyO/KmkuOsI1riVnNRDSlB3DbTsIxn11EJYUS7XSg?=
 =?us-ascii?Q?o3i7WxgkJA+f9KuA3oAW08UqftoFKrxjgHrW3EBtsPE4uWBTrFLguJtMCO8C?=
 =?us-ascii?Q?3dbl2BUGi6mK3yYWAGwBRoVN8EP7qT2+ZPT2msyXbXPW0UPOfahbrJAboPNw?=
 =?us-ascii?Q?4yMiMf2odFtboL3uQi5jrmsvA/aSndbeJvc0pGNTXRqnp/Y6uZeQAJvSf/ct?=
 =?us-ascii?Q?VtfQw9TeUCy1GkhIGKQ1Wt+B1rSJNu2lTTUMvb+hyKlNipJDnHeyD9CHiDzu?=
 =?us-ascii?Q?onUd8H64uYkrUUSB5FQ1WaFtQROFf0EpDLiuAZ/Sr0OkTqaR6sNeiimL9E6p?=
 =?us-ascii?Q?Jz6KY7KN8Y7HxiwMEShXhJ9vO8YF7a+eO18eiorV0tj9VPElr6Fsl/PBtw8e?=
 =?us-ascii?Q?AEeWmXfo7sFg+A4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fpunF2X5PzxvxgdEt+q8Hnrdd0bP4GE1GCh09OLJD26J3csfm1KJ4trbk3To?=
 =?us-ascii?Q?rsh8FPb0EULE7rzoK/0Vd8+gZRooqJZ6hxvg7xSZVNBkgxT8aQcCDYTZ4cgf?=
 =?us-ascii?Q?d+q+SMdXKKsXuw6zqDp3ZjpekQ7MV40/mSAzYxMZY8xo3QPlpEw43yIEsMCB?=
 =?us-ascii?Q?+3n0qzkKxgmhpCvssDy/iWM3pmEL5hZlDLxe3lYpU/XlmwvpqJ0eZ+8tK1bp?=
 =?us-ascii?Q?BMolaViADAoTroJYV3vQ1dSCnnLEOs4DN7egfhd3j/UwCx75nfA4nH2N1ZMV?=
 =?us-ascii?Q?WPLCx2FMOISgp6yEjEEH7z3y44Qc+CcZa4jfpUfxRS5i9xTZat7PHlHS+ZZE?=
 =?us-ascii?Q?e9BMB6nhnen9EOGIp7z4ILcFGMVpIURKvXK4X9V/vcrq3l9K69IB0kiglUx0?=
 =?us-ascii?Q?jxPrRw8em0T2kOehhsjMBsrMeyvhYheLJc3/QgYnO/a/laXxwQhJVRXzw8Kr?=
 =?us-ascii?Q?Q1cMighs1ld+GlBDsh9M6v+BgJ5A982ZenwO5UitySil5H6bgRvI5XZzGF8Y?=
 =?us-ascii?Q?zOXBg53Ld48BH2LuE3otp3zwvAIaei9wFVIE6z5XpUm6YbHNlrEXFwN8/1Ge?=
 =?us-ascii?Q?rMcSvtq2+jzZ1Yu9856S4rhAdqyLQIGlbsuF2QMqFZwl1LGJA+8H7RZCU4s2?=
 =?us-ascii?Q?8YVluKdk7dJ6L+Yog1Hkri65cR1sUgJVBaZKHMLHtk9pDSoz20/fHW7I+1AN?=
 =?us-ascii?Q?2pEspbYhJNFa9Aj8PZQLZGStoWFaOTh/YwnOff4VcsUvhkxT1EAQgAAeQWRG?=
 =?us-ascii?Q?twyWeLuQSHHvdCs71zqTEFyxTiBENdNmTP0MqEj6jDscubzAn8qOT6Y3kPmN?=
 =?us-ascii?Q?YqlX3AAOkKGiNirir+d3XHHfixnWZXpu+tI579J/a9kDzoc9d0oFwuWhiMsU?=
 =?us-ascii?Q?J5BhNRW2FwhWZ3kMVYgBW9aQmWRdEdmjYbyxp/KFoe81WF+bgTAxllqyHNfH?=
 =?us-ascii?Q?PkzN3mGVETJXut7nrdxBSSoiKKAuPnqophZQfEmZJ56va4+8iNx2ihk+/ltq?=
 =?us-ascii?Q?vT43czkTWZfgjGJhejhJPkrl5S4+w5DmrZCeydAb7twhJ/wjhzUrCpKlDpT9?=
 =?us-ascii?Q?csBDD+ZtDkCJA1u6yIPmgIab7ZeT1BZgR4VJD64GrUAZeqyYLOMVut/g4Giv?=
 =?us-ascii?Q?W9yvREUvzG/Gdw2xrRAO/OHEPFAbWCM759FLsWZWEXdJqtrW1THOADMQyhcf?=
 =?us-ascii?Q?Ak/4SzC6MUUCp0s71VMJ1p2Bh9Sp+PFcQeqDo74rpDkuBl/DIi2wTpGeljys?=
 =?us-ascii?Q?og3SVhwd6y2Bd8PwspexOFsTg6WgL++PNzWuJVCr23eo5PbcYKnJ49heOF5W?=
 =?us-ascii?Q?orH9Xg74/1DSaEe8FmxTNAF/hzqN7eCXaCFi+brTdF0g+abx3xwwTuXT50oi?=
 =?us-ascii?Q?wBwNBB+F1BCqyPsZn1G69Vq6wUYUUcBswuMoUrejqXoGtEUzsRg3njcRenu+?=
 =?us-ascii?Q?6FCu8AoyqEnyMQ8Y4IjZJt1fLxQ8VmChKYMnIXteq/7kUUh4EEtxBxbSJRdF?=
 =?us-ascii?Q?v4XbQQzLiuG5pHao1HDmhWA4mYopvhDiaqQwDeGG3ekH6b3N/RuUaMFMXe7V?=
 =?us-ascii?Q?tsXMZjn7WCItQTeCZ6ViPS8chBBgl4rXD0o8q+PZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d882ea-19c9-479b-9e5f-08ddfb3b553f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:24:01.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QtpIn8awK9tx7S6YDfvSkok9F23X0sW7f4VukUJMYHI60sDZHXwIrGP9LwROTFDRaAKwgpjUK2g8OlECJ6hTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
PME_Turn_Off is sent out.

To support this case, don't poll L2 state and apply a simple delay of
PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the QUIRK_NOL2POLL_IN_PM flag is set
in suspend.

Cc: stable@vger.kernel.org
Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c         |  4 +++
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..a59b5282c3cc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -125,6 +125,7 @@ struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
+	u32 quirk;
 	int dbi_length;
 	const char *gpr;
 	const u32 ltssm_off;
@@ -1765,6 +1766,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->quirk_flag = imx_pcie->drvdata->quirk;
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
@@ -1849,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1860,6 +1863,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 		.core_reset = imx7d_pcie_core_reset,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9d46d1f0334b..57a1ba08c427 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1016,15 +1016,29 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 			return ret;
 	}
 
-	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
-				val == DW_PCIE_LTSSM_L2_IDLE ||
-				val <= DW_PCIE_LTSSM_DETECT_WAIT,
-				PCIE_PME_TO_L2_TIMEOUT_US/10,
-				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-	if (ret) {
-		/* Only log message when LTSSM isn't in DETECT or POLL */
-		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-		return ret;
+	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
+		/*
+		 * Add the QUIRK_NOL2_POLL_IN_PM case to avoid the read hang,
+		 * when LTSSM is not powered in L2/L3/LDn properly.
+		 *
+		 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
+		 * State Flow Diagram. Both L0 and L2/L3 Ready can be
+		 * transferred to LDn directly. On the LTSSM states poll broken
+		 * platforms, add a max 10ms delay refer to PCIe r6.0,
+		 * sec 5.3.3.2.1 PME Synchronization.
+		 */
+		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
+	} else {
+		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+					val == DW_PCIE_LTSSM_L2_IDLE ||
+					val <= DW_PCIE_LTSSM_DETECT_WAIT,
+					PCIE_PME_TO_L2_TIMEOUT_US/10,
+					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+		if (ret) {
+			/* Only log message when LTSSM isn't in DETECT or POLL */
+			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+			return ret;
+		}
 	}
 
 	/*
@@ -1040,7 +1054,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 
 	pci->suspended = true;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcd..4e5bf6cb6ce8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -295,6 +295,9 @@
 /* Default eDMA LLP memory size */
 #define DMA_LLP_MEM_SIZE		PAGE_SIZE
 
+#define QUIRK_NOL2POLL_IN_PM		BIT(0)
+#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
+
 struct dw_pcie;
 struct dw_pcie_rp;
 struct dw_pcie_ep;
@@ -504,6 +507,7 @@ struct dw_pcie {
 	const struct dw_pcie_ops *ops;
 	u32			version;
 	u32			type;
+	u32			quirk_flag;
 	unsigned long		caps;
 	int			num_lanes;
 	int			max_link_speed;
-- 
2.37.1


