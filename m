Return-Path: <linux-pci+bounces-25989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1561A8B319
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615974445B6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC7D230BC6;
	Wed, 16 Apr 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QtAtXDgD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969423371A;
	Wed, 16 Apr 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791319; cv=fail; b=U5OWizVDjVprrpLlyRDk/0bvFZtsacMG3f8N5fk9bUVjYrP4WIGrk9RdPvad+ZF3S5oiXblJ7gv8C0xtH0AUYZLNkeoUntVijUH0vgyNA0hBSbXKJA7X2gGFDTE6lN6Lt3wPg5W+WHqhVED/qWEVH2Ky0rYlmKqxfliMKGhcq0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791319; c=relaxed/simple;
	bh=4CIjgItRseUrafBnGXNZaQegYkLZQBw6fsBMX1uKC2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jgbwW3DwsPvN7olk/yof5nkOQQr0DRCY86xmgkW2Yg1CW3coqRaR8+vmyBuchv3PgXCyxsKxwRPXZUuy9mYPtyVjaNe5Oyz2xxmMvaFhAdLFbKYcwtDwtPC/Sbwiky6zbKHQV9EEtBRI3L5O3fbU0Ups9KGJxrhF567JXLFNdX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QtAtXDgD; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYKMvnoQN6k0lQ44NB7rHtm3eMrMQXv0YNf6kTlHij1TyvLVjIDyQytNR1b7G+kYwY3r68N1NynWc5EdvQPudWEIyrpKDUfsFl/KzqaihSiysau9heNx7YJIbcXw5Cmpo3tUJUOTV0Ry6444fAcp1mXMaJkZ33g46vcwZlUxpd0t9GJAw+3enpdmwKTmJYS/Y1xfLUxFGUEBOcZyxeRnNlSizE5LdoL9VtseCh7NxYYikp/wwsOpAaxyx5uGh9MlYNS+ofsCByWxOzv9yusyVhGP1BY19KK/tqoe+F3pmppG8Wftps3csI1lwUZVx6MAtCK6fZymfz3e7AXBygWZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mi6mKBl9wSEkHCFGJZSabU9nI902sgwAi74QsJHvFMQ=;
 b=FhjkU1YRLkZF4f7MhPZfVpcAGjR70v4fVH/SLMF3v8WL47L/1tGObJDpDgAQbiRcEpWULcz4m4d6otTOOjsXwh860poC4RQ0ChMiIDpM0JaEvQ8w6/p81AvrMNUQOc0zPCiDmjlfmJi022fX1n3BnTu7oy4PUt/9F9ynSSUnLwMgXgZOhKWXhGBho27EQuv19u+/Ikkn++axZxCq+fJ/JjJoFcLnKWMaurBtdqUJsGzFheoyMyh944iFkTar0wUFHRIEbiEohodUhI6IOULFB56FVGv4zmkVmuPwnLRIU06BC+aMa1zSi82aJ1hzoyb1kmdm1kkbB9HuVjugLogVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi6mKBl9wSEkHCFGJZSabU9nI902sgwAi74QsJHvFMQ=;
 b=QtAtXDgDNvRBGdsPNRNRN3mM0V8q1djmTH+Yz07Od3B8dvSv5/530UCfHVY2ARmEQ1Lfx+SYQ8HV3xot78yXIVFcpCbuvs1m1kX9XD8Y64ybTj0CtvDN+KIsu8f6V+KnjrRLbqstHTzHJRIR/sXqFDsg5nhrET+RV3IMxNCKBlYbGxg1DYsKkG++3UV8ZtQyXcsQSmGeP89LSxqoxie2sECSY32cKLhUKhmVr1I3nSD7HRx33mYvodrLlhjGP9D195rI4jF0uHD3/LKpas0bMvg71RquBAvzoznnnqW4m3QMW/jxAT2XO2vavHnqlHc8+WGAuMbVwohUT30PPzBHwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8716.eurprd04.prod.outlook.com (2603:10a6:20b:43f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 08:15:15 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:15:15 +0000
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
Subject: [PATCH RESEND v6 7/7] PCI: imx6: Save and restore the LUT setting for i.MX95 PCIe
Date: Wed, 16 Apr 2025 16:13:14 +0800
Message-Id: <20250416081314.3929794-8-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39d6290e-9498-49e0-3129-08dd7cbed119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DzRRpvNRgvRLV+YBwEHwQ7rbnz1SItjIa8/NAj739q7fGtAVKfEKL0g0HMgP?=
 =?us-ascii?Q?/Hm5ZAVpidK8Q5bZqYFtNNEr5tXa1Aoj43B67MTn0ZdYRLVhmaeFyOGfoLQg?=
 =?us-ascii?Q?qJONOxtWq6GUO2ObfqU82ix7G5nzOB6Ew6qzHmNxJKfRfko4ZbDvWqEjaALz?=
 =?us-ascii?Q?0pUibCsKTaHy80Cugcn8zZb03rVOROmIUArQh/nBI7NWVtCsLMacf8CRF3UT?=
 =?us-ascii?Q?+ViRG7Hf+v69OJhmvYbrzuvsp3xMe7Qf7CTwhGbZL6IVg5N6d1qGYYRNwhHQ?=
 =?us-ascii?Q?9kIW0BQN8xdCrn1wH1JdkWCo2UFHAX/IdWcv0xEfFzvo07qWSg+sMNTsNHZH?=
 =?us-ascii?Q?1LYZSfQQsyMNqBOpvDCdAyjCn4LA2GLTUnaYKAKjRYkIz128IVouKoptdejm?=
 =?us-ascii?Q?X08NtyS3KfmEBtcabH24MFTeYxvbvnTxwosJf1aWS0FjaMlEEmda4B3o1qiK?=
 =?us-ascii?Q?pUUIItjEcVpiLp7+xvjYzhfug+CbmIc+mDrDt9LONGfA8qEAmKoDZr0uy2P2?=
 =?us-ascii?Q?MouFFGdrCBc+4DPWf6GBCReoxDAsusmaOBMwZMOWxIEOj4PeqQUqFM4nuMkH?=
 =?us-ascii?Q?SrMjlo2QNQu9+lTuYen5qtt63fHyMxd3Ox5D9NW7CNEy0q5ovs44b5JUbhyd?=
 =?us-ascii?Q?i7mXO3XLCCNaRD6yHR/UPncHh3VedbXQcb1o2sDJJM13we4O9Ijxx6ND3VGc?=
 =?us-ascii?Q?SFNxWuulByTyYUDiJ/sR68HY/AuELPj6oBqpdgHbTNlrjYHYggq4WAXRt7ZE?=
 =?us-ascii?Q?0Ea345nK8lLK2qVrd1Je5zNEdNLJxKODP8KRiQY64x5MMjWm0FPmdp5fPJ9f?=
 =?us-ascii?Q?Fmx8feq2IXo/h0uG2lOEdlTOOJW+D0zsiM22bBd/Mk91AiUhtowMNyrCVPiZ?=
 =?us-ascii?Q?HWc0uejR3DfTlBopVfrLXU2N0q1X9j/Ok6r66X6VS0Hh1knguaWFO/k81rbm?=
 =?us-ascii?Q?kVfHmpnhOTlGyw2MmWYzfmzN6JYYL+fVhZ43zr+snE6xPeF78rSk0CJhjw19?=
 =?us-ascii?Q?XUfuU4zjEHqN0T4I6kWVBy2wzeEWsi5M8FLD53qc7Sgz4giBl5ohOYDG4ncj?=
 =?us-ascii?Q?2gQgMgsHEiIK7iQRrI3hUXHmD8547ffbsm3pb4+gubT4/VyhIoZhzcUEcmGH?=
 =?us-ascii?Q?Qpbg1/xEHFyNW2uHBL5CSPS7isk7t6StiyAj1ux4KFGw8R6j86d4+oU544q9?=
 =?us-ascii?Q?xfdWS542J49sLJdskn8x49lis/sAkYhFMsFMuJZ0PT/mO7Gw349sgMtZAnrm?=
 =?us-ascii?Q?AmHgi3vyTV9ul/mWG2GUAaxlsJwgqzb7UHHBU0LGQ964Wu8wKKM9HysxTx/Z?=
 =?us-ascii?Q?MkO4dsUjHkH88dp+Av4BGlJtzHyv5rny1I+uZgKKcqANZlsAJhl02chbh4N6?=
 =?us-ascii?Q?2wjTDcqwiZjSrc5KdsWMBXgHbg9r5YqJaZGzqF7p76C1rwYRcp6v5As4CRxw?=
 =?us-ascii?Q?mnUDGZe3YWB7g0mK7oFaxF12BHC4+rMUUkMsDhgNov0MN4tsZ65yMc22577A?=
 =?us-ascii?Q?X8Fl6Fcbv39No+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yaxOP8MTpYVYMHlRFco0CUXXZ+XU3yUnvKb50rFZJ17R+Ds9qHz6r9n70yE1?=
 =?us-ascii?Q?cAaTx0Pcw7IgGzvuazC4G7Okj/tA9U2hhy5CNTnGH2OJb/z7ItOSCwW/bmvk?=
 =?us-ascii?Q?C/HiG7DyGuWNSI6vPc8tnksWCkCrp/Uq/8p7AwsbVFBZYzCqJH7tPXSq2lN7?=
 =?us-ascii?Q?NO0q0jCMawF1EMpqIzXHsi+WFt37gEPJqmVqDc3r/iuzzsDYPr+sb7iEPy22?=
 =?us-ascii?Q?UrK5BT0ksgK1UAodDU7nrPHejaGc7duCHBqZcScw4X9e4gN4lIyl4m+xpAkG?=
 =?us-ascii?Q?fwoZIU0gaZM2Ygf580fVIe7ioAJ/gfDlGHRINx1JRxgCrXis9B0teONEwND6?=
 =?us-ascii?Q?cBfpkL9nqsmadkIhGtVX3QVGlBi/Ul/eVngEsC5MgVWc+20MwYW+3MnHnEs/?=
 =?us-ascii?Q?PhbWmoI6DmNYbyvSHLQqnGDqGB8TJQS0THxmID210vNINtfrpKtAP03JLNR4?=
 =?us-ascii?Q?UbwN8rnZcsmOxYnFqVTe7EpQkR5tDzo4+kRzSAV5dxz7OcatcQhNZlA9E4Yp?=
 =?us-ascii?Q?+b55HEUDlVdM/C3Dq4eeG5Dlb+QVcLwLkiv6c5I4N6ts/VDZbIrmuJq3hnpQ?=
 =?us-ascii?Q?bsqdPMdwpZhakFEEJuCrkJYdHUinmHHFJ5A1tOpS5/US75d3lLccv4iZqfCj?=
 =?us-ascii?Q?tRXRIRMbFme5wG2ogVC3pp9xklmdAof3V1mmrr6nRIgT6yuqktZmLz6IRtEv?=
 =?us-ascii?Q?7W9n4DkD0nEJ8qJMaJpIX5F+UrK71mHD8FFFuUtrKfrsUS0QuRh7r3lNFwO5?=
 =?us-ascii?Q?pvptx2H63pWF9PyoqwI9FK6N0A7eblqUCXuH3XQNgN9PauzmYGMignGkBRg2?=
 =?us-ascii?Q?8KHrXkczxFAPEI2jIR/+eeVlyf/WFgwn38RKBqgGJWngln+T0r4V8zd/AXZP?=
 =?us-ascii?Q?qlon1dctY1u8FZzYlZD36ACfhKWot8JBRXDU4Cu6pRI1lfzlTpbJwcEJgNbF?=
 =?us-ascii?Q?serzoo2py8NqtoizAOZjISql5zlQCLnaW8eyLBdccansnQlvMaJ60Cp79Dc1?=
 =?us-ascii?Q?QDdEGK/iHg7FZjBP+M4iJYwY81sf+GYTr/Ahtvkepm/dowWnbaCUAeBEF+oK?=
 =?us-ascii?Q?XGxl3MLg0B5kprBS72N9fim7pDjFyhEWE5BbqY+eeYUvscjnqGBZC7rTdz5D?=
 =?us-ascii?Q?yuJ3wMR8dRkP8Q2FDopP+s1OeIqP87HkDytEnGoK3RMUREqCR2SKioWqtHN+?=
 =?us-ascii?Q?AnkqzGdESXTI9BdDavT0nZOU8w0s/UxZW1bBG8kTL8sNcPjuz+DMtkea5Q7w?=
 =?us-ascii?Q?L6Kp+Hkpz/bXXLNv37z18GLkBOQaXmzixpJT36S1Ed28Uj6dxKlVfQUzU1ux?=
 =?us-ascii?Q?yqLzVAqCFGwwE4uuv6R+yPKkixNHHVEYSCaSH4rggjEksN/MYJf/+aVj3svY?=
 =?us-ascii?Q?ojgxbpwtPk5dWn7gdQedVl236h2vnCa291Iz/v398NSILyDGnGfDxkBcN44c?=
 =?us-ascii?Q?bokcgasdceED7nW9gcASSQzxR1GcDWnbQOhoui3AiQZGF/WzGtfk9+hGkoym?=
 =?us-ascii?Q?y9HZ/cnKjHO6YPCZPAfjaO50oIC5G2fI6akNjsufeLwjC4OKhjBphh0Zl7v7?=
 =?us-ascii?Q?tvsbwhjny17mrvxt3Za/7Qi0OiSlPXU0mJ7uzEPT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d6290e-9498-49e0-3129-08dd7cbed119
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:15:15.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2x/l2XDNtks5vLM+bf8/sGE+hwG6M74CdhbDqq3/Lw8jufvm5ibt9wwzQIa+EiKtOTbcWAexVFHF3SIA/Mujw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8716

The look up table(LUT) setting would be lost during PCIe suspend on i.MX95.

To ensure proper functionality after resume, save and restore the LUT
setting in suspend and resume operations.

Fixes: 9d6b1bd6b3c8 ("PCI: imx6: Add i.MX8MQ, i.MX8Q and i.MX95 PM support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4cff66794990..5a38cfaf989b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -139,6 +139,11 @@ struct imx_pcie_drvdata {
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
@@ -158,6 +163,8 @@ struct imx_pcie {
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
+	/* LUT data for pcie */
+	struct imx_lut_data	luts[IMX95_MAX_LUT];
 	/* power domain for pcie */
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
@@ -1484,6 +1491,42 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
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
@@ -1492,6 +1535,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save(imx_pcie);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
 		/*
 		 * The minimum for a workaround would be to set PERST# and to
@@ -1536,6 +1581,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		if (ret)
 			return ret;
 	}
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
 
 	return 0;
-- 
2.37.1


