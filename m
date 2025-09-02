Return-Path: <linux-pci+bounces-35298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 671C1B3F208
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 03:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B28E162437
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 01:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E540D1E47CA;
	Tue,  2 Sep 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OunAHW0E"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1E2765CF
	for <linux-pci@vger.kernel.org>; Tue,  2 Sep 2025 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756778070; cv=fail; b=Jg01+yNA/KTYFouaiTpSP9AdbLzkWQosNqdgkYtOng6t5M81w8JEhCZcvNgCQ9RV1DIhhjd8mrc5935vGIjDcjx8EmEUTaUnxzYghgXCRQ5BUwfhBksMN0ji4sK5/KXRDE1AEjwoJis78a6mfOD8k+CevGCCNB8HBvGU7RoJJXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756778070; c=relaxed/simple;
	bh=1mUqYAX2cK/O8R4hjz08lsf7o0CACRL9mhMo2i6u6dM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jC6iXq2HIJOrWZQQTMbXkou26l8ErrMZiiZtdEVP9WeWasSUutk9KtUygcpPGYb9sgeQZJWhD/YxdSNSF+ZHB/GaVBPTlA2sjnvYrY2cwn2yMdncvQX+N0d8WBbYeoGqsLWCY8/BIlrqNcx7nB72hiHFiA+5WxZdOAd03MXM7eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OunAHW0E; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYKfW0hEdzxR6NSkt43XHGJQPM/lgUQ3EWOiX1Md2ohHgTjYFJumjlUN4CkZWBtYlpcameezInCQwGpTYxYy5jmaaYrDFWaFWHSApsiOzGxeZnmvKLXxzB8xg1zdGO/iaR03NDw67udytbQgbtbkbdqGHlFzWdqmIrv5w6AakhFG1citXfElXtR43eq2hZ6amrf4L+FWqsQP3HRAFvBOxcy/zgB4bss8ll5MAUqutjxQmqo8ArGiJpXcasE8GyVhwJU61H1njAnGzA+nVcQEKM4az8CE7wJvMgVr35DtWU1p1XVIUgNdkVjuWdRK02KwhJayUZK3zqyBbMAsChV3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7Vn0L1t6mWex05YWacfeHPYwJllrnX0umLycz3gdjk=;
 b=Org/V/7adxqHYFzEieOYVn2wvoYkfCdS59Jj2EjUE5jjUxQM1gClOh1IvDU8vIAcL7ihxwJGm/TChs7aTsMGrmh39h9VL/PG4Q6ty6sbJtv3Cu3bZ9moYk5JWJRawO/QpZxADLK758kkZWMMhzl7Jf5VmJwr0m9fbEsctX77k4ad2rG9iCjyNr6vdy/SMUYeJl/1fEQTsJHxKx5wkQj0agrXwup7zZtLxHJ9OKkWkaxz1sw5XnD9/DHvND1xfhI7+gvlfsafN9muAp7Fmmr01gE7hpuYH+qXZcbxKNl5x4K5cZ+9WyT2GiCuYYxsA6TCrz1o9WXlwA5/033AZ34W0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7Vn0L1t6mWex05YWacfeHPYwJllrnX0umLycz3gdjk=;
 b=OunAHW0EfJyP+8yIxV2ZIWbFpOl6dPAMCvgRlstbKqRKy1rBBEcVW+pgfKTqCaaYV6Em7HjSc58IMHVaMQ+M5+WeurHdGuOdkzWb09qqhgesjyMj0laPLCxFyY58L5DBuHrxT1g8hPlUqG9ZOwe5zJkZ+kjJSQemb8QTVPbHzvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Tue, 2 Sep
 2025 01:54:25 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 01:54:25 +0000
Message-ID: <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
Date: Tue, 2 Sep 2025 11:54:18 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
From: Alexey Kardashevskiy <aik@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
Content-Language: en-US
In-Reply-To: <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY8P282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::6) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: e26521c3-5e64-4193-29a3-08dde9c3a49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YURPQTFWS1I4YmdhMnU1TVM3aDZ5cDRmUWZCVEkxWFRDVU5aVVp4U0dsSHRT?=
 =?utf-8?B?ckltdWYxOXZWSmhmWkp5S0lwV0dzSG1UVnJ5NXU4MWkremMxVnJHcG11VExw?=
 =?utf-8?B?NXhDNnJhdHlTM3dYK1NBVy9ENTd4OE5WaW9kWDdwbVVmcGhmMktQdXFWaUZ5?=
 =?utf-8?B?NG0xV0JlRGpteTdXN2dyS0VNdWdtU3oxR1ZJVjFMNG5WTkFBUDF4U1JIRldu?=
 =?utf-8?B?dmhBR01jRUgyZTFGNGJUd09rYWdhQTloZVNEVVIwZS9LTnhIYkRvR0dQajRa?=
 =?utf-8?B?eWJNc2x1cmFXL2pGZURFbUhVVHJsYUs1QU82MVJEU1o1QVEyejBLTGZ5NUdl?=
 =?utf-8?B?ODljaHN6NndtakNwQlJnV2cyd3dkeWxXbk1PTDdaK0F1R1gxNDFNT25iNHk2?=
 =?utf-8?B?RkhKYjhuRmNOd3lGdDNlVDVLQnZzODJiTHZJODgwSU5HaE41NFFNY1dIRXlF?=
 =?utf-8?B?SXNCeWRnbWc5TXJxWlpGY0QyTVk5bktQTTlpTWtqMTVaQ0o3U0dBc1JUcUtl?=
 =?utf-8?B?RkJUcjVEVWVFMTFjbmZFdkxDWGFWSEZMaHlLclNsWFoxYzl3VWNjcUppb0pD?=
 =?utf-8?B?OUZSbFRBNDZIdEswaG9KRDh4cktURlBzdDNkSkE5eitFVzlsR3ZQb0ltMlZL?=
 =?utf-8?B?YTdsaTFodDlFNWZ3QStRRzZPVHM3UUx0YmRmL1B2eS9DcStUNkJDcVF2WTBo?=
 =?utf-8?B?RDFCU3VWOXFZdDZWTWVqRjlNN3hsS2JrSGljMjlkMkhmQ2F1WFVHK1NZZ2JI?=
 =?utf-8?B?WURDVkxvck1rVkJXY1JjQ2VDc0lnNVlRRjNkU25OT25JczdtR1J5QWhNUG5E?=
 =?utf-8?B?dEVsMjI1RlZoM0xqSDVLZ1ZRQW50ZUg0RnRKWWl4SnFuNDNqMkhmanp6M3RY?=
 =?utf-8?B?WkZRL2tOd3ZOUmlNb3NIUHdzTGhQQ0hmQ1BPSzRMM3dlbVIvTldrRmcxRlA2?=
 =?utf-8?B?cm5lSXZ3YUdOYk92WnFMYzErZmpycEtUdEtlQlNXR2cxb2l0bzVEM0gwTjRN?=
 =?utf-8?B?aXlEOEpCVkpQVUliMTk1Wm4vNFRISzhIeWJPRHNwUXdEejVNY0JhY0M0Ullz?=
 =?utf-8?B?UFJHOWFtOU93dkhLOXl3TE44azdxRXlmQ3NNTEtRSXZqVWZiZFZsL2h0SFFx?=
 =?utf-8?B?UkFvS09vbHovd015eVpybjRhUHZBMndSYWVHTldZSVFnVk1BQUtrU0U4a1NZ?=
 =?utf-8?B?R0ZuTFU0REYrUzY2eVUwU3ZzRmVuWkgvbVBZUjdpS0d0RTdnVkxVOTNiR3hh?=
 =?utf-8?B?OHV6THgwbVAyNnQ0ck1DMm41MDlSNWIwVTNYVDBwMkFTdjAvQ2xscy9qcVJN?=
 =?utf-8?B?Qm84SklyY3piMlRFOUNnQmhpajI2U0ZzSHFMZGxNMnZtNWI5WTl6VG0yRjVB?=
 =?utf-8?B?NCs5MSt6dmpuTU0ycjNqMVFUR1E2aUQrNDF6N25WeVRMT1E2RlNNZU5nMXdl?=
 =?utf-8?B?eXRpQmdCZjhKb0hyUDZSTVJQQ0dVbEEyaWVkVGtrSXgrek1tZi9DbDBHTUUw?=
 =?utf-8?B?QUNEQnRpSHIvRlFMUExPeDJwSkM1QkF6WGoyMUh5V2l3amNRNitQQkp4YTg0?=
 =?utf-8?B?ZVl3QXRkVDVDSmtxWE40ZkI5ZFB5S1pvenVHMys1VWN3NXcwYjdrL1lza1FH?=
 =?utf-8?B?b0lhY3JhanFVaGlHV0cwZWlZWW9BQm9GTmpKRnQxRUZXcHp1UkFMeHdZWURu?=
 =?utf-8?B?cExnbUQ1TGhJbUNNNGNyZlIvbU1CbmZUYi85OVd4ZEFLZU5SUkg1NUlYdmt5?=
 =?utf-8?B?RVBVTWZuejFzT2NOQVpzeXNqTU1uci80VWRmWEJzZ1JPZ3hVWnR3cXBYeU43?=
 =?utf-8?B?NmRGeHNIcjFOY2ZMZUVYUTQyRUZXWTZjeWxBaFNrVTVSQlpKL3VIbm5iMFN5?=
 =?utf-8?B?WVdFQitVWmtxcm8wYUhXbzE3RXRoWGljcHh1am01Z2JqNzhOVG9ac2sxVmdp?=
 =?utf-8?Q?ugZXYj6+/v8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVkzRVRrR3NaUmdhRm5wSlI4bXdiRVVJcHpCKytHTDFtbEhwQXhrR0lYWXNk?=
 =?utf-8?B?bXhpcm0zaFJPWTJLanBIZk5uSncycDFldDR6bXNscjBpZUhCbmFCN2M4a3h0?=
 =?utf-8?B?VDY4enF3cjA4WUdXd0ZuVkIxd2NYbjFmWjhKZ3NoRVAwT1N2NTY5cklMczVB?=
 =?utf-8?B?ZXB5NzJ0RTY3NzVId0FzVzFCb1FnYnIreHJnQlY2Wit6VCthdUZiS1VaRVVR?=
 =?utf-8?B?TnI2R3llR00xTmVObWhyelJyaHJ3NTBRcjlDVjZlZEVSY0N3WnEzaksvVTdh?=
 =?utf-8?B?eFVzOUZyeVE5Sm9ueUhUaEVDZ2RyQkhTMHJxa2MwNzAyOXpLU25xQ2VGditH?=
 =?utf-8?B?TDBWczVZbTVva2lKTW1Vc0tTTCtielo5QldrZWsvdUtUR2VEMWxyaXZEZDN2?=
 =?utf-8?B?dWw3S2tXNGtHV0VvdU92R2VDY3BOSit2SVJQaEhmR1NSc04xcDg2ZzR2NTEz?=
 =?utf-8?B?UFFjc0dHUnVCa3I1YWt2Z1k3UHlncmJidmJkcU9aRVNhUHNqTVVEWlpYa3ho?=
 =?utf-8?B?VDFHcnZOQ3JsNGpSWUljYm10WGp4bmFWWlM2TUFVbWhVK1huQVNWZEJENzB4?=
 =?utf-8?B?aHhFVVNaS0Y5YmJIdXVhTmtVQXk2L3c0dlp4bWQ5Vy9oUFlpa0tOZHAxa2Vp?=
 =?utf-8?B?N0FwVG9tN2hHaGc2SWhtcndtTnNxNDNhK2krMDdkRDBrb3dMMDBmcXIwOWdI?=
 =?utf-8?B?bU1wTWlEbkFkYkVwYkpUYjR4Wk1qY3JtbjZwMk1QUVh0T1ZIOEs1VVIwRVdL?=
 =?utf-8?B?TGx3Vlk1eXpqMHlYbVJJTG10VytDR29yUURHZ0VvbCtuN2NUNFJDYXhwK1Bp?=
 =?utf-8?B?aWpZWkVTYTgxdjhKSCtYV3k2QlRNeUdlbDAzaVdnTG5sVGpHaDVQV2ZMZDU0?=
 =?utf-8?B?b3lwdk1mcGI4TStjQzRxeGxSYTh4R1p0dzF2SlVZK0svZjJqOUYwcXBUSXJG?=
 =?utf-8?B?Y0xVNUNzVzFUbGJybmJOMWlxbnZ6STRqMDdBeXpSQjIzNWRMUWErc3phNkl5?=
 =?utf-8?B?eFVjVDB1Mlg0aXMyZSttV3VLMThEbGdlZDcwU0huV1F4N3hTTURabUxwanpV?=
 =?utf-8?B?akIvekhGUDcrUzJJa3EzVjdYS2oxLzdPN3BJMFJBOHI2NDZOd2V5NWdOemJ4?=
 =?utf-8?B?a2xPMnNmczQvWHE5Qkg3WW15RWpOTUZFVEhnYUxzaVNKSGNYSVIvVHRPZ0h5?=
 =?utf-8?B?UEpIZ0VERzZhOVJ6aXVuVmVQZ2pZZUgvWkZoT0xsdHhyeEFmS08wbTJzTFRz?=
 =?utf-8?B?c0xDN1VBc2ZpamFDMHJTc0dsR2VqLzR2bmNXVTJMZXpBdjRYdmZjTk5HVEw3?=
 =?utf-8?B?RHk5aElKMUtyMGRYc05sYThDMThKQkJ5K284bEFRZ3ZGdzJiWXJIWVk2ZTdC?=
 =?utf-8?B?WDl4QTJ0THV6Zm00dWxIQWVLV0p3eXRjVHhaNGw3Y3A1SFkzU1hUUVR0WmdL?=
 =?utf-8?B?QlZpK3paMVhkN0puSFdpVUhweCtpME13QXhuUjVrVDF5SmJZS0ZuTEdES1FX?=
 =?utf-8?B?M2RBcVRxZkdSOWNuWE5VZUppR2pDaHZ0OFlXekc5cnhZVWFxUEJpeDFSRGNx?=
 =?utf-8?B?Z3FiNHZpVFhRMHA0Z043ODUyS1Y1am01N3d1T3B5OE1MVVFrWVUwc25YaUd5?=
 =?utf-8?B?b01uT3RpTjZEZTNHZGxvbzMvK3N2dmNlb3VxUms4OVU4azI1bklKMUlSTDNO?=
 =?utf-8?B?Tm9RRkJsUnVHTmVKV0ZwYlBjdzdQTEhKby9IekJEdFFtUVF0Rjd3SkE4dXc2?=
 =?utf-8?B?ZWxLVDQ5MTRZelEyNG9oelhJc0kwSkhIbDdiaStvWDk1ZFYxcDEzdWdJclJZ?=
 =?utf-8?B?R09aSWZDT1lRL2NIejZ1MmZ5UkdzK0xFcUR3WktFYkhEWWtQSHBiWnVqSEVx?=
 =?utf-8?B?UVNwZ3lNZUlPZVFhSnA5VkhOR3h6STRkZG1jUk5zQWRjcWc1Vi9FRkVQTXN6?=
 =?utf-8?B?Tm5ZM1RqeVNMWnErSnR5Zi8yTU12WE9DTkNwN0RiYTFQTzRLbmp1WVJ4c0VY?=
 =?utf-8?B?TlloR2h3TjRaQnN0YS9BeDRKLytzVW5NNUxReGZMVytKRWJzaVhRTXhBR2d0?=
 =?utf-8?B?Zngya2dZQ3NUbEJFbS9lbXVGbms0SnlVUEJhclNCcUFmUFdJV3JRaDkyOS9n?=
 =?utf-8?Q?xWeiii3al1IHLqgp1fMMqS9G2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26521c3-5e64-4193-29a3-08dde9c3a49e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 01:54:25.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eJQXmdGcoGpTMZqUD7F+g4Ri0YCZmDCxv2V35YdFFBvVmitvQn3R2GEqYjVnzW1f/kYzYKZ/puMQ54zUawGyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514



On 2/9/25 11:29, Alexey Kardashevskiy wrote:
> 
> 
> On 27/8/25 13:51, Dan Williams wrote:
>> There are two components to establishing an encrypted link, provisioning
>> the stream in Partner Port config-space, and programming the keys into
>> the link layer via IDE_KM (IDE Key Management). This new library,
>> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
>> driver, is saved for later.
>>
>> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
>> this library abstracts small differences in those implementations. For
>> example, TDX Connect handles Root Port register setup while SEV-TIO
>> expects System Software to update the Root Port registers. This is the
>> rationale for fine-grained 'setup' + 'enable' verbs.
>>
>> The other design detail for TSM-coordinated IDE establishment is that
>> the TSM may manage allocation of Stream IDs, this is why the Stream ID
>> value is passed in to pci_ide_stream_setup().
>>
>> The flow is:
>>
>> pci_ide_stream_alloc():
>>      Allocate a Selective IDE Stream Register Block in each Partner Port
>>      (Endpoint + Root Port), and reserve a host bridge / platform stream
>>      slot. Gather Partner Port specific stream settings like Requester ID.
>>
>> pci_ide_stream_register():
>>      Publish the stream in sysfs after allocating a Stream ID. In the TSM
>>      case the TSM allocates the Stream ID for the Partner Port pair.
>>
>> pci_ide_stream_setup():
>>      Program the stream settings to a Partner Port. Caller is responsible
>>      for optionally calling this for the Root Port as well if the TSM
>>      implementation requires it.
>>
>> pci_ide_stream_enable():
>>      Try to run the stream after IDE_KM.
>>
>> In support of system administrators auditing where platform, Root Port,
>> and Endpoint IDE stream resources are being spent, the allocated stream
>> is reflected as a symlink from the host bridge to the endpoint with the
>> name:
>>
>>      stream%d.%d.%d
>>
>> Where the tuple of integers reflects the allocated platform, Root Port,
>> and Endpoint stream index (Selective IDE Stream Register Block) values.
>>
>> Thanks to Wu Hao for a draft implementation of this infrastructure.
>>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> Cc: Samuel Ortiz <sameo@rivosinc.com>
>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   .../ABI/testing/sysfs-devices-pci-host-bridge |  14 +
>>   drivers/pci/ide.c                             | 427 ++++++++++++++++++
>>   include/linux/pci-ide.h                       |  70 +++
>>   include/linux/pci.h                           |   6 +
>>   4 files changed, 517 insertions(+)
>>   create mode 100644 include/linux/pci-ide.h
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>> index 8c3a652799f1..2c66e5bb2bf8 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>> @@ -17,3 +17,17 @@ Description:
>>           PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
>>           /sys/devices/pciDDDD:BB entry for details about the DDDD:BB
>>           format.
>> +
>> +What:        pciDDDD:BB/streamH.R.E
>> +Contact:    linux-pci@vger.kernel.org
>> +Description:
>> +        (RO) When a platform has established a secure connection, PCIe
>> +        IDE, between two Partner Ports, this symlink appears. A stream
>> +        consumes a Stream ID slot in each of the Host bridge (H), Root
>> +        Port (R) and Endpoint (E).  The link points to the Endpoint PCI
>> +        device in the Selective IDE Stream pairing. Specifically, "R"
>> +        and "E" represent the assigned Selective IDE Stream Register
>> +        Block in the Root Port and Endpoint, and "H" represents a
>> +        platform specific pool of stream resources shared by the Root
>> +        Ports in a host bridge. See /sys/devices/pciDDDD:BB entry for
>> +        details about the DDDD:BB format.
>> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
>> index 05ab8c18b768..4f5aa42e05ef 100644
>> --- a/drivers/pci/ide.c
>> +++ b/drivers/pci/ide.c
>> @@ -5,8 +5,12 @@
>>   #define dev_fmt(fmt) "PCI/IDE: " fmt
>>   #include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-ide.h>
>>   #include <linux/pci_regs.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>>   #include "pci.h"
>> @@ -23,6 +27,13 @@ static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
>>       return offset + stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
>>   }
>> +static int sel_ide_offset(struct pci_dev *pdev,
>> +              struct pci_ide_partner *settings)
>> +{
>> +    return __sel_ide_offset(pdev->ide_cap, pdev->nr_link_ide,
>> +                settings->stream_index, pdev->nr_ide_mem);
>> +}
>> +
>>   void pci_ide_init(struct pci_dev *pdev)
>>   {
>>       u8 nr_link_ide, nr_ide_mem, nr_streams;
>> @@ -88,5 +99,421 @@ void pci_ide_init(struct pci_dev *pdev)
>>       pdev->ide_cap = ide_cap;
>>       pdev->nr_link_ide = nr_link_ide;
>> +    pdev->nr_sel_ide = nr_streams;
>>       pdev->nr_ide_mem = nr_ide_mem;
>>   }
>> +
>> +struct stream_index {
>> +    unsigned long *map;
>> +    u8 max, stream_index;
>> +};
>> +
>> +static void free_stream_index(struct stream_index *stream)
>> +{
>> +    clear_bit_unlock(stream->stream_index, stream->map);
>> +}
>> +
>> +DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
>> +static struct stream_index *alloc_stream_index(unsigned long *map, u8 max,
>> +                           struct stream_index *stream)
>> +{
>> +    if (!max)
>> +        return NULL;
>> +
>> +    do {
>> +        u8 stream_index = find_first_zero_bit(map, max);
>> +
>> +        if (stream_index == max)
>> +            return NULL;
>> +        if (!test_and_set_bit_lock(stream_index, map)) {
>> +            *stream = (struct stream_index) {
>> +                .map = map,
>> +                .max = max,
>> +                .stream_index = stream_index,
>> +            };
>> +            return stream;
>> +        }
>> +        /* collided with another stream acquisition */
>> +    } while (1);
>> +}
>> +
>> +/**
>> + * pci_ide_stream_alloc() - Reserve stream indices and probe for settings
>> + * @pdev: IDE capable PCIe Endpoint Physical Function
>> + *
>> + * Retrieve the Requester ID range of @pdev for programming its Root
>> + * Port IDE RID Association registers, and conversely retrieve the
>> + * Requester ID of the Root Port for programming @pdev's IDE RID
>> + * Association registers.
>> + *
>> + * Allocate a Selective IDE Stream Register Block instance per port.
>> + *
>> + * Allocate a platform stream resource from the associated host bridge.
>> + * Retrieve stream association parameters for Requester ID range and
>> + * address range restrictions for the stream.
>> + */
>> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>> +{
>> +    /* EP, RP, + HB Stream allocation */
>> +    struct stream_index __stream[PCI_IDE_HB + 1];
>> +    struct pci_host_bridge *hb;
>> +    struct pci_dev *rp;
>> +    int num_vf, rid_end;
>> +
>> +    if (!pci_is_pcie(pdev))
>> +        return NULL;
>> +
>> +    if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
>> +        return NULL;
>> +
>> +    if (!pdev->ide_cap)
>> +        return NULL;
>> +
>> +    /*
>> +     * Catch buggy PCI platform initialization (missing
>> +     * pci_ide_init_nr_streams())
>> +     */
>> +    hb = pci_find_host_bridge(pdev->bus);
>> +    if (WARN_ON_ONCE(!hb->nr_ide_streams))
>> +        return NULL;
>> +
>> +    struct pci_ide *ide __free(kfree) = kzalloc(sizeof(*ide), GFP_KERNEL);
>> +    if (!ide)
>> +        return NULL;
>> +
>> +    struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
>> +        hb->ide_stream_map, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);
>> +    if (!hb_stream)
>> +        return NULL;
>> +
>> +    rp = pcie_find_root_port(pdev);
>> +    struct stream_index *rp_stream __free(free_stream) = alloc_stream_index(
>> +        rp->ide_stream_map, rp->nr_sel_ide, &__stream[PCI_IDE_RP]);
>> +    if (!rp_stream)
>> +        return NULL;
>> +
>> +    struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
>> +        pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
>> +    if (!ep_stream)
>> +        return NULL;
>> +
>> +    /* for SR-IOV case, cover all VFs */
>> +    num_vf = pci_num_vf(pdev);
>> +    if (num_vf)
>> +        rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
>> +                    pci_iov_virtfn_devfn(pdev, num_vf));
>> +    else
>> +        rid_end = pci_dev_id(pdev);
>> +
>> +    *ide = (struct pci_ide) {
>> +        .pdev = pdev,
>> +        .partner = {
>> +            [PCI_IDE_EP] = {
>> +                .rid_start = pci_dev_id(rp),
>> +                .rid_end = pci_dev_id(rp),
>> +                .stream_index = no_free_ptr(ep_stream)->stream_index,
>> +            },
>> +            [PCI_IDE_RP] = {
>> +                .rid_start = pci_dev_id(pdev),
>> +                .rid_end = rid_end,
>> +                .stream_index = no_free_ptr(rp_stream)->stream_index,
>> +            },
>> +        },
>> +        .host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
>> +        .stream_id = -1,
>> +    };
>> +
>> +    return_ptr(ide);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
>> +
>> +/**
>> + * pci_ide_stream_free() - unwind pci_ide_stream_alloc()
>> + * @ide: idle IDE settings descriptor
>> + *
>> + * Free all of the stream index (register block) allocations acquired by
>> + * pci_ide_stream_alloc(). The stream represented by @ide is assumed to
>> + * be unregistered and not instantiated in any device.
>> + */
>> +void pci_ide_stream_free(struct pci_ide *ide)
>> +{
>> +    struct pci_dev *pdev = ide->pdev;
>> +    struct pci_dev *rp = pcie_find_root_port(pdev);
>> +    struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>> +
>> +    clear_bit_unlock(ide->partner[PCI_IDE_EP].stream_index,
>> +             pdev->ide_stream_map);
>> +    clear_bit_unlock(ide->partner[PCI_IDE_RP].stream_index,
>> +             rp->ide_stream_map);
>> +    clear_bit_unlock(ide->host_bridge_stream, hb->ide_stream_map);
>> +    kfree(ide);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_free);
>> +
>> +/**
>> + * pci_ide_stream_release() - unwind and release an @ide context
>> + * @ide: partially or fully registered IDE settings descriptor
>> + *
>> + * In support of automatic cleanup of IDE setup routines perform IDE
>> + * teardown in expected reverse order of setup and with respect to which
>> + * aspects of IDE setup have successfully completed.
>> + *
>> + * Be careful that setup order mirrors this shutdown order. Otherwise,
>> + * open code releasing the IDE context.
>> + */
>> +void pci_ide_stream_release(struct pci_ide *ide)
>> +{
>> +    struct pci_dev *pdev = ide->pdev;
>> +    struct pci_dev *rp = pcie_find_root_port(pdev);
>> +
>> +    if (ide->partner[PCI_IDE_RP].enable)
>> +        pci_ide_stream_disable(rp, ide);
>> +
>> +    if (ide->partner[PCI_IDE_EP].enable)
>> +        pci_ide_stream_disable(pdev, ide);
>> +
>> +    if (ide->partner[PCI_IDE_RP].setup)
>> +        pci_ide_stream_teardown(rp, ide);
>> +
>> +    if (ide->partner[PCI_IDE_EP].setup)
>> +        pci_ide_stream_teardown(pdev, ide);
>> +
>> +    if (ide->name)
>> +        pci_ide_stream_unregister(ide);
>> +
>> +    pci_ide_stream_free(ide);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_release);
>> +
>> +/**
>> + * pci_ide_stream_register() - Prepare to activate an IDE Stream
>> + * @ide: IDE settings descriptor
>> + *
>> + * After a Stream ID has been acquired for @ide, record the presence of
>> + * the stream in sysfs. The expectation is that @ide is immutable while
>> + * registered.
>> + */
>> +int pci_ide_stream_register(struct pci_ide *ide)
>> +{
>> +    struct pci_dev *pdev = ide->pdev;
>> +    struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>> +    u8 ep_stream, rp_stream;
>> +    int rc;
>> +
>> +    if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
>> +        pci_err(pdev, "Setup fail: Invalid Stream ID: %d\n", ide->stream_id);
>> +        return -ENXIO;
>> +    }
>> +
>> +    ep_stream = ide->partner[PCI_IDE_EP].stream_index;
>> +    rp_stream = ide->partner[PCI_IDE_RP].stream_index;
>> +    const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
>> +                           ide->host_bridge_stream,
>> +                           rp_stream, ep_stream);
>> +    if (!name)
>> +        return -ENOMEM;
>> +
>> +    rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
>> +    if (rc)
>> +        return rc;
>> +
>> +    ide->name = no_free_ptr(name);
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_register);
>> +
>> +/**
>> + * pci_ide_stream_unregister() - unwind pci_ide_stream_register()
>> + * @ide: idle IDE settings descriptor
>> + *
>> + * In preparation for freeing @ide, remove sysfs enumeration for the
>> + * stream.
>> + */
>> +void pci_ide_stream_unregister(struct pci_ide *ide)
>> +{
>> +    struct pci_dev *pdev = ide->pdev;
>> +    struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>> +
>> +    sysfs_remove_link(&hb->dev.kobj, ide->name);
>> +    kfree(ide->name);
>> +    ide->name = NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
>> +
>> +static int pci_ide_domain(struct pci_dev *pdev)
>> +{
>> +    if (pdev->fm_enabled)
>> +        return pci_domain_nr(pdev->bus);
>> +    return 0;
>> +}
>> +
>> +struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide)
>> +{
>> +    if (!pci_is_pcie(pdev)) {
>> +        pci_warn_once(pdev, "not a PCIe device\n");
>> +        return NULL;
>> +    }
>> +
>> +    switch (pci_pcie_type(pdev)) {
>> +    case PCI_EXP_TYPE_ENDPOINT:
>> +        if (pdev != ide->pdev) {
>> +            pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
>> +            return NULL;
>> +        }
>> +        return &ide->partner[PCI_IDE_EP];
>> +    case PCI_EXP_TYPE_ROOT_PORT: {
>> +        struct pci_dev *rp = pcie_find_root_port(ide->pdev);
>> +
>> +        if (pdev != rp) {
>> +            pci_warn_once(pdev, "setup expected Root Port: %s\n",
>> +                      pci_name(rp));
>> +            return NULL;
>> +        }
>> +        return &ide->partner[PCI_IDE_RP];
>> +    }
>> +    default:
>> +        pci_warn_once(pdev, "invalid device type\n");
>> +        return NULL;
>> +    }
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_to_settings);
>> +
>> +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
>> +                bool enable)
>> +{
>> +    u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
>> +          FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
> 
> There was:
> FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
> 
> and now it is gone, why? And it is not in any change log, took me a while to find out what broke.
> 
> Thanks,
> 
> 
>> +          FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
>> +          FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
>> +
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
>> +}
>> +
>> +/**
>> + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
>> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
>> + * @ide: registered IDE settings descriptor
>> + *
>> + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
>> + * settings are written to @pdev's Selective IDE Stream register block,
>> + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
>> + * are selected.
>> + */
>> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
>> +{
>> +    struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
>> +    int pos;
>> +    u32 val;
>> +
>> +    if (!settings)
>> +        return;
>> +
>> +    pos = sel_ide_offset(pdev, settings);
>> +
>> +    val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
>> +
>> +    val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
>> +          FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
>> +          FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
>> +
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
>> +
>> +    /*
>> +     * Setup control register early for devices that expect
>> +     * stream_id is set during key programming.
>> +     */
>> +    set_ide_sel_ctl(pdev, ide, pos, false);
>> +    settings->setup = 1;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
>> +
>> +/**
>> + * pci_ide_stream_teardown() - disable the stream and clear all settings
>> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
>> + * @ide: registered IDE settings descriptor
>> + *
>> + * For stream destruction, zero all registers that may have been written
>> + * by pci_ide_stream_setup(). Consider pci_ide_stream_disable() to leave
>> + * settings in place while temporarily disabling the stream.
>> + */
>> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
>> +{
>> +    struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
>> +    int pos;
>> +
>> +    if (!settings)
>> +        return;
>> +
>> +    pos = sel_ide_offset(pdev, settings);
>> +
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
>> +    settings->setup = 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
>> +
>> +/**
>> + * pci_ide_stream_enable() - enable a Selective IDE Stream
>> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
>> + * @ide: registered and setup IDE settings descriptor
>> + *
>> + * Activate the stream by writing to the Selective IDE Stream Control
>> + * Register.
>> + *
>> + * Return: 0 if the stream successfully entered the "secure" state, and -ENXIO
>> + * otherwise.
>> + *
>> + * Note that the state may go "insecure" at any point after returning 0, but
>> + * those events are equivalent to a "link down" event and handled via
>> + * asynchronous error reporting.
>> + */
>> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
>> +{
>> +    struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
>> +    int pos;
>> +    u32 val;
>> +
>> +    if (!settings)
>> +        return -ENXIO;
>> +
>> +    pos = sel_ide_offset(pdev, settings);
>> +
>> +    set_ide_sel_ctl(pdev, ide, pos, true);
>> +
>> +    pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
>> +    if (FIELD_GET(PCI_IDE_SEL_STS_STATE, val) !=
>> +        PCI_IDE_SEL_STS_STATE_SECURE) {
>> +        set_ide_sel_ctl(pdev, ide, pos, false);


Ah this is an actual problem, this is not right. The PCIe r6.1 spec says:

"It is permitted, but strongly not recommended, to Set the Enable bit in the IDE Extended Capability
entry for a Stream prior to the completion of key programming for that Stream".

And I have a device like that where the links goes secure after the last key is SET_GO. So it is okay to return an error here but not ok to clear the Enabled bit.

Was it "Do or do not, there is no try for pci_ide_stream_enable() (Bjorn)" in the changelog? Not very descriptive :-/ Thanks,




>> +        return -ENXIO;
>> +    }
>> +
>> +    settings->enable = 1;
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
>> +
>> +/**
>> + * pci_ide_stream_disable() - disable a Selective IDE Stream
>> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
>> + * @ide: registered and setup IDE settings descriptor
>> + *
>> + * Clear the Selective IDE Stream Control Register, but leave all other
>> + * registers untouched.
>> + */
>> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
>> +{
>> +    struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
>> +    int pos;
>> +
>> +    if (!settings)
>> +        return;
>> +
>> +    pos = sel_ide_offset(pdev, settings);
>> +
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
>> +    settings->enable = 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
>> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
>> new file mode 100644
>> index 000000000000..cf1f7a10e8e0
>> --- /dev/null
>> +++ b/include/linux/pci-ide.h
>> @@ -0,0 +1,70 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>> +
>> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
>> +
>> +#ifndef __PCI_IDE_H__
>> +#define __PCI_IDE_H__
>> +
>> +enum pci_ide_partner_select {
>> +    PCI_IDE_EP,
>> +    PCI_IDE_RP,
>> +    PCI_IDE_PARTNER_MAX,
>> +    /*
>> +     * In addition to the resources in each partner port the
>> +     * platform / host-bridge additionally has a Stream ID pool that
>> +     * it shares across root ports. Let pci_ide_stream_alloc() use
>> +     * the alloc_stream_index() helper as endpoints and root ports.
>> +     */
>> +    PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
>> +};
>> +
>> +/**
>> + * struct pci_ide_partner - Per port pair Selective IDE Stream settings
>> + * @rid_start: Partner Port Requester ID range start
>> + * @rid_start: Partner Port Requester ID range end
>> + * @stream_index: Selective IDE Stream Register Block selection
>> + * @setup: flag to track whether to run pci_ide_stream_teardown() for this
>> + *       partner slot
>> + * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
>> + */
>> +struct pci_ide_partner {
>> +    u16 rid_start;
>> +    u16 rid_end;
>> +    u8 stream_index;
>> +    unsigned int setup:1;
>> +    unsigned int enable:1;
>> +};
>> +
>> +/**
>> + * struct pci_ide - PCIe Selective IDE Stream descriptor
>> + * @pdev: PCIe Endpoint in the pci_ide_partner pair
>> + * @partner: per-partner settings
>> + * @host_bridge_stream: track platform Stream ID
>> + * @stream_id: unique Stream ID (within Partner Port pairing)
>> + * @name: name of the established Selective IDE Stream in sysfs
>> + *
>> + * Negative @stream_id values indicate "uninitialized" on the
>> + * expectation that with TSM established IDE the TSM owns the stream_id
>> + * allocation.
>> + */
>> +struct pci_ide {
>> +    struct pci_dev *pdev;
>> +    struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
>> +    u8 host_bridge_stream;
>> +    int stream_id;
>> +    const char *name;
>> +};
>> +
>> +struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
>> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
>> +void pci_ide_stream_free(struct pci_ide *ide);
>> +int  pci_ide_stream_register(struct pci_ide *ide);
>> +void pci_ide_stream_unregister(struct pci_ide *ide);
>> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide);
>> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
>> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide);
>> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide);
>> +void pci_ide_stream_release(struct pci_ide *ide);
>> +DEFINE_FREE(pci_ide_stream_release, struct pci_ide *, if (_T) pci_ide_stream_release(_T))
>> +#endif /* __PCI_IDE_H__ */
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index d3880a4f175e..45360ba87538 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -544,6 +544,8 @@ struct pci_dev {
>>       u16        ide_cap;    /* Link Integrity & Data Encryption */
>>       u8        nr_ide_mem;    /* Address association resources for streams */
>>       u8        nr_link_ide;    /* Link Stream count (Selective Stream offset) */
>> +    u8        nr_sel_ide;    /* Selective Stream count (register block allocator) */
>> +    DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
>>       unsigned int    ide_cfg:1;    /* Config cycles over IDE */
>>       unsigned int    ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>>   #endif
>> @@ -613,6 +615,10 @@ struct pci_host_bridge {
>>       int        domain_nr;
>>       struct list_head windows;    /* resource_entry */
>>       struct list_head dma_ranges;    /* dma ranges resource list */
>> +#ifdef CONFIG_PCI_IDE
>> +    u8 nr_ide_streams; /* Max streams possibly active in @ide_stream_map */
>> +    DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
>> +#endif
>>       u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>>       int (*map_irq)(const struct pci_dev *, u8, u8);
>>       void (*release_fn)(struct pci_host_bridge *);
> 

-- 
Alexey


