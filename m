Return-Path: <linux-pci+bounces-21959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9549FA3EB5E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 04:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8FE178A17
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 03:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753691D5CD4;
	Fri, 21 Feb 2025 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X49n3dxZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95613A3F7;
	Fri, 21 Feb 2025 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740108579; cv=fail; b=Xg1Ylzu5YNfx0mnpmWLJfu4rFBeBPQslgP3jgkobbpT2hejC980O41H0mf5NoduTonXM13p2JysGpbBPf7dxWRSmOtsfIDjD/VgTY/g28Cas8msFBVKvAS0TS9UWm/sYH9ue6rBRHu+9p3jrgAxdUrZ1i5FWSe3Ps2e87Vme1FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740108579; c=relaxed/simple;
	bh=5CttMkVZo6nGmNa1/sm8fJMvRNezOhtAHuXDEg61DeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ri6qlH5ys/v2OICRdnu5HiNRRxlGC4De2k3tWYuki9yXC0zij5HnSQ+qzWJ+4TKJL8lS0Cc5JiSO5+ktcPTvJXjNm8DdoNpeYrXNsqKfuKPpM+136bE+lWcXTroNzJytirjf5WqGrRk8hAvaUlOdQEHZtNe9i9OBPdAKTA7LNJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X49n3dxZ; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvmiuQuZRdPQrb08CjMK9JmKKo21XlwqSHH82w4QX04AFDYz6cY7gFZr5aNZHygPv8lwmDO4JsDnQpc6lB0GUOJcM3LYxIlU4vlbY1sqJbkYHQAykPCigogS15oJV7GdWF8q3gQpMMgdxOCA0cCOYuiqh4/lDx8DAF04+MCL8uzIquJWwWGPxHP6j0fXoqWXvb22lLaAsEg98wML0mFkAimZZTLgtINlwS4VpHOy1WPNYBerBO01PXu3voMF0Jfeqe4/gRjvIpOyAmw2tFpjVJcu0fjhUKOJefEInf/vwymjS/IrSVrdDhTh7PZRJoOOuR9Dp+6abXku5RkPLLFmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFxW24W6Tr0+8ACc81E82PLmMKGz2AOg9O5lB1jX5QE=;
 b=XKLyeuIabMFoEzkpYl/Jo6MabdOXxFgYgJC9KwCCTkf0FjULyYV0n3qWaDKEP/R0kKeTTW0eRjtQ2nL0tSljQ7SkOWmSg0VPpxsRoUrlZzcbnVI7Rz6xuEjvnhhiXceigCfRLvGqcKj+iRKt4ADzGDa/9DqJBvKq1gnwuprOPkLr2k5+IhV9cRsiDlwOCeIGus4aOr4BLxMHsxB+mYcADnMbN1XxOcYsbuzV/KYiylKIy8gveRW4weFrjLcGRRAOknyfsSYhXDWeulSHPxfm2vttI9Whb/MJfB4PK3L5+JWURUhxx3qvvrNEqSm5DZMBLzJiP1+fQ6HmIAw2TJcNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFxW24W6Tr0+8ACc81E82PLmMKGz2AOg9O5lB1jX5QE=;
 b=X49n3dxZQND88N5HyEdBLN4G9iTZ5fIN8TWOMsYNftM7mG3FB7u8jirdq6kDW7s0ZfHGkoBdkvkXJCXsOvmlZC1FLRiOimq29DHv29tF2i4Me5tWQGRAb0kkCQYHDGyLvi+oGL9/nLZPZDOILV+Lq/hR6qHvZbAmmlO45SG6V2N3Ki7+nfXxQQfNYWnQ/mxXDgdM3SQdWottY5KXxhm6q2RwL9JxVZ8u7A4BmdOlFQp3L1TRLikSdxk+O8HpyqV5wjcSJ+sp8AKz7JW6soOGNBCL4lLE+5jWc5YNnQg4fLSCfgZdQcH1oZb1bKt63OoEIZ8laYihuJJKik86UeHttA==
Received: from PN0PR01MB5662.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:62::12)
 by MA0PR01MB8801.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 03:29:28 +0000
Received: from PN0PR01MB5662.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::da87:15b3:46a4:7fba]) by PN0PR01MB5662.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::da87:15b3:46a4:7fba%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 03:29:28 +0000
Message-ID:
 <PN0PR01MB5662DF3C3D71A274A2E5B9C2FEC72@PN0PR01MB5662.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 21 Feb 2025 11:29:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20250219182247.GA225989@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250219182247.GA225989@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:404:56::21) To PN0PR01MB5662.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:62::12)
X-Microsoft-Original-Message-ID:
 <f5ea288e-697f-433b-95a9-f0b4d926d56b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB5662:EE_|MA0PR01MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 29cc7881-c914-460c-29ec-08dd5227f1b8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|15080799006|461199028|7092599003|6090799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk9hemxHZWhpWlVQWmhRSCtMZjg1TjdiT2ZET000YitjeVlMc1ptQXJyYTd2?=
 =?utf-8?B?S0tySVRqa1BDMHhqUGlYbmg4R2g1ZnZtVnBBVG16MHZXM1NRRDVWKytJUldF?=
 =?utf-8?B?Nlg2aUpiaFZEclJPVDg3NnhBZkJhMlN3Y2tZSTQzYU9HRldDWmNkZm5wWmUr?=
 =?utf-8?B?WGdneXU3RWxXUkhsQTREYU53VHVpQm9hNk1lMENwdlpnZ04yTFVSLzAwRnFx?=
 =?utf-8?B?Mi81VHhtQmFoVFhIU2dYL2VDc1c1b0Fxd1I0TmpTek5jYkhJRU81UXFONnhX?=
 =?utf-8?B?bjJkcXNERGhncmw0Tmc3OFgrN0RxcGxuWkVBTlVEWmI5NE1CTk55aGpjWS94?=
 =?utf-8?B?U1REUnVlaGw1K1JGeVl2Rm9CWDBnL3B1czArZTJwRzA1bHhXMDI0dHRjRnVh?=
 =?utf-8?B?RXZ0UStqNUdrSWY4andXYjVMazlLMmlMWWlnZ2R6NUVwU1FIeHdVV2hMSGt0?=
 =?utf-8?B?eFVjeVhGS3Q4R0I4TVI4cWFxU0g1UmVVR0hSUzlSUEpOWFR1RU1FNWsxUGY2?=
 =?utf-8?B?bUYyd2loWDhycUN4Nkg0dXluNkRKSjJzRHBPa0NSa2ZRTHRTM1NhYXU3cGpW?=
 =?utf-8?B?U3lleEFhRVllUUgyUklvaXFDUEI5QXg0bDNINXN6YmlldDNlZUtmRFo4SWdV?=
 =?utf-8?B?N0lvRFc0VnF5a05LZlRoc0k0T3JPdjZkeWhxQnVSME1nbkZKRjlGUVV0dkZw?=
 =?utf-8?B?SVdCZFlWN2lmMVpkU3hxTXFjbXMrdkF6K3dUYUdMRU9mbU51cjV2S1l2VkJC?=
 =?utf-8?B?WUV5UGgrVFRDV25RMk9iN3NrQzFmdlhkRDJlZGV1bzVXdzI4YzFqVEpHUkVw?=
 =?utf-8?B?Q3dRS2NYK2hJbktBTko0enRCWnFDb1owczc1djNsb3BkemovMzYwNThQVW5D?=
 =?utf-8?B?dnJ4MlhzVmlma0xSbW9EREI2bUZ5OGhDRlFqUmp1TEFQc1Y4YkdIbUxiZnJF?=
 =?utf-8?B?RStLMUFxYWh2N3h2OHljL1dia25uV0htYk5RZW1RUHhDMlZUc1F4c0hXbFhE?=
 =?utf-8?B?a2tMUSt1aWt2RisyblV1TG5XSGVqbWk5WXN1U29PaGJ3VUpJeTlLMmlDYTRj?=
 =?utf-8?B?ZEpNOWVHa21YMG1BakM0dnZheGNKWHZ1cmNaSzFaLzdmbkRzMHVJL3pIZHhY?=
 =?utf-8?B?VElnTWxCdG15YjAwZTl6bVZEUG44UEY3ZkdYY29ZdHlnZ3BjYjFuY2Yrbm5j?=
 =?utf-8?B?UlFPN1F0a2ZBc2xDNURSeWxhdzgvay9uUlBKbndpZUdtOThGcTNJMW1ZK053?=
 =?utf-8?B?aTZFekpLZU1PRkNjUCtTTEtzOUFPVTVycnY1UVlHUnphVk1DZk5KQVovVkg4?=
 =?utf-8?B?YU5wZ3pZb0R2UWN4ZHdaZzIwSko5WnN0aXh0TnhZcXc3Nmg0QWNDNDNWOTZF?=
 =?utf-8?B?TkVOalQ3Sjczb2J6THZuOVpkMExyRk9ZeGF3emc5ZzAyZHdiQmtjTEQ1VEk2?=
 =?utf-8?B?RUJSd1dDd3VNL0pNWkh0Qk9pYVhzY3NhKzFOLzZsb3RRT1ZsOU1zRVVMOUls?=
 =?utf-8?Q?s+HaO4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1htRUFFdWdBWk9vZ0ZkeHF4NHl4T2phMWcrUDhrRUtBOFd3bzR3TXNEMUZZ?=
 =?utf-8?B?M3NtMGJVY2RtUlVXeHJ6eFlMU3E4RXErekhNcG9KcG5kWGV3ekl1SjNGQ3Ey?=
 =?utf-8?B?YitJL3dtSEZwUDJIYnJVVXdOeFBuUUN4ODVNeklMNkV1emxkNUlnbnB3NGpZ?=
 =?utf-8?B?SmVGMEdiSENlS0t3QzYyZDVzb28xNmtkTi95ZWRKSzlQVXJjaXg2NWYrRzgw?=
 =?utf-8?B?WjhsREpYK1BaUW14Rm9aMVlXQ0lERUxSRHBQQWpVbzdna3RYY0x5RkYwZ0ll?=
 =?utf-8?B?KzI2Umt5bUZmc29ZbE9WZ2p3Uk14UjJFeVd6Qlk4dDhIZTJjbEo5Y2FsU3E2?=
 =?utf-8?B?ajBDVkVjaWl6Y25nYkxXQno3S2pIZjhxdllLZjdPNDdEazlONmhIcVcvZE1n?=
 =?utf-8?B?Ulp1aUV6eGtES3dyQmUwSU5jZVo2VmJjcFVJOHRKTCtGd3piUlRpaEQzSFI1?=
 =?utf-8?B?TlVFbDFRNm15eGdoWFZHbGpjN0tQQVQxckpJelU2SXpDemdkaEdBUXdXZkYx?=
 =?utf-8?B?MUdvMkF0Q3lIcy94bGVEdGRzODJGOEZySzB1QnA1VHR6a0xTK2laZ29IYVNB?=
 =?utf-8?B?VW9sSThEdG1yTFVDb1g1WlJnbmNqOFVtNkJtWFh6NFZVa05OdEFiRWZINmRl?=
 =?utf-8?B?ZEMwOHV5VjQ4WGhnMUVoVU83UHFZeFpNTEUrREtvOUVCcU9zWG5pM0JRQ1Vt?=
 =?utf-8?B?amY1MURTM3c0ZWY0YTB4ZHgzVVBjTzJMWnNIaWlHWXpoTkRQYWQrUXpQVTVv?=
 =?utf-8?B?dmQ1Y2lrckdiRXlkZFRkWFBpSXhuYXdlYTQwZVloQjA0SkZUczUzMFhQRGth?=
 =?utf-8?B?aUF2ZzZjL1MzdUhtTy93QTEwcHhPYXQxVEFEM2FrYm14TVNEektTbHF2ZjFV?=
 =?utf-8?B?dnRJdDh0WXJvVWFpdklJaTJNL1BDdzcyK0syNW1RZXR1N1J0bitMaElUa1ky?=
 =?utf-8?B?d3doQ3lPVGtNZDlGL2MxUnBkQ2dsY1ZsdmRiYjJubzMxZlQvYnJzZU5HZ0lh?=
 =?utf-8?B?eUhXQ3VPVGdpMm16Wk5sWWdteno3Yi9EOXNBek1naDhaak8vV0tZZkhQWHlG?=
 =?utf-8?B?TVBtN1d2WllCOVpITXVnaFB5UjRkZnQrY3dFeTZvYUJNeVRaR0dldTRsU09K?=
 =?utf-8?B?blptUWtCZmkyc1h6bm1xa3BEK09IUHpLODE5ZWE2aG5zZUJmRGp4U3NBNEZw?=
 =?utf-8?B?dzNxWTdEQWFNdjhtWkVIYjdoWWRiTDR0TCtrSzgzRFRyR0RBcFZsaEMrR1VW?=
 =?utf-8?B?bmJ5aHpYYU11b0NxOUhpYlV2QTlVUTEycjMxcWc2ZFVJV2NHUE13bEhzSmZQ?=
 =?utf-8?B?dHlEQjRiY05GaFEyMHZFT2VrdFJobUJXLytTT29sSUdoTkV5TlVoVlFmbWRo?=
 =?utf-8?B?UVk4MVcvRGkyRG1wMHlFNzBYS0tDYzNCejZkWVdQZXA2UXUvZE1KRGh1QnV5?=
 =?utf-8?B?czA5UGZsRDZlMXpmTGtrMCt2VkliNjZnSTdiTGN1YlNVK0ZTb1N2THV4NjlY?=
 =?utf-8?B?WGVzbXFLM2NreS9tU2JlVzVVdjkycXhIakJYakJxaGRKKzhNMEVSZFo1eGVu?=
 =?utf-8?B?YTdCZWJ0SmJxcUJuRUxvdjdDaThzQmRtNU9OeGtaakVZNE96SU84RFFFUzdi?=
 =?utf-8?B?cHZnbS9Sd1ovaVEzZ2lubzIzcFpwRnAwaEQ0M0NIUENaT3pWSzROWkpQLzBz?=
 =?utf-8?B?QlVkRFpVcEZRbUlGQWZYdE04UmhTVEJBa0pid2VWbFlIL2YrTSswYkRhdU1K?=
 =?utf-8?Q?xk1IfXNyuwGd5BdGjVacXGmYNMMNi4iUCjzrV3v?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cc7881-c914-460c-29ec-08dd5227f1b8
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB5662.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 03:29:27.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8801


On 2025/2/20 2:22, Bjorn Helgaas wrote:
> On Wed, Feb 12, 2025 at 01:54:11PM +0800, Chen Wang wrote:
>> On 2025/2/12 12:25, Bjorn Helgaas wrote:
>> [......]
>>>> pcie_rc1 and pcie_rc2 share registers in cdns_pcie1_ctrl. By using
>>>> different "sophgo,core-id" values, they can distinguish and access
>>>> the registers they need in cdns_pcie1_ctrl.
>>> Where does cdns_pcie1_ctrl fit in this example?  Does that enclose
>>> both pcie_rc1 and pcie_rc2?
>> cdns_pcie1_ctrl is defined as a syscon node,  which contains registers
>> shared by pcie_rc1 and pcie_rc2. In the binding yaml file, I drew a diagram
>> to describe the relationship between them, copy here for your quick
>> reference:
>>
>> +                     +-- Core (Link0) <---> pcie_rc1  +-----------------+
>> +                     |                                |                 |
>> +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
>> +                     |                                |                 |
>> +                     +-- Core (Link1) <---> pcie_rc2  +-----------------+
>>
>> The following is an example with cdns_pcie1_ctrl added. For simplicity, I
>> deleted pcie_rc0.
> Looks good.  It would be nice if there were some naming similarity or
> comment or other hint to connect sophgo,core-id with the syscon node.
>
>> pcie_rc1: pcie@7062000000 {
>>      compatible = "sophgo,sg2042-pcie-host";
>>      ...... // host bride level properties
>>      linux,pci-domain = <1>;
>>      sophgo,core-id = <0>;
>>      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
>>      port {
>>          // port level properties
>>          vendor-id = <0x1f1c>;
>>          device-id = <0x2042>;
>>          num-lanes = <2>;
>>      };
>> };
>>
>> pcie_rc2: pcie@7062800000 {
>>      compatible = "sophgo,sg2042-pcie-host";
>>      ...... // host bride level properties
>>      linux,pci-domain = <2>;
>>      sophgo,core-id = <1>;
>>      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
>>      port {
>>          // port level properties
>>          vendor-id = <0x1f1c>;
>>          device-id = <0x2042>;
>>          num-lanes = <2>;
>>      }
>>
>> };
>>
>> cdns_pcie1_ctrl: syscon@7063800000 {
>>      compatible = "sophgo,sg2042-pcie-ctrl", "syscon";
>>      reg = <0x70 0x63800000 0x0 0x800000>;
>> };

Hi, Bjorn ,

I find dtb check will report error due to "port" is not a evaulated 
property for pcie host. Should we add a vendror specific property for this?

Or do you have any example for reference?

Thanks,

Chen



