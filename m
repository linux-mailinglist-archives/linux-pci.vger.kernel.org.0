Return-Path: <linux-pci+bounces-15515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC59B466F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 11:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2CB283BFF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 10:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B02C204034;
	Tue, 29 Oct 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="ccSS1Vif"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC71DE3C5;
	Tue, 29 Oct 2024 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196614; cv=fail; b=BzaUu3GUJqYjxbLUs1YXFXYdUbC+8MozygBm7H5IJElOnpj+C8gBVXlDNXV16vS8znbzEmGjj7Am4pGPL40JhmnJkEM80vmQ/Ugscdfk8NMZ91fM8CQl7xahtxX6nrB5Fx5sG/DSjy4gNkMwEuRdUJ13hkCCUsfG6+eOLTzvr8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196614; c=relaxed/simple;
	bh=/X/ISPTUkIRxyFblrHLN6Srtm3yuj05Zy9AnChWMhxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AZ7NLff85Ajt4yaAczHTY2zThdur/0bhz+TctXU8Gt2+ws/Ig7JTQkh5fqRe/y04GYc0UKpCFSucDK35M0xClXKujiIR/jSQdpDX8guLtR3PCQRdj2ex4ReM/V7LqOqVzTmZ8NBUkqIpaYY4HpPsWZLOAa61yhqotW9CteJVqhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=ccSS1Vif; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBGXfq5K0fPN1sISz7s1GX4qsILwUDMGfIaXo7cnEFNhZ61w/EE97XWwc+Hg830uN6U3Zc13+uxo4NFbtIGSkY8Ckc1sEOLXRhN9734e4k7mlVQz5GXbOEGeekRO2zVW0SPhh87aU84SOj5eROgBZetWfQJuh5ipGatRLtaE7Bx/dlQXX9s26oP7jdGQE4k+VeyK5Dqa3lKxCa5TLKmbGhUR7D5mDr7aktwRfwWDggWLrCRgbHSxzRAQF8mR/Rbv2mmCz6ohb7mOsxJ4nxvttroVgJTcFiuZghLWQJwxGPUXrASU+36qYnzVogF2XrIc0ne3hrRNqANzSYuvK1AmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOh05M0Yp8bB2u5TCUO4rLYagzyGlpzmHBGq43JKNB8=;
 b=fms+E9ixpHJFqCjCNmTgNssQLcPaiVvS1y+tk4GQ5y03eynZFWZ5VskazppQ5a6WDoxO08rFugzyXiGUrkHmz/IY5/8MMaJeMIRa11QwxQ1Nf5wBySCIGeJ4cEov4Eh1lBKxrJe3dRk49yIr707N0sfNxo815lAfS7m2Tz9c5OCzuTizLLGNCFEiIViyDMLWQStmnrmKtH3qwFIJ1VTmv5Io1CNx/2oYqi6Tul7whwJcp5n7BCe5ktEeFE8iN1SQx7uFjTKycmJ09ATbZsRIqnlEbRsD/18ZENj7njBLwASBTOrMKhLPjPCil3Vo89Dqq33cESWNGdmEVGPBHITczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOh05M0Yp8bB2u5TCUO4rLYagzyGlpzmHBGq43JKNB8=;
 b=ccSS1VifCup5rg+72FyyEYqNq81F42vehicYwcUQO2fiGbJSr8t4XckVDRRwtXbLqKI29lD1ERYAN8vMbct5gMA8CQlsDT6mCifzjIMOqfueb9eN/FEjYWpWLgiysOhF9Blxv6DxWkWKPntt0gDg/0cnKJ0hX6TUKYWwCfZLfUS89+tsqGm9TTr7iENY8RY2QjdbNfbO4QK0azXoLjp3VJTJiH1IRUf2wP/HI+uhdRu4KaodIhYNamDASqePpa2Fz8oXpHOzskrtA9PmNN9/12bJwrNKQN2ylXI7ZB8CAktPnwpItuc+iHivS7xd8t87AHMq+4VdejILVSZp1hPArg==
Received: from AS9PR06CA0639.eurprd06.prod.outlook.com (2603:10a6:20b:46f::26)
 by PAXPR10MB5590.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:242::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.11; Tue, 29 Oct
 2024 10:10:07 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:46f:cafe::d8) by AS9PR06CA0639.outlook.office365.com
 (2603:10a6:20b:46f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Tue, 29 Oct 2024 10:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 10:10:05 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Oct
 2024 11:09:54 +0100
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2001.de.bosch.com
 (10.139.217.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Oct
 2024 11:09:53 +0100
Message-ID: <6769b70c-19d9-4e20-85a6-96b55c83a45b@de.bosch.com>
Date: Tue, 29 Oct 2024 11:08:37 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
To: Danilo Krummrich <dakr@kernel.org>
CC: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <bhelgaas@google.com>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
	<tmgross@umich.edu>, <a.hindborg@samsung.com>, <aliceryhl@google.com>,
	<airlied@gmail.com>, <fujita.tomonori@gmail.com>, <lina@asahilina.net>,
	<pstanner@redhat.com>, <ajanulgu@redhat.com>, <lyude@redhat.com>,
	<robh@kernel.org>, <daniel.almeida@collabora.com>, <saravanak@google.com>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <42a5af26-8b86-45ce-8432-d7980a185bde@de.bosch.com> <Zx9lFG1XKnC_WaG0@pollux>
 <fd9f5a0e-b2d4-4b72-9f34-9d8fcc74c00c@de.bosch.com> <ZyCh4_hcr6qJJ8jw@pollux>
 <8d72e37e-9e27-4857-b0eb-0b1e98cc5610@de.bosch.com> <ZyCvyrb5jsY1O4uX@pollux>
 <ZyCxLLE0Wzem0mzi@pollux>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <ZyCxLLE0Wzem0mzi@pollux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|PAXPR10MB5590:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f04b27-2acb-43cc-f065-08dcf801dca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU1LOFVsR1dWZGhtNGlhUkVFaW5ld1ZWSWQxbCt2aGozYXhSRUtiQmhkOUlG?=
 =?utf-8?B?MVRSalhVSWJOYk9NMU91UzkwdlRTVVZRS3JvZE9WYjJUQXpaMWhoMTdJQWUw?=
 =?utf-8?B?TWRuaStNNUh0TEZSc1hOSHdaUnZXbmxTVmZlRS9BQzFiaWhoTVlYQlhENm1S?=
 =?utf-8?B?V1h1V1FqZGRjdXRLbUJaT2RQWEZFL3hVU1ZDbmJzaHRpSnNpbjVid2MxUDRM?=
 =?utf-8?B?Y3Fud3VlV2dvb0dJT2pnV01JVXhGUUl3dHlvYkJuMFRrRmZRempXMTNmVkFI?=
 =?utf-8?B?SUl5cTRPZjVOMXpPSVNrNGJCMWR6NWtNaVBVZ1JxbElkbUZHcmg3RVFmd0RL?=
 =?utf-8?B?UDk0MFAzWkVCb0pBUWdpNkd5S0JqUlRWT0tzSlY0dXN6VzJBc3FMMm83RWJM?=
 =?utf-8?B?ZHVFV05LTWpjZ1NnN2ZVY2h2aXZPanRKTncyck5kYmZNa3BXczBrY3RISFRj?=
 =?utf-8?B?UkpEbXk1Sjc0Vk9TTkdVMHd2b2xSWjloV2psYlJQUjkzanRmaGt1dkhVZWY4?=
 =?utf-8?B?WlBWeDRVUW1VL3NNVWdQbHkyMTNQa0k0NjNtS2Y3SVR3RVFKaXNCandWYVhV?=
 =?utf-8?B?cU5Za0xGeUpIWjJ4dHhBSnRuVzAxbi9Ya0syZlpvVEN0a05GdTNVbm5MdWg5?=
 =?utf-8?B?dWtmVmJYOEZWZ1I5WjhIZVZ0SERqQlk0UzF3a29vMU1ubmRXeGZNbTZCOVB1?=
 =?utf-8?B?cmJSV25KSy9kbEgxbm9Md0lDclJjeVlabHF0cC9PMjNMcStmSzE4UXg2SlUv?=
 =?utf-8?B?anBsRHF0dHJHYnExRUZicTdCa2JHT3o4bmZqSlp3MnMxWVhXNlFLTVl2LzFN?=
 =?utf-8?B?S29hdzJEaGEzVk9iNWdPQWx0QzVHU0duWU9VY0hPNTVUWk5GK2ErK1pYUlhY?=
 =?utf-8?B?TVZHQVZ3a0JrUnNvbDFhanYwTzdTMWpGZXMxa28rU1UraklDWXVsZ2tzTElu?=
 =?utf-8?B?dTQrVS9tTlE1QWovTjNpTEVEeHp4akZzNGtmNWFCV0NtVGJ5UjRaOWRFMWtP?=
 =?utf-8?B?aVJsS1RYVVRlZUJQS1dJeUxKZXRKbG95bm5RNTJzZnVScE1HakxhcVlZcm1S?=
 =?utf-8?B?c3lnM1MvbS9vTUoyNXdrLzhNRVF1b3YrcHlKUE1mZFJYWHcwYk1BRElIdCtw?=
 =?utf-8?B?ODBUSytlQm1VWWNpTy8vdDJsVUVCMzE2eTFkSFFoY2lZUXQxRTFBeWNxY3Zt?=
 =?utf-8?B?YU1tNG9sQmlrOGc4eTJpNG9JN3BHM2lRaG5Za2hLQ1Arb1ExRzB3dnBZaEJt?=
 =?utf-8?B?ZUhKbEZMWGFPWnI1MHNKcDE3RXlmREh0N3ZRNnM0WWh0TFM0NS85akRCVHVr?=
 =?utf-8?B?cUFqTDFkenFHb2RhZkI1NEROZm9hRzBzRXcrQktqYnFwcVJhMjRxMEVBakFj?=
 =?utf-8?B?WnJ1d2F5MEhxamtXaDlld0RyZTIrYXBwT3JlU0tCQkdOYWUwSjF6bkJpMHZ3?=
 =?utf-8?B?U2pmOFNMZjNHNWpVN1F2bnlWWjcyN1Zya0E2RGJPKy9nenNPMFRnK3NZOTR0?=
 =?utf-8?B?M0UxR3E2V1oydy9aTUJKbzUzNjljYjdWMmh3OUpwM3AySUcxT1Y5Sm1KSG5J?=
 =?utf-8?B?QTcza2tlTFhUT3RTTEpnVW1DajN3S2pOOE16R2p1RG4vUzB6YmxBeWo3Umhx?=
 =?utf-8?B?VnR2U0ZWRkxSV211TkVsdDdHajN1QmpUN1JKeThicTVuelpHVGdyT0F1a2ZL?=
 =?utf-8?B?Y3RTR0pvTXZtYTY0Y0VNK3djYlc3eXFtQ3hVeXJuNi9NbUNneXdiVFdWcTdy?=
 =?utf-8?B?c2VBSUU5WFBwcmNXcnVRbElQQ1lRQ0FoeGxMdXA1ZjgzVDVwUkdlUktGayth?=
 =?utf-8?B?RlF4SytMUlFTYzVja2xNSTVUSDBVN0lITWtVVytoRlBKRjl5dzVqaElNc3cv?=
 =?utf-8?B?SjBHcEs4S2FIZ1AyY1VROXJkRUtCT01jNWFuOG1qYkxNY0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 10:10:05.9635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f04b27-2acb-43cc-f065-08dcf801dca7
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5590

On 29.10.2024 10:55, Danilo Krummrich wrote:
> On Tue, Oct 29, 2024 at 10:50:11AM +0100, Danilo Krummrich wrote:
>> On Tue, Oct 29, 2024 at 10:19:08AM +0100, Dirk Behme wrote:
>>> On 29.10.2024 09:50, Danilo Krummrich wrote:
>>>> On Tue, Oct 29, 2024 at 08:20:55AM +0100, Dirk Behme wrote:
>>>>> On 28.10.2024 11:19, Danilo Krummrich wrote:
>>>>>> On Thu, Oct 24, 2024 at 11:11:50AM +0200, Dirk Behme wrote:
>>>>>>>> +/// IdTable type for platform drivers.
>>>>>>>> +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
>>>>>>>> +
>>>>>>>> +/// The platform driver trait.
>>>>>>>> +///
>>>>>>>> +/// # Example
>>>>>>>> +///
>>>>>>>> +///```
>>>>>>>> +/// # use kernel::{bindings, c_str, of, platform};
>>>>>>>> +///
>>>>>>>> +/// struct MyDriver;
>>>>>>>> +///
>>>>>>>> +/// kernel::of_device_table!(
>>>>>>>> +///     OF_TABLE,
>>>>>>>> +///     MODULE_OF_TABLE,
>>>>>>>
>>>>>>> It looks to me that OF_TABLE and MODULE_OF_TABLE are quite generic names
>>>>>>> used here. Shouldn't they be somehow driver specific, e.g. OF_TABLE_MYDRIVER
>>>>>>> and MODULE_OF_TABLE_MYDRIVER or whatever? Same for the other
>>>>>>> examples/samples in this patch series. Found that while using the *same*
>>>>>>> somewhere else ;)
>>>>>>
>>>>>> I think the names by themselves are fine. They're local to the module. However,
>>>>>> we stringify `OF_TABLE` in `module_device_table` to build the export name, i.e.
>>>>>> "__mod_of__OF_TABLE_device_table". Hence the potential duplicate symbols.
>>>>>>
>>>>>> I think we somehow need to build the module name into the symbol name as well.
>>>>>
>>>>> Something like this?
>>>>
>>>> No, I think we should just encode the Rust module name / path, which should make
>>>> this a unique symbol name.
>>>>
>>>> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
>>>> index 5b1329fba528..63e81ec2d6fd 100644
>>>> --- a/rust/kernel/device_id.rs
>>>> +++ b/rust/kernel/device_id.rs
>>>> @@ -154,7 +154,7 @@ macro_rules! module_device_table {
>>>>        ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
>>>>            #[rustfmt::skip]
>>>>            #[export_name =
>>>> -            concat!("__mod_", $table_type, "__", stringify!($table_name), "_device_table")
>>>> +            concat!("__mod_", $table_type, "__", module_path!(), "_", stringify!($table_name), "_device_table")
>>>>            ]
>>>>            static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
>>>>                unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
>>>>
>>>> For the doctests for instance this
>>>>
>>>>     "__mod_of__OF_TABLE_device_table"
>>>>
>>>> becomes
>>>>
>>>>     "__mod_of__doctests_kernel_generated_OF_TABLE_device_table".
>>>
>>>
>>> What implies *one* OF/PCI_TABLE per path (file)?
>>
>> No, you can still have as many as you want for the same file, you just have to
>> give them different identifier names -- you can't have two statics with the same
>> name in one file anyways.
>>
>> Well, I guess you somehow can (just like the doctests do), but it does make
>> sense to declare drivers in such a way.
>>
>> I think as long as we take care that separate Rust modules can't interfere with
>> each other it's good enough.
>>
>>>
>>> For example adding a second FooDriver example to platform.rs won't be
>>> possible?
>>
>> Not unless you change the identifier name unfortunately. But that might be
>> fixable by putting doctests in separate `mod $(DOCTEST) {}` blocks.
> 
> Another option would be to not only encode the module path, but also the line
> number:
> 
> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> index 5b1329fba528..7956edbbad52 100644
> --- a/rust/kernel/device_id.rs
> +++ b/rust/kernel/device_id.rs
> @@ -154,7 +154,7 @@ macro_rules! module_device_table {
>       ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
>           #[rustfmt::skip]
>           #[export_name =
> -            concat!("__mod_", $table_type, "__", stringify!($table_name), "_device_table")
> +            concat!("__mod_", $table_type, "__", module_path!(), "_", line!(), "_", stringify!($table_name), "_device_table")
>           ]
>           static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
>               unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
> 
> This way you'll get
> 
>    "__mod_of__doctests_kernel_generated_3875_OF_TABLE_device_table"
>    "__mod_of__doctests_kernel_generated_3946_OF_TABLE_device_table"


Yes, if we want to avoid adding a unique name that makes sense and is a 
good "automatic" option :)

Thanks

Dirk


