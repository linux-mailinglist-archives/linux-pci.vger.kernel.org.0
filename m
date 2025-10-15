Return-Path: <linux-pci+bounces-38114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1893BDC42C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B63B94F8189
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D528980A;
	Wed, 15 Oct 2025 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ebsHWmOy"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35C2BDC10;
	Wed, 15 Oct 2025 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497536; cv=fail; b=Ibtgz6DG6nQ1z/KDxC5I7LMUq0SW8dd/RYBh7iYXG7mXXR2jZOKKFtV4j2MfVFinkeSsl5xlCu2SJmvSafl8z/kwdX11DHpo2izoc1VakPAU/ZmCKXVR3D3g66HFvKzk8gtnwCOs3JLiulBMaJ+D3FtxAnb+NMHgs5atPe1K1gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497536; c=relaxed/simple;
	bh=XKAOdzud6YfE2sw5R5CkWOSYC+gV1CtDaRs5Al58ZBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RBefL3vbA4b3p1o31QiVBfH0gO+4XypZk8s6In3Ks1H21nwvBzVPptBmukM1WTIJ18EC5+Yv4kCs3bwuaMqaXk5OJ/a1OFFZmjuzG4xwV86sgC9Pr+m6Ta0nqbJMIaGCsIMVne3Q2HqTFXH95CLQozY4+4sSR8HWKLMqirnsUmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ebsHWmOy; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjMeF7V8TB4yDKvnEWyiOcnBSB/0AxC2ILEnd8IVqYXGWcCdpXhmcMU7zQDIkpM53VamAZe49yOo+pHgk33BTE+QzWSf/zKQsxipOwkGYMaxmN9b8lcMZoCO/5caQU5beQAxEh8n3+yZfbAJhR0lJOdyCJVqkfrHNgXoza0mG0K1uuXhKJEU0eUyIrYwBa0VEgoPUlrO/oLYCeUbVUs7iNfsYJgdxplwAkrhwgdcFkNFdbaDFBUnGmuK8NpJtoXFb4cOhuBWKJneLXJkEUUaF+JzD7DGq2pO2FOYduNoUHceWXVtu1rRvxPU2ib3zCUMbG/4aF0Kgn3qXjz4o/9FDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Nz4aanaImHa1ZgiBzIar+fJLAS+UsUFOl8IDaP8sXU=;
 b=w1mwOQER06bNJ4VzrySMorwj4ffNu2MXD++a21lJxNZGaEV4HWjSO5+2+MBpIsKjnIWACP3kjzvZJ4wTywxdiF3OKooD/1vVjqqFT1w0AzAm7giq7oRAr7oY/ycHsYJcO+hOsF7M9LGidfsPzVKFoCCl4AXkv4UMUQnYGuTtn0C74tnEvvR+76U4SpihcAA+Pmebo9Hd+y8HkTsEQzV0oxciVvxmskMDxwJVDqUWF09vJhoITlTlqZrY1KFPDfFssPdksfTYclYaOKjJPFXBq8jJ1A4zhJNilgvFBgq1RtnwBUm/ZTLmoLp4OsrbJlPeXiVMUhpmIHHpxWQ2fYLr2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Nz4aanaImHa1ZgiBzIar+fJLAS+UsUFOl8IDaP8sXU=;
 b=ebsHWmOyhu1lZ0nhoLC8ddf+m1bGkH56K2UgEQw75TusodOb866jZBw/n6VUfW3WYzTrsAWWzna0PcwR6/qwVn0KeOSOzPchucAXnpPfv0+x5Ux/Z0CEscQeNacUL/yJhriA0LSNw8EEmvuGm8BdDXv6Z/B+nh+qpG7Lqj9xuZSNjSiTZ8V/vJ6irZjsynATEETfZBENGuCIYMtOLSHiwqfQ936yLWupmLhAMbwCpxdnA8OJIDD9xVT6yQNKDT2NQUn0Iff7xIEdxDbyIm4dyODqUzasj6ZkDarzifRieMJw1kK4ZFTcxTOScAlO/gFy5n0rG4atLME5kwsQO4+iLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 15 Oct
 2025 03:05:31 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:05:31 +0000
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
Subject: [PATCH v6 05/11] arm64: dts: imx8mq-evk: Add supports-clkreq property to PCIe M.2 port
Date: Wed, 15 Oct 2025 11:04:22 +0800
Message-Id: <20251015030428.2980427-6-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f47cb14a-8ffd-43f1-dd3f-08de0b97b38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9dExqNSjKdGbiTtlxI+5nKxL/kYo2SoFYmfcXJgFJBOStjpb2cv9yNskan6V?=
 =?us-ascii?Q?3D6XNKNG9iNN7vHHozrCszbQDaxA8aMPt4+69TETqtgHTLOjwE5+I7q/KLBb?=
 =?us-ascii?Q?hthbyqmpjTtZO1z7ULGWT6ojJwRxEFghSYGz+h6X5B5SPu2J/zz4S6bXCcB3?=
 =?us-ascii?Q?RoCa3P/tt16lU2YBrue4J+mKhauxUdpET2JZbgSSIWI+zj4vpmI+E7Say5nP?=
 =?us-ascii?Q?TPHpHiCkc9nvp9hpb2HWQfdksLu0qvALwJgdquyEtw5rxr/AMNB6JhDo3ink?=
 =?us-ascii?Q?IeSZM2CVICelI5E3ZhcjUdGFf3Xn+sWjBFUB7llMTM+LorMWUXvUcVal6RWQ?=
 =?us-ascii?Q?wT/C42HDGDABz3zTZ1hR2Jl758IVNENcXV1BJLIXdKQ3oGu+aOqkzbb3t4nG?=
 =?us-ascii?Q?h+YCPf7aUALjklpe285/qoOdnqddhGS0ZootDUk84hy351UoCig/4cfOm1Rd?=
 =?us-ascii?Q?4HC6uIyXqaLO1iLbrGtF2aYDmpF5seW0tFAKpybJXPSTpXGqaSi3kwGtSVVh?=
 =?us-ascii?Q?UbCJJ0wQQcOwWUBr3bDZRgUV/nWUy5KV+Fiy+WC4X5sO7LINQE7rChhJD38h?=
 =?us-ascii?Q?2rtQheSVeHN54XSEk44yQ/dSIubtbhSfW2q3ujOXKED/r8yV8VN5G2NwSAqy?=
 =?us-ascii?Q?2hW8L2LlRT2T7xJsltqGlJuH1k+9CsyB0fuy0sKsPCWQFlBX4EaM7VV20aD0?=
 =?us-ascii?Q?INA+s3H6Ct2Xa8ci+vOgpSgMii7f/XKIc8krlGcd1o/koKJ1qAR0LQbSoRME?=
 =?us-ascii?Q?WaghbJ9aecfZNIBDhz4kRYbRqOhAaYkm7Y8W8wHh5tuD9ILxD4OBZtmj/9B1?=
 =?us-ascii?Q?EnroE2kuoTEQWs036wkNy9ui2nRUIngSQT6x2CHsl0HsqGgEGfOpvTy+xO6y?=
 =?us-ascii?Q?TfmKMhJeBidDB7aHyeVNPmJfegvLFAfjchd1pumOKEAEKy6F2VLqnmNZjeeh?=
 =?us-ascii?Q?fN3TNy+qBqqG2/SxsUqO7dUlLowcNpvQTLtSj4Uh1liXf+0g7wqVRpIlXwav?=
 =?us-ascii?Q?TJoEzBLoZilV5kg1eSOA8bi7DE7G3IQKLUYj59Ful1X02DSiAaXwqS7Vov/t?=
 =?us-ascii?Q?KlG5XpeBEMlavFdCxu7M62uXsx43S++9TDHSpvWtH3rn+w9bUB0caGAzzISJ?=
 =?us-ascii?Q?oZDqEHlZzAewyKtTt75TbV8ECsy/APY+1ZU8EdiPT9aMIQGiziZWnWGEgd7J?=
 =?us-ascii?Q?pXQyFOcapyxQ23TMfx+UKk1WG49I5/K16x2LeP/vQ1Ivh5G96nYDBk2b0ALs?=
 =?us-ascii?Q?kpd//idmYSgGQqfJeCbvHE23qgoAefEYs2f6UR8cx/TBVPx7iYgAxc5iIdBL?=
 =?us-ascii?Q?tQt5rUd1pjvft/2xhzcgCIutJuOHkGkClo5/gr5P1xn0SY4W2WKNtsMXmcLs?=
 =?us-ascii?Q?4gV7k41V9dMaTpgzgz640AxDKqCZ8XXTdkut6gMaAMjWT+CpNSHcUPa5LKnf?=
 =?us-ascii?Q?U8ArgVjINBTLL3qgUON8uwyrKYHGokBZbzXntnvXfFaZL9PJwlEkhnU/NZ2q?=
 =?us-ascii?Q?TEByZMQ8o5UpGm/a5rEAz4HI6iL9q54rbqDBX+ceP1MadBR8hmXirXSoSA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HtH+AZuKUdzJR6F6DGPfpGGlrK//CtOUcandXhlFAGU4bNWahpELFnFh0pDZ?=
 =?us-ascii?Q?Zg4/HDNtHtLbV9OrxjsGhZpQpHeIah3xs9nBuEa0j4vNK7XawxdwJCD2kJTm?=
 =?us-ascii?Q?Bua/DG6XmYmy8xE7C1Oufj+sG1Ymhm8mRNWI/yF7dOfTu5NDnzjFb2K+hfCP?=
 =?us-ascii?Q?Mj9yKvgILfQ6B2wn+ckPhYdjkNRUArJBXHunv/k3XlnHF8Duv1GXko9mPdu/?=
 =?us-ascii?Q?p2c0JU3STRHGykVKi+KEXx/KYp8ccuZeEpp/d2FCehFsOaai0/pnQEWBfKVA?=
 =?us-ascii?Q?wRaiALDJa7+hblPPoyLWx9gZNz3S6aUEts6oZ46Bfq2nuq7Hk6jJnHBbR2CN?=
 =?us-ascii?Q?iWWYAnsTXD0PrYi1uYucCY5Ywe+c9fP+kTjuCl2nd1oPzc8T5hR2U+/BKveY?=
 =?us-ascii?Q?OCP2UurdPdG/6FZuer/+MAFoQUEH7UVFF2+NLOtJw9bC7Va2iGWXobcEc5Dg?=
 =?us-ascii?Q?6FoRSUMBDKsdeMBswtLW00UWfLnfPtRDvKN1Z/hYN104CVvGQbbX5zqPRDZS?=
 =?us-ascii?Q?bE0VegHJ30D/edCy5H21kBFpwldz5QZVzLz1/NFt9vw8iulvAHTEWDKNmlOK?=
 =?us-ascii?Q?fsY1lOZ0bgwbwFPHSiGlmSmHIUv8b6t0i1ZAD893YQXki705ihWr6TeghmVp?=
 =?us-ascii?Q?wpTukhufBZPbht9mbNE3k9UWhXPcC16ZrTSnA3SAvpiKxZ84E5e67JKVqHCL?=
 =?us-ascii?Q?Gvy8lkddgKZ7NS38r1ytIH9Fv555NijpXEQqsFwmJ2wT15cdCJoyBHVmrG/C?=
 =?us-ascii?Q?hSXXUwTZQcjc0OSuZX6AioVcTCZxfiUMIk/qxBywMY65d72KeUccTQw3qbVw?=
 =?us-ascii?Q?zcsDwfSaUvZ36lBRcTQNeOPfYnKUm4M1KhwX0n0DrOmVPT9dPDBVJ0SUxa13?=
 =?us-ascii?Q?pvAnDUH9sjymAHCp+ntnBZzLmjsBKzy6kwfrhTnW2eUe7gHIkky7alk0kbqj?=
 =?us-ascii?Q?9ib+WHGtQdQcZzHebaV24Vvu58oPsCzL93uN8Uz5GojXxIEodFts1+W8NiT4?=
 =?us-ascii?Q?VOrA85VwQgEDEQRNx88v27qHQlalSEjLLkiTDHL+fMAKAdXiOAm2X9jsDygP?=
 =?us-ascii?Q?LCk/UrtDm7kMTRYcaSybQweAlND2sHruUMKKDlPANY7depZQT7DEXprvgg/q?=
 =?us-ascii?Q?KlJSnbUtySkHFI/9C4BG/HtQ85gyGssBjtsgt0SDBpzQe5kpZM9UI46d5vYZ?=
 =?us-ascii?Q?dEQl/9aPFEL15VJL7pVbkWXPKTZ7S3b0v/ZTvvVkmR7w8V1gNwnoAnirhpiR?=
 =?us-ascii?Q?rUFrsuL4pXB3u7rb1SyTJZHxa0+XbIWh9DM5pWRayr/3aPu4Bc/OLgFO3lgE?=
 =?us-ascii?Q?CfgI4ajxeb570llkZFmeGM1yd0+6d2YYRzS7iNMVjctBR2ygbeCB4ixAVAEi?=
 =?us-ascii?Q?qYSAFFZ7Ux7YuFubDSofYnM2a1F9e7nJBpYiQ3dolWzGbyG1Xc7kgkru5WFo?=
 =?us-ascii?Q?CoVuKwITMdjfKxBa0x3Htky9ueQKgLJx8TC64154QIqmNLYvobVdjy9tUdcs?=
 =?us-ascii?Q?S2wo8jHFW2g6WA6mvoWHlhkB1tLhGKY7cvR8NnHowo3JuZbUbD37Vuvfa1Dc?=
 =?us-ascii?Q?W5HqV20F6av2mA4sTUVke1WdFGgSPoPvEeaRCIXx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47cb14a-8ffd-43f1-dd3f-08de0b97b38a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:05:31.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyDzlLj/OP3QgthfMXjyxQcZzFs8MdxqiGg9T9X/ipNREIqdW61TbAUxJ0sUDfSArP49VTb6pQnCylNp5ef7fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006

According to PCIe r6.1, sec 5.5.1.

The following rules define how the L1.1 and L1.2 substates are entered:
Both the Upstream and Downstream Ports must monitor the logical state of
the CLKREQ# signal.

Typical implement is using open drain, which connect RC's clkreq# to
EP's clkreq# together and pull up clkreq#.

imx8mq-evk matches this requirement, so add supports-clkreq to allow
PCIe device enter ASPM L1 Sub-State.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index a88bc90346636..852992b915a39 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -375,6 +375,7 @@ &pcie0 {
 		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
 		 <&clk IMX8MQ_CLK_PCIE1_AUX>;
 	vph-supply = <&vgen5_reg>;
+	supports-clkreq;
 	status = "okay";
 };
 
@@ -398,6 +399,7 @@ &pcie1 {
 		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
 	vpcie-supply = <&reg_pcie1>;
 	vph-supply = <&vgen5_reg>;
+	supports-clkreq;
 	status = "okay";
 };
 
-- 
2.37.1


