Return-Path: <linux-pci+bounces-24956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F0A74D3C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2953B3A4A25
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AE51A4F0A;
	Fri, 28 Mar 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="itbZKxEB"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B21C1F02;
	Fri, 28 Mar 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173810; cv=fail; b=COV3loJ7Buc5QfyA8UqOYbKkRIr8PVmFz4TbDzYzqhaCj2s3GNKLXO3XFgr2hGhqSUPsu3okd1toHSZE4HoTBdCA12EXid3UwD2LLysoaxAwgQ55pk4waiagdZCwQ1q0GtyhIfQY63dlNuTGHqHWlKYMDAcIMLT6mKiURIykqXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173810; c=relaxed/simple;
	bh=r2N8NjpmNepbvw3v5drnSWIT/UdIC1v52sCxzhCtAGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=olULC6SdaZpdkByrql8Q0ZIwrXDCAT/pSluX8pYD/4mGX74V+t6yWJTAanNL4N4H9oZPn+lAtZeS+cigTFQk7NPexVxxdLveBAAKQ2O1aTZ40Ek5tmWTXvz6L0phV00RWSTz5PBT0AiyYEcR3fA0JAotk0mmwkWFjyltqzaNjnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=itbZKxEB; arc=fail smtp.client-ip=52.101.72.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwgLDxPZO3tGoIqYtnVjED4l+ps1xe68cd7HJdjGozEROW5FCVJRWsW/HW3gMfVkf0X4/JJa7slYdsUlYr+zHSgdrRauf4rj/QNaLv3n5q5v9U/d0qFS0exQf6SiAiCoF7Nc2jE/ntXq/2URgL99tseFMvzEZq4rGs/f1jcwu4YKW3yUtXQBed5XLEJJo6pcjP1FajJJaSINmEpAU+ydKId2Zz8WjAy+3PazbJFXuQIzFezTs8x8+dw18twffR8xeCHjn8ZNjaWsP5SkDn7ZdP1DsLqCWYBU8m0R9g9I4Y67S4qP/Aig47mT4W52X1hgt8IAKXlsIjmRhDivb7kv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWHjFGdLsuAc2RCUSFZh2y/tgjnR9aFMzH8cFmV/eTo=;
 b=L3LGEXdIAdQj4EHCBqc6Bv/5ivMKPc4qeFLJraOjPfeW4N8ZFBqdoP87khOWfdL8ur9Y9WGVTdJ5nA3vB4VKqVcQlJb464mFj2PGHRiNozNhOVgy3zD0LK9hykpQqGHoshTaEe0GLv6yQHFNvD0sJcJP5U/1ldTTY8p+J+NxEOUutfB3sTWN+4ev/OWQ5HcWK8T13MUd303LJdIZcS+3ADbHERIvin/U0K4VTxxO3Ky7dFIhnsfXiC7ljYGIhXThH6e2WThqMg0Vi6MWHueNj2La/hUFmCQymCTlYG2RXn1n4C+qPRM/XMEjbXH0mZEqIgzfjSVPMxPjp2lyI2HTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWHjFGdLsuAc2RCUSFZh2y/tgjnR9aFMzH8cFmV/eTo=;
 b=itbZKxEBm9UvO5O2mA1NMpxcnnKIAgg1JRUorQE0ntxL8kIWVHWFpAzyHnBc80f1o4kmTNmqtVhxstAog9KTtUNnNPGTGjvUWwZL37HuxySrJ4usJRy++50VqA46THrgHFCtgNMcEQIcqEC4IXo+8CB+fWPa4hguPSne6ncayIxylF9KcZlbiMYudOT/B9TIANSSE9bZWDZ/ciElPJququ+gnLcq3uHH+uLwHb5FAM4O4b7m54r36waV8B+SQ9xJPYwW7IttOcdy4IGKUq+tVTpYdhPBLkOzdnOAxX6Vxm4J27/U2rt8efLrhIvcBH/lUQK5Jgt1W76t0Xwy6elIZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 28 Mar
 2025 14:56:46 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:56:45 +0000
Date: Fri, 28 Mar 2025 10:56:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] PCI: imx6: Save and restore the LUT setting for
 i.MX95 PCIe
Message-ID: <Z+a4pS8Gkg8vDanC@lizhi-Precision-Tower-5810>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-7-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328030213.1650990-7-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH8PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::9) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBBPR04MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 814d43b9-a19f-468d-6511-08dd6e08c1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+I+hSoKbSJVXPS5aNS/bpoFAZAggjbcwCedGIhnw0AkqC3NVUialDorK+wB?=
 =?us-ascii?Q?wYCiEMLjB96eY2SvMH0Gz4yX0CAXtPeka7m6sKgy1u+M/OQf0xRlTRSMtv80?=
 =?us-ascii?Q?21dvAPBCLfj+Dvh3Um7yDv959HHRKqnRA2siPmaLUF5xX4HVQyICWsqWDxgv?=
 =?us-ascii?Q?aVIrbID77mRlbYYSvRDUH9h2V8lzHYT4wT/cLBXRR8jQONXgm4A5MeFhEwK6?=
 =?us-ascii?Q?+gxtbfxd0zWI8d6fNPfc1QcDTOxlidKue7RFaiEbtVO8nQD3385/7ZObt4jo?=
 =?us-ascii?Q?x62wgipRaMkK0nJhy61Q7sgczefmhrkHaG5ZXGbmMtFrIWLppzhuRG0w5ofn?=
 =?us-ascii?Q?wTisz5Od4TR+OJH36GwifSsEJTNQHmFjms/fHeJSjXRkMD27cgegBaKN1Ag3?=
 =?us-ascii?Q?wqucjhPMBcBS3PfsSryD55tjSe/3D+e6XnyijCxK5RkY6IejKrAuU7yVtx/5?=
 =?us-ascii?Q?NkoqotoiLE8aQARYQg/jDIdTpDis6zIQq6f4jSaSKL4dwdcw7xjRK/sImUjy?=
 =?us-ascii?Q?1cfHARkFCyd1LvIswyAnPRNBhuvMpTRRbM0lnTcJgfyOkiwXjFvt2c6vNYxw?=
 =?us-ascii?Q?W5mEDkBlLnBUOsvXpap/jVjrv4zH/+WV8K/Mi0egemT5M9rm3/LVIxDzM2yC?=
 =?us-ascii?Q?7jn1VQrkWjoRMNnmsay1InpGNw8tiDpN9sNBuSJTCIUw275GSVOH8wjNxI49?=
 =?us-ascii?Q?D44mF6F4fMPgdRWN0xChmIxSt3P4+kA80n0Qm1M5gs4o11yhs1sbqtQxi73C?=
 =?us-ascii?Q?AxCRaXRmvWkBG1eU6CNVyrTdpVByuc6Qpi8Gk1jRdO+I/udIXj/VjD1glQxf?=
 =?us-ascii?Q?JcHEXoMo23/+5jR4Of1jGmJ8p89osarW9YSx6AZCSI3zkIgL1B0Mlx8xAFn6?=
 =?us-ascii?Q?2QOYjWkDFIOKMaovCKDY58VV+w6kEw+bDKjZ5lIDHuIhJjVAqHSSYCynmWot?=
 =?us-ascii?Q?GAbMFsQWDoJZeWqFku+mlZGQ4BEweTx5aT0v+ua6iBeincTaY8l8tCL7h6s4?=
 =?us-ascii?Q?IqFvvNKqHDFIhu0rqRjl90Nmm/RWln4FFJKJfplKCiJ7vk2Q5OWEedl43uqj?=
 =?us-ascii?Q?bQ+y4jFEL9/s9MXVPh18hIM16+Na7aH441oyfA+mRRqCtzevOCU1BwNejIR6?=
 =?us-ascii?Q?IOH2d1TJytpZ+zmYNLkuSqpnJPt0GWMDLFxmrTfTo4T3v8YHXczx9MCcErai?=
 =?us-ascii?Q?rfcZ/iYPIA/81XCHa8CQtGmD+v+h0gXitcEmm+i80gTsQBcgBoRXbz5YFtJ9?=
 =?us-ascii?Q?ktX4kSPuuT8RP37SuM63qeVTnSH3hIAOti1Qq99uM93sgZODe4KnhVEXGGiY?=
 =?us-ascii?Q?cVv5q5vVEW4A0X/ERlwhMbaafOXWsYeiLxmoum+ri5RvyjhZZyuP3iii6ZRx?=
 =?us-ascii?Q?m+jtBnE+ckwgSf+0IKmMxyVAIoHuR7Y5IFQnAzwJewy3fep5ZPKnJdljqSai?=
 =?us-ascii?Q?NGTrdBwt+wGFiu9iOHuH3Egc2xJo1DTg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dnqnc+fuhIk7EhirkMRe694xOyE5ZGus02QlOx70G/YfslVBHBsMJUKngjq0?=
 =?us-ascii?Q?fxfskA6A4sEoPrYZ2mJm33TcReUmWriMW5H9LiFJh7seUrzUfsmzVqiLfBWS?=
 =?us-ascii?Q?j/6eJCZXvDPxJH1vngQbZeQ4LlWC+arVnYMRcWJ5wxGIprPcLsM1BAaRnqFj?=
 =?us-ascii?Q?sxNrH7+hiCxygNjUZIqEv7b6TH70lDRpqLHXW+ubKHKhP4jA7ZTvsQKtpkmr?=
 =?us-ascii?Q?dZW3J+hF1oUSR/Pv+4KxFniwYLjquvD08NL+wSfUF8H91VK1KflGQaSPEnXw?=
 =?us-ascii?Q?qQWG9XNuiJ4AAnR+zzRWFimZHxtlGN1CY4akrxLDAFmNyTWivlxZDFt+2LUl?=
 =?us-ascii?Q?zHQ/ekie4MXoyYKte4TuMTbPEwvOJ1g8sBj+QVGdS1IXEEfr5UZJ1ViD+Jgt?=
 =?us-ascii?Q?Uic966YqWwgYxoe5QJWz7Y7iLJN3okA0Eszhgd47EO4FnPMp/nmvT5O9TfXI?=
 =?us-ascii?Q?fVJaWUhai8E2KVlOlhXGt2ahlfS3hEank0UNnccOps+STXS8MB0w9hSTC/b4?=
 =?us-ascii?Q?LL2o2c+NHSbgKgWIZB/Rlr0Z4ozaLAuti4GDUH4iNwLe/HblrHvdVuY8M299?=
 =?us-ascii?Q?GcdwzrZOJ2V62bhbhBudKdg26hO/6HtPIzfbbpMcJVylNJxpemybt86XB8gy?=
 =?us-ascii?Q?5w/oZuHyhl+JMbatdcuCKqPL6CdLaLzeUEL1B//ltNJ2IylTcDuwNut4/4hw?=
 =?us-ascii?Q?X73RvCnFDmOZH+zaGd4YRn9t1IBunbAAWQjsw9JAclqZnAngxGCrxS8I/QSj?=
 =?us-ascii?Q?uKoEBc9hRm9YhvKXZ+VSnlSOjzlsmhQgQBie9DHz3RfEPHe+v5tE4JXHZKlw?=
 =?us-ascii?Q?n4ESQUiX6/mgDkfpo0kcjdWOrldEQdaJRUp+NOKa2qV+xLCqoR0EVx3WbbL5?=
 =?us-ascii?Q?ZNXzSQyw+g+yr19OvMsIm9kjqOrc4qnbD8fOuAZAZ1SUGIkNwnSMSVvGWIUW?=
 =?us-ascii?Q?zPO7fH7UHrxYWIfZpr4NL7QoMnUkUGDOqQE5fmvP0MGBFV+3vMrlIELbGRfn?=
 =?us-ascii?Q?UKiGZdjn5SkMuvtGHlCWPl4wyK2c6R6rR/q9LaYFME9zReBcFxBpzJhVx8yF?=
 =?us-ascii?Q?+5vQB+IzRTvZVD2VxfTzw8MYQIZ+uob85U5pU3tqGUSwhlNI6HTf4RsK6RDI?=
 =?us-ascii?Q?ofBGsJbO8pLSQmw3opZONoKyl9yr08PTUzYUnCk8+CTJH0TGGKDRu3tRncaL?=
 =?us-ascii?Q?pX+fnAMuOZIlGMa3unAPRcxFLLxx0axnt0IcpnZDKRJfUrRdV1Kn3Eu2C+F1?=
 =?us-ascii?Q?8LrP3MJr9vPO+k5QUWWcBzoC/fNEcweYlm2+XSejZn4bIc+Rsz+mpFkIOGNO?=
 =?us-ascii?Q?B/CjBD1WGVLdvwrSRLrC8S0Uo6SPTXU2EHY31pkqMLT59NVYg93BuCZj7KVX?=
 =?us-ascii?Q?RG9bHklveBmRlzZtDiE+tOLC2FbPuBzmfFi2j/X/nJLipHar6v+EDFIXBVAR?=
 =?us-ascii?Q?siD3G4YNG/wq01F4xuCml9WnY2kAYqgIxS73U2V9xVX0n7bjP5KKIUpxE6fx?=
 =?us-ascii?Q?1Ges2wF5NtRXAs+PkGfHds62ZZhgyZbmxv/0c/04afsIzM5C5VBuU7nvSdD7?=
 =?us-ascii?Q?kxcR0ZPuWipzeS84CjLYkRczmGowvth8xDVEXas7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814d43b9-a19f-468d-6511-08dd6e08c1ce
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:56:45.0431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ng49n4c0aT75hEgolJL+9kUrl6ipDuonyWiUg2n54hHr64xzaeYMeKreGIoifPFav1U69iWCSRaNzxyqoVt/1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564

On Fri, Mar 28, 2025 at 11:02:13AM +0800, Richard Zhu wrote:
> The look up table(LUT) setting would be lost during PCIe suspend on i.MX95.
>
> To ensure proper functionality after resume, save and restore the LUT
> setting in suspend and resume operations.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 40eeb02ffb5d..d8f4608eb7da 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -138,6 +138,11 @@ struct imx_pcie_drvdata {
>  	const struct dw_pcie_host_ops *ops;
>  };
>
> +struct imx_lut_data {
> +	u32 data1;
> +	u32 data2;
> +};
> +
>  struct imx_pcie {
>  	struct dw_pcie		*pci;
>  	struct gpio_desc	*reset_gpiod;
> @@ -157,6 +162,8 @@ struct imx_pcie {
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
>
> +	/* LUT data for pcie */
> +	struct imx_lut_data	luts[IMX95_MAX_LUT];
>  	/* power domain for pcie */
>  	struct device		*pd_pcie;
>  	/* power domain for pcie phy */
> @@ -1505,6 +1512,42 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
>  	}
>  }
>
> +static void imx_pcie_lut_save(struct imx_pcie *imx_pcie)
> +{
> +	u32 data1, data2;
> +	int i;
> +
> +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL,
> +			     IMX95_PEO_LUT_RWA | i);
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> +		if (data1 & IMX95_PE0_LUT_VLD) {
> +			imx_pcie->luts[i].data1 = data1;
> +			imx_pcie->luts[i].data2 = data2;
> +		} else {
> +			imx_pcie->luts[i].data1 = 0;
> +			imx_pcie->luts[i].data2 = 0;
> +		}
> +	}
> +}
> +
> +static void imx_pcie_lut_restore(struct imx_pcie *imx_pcie)
> +{
> +	int i;
> +
> +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> +		if ((imx_pcie->luts[i].data1 & IMX95_PE0_LUT_VLD) == 0)
> +			continue;
> +
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1,
> +			     imx_pcie->luts[i].data1);
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2,
> +			     imx_pcie->luts[i].data2);
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> +	}
> +}
> +
>  static int imx_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> @@ -1513,6 +1556,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
>  		return 0;
>
>  	imx_pcie_msi_save_restore(imx_pcie, true);
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> +		imx_pcie_lut_save(imx_pcie);
>  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
>  		/*
>  		 * The minimum for a workaround would be to set PERST# and to
> @@ -1557,6 +1602,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  		if (ret)
>  			return ret;
>  	}
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> +		imx_pcie_lut_restore(imx_pcie);
>  	imx_pcie_msi_save_restore(imx_pcie, false);
>
>  	return 0;
> --
> 2.37.1
>

