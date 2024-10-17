Return-Path: <linux-pci+bounces-14816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396DD9A2936
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFC61C21D20
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665E91DF744;
	Thu, 17 Oct 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VoOOstvF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2281DF753;
	Thu, 17 Oct 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183248; cv=fail; b=dyV4iQ+s2XvLW5mtRRCskUv5l2X3uHTKyTxJ9mP2gZXnkUW0z74WsGZesh/K7sSGe/fkAlQdCNPU8EohrHfc7T/TVO++sXODQ9fPQU5OQW//dBOH8hNJsqmLXMTz0v/JgRRdReR1D7TgLY++LpZ2vsLEEuxl9yoAN43T07iOf8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183248; c=relaxed/simple;
	bh=DyC1w2Ijzw6h0gZrUGytTriCKU03/0sD+tRwG+K2B3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iyln0JYs0txcRLVjSg4aadyCnW2SdmP3dWKMaMKEPY+U83FFSNz8cxqtL+vFRu69AWtWGqO/6Nf5fzmcczcZMWp9fQL3U6AgsOknrIkP7hXy4qI1JKH3BMIZ8HjZGBf6/VwcT06ZvYOGB2M3S/B4qekjUYz84RE8D1XfYVxn/Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VoOOstvF; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY8AvCyRASlGeLQBMioh6Prfh+cx2moJ0hoo7VX/5gYbSASAcgWzoac2w7l75csub73A0TxER2cRN7+b1Mm2hdSUNC3IG7RiJAn801wZLu1rk9zMel+qqYb79/4qcTLrxDly2yTwJ+7CF8oFSmNsD7JcQsKDE/lLeDx18fi0gOLT5cEs0tQEMH5Hwxu9xldyjAZb2DOtRo+wv5wSJ8Sf9sjSW9jXs5JZWk7bqqLRTwrKoO6oTqeOVtzXZkB1xuYigz/lh0Bleqg6Xb+vUhmCKOjLlWfbGAUDTyDKMq9UMv3zZW3GuR4oIDqEH3L0qlehEeKQoE5Ci8sJGdmTgWQDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ayo3uKUB1qOkphM96IUbWHgHjmZ1xgFZYG3kq+Uge9w=;
 b=uNONb8lQ6S0quiMzdg8IDuKmYtFzY80CMyrJFxZR7ziciEyGzr1YOvyrEbPWOA5dp1SUNAo9EN08CU2bjBqd3C1NGkS/SAgLiCCGhcOZqWWjrV82dqi8b/okq8wriTEqswjeFJlJpnMoYLTI69xqhgipXlY+T+SxDdW1r70tDTtetH/traJYZX4CC2SkAmiAgT+4c7RNyvq8EMXGtzzlM3R1o3RYnJrshhZiZya5/eN4khU8gFjWvXBYkzqXluDNzPe7HgfGE/T84l1mo8T7wywUcEBlvo2eXNnQ7pvXL880U89s1cdJ8LnJS02B3uASWel0AEDnd/MNYXPVJJr7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ayo3uKUB1qOkphM96IUbWHgHjmZ1xgFZYG3kq+Uge9w=;
 b=VoOOstvFdLYKax8ZsWUmBcu6MYadNGDANMQVuuh6kD2pEelSw5GBwJhBULmGe3KcdEYI45iaJ0XjZgWNMxgTdOwPckEDdwIIiBE3OMj2EteAGwm3iwg981T1ccGAZPrXh22Q5oq3Br4lEWPJHb2QsZtbHzcTBBMwVLhqsBT52WykTM2b/Rrn9lqMfzyIXDLv4ZkaTFtwwjMGmBxdvMFXii+ZyOOgY3IgPahkwYGRWfVif69sVQIfTqjx+gXs/T8FyinZvznFmQp22SnLmqujiFszVOml/fgwrMq+aM+wKBsPJyuYUdfR1fXDVdU7rkHKxBoV/Y1bhr4JUyXU+vsh8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8258.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 16:40:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:40:38 +0000
Date: Thu, 17 Oct 2024 12:40:26 -0400
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
Subject: Re: [PATCH v3 net-next 07/13] net: enetc: remove ERR050089
 workaround for i.MX95
Message-ID: <ZxE9+iaz+QI9Jeak@lizhi-Precision-Tower-5810>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-8-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017074637.1265584-8-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: d44af391-d215-4721-b500-08dceeca6e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?296sK15/00S0KCMC4CUGYBRUrulHrJI09HvNtEyMc2q3qWlcg6LNhvg+6p1k?=
 =?us-ascii?Q?IcOCFKdS5GWFl6V8jA5yrwi7SGBayRH2dDDP8DoZGT8bWfu0s9e0e+/jKeu6?=
 =?us-ascii?Q?Dk2vegRFf309QATAVegdAkpTjwrrHM9Lg7AUK7Ca7HHkmOEhwgKhpfdh4SnZ?=
 =?us-ascii?Q?E2iLSNflLysKr5ets2FoqDJ19iWuNWVvtP5JE3GSsAhhWcQv0eQLx8wUa5ag?=
 =?us-ascii?Q?YZ+3fWKV70FOd5XRu0w5iP9Vb/oVBNbbLXcYcA/LwtWmIHx/LBRpRxURJ5Eq?=
 =?us-ascii?Q?9GPvom6AAczc0hwuNDY1eaHuIVu+8WHjrGqIo11VDn1WEAFLlKP9Ne99Pe+f?=
 =?us-ascii?Q?YEfq7S9fZMk0mtycVyZC8Dm8Q5i/W9F8klyhmYs05vKSbzh8dYOZF1sMBmbu?=
 =?us-ascii?Q?vHBTC6lQAMv+u+Xz13IpgaaBjySU+yFmwuno2yCOK6NIXNg37QtiytjUBnpt?=
 =?us-ascii?Q?75alwxGLVDPx6Q1DdPyv+zqAIFqcPSMeDemWXR502Kl8FIJTwZ936lqArGWo?=
 =?us-ascii?Q?hi8nr1ATXzmtToLme/UUA9Mx7GkD8thZf16qsRkmXkBLn8tSTTNNpXCRHhqQ?=
 =?us-ascii?Q?bhbGCC4xi5K9TVLavKvHqaWYDqPmlr1Xbq2W1EMO13ylvP1z+kJSyQ47tiFw?=
 =?us-ascii?Q?g4pQGutdrcdI+QpFLupWUDRqyQdz3Sali6FgbJ1hLsDqI8XonWDRyw1CA8yl?=
 =?us-ascii?Q?5hDRCnpiZ0nKbFY5lwn2UA20PbY5w1MXRREpUiSSUKONWNcadxm6yy+Lf4VQ?=
 =?us-ascii?Q?mUC3B29EvOBvA3iYRaGwLtSa/Tuv4TQnpkaoivPpuE82Qq/vq7AMQlLuPfu9?=
 =?us-ascii?Q?KTlw3/G9T3dy8NWc5JBWJgBkJm5iPfrAl8wOA2ZR/dUQTFE2c8rKXgtPN5MV?=
 =?us-ascii?Q?7//SObJYi7JBQcoBL+w2jigzHkJOwKg7CkPbW1vQ1vBI+FM3gQf9AbI8PRo9?=
 =?us-ascii?Q?El6YgDqSIEIH9wSgMDzhWNFjkFdvOmzI1XXO+o00ryzaz5HCRbDrBwZBsOby?=
 =?us-ascii?Q?Cz2HGwvBJ5HwqCVR18Bz8DXW4HpRlj5dMsfPejDewwqzhehXjcRp+ij4I3ML?=
 =?us-ascii?Q?1pF0QMpP73IBTKtDxGh+o6picZ8E5OBcfcMY66Ifj2X7V7rVzr4wiC63OY7a?=
 =?us-ascii?Q?AL5QpJON6cVrAP1tq/s4VrInSckqbmkpj6/vowbGHV/BO2nfZx0Q77H7+2Ip?=
 =?us-ascii?Q?wYUI35B3mvZ8htkOqKjFa0+ca+pEfQ67fugtT+ps5krBTdjuwBzafCsuF5PG?=
 =?us-ascii?Q?jNAb1IcdKspeM7G1vjaMqVePlIwH0VSGGbKE2o1feFlbmNEXI4+djcSZqOgF?=
 =?us-ascii?Q?uPRpXCJYCG/d5z7LfXAT3NAUi5qyNDAa22Zmpr/nh8RjbrlFlEhbr+0xLAwy?=
 =?us-ascii?Q?FKsJv4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3EJTr+MbkW6EfT61mHACWuDCqwqBpOAL4Sztb2fwWVHcv/BTZsHItjOySEkr?=
 =?us-ascii?Q?/oIAS/2jvnX0h8y5r7Y+XcfdLsLCCScnyWdDYrHd4CPd14zeSVyx9x4MnDsu?=
 =?us-ascii?Q?bHuJz+gj5RwHOLqOOhGk0B9Ej7c0NseEZ2+wFot016Bwf8xMT02VQ4ZVUah8?=
 =?us-ascii?Q?/qV1iE/EJFWnkrpKDfUS6j0dlVAgd+CDmSVxAL4v2ENVjO2DgapcRMPAlsgF?=
 =?us-ascii?Q?MfeIjUFrm0srBpoHxWPIjn1Nvr1m/eASiKOXXVakvPpdu+auAZjCnDzC31mc?=
 =?us-ascii?Q?mo3PUtnpU4fy8VsJSM0erCH+tlc75trfbfmiPzQ92yigGb/HuMHpoykg8TFc?=
 =?us-ascii?Q?kWKIkHM/AEMITp5g2AP/ZWSIQ1Pmi/jNVIDH0uN5Ze8K5h/bxwITtmo9A371?=
 =?us-ascii?Q?idwojZLe6WlN2YFjHM6wv5AJQfXU9zHNL40r1f95BnWUQ+erpg4/rI8Gvpg/?=
 =?us-ascii?Q?ZGDEAyYF4UROXbIBF3xs5f1GYvCfZqioA0Rq13GN8T7/MEHI87vsLee6xjtL?=
 =?us-ascii?Q?aZAx/zJZk/Te+Vilu1DruI+/mqEkBkAWMVN1Asuhet5ZlOPrywmAp+k5+31y?=
 =?us-ascii?Q?3zdGEe36wrf3XCazsNIjut0fl5iMSJDltb647D0QikPDnx3CqfFSLqyGVBmQ?=
 =?us-ascii?Q?4QggN0RXeDj+pRF1bE1CYjWpMslZmN9vkmhYNlJWqxf4HgUdpgNj33EbMRYk?=
 =?us-ascii?Q?9kDXOlJdE3FPSYfnOqlau5X9IOKNskh5p/vY1QtsotIxsf+1PHmjhmsbEJ0J?=
 =?us-ascii?Q?OMqQB8unPTf1nIhrXgO78HNXYRhPaOHTuV/htsZktZl0OFUtSE2o70wdNCOp?=
 =?us-ascii?Q?GVEF+Ser/YVdCBhkOivR6pKt2oU6X4mlFizszo+haql/SoEdrjjNNTqtnBeO?=
 =?us-ascii?Q?nXibwM1rYsXILycwLJ8dMR+8ToyqIumKx7HyRjjBcpTdhGOf9qhm/VspzmNy?=
 =?us-ascii?Q?jPqJIL15QwMTjgusZh08FqhXGlOZ4CeN0Vsz0pfVT4F7eW3dTDqa9ZATzgD0?=
 =?us-ascii?Q?3BUjlpBgsPmJrRkknvrZVPdKEA1tvonD2iMw3I4N/pqan1yQ6PFO0KktSuoK?=
 =?us-ascii?Q?klSLExC7PiYO65avDxO+Aa3O8AVXM8zOZuHfGuo91XyNXFnFIEc6G0SNX62r?=
 =?us-ascii?Q?1+mvNTV1O3NPAm0KFOLCj+aFmoVq8ikjz0+PcCVJnB6Gsw+BMc3eI5doMx0o?=
 =?us-ascii?Q?OErwDZCNt1kzZ2mGHqpTXqLb5iNWK7InE1QynzqTuPmAiDv/IxtsxUjpcgu9?=
 =?us-ascii?Q?k8qjoJnZV422rGqeoCnYmGq3jg0tkG9v7d0ZYz0kh/GfKx7txlBjkoGc8UuI?=
 =?us-ascii?Q?wM3PuLtaOs6k27OkoSberDNMPx1ZJLdWl+vzcwzFAIVaw+iPR4FUKvqUj79G?=
 =?us-ascii?Q?ZtOT2a765ztVy5DDxdM9QIg4e7NV/n0YbEFSgPDENDbQgWlR3LCXf7cKXw3i?=
 =?us-ascii?Q?20PrmN/fXpeVr4wKT5vUSLCFemG2u01WwvnrUjfswQ20IaZyLmod2kn2KN0G?=
 =?us-ascii?Q?LMjEQmZwj23WXJGKDp/i3MyoEU5Dy+REeReo17DFxPX7XQNiD1EO5R57itNo?=
 =?us-ascii?Q?wQGLcx50ygs1d4YYlbk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44af391-d215-4721-b500-08dceeca6e38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:40:38.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7OAjusvsqWBmJyQcp5SOrY1T9DFEIwfcvXrZzTfcNZ2JYclFBV4Hh0CogMXdMxIhvkY2NrWSsptZr3toOBPTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8258

On Thu, Oct 17, 2024 at 03:46:31PM +0800, Wei Fang wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> The ERR050089 workaround causes performance degradation and potential
> functional issues (e.g., RCU stalls) under certain workloads. Since
> new SoCs like i.MX95 do not require this workaround, use a static key
> to compile out enetc_lock_mdio() and enetc_unlock_mdio() at runtime,
> improving performance and avoiding unnecessary logic.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v2 changes: no changes
> v3 changes: Change the title and refactor the commit message.
> ---
>  .../net/ethernet/freescale/enetc/enetc_hw.h   | 34 +++++++++++++------
>  .../ethernet/freescale/enetc/enetc_pci_mdio.c | 17 ++++++++++
>  2 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 1619943fb263..6a7b9b75d660 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -396,18 +396,22 @@ struct enetc_hw {
>   */
>  extern rwlock_t enetc_mdio_lock;
>
> +DECLARE_STATIC_KEY_FALSE(enetc_has_err050089);
> +
>  /* use this locking primitive only on the fast datapath to
>   * group together multiple non-MDIO register accesses to
>   * minimize the overhead of the lock
>   */
>  static inline void enetc_lock_mdio(void)
>  {
> -	read_lock(&enetc_mdio_lock);
> +	if (static_branch_unlikely(&enetc_has_err050089))
> +		read_lock(&enetc_mdio_lock);
>  }
>
>  static inline void enetc_unlock_mdio(void)
>  {
> -	read_unlock(&enetc_mdio_lock);
> +	if (static_branch_unlikely(&enetc_has_err050089))
> +		read_unlock(&enetc_mdio_lock);
>  }
>
>  /* use these accessors only on the fast datapath under
> @@ -416,14 +420,16 @@ static inline void enetc_unlock_mdio(void)
>   */
>  static inline u32 enetc_rd_reg_hot(void __iomem *reg)
>  {
> -	lockdep_assert_held(&enetc_mdio_lock);
> +	if (static_branch_unlikely(&enetc_has_err050089))
> +		lockdep_assert_held(&enetc_mdio_lock);
>
>  	return ioread32(reg);
>  }
>
>  static inline void enetc_wr_reg_hot(void __iomem *reg, u32 val)
>  {
> -	lockdep_assert_held(&enetc_mdio_lock);
> +	if (static_branch_unlikely(&enetc_has_err050089))
> +		lockdep_assert_held(&enetc_mdio_lock);
>
>  	iowrite32(val, reg);
>  }
> @@ -452,9 +458,13 @@ static inline u32 _enetc_rd_mdio_reg_wa(void __iomem *reg)
>  	unsigned long flags;
>  	u32 val;
>
> -	write_lock_irqsave(&enetc_mdio_lock, flags);
> -	val = ioread32(reg);
> -	write_unlock_irqrestore(&enetc_mdio_lock, flags);
> +	if (static_branch_unlikely(&enetc_has_err050089)) {
> +		write_lock_irqsave(&enetc_mdio_lock, flags);
> +		val = ioread32(reg);
> +		write_unlock_irqrestore(&enetc_mdio_lock, flags);
> +	} else {
> +		val = ioread32(reg);
> +	}
>
>  	return val;
>  }
> @@ -463,9 +473,13 @@ static inline void _enetc_wr_mdio_reg_wa(void __iomem *reg, u32 val)
>  {
>  	unsigned long flags;
>
> -	write_lock_irqsave(&enetc_mdio_lock, flags);
> -	iowrite32(val, reg);
> -	write_unlock_irqrestore(&enetc_mdio_lock, flags);
> +	if (static_branch_unlikely(&enetc_has_err050089)) {
> +		write_lock_irqsave(&enetc_mdio_lock, flags);
> +		iowrite32(val, reg);
> +		write_unlock_irqrestore(&enetc_mdio_lock, flags);
> +	} else {
> +		iowrite32(val, reg);
> +	}
>  }
>
>  #ifdef ioread64
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> index a1b595bd7993..2445e35a764a 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> @@ -9,6 +9,9 @@
>  #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
>  #define ENETC_MDIO_DRV_NAME	ENETC_MDIO_DEV_NAME " driver"
>
> +DEFINE_STATIC_KEY_FALSE(enetc_has_err050089);
> +EXPORT_SYMBOL_GPL(enetc_has_err050089);
> +
>  static int enetc_pci_mdio_probe(struct pci_dev *pdev,
>  				const struct pci_device_id *ent)
>  {
> @@ -62,6 +65,12 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
>  		goto err_pci_mem_reg;
>  	}
>
> +	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
> +	    pdev->device == ENETC_MDIO_DEV_ID) {
> +		static_branch_inc(&enetc_has_err050089);
> +		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
> +	}
> +
>  	err = of_mdiobus_register(bus, dev->of_node);
>  	if (err)
>  		goto err_mdiobus_reg;
> @@ -88,6 +97,14 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
>  	struct enetc_mdio_priv *mdio_priv;
>
>  	mdiobus_unregister(bus);
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
> +	    pdev->device == ENETC_MDIO_DEV_ID) {
> +		static_branch_dec(&enetc_has_err050089);
> +		if (!static_key_enabled(&enetc_has_err050089.key))
> +			dev_info(&pdev->dev, "Disabled ERR050089 workaround\n");
> +	}
> +
>  	mdio_priv = bus->priv;
>  	iounmap(mdio_priv->hw->port);
>  	pci_release_region(pdev, 0);
> --
> 2.34.1
>

