Return-Path: <linux-pci+bounces-25987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 664FBA8B317
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1345A13D1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBC11DDC1B;
	Wed, 16 Apr 2025 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nMOn5gJx"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940CF231A57;
	Wed, 16 Apr 2025 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791309; cv=fail; b=I3d/nN68Y3wKF3EDXPxdATAq4kVfs1sVhc3Wl7Tgyr7CCD0CPfsqdpWuwdl4jS4d2iQH2pkcFnKf0mlmW8FmLM5GLylqFIWj2CPhUhqlpd3r/PtX03IaA8DNEZuscpsBdDruBJ5byEr6EWMZlyVIvXDXAvoGgU7uTc3YfP1nZQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791309; c=relaxed/simple;
	bh=vl7IHnlsKCckjRcbUyhgVQFVgrJ2fCD0n8q4dgniaxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIR/FPcuI2QUZ3Vp1kYmKBGGV3zNswh4WKZsP5V8/jiZYn0N/t0AEZER1n4o1gYaqor13H02BA8oFcvXo76DO4x+kum05VmAF5xD76VNA1ZWNsmlrqxU3AubLCTM8Vb8XQ5JmZcy+9kxxU2kJGJwcPa2PSCr+QW2CNd9PmhASwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nMOn5gJx; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sz9EBkWGzESzMwH1o8NkHBg09ynqd3zBQfoM4hrMHjwDgFvjsvhCaZlvSjDG6paSiMaZowaUFPs6Me00GWfAtAXc2hsO5tsfeNOUo+0j35obOW/D6OWFU0P4JjIRGcWwfYZJ2HLwXwgg3kmSWrLplgGNlywbyqn0qMBSSJSsmXhA2VyiVKtDw+hepxKknU3dt9M4DWNhMYqSAmThvfH32zIE/5/NgfpkMnFEpFF7I5pxHL3BPBReB4fPnSSto+64k0spZJ4l5cWtNuC84szSEdU3OAulI/ONt9gvwxs4C1efv+5lMRicU2KykOBrs6TXXBNU7cx8KXRuDHkMQsi2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnwGdEG5qfpvTGMebNhGg1wtFGs1UvPt05cM09AHdDU=;
 b=gQLZzCST7eAy/ew4mmWNypq7FLYiMDb3uSDlhqmL+ZaAzYPcxB/acEzO6fRnGyveb0xmEUZB6jLdFC9DwN3zYDyRjM8ltsSukr4KsD2xiRdY/5kN+GzfptacfsYH8DtcbPmPEvxgC0oclKoqTXdlZD4ZOzyRizDFPeka3g1M0455wh7ySz2yxNOt0IzwK22OfsU0gSlxeEyFRC9H+cBmYTUHnUGO5cl7GNX3wxKkcRxzNRuXlV/so+dyywFlnPB9a7YDy9L2llYKFDH3OXiJh+4J3V5ULGo4Nmnt2tYdVQtReYUpturXZlQOAqFGI9W+3YneGbgtAGJl90VCiIP9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnwGdEG5qfpvTGMebNhGg1wtFGs1UvPt05cM09AHdDU=;
 b=nMOn5gJxhdVGRz6aeTupblGHepwgOnBmWlwqnY3jYtt2BlJ+Ck6egMUl3Ue46zQChBdVjidSqTMSEPg4pKBJ1Ayy/wz0UA9JjLTi/vfEZaiRN6AtYxotD9LxKGqo5yIhDxq2ASB6oOY1wRHebw8lkoIoUG1RJMoVvijABZDORLpu/LAb3JD718HVducDNm80a/b03HJXwqkGafF4Z+md0z8RVKsne61UQpXuf6rmzsvbDPkWre7LGzInjqkSSfV95ePmhEtPJ4Lmnwnyz6wvmjgaWWwJ1eHVKKRXcnqfJm5LD7e0vXKeDEki7aSj68Be+mMf0u/Qu1m0zbKJaNF48A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8716.eurprd04.prod.outlook.com (2603:10a6:20b:43f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 08:15:05 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:15:05 +0000
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
Subject: [PATCH RESEND v6 5/7] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s Receiver Impedance ECN
Date: Wed, 16 Apr 2025 16:13:12 +0800
Message-Id: <20250416081314.3929794-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
References: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 3339cd12-9828-4fcc-dd37-08dd7cbecb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XBz1BNiwbYsrIrqHBY+dfCj+wz9GO5MM1qgaVqABjoNcKHLVtefpV3/PYddu?=
 =?us-ascii?Q?OD3JHiMsGd0L1auK+0p9pucoLJ0CWIqi2EbQPatkoo2c0FQkO1OR3Doe/w3I?=
 =?us-ascii?Q?AFqPa4HsgRiRdGtwq4Dc5GLZcfHZsIv4WOTpVJaTbDx236UViim5nDndO9XH?=
 =?us-ascii?Q?rHP6f95YY60qS2xrTORsJyvQB0yfP5zpYRzYPaPXA7cp9RGV7pJKWJJpU1jp?=
 =?us-ascii?Q?ZKL8XuwRcldDSzfC0GovF9pdJiuH7qrQVutTJC+BwoXmCfdBmq8bv+gCKhrL?=
 =?us-ascii?Q?qAMVthWSLzyZSshwyV9IFGjzNSWFOCbnI/ctOgWOt+KC75ZZcRGlhBs6Vuco?=
 =?us-ascii?Q?44z7Pa8m5BFDkZVkM1YOpQIMZaLmANTSG7bRifphUfxTy0a20uvF/M6Mm6WL?=
 =?us-ascii?Q?4XhxoV0nYV9EZppGhQGUwSEQH3t3Xs63oBPpVAOtQZVK/bvMzaiyhWYqQ0WP?=
 =?us-ascii?Q?Kna3BnUvAbs5iqd2iiveDPPgO7/9IzgCX3zR00dibXszHQbkiJmPvldmj3Da?=
 =?us-ascii?Q?sKyXFlBk8TkYfcllzG50eAhwnvJYUjiAkP+HUuziotqJpurCZbAdSnGoj+ua?=
 =?us-ascii?Q?6Q/TlDzakPuFOL9oqnNGu9jyJg/c8z9carlJAx1wArZTcv1xprl1MNisU+rS?=
 =?us-ascii?Q?XAlvAjaZB1xkmAhesNwgRU3vh8iNhnNYa/LVedgU7D0Dvxe900z3/45SH8pV?=
 =?us-ascii?Q?LKVRqAztrshtRtG06ywTPAFDwyUhhE7AAx885aD/AW8HWD6AVPRHlNrD9xla?=
 =?us-ascii?Q?aiDTY4PnPqQjPArZPHUJrijrItdNazkr0KTxG2/P4SMHZWtvXTevdlwRp6pp?=
 =?us-ascii?Q?3A05Pj8v/4lFkqRXeHHjB36dVe+i6064h2PaFbN8YoWjwZrLrkl8zobEB0KF?=
 =?us-ascii?Q?wwGPPsdrzUIZNVQuwHg/C7xxZI0FrbmVyYOZ6VCb6yvGrRwr1r1lxsCvUFXV?=
 =?us-ascii?Q?numscWSVC3Wqs0ahLdFNfbJPVC1zeMUrE1PVPNp2tHXbCUJoFmWpnG53KIrl?=
 =?us-ascii?Q?XUPEwplrTMSQJ2QZN00NN/Ja2IeLz927f1fIGx9p/upecN5W4Ed3sC4L4Dwd?=
 =?us-ascii?Q?DQxGpe02d9yh9pKChBceQ4YQktrIC/gbpL5OIxaQaR3y2PUTk+Py16Cmw4HU?=
 =?us-ascii?Q?z7uXiydShwZMnkmOJmbeFFXrzNPI0/hwzCweSZOr96mlO9x5GEEPRG5Lnt9H?=
 =?us-ascii?Q?OMapvHzckK4AjW4Gseg1B9mLOgjWSweyCV6pJm9oIpSghlFhI3JaWRWgPkND?=
 =?us-ascii?Q?Oe1xOMEM/r0dNaQ8j0EMeJkUUqDkZGjKcp24BiWMr3k0wpwFfRl8hlSLRGt+?=
 =?us-ascii?Q?jNUEEbPvYuMSR2HcLgZ2OctwUmcZbitm1xD0eo7obRxks4FHXO0lZbNaOe/C?=
 =?us-ascii?Q?PODqG5yNVH/xLBdgQtNDw9TGy3qvDmAHbvRU+Wx5F9pqORqJZj/qo/b/5S4E?=
 =?us-ascii?Q?blB+gyfLaaJmWEjMVGPLJgG4rZtI66jkXQbQL/9zZbn335p3XZ5pnXSDU5qj?=
 =?us-ascii?Q?vQbTKG8MYIWnewI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uGpVr/rsBm814y3+L8l76k1uHWe+fv/bTBUkDV43eGSf6zTBRJyNBOcKqN0R?=
 =?us-ascii?Q?9fmPw6+OcPqY4QnFwnh6v8krvXXn3jgPQ4ZAWpV+5RVpI5V5l6Sfc/hj9HjT?=
 =?us-ascii?Q?drJX1U0FZ5RT6XRSRHW8W+Ml7VKjF7lYY1veu9TZIh1hthy6Ad0doIRnJYg8?=
 =?us-ascii?Q?GGn+6+tWGPyrApmKYKM2MnDBV5CRhgJ1KEUYTmTgseNm127rH3ErW06lVAvO?=
 =?us-ascii?Q?ZWFYU6Kc+wNEosgBNXRU0yRh1O0R5AY2QpmViMy8IZxSh7XHSsPM2agWeMJO?=
 =?us-ascii?Q?8QfgOhhmhFO8/t7ac/uSw4R6faZptnmM15XlGkOtJL9al+iDBwZAgi7ojzfj?=
 =?us-ascii?Q?5k2XcubYDua1hKIOqMfwlF6HRP7PkbXY+ImCj/cGaua8Td5uMvt9ndZ6urVE?=
 =?us-ascii?Q?UaeBrz+Mab2M/egIhDoiOsygbFqDCigB20IzhXrg8fVHqhueTKmYwynYld1B?=
 =?us-ascii?Q?c9DZzf/2pS83UxDzDRHv8bJnHhHu5LhDIwor3tlN508+kn9ubCo/lzlQitu+?=
 =?us-ascii?Q?AQYLpxzB5na/aqTJKZ1qfaDDP5SqR2DkXZlIyv6ZzoeSvWDN2bKBVcnZ1mud?=
 =?us-ascii?Q?lqJVicaw1P8TqwxGctO3S56+OkiyhmQiTdt1SjUl9ir3BPbLbAvImH8ugDba?=
 =?us-ascii?Q?r0M7NXkgcx9Fzl8z622bQbElFjLkaD41pQoNj7GupEEzGEPMAZ5I8gyo5nMo?=
 =?us-ascii?Q?PN3Sj+6XyDoOqJNAMzlDq3zlhtgjBs2fW1mgwfNyBC9p2kMGA5Y/uzV4F0ZZ?=
 =?us-ascii?Q?CgcZo0ttIxksIQruF0RkS/H1Bu7S8eYAtd8QRE8Z7Ez5MHXVB+I3XNFvq0QO?=
 =?us-ascii?Q?CqNN0eC0vkDnycyDVN2GAZStq9vODpk/2ahHv6w8P6vqXmuLBisM/SFz0DL9?=
 =?us-ascii?Q?trf7aqpfrgRNFQ5wcqXk+tAGCpniWAVcjJmzy6LFbCfHAah073b8h/ctV0Bx?=
 =?us-ascii?Q?6J5yDR74Ay96/bEtUBnOX/8Q0AdE3iLouNKo7eSptWGdDlTKeqVwL8ckH+3A?=
 =?us-ascii?Q?XtNuym4WWoBYmvT00ZoKIWKoJnzmMckp+8sYPDjiNsx3rg64lmdJ8qxwaCG6?=
 =?us-ascii?Q?GOdYlufAui/zHKR+aMemnvkLvDcPyDG53uZXykbhe9W4U4GOpaZJfLdT5G9T?=
 =?us-ascii?Q?l0bsNf95Thtt90tQjC01a5I14pImLhMZwX/TZVaJ+0/0w/tMh3cJ926M8PqO?=
 =?us-ascii?Q?F5g303B4VN9hBRy/Pz7LS1AETyeW7xEnQr2eiWlJYnIEtFlnPMLcYoZROaZ7?=
 =?us-ascii?Q?4X9r3jyFoRc4NT3UIRq2mPsZOxnF0RDSNgBqEHMHf6WWMVc0co2H9pLBMp1X?=
 =?us-ascii?Q?e32tqDkwUJRLIOj/5assGLIiW5ueo3b4OJvZQdb6SVjjHqULDYypZneVi0cf?=
 =?us-ascii?Q?Ns1ZdHti1WiFaHVOpG6XPw3HS7L/W2ntPb6osdrqeGFhPNJOUZExd6iTQsCt?=
 =?us-ascii?Q?iruwmrP5HOLRuVfiDYXR40RCm9jvQ4wjBPy5weJmXAlXf+LjxwHot+an64U/?=
 =?us-ascii?Q?LKDNkzh2vqKU5QRwOW6ZLutL1Z0vocC3DwFNXFT93cbNK0iFutgRHJI7qmzN?=
 =?us-ascii?Q?uvqK2TwZM+nbbSUizd9365Qe/dUfg/jG6tRL9VYT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3339cd12-9828-4fcc-dd37-08dd7cbecb0d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:15:05.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kd3P4z8vOLP7XCXX7LbgNB/OQuIA7B1uEea5Foxx8qfyknIhiI1sdjyk4BLesJWUDiNn424yKgu5nFKyV4DwnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8716

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
index 016b86add959..7dcc9d88740d 100644
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
 /*
  * In old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD in iATU Ctrl2
  * register is reserved, so the generic DWC implementation of sending the
@@ -1281,6 +1308,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
+	.post_init = imx_pcie_host_post_init,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1392,6 +1420,7 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 		dev_err(dev, "failed to initialize endpoint\n");
 		return ret;
 	}
+	imx_pcie_host_post_init(pp);
 
 	ret = dw_pcie_ep_init_registers(ep);
 	if (ret) {
@@ -1789,6 +1818,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
 			 IMX_PCIE_FLAG_HAS_LUT |
+			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
@@ -1842,6 +1872,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
 			 IMX_PCIE_FLAG_SUPPORT_64BIT,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
-- 
2.37.1


