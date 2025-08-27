Return-Path: <linux-pci+bounces-34907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85241B37F76
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E0B2085E2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E82EB86B;
	Wed, 27 Aug 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HjSv8Ck9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961191E1E1C;
	Wed, 27 Aug 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289083; cv=fail; b=Ox4OG4t9eIV30e8J2tFMfOb06oQ3j2bhzVMUUge845/5HaOhPdMeHDr0nJ8aqbK+n5dynQdpg430eRj5A+/IE8ylMRGAccoIXB4xm2KxI++Qqxjz0wF/IxTggUfQaYXny7c91jWE0+l89K1INbWdFI8o67pBJdrwvFXz9Eu8qys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289083; c=relaxed/simple;
	bh=Kc1q/wtYMSZP0x4Wpzp2LgECS98ORFziOCwgZxb9z0s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CuGzgH9fwUDiLIvdbVEq8V2jPR2+X3ykYwhoagGIvKaymSVioMjW5GqI1b5ScOev4AtTUtgsW+3H47wVPJgT2E9dEdflpdlgkAguuJhIlalb6PMZ3gXYHDxvIuUTeUhT8xylV8cInabZ095/NvLZyondAQ4ZVRUdBVURDoYW/vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HjSv8Ck9; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYJ8vhYSCBrtyIYp4/9rDR0yGvjFDx9PfyHwtJAbu4bw3zKUPpDQR61CVFlAmfP7z/mephGXi4q1sYFQzPmQr2xmnz3w6GUcPzPQ9UrgpSACs07V8jeVt7Qtwm+V69i3trb2r2JnQkYw+vPmbxEiYyb8Y1wHrztUShGx/1v4JIJ8xXlWyAr6eyJayKhxAXNchPdHoCVzXaMM4As+hB5fD6hwZjQjKY+uGKDEeQS477WO3a6Z93nPnM3O+TAuhIz26mAL7zmU+uBaKZZGQmCpRUtrzpMu0KvEOkexc1Gc/1IICPT//6i/a3fHa3ulk24sMR34LUNwSCzAS/BoCKq8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpgeVZUc0szRudRslnKObVKOaJXC9mIANnYSWqtmv08=;
 b=oefesItI82/7qauSYgVshBaLJBcQwsdj85pyH7/PpYG/V//l9QDoPyDDZxaByWyQ8u/7QN+z2atdXMbrT8v7i/IEn5Lt4ylv6vuhvwvID70g3I8vVik8y5uUSDKG7I9XVJfGMsiPTt78rQCK1DEqBsAa0igAxitrT2HI7YFMKaJ1bTMkF87MAhznhY+AnaPOFxecymZHGD1pTJyJY2BKSN4poGvOPUvSxtH7j3qJlCbMhSrVocdK/0RGfsDbSf15ti5Tz3AHf1ywT/zXJ/O/tygNQsUIncIPfcYTmA8tge3bwgpzHYOAWKnmYZDWOXHV8fQptjAw1AwjJ4HzLHD9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpgeVZUc0szRudRslnKObVKOaJXC9mIANnYSWqtmv08=;
 b=HjSv8Ck9uWv/wZ9FBhrnhuHaQ3HUuoC0mACIBOiv5eZr7reQP1X6MlFRLTZDEsIAmXWA3MDbV6vqY2bQDU0veKGh337KWA+pAuDjHn+hTcLFYHKPhsz4JMwXlNKWpcxMl8uRrT3JAZ3Jt7wpvUAgXp4XKY6d9BjJJl3qgFmhMPeQE/pJ/CeMy7TK0VQrOSXmI23dppvZFL5n5YLpJbh0u+fZhSfuLZQOuD8ijupktmukkhHpNS4x1K0ZF0+3PDP9W1OGHl+guj7Jz/lvGVdp/FpOwK4qqKZY7IVaF2CiQ8eTJacZnqj1lB4RtmiGhLqRVBADOaHCmeYafyPC3cWvYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Wed, 27 Aug 2025 10:04:39 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 10:04:38 +0000
Message-ID: <f84dd20d-8bae-4065-8b7e-9a0ea60e6b88@nvidia.com>
Date: Wed, 27 Aug 2025 11:04:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
To: Inochi Amaoto <inochiama@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Anders Roxell <anders.roxell@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Longbin Li <looong.bin@gmail.com>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250827062911.203106-1-inochiama@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250827062911.203106-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0208.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db536e7-f3cb-4ee8-f19b-08dde551223c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjBGVC8zbStKdW9MbnZ3QlVHN2ZjVFZaeGlWZElyc1NhVEIzem5ja1lpTjYv?=
 =?utf-8?B?SExvVTNubG5Mbk4ydG82YUdkY1hyeXZua0dMWmdqZ2tVdllEOCtCYi9qVDgv?=
 =?utf-8?B?Ly95UXhJZXpkQ24xNFNwWmhqRktqUzRJRlhIY01DMDJLVmVTQ1JQMEFuUExa?=
 =?utf-8?B?ZFZCQlpwRy95SEU4alNPNzduYzJoSTkyS2RzcmIwZ0tDYkt6OEV0eUNuQVNl?=
 =?utf-8?B?V1BFUzg0SkpWdVBxQ01mSGlFdUZPVU92Vm1jMUtEeWFiMThBTTN6d2hSMyti?=
 =?utf-8?B?MFJHK2N2dTF3RlBFL0lNem1nZStDdWFQK2RyLzVZTUVPM3NJTHRMSjRIeGpz?=
 =?utf-8?B?QUZYdU9aa0dnTXlJRy93bnc4ZHNzTUM5SGlQMzJXMXZ1Yi94QVh3czJReWFK?=
 =?utf-8?B?Zm0wWFIrbFJqRitVcDV4czZRRlQvV0ZSeUk4YXJIdEdqQTA5TFhhYk4vUnBW?=
 =?utf-8?B?ZzVPTlEwOThJWVNnelM1NThNemVKSUhBcTRQUXJhb01sNE5DWDdSditMS3p0?=
 =?utf-8?B?SVIzc1JucmZCK1dGcjNxTmlyWjVCZkZ3dTNaQ0hZcDl5V1FXMFhDWkxWL09q?=
 =?utf-8?B?NzJBL0tpQnVzaFFOWTc1NEZ1QU9XbkpuZWtGVFdRbTJnNWhiSExIM2twNkVk?=
 =?utf-8?B?L1VzbEd6SW1BRjhaOS9LV1c4WUwwTUo1dWIxdnYzNUo2NG5kYVVsTkltQUpK?=
 =?utf-8?B?TWYybzRJY0ZBVW1KczhqdFFOekp5VllPOEZyTVk4MmZ2RTlJOS9qeENWK0hK?=
 =?utf-8?B?VTROZExNZlo3eUgyOWFCdmloQ0lTSm13NUxoTW9RbCs2UVRCK05ibllvUHkv?=
 =?utf-8?B?Nlpkd3ZaWEFXSmUzQ2hIQ0E2czQ4TlRObzdOR2NMMzJUOW5FM0RnZU55Ni9r?=
 =?utf-8?B?T0toWVFmelhma2JMZUh3bmhmclphVmMxbXdnUm5zVTFsbytyTFE3K01QRXor?=
 =?utf-8?B?NXNmMk5OSHE3VFh6cDk0UHFzWEx5Y1BaY2VMclhjMjczYVdXazhabEE2SlFI?=
 =?utf-8?B?bTJVeFRvMDZWakttVUpid3NaTGlQSTcxRG9iQ2lQNmJWa1EzeTRkTzRwZUdv?=
 =?utf-8?B?ajVTWWY1ZUFaY2FhL2svNmlqQ21sZjYxRlhzbW9sVEhEdzRCREhPcHRaNE1x?=
 =?utf-8?B?ZWxFNnovV1poNnVXVnFiQU5JYjRHT0l5TCtxcHF1YXpvSldINFNRM09hRlpk?=
 =?utf-8?B?Mkg5Yk82M0loMHZnZWdpOXhCSndkUHpsN2JWQ1hwdy9iWWxRUnRCcWlLWFNW?=
 =?utf-8?B?cFlUd0hYaS9KdGRXeVJMZ1J0SE8zb2h1allHMCtMOTNvS21xSmljeWVFSE9u?=
 =?utf-8?B?NEJiQzU3cnFNejM1TEdwK2dzdU5DYjk3T1RyYlNxYXRTQ3M4YnVDRWtKV0x1?=
 =?utf-8?B?dGRtemhJU1V1S3NYNmhUKzluZE9VSXB3Q2ROY1pXaDRiaEhQc05tMVFieWlh?=
 =?utf-8?B?aXEwWjUwRjZCOXVZQzJVVjl2MDgzSUZtaVlRNjVsSFd4V3prTHRWYk1aU283?=
 =?utf-8?B?TUgyUThuVENFV3FCS3RCNGRsMUttTTUwSEJJZHhoaFlNNDZWRTdXZlRYVVBO?=
 =?utf-8?B?bkxweENvRzNkRXNDMi91RjdxZzgyTzIvcVF5dEUrNFdFcncvQUR4ZHFUenA0?=
 =?utf-8?B?R0VLcXR6Q0s4dndON1FOd1YwMHhQTTdWTDZqQ0Jlam9wRWRwWTNHeFh5ZVIz?=
 =?utf-8?B?KzI2UGhpRzF1dTQrQzcwSnNxS0grSTJqcjdXeXBxYUc5b1M3R3RnTDRJUmp6?=
 =?utf-8?B?d2laUzYrRzN6U0pwQXhTWjR5K3I3S3dSR3FJTHFLTUEzQlc3VnZPYUNBZzRR?=
 =?utf-8?B?VnlOdzcwWmlWV2RLazVZWnBRRFBlVUV6MElwbUwvN29DeXUvTU9HYkNGV3dy?=
 =?utf-8?B?S1lPUHIzbEg4amxieFF6QWN6N0VrRUJBOGc1bEU0bkptRWpRVkJLZFJEYWtp?=
 =?utf-8?Q?2KrBUJhjY5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0FHeUpGN3JNekV6RnBXemZ0N1dCZ3FHRUkyeEZTQWs5UWthQnI2aXUwVTFw?=
 =?utf-8?B?OW16U0FHNzNOeFFXSWV5V3AwN1FORmVMb3VoVTVSVk5OTjY2bmxpTFZLT3d3?=
 =?utf-8?B?UmhUMWdQYzc5b0MwcExxOExHV3pxc2FaUGFhN2pCSm5Uek8wN0t2TDJ1cWlT?=
 =?utf-8?B?bHVxblFjeEVQUjNEdStKbkVrNUlPY3ZwUU1zZkRhTnhJQmJrR3M4L2pXWjBQ?=
 =?utf-8?B?aG9DbXZSTlNFanhNUWxkd3dZRkIzMm1hanZjeXgvZWR4Q1RMTGQ3V2dtYnJV?=
 =?utf-8?B?ZkxhcG1JVlh0cEtmRVBDRU1TWk83RGIzZlJ1aUl4UmJMei9JT2wyQmNyUUVm?=
 =?utf-8?B?NGZtTStNNGo1eTNoZHh6SlRZNThGbjZZK2JiRnNkRWpOYUg5cVMyOGVUL0d1?=
 =?utf-8?B?OThGaFJnL21LbTRqOUhnMWdYeFFvR1N6WUpWUFU5bm5RTVNhMDFaRFlZQVRK?=
 =?utf-8?B?cHVKQlpWbm45a1FhSHE3MmtLYktCYktjT3h0WWNCS2NIQlVaVEZYbUtLMUds?=
 =?utf-8?B?a2Eya28zREVSMzhmTE52dzZHY2hYNzNOejdZdmJvRDlxbHFZNDNma0ZSRFl1?=
 =?utf-8?B?dWYyRjZxWEdMS0V5TFpoZmtDL2dQSnp5Sjg5NXp6Y3NCK0tGTXdrbVhRSklo?=
 =?utf-8?B?RHdLZVJqSWdyZ0hNVWRlUjNpTFkrQ2N0REhQVG9GeGVKWFJHR08vSDZXM3ZC?=
 =?utf-8?B?SXdNZXl6SHA1azZRcTlQT2lJVFA1SDhtNGNvOVFBQWRhRktvdUdXSXd3aWZn?=
 =?utf-8?B?UlI0TGYwdy9HOFdKTVRRSDUzNDFEdXNFdWRhb2dCRURNTnU4QjJoVFJCRU1Z?=
 =?utf-8?B?U2RHbEVpUThNWGk5VVByK0puYWY3L01UQjYyRlhXcmxtRFJXQnFWenlzblk3?=
 =?utf-8?B?b1NDQW95Z2FtMG9pS1Z2anNjNXBBOW5hT0ZZOFNJaHlVeGJ3TDhYQVV6cmpQ?=
 =?utf-8?B?TGxjNWc3blUxbDNRNDk1YmFVVUh4cXVMMW9LZEdNV2Zjb2JkdDNGZ05NYXJI?=
 =?utf-8?B?azZ3dFNhb1YxdVZORGk0UDRxeHcyV1VUYWhvVWJkU3RaZmtTWk1YWHN2UUlW?=
 =?utf-8?B?cm91TnhxZ2NQcmwwQ0ZXSVdZaXlzTFlPS3JrYTA0eUVhU0ZSTzQwSGRBcEht?=
 =?utf-8?B?MHY5aHppZzBUU2d6WXZuV2hIRTVNTWlpQkZTNWZyWDE1QWVCNGlpSUQ3ZFdo?=
 =?utf-8?B?TWJjTjVNN0hWSHRGOEV1RDlXRUx5QWppenhGZ094RVdxakwwRFlVQWEybFdh?=
 =?utf-8?B?cDZUWlV5M2ExTzdweVBleEhJVE5RVjBTMDV2N0hTZFR1aGduVy9mWTNWS3dv?=
 =?utf-8?B?NysrcjhlMkZmUTNqaHFtdGdUNms5WU5SOSs4Tk44ZkwzeDJSN0UyNzk3eDBn?=
 =?utf-8?B?VUtSckxYM2VnMWMyZUJKNk1jMG1TdTVpbU85NmlxZ1N1MWJ4T3JpN1ZNeFY2?=
 =?utf-8?B?WllBcDRWWWZHT2J4SkRXUE1QRjJtbFVJRVFWV0dCdHZYUFhiZTlESzduakcz?=
 =?utf-8?B?eHlQaU9kWXZnRTdEU1J0TlZCY3h6bzdTTmVoeG96VnpKb29DNkx3b1VNMzl6?=
 =?utf-8?B?Q2puZE9Uc3VxdGw5ZlBqTjRTOTZOc04yQ3BoNHQrNEFpL0Q0K0VVSDJkbFJB?=
 =?utf-8?B?aWNLTzd1SENPZGZlU00xWTliYjRWNk53QmorWTQ4K2hBWUtxN0wzMWFjUFd6?=
 =?utf-8?B?T2tpUVBlRHJkVTlPYjl5b3NYV1ErVnZEYzBQbmpETU1hQmVaUkowNWd1SU5I?=
 =?utf-8?B?MmpuVmhxc1E3MVkxQlBFYWg0RC9aaGxES2VKeXhHb0ovbEpYeXA1YlFuY1VP?=
 =?utf-8?B?cUIxZllYMWxLNWU4Mk1HdVY4VlVBUUIzOTZRZCtCWE1CbW9SVFQ2b0pRTnBD?=
 =?utf-8?B?L3IzWjNaYWZnMkdhNzExYVJ1dmRCWDdPeHBZSURsRGZvR3hMS0RRVE5BN0FV?=
 =?utf-8?B?RE9LTUZaZm9nUTVCTlNMeUZUbUVmalp2SVpYcmlyRnd5dTc3cEVrbmxQM0Yx?=
 =?utf-8?B?NlVHWFpranJybGFoT1JPam9yNng4aU84d1UzbmxRN0IvMzNtZjNOYUxMY3JW?=
 =?utf-8?B?TTJqWlljUTI3ZWQrR1BJcFZVTXNmT2pBUFBuQ3BGNWg4dUgzdnNKNmFtbGlE?=
 =?utf-8?B?NzdsbWd1dXNDWlg0bFNvM3gzbmVmckxJV3pqZUZsdVR1TWsyRGxCVkdnRlhz?=
 =?utf-8?B?eVpwZ2kyK3FvcEdRRXhuNDJoeGwyNXV5Titab0JGYzdxYUlUak9DejZyNzlH?=
 =?utf-8?B?RlJZdU5VcW1rU3BTQzByeEV0bER3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db536e7-f3cb-4ee8-f19b-08dde551223c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 10:04:38.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVfsXzmUOZLJWBllHSXZBdd6LDiGr843R4S7djbhJB1qQ5uwngRqETs62WBhl/lXQaluIkcQN0fne+V9Rdm6CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963


On 27/08/2025 07:29, Inochi Amaoto wrote:
> For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> the newly added callback irq_startup() and irq_shutdown() for
> pci_msi[x]_templete will not unmask/mask the interrupt when startup/
> shutdown the interrupt. This will prevent the interrupt from being
> enabled/disabled normally.
> 
> Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> cond_[startup|shutdown]_parent(). So the interrupt can be normally
> unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
> 
> Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/pci/msi/irqdomain.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index e0a800f918e8..b11b7f63f0d6 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)
> 
>   	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
>   		irq_chip_shutdown_parent(data);
> +	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_mask_parent(data);
>   }
> 
>   static unsigned int cond_startup_parent(struct irq_data *data)
> @@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *data)
> 
>   	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
>   		return irq_chip_startup_parent(data);
> +	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_unmask_parent(data);
> +
>   	return 0;
>   }


FWIW, this also fixes a boot regression for Tegra124 Jetson TK1.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


