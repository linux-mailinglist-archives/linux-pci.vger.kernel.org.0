Return-Path: <linux-pci+bounces-24483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AE6A6D455
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB228189047A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 06:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C607019309E;
	Mon, 24 Mar 2025 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ma/NsqBg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2D19DF41;
	Mon, 24 Mar 2025 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797923; cv=fail; b=S0thtf7RukKNl2tMY5i3gRfMgiyi2oUjOnuDuqdBe5RpcK3w+iGC3BH4Ur88VJFMvgcoiFvL0HKIRHoKItHZ0B77WrQredT+AN1929Imx2iFt5TjCWAdpqz53iOylQHnzBZZ6ib+JfBHwAwC1xZgoTe3Ja64kmWi2BIJX7auguM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797923; c=relaxed/simple;
	bh=jFLAW2f2cKOsi8QlYcWGQExHjhI8utxfErqyHzAjGdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sVCEB/5tu1q/A23B5visBWLK98w3XLJvFcTXQBJIWDQAVIA0t3Fg7BkFs/W33StROYhYMFzgU3GoET6eJmBUiRfRv2GVJo2evLTe0ZvweVi3XIg0tUkybcG1s31OOfyE+4L5tar1qn6y+9GtbWVR4/LfFCMafHM197awkRj5hh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ma/NsqBg; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZjYtFKresMYqCX2QPZM+q5j03Mki4IDuUx7UuKOxnNbX5VPd9RdZuNdDw6Snx3bpKSukOcQ7acaAd/uufzX+rDWGMopMfkUUd5cQSR+NuHyZrL3AyaxSX/grGg39/f6LHgulj1Y2DLbIg0IzOLMrQq29BRkEB10S378OfKpm1Oh3MlYdvCIAiehx5eRBkGp08jGq/58Hkblk/TZkREtsSb+vxukHCF1pAEZbnL6+VA0JI9D5G2k+5xPKRQRUO5jQgtWuQk+WOjGowbVzu1ijW3lMOgwk2XQvV8e+2VS+mMCOXLVW942weByHyZaFCCQTJbzRfI8NBwZr/NACAQNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFxWWJcxoHRrYnpXOG8x7dcCBKKTSrbc+plTP6+XOLY=;
 b=vAu+/fzhEDrIjlXWhvDpGh1MK1W2bn6B86GMpXgMqN48KlW/t8AlGxYiTeekWP6jyFgyaD0n7o6reRGr+vcBlPW4qdlwf5smN8EszITydKkXha8eaewDD1zNVa4gl/qfam4ncyThMjX0DkS7cKAD5VUjUUCd5Icu9MAF/C6Sm9lNGoYSU4kjlinaCS0tIo6yi8pChvQ+Bl0kEyrrCwcUMc+BQ29ItKVc7/njIbrlONOMfK8jQLW3wJAZRI94Jx8BzxvwQ5Dbqz910ReCSPdOp0HJ+XxT37ttHBh+emC5YA3yYk8/oDF6IpSwC6u5LTZ7YmC1IwCQ+1Hm0MD01/6yFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFxWWJcxoHRrYnpXOG8x7dcCBKKTSrbc+plTP6+XOLY=;
 b=Ma/NsqBgYMQ0B1sjNJrFJ5ay8rtPPDT9tD845nX4kqaaBieLkXzM0tPNn8/fWLxsHtObkp0L5iX209IFGCIs4uH7w1+7Krzdxl87W65FeubEeUl220NJc6DgRP3s7emVKjM2b664Eo5Bg77GSD3aHIbrqlei9uhRN4XkhxXEEhBQxji7uNPEhVKkMXFribEMHZNW386QeDjrhbj6m4mGz0Jnf9eV9kX4nUyoTARzwHmdmrjj+oLnK7PfkEBfnHoi4dvkqBGFH4gt3sy9nYmldPOy5NIENyaPazTFFesqHN1JGL0QrT3rvcjdZIYNMUPFwDNRaI10slXM4tFezuUD2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:31:59 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 06:31:59 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 5/5] PCI: imx6: Save and restore the LUT setting for i.MX95 PCIe
Date: Mon, 24 Mar 2025 14:26:47 +0800
Message-Id: <20250324062647.1891896-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5336c3-28f9-4995-4d09-08dd6a9d94a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|1800799024|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GDwvxFEnC7IwK5FdFBciOHMcgUmHAtoSaYKQ521nuCdC8ZTl80FB/O/wDend?=
 =?us-ascii?Q?8uELAYKPmUt8585vBUKp0oOoHAB1VNiDIg376aWVKQkWhvLT2qYTjFl+dcbL?=
 =?us-ascii?Q?jtt5LErvceVZxgSTm9R/NLYYvtUDB+SyodNKqoSBdnoIROHhpQc7+5vCyeaS?=
 =?us-ascii?Q?j+0ooWZJa6UQ0BhhNgJXQ5Mo2IzAtK5kjnsRiznlsIAQ76Hj/rS9d/E+rTWH?=
 =?us-ascii?Q?pIA3C6I0nw1pyjdkq1Gtu2A84u7c8uBbFO/UinngjcDaVpKwvvtcFxp/W3+t?=
 =?us-ascii?Q?HHVnjRuMqPyRtFnngVx9t5mw6k2qi+rcNwsW7MpGkkcuUVX/5ADCyvH68N5M?=
 =?us-ascii?Q?TBeWHKkmMJvAXcXS0aPH1j/1bi5K/IaeXBVYoyM/rc88ymfFsBA41RuhBN26?=
 =?us-ascii?Q?csGsRrLLEMMG0bR/rnIjXf+86tU6x4IsW4HamV3XA5VRyzwEOisHOaUobbTP?=
 =?us-ascii?Q?VhxbInjneje/IR/a7FSM1rcPGpkTzur3Qoyc94Qgk3XKj1abX7Fg0JLF1yC8?=
 =?us-ascii?Q?hsYXTFAq8WUk+jpkbHzCw5JoSeGXvXBowogw+jpWR5dweWYC+WhWSP5Wx7ll?=
 =?us-ascii?Q?Wg5DKpK1qg4b8gTAYXAu1LPPgX8PMx9XY5wBfhKq4kLiUoBcBkgQg/a8cKoe?=
 =?us-ascii?Q?MdfAEvbVLnp8f9Mp3HdlvOLCdRw0Jn1M3Pka9d3lPCSsfJxBSvwyvEye7Q0r?=
 =?us-ascii?Q?wxNcyIpIKx2hzQ88e82341DJ8JH7I5jAerh37WHxQfhsJsPgy5PccqqVP2Ew?=
 =?us-ascii?Q?kP+k7SLSgzLnjRMtcokxIdfqiKPA/DY/CCKaI6D5qn7Bcd+lI89dalGfpwfL?=
 =?us-ascii?Q?rPt1D3SelATfFlPuydfPJ3Qg5SUTRqP7C5GkXtZ9io4at24/QYkR590hp6ih?=
 =?us-ascii?Q?/ouGZjNW/24vl4sp9TIoxt2Sw+2l+7Q39dD5QKncO+HMwmEv+IxVPfH/tIdZ?=
 =?us-ascii?Q?Fa3/0GBQP/8vMKGpvAFbkZyhhleNGqnzu1ALq+0oAdP8G48Wb52fGkzJYMBi?=
 =?us-ascii?Q?kfxml0x5SGx4bJJm9mNSlRmYGr6SHspsJnrcQ2T0N38RQeB57OxqrukNkJwj?=
 =?us-ascii?Q?k6T4NSlaUhNDAPhMDGBYBOl/d/H8wjSbwhj5WD+pEXvQhDx3ySfZ3N2/gyMx?=
 =?us-ascii?Q?ElscOPvNTfQAHOBbnJCT+tM6SZhfd6bE0YIc0R+2/7MRSR462fA5xafBjN0A?=
 =?us-ascii?Q?qLe7sGelztgJgh2ruPZSrPIaQVqF1LWS+QqQ4Neu4wLCrVGKXBrz+7sfZoS9?=
 =?us-ascii?Q?M4lfknMWCQXmWTOY6OvSpnUvMrXgp4t3b5pK0q2/BAFdpG+me6+sD0VypjmX?=
 =?us-ascii?Q?slHSz0t9PalTxKBHhOwc7Aj4APofqrOTjZctd76wFAXffjaU2TrV+QYK6gKf?=
 =?us-ascii?Q?KGHD+rJb9iBFGiRyfHUU4ctGUT+/bazkJ6Tw9X4u+/gkxiJOqlkdi6mWXWvJ?=
 =?us-ascii?Q?4NOaT1XMyp5lDSLY+zFN7uMA5q4hy7xktRagy2fU4fg9fwJF4APjIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(1800799024)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wd4L7sYMmS5oG/ZZUpOH+9QS5Lh54Y2wVdCWo92ipWP3jS/kczLTJYSgA94S?=
 =?us-ascii?Q?ZFtlL25D96+RQ+QxFmabCmWBVbeQPfX22wAw6j17mn9IjE+NsFGxDLkLPCu+?=
 =?us-ascii?Q?SY0jVNN3bBuwnWi9Vp8Uz2V6A5K0jMzujweQtHBl9zyWp4JC17NFCj8vfdhB?=
 =?us-ascii?Q?cuyiLTG+zV2hNOWwdICQlaOjv+5Cr6tWeDWWFu45c3mY09Vfl1nbiHEEfHlI?=
 =?us-ascii?Q?XWcTcp+ZLjBrJAdLSU0p+M9el5viEph2Qdb9+pQK7JewNov5fF3B3WUdKJbz?=
 =?us-ascii?Q?thcOfc8ObR5134cZwyMQfCWgFLjP2IM2edBsqFDBj/HLvg1yMWuJuFBcgwqv?=
 =?us-ascii?Q?BIQclw9ESyKwyI84GMNFzjkQA3PqqbHbBLkyN7z+V5Q6WMqfzaQfYby787l0?=
 =?us-ascii?Q?08T8pdApOTj/pmisH58YNetwLkB9cD4DM/JRa/XNMzsu3OIsvURly4fM48oV?=
 =?us-ascii?Q?BEehdxPVIWfK0rVnShMlo8+f1K9vKJzku1ca8h0o2ezdoJx4yEumzYI9aA6H?=
 =?us-ascii?Q?vCVLiDpofllG7z0Wo9xj9a7UlssgIv8bMei53cvcn8okEyeSfW4rThJSQopS?=
 =?us-ascii?Q?M/viD8s2g7fq+ukQXTCq3dqvgDlp7CScycwKvjlAiqTWN3ihHPLqCB1MfYYO?=
 =?us-ascii?Q?7pZFv34NNeq04nPrcDGJ4QtMBEZNJWaLI6F/Gnd3wNEacNchO7Uot8+zFTDd?=
 =?us-ascii?Q?/KMkncFiwFWlK2ylYIb3+6CNEI1yGGpfx2RoTe5k6u9DcDQR2kz/noMHB+X3?=
 =?us-ascii?Q?6RrfzTaZXeTugCm08hh4KUk/R/QQeCA0WqbV8NNH6Rm/p/l0y1rdYqs6cy8e?=
 =?us-ascii?Q?+1095fih04ExZOOv6Xpn0dzndkCVCaAPPP+rdYZ6KwJU+SW3NAe9i9dpuEsI?=
 =?us-ascii?Q?FRr+B+pb0o2gH6fccjzEqBOsDC2HhUatMb9KILn/3zsi4Zjh9MjibODvsoJt?=
 =?us-ascii?Q?mQ1HEA3GAtPoibZssyjwc9gsZfBhb2Fuyfz3GZLY/V+qOuG1LVEysJT/3Spr?=
 =?us-ascii?Q?Rel6XtT3b1bXTerTnu+JHgcGA+xg5OJSRosYOvTCJ0pBTTB+SOaSNNjNT0AA?=
 =?us-ascii?Q?OFpwApaCy5GWr4nU94KyB9X0bezx7AaZNCFDCKVX5do7kHE6cnBd+jOX5UmY?=
 =?us-ascii?Q?pZUJLung+UDV0bC1T/BFsaS0ITH/4NqT6zGHtYRIDAbUW3Ho018kJMBMyJho?=
 =?us-ascii?Q?yWGXQgHzTz6AfBiZZA7kjpitql8m6k2AdzikisWuurFTTteS6n2AbtUiuq2n?=
 =?us-ascii?Q?RZ5uBVrxlL46svsiCf51E7L3yNGf0jhx9J50D0ik7D6+kyVxx0wpQtIvydFx?=
 =?us-ascii?Q?qbdRqsJGKaNjzodBUUuFbt8tUL6SZZeOdqRxmsVHni/PtvUg3v+6f7eZfvfG?=
 =?us-ascii?Q?az5gUnYBveEkSD6EpV0j4N/OQiQmA4txSB7H+PES6OcF8L6Cxqq8oo7v8bVL?=
 =?us-ascii?Q?nu2Op5rIPTr95c61ULknePNkI1/hDoMqIwLeCUaTOklYmiWQRyhxfDiD2Cpi?=
 =?us-ascii?Q?h9/V91q9zTGXPg2Bep+QU45NrKVX4EbhfQBDop/gkTZzkktsC+ypPOn3YhLP?=
 =?us-ascii?Q?adxAjRkZj6GnHJ/1nvDJRcDnsO90WrMJyuibwS8Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5336c3-28f9-4995-4d09-08dd6a9d94a1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:31:59.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jToMQD7VMZGZ6J29sk4PRILjWuhZMyhgV4KGuJHDmhgaI2aRDXztwVZyq4C6IBfqq+gwGHSyUbrK8MIJBnHQig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436

LUT(look up table) setting would be lost during PCIe suspend on i.MX95.

To let i.MX95 PCIe PM work fine, save and restore the LUT setting in
suspend and resume operations.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 46 +++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index dda3eed99bb8..a3a032cbaa3c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -135,6 +135,11 @@ struct imx_pcie_drvdata {
 	const struct dw_pcie_host_ops *ops;
 };
 
+struct imx_lut_data {
+	u32 data1;
+	u32 data2;
+};
+
 struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
@@ -154,6 +159,8 @@ struct imx_pcie {
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
+	/* LUT data for pcie */
+	struct imx_lut_data	luts[IMX95_MAX_LUT];
 	/* power domain for pcie */
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
@@ -1468,6 +1475,41 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 	}
 }
 
+static void imx_pcie_lut_save_restore(struct imx_pcie *imx_pcie, bool save)
+{
+	int i;
+	u32 data1, data2;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		if (save) {
+			regmap_write(imx_pcie->iomuxc_gpr,
+				     IMX95_PE0_LUT_ACSCTRL,
+				     IMX95_PEO_LUT_RWA | i);
+			regmap_read(imx_pcie->iomuxc_gpr,
+				    IMX95_PE0_LUT_DATA1, &data1);
+			regmap_read(imx_pcie->iomuxc_gpr,
+				    IMX95_PE0_LUT_DATA2, &data2);
+			if (data1 & IMX95_PE0_LUT_VLD) {
+				imx_pcie->luts[i].data1 = data1;
+				imx_pcie->luts[i].data2 = data2;
+			} else {
+				imx_pcie->luts[i].data1 = 0;
+				imx_pcie->luts[i].data2 = 0;
+			}
+		} else {
+			if ((imx_pcie->luts[i].data1 & IMX95_PE0_LUT_VLD) == 0)
+				continue;
+
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1,
+				     imx_pcie->luts[i].data1);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2,
+				     imx_pcie->luts[i].data2);
+			regmap_write(imx_pcie->iomuxc_gpr,
+				     IMX95_PE0_LUT_ACSCTRL, i);
+		}
+	}
+}
+
 static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
@@ -1476,6 +1518,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save_restore(imx_pcie, true);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
 		/*
 		 * The minimum for a workaround would be to set PERST# and to
@@ -1520,6 +1564,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		if (ret)
 			return ret;
 	}
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save_restore(imx_pcie, false);
 	imx_pcie_msi_save_restore(imx_pcie, false);
 
 	return 0;
-- 
2.37.1


