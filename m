Return-Path: <linux-pci+bounces-20361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D6CA1C623
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 03:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E06164E70
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 02:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE2183CD9;
	Sun, 26 Jan 2025 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eDMgjojj"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010007.outbound.protection.outlook.com [52.103.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391318828;
	Sun, 26 Jan 2025 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737858463; cv=fail; b=kTOpeUw1L34l3RkNVtL6jIhQVzemqkbT/esGa4imY1xagfRFrlPbOIJIdfOZYnOr/PxDH2o2n/q7I3rg4RNGnfPG7LFXuDVoEh3Xqix1M4vAdIghCrmoU4AIDcDI7leyVZGDWANCY8YIXoovW/CVpXG/bUQXCNcej0CPT3sXqkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737858463; c=relaxed/simple;
	bh=QxozMLI0GUSr5KvATUmL2YhMB2xEL6U8wgte6vHTra8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cTT76GQKpe8JDgad14Nc1qm0RvBLzgEwT/55pObxPV4Kix/SPVvQCcPVV4RMJdsL8VHY2CwPTIysC8VyiaLGFciftgm6F13Z9aWF2s2tr9ruXNzG2Rsko+MK1cB9zBRP2rtcj0UO7GMNMHoxjR1gA0g92IeEi7Tyh372GZbeyCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eDMgjojj; arc=fail smtp.client-ip=52.103.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjwpmRjNx6zfIE2jWrYelDMPUTaeyKXEOgb80yaR2m1/vAJOMM8f4nLTBC5/xwBqtRO5UKx7j3sOYo7IKiwYLslhMOOvFhiKlm/FQuIt0ojOVcrUKvR3Zv4Bn4q9jbJXJPrHJWTtVHZ/VtSKmhnGI+33B5jb7m8m6yEQw8BH2v9s7lEShZZC/OAK/yXNTpUsS9jSOrP/REpT7Bgr83p+3nLucuaboXbvKdlwDNRo2jjcrIcq9scFb5p203rVQEaQB5LFow+XLmkST+S2F3Osy2OyAOhIGPH82+tyEo69C/D/elIYmwWk3Ol/GYk5Xu+hquYfTevmkDaO1s3+pYHVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM5w0S8yeaCpStz1XhPk8O06U+2QnOHDqQt5Yha5OUc=;
 b=VBPlHfCPwrqjLLKHSiuZpyJ+DNOA/h5lZWRwQOfmheajwzQKfWuE2eMFdIrrDDp/Z01xBEKU9WvbRuOkNxNeVJVaT+UA/O9MGgQbp4pNUL9JzhhW5aK9tOY+4soJAG2q9hA5atYlPtdBUrVMrXXhgjdvgRGRGI2h1BmF5F6TPjscqj/z5PDfPutcQpf/zxdLaUvdABr2qTjvtIniolU6f+x1xFRQjYp/65zF3KHgLbX0MRDfaXr/Io2ihrEnLoNvt6RVMaLX0jOcOqMDxNU19n3XMmlmL5KLWmXWM7yjLKv2YilZPG8OKwZKGrwnDDMpI29JfXlIdfZ1bN70BxOOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM5w0S8yeaCpStz1XhPk8O06U+2QnOHDqQt5Yha5OUc=;
 b=eDMgjojj2CA+Vyq4pkpu+BYqwmphpATqXfiPMmGy76aOwuJXkcmgSHP40yJdbZuVPpU9erlsCyZ3O5BxBe+xAACa8pqyhPE66KLzXE2jd38atFVEtHJ3PKXrXL52TAk4zagjuiCg73SkxyanwdFHPoPzbJl48p5UY1Ubb3yGnqP8CRr8psLn0ZDAveEI1lsOupMlwNaM/Q8z26LDhlwFZvScLAZdkX5WyCasnnVydPgNxBJ7saQu1+NfbwRc4TgZlHhrcGofXrVEWPYh1NmB8VSGl5h4yK5mX+HqHm6mxBDZOXcEw47kl2SPF0LtPIEpMzKyH8rqKclIxR+L/mma1Q==
Received: from PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:64::10)
 by MA0PR01MB8754.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 02:27:31 +0000
Received: from PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c520:8ca7:e83e:e1e3]) by PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c520:8ca7:e83e:e1e3%4]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 02:27:31 +0000
Message-ID:
 <PN0PR01MB6028C76DCC20B81498081CE1FEED2@PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 26 Jan 2025 10:27:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
To: Bjorn Helgaas <helgaas@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20250122222147.GA1117670@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250122222147.GA1117670@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:64::10)
X-Microsoft-Original-Message-ID:
 <cd67089c-4538-4d37-9521-edbc1b0bd076@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB6028:EE_|MA0PR01MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc0adf4-5bd6-498e-0c73-08dd3db0fc14
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|19110799003|7092599003|8060799006|5072599009|6090799003|1602099012|10035399004|4302099013|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW8ya3dpemQxNk9FWnFmMzB0eFNvMDc4RVJLd2xUb1huZWFuYzZWWlVUSTF4?=
 =?utf-8?B?UmVzWldlNWZCRlFBdFpFbFIwU1cxem9md0MvWlNZNGtqVkVDVlhVay9vTmNI?=
 =?utf-8?B?SDNOT040WWd2NEJFbGtmRXFEQkNkbEl4T2dxcE11WEJTandrUGY0eXJrOWU1?=
 =?utf-8?B?VUd1WUZGeklNUStraDNlM1ZUbTNGU01FRXg5bEw5U09ySzhYTmZxcldiT3Jq?=
 =?utf-8?B?VDl2SnB0akJYSkdTQ1IvN0VQTTA0blBBZ2tKYTc1Wk84TGl5NEJBcCt5Umg1?=
 =?utf-8?B?MVluNFJrVEc5WGNJb1BLYWpEUy9kQ3lCbEdYeCt0NVZSREc5V0hnWlpoMzJY?=
 =?utf-8?B?ZFAwbVNjbGU4ZGRzZFFpdVJ6a2N2YXRSdkFCSjlvcUxuMUFxYUtOZUFNejIz?=
 =?utf-8?B?MVMrNkpvOXI2bHlJbmpKRTU3RTY1OTJLSXdZbmgwUFE0SFBTL1ZUZkNSYkYy?=
 =?utf-8?B?OFhqaEhucVJaMjhMU055OUlWZVU0eUQ3SnFCclZFUHBxdlFQTHlHV2tBRDQw?=
 =?utf-8?B?Q0d4Q1FraDFFNG1XUm82VnQzRnhURGJVODVyK2dReitnczE0ZUlwZ1JPOWt1?=
 =?utf-8?B?dTFRNUUwbVd2bkRzZms3STF2bVFoTGJEUHNlMXliVlArRWd2Y1AxMURCbkl1?=
 =?utf-8?B?c3ZZRWhqV25nNDAyVmFwS1QyMzY0eFl4dXZkYUN5aXcwK2Nnemh5dXliSWpN?=
 =?utf-8?B?VVREd2lCOUZmeTFDeGtlZTdVRjNwZWxtZnROelE0Qlp2YkFPazFHQXVyKzZz?=
 =?utf-8?B?TkVVWkNKbWJyY3RyeXhsMTJQOVR1RmV4bE9hRmRDL2tMN0NpY2l2QXhVdzF3?=
 =?utf-8?B?QVZSUmR2QXl6WnVDVDcxZFZUZnNpYm5lNVdOaU5Ja1UrSDE4ZnNGY3pWV3Q0?=
 =?utf-8?B?WmpHNlpZQ1N1NjFhZUhOdENoWHRUSFB4dHBJSUl1RDYwekpuemJneXZWY0Nv?=
 =?utf-8?B?WUpWTGhJSFpxYjRxV1NYaHVISTVHWUtUQk0vTndZOUlwQWEwbWM0OGlCYmV4?=
 =?utf-8?B?QW91OFhRYjVaWFFzSmowa0RFMjJZaEtlZG8zR05LVDh5d201M3laV0FlUXdk?=
 =?utf-8?B?bFdCbDVhV0ZTNFhsbzZBcHJPVUlpekRmV2dTOUhkTnZPbFd6M29iRWFWZDBG?=
 =?utf-8?B?RmY0Vld4S0pieDlqTHJYMFJSVWxhNEswd0g5ZC9qY09CZzZWZ3ZoMC9lNndI?=
 =?utf-8?B?Uy9Kd3hnb1hUMDgzRXIzczN3ZWp5aTdRZXFNWkVma1lERWNKbVB1aUk5TCtE?=
 =?utf-8?B?Y3Q4VVBTVjcxUGkxTjFlNXVqdG9oUHpmOEs3MWM0ZG8zNGZnT1JrUFpNSnZJ?=
 =?utf-8?B?aHJtWnhBMmpmMERmWU52SmxPSi9URUdnSGJzVHNsMDBOUnlxRkxybkRXeEov?=
 =?utf-8?B?NFZrR21hL3U5R3J0QWI1MFZEMVlxL0pncUVYV3dsa0l2ZUlnV1hSekFQNHkr?=
 =?utf-8?B?eE1nT1JIbzJkYXU4M3M0OFZFQy92bmxqZTQ1cGtzU2x0a05YK0U4dFF3UGZU?=
 =?utf-8?B?aEpkNzYrNWtMa0NVelNYNzNNekJVOStJeGE4OHlpOUt3cFFBRjBOUkVmTkhL?=
 =?utf-8?B?ZEp1ZzlHUldDMEloWkFkZ0F1a0R2cmZ3UmU3TTN0NHNHRit5a3pjL3Uvc0V3?=
 =?utf-8?B?WjZaZXppcnlIMTY0THVGd0dJYkZxaFJFMHdUMnF5WWRCVXVtUEZjYnN1V3Js?=
 =?utf-8?B?bXY4cGZkM1FCUjh3MDZsaFpSNkFPWEppNEFkQW14cWxDUndIRjZCeWNOelVY?=
 =?utf-8?Q?H+EtjRrV3Q+ChnXy8W8h8HAYCTvnzwjkBMYLgnk?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDlDdDMxbDdjS2M4UVF0NlVtcUREYVhYbk5KTXhuTjhLNzRrckJLdzgxRzEw?=
 =?utf-8?B?cjNFRVA2ck9sMlJXdVIrVVdKR0FTYURlbm1GMXNwRVIxYlhSSGpRS3JiNUVh?=
 =?utf-8?B?V0RERGZ2RTlzeFhmL1FwWHcxeWZkQndVVlJ4QUROL3M1cE9KSFhIT0V4a2lX?=
 =?utf-8?B?YXBJR3F5d3VwaUhqSWsyY1hGNUpSYzZscGRVTW8wcktKa1BPZTdUUGNYVjJv?=
 =?utf-8?B?U1lJZW5ZUWN0UVdYTUFzYVdXWENVS0N6aCtHMXZGeVIyQ0tpWC81STF4NVJ2?=
 =?utf-8?B?aldTYlF6b1NPNEZWbU1WZ3NMT1ZaY1hFMmFEZzV5U1FCZ2VWSjF2ems5Kzhw?=
 =?utf-8?B?OGpMR1M1YXY3WEtBbE40YkY3TVBsUTFvMnV4RVBkSGEwb09DL0RxZzNpU1Jm?=
 =?utf-8?B?NXNxc1BnZWo3d3NPaWNSTkNDeWttOFBLV0xtVVlDRjY2UHVJbXhhdlYweVd5?=
 =?utf-8?B?SXJFTldtY2pCbC9leDBSVjg0WCt2Y242ZXhPajdYT2NWM1NMK2NzZHpZVkM3?=
 =?utf-8?B?NEcxa3JLT1QrSDByYTRwWTZrRzFuME8wMnZ1SFdRbSt2RDFVRDdHQ09pbWpP?=
 =?utf-8?B?aUc1N0hDemxscHgyb3BVSVZLVkJEbTZxRmx3eVc2YjU0RGlGb09LdHp3UkZu?=
 =?utf-8?B?NHZRaGRtSUNRTUpOYk81SnJnanlnWStYK3dUN1FKdWdNR21UQnJLMVAzcWdp?=
 =?utf-8?B?a05ycDVseHdjNTREaGNsSDhXcUx1MEY0amlKSHNaK2tGSm14eFVlRlJubjNK?=
 =?utf-8?B?UVowVGRtZXp3UmJmM051cDVYempIclZTOW5vMFdTM3VBVTM5eWNQVlZFcG95?=
 =?utf-8?B?VzFUU0JSb3p4SW1ZV1d0S0VxNldnbVpqVmsvWU9uQ0xhNmV3U2wxR0FMOXJi?=
 =?utf-8?B?MUlpekxMbUo2clFyWnljNXd2RHRVTVpyV2hKUzJ0dURocitoQVRLNFRQejVj?=
 =?utf-8?B?US9heXBPbnp1ZFJiS0xLVHJWcUZOMVZNcFJjcm1Sa1VBWnBYR3I3UWdjUXNi?=
 =?utf-8?B?TkdwUllSQlJzYk43Z3lYWWI1WUgxazhzSDNPZUdnQ0VUL0lNT3Y2WGZ1L3Vt?=
 =?utf-8?B?Ynh0a25mUEQrQzF1S1YrdGUycmx2UUxrS0cyOGpmYnFsWkxsdDF5dzEwLzNt?=
 =?utf-8?B?SnBuNWN0QjdPbDF0d2NPVkZlV0E1RXJUTWhLR2VwVktoSlhLSjFPRWgvT1Bi?=
 =?utf-8?B?MzJLeHh3RFFiU0tPZ3NvZlFRR1hiNEd1Y2ZVYUFOQ3A4cE1MZ2Z5SXpEbVVS?=
 =?utf-8?B?MllGQWh3Zk90NjNyNVRaZWl0UE43Wk5PUllvbXRUbjMvUXBjaXY4TmE1azhx?=
 =?utf-8?B?VTZLWVF1bVhUNk41MVI0WjBtZFpsN2R1ZkZVWVJQYjN0L21iWHpqWWQ4OWpi?=
 =?utf-8?B?Nnc5WGFHQnNIazFzemlNYXR3dTJpZ3l0MG43WlpaUnJHbFo3YkJybnZhekZR?=
 =?utf-8?B?VGJTUXlaWnJvRCtFeEJPdnBVUzN4dFcxcjJCWkwwZlNnL2NjLzZVcXN6bFR4?=
 =?utf-8?B?UG02eWk4MCtKa01uK0pNY1RsWGZjZTdkRTQ4Z0svRG1kb0pTaStiZnVLb1V6?=
 =?utf-8?B?YzIzdk1Sa2MzNU9HSGhSVTNydHJoNXJBQU1taEZIZzZzNmdvZXlKS2t3NmpQ?=
 =?utf-8?B?Zm1xcFdXclZseTE0aEMrSGpJZzNMVlJxUlIvcDNjc2xLb3BndnNHajlqL1Zp?=
 =?utf-8?B?N1cwUXo3VkkvUC9ZcldIQ2pCS3ZMWGRwelEwempBUHZiWVREU1NvOHk4bzlD?=
 =?utf-8?Q?3sA4NdAP0eRSkMAtB2imxpl+jQidr92K59d+fyD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc0adf4-5bd6-498e-0c73-08dd3db0fc14
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 02:27:31.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8754

hello~

On 2025/1/23 6:21, Bjorn Helgaas wrote:
> On Wed, Jan 15, 2025 at 03:06:37PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add binding for Sophgo SG2042 PCIe host controller.
>> +  sophgo,link-id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      SG2042 uses Cadence IP, every IP is composed of 2 cores (called link0
>> +      & link1 as Cadence's term). Each core corresponds to a host bridge,
>> +      and each host bridge has only one root port. Their configuration
>> +      registers are completely independent. SG2042 integrates two Cadence IPs,
>> +      so there can actually be up to four host bridges. "sophgo,link-id" is
>> +      used to identify which core/link the PCIe host bridge node corresponds to.
> IIUC, the registers of Cadence IP 1 and IP 2 are completely
> independent, and if you describe both of them, you would have separate
> "pcie@62000000" stanzas with separate 'reg' and 'ranges' properties.

To be precise, for two cores of a cadence IP, each core has a separate 
set of configuration registers, that is, the configuration of each core 
is completely independent. This is also what I meant in the binding by 
"Each core corresponds to a host bridge, and each host bridge has only 
one root port. Their configuration registers are completely 
independent.". Maybe the "Their" here is a bit unclear. My original 
intention was to refer to the core. I can improve this description next 
time.

>  From the driver, it does not look like the registers for Link0 and
> Link1 are independent, since the driver claims the
> "sophgo,sg2042-pcie-host", which includes two Cores, and it tests
> pcie->link_id to select the correct register address and bit mask.
In the driver code, one "sophgo,sg2042-pcie-host" corresponds to one 
core, not two. So, you can see in patch 4 of this pathset [1], 3 pcie 
host-bridge nodes are defined, pcie_rc0 ~ pcie_rc2, each corresponding 
to one core.

[1]:https://lore.kernel.org/linux-riscv/4a1f23e5426bfb56cad9c07f90d4efaad5eab976.1736923025.git.unicorn_wang@outlook.com/


I also need to explain that link0 and link1 are actually completely 
independent in PCIE processing, but when sophgo implements the internal 
msi controller for PCIE, its design is not good enough, and the 
registers for processing msi are not made separately for link0 and 
link1, but mixed together, which is what I said 
cdns_pcie0_ctrl/cdns_pcie1_ctrl. In these two new register files added 
by sophgo (only involving MSI processing), take the second cadence IP as 
an example, some registers are used to control the msi controller of 
pcie_rc1 (corresponding to link0), and some registers are used to 
control the msi controller of pcie_rc2 (corresponding to link1). In a 
more complicated situation, some bits in a register are used to control 
pcie_rc1, and some bits are used to control pcie_rc2. This is why I have 
to add the link_id attribute to know whether the current PCIe host 
bridge corresponds to link0 or link1, so that when processing the msi 
controller related to this pcie host bridge, we can find the 
corresponding register or even the bit of a register in cdns_pcieX_ctrl.


> "sophgo,link-id" corresponds to Cadence documentation, but I think it
> is somewhat misleading in the binding because a PCIe "Link" refers to
> the downstream side of a Root Port.  If we use "link-id" to identify
> either Core0 or Core1 of a Cadence IP, it sort of bakes in the
> idea that there can never be more than one Root Port per Core.
The fact is that for the cadence IP used by sg2042, only one root port 
is supported per core.
>
> Since each Core is the root of a separate PCI hierarchy, it seems like
> maybe there should be a stanza for the Core so there's a place where
> per-hierarchy things like "linux,pci-domain" properties could go,
> e.g.,
>
>    pcie@62000000 {		// IP 1, single-link mode
>      compatible = "sophgo,sg2042-pcie-host";
>      reg = <...>;
>      ranges = <...>;
>
>      core0 {
>        sophgo,core-id = <0>;
>        linux,pci-domain = <0>;
>
>        port {
>          num-lanes = <4>;	// all lanes
>        };
>      };
>    };
>
>    pcie@82000000 {		// IP 2, dual-link mode
>      compatible = "sophgo,sg2042-pcie-host";
>      reg = <...>;
>      ranges = <...>;
>
>      core0 {
>        sophgo,core-id = <0>;
>        linux,pci-domain = <1>;
>
>        port {
>          num-lanes = <2>;	// half of lanes
>        };
>      };
>
>      core1 {
>        sophgo,core-id = <1>;
>        linux,pci-domain = <2>;
>
>        port {
>          num-lanes = <2>;	// half of lanes
>        };
>      };
>    };

Based on the above analysis, I think the introduction of a three-layer 
structure (pcie-core-port) looks a bit too complicated for candence IP. 
In fact, the source of the discussion at the beginning of this issue was 
whether some attributes should be placed under the host bridge or the 
root port. I suggest that adding the root port layer on the basis of the 
existing patch may be enough. What do you think?

e.g.,

pcie_rc0: pcie@7060000000 {
     compatible = "sophgo,sg2042-pcie-host";
     ...... // host bride level properties
     sophgo,link-id = <0>;
     port {
         // port level properties
         vendor-id = <0x1f1c>;
         device-id = <0x2042>;
         num-lanes = <4>;
     }
};

pcie_rc1: pcie@7062000000 {
     compatible = "sophgo,sg2042-pcie-host";
     ...... // host bride level properties
     sophgo,link-id = <0>;
     port {
         // port level properties
         vendor-id = <0x1f1c>;
         device-id = <0x2042>;
         num-lanes = <2>;
     };
};

pcie_rc2: pcie@7062800000 {
     compatible = "sophgo,sg2042-pcie-host";
     ...... // host bride level properties
     sophgo,link-id = <0>;
     port {
         // port level properties
         vendor-id = <0x1f1c>;
         device-id = <0x2042>;
         num-lanes = <2>;
     }
};

[......]

>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    pcie@62000000 {
>> +      compatible = "sophgo,sg2042-pcie-host";
>> +      device_type = "pci";
>> +      reg = <0x62000000  0x00800000>,
>> +            <0x48000000  0x00001000>;
>> +      reg-names = "reg", "cfg";
>> +      #address-cells = <3>;
>> +      #size-cells = <2>;
>> +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
>> +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
>> +      bus-range = <0x00 0xff>;
>> +      vendor-id = <0x1f1c>;
>> +      device-id = <0x2042>;
>> +      cdns,no-bar-match-nbits = <48>;
>> +      sophgo,link-id = <0>;
>> +      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
>> +      msi-parent = <&msi_pcie>;
>> +      msi_pcie: msi {
>> +        compatible = "sophgo,sg2042-pcie-msi";
>> +        msi-controller;
>> +        interrupt-parent = <&intc>;
>> +        interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-names = "msi";
>> +      };
>> +    };
> It would be helpful for me if the example showed how both link-id 0
> and link-id 1 would be used (or whatever they end up being named).
> I assume both have to be somewhere in the same pcie@62000000 device to
> make this work.
>
> Bjorn

