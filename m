Return-Path: <linux-pci+bounces-34535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE150B31237
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 10:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712AD17A01D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 08:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733C92ED870;
	Fri, 22 Aug 2025 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gkBx5DCr"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4D2EFDB6;
	Fri, 22 Aug 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852288; cv=fail; b=mx2/jq77das0UV7bqwVKIsgf4BucSHfHcNobujOSf7kdLm9y6IDZa3nuacyJ5M1mJjHIV7LXo4mQpy1380pUmxX0NvP9NUNacYWyMOyqicVPwofmygGbIudX8E6Ipw4R8JRwbpJbKb4Rd0GXZohQW1zzGb9jBcm0WrHNh0poHLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852288; c=relaxed/simple;
	bh=FJnYr8S3Z8rr3nJZ4PK31fYI5fMDywJW1iixA8AFG1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPF/j0NbDoo42Jzx/uwfsUHG+RGcYL3T2I3CFbgKILgbnOXWw8nhZfVB7kavUAJVHgv+wULs/eUWFIeb9beSt0eClMm+WBoXMQAfKElR5oclikYG9ZNnsNJk9wwHNCi7WHQp2U9vl1xDa7J/l3URog/AQZJmWZMAlEve/Dcy6Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gkBx5DCr; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0p31pY/at8+usz9OSajjkfIX+/waOAUEOR1AJFChx0145gihpe0FIzopV9YU8VJQHjPSj4+sPhBfpbzrPVFh6rLdv2er1DOD6k9mp6TyYvvTUuxcBa58ks74NL1b8WKaGHTehmJbdylRtQPoiHRoxVh/gjEdr+qrdDxJolIkBsBebrD62xe+pJ/1PFs34iqSWgihqaXqcMVxKf7WBfipX8JyJomO9pB5bIh3NfFSeTmYXD5FOvwtVsn2b6QfRClNjZiOMIxNlu1bnOK7XhKEGPiiEV7zZceRrqFk+mF983GoAMR6S+pcf4RNfZe5IVUqRan/jYxmXdY09l/i7snQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSZGv0FmqbwS+LbUjwsmHIWyPW6CsRO2Uw3DePhj1zA=;
 b=cuhDGzhL2pi2/Pc6zytsurtoUh55iFbiiuyffTuwq86jEQYe4MXpkOYehcmv1bo1HnfvNnW0PdNBnhAfb0LXBJzDOcvJGgla0Xxr8Qen1bkgzBuVsnoiWBTKEeNo3ajGTbYDTmDr4VqS0p3KzvUWZykOk5PglUFWPdssr1XIQCyET2pgrhvb5wzpPdSgg8/5+Xsp9fKPW4V4CA8gXsGLTTj8WD7LWZ0uT4zcS62JJMYe78bOeL2AT7XUQZta9H/Z8hJhEoL+TZKtO3H7yOFlKio1yh3ETQF5Q447kDP9d6mKnZied47GlQQTR7RhaQllcb09AuEoRKWFWY3ympaiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSZGv0FmqbwS+LbUjwsmHIWyPW6CsRO2Uw3DePhj1zA=;
 b=gkBx5DCrfrOKqW6qPRRpzl2I3KUs3aO/ermoXqAkBV2alwe/icjD6DMNyQZQPegIjR3yiwXexdwziOmM8/arqpWyOZ9Feg9g56JhzmkOp6sY+Qr7bT7amiasfRKr9ui+lwmG2+abIzmjmeRG+ux5po1RP9zzf8BlL/SIkMZi2P/sm06RT2sUOFze7r0/mzzhUgQlUJoOWFsvsBAjc/F0MouS/wQ24x8wVrcjbUbYccJKGAaw1FCVmJIYezSs3Cf3osoOjVnPc9Tq05ql5CDXg9FSyV5VPDFv3p/lylcfukuoOYwgeIDkVsuyhqGCmQPGF4HWURPp++xvHq+aXnygQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 08:44:44 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 08:44:43 +0000
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
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 3/6] PCI: imx6: Don't poll LTSSM state of i.MX6QP PCIe in PM operations
Date: Fri, 22 Aug 2025 16:43:38 +0800
Message-Id: <20250822084341.3160738-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250822084341.3160738-1-hongxing.zhu@nxp.com>
References: <20250822084341.3160738-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA4PR04MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: dde3536f-b015-4892-f9de-08dde1582421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CE3gOVI7N+yC8CUd5pzTTE8esSH8SZVBS4cFhxprw27xdK6cwS+TfbyCn4HV?=
 =?us-ascii?Q?D5wMulyZAwsQieQ4VT1INqH9FHfHjlWmf38jSgcIUsQvD3bcrAawBRDgmpsC?=
 =?us-ascii?Q?D36HYI8pQjiTLY5KmxiNYHGWIutgi7LmbSvs8vpmpc1MUJn+w/fpcNHjIL7W?=
 =?us-ascii?Q?etbR2Symc+GMel4XPMUFoQdYz2hLNtFY58335K9XWINh/GyzpojE4jLLSsnt?=
 =?us-ascii?Q?9+BquKeqPZK+0/TCFJiK6V2PJhzeDnOfjoD/wN8YBC5x94G4xXCJBI3ljezH?=
 =?us-ascii?Q?s9wAW/DRnnxXE3bncBniHxe+iLRPp0Rf726mL1ny5uYaMmBY0CVM3wJ4+raZ?=
 =?us-ascii?Q?x1HRbDCVX5iyd1mvacY7gcTdKdxEl+P2to0ZLoWZOEPZiqXfdXnKJDHOWwlP?=
 =?us-ascii?Q?3GJRTHJM5FzDCcGf7b+mvgqFS2nAorbFbK4EG9U80r5VZHprOe20VGkdOqv7?=
 =?us-ascii?Q?9OIwu33CCjTg9H7hP8Nxro1WF19Updx6BBG/bX+qTVJ3o4a6I1zwemCBkCED?=
 =?us-ascii?Q?7pZK4EM6O3H5CXq261X6nkIRUmeqZwhHM0+TIzDfkZ45o8mI1sGvEU3gyCx0?=
 =?us-ascii?Q?FE2g/ZPUA3/c4x289NFZFuBw800bY/DQ81xwSFVA2L1i7f/F8zUkw4jcv9JA?=
 =?us-ascii?Q?7Clc1SfMvB6Ed8GQvDmD0Cvl5rRExv6UI6AkPNXG7fsykD1074AtYLHzOB/u?=
 =?us-ascii?Q?iR93oXSeQAod0Tk3EOEX5jEp9M+RR6XwAbEbB8hdyP/259oXXNVLmNa004TT?=
 =?us-ascii?Q?VJYiXqkTgnPsxTkNAffv6vsoeWPbsZGi+Cr2lEMKVxa+KoU4RU71DkYB0kms?=
 =?us-ascii?Q?+8r8h9Mf9vmlMeVkYv6m2Kg2XBLoZSfQaRX9EuEz2ck7adUoQuxOFbIumgTz?=
 =?us-ascii?Q?9g+ER/EKAQYzEF+bYa0p/2gINV/+GaowHnMWpA90PdStTUVq5oraXWucTPHy?=
 =?us-ascii?Q?24Odr/JNWqBrk6FSWDNyRwtXpYQrKEjXSwj3e6uq5+5F+686xa6+mSmJ9Dij?=
 =?us-ascii?Q?HgrPgNZqhcPQ5FVUrbjpRYHnglLwpAzgUwytQrC5/uLxagacLShlGGQPOWse?=
 =?us-ascii?Q?pPpYt5BQyMOcI47u+D6+T62hsPrFGDS780RZr+2eJmhArPsbKojdV+faRVBa?=
 =?us-ascii?Q?4JE2jaGTEDQkbnt3Fg6Bj6I/6U7PhpbsEdR53LsOuCf8dYsSDwZ0CV1obUHu?=
 =?us-ascii?Q?RJ5UXRzK40N+q9X+qkZfvMhZmChCxnxKhZvmLV/FoxTFNnAzdCACCHIYOY3B?=
 =?us-ascii?Q?82bZ9TKYS66aRcCPGSVupcdPbtKSNGIdV+sInq4iWVfA/nd1R7/FOAxmzCfw?=
 =?us-ascii?Q?dOFUrAWAwJ6jheGogpFGGfbO5G8wouKEfHobRFbOYQJIbYk9bTQzam/WOyM7?=
 =?us-ascii?Q?SbKbN0x6GJj7X50Lx6JNKILKLLk5uA8AvX9NuRFO6V3N951yHkdhDHRk8s4F?=
 =?us-ascii?Q?iwhA6MIuC53u50lvbrbCIdvVloeuZXijCEoMeO1pAipHhb+jg/oWm6sy7gzW?=
 =?us-ascii?Q?Ae5+TOFbPUbCYKI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4OE2a0yP7x17xgUrAzRq6TejH6401SYV6YivQWqnOKSMdIxuj2XPfK3y9Knh?=
 =?us-ascii?Q?pdhR2NvhgiPhQSPwvpntHnhLijVSohRrUwqExrDiuXVUdwLpf9QfCD8VQgvi?=
 =?us-ascii?Q?n5mwgQ6fqitDa7S/vfvvNuaUzs53tVJTE7RHdUYLviAqm46fqhMDZwCDJTIJ?=
 =?us-ascii?Q?YdI9DgQHYsHyLXE+Oa9NvCygmssf+81fEGtciba85ERs4Y57cLPyZv1uYtSj?=
 =?us-ascii?Q?RRNxXwTgJ8iKtUECBy/aBiv4hzKVBwU17gwegFsFLu3fy9Vqym+TNEOPNkcP?=
 =?us-ascii?Q?L03qiRIJh15o1CiGnNG9VvFWgb5SRJZPi/1F32RMjf6aAkNWWyUmZO//PSyk?=
 =?us-ascii?Q?1mgtZM6KtymXXfBkZRuMqNsv1EmtwdNCEr2z0ChXTa29fb0o+focypxNtUON?=
 =?us-ascii?Q?s6das35+ceyr+S+AHlVa0W4BO0+cmDQZR59j+j0B4yc51fLEB+JLtZeBZSdw?=
 =?us-ascii?Q?ViPiYbdafPGqYNlJ8pbPTVVNYGryx9SkeXGePn5NfBhpIh4nfoQfcTx0xFGN?=
 =?us-ascii?Q?BdEuR3uIfypEqutBgNhsg4Sn/w1Mz+Lz88ZD1LBxd55RV6PT+aRlRGLZUPGy?=
 =?us-ascii?Q?9pufyuoBXGeDWQiH2d6f/RNUcUV6VgUk1SAqP+LRrDqp4qKXO3GSYm+cPWvN?=
 =?us-ascii?Q?/55S0zZrstf9vlO+36ohIEgZnGxJVS3RKOdIVxR3Bt8P5zVhJITLGfC8/v9P?=
 =?us-ascii?Q?y3DVbpFFRF0rui6iTEocC9I3VOW1PncVGYiJA0ajBv0Ct1bZxmGRn1fsmbFf?=
 =?us-ascii?Q?vfYpmGDjD7lsCztgey9Ei5ldllG5YBzNgm1gGZQKdBMoHkpkx/Rz9vAW5X6S?=
 =?us-ascii?Q?hQeSbTS8I1KpmIkvX/a+rXLuA6IvuPuzOMH355fVXiGfE2AUu1848Sv6vjuM?=
 =?us-ascii?Q?xiUns89momxTamjCvqZWhtj6UkOq5i0xAVooKMkIbvMR9E4aOi6gWQXMuTEQ?=
 =?us-ascii?Q?WMRMy41hH+b4qeWNdOmsI1ROfLXkMAbVVNM3QdllxGnjsKcA8AbW5dsWvmp0?=
 =?us-ascii?Q?8MermmKsZppeVOTfvKYVjufsOVusmeGEgPugrf1k8Be4VMUJv3IK+RNuhFko?=
 =?us-ascii?Q?0wWQb3w9oUYZyhz9igQ/zd/2mv8P5Jq3FQqlWnF74j+xjozCrP4lWf7Cjgud?=
 =?us-ascii?Q?AWHCYk9lLtwDewWC9z+3TAS5Cu5Xmby7LrqUslMCg1hcf6bETXKgwHJy0UkQ?=
 =?us-ascii?Q?OZ/37E5SI1JwX4w+2NVDjY68J+bpvJ8m583EBjLctVOEj+gSJte/HASSiuz+?=
 =?us-ascii?Q?NGqIHq+ISELn9I30WXvksyHv5bH2rfs7O3RQYAwnnxuLIwIltVmvziH9azaE?=
 =?us-ascii?Q?UDlKogZA/OPKymY+1UJY5dQ9QyjNHp3u/DBly2Kusq8CiT9tMd2kNwMCEgxS?=
 =?us-ascii?Q?t19VQHji8QSCxac2Tt8JYIW4t068Vrov2FULz6e9RMuCYFGVqYbTBuM0enoE?=
 =?us-ascii?Q?Fr6PYZirgbnQ4nD0JKDPuOS9zXnwTtxkZ0Wwa0ekPGxTBCA4Cp6AOpKbXEbe?=
 =?us-ascii?Q?hHmISTclH/k+UdIe+ncqtKMeV7eAI8IvO0Vo+N6P2EFZlBU+AglxPyi6p5/N?=
 =?us-ascii?Q?dr1++QIWOYuT9+KWAIybSGUJe4aSZN1AWDj3oasT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde3536f-b015-4892-f9de-08dde1582421
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:44:43.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCSzTmd71aSy/lJ4sTUsl1NmwFnVyGYAqZ076OtePpxv2dGgHHGZ2b5woWyePVRJzQyWrkN4UbbGlfvDlEd0OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7630

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe are inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf6..18b97bd0462bb 100644
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
-- 
2.37.1


