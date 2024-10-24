Return-Path: <linux-pci+bounces-15226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C329AEF0D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6442F1C22832
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA81FF5FD;
	Thu, 24 Oct 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z4JfL9xO"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E51F585D;
	Thu, 24 Oct 2024 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792827; cv=fail; b=nTK87fQ5KVZsXl3FXKh4tokH9gdZ6xLFyiM7CAUUqg/yF23VOiVPASxPSjxOZ/7tn/KezW416gmWw3RI/oRWj7dIkGji7IKUgag5vKnniisfpXg++6j4+HeGTLLeRq5InMe4Ugrye8/32iP9DVhLESTJPEK2YxiHxOuCjGeqMrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792827; c=relaxed/simple;
	bh=Mt82SwexkdkWUWPGRXCGlDhBkwTVp4oZ4KNK7Lwq66U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pLKaomI/kfwrYFYQ9B4OUyKFh5fh47mPKQcs+CHQNIPKgYXacTrRJYb5WtW8y7qb8EQWIgQpZrMrXDBZp+363J3q5n0dqsn64l5V9xWf+Iue1jIyAT4PmS/MTC0QQLP7E6cB6yu+fXusSPN6BPfX5J7S3FGHqKCMdQEqyY/+OeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z4JfL9xO; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bflpPtdAFEBz2EVOpgPUNjVypZldaiCcNtf/aPMqzo2sAsd670HRQ0RZfTlcolN3i94IrC347NK9O4YS3rtXPqr8UkRLD9FNp1utE5+ryXgN2wHrkXVwDJeYHEdA3+6TAGO1bFFFgKd06h4Lm8jE+KYFJPDiC+qXh4ft6M1N7/nwn/f9dNgkyqR7Zkf09UoPGhRTUupTtFjdqpPNJPtN/96Ipjg4GD22SsqCJNA8P4wHHVAlkqnA8lHxXwph8I0gmf1k8IVJxuqjld+gJ3x3iZ8+Vekemhk0p7e82rvfrzKaWbMwQ1FcMlXK3FiClyWsdL4yzAT+1CsxWgj1HK/Vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duIyX4KTvghnFV9u6qmd4T6DizqpODFNdYL+VSdhe2o=;
 b=ZV4EgWf2KipbtHBci88wC9XDoIgTAZy5Aok+ihJvXEc8W4o1Scv0rN1C8hgXtOhlSca8zN1GmlmfjWW2zSMi6HscyM8xiAxg4GKO6At+oA17r5gezyVZNJsvHRKx1GP7arQU+wCrRc5MNRZnWQGuR2Lp/2r4qTAWKn3eiLHJG3BE7M/M8xWP05FEIW8KTr+tlv7C8fHGui2Lwy6erf+BqgLy4hlo5XR1I4BY+0enPxxX4VSIzGJE2dcAii8NbdK/PFi+fwEKDjuZUwQ/X9OmeFkYP6i+Xg7plcgPuy9ofTHKeDRhtjlIbGYscw9lzgpJHeG/5+MReCgpwBeG2pOjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duIyX4KTvghnFV9u6qmd4T6DizqpODFNdYL+VSdhe2o=;
 b=Z4JfL9xOqDzXsvYp54a/bjYl30/hLgU1ILQYvfqBjPr6yT0Wtx88ubrSWtxPbYlzjbT10rlPrewrUCqPiJD0I3qMNyVAYA7OMkd6+qbiOQTmjTrL2DL9F2QpLElWcFV3G5kT6NQNtsgDof9Gk6IUiOpM3tbF8AGZGnBxC0V6qsVPzEe9rDsAFWrZF1lu1r29f2RTBxa6wul8MWH9A4nJZ9KLyoDJk4tjkj+yeHbXXLgSyv5IBFCVQCqQDfxlCqWNh28xARa3EmvSUbY4PDht6YYJynK96t+auj5/9N2nmXGl46dFj7AkzWe8H5aXUOIVGGZu14NunP81tsxe313tVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 18:00:22 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 18:00:21 +0000
Date: Thu, 24 Oct 2024 21:00:18 +0300
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
Subject: Re: [PATCH v5 net-next 09/13] net: enetc: add i.MX95 EMDIO support
Message-ID: <20241024180018.i6bizcc5amrapody@skbuf>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-10-wei.fang@nxp.com>
 <20241024065328.521518-10-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-10-wei.fang@nxp.com>
 <20241024065328.521518-10-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::29) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afc57e5-9c30-4ef5-6cfb-08dcf455ba80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H5efh76oFNkr9MhyEvC9dbhPTuivwgE/zZJr/RD8du414RTasiCiQEqTSP7y?=
 =?us-ascii?Q?M2qYqYnmNHOccxAfuu8pHQxd+Lk/3sGrO9ONWfUOgkrSqk+0fAfunTvWIkyb?=
 =?us-ascii?Q?piSNcOJ5SuCpXih5n59e5GTqiFugFhh1GQu4rEZwYzDQJAAEOBpWiMDMhFIr?=
 =?us-ascii?Q?OTdtxFPAOHTrrjsN2MX3KjTM8CBIQb61sU8fnOuxLHcEyEdLYtzN6BONG85l?=
 =?us-ascii?Q?i2t/9s7fHv1bsXgdwx2SxKDj/1KVBjSmBpQ/T/LQiLVeKrrtGahRRofcDAdC?=
 =?us-ascii?Q?IrwlPZZjoAl2i8jDsoyvJaGH9Vx7ECuYw+Cc+/mSQEIdyDePitHTXMTQ0hlY?=
 =?us-ascii?Q?ibvCrqdKPdskWSKJtUXMu4tUfz312IajSvsnwUdDTizeR3ylKBrdXgRQ8xvv?=
 =?us-ascii?Q?htpkdN25pc2zm0LHrYiRJKureX1WOikF+P7Yk37tcAJvgeXtNfPBYFDdEOO2?=
 =?us-ascii?Q?bvkmIwR+bLmXyuqxN79DcL5KNqfWnzkFW9mKgXRuSrsxKX4pXNGVrAKSRMlQ?=
 =?us-ascii?Q?R2aJalrFjrkecFyifgmnVqvND7KajBojHsH5uhtaMscaVhVjMuMUJA5cdG2S?=
 =?us-ascii?Q?JgjEG6mRLkyuNDxadGWl/94qm1fzzBPHCCeAaZ0Ch5AOYeZC9GGNTxrv3hVr?=
 =?us-ascii?Q?Y0inGOhHewWL1hlnQgnGDJnC9I8JKznzJsfz12Msi3/aIWAG8/JpsQYP2Q+J?=
 =?us-ascii?Q?M5EWo2jsm2IWkiOfdaJ1VKSO0bxVlVW08y1CMRHArPObj6FSxk0LrTTArEZF?=
 =?us-ascii?Q?zjuRAdw5kYbi9oecNIBUO9XmrIU2SbWseMXiiWwCJ8XX+fQWt+s2+LTkWwoo?=
 =?us-ascii?Q?mwFOrYBvxVdWYVswaosUItwywUvrY2R5DnSA6Oup04C/QzybqQCLh0386GrE?=
 =?us-ascii?Q?KzkX34jRY8bjHgy3qY09zyE5j6iSLe41iYWPtOJt7pv0TsJR55WpJ+ovlRyi?=
 =?us-ascii?Q?kOr2Yow8IReXqboH+nrdBk2lhuxGhmw2dgWlA/Zljsx4Pa2hKfgwxt6bouzi?=
 =?us-ascii?Q?oMwDqp7YWpIz6DoXoe1Y2kAtMzcUOFBftF8iPJumllJWx4MnejYQSJmnnDrZ?=
 =?us-ascii?Q?h+Xh8e8PQKSDCuibu438crk0BP68gMGmQWe3NEXPc29hI9SKBTbXzZtMXstt?=
 =?us-ascii?Q?Dvm9FBnyVNrBpUBa/LA/JTfCIIaf523ahpP24N680lMSvgx3VDnOyu0VrsZX?=
 =?us-ascii?Q?L8Z3iFCd/eL0NeqEqSx5b1rRDz10KlXV0pftL4nA5yQdKUZIFC35uhxYw9pj?=
 =?us-ascii?Q?2FsT6MExHXILVuhJJzVuxnB3fSEX8QeCqGFdW/UmL1q0EQRwEPAkbrwGOUFJ?=
 =?us-ascii?Q?am81wCBfkQgT/SpBeOlrh7qr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D6zvSTc7+/vPfUCLfcOld81dcioMPME4DS9Y4znYztGF1FzwtHGVx50hng8N?=
 =?us-ascii?Q?fsT6XIxmhmIg0CAXir3NvWjBBq9QQcagR9Ivu3f+KdVPRRq0P7IPNhHyrlMb?=
 =?us-ascii?Q?ZzdvdjBvzAIi+D/FuZHj6doJL5hSlw9h38gm9gH7+4IKaKPebBGPoiATGzwV?=
 =?us-ascii?Q?A0daQK4bOrM9oR2Rrdwav6XoW5rhIudw80WHp/VCHhgrnssXaI9zipho34IA?=
 =?us-ascii?Q?rAtq3rALZIvo7tOFJGahERnc5zthcUPZnrwQTpw4Y/a/jhfLYOoxSLZplpZL?=
 =?us-ascii?Q?BjRlWWfnZIhBTcZo11FocN0q0wDa+0HY5Oa0CtQRAs7+m8Or7UjXUbnndfsJ?=
 =?us-ascii?Q?7AHUckWNqj1qwcYbJWzKACVsyi9sjcPdHy61H1Y9BkP+J2Zw89RBRu1/qI2q?=
 =?us-ascii?Q?kk3rrfHO/3MTmgytOYZKfI9VOgvaEUzFgH+RBnHPugxpVs9fp5qc4MET0fl4?=
 =?us-ascii?Q?Ski3gI1EAvs7j8KUdQlw+horYCMQcsx6glqm5qVJg4orwg/yc4xw4J7CzZ7r?=
 =?us-ascii?Q?D/5RIFKyqVmAaIxbfkLzd4Ycv/KFQxw17aMWTeGWoboN5Wb6k7osZiHYsRjY?=
 =?us-ascii?Q?87X0O7iOZW+EHsQq+Oj4eVK8T+uAPkXyAontt7tq9uLJ8oNglsUH8H4O5uU7?=
 =?us-ascii?Q?EM62VGLiZOzI0aoTJMYMtwgHsb1+BVozSdxk3FTaxXyQ+VkH2cHM6ewSQ2/U?=
 =?us-ascii?Q?SNSE1Qah+o1Q+Z8IEGcMcmWNtcukYpC2AeyXDNylQ+l8zM9AzgDdPuIoCoyh?=
 =?us-ascii?Q?G7vSvzjk+XWRENuuqTVlQIaWsvBmdTeH+Yamigrn3l8iAi/HBz8wX4csF35W?=
 =?us-ascii?Q?CcyRJ8tBdVPmT4EJYpcI+AQBSqmrQUM4P/Xfxf3E61nk58sXM84JB/w0KXgq?=
 =?us-ascii?Q?rh/tsLTpad6Js/MiKriroGf9ZrzCGuRn1jOc4rrgLAxibL+jG3YD8dAqEzif?=
 =?us-ascii?Q?XvMw0dzhG5TRWI52bYycYXsqK52llANxx1zDeGO+gPTbkYjL98cvIArnnlxc?=
 =?us-ascii?Q?yxribZraHGm8Z5O1cjtYWgIyOzRzDpfNM967xyb5PcXAwtJD/sLwrHr7IRuH?=
 =?us-ascii?Q?AG790eGFCQcAyotO85R8BonQJUnUv6t3HYXyuSIjP0C2EbbH2TN8VtECaeHR?=
 =?us-ascii?Q?f3S900/iYt7M3XwP0EjnEzYbOrqaLxAU5QEhlje+LXLarofgNuyhQEcY8Cun?=
 =?us-ascii?Q?Oop0W4Bh3QbbPqhRaV4CiUVRnwMbdr5Wd9PbG01cboadgpeChJzkPY9wAWL3?=
 =?us-ascii?Q?eksyLi8FJUvDpZaCDA+LDqEeTrozFpbFzIjtiNwBdKhB2qRQMT0JQEF/0Hbe?=
 =?us-ascii?Q?9CgttLW01P1reva/IsznMrsI0OfwGjziCGe+r5R2pvaSP4XGjuwGlwaUGpxM?=
 =?us-ascii?Q?QnbUG6hQCYm15XU3pEnyNaQ88AkatCXXONUucrRsM1MkFJe6q1DxN4nKEbez?=
 =?us-ascii?Q?FzfJx9nFj/oCPTCeZME2g2gw0SobN8If8sBzeccQ5hBwc0RXhnWzBAOtgtTr?=
 =?us-ascii?Q?zPanh4XHCyxIbB/VhHADLOli+EkCI5iwCTB/ms7XZ0cD6XMzCq5Kj96seu2a?=
 =?us-ascii?Q?lgi6mAQDbKZ4ReWhM/LTCueF1F5TamWElRvJEhOn2qGVbPu5zAadR3Rua5SL?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afc57e5-9c30-4ef5-6cfb-08dcf455ba80
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 18:00:21.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIB/kF3oXtsjo7oYmG+C0e7BsFJxrnWfu7lmqrJ8QjKiMl3geFUXlDXb0toS2RIWhmiPkAW8pzptX7k3d2bDAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

On Thu, Oct 24, 2024 at 02:53:24PM +0800, Wei Fang wrote:
> The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
> EMDIO, so add new vendor ID and device ID to pci_device_id table to
> support i.MX95 EMDIO. And the i.MX95 EMDIO has two pins that need to be
> controlled, namely MDC and MDIO.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v5: no changes
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> index 2445e35a764a..9968a1e9b5ef 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> @@ -2,6 +2,7 @@
>  /* Copyright 2019 NXP */
>  #include <linux/fsl/enetc_mdio.h>
>  #include <linux/of_mdio.h>
> +#include <linux/pinctrl/consumer.h>
>  #include "enetc_pf.h"
>  
>  #define ENETC_MDIO_DEV_ID	0xee01
> @@ -71,6 +72,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
>  		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
>  	}
>  
> +	pinctrl_pm_select_default_state(dev);
> +

Not an expert on pinctrl by any means.. but is this needed?
Documentation/driver-api/pin-control.rst says:

| When a device driver is about to probe the device core will automatically
| attempt to issue ``pinctrl_get_select_default()`` on these devices.
| This way driver writers do not need to add any of the boilerplate code
| of the type found below.

The documentation is obsolete, because pinctrl_get_select_default()
doesn't seem to be the current mechanism through which that happens. But
there is a pinctrl_bind_pins() function in really_probe() which looks
like it does that job. So.. is this needed?

Also, pinctrl_pm_select_default_state() seems to be the suspend/resume
(hence _pm_ name) variant of pinctrl_select_default_state(), but this is
called from probe().

>  	err = of_mdiobus_register(bus, dev->of_node);
>  	if (err)
>  		goto err_mdiobus_reg;
> @@ -113,6 +116,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
>  
>  static const struct pci_device_id enetc_pci_mdio_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_NETC_EMDIO) },
>  	{ 0, } /* End of table. */
>  };
>  MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
> -- 
> 2.34.1
>

