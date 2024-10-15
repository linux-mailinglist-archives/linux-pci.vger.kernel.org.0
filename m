Return-Path: <linux-pci+bounces-14556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690DA99F2A7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892291C220A5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA11F4FCA;
	Tue, 15 Oct 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NqjAqQrW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3B14F117;
	Tue, 15 Oct 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009476; cv=fail; b=Fg/FlzbELt7k6vIHGG9DJKGx2TSv+xsFxgi6GjOKVvmftuhLaOFXozhQuvdPlEZUdLMdOlmQE8X4621eNHL63LqE3/W0vdVe+A7jXbE3xpOgrxPx6owNqwDlxqb1N8qE33UVF7px1c/1CB0hiPTeUxmCy6fCXHuhncsJGC/2P4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009476; c=relaxed/simple;
	bh=xpbtzw26jTdh4aArcdBDJIrgAIarkF9Hh6r2N9Fk58A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AdBzGpkXHxwyB74syeXkP56DOzaggS9Om9/oz9BbEhrWJcCGv+f25W4u+206DzCDYoxVgtPd2Af9PacoJBuUn4+WxAvvmQD9LVQaHGa2Q5VRmkgdk9qgO6KvuezQLGjzD3V3Rmo+WJT3EJu5pE5e15nVq/41jeSc4jUNhijmpxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NqjAqQrW; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggdn4XIkME1XcDGqBmcMbiOKt1lS+iuij4LcVWL5LEetng4smsMNBSbEgBi+s99DCvA6bP5FZZ1/nRTUs/y3t2Eq52rxirqf5xRJtHdrpBI32eeK7CVkCgxjA035enD18EjgPmuQLTrAJRhFQfRl/oq+9vjokhHOn/FIavLq8qEM3jfq0FWNjegtSdzkOFLStcAeJxeOCWDonkbjIfJvyNJtltyZKe4ag1A40rmep7C5MlWApJGQILAmcQIBkkTeP8uZiYMZXWamYJ6bcYPhU7gHDFrHAt0LaFbW57sLt9PLuiKE4lSfujjPPx23cilLDLRxSMlxZWENt9tZ9mOuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8rcNNV+ncKy/KcILKRg9gH8PYYm0OjQYLUGQhEf4RY=;
 b=Nb0ps6/OG4VKJj1w3sKBaqpF0DVsa4cc3HYKuJ0MuLBhepdQE63xoj89GBoWNq/WPu7kM4N64JtyaSfetgXixBN7/84AMIIUPPwLUuKARUlf3LfCaQib1CzB+QCk82eDB1W9IJZwKNTZhoxuzy39c8amMZzAZ44JNQ5BAuJx7wDrYWHFJmBjXiG/vVI1ftiT9IX4voFyD1KWksxIKwLxzB9OHeqz4le5Om8TXf9wJ7n8QBapQseDHC7DACOo4oQf58kyOXM7lyHgDusR236qhP7Ay247NsXvr2q7Ba12cLMOnXRCBN+EYjuJ/NedMJYz+Tcx6uZPoCz2rvO8tPLdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8rcNNV+ncKy/KcILKRg9gH8PYYm0OjQYLUGQhEf4RY=;
 b=NqjAqQrWWOE/4/VMOg8r3TF1FJg2U5jdVKZzbe+rfWNpYXeHk5nNMUfUfUbZN6/pZgwBAG2GM1fgSEL8BpzOrVDVl1pftNU84M7UPQ9VSTfGnNSSC9fEyHbhdwRIiabQmfXrcMNli6z8ibPrRu47Q1IKjY913J3JxSzPPdmb5llXA1w4qlc9rlxAY7RSRJEYCt0I3QrcncUKpBHeCwW/0SZBRndbUlqkARnRNm83zHmM0TrKFAufvwqDms3sk34DADKVSeDCDLDPBTB6puZD2EMejpJCKQ4MUl59SAJBEcFpMUZ4pRr9S4PSIbEl+gxy2KjOFkRTAF2f87pm3L380Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10850.eurprd04.prod.outlook.com (2603:10a6:150:216::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:24:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:24:29 +0000
Date: Tue, 15 Oct 2024 12:24:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 net-next 05/13] net: enetc: move some common
 interfaces to enetc_pf_common.c
Message-ID: <Zw6XJVvUKl7abjPb@lizhi-Precision-Tower-5810>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-6-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10850:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcea4a9-d0ec-4e3b-a3a4-08dced35d829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OOJKv76ICs3y6Q1cy8AdXhKgJnPa+9EtnJztDBJQTDJCZAhpOzOPMdUraTbK?=
 =?us-ascii?Q?89fDqfgaxr2GOe2IXQPbd8EoB1uBLOlLELrKVgrRmGoTAOjjJPrIXq1b0uqV?=
 =?us-ascii?Q?GAX5tsqhcm3RVfkBSIjPMkjmED2FAvhqFfSE3ahKfzb4Lx9cDEk4T9o5EyaX?=
 =?us-ascii?Q?Or56axNjWgXfyz8bdsAO4n0td9ON9Yko33UWEFrBiqC2anGD8ZEaViUMbSdm?=
 =?us-ascii?Q?Fgi1kZ3OqOaINAEOzhDTo0ml3hAs8TdaIAU/47Y9S/DTWVnP60g0+fx2lzoU?=
 =?us-ascii?Q?Lpzsrkx3j2wXPCKM3V6ROMn3ESHyLmKjxQnaiBDhvaKwXf8a6C9HmS+JuHwI?=
 =?us-ascii?Q?2GafkKsudf4U9DQHddW+s68Ez8EIfDKtlT8q8pzeavJlw3Cmgi8WBGUqnOc1?=
 =?us-ascii?Q?yiCZb3eKKFQnB972zio/4JOP/WaxkP1ns3UifHSoU+v0SeIgLH5iRE5tNikr?=
 =?us-ascii?Q?PyOUbYQrerjun7wMW9sLs0nUYbT/tu98wjlvQKPo4SimbEJBk/6EQoqKjMEV?=
 =?us-ascii?Q?cJhd0tKXtIb+qi3voYLYN6hjBawGkOVpx23B7fxIvaJMbdgVZcP6VwLQLN/4?=
 =?us-ascii?Q?myIKC9IKCSt2yS6y8QDePVBJrNrfYCq+cQglwhKM/QJVeRdY5rLkAvkaoKMR?=
 =?us-ascii?Q?WzglN+M/UYn4OGZ/Wi8MN6bHHhBZqGi9Eo3o6zzxR04FRT73g3QoS1fZl/8A?=
 =?us-ascii?Q?HzVW32vtNhrYlAauUQUdAUFcped8/N2lCO5kQHPm4n03sCU/A8aY+S+D246I?=
 =?us-ascii?Q?4p0ZkTUjShcljk8BpjAQ6pBfYxzcbrOeV/Qe980S5HpX9kZlLe+TzcgTK/Ic?=
 =?us-ascii?Q?GT+Wf8MvYENjPi6/E1rKBTA8M6qn5dYB/mfkUb1KrOPJ6LsXvCFEn95AsfxZ?=
 =?us-ascii?Q?CYOElC2gkiGYILDzhgOLCQjnIMk0x4uIkWOEepoNWdbBey/Nq46xUIKi7Nv2?=
 =?us-ascii?Q?lXWvnFb6U2EozIPofDVQ01+EAeR92lTuroPmZQIqOrEDITcPDeZQ3dXQ6xev?=
 =?us-ascii?Q?BIPJoP760OdBv7NOJXCX7po/Vzph5Yl5unlZsZsIGAEnYA/Nxr0wIVPU72Ye?=
 =?us-ascii?Q?oz1ox+J0HvlRWjnhM2hm/53W/vWjUI6sbNjmJ/VVdeVCQ3qvUK0DJaZZGqsE?=
 =?us-ascii?Q?SffKLPxO/ra77juU7tBDwKQbZwrzLA4XxRu3OYRXaSerTCTrPCnbrSZ5tnU2?=
 =?us-ascii?Q?IHIiNjBJnpTZ8ObbW0DhvxM7wR6sKOGkLWCrE1aRH94OPPi3S7JhRyVAtLEn?=
 =?us-ascii?Q?A6TyrGhDR375TbrwtFlIa5rviIkFUU4y/0Ww2f/fEoVqa33RI9EBWjQ8Ld1A?=
 =?us-ascii?Q?K+rhaas+RHGLyrEhaSahPYdLPsMZV9aVEOtzhwYm2Pq9nA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ctpUUNoST1cMf5HWoRhDg97/6ugtOJvUTf9eJDhuUzVxMtf4mMp4qvyFzYu5?=
 =?us-ascii?Q?J0bCHMQCcvlB/5+hyZ8S0e3YJKgD4VIe6Wn/HVFpf9sftIlm2JEJvfzeIZbE?=
 =?us-ascii?Q?PedS8xtTAAJAOzUXU7STacBQwihE6Qt37zRkq+2tqVLJ6ZapyGLMlO1iPYNi?=
 =?us-ascii?Q?jJbOmun/AbShye7VUX3Hwj1X2x7z9LFuArvL0SSjbGfPIzZ0q8wBZ0Bd4jbG?=
 =?us-ascii?Q?2TnOC+rHAVwCxJbHu/THWYzcrRc7xJEzWK+4wdcCMp0irqjjSs1n4r+FIm07?=
 =?us-ascii?Q?4i7K7EQMIz01kUhN2uLWShupnqDgWFZyMndzc5U67S1igqMHsiHZJvtc8wJc?=
 =?us-ascii?Q?Vg3Er4F1yu9klltSSXdszYiWqoO8yw+oqps/jpJGVe/SIlCy2YDlcgEXkvxJ?=
 =?us-ascii?Q?XCo0h8GAtt+whPFfT3WPZFQ1tFzhVnU2RypUcSYyaM2WDF6UxtE8acJqxQiK?=
 =?us-ascii?Q?60upBxgwlfKiGL1E0cP7XYVJV6DzAyz2VEE+/2K5P5oAUz/QIWWe4zufD53n?=
 =?us-ascii?Q?U4sabjJmj6LrP3fTcy1YYYcuOGPV72EEne402oRQWIynecPododGi4ZpesnE?=
 =?us-ascii?Q?82Pd16VtCgF/067Pfbp5IeERQr/qCS1dLFhnZ7F4UmNNHl4czrc22rH/x9jx?=
 =?us-ascii?Q?8uTeK/aaTS+w9rAfCnBXqQ+lkp7KutktXEGY0gL4psqkFoUy+4+0uwJrnNLa?=
 =?us-ascii?Q?0K+1GpkREe+KfOTBtUGK8EgXLYozgN64P7h6yg664UKVqKiJEN+AKm9l/9in?=
 =?us-ascii?Q?5odzjKD3d96YWgkUeP6kEJW0ArRI0wG0vF0e1vs3btWZjakZWkJUboqxqnsX?=
 =?us-ascii?Q?qXiIrzfYEJSLnIbCFBndEVnwEtVlwY6zqv6Rv5Eo6kwZHplvN9/m3LI63O2J?=
 =?us-ascii?Q?4sYLtt8Yu7Q82qWP7g04PF83KP1w2Cx8Zcfts2o/aj7LVa1aFAnWkgIHFX8C?=
 =?us-ascii?Q?b/lxOGSsJAD870BJdBCTiqWPE8bwGc/IEQd9kfzPtS3P8o4zjs6rF3DsdLPq?=
 =?us-ascii?Q?26NKuU8WEIEtGwAviG6NRCqzdKurnjhxyojj8puJfaSq1AfRQUbLVogn1Xi/?=
 =?us-ascii?Q?koSBOSfDGXDH3duq8nORJgJOI/p2+/WngE81FQM9H967+rDrbT2sIfyaUdCm?=
 =?us-ascii?Q?PodzxR+i//TykAepalckQ6ypAa7a7cbHIuxSJIuSX6harc2DeQAzZFYxpPcm?=
 =?us-ascii?Q?ZotPDmtegbHPVvrrTUuv5mzfCcKC21U6zfbviaOSMCt2TbLMakleOK1xjsLz?=
 =?us-ascii?Q?1AIIJAykVttLXKafHc3+J/Uu0+gnlSGxpVSTeAvVFxqGplJiOOUO7tTKuDaC?=
 =?us-ascii?Q?UQHEft1/zGeWxquWXLqwL4PtiGTGu5SnN4oVn829ZMKIg+Bw29PWDtYWdayv?=
 =?us-ascii?Q?GdOHb68Hgq5Xang8ynSXVnivAQBtgXG83MdswwfrE8HvGkHXJfjOAfbPWu9i?=
 =?us-ascii?Q?l/DrcvhT0LUadgmuPHvhE6Rf25+t+WhBobmbSZOERn4F5g98gkX1gsgsigtx?=
 =?us-ascii?Q?A3HXBNqgLC5UekCYm3ZNQ+i8vdI1VRk2UnDSi35vMTAY4XA+46kGeQHbMQdM?=
 =?us-ascii?Q?pQwqjsZYi1QTE9Qyu32bIPxz3D5aL42ZhyBiDz2m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcea4a9-d0ec-4e3b-a3a4-08dced35d829
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:24:29.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+oP7yokkWbNniYiTrDPOi/i+uwgCUxlCasVFS8TBRtT4WFaBP3seeS/ynEPHkig8r0Ob5PaP5WjiIZ1QsVxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10850

On Tue, Oct 15, 2024 at 08:58:33PM +0800, Wei Fang wrote:
> The ENETC of LS1028A is revision 1.0. Now, ENETC is used on the i.MX95
> platform and the revision is upgraded to version 4.1. The two versions
> are incompatible except for the station interface (SI) part. Therefore,
> A new driver is needed for ENETC revision 4.1 and later. However, the
> logic of some interfaces of the two drivers is basically the same, and
> the only difference is the hardware configuration. In order to reuse
> these interfaces and reduce code redundancy, so extract the interfaces
> from enetc_pf.c and move them to enetc_pf_common.c. This is just the
> first step, later enetc_pf_common.c will be compiled into a separate
> driver for use by both PF drivers.


Extract common ENETC parts for LS1028A and i.MX95 platforms

The ENETC for LS1028A (rev 1.0) is incompatible with the version used on
the i.MX95 platform (rev 4.1), except for the station interface (SI) part.
To reduce code redundancy and prepare for a new driver for rev 4.1 and
later, extract shared interfaces from enetc_pf.c and move them to
enetc_pf_common.c. This refactoring lays the groundwork for compiling
enetc_pf_common.c into a shared driver for both platforms' PF drivers.

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
> driver support"), it just moved some common functions from enetc_pf.c to
> enetc_pf_common.c.
> ---
>  drivers/net/ethernet/freescale/enetc/Makefile |   2 +-
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 297 +-----------------
>  .../net/ethernet/freescale/enetc/enetc_pf.h   |  13 +
>  .../freescale/enetc/enetc_pf_common.c         | 294 +++++++++++++++++
>  4 files changed, 312 insertions(+), 294 deletions(-)
>  create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
>
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
> index 5c277910d538..39675e9ff39d 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
>  fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
>
>  obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
> -fsl-enetc-y := enetc_pf.o
> +fsl-enetc-y := enetc_pf.o enetc_pf_common.o
>  fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
>  fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 8f6b0bf48139..3cdd149056f9 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -2,11 +2,8 @@
>  /* Copyright 2017-2019 NXP */
>
>  #include <linux/unaligned.h>
> -#include <linux/mdio.h>
>  #include <linux/module.h>
> -#include <linux/fsl/enetc_mdio.h>
>  #include <linux/of_platform.h>
> -#include <linux/of_mdio.h>
>  #include <linux/of_net.h>
>  #include <linux/pcs-lynx.h>
>  #include "enetc_ierb.h"
> @@ -14,7 +11,7 @@
>
>  #define ENETC_DRV_NAME_STR "ENETC PF driver"
>
> -static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
> +void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
>  {
>  	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
>  	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
> @@ -23,8 +20,8 @@ static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
>  	put_unaligned_le16(lower, addr + 4);
>  }
>
> -static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> -					  const u8 *addr)
> +void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> +				   const u8 *addr)
>  {
>  	u32 upper = get_unaligned_le32(addr);
>  	u16 lower = get_unaligned_le16(addr + 4);
> @@ -33,20 +30,6 @@ static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
>  	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
>  }
>
> -static int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
> -{
> -	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -	struct sockaddr *saddr = addr;
> -
> -	if (!is_valid_ether_addr(saddr->sa_data))
> -		return -EADDRNOTAVAIL;
> -
> -	eth_hw_addr_set(ndev, saddr->sa_data);
> -	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
> -
> -	return 0;
> -}
> -
>  static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
>  {
>  	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
> @@ -393,56 +376,6 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
>  	return 0;
>  }
>
> -static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
> -				   int si)
> -{
> -	struct device *dev = &pf->si->pdev->dev;
> -	struct enetc_hw *hw = &pf->si->hw;
> -	u8 mac_addr[ETH_ALEN] = { 0 };
> -	int err;
> -
> -	/* (1) try to get the MAC address from the device tree */
> -	if (np) {
> -		err = of_get_mac_address(np, mac_addr);
> -		if (err == -EPROBE_DEFER)
> -			return err;
> -	}
> -
> -	/* (2) bootloader supplied MAC address */
> -	if (is_zero_ether_addr(mac_addr))
> -		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
> -
> -	/* (3) choose a random one */
> -	if (is_zero_ether_addr(mac_addr)) {
> -		eth_random_addr(mac_addr);
> -		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
> -			 si, mac_addr);
> -	}
> -
> -	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
> -
> -	return 0;
> -}
> -
> -static int enetc_setup_mac_addresses(struct device_node *np,
> -				     struct enetc_pf *pf)
> -{
> -	int err, i;
> -
> -	/* The PF might take its MAC from the device tree */
> -	err = enetc_setup_mac_address(np, pf, 0);
> -	if (err)
> -		return err;
> -
> -	for (i = 0; i < pf->total_vfs; i++) {
> -		err = enetc_setup_mac_address(NULL, pf, i + 1);
> -		if (err)
> -			return err;
> -	}
> -
> -	return 0;
> -}
> -
>  static void enetc_port_assign_rfs_entries(struct enetc_si *si)
>  {
>  	struct enetc_pf *pf = enetc_si_priv(si);
> @@ -775,187 +708,6 @@ static const struct net_device_ops enetc_ndev_ops = {
>  	.ndo_xdp_xmit		= enetc_xdp_xmit,
>  };
>
> -static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> -				  const struct net_device_ops *ndev_ops)
> -{
> -	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -
> -	SET_NETDEV_DEV(ndev, &si->pdev->dev);
> -	priv->ndev = ndev;
> -	priv->si = si;
> -	priv->dev = &si->pdev->dev;
> -	si->ndev = ndev;
> -
> -	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
> -	ndev->netdev_ops = ndev_ops;
> -	enetc_set_ethtool_ops(ndev);
> -	ndev->watchdog_timeo = 5 * HZ;
> -	ndev->max_mtu = ENETC_MAX_MTU;
> -
> -	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
> -			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
> -			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
> -			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> -	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
> -			 NETIF_F_HW_VLAN_CTAG_TX |
> -			 NETIF_F_HW_VLAN_CTAG_RX |
> -			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> -	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
> -			      NETIF_F_TSO | NETIF_F_TSO6;
> -
> -	if (si->num_rss)
> -		ndev->hw_features |= NETIF_F_RXHASH;
> -
> -	ndev->priv_flags |= IFF_UNICAST_FLT;
> -	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> -			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
> -			     NETDEV_XDP_ACT_NDO_XMIT_SG;
> -
> -	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> -		priv->active_offloads |= ENETC_F_QCI;
> -		ndev->features |= NETIF_F_HW_TC;
> -		ndev->hw_features |= NETIF_F_HW_TC;
> -	}
> -
> -	/* pick up primary MAC address from SI */
> -	enetc_load_primary_mac_addr(&si->hw, ndev);
> -}
> -
> -static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
> -{
> -	struct device *dev = &pf->si->pdev->dev;
> -	struct enetc_mdio_priv *mdio_priv;
> -	struct mii_bus *bus;
> -	int err;
> -
> -	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
> -	if (!bus)
> -		return -ENOMEM;
> -
> -	bus->name = "Freescale ENETC MDIO Bus";
> -	bus->read = enetc_mdio_read_c22;
> -	bus->write = enetc_mdio_write_c22;
> -	bus->read_c45 = enetc_mdio_read_c45;
> -	bus->write_c45 = enetc_mdio_write_c45;
> -	bus->parent = dev;
> -	mdio_priv = bus->priv;
> -	mdio_priv->hw = &pf->si->hw;
> -	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
> -	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> -
> -	err = of_mdiobus_register(bus, np);
> -	if (err)
> -		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
> -
> -	pf->mdio = bus;
> -
> -	return 0;
> -}
> -
> -static void enetc_mdio_remove(struct enetc_pf *pf)
> -{
> -	if (pf->mdio)
> -		mdiobus_unregister(pf->mdio);
> -}
> -
> -static int enetc_imdio_create(struct enetc_pf *pf)
> -{
> -	struct device *dev = &pf->si->pdev->dev;
> -	struct enetc_mdio_priv *mdio_priv;
> -	struct phylink_pcs *phylink_pcs;
> -	struct mii_bus *bus;
> -	int err;
> -
> -	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
> -	if (!bus)
> -		return -ENOMEM;
> -
> -	bus->name = "Freescale ENETC internal MDIO Bus";
> -	bus->read = enetc_mdio_read_c22;
> -	bus->write = enetc_mdio_write_c22;
> -	bus->read_c45 = enetc_mdio_read_c45;
> -	bus->write_c45 = enetc_mdio_write_c45;
> -	bus->parent = dev;
> -	bus->phy_mask = ~0;
> -	mdio_priv = bus->priv;
> -	mdio_priv->hw = &pf->si->hw;
> -	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
> -	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
> -
> -	err = mdiobus_register(bus);
> -	if (err) {
> -		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
> -		goto free_mdio_bus;
> -	}
> -
> -	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
> -	if (IS_ERR(phylink_pcs)) {
> -		err = PTR_ERR(phylink_pcs);
> -		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
> -		goto unregister_mdiobus;
> -	}
> -
> -	pf->imdio = bus;
> -	pf->pcs = phylink_pcs;
> -
> -	return 0;
> -
> -unregister_mdiobus:
> -	mdiobus_unregister(bus);
> -free_mdio_bus:
> -	mdiobus_free(bus);
> -	return err;
> -}
> -
> -static void enetc_imdio_remove(struct enetc_pf *pf)
> -{
> -	if (pf->pcs)
> -		lynx_pcs_destroy(pf->pcs);
> -	if (pf->imdio) {
> -		mdiobus_unregister(pf->imdio);
> -		mdiobus_free(pf->imdio);
> -	}
> -}
> -
> -static bool enetc_port_has_pcs(struct enetc_pf *pf)
> -{
> -	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
> -		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
> -		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
> -		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
> -}
> -
> -static int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
> -{
> -	struct device_node *mdio_np;
> -	int err;
> -
> -	mdio_np = of_get_child_by_name(node, "mdio");
> -	if (mdio_np) {
> -		err = enetc_mdio_probe(pf, mdio_np);
> -
> -		of_node_put(mdio_np);
> -		if (err)
> -			return err;
> -	}
> -
> -	if (enetc_port_has_pcs(pf)) {
> -		err = enetc_imdio_create(pf);
> -		if (err) {
> -			enetc_mdio_remove(pf);
> -			return err;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static void enetc_mdiobus_destroy(struct enetc_pf *pf)
> -{
> -	enetc_mdio_remove(pf);
> -	enetc_imdio_remove(pf);
> -}
> -
>  static struct phylink_pcs *
>  enetc_pl_mac_select_pcs(struct phylink_config *config, phy_interface_t iface)
>  {
> @@ -1101,47 +853,6 @@ static const struct phylink_mac_ops enetc_mac_phylink_ops = {
>  	.mac_link_down = enetc_pl_mac_link_down,
>  };
>
> -static int enetc_phylink_create(struct enetc_ndev_priv *priv,
> -				struct device_node *node)
> -{
> -	struct enetc_pf *pf = enetc_si_priv(priv->si);
> -	struct phylink *phylink;
> -	int err;
> -
> -	pf->phylink_config.dev = &priv->ndev->dev;
> -	pf->phylink_config.type = PHYLINK_NETDEV;
> -	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> -		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
> -
> -	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> -		  pf->phylink_config.supported_interfaces);
> -	__set_bit(PHY_INTERFACE_MODE_SGMII,
> -		  pf->phylink_config.supported_interfaces);
> -	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> -		  pf->phylink_config.supported_interfaces);
> -	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> -		  pf->phylink_config.supported_interfaces);
> -	__set_bit(PHY_INTERFACE_MODE_USXGMII,
> -		  pf->phylink_config.supported_interfaces);
> -	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
> -
> -	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
> -				 pf->if_mode, &enetc_mac_phylink_ops);
> -	if (IS_ERR(phylink)) {
> -		err = PTR_ERR(phylink);
> -		return err;
> -	}
> -
> -	priv->phylink = phylink;
> -
> -	return 0;
> -}
> -
> -static void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
> -{
> -	phylink_destroy(priv->phylink);
> -}
> -
>  /* Initialize the entire shared memory for the flow steering entries
>   * of this port (PF + VFs)
>   */
> @@ -1338,7 +1049,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
>  	if (err)
>  		goto err_mdiobus_create;
>
> -	err = enetc_phylink_create(priv, node);
> +	err = enetc_phylink_create(priv, node, &enetc_mac_phylink_ops);
>  	if (err)
>  		goto err_phylink_create;
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> index c26bd66e4597..92a26b09cf57 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> @@ -58,3 +58,16 @@ struct enetc_pf {
>  int enetc_msg_psi_init(struct enetc_pf *pf);
>  void enetc_msg_psi_free(struct enetc_pf *pf);
>  void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
> +
> +void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
> +void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> +				   const u8 *addr);
> +int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
> +int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
> +void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> +			   const struct net_device_ops *ndev_ops);
> +int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node);
> +void enetc_mdiobus_destroy(struct enetc_pf *pf);
> +int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
> +			 const struct phylink_mac_ops *ops);
> +void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> new file mode 100644
> index 000000000000..be6aec19b1f3
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/* Copyright 2024 NXP */

empty line here

> +#include <linux/fsl/enetc_mdio.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_net.h>
> +#include <linux/pcs-lynx.h>
> +
> +#include "enetc_pf.h"
> +
> +int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct sockaddr *saddr = addr;
> +
> +	if (!is_valid_ether_addr(saddr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
> +	eth_hw_addr_set(ndev, saddr->sa_data);
> +	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
> +
> +	return 0;
> +}
> +
> +static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
> +				   int si)
> +{
> +	struct device *dev = &pf->si->pdev->dev;
> +	struct enetc_hw *hw = &pf->si->hw;
> +	u8 mac_addr[ETH_ALEN] = { 0 };
> +	int err;
> +
> +	/* (1) try to get the MAC address from the device tree */
> +	if (np) {
> +		err = of_get_mac_address(np, mac_addr);
> +		if (err == -EPROBE_DEFER)
> +			return err;
> +	}
> +
> +	/* (2) bootloader supplied MAC address */
> +	if (is_zero_ether_addr(mac_addr))
> +		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
> +
> +	/* (3) choose a random one */
> +	if (is_zero_ether_addr(mac_addr)) {
> +		eth_random_addr(mac_addr);
> +		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
> +			 si, mac_addr);
> +	}
> +
> +	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
> +
> +	return 0;
> +}
> +
> +int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
> +{
> +	int err, i;
> +
> +	/* The PF might take its MAC from the device tree */
> +	err = enetc_setup_mac_address(np, pf, 0);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < pf->total_vfs; i++) {
> +		err = enetc_setup_mac_address(NULL, pf, i + 1);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> +			   const struct net_device_ops *ndev_ops)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +
> +	SET_NETDEV_DEV(ndev, &si->pdev->dev);
> +	priv->ndev = ndev;
> +	priv->si = si;
> +	priv->dev = &si->pdev->dev;
> +	si->ndev = ndev;
> +
> +	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
> +	ndev->netdev_ops = ndev_ops;
> +	enetc_set_ethtool_ops(ndev);
> +	ndev->watchdog_timeo = 5 * HZ;
> +	ndev->max_mtu = ENETC_MAX_MTU;
> +
> +	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
> +			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
> +			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
> +			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
> +			 NETIF_F_HW_VLAN_CTAG_TX |
> +			 NETIF_F_HW_VLAN_CTAG_RX |
> +			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
> +			      NETIF_F_TSO | NETIF_F_TSO6;
> +
> +	if (si->num_rss)
> +		ndev->hw_features |= NETIF_F_RXHASH;
> +
> +	ndev->priv_flags |= IFF_UNICAST_FLT;
> +	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
> +			     NETDEV_XDP_ACT_NDO_XMIT_SG;
> +
> +	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> +		priv->active_offloads |= ENETC_F_QCI;
> +		ndev->features |= NETIF_F_HW_TC;
> +		ndev->hw_features |= NETIF_F_HW_TC;
> +	}
> +
> +	/* pick up primary MAC address from SI */
> +	enetc_load_primary_mac_addr(&si->hw, ndev);
> +}
> +
> +static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
> +{
> +	struct device *dev = &pf->si->pdev->dev;
> +	struct enetc_mdio_priv *mdio_priv;
> +	struct mii_bus *bus;
> +	int err;
> +
> +	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "Freescale ENETC MDIO Bus";
> +	bus->read = enetc_mdio_read_c22;
> +	bus->write = enetc_mdio_write_c22;
> +	bus->read_c45 = enetc_mdio_read_c45;
> +	bus->write_c45 = enetc_mdio_write_c45;
> +	bus->parent = dev;
> +	mdio_priv = bus->priv;
> +	mdio_priv->hw = &pf->si->hw;
> +	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> +
> +	err = of_mdiobus_register(bus, np);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
> +
> +	pf->mdio = bus;
> +
> +	return 0;
> +}
> +
> +static void enetc_mdio_remove(struct enetc_pf *pf)
> +{
> +	if (pf->mdio)
> +		mdiobus_unregister(pf->mdio);
> +}
> +
> +static int enetc_imdio_create(struct enetc_pf *pf)
> +{
> +	struct device *dev = &pf->si->pdev->dev;
> +	struct enetc_mdio_priv *mdio_priv;
> +	struct phylink_pcs *phylink_pcs;
> +	struct mii_bus *bus;
> +	int err;
> +
> +	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "Freescale ENETC internal MDIO Bus";
> +	bus->read = enetc_mdio_read_c22;
> +	bus->write = enetc_mdio_write_c22;
> +	bus->read_c45 = enetc_mdio_read_c45;
> +	bus->write_c45 = enetc_mdio_write_c45;
> +	bus->parent = dev;
> +	bus->phy_mask = ~0;
> +	mdio_priv = bus->priv;
> +	mdio_priv->hw = &pf->si->hw;
> +	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
> +
> +	err = mdiobus_register(bus);
> +	if (err) {
> +		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
> +		goto free_mdio_bus;
> +	}
> +
> +	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
> +	if (IS_ERR(phylink_pcs)) {
> +		err = PTR_ERR(phylink_pcs);
> +		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
> +		goto unregister_mdiobus;
> +	}
> +
> +	pf->imdio = bus;
> +	pf->pcs = phylink_pcs;
> +
> +	return 0;
> +
> +unregister_mdiobus:
> +	mdiobus_unregister(bus);
> +free_mdio_bus:
> +	mdiobus_free(bus);
> +	return err;
> +}
> +
> +static void enetc_imdio_remove(struct enetc_pf *pf)
> +{
> +	if (pf->pcs)
> +		lynx_pcs_destroy(pf->pcs);
> +
> +	if (pf->imdio) {
> +		mdiobus_unregister(pf->imdio);
> +		mdiobus_free(pf->imdio);
> +	}
> +}
> +
> +static bool enetc_port_has_pcs(struct enetc_pf *pf)
> +{
> +	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
> +		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
> +		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
> +		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
> +}
> +
> +int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
> +{
> +	struct device_node *mdio_np;
> +	int err;
> +
> +	mdio_np = of_get_child_by_name(node, "mdio");
> +	if (mdio_np) {
> +		err = enetc_mdio_probe(pf, mdio_np);
> +
> +		of_node_put(mdio_np);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (enetc_port_has_pcs(pf)) {
> +		err = enetc_imdio_create(pf);
> +		if (err) {
> +			enetc_mdio_remove(pf);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void enetc_mdiobus_destroy(struct enetc_pf *pf)
> +{
> +	enetc_mdio_remove(pf);
> +	enetc_imdio_remove(pf);
> +}
> +
> +int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
> +			 const struct phylink_mac_ops *ops)
> +{
> +	struct enetc_pf *pf = enetc_si_priv(priv->si);
> +	struct phylink *phylink;
> +	int err;
> +
> +	pf->phylink_config.dev = &priv->ndev->dev;
> +	pf->phylink_config.type = PHYLINK_NETDEV;
> +	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
> +
> +	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +		  pf->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_SGMII,
> +		  pf->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +		  pf->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +		  pf->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_USXGMII,
> +		  pf->phylink_config.supported_interfaces);
> +	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
> +
> +	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
> +				 pf->if_mode, ops);
> +	if (IS_ERR(phylink)) {
> +		err = PTR_ERR(phylink);
> +		return err;
> +	}
> +
> +	priv->phylink = phylink;
> +
> +	return 0;
> +}
> +
> +void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
> +{
> +	phylink_destroy(priv->phylink);
> +}
> --
> 2.34.1
>

