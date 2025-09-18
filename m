Return-Path: <linux-pci+bounces-36398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009EDB82BFC
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 05:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE9D1B24DD8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EA91F4181;
	Thu, 18 Sep 2025 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DkXiiEau"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275892582;
	Thu, 18 Sep 2025 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166011; cv=fail; b=bbLj4fvCghWsEyuorw91uP9tqqS5Etf8Ex5JwphblzddSnkebCEnntgYx5A8N0Za0irHit9B0uKffMCeJDHiVTRp91TOhyhG+T6OF/AEdSq6FF3lxqC5k84+milQiGKJkeS81NJuaEcolv3O/U/O+GihLYdpN8PypLqXgguVHVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166011; c=relaxed/simple;
	bh=29WERk+pxRiSIXU7n5jP354nuw/i6xhRmN9mirSwZyk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OiRmpRbZzetMfhxbgGpFWZE2WKSZHGNyBe0Rqj1WfDNuakSpTt994csV5JAp/oBCJb9cyJyWFHm74T6MxIfLxNLket23v/HEWBx7J0TA5+NXrOwkGkLGMmDb/hVnl4ppEg+jSFXaoOy2pgRsiBg7OFgw2WPigTzRWDl3cmXmzqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DkXiiEau; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIn8LpOB5w2YeLL7QEI4gTYTaTUIcUq5MjQHSOBSf6JyVvxwhj5f+CxW/GqoF76ocEcnyImoyWCb4r39nhrays1XyMFoaOibw/NWw1KO5cVXZZPCjtGI9IO1RRbmV9uzeRJD+GcOdHN8ie1mj4woBey5JboS8zGmz/yFlVIYzii2wPV1L4J3e1ZBanSD1hryOE4vauZ7HQ/1FUvBDODfnI/Jcg8p1FZ2HEZnK0defH8//jajt7uScXbfrgHQyfBSJ9QwqlGkrskM3yMXexTAhiIMJ6EqMsf34l6GDeBK6eFAKI1RtLgEaeJCLSRV0hxF9Cg73VSNFncqVVAKh9BE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqQAHxUd0LumpwIP23wIlLG5JvIUkKthnXOZN/7Maxo=;
 b=SSqStwYYGFiYcuGPuKFap4PLV1oiwXqIU8dOx5yk4IoT5hF57SVKdI9l1N8i4t+/K3qyIm9FkZc2Vqk4wDBhvJFDcVpavo4Dpx6HjI4bZQ9WjgLFJ3tTCNgUyl1BVBfVZI7HoUzBFHDu4OUhgr7Nbul9i160hofsE8rswvKxMGux5GX83qF3ZCyfJ0T9iBXeohS07k8PCeYC4S6qexMtAStVk2MSHmHKxJNS9Pcb2N4smvy9xnRzFCH9umENTVougC+Ep0v3D9nv6MPxD7D8XM5MTnCDbnHmhoGTFcex09jyeOVa8nRjaUqVLsoDi7c9ilMzZsRbgVYKyFJtKQmprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqQAHxUd0LumpwIP23wIlLG5JvIUkKthnXOZN/7Maxo=;
 b=DkXiiEauSVbB0axAFl8WRd8bJiPqFQCug7KL7BIVdII+M2LqokwgKJ2ik5lTMOFx9oA8lqZeH1cCBRUPg6lobBeZGxV4n+Q2/mR0/mnBBKpZy/29YX0rGcq/Va6bLjiUpERZyh0DfDbugMulR0alHoG8YEDObOXat0NrhFsI0y2tOWGzZjgZ1wBYQHqmA0o4vTjb7kXACBbNzvQM2vZw+9v9CMriCbTPa0mGYvvXR/jDLFs8qDsWNqsDckDTT45brEBpDFApT73HcJ2OgBJ48woNsLky0d/tcYYLUtR5NuJSYdST1MVFcUGpMUTwMDrhBkfwO0T84jvr6nBRw6mmjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 03:26:46 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 03:26:46 +0000
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
Subject: [PATCH v7 0/3] PCI: imx6: Add external reference clock mode support
Date: Thu, 18 Sep 2025 11:25:52 +0800
Message-Id: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM8PR04MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: ec653c7b-10c6-44d5-ca23-08ddf6633208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LpV1//VMYWUKCejFVkKr6ewt8Et2/fZPCp/0yeFwuM3IAWqfPEAzFtQrHAOj?=
 =?us-ascii?Q?/QVYJ/jrg2O9BZq81SzeZYaptPFAFa4fcjwPnrDWJYidr4t52sOBnHseePLK?=
 =?us-ascii?Q?1YgrOMemSyfjNgD4CRGZi8PHC1SFoWfF6fjjFmjT6FfvsPXzO4zn3WQ7JDYD?=
 =?us-ascii?Q?rkQ9CDHcfTMvOww8MtE3q/T/LhrNkq9XuTRY6u7ioncFMekeujpmj2rNMS0m?=
 =?us-ascii?Q?YKiDofWfZbXjdFcaE1agcWtoBDgjanC/j122501nc6F9Ytep01wJYTAZ+1jc?=
 =?us-ascii?Q?+MQ8CL2I8YQ1LjntGJhtVrl2oFFLp/mF74hi4N9KKbn84PwaeLLXpjSbhtTH?=
 =?us-ascii?Q?uf95IG8w/YefA2M6YVCqewUkrztTXC2VrEYO5OK0IfIQUNCHWL1ZILPOddzl?=
 =?us-ascii?Q?Fs2I9zKkjkya+y1E+uFSxtaA1sXbCvuGe2unnkI+fx14wKuT+iW7xzRK5xoC?=
 =?us-ascii?Q?NLghFVLB9bfLfAC4hE+7l+rPsrqkvEpWwJE4s3JLz87jDMYQm0KRLgGwmWdw?=
 =?us-ascii?Q?ZVa9KMDnzXxZ0kh91pCSPIR3aEhzrGtOAc4+DrCHBNbjGbzl0jJoL1NW2K9Q?=
 =?us-ascii?Q?AApSHT7PEQWatUsVfNx7pU0B2i+nVYskwjpQLw9XuNo0A2v25QVW0wpE7J4v?=
 =?us-ascii?Q?uDbx+4aekAkSvKbwVdJhsyyB1X3XAJEEyfADfwLzc3Bp9SEdWkdpAR4Xofua?=
 =?us-ascii?Q?9tH1FNI+ycL03YYe52IN1ENZBZKML6TSsGQpk170sqjeTNJZIuYI+zlEtonr?=
 =?us-ascii?Q?QQpocFId+/12F9J8am9XtlLoaopKh9uVugjIDFsXBQiosvGVvzjtMo4GCbTq?=
 =?us-ascii?Q?qovZ3HIq0pcnJmJi1MprRuYe07Fytc96AHF5Xnjr0AXmC5035Jp4B9msOxKu?=
 =?us-ascii?Q?H1r8gD09tzvE/aSwbfUaSPrpaB+w9pmtduiwVghYAQJX269qg6XnDmqbRu7e?=
 =?us-ascii?Q?uph+7qZNkBdcLHHABfpQHLipvIqw9BzNSJEk5D4R4/0tFuzWhTNNTJdyAlah?=
 =?us-ascii?Q?ArPiYAhEGo2lWi8EvEgafY8cbyqJKM/JtHB/QQYOlBzxEuP5L9MOsHjQ7Bqw?=
 =?us-ascii?Q?RTgSb2c0cqwJ9NyaDMZRvcehqxaABBG9UAb86DIbpvSZPvayTINbcIFW5AuX?=
 =?us-ascii?Q?+3/uTcHvCNVap8bNvnlGuUioVK11y25BqpErL/sSM+ot8+z1HLhDf+j0+sWb?=
 =?us-ascii?Q?BxPEMN2spNxu7MiLFHZ/CfvUIvTY+G+xodsgHLn86K1dxwu9ganKvx0NwRrn?=
 =?us-ascii?Q?XRAzznd3DfCEQP8zsWLd8zESs6n2CDC0cdk+hDaGEnfAk+c651Q8AyzrrkgX?=
 =?us-ascii?Q?R6fNOwg9j0ya90RU8iyCBQZwI4NdV4J3PbAnKO6A0f4qfQixFYl7dFruuwGW?=
 =?us-ascii?Q?6+vRerBpRS9GbbmAJsDrc9KY9S7UoadvUkFLfJpiYDVCz5ZuKP8t1rhe3Tlq?=
 =?us-ascii?Q?eufydW1JrOQ6FFrETUDkfx5OM2E9qDTa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6sfrFvWKBhOs9MNTMcVkGWfdSWEfXAm4TTgUQgKFlEKaCa752WtHyJwzWEdc?=
 =?us-ascii?Q?1ad+xJ8L0zjQdysoqWvBkOdxL6uxhHzQxSHLwg2Y+zI3sqKSY/n0d/PKITnp?=
 =?us-ascii?Q?Ypg+P11BwG1pObRVfloTtbdsvP8QkJjNs3gdMyVZpztWKib08zxfpNOl0Vut?=
 =?us-ascii?Q?ebxkHTs+TWD3T4fIUC53TWgjiTwKK++ii3IdywCUeFKQH/jTaZOe2mYCjoJy?=
 =?us-ascii?Q?E5sQsY0pVpbIqML3I7Q08dAZr4FqBZDXPmFGZxOr5ix7+u2cJMy4IJNGiv3/?=
 =?us-ascii?Q?enR2ttlP4eaNyMv+R6dQXiaQkE/g5EcCcDPTg27EGEfkdWmlmAdNWD6QmWWq?=
 =?us-ascii?Q?f9ubxS3mXvVGIRYvcFa+vtiapXXJ/lAXIfu9ghbm8TXoduKQGog1WIu6eRmg?=
 =?us-ascii?Q?IvFB2YfdqucL0t2lSm/kWm+/0kCc372rWfz7ea40mcd+Ji8/+uIDViawaxyn?=
 =?us-ascii?Q?JRvBl/9DF1DhuY/4I8z6pUNz6qcNsLQ2U18G6Ll2bY1wADjZV2epUjMeEhzL?=
 =?us-ascii?Q?Y4dXa30vUoivOnXjdXlddmBGHR6zRLEbTH/39xyT2EL75J1FEdl90IkuZgL+?=
 =?us-ascii?Q?FmmbCd3CrRz9j1YPHXA6M68unq04M19wNxRaAzEt8djrmU6HsvgwDn5GJyY1?=
 =?us-ascii?Q?HGJu+KFFVgPWRXnd5ATaNJ87yprogx5R+FW4drrvmkni9+XybmVS2Z6+yFod?=
 =?us-ascii?Q?viMvKmzqeI1YKiO/UQIY6UtNWDecclqa0dsjqLD2v5Ox0DN6bm6BGTem3FBC?=
 =?us-ascii?Q?Vht/7wJ3eQgvlOUkbZbA9l9ra7HCf/3oBGaUi8Hqb9SoLJACMlQupvK7gDSI?=
 =?us-ascii?Q?+BonVxuGnBnpjSRs4GWmelxfkupmGd+S/QHPDemP+GJlrbPaAbbIIoXDFq8X?=
 =?us-ascii?Q?8xgSkBP2rUVhcUxlWXFY0cuI+4tlrQ2a8comEP+24fnzlnaILGJeFEz5QfQv?=
 =?us-ascii?Q?FxcfusV8KWmB6L+H2wxXHXgaZK4u5hvonRiBIfT+m73BiDUg3dbiqvAN4PIe?=
 =?us-ascii?Q?pI05UW/TYlQ43GsxBWJ41Efd7He6GsS9fP0c/eH7QR7wOc7PtuM+pXT9E/xj?=
 =?us-ascii?Q?nK5zbQQoaASnSpEQOrjIBcqPCMSA6LszfON1yKfvY/e9WSf19DVXjUZq70Yo?=
 =?us-ascii?Q?n7bShlzuTX+pye31DHoc4GECXDlEv8k3J+lNi3OEKD8NUnjkQmhbA81WgdmF?=
 =?us-ascii?Q?6yquvMzhjPoihvyEIrDwJPUCc+wmcjy8imcdO1v7rWYfsYsXg4X8F8d5zgEt?=
 =?us-ascii?Q?k3R57Y5v+xRZwVwC5IQ2u5BcDHbrLzn34lWdLi282KAM4ZdiFnOqdwnbeTyK?=
 =?us-ascii?Q?YaUysIddZMV9EIxbVKefFsc8rl82a8wqSA9025V5LCpNgwqk1vgdUcB2V5nw?=
 =?us-ascii?Q?tjvw9RBAlpE6aLlsfMyh7PaamAsBiwO1NpQaqVLC/k17UhCxj8M76d+yf94B?=
 =?us-ascii?Q?iF2mAMlHAp9EpWF+QlHQszxgDVMKOUkgyVdwBwIffxMtN46l/nmsZaCAt6RF?=
 =?us-ascii?Q?JnrGTiYDvVAgTJhC5XG1GAc9+ZdEgEEpaaH+uTlr02C4I9MLdpAmxJYSajgL?=
 =?us-ascii?Q?gpBkSRvWSkQ2owyfisfePLbLTvcoTPHMA0HA4A4B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec653c7b-10c6-44d5-ca23-08ddf6633208
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 03:26:46.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/RmNrfVXaQ1xPiDb8lIyUot/lEgz21HX+WqKo+VnSRzSyyRcvHlTrv8j0ljGcH6N2JEqZRsOxNxx7yXXpXjEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7779

i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
other from off chip crystal oscillator. The "extref" clock refers to a
reference clock from an external crystal oscillator.

Add external reference clock input mode support for i.MX95 PCIes.

Main change in v7:
- Refine the subjects and commit message refer to Bjorn's comments.

Main change in v6:
- Refer to Krzysztof's comments, let i.MX95 PCIes has the "ref" clock
  since it is wired actually, and add one more optional "extref" clock
  for i.MX95 PCIes.
https://lore.kernel.org/imx/20250917045238.1048484-1-hongxing.zhu@nxp.com/

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

[PATCH v7 1/3] dt-bindings: PCI: dwc: Add external reference clock
[PATCH v7 2/3] dt-bindings: PCI: pci-imx6: Add external reference
[PATCH v7 3/3] PCI: imx6: Add external reference clock input mode

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml      |  3 +++
Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml |  6 ++++++
drivers/pci/controller/dwc/pci-imx6.c                          | 20 +++++++++++++-------
3 files changed, 22 insertions(+), 7 deletions(-)


