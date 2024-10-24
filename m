Return-Path: <linux-pci+bounces-15199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 214509AE79C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 16:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EC4B2764D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39831F6668;
	Thu, 24 Oct 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BBtzRT/i"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2061.outbound.protection.outlook.com [40.107.103.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5791B1F6662;
	Thu, 24 Oct 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778791; cv=fail; b=OChciqxi39ar+hjcIaKKtyeGVwmvx3A4v9SyhnpAlZMf1BOb/oHKeKGSzrDqPHQYx4HP82qykylEbmmMr5RzGQqjTEuzVSV/vnTbiyipkQCorJib0qj5A+HMnKljrI3zESI44ZolHEDu6qP922crf/iHQDRFKY1z0zZ330nsI2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778791; c=relaxed/simple;
	bh=jhVOxV/yv31HFAKxWeOF0LsvGurUd5L+Bot20NbXE4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GCSyV5BzwtXQpE/WiVmm/K458kPwhjhBJzBSdTvKKzsn1nTECKnV/rdT6lMiz2lmZ5qDJE5CMLe+M6J6Kzs90Ix2lH0fgIRHVFuBGXsWVCUdu4Ekxd5xbWGl0DyYihkpgB+ZSb07cowc4bDtHlOSEEKkJW7K3M2YigC9BNpAlSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BBtzRT/i; arc=fail smtp.client-ip=40.107.103.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMdkBXZZa6PrIQvyKudTz8meyLmFD0VQ6uGzo42/WWAeLnPO+eaVpoTirMzeAJVPSg/gOx2Jo258kaYn9ZzCcQswr3Zz5cKoY0d1ue0Imy9x4GyqGY2W9WhD2YvKjj0x2jMyJexdruWFf2TbmxwDExRqvH5ovoUtPtYLsMFCZMHTt47glQ1+6bXE8YWw5q5iVA8isEoUd79t6JU/RSIdWd8zwc1qITHb4ynp1N/HcvpFLPQvZRkxLwYBSOMKbQZy/p4oOQ+x1HXrfgcFRy2SXXQ1WCgyVM4zDto4NrQr8ETAlXKGEWdgVmI2NaRp1FEpFNrydOYqul6iXjf4IIXMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28lhZMPaEqWLjsypx9eenXJnHWzghLwS1fLosq8lNSM=;
 b=wC4OThTUUOXXcVSFO+lnHw8DlY5ZVnBF2QQRhRvdPuGT6aB0pi3l/9/TkPhUKxtUlgFB0LeB8HIoBBNVO3OJw4B8gJMSmaxSa3w8PWWfSqLX5zSYYhYrFQ84wgQDGromTHie3fqShVRGrgnv6OFs3IhSLedLTR2x83bJkw8LAs8DxGvSI7U2KVQlQlrZYPwp8K5gsMUnll45QusuJDyprCqIjIS12Mei2JL797X6S18JHoT0jKhnmQd61EeNyvDIpWhh9LCmmYmQvqHCcjqPwgy/T0vkqWGuFQ9z1VsE172raktMM57SSUFv084oPn0PY0BDtI6D9853e+jCRUbpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28lhZMPaEqWLjsypx9eenXJnHWzghLwS1fLosq8lNSM=;
 b=BBtzRT/iXIF+/J2GxYkbpKQj3+0qH6ar32I0TnloOdpL357i/yEaRBENrY7cjq3i8Obr8LnypCziheih4TsIu4qyWPEta9QKfY1mU7tlcw1WLLvyh8YjuY+gzx2gifarm9IlY8eJr3fRb6JZto6UEBBLTjUg8hmzdy12tch2h3bDw9iJFoQFnivrlpmCpVsbqDstVryDdbxPYncVhY0gLnHKujb5jQIgYYK+jIvOkE25V3GES2ttSHMbdx7V0Wd3o5XzavXm/Bdby4kBHZI2MvN7B3lBrSpWB6jBGlHS99K0pz57nWWa/vLO8LGq8SIwpRtuPGFFbXrBoZ15U7ufiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10560.eurprd04.prod.outlook.com (2603:10a6:150:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 14:06:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 14:06:26 +0000
Date: Thu, 24 Oct 2024 17:06:23 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	Frank.Li@nxp.com, christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk, bhelgaas@google.com, horms@kernel.org,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v4 net-next 01/13] dt-bindings: net: add compatible
 string for i.MX95 EMDIO
Message-ID: <20241024140623.yr4lgjp7pryx344i@skbuf>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022055223.382277-2-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5f4280-0441-49a9-b487-08dcf4350ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5pfMLovlrSgV4JcdVZwmPQi21a3qPX9QKXa6kcapO4/YUyMHrzKLRSIo/8Tm?=
 =?us-ascii?Q?jBIEDUq+263uZAWC0NksoezXFncn9XFvjaRh4filfX/JHXsuR1vD049a7A2g?=
 =?us-ascii?Q?tcdx2l2BRkb/3CSFXHBbRywCnI6RVbT3IYwXuL/C0PR8an1K8jM/rHlHQuXV?=
 =?us-ascii?Q?64yl30N6D/uvEStanQcq+ZSBRuyusH/Ca0oyJ3QwHCzyC/yxcXsWRc3IXHmP?=
 =?us-ascii?Q?e5kMyJ1AI16/AItYbHgC5Cbo+aPt0+U4wCgRCxugfR7xOo+nTi3/8meK9yxB?=
 =?us-ascii?Q?MeINP4Bbg0D0W5G80UxLZ7wyA7Nl6Wu5zQQM2DhZYxraVc8oTpB5ZQzp+GHO?=
 =?us-ascii?Q?8HJslUOdLAUxPw4Jo676JDvtJK/aLYnqlx2HL7ZtRUdy0Eub+NsnRyq9ibal?=
 =?us-ascii?Q?INPvvIZ2VenY0URR7ANgXf9zzGGEnNs3tRFImLO/aQIuSWd7WirXCkZjOSzf?=
 =?us-ascii?Q?6PShOh6IkOAtO3qH74q1F3FmHE6zTkLLjswcwtFZIUsLsSH6IcyE5K03agZg?=
 =?us-ascii?Q?woVwhqo2X8hKzYVlzsoMBaBcjgi3FcwGjGA8jaqWGGZSjGVm93iqBxQNUIWh?=
 =?us-ascii?Q?LhXhL1Xy04uaOw70e/e0A6ttoYCaAF8atZL3/A9N2z3nXasPeknwzN6anqPw?=
 =?us-ascii?Q?By153YYx6Dq/M/wsex9lXQNBRP0NpyBKtPpAIgVC46N2f6GFvwfL0aRYRI49?=
 =?us-ascii?Q?WNrJmYmjBvFULR4bwy9UB7Cm4p6sRYaxx0YF8xJaGXrQ2TswHWXXmkVKpBLf?=
 =?us-ascii?Q?qCWPa6MyTrXDfbo4xaXTTEDwljBTcIOnPjYoIUWkowysxotLgfzy56gSpbmr?=
 =?us-ascii?Q?2eR9GdTsP/jpSn1uwbUg0E5aUewE0ZUHMMUMd/YnqYPAHf+aDRBKDHupcILa?=
 =?us-ascii?Q?icNDQQRKfVp4b/jq59n/1fOc2HiU3DKIvsaxzeAcQjmsMlhTNV18pBGVmc33?=
 =?us-ascii?Q?WtIKy6TIoTEAYBId1Uf5OUjpfLtGasnENLdZLW7SBM6W0hUebfCwZX+iOjIe?=
 =?us-ascii?Q?Zy9nwm2UPKubrjZxQluAepW96CgVeoyNBr2f6djz97Qj/NAWq+Djgo8ocChF?=
 =?us-ascii?Q?TdrzTvS1TNC/g16CkNEByGF3d9oSaRaFH9fbpYOs3ZYjRJMA1TWpoQkQFGhB?=
 =?us-ascii?Q?SEGUjlm97IqOpIJ7po2sFfLhkm5JA08mInYAdSzvf4uvujQhiOt2u032rOMD?=
 =?us-ascii?Q?D8o/QkZ9hOOlKw7l6EQtkahVJhEcIF19CiG3MsmlE2UQoowf7NvQJRaPkYQ6?=
 =?us-ascii?Q?v3AfZUT7lRViKTa5uMfCgVwElij2MSAvk1oH+P9dFELxYMtdzcLkEPxtcU7g?=
 =?us-ascii?Q?A5I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+x7/fXQWYZ9k5c8UOdN0nPHfqK03a2C1PLHSAdlHNheeL3s8gSFCun6iUw42?=
 =?us-ascii?Q?1PLPpCz5sLvRSTEmnEqCNPz+ib0JLlIOuk06fjES5zD9VgMEL0eiRfZiUPop?=
 =?us-ascii?Q?rMDi7VK9XcufQOZZb17Qlhe+AibefyflHXVafAIY2vW/6Ig/3c7iDWtrjUpL?=
 =?us-ascii?Q?OfriVSezHsYop1mevTkAgbRynacOL6FLboBQujt44RY8IB+q57S7b+Cb5UU4?=
 =?us-ascii?Q?00q4RM8N3tr1lQ3P8zMZ83IS7MjX0dHmG85GZUFmLm/vIzK1zP5txmQ/lJW9?=
 =?us-ascii?Q?AP/SWMLZLhdeMDhVostNtpD3ky0jlyWyGl8lDyjlYLcW9msA1kAkgmLGxFeD?=
 =?us-ascii?Q?rqPYrDvg6xDwsIGe6UIfu20oSiRLgHjYdSGWrvUuKuJr5DQrErgEx+yeoMmE?=
 =?us-ascii?Q?/ufSHA1Vewx1Bdu2VpzA+Ip2/fqUD39PCGTPaHSCmwvyVbMl0icw6n0qawfi?=
 =?us-ascii?Q?ujboF5RJ2YoR0trpC2Ia77vfnEDi+kuzAy4s5efG5rXOvjxZjZxxfXby7hWh?=
 =?us-ascii?Q?heHJTBrGpwME117SUyZBvpsYf1OTfTk1GEssN68HQkdjfJAcDrbQ22yh2Ntj?=
 =?us-ascii?Q?fj/NaoZGNaxOCvSOEwetgCkPw/eM2qxljKKNaRCNB9e2lddOWe9q+SLcPhWD?=
 =?us-ascii?Q?5XLp1XkCr+18Dz1+Tqh3B/t5p8LLVqDB729PP8AXX4TArN11/Td5e7jYNS24?=
 =?us-ascii?Q?uEI9+uROlQAgYDk/9sKVklWMpDJeedbhjkSZCaezMtl34kBjirDggwQLqN+P?=
 =?us-ascii?Q?IWcFRvEc/cE8X5b+5vJpMgppc5gYTIqlWaUbjZG8utHTgcpx+HAicnbu9Xrd?=
 =?us-ascii?Q?NlJd3GWQjUWLyvt6pdJfAwd27NrPry3rrWxBf4t2aKWpfmr6um25CSRAVVUi?=
 =?us-ascii?Q?9d60VvqTHOg6UufN5DaexZO0PMaoFgTcGpfRv1qteBu2Uh3o1hH2JAtR8Mm/?=
 =?us-ascii?Q?ulEgt4ZwbfOvaNvNyoGPx8kKIwdofc8TDVIp987kVdkm3g/kVuh19e/sEzRm?=
 =?us-ascii?Q?ZbJpd1G9ASo5IXVo5dGARfwXOpLNyR1UHUf6xllu+iE8dOFMa0cRdoL9DwSa?=
 =?us-ascii?Q?zn/x6qSt8K9XKDsd5hVR6wVxxhhSXqZyRxF9kTiGe3BM0Qwk5rnWZTuMOYyh?=
 =?us-ascii?Q?gc4iHFlscTrGOgBy0qejlt+H4UbwiJpJ6xbMRtCBYtTwhj2C5sg4eTPydD7q?=
 =?us-ascii?Q?WMnYAS772MiQCcZO94L8+tZo/l4Z2DUoZzDBWpkxdw+ZNSVXwG0WyHJADedI?=
 =?us-ascii?Q?TjnaThWtTaBnuW6G9OmHJ/DWYG5x2jJHtL2kJMy+D6puE5idm2+/3UKsholy?=
 =?us-ascii?Q?FuFiKPKmbA0cd1dI1tFKxIsb+wjZpoAbFWRXB/h+n4ofNGPgWmQ3ui2NO8SN?=
 =?us-ascii?Q?+mhJm0b8WcJKzd5+Uqm3UU1bvvyCULS7xXcKO722C9gwO5aTXUQhl5anSa0S?=
 =?us-ascii?Q?muv9xGLT9vrjrcaJknRHIq0LXFjz/8cX2zpRhaRyIxGy/tOh0thVSV6SW5kO?=
 =?us-ascii?Q?TvkiHVhjm5cXKu3ifTMo7B864k7bZHlhxqoFgB4XWiO2Vm6/3sqI5bqW62j0?=
 =?us-ascii?Q?l4dvXrgvDFdS8TSqLhhF2Ehtcwu/NoHPG5lB82HL3XsI0Kvk0mOOv8P2qgyT?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5f4280-0441-49a9-b487-08dcf4350ca5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:06:26.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A4GGOSaiHuGIIlhruKaIVDaV9o4TcZmDf2LRLpPxx5z4/O+FgEzydayuz4p5hiFS/85P4INFNDEyCjDpuFVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10560

On Tue, Oct 22, 2024 at 01:52:11PM +0800, Wei Fang wrote:
> The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 EMDIO.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

