Return-Path: <linux-pci+bounces-18826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF80C9F88DC
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 01:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1878F166271
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFB3EC4;
	Fri, 20 Dec 2024 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lSLZtvea"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B15C13B;
	Fri, 20 Dec 2024 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734653662; cv=fail; b=qk5gYhDwpdmdbSgM8jPg/dI7JSiugAaBGKkp2o2oES+gxL+ZEyuOmV78JCwJQXBajyig+OJTmrqL5o/7nJoMvq26yONu70KTwyfCgLLQnmiIALYUqoXgSgUiH6cF8moBhOOyCnBeUns9NpnbvvuF5QywHO4hwZo3969XwfBpmLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734653662; c=relaxed/simple;
	bh=EWpJBQvoeDDHLs6Z6ZPtRO3T7ezzCFCQxccoxh8uf/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KnC69RMXd/dSK6VLIRu3qTmR18XPsxglgvGz1WfReFkMOplzmxsZxn+kpHtgKMp3La/TFBJWc32BNNNyg4gXy3HL+WqsVx4ZaU3yr7X4yihzOKSHeWoG2ETAAdmWZaay2Oxkot1mZ56QgeHgCN+F5gKHLl80kW903lwJW1NUJcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lSLZtvea; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yV8H7So2oK13rLQJUbpp6juKgNyoJkDyXpRsglVc2CnkLoJb+DAEmkg4ZhrfNGNhj+4mCnX1KwiWV1yHMNIBVUvqcS3x7vazr3EKHBh2zBrPZmlpvbxqsOa1WfmZIcm/cLIpN191WpHlp2FuCgHx1KftIA5bNCDCRxo3LTjH6/DVpNJO3zLU3vQUoAQGaqTVB7dmxUEERpypwZFa+fZZkK6hduFXn69rsqtgv3K0mkf2ZlfBdYAPicn/Kb021xBBJeownaQLccw/YZ3qle4tuh3mZ+bz+FVEpxIWb5KaSiz/h1wPjb+LoS0VMELX7B6X5gnh+E3ChUlhvk9VjFxO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8n0mcnRzy+fXWW6m0KpefqvHjZWEm8JUaEvq6Kp+v3w=;
 b=el0NE7/Y0zjRrFtl36eZDgpiojpuDTWx/MSz37Z661W2K0iJNdzGmlFD6Cu3UaoduilqYdo9F2Vmg2+KljTLKTaSTP3bUNxdsxFNKNcY29S0xBr5I1o90ThK+Tif8Gd7G3R7grttUcZYuNcuheFSQaN2yYFZjq+3P+If7Gml9gXOrsOcrYgxjjplmJmCm1YaxWz+nF/9ifRwFXCgYUptimSmJ1D0M10C55+aadUCJlRje8/2wUyMLyaxHfrJoaoNk1ZVtvNOya1VF2jN1WbZrZHpcoRi2BIH157/f1Rdlay41Kve/gLv0ZfOsY/4bdGprm2m0j5H+v4VwIdtrQWO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n0mcnRzy+fXWW6m0KpefqvHjZWEm8JUaEvq6Kp+v3w=;
 b=lSLZtveadecsP8+qWGSW80R643YeInwjwaw5398OmKyQJHyHMsChC4sdy5f0NAiJIv+GCd4LymEWudNPZ5PQmguYrWURFjm8e4KSuZjI0naZ7pIWQECHh5EdH1zfhMVjihih1lXlLjniMN8aoO3WUrUxsG+YBFJ/NkQN3tKPFeozTCxce8hZX2Wos6EPqPiMRv4NGykx5GICnu17oIIsRUZJTlTRQjzRs8oKG3L7d3qzpoTslhov2Y/XfCEFjTQVMrSavBOKCadfQPFMJ0GyVndtvEjpOdunBnwAwa6uBnuc9Fws9LIfpCs0QS1cCpFgXjAsuxSEDo9BcmqAzUeCfw==
Received: from BMXPR01MB2663.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:34::20)
 by PN2PR01MB4170.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 00:14:10 +0000
Received: from BMXPR01MB2663.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e7cd:1010:6f38:29b1]) by BMXPR01MB2663.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e7cd:1010:6f38:29b1%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 00:14:10 +0000
Message-ID:
 <BMXPR01MB2663866236EF66DCB1F58C42FE072@BMXPR01MB2663.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 20 Dec 2024 08:14:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Chen Wang <unicornxw@gmail.com>,
 kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20241210173350.GA3222084@bhelgaas>
 <BM1PR01MB2116EB0657EA6E231AB75BD5FE062@BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM>
 <20241219121639.GA3977968-robh@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241219121639.GA3977968-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To BMXPR01MB2663.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:34::20)
X-Microsoft-Original-Message-ID:
 <d8b14cb6-ffb8-45f1-bbdd-b0176ccceead@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BMXPR01MB2663:EE_|PN2PR01MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 6806df43-a148-4256-89b9-08dd208b3a02
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|461199028|19110799003|6090799003|15080799006|7092599003|10035399004|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0luRDNjN1FwRVI3QkptVW0rKzgyZndVWGdzaDYxOVprcE42QzdRR29aVnF6?=
 =?utf-8?B?L0lFcVJFUHFNK2h3T29TMzAwRnBVYmo0ZlZvQ1p5Q28yL3lCOUhUNUxxcy85?=
 =?utf-8?B?Z1d1bGN3Y1NjUWlRTVNwdSs4NEljNGJ0SUQyNGxUdEYzbWhqcEtGU25rb2ZZ?=
 =?utf-8?B?azMya1lRWkdJdVRHY1pnclRtbVpJMXZaTi9KMDB2U3h4YkdNZkVJWmpQSHp6?=
 =?utf-8?B?aHBKclJWblpTYytHMUM1OHdudW5QYkw1ZHBUajVJakJoMm9zdUxFbFU4VHlM?=
 =?utf-8?B?SlB0YTF4dk12ejNDTXRWNHVNbVFLT3pncG1XZkdBdmhIbjVGZkNSN1ZPbWlj?=
 =?utf-8?B?dGNOQUpqM3dNTzROZTFCcGxHMm83L2ROZ1VMS2hGeHNJSTZEWkcxQTh3YTJF?=
 =?utf-8?B?am1JYXdSSHRxSlNQT1lZMFlib0tydFYvbnlveHh3TjZHeEhxYmk4bWJQb2w0?=
 =?utf-8?B?N29OLyszdFJDT3FHbWRNOTVXaXZ1SlNkZUNQNXdJVUxHVW5peGlxVWdEVkZm?=
 =?utf-8?B?c29lNzlPZVdLZHZYMXRMMU5GRUdMZUNsQjFPVUhWMEcyWGh4UWlaang0T3Vo?=
 =?utf-8?B?OEFtcmJ6b1lFTUc2Qk14cHJ5dUNCMnNWd2Z0K0ZhWm43L0xERys1blJUd3B3?=
 =?utf-8?B?dzZJd0lGTG9OMFVDSHRublBSdjNWTnpjQ3NZWVVQV2FLWEg0QW9wcG1VU0VE?=
 =?utf-8?B?Y0JPUXN2QndvM2lsZkdqYTFxak84NWM4VkJ0V01hUW9JTjNyU1RzWVdNYkNV?=
 =?utf-8?B?MTlva2loMmhEby9OQXNGTDF4TGRLbjRiK2sxQ0JTK2dnZVd0bTExa3JHdGdP?=
 =?utf-8?B?WGxxOUZTQzhYS1hkRS9Qb3QrNUVhUTk5NW1XRDYvZlIvWVI3QzlNMk11TDdp?=
 =?utf-8?B?dVhtUzBrVmRMVSs3cjlRb09wNkxOa29ldEJnNFAzL21IMHB1UW9rUjVDSS90?=
 =?utf-8?B?VXZKMWsrS3RKZUZJSk5nOGxzY0pXQ3RBUWNCc3NYU3pjZXRhSStXaFFLMlkw?=
 =?utf-8?B?cVZSUEJGZkRaZmFBc0Z1Q2lCUStFQTJxQ0NxMTJhRGVvYmNoSFpiaWhNN3FT?=
 =?utf-8?B?QWtTMjhucUJwZDVHNGZpQmpVd3JNeTQvOGEySWVMUXR1R2VPZjg2WktXTTdi?=
 =?utf-8?B?Rk15c0VCWmFpYmtITzMxTk9RdmdjdWFVNHllcjNOT1FFSjdzTzgvRlRpdHFp?=
 =?utf-8?B?WnpBOEVudThtdmFLUkVrWFMwRHBXVFc1aFZtczVyYmVQT0JJbmx5Umw0eHhm?=
 =?utf-8?B?ODBVN1RLZGJrZnhYK3V0djM4bEF4WVNpaU85VE0zTWg4WmpFeVpWNVNpMkc5?=
 =?utf-8?B?QlZBemc5ejBlOGR6SWhZMGNXZk1EdmFkSUp5RlNEZHRmSVRndCtWYUVMVDMx?=
 =?utf-8?B?bHV0V0VZWS93NkozNlA1UlZvVVpsTExKZ2xTTm1PTFJIVERYdWR0aVh6OXVL?=
 =?utf-8?B?ZDRwUWZlZmN5OUlSOHl1UUVzUEo3VDI1Sm1BaDhFMXZ6bmg2dVpNQmUxMWMy?=
 =?utf-8?B?MUVOQVlKQVNvOWVCNzFwSDB0MzNKNTc5NUFDS0l6Rk9RNHVaaXY0bjBpRVUz?=
 =?utf-8?Q?RwQ/B5xGUHNvQsiduqdyUzD3g=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UytQM1llRnozNGR1ckl1QXdNWnJEdHFrVDlsQnZmdi9BVE93UTdzTVNCM1lU?=
 =?utf-8?B?VWIrVkhOem1WTVgyb1ZiZUZnZUNqaFU2bEVwQVpRbWYva1R6V2NlYisrWXFr?=
 =?utf-8?B?TWxDb0JDbDJwcUQzckFlakQxdXNLSC9MSlRZMEFXTHBSdWN2M2VDaEpodlk1?=
 =?utf-8?B?RDN3eUMzWGttSldGOUFEOERERHRaaDllZDNIRFJ1RXVWcHd3Si9tSU8zOEJo?=
 =?utf-8?B?YkFETjhocEczUnh2VnAwd0FCelN0Z2NneUdtOTM4NzI5RU9uYWtWdkV3MUdX?=
 =?utf-8?B?NW1SdlBEOFhVWGo0RERBeUJORFBtOGxxQlBmaDBONVR1WStXTXBEd3FxSGdF?=
 =?utf-8?B?ZHNZRnA4cFR3NFl5R0prVERxUXFnZk9zcDI5TkJZVjhFekM3R0w2S2RjRGp1?=
 =?utf-8?B?eHRqVXVJbjVFTysrMGJHcVZJQkl5M2RKQzY2RW9mbTJhd1JaRzFJeUxmYUd2?=
 =?utf-8?B?UzhQd2F2dk9LMEdOR0tJU01jcDZuekF3YmxubmhNdUdUSmJLOUd3QWhHNHNk?=
 =?utf-8?B?bFUrVXR6ZVdKYzZDZFE5N253RGZnYjZ6ZzROc2RDMjhmRkowbm1WNTdHMGI4?=
 =?utf-8?B?QS92S1VvUzh2SUhVNlp2b0szT3k5aFBPK1F0dlQ1cVhmTGhKUXN1a3Z6L0tW?=
 =?utf-8?B?MFY3dlQzd1F6dW80UFpPWEJYUnVXaWZuaUFDU0g5ZzVwNnVMYzBWNWpjNTZM?=
 =?utf-8?B?cEo3QnNNTnJ4eXEzLzdRVlNEQmhVVXJENzgva0pxaEZLbGZORUdXU1dUb2x1?=
 =?utf-8?B?MjZhVFV6bGF6aXNHSEUwcmVkR001UE1TaWVOWStiYzhoK2NMUnVDdDNTelZl?=
 =?utf-8?B?dEVtRm8vZUp0RWRTQWkzZkdDNFQ5UzE0bkZOUXQxWWltYk1QU3R1VnMxbDJ0?=
 =?utf-8?B?ajkwc2RuajRWZ3VYN1F0VnNlanNQZ1Qwei9yMVJSV1FHTjZlWVBuMFZ5ekFZ?=
 =?utf-8?B?ellZN0dyVDc4QXNHNVlWNTdmaDJYK2FtVlQrM1p2MS93eFZYY29ueitOeVhW?=
 =?utf-8?B?eTk3V2JPc2lJV1dDZjU3eXRrSGNzQit2WGNlWUE1dm5GTHkzcUt3Nzg3dUNO?=
 =?utf-8?B?S0RkRXAxa2RidFRlMHdWMmJTWEgzQnZ6cmlHeXV0MUptOWF4UmNXVFUzSGFh?=
 =?utf-8?B?MVIyaVJldHc1cXYrNjJtRzhsZURIenQ0V1lNc0RKaFJkMnhQM0JqblI1SHBD?=
 =?utf-8?B?dDZmQ3h4RFlQOHE3a2ZlS0EwZHNhd2RQOTZpazBSa0lxNHg3NUFCYnNVWFMx?=
 =?utf-8?B?ayt0V3FmOXR2WGFQcUpkb0U3VGJuam94ZExjM2RWR1VRMUY0QlJBaEFyRmIx?=
 =?utf-8?B?ZzNOVHBjbzhpcXhUY2QySXNYTk4yeHBORTJpNnhYYlQwRi9TSTd3YVZyZGFE?=
 =?utf-8?B?UG9PaW53SGZ5ZzU1NXcwcTlyelBEb3l1UFFxM1Y3bDg2VVBtYjBQUmovS0Vv?=
 =?utf-8?B?RnlUaTdrc1h2WUtrRmRCSzJrandWREw1N3QySEgvOU5ZdjlDSmtTOWwxSEdl?=
 =?utf-8?B?UGNXUVZwdWlDRGx3VTE5NXZqSjYwK0libG0rc0J1djBqQW1CNXRlRlZTNDk5?=
 =?utf-8?B?VzZZeHBBSVgycDl1R1BZM0RuS21WUkJDN3pkckIzMSt4UVRtN2IvaUlVLzdx?=
 =?utf-8?B?MC8yOGNNL2hDUzROSU1vWmVLUThrQUYxZk5TUGZ5QXB4T01qS0xabUZBVjZn?=
 =?utf-8?Q?vvTPVAE0CSep6pVyQrQM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6806df43-a148-4256-89b9-08dd208b3a02
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB2663.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 00:14:10.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4170


On 2024/12/19 20:16, Rob Herring wrote:
> On Thu, Dec 19, 2024 at 10:34:50AM +0800, Chen Wang wrote:
>> hello ~
>>
>> On 2024/12/11 1:33, Bjorn Helgaas wrote:
>>> On Mon, Dec 09, 2024 at 03:19:38PM +0800, Chen Wang wrote:
>>>> Add binding for Sophgo SG2042 PCIe host controller.
>>>> +  sophgo,pcie-port:
>> [......]
>>>> +      The Cadence IP has two modes of operation, selected by a strap pin.
>>>> +
>>>> +      In the single-link mode, the Cadence PCIe core instance associated
>>>> +      with Link0 is connected to all the lanes and the Cadence PCIe core
>>>> +      instance associated with Link1 is inactive.
>>>> +
>>>> +      In the dual-link mode, the Cadence PCIe core instance associated
>>>> +      with Link0 is connected to the lower half of the lanes and the
>>>> +      Cadence PCIe core instance associated with Link1 is connected to
>>>> +      the upper half of the lanes.
>>> I assume this means there are two separate Root Ports, one for Link0
>>> and a second for Link1?
>>>
>>>> +      SG2042 contains 2 Cadence IPs and configures the Cores as below:
>>>> +
>>>> +                     +-- Core(Link0) <---> pcie_rc0   +-----------------+
>>>> +                     |                                |                 |
>>>> +      Cadence IP 1 --+                                | cdns_pcie0_ctrl |
>>>> +                     |                                |                 |
>>>> +                     +-- Core(Link1) <---> disabled   +-----------------+
>>>> +
>>>> +                     +-- Core(Link0) <---> pcie_rc1   +-----------------+
>>>> +                     |                                |                 |
>>>> +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
>>>> +                     |                                |                 |
>>>> +                     +-- Core(Link1) <---> pcie_rc2   +-----------------+
>>>> +
>>>> +      pcie_rcX is pcie node ("sophgo,sg2042-pcie-host") defined in DTS.
>>>> +      cdns_pcie0_ctrl is syscon node ("sophgo,sg2042-pcie-ctrl") defined in DTS
>>>> +
>>>> +      cdns_pcieX_ctrl contains some registers shared by pcie_rcX, even two
>>>> +      RC(Link)s may share different bits of the same register. For example,
>>>> +      cdns_pcie1_ctrl contains registers shared by link0 & link1 for Cadence IP 2.
>>> An RC doesn't have a Link.  A Root Port does.
>>>
>>>> +      "sophgo,pcie-port" is defined to flag which core(link) the rc maps to, with
>>>> +      this we can know what registers(bits) we should use.
>>>> +
>>>> +  sophgo,syscon-pcie-ctrl:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description:
>>>> +      Phandle to the PCIe System Controller DT node. It's required to
>>>> +      access some MSI operation registers shared by PCIe RCs.
>>> I think this probably means "shared by PCIe Root Ports", not RCs.
>>> It's unlikely that this hardware has multiple Root Complexes.
>> hi, Bjorn,
>>
>> I just double confirmed with sophgo engineers, they told me that the actual
>> PCIe design is that there is only one root port under a host bridge. I am
>> sorry that my original description and diagram may not make this clear, so
>> please allow me to introduce this historical background in detail again.
>> Please read it patiently :):
>>
>> The IP provided by Cadence contains two independent cores (called "links"
>> according to the terminology of their manual, the first one is called link0
>> and the second one is called link1). Each core corresponds to a host bridge,
>> and each host bridge has only one root port, and their configuration
>> registers are completely independent. That is to say，one cadence IP
>> encapsulates two independent host bridges. SG2042 integrates two Cadence
>> IPs, so there can actually be up to four host bridges.
>>
>>
>> Taking a Cadence IP as an example, the two host bridges can be connected to
>> different lanes through configuration, which has been described in the
>> original message. At present, the configuration of SG2042 is to let core0
>> (link0) in the first ip occupy all lanes in the ip, and let core0 (link0)
>> and core1 (link1) in the second ip each use half of the lanes in the ip. So
>> in the end we only use 3 cores, that's why 3 host bridge nodes are
>> configured in dts.
>>
>>
>> Because the configurations of these links are independent, the story ends
>> here, but unfortunately, sophgo engineers defined some new register files to
>> add support for their msi controller inside pcie. The problem is they did
>> not separate these register files according to link0 and link1. These new
>> register files are "cdns_pcie0_ctrl" / "cdns_pcie1_ctrl" in the original
>> picture and dts, where the register of "cdns_pcie0_ctrl" is shared by link0
>> and link1 of the first ip, and "cdns_pcie1_ctrl" is shared by link0 and
>> link1 of the second ip. According to my new description, "cdns_pcieX_ctrl"
>> is not shared by root ports, they are shared by host bridge/rc.
>>
>>
>> Because the register design of "cdns_pcieX_ctrl" is not strictly segmented
>> according to link0 and link1, in pcie host bridge driver coding we must know
>> whether the host bridge corresponds to link0 or link1 in the ip, so the
>> "sophgo,link-id" attribute is introduced.
>>
>>
>> Now I think it is not appropriate to change it to "sophgo,pcie-port". The
>> reason is that as mentioned above, there is only one root port under each
>> host bridge in the cadence ip. Link0 and link1 are actually used to
>> distinguish the two host bridges in one ip.
>>
>> So I suggest to keep the original "sophgo,link-id" and with the prefix
>> because the introduction of this attribute is indeed caused by the private
>> design of sophgo.
>>
>> Any other good idea please feel free let me know.
>>
>> Thansk,
>>
>> Chen
>>
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - reg-names
>>>> +  - vendor-id
>>>> +  - device-id
>>>> +  - sophgo,syscon-pcie-ctrl
>>>> +  - sophgo,pcie-port
>>> It looks like vendor-id and device-id apply to PCI devices, i.e.,
>>> things that will show up in lspci, I assume Root Ports in this case.
>>> Can we make this explicit in the DT, e.g., something like this?
>>>
>>>     pcie@62000000 {
>>>       compatible = "sophgo,sg2042-pcie-host";
>>>       port0: pci@0,0 {
>>>         vendor-id = <0x1f1c>;
>>>         device-id = <0x2042>;
>>>       };
>> As I mentioned above, there is actually only one root port under a host
>> bridge, so I think it is unnecessary to introduce the port subnode.
> It doesn't matter how many RPs there are. What matters is what are the
> properties associated with.
>
>> In addition, I found that it is also allowed to directly add the vendor-id
>> and device-id properties directly under the host bridge, see https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-host-bridge.yaml
>> And refer to the dts for those products using cadence ip:
>> arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> It's allowed because we are stuck things with the wrong way. That
> doesn't mean we should continue to do so.
>
>> In this way, when executing lspci, the vendor id and device id will appear
>> in the line corresponding to the pci brdge device.
> That's the RP though, isn't it?
>
> There is one difference in location though. If the properties are in the
> RP, then they should be handled by the PCI core and override what's read
> from the RP registers. If the properties are in the host bridge node,
> then the host bridge driver sets the values in some host bridge specific
> registers (or has a way to make read-only regs writeable) which get
> reflected in the RP registers. So perhaps in the host bridge is the
> correct place.

Yes, cadence host brdige will handle the regiser setting for these ids, 
see function cdns_pcie_host_setup() in 
drivers/pci/controller/cadence/pcie-cadence-host.c.

So for this case, in the host bridge is the correct place.

Thanks,

Chen

>
> Rob

