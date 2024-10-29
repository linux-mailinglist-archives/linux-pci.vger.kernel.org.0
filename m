Return-Path: <linux-pci+bounces-15511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803BD9B4589
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 10:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C331F223CD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAF02038D7;
	Tue, 29 Oct 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="IOP8DawI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31702040B9;
	Tue, 29 Oct 2024 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193585; cv=fail; b=cUMsvTiEhiG+SHSS78CX9YR/WqzxpeIte0m9EflXGeit67EriphUJUeOa7WVM/pbt41xivcsdyS6VvfYBMUFljSP7Dgvu51Hc28CBnj9FKNof1zkKx0bf7dcA1gwbeVrSg9euLlWLWNzp5voJDbnlmq8XJwvsP9NjYcQ3KjiLSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193585; c=relaxed/simple;
	bh=ifsK6MSjNuRdnfhix0W09zPKNbzeVkEaeDatXYTlabw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZjjFasD+EEOkU8wp3u7+fl977qAdPwXx55VHDlpKkQJGTyfiEvmfGiIoD9zNvb4eBDl6UsP+GHPWLGaNIrQnthXFPGLxgNhQUXqr6EDKV3+0kP7B0ZHImvVKf1GTT0u7Ql+SOQx2VEmWPzowSlN5yPtKUxGqE4H9O1i/0BZya5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=IOP8DawI; arc=fail smtp.client-ip=40.107.249.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkOmJiftSCP/X4FcVwlicv4WPVGngxvomXi7jqB5mF7DJSfXUQYk2uYqI8LWqvbSttXwsJqlDpbkvKytgyJVkavq/8zZLd20MHs7zHdQEstPfSnZ/Dr2YEiALUasqXrbbqysCml1LnLjNm3YMrTurZHW/IteTTRdCPDyPxGy1c80llXliML1AU6AfCokLxMwZA1jlo8q8gag+HBIbIzqtF20lIy8HOzRLckLmPplIIcrQwqEcwF1L9PGUYd+f8ph9WSeIV+fl7GxtMekI92+9ElCACMK0r3eFw8fSLzvVgXxTK+1K/Q6hnfMpfxmoLfP/YPcKxIv5i17j7W6LUDcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGEI1tYJdKCaTjkK6Sz2uHIigdS3ukRJIQTesTjou2g=;
 b=lFJQhZ+PN3cNxF60n0l0Ngv0k2oim6wsYAKvhUhqkX0soc2Yn0OoUO0DyAKEA/SYRgfNjyzwE4HN6w6wAjs8dLdUX4vfwsfAjmIN6fxKK9cXMVBZ5rijK8uVctE9u0YyDmD5oIJPCp5ITkjPMuYmOhBByeyEymwZHopYelUCew6T5NJhqs7sT9GrS/ifBhvXuT2opd9r6Vy9dpr6/pCCgKwEML4SgmM1XR9Bi3nlDGMmjqiil9sbxTd4n/QRoECXTJnLZ1YHZ+0kc7sO2lEywyl+QTXdY41CuMFkUhLSuQjhxGTt21SttXG88bJ91kcB8NmMkQiSntUdSFzM6JPkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGEI1tYJdKCaTjkK6Sz2uHIigdS3ukRJIQTesTjou2g=;
 b=IOP8DawI9BZRfQO63yuFENP8xa0ydHcTqF748y+0wKFgDwnpjFFrkpeBLeQVeXk/UoJkB3UPGgvbACDmgQIukN9inVoO4kUT8mb/5Rilc+U6TwkagBtBYx8x+e7vgP7Vv9MY3EX/zu8Xgpo2i0KFakW1OHkkUsCXQd5nnr0nHh+1cemntAnV5cuETmD9mbVrwhG4DJv/SEKrdLN/3MqpPdSE8XpGWQDVwlxbtVYq2kXq2x30JFiHnrZYe24rVhbTLdIXwJupdyhdmhKeyQa0t/3GohxbVvPbRlxOoVxvILZW609Uu+AFKTfwDSpyVIXIaPe+PO8mrZHkTBLbVD117Q==
Received: from DU7P250CA0029.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::18)
 by AM7PR10MB3892.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13; Tue, 29 Oct
 2024 09:19:36 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::6d) by DU7P250CA0029.outlook.office365.com
 (2603:10a6:10:54f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Tue, 29 Oct 2024 09:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 09:19:36 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Oct
 2024 10:19:14 +0100
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2001.de.bosch.com
 (10.139.217.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Oct
 2024 10:19:14 +0100
Message-ID: <8d72e37e-9e27-4857-b0eb-0b1e98cc5610@de.bosch.com>
Date: Tue, 29 Oct 2024 10:19:08 +0100
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
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <ZyCh4_hcr6qJJ8jw@pollux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|AM7PR10MB3892:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e81367-c464-4d51-70d5-08dcf7facee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVpFK1ZmS3pSMERYSkMzb21Jc04yeW9GVUsrN3lLY25aLytZR1JwWEh1Q3dE?=
 =?utf-8?B?c3ViYWZPYUVEZEtVS2xUUkxBY1JNMHdVaEFlQ2ZDMm4yUlAyaURSYkU0YUwx?=
 =?utf-8?B?Skt4UE91M1NPYUpjV29NZktOeU5XQTczbk1iZFdVejY4WXZjMmtxd3BEenVQ?=
 =?utf-8?B?RmpxMjNmemViUFhsMHN4aUVTYjl4SWMxNndsQk1DamI3U1ZyajF1cFB1WTB3?=
 =?utf-8?B?WERtMVl2UzEwMElkZjkwRlJjb2Z1SEZuNlZnWVNxdUhoUCttTXRuOTh5VVRm?=
 =?utf-8?B?STVaSXVUYVNmajh1U0dlQ0hiWEFHTDZ3SVZGVnQ1KzFQdEpEVHVhKzIxVW9W?=
 =?utf-8?B?Z3hoQWFJb1ZiQ1ZSMjN6RlFzNGdaQjdpaUdQOG9kY2pNVzJIRi9rbXpkbHNa?=
 =?utf-8?B?eE9qcXJRWHZtYW0wRFlPYXNNMEJaZHZ2U2dOMGpFQjNhNCtBVzIzMDZFaUIz?=
 =?utf-8?B?Mkd6Skx3ZzNqOENUZnByK1ZybXMxeDVPaU5FMnJybGRBeUNTWnBzdGQ5M0VG?=
 =?utf-8?B?eEUrSzFia1l4YVMwTHRVSDJUSzNWOFhtQ2ppeENkQkJsVDBxTkprNFVCTFpW?=
 =?utf-8?B?MkxwbERwZzJQekY2UTRZQ2gyZ1VLVWNxZ1FLdXRvaU5hbllXKzhPSmhybjUx?=
 =?utf-8?B?THRUb0JIckZrSSsxTHVPOFBZSGliVFY3UnZtWGZiMjk5MExuZzJZeE9XOHZW?=
 =?utf-8?B?cVh5Zjc3NVNvOHV5OStiQ0thNE14a1RCTVFJTzRKL0lMVENUUjFGbXBDaHlq?=
 =?utf-8?B?ZmpXZnBwSjdsb1AzLzhRMUU0b2EySDZ1Nm56eWdpMXFad1dCTURxeXkyUklh?=
 =?utf-8?B?WGxJcXBZaThJbTlLVnlvOS8zVmlRMnhNWUFBdG1oQjRBeGRvcUlkMzEveWky?=
 =?utf-8?B?V1RhSHViUFIzZ3dzeVcwVFNjSDM5Y25ZVmFieEhwOEJpOGxFVzNDSzVWZzl2?=
 =?utf-8?B?TjBhVnE0MUFneW0vRjU0aWRGeHNUb2ZFdnFLa2FTalByWWdMckk3MDdSbEdJ?=
 =?utf-8?B?LzVhQ2lpQU9VTWtzdE42aVdHQXlreDl3MmdFMlVyaTY4K05tWlRJOWpaTHNn?=
 =?utf-8?B?RnpWTDBzaDhzMEhvVkVGT3pyVXFCRStlRGJaTHdGOWlBR25KTkFHblhrOWNE?=
 =?utf-8?B?aFpzWUtyYVlrTUtxdkt0M2RqdmRsQWlyOHNBV2ZoVk1uUkpwdnlIM1B0RWVN?=
 =?utf-8?B?enNzSjVadkt5QkNMV1dmSDdqV05Vd0tldDFoVTFyT24ydDVkRWtiMHQ5bXFK?=
 =?utf-8?B?ZENwNEIyTTFqczVFenU3YWZFUTc1WW0rZFpzcS95SkNSRmNFbkMzaXBSdmRO?=
 =?utf-8?B?emF2cTJiK2Nrak9yMEgwbHVOeUE2TjJ2d2tIR3NaSUVJRDFUdWI4bEtpZXN4?=
 =?utf-8?B?ZjRuM3U0cHg0YkVtaEFFTHdVRnBLOG5FUVRKUUVwc0N1dXMycjJoLzJNdHFt?=
 =?utf-8?B?U2txTHRFWXUyWmNadHRzVFJrcUZ4clRWN2pIVUdYcDRhZmJWQ2ZxNTNERnMz?=
 =?utf-8?B?b1lzclhzNC9mdWQrWWhKc29XQ0U4M1hWYkh3Vi9CM29abU5kclBraW5ZT3Bu?=
 =?utf-8?B?Qnc1NTBDeXFINXJEUGpRT3ZrbGh3K2R6TmN0Z3VpbzJEY1BoSWRZWVJicWFi?=
 =?utf-8?B?bFQzWVRTVlVZWXMzaU9YNDFNYm4zQ3BzdXQweFlwbytiN09pdk03NlBUSEhN?=
 =?utf-8?B?Vmk1ODJxTW1jejMxU3dlck9DYWxRS3dNRkhuVUxaenlOcnlFdE43V0FuSnJC?=
 =?utf-8?B?eWptYm5pbEFKdi83ZEdkejdTL2NmSzd0MGMxZ0JicUJPemc1OVBpY2lIL3Uy?=
 =?utf-8?B?VWNEdG1HcWhuRGovUjNaQ01xZFZiYkkwczAzOFowWEpNVE9jZDNnS2t3TDVW?=
 =?utf-8?B?VE84UHRNQzBHdGU4Mml6eWx2RC9TUEZQdHk4a3ZXd084N2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 09:19:36.4054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e81367-c464-4d51-70d5-08dcf7facee8
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3892

On 29.10.2024 09:50, Danilo Krummrich wrote:
> On Tue, Oct 29, 2024 at 08:20:55AM +0100, Dirk Behme wrote:
>> On 28.10.2024 11:19, Danilo Krummrich wrote:
>>> On Thu, Oct 24, 2024 at 11:11:50AM +0200, Dirk Behme wrote:
>>>>> +/// IdTable type for platform drivers.
>>>>> +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
>>>>> +
>>>>> +/// The platform driver trait.
>>>>> +///
>>>>> +/// # Example
>>>>> +///
>>>>> +///```
>>>>> +/// # use kernel::{bindings, c_str, of, platform};
>>>>> +///
>>>>> +/// struct MyDriver;
>>>>> +///
>>>>> +/// kernel::of_device_table!(
>>>>> +///     OF_TABLE,
>>>>> +///     MODULE_OF_TABLE,
>>>>
>>>> It looks to me that OF_TABLE and MODULE_OF_TABLE are quite generic names
>>>> used here. Shouldn't they be somehow driver specific, e.g. OF_TABLE_MYDRIVER
>>>> and MODULE_OF_TABLE_MYDRIVER or whatever? Same for the other
>>>> examples/samples in this patch series. Found that while using the *same*
>>>> somewhere else ;)
>>>
>>> I think the names by themselves are fine. They're local to the module. However,
>>> we stringify `OF_TABLE` in `module_device_table` to build the export name, i.e.
>>> "__mod_of__OF_TABLE_device_table". Hence the potential duplicate symbols.
>>>
>>> I think we somehow need to build the module name into the symbol name as well.
>>
>> Something like this?
> 
> No, I think we should just encode the Rust module name / path, which should make
> this a unique symbol name.
> 
> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> index 5b1329fba528..63e81ec2d6fd 100644
> --- a/rust/kernel/device_id.rs
> +++ b/rust/kernel/device_id.rs
> @@ -154,7 +154,7 @@ macro_rules! module_device_table {
>       ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
>           #[rustfmt::skip]
>           #[export_name =
> -            concat!("__mod_", $table_type, "__", stringify!($table_name), "_device_table")
> +            concat!("__mod_", $table_type, "__", module_path!(), "_", stringify!($table_name), "_device_table")
>           ]
>           static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
>               unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
> 
> For the doctests for instance this
> 
>    "__mod_of__OF_TABLE_device_table"
> 
> becomes
> 
>    "__mod_of__doctests_kernel_generated_OF_TABLE_device_table".


What implies *one* OF/PCI_TABLE per path (file)?

For example adding a second FooDriver example to platform.rs won't be 
possible?

+/// struct FooDriver;
+///
+/// kernel::of_device_table!(
+///     OF_TABLE,
+///     MODULE_OF_TABLE,
+///     <FooDriver as platform::Driver>::IdInfo,
+///     [
+///         (of::DeviceId::new(c_str!("test,rust-device2")), ())
+///     ]
+/// );

Best regards

Dirk





