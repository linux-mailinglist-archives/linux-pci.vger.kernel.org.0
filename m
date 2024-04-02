Return-Path: <linux-pci+bounces-5550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A689571A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8090B2248F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5B81350FD;
	Tue,  2 Apr 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QDPqeZ2U"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2125.outbound.protection.outlook.com [40.107.6.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AE1350D8;
	Tue,  2 Apr 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068482; cv=fail; b=Ytq/LxFQdMoiRoZ5/ArLN7bTEUue6CYfVpN+Q0X+APgSFG3jiudoBg/SLorKKCaGG4aXwOdB+K/rn7Tcs87842/SshyMpLrfZd7lzTBfZKFlXBPcAg4enTZHcEvNtijiFGjdfT8OE/p/1pLmtqXW6EGZx0hW53TIKaF/LwUdblg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068482; c=relaxed/simple;
	bh=fahIF35kCzzN2NR1WBFY+sDojPrl8TAvK/Kx6xk+iXE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YXPo7ze3h+LWakpnbXvx9bPoghJmtB6j7jyvVY9a8xmLuCL5MKddyk+x6i8P+DeYKPYB7lzS2x9RjvyOPiapwbIcP6YQL8l4kHMSRrsyn/nGShFlD+xS1lPG64wwn6L5IdYGdTlUYt1qUSNOBVy49Alo87zvu/xGisvKrmwlvhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QDPqeZ2U; arc=fail smtp.client-ip=40.107.6.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuZ+oYG6U3XFBqstUsmrIEZSfYdJ5aMCYfH+3eDX9TQW1TDt1gqmfE3l1lWSJJsir3wVIcPeyotFQwNYGSPSLhHgusSCxJwbJ4okUgGsTTmKn64RkglHoeiAf4ZqR76LCowdcs78o2ez7kDXbamAem+pwqo3W6NXt34gSss+kiBIYGWxRhDFYbr7cOisIc2GtkADWIYzPV90/BtVv2Bv1BqDOC7GoNAZ0QQpS6PD1yUeIqtNwY3HMM6QimlvZLTZ6MSdb38lx/6R5qPnN/tvMGxFKALXhn85qazFA1rQ3MCcW2q/rJsR2jZCwuKMuqL4yPc9B0EIPaP+yV3+rciSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP8kCdgh9JdBZ9PsUYjaNu5y7zPL3VGTR6UEGj6lmUk=;
 b=iL2PFNAowo46V787OzIMxMHvSAlDHYCQynf7FDDkjTyYCOscaisPr2PJhNqWmmU8VG6I7CEmAO1z1sNLN8qYzZ4oak8W9FTSyjYTCAsGoaQ2ScjpKPW5BJVqnwDnR+M9KNX0ilUU8tqYPbXpmIhjgrKjInxEwEvXZNjaUFyvyd+/0j+OAK+JJ8UBkSkLIVwgULCnKNRjvPEH8ZLqaRuC1fIB6yhx2qiuAYt+h2xFnJN/w+747YZ5tiU+VrdaMgWKeKytL5KFuu2pcExirNMO8J1vsr6Imwjmuqtaq2b5W0YjUl3/FiQoGdwSx6HKmqdJM+AJq1s7rgCT3qHYBB2cYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP8kCdgh9JdBZ9PsUYjaNu5y7zPL3VGTR6UEGj6lmUk=;
 b=QDPqeZ2ULSKjYiSP2C+PwpLPdcXIzdB8loNxpgUDgV3wBZF2HvwTxCDqAoDa0lhlG+MyH7yEeto84sj5ccAi8ijWA8FHOLbCEz3k+jHjAw8Vg9MGEdYgTCU1jSkoqip7oTMLJLC3Qs1zZez+GwdeufM44o8zQwvSUDoU02a+900=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8926.eurprd04.prod.outlook.com (2603:10a6:102:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:34:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:34:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:33:44 -0400
Subject: [PATCH v3 08/11] PCI: imx: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pci2_upstream-v3-8-803414bdb430@nxp.com>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
In-Reply-To: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068432; l=5960;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fahIF35kCzzN2NR1WBFY+sDojPrl8TAvK/Kx6xk+iXE=;
 b=frWJTcymRSS0mT7N+72Jabvb9ATyTzdlIu+vXLhrdwUUXV6UoAGAIjF4LwkDSBK74zb+kO4xl
 h8om9wj6BhxAXtN9u2vT/LLgvyE/ynRsfHcMwO6PUaVuBI5FIUwGL9Q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8926:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iO5FvEW6kwMA+7jfDT8DotLOtQy49acskemoV8Hf47IoYwm/Gn371zLYlE47yKFVnJrFHSbL/5sVJ5RfIak175NDPgQy1pmJ1//7A5oJpXA9IyqLafsYMMs/IqgcKGN8kVwF5I4VWHuJHW9rKZ0UIEAppHnb14EaBn0EDW3345tivCbOdTcHiFGPUou3MtFybwy5sK6ozeKfV2HJpfR1YZRC8tcD3grl1wAQglWuLozKL/X2B3vcBW2HJtqRVO4X/eA2DPIVFhg1ZXcvSzw14WT2SVW0nyLawlPIPpWmhdi2FbEdm9vzYlNANVvVF6UW83uC1+EsGTS9iaZoGOpT3WrqJ0s6EwdRTcT3p9VRdR73oS0PpGxy+ezrcnhfx89kBOR2bN0PCTpCsgBwIHlFZH9ON2PBrRLi8Fb/+bowgrJSZyiz02tmG4KWgRApINDtQIX/PDjUEKR6UGW3G5f5Q3Op8m0zIfA1nlv6hVtYXds6lwARuV6bSa46u9nq2mhibPBOqbibR/azFJr6NIPGO3iDTWTejMOBEABT0PbOx+cDWOGsocPs1PqSDWmJDBQYXjRrqgbaI2PD0Rwci+0/DLDqOnjE+YTd1N1iTSvVYLCJS7Xl51I+wYTVyWneS0+kSbEfX1jNko410t2NtQgW0kIHE2bT/3m3c4Sp9G/xAn77jJ4aGjnCj49SVtclHOXxQxFPYarA0nQFTnwwNdmo14684OvjI4Rw1pu6plT2dZs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1JiZ3dUMEN6ZmZPWXlKNmhFTEF2dEovbDVFdkdMNjVMVTZPOXZ6V2lBeW82?=
 =?utf-8?B?SVdBd3RlZXhjMnlmRjBPRTBnWmcvS01LUFp0ZGtkbnBudnZhQ1BQM3B3YmlV?=
 =?utf-8?B?VVpmN2xHVlJFTXh2ZVNVaGVRVDJuNFBnczJtbUFSSkp5Z21DWDNRZW1rUko5?=
 =?utf-8?B?M2xINVB2ZVZ6MDJPWDRVNE9wSmdHeHMwZGRQazhWd0FRemNQMFJNUGh6ZmlQ?=
 =?utf-8?B?RGJ3RHZYUzN1WDE0SDdIK0NTeFprRHlEZ3NxYUxHS2I3NEJ6WHBsdC96eWNs?=
 =?utf-8?B?QVg0N1ZNczVxMGRUbnNSRjlWeVQydGlQN2h5RGM0U3djSlVuWlJTVE8wR1la?=
 =?utf-8?B?Vml5Y3ViYzF0SUtpay9VUkdrWHZ1WXlKUEM5NXB1OUt3STNZczlFZXZ3RTY5?=
 =?utf-8?B?S2Jpa0U4ZUU4Rk1ETUcrcitrakxGc1EyM2Q5cXQ1WGczbUZKNlM3aEtpdUJS?=
 =?utf-8?B?MlJOLzY1VThxVDhnMWFYcWJpVG1uTmlmVFRkbXI3d3Y1VG84Qmd0a3o5L2ti?=
 =?utf-8?B?aVdSbTk3dzdvNWtiZDdkVjhnUVEvWTlVeG5TSTFpbkJsZG9Ba2NhSkp5ZThT?=
 =?utf-8?B?cFdySk9CV3RkT09yNk9aaHhRR2k0cGZDK0g4ditVODZUWmxhNmVuMDFWWXB1?=
 =?utf-8?B?Rnh1U3plTVRqT21weXBjaU1iZ01NUkRUbEREVit5ZzExM1JOemZYWjQ0NGJx?=
 =?utf-8?B?SG83WGR2eDRkYWRuMW03OWNBZ1ZiOTdITDZLZyt3S0FEVnpISU55OGNDeDdr?=
 =?utf-8?B?bjZCR0NHaEo2WTlrdUtkK2dvcHVuT3JmbW10TGJLQ1RXV21XUzJyd1h2R1hM?=
 =?utf-8?B?ZjFZYUEyaU5iNDdjQWdlZ0VxZFFHZXB6ZXpFZ2x1MWR6S0I0bVZUbTdxMjlP?=
 =?utf-8?B?cUUyUGhMcGJMTnRrNXJsRDZ5VUlPRVBKY3Z3TW1RVGtSamxnRitBbmtienA2?=
 =?utf-8?B?a1N1ek1iKzd4aUZpYVFmZjNZWmRYV01yQUgycy9xckdYVE5OK1NtcHVwQkxS?=
 =?utf-8?B?U1VBSHhiNVlDWFVLRmYzdW9mOG9HNWQ0RGcxTWdsWVprMEhlSFVGbWQvNWEr?=
 =?utf-8?B?MFRsRm9wYmE4TlplY0lJbk5HZTBkakU3MGU0UVhiUVJCZWF4eG8vUHMzOWF2?=
 =?utf-8?B?UUkyOUF4RThsS3R3SzI4RWZ0ODE2MzBFMVNnc0dMTTYyVWk5d3NGUFlacnFm?=
 =?utf-8?B?U3RXRnIxR1ZlYlVIUjlVeFpvTzg1V284OFAyb1F0TXVVSE1GS0hRMEJPL2xq?=
 =?utf-8?B?VkE5U1U4UkZPMDJQRGpEWlVLL1k1VkI2VHRSalMySy8rdUQ3Ulo0R0JEKzNl?=
 =?utf-8?B?eHBVVnZibS9RYVZlc04zeXRxSVkzYkNidjc2NkVsQndYR3hzQlNKcHFJN3Fz?=
 =?utf-8?B?SnoyTGtiMks2dVAxcERTaUJFYnZZZjNSc1ViRjhJZEZFLzU2UG1sVG9aU0wx?=
 =?utf-8?B?ZFY4ZnpuR0dTQWxQQTNBR3FtWXRQTlpxdm8wNHBZU3NOdlBSYi9VRDdPTHlw?=
 =?utf-8?B?QTJ3bUc0WnBnODhsem9OaHdoaGNSSDV2NGJHZzFpVDhCaURCWVZiZ2lpRlhS?=
 =?utf-8?B?dGI5Tm1nUENvdWRYNFg0Z0UzcER6dVU3VGFneGx3aWV6ZWZEckRKVUxtZVlB?=
 =?utf-8?B?UTllMWtyQmlXTUNmOXNJU0JYYlJkQlFuL0gvRXc2QjFLK2NqMEFRakJQUlpZ?=
 =?utf-8?B?RTZ0MGY1U3BVRzRNUHlKS3RkeDNTRlJrT3ZiZmYvbmhTS0ZsSXBpSjhuVVJ2?=
 =?utf-8?B?NU5pTjQ5TW5aT3I2eGtQN3V5U2M0Um5MU1JacGpIdmlhV0FMR0R5MDlaalAr?=
 =?utf-8?B?WUV4WVJNTnlTOWxtV1FWdzB6cklxbUY1LzNkSWFPeXZ4cC9aRmtWKzNuN2tI?=
 =?utf-8?B?OW43TUpBTjg2b2E4ZGJQUUZRU1JMekF0TFExUERWRGNsK2VYUWg0STIwN0p2?=
 =?utf-8?B?ZVQyNXloOFgwanhaMFZQMkZjcHFCYzZMZVBoRnpGSzRzRmVqcDlGenQ0UTZv?=
 =?utf-8?B?M0JWT0d3R3U4MmNPc1ZmOTFxUGEwQ3pGd0FQWkFKclZ1R2xRREg3UG96aitq?=
 =?utf-8?B?U1pjdjBEc3I3akxObjBKR1QxVkovK0d5ZWtnM0VHMFd6NEhzODdTREdnb2da?=
 =?utf-8?Q?L4eg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56357fa-4096-44be-6f43-08dc5322064b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:34:38.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijAiLgxffw0qp81eNSGtrUbrdifwY8D5OeTfrMaZnrhK/2+ntHZixygQjL0EnPkMUTAXU+5mZsiz5P/rEI63OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8926

i.MX95 need config LUT to convert bpf to stream id. IOMMU and ITS use the
same stream id. Check msi-map and smmu-map and make sure the same PCI bpf
map to the same stream id. Then config LUT related registers.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-imx.c | 175 ++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
index af0f960f28757..653d8e8ee1abc 100644
--- a/drivers/pci/controller/dwc/pcie-imx.c
+++ b/drivers/pci/controller/dwc/pcie-imx.c
@@ -55,6 +55,22 @@
 #define IMX95_PE0_GEN_CTRL_3			0x1058
 #define IMX95_PCIE_LTSSM_EN			BIT(0)
 
+#define IMX95_PE0_LUT_ACSCTRL			0x1008
+#define IMX95_PEO_LUT_RWA			BIT(16)
+#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
+
+#define IMX95_PE0_LUT_DATA1			0x100c
+#define IMX95_PE0_LUT_VLD			BIT(31)
+#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
+#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
+
+#define IMX95_PE0_LUT_DATA2			0x1010
+#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
+#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
+
+#define IMX95_SID_MASK				GENMASK(5, 0)
+#define IMX95_MAX_LUT				32
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -217,6 +233,159 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
+static int imx_pcie_update_lut(struct imx_pcie *imx_pcie, int index, u16 reqid, u16 mask, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
+
+	if (sid >= 64) {
+		dev_err(dev, "Too big stream id: %d\n", sid);
+		return -EINVAL;
+	}
+
+	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+	data1 |= IMX95_PE0_LUT_VLD;
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+	data2 = mask;
+	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, index);
+
+	return 0;
+}
+
+struct imx_of_map {
+	u32 bdf;
+	u32 phandle;
+	u32 sid;
+	u32 sid_len;
+};
+
+static int imx_check_msi_and_smmmu(struct imx_pcie *imx_pcie,
+				   struct imx_of_map *msi_map, u32 msi_size, u32 msi_map_mask,
+				   struct imx_of_map *smmu_map, u32 smmu_size, u32 smmu_map_mask)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	int i;
+
+	if (msi_map && smmu_map) {
+		if (msi_size != smmu_size)
+			return -EINVAL;
+		if (msi_map_mask != smmu_map_mask)
+			return -EINVAL;
+
+		for (i = 0; i < msi_size / sizeof(*msi_map); i++) {
+			if (msi_map->bdf != smmu_map->bdf) {
+				dev_err(dev, "bdf setting is not match\n");
+				return -EINVAL;
+			}
+			if ((msi_map->sid & IMX95_SID_MASK) != smmu_map->sid) {
+				dev_err(dev, "sid setting is not match\n");
+				return -EINVAL;
+			}
+			if ((msi_map->sid_len & IMX95_SID_MASK) != smmu_map->sid_len) {
+				dev_err(dev, "sid_len setting is not match\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Simple static config lut according to dts settings DAC index and stream ID used as a match result
+ * of LUT pre-allocated and used by PCIes.
+ *
+ * Currently stream ID from 32-64 for PCIe.
+ * 32-40: first PCI bus.
+ * 40-48: second PCI bus.
+ *
+ * DAC_ID is index of TRDC.DAC index, start from 2 at iMX95.
+ * ITS [pci(2bit): streamid(6bits)]
+ *	pci 0 is 0
+ *	pci 1 is 3
+ */
+static int imx_pcie_config_sid(struct imx_pcie *imx_pcie)
+{
+	struct imx_of_map *msi_map = NULL, *smmu_map = NULL, *cur;
+	int i, j, lut_index, nr_map, msi_size = 0, smmu_size = 0;
+	u32 msi_map_mask = 0xffff, smmu_map_mask = 0xffff;
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 mask;
+	int size;
+
+	of_get_property(dev->of_node, "msi-map", &msi_size);
+	if (msi_size) {
+		msi_map = devm_kzalloc(dev, msi_size, GFP_KERNEL);
+		if (!msi_map)
+			return -ENOMEM;
+
+		if (of_property_read_u32_array(dev->of_node, "msi-map", (u32 *)msi_map,
+					       msi_size / sizeof(u32)))
+			return -EINVAL;
+
+		of_property_read_u32(dev->of_node, "msi-map-mask", &msi_map_mask);
+	}
+
+	cur = msi_map;
+	size = msi_size;
+	mask = msi_map_mask;
+
+	of_get_property(dev->of_node, "iommu-map", &smmu_size);
+	if (smmu_size) {
+		smmu_map = devm_kzalloc(dev, smmu_size, GFP_KERNEL);
+		if (!smmu_map)
+			return -ENOMEM;
+
+		if (of_property_read_u32_array(dev->of_node, "iommu-map", (u32 *)smmu_map,
+					       smmu_size / sizeof(u32)))
+			return -EINVAL;
+
+		of_property_read_u32(dev->of_node, "iommu_map_mask", &smmu_map_mask);
+	}
+
+	if (imx_check_msi_and_smmmu(imx_pcie, msi_map, msi_size, msi_map_mask,
+				     smmu_map, smmu_size, smmu_map_mask))
+		return -EINVAL;
+
+	if (!cur) {
+		cur = smmu_map;
+		size = smmu_size;
+		mask = smmu_map_mask;
+	}
+
+	nr_map = size / (sizeof(*cur));
+
+	lut_index = 0;
+	for (i = 0; i < nr_map; i++) {
+		for (j = 0; j < cur->sid_len; j++) {
+			imx_pcie_update_lut(imx_pcie, lut_index, cur->bdf + j, mask,
+					    (cur->sid + j) & IMX95_SID_MASK);
+			lut_index++;
+		}
+		cur++;
+
+		if (lut_index >= IMX95_MAX_LUT) {
+			dev_err(dev, "its-map/iommu-map exceed HW limiation\n");
+			return -EINVAL;
+		}
+	}
+
+	devm_kfree(dev, smmu_map);
+	devm_kfree(dev, msi_map);
+
+	return 0;
+}
+
 static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 {
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
@@ -950,6 +1119,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		goto err_phy_off;
 	}
 
+	ret = imx_pcie_config_sid(imx_pcie);
+	if (ret < 0) {
+		dev_err(dev, "failed to config sid:%d\n", ret);
+		goto err_phy_off;
+	}
+
 	imx_setup_phy_mpll(imx_pcie);
 
 	return 0;

-- 
2.34.1


