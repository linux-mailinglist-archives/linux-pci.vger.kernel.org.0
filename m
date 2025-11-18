Return-Path: <linux-pci+bounces-41517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40009C6AC9A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 18:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13344368295
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B30833C50B;
	Tue, 18 Nov 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QvXr6Wl0"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CA241695;
	Tue, 18 Nov 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484889; cv=fail; b=VAMCzx8lKXNJzav7tKM2HGRn7b/jx4+IwF8Dheug/5ISF357Fd/j7FYWRzLpoAU1tmkZL69hBZQnGVenQ8rB50xL2H2Imn42yQ71k4/klhaP+LRF1JLkUudKiwLlMRt/LbgTZsNSQXYT+LqL7HzMF83yv3UIsbte7ojejTA9eUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484889; c=relaxed/simple;
	bh=qi6hnF8M+3PhpXRWSJpYdqg0T/4fgzoNPo/TWUKh6o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AzJv6iYdBdKUoJEVFJnOGMgzFXd6fYZacrQRjh6Lkcy++DzpYw9nH2z5/JN7f9QSTrBq2ZJyTkC2+uyPSeJnSaxW2fXrgLAa3V79I/qQEo5BxfWllPeztemPU6GOWVAgs2bZsk7bNwVcLkufpblQgM9WZhVU5dS7MP+R8M+PW7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QvXr6Wl0; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhhZ1R0TLLziyxsGs7REKpzhyazjDkxp7UD8auWvpmDJvgCKiHnYKlhsalo9HXB7Ewo5gD+sbZV2mFLZYu4gOBaWHtgp/CNgUWdMA9D2jrsrd8/TNkJGTQuZrWMLeLm9C7kgaDah0JKeATsto5DEw/BzBQFIZqMDfCjRjQwb4bhIz2RdI27qorsw2ove9JUU7uzKdRN2Ci4o57CONDgTszgs4vS+xM0MYRKUfJQXHG2/viZQSJK0kST7yFKY9h+apFZc51wz1UHMnZ2kgM4nJoygvmZZjbieaOPyuXhQLdA5Yew+RnItNKW6G3U9O4KAM9TShYmJgsNaCu9JMkbHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtV62+1Xttx7D+Nrxcnf3yfcoYR0ovFjAOJe8VG1wDE=;
 b=tylz7kRyAIlRXYO8O6cMiKIiuMtih2bFZL5WNelJ5vCDqEGLd1PQmXmHpYfJLm3Gix41BXVTUy1C5MEruHAukFIxmibovFFWSpgioHQ0GKrsuHeG3SIYb/OBhahhSCtNOfOU+L0cB2x7mlw98W+VTZOHfG79mYwySWR2sxt8sLRO27Y3P069db4e1JglUV/YDn8deVrBJfh7RL/NIkN2UmDLf49jNp80zdcVTPdqqP9ba21j4Me7ZHugw7yakEXvVSzo2aepzQsFD3ZtJsNdj/titWpD/GJvAkUGLcX8uKSXtap215tsQEU9b2uUVuseMf7KQhuA4pQptKAyWlNMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtV62+1Xttx7D+Nrxcnf3yfcoYR0ovFjAOJe8VG1wDE=;
 b=QvXr6Wl0xhWWLnZOi5In/ckx3BvT8VyttvrmvqG3BNegMFAZgbCJZW1oiK3sf6TBa8c6zxsoXLhrnVa91aPrgJ/8MbciZxlbfDpaIGYRFe8YN9VMHdxs0bLHRqZHeMrNFPkfzlZc2h/pjPOgTeQdBWaT+/7wl0r2xYebeGCCX/4Aj+LmlAvbAtiz8WSPG78l0UVETFZOImXoTsOAfewiW/vx/YLxxtVRtzes11zJT6Aig1L4MDBmw9fIScZbVptdzQxnEZm8FyKCbtasLHEgXYK6XtWjfRfpY2YX95XiEX6gRZOPRN6XoQczeLhj8gjqdlDlrSiAoziFFA88ZkI6MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM0PR04MB7121.eurprd04.prod.outlook.com (2603:10a6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 16:54:44 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 16:54:44 +0000
Date: Tue, 18 Nov 2025 11:54:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	cassel@kernel.org
Subject: Re: [PATCH 2/4 v5] PCI: dw: Add more registers and bitfield
 definition
Message-ID: <aRykzbnsMFFb1Kbo@lizhi-Precision-Tower-5810>
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
 <20251118160238.26265-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118160238.26265-3-vincent.guittot@linaro.org>
X-ClientProxiedBy: SN7PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:806:125::11) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM0PR04MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 4555e78c-15c2-441c-a048-08de26c32cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xWkrWAozlo4czYN/kFw4wRjpydHQJsnhmc3WMI+5sSfrelPz3tHj0eye7ZYi?=
 =?us-ascii?Q?ibeGxDNIJZcgssF8B3+wx5XkS26EP8wEL+Ne8QUMRBTmjq1kU+DIhXwU2YgV?=
 =?us-ascii?Q?NlXgc0jqhCzy29AKkC/+xlLJhveRd0VDpMfeGSj3hmMWIpA4S4dfwFOEY5Hw?=
 =?us-ascii?Q?qQyTw1vNRWHEtS1uFazdagsacytJwTQqM6MenOJvejB6W2yhwUf4IQtgzBAi?=
 =?us-ascii?Q?hVFIaUKvHTx4cfc9jHaKvA0azDVzGSUBD5GcbJvvxK+dxIDH/+esq/SgKYWc?=
 =?us-ascii?Q?Y6q+FbKNoQyHlSC8gmzASYqnRtWBkH5MVl+oxaBtniiKm8Pxh8SfClx92Nal?=
 =?us-ascii?Q?4NMtRBTgn+jJ55jCEpU+PBJdoavr6PzpcIHCT8iqHi8ib4T8md4M0HKHeqAd?=
 =?us-ascii?Q?Yofv7I6u9Znpjd+vdjbCjPXbaivXG5gdZt09rG+dShw/iyCZVGO0vBQK6w7l?=
 =?us-ascii?Q?OqtGA566XrdcjqNHhXrNFY5qCqn2HtNZa6J89ePpe4irqJkt6wUxfOmhB3gs?=
 =?us-ascii?Q?9PK8FIfq6dRe/Iuw8uYA9D1XOnQmo6f8yc5R3H4nXe8PZcyVGWron4KYXOZZ?=
 =?us-ascii?Q?OeocR6TAfqmQCf+/x2u2iivuG7EuPFQGs0U07vAOoHAjC9CfMtJL+ZoBqhi5?=
 =?us-ascii?Q?vdfT5sYfFMvQaCMhpJOIWRElJv2AYDrl1+zgE/f+JHouVBqL7WHOE6kt7D9c?=
 =?us-ascii?Q?A/EG2HoC6Lzfz0ndhdXiwNGduVX8AViqRieeAjB6J/V/WY5Pu8M3ExOW1xTy?=
 =?us-ascii?Q?jQU1nIrpB6bTWOfUAVNwSOCPjV+L+ifcRV1bOC0886A80WcasVG70YY67O8j?=
 =?us-ascii?Q?spNKZtsfF9u4g9+TivRmuNTFc2k22zfrupCoIkoo8+UIDWHd4TTj0q4heza+?=
 =?us-ascii?Q?sMifhyS6TS1GNNwVN+AuYBc/s5C4cJhdNb2U3VCWEhqDeloG49f9G+PGLXvS?=
 =?us-ascii?Q?CMhuomNXX6GvHqX1X4MWFnPIRApypTMvYOHAsrF7ORMD0nAdw1prNbFBFfOH?=
 =?us-ascii?Q?nAteLfeJRDE//iVfcagytMgxo1QXPX74Ai8+wQJXpI5IuwktQE5Zd4Kye4zF?=
 =?us-ascii?Q?acdDlsjRIaiHSvGZp2McKuQKToptxMwHRWuBygnUaF2peZDY8jnjX3WrYBV4?=
 =?us-ascii?Q?1s4JtydB1ZDyHTfCrLihJaDmWOQ3z1pID7HBgL46oqE2j5zOh+VmjotJI9bv?=
 =?us-ascii?Q?wZwjgFBdy02Gfom9QNkig90NErdLPYeIkWP0g8CrvBV51J4ARHr1K9SySfSW?=
 =?us-ascii?Q?jo+cpy6gh9r85cFTgS95Ra1jWiosz0pFf1ek1ksmuAtDlbeuL28cQQRo98MF?=
 =?us-ascii?Q?ZFxxApa+JE+w1CInso+jhF6cFORtYniEOanFtcHe8uHNQV7b1quq8LIfz0vo?=
 =?us-ascii?Q?mWMtRrU40TuHK1QlA7TxgeP36IVLxGubBC8deALvmtGw1WjfKn8WHiVi5IJN?=
 =?us-ascii?Q?aB/pkeGrRlvgbpKY9/jNeLmTWB6jS3QsXyPhHakR6mVR1a6lJe2tD9WDIx7a?=
 =?us-ascii?Q?vAwHSIC8XNityW6I12lBIOHyjregrSo/wOGO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q6VvuvtZk95VUP84yFyGHW3mcfhaE+rNmhGvWSo3IRnYaijrFAU81gAsX4eq?=
 =?us-ascii?Q?6TkgnFC0Y82sxPRBf+Vd/x1PeNfsOKER6475L8ech8/fGmzmJDD1CPH8+wds?=
 =?us-ascii?Q?Zxe/gopF5T3UFUZje611RxAD/gh+4OjYAN8Ag5QqT2hZER+CxfH/F+23Tz2t?=
 =?us-ascii?Q?kvju+lR6fDWUg343jEvSjQ2l7WbXFFS2CXHnmY4S80H2nQaRfIfVQBpEpHgJ?=
 =?us-ascii?Q?FxxSVlf/ol8pEIxs07aUwOFx6gIZ2TPQxgJkIHA9ILQ03oOJflxNeYz9MQ53?=
 =?us-ascii?Q?4JfEVstoSXE+2zr5E97goDs4ZQPcyCBgvH2QmtUB4RwSvKGNg9SxSglKGxFj?=
 =?us-ascii?Q?+BMcTh9JVabj/wLtTDMFF9JLOyHreQLWmi6CjN9r0K2+dFt8tdNCEploWYVr?=
 =?us-ascii?Q?LMbW0RREWWJeR9u2PHIhgZ+4Nw2SFsyvjaYOKnjSdn0VLkqcr+HvrwG/aWu4?=
 =?us-ascii?Q?c+QTm8bCS3Fdcl53ncIHgQPA2pUbZS3Eibxu2+DaQeZziyNs0FlPzhpCYGnS?=
 =?us-ascii?Q?F9kwuFlTWyA1n6hY0IAzWWkqd//deKXl9DphszjuzeaxxQcgQfWexWl/QVyz?=
 =?us-ascii?Q?8DFldxhFjVHFCMuNz39I/G8NXyZta5Xe8U4soQOrCgF0Nh47MwA9QZz3VrHn?=
 =?us-ascii?Q?aIoNIFSHQPwbY3lfCPgFMvqfbzIbc1v5r1BSpSY252oNxQZIi85a4wA34UC0?=
 =?us-ascii?Q?0Lo5Yy/j6of6iAjY6eieO8OWKYgjqRZF8Slqm84QCW7aBVXei3eyTVB1E3Yr?=
 =?us-ascii?Q?d8J3VQcdbC/nGJf1T0difV1Y+V+0tsV49mHAEXEfVw8xEPWLjt91xTiTYgy7?=
 =?us-ascii?Q?H7fyqXjy4B/fdg45jadKycY+HVSVP+Qnhxn368sheRnkfPgo6m17T1Bufubd?=
 =?us-ascii?Q?Jjx9B4HZO/HSxfB6CTRWMmeAZhvwXrUDOP9eSE3tkf80c2aWkite1Bvr/tuY?=
 =?us-ascii?Q?BNzkRuxOnCj7eI8MtoOCTezmpmpXC41iT1wzjyni4NOZ/KcJNRpYaSZeyW8c?=
 =?us-ascii?Q?jj8OFBazTUHQQTloaf385R2NWugaOF34WBfdwosouMjKJy2YG+BUqEcZPCfg?=
 =?us-ascii?Q?f6D4UY4l/5gfepWDuse0tWAFIcZVRndk5XIAnCWIqPh+cSbl76oY4qq6pux2?=
 =?us-ascii?Q?KB02u0kVpgpPaDpqBjq+186nrw7BxuVWJBW6ps8u3DKlTGRHhq767w7k4yy4?=
 =?us-ascii?Q?CHVuXKtEuw5HIGl+1v/gdpJs0h56DVjAEUB5UMUTB3btUmLvMCPyfaoStqcf?=
 =?us-ascii?Q?fZ9XeK9F4Xc+1EFr1Qyg268oah5syurqgaqRrthNBtQHHI7ogkABQAT4fEIY?=
 =?us-ascii?Q?7u4z8koeKG/SZJS/Sf+BvAVOR48tAq3pDEx6SYHKBKxE8LOyayOS7npljbKf?=
 =?us-ascii?Q?WZCeHbzoogmwtH9fFOKHRt+W3GaCx6V68G8VbvCIwuUVOJLLAvNDKErzn1pC?=
 =?us-ascii?Q?8OqQuV5dimMVWIyQiWM0Yt5m+QxDcg3L+uAoC9QPGZut59WoGDNdvd/s9ljv?=
 =?us-ascii?Q?qUc0WQHe2Co6J4WNkNuKfX9fvLUJLQwe5VkrtffFjmEZV7nyb/GcPgBXdhaC?=
 =?us-ascii?Q?7JGJzAm15TzbiusCn3ycSywkhGtSXgrcTZaGIKa1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4555e78c-15c2-441c-a048-08de26c32cb4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:54:44.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKEzdTaBU4H2uUsqZdj7XKm/6/m49GHg3GWFwSwVulSxrH+ZUdzrlbDUuXxWp3FWxq3WB11fD4wMWKF7Oj/BfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7121

On Tue, Nov 18, 2025 at 05:02:36PM +0100, Vincent Guittot wrote:
> Add new registers and bitfield definition:
> - GEN3_RELATED_OFF_EQ_PHASE_2_3 field of GEN3_RELATED_OFF
> - 3 Coherency control registers
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/controller/dwc/pcie-designware.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ec..e60b77f1b5e6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -121,6 +121,7 @@
>
>  #define GEN3_RELATED_OFF			0x890
>  #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
> +#define GEN3_RELATED_OFF_EQ_PHASE_2_3		BIT(9)
>  #define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
>  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
> @@ -138,6 +139,13 @@
>  #define GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA	GENMASK(13, 10)
>  #define GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA	GENMASK(17, 14)
>
> +#define COHERENCY_CONTROL_1_OFF			0x8E0
> +#define CFG_MEMTYPE_BOUNDARY_LOW_ADDR_MASK	GENMASK(31, 2)
> +#define CFG_MEMTYPE_VALUE			BIT(0)
> +
> +#define COHERENCY_CONTROL_2_OFF			0x8E4
> +#define COHERENCY_CONTROL_3_OFF			0x8E8
> +
>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>
> --
> 2.43.0
>

