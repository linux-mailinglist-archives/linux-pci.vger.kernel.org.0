Return-Path: <linux-pci+bounces-14554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1C499F1BD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 17:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9E62823BD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5BC1D5145;
	Tue, 15 Oct 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HPvZHxlU"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1016F8E9;
	Tue, 15 Oct 2024 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007125; cv=fail; b=PUNsmmp+yOxV8IyKG8a8g0dAuwO8jQbiryJJQmK+hXg8wXRLtaM1WNdS8jOpoiyNXUywUR/VezISubQ4rgeI8V/3sDjf6mnXtT0y0lpNZqdFCyuBA+/j1IZwZduVjzoxAX033uDJtT9rdgPSBhRqtG7GHo2RYyDLXoQCtEWztP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007125; c=relaxed/simple;
	bh=H9Tbb3OUtx4H3JmiTqjRMDQu+gpblRUixXI62mt7ka8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TPkxg1eZxhQ+cj/ZXHOMD1rA2Pokepdg9tcvAMqt9ZCd15nkKJ2w8hta1GuNiqd8F9929a8X2f0HXmfZHiUVfqCDvfsiT7ToU/O0cwvRqc6c//uCuQZbGpVG/CaStpZszPc2Egh6IdQoZrG3+9CvH2CbimVRjccb91vR6KcTjxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HPvZHxlU; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpM5Xyj29vuU1HnV5FdFWzTdZavFmDAismPQ/zmYd11E6Z0XsNchgMoj78uMLVaC48XidLbTmikv/3lAuqzvQm6vo277NfUq2HuD0vahmfI3oBRClb/CTjcAcKuHRimQ8YPnB32LJ0jDqSiT2h1AsZFB8bJILgr70gupEXJHRMdFTfR3L1aNC3MizZAuD5sDqGriOiTi/MkiThoxrVMcCTpijY1sQ+gE4YPeVPBLdcDse0t7JZO5ntxiz1BO6Od6caIGbMnoL6zmzBkM/SShaWqqLPkFCbKw1JHH2XeipSLwp92i2sPty7tFJbu+PJASnB4fZHXPs9kqpVoOO+KWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhm1ooMjERUcchpF5xcNE1zz99lZ40+BQYtRnFmpgI4=;
 b=UtSD0b6g16W4LA4eB3CRoJenKFc/Jjozdz3G76AaxABm4PGppESV/ql5ZeZM9ZV9ipTO/8HxFB9zFkCoe9heoP4RMUfbmhjtylfCQoVlAz7pvy1+L44/Cxgx0b7pLG2jj85YVdaj1A2tZy9Aa8iwDqzg7Scy+2J7BdbpZQZwYJyUji1zuNbUvABuw6wOCVOfozSOe7aOuqV9nOUYWAzW6k8lsdoMYzOKM069cb8KLB7ozV5WI5G7gpPlIR3u88+BKmvJTUzYtyR2iYSVFhudrx+hGAieSUH0RgRIqXT2G1TVZ16e6MOCA5SkmveSB9H/okwDZYodWVsgbZHy529FkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhm1ooMjERUcchpF5xcNE1zz99lZ40+BQYtRnFmpgI4=;
 b=HPvZHxlUbXY5b/GRSdexPggJIKsd8DvQl6WGxT363wr3CMOOVZlxd+rjvhsMcIA5Jbu4Y9XTVSWhMXJTOUAehKZuPsDR0JEraIs+j5r3xC193rEXI8SU+0sTb7yzpNstTokiZu3A0nw3watFnxboUogDOZjGQQRMLrnGp4KJxyDlSNO255Yq3vvcAMbexn5QBZEEE2dP4a3u1HVERHyYkRPbC4r2xqYYwID2YDc3B9315pwnjdRfqRVcfO/cgCtSz4EY6+cLtH9jj4goPriWgIpB5VO1ADIq5ZwsC62lH+Kr+Q3kWSw5JpORXu/XmfiaI1zdOWBHe8ZTUE+ttuW2aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10185.eurprd04.prod.outlook.com (2603:10a6:102:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 15:45:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 15:45:14 +0000
Date: Tue, 15 Oct 2024 11:45:05 -0400
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
Subject: Re: [PATCH v2 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Message-ID: <Zw6OAVT10JrnFkSO@lizhi-Precision-Tower-5810>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-4-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:a03:100::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10185:EE_
X-MS-Office365-Filtering-Correlation-Id: 90822189-a2a4-4571-0e6b-08dced305ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VvxhysofUFHV5vbNhk48W+C2YiwTLNoniiE9qHNEAcyf6vJu957Q27BnEt+v?=
 =?us-ascii?Q?a37IQp8cV5ZI7b/DvfWN5crV/89jftvuPNLlZp3T6b96RJwd0F9GDaWHenu0?=
 =?us-ascii?Q?zKWvAtqJ661WY5Zow4DATo5Qm98Qt/AjVpqOYBwZRmbdwik2k1HrqMMl1L3K?=
 =?us-ascii?Q?gL3giKSaTIQIGBDijq/IUNx6T9xL+yUpiObtR8a/DK3D4EJmPYhJWRLV8Ryd?=
 =?us-ascii?Q?BDHeHvh1ikkDTcgYUZrZte1L7h9VasEMkXEBDBYKPqWKsWQDs009G9gpGCmd?=
 =?us-ascii?Q?DJWv1AsDE96QtBK0mTIPi4/vGj1rqZH0duihczoUCDP37sgeP275w3PF/7rQ?=
 =?us-ascii?Q?iXJh2Vr1Oy309Twar9s/Y1wHkQ+/EhniJCj87kqYWkHmG/i9ov8mWcBmeSZX?=
 =?us-ascii?Q?fYaf1K0Q//IaMGWepHtyBuifD/HUXA8UgiZi/sud14cW9wXuU8rtBYA7dvdE?=
 =?us-ascii?Q?ImUQ0LE438ebrbQYEExtXeY2CiTGbzc/TYTxJRT8UvDEdh5xu1XaW+E87xYp?=
 =?us-ascii?Q?a7S/M+RmpDuq3vxHmjc2QjGBtCrQsoa5BLpZ+hbpFzw/+0LROmKlID6pAmTx?=
 =?us-ascii?Q?YgzloW4AGCHliKvIM5JItNe8qQkyDmeJZVYhSTCAsMjcIJmzr3at8ZoHQbYb?=
 =?us-ascii?Q?cryKpogA0AYbYJto1PJohM/Bb/4O5WK2IpwXyJYGkD8Me+t9Fq4gQA6Obh6N?=
 =?us-ascii?Q?5xFJKEWTmTeOw3p+7bc4Y7jvn641ODEkVWtj9+KmhgrQiH5wtvrkTVMOc2WF?=
 =?us-ascii?Q?jAnqeomEcTQOC2cziqTF+2opLxUE5B4mzdYcNWBsgD6Wql4UElrP7+Zlwz3G?=
 =?us-ascii?Q?9PptJFPSuoOaXU8AnPR96JZYDtuo3pTw6eYjMSXC9KWJdBvKMx4lP+WHHNs8?=
 =?us-ascii?Q?7JkjDwA3oZXP1wyEL5F8SEa6C3j/bLd3eVM3zZrHcZQDqqlC5yMOBnWG7s1H?=
 =?us-ascii?Q?HS04Y7VRyD0HTkatsyf0dy4yMqiR676y3KN0fH1YicdaL2XFS1dvra+3hvyR?=
 =?us-ascii?Q?bsjtIJzJQPrsBlMRuVMaQq0wtwmGex7FCz5cUV2JLA3Y8mdp8z7uSXMv6Mxz?=
 =?us-ascii?Q?z9Y4dJz+jKi4Xyl7viMn2DCQMC7jg3TSUXXRGT9rT2y+3FRaLwPH7yphZI5Q?=
 =?us-ascii?Q?fLm9LCZos4nDjClcAaAVptu4vSDHGGa7/IZODZPn/krmSc21AZWE7z3/bWL3?=
 =?us-ascii?Q?FONH4i+oJO5/rC84vpSVncbVItm44fqtkch9cG5G/bhMh8fix7MxkGVoRr7r?=
 =?us-ascii?Q?uNxKxftdCe2gs3EaKnV7B3bpz/DNoFtkwuDBAkZk+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJg+HbFkMWoCPEDJa1zjk01fTF2NN/kLbhZFRBZsss3GGDmUSQgWVUq+ehAz?=
 =?us-ascii?Q?HzNNOC5vZO3LPxxlE10K5WqYP9yURT0iY+7iqKswhln5ffSOK3eD6EHihSo1?=
 =?us-ascii?Q?OAfxI6s5dQwwBdYWLYQpBqaSfPOcjK6zqavaIcqPUEnI7dhNRGaMziSbY5Je?=
 =?us-ascii?Q?i7dP+7M1W38knf+LiYdkD/HPlVVpLSmIeJ+XbL5sG9L5BPSVWFAbPfOYh8Cm?=
 =?us-ascii?Q?mNMTjCHMYFjSw6NSQqQQa0IgdBMYTnQMKuPVHU4GUGGqHEE11yX8eybyM6IW?=
 =?us-ascii?Q?KtkMCGb4m7ELZ5S+B8f/rWLRowuolKQwBAFpiqLKl38RwB0dscL4L3/zId7V?=
 =?us-ascii?Q?s4p+WItsytLCk2OvAfmtVGuE46bmQCAHoUk5FpXONATCp0KfpiluJafQX5iW?=
 =?us-ascii?Q?WpPE4W3vsSZjH/70P5Xffp9w5bQVwiNbRNddsmRm7jwYrIY9oSkQuDYol61+?=
 =?us-ascii?Q?wUcZNn9WOCDXoQZ3jtWPnEbdSVeXBqifGQdBAs0cy+JJtzbSPlUOBbqzolgk?=
 =?us-ascii?Q?3ruNLHG099/1iGznVmt91jSVQDMbjF9W/xMJmGB9TrhTjkLwy4+d5V6chyy7?=
 =?us-ascii?Q?Zw5dkTQGwnQpd/sG+42FQkOsViRmXKQmmiJMH8E3k5K2I6tu0L0zOwF5QvRM?=
 =?us-ascii?Q?tmyRlNeaLTMbE7Y885sxBRTzHh+oT1O8ufYQTggtlvh0r+j+bgXZT8SWBK0B?=
 =?us-ascii?Q?eSr5hZr6dPv3tzfGQl3geHeXKwRdhhZCjWtbI7hEs9kM+Jmr2hHg20giyyE1?=
 =?us-ascii?Q?PX0BZ3pREDW75+vrckRmj7pwOLxk/grsolU3Q/1P2OTYz2noqUcN0lQAMAk7?=
 =?us-ascii?Q?spvcB6YAeJNplkGASpv0JHQUA2emXpgsNlr/Z1JitFCHHZo1M55/Iol7Orky?=
 =?us-ascii?Q?fgPgJr13z13BTqBarspCwpc+GkJpEENqMMQzxY8bbmzkiU/CMYuOq0eUki49?=
 =?us-ascii?Q?4MuwxHAOX8pYyCLD/lLSII4Xm9SgxSV9vG+bRXmWY8GgErJYrLCN78D7mWDS?=
 =?us-ascii?Q?+STWzWDHsShJpipHECmhay0uurQmGC4rx3kBQGEEOi5CvgHOWPuTaCaXnekj?=
 =?us-ascii?Q?p+XrGvw9//0JU+h7xbWPbBawcpdX3vMQ2Ubel+B/derhCc3ENqIQKzqaBYvG?=
 =?us-ascii?Q?XPU6PZoRwn+BL7a/yyygq+c4ou27bgA1M4fYlCtq3p+qEZ+4cPCe4t4CBOwh?=
 =?us-ascii?Q?BCetWNEWPLV9Dkx+FxLAkDqLJFhHM32LRhBgj53WUyHspAAUtOGPt6xBjDhV?=
 =?us-ascii?Q?daxh72y6m93kbZvh7u+PyHhVn99s17pIKrB1AhVC3kL8AqTtyMMrljrXT9Au?=
 =?us-ascii?Q?sRdNmyJnkVaWt1hK6z+6RlTnB7INq+6uRFe5vb06L8rKfTGXSuHb3CLIAsbu?=
 =?us-ascii?Q?3o9y73598ZhL3MBTvIn3JXX+vA3BtFH8kOSHvtpMTbdK1Mk9IlgTRDJht7+b?=
 =?us-ascii?Q?hXlFx/mV43veyG9vGzcXffrvm08hzUvoapyJWP+J/jHwh8dquBidDkANQWFp?=
 =?us-ascii?Q?qHboJMeu3UFfNi5zgQ34dnJxEUsMdqKuhtdFPfnlFkndhnBjE1USXLtWXqm8?=
 =?us-ascii?Q?qnyLL22xdoq+86WKssDQ+iMO1f3PDUdg2+vOW8pj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90822189-a2a4-4571-0e6b-08dced305ca3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:45:14.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5s8f4RqYn+grIsJ+gkLSHnwSYwDG6dyYMNF+M5mcgL4zR2X5uRwDQiJt3BqBbWRsICPK/N6kylHwdEGurH1uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10185

On Tue, Oct 15, 2024 at 08:58:31PM +0800, Wei Fang wrote:
> Add bindings for NXP NETC blocks control. Usually, NETC has 2 blocks of
> 64KB registers, integrated endpoint register block (IERB) and privileged
> register block (PRB). IERB is used for pre-boot initialization for all
> NETC devices, such as ENETC, Timer, EMIDO and so on. And PRB controls
> global reset and global error handling for NETC. Moreover, for the i.MX
> platform, there is also a NETCMIX block for link configuration, such as
> MII protocol, PCS protocol, etc.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> 1. Rephrase the commit message.
> 2. Change unevaluatedProperties to additionalProperties.
> 3. Remove the useless lables from examples.
> ---
>  .../bindings/net/nxp,netc-blk-ctrl.yaml       | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> new file mode 100644
> index 000000000000..18a6ccf6bc2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/nxp,netc-blk-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NETC Blocks Control
> +
> +description:
> +  Usually, NETC has 2 blocks of 64KB registers, integrated endpoint register
> +  block (IERB) and privileged register block (PRB). IERB is used for pre-boot
> +  initialization for all NETC devices, such as ENETC, Timer, EMIDO and so on.
> +  And PRB controls global reset and global error handling for NETC. Moreover,
> +  for the i.MX platform, there is also a NETCMIX block for link configuration,
> +  such as MII protocol, PCS protocol, etc.
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +  - Clark Wang <xiaoning.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,imx95-netc-blk-ctrl
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3
> +
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: ierb
> +      - const: prb
> +      - const: netcmix

Is 'netcmix'  optional?

Frank

> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +  clocks:
> +    items:
> +      - description: NETC system clock
> +
> +  clock-names:
> +    items:
> +      - const: ipg_clk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^pcie@[0-9a-f]+$":
> +    $ref: /schemas/pci/host-generic-pci.yaml#
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - reg-names
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        netc-blk-ctrl@4cde0000 {
> +            compatible = "nxp,imx95-netc-blk-ctrl";
> +            reg = <0x0 0x4cde0000 0x0 0x10000>,
> +                  <0x0 0x4cdf0000 0x0 0x10000>,
> +                  <0x0 0x4c81000c 0x0 0x18>;
> +            reg-names = "ierb", "prb", "netcmix";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +            clocks = <&scmi_clk 98>;
> +            clock-names = "ipg_clk";
> +            power-domains = <&scmi_devpd 18>;
> +
> +            pcie@4cb00000 {
> +                compatible = "pci-host-ecam-generic";
> +                reg = <0x0 0x4cb00000 0x0 0x100000>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                device_type = "pci";
> +                bus-range = <0x1 0x1>;
> +                ranges = <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000  0x0 0x20000
> +                          0xc2000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;
> +
> +                mdio@0,0 {
> +                    compatible = "pci1131,ee00";
> +                    reg = <0x010000 0 0 0 0>;
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                };
> +            };
> +        };
> +    };
> --
> 2.34.1
>

