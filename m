Return-Path: <linux-pci+bounces-38112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA4BDC438
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6493B67AC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A52D299AAA;
	Wed, 15 Oct 2025 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CKZBxd98"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF629AAE3;
	Wed, 15 Oct 2025 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497526; cv=fail; b=cFK1UcizlseAvo8iv3wF3UeLH9wmrXimF70m013y4BGf6NBRrX22A74/N95UJdZGZY5cAdSoLK8+Y0Nhx/P8FY0qzZNBkQXp8qUtF0kj4rNvmiRpqhdV2yxf/oxDNeECvbgoHXeOMVJRAZAIV5paCqfRSK5cNyPLINlaQHLXGIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497526; c=relaxed/simple;
	bh=fN8mDgm/nP4Z3HpjrCsqMfAlHPOHyL6aa22wUNBKdzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K36xS8lUP31iPqQudU8CRIhpRXhVMx0yTp9xgx+SZ+Pqjo8nXRllK83UjPEAJ3Cpb1AgFcvOfh8UzQhh0u6Rk9S+MkfLq18j126r7PQBoLRgRRTI+X8zZx51HCNDsv4WSgXLdJ8+LF0aqR7t/MKZS6qMkHApwQIiQGg53558B9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CKZBxd98; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IP/gaaeSzEhs9r3iEyeYY6+H/tX1Vx/ZZpwwkoKyDfK/J6hQ8OYunP689Zg/UObHYVQjJlI9I0T0YRdyhZTeDPEjJ5ZT8SSnul+ihWE+ex4Gi54G7Xnw9ESyo7MNCwrFMRGTEGmiCWNvsJRurNuXwoi3OQx3OePavu4JcsdiVMgniHuIz47ak9lyxvl5ETr4dRhZxTJXU4v5Dr3QoDWBo0oV7Oonlb6PpaJnaR1zKP/BvQN+xJ130QMcnI1KBmDITG9/s+EsZlJzagVqCzCdTLtuJ4KrBs9fRVlqVCU/zRmKKuI5TQx1YN2mD7bPVL2y8G3MXH6M24PfcVXJh6+7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqFoeoWwJXj7rYkB0BZG2o29Y2GtQNZdpPRpnN/0Src=;
 b=tHp9cCMVRlmrSGxBvVhWgXGbI+cDmYd/fidBlBTU64A3XOTT2Q+uGx+uK2La7f+oCoycimM2e+BCLpMPPWUoL71j+wRxIDzRJLmyjugtMGqAYztNdl6ZGdEMT7Z/9bOex2/SBAyI+zRytf64ngbROn6ppi5K88SYeB1danmDxOufFDwEAYjMRKHKp9eoN3JZEDUgciiBlimCZApu2ycA1eKCn7c7ci4pXqI161dBAsmtgAbEVw0jqh9ErtzRohdo6NRQjofrS4L4Pa8wIdXmGGdD6rkRrhhvIEvCs5u/0KmN8lxUK3SyHDB/QE6mVcuphICZ3h9z8rFTuVLl/E/+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqFoeoWwJXj7rYkB0BZG2o29Y2GtQNZdpPRpnN/0Src=;
 b=CKZBxd98zme+oIB97s9QuzuQaW0btTnBHywPFiXupGLg5ZLNLT0LvgymSVanzPaa32UmkCLcvND0TtMTD9qIPQYoI4gj4A8Kio5C5Kk/rnjaLzZFR4x65taETf2KaXjUMewb2toTp8cookxgb/PwL+Z+2fLoIlcVAsZIvafZepVisG826DUe3S21Vj8QJBkyPWvk++HzEDxfp5ZykiwHo9Z/qYH6xkaPKeMCtGLS6QdT5rpm5dFTWFe6DR35vWhEGwBsWdf83SfNlMhHBPLFc54A6mKTYeXDuu+vj3Cq/K8i50p4EK8Man4pw1XGcoQyS8bM7d2OSpGg8Dt4sAtX3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 15 Oct
 2025 03:05:20 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:05:19 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v6 03/11] arm64: dts: imx8mm-evk: Add supports-clkreq property to PCIe M.2 port
Date: Wed, 15 Oct 2025 11:04:20 +0800
Message-Id: <20251015030428.2980427-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|VI1PR04MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b5aa2d-b9d2-4f84-a6b5-08de0b97ac6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z3WnBwzCy7XX3GNFI0oIT/5Y85mo3SGCqJZctBw2faFPlogW30lf1MWC0OEo?=
 =?us-ascii?Q?YdHZdJyz5e4vmBsUBvl9DEivw8CtkeRSU4g7yd0ijYxKodjmcxxdqHF3c8me?=
 =?us-ascii?Q?m9GCenfS7huYePuRnFNGT4DWkrxJlKegF87qKDgnwfVSAT+2kyTP0OYGJH4R?=
 =?us-ascii?Q?vfSP+6WZfkfIL8JnYHokyolHVF6UC5HLrzYeCDTprmOVjJ4xzS9HgWhfC93i?=
 =?us-ascii?Q?r6hIuXcqroDLTTc9brLQxsfW2hW6VaN+TWiqP6stGz+jkMCxXBmNIbSoiKo+?=
 =?us-ascii?Q?xHKiXM68arXjWNc+2gaCF0Md9LWcOWOXtWeiVYtqju4i+bo5nGfHo7aRmOvi?=
 =?us-ascii?Q?aGQEkRoKPP6XmoGLM+esynwdvgl79F1dRN7/2M2GGgm1wm1bbnNZoL5fnJPN?=
 =?us-ascii?Q?izt3ckGsI8rVEiUXX33QgtTA1WkA5w+/U9ZYPbNy7ZDvwjRxMUGiOzNTJyZG?=
 =?us-ascii?Q?IyHwZ95TtXoTzSSg/Gstsx0py0E+9m7IQj+z+n/IkPYnlFiwkFYG3bztRQHn?=
 =?us-ascii?Q?/yMco1tPUSn9J1rwi9/e4F0745wmziH31pMwb9Bvw/gHALz4cLXXnQ5nM1eR?=
 =?us-ascii?Q?8Q1rHjZkN+J1Q/AtacGnuJZWFiU/gLEGHgXF20dGL95whbckeP4bh/Minh8J?=
 =?us-ascii?Q?u5I+G8MWyHPqnzNnVG2WXAjVZgROR7vrZSWHZoGYH+JFOj3ZguBDIX6BzSSl?=
 =?us-ascii?Q?QGQLJ4itWU1eK228m7tc5ueJGSXJMDuSQ/fa+tvCpBRUH7c0lpjUBu/FxOdB?=
 =?us-ascii?Q?9fqPJsO99BVbyzeTiN8VI5p93inARlAuc6MgzEA8Iv+c2drnyYNstV8xAoQ1?=
 =?us-ascii?Q?9XpRSqlFrNuoorMqU5sB/Mz4UYwPCvO4/QrrAFOhpJOHpFj4Q3Ocj2BXAZ0Z?=
 =?us-ascii?Q?njxUe7Ai+JBFnGp2D3Ox8zdnajOxrLg0GNTLGAIaWNj72pIjQDrUU2uMhtZc?=
 =?us-ascii?Q?q5JVfhkmh6Dnk81qwzsvX+LLl4ORw885D3xvqN9gDWLKeUXlPV5pBRaBzhGq?=
 =?us-ascii?Q?jkrjWj7FT1n/osnGTpKdR8lLwAJptPibTJYpsLPCHn1tpS7/YFVl7zVzpii6?=
 =?us-ascii?Q?LghttG3/sQcRdoWzZUPV25/eE1MFYfyJigQ5/9lE5k9GTNRRZEDIrBaNJu26?=
 =?us-ascii?Q?SKAdYyRwOTugSNE2xIPjRWpxdLOObNjZdxnyDLnD1IvZtJuR9fytKUefC5S6?=
 =?us-ascii?Q?cQ5uUtxx9NEvft8Wumk2NfsY1iNSvrlaJaB82RstFIEolR5tf1weyRSFGIZX?=
 =?us-ascii?Q?cplSbPCWMoZOyBXfLDTdXdfm3+zWtwS2ISXr7fMl74g8UiifOo/4bRLvSsTM?=
 =?us-ascii?Q?giLut2+ft5U0i1py47x9bSaQwAr63kxar2D+VrgiFoMVfCcNDD4uS2GKkr0T?=
 =?us-ascii?Q?76wMUSCnqZ4/CI5/qJpYjyFwRXgsrKA5DZzikZFTOpjKrBsQj/DhtOT7RY32?=
 =?us-ascii?Q?osYG9J4oidGCx1+DQB5Ugc9KffLjekf1YmRT9NeguNXu5j+fnOap5FWkdPyK?=
 =?us-ascii?Q?GWIcHpkQkUvudHBDH9TgCm//uxlfwla+0lqlOTtHmfmB3CR23iPwK9qXjw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lUADP5d+qYS7LFyWqMw7fYRQMD9xCO17xZyAd15lR3wZKV6AyUh7mQb78AhC?=
 =?us-ascii?Q?cjxEl8zN9i86cjjQ5A8B97oVtjVNlrMzrJlaaAd91U8O3xHSY+6ln7HBa7pN?=
 =?us-ascii?Q?wR1ij1e6/r/+GZ0U8Td4j8bhbrLdeWemvvCMDtUrYjIN/Yp5nruBYgGBpjvN?=
 =?us-ascii?Q?jsLPM/JN4dg9Du9dYDUxr3SdT3P0m3ndz3hqSLfK7JQnpZAAIWE/HOnfvnCo?=
 =?us-ascii?Q?5y9BDABju88+vfSBKfEpTfKfeq3ouNoNxOuJNNM0xVl4D4RynfeRbJeK46kT?=
 =?us-ascii?Q?vGgeD6kODmnCQ8Wm9T0zMhJCSEE11u9zd1hB9JQDyBfnn3qUUkai/IiSyjCf?=
 =?us-ascii?Q?6+bYk90KVfYuDS9zYF5vJXUtK7jYNFUcMYFyLXcnjMpgxJxD4kBSYAk2boX+?=
 =?us-ascii?Q?KDpOdefKCErqDJRORUjRLIAUoz/sXzHpqqHv3pPVdn7qSq1s2cHKiDiRtkBv?=
 =?us-ascii?Q?pUqevZwDTXm9eelhu1Rs+oGlLe2mw/HHHTJs1kIrbMU0jQdH0BvUaR+tN6vk?=
 =?us-ascii?Q?9XcrNBIV2QmGibVklOtV7uVluUH/ES5UxlLNxvvt/pcB8r2fywRBnaIBGs9B?=
 =?us-ascii?Q?MsbVvME95TIgHYhFZRs80XhoqlEt2B5sswnYWDMhiLHHA2MJoTPXGsOCsSQp?=
 =?us-ascii?Q?PSioADaRVT31zXsLxGO4543Yq1FwZgJeJwXH/yXxJG2r4OYl2RfyxMsDsCJc?=
 =?us-ascii?Q?ppUkE3X1NoPcukqfuVZSKnS3SlQGd9cdo6++Uh7yRY9lzKULSZ5VxZvHkHGN?=
 =?us-ascii?Q?ol2gjJa1/YpLRMM9PWtuu3eKmPhLcKd3FRF1xj29N+Ji92PsUxzmbP9jjUSL?=
 =?us-ascii?Q?P4maDV3HGLS5FeLcFE3HzsNa1DvkhlNsTS83ANLXggWJDSs8uMawWjLvx7kh?=
 =?us-ascii?Q?+6UdMvJsfRZBfGDNi93cvaL1Yrr4Hz9gtVR200UQIQ/SlR8CThZqOFcpReWT?=
 =?us-ascii?Q?cLL2BpKHkpefgVbSC0v1NeJfES6CoHOD8RJCRgqScZGEwlCK7WSAIhHC3U1D?=
 =?us-ascii?Q?aX3Hnwhg+RIxx97i+V07gHTE1+enGnrI8UZmZQLIGD/s+q9cXFR8I73zOZiL?=
 =?us-ascii?Q?I/xj2zpfbPqLjvtCe8rNxQ2Dqh1HspwuSMdn3XrJqIDDsBtOB5jHnnEIxMgx?=
 =?us-ascii?Q?VUlTHvRkITI2EATVV6eQF6Ci07p74sx6fQZj4yTRL0nMw1/e0A1OH9aM0/nQ?=
 =?us-ascii?Q?iJqWodra4iy02p4ERLiGbc+HUDY4s65K1zyOeDtAchCGbnTi1MtOTQlNYqk8?=
 =?us-ascii?Q?kDYCNmLTLWbKX6u7AqzVVWjsIqk9XrDbiCjHXpd/tAx0g/gd6v61fW4N35cZ?=
 =?us-ascii?Q?hoHKAnjvnU2QrGup41MJrcULzy9cVDSmkO5ayqUT8OdHM4zrKXg3uRsW+ALb?=
 =?us-ascii?Q?4l/ZrtRdOJ5G2tIFwrlCU9b+7tZjtj3wuLymj3loFuUnscjGIM9sUjetSdjL?=
 =?us-ascii?Q?sostarMaTpC6T7m47auxmGjOAcLIyNtKtkMd7ZpwTbE0cnEMeUnORwF4vq/2?=
 =?us-ascii?Q?DNtxaupTn/J7bQo5k8X5VYANb8RL5byMrC5tQl5jxCjSgXCffWOx2hKyxeRR?=
 =?us-ascii?Q?vEu25wdz4H2PAYp+lOPF7eBBbxhJ56x270Mh4bMF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b5aa2d-b9d2-4f84-a6b5-08de0b97ac6d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:05:19.7127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKfYg3ttLp3buHUAXETOm9a71cKXWfqjkW4x6hQuNM8yMTqXLFCc/CDG67swgPCYyQV1ie6yEK/DaiEr/7JuLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006

According to PCIe r6.1, sec 5.5.1.

The following rules define how the L1.1 and L1.2 substates are entered:
Both the Upstream and Downstream Ports must monitor the logical state of
the CLKREQ# signal.

Typical implement is using open drain, which connect RC's clkreq# to
EP's clkreq# together and pull up clkreq#.

imx8mm-evk matches this requirement, so add supports-clkreq to allow
PCIe device enter ASPM L1 Sub-State.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index ff7ca20752309..6eab8a6001dbf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -542,6 +542,7 @@ &pcie0 {
 	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
 				 <&clk IMX8MM_SYS_PLL2_250M>;
 	vpcie-supply = <&reg_pcie0>;
+	supports-clkreq;
 	status = "okay";
 };
 
-- 
2.37.1


