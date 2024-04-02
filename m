Return-Path: <linux-pci+bounces-5549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D812E8956EE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C028B62F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D853C13442E;
	Tue,  2 Apr 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NqEul29U"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2126.outbound.protection.outlook.com [40.107.22.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCC13340D;
	Tue,  2 Apr 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068476; cv=fail; b=SwhR2NsLY2RUpu7u1DjpZWm2YpuC3Cs0bQfEHr4wVqpLin/g7Sow9IhwYeECxd9gJzFvlNeV9p4m6Z3GcX5UCBkcwYtBkHpPl8XWc5HmUfF3Mv4L6JmB2zJzDbMwAW+f7AJWMgi8GwhaNpCSPIOI9psHx64bPb/hc6bfGIvXJiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068476; c=relaxed/simple;
	bh=mFhMz4VdFXqRSX2lKu1hElYPiRsX2Dg/xKkGszGaOgI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Sl5ZaRk5LQyBY275UsJb4xyRBgtNhiOsOHgA8vMwERH8jM6T456kBwnje0LBbD72psJlkVSY6Cgmo3oMYeSeWBNvBs8d5A8pyL9oD8TaH4zFSBCOU7l1XJPwnVcdfdyTANuHynU6S0zHBcJ2JAAUy0ut21d52PMeZD7RHAV0bIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NqEul29U; arc=fail smtp.client-ip=40.107.22.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWJHGb3hv7kf/fRawXA5+2XdiET9v8sGM4yfxSKsyc+xHjggTtB+DC075gkR93N8TteF72vR93J8jSIKU37KBk4DYVZ/FUN2fpIUPMaUR7K8C7/nfgizpJZ/6WzHBT2GAFQsUStKFvF9qi49UqsPZDmR3zYpbufDaIPqn36x0Y3G3kqFjhGvnl9JNXti6z3KtMyW2vXPRWf9whN8KszFJcG9xfd3oHbDtx59fSBQyYZ4lGhuLRZAnZkWyeV+FhaNFB4lyHpocodWDWXwWVWmXzRg9q/cJSrIllvc6SruWuQM8m9Ztol8v0VfHfcLADrlLePkWOt609+91xfA6OPGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv2RQwHxs4Ro2donJnjea0UmCTHdA8dsbQjjgbryEcE=;
 b=B3g0sPKkVGLRupIjQViUMMWssIhsNv859THMeLuSx1fVn2zxzR/heccmew3tOijArLoHhmz7OUzwn/Iez02CX1iyvIvXOapNtLXdoebY6ThV2lDpQGXD7++TiUdd0f60k5VF0hlCMNyh42L8aliIv5tArZyZ+TpRhSrgFRrkeWvGBiucJTyOa+P0ZIP/A4ftHuy5kIG1yQRVK7mhXX2aba55AzgkaV+EhfTrO91bh8rKw0j7bTvVG9SAkkQE1obSzzZxdA+g9BOgtkDa/4j34TIamYsU3HpshkY6yrX6qdtYJZ4Elhvn/w+IY1KOnvw0PbJFJbCVcQfjcw+Mhbp0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qv2RQwHxs4Ro2donJnjea0UmCTHdA8dsbQjjgbryEcE=;
 b=NqEul29U4SkdfXW7yry809idt9TenmMh8u8k/tbY0BJr333UfkBxipC6FF2vntCJRAPdCvF6vk6KJvIPgY3yVqbtM8WFvrntOsfyQJ6kv8b9uAYK2zpQAuI7U0sxHTKhgFTI7YAsoAnfzRW4Snk9OYdhjcq2R22jUddLm5DZX2g=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8926.eurprd04.prod.outlook.com (2603:10a6:102:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:34:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:34:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:33:43 -0400
Subject: [PATCH v3 07/11] PCI: imx: Simplify switch-case logic by involve
 core_reset callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pci2_upstream-v3-7-803414bdb430@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068432; l=7125;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mFhMz4VdFXqRSX2lKu1hElYPiRsX2Dg/xKkGszGaOgI=;
 b=4hs9iF9y+Gkzkopym5BC7dFu24MFD0bq8Y6yuBb82Lyz6F2BOM02L4A876Cz8RZZVtbH3SzRl
 SjNNPWoVR/XBZLSZv2tyk6cQeiNRo4KeGtMVMHWo2nc1v5Ghx930OQc
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
	gB6bENnlrdsaH2JrZ83VJemnLQRY3cuX6LfKbRtWZkwRu5WL1Kjy8gxiRXEoPN0ekufo72GFS8hrS7lQ82pYWSf76QSCv1OJ/Ay6SzOHUMVn55kWGO7zDRSdemG8ept3zrH26O1UapKMmjP+9UPnDnIcyJ+fvkq+90mKUyELxM3zBZhZ6VOMRslXPVTkxYbCMZboiFHjHUpLM15nHXizMW+Z23JAHI+xGsb8ulNlVuWzWDai6wUj1kXCTLOdBC3YHYz+C733KScLM7NZxjPpDWe6pcz/ZoIi9R2a6WCRTTIQaijm3IImdIEwbe+tZc1E+xgFjHN+UGx1fJ4MkusquSOfZ7tLF9JeIOgkMg78LJkA2ev+LkSDdIYMH5CDCWw+wA4jIH4Q4DQxgCRNcm0x/AvvGiruLeQv+Lb0sLY7iy3RcLJwFkSTiVQStUrNzAOhJ6eg4TR9n6O7jo5UXxhBrANebv0qv5SVrriRh6LUIj2r+pogs7BQ1f4B3oUrfxDwMA7hPL7MT9k6D17lgxVUhGXvBZMQKS9LflJ1UhKXX3YlaSGw00a/+UcJouM2nb75RiNgEstsR10p67V3QAFUC4iWlbCC6FPUQJOpjLGX57dN0cMLQ7z5w+U56I1APMqBZ0aMziiXmtv33abM/LiLK3PJpyVQ3gMFvzP3ttbuwL2djRQPykJskW/Zc0n7Obh45KHBsgdFcyINYpZPgnUd+QDg8lAYZUB/VEZTmsRsoCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUJ3czdaMGQrNVNLOFVoZ3lReTVIYy8yMHRlUEpoUGNaUC9SMVRZeDllWEF0?=
 =?utf-8?B?ZHVIa3VuM1dBQSt2WWFXQTQ2UGlPRlNNZmxMQ1R2anNzTmQyckJadUo5bjl1?=
 =?utf-8?B?andBcitqV2pnblNnZFN1cERLYVJVcDJobmV0MXZzQlNJSTgyTGVadnY1M0FZ?=
 =?utf-8?B?RHJDcjhnMGJwUzVwcXBBOGZ6UUVEaXRkbjl4MjBLVDdyUVplbCtESEN4bTNi?=
 =?utf-8?B?Tlk5K2QxbHQ1OEpxcE1QRk1TeFh3TEtkRzc2ODlZNlZWZlBnWlNYNmZLRTVB?=
 =?utf-8?B?dUV5RkNoZ0IxdXA2Rm1JVURHc3RyS3NZWU9SNFlpek5zd0ZhbWNjMEJkcHJT?=
 =?utf-8?B?YUxOaEZjdXYvQW5WUEJ4cjVMVEoyWHdxc3NRdDdMMlA3V0xGOFBmV2xGeld3?=
 =?utf-8?B?VFhGQncvbGhnQ01aK2JjcVNIaENXeHdseHRZUDJzd2lnN1p5ODdmcDIyM29P?=
 =?utf-8?B?UTJVeDU5ZXVpamkxNXZCZmVtSkFCdmZRRTFCa2N5VjFQTzBWVWJuczVQV2RN?=
 =?utf-8?B?U3JTM1F3T0hmeGx3UUxlUmJHREczRzJtc3lCL3dCVXl4YytFQWJkQXdBbHJN?=
 =?utf-8?B?YnhNZzluUmtqK1cxMzFWZHdZOXVGQnF0RkdEajZ3U01LNkxCNFB4QWtCZTVH?=
 =?utf-8?B?cm1uSUoweHpFU0RqSTJkY29HVnVqbjhBQnVYa3gwQmdHTHhidS90dDB4L1E4?=
 =?utf-8?B?NURZMzZHWVB6Z3hnZDJHTnpaeVpFWjI0UWlsSEZqU2dUNGVHdS8vTzRKU241?=
 =?utf-8?B?ZHRVdWdOQjZqRzVqVkpJNEwvcUxNcGJSNTZ5L3FUV2IwTHVhVUlScGZsMGEx?=
 =?utf-8?B?aExzdlVzQm5CYTVKQ2lVSlQzRm8yeVdzNFJOSTBYMW5ONDNpU0l3ZDlFSUlU?=
 =?utf-8?B?V3RKV1loWllhSGMzSnhpRE1KcHQrMExXa0ZKeXNNbGUyTkFxcmVUOGdNT0Y0?=
 =?utf-8?B?NkVKRW9BQXFYcGEyQlpFVlV3bk95MXdRMXNyZmtlSWxDWGU1UXFIdGVydkNO?=
 =?utf-8?B?aTZUbTIyWFRwZDVvckQvcmd1RlN0M2tFaldGSmE5MnR6WHU5VVlpNC9xa2xh?=
 =?utf-8?B?ZlhHSVZhZWRsdmwvV0kraFdsYUFCbDZsdStYd2xyRkpLd25ZQ0xJVmVmTmZ0?=
 =?utf-8?B?aXVla1EyS1FOZXpuZEZLUmxGL1k3MWNoNzNtMjBoSGFJU01Gd2lxRFF3alNv?=
 =?utf-8?B?SCsxalpKM0RWdEU5SjMyLy9NTlRZN0JXVWkxOGxwT2VxTUk0QjRxNncwSml6?=
 =?utf-8?B?eGFyQ1REVWtFWXRpTXNjOXZUUDhJcHhKWFN2SVJtVGM3dElFM2xTNWl3bU9v?=
 =?utf-8?B?ZGQ1WlkvRmdoemp1dktyQ0hLSGtVSzZPSFRPcnNDY0M0QUk1bXRCK2IwZDhW?=
 =?utf-8?B?QzNYcmRWK2dieDk5dnVBY2lld1cwM0g1bVFpQWI3eU11bmEzM1V5bk0wZ3Ax?=
 =?utf-8?B?dTlnaGk1V3EvZjM5L0NzVWF3cGJVcW9WRzhObWJJcjdsUVNpaFRKcDN0OTV3?=
 =?utf-8?B?T1ZEeUZxUjFSMEQ3R3hpYnNZQm1Td1RkWXNBWjRQQkt2ZXNQdlZENTVMN2hB?=
 =?utf-8?B?WHZrV0hzOC9mS3ZnSjBtU04xRlBMZEhRN1BSTFE2WWpEZnM0RnQrQ1lONlRW?=
 =?utf-8?B?U2FHZ2FROEVlTVhpRloweGdQZGV4R3hXbDNvdHRRaVlzNUt6OFVPR2V5Y1NU?=
 =?utf-8?B?cEVHNjdZby9Ebkl6Q0FYUHpYV1ZiR05iOTFvU045Nlh3R0RpKy9iYUZxbHp4?=
 =?utf-8?B?K3l5a2Ntdm1TR1Fzb2pDRjc4bFlwUmxSMjRSUGVRa0xONGZXakkyOUFoUUFr?=
 =?utf-8?B?a1d6MThDTUhzUjFRbnk5TmdJMlMzWXRyeGltbUF4c0d2cmRiWjZGNVNWazZv?=
 =?utf-8?B?bnpnLzdYblRxSmswYlNzMXhqNnVLN3Zpc0l5Sjhra21MWEpkWmVMcVM1SU1v?=
 =?utf-8?B?S2lERlNyRjVDNzZUbVBWR2c2MSt2cGpjN0RsM0h5d3d6ZmxVQXFyUXdZSFFo?=
 =?utf-8?B?SjQ0ZDZxRXBpT1NGMzB0aVVmNWF4NkkxRmtDU2tqMnhERlF0QmgrT1hXNFBq?=
 =?utf-8?B?WTg3cHNYZElnaXl0SlBHaUZUZ0dHTzlwL09kOVRTNTVZRWtRbEpiN0R3Yi91?=
 =?utf-8?Q?AkPQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f937455f-d1f3-4093-05bf-08dc53220354
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:34:33.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLS89qlMGFhVBjGXigtv15AJ7oaxm9xFEkFvUXCAn12ffiydEt9HqqwwLGMdU8iRMw6Gs5SJixQwbK6aQbM94Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8926

Instead of using the switch case statement to assert/dassert the core reset
handled by this driver itself, let's introduce a new callback core_reset()
and define it for platforms that require it. This simplifies the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-imx.c | 131 ++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 63 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
index 77dae5c3f7057..af0f960f28757 100644
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
@@ -1447,6 +1448,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6q_pcie_core_reset,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1462,6 +1464,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
 		.set_ref_clk = imx6sx_pcie_set_ref_clk,
+		.core_reset = imx6sx_pcie_core_reset,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1478,6 +1481,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6qp_pcie_core_reset,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1491,6 +1495,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
 		.set_ref_clk = imx7d_pcie_set_ref_clk,
+		.core_reset = imx7d_pcie_core_reset,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,

-- 
2.34.1


