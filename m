Return-Path: <linux-pci+bounces-25473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324BDA7F54B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 08:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DFB1895D57
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 06:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19C425F7AF;
	Tue,  8 Apr 2025 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N2B+A0+x"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816CB207DE6;
	Tue,  8 Apr 2025 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095242; cv=fail; b=rcYiPxO3IWhRxgPN8WSKD4pPpWN3q6m6GgpDS7a0zq2ycj4S8kKUavOVL7IBdtIj5CX7xTT7WBDOEm339d4BSem/G+b7FVtpzFdDixe4G0P5TxnqpAWFfsevcx8HL5cPol62W2HW1e45BJaQg+CYEvmI2qnt+Tit97xekHKU3Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095242; c=relaxed/simple;
	bh=sQJMldnOKpNiPZS///wtx93CcbBvAb2+n02SmQA8Epg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jKl1YjLCFMDOIwL0/NWJdfFXnpqn63kA5bsB3iDnMblTsqi6QarU6aD4PQRA0RTnNF/+nO7hEJGGWQ3r3MN8cY9jGWt5+1AD0J2apedTtxK6O08F5W1BRCJ4UROp7cbFWIGJf7cOGGyU1/rYV62f820XQzlGGaN5VUFUEZD7m0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N2B+A0+x; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FD/YF/UgB0bKnhowwQKPe+AyqccOI/D1d9AKG3l9IBetUjVHNxrvqSHwX4MCm2+qz4d4L6cwG3DGVqPrCzLFnGV0iZX5sKFgW48WZ2zgoBoS8Enf8lpgwdr1XFRIZqL09g7mIqgC1gmAk/KN3qb33OguWI/iVvc4KRUy+2KfkxEse3FuhyTBBs/SJYK/JOTdnHUZAh30YgjWkLQuk/R4vKtWY32iCZyR+1LVHKTcKKa+mbu99RkLJV5Zbgm5E5fL1XgyjXCpl50Q9ueN1Gi1zWw740b2Tk0eAGiJC/rGKA42/7obcmrZTDsmD1ri/LDaBSiG1aYR+VNNPnS1bh/Kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7ywLpwfPKI54Heoid/+aKn5oeu1MKqyrNKlAMLfyRc=;
 b=FZ6EB68fu2kXsUcU7hzYNVIh2t/ZKQ/JhDIi6XuboWpaQDNbMAndyOXELpdZhV8gt0MFSwakct6evlf5EEUMQkX6cQW9aAlHgoujmaXMiB0LdEQ8DvvbVeMfdwbnU5mixGz/a+IHTFVMrZ3GBnoaA7Hxc4c6f2JQabdy1L11z9nqhX6GLJ4JcHJcCV4SXwmw6pQxlvtLaIfGpxAd97bkLmSXtsHM+FXEcekalphf+V+qiG3rSzFi4+vSr4ETewbpj6OEgkG+uG+XlnxJIuZGA09X6M0FvfjFpS5MFVH3Bg3CL3Ei3F+Y01jAPXXbvg5nRFyGOQnB9ky54zvVLfxfPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7ywLpwfPKI54Heoid/+aKn5oeu1MKqyrNKlAMLfyRc=;
 b=N2B+A0+x86Zys0hJ+7dZHz2myO9g7Uj0PQTn68Odd1HiqWNFVsvL/9LLGFdY09kt00WtZO7BF/Hn72cAa3mOJQJpPI6Fuvs66SUv3XSO+3oHxpKdH9cRA7dVmIZaTb2IyAm/pAWGcHc/jtgD/Vl1Yj09nlTqNz4No8q4TlWZQXtvYYdPr1TNY53gwQGuZLFVbhlOWCtW3yNd41igUfQa2WVjJgPVyLJpBisP4iV+iu1fMbWGl2IOG8Zey+KyBTrv9+0cd9ex5HzKoF6r44BVt5hN4x8iE7Pchcd7GaDJ6YOyerA1oYHW6P3oZxZ8abKBEEZS6v2KQpwDS9O/P0Rzag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8309.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 06:53:57 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:53:57 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	frank.li@nxp.com,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Add quirks to proceed PME handshake in DWC PM
Date: Tue,  8 Apr 2025 14:52:17 +0800
Message-Id: <20250408065221.1941928-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f1ad5b-6f21-4434-164d-08dd766a2258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q5RbD0u4KzRtTwwDomX/M7/1LmCPjyYehq+X1wpsDbtYYWts2dp+BTMDw+YN?=
 =?us-ascii?Q?F8GLa7Fdwwva/WhqnUmMVxAbe4o73O9o0p9S0ns6JiujpspgYpzJvasIphxP?=
 =?us-ascii?Q?3R1/SlxVk98KMLbQXrxE1yTs4jFQ9U3KGolCxpfRkVg8SQnx9Cnt1O0MvA3Q?=
 =?us-ascii?Q?1CHu7y9sVoQ+YnIpR9kzwzloXrVGaQmA+NoiClMRsZGkzy17DtWpQeabf1ZC?=
 =?us-ascii?Q?EmIm+xhBnSNv/7iBJZs78PwoDlRIfqBFHeD+bufoH5fhYVUUvscqLFW2B1Ap?=
 =?us-ascii?Q?Fe+Izdv2UDLBAC/Jk3Z0OtM8QWSKZ1A7O2OWSwrQ8tMTDu8mMLneElYQLG6y?=
 =?us-ascii?Q?5PPshsDiKhWSoiqUmGZxKF64DBu8SfgPaX1iXm5/wGEX5FL1uqQoIcTgXvsY?=
 =?us-ascii?Q?MJ2NamH+s9UVgtJmsT6QUeFUPEzzQKrKx21j3c2BFV8BfxizUMJsu41KgaEi?=
 =?us-ascii?Q?imphT+rgrzfHe4zX0X6PtLtcHlRl12PI+SyyK8QAPGd1DoIq84H+6g83x6XK?=
 =?us-ascii?Q?IvS3ey/LOA/uH3yIgBIrtgLceqiljOqYjiq71YLPdDcJaXAHy2wVoVqPTQdC?=
 =?us-ascii?Q?DRZbFhmjayRGrCH6q9K6M2dfclCiPdZW1nTsgZnwXnkSRC7mfBglQiNIojIj?=
 =?us-ascii?Q?FcsHWNx49CqGpRd2FRoL1zHB3Yd4Sy/IONs5HPCCReXRFSNRONeMKEEf+Wvc?=
 =?us-ascii?Q?rU7g8jYLa55nW/SBzoLR9BVJoNcbhmSI4eCrwaoDOmCY4mnU7HBBcdWWBWqG?=
 =?us-ascii?Q?wCETLTq6aQoNAD72a4Tq2WE1D7/hhU61IeTmQV4X7oMHftkMg4hkG32/BHaK?=
 =?us-ascii?Q?baLxFfZEG7y45AqVzfSRX1zPYeGRcPq6QD5X2v7Dlk4CKBHlKVIGjXCfwyuW?=
 =?us-ascii?Q?ubnSCQlYvIFGAj9d2tESWDD6gQC5QEyLYe8NX8e43d0iqm2jKbNKsq4Pf8ZT?=
 =?us-ascii?Q?px/ThlDCPGHavZNv2cGK5Ov/lJ4ijsClBgDDxL8tLif6I14wrDnoir9x7wjY?=
 =?us-ascii?Q?Ox3P3kSDS6i+vOdQWLfOsGLSi+tYkdJ/oQkOAhHD9V9UmOe6x26EdwxoBMAE?=
 =?us-ascii?Q?lpJ6KoVe6y5cYlVFSFrnblN1OwCcnCx7SvreXec+hVLopr4jGw9BLZUWtLXd?=
 =?us-ascii?Q?KLRa0BbacEsexhMvxyrEHIGX/l79giqTGdhzJGlzpKaqCR6TUTYXmILAKOHU?=
 =?us-ascii?Q?0s7gQZyzwwsEAurVpPu16r6dF+/LKF7z1reo5KFNzA1jX06f7g25NFXlRgmW?=
 =?us-ascii?Q?oA4ZAo8KSm2J89fKMTbQmm5dV/08jC8jbUXQsG1jf+7wFRbyF0/5nKT/WbGf?=
 =?us-ascii?Q?/ijvX8siearVU184Hr7XhdKqLZMMI0eTz+UX39UUqq7INPCldPPTq8bE+mfw?=
 =?us-ascii?Q?XVqQA+5ehQJyjPzreinmEwrHfg4KG2ZqWoyKWrS1qSuCpzzePYaPi3H/ogOz?=
 =?us-ascii?Q?eOs65Di5N/PDC2XRVSUbpT18pOGoQPYNdD0Mqu8Jett9o2OcIcI1GA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C0irJiez39kNmTNcuKto1vhimyFgiCmpguln6RTPWbMG6W6dnE+bTWcasjiN?=
 =?us-ascii?Q?YaCAq2ruJT6jzv5g1DvEnoORIR7aMIwhOjvV4DhklRVUe/u1HuLdHPoEfETk?=
 =?us-ascii?Q?oD5EKQmK14algfJnxe2fpD7a+9meJ92xfxfDF9L4OjCwwf5iQRl132oZ954V?=
 =?us-ascii?Q?PQBa3gJbxqv167Z/ERPGv0lWMJp81gOREPdDHq/QTGBr0DbTgUxu3UIM1gb7?=
 =?us-ascii?Q?quXNdSth1FW3CtqLZTlnVLEYVCe00TGS6EbMD9TSptlg0ote47dCeWPjcY4i?=
 =?us-ascii?Q?WCvc3CBfNu8sNLTZeo0OFxOQeZwtwg6nqyz0GzDA+Sy4oZPkj2etO4Ko9jZ+?=
 =?us-ascii?Q?uZVMztNMsptTDX9IfRkp/kjK5DmWfbySJTZancb9FymKEer/yr5Uvi4jHqIa?=
 =?us-ascii?Q?NJGo4HKDIXJ1sDdT01Ztj1+Kq5x2LLyE9PGCOu2SFqmmogkZpAslOZ+juZO2?=
 =?us-ascii?Q?HMQB+dzHF1sL1HI0ebI7qeCNvhZEqs14qBUXb2ycVp8C1sb43Rz/LtWhoRI0?=
 =?us-ascii?Q?fwU2j9K4pskT4l5rkNgOjYrpZA4ixM7DkF1iaI3QNw3xTp9RmSDMqrYmrZVR?=
 =?us-ascii?Q?VfxNWX2a3nTCfmnjOeXuzrQdU/28KjTWxPT9UtJlIcp/kBU54XYgTQjYkz6Y?=
 =?us-ascii?Q?DJp77IEWiypOojOTnzrKeL24SbKBvCHN425vhXD/DNbQhddgEJpOdGfYIxVr?=
 =?us-ascii?Q?HAdSa6o2QGCq+/bezwsRg8XIIV9tMytLC1FWOzyMHRTXwIULYD22V87car3x?=
 =?us-ascii?Q?FRhVydKwOCsII+sLDunY0oKjmejNEa1WRqNev6Cth0oDdlGEkOBtZGW7EqEQ?=
 =?us-ascii?Q?/5bnc1C1tblHZf7/pDe8qIBFAZZN5dAwVYOtrZunDIvO9eJgshX9FBla4gy1?=
 =?us-ascii?Q?aEQLp8y6bEIOwI148CAvKRedNc/e+JP5SYLONG0T14Zplp7t03mEjVEjqP8o?=
 =?us-ascii?Q?RdHUdpAXcEG24wa+go8NTxwAwkwkoSqS0+BB/wnPqf3IeaH2RC13rUP5Q+DO?=
 =?us-ascii?Q?l1C1aTL9tGhVuXefDDKqLpSr1spfaSgEBNcAWsXozaShuexy9U2RYhyxHDel?=
 =?us-ascii?Q?BiG5q1LU5dIx5D7njrgx40UaAHuMvLLFQAGMOFR/66f9/IFOS62hAJ5MD6iF?=
 =?us-ascii?Q?WZ2P3/5ZDPW+jPEPAEclTr/sx/+Uu6UDht258de4wRHovbrDSTYmOGN1ISxK?=
 =?us-ascii?Q?MsIGk80luAEWdrr0Ug1adsL67RJuWCCDt87KQollZvDp0Nmm5QErIERd0MXR?=
 =?us-ascii?Q?Gd5QP/SksLOWhyiY1j5alVqFLwBovIchja/StUD+3vjG7VKrI411UXF+4wrz?=
 =?us-ascii?Q?0lv6ozMqkzyF8p/rUeO28ZEJaN5Ho7IuelkJT1Y//WCPs+QLN6W83K7JInt8?=
 =?us-ascii?Q?OWsc7+N6BzqFACKmW9zJFCI9hlH1f9PT0OYVTvTSjZMNIaCQY8dUjPvwF+jm?=
 =?us-ascii?Q?3YLW1Wna3w2QnKExfsWvLihpFmOVOAqClcNG43/s4x030yNtDu2b3eUzm2Bd?=
 =?us-ascii?Q?TkKoVcJLbEvh6cxpyIddOQhp2lEWbN4ZFXzlnTDWvfJQ3mxvZH5xAWfyh8j1?=
 =?us-ascii?Q?YZ9frcdwyBwWtYAsvBswmAmhmPg3v8nQizNc4wXu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f1ad5b-6f21-4434-164d-08dd766a2258
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:53:57.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSkwLvsB1u5yydrma59/t3hw4F9foONELD+ft2QO5rv0i8PniLCVIulnkFT01FPmKAWTFZXnuEzCGVu4gkvtFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8309

Some platforms are broken in PME_TURN_OFF broadcast and ACK handshake.
Add the quirks to support these platforms when generic DWC
suspend/resume callbacks are used.

[PATCH v1 1/4] PCI: dwc: Add quirk to fix hang issue in L2 poll of
[PATCH v1 2/4] PCI: dwc: Add quirk to fix hang issue when send out
[PATCH v1 3/4] PCI: imx6: Fix i.MX6QP PCIe hang issue in L2 poll of
[PATCH v1 4/4] PCI: imx6: Add quirks to fix i.MX7D PCIe hang in

drivers/pci/controller/dwc/pci-imx6.c             |  4 ++++
drivers/pci/controller/dwc/pcie-designware-host.c | 38 +++++++++++++++++++++++---------------
drivers/pci/controller/dwc/pcie-designware.h      |  5 +++++
3 files changed, 32 insertions(+), 15 deletions(-)


