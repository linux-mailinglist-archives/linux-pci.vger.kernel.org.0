Return-Path: <linux-pci+bounces-23871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83F9A63312
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 02:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B963AFD56
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 01:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08536DDA9;
	Sun, 16 Mar 2025 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eRP8G1wu"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2063.outbound.protection.outlook.com [40.107.249.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A42F5B;
	Sun, 16 Mar 2025 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742087949; cv=fail; b=uKeXuvjDCnWCIF3lTn9ul4QwSR6Yk/iXolu7yBszj86fydoqWv5+qi/yICJlAZq/SgTNL0+pJt7FxTcwnRpmSNlOP0AF0x3+yPJfDYs1kgRkt5EhwGluea1KR7Yh0gdHsAqnB5CUF/JhLiY2r0PEDpmiCGTsmnB2JDH/njPqcTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742087949; c=relaxed/simple;
	bh=q4h8nTpTvgkYWwOAaXizqdGPAV/ZDcoC8WlREF6/wjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FweS6Idmg2gqujto0BXKbewgZCUqGLPwVAm3xa2ZWi0RsKZb2+NbPcmHc37cR2P89BUUv78GwPSxjw4Aq5+pWUsY0jeTsk09XJbhwhxp7Q9JOFeLDVZo1J5LOEA6Pd7fPDqC5Zgi0H1JgeDU3FAcUh0dapRNllIBZvhbrtmMNdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eRP8G1wu; arc=fail smtp.client-ip=40.107.249.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddlTbWpyBflBtC246bTXF1Ny3TSQPTSGak7vcNfUFB7UdakEQGGbqFHLlizbh+OGY/5gw3o5ylgaVRwvMWH/I8rKKKYrYIVrh7GpAvbM+7MSjZb7/pFkSf+dCD1QPlmdFlyVMxgaDYV2SIvD8WH8mwGWfLPIlD5iDc3ol25sGgduldMUiFMjBGYGldhK59Xus9U8A3eihLsg4OlX3SPbsFxOHofFWEYy/J+SmjiHRJSnPlrIFKHtZxB+EjnBOC1WllyWiXUggEVgl0x9pTbSr1Tyvj4ez4G6otrF3XZPOt2Iwlh/pnAjsqMLYe8MYAubUwQrLvhtFHvXSp532IR0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U7B6tlP+J+3Rh0ZBZ+RraCzqbC8iXp8AQiCAJ0s6rM=;
 b=h6GnXOMT3AyRfw0Cv9Hy+ZOKHag+OvIgdY40ObS9d4bpv2HibGnZSu1kOFwKQvqX2AbmhTXzLFZeoEfSpONtLXz+cOLi+X0xkN4K0f1n0IbXXmEZ18sH0K2qkaeTxXdaIycY/Dpze7mUx5EoKT8b6uaDLmHeJx6vEoJNgFJCjYQPfJZHrYJePDHbWPoruDPK6INV35r0unrf+0dogtO1eb1NIl+C2D6i87PmVvTBC2O/r/epwWX/xnHrZhWsiuD2zZ/jIOzoX+woeXPuzgNmOrq3qD868FMxiDmGQxg86sFZ7QeY2AYKk12l73uuA6z5Ux84kfGNFCHlQsxmoRIfVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U7B6tlP+J+3Rh0ZBZ+RraCzqbC8iXp8AQiCAJ0s6rM=;
 b=eRP8G1wuSvvKYejPlea6ExgVPmn18j1xhKhiZ195knGrpLCfKdxu90xzdelRrplDEby/FZofRG5kPgqH54yJiCwODneNvbEXnvxILW1xrH26AkCxl7yseRI6EvG5G+lntNCHmV4ghsaUyggyj19lN/bqyvz8IFXre8wa6DacRprQ1cRr1GHO61UvN1NElnpqD3rM9IQ9UQXtPM0EY1XkzS7u3xyjS9bTpC7hGH6CycfigvI9dBnB7WIyraeKoK6lxuJn79diDNZ7JryLD4RiRf3jQ1Mj1N5ttSUqvmOX7o+bL6SvimgapKv6P0FWZ5rFX2lackejSU3xF98JGU9d6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7005.eurprd04.prod.outlook.com (2603:10a6:803:136::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sun, 16 Mar
 2025 01:19:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Sun, 16 Mar 2025
 01:19:02 +0000
Date: Sat, 15 Mar 2025 21:18:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 04/13] PCI: dwc: Consolidate devicetree handling in
 dw_pcie_host_get_resources()
Message-ID: <Z9Ym/MROIgAOvk+8@lizhi-Precision-Tower-5810>
References: <20250315201548.858189-1-helgaas@kernel.org>
 <20250315201548.858189-5-helgaas@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315201548.858189-5-helgaas@kernel.org>
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f002c3-ec0c-4c8e-32ea-08dd64288962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mi+N9dJQhgWqIjVj3a6BN+zTSjb310IRfc8yP2ev0ePmZ8nArupuzUsxXIS+?=
 =?us-ascii?Q?leNOn3zX1hSMeOt+lWO1CaxiY/AMxoxoziXvs7fGuQkJbrEWVPPy8AOK9wnb?=
 =?us-ascii?Q?NGzw6Hxq9E4IhkBdXLp8rXQXtFMBa5PgY+TCbxVFy4BmPN/TeH+QssqPriwX?=
 =?us-ascii?Q?yW30+WV9cjPbEkQmTB3HsTCf61Pzek6hbfyC7TaxqvK/iva9KDwIh9radD1v?=
 =?us-ascii?Q?p+scLqyUwzjeHjQFYaq4646ebBZ/u+TkK59y0J3X6fDsxthlgh0s9wsTjXYH?=
 =?us-ascii?Q?YNUgdA6syQer7/320Y7KW4VtPUCAm/I1Z7c2XFccqgFoWeqFkehyx46KZnxY?=
 =?us-ascii?Q?CndKrmmeZv9GnZW4sw3pVi542HjgYXOHD3YYDvEqUsXd2ONZLHYUa+SKMbTl?=
 =?us-ascii?Q?AX1TAZmCyyCKfeBd4JQUA9u6yxx+2+hIY7qCjghQxz/wwU3h71qZPnlwlG8X?=
 =?us-ascii?Q?cUUiWU8Z1O7/GcfFzaUnxBrVwn7boDK8kT1Q/f+h/XT0H/DxVkhn2h8TNQOn?=
 =?us-ascii?Q?h1moiuvrkP7YXOjb/bviz+jy+pSOzk3BsCdqWNN6qlkFi//kXB1MlAY0OA+F?=
 =?us-ascii?Q?yPwtrieBIf6vC5RPWmFDkPJFRCHJkt56PaFUvsrxAIhN7XR7GOFVPWiJqsR7?=
 =?us-ascii?Q?NJPkZyhoRqFz5FpoUV6T1K7TaxOGdI2sGBKe10WEx2vBSTAaOjhtMJGFMglt?=
 =?us-ascii?Q?kuNMDEoE/pGCYjPoxLm6x1VdUl05I5T0Wjzj6r6OUWDdlpQX2182+OEghp3J?=
 =?us-ascii?Q?Ry1pSEH88W9Wuxr8EV1ivEbJvzL/e/9EtCJhqfOmJYZOzhrWBFBgvqzjmjal?=
 =?us-ascii?Q?94BC8RQKuMz4bIVfqtiGtMf6zp4Wv7Fkd+x0Ew1keMG/Muzk575w2Rc/xkmH?=
 =?us-ascii?Q?SchE4yzy98M1zQgYrqRlzinrzRbmc8f5OR9cuLuCmtzAdlTTvKb7dSQH/AfU?=
 =?us-ascii?Q?MmrZomaa4ceyYlIMcX/k9vfgnd/8SFjZ+xt74hmS3u9cUQ9fVbxr6t0ELpkb?=
 =?us-ascii?Q?WoOGkUMszuQbVG6hzSA2kSTMSJ1oCULbs4NfDNhN5ox2wQeq/6WAR3xsLSjC?=
 =?us-ascii?Q?yXhE/a5z5d7KKolXee6og8EcMav/lROMZgDogM0kP5nLfpexJooJqy5jI6rq?=
 =?us-ascii?Q?/7St/GsL/caI/GA+7xwlskMwzRmMyaVB1o6FGornaTcevpPhw5NRh5FyIYkj?=
 =?us-ascii?Q?hlk6UuFQ2n+FkBbEli0I3+REVfjavQNN3i+ZSr9tOzZVqJ+Y9G99zc7U/TY8?=
 =?us-ascii?Q?e4VPT82Iqd25+TmjdT/7VNsdNxH1lWRK2uQaQuXaI0rDUiBrMVPIJnT4I65L?=
 =?us-ascii?Q?x0xwWOvPd+dY8y9JYomHI7ggLmC5Uk727YvbbB1st6ZPmc5EA6RJlPmOTk9g?=
 =?us-ascii?Q?qbgzzFDGHLj3MzTOvrZadKxNqs475Dleol/1ScZWs0D4BMno8o8XedK5iaQ5?=
 =?us-ascii?Q?rJsop3N4l+wuCxd3cujfy7DAFoPd8Ywl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?li7an7DF6/8zv0rudQKsIkNs/xLTAWkBsB3eLopkU5ryGu+LjpHv1zcScFDl?=
 =?us-ascii?Q?Dk97r7/VfNr+5M2YTXeU1LzbvIw8jiwJQQRdXYNUiAaazS8pZ5qzfW/yVxMn?=
 =?us-ascii?Q?WaIc0ZBOb7t+WMsqjW91dpD4Km2uAIdjVB5QoFWMsF0VEV832JqlfZ06m9Ge?=
 =?us-ascii?Q?Rj/n1WsNMCJPw6UBwP42n1BeSx7VwCcDgHiW5BIsoy8nRqzE79dL7j80pfmH?=
 =?us-ascii?Q?aB7XvtlYs54W0FGBYr2ds4LNpf9kZ6jTIxyU3B2iWtTsLfYCzfmnkRtEHOLY?=
 =?us-ascii?Q?2Jx8CIl4cAktJjoqD623jylJ3lTSHywW5SMdVI1OMpWys2rf91GoJPoSVziL?=
 =?us-ascii?Q?5/y2Y80ml1dIcvntnK4UWryfgafJfSHmBuvzHkVqhwLMwiLEmq7ehAIEjBT2?=
 =?us-ascii?Q?J2wp319IrT1A68bvqy22myyLui1SjUwte7fzsV8ioogIizyYfH9UYoeNRquN?=
 =?us-ascii?Q?JG1CqH+fF2BfhMu4mkJNG058V5wYAvFLAMwImH3ZQJW1XrD4G5sNlYJTuCwt?=
 =?us-ascii?Q?KMNlGc6KFeEU+5DB2XVX0xDId7szMXnyvT3lmzb/rGKfJogC62I4PqtO1z61?=
 =?us-ascii?Q?CgFaFgsMB9DgGKfujt29YVeb8+oY7huz3YglC03lhZxMycvNgwU7iA5727yf?=
 =?us-ascii?Q?raZ6BuzLbsmbOnOSEukJI+OZL7B2JPYqsl0/EvzSKMh5L9W4+RBpHvY1S0kD?=
 =?us-ascii?Q?FIt5z/dI2TWoZX763veYiwnjtQ4IKsOmkbK05MdAFF9L2xhDi1jtCApiZw6g?=
 =?us-ascii?Q?jbYTzAxDmPxx5mN85rpuQiYDjVLjd2FxEwlmC6q/V9KoO6bEXRaVhcK7XID3?=
 =?us-ascii?Q?4lYVaKfOENOnM9EEHmZA05SlGajSzVcT4CpfQDRTwLE2+0ch/hqwEJwGl5sk?=
 =?us-ascii?Q?uEHMSphecFH9cuWNxyR5zWuIpT85GUXnJOufG1XeTHhqI0we35Jj1ief6Pzo?=
 =?us-ascii?Q?knJqXFP1gmYlFYKvIVkcuZ38Fjgnvk32paY6VcnoJBY3QRnnsiQzNeYZJmje?=
 =?us-ascii?Q?uWtvD7cFqU5ZQaR+Y1rusiMKRvGmYYjRBml2uHZXQx/XYL1TqYHiC4Kk+ZDG?=
 =?us-ascii?Q?Of6DPXi3M9qo2Qf+ko2h4c/kgmyHEdpGtxle+sQFs5gSJ0ZtxlNYihgHUQrN?=
 =?us-ascii?Q?uqMaG5t+lPkb/Vavo7/9BzFXg3bnjmy2hH0udAQpt3U9R+zkXcjr/3dqUFOY?=
 =?us-ascii?Q?Yi3rks6F4AjWkmILxxI5eLyI7TZ96wm93FDjm6KYGUgeMNiv9gkwV8J82bS6?=
 =?us-ascii?Q?EeJnaUFFk5EuVOs+Ydl+Hs9xeea2ZwLZ13lxnG++hqXWVn151qKeDozj+Vhk?=
 =?us-ascii?Q?NciIgq82OTuJt+sAK7RMkjGrdXUmEZQbm13yOr8yisl3zOiYmLOzkjc6UcZJ?=
 =?us-ascii?Q?AYXkhCMhcgZrmSWen90O/U9iWyzJC51fx04+q63IGTyw/6hGLy2vZy4TpRB9?=
 =?us-ascii?Q?qsvUizCZ4f/7Mf5M8QJlAJ35cyRfvRb6vPMXNKFEHT1mBaSjIXC+LnNqODKc?=
 =?us-ascii?Q?HZ6xphzgIPn7vmrtvlPjdPtksW3DIB64svrSYh0CIep9NFPEE40/94yim/QN?=
 =?us-ascii?Q?xn4AvEKCCbHSmvDL/+4WlI6wzwx23it42Y80lHzt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f002c3-ec0c-4c8e-32ea-08dd64288962
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 01:19:02.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELqWbTJPPgBh6Cznuo7coEhH26yNwckdyMfGQr0c8xk61g0ioAIlobLhNq3QIj6fEl4S1r9dsQ5cQLa9x5wDxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7005

On Sat, Mar 15, 2025 at 03:15:39PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Consolidate devicetree resource handling in dw_pcie_host_get_resources().
> No functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 37 +++++++++++++------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 5636243fb90e..9ce06b1ee266 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,25 +418,15 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>
> -int dw_pcie_host_init(struct dw_pcie_rp *pp)
> +static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct device *dev = pci->dev;
> -	struct device_node *np = dev->of_node;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct resource_entry *win;
> -	struct pci_host_bridge *bridge;
>  	struct resource *res;
>  	int ret;
>
> -	raw_spin_lock_init(&pp->lock);
> -
> -	bridge = devm_pci_alloc_host_bridge(dev, 0);
> -	if (!bridge)
> -		return -ENOMEM;
> -
> -	pp->bridge = bridge;
> -
>  	ret = dw_pcie_get_resources(pci);
>  	if (ret)
>  		return ret;
> @@ -455,13 +445,36 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		return PTR_ERR(pp->va_cfg0_base);
>
>  	/* Get the I/O range from DT */
> -	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
> +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_IO);
>  	if (win) {
>  		pp->io_size = resource_size(win->res);
>  		pp->io_bus_addr = win->res->start - win->offset;
>  		pp->io_base = pci_pio_to_address(win->res->start);
>  	}
>
> +	return 0;
> +}
> +
> +int dw_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
> +	struct pci_host_bridge *bridge;
> +	int ret;
> +
> +	raw_spin_lock_init(&pp->lock);
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, 0);
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	pp->bridge = bridge;
> +
> +	ret = dw_pcie_host_get_resources(pp);
> +	if (ret)
> +		return ret;
> +
>  	/* Set default bus ops */
>  	bridge->ops = &dw_pcie_ops;
>  	bridge->child_ops = &dw_child_pcie_ops;
> --
> 2.34.1
>

