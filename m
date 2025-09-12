Return-Path: <linux-pci+bounces-36060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C66FFB55860
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 23:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505217AFCAB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 21:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6D51DE4CE;
	Fri, 12 Sep 2025 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="amdi2MBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F48F513;
	Fri, 12 Sep 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712648; cv=fail; b=C4ocfAhw9BLJ/hsv91VpxISrNILMzqf1+MEHFGxZSnFphzNuxUg36hObhJCaKafUE7ykOZqiTE/DczStt49ew4yf3Ko3FqiTtyYwZ2yEZnjO0UhYnA+rbhWnrVnqY+S+mV4zEQNtRDjzOsBT+BK21/CK3h1EUYq+4kGKDBiODPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712648; c=relaxed/simple;
	bh=KYAG+LjWq4xCqGyFqqpBpsJiVNAWSBeipqr6HbL2fbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y6aj2mxPYnsXHS76HNtXnt+mzI3SywDd18FGCUhlExm2XpzF42e1tzyJ8uqQsOxz7LxOEaEbyEfUHdJ24twdLpDHL+mfkMjzVS234M0Pt3OvtDgKyddg5De5/Jr8ykOVrj0lSk0RkIE4e1W1724sqrM7RShQRB85Uwe1GDZqvyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=amdi2MBI; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLCBpsA6Iu47ucu9qsaBuRFzFIPSw4zwAAG2A1Uh0tYXS5h9LJ0CX9VpJgG6j7dN9gbiqx1lmusGEMQ6v5hepSaWilL5mEBHdfD25psKe7prF2zETK/jZSK3XsAFHKD6HLSGF/qfxN6cPPRUGK+5NJCAmqgD2zVVM45GURu1qhsYm8j9NjbYvOFf7y69qz0CX4PRY1wTrhVMD0Pd/Sp+nBELzj6GqIYoiONvtnBCbPKb/4BuO4Hpjj0cGkCAXrxFF3UHwpcRI09e+uzb5M4eKXSzsWXlP40r78cfRw8oLjbzzM2Fywz9FtucLxCz/zBD5Zicy8mwt7dTWYFmr7oPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZvu+QHX6R6KPbAzUIumKurlK6teGCewgOvQ3dcvqH8=;
 b=mm/vWAM6RER/Lxh2c4nGTr2N8ViS0+z9bW/wox6aoIRjPKK5RuVPIKH3t+9m4zkAD3PVfEwoZJ4n2+HERkcFbiasiEWNTPxKyhy5E4xrnBS4b4gOOt15CNdz8iZsNgcduwqJ55ykzqeR7H3JsSM/Iju2ZuFdXCFSpb3xBfXiRA1AO8xg+DFkzjCHduAYoq7l33OtEfTmxhIey6CbEmhkZOSlJEWQdNX1UU7i/OHkzLHY2Q8ZdTifYPfqBfGmlpGEZBnIASMA/ueUF8TXMXhmu1LuJHIKmIBdtoLEuNYdFu7mdRPHHtM9WEkXjvpriM9eHvCcStNkUeqKed2y1wi24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZvu+QHX6R6KPbAzUIumKurlK6teGCewgOvQ3dcvqH8=;
 b=amdi2MBIH6ZAiT1nmo3hXO2Beks5ic+8Zafop9nOn82XLAZvZsWFYAltAMiDkBqyrv0t5WGakIYkHin9pZbk8P5AmZTKKDVrL7yjvm4JHamo18jxcQfnZQTx0RWERtA482aK1GJV/1SLe9CW4i0nsl+SikprDUo2iHYXCZrI8rc59PzZpUMjemW/ZFw1Y4mtaJWoZAN1wNn2VFm+Ym7YgNuekGPTy37hpYwGiQAUiA46g56OTNfnq9DSZLPYAV2COQXUapzUhKyU5nKG6R1KeHWcKV3YcslPxXZNIijVTlT7dBUK6v1g6hkg03lI90Ttl9dfSkRTwUnnoO9+GNHlXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 21:30:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 21:30:41 +0000
Date: Fri, 12 Sep 2025 17:30:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] pcie: s32g: Add initial PCIe support (RC)
Message-ID: <aMSQ+CWz/rUoap2u@lizhi-Precision-Tower-5810>
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
 <20250912141436.2347852-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912141436.2347852-4-vincent.guittot@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d798b8-7abb-4250-5a60-08ddf2439fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?erCch42AUCrVNGo8rMPAggh6+SUGB/fH+CXY+Zm71ZHmUJ+MythQHDSFGi/Z?=
 =?us-ascii?Q?zv7Lffbzf/LpliS+EyOuiKQrQvlElqJdLgbjbQq5+rmkTnB5F5cXf0d19cVI?=
 =?us-ascii?Q?VKs/d35NGIkwlN/aYOBqrMpJx5xWLiYkzrDRgTC1avDg3kN2cGVQYFEzSO7a?=
 =?us-ascii?Q?0XoAvYun3Y9IQAtp8Epr1Q2F7Huwhzm8UVVtM5SBa0pekxkb6z/8Vmh8kFHt?=
 =?us-ascii?Q?zZZX01jnRPdWUaIjSr4E1ev2Kka3CtrrLiauuHujB5HmNJgtdYD9MeBSpoVr?=
 =?us-ascii?Q?Z1KcAIvEbzBU9D5+7VQHhuyERIqh4pD0N/3X9cqETXtmKOdLegDpbOlnl/MX?=
 =?us-ascii?Q?ATuQqquEHG/IelPFtyW9baSu2NnXgKQMGLLyhlEqC0CWF7WSFigdLlwLjvdV?=
 =?us-ascii?Q?+JmEFNNlO4TPfwpPRYdNcSH5KP6fEQ18L609nK8XvcRUuApQBt9n3ngxrRBK?=
 =?us-ascii?Q?EDhUQtDri5ygNncIhd3nmUXPFvzsVwvGi137pZ34dbcjNgqvP6PCnBIqqH6B?=
 =?us-ascii?Q?WLm9QpGiWd5/qbSz85+V87KLZ4Nmu98KPvrPGiy1D9I5X6XlOhe8D8Nn2Ign?=
 =?us-ascii?Q?DMrMFxitrPrEo0pA5bv3hQfyc3oKD8Ji0PLBHz952YOFkFAalLNjHxi3emq0?=
 =?us-ascii?Q?Ai2a5K2uWSD/SrSOBMDlTyHI0wP4dSjau9PiIeW9f50wHRcAD6fxVDs4ENaz?=
 =?us-ascii?Q?eeckagrS7kiCT1QTGipy76F4936t62SxR2Qt4ClHAJy2wt3sQPGoDOI00+A9?=
 =?us-ascii?Q?RKgHO7TBOCcnuT8zwgbTG/R9H0Czya5x5YgEDuuGmdiCZn9QBssMjNLMsjtS?=
 =?us-ascii?Q?hgK9VeDSLrexMlCPYZyGPxyTaBrohKH6BQAr8sdNaH3R2jNMMzga/FTpxaL8?=
 =?us-ascii?Q?XHXTUg7zdPj4vDH1KJNO2HOwIdIVjZpFt+SNO+j+RBJdx6+Av9M2sFGI7xxD?=
 =?us-ascii?Q?eLJtm/Mb58+M8DxlAvIsVEoYERCiRTmtB/qTD1HF/OKlmd+3WQ663TTpe7ko?=
 =?us-ascii?Q?lGYRU8AAOYS0ECkNfdSuzLzPaKVGMD9mC/6rxAqIk8oqAZCYHhTT3aC6rYJo?=
 =?us-ascii?Q?UxgcHQac9N0FpDzR0uJiCAHvL1chsiuEO0gx8GK6Iu5Tz27L90zOy0Kz9f3Q?=
 =?us-ascii?Q?vrTVLEDBs7JhYNuQ3dpUQcbQEdbIrFQSymE19JOi0R8jna5TcKkFdVr17HI1?=
 =?us-ascii?Q?BJfGSU4ucAq0nXG1y+GAdLwSxnkrFjwNWVvaB7m24mDuczqlnqW+5+jffU9L?=
 =?us-ascii?Q?PAfRmr0/I4eJC00OcpF2pipIVMfD93OBVzBsw4pCGBVQhU0NqRYa1b5cf12D?=
 =?us-ascii?Q?bNXyhh9xNZNaGfx07DXO+lU/+1Cp5bmw/qt5DTzs+8cYxEbohDtmRydZs03Q?=
 =?us-ascii?Q?uIhKP/hvqOwnXC45QLZBu3dlQg/3j7qxelMHrdKp3MK0M3hfoIgnJ/9CFcid?=
 =?us-ascii?Q?Jd4dGTZiAgnWFFghk9e0ZMO2t3pLsAnzKY7FsDRYWiGFpM8/u7z6Lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4eHAyfe+6JtiRNZbVbzL9T0NU+6ebqUn5loteVFrtOc4juuCfOzIEDxUmEha?=
 =?us-ascii?Q?fl9gLWIp2KRvWgJEAnrmvpYAcHsBSa82nkiNHVjAIQS1Yzpyw8vq3l84qkPO?=
 =?us-ascii?Q?jSKKwqjOb/FbYzhUo4c2xEBn0k/VM+f5c6bAzJ9UEGXnSXmgfCRFn/d5JjHa?=
 =?us-ascii?Q?aL1ZEGXMat3Ev4WTsNgNtf+sz+vG1bQlGawyvGtGO3+47SFcJ48YULRBKHNG?=
 =?us-ascii?Q?a9GvszpzZ5LtQOoGJMoY5TgC+z9etP1l3/tEA3fPpPyrsMkVjXO83fLbt53q?=
 =?us-ascii?Q?y5XcinEIlwX++Wmb0g5TNFCBmiT5p9thBl2XlyLhV44H7URkRUllVFkQoFZw?=
 =?us-ascii?Q?HVXqrw2p+RQNOo6JxGxsg89XD4Cd/OiwY+ddx272Jki2dPxg0uQrlspqHXe2?=
 =?us-ascii?Q?bSsGwEMSk+ODtRda55BXfG21U5kcbQDr1NR1pjB+C0Lm81NNhRTwzQ+ru9Ca?=
 =?us-ascii?Q?yagUd2dy9cOB/feYWzRNi6I57IB7n7wM1uKVOwLRGU0kEmDcbe8O2oEgjHvY?=
 =?us-ascii?Q?PfSTtEPVDD7eaH5FD5op21PI1alCwYFrdD/Q9tlgowM2J9ZW2ukcTg3oeXxo?=
 =?us-ascii?Q?yNAsCMO9s7cvS1kXteZ0ZR4STMIQtBnZwuhnY6UGP2jVTzS64gmhbQHKvmlV?=
 =?us-ascii?Q?ngAt2HqoxJXazEYZ72nVSmEQWtmZWzf/4wgAUP3AwtaZPARFfNd2aRdjcxqM?=
 =?us-ascii?Q?3bbZPDcsWGE4ancK54iFdTfAuKHfFVSJKTjGv5RPWx+eDpNzZjOHxe0FUsZ7?=
 =?us-ascii?Q?rT7PugvQU+XgFDZsV26xSAjQROQ+/83vwkRgF1pJDtk9uqViXqvbelIoFnHc?=
 =?us-ascii?Q?j2k7Qeseg9/w15ozgWYc7qLARVtcl0chw8hNdeSoSq94IaFyBVpLseAGlKEu?=
 =?us-ascii?Q?24OX1PqeOhh0p/lCCIeh5nWhf4xBfR9D/pxusmxNJyj+/5nlfL7Hx8RwEwSW?=
 =?us-ascii?Q?mDmx7zZ+D/pefm/xuI9cS24BCSY8MbNlGmMyIGkMytBguOZn4zIC2UTi+QYo?=
 =?us-ascii?Q?pzx6hMIjWeO0/emlQq7eehJfPfj39TKRukDHLG7e/xszXTHesWR4roONM1jz?=
 =?us-ascii?Q?/9v7EwKh5PVQu+6VaPzogWNe3AhdnE5U6pw82B3QtC+CBlSNzy4uW9tzBYjU?=
 =?us-ascii?Q?kOHLWvZn/g9oWgMTL2cfWyJcqvYILXpIIDv/n36oFltHJxbNkihIKY8jK3dg?=
 =?us-ascii?Q?7HyNSOdp4k+SZ1+XpTnZGSDYOPEw/TW7FB4rGnRRMe2kWuiOrXBgxxiPV9Sz?=
 =?us-ascii?Q?gmB85ghIiM4sCyXwoxwhx9cJeZT+TNfTOKG4C9QVN7b7c+ghS3vuowNnddYB?=
 =?us-ascii?Q?jxQSWrEGm88B8+9ubcFAqPCSkYnE2KbvfL1z/mGD2TDIgQhwTEusSTmq1hLo?=
 =?us-ascii?Q?0/GGM/4d1u/tNLUcuVu8IixqSTj+jziXAkg47Tbnv6GbrrQO0fxzYtz+BGEj?=
 =?us-ascii?Q?WTwOJTl/Wguvw2E4pjLkCdGp7fYBzJnIo/ebupNmI2bN3RhnjzQOfrsXVdRc?=
 =?us-ascii?Q?f43BXb9FtH5UDpDiL1Roa3fxJvnawebLZp70dMwj8eK2eBLgVij3SLJJNTCG?=
 =?us-ascii?Q?IXVyuC1awTPmn/pBLryLMnOt8mmx23TjawXNLzJk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d798b8-7abb-4250-5a60-08ddf2439fac
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 21:30:41.4912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4A6usb7dtiB8S6DsuRgsenRXDgOiBSp4M2vCOKFlUgLg46DNGR7sI64SwaC1DkMJmHe6Tflrfy3+8GkTFfHifg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536

On Fri, Sep 12, 2025 at 04:14:35PM +0200, Vincent Guittot wrote:
> Add initial support of the PCIe controller for S32G Soc family. Only
> host mode is supported.
>
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/pci/controller/dwc/Kconfig         |  12 +
>  drivers/pci/controller/dwc/Makefile        |   1 +
>  drivers/pci/controller/dwc/pci-s32g-regs.h | 105 ++++
>  drivers/pci/controller/dwc/pci-s32g.c      | 697 +++++++++++++++++++++
>  drivers/pci/controller/dwc/pci-s32g.h      |  45 ++

pcie-s32g.*, previous pci-* is wrong added.

>  5 files changed, 860 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pci-s32g-regs.h
>  create mode 100644 drivers/pci/controller/dwc/pci-s32g.c
>  create mode 100644 drivers/pci/controller/dwc/pci-s32g.h
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index ff6b6d9e18ec..39d9a47f6fea 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -255,6 +255,18 @@ config PCIE_TEGRA194_EP
>  	  in order to enable device-specific features PCIE_TEGRA194_EP must be
>  	  selected. This uses the DesignWare core.
>
> +config PCI_S32G
> +	bool "NXP S32G PCIe controller (host mode)"
> +	depends on ARCH_S32 || (OF && COMPILE_TEST)
> +	select PCIE_DW_HOST
> +	help
> +	  Enable support for the PCIe controller in NXP S32G based boards to
> +	  work in Host mode. The controller is based on Designware IP and
> +	  can work either as RC or EP. In order to enable host-specific
> +	  features PCI_S32G must be selected and in order to enable
> +	  device-specific features PCI_S32G_EP must be selected.
> +
> +
>  config PCIE_DW_PLAT
>  	bool
>
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 6919d27798d1..69f8e80fdae4 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
> +obj-$(CONFIG_PCI_S32G) += pci-s32g.o
>  obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
> diff --git a/drivers/pci/controller/dwc/pci-s32g-regs.h b/drivers/pci/controller/dwc/pci-s32g-regs.h
> new file mode 100644
> index 000000000000..e7ad1b6b7aa5
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pci-s32g-regs.h
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> + * Copyright 2016-2023, 2025 NXP
> + */
> +
> +#ifndef PCI_S32G_REGS_H
> +#define PCI_S32G_REGS_H
> +
> +/* Instance PCIE_SS - CTRL register offsets (ctrl base) */
> +#define LINK_INT_CTRL_STS			(0x40U)
> +#define LINK_REQ_RST_NOT_INT_EN			BIT(1)
> +#define LINK_REQ_RST_NOT_CLR			BIT(2)
> +
> +/* PCIe controller 0 general control 1 (PE0_GEN_CTRL_1) (ctrl base) */
> +#define PE0_GEN_CTRL_1				(0x50U)
> +#define SS_DEVICE_TYPE_MASK			GENMASK(3, 0)
> +#define SS_DEVICE_TYPE(x)			FIELD_PREP(SS_DEVICE_TYPE_MASK, x)
> +
> +enum pcie_dev_type_val {
> +	PCIE_EP_VAL = 0x0,
> +	PCIE_RC_VAL = 0x4
> +};
> +
> +#define SRIS_MODE_EN				BIT(8)
> +
> +/* PCIe controller 0 general control 3 (PE0_GEN_CTRL_3) (ctrl base) */
> +#define PE0_GEN_CTRL_3				(0x58U)
> +/* LTSSM Enable. Active high. Set it low to hold the LTSSM in Detect state. */
> +#define LTSSM_EN				BIT(0)
> +
> +/* PCIe Controller 0 Link Debug 2 (ctrl base) */
> +#define PCIE_SS_PE0_LINK_DBG_2			(0xB4U)
> +#define PCIE_SS_SMLH_LTSSM_STATE_MASK		GENMASK(5, 0)
> +#define PCIE_SS_SMLH_LINK_UP			BIT(6)
> +#define PCIE_SS_RDLH_LINK_UP			BIT(7)
> +#define LTSSM_STATE_L0				0x11U /* L0 state */
> +#define LTSSM_STATE_L0S				0x12U /* L0S state */
> +#define LTSSM_STATE_L1_IDLE			0x14U /* L1_IDLE state */
> +#define LTSSM_STATE_HOT_RESET			0x1FU /* HOT_RESET state */

does common dw_pcie_get_ltssm() work for it, why need new macro for it.

> +
> +/* PCIe Controller 0  Interrupt Status (ctrl base) */
> +#define PE0_INT_STS				(0xE8U)
> +#define HP_INT_STS				BIT(6)
> +
> +/* Status and Command Register. pci-regs.h */
> +
> +/* Instance PCIE_CAP */
> +#define PCIE_CAP_BASE				(0x70U)
> +
> +/* Device Control and Status Register. */
> +#define CAP_DEVICE_CONTROL_DEVICE_STATUS	(PCIE_CAP_BASE + PCI_EXP_DEVCTL)

You use standard method to search PCI_EXP_DEVCTL instead of hardcode CAP_BASE
to 70

> +#define CAP_CORR_ERR_REPORT_EN			BIT(0)
> +#define CAP_NON_FATAL_ERR_REPORT_EN		BIT(1)
> +#define CAP_FATAL_ERR_REPORT_EN			BIT(2)
> +#define CAP_UNSUPPORT_REQ_REP_EN		BIT(3)
> +#define CAP_EN_REL_ORDER			BIT(4)
> +#define CAP_MAX_PAYLOAD_SIZE_CS_MASK		GENMASK(7, 5)
> +#define CAP_MAX_PAYLOAD_SIZE_CS(x)		FIELD_PREP(CAP_MAX_PAYLOAD_SIZE_CS_MASK, x)
> +#define CAP_MAX_READ_REQ_SIZE_MASK		GENMASK(14, 12)
> +#define CAP_MAX_READ_REQ_SIZE(x)		FIELD_PREP(CAP_MAX_READ_REQ_SIZE_MASK, x)
> +
> +/* Link Control and Status Register. */
> +#define PCIE_CTRL_LINK_STATUS			(PCIE_CAP_BASE + PCI_EXP_LNKCTL)
> +#define PCIE_CAP_RETRAIN_LINK			BIT(5)
> +#define PCIE_CAP_LINK_TRAINING			BIT(27)
> +
> +/* Slot Control and Status Register */
> +#define PCIE_SLOT_CONTROL_SLOT_STATUS		(PCIE_CAP_BASE + PCI_EXP_SLTCTL)
> +#define PCIE_CAP_PRESENCE_DETECT_CHANGE_EN	BIT(3)
> +#define PCIE_CAP_HOT_PLUG_INT_EN		BIT(5)
> +#define PCIE_CAP_DLL_STATE_CHANGED_EN		BIT(12)
> +
> +/* Link Control 2 and Status 2 Register. */
> +#define CAP_LINK_CONTROL2_LINK_STATUS2		(PCIE_CAP_BASE + PCI_EXP_LNKCTL2)
> +#define PCIE_CAP_TARGET_LINK_SPEED_MASK		GENMASK(3, 0)
> +#define PCIE_CAP_TARGET_LINK_SPEED(x)		FIELD_PREP(PCIE_CAP_TARGET_LINK_SPEED_MASK, x)

I think these should be standard. if not, add S32_ prefix.

> +
> +/* Instance PCIE_PORT_LOGIC - DBI register offsets */
> +#define PCIE_PORT_LOGIC_BASE			(0x700U)
> +
> +/* Port Force Link Register. pcie-designware.h */
> +
> +/* Link Width and Speed Change Control Register. pcie-designware.h */
> +
> +/* Gen3 Control Register. pcie-designware.h */
> +#define PCIE_EQ_PHASE_2_3			BIT(9)
> +
> +/* Gen3 EQ Control Register. pcie-designware.h */
> +
> +/* ACE Cache Coherency Control Register 3 */
> +#define PORT_LOGIC_COHERENCY_CONTROL_1		(PCIE_PORT_LOGIC_BASE + 0x1E0U)
> +#define PORT_LOGIC_COHERENCY_CONTROL_2		(PCIE_PORT_LOGIC_BASE + 0x1E4U)
> +#define PORT_LOGIC_COHERENCY_CONTROL_3		(PCIE_PORT_LOGIC_BASE + 0x1E8U)
> +/*
> + * See definition of register "ACE Cache Coherency Control Register 1"
> + * (COHERENCY_CONTROL_1_OFF) in the SoC RM
> + */
> +#define CC_1_MEMTYPE_BOUNDARY_MASK		GENMASK(31, 2)
> +#define CC_1_MEMTYPE_BOUNDARY(x)		FIELD_PREP(CC_1_MEMTYPE_BOUNDARY_MASK, x)
> +#define CC_1_MEMTYPE_VALUE			BIT(0)
> +#define CC_1_MEMTYPE_LOWER_PERIPH		0x0
> +#define CC_1_MEMTYPE_LOWER_MEM			0x1
> +
> +#endif  /* PCI_S32G_REGS_H */
> diff --git a/drivers/pci/controller/dwc/pci-s32g.c b/drivers/pci/controller/dwc/pci-s32g.c
> new file mode 100644
> index 000000000000..3a7c2fc83432
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pci-s32g.c
> @@ -0,0 +1,697 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for NXP S32G SoCs
> + *
> + * Copyright 2019-2025 NXP
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/pci.h>
> +#include <linux/phy.h>
> +#include <linux/phy/phy.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/io.h>
> +#include <linux/sizes.h>
> +
> +#include "pcie-designware.h"
> +#include "pci-s32g-regs.h"
> +#include "pci-s32g.h"
> +
> +static void s32g_pcie_writel_ctrl(struct s32g_pcie *pci, u32 reg, u32 val)
> +{
> +	if (dw_pcie_write(pci->ctrl_base + reg, 0x4, val))
> +		dev_err(pci->pcie.dev, "Write ctrl address failed\n");
> +}
> +
> +static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *pci, u32 reg)
> +{
> +	u32 val = 0;
> +
> +	if (dw_pcie_read(pci->ctrl_base + reg, 0x4, &val))
> +		dev_err(pci->pcie.dev, "Read ctrl address failed\n");
> +
> +	return val;
> +}
> +
> +static void s32g_pcie_enable_ltssm(struct s32g_pcie *pci)
> +{
> +	u32 reg;
> +
> +	reg = s32g_pcie_readl_ctrl(pci, PE0_GEN_CTRL_3);
> +	reg |= LTSSM_EN;
> +	s32g_pcie_writel_ctrl(pci, PE0_GEN_CTRL_3, reg);
> +}
> +
> +static void s32g_pcie_disable_ltssm(struct s32g_pcie *pci)
> +{
> +	u32 reg;
> +
> +	reg = s32g_pcie_readl_ctrl(pci, PE0_GEN_CTRL_3);
> +	reg &= ~LTSSM_EN;
> +	s32g_pcie_writel_ctrl(pci, PE0_GEN_CTRL_3, reg);
> +}
> +
> +static bool is_s32g_pcie_ltssm_enabled(struct s32g_pcie *pci)
> +{
> +	return (s32g_pcie_readl_ctrl(pci, PE0_GEN_CTRL_3) & LTSSM_EN);
> +}
> +
> +#define PCIE_LINKUP	(PCIE_SS_SMLH_LINK_UP | PCIE_SS_RDLH_LINK_UP)
> +
> +static bool has_data_phy_link(struct s32g_pcie *s32g_pp)
> +{
> +	u32 val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_SS_PE0_LINK_DBG_2);
> +
> +	if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
> +		switch (val & PCIE_SS_SMLH_LTSSM_STATE_MASK) {
> +		case LTSSM_STATE_L0:
> +		case LTSSM_STATE_L0S:
> +		case LTSSM_STATE_L1_IDLE:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static struct pci_bus *s32g_get_child_downstream_bus(struct pci_bus *bus)
> +{

what's this, why need it?

> +	struct pci_bus *child, *root_bus = NULL;
> +
> +	list_for_each_entry(child, &bus->children, node) {
> +		if (child->parent == bus) {
> +			root_bus = child;
> +			break;
> +		}
> +	}
> +
> +	if (!root_bus)
> +		return ERR_PTR(-ENODEV);
> +
> +	return root_bus;
> +}
> +
> +static bool s32g_pcie_link_is_up(struct dw_pcie *pcie)
> +{
> +	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pcie);
> +
> +	if (!is_s32g_pcie_ltssm_enabled(s32g_pp))
> +		return 0;

This function check if linkup, why enable ltssm here, suppose it should
enable before call it.

> +
> +	return has_data_phy_link(s32g_pp);
> +}
> +
> +/* Use 200ms for PHY link timeout (slightly larger than 100ms, which PCIe standard requests
> + * to wait "before sending a Configuration Request to the device")
> + */
> +#define PCIE_LINK_TIMEOUT_US		(200 * USEC_PER_MSEC)

define SPEC's defined PCIE_LINK_TIMEOUT_US in pci.h.

> +#define PCIE_LINK_WAIT_US		1000
> +
> +static int s32g_pcie_start_link(struct dw_pcie *pcie)
> +{
> +	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pcie);
> +	u32 reg, tmp;
> +	int ret;
> +
> +	/* Don't do anything if not Root Complex */
> +	if (!is_s32g_pcie_rc(s32g_pp->mode))
> +		return 0;
> +
> +	if (pcie->max_link_speed >= 1 && pcie->max_link_speed < 3) {
> +		/* Limit max link speed */
> +		reg = dw_pcie_readl_dbi(pcie, CAP_LINK_CONTROL2_LINK_STATUS2);
> +		reg &= ~(PCIE_CAP_TARGET_LINK_SPEED_MASK);
> +		reg |= PCIE_CAP_TARGET_LINK_SPEED(pcie->max_link_speed);
> +		dw_pcie_writel_dbi(pcie, CAP_LINK_CONTROL2_LINK_STATUS2, reg);
> +

use dw_pcie_wait_for_link();

> +		if (is_s32g_pcie_ltssm_enabled(s32g_pp)) {
> +			ret = read_poll_timeout(dw_pcie_readl_dbi, tmp,
> +						!(tmp & PCIE_CAP_LINK_TRAINING),
> +						PCIE_LINK_WAIT_US, PCIE_LINK_TIMEOUT_US, 0,
> +						pcie, PCIE_CTRL_LINK_STATUS);
> +			if (ret)
> +				dev_warn(s32g_pp->pcie.dev,
> +					 "Failed to finalize link training\n");
> +
> +			reg = dw_pcie_readl_dbi(pcie, PCIE_CTRL_LINK_STATUS);
> +			reg |= PCIE_CAP_RETRAIN_LINK;
> +			dw_pcie_writel_dbi(pcie, PCIE_CTRL_LINK_STATUS, reg);
> +		}
> +	}
> +
> +	/* Start LTSSM. */
> +	s32g_pcie_enable_ltssm(s32g_pp);
> +
> +	return 0;
> +}
> +
> +static void s32g_pcie_stop_link(struct dw_pcie *pcie)
> +{
> +	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pcie);
> +
> +	s32g_pcie_disable_ltssm(s32g_pp);
> +}
> +
> +struct dw_pcie_ops s32g_pcie_ops = {
> +	.link_up = s32g_pcie_link_is_up,
> +	.start_link = s32g_pcie_start_link,
> +	.stop_link = s32g_pcie_stop_link,
> +};
> +
> +static struct dw_pcie_host_ops s32g_pcie_host_ops;
> +
> +static void s32g_pcie_set_phy_mode(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pcie = &s32g_pp->pcie;
> +	struct device *dev = pcie->dev;
> +	struct device_node *np = dev->of_node;
> +	const char *pcie_phy_mode = NULL;
> +	int ret;
> +
> +	ret = of_property_read_string(np, "nxp,phy-mode", &pcie_phy_mode);
> +	if (ret || !pcie_phy_mode) {
> +		dev_info(dev, "Missing 'nxp,phy-mode' property, using default CRNS\n");
> +		s32g_pp->phy_mode = CRNS;
> +	} else if (!strcmp(pcie_phy_mode, "crns")) {
> +		s32g_pp->phy_mode = CRNS;
> +	} else if (!strcmp(pcie_phy_mode, "crss")) {
> +		s32g_pp->phy_mode = CRSS;
> +	} else if (!strcmp(pcie_phy_mode, "srns")) {
> +		s32g_pp->phy_mode = SRNS;
> +	} else if (!strcmp(pcie_phy_mode, "sris")) {
> +		s32g_pp->phy_mode = SRIS;
> +	} else {
> +		dev_warn(dev, "Unsupported 'nxp,phy-mode' specified, using default CRNS\n");
> +		s32g_pp->phy_mode = CRNS;
> +	}

most likely it is ref clk property, not phy mode. You can check if there
are standard clk property for it.

> +}
> +
> +static void disable_equalization(struct dw_pcie *pcie)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pcie, GEN3_EQ_CONTROL_OFF);
> +	val &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> +		 GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> +	val |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_FB_MODE, 1) |
> +	       FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0x84);
> +	dw_pcie_dbi_ro_wr_en(pcie);
> +	dw_pcie_writel_dbi(pcie, GEN3_EQ_CONTROL_OFF, val);
> +	dw_pcie_dbi_ro_wr_dis(pcie);
> +}
> +
> +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pcie, u64 ddr_base_addr)
> +{
> +	u32 ddr_base_low = lower_32_bits(ddr_base_addr);
> +	u32 ddr_base_high = upper_32_bits(ddr_base_addr);
> +
> +	dw_pcie_dbi_ro_wr_en(pcie);
> +	dw_pcie_writel_dbi(pcie, PORT_LOGIC_COHERENCY_CONTROL_3, 0x0);
> +	/* Transactions to peripheral targets should be non-coherent,
> +	 * or Ncore might drop them. Define the start of DDR as seen by Linux
> +	 * as the boundary between "memory" and "peripherals", with peripherals
> +	 * being below this boundary, and memory addresses being above it.
> +	 * One example where this is needed are PCIe MSIs, which use NoSnoop=0
> +	 * and might end up routed to Ncore.
> +	 */
> +	dw_pcie_writel_dbi(pcie, PORT_LOGIC_COHERENCY_CONTROL_1,
> +			   (ddr_base_low & CC_1_MEMTYPE_BOUNDARY_MASK) |
> +			   (CC_1_MEMTYPE_LOWER_PERIPH & CC_1_MEMTYPE_VALUE));
> +	dw_pcie_writel_dbi(pcie, PORT_LOGIC_COHERENCY_CONTROL_2, ddr_base_high);
> +	dw_pcie_dbi_ro_wr_dis(pcie);
> +}
> +
> +static int init_pcie(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pcie = &s32g_pp->pcie;
> +	u32 val;
> +
> +	val = s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_1);
> +	val &= ~SS_DEVICE_TYPE_MASK;
> +
> +	if (is_s32g_pcie_rc(s32g_pp->mode))
> +		val |= SS_DEVICE_TYPE(PCIE_RC_VAL);
> +	else
> +		val |= SS_DEVICE_TYPE(PCIE_EP_VAL);
> +
> +	if (s32g_pp->phy_mode == SRIS)
> +		val |= SRIS_MODE_EN;
> +	else
> +		val &= ~SRIS_MODE_EN;
> +
> +	s32g_pcie_writel_ctrl(s32g_pp, PE0_GEN_CTRL_1, val);
> +
> +	/* Disable phase 2,3 equalization */
> +	disable_equalization(pcie);
> +
> +	/* Make sure DBI registers are R/W - see dw_pcie_setup_rc */
> +	dw_pcie_dbi_ro_wr_en(pcie);
> +	dw_pcie_setup(pcie);
> +	dw_pcie_dbi_ro_wr_dis(pcie);
> +
> +	/* Make sure we use the coherency defaults (just in case the settings
> +	 * have been changed from their reset values
> +	 */
> +	s32g_pcie_reset_mstr_ace(pcie, s32g_pp->coherency_base);
> +
> +	val = dw_pcie_readl_dbi(pcie, PCIE_PORT_FORCE);
> +	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> +	dw_pcie_dbi_ro_wr_en(pcie);
> +	dw_pcie_writel_dbi(pcie, PCIE_PORT_FORCE, val);
> +
> +	if (is_s32g_pcie_rc(s32g_pp->mode)) {
> +		/* Set max payload supported, 256 bytes and
> +		 * relaxed ordering.
> +		 */
> +		val = dw_pcie_readl_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS);
> +		val &= ~(CAP_EN_REL_ORDER |
> +			 CAP_MAX_PAYLOAD_SIZE_CS_MASK |
> +			 CAP_MAX_READ_REQ_SIZE_MASK);
> +		val |= CAP_EN_REL_ORDER |
> +		       CAP_MAX_PAYLOAD_SIZE_CS(1) |
> +		       CAP_MAX_READ_REQ_SIZE(1);
> +		dw_pcie_writel_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS, val);
> +
> +		/* Enable the IO space, Memory space, Bus master,
> +		 * Parity error, Serr and disable INTx generation
> +		 */
> +		dw_pcie_writel_dbi(pcie, PCI_COMMAND,
> +				   PCI_COMMAND_SERR | PCI_COMMAND_PARITY |
> +				   PCI_COMMAND_INTX_DISABLE | PCI_COMMAND_IO |
> +				   PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> +
> +		/* Enable errors */
> +		val = dw_pcie_readl_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS);
> +		val |= CAP_CORR_ERR_REPORT_EN |
> +		       CAP_NON_FATAL_ERR_REPORT_EN |
> +		       CAP_FATAL_ERR_REPORT_EN |
> +		       CAP_UNSUPPORT_REQ_REP_EN;
> +		dw_pcie_writel_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS, val);
> +	}
> +
> +	val = dw_pcie_readl_dbi(pcie, GEN3_RELATED_OFF);
> +	val |= PCIE_EQ_PHASE_2_3;
> +	dw_pcie_writel_dbi(pcie, GEN3_RELATED_OFF, val);
> +
> +	/* Disable writing dbi registers */
> +	dw_pcie_dbi_ro_wr_dis(pcie);
> +
> +	s32g_pcie_enable_ltssm(s32g_pp);
> +
> +	return 0;
> +}
> +
> +static int init_pcie_phy(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pcie = &s32g_pp->pcie;
> +	struct device *dev = pcie->dev;
> +	int ret;
> +
> +	ret = phy_init(s32g_pp->phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to init serdes PHY\n");
> +		return ret;
> +	}
> +
> +	ret = phy_set_mode_ext(s32g_pp->phy, PHY_MODE_PCIE,
> +			       s32g_pp->phy_mode);
> +	if (ret) {
> +		dev_err(dev, "Failed to set mode on serdes PHY\n");
> +		goto err_phy_exit;
> +	}
> +
> +	ret = phy_power_on(s32g_pp->phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to power on serdes PHY\n");
> +		goto err_phy_exit;
> +	}
> +
> +	return 0;
> +
> +err_phy_exit:
> +	phy_exit(s32g_pp->phy);
> +	return ret;
> +}
> +
> +static int deinit_pcie_phy(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pcie = &s32g_pp->pcie;
> +	struct device *dev = pcie->dev;
> +	int ret;
> +
> +	if (s32g_pp->phy) {
> +		ret = phy_power_off(s32g_pp->phy);
> +		if (ret) {
> +			dev_err(dev, "Failed to power off serdes PHY\n");
> +			return ret;
> +		}
> +
> +		ret = phy_exit(s32g_pp->phy);
> +		if (ret) {
> +			dev_err(dev, "Failed to exit serdes PHY\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int wait_phy_data_link(struct s32g_pcie *s32g_pp)
> +{
> +	bool has_link;
> +	int ret;
> +
> +	ret = read_poll_timeout(has_data_phy_link, has_link, has_link,
> +				PCIE_LINK_WAIT_US, PCIE_LINK_TIMEOUT_US, 0, s32g_pp);
> +	if (ret)
> +		dev_info(s32g_pp->pcie.dev, "Failed to stabilize PHY link\n");
> +
> +	return ret;
> +}
> +
> +static void s32g_pcie_downstream_dev_to_D0(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pcie = &s32g_pp->pcie;
> +	struct dw_pcie_rp *pp = &pcie->pp;
> +	struct pci_bus *root_bus = NULL;
> +	struct pci_dev *pdev;
> +
> +	/* Check if we did manage to initialize the host */
> +	if (!pp->bridge || !pp->bridge->bus)
> +		return;
> +
> +	/*
> +	 * link doesn't go into L2 state with some of the EndPoints
> +	 * if they are not in D0 state. So, we need to make sure that immediate
> +	 * downstream devices are in D0 state before sending PME_TurnOff to put
> +	 * link into L2 state.
> +	 */
> +
> +	root_bus = s32g_get_child_downstream_bus(pp->bridge->bus);
> +	if (IS_ERR(root_bus)) {
> +		dev_err(pcie->dev, "Failed to find downstream devices\n");
> +		return;
> +	}
> +
> +	list_for_each_entry(pdev, &root_bus->devices, bus_list) {
> +		if (PCI_SLOT(pdev->devfn) == 0) {
> +			if (pci_set_power_state(pdev, PCI_D0))
> +				dev_err(pcie->dev,
> +					"Failed to transition %s to D0 state\n",
> +					dev_name(&pdev->dev));
> +		}
> +	}
> +}
> +
> +static u64 s32g_get_coherency_boundary(struct device *dev)
> +{
> +	struct device_node *np;
> +	struct resource res;
> +
> +	np = of_find_node_by_type(NULL, "memory");
> +
> +	if (of_address_to_resource(np, 0, &res)) {
> +		dev_warn(dev, "Fail to get coherency boundary\n");
> +		return 0;
> +	}
> +
> +	return res.start;
> +}
> +
> +static int s32g_pcie_init_common(struct platform_device *pdev,
> +				 struct s32g_pcie *s32g_pp,
> +				 const struct s32g_pcie_data *data)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie *pcie = &s32g_pp->pcie;
> +	struct phy *phy;
> +
> +	pcie->dev = dev;
> +	pcie->ops = &s32g_pcie_ops;
> +
> +	s32g_pp->mode = data->mode;
> +
> +	platform_set_drvdata(pdev, s32g_pp);
> +
> +	phy = devm_phy_get(dev, NULL);
> +	if (IS_ERR(phy))
> +		return dev_err_probe(dev, PTR_ERR(phy),
> +				"Failed to get serdes PHY\n");
> +	s32g_pp->phy = phy;
> +
> +	s32g_pcie_set_phy_mode(s32g_pp);
> +
> +	pcie->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> +	if (IS_ERR(pcie->dbi_base))
> +		return PTR_ERR(pcie->dbi_base);
> +
> +	pcie->dbi_base2 = devm_platform_ioremap_resource_byname(pdev, "dbi2");
> +	if (IS_ERR(pcie->dbi_base2))
> +		return PTR_ERR(pcie->dbi_base2);
> +
> +	pcie->atu_base = devm_platform_ioremap_resource_byname(pdev, "atu");
> +	if (IS_ERR(pcie->atu_base))
> +		return PTR_ERR(pcie->atu_base);
> +
> +	s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> +	if (IS_ERR(s32g_pp->ctrl_base))
> +		return PTR_ERR(s32g_pp->ctrl_base);
> +
> +	s32g_pp->coherency_base = s32g_get_coherency_boundary(dev);
> +
> +	return 0;
> +}
> +
> +static int s32g_pcie_init_host(struct platform_device *pdev,
> +			       struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pcie = &s32g_pp->pcie;
> +	struct dw_pcie_rp *pp = &pcie->pp;
> +
> +	/* Set dw host ops */
> +	pp->ops = &s32g_pcie_host_ops;
> +
> +	return 0;
> +}
> +
> +static int s32g_pcie_config_common(struct device *dev,
> +				   struct s32g_pcie *s32g_pp)
> +{
> +	int ret = 0;
> +
> +	s32g_pcie_disable_ltssm(s32g_pp);
> +
> +	ret = init_pcie_phy(s32g_pp);
> +	if (ret)
> +		return ret;
> +
> +	ret = init_pcie(s32g_pp);
> +	if (ret)
> +		goto err_deinit_phy;
> +
> +	return 0;
> +
> +err_deinit_phy:
> +	deinit_pcie_phy(s32g_pp);
> +	return ret;
> +}
> +
> +static void s32g_pcie_deconfig_common(struct s32g_pcie *s32g_pp)
> +{
> +	s32g_pcie_disable_ltssm(s32g_pp);
> +	deinit_pcie_phy(s32g_pp);
> +}
> +
> +static int s32g_pcie_config_host(struct device *dev,
> +				 struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pcie = &s32g_pp->pcie;
> +	struct dw_pcie_rp *pp = &pcie->pp;
> +	int ret = 0;
> +
> +	ret = wait_phy_data_link(s32g_pp);
> +	if ((ret) && (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL))) {
> +		dev_err(pcie->dev, "Failed to get link up with EP connected\n");
> +		goto err_host_deinit;
> +	}
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host\n");
> +		goto err_host_deinit;
> +	}
> +
> +	return 0;
> +
> +err_host_deinit:
> +	dw_pcie_host_deinit(pp);
> +	return ret;
> +}
> +
> +static int s32g_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct s32g_pcie *s32g_pp;
> +	const struct s32g_pcie_data *data;
> +	int ret = 0;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;

Needn't check it now. never happen.

> +
> +	s32g_pp = devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
> +	if (!s32g_pp)
> +		return -ENOMEM;
> +
> +	ret = s32g_pcie_init_common(pdev, s32g_pp, data);
> +	if (ret)
> +		return ret;
> +
> +	ret = s32g_pcie_init_host(pdev, s32g_pp);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(dev);

devm_pm_runtime_enable()

> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		goto err_pm_runtime_put;
> +
> +	ret = s32g_pcie_config_common(dev, s32g_pp);
> +	if (ret)
> +		goto err_pm_runtime_put;
> +
> +	ret = s32g_pcie_config_host(dev, s32g_pp);
> +	if (ret)
> +		goto err_deinit_controller;
> +
> +	return 0;
> +
> +err_deinit_controller:
> +	s32g_pcie_deconfig_common(s32g_pp);
> +err_pm_runtime_put:
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +
> +static void s32g_pcie_shutdown(struct platform_device *pdev)
> +{
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +}
> +
> +static int s32g_pcie_suspend(struct device *dev)
> +{
> +	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> +	struct dw_pcie *pcie = &s32g_pp->pcie;
> +	struct dw_pcie_rp *pp = &pcie->pp;
> +	struct pci_bus *bus, *root_bus;
> +
> +	/* Save MSI interrupt vector */
> +	s32g_pp->msi_ctrl_int = dw_pcie_readl_dbi(pcie,
> +						  PCIE_MSI_INTR0_ENABLE);
> +
> +	if (is_s32g_pcie_rc(s32g_pp->mode)) {
> +		s32g_pcie_downstream_dev_to_D0(s32g_pp);
> +
> +		bus = pp->bridge->bus;
> +		root_bus = s32g_get_child_downstream_bus(bus);
> +		if (!IS_ERR(root_bus))
> +			pci_walk_bus(root_bus, pci_dev_set_disconnected, NULL);
> +
> +		pci_stop_root_bus(bus);
> +		pci_remove_root_bus(bus);
> +	}
> +
> +	s32g_pcie_deconfig_common(s32g_pp);
> +
> +	return 0;
> +}
> +
> +static int s32g_pcie_resume(struct device *dev)

does common dw_pcie_resume_noirq()/dw_pcie_suspend_noirq() work for you?

> +{
> +	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> +	struct dw_pcie *pcie = &s32g_pp->pcie;
> +	struct dw_pcie_rp *pp = &pcie->pp;
> +	int ret = 0;
> +
> +	ret = s32g_pcie_config_common(dev, s32g_pp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (is_s32g_pcie_rc(s32g_pp->mode)) {
> +		ret = dw_pcie_setup_rc(pp);
> +		if (ret) {
> +			dev_err(dev, "Failed to resume DW RC: %d\n", ret);
> +			goto fail_host_init;
> +		}
> +
> +		ret = dw_pcie_start_link(pcie);
> +		if (ret) {
> +			/* We do not exit with error if link up was unsuccessful
> +			 * EndPoint may not be connected.
> +			 */
> +			if (dw_pcie_wait_for_link(pcie))
> +				dev_warn(pcie->dev,
> +					 "Link Up failed, EndPoint may not be connected\n");
> +
> +			if (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL)) {
> +				dev_err(dev, "Failed to get link up with EP connected\n");
> +				goto fail_host_init;
> +			}
> +		}
> +
> +		ret = pci_host_probe(pp->bridge);
> +		if (ret)
> +			goto fail_host_init;
> +	}
> +
> +	/* Restore MSI interrupt vector */
> +	dw_pcie_writel_dbi(pcie, PCIE_MSI_INTR0_ENABLE,
> +			   s32g_pp->msi_ctrl_int);
> +
> +	return 0;
> +
> +fail_host_init:
> +	s32g_pcie_deconfig_common(s32g_pp);
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops s32g_pcie_pm_ops = {
> +	SYSTEM_SLEEP_PM_OPS(s32g_pcie_suspend,
> +			    s32g_pcie_resume)
> +};
> +
> +static const struct s32g_pcie_data rc_of_data = {
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static const struct of_device_id s32g_pcie_of_match[] = {
> +	{ .compatible = "nxp,s32g2-pcie", .data = &rc_of_data },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, s32g_pcie_of_match);
> +
> +static struct platform_driver s32g_pcie_driver = {
> +	.driver = {
> +		.name	= "s32g-pcie",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = s32g_pcie_of_match,
> +		.pm = pm_sleep_ptr(&s32g_pcie_pm_ops),
> +	},
> +	.probe = s32g_pcie_probe,
> +	.shutdown = s32g_pcie_shutdown,
> +};
> +
> +module_platform_driver(s32g_pcie_driver);
> +
> +MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
> +MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/pci/controller/dwc/pci-s32g.h b/drivers/pci/controller/dwc/pci-s32g.h
> new file mode 100644
> index 000000000000..cdd0c635cc72
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pci-s32g.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCIe host controller driver for NXP S32G SoCs
> + *
> + * Copyright 2019-2025 NXP
> + */
> +
> +#ifndef PCIE_S32G_H
> +#define PCIE_S32G_H
> +
> +#include <linux/types.h>
> +#include <linux/pcie/nxp-s32g-pcie-phy-submode.h>
> +
> +#define to_s32g_from_dw_pcie(x) \
> +	container_of(x, struct s32g_pcie, pcie)
> +
> +struct s32g_pcie_data {
> +	enum dw_pcie_device_mode mode;
> +};
> +
> +struct s32g_pcie {
> +	struct dw_pcie	pcie;
> +
> +	u32 msi_ctrl_int;
> +
> +	/* we have cfg in struct dw_pcie_rp and
> +	 * dbi in struct dw_pcie, so define only ctrl here
> +	 */
> +	void __iomem *ctrl_base;
> +	u64 coherency_base;
> +
> +	enum dw_pcie_device_mode mode;
> +
> +	enum pcie_phy_mode phy_mode;
> +
> +	struct phy *phy;
> +};
> +
> +static inline
> +bool is_s32g_pcie_rc(enum dw_pcie_device_mode mode)
> +{
> +	return mode == DW_PCIE_RC_TYPE;
> +}
> +
> +#endif	/*	PCIE_S32G_H	*/

unnecessary for seperte file now. You can put to c file.

Frank
> --
> 2.43.0
>

