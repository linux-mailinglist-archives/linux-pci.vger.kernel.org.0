Return-Path: <linux-pci+bounces-19365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADACA03422
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 01:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D483F3A38C0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 00:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07670CA4E;
	Tue,  7 Jan 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="n7oHhOjD"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010010.outbound.protection.outlook.com [52.103.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB14207A;
	Tue,  7 Jan 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736210647; cv=fail; b=gtJsi0D2uFsyUoJZgxWqxCRmkX/wZLjw2UgOo3qAasn8yLqvlR8QPCY7jXW0y8jMAH0ywOfCJYVmDD5sz75hBe1UHOvqbsXNdtpznaiD4ajSDxDvX17+h2+TPZ1/sdRvIlRzpDxSb1nTNaXMa6DYdC8TKR3ci6y6f7fPPb89U6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736210647; c=relaxed/simple;
	bh=Fv1n8K0cggnfOi7VM8z4a40mwFRuFVqinmWAkO5jiRw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+jhWrwjNR5pd5KwIPOPPpRu+Z+18maei/bOREhBinykAuWIpncBPkjsdVQOQagxE7cyilyLmeWHASersp2mvIFn0nZSTdhReuIF0EAkeF9QIR+PJ8DaWupv7NK4rlWIMW1xl7swqeeSrdQBp8u4ltpzJr8e1umX+RYGGTSmGuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=n7oHhOjD; arc=fail smtp.client-ip=52.103.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIWcl6jMjDc4m66OwCgAgTS2dWtLYvzpb35gDFPhMJiOxAhwx6mW9BPvtq9xlH+ESnTAxJyij/HKpFXARU5NG34rcUGrKzvOPFVOTqMYLgzi4hq9LhX73+paDLu9cfihJ4TDBNnfgfoFZ4BaO4O5CeksO6ab7RfZMMAcoDYiS55r48bDge+m5WnsfoPIpiLIooCXSbwGLjbkvbXegE1EM0zCbvCQABecL9pSWt9O/aVV/rBmA6D6K/axfl7xX47qfLdTtQoxAQsjNgeok3+NLyc7euibsyZ/skMDQFeR3bctssOJLUpMc9/Cc70OjnKXNODWHtfq6hcnBxqd7O6PIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K3CrMOtu+monAAo3ZA+65Mdcdyw7MN2KAbib/o/h+A=;
 b=FW9XMX5HdMhqWDylhGiD9k/bJInCqrMFTTd7Xt6vQNT8+5c7rnChfdy3ft2zZvDfFvAZbZ7g5d9zvMcpEPqiK8t7xNYnXjnaR1riJ2kmrLJx57yYdeNnl2ngr2gmJQudyVBNLSO3fO07vthguoVyeJjwCrqHU/wxijduYrggwEY4WoglzeAAi7A/CSlM2x35ZWWSMKFneBxFf0WeLtyfR18/2uTjeO5DIVVrE4my75yJGIBzF157ueYSTXF8gLXzhhI0QLbNMaoZNNlrB8l4YD9cdisz9GbSc374bo75JRKvAsAxMMqbOyzfVSR2xt/29jg7L5WWjfRVeGTkhjhHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K3CrMOtu+monAAo3ZA+65Mdcdyw7MN2KAbib/o/h+A=;
 b=n7oHhOjDBauhyCTk+LU097LrdF9LBObhyLN/TCb63auyouG9Ud9NZBWNERq5QJdcHafkaXvPJxLzCi5f+8sRDBtlXtMKCFa0WMb8JJCJgAIJdg2ptL5fCQ15r4UH9Li6KXZwQmCbHonI/4102wzmx0EzzKFx6hdEEMioWmfu2TAFul89CBahn8VGPXmSMiY9R9ZmIcqf9Xwd5Xddnu+HiATD2ebW29b3TBiU2OkIeJeqx73Li0YK+Fn24uNDdU8owZ6TN/VjT76ZXGvKshDv44MoJsVykHoIyh8yngsPDBlJMte4TQEUcwX7T2eMKcKDOew0c/5Tey1o/OvSyeMB2g==
Received: from PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fb::11)
 by MA0PR01MB8945.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 00:43:56 +0000
Received: from PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc57:de35:cc59:cc4f]) by PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc57:de35:cc59:cc4f%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 00:43:56 +0000
Message-ID:
 <PN2PR01MB952383AEE840F23EF29AE73AFE112@PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 7 Jan 2025 08:43:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
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
References: <20250107001839.GA142126@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250107001839.GA142126@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::19) To PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:fb::11)
X-Microsoft-Original-Message-ID:
 <8d267fa2-ecb3-4885-ad71-95a841582d79@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PR01MB9523:EE_|MA0PR01MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: bef0c19d-f426-41c0-5cc6-08dd2eb45df0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|7092599003|15080799006|8060799006|5072599009|6090799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sitldm5ZZTROOThzQkh5TzNzVE1XWHhBNFpVNzVGWmg0NE9PRG5tSXkxVGNW?=
 =?utf-8?B?TlRMOTdOOEx6eGVlbkxEL2RDSjkxc2lWc1kzVm9EdFJ4YUhmeVRiN1hpZEdT?=
 =?utf-8?B?Q2EweW5iTVVlNWNEYXFoaitsQy9NL0xGNXJJeXZNWDN0bEhETEhVWWJOOGE2?=
 =?utf-8?B?bGRpOEFNSTBnVFFya2EyNHJ5SGZZMjFWTXRoYTNrQ1cwNE9YYUVSajc0TTA4?=
 =?utf-8?B?MXNONXpqL0NIdHBrQXVYZnpNWmU4MlhPUll2ZWRtRGk1M3hDYytCSGUya0pV?=
 =?utf-8?B?UmhDSDRhZFNlT1RDWlhKRTBackhxb2dmRDNnU1RUOWNKN0J2TStkSmRMUFBm?=
 =?utf-8?B?MlNsc3NqTkM1VHlLV0ZTeWNLMkxaZ1NjbHZGQ09vYlRTLzFnUFM5Qi9ld0dI?=
 =?utf-8?B?ZXpEdmE4SW9JSURUWjJOaWh4WkVoWlBRKzJPc25UMkQ2RGF4dkRLNVVPd25M?=
 =?utf-8?B?c2FweHhRL0VHSG1QRGhDb1pva3BtOGY5UHZMOWU3R2xzR1dEbFFqNmt3NXVm?=
 =?utf-8?B?RVJmWXM5TzIwRDU4c2dLK0J1Z1ArWHVWUHZIcXlsZ1pqYkNRZ0d5dWYyS1Qr?=
 =?utf-8?B?RWJTNHJ3TFdyMzNJV1kxV0gzbWZ2N0RIQWEraVh2N0V0T3gzTHFzK0NWNk51?=
 =?utf-8?B?ZU1oY1VyQkoyQVpRYmJEcE1ycTB2RGdZb3pPb2x0T0RhQ1dIVHRLVk5ZK1R5?=
 =?utf-8?B?Nzh4ZUZ3MnNvclJJaUlNODdyS2JHUWJhVExtbWZSSnpVem9Id2dEczNhUjBI?=
 =?utf-8?B?YzRBTm40SVp2YUVUZWtqb2FmS0pFVEVDR0RnVlRvaVFvVm5NNTVQRmVwemV2?=
 =?utf-8?B?Q1QvTnBQWU1kV2lCbXVmdWFJWHNDbzVjWjA0ZWEwQ3dBVUV2UU5XYXFLc2Z0?=
 =?utf-8?B?QXdLQTJTQ0drbE5MblgweFpxUWRlbjdETWM5eVdscm80dGF4a2dZays0QU42?=
 =?utf-8?B?dzI2VWpOQ3UxdnQ4c2tuS1l1eU5wN1prcTRjLzNxMjBsRnBwdXJ0dE5xT3lY?=
 =?utf-8?B?cHlqRUR1bWpFUzYzTmVsVjhBMUUwMnZDd2FkZnF1N3NUV0E5SmhYcmZZVDkx?=
 =?utf-8?B?U0kzcWg1L0NUcjZDd0pWVWdoM3Z3S0ppeXRKYVAzZEc5bDJaRzF1czZ4aUQ2?=
 =?utf-8?B?RE9GbFZnQVRXdXluQjFJMWF2Y3FrYWMvQ21pNGprbFBIUG95aDJ4aGFhUEpF?=
 =?utf-8?B?Z2FpamtpNE5MOGpyRVFZeXlXQXA1dWJ3RGQ2K2hydHVBNUpwOU80ck9mSUli?=
 =?utf-8?B?bmhGazRLVWM1cWh0bzhnQXBXVE9tY0l0L0tIdmxBUVo2OEdnbjVNcGV0MGdy?=
 =?utf-8?B?K1RUQnczSjBYcjZkV0k5TmYvenlkOS9yZkVja2x1UFRuUU5FT3hOdTI3QjFK?=
 =?utf-8?B?aFFwNzRmaTJIdldCZ1lwN2RIU0ZlUDAvK1l1QVpoZUtGeDNrZnpydUhYUkky?=
 =?utf-8?B?dnNqVXdpRUJwU2FZbDlicm8rb0RJcHRRM3ZOM1Q4WUgyUEpCbmV6VHB4bWJD?=
 =?utf-8?Q?bXdKhw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnJKdmJYNFRzU0d6R0tBd2lYRTZ4L2RmRTVZdzUrb3pORjh5Q0NJWVUyS2xh?=
 =?utf-8?B?bW00d1NjaFpIS0pLaGJGb3VEMVp4bG5aQ2pydVZZa1dBUndqMCtJdksxbktN?=
 =?utf-8?B?R0JaNklpdVFmSnRYYlkyV1lTZk5iN1V4eEZFODEzMTVhL3lQblEvbWovckEr?=
 =?utf-8?B?S1pUK0FLeUpnaWZLVEhWS3ZUaTk2cTBEeG9DVmRCVnNMNXlvcWhDeHBLbDVK?=
 =?utf-8?B?MS9oRXMwbVBHQXFCWldWdU45S3REdS9VampNTndGTEFISEUyaVV0RHU1R1JC?=
 =?utf-8?B?S1VUejBBOHByaEhLekkxZE9BRUUvSHdIRCswWHVDL2p1K2Z0Z2J5QnJaellO?=
 =?utf-8?B?b1JnS256ZVpuUXMzZjluRlVQaktGb1NKVEI1emlGQXNPYkxKazZvTDJCcEh0?=
 =?utf-8?B?ZGIvRGJNT0VpREhLanFDaVZlWTJwSW1JYVJ5Q09oRlNQWVp6NFNnRzlUYmdU?=
 =?utf-8?B?dXV4SlVEbVZ6b2dhSnYzcklhRVZaVVRORXVXb1RkUmRGbzdEUGlrd3FOSWNJ?=
 =?utf-8?B?OHBUZC9yMC9Cdmt3WWFGendmVUZVU1MvVGRuV01ZL2h1bmppY3I2QWVnMmk2?=
 =?utf-8?B?Q0xiN01TdGJyYUE2QU1sdlpmai9YaU9KdnFQYUFNelZOOTVoL29wZEZtbE9Y?=
 =?utf-8?B?a2RHb25scUNVTWRRSEtTcW1iS3dxUm9yUHpjaG1JU2xVMVI0RTdiOHcwdk5H?=
 =?utf-8?B?Q0l0akpEdEx3RVhDUFFHV1lrb2lkOU41VWh2OEtrQVRVZnpVcEdwNk1WTGpE?=
 =?utf-8?B?R1RtNFZNU1Jyd1dOYUNLOWlxOHZXY1RmdGllcXBCdlk5Q0V0SEZ3UXBGNWky?=
 =?utf-8?B?VFlncmhINUtXdWNJSGp4R0oyNndjVXFwakdTQy9TK2hkODJFbS9LdWpSM1pa?=
 =?utf-8?B?K1JKalJWVElhcmgzYnlHeUJGS2lCR0dUdDVqMi9Ba2FqVXMvTFRHS3ZvSDZ1?=
 =?utf-8?B?cjhDNlRLSS9mVXdOZUxRelZyZEpidjZ2OFI0M1JnajlzamttMTAvb2NCU3Fq?=
 =?utf-8?B?RWY3SVRYOUhRYnE2VUVQQlk0b0ZNdVpvK20rWjN0VURLN3NXQ2h6QnZQTlpK?=
 =?utf-8?B?MGpsWE8rZWkwWDliamZ3eHJJN21PMnRjYmlIUzk5aGRxdzZMZjh6UGNWK003?=
 =?utf-8?B?b2VGWDFhTG9vVndjajN1WjZxTUV0OURVT2F3UzN0a1dFWlZtQXhlY3d3OU02?=
 =?utf-8?B?SGxIQmFWc2RneWZOVEFuNytQb0FHem1qWnZhRjQ2UnUwMEVBc3hLRlBOclpD?=
 =?utf-8?B?Z1cwZGk4UXZKQzVRQ0RBTm5nSUtaTnlqV2pwUkZoMUVvd0NZMXpxYkxRUzNE?=
 =?utf-8?B?d1RkdEs3M1hSZkNLU0JnTGFzRm1GTS9IaUlaemp0K0MySGU4bDE5QWM4Zlgx?=
 =?utf-8?B?WVM1ZjJKZVhDMWoxUVdLSUdLd0VXdTBGeGNaYWhGV21NNVRsREZSY0wvZEw5?=
 =?utf-8?B?TlNrMjQ2d1dFRUxJRENzUkhYaWdnbGJMZmVTdnU0UVpoT25jRU16WksrNXl6?=
 =?utf-8?B?MGRJTnR5YnZQanpqeE1VOVJHWTNhUG5hbzcvU25HV3NjUWNSSGJ3dmtoYlZV?=
 =?utf-8?B?WkpDMlRic3lHVXpNSjdGMmozWkZPdXNINThzQnAyK21HWWUxYlNVaDhVRStl?=
 =?utf-8?B?cWRMZVJZdjdlYWdxb1IwNlBtak12YmFvUi9yZTNrNlkxbzBlRU5GSUR1RFZF?=
 =?utf-8?B?OXIxNFZQdWdzay9CNXFRV282MlYvMHlaNWthOS9OYmNERFdodUtHQnZzSHU5?=
 =?utf-8?Q?AGGlURYNv1WG3c7UEAglyhNxXmeakTyZqM3IkBU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef0c19d-f426-41c0-5cc6-08dd2eb45df0
X-MS-Exchange-CrossTenant-AuthSource: PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 00:43:56.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8945


On 2025/1/7 8:18, Bjorn Helgaas wrote:
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
> Host bridges are logically separate PCI hierarchies, so these three
> host bridges could be in three separate PCI domains, and each one
> could use buses 00-ff.  Each one contains a single Root Port, so
> enumerating could look like this:
>
>    0000:00:00.0 Root Port to [bus 01-ff]
>    0001:00:00.0 Root Port to [bus 01-ff]
>    0002:00:00.0 Root Port to [bus 01-ff]
>
> Does that match with your understanding?

Yes, that match my understanding.


