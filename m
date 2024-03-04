Return-Path: <linux-pci+bounces-4481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDB3870B90
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 21:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76D32818F3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168DC7CF29;
	Mon,  4 Mar 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D1rYGIEH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AA7C0BA;
	Mon,  4 Mar 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583956; cv=fail; b=TXnRV+hxtbImjmucR7VW6I9/gxJcF8Jqcx/uJ3AH08guzWSjM8Ic2NjTmQozFlKFF3uNZL1WJehXeeaWl0F05Pes9NVLwsN41bnfqHiFHxsAxcy6+YVhtd0vEiyOo9mOa/IfhZf5cvfQ3R/qi3EpsoeKVJOYPll3FAEkh67XHLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583956; c=relaxed/simple;
	bh=yxG7AGjBMuePy4Pbyyz5wGDbAp0MgjoJQfLnxXmdHok=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EWTYiKhxQEHyvuke+Yz97+r9QUgeoLIYb225KhtYh4EBR1HdxRnAL9T791iNYpXgs0W9PVehHcCrcAHJnQmolYZa9igP7FRZ4sGxx5KRqEH6P+iH/V49q0GSUOnbalfHfQMt2pb/kuLND9nT12cIqS3U0WEoy62MLPWJt8HlBEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=D1rYGIEH; arc=fail smtp.client-ip=40.107.6.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHwjtoiYfVr0nTXpVvLJ7qO20dM/sriTm8JHKbjNnsHP5RQzv/axqNpYem+2A2sMBMQeYlx+0/lZ5eSjQkl9dEqliB24FXsxA5oswYm0FEBZDSPF9kEtnaVzo+7YC9QTCXJy88ZjOu8sPxgeQqAJisQznAsj4uwP74b+SXf+4c2pLBj2UKYUkZ2FyoLtJ2raDN9tscB+i7NQslfAggZOJ5TxcLyVcdFuao3+Wkdm10kIxIOgE1YC+uZikDPEcxYt3KhffHIMDYF84Z+7NvKWC4QkwiD0GEsstiEj24HHmaEfE4FJzIMe0coBrWVnq1tcRudZWMtJVblKlaM9MAfRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fr23l1BE/BC2PYVi1QqvOfijpDuQUmU1u/gTjcILKq0=;
 b=ZMOZMmYUQYqZBI7RnTgtw7f/mQHj7XMI8cCvMtodrB5n+fLssZ6KEU4T0b69osHAJa6mmV4RLS+zlJ96EixgUgI6Qx4s7ErDf/kVh5Obyh2evTlqKbY8y4fk7jQ2KVxm2SoGqhDtXJ2MIj69sOaiBWtpbcqHIAUJZIv2K5fZbhN7adDyJEPRYQRKvA0ybljzTJBneks/hBAHDC/WoNr7YkUuWTeFt7HKddo05lToNJwIvMRhvVgks9Y4sefga3GgtzNmR6IHFgYPGar7Tc/58cgUkQtQaq4pRcCscFb/BDC1hOuafAoSDypYffmdLyuPNjP/jlI56q8Ow+ge4A1upg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fr23l1BE/BC2PYVi1QqvOfijpDuQUmU1u/gTjcILKq0=;
 b=D1rYGIEHOkJVyYsCz11BqG0XP6h2xBnsFCnVnO94VY/JU/PpLej1kyj0aGi7b5VMracN/Ler0VlJvQxxroEu47Q3IW8opM+NJSvimx9A3xD+nSkIWBoV/GUHru+Gr19T1fxWiDXFKuQYJ07qhsFcpGyEW+aero/qkgwolLqI0ZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 20:25:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 20:25:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 04 Mar 2024 15:25:10 -0500
Subject: [PATCH v2 5/6] PCI: imx: Simplify switch-case logic by involve
 core_reset callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pci2_upstream-v2-5-ad07c5eb6d67@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709583933; l=7125;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yxG7AGjBMuePy4Pbyyz5wGDbAp0MgjoJQfLnxXmdHok=;
 b=Yhxo7qU9NIeBNHL5u9S02A03ulsLVGdz/YlmW0HF82CElxMuXvoQ99C0ae+8myqTrWiVHOwGF
 2/Vo1EB930yCCiocYULnh8ATzDX2VlTh6SSQJq68jwPlrlyXgcf54N1
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
X-MS-Office365-Filtering-Correlation-Id: f92244c0-e2d6-4b4a-458f-08dc3c894923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3f3odW/9d6sLKvkUidyI2hMKTzxIQbkeWiL2Tl2qMb35HLR+RL009fYPmw1KqNT6F0LJOhou0yHnDvHrwqIx6tZOSvHFuHfNiY0fFFSDAx3WSSAWJ7Vo9lvCUDIRH8Gg6Y/Ahtp/7Zzj87JO1pbkUA+f1DLQXAYTFMEJ+MJ389C0yjS7K+K4LA8DRb7jtfZIY2oQttXwf+Cf7NQN73Uf8Qtr3+Q+FCEYA1giCNM1gs1zy6qBmUfcb7Lhp4OWoeO6Xg1oK4tkP8ZTj0a0Pwy/zrf4Bc+cWXHGITK38rKE0x3qMYVScYTnjjInK1sV6liSNg2RMhn3oTUoc1XJBXDn0OEW5gnQuAuZK/fsfYLjlLxvzt4gFDohQ8YpbjpjU18d+Ab+jHPEZHd2fT8u+GwxLRm6jHAuTLF4jyNmJJl4QRDsU37zZv480WZHTDgCnDaWU5r1sU1NDau1WKx1yN0QdS+y7SMMXYTNyskHBtEIHN+QQeti5p7eeF79dMkW+LG7gsxCCDCeaVd95yC5c+EgAes+RcSThKRuSKlyQgsu2AkIl6zifNlobjM1jBh7OClqS8eT/KZ2gC0dExT4XNybFhjyYMzQmyW/81UrmBtSobFZ5YEVks2cCPAsqNenqsVOzxQDN7gCOm66DxVHXe8CvFkUmf47Gd9hJhQC/JXJWMJaX4rAfm4RIQP4M3POW2mewJtS7cgMM9SN/3Jhlua1QqZDqgXrnMpi8y/b9A3a49o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG9vVklqVWtsaFFXRVdIODNmNFdVc3F3MWFyWXpPSE5CdXVXU01zS0dxZ2lo?=
 =?utf-8?B?N2pyUmZ5MkFYbmY3S0J3SHg0UWV4YXFidkJpWWVwRW9MQTVDSTRIYzJkUzZR?=
 =?utf-8?B?S1hqZ2dDb2F0SlVVWkZpYTZQU0Z4R0RJN0Z3QkxSeVdTTmdGaWltajhtRXVQ?=
 =?utf-8?B?bGZaRmdFZ1VwcTlGKzJuLzFwQnlVZ2xGc1R2aGNUOGxXVVVmdFd3WmZlMmJp?=
 =?utf-8?B?Z0xpU1dEWWRZQStySmtvbTU0UUI5U2Q3U0hDNW9KZm5RSGgrbGFLNFp6amZp?=
 =?utf-8?B?aUVVYVk4eUFvL3p0ZTIzU201cFhObFdaWGRZblNJbGFZL1RMU1RVQnJ4WVNp?=
 =?utf-8?B?WUc4V0Z0bm1YUkVOeG9aSzZQRnBqYThCY3hENnI4SG9rcEg0c2VGOVBIcHY4?=
 =?utf-8?B?aDhNQWhONzE3ZGpUeDdNVUpYbFpPdVZQOVZTMkhCaHRhdXRxNGFxeG5qQ0ll?=
 =?utf-8?B?YkVyZlg0UTZHZ1JqUjY5YVdIYXNuUllkVTZ2cTFtQ2dNeFNBYVJRWjNjT2pG?=
 =?utf-8?B?V3U1a3RFM2NwcEZvT2hKMWt2WER1dStrSUR0ZzRrU1pZclhhZ29uVnFEMVZ3?=
 =?utf-8?B?QW9HblFHMzM2VjI5UlpxcVpISk5OcHFNajRGem5zQ2ZhSEllNHphNzFVTVdR?=
 =?utf-8?B?empETXJ4SzV3aFo5aG51T1huOHpHL1pqQmZ5MzQyZjNRamlnVWJKUEVZUWdy?=
 =?utf-8?B?cmh4Vk0vWktIb2wvYTZoZGJ0MVJFbmV5UFdqOEhhckV5bkR6Wlc2SWdhN2dw?=
 =?utf-8?B?U04zdnNIZUpSbitkcTU2eUZVVnYzbW13US9DUkxuSTRiZXhiUFYwdHkwU1o2?=
 =?utf-8?B?Mmlaa0l0UEk3Sk5Ka2ZVVUNIbDBjZjN4VTZ1L2c1c3dUR3pkMjZPK3ZGREdJ?=
 =?utf-8?B?bXJ5eTkyU0c3NmhZdDR0WHhUQW9sMFNXNVZDTjFrTDRMY0pPZFRRSEQ2Z3dm?=
 =?utf-8?B?a2lpTkFJMTBZR1V5YnVPRkU1OEtCWWcvTmFjeFZOczVrNWt2ZW1uS0dEa0dn?=
 =?utf-8?B?Rk1vbUF6V3l2a0FVWjIyRlZLbWt0YUtWMnVCY0FDTkpHUVNBTjZza1M2RUFK?=
 =?utf-8?B?YjZoRStuTmx4eFhaeVg2MU9GNFMvaURiL3pGbnR1alcxRHJZR0dQTUZ1Z0wv?=
 =?utf-8?B?Q0NTNEVNcGVmZjFvQlZKVCtNMFE0dDRYcVM1TzNualg4RXZGV3VIUFRUeEhQ?=
 =?utf-8?B?dDIxdUhNRGJ2WGhkQ2hHclU2Q2prUHlLM1o2TmxXbUloc2NudEc1QTZ3c1dn?=
 =?utf-8?B?UE1UUFltdHpRSzVMcjVlVHJ0a0Fud3VmWlAwNTBvRkdWeU9XWFYvaHdmNVFz?=
 =?utf-8?B?cnpaZC9QT2J0ek5IUGJhK3o5b0kzdjZ4eDNGYnBuY3ZSdWZLL3pQY1YyR2tU?=
 =?utf-8?B?N3cwU201bmpwU0k1V0JJZ05udWRsV2JtNU9mRzBhTWlyeUZ2OWtWODRiYVg2?=
 =?utf-8?B?SU12Zmp0c0E3blo0YUpvU3p3VDgrSDFYNXF1RDNoVHdqNzRFcGNoTnhBd283?=
 =?utf-8?B?MHRDTUpEdmE0MTc4dGRwSDZ1UDNWUmZ2U0JqT2p5bnRYbndLQWJrbXBIWVVK?=
 =?utf-8?B?djMzaHdTVVpNMHZoQ0Vvd2VPNy9ZbHFpNEtzMmZwL1k4eXNCVWJuL3VySlJu?=
 =?utf-8?B?Mi82UllXRDZpcnJwbWRNUWRKVDBxMWxpak1zQzAyMlhPczR2M2Q0WXNyZlpp?=
 =?utf-8?B?VHhTRms4TXFUNllNYkxiWmIyb2hvOVlVNnB5NDUzTTRhZ3dCOXZCSGxiVmlB?=
 =?utf-8?B?a0hkbXY2Zm02cjM4MS9WQUtIK2lINVNQRldmb1BCTXhBdXdRZkhPY1QyM3U3?=
 =?utf-8?B?aWdSTmZOZ2FEczNvOVZ0NVlJRTdQaFJwdTljdnpLZjF3cCs2TlpUam5LQ203?=
 =?utf-8?B?SVUxUkpnUlNIMkRiU1k2bHlLcmtGbk9Rb1MvTWtENFVKNEhCdStEU1BxOU1D?=
 =?utf-8?B?RVlwcEV3RERXSk5VZHAraS9nNVNRWFN0endGSk5zZk1FeTBwNHhsNGx2dGFI?=
 =?utf-8?B?K00yQ1FvMElPWUNoMmxiODJ6Q3RFVEpBOTc2RkZHMnl3QkNQUGoxWEFOU01W?=
 =?utf-8?B?Wm1SWlVxT0VVSTV6N0JQZUt3dmhJd2VLOFNTaEV0bVVTYmVhOEphdEx4b3dH?=
 =?utf-8?Q?8uifKUwrdEyXm0tc+PBbviPA9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92244c0-e2d6-4b4a-458f-08dc3c894923
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:25:51.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7eEujS444VtoXPhcKOMBAqlxEx/MaA3JbHVXtgjvTPagUA+FbqPfkTVav8Zv+5kebQu+qwADsEhmXRqLIg7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083

Instead of using the switch case statement to assert/dassert the core reset
handled by this driver itself, let's introduce a new callback core_reset()
and define it for platforms that require it. This simplifies the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-imx.c | 131 ++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 63 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
index bff6212c617b7..922bbc0bc1bcd 100644
--- a/drivers/pci/controller/dwc/pcie-imx.c
+++ b/drivers/pci/controller/dwc/pcie-imx.c
@@ -104,6 +104,7 @@ struct imx_pcie_drvdata {
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
+	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 };
 
 struct imx_pcie {
@@ -671,35 +672,72 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
+static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   assert ? IMX6SX_GPR12_PCIE_TEST_POWERDOWN : 0);
+	/* Force PCIe PHY reset */
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
+			   assert ? IMX6SX_GPR5_PCIE_BTNRST_RESET : 0);
+	return 0;
+}
+
+static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
+			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
+	if (!assert)
+		usleep_range(200, 500);
+
+	return 0;
+}
+
+static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD,
+			   assert ? IMX6Q_GPR1_PCIE_TEST_PD : 0);
+
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN,
+			   assert ? 0 : IMX6Q_GPR1_PCIE_REF_CLK_EN);
+
+	return 0;
+}
+
+static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+
+	if (assert)
+		return 0;
+
+	/*
+	 * Workaround for ERR010728, failure of PCI-e PLL VCO to oscillate, especially when cold.
+	 * This turns off "Duty-cycle Corrector" and other mysterious undocumented things.
+	 */
+
+	if (likely(imx_pcie->phy_base)) {
+		/* De-assert DCC_FB_EN */
+		writel(PCIE_PHY_CMN_REG4_DCC_FB_EN, imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
+		/* Assert RX_EQS and RX_EQS_SEL */
+		writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL | PCIE_PHY_CMN_REG24_RX_EQ,
+		       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
+		/* Assert ATT_MODE */
+		writel(PCIE_PHY_CMN_REG26_ATT_MODE, imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
+	} else {
+		dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
+	}
+	imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
+	return 0;
+}
+
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
 	reset_control_assert(imx_pcie->apps_reset);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-		/* Force PCIe PHY reset */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
-		break;
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_SW_RST,
-				   IMX6Q_GPR1_PCIE_SW_RST);
-		break;
-	case IMX6Q:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
-		break;
-	default:
-		break;
-	}
+	if (imx_pcie->drvdata->core_reset)
+		imx_pcie->drvdata->core_reset(imx_pcie, true);
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx_pcie->reset_gpio))
@@ -709,47 +747,10 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
-	struct dw_pcie *pci = imx_pcie->pci;
-	struct device *dev = pci->dev;
-
 	reset_control_deassert(imx_pcie->pciephy_reset);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX7D:
-		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
-		 * oscillate, especially when cold.  This turns off "Duty-cycle
-		 * Corrector" and other mysterious undocumented things.
-		 */
-		if (likely(imx_pcie->phy_base)) {
-			/* De-assert DCC_FB_EN */
-			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
-			/* Assert RX_EQS and RX_EQS_SEL */
-			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
-				| PCIE_PHY_CMN_REG24_RX_EQ,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
-			/* Assert ATT_MODE */
-			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
-		} else {
-			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
-		}
-
-		imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
-		break;
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_SW_RST, 0);
-
-		usleep_range(200, 500);
-		break;
-	default:
-		break;
-	}
+	if (imx_pcie->drvdata->core_reset)
+		imx_pcie->drvdata->core_reset(imx_pcie, false);
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx_pcie->reset_gpio)) {
@@ -1445,6 +1446,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6q_pcie_core_reset,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1460,6 +1462,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
 		.set_ref_clk = imx6sx_pcie_set_ref_clk,
+		.core_reset = imx6sx_pcie_core_reset,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1476,6 +1479,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6qp_pcie_core_reset,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1489,6 +1493,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
 		.set_ref_clk = imx7d_pcie_set_ref_clk,
+		.core_reset = imx7d_pcie_core_reset,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,

-- 
2.34.1


