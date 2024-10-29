Return-Path: <linux-pci+bounces-15505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9439B4301
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 08:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C6BB21344
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D41FF7A8;
	Tue, 29 Oct 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="TZuimXo4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311220127A;
	Tue, 29 Oct 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186551; cv=fail; b=YoCePp/AhF4UYk/96GeRffC+tsPubensxHq+qr51Nv31ewshpZCY/MixIcmIOZqszCN1lUAU49/SjQO4dyrNWhlLxFUowzj7CnRdCy9Urd56TKohwE+pkDQ1Bz7SRhOZmXEdYPhlF2TTox3ougqx74QYq9sfr/04cF0f9Yjb2o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186551; c=relaxed/simple;
	bh=Yk2qAUYU0AFSDgMR2vvfEM9UwjHtVW2iPBcN81elVls=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y1LRQ5Pg1YVLiEDJFiom8TElhPpEkvSA1O2e2LdcENAbs2T1K1nYQwIZvg/JM+Yo3CX5rOPahC29aPNZT2of7Q0Z+fwQPNbvgLL1RP13fyM20xWP0GM9nBgPObJkfUZz+WvHsRq/ZuYvaO9mSzfCBKRKcvKbMgXYPxwfqGCqtYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=TZuimXo4; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW4QzDqrurqFKot7zhzat9NO4YCSYGSkMGoxIxp2CT6gF1PJ22rYvmsMYjlZ7MT4CYGkGHktJ+bYSlm/GQlvRF/xVDMKZ3tPkmStb8AOPKJfhTGnNm8jMsfGSr5DBOLTqdtlFnAE/7dHnOt5bs122yJ2d+DnAqKQMJPAaaHNsA/g4FnrgTThuyc8F1Fx83YWz27InGPWh3T+wtptHI8JnwpLj209RobP8otSZAsCU/PcQVy7QmGbDLwnkS4kFxOaaJku9kgL/W/VrepI163Ut5ZwoNSlpUIwPoAmZI+wcnf9sa/zte3Y1d2Es52dTVwDiDmnD8CjVzRBHDGXvMJ+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItbvLAyOtuWRT2gLACoOLaMGlSuhB8RhQeMpL4ziLs4=;
 b=j3vyIsHiVhvd/PQnO92PY3VARujEb81/XtYHDQxkQpACRHR8l86exkjWgWIAtz75/qEvMCP99t6lpa/qrhPGTTU9Vomg+7js7DCMshRkV9eAQ1IIJk+Nhn63DHOnnXW1vgNxNDRaxRB4CNcop/dbdsCHndwroga1Cb5FLp1WPRrFFtDeVkhdTCyRl3xHgMcuMIGiIeQLBe8pu4QOkZQnwA7Q7l+vKjejGKrJ0Fo4XK6Y/GrqzXgWS9a/+cEzHPbxg1MrRO9p39kVzzVH/nwwWPlxvRYTeeb1ucOV9EHhxmFB1d5/ZGuMmK6pn50B4f7YjseTa5IpeFcA+cNrIkHdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItbvLAyOtuWRT2gLACoOLaMGlSuhB8RhQeMpL4ziLs4=;
 b=TZuimXo4dqRnEN3llUJl0QElM5IasEuv9+aV+bD9mEbjvMHe2tCelWzGZmsCgAsSTsOUmTytLzb6VIIBStLds7pISuAj54FBLIYNCF9GmqVPui0cGKxdsx62LS+ttHEK4k5SL34K+WvNWSEnvkU1Dq9CO6ENugUkbHnQE15mUU22R/NOb8Fylw9RMJ4drq4b8+TfrGdkAn3x/y3A33kYRyvmcIKK9H79mKyDrRv9LX/ygK24Dp0643xVBQZB6daa0NF/RE4Xt/Xtss+rMkgsZr6Ld8CE9WynVjvk3Wx5Y/YvERIPivMK6h6VrfUnXuhh/Mu4oh1dr/3lbf+S0E/YMQ==
Received: from AS9PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:20b:46a::10)
 by DU4PR10MB8322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:566::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.19; Tue, 29 Oct
 2024 07:22:22 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a:cafe::3f) by AS9PR04CA0031.outlook.office365.com
 (2603:10a6:20b:46a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 07:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 07:22:22 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Oct
 2024 08:22:21 +0100
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Oct
 2024 08:22:21 +0100
Message-ID: <fd9f5a0e-b2d4-4b72-9f34-9d8fcc74c00c@de.bosch.com>
Date: Tue, 29 Oct 2024 08:20:55 +0100
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
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <Zx9lFG1XKnC_WaG0@pollux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|DU4PR10MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e142ec-12b6-42a9-476a-08dcf7ea6e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXFUMVRzNkxCRENTNnlwZTA3eFVXajRFV0FabDlDL1NmUXFGdHk1YzRra3pY?=
 =?utf-8?B?aFRWSXdWeWtDaEpBTGNjZSs2T2tBaTlyUjVkUnN4dXB1SVZkTC9nVVJCRU1D?=
 =?utf-8?B?M29OcTBWUkE1Vml6NS9sQ2hXbUY4TTdFMy8yWGFtNHFnN0U5eG5TZ2dwa1ZV?=
 =?utf-8?B?TlBkUDd2emJLMW84ZVF2OHhpRktWcUxsek5ySjI0VEE0WFk5VWI0QzFMTkpO?=
 =?utf-8?B?SWUzVHc2Z0ludDlSOVY3dDdkOVpFd0J4TDJadUJ6QlMyV2xScmM0Z2ltQ2N4?=
 =?utf-8?B?dERqREgrNWxYNHJpa1pIRnBSemNTU1lVUmNubU5kWDM1ejJRVE16NkNaNTZs?=
 =?utf-8?B?SXBZcGRpWVc0Q2U2Z2ozRjg3OGRrUGQ1OXdoNW82enFRYU5vQ2hwaFJNL0lZ?=
 =?utf-8?B?bUhocmRROXNGbWErUGJ6c2JFODh4ekROVyt4S291cnNzU0daV0NaelZqcnM4?=
 =?utf-8?B?V3FBNlF0UzY5cWVYV3BKb3pCODNIY1RaUGtNV3RTRjBSOEluRmVLZkdhTzA5?=
 =?utf-8?B?R3NsY0lCdjVzcE9EREdEY2VPSVJiTHd6SkxVUkhnQ2VJOWtRR3BxYWlia3pY?=
 =?utf-8?B?T2RCcnlDc0RtS2VybENFRlJYSXJYSXVYeHlFT0tTQ1FrdHFWSmY4dFNOc3VJ?=
 =?utf-8?B?VVkrZWRHeStKbDlPRktTZ3ZZaHYySFVWaEVSL1JGLzJBNkREb0IrVTk4Kyt4?=
 =?utf-8?B?aE51RElaNXdQRGUyQWlxN2t6NDI0bm5mN2h5K0JOeHNGVVFDNjdwU3gxSi9v?=
 =?utf-8?B?SElCMmhIYjVGcG1Nek5iazBjZStHNkZPdmY5RmV3d2Q5MU9ONkNBazJSa0FP?=
 =?utf-8?B?YlordGNOZERZT3ZISE1kRFNtQlJSOHZTbUhmOGl5VG56MXBMdjJPMkkyaEtt?=
 =?utf-8?B?SDRzN2h4SkFBWDhIajNBUWNrbnA5YVdMbkNHMEQyU2FIbVZVYmY3ZmVOUWRq?=
 =?utf-8?B?MDZuNS91ZmV5NXF4OEpjZkJ6SlRSUlgwRzVDa0N0ZktsQ1RTaGJIRENEWTgy?=
 =?utf-8?B?QXVXU0U3VldhbkhzLzZxdFNkbERSMnR4UmVMbEtyZUQ4QUlqbzJUblhJUy9D?=
 =?utf-8?B?NHRjTWZrWDk5bnVIMEtCWWdtOVhuMlYwMndFbThOc0xHSm43NkpXbmsvVEE0?=
 =?utf-8?B?c2MyUFZISUxaUEhjTGp5WDRrRGE2Vmc5ZGFsaWQzRTEwVlhjajlvVVNjeXlJ?=
 =?utf-8?B?RzlqTUpuRW1TTkFuTENoN3lLdVNQVWZwNnhxdDZLeFRUSWNNV1lhRVFVRUFx?=
 =?utf-8?B?NnhmZEt1OGpnTjF6c1l6amE3bXFXdjdIY2xoMVJsMmNJT1BsZ3NKVCt3UDg5?=
 =?utf-8?B?czd2TndEbEpXTDlKOXZWTjRiY2RldXNwbTBMSkdRSllsRFp4RVd0UksrNjRH?=
 =?utf-8?B?VzJqOFExalBobUFCU0JUYnhSWGFCaitYYnltdklEYm1jRWRIUlZKSW1WQ0V0?=
 =?utf-8?B?MUhLWXJ1cXlIRUtwK0RSRlNpYVJidFhIWGx5Skt4YkhYYkl0VHNBY3Q0cDgv?=
 =?utf-8?B?YytxWE9obFpjd0dDd1grQmMwVFQ0bVg1NU9FR3JzWGVIak1YOUxndWR3aGhS?=
 =?utf-8?B?MVhCNWtsVkxCejFJdG1ITEtvVUhEMVE3Yjc5bXZ3b2c3dTBncHpyRnMwZ04z?=
 =?utf-8?B?bWZQRDJxYmtUSkpWZmFGalM1NHVVVWFmS29YL3EyNUZZSmJCZDFQU2pBQWRV?=
 =?utf-8?B?WlV6RStCQUNJZTRTQzJyMjdDaTc1Vzl6eTFIcVZNVldJamxHcHdVZlgrWWJR?=
 =?utf-8?B?MkMvM0lyNUg0OFJMaGhJM0N0Vy8rTjNvejJxemdtOUpkTkpRQkVLNGtuT21M?=
 =?utf-8?B?Yk9uNllGWFJxL2FEa2p4amlrY2VZMFZCVWN6RXFQRUJhQW9NbnBJdmJZbHdZ?=
 =?utf-8?B?QmFJZGN5UGIzMENrMXFZUU1adnlmRlJGdE5YQlhaemxaRlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 07:22:22.1593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e142ec-12b6-42a9-476a-08dcf7ea6e29
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8322

On 28.10.2024 11:19, Danilo Krummrich wrote:
> On Thu, Oct 24, 2024 at 11:11:50AM +0200, Dirk Behme wrote:
>>> +/// IdTable type for platform drivers.
>>> +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
>>> +
>>> +/// The platform driver trait.
>>> +///
>>> +/// # Example
>>> +///
>>> +///```
>>> +/// # use kernel::{bindings, c_str, of, platform};
>>> +///
>>> +/// struct MyDriver;
>>> +///
>>> +/// kernel::of_device_table!(
>>> +///     OF_TABLE,
>>> +///     MODULE_OF_TABLE,
>>
>> It looks to me that OF_TABLE and MODULE_OF_TABLE are quite generic names
>> used here. Shouldn't they be somehow driver specific, e.g. OF_TABLE_MYDRIVER
>> and MODULE_OF_TABLE_MYDRIVER or whatever? Same for the other
>> examples/samples in this patch series. Found that while using the *same*
>> somewhere else ;)
> 
> I think the names by themselves are fine. They're local to the module. However,
> we stringify `OF_TABLE` in `module_device_table` to build the export name, i.e.
> "__mod_of__OF_TABLE_device_table". Hence the potential duplicate symbols.
> 
> I think we somehow need to build the module name into the symbol name as well.

Something like this?


Subject: [PATCH] rust: device: Add the module name to the symbol name

Make the symbol name unique by adding the module name to avoid
duplicate symbol errors like

ld.lld: error: duplicate symbol: __mod_of__OF_TABLE_device_table
 >>> defined at doctests_kernel_generated.ff18649a828ae8c4-cgu.0
 >>> 
rust/doctests_kernel_generated.o:(__mod_of__OF_TABLE_device_table) in 
archive vmlinux.a
 >>> defined at rust_driver_platform.2308c4225c4e08b3-cgu.0
 >>>            samples/rust/rust_driver_platform.o:(.rodata+0x5A8) in 
archive vmlinux.a
make[2]: *** [scripts/Makefile.vmlinux_o:65: vmlinux.o] Error 1
make[1]: *** [Makefile:1154: vmlinux_o] Error 2

__mod_of__OF_TABLE_device_table is too generic. Add the module name.

Proposed-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/Zx9lFG1XKnC_WaG0@pollux/
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
  rust/kernel/device_id.rs             | 4 ++--
  rust/kernel/of.rs                    | 4 ++--
  rust/kernel/pci.rs                   | 5 +++--
  rust/kernel/platform.rs              | 1 +
  samples/rust/rust_driver_pci.rs      | 1 +
  samples/rust/rust_driver_platform.rs | 1 +
  6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 5b1329fba528..231f34362da9 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -151,10 +151,10 @@ fn info(&self, index: usize) -> &U {
  /// Create device table alias for modpost.
  #[macro_export]
  macro_rules! module_device_table {
-    ($table_type: literal, $module_table_name:ident, $table_name:ident) 
=> {
+    ($table_type: literal, $device_name: literal, 
$module_table_name:ident, $table_name:ident) => {
          #[rustfmt::skip]
          #[export_name =
-            concat!("__mod_", $table_type, "__", 
stringify!($table_name), "_device_table")
+            concat!("__mod_", $table_type, "__", 
stringify!($table_name), "_", $device_name, "_device_table")
          ]
          static $module_table_name: [core::mem::MaybeUninit<u8>; 
$table_name.raw_ids().size()] =
              unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index a37629997974..77679c30638c 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -51,13 +51,13 @@ pub fn compatible<'a>(&self) -> &'a CStr {
  /// Create an OF `IdTable` with an "alias" for modpost.
  #[macro_export]
  macro_rules! of_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, 
$table_data: expr) => {
+    ($device_name: literal, $table_name:ident, 
$module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
          const $table_name: $crate::device_id::IdArray<
              $crate::of::DeviceId,
              $id_info_type,
              { $table_data.len() },
          > = $crate::device_id::IdArray::new($table_data);

-        $crate::module_device_table!("of", $module_table_name, 
$table_name);
+        $crate::module_device_table!("of", $device_name, 
$module_table_name, $table_name);
      };
  }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 58f7d9c0045b..806d192b9600 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -176,14 +176,14 @@ fn index(&self) -> usize {
  /// Create a PCI `IdTable` with its alias for modpost.
  #[macro_export]
  macro_rules! pci_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, 
$table_data: expr) => {
+    ($device_name: literal, $table_name:ident, 
$module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
          const $table_name: $crate::device_id::IdArray<
              $crate::pci::DeviceId,
              $id_info_type,
              { $table_data.len() },
          > = $crate::device_id::IdArray::new($table_data);

-        $crate::module_device_table!("pci", $module_table_name, 
$table_name);
+        $crate::module_device_table!("pci", $device_name, 
$module_table_name, $table_name);
      };
  }

@@ -197,6 +197,7 @@ macro_rules! pci_device_table {
  /// struct MyDriver;
  ///
  /// kernel::pci_device_table!(
+///     "MyDriver",
  ///     PCI_TABLE,
  ///     MODULE_PCI_TABLE,
  ///     <MyDriver as pci::Driver>::IdInfo,
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index a926233a789f..fcdd3c5da0e5 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -118,6 +118,7 @@ macro_rules! module_platform_driver {
  /// struct MyDriver;
  ///
  /// kernel::of_device_table!(
+///     "MyDriver",
  ///     OF_TABLE,
  ///     MODULE_OF_TABLE,
  ///     <MyDriver as platform::Driver>::IdInfo,
diff --git a/samples/rust/rust_driver_pci.rs 
b/samples/rust/rust_driver_pci.rs
index d24dc1fde9e8..6ee570b59233 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -31,6 +31,7 @@ struct SampleDriver {
  }

  kernel::pci_device_table!(
+    "SampleDriver",
      PCI_TABLE,
      MODULE_PCI_TABLE,
      <SampleDriver as pci::Driver>::IdInfo,
diff --git a/samples/rust/rust_driver_platform.rs 
b/samples/rust/rust_driver_platform.rs
index fd7a5ad669fe..9dfbe3b9932b 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -11,6 +11,7 @@ struct SampleDriver {
  struct Info(u32);

  kernel::of_device_table!(
+    "SampleDriver",
      OF_TABLE,
      MODULE_OF_TABLE,
      <SampleDriver as platform::Driver>::IdInfo,
-- 
2.46.2


