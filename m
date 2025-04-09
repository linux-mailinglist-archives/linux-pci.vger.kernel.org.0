Return-Path: <linux-pci+bounces-25573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E3DA82954
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E86E90690C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9C267397;
	Wed,  9 Apr 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="QQ9nnEN6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2113.outbound.protection.outlook.com [40.107.105.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B178266B75;
	Wed,  9 Apr 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210188; cv=fail; b=BcCqSYioRxFFcYe8aEx8UMBPr6wMNvGl8U0ts3RyT31f6xZpV4qRuG/4IVOmWcVAcH0uXeGIRXEWrrGNbebY8lKfQfdQuNnmSeqiLOACxnZmdBBisSEE5YGZd4q4t7WFCzeYQzV3OC6VntCKhqKid+QB3pvFaYNMOGpluv4siSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210188; c=relaxed/simple;
	bh=NB5ZpJCVCOJiihyteNaUXp/3M7syeBB2lInwHUBD67k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m170Zl5P5PdMTCB9d8clX+BXlaOba3F2idvrKQmzEc9p4XQMDVtK3ycZVan9LrjQHFYFeF0+6bR+zdNcIwxfQ7o0NurFWQtWaP7et5St2tP6R3Cvkap9F7azJYYYFHo+g7NnmBbqSiFJM+QvU/EfIQH1etQg+gmCBTM7hKX9tG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=QQ9nnEN6; arc=fail smtp.client-ip=40.107.105.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADhO7a3sTtFVKWUtorxabs4FYJOq9k9EQfTBXN1Zoa8oDdea6GuCiGMV/zISXzDj0fuWKMngB5sI5rlxvNtH/75GLTA+XdbIHzL7WtEkSheqo75iiVXld7HAmjI/rCGy9yMN8Y9Nj5r8s0vZGEuWYlqMbsbLCMycsFTWlthW8b6BTwDEihckLODNVashIiOiGABZBeyb1uCm/iiil2NYd358p756AXuGxpbKnX4GsiFEVxVofZJWcxCode/IeyplpMjRWBNmNLkD1QRhk9b3COM6btzIsJNHt7KJlT7Ut/hO5uqmWaTlHPwKGpkFqODzRZLDGk2RsX5SbdeSqulpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFsojQkjE5+qLRt4ZFFghJ+cfJmKYX9alhI5Zh/AySg=;
 b=Yn2IilHTHWSFIjTyeGLNMxdoO3rjQ60JDnkMaUoyzPTbZFHdJu6dzzR2KJtHV8VTNqO8HtTNAr/dtNJtBTDeiQjfcTaDeizjAqBWq3aAhndQM7ubcucZf5jxAxACSTLcKmMIj9UbIWnkEhDZLAHV9vxr/CuGGPehcqEe5ONEEey7rbyN9iBXW6i72nuhpTr4pxilVZ3vuzRDPDenZ2LF5xud4I+3Nj2CKJue8XXA4PNGox7Av0n8viqIu6/ag/4hIQYz5qprHiMZxacZp6MtEqnHAIggd93mWG94BqSBVpklDCVfJ+tOPx8Eso0bXMLBiOs24VuwgCu9DP3BG/259g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFsojQkjE5+qLRt4ZFFghJ+cfJmKYX9alhI5Zh/AySg=;
 b=QQ9nnEN6q0uK7hJSOQ62syej6xQwLZSsWuVej1wzhbp7ZFe+GExE2gKJv0bYqWk6mR0kfE/LEgq1KPc3q9sGvsZQLmnluzEXNLDQdu9L94jrw5ltztLC/kNRiZp1gXPVQ3210/BQYukcBZfxGBXqXl7Ld1Irp3385/2xcUSAPO1tpqbiilahaCQD4ICYW1pL9pu4tIqT3VXaJN1HehC9lr7qWpv2uP4Jfv+jO1ObtKqJ4MpEZka/HmE8aseRrNCd2Ty0mEifmvzPfRPM1dvdmjEXIwUsNYpqGG1g6f/QxQV6EaCqXkCDhGDB+FFhb0mbPSL5KaIWv7E5Svtd8lJnPA==
Received: from DUZPR01CA0216.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::14) by PA1PR04MB10916.eurprd04.prod.outlook.com
 (2603:10a6:102:483::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Wed, 9 Apr
 2025 14:49:41 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::29) by DUZPR01CA0216.outlook.office365.com
 (2603:10a6:10:4b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Wed,
 9 Apr 2025 14:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 9 Apr 2025 14:49:40 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.104) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 09 Apr 2025 14:49:39 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM0PR04MB7155.eurprd04.prod.outlook.com (2603:10a6:208:194::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 14:49:38 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 14:49:37 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pci@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] pcie-xilinx: Support reset GPIO for PERST#
Date: Wed, 9 Apr 2025 16:49:25 +0200
Message-ID: <20250409144930.10402-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409144930.10402-1-mike.looijmans@topic.nl>
References: <20250409144930.10402-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.7d136b9c-d113-4bfd-af7b-10cf34f20342@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM0PR04MB7155:EE_|DU2PEPF00028D0E:EE_|PA1PR04MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a11ace-7d23-49d7-e7c7-08dd7775c218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Dy7znNuRh5ZeFNfJE1MhYz05f5MYzxG36yXXr1MQqnb/EvMi0YmsvI3BdLq5?=
 =?us-ascii?Q?r5uqiBSsGlhjZ5jB2gIVjh3j3mD7DjuK+dXayQgERNL0wuyHjf8J6hYziwSs?=
 =?us-ascii?Q?Hug8DExzhaiCndpjiL+sDvFZdu9t8ZUtEW20tyy5EhAQwAW3EbhhYYgjhx4Z?=
 =?us-ascii?Q?FlKkXOLtL45NxrwFFJ8OTEgOWZzyUkUP38NZuWHLHGhKKTkrUAaM0JUOoGwB?=
 =?us-ascii?Q?80a/FRw5e+GWlZY6fVzu2eihdQJElkpPZptnReHywoK1tJaHcjQB1+IADz3s?=
 =?us-ascii?Q?6TWUZkdnifExKA3uXEGVfPKZGmZBNqdfcn/Bic3JI/RjOnZ89AMPOP6ljbdm?=
 =?us-ascii?Q?zSddynBzss7Q1p03N4NWRoYaWYbceAyOOI0dt+MFRaB1HXYirG9Alt2wvpCx?=
 =?us-ascii?Q?bDELG93xYPCLmJRy1zuVyp5KbAHbunm9v9tf4u8K9zJhXN8LA9mxB1BNfB4w?=
 =?us-ascii?Q?h90a2P6e1LNCgxnbTSwabSX29svC7EsoI371zkY/9aiD77u+h7AIBEwamDPR?=
 =?us-ascii?Q?j7kZh3U6oIZxt3kniRxVbsA4U3xrDmlbQXImnoHuHmP3fFv2U1DCAV1qyTIk?=
 =?us-ascii?Q?0ZyS81cwFGiMfFwhLnRXmrTEE+CPCPEy4+cwXWimDFYMSWDbRaO/PjcsryP9?=
 =?us-ascii?Q?wrw6NWjkmnUMcjKjt5OrKy3MggfFbkDc0ZFhctuwjM9ayJ+6RreTg/0ZaHts?=
 =?us-ascii?Q?qAXP1eoklXZvbvTXu/YM+Vd4tMcC1DmT9TOvF/UhNkzAHyKO1C4NWi0AocWc?=
 =?us-ascii?Q?KVYhcfFB/JD6rFmYw18+SxhrK+ipBAaCpJY61d5k9DzR9g7OMebA7fJ1gUx8?=
 =?us-ascii?Q?TlvxOlPbRg5zlrx6A28NNyHvMwLNZxmRzOh1fj07U0dG9jXqSmc+It6d4vf+?=
 =?us-ascii?Q?xbQKneTMYvDcMYiKH02esypio6ODbF8DcSXSV3YL/ULrX4Blsswb3bdKa0Bo?=
 =?us-ascii?Q?/+1f9+DARwuZpYJqKm/D4bdukSxkpO271J95UoN7HUAiXcYf10lrb6d7Nw/D?=
 =?us-ascii?Q?wO+Xbcz6C7kWF6DY7+l2vqzAEKdh5+lbAcZ/UMcWFMWcmNdZgVywWHhz6TCq?=
 =?us-ascii?Q?s4KPnT/Ihh+m+ljlWKQXALU6C9ceajnvBWxFLoH6/pdZnxQeP7YtWaHt/1iw?=
 =?us-ascii?Q?lci9ckKoiqMmrjRGL3EIVJKeVya6V4PFyVxAHm5vab0LAngsUDTLZcu/qDNh?=
 =?us-ascii?Q?JKdIT8AEkKFRR1H7v8+jJU5fOPWdqq9tP9Nn5e8z28omB9zdX6iVmX82gjOR?=
 =?us-ascii?Q?OFk6Sv5h/MJZotf09b9e0e+139lXohpIVBRcl+d+AJNCPjRvz8JNzhq3kwc4?=
 =?us-ascii?Q?zy3FPJG4YwlN34XSVFy0LXnemWl+4ssZIayE2FIhjjnX1nxz0j/EW6FTeJuL?=
 =?us-ascii?Q?JmU1MAkZo8K4XHssCmUnPSuaedbFAUrKuC6SCteXYGMuDH3z3Rs5FlyHif4I?=
 =?us-ascii?Q?we1nQ26UdZv8sLDvZqH90B3MDUn9Bptcn/3lb6sQWbnITStOerUrRg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7155
X-CodeTwo-MessageID: 6f0a156c-86a5-4acb-a589-074aeb2c224c.20250409144939@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8628d9b9-84c7-40c2-64ec-08dd7775c00c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|1800799024|82310400026|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dri9XwrusMxcvrCezs7e3Xt8aOS7Cy1xJuwnORx/z2DS8R6NMpEG5rxHXcYS?=
 =?us-ascii?Q?nqIKXv3VJqafN+ZUEZZhQ7K/6zIaqCQ3iXV/kLcOAsyyB4/DG4W6bd2CIkQo?=
 =?us-ascii?Q?Sew30/NPZDsgAA75FOoKFrVJ7kpPLnY0tcjxkLRyk2y0L0F1jre1eN6fRUY+?=
 =?us-ascii?Q?92bExXJvFFHbhoTZBfbQC2FMF2hJYk0BaHuX9TCLy36OjTzsJX/51Hjd/l5u?=
 =?us-ascii?Q?oRsQZ69VWUE8KTOoud2kH/kb2ogSgPm+555AhX5XKW+odkdcNPP3leuXGPeC?=
 =?us-ascii?Q?i+gA3FeEzX3Huvlhd9AZo7mgKsWUalW56MOgw9IEDbM+6thfd0BtShdr5AMG?=
 =?us-ascii?Q?AEub5xPwSgJlG9xCf4oSVOJX96Y/Qsn1h7acZjwS+lOD7lMDLmR7KEG5wkrj?=
 =?us-ascii?Q?w9dJkGGK8lyIWHk7oCwZY/IpJOmku0aeok4Kz4Bm5y/KLZdQ6LTfGUQI+CQQ?=
 =?us-ascii?Q?Q76n+purtKU+uv3GkClgF5pBFX1ewbtQ04O4VFCbUumdkdQPH4RJlFCl0b8g?=
 =?us-ascii?Q?6CwlKxdUx4y28M7ITkrMebe/v+oAJX2Y/bC9S9Purn3JpDqDytUG4kWtdzcA?=
 =?us-ascii?Q?ZLQP/I69a9ycEGDhhe36e0zwV4GnjiR5Xoeu7pWtRBgpwasMojh2G/hPyLzb?=
 =?us-ascii?Q?br3W923ws3I+KUmWjA86fK+6f3Bfy2Wzw/artx5FRuOY3vSIU8Z5TAS95Fsb?=
 =?us-ascii?Q?xyNshla0ChAs/krG0i2lo2gKsR3b0gLyb3av62lOuuXZv3n9zOQ4InQtPe10?=
 =?us-ascii?Q?9g7OpSJda/aEz95zHP/+gFe3J3UcRW8BnRTnX4pTmXe1cvyFfJpFLX8tlCnK?=
 =?us-ascii?Q?4Lb1p1uTxf73TMgFBdKxCAImImHZf8nW3igHtBFtc234qNBv+shzJYxHI7QC?=
 =?us-ascii?Q?gT495rRMi4dqjiiCYJxelrNdwlR245pgMA5I+FCVdPBBiFy+tRqQBzxlgjnb?=
 =?us-ascii?Q?dq4cws3TxPgwsg3bVQswCwmSQxdLo3NidQpiYv6NQs8UhAIc08gNhI4o4Wl8?=
 =?us-ascii?Q?BiYbzq7pSUdOYORXCBXoT8nunGNkSvhvtTI7rJPS/MKQQTkd0EvB/REjjsqq?=
 =?us-ascii?Q?D91GmwI0ivYEiuexIzza9iSJJQNhSJtumP4xRFb4Ys+hxy0UWLcqe2vsJT/J?=
 =?us-ascii?Q?Zy4vXEMnbkG6zECHDm0woOjkUMOWWDZA/9B7ZZc9GPOheHTOHZdAT8Lcbbxc?=
 =?us-ascii?Q?eKL7lUSvcWfcUpQMd6Wrf1/rQnVUHhoZT4cP1bRNMEvc555c5B0m2B4fvio1?=
 =?us-ascii?Q?kHbNqZaiTXHcp9WTBhaGZkES5jDbIyylwRyeWZz44FJ9NpvoILdLYFArc8Hg?=
 =?us-ascii?Q?7mULWHiBVodGgEBlCBeKYJjZ+MT/EpCn1yjRl6uSUrJAG71zMt2p+JPCuaQw?=
 =?us-ascii?Q?fGMJtprIA2621oegyrwHYQ0y6w0fEU6E1QYlYljaR113KujiUBRjiKDNdmQ1?=
 =?us-ascii?Q?WIT4sqUFDz0=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(1800799024)(82310400026)(376014)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:49:40.6050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a11ace-7d23-49d7-e7c7-08dd7775c218
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10916

Support providing the PERST# reset signal through a devicetree binding.
Thus the system no longer relies on external components to perform the
bus reset.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

Changes in v3:
Include linux/gpio/consumer.h
Message "Failed to request reset GPIO"
Use PCIE_T_PVPERL_MS and PCIE_T_RRS_READY_MS
Dropped dt-bindings patch, not needed

Changes in v2:
Split into "reset GPIO" and "wait for link" patches
Handle GPIO defer and/or errors

 drivers/pci/controller/pcie-xilinx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/=
pcie-xilinx.c
index 2e59b91f43e0..8e8ca9891b36 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -10,6 +10,7 @@
  * ARM PCI Host generic driver.
  */
=20
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -577,11 +578,17 @@ static int xilinx_pcie_probe(struct platform_device *=
pdev)
 	struct device *dev =3D &pdev->dev;
 	struct xilinx_pcie *pcie;
 	struct pci_host_bridge *bridge;
+	struct gpio_desc *perst_gpio;
 	int err;
=20
 	if (!dev->of_node)
 		return -ENODEV;
=20
+	perst_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(perst_gpio))
+		return dev_err_probe(dev, PTR_ERR(perst_gpio),
+				     "Failed to request reset GPIO\n");
+
 	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENODEV;
@@ -596,6 +603,13 @@ static int xilinx_pcie_probe(struct platform_device *p=
dev)
 		return err;
 	}
=20
+	if (perst_gpio) {
+		msleep(PCIE_T_PVPERL_MS); /* Minimum assertion time */
+		gpiod_set_value_cansleep(perst_gpio, 0);
+		/* Initial delay to provide endpoint time to initialize */
+		msleep(PCIE_T_RRS_READY_MS);
+	}
+
 	xilinx_pcie_init_port(pcie);
=20
 	err =3D xilinx_pcie_init_irq_domain(pcie);
--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

