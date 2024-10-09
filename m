Return-Path: <linux-pci+bounces-14098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7E6997199
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 18:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389C2282AD8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71FE1E491B;
	Wed,  9 Oct 2024 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NLTT7cen"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD35A7AA;
	Wed,  9 Oct 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491227; cv=fail; b=hO00H1tPWvqJOV9sarKOZ1WPLq3g9/3ZHhs2sSpXQCNBAPWv9HCB7R57CbX10zLjs84uBIivCiQ7cNSMEJM1HzyiqCPsFf9Gdgjw+i9O4sCgZMKTLsLbrE4kn5pXyUd1z+GnlfM4WlhS3NZRwV0v8MtNs02Y5eickbY92AxHQ+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491227; c=relaxed/simple;
	bh=pd7gO1DMjdPQsacmLzM+drMlWKyzm8hru26DGm+VeOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tt0VNMRCqh/rzv29kcJZ+7OMJPlHzxphyie71zzbZcbbifUdQHHSfEwID2gIQQdcV3afW0+qeb7pMC7e2WS6SHeRVRSXfkgaWmGUAL2G69DJuMXK2ldu3I4IYyRgmBwAHxVXRyX4nuJPejM9Luy3xDZ1MTxJymFwYfhW09HnCyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NLTT7cen; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWcK5/WxifyzSpSqg9jGVuf0zxZxcm6lNOGXsBO50ibQYy/hXxWQrJWqOM+bCVRw5PjFoFSuOWbt0NPSAQYh+CZau/8bCgo9QOqR7iqUJGax82tqzx6ov5qR8lMaQ6A4b9ejjNzK01xQtOc3kDf15BKstRDNlMoqlKCpeWq8ptXzR/j5+MC85+c3+DEebYeKNA9zJF1jUa1wegQV0bbWCtWq/QMnAx5NP1PB5bEl4jm3bpIQ+TanfInRhdTum/PZWmsQZ6BI/lDjZmOl1CM2+KqbQ5YKXcgFxxB3wj4ev4+wYr4gBnXLHMM/6MRlx01YBJm8FRqc9huDdHVGZEdw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcDfCNvc6PcTkC3VTcF1ubBo51lwj+vwGNUQ50trksU=;
 b=VnGsMCrTQEzTO6F1mpQKs2UBqQtUPviHPOAnnyODTJRQRcwUooskvkkFdUGsLBwGw1ZXKPeGx2PCRIHDqrHJhvfzL9ZpIf8CKZ+J/tmPDvUGxS/XxVMAkgdXvKLJn7EZNhDapFoVndd59BHKqRRSdJ6+qCAtyd3PCgSXawSFGO2X+QcwllhJYA3TuEkE3a01CAgywrtdg2qrL7uqYQKj60gQkEbmBTsD01kmTiQ7VWox83gtfJEB1T4+63C+oZuuabRWpJoZMPD/PDfZ0LbH+RYaJshC/s5BCWIaFFq5X+rFgp3ZCHTPiWvAJ7y2wEaksj+CHUyFQUFEr5OQNeBXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcDfCNvc6PcTkC3VTcF1ubBo51lwj+vwGNUQ50trksU=;
 b=NLTT7cenubd9vweFMFXG5nnAzHnhzRU64K6nPlMDiAIfOqkcYW80NHfQomG8wHkaJEk3AYycuNQvGRRKf2h8UyTiAVHk5MOE0ybQMrusd3ere0jYtSxmYRm3xg2ik2P3J2UEZrtDOEJAEruRHp2u2x6nPQikfx+SjCfgHw5vmpLLu5817yg10yPCMhFXgnUrXRqjCl5rMko2kOpMptWxs2gcOnigzU3aoaXK2r0y0hxrvuqoH8sFrReW5ENv0BmXQHqFKC20vOmdHQULOINTdBXU5I6YZRBzb7IWFQ2P/4mpAXOmCQ4cdmwkD9JFwy3HEXfOUYEw9kHH1xlvd6UsnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10300.eurprd04.prod.outlook.com (2603:10a6:800:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:27:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:27:00 +0000
Date: Wed, 9 Oct 2024 12:26:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 01/11] dt-bindings: net: add compatible string
 for i.MX95 EMDIO
Message-ID: <Zwauy1WYZtHmwmFC@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-2-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10300:EE_
X-MS-Office365-Filtering-Correlation-Id: c35f692b-dd7e-4a6d-b09a-08dce87f336d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FtLHCcKOcyoLHiTH47pITV0TeMJ6YOVUdKmKdZxZC4prrbiXW6jul8UPVOXH?=
 =?us-ascii?Q?7cqV3TmtM+Ov2udqrj0ExlIz0qhnA6SmuPvHUXrJkvl20mcCd+HvFmv8k+BZ?=
 =?us-ascii?Q?puYQou33Yuhpk0lk34UhRLTewWtz7lPxq7jjeGETXkIEFbVCqTtegoN/1d38?=
 =?us-ascii?Q?qvV7DOYO0aDXh+1yEp5mdn9PQp/jgVn9vDCa0tVI3DQZMrjTcDpXX89y8+ku?=
 =?us-ascii?Q?kfhX4Xglk7zdELZDD+UbY1jbd1j8BvxWSCVWJcEOG6738XaM2SQeOt9JXquW?=
 =?us-ascii?Q?7mc56XpMM1Q0cD9LcHJFivsRzlJ4Q9+64iI543NcgGkfyRjB9bgvjVWRxDn7?=
 =?us-ascii?Q?Nv1pHZe8OgOtrhgvCKLzGWESmIQz9WKEoD55BQUMSS/YLzeutXNcxFDZKjQB?=
 =?us-ascii?Q?IA7xQRL0KL/yOKVpriTS636Zp5+HcMQOBHhj6tKRrpfjAzWv7oxTpr5b7CGN?=
 =?us-ascii?Q?YyAeLVZO1W2tkH5NpZh1YjRBFM8d8+7F9QAjbE54LJXyvUPfyCGYY10CDpCy?=
 =?us-ascii?Q?e8TNQtQaAa26W0MJQ93nQmSWSD6kxqob7jXAaBaiBA7QjmH4jjzQ3gjlWGow?=
 =?us-ascii?Q?V2pdiIA5eAvPNBMe7QrO5i+7VJvubr08B1rGHL83Yz/TfHyR4u5Y4Q07LAwE?=
 =?us-ascii?Q?U0OdIiIBkZk9+ecXIISN9IpZJf3c2SV66clo6o8c5Q6nubpGx36AerQo1fbF?=
 =?us-ascii?Q?2VhJJDGD3wCux3HOjmPnp6sFp087MOHXWQ5bs978JiV5BJ93NLsrVpel7qsj?=
 =?us-ascii?Q?T4SmoV5/KuYvC3nUEgH3xPd+v6Uj6w+PE3lB8xx8M0Sn4JvlWqxpOu/Gq+VT?=
 =?us-ascii?Q?xM1uv1imNtuzxrvmBNgVbf6YLC0kLSmEeYvm3ZAL6wJniSdq5nKYrDQJ2BV6?=
 =?us-ascii?Q?tpZB9kGOk6+zlLT/QmLn1s+l1SSESf/PpfkXBXCxNWXkT3QIXG8Y+UIcFJFn?=
 =?us-ascii?Q?/Ia8COGQP7hhTIuT3SQRz+P3wTtFGxo+DKvUIxQ9RqJnc6/RmSYIyj0h3+pS?=
 =?us-ascii?Q?TwUOIfmhfssLjvub7D4ZYbgQgVb2ku6v/psJRxMX2zJGg8GN0enlKVvjoPoT?=
 =?us-ascii?Q?tbwy45z6+ZwSdqNw+n9YTeAboTqMkZLatyt6VWeb8q4bA96vHf5RhF1SCv/h?=
 =?us-ascii?Q?2Yk5KLbZBA1IPVZnreYhC3CYllx1wXV7pJnkYO4a9iJ4m8HVPSzY7oNtcwnw?=
 =?us-ascii?Q?sX1ba9b1Fa/VpapvWqMK5FDuLhORX+B0OdYaVJorz+x3QzQIoa4TGWTCcnmB?=
 =?us-ascii?Q?4vh2HmoGsBdJamCjTfEiTlb+OEIzv0i2LODs2+zm8nVcV+x98PJw9/Fpj6F9?=
 =?us-ascii?Q?wPNtA0i9d0aIG3Pl/QwOmXvGn8xz99NRmqIlZRmlAAGC6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YGT1JUHp6MczKOYAJo+Fr71H+9QwHp7Mcqb54JTckgFrEMJEBLd2tKEUXF+?=
 =?us-ascii?Q?8yPIT2Ifm6+ttxAQEWCwUrNlMiB+ZyF6xYjXca1zi/KtDOGAG5iwF8+G3Pys?=
 =?us-ascii?Q?H5BgSB2RKxTH1d4Pcn7jo8x0UJozubwhcQ6NMnHLEsTNxfxEpcV1xxiksIV5?=
 =?us-ascii?Q?cf/YoUxvtXf6eMJuuEM+OybOL7S79+Ij4tEb7d05/Td2wSdYR8OHEf/bJEGP?=
 =?us-ascii?Q?vHKJRHhLEuh/CgDRlvI74Tjj84vauUIvV5xs+piyGLV5xctb1i+DeU0gECl3?=
 =?us-ascii?Q?7eTXk5j3xnQD5Yia8rgfAokkwSj8keYvo1iRlSSViNNt+GFCuuSt6XMeuDqU?=
 =?us-ascii?Q?g3T2Bo1eMyfPAvFOY0ue6IP+rocojsNbfRejRYigyxNNWy6LFlamgmT9PTnC?=
 =?us-ascii?Q?omXKmCfHsBFxEtbapbwYghH8833xYNJrrU0yyoIdKLdh1oOUhZP4r3RAQOLq?=
 =?us-ascii?Q?yVuLEKQQK9YHfhOF/+IScykWpWcUR0arr308xMAAGpAgRXGWxuiZeVyKXQfB?=
 =?us-ascii?Q?T81lymTBtW8ytjFg4aHOhTc6zYZUaitDz2SvwqKx16BJaT3cKIs0n9oNM+04?=
 =?us-ascii?Q?SSE0BR3Gv3QGgb1bCdZscbpKU6wJTGy9VQP3D82iyfDek5OxlvGj/3NB8RAR?=
 =?us-ascii?Q?83Jym+3DG5GadDjVAP/26XB7gLOW/abTdnGslubeHTOETC8MYo/Acq1G5tPz?=
 =?us-ascii?Q?NSzJvF0JiYUyhvR5sFn5j50vkbieQVkZGXqSRbbd3FTog1PZUum5huOb2eEa?=
 =?us-ascii?Q?dfrw8KScwuImYSBNGtKiQnk6uDUeAwBBICfnr2ckfK0ZBZl9Ler4Pm/jhMSL?=
 =?us-ascii?Q?Sh8ozBOdbnBJwvTCMXGKufh6ia9fPQEJNo2zGvRzEMhxAlwp0xbmyV4Q0UN3?=
 =?us-ascii?Q?SAOoKQrp6Ei9nXSwrwtNA1KxReyHoK0sg+8BRMTBPCpyPJXJ3x5BoZHZ1STE?=
 =?us-ascii?Q?F4Ade4z6avlytX3bWq0vyE0LHSiG7mYrXFd+eKI8RSLkJdDJYMO8GV8Q2NZo?=
 =?us-ascii?Q?VzRA30F6h3g8my9FFES756uD+Tz6td8KSM5wHQu2X+NhpeaDJPynCrkDlvAF?=
 =?us-ascii?Q?bB/lHxfJQKWF1bocUrpzPA43CkHdO2m2EVF1HYyN2oxF0BfpjG4VE7yBicue?=
 =?us-ascii?Q?c7Nj0sjKQFjmWFqsvKFIGDE+uQWd/D4GvVFiMvid2V/ZWivxRMD1a5FNSpf9?=
 =?us-ascii?Q?ilHeEbOoZCaKLexOqur/6u1omlqhbWkOHQBU0gGq6OxTl7fgFjXjuky2A+0D?=
 =?us-ascii?Q?mWYINGnmmC0Au6dYogkaw8irYpoPhYS/1WLc1ueS0nX+nGv7xoHqo1woqdNO?=
 =?us-ascii?Q?3NClPXugp3isbVWP88n73qYU7UZT68DRm1rkzmtX9yj9SzcTG4qKc/tUO1Zz?=
 =?us-ascii?Q?Kv2RSVVPX2b4sgn5eu18/FjNLWCrh6wRV9gJNJ2KmwVV9uDA1C6syB2D/lQK?=
 =?us-ascii?Q?W4n3oPnuBfJwtPk488/SWvE9jnVANxsUSldouEL9wtj2NZkZQ40OQ+y/ME63?=
 =?us-ascii?Q?0pVOEIOe4yAMIizc1eP4C/scaxf6zxriqDxqeglkwzPbpqvRVGO5CCjNJ5qW?=
 =?us-ascii?Q?IHsrFaYVpVxda/A9BbY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35f692b-dd7e-4a6d-b09a-08dce87f336d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:27:00.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqG0wM4vdPraxcX3uabx6Y9NzYAdRpBALphO1nIftUr976I8vOt3E8dGD6uac+wbU9YLydHLd0liMV+CE5y/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10300

On Wed, Oct 09, 2024 at 05:51:06PM +0800, Wei Fang wrote:
> The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 EMDIO.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../devicetree/bindings/net/fsl,enetc-mdio.yaml   | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> index c1dd6aa04321..71f1e32b00dc 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> @@ -20,10 +20,17 @@ maintainers:
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
> +      - items:
> +          - enum:
> +              - nxp,netc-emdio
> +          - const: pci1131,ee00

why reverse order here. suggested:

oneOf:
  - items:
      - enum:
          - pci1957,ee01
          - pci1131,ee00
      - const: fsl,enetc-mdio
  - items:
      - const: pci1131,ee00

Frank
>
>    reg:
>      maxItems: 1
> --
> 2.34.1
>

