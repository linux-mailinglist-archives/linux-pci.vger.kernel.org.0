Return-Path: <linux-pci+bounces-14104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CA49972FB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 19:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746C828244D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFDF1A286D;
	Wed,  9 Oct 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iHOVVPe/"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B51836D9;
	Wed,  9 Oct 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494728; cv=fail; b=c9WrzlN8XS3VUHmzVNwcX3AcBWIoBR9/3SVdcAXpvnubhfiCruDg+gudSgdNGslaUWuFS6PCj14iCbGwq4axPueVK/hp/cV7eUlAqTX4CgJ5ufnoRAekLcuV6i0qZ+DIvwiXQymhh/zzLnFT3JhdUmztZFSQ8eOKVSQGGoj7qFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494728; c=relaxed/simple;
	bh=13EwtkyHBB1EnZ7i19iKb/5ytfGW8SfgxHrZEgw9rlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JsdKTwrxHFI7PB7UW76iqL8mqB1JGEmQDoe98h06kfk/ukaKDgHMZSbeuS+hs3/b94MRNhYK6YrW1gsipz1fDLG1xzYnKV5w8mstWjWHuFuTc02P0PoYbdakZmIIAaTb5yZ0d4DXNlRhQ0TtI5/Pr/soaWglTWseipYAICScvKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iHOVVPe/; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yH/m5aW+xmnjM67N09LUkt/1qYkY6iQAP7yI0JmpOsAaMNjV6vX5PUQIvxJgF9h6mYJ4zdNb/YJ7ZHZBHkKUoV2/Ursy0IGp+40UnarLaCA7GiTa5ds7lCyVR3KYVhxIgLKfTyNxX2Klqrj7jJRgnrLI7+8mA4ql434PXSg0JFCHilEQn2lPM85xMr6m+389XcttTgnL7H1fCgeYAGS0Ng5267AkNztXFalMRAretqbAbTKg11XpmW1R4QCqIP0/h5pI5YlYMGxTXXhTM6D6bQL1GMNSPg72ox9Th6hLCCXz3PUttrUR3+M5gK7PtUERb0G1OAKTGvnsvHYpLTtmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEWMru0DEPtm6ya7pCWUHEf8S+fz+TB1aRXlg/4hhfg=;
 b=qi0RBIguvnxC6A9kiUUjCjJ3W2THpLIQ8u1pVc9whxwoWS0ipM4aaoau5wTkQLSeyV2mees8jpKP310n/sI+oGy5BtLKxTmOfH8zwkzzx9a9JQcLHno/UL5vA/0LZzmz+dHDZ9b22HLwErkmbOlLr6gBCAyZC0Q1G4Lok8SGQlp1ie5+wQTkpN9mwNUOrPVW17kS56JmJga6x7+xTS/753jA8hP5hynqCu/ML7bm3TgfwkP1lybs+akBRiNouzfl2Qecjo3lihaB0Iv8CuPSHYdTSLpohq9W9wIqTGM3cKKCF0zR4mPApwl1FxS91Tfus9VtRrGc7Re/q7Sr5Qoiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEWMru0DEPtm6ya7pCWUHEf8S+fz+TB1aRXlg/4hhfg=;
 b=iHOVVPe/UMXxfAV3PrSvktIkzPl67hH10mJO3L0SHg9gszjEq372ZKqj3suKNQT7jXmojHPSXsnwhSvQF9hO2OVM+OKYqmx8F+MCl3qrEbVyjn3jsiRg6W/JYjXLJLW5PYP9miDaJVUIj7A/Vez8J2RSA65oZRdHMMLeAPeS1Oh5rc9Pt2UrG7QdgTokDKG9HreBbQg6jMppXIzE8APzW9LziiQ91jBmQ6onzPix4GVeaAbAqAYpomRwAuX2aLQHwglkG08Tzi4paQVdq4jRJIDwLxTPISlTnMGXmfRu2cYo9dXuqj1D9Fn1izxRC0T50ojUZmDvFBN5VNP5eGunsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6913.eurprd04.prod.outlook.com (2603:10a6:208:184::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Wed, 9 Oct
 2024 17:25:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 17:25:22 +0000
Date: Wed, 9 Oct 2024 13:25:13 -0400
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
Subject: Re: [PATCH net-next 09/11] net: enetc: optimize the allocation of
 tx_bdr
Message-ID: <Zwa8eU+YDuseXmK7@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-10-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-10-wei.fang@nxp.com>
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 0802718d-f15c-4926-5bf2-08dce8875ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?32yhxPxv1UMkUyTwd4Llyb7aketHM2xuCZGIQG5kqok0u64RJVogyvMnQ+dt?=
 =?us-ascii?Q?XB0ocF+jsE9r/IXzgFTLelc1gUqeH1YfJ9aBTvYCPcdir4Gk4AQ03lZ7OSpd?=
 =?us-ascii?Q?THFYb44945zqZwfkV8nWGKJ1Rlfp5YNizskUJDbQEH1sS5ouGl5kvG9iptgf?=
 =?us-ascii?Q?QT1PHdp8EY0NOyf75htT3H4eVNcrGhV+E1LryuBT0tBPQuz496zplmSd0mwi?=
 =?us-ascii?Q?tTDt76p1LtTQ6/6fVwglseOXswZ/M+pqQJfnoB/D5ADQYmbH0QgNBJGAahVs?=
 =?us-ascii?Q?jv3Q4J9fwfUWadG6PPXKEG4MKX3JwzEiz95GBp8hT4PRuSadAKODj+fyRfWd?=
 =?us-ascii?Q?rYpfRuRdkp4dPRiZdHUYjwqrTctstK2+dYxnfd9hN75cj4v4Z0ge2SyUZ4/L?=
 =?us-ascii?Q?qknIpX1M6n2rXcTbwBvKT9ISv2gPNAetZsY0BdW7b9mXe1oGCnYiNWFIDqFZ?=
 =?us-ascii?Q?q0d4h8nKvkgxikiI4u30V5OEmM3keUpfgTflcKPwMAbOd6blDQah8uMAxh0o?=
 =?us-ascii?Q?hmxL+gGsShihITxDtpNKQd6WWGH4BjjPUZC1bmd6zz4Ro2tdwsVDaPi6uXp2?=
 =?us-ascii?Q?X9Lto4G9oAeySZ+GQ2dUhupZXZDhvNB15AkVfXZzJAZH8MYWgB7cGZ/ZnZ7J?=
 =?us-ascii?Q?gQi5ThG3w1qNABUz6eCAkWKF6oOATXpBL5vSMG/PwvEhKcVK/N8c46gHDiVG?=
 =?us-ascii?Q?D+2kqI7u02t8ifiL3KizXf5nqVesL65nZ5TxCF4q7keyYYgQ7U9Q7WC1StPf?=
 =?us-ascii?Q?G5pJg/9FzUZU8TMtPv9dTU+zz2Y1iM4FEo0eWcMS9FGglO2Rkw6JVLJKzv/9?=
 =?us-ascii?Q?qHYGQa6kixARxXjcNqkjIQY/OavW4P+adQHb8boMKyudMLK3UH+W12iYCdNu?=
 =?us-ascii?Q?b7Zs1rFsSoWQnIfeyMWMnuGznU+u2lRst3DtMOjZgMIcXEc5JDkYbdmV8C9h?=
 =?us-ascii?Q?T5GnwvmU5FutapmECOFG2T1lhELcgys//2evEuPZslomVhYu5cbATkHOWV9u?=
 =?us-ascii?Q?GPftwbqlteMFK6CuXvVS+I2Lllzso7C9oEs3vNlXCxA4EqOuWzmRUCC7UCOM?=
 =?us-ascii?Q?/ufVZBjuBMZvP+Kqw+Cibpq2NjMWl3mJCbhMPyR5rQ4EDctqqrl5H5UvhEas?=
 =?us-ascii?Q?hrmSj+XKeY0Wbfx4VbAAHZRQ8FeOCNxFu66H3Qn0vr3au8C1poY1K++7/ZxS?=
 =?us-ascii?Q?uBHc6NJDJ/tuCRD4fMHAuwI0Za60JqXxf8WQAb5EEvJ05N+vVnfcRx4harKN?=
 =?us-ascii?Q?yLpLw3Tx9VfPWex6wAIhuQ9X1+h668O6pEgbaldy3T9XUCs0yg/1H3fN3iFF?=
 =?us-ascii?Q?hma74Matze7ALeOwmWpGWaHnrogFvK3Q+UOTT7avU5UBlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KPJyEnShwlIg1U2jQ8PezHCPCp6z2+7+gXs7jSm0FK6yPhlyew5d8oYSgyB+?=
 =?us-ascii?Q?oXlF3MIVlnh0UIBCoUFg+icVmvvE+d95JzcfykmO8GdtmbvjpBwnIwnaf5l/?=
 =?us-ascii?Q?8+cIj7sC41KcAd3F7eI6Wc9yrQDnrZi4dChlHgwGM//z1b+EKuFQ5omgZL1c?=
 =?us-ascii?Q?p20louJxg1lldeuyDWQkLubgyBZG91fmlNMcDz1GK/DWV1hGF16AKLKkV05F?=
 =?us-ascii?Q?qQ6eCc/tI+WdI0P5J1pnoFpj2DTsQ5amMsRjD2CzyNtVuaDlhi8MlXyfSFiO?=
 =?us-ascii?Q?cCqk2hyAlVX3xcSPrtRA5Fsyv1hisNkd0b0/BRXcp4oshbCu/lxrjX3jn4BH?=
 =?us-ascii?Q?6XaQOSBZFKYwRwd43h31u5CHD0ULk+oJeB9SFjtzWQmayQJgcYTDEPYY6XwM?=
 =?us-ascii?Q?JHH3PO3RL7GWloa4Wp87QyOUMJjC3+8IiZUqwXh+xPA0C526FcCNKBQncQlv?=
 =?us-ascii?Q?8ZC6ZDFnUhZ2gjW5UCaLGwwRHusUbW6tCS3pANc/X+cavYJhMl6O625p3KP+?=
 =?us-ascii?Q?Thkx5PVEPWScV66aZtat+/eSG5fKhCmSCdVTqb+rMVrWujlnfuKf5ywQrQDp?=
 =?us-ascii?Q?JFTqu4rLfCchPae3boX9dCUeP3TotWnlcNpmH2/0ue0jJka00Ly51CEMOQll?=
 =?us-ascii?Q?/hux4IOFf7hkz66cqoP5GQVGINC6rhS+xD//k0ds4EJU90a9OaA8dBL+5E79?=
 =?us-ascii?Q?wl2RdgrIh5qc7Z7QkcdNeV/YWJsWPflumlUzpREitrIydTklQ9E9Xxz11T8Q?=
 =?us-ascii?Q?5yC43p2RPdAC78ymgtmklB/7ncoXbET4avzZkXyA56dJXqUwYRcWXquto2vr?=
 =?us-ascii?Q?ak2GZrUPwNbfD1G00SnGZu3J54hJCKF7vBid4KV3VH56dxeJBV6mw3MAMRV0?=
 =?us-ascii?Q?7CzckLDVjfF6eh8QPHOGvrUC4AbQAtABgD24MOoayRKJyvLfV4JtRqNeRwFa?=
 =?us-ascii?Q?hIiT252sTiiWL6ZMqhPm3RQ8DxsguDQSwHOmUlPkUKOLi4V/Z2hg+4Eg14ko?=
 =?us-ascii?Q?pvGtAykUg1HtMOZkGlBQEsCgvlh+xV+v+IzNgiNYM36PJTAys+PeJiTXsIIp?=
 =?us-ascii?Q?CeCoFwn5IVhN0fVz1+wQz6bcZCtnX50uyqyhI2b2iAaN7idENQBsfHC2fUFW?=
 =?us-ascii?Q?V+pHHhWRF1vuXgamCjGFuyR985WjLcsAkb1lrnukvRnwmdDXfj36Q2RQCZNt?=
 =?us-ascii?Q?Wof063fTCC2IuCp3dSJiAbbwQM3hkroB5KL2mtFcpb1lqZFoiywQmUiHHFQO?=
 =?us-ascii?Q?NuTkcABILATprFQHW6Nw214ZfTQt6uVd4UT9emdYVV3GbyCQJTks/Fv8JHxx?=
 =?us-ascii?Q?XZxlVo5qVMm8rrBxWee1x+ih79LYZTKehcejuQKbH8d9kNxRm9nQ/NjsmPs/?=
 =?us-ascii?Q?idlRp0sKV/M1SBYUmihJ6sNpLy8TD3xSP3XMeeukDuiAv163IgfR6ZGdcqNo?=
 =?us-ascii?Q?bD5THaDuvWmsD8PPWw7mL/9gdBRxNbL/fqQ6Msib1CSi07ADOcxkerSJirV+?=
 =?us-ascii?Q?doxjYsHlH8YN+xhIvFcOZ8VxgN/CqnsUFcKa5OwEyv+47/wuZVNiQhfGuz5z?=
 =?us-ascii?Q?5ENjyNJl4ARWj32BxLW4FJi0hTqmenlLLGNWrGmr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0802718d-f15c-4926-5bf2-08dce8875ad0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:25:22.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KM06Af+Uk2XSqHmYyulih8PJN6EpvkIflTPD6yn8glJLXYuu+c3ijnspf3j/WmtytAX7NwTCua4MmdGzbo2YhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6913

On Wed, Oct 09, 2024 at 05:51:14PM +0800, Wei Fang wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> There is a situation where num_tx_rings cannot be divided by
> bdr_int_num. For example, num_tx_rings is 8 and bdr_int_num
> is 3. According to the previous logic, this results in two
> tx_bdr corresponding memories not being allocated, so when
> sending packets to tx BD ring 6 or 7, wild pointers will be
> accessed. Of course, this issue does not exist for LS1028A,
> because its num_tx_rings is 8, and bdr_int_num is either 1
> or 2. So there is no situation where it cannot be divided.
> However, there is a risk for the upcoming i.MX95, so the
> allocation of tx_bdr is optimized to ensure that each tx_bdr
> can be allocated to the corresponding memory.
>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 121 ++++++++++---------
>  1 file changed, 62 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 032d8eadd003..b84c88a76762 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2965,13 +2965,70 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
>  }
>  EXPORT_SYMBOL_GPL(enetc_ioctl);
>
> +static int enetc_bdr_init(struct enetc_ndev_priv *priv, int i, int v_tx_rings)
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
>  int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  {
>  	struct pci_dev *pdev = priv->si->pdev;
> +	int v_tx_rings, v_remainder;
>  	int num_stack_tx_queues;
>  	int first_xdp_tx_ring;
>  	int i, n, err, nvec;
> -	int v_tx_rings;
>
>  	nvec = ENETC_BDR_INT_BASE_IDX + priv->bdr_int_num;
>  	/* allocate MSIX for both messaging and Rx/Tx interrupts */
> @@ -2985,65 +3042,11 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>
>  	/* # of tx rings per int vector */
>  	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
> +	v_remainder = priv->num_tx_rings % priv->bdr_int_num;
>
> -	for (i = 0; i < priv->bdr_int_num; i++) {
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
> -			goto fail;
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
> -	}
> +	for (i = 0; i < priv->bdr_int_num; i++)
> +		enetc_bdr_init(priv, i,
> +			       i < v_remainder ? v_tx_rings + 1 : v_tx_rings);

suggest you create two patches, one just move to help function to
enetc_bdr_init(), the another is for real fixes.

>
>  	num_stack_tx_queues = enetc_num_stack_tx_queues(priv);
>
> --
> 2.34.1
>

