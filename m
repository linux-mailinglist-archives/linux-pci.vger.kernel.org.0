Return-Path: <linux-pci+bounces-40762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C4AC4923E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BBC84EA886
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C022F16E;
	Mon, 10 Nov 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jTFJfTdW"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AB1EF091;
	Mon, 10 Nov 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804286; cv=fail; b=Ko5MBKahnfRWaCNw0uIZa38jepSchTJf6cdYnROBxSgF3YnxNVsu5udUkCpdjlLPwRxUkUZjTDwBGW5vTW9KcRsSZf5bgHrg/vMZS7c/OmuwSvSDT5Fs90+G5+usodSpo6TXn/hLrx54SFZpHN8dOSH5nnAEf1i/7y+gTonZJFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804286; c=relaxed/simple;
	bh=hyXsqgji7eUF+uvULihDkdMcTmTp3BDjEYfdNZ6vR2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mbOm4ZAv6OjI6H/7dtUq2koeLSj/7kFYKKfbAIHuGABE/HG3LQumRSSQWa7au10k7LcKFJl1csfLTCFsWlXCZgdryOICqieGa9e7tMknndydyMdb3ykt6AqIoc95wF2w5/8zPtwfCUcUruJBuqn6qDfRiNMafoOSbgOHSZZZtoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jTFJfTdW; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGwou2i1G3u2eSGsNZ+ieknEu5InVgUYwj8nFwZtJXfCNO2DMFjKrcyLA6LdSPZnnxP2VKpkqb1jyjo8NbmgQiUqG2D8I2FXkGWHVOultTWX8AojSIU2PxXEha1lERS7qgSRGcBijglXW8GoPuHDosXRcs/mx62nMh5rr46DPqM2/zRyyin2pEV3rhj7jZCq/eo5q2y180xJV2q5eEEKZsdl3fW4qksAut9Tl6xEXYR82SaIRzSux0FWi8uG0g/quderVuEqvunSsDsT/VIzOP5PFZulePXsbHiPE0lMs1V7LYId/wKYqjgURpzYrKvkxtC2ijmD54qNjdi7cKFDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utLLCX83RgIiwBUEaqyEEC8cmiCpVqWkVkQnsu9+DfE=;
 b=AycK0TdISV1qrJihzpwuCBdkG3QNiSJrSJHENleqBNt8rwTtCFYgPuAbciE1nBaA6joN3Jxhf6eQJ51DFVa1dLt5mRP63lP7bgRWT7Ql1WjpWSJsHrjZ06tawG6LSKQsc/fV+aRXXpMekEzPE10KXIkfD7k+c1/AXF7XdQhbPupdrN0Q1Uy53qgyKJaorg04jv85xWOXHJkJ5W9dwyyTw8n2OkeIjONmeXRxPmNZyQQqvEt/5atxEx0NuGdk2z2UlnIt0yLOdecL5XOpkQ1hW6um2vDux2/HqXkifVolNPMMQDf0eMwjQb/UpS76GUV1k22kNDYCwa7uNOg/PFp+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utLLCX83RgIiwBUEaqyEEC8cmiCpVqWkVkQnsu9+DfE=;
 b=jTFJfTdWfXOMpC0Zl/pz78008ZFz3e8BSW3QJ0CmmTtHhna1N1PxbGNxhc7wjfrOGAoyfOB7ud6j3D1qiBjrqMGFgxE9WzJ1dhHGmpri5Z52Tsga5EsZZqLEdrR5fMl+e7CT0iOdo4DZv3BU72coBRhQyA+nJixfTy/2otVOyheM5mkdJ3DOM4Dl0Q+0OhD7NrzKnWK5mBO8MGLkyltx4vjU7ddZKkjt1NyYqARJiVnwd3dcYHrsllfX5ZXB7Lvw5rYaxsg6spTQRDVRuTg/DPfcRD8F5UeZMsllZga7wx1li3ZmSmcNsgWJo7DkIfsxF48CQmq3yUF/Piq2kHXWRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8086.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 19:51:21 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 19:51:21 +0000
Date: Mon, 10 Nov 2025 14:51:12 -0500
From: Frank Li <Frank.li@nxp.com>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: endpoint: Add missing NULL check for
 alloc_workqueue()
Message-ID: <aRJCMEUdjxh5K2UG@lizhi-Precision-Tower-5810>
References: <20251110040446.2065-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110040446.2065-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: SJ0PR05CA0121.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::6) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ed4b62-89b8-4f3d-7889-08de20928534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gI0Gthsu5+C26jMchSwFd5dVnSPVUHoJFA5Ghra5MIGtbCI+REFTFjnvAnHk?=
 =?us-ascii?Q?oSiRADkJfoN2RlAEiu13oLus2y6sYY2b3SjTacr5/EO8fgLxLdZQyOh8iowk?=
 =?us-ascii?Q?maAO0BUsO41+wmWIWYtwKfiGWClxSMOZ4g0V90Q2oE+EChjp2JD+7It+t6Ml?=
 =?us-ascii?Q?W3eU/2lMBHaxbywijjy2/z9aPoAMLExXGeCbWonI8emCKJ/GK+V7+pcoOe4L?=
 =?us-ascii?Q?AUML+RuoBMlREtAUJe2WYsKtCT813jKqFarSW11zTI97mKWPXejtnbgVXRTJ?=
 =?us-ascii?Q?WSBM/klPnjXQTSIhy2xGwNp/ERB5WSeBEHXjYRWr55UKJuFqNWAN4/PRT3A0?=
 =?us-ascii?Q?wk8Hb01I0utQ8YDggFMvOxWVgoinQS0R4Cn2jOfzgiT/yAaBXUXFyimAsL5z?=
 =?us-ascii?Q?OWgFWWNIS8FedGnnJFWp2nL5modEMhSifvRSR9p6wtNft2GpsC6T2QJ7RIGl?=
 =?us-ascii?Q?SoNShKJP/Zgbrp4jGAEwc5fO9NM8KUGAMGd34r0ROVitshPUwrD2eW49sx7b?=
 =?us-ascii?Q?2vlizzPKdm57Lv83d5gRkYVXN184klOXu4m1qNb6Rh74KaPFWpdutwR3NyBn?=
 =?us-ascii?Q?KI09XgXxJPj0+nUtEXGu2UUYEYBx2bP3fMJ+GXPs0NTl5kR0jO6HUFqD4UlH?=
 =?us-ascii?Q?urBPTp6iuyjPfaOWAoKWiLfYhXQ5sz+bifvqGx3Pe2dJ10wicY+/gCr4SHQm?=
 =?us-ascii?Q?PWUrpN4JLWN9hO/XQW+v9C3C5pH0YZFAtE7yEGkhCz+EA/GwkHQCj2Iu+akJ?=
 =?us-ascii?Q?IssLhaS2Nai9YSXIQB0pEENQ0sfmW+wW3MMN+XrQHH1oAdlBM0TAwu9wcQxz?=
 =?us-ascii?Q?p8tm6Sz7h2sIUUGjfzAb4iZgRDD/I8N5+r0n2H0mDvkXioBdLbhWwaPuQvZ0?=
 =?us-ascii?Q?TElFsUYa5YEAoIZmXRAxI+aBJt2r3YVPHkurcNaExW0UTCXXZptZHgzQiCr0?=
 =?us-ascii?Q?D64YWkNcYGe6lLokatU2IAH4t8b6W6YVldJ9FJSrdP0RXfm2rhpAgB5jca0D?=
 =?us-ascii?Q?Co6VMoSOA12wOcaE7YteP3ZV1FAu0FsfuhmNH8UGgjki2pBP9MWnWujY/5eN?=
 =?us-ascii?Q?PYnKq0p8BQplIQrYQY8I/mfgWnq2eXkRpCbBuTWWfdQGrjrFns8ex5XLAHK1?=
 =?us-ascii?Q?ZU4q6lVnF7ox2M1Vjs9MQ6fPFxiHGZOFIqwVFYl9WCkTWk3VEBDcjY+o1OMD?=
 =?us-ascii?Q?oactH2fzwe9An+GED5UDCOVp/Oi8C32xGgS8GesYF5cH7OS72/aaa4cpPjMk?=
 =?us-ascii?Q?s4IEcYNSPg64xnK9BBOk6W7wWJxHdrZPiXDbDwUPziKjzEOxVKjcJCd5My/9?=
 =?us-ascii?Q?xym7L+kTIiEbRhxbVury3e+YBJ33FU1OXGhf1JYXOM3k7mt8oWQhbiuwyvA+?=
 =?us-ascii?Q?8ZOv8jMrsFZyNMwGFt3obTcL0AfkC9FwmV1lmP3oBoeQjwDI40mBUJnTI2GO?=
 =?us-ascii?Q?0SPD4Z8rTTy2D2jmYcr4dkQWYNmpUwtPNSba67gTrfHYWNWi9L8UlXNxa19b?=
 =?us-ascii?Q?KEilm6oWfXBaE/a1G99S9LD2gvB3WJ6ALy+Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tSA7xWQhaGe5p7sR8Lqm6oxGKpUkJrpvQQ7r7gN8NMsMp/Vw3QLqbMsw5zsB?=
 =?us-ascii?Q?55AMYiRKpj6NPrH3Ix1oFuyBrar9685Kq1wlC1xXknWCSavhF8nvJX51+MH2?=
 =?us-ascii?Q?gVf41nxJuMD6ohYIomAiZiGgdW5b+skUTz4LX4C/p8UE5nsxJWLZmet9l867?=
 =?us-ascii?Q?rumgxO6BXwRVUe9BzBhgXoziNW7v2OyjToN9FaXwZLNLr6/SsKSNZ9ozdlbo?=
 =?us-ascii?Q?vN2q/2vM2szycORZpoWTT3nGMnj5XiijMySZJLYaAuIal3BhgbDgZJfCKhGH?=
 =?us-ascii?Q?sDLcgIqTjirqo38MICOPIB82i4fxzTdr3YTVWRkUTeFLBiPRD/Tduaw04bBK?=
 =?us-ascii?Q?Zuu+NdHoE7+1eys81eBJcjX1vMHej2uQJmLoFunyOk/nipjsaJiqxybliM7V?=
 =?us-ascii?Q?33OWj1MnHkrb+qV/1cM3xw1sldOCJdfGS/JMH/U3qj46sV8bfCU9zVdLRGoO?=
 =?us-ascii?Q?/gctc+ec0vYUX33gBuzWyuQ4C+SHreDYfxkhd/of5nQVoq2k6445fbXClnoR?=
 =?us-ascii?Q?aNyVcwcBJrgHlUhEn3CQitnzPR0aUbyhcBN1nn0QkVUs3oOcvYB0uwUWNIRr?=
 =?us-ascii?Q?bQfvvyXsGmbohnj/VryFcpwa6mdv7M7TbssJgYb/OvO7mYTmGkuOHJCNeW9Y?=
 =?us-ascii?Q?RF4tS2N943x4Y4qylVElfxDCMuKuNOYCFf7jGM6UcK8TbZq+RyBK1w2PVQnN?=
 =?us-ascii?Q?1K5hZZGy2UHcWbWM4a21d25/WYgr1aYoYZrxtRA9v4Sy5SP686/mVho073EA?=
 =?us-ascii?Q?FVl2gWMpOxaKTQs8sPJD36pCstpZLom2D5qNaokugK+PSFBHs5H20S31+7r0?=
 =?us-ascii?Q?FGBZxl7z3uoMWtzeThU21QpKV06wGmLx+5VTJVWw57hkzNBF/sxnjsLXb4Zf?=
 =?us-ascii?Q?qFf5sO4MCcs4QOrUIbkGMqOGgjcctndYI0dyW24LY2MZOKFo4phfuKQ5yDai?=
 =?us-ascii?Q?4kE+Kfhib4pb+4Mh+xSozEitHzo5PYb78vbzj4Lde95BR3zKiBvfz5CTNi5O?=
 =?us-ascii?Q?4VLai/SuI/sHw9GkeO7gZne2TDhJmLmixYXYl+LMTRbX6SwcaS5thwBkgzFt?=
 =?us-ascii?Q?DEAlrXnCINXAAuyq9pXbE8OllAjKeUbD8H597jbRr7C0wBKlBy5/SaJ3PyAU?=
 =?us-ascii?Q?VER6aDwOmGaN9rC34Y3Ka7U3xNgRuqM36wk5RxAAXfAPSCpyN0zPeDy/eBq7?=
 =?us-ascii?Q?Stp5mPNcdaiUdn30EXeySgsgd01Oh17N+hXAUePbCBEt1r8nuXG3l8ermErf?=
 =?us-ascii?Q?o6LUkFE2u9hhC2RGHq9i95PD0LVBznBv4KI0yeoMSqz3n4QK91HdiDUw74xK?=
 =?us-ascii?Q?gEC5i6yjOGEFXmnKJ8hp3dMFk9xPlU4IvtNaT/GR1O/CLh9SpDkWFpoySKBQ?=
 =?us-ascii?Q?PisvBK7xrwupYL0h0mVwf5EED+vYFaoETu950aDpZ0jK57sDG1jpJ8Rddkgo?=
 =?us-ascii?Q?jCIevhJnfvU2qKYvXZMpp42xc9IWeQ9rx5mYwtRU2Fl5NPluRH/4/QM6vGBY?=
 =?us-ascii?Q?b39wbPassiItMy+kJWGWiaZHtFFQN6JENZJgxYKLWoyS2kB4G5R8q/uA/LJ+?=
 =?us-ascii?Q?DUDMJj8viG6Ljp05kaW3vreUDHQdX7uYKgPsaLwl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ed4b62-89b8-4f3d-7889-08de20928534
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 19:51:20.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Hkp9xPHZxP7tfYLdAW8Hg6lihT5dh05V3UA+7vqko07sfXBZjJNGXs7aUhR+Kn+fZtaTdOLQo4YfVtzi4ItWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8086

On Mon, Nov 10, 2025 at 12:04:46PM +0800, Haotian Zhang wrote:
> The alloc_workqueue() function can return NULL on memory allocation
> failure. Without proper error checking, this leads to a NULL pointer
> dereference when queue_work() is later called with the NULL workqueue
> pointer in epf_ntb_epc_init().
>
> Add a NULL check immediately after alloc_workqueue() and return -ENOMEM
> on failure to prevent the driver from loading with an invalid workqueue
> pointer.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Fixes: 8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 4 ++++
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index e01a98e74d21..b3d96a2e3a8c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -2126,6 +2126,10 @@ static int __init epf_ntb_init(void)
>
>  	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
>  					    WQ_HIGHPRI, 0);
> +	if (!kpcintb_workqueue) {
> +		pr_err("Failed to allocate kpcintb workqueue\n");
> +		return -ENOMEM;
> +	}

Can we direct use system_highpri_wq?

Frank Li
>  	ret = pci_epf_register_driver(&epf_ntb_driver);
>  	if (ret) {
>  		destroy_workqueue(kpcintb_workqueue);
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 83e9ab10f9c4..79800f1fecc3 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1534,6 +1534,10 @@ static int __init epf_ntb_init(void)
>
>  	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
>  					    WQ_HIGHPRI, 0);
> +	if (!kpcintb_workqueue) {
> +		pr_err("Failed to allocate kpcintb workqueue\n");
> +		return -ENOMEM;
> +	}
>  	ret = pci_epf_register_driver(&epf_ntb_driver);
>  	if (ret) {
>  		destroy_workqueue(kpcintb_workqueue);
> --
> 2.50.1.windows.1
>

