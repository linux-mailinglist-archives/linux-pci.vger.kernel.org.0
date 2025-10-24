Return-Path: <linux-pci+bounces-39297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A27C0829C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 23:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E78D434FBAD
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83518289E17;
	Fri, 24 Oct 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RT1n8hzb"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C32E2EF1;
	Fri, 24 Oct 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340598; cv=fail; b=TfdSclVSZ0YiOQ0jM/doM4vG+ZLkY5s7Y+m/3gzGF1Tlcu0diwX5JeKMePHHtmKxh/sr08oQNGbdZLtoGfe19Tu7gLdfnNigw0jWEbFKlTGd/1G6ESHzUh+UZGpb4zr9UKRzi0PJZqE8ptaktHGoGPBrktSmnPMuhVKgOzM7lW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340598; c=relaxed/simple;
	bh=s2mPOAGa59hKeqjXY5qgjOy/tq+WeyO+u85gs/ksUtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=USc2M4SGpTciMfKac9jRFiWWtB1xFKR2f1egk9lvTpOmH7BUFJfoPZzLULXWSURn5r71AiElc1zEg6cx9MrBufHrXnyWaQYpSLPHK+r9I/lJqstEjHeH2c1ir9WNs45EBnc4WniuWqHWE26tD+cPImADPkK4HweLYA/aDXoeIZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RT1n8hzb; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMFL1pznkplgElDWZjNhC4nsD7rs4IVI3vJS3FPCIv1bixsMLqOXizYx2FQ04grwFgQ2sKsmamRTB6M37w7hwinyh196jOAeyfu2S5+PQb3QhXjDY6Y1/J87QTPhmxc+MOmS7tTKu5Ox76R7PRtFMY3sCsdpCqCtyn0OwEXOwEhiTNWWM5oHDHOQShXYpjtTYkqEzEhpjdu7VQxkp2qmINxsa+0pkTXW/m9bu8Z2gcZc7ExegRMi+cBkXmcH+CV8tRx8h7IHD7jHVGW2s3hNQF7Dzt66jb8wcLDqRRvXlEiS0BpExuNlwdKQlL8fqy1qUrf7C+wOU3/4dA7OdvGOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXiJ5gqDegtjT4fEsjkXl9K6aaAkpr60p/WFV7Lb+ts=;
 b=TMWAzu5XDkoRKc6n/wxLKqUXCzgHI3RAD+bXFCjPxQ19FSjaHLIMmoV83e5hALKeu8Y6rm3PHHm5iiGyK1luZImvVYK4S1S3w2wFcFjL+Ow0u+xbqonHjn9urXtsUhxn0Tp0bRdG2Tu/Qgow/QIS+99XPQVmAyFa73Fjui3QS8V9T/Xc44beI6trX686ob3cR3XQn3GLjM6ssyKDOQD8MxNgQrxLxL7B7juM76AlUQxF528BGY9ZPumOb+/rUwnOsumnf3gbDc3OB779e5KmbAABbdDOvs23OgWjsoQwAy1b84GMjnM4rjvNZAWiMdX73Jy8S7E/VZG3XNU3sxJdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXiJ5gqDegtjT4fEsjkXl9K6aaAkpr60p/WFV7Lb+ts=;
 b=RT1n8hzb+OIcOOiHLD2zVgP7x7FeCfObeby29NnGKagteUolyB9q5OjecEj7u358Ouog4x60LTDBQ7VYGKjDgWFl/JIT3d1ZIOePePWuoByRVo31Usm+DfA2kXoJ/8F03kJ8qz2gH0LJuEUBdJ7hS49tAuL9fU7cPDs+vLHVZ9fwjeUe2dZAeckXEOilAVky1wmFj56SpI2wmCaiSayVONZWpvJZppkgSbzXeBG5XpvBYYVbY1yBQjPM7DuAfx7tc4L+yflaAv1vDzpOBp9yVlAy3nAUxqNvXg68KvcBypVy+isNuUhVB2Oz0Ze1h/gNail+BScMffB5e1NnZHy27g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV4PR04MB11729.eurprd04.prod.outlook.com (2603:10a6:150:2da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 21:16:29 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 21:16:29 +0000
Date: Fri, 24 Oct 2025 17:16:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com,
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH 3/6] PCI: endpoint: pci-epf-vntb: Remove duplicate
 resource teardown
Message-ID: <aPvspDh6VJYjCjyS@lizhi-Precision-Tower-5810>
References: <20251023071757.901181-1-den@valinux.co.jp>
 <20251023071757.901181-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023071757.901181-4-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV4PR04MB11729:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da243fa-9e4d-482d-c475-08de134298f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b1IKB1iwdSa8j55dH/h/bMqgIeaJ0E0GE8peZqBdJ42SHyeEjlgb03RnoMG/?=
 =?us-ascii?Q?JetF03FWgZ+gExvV/9b6653eM0dTipJtQZU8pU/m12g4IkiWRp/5qpDx+TkI?=
 =?us-ascii?Q?rqXMXFJ5PqH91uibaMx+HzIc6o+pHL/7nWCPoaEx3194O+mvMPb8CSTUbCUR?=
 =?us-ascii?Q?NPWxwxbKGqwcdfx7AUvQhtZkCrx7xz5DpsccXvEH33+MdfSjKEHH1AoMg45I?=
 =?us-ascii?Q?GNR2iilwe6Xxn4zJ8x9Bi74AEyyBNBuk0hCtZBa2PQtEzgbyC9a9sbNp64/I?=
 =?us-ascii?Q?LL/4gQ7Yy6LB6HHeeRAnok96oF5sOahao6NvHrZeXp3A0I9umHYIRorYKFrg?=
 =?us-ascii?Q?OWvPp85S/NH/LvqNgI/HWQrqhqcDwWXOak6CMpCmqClgHND7zgLL8N0JQav9?=
 =?us-ascii?Q?WRwmw378o9nmKk0fJhAVTly0cTWGk9HkwXHHUWaN0KqyEFb0zm809Us/wUjc?=
 =?us-ascii?Q?Mzhcbxst7g+1rhzu57oEuB4sF4fpjzg2YFoOha5AipZIKd2S9Aw2Zg9MqoaU?=
 =?us-ascii?Q?T4jTTKDClLGjuXW1XjN4a1p7etR6Y1GibRIDpdYq8wy+9yCVu1oayEwOgjcA?=
 =?us-ascii?Q?M4z9Vuc2IhLEdV9Ibork26hmIzaKao80rAWSZXvqi8hJ8VMCN8nMcE3M/xbs?=
 =?us-ascii?Q?p6YR7fPL0v2VXtK3XsHGt5Ku5QGxNOnAHyiBiJDt3v9pe1K18RDzmHG+YxbW?=
 =?us-ascii?Q?V8F4A7CKeLdfKLsmp5ycip7cFQVZTkSBeMJ8ZXJtekqW7mjCcwQBtCoQJ/kt?=
 =?us-ascii?Q?oUP1yfIPG14u9a+Zkf98y60mhyYtS58RwDUgL0hyh0giMNWnVvOcNAz81hGx?=
 =?us-ascii?Q?E0rYzLTeRfAL9QF+rPk4Uor9h9KYEMdcUh9hnoQqOYPjzn96qXxIQYwCJ4SE?=
 =?us-ascii?Q?U9FEpYI27MAhGv3M+HGhxRZX64SLfa/YhCEwK4NpM6nEsEHHPtW2XuP+uV5a?=
 =?us-ascii?Q?xdfM+0tC9NK4iUAhW8TTLf8xFafADnfxGPbvhwUg8EZuSJbameoFQcpt8Z/c?=
 =?us-ascii?Q?W1ETLGoLwBZ4CPU7008EZOj4xdW624nI8aK6uNTkF37bf+BAzeWToa31iPtq?=
 =?us-ascii?Q?hDmLKSIhYrMXqbO1DrOLSBjQdOEUXXJDKRTtL5txXbr/FNch870H/v7M6yoZ?=
 =?us-ascii?Q?tsv/xsG7E5HGzw506jojAqL/OaoRkSaa7aeaE3jU/22bgYqXMwjR24j+p+Gm?=
 =?us-ascii?Q?eArDMaAzO8ODeyRUSHkTRbooWT0sVxb0P/q6KNnADbhGOhyPtrYjTcFlvT/1?=
 =?us-ascii?Q?cN4FgIgLYfjGnMV2348zOmesqpVBhxmpCdvHGW2Qvxflh5L1+NoZc9WWcBN8?=
 =?us-ascii?Q?eGEXsiku4VhUVr5BvifLeGi/vPJFTukoVrXSU2jZz3jITrQe5V0h1/yxJRQD?=
 =?us-ascii?Q?7ETNrVbnyG03UYemDXa93+1GpUbt5MN3iMdoqIY0I0bSmAz7tp/xwGRRRAQ7?=
 =?us-ascii?Q?m9DI2JNPPuSRmir28ZRKkxos0j0uiU6BnDZmzMSYkwqYADUqXOdoefeMy/Wu?=
 =?us-ascii?Q?Kom2v9EXPjLRucTE9mB/HicqNvpPYYwOISy9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pdFSFJAUZDakuntGpWugbt6lb8GMtIW0gDdUn7hmYoaxZte64WLcFkJXAt+Y?=
 =?us-ascii?Q?3bIAfxQaw9uSKxlsbpd+yEKmHxhJ35WPSRZkhstXTKF8MXKfTt8g6TBhKkNt?=
 =?us-ascii?Q?GE1iWzBwKveGAVWypmtouhA/EP40gsdWqAL5eZPsTAwrn0t97aLc+lI4vNrk?=
 =?us-ascii?Q?15MnUfOwhcLyYQLMd009bQvnvLsvfPZQPeNVlGMIbH6AN0cPosot259pBBI/?=
 =?us-ascii?Q?FKnfj4vByhFt6BSNpgQULWzYfMdPOPAtmcefO6XmsN6RSnpYwS4HtQJKpfDF?=
 =?us-ascii?Q?ebFIbp6UDYEPZeZzyqxNJOPJ9+fezvW1Z7Y6S3AqK6uOojl+tlA5IcJ5wFK2?=
 =?us-ascii?Q?d/8XiCXlPVNagJjTTOtHy19TeI9CZAolJwQpfWTRMoQUO8ybOvxClWUimcdC?=
 =?us-ascii?Q?c73YAw+3nF+FAFFIMtybeMCHuwyMqqdrcbK3UtylNYVw4WtbLL+QlKcLhgwy?=
 =?us-ascii?Q?cC+wiFRfEoeBwrgopqzQfsne0MZrJFLCcM+skL4IsLFew0U0DRXoRrKKx3kL?=
 =?us-ascii?Q?1+dpPGSMEE8apnWdtSn1YDHw5s3rd0dVNZLtW+JqnUB1EmNLQ6Eh+FmtMny7?=
 =?us-ascii?Q?mgsFsUTt+9buG7fN5P+YZOcKQACmJijzk/ESxc2Gdc7j+368A+RFW8fsTRTE?=
 =?us-ascii?Q?cl1SQw6vDkjuE065hiSQ13UWG/b/lMVnm0Wb/abwAfTYqAs8wfvncx+BA8FO?=
 =?us-ascii?Q?/fW94G9UDlCzcfucxERbyMrbdkyl1KnOoBoYelXeBue6MFjgtYMazITKEUc9?=
 =?us-ascii?Q?zngKaO0fy7DzvNY748yIRSCNvqOlZNe4yZItxaSzW+s2m/DHIVXsPymiljhL?=
 =?us-ascii?Q?5NJawfdPzDZroyCi7D5+r4A77n8YmXOQw4oRxeQPKSDKFSDGITxDe562KgM2?=
 =?us-ascii?Q?td8RC2tjBsCRHH4OADqUbkRS7oe8Ai0e6fELLC3x/wPaPrj/cwQUmA3m3e56?=
 =?us-ascii?Q?UtOogR4o03H84aRTloxiRTlfLpF7Ls5WoZwkfgEJCkkmjBr3btIz5md4uIJL?=
 =?us-ascii?Q?2XhNEe3s+HE0kv5jbIGqE752LKq8REA25KfndjzCxDhGck8CNiSUfksSDf0s?=
 =?us-ascii?Q?RW73yFoevtIzE9mUx382DfqkTLe5+vFQpnb5JQpv6TW8jdTxjCM6Tm8OYuqS?=
 =?us-ascii?Q?yLmxNR8UWkAKbh1IoTu67OMtOKP8dX8Yr9LVwk9HPhfTQwyCJDTVWebMeLp7?=
 =?us-ascii?Q?Wwl0pdT7ONTdz+6m5CweJOz6rsWQgxHTzy2+tTQyiW/gAOt8cVucI9AA9qE8?=
 =?us-ascii?Q?tF39edE/XLkF6Dmv76/V/815KwV56wC3T7ZJSkuXB8w8lyWK7hD48a4wmS10?=
 =?us-ascii?Q?9FsH9CEOcpWB5YDI00lRwKVJuCPNtTnulZGhCLXAqLU+WH0EgusVMDwmh2H+?=
 =?us-ascii?Q?BWj2J4HdqM3r8/7i1g9D0Lgno9ucXH8RDe6XbPkQJvTJdqnRQO3CAJlK7vP3?=
 =?us-ascii?Q?b112skC5cDz86ulbEEUxa5DNoKYO1oxNjKo0V7p1hFg/patdQuIYDzEs58np?=
 =?us-ascii?Q?xZzEZA1GPCgbrzY9n6HT6xcL1Ht40YDEvi9ZJt48QsD1/i+pAIwcU0YfXjbA?=
 =?us-ascii?Q?7NZE1iLbvF/o9AnYGb0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da243fa-9e4d-482d-c475-08de134298f3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 21:16:29.0161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spP/qwHKlDD2RCvhmICpAR93atyd3yY5PrK96YxFo9XwIUQoESjZ/zp46MeZvAZWjvPH2IZ1bnvzDhbGtUVoEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11729

On Thu, Oct 23, 2025 at 04:17:54PM +0900, Koichiro Den wrote:
> epf_ntb_epc_destroy() duplicates the teardown that the caller is
> supposed to perform later. This leads to an oops when .allow_link fails
> or when .drop_link is performed. The following is an example oops of the
> former case:
>
>   Unable to handle kernel paging request at virtual address dead000000000108
>   [...]
>   [dead000000000108] address between user and kernel address ranges
>   Internal error: Oops: 0000000096000044 [#1]  SMP
>   [...]
>   Call trace:
>    pci_epc_remove_epf+0x78/0xe0 (P)
>    pci_primary_epc_epf_link+0x88/0xa8
>    configfs_symlink+0x1f4/0x5a0
>    vfs_symlink+0x134/0x1d8
>    do_symlinkat+0x88/0x138
>    __arm64_sys_symlinkat+0x74/0xe0
>   [...]
>
> Remove the helper, and drop pci_epc_put(). EPC device refcounting is
> tied to the configfs EPC group lifetime, and pci_epc_put() in the
> .drop_link path is sufficient.
>
> Cc: <stable@vger.kernel.org>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Frank Li <Frank.Li@nxp.com>


> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 83e9ab10f9c4..49ce5d4b0ee5 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -644,19 +644,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  	}
>  }
>
> -/**
> - * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
> - * @ntb: NTB device that facilitates communication between HOST and VHOST
> - *
> - * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
> - */
> -static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
> -{
> -	pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
> -	pci_epc_put(ntb->epf->epc);
> -}
> -
> -
>  /**
>   * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
> @@ -1406,7 +1393,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  	ret = epf_ntb_init_epc_bar(ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to create NTB EPC\n");
> -		goto err_bar_init;
> +		return ret;
>  	}
>
>  	ret = epf_ntb_config_spad_bar_alloc(ntb);
> @@ -1446,9 +1433,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  err_bar_alloc:
>  	epf_ntb_config_spad_bar_free(ntb);
>
> -err_bar_init:
> -	epf_ntb_epc_destroy(ntb);
> -
>  	return ret;
>  }
>
> @@ -1464,7 +1448,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
>
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> -	epf_ntb_epc_destroy(ntb);
>
>  	pci_unregister_driver(&vntb_pci_driver);
>  }
> --
> 2.48.1
>

