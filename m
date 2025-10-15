Return-Path: <linux-pci+bounces-38109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F9ABDC405
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5ED421B69
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3004258EC8;
	Wed, 15 Oct 2025 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QbR46BJw"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A63255F39;
	Wed, 15 Oct 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497509; cv=fail; b=XR/FVwcVT7MAs4PiwZFGj+bVS8wTwa9rW02EciHgzVmTLfB+F71t7tXX6Ei0Zqg2rJV6vB/Y33Rru/3PIwSvlwqZmQ5BXS89m9z0OE78/nlVczLXMFSGE3iOsbCEMYa5LbELIbD/xP0HcT8rmU9Wl3SWuJXdv8L50aByEArYfhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497509; c=relaxed/simple;
	bh=CXJJ1H1shurUa+gU0+GH+KLMMc1D3Smch39AgFCR9D0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hJJ70w0uDnzVf3HzHL5VAP7sakNo+qOb/leZrHQVLimJPuLcXWq6pt45ZXtytOQOBib+tZEHxcdBifzEBZxLu2L0MJmDMyZeAFsZ4rjNYBALYbke58M8LAlZNQ2kPw/hDA/t+fYQ9ZCTJJtFzhIsWnqKBmxbtFWpdZ1Dg26JzoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QbR46BJw; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOpEbNx7pJHoAOue5uTDq4PAbT+CUEkSAAJcIzNU1KIp+4siGThUE1ye/rUC5cuAlbu7T1WSodJ8avGc0qpsnuvU9FqW8j6t2J3wVJdE6fYzfriCftf6W/dedgoF7QOYTTJWMsVEAd+0MgW2p+aofJNCZa4xdh3Ul67AErzauSTkWo8XJiIIcgZPwomI16eph8KmyIUlNXybHr6CbkaEn/hUxFadiJwv9f4iQVZvFG7IQfaoeDnLu/MlPvhC23xYOcChPcL8tAaSyEiCSP1jn+z/694Xj2xOvXrGBzoPnYGOWhoh8GsN+QtE3WSOy0JJk3L3Taf8nHkZC1XsZ7H/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGQOy1bvYaRaKpXUjE3nj+pRJMYbyR09BI6H+7JWAfY=;
 b=wEQoVH0FBITxGpaBzJnJVY2VFcvaneo7IkacSpC9+HjK0thJWBWKwcbmw3MoAPbXN8CLoa9sNWGStUGVTh8VQz328OyvfrShh+efFxHbnQO9J1Rrtxv67uFG6W9u10946LGESzQ+z0P1ZpXv78fXTPG0GHLRC/nG4yjSFNRootS4kY0c/ZkMneatGkjPlPpPM82o5899p4xLFVoGiOIzSXvr+lQXyjkM0TiEFNYWV7fDI0Y4KcpgQluaUW1k1IoSM1hTENcvrZkCeBtncH2aw07XAU4bhwxBzQdF6vSNO4yFHLHXCjQ9RTj8spPeVVeJttYR0GXwJcAwMcCGsjeNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGQOy1bvYaRaKpXUjE3nj+pRJMYbyR09BI6H+7JWAfY=;
 b=QbR46BJw9qe0+G/K+hVHtFynU/hnWr460PywPGYuqHg0EMeRwcg9LNLiQnqQnROcAObG7R0x3jBvBWA+CfOrxAiKS34rOdXeS4QVTyvIWRN18gX/eqkIkw4jAG48Zo/Hp49sX61pwtBlHQRyrH0HAqBAYoEKDuiTcZzGZDnmqZlOxgTLrGe01pR2t5OABVa++446gvHIeuyUsCmdL4tVFIWN0w/aqwOGAOBD0OuTmKnfpur5kSOpCvnPrG7+s+qtCRC1VvHkLO0eJUUx/EF/1enrjHkw4Yx6/D9/eOtT0J/S7RbhgjA/fszf7Q8/RarlcHk0JEN97LcmQIyqRoAdiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by DU2PR04MB9521.eurprd04.prod.outlook.com (2603:10a6:10:2f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 03:05:01 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:05:01 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/11] PCI: imx6: Add a method to handle CLKREQ# override
Date: Wed, 15 Oct 2025 11:04:17 +0800
Message-Id: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|DU2PR04MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 69116f41-b1e8-408f-0ff6-08de0b97a199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NyFe8w95iXTe9HxDW7L1TTlQoPlDw5aEu+w8hRwkioWXEBXXTe0fDmllRXX6?=
 =?us-ascii?Q?IXrK1A8l546qAAvY7OwgdQT7vfn9nHJJkUDRNSn8THhYEwMVjXus7h/T/8oj?=
 =?us-ascii?Q?/Y7NSA1QyhI8cCpvND6fURrmKEP7ndiHpKdxR+aXaQyIWQXsCqudIff8DPNI?=
 =?us-ascii?Q?FOKkTFjxUMXqW1mpe6Y0ma8iuxNUnIL/eclsJihlubEtFQajbsfGOJJ8nG9k?=
 =?us-ascii?Q?j8mj0N+n6cTOQ+vCYcW3fuM8hBv+yq73ElIAn+kiriMS8I7GjP+fTMDQFABS?=
 =?us-ascii?Q?OsuActxKeTMD7qitosO2jPzMHCCd4Lp9IVpgXPFfoh+NLwIUtogio8IMCnDD?=
 =?us-ascii?Q?sJJen7N2YUxddpqhbSmY3Laz903hQX81nftTLEAxfp5SQ6lPeLMGEL6lID+a?=
 =?us-ascii?Q?dwWhkpM0GJMXDK3s9PaotYAODiMNMCRYBkuTS13ZVxcQxNPjjOkXnRTIkPf4?=
 =?us-ascii?Q?PmUG3GnGDoj+YxTpKB1Vu6cjAc2vZnmWVnZBa9MMxtKhiSjfCDa6uD0KAPyy?=
 =?us-ascii?Q?fDKCmWbHF6mQ6LN7fBSj8vYvd0Aql8Bj9m1P1MAcWt3H2UgcUl0O1uptU0qZ?=
 =?us-ascii?Q?saeTg/aeo9wFGiKI5AzVpYIl8x0BKdbZCOT754BEEkSDXZqZNX0LgoiWjfMj?=
 =?us-ascii?Q?ApKNNZO8iADe8k83fm/nd62GyxTVHKZmPrF/k170OLu9uPgOW6K575V0x45w?=
 =?us-ascii?Q?4peyFGrku9LNStffhpxPBvYbQ1nWCZk4M9geQY6tm90902ZuzT5p3QiUFPO+?=
 =?us-ascii?Q?3I4c5/KCudZ+k8dfP3F+MM2XjiymeFZOK71HPUO1qescTSgbSBbAOkiYPqKJ?=
 =?us-ascii?Q?iHEU6UKOFBm1PS+2eomNTXAlwJ0ncQRT84ihCeKKGH+KqLW9SeT79scE8oe4?=
 =?us-ascii?Q?yFuEuZ+13Jx5YoFbptD5tyUXT5YYk92EBxCno1YPDsS84nIvF1ciBYvsBdZK?=
 =?us-ascii?Q?f1cqNX6pCqu/C2i11CzVAGkgVtI5BBoFxy2cztEj8SxwNb2k6Z/NMl38fBzg?=
 =?us-ascii?Q?vTSdIJe9jH717oXk9lmemS/6s9qwA9PiF24rsQt91tykFmUzExz/5Mp+zl0m?=
 =?us-ascii?Q?9cwaojnNLRTOzxH5/MA2lKmTsOBwmIZ5a/2G3PqPi1HW/wcAKOdgS1w60y8d?=
 =?us-ascii?Q?0skgctovsXdZLMds/neKGuHJVmBD3BSsxctni7nY/q0n+wNumebagW+esrj4?=
 =?us-ascii?Q?gec06ddN2uJNFOzzC4QhMAdHSnE6iWZGH9LZ/bp06jiO+QI2FM6zQm53FrxA?=
 =?us-ascii?Q?9YI418V03Zp6maIJkSntgY+XCRdcLkNbKYHxFO5mJNL84bKGVOP1gMGAEX03?=
 =?us-ascii?Q?7nbm84v8xiUPjfh0JFwLx9qY2NhxoofYY9d+7/W9oxfJc2H+U2jEbWTg2xUZ?=
 =?us-ascii?Q?h6sht9jLXGQo6TO9U64i5StsCXXg+AUGYc/PyJxJXEb/BVrG2csONxaPwqFv?=
 =?us-ascii?Q?o2N2CjD0u5W4hchetkmboF6FncBO4I1aBCOUcKDPVWHZfUsyJAp+OuuB1Nwz?=
 =?us-ascii?Q?rrtEJbhjS+KvboIr/ZYfUOLXEVBDuribsoqEf039Rq2RbsFqZwbg1FViiw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X2cQ15HeaEJepbrkXYlQNSlVDkHixdHLgilBq9KALSu2TlLsmn6Dg749RoUE?=
 =?us-ascii?Q?JT2OJMxfKIP4eCmFu6lZeijf6uHvzGkh0csuqpRKEWq7HkOhul4PdzEwEgz2?=
 =?us-ascii?Q?/QWzQwQ+Tlx7lTNJxq3NxBJruJN4bpZ2EtIKM9KttdRwX1jQEDd14jhJDkV1?=
 =?us-ascii?Q?H7GG+meMqgSIFRyypqQ7Q5YTrVGPShZvnMGTjBXqzYvkpC+rUgCm1AoYHeO9?=
 =?us-ascii?Q?oyZ3a2y5L7zTB+q0eoNS451wHY4PdiBHpB0l22CcKdlhA1FvUeevcg1Mtlux?=
 =?us-ascii?Q?H1WjHFQGcw8Ss2ritIVJhf2gbsJkVbCyHYJMEdUglzde7//Ws5C50qGNBN/m?=
 =?us-ascii?Q?AbSFRynhN71VndQKW5Ia//X5/JbzLLKln1KRlGEqgzNHJxmqmULpaaZbcfAc?=
 =?us-ascii?Q?ZOhVJ2OryKnOHi/CbjD2sLPqnLA3UoO8/iXZob/198sCXBvX0wr4OSF5NZis?=
 =?us-ascii?Q?qnOMQMq7WcT+X0t2wr+f3z+2WHrOrJ15FYk2I7jRSCQtOJmHgjAoJFbw9VUF?=
 =?us-ascii?Q?aTnmnyXLTfbu7nVwbn0q2Jh7DaAaWSj63XcoLi9zYk3TulmiVXz4MpGh8FUX?=
 =?us-ascii?Q?Qnnmgqc7LjvPg0LWAqJNG3ECgJpt5yQQ9cjl24hSKn+NqnRcdurol1377nrq?=
 =?us-ascii?Q?t7FadIEcKnXxZSeZIFRi2Gb2ciIAlcqPyKCoYBmdu61gIjmytNtibhSyjIuM?=
 =?us-ascii?Q?rLAzLH65+H2YXaAvTB1uol/gCmq9Rp9hwkClBtBEo0Z6dhCePCdkvYNtTjzX?=
 =?us-ascii?Q?fBjJ6DKHGq1WBIWN4PXoS1lSclMQaTD/elXh1X0NXuRoxHPrF/DwWJ/4eQP9?=
 =?us-ascii?Q?kdVckfiy/Prk7s0jTapn6rFpwZ+NN9AbLveTaVqFAghgcMfN8OuejkwVsYZW?=
 =?us-ascii?Q?WvvlsjL70F56Xq5dsiqRw1jXlLsVYOKdVTVdr2dYxf0TUcMGDRPT/SJZB+p4?=
 =?us-ascii?Q?LuXFl5wavqRFo3TcxRcbxHZzK9s5F6DUjLAHCloRkyn/g/5Ayp7Ws+dBBWsd?=
 =?us-ascii?Q?5Y6fWc7X+BiVYnUhfKXJ1Vskf7VOZoJbAWkAb5UfQ+eCCwEsmmEDS6VPV1JI?=
 =?us-ascii?Q?jcTdTkZoTG7Ahecg4mxTiW3KFw6nmFzuFeERFVK2n2rDZvsW2+BFOQ8wCb6W?=
 =?us-ascii?Q?GFYFOzNwdGfvM9dQz5qpFA1UVDIYvl5fHv9PWIFTLwvPfA8aLCcs82yu/4/p?=
 =?us-ascii?Q?Wn7LIXyszu+vX+w73xB+8eUkOsogdToggVY7mmnpuhG9BW83K9nCjvszlpAR?=
 =?us-ascii?Q?klKnJ2iZlIratgR3vpYo6/Ce1rjO54K5Co8SIfg1y+4vPtuuNIDpbjcT5Rhl?=
 =?us-ascii?Q?j5MFPloAc7EF3MmoEPe+ip1vWiXKQdMssN7bPLZC/EmP0h5KhlU5GSu7usha?=
 =?us-ascii?Q?Symqy5yB72D6V0cAZOMD7dX/n311QFx9BR9yg7aWxRsd3NnZV1MYEyka9UcL?=
 =?us-ascii?Q?gv6kx9kPgptp6gPCWHckulXpTInsJ8GA74dlmLTywSyes/GurowaHu0yh/v2?=
 =?us-ascii?Q?xDxX9BbppPTzjvm7c09UUhD68uRk/FFE7dA+Z3zd0rCZN421jZN3Q0jGjj/i?=
 =?us-ascii?Q?Rzrz/6zMMt0+dlOIiw/t36SV2qL6bFjm65Yxfr+z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69116f41-b1e8-408f-0ff6-08de0b97a199
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:05:01.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJLGwiPj/IssV1e7/izvZpRiR0pWNxfQgFb8kFqR4QImRGVtS+cKmWqMoT8SpK4fIYRhWyJWrLjfbcqbUQQ3kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9521

Clock Request is a reference clock request signal as defined by the PCIe
Mini CEM and M.2 specification; Also used by L1 PM Substates. But it's
an optional signal added in PCIe CEM r4.0, sec 2. The CLKREQ# support is
relied on the exact hardware board and device designs.

Add supports-clkreq property to i.MX PCIe M.2 port since the CLKREQ#
signal would be driven active low on this M.2 connector by the add-in
card to requtest reference clock. And, the host bridge driver can enable
the ASPM L1 PM Substates support if this property present.

To support L1 PM Substates, add a callback to clear CLKREQ# override on
the boards that support CLKREQ# in the hardware designs.

Main changes in v6:
- Rebase to v6.18-rc1.
- Add the dts changes into the v6 version patch-set.
- Fix the i.MX95 refclk enable that was missed in the v5 series.
- Make i.MX95 refclk enable parallel to the others.
- Describe the potential CLKREQ# problem on i.MX95 19x19 EVK second
  slot in the commit, and emphasis the CLKREQ# issue is caused by the
  board and device hardware designs.

Main changes in v5:
- New create imx8mm_pcie_clkreq_override() and keep the original
  enable_ref_clk callback function.

Main changes in v4:
- To align the function name when add the CLKREQ# override clear, rename
imx8mm_pcie_enable_ref_clk(), clean up codes refer to Mani' suggestions.

Main changes in v3:
- Rebase to v6.17-rc1.
- Update the commit message refer to Bjorn's suggestions.

Main changes in v2:
- Update the commit message, and collect the reviewed-by tag.

[PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add supports-clkreq
[PATCH v6 02/11] arm64: dts: imx95-19x19-evk: Add supports-clkreq
[PATCH v6 03/11] arm64: dts: imx8mm-evk: Add supports-clkreq property
[PATCH v6 04/11] arm64: dts: imx8mp-evk: Add supports-clkreq property
[PATCH v6 05/11] arm64: dts: imx8mq-evk: Add supports-clkreq property
[PATCH v6 06/11] arm64: dts: imx8qm-mek: Add supports-clkreq property
[PATCH v6 07/11] arm64: dts: imx8qxp-mek: Add supports-clkreq
[PATCH v6 08/11] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
[PATCH v6 09/11] PCI: imx6: Add a new imx8mm_pcie_clkreq_override()
[PATCH v6 10/11] PCI: imx6: Add CLKREQ# override to enable REFCLK for
[PATCH v6 11/11] PCI: imx6: Add a callback to clear CLKREQ# override

arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi     |  1 +
arch/arm64/boot/dts/freescale/imx8mp-evk.dts      |  1 +
arch/arm64/boot/dts/freescale/imx8mq-evk.dts      |  2 ++
arch/arm64/boot/dts/freescale/imx8qm-mek.dts      |  1 +
arch/arm64/boot/dts/freescale/imx8qxp-mek.dts     |  1 +
arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts |  1 +
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  1 +
drivers/pci/controller/dwc/pci-imx6.c             | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
9 files changed, 60 insertions(+), 1 deletion(-)


