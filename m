Return-Path: <linux-pci+bounces-37865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0120BD13A3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 04:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 353B63479C5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 02:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E692ECEAB;
	Mon, 13 Oct 2025 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cTHISZka"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115962EBDD7;
	Mon, 13 Oct 2025 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760322696; cv=fail; b=hy25jHV6Vres0Irr/4/UQYI63roQkuOU/YFKqp5u08WkddidQoyvqGdkRkrTgG0BwjH3enhGHwk4cWTo2NrNaq/uHP056DrLW34f1Jl5eA6p16nicdL1lrpRIlD3WAeNXzwTxPEoN5ryD00JyCk577yoFotS9Eb/e5v58I/lxGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760322696; c=relaxed/simple;
	bh=WbJyeTeCr+/4gN2dAd9UaWIgJEEQJlfeIe7XCbt2z2U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uOkkNkNGjAU+LvMxGZXxIv3UOoCR5+9BbefwoITcXR3ZOBn5LmW5VbC2nWHVlohbt0vVfMECZuUyGDYk+icFKJBF6ZL0ZYAU8+LS8n7HcWzR7tow2Cq2f3BnFV5CujFRYJW2XqPpteQqSNYDVNWgyTbsDfhKFuAwzzpCM/F/214=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cTHISZka; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cp2brZbN9tP1+vQ5jF+SXXqD48DsUJo5kOg2eqd6KSEJLFmMYp5uo+fX4Gsi6QWDt4NW7Db7327MdRK4qpLO7tsf1dvzL/AF/Wd8Tx2wyEBnRPncwnSUbZZPJg0fWkkObfeGr+wiSdgkgTTFn4es3/ZZdsMIEFRYwdk1wyLi7h9ekLBUXYyBkH7OOvHMHf5skvKrUrydNrHpHlGFYporxesvpY+KOTIaFccEnhhYHDvKe8bn4+RNXDGPXSU/eeUooayilP65PQ98hDAfxZgtcCozjFDqRvP67Mvefsp6RZ+DDM4FuTusUdOSoSPU001lYI3pDKXrY8XL4DzaS6yHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j/sOd5tbQbd8Bf+xgbRrGRXRgE7bQ+7q7Fu85bORh8=;
 b=uNx9x4XW8niSosyUBxbUBIVU+WvXnBMJPoLS70fHbM5Nk22fDhMKypT2kMad37pgi3dv7wf60Ywr7CT567z4YbUzbGTUOF8nghkOykAA6wM905S5la62TXAWEub+zpmlG9qBTKjKeGBTSX2RISDmnxUtLu0ZMU1ypjTJneAAVkhB6WGedcC6iR+pse3BmXMZoAMYhSlJJ0jwW+Gimch5NZEbbrPuMQPITD0rExccYPKGVmMFSJVxQMmy+zrpk183iJG+1HwVSZR/vj194YurMTNJ0Nzgiqt7awmZB85wQmMrIg0mfrPy5qp1k5pC5v3JTC2F1tqUTbBn+bqRY/o+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j/sOd5tbQbd8Bf+xgbRrGRXRgE7bQ+7q7Fu85bORh8=;
 b=cTHISZkaBsNQRHmoYnFqx/4c50i8jmtX9qm0Ypwp94kNH4oILoU8sfcFgSw0pHGAd6IiPMnewxddwJW+XEkRN5yDkiGD0SxHJHN/T/zXmRNgRCgRS2U2/AwNmS95HefWZ0kRYVCLLFF/v8mJoDIXuG9KjVBXSIy9S8FNrpZUp5+4548IosZ3OFU4JkJiHSYqB5o3I+FOx+uR192BRmdqS+UtUamUdOJLfrGphPtILhF2dTrv7QSbpS62Hi+3F9Rm75IvkQs0NZzS/ngN7KfpiF4zATf8jzj46/iZtvqJf0/+7wj0vmQoLxOXh/ZdXeA5+4Bc5fJqaxv3FAzpZprX0A==
Received: from PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2f1::8)
 by PN2PR01MB10017.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:12c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 02:31:28 +0000
Received: from PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2e35:fc95:ee3:bf0f]) by PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2e35:fc95:ee3:bf0f%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 02:31:28 +0000
Message-ID:
 <PN6PR01MB11717CDA6EBC89511A6B567B6FEEAA@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 13 Oct 2025 10:31:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: sg2042: Fix a reference count issue in
 sg2042_pcie_remove()
From: Chen Wang <unicorn_wang@outlook.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <242eca0ff6601de7966a53706e9950fbcb10aac8.1759169586.git.christophe.jaillet@wanadoo.fr>
 <f1887014-17b5-405c-bba2-1a441d50e1f8@outlook.com>
In-Reply-To: <f1887014-17b5-405c-bba2-1a441d50e1f8@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2f1::8)
X-Microsoft-Original-Message-ID:
 <0e9b75d5-a1a6-4c5e-ad69-8e189af69bf3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN6PR01MB11717:EE_|PN2PR01MB10017:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3a9ad8-5df4-47bd-51ce-08de0a009ca5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|6090799003|8060799015|461199028|15080799012|5072599009|19110799012|3412199025|440099028|51005399003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkFEZHB0M0dicy9LNVZDSTZ1OFVLTm1OdnQrMTNZdGFMM1hVTTVpVGhXb1Qy?=
 =?utf-8?B?OXNvYk81VFNueDFJZ2ZENk9GWUVaQjlYZzlReHU3VXdzZG9DZEh5dG00YU9W?=
 =?utf-8?B?b0xWcFhrNnRxVUhqT3hpbjJ5alVHMCsvbmt3T2ZiUkZCS1JNczlyRXhQQW4z?=
 =?utf-8?B?bURKZWZweHlMbEZEQWZUZElabi9aVXM3a0lFTU8zamlJalV0U2tvVkcrbGFJ?=
 =?utf-8?B?OWxwelBrWEZ3Q1Z6VVB0THV6Y1YzTGVIbkFuV3BwcmRYcTIzSlA4ZjVsUXQz?=
 =?utf-8?B?YWczaUVWUWs2bzNZYUlWL2JOKzJJdXlNNmtCTlk4YTloT1Q3RWhDaXRFeGgy?=
 =?utf-8?B?ZTU0UzI1d0ZhcXRGRUFmUmV4T1ZkU1NCSlJDT3Btd3o3Z0gxei9DRXFyZTZt?=
 =?utf-8?B?dUJLR1dvdlFoV0YxN3dDUW1LT1MyMW1tUWxQQUthSWJMSWU5dEN2SkFsV0ts?=
 =?utf-8?B?bHpRS3dYYmFEWDBNWU5GWTF6ek9CWGlDYkUyY3Mra1Z4TEVLQXJOODU2dnJV?=
 =?utf-8?B?L3hqV29ZV3dYelRtZWJJbWc3bGFKNnRhS3FlRjRrWXZZcmYyWVE2UWVMVXgv?=
 =?utf-8?B?VWRJTFhrQkZ6VVEweU1JSiswZ0QzQUlvdU1WTyt4VHllY0VJd25UaTE5eHEz?=
 =?utf-8?B?NXltNjJLNWlGeURFWkhBNTIvR01XV2Naa01iTnpQVGZ3b0pQLzRVODBJbHda?=
 =?utf-8?B?M2ZjZ0dETVBndUdxZ2JCNUl2Z29iUnNPREhsWFRMMEszVVAzT2gyK0FOc09X?=
 =?utf-8?B?MDFHVVQ3aFpQZ2Q5MnhFVlZDc2gvWTExWmtuNGVpdzBFd0FkNGduQ0tQMEpq?=
 =?utf-8?B?b3puSXlwdXdPdG5aM3hzeTBzajdueXkxdlQzTENZeFZqc3N0T2lKVjNqTG5P?=
 =?utf-8?B?QXAySVU4Q3RmTXFhZmNjZUtBMTNjeUg4YUNUMEdCNDV1MkFJaVNBYXM2ZFF1?=
 =?utf-8?B?c3JTZjdNbW96Ri9PL2J6RkZESzFJcnV2U1ZDMkFaM0ZsT2hrdEtYWGFXelBV?=
 =?utf-8?B?WHordzNJM3NZNHBhUDJrYXoyaERldHVaQVU2MWtFeENUT0poeUlEQlB3UWpF?=
 =?utf-8?B?dzdvbzlJNjBwMndHQ211TWxVWE1heEl3ek85anU5RGhGV05GY3lDRzhNZjU0?=
 =?utf-8?B?U00vR3QyRWVzenJ0MjVGMEd6OEZNdzJPQlc2WUhTaHFnYVdXTmVwdGxSOVNu?=
 =?utf-8?B?SnVzMkNkbk5UU1IvOE1STG44U2trR3VSSmluTm5VaVEzdUhtZWsremJHY2VD?=
 =?utf-8?B?aEt0QkZjUjFGMHViK0FpZFhQTU5BTCtCUkh3S0dkOEV2aGdHOEVOUW0yRVRN?=
 =?utf-8?B?amhUK0plRndEWHVrQzNzQlBpZmZ6UUQ5Nk9UMjc4TXFoZGVJT0NyWGQvSmR3?=
 =?utf-8?B?YlZVbTNia0M3MHhLM0pQNitYaUF4V3dEbU9ZMjBIN3ZrNFV4bEpqUU1vYVpP?=
 =?utf-8?B?MDJCWjd2dkFFTnVqTldJdmVwQVhvUEYveFRHOEdGME9OQVlCSGY2NXFOYmVD?=
 =?utf-8?B?d3VicGpOMG5RQ3d6R1liS2o3QmJIaVNvMjlucndjRDAxWFNUK0lsQk5WaUc2?=
 =?utf-8?B?RS9ybHhmOGd2d2ljck1BVHlaM2Q4MVo3cmhId0l1enZ0Y0hIUER5ZFVUVUdi?=
 =?utf-8?B?dVM0NVp5UVNRVGkvSjhUWTFRQ21aT2c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y09JMi9STjRIUTFDa1dxaVZobFowRGhtdFloT284NmJJTGpUVURrMWRaT3du?=
 =?utf-8?B?cFFpeUM0WnVHaG1zb0tpU0NHVEZVWXltNnpqRHM0RW4wSno5ZTU5TG5EWSsy?=
 =?utf-8?B?eVJmQmU3azY1OEhmQTNGVWd2K3BrMzNaNlcxMXlOMWs3ZkdTU3BwMVBTalBJ?=
 =?utf-8?B?Z0lqaXhCM25sN2pCSlN2ajZOeHgvTjkzeHh2dC9GSlB6Sko1M2RBNUhQZG84?=
 =?utf-8?B?UTk1Y0FoRVlZTEhKNDQxcExvbkNzaVJWK2JvQWJsSW5pN3piZFVPMjM1UVlT?=
 =?utf-8?B?b3cyanFOMFhaazNLMy9DZjdDanl5NWZPVjliTjZIeHpqNiswTENPeTB0S0ZE?=
 =?utf-8?B?eW1QUytsQkVzcnkvaUxDeXEwRitaZkNWRVNaS3Vjc09aZ05QSGE3em5jOGdl?=
 =?utf-8?B?aGJlaEhqUVZ1U2JDcHVGL3IxSW55SzNDOWlwcFFNejNmU3RLakY3bTlOWFpa?=
 =?utf-8?B?eE11akc5bzgvenZrSDhieGVteFRVN3pFZS9IaXlTNVF0VjMxdUg0a01RZEQy?=
 =?utf-8?B?UXRMcFowZ3E2d0lwa0lic3NHbi9ZaW10cWNVRkQxd3JLeVVGcU5uTFUzenZh?=
 =?utf-8?B?Z1lTanNnT2JCNFEwT2NKYktwUFJRZW5ObmV2QUtpNitEZSt1b2psRW5vZWY0?=
 =?utf-8?B?aXNON1dJd3RHMWIvSnN0MTJib1ViU3pJcjB2SEZqb3R5RDJLcHpLakxlVyt3?=
 =?utf-8?B?czhCemo2TEo0NHpZc1NDcWo2WHVERFdUQWkwZy9SYmZRRnlQaGhtYndqSjN4?=
 =?utf-8?B?S1JKVE1OTkhFTldwTk05alFoazFQZ2hvZVpiVDNGUC9ncnNDU1QvWG10OXhW?=
 =?utf-8?B?Z1pxSHAzQXp0dm9kVHNnWUZveWsyUjlvQW5pNnJ0a1h6cVcrRldXSnBIS3B2?=
 =?utf-8?B?cUU3QVd5alpUZWlDTVdkNWNYL0JUT2RXOHpGL3VwZEJENDhWSUJKN2h5RGJQ?=
 =?utf-8?B?RGtpc3gxK3p3NUlDMGVKVzBxZzFZbXNSSWFzZ1MwRndxQ0VZQ3BNRlh1b2k4?=
 =?utf-8?B?YWNlMklJOWdBTEFGVHdZclJ6WnVIb1VldkhoTmYzZHEvdHgxTWRrZkhhckFV?=
 =?utf-8?B?dEJYVGF0ZmV5R0VNUE11Y0Q5YStwSkNwNDdsVkxsNmtNVEVTWUpJai92d3Qr?=
 =?utf-8?B?a1I4K3NaZ3dVK2ZDYVFHL05Pa3NScDlGSWVVN2xlVW1EUHliTm9DS216aWd6?=
 =?utf-8?B?cW15K2FpdFU3SjhGSXJRaUpiMGlrOWxQU01IazU1MHlDazVuREdrM1dHTERP?=
 =?utf-8?B?czVNQXBXaldSbEhLQ0srUDNaYVh4ZHROeHg3TVRUais3V1lRMmk4Ui9DSnNC?=
 =?utf-8?B?R1FqQTJFV2N4MnliVEhHWGJSb2VaVXNoOG1uNytUM1pQV1JnMDQ4VVVtc09N?=
 =?utf-8?B?TklteUJmZWdncFd0TE83bUN2Njc3MzBjNnNoczBQWFlNZW1kaFdNRU00aE1i?=
 =?utf-8?B?SENLTUZjM3pJMlZrZFY2WXFucVJCUDZsS1hudU44d0RSaVNLdlJGRVY1dXBl?=
 =?utf-8?B?UmdTYzVHNkcvK25NTjh6VnNpMHQvTDQvb0gxS0pwemJhRm1MdVQ3azAwL2pw?=
 =?utf-8?B?cUJEVDR2VTBMKzJ3akRSdGwxellEZHkrNm1LeVJJR2RMODZxeXh3SUZjazhK?=
 =?utf-8?B?VHBUcnA5cC9tTEVjYUJNTmRzSVJwQm1xUVV1N0ZFeWFKd1JLV0dTYmtSbEhO?=
 =?utf-8?B?ZHJ6Y2wvWnhhdCtGRmVkYnQyRzFVbXhEK0w2UWhzUDZaQzQzdm9DUTZGMW5k?=
 =?utf-8?Q?7o0mh9zFjf3Se1+XKfyZ+JiJ1qWOLjtRu9DTFEd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3a9ad8-5df4-47bd-51ce-08de0a009ca5
X-MS-Exchange-CrossTenant-AuthSource: PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 02:31:28.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10017

Hi，Manivannan,

I see 6.18-rc1 is released. Could you please pick this fix for 6.18-rcX?

Thanks,

Chen

On 9/30/2025 8:43 AM, Chen Wang wrote:
>
> On 9/30/2025 2:13 AM, Christophe JAILLET wrote:
>> devm_pm_runtime_enable() is used in the probe, so pm_runtime_disable()
>> should not be called explicitly in the remove function.
>>
>> Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> LGTM.
>
> Acked-by: Chen Wang <unicorn_wang@outlook.com>
>
> Tested-by: Chen Wang <unicorn_wang@outlook.com> # on Pioneerbox.
>
> Thanks,
>
> Chen
>
>> ---
>> Compile tested only
>> ---
>>   drivers/pci/controller/cadence/pcie-sg2042.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c 
>> b/drivers/pci/controller/cadence/pcie-sg2042.c
>> index a077b28d4894..0c50c74d03ee 100644
>> --- a/drivers/pci/controller/cadence/pcie-sg2042.c
>> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
>> @@ -74,15 +74,12 @@ static int sg2042_pcie_probe(struct 
>> platform_device *pdev)
>>   static void sg2042_pcie_remove(struct platform_device *pdev)
>>   {
>>       struct cdns_pcie *pcie = platform_get_drvdata(pdev);
>> -    struct device *dev = &pdev->dev;
>>       struct cdns_pcie_rc *rc;
>>         rc = container_of(pcie, struct cdns_pcie_rc, pcie);
>>       cdns_pcie_host_disable(rc);
>>         cdns_pcie_disable_phy(pcie);
>> -
>> -    pm_runtime_disable(dev);
>>   }
>>     static int sg2042_pcie_suspend_noirq(struct device *dev)

