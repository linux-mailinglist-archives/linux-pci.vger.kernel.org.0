Return-Path: <linux-pci+bounces-15287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B359B002E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 12:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9652818F0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC301D8DFE;
	Fri, 25 Oct 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="GB9gvuIo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D918D655;
	Fri, 25 Oct 2024 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852385; cv=fail; b=IFFq/ZZ0gcTKTvFFDlJIhgp6th/hcMg2DGLNBDifTfihHUb5cakxnsmtw0lvNtbtX0MGuepi1T7ZdU1hZN9iJbDQk5DPpd9xFVlm8q10mzAs3aJia7uYyBsmwT5Wzrs2VHtucRGaMK1PG+pAgNIEzpNWGqMHCXCDq3hEqIKd+aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852385; c=relaxed/simple;
	bh=EolDaJR0iwjYUOos3BKcbnlcMeVfQQZGk/GJULYYb2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r2IJyO7LHcCfpywV+0Ngd550I2nV6z66UOFLWgLk35/XKvDWuXGEjjxDy6gxFbZ18EQTzXvj/a9fzUqu6VgHDLPUh7tdVARiCSEkILnk4O0yXzqL1zkw6JhLQqCPPnCKEiP0O0YTx3o3PKllWNSw1Tk5cUFb245gbQmaIIwMUpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=GB9gvuIo; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rssR0SPwBcv3MElVwipthuPiZZf8HzpMkoX90Vb0x7cJBWvWUaoI9R+WKsxu8ghV2s7AwTeoFo6BVP/fECwWWjeuC3txfSZlNRtM1LlOYo+yCNpT22fgGZD6bEjAf0Ab8Oz6HrreC5YUnxoaFuGGMGkj7RP1l4JSBnO/WlxPzr7EfS9Jb8N173q5zHRPpBIqaYEjYn4g0+fSW9WVkrbzWcMb6JtiMnCx5leg/FSYlMGUWIXqqwk6Q9H800ZS1FDdIjw1x2Jp34GG7olA5UgDbO56xtSS2flBQIqGQJG5pzcZcicAZv0FtHlDuwJbAP9MwTHDUBVN6NzMyYvGwPsYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZbapgb5lAp681rG5rBcbNNx+DCPk6+p7IrWnDCjNkg=;
 b=LZkraRe7FWwwYsZ6KtI2A62v/DMAqIyITR8KOf7DT8xXfrJU/MNStAmyrzi2lm3VjjvkwLNK6VkuQJrdVpqnhlS/RSGS2Mzua4EjABUhHPIXZdd5gx4FxkMOwdDa0fmexsWMQcofPpZznOoR2CALYdxa7GW5FbOAtI9FgeRZSjohphlW4XLyJvz0BxoDOZBSwUznFVfonJvYjsxcRwoyVgXSNBajH6JfWAHItWa8dvzNQK5NH6ciN321BtCE+g5a7ILGLwfSTZQIePEHB3XyStlayyzRBPZ4Emb48xK2oE4iniThkgB/CpJXuARzwRG5QsiXtJFrrOFUJ0HMqqD7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZbapgb5lAp681rG5rBcbNNx+DCPk6+p7IrWnDCjNkg=;
 b=GB9gvuIoFlUDb+rxB8tk/LuhXoPjqY4FOcdvWeXvqn1Sl0rDawXdzdlJ8FBu3jZIzPeCKLUgijNNrp3bcK/SwsG6p18PR3ZgFdr7E3Qc5K9+YAhT2VZ9acQCnV9+TRoCQS0w5dbJqtkxbdF7bgyTcietn4XfJt4RYrTwBrTtuWMrT2kXarnIVLhbBfWYweMdo2vV8Kvq2yG7P5nvW9c21Jd33WvRE+DCcysagjDBcf+3TEGnHtweliY5aS5Nj0/3PmGcP2fKKfEgpS84/ct4hiG0PkmVBh9Yd577iW1Sxuzb++nr0Nmqt2jlw8Td2pf5fJqGCJArynTY77Hs2c7W3w==
Received: from DU6P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::6) by
 DU4PR10MB9072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.17; Fri, 25 Oct 2024 10:32:58 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::5) by DU6P191CA0018.outlook.office365.com
 (2603:10a6:10:540::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 10:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 10:32:56 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 12:32:38 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 12:32:38 +0200
Message-ID: <553bfc07-179e-4ca9-99ac-74b90badb6b0@de.bosch.com>
Date: Fri, 25 Oct 2024 12:32:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] samples: rust: add Rust platform sample driver
To: Rob Herring <robh@kernel.org>, Danilo Krummrich <dakr@kernel.org>
CC: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <bhelgaas@google.com>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
	<tmgross@umich.edu>, <a.hindborg@samsung.com>, <aliceryhl@google.com>,
	<airlied@gmail.com>, <fujita.tomonori@gmail.com>, <lina@asahilina.net>,
	<pstanner@redhat.com>, <ajanulgu@redhat.com>, <lyude@redhat.com>,
	<daniel.almeida@collabora.com>, <saravanak@google.com>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-17-dakr@kernel.org>
 <20241023000408.GC1848992-robh@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241023000408.GC1848992-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0A:EE_|DU4PR10MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba8ac28-2b21-4430-fab7-08dcf4e06422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0hiVDhhRFUyb1diZTR3WXloeDhtK0hueGdOY3pvTDVvU3kzcU5hUTdHeGhm?=
 =?utf-8?B?dkRLSG9YV3NyRnNvOEJSWGJYRW13dlVJS2V1cERZU3Vnc1phZDN6d2x5a092?=
 =?utf-8?B?Y0FoZ0d3ZHdsSUVXK3ZIVURFVlJpYUhlNFRZMWJsUEpuNXpYcFViWllFUEFa?=
 =?utf-8?B?U1BXejFrc09yV0MyTWxBWGdHaHZId1Z6MUk3WDJQUU9xeFQ0bjE3UXh3UDlF?=
 =?utf-8?B?NFVERGtyZUZZbWpqbHBHTDg1TEkxVDI3K1BLSERJU2FsbjE5VXRyT1pDUzYr?=
 =?utf-8?B?VERhcUV4a2c0VGpZa3JTS282Q1VSb0pOMGJ3Q3BEV2tIWG0wdkZPUFdPa3V1?=
 =?utf-8?B?RDRoZlV5eTJJMEN4bVZNd3M2VEtzY1JIeW0zclpKVUZmYUFxL3cwU0djWU10?=
 =?utf-8?B?amgyb1lZSWYrL3JNb2hwTGJJRElJamZ1YTlQWnNjamhGVGJmVXovTUZZcG4v?=
 =?utf-8?B?dVdTRlR6UkZoaVpPSUV2UkQvYmRGbGpPMFdSa08vTnlydHA1UVZRRUVxSjZZ?=
 =?utf-8?B?TXY3YlU0UzJjWVRQZlNUNktLSW02dU9kYWcxVXdiRGxpWUo3NHRDdUp0ZlFq?=
 =?utf-8?B?VG5BZlhUdHVZWk9SWjlnYWRGYXRuQ3FCdEhaaEJSekhlKzg3VnFjQzRVSHA2?=
 =?utf-8?B?MzRXbndJcXN3eFVYcWpiVDNrVjRSdFVObUxqUnpMUEZyY2dtemRHVHhNUkZX?=
 =?utf-8?B?Vjc0K0gzdUlwMVBNRDJPQXZ3dDJDNHgrU3B3UHNobmg2VFFiSHZsZlVKdDBL?=
 =?utf-8?B?eGZBdHZlQWp1Ry93TmprZGlyVGMyNnV0eDk4a1g5cjh1UXNHaXJZY1FZVWdX?=
 =?utf-8?B?MWsyRURMM3lTZVlwS0k1N3ZrT0QzSDZKSXQwbGN2cSs2NTlNZTJ4NDlsWWhF?=
 =?utf-8?B?QXV6MDEvZG00ajd6MFRXN3pPbVR2RUtEZXAvSTFWcDZpZ3pDSjdxdk95d1lh?=
 =?utf-8?B?WXdFWlN2Zk9pcTMyK2trTXpRcEw0RFgwWGdQb0dBN0d6alJCem9XMXJtSXgr?=
 =?utf-8?B?endQemkrZ2E5Z2R1TE96S2RpVWxKbkVEdGFsMFZpdjN1M3dZUnhqZ2JZb3k0?=
 =?utf-8?B?YVVSdDZaa2dtV0Q3THBsa1ZPL3lxdWUzQlUyWVZJQ3VKWGFRTFFSckxJbHZL?=
 =?utf-8?B?MDE1Lzl2YlVEcTYyWVVZZm5ZV0JrSm9qQW1YdGVoRnRXNWYzUjJkTDhJYzN4?=
 =?utf-8?B?UWJJSXR1SGErb3JvY3FIZlNUcHBPUkwzN0dCZ0ZxSmNaUUY0eVBxRFFmK3hs?=
 =?utf-8?B?K0VpSlNCM3RqUU14cW5FSWhmNy94QnhPRmcyYWxsMjM4cWVWbThJMnk1TWM5?=
 =?utf-8?B?YUxZSmJwajhPWElUTTRTbmhNb0FzRUQ3QTFhdFM1WitoVjJCOFZOcFh6U3hS?=
 =?utf-8?B?SnBOS3BNZG9KdmRCei9MRi9wWkVVdmdMYm9jdXBTeThEeWcxQjVQMWQ2WXVz?=
 =?utf-8?B?OWlsdjZBT2hzODVXcVdMMkcxQlQvNFM1NGpoMmlHeEdDS0ZuaDdEcTZaVWlS?=
 =?utf-8?B?Y3JCMEU3V0U4L1BnVko3c0hzQmxoQ3hiNFNodE9vcDlRVmFLQzVLMG9wL0J1?=
 =?utf-8?B?VlhDT05xSWxCQUpPOXRIeWhYY1pNTWtqN2hTd3dLNzB4UzU4c09tbFZxZHh4?=
 =?utf-8?B?UitDT2JFdWlNcVFMS1lKdXBhaW5MRDhPSlkzU2IvK3lNQ3RuTG5ING9pb29j?=
 =?utf-8?B?a3hQYm13anIvcVMyaWZ0TG0yV0trdHRqMmZDQzFha3VFaWY3SzdoOEFzQTBL?=
 =?utf-8?B?Mlg1cmltZnlndjFwZEdxRmE2NW4wOThuS3JES3JxOUNFbVZTbE5GQXA2VEJk?=
 =?utf-8?B?YTJGOE9WSUNRVzNRb0FMOUR4ZThQaHkxS25GN1lxL2hUZjRSeS9iSUF6dWV4?=
 =?utf-8?B?bXJWODhrYWxJZU96dE8vaThkZGxWUXpyaGxSbHkyS0gweFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:32:56.8695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba8ac28-2b21-4430-fab7-08dcf4e06422
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9072

On 23.10.2024 02:04, Rob Herring wrote:
> On Tue, Oct 22, 2024 at 11:31:53PM +0200, Danilo Krummrich wrote:
>> Add a sample Rust platform driver illustrating the usage of the platform
>> bus abstractions.
>>
>> This driver probes through either a match of device / driver name or a
>> match within the OF ID table.
> 
> I know if rust compiles it works, but how does one actually use/test
> this? (I know ways, but I might be in the minority. :) )
> 
> The DT unittests already define test platform devices. I'd be happy to
> add a device node there. Then you don't have to muck with the DT on some
> device and it even works on x86 or UML.

Assuming being on x86, having CONFIG_OF and CONFIG_OF_UNITTEST enabled, 
seeing the ### dt-test ### running nicely at kernel startup and seeing 
the compiled in test device tree under /proc/device-tree:

Would using a compatible from the test device tree (e.g. "test-device") 
in the Rust Platform driver sample [1] let the probe() of that driver 
sample run?

Or is this a wrong/not sufficient understanding?

I tried that, without success ;)

Best regards

Dirk

--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -15,7 +15,7 @@ struct SampleDriver {
      SAMPLE_MODULE_OF_TABLE,
      <SampleDriver as platform::Driver>::IdInfo,
      [(
-        of::DeviceId::new(c_str!("redhat,rust-sample-platform-driver")),
+        of::DeviceId::new(c_str!("test-device")),
          Info(42)
      )]
  );

