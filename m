Return-Path: <linux-pci+bounces-24904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565AA742B1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 04:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5130E3BFCCF
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 03:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4025F211474;
	Fri, 28 Mar 2025 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KhDOP8P4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C5211466;
	Fri, 28 Mar 2025 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743131042; cv=fail; b=HMZ0HqThQ98CEa1F+MRUbIY1I39R4wots9igJNW5zXS7VApbjR38OkRGuSMzeLoupriFpddVSo63QwLN0nnGcp7FShB/ftj/hTgYJd0Bsn+8qbwKVG8E0lDks9Z+57FEjZWg2v66czoC7o7KcXH6YWj+QREeqyMM34Jp109y9uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743131042; c=relaxed/simple;
	bh=KFbAmY7tt+tcMVJTRrsdEt6NhZ9wP+vuVYL/LamKlSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwHNdciyXQBst5hE0K4/oZ/J3XETS2+cNVENPlvEWWlfocZaM/u06HBmPtiNK1fWbuEEna3v04zn5LJV+x3TOXrYwiKHpKt9+IQHU8nJluJJ75UGz6ULuE8B7zuu10/9X1O87aeIRw/JxKWpwUNkVA8v6QQH6aCsG1rJld6fO2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KhDOP8P4; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsDumoW1xXNG9MopLKN6UEOb/FPv+NtN25uFBVPtIK3jkKKdky/QPC55FGLfwL7xmJKWOIweP4ZbuQcT/H1+O55L890sw12RMlc2clgpsrhE4ydO5hdjpgqkhD4xjDrRKCV8BsDAWLPI/vZNV5JSAxl45buD9lED3ViFIb/LJIZe5lraIBFzEDUm6VJPxHfHz57Pt5mpujyazEknAbrsNswhKLcqb4SmjM4h/yKuhftvj6ZmSyQ2ssXf36uvJ9f5zTyorBBhMFSPuHOUO5wu1D8c9Jb3CuGAzzBkoyhvgczsSoHYxijDJm8KTHLGwpxRIdQUB004utNH7tXRNKVnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdLbJI/a8fEfSLxMsAJ3X1/n/Mi4R72cFi83T+J7Mx4=;
 b=efy049nNO0Z4ZtNBLkJffkY5NzSg3jfzXkmhH/OwSTVsL+IouH/MzcQphCf6n0+VJiEEAB1fPus2Ge6WGOY4udUy27Skf0xegUkheUBJ+ZepiUAxrIQcET9ocTVd8nT9//r/O/uKWeTU/b5KdlGckZyUWH0cyxDvJOgn0n5UxVjDty0Ea5VdsynVJaJ5i6pL9yiIerPh84Cb7qHGqAnqMJYcMFDkl6TuY4fGZ09iqE9usvPC6qwf7Kil30o1J0qbNtZ2b2ED4UvFYtmXyvpYaveWaqm1jI38244I2/iHoh/rEBNKNY+szJhnL2kAzsgNa/NgYYdZV83ujpx+LKhmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdLbJI/a8fEfSLxMsAJ3X1/n/Mi4R72cFi83T+J7Mx4=;
 b=KhDOP8P4UnjiohV6A2mmylagHUCyIBkI075Sm1vJauhJiED5u965t5WDZ4naf+K+2cZSerBWcMx91TXBB4GPy84RH4Yof9xKwOoGvu1S/nJ18S2rSQypzyTbwH5xZQ5mLeoH3QOd7I2c3gHBZgiFq3PiSCLzNNzA/6vbWUw35Yx3FxZB589tLg7mi8DF4k1pcjUuOI04I1Jp2uEF2jAZasM8UPkF971NNnG5XIrYhWtr2nLe7hXxAUzEqVATsB4JPCbtcq4HEZntmBQf/LFNE81f1OlSKlBawoBdrxOOYUYLZV+ZSXIX4HZJBSjL33wp3+FpvLVqek0o4DRD1lvSKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 03:03:58 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 03:03:58 +0000
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
Subject: [PATCH v3 6/6] PCI: imx6: Save and restore the LUT setting for i.MX95 PCIe
Date: Fri, 28 Mar 2025 11:02:13 +0800
Message-Id: <20250328030213.1650990-7-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: c91dea09-7f74-4ff2-9ee4-08dd6da52ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wu/mpfWS1PuZtVIl9U8Wb8dIeR+kzm68jsxzS12EnY98Ryc9wvsvTO7PZ/Xg?=
 =?us-ascii?Q?sWoey7SfnsYPGThJ9bC/qv1Kv2hzxPdT21low3d2AV/v5s/F5BFoBshDa2Ju?=
 =?us-ascii?Q?SprikvENho6TvfI27vT4ZbFtS+GRm6AAMuDEV+9KV9i4+hHCTcgMqVd9jxMI?=
 =?us-ascii?Q?A1XRgJUBQ2+Yk/u23GgGVsH/WB0e+4bR0vp5R57/L2dUCsD1J5B4YrW4FpXG?=
 =?us-ascii?Q?ZvQFSegC8c4pnOtylnatNj1UiFQuvRJmN61MMmL8XUp9Mpd6ybwknARjITc4?=
 =?us-ascii?Q?O4+wYiR5nCHDPLfnIz5W78rIoOdVz3VoqhJswTEM3F2TOFFH4K1CJUv75MKN?=
 =?us-ascii?Q?5tiZxoWG9q/17QBaLx+FOEJoDCQgtrohVKsmE+S78CJA1ZOFID8I4fDfJn+e?=
 =?us-ascii?Q?47TmGRNd3Hy+vUq+XekpV2nqt/mHiOu+/JZd9zVA0Std8Xnmojfcz8fTXfAb?=
 =?us-ascii?Q?ima3kvvvxezl63xeio9lH8OxySwC14H3cyIv6soGhz0AexWr7KD6+JdxC+38?=
 =?us-ascii?Q?9upjHYf01BSyCFIyT6WBZCvfvktQTMt2gtRiY/0C6QHPCjMo+nnPeEUe4u4j?=
 =?us-ascii?Q?dHBfCdGiPUc3+vSw1w0hvouj037Cbp3x7tKwwaX3I+z3DEE9jFxtKIa8h15K?=
 =?us-ascii?Q?hGIyCSRrr0K11pbq2lVNyAUMSVoBvY5YNhaJbmvHt7ZTnsne3hpRLeqzmzbD?=
 =?us-ascii?Q?aSae3u34O5gzRAiFPcx0UlO3ml0CbCZ/KqkKudXo9xrPW3/m4AVDGoIGI1n1?=
 =?us-ascii?Q?8AnwtltS8jpKNRXusBhGf1/fOGfK/n9i9HZ/S8Kuo3RFi2JbABr5DGEObPWA?=
 =?us-ascii?Q?LFXGc7sUxk7/UJBGxG7SY/cV2fkQdgxXz1mo8lJKBke5nHPkl/N4oGa4iXCT?=
 =?us-ascii?Q?XTcvwViTm1Q1G5ufvOAN/fJSZfCPctQkAucxwg1OlUjzlZUN1X01B8zQA/M3?=
 =?us-ascii?Q?kMYuelgGQWP4ILz9d8S9ZXNq+tqLrgt5tn6ppXJ4xs+eDNG1x94vr8nux2sQ?=
 =?us-ascii?Q?a6g5QRpj/g5GvmF+3rKMLpEy+EFrNgkzJdYAmln10KiBTUsTgegTMT3BX644?=
 =?us-ascii?Q?Zf4R4wQ2LHtI+/R4k22qDo1sL/Af2LUd4+i8tLyR1uJjvnbsFVfrY+7J5/cz?=
 =?us-ascii?Q?4GM43ME8dJ/Tnx24MFXLbiLdUnmjLweAcoYZAvtj5zjPxqNYKS6S05B5yIOy?=
 =?us-ascii?Q?d7TTsEdUIaUatvfHOitbaUQW6J8wLg6kvfXV//J0qsiFfXoTWaEdVU1OoSSs?=
 =?us-ascii?Q?s12b9CdhiDFFv5q1hpPoFexWfvnGmS1naPQZfFcES8AUGSigb98gsvS+Nf0r?=
 =?us-ascii?Q?AuOVotB8IIpJ2XyUV/ifJNReFtycvDZmV/Y/ju3/EDAv/LijMbJKqzv+0Qs9?=
 =?us-ascii?Q?cBDSmq77zz/dfhRHPHyzNv67QWAAr5hB97fhFlPtvSZpS2oQABm4lhX+QNm9?=
 =?us-ascii?Q?1zOwgq/M8wIz8076wMuMW07NYQ52ktoe8bDQwyDycGTDk2oFI8X6sg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/uUtDcaIsm01622mKaWm8k0RviGmEUkzY1e7XChpDbwKY+Q/PVeGsNbt1ZJK?=
 =?us-ascii?Q?cDN39qCBoFvTjZ+x3veSQWE4DXAhPOwMHeVW8Bw6/M14UUGBLqOosUWs9kx7?=
 =?us-ascii?Q?BL3cPGBX3ch+OdgchO9dT2CDDG4Go2pXikFJSTjYQOwN2xWxeEpJxsRXbjnm?=
 =?us-ascii?Q?f4FjpMUkGmHz4ec9NPjqd1dFbrHhRY5aWJjkHWynqnQIzUKneElu4eIxAYsE?=
 =?us-ascii?Q?2i3rXmHYa+N5C88RZJPCAnyJKBB7hC4MaTjT2HQWGP+hJAhT2LNu5aF+pcb4?=
 =?us-ascii?Q?UMGIQWSeHVD29A+dvWn/4g3ilCthx1aCYkIdDfdFhxQTm9bf0fCsnZChuT+6?=
 =?us-ascii?Q?lP+lAoyvIM1gNnUhPcVSQ5ZIKWsQzwylQ9vG1g+y0ppjWLRWNBCq38idGPTS?=
 =?us-ascii?Q?nEc5hxsvPCGsWQeVzLRECk3uPHAfVzwzJX52EUXAMbX0O3J+jseoutLnE0Pl?=
 =?us-ascii?Q?xt0+/XdZsInbj1lT7g77n8E2NM3e6FK2IUlKQ9RaJFRiGHobvb4KP1xTHuzP?=
 =?us-ascii?Q?Oe3BohH/c9wM1LqBh27lM4n2LM6YQYULy4K8YBheLqxSUrQ0ai2qbFIGP1U2?=
 =?us-ascii?Q?0uY+WnUecUwGlczVqrBxH0kCSlTEuiGYuyyqnPUAt/wLXllxfn4S63AgljfA?=
 =?us-ascii?Q?FTarT7rv2rHKirzNKYcGrN+rI4QqiuqaM5dccmut+5aRz16QxwOMgf14kQRT?=
 =?us-ascii?Q?LZXdReEoAPBxvGhn07ml3nCC9WJpw3lpWxH7s/CprIkUQlNhQt0dCCzCJzq2?=
 =?us-ascii?Q?hqZS90oWY8iS9vEPDd6vVdNa34Ev3dGmv4gDvJe8DgRZJQ5+nyfSvO5RCnnl?=
 =?us-ascii?Q?moHLa7BVXezyLxTeus5nKDz2ywrsTKsryTC/ygDJeyc9cwsJhRil/jwhZdpQ?=
 =?us-ascii?Q?l2v5l7mbMChnWjuySzGwL1q36ocl6COYEUpY5HVxKkwQFr+eZBoogtDjVsPl?=
 =?us-ascii?Q?oH0RkFo7zVfMNckGBMlxSr60tDVabwdtqRC+d8JheDAtak5i4eazlVkmeAS3?=
 =?us-ascii?Q?dSwpMAwEcgQfmSY7CQv3jbqk9wTXjFjazzybXtktKj6TiW4FGnqByZi400Kd?=
 =?us-ascii?Q?H4QMLbjew/fga3FgYsM+ctII2PxRcQJ7PeL33bHYgcS+ti4IFvj32gHkur8A?=
 =?us-ascii?Q?m3z1hGrimE+zECYsGXkKu/Wr/syKUCyDgeRuPWobFZ+0xBbhHngmXt8Hlq5+?=
 =?us-ascii?Q?tte1FNHa+qb/y0RBudjkaRqR2wQPAUJxC4moqc1Qhm/1G4ILHTA2ncsDiWad?=
 =?us-ascii?Q?7FMlWh61j9eqPBR5CiMFiwUzTuDpinNJRzuFfDI8Bw2vjN9KhLwBoVO4SOFF?=
 =?us-ascii?Q?VxUVVu3MtgtZtWrgwM6le7ZpYYBrKrwHgAhM+u5e1A4vF7Eu5xeJHlkL18Vw?=
 =?us-ascii?Q?OhtmCNeL+UDnbHQ7kyP6SmM7LSb/uL9zXredcS5vAv7BlDOMUWhPbnXIj6fh?=
 =?us-ascii?Q?pRh+Qrnxj+ZcXruSkhdexbvYzVf52cgx02lv3Q1FLG1ZsPS5yxJES14X3Kfz?=
 =?us-ascii?Q?aw6Vh2cOj/lCkPIQVx7cTB9MfA2Ivq+FNQv5rzijeWmyCszpHz2GxWOL+Isb?=
 =?us-ascii?Q?g1OQvIGY/qWkxQD1GA/mkusmuK98TdNqKb28S8Z8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91dea09-7f74-4ff2-9ee4-08dd6da52ec2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 03:03:57.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r71XkNOE1Ia6ry4ZFXJql6+gkJ1VDja/VuYV5E9zP6bz8C5PHVRTt+QNfng4ZpyH/DoT81xYXNOvq7yyQbLCJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

The look up table(LUT) setting would be lost during PCIe suspend on i.MX95.

To ensure proper functionality after resume, save and restore the LUT
setting in suspend and resume operations.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 40eeb02ffb5d..d8f4608eb7da 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -138,6 +138,11 @@ struct imx_pcie_drvdata {
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
@@ -157,6 +162,8 @@ struct imx_pcie {
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
+	/* LUT data for pcie */
+	struct imx_lut_data	luts[IMX95_MAX_LUT];
 	/* power domain for pcie */
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
@@ -1505,6 +1512,42 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 	}
 }
 
+static void imx_pcie_lut_save(struct imx_pcie *imx_pcie)
+{
+	u32 data1, data2;
+	int i;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL,
+			     IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (data1 & IMX95_PE0_LUT_VLD) {
+			imx_pcie->luts[i].data1 = data1;
+			imx_pcie->luts[i].data2 = data2;
+		} else {
+			imx_pcie->luts[i].data1 = 0;
+			imx_pcie->luts[i].data2 = 0;
+		}
+	}
+}
+
+static void imx_pcie_lut_restore(struct imx_pcie *imx_pcie)
+{
+	int i;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		if ((imx_pcie->luts[i].data1 & IMX95_PE0_LUT_VLD) == 0)
+			continue;
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1,
+			     imx_pcie->luts[i].data1);
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2,
+			     imx_pcie->luts[i].data2);
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+	}
+}
+
 static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
@@ -1513,6 +1556,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save(imx_pcie);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
 		/*
 		 * The minimum for a workaround would be to set PERST# and to
@@ -1557,6 +1602,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		if (ret)
 			return ret;
 	}
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
 
 	return 0;
-- 
2.37.1


