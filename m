Return-Path: <linux-pci+bounces-4477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E889870B84
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 21:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A455E1F229C2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EDC4AEF9;
	Mon,  4 Mar 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b8WXU1Gr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECE7AE75;
	Mon,  4 Mar 2024 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583947; cv=fail; b=QoFInEwIytbEoQpmM+PJbcdPvivbHCdugNt7bUCR4VHgt4mxgdnvg273761Lsp8N5McZeXEu5dBpwTTPUwegj+MZ/FRsxzGu22v2GkJd2RT3xlhsruaELiVCiFqvpsOkBmK0JdM5OTRB+nOHucLmHAs4mcsHowJUDFTHsDCS5mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583947; c=relaxed/simple;
	bh=8Hb5H4vKR0NdWcesuU43bjOBcLuppR7GFSBarkVTO54=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FcB/aFYrlX3j9CAb4s/uT/8IwME+iH7TD9dkL8GJEQ6Oe6e1AJzVytQhIbYXv9l4iX1Y+WOM3qLgtOJ6i+zFMMHuWkgH8J/SJ27vp5bfyav/RKmrwS7jQi/vamin1usxbWcKE9/9gCa2R5f2VxHosSvYleWf14HBxwjajqxS0+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=b8WXU1Gr; arc=fail smtp.client-ip=40.107.6.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJlfTx3NDJh49MHK2olkT7bUYvXljGODYdSp6zYxRqghCGcc6x2l4MITzdDtJKO1KwXSvsDg4+2pJrj/F6H7ev5/2phJ29hJEsVS83tf3E9Dk899JjBDshojOgVbC5B1Dvfom1GwSKMZwF0BQ/deZLcNq/qQqMDjwtVvElGPvUFeFpB+sZpommcOgNCM185YFPRCNayA8gRVaGN41zVgPd7JjCP/KpGI1xPeGit6IjcUIr/VZIXymNT2j9Hz0VB9LWa1tDxeAmTO9hmd0wcimPVDxMy+3p3I/2AHxqRfYr3DIlNyeQMIb5qZNu1i+1rCzly/axkkcUsGraG0fdw0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bsOd5bZlzmjRcAY9umW8miaTRo9tpipw/T4Uh3Ro+c=;
 b=XvX/74xFAf5UgtQ4W2Vav4fpd2qq/cN49ddJakGyQ4p3KK5XA5OWt9A5/84gsFBF9Taf7Hrfa9nM4etQ4NeWwDtxgDayKEK2IPtDzoGL8GrRqQW9tF8XjjE47AI7kHXmnNXFbMlI41c4fX034umeF+VIjhRU09HnswBiH3Nf8F2KCT6/WrC20H144T43gAhnm3RXvlJOnzrg2xcuiCWdQwfpwgR4QcZtiQ05lya+n4HHqL8Di8fl9+pRoD8MFpmEX4wIgc0z7VvYk1kIlBwgpWH0PDXeWQLaSqZblPdvThwXAtJtyln3v++HrQ88ISkVbMbzD7OXK1nipMmrXnAS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bsOd5bZlzmjRcAY9umW8miaTRo9tpipw/T4Uh3Ro+c=;
 b=b8WXU1GrEsdPNt7d9b02YJJrzHE/6yf4Z5r5AN8z0sijugIc14cOQXurErNa2CFXVTGjHTnFye0nFs9hvHzJNAby34rgEKNaP0AGCxgiLXUAM5DmBfvRY7ZPOSPSkdWpN19Pa+4qs6fH39dA1tX/0slclB8WUIkH0/97e+YCtT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 20:25:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 20:25:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 04 Mar 2024 15:25:06 -0500
Subject: [PATCH v2 1/6] PCI: imx6: Rename imx6_* with imx_*
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pci2_upstream-v2-1-ad07c5eb6d67@nxp.com>
References: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
In-Reply-To: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709583932; l=59482;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8Hb5H4vKR0NdWcesuU43bjOBcLuppR7GFSBarkVTO54=;
 b=Xp7iO+pCnewmKXkbmxwNrktY0Vmc8IxotatuAO0q7aF934d2I1ONAnbs8qvlPbyqMdnK2OFir
 j/VA82ArFD/BWZ7W/ebc9vYRkHxUFbN6Did5sWZsQC9joO75h5i161s
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: e31a1fa4-2ebc-4275-768b-08dc3c8941b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ruSuP1RkRMpD+hw8vc+jbTAJlDI6rNBmjynsfOMtZ6yt0w5L+dr7oSpjMWZxGZtwJlBZjqLZ6bSvzmCyPXSd3opup5+ZznpLe1/MCe+8YWAn6k5NIFaTnsXOumMauVukC7xu9x1/mySsyuE7Pdjh9YaYthqec/WSI9EcinuUZttYPpt9VfkcXNTdN9p1XoRIYgafRwS0yJSiCo21puQgh8G6c/y2BjI/1Wkrc1q8LCw+LNhqhrHoiqkA6OLAZT3LXNQ5uLT/jiRvDwrxV2TnvEYdTuZYQtZuRMOAzDvNsWWF3ug4ExZ0ChZULHPLdHC8PzPp7mhL3EnP+0GBmG11kUrtz0TKlQzVHwki3F82tNtonGhm5Xpcd5kJQ8M2JqrepXB8w3xwthOvPq3tgq+YYvp+DQ1xXfYvAirNGSuYx7/m1ZY/cshzbhZqJpt2SD2FsRWMNk8wM4vXIDaSQqteZ4PmXYLLDp+tMtm0VMcLc6pacswIwry6xXovPQGdJk0ALqM2pK1uw5UR6jF/wcQfeKOCj1JaLv5R+Vrs7mzB7p/P1ISlnKU2W5kq7w54kkJmEhHr2p/OMX3/zh9MCYFUziqoHUnlfACKCMFtrzssOHUMZ9yEeEYgd360Nd2+2RunSg3Rg+us69ipdxJZOQxRcKGDqsRQ08+AXTg0FDiQcTFxjmhMfJTce7FDW2GL0QBqqzPbg6i+rDgLdAtQe6GKykyA0rUZo6Fuo1C7wABSiEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0h5d1dnbFo5RTV5K0dDSHcwRmNKMnF5THZER3JwZkxqclcyS0d2ZDRkajNZ?=
 =?utf-8?B?MDN1REpuZWhIRzllUlVNcWR0N1B1MUJFVkp6cFFnUGNBVHBiNzk0VHFQYU5K?=
 =?utf-8?B?bUxWMEtGYUl6YmYrc3ZZbkxoTVJPZ0tTaTluaGZjb2JIai9qeW1KNllyRHlK?=
 =?utf-8?B?NWQ3Q1N1SWdEQzE2SjNndTNmRFZpWVA0clRHbkxUWUlNaGJCY2Q5NHVDaUJz?=
 =?utf-8?B?dzlsQng4eUIvYWRaMGRHdWdXZWRZZWxQS1hwYmJuUFlJcEI4TjNqVEZ3VlVO?=
 =?utf-8?B?TGdadlMreU14YlhwZW1vSGh2OWlDVFNBVVU3aTYwUXNjalJ4QW1WVVZjeXpH?=
 =?utf-8?B?VEV5WTcrb0o5VENGaU5ycm1RbG5lNDFVTzZjY1F1Vms2K2g3M1M0bHh5Rlkr?=
 =?utf-8?B?QVc0bWtZRGs0TzROcWtXNHE2WEdkR0pxSnRzZjRHUUw1QXZXT25LV1R2azZR?=
 =?utf-8?B?RUJxVHBHVkV2SFNsbzkrTkU4OTVjK1VsbVhNT0ZVTnp2NDJFZjcvVHNUbS9m?=
 =?utf-8?B?S25HQ0RPaFBUQkYwWDFOWmNmYnFoTmdJTFhjek15KytjSDhyMllqSXdGdDJa?=
 =?utf-8?B?bVFqd0pBd2RJRE0vZUExcVROT3JKK3ZlNlVDQjF2T0ZpUG5HRVV5d284K0x6?=
 =?utf-8?B?WG4ya3h2MFAwM2dDa25tNEF6Ky9EVXhmNTdLanJsNUxCbmdIVjN2ak81MnRP?=
 =?utf-8?B?dmVsVE5pQUJGN3pXMFUyekRTNmwzQkkwM2s2WjlLbjJ5SkZtcTI1STV2eUt5?=
 =?utf-8?B?dnFEWDZma0hzUWhsRHNsUytqaXIwVm1Xb0Yvczh3aExoK3pLY3RuemppQ3JZ?=
 =?utf-8?B?NVJCZktJbmR3OEZsb2xEN1FGVEM0dkpsZ21UZHJkZERsWUxyb0RjODBhOGZi?=
 =?utf-8?B?SVlRaEZWS09IQ3FOaWVIc0ZLTnJaRk8wYk9GOU84SUNUTU5zSmQrZkg4QnlM?=
 =?utf-8?B?L2lWRy91QTdQQnVodzN4eE8xWWM4Y0pZSTlkU3c2MEFBblFVa3BMb09kWXZV?=
 =?utf-8?B?dmxiODg4K080MTRKc2hiNERTZjVJVGtuMTlpeW9qNC9DeVVMT2RmOG04dkdv?=
 =?utf-8?B?RER5RFBrNE9kMzl2dms4VVE5VGJnQmpPRmcyN0lFak5vY2Nmd1RiWlBuRldh?=
 =?utf-8?B?Z0JGK2o3Tld4MC9HT1I3dzk4ZklFQTgyVzltNmRXRFIremMrM01wUy9Ia0hI?=
 =?utf-8?B?d1BsV1JrOWlrcUIzZndEWkNBMWJQM2FHMEJtQiswWGg1VDVSOGV6dVFzK0kw?=
 =?utf-8?B?QkJDeElHS2J6d3JTV2NXVTMySnd5dHAvNFFqNXBDaDVaZDlYOGM1ZGJCYVNU?=
 =?utf-8?B?WklxVmxWY2ZHK2FsTzhOYWprUTFTbzBHdVorTHMwNnlIZ0x4Si8wRlRncTFx?=
 =?utf-8?B?eUJCc0p0Z0FKaVZIenhQcGJRV3lVVlM5OXJzQnpYQXViZzJYMUVFWFNsWG5w?=
 =?utf-8?B?b1c0VE5CT0loNWhudnhNeUxvQjFrSnN1eDA4eG1WY0NyV29GeWNuZDRVWDZH?=
 =?utf-8?B?aVJTc3llSmhwT3FldkVOZ3o1cVB6L3pBeFkrN1QwejBteXBLeVVNY2ZJeTRE?=
 =?utf-8?B?Z0pFYVZmNHZ6TUJOZ2ZJQW8wM2MyMTdrMlEwS2d5dkJyclJxOXNNUURmWjM3?=
 =?utf-8?B?L2x5d1BHZnNrc2IwVTR0cDdqR1o3UFNMK251My9lditPODU1QnZleHIrMENv?=
 =?utf-8?B?b3BEdkZ1OGZUN3oweGFvUGMwNzlFRW50NmMrVjV3aVp3dUhEUnJ6UkNlOGEv?=
 =?utf-8?B?VE5QUlV2Q0o0bzJZRnVhWWorcHU3NitML0FBYmx2MHNabEV0eDUxTVpTNFB1?=
 =?utf-8?B?S1AzVXIrckJxUGlQQldhMTVsSU5sLzB2aG9JbXNwR3hybXFoMlAvTE9kWE42?=
 =?utf-8?B?SXlHajI4MmNUY3ZUU1p1WTY2bzVYdkFJSDZ5QjEyUmZxNlhQUzRJRk83c25m?=
 =?utf-8?B?OW9ROWtIRXV5U0xxajR4YnBkWm1NS1lGZmtEUkR6NjFsTnUrdktkd2srZmJQ?=
 =?utf-8?B?eFROa2FGUDRVNEhMVnVFNDBSOEZkTHJOUnhkeTJpTjhycDNGK1ptRzdweWI0?=
 =?utf-8?B?UzJaSkNWVjgzZm5GU0xWY2g0Mk9rc3p3NTlCdVYvT0Y0ZS9EcURtUUJNa20v?=
 =?utf-8?Q?ulWprxjVWGKqiERH9YZqt7aNV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31a1fa4-2ebc-4275-768b-08dc3c8941b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:25:39.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FhcjqzMjrVqhfi7OL9OWphyKfUUZOcCX8ZDRpVBiE89pXJprDj6fxa2r0sOFiqSuWvK7jBCCfROSa23qFB5kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083

imx6_* actually mean for all imx chips (imx6x, imx7x, imx8x and imx9x).
Rename imx6_* with imx_* to avoid confuse.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 754 +++++++++++++++++-----------------
 1 file changed, 377 insertions(+), 377 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 99a60270b26cd..4aa5f054d91c8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -55,9 +55,9 @@
 #define IMX95_PE0_GEN_CTRL_3			0x1058
 #define IMX95_PCIE_LTSSM_EN			BIT(0)
 
-#define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
+#define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
-enum imx6_pcie_variants {
+enum imx_pcie_variants {
 	IMX6Q,
 	IMX6SX,
 	IMX6QP,
@@ -72,25 +72,25 @@ enum imx6_pcie_variants {
 	IMX95_EP,
 };
 
-#define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
-#define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
-#define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
-#define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
-#define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
-#define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
-#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
-#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
+#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE	BIT(1)
+#define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
+#define IMX_PCIE_FLAG_HAS_PHYDRV			BIT(3)
+#define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
+#define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
+#define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
+#define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
 
-#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
+#define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
 
-#define IMX6_PCIE_MAX_CLKS       6
+#define IMX_PCIE_MAX_CLKS       6
 
-#define IMX6_PCIE_MAX_INSTANCES			2
+#define IMX_PCIE_MAX_INSTANCES			2
 
-struct imx6_pcie;
+struct imx_pcie;
 
-struct imx6_pcie_drvdata {
-	enum imx6_pcie_variants variant;
+struct imx_pcie_drvdata {
+	enum imx_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
 	int dbi_length;
@@ -99,18 +99,18 @@ struct imx6_pcie_drvdata {
 	const u32 clks_cnt;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
-	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
-	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
+	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
-	int (*init_phy)(struct imx6_pcie *pcie);
+	int (*init_phy)(struct imx_pcie *pcie);
 };
 
-struct imx6_pcie {
+struct imx_pcie {
 	struct dw_pcie		*pci;
 	int			reset_gpio;
 	bool			gpio_active_high;
 	bool			link_is_up;
-	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
+	struct clk_bulk_data	clks[IMX_PCIE_MAX_CLKS];
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -131,7 +131,7 @@ struct imx6_pcie {
 	/* power domain for pcie phy */
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
-	const struct imx6_pcie_drvdata *drvdata;
+	const struct imx_pcie_drvdata *drvdata;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -186,28 +186,28 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
-static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
+static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 {
-	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
-		imx6_pcie->drvdata->variant != IMX8MQ_EP &&
-		imx6_pcie->drvdata->variant != IMX8MM &&
-		imx6_pcie->drvdata->variant != IMX8MM_EP &&
-		imx6_pcie->drvdata->variant != IMX8MP &&
-		imx6_pcie->drvdata->variant != IMX8MP_EP);
-	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
+	WARN_ON(imx_pcie->drvdata->variant != IMX8MQ &&
+		imx_pcie->drvdata->variant != IMX8MQ_EP &&
+		imx_pcie->drvdata->variant != IMX8MM &&
+		imx_pcie->drvdata->variant != IMX8MM_EP &&
+		imx_pcie->drvdata->variant != IMX8MP &&
+		imx_pcie->drvdata->variant != IMX8MP_EP);
+	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
-static int imx95_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			IMX95_PCIE_SS_RW_REG_0,
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			   IMX95_PCIE_PHY_GEN_CTRL,
 			   IMX95_PCIE_REF_USE_PAD, 0);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			   IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
 			   IMX95_PCIE_REF_CLKEN);
@@ -215,9 +215,9 @@ static int imx95_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 	return 0;
 }
 
-static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 {
-	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
+	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 	unsigned int mask, val, mode, id;
 
 	if (drvdata->mode == DW_PCIE_EP_TYPE)
@@ -225,7 +225,7 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 	else
 		mode = PCI_EXP_TYPE_ROOT_PORT;
 
-	id = imx6_pcie->controller_id;
+	id = imx_pcie->controller_id;
 
 	/* If mode_mask[id] is zero, means each controller have its individual gpr */
 	if (!drvdata->mode_mask[id])
@@ -234,12 +234,12 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 	mask = drvdata->mode_mask[id];
 	val = mode << (ffs(mask) - 1);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
 }
 
-static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
+static int pcie_phy_poll_ack(struct imx_pcie *imx_pcie, bool exp_val)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	bool val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
@@ -258,9 +258,9 @@ static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 	return -ETIMEDOUT;
 }
 
-static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
+static int pcie_phy_wait_ack(struct imx_pcie *imx_pcie, int addr)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	u32 val;
 	int ret;
 
@@ -270,24 +270,24 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 	val |= PCIE_PHY_CTRL_CAP_ADR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
-	ret = pcie_phy_poll_ack(imx6_pcie, true);
+	ret = pcie_phy_poll_ack(imx_pcie, true);
 	if (ret)
 		return ret;
 
 	val = PCIE_PHY_CTRL_DATA(addr);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
-	return pcie_phy_poll_ack(imx6_pcie, false);
+	return pcie_phy_poll_ack(imx_pcie, false);
 }
 
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
-static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
+static int pcie_phy_read(struct imx_pcie *imx_pcie, int addr, u16 *data)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	u32 phy_ctl;
 	int ret;
 
-	ret = pcie_phy_wait_ack(imx6_pcie, addr);
+	ret = pcie_phy_wait_ack(imx_pcie, addr);
 	if (ret)
 		return ret;
 
@@ -295,7 +295,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 	phy_ctl = PCIE_PHY_CTRL_RD;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
 
-	ret = pcie_phy_poll_ack(imx6_pcie, true);
+	ret = pcie_phy_poll_ack(imx_pcie, true);
 	if (ret)
 		return ret;
 
@@ -304,18 +304,18 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 	/* deassert Read signal */
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
 
-	return pcie_phy_poll_ack(imx6_pcie, false);
+	return pcie_phy_poll_ack(imx_pcie, false);
 }
 
-static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
+static int pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	u32 var;
 	int ret;
 
 	/* write addr */
 	/* cap addr */
-	ret = pcie_phy_wait_ack(imx6_pcie, addr);
+	ret = pcie_phy_wait_ack(imx_pcie, addr);
 	if (ret)
 		return ret;
 
@@ -326,7 +326,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	var |= PCIE_PHY_CTRL_CAP_DAT;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
-	ret = pcie_phy_poll_ack(imx6_pcie, true);
+	ret = pcie_phy_poll_ack(imx_pcie, true);
 	if (ret)
 		return ret;
 
@@ -335,7 +335,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-	ret = pcie_phy_poll_ack(imx6_pcie, false);
+	ret = pcie_phy_poll_ack(imx_pcie, false);
 	if (ret)
 		return ret;
 
@@ -344,7 +344,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
-	ret = pcie_phy_poll_ack(imx6_pcie, true);
+	ret = pcie_phy_poll_ack(imx_pcie, true);
 	if (ret)
 		return ret;
 
@@ -353,7 +353,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-	ret = pcie_phy_poll_ack(imx6_pcie, false);
+	ret = pcie_phy_poll_ack(imx_pcie, false);
 	if (ret)
 		return ret;
 
@@ -362,74 +362,74 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	return 0;
 }
 
-static int imx8mq_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	/* TODO: Currently this code assumes external oscillator is being used */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr,
-			   imx6_pcie_grp_offset(imx6_pcie),
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
+			   imx_pcie_grp_offset(imx_pcie),
 			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
 			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
 	/*
 	 * Regarding the datasheet, the PCIE_VPH is suggested to be 1.8V. If the PCIE_VPH is
 	 * supplied by 3.3V, the VREG_BYPASS should be cleared to zero.
 	 */
-	if (imx6_pcie->vph && regulator_get_voltage(imx6_pcie->vph) > 3000000)
-		regmap_update_bits(imx6_pcie->iomuxc_gpr,
-				   imx6_pcie_grp_offset(imx6_pcie),
+	if (imx_pcie->vph && regulator_get_voltage(imx_pcie->vph) > 3000000)
+		regmap_update_bits(imx_pcie->iomuxc_gpr,
+				   imx_pcie_grp_offset(imx_pcie),
 				   IMX8MQ_GPR_PCIE_VREG_BYPASS,
 				   0);
 
 	return 0;
 }
 
-static int imx7d_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx7d_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
 
 	return 0;
 }
 
-static int imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 
 	/* configure constant input signal to the pcie ctrl and phy */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
-			   imx6_pcie->tx_deemph_gen1 << 0);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx_pcie->tx_deemph_gen1 << 0);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
-			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx_pcie->tx_deemph_gen2_3p5db << 6);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
-			   imx6_pcie->tx_deemph_gen2_6db << 12);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx_pcie->tx_deemph_gen2_6db << 12);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_SWING_FULL,
-			   imx6_pcie->tx_swing_full << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx_pcie->tx_swing_full << 18);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_SWING_LOW,
-			   imx6_pcie->tx_swing_low << 25);
+			   imx_pcie->tx_swing_low << 25);
 	return 0;
 }
 
-static int imx6sx_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx6sx_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			   IMX6SX_GPR12_PCIE_RX_EQ_MASK, IMX6SX_GPR12_PCIE_RX_EQ_2);
 
-	return imx6_pcie_init_phy(imx6_pcie);
+	return imx_pcie_init_phy(imx_pcie);
 }
 
-static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
+static void imx7d_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
 {
 	u32 val;
-	struct device *dev = imx6_pcie->pci->dev;
+	struct device *dev = imx_pcie->pci->dev;
 
-	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
+	if (regmap_read_poll_timeout(imx_pcie->iomuxc_gpr,
 				     IOMUXC_GPR22, val,
 				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
 				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
@@ -437,19 +437,19 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 		dev_err(dev, "PCIe PLL lock timeout\n");
 }
 
-static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
+static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
 {
 	unsigned long phy_rate = 0;
 	int mult, div;
 	u16 val;
 	int i;
 
-	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_IMX_PHY))
 		return 0;
 
-	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
-		if (strncmp(imx6_pcie->clks[i].id, "pcie_phy", 8) == 0)
-			phy_rate = clk_get_rate(imx6_pcie->clks[i].clk);
+	for (i = 0; i < imx_pcie->drvdata->clks_cnt; i++)
+		if (strncmp(imx_pcie->clks[i].id, "pcie_phy", 8) == 0)
+			phy_rate = clk_get_rate(imx_pcie->clks[i].clk);
 
 	switch (phy_rate) {
 	case 125000000:
@@ -467,46 +467,46 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 		div = 1;
 		break;
 	default:
-		dev_err(imx6_pcie->pci->dev,
+		dev_err(imx_pcie->pci->dev,
 			"Unsupported PHY reference clock rate %lu\n", phy_rate);
 		return -EINVAL;
 	}
 
-	pcie_phy_read(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
+	pcie_phy_read(imx_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
 	val &= ~(PCIE_PHY_MPLL_MULTIPLIER_MASK <<
 		 PCIE_PHY_MPLL_MULTIPLIER_SHIFT);
 	val |= mult << PCIE_PHY_MPLL_MULTIPLIER_SHIFT;
 	val |= PCIE_PHY_MPLL_MULTIPLIER_OVRD;
-	pcie_phy_write(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
+	pcie_phy_write(imx_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
 
-	pcie_phy_read(imx6_pcie, PCIE_PHY_ATEOVRD, &val);
+	pcie_phy_read(imx_pcie, PCIE_PHY_ATEOVRD, &val);
 	val &= ~(PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK <<
 		 PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT);
 	val |= div << PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT;
 	val |= PCIE_PHY_ATEOVRD_EN;
-	pcie_phy_write(imx6_pcie, PCIE_PHY_ATEOVRD, val);
+	pcie_phy_write(imx_pcie, PCIE_PHY_ATEOVRD, val);
 
 	return 0;
 }
 
-static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_reset_phy(struct imx_pcie *imx_pcie)
 {
 	u16 tmp;
 
-	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_IMX_PHY))
 		return;
 
-	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
+	pcie_phy_read(imx_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
+	pcie_phy_write(imx_pcie, PHY_RX_OVRD_IN_LO, tmp);
 
 	usleep_range(2000, 3000);
 
-	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
+	pcie_phy_read(imx_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
+	pcie_phy_write(imx_pcie, PHY_RX_OVRD_IN_LO, tmp);
 }
 
 #ifdef CONFIG_ARM
@@ -545,22 +545,22 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 }
 #endif
 
-static int imx6_pcie_attach_pd(struct device *dev)
+static int imx_pcie_attach_pd(struct device *dev)
 {
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	struct device_link *link;
 
 	/* Do nothing when in a single power domain */
 	if (dev->pm_domain)
 		return 0;
 
-	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
-	if (IS_ERR(imx6_pcie->pd_pcie))
-		return PTR_ERR(imx6_pcie->pd_pcie);
+	imx_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
+	if (IS_ERR(imx_pcie->pd_pcie))
+		return PTR_ERR(imx_pcie->pd_pcie);
 	/* Do nothing when power domain missing */
-	if (!imx6_pcie->pd_pcie)
+	if (!imx_pcie->pd_pcie)
 		return 0;
-	link = device_link_add(dev, imx6_pcie->pd_pcie,
+	link = device_link_add(dev, imx_pcie->pd_pcie,
 			DL_FLAG_STATELESS |
 			DL_FLAG_PM_RUNTIME |
 			DL_FLAG_RPM_ACTIVE);
@@ -569,11 +569,11 @@ static int imx6_pcie_attach_pd(struct device *dev)
 		return -EINVAL;
 	}
 
-	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
-	if (IS_ERR(imx6_pcie->pd_pcie_phy))
-		return PTR_ERR(imx6_pcie->pd_pcie_phy);
+	imx_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
+	if (IS_ERR(imx_pcie->pd_pcie_phy))
+		return PTR_ERR(imx_pcie->pd_pcie_phy);
 
-	link = device_link_add(dev, imx6_pcie->pd_pcie_phy,
+	link = device_link_add(dev, imx_pcie->pd_pcie_phy,
 			DL_FLAG_STATELESS |
 			DL_FLAG_PM_RUNTIME |
 			DL_FLAG_RPM_ACTIVE);
@@ -585,20 +585,20 @@ static int imx6_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
+static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
 {
 	unsigned int offset;
 	int ret = 0;
 
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
 	case IMX6QP:
 	case IMX6Q:
 		/* power up core phy and enable ref clock */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
 		/*
 		 * the async reset input need ref clock to sync internally,
@@ -607,7 +607,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		 * add one ~10us delay here.
 		 */
 		usleep_range(10, 100);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	case IMX7D:
@@ -620,15 +620,15 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ_EP:
 	case IMX8MP:
 	case IMX8MP_EP:
-		offset = imx6_pcie_grp_offset(imx6_pcie);
+		offset = imx_pcie_grp_offset(imx_pcie);
 		/*
 		 * Set the over ride low and enabled
 		 * make sure that REF_CLK is turned on.
 		 */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
 				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
 				   0);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
 				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
 				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
 		break;
@@ -637,19 +637,19 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
-static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
 {
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX6QP:
 	case IMX6Q:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				IMX6Q_GPR1_PCIE_TEST_PD,
 				IMX6Q_GPR1_PCIE_TEST_PD);
 		break;
 	case IMX7D:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
@@ -658,17 +658,17 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 	}
 }
 
-static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
+static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	struct device *dev = pci->dev;
 	int ret;
 
-	ret = clk_bulk_prepare_enable(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
+	ret = clk_bulk_prepare_enable(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 	if (ret)
 		return ret;
 
-	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
+	ret = imx_pcie_enable_ref_clk(imx_pcie);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie ref clock\n");
 		goto err_ref_clk;
@@ -679,41 +679,41 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 	return 0;
 
 err_ref_clk:
-	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
+	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 
 	return ret;
 }
 
-static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
-	imx6_pcie_disable_ref_clk(imx6_pcie);
-	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
+	imx_pcie_disable_ref_clk(imx_pcie);
+	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
-static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
-	reset_control_assert(imx6_pcie->pciephy_reset);
-	reset_control_assert(imx6_pcie->apps_reset);
+	reset_control_assert(imx_pcie->pciephy_reset);
+	reset_control_assert(imx_pcie->apps_reset);
 
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 		/* Force PCIe PHY reset */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
 		break;
 	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_SW_RST,
 				   IMX6Q_GPR1_PCIE_SW_RST);
 		break;
 	case IMX6Q:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 		break;
 	default:
@@ -721,47 +721,47 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio))
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
-					imx6_pcie->gpio_active_high);
+	if (gpio_is_valid(imx_pcie->reset_gpio))
+		gpio_set_value_cansleep(imx_pcie->reset_gpio,
+					imx_pcie->gpio_active_high);
 }
 
-static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
+static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	struct device *dev = pci->dev;
 
-	reset_control_deassert(imx6_pcie->pciephy_reset);
+	reset_control_deassert(imx_pcie->pciephy_reset);
 
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX7D:
 		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
 		 * oscillate, especially when cold.  This turns off "Duty-cycle
 		 * Corrector" and other mysterious undocumented things.
 		 */
-		if (likely(imx6_pcie->phy_base)) {
+		if (likely(imx_pcie->phy_base)) {
 			/* De-assert DCC_FB_EN */
 			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
-			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
+			       imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
 			/* Assert RX_EQS and RX_EQS_SEL */
 			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
 				| PCIE_PHY_CMN_REG24_RX_EQ,
-			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
+			       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
 			/* Assert ATT_MODE */
 			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
-			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
+			       imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
 		} else {
 			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
 		}
 
-		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
+		imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
 		break;
 	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
 		break;
 	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_SW_RST, 0);
 
 		usleep_range(200, 500);
@@ -771,10 +771,10 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+	if (gpio_is_valid(imx_pcie->reset_gpio)) {
 		msleep(100);
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
-					!imx6_pcie->gpio_active_high);
+		gpio_set_value_cansleep(imx_pcie->reset_gpio,
+					!imx_pcie->gpio_active_high);
 		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
 		msleep(100);
 	}
@@ -782,9 +782,9 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	return 0;
 }
 
-static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
+static int imx_pcie_wait_for_speed_change(struct imx_pcie *imx_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	struct device *dev = pci->dev;
 	u32 tmp;
 	unsigned int retries;
@@ -801,33 +801,33 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	return -ETIMEDOUT;
 }
 
-static void imx6_pcie_ltssm_enable(struct device *dev)
+static void imx_pcie_ltssm_enable(struct device *dev)
 {
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
+	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
+	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
 	if (drvdata->ltssm_mask)
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
 				   drvdata->ltssm_mask);
 
-	reset_control_deassert(imx6_pcie->apps_reset);
+	reset_control_deassert(imx_pcie->apps_reset);
 }
 
-static void imx6_pcie_ltssm_disable(struct device *dev)
+static void imx_pcie_ltssm_disable(struct device *dev)
 {
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
+	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
+	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
 	if (drvdata->ltssm_mask)
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
 				   drvdata->ltssm_mask, 0);
 
-	reset_control_assert(imx6_pcie->apps_reset);
+	reset_control_assert(imx_pcie->apps_reset);
 }
 
-static int imx6_pcie_start_link(struct dw_pcie *pci)
+static int imx_pcie_start_link(struct dw_pcie *pci)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 tmp;
@@ -846,7 +846,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	/* Start LTSSM. */
-	imx6_pcie_ltssm_enable(dev);
+	imx_pcie_ltssm_enable(dev);
 
 	ret = dw_pcie_wait_for_link(pci);
 	if (ret)
@@ -869,8 +869,8 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 		dw_pcie_dbi_ro_wr_dis(pci);
 
-		if (imx6_pcie->drvdata->flags &
-		    IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE) {
+		if (imx_pcie->drvdata->flags &
+		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -880,7 +880,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 			 * failure.
 			 */
 
-			ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
+			ret = imx_pcie_wait_for_speed_change(imx_pcie);
 			if (ret) {
 				dev_err(dev, "Failed to bring link up!\n");
 				goto err_reset_phy;
@@ -895,37 +895,37 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		dev_info(dev, "Link: Only Gen1 is enabled\n");
 	}
 
-	imx6_pcie->link_is_up = true;
+	imx_pcie->link_is_up = true;
 	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
 
 err_reset_phy:
-	imx6_pcie->link_is_up = false;
+	imx_pcie->link_is_up = false;
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
-	imx6_pcie_reset_phy(imx6_pcie);
+	imx_pcie_reset_phy(imx_pcie);
 	return 0;
 }
 
-static void imx6_pcie_stop_link(struct dw_pcie *pci)
+static void imx_pcie_stop_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 
 	/* Turn off PCIe LTSSM */
-	imx6_pcie_ltssm_disable(dev);
+	imx_pcie_ltssm_disable(dev);
 }
 
-static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
+static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	int ret;
 
-	if (imx6_pcie->vpcie) {
-		ret = regulator_enable(imx6_pcie->vpcie);
+	if (imx_pcie->vpcie) {
+		ret = regulator_enable(imx_pcie->vpcie);
 		if (ret) {
 			dev_err(dev, "failed to enable vpcie regulator: %d\n",
 				ret);
@@ -933,83 +933,83 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
-	imx6_pcie_assert_core_reset(imx6_pcie);
+	imx_pcie_assert_core_reset(imx_pcie);
 
-	if (imx6_pcie->drvdata->init_phy)
-		imx6_pcie->drvdata->init_phy(imx6_pcie);
+	if (imx_pcie->drvdata->init_phy)
+		imx_pcie->drvdata->init_phy(imx_pcie);
 
-	imx6_pcie_configure_type(imx6_pcie);
+	imx_pcie_configure_type(imx_pcie);
 
-	ret = imx6_pcie_clk_enable(imx6_pcie);
+	ret = imx_pcie_clk_enable(imx_pcie);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
 		goto err_reg_disable;
 	}
 
-	if (imx6_pcie->phy) {
-		ret = phy_init(imx6_pcie->phy);
+	if (imx_pcie->phy) {
+		ret = phy_init(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "pcie PHY power up failed\n");
 			goto err_clk_disable;
 		}
 	}
 
-	if (imx6_pcie->phy) {
-		ret = phy_power_on(imx6_pcie->phy);
+	if (imx_pcie->phy) {
+		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");
 			goto err_phy_off;
 		}
 	}
 
-	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
+	ret = imx_pcie_deassert_core_reset(imx_pcie);
 	if (ret < 0) {
 		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
 		goto err_phy_off;
 	}
 
-	imx6_setup_phy_mpll(imx6_pcie);
+	imx_setup_phy_mpll(imx_pcie);
 
 	return 0;
 
 err_phy_off:
-	if (imx6_pcie->phy)
-		phy_exit(imx6_pcie->phy);
+	if (imx_pcie->phy)
+		phy_exit(imx_pcie->phy);
 err_clk_disable:
-	imx6_pcie_clk_disable(imx6_pcie);
+	imx_pcie_clk_disable(imx_pcie);
 err_reg_disable:
-	if (imx6_pcie->vpcie)
-		regulator_disable(imx6_pcie->vpcie);
+	if (imx_pcie->vpcie)
+		regulator_disable(imx_pcie->vpcie);
 	return ret;
 }
 
-static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
+static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 
-	if (imx6_pcie->phy) {
-		if (phy_power_off(imx6_pcie->phy))
+	if (imx_pcie->phy) {
+		if (phy_power_off(imx_pcie->phy))
 			dev_err(pci->dev, "unable to power off PHY\n");
-		phy_exit(imx6_pcie->phy);
+		phy_exit(imx_pcie->phy);
 	}
-	imx6_pcie_clk_disable(imx6_pcie);
+	imx_pcie_clk_disable(imx_pcie);
 
-	if (imx6_pcie->vpcie)
-		regulator_disable(imx6_pcie->vpcie);
+	if (imx_pcie->vpcie)
+		regulator_disable(imx_pcie->vpcie);
 }
 
-static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
-	.init = imx6_pcie_host_init,
-	.deinit = imx6_pcie_host_exit,
+static const struct dw_pcie_host_ops imx_pcie_host_ops = {
+	.init = imx_pcie_host_init,
+	.deinit = imx_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.start_link = imx6_pcie_start_link,
-	.stop_link = imx6_pcie_stop_link,
+	.start_link = imx_pcie_start_link,
+	.stop_link = imx_pcie_stop_link,
 };
 
-static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
+static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	enum pci_barno bar;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -1018,7 +1018,7 @@ static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
-static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+static int imx_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 				  unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -1065,35 +1065,35 @@ static const struct pci_epc_features imx95_pcie_epc_features = {
 };
 
 static const struct pci_epc_features*
-imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
+imx_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 
-	return imx6_pcie->drvdata->epc_features;
+	return imx_pcie->drvdata->epc_features;
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
-	.init = imx6_pcie_ep_init,
-	.raise_irq = imx6_pcie_ep_raise_irq,
-	.get_features = imx6_pcie_ep_get_features,
+	.init = imx_pcie_ep_init,
+	.raise_irq = imx_pcie_ep_raise_irq,
+	.get_features = imx_pcie_ep_get_features,
 };
 
-static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
+static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 			   struct platform_device *pdev)
 {
 	int ret;
 	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
 
-	imx6_pcie_host_init(pp);
+	imx_pcie_host_init(pp);
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ_EP:
 	case IMX8MM_EP:
 	case IMX8MP_EP:
@@ -1115,7 +1115,7 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
 		pci->dbi_base2 = NULL;
 
-	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SUPPORT_64BIT))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
 	ret = dw_pcie_ep_init(ep);
@@ -1124,30 +1124,30 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 		return ret;
 	}
 	/* Start LTSSM. */
-	imx6_pcie_ltssm_enable(dev);
+	imx_pcie_ltssm_enable(dev);
 
 	return 0;
 }
 
-static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie)
 {
-	struct device *dev = imx6_pcie->pci->dev;
+	struct device *dev = imx_pcie->pci->dev;
 
 	/* Some variants have a turnoff reset in DT */
-	if (imx6_pcie->turnoff_reset) {
-		reset_control_assert(imx6_pcie->turnoff_reset);
-		reset_control_deassert(imx6_pcie->turnoff_reset);
+	if (imx_pcie->turnoff_reset) {
+		reset_control_assert(imx_pcie->turnoff_reset);
+		reset_control_deassert(imx_pcie->turnoff_reset);
 		goto pm_turnoff_sleep;
 	}
 
 	/* Others poke directly at IOMUXC registers */
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX6SX:
 	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
 		break;
 	default:
@@ -1166,73 +1166,73 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	usleep_range(1000, 10000);
 }
 
-static void imx6_pcie_msi_save_restore(struct imx6_pcie *imx6_pcie, bool save)
+static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 {
 	u8 offset;
 	u16 val;
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 
 	if (pci_msi_enabled()) {
 		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
 		if (save) {
 			val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
-			imx6_pcie->msi_ctrl = val;
+			imx_pcie->msi_ctrl = val;
 		} else {
 			dw_pcie_dbi_ro_wr_en(pci);
-			val = imx6_pcie->msi_ctrl;
+			val = imx_pcie->msi_ctrl;
 			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
 			dw_pcie_dbi_ro_wr_dis(pci);
 		}
 	}
 }
 
-static int imx6_pcie_suspend_noirq(struct device *dev)
+static int imx_pcie_suspend_noirq(struct device *dev)
 {
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx6_pcie->pci->pp;
+	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
+	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
-	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
-	imx6_pcie_msi_save_restore(imx6_pcie, true);
-	imx6_pcie_pm_turnoff(imx6_pcie);
-	imx6_pcie_stop_link(imx6_pcie->pci);
-	imx6_pcie_host_exit(pp);
+	imx_pcie_msi_save_restore(imx_pcie, true);
+	imx_pcie_pm_turnoff(imx_pcie);
+	imx_pcie_stop_link(imx_pcie->pci);
+	imx_pcie_host_exit(pp);
 
 	return 0;
 }
 
-static int imx6_pcie_resume_noirq(struct device *dev)
+static int imx_pcie_resume_noirq(struct device *dev)
 {
 	int ret;
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx6_pcie->pci->pp;
+	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
+	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
-	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
-	ret = imx6_pcie_host_init(pp);
+	ret = imx_pcie_host_init(pp);
 	if (ret)
 		return ret;
-	imx6_pcie_msi_save_restore(imx6_pcie, false);
+	imx_pcie_msi_save_restore(imx_pcie, false);
 	dw_pcie_setup_rc(pp);
 
-	if (imx6_pcie->link_is_up)
-		imx6_pcie_start_link(imx6_pcie->pci);
+	if (imx_pcie->link_is_up)
+		imx_pcie_start_link(imx_pcie->pci);
 
 	return 0;
 }
 
-static const struct dev_pm_ops imx6_pcie_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
-				  imx6_pcie_resume_noirq)
+static const struct dev_pm_ops imx_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_pcie_suspend_noirq,
+				  imx_pcie_resume_noirq)
 };
 
-static int imx6_pcie_probe(struct platform_device *pdev)
+static int imx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
-	struct imx6_pcie *imx6_pcie;
+	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
@@ -1240,8 +1240,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	u16 val;
 	int i;
 
-	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
-	if (!imx6_pcie)
+	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
+	if (!imx_pcie)
 		return -ENOMEM;
 
 	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
@@ -1250,10 +1250,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-	pci->pp.ops = &imx6_pcie_host_ops;
+	pci->pp.ops = &imx_pcie_host_ops;
 
-	imx6_pcie->pci = pci;
-	imx6_pcie->drvdata = of_device_get_match_data(dev);
+	imx_pcie->pci = pci;
+	imx_pcie->drvdata = of_device_get_match_data(dev);
 
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
@@ -1265,9 +1265,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "Unable to map PCIe PHY\n");
 			return ret;
 		}
-		imx6_pcie->phy_base = devm_ioremap_resource(dev, &res);
-		if (IS_ERR(imx6_pcie->phy_base))
-			return PTR_ERR(imx6_pcie->phy_base);
+		imx_pcie->phy_base = devm_ioremap_resource(dev, &res);
+		if (IS_ERR(imx_pcie->phy_base))
+			return PTR_ERR(imx_pcie->phy_base);
 	}
 
 	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev, 0, &dbi_base);
@@ -1275,12 +1275,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pci->dbi_base);
 
 	/* Fetch GPIOs */
-	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
-	imx6_pcie->gpio_active_high = of_property_read_bool(node,
+	imx_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
+	imx_pcie->gpio_active_high = of_property_read_bool(node,
 						"reset-gpio-active-high");
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		ret = devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
-				imx6_pcie->gpio_active_high ?
+	if (gpio_is_valid(imx_pcie->reset_gpio)) {
+		ret = devm_gpio_request_one(dev, imx_pcie->reset_gpio,
+				imx_pcie->gpio_active_high ?
 					GPIOF_OUT_INIT_HIGH :
 					GPIOF_OUT_INIT_LOW,
 				"PCIe reset");
@@ -1288,70 +1288,70 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "unable to get reset gpio\n");
 			return ret;
 		}
-	} else if (imx6_pcie->reset_gpio == -EPROBE_DEFER) {
-		return imx6_pcie->reset_gpio;
+	} else if (imx_pcie->reset_gpio == -EPROBE_DEFER) {
+		return imx_pcie->reset_gpio;
 	}
 
-	if (imx6_pcie->drvdata->clks_cnt >= IMX6_PCIE_MAX_CLKS)
+	if (imx_pcie->drvdata->clks_cnt >= IMX_PCIE_MAX_CLKS)
 		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");
 
-	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
-		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
+	for (i = 0; i < imx_pcie->drvdata->clks_cnt; i++)
+		imx_pcie->clks[i].id = imx_pcie->drvdata->clk_names[i];
 
 	/* Fetch clocks */
-	ret = devm_clk_bulk_get(dev, imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
+	ret = devm_clk_bulk_get(dev, imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 	if (ret)
 		return ret;
 
-	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHYDRV)) {
-		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
-		if (IS_ERR(imx6_pcie->phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
+		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
+		if (IS_ERR(imx_pcie->phy))
+			return dev_err_probe(dev, PTR_ERR(imx_pcie->phy),
 					     "failed to get pcie phy\n");
 	}
 
-	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET)) {
-		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
-		if (IS_ERR(imx6_pcie->apps_reset))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_APP_RESET)) {
+		imx_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
+		if (IS_ERR(imx_pcie->apps_reset))
+			return dev_err_probe(dev, PTR_ERR(imx_pcie->apps_reset),
 					     "failed to get pcie apps reset control\n");
 	}
 
-	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET)) {
-		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
-		if (IS_ERR(imx6_pcie->pciephy_reset))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pciephy_reset),
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHY_RESET)) {
+		imx_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
+		if (IS_ERR(imx_pcie->pciephy_reset))
+			return dev_err_probe(dev, PTR_ERR(imx_pcie->pciephy_reset),
 					     "Failed to get PCIEPHY reset control\n");
 	}
 
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
-			imx6_pcie->controller_id = 1;
+			imx_pcie->controller_id = 1;
 		break;
 	default:
 		break;
 	}
 
 	/* Grab turnoff reset */
-	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
-	if (IS_ERR(imx6_pcie->turnoff_reset)) {
+	imx_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
+	if (IS_ERR(imx_pcie->turnoff_reset)) {
 		dev_err(dev, "Failed to get TURNOFF reset control\n");
-		return PTR_ERR(imx6_pcie->turnoff_reset);
+		return PTR_ERR(imx_pcie->turnoff_reset);
 	}
 
-	if (imx6_pcie->drvdata->gpr) {
+	if (imx_pcie->drvdata->gpr) {
 	/* Grab GPR config register range */
-		imx6_pcie->iomuxc_gpr =
-			 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
-		if (IS_ERR(imx6_pcie->iomuxc_gpr))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
+		imx_pcie->iomuxc_gpr =
+			 syscon_regmap_lookup_by_compatible(imx_pcie->drvdata->gpr);
+		if (IS_ERR(imx_pcie->iomuxc_gpr))
+			return dev_err_probe(dev, PTR_ERR(imx_pcie->iomuxc_gpr),
 					     "unable to find iomuxc registers\n");
 	}
 
-	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_SERDES)) {
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_SERDES)) {
 		void __iomem *off = devm_platform_ioremap_resource_byname(pdev, "app");
 
 		if (IS_ERR(off))
@@ -1364,59 +1364,59 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			.reg_stride = 4,
 		};
 
-		imx6_pcie->iomuxc_gpr = devm_regmap_init_mmio(dev, off, &regmap_config);
-		if (IS_ERR(imx6_pcie->iomuxc_gpr))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
+		imx_pcie->iomuxc_gpr = devm_regmap_init_mmio(dev, off, &regmap_config);
+		if (IS_ERR(imx_pcie->iomuxc_gpr))
+			return dev_err_probe(dev, PTR_ERR(imx_pcie->iomuxc_gpr),
 					     "unable to find iomuxc registers\n");
 	}
 
 	/* Grab PCIe PHY Tx Settings */
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
-				 &imx6_pcie->tx_deemph_gen1))
-		imx6_pcie->tx_deemph_gen1 = 0;
+				 &imx_pcie->tx_deemph_gen1))
+		imx_pcie->tx_deemph_gen1 = 0;
 
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-3p5db",
-				 &imx6_pcie->tx_deemph_gen2_3p5db))
-		imx6_pcie->tx_deemph_gen2_3p5db = 0;
+				 &imx_pcie->tx_deemph_gen2_3p5db))
+		imx_pcie->tx_deemph_gen2_3p5db = 0;
 
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-6db",
-				 &imx6_pcie->tx_deemph_gen2_6db))
-		imx6_pcie->tx_deemph_gen2_6db = 20;
+				 &imx_pcie->tx_deemph_gen2_6db))
+		imx_pcie->tx_deemph_gen2_6db = 20;
 
 	if (of_property_read_u32(node, "fsl,tx-swing-full",
-				 &imx6_pcie->tx_swing_full))
-		imx6_pcie->tx_swing_full = 127;
+				 &imx_pcie->tx_swing_full))
+		imx_pcie->tx_swing_full = 127;
 
 	if (of_property_read_u32(node, "fsl,tx-swing-low",
-				 &imx6_pcie->tx_swing_low))
-		imx6_pcie->tx_swing_low = 127;
+				 &imx_pcie->tx_swing_low))
+		imx_pcie->tx_swing_low = 127;
 
 	/* Limit link speed */
 	pci->link_gen = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
 
-	imx6_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
-	if (IS_ERR(imx6_pcie->vpcie)) {
-		if (PTR_ERR(imx6_pcie->vpcie) != -ENODEV)
-			return PTR_ERR(imx6_pcie->vpcie);
-		imx6_pcie->vpcie = NULL;
+	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
+	if (IS_ERR(imx_pcie->vpcie)) {
+		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
+			return PTR_ERR(imx_pcie->vpcie);
+		imx_pcie->vpcie = NULL;
 	}
 
-	imx6_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
-	if (IS_ERR(imx6_pcie->vph)) {
-		if (PTR_ERR(imx6_pcie->vph) != -ENODEV)
-			return PTR_ERR(imx6_pcie->vph);
-		imx6_pcie->vph = NULL;
+	imx_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
+	if (IS_ERR(imx_pcie->vph)) {
+		if (PTR_ERR(imx_pcie->vph) != -ENODEV)
+			return PTR_ERR(imx_pcie->vph);
+		imx_pcie->vph = NULL;
 	}
 
-	platform_set_drvdata(pdev, imx6_pcie);
+	platform_set_drvdata(pdev, imx_pcie);
 
-	ret = imx6_pcie_attach_pd(dev);
+	ret = imx_pcie_attach_pd(dev);
 	if (ret)
 		return ret;
 
-	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
-		ret = imx6_add_pcie_ep(imx6_pcie, pdev);
+	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
+		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
 			return ret;
 	} else {
@@ -1436,12 +1436,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void imx6_pcie_shutdown(struct platform_device *pdev)
+static void imx_pcie_shutdown(struct platform_device *pdev)
 {
-	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
+	struct imx_pcie *imx_pcie = platform_get_drvdata(pdev);
 
 	/* bring down link, so bootloader gets clean state in case of reboot */
-	imx6_pcie_assert_core_reset(imx6_pcie);
+	imx_pcie_assert_core_reset(imx_pcie);
 }
 
 static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
@@ -1449,11 +1449,11 @@ static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
 static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
 static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
 
-static const struct imx6_pcie_drvdata drvdata[] = {
+static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
-			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
+		.flags = IMX_PCIE_FLAG_IMX_PHY |
+			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6q_clks,
@@ -1462,13 +1462,13 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
-		.init_phy = imx6_pcie_init_phy,
+		.init_phy = imx_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
-			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
-			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX_PCIE_FLAG_IMX_PHY |
+			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6sx_clks,
 		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
@@ -1480,9 +1480,9 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
-			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
-			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX_PCIE_FLAG_IMX_PHY |
+			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6q_clks,
@@ -1491,13 +1491,13 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
-		.init_phy = imx6_pcie_init_phy,
+		.init_phy = imx_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_APP_RESET |
-			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
+		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
@@ -1507,8 +1507,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
-		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
-			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
+		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
@@ -1520,9 +1520,9 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHYDRV |
-			 IMX6_PCIE_FLAG_HAS_APP_RESET,
+		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_HAS_PHYDRV |
+			 IMX_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
@@ -1531,9 +1531,9 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHYDRV |
-			 IMX6_PCIE_FLAG_HAS_APP_RESET,
+		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_HAS_PHYDRV |
+			 IMX_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
@@ -1542,7 +1542,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX95] = {
 		.variant = IMX95,
-		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES,
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
@@ -1553,8 +1553,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
-			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
+		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
@@ -1568,7 +1568,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1579,7 +1579,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1590,8 +1590,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_SERDES |
-			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_SUPPORT_64BIT,
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
@@ -1604,7 +1604,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 };
 
-static const struct of_device_id imx6_pcie_of_match[] = {
+static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie",  .data = &drvdata[IMX6Q],  },
 	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
 	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
@@ -1620,19 +1620,19 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{},
 };
 
-static struct platform_driver imx6_pcie_driver = {
+static struct platform_driver imx_pcie_driver = {
 	.driver = {
 		.name	= "imx6q-pcie",
-		.of_match_table = imx6_pcie_of_match,
+		.of_match_table = imx_pcie_of_match,
 		.suppress_bind_attrs = true,
-		.pm = &imx6_pcie_pm_ops,
+		.pm = &imx_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-	.probe    = imx6_pcie_probe,
-	.shutdown = imx6_pcie_shutdown,
+	.probe    = imx_pcie_probe,
+	.shutdown = imx_pcie_shutdown,
 };
 
-static void imx6_pcie_quirk(struct pci_dev *dev)
+static void imx_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
 	struct dw_pcie_rp *pp = bus->sysdata;
@@ -1642,33 +1642,33 @@ static void imx6_pcie_quirk(struct pci_dev *dev)
 		return;
 
 	/* Make sure we only quirk devices associated with this driver */
-	if (bus->dev.parent->parent->driver != &imx6_pcie_driver.driver)
+	if (bus->dev.parent->parent->driver != &imx_pcie_driver.driver)
 		return;
 
 	if (pci_is_root_bus(bus)) {
 		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-		struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+		struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 
 		/*
 		 * Limit config length to avoid the kernel reading beyond
 		 * the register set and causing an abort on i.MX 6Quad
 		 */
-		if (imx6_pcie->drvdata->dbi_length) {
-			dev->cfg_size = imx6_pcie->drvdata->dbi_length;
+		if (imx_pcie->drvdata->dbi_length) {
+			dev->cfg_size = imx_pcie->drvdata->dbi_length;
 			dev_info(&dev->dev, "Limiting cfg_size to %d\n",
 					dev->cfg_size);
 		}
 	}
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
-			PCI_CLASS_BRIDGE_PCI, 8, imx6_pcie_quirk);
+			PCI_CLASS_BRIDGE_PCI, 8, imx_pcie_quirk);
 
-static int __init imx6_pcie_init(void)
+static int __init imx_pcie_init(void)
 {
 #ifdef CONFIG_ARM
 	struct device_node *np;
 
-	np = of_find_matching_node(NULL, imx6_pcie_of_match);
+	np = of_find_matching_node(NULL, imx_pcie_of_match);
 	if (!np)
 		return -ENODEV;
 	of_node_put(np);
@@ -1684,6 +1684,6 @@ static int __init imx6_pcie_init(void)
 			"external abort on non-linefetch");
 #endif
 
-	return platform_driver_register(&imx6_pcie_driver);
+	return platform_driver_register(&imx_pcie_driver);
 }
-device_initcall(imx6_pcie_init);
+device_initcall(imx_pcie_init);

-- 
2.34.1


