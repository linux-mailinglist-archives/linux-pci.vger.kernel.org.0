Return-Path: <linux-pci+bounces-30120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A9BADF5B0
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 20:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F1C189F0CA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C0D3085D2;
	Wed, 18 Jun 2025 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e++L8v+G"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCD2F49F1;
	Wed, 18 Jun 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270777; cv=fail; b=Ex3He23+yo0QUjy/QI+J6TUQGu3sNFfqqsaggv84J24VZqrLYX26JNF9JjjRoq+gxAo5Lv3NRzcOKafiruZP8Amkxu3DD1obguW3sLA5vNHkgmQtz3kMBgKln1QFq4cWzW9aVaBQ+rpvYPfQEY0E42+EzCQX0wlHVEIYn/5MsGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270777; c=relaxed/simple;
	bh=ZEzG65Nenios7jyLTBT9tMsVymV/FLqx50FRTVLCnnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=np2MGsiM38XOl6xM38Rf0YQeAyZJAS6A9W3VPHqB7byNWmCFBdLcG/A2ZP8ji5tx+c1HZQ+5zJAch6lH/ky1Adexuf/ZEr7tU43RlnYz9I9fzca8QcMi4Zq9q0IU1SsxKlm6LkR/WEFD/EkTFcJPk3geExM6DXw8Mf5RToz106o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e++L8v+G; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veMUPxssLVMLpY4hS2W/N0PtgYkRHu/GOuip5G9nJPvCPehX3OBOxzku743/tYD6a5DOVyM/Z8r1ZUaWWe9w+SK8APEP1ZqKayHWJWB13kH6ooLK8EGli2/vEnjEBecKNpIQrycm3pgLxgGS3k4OWXqD9qclObPPIPTM/+Sw5m3I94SIQdn5aUlNXP5dd0LxdcKpbrigPFYoyuVb7hFdb2QgA+7SCmOSMg80uFiHOT3wa283hxpnetVRq8sElM9CH+57jbX5qzpot9BwFYayeR27tXpzFfW8dhHPcjQj4zJO9l1XXGN8ZKvlnX0fFj8ZVuWWHI+h4k66KKi7t3Dbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0I9Mk0MWGePUFXLnt14ZYQskQbX93C4GD65YuI9v3k=;
 b=IiwU7WNkU5avNxo978fgCiWp2EAEY8ChXFuMEDEx/MYtskOZQXjHPFoOfbTRQgeClzVWgEwSh+ik6rGUikU3BZAsnCGO89xK+vPwPoo0cUu6yPsCBW8GJd+QewwgikNA8iwSZ8DDCfJxbHEUc8coO8DvUa+3dyN6g/x8vv7VtDlYBaFR1Fj/vuiBU2HSWs05sBhhcOTBaK3OerXT6gULHMaZEcCd3hE24SuiF/RbZRw/kOQaAabFDozNrwblQs82wzSsiZh/ru4gtsKP9iiPztgiFRU6FkcDhjsvUHnVfrwothVc5AKrcHcEFrdagZf8UD0jni0Hj7xR0T0H1hhc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0I9Mk0MWGePUFXLnt14ZYQskQbX93C4GD65YuI9v3k=;
 b=e++L8v+GyNodD/YrjIdZ1FeDRg86hnQT4stv0WTBOL0gN8CIKgeQDrTSFkckj1dFofA8W6c8SXYFmLh1Ullb+1MWu5NcR+6V2xRfJuK/YAuJPqIfE7yDZjVV8rJxz5nxZElYoV/lpEUNQ8VW61Af+Q3vR2W/SaOoY8GjCnjrlXRAZcYlM6KR+iB2JbCCkCFPBequdkN7eF/P1h3iyLJdPtqdzjb0hXBgQkpI9S12m17re96BDurfYEllsSdPm/q+FXNzfntGLJUZ3itQ0XUeCoGVAi9lPSsICB8VvAP1n0AYhWSkK3OPOlI8WOFzivRb88wPnU+fa63qbIDj7HH5hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 18:19:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:19:32 +0000
Date: Wed, 18 Jun 2025 14:19:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: dwc: Skip PME_Turn_Off message if there is
 no endpoint connected
Message-ID: <aFMDLIEzDTw0sFa2@lizhi-Precision-Tower-5810>
References: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
 <20250618024116.3704579-5-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618024116.3704579-5-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH7PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:510:339::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe0efe3-fad3-44b3-376c-08ddae94abd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/fgOf058QitKtmS9ZAdSMbUv11FgndCQJaUP0s5FPP9PD3y51WDdEUqRrxz?=
 =?us-ascii?Q?KHRWKhFIKayCT90jw9Y5DH4dm2oGPF2aKx8OTnBrKObLJXDMGFzoVxvTuRaH?=
 =?us-ascii?Q?OhLTwnYZdtJHPdSHjmK+IrRUj5yY0Dp8Zvm4j75jz1udueZcxg+EKCBXt4l3?=
 =?us-ascii?Q?xN9xqC+g8zMenBiEFSq+emOgyNLOp6A8tzF0ys+MxOeVZPHSwZFBx/hP43hv?=
 =?us-ascii?Q?vvXxauUT45M00jhtT5Kuo9UeizF+GWLreQCItH1Buus+ZxfqFikbVdS0Fb0F?=
 =?us-ascii?Q?hDVUewEdW6s6alf18e9Kq/CwBYwmh956YLQNXFFB8yS3JN2Dp2m1oeu1tElo?=
 =?us-ascii?Q?5OMQLSjmgMjnBttNw6+ZXeOzOFPOIRzDZAX9uatONZ5m7DaOcxJ+83HCiBDz?=
 =?us-ascii?Q?3+elulPP4H4jul36C1ahAoR4zegJ+ytYE+ZFr3tqvetgr61CcBL6WYoIfEuh?=
 =?us-ascii?Q?yhDuT1ICz7XcBf0KN06Xh/yIPiR16sEW/LI+TD0ENir1yxnxkCkaogGO6w92?=
 =?us-ascii?Q?aaf2/iVfcYXwp+5gF92gQ4XSUgCQkycEtw14OMUaaiqsTQkHrrz3L+PRUL2C?=
 =?us-ascii?Q?ddMrIq6/fzGDtIE1biwGa0vRP9OcDbhJN4yqrR8TiRxSe8L9lqXJnkDNfCrV?=
 =?us-ascii?Q?Ic9me53qdTaEcL69Hmc8x3bp2izD1m+P0692ttlAlpv9nnaPMDaVBxyQu8Rd?=
 =?us-ascii?Q?paiFhAZOOBuxn0BnLsLCheb6Jos/ZPxK/XOOLARALaCzqwgo7Ys+b9NPWrEG?=
 =?us-ascii?Q?GNTw7TLp7RzAY7vJoHwqAufIVLdM+zCjuL7vmlNROQNu2G4McDVJSjX66qic?=
 =?us-ascii?Q?15jz+8kVWeN9WxHF3ro8HacA6zPhZMGSx4VYYoeju6eg2DfjqO+1DUH6hvOV?=
 =?us-ascii?Q?hz0wWIUYjSqcueZsYFRb5kcw9633szza499g8KnbT/uqQc7TaSOXpV88HlNs?=
 =?us-ascii?Q?rP2D847ISPeufHhGGcPH6pzTSlLaV4H8y4SSqWauaCLwI8dg3Q/B6DI3Vp/Q?=
 =?us-ascii?Q?syS0+cawPyEhRJhYjtUh1NmNXB73aD9wN+JSw5KJCwBlP3I37I15+jaa5/MA?=
 =?us-ascii?Q?H7rW2NXaT33t72ElkCfbsXXdujG87d3QNRwhIPHi6BujBruShp/quzzzXBJd?=
 =?us-ascii?Q?89VyotjeT2KM3b9iPckoCmpBvlPWDHgHf8n/tA/IsbQzUSMbwf4RwZc+zi7/?=
 =?us-ascii?Q?AzaUaEDZAvCEaqpKgFZZWVe/CyrkFFUhqgJFqhaHthZxnV10NfHAAtCg9Iq/?=
 =?us-ascii?Q?brTXD8ZQuftvvlZDi8Q2EoZK33WSioUgi//7hwBwuiLXxSDh9kBDzIb1NTtM?=
 =?us-ascii?Q?nJ3rfn/kqAqVcbvYFbKfinG2/tkckJxvwArsp4GcWQe0Jlt8MxRcefK8pig+?=
 =?us-ascii?Q?V9LesgwWtJIroqX+eOSZOVz1H+n7nn5o+ffn1GKUWwvLonrjwQatuYqJMEU3?=
 =?us-ascii?Q?gkKh89M0ZkoqBJGNfC7Gh3d/Vppv7WEpqYM2aqpsg6uy6eSfRKj32Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wP1iW0s1u0p4fV9wFFdpFAljpmJHDLlyCYHBALt65q3IhqFAgT5lcDYyWos9?=
 =?us-ascii?Q?ndRTdly+xLZ6B8GeKUoqmZGhLThvUKv/SXQSw45wbYzaX0MCABfcyO1fdtnU?=
 =?us-ascii?Q?ZVUWBnTkV9w/+7ooz0AsjYGbApMDRz66X1PBYvlGvgLEUtr8o2WPyt6B10H/?=
 =?us-ascii?Q?7GTlb1R5KMOA9/eLut0eU1m4gvQeajfI00UkdyjWihN81hjpEuGZ+lI8bPdI?=
 =?us-ascii?Q?wUBc5v1q7RbuazR/C92jj+wFwMJFiNHXqKKRAqq7hpyJla6aPrPl6fc1Ic5A?=
 =?us-ascii?Q?dHbsIooNeaKnWOri4GBgtcYdUYyhwBGre0xbGVdyaTTp9Rys6qS4iClTp+iJ?=
 =?us-ascii?Q?iIE3kVpVeEwNgA9fiqvtgZ66CXOgkc/j9f7AMMA5uJ1wodh/gpbFeoKonkSg?=
 =?us-ascii?Q?jtFeCjKrCKK0GW77EWLVli+vD40hpVdtCJqPi4WlWXRNCgEYnmEtZjz0npMo?=
 =?us-ascii?Q?Co9apo1+gJCOrVRkm2b//H0Vr73uWf9HPoRI5TE3osuaGRrL/J33t45Jn7yK?=
 =?us-ascii?Q?Okvhq/Nisn0NSBIdDN1PpJNjlVxQnua//0xyLvlZsUvTey8XIbTOSQLWnNn0?=
 =?us-ascii?Q?CVMwtp8OnstPG1D23r9Y/oKuWGBABEB+5YtFr3cy+H5Vj8aUPYfcUPMSlPrf?=
 =?us-ascii?Q?faJkciv/ZhjcvD4m1v1lVpvzuGsVL0yJNVwwqXtwdfu9W4f4iwrGINx9Owh/?=
 =?us-ascii?Q?gYuEuX/xGCk4FfwSTe89afHxtpLdBt9C7D9ay6yATwQ6Af5Ab/kpRdb5WIYL?=
 =?us-ascii?Q?qkL85xtGizLuHPfs8cvfIOZn5IihhvTI8q7zX4kbz6ahnU2lIQoUcVB5DW4p?=
 =?us-ascii?Q?EZoQuMlMTeqsAJ+P5KYqKgbba3aUvoLlpbBjpfzyerzowgM+zgBwyCAW8NyL?=
 =?us-ascii?Q?S31dvVBMisPaVfAG1H+KvQ8uF6w4ebt5QmYpKj9Wts9SfmHh39fe0bxO+b/q?=
 =?us-ascii?Q?oxHP/E2RYpOTJLPN1n6ZLDB6eJoil9wXsOy/Hz5QpYxipfM9gGADSEpgHnqo?=
 =?us-ascii?Q?TFBnvktp6QQqOUL+MdPPJcmCau+YkkDa16rS/3IIMumAT+Iw8nCC+ivB1cab?=
 =?us-ascii?Q?+mfO4KkQ9df+C/iyFJF3kTMm99WYYdqmEtg72+pmejAklIJvZkmwlukqH7Ns?=
 =?us-ascii?Q?SZmefQDcjOTYA2BsMzUAaxxoGJpYNW8880hS0EaW7Cve579+5O4/IphvQYUA?=
 =?us-ascii?Q?SFzAMJq2UvJU30+IvW9r5XHOiaEZj9/XkVtL3IgOajXzzr8L8NTo5Vn2XdRM?=
 =?us-ascii?Q?yfGml35XjwI37qJBCUnad507pPGbJakWU3FW8GAXouSDBBVxlWFi2XlgWzim?=
 =?us-ascii?Q?z9A4hnEYSTpf8lteLpt3FWHrBytTRfShKJWjCCTqF4CxdJ8eUKzyour056OM?=
 =?us-ascii?Q?rMjyVArMmbZ91Y6eKn7pgO4g9RdTqC0EdkowwufcufP1qM2oT8uXCQJM8JJW?=
 =?us-ascii?Q?ymDpVRrzQ7uKgx7LfbyMXx5TlLqKwSluEsFE5RkWSkd2+oK/tPSPLeIHHUSg?=
 =?us-ascii?Q?YAwteEhA0qbWhGBAZXf5fX9EDMmDB/w7VRWSIj/S+CJQKcyFALyiRvWalfIX?=
 =?us-ascii?Q?WXp8QP9cjWR7hcTjs+dL+AsWakTKXp66Vwv/H63j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe0efe3-fad3-44b3-376c-08ddae94abd9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:19:32.1259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQjdMHx/F7z+T8Y8Jw21VMavCW9Qx60IiOfjBcA9tHGBOW2eq/rdTnGcDKkT6VquxXpDtxfi8HNoB+UmSXCBTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845

On Wed, Jun 18, 2025 at 10:41:15AM +0800, Richard Zhu wrote:
> Skip PME_Turn_Off message if there is no endpoint connected.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2d58a3eb94a1..228484e3ea4a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1035,12 +1035,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>
> -	if (pci->pp.ops->pme_turn_off) {
> -		pci->pp.ops->pme_turn_off(&pci->pp);
> -	} else {
> -		ret = dw_pcie_pme_turn_off(pci);
> -		if (ret)
> -			return ret;
> +	/* Skip PME_Turn_Off message if there is no endpoint connected */
> +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_WAIT) {
> +		if (pci->pp.ops->pme_turn_off) {
> +			pci->pp.ops->pme_turn_off(&pci->pp);
> +		} else {
> +			ret = dw_pcie_pme_turn_off(pci);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>
>  	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
> --
> 2.37.1
>

