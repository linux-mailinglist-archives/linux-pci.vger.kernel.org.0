Return-Path: <linux-pci+bounces-17799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6959E5F4E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 21:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141252832A0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8733F22F387;
	Thu,  5 Dec 2024 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y0ALtj6L"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85718FDAA;
	Thu,  5 Dec 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429686; cv=fail; b=PLBCHchhoS+vWDP1alorumSncvS5aGwQ3ttdNa69zO1yy/zNY2bOUYvGM1ceieGYkM0E9FxDGUpnyw4/PKgJ9etPKjbTdNBxkXkegBPLaf+eZJ8tu0VK+6iSGKMCe88LHtN9Gw3yA5Bmt1ExAbPUsuUKVFxQiG+TNaUOVeDlPfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429686; c=relaxed/simple;
	bh=V6LJEqmCuxIOhXTmsMxzcw03HqS58w1NVGrMeaHnwPg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a53v9TEf6cGMBmBjl0ldIi7QThn1Kl+P3soiNp+MdGaFl4ExokcgG9LXwA6ggOLwLREiJKBq8ZeajkEXAP+FyPToxI7GEhUq6GBAbhHHD9/l6nLtqO3tzfCG+DOnCRIuUSvrB2QmoPro2iM5e9FVD3O9KHO6tnxHBwnkFgAQ3uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y0ALtj6L; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqYU3qlj6sXQ+U7EPbSnAVOjzZOEdJQXUZ7YytZUL+QE1zJiYyqTQwzRf+iSe/02G29mcaCL+Tpx/sMDGWKASHVH6nU3cTiqvJdB4zafGL/hyvNos0TORIJkZTQV88tlKPKaM/IOMl2tkd8/O96N4eLMrMK6SapVzVDmoWIZqT9ZeIw/dWIJvrczTZERe3qoHOR9yUALV0pTY8IFvCGLy1YiAPxdCGkiV5er8+/KIx6uswOLW48lwD5jY3Nqwsc48SeJFzL/vRsgbPiKkdHaxmaThZQ4Sgl0/R1ZIBG/BmDB4MoGnjr2G+y8LAj5vGpmdJvXMkruYaROp9yy5hSu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdHrSlGEm91Hs7yL39JUe49NnNhesv00gLm7jpse5qI=;
 b=MLJESEP8NdgHkx7BSr0zEjR9n+axGexvNWwDrl2DxT1HwWUr40+yJP870LUbidfANRT8DAsL9sVLK4Tbqh4RXysBIojhPsTPdCdyv2ZJ5yVItHnQhBYJgjGSqs+lQ7jhSJBN9uR+xgo/u+bywaJYDEGto6ShItcAB1XISztoaR555HwOdJiRHny4X/5ojZmUZ1CmPSyQYD+3R3I+4sEA2/gZuGLcddLvMSzzZhSTQCn+b4bUeBuuzYVzvDmxQHr8LLU7der465ACy3iIb31Nk9HAFoMknZmh3zjt96rvu6D/huuIQzA7wOvAcZJo0axJuZtXRG/bso61cxmEcyF7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdHrSlGEm91Hs7yL39JUe49NnNhesv00gLm7jpse5qI=;
 b=Y0ALtj6LjtH1dvPYusSYV63wfzjXa1n5+il1anIW+M0fZexGQ7BFAC5ue2I8Guj4om8wmtr9L3Wn/maaZJtQC6a34yFX4bQWohd5SDogqhVi71YJXmlnHFUQHfYETqpMfoNFoAYh//TE3edc5Lp1+Ywn8Vmto6XfkbUKNKtHT1PGQdGDArqryZBfsC18MkR600B1/fz8aud2UsnrxV6cmQPYfGul0/Ba7ZguVBij5BNBV3p9uFxeWkNl/nfR36pHm3DmGruugyIWWsTs6AsQ4Vo614mor0yWENaoJ3X8y57/LHWG9J8OHu30n4zlIfi2ScCqGEPUG00fHDtNIVI/CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 20:14:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 20:14:39 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Frank <Li@nxp.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: PCI: mobiveil: convert mobiveil-pcie.txt to yaml format
Date: Thu,  5 Dec 2024 15:14:22 -0500
Message-Id: <20241205201423.3430862-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6fd937-3a16-4a1f-5f0c-08dd156972ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3G/M2sduOvyyz2tMqkh23uZwMZHcUnQd96J4yaK76zZJ7MQyIf6v1iNlSQiZ?=
 =?us-ascii?Q?/fPxrSXHIFqkofDo+MjIGb4IzID5SaNjTRlorXB7A9tz+JNIJ8gy6ZVvHMA6?=
 =?us-ascii?Q?Lp4pyHc6eu/phPq6jJONPpIpA5urR/HuVRG2uexdelLkC2g6jUQxX8+FAe8v?=
 =?us-ascii?Q?5NHr7KY3ZvvqNB9dbTC7h7G8/ktqNDslZmrDa3Gu/M5YM3rM6cXR4Cjb6SHa?=
 =?us-ascii?Q?3MkpCdmc+GVyd1AXzqKfA+/wGp3dWoLWQGe2NZAI5WhFIGdQ9qGN+xWGyKby?=
 =?us-ascii?Q?ZCbv/Sk6eIXeXStzMp0rDEs/fIxiklX5a979eElLYj/MfWWevkhq80ULg1/h?=
 =?us-ascii?Q?A+wM6hs1cGcN371zyWY6k5p3Va3HplgMJ4iPFpabMSgtKneCQMciTN0MFVwY?=
 =?us-ascii?Q?fF55ypAxV4VqDnNRrzhjbzmJ3LQnKI+VGlPDvoYha/cM/P1MCAwiip0e2MV5?=
 =?us-ascii?Q?dOlye9rCZAuSeuBr2fDcC48wK0quhONZhA8egJcG4vmoDRtNBgmYCmHaPZAb?=
 =?us-ascii?Q?4GaSZB0jMPHGjfvCoU8CfcHk0G5DGqhbKTHK+NKFp76uN6OMn8PrEjG3W9Z0?=
 =?us-ascii?Q?5fNmSg8OZYJphdFm37SsPkMHFV+PtdAlrUgGOvgYj1bBt3rpnqV/oKyUbN/D?=
 =?us-ascii?Q?AKI3cfm7mJbcqIhjJWPMbQpk6yP2svdpxfh6OC83CpOFBzL4qvG3dkr6B1aQ?=
 =?us-ascii?Q?Kn240Nu70NjyTuBxhyNTi6ZimZcqewNezrEYTcD3R1/wsAJ6gxh9MeH9i+De?=
 =?us-ascii?Q?dYtzfhSGrOF61g6SLPAWiJIalP9b1zeJcyUrmWTw1zJe0GVLD5ZNpMYysAPy?=
 =?us-ascii?Q?FgIVF0/YOEjlW0kBfadOycQ7MmnB5nrLcKjZI0JoZLAYT7wTuAaA24Mutvyb?=
 =?us-ascii?Q?BDCcHKX1WT4YxAOWn6qE4EjrXpSQ9e4ntA9mYGzmDFTkHaxvEJn7xTv3+Urg?=
 =?us-ascii?Q?vGkm2RVccXnsJ9OAudj4ULNMYn8IIEFwLJH1M5B0qv6E3iaOy61Ytpsmu55H?=
 =?us-ascii?Q?5gJD+BRLkjRhCliPJvC1u2lfrk6wNf+p1fDhOIIkwMPKg98H7SmjS7Y3Vepy?=
 =?us-ascii?Q?BnPd8k66G8uy0ePu+g6mOFd7dsKXhSs26s4yQUpLqN2GctJpM6ZQ+YkyfaUE?=
 =?us-ascii?Q?sk/QSXu2YNS4l0GAe+b4x8heDhl1X3uvoiNT5M/PYUJTPESt8QE1TS1fMdFY?=
 =?us-ascii?Q?72Qn9sHUjV00v6jk5s5sCOEGxejEYW/I1PDGJ9VjnIk26ss21JYDOoi8QQVP?=
 =?us-ascii?Q?N+9G6/pEkbBnxDNUF1ivO18ldq0j8Z77a5vsavQ0R71DWCPs1LeIFqcsr8WY?=
 =?us-ascii?Q?ua52JTfzPqd+GIfKHV84XvnDVfF7wm2OU3QIaOIgip/HfR0C7G9i8Djspm+O?=
 =?us-ascii?Q?+/IJZ4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qk2aXxjD+NxV7bC4qgwGrEXPfj6RNb30XWFvQoLkrlelwwCEhvJDZ36xCygz?=
 =?us-ascii?Q?F2R9XJp4U0EX2FZJHcqfVP63Z7NKoZfXUkuwx119m680+6nNQLMISdereWrS?=
 =?us-ascii?Q?8KdvI26PQNugyh8BV0WS9PnOkMy8pqOC5Fb8LJSVJQP5x0rhWKf4zrP5Wu8h?=
 =?us-ascii?Q?SQURDDCClgL5mGcxcjrWR42bEPOgRQd3o8dY/LeONdiyoS3qS8or9ADH2fFY?=
 =?us-ascii?Q?j4AuniiX0d0h1E+ko39Irzw3UVr3VWhl2/lsnrT5guHkocX6Xiswulc8x8oj?=
 =?us-ascii?Q?iSleQlY32BbBpS/rUagggKqgP/oCxCTa4cvPAIohD2xfqIQMYPEYdG07GQih?=
 =?us-ascii?Q?UAkDAhRvZij7Yv26D7VNyHaRF8zwQSl8swUqp0DLNDAAbImFni6g4RlEkH44?=
 =?us-ascii?Q?eQ6KuGEeLyNvUC+S8YhmD6VIpCCYxK/uUAJJbWnMh0uwgNL024RY4JLDS1bc?=
 =?us-ascii?Q?4yhVqux2Y8mnMQFmxHLP3IdL7dSMKKxz51kP99IxXQW5xf4Ivfs4KmV1lPsB?=
 =?us-ascii?Q?jK8vTNY3jEaqx59ev+Skzne2XYo2yGNXr+AjMJqyIxki2cvHEGK3e2ldlppn?=
 =?us-ascii?Q?KpVibfEkqEsrw+IVSOj5gmIYikVFtPPwJHUZ0lT5ea7GeGnMGDtfFF7+2oKp?=
 =?us-ascii?Q?zIOQ5Y4Vwf1ZMD1WHhHy4QVJYoV038VqO3YsP0NZ4WaccY/fpBvPT0mkAmJw?=
 =?us-ascii?Q?SHB8JolhiYiLdOYQYflYqRAgCXVtbrxy/LNev/623ebeUhR7N6ZOvMtyMz3d?=
 =?us-ascii?Q?4rMvfNeUEyTKj0Z+x4Rw1wA1vu9dv+p9iwuD15KLJgT4GsTCNSaVgmh4jByq?=
 =?us-ascii?Q?+DjGaeSIViLEEq2k/ksLPpJMClVCys4Z04hRHEQJJpp5PEoU0S9bVrqGIP+/?=
 =?us-ascii?Q?8TnxdsHVuzHoEOve0pm8WQNtTdJLUfR+1HkRB4vTvdYakBwcaQWNc7/RSOSk?=
 =?us-ascii?Q?bjXn8UXjedH8UrDh7S/RjIT8jV19OEebpmgDF/VnDp8RqGUOtb9aEEeT71xi?=
 =?us-ascii?Q?Z+xketHn85kdUy+JiB0Pa7zD5OcmOQtlWm7a44pfyXWOlA8wbQO6bcCqk5zM?=
 =?us-ascii?Q?OCQNTApsAPKdo+1fsUZAtmvqCYynxFiu5tqdhOOySM/X58704q6RB3xYSbYC?=
 =?us-ascii?Q?UnwB4TjPeYNn/JwFRNQ3WyMN0WqRGQbGcUTZsC4il5U0p9bHr9c4bzZYo++6?=
 =?us-ascii?Q?43JV7CX0vEdXzgWy4ICbK1nEPsq6NaNVC3ppvLduoIc3Lz6sne7QrsPf8jmG?=
 =?us-ascii?Q?kFpXsawjd1UistrcVBTzRTf82f3qZ0pSZiswteUpNT8+WGI3UIi+C/YH6x/A?=
 =?us-ascii?Q?0Ctp5PbI1YgaUARcgePG+MRWw0g86y6ZVSfQP/g0QFboOpKUjiM2MGjQjKia?=
 =?us-ascii?Q?ekyiNCHtT2hZeNGkGD7MuVYBGtSZlaS5OIvwNO+5NiC8AlolkHTGxgkZR6/f?=
 =?us-ascii?Q?YS3zjHnVbImMPCez8gTOjj18UEvIMd3U8uXtXuaWZRcLGelLQYupoEYXgmg7?=
 =?us-ascii?Q?b2K9jMHchBIxhb8H1IM3emZ856Ga1msFL/xqVW+m4nuwwuegKdPC/nPdjwqJ?=
 =?us-ascii?Q?mpo2onX+SqjSx8HRSo6XCyxK+orIufJPxSeQOpzL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6fd937-3a16-4a1f-5f0c-08dd156972ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 20:14:39.9003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYVYElu4NHOp4JvU6v7xRetasfpD9Ob7Oz2Poor3+18By03JoCUB3ngX+/sn5zFtRrXAxlO7Lndeo+dql09MCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200

Convert device tree binding doc mobiveil-pcie.txt to yaml format. Merge
layerscape-pcie-gen4.txt into this file.

Additional change:
- interrupt-names: "aer", "pme", "intr", which align order in examples.
- reg-names: csr_axi_slave, config_axi_slave, which align existed dts file.

Fix below CHECK_DTBS warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/pcie@3400000: failed to match any schema with compatible: ['fsl,lx2160a-pcie']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
lx2160a r2 already don't use this IP. But someone still complain when I
try to remove old r1 support.

So convert to yaml file to avoid annoised CHECK_DTBS warnings.
---
 .../bindings/pci/layerscape-pcie-gen4.txt     |  52 ------
 .../bindings/pci/mbvl,gpex40-pcie.yaml        | 167 ++++++++++++++++++
 .../devicetree/bindings/pci/mobiveil-pcie.txt |  72 --------
 3 files changed, 167 insertions(+), 124 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
deleted file mode 100644
index b40fb5d15d3d9..0000000000000
--- a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-NXP Layerscape PCIe Gen4 controller
-
-This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
-the common properties defined in mobiveil-pcie.txt.
-
-Required properties:
-- compatible: should contain the platform identifier such as:
-  "fsl,lx2160a-pcie"
-- reg: base addresses and lengths of the PCIe controller register blocks.
-  "csr_axi_slave": Bridge config registers
-  "config_axi_slave": PCIe controller registers
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: It could include the following entries:
-  "intr": The interrupt that is asserted for controller interrupts
-  "aer": Asserted for aer interrupt when chip support the aer interrupt with
-	 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
-  "pme": Asserted for pme interrupt when chip support the pme interrupt with
-	 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
-- dma-coherent: Indicates that the hardware IP block can ensure the coherency
-  of the data transferred from/to the IP block. This can avoid the software
-  cache flush/invalid actions, and improve the performance significantly.
-- msi-parent : See the generic MSI binding described in
-  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
-
-Example:
-
-	pcie@3400000 {
-		compatible = "fsl,lx2160a-pcie";
-		reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
-		       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
-		reg-names = "csr_axi_slave", "config_axi_slave";
-		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
-			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-		interrupt-names = "aer", "pme", "intr";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		apio-wins = <8>;
-		ppio-wins = <8>;
-		dma-coherent;
-		bus-range = <0x0 0xff>;
-		msi-parent = <&its>;
-		ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
new file mode 100644
index 0000000000000..160ddc4bc45bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
@@ -0,0 +1,167 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/mbvl,gpex40-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobiveil AXI PCIe Root Port Bridge
+
+maintainers:
+  - Frank Li <Frank Li@nxp.com>
+
+description:
+  Mobiveil's GPEX 4.0 is a PCIe Gen4 root port bridge IP. This configurable IP
+  has up to 8 outbound and inbound windows for the address translation.
+
+  NXP Layerscape PCIe Gen4 controller (Deprecated) base on Mobiveil's GPEX 4.0.
+
+properties:
+  compatible:
+    enum:
+      - mbvl,gpex40-pcie
+      - fsl,lx2160a-pcie
+
+  reg:
+    items:
+      - description: PCIe controller registers
+      - description: Bridge config registers
+      - description: GPIO registers to control slot power
+      - description: MSI registers
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: csr_axi_slave
+      - const: config_axi_slave
+      - const: gpio_slave
+      - const: apb_csr
+    minItems: 2
+
+  apio-wins:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      numbers of requested apio outbound windows
+        1. Config window
+        2. Memory window
+    default: 2
+    maximum: 256
+
+  ppio-wins:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: number of requested ppio inbound windows
+    default: 1
+    maximum: 256
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
+
+  dma-coherent: true
+
+  msi-parent: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,lx2160a-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 2
+
+        reg-names:
+          maxItems: 2
+
+        interrupt-names:
+          items:
+            - const: aer
+            - const: pme
+            - const: intr
+    else:
+      properties:
+        dma-coherent: false
+        msi-parent: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@b0000000 {
+        compatible = "mbvl,gpex40-pcie";
+        reg = <0xb0000000 0x00010000>,
+              <0xa0000000 0x00001000>,
+              <0xff000000 0x00200000>,
+              <0xb0010000 0x00001000>;
+        reg-names = "csr_axi_slave",
+                    "config_axi_slave",
+                    "gpio_slave",
+                    "apb_csr";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        apio-wins = <2>;
+        ppio-wins = <1>;
+        bus-range = <0x00000000 0x000000ff>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 0 &pci_express 0>,
+                        <0 0 0 1 &pci_express 1>,
+                        <0 0 0 2 &pci_express 2>,
+                        <0 0 0 3 &pci_express 3>;
+        ranges = <0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@3400000 {
+            compatible = "fsl,lx2160a-pcie";
+            reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+                   0x80 0x00000000 0x0 0x00001000>; /* configuration space */
+            reg-names = "csr_axi_slave", "config_axi_slave";
+            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+                         <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+                        <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+            interrupt-names = "aer", "pme", "intr";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            apio-wins = <8>;
+            ppio-wins = <8>;
+            dma-coherent;
+            bus-range = <0x0 0xff>;
+            msi-parent = <&its>;
+            ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+                            <0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+                            <0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+                            <0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
deleted file mode 100644
index 64156993e052d..0000000000000
--- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-* Mobiveil AXI PCIe Root Port Bridge DT description
-
-Mobiveil's GPEX 4.0 is a PCIe Gen4 root port bridge IP. This configurable IP
-has up to 8 outbound and inbound windows for the address translation.
-
-Required properties:
-- #address-cells: Address representation for root ports, set to <3>
-- #size-cells: Size representation for root ports, set to <2>
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-- compatible: Should contain "mbvl,gpex40-pcie"
-- reg: Should contain PCIe registers location and length
-	Mandatory:
-	"config_axi_slave": PCIe controller registers
-	"csr_axi_slave"	  : Bridge config registers
-	Optional:
-	"gpio_slave"	  : GPIO registers to control slot power
-	"apb_csr"	  : MSI registers
-
-- device_type: must be "pci"
-- apio-wins : number of requested apio outbound windows
-		default 2 outbound windows are configured -
-		1. Config window
-		2. Memory window
-- ppio-wins : number of requested ppio inbound windows
-		default 1 inbound memory window is configured.
-- bus-range: PCI bus numbers covered
-- interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-- interrupts: The interrupt line of the PCIe controller
-		last cell of this field is set to 4 to
-		denote it as IRQ_TYPE_LEVEL_HIGH type interrupt.
-- interrupt-map-mask,
-	interrupt-map: standard PCI properties to define the mapping of the
-	PCI interface to interrupt numbers.
-- ranges: ranges for the PCI memory regions (I/O space region is not
-	supported by hardware)
-	Please refer to the standard PCI bus binding document for a more
-	detailed explanation
-
-
-Example:
-++++++++
-	pcie0: pcie@a0000000 {
-		#address-cells = <3>;
-		#size-cells = <2>;
-		compatible = "mbvl,gpex40-pcie";
-		reg =	<0xa0000000 0x00001000>,
-			<0xb0000000 0x00010000>,
-			<0xff000000 0x00200000>,
-			<0xb0010000 0x00001000>;
-		reg-names =	"config_axi_slave",
-				"csr_axi_slave",
-				"gpio_slave",
-				"apb_csr";
-		device_type = "pci";
-		apio-wins = <2>;
-		ppio-wins = <1>;
-		bus-range = <0x00000000 0x000000ff>;
-		interrupt-controller;
-		interrupt-parent = <&gic>;
-		#interrupt-cells = <1>;
-		interrupts = < 0 89 4 >;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 0 &pci_express 0>,
-				<0 0 0 1 &pci_express 1>,
-				<0 0 0 2 &pci_express 2>,
-				<0 0 0 3 &pci_express 3>;
-		ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
-
-	};
-- 
2.34.1


