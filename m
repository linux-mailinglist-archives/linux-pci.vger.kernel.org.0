Return-Path: <linux-pci+bounces-17663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B249E3FCF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFABD2812C1
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB985182D9;
	Wed,  4 Dec 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aiuX9o5i"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF14A28;
	Wed,  4 Dec 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330266; cv=fail; b=U7VUyHUb41ZTrUByN9Hi7Kz5GLf6C2QRxR0PYov8WQ26BvikIFpQQ2046WUJNVoCkJVF+yeUKkVPM1bOkoS48VZEXN1Xne8t1kzT6x7C03X9h5I5HYxI5e1DdTkxd+c4eepVzCyrQWAn9+y7xB+gEy6fn0rTFuf9l0JuddIXOmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330266; c=relaxed/simple;
	bh=L/EZVm39cCus7u7sQLek/lKVBFpPN6s682xgm6TKVLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FEjeOalQjACZXLu5AwpoBJe3Gnwp4i2c1YUIvqFawGdIBNUozRuKIst64Xexd28lcvplxKZNiKJZGBJY/t5ZB9gUhiImkD04RcEkoD2KmwIO5MjwooO4XIGCxRMzoqAQCD3VcQ51ZRR16T3O+TGMj3umi57VJhp7zcYF6Yq9K8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aiuX9o5i; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baPsg8xf/W8Cco/EAcYIX0mz8JDtQ0bSxbHpI5KRdXf89BGYhMnb1kPu9xX1r+5yffAhizQb/GWNFi7zuJE+JN2Tr4zkB+Fy/PlrBpdYhJJphkCoL8XZcOo5LnJ/N3EmQ9I+OJ4Iaaor1Dv6ZLxuf7PyoHZrC4IwGYQXP69iDPW85y0pGMkIJa/QIk/PecMSYV8KkYJGPJpo/R8TEpwgs2X5cnrWoTWOlw+u+qabYku+Zeg0jIWWpDHaz+J7aSQ9Fp4vsgTXhPrDHo03ZLpJ5WNVc4QSSpn3eN/dH2ffdU7o7nN3OGnw5EZrhy7hOELpybqGMg+XX3jQFgXphGHa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOhdKF6NTp3/UTaak6tOKZpUBRwTVeN+/jW60MaTkGE=;
 b=zKDGJ+mr+dq2XQ0gd7tffdCYqS/OSlq3gxXrJ4DhTxXUPTsEapQurV3wpyYXYGrkTty+4a0v/k/J7r0UZleL59lJ1rFy8bBvfK19Z5PyW2QY7asiANK02A+tP4+X9ztqrCvEYhcCvJjKWbfHc3E51uVMjInHy0LefEjrsEbDDThHIDFtGIYbSZaR/8bQxndgWlDoV+KRRkkVoK9oDhHSrZ6gNRxWjvxNqG8ApZjTbdulE2rl4EetybNTmeljHlAn425XnUviBs17U7C7EJypAnZuQgOlIk6yuwBcLfEl9lI8cUHhhfu0FcmqPO4C6FWqzuVlrmfQaZVz+1xiRNAtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOhdKF6NTp3/UTaak6tOKZpUBRwTVeN+/jW60MaTkGE=;
 b=aiuX9o5i6Jx+McmRr22QULgwdRMNJuXnlpURd4ZKjthQEU/4VF1oX/ApXw26Ev1zn9ErYE5AzzD7EGt69TE7p3xm62AVKUsSHz9fEM1p5YcJNDowmBq0paiksXYJGIwe2QnjXYksQlI5S4JAGfsH64IqcEYcY2LpS57aIi4ZDGdq9t+nU2IuL50OyCmTDitVQFRiAkdqgQH87Rl3xBJZeb1P7OyIGgKDytN980wi7PCsoPoYmmz3dSpcKfseqBbpgd9fKZe9Dhi1KZLQ190g8GDyre00mvW4miW/So4lypzfHFEiFTG3p0K7hi8muyEY4CbbqTZyd8J2qkyuzhSNvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10807.eurprd04.prod.outlook.com (2603:10a6:800:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Wed, 4 Dec
 2024 16:37:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 16:37:40 +0000
Date: Wed, 4 Dec 2024 11:37:33 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 2/2] PCI: apple: Convert to {en,dis}able_device()
 callbacks
Message-ID: <Z1CFTb8d1SfAmP2w@lizhi-Precision-Tower-5810>
References: <20241204150145.800408-1-maz@kernel.org>
 <20241204150145.800408-3-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204150145.800408-3-maz@kernel.org>
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10807:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6dce6e-1b5c-43b4-317b-08dd1481f855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cUczH68vKLROXsiNfzmg+NQBWl9tsSFqI9BWCYIiI8fK8Wdxq/0cRBWZyluu?=
 =?us-ascii?Q?bw8PBm6AQz0vjkUqTrPD6TrmVZdqDUelrkScNNb/ZuVPUW+xbqBxZJvXGzRH?=
 =?us-ascii?Q?1ftn37bBZiehxckf+VKomX4iRJ24H2ZTe67ZhlZNuOP2hMzuFDhu730hB7Wq?=
 =?us-ascii?Q?zDUoIHwbvFb8LgYrOm4jptT+B7w39MygzU5UV1eTYBOWdDbX9cISTFvJ1+NF?=
 =?us-ascii?Q?4WrUyNlNBe9H8kYxiujxXZLsaae83iAzptmrKBl1w03dwCY6WpyAYeHLz52j?=
 =?us-ascii?Q?PEYoQwn4LEp2ZAfxbJLAmPvTP7wXrTdT9FBK1NtryCrJUqqyJsGVuLLpzEmo?=
 =?us-ascii?Q?10stiTxkbJwj2Nm7RELe2Y62p2eZBXi5vMGlFr/Njslj/TlBe1tDUNUbzWJs?=
 =?us-ascii?Q?WD9P6H4UKTV27qPBlIfWwR+8tpQysggg83S6HaVCPGqs/k0ZUWOUWg9mp/Qm?=
 =?us-ascii?Q?ykzvHvPXCzLhf60aOY6jWOvJcngKp3/jEe+ppNCFD4B3TTsD2TV9zYAD2+XH?=
 =?us-ascii?Q?Gz+zjdhMOlZ0xGG8/UcJLZzd2QdkSZ8u9CaEuiIe7SPklMDNb0EoZUuRclJP?=
 =?us-ascii?Q?kWL7gUzwq0bpihWzcm6hXaeSmCSK4SgAl44ywFwIS2S0m3tsmw9oHxQWcAMM?=
 =?us-ascii?Q?zh6gXU0ykbTtSc1JPsk6okMn4n/Ag2duyjNUEhql2Wd/qJt4yJUZwbuTTf2V?=
 =?us-ascii?Q?NE/fFoICErfQgR5QJcQm2YIIBD6ZKliQkcIcc51M2eF1l09A8OeD1U/tD8rM?=
 =?us-ascii?Q?K1BuU8/dPttENuaHm7ld+6C8s7Ce5osBuD3LhROxlfEj+/KEsIcyQBW/sU4j?=
 =?us-ascii?Q?g0xuSYunnP4jKit6JmoCP0Cs7EJaw9/CC/Zo5jZ1rMO0zjb7SH8InAsE2uFn?=
 =?us-ascii?Q?oHK+We5MkJnbVZw30N7mlFFEPKrta79zKasufgGKI8h2WRLpjXJZ+3dNqOfs?=
 =?us-ascii?Q?ye8k8iWz/kYpkIGO3lUN8sU8KFrsZukARtXwHLW/2WgXthJiY0fc7CF4ufmj?=
 =?us-ascii?Q?Y26ea6VkRl8ZcoInAAfFtNhG0wbBEGuCwV8/H5UbN7xseULn5wwQ5GAmi8Kv?=
 =?us-ascii?Q?D5BSDB7C2vTBMO2JZmzyI3EDMvlWYVlLJwk5nWPrlQhbUuLa2ehev1fukPku?=
 =?us-ascii?Q?KzNBlA/ouQUdcHK0tQ2GRCqPPmkJUIpaBfOF111j9auh7YAD5bRzWiYyuAml?=
 =?us-ascii?Q?EbPyb3V9T1B02+kHMQsmHdvo4kl9brtmj/JIAPl6wjLyUe7Cja7GlnniN/d2?=
 =?us-ascii?Q?8E/v2bW2IqNrnT6ytL9R6E2hfqjsUxuZtsXDtaChgpcGNDe9LpsGv4HEYsx3?=
 =?us-ascii?Q?dK5VI09W3w4gFazOzeLByLUma7Db3G59dtCWXxdLf8+l1mSgWEMW5/s3qtkl?=
 =?us-ascii?Q?uH6ge4uZVvch1zKcpxkouJ6I4dQwhfaNFMX48spvI+zpGvH5+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPI7JDik9sHCnYAnh+gtSpP5X6W5JVUOTOh0MyZ3400k/IeZ4FcKGNNzPwlH?=
 =?us-ascii?Q?YWZ5rca49IqSMSrKcU2ELRMeCnEtUp3R0EOyeddKB45Lr41odyPbF4AGzpL0?=
 =?us-ascii?Q?ca+zvmbVFNWCerGmtA1LX2UScKOnQN7DxmtEF2YE2EDFtAAx4kzAZIF1M+MK?=
 =?us-ascii?Q?m7Q255IoB1mu1p14q0zP4ovm+mfB3tM6voZXMJtU50rHGlxHV3oN86lekqQT?=
 =?us-ascii?Q?ZwhEE734YoUgdo2B2LPNoMIGDr8KDdrwcbWBRccyHb8IoX1XvYWNsRjILeAg?=
 =?us-ascii?Q?q5MlccydckuGAuvl7ko1FWb7S+GDAaFfVxm8c2z6QDBpaQhQmoLyZILIaC/C?=
 =?us-ascii?Q?k/LM6sM2YDvblz2/ns2UkJaOUp1ydJH7GH2y4Rs1l3x+QC16ftHPG8+B7hr+?=
 =?us-ascii?Q?Ik0vgCHICHUxndTlamCehRj3boudgPnUDA5MunEqiHBBToCok3Ex5UX0iEPr?=
 =?us-ascii?Q?Q2rYIK61G/QKBb9UGNzQ0oEI1zb4obF8J6I/L2tG0QEWi2CFGjhcFnV4M0R2?=
 =?us-ascii?Q?HSvHkOKOn0HzgHqWGdziO8W7FKCxpX9CRXQp8OxLTA++VxOwkREqNRIv9eGU?=
 =?us-ascii?Q?XZZfgyZKgt2ihp46OYFKF3qBj1I7h+xSiZWxTY2i6ohpxlX4slGC954odaOH?=
 =?us-ascii?Q?4Z1WwQMhErTccBMxIUEDAwE0EwkImgXLzDw7yKeEZ6rhhvg3CZMQhpaDDhvt?=
 =?us-ascii?Q?/u60+6MzF4AkmqvprwvPP/JLAA1P1VdaGaJzMu5JlaXFmUVBMJpOUsK9W8Vx?=
 =?us-ascii?Q?HeD9iLTsh840Li4+gid7ceMDmLiS6XNFomJEk3nWlL0DUuy0oHcdaZiEaAg/?=
 =?us-ascii?Q?5zraF6W3priJRL6OcaZXKrMH5UwNKXAhSzC+wtKSYAyMH50pwIU+1/g7pXOV?=
 =?us-ascii?Q?76Cb9sDgLivtfTn4QtT+/2z9EJgLM415ArK+HUyrEI1iiFHW130XLjgwHEBu?=
 =?us-ascii?Q?R6aJRSQoKmGMZ7jqYwp6nPXctPD1ZCKX+xB/Ub+AAraAYfdnmspNecnF/dfE?=
 =?us-ascii?Q?QYMEfgmQU4SbNrO4K4I9NPSx1s8WQxCYSvDbyc4Z63dOV634CnYx7HOARFQI?=
 =?us-ascii?Q?nWpL46CjYATXbsBVIwBytD8+v1aVKELtLtCKKKJzqKrycBFYG/bJ1wY4TpZu?=
 =?us-ascii?Q?jOlFKvg2NMJPYD9v0XijcKrC7+WZ+Y6hW0zDWXIKnKx9kPhxzn9DuKpV5h8H?=
 =?us-ascii?Q?RR9P7/Ntj+i9MZzsTvTg5Zrb7crx/z1ngwKkLkYu5OaJMZnKixje0hEzM4yT?=
 =?us-ascii?Q?efAxDO+o9xiM20qU8uqoqY7289d4vg/7OSla/bk6cvU+P9a7MFubAvxBTzuB?=
 =?us-ascii?Q?7ZEd9Rsvc+5pllsOrn4ggTL//lmZxIoyTWZtGWcQJb8qBNeNtnD6ZWkg0J48?=
 =?us-ascii?Q?1QKbl+7qgaZfC/5wfXzLZwqrzSLE3YrISZVa5yQlQyvAEczIZ3/LpJ8eP0pW?=
 =?us-ascii?Q?l+QoQtLI2fAUFHsSueZNsGErk8aBvfmZc1TpW4nYAaN7yEcew0rJPHidKNcv?=
 =?us-ascii?Q?FsaEXOpzehl2fay3NACRmKAbPf1Gl0YCUyYO9NJ5lTODoiJ6LBCONwJd24Ws?=
 =?us-ascii?Q?fmEuJiuWorZPHmP831MjFJ9dWxoeooWwvMi+H/6n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6dce6e-1b5c-43b4-317b-08dd1481f855
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:37:40.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: co5iOok1lZRGRocjRSuucuhZ75b/cjGNW2zRmSEm04A3YmxIS7dk5xLod01ZNbmGf0/IlftejUsjcBkBpnGdGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10807

On Wed, Dec 04, 2024 at 03:01:45PM +0000, Marc Zyngier wrote:
> Now that the core host-bridge infrastructure is able to give
> us a callback on each device being added or removed, convert
> the bus-notifier hack to it.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>


> ---
>  drivers/pci/controller/pcie-apple.c | 75 ++++++-----------------------
>  1 file changed, 15 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index fefab2758a064..a7e51bc1c2fe8 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -26,7 +26,6 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> -#include <linux/notifier.h>
>  #include <linux/of_irq.h>
>  #include <linux/pci-ecam.h>
>
> @@ -667,12 +666,16 @@ static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
>  	return NULL;
>  }
>
> -static int apple_pcie_add_device(struct apple_pcie_port *port,
> -				 struct pci_dev *pdev)
> +static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
>  {
>  	u32 sid, rid = pci_dev_id(pdev);
> +	struct apple_pcie_port *port;
>  	int idx, err;
>
> +	port = apple_pcie_get_port(pdev);
> +	if (!port)
> +		return 0;
> +
>  	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
>  		pci_name(pdev->bus->self), port->idx);
>
> @@ -698,12 +701,16 @@ static int apple_pcie_add_device(struct apple_pcie_port *port,
>  	return idx >= 0 ? 0 : -ENOSPC;
>  }
>
> -static void apple_pcie_release_device(struct apple_pcie_port *port,
> -				      struct pci_dev *pdev)
> +static void apple_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
>  {
> +	struct apple_pcie_port *port;
>  	u32 rid = pci_dev_id(pdev);
>  	int idx;
>
> +	port = apple_pcie_get_port(pdev);
> +	if (!port)
> +		return;
> +
>  	mutex_lock(&port->pcie->lock);
>
>  	for_each_set_bit(idx, port->sid_map, port->sid_map_sz) {
> @@ -721,45 +728,6 @@ static void apple_pcie_release_device(struct apple_pcie_port *port,
>  	mutex_unlock(&port->pcie->lock);
>  }
>
> -static int apple_pcie_bus_notifier(struct notifier_block *nb,
> -				   unsigned long action,
> -				   void *data)
> -{
> -	struct device *dev = data;
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct apple_pcie_port *port;
> -	int err;
> -
> -	/*
> -	 * This is a bit ugly. We assume that if we get notified for
> -	 * any PCI device, we must be in charge of it, and that there
> -	 * is no other PCI controller in the whole system. It probably
> -	 * holds for now, but who knows for how long?
> -	 */
> -	port = apple_pcie_get_port(pdev);
> -	if (!port)
> -		return NOTIFY_DONE;
> -
> -	switch (action) {
> -	case BUS_NOTIFY_ADD_DEVICE:
> -		err = apple_pcie_add_device(port, pdev);
> -		if (err)
> -			return notifier_from_errno(err);
> -		break;
> -	case BUS_NOTIFY_DEL_DEVICE:
> -		apple_pcie_release_device(port, pdev);
> -		break;
> -	default:
> -		return NOTIFY_DONE;
> -	}
> -
> -	return NOTIFY_OK;
> -}
> -
> -static struct notifier_block apple_pcie_nb = {
> -	.notifier_call = apple_pcie_bus_notifier,
> -};
> -
>  static int apple_pcie_init(struct pci_config_window *cfg)
>  {
>  	struct device *dev = cfg->parent;
> @@ -799,23 +767,10 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>  	return 0;
>  }
>
> -static int apple_pcie_probe(struct platform_device *pdev)
> -{
> -	int ret;
> -
> -	ret = bus_register_notifier(&pci_bus_type, &apple_pcie_nb);
> -	if (ret)
> -		return ret;
> -
> -	ret = pci_host_common_probe(pdev);
> -	if (ret)
> -		bus_unregister_notifier(&pci_bus_type, &apple_pcie_nb);
> -
> -	return ret;
> -}
> -
>  static const struct pci_ecam_ops apple_pcie_cfg_ecam_ops = {
>  	.init		= apple_pcie_init,
> +	.enable_device	= apple_pcie_enable_device,
> +	.disable_device	= apple_pcie_disable_device,
>  	.pci_ops	= {
>  		.map_bus	= pci_ecam_map_bus,
>  		.read		= pci_generic_config_read,
> @@ -830,7 +785,7 @@ static const struct of_device_id apple_pcie_of_match[] = {
>  MODULE_DEVICE_TABLE(of, apple_pcie_of_match);
>
>  static struct platform_driver apple_pcie_driver = {
> -	.probe	= apple_pcie_probe,
> +	.probe	= pci_host_common_probe,
>  	.driver	= {
>  		.name			= "pcie-apple",
>  		.of_match_table		= apple_pcie_of_match,
> --
> 2.39.2
>

