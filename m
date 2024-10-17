Return-Path: <linux-pci+bounces-14817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF589A299A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06BF1B2BD3E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77221DF75E;
	Thu, 17 Oct 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="blN2OE7m"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2050.outbound.protection.outlook.com [40.107.103.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC761DF98D;
	Thu, 17 Oct 2024 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183343; cv=fail; b=Zz59M0Yf4Xk8zKYiecqXi2/obt3ctmcMlHW/AVVgrsMD29V2pqEoxHwVwMMM4BKuTx8vZwcPaQJ4ep43C+uWnRrBr0CToT+nW5/miUZXsgWQyERCe//GdMu8JUlMAk5m1PIMOlkM49LRdBOG3C800rlhNOpS2PWDVUGrLwXqPXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183343; c=relaxed/simple;
	bh=eWIjtcgYG/WuE+1inWYnJ9lu2+P5DKUrBt7CRTfqlGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=srQAOfsPzi4F8LxtleNgQ9OxJ7h44KQoM4R/TXVcPwaxp2elgjJ0+aT43IbdRTOpEVyMSSbBJbRvqsCMmYy7Djdf9FJVvVsCjI/sQxixe0LkC1ZqtCvLlZXoHAkFkjz9TFe05mhte/xEVkzG4/WGo8jwKGcn9wDwrECjl1GKOJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=blN2OE7m; arc=fail smtp.client-ip=40.107.103.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+MdXNMKNInKFTmsF/+7NWAkqGuoFuOrhq4HvnvsTFRJ7ekQjAyzy6C/DIHhs4uEfT0AnNl/MZ4ZWXmJdowAEPB8/ZGjeV2jQ8WkOsyv2rqiVFyTw/0Ey1kMjwQfSyMYZ2K9t3RvkhQUl5ZbKqqlNhPt9FNyLY6VrLv3XRg6qE4JLyIurw+iik05SLkXMQ9VEbUI9T4TVf/I4OJwO1HQPcLS3HD96jtQYndYdQIYsPgdqQ79pWR1mcwdDJLWbqVeTv5kp8DEwYn4HSXmR59EW1ruq2KGPp7FDG6jHoYGyLEXWSJsAJbmXTs+f0OcB0kgOk2fBgkoeR8tpWiCycoVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhVLvvbapYlMIbQT8fjyJF8pN4YPLNBOx//sVqHVS88=;
 b=VV4oTmhorHJHvAZ/FaoT4/lCx7i7gqe2M1YlxQglg46N+9rqwV12X7fJfhvNSByZqSxmhNNR9+WieGsFmemw8RT1dy+CYHVV5lMVAh5nd5sg5C43L/h5Bpl4XHYgkRykd4PCcavG/UNSs38M5GzPkYSpqPvMo9JZvClo0Rwf1qa++GmqnQTOLguoPbjvrn5U2O24a9OZ5Xnxf0c9kcM4aMfEjlPxyAUJPF02BfsyFTb4mB7aXP78RFh0v0U1MZfltYRPyAa14tlFM0sAvWgY4QWpvyq0Enni+SRcMs/vDckdrex1+BccWHXvG9vvHRe/CE8j8gi0mqQr9AQtoF3KpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhVLvvbapYlMIbQT8fjyJF8pN4YPLNBOx//sVqHVS88=;
 b=blN2OE7mAiVDUL/GLWmG7OBXeZOl8fQu3osGXrUX+2sGLefritHQp4tTg+FXhkNv6f9E/j+Oyy3hBECfylvVUHonlRVQO7evX4jNzJMP91T32a6wFx0eB0wmuFXJN8EEwgvCqo8D/SQZp9FzTfuAcjzwGX6lF6z0QJmEwVE0BZeV4EXDIbBj5gMddORmK+wKq0ymVJWklEhUakOPkd9n/091ik/K+PzCsPCagbE4HiuQmAoTCT2j186hUiqYV+CGzcCXlwlIlw8bjbyb0397Wi3cHL7EFSAjB38tcMzj4/mf9GwMRTf/591gwGjKwE25prRrpyw84FYsW7IsDD1HsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9056.eurprd04.prod.outlook.com (2603:10a6:150:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:42:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:42:13 +0000
Date: Thu, 17 Oct 2024 12:42:03 -0400
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
Subject: Re: [PATCH v3 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Message-ID: <ZxE+W7pHypGN7KYl@lizhi-Precision-Tower-5810>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-11-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017074637.1265584-11-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: b6413419-7864-4c4b-1363-08dceecaa726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tKmEn/7eIOyjJ6ABPRSWSIbPXx+w1lbDWgTw8Pfd5/OwmRcIjKH780RnNKpY?=
 =?us-ascii?Q?0xNk0kJafgiKom28hAsDOlyOalNRtk6DPN6sC9lEQaJQ76r1nvImje1sI5Bv?=
 =?us-ascii?Q?RJ0jSebD0iEhEDjLajcGy9KU4CbCHxEELGrOL9vIh3wuApW6qD1uL03nc4NB?=
 =?us-ascii?Q?uweF4Bgbi/+iPX2qa/CcM4uQq/byb0DXbeEC8uw0S2po0rif1ZnT5Si1ybpf?=
 =?us-ascii?Q?jcX02KBOs2FexmIbyl/wQF4pNVxJdh3LIg8kc/Fsf6zZqrAk70kBYFiw3xnV?=
 =?us-ascii?Q?3KZmz9YowKmtzkBt8RNLIIrMfX27RfpiGe2uCXi+ZP9JcmOeDZSs9vbZxIwC?=
 =?us-ascii?Q?gR4NTfeHmEpGmU6PxD1UjH+Oj9wGT0xT1gJ1nCKZJwj8zRTxmwqFia6Qx8ck?=
 =?us-ascii?Q?0tJ42JPsH72JJoLCoB54PT4tlrl6JMuqj3xNqDAZUihjopODI7uLJhnlaqlY?=
 =?us-ascii?Q?OmfgtbjkTGQXrBuIALlCLEjaFR+vOp6Q2WUfcdbm4Kr/nB5qV3uIQkbaSCfv?=
 =?us-ascii?Q?K89Y0RvffERlFATivBOToeNoOfU0RewnhKRZ2/Nw1uEGMjMbKUD3l9dHxJ8p?=
 =?us-ascii?Q?PU8bf6IL3K2yg8AeioYGcUPgVdxfjhDmP+oiB+LjHVarba2edvxovv9Np3c/?=
 =?us-ascii?Q?aD7bkzimqO+9zNAiOwb7O0XeR0kF1mU48MTivjkDicOkMbKQN+OvNDDxMkKr?=
 =?us-ascii?Q?K//pQAuZASKiK5X4FRaI7DSlAlLp2eOf/zpXCmXUF4D0KH7KXidRQCg1pzuQ?=
 =?us-ascii?Q?PMUyhG4cRatZ2ca4SoXqwPxMQ5h2BE6olXPMXqreOB27n9UcQ2DLsqYZmWZr?=
 =?us-ascii?Q?sKx4paa27v/vQDR1slhi6h4hh7BbTrtukbbWQ0RFOQFPFDix+MiuH7gDMdWH?=
 =?us-ascii?Q?7pf+MFi4QoS8aZi7a2u3BJmenG3m37cA6Nghl9P8uoO5/jJKfCdvYMftG/tS?=
 =?us-ascii?Q?REWzvA7/CpNEtY3q6eoblfy1Rqg6Msb23fWjqVpu30qYqjAc5kVajj8wuLJG?=
 =?us-ascii?Q?iQSsbCcYQcZ1XWlR4ScUszLRI26inDQ0mZQI5/6fg8lxKISX8i78ZvoB7ijO?=
 =?us-ascii?Q?QW47IpY/tZGSrf01b+3N7a2Hvy6eIU4QL1N5az6i8BQkWrCe/QCzVeFafQlJ?=
 =?us-ascii?Q?O9RrDiJXdPjTeIr2RcN9oZxGZKymUl+xYmt48S6kRq2e/3+HceLdCVjgkR9M?=
 =?us-ascii?Q?NxdUCUyLskL2mgPT0jlpfoN96liWwiY2UEx86EC/kQCTgcQREYbA7xqz/Wj6?=
 =?us-ascii?Q?erynX48SvteFI2zWGRY03ZZq/vlApMimQqhtqs5TLURIFCUfg6rixFurNlsb?=
 =?us-ascii?Q?gh1P4PzzHqzKtNk9wJL3Kvs0xQ6wq3xCRiRSbArLlSMA7e5/Cng/bMFUxaoH?=
 =?us-ascii?Q?SCop8qg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?318TRHCLS6ZfFwFTGxf/ztbMQmpLqA5Qe7c+vPwNICYvXAHbSe1761N483ea?=
 =?us-ascii?Q?P8euiqYb8//deY95HwYK8v0rClgXevrT6JPHijoUvQKu2rDWwZD9ShagqFWZ?=
 =?us-ascii?Q?GXB4EOqpNhEMr+dyzRFiUuzPH/RyBQfnEcJfvRy8MH2HXsHHab+kWCNNUH0i?=
 =?us-ascii?Q?BhYoP8NyAdKlb0tooX6oSgZUp3yD0ZzaWCwPlhp1kjLm+w/nSzBNZGon5Q54?=
 =?us-ascii?Q?6TLOagWgqoYmtMnuvgwZB1lPJCfNwFQ5SUxqVpUlcTeWMX6PZbrlgOngJrO+?=
 =?us-ascii?Q?naUJ9n/qLjKYBKK+3FeX/QX50DaS6b2A278GpqSHwTCXnVqgLP9Mof/MVtvV?=
 =?us-ascii?Q?d2gOlRAcYkTK0kXuLEwDLOkRHJYFdJIiaNgYZoEnNaxTZiFtutgIqb6lF4vO?=
 =?us-ascii?Q?YhSJwUlFYxoyGp2o3VYQWevb8Q17o3aTDYrdNQv1swuSM1qmJstMsiD+1EOo?=
 =?us-ascii?Q?zme7xIb2OaGA5urpFsGS1NFWd/wC/5NdP1s4JVh8uLCag3zQoFd+UDVV81Kw?=
 =?us-ascii?Q?wkdBwiVeaV4aa6WdWcvipf3A4QkFBvjs898K/W6wEZwDmrTVXNMOWBMkNM+P?=
 =?us-ascii?Q?sHLs7AkcVd7oa3gyQFfuF+AmOWw3Yv19mEWQDr+Npxqm587jXSTE0E5sCLoR?=
 =?us-ascii?Q?OoEx+hwEqgP6jyBeYnGMu/Qdh5qrHBL+UXwU//Th2GbpBIqW2zgQ3g/ArKwy?=
 =?us-ascii?Q?Vi4r1ZCEfS9qI2dggbAU1P+vZIaqxNoIhGg58uRfBTjNZq16+6ZROOB//tR5?=
 =?us-ascii?Q?ne6KLzxiJ1EBhuAljjxbEAcNJ7Qg0e5Hodc5zZI76bEq3/Up+jYLW81iX+DQ?=
 =?us-ascii?Q?/sMKkgil8BxSsfiFmSA8AB0FZU+SFLAyo3lRtPQ/7e8K3RN4+5GPXH5f5vyx?=
 =?us-ascii?Q?4b5lJrXbsn7Olj5SGrLmAXHR22mtNKFpUFDG/OJUC2X+f1YVWwg3F6Dl7hfJ?=
 =?us-ascii?Q?Q5AzmYPyszww73KgQiBnui2NAG/0Rn0VXF7z95bkRRl5rd5bNofwIfiBRbQQ?=
 =?us-ascii?Q?k2b1q7oZQhz+3yDKBbZP/h9NLIjquSRQqm9yKqBjTTta84X0CkhvvsJ2NKHF?=
 =?us-ascii?Q?iolvRk+h9qv5T2HR2gVUjlYfuzG5x/i/L+mmvJWtygB4SBTxG8HVGH7BW4gU?=
 =?us-ascii?Q?798ZEjb0OVdr+MlsSmvourey55VpeZqFJYVV5s2nsG0Z2V9t4Xb3Mu5nsO8/?=
 =?us-ascii?Q?JvnvExeZHO5wLkkHxgzrxO8sYTvTIA1VEK7Ns9kBkoHf3iGQ1sNxcFIrEDZS?=
 =?us-ascii?Q?vv0K0HBsJf2EwaL8BeLeGfXO4MbGNY7x5/U4SBrl45lsZOYwpmxJLkjMTL0h?=
 =?us-ascii?Q?c9fpLk4r6WFBE1tIxR2Odj2FaeG4+VR+iRszqWj/SRJStCoLvcW01TPfc8JW?=
 =?us-ascii?Q?JSqt5Hq+uaCsg8bZvnhmh502SmAad3wPqx5nRY5faJb/2svgGKE2l3nS3Vdc?=
 =?us-ascii?Q?Gl/+sLVLWQr3VNRCcGpVKwrnaJt8PDWvK+NU8pWSKmM9HN4RulLQRxXKuCNm?=
 =?us-ascii?Q?GSlffY0+kv+ZrPqwyClXBSUweHYl1H/k+uIxxD+UyHikNXpFM77vPDiXgVVz?=
 =?us-ascii?Q?jlSgmv28tl/DBppQhSmNzsBVvgec+cka5LUwKOzH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6413419-7864-4c4b-1363-08dceecaa726
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:42:13.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdZmSvdZjwHCSWeSH6feErWQ1zWdCbamMDnm/M48pXFTxyjYiAmXjzdK6HXI42XpM3bRyDPAa9/Lj/e2SW4ObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9056

On Thu, Oct 17, 2024 at 03:46:34PM +0800, Wei Fang wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
> enetc_alloc_msix() so that the code is more concise and readable. In
> addition, slightly different from before, the cleanup helper function
> is used to manage dynamically allocated memory resources.
>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v2 changes:
> This patch is separated from v1 patch 9 ("net: enetc: optimize the
> allocation of tx_bdr"). Separate enetc_int_vector_init() from the
> original patch. In addition, add new help function
> enetc_int_vector_destroy().
> v3 changes:
> 1. Add the description of cleanup helper function used
> enetc_int_vector_init() to the commit message.
> 2. Fix the 'err' uninitialized issue when enetc_int_vector_init()
> returns error.
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 172 ++++++++++---------
>  1 file changed, 87 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 032d8eadd003..bd725561b8a2 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2965,6 +2965,87 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
>  }
>  EXPORT_SYMBOL_GPL(enetc_ioctl);
>
> +static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
> +				 int v_tx_rings)
> +{
> +	struct enetc_int_vector *v __free(kfree);
> +	struct enetc_bdr *bdr;
> +	int j, err;
> +
> +	v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
> +	if (!v)
> +		return -ENOMEM;
> +
> +	bdr = &v->rx_ring;
> +	bdr->index = i;
> +	bdr->ndev = priv->ndev;
> +	bdr->dev = priv->dev;
> +	bdr->bd_count = priv->rx_bd_count;
> +	bdr->buffer_offset = ENETC_RXB_PAD;
> +	priv->rx_ring[i] = bdr;
> +
> +	err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
> +	if (err)
> +		return err;
> +
> +	err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
> +					 MEM_TYPE_PAGE_SHARED, NULL);
> +	if (err) {
> +		xdp_rxq_info_unreg(&bdr->xdp.rxq);
> +		return err;
> +	}
> +
> +	/* init defaults for adaptive IC */
> +	if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
> +		v->rx_ictt = 0x1;
> +		v->rx_dim_en = true;
> +	}
> +
> +	INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
> +	netif_napi_add(priv->ndev, &v->napi, enetc_poll);
> +	v->count_tx_rings = v_tx_rings;
> +
> +	for (j = 0; j < v_tx_rings; j++) {
> +		int idx;
> +
> +		/* default tx ring mapping policy */
> +		idx = priv->bdr_int_num * j + i;
> +		__set_bit(idx, &v->tx_rings_map);
> +		bdr = &v->tx_ring[j];
> +		bdr->index = idx;
> +		bdr->ndev = priv->ndev;
> +		bdr->dev = priv->dev;
> +		bdr->bd_count = priv->tx_bd_count;
> +		priv->tx_ring[idx] = bdr;
> +	}
> +
> +	priv->int_vector[i] = no_free_ptr(v);
> +
> +	return 0;
> +}
> +
> +static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
> +{
> +	struct enetc_int_vector *v = priv->int_vector[i];
> +	struct enetc_bdr *rx_ring = &v->rx_ring;
> +	int j, tx_ring_index;
> +
> +	xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
> +	xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
> +	netif_napi_del(&v->napi);
> +	cancel_work_sync(&v->rx_dim.work);
> +
> +	priv->rx_ring[i] = NULL;
> +
> +	for (j = 0; j < v->count_tx_rings; j++) {
> +		tx_ring_index = priv->bdr_int_num * j + i;
> +		priv->tx_ring[tx_ring_index] = NULL;
> +	}
> +
> +	kfree(v);
> +	priv->int_vector[i] = NULL;
> +}
> +
>  int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  {
>  	struct pci_dev *pdev = priv->si->pdev;
> @@ -2987,62 +3068,9 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
>
>  	for (i = 0; i < priv->bdr_int_num; i++) {
> -		struct enetc_int_vector *v;
> -		struct enetc_bdr *bdr;
> -		int j;
> -
> -		v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
> -		if (!v) {
> -			err = -ENOMEM;
> -			goto fail;
> -		}
> -
> -		priv->int_vector[i] = v;
> -
> -		bdr = &v->rx_ring;
> -		bdr->index = i;
> -		bdr->ndev = priv->ndev;
> -		bdr->dev = priv->dev;
> -		bdr->bd_count = priv->rx_bd_count;
> -		bdr->buffer_offset = ENETC_RXB_PAD;
> -		priv->rx_ring[i] = bdr;
> -
> -		err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
> -		if (err) {
> -			kfree(v);
> -			goto fail;
> -		}
> -
> -		err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
> -						 MEM_TYPE_PAGE_SHARED, NULL);
> -		if (err) {
> -			xdp_rxq_info_unreg(&bdr->xdp.rxq);
> -			kfree(v);
> +		err = enetc_int_vector_init(priv, i, v_tx_rings);
> +		if (err)
>  			goto fail;
> -		}
> -
> -		/* init defaults for adaptive IC */
> -		if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
> -			v->rx_ictt = 0x1;
> -			v->rx_dim_en = true;
> -		}
> -		INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
> -		netif_napi_add(priv->ndev, &v->napi, enetc_poll);
> -		v->count_tx_rings = v_tx_rings;
> -
> -		for (j = 0; j < v_tx_rings; j++) {
> -			int idx;
> -
> -			/* default tx ring mapping policy */
> -			idx = priv->bdr_int_num * j + i;
> -			__set_bit(idx, &v->tx_rings_map);
> -			bdr = &v->tx_ring[j];
> -			bdr->index = idx;
> -			bdr->ndev = priv->ndev;
> -			bdr->dev = priv->dev;
> -			bdr->bd_count = priv->tx_bd_count;
> -			priv->tx_ring[idx] = bdr;
> -		}
>  	}
>
>  	num_stack_tx_queues = enetc_num_stack_tx_queues(priv);
> @@ -3062,16 +3090,8 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  	return 0;
>
>  fail:
> -	while (i--) {
> -		struct enetc_int_vector *v = priv->int_vector[i];
> -		struct enetc_bdr *rx_ring = &v->rx_ring;
> -
> -		xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
> -		xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
> -		netif_napi_del(&v->napi);
> -		cancel_work_sync(&v->rx_dim.work);
> -		kfree(v);
> -	}
> +	while (i--)
> +		enetc_int_vector_destroy(priv, i);
>
>  	pci_free_irq_vectors(pdev);
>
> @@ -3083,26 +3103,8 @@ void enetc_free_msix(struct enetc_ndev_priv *priv)
>  {
>  	int i;
>
> -	for (i = 0; i < priv->bdr_int_num; i++) {
> -		struct enetc_int_vector *v = priv->int_vector[i];
> -		struct enetc_bdr *rx_ring = &v->rx_ring;
> -
> -		xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
> -		xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
> -		netif_napi_del(&v->napi);
> -		cancel_work_sync(&v->rx_dim.work);
> -	}
> -
> -	for (i = 0; i < priv->num_rx_rings; i++)
> -		priv->rx_ring[i] = NULL;
> -
> -	for (i = 0; i < priv->num_tx_rings; i++)
> -		priv->tx_ring[i] = NULL;
> -
> -	for (i = 0; i < priv->bdr_int_num; i++) {
> -		kfree(priv->int_vector[i]);
> -		priv->int_vector[i] = NULL;
> -	}
> +	for (i = 0; i < priv->bdr_int_num; i++)
> +		enetc_int_vector_destroy(priv, i);
>
>  	/* disable all MSIX for this device */
>  	pci_free_irq_vectors(priv->si->pdev);
> --
> 2.34.1
>

