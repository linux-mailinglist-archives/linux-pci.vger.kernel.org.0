Return-Path: <linux-pci+bounces-34355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A309B2D5C5
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9F31B65B4A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A9D2D6E56;
	Wed, 20 Aug 2025 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfgxTU0L"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD92D877E;
	Wed, 20 Aug 2025 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677489; cv=fail; b=oAyZez8jRVRgXb6IZ9GGGtDbMF2iME6DBKIW9PBljzkJJ6IEuNT9clUm83ha5KnSuCzK25YSoJZPXmNvjyb6LEnhSRbRYXVSyRC+afHTZej8awxwtqJasnwlQMTnLYnKJgtrdHbGRUbSEITV/eUOry9lsG18Hbk4bbLuu3O45WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677489; c=relaxed/simple;
	bh=uJpkuB/bPlii6WpZhbWEUarfuuCzJPFI+VM3ZQS3CGc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zz8L8lMU6dmQArQ2BkTnb2ePzJ7h0fZAgx71LIlzacirPQdHznqBMqMgVaFawm1qY0ND+ClakxlCOfZQlQdZvPboUo3Cuqo9erl0l3LkfEiBzm4Lif901Q7kAvhyB9cyRckSV2jsurMJDLtjrbJ0UVGC+ZJooHLZ9g03V5+L1Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mfgxTU0L; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L96fSXkzNqVJWwkSqfVJfndf/JSvAkk5eQBlMv7FYkR9DlCrRwDWHW4g1lIpVSZrGLLxjQ/8YmiNHqzfll5AI1nrMW4DCoQBqMrhyV4jpQ4HUJ+/8XHbtQDTjhas4YTYG+npeJQm9+YZBxOwflupixkX5OkJPSV6EhJGmg30VHuGYbMA9JTzp46X9pCK/0zH1c9rYoqeo51PXZf0PJxxpV281uMc3zpHvMkgN+mm5DJ2xUeaW/VXMQHDK0ifHaRYT+waP37Dawcy6730vXUpVfOwFljWj/2UPRvbNeJmiUyHcT6Rb0+lb/RYy8GAQr9UiwkjGxIe7ffVSIoSh/8p1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fczutGWC5Go+2yzPn++mRWkgrLmZF4asosA95N2t/ts=;
 b=NmVAHRHmRDGugzxAQZ6SY8bP9Is6qSpBkgAJCcOwqbOojxYRLx7AIz40ZQJ6qFD4aDlAEBCSrfKRhdT/LcGVBOZlEb07YMmWIDn2ePLqCZ7IfgPwfly9ppOgyqHp0fZBVHLMrEKuF6hUZ/Fd7nY2JkUlECiXrdMA/D7RlR8uRmI+aU+XMxXYK08DuO5ojs6PrHmyIE6ZKS/0lSpsjQxVQGosTovwEZG91yHbdua/01FHVLtfGehCad1pjVgQXxYDEV9jdaiSMgrWC9J6vuL8pnMF6uM+o1/jF8dab8QZsBBtP7wGCfIdfRDpdrs/vc2XioxUZCjzqjXNksxcUcyFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fczutGWC5Go+2yzPn++mRWkgrLmZF4asosA95N2t/ts=;
 b=mfgxTU0Ll6Ro03kL5UKpLaWBUh2NVmxzepB9atn7ZSB0ZYD3jQubGGzwvhnn+RTLMNDxRqG5ECtia4mQ9ElfUNNJBIIkmarMPcGftsoP8JJ9KCye4AKwLvWw6Jkouj+UCQ0HAwryLaeZLPpiRBw4ATqfJvFwCLGtwS7oW3Ha/AeAZqC3oA5+MHE2KkNFmvBKAfZPEj5fzQ6HkW8dNsmO8B+VFibLxy49xuZCZ9AkXOwy7V7FhuI0hlO6zgCEjHlsmyoeQ6a0DyFyNWAtLiTzjS5owtxEmKlZflmg+xJ8KBt9fgVAOGEDsbPPqqKzI4F9mvTQVq3V4P+r2pFO7rivHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM0PR04MB6913.eurprd04.prod.outlook.com (2603:10a6:208:184::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 08:11:24 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 08:11:24 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
Subject: [PATCH v1 0/2] PCI: imx6: Add a method to handle CLKREQ# override
Date: Wed, 20 Aug 2025 16:10:46 +0800
Message-Id: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM0PR04MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acc90cf-a2f8-4024-6dab-08dddfc12787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fBhrE6rFp4kwhjFR98u5XoO0OpJuAb8HWJsyRwk5Ks2GUFonKuD67zh4zUTj?=
 =?us-ascii?Q?t7p16bA+mscgruMg2fANQOdN411C7dMlC46BlqKLRuuEPPeDY3uMxx6XF47k?=
 =?us-ascii?Q?/xP1g8msOPgKulCNQ/UNcOipJD3Rcv7XCBSSIoVJGn3S2yZ8xzxkYCb62nKJ?=
 =?us-ascii?Q?2zOWZun14usmRnfVlpzb6F+R81GTNyXUBE7Ctbm2pgdfF+ArnzXYVXLSx0JN?=
 =?us-ascii?Q?X2P/Z7f5Duo4KqKvGeNfffOOGaSmz7SLBG3YA1T8kYSt+DoNJHgDYy49F3Sf?=
 =?us-ascii?Q?MY6Zk5Ux3L91ims30yUgglK2ZddKHhC1DTAYrvUBLmdW9jEf67d70lcejVSP?=
 =?us-ascii?Q?ZbWw7xd+K39zKdN8b6yTmIHFo3IUTN3PwKshfpvhdJy55O2xG5iIo3ft1JsE?=
 =?us-ascii?Q?Y5KlAF6BC4T8CJger1aoDAkGBJCMQCJrUuKJEORTQxRvVRY5TBMEO5THwwld?=
 =?us-ascii?Q?+3CA4kjZPDNCukWOBbxSMo7T6uCoqdRe7t3+k96XuMyWLez98P3DP/GvuUAu?=
 =?us-ascii?Q?BnBsr43onTPivJWzDpNPSbjfNexh1A35Q84Ke3b2KKnyz9I+gyjgzUIvVtfY?=
 =?us-ascii?Q?C9LWPbHtao0m7VTsnoM+VbwJ3nCHYhCGSvnYyEDDzmaZsDu4JmR4i1OvHY3+?=
 =?us-ascii?Q?tK3x8lxmZlwheoB/2GmFrNyyV0n0rpDZi5Lf810ettraJaeNdnEXlJf2U+CB?=
 =?us-ascii?Q?Qf71kI1ob4hNPVvJnR1e3V1bnuK80fGofgCnpVtYYSzPsuQ/Aujym0+CVsJ4?=
 =?us-ascii?Q?eUNgz72bB7BKT/KglfNrChGR4CvfLWhE12JhhnN2bFdI/ZnSx+DpOkgLo5v3?=
 =?us-ascii?Q?3Wz2n8Wm4usSjraG1Q2ugzz/KsR9F7vhC2o96/rg8zbcTT93cQjYu53IxjI3?=
 =?us-ascii?Q?2GVgD6R0Ltp9D7beIbENexJAlqwQFAh/Wpapm6xHYEn0eAKu5WdTnG5uLIdW?=
 =?us-ascii?Q?BkyN7RueL+T0mYuTZq6Y9bWN6NvaKpYZ1C/ckbJP/F6e3QVpLYZjFMKurM2v?=
 =?us-ascii?Q?w8pWiPYu66ORO3yTmrtw17fN3cTi3KkH7umtGCFdMWWXg4wA5z+Nmqe8TCNg?=
 =?us-ascii?Q?eaLoe9q/kEF2ViEa2h30dlK69cfwrXzR4Upl077vRY8Q3v/AGYaR4VjFftde?=
 =?us-ascii?Q?9bMO0FODqFJRQykxP3O64vdceZYVnSaU+WbAhkj85YC8UQTBBrAAKV5Boprd?=
 =?us-ascii?Q?wXr0GZmupLkdR3ryMwDCIkxH2AT+ixo3zrxAIUOt7eTXVTGtu+VfPtgkZIMj?=
 =?us-ascii?Q?WyowFbW/aQAri0M2ssKLJNyV2Ob/zmuJrs2nYkedoKoncqB1E0fZBFdO2WkU?=
 =?us-ascii?Q?/dqMdvVixnLGszXvu6j10+v3gryOz9fq6aPVoIksuuZfof/cXe2yZe5MvimL?=
 =?us-ascii?Q?jJ7ewmUBlNoCrlylw3m+aJYHKkHtnltaBiEr5tPqjHw88iaAK0VOVB5YIMtI?=
 =?us-ascii?Q?yRM0nlRe3bG9V3rz7AHbhi1JKvLPQQYIcgityT5a1WmNJCfCU1qupV4EiMNO?=
 =?us-ascii?Q?l4YasyjoVtPOfsY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/koduIszp5i487YhzAMpUevHZQXxrG6kUlpSRZGL6p7jk4qP45dJ45PDuRLB?=
 =?us-ascii?Q?EIAldREiBWzXaDXYs/2Q1MWiXAhHvyPtoaYxq+ljkn+4vkaQZoVy6wN7hU2j?=
 =?us-ascii?Q?23LsP4FNj0kde9ycP5hNai150R5NxaoCgheuWFsEH3Hq810MhkMz5f77tWKl?=
 =?us-ascii?Q?FsH/dPb1AnXi9w7GkO6DCdaYhuhdoUQ2U/v8wbUYu/v9gcOLbf1Ptdm6/O9K?=
 =?us-ascii?Q?6MzImgLmgAKRyntzSr2Jsq917KEBbblTqkiELWRFpwzhgJJDe9y/7ncWpU9x?=
 =?us-ascii?Q?YEo53pyE0Xnimyty/Zc8a/g70M2ZgJeTfoqmSfPTj3WiLAqUPj5DCuYd3D6/?=
 =?us-ascii?Q?6PkEN0xBDVq9Ml8emcbNDqLPZvi1ON5i/NK3coVsDmq1UAYWA0Rksr6BfifZ?=
 =?us-ascii?Q?eQgqZtEB3ldjjVSV5DtKlUUDYwyE/2RGsNCJ056h9HOoYJAQfNIPQfiHDgmv?=
 =?us-ascii?Q?o387vhrCAyRb8nfXTrS2ydvRJ1adpmAI596X+oxBhUpqPRUHElX0EXm9nWxa?=
 =?us-ascii?Q?0TDPBc14Py3ry9qy6+YCv9AfSdbz8xRoH2wTFHE+ULQr+C4u91JK9+NS/y1w?=
 =?us-ascii?Q?mT4/p1SgfnQNyXE0yo7QiPYUlTaUFko+7I0kduvnAmY0ilHgS0e3YbNaBJWF?=
 =?us-ascii?Q?uiabsn92az+9n1NVq/EVywDTSRARyJWKZQrfOz45h1UbXUO6UDw7dHoYr/LR?=
 =?us-ascii?Q?9dgEig8llAO/fPxrnM9rqrsSZ0iWfCDXHjyEloz6g10gV/FFt4B4dW/T5zuP?=
 =?us-ascii?Q?8LVe8kR21vqR5gl+L/91lF+kJEZx3ZDfCuKH/6++D8dE8idHoN3XffPk5Mai?=
 =?us-ascii?Q?Gn1K2NfhJypoYfye4fmfAKEn93xPy4dfSOYRs+WPQMF6VBkOOBL4aMrwSNOy?=
 =?us-ascii?Q?jqnIPKqEgII4cKjFVW9Bn63H9xMoDcOqB+Xx19El9ci7DnW+zWNxJGLUMCmF?=
 =?us-ascii?Q?GuyJL7m1sGD8N1oghUg5uHnR1ROSnpP4GCHEyoV9WpomXlF2emjj+N+Q0NZq?=
 =?us-ascii?Q?GEx4VlzD/A1t+Hb77u47aIE8wRDr/RIyJwsaXqtVcZ9RL3Qa6LJPyV9o6yNV?=
 =?us-ascii?Q?e7j7fz36NVAmAAEhaoVMDS73g41hWDZXCGwGKSlyoNDDYA0GXnoQYORI+UVT?=
 =?us-ascii?Q?NWxBNAVeFwP2LgSjBXqFLH29ek605mHXYzZZDX+8GfBG3MRLt829yMoukNVf?=
 =?us-ascii?Q?pv5xeyZCpnBKuYD6OOOoIcCExBl7EaInMXdI4l7vsP5DvA4BCTbrNLISa2H5?=
 =?us-ascii?Q?Z56S9KQgH+gsUj7krat+EeiL9QAnDxN8NHTHkCiJ0jgE0LhGZRksNguGRO44?=
 =?us-ascii?Q?8rLoC/K8Fgkx9RuoWs1U56Otex3kwiBEVlmKAMpCezW6L4t0VY/TEMa3ZdcC?=
 =?us-ascii?Q?Uc1TCmGOA8Chbq+JOOo7vFiNI47W2Dw9N6dkvisjKA3OKud8MbhcAGCRRt7I?=
 =?us-ascii?Q?/q9z0jzi8sk5Pbo8yLI9ahJeHhhpHS6aO0g+Zs4tJGjL0hnYEwUV7e86T87O?=
 =?us-ascii?Q?6ZGza6+h/vFrURNqLhiMkvBkD0KsBNDbQSPqinAefTzer0+8yulrVVcG0Cgs?=
 =?us-ascii?Q?B74uBZjEgP6wfmGSBLcua15Lko0yQVBQXprQNlbZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acc90cf-a2f8-4024-6dab-08dddfc12787
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:11:24.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZc2DDobMbFuCIT5DWOMrxHbiWcqfBa0r/iX444tdBgt3b9n/12WrX+snmoIa7UxTboprk+6S50OyT0JKV+F6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6913

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock.

Since the reference clock may be required by i.MX PCIe host too. To make
sure this clock is available even when the CLKREQ# isn't driven low by
the card(e.x no card connected), force CLKREQ# override active low for
i.MX PCIe host during initialization.

The CLKREQ# override can be cleared safely when supports-clkreq is
present and PCIe link is up later. Because the CLKREQ# would be driven
low by the card in this case.

[PATCH v1 1/2] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
[PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ# override

drivers/pci/controller/dwc/pci-imx6.c             | 35 +++++++++++++++++++++++++++++++++++
drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
2 files changed, 38 insertions(+)


