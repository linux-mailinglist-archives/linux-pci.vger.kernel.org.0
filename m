Return-Path: <linux-pci+bounces-34388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE22B2E0BA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 17:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5ED1C87C39
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16043320CA1;
	Wed, 20 Aug 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EOxYQsxv"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCEF3218DD;
	Wed, 20 Aug 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702404; cv=fail; b=qCZFP9eYlBxV5PXOYnSnJZaEkmE0898hKfi7LIeWGe1lagcSEnw2CylGEGWRvj5W1n8sSgPrXeiu1blzvxk7W2yUaFWPiQW1LJJg54rUomRiPATf/NFnIBAg+OftrjxpYdUUB92tGiIT6dKJEqzQgmZf5dQvyR9jF9OONcVuuBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702404; c=relaxed/simple;
	bh=22KBWKNGjOPrPdXewWDZYAenOAUcz9Ag+5VlSp5QPiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZ8uIWdZgEjgtnES66Fym17QkLJ9ixXMSJzLV28T97uOsW+vXWTzLmFGt8iMJs3Ylev34zJj55LVYRDLqaNt+8F3L9hWKyOQZPy1W+nagLcw5TwIUT1J+/7zfXoLYyNi+el7hQnkLS7vl3iO/9baimt422XFtuHV4qcvKQ6zGqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EOxYQsxv; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSDDFc2zLt4/hHNOVYuAlN2Xm/0BxosD2yLqAzZQSdCezFPPUguTC2TZ/yS00JOReArhzowaFYWYzFWCahXcFtwHpSysAlhV6tu4YBLHZ0l7F1aWA8JycQiNv4YazUP+34izpSdIUBaqDcpbUOCLnujOoudLneOxrHSyTV0bTy9EHu/SNnaKWPAszg2aHv428Djr+qtpeKJCof7sfrmbwKI+g0kG9aV+y34b9F4jdDw0BZkrpv9GFiyQZCSPERwAv5kSnOquVNDJRs3BInWyQMpVTDiZmBSyXwSBPgYJn6q4G6/fPm9kGRdGJp3rS4qc6wHb5xQMBNDTEwCN89Wu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPZI8w7qKJHwSZZbJDPL1p2iDbL2Svv2buGVdbSdiiw=;
 b=Iq2015SAORJZyiO+x8eSPPs+TihvEwlIFDsY0Jm0ARquAr1SGBuPQBshLYJcAZwFC8xU13qAHwMTE7lChRyNjQCs6nNYDuUSbqWrvzTUDGqX04KUSQ8+iNkY8mU42RPBgIjOS+T162UOJ55JdVH4EvyTxX8dsta8mTaLd9s3xSg+11SbjP4rWtznGXq771DK42J6xcfkNDIZ+LIXHG6Vz0gaZBnLWMm5/ZH8FZ06KHSEgkoYAykbGlUVeXTgkYvRXfMqcXxZbnQg+s1C0V3hC/9AJFlXH58ymXmM6cY369PqC8VvVIJ+RP2rFkETJBaugEPYCE7Jjqne/eS19PcSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPZI8w7qKJHwSZZbJDPL1p2iDbL2Svv2buGVdbSdiiw=;
 b=EOxYQsxvsuqOCtOQvYikAZ0q1OsnbRJfvNuNzMI8pKyfnaJx457whIeIJB8Agi49KL5tsnrgbC378MwtNOAUv5qmJCNVrqt64BBphVEkzx8PQl5Nhy4WYssZZXYZ41CYBRgk0fgyf96eqNBbPm0bd0SAVSfOMV9FZFVzoRlGoVVcTyGmMtj7iPylRc0ROkCdAgb0n4FO2RDSP7UzoA0Issp+xemzbVqGpi49ktOibl8EBVoNY8s4nyirrnRMmTB8/QQ9JsVezUj5b7wDVNFn0pPVyz0/VSGg3avRrVKkEh3KhFlp+xNMiWP70kTXTkjjCEeQJmVswW5kRxI7SlkGZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8698.eurprd04.prod.outlook.com (2603:10a6:20b:43d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 15:06:39 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 15:06:39 +0000
Date: Wed, 20 Aug 2025 11:06:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Message-ID: <aKXkeutR3SXjJgZJ@lizhi-Precision-Tower-5810>
References: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
 <20250820081048.2279057-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820081048.2279057-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: AM8P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::10) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: fb41bdcf-ab7c-4310-2767-08dddffb2a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mI27NucsVK0GkzK8ow7031rzI9xHdmTQU/gLYV6fB862E0RjO7aUs/GeSiFL?=
 =?us-ascii?Q?ynqjpNrAIHVckb6gOjyQjaNXCIGNUqnrUcF2bAwKWtUmIYBsBpafrl7Uk6nC?=
 =?us-ascii?Q?Q3vluDMAGw4KXu1K980o+vtrJF8KdcTGi/NTRS2nCbZ+xrPpiY0VryAtm57w?=
 =?us-ascii?Q?QZFeRG2Nd9NR4YKyy/taY9rHG8pOYCvg7Ow0953Ej7u6oJz4PI/qQdPwEmUQ?=
 =?us-ascii?Q?6VzJO9ljQluP4V5jA5rOgn3pf6WEBzKPV77IzpFK8lIAa0ZPTDp8LVg1ohxD?=
 =?us-ascii?Q?Knec1sa7d80a0FkOcPxuGxH9yJW3mnxDv2PcOR3UadCbIyfV+pWmWXNg2W4H?=
 =?us-ascii?Q?VMHmxp7mlszGart/J9B9/B7zAmLreAMkytN4/8jtnHMt/MBOnzfTNk1Xb+xx?=
 =?us-ascii?Q?WJ5QDHTlbL+wZVUtRFKyKWnYuPrrGDtkhjQNxT+GOTf/kmdgrPfJeYmDv0QM?=
 =?us-ascii?Q?zaUjB+mtPwS1V9lDZS/D6huP0RC/BFmvkpinGQnEL5IaPKwBSBl5MfSj1yBF?=
 =?us-ascii?Q?eWnRyd04GLmCRfU23V0DW0lIUVfZoE3vmSvB9Otz3N2k1SkGIottntjP3EG3?=
 =?us-ascii?Q?h58fufzHjCOH3zZPKjHCP0LO38LCcqPXsvfUAXzd7pObUoifVXFMV+va5yvb?=
 =?us-ascii?Q?kNvs855U9/BMTRa4gk1Uc1bskG4wEGKHNgyU/Hr8tHNOk4JvwH/eN3ZNkr7D?=
 =?us-ascii?Q?tY3JBDxiNpCY/NFaD9TiB94JzjsAturFaCS+e9Jq5fvrorYCXCFhwIgu/9Bz?=
 =?us-ascii?Q?IcWTksN/+wbb2obsPMcPHad4AH/wlRjbYNjmONKCgBbaS/jkyTnqe6lVOccP?=
 =?us-ascii?Q?+mA5+1V1XyKcNLx6keXTEkJbhl7X/PjVk9IeSnJZ3ezhVbTiOR1ieX9S/S0J?=
 =?us-ascii?Q?QPeytxR9n+9RmVOOUkUNMN0epUuuom8ZftrrGivZGXm/6pxwMO/LGz5Mv+fz?=
 =?us-ascii?Q?NT4R4YI4qHLknw/W1NDdjpLOUSM+S5ITJl+Kqs4QQGcbWJT8AsP918oC+qUP?=
 =?us-ascii?Q?c/1gXs4ujPKgoAqKG0RjjGQnJ8g2aYUqAb8/+rRgPeGdqjr8bShQ+JEBpdhG?=
 =?us-ascii?Q?sr11w92KvA7ua3KUkhzsu/claya8uKrkJCpQUWPUed6uJ+SFGyXtHpLAH02Y?=
 =?us-ascii?Q?tj2vGXYQlc8JEurQiI69OG9ZQjWyCKG8V6lTqaW44a9RYkSQXH8gAP0ID0gx?=
 =?us-ascii?Q?ZteCmi9Ve3fF8okNvg8aj+eCnzmFp+r/Wt1/0rnDISPZF+UQIZKLykSDMr3v?=
 =?us-ascii?Q?XCsmvtOlyFYTAEHF0TiwPkQVr3FTR0bzpdI2DpOMxSZZUMCwaDhJYk5g5qPF?=
 =?us-ascii?Q?+7c/IAhf5OzwRhTA/z82hEYDoIDo9Ucx5HvAhN7J9lWDPWtmcvAwTMLknZUn?=
 =?us-ascii?Q?KH+txWIKBJlpvF04LQBYtQP1GoSBdixx55f78kGaBuNBKjK9M8XFnvvdCzE+?=
 =?us-ascii?Q?iN6VvdwA9+d1vZvm3JoQJz9m5hy0C+lWD4bI3aMzUxR0snEDn6Vp4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rRKsfA2kpk06NK5JehqphWGOOAvoSLxbTbneiP89523NekIiPRJ61fuqXEEp?=
 =?us-ascii?Q?4QIN9lh86PCOzyFG3a4RlHMRX3unXlU5MDrCM06ob1baUWQ6SMF6ctcGmxPj?=
 =?us-ascii?Q?NdYjiUSR1vxVw3bicNBxot2iLkbgn6gxOKwOaxUgrt6ZTgn0PsNFroY3NXvO?=
 =?us-ascii?Q?SHU92tMnS3dUwY79s59rwIf9cDnGBVXFFFOQq7ooCFYaJqSUsYfEJBsPaKVc?=
 =?us-ascii?Q?THfhSp23rj6xaGBq3trWVwXMsPDqMmFU9RJzx+YFpLmtaapPIMpCoJo/MACD?=
 =?us-ascii?Q?0JAjSIP5UG1USL3IXaW9lvJQQOfCV/haY9hZIXqwKx0z6bR9MMzqS5AP0x5p?=
 =?us-ascii?Q?Fe3xLe5MDU/zhnRQjIPJnk1NaCk829rABbA+D85iGLHSu8TQhkmfX0zwC06F?=
 =?us-ascii?Q?4AgChknQPSWFfrqbH7lCRV1LRdmLe5HM+TlxVbREIt54CHs54SGG2TlIc4wd?=
 =?us-ascii?Q?So4vlKDhs2aKsgMWq75874WWL1xD1QMb4EkDuvQIvt7LV3qKNYvhfoA35uOR?=
 =?us-ascii?Q?xQKAHnfqdW7ZUGhrrd6BV1Za4C4GP6cCKbzkYhPQZkogd9th76k4kEVKNX4g?=
 =?us-ascii?Q?dcIrmCDhLUHBK2gfkaxtUiFzv7ZGfkC2OaMvaZRNRDY5aAoZWorWmctQpVdE?=
 =?us-ascii?Q?pyR5/xi85RFs+dMvudPrDmDbS+u6dyoZsWBva1Q3x8xzx4MwlBUbpV9jgizv?=
 =?us-ascii?Q?hN+AV7tzcvmYpVcCKzsEfCKMQG6JK62mmv0++qUTjtgucL7pCpDtyVH3hsnh?=
 =?us-ascii?Q?26C1uyhvNDREbZC5qxEycuT7jHhNvcEw1GThBi2iFg0OtjzJ1W02liUZ6159?=
 =?us-ascii?Q?vXXkk6IZS4r/4SOCbn4Ij0cyYS7G67ULGAJUsfyo43E+QXVsnSUewxK9rrt3?=
 =?us-ascii?Q?9KV+V9CQkBzHHuoLddN6vbnZIl5qlmd0kn9667YyYjw9j3xbEfpBmLfuWdQG?=
 =?us-ascii?Q?YpvwyixP/WhrKFSvyzHjW5Wm3cyORpTuIklBtUGyF5HAYKlZ4MjuFeQHCu95?=
 =?us-ascii?Q?7H7Wj+rWoEAvPqhyP8o6iyp0Vw0TmRO/KcgLk/NRtVUtR3NyPcHuVLBIyC+y?=
 =?us-ascii?Q?dbjBv4I/SsgXC+LCykB9ELCEbcpGZSxdapzaRYvEkrLNi2SjbQHHIeLaHO+8?=
 =?us-ascii?Q?6oHeMRND3U5NQ/9f2RIj2M6QztXbaaPkuJismsxP/2TfTnhiuKcvc3p7RkPX?=
 =?us-ascii?Q?boVJ+NK2VOkjFmTvCbgKBEJ2fl51c8v+vvrBhV/z59+39pIblU1eDqOnevO0?=
 =?us-ascii?Q?nOyFAddSiXeMAbSWTWdfFoa5VWceOeBQdumHj/IXi0mgdNzcHVU04RsJuZ5u?=
 =?us-ascii?Q?K4E+vOOL/xVog577nZelahCL94TMnz29sL3ew4ZKk0Ep4MIA6BTRPK2M76CV?=
 =?us-ascii?Q?gkhTI/vzY9S4TUL27PCq7dclXrb6mwK86OHJHgpj64J9nrChhqRlWJP3yfHi?=
 =?us-ascii?Q?jrLnw4HzP7d5xmC6otaFRxm5bOBxrFVSSJkCkWN1WbPPLW6jfEIiOS6bWcCu?=
 =?us-ascii?Q?gVWtVRUgJ1Dbpo8cDREFkg9Yv0+e2dasvdU+W8iUtl4bmOvMunGdq1Voy3qy?=
 =?us-ascii?Q?JD9PM1rAnw3ZpcntLgA/7fhbkfKiWBoPhcdjQ2ch?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb41bdcf-ab7c-4310-2767-08dddffb2a1d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 15:06:39.4494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5M5DKr/upbqy1Kzz4OO8l1sYcZ8fO/22YyAw9FpTDTzrG+vUCzVTNuv7PwMLllgwT966w3R60QWwewzd6nAg2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8698

On Wed, Aug 20, 2025 at 04:10:47PM +0800, Richard Zhu wrote:
> If the ops has post_init callback, invoke it in dw_pcie_resume_noirq().
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

This one is independent patch

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Frank
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 952f8594b5012..f24f4cd5c278f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1079,6 +1079,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>
> +	if (pci->pp.ops->post_init)
> +		pci->pp.ops->post_init(&pci->pp);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
> --
> 2.37.1
>

