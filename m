Return-Path: <linux-pci+bounces-23877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F5BA63332
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 02:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1936D16AAF3
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 01:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EBE8F64;
	Sun, 16 Mar 2025 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iNlH+u1B"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEFE5227;
	Sun, 16 Mar 2025 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742088912; cv=fail; b=dQzTgryDYWRek0n0n4LtdEkTcHKh47md+UGPkols81ShNUbf44pe+3NaLSqu1FUANd9lkDo44sc7xxKoFlIEZbfzlix2tPat2+gqAlQ5u9TJ9emCWA22xXl92Enf9PdaHnGfTyV9ovs7iRTRmmu8fn3PYUDOs/2Ol5YwQEGePf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742088912; c=relaxed/simple;
	bh=e4cHx8OCSIX8JAAwIM6uImd9eoNxxPuXMtP5V4D49rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iR6ItC5Ws+zzOJJlrtUGKTGYOwSbYQhvbH+pb7y4D6SL2Ns5/sinYq6f9DfGUpFBPwd41hazMiOJzvNtFU5Nwdtz/dMl1KP1954m8iji7wkl70/p9cp1LsrakPF2ft80MK1AAd1DdqpYJrZiGHaY69TGzRnAr+PsLQNzdGReXdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iNlH+u1B; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHr6AwbCTdEIY3LIMfFz09q2Pb4Qvw29ofL/iGvs3rYRjjC+OKFX7RRxCuTIaXUhAiGpwt74hRjTNLsmUGfSGjihqixSokokONabP5MRN4ox5Z/MgYGr3esy7KWMsKM9n/bmsAMtPVbL2ecnhXwMX8gUO8iGiinR94L3jNi0NhJCgK7l28zdgrZfFU1B4evrs7M/NX73u47dAtnfPESDMVWI2aNpMpS4ZmWaouhjntVzs/6pqdpfxCHhnpUoj/tndSKTswFbMnw8KJ35A+9M0SDq4z7e10sfaiciVbztUnwoQuJ/GpSJ2Z+PSasQBww1Lw/7KCMylHGY1bVwwT409A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67zmGeXuCMRKWzEElMLEOJVKxGDQpwBgMA6Rp1uyIXI=;
 b=WyXrMldp56nvErD+rfLPi1X6ucYj2Stwcz6pzcXWxy+wB1YUZtgsPXH9VMvXnRpBuM3f5pFNYdlH4ohhHQMIn7/nmDd+cQNFb6vixCwP9puSc5UeqlplcbWGFegNt9pshqk2bRySk1dVYaHPEa6Ct4HcgkL7TDWAd4ZqefzMD2AAEgTsYdkh1rUv5419DqLZZsmqhbs1ROHwmFVvIBuaFrbe4lW/9hhpRsF/KLU82kT6uDTNMc+yLAu0c8LTTbYyPY/PU5bUMiZW4zFImFp9GYZtwOChEd3m1R5SJqqrGvb9pXivXwOiRRuDM2b7r8TEqhG/6RnVKXRF9qWCEpc/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67zmGeXuCMRKWzEElMLEOJVKxGDQpwBgMA6Rp1uyIXI=;
 b=iNlH+u1B/MrAl2Au7UkRJ6ySxJdNDICc4MvjKIjuo7zmvyo4bDsAWL0sGvno0DZCYnsntFvr5ewe6haAt9XcEu7RPfqRSwYxSqVHSoXFuSuJS0tVcLLXPYFXQs2pJFrlAgpQgyHuUftBaTCRIIcgr2doTH3ddpjrppT6mjecRrSS3HnqdNkGmZ9nrkEAHS0k4ntpAkqjBw1ewlCB2oweBGPQ6M/yDnl3Kno3qmWX7Va4Knflnsdy3TF5xQe0rjx1/GLJtgbg5y9gxOBnn0TL/k9m7cKz7n6o37w2hQljJkxKjuhnCYHb7UqBOncEpcNIc6Fli8CVtQI0jQHPvKsPjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6964.eurprd04.prod.outlook.com (2603:10a6:208:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 01:35:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Sun, 16 Mar 2025
 01:35:07 +0000
Date: Sat, 15 Mar 2025 21:34:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 12/13] PCI: dwc: Use parent_bus_offset to remove need
 for .cpu_addr_fixup()
Message-ID: <Z9YqwXG5yrQX8Mep@lizhi-Precision-Tower-5810>
References: <20250315201548.858189-1-helgaas@kernel.org>
 <20250315201548.858189-13-helgaas@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315201548.858189-13-helgaas@kernel.org>
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a28707e-2316-4448-aa6e-08dd642ac8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tISBMOx6ePZHcpW+ig/sMYJ99vEzIpEzg/YrqBNc0x/sJvtYIzNZZf3vQUdT?=
 =?us-ascii?Q?NNfJOGbnwbTQ3hPhK51p/94Bm5jj3Wdmt5RKBPFP/WrihtkSvaI7ECvMdjTz?=
 =?us-ascii?Q?vglnQoskm++AAKJho6W5P7Uy46m6CWapylpT5wVlHfqfwxPsrGehXhQcoZHJ?=
 =?us-ascii?Q?8N7ApXJ9iOKEP5YQwQl0z84ZrmrSr2vScVKd0BD0B26pMzwqWgESJJPSq/v1?=
 =?us-ascii?Q?+YC/BfWQRJ8oe4Us+318jvq/GXQmnYO6eG8PqYuPD96pFVwNHmCKpf+afny6?=
 =?us-ascii?Q?7UGIAslp13QjLPUoKgIbUDuNZ5jJMsDotfVTYU2xDpDn3h9FGyrc2rvmi2Cy?=
 =?us-ascii?Q?gcNZDSRJ9N2hlb9bKy6ugnBCh6kEobpo/ag5N/XsHwnCfAe2W6LmE/5Bw8Ut?=
 =?us-ascii?Q?PfE8srtZoGMAVMcdivgoNjttb3L3xEOr9mrAau8MH0Jykc2fMaDGa9bBsq/7?=
 =?us-ascii?Q?5Et+Y+oh2xvlO3SzvvjRs3vJJtx3E+R8BKIU5tQ+MsAi08Yq0yEwEqFPtTvf?=
 =?us-ascii?Q?fDx3xvHbQEW5CjjflcmC/pezKI00IS+Fj3OlPXIhmIrjMQNoxfKcLDU/NMEi?=
 =?us-ascii?Q?iJZu4N6qu4ucGIPW3+RxjjsSJo8S4PBe3e1+Cgf03fkn0JAfOrFnq37GIUzQ?=
 =?us-ascii?Q?t68hVWWTnYL66jwZyqGjIW9DSaaZLSLPg2Kxg1dh/tcXiJIUfp3krIdOB6Pd?=
 =?us-ascii?Q?heswcMG+x5mdtQwjMXbvE4HvKJo0//yHaPIM8v8t04ACRKegXgEnoG0oMCdA?=
 =?us-ascii?Q?XqveAZJMZhmkR9eHwn8kuPRWP7zPYBF87xE1ANKxOelX941J36OpMEXioSoA?=
 =?us-ascii?Q?FRdTb6rd/lH9Q/cMme6Dj+4u6KZoTcsSdyFBofT+l5iOPBwssOtelBKWxNMw?=
 =?us-ascii?Q?3WsmIObk4kyGm60q5QN5vfJDWxmV8890y23tdFLiYAXwzka+uEszrX4JZ8Yd?=
 =?us-ascii?Q?QTKQHcC1V+1WKlOlB9+/NuHAqLcgzPRDufFzwKuUCiDWAB0vi/CFKcgDglwN?=
 =?us-ascii?Q?LwntPSW4JUp05JThwa3x4OfKZy4DOnHnLrhrWc45kcmQrsVZK8xJ67UTb7aX?=
 =?us-ascii?Q?uaAVEkNcXAlojhhuT13Qt0+b3M9gXEy3ZE3YkvQtxaHfCoKmCB6aM+z5H/KM?=
 =?us-ascii?Q?CUqjRiKyf/oO5SSm3j4QVMsPnkqK25RuztgxWG67iW6Fk57ydx7ZEw1yn6Zt?=
 =?us-ascii?Q?bYOVrk9mdwUtpTj/3VFCukUsq7X4K+OqVcNEVIP56wwM9Tn0LlqsAh8ix64P?=
 =?us-ascii?Q?tDhM7XA0YvS0+yJS8qkSACN9NA9yaaT7ltEJYrQqi/szP19SnzWTMSPXT6x4?=
 =?us-ascii?Q?uRR8YbKXP4xFrtiEDwzmQysI4ClPHY/2OwLQ3thRyBtdFXMQYBqQkEdx+Rb8?=
 =?us-ascii?Q?3OegP5lPs96qCCmBCDv4sljiSsTUfqoEPgkllBhuDabFtHcMPyHMLJKXLgkS?=
 =?us-ascii?Q?x2X1oWhuCR0VUo3X3xb8CR0dO+yiWwka?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3SwZBQKjMsxSneUXzxJ4KMOIfZOomsSwapIDTw78C4GtUqRFHCOSLpFP0t8c?=
 =?us-ascii?Q?kRT3H9pfZCEro7OeOd57PtKodthZ2jHBNDaP0Izj8tHViAR4MC1btyKbtgWF?=
 =?us-ascii?Q?vbStWeVvn2M359wqSNcC3CtIjvY0FuMSZH9iT1rnNUn6c2zmjSvqcQY2OW2N?=
 =?us-ascii?Q?qbX1LFD6iKNK6cymiGP6P3GT4qyYIyh1U9wS8WMFe/RMsO8FMfc+Z3wy4WtI?=
 =?us-ascii?Q?AYwjU71EKl771uSsoWx4zJGj3926hOY8IiZvza0WUpTu8Uf1RaXK5Cp191qo?=
 =?us-ascii?Q?UXPpsy72CsGI7zmiy60L4BwCTO3CFy8U5agA3stxx+OtFxlv+4ghOfScNK13?=
 =?us-ascii?Q?1ekbTxf1n2UuOoIDLpm2Jm++XJI80zdiB3oV//SOthKZL5Sp0GYZ1r8AK0d/?=
 =?us-ascii?Q?t8Nm6BLIR7FiFiVs6E70O5o6BRKTI+Xku8kl1NHiSaV0yCueiSugEmqCgm/M?=
 =?us-ascii?Q?QxijDSnCE3Ck41zdbYArmqW95OEFx1vOKMQ4BnPwHL5/IW5TfhzSeYmimk/m?=
 =?us-ascii?Q?DHu2zVrmx6mDK/6eROniGpTbAP6FExd2D49PYRTl8+gY5IVh18gWDHkl648D?=
 =?us-ascii?Q?QmhBF4sxsA9ATaTDAGEiJfYDVCUD27hkGugSL0gzltm0LXhHF3iZ6TTUZdeE?=
 =?us-ascii?Q?CZBthzwzYiF2wJRJvaQtuxzD+IwKFg0Uxko0ycEVD/O1itVk7SyizlDFM9jz?=
 =?us-ascii?Q?k1kxaxE41x/iQz/GE5yUQ7zNRtjcfEkKCI0DriObfLyw7KMJKtj//iyemmt7?=
 =?us-ascii?Q?BtaPUOKQB2d8QUsCxFHFcS/5OWr1Oc0mtxgXwYMGPehL2G+YvBGMLKpMPOQq?=
 =?us-ascii?Q?O/oMqUVr4+eFEdYxP+2LvJ8/jJG3ZPAnktMJ+wJZNAM0PNVU7vsWbvggQRFE?=
 =?us-ascii?Q?LK3sP6RbNbfufgghc3Gfg8PtJILIK+P5w8mfL+ueahd4jttTWV8Ree7jQrFi?=
 =?us-ascii?Q?O0wYPe7rRuGqVPbccqT+liMLxj+3MYOwBoOku7IhiLgsSkIYwxKJsPSSKsPy?=
 =?us-ascii?Q?xFiclruo4yQcqNjVBjDUSIzJm8UZwCCvBc2VEeFSRWHXOfSJRi8htSMdR6wd?=
 =?us-ascii?Q?EjpjU14zY5QOZwko5i96MQgFQ2djm8AROOs9kh4LVhWT0qBTmx5hcX2QTBx3?=
 =?us-ascii?Q?htPcFbSc6W2Doc3PpfpbveZQZgAoyWoKaTO9HlBpX6vrgJ0WiIyKaecZ+Sfj?=
 =?us-ascii?Q?Jie4zqtgXnYjbApoM8zG12f6ikUAIjFwtOjwotdqg73P2687RVj8dFTjem3N?=
 =?us-ascii?Q?xq0otl+mAcAR87i+xj7yKTWcADFbZDBbqVNPkmvMRkM+Vau3TTHIQre2own5?=
 =?us-ascii?Q?HDb+EhgdgSaL0nBs1lUZ4PTvWlOpMCN74/abVv1Hh7YAfxmezDEAcJrrIOBP?=
 =?us-ascii?Q?IAqxhmiC1RFQD8wVUqc1du6T2whxMECDGaKMeexUyovZhLr2077EqB9ofdDX?=
 =?us-ascii?Q?0rqapTxBFlM4TUxjHSL9u197NVcqKyddwekwndWr1+m2iLvkIyw7L543BIVo?=
 =?us-ascii?Q?Fxns1X7R53fSEWV1oxpKP8oI9COsrrxMzy9lMWKd495sOCMLuLYJjh0QurpD?=
 =?us-ascii?Q?kcp416y5UH4tj9caf0LnozI6051CmD6ELNluMKQL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a28707e-2316-4448-aa6e-08dd642ac8b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 01:35:07.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UC0rOBePPCb1i7fdmHGy0GAq3R2OYIdU3orryOEIImr4VA75HFzT0B4e4Z54QzrGmXpcwkbYcH6K5JCh7iD/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6964

On Sat, Mar 15, 2025 at 03:15:47PM -0500, Bjorn Helgaas wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
> We know the parent_bus_offset, either computed from a DT reg property (the
> offset is the CPU physical addr - the 'config'/'addr_space' address on the
> parent bus) or from a .cpu_addr_fixup() (which may have used a host bridge
> window offset).
>
> Apply that parent_bus_offset instead of calling .cpu_addr_fixup() when
> programming the ATU.
>
> This assumes all intermediate addresses are at the same offset from the CPU
> physical addresses.
>
> Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-9-01d2313502ab@nxp.com
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> [bhelgaas: commit log]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

look good

Frank
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  5 +++--
>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
>  drivers/pci/controller/dwc/pcie-designware.c      |  3 ---
>  3 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2ef9964fa080..c1feaadb046a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -314,7 +314,8 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>
> -	ret = dw_pcie_find_index(ep, addr, &atu_index);
> +	ret = dw_pcie_find_index(ep, addr - pci->parent_bus_offset,
> +				 &atu_index);
>  	if (ret < 0)
>  		return;
>
> @@ -333,7 +334,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>
>  	atu.func_no = func_no;
>  	atu.type = PCIE_ATU_TYPE_MEM;
> -	atu.parent_bus_addr = addr;
> +	atu.parent_bus_addr = addr - pci->parent_bus_offset;
>  	atu.pci_addr = pci_addr;
>  	atu.size = size;
>  	ret = dw_pcie_ep_outbound_atu(ep, &atu);
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9e38ac7d1bcb..d760abcbb785 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -635,7 +635,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>  		type = PCIE_ATU_TYPE_CFG1;
>
>  	atu.type = type;
> -	atu.parent_bus_addr = pp->cfg0_base;
> +	atu.parent_bus_addr = pp->cfg0_base - pci->parent_bus_offset;
>  	atu.pci_addr = busdev;
>  	atu.size = pp->cfg0_size;
>
> @@ -660,7 +660,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
>
>  	if (pp->cfg0_io_shared) {
>  		atu.type = PCIE_ATU_TYPE_IO;
> -		atu.parent_bus_addr = pp->io_base;
> +		atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
>  		atu.pci_addr = pp->io_bus_addr;
>  		atu.size = pp->io_size;
>
> @@ -686,7 +686,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
>
>  	if (pp->cfg0_io_shared) {
>  		atu.type = PCIE_ATU_TYPE_IO;
> -		atu.parent_bus_addr = pp->io_base;
> +		atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
>  		atu.pci_addr = pp->io_bus_addr;
>  		atu.size = pp->io_size;
>
> @@ -755,7 +755,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>
>  		atu.index = i;
>  		atu.type = PCIE_ATU_TYPE_MEM;
> -		atu.parent_bus_addr = entry->res->start;
> +		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
>  		atu.pci_addr = entry->res->start - entry->offset;
>
>  		/* Adjust iATU size if MSG TLP region was allocated before */
> @@ -777,7 +777,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		if (pci->num_ob_windows > ++i) {
>  			atu.index = i;
>  			atu.type = PCIE_ATU_TYPE_IO;
> -			atu.parent_bus_addr = pp->io_base;
> +			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
>  			atu.pci_addr = pp->io_bus_addr;
>  			atu.size = pp->io_size;
>
> @@ -921,7 +921,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>  	atu.size = resource_size(pci->pp.msg_res);
>  	atu.index = pci->pp.msg_atu_index;
>
> -	atu.parent_bus_addr = pci->pp.msg_res->start;
> +	atu.parent_bus_addr = pci->pp.msg_res->start - pci->parent_bus_offset;
>
>  	ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  	if (ret)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 985264c88b92..d9d2090f380c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -475,9 +475,6 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	u32 retries, val;
>  	u64 limit_addr;
>
> -	if (pci->ops && pci->ops->cpu_addr_fixup)
> -		parent_bus_addr = pci->ops->cpu_addr_fixup(pci, parent_bus_addr);
> -
>  	limit_addr = parent_bus_addr + atu->size - 1;
>
>  	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
> --
> 2.34.1
>

