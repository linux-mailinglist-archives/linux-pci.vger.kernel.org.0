Return-Path: <linux-pci+bounces-39275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA3C0712E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1171C2018E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9632DF155;
	Fri, 24 Oct 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bLaL/AVl"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB1328B45;
	Fri, 24 Oct 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320944; cv=fail; b=NQe+VE129QFNKlSyIHz+4QLLadaolGG+DVrDI3IKyQGlXFJ+QvqBmM17GuBXsSTJumrg2UyyJ++qoKDYpn84hoLQzH0WZfhO9iLA3iLLNpcf+JdS1RuMTDLbI/YcMEGQhHRMn1kMC4wW68OZrLPwxonEEf574EVdPP3V1CELA1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320944; c=relaxed/simple;
	bh=JYKJpObeGWOUjNDfBxT5MK/VT/5otNlwHmCYImC6gxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AZ8C8jZK7S0lbSJ7a764ZV9D2kgv+PQc7Z7QXqqx7+pNH2bQ2VO50gehGgD1ndtP0aG28BJt+F0gHnGTg46KB68OBn39XW6Y7k+UvnBDIseJrwwi4Ref1SnBGvguLebMsHhjCkdnzCccSa3Gvxwr3eTmu321ReDh4Xolr5NY8lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bLaL/AVl; arc=fail smtp.client-ip=52.101.83.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okG8X/D4ZuxAQekkWzXKOlLMqFvStn1d7NkuSMYsy0iP6J6x9VfThfz3F8JvnhBwiU8Pg0z9wKoFP//B+mQ36AIqr39NLWVWLYYas+tF8phv57TFoR/Pa94WntxMaafktn7V6p1GalCj7zcn/QqYnYtPQPtQQwnVoW2ouojmMFScO3meUlBHJGEfVofXOwJs6lJfPja+9kzzVvEglEGOF6toD1G/m81gHx17Nk8dxFdAU9HwckV1Vt9O9cZL35knJ4otJ6rd5cgBvfHnvumgPIKcfyocxWXamjwy5+FY1bi3amBdQxDpKacij68dCxu42Z3ZIGCtgd9tGU1dtRdaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57QV4UZp2ik5ylZLObWAsfm0Ttk1x4ou4MpwFgt31IU=;
 b=CsSIPbhoGt3HpjitoL1srjwGeIAyz1T+PDh+1v3Q5crdlQvyFPbmQ3BYbQwgmxWo7feTQoTTb1f+icF4G9iqThnP35W88rei9ke6aion5HHlZAbjklFBfEiao1hknS1HtVyAX46GbM5KFyl44aAXC1ekz8N2zDb7JcfNiXXVgpYDEA7VjC89SQht0bcNi98SxD7ELc7Vbks0/NQwZZWOL7vufzUQ8BOcnVMpLpRX0wgBme3btX4nvmC7Vfx8Y+hK2ynNfjIg5ZLke7nQFlrAFIWCFrHsNRsOQbpJcyqbnsBHn3CxKloZxbJUvP5Gy3APw1e+ut6V3iGFikm6SGn0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57QV4UZp2ik5ylZLObWAsfm0Ttk1x4ou4MpwFgt31IU=;
 b=bLaL/AVlmylPptfjp+E35O4UTYBeYC6xHxvProhCsI/5jyyPL7WKow1TCxQfvDYxMsxpGkXOBajSPn+Ok+VYM9K53mVXR+IW/dlJRrjAYJWCITnm9JyJvLL2+G2/0p52tB/qCdliC73p5fDwHvveuZd9nBe5qPFi7//AqOGnpMZBo0cB4NtrLNIOiVTGzQG2IWMr/3sVCqJq+LhM4WSbO5hsNd9Vxkxs5ztJ3yHF7oIcuPDcGPS/2Y2Dqw4yIaWvZ98ZTLrHz084y1h7fkc20srk6YWAYUj+ulTGqvfwPi8dcK8WkF8L+yNrVm19KUpc18tCBgQzmAaCYxCe02dqHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAWPR04MB10054.eurprd04.prod.outlook.com (2603:10a6:102:38b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 15:48:57 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 15:48:56 +0000
Date: Fri, 24 Oct 2025 11:48:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com,
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH 2/6] PCI: endpoint: Fix parameter order for .drop_link
Message-ID: <aPuf4KyzR/h85eUs@lizhi-Precision-Tower-5810>
References: <20251023071757.901181-1-den@valinux.co.jp>
 <20251023071757.901181-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023071757.901181-3-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAWPR04MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: fd84207c-8411-44c8-0c6e-08de1314d768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?12MyzvZgB/1S7hilbJPTkCTc8UxLSqTWcCyOOc9sdYMK7ArVqlskMXOC+lMH?=
 =?us-ascii?Q?QjjNFaG6WhfTkL1vzSqUNDCqo8A/Le42kHBd81CV9j6t5O1Hp33LKe+zQ/4i?=
 =?us-ascii?Q?jy1xIankTZzaoYpi6I0FM0vT7UGWAYV+OdIK7/9mNd80xb6sCcPORcOsV0Nv?=
 =?us-ascii?Q?P97qLlRsZXact1/OQhdtJ131UBDRftT6W/KZ+w00Lc4qSoVjW6EO9cOd0JQC?=
 =?us-ascii?Q?NmDozPJfAZqM0dzLCv51O9USGtmDiVkkALn53FwI0jkM2ioPIGxNdtyvuxgR?=
 =?us-ascii?Q?oWy/i9AGfF+VYmIJQhwfEbybUkbngzpxwKWAFZwUSWdmHcvqHjrwlfSdW6K3?=
 =?us-ascii?Q?rfyDkSHn6ySNfCLnQotaro6XH0o20vHsYgu1RrmsT67KPDbOuijbPrBoRZ95?=
 =?us-ascii?Q?1W/ODw8i9l1u0ROhgusTjm/VojlJdOLAoZAPSNoOPMJhFQhiU7vCjOAH4QIQ?=
 =?us-ascii?Q?CIbzFSUN4eTi4WUl/eTDOC1lh7dv9noD39tyu5QfMuiAYljVpYbS0NpNSelK?=
 =?us-ascii?Q?AG9RRbEYJnuTmjXiprJ1+f3q//C3n0UQQ2/YA6EJ8eTtCDiRNbOtZTGQZO6/?=
 =?us-ascii?Q?Fim3CKKQVYsYG4V/0JFul1R60AHLl4RWY0gYTIoNJQORxGTOt9Uk6I3WdY2C?=
 =?us-ascii?Q?ioNIaMxRIxeZuUnIbCMmmY19SM/ieZv7aadLnvE3uAyVW56QRByNYC0oWyq+?=
 =?us-ascii?Q?RgoV+QPByqXJppnK66Ok8sYifO1InxqHnLQgawW2T5mX0kmVApCyG+lt4y86?=
 =?us-ascii?Q?he6pZLBlalFPn6azR0yCQK7Pqyyf25OixMUbEWX2Kg/ypvi410ZPa7ViSNfE?=
 =?us-ascii?Q?xuxXSqICZm24n1oNPof9bqtUoUZNMhn8CIXNuwFAY730EFWEv2JBgwjZ/v9H?=
 =?us-ascii?Q?dIR8aq3mpPPAuHxABSe1fU06n+6722U0Zr18Ja77tsxZtR+7KGy4AYfx39YP?=
 =?us-ascii?Q?1Fl+XdnmPoXBq5Na66LU7JZeqJtgS8jZb8q96dfbsclZBqRvawRwdAaQzj6z?=
 =?us-ascii?Q?yPHAL9HPXJ6E1fcuErC/NsVTFdDSqnDpxgIRB1fSdmG6m1fxuAQYy03aU0Xn?=
 =?us-ascii?Q?O7YvlKPznwoHm8lRcrlop9n2+7qS/UthKZrL1rhEuPRg8GA7sTxB/CR+2qn6?=
 =?us-ascii?Q?tji86N0rXkKddHQHFcPC23i6tjuN2C3Uj9udtYCoH6M3WBFZcHd+4ynpArAp?=
 =?us-ascii?Q?uWc0TFp1OMeauSD2PKqTC54gH2u7ZlPIxo+ttXnCOT5gEVGwLv6yxC90+kox?=
 =?us-ascii?Q?F3k9p2HdZlRGaxczf4m6ZRRzwZ2ffG1jKUFPukYfDb8QuZvFyZRLT/kUiHlC?=
 =?us-ascii?Q?MP80Lpy7cvFYcZy2K7iKOdFlDvgEAz2fyoLNmMXz27e+GO0zodgO1CMXs9PT?=
 =?us-ascii?Q?wS154JGF5aFdQ18kbJ6bCvMm0P6pH8IoXod4kSi5UwsnxW32hRy3fgkleoxE?=
 =?us-ascii?Q?LzvwepSAhnLeFFYaLjvUIEoSlXDm5PCLAT95SbVNgA/aw+jG8hDAzsYipmsh?=
 =?us-ascii?Q?gqF1dxqQaK6QFLh90aQCVK/5hRxevC256PjB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JEi23dl0/aO1gihWGkCbdTw0y8lJ2TCYWHAHqZmr9ZqUyfkWIRNlBcYjz8Vm?=
 =?us-ascii?Q?7S3dwd8PJuCuhqcptCHY221dJFaTO5nLDHMU82q/kvnoIF8gYJPQzl+A5fYk?=
 =?us-ascii?Q?Ris8hUm9vjqewW9xeenVTZfcPYMWxWWbRmngJXCHlmtUJWWEStKOe6mJ/w7h?=
 =?us-ascii?Q?9oA6s3w/pHoyjo0npIzREb9+Wyqv8Bej7G6GGvGFn/YEq6Wfnvn3uFm7WFvB?=
 =?us-ascii?Q?aWEAb2Rt9lqoB16p9pB+vyAMAAR7RU3bUJju786Z8w+1C3cZM25L78fs3adq?=
 =?us-ascii?Q?oCfv3BzO1nMGGCspJgBThJOEJxfbHHiMVxrSZ+nLHaklXyH76KLkUFrydK6G?=
 =?us-ascii?Q?w0rspy8rD8QoUKhCbEI0npZRt/SIS33vnPAzJ3B/YUFMmv/QrtiLQlEw8+ha?=
 =?us-ascii?Q?5obVQviMGYlg+xPAg59LDEQ/qQq8Sn1LBZzKRe7g+uKV6CKwIrm42uBa+Tk3?=
 =?us-ascii?Q?r6kL20ncXCqP2JTuGGZqxg6VS7oxDaasMG+q8tzf+bB2c6RgzJ3cdVL/HVAr?=
 =?us-ascii?Q?7HcFw2OKwIXPwyuI2Wab/IBc2rFQL/TbuyXOE8nWaExmEScKMeNg4C3YHZIp?=
 =?us-ascii?Q?auk8bPFWaBi1gmJrYWdxJERDbhazWUMRlA3a5ys8rkdItFCxBhoCHtP1ra/w?=
 =?us-ascii?Q?z+Y/tRqLndFmz15wbZKXJdNf/10IhxDRZPv3faVsT4vFTY/5f2CzEnYhxdDV?=
 =?us-ascii?Q?LP4xbqIwBOUWjSkCyTAFUwr9YNk8OstaLXdWUofWiZ9CRRKKctOCHG7FUW6m?=
 =?us-ascii?Q?WhJ9howdmthBiaSP0xTsrTUSzlvku0UuySW4aXWj0Bh+PoS1pb6Sg/b/x6DZ?=
 =?us-ascii?Q?IgzFPnLkLUXhsKyYoJgMN8azuHrPLSEqAh0OSMtfuOa+pJx1wY2HuyZfQuFI?=
 =?us-ascii?Q?a2Yq0fjpwbmzq39dkelqX1JuJkEf9tik8n/ee406NT4RqNLqsMQL6eqx+JN+?=
 =?us-ascii?Q?TQX0NPR3qLKE/PPy/ZvAKAmLSGQ9U2das9Udevr8fCa2V4M1QEYxcLpVOaWa?=
 =?us-ascii?Q?dOztj5xyXEHhd8YVjV6YP3IpdxwX08VBFGGl0F0avVeJhW7lpKlO3bTtEbZG?=
 =?us-ascii?Q?HkNhlXI3QR0rRPLvauTwv2K+MYkCvhmXZpzYAJVpnkREs9i57Npt9oEFx+Wy?=
 =?us-ascii?Q?NZNnGgz1kZP1v1HNuNP1eNJU8TSDxVRN0nL1EUKRNVh+wXXFbfuGp6OKyDOO?=
 =?us-ascii?Q?4Pw0n3znjk7ZEkLkaF3onLJFNGPadN/WBBUA/9TYkvKkvBpmcmqdY2eS/NFn?=
 =?us-ascii?Q?r/2atDdJ+HXE6I7mFR28zDoPjIeEwXyNwuq24c6ioQfpJ9dejOLDZBdqDobp?=
 =?us-ascii?Q?qIwjEhV3T5VWL2kODKmdIXR0O5Yjqocsg7dGf6aA4qiBCKfcfE6PwVORkIxL?=
 =?us-ascii?Q?drqGNSCkHCxtTkAfzuDYQn8B7cMTS/JDged2ArvmQvn6PJKRzNxYDkrIVOf8?=
 =?us-ascii?Q?MEitgy8d86FEIMhkqdtPWmlIVA/T+15baL8cjQwbpK4gpusq8T4wvAeeh8S0?=
 =?us-ascii?Q?gE7P9+0dMvuKTsbmPB5ARyvY5CMSiHIyG4rCX/vuIM8pJcBRGS9xsCGONKXR?=
 =?us-ascii?Q?lsfQDhmtmDm0EKbweZV3fvp2cnzt1ZQNQVfq/0dj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd84207c-8411-44c8-0c6e-08de1314d768
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 15:48:56.9301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6WlApnqqeBAnpbNsDTK6MfORNLE3lP0MUIkHtaRaa43372I81MbruQSg+8X89eR5h84gYM6kCvZYHguHJde0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10054

On Thu, Oct 23, 2025 at 04:17:53PM +0900, Koichiro Den wrote:
> The unlink callbacks passed the parameters in the wrong order that led
> to looking up the wrong group objects. Swap the arguments so that the
> first parameter is the epf item and the second is the epc item.
>
> Cc: <stable@vger.kernel.org>
> Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Nice found.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index ef50c82e647f..c7cf6c76d116 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -69,8 +69,8 @@ static int pci_secondary_epc_epf_link(struct config_item *epf_item,
>  	return 0;
>  }
>
> -static void pci_secondary_epc_epf_unlink(struct config_item *epc_item,
> -					 struct config_item *epf_item)
> +static void pci_secondary_epc_epf_unlink(struct config_item *epf_item,
> +					 struct config_item *epc_item)
>  {
>  	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
>  	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
> @@ -133,8 +133,8 @@ static int pci_primary_epc_epf_link(struct config_item *epf_item,
>  	return 0;
>  }
>
> -static void pci_primary_epc_epf_unlink(struct config_item *epc_item,
> -				       struct config_item *epf_item)
> +static void pci_primary_epc_epf_unlink(struct config_item *epf_item,
> +				       struct config_item *epc_item)
>  {
>  	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
>  	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
> --
> 2.48.1
>

