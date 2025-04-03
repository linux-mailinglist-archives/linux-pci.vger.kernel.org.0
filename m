Return-Path: <linux-pci+bounces-25209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F1A79B76
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F2A7A4CE0
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DEA19E833;
	Thu,  3 Apr 2025 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Spgravn7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE41A2387;
	Thu,  3 Apr 2025 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658887; cv=fail; b=WQckl/eXcRAzL+QRPwaPVLEELqIP72n0HcSBSqOZwJkwA6Uqcw2J1zkOdKqGbkIZmtWDptXcwliKTrobX7il+onzjerTeRI69XJayqzrh1LIv4QGazE/Cp2VDWRdCQrzMVX1Yb6vmx8BZPmfgfvrGGH4gcz+xEBA4bv8Vzkfo9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658887; c=relaxed/simple;
	bh=ZwqMs2ULNa5A7dGbeGI4LXIdeH88zM/NlP+6o76ZF5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tcwpqQMZY3y3qPHHO+d2ce9indpq4omOtZ8vVq4SsUOelNz7EDr3+ARZhr3jzMw/wg8Pc+AZ+bBUb68qeJTV0WhQnFfwCMDXzHce4cPuQBxlQ5BOEAjXIMHYowbgByMEagX0itkF0jRCioS7FJ4jCbHVnlHMEAOsdYLrVElLuEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Spgravn7; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEgUPShY3xuiptWECIe7n7aflMlSubRZlnLCFMmyNoewVQsI8fJ9PVTiM99+NqAnWvHnJsFKw95mU2cs1kopY4RUKI9nGGQAy5l7IBO0871rBiwV82ubbWB8ZPbQNlVpkm+vPcBnXkoE1s7H5q5ugKWWnX+WhP07t5wQU0UlKaARtX978RVwCCD2XSa+vCrEZicGj0DceHjHUKO9/Ksla4MP7HLLkjlsdKpRs+RJfUjESeh/JF1CvUTH+DMtTYSESStesc+bn9hAFssslqn6mekvDnkWKhXdrbrZn0nf8azmY4518uYtIVFS9EL8WgzRWCfLzvEFT9/KsINw+jErnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH1iXG1jWeeAOPBLEpHyDr6pN3mmE7ziwtgAvyjl+Vw=;
 b=p/IA7ENjeeR3UJhcAfGYcjaH+qMN1rDi48IPoMqI+HwvApX0cdJkUt8zoRHWmcW+U0E0nnVKqcxgiynwYHVZvrVqaWQ4tzdF2rJFOwT2y/l+6w8GNaKKpKuMYH9UI0nICzxc4rsqUkOe0JW3x8yORJ37GSdrf7CNx+I6HZWmlIKyWzgaUo9v9TC8tGTAWgqJdZ1uMPQ25cRBTZF3t3kuRsRKnp94OUi5tjS7jnFhxe9Iq0BE+sp8x5m68z/ubrvjZgWbc7/EbnkeErL96pAZUZ02n/m28olKrF1Cw/FaEw4vvxbqy6/oXthrmnKEUhWR+mOrClvHw/bqefzfAd1WmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH1iXG1jWeeAOPBLEpHyDr6pN3mmE7ziwtgAvyjl+Vw=;
 b=Spgravn71zMhC0VdIExZtIgBN8Fd3RUAMjE+TRyhl/KWMLXfDmB6yNJkvdkNHdIF5dQ+IG9J5aSoDIi8aIA7kApMk1KOPt+Q/BzrVMDCC2Uvc48HIKvAvGVPjPi+lPQcY4KXWN02I/7OcTVnH0/SpGFjzetL8TkjPrHJ9+ENJGVEpF/kegS6+nlr7dGKnROVFTwEtmzhkhPQm7XZR/S49Z6+gYQclzXikQVceZ7GGvTP0BymdisZUzF5JtbzV4qJTNe6XcvBCJIDe76n8+y76ZAfLgtWa/9QvyF/bGRhtp91abzISZsqPhgYEcPusET4c1cAm+qE/NrVKsxXProtuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 3 Apr
 2025 05:41:22 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 05:41:22 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
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
Subject: [PATCH v4 5/7] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s Receiver Impedance ECN
Date: Thu,  3 Apr 2025 13:39:35 +0800
Message-Id: <20250403053937.765849-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250403053937.765849-1-hongxing.zhu@nxp.com>
References: <20250403053937.765849-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 8200c5c0-2eb1-4a09-2637-08dd72722a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tdP8KDxzWlgH1yAx8tr1ojjz97gwMcmG4domhzAiTZ6mVkNK+HjZC+T8HU7T?=
 =?us-ascii?Q?XUCjvDtvsGaWmtxBzcmPLoxxx5gHrd6x6dGSfPQg4OJ6CmMX3wu/y4EjNgGd?=
 =?us-ascii?Q?X9CDUFX4EWgk+O8VWGPAedKLNtjraTBSLm5WOP+ajdKnMcbJNAKwzZJ3dSUv?=
 =?us-ascii?Q?qpibEQVYLli4d/VUKGBpUJ+H9tjCU9y5Th9CA7vhvqRHXjsCsmG+yO0esvvN?=
 =?us-ascii?Q?F4LayxTMdgQbgI9exJjIipnYLbnNrGP8GVIrmUsrgxGaJ7qHAVkyLINcJsWI?=
 =?us-ascii?Q?u+PZauLeKkFlss+q1k12eNDzOg9nqd1R65CsEMKLnQ0zFr1GJkSEgE17H8/1?=
 =?us-ascii?Q?gxYGcsYYaOVRVP40XTeCz66sB+kRpGuvtOAXyzbdIUpko4kkxx+SZXozt0yx?=
 =?us-ascii?Q?ZpRVkBSKQhcrfY0Bipi3JdYVxmf8AC0QL85GGv+NayfGDb2OMVCepCwMkwg/?=
 =?us-ascii?Q?Y/cwWuvrt4iqV8ILLt4F/5ImZ2T43EO1MHfsyatNXXTbXEdjtwVjzypG2RXS?=
 =?us-ascii?Q?wrgno1pLlpxn7coxMNAingvA8AAslARK80kQsOdRNbUO1cqjVvilyRmoF6q3?=
 =?us-ascii?Q?whRo00BAjEFiFWgQuKOU+yYLSUmrEnAfuiHrYBKqrWXcQoP1HPm9g47/6Swt?=
 =?us-ascii?Q?oKUsNhGDxbC4SA+v9riI9RwmX+7DHF3CzZZgGFchQoO5B1A/7vgm5UK/1lGc?=
 =?us-ascii?Q?teNN+bKpKcizekDpPytQlzpEHCdW09r+q0vdmqO+nMXbP6Ez/feldUg2jYyw?=
 =?us-ascii?Q?yp0ZHDYVLTWfzc39sdDw03/akm7xDgZGZuhd59sszif38J+T2VrJ9gkMz2pf?=
 =?us-ascii?Q?z6CvBbyqq4S53KAC5GEg7G8Rqq1WXmn+HnejYzQ31ssfPvxTfzUU81lWTuPQ?=
 =?us-ascii?Q?6E9HrD2nqQcYv9tFFtiIo59SFTf+G2qLn0QpuQIpEjSscd/wEEwBl+uCeKV0?=
 =?us-ascii?Q?vu6DGk/HlGq744G7P4BhVrfTxJLH67dMJPqqJ/G364YkzTjSfXl6A9J+n8PW?=
 =?us-ascii?Q?A3CfIDK7EUc4jOWtxA64pKCnkdz0Mp248qr940jOri51BBPmsTMnuYsPmcRI?=
 =?us-ascii?Q?Gp82fSR8ehw24aABKEaesBqAwOfwEs1ZT4R2Ig1032ynI4P4dwSqE8qY1rlj?=
 =?us-ascii?Q?1BVZ/2H7MIDcuhyd7LgHd2wtA0EtFS2JqQMiPtzexXTiIs/5LH/4aR2iMH7b?=
 =?us-ascii?Q?gJknxh6FSvx5U+pICNPA6EjyxgxVIyl8HzMxPtuQ22wIrPKPyoJwmkNM+utT?=
 =?us-ascii?Q?/dtITFC+BotDz2nvYGHXkaQKfOfHUY/Hu7xOgyNuLT+wT7XAdTJMEykwhuh+?=
 =?us-ascii?Q?Qzg/Ef/arLVPvCRveg6FZyiuvCadCP3Z5CfZi4z4A2XdC1Sa1T+f7j5avJ0/?=
 =?us-ascii?Q?DFlG1RlSoIaeAGkDm1EK1zonBZOeVBCvRK0EeLpHVrtTEI+1mOHHKeDn1OaH?=
 =?us-ascii?Q?4wGYW2rwVkEwnxQ5EzkW/riA7lgt24jQuDWOWRgaIyUu7k1gkNP7+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqUzDET/BSYc212aP3YYjyDbElLr+CcgyAYXFiWWCAODdXJga/FWvmuale/T?=
 =?us-ascii?Q?3WOGcxEMv3p6LRH9ExAkLhUPFvmD8zPFvhI5CbWzspBuU8UFmZMAPrVCsBWw?=
 =?us-ascii?Q?aTf3vyp5g89oEZjgV6gfJEDuQtLWBUSHgnMS7KdZjGIhL5AygiR83Z3zLFdg?=
 =?us-ascii?Q?KbeuBeCWwmYg/W6oT49kv4TSNt+HbQKLLU2ebf14ongpb9ksUSEm8BJufo3+?=
 =?us-ascii?Q?4GYnYjMBqraQRAL8+toKEGCBTF/jaDfWCoT6tLxfrZ8vZCq12nTtVLd/wngv?=
 =?us-ascii?Q?hnaCg8sjkZDlkjfW1O4PR0KYc5QVEINm3WUbn84WPZtZyQbKo0X43/nf3xrt?=
 =?us-ascii?Q?/aS85k4TQx7XJ93ivxMpxcxSd5omUdKGSQkgFrA9uXsfzIJ+3OigzGSgnTyN?=
 =?us-ascii?Q?VddyE+dDFaSHj0jwOajiYJLpcxWhuBmucMCfFzpzYRpTXknqFPJs4mgTx+z0?=
 =?us-ascii?Q?tvMSiVEPvLvsN4s93BdJf4Ga2hhcebDey7zdgwKLkPZyr9fXfrvR4rUMsgc8?=
 =?us-ascii?Q?EisQEYnj3DOqE61ZbCGCUz21Lpb62flTANZL243J6kxs1ozwWW8Vu9pBUCiO?=
 =?us-ascii?Q?6DXJuC7FTNx200fpk/z4wFWxlvkUS7WZKC5YJpac2TOji8m8IAJNNbrpt1li?=
 =?us-ascii?Q?Etbqfa3BTU46tFLDqLLxV+AWk6bQ0bAnXX8f8IyuUcqt9A0r2mPljuTFlNMi?=
 =?us-ascii?Q?5Pd6hBr+StCFlBUczSRU6SlnjTumS4t9yfsqSMexUuTmkLmMPiR9MPoty1rf?=
 =?us-ascii?Q?H5iMR9M+QbWnWGoo+ysEbXVEQu4HzBCOUdVW2yCVt6WtTzsjINc4wIOmkj7o?=
 =?us-ascii?Q?29XOl+U+k0IBQYTMCu5VbqnklukLHUftU2GS+AgO/dF+o0nbIBFTR+0qa5qm?=
 =?us-ascii?Q?0eczrmp7W5/55OqlE3rcnP7pKEK2NTVlahj8va4LFgrEr9nqoDCqjlNVRm6I?=
 =?us-ascii?Q?JjA5Xcxt5QOM184tVakEGKT9gg6YicqXqvc80/z3QUdMpe8YrX9otNPH7sPb?=
 =?us-ascii?Q?LhUe76bpu6DPya4FysMripBx8RwM55u8psEi1GLzy+zbz4+gfY1gEyJRKYeA?=
 =?us-ascii?Q?5wCtAMsKiAuNwsjr/xt/5ZIEIX11FV729IbIxmEQE6yxTFAyg1gqWmEEufgx?=
 =?us-ascii?Q?KJwWeHsiC2gqWHbCVO2izVG5xStEEp3ofEBeBDr5ajdmjmftGAL2tTJtjHUW?=
 =?us-ascii?Q?JsQNNNLwDudWxCH/qv5LbOD1K6C2TZ89MDPEwDOlZZR3d1wt5/wJoo2w916W?=
 =?us-ascii?Q?0/DM2kHUEaEiJKIIEoIg1S+M4qhuO4TRfjoi9mrviS6OHpxSrrweSsJ229oh?=
 =?us-ascii?Q?Yl9VeJj2EAKjK0AQE6ctmo15SIUGppDXohCo1G2q4noDQV8Q+GzjShSlnkY3?=
 =?us-ascii?Q?dlTii7vWPM/t0Dp23PfgD6tXF8tUj7lrpdc3qIp8y0xXrOFprAX10tg8Plbv?=
 =?us-ascii?Q?Ovyh6FW4HGCLbIynSZru8at/ZpZH5qREamkfwG8lwwKeg6/Thq9m71hB7fsn?=
 =?us-ascii?Q?gcp2ASRS+Q7x5kO/9xTo7mPttTN2EmC7Q7jp+dKLIxKBNCXeLs/MN2XwTcH/?=
 =?us-ascii?Q?8u4kc0GGiZI250C2zsvJAwMxmMz7nnnAEGek+HmA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8200c5c0-2eb1-4a09-2637-08dd72722a6f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 05:41:22.2391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ4Ew88wM+GFekD0BOgBxBBVb3ECvlpWU9xidZJ+puTxrbhce5uobdiUJTH6AjDAS6pBaLvwkoJ71xEBQSycGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145

ERR051586: Compliance with 8GT/s Receiver Impedance ECN.

The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is 1 which
makes receiver non-compliant with the ZRX-DC parameter for 2.5 GT/s when
operating at 8 GT/s or higher. It causes unnecessary timeout in L1.

Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index abaf6b13a8d5..2232436709f5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -110,6 +110,7 @@ enum imx_pcie_variants {
  */
 #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
 #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
+#define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1256,6 +1257,32 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	u32 val;
+
+	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
+		/*
+		 * ERR051586: Compliance with 8GT/s Receiver Impedance ECN
+		 *
+		 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
+		 * is 1 which makes receiver non-compliant with the ZRX-DC
+		 * parameter for 2.5 GT/s when operating at 8 GT/s or higher.
+		 * It causes unnecessary timeout in L1.
+		 *
+		 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
+		 * to 0.
+		 */
+		dw_pcie_dbi_ro_wr_en(pci);
+		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+}
+
 static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
 {
 	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
@@ -1297,6 +1324,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
+	.post_init = imx_pcie_host_post_init,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1396,6 +1424,7 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	struct device *dev = pci->dev;
 
 	imx_pcie_host_init(pp);
+	imx_pcie_host_post_init(pp);
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
@@ -1805,6 +1834,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
 			 IMX_PCIE_FLAG_HAS_LUT |
+			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
@@ -1858,6 +1888,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
 			 IMX_PCIE_FLAG_SUPPORT_64BIT,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
-- 
2.37.1


