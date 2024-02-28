Return-Path: <linux-pci+bounces-4205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C93D186B7DE
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 20:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F583289B5B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27E615F330;
	Wed, 28 Feb 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IeZNflVV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8315F30B;
	Wed, 28 Feb 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147038; cv=fail; b=bgkCqF7yExAY6KKvh3h4GnfgdtK1TxeH9ijhLDGWPtnOiP8EyNvjvRp00eMMTKrz9Zf6WGI52f0hOkui3m/7je+e+TA1+ClybUD3yru1/uEUOpSqHTAMLeo32u1EKC5Mu5nRz1B29PdvH4B6WBPE/GhOUO5u8vVrlq92tUAAce0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147038; c=relaxed/simple;
	bh=3pwKWMOfDGZlUiqtoecsQrIEagYgVEMbV1pnhZ3PjLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XVkny/xsZH7faOPSwEKzFoe/0b8w3Y3FuN6FD/jiy2pmVkz7VAIGlyXAB/Ae0rQ0f8Cj6fMN3Kjq3OTVf8ZDeKIt2eE7y/onVglE7MaQzFy2V6D+NXsEnzRatVGU8n6RizQYItOhqIfkXQvVj383Xyqtuzzpjggbm+tthu4BnMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IeZNflVV; arc=fail smtp.client-ip=40.107.247.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHIpQ/VyO2T5dLwxPDz5+70LWMfX+UiOEdMTySlaRKT6HX1q9oG445OxwhqByNHcbo89TdAsBotsNQa/J8tsjkwj6QfeAzne0AX7fe9ZWja2EOO17vROzYOrqFHU0PP9A/twr4b0If5QZyVi7jHy3hSlabkAbqMllHITjCQ5/5C3URAQDRy4DevS9KEBA6ZbWYmZyXpGOwqF9ojydMZDtGH1f1TAn7xyHGwoYsasOqW3fmlUPTweHJsKxtUCGfewhpFghUmZxmPaqJbgeOw/DPLFH8wTRcaq3iX4t4vLfVdaEPfqQwUJIIX+qSNq7xQ3Eazbh6M0F84A7JmHoXIoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkRlpYqtJJVELc6OrHSBMJkiS6uRXhRsZfGaWicajEE=;
 b=LDLOc91t0LUJxol6PvMOnAfxNVJemgXKk1U60r7mUnS49+RyB+hQRlfEB4INooOD3z5UgSmUgHvhg2oZfhQ+sQiSL8sEWuhyEa983joKOtlUcu/TFrfiRwktdCpyvxGh3bjnyA4muC740PaadyFecUgI1aKYTgTRA/+2bnvMjlk7hno1qoi/Y7ShO6kMJQh0KmsVSlVmE8C/KNDc/qBJHVW0e4zWI3q/KE58Ul/R2U9f+nMAV1IEyrjoduQ1G9+gpaY8UEhDH9BfZ4wojJdmKzP6uhZ1B535O4dRGSQKl+Mzg+1i2T7d8aZ7f7mwp5D6FQDLbBbZCRKCca68zmPkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkRlpYqtJJVELc6OrHSBMJkiS6uRXhRsZfGaWicajEE=;
 b=IeZNflVVUhNOtZWLyN8Swn78x5NMVmj68iF0TGKc0Bqh+03NJ0rV5Nn6fQNA5mw7vEAT1s7Y/18gIugl1/JNFlr2ah5b9Elg0b+zJZ3OA82RSlViMcd7WM4YqBKFLlFAfPbsImtmTkVVdGvOuMyWe8Tt7bfQzrubXusabXQdtrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 19:03:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:03:55 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v5 5/5] dt-bindings: pci: layerscape-pci-ep: Remove 'fsl,pcie-scfg' and 'dma-coherence' from required
Date: Wed, 28 Feb 2024 14:03:21 -0500
Message-Id: <20240228190321.580846-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228190321.580846-1-Frank.Li@nxp.com>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 735f7fd1-1291-4699-f64e-08dc389002f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tu/mmcHdo9U5ZAW7qxZF7dgK3ErbTks0Y7q189CmzGcPjmbVkGvnZfpCHotq+cgbJZ1LPQq0A53mOgwqkXqsJWfYBafaAQfURu7jhocRfj5tS9Zc0bH+Ai3T7GplxGY+Is30+2X4o3MFMF4/gY/LigczvdA6ttkPshvvB4YQPxIuO9w64C/CEtMuCnw+ngUrNbVWGxNOqN62qJ+mpBzOks1ZsYAhG4M8stS7g0NaOyGOpJPvbHP5t1ACccKehAHNkzEaKg4QOIoVo1sR5ZTKJDPk0wSGw/pGg3zKt8a5WBDXoh2u2OhCnDiunLjPbaokmCgYOemyVPfZqEoeZ2Pfccvx0mfMkaXtRU7dFuLHyOSuyDEaIa/K79Ctt8oiW2uT+DzOUnnDA9Arn58HWpwGjjQ8ol3LPMafE0zV2Be3HYb+c/o9Bp7FBbnyfT5Lg8S7VWcp6InRrLIR2huxHvsH5prBc3xbrrVrc0i0nO598aMQvqdz7g5MAUyl2eGwpFS3qR3IhpxNJGK0awk3ER5bDFVQTLSqH1BhNTsghs2criHfIoJGnLjOYYFYRdZCZVqY40k//wr6XxSIST4Uo32FMwHJpkcIQyiAZiIJNsnIRb9owCc9fq/+mVK2dYxy2DyjO23Vs/A3/ETvhu+iUOt/xD7H5ehwHpMqZsIdQylNzoJXBn3erxPkLI56AkI/lbalTt27fqFB3gb88a5Cul2WKXcPUik0l1X6kM8wD0+erUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CLqhO2zT72Wmg+7snXc0sKpdyGVT54aypF6bWkskYkhI0+sCIrKZh7m+ATFx?=
 =?us-ascii?Q?DnEM/xyEXKgS6L55Lnabh5Fs1B82Pckh2JsStvNen4+2GPAvISyPlIo9Fej6?=
 =?us-ascii?Q?12smfvOFlBQ8DGhCzEfrB4ATJzoXZgus9Icy93HeUFWb/cd4/ScgMpoQ37NP?=
 =?us-ascii?Q?F+sJapRDb8NCi+MqitkVcOfV2TjGmuxjEQPGDcejWubzs9g/955DU5rNq/h1?=
 =?us-ascii?Q?IG+E0MWVd0EqTKwCPguwyLdZjFc2pQDDtujEBf3oViv6phE1iFd2+xC7/xGT?=
 =?us-ascii?Q?db4IrpoP2R6WLxEXzZEwzUoYGSenyT4mIq2KykuISv8SHmLOLAudlP260MBN?=
 =?us-ascii?Q?qhQJorVHlFaehBc1uRGBwfrEGo8CQXLpcOIbu8GaXFAtv0IbNmGdFKtaZisW?=
 =?us-ascii?Q?9O4lCdDeN4/14uRHHZjJ04yUIzXkZ96ILoSjhaVuhTWv3fwOo253nCBmMMRr?=
 =?us-ascii?Q?6NZDo3CB18gqdi+cmgXGHGl3nun+kkFv01nzKSb+mWxLslyWJovBvfs5vwuo?=
 =?us-ascii?Q?qAw5yv454euBW1rTvHaAimOf2ZhRaYi2xNAbvCCFCigQFigFS7WqTxD5HBXM?=
 =?us-ascii?Q?EtChPBKDS03tLsgY+jiVw3zw5i38c2x5wVPVYM22wK3TWmnOXXTb75Y7UI8E?=
 =?us-ascii?Q?JYbEm+YsorEePX9QY4OsTW/KsyRrDoCDY5PefnpUTrJFHdYFXTdiJhPlX9vF?=
 =?us-ascii?Q?n1Tb9ivvbXUibeFQ6lHL9knB4JU0PiU7d2BWbJLn1v9mQUPxXAegLzRNNC3V?=
 =?us-ascii?Q?Gdidzluxl3GshPHHypZR0qOIdZUvYQ+j5AM7B2vijZNbOO46E6lS9c80+BZd?=
 =?us-ascii?Q?6Ow0L2JNQHzdNkZtbP+E9I2XH9w72m80wvO6dRUgfF4tnr3xSgfoPOAUoLCU?=
 =?us-ascii?Q?gepKI55qtc3v5n+BASJoZDhKBJ6vHGy7HTkFzRP5pv2iAKesDdCdhvgBC5+n?=
 =?us-ascii?Q?ld5V/TCa4I8gDGdK3SrfdoklkX7m/lVZ6UWLO25Shkfd5BDBo7D6sylMP0nd?=
 =?us-ascii?Q?LuIkDk03lc3AHLMMhelZo+Daeh6nKKIA9kpSlWP9xzz2EWU2YHuDZrqJQPkd?=
 =?us-ascii?Q?A7LQ6yveve5g6+HhhRK7NnPPq0spITEW6bwcVOxqxTnRXP5W1vga5usKHECj?=
 =?us-ascii?Q?rOwOb7+fxtllA++40ToYkJnbA2SsGyQy3irNN3QFRj0PbvanQ1jmmKp9bOou?=
 =?us-ascii?Q?0dUkH+x3EO/NkGUR4m/rv+58oZWbbiAhEafVHHgippG2Rvq8IB+I9lPEw/FZ?=
 =?us-ascii?Q?BtHG12ze2NR+4ym3ItIuT1O+NbF0WvPiNsLje6n18Q+f72jduopxd7fEDwLA?=
 =?us-ascii?Q?vnu1VYqF2Wv+8TmEFwuOFDTsM60DvUhxXezGrXeQc1nb+6SRM+ZZeBc1ovcc?=
 =?us-ascii?Q?K5Z//xsXe3wTF6Yd4dvfyNrGvR3yxzDq5tqyccp6dWOpNyO/72IaCHMSiFLB?=
 =?us-ascii?Q?jc7MpEggDIfbfIqELyjSNxurs0chEpPjKcCz+QzRXNgljWBYTLjl38pAh6Gx?=
 =?us-ascii?Q?ZzlVVICdBLP6iqVfqjjMIcaWliO1Bk4h9t0YnxAaCVP9GGp1E2+7GNjaABEy?=
 =?us-ascii?Q?bwrLkYzO/o8oFiJNsniO/HTYBKTt1NeEnfok/ozM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735f7fd1-1291-4699-f64e-08dc389002f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:03:55.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqa6AvHP9OpTElyATasx2j8YiQPQGbFn8qlJRM8QVFUbPk7UExCdToMeBR27fwBq3Zc6MhuX5aYOkjULxao6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370

Remove 'fsl,pcie-scfg' and 'dma-coherence' properties from required because
not all chips is dma coherenced and have supplement configuration unit
(scfg).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml         | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
index e75b8853dca8c..07965683beece 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -67,8 +67,6 @@ required:
   - compatible
   - reg
   - interrupt-names
-  - fsl,pcie-scfg
-  - dma-coherence
 
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
-- 
2.34.1


