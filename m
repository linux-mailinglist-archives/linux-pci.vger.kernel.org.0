Return-Path: <linux-pci+bounces-15306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0DB9B03E9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 15:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D491B22AD1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA0752F76;
	Fri, 25 Oct 2024 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZl+H25r"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C381212182;
	Fri, 25 Oct 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862607; cv=fail; b=GroI6WifXSTjZRugHuySEIjQH3gP9Iagdl3OcySctlpR7zS+TcHNYglnvNE/EUsrEUYNXs7w6f+S740Fw0Le8D12bVCA2oA3b2BeEZaa0qNnW25xufDP94my99juDpw44zKkuHbxo2LtvzSRwkwTekOyI1QqGuGXxLSa1c3nsJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862607; c=relaxed/simple;
	bh=6n0casdYb+NutwCrfVqH3imDOPzzDIQv0To0xihVALw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bgu38XrSD0WbUv7mTo1OAXHaVn5QCI+0D8f8DInRU1/+fxNNDtJPwVWrIRr0TI3G/rUzB2lI+H6ktZnCGj1cCw5cmnx/LRya1fTpy0mAS5mdkPf3edV7Icwe+h2D1vRCfBOPHJXBRkhZsrbpiM6JoHQSrrzSx/P4+EOI5jOq4wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mZl+H25r; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/+34iOfvsDFSBoJIIBbIfqPoX/D9ewk2XLIQANUrvJrA2sC4rm0E93uwNgJ0UC1nE/cq1OhCd6apM54NDRT3pv/MPzMdrJ4GW0oJPLhDvFtqCPAG6c1frP+Q/3et+CGJBzp5M5X8d4s/SuFBUSQMarTyUEJG03kOeQ3bHtJVl01j1W2LTJHH+DinRIZy4aj6EEJ4kA46w2COjZo/sRKCFWxCypEu7I/9nLayOADrVJsjSNqL57NazgOdxJY8WQiQvPFKxsOW7xj3boAQoMmtbGfG5EKT7bbczyHwd4fosz7UyhL4nzolONXSjimPIH9CdozT9IBavkqaGxM+5dQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULS9ONfdOI6X4p6QMMCTEzscTbPbihSzTlXyHtoTEj8=;
 b=WGRu+WjRkXGsS2MLfp959BUXtaT5zv8Xb9PagQzYHEM7I1GZ2oBvDUK/sgg5FOqIOSYgNzBlGpZJ8Ha9x8e9NeD9JgYrb5jYjoFY0WL8w8kHXu3zVPDnVFoV4iWzHPzeD1SQPAMTWGwkQ4/KAv8yutgLnGUK7peFjGqRgnnJEAS2czxIvFaPZ8nN8jbtc5q1E3hLGpsTXW49ncVmRdmVpuPrfPkgsrQf+XMGflDKjlHDwixEO0LsvRwA8VM0/drG7N4pag+umi9yNPT16mcoMzT8JN2YJpXpXHRUOXTSapR8b9N0Rdzdekv+8Kg3DWUzf23VFXF/cjLIc2nE764dLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULS9ONfdOI6X4p6QMMCTEzscTbPbihSzTlXyHtoTEj8=;
 b=mZl+H25rZ+nErw4PO9rAOX1SKtdV/0AAJPbI+86Uh9YdwWEz5Pt6yWkFitvX2A6yTzm2iCcyGcXI7N+VPjGm9Gp1dRSkrJIPiy49YcuIb8ff4GlAtCMjOfnVODPbg9RyWQ15IYTVzHQ0AWaBAPa2SlqZAC7hf4x2QABOjVzdcdCjmg2/T3fnldGtRfDM+1rRUGiZQVjOGbTAZLwN1URFO1m2o84e5knVtM4gN6W1L0UKgKVwdF5lMDhY/8fudzu5xjkYnEA0w4TkXuuVvMpCXcr6mt255oDEkE7dI25Vl5AgMBD5mpAMW3jPYSOyX+TAGsZVaoIm/iX247ucHOD0tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB7945.eurprd04.prod.outlook.com (2603:10a6:10:1f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 25 Oct
 2024 13:23:20 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:23:20 +0000
Date: Fri, 25 Oct 2024 16:23:16 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v5 net-next 06/13] net: enetc: build enetc_pf_common.c as
 a separate module
Message-ID: <20241025132316.6pyamwivaupzwo6j@skbuf>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-7-wei.fang@nxp.com>
 <20241024065328.521518-7-wei.fang@nxp.com>
 <20241024173451.wsdhghmz4vyboelu@skbuf>
 <PAXPR04MB8510468F88A236EA7ABB76D8884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510468F88A236EA7ABB76D8884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1P195CA0091.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 455bba8c-e789-4825-6f3e-08dcf4f831e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i3ugNlB6X0br4XbgO/3V2ixzrn5QUwZ3WjOi2J7TBauNcI4gUqOzbiWnE+5A?=
 =?us-ascii?Q?0wRkGl3/X/oAZTMVw4U6H36UnJ2zPlKILJNa/ms6J4TffdaOxQFy6tJ4wFQ7?=
 =?us-ascii?Q?BQIUU7Io7bxqysT0U6VB847oBf4GkGdA7tGDkTmjU8Te1HDS7EleRs4VJxzZ?=
 =?us-ascii?Q?p0bAtTOSn54dwlQXV7/lyYT14oS1RVTU5rnAbKdqto/TMBo6CCh1skbIssDW?=
 =?us-ascii?Q?eYo0XhBP8YOE6BWY+LDIgt1+xZl3uTYM+MmAWNw7pr6lhmc7iYCi54QouDL0?=
 =?us-ascii?Q?R7+HNT89wZOlZXA65P4DIm5VNGm3Z4OMKFYqkhQyT2IjN+dSdiqnuMEl9T2A?=
 =?us-ascii?Q?Mz8rvKm2WyJsIrrfMTeZrbzkskKtY60nUK5/vUioDHxJjkGWDz5T79qyaL1E?=
 =?us-ascii?Q?DSaaQ1kzHlgXjzwWq+r2YEJtj2NN0ZGrMcJuUcnK1k20X3S6F76+c54YWMj/?=
 =?us-ascii?Q?k7piFg8P/pNzAU20UQe5Bi3lMIQKOZGpjfZMnYgRmtm40NEqwFBPXOxEjFTr?=
 =?us-ascii?Q?dWEAF7OncIwcJQjrbbK4/J91wuyREd7NDA8BhHNL8eUiOXRc1Wu7dk3y4p5e?=
 =?us-ascii?Q?PRnPzo9x8yGZlPOiGnNNInUE+C9uZ70TOxMfJsweUfuUleMa/R4hFhGwMaOk?=
 =?us-ascii?Q?TT1Xy2LOjBpO3wyoyhNU1p4EQjZ7tB1Yh7SxDHkws2653RJHObb/F8VXyBSC?=
 =?us-ascii?Q?nPhjs4SLd9RZACCOGA/w0qxsJMvAKWw/NfflgbcKvPjthtMUj8FLgN++JwKj?=
 =?us-ascii?Q?AHeB7n8QkBtDC2mskWVeZj+BJiytcngUcvKhf12/7zW2692GFnbz309dlnR5?=
 =?us-ascii?Q?9IzxbRVi8bQ12yrztL/vBEEEfQ/gBf6pXpNB7x5jy/fI0yuos2zTiAZWyWRq?=
 =?us-ascii?Q?a6K1YfS9lGA/yUqx9lxKhODBKhAhU374UcpslfW4ATvVicJnzlV+Iz3Q0wMm?=
 =?us-ascii?Q?FjitFwTpeoW+QJd1tijnZqUal/G9ARHb/tEN4q69soM0EQGfc/s/dzFMwz/O?=
 =?us-ascii?Q?9pC+au7iTgVXL3qULi1mLFPI91zpkIn8L54aBN/VpQLmc/Da6IZnwQknctbb?=
 =?us-ascii?Q?jUBaBxs5sFoHdlwjrefaCX0Jbnn/epvHBou7lnY4MxqPtmooicQbs7GQUuUQ?=
 =?us-ascii?Q?h3eykYhtDnMYYHataq0pF4Q9CN6FWWnE7Nx2d6RzGtJ/UAnxehCHEOLF85eK?=
 =?us-ascii?Q?jL67dpFv9Lb931BMJtxygt5jwm3LWS2mrOUzvG3VBL2H6eFkdVwI95SijlYl?=
 =?us-ascii?Q?R1PI9YlqdbjODOnEIpCyIEsMxRUNwnC51iaFtS32QFnIWRSkcUYaUb2x8TCi?=
 =?us-ascii?Q?thjsVKLAjU30wAJNt9oLX727?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qoWBc3jYeLn2a0qGe1Qo9xJfoz969NP73r8xYdIwUhVnBQa1OtD4sOz+G7fp?=
 =?us-ascii?Q?JkoKEOOU2EaGmNOKyFAS75D8FPyPeEtVzAwchnKMu8IGTD1P2LBEuAuXh7Zw?=
 =?us-ascii?Q?X+j4jKiHlHQk336lkvzAOEtoxGf0sbI2UtoUglLnWG5SPqWJ52nsOlJcmEhu?=
 =?us-ascii?Q?nQcl4IU3g6kuN+W4rm+dKpK78py8I0DBbuzX/0fzgqpByP5Olv2NBWTdYA3A?=
 =?us-ascii?Q?takVcVsvB1EHni8BxNDiUgN+OQlFng5WNCFYDnPg8ZQhM4A0Dc0UKROqsdi1?=
 =?us-ascii?Q?lNKxIiQAbVSnQTOf0ENjeYu9t5Vglnd4GTgtJKEtX7F6n5i8wiBHq4upl4l0?=
 =?us-ascii?Q?PAXcqozCsR4QeK9bLMeARRBGYlmP9HafPaAl6URrTbIHqQt6++NgLAEorYX0?=
 =?us-ascii?Q?aqRIRAGpV40En3C29GGKSzajDY4pig2ZacrlHTMH7kFaZjZ2iTmg+y4xoI4C?=
 =?us-ascii?Q?xy3TEBQYasY07uiusp1DaWKz3PVWLWJZBGgqNp45JzU5Dlf80Y4Fp552wskK?=
 =?us-ascii?Q?xghcpQwVNmG7tv3tUyT0lsVVqH/uTBYWVRFwNpCfXMz4x1IL1bZZKLxv0mei?=
 =?us-ascii?Q?+3ipXNcm8gbBssW0CwG1YnFCz6f9ohl6TZ6t88VKa5hW6qdpwUQtsz44+7LX?=
 =?us-ascii?Q?Cams85+pmWahHwQYTzXe/vdGceNP2dCgK18aTPu6dp6KsrQPDJp8yiOfojeB?=
 =?us-ascii?Q?SKuQIxLnMQtifBFZHM+UFwoZOQ6MSdXdhoOLr50JKsT6t7VvuEsJoZkBF72F?=
 =?us-ascii?Q?LYli8syW/WO/eLRjmUNtvTEgfsnf8HlN2o7udz772RMjuOxqnGUZu/r8vRSz?=
 =?us-ascii?Q?1O2J5gGWDO7dzIzKgjb+aJ6skdYlR68/qqHMK0UkeBKRuE3xlaEhbY76ArsG?=
 =?us-ascii?Q?20+LJIxOASG2pkwv3PreRHxz4B1L5HB1aE25CnqYOnzGNw7n7kId48x9FUjZ?=
 =?us-ascii?Q?ADEerS6qZ5Y0i7NwDu0JGv4SFz7D6FYO49vFQSlXX5u3eXC5ryEM8LSWvTYa?=
 =?us-ascii?Q?XeXWLBbUz6wYyqYlG9xTKX0QkQK+JKugMJmK1IBMlesXOqFwDvGk9ZXWaCW0?=
 =?us-ascii?Q?ZJI4V+oiWrN5ohO4hsGmioJ2Q8nMfjkM2zRRzxnSOCWQULgBiLZcivaocI2B?=
 =?us-ascii?Q?eSpoh5Qsm+XdS9G29ipctjJZKlHQABoJMQZbqx0lE3zw3sa5v1keyOVPnLZE?=
 =?us-ascii?Q?jLxvJ6tajuKHcoCUD/es4bpq2/s1Is/IzXSc10fywkLLhLmTqEhZ8mu61CFP?=
 =?us-ascii?Q?8CAskyF9Wy6o1iEwj6sT9BVqsvPE1zBa9KRbRgJrv/WkMkFVNsPErn+1JkL5?=
 =?us-ascii?Q?E83yjAl4TGgv0Lphhq7WX1XdAd1fVsVhcNZKLEWcjKcG6i1NtIOAy6fRM+yX?=
 =?us-ascii?Q?N4/pjAdy8U4y6lYeqdS9cBU2WlMNGTpQ1Wo+3F4fS9QzqHWzRcEDIcbeFeyP?=
 =?us-ascii?Q?k/jgVXWjXmFtfJd5F612EXMs8BoHK3tSqzw9CDvUrEpTo82guUeFfLqJWxO9?=
 =?us-ascii?Q?2ZAF2Vh7gjSzgyiOLjM71UjebLOgtNAoEMfFjlikKKG3F7fMfsZJmcvhU8kp?=
 =?us-ascii?Q?AE4D8Ss4+652fBCQ3X/pbj+10JiM6VKRciQLl28OCc1Pu1iEWd2tqpMW65Cx?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455bba8c-e789-4825-6f3e-08dcf4f831e8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:23:20.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylYNEmKu2IJW8GW0igrKqZ9StGGiSX+81cM/mRRr3YGX/Iai5HWkDS+qfTKUBjGwQ4vtcDOQthHYx/ibrji+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7945

On Fri, Oct 25, 2024 at 06:00:42AM +0300, Wei Fang wrote:
> > Don't artificially create errors when there are really no errors to handle.
> > Both enetc_pf_ops and enetc4_pf_ops provide .set_si_primary_mac(), so it
> > is unnecessary to handle the case where it isn't present. Those functions
> > return void, and void can be propagated to enetc_set_si_hw_addr() as well.
> 
> I thought checking the pointer is safer, so you mean that pointers that are
> definitely present in the current driver do not need to be checked?

Yes, there is no point to check for a condition which is impossible
to trigger in the current code. The callee and the caller are tightly
coupled (in the same driver), it's not a rigid API, so if the function
pointers should be made optional for some future hardware IP, the error
handling will be added when necessary. Ideally any change passes through
review, and any inconsistency should be spotted when added.

> > A bit inconsistent that pf->ops->set_si_primary_mac() goes through a
> > wrapper function but this doesn't.
> > 
> 
> If we really do not need to check these callback pointers, then I think I can
> remove the wrapper.

Fine without wrapping throughout, my comment was first and foremost
about consistency.

> > This one looks extremely weird in the existing code, but I suppose I'm
> > too late to the party to request you to clean up any of the PSFP code,
> > so I'll make a note to do it myself after your work. I haven't spotted
> > any actual bug, just weird coding patterns.
> > 
> > No change request here. I see the netc4_pf doesn't implement enable_psfp(),
> > so making it optional here is fine.
> 
> Yes, PSFP is not supported in this patch set, I will remove it in future.

If by "I will remove it in future" you mean "once NETC4 gains PSFP
support, I will make enable_psfp() non-optional", then ok, great.

> Currently, we have not add the PCS support, so the 10G ENETC is not supported
> yet. And we also disable the 10G ENETC in DTS. Only the 1G ENETCs (without PCS)
> are supported for i.MX95.

Also think about the case where the current version of the kernel
will boot on a newer version of the device tree, which does not have
'status = "disabled";' for those ports. It should do something reasonable.
In any case, "they're now disabled in the device tree" is not an argument.

My anecdotal and vague understanding of the Arm SystemReady (IR I think)
requirements is that the device tree is provided by the platform,
separately from the kernel/rootfs. It relies on the device tree ABI
being stable, backwards-compatible and forwards-compatible.

> > A message maybe, stating what's the deal? Just that users figure out
> > quickly that it's an expected behavior, and not spend hours debugging
> > until they find out it's not their fault?
> 
> I will explain in the commit message that i.MX95 10G ENETC is not currently
> supported.

By "a message, maybe" I actually meant dev_err("Message here\n"); rather
than silent/imprecise failure.

