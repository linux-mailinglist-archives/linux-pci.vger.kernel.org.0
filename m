Return-Path: <linux-pci+bounces-15603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD49B6697
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D471C2032E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3671F4704;
	Wed, 30 Oct 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FPw43Mts"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8616D1F12F5;
	Wed, 30 Oct 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300156; cv=fail; b=NTR/0bH/7/YvK4y6qW7jxOfkObjnjH44oPxR0STJ4v4dCNn8JVV6reXLgPLbt+ayhZppmSkCYxQnQQ0FKGjYyhKMxrULtzkaCgd80mU/UUSE0Lqrk8yCSdlQaBOxRwBz9mydCDVQXyT9tCGN5/wKxjiwECGlVztQm2UZ2wxpMwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300156; c=relaxed/simple;
	bh=IR+ILKMuSp2ePQZf7BLw1k3m34mm/gi5Qg4SdsehOuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NIRITAPzR5yuvazNCDNAuqiBSwiKxMu8GnfpcmefTw9WXQlf0gHhPACw2ktqkXV2xC2+HpNzFV4rC8ULvnotpNZooH7r9zv2ou/7SB6p8T/HTIm9/DQCe5xJxOZnC9ousAFFbW9cJsYPWkGsuVwql1845WI24TJCqK82/VvaEbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FPw43Mts; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg2sKYKGz3KvWY2Hz/65Pwnu8zi9LlTnAp92lM7z4nzrb0Ryumq92aWegHrmwYZh7VyeXh6lsZbd1tOx/iH8HnWpqrU4IiIU5vDdiL85aTFViTSWSmsz1XCA5eyrXXlgn8Z3OU1FTmysPzUyQQ0DG/zIAftJMzp6Q/yTEqWf6TqkkbGRaJcnq/WwCerYmPrqYAFTfLNoTushBEBCcef+kksoCk/KZUJsPDZygfWIWBjH9xNS/SK68orQsEbk0oqhJUzye/fH6S2TVfzCN8wJIl/fE51WeSJa8SugWgRuunOEVCYmJLXZJMFajeJ60nIWivfQwcjVAL51PvcDwo8wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1y8O4FVJVnKyR8V4I9SruvpOeNZScWFlGjjzgqIpKM=;
 b=IfjUL1v2sNjtAJ4MHtKNszGsa/zY24KgnCDZcQe0aLJftUNGxlq4l8hKeNliQa/za/ZcwEw6jypQd2LaoYeCm38Lju8S3KpQAO9WLzMfYfypQCiGsoo1YxQfVWsAd+8ktiBZDbHrHkdA9lnsyYY7/t3YtO+axksnFsQTG6VM0G6NPD31d2UgxUGY8Ouwb1AOoXMLeFUH/e2YcdUADA2l6nwB18UnDDoo6KirEBiEnEppqpfy4H0kgkk6DePJqPzDG/Rs5pvClPI0wJjn7mUcAdLH5DPbcZUUFadnnPJ4Facybm4wOrNvtBgxl9MLTQ8lxAnC73o50wnUOEVWrnMjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1y8O4FVJVnKyR8V4I9SruvpOeNZScWFlGjjzgqIpKM=;
 b=FPw43MtsvguukwVEKVpMWF5TU741FizPOCoCPOjiqkBy7ME7sU7Ebc6Shy/fTA6rrOFgZxHr0kXwMyCq9Z2pyg+pIvLk/xiWzUte8+Iznq0CAptVO1cLUWQ/HQA8GGps8bMjq8H/CvjDJRBfjE4WB/koTE6AWE6098fqwfsRQac5G5hCITJssZPAssBESF1WEq7KJ77kw2s4x4Wh9KPzcroJzVGBnz9gNtwlcUZAM+eykx6HZBI0Ns8Q6ot9UFwrGJ1Oy1C1aVhBFWKlzbLEdkWg+pR42Ve5smepMnaO6kCQDpSQ24tp+tsEGFMkBGiDtQLIlyBSrbRRUd+a+dJoJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9214.eurprd04.prod.outlook.com (2603:10a6:150:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 14:55:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:55:49 +0000
Date: Wed, 30 Oct 2024 10:55:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	horms@kernel.org, imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v6 net-next 02/12] dt-bindings: net: add i.MX95 ENETC
 support
Message-ID: <ZyJI6lZWg/oKCTvu@lizhi-Precision-Tower-5810>
References: <20241030093924.1251343-1-wei.fang@nxp.com>
 <20241030093924.1251343-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030093924.1251343-3-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR21CA0012.namprd21.prod.outlook.com
 (2603:10b6:a03:114::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f6619c-da98-41a0-5757-08dcf8f2f14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZKkpHpawOXZccOv+zJQY3thOoGQqinV057/YRiJOrLgOYb4J6hv7MY0f3J+p?=
 =?us-ascii?Q?0KH3RW+5ewf8vqznZa1XEvt2XnhMcNetdwIlLbckC2FnaMmpRwQnU80H4oM2?=
 =?us-ascii?Q?52ORn7ko2kzqullPho2idz+5NBUXzmtbcZbsLqL1hWy6onHg+m5uCk187M1s?=
 =?us-ascii?Q?eROMXhb6aLEBM7u/87xeJnHu07n2tyPHku2ZW4VUBz3um13rqD0X6unzVOf8?=
 =?us-ascii?Q?aptSAhebqshnu4qI1+RMEpcYEHZSA8VHLSSTp73CYad2uRKsm1WlJ8Yn1bxL?=
 =?us-ascii?Q?bQ9eNzhuf6+Y88LL4TATEyWMnmurZi/LaEy8/IcanRVORSX26yXpKx/4pkEs?=
 =?us-ascii?Q?aS4iVo/TOIvFmF+dDDsBe6YUj658WtBjJBYs6LxaqTnk3x06aXqwIuH/8O5I?=
 =?us-ascii?Q?f7RyAbUY64yBK2Ql6g2U0ORX2uAkGSzcSDhmeFy5+dvcCVIhg7Vy2/t1zVyy?=
 =?us-ascii?Q?HxYV9bLCOIrcRi3FIYAQsGKKL2BsJa+TAyQA7OtoEIUpbmxxd31RmEzpn9AK?=
 =?us-ascii?Q?GgLEDtwIlPbYGDtESnnEHOGjBbyPXHbkJGFixqz83nnvHsib/G/WAHF1EeFu?=
 =?us-ascii?Q?9X/mhmRmb8nzxDO2VWxrx8bKoGeHWQ2ht5PuM3CStvEZpX/qqgDcvrfs+CYp?=
 =?us-ascii?Q?hhbClvakyJG+C7FqpA/bWVPAKyQREL7FYKPyuwtzLvPWGjFIUn4k4FGzCyJU?=
 =?us-ascii?Q?p+sWMkSpopbrvWBv2oBq+MMiWO1jGK94dufy21wBLKW626pMx3M53OJ5DXiF?=
 =?us-ascii?Q?XRJj55h7GOJEdK9aKBqLFeIZ6FTULWewP/0P/QtCB1zglnYzvCEFfh1OKzJ0?=
 =?us-ascii?Q?/eM8YTvVu4SE0gdO4SSTHg4t9oNk5gSQ37ko0GNZLMfPSioYTHp6hdFdBzDE?=
 =?us-ascii?Q?B4AzOzlnVTSqZaykpKBo3ULaixUXtlcQyJdfyFWIMjKcxNdGoFuMCBjGcdSv?=
 =?us-ascii?Q?+KI0GzT+2RxYDj00/nNgpzgoy7h2lZBz0BQrVRfk1zPead9R/1N3nwyhvDwt?=
 =?us-ascii?Q?zWPa8CazRDn4sbar5Vjyg6zSrrSG89n4jaSy3uCKWBeMPHJlRgTvhMTWxjXq?=
 =?us-ascii?Q?H8ghzcOisAujq5bktMxSmrjOxJqeHUTX4QjnE7aHaYg+r3umNP4xys1p02/H?=
 =?us-ascii?Q?2WNsijuJxiYndUxC2NhPn2VYrsKpAu0uDzAbnMAYY/IFVcr5yz3Gl11rIQ2J?=
 =?us-ascii?Q?jcNdK4H/lWbPF51prBuRbDnQacbL8CIftLCnMdJ+wwc8yIQHwTAruWrl3GFK?=
 =?us-ascii?Q?LAgQqe4dcrM3/imEJ9DR5eZpHMG4LIXzyCSATJBjEVRKsq4eUAsMYpOSytyA?=
 =?us-ascii?Q?bARCpNvsWgpSBrYaj3NWEomwxwDrmEqEdH1w1fOg5RabyDOWDKqz5sbdk7GV?=
 =?us-ascii?Q?CRHV4tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JXrnPSXEmKy+kTIu/KE5P2AQXeFCGSDbRUIOSBj8CcTzvbSMl3hAKEPPvXZi?=
 =?us-ascii?Q?KsdHrmTfJDRLAdHcQoAestnq/s42E8N840P+/Cd7CAJ5bJQTFd8jSVFqxA3Y?=
 =?us-ascii?Q?14qrG9Y3HjmBgSpGyxtqYoJ9ZT+8uLbUcqGtdL69Z4wMLK/G/5d1WxqsgaV1?=
 =?us-ascii?Q?b++3fivYb1FrN4m/qW5fvkwwbpIkqKbYsIAQsmj0CMM7Xho5UHnuWrlX/S0y?=
 =?us-ascii?Q?b9V7hjEK4jBxtCVd3BtOspACrT/yP0fjiTVT4gOKjV2gdBjZo1JBOYYwdHyC?=
 =?us-ascii?Q?0pgJW2b4Le8APpNoCGoC060QrjeUXhrqzwxi4bZFK2rynxIjKl4NT2GQ0eIs?=
 =?us-ascii?Q?jDbOqyyNVGqCIemVgLK9CvLUkazYUBj/V/6y4LRAHveSQ8OoFvy9esRtnxbt?=
 =?us-ascii?Q?38Igxv3dkjJlVu9+C6dmGGe9w2Vr9GPMcVBCNQ8bzKox1z5NMLnKwv02hra7?=
 =?us-ascii?Q?9ENZPgxMgMPzGRK+rCLikfjbAZNYuRDGtnjbFJHCoK65g80215d8Cj+5PO7Z?=
 =?us-ascii?Q?DtiQO5RmGwELrlYzCfl3uXIJ7ZCEsE/BdfSSQZKvmh17FtQn4rnHD0URDUz8?=
 =?us-ascii?Q?0inn7JN6RhAc2TROj8vBhzjTZRvyfI6dDMGSqxbWjWoPXN4rduEZCe35L4QV?=
 =?us-ascii?Q?/uaJfHxl4aPRpbhfxk4UvgOh0TNcsnVifVddlg+jSmgXJE/zLhvTo22p3USg?=
 =?us-ascii?Q?6JSOqJn6Aj9e0kqEzVObqlJYvuYH8E5V6WMPZnoaIkadJoRjfr7E5PtmKZB8?=
 =?us-ascii?Q?Ai3fqrZ4bCJqWfS3NaoWQha7y/teygaEPjvhjFRzqOCdmQBghNk68j/v468A?=
 =?us-ascii?Q?FRRBVgT/w9X8QS3yff23o2lEmQ9fnM+mTqih0OBO7DexBD5kLzj2TKUUIL0t?=
 =?us-ascii?Q?6zc6dETEjDKA2HQV5wzYWcCvHPheko4DmVdn2fFHZ97AufTLHOeuV+9rxOTL?=
 =?us-ascii?Q?1GVWKGg+7NcFpQHOp+G07xdi7To24H9CJzgFUtdz8SdMXtgOOIuaJ4/0O1nN?=
 =?us-ascii?Q?Rkj2/SRUYvlYO7HyUrv6PzIfjiqKF5FOO96nMqlTY9k0yp21WNFk4ZLIVidh?=
 =?us-ascii?Q?d6tz1tx0M6lxdOBJGm/m368FlETVjYBNz1+TCuoFrUbR75JX4SrEJX2GXGMA?=
 =?us-ascii?Q?f/go6LSO2jL/xfa8eDYnWfLE+qoYZjEfKUR86+FAZls1+vu/oPdTwIwhWIO6?=
 =?us-ascii?Q?ZmWM1VGr1FT5lGFiYRu6Fdy+nPyLAMIOw5E9lYI1Ww75tNRvNYzYkEV9heft?=
 =?us-ascii?Q?mVsQ4Pn6QFEDDtXqpg96ElZsdWBft4+m02UeDi8Vs2rBnH775mFl3KAQdFtQ?=
 =?us-ascii?Q?a/m9wbNh80cpx1IgG+LeU6McFxXPfNTy47U5y5Uevm1OgIhdgFDKCbNX2vO0?=
 =?us-ascii?Q?hwdZwMm6gVFU3XB1L7LZr4RH64kxNcBPIHzpAeDs3gyqcWkz/ApZTydAI6zI?=
 =?us-ascii?Q?GB/SRoMxyUDuOtBK3SnLd7XsIDhtZQb0mXXECT2ya9mm75c9jz0PwXuXjCDX?=
 =?us-ascii?Q?cYeKCzKL82t2o1dIrNOk2Orz6bwrNESKS2ESuq/KaKzFwpMxnLqY0wF5/1q8?=
 =?us-ascii?Q?qqvU5HKOu71Tdqlue2A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f6619c-da98-41a0-5757-08dcf8f2f14b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:55:49.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fD8Tnq5fYHvd4Bfr6jp0mtiO5OQ3KxGokW5GcYR6i2hlKdzrNyRsaUaDFAUEXrcem3TCrTvLEk81NpJFvrhLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9214

On Wed, Oct 30, 2024 at 05:39:13PM +0800, Wei Fang wrote:
> The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> or RMII reference clock.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v2: Remove "nxp,imx95-enetc" compatible string.
> v3:
> 1. Add restriction to "clcoks" and "clock-names" properties and rename
> the clock, also remove the items from these two properties.
> 2. Remove unnecessary items for "pci1131,e101" compatible string.
> v4: Move clocks and clock-names to top level.
> v5: Add items to clocks and clock-names
> v6:
> 1. use negate the 'if' schema (not: contains: ...)
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml    | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> index e152c93998fe..ca70f0050171 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -20,14 +20,25 @@ maintainers:
>
>  properties:
>    compatible:
> -    items:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - pci1957,e100
> +          - const: fsl,enetc
>        - enum:
> -          - pci1957,e100
> -      - const: fsl,enetc
> +          - pci1131,e101
>
>    reg:
>      maxItems: 1
>
> +  clocks:
> +    items:
> +      - description: MAC transmit/receive reference clock
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +
>    mdio:
>      $ref: mdio.yaml
>      unevaluatedProperties: false
> @@ -40,6 +51,17 @@ required:
>  allOf:
>    - $ref: /schemas/pci/pci-device.yaml
>    - $ref: ethernet-controller.yaml
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - pci1131,e101
> +    then:
> +      properties:
> +        clocks: false
> +        clock-names: false
>
>  unevaluatedProperties: false
>
> --
> 2.34.1
>

