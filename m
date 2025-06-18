Return-Path: <linux-pci+bounces-30121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9CADF5D1
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 20:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF18A403F1C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1DC2F49F6;
	Wed, 18 Jun 2025 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CeM8lhck"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EAE224FA;
	Wed, 18 Jun 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271058; cv=fail; b=Uxruybx/lz8faI+dStmFIF0x6mL3lv8NzwXui9kTDCC4DLNhlKdzY6BdS3whwh6qSxyG9R6U4YnG+U8j/UFNBNarUhOpY10gniohGrT+jaZiR383L+DYwOse8WTZq9IYNaihkeLN1UKt3tJjyowNck/hm2HWkdQNPi8JhaXIyAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271058; c=relaxed/simple;
	bh=83AUb2siPA2T4ELh8iaA5gTSYbK5VxalpE7/YDMmRwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ez2ijzWWCb6WpXuBiE71G4nYVWGT9jzrH9ByzMPOKwpXx9CTea3R2Tg71QF3Y33Gbu932KfmoG4PW4zxTDMIZnQ5Uh82G71tVT169TisafXOYgPNQY8VEgBS25sTG/biMmhj5+jU+C5DaqcKJ9bxkbQRbzNa3FqTIT51TcZeWlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CeM8lhck; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouFWhzfUw6GxCuJNqE0/mzXERB7mHaSY4HJtzvbNGTNN31DXsxIg8SGgiqbzhsERVsSIpxqUd1OfE/IJf4DEHbqeBE32A8BsjmwHi3m/EPF+i6M1QqZqGnkGvCSpijzfnZWOEovpVInDymIz1fSrlqsQ9+ETnfKyjV/yGXzKgEP+MgcYRBBqW+TOZ2ghOZHRC4P9o8CNfdjdZfKV1yggzgxvUCtE4dCYoZ3qTIBSp7r1RuRNQYMOs9qH4SAk+by/u5zNKJoIett1T0tey8Fs6ZJ5oxbV6FdUCQpbiihn5+cZoRtJ8NI+VtqdH6Je2QcJ+9GBjfTAV3FSwgQmUZCCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALT8eoMO/8J8lftRcDnkTpnhJWHyWslQs52NhD1JfQE=;
 b=BGpHNYnePmPqAnBborLy3yTEL1OiDish6OrFjiuWCwB+HFj8I+k/n9xEv/1Br8tWlT/0YhLYDDhTngzvEh8QxuUb3ZH53y+AWu4R0+vMXwr6yGtKYAqWRQNgWjjrEIXMmkD3LhTtd+kjmaqMdbGY62LT/RKh+BqLcraSfC1o1gbrTS65qA+h1421DXP5b2KB28HyKeIpUaCcJtomxsw3OehVnCU9s5QXlfaQ3S6a4i16aAGXHhrSyNlmi0bWszNCINdg6cFBVH7CjHDHCBGJhF7XglYt833sITh/kPjAbBhU7c+SqrfHb6DHNlPj+MM+9PnAt14wU1EeiWrzL2yy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALT8eoMO/8J8lftRcDnkTpnhJWHyWslQs52NhD1JfQE=;
 b=CeM8lhckJkoyk85bln9BVsbF/rIWoBr83+GcN5ndCScnNfIzBxB4w0/QuA7Jkp2H67WOgk5RbyKBeP3Z/j0iz+KDjdsvSabQaRECTTCMS4MDlyXB6ayMtTFqqmd9Umdl+ITQtj0R4Fs+6o7u3zG0zM3N2bZVArp1Nwh3wqhtPHGnVHE385jWqCx4tT8jRvZMi5WmDUrdwmJ6tFb+BqoL4+hK+dMiQ4h5D2iA7g0/dJAgUSPZSBVAUJEhtszUoBciSEY9dFUP453DDDS8rKxPEpyRRNGPO/6OHPklufUCddPZydB8qIQJE12OcnuJcDRUJwmb6FLJQ1skGIfahKhVqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 18:24:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:24:14 +0000
Date: Wed, 18 Jun 2025 14:24:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] PCI: dwc: Don't return error when wait for link up
Message-ID: <aFMERHMxYRdMyi9Z@lizhi-Precision-Tower-5810>
References: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
 <20250618024116.3704579-6-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618024116.3704579-6-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: 790d2d6b-8c30-4561-f9cc-08ddae95543b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qBgb75sN4R+OMbIJVTbBWQilrVXEOtQYUHQl3iDuwYXwHxDMeYMccmtPE4uT?=
 =?us-ascii?Q?gDkNdwhPseqI3jA9sTeMPq1G3LCMWfoMAmsFHgJ0qTJSfy0gUjh5ThrdtTp1?=
 =?us-ascii?Q?cY148WdLlrDjGIPWd267YLnq/bHXd+8o2/AJbHULADjWo0cl0FyfJtTprmzd?=
 =?us-ascii?Q?/qdeI+uTtyAWoNS+2JXDAg11jU/J3XP7OpWJyGe5oDAtC0SqarHFA+sRk/Bw?=
 =?us-ascii?Q?fPLul5FENkfSksBELxmWK8hzN2g3UCM7vskByAPLxEUW7J+PNDf+hAZgABfn?=
 =?us-ascii?Q?dqr1q/G6s5crxuYCRsvW8MtEaGepMziCXWo26WXiYz7P7839/kcUAtEICs96?=
 =?us-ascii?Q?WE3IFAwVGGvfltIyWkxd25DehjzXyjlEtosUGessxQ4fvEbuSA2jiyfYXMIh?=
 =?us-ascii?Q?VJH4J82s5eTT+bBSzIvkkgKvvBfNp3K/9KwdvgsQTogLsY/TcSGVu4WYxBeY?=
 =?us-ascii?Q?M83Q1aP0JX8tThgzJ8xo8WyhfvfikTpUqYiyDcsIRQYZLjFfsW+acBY0YkvY?=
 =?us-ascii?Q?zjUtZIdky21EQUt8Cb4hSsMSinIcEWIs4S7itSs4MU4x7/S6r2uQVydjHone?=
 =?us-ascii?Q?kYhEOvz9gJmUcfFVn0YPzlwTM5wH/uWXHCoBlxrzTQ2XSIVPL87QfNu/mIJK?=
 =?us-ascii?Q?EGeA6Csw+tv54OQDZ8tmoFRwgxZKiHzOjjMHhYV01ridN9Bsi5kaBdWTq6aZ?=
 =?us-ascii?Q?4XeU0XO+I2SIBCZ7DI2RIqzwxEBhqikAOerNYDPd1HFEk3Yqa9n+BrjjZdP1?=
 =?us-ascii?Q?s8dRfSQp20SwXKS8Cjr0wmHhfja2CUVzGBFIMF/H8boQaivIfEv5ctWKEUXp?=
 =?us-ascii?Q?tgpcQi7zqK+/SFa4JHWDJjt9vRmPwAbIoQzAaeZtdT08/5qg+aC57gCL8f0a?=
 =?us-ascii?Q?3fHLF+mm3fliWlVrazE5sNYRbmJd2do/syVyapLHzY2LxgqWY9MYfhdhOpzn?=
 =?us-ascii?Q?pnNDNeiBKdvsOhCZUmXKMLAMEafUxqNWyDcOcpEoHg0zjnQld8z/OVVuKOuT?=
 =?us-ascii?Q?i8yHyKmHr55ol6qHmIUhEQPEuw6lZBNKNhWyDYqLyzBsdqMSld6o+L2BdAUJ?=
 =?us-ascii?Q?363jUaO4g1Hmbk0wx0xpmDzLbBNv/cj2CVuhHHOkAdGKeztX83f6kyAfmPUF?=
 =?us-ascii?Q?lBkTumfiVVgHQaKH+oyAZKsxbMfRl34Do0sEdSQjA8AJi/T82174uYxxYJh1?=
 =?us-ascii?Q?2aYyDYUpR4vjSaLOZTfPRaggVAkmTjzL/dK19GHWvSfiJJSmfzMDeBF7BaYD?=
 =?us-ascii?Q?oDzGK0vnjn6MxNDeI2VjzRuQbhsNDf1YDlKTyNVJQ56Jrtlwe6ZXcU5stQSL?=
 =?us-ascii?Q?U6KsxJ+dmE2Te73glfLcHKXtvwNlD7AIAdIaTTuD0qRryWlBbz8qdAppKDrq?=
 =?us-ascii?Q?MCyynqGOi6S0DeaMo47BWcpNB5+pGGpLGFc4cZABvkp9e96o/JMmPY8cX84d?=
 =?us-ascii?Q?zzdVwgkM0mO/hFZ71BHyg13b/WgpIOz7mSXQz+CQjJULwCfyJzIlFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5bcSwwPNrSy2bE+kclZ9+4UXg5l/VG5FKHWZlrTNdNO1Op2LjDtdsgK9Zb+m?=
 =?us-ascii?Q?gW5u7k+x87hG5L01DuHszvzR5UGOGnG3R94q2DdefmjEXSW9wwyHF28IHMLM?=
 =?us-ascii?Q?FRZeBnlbLKLdV/39NYhIG8kudMNfLwCevqcGd/sifLsS8zL+mOwH1NFTpcjV?=
 =?us-ascii?Q?VhW6RzZdaUuhDMVoAAEX8XIqXxe/fizwwrLDxB3vm/xYE/VrsULKeTxGJ+UF?=
 =?us-ascii?Q?zLhCxje3acUwcGYznoaxjGAThkHZ/k33JUhcohsTGOCXJGqtCbS5I/3LWKwg?=
 =?us-ascii?Q?cHw2xnAWbucSbU1kV8/985YR89/l3ZQBYfAmNkLViB8Uah4ulHvPX8Au3weO?=
 =?us-ascii?Q?O7beH3aECVh/5qJmQgLhSykWHYAPyBnfo77s7qwwg7C0kvtCWwG8Dn6wv0VZ?=
 =?us-ascii?Q?uwcqJox0HeBwkzy2rflTh+onhZH9mZ0v2krxxBXiN8TO85yZZgm/S/nl/rpj?=
 =?us-ascii?Q?z4m7Pmw14Y7HUKIlmj5SyaYAzr9toby1worm+bCoZYHllelPjCM6C8RRV7kC?=
 =?us-ascii?Q?kotRbAS6FRgrq8IdN+IT7/gi9jfrLfpPVuMjYXlFBzM6iy0TfNd9jQBwlrYr?=
 =?us-ascii?Q?EBLy1dXeB6KJ4YUE2ofidM5RBbQ7CDlAguPOKuMUGGUsa+QEDn7wCEVdHUhN?=
 =?us-ascii?Q?+Fte+xHSPlXIx+SotiU3mOlMzZMT6+BZRF+5KrEpCoZaOpzmqYr2ah116mi/?=
 =?us-ascii?Q?D80xJkVhgWRC6Z9StTTlvPPzYe8onDAcDbyEdHQfffCFgwUktDi1B6f+SPZ9?=
 =?us-ascii?Q?ZFMJo3XLw3ch3eMoH77paR9ggCPFU5vt5uAI2qBe9agCSvEZ+djwcguayzzs?=
 =?us-ascii?Q?MjgK34Pt0TgtWWWl/8e/zBwJgZ4dwf3NUWoKCRV5R9rqgu7tisVZZLNT50oK?=
 =?us-ascii?Q?OV81bgB4ClqKkr5EprkxYe/8LOag9mQuDxoIu4dOywn7GMoJ8hC5rtPUQW0I?=
 =?us-ascii?Q?KACqJ1hDl5KjckwV/0JR9RluPNq5z8TUgHKvOgw6nMiHAi9H7fdnYclIhrd8?=
 =?us-ascii?Q?/2BlAIPZCg73ug/Ci0XnQzWgeLgngozyBUY/WemeYCsTHnwn4Kk6JcfzMHYQ?=
 =?us-ascii?Q?ZPxkiccpZOLHE26oXi7HRMYGSMhGeiggFbJcWwKG0AZCEJ7U+vP0h0xSuKkF?=
 =?us-ascii?Q?hvLS6IpjnVUb7ta9AtoveJ6yJa10oK7hBmtODE5DoXnWwnNKPyzhDUcm95lk?=
 =?us-ascii?Q?RUcSi5CWd5nCxeY2E3J1S7l5Zip/qRZHTx0ed81NxmSdBNTSxG73XREh39TX?=
 =?us-ascii?Q?KYCZAj092KfNCrk9NaLSe2IOxaWvy6g4B5/A2Z0Qkfdm0xjAvLl7spp+70Y3?=
 =?us-ascii?Q?+Tqq6FIU5nwMzHTcxuBGTlc9f5JG99eYxFxWVKq3KUOlQh7WLwkNduS9AjyQ?=
 =?us-ascii?Q?d+1MIVohSjCmYs/7aFYL9FiZdTcOuQ2YV0GF+MXkKPE+VzFTsDo7yKFdqMG/?=
 =?us-ascii?Q?91gXDcDNaUgSRYe+/ybUZjcG9WIip2eBXGZM6/FOi6LVCkk2OFqH6WcjS6iN?=
 =?us-ascii?Q?wMBD66d2K17VWZSDD9SzUChtoL47jq20+nZNakcxfAidNmMx+i/OcQfLjJCz?=
 =?us-ascii?Q?rzqsaaJ3eqkyQ5LSGCdIxZ7rHkLX1UYMnz1nPI/g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790d2d6b-8c30-4561-f9cc-08ddae95543b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:24:14.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n/ywZGB12B0dNHihzoOn3NIsvLd5+TfPy03mqfC9E4yDASxuaGxCRHcEHKtWI5nEp01fQbVv0eIdAUIcjgLuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

On Wed, Jun 18, 2025 at 10:41:16AM +0800, Richard Zhu wrote:
> When wait for link up, both the link up and link down are normal
> results, not mistakes.
> Don't return error, since the results had been notified.

When waiting for the PCIe link to come up, both link up and link down are
valid results depending on the device state. Do not return an error, as
the outcome has already been reported in dw_pcie_wait_for_link().

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 228484e3ea4a..fe6997c9c1d5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1108,9 +1108,7 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>
> -	ret = dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		return ret;
> +	dw_pcie_wait_for_link(pci);
>
>  	return ret;
>  }
> --
> 2.37.1
>

