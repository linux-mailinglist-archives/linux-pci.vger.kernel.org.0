Return-Path: <linux-pci+bounces-35072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C93B3AEFF
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 02:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A98D3B4EE5
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 00:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837F1DFFC;
	Fri, 29 Aug 2025 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="s4+bfDyq"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1579CD;
	Fri, 29 Aug 2025 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426638; cv=fail; b=EiSHwSb6mvCqbTMxNfnO05fWFbB9kJy6BDxBd11n2ZlVzzYYyJxpTQAfMLUUbpqN8ILEW1htIwDvKj+oDpQch4I9KTwHMEaQZOwLW2ki0GzB5x9FbCJkhrete9qIUUqmrSG4rVkXnnqGU/k7aD8ZD8BzAIBk5H6xzVwwWtvM5r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426638; c=relaxed/simple;
	bh=7XmqyAnVrlq/ysT6e1BMmcbOhpKMkk/mHvHgoFS4p9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XUXaFQndGSj0nWq8gxC/kj3WsTeldfUevd2QT1v0PEkFwvmQpxJtbbd2IaxA1Vw4jBJsCJO3HQbuchdWr+8fDHZt5kw7H5+W4nUyguGghArMtC9TqoGnH9T+nzmLSSeeRXhX+ySvg2MsXPgb7qWfibDUMTPZxO8mNo5qP8qujgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=s4+bfDyq; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAO1YcFPwkbNF8rAm+OiHSwDx1Rldvqk4XDdsS6B/SofbOaEbkrKkzZV+y39iiBaYBSsF1dkMZ9JqOEvwk+DfIsx8qNFmBCQsoonDRSKSaetqZswsCNEJKUg3W1V7FP5wt7iAn1/qaEoMAsKMsc/qfpryS1MWuUNj61eCEbqzIq5YCFJMKaYD9rpH6FxUXBx7E2mfV43vAPXgGkdzwEArauEktXNvJMvEPco3QSdKPWdQ1rjJlDs8zqUFjPi6O4+MQPqnHAV158y2noGu3o/78MQjEyOBNRY7HRSTNTA1S7IH5SWr2aKrFKCXxpleXvemQPBxHDsH5z5AHW6S60W6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO9DBWuy2BxOtGpeSJBd6MctchCvSIF1YVEiraMpRYE=;
 b=m6tiwS5Hvo5tgnZbRmXWYFRwLZqPrLhB4mDysa5JC/bU3EPeM9QDkICnNz5GZZpYrA2KQ7txV8Y0zNTuDBkivY+hwlNTIGfDVVXrDh3fknp8K1aWZ97mcyRBBRL02I0mHeF1oAMP1mDWydgG78OR73nEmC0OW81vOd4HCe6fC4rArdnFNC6Bd2DjSdX1zk1GeKoSrba5IpVmAp+rFMd0hNg/vNlol9rS5R70e2qHeS9AUZTn2/e01U3TaMUAeyz6NmT/ws4sO0CWQ3PdrHoEruUziANLAhK/GI9/dueYwGmRSKYCwTDaoTX8IDaK+D95Mkln88jTuY4nShvuMYw04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO9DBWuy2BxOtGpeSJBd6MctchCvSIF1YVEiraMpRYE=;
 b=s4+bfDyq4/DOid+btG6zn/3tRSko5lE+DAPPXvpUDjQQKQBL53jv7nmuCdak5toO5joF39A3NkOX2AOAN9YqG0F/mT2VIm9jgFntlZt45AuATOwnwwuWxYw3sqQ1UwZr87Vrm7SlhC2LclTemHED1HCeubd0pWjC8fDt4FU/sC7uwX9rCddoxhY4yQDVaJgH71FpOVSr7WZMyl7WxG7+M7cruvwA4eTWHVBVadUftq7YM+HvMcO+4LTi28+uBFxLGsObG0Ofq1dgLhRvKxo1al4PMU2VG7Nj62IQ/EGSidOrGL5EWBuZxgmz4qIVXmvyOy2ESgjvoo+4JDYrLchcBg==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PNZPR01MB4270.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 00:17:06 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 00:17:06 +0000
Message-ID:
 <MAUPR01MB11072761AFC08D7F9A1EAEC08FE3AA@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 29 Aug 2025 08:16:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] PCI: cadence: Fix NULL pointer error for ops
To: Bjorn Helgaas <helgaas@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kwilczynski@kernel.org, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de, bwawrzyn@cisco.com,
 bhelgaas@google.com, conor+dt@kernel.org, 18255117159@163.com,
 inochiama@gmail.com, kishon@kernel.org, krzk+dt@kernel.org,
 lpieralisi@kernel.org, mani@kernel.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, s-vadapalli@ti.com,
 tglx@linutronix.de, thomas.richard@bootlin.com, sycamoremoon376@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, rabenda.cn@gmail.com, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20250828214302.GA968773@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250828214302.GA968773@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <31a4294e-86e3-45e1-9745-1ab0ad0b0933@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PNZPR01MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: b12381bd-ee1a-4573-74ce-08dde69162c5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|461199028|6090799003|5072599009|15080799012|23021999003|8060799015|40105399003|41105399003|52005399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGFDcUhmYlVIbXBBSHR4SklUQVIyejRXdXh6Q0M4RW5JRHA0ek00UGZMTW1L?=
 =?utf-8?B?MmNHbVBGbDMrUE83QmhHcVZvQWszcWExTkpoYzR5eDR0NmZ2QVQrN1JDT0Ux?=
 =?utf-8?B?NjdBUFJLMUQ3RytVa2dEaEEzdWhhMHlTaVpmWVJuZXdIN2kzc2ZFTjY2ZkpG?=
 =?utf-8?B?R2tpMTJlK1BPWjVLRkExNERMTUovcVBNcFd2MmhDdzFxd3liTUVQaDhNV1oz?=
 =?utf-8?B?c0FJY2VUZlZhRERxVWl0WDcyWWFqTUJtWmc1NXExOFB0MWFYK1pjV3h3Q2NN?=
 =?utf-8?B?dUJQZG43NDNxS0dYMEt6Q2pxRjNodUtxNDlXRVpycDJaK0p2S09vb296ZUhs?=
 =?utf-8?B?Z3N2K3R3OVFpU3czM3JDUlMrNHRBU2lFQWc4cFNsaW05bjlOeW10VTIwZ3Jn?=
 =?utf-8?B?ZnhsZys0NzNJb2lKMnMrTHRPUitRYzJEVll3TjE3T0xwckhxbWhZcWoxeldT?=
 =?utf-8?B?d1BGOFFLVEJxQ1pTUlVCYmlSUDBDeUFuMjVlc2xjNzNFWTNUU0hVTHl1KzF2?=
 =?utf-8?B?WVpCcjJjMGRVb1hScjZPNmk2anZwOE1RcVpiNHNUOEpaMDUzU3d2MC8yZlI4?=
 =?utf-8?B?MllIUTNHUklaZEZKTTBZMjZINkdsSW9yVExkdU5mdldZa0t5YWhMWDJTaUgy?=
 =?utf-8?B?RjhVSUdIQm5KQVRVUW5aejN6R2pyNktTQmkxV09LbU5WWU5DZFMwSUt0NjBa?=
 =?utf-8?B?T01NbXA3bkxDbFZ0V2JqRkZOSkI3MTFoaUpnMDdhZHNJbWhJTUFTSld2VldS?=
 =?utf-8?B?d2NqMTZXODdaZjFuY1ExaGt4b2w0ZXkzYmxmMmdQNHB2WkNqU25TQXF6eDkx?=
 =?utf-8?B?cEJjL09vREtHL29iLzNlNDFNckYvdUxCTDlodU1tQ2VQSDB4c0NmaWxBQzVt?=
 =?utf-8?B?SVdDbnFZbjNkMklnV1JpU3BuS2crVDhlRU43TG1LamlhRXFoalAzMXBzVzYw?=
 =?utf-8?B?Z1k0UlF1TlNTUStKL0ttOHc1SVFzK2pkKzNhTFZiMUFWZDdscUtYem5yWWxO?=
 =?utf-8?B?UFRMeWhxUWZMSFl3SHJ4NmI0OUZUZExtVDB0bjFHS1o5dlZRa1psOU41Q3lW?=
 =?utf-8?B?UDZXL1RLcDh2ZHhMTXZ2RkdkclRRU2FaUlNQd2RObGdIYm5tbVZhcTd2SmZi?=
 =?utf-8?B?NGFVNzJYVXJnMHBvM01SMURnRk5qU2wvb0NVZ3FYY2J6M2ZwTEFqSStnaUJq?=
 =?utf-8?B?MUNxaW5hZWVvK25tdVlGZ3BQREd3bHp4aUg1YXpDd2M0WjZWNmhRcldpQTBB?=
 =?utf-8?B?Wm1MU1FVL0krZmIrVUxmNzZQbU9UTVpqY2dXOWc1QVA0OVdtcFVxZzVnUVI2?=
 =?utf-8?B?TEtRR0lPVUJhNk02NWgvK0ZsbDdmWkRSNWxBakk0dU5kK2JNK3M3c2Y1ZmVV?=
 =?utf-8?B?eDdIOGZLOVJlZ3JJZktPU1NKSlVRekdlMGdhYmFLbUViN3ptZ0lUSjR0V1pR?=
 =?utf-8?B?SE9CSjlzTWVKcGpRZzFhWloxcTY1WHl2TElSY2VrV0kyVW5NQWo0Zy9URGpR?=
 =?utf-8?B?bGM2cS9TV2VhNU9SbTM5cTNWZEJ1NEQ0eDRlVXVWcG0zWVRmMXEwQ3FKbjhk?=
 =?utf-8?B?R0RzQ0FudkVCNDl3L0orOTVlMHZsNDEyTFFSTVJvVXNJRU9tTFQ3SkNYQm1U?=
 =?utf-8?Q?NqxeyyQFth4A4KGYerlfbWrsUTtQqHgnhzvEpThy8wvA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGhzcEhISUwzQ0lYdXRIN1BRU01SaGZvSmJSUTNvWGJMczUwRFhUYkhpQWRj?=
 =?utf-8?B?MjAyRFlvRXJCQ2NOR3Q4VVZiTkVtQkd4dXc5SFdUcU94aVdCYVlGUmFvRFp6?=
 =?utf-8?B?cGg4cml0M1hIUGlZakdncWlqeVBIc0NSSnBMaVdDZjluSHRPR2tBczhabnlW?=
 =?utf-8?B?Yk5aU1JWcDdNekJtU2prZUd3OWdIbmdzUVhXSXU5SGxFM1VtVWhKY20yVGRq?=
 =?utf-8?B?SEJJalpYeGZ2OWN3Z3hHZVl5Sk9jOHA1RXhTV1I4aXpHNk50eml6Z0E2UmhP?=
 =?utf-8?B?a1lTTWVyY2x3dXRwVmJLSHRlU0NWdUJ6NDVyN2gwZGkxdFExVW9OTmdzc0VJ?=
 =?utf-8?B?eDZuVTF5b0dxVHM3SW5YZ1dYcVpvTEZkd2lETjg5SE5IOU9iMEVJZzYxZTBV?=
 =?utf-8?B?czdqaW1hQUhvZzNqYXpTQTh5aVVROGlsUDBkUEJkM3RnaXF5Q2phSERqUzlR?=
 =?utf-8?B?ZUk2NC9Eb1ozWGMzMkFVZUNHaFYyaFdrS3puTi95dTUzNEhPc0psZVMwZll0?=
 =?utf-8?B?cnBnSlZmTHhITkJMc0dodkxWTmpSK3ErR1hKZmpEMld1a3N2NnBSS293SlBt?=
 =?utf-8?B?dis5dlMwcXpBZXY0SC9SV3daYzJ5d0krcGRYc3NyOVdXakxDUmdtVE5RdW44?=
 =?utf-8?B?REFyYWI4eUM0ZURpWjI5OFVTNWt0aE40WWVKcGlEdVorSTJPYThYbWhlUTY4?=
 =?utf-8?B?ZVMrdnlYalNvaXVwTDA1Z2d2ampLZEVEQVFMaHJ1RmFheVU5Y1FvaWVzOWFo?=
 =?utf-8?B?UlBvbEF1NkpHeGp5SEZIYjV4Uzg2YXZRUXl6UGVOL1U0b0tld2JEM3gxTDFk?=
 =?utf-8?B?TFRRejlVN3hnbWNsUGhwQ2thMGZnOUNmUG9JbnAwcDk0ZEJ2THVtbzJaeWQ2?=
 =?utf-8?B?azg4a3JJc2dNaGpYYjdHa2xKYWpiTmtlWDVJSFB1Y0ZLeWVGOEk1T0tOd292?=
 =?utf-8?B?OCtNUzIza0c1NSt6UDdLd3BzY3lJRml3Nm1Gb3czMEl1cVh2UzJ6QStXUVFq?=
 =?utf-8?B?Wk1obCs3VVBVc0JYS3hkZHZvaTQ4dzZzaE9MeVJaZXlsSEtTSFVVbTJ6d2Mr?=
 =?utf-8?B?RE83YS9SZEpadzFDN2ZyekN6TWhGL3N5bjh0dEhxUk10U3lUN1ltVGFXeTk4?=
 =?utf-8?B?NzIrcHdnWFVZSURBRm90SmxUNDA5aGg4OXFwQS9kRC9HSmJKaXJENXR6TzBW?=
 =?utf-8?B?MjY5OTdUOE02a3A4UGVNUlVya0t2SHJpeStvZ0w2Ni83cDZBVGExajNaM251?=
 =?utf-8?B?QTM1ZXdINlNjdnBSbWwrNW14ZXpyaXViejc1QjZ2dkIzVE9Wa2FYUmhXdnRi?=
 =?utf-8?B?eE1rSFd4OXJ6OExwOFNrY0s3NFBpNlpFMVNBZ2NrL0xMRGJqRUlWM2ROUTJI?=
 =?utf-8?B?Mk9tSW1DK09tM1JkMlBIb1JuYkVMWEVKSEhDQVRGNGdIRHdNaU83ZkEyZ0ds?=
 =?utf-8?B?RngwWXpIZVVkaWhFMDJRaDNOTUJRd1ZsOXBZbVdJUC9aRVlLSFcyaHpWOVVX?=
 =?utf-8?B?WTB4Q3FYUE9sSWJ2OTMySnEwK0hRaXhoVFE5cytHeWF0M2pLOGE4ckYxeGJK?=
 =?utf-8?B?WXNqMVZWRks0eVdGUlYzOXp2Uy80NE5MM1pmbXIzcFFCcVdMMndOc2w1NmFP?=
 =?utf-8?B?RURlL0pJK0VkS0IrSllETVBuaUNVbXJxTktXNWdBRHU4VThTK3VkRUVlcWw1?=
 =?utf-8?B?cTF2S2dhUVpIdEFOTkk3UFhWV3drNUhVUmRYeE0ybnJSbllka2puZWgzS0p1?=
 =?utf-8?Q?Zi1VLFeipXn1FFuJOc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12381bd-ee1a-4573-74ce-08dde69162c5
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 00:17:06.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4270


On 8/29/2025 5:43 AM, Bjorn Helgaas wrote:
> On Thu, Aug 28, 2025 at 10:17:17AM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> ops of struct cdns_pcie may be NULL, direct use
>> will result in a null pointer error.
>>
>> Add checking of pcie->ops before using it.
>>
>> Fixes: 40d957e6f9eb ("PCI: cadence: Add support to start link and verify link status")
> Do you observe this NULL pointer dereference with an existing driver?
>
> If this is only to make it possible to add a new driver that doesn't
> supply a pcie->ops pointer, it doesn't need a Fixes: tag because
> there's not a problem with existing drivers and this change would not
> need to be backported.
>
> If it *is* a problem with an existing driver, please point out which
> one.

No, the existing driver does not have this problem. Only my newly added 
driver doesn't supply a pcie->ops pointer.

I will remove this Fixes tag in next revision.

Thanks,

Chen

[......]


