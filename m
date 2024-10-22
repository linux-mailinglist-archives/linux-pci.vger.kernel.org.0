Return-Path: <linux-pci+bounces-15022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472859AB39C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 18:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95FEEB23016
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F0D1B5829;
	Tue, 22 Oct 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RChambTM"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9A1B5EA8;
	Tue, 22 Oct 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613629; cv=fail; b=H9S2jCP2gZOMetbomR0PFNcXoX3n1JZEMg+/0gyHSIncR3l6nzaFzvSKk9DZnhgDjqt16mF2NhLUeaWsHo20H8n4y1tAe4onfPbVTRpNSySh9L5+zEvyLO5Nw9IcfFLh0qbF9hkmOjs8ptm88yOZ063jxfYkrkny0NJ6dtSpjSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613629; c=relaxed/simple;
	bh=E8ytaGjIgvyWzTbreQF/JDUVhGckQS9DcS+W8Tm/r6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k4gLtxttGo0oW/n+3H6421z2AcoXYVtpjpAzeV2dSob3LOfCvIJANIAwuRIPeDAsbCNe7ZbngphFR1tayhb4Ecfr/1QoB8oli/M+NwM0pF+u5d9LdXYZQlbOIe8eDeI5zfUqncwrgIoXDbHTWCjZoqOWU5vrR/PjEpno7d8NVu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RChambTM; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDcYp1V9Hih/3ZaLLxElldz/OLcn+xDaoSymWIkIPczCU3iG0Aqgx8msF5mzhEyVgHrQMmqKVZpyyOaa7gsJ8aB3hiahDDlJaAmumBiDw7IGGXapoEjgQxvUsgV/1UrSJgHeXZQcgxWu7r+7SjpTo+fPw696mHiJ9DHAgHbuXosiquutA6tTHxNwD1eizEtMf3rNq+3PT6DPEWLH8omLkEquMJRaMTmdSsCut81at0Cuswt5p3IwlMDhjH0uWlO00PEc36l1APyIOmA9bW0dO6s3G24oIYFl9EUtWXsQHKDOIdLdrksK9PjNatWO0OU7RV6Ljdc60AvOzvFHdEvfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwJTMede1HTyGTBa/DQeNXDHdsQ7lBJrcSqo8M1ItqE=;
 b=fUUCryd5vIBBIyoHJCCHGFSjBazeeqUuZhLuSN1Fep7zboOrVRurb0ZFyZbcovvUAvHCkDGQwHYlglXjbA9O0DmUMFZmV1hQ6xiAQixme15Wm/4NWO1Ncg5N5JRKIG5qK+PGcCz/FYaaEFph11YVLUT64F7izhzYRqRwrKLHGRp5C/xmZtk2i77baeyPQCvhiam3cgyjjgl12L4sR4c1W1ZTvhk6yzoWOb7reYNAbZVYYveDsFSafpBqpfFlpirJVyuqkY16b5zPVWB2mUeBudOI9EWhEBaFcSaYtNHeLKdk5BuAvkL45MPaFhJe2r/o+nwsx/H+JI5VYFJSllCg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwJTMede1HTyGTBa/DQeNXDHdsQ7lBJrcSqo8M1ItqE=;
 b=RChambTMdl4b8z4dk/RrZ+JUYLcbNCFGEhFCZEEFQXzyW8iuJMpd/ijb7ClLGaHaOXOkoy1jdpAJUHz4fib6zi4a84VX2pih1qFtreqldMq4Dl4RtSJ59+U2N3OrtV0LNlm0c6fGhmhej/O5owH8QOGTwsd7aOlmhCPoW3oRK3wEOW0bbhhP4UkS7SJz7PPjpsI2EuZDONTmukzAUb4amvePEnbJLNsrUhZktpJJGIJ3PZmqFQ8Ew3F7Jh2O9g0X5JLbd5SJtBNFTSCa9hriY8VlfpxtgXJABtkxKMWWB0ekRwwRTM7l94ToqR+zEkol6bElzOfvBAizm8ZfJz+jmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7581.eurprd04.prod.outlook.com (2603:10a6:102:f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 16:13:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 16:13:44 +0000
Date: Tue, 22 Oct 2024 12:13:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v4 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Message-ID: <ZxfPL/9+U6L9HoOO@lizhi-Precision-Tower-5810>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022055223.382277-3-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa4f936-d96d-4447-5774-08dcf2b48076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p94YIciIl+Zi8HwW/EYCh8469YB0fPAmQJ6xpnSx4UxHiYahA72tuPA9ecgw?=
 =?us-ascii?Q?zsx5H96uSxbMmdxB9ul/ymai8vs1UyB1tdGKEzQTVvlcMsg/9B7uKXu9s6Yt?=
 =?us-ascii?Q?KKbMOuAJsd+IO842AK9qAhwzhIkN12rouA7wAkDhI8TG8mGPxDeZITLEJrtp?=
 =?us-ascii?Q?8Ibm3oLl5vCEQ8dLzvH+NZp2EiNEMazAnGnhQjDyOjPbwRmRuVxl1TC8T3I5?=
 =?us-ascii?Q?6mlaEXXS24x6LlRsyLkynHvnAvsrps0H2GI/3MXnC83w2zz/Ba1dh73wXSYf?=
 =?us-ascii?Q?ueYQD4WqHhq+mIL4Pa+hSMNCBz+lRReVwRJhMI0jkqNqDDDuCk9AmB5pd2xa?=
 =?us-ascii?Q?MZD9wo7BNV/csiugroDtqEbIH4Nl4AVarme0OKTraKN33h+vPSm0QeSK15DW?=
 =?us-ascii?Q?m026iS4W2h3acln/7fxlSQZ3OTQpg3wXijW/41lsQC/K5tzy6epN9FYVPDcV?=
 =?us-ascii?Q?mBTJUnAy64WNE4CGo/kKyB1ocYQcUhM38AK27YjtPPou/xFqqIdSUhBGIBCJ?=
 =?us-ascii?Q?75ZeTlOuxMNmWAcZcr4dscm82m4tSe053iXWxWRrzBns1meeWhQYbnwMDl/W?=
 =?us-ascii?Q?APYXFi51U6IyFVwgPYV10RKWo9H/LA/9QHS8m9bKplg7zBxcPTas1vrqf1Z4?=
 =?us-ascii?Q?bkyMxQHmx1ewk0VbWc6U2MvDT7a1Dj3SXicSBY4YODR4Cd03hKrnZcjbWPgJ?=
 =?us-ascii?Q?nmt4u+PIlK/wddGixIsRPOR4bj5h2MW9uuEVs4NuMRQastK9SM+k5BghLVVy?=
 =?us-ascii?Q?n7jETedKCsn21HfMNDBiD5Xvk67k30M3CyDBZgCTRQajLSUMD4hw3c3gSWOf?=
 =?us-ascii?Q?fBzoBhSN75xzIZU7b3wL/8AYVpYkE/7/BZz3VPk5/Ybxs3dQy1eX9xP0i1LV?=
 =?us-ascii?Q?zjR58uvTTlRtYUSbJLaSaBiJ4oAUczJcpoan4nQ9kCksswXbq9W4EkteUQdi?=
 =?us-ascii?Q?TKkzXsqJxVmcfBv5JjghwXGXxVaAHPT6E7lap8Rls6L4j9GZ0Tl6zrzIy4p5?=
 =?us-ascii?Q?M86yjLBd0+5KbpzuIeW3eoNCPgxfctl1Dku8yI7sjNKuoSP2TNm0mVH6E5XI?=
 =?us-ascii?Q?POy4pi/rBbfPgAvwzzoSbW8iZ0B0+P7zdVzzdTcAaG2ewJjm5I+Y6ac+lANe?=
 =?us-ascii?Q?Tit2ptBE1LyPvAz36UoJUHI6VCtrsGv/RaolSGr+M6ds282jfcV+hsIUnls4?=
 =?us-ascii?Q?N8Nj818nRUwCfm+qzIJtnI86obBrePSBFw9FKCF/x7qMUSsp8CxPJSop1cvp?=
 =?us-ascii?Q?4JxH2enkS/bM63LJHMCJ0/LMXKn8MSa+9dyextzF0Q/Ts9j4pSZCwv/DT0PS?=
 =?us-ascii?Q?gO9nMvRIpI6gFNChMHqKgxC9I8+rO7FcrrtzkqUkoMbrj6j9ZRVIrqxZ3R2j?=
 =?us-ascii?Q?zvoUUro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kqf+MDNSZ2oFKZm5e7MVCviulBWt88q3aFxC8oZjEci58a+tdb5dACLjinAu?=
 =?us-ascii?Q?oKqaLG5zzySwEBLqqw+aDpRYd6Gxpdylq73I5mhA0Mk1Lckz91B3p8Zx049k?=
 =?us-ascii?Q?7bIcYK5BFerSQQ2Rn0wi/VGCSIgHn9Qc20lEQYuipVuXFBDCQqbLpj2KWpIv?=
 =?us-ascii?Q?pPRLIys6piGRqElvwvk1mnhb0c6qeFFMENqucMCzigpzxVl+znFFSDAx4JyG?=
 =?us-ascii?Q?z8APQMvIN1KLokCCR4u7fabpYWCJE8ev8QwsLJUkksgRKIFwWPuFwLPYo2te?=
 =?us-ascii?Q?lt/ITLymX85OdNr28IcbSZuUIcBvtg21rthbNw/djTETl2zDZRsogRdpJE2C?=
 =?us-ascii?Q?Muf08Aomrqf5rOOyhxJ8gp3fDT8QEMxqGVadFcedw/WF4jVApwuDPIhBF228?=
 =?us-ascii?Q?kET6seRr5sJZVhQQGBfvVVGh3YG2ra9KaaVcXn82L7nzkL4pNV4AFJsXwPcB?=
 =?us-ascii?Q?v6qSZBPGfhLyxZMf8b1ACntUzRuFedYdAbzjoGqx946O+BpKuER+qdwh86IT?=
 =?us-ascii?Q?PAfX9vsGyyBJpZSzc7n5ZrVIyzwbYbWu1yh1hangxv8+iqZfwTHL5vDzq1qI?=
 =?us-ascii?Q?c0fG7SVe+yiYiux/R76koIhaGkTByzCsNJh7wLPGTUTt0fDPBrnG2fbPw0Sa?=
 =?us-ascii?Q?zxNJiScorhkIUcwkIKp2M5DM2yTDlY5+ZQfQ4xc0+QK0ZzZuglj2ZKOtSYLZ?=
 =?us-ascii?Q?jNTMogGfhqo9+jpoJAj/a5D+7rZFjKw6PMR9H6jiRL62BLs2t7GZdf9/sPP8?=
 =?us-ascii?Q?SFJYYWQM/iOytZsGgaFRcQ/SaumteotJtxhObZS8CsjczxtN8wO3xajJEZPf?=
 =?us-ascii?Q?HXbOWZtqTZq78eD//svcp9PyH/JGbCPgzFyj+VLCESnXduG5iEOZJrvAp7mg?=
 =?us-ascii?Q?W+9QBBVvqRdAKT3lWwCW45zgrdj/gzqkFA9AT80DaZdkiF6eqtH901pJ8nz8?=
 =?us-ascii?Q?2jWS7NcjeW6tLucmSaApdg8S4FeWdS6EuL2jHoZetPBjnqgtipwfIIg7cq+Q?=
 =?us-ascii?Q?t7Jyq9NKitxqNkF7kuGVGG0rcQZHFFcIW0A+GoDCWz66yZJgd+2VJcmf2A+W?=
 =?us-ascii?Q?QrM+iFKBiqmMdi95r/fyrb3lq9/z8sh3NdWAXPR9AJICZdrnlb7189RANy3p?=
 =?us-ascii?Q?/N0eEnHv3axi8R+MwQZnKcq35oKvTlLiYep8AIHBvtiY2xhetjhAJ7C8RgEe?=
 =?us-ascii?Q?yigOOmhuoyBIJVzGKiZVqmM8KMNbGniTrdTzgvFvTysZN/K4vThR+nmvNDkH?=
 =?us-ascii?Q?txh8R0fpCc3tWFeQpz6cWy82dVDGdAkR0XbLPxJCXmm1jDcgTi/c/L5FbDps?=
 =?us-ascii?Q?WxCq9oydEJ7zBham0UNpMMDkcdownmzKLgMYYLyRO+6siLGhfMDrjhN/EpFl?=
 =?us-ascii?Q?PtZezTL5S2dYWbhWJSxNnpzJo7TwzNUO0vmQwndapAtfHEq360clJsnsJLaa?=
 =?us-ascii?Q?R3sUvUKicNIzLNI/KjzIu+66AuYXi9smyXoFMJoVcc761uiSW/6wpvF+3qyG?=
 =?us-ascii?Q?26Hq1KLUSZfdNrjs0x3zQkn6kSXTCxtD+YhAW88XGq9FIdvsS+FKMV465p9E?=
 =?us-ascii?Q?XgZe89XoncNWDAggIE5zgbk1GzLYmj3kGF8S5J+o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa4f936-d96d-4447-5774-08dcf2b48076
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 16:13:44.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrGoDJYokh0fFJoiwKAtMZr6r224t+kkJAQo+OrSk0vF7PYfBguxEY50pbJMc4RG+ztYwAP4FqFaMklmqpGLjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7581

On Tue, Oct 22, 2024 at 01:52:12PM +0800, Wei Fang wrote:
> The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> or RMII reference clock.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2: Remove "nxp,imx95-enetc" compatible string.
> v3:
> 1. Add restriction to "clcoks" and "clock-names" properties and rename
> the clock, also remove the items from these two properties.
> 2. Remove unnecessary items for "pci1131,e101" compatible string.
> v4: Move clocks and clock-names to top level.
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml    | 33 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> index e152c93998fe..7a4d9c53f8aa 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -20,14 +20,23 @@ maintainers:
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
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1
> +
>    mdio:
>      $ref: mdio.yaml
>      unevaluatedProperties: false
> @@ -40,6 +49,24 @@ required:
>  allOf:
>    - $ref: /schemas/pci/pci-device.yaml
>    - $ref: ethernet-controller.yaml
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - pci1131,e101
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +          description: MAC transmit/receiver reference clock

items:
  - description: MAC transmit/receiver reference clock

> +
> +        clock-names:
> +          const: ref

items:
  - const: ref

Frank

> +    else:
> +      properties:
> +        clocks: false
> +        clock-names: false
>
>  unevaluatedProperties: false
>
> --
> 2.34.1
>

