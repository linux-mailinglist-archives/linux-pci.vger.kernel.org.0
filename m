Return-Path: <linux-pci+bounces-25468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFACA7F2FA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 05:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2663B7041
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 03:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D1F25F7BF;
	Tue,  8 Apr 2025 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BjDY/CmL"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79B238D2D;
	Tue,  8 Apr 2025 03:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081275; cv=fail; b=t5LoyHtK47Ez3jun0zo1l0uBpIw/7hq7McnDv870zVnnlvxdayqId3xMKMxTyOfN4DFl0VENJ295fgNP0quVJ+ndlrVchvoV6optlC8OQLEAW73TwJyYKfK80Kx2qED9w+RMwUxwhTaePJsZFbqTTBVaUEO6hVxMVFCi/LKICc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081275; c=relaxed/simple;
	bh=1QkVSpT0zTaAJ5qscFHrAvV2+xSXBx7wE6DvdFOJ5pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=biMeD7v7Uwgt/5Rgs0QsMUV3U/AQXDHigx1AgXCpXS1s582Ngo7Hwd1fJ4kalkizkqvGooDv0Mv/oA6UFwQEKjyeoUOBTl/pCff4u54YC1uo2dnLH3yOIkUWkUPZ29Uzoh0Y7UCCWLis7uCZ3eG+qqLCG5UZ6ccSt8vlgSXgmbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BjDY/CmL; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdzdZTpKHQO0biUoxKIsrnmkS06O1fS0NX9ii+NtuGkWX06wdP4/7Tr+o+QTIxUHp6pjbffL5SUuYKL2jSt5IH2FhAGc17XO1u9OYrhyvdri9XFox/8k3BtZoXucWD2Pdd1DCukFeTOxtwD6pkymQMsWCIDhWHP5fjeH9wGeVfmYF7S3u+Edia2ejZMT3MDlBXNEk8PyBVwBSZ6lEYpV2MURuvLrmaFt22LvqpPw1BQSKqvYbVUjY5Qmcv6ll926SzXuPPKyJHpc155AYi6l7/8X39MuoUgqT3YZsvAb+Gka2q0gDC4//AcDs4BTy6932cI84UlCCc/4EqDOxKsXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzJ+4AuRn2P5jpXCGDnX1KId/yylUIGQK13gqDzlVjs=;
 b=QtCVrJHZOcVWdIScceWQBoqGOEyb6XQOft1JyyGyS45lORrh/jUzfs+edufWOiPNfs3w54sNn1/hnrw8pKpmwHV1K/Yg6/1nrGdQd6j7CXRDoFbyEyvIjXQLKBtzp0Jva5XruSGhAOBbd66ImlQJR+HnIf0Oanf+5Ws7H4KmjZWZhyIK9ZvF57ZBM/63Bc3DtK3brh87l7gycrYdXNaUW7+/cQeL1j1mOUQCeownUg8YzFJqMWu8DJ1YjgrSnTC5q0BkqG+kkHBl5znud3twXFJ+A0iB7C2vAo+qZfcwNNv16Of/yByzH3gpgo2zgE/ls8FW1BSsG8IBIv0WTf7dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzJ+4AuRn2P5jpXCGDnX1KId/yylUIGQK13gqDzlVjs=;
 b=BjDY/CmL5yaYitqT3jk5QUgpLri2s+Q0DJc8+cvIv0VINa5l2RbkOqfJmUbZCz1DIG+1HF89/fJsL2ZnVSJgZmbE/8cl9bg9ivNygiW0lVLXHEc3emRX/eFtw5uk1iE2GCUH/SeAxd/rxtKJlDss3lK4Qx6ykb19jcvnCQ/d5OtiGzj3WZCEtrZ6dGPv/OSRnGZkPkGMb0mp7uEUfgIaQscMswfXPz6k3slOaQF1WfGPaxvgAnXE4zIRv2JI4VfjUpYwR1NACiYxBrRFs32Z3U7DkNNtwjZExBofVH999TtuNB6/I/RckH3yyQ/V1i2TVk7yFW3sX7H3qNjz0sy8mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 03:01:11 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 03:01:11 +0000
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
Subject: [PATCH v5 4/7] PCI: imx6: Workaround i.MX95 PCIe may not exit L23 ready
Date: Tue,  8 Apr 2025 10:59:27 +0800
Message-Id: <20250408025930.1863551-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA4PR04MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 49506467-6623-410f-77ff-08dd76499dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KyMqDYh2W+elybYYT/JLmXWmGJbVunqsR7luwcum1KNF0ZjfR8VayjQON12Z?=
 =?us-ascii?Q?e0nN1jetoZmxj849qONBe2zNoif9eGmk5nkDuGEb5jdM2Ii76rxQVU7MBJ2I?=
 =?us-ascii?Q?VWRsJjHrJKdIqtsnRZDwam4L1ytVsj3HU2Z30Bx4mBNPJSANnqje6K6YpiFc?=
 =?us-ascii?Q?2Xw37drH43uaWYT0ZcmIuHqkDzEvmMDxPbARpm+dSKIu0Wk5hfQhCBSg/New?=
 =?us-ascii?Q?YB3GiUH/tE+0np947o2+P+Ag22Ai08yAf6CmLLL7KT5XCrOCfrduskfIzx7U?=
 =?us-ascii?Q?/EPmoMfwmYeMugy6B6I0/P0Kyvf03ywDoGXy6LrZgoZSQAi+qzkDNdtt0hfr?=
 =?us-ascii?Q?Z0adDT7aqr1srvMs8jZzzL+AkRww2s8LR3MPolaMtfF5NPyTDwCeRQ7ORTf2?=
 =?us-ascii?Q?CZJjGntWx/QoW0/ReJy5v7xdB7w1UqVQRldkh5jAzI3Fc1/R5qOE93FweT2S?=
 =?us-ascii?Q?gUu/J6f+mrTeqQvfq6EKqf+eH0bnFq2pE7GU8I/8QJi0RIkv+BXvL8xBIL2C?=
 =?us-ascii?Q?IwvOqknq0k/J+M50sxJo3o7CBjbvWNl1a2wCSJOUgnNZECigumiL7slrWx13?=
 =?us-ascii?Q?pNxdlKFtaKob5Eq3pdxEiIaXTgSF5FbyPbao7KSx0DPlBQCpsxqiN2Tzvb/T?=
 =?us-ascii?Q?iaBX5tf5TdIB/vql3jbI3Z7/kI5l8f608kgtLEzR8cuiwxE2BrOSkrgmwmtP?=
 =?us-ascii?Q?BJVrN+dWDeo79eco5VV7kitR4JJjQ8eTRdK/It1ScwPURmy18I3L3XU5ZZxo?=
 =?us-ascii?Q?0hFIYmE2m06qJab7OOuTlDaspalM+9SDPcni4iWbTeHdI2foVGtv9dDyhEDd?=
 =?us-ascii?Q?uVkK+oZE0oOvPxT88HZx/GxzzgyjTw0C79EOvP+XwJ2qja9pEPWL7cgkCLdN?=
 =?us-ascii?Q?b0MYeuqEu1GTm7tOd+m+F6gDsPkNEi8nf+IzaDlvOCARDbCUVU95JQi9KLgG?=
 =?us-ascii?Q?B1b3q2ksWRpIkZuFCaUS66Gd+7k3+P4CksRcRQlLoOfLKJN/GZ30jemHPV5E?=
 =?us-ascii?Q?gmqjOybfI/+LIbUcAnsXID+04hNhieLOnotp4s6QIaZDeiZccHUWQ+kdvDNQ?=
 =?us-ascii?Q?twSKCAorEf6jLbCcu/g5q1CbAKj/j0Cxg+IXY8S+JtcqZYbNABHYsoYO+k3s?=
 =?us-ascii?Q?Tktn7N9+oatNmcACpkJxuBzkTFKR7MBah+czxuFlk73saiV4E9PJhj/2xdbu?=
 =?us-ascii?Q?epE/sQ7Yk5RHovBjAeXTAg5qE5EAK4M38QoSO73P1NS6i7zZAmtV3kSrTmFL?=
 =?us-ascii?Q?TfYDoqxgBiU7H/7bx5ySBK9iCxuMOMtT2ybLXg2eIkCl/nBYHbq4Bk1Vbj4/?=
 =?us-ascii?Q?u51I18tdJbXJ8m/3NjAQdcyeVHN+ri7wknE9HwnGM0lwQ4KcNbbPiJ6A6PQi?=
 =?us-ascii?Q?gd1+UArerlIXLUwI+xQ62a7I2ijsWw+CBBhCsuk0D7goTBEoIMmWzCx4w8xS?=
 =?us-ascii?Q?f/YzroJbpowiXbBIY6A77R1v/IzR+rkYK5H+gOP2jztw39LK/RYmSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k4LJkJqUKhB0Jr03/JBKOLP9gYQeGsvkqGdpmwcIUSPjQAQu5WfNNPiErljl?=
 =?us-ascii?Q?w9daqiK8EpRo+UNBdmvJIcKKP3GlW8RPe2Bvx/zbGirEx4uDo/uYp+k72oyG?=
 =?us-ascii?Q?Ru/hRj8V3l+qf5G5ouQ0pu9Rukp9dk4RcT0uFX2uIGpEG0FdkzQ9wY8FQ5JJ?=
 =?us-ascii?Q?VOWbxELveFPeNev+itGAtJnxvAoshmMzrzd3mULhv7AZpyTJBICmtYI98sVP?=
 =?us-ascii?Q?XIzX79NErogMgNZVww7HXUjUAuBFZMH/qZM5SWebReNmin6BQtH6wfriG3ar?=
 =?us-ascii?Q?MYX/dPs7aDvDhtLe/MrS4jcX9B9HrdVV9+9fHVpVr9plI75exLxBt0GqqIKV?=
 =?us-ascii?Q?SpDYDgtqLYCiZFEgVKU5OblAEHD3ZD9ltij2s88FZMji/37u12i7EhfZ9wDf?=
 =?us-ascii?Q?vXdPPmVoUdmqmAdjpPx+YLe8r08gBJ+DFcyfy0bAjhAOl82i4Z7zF1/iR3bq?=
 =?us-ascii?Q?/bC0ZfVMor3VeHlENl/IKtV0dSaHQQaXhUfKDavllaDyc5tPdG6nwBUwAeLt?=
 =?us-ascii?Q?KVZ+BF+6EFcjMrMifHxZEmhHzuTmylfQGl8Xdwewa+0dnUZPGXduOoBLeQZj?=
 =?us-ascii?Q?udymtnY9MPEupZRvFewBBgNgMesoE/RyaZALqri341UfDeftD5ZZKpKxwWZO?=
 =?us-ascii?Q?TCVoqrXeSaeGT7zAaQNo9UeEPwGMExm/mkyjzADZCXX5qB45ZJ1albAlpxIT?=
 =?us-ascii?Q?hMc4iuHFthD8XMxR3uCUscKgsAAxBcHoSFjb7Yp1GNtYPeCt7cwrh/upra0v?=
 =?us-ascii?Q?rFQMuvIzrv/zeZNdiHQQJNccbI9AKQvu6WtpCKTr1OR8fS5X1onCnN2Ow9Y5?=
 =?us-ascii?Q?p2EW34AMHJDL1BfP6xBShKqV5qfSAqV9zGbvDgSs16lKn02paV4lgYR42Gk3?=
 =?us-ascii?Q?pY2WwVDtYOVNYHzR5QozsRxjMdxy7Y7MHXzlhjA/PJHAn9oK/LjmYemcTcou?=
 =?us-ascii?Q?DT3+gXOX9yrv23IUirc3IueKuOsICT0asU8UU2EzJnIpLTr4x+eCVqy5vZer?=
 =?us-ascii?Q?vRhthjWl++1LHryA42WIbOyUKtDViac/jlsRWnHbybFmlvzAz5BNpbEFlgRv?=
 =?us-ascii?Q?dLpzrm0iLq4o4Tfsgu6iQZO6v9GohiQrYas5S43/w4xrhg1tNQ+YSm9T572l?=
 =?us-ascii?Q?zNXDPPW5CvIs5ewZ4Q53tLt+3lh9s36t+jY/z9UdYnY3AjvwL4/yHdob/QD3?=
 =?us-ascii?Q?X3wSO1HGx3/1IaofxwMjZeajiEzDoVAKrl+ctkcyNtWcs0Hd/35cWkcjfu3L?=
 =?us-ascii?Q?GNQr7b1J/Qr43j59c3+UEn0SCp4XN+wgwcaq/kCUwWNmeYjaYVmglCU2sQkV?=
 =?us-ascii?Q?qwQFR3/wA8ystgRYVMaNlGtCwohrsurlhK/foVnueu5Mtex/qbfrzsTRCouD?=
 =?us-ascii?Q?L67mjdUtewq9iKGOTs3lbVImhuw7EkDUuoToS5sB56STC0AZ0oTMJK9+uuhn?=
 =?us-ascii?Q?OoX1uhP1R5dLQ8ShRox0JomWo2n/v9jDYq+HpMPHcOkw5kxE3Pz55wWirUdl?=
 =?us-ascii?Q?j4nyP7dr7QS+gg55HePsuDMt5aWjeWbMVISrnIJuMW2tFUjFpQD+ispCcHG7?=
 =?us-ascii?Q?ggqHN6sI/xjdBq8f2kphUl/pQMXG115eYRHUi/GY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49506467-6623-410f-77ff-08dd76499dc8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:01:11.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cm6k+EFtLpS2byDEZvmkfRmk2JLrE9c7qY1JAIPQnYoi9/DE7ZoNIuhjysqrSfEqGI0ppdj8nuhJHKCK66hRgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536

ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
or PERST# De-assertion

When the auxiliary power is not available, the controller cannot exit from
L23 Ready with beacon or PERST# de-assertion when main power is not
removed.

Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7c60b712480a..016b86add959 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -48,6 +48,8 @@
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+#define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
 #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
@@ -227,6 +229,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	/*
+	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
+	 * Through Beacon or PERST# De-assertion
+	 *
+	 * When the auxiliary power is not available, the controller
+	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
+	 * when main power is not removed.
+	 *
+	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+	 */
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			IMX95_PCIE_SYS_AUX_PWR_DET);
+
 	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			IMX95_PCIE_SS_RW_REG_0,
 			IMX95_PCIE_PHY_CR_PARA_SEL,
-- 
2.37.1


