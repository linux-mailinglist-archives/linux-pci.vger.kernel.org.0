Return-Path: <linux-pci+bounces-15677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C79B75DC
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9F52859E5
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC1D153BF0;
	Thu, 31 Oct 2024 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gPTM4lE3"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAF16A92E;
	Thu, 31 Oct 2024 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361442; cv=fail; b=Jj/bKxFPsOYdWbSEBJtrBDEQsH3aDJJ0CuJxmJyojRQUTsMmHcv4GepVL9NUpaZEY7xYGbU9m5R5zQyA3klvbXX/fXtMm6NZ2OLhalMf0upSkJPTWR/7XLH47F5jhsVHaCE3C94/hbUkW6h5o7WTsz7V0k/X3I4SG9t0sqIRPnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361442; c=relaxed/simple;
	bh=Lywi4pVRf6RPgUcGteQFVbPR3c+UAZ6EQsPmZyaXHBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aSuxJ9fUfwLtihRaD8+fQMcDe04jPbTdkSp7SN1i4Vk+//V8BsfyIAPKTZrXa3ewb+tY5hDknnoC0BxT+0pVDI8xeKUiuGgFTtMwKDVu9IqQmShHOjLFtfQL4KLQc0Js4VO290ISs6UBWdJyBqQecV9Vm99j3USFlXm698cMa/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gPTM4lE3; arc=fail smtp.client-ip=40.107.249.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNr9qi1Pkfz7uJpM1bS71dqcUjkJNUJmssEJ0Po/7/BFRdhc1l2uo+tp/6IXMpPAVjAEeTGQqlUXzPg6yjMw4yg0j5+yTfbfFmovOSQMiNZEh5KlJppXW6QXs4RfOw7wwUArBUxOCUWg2rs4h0BmEj5yaLzCfNASu+wjyStXWcvH6XjXoUNrD+C+7YU2BQeuGyX7cEXsF3TyMy8pN8n1F8YDbYYfTD1IbN09iRLfG5vukzfBBqSmJAcX+/NzIHFhfE4DuMU3dMefw9tprCa6EwZBTHjgqoom11EFZc+Fc0mKemUfBjzhQDV7DZG3Vc+XB7ptQ/TDgQBBPT3SVgxWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/foMJLXbrz0qbnxNQ57gS/EpLf9dk983dskH5fpV0w=;
 b=hYk3BCpz/QycFgaXKbWe4a+XDTVxeagaS+RWIXHECN0gkTRwa+xq+ejpAH/an5e8Duti/Q04LeKGLQ6yyplvtQL4ghvG9RSJNcrDS2huIsI/F7bYKWpfD1tOjHOoI4TWdmnXLFSR9ouYazRNsI7WVIwjPaIjgolRpl22nWdm79lcjEOTNxAn08eKAPiFcM745tv8OON1fbWcLV49iNJGAoWawQA7gkHyv2EM50LCpg3c1ZLETuLJAIIwdKarfz0zSHzUxMRjkVLkqEYVx3yPbWlVpSp5f4y3sC81X0qLJIQhXlIPja4+ZIL6oyZ13JoNeqTGoFyDS2meWWHK+02PCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/foMJLXbrz0qbnxNQ57gS/EpLf9dk983dskH5fpV0w=;
 b=gPTM4lE33rv7qriY0jiI/4w1BKgXtV8UdiBFPghTJ63U8utzNd5lEVnSTSSrpgqUMfEG9Wn3AfNFzEEAZ2xISAdxwazBEcZM8OorFXiUevbpozvmlJ3SH5Rq2otBqkh4IZXPcEInI6lDWZZ2Gi90CDfUriDyaS0A1tbBbsNGDJWpjTjl8kV0QWgtWOfvUC1CmwS+ilyLDR1NDK4AldnIoj9Z+6I2X4nx8EcV7bVhGa3vg1KeE/pbPYJWlodhnsTV3cCI25mdpZL2s3JtTWY2vkc/HvJiJm31UpPLtvvIrvGPEUZgFxoXulKHywutA7z+VN6iqJIkvrNTxXTvL2tYnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:57:17 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:57:17 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 04/10] PCI: imx6: Correct controller_id generation logic for i.MX7D
Date: Thu, 31 Oct 2024 16:06:49 +0800
Message-Id: <20241031080655.3879139-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
References: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cfbcf3-d6ec-41b8-f257-08dcf981a3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d4CMnpC6izbMfSo3TsK15okcFcMoq1KOpf2z/zZMdOWPQGoUaQ+JWiTgF3EU?=
 =?us-ascii?Q?1sNfclBR5Xn2I/QDifT5ksJauIXYs9Y0xdlGmebslNI8Bv7x3498FwsZ7QPh?=
 =?us-ascii?Q?3P9KC9xHVTajIk8C8EVtfGBNRCDF0c7ElVroDRAewg0sRZrpWiPvtE72cpK7?=
 =?us-ascii?Q?bcLcbVCzlicqtTSFSl6UMYTjIE37IGDnLWXBpLGNAesQaaXjRENehtgFEpp5?=
 =?us-ascii?Q?XpLZfyIocsO/XXuBOi2pImUq23uc2hErqiyZu0MQOKTSh+5KXEFoYCRc4RL7?=
 =?us-ascii?Q?dV5BNzXGIVJaQ6zQcg87TyqpY13eJseKaciU4ea7V5hX0lJ/NAFnxrtdrfCD?=
 =?us-ascii?Q?ynf7k0u2YVuBrrIRdT3gnwjXivivwhH1VrJxq383570C11LnxiSbutlRdT5T?=
 =?us-ascii?Q?LlxAtSidofsVhByw+ubQg3cwNTgoE6gAysCGJKpI2IDXEdtySoA1+Faa8daA?=
 =?us-ascii?Q?+1ilHDN+mlPciSyRNKLxYBSOjxwOxRtnWqzjYRWoPlhdc3uNey1YUOqLQKqW?=
 =?us-ascii?Q?1UCu8enTuCcYEoHZ0r5JhyUtrxKlqVc1U8yL70TqsC2kadXDhFBlfpCMvmtM?=
 =?us-ascii?Q?/+pPS5DSn1GguIRnJamffTmvK1b++F8zxxDjd683othdM5r/7CtXQtLrit5c?=
 =?us-ascii?Q?JHZNvygUWYM0lBAyjFIx6idtY26CEUB0S/iDMQ7h2Zka0WsmoTSDkCXfWmWx?=
 =?us-ascii?Q?Qix7yR+bK95iTIY9zyU2JLEzUsQ6I9Zz3iwJVMNtdSH9uvukxhGiISJPy7ek?=
 =?us-ascii?Q?zyg3kERCPGu97IPia/3P17HZSD8yeOjqVsZkVhOz0FItj/Ii+Q3OaF8lhYGx?=
 =?us-ascii?Q?6fN9318JT6xE5Ogk4LfCNoLmEFawqEK9rvXSfEcFQHx1LYh8DirVzDgHADjm?=
 =?us-ascii?Q?SGHuQrXETWffyWtlsrpPwbEAQpmYcSdSXaF90cdHwSfORl9GwxW2smk9RslZ?=
 =?us-ascii?Q?nUEiJP0ouQ53XvfZMwkxH4GxwvetcWlY0tQDnpC8hMsBMkrSxlQhnmoCiz/r?=
 =?us-ascii?Q?/AIbDomHjkmx0XwqtnhIMTjtIC6oNUs2mrDIhqOmN5b6dR/OSkf88jF6GKoL?=
 =?us-ascii?Q?tONg+OOUkYVCUuQEawiodymazIbZKIW2bndWSBVJ12i6fjdTphHvu9D4myi1?=
 =?us-ascii?Q?MAIrIrZqXdH1B4xb5hIvI5hMQpJtif36pVORro+38u7ahZJb310lf1qOGqYK?=
 =?us-ascii?Q?FeD+9bvCrSj5XDnvuEOwYlmTL5r+pztcHf/zTyNe3YqCGe0Fs+dVzoBx8dPK?=
 =?us-ascii?Q?qqLD2OQmqQ8EiUHd+njU7tqji9HEMZ/0LW2U6DIeTvfYErnBR/AjZvxwMeA2?=
 =?us-ascii?Q?84BqViuZ3TBaLWbHplBJkp1XK/FO/DMvcC8Xi/WFlj/8hK6M6Rfdqh2YE6ne?=
 =?us-ascii?Q?VSEEEdFUPF0x13nVfoB+2KGQRgAj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mSiEmeNe2fDiwLyXILcwqsBWwSV8/8R9sbekQeMcUZCw5u22nB4ibW6o40jn?=
 =?us-ascii?Q?KL3ci4sk2RlWiKivtcPZZwe63HQEzot8XoSfk3t2+Zr3PaKGYD76VlMTWlEu?=
 =?us-ascii?Q?MeoxG0Fmqiwccjv7MTkg6P7lMuFL5IKHjeK6fGc6aVUGe7DqbH1E2yldJk/t?=
 =?us-ascii?Q?mCxjW3NQOWZBR6eiLabw0peSS2M3wIUzI9IbIGfmhcKYnnDpy7gDYzqQq0kA?=
 =?us-ascii?Q?fhQ+mK5Ov+J4BlDrLcMf/SgsTGUTEdeOJAOmz2+8oyNlAGHj31fa/RsrmD+9?=
 =?us-ascii?Q?dcFT6aBcbQa3ng7W14aqQkz0rYw9h4rPZaA+RQOCV3hTCRcNfBIoZ/cC/Ua3?=
 =?us-ascii?Q?j4Kuo+UUfvAshTzcZvvU/VyLLdCIMNT/U2lnS6z+y8SwgvJquexfX5GbZAtp?=
 =?us-ascii?Q?VJq9gmkwLT06g5ZFyHitszJtfSuMhHC0QwxUYmUcR7yPMk5Np1RkH6+oaREb?=
 =?us-ascii?Q?pfiXgNq16AhnqS6mORyNDxX/mOX0eymrvq/YmefWNauQDJNwSOmR5x7eud8f?=
 =?us-ascii?Q?ank2c4wZuvYT6v3dHyWgH25EcZ/qQ/oojp1lyfD+WqAIVpIQVpJcfoX99gfT?=
 =?us-ascii?Q?lPOJH+ox0UbrtPViGBTow6HVViCTp7xDjoW7IXIGVEp7UOINGiciCtsJboM+?=
 =?us-ascii?Q?/3e28VWBL87/wH8/6DwhIuEkSnb4UUXv3Y7COxGwIY/z7luq3ZdFYJdD35Gz?=
 =?us-ascii?Q?76ZWbe7IzHPfRCoJCM96Wze/JxwQtxeXMBeYAORB6ZuCguSj7g4El/EHdXRd?=
 =?us-ascii?Q?3VZ+/nkGmNAOqSGlnQMBpAy3llXFOmt4berpOitf/Tt3T7JxqMkBIbyqr4m5?=
 =?us-ascii?Q?UBT22yaZt2YzUa/h2WQjZpf/nN0uKrNalK/7LzG7T46mdPx4G2eP/mTynIBm?=
 =?us-ascii?Q?L2MvuOmA84n473HoeVgmnfhJ54EeXVYGhJsqw8EXzXyR5w29cOzD5VSdSwde?=
 =?us-ascii?Q?aMqUy4X6IymBNTVCQvow50yA10TeseWh7pwVcJ9s97QTCv97aZeY5yK5p74x?=
 =?us-ascii?Q?Qj3YAT5swc+PUPFv8WN+Sd3pdBDZjMniniHMz/w/vYRVh+VJtirFgm3mR1Pp?=
 =?us-ascii?Q?cDBQEwF3iEO3HzggEYd9iJ8gpavmmhdETfoS6XNBiL8ftaXA0IiA/tpvQPo6?=
 =?us-ascii?Q?iupK+v2ubzD7OeNTEK0oZCFSIoo1nSDHY7OdWuije2pNKanaf11MRPXZdxCU?=
 =?us-ascii?Q?Dgd+bsU0qmOGF0Q2dUVqShnONg8sDfJS/rgvPAC4DzXai00ELr8DalzmZUdf?=
 =?us-ascii?Q?+uZtFJsOA+bnLE+Y5jDMbPvFEUCr6vtJFbfNFO1IBDvUSVHAQyhGXEeXxcRS?=
 =?us-ascii?Q?/DoFUTDdfGyUe0gIFXbiD20gFS/Aimsn6UsiqKr0/Bu1rn1EKEokvTP38Rmv?=
 =?us-ascii?Q?m7/xn3BbRWdFJ6E3QnWdmnI6KuBWKvEL++qrRKQX7d5WZb/+OAMwQu3BCQdr?=
 =?us-ascii?Q?jlKjWD8i5kMzCcgSIo9GQnih/5uN9StTMZ3ZfEQtJ3FFcLygv95/6DpO9OwZ?=
 =?us-ascii?Q?ygqe/w78eA/Z+sey7gViOdAhij8O/Zvd+BTGmYvQxoIGd8Y2mZB4qb8WAty7?=
 =?us-ascii?Q?q8QW32RA21cmrCL5Xn2rRDXuCvT8wDPzHFcbIn+8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cfbcf3-d6ec-41b8-f257-08dcf981a3d3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:57:17.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XCQMS2KmhpDXyEt6+5jhee3PuB6/NReMTmvSLjQkHTEzYX6qXa21jIRXeoHeIcgmXqBCRPMSd0q/kDMBFyBvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139

i.MX7D only has one PCIe controller, so controller_id should always be 0.
The previous code is incorrect although yielding the correct result. Fix by
removing IMX7D from the switch case branch.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d21f7d2e79dc..7479d3253f20 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1344,7 +1344,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx_pcie->controller_id = 1;
 		break;
-- 
2.37.1


