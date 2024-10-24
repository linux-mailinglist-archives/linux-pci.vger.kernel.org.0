Return-Path: <linux-pci+bounces-15246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7029AF414
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F64B1C21A80
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC97A216A0C;
	Thu, 24 Oct 2024 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PP7hbDhP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE2174EDB;
	Thu, 24 Oct 2024 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803023; cv=fail; b=jIqrjZPh5nHAe8p3zntzmsjx3HDsUFGejot5tbeXQ5VZphQH2tCc9ep/4egqSq8FQcV8ntQyCeJgVI9n4LkcaYqZp5EQl3kjmerotaHz/NAFoL4vrdE7ZpzPEz10ZWaOQyRT5aPE0J+DfrBgdnP/gS7bpO8ix7NteeYPOK11H8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803023; c=relaxed/simple;
	bh=r7qkt4M2Q4J/n/SOHihHmBKXaU4pwcA6zPx3E6/EDd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RZB3ucrUNXcb5a8LnDtX6PD1WyTT37TuN0715aeBRHdQhTPJXrbz/abNryghVoAJ4f+VfoHIF2hyHrlN4b8E+dM6iTeKwr4alsul31/JwKxrn/noHBzDxAKVGlS6ojb+gBzIa3EmMI9N3EjGk1X22RbgjUX6c15qZEkiGEEw+eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PP7hbDhP; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daAYvTPfU73nKQuzKm/8rIdqPCESQCTWEiGDH4zQ7C2xijq7aH+oYiaYH+V3Fl3x5QW/X6yWanPI7fFFOXt0J/UULt3bexr71/FIW0rhCxQD75Ae6uClISrYGuLi2ujofXNsgEdnCjCioXdADp0EeQFEh1oCxcR4GhO9kKON+mEqAx2rtyydmUm9S2E6KgWkdO9I1MAx7nlbgGlKbFWd5rMD83LtYfEw12lu9zr5abdBOhEu+usKNC8Ajs7r8qWaW2Q+rL/zXn/YCqJBuNEgqrbHL9RafClis3ofFXpacU2ZWWIzNtjsdt0V3EI/ne6TVVR+EkiLDE71FTq4kkF9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6DX5yYhR1W6YuKQ8cbKwaqHQ6bkx//ZTIxwprvs+sc=;
 b=cPL4roA0/T8KUXAC1Ee/u1IHPws5Wee3/tlj0UCpudsMZVi4oTO/YFB0/8b5wvLqafcPHNC7YmtyFc0l5c8bfUD5mHfsw5LBBN4kimMWoaJhjQEk5x0oPL9QhBh0fYagkvxfLUIk/PferOL4IsQdSYFBKPXvm/F2YiCIDWCteeOcafTBMFOSxXAHZ1OEZnvgpe7WRBPKgmO04MWQZMzWIIJqczB2Mo/7uNs2oEgG987HvOJFEKrsUNOD3vyOqoLLn9xewqrnIx9vhWjq1fds6yk6BZKw2Zx5Ud8BjOb2YFeKfuERCZBpbtfmFoBwgr26OXDguLyaZyStdGHwpo9i+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6DX5yYhR1W6YuKQ8cbKwaqHQ6bkx//ZTIxwprvs+sc=;
 b=PP7hbDhPHU47dgHdki9pVD/nD3HvfPa8VEjyLuRsqIbloHsmfMAK9Vz/gaT2vUDpeWZPWPZjJ5ymKbr44mZx43KBUqEJdY39C+qpfMDWFo8dAONkbvm6bB5Xp2ghrXcQ+cDiXsGpAk1XjTOvap5VgK0kVwcV18F68F1mLbUAtdFG0wLrqbpBJl/9c4RRv33qGsy/MngUKrFFd8CGEfCt5MTnBTV84UaBF0iRqG/2lBriBSkC3g2jkyzMARUsUm4eZD/M0SVqzNxzlYQqq1qK24mkqd9mvvU/pUMAduihOXRMIE2vmJVcxjVVU/lYSzRbCJUp7PMIaJQV95h9XTtqIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10766.eurprd04.prod.outlook.com (2603:10a6:10:587::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 20:50:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 20:50:17 +0000
Date: Thu, 24 Oct 2024 23:50:13 +0300
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
Subject: Re: [PATCH v5 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Message-ID: <20241024205013.xw72mtssgvmwfmuu@skbuf>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-11-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-11-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR0902CA0055.eurprd09.prod.outlook.com
 (2603:10a6:802:1::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10766:EE_
X-MS-Office365-Filtering-Correlation-Id: 13400645-fe8e-4dfa-9981-08dcf46d7758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?10wDiqNNOqTK009OSYoBvS0a/47Bg0Jtb/QTxSKKI0zgeYU4RcKHk/6RKkjF?=
 =?us-ascii?Q?5mwMUQnx7di3BnSRLQ+K7TSvmCXG1J5Ip18R2/tlw5TBjpSYEFjkrCvniX7/?=
 =?us-ascii?Q?zWnBXws6C2ODg4v5VA8Vvf2GPn0VMfoKwzraEyi/N74uN4vkqbDIk0QjhwB1?=
 =?us-ascii?Q?fFBPa972+nXxYAVzDDtHLVodAzpDYBHV9720F/nG3qI/T4PvNl0HcZ+qjRij?=
 =?us-ascii?Q?Nrf+1sGgAdvnBCzMRr3E7Pm7WiBzWIp5l4G+wh559NrXoVa/aWAGIfrlZ8cl?=
 =?us-ascii?Q?4ByGrWkQkmxR3Nr7bSV0PQxIt2zsIib7OR8RkPydDwfwWBkOqfEAHqGdDBpR?=
 =?us-ascii?Q?pMbOwzb7MhyqmuSFGTuLwhk/ZneF4nK993h8RBGXb1fWZw3vleuZERjZTWi+?=
 =?us-ascii?Q?L7Spri0uTPcp5MRzBQdmij/+pyt/LmSn3Dzmj1o8CJoRlnkfqdrzTGq362A3?=
 =?us-ascii?Q?Ka+FX1wWtHRiOR+lerSTutblQ1VYQdug8c/9Hv1Wu7cSB3WwuMD/4BPj1f14?=
 =?us-ascii?Q?pQO81030aUl0/MY1sLTPALSleBMpzMKzWrEnSkwzHw/Jso6ESsrpq6dHqneg?=
 =?us-ascii?Q?qHvtHtFyyLdSFhY9NkMLL7SaXPv7JIaZ2RRCnZaGg+oz2PYLYGwGpM2zru2x?=
 =?us-ascii?Q?105upzd6bI8qkPxOswluIJFQ1E70VCxtV9Z29jYwz/jGABMhmh8iOEORJwkO?=
 =?us-ascii?Q?IszN2cdiwD43qOjFfno7mHGdiaiRnPa0xKICUFat2LqXNFSU/aDTc1bmXyIl?=
 =?us-ascii?Q?UUbHDOo5lzEFj71QzpzADNXBBxvPEoTIea+V6xwLR1zHBBm3oT1W5YlnqS3M?=
 =?us-ascii?Q?zhtHMEzs0CeLd8TMgNtgwvs7IbRTL/XPbYRGonFFebSCSBdX7c03uzXJnsmB?=
 =?us-ascii?Q?P0tmcZsjEx33xYHSjOpobmGF/rmevA2AjvsDmmQnnIwPl89lk2nL1iYjH/lH?=
 =?us-ascii?Q?qzXYDspTQfYpl+rOy4IcdYcWEwkZIIPgKZIWiZPm8IlOvRGhcNfzC99pOKXf?=
 =?us-ascii?Q?ojx9YEVEi4AdLgY+wNHvrh7VSeMpIHZ8Z/KT/Pwp54TgejTowvfsQq8bdOqA?=
 =?us-ascii?Q?NkslfQ8rP5diSH865sKx4864WGkLBzrpWly2IDl5bpr3lruOcykVEVvoMAm1?=
 =?us-ascii?Q?RVUOb1av5nPKQ72WnJctSWzfbYhghw+rl3jA6YHr59Csd6Fg9bGh7uQStMpx?=
 =?us-ascii?Q?Crs15QOV1Sw9w4u86ZhSY97d1E2wZygpNItnJucWRffpEWXCkHWeD+vzYyjv?=
 =?us-ascii?Q?FLmwxHWgnVhjAUsR7ZsFehhPIIiLULYcqs4BtH2DPFKuHc1+3DXndvOp0u3r?=
 =?us-ascii?Q?ZfGvz/Y8vqN5t225qD+CbDka?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?50VbgVvU/UeMUARK1fFP239iecXtFqpFFpeVdZinwa/5DGmbR7hMow865UEi?=
 =?us-ascii?Q?+OgLLevsRLAmZL/kPHqi9CMAhuDOZQjUgxil7Y8y+mPBX2hXKnUQUJo1Uwnj?=
 =?us-ascii?Q?/AFlSU7VjVwz3vQw1PprKDFvQaunmiu+Uc4Uq+9wf07ZhYboloV91xHFBp+3?=
 =?us-ascii?Q?N5naxbuc7MW6ySUP3BnadPqngbuvgKUOhl1AEbdUlSDrhQDXDvas2HjuFJHB?=
 =?us-ascii?Q?+d4Tx3JJ4Y42Rzvb6V5GZGQCFhB4XqsBd0DKm1zR6v1z8PuohJJHD80xnbBr?=
 =?us-ascii?Q?QXVMVNKVtKS4aim3oKtXRQXG9mQWOVgFgcM+7y7KxFs4PPcZ+tdQ5AAfkHkT?=
 =?us-ascii?Q?tnsixhoP9tFZhEuttXu+3HZ+pZ/qrNEDf6XNPmH9Vt5pjpSzwjAFJEt5b4gJ?=
 =?us-ascii?Q?2zVEVJdumOHZtzH7NAkoaB/+fyB46o39WhhWFL/7B5NpKmCJ/zJfgWiIXZ0X?=
 =?us-ascii?Q?cEvRlWdY3NXAqPj5Plm5wQ8D6bBhgcQQu7tATYjK3aQ5zVXXrb6R9ytR2GId?=
 =?us-ascii?Q?qUNY3a+S5KAAOqHgsvx6YsHJPT0PTH6vtNc7TNs/ofs8UBQ4hs5dnIrlUdEb?=
 =?us-ascii?Q?dbm7afLE5Tz4zBd2cJjArg81t3F/O8Wq4rh2GmbEK8Dow7XyKJHa1nsv2Huf?=
 =?us-ascii?Q?WwEdFQnLrr6oJoqpZRBxkDdgBkkCUG4YNrlNu5hNRGpkt3knefNoln9iN7UK?=
 =?us-ascii?Q?T1cnG5sGRg2+QdTvHKAnKOtCNM1vt3lEp6IIpJ96pMdlmiCub406uXi8JhNt?=
 =?us-ascii?Q?CMYDNmzld99qWjS5Z4VQi0lexnHtYdWp94tub1iutSZGQRXqhCWTcy9SyEbW?=
 =?us-ascii?Q?TDJ4vwLzxhL6VmruVrYa3u/LzkJdNSnny/3zWl6IO0EN3w7C8J1aUCwFjNxw?=
 =?us-ascii?Q?au+EaccFNudBVHVlF6lzcLvI3KKaj3hFGr0G+86V/5tJt+WS5e31KcdUNGBr?=
 =?us-ascii?Q?5vOBk3AVt4hLnkaKm+xS3W1ptqHMoV0Y2VEq/HB9vN2FznblUJgCeMWhVsZQ?=
 =?us-ascii?Q?tngFweRcX1fwMytqhCQg3s4CxVyS42GK7C3JEJ+v/tDFtpe1x17dxxHQGxkW?=
 =?us-ascii?Q?FoOQSNVi+ij5wN3DOU4Vdp2UO1ZRC/o+PWeVjuPwMwY6CkByrFQtRt4wsOHc?=
 =?us-ascii?Q?Kc5Zm/miR11gloabtQHs6F4VBhwkJNaFxrWsQG9CtSNGHcM3Y9La8Q9NKDda?=
 =?us-ascii?Q?MRVAnD73oVPJCZPIWyX+empxsQTGYALVidmAk2YIe0JtHUBXsNY5kJU2oQur?=
 =?us-ascii?Q?qy73LSp6Q4VkEm62OA+V5cfc2VNZ9czBby08HVubbND0jaD3c++axkim7sX0?=
 =?us-ascii?Q?ik3ke7scu5RFA0P9nqE7D0uGAsdamVWmwz+mgF4FNNB3fvTOaN07R0D7d/Eg?=
 =?us-ascii?Q?Rqpj7sX5zKxfoBhf9BaatKvGWq5zCsw+Qdyw+3NRaejK/tPsMnSJVbeeRPEc?=
 =?us-ascii?Q?+X0mic1WFoJZ6ZeQeV2nr/VZqmCzYlmPBIUf9lLb9SONBwFAJyzl6GZ9ph5u?=
 =?us-ascii?Q?chwMV7iH86NixOAYlW81Vs1nWGK/uUJYgy2WuCZtAw29m0cSFJJ+cVMCh42R?=
 =?us-ascii?Q?WAyZlYbsUuN3MQZDMiV3G2uyFY8x0VsAYxGlF3/kU4xTGs0p6/K2ZMcWMURM?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13400645-fe8e-4dfa-9981-08dcf46d7758
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 20:50:17.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6iSdo3DvUd9I7hByflkyB7fJJChXRqh/uihGAsfIkFsAzF+SXnZByqKpbfTx3oLXHaYMbANaKEXRDe0B1GDlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10766

On Thu, Oct 24, 2024 at 02:53:25PM +0800, Wei Fang wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
> enetc_alloc_msix() so that the code is more concise and readable. In
> addition, slightly different from before, the cleanup helper function
> is used to manage dynamically allocated memory resources.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
> v5: no changes
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

Please limit yourself to refactoring the code as-is into a separate function.
This function does not benefit in any way from the use of __free() and
no_free_ptr(). The established norm is that the normal teardown path
should be identical to the error unwind path, minus the last step.
Combining normal function calls with devres/scope-based cleanup/whatever
other "look, you don't get to care about error handling!!!" APIs there may be
makes that much more difficult to reason about. If the function is really
simple and you really don't get to care about error handling by using __free(),
then maybe its usage is tolerable, but that is hardly the general case.
The more intricate the error handling becomes, the less useful __free() is,
and the more it starts getting in the way of a human correctness reviewer.

FWIW, Documentation/process/maintainer-netdev.rst, section "Using
device-managed and cleanup.h constructs", appears to mostly state the
same position as me here.

Obviously, here, the established cleanup norm isn't followed anyway, but
a patch which brings it in line would be appreciated. I think that a
multi-patch approach, where the code is first moved and just moved, and
then successively transformed in obviously correct and easy to review
steps, would be best.

Since you're quite close currently to the 15-patch limit, I would try to
create a patch set just for preparing the enetc drivers, and introduce
the i.mx95 support in a separate set which has mostly "+" lines in its diff.
That way, there is also some time to not rush the ongoing IERB/PRB
dt-binding discussion, while you can progress on pure driver refactoring.

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

MEM_TYPE_PAGE_SHARED fits on the previous line.

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

