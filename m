Return-Path: <linux-pci+bounces-38030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8ACBD8CFD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 12:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082FC1922661
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522CD2FB629;
	Tue, 14 Oct 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TIG4x3wj"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B802E3B03;
	Tue, 14 Oct 2025 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439056; cv=fail; b=ofKyBYrf0UKZSFxilmn7VQHKRNIleYpZpCHg+Xc3Ogs0r6EXLIPvUC+kjEqC0CkCX3uYAaPZ+b6huT8Na7aWb0JOguDSS/xiJxf9mUTkk4nO8IedLlsVFdw986q+iuZaEe0cLrNIclNL/ox8W6tOzhFG7oGv2hQGW3rZTmUx08A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439056; c=relaxed/simple;
	bh=8m8Wm4/v6+EnXFjX4KuFuTGdLYzcJmOUeElcmOYnMXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TwSYuhhuekXtm0ZCmoHFT9AbzoQsonL6NWzQDMO1GtgNhCLbNlpsHEB9hm/wN184+cgt4PKDAMtXGJdU7NN8a6EgZACTNeIqgwB91ZdN9OAFUNXITwbif69i8KzOVGxl9m8nG2qQ+BrQeX5zGKx791gXTiyF+NkPn2F7tZ88MTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TIG4x3wj; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR9eeySjie7Ov++hJlk+hi3trsdITCvmXW6EHUWOO5eYnVDHGzeiy3ZR6IXXFWAypRPBnDNZf3NLJ1HN4Cus8KU6SMOx5kKsDoo2vbuPGzl0TghV5gfS73hI8w7ipeEZQpjId3uA0wDoImGpCaYEIz02bbsgwTFKmKYqfxhr3SxgP6Q6rOCvrcyQ5RzukukePHpEdfp5igL/6kFNzdmpAlfwzlIJKzMQm27P5ZCH3gtUfVwhgm7+qk6fmt1IgEjQ+r0jrPkFeFf0e6+VQGysWSNN3y5gX+0w0ZePG4MaImWPtoSTn8Rq+8RM1Z0pahiu64vQBWdFYl/mUOlMUFvH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blA2DTrGVdCyZIg8yrxBh13OprQ96S+2FeyBfMKLq8o=;
 b=kKGXwqKT1hhTX+H76ghZmNRc9bk9A5VQol1nANl2KeIxiy6TOWUqCeU4KlRYJm775v4hfo6wDDipxOxr6YQB/OQguJYI8XquP+qkSYf6b9s767LW+WnNC0GQ0Zqpw3O4YocV/LFKqsytySmt7sDXkbBcKW42ljuY4NaQdcVsEVFba4pV/U+WOnBMG0exYTKUD7Za8UpSCOEIuva2TFKaaFvy3Kp3PazlSq3qcW+9+ZLV8eeOSO+FJKq5ufo4QGS1GUDKD6BzJQkr3gQ4Gzpe/7HJiT86HI4LkcrAlkKhqEwD6brpWxEwai5Z6hljBmlGQzNzVqUDsyHRlqnPZrmxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blA2DTrGVdCyZIg8yrxBh13OprQ96S+2FeyBfMKLq8o=;
 b=TIG4x3wjSlnef/eMoPMFGNhair9nBhCRFqDNI8Vp2a5itjMvmdeudAbkpmemhxmMCoSLcUvLUB3bK29VJLn+8kh1V8PHUIIba1k67WRu6tyAY26VwV6x432lLRAkQbKt/g+ukJ2Mo469u4Wsq2GP6qRYY2T6k4xx3ogWBo3pNt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 10:50:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:50:49 +0000
Message-ID: <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
Date: Tue, 14 Oct 2025 12:50:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
To: Mario Limonciello <superm1@kernel.org>, Bert Karwatzki
 <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20251006120944.7880-1-spasswolf@web.de>
 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:208:236::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 754ea76c-5df0-4c98-90c2-08de0b0f89b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0RSeXhveE9KZlc1T2JqWGxQaStRUExkWVA5Yy95aWNEaDRuM2tuYnYrWUF1?=
 =?utf-8?B?bDVFNFZhU05xVFFnTW83cG44aUt5RU5aNFBSQ3Z2cFJFRWtIakpWYis0NmFL?=
 =?utf-8?B?cWZoQXVMcDJDdVRKT1A4anF2TjJUTlBteE1UNUJWVHhIZ1lZb0JEeDVzQ2s1?=
 =?utf-8?B?RkNyOFYwRjJlSFpyTHE4Z0t6QUpVYjZ5RS93Q1hLRmNwZkNGZVdGUEtmUmxJ?=
 =?utf-8?B?c2oyZzZ3UXVRcWIweVR6Q2lQTGM0QlAxclNmeVkwQ1ZyNE5VR2FzbmJ5YXE3?=
 =?utf-8?B?UWlMWUU4RjZVeDVhbXY0K1RkNFBpa3kyWWEwbktuN3YvSkZWVjR1U2FTZGtP?=
 =?utf-8?B?V0dnbXAzaFVjcmtmMWtLRkRxdXpzbnJON1dLVmZ2MkZSV1NHeUtRRzRaZmJX?=
 =?utf-8?B?TE43dHF1VWFPMW1zVVV2dXNreXVOeG8vS3N1dVZnOGZ5Sm9MSDh0VmZWVlIz?=
 =?utf-8?B?ZEoxdFJSLzFpSDhLMFRHVS9NVEliZGo0SG1JZWxmNm82VHo2a0NRajhpVDJ6?=
 =?utf-8?B?MGsvMlpUOEkwZCtXWmV1MmRJMStCZ2ZSSXpGam5hRUx1UlNuVDhxNFVDUEJI?=
 =?utf-8?B?cE03YlFRWVRDRjRqaFdPUlVWOFJmU2JzWkVWOUZzSTBMVTJvN2dCM3grV25J?=
 =?utf-8?B?dmY0enZaQmJSSlBqVkQxVjNDNUlIOUVvTmdEQkxURmljdWFzYWROTlY5ZFZX?=
 =?utf-8?B?NEMra255MEQwMCtVQlRqUVhpdXRkT0czZjF2WmhmTVdLUFNyVThCbmhhb0tz?=
 =?utf-8?B?NE9Eem4zRFdXczhGUXFBMUhGUGlTUXJpUlg5NDZSdTlHUjMxN0I2bStVNHFE?=
 =?utf-8?B?dFl2clFGVU5BVmtGemM3WmducmYzT2cxbll3MSszcmtZRS96bWpKUXFXZGdm?=
 =?utf-8?B?RVVGemoyQUNqUzZWMm5qSTB6bXY2Qm5uZkc5d2tYRFl6QStaYzdzbXRGNUE4?=
 =?utf-8?B?QmdkN1lGUEVOczFSb0RkZzNoVHhGUklpcWZ2Q3ZKMXdJZVhsUjRHSkROY0Zw?=
 =?utf-8?B?TGJpeXpBSjU5ZldVRkVqYlEzTlNVZ2RWV1ZDeG1USnlZd3A3MUZpU2Z1bGky?=
 =?utf-8?B?bjRSOVBMNTBHVDUrT2hVakt5elFJVnRncm9uN1FsQTBUc2c5L01LalFHSFMz?=
 =?utf-8?B?TXg4b0NLQjlmK2xCcFkwVUFCb01LbkNoSVJuWEhkOVRBcFdaQitLQkNManlx?=
 =?utf-8?B?dGQ4YmM4NXRPVG45NW0veWQ5bGNEODh3RHJoSkNNQ0MwNGxsMDVhM3BDMGw0?=
 =?utf-8?B?R1JwQ1NIa2Zjd0ZhalVZRDEvTjdiVlZ5QUNZdVp0NURCTmMydFJsck9CYm1D?=
 =?utf-8?B?eFo5MkRSUXZqVGVsRkNRL3ZNZHllWHdWT3h5cThoNXVCNlo0TlZNVzhPVk1u?=
 =?utf-8?B?Y3J1ZGJSU1B6NlJ0WWhmTTRua3VPZnJicXRzWTY2QTAxV2pWSVNNUlhMU0dZ?=
 =?utf-8?B?N3BpK2IwcFI0MmdZbWVqSEhJa21aZEZTRTVlZ21zUllDbGs3ajNtNUUwVTlR?=
 =?utf-8?B?dWpGRUwvQ08rdWVROFB3ckFiaWJjOEhrUnhvbXRGT0pYWk1FWHM5alVrWkNx?=
 =?utf-8?B?Um5nYXMrS1E5dFlIaDlwNTJaZHROMk5LK2VUeDhSejVncldLSlZXLzNHRmE1?=
 =?utf-8?B?VXRqZ2JjNk5IMmtRNENDL2srUGQ2VkI1R3NHeEZrWXFjVWp1b0Z5UU1rK044?=
 =?utf-8?B?N3VTZFJDUU1CTWlqSWt0Q2kxODU0OXZrRE5SdUxqb1hhdUIycTNRcFZ4Zktj?=
 =?utf-8?B?aW9lVHYzUXE0RWtBZ0ZsTzRNWTFrNU4xc2RtdDc3SzBaZnQyd3VzaCs2VHpP?=
 =?utf-8?B?YS95VTMzUW16QkM2dHFQaE4ybFA4OUdNV05yWDZld1NWUG5QdnpBVlV6N0ZQ?=
 =?utf-8?B?cndBV0phM3RLR2tQeGJZaysvRjBOVm4rVHZuMWZBc1FHNnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MCt0d2lqSXpxMnlMQmJqK3grMDRuQVluVWlHOU1rNWRZOTltejBYaTZwd3Q5?=
 =?utf-8?B?VGdSUDJpck42QkNLQU1vM1I0bndBQzdMMDVMNWRWdkVweHg3dEFTMDJudUt4?=
 =?utf-8?B?T0x5RWVZNXhLR1J1N3BxaWVhVmcrd29VcjR1S1hYRXd3NEZHOG1vaW1ZczFw?=
 =?utf-8?B?VWoxSm1hTm9CK1ZrcFV5cXRHbWRlVjVvMDkyVjl2Rzkrb1lxR2svYlRTOG9D?=
 =?utf-8?B?bzZKS24rOFQ0dVh1OGZNOUU0SmI3NVlGNWlMOTQ2T3hqUGx3ODVDVEthdElo?=
 =?utf-8?B?YVNRbmVJendxNFQ0UnhWUllQTXVSTm5nbUxKK1BWVjVKRG5RWVNJU0l5TGFP?=
 =?utf-8?B?QndaMXdKemFhajhNcCtiRWF6R3dWV2Jwb1BOT3BBK3NPNTlMcy9sdzBGYUtO?=
 =?utf-8?B?Mk04TE83dUV4V00wSFlrbWF6OWVFeXh3KytFdllLMmNUR2NnSXd6ZWVUQk8w?=
 =?utf-8?B?L2tMUEUwNEpkNUdzTERMOVFoNTY2b3NaZlYrcXZ4ejVPcWRjZGsvOEsyTlov?=
 =?utf-8?B?QkJhTU9HVjZ0S2hLdVlyWnBDMTY4Uml2dXBDM0VsbnZRY3k0WkpTZmxqUE10?=
 =?utf-8?B?OTRURzJDSHRzYkV1enpmM1hxQzBIK3NRakpXTHBrWXNQQWYzeXZYNDU4QVgw?=
 =?utf-8?B?L1ZQaDVrTDdqRGpNcG1NSUhjUHpiUU1kb216RVY1VVhRRW9oMndFWGdoUjht?=
 =?utf-8?B?VjNZV0NISGI5cGVPdVliQStQb1lOazZ4SHVaUjlIcU5Bc0dPWENCTVBEN3NN?=
 =?utf-8?B?WFZQaktLM0l0MlY5OHcraVZLb0xEdXFSczVKamF6NktGUkxpZ3VGc2JUd2c1?=
 =?utf-8?B?OXhxUHByckRIZWM0VVZDVTlvVkZDQ0JKemdLMXlQY1prR0VFek5ZOHg0Uyt4?=
 =?utf-8?B?eXVEdnZsRUJ3VnpWbWI5SGVyaHhtNGYzVkFVYVFFZ05iQTJ3N2F6alFscDJ1?=
 =?utf-8?B?ZGs0V2tOUGN2WFlrdGFHejE0MmR3dTZUL2JiR3dBNThnRmJvY2tXbEtyclNo?=
 =?utf-8?B?R1picmRnaXdIYkZXbUFZQUtHYno5bTdyWVNvWTBDK3E5T1V1N0FPY1VTR1BD?=
 =?utf-8?B?STI5ZHIwZUhjeVZQSWM1UWV6ZERhUzV1TVM5WkVWTkRtd2wxQUpXUVRhTzhR?=
 =?utf-8?B?MWx1SENGZktETzZmaUd5WXEvN1pqS1Q1c3Z5RkxIZU8rVzNtNlpuWk1TUHhV?=
 =?utf-8?B?aVdwYjFFaTZ4bUxEL0tGeXUvTGFIVnRlZHREa2V6UlppVGRNeWEyZFlEbDc0?=
 =?utf-8?B?ZWxKM3NISjhlanVybkNIWXgzdkJiZ1AvSWdZbWxPc01KU0U5M1RwQzRocm1G?=
 =?utf-8?B?NEk0WGs4OHpuYnBEVWpZYzRjOHJRcVFsd3BwUThOZDBJOHV6V0NJS2NzUmtW?=
 =?utf-8?B?elNscUlRdnBlaUV4UVQyMHIwUDdEMjZqUFJ3czlwRzlpbkVaajhvNjRUaElV?=
 =?utf-8?B?dGhmaUkrd2FLVnk1Q05Yd2p2KzZ3bktNOXJzZk1zV3o0Z2VwLzN0cDE3aUJr?=
 =?utf-8?B?dkRheTh3SnBnTkJIVi9iNGJ3M0hOMmpRVVF4SFk2aXNPOXFqMEJyeEgydGMx?=
 =?utf-8?B?OGNGQ2s5Q0NTbGxPU1JHOUFCaW4wSjRjbkd1eGhHMDBsc3M3TktwOVZNZTdP?=
 =?utf-8?B?MXBpSUxZVWczVG1XVXpjb0FBQnVRZ3JWZkFGR3dTQm1tMk53Y29zcXFOQ3ds?=
 =?utf-8?B?VEJYdUJ5M2xzVURBQkdiVGcyYnA0d1FITlVyMHJkc0dUbE44QTFNdHdweFZR?=
 =?utf-8?B?bDg3cUNSZGZON2tIK1laWFJRc1dNUEYwWGVWN0VQQ2g0cVY4bkJqRDdKelNL?=
 =?utf-8?B?UHI3QVpKUmlHam0waXRZenFsQ2dYTlBDWmpsR2xsZjhWN0gydUpTUk00NkRM?=
 =?utf-8?B?Mm9oVFhtZi82RXZJT0RqcU5DemxwZmNCdkd2YlgvZHdVbVBsQUpQQmF0bTJr?=
 =?utf-8?B?WnBhZlU1NkxuR3pMSVE0YlBqWVdtK0pHRWUySVpQbnM0b0VONWd4M2ZQY3A3?=
 =?utf-8?B?MzdUSzcwRitWcUdxbWN0eXN2eXZlSU5jMkVQejE4ODJzWDRCbmcxNWRuVGpR?=
 =?utf-8?B?NWxhMWRXQ3FmVnpOT2wvSlRUdE0xNzYwZkp2YUxqNldKR0VKdTZuNzY3cEMv?=
 =?utf-8?Q?uG59cItYnygy8RbfSKdyTCpEo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754ea76c-5df0-4c98-90c2-08de0b0f89b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:50:49.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dgy/a8FB0T5UE8/qle30TXhABDc2NMHEmqfU7qU1bMZdOch9HqiphoorAi9ZlvRR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279

On 13.10.25 20:51, Mario Limonciello wrote:
> On 10/13/25 11:29 AM, Bert Karwatzki wrote:
>> Am Dienstag, dem 07.10.2025 um 16:33 -0500 schrieb Mario Limonciello:
>>>
>>> Can you still reproduce with amd_iommu=off?
>>
>> Reproducing this is at all is very difficult, so I'll try to find the exact spot
>> where things break (i.e. when the pci bus breaks and no more message are transmitted
>> via netconsole) first. The current state of this search is that the crash occurs in
>> pci_pm_runtime_resume(), before pci_fixup_device() is called:
>>
> 
> One other (unfortunate) possibility is that the timing of this crash occurring is not deterministic.

Yeah, completely agree.

The exact spot where things break is actually pretty uninteresting I think. Background is that it is most likely not the spot which caused the issue.

Instead what happens is that something in the HW times out and you see a spontaneous reboot because of this.

I would rather try to narrow down which operation or combination of things is causing the issue.

Maybe also double check if runtime pm is actually working on the good kernel or if the issue might be that somebody fixed runtime pm and you are now seeing issues because you happen to have problematic HW which we need to add to the blacklist.

Regards,
Christian.

> 
> As an idea for debugging this issue, do you think maybe using kdumpst [1] might be helpful to get more information on the state during the crash?
> 
> Since NVME is missing you might need to boot off of USB or SD though so that kdumpst is able to save the vmcore out of RAM.
> 
> Link: https://blogs.igalia.com/gpiccoli/2024/07/presenting-kdumpst-or-how-to-collect-kernel-crash-logs-on-arch-linux/ [1]
>> static int pci_pm_runtime_resume(struct device *dev)
>> {
>>     struct pci_dev *pci_dev = to_pci_dev(dev);
>>     const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>>     pci_power_t prev_state = pci_dev->current_state;
>>     int error = 0;
>>     // dev_info(dev, "%s = %px\n", __func__, (void *) pci_pm_runtime_resume); // remove this so we don't get too much delay
>>                                           // This was still printed in the case of a crash
>>                                           // so the crash must happen below
>>
>>     /*
>>      * Restoring config space is necessary even if the device is not bound
>>      * to a driver because although we left it in D0, it may have gone to
>>      * D3cold when the bridge above it runtime suspended.
>>      */
>>     pci_pm_default_resume_early(pci_dev);
>>     if (!strcmp(dev_name(dev), "0000:00:01.1")) // This is the current test.
>>         dev_info(dev, "%s %d\n", __func__, __LINE__);
>>     pci_resume_ptm(pci_dev);
>>
>>     if (!pci_dev->driver)
>>         return 0;
>>
>>     //if (!strcmp(dev_name(dev), "0000:00:01.1"))         // This was not printed when 6.17.0-rc6-next-20250917-gpudebug-00036-g4f7b4067c9ce
>>     //    dev_info(dev, "%s %d\n", __func__, __LINE__); // crashed, so the crash must happen above
>>     pci_fixup_device(pci_fixup_resume_early, pci_dev);
>>     pci_pm_default_resume(pci_dev);
>>
>>     if (prev_state == PCI_D3cold)
>>         pci_pm_bridge_power_up_actions(pci_dev);
>>
>>     if (pm && pm->runtime_resume)
>>         error = pm->runtime_resume(dev);
>>
>>     return error;
>> }
>>
>>
>> Bert Karwatzki
> 


