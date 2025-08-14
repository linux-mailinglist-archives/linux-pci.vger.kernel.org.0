Return-Path: <linux-pci+bounces-34066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F46B26F72
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 21:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6847ADEAB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 19:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A822C2165F3;
	Thu, 14 Aug 2025 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cqffIUSb"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E6631986D;
	Thu, 14 Aug 2025 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198152; cv=fail; b=GTI/1mcrU33qCGBF+DUj4MAeBkeOPKvCLfuMaorjcfSRnpJuZ2p0R0O7nEQMmnXzSSsu4gL9YILkKoWLKQyDSaLSo4rQyfpkRAITozG4B5uTs+Bkf8nXzc5zQCR1jdI6iSuvCONT5ctvErDhNdAgFX2Vn4XlhiGmG4FF7HR0XIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198152; c=relaxed/simple;
	bh=yC6k5uJaKX1OCp9449+fcLr5hepKoxR57vBeFUZHenU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W7mfbtIloTqOTOk62UPOoSZYPiTvoxkeJTClRz/tIdJhBoDZGB0aNx5vMOH0LarMDES/YM4m6qG3KuuVgDlBAIichSKqcOxBlYRlI5Ij/jHDH0HQN/rJ7u6ubudJ2Hqv/jIak+g5d74dvQMx+6Q42gVvBLX/bhbdezj6fvXy9So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cqffIUSb; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n79hs+fIjRDxsUZL/FLftVjp83b24ujLqiJo8Extf6dmbNgxb6K8uibP0Lvu54CnicyZ3hNZuafkq/YXISQlLGP+vxzj0TkBHJz6sPmpBuyMTZqMBIBqLjjot9p4SUq9MjItUjwkEzTDtCMo9sywXtma+2d8vRVIRbvrCx/LPK/+fNbcuL4iajc9+q8JE9oWPAd2xJ7AZncWVqS069CTvZGP6lTlp15Qpxp7HwPFyp/FQef79dnosgltGz3zGG9gMwI5RE1dbsJerT/4wKW2pPcIGFdXnYZ5ZaoI3KKRtRZQMStmYHodQxnD2kFZ5en31BBwngcI1aFt0/JZ5gHcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw8K/kYp3skJqr334lGHwwn6jeB0ETsGdF7dqU2Bw3s=;
 b=perYwaedkTo+6BKF/PEcKcF9DPdk3Mz5d6hL87QnZKx+hssTTTFLOCpGNG16rk/8ip7iina+NChttp5f3Gfsd9AlYHTiD1lmoc3+jR6+Ivu/aWFyyxdhzBPcrvBsQbxm5FiBeyzkuMjIP+YiQUXMBMEwb/O0nOUW/sfEd4qUZN3X0uTq86itlimagfO2UkVIqH7FCUA6+9OVlBLvP5piWoGDBqD3+Aos3A7VcoULb7KO8E4TO2vHg5GRFboq5o1+5etOpvkaDOqqhOjjEmH8SqWGPlPK9MkZ1ds/+VEFoNzP3Jp/1dx2NW0J0/DRRxy4DzniKHTsMWd+ewHM1AlWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw8K/kYp3skJqr334lGHwwn6jeB0ETsGdF7dqU2Bw3s=;
 b=cqffIUSbD6gzNsU+6dAEmYYeoM5HYgZK4I9a1GIaEanJvtIr4Tz79h5EpJol9m84+tmlwJOTFypNgByQl7RXjYPlwxj4YTVf9pfZ8VZjzzqAyCSMYwSiMrNtn3BikX/2T6nkH9DsV36AN63Yk1UnrIcHaGAjFTOBP256O1KaK6OBAEf6UE8xRhgPFzdvi621cml/B/Ad9GO0ZNrvHzI8UXSVVyYJ5Rx3jRlRO7vipYR6x9e7/bRA2oQmhmos0CJ7zI4dIkntjYsVK+pHRJhEnZMF/wmgYayyhaM83twqFqarbBrK0+dp6E4ZssXufitRJ6qfFIHNU3R9xVtyBgAZYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 19:02:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 19:02:27 +0000
Date: Thu, 14 Aug 2025 15:02:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Add vaux for
 i.MX PCIe
Message-ID: <aJ4yuo6bULFy7uAv@lizhi-Precision-Tower-5810>
References: <20250814085920.590101-1-hongxing.zhu@nxp.com>
 <20250814085920.590101-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814085920.590101-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 153f8fcc-0663-470b-49a7-08dddb651c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R+pNdvlxSeLQ5ggPXvGnuAg7Af1dQz643Hv64p53C6uuLuQASyP1Bflcow/8?=
 =?us-ascii?Q?xx7A8i9lDsscVCX0E+oqOuQJFhMhrU1kHoqlBMNiaJKZ79MDmkIP0bNqtVcP?=
 =?us-ascii?Q?FRH6FoYNZs4ohNaaegCqcFyg0dXwOCkVsxl+sRGDdU5Pv1+4nnSEbHeWJmPn?=
 =?us-ascii?Q?1JibqrN+btAVQYQxLYB9fNJlaeyLdITWI9nJJvobWxexYLiTCh9mtE40oDur?=
 =?us-ascii?Q?DkM4r/5MaVwtFGZNrXqqGYs5I6sgUwj1r15lXYKsT3OO5eJhO4zsgXNm5uNY?=
 =?us-ascii?Q?Aaz//ztComfFV4wX9bDJtMayowH2DR5xbRKHqtKe34+V+INyI4ozO9jebGq9?=
 =?us-ascii?Q?AERPVo+Yih7+LFyPjrg0zNhE272LSqkbGoKW4YDWM2O+0VBVqYzkNvrAWpga?=
 =?us-ascii?Q?IiSfoEcOXsU+JjJekVpbVmTTweJU1ZJYabmGZcvCBaq25k/aCRctpg6VmlBT?=
 =?us-ascii?Q?fZj2qNY8dWNB/fEDNO8EMY+JhuyK+kGuI2HTDxO1sIscqPtZVn5m3rlWBBLU?=
 =?us-ascii?Q?wDJm/+2AZ78HfXaOqwIWbVUDP39y5qO+nGS5bWczlHfEjliXH4EyPAGuGy/8?=
 =?us-ascii?Q?ZknXFNqF6M3VvivJAbtubvWQwOsZhF3+T86+LrXQvcrkvcP/uIHS2Pu5ohEO?=
 =?us-ascii?Q?cSXCHF+W2b+e6drid10QvCfiFEio2hpm7GIl2OSaRtCPtIOUCo0gawxW4Bae?=
 =?us-ascii?Q?WMfpH6u1CjhX70bKSRoK77RKvS+vvAtPqR4JcZQ55dCMtQG0PuGLH1ZmVWPx?=
 =?us-ascii?Q?pQA0KVESx3mhF7i3tSBDgLwNWavKBZYyAbzk0r+6ida282XesHzaxAJr5bka?=
 =?us-ascii?Q?YMj4NEUslzk0mJ9AvgOOYxbibRereqCStgcBz+mcDIENppyaKirKQ+AbsUP2?=
 =?us-ascii?Q?xx3+VJDJWzMsdLv2eKPcIIfYsFMZvf7xr8BktZDuD9ffgwrwGnIUk7g57TmX?=
 =?us-ascii?Q?BAn4GxiTcpXGfWykCqjeTzoEIJ9CiuwtIRzUhOKUYsGitenvb4joJxyh0/Kv?=
 =?us-ascii?Q?/KhuJnHZpx12Y+JhDUDgsl2cCWmidYU2IpGXw7j/x0InQsgWeP5zn3/I5dQ6?=
 =?us-ascii?Q?P1GNPT9yRzgR32YoxPZ0b9hVd853I7s0ELRRJKjsaz6OB9KD8Q/72f5oF7AI?=
 =?us-ascii?Q?o9fhmyW4ej31mVKtHtzZWa2grv1kFxrcYRO5iC+mIU+BUi+tdmJT5nkGO29A?=
 =?us-ascii?Q?/KSwaakoD2/z6KTie6tUNLpEIRnZ7rdJUbLRshPHXIdbYySvofoDRRsRZgR4?=
 =?us-ascii?Q?zpDBI2rBkBuNbrhD02qxc/zFfS0b37AYa05s/0WTucqKXNx+Q///eFQ2PfSa?=
 =?us-ascii?Q?2PUET9Vg5hwXMkwO67SD50I4eR7dAnvEdcDykPd2N6XO5efUlNOIsPiX8XkB?=
 =?us-ascii?Q?PMUhXmtmylpPIQi17CAqFEhD7ENGu3CxmwTAmyyRJrqvU6V444SUeQgaCQmd?=
 =?us-ascii?Q?3syJQh7v1k3ORKAkJt8uy1GVsHRR+HxXrHBzSO7UiehoYq6qaBm1iQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SIDBPIJMYkFo8NBIjaatbUsBTfaogxdePO6LsHuB09146DgwzWPbqwu2Qk8t?=
 =?us-ascii?Q?BRe+FqQM4GzZR+ouhGK71pcq1X5nyEK8FUMday9w6MJSkwWvalBbGfJKgKIe?=
 =?us-ascii?Q?HWgM5MFNqfxnwiu4SaiURrSFKRCeH+uqWr3q9EkYHKYMbhXL/G5p7OIEyPmm?=
 =?us-ascii?Q?Oqf0GVlusr6LU8PF9gtimXNXfQElBjPbiY7Vh4+KWarqsCe3ORzhZ5vHwVev?=
 =?us-ascii?Q?eM037KcxCBn3yBjxvPg+fVROYjZlGlRaptUv46x2DSeYUQuRTQOiTyduybQv?=
 =?us-ascii?Q?J1Vi0necCqPpw/vf8/YuqjDQ05a3boK5OVbfrOLB5Rluzwly708vZPc7u8XR?=
 =?us-ascii?Q?iIatkXELdihdNPtBFtaNOtE9++wNwGKeZ+9kBJ4gczjPL0mMljHnZETF7FER?=
 =?us-ascii?Q?W8nEZsx7cz32LtxLQLyj01YOnh191w+5p7IximVNfjmEp0m6loUzJytZWIfQ?=
 =?us-ascii?Q?2YSA1eUu6Z5zNh54tutTcMhkcNuybsKWXUp65fBuPzii1JmPuNc3CczOe3qX?=
 =?us-ascii?Q?pMd/9vxchkYhX9o4ppdoqhaeTX99JVHQxaGcTYUgxir+2q86nemaLhe09E7h?=
 =?us-ascii?Q?hR5J7yHyA2/3wgPVx2dwQZSfmloaK36egdHUr0KG1fzxxhAzqJ4UmKB6jdFQ?=
 =?us-ascii?Q?dY0LvFDNG17RbDBZP/CmrvFxgjgXaHnCfifxM9uSYYp3fABScyNRtGsnR7yK?=
 =?us-ascii?Q?HOJVHw9OOoD0SUkxY0MFruzKzoM+ogQuk/oDb+sKlJGT1PBb48iAHiJkZALc?=
 =?us-ascii?Q?SENDCjfHO1Bts75VQMkwhRFnwWrbyr7noWC8xMRdp0MCrPOV1Z1IvcCQ5hCm?=
 =?us-ascii?Q?4U+8Pxcgt3EaBi/glzZ9nBE1Xm75+pIKpxRdxunjjGh8LveuXa35Hotu5z3U?=
 =?us-ascii?Q?8PLAgoHvlP+vEqr/GOfT/lS+8ibgyiKST5bIEv6o0bmtm5/c1WONnxKKrKHS?=
 =?us-ascii?Q?/Z5cpwevu+ER5lAjW0sHRecnRqMdLbr8zpsExlpaicPqODjcKJ7jZ0MEcbMq?=
 =?us-ascii?Q?sJbalSBahXiHLLX1RArS8K93CZuwYQGBDtka/YUSwpAeymaQg1O4Agf8+uwH?=
 =?us-ascii?Q?e7qWREtBpK5td8+9rLOvo8gnsd++RcZ1DfrFmClD/koGEuI2P7RjD+tlKH8P?=
 =?us-ascii?Q?xQ9WgnjAGk4v+ZSDd/+yw/pjSfCI2lfcuSGBWYsiqBkDc4cZLUvJhj82Yzje?=
 =?us-ascii?Q?Rv8R72x9ww+NLhk2ReT693cgq7U5J1vxh7+tO6qftgYBfNib0QOyXPrCgpfW?=
 =?us-ascii?Q?ejt4AJwB8G95jCv//rEjK7AFK5rozwn7Ncsg+WgWuEHXOoPRC02yp1Tq6M8g?=
 =?us-ascii?Q?SR0lEGVzCfn/f7jl5oR9Af1LidfVB/C8m1e8+INRBmsAqhMDSnsozkjvcJl3?=
 =?us-ascii?Q?xIq1sTpB+4xkgqhIMhR7AwdmlYVsOm3v1j3E7GRo9Kj5dSu7SB3BUaqa0Wei?=
 =?us-ascii?Q?b/od4oaFgsqMewDUgv9HLAtntUZCiWvcbU5EyJj49kF4rEW750VULI/h5NOs?=
 =?us-ascii?Q?zMf2eu//Iau94wGOSnE7rRpyNEuAx74IZCUJMn5wyZ4frXogw4cU+C7MDYxm?=
 =?us-ascii?Q?StQJTwYLPE4sO64rq+HtlMFfg9GxvUcVzXAGMHKu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153f8fcc-0663-470b-49a7-08dddb651c99
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 19:02:27.6167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KLQ+qILbgouQAUrM9fVPimP2BjDSrzDg887m7Fel00CZD5AMa0tYJ+e5zPAX6EairOXxMJGn/3GOLDw/FGMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8906

On Thu, Aug 14, 2025 at 04:59:19PM +0800, Richard Zhu wrote:
> Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
> asserted by the Add-in Card when all its functions are in D3Cold state
> and at least one of its functions is enabled for wakeup generation.
>
> The 3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
> process. Since the main power supply would be gated off to let Add-in
> Card to be in D3Cold, add the vaux and keep it enabled to power up WAKE#
> circuit for the entire PCIe controller lifecycle when WAKE# is supported.

if it is standard, it should move to snps,dw-pcie-common.yaml.

Frank
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> index cddbe21f99f2b..13fddf731ab8c 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> @@ -98,6 +98,12 @@ properties:
>    phy-names:
>      const: pcie-phy
>
> +  vaux-supply:
> +    description: Should specify the regulator in charge of power source
> +      of the WAKE# generation on the PCIe connector. When the WAKE# is
> +      enabled, this regualor would be always on and used to power up
> +      WAKE# circuit (optional required).
> +
>    vpcie-supply:
>      description: Should specify the regulator in charge of PCIe port power.
>        The regulator will be enabled when initializing the PCIe host and
> --
> 2.37.1
>

