Return-Path: <linux-pci+bounces-23117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D4AA56875
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 14:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D076171C64
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5303020F068;
	Fri,  7 Mar 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sUFB16nE"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010010.outbound.protection.outlook.com [52.103.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1EF2940B;
	Fri,  7 Mar 2025 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352872; cv=fail; b=WiSfSH5jNdxwP9lzBnWufi0CnuqTwnC6bXR9Ls+e99+Ng8Eqb2XZMFhj1QYFM1hlGj71chQAYZqt/8OUurk+dL2BCxnV2slnzph0nGNRAujlkPxDinv+TV/2qBxkJltep7XdHKkGmHI8osM0mD4m7O8S7sA+SE883rnP9Kx8cNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352872; c=relaxed/simple;
	bh=eKzbfhES+e75IGSxF3z1EAqhKZ0TJgCdaRb5GrwC/hY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aiO5OGp4y51mshTQ+VMJPFFn2gid1G1qtzS8Y9DzYHwtMYMqUSYBAryif7nQl/Lui9Z85F6AxgfA7tF6gvxOymzKuNRClQcDmMm3637+tQzYdvZSFh8I96sfLiLTJqs1UUM+Gnb8SI87/qtnyIUAJWWDV8C1N/GtmSWDUuzrJrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sUFB16nE; arc=fail smtp.client-ip=52.103.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5H9Wkup2n4It1lVqO74IcxOoC60sonJLMACxgkF3+e5eCyYXz5DPDJLj6WDtyw2mFDGpVuKiy1wR7aK8tYSTWbxCvor7XwCOsF3pExyPCuKJRqzINac4nWvz2KDji5Wr0Jb6eudzGQN4QNGE3b5VgKUpmQ+DhlgqIImylGD+ldJ/KfUm0M1lhqFLlwdY+7pspNfDObYKiZE5t1ESBuRqfdbwjEVz6V+kknUE+RL7fMgscOTdYSb9AOxxiB7Zu2/zqaMkKtc6n1QbCz7pi+ZNz1giVkZSkf72Kod6JWgd3zRcbdDq8Zw2cP2z4FtB3O7ZAi+udjdTuD3e1j+UzVriw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XrB7T80mYHHKo+ciE8oxlyeiYgkgdfdt5NKUNGeoO4=;
 b=ykZJpjiGL3kLbeNABTpVCOiKQ3sD1ulFMJaD/1gu6Zc6456tUMVyBoPvGPcfTsGNIHB8M9UP9UZ930rSuZ6z+zU0fGgIOQJCn3DPyIVXT3NMEp0tubcDJpF+/fwyH9Td8a62jmVyhGCca14PUJihfIQBdGU03toqlmW+Uj+hxeTyxGoSDb42meSBfgqV6dojdWffZAzL24Mr/EBresSOYo4z2qFBWBlCZ+X4KJq+NAhwrdCEjsJmvQtfyAEQxtJB5s3TWwN7aoNxlPuB1kg0SRt8nCXtWIBJqfv8vPdNXW26FIcPv8dv2itiMK0iRmRAtSV7NUBPPWTslToW1zViOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XrB7T80mYHHKo+ciE8oxlyeiYgkgdfdt5NKUNGeoO4=;
 b=sUFB16nEujWWUR7Qku69i4+v1daIeg3KxE0HUCrbK9SiOfYjZKL0GGP/xUm+OdC131Xj12FqBUxNkDD0gunHzvLf/szbJqsfPCk0vWBOGKbG517U3jKQTL6+vvfzZe+B29WTjJRriTLhLNEjSKeHHtCIAXAcHrptOqkGTBc27Yvp7y3WmwSUwCjM8plK9X4Wawy+5DfqtpvlRhC4tpOBPNZ46YrN5oFFSB22xXNVVwp1n9IVLR046uf0Ypu7nVk3J4fqaE6Rcv3qY5Od430Qq7jOxTLJk9nzBeexSsBqDzm+4ReO2/jqb09SEFTQgm2wqV2Am0BSX2t/sOqeRUZshg==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by MA0PR01MB10236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:127::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 13:07:41 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%6]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 13:07:41 +0000
Message-ID:
 <PN0PR01MB10393C44D1F4B9189C52D31EBFED52@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 7 Mar 2025 21:07:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Fix NULL pointer error for ops
To: Chen Wang <unicornxw@gmail.com>, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
 s-vadapalli@ti.com, thomas.richard@bootlin.com, bwawrzyn@cisco.com,
 wojciech.jasko-EXT@continental-corporation.com, kishon@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 sophgo@lists.linux.dev
References: <20250304081742.848985-1-unicornxw@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250304081742.848985-1-unicornxw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:404:15::30) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <1f2ed6a6-d588-46ed-af9f-9aa452bdd79c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|MA0PR01MB10236:EE_
X-MS-Office365-Filtering-Correlation-Id: 99651ef5-d4d4-4423-12a9-08dd5d790ada
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|7092599003|461199028|8060799006|19110799003|5072599009|15080799006|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekN0dzRiOUtVWG54aUNKcWM3V2V0czJBdEdBREIzS05OOEwwVytocXF4Z1NL?=
 =?utf-8?B?ajJmeGRvK0MwdCtzNjhpUTZrNTg4NWhEcDdQSWZScVd5TVJTWHVGRHZpQkJs?=
 =?utf-8?B?U3NnWmlMc1NhSGplYzlxelZjamlzdVY5YXJ4aVZRdTJ4Zy90clo5bTdvNFBI?=
 =?utf-8?B?eW9zZWFNQWtrYjJlLzNZOTV2eFpobFA1NmJhTUhUZHFleU82ZG1IMzdPOERk?=
 =?utf-8?B?UENVQmxjb1N6VTJLeDYreVdjcHlOVjUyelprWDJTcEVVMjVVSnlhNU1RdXMv?=
 =?utf-8?B?aERtTW5vODFuOHllN01PTWFVTFpPYU4wc1F2bjQwS08vTjRCalk3ckJFQlFs?=
 =?utf-8?B?N3IzQXpNRHRZb2ZsU0YzWFVpM1hWMUlMaFZGZHdiRnBkSzk2dnhQa001bGlx?=
 =?utf-8?B?bTFWbFhWallobzNya3ZKb0lWaUkwQlZYbEw5dkRucFZycG4wRDlKYW0xMkJt?=
 =?utf-8?B?V1Uxa0RkWDVTdEVibEE3MXhQYURFeUN6aTBrNUp6SEgwMU1pcFpHejRPdnlG?=
 =?utf-8?B?bUNZaDJUOGMzQ1FBVW4wemkra3h4Rzl4bnZnUUQ0NWRCUXpYN1Z1WHd3Yk8r?=
 =?utf-8?B?NWpCQ0lvSVAzNm5KWUhYZW5HSWd1d0MzL3g3TDBYdktoV1B0eHRDM29ZWjNw?=
 =?utf-8?B?L25ZOHEwRHJKTXNXTW1RNHBnMEI3K2JuWDJQY3B5cVFFbkI1UlBaNXNCYm9H?=
 =?utf-8?B?YzB1Umx5TFhyRjZ1ckJpbUVhZm5BWFRzK0xPbGVXS2Q0cTQ2eXJocVp6MU8x?=
 =?utf-8?B?dEhFQjQ0am1VWkNPZGxZV0dscFVSSmRoWDhiTitQVGllelZrVDhmOGlvdFo5?=
 =?utf-8?B?UWR0bS9kU3hFQi9LVnAxdi85VGl3NHJtcGwzRFlQVVpRbFkybEZrNEFoeTFU?=
 =?utf-8?B?SHdUR1JMTWRXbzFQS2JxdFR6M2MwS0s5ZWg1SWlQbE1xTkJmYkpETXhjWUdW?=
 =?utf-8?B?ZVNSbFNGeDRQY0tiTmdtSmtRZ2tHUjJvMzhrdC83NVNvZ1A2UjI4RVNuSGpV?=
 =?utf-8?B?WjUyeVkyVW5kWkZrV3haRXFtdTg4SkdiOW1UWk45MTZtdzhVWjYxcEl5M3VX?=
 =?utf-8?B?NTZLRDQ1R0UzQjVxWkFaUVFxalhqbEE0bUVDayt4TXpyc1pzSG5OaDJhWFFq?=
 =?utf-8?B?YjRSaGp5dHkyTDA0RzdiQWNtTkltQlNXTDAwMkMxMmRwNlJ1cWxoWGpmTnJ0?=
 =?utf-8?B?bWF3Q1N6dnVYeDJsT1htZmtQTTJ0UWxpVDhIaEZ3OWJrd1ZUTDFPUytxNVRB?=
 =?utf-8?B?djNHbkhJdi9OaVl1WEtHeGV2eHpwRHlpT0crRm5DUlVoMy9aNm9mOENISnpJ?=
 =?utf-8?B?YmRqOUNsODdqcFZxQjdNRjdDOU8wSkZnVGI3VWNrZkUxR3RVUFZQMFl3Y3pl?=
 =?utf-8?B?Wkk1M0NnQjZlRW1UZUNIQ1UzNDdZVHRRUklpaTV0NTl6VUkyL0tDanMvbnk5?=
 =?utf-8?B?RmRPa3NveGdUeDNkS1hlQ1M4cnpzMmVUQzRsY3lHc3dNWCt1Yk5jMXEwSGRL?=
 =?utf-8?B?NEVKU0tDM3dFWjFPcVNJUkhsdHFZWnNLQ0h1U0dxd1pJb1MrWTE1SVNvazg3?=
 =?utf-8?B?STVpQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkdxcWdpb1Rvem1lNUlvek9jcWJrUi9lNTVQcEVIYWVBYTdnd3VOcTdZdGRZ?=
 =?utf-8?B?enVLVkNlRW4rYUhsQXdZNHVqT1pldVV6VGhUMURzSXJhWXJCSnhkaUZOYTZY?=
 =?utf-8?B?bGl1cTRvcmR2VU5tZkJrZTJvaUFkWkJ1Rzg3eTlud0VETzNQeHBhaFNsWU9w?=
 =?utf-8?B?b3ZoMFhwVXhXYkdlZUJFNHl6cXl3Tkp4UnRiZkdFTDhQczF6VXhmRGpzeE9l?=
 =?utf-8?B?SVZTd2VFeFhwZFZhaEUveGFQcmc0NGdmcUVwZHlXU29KZTZCNmNONGkwbUo2?=
 =?utf-8?B?dkltVC8wM1F6VXBrY3VCZWZ6R2VCeE45UUhmaHJ5aG52TzcxNCtjeGMzaHFz?=
 =?utf-8?B?UjhVeFdkc1NqT2RXLzc0VjVKR2E4NEhJVVA1d05Td1BBNzFrT28rMkNkQlZQ?=
 =?utf-8?B?TGlIejhrMzdhMG9MNi9KRjRjTlNBUE55cExRa2ZXRzlhcE5rV2g4V1hsaTJj?=
 =?utf-8?B?WENTdXpkMk0rZmU1akh3Yi9TNTZheFJpZ1k3TmVhTkRKL2Z0TTIwUjJLcGt4?=
 =?utf-8?B?aDJHTVJMVWZOSGcrb3hBZ3hlTk1mbkRzTEJHMW0xbHJjZTJmNm1oVVRUaTBu?=
 =?utf-8?B?UlJMZUx2Yk1pd2JsTEVBamg5VkdObUM1bStNd21SWU9YNUVuVWxUcUlhTExN?=
 =?utf-8?B?VkIwZkZnbjVpUUVnaGVROG1DbVdja2FNblREMVZoTEVXeGZuMmJQY1UwdGVz?=
 =?utf-8?B?dENyV3kzTzJuSEpXSENhR1hIUExaYm1uUjAyaTNEVDhzNEl3cU9yWW5KeUhm?=
 =?utf-8?B?amhtdTN5Ykc4OTZIeWVlRXo5WXJlUk9mUDFmVFN3RGdVcUphQ0wzQjlIcDZT?=
 =?utf-8?B?bHlIaEF2YzBQRG92V1JCNzY3TmJYMVJ0T29YeG84M1kyd0Q4WWZ3OHF4dE5E?=
 =?utf-8?B?U1RWYVMxSTVWc1pVckFEa1FxcmtGQzYvQjdSRlJCckhoRTVNZXBQT2FwdnBG?=
 =?utf-8?B?bDBJVEl4bFRCdUhDS1ZaZEFqN0w3dUpaRjMxTGMwYWM1dzF1UTAvRVZyMXh2?=
 =?utf-8?B?YnZCZkhFTjdpVmJ4VVVzS3Q0OEFFS0RQcEpVT2FueDNHRU5uMmxIbGw3RGFU?=
 =?utf-8?B?ODd4SUNKMTlCUnpLOGFFdHNaT0R4RE1GMHJPaGxua0J5eHozVjhrbUE3YkFw?=
 =?utf-8?B?SDVGTEFQUTdLaTJMSjY4WGE3T2hGQktkMHhmWXFyVFBXeUgvT1JncWNVQnA1?=
 =?utf-8?B?SzZXNC8wcmJtYmNqVDdaTEloZGtvYjZYVXNaSDFab3BaeHBxKzBTc3BRUnZJ?=
 =?utf-8?B?azRGOUEvTE9OeGJYR1FPQW5ydHpxbzllZUF5TndWaFpkbXpadzIydUlJek1o?=
 =?utf-8?B?M3ZQVzkveUhvUytBR1lMZCtaZU1hOGhrRlZaS014MkRhOUlJek9iSy9kQXlB?=
 =?utf-8?B?UUt2NkkyTjVKajRBM3NvMkw2eHRpZE1UWXEwM1liZjVZODgxR2hYek9CeG4r?=
 =?utf-8?B?MzJYeG4vZ21JeTEycEhFM1BoemZmK2xjTnppZVFobTY0Q3hTaFI3YXVsZDRl?=
 =?utf-8?B?SlNCT1hVcTJabTdSWVdzVnI4VTBONzRoZFgrSGZ5aUMyaFFGa1JUdTZRckFS?=
 =?utf-8?B?YjByODRTb1hsUytCZFVpRTZtUWdIaGRMdE1Cd3lEREpIVmNkZ09WcnFDT1dM?=
 =?utf-8?B?akQzdUZJdC9aU2JmOXo4amNrRVVvVG9zVDNtRHd5Z2Q0YTdLRitlRUxubDlw?=
 =?utf-8?B?QzFMRTVFS2ZybFFUMEwxTkVqL29zcWhuVkpmSStFc2lJbU4rQU94U2RUZzJJ?=
 =?utf-8?Q?kGhY8L2pYiynVYjId5lyPoSO7PxarirwYPYHNmM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99651ef5-d4d4-4423-12a9-08dd5d790ada
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 13:07:41.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB10236

Hello~

Any comment on this? Or can we have this bugfix patch picked for coming 
v6.15?

Regards,

Chen

On 2025/3/4 16:17, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> ops of struct cdns_pcie may be NULL, direct use
> will result in a null pointer error.
>
> Add checking of pcie->ops before using it.
>
> Fixes: 40d957e6f9eb ("PCI: cadence: Add support to start link and verify link status")
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
>   drivers/pci/controller/cadence/pcie-cadence.c      | 4 ++--
>   drivers/pci/controller/cadence/pcie-cadence.h      | 6 +++---
>   3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 8af95e9da7ce..9b9d7e722ead 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -452,7 +452,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
>   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
>   
> -	if (pcie->ops->cpu_addr_fixup)
> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>   
>   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index 204e045aed8c..56c3d6cdd70e 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -90,7 +90,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
>   
>   	/* Set the CPU address */
> -	if (pcie->ops->cpu_addr_fixup)
> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>   
>   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
> @@ -120,7 +120,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
>   	}
>   
>   	/* Set the CPU address */
> -	if (pcie->ops->cpu_addr_fixup)
> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>   
>   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index f5eeff834ec1..436630d18fe0 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -499,7 +499,7 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
>   
>   static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
>   {
> -	if (pcie->ops->start_link)
> +	if (pcie->ops && pcie->ops->start_link)
>   		return pcie->ops->start_link(pcie);
>   
>   	return 0;
> @@ -507,13 +507,13 @@ static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
>   
>   static inline void cdns_pcie_stop_link(struct cdns_pcie *pcie)
>   {
> -	if (pcie->ops->stop_link)
> +	if (pcie->ops && pcie->ops->stop_link)
>   		pcie->ops->stop_link(pcie);
>   }
>   
>   static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
>   {
> -	if (pcie->ops->link_up)
> +	if (pcie->ops && pcie->ops->link_up)
>   		return pcie->ops->link_up(pcie);
>   
>   	return true;
>
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6

