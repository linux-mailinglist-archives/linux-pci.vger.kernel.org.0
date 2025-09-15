Return-Path: <linux-pci+bounces-36106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54528B56F14
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 05:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D6618881D5
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 03:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB05B275AFD;
	Mon, 15 Sep 2025 03:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eHlLPFRE"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045E275852;
	Mon, 15 Sep 2025 03:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757908469; cv=fail; b=RBF1gU5FJiQKeA1cDg+LUHzTxvBJVkZ4mD1c9nA2+dBfCIlG6bq/ltMZLiNkQSd0cR2gh2DllIUotCOLBkA815+qXBKdOzmFoK4Nn1AbhuI+AILZhysxr/AL9CXbui748bOGH/2geygpR2yPlT+rkSnDiknowW7bWfhE8guq9Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757908469; c=relaxed/simple;
	bh=7NSrT2zpOW/A4peVsZdNYj5BBdMJWU4FqTgSQ0MnSjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OrAdH1URMqNfMXgQdnJiTBq0nD/ogIhFOsXlLFexf3RG519hEcVSbHizyn7gTvXV8o3+CP5UASyKSuQ2IDd2+z3SmOO3leIEdDMt2+GFTwgJNYoN4a75a86zfzK5FWyStQfvXCKhs7lk11JTzLQicw7q1JR2sRdBmm5VOyBcSUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eHlLPFRE; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEiBRuwseUo6nQF+sNL/FBzHF5datj9/NCXVYBBepPMr3OFubw+1wgRqpl5eccd56Htsf6RaH//owg38c8Tbg9AcBr1JukyEPB6i20Uq/tMPpx8fTysJ/fNwdXl/2sCZ1SyTJxA/pXKmkmP9Eo028rnM6Q7oBDII6df9V2QlXH9mVk996nZlx6jmZ4xknYP9oXzFl0nR5loZ226V7+4bpUlJxwzHeZMaMVG6O304bOZ+X4rBOFE/p+4Jp6Sv5oUcaRp/N66LfQj6i68BtxyvAiVfdoGXWNodTFcOuX4+vMeqRn/gb4Uh1tWke77mgKAw5i999c9AcJnRAMylRAdM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NPaWejIryNxORr6jGQyIvfAA5HdEKfbiJ9as1kpaQs=;
 b=fX8FU+TIH//WCDq55p2AWeTAYKqZf9fzfEVbauBj/1bJ2uRwCEB23/Q6JIEEYHk+kHiMpP+U7viZ59VU4hwh4mJ/fjHyht1ZpqtHKVwAaGrS9ymv766rsbNJt8Jph9lHKAuaFyqHvzhjvo35E6LQ8eeVmSMfy+FD8zcBQLJwRXZekCACdseZ+JJEg+JxuAHnzGXbvGRW6z7LVltaE1JPRxFUeaXbJoGY83FLyjuokF2aGhy/dgTUw7uI9Ls3W9oGoWedVNAabgs0ySrm286IUdxz/f9Smcrn1rmOQbJQB6m/SsCeKNClq7gPtj9JhArV7IAGGUvZY/1xyoMLTQ780g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NPaWejIryNxORr6jGQyIvfAA5HdEKfbiJ9as1kpaQs=;
 b=eHlLPFRE8lw0aFeVDQDNNFrnjbl1VIGBwGOLjIJJUdmixEDdxfbWfpJTBDxIlk56/Boh4ge8KkBMk5P1qSTII0exLGKo3cryHqHAeBmsb1jLswS1UyCydY7jIl7qAvQ3D5BNZ2Uqs/sy7mNT2BLBHG1dYFd/bYWjv88mTH5EZ8JwoCvFeJ4uE8HatSNs191hoSynj2+E88P9MmsNZ6+ZpJVJyLNLbaEHYrDRzXrh4awXqLZQ9grj0KpFNExYghxXefO1gzIolDyxn5ryyAk89y/MeaGqV5YtolxnJ8LvJg/bi3bJSl6wOlXBBpEuWeqvIpfjxZTB2OO+lsIP+8S4FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU2PR04MB8693.eurprd04.prod.outlook.com (2603:10a6:10:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 03:54:23 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 03:54:23 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 2/3] dt-bindings: pci-imx6: Add external reference clock mode support
Date: Mon, 15 Sep 2025 11:53:47 +0800
Message-Id: <20250915035348.3252353-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
References: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU2PR04MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 364d9b3a-9cf9-40e1-5a84-08ddf40b8ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SuKoMzl+Uc8FJAIcBruhtPTsYR7zT5futvOnrEVWKg5t5Phqy8JSKYjHyESF?=
 =?us-ascii?Q?7DBcpQl4ICHEa35FjPwQmckuKxvsozMx4q0aQ2h7v5A/SWGTmQB3ntUBDXdS?=
 =?us-ascii?Q?EseoycEuwtDm8uI8rXdn+lmXXq3QrKCmpqJ+IwjtJ5fjgdOiA5hEqOVS/KqT?=
 =?us-ascii?Q?/sO050qDmHsqdhZnrOLIcoi6qvAYrKeIH+3HZUIwz9cQK/vHTPASfZqR2lzM?=
 =?us-ascii?Q?DMKOh1eQfhKtQt4Oe9uhPm9dYYeQ4ur4iidxwGdpnL5zRTAj3ms1tGD6jib6?=
 =?us-ascii?Q?I7HU/0YdS+3Xv1Ql+whX5zjGvbAY3UpE8aFCN9HYDP24ewYHvZByiguqW9Bn?=
 =?us-ascii?Q?RrXlAWTAhVHjxcxDKvwiGB759HtdLf+nkfZmBxO/Kigc/iLolBrz8LsdV34Q?=
 =?us-ascii?Q?2733b28HbNI8bqCwiTXZE1HHYLyvd9a4MijrITnotZnY96xLBuWmbqIwLodU?=
 =?us-ascii?Q?iABHatUQd1t7AV96jPksXNXBcMwWBqBmMtfrL/lpOY6DJyqCK4a5Ua5gckkn?=
 =?us-ascii?Q?tfNQuV+EZoWOusP4bQJc5mbq1z3hTySy8lMEuVAugnb440mWQBIalRzAhSPM?=
 =?us-ascii?Q?PpI8FZ1OzhwsWabdydLFnpKt2/o3Z2RKzK//uV7cBHUdSQWNxZrxYN/ZpZIS?=
 =?us-ascii?Q?tJ2RhkRC1NeuA35Gc9UhDKY6Kae9u+e4b0AZww28NKeJ8tWGCPBOzJRMsIbZ?=
 =?us-ascii?Q?4jXXy2FrduqEXsSX1MHO6ZUaNRqcqkqd00zI941OzgVJ+9xfUGSa3qMiZPd5?=
 =?us-ascii?Q?RWkncFgZaSyUq6F2CEfNUlAAk19NefPEZzqFGi82scyJxfukDWx0n2m0cAhe?=
 =?us-ascii?Q?E0ZQwaZuSSeAuBgDI/iIjbuzRd9kpGUfPXr4Hv5j8s2InL3UjDBxz46zmp7R?=
 =?us-ascii?Q?JS5X15oVBIWjPAg7tXZtox0PL2miiquw8FwPLSew3oW96aEGWRw5ovK+gNbp?=
 =?us-ascii?Q?DAwxysWAER0zRaj6C2QWv3hujlk8ALW71L3DpAz1NH0pOf/runy5ZHzNgzz+?=
 =?us-ascii?Q?fBMvFLDG/h0dD8pHbVdGMCAM4ho5HaIQeY/lUS3ZSbwrqadyy4Mv7kOsZaMe?=
 =?us-ascii?Q?IpIe85FfU1AuAYE4zuk0X4DPbZpiIQAIX1a7WHmRJs3BrmKtyR1mEnItWBLC?=
 =?us-ascii?Q?JqlSaG7Sp7/WoODVGqdp7z28nftNqmroD7rvZcMueueLCtKle5LbWjoKJtZL?=
 =?us-ascii?Q?7p4fRCsGIlXo8uO0wAEGW3d0+G+kTi74rAzyHl46/sHu7ohOSTzQHVuZutRr?=
 =?us-ascii?Q?kkExdjp7tgLrYEkqqQPLCqnvUeI+eq1g/wkFFxKKtxUkv05Is75h36VRfOSp?=
 =?us-ascii?Q?KhtnSBHZ3HEXzGm5SR4zO90DQdlucMfZtVVfpO6cULhWL/uM2drNmLzJEZ/8?=
 =?us-ascii?Q?M00LDWLCp9/oLgHtJYbPkkejuJinRRpXiIOSPvsS3nnPRVG+I6TGBGz5sgK5?=
 =?us-ascii?Q?DV8gg+n/HxOJ4DyPLLXPEz8Vtc7/J26vPfLCkwJFaNZb8x2lABUfKX7aEi8A?=
 =?us-ascii?Q?qOnQtNiSWJzshsc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iegf+J8mp4gwdkRWqdRB4VHsetTG15JQp5SbNOPYyFnt1sOPaieFZ9923QDV?=
 =?us-ascii?Q?bH+L+t3KCzwTOpHvtlIASORkKPnqRYWLDbEthZm+rXG+HvkfPO+zmjVZ87Qh?=
 =?us-ascii?Q?6qR/KJuQUl3xtRJ0OiHSqVRNUm/7yKEv0mOf6QmoX6k3uikM27cDz1ZcrrYl?=
 =?us-ascii?Q?HYQu4BxpBJz+P1tkLNtzjNRHq0O7hyItqoNXohrwQbNTeSCXyLV+FCC1qlVJ?=
 =?us-ascii?Q?h9qQAchM3UPyz9Qu09uHnApkNTAL+lkS0MxXvPbaESdNn/NW8SpcrGiSSTiP?=
 =?us-ascii?Q?DgivfkoRO46Zr/ATa09I3lezwCwr1epwyY8LonsL1v7fOhPlsXDd6Vi/vvC9?=
 =?us-ascii?Q?kRFCTTUrltaejEUDBLFGpvwHVuxSJUmIgq/YZWWVaGjM0RCWnaMGf+TlxNcA?=
 =?us-ascii?Q?UIY06UQIX9uwdbZvN+HuocdUEquQfkcX78ik4U9+xHnKEQGrgdDyNBtWS3gr?=
 =?us-ascii?Q?X35qHCAMrtb/16Qaz6cmhZTu9d9A1nnKwYeXrv9jzzi2rqGA60sEvFxz3/c2?=
 =?us-ascii?Q?PwNYF5phNUlcCFgo6tZKSHy84r+xa9DjH3kafHEqFnm89tFHpy/ayVnOB/rb?=
 =?us-ascii?Q?D+9GsxGYNIQAx8rStUJyOz4y8l2CKDJ4odyUOIO73ZrPv47U65yhcbxHL9BO?=
 =?us-ascii?Q?dTZOoNcVHQvu8DlUHIdM6PeXSWstS57VQSel5OqzcvaHBhiR/iZaNd9Z+ulG?=
 =?us-ascii?Q?wOusqJngN8n2rUU8cTlwQ2XdUDMn2Knm4ThD5uBjINgd5woIDQcmn1NST/ko?=
 =?us-ascii?Q?PRDYRCL1oM/ldRu6poy5YPGgDPCrVZOHerunAPXnWayMLJPZycl4qFbm4RiK?=
 =?us-ascii?Q?ua0kBmi4sQYS1c8XlqEFpCQX3cwDz9aYgjp7yMAqUsXYB4DXEFHWaktqwVhV?=
 =?us-ascii?Q?CVWlIPVlpCdGuCRadv18WalhXPSKXDuVqj+pikdqjM2Mi5ooIyyAcN3Hfi0T?=
 =?us-ascii?Q?mU+v76prnHi61EwP63BItHil8+DVQ+a/RI2vKpPnVGDzge6D2BOFBXL5hQzU?=
 =?us-ascii?Q?vQmT82hINwSUydo0nnQbk3Nw1Pab6F22gucO1xrhv2pMhzdHaCqADOALbFVm?=
 =?us-ascii?Q?9ys2XQowUTX6MZRP6CkXB3+PI8CUdr9NSEwHbM06QRQLgdWdPOPBGo2qkv/9?=
 =?us-ascii?Q?hg8b3IPndliFdXbQ093ZJHG/870Qq0AmA0RvabbwfHeGW+wje5LXxdVNfLK7?=
 =?us-ascii?Q?rr2DZNpcwa2G+cLC2GugW3jk5Kn/6hO7LazHpm9oR63Lt63O4VYtxMtkvRLa?=
 =?us-ascii?Q?rhgBm+eEyANXl5HozvYtfvyoIsEkWR5/nZTYr9jtYoPrDyjKEJraLn262SRu?=
 =?us-ascii?Q?f7wsLqCaf6rPeYxAKGc7a8NUlTbnWs2zJ/vB9003/xKgYSzvTceJEvuicf+E?=
 =?us-ascii?Q?v6yOQxIXwKY4wW1i3ZDv4W3uc9YbW/UXprXUNAagQRTmCWB3vDjattkhkhbR?=
 =?us-ascii?Q?WO1176XwZDpFqS2IDZ9YI2i6KUhWAUhjbx4CQNzcDJ91mfbqfkJMkub2yki9?=
 =?us-ascii?Q?q12POoUAA4p1DJuEJPrDkdqSFLHFpVnEXVDnhoBGuJnun6FiUNHe3/IShM3G?=
 =?us-ascii?Q?3S6tthXNm8Y0wLQpIVSaFv2YNPrBnFUe59IEjIof?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364d9b3a-9cf9-40e1-5a84-08ddf40b8ed4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 03:54:23.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgNJE/sE9G4KHFlPwnp1gOgOvFp5ddRvS7d1MbYTjG73A5JAZMK24Ofa5C7WI2UF4lCC6plwsk7aicL+UGaxrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8693

On i.MX, PCIe has two reference clock inputs: one from the internal PLL
and one from an external clock source. Only one needs to be used,
depending on the board design. Add the external reference clock source
for reference clock.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index ca5f2970f217..6be45abe6e52 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -219,7 +219,12 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-            - const: ref
+            - description: PCIe reference clock.
+              oneOf:
+                - description: The controller has two reference clock
+                    inputs, internal system PLL and external clock
+                    source. Only one needs to be used.
+                  enum: [ref, extref]
 
 unevaluatedProperties: false
 
-- 
2.37.1


