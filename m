Return-Path: <linux-pci+bounces-30798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041F4AEA41E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A8E4A832D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB72ECD12;
	Thu, 26 Jun 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TNObDmdM"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0623D2ECE84;
	Thu, 26 Jun 2025 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957849; cv=fail; b=ZXNFbQwZS/OqmCHCdQeSkOodhTPCUi6DqLirqW5lPdRv/rQ2dbOJBbcwpDDuNQViZSdn8p7Sg2EecSZhOyDjpCtKdiVUPKaiPw6rgsB3k4S8q5Sw5VAaQfBAYdXdOC3bpwu5Az0L9qHyeF0rGSNhTvu18b39EJFXuFixR94drns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957849; c=relaxed/simple;
	bh=FxJQuUyhEArBmTYSVL89mNhjvHAJ6Gkzjwjnv8kGyAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IOAl9mQ4ERbSuYy67ULxDUGC7vMlXTmpVYoD7Bc3BoyTnkh/Bx5a5R/JHljbMnn6G0n4WyZ6WCBTJonKNfocjuXcKg8xQOvw5So/j7o36syAV5mq3TodpjX3x5IHr11wObmOIP+RlvAs68OkZgE3+i/p6YPUMOQ4nWs5nai3Plk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TNObDmdM; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSzX+V+S67cVRlstvQbqnzbosgd6NYw9xgY/pUr+2iUrirk7/3lvSUu/NiAkdjYTQTYitDsknCy8JpKtK6w0V6SVralraTLJrFZWyqFw2KJ6nBHvPPpiDA/wTv3O23YaZVzfwuGUrkZXakl4vNgJIFU0lL0NKWx2O4Z21S+YzVVVN3mUXy323TcVOXL7y0g6LjKZM8+WZNAkoFpazkJm6JQeS00QlQhUJAK8QczMFtFrTz8Wg+7FWAvaJIsOJyg0qf3ebfHdiPbN0626uNiAPFaQrgyAhO8zK7NLQaxtRKhtUgaEvL2Ms7B+irX+DSNhrCs7H2rEVxh+owoq/kxsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMLRaS7zetcMsJ/uo849rj/yD1ej0ZyGWQKmYh+CLII=;
 b=vLjiOyMkgEw3PJk8x6TbO6CYVGbSi7/WHwOzhJrH2evKwtSBHjJMD0U2aw9GCOnPNr+KX8LUFOJHJNlabYTvuXiwKcrFZ1jH5CGbbb1XcRgCuc/CMKOGUg+D+ewISf9CeWuDoadzfmTlB405ns2mirueXxzvpHgyXAFgyWDQUGgiP+XXOKGDU/HwdU3MnwYEeGvPWYMpsUJ7GxIztSAQ0plmo26ysKgJjPYi0oPBVF29cp6xPErfCkoMcJli/Cl3naPutmNE+HwhkAJADr4A9/7OfCKDQxM+/pfQoKXl4JtCMI7+39p19vJrguh2yQwn6mPAIXApD5AtskGTNIHK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMLRaS7zetcMsJ/uo849rj/yD1ej0ZyGWQKmYh+CLII=;
 b=TNObDmdM9/Kw7M3bIp+97vIeUP7nSGb2K4MI34D8W6ddUqsryvEx8raa4QEioQrnmu0TqhnLaHl5qPZMGvMitlQQ5OkyZ3lM+OVmvffj4BVN34Z3Ph/SHjVkoGdCckFunf5hOb9sCFLxwg3tZg6dJXtb07sK8INNIkoUMdANT+bTI3TOZ+FfFbxeGJjp/6zHsUiPBLl4CJPnROJ98zJTrxC0MjBaXPuUUcKzy4vKSLTu/96pkdH5uamBy0W3HR3/7Z0SeFkWK3VQ0cuB8J09suVD5R+UNruTecp77LGPLgMP5feDC99IxMn1JeprRcPWCOFuM/F2ki/nbgkWSQDaCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9397.eurprd04.prod.outlook.com (2603:10a6:102:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 17:10:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 17:10:44 +0000
Date: Thu, 26 Jun 2025 13:10:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/13] PCI: imx6: Refactor code by using
 dw_pcie_clear_and_set_dword()
Message-ID: <aF1/DzLRRhtgFVsH@lizhi-Precision-Tower-5810>
References: <20250626145040.14180-1-18255117159@163.com>
 <20250626145040.14180-5-18255117159@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626145040.14180-5-18255117159@163.com>
X-ClientProxiedBy: AS4PR10CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 1648e079-a87d-4dcc-297c-08ddb4d462d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ROQLId3j53UaZX1j/MPt9ru1SiWlpUdOYIWN4j5NziXnVjvQGxNpfKUlES7y?=
 =?us-ascii?Q?BcYZZ7h8P6NaJrK8Y4tWXVBBpWw/GwArZLEsmJvq751lAQe+r3dAIHFE+6Ug?=
 =?us-ascii?Q?s4EGLuqsNk5jAD04GeyBek+emgv8dmMhAzWVCzu8hC8ionq9cqlXXc5Ni624?=
 =?us-ascii?Q?ozROAKEJ4rItmQPr1fuWkMR7MUs9QTHULDK2nFauLQn9dmFqpW8cFlyNUaw3?=
 =?us-ascii?Q?krF7Fyb/KS6C4xoUPuhVdY+KzLOuXpboqxYV/4k+5IcS2pDFrc8SMVfkNZcC?=
 =?us-ascii?Q?rxq8bS1/vvGlFpD6eI23+IHLayfqzmjRrl0S713pSl9RGM/P6a776JWM0Zqu?=
 =?us-ascii?Q?KAu+qsl8ThTzWKVwvYG7yVJPA412ZuN0MHimIk0CZD+nlH+vOT6eDeqw5A+F?=
 =?us-ascii?Q?mcy0l98V3jGeDxYeC0Ec5p/nA2RkPBCg5WsPKWZeRozx/wst5E4Oy26w2ljR?=
 =?us-ascii?Q?sXe9IJaWSd3MbvXBFPNzK6XFNKMZzD02gRrnocRPuDeEIEhx3tffSBnjwu9n?=
 =?us-ascii?Q?M/rQISd6xwD6T/RslFHeSt5i4hizS2RC7UPJxWZn9vYawrbdXKwfqgLtTTfN?=
 =?us-ascii?Q?FDOpJom9XmxwCssgkRxXIKpFrXrip6UZWd8dlMahfId0yLwyj6/otdbNvgV5?=
 =?us-ascii?Q?l27o6EU1V9T0+vDYCo2nEHU54Poh+TePDwhXeIpM0np/SlbQapM4zNnPXGpo?=
 =?us-ascii?Q?33chmBwWLv4ZtPgENMT8AwQef5bryBwIUj+6jiP0xl+Hr0ac6wcBm7LlQmkl?=
 =?us-ascii?Q?MPlhyhHYiYQv4qAkpZbBjVluQft34HYyRVaBzmHW0ew2Nrj+Eeqf0jGNAUd8?=
 =?us-ascii?Q?ZuXLWMtLdhY7NfTZwg6puK2rnjjqApAOE3rdb/ArTRpVyaTP3Fev6HX7RZWz?=
 =?us-ascii?Q?2DVJ2znmovqFuBoly4nYKZyrchou/cmZ91XOftAoqaL+tu2SnAKQHOaviqoK?=
 =?us-ascii?Q?YR/bGQKJlRGUq6cc0T0MR1XQbjrFEfQM7G7ZqlkzM82NJMFIkS1w7LoeeDAz?=
 =?us-ascii?Q?FyVeqJNKBnJhsQmP3eIWegv5K6ommTUP5MIqZPhlb2frkP/pcKed/TXKA3Y0?=
 =?us-ascii?Q?k3VlNdZ72C9TK+tzJNZBLeIfd3I7HUCH1crKkCPo7c+hnbu7SKAQmsXIUI3q?=
 =?us-ascii?Q?3gNjcOdAlEFGBe/zgqYgAER3JKQ173P87HBWrtu4iiRLduW6FKyDtYP+KE7N?=
 =?us-ascii?Q?tffUL5zSVtncXcHrG29JM5usZ1MUC+DFu2zUZEgzjgDZiMlgrB1WjKOIrgax?=
 =?us-ascii?Q?sNVQymF9/8oPoWGZktQmtoH9auh+7OaClL24gkP1Qd+9+fz4YGtSXNtBZTeJ?=
 =?us-ascii?Q?kv0Jspaoy8a+qNFw2p0pnS7xdsUSSqsOK0baCzH6eelaYFnwEGMRh+YtlXb2?=
 =?us-ascii?Q?FSTmm0Sx+oguHIEw24zeeNfNwmJjgRtjr/LNH3ADlx/TfH2Ezqm2bncDd31h?=
 =?us-ascii?Q?FdwCg/qNLT78FIpc9LjRX5Ob5+Zl6CKVIecxBeRuq2SlAVv8dpjFfg95Qy5v?=
 =?us-ascii?Q?nx2ke8KXuw7tcgw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VJOsVzxukWpBoFzwYfIrCpPeYg0AqOfG2oxkg0UOmHBiULqovKyyAJhvpxao?=
 =?us-ascii?Q?r1zOOpaWABLzNLiUfEYkZMAeGVhFqTJP+qJP4hyWUSbvNbDFJYs+EhzM+p7V?=
 =?us-ascii?Q?dCWYdHSM/FFqsCGFIRQLgBHokE8xxMvhTLWAd+cMVXyIIsrpE2zAQ/SYqTPM?=
 =?us-ascii?Q?5ZgD9Feodh7mKajVy4xmnDsTFpsUML+9maekdZCRDE4aItShKPIATvRrSgbp?=
 =?us-ascii?Q?CYFQX5wbEFAyAQbgCwXlkUf7mVswv6A91EfvBirasrj8mxC1ngrDYmyzjTjJ?=
 =?us-ascii?Q?l2+0f1m20RmFInfsk2LDKhf8BxdITn1Cw++ZiimKE3qZm/oRfv9yDlD7rYJV?=
 =?us-ascii?Q?mWJoiydDfMeKXtE+47HXkihESlsINl6djtVDJPIhPqsdJ4+dP7tqjp2i/b55?=
 =?us-ascii?Q?nXjxvAKNRLaKZMnYVHRYW2ch0FQ8MQ6DmOihnvtMzl/vdI9L/sP9WkIQ1WZ8?=
 =?us-ascii?Q?pHCGIDai3p8xAxXVsVoptH13F6KpfopwCu1IpSZYvGdhwNjJYYqdGR8pYiVn?=
 =?us-ascii?Q?Hye3rJWNkf8Epo6eLuXTBPNzuP8kICUb7WlGKmx7UPzFy6nHWttmlxacJREa?=
 =?us-ascii?Q?qLpuxGqHxrJz0bhC80D5OILAwPm9UQ3r8+P9BWCyBi8oF0zSEDZlTyF86+ak?=
 =?us-ascii?Q?8QpUyp1f4ftD/iwrzNOQVtUbfw7ZPD5ulWTb8pkengM4K9xobOfdXvDMhQNz?=
 =?us-ascii?Q?L88FvnFo7JxrB+OfjiNM0026l1xtiYMMBKZFgjXTifuSdOrWfnXkUgA4RtMo?=
 =?us-ascii?Q?JdhQ7WGFOs3k1cl70Js1JwSBpEmFRHqMq+B/IWWJhwvCQStSEXYPjFOmuZdk?=
 =?us-ascii?Q?Lu9yT/iNJFnGFMO6d6nFGWxrxgzEwjGDsjusPmvAnlJWskq2MlRBDMYJ9DvP?=
 =?us-ascii?Q?17lwHDwS7icJuNYJba8HT3huVbl/LkfA4RmRiL84hl8nWlHW3pydO3+a+U+9?=
 =?us-ascii?Q?pOboeSonyPS+m9tb7jRYkrTf6RZCm03VjeodA7ZUh9cJKH1uj95jazTqKMMU?=
 =?us-ascii?Q?qmnuZmX0Rg/+e0IQ+/xkaz2SsA1js4qpN6bQ4nyhZeAI6elBPk1tuxB+znB5?=
 =?us-ascii?Q?ps5Ujx9Uy7GiaeMHF2aJfw31aa+eVeCGinPJ9m4+Y90Mnjag45ndGaKBghU5?=
 =?us-ascii?Q?F1ZezQY2xWFeIgsaTPP6pWPtq8z3RUIUHF2QaQe8LgX2Dx1hqo1rw333UF1x?=
 =?us-ascii?Q?fE6h4dihreP4A4qlk/pqbapPQ2LgLl4cdWCcHq2zh0jc4jfSjqEDYj6RF10N?=
 =?us-ascii?Q?s4GrpEEwWcLr/Ca+RASp9xx1j+TDAzwHUxVhjXUSzHbJ2SN51OF6LHp+6+IG?=
 =?us-ascii?Q?hxd6tqXK5IBeSZ+5w1YWu33agbDa1uTfHA7BuscbA69NBZ9WetfXWWTkEWXT?=
 =?us-ascii?Q?pEUmQg4c+EPhmidwTBOqc4GFBPaYPRUyOE/t729CYw3aA2hWfPgJwQN1S64L?=
 =?us-ascii?Q?QB3DMJrUPpBmC+n1CSZEogGFXP5N+i+GDb9O//qnrv5Mgizo6qb0n1sc7C35?=
 =?us-ascii?Q?T3mgdgxK+NqQMyK8z+tHf0C381At6N85hLdZ9OaLUNi8FglQf8QHgvhmEYKE?=
 =?us-ascii?Q?J6tIplI/RsV6URasUpAy4lQK2JSixPXRo9rklZ1S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1648e079-a87d-4dcc-297c-08ddb4d462d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 17:10:44.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0l9kDtr4lYzy7BJXV/Cz5efEzG88Sz1AbN33SVhzf9eJ11t1htwbG7faOMNmW9ovvkBsNhUF4egxEC8JrAWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9397

On Thu, Jun 26, 2025 at 10:50:31PM +0800, Hans Zhang wrote:
> i.MX6 PCIe driver contains multiple read-modify-write sequences for
> link training and speed configuration. These operations manually handle
> bit masking and shifting to update specific fields in control registers,
> particularly for link capabilities and speed change initiation.
>
> Refactor link capability configuration and speed change handling using
> dw_pcie_clear_and_set_dword(). The helper simplifies LNKCAP modification
> by encapsulating bit clear/set operations and eliminates intermediate
> variables. For speed change control, replace explicit bit manipulation
> with direct register updates through the helper.
>
> Adopting the standard interface reduces code complexity in link training
> paths and ensures consistent handling of speed-related bits. The change
> also prepares the driver for future enhancements to Gen3 link training
> by centralizing bit manipulation logic.
>
> Signed-off-by: Hans Zhang <18255117159@163.com>

missed my review tag, you need collect all review tags when respin patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

https://lore.kernel.org/linux-pci/aFQp4MYpRaEUXNQy@lizhi-Precision-Tower-5810/


> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..3004e432f013 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -941,7 +941,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	struct device *dev = pci->dev;
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	u32 tmp;
>  	int ret;
>
>  	if (!(imx_pcie->drvdata->flags &
> @@ -956,10 +955,9 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	 * bus will not be detected at all.  This happens with PCIe switches.
>  	 */
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> -	tmp &= ~PCI_EXP_LNKCAP_SLS;
> -	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
> +				    PCI_EXP_LNKCAP_SLS,
> +				    PCI_EXP_LNKCAP_SLS_2_5GB);
>  	dw_pcie_dbi_ro_wr_dis(pci);
>
>  	/* Start LTSSM. */
> @@ -972,18 +970,16 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>
>  		/* Allow faster modes after the link is up */
>  		dw_pcie_dbi_ro_wr_en(pci);
> -		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> -		tmp &= ~PCI_EXP_LNKCAP_SLS;
> -		tmp |= pci->max_link_speed;
> -		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +		dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
> +					    PCI_EXP_LNKCAP_SLS,
> +					    pci->max_link_speed);
>
>  		/*
>  		 * Start Directed Speed Change so the best possible
>  		 * speed both link partners support can be negotiated.
>  		 */
> -		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -		tmp |= PORT_LOGIC_SPEED_CHANGE;
> -		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
> +		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
> +					    0, PORT_LOGIC_SPEED_CHANGE);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>
>  		ret = imx_pcie_wait_for_speed_change(imx_pcie);
> @@ -1295,7 +1291,6 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> -	u32 val;
>
>  	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
>  		/*
> @@ -1310,9 +1305,8 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  		 * to 0.
>  		 */
>  		dw_pcie_dbi_ro_wr_en(pci);
> -		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> -		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> -		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +		dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
> +					    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL, 0);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  	}
>  }
> --
> 2.25.1
>

