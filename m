Return-Path: <linux-pci+bounces-14560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091AE99F2E7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2921C20916
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD581F76A2;
	Tue, 15 Oct 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k1Tq6ZbP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2042.outbound.protection.outlook.com [40.107.103.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB531F7065;
	Tue, 15 Oct 2024 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010519; cv=fail; b=CbT8KlGeJO3PWeqAlnhS4go9fbIXToIPOD2Oc5yYzm445vxsJNOFXbr+T8qOpDGp18sQ5Foc0IGnjYJVqSeeOi3iVyHyVpaKS+UUVb4UMnJTY1Pe1lY5aAyQA3G3iZfAudThAR5Px74lHYfADRmZbWSytWAk5b0u8+5Wn7gkEf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010519; c=relaxed/simple;
	bh=eQn7Maskr7kxSqqjSpK1WFuScrtI4YaqS2fe1Q8FOMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J0gdACFgMLDIrWl82/sP6s2S3pPfzzQR6eJqbjmObra6hzWIoBO44mBxkCZKFukuc/Vr0Wx/uM3gdNd+asUCprKs0d9WEqiE+Gkm4VhUCmvgrNeNUwpJ4lYuIVmrUwpuPLggGGSGtw0k50qOBgYMObWVJn+3+LZ2OGoOykf3kB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k1Tq6ZbP; arc=fail smtp.client-ip=40.107.103.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPE51g2NAaE755IXZNV+873Ru9+cc+zvrSGUBmtYw6EXgUVhvalhpTvibmfg72c3xsMLj37qH8OZW/4zrly7M1gC9P8rMFuL+YIk7oSFUuT81J6PXRUVuZiiGKpwSJRknLgXJqXx8daaY57ob0Ufa23AMqJAJbo1c9ypVeJQjeKQR9TmgON89sbsTqKS7Bv8VbZkFC+FSENtyLlKMNcmhx+l2ZHS2cAp7ZexW/kdS/6xC2/Cgkvql4EtpXoyKhPBKKlpb2qadL6iNLls0JzMnl+TdSqE0YCqI4yP7fCn5dnRLD0zJatQP0Nq/AbRxpmToAyIoIEg9UH9D+/JmFD35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TX4oDaZ/mWRRsvQ8S7wor13K/u+Ko9ElOs1Qv3apEQ=;
 b=C/JFCQLJldQVUaJSX9opduDA2ao4hPu1RV4/JPOXB+w1BcaVU5IovQHsYAH9TEQLnAHSlvCD+9nt+EY6atwj8o6KoYXxlqXhNEdbCLKbPXf3OMUHdqfll4d302/7K/WkN1hFzT9IwPzIimY7Bsqh0EP266HkSB5BGEEkrTMcF10Vkx5CIEsYwBC3PGet6AXVlHfFaWa62GFO5N4UpFHbHhWBw6ZlaJkpca/tjQHAT+e/Sacf4PeJUwQ2UQzRbCASkumWkx4eLJLc8Z6IA13bc0SAcMKMr2i7n8OOoCuukIQfOhwqRTQbTt7qPSybOcjl2t+gY8Ij0qSfvyJhVkOL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TX4oDaZ/mWRRsvQ8S7wor13K/u+Ko9ElOs1Qv3apEQ=;
 b=k1Tq6ZbPy4nQUcTGvsvrVJvBrI4MelRzBHbkuf3bpP9T9bmhRsxBy3kaNO3tEYU571EwzJuuvRrWUJSKfadO4m0RQvJ6OE4gCv4giMqLuTEWdjlxAjYPSJTVtrjNGT2gbyXM/i6w0Y/EyL6807NEsPugmOGoUQmhit8EV/pZZtGyZuMtJk+CMaOo2X+XbuCYqCTVALigNfB2MCVQse10MOmeXG0xO6A2msnbVoKvMiQ6l4ZHR+XKKDH7ypVCCNfDRwbjqrogBVOzdFfkYnjtnYWXPXPeRZoMJx6w6G+UvUQT2ytVC1Fvz8cHxObLBiSFLO03YXMU3VE0uCcL0GWQRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6787.eurprd04.prod.outlook.com (2603:10a6:208:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 16:41:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:41:52 +0000
Date: Tue, 15 Oct 2024 12:41:43 -0400
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
Subject: Re: [PATCH v2 net-next 07/13] net: enetc: only enable ERR050089
 workaround on LS1028A
Message-ID: <Zw6bR0L9tBOhQWkE@lizhi-Precision-Tower-5810>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-8-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-8-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 165d286b-f877-48c5-8b56-08dced3845a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AHnl1TSulsBf481ozWGkTVkiivkE1Rq8jjegq3Wy1P3vmwf3yXMMiI9jZ9ZJ?=
 =?us-ascii?Q?kwmknLCzD8DhVeWsah/rvTrL4CacWtHbz3EOFwEyWcqE6B3O4/JClAlPdaDW?=
 =?us-ascii?Q?idbmOy5+KLnkvH7RFUtoqVJTgQu6ISzX7sq4Eil0Q2J7ybj+JID4EwEBrfU+?=
 =?us-ascii?Q?JuvuWDVpUEGhSPiUKb1hSvwBycedwOt314mqnA89MHzsqPPSW9GXygSMuTs2?=
 =?us-ascii?Q?smskCHI8ZIerZ6+V6tAfqcDEnHGzACu5qj3fgPgT6ZekpMETAzPu8qQya/Mr?=
 =?us-ascii?Q?NfePnDC7IHYwdB2u9qF+38Z3Y5BqOpiY8HllrG5f4IzFj0rHRBnEt8GTYFs2?=
 =?us-ascii?Q?XAo+2MvydJ5dbG4IpeGcHX61F0R84EBDGUJc4ARJjclKKn9bcFKe4PRJ0u5I?=
 =?us-ascii?Q?wb7MoX9yS2v5p3EJEwSS+LVfEDuB4igctEotGR2gJzdKJAZg+qYAd5UceepB?=
 =?us-ascii?Q?PNdX7QHC0Srf1U2Y0s+pW8KYZFbm/ufCaMobJEPfs+JtLPfDOT1cP+8EqPLO?=
 =?us-ascii?Q?ybeU3hDNDpfw2vXEvwCR8M2X5D+5yk8cQqekf7iB8eWMr/g22Cn8J0sD8S7E?=
 =?us-ascii?Q?Eoo1zwwRv+s7gEvK4ZTQ0PpjrAkxLEwytqigLXRXCDtQhWZgLBFpfGTPWwNc?=
 =?us-ascii?Q?5Tc5tZJNSwBlDpji7bmkqaq1d+/I6Ko4nkk8dLuJWYTjqGuOcSfO6TvDKQiu?=
 =?us-ascii?Q?oxhS33/PYhfN9MGEeVbu2C9i9ode/oj/VZFP3g74HfEClP5cXEg5OkhEzHkz?=
 =?us-ascii?Q?lOAqv6usN3DNhs5R31X7OevURTVqclCRQXraUwzf1wFukWlN8B5LWCAkNIB7?=
 =?us-ascii?Q?RqvIXNWNWZ1ZpeVel7jzjNSzopNQbAT9s4epZqbRtIGaPQM+T560Oj9i6COb?=
 =?us-ascii?Q?d2PYfYksWG05etf42GeR9km2PB3UKZwwibjQLa2+KdUpyWTR+NBgOYxT6EnY?=
 =?us-ascii?Q?B3H3I04/lwkldRvWpRpg2ZcOHmJERk28yKFYcgsTXfqpVZnqT4ArjgsZVaRi?=
 =?us-ascii?Q?SAFQWuckdZOG9RwU0TcTnJQATp6Tqzp0KuX2C7HxUjJVXti8wdidp/7Jz5dQ?=
 =?us-ascii?Q?qOu7nkxMiqgDC0vb8MyxTU+xA060DK3vkEntgnQXg/0RjL2MsPz2vza5wbEW?=
 =?us-ascii?Q?lnqM9IH4Ip3OE4Hg6Wh0KSoe97lkmY4a2117qvdcf0xHxLdPfxwDOGxqBSE8?=
 =?us-ascii?Q?kyK2cfVQL7PyD2pA0U9eXpR5fu0rgkFtOsbvK/5g/QpxNZnquiC4w5ZIVJJ3?=
 =?us-ascii?Q?XZUFjBmwCy6fgZOqaHcq07hilBaiqi0Hv9TbB2jZfWomjUfXHG8769tSHFhO?=
 =?us-ascii?Q?dbGPAfAIKv4mAIPZciWPkaelVIdEmW2XcZyvGpvjXdQkFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?huZw3A+eVn53YuFq7BPPqG5cCEeJM5oGxjAef+z7lh8BfnQpown5ZZ8XHnRt?=
 =?us-ascii?Q?7hGPtMDShKIwBEswZgKd75TkmeSKeI/xS3Ct1E2LfgWFm9ncm+vOo09+c3V8?=
 =?us-ascii?Q?SBrqcn/P10Lde+lvunxgUtmdVNt13chv/ot55zvphq4iR2rcJzJmjLeEEWHQ?=
 =?us-ascii?Q?mwugyBCk2HQQsIqVIRCE2C6gDEQot31xLItLvdZprrua7Izdrq2Yi59cItq4?=
 =?us-ascii?Q?jD04Sku+SSfip4Zj0l420qfPRfbt5GEkkX1vsZund0thlA6oOKseeg91RRN2?=
 =?us-ascii?Q?L1r9B+0B/M1DF7YsjRX3YZNWGPtyDjNPqIBeZ1uIK3CQ2dar/JRhqBHK+TFz?=
 =?us-ascii?Q?V9UZztsRB5b+t7HcjK+RpxedDp218ZbaiqoF22ikvYhpbdyjnA7GDuLZeROC?=
 =?us-ascii?Q?Hq+1k2FHFzRyDB0shRicYHR3dAOvoxJyLXoUxgf61Earhzb+CIVoxKVJanBU?=
 =?us-ascii?Q?tZeBXNhGjvmFwrK1fR+Dz9nuykx6ipwsaJY/PIgXmBawBKdi150Gkf560PIL?=
 =?us-ascii?Q?stio+6Ku2SV9LSG1hlZ/dh59uLqwjKoOMQvLKN/7tvzYDXkQesbV2Ljq744P?=
 =?us-ascii?Q?DqU7ZOqs9+sGpPfFJw9PvPWkHZDgvWoDZ4tyifB4W9g/MXiAUwSWkN82tF44?=
 =?us-ascii?Q?LC5InTe9iDOphl6ZZOYFS4SIftWxtFUBh1hwre0bwyquRvOgcnP0ML17a1Tr?=
 =?us-ascii?Q?owPHBBVu2dYkvop0TQdY0KuQH74juNJVwVvjCpNz/gVKWrhZGXYq/ZZNy0Pl?=
 =?us-ascii?Q?voN0bxKQfr3viTbW8AaaAj2BmLKfyAy1UQUc4qxm7VdFrwxt9omDpPJl0gC/?=
 =?us-ascii?Q?w+wCWZJ0rrqpurpQR4Q4nKP27Pf+bADEZqZabs1q+rReVeohdAY+jHZqsdQt?=
 =?us-ascii?Q?iqp5UkiTxeC2mZvQUpbjUNgvlqL3XQCHyB0M8nvSmtz6TewBZrFUPCxKChxS?=
 =?us-ascii?Q?P7tXp1RUoCJDXknihC0KP0/k7gVzG+xRN82Z7iL2wC/PPqIugyRHpKjZMgL5?=
 =?us-ascii?Q?bC0rpnnHn12Bv2bT1gQ+fMafgbwbKPDu46BDaRr69xKee2aLq40yLvLirn5B?=
 =?us-ascii?Q?MQ763K9skRXRFZ9yj9CTF8ghjKVZn7BM5aJ777xtaz1PBHT8w7c1RcZ0ARi+?=
 =?us-ascii?Q?KA4DmTXaBblls4+RwVUAq4/6sFbFarnOGM4sBfjXPJ0M8TbdE7ZaTJAmKbZB?=
 =?us-ascii?Q?8X2yyWpyTJpA7KrU4SLpmkMfzdlPeYn83CXXbwq3hEEG3ikEP6faEu0ysUvO?=
 =?us-ascii?Q?YLqWHfKxhL4NQk/nFYmPlltQd14xWw3e/2LsKA3KBWbmXermIN/fV58HY8GZ?=
 =?us-ascii?Q?laSkEd5bnHztUSFhJn1yjbTfE/xYb4Kbm5U3N3Vs2HSO/BgR1J6woSxQ68l8?=
 =?us-ascii?Q?RKit5cnEjVED66RUNsO8FIlqBsUNgPrxuvOU0kVC7sgfdrWebG7ROSj1mL6J?=
 =?us-ascii?Q?PVUbJSVF1i325bH1epbywMT+KuRvukVoSp47H668WSd+NxJY8XEvI8GTXQkT?=
 =?us-ascii?Q?1vTd+y3YPGnL/gb8pkhWAdhMHTBZHr7aCi2ciKv/AInSXcDxFtn9+r7wgJbL?=
 =?us-ascii?Q?EZjEGIOZGtlP2rD1aVUEGJyyjq051NMdwYdtKv11?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165d286b-f877-48c5-8b56-08dced3845a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:41:52.3832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ma/0+HxvgLDvFaAb9MwZ0OF12EahGNInaJ5s2wA0cQCEmu2m1XDH+bY7/d5wgggcLxhPhFT9E+fkY1XcQhszuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6787

On Tue, Oct 15, 2024 at 08:58:35PM +0800, Wei Fang wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> There are performance issues associated with the ERR050089 workaround,
> as well as potential functional issues (RCU stalls) under certain
> workloads. There is no reason why new SoCs like i.MX95 should even do
> anything in enetc_lock_mdio() and enetc_unlock_mdio(), so just use a
> static key so that they're compiled out at runtime.

Remove ERR050089 workaround for i.MX95

The ERR050089 workaround causes performance degradation and potential
functional issues (e.g., RCU stalls) under certain workloads. Since new
SoCs like i.MX95 do not require this workaround, use a static key to
compile out enetc_lock_mdio() and enetc_unlock_mdio() at runtime, improving
performance and avoiding unnecessary logic.

>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes: no changes
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

