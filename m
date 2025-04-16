Return-Path: <linux-pci+bounces-25985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB35A8B312
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116635A1830
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939F4230BDF;
	Wed, 16 Apr 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="byXPv/+v"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F7230BCE;
	Wed, 16 Apr 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791299; cv=fail; b=Q+Z8GBRHMvF0xDFiY/szw5WyCO2Mw+A470qIpDG6h9G0tV5PJKJUaakzoqlIzO7Yoh7Gm4+9coFhBWi7NAzKD+BnYPAIHXyo7019/4jNM+MHuK5zf4pW68v95l9hlAny7olWAqcwfGpgp9bBAsGiZ809aSyZnCa/C6BEYa8PuSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791299; c=relaxed/simple;
	bh=WaqQmKsfvH/WeOZN3jVoSkWGQBlGBnJA10N2WlCTpa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTyAoza7hyrFXHn3ASaxUX/BGCrJybdV6JSJyr6y5nec+rhT0IEcPAS84J7DWyR6Fx6TCIjXfslO3Skqy+o+qwtknDAZOy+q9ztT7wAajuzAEnuWJAvA1MXYIhq4v1JrB4uj80gKGGBngJTaLrWSGXjnpgLQw5sbm0JOL/9yHxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=byXPv/+v; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRQm/3/s63nFr0Bif3hIbqu0Y1qmmChrzMQ7XkmVwVAYtKvOlHVN0q1X7sBJDrP6TMOiXrEx1ZVRSJSHgD2KqmdDPekyibXzfUXKHwnycD7rp22Oq+GN3cA01Rl0VNYmPTohD3X6wHde30ABvp3pyV39XfWUsNyZKwb1dQhHXutmGR8BLGSh0cItSmXjN6hZPS8UE9M76fQ0o4xCIOCni848Hs5lLxGYcRBmw17fRm7AkIdGlhdJ9JNtywBGVo5JdNK99vLbvMYSqVTFwwBmREkY5AJrt0/tAt9x0IhvQEQy1Xe4Sudw4RCTLydyOFUQG+P/nCaVjtUEeA58DbnMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/ZZpQ8LxIFPxxJvrZewL0fh5qESFxQt9iOTACQH02c=;
 b=xKjTBKlzqe6DTKomGXATYInFjRND2anj26dGBB7WcWZ5Jd/+D1oKoVTY7NpvO2j+SqlWfjXEbSbnhAo3FrgWTTm+zrCVXcOJfnvzIgY9vDyBg0cB3/PRqEOOJQXplH4GYSCK4zqmnNQZKIkTN2u8y1jNqN07BK5OWnst76BKZgSSZNPtZe+gU6mBb2MBMLKPMwbY15HNk4k6/NMqIl0PjUe/roqJCB3kiSN/pZmTslIUgtSMJymgMBirXM7MeYMSlEwWeJF9YL2jH/aXaoj5HNcPXOWzDGUcwVa9Grsh+FjI2cFYxcOYfnyt7HCocdAg+iEWC4KYc8zA7L4EBFmJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/ZZpQ8LxIFPxxJvrZewL0fh5qESFxQt9iOTACQH02c=;
 b=byXPv/+vzoz31YFmjBf1ToB3iH9QDpP0yrZKhbuJUMfDVGpdh8a0TJlIxwmrs63KM1G5Dz90WwKTXgzA3CB/z1T5gYQIP7Z/VUAq/jDGawJVa+zPEO3l+yfSV9PK3xOcENGGTFN/UeeihHOh2Nh3Yh/Ot40kfFESlnAsYBB6vYkaTZGFvr2UDMeXdm+no1xWpb9KN9dw69bORGumvGKa9fmTmCzdQj6JuMKGU17f9lFj34zACozPEjg5tdZXProMp6iTP1rUCx+d5SOUm4oF+fidTkYVmEfTGYoYvkirRX0I3lS9ae6O7vUbZ4w9KVzpTQE03nb8cFxeN7wrZEouFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7103.eurprd04.prod.outlook.com (2603:10a6:800:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 08:14:55 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:14:55 +0000
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
Subject: [PATCH RESEND v6 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Date: Wed, 16 Apr 2025 16:13:10 +0800
Message-Id: <20250416081314.3929794-4-hongxing.zhu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 234a6a09-3ade-481c-5e83-08dd7cbec52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S/+ZNlp4GUh0OpDahKBN/e/LWliQt8Kjl1JwVbnX+LXA0RLnnImmsDzbSsOx?=
 =?us-ascii?Q?uvIskPFcxyAp1pjVtsPrNq83XMnx8QC349HIxuBtMoTb+f6evC/WynQZuYEx?=
 =?us-ascii?Q?twGLYxkFw4gX3yYrOloOrPAXNXSs/coIqS3mBynFz3PEbAB6UqV3PahwkjKS?=
 =?us-ascii?Q?+74xFUG5ewgh+x3vL+h3qupFFAhuM7PtJL/PQ4CRBqpfMV438RzOMLVFIUDp?=
 =?us-ascii?Q?YVC5bF2VFTTO4XRt0ajxhOaErxTMVGqORyeGEJIuPl6PFOG0/PXoesGdyIaz?=
 =?us-ascii?Q?A04+f6buZiezX9FdO/Oq0q3Qq4NXUhyxNVr8wqDEoiP02L5y7HbFJvR9un3M?=
 =?us-ascii?Q?EhaDTQHq7OBG0NnQAkSlmuR760KMS5sYSTY241sSNbtvHoLlu73nDVy688WL?=
 =?us-ascii?Q?yoeofsEtoTt+ezmc+Cf7RzkLRIARmNk9UGSYofiOP7hJdv2XoEjMF22ZzAf2?=
 =?us-ascii?Q?fO1t5mgPB+3R7nec7nWHKHsl3ZxMn5ACo3s5b4/RYHfDu5PyoogyrX8m/0NL?=
 =?us-ascii?Q?Ww5UQMNxyRDb2N83hi8kCfCsSnGIvJEBlC7nPORTg//PFGpm2xSsN4FXc1CE?=
 =?us-ascii?Q?EXXyuyL2oP65XI+OMQLuBgdH7J3UAluDnTaMiLkvtwZPbPCvm9i0lE09b6Bi?=
 =?us-ascii?Q?UDMkWZB7QQ1BTRLHz4amsJIbEZJP9vbpmvcyRtxXIUKdmFzEMAWjnDSHc7xH?=
 =?us-ascii?Q?kQ7nNdJve5Iv3tuyQT/1cJ4j63Xv25Z/uotsuI0gjNycWdkIDeXn7jk8WaGC?=
 =?us-ascii?Q?x4CbDG7YLcyH739wuadCrxehrme6aYab7z/vwYh0cs22ZVCoo+cj2WcrLORk?=
 =?us-ascii?Q?g1+Q0dHy5tl0PGeqgUjAvpGp2yh51MXkPKW8y/Z9LBQIHQ+cZAOBcQlsFA2j?=
 =?us-ascii?Q?jOM7OHNyFRKZqkQGTatbQDhVw+QSuZTtJSB21ztXnE6hfjJLlQQjpcGLD9G4?=
 =?us-ascii?Q?HaVh4sPtA6BSDt2+Hk1pCG05EBPsiAb+/E5kxZFlYFnMleHGnj8OiI6UOfB+?=
 =?us-ascii?Q?S0n1JHJPGkWHt3HDABjzEdbK5lUdxmnrY16om9QmUkCIw2sfXpI9S1UIg3JX?=
 =?us-ascii?Q?GonkowrRkgw0UzgwlnX/3Cwkbl7IGq/9EcooKiIorc/nr1Etbd5Yh7Ll5OMP?=
 =?us-ascii?Q?7LiDOptZH1Kd+XGpHKBIWSLtsdvl0Jebfiwng5dfM/4SFjgvYP769iHuG7KA?=
 =?us-ascii?Q?T9gMQFMsfd09Dy8cNQ71jZhlDzCXEzbP0e07OKEuurS7lEVtsxM9WZyx4kh3?=
 =?us-ascii?Q?9O5KH1prxXsjl9ZezF1WEskB9V6Vx4YtMuisAAOtpeuO+QMEiEvLWpPKcJlh?=
 =?us-ascii?Q?aUvB6hSoMwIJ+4T30Mzy8nhhUHecjv+pnJXU60Nf2Xo+nGmO6LKuvhuZ3Nos?=
 =?us-ascii?Q?Y8p+ghXbNdL5Tpx+hgzl3q2eFwNK5YoNltT7ADBg93QiguT6aIaEFY9Tz97E?=
 =?us-ascii?Q?wDUfpcBdTV1IJaacGRG+N3dh++BWYBGkoDx7bi9axxbBIQLKwLuAPScmZoFM?=
 =?us-ascii?Q?cms6Qhr8vO9jpac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kduE7OF2ruKD9GgObRg2n8dmQi+miSxeAtzM/asMsNAzQYRq+Qr8/lvlfXj+?=
 =?us-ascii?Q?rnOXOFN5P/ta1ITWFGLZ3wdCwoZMoika9ofp3jvxvdd0XcL5BBb1SwgJL2kX?=
 =?us-ascii?Q?Lmv3DwFtfM3eqF29rWHzCEJit0d5zVHpDOYpPgibafYcnsWhfX2R2JP5/X6Z?=
 =?us-ascii?Q?szYTy0btW767fTMLhKvmS9yQf9b7k2TCELKokGVpmVrCH8Emn8h1OfkId9RZ?=
 =?us-ascii?Q?Kri4l4ppFVKtIPC8hqzt5uSekKJo9scj0gF3Mf1jrT+CyB2PCpXzLonVUG+8?=
 =?us-ascii?Q?i/UuAsYasZ+S70vn8tCRMnkjzbDN0Mw8jrOYgYA7+JJSYpsxCJ5SRdxyIkhb?=
 =?us-ascii?Q?3lKyeK9ILBrpUeJ7hUVnQAVhgflqXk7oFcOPDpFmyGVWvjl1XlWE65EZNdf+?=
 =?us-ascii?Q?VtUYnnYm2/6vyOJAd6uFATs1aGkPdqtnyF5m/c+UzOJQN9DYtV0mIqbeawDi?=
 =?us-ascii?Q?rcxFrZ425vKuIcUKVN474cAQea/hFme5MUx/QPX924ElOoCuz+TRpEuAieWI?=
 =?us-ascii?Q?6iqnfkLJ5k/O+e6SRBmTu8UDDlQNiPBQksy7o3l9qSff8edWho3jg4+4zj+8?=
 =?us-ascii?Q?wxOQZeTv4mLkcYhGx46toD3FmfSTg//gnLfIKWrKoE4nmXrJ7p/TqP+6hFrp?=
 =?us-ascii?Q?pNyFaZ1fiQ4AQXNMBNsqAn3AIhWgo27oxDsBuuhHAbaOPJkeOiCjHS/rYXX6?=
 =?us-ascii?Q?t3Db0M37XCVR7Cja4gK/Z6KrYUIDiHEuhEl6awAkupqFXkH3m9AUoRgMwxET?=
 =?us-ascii?Q?1jaeIseCtHNKNr9slA53AWpBsjF9muisrZUkFVdTkWL/rP6IFwir9F7kuBGS?=
 =?us-ascii?Q?TMQ/5sJvzjaLzyW0sY0FEojdgMLh/LfPJjbHutZKX3eiU7+/iyuaG+wgb7Y1?=
 =?us-ascii?Q?HFag1pvja1h5FoMrNdeJFaA33QKeZDrxhtm2YnV+ngo/w8YbfdFuqMrJpMPe?=
 =?us-ascii?Q?p1CDdHqFiKFOebfb0LyhtWumwlfCJOg463BWlK/t5QoGQmxm4bm+rAUcSgcT?=
 =?us-ascii?Q?SDrcC78Nq3Bc5Wk+t+MHqmc1j/YXovZFWKahjECDGlSzhdBAxOSO6OEi5h1W?=
 =?us-ascii?Q?BJNrbZ1SuJJ4MjyxiY1DhylXxkYfX1ahJuNIxPfUesPVf7mTMe2NpUlCl3No?=
 =?us-ascii?Q?5ryoXCXA4F8q9m5Htn2vp2zRhJDqGTmaC7LOfLkI18hOhIZE92nOkhNf9BVr?=
 =?us-ascii?Q?WSMrjO/vqzrjQBqv4YcfvhwNSsaY+EjbDAH1s/58yIhrqeLvDrrvD432amaj?=
 =?us-ascii?Q?i6DCHqgtwYkwrY2DLLR8ZXFxwrEfvlICsfTRVFN7QTN2EkzZC8CNyn2ksfcw?=
 =?us-ascii?Q?Z9db2dE22Qd1ZvBXNlmyJo5rp3U19JCnTYohnAcFGGQ3nxYPVG+5GLzaXpOg?=
 =?us-ascii?Q?/0BuLFeq/JwtwDAS+JAwYSTvGixjQQGl0PlAkLa6nfiRI48zvkY+ebxe5n1D?=
 =?us-ascii?Q?F21ehi0OdeaR8jwTgvpXSS4fRpIry6HKx2QIwPkNDqu6d6PH7pA7qv3rv60u?=
 =?us-ascii?Q?aaxGZoMmKCxLEd6xXoqKKOdhmPzHq2AvzxEuePiN/YFCj26FQDKDFyLIpFCZ?=
 =?us-ascii?Q?fqPfEfd4kqVErNSV8MR9vCQQ4lto77DcXXouwetM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234a6a09-3ade-481c-5e83-08dd7cbec52b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:14:55.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLqi63KBYi7YIqqUut9OYarXpKN6Ry+BlbEglOHfaHooOJbZoXGP9joKw2fwCu5YPL8l2DytaluzNK3plEjuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7103

Add a cold reset toggle for i.MX95 PCIe to align PHY's power-up sequence.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c5871c3d4194..7c60b712480a 100644
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
@@ -1739,6 +1779,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 	},
 	[IMX8MQ_EP] = {
@@ -1792,6 +1833,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.init_phy = imx95_pcie_init_phy,
+		.core_reset = imx95_pcie_core_reset,
 		.epc_features = &imx95_pcie_epc_features,
 		.mode = DW_PCIE_EP_TYPE,
 	},
-- 
2.37.1


