Return-Path: <linux-pci+bounces-25978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB79A8B00F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE243BF1F5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 06:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D6722F39B;
	Wed, 16 Apr 2025 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EA2ck74F"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95322F16C;
	Wed, 16 Apr 2025 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783780; cv=fail; b=JfWMzOYkIE88UeW5fBLY6AeqFAjGgu2p/7aqSl9gEEWdg3Ko7TOzpasyx7JWdH0bEYkCVPg39Nbrigxdbkw8SBrVRN4Sedd5aGuRBjmfM0Cov573fG9ZNmifejOQgHjgWksb5tvB9xy3Y+4vFIP4F41mFr7z3oGXADXN2geRW4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783780; c=relaxed/simple;
	bh=vl7IHnlsKCckjRcbUyhgVQFVgrJ2fCD0n8q4dgniaxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qU6Z6k9DVeN7+vHivdB+WhX2yJ65bPlB7i3gkeHKGEzNTvOKS3nhVHQZaJai44LgpwgSM4bnKHblK5Yq3KKuNEiSUdgd9cP56Axcu4XratEwYd3XRqWjRQ1Sv1SamuuU5cDK9x4PJUtcQ3uZMoa67v7YGGXFtQYEp4WAqzIBsIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EA2ck74F; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBEZxwBPCbIHRbk/rXnF1wuTUkJTkJYqSeb8q4rX0nhjZom9wkGywyFBr4t/g4pLl+SyO7k8px8AL53L3oHXa+9ywexQ7sfP1D4NmWIsduji+hu5UugGYSoTiFTHWayDOKj2OG87V6y70xma96T8wFp2HLdazYZ9wogeV4rOpVipMb+wVjkzEApAk4XjfdkZtu2pm15UMqZVBMrQi2+qMJ2nkWIbwU4t7JzMeLVG1ZnfzPtROZyF+DGwpDukWF1aiACX4dKc734rGb1nwtE9se9cVGQNm2LAzBDFAcyiQbjMWu67mPtet+PvPtfSFyygWyuoCv+c/2X1IepahygF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnwGdEG5qfpvTGMebNhGg1wtFGs1UvPt05cM09AHdDU=;
 b=Mcz7qm16V1/etDjXXCcHwxUwDAqvISw9rGfQamgrJYxAAaSRMv0YFOO1sRYZg6GqsDIm7TAcUeFubtxLAL9QRbsJqi8fy3/NK54JEXduRQrfbDu6LeP4wgiCupYghfi6OKFsec9uI/ElJRay1mQ/5k2USTfaQPPGiGpCwp74U2fftAbD6ezqUGm4GkuR1XCgTQsSN8nfwbWRREoO4iRot5NfXpNUfmstC3w04XZRALS8EuDmHNambDsuj71U81JMzw3C5eOUq0X15NLrC0dEdYLa4Wp5KpL/ih4JBIdkAdTeFJ5jUdxUmC2VdyE0CSOCd8lDPJnYWYW3DFoLpJnBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnwGdEG5qfpvTGMebNhGg1wtFGs1UvPt05cM09AHdDU=;
 b=EA2ck74FwJBkMUyI2x5b7WEMMB8e7ZpGteAsOL4WVOvhMtgJ+OFeJwcfz6ABosNWQokqB66mzI4EgPopLGopElew1h6a7ZStXZh0fdNlmIch64sHWiOVhXaHBsKxNdA+uxeI77hS8CnZKMIdkgs7rE4RUGQX/BXmeHhPhLjHuL2BavF0K/0ImhEjJlPeUFC/gYpW2OM5xxqwrgbjJOFrRpsXbUoR8ly35HUTRweTI6yaKPNZMWmjN0K00RDqK2Mk3yMgAiP9VvLnHCo0iLGg3W57eFcVB6pfkdJpr1HOP+3Riq/tpkZsa/Y1xGJdbHf3RrWJxuspkoBD+0xZ6kcfGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 06:09:35 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:09:35 +0000
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
Subject: [PATCH v6 5/7] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s Receiver Impedance ECN
Date: Wed, 16 Apr 2025 14:06:46 +0800
Message-Id: <20250416060648.3628972-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
References: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb8add1-e0d4-4321-ce04-08dd7cad42d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ip6w0a9LAsYZX0QJuIzuWIHPRwtu7/7P5XO+nMkXgXgeSYTRMzjOPMfmWbX2?=
 =?us-ascii?Q?Up8pR06eyuEy9m0eK44b5y3oxd6F9Fvq+8hHHFE4m9l4sGHLQHH0AKmU+JbH?=
 =?us-ascii?Q?bU+sA7owOVKTcUwNTuf2Ju7IH3F3Xwb52P5V8cKdJ4ss5MS0Lxqvxwcpa03O?=
 =?us-ascii?Q?ux1MuPxKztIRZgC6C77ZcBcOytOkQT6tQdOzqyGdB526O1g6LWR/v2xezIYb?=
 =?us-ascii?Q?d7vP+PFuMs+qnCC+23ZghtwZlQcBBAmP1Nklvyk5GYWGW02xlGLm/olHBoBp?=
 =?us-ascii?Q?rtsKGyLMhfBlfdGxRddNx6DfuQnhJtiUBvYQKXsbQD2BMD7/uHgdMvfEzhdB?=
 =?us-ascii?Q?vkOt1Eal0nv/iVgn8M7zv12FRzFWs/nRFfCtRR4YVkOOQjd5/yucwnM9SmAQ?=
 =?us-ascii?Q?ngiRXg4TBC4AJ6FnFAl6vwub8kHAjZPmns1UtQH0vXT5XCmoybnNSV4Raiiv?=
 =?us-ascii?Q?EuAbdLna0f4W+ZvXlHvoB6hw2FF3Fo11eQ48b2H6IIm3o911OX+LbYVOKsAm?=
 =?us-ascii?Q?P1V9zbbAv4I3BMQk0KC9I9VOftR2AvlihRTyeoQIWYY/GOZKMeRoxnG8hFT5?=
 =?us-ascii?Q?xEfvJLEaLGM07S0mVkCmG1mdlJW/SQcVjcnY61/LYnwGU5fun5cDAQVHFsTb?=
 =?us-ascii?Q?BM8LDnh+jIRuFNJbv9+mFKQb63mgIPH3xeZdoLCpEXpSXL8+CxRcTyo7XYN6?=
 =?us-ascii?Q?F1nMUpPR8acPWAM6Fw6eiwPiGirmiwOOtQ3LbPFHtHbDcGcYKp9d5tPmadcq?=
 =?us-ascii?Q?xXujlnUPXRo0Vef2fnB9Ywj9wQNzyE1tb8mNWTIDNCwKMtUxsSXamTw2yC74?=
 =?us-ascii?Q?wySJhF43FTx30ilDbfv8dDtCXDKCL07f5CMmjr7TB0wltP32TCPxIeAS8czB?=
 =?us-ascii?Q?HXWVbzdJ6k7xa9IyGcLheL1tUQNNIwhsX6Yocr6yvBcfFb1DZAizCDLbECbe?=
 =?us-ascii?Q?2PWHivmc85C5KrzGzH/tGDtcu9agHtQ1AEg2qa6xIZlzjM2QUIune846p1of?=
 =?us-ascii?Q?IXQjsw629zOmmDpxJ3mUnj85P8LP31OAjxtGXSdh+VRr+ZSZTyZGXX5aT+Cf?=
 =?us-ascii?Q?MNYjBU91k6C4uCI5CkEwj4ZPX1GUHUQB7syxrEHW++hV2GLLKYesHrsiAjWP?=
 =?us-ascii?Q?h/3cD0BNv4oMIlAKUBzkqJOIGh2d6Uk7z6W/8fQUK7hZEzeoID4kdG4LPCgY?=
 =?us-ascii?Q?CRsww2FqrX0YBfuF6nuldP9J79zIMDgfEuFUY3JetkxOCUYq06FR8XQxr/gt?=
 =?us-ascii?Q?tB8cWtCRPzhmBdjJAGbi+nGj/tyIVjTtIKoN/weRK3/q1jWsSBPUBAyPx+JS?=
 =?us-ascii?Q?Xk8vCIaO91ykf1aWfoSg6k4mOxbWBM2iQHhttrFVqShF4PWFuTyO7yCjX/zK?=
 =?us-ascii?Q?v/dxkvl/Xhz1vEB9uSPtzU6/6wYdF2WZLQebBZAiy1YEkLYG0mIIOxfUp28l?=
 =?us-ascii?Q?fsjG8qRjYwZRKPIKIQpHBYIJ+hghK35VBYLxpC6BclIj185StqyMNgHqI+N7?=
 =?us-ascii?Q?5MFWNtRsmEENaT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1IQObNsi+kKBkhOrfkJ41MVvBETR7OvP3XlOgQX58/Kk5/osVIlNTpe0D0n?=
 =?us-ascii?Q?2HvwOAzXfLhUYE7ke4kDfKEV+iItPHgGIUHXDXT/6gFO3qtw/cv9v9J4acuO?=
 =?us-ascii?Q?f6iNt0Ak5qM4S4UrvX6eC+XdLJSSju24gL96VhSgkqt4KKVShtpu3TAut5st?=
 =?us-ascii?Q?r7sN3A8W/EiCCETCXSLRojBHlxQ9/Gx4ZBWmoWrK81WQcIXsKEL5h1DeEN3I?=
 =?us-ascii?Q?xiYzOT6eD2KLjzTGoYD+mrljZcEXwWCQhOFQgnKitnQcuuoW8dsioU0oeMlP?=
 =?us-ascii?Q?OnFfAvD0z85CPiW90+PRQ0Ylgn73m0A1GyYajiL2aq/rojUsLyVwLI8kPplY?=
 =?us-ascii?Q?0LBoDi+0tuDqo8Bo8vvZAUL5Bht3VlkI9O/AOUPAqXNzuxc0hCnEZ3ZbTJJ1?=
 =?us-ascii?Q?IPEx5ET4F/vQvTSLu05w3l2ngiICUetn9zjwCx2djBi8FmU5NPaRJgIaD21d?=
 =?us-ascii?Q?e/OLfmPDuXFGaVBcIPLH3rfwU326C6uZtyajS/OCDe4ywSQSkvWxWQC7HP7F?=
 =?us-ascii?Q?E63yQmlkVNn2Hab3W/TLOdsI7ocZ0Qk2c4qZ0ATY2lcGmhF9ACQ/HkR9p272?=
 =?us-ascii?Q?rpO3a8gUh2d2BliS5Lz2USUibCCsq6dL13nJAu28mx5LTU7Kw7weCpiNqmMO?=
 =?us-ascii?Q?vE9HyhE5NMr81Mf2p8wXOJwKweL3KpPpRnkeG9LsROTxJ/06ZrEv4H9Uy47O?=
 =?us-ascii?Q?Fdyhcz3ctACA/cnsLuyV5YwQd+mWo2pea+UhsBUkeki0V3CkA9/oAEH2QSyH?=
 =?us-ascii?Q?cvoHhIpGl1qqrScErTkiMHFlnPLiSFCrMZ5isQ4L89jE7QeSp4ZrPfvfW2qo?=
 =?us-ascii?Q?Db7Cc7/1gzbsOEHl5APTeBc0MftXBsv6br07sbhAolcjl1rcP5hrrEOnipz6?=
 =?us-ascii?Q?yc65ob3SfGTk+Jre7nU0mNFLMXlhyiBJt5RsF115HOlVz5JQB8MYBehsQoeZ?=
 =?us-ascii?Q?8UJsKwSrRw3tDygBNpCacfKgZdssye/FzQRw8OCl2YlBeNPDHj8Z1LKfCD6T?=
 =?us-ascii?Q?C+mZzbGNgcsT2sklZ2jjd/a3hzD5zGSyTdG676W7E3UpE7Q7bFf2A+ALInxH?=
 =?us-ascii?Q?othxWTgHy/ooICQA6OYVj8cm2f4//LO6gaeo4mWc+NMim/K4vMc0eh7DRtmq?=
 =?us-ascii?Q?d65ROKUpmgl666hwwTzR/giPuWzeKbHeMLUZit0lOprHe5vxDaxxuBRc0JdO?=
 =?us-ascii?Q?stSXEteQVb1P2ngTLrnjPq5KKFzsOrN0XE5CQJKh3KIFdUStPaTpLqbvjM7I?=
 =?us-ascii?Q?XLl8b6i4DoBXlg42wLdvayRlxrSyx8CDqUh4yJV/opLNrfb/Pc4FEIz936pk?=
 =?us-ascii?Q?urlRYpOnY70nDVDcW9VXHo6LmF/2EtE0Ge8Q9mipUwvrPMYu5iQXoxRhisJX?=
 =?us-ascii?Q?F3kTobk59g0SrdvUHSgeGts+xAgrbELOPGK3nhRDj8pDZ0wNUy2pSr0SJozI?=
 =?us-ascii?Q?xU1db/pJ6YW+Lv8M8YjYjExg4gA0lxby1nWmThzuX2s78aAsU8koG056Ickh?=
 =?us-ascii?Q?XC/1fPnUYDbYow81zfUiYzNk9L6CJPf2FV45N0NzZHoxGfXakscFvZlfwmIs?=
 =?us-ascii?Q?KtYiRd4jpQyzoTwgDlNiIGlACVzctCfVOxnQRBM+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb8add1-e0d4-4321-ce04-08dd7cad42d9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 06:09:35.1685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SFuSxm5R4Ol9vEX/iGiQ2+85SOf4CYYrvsxQhqYb/3S6EXVpLLFRA9d++7PdvseGjZq6ygCbIh8BTVxXcPufw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

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


