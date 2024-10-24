Return-Path: <linux-pci+bounces-15200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C79AE860
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 16:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F4A1C22654
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452461D63C5;
	Thu, 24 Oct 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VtS8f4nu"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA341E283E;
	Thu, 24 Oct 2024 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779405; cv=fail; b=HxEXijqmhuKejQSvNXlepOt5uXagygThxtqQnOXDHZ8/oOgEoin+4OsdupzNHNzILQo2IYFpyOCHyL/n/CEFKHjBdLbuXkWP8VC9isR71cgtbkje6J/jx6f+Q2JyXMujPABsXJhj2PsyFBguCY0lO0TSoHtdp6P4fXEDrycoPOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779405; c=relaxed/simple;
	bh=SGbRxD2akB1ui+XnpCdNv43NZ38EGjrkGD4jZRjJ1TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WAPOk2bjFNumj4uN6KZMMbaIggwzgNvhb+eAuvX4HnimkBa5xEwFeoUhnxPfAM4MX7VCsDPLEC1gYpmSgHeAGHezVQuYzwWCMqVKVicIn92cC601IOkBD6QmlengMa/SfIJa7uD/cA1A5kmPih2hhrfAvB6dAwm/ZtrwPE9MwnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VtS8f4nu; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5RN82/S572Q3k6YgXuAMxXiwoUmhCZEWud9ZtQ01dhEwG9U/5Q0jZGDPXZNERazlLE22DskmL4iXAD0HiQT4Do6hMTu/13kmPYWFQqQz5sKb3qwE5BLOs0ktYOfkYcRDkwRs8zQAubaBbOFWsOfTk8eN9upOsy3Xqkj7q1u/Yu3FWVQlfSxtVKRIgT3Cdq7gQg2GVm9bI8JO5LwhgMlAdyroTEkpDsycazgTWj0HOeU7Me7A3DGRGI7RHAaLaUL5nJQTeAGvLMxLKIwm5diVXl07P/c7hmKzuww2c2ZT93l7sUy1dEzPii8KzA8wg7Cp/Q1pIO/YYrOxF3kr+yM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bJqchE6dS9Z4fxCns1jj4YeAhJUr98Kyjedj16lN0Y=;
 b=c5FluSE+6rzbv9fXZJ9zumAXa+fjUQn7FTStW+Np3KwL1W7OQwkbzJg7IQHgq8vr4QVpkKtJFGkKJo/Pq10Q7igfI1K14xw3L6ZzPckHnftgHj3zYaT7KgeNV7Qeo+zy4HWavTLkbeansZHIywaEMvHzEJ2CsWZQkEUhBOK5WUvUpg1OD7cvNcvag3JHjZieYaQWXkeoYka2BLPFm/E8H1xjY+eTTWmhHLVKrJswnh6L9YMZuHZN5HgzMTqdEdkqrV3Xyzh6xR/vvuARuyufx4dLBVRH6Ghwz7P0WJV3+oFL+0K+fo3giva2psn5zFfLYnAbejMi2BDpphzU7utIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bJqchE6dS9Z4fxCns1jj4YeAhJUr98Kyjedj16lN0Y=;
 b=VtS8f4nux73mXfC0me+SshlNfFOVVDo7kV4HE4CNqhszSQTIHhc1/tIDoN/HLIEXTfN6CnVxnCsjqBpR01rvfdgwb6C7UMknjqYfml5gEgHqIcYZKEzRT6Hx/JCAsJD8/PAuCfdOvjHDes9nhU4v9JueLNMdCpM7hbancGlhcsICuYgG9VUHdTHxs57Fa/t7xpKxZgut9V4hz3oWk8rZvartYD0c8MHZlORjI2jsBBAt44niG9i+RCbtzdXLdGlw9u5k2MxoZF6YoW/t2b7SmzLsbatpeVmW18ZH26jckURhq0XjdjjCD4TtghWCw1ALdjvG1+LQ9w72Nraf9iA75g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 14:16:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 14:16:37 +0000
Date: Thu, 24 Oct 2024 17:16:34 +0300
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
Message-ID: <20241024141634.v6rvomql6gkpnf6a@skbuf>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-2-wei.fang@nxp.com>
 <20241024140623.yr4lgjp7pryx344i@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024140623.yr4lgjp7pryx344i@skbuf>
X-ClientProxiedBy: BE1P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e83e5a-ab8e-4dc1-c4b8-08dcf43678a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yPNBh4AoPr4Jet2lJDjIm+R23OTNOJRyyxRD2JY0h11ht5Ntgehz4z8Vs3l8?=
 =?us-ascii?Q?5KnUWzYrghVIg/TOcL8Dr7K8/gw6w5M26j1AzVNiMta6cWyLIiE0BCIgCn13?=
 =?us-ascii?Q?IpQN1nwkC8ankLLYYQEqelqv6evKOI4f3kbKZxb5HpD5HiEGJYQgXkW/bCjs?=
 =?us-ascii?Q?VLZh+1ZgUyOUnMF+1FMJSWJgMWcA4qVnj5hkdAguGBaSCNSrQM+V++50H0Aq?=
 =?us-ascii?Q?liIQEgj8nz3AEsp8lvTpU4cmzxmUSH6utNiidc/I9MyaBF3/QLfkRQjRxeb1?=
 =?us-ascii?Q?LgYiXicA4R2UpusISpbAs1NlXB3nVFvbxVQVXfih6j+nPLGL2WZRlygdtZDR?=
 =?us-ascii?Q?Xa2NJOrYZzvka3aPIZRqN+mT0BuNDSzk3GxWW0GW+6AoqtvJhYI/0WSmavUQ?=
 =?us-ascii?Q?7DH3PDKCuTXvsCRdlerMy9SyjM3ge0ZeRosBynb7WN57CBYSFfGnYSm4Vf00?=
 =?us-ascii?Q?zBiW/3PtBC2vAqc7ziZhSOllD9hRgOPIjIRTGO3SW/gtzkvGKxOJ0uoDEjFb?=
 =?us-ascii?Q?kK5nMGFJYktqRDWEy3d1Cu0BUphIkIMdVpQmGrKEEFdDdvsnWVqpA5VAJkvB?=
 =?us-ascii?Q?6bcYZyyJMbpU+jEOUN9n5wQKhDSG3QFcegrATzm7RiVF+ZZXk27iotovrkJI?=
 =?us-ascii?Q?L8egfYDPPbX1KG5cXerWdG88XUX3vn7mootPu4vvPTkteQ4jdu5bhbWzEFAI?=
 =?us-ascii?Q?VCQVKw9CsQgcSugInl5z9bWQrXp5meKsWU4Qx/dAbbG+79EVzQUPaPuaO9os?=
 =?us-ascii?Q?neu0/Lq3ARd5YkkRqqBd38ixPHmRyCi6yfGqUR0Z2/Pvkr7Yv3k8WyySgLGw?=
 =?us-ascii?Q?rqQ4qlt84Y/fAub4KdmOPDd9KJN8qMjLgSLaS5GL6cXLi3uw1qdqrEGiKtzN?=
 =?us-ascii?Q?ThGHIUQd+OAHXIt/2wPIVIhEeapzopecX/6708H8PGyJSi9hgPaKnKCiIV1n?=
 =?us-ascii?Q?xXGN3VLIM3N+z1XYd9DbfwEtRQh+WFvF33RJWL2jDI/ol9u0zrPVzOF2i4Sz?=
 =?us-ascii?Q?KD1F+kEjcPLKAa9cU0WM4ljGYYaeRHyMcek9Gvta+QhaBLQUHRJYaCXhfcrM?=
 =?us-ascii?Q?kSHHikxwEK1kDakjfFJ9K0FEFyoR2nYyVc5CiZoVK8g9eHBle2drHXb6dubl?=
 =?us-ascii?Q?Pbwxku4fCbyqqfd/tKL9Du4BTIviU7ua3zQbvuzKKrYNBy+VFVDYZQK5JjLy?=
 =?us-ascii?Q?pFgmn3OlShO1ZdJvywPClxTQZblZf7uEmTB5VbB4cL4KkPletguw9pOYbMrE?=
 =?us-ascii?Q?cWAGds2Qdr5jldBDHZjX2+51GGAHSE1sYyDnUXSqiFYkamYnIcSYFSCcN2vV?=
 =?us-ascii?Q?2zE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rHYM/HUOmeIpUPR+j5/5KGSC1QiSpOpL2R/2gPHCY3U2+YCFv+VO4k03LPfY?=
 =?us-ascii?Q?Y1l5RGHjzQgMjSW28pZRG7wBKr5SmW66215XlNj9clqPmMHYdj9Z3QYorxil?=
 =?us-ascii?Q?/Yrr16THHQZnkoRgwB6aHlJuZ2TlrUnrI576VIumJ7cIkuk3mRWvcc8TJ1Qz?=
 =?us-ascii?Q?5zue0muNuCjdZTg3dFFg8htCsE2XP/rSQD4Wdc0xGD2viImk6/QMTA79IXGQ?=
 =?us-ascii?Q?iQy/HS53w1DbzKOvRDbQzbg0JEBz76z3mJf1ITB1UnPhhiGRdSbBt71Xv9zR?=
 =?us-ascii?Q?wo3TErP2m0cfW2tLXrYsGNYf/NsHLGlPYd0maTNrlwMSr2FldGSAc/eACC1Z?=
 =?us-ascii?Q?mA6GS/8A92971/IU2aCSMvEsud7/SNs1+DOmOPAvQZ+rPh56fHbU18yhr0en?=
 =?us-ascii?Q?RJHA+Gz1t+WQmF5ujvXtSVcJlYr49fOGUv0BvdmdSAaY2dev3QIC0MFdLtmI?=
 =?us-ascii?Q?NDGexC3VJA4tQYCXYcOS1A+uF+GVPWYp9mCpQAoGI+GbUE51KCm8nYK483vN?=
 =?us-ascii?Q?JpPfLNYNFohV31Q2ibKoB1se8LZBRQFcgy8hqJvn4o3HC3XM7urek6YH2Iyv?=
 =?us-ascii?Q?AC1pWz5JrktTLF0huZLMQfj52eAAZqDpisNtyf1ajG7vzjoRcvA0smEIqjy1?=
 =?us-ascii?Q?kedE5yfebs7C8jzVSsBtPxuWunOZtCNcxZRuaIcVsvTHz2MaulJFPcP3sUYY?=
 =?us-ascii?Q?LzZq0V/0qua/Vn658YzegMw8caXyawJoA2xcAWczW+xYkVcTJuJIMy2euMaN?=
 =?us-ascii?Q?4ulVZt1NEBj6AYSgUOLrjM6lmFq01QuY8plsPrGV4itcuz6jK0PoXm30KxcX?=
 =?us-ascii?Q?8mbPOc7g2ZAOHOqsN87/BUlXPtxaypR+j7RYgCctI5u4jbxBsIoe/IwZ7TAq?=
 =?us-ascii?Q?vkG19BHBbQYx/xGCnxnSnbQGNL51Rw5r/0bYzF1fKJBTvVb9QKpLNSaHcia8?=
 =?us-ascii?Q?vQSYJfz5V2XN0Hl1EYK7CpzXOsC3vnZpWapQOASZ3/tXFzu+FsAQFUfMg9GD?=
 =?us-ascii?Q?F3WAbLwNOg89lygOOD2+Pg8oaOhOxIsoF5BYmoX5A/QU9yNtZBOYjAoDvXqY?=
 =?us-ascii?Q?nRqcf2Z798cctnGGQogVG0KkeammCloJTJWFHCvZs9hD3/yi9mUdfIBQgUhP?=
 =?us-ascii?Q?HSHr6mN4OTZZHjLbRrjkkPJ1OQNVIvRBLZjOkOzmyxVcYMGPPvruZbRXi7+d?=
 =?us-ascii?Q?n+Vm3g2O19KjCqc6Vh/R2DejX6u5l+/AtNj/MK1nTN09hnQra39tK/dXtUXT?=
 =?us-ascii?Q?gvXxt2m1u3e06TVrcQjnDJRcVBD9QRUoWmIeDoq/DAoiqBcOiXqbJ8hJx2su?=
 =?us-ascii?Q?utpS4LrPdlKUrPTZMM0LFdQRUFtgwP+umzbdaGcOAfr87XR+oBor3UJ0l32n?=
 =?us-ascii?Q?FF7LgrmTfATjpbKEO7Lz9BLndeVYfCsR5EVbhenSa0o41s4QZd4lmvCxyFn7?=
 =?us-ascii?Q?1CxhQdZnSbqktSyUpjYg9JayP6Pa2gBmVq28UisQOFbi901hGSw0dwf/WMAj?=
 =?us-ascii?Q?rNEnlbdB8k1puq8+FylUxMcv0yq33FTpGibW80lT2ftGAzOC2kKatvq0gTTf?=
 =?us-ascii?Q?0uTaIljjHEUCSJrLiRJ+EzOZEQrO+lsvl7n4/HxACoilDRW72+Dr4rOE/E8g?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e83e5a-ab8e-4dc1-c4b8-08dcf43678a9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:16:37.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDnZ3d95Es6o16Veec7N7TckjQM9dkJVuszbrKyFm25ipbsc0rfcuqa4Mef30FsV6WINzBePyFPHuwfmoe0HwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382

On Thu, Oct 24, 2024 at 05:06:23PM +0300, Vladimir Oltean wrote:
> On Tue, Oct 22, 2024 at 01:52:11PM +0800, Wei Fang wrote:
> > The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
> > ID and device ID have also changed, so add the new compatible strings
> > for i.MX95 EMDIO.
> > 
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Sorry, the v4 thread popped up in the top of my email client list due to
the unfinished dt-bindings discussion, I meant to post the tag on v5
(which I now see that it shouldn't have been posted until said discussion
had settled).

