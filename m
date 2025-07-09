Return-Path: <linux-pci+bounces-31821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E422AFF3C1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 23:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDD55A6BFA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 21:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434723ABA9;
	Wed,  9 Jul 2025 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mRduUWvY"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8FD13B797;
	Wed,  9 Jul 2025 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752095702; cv=fail; b=APef67lUOZe6jC/UBdEPtROxEUdqt41FoOLaI5avXQxeOfF03UZ/7q6PSqwIpcr6ZcoLdru286KXN/LOCA7bgJXIkftQK/SC6C2pkPwyySkb/NcaJsy3NIS/D3735xfonPLThdfe1EcIKlbphkBk5EXLcM76JHwO8LTIDYZudrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752095702; c=relaxed/simple;
	bh=J6F1TWv5sjGFNZb0/z47HYcJhsHbA5rHJDBuAa6hPas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UZuWNRS/7UGerYKz4kdvvSJe2e7kYIASPrCRTkZ/P00W7sADVnEqlpgnFtG/ctcwJdwPeCrBOka15RfebW9znvWbEa2+pn9YdQygtnDR6QkTdwe2cdqr+G7FVicIePrKQBrxyYupyD6uhShfq/vhoiINpdkerjqjXllGiho325I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mRduUWvY; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4RS+LWRXfTZNPVNq3OO+E5+IPy/XBgQCCD9VOOF5zIJPdHGkifAov9N1WEsLDMws3g4TWb0EJyQ4beEaR5MhkwTlLZmgI7f2Ab1b2HnxVOUTklz0byPRBT5nYS5NLzXEAu8GdOvaV1DiwdVF0C4AuyJb3QnjKoM0PoMV0hsT5m2MXzywCv8x7neukPqoCn+6z3lBoOUDyMcDO+xFu+5hJrzzzyuuixv5c9XPN+sxKfLB1b6O6LFBvMnzCIecL6NxhMWHN5RyzddkWVBX4R2kitfNXTs5K5AHs5pIloi0zrOHUK/ub9Yfxw5OrDsgWhN86lwKjagT1vlBPdl7iZrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM0uMSlN5/5UJ27x8S3d/l13kuMwJe70Ia6Yp0NhpoU=;
 b=hngjtt7ogpsvgetmJgeqpZ5IcDgDvOmdVG8otMHDFf/nkplrWfD5Dc25N+VCB+ViJ34IZ20/luz7+KTVLv9bxOoV0ZMdFH+80StG3YwekorEs6S1xziawPRQPdsuXRf49JwfVoSX1OJV1ytkaWNngC+zw5Fk+09c1di2ogxSjXrN+nAxeOmvYhXmTIqkgXp92NJ7vfU9xAHnok+QqkFNxCvPGCRUwGl7dpmvdITBRUMadAO2yDNzyiEw5S70TsJRLboTOuxwYogPMMsRDTvFO8Vl2A3UG8ItdOOnBudzcqEw/h/n/Tmf/95ijkz/U/L9Z4HBXn9UVh9b5ey5KO00/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM0uMSlN5/5UJ27x8S3d/l13kuMwJe70Ia6Yp0NhpoU=;
 b=mRduUWvYxcniiVkVNr+meR0FX9KblLqA+BdKGI5WD9kkYo3brVHJuT1gNOJp/VHQwsZF7zRVVdS1UX5Tip3GyEQxsafuxXCgZP3t5BOucKIe5rK+oiQX1Y1743mkeQIJt1UEhxWrOgYj3CM9HuCuLFCwD3G98tGiLohQzLMQHKtbD1HLzUU7wWsn9YnIURXKCVyUuAuMSr+mcAxR3A72i8Vl4cod0+ooCA5MeeTdqesjfq2BRqJpsMBxbxA0zZkAEWXrqC2M4c0zl3yuwB/oYQsIFLjyG4xfTSTvRy4hyd0k4wUnuqeHSr5ZHjiO+SnF6+XDIKJoB0o3xhOMP5eN1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10948.eurprd04.prod.outlook.com (2603:10a6:150:222::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 21:14:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 21:14:57 +0000
Date: Wed, 9 Jul 2025 17:14:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	kwilczynski@kernel.org, bhelgaas@google.com, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Fix the incorrect usage of
 __iomem attribute
Message-ID: <aG7byxE2UmzpIQr3@lizhi-Precision-Tower-5810>
References: <20250709125022.22524-1-mani@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709125022.22524-1-mani@kernel.org>
X-ClientProxiedBy: AS4P190CA0031.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10948:EE_
X-MS-Office365-Filtering-Correlation-Id: befa8ef5-fe3e-4317-bd11-08ddbf2da80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nuy7jNi08h7KvsPLH6UDmBnU/4Les1cpZ7rrAKryU+fQh/aW+4R6fXyPhd1A?=
 =?us-ascii?Q?ZrhRgVh6gtas880pAnRDqYiRW5M+ikYw5Ta65r+tMwbDmZsNEOlNSMLDAhyJ?=
 =?us-ascii?Q?hQhwLqDIDxHgnHjbZjrq6YXlRIQjTw8r+/UrOCKh1yS4vzdfdK9pD9Xhrv1i?=
 =?us-ascii?Q?ccgcyI+Vjpg8LYr7Qbo4b7nFXNKAKIWDcdJZA2unkooMvY/qt68WVGOiR1Y/?=
 =?us-ascii?Q?1O8ClZ+mNdgmDfUVijclpX5JkXEbfGBnqvW+TyIjT1opcoDN9RYtVXt7lBUb?=
 =?us-ascii?Q?8JjB8mzK/VwFI3r7voiyF1uAFo3nk0tMEhwGzVCk4kYRCJSjAMIke2QmXNnx?=
 =?us-ascii?Q?HpHUo12oXGIZLvRc8Sp8lU2lwPar+hZsms88v3eam+XgCLjh9+teI3siV9Y0?=
 =?us-ascii?Q?POEpBnnkUQ7rve3Xf66YfMS8cb6qBER6FjOMQHr04XuJFn8z/uggoQCredGB?=
 =?us-ascii?Q?cXQ4Ogr/nMgeYv5ob3PpzLuvVr9RujEclW5bQx61zjjy/31Ni6+TIQT+0Ohu?=
 =?us-ascii?Q?cyTxFtv1BersefF02cX9t4k0ACqpTOgjw4vD7VbHQGestbUAfimd0QGGd0CB?=
 =?us-ascii?Q?SA+YpLmmy5lOSilRpwMNYRdQwzWwyM/FO2XYh5rHFsrcdLvAm05S4pBNzSK1?=
 =?us-ascii?Q?IAFeAr44N6/Fmp9NInyhlNv8Zba069qR8PvcIAVrYikvXTZo+NFE2E6Msfcz?=
 =?us-ascii?Q?Fe4xMgC0PtdizinTsDq07wsIu7T6P6MJboh1vFSqhXMjJ06U7TceKB3BYCpf?=
 =?us-ascii?Q?jINC1e+IMRrv70yV5t7b1Pusp/9xXEKaiAw8BbTx/eS8suWGGX+vCdzFxUDA?=
 =?us-ascii?Q?C7GmDzb1uif+e2nBA/NhSDxt7BZF7BYGGZu321UAWcSAeQ+C08V/LUq1vpTE?=
 =?us-ascii?Q?LAg7HSK7lBEL+2gYF/+/De+oQ3RNyOa48Xt3E+wk1rVl1IxeMocZqCVB8ctK?=
 =?us-ascii?Q?gyeKd82S0YnGjMay/iZY4WWDOezzXwl+FibO6lOs6FX50cJ0fRkZ2n7p6So1?=
 =?us-ascii?Q?BnpoC/+p/2l8KvWSX6R7F237dtGUxkDdrP3m42gqQBaXWNUXA86aoi7EMqtE?=
 =?us-ascii?Q?ujpwMvnjkZXa7cfN7fPQ5zMonMvxk1Ei616dnMElCbqfuBZR63OpUvMKK+7r?=
 =?us-ascii?Q?Q4cFZVKVDsD5vHjv5sI/4zlsKOm2VNIPdEuRix3tGgXZCLqAByaPQOV3NUBx?=
 =?us-ascii?Q?VKRjWusB5HzbqfW4R9VFy8W9SG2B6wRO1XeMMAj9MqHTVRNIeWLsITGDRCbx?=
 =?us-ascii?Q?5vRf2XA5+Yofpx8b0LxYt9nCS69uQ2RkOTu4XQt5eAiDqlSwqOXP0fvkozxz?=
 =?us-ascii?Q?xzuiAhsp3aI8vXDKIKZAUgYkideTe6qF5wBaXlFX3IT6N8BBqOuiV8wWv3s5?=
 =?us-ascii?Q?1K3EiHLm079n3KtDiy7ejNxc/8JIq1ZtwDQ9Z9SgXS8xg2JUOJesxrqAmaxj?=
 =?us-ascii?Q?Zbj42mEtkVid7NNLtJYDJF8aiQuEKEGlhPvE0JLwbF1htVWH/Qakog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R92TrGH/z0l5BaSB9qr1wC8i03/UoPqNjkylNR0cXS7ywSXOZT2JvZlkTMuR?=
 =?us-ascii?Q?COnkEjpwIxbtqtcZpdElfX9xlPItOyLlJwXTEV4y0kugh4pOx9/ApZ33HXZn?=
 =?us-ascii?Q?+6AMCbq+7Ol1NRVZetidLn6UvSNp6s9IpeP2+LMFm8zE3IYH4x5e2ZTzUyzS?=
 =?us-ascii?Q?jQlk/b59GR1pH3AYXPUfBE6drNyNk2Q5EVRpxFcMPiWtIlGq0o62t65tsvVm?=
 =?us-ascii?Q?nTMLAkS3gVPtbSrDEYDrb0XaPKLK8sQEUTb1T9BNkhpakcyRqsHtZ5lPFXR/?=
 =?us-ascii?Q?Q54Qtq+Bq2N0T1Uuefk1Wbn/iTd8t9MW5W3hdNuqn7kuSL1Glov1RBmQpGjX?=
 =?us-ascii?Q?nmeIHmLK+V6H9Y9mNctpJK1toUAHlQpygtlm+BAL+pn0DJmqgdHE9gbSgWbT?=
 =?us-ascii?Q?sTZ3aHGfjkSXCjdJ3f3lOnkbzqRsHniXVzGo4ONfk12KgglmMm/7I+QXn3q1?=
 =?us-ascii?Q?ksgFsY9N5+eEb9I32uJYaWJjkmpssOKCJnGqK9t/yO0swKAeImQpPWmchjiQ?=
 =?us-ascii?Q?kgAoTHACQPt/DlGN4ZpvGzmSOZprWD02AY4XKjlk6TRDsBp1d7Tx1y3glKvB?=
 =?us-ascii?Q?qWrM9j7CIIrFgWFIN5Oi8e7ElKNfp67jWTgR4JLXqRQu//GaCmGTfQRaQPDI?=
 =?us-ascii?Q?Kk7wYVVQX/DU6BQmnA5CN73YviYwegM+Gmn4/XdrGDlDIQpPs5GrugqETgOE?=
 =?us-ascii?Q?/YyaTyFYyXvVrbu158lHngMXrUwm9ErOaBthKSwIaFOU+50pJw8z8QsR0KQJ?=
 =?us-ascii?Q?nSuOOzs+jt+UyACynSXHgZGCJzXjdPdIoAUpAZwMcEHeiQxKIcT9Fz1GewsA?=
 =?us-ascii?Q?wgVcFaSuBdtTYBJWpIqj7Cxxl4ceTxxY36pj9Yfz5LSylIsWFQBqqDTHa7LV?=
 =?us-ascii?Q?6KyImaBO1saEj9xmF3E/ilAQ3No+DGMVS3dhcmSuCwfXkRqQbjyv+63Wda9C?=
 =?us-ascii?Q?OwLTmFnDQQ6YNKZDqycrSX7ckS9Dgh6GkAyisZiHf3fyMD1Mz9sCtPLWkkak?=
 =?us-ascii?Q?Ngs/VqllMhok99AJe5Vj1qBTb2mR6USteh4N5zRUwNmb0rZ28bZeolDhYNoT?=
 =?us-ascii?Q?tOxt4vdi0oxrlVBm+fNMzkZeQayqPsWEQJXUl+me5cDlvoJ9ii7vdsP1VcoB?=
 =?us-ascii?Q?8UL2LOOfk4aOSjgGllcSGUISnCTvabt4LaWnvFbvj9OA/DdUIZbpkWezkKN1?=
 =?us-ascii?Q?7rT/kGisOgYmG04BiexBz1WVe3lOoYsrgiQY0A4E1ThBEyxm1pwwRBeKpVNW?=
 =?us-ascii?Q?eeUamovPWokC72dnKJy0UMH1DOuYn3SUngLqZ4ZwJI0LVgV2Wkq4U8G4DXgb?=
 =?us-ascii?Q?sbkVQDqnjucSlKDKS/PcVHpmbg+3kgLTtrX76CO0TQjdZ5ie6nRFDjLWaxou?=
 =?us-ascii?Q?r0PewSJHqg39e1o4u1Dd+1gQr4ME9N585S5yMPtpwXO1Wud3nNp9h6ah/ivA?=
 =?us-ascii?Q?9eOm9KEDvVWisN7XfZ9H1N6vCfHs+9hDb6PLYlMt8bP+02QVsECkC2WCNJn/?=
 =?us-ascii?Q?oFy3uSAjzyBSeYZVq495xiqr2eGIdZiPYbunDS0FFdPAKOF7Vcg89HqAJt6V?=
 =?us-ascii?Q?oUcfZI4vdOznao1sd9E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befa8ef5-fe3e-4317-bd11-08ddbf2da80a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 21:14:57.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkInNWfjldBYuiLYYywQbuIv6Ed41hJcGZ42MVxTGlKJbXdMTWUDUDDHAHkjc+9CoFuc0tdUAliDNdMC6Y/6/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10948

On Wed, Jul 09, 2025 at 06:20:22PM +0530, Manivannan Sadhasivam wrote:
> __iomem attribute is supposed to be used only with variables holding the
> MMIO pointer. But here, 'mw_addr' variable is just holding a 'void *'
> returned by pci_epf_alloc_space(). So annotating it with __iomem is clearly
> wrong. Hence, drop the attribute.
>
> This also fixes the below sparse warning:
>
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17: warning: incorrect type in assignment (different address spaces)
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17:    expected void [noderef] __iomem *mw_addr
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17:    got void *
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21: warning: incorrect type in assignment (different address spaces)
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21:    expected unsigned int [usertype] *epf_db
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21:    got void [noderef] __iomem *mw_addr
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38: warning: incorrect type in argument 2 (different address spaces)
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38:    expected void *addr
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38:    got void [noderef] __iomem *mw_addr
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ac83a6dc6116..83e9ab10f9c4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -512,7 +512,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	struct device *dev = &ntb->epf->dev;
>  	int ret;
>  	struct pci_epf_bar *epf_bar;
> -	void __iomem *mw_addr;
> +	void *mw_addr;
>  	enum pci_barno barno;
>  	size_t size = sizeof(u32) * ntb->db_count;
>
> --
> 2.45.2
>

