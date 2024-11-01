Return-Path: <linux-pci+bounces-15782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883229B8B9D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5771C21468
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2411F14F12D;
	Fri,  1 Nov 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W88z4nqH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232715749C;
	Fri,  1 Nov 2024 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444221; cv=fail; b=Y/GcCsruYbGLwlOuAiQ5/bhwAWweICAwaKL4aw72d6sXuT/dyAFi9ylR9uFDmYhiaqnHB1PQNZg9OcCEgVoN3Y10AlxmIxAPpIVj6HYBCUZ9qmInoZXaaUHYsSsWCeQeeZgtVjG1u001oh0KqFqxwaUxTVVekFiWjLsOMJhyJXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444221; c=relaxed/simple;
	bh=PWLY4lFAPWOPyYWxLyKdyvgEQsbc18BETBnhe+NrURE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+NPP8nKht+MS9OsQCrIhZwF6Ch8faU0/dVihI2mdXMg9SJWw1oQoLaingy/9u8sYVTpmjaOREe0KRO6KcTqPhPRFHTBTwaJeb5ZHV6JgCU7QCI/bnEKiLf3D9HCWLxQWBNDzwm6s953VtwU3cKdJu0qKv2K8RRUT5dZNVa0eUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W88z4nqH; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIp8BNG1zHVu1ExrJKe/2BhBtHBzWc9zDJgi/owt0yin8VFaPIz6D4Ca4J0gZ/p3dBYr70JohLxcOg7smvc8wpSwyC068xA1FbH3Br7rYcZ5YMAyeAKd7HkzOYsBlK7D/QDaDbPAhWYdb6XyhnLSFwCL7tsIoN7I0KUI4oU5Y+1TEZUYAetxDqENBd9aVPGTb+0xHBfmlY6UqLm59V7YA//cL0XyZrRaQxSNTS3diEIRl+uGlhhLS8q96m0c3e8If3wqVtxmAGnGgbBbsosXUxy5oTd9PmCH7dlkyQmh6Y0RV+2TfkbDmkoFwt0aoBanOWO4eCefA2Uc011d+dDlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0TuMiPepsNIub5jdEZmVmFcvsRa1/dMj99G+45paE8=;
 b=k16n3CGlcN021i6hoV/nc51dJbiz5+9H2PNMJ1loGrDR849vgC7rMRdH2GPMp+nXCYlDUXbEMIR/KmkqFCzwWaEpB4T6AmjXnz0H0Pp+laBlAeEFiI0iYVIti0TTVi46vSTbYAdKSXb7MzLPbS/9FirtC3LaRLROjZsGn92P1msW8UiVCE5uvKPFMQN+rKDDLpzm5b4dALWLn65mHkB8bfJQMfWr/QixnUtRwloAjlBH4/TNO62Rd/rIRDuR2dgOnZAa88cgyJKrn2etTgOnmjxtZXFeR+naVX/SeV3GXhrIEJLXXNHsioqBZLuZe0sgNGa0C/yGSzFgL/bWBa/xIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0TuMiPepsNIub5jdEZmVmFcvsRa1/dMj99G+45paE8=;
 b=W88z4nqHWUQQ0UnCcoPIdXqd5NTN7qpgRokCopehF7LsbJOLH9lyan43PIImqW2V3H6WLyhOAt94IxeVA+uYdb7KkuIg2W3fXypv2lSRq0ixcKYgmopg3N1bpfLe/7dq01U85Hw5fRx28McQQUnG4Y593AzusfJf0lHZazE6xwdHt5v2NazbwgLFPa/DIUQ3wHsbskj9QBcAPUEcEJI4bkudr3Q8MV0plkC035KCHfFlRJavhCVaps25aWavskUlMXZCjJRBgoKzwDHbZ36mhq0esEVc/eD9AVJ+rGGiZQtoVfIl8AUWYyG49kFh/hzk4v98sYQ2A6IxxbXVXSa4oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 06:56:55 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:56:55 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
Date: Fri,  1 Nov 2024 15:06:08 +0800
Message-Id: <20241101070610.1267391-9-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 766f0b81-b6b3-4b07-e243-08dcfa425f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYwP5U1ChymxUUIyGbCmfyHYA0n5FbvN8StyY/2OO3XP2ol8isw1GKpS+l51?=
 =?us-ascii?Q?tg8JY9/FyfKLt9T9aeJITqxkIF7WDhZURyVDKBfahpvw7D76NbHRJV80Cgqd?=
 =?us-ascii?Q?FBs1Uyv+ZNQC9Dy+i+KNmX2y/og3UlcZrC05H9BHVGZL+x9F0AG/3dpdxwLJ?=
 =?us-ascii?Q?nAEj0bYCzy/vvNiepjbVhjvBSU21z3V7TYiK5gbudRWv616FQ4udpUC0iAH7?=
 =?us-ascii?Q?sPgodVkLekRr3lRJDZi0vTFsLo5jJcet7ifYjPilHXAC8DaGbRY4u7M1KoOo?=
 =?us-ascii?Q?oX8JEc2E0CfDOFceiTra0jB/Eujv6F/Gy2f97GDbimETyVshptpjkfWBqDw2?=
 =?us-ascii?Q?KgLF+lqh1hPevLWRNdc4dsGuU97qzDI/ZaCsI9laW4jI/fOcLZbANHwvsyXl?=
 =?us-ascii?Q?hwXeJepUztCEsklmMfJq1TXYsM0OAWS3xXL6AdgqPVUlaDGna/ZsuP7M1JjA?=
 =?us-ascii?Q?Zslx/Zn2oL0f+1ABaewL4xEhC1VXI1V9ulnXMsfiSC1BndI5Scpmh/odO1Qk?=
 =?us-ascii?Q?9Do4R4XmLK/oNDR2lkfOLlOr7LqNYIA4ZPfJJkoJVzI2cqBWC59CxffpjQUR?=
 =?us-ascii?Q?lSnZIxHG5pWMD9JgT0QLXbPX7tsJyduq8E0GktT4RGc4uqVJRxkK36A4RQjn?=
 =?us-ascii?Q?a7B8rnrI6SX5cPGOD8674is2BU+zfbOBlSgq4xgczhGiBjaPK6Wa3ix7GqRK?=
 =?us-ascii?Q?Xzj7OfxAJA976bewN/WWli+cmcieI6FNSoDSRTxbNyNoCLy4p5gZPFF2YGrU?=
 =?us-ascii?Q?BJIo9D5m3ESrdxX74TYpDU5gPxnIJ7XSimGGp1IChTCzHr3oZsgG0Ve2uXNL?=
 =?us-ascii?Q?79RodMjD3etzLnhBCxR9EUet5Sq+rrhSXso64LQzYjPABH3WoR4RfIDEP7ue?=
 =?us-ascii?Q?Iu3zIJIE95ShlGYSm+yPGrxbkLVyLaGGm/ypw6B3FoqYLxZigAcPKEvzeXrE?=
 =?us-ascii?Q?F3wsz25EFZUP0efcU2Prsj5B4M1/5w0Pk89nDKmQ7QmHWahgfX8DjIzjfb67?=
 =?us-ascii?Q?oSZWkYLk32ZRbR09b24tnUxbXeEWsb0GEnb9VpcRh93FIB9BStgYWUHf7SCs?=
 =?us-ascii?Q?MhFTDNfZxKlJaNSrO52hPonV15MMOktCFrlU/wKjncxM7yC8e3sF04tBQMjH?=
 =?us-ascii?Q?KSE+YLk9x4aVk8wmuBeoqJZcBgGce1KQVsPadvrpelzVVbngjfq5trPAbeba?=
 =?us-ascii?Q?GURLD00mf0lgVM9W39woF+V/7Qg0zhiIKL6LAK4PY3nMsWfFOk97qqTpDhXM?=
 =?us-ascii?Q?bmasIALVemApCrD2K0TiuEx6mUvcaP9m5qZn88SYnORcpZrvt5agmgEm6i/R?=
 =?us-ascii?Q?WGPD1QOKwshDyHEIYQIkfd5pEtsvy5u4v2fYc/RaomqJeu24BfjEO/4GKll1?=
 =?us-ascii?Q?UNBdot+hjZkrfAKp/+Dj4SlHrVjl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AySwCuJsUU6h2ahuGvS5jMzs6WvqkX/k56XG925iCzVTZTyBpo8ZEKGfC1ms?=
 =?us-ascii?Q?Qvs7WS9esL46DuF1uuJIXrEn9I2uRw31IuRA/cgRRp94RYIggaJF08r/byNw?=
 =?us-ascii?Q?SidTAWLBWDPuJInRoXJ8jz1+D03unKdz+EaqImtjE1FqkZJkEw3dbgZTkuKo?=
 =?us-ascii?Q?0raftiON4GUh/iquad5OkZ1jUTNryz9VTLGyov6J7PfWo4IzK9zD0qIkCPC1?=
 =?us-ascii?Q?PsGtP2ic9Oiw7XrB+r9IBy7D2HR144AfmHw5N3uCzFfxSif9X6NPZNkv4Upt?=
 =?us-ascii?Q?1kuT497inLSfM6B6zlRukwSELTnPGtWPe6U0TS1HcYLXEyIb0nf+zz4fbfcM?=
 =?us-ascii?Q?S6CkYZlrXYn+uIhZvbKvexPj1M14aSRS0xyf0DzDVAHs3sgWYKwQ/xmcc+y1?=
 =?us-ascii?Q?pD4EBQMNfj8DnrVxwpGG5L+l+YJfHDkOm4Xyh7FaK6niTImf6444HHEyGAiG?=
 =?us-ascii?Q?cjKNkxpuRgXNPhS8Bc9Ha986SYEkjK+th+2VmFYwAG5Fl79q9TmRrN0+CKIk?=
 =?us-ascii?Q?Sc79JFdFbjFe6D/AKl76+gIvEb/JAdkIujS9HI57tzjsi0JKy2KEvj7Sk+a3?=
 =?us-ascii?Q?P9fHOtIHBM8BETpRP9ofVsUcNiq552PD9X7jYPc+a20CsZuJ7Da+hF5piTKQ?=
 =?us-ascii?Q?gXb9KCUHb9WkAVXDGsoh0sNCt0GWw4GSbv0gBFmnzWwK5UUizP+E/8vC7nlI?=
 =?us-ascii?Q?GtaVUX45Gf/neMWjVp4K/tG14tmZ+YwJP/34VVDtHHFI77nWZYQuQme9d6u+?=
 =?us-ascii?Q?njxs4ElJc0KOX9dI6YPs8otGZYazQGsN4r50stz9YMTbzzaSLAKIr5OaFnw5?=
 =?us-ascii?Q?pRnCwNXQeTQIEzosoqEIfZgVAHtZSHRf1mSSMPa6b+9S1DAlK9HxAC7p6qS9?=
 =?us-ascii?Q?DHBcKIUqvH8OqlW4cJqK9h788arbTtWHMM5T7cTbMnccGkAP3gC6LaiXdLcN?=
 =?us-ascii?Q?fs9qXwfmjqc8PNrSZSgtjH6kzdm3IySTHqu41Rs/eJ50Ufbialn4D1Mq/zaj?=
 =?us-ascii?Q?YH8LW/qOalstNmN5Oymc1BWpJeVLxMm44DcVpi2iW7YWUaJvD+v6ZnL7aXQH?=
 =?us-ascii?Q?ioburnne/sCBVji09Y7tJ3R4qzY+iSHNR7CFKCyrQNkHW3v495EqFfursvRg?=
 =?us-ascii?Q?nu0sYWp4YhZGOxo7zTGjZixrm7hj1daHBMMmTMpgsulbQtHZCNAL2QEnKKEB?=
 =?us-ascii?Q?8urLKhIl62B0ggLf5U5D/dPbeCk3mykiLiQhhPej95eKR2Y3NJBaOZUcww0f?=
 =?us-ascii?Q?JZD8dsz3VeSD3OKtiWizSb11PUWvt1mx6HTmtmWaKRx/AlD+IZq3pFkYVxnQ?=
 =?us-ascii?Q?CVMBpOaymCITVM2gohpLEvPsxMluzTzGEAYBrtAYBIa1Q2w2cCvb9beOMVHX?=
 =?us-ascii?Q?cG2G6VmNBM7T79HqXwg82+2ZOHAG9kDvjDcmQoUYzUO3mjMp8VisTQR0nlYD?=
 =?us-ascii?Q?MnFOVV8Lsg1IONBNxPdovqy7Z0y4y5Ngxhc5jnZt0LN+xzxABn7oHvO4W47C?=
 =?us-ascii?Q?ef0nHdu40xWePK4PmkZLDAX8S9D0k+yBpu6DPQcBzfofGxPu8RxQoEL56Ja8?=
 =?us-ascii?Q?0VCqcIfiNMt0X+o9QI5EMlSfTkCsroY22KRMAOD5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766f0b81-b6b3-4b07-e243-08dcfa425f48
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:56:55.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Pp0O0GE9N2mQChNNeKeLXgUJGkV/prFQFc3nkQa03mV1MzLu+RK2klmQep5Zr8zrTX81/M16UhTYCTpK1rF9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

From: Frank Li <Frank.Li@nxp.com>

Call common dwc suspend/resume function. Use dwc common iATU method to
send out PME_TURN_OFF message. In Old DWC implementations,
PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2 register is reserved. So the
generic DWC implementation of sending the PME_Turn_Off message using a
dummy MMIO write cannot be used. Use previouse method to kick off
PME_TURN_OFF MSG for these platforms.

Replace the imx_pcie_stop_link() and imx_pcie_host_exit() by
dw_pcie_suspend_noirq() in imx_pcie_suspend_noirq().

Since dw_pcie_suspend_noirq() already does these, see below call stack:
dw_pcie_suspend_noirq()
  dw_pcie_stop_link();
    imx_pcie_stop_link();
  pci->pp.ops->deinit();
    imx_pcie_host_exit();

Replace the imx_pcie_host_init(), dw_pcie_setup_rc() and
imx_pcie_start_link() by dw_pcie_resume_noirq() in
imx_pcie_resume_noirq().

Since dw_pcie_resume_noirq() already does these, see below call stack:
dw_pcie_resume_noirq()
  pci->pp.ops->init();
    imx_pcie_host_init();
  dw_pcie_setup_rc();
  dw_pcie_start_link();
    imx_pcie_start_link();

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 95 ++++++++++-----------------
 1 file changed, 34 insertions(+), 61 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index fde2f4eaf804..3c074cc2605f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -33,6 +33,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -108,19 +109,18 @@ struct imx_pcie_drvdata {
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
+	const struct dw_pcie_host_ops *ops;
 };
 
 struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
-	bool			link_is_up;
 	struct clk_bulk_data	clks[IMX_PCIE_MAX_CLKS];
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
-	struct reset_control	*turnoff_reset;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
@@ -899,13 +899,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 		dev_info(dev, "Link: Only Gen1 is enabled\n");
 	}
 
-	imx_pcie->link_is_up = true;
 	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
 
 err_reset_phy:
-	imx_pcie->link_is_up = false;
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
@@ -1024,9 +1022,32 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
 	return cpu_addr - entry->offset;
 }
 
+/*
+ * In Old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2
+ * register is reserved. So the generic DWC implementation of sending the
+ * PME_Turn_Off message using a dummy MMIO write cannot be used.
+ */
+static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
+	regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
+
+	usleep_range(PCIE_PME_TO_L2_TIMEOUT_US/10, PCIE_PME_TO_L2_TIMEOUT_US);
+}
+
+
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
+	.pme_turn_off = imx_pcie_pme_turn_off,
+};
+
+static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
+	.init = imx_pcie_host_init,
+	.deinit = imx_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1147,43 +1168,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	return 0;
 }
 
-static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie)
-{
-	struct device *dev = imx_pcie->pci->dev;
-
-	/* Some variants have a turnoff reset in DT */
-	if (imx_pcie->turnoff_reset) {
-		reset_control_assert(imx_pcie->turnoff_reset);
-		reset_control_deassert(imx_pcie->turnoff_reset);
-		goto pm_turnoff_sleep;
-	}
-
-	/* Others poke directly at IOMUXC registers */
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
-				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
-		break;
-	default:
-		dev_err(dev, "PME_Turn_Off not implemented\n");
-		return;
-	}
-
-	/*
-	 * Components with an upstream port must respond to
-	 * PME_Turn_Off with PME_TO_Ack but we can't check.
-	 *
-	 * The standard recommends a 1-10ms timeout after which to
-	 * proceed anyway as if acks were received.
-	 */
-pm_turnoff_sleep:
-	usleep_range(1000, 10000);
-}
-
 static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 {
 	u8 offset;
@@ -1207,36 +1191,26 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
-	imx_pcie_pm_turnoff(imx_pcie);
-	imx_pcie_stop_link(imx_pcie->pci);
-	imx_pcie_host_exit(pp);
-
-	return 0;
+	return dw_pcie_suspend_noirq(imx_pcie->pci);
 }
 
 static int imx_pcie_resume_noirq(struct device *dev)
 {
 	int ret;
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
-	ret = imx_pcie_host_init(pp);
+	ret = dw_pcie_resume_noirq(imx_pcie->pci);
 	if (ret)
 		return ret;
 	imx_pcie_msi_save_restore(imx_pcie, false);
-	dw_pcie_setup_rc(pp);
-
-	if (imx_pcie->link_is_up)
-		imx_pcie_start_link(imx_pcie->pci);
 
 	return 0;
 }
@@ -1267,11 +1241,14 @@ static int imx_pcie_probe(struct platform_device *pdev)
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-	pci->pp.ops = &imx_pcie_host_ops;
 
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	pci->pp.ops = &imx_pcie_host_dw_pme_ops;
+	if (imx_pcie->drvdata->ops)
+		pci->pp.ops = imx_pcie->drvdata->ops;
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1343,13 +1320,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		break;
 	}
 
-	/* Grab turnoff reset */
-	imx_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
-	if (IS_ERR(imx_pcie->turnoff_reset)) {
-		dev_err(dev, "Failed to get TURNOFF reset control\n");
-		return PTR_ERR(imx_pcie->turnoff_reset);
-	}
-
 	if (imx_pcie->drvdata->gpr) {
 	/* Grab GPR config register range */
 		imx_pcie->iomuxc_gpr =
@@ -1428,6 +1398,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 	} else {
+		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
 			return ret;
@@ -1491,6 +1462,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.init_phy = imx6sx_pcie_init_phy,
 		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
 		.core_reset = imx6sx_pcie_core_reset,
+		.ops = &imx_pcie_host_ops,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1508,6 +1480,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.init_phy = imx_pcie_init_phy,
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
+		.ops = &imx_pcie_host_ops,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.37.1


