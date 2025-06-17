Return-Path: <linux-pci+bounces-29916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E37CFADC378
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 09:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4BE3A7FC6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 07:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100A28EA52;
	Tue, 17 Jun 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nAsG7NAk"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5490288C06;
	Tue, 17 Jun 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145811; cv=fail; b=uLDQqmnSbaX+USFxpp20E7gnXRfsv5PdAwx0wnmt6x0MxjiZTqpGpM3ZW0O9+JalBGhYM18SlWs7Y14eE8g5IbCuVCjWcXeRftgZwx7XYuASfzlS1KbA3SJ6eQQENanUt/9bqtm4f8ZRYVpeqNHSMi3QPbq6aQCFgLp6+fReVHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145811; c=relaxed/simple;
	bh=2RBx5q2nKmjjl8cXzzf7HO9AuSDnInGHBP8P4ENgFDU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bO6Xi0uzxV3xHL/SkA6eaONeBI1xDxm58jXZOu8XPWmLXOPmyuC82wgPhmAbGNdX5rtLXJ/+zGcK9vtIkOJ1p2viyzhumw4GfV5McTCMdTvrxSS6smYJSSe1xxYttJwlSEDKHSA4ds16G4B3VqLJP+0KbDycgdGe5a1TwRz6hRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nAsG7NAk; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLfTBtknCVAVdXVCN1ItsGtZ352tJ8I6KwP0OXzlJR1KVNKBXqOpQb06xJO8ryxLZ54UmR44CNsHqnROr6W2yDUdEpuGimyXX27wEzJSpo16Z1vty1vaEQtFHt4/MYcK+v0ByK/KNkOX5gXrv6xE0wGr3/QopUFjhRD9XPMpojDYCzLGWf7i+Kbrs9EfVoEuN7lWByCi2VdRRrfv6LPsZlqFjoy5nOQjEHnFsT2gXbOpc3KdY4bXGpyEL8qTJKZDtpUHJtayXg/hA+JkjUgsjK80Rcir/qtYeS0CLGOBBmRx+iyLsMoM1QoIn+dtGnJCFVEDnpThB89v3CJxbRU6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaG7TdRK4qA/us1zaqr2Pg7TG2FCT7VQUiqEoXFRiN0=;
 b=NPegTf10MbI4WOtyGDydTZY16ZU2hdrcQiIHeaLNKxQ/tI9BTq0Jbn+oGKHSfdSWoLhT5hI4Sb/xiVyeFJlT8FJvDCbPtdcDH0QPjefqj8sx9vFRyHzQPSfz2/O92TPZ7/OyxxgtFtZFK/dtQcRPoMXghNMZWyUYLdM+OG+8rnqNoCp734QL06WvZoOBGohsqZNXnM9xDQDh1XJkbs1vjBphpJI41xncxTy9aRkZdT9tr7c4plwqlpp9/3StKIw4WiTrWQGc6R1rI6pAMGHcEW1kdrg4ul2Ty8t1s144zgchxew4/SAGKX8yOfFfMyffSChDhlNqeFBa9ltmTWnIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaG7TdRK4qA/us1zaqr2Pg7TG2FCT7VQUiqEoXFRiN0=;
 b=nAsG7NAkOE5RcPWkFHZyXNp4maN/k0oZn58q90DmzF6M9DS5anvnN7DDuG/JFzsVIokuZoBy+zxZD/Becou2LzZipi2hvQOgu1ZepYwofj45V0BuyNWiQKWVpR1AIM9pk2m3vLdRbsD6m9MbFZOSwX0N+lyNn8M36oiAsZ3/ybaD5+4wg3xXHtMTrGpJEZF1qSi/NClY7iCVVinvvppO1Q/Ok7cqhD/hXSEMmvOOESmDpMtUdp2UX+EpUecsnBoP3px7TJ06C3HtVx5lbiKofEhHn4/u39tHrpVfUsaQ16qdqZQ4vr8rmvilgzWjOlATwppWTkJ17/HPpypaqswacg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAWPR04MB10032.eurprd04.prod.outlook.com (2603:10a6:102:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 07:36:47 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 07:36:46 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
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
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2] PCI: imx6: Correct the epc_features of i.MX8M chips
Date: Tue, 17 Jun 2025 15:34:41 +0800
Message-Id: <20250617073441.3228400-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAWPR04MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: 19183ef6-2e1a-44ef-bdd5-08ddad71b692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AJxIlscAPfxw9eZIoKdJqnEzj7CrQx1RIHMOLBt9UMxbDkg98fSgVekCEM7k?=
 =?us-ascii?Q?x7M/evp0WjaytiHEt7nRelRi5d3kyRRhy+4CA9VulMq3fDZfnVsyowOgMENx?=
 =?us-ascii?Q?2jB6PxaP9qlfJBBJgaHAZ5PgHuWfRY/6tg3TFmuKa2gJ0QAU7Ywu5K1f/Hz1?=
 =?us-ascii?Q?Ml2Mi1PKqSArqmCYyKMwTDWgzFbx0EMnSxP3YuuJOZ5pqXqa4hTvVPB0fa2d?=
 =?us-ascii?Q?Vaz3gF4zIl2DeMZk5/GV/ukD8jjgLA06Dpx/ZL9i31HiRLK5KHMl8IAwlUS/?=
 =?us-ascii?Q?3qyk32erygAXSf73G5IVlvkYUYtVSN1VSg0phqfutZzUyzrKQgWRYwvVkQwi?=
 =?us-ascii?Q?zcMlxiPrXlQCvm37T9esd4NwojA9uOoqhxouXDUGV8xN2vyHokUOZ7pfMjJE?=
 =?us-ascii?Q?tv4FZWz7BiMmuo21x0xPfDU4ss+WyPWA7T6DqxmCaezpqSDndLFVIr1KleRN?=
 =?us-ascii?Q?TavmOHKbJYSvSzPohttzHx4uh/s22/PREYb2dG29tiwy21Jl9R/8qevXPntl?=
 =?us-ascii?Q?CHboosta5Fp6VmR/bHKiP1kjx7FfK1crKq8CvuEW2w2JIAEW6CawgFsgpZDc?=
 =?us-ascii?Q?UOFiIlh53CYP5ZUzcA2LiOOyqkgKr9HYjZCh0NaebJ0dhfGKs+D2JtlTSLdl?=
 =?us-ascii?Q?3iu+qP/WV5yKQ/OONGn2lwEYl8VC54hwC2ZW8hIVamwe8VuhvEH/VLK0vvgY?=
 =?us-ascii?Q?ixzzHIfJsK4RDV7wRWcfGJJ9flm5T9gE9dw7D3LlwvTuSIkzxyvT8qoE5kB7?=
 =?us-ascii?Q?097o53Bnuc4CH8vURDG8RCbBMLOX/t8Bi73M1rpqXof9cHy9kej1mZbpfr9k?=
 =?us-ascii?Q?jnV7Um9LlUEwWI4R+8Ojys2LGW2mC97CYKxQRYcnkrrtF/TK3b23jaMo7o+N?=
 =?us-ascii?Q?SR19JXRvr1luyW/ebJ0gw04FTontLA/n6ga1WprVDHqYUFSOn4AGr+zG3qhg?=
 =?us-ascii?Q?5DEwS1PZgflnWtGBLJgeiMAIoZJfHGGemXzLggSqdOs6GFAVUY0AatvGxivI?=
 =?us-ascii?Q?ajwha/WQ4aS5SyG/XePgirIMODOL3AclvVgxvfVLzIgGAyy5Mnbw3SxXP3yj?=
 =?us-ascii?Q?8umLP++WQtA1EPRhFlFJhTMIfGj42wgvRQwujalTSRj3jIsVLNJrqqxF+DHw?=
 =?us-ascii?Q?yrTsh+hYA1p1S32Ib3jyHhNr00mqctZSdbeuN0XbV4pQIywsFt2Z/57t+mFr?=
 =?us-ascii?Q?Sohs3shgcauIpSfSWj06VMmZFiSJcR9vFp8rwHsWbg8GBvkmBYFBFhc9cTiq?=
 =?us-ascii?Q?qB2gF/XgYntYlfShEcOg1cQJKN3tT+YQvAkfTIvi9noiKDakCJl8r5exHXvd?=
 =?us-ascii?Q?3vRUn9PQqhNISsKjZx8MC/KCRR9blBT/zJ6uaR6Jgr5mnRZfGXUreyM3+LwM?=
 =?us-ascii?Q?CTLvD5l4otUhw9hpi/kBye0NW9mzPsa5L/SDLPSwo0vvpvmY9sgSk3yNeLDs?=
 =?us-ascii?Q?hKXRltfgUEUgbxjV/bUg8S6P7owgQgyo0eaGwUvDBE9I/0Hqwztca3jpV1UH?=
 =?us-ascii?Q?Xv6U4sSs1gxOKr0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nMhlVShz/QqlMZBvLzlBluPkNYrFw5Yl+ceTIMooOgy0vBOIkZVs5q2RXPF?=
 =?us-ascii?Q?qdjAE+KQro0iFybJBTUPVlGDKMxEkvtXWKcZmMZ1azZPLuG/u4NeEcVjkiiY?=
 =?us-ascii?Q?RiAyQD2/XsmfzX5cBh6EW5I/D1IYx4/nHsTiXEwdZgkPu/7e3tJ3cZYI06XL?=
 =?us-ascii?Q?g8WKPn9spSBhdvhohQxO3kA6hAJRdJ/KD+15IoqoQg3c23krzvkbzqbgGK/4?=
 =?us-ascii?Q?swm4mM8vNaJ8IWprAq4MDSC+3TPwVNqj0Utoh2PVhcyTbCp8QkYBiG5yDyGt?=
 =?us-ascii?Q?NmkUH6LlgQLUGr9hGqcKHxlhgJHWBjOrTLq47Td+bfRIpHu6+atXeTi6TKZd?=
 =?us-ascii?Q?lZsScybJf28LfLadrT2IDkG8SuVHURL0A0SfTwyYC580KdLqWjmpuOU2ws+E?=
 =?us-ascii?Q?eqAvokjK263xvt0CvbrkV6bGdqdPn6omz/UTvc5mVI+kgc+4fp6yrcM0gUxK?=
 =?us-ascii?Q?/BCWseKEKfjyHhPbq4x1PTQrpYBlqKXhtOKqSAl/1YhCv908k+fR9WOK6v3o?=
 =?us-ascii?Q?WYHq+8nQuYTg7RMgxd+kvqCZKBp7Le60H9abgwBNVwjDZcp+gmkKuiOvTbdh?=
 =?us-ascii?Q?Xa0pInOxRKql8Z9Lzy1ZTcT7jvKUDrKOfSRcEAqYXRHQH8CTesWj5ZK4qmWQ?=
 =?us-ascii?Q?2VLuKW4I6yM48nb+4bdInT0vvCmS0jy63kVdw+nK8uVakJNzNVbgpBdLf6iv?=
 =?us-ascii?Q?xyLnE6xxfkQC5cPue6snLmmDhnWC8DNBHGBYpTNpK28dQ1YSxjTtLQ4Fszvg?=
 =?us-ascii?Q?88Avad4ZUL0eZ3Li72m6ZvipZIqfTZjUmpkP3oQHxyLaMhYpRtoRVzq4gN7A?=
 =?us-ascii?Q?S26mg1iAiwQ7fzOyuaTaJqzs6ZHT8h/vO+WSKiX6h3j4Emn4FGV5RNy90n0g?=
 =?us-ascii?Q?bK6qSK8rAUU5rWOysMkKHj7DgTatfDEQ569LWz0rqp2Kn3E1CxnWAiC7yy2o?=
 =?us-ascii?Q?biIxhX9PoBUQ0Ega1c+RY8s2eHbRCEweO/lk4e2J2awQmUS7vU1LQQWDBFjD?=
 =?us-ascii?Q?yZjNx6OEHx9vGj184DdsmuLMI2PvpJy0W1cp3a3cvs2SrUxkFOITh6UxAin/?=
 =?us-ascii?Q?Y556mInVHvpOtdQ+TXyvucMt3X+zcu64urymsOolTPzi8bziiEicnowh8Q1K?=
 =?us-ascii?Q?uH4TXwDX/ON6LDpvgR0CdJHqIM7EmqCPDTYyi88qJ4KCLDo2Ar2NyN/sPsgL?=
 =?us-ascii?Q?o3RQoauResBIrOvZZKvIi5dR6jYXv2e1vSGQwHAumrMrFEXXZGcK5NJAn5vN?=
 =?us-ascii?Q?hjIay6ag4WJRJflzi4Yucoa5tc6WBo4QYM8F5XD5z6iA1w3TdkTLMqbyMP9K?=
 =?us-ascii?Q?N1V9BVutiLpVeHvb/zPOmmZpRjl6xUZviRGkKjkORm6giNz91P16Vb+zVyuZ?=
 =?us-ascii?Q?BM+5+TNdaC1GkkK4UimGy6l52WUsaIiX6ofzA754lF879ZVGA1SgNSLiE4OY?=
 =?us-ascii?Q?iQFKjshJDjKWyADlYaJ9zqtY0w5TQO3Amtbw0PYnk10gkcIGZo6zgTUUSVNR?=
 =?us-ascii?Q?mKWVnIjKFYYVs4Ry0/QnJkVxzjhcHD/jZ2xyMkQtgbd1CukKHPSpgthvsgX6?=
 =?us-ascii?Q?r4FVDDKbcUHkyEbFUSTF3yVYRbtcjt+gAqC5QNS3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19183ef6-2e1a-44ef-bdd5-08ddad71b692
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 07:36:46.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQrAx/H+7xJyCDjIDyrmtV14exVnwo7Jge9V9z9bfe+7msAXBtC1FfBZ8VJDiZgiDwLWtVBD0zKL3uVa5uEvwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10032

i.MX8MQ PCIes have three 64-bit BAR0/2/4 capable and programmable BARs.
But i.MX8MM and i.MX8MP PCIes only have BAR0/BAR2 64bit programmable
BARs, and one 256 bytes size fixed BAR4.

Correct the epc_features for i.MX8MM and i.MX8MP PCIes here. i.MX8MQ is
the same as i.MX8QXP, so set i.MX8MQ's epc_features to
imx8q_pcie_epc_features.

Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..9754cc6e09b9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1385,6 +1385,8 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_256, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
 	.align = SZ_64K,
 };
 
@@ -1912,7 +1914,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-		.epc_features = &imx8m_pcie_epc_features,
+		.epc_features = &imx8q_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
-- 
2.37.1


