Return-Path: <linux-pci+bounces-14552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADC499F14B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 17:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5CC2821B7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CEC1B3947;
	Tue, 15 Oct 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bxu6LJjq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E61CB9E2;
	Tue, 15 Oct 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006427; cv=fail; b=ggxZgoAspDS5YnnnCJRYDo6Fm85cEPYKRmn51tCoJK2mL78QqCGK6foNKas8GE8eCWqnBP4WB0MW90oqS2FENcpjb8V7eu8AEVUr+SdZksTpDLo/9dZ6XQD3S5S02OkeNBygpCaoPTSffuHKODDyWkOuspe0/oLYWSEEemt97MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006427; c=relaxed/simple;
	bh=WhCd1SWFpzFXdZ4Lquu3ielncoYrjFlTD/qyuGsPKnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CBPJTe307gaPnaGp9CEVLJbAbNsdqE6+UFsLFstdeahWene4caQvnOM7DA3FDqfHGkEzsk0XeE8BsKyLNYHGc1T9/ICRPQmQVf7meRJoe8GKjjOlTKyjvJVJGvBslBaxBr/l9Xz9t8OmNllPOMym1EGIFkgNcTUoZ0kwqxsjSE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bxu6LJjq; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9ldyal/7DwhTXT6O8VNValOHFR9GXTkAis9ugv5ojhb/y4hGAhsh+kr6jpyP1Wqdi5QFuPJRNni9uXCgOH/J1eCY0s3/bSiC46ZU2VLZUsfW7uIyxC2ooYC1Y2d1CzzMaJf5gvNM4lccJZEfN7P+x9dFjBAWKX2GnXPVqDMaCv+04syKQlRupUdVJjlbKx5LsZeXyfQZYCKMfcRTSW2+RloYV1gsS/M2lFfGitSJ+hk+jC/f8bEJYJA4ovRQdCTUYIo6lgKhMO/CNGddn5ycKZDibr7NVQoKqgfjwQJZ4eZ/M/qw9YevvFf67a1mFFj6Zf9EnbDoHPykRBdemVyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYG6w/Ev/vzP09I61yWw+MKn0O5HW/QizFdQf9zVF80=;
 b=cI8FBXsd5T15kGlIkW4v0oNeq2tIsVBeldRdmLtZzOaIwN01pvuLkuqN/WcmJpsPfWXYFATQb51UXgYn1Tl2cVwbe2gSaHOHOxIwoQ7GP76SL4ykv6p3FsLD+ONQOGEKquEN0g4YAlfBDHCvMcttTMSS3/OzCfoDxVwtywv55dP3q2Mne22eAfJ5KbF9ZIkFllWPRClJxG1rKWjD58um1lj3T7WbEMmNtSE2q6t14ld+DDH9mJd+JUmQDs/r7LatLKV2e8t8N9NcP2k572KCwknPDOFFy+dM2XcWX/UpYVPVt6quBZKumj4DIA5WMhW3IbqH7PqqQ+kQifzNP84dXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYG6w/Ev/vzP09I61yWw+MKn0O5HW/QizFdQf9zVF80=;
 b=Bxu6LJjqAF8Fc7g+TFmpc/9ByLhYLnKAKwXXcuBJEfLuZc1ynZW/9r007ysHJjrqfXZgBlHs1AHfeBk6loTIWjZSoala0clvOQFSAdEbDmVLGkaaxtNIiqeuZLi4vebvOmDV/KwaOIx66dTHZX1Q/1z1lrl02WFxGDo7uTwdOfOYc0N86tPY9ZdGJ//GCFzy6iSdfoTakn/41wYFOVjB8bmxBqUga5Ls2YemCohwdBeV/j+OmDHDkevmfF5D7cNvHASh+/BvQceI92ljGDLPYYX8FK1evWJ3caskM7V1r/AcGuPnEZOYhtEmmtQNwY4RXTD3YHAmAhh97YQMrhVVuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 15:33:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 15:33:42 +0000
Date: Tue, 15 Oct 2024 11:33:32 -0400
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
Subject: Re: [PATCH v2 net-next 01/13] dt-bindings: net: add compatible
 string for i.MX95 EMDIO
Message-ID: <Zw6LTCeHL8eH8shy@lizhi-Precision-Tower-5810>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-2-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2499a7-691e-41b1-0bac-08dced2ebfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4SVP4R8OiyWjH6boaqTbR2QwMwO0NHn0hBuhhol3ZgRn+F5mhUlPt366Bm5u?=
 =?us-ascii?Q?SaL1GqAwYHBXWu2nrKSpb6zuoEquht7iP8RXjQ/VJW1lgMm7ILw07WHQoyGM?=
 =?us-ascii?Q?PcnTXdDe3Mfk0IznxlzhMQy5VE7QU66R9Laa4mNt3x1KhqkyoZrsGHQFOdDi?=
 =?us-ascii?Q?pquA/2W7Gu2eCsD9QLSvfxg/wSqS9aT79F7CwWyqBCrf7CZf77S2BYwv8dQZ?=
 =?us-ascii?Q?oEqaZIYTSeSAlRVmZ17YMwHw9Rkc1QHODSlRE4XzWwOSC65Zb5Jdk/SQnRBP?=
 =?us-ascii?Q?TWIUqtSYlasRWabRAPAWMKCeN6FlzHYUguBsv382woyRNKAmQkyaTjg+FpOK?=
 =?us-ascii?Q?3hjWwlEW7wgc4DdTr0ewTa7pu+dy3il2hQ3R5UYTFKUxAJ03HlXJNETK+6+K?=
 =?us-ascii?Q?pVDFR/DMcmAnUey+drnejPnc8i2b7d6Ke39E3/TNWOyYk9wmafBSPgU53B55?=
 =?us-ascii?Q?2gy1IK80kWhh7jQn+e0uvH6ckfekBq/qyWb7bPylxFfq3Q09pE6rf7zyUNf6?=
 =?us-ascii?Q?LCHQamuegsq2LeWn7WcFleKgZ9kny0GieZFc57LZDyTp1VHzeiEyBHoR6oIv?=
 =?us-ascii?Q?SVbJN8E3Hm7FwVgtR79XWz33Ibcuf5VqnTE1oPTowThC6gcRXgsvIpABB0xr?=
 =?us-ascii?Q?MjdBaUVkbZa4Uj9erTCHRrCgRN+2ZawBwaZ44UmDwlfg+PxKD4pjwhHtd+AT?=
 =?us-ascii?Q?x/c8qUqL20bg2UPzjHUmNBi5dpdbcfFEHFXTjb6wdXM3GTCrvREPdu3ivP32?=
 =?us-ascii?Q?bdyjjdgR97eQDS24QkMk7QuJr6e4YgZF35ewe8QuES3gxToQuEpFBFeb6L2g?=
 =?us-ascii?Q?jpsYuB8+n3dreSCSDbOOXH3vimGpAOFg29bIcPUtLYqLTBDFEOyerwVTp3B9?=
 =?us-ascii?Q?ta/mabmJUO/nPRX65ayePNknqq2A2D7cH8I75KhyjvFGSMxrTt59Py/ayPQj?=
 =?us-ascii?Q?n9JB1oBwDF3bLxUp1IvYIHEmO7b9MqGk4uGieDddPXv3SE72tr3k13P1YC3y?=
 =?us-ascii?Q?NS4QA6Qonqza6gWXjZgUVDSUFikoaQ9aAhqYCZx3YCTVk4plNC6skREQlrge?=
 =?us-ascii?Q?lg7QPgbhBdNTN9NXQO6SJwZ5OHkxGiGXJNBe/B7Lz9HKN/UAUe0MivG5RC4g?=
 =?us-ascii?Q?h96z3OslaS5T+zdDD15zM+PlG1wfvVv0k02aBih2R7FCoOzzFkGjxi+zCv/t?=
 =?us-ascii?Q?0dNrh+O6us+JgMfwnWBJ+n3zKUIVQVPXZuUo47JKoZcHd4Cp/bMVVNAuoWf3?=
 =?us-ascii?Q?rML6Tc1n5Qc3vbJBlXSoJCW+CO6MHlmk7WYHbjVCtnQ1TxrokNKCIcnkyyTc?=
 =?us-ascii?Q?LHZ8IeMRL+sqOC+tZaM6+WNx4QeiMpVs5gP5sfs5IQKA1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JNpeI0hxEDWkucnJU2VjpTvHlqcDAlR28kULTwCNBzcU9uEevb83yFuE0boG?=
 =?us-ascii?Q?nr9nrnR8ZmYhjcOHcKQ8Q7lrajT2Sd/Q+kRmTvo4+RbGsQyMFNdWuBD4eiLo?=
 =?us-ascii?Q?anXOfB0tJ9QhVL/WN0e9+ArrSux823vTEbDus0uyTETKD5A5gKSMtabMDejW?=
 =?us-ascii?Q?QqmMHqJHKnWJn5CJZwY7imf6NLrT625Yn62UZ12QS88uxXWs2/UhGb6ilMc5?=
 =?us-ascii?Q?mRB/0rSMwPJRDniyuTRKrih1R8A9QOha72ZT4G19NqThUA/229f4v9frebGk?=
 =?us-ascii?Q?DBcNLhUcGLiKQyAjaaRqJAv+FcKuLA70IojcQ7q9LCEJehNsLKG4Pn0yRPUS?=
 =?us-ascii?Q?kUvJ0YcMutwUwG0Roa5ZqQOdcjb8JpMeWXRdpddc2FUXWaP4KkJW/PfcuvfD?=
 =?us-ascii?Q?78ghYEKuz3MqdrcicRIT39FGc4Yy183QgdV0zS4cSI1IYzamGmA5euZsUb9y?=
 =?us-ascii?Q?M+guGFTOzdjwJUvDV59iWQh34s7gQGzRaIf/cCkmQP4lYsdSCubBrQe7RuhU?=
 =?us-ascii?Q?J430p+cTdptGPBOwPPHqh+NPypDhcfTy7Eky8USmIPcjS72jcVidqB55V4PL?=
 =?us-ascii?Q?YXjdkiJU/6C6ZQdhGPA/9BJUAx8OqHCN5MEJyKuzWNszhihO6iJuhbBtnEN1?=
 =?us-ascii?Q?3N5ARYCfP1P8RmX2dk8+WKmunVb4X/rbZ2RXrETbwKc83KSFhSNOrb8wcrV9?=
 =?us-ascii?Q?lIfNevqwchrSLpOfie8UJRlfVoWehoH3biohvR4olENHYEhpzifqGvg0bwA6?=
 =?us-ascii?Q?gbEsU9JoiXVxsNuzovuBTxdWBTl2L0CxSj9JgKB6TMa1B1aCiE/HgPArPw2c?=
 =?us-ascii?Q?KhVy/db9/lnTgAlim8WmraffGV6qhT3Z8WbjjKtXxa3Z80+EsYCLK7UdJ7yI?=
 =?us-ascii?Q?6ipRzDzpwVEWfifsetGjv/NCELFJ146s3eKmcNN/H/pPIUWdlPtE9w0HNH/O?=
 =?us-ascii?Q?Y0Mown94QpTx9Ob9bxTaCy/CVByIaO4AVl9/sGf0lxdY5ISUSn44iAJQgUB8?=
 =?us-ascii?Q?p4J+8pJ8lcaMfy/jESpTgPylNZ2UwaGUzb4GclqMhC5EVBzYV/sLLRvjAr38?=
 =?us-ascii?Q?ALG/W9N3QYKmvJ6D+zeI8iiaaa0TZYJWE7qvjlP5mdPjh9arMaz2DiGiLG6f?=
 =?us-ascii?Q?/HeQfCwgz1FLxGOkEmITUbpwJDMYeDLfrq8Ffh7OPBJHWRkAv2/IElSVR1I7?=
 =?us-ascii?Q?zr59qBxVdGx8nsLJQk2Xmsi4fLhDwWA5HeTEItIicufykaxmuJ4Qz8DWSXsh?=
 =?us-ascii?Q?s558tPZzXSyuVTuokXzUduRLBbgS7byyvGG8fkkR1Px0OHftaT/PLJDBKnN2?=
 =?us-ascii?Q?sOvJG9nbSLboSzK1I16xvND8ut373ZqK422cVzcXMioD051XHKtoGhOew/iC?=
 =?us-ascii?Q?WX4Z04XxDmt9xff0Zu7RBVcAKNNBnSnryiC37UV0yaX6QeL5Fyp0yFzxt72b?=
 =?us-ascii?Q?/TXC2lww2BVUTQhV2ku09wvscpsp0lv2TJRfDPN+Z3IhISV8oGBA8GeWAmmn?=
 =?us-ascii?Q?tjG5hyzGi1oe8G7IUD0MGhs7bqunrQ4FlF/4ci+202Q4nFtLcJcAFxckDT3X?=
 =?us-ascii?Q?gKLI8vl9Oi0DSPkEgEQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2499a7-691e-41b1-0bac-08dced2ebfb7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:33:42.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS1sncGpFGhADJSyt7/YUU88/R34lm9IdzMae04SG8TD+cHHynvvxh/xbF73FzIuCj8LzdtbVX5zRo3XucnWNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

On Tue, Oct 15, 2024 at 08:58:29PM +0800, Wei Fang wrote:
> The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 EMDIO.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v2 changes: remove "nxp,netc-emdio" compatible string.
> ---
>  .../devicetree/bindings/net/fsl,enetc-mdio.yaml       | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> index c1dd6aa04321..71c43ece8295 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> @@ -20,10 +20,13 @@ maintainers:
>
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - pci1957,ee01
> -      - const: fsl,enetc-mdio
> +    oneOf:
> +      - items:
> +          - enum:
> +              - pci1957,ee01
> +          - const: fsl,enetc-mdio
> +      - items:
> +          - const: pci1131,ee00
>
>    reg:
>      maxItems: 1
> --
> 2.34.1
>

