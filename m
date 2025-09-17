Return-Path: <linux-pci+bounces-36314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FFAB7C63E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0CD1B27EAF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 04:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0123E260588;
	Wed, 17 Sep 2025 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="miOEIGlG"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8170C19E992;
	Wed, 17 Sep 2025 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084811; cv=fail; b=sIWWNG1GBaOKUQIeqlsA7pggHGcZ4UD906bXQVMDCrnJ9bajMC2yAtXALbmqj1N14S54IvSspcaG/Qlb0rEFnwgRqVsbXp7x/mgvNnuKlYtOaAuBwSPVGFrWbZSnok8+DhoTWzjiRyvgBgJqklaKYE7HDwndfRywUr9xwacrP3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084811; c=relaxed/simple;
	bh=1ELCEYemJ9jELZo7gGyZd2TB4XbH0UL/72NaodnmqLA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QvaqQg6Pn2j58QddUMOPYGrjzJuXy7ZSU3wl4dSlt2NauCUszekEiDWPx1VPJ2oQ4wJIy9hG9C98Jvy1flMAINEiKFxow22/leLpPlnY86w4IiyegbuESVUDuAOfEjFbSrHgyUn/MuCEAEb/vbILj0N2ukRGmKYmMQcMpTPbquQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=miOEIGlG; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGDAV/ZNJxhIPDTEGYAvaXVtHHnBYmoMcvrhzO6RPIIU5cvZgv/ce3SQq1OkmpWI4SNiThcesUbwfX4xhaGzSVPVXhISa3ONc+k0lV/rDgwevIV7oYW6GI2RWJA+6P06DgXUWY8trBgmCzJkr/toXeHwR4Ltlu+8K3ZGm38S3Fz3JgcWU1cPfVnLIqU3b9A7++LNBJmHssw7SW5Cpd01DF6v2YmoT0Y/h3relT9EpqfKAyUKNafTgnI7Gb3gNXoYoRVgAy6SaZi4VBw2osVx/uoxRG6BSUQKCp9a6eB76XDT5VTHmVP9qV2SNwwD45/okVJYhS+SmW3FbpNewkQbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxbf2rsem9PANC2JoS2dYaDVI6O8Vrk2h5yt3UmXN9c=;
 b=lE3TlurN3IkCIkzR95AY2KglFivKw0Wh+KTKVet3+r+ZTJCU1RNJ5zzVUAqjeSYoP90OeqEQ6xwAbQcIzqbLGjJYZ7CbkHfVjLb4atiWL+WcnrguBNAYR/wOtv7NqA6rS496mjVot0k8Qq4Ck8Rndv7raGcimXYaHkI3qUIau3Tc9OB7fi6uRhx6zKzMOe5N7b+/wShNBdvsWF1ZNziYoRP0EybPKk2rY3bQn5REna6jy6YU3Rnk8P4Vq91cMWCcrmUtDk/4cqnN2D4kghOegy6Z0oYTLnBwAVxYUSwgpD9VjCI6qP8Ng5ghqNOKrxlHFlXUQjOlln170yggkGeAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxbf2rsem9PANC2JoS2dYaDVI6O8Vrk2h5yt3UmXN9c=;
 b=miOEIGlGuygl/me4qGM0CY+Mrb08lCqcPoQqg5i53VF6Y6CrVQPi1iIhJVsp+8IcOsS2ND5TDsz4IVwG+nu1d/PSgVc6nZvfm5GXoTxu/zY7YTJ1rG+gEFdIGLlf8dthpPaQMEyqmVwvpJiYsfvooY5SxdEavHhOfNJ40i63NoLNEwITxE2hpPZimvHfikGrQ+57fI7JJO4FwZh7+KCtvJiJQQXvHByHQsruqIec+mS7axkvA5SAm/HizxUIkb+5QPCrdcGGShHna13Ypo+pEKIIoxsZYT3errBYIhrqGfAHypEyqec1sYkXKt6gKtH7KgCuF/JyfXfdJrOxMzpbYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 04:53:26 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 04:53:25 +0000
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
Date: Wed, 17 Sep 2025 12:52:35 +0800
Message-Id: <20250917045238.1048484-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ddf54c-e4c8-44c3-bd54-08ddf5a622cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zqRWpAgjR6kNBxvmM7a2r7ug/Mofdxzvy0HgxyLd6dtWYcZwr9FK8aHv9TJ0?=
 =?us-ascii?Q?6e5KbLGpaCVQiz/RpHphNAUbNKcTdWA4NIvnlwV1GWYzbAVn3YAfobUmYm6q?=
 =?us-ascii?Q?2ndAme/5aA+CWdtx98r2MHZ/mkzMaaPjVFSS25fnCpqz61Ip0uYcvYj2sz5L?=
 =?us-ascii?Q?daSnF0Y31wCyCWPQLAgWBfWWZX8G4WwYk2Z5YfAH+wRb8/VGrS/OG0ggeQUy?=
 =?us-ascii?Q?kPL/U47Trn7+7G8OgOGMVejhmkloQRB6OIPZuoexHFO8mbBNRuxh8Vb50C3/?=
 =?us-ascii?Q?XGqRLAi6du8b8vRYxNNFca7c3YfPqEOaB9eVFpSZACJskTikaOUexLDRuOF2?=
 =?us-ascii?Q?4Hu4AH2BTk1t/3m2tGtjpqrmq4ZaMJ1PxGqW6S4xm80ergen+Iv9QDeeB8mt?=
 =?us-ascii?Q?L26aNHDLsPccVzS9Ido3IrJaasMTsWEWnpJo/HL4ar9FjSImgfxolAdLMxrV?=
 =?us-ascii?Q?TJQC+cnyfRq2D/jLY+N7TZulHP9Qk1eD+ioYjDx2Upc3Yc/eVlW2URzO9lcr?=
 =?us-ascii?Q?EIBt7QIKmyjtVEqchHiBmO0sOFjoRLI+nyRJQG8k/1PcG1rZCFPSVcMylYCe?=
 =?us-ascii?Q?3qQNEBJ4JIxZnRMLsmiB9qCkj9L/CTklnwoktE7pJVM3Pm1q0VJTzDVZ4zsh?=
 =?us-ascii?Q?od/iJbyGUaDk6j5ERgMCCTBVxoI3sR21C//0qe14Vo28PLEEOWJGb35mW8P6?=
 =?us-ascii?Q?9SwEwTYD1PawTMJAoj0/eKBEjv287gysyegL7myzb7d2YWfwv1KrHmiXZydN?=
 =?us-ascii?Q?UNCXOeBgePOIq2dyd1lDVC3mZOQNS5eVf39QObu7UwPpSF2KW8jZQLvo2jSG?=
 =?us-ascii?Q?A61UMAkbt3mc6g1bjx5ZAXcs6KH3ajeAPsrTPyjYIQ8riGou/IlO13otZ8BL?=
 =?us-ascii?Q?WCNuNgsuLvzetCeRzfgafNwslv5Ubv+qwMLENaR9oIRtVhOvzv6ELIceCckP?=
 =?us-ascii?Q?xxuMLmAyuArr1NkdpYQw7ZK/1TrxF/8ZFr1o/L+dBSLzqXYwKqcYFdV56Ol0?=
 =?us-ascii?Q?vRBZzh9fEByYJKog4ONErJix7JFSxvy9ZqNTGckfBe6ApyLhgOHEDQ+b/SWx?=
 =?us-ascii?Q?d5sM38IWnLud/UKbTqAEhRbRSFvWUcSDMSzTwzhhULqPI6HaZG/7RRirNOAm?=
 =?us-ascii?Q?N587fdZjh06P/sgLgovH46qenensvGcByYn8JvDFUL3mQ/+3TMwYYBcmbJIq?=
 =?us-ascii?Q?OaGL7mWhTtb2zEgrK8gWZoKTVuKudxRfAzUAUIzBVjG0RU7k+Vbzx0S0EY21?=
 =?us-ascii?Q?+anjOz+ontA133q6K80ZTln/iJ8jC8QdlRUIcZk9UmvbkWiNjwGbTubrbt9S?=
 =?us-ascii?Q?3zQH8qpZtOfCqxJ4hmPJPpzGYvUyLjJ+yVn8AIz8bGnCaE9H4567PJ3w44Zq?=
 =?us-ascii?Q?GYl/P9Dj1La8oRxVLAaa4H1yCy1z0/MgysVgIiGCXW4UvPs2g2I3YsBoM0vb?=
 =?us-ascii?Q?5tCSmTD+4XfpNrhVKxcfM9brSQ7lYQCD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dmA0KnGRHZLXy9n9M9y1OWKhdy4yYghGKp4yFL0cpHVluhn6ZEVntas3LizG?=
 =?us-ascii?Q?hAAG4htiGz5wFW/Y8VjxDfq/TBF3b3jNnuApi5RMMB2lC+4hDxKAxUiPG1zQ?=
 =?us-ascii?Q?c1cvnpFClPIByUBgnHEPeioMRViwMiZijqy4FvEQ7DYx1G7xBikBq9C1YcD+?=
 =?us-ascii?Q?joKeJzlPNyRrd+s50U8zDE7zgrX4UQ74/IUayG4YDhAudEFvkZtVsQqhgrLy?=
 =?us-ascii?Q?S/bZVbP42sZrvFA3tnGvVeY5f0sgzrhXJnZGTmuILZBEireROOK0yh+lrJ1X?=
 =?us-ascii?Q?iLa97KiJNHB0kIzw/WUHjQFzMxIxxsVlv8uVDGS4jgk14UijN/kQoxxa2jLu?=
 =?us-ascii?Q?YfPSRPmO13VBYed8rrckY0vA1A4dBNyRGuULvOhtNZG8oFTZct/aZIIOwhbu?=
 =?us-ascii?Q?7y/wP71faw+1WmdDg9Umn1vq/Uj7dyxxpv2OQJsWd7fX/20KfIMeAZ/tSsuT?=
 =?us-ascii?Q?QEfLmnDnfEhUOEGZDau5Tnbrh4/m+/4TLVSj7cn+4Jpdyb9XBsefNhHMfXY/?=
 =?us-ascii?Q?DGT1spTViRCTkBJ7K7gaB9jUymIIfa26Q6MUr5CdB0E5rDADZk3u0ZxtPTbi?=
 =?us-ascii?Q?3SqbWraUwVIbRnN4QHe6OAP/oLcTTQM3UvMWCg90T2vnTel7xROV9b5wbyGc?=
 =?us-ascii?Q?AyE4QPnhyVEG9PaadH3qB9n6CQp1TaV3HaGgmQxryzvGmDV0l4kqxRFHka/t?=
 =?us-ascii?Q?YUmiAvUTRryyb1seM9UCRCm7mL2CZcaA1GZGqIjSC3Tq/if/poDsxFiHxpr8?=
 =?us-ascii?Q?VvDbpEPrGXnaVlQWYw4ZLqsPucqCiiOrj+iC8gVV5Jic1AZgXs3G+n0qzK4P?=
 =?us-ascii?Q?Tbg6pMINcvmAdfu0uMtoGn2SLUEF/17We0S5XTTVF3e6z7W3g97hdrVK6AbZ?=
 =?us-ascii?Q?JQd4zFmCz5JeJKy+UxRxXe9x9yH8yN8Dtxjhi6VzW4HVpMV1QCmcgNuSN8t2?=
 =?us-ascii?Q?Q4+zHd2QF/LHPHeeFDR+uUu5+8hhEq1V+1N4FNIkFqxwIOeEy3tqSUzFSw+F?=
 =?us-ascii?Q?Gkp3c3q137sHaOQLHx76oBIkGOjyrPL4unvRA3Tz5l9/VWOrjnEpsoimScsM?=
 =?us-ascii?Q?pIGajZKR7sb5gBqhzOvyhYH6GT8RIchcmfpYdVmoBQO+GpdRtXR8n1KPmUdc?=
 =?us-ascii?Q?j2GZQx30tQ5ZkJDpKDpw2R9JMRFqL/czYFms2uwICxdvmR/qknYfPsUvQtQm?=
 =?us-ascii?Q?xB8AihTWnOUH44Aj2hYgFWMytrxip46/YCjeUszTnIsT7rc7aeA6hKdxR1Pa?=
 =?us-ascii?Q?YXxJ+DPd8bAkZ0Q843ktllspvbZgzqUcTxu50nKhd5qd+V6G2q84Wc80ywUk?=
 =?us-ascii?Q?mZEYpYutgypv1sTvtFPwcE0OjttAzpXjGL3nJ5GoQLsvBnZx8ZR4+VhrtJSr?=
 =?us-ascii?Q?cZ1qA+FXs032+LNhWt+3picJABIzASPpDXLTwvQybajA5l3lJtjwhC66jN34?=
 =?us-ascii?Q?sN1fe1O+Ac5YJ15fa3IoH8+mkFUjMOzuSFMCJTpfYZ1m3vwAkLhmoitDeJ5C?=
 =?us-ascii?Q?4t+IV06zOyyjwgBDgFdHVjdag4mSw5qGBXQDCGB5a7qinTGXOHQmylp8cjIv?=
 =?us-ascii?Q?866NHv/82OXpNdRlDEOZj+MWmbrNJAESiZHxmk9L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ddf54c-e4c8-44c3-bd54-08ddf5a622cd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 04:53:25.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbw1T1ZjxLjw1K1jyU+9a0wPfgHGGHlniaRdMrrMm964N/Aoz/RXqleKPLogXuEyggJqu+gnsz059cfPS9an6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098

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


