Return-Path: <linux-pci+bounces-25207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B896AA79B72
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADBC174B96
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900B19F41C;
	Thu,  3 Apr 2025 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AlIXtT5+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC791A317A;
	Thu,  3 Apr 2025 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658876; cv=fail; b=WhHpvFV8tC2phrhDFKKAZRqQXjrI3HSQ6UXVp2tNtfx1bGV9vEDyLsQEMfv9jb46LXLO2ZAZA4LEOFXxlLKArkSg9sMwccJJc31UcEllvD51c+CUdMmZC+rIb8yUvR0mh5nb/c7kUAYdPGIBAM84xwYOxY7wyR8SkiPF+vwr2YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658876; c=relaxed/simple;
	bh=w+AcPRPwIBjLexbDMkzhBDe6cbD4YVqGLrRY3TpzKIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cv8pEZIIGC6L41S/wOS4qaepA4Z5PfjEKZMaWp9QLgpVxIjsqLuznjMWBS8ZEn2NG/I3UP0qaWdKqjSzCCeHyAE/b+g8ORM5c2uaTXuADTsmoUAWvNJ6Im2qQjfCowDOwZJe2JdBK2oWx9CEyu4GRaQs82Fxjkqr4YCSK+8jMSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AlIXtT5+; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNOVnG0OaZB+rwMWVpa9LwWWag5AwFEUu2JT5AAKYr+Jc9Ra0cXEjcsOwSnP4JvjqZz90Uv/0KVGiPfJ8Hp5OblZCUJ3IWjPxfnSEk51fWLiFPuym31X19nQp6/URbHtGoPxRDx/Lf8+nAFcIMPnaWkNpB1AevISeLIhuJ3LLit56Z2J9XKo1qIcV3nwn7oiRMPurXnNoszon36yroVW/mmbfJPs6VWzgfJ3x779YxFFy2FpDlQNIfisqlBcoxEhdPCb5SHCrJ5DBukjMH9ybW781TvfRtP8UUkSAZxIGPa3KwUae6VuO3e8xNViJkizBpb25meTAC3RSQj8v0XA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6nX+n9gpN0mZpXpTF9xMJRjq0y150TqRpk/BYouJfY=;
 b=yDoIiRI4kfxYfYKRa0+qulGVDeuZ1SQn+DfkaUj2ccwOV2qkceDcttyDWLPDTmkUvaWNmHF7cvSsKBSxc4uG0lXUdAuo5Zv9Cmkp6vsdJp/JIQTgcDXo7vflI4ZYytWDMyCUqfiQdTr/wp4vLMiU4dwSgmUE/ousPq1MDIMJgVDXQNRPYrtd5y1lUtdLTTxscUlpAMTCrvrpsc6IGxeFFQl9eJtj7+EZgwEl8fDX7ClnDpr288BAMSYXGJmpsopbmtt86Renz6zmaghiC1QpZox6tvmKh8K8UATQMqu8HMdghKZWu+bYYBbEPf9GENJop0r/iZSKywM5RjhmeyXVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6nX+n9gpN0mZpXpTF9xMJRjq0y150TqRpk/BYouJfY=;
 b=AlIXtT5+nIM6QQLCiIyFnOXFByu8vrSx014hyuiTW0urwWqNfmTNwglt50HSVxl2Shx9Hkx1vN9/DD4hiRYu+uBqnQeO2J8qUDJgIxrltDCV7C+5TzcGmAU26W6MOgk+1hQgWB43g5wN88ERpMJHEXmdefuj/HXGG5HV1o681GakDAmBYZPDXt2siUhoejo0Bwq6E9vkRHN2qhwSTDGhPkbSDLClAz7uCHHMyjynQoW8N2rOV8j6fnKhfetk/Jhk9L5FA6RQKTyMGWWdsYFjJ+RZdW3OlU7YzBlHbxhUnUEmrftLOQxVejSaAEZyqoaTqFSkVEP4yykd/Lw6xj2+Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 3 Apr
 2025 05:41:11 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 05:41:11 +0000
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
Subject: [PATCH v4 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Date: Thu,  3 Apr 2025 13:39:33 +0800
Message-Id: <20250403053937.765849-4-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5425a5df-38e3-4bff-24a9-08dd72722408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r9w1u5TkYj+WwG7ftb1LF+IuhNiTjJQn6UVr9ahtOmNEjKmHEBL5n60gdFWI?=
 =?us-ascii?Q?tHSfCc3gmW8UZnDRrNV1Kqb28oDA213IjrgBcrAvgaBck8kuncVwN2lR2x1r?=
 =?us-ascii?Q?IXuLeLUcmO7NpZw8tbpmM1RlCfQkrIwZYwIQScbgm+lW9Aaj3hFM4+v5OQ1R?=
 =?us-ascii?Q?v8fgGMV0SPQhrbqjBg0/zeehAFOQglftYrhjIzcE5gHuxU2pBJd/rnF+gzu4?=
 =?us-ascii?Q?jZwxCnpVe3UY20048RZ1BBBhaPOd60L+hmXDwbNGn/+TbGoi50+lZY/YWwH2?=
 =?us-ascii?Q?HqOOm7YYMTtxK+V69IPcilBZ/T7k3xZP6ABRuXenh5zjvqZtBaGVgy8SbRx5?=
 =?us-ascii?Q?qZrjrqbuhk3c0kmnbJ6T7qKiloAZwU3XsNZ3WMy2LP47sSxTN0AfX+m3rqz3?=
 =?us-ascii?Q?AX4BhRekKe2kKpR/OZcSOe/bQ3WNXc/ygeEJgaIB2eq9uA1G9Ht/KLRSzDVi?=
 =?us-ascii?Q?TF42stOeTnneRkF9FN1Tq1x+MwSfnnopk3+/9phsfwFMd73zdR/lsRWm9BsQ?=
 =?us-ascii?Q?43/qSA30xFA1Et32trlIS2G+kUy0VzL60sh0+k3jmJ7ftzDMxtBKVsHzoRme?=
 =?us-ascii?Q?45B+U9/vt4m8dEKYe02snwYp6otgZp89mcg9ZcSQ25LlvjPszo2tpooPm2uA?=
 =?us-ascii?Q?IArIVe2LMTKQLM/UAGYHBfVDUnRPCygxQLQkVrCKzxiIcS3RldoOqpCPdqZg?=
 =?us-ascii?Q?eb9fJlytXIDjQbA+6PeYytxcIMoHrzgMuaPSjPNWZDbn1M1DAHanS2z8eQx8?=
 =?us-ascii?Q?dBnoJi/cNTaYBCeQ++2d6A6bEG95W14x6Xptfb63cBWq/wV+B4S8pS4VIQv9?=
 =?us-ascii?Q?XL88C8OCJ/PDD2wXMQJUaZbafWWd0grezdkS9WXdeKnxDxO5bycQA28Rc6C1?=
 =?us-ascii?Q?WUABmWvCRPdr14nxP9S6dh8FozZ7MHAhz39fG8ZmnE1uUbxNIrOVAviIzOLH?=
 =?us-ascii?Q?tILupRktVG5FXq5JoGaqJ5OElLukEN/LNcN+m0lze7g1dygyyHIV7Q4NNQaY?=
 =?us-ascii?Q?4Ygz2X3fOBPQqmjt4F2BEhi679eoG1lbtA/A9d1iE550dMtUQcTaqTZB8jWZ?=
 =?us-ascii?Q?WLDkU9kPsqNtsIANG9r1DSbJ2FJslC3wYG2bing69O8FhCgSYiLku7fZpZdT?=
 =?us-ascii?Q?N3Dsrg+54bNZUvaOAtfBE/ljdfCohQd4BWnYqtnk9HS5NJwQ+/fClypqIrRk?=
 =?us-ascii?Q?qxQ4gb6Rg2A5fGDuiTdxYsv+AQPrun1WD5O3Ui89jrukCH8tlfmPQGEA14xO?=
 =?us-ascii?Q?sLTC/VhLEMluuetmXRrczZSVzfv4sPAm6l6UkCzTx4lN3YhsHFx+ghmj+cxx?=
 =?us-ascii?Q?FvACglSZVtL4PfVk/yw0GEa32HSVZE8cl3HKj1bN7F1UTrTKu/I7+32NKRUv?=
 =?us-ascii?Q?uf06YOAkoiQtVflNe4qHszEM17umTxxeCuQXCZTNrbc3G6KIZ8vrpvfMjL6A?=
 =?us-ascii?Q?5Qr6xY8MH/+YxQ33oYYO42S+rmAGnSDfSqW5mRTA8Hp2QpX626yd0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lQ0nbcxvI8XHKP1UWSuwgw9rB7l55NaxuVR1DsM0BSzMovWGNcseX6sCd8EU?=
 =?us-ascii?Q?lkToGHU7+JSdpVmt7ARtxBNznpaR7i/lexIuafL3sSQcsqAnRSV8nmVvaypc?=
 =?us-ascii?Q?0xBD1CTr3BlL0EHk7gqDVX8pRxUi8z21kcPaKaK5YnmkpS1imG6xl6cbynYx?=
 =?us-ascii?Q?a+0yjBEw9ApM4A0qqkG6IYuqjQXLvKbeordrW3H6T3N3zVyCxHpY/BaCrMpX?=
 =?us-ascii?Q?965mEJnEp1QKxFdsmafsgdPL6r9rhtFxHoH3Xo4ducyyhjVh8tRK+Maze3FE?=
 =?us-ascii?Q?rmXVrDG6dCwc0Qknv1yP3QEuP0g33d7Q52vSMhxssXDaBnG3WcvV7OscFk6n?=
 =?us-ascii?Q?sp1lxHa5MNN41z4TltyXE7YiNefIlILYDE32TE9loA+U+3+RtNAOOTGSbRtc?=
 =?us-ascii?Q?VN2PstF+H4n9VnhVier2f7isQdNkxKutLx7JIIeZNKMWcahu9WKXAgjIuyZI?=
 =?us-ascii?Q?9vUb+xbvlAkdRayyec71UfmKOUZyqHKR1EdxpjF1Q16siWtB6pNwTtW32f3k?=
 =?us-ascii?Q?RIhabQMxgvnIM75DVdOEIFU1dEtUurGdLrbOf3HaUL0/Jbd53Mi5fs+pIFHz?=
 =?us-ascii?Q?nUl69a6LjPSD7z6P88/uVEvynssxSC4ObM0b2mNGLh2uAuLqrDsPpS4dTkYO?=
 =?us-ascii?Q?h3j6xu/lBPfvW02jRA8Ci1dL5F7rW9p6reyGpBj6W4xY3Lo7gtaBEMHIXE8f?=
 =?us-ascii?Q?HZdgmQ5/eMij8ZFOiwE1Wh4fRa60m5EoyLRxEfceW6QpH4L9EiUUV9p9c/24?=
 =?us-ascii?Q?w+lbV4P2fLP6Ig/LZVVrg5U/LFs91RfHAhvLAhL5hGH+6L8qQDggWI0/LZG1?=
 =?us-ascii?Q?mivfU+fARRdM0M/MCdp+AfqOf480nGSBbDp8odrrb8GUuR6upGrdYNWSOVkE?=
 =?us-ascii?Q?dq+1FI8fHOYF23VVmxFlic0GWVoXCxMkR5UPAyM8gepXsJtuGciH2+aSz6iu?=
 =?us-ascii?Q?j+KsSzo3FgjUnwk17LqEUxdScO1gYdxjBXM5b/mDnQl5sYlhID/N3Roj8HH9?=
 =?us-ascii?Q?tkzdY5oP59Pw/9qnr+vq9X3bCL0/dZE2+YZNPFXVJtVyjtKdDM97pAFGb1CY?=
 =?us-ascii?Q?phfKDeQf9/whqrYn8EobrzJ8IDcvv6SM1rGl2n2H73naP0Kzs655hzwXYo+i?=
 =?us-ascii?Q?4ZTEPcOlyCL3vWIHG0pSdEIcCeTGuCRtpH8MNW5mLYeaJscfAZo6KA1SNcrG?=
 =?us-ascii?Q?qwyb/DfmebmKbAa+B2O+SRzyIxoW2+lBs9M4JthuwLyWAA57cqmVoVzlCpSu?=
 =?us-ascii?Q?1CGnr93vjkAsWChLe7uKyFvSSUqjdYEn0d5bcFehcD1Kht5/5WFqtKRj5wl2?=
 =?us-ascii?Q?UtnJWyuvxTtn7VSH0el/u9hBroZbbj8kL+Gb+K6OK5B2cXgVxdoErkB+Z9lt?=
 =?us-ascii?Q?/kHTz2JC/m3s9/uP0Oub4CazxlOYumyAUNLv/78W7ER/R2QTKVDEg1H0WRHj?=
 =?us-ascii?Q?ZV0T7MbPpr+I8Uzb/A9ScnTITYr0ZM5asAS9Q+igY6siFp01Dazq4MRZHVBQ?=
 =?us-ascii?Q?A+JUiFn/W6UcWLZHPq0HAzjuF+mB/F5m/4n7QmxoGCENhp8VX48jdAyiPusy?=
 =?us-ascii?Q?81qdP1CCp+bbxZWZtau4tBPBkbttm2Cl9U3wZwua?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5425a5df-38e3-4bff-24a9-08dd72722408
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 05:41:11.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiORjghDHbbsKCqlEbS8NoWqzCERBsbNcP+0/5Eatnm6mISSsBG6BM28/sJaxv+dZrN+PG4Ygp0Lv7Z5JyfWGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145

Add the cold reset toggle for i.MX95 PCIe to align PHY's power up sequency.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 84d2f94e3da0..a2d65dc88b66 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -71,6 +71,9 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_PCIE_RST_CTRL			0x3010
+#define IMX95_PCIE_COLD_RST			BIT(0)
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -773,6 +776,43 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	return 0;
 }
 
+static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	u32 val;
+
+	if (assert) {
+		/*
+		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
+		 * should be complete after power-up by the following sequence.
+		 *                 > 10us(at power-up)
+		 *                 > 10ns(warm reset)
+		 *               |<------------>|
+		 *                ______________
+		 * phy_reset ____/              \________________
+		 *                                   ____________
+		 * ref_clk_en_______________________/
+		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
+		 */
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				IMX95_PCIE_COLD_RST);
+		/*
+		 * Make sure the write to IMX95_PCIE_RST_CTRL is flushed to the
+		 * hardware by doing a read. Otherwise, there is no guarantee
+		 * that the write has reached the hardware before udelay().
+		 */
+		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(15);
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				  IMX95_PCIE_COLD_RST);
+		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(10);
+	}
+
+	return 0;
+}
+
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
@@ -1755,6 +1795,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 	},
 	[IMX8MQ_EP] = {
@@ -1808,6 +1849,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.init_phy = imx95_pcie_init_phy,
+		.core_reset = imx95_pcie_core_reset,
 		.epc_features = &imx95_pcie_epc_features,
 		.mode = DW_PCIE_EP_TYPE,
 	},
-- 
2.37.1


