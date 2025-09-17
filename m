Return-Path: <linux-pci+bounces-36312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B62B7CC66
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423DE1896876
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 03:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E98277003;
	Wed, 17 Sep 2025 03:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ATssKLFr"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD2926656F;
	Wed, 17 Sep 2025 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081103; cv=fail; b=u1YmPlQ6uXQtP/xbdbZoaOYEetlJhSM8q3RJfFUd+BUqCz/7lOwR3IR+ZeDd9fojXMqJeWCOIoCXlJ0HNHaCQyqypr4+VByAjr9CqNABMVHjbEHoiSTzFrorke0LaRy0ZDd1TMGV67HsudXcJSXn7bBHEVUEOuNH0AO8JYSyMMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081103; c=relaxed/simple;
	bh=1ELCEYemJ9jELZo7gGyZd2TB4XbH0UL/72NaodnmqLA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ny4CdkY1DkNBSTsuQws3tZ6CnulFfuyGwtrOTWbBgoGk4X2IK8r73Y6eHwQvUXjkL9XnvRRaTQSqHlGAGc2k5RyLzwJrr9szDIiMR2gmqVJnr//RNaSya9shZ4uMggZlr0hExqC5kGR/ggle8MbfeRiTJplX3bX9EvFAqd1b26Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ATssKLFr; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuSnQ3z5/zCYb5voaWSfwc9Oc/uDqwjzFhNKhamNz+GqXSJdLiRAvzNJ8/6l82eVlBlwJZYMWGOEoL4T9nBFDPqP+w3taxgu4nAFag6dfFKLlbgaCs6ofDO0/GneKL6Xbw28a7hLPDaQy9RqXzDGLXZB8atySF5jN0i8EojIPvA9AxlaO/l1oyIm0huIGeui03uUJM6W0qDXlW6kA+r63EgcWW0N44THcvZpNzIGe2cKvUdaEqjGfLLpEq4bWITa+rJaPo3tQxLk1CNrKaaS3LdQFsIugnuELprGp/uryFeAI/c01/lJS4Zovo9yrvZRN6/Fc/msfqKSkG33lKIxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxbf2rsem9PANC2JoS2dYaDVI6O8Vrk2h5yt3UmXN9c=;
 b=ir4vZo9qiJcgp2+5atp/ARp69+EXsPUf5OhV4aTKRW7sgl9TTkzUUVvwjvDODN4VkqbRWFkLDTKTy+xLs3MHaTynsI03Fz2DmaGXRW2TFTF0CmScT5U20JZc+nGHWRQisM5C/Fp7Ies4vupc+0nHoY7e/XSE8xxTsBu0sBHd9PPM/FJhcmTp1qCBKUd02kQJDf8cLFezY6tWjWhXr9E0IBJj+pW6p6Yqnh246O+d0UGYt/+FcLhWOpUJ+iLUBOMCVaOV3h3g4cmKSIPJ6A6kTY45OOvDx5U4koODeZ9bcjHHD2/BM79Y0GIQNV1Y9ROjQ4kiunnkltChWL+ay2S4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxbf2rsem9PANC2JoS2dYaDVI6O8Vrk2h5yt3UmXN9c=;
 b=ATssKLFr80Fsc94FLNWeu18wVBaB2DE3UoFA3BCGWyvbS6UDU80L1H+86UBVGaM2a+t9DQkStTFtYu7dHsTP4CDaISwMR+BFaQJmUFnA168b6ZSar8rms1LyKwoRadZCQBBSbEoTbG/mvbaSir5/V2pEX3fCp2GEMAcQm09vE9kxC/bd/9fstOpPSAdZzUsbUcytQTnsOTkpTpAx03AjQXlgczUtbWncq+1zGuvgl2k6bxG5xOnEWmC9ceaYtMT1mC7E/iEF0QjuKertOvHZO21wvHvJMmQBjajQcG1/2Fn9dLel2nsNJbcfPO4iJ+nLRynvj9TVsGdcPk8EBA9BgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AS8PR04MB7703.eurprd04.prod.outlook.com (2603:10a6:20b:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 03:51:36 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 03:51:36 +0000
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
Subject: [PATCH v6 0/3] PCI: imx6: Add external reference clock mode support
Date: Wed, 17 Sep 2025 11:51:04 +0800
Message-Id: <20250917035107.1003211-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AS8PR04MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 106baa18-43b9-46a8-cf7e-08ddf59d7f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|19092799006|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kBH0XuXkYYek18fRqcGwLK04np7LV50OMWR4oIzkO+ZYZ7IxuXkSS8dSlDeX?=
 =?us-ascii?Q?L/F9JEbmdTM7qGBd+qfLOot58zqdJC/hQrMXJEkWuvregvPHfERXWlNrnu0K?=
 =?us-ascii?Q?GjYI+oWtQ5D4HoSrMGhzXv20KMQHdq17o5NCFXxk9/xZ4XRaVT332F73KCK1?=
 =?us-ascii?Q?2d+VR+GiEUTCilT+voOPtMZ+ESD3TD5AF1ReulMMuTX0tPvLr4WQMyQFi8x3?=
 =?us-ascii?Q?vtpkul2wK4JDYArgzFicaBqYEUkmds4BD4E5SU4TaYLLMmk0CsFcmLeHlFT/?=
 =?us-ascii?Q?pOp2yCP0Jon6JpRz4iO7km7W4hN36C8ILB169WnzN1L0D8bk6CZV2883cjgW?=
 =?us-ascii?Q?UrO51keGbcn+sLnToOQIc7l0U8tzTbD/pF3amzSDmddcTKOu0I0YZORBuN44?=
 =?us-ascii?Q?TBAjV/K6TQ/Dhn3eDwNiaiYNSojhXERRmrNW3oATkyI0psJ357cUDOSnEhCR?=
 =?us-ascii?Q?R7cw0+wLSN4VXuwjUtDTi8wCjoGjJyQiMrhbie4nUlz99JtmXjuylup+6R9G?=
 =?us-ascii?Q?kvtRgoJTERhVCnGXyBH6XLm9uMMquTcKRw0oER/f4qCiBv1/xbng2+BZ36M/?=
 =?us-ascii?Q?wlG2Q451xT5ASgB8507WC0MZWOynp29qcu7m/k5oDqcjO0PHLMai5aH5Yay3?=
 =?us-ascii?Q?RGF+UC2JSAywlKnwySIcVvuzSHpbUT8X25pSukDbl4ufuIIsluop2FporhGQ?=
 =?us-ascii?Q?H4JPiUw9TCWmQYV1Ukj1fWOej9P4RUdLe0V19CrgER2+EUW9w9DD4Hpl1ZIg?=
 =?us-ascii?Q?73eliFs2+GnJpqJUaPx/GxASscaL/9UmKbzpIXADhkKUQTwNCK6A/OKD6feu?=
 =?us-ascii?Q?oB9B/4iTEu27B43fZcLlPv6hJDCiLu65ZpKFlKjNuNMUCE+KzU8fPhizijiK?=
 =?us-ascii?Q?b55W4hyqFl8/LSKNr8JlBty3V4eHE/CAWmfnAsaj/Z62kFZFhOnD+0sayroS?=
 =?us-ascii?Q?BoIZ4k7hDMo/6ESE4dXqNVH7C2kW8nGaLa7pxoB3+YKJpoHhjzJOPxsrIqMC?=
 =?us-ascii?Q?3F66d3xCyTr3K0jYiHoQapGyWuRsf4+v98SNBGNmG3P5ePNRsFz6+GKogRti?=
 =?us-ascii?Q?SBrLZUWFJatlOq1dlJ67Hp5BJqwdGL3YnrtaUcxXxtE0FOB9h9oa/rEfvvwm?=
 =?us-ascii?Q?YYHlWTp9FNfXrfXQSBh2WnyCyrSIjapet265ql+X4LSRboSg80D7CaKPUWJa?=
 =?us-ascii?Q?9t1rYxGsNvygYxF1bgXnsFqEZkUVRPTzU9I959RB6Y186LCKthT48lao6Gth?=
 =?us-ascii?Q?Jk0xSq0aBVP7vdcf2mpJLmz9FpcdPWuSpqfZWYFZZ2sXn7B1uAoeB+ecUX+r?=
 =?us-ascii?Q?KFS6qp+a6+gsHFA0Bom0uKgbYg8jih9IYPyJ2sirKfBpGBRNUMtD2ZghLuBY?=
 =?us-ascii?Q?tXj5E3QqMMtJgmHTiwXYnJAVbaTp8Uw8UFxzkLyUpYw0L5MqsCd6uoTiM3bx?=
 =?us-ascii?Q?q/O9u8n9t9Bt4fhOafdhT8YslebtG6CF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYZhi/qU2NfrlYBhiBupAMlkYDZQEMOxVNt9vq+j+EXIwwshybN/N4cwTWRD?=
 =?us-ascii?Q?QPWB7IwJPFb5fU8+6WYep/6IKmCMA94bFx1HiiFa0Uo4OCwo99yQPLoCdzOB?=
 =?us-ascii?Q?Kp5eq4WGGQCgUIYtfTrs7fwhFZrQ+wTn8JxdscvNEAMfWF5QE/ILxfpOkGiq?=
 =?us-ascii?Q?cFuCYhbUrxcmwAmFRqmZPruV3y8cl7s8E9KCuW+CrvtpXjC7nkmDQsDxLolD?=
 =?us-ascii?Q?z3dLaWM5EhuSmWLEzjz/zunv3WKRLP02dSmaj5EroJ6xNXlbZ+EqkRF073/d?=
 =?us-ascii?Q?wMwhrY5i7bSGCm0ofX6WaQLv1p5qflIuNJLlhZvrBG+oOKvoW/VENMQc4NlI?=
 =?us-ascii?Q?IVyglPPXOkBvP8Yxev3gzWiPV39PJ++pVEqGSRKyFYHKky8kZbEAkd7YKqxp?=
 =?us-ascii?Q?xYnljy/D9vJFH5jpMwgnXZNYjGBXbLpgPD/ksY0dK2pWoLTx0WB+j+50aPEi?=
 =?us-ascii?Q?sYRGcgwCzMcYFLDKvFv6jrMbLu6q2n8P3CDl7yKI/wR+lKnEd11f+XTUjL5M?=
 =?us-ascii?Q?8k6UhLXQdBkpbKkv3oS477c8LNW65L4cMO4jKYO6Wq6vPhwH45oXgVxHY4VS?=
 =?us-ascii?Q?xu8EQn5K2QWg4sCAIj5/3w0ayV2zM17h9DF12Rx/nChW38f1JjN3paGGieWm?=
 =?us-ascii?Q?9D4VXY9Y9Y1URrwq/ZOaXqi3gUMmHlJQNI/2rSCzRiTNmlWdVEKSSIpH5wW9?=
 =?us-ascii?Q?LLn8nTMnFETSCN9ubVPa6NZ7Fama4xrCVaCK5VG33Y0AGgIIW1N9idewNlYy?=
 =?us-ascii?Q?GV827aa4wofd/rn21s7ExAGljcKzD5CAqzt9oV0o3cpr3wt0+UVZI3C7YpXf?=
 =?us-ascii?Q?LV3/j6qCEEmcwOuHzu07J5+YqJaehZZ0qzXhijM6V5z7Myc9HJmc2SWI+Z3W?=
 =?us-ascii?Q?qiUUO1dj0UDs7cp12rsC+i0V2NVWGZ0xoqnG/Q/N5VQhsrNpyqSx0uvoU2kE?=
 =?us-ascii?Q?w7mXfn08j/NAMwgHhQscAjzBUE/VSNXehem1MR5Z/xPViui0MP8OCOMMk0V0?=
 =?us-ascii?Q?WsdkCrO7dbSiH4AGU4bijnC5TqHldwBo01AI7l9LGybx9nNlYoB3m8imYrBX?=
 =?us-ascii?Q?MzxwMLdeW9g7T56fQuvdMiF1gZx4NmEquEE9ezE7ZfNU8jJDrhvZaov0iEin?=
 =?us-ascii?Q?Fxae/e9r32e5vMVHQI8FtwNyjWkp/NClFDqy5OXMxLHCpdD2oof4R4Dts5zH?=
 =?us-ascii?Q?XKEjPaGx0oJHocno9775KOsVO4ZtEOYNk0vtkjuQIkXWJ8QmZ6KN6SiSrrvo?=
 =?us-ascii?Q?W1TxDwuCkZnjBDkdeakxA/MzZ4D81SfDQSNJdNxDXp2SLbYE4u/AEoIaZwSp?=
 =?us-ascii?Q?WgfIZMyDiSvi/4dGtqQfUWTQoe2n1It2Kdb6BIl8+ISicmxPKdo0R8C9VOJP?=
 =?us-ascii?Q?daFrm+5UHpjJ+RZIJB0TWz1G26t9tikJr1vRwYKvLhakLNYrq5vH1gWM2HUx?=
 =?us-ascii?Q?k29UDEg/KJBUF/TrwwI6d2x6WKhamG+81x32Bbw9fz1LKvsQiHQZvHb135ED?=
 =?us-ascii?Q?MXkXSpV9V9fA3puKliFHq1UwQfGs5rUBkYzHKxOEggZPhGlPvk97n+JFPZ6K?=
 =?us-ascii?Q?FA7eSgdrh78/VAYcJrcRFgDOBAYLTZk8tNd03bya?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106baa18-43b9-46a8-cf7e-08ddf59d7f39
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 03:51:36.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sM3y0e/ZTbT4trgZJlIugSpmY5j+9DmvZ/4hdu8thuT9uFxe5hxjoa9+ebHvbuA+V5Jney7qxelm4Fs1Nrw+CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7703

i.MX95 PCIes have two reference clock inputs: one from internal PLL,
the other from off chip crystal oscillator. Use extref clock name to be
onhalf of the reference clock comes from external crystal oscillator.

Add external reference clock mode support when extref clock is present.

Main change in v6:
- Refer to Krzysztof's comments, let i.MX95 PCIes has the "ref" clock
  since it is wired actually, and add one more optional "extref" clock
  for i.MX95 PCIes.

Main change in v5:
- Update the commit message of first patch refer to Bejorn's comments.
- Correct the typo error and update the description of property in the
  first patch.
https://lore.kernel.org/imx/20250915035348.3252353-1-hongxing.zhu@nxp.com/

Main change in v4:
- Add one more reference clock "extref" to be onhalf the reference clock
  that comes from external crystal oscillator.
https://lore.kernel.org/imx/20250626073804.3113757-1-hongxing.zhu@nxp.com/

Main change in v3:
- Update the logic check external reference clock mode is enabled or
  not in the driver codes.
https://lore.kernel.org/imx/20250620031350.674442-1-hongxing.zhu@nxp.com/

Main change in v2:
- Fix yamllint warning.
- Refine the driver codes.
https://lore.kernel.org/imx/20250619091004.338419-1-hongxing.zhu@nxp.com/

[PATCH v6 1/3] dt-bindings: PCI: dwc: Add one more reference clock
[PATCH v6 2/3] dt-bindings: pci-imx6: Add one more external reference
[PATCH v6 3/3] PCI: imx6: Add external reference clock mode support

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml      |  3 +++
Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml |  6 ++++++
drivers/pci/controller/dwc/pci-imx6.c                          | 20 +++++++++++++-------
3 files changed, 22 insertions(+), 7 deletions(-)


