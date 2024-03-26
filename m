Return-Path: <linux-pci+bounces-5148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DFF88B852
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 04:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5655E1F3EE23
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 03:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05325128826;
	Tue, 26 Mar 2024 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nQhehJRo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2105.outbound.protection.outlook.com [40.107.22.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14957314;
	Tue, 26 Mar 2024 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423276; cv=fail; b=j3iikHTpONTIUhiPE33zF/bbfuoBuwc6rSO95Vz3Nd4KAosduh3rvswPta0CrwVtD4FWQh9Ga/B66BlyTgDrQO8RrmdlNWoDiuEO7cUXWZbuqFtDtFEv2WHhLgDcsJ4FybjnO9tJMFENq15dfyPVWvQPgUrkZpyFpsHN02YCXxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423276; c=relaxed/simple;
	bh=1mMr7kWpSQh4d45YS/CoPUJW6RtsYBlLDKztPqxrJZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6bD9DQZ42d7dIkP9REpDYX1N5E9OgEwGleS8WPS1ymwX8Z3Uxupk/yab/9Oeb3j/C5g65C2hTqNy42YHeeFVXmxAZ7TsNAA3fSI7Wqi4koES/nvh+6f7QqdnWc3QmY1fwp4/DAGI01M7iP0VGoZEsyzYNOPVRFjqJEBTxlu2QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nQhehJRo; arc=fail smtp.client-ip=40.107.22.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0RTXvXx3ZdeVQw66DtBgOEiKY58ORurHR763YCZ8XUzXN0JNqffkou3/ayehK8RcoCqcPmkv+rk+joXpkrrWmEihTnt1vteLW0vNw0bN+H+2nqJlh9pJ1oswS9BZwShUxUJc/HtP2Bp9LZPMbWY/Fg6VwvKHPq7aJDPfRC/PwCC9qnx0FVC3uwWavy9etmbCYH6qBsU0f6/A9sbCWnxuKhXcF/fcZxsm9I9zhFnYs1UFPqbru5+QvAqruWnN2ph/NUtP8rMvCoJiEX35vNM9GXWzMdazpJkCIlXggJ5sQR9jHKqUyCp7OzHjuinx/SI6pHVvlg9aq4xqbuay2IhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia2FDLfELgf2UKuKHMr9hgXLUzD6pGgwKJudw0V3mCE=;
 b=ajjNx2afjuNMK9bMjLaUhk5JPMHCOBUNR70TNB9FIYiwW4OW7ZGHx+1jazNJCnRqNH95LngLMVwwQv5u/+/qE+08P5d9EUtmYoN/k+blUgqZ69TEIhNzNTeZowGjF6c6q18F06PGyig7kI0mwzbKGZSPO1j8faSuCGZb0UiDM5gOsKOoJ1xXvaL5Q9SluZsw8vG6sKSBbgZ0UwAic/pl9xsjx/yGCqgfJeJboczDb07ahwZRFsz8sUHeV4uxCtrwQ9IsdRcIw9aprv3ufWEnCfaNzCZdzE3TE86Vcf7iHVH4L+15HrWzvSuXu2/gQw+72Fyj5R48k6PYd92Qc/AyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia2FDLfELgf2UKuKHMr9hgXLUzD6pGgwKJudw0V3mCE=;
 b=nQhehJRo6nfLYknmlSRcRd9T1p14roxC3UQpOvzgBXXkQ0w7dScbsTrddlBTLFERQDbo2rKVpvZCLvfbqyiJwear/yv66rfm4x8AL24KkeEjbvrsP0n3w0uAJb9CddYcxq03VqjAks7ln0M12k3h5IAbHjVde6+oW8TiX86hAPY=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 03:21:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 03:21:11 +0000
Date: Mon, 25 Mar 2024 23:21:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 6/6] misc: pci_endpoint_test: Add Device ID for R-Car
 V4H PCIe controller
Message-ID: <ZgI/IGe2L0rJ8SSF@lizhi-Precision-Tower-5810>
References: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
 <20240326024540.2336155-7-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326024540.2336155-7-yoshihiro.shimoda.uh@renesas.com>
X-ClientProxiedBy: SA0PR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:806:d1::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7114:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lrYmTga/AyvOC9YUH+5563rCN7oIOFSqgp56AcrBHqUtpR0ouDNtbYga37tTvCW2JWCAf3TJq9fOOPn0Z0BVk20Ll6cA1ltdxkGdVnG9v2vDca3WQCXsdHSgBWMzyZqttymXP0Q2qkYXncbxoN16/uRYa/FBizRBXCHGYipq/RIDQFcSgrLXjAuQlu9NjDERjQIGJ6rMudKga88gafcuEuyTP4Wa6fELu8E7qW/VZZffVc4CEuChaS2f9QITYEuk1sf2IlVBndA4ZvhO6HJp0j8dpAdxfBWmcx0hTTtOBZd6F004Na9D6DI5pm2/kStYXXeku6DLnaH9jeGeJ6/zHjRDxvuhtLmg4ewKlOtJapinM+noDAStrlqlIwN6forNb/8QAJuQ8u8LSrcjw5NmyENULn9ba0I2XdlbdYlimNyYR5Qa0B0L6bPYSYV5LL0LsPIS+vQM8+KORrSKGry89yA+lRgYDefOh1hwFIfGEcUHV6rx7nt9Qkwl2tTLpBnIrFfTXh3icmNKI8iKOun9EWfqEm630EW7RML40Uy6Wd0OdJrftQdI+Y0S5SofwnqcsCNBQ4EP7crRJtUJrLNgnR23wVdA9uN3rTQdD2Q67dKuQBJFotrkRv392vn70+g7loUU9aHl6EIK64VmeabaTSgOJmJw66XgEdiw8LedTvOV7JxGkng/70QKCzJM3IVz3AjRYq9nXgtXtlh+TZvOnXyTtHHRRv/OFq4vlZsrA7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9kT2QYhp0g15PhcXQowBccWReMlKfhAu+Ncaa7XfDk7OoGaZdLC9RfgpTSbj?=
 =?us-ascii?Q?JfXaKFUG17l2XZ5HAVeoLRU5TWXd6GLFi/x0bDFX7yYIgEEoZyIyq2dxhnQa?=
 =?us-ascii?Q?Ys4cFiur9vLmRG0heitBTQn6mZGcElstgVQH9i/UhVXW6E/0aGArZ1iXwdUv?=
 =?us-ascii?Q?WKQp8wu1Xtu1UOeNu98KupLmAiSfjaLLOJ03yoSvLSkbV1zuQRG0G53nA3wx?=
 =?us-ascii?Q?8yqhKaGgSzcMMGpnoB7EkaRtDHE6a/oydUfWmWTdi4zFTH9THlLGG/V1ODID?=
 =?us-ascii?Q?uiuzM973PyEmkbcX3eBfWGsU+OZN7RlwZk9x5gfwi0k273oZpWfUTYDLpHfv?=
 =?us-ascii?Q?KLyEdvcuR5tzh0p/Q+KHkPCxf8s60ERhVXSPiMsfAEAu9aM3ThJ5pnKCnxaz?=
 =?us-ascii?Q?8O0BpLKwNuU1c5+oa8nR2F8ZGazhrY7lj8pSqmU6PH24OVKmXjnxPQwY2pkj?=
 =?us-ascii?Q?4c8hGg9wplxJBiiBzg+Pw2p3ABEcSnrIjRbYm1kKx3XHwR8FNGl777sLo6YJ?=
 =?us-ascii?Q?SnFYJyhNpNHWwHgso1x3lSGxUd3etrwJa/drpVJvP2gqjYx9LSMxQRCswWz+?=
 =?us-ascii?Q?bRne9rpOEb+D+BTfodOe4ZfVO3MHP25JYIYFSU2EC3isj+9PyAflRotOOdmt?=
 =?us-ascii?Q?OIm0X/nH5BArBK077bT3XZzt7cxDjUZRqx6nfQ496WtEoxo39yPXchzxBkZV?=
 =?us-ascii?Q?NYGaCFHaDyh4iYr1/VS4rvayrcEkND7mLtZKIGvkUwGEaznqrqcLENWVUUu1?=
 =?us-ascii?Q?FE92k648tXgA+7HSuFTKc+npQ4+Jiwy1Zhp1gU6UN5NwIpxRtfT2vG9dZor4?=
 =?us-ascii?Q?vPalWZjovjGGIdObRK3nCxpeuLoWvgQXC998a1oewqGIs8l+7THS/JavM+Av?=
 =?us-ascii?Q?iudK7sqpVHEBdJnGqqhYEci4LzFwW6T+ywjjBPBhRtAwFDYRGmcCASkyudkw?=
 =?us-ascii?Q?B+IaRQ4VEy0N0w+dOLED4hFcCERm/DF4jytrdK6grbxE7b6T0Gyw/As+Iakj?=
 =?us-ascii?Q?+jOL9xFzYPVcYvZcD6eY/qL8RJQDOtegeqM72dI/Bz4s5QV4AzAZ7kngiF+1?=
 =?us-ascii?Q?htWgEoHXfg6RJGHSFkwje7zGlVG2j2E1AMW9awmOsRoDrUGasC6D5AnyZ6aF?=
 =?us-ascii?Q?39sJrAKJ4bPWZqFRNh9u97tMuMYHpaJZHtTrxh/a8sGKzLlZFAY96xcx8+dU?=
 =?us-ascii?Q?2vyzJ22/JnLtU/YHq2Ao8KLlSJTfXzMh6m9q2ie+/WLnwpoxeKqJPI25LaCL?=
 =?us-ascii?Q?HAfaH5Lo1lBJv5pSFJF1crNdxKOvnjb3AYhBeyrtCbOjdj2IV6Sn8MQwELq4?=
 =?us-ascii?Q?cNMgw8eNW8/5eHI7m/4VCnBSVz03+rGFFfrpQaTpDlz1IejrOyzvdQIRkDUz?=
 =?us-ascii?Q?m1dvZ1dOeRWK86Yo9hoHjRp5lZ8U/SDICrpJNA1Sr/Sik7sZbisRlxrftq3t?=
 =?us-ascii?Q?J4jmpLxtmHwvAkgJpoVCNU2yhjxeRN+dpqm83l0y2w0D41NzBTtxC7z/O4DE?=
 =?us-ascii?Q?R8ujxH86qA8zNSoBXYRQN9gWY92JBFTrGOWNI6h0uXYx4f2qeD92CZJRjZvG?=
 =?us-ascii?Q?Dx+mSyikd5eY0MjObtcO2LLMJy2JlkUEaowpOMrp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ba35b1-377e-4673-2752-08dc4d43c96b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:21:11.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: if6jrXAgXQvI6anHc0hl9mKzcZSAb+LHVQvUpt6iLyBw5c39NUcb96BGj9lPWzUG9JkiO6IP7BVt6HoLhC967Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114

On Tue, Mar 26, 2024 at 11:45:40AM +0900, Yoshihiro Shimoda wrote:
> Add Renesas R8A779G0 in pci_device_id table so that pci-epf-test
> can be used for testing PCIe EP on R-Car V4H.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/misc/pci_endpoint_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index c38a6083f0a7..2fa3c6473c7d 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -83,6 +83,7 @@
>  #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
>  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
>  #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
> +#define PCI_DEVICE_ID_RENESAS_R8A779G0		0x0030
>  
>  static DEFINE_IDA(pci_endpoint_test_ida);
>  
> @@ -1005,6 +1006,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),
>  	  .driver_data = (kernel_ulong_t)&default_data,
>  	},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779G0),
> +	  .driver_data = (kernel_ulong_t)&default_data,
> +	},

You use default_data, why need new device_id? I think you can use 0x0031
to do test.

Frank

>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
>  	  .driver_data = (kernel_ulong_t)&j721e_data,
>  	},
> -- 
> 2.25.1
> 

