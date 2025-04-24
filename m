Return-Path: <linux-pci+bounces-26688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103B8A9B0D1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24FE1B84CDD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BC919E7F9;
	Thu, 24 Apr 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y477nIf1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5B17A2FB;
	Thu, 24 Apr 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504273; cv=fail; b=pxqVatFqYFudjsIw+b0WSVO3AZAdUPOzyqo5R45BldhMj6Q0icwNt6RE3gyHwP6wTGfvdRpHLb+oSqPTB+5BqGl4Z1TkyIa/yEgEA7Kce61RCfhyJ4DULHodLZTySuDnJxUOW7Md+AOSOrHVOA7e+n5jZ3/5DnKevbIDrsqT+MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504273; c=relaxed/simple;
	bh=bBemKnxah4LAYn4sGPLinJ4JgFeshzfTP5ltwrGNU8U=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JAgZHvUJkdg46JIk3J/9KeeuUuLA9MisLb2T3Eyyyke5AT96ApDXxnaaDPX0zvp5bTBYXzJXAMwSkhGE3CCqnoUk0/TqbyUx0vsN8Sncj9PS4cIBQG2GdlnsEM03Y8gmGYntQkeN4W0DZzxcVV9gz+VU8kO9LyYAwA05cyzg8PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y477nIf1; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJCw+AaJ9b6EHot/CdTnxo74J8qYobFBN14MF0FCaExsaUqmLcsDmb22YWtKr+BcleNrxUlRyRTtV/e53VNTbeVeWKhmIuuVwXDfeDiWSaTJ+qUbkW98dPFRHIbY1nVsvGHr5Mg9hqPw0ROoWAVqvb9qMNm90VAWxLSXPJSyPUoxuYG3fRUWLj7iEPPwUnpb2KRZWmuXof4D6Db9O/RTfpB0H4STYG8bdtCjTujsKgd4KEhncVIE4VTifTFVBGTAQG9csIPuZNlSdj+8O4fLUQb99JNGG/IeYa3zcSqDOc8u9apg2FRz+9/divE0Lzt6CuqINzWnKM0R1+xzVSBqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN/9UqzSpNtBBX+SJvJcd+/HqHsaNdppHUSIzjV0Bh0=;
 b=XYGKU03jj8c30orZZZOzvcEYZQpfvWIYcbp6L8TZhyLbQP/uMRyrVhA0BeQPHc53jcVUftftO/O1nLiEka4EHioI+1/NsDwjDF910ny4t+uVeLzuZY4r8ZVFBqLxEGg4P1kpcFwYtBwhv7X7IFj4pNj5wcj1X6BnfFeLaE+bbqVzYPfhI1Jcn5Q6hl/e8qPnaIEKXRRXnX6t1eyS9121rlQLnBWFGldCJVjhhLDH47iwkgKxA0v1fSYPA/0bBzxCxvdOEc1zVczTcbNWZRdqBO0XMfBgtGOn7OT9DMHq4ENZm3UamohEWGdog5f/uKlTxYZx7x4vM1PX4bcmqBOH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN/9UqzSpNtBBX+SJvJcd+/HqHsaNdppHUSIzjV0Bh0=;
 b=Y477nIf1a8NVPKON6xh98qCtwvMABRKh8svy4zzhQz7SF3D5MUjSoOAi3812qvFFZcnuYDrfmJRl1OF8TOweoB5DTeNqoy3bRu6TiPZBOUUb7cqTKefnR3vhsBMPqPv1VNjtUBYz31QIm9A/hpTKJmcqNYLC6JJ+F5CMzrYyYI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 14:17:48 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 14:17:48 +0000
Message-ID: <e473fbc9-8b46-4e76-8653-98b84f6b93a6@amd.com>
Date: Thu, 24 Apr 2025 09:17:45 -0500
User-Agent: Mozilla Thunderbird
From: "Bowman, Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error
 to CXL driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-5-terry.bowman@amd.com>
 <20250423160443.00006ee0@huawei.com>
Content-Language: en-US
In-Reply-To: <20250423160443.00006ee0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0007.namprd21.prod.outlook.com
 (2603:10b6:805:106::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: df045734-f500-4124-c583-08dd833aca17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHVxakJZM1cySC8vMFk0enR6L2RYRllvZTRQRHFKcUZWV3ZHT0NHNENrbWRZ?=
 =?utf-8?B?K0pJcldrSzhqZ2M3UGkwWm1qRCtzN2tZdkY3djRicm5Kb2R0RVJXd01NRkFB?=
 =?utf-8?B?L01rOFJsMXVxRFUyQmY2Q0F2TWgvUWswd1FQUzFVMFVySUhEOFEwN0ZiL2Mx?=
 =?utf-8?B?VzVPZkpZdDUxbkZDSWU1ZGh1MFA4eVpWSkdUelBPNHd5QWVmWkJ6Wm9BT3Bl?=
 =?utf-8?B?eHYzT3d4TjB1OXZSaVRwZ2NxNEhpbU81N1JOeWswV3N3ZUNSSXZDS2QycTFj?=
 =?utf-8?B?dU83UXNJbnlLRjV3enljMEt0RFpjRWdVaG1sVCtnSXNJcTRaQmVhUW5KL0hu?=
 =?utf-8?B?WmFDejFybjVaSjdnZWZzaEZxVW1nSHJzZUNsMFExSTlTaXNmU0kvM1I4T1Bm?=
 =?utf-8?B?SmdHUE1ScmZVSWt3Qm82R1ZUVDFncVRpUmxwN3JLOEd2U0hTbGd1UCtDQlly?=
 =?utf-8?B?Y0NZVU1zeC94MXB2ZjR6b3R3VTFIRGRkTGU3WitzWDlFOS84UFB3Rnp6QkRU?=
 =?utf-8?B?NHdjaHJuWXhuZGE1emUybitURytyUjJHZlpBMFVEaERZUWRjdUV6clhMQUY0?=
 =?utf-8?B?OFFTcTZjbnJqUThURHZqaXBZTkdHTmQ3YndTQ2tObi96SndJeUo4aDdnUFdH?=
 =?utf-8?B?WjBJQ1FBOFRkK043L2hJY1d5SklJUkNKQXBJbmJ0b3pKbnAzNTBoTFBlM09E?=
 =?utf-8?B?TXhHQ3c1KzV3WHp2Zm90Tm0zazBVYitsbExuNkJobFBsTktpSU5uTFFneTBB?=
 =?utf-8?B?dEJJaWoxSjg1ZTh5MXphZEdqRDFQY1MzcnNxekZ6VEkvVkQvQWxLYmtaV0t6?=
 =?utf-8?B?cU9mbHQ1RGp1MDFxN05rYjVwZ2QxeHdITVhMa1lrL3dFTi9WZElubkVDaVZI?=
 =?utf-8?B?VkxiSmo5TVViYSt1QWZKMUhJa25BZGZJMUwvcnVweUVwZXBiMEtEUzVSZyt2?=
 =?utf-8?B?NmZoVnNQNFpJYU80R3ZOVmJhNzZXVVNMUjVvMXZiUHgya1RJMy9ndldaZUt4?=
 =?utf-8?B?T0s5Q0RpVUpFbm1VbjVlbEhZdXlEeW5pcW0rUGJMcldFVzR4d05OK0EyQ0JK?=
 =?utf-8?B?KzRadVlyd2RvT3ZjRFNVcTQ2SnVEWG83d3hLRWxLZFBjbTlaeVNrOEhDNFNE?=
 =?utf-8?B?dnVMVkgxei91M1lUcTJwcVZPYVZVZXRkdktxTWgrZ2JKdEhraEIzM3NiNWhp?=
 =?utf-8?B?WkxheG9sY0d6OCthVmtvUTJObzZUV1BnU1poV2tsbnBWYlM5bE5VekxDVzBv?=
 =?utf-8?B?cGtRQkhiRXFtbHV1S2kxcjNFQVlTZ3M4bzg4WlJxejErcTlZcyt2bmJocE8z?=
 =?utf-8?B?QklDa2xsVGxwWDRIUHRuZ3ozOGYxWUpxWnlVTVROb2xFN1lpZXRjcmw4eUU5?=
 =?utf-8?B?NzdZV3piZWVReUZlTEdwdDRQVEdjanRGais5U2J4TEJpTnp0OGdSVmMzUW14?=
 =?utf-8?B?NGQxajdmeUxrVzg0bExsMkdTQnJtVXlBK0RBVXllemo3K3ZQZHVweXNrUXpi?=
 =?utf-8?B?T2lhcHFuOE1ObE1NRERFejh3UTVNeTJZVCtmY3dBTDBJYzNmbXdnWjBvcEhP?=
 =?utf-8?B?SVV5ZCt2S3pMZWY1ZFlzUHQ2amJhUm5RWWpaNWRXQlhFcGlnYnBBa1JITHp2?=
 =?utf-8?B?R1lOaWdWc3BIZVZIbSttazcwSXdic1B0ZGsyRVoyNUhpRDFXUGc1U0xONm8w?=
 =?utf-8?B?clpEWUpvdy9uVGVkdnZqSWV4TkxSdWRyVklOTFFtRzFBeWdqdmhGUkZtTkZO?=
 =?utf-8?B?SnV4RFdUVjZhM3dPeWRoVzdCVy8wR3pMYlVlRmdHQXF4UVpGTnhNbHhvaURi?=
 =?utf-8?B?RTRhUllIazJpK092M2NHWTN4YUJpMmhPVzhURVlWWjFkUGQwUkN0clpTaUpC?=
 =?utf-8?B?SFFWV0t0NVVzWTUvNkhZUW4vV1J6QU5rclBoekhNakRWdWM5ancxL0RWMWJF?=
 =?utf-8?Q?faF18kTljmQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MExEYVFNY1cybGo1bU5KekxLcmowQ2pIMlN6bTh6ZDRSbzk1THFuOWgyenEz?=
 =?utf-8?B?MkVqZnRoVG5tQS9yN00wbmtpR0ZvSnhSUTBIbjIvL295M0RVT0tzTU5nUXlj?=
 =?utf-8?B?RjFNM3V5cE0xL1lWc3pkKzdzZ2hXVlYyc09ZRElFMkpqSnprdFFsaTJmU1dN?=
 =?utf-8?B?Sm9iZG1LZGZGMDhuR0FhTFdDSXNzVnR3czJISmFzbVVtYWxxMklRTW9VSzE4?=
 =?utf-8?B?MTFQejdLQVRvRUNHQXBhb3gzeTlVUWpMV1c4NHpENkIyQ2NyT3UraVlOYUh4?=
 =?utf-8?B?STVPRXlkc1FmUzd4OVF4MHYvZjNZamRWYmlPcjBTUHB3VUloQThFMnFlcDdL?=
 =?utf-8?B?KzlPa3JNNkhBaVlsdXN5ZTl4QjBIMXFhWjZNa29uOWtoQnF3dnNFcFRtOHl4?=
 =?utf-8?B?QWZSbitUanhKMHQ5SGlBQ1hTU2RKZE1ocVVtMUNzU1hreE0zMFRuRmV0VUlw?=
 =?utf-8?B?azlSeXBPak4vVkJ3eGdmWEUreWZWb3UrakQ1MFk1N0EyeGdaazR6Qm9TbC8x?=
 =?utf-8?B?UFRja2JiSmxwTGNNOFM4emE0SVlXK1ZnVlM4OGpLYVRURzFtY2Y4TjdSV0No?=
 =?utf-8?B?Rkw2TGUwdUt0VU5XVWZvUWhKTld1THc5bzJyVzZIdUwzb3lOelRnK2FMeStC?=
 =?utf-8?B?ZllYTkFwVWpoVFNHWlVGVG81SDRZVGtqUXBwTktuMUcvVWJRVlRTbUFTc3ZH?=
 =?utf-8?B?cVMxZGpZNm4zKzlndWVCejVYcHF5eGk2UjNMek1SL3pqRTVRSEtFNDZEQXdx?=
 =?utf-8?B?TUcwQVg1dlBPT2NZcUgvNERnd0R1d1hHeW05OWpuaUxUM1U5UVM2WDVxYjlO?=
 =?utf-8?B?b1JoVWF6ZW13Q0JJdG0rcWVpZHRyRFNPbWZickFhQ2hnbXVBUzE3b1ByLzhh?=
 =?utf-8?B?WFBDdkQ1Vk5McFNKOG9JMmE2TWhvcUtCVFliQ2FGcXhTOHYyOFF6VEl5dC9N?=
 =?utf-8?B?Z2tXMlk0SnJxcC9pQVVkeW03NmhMQ3BJQnBRdFJseEF0emdMY1N4TUVGbzdH?=
 =?utf-8?B?cy8ydjdEWUM2Y081REg2Y3U4QTdKbHd5NTRtc0dTeDJaWEM5VHRmTjUyUlgr?=
 =?utf-8?B?NnFFajUzWXhMUkZ0Z3hybzMvZUFUWmlNeklFdXNuOFF0Zmx3ckJqaUJRYURN?=
 =?utf-8?B?T1E0V2YraFAvMFBlclVQcjluWFQ0Tm1panBoQ3RSMGs3em9NS25NMi9Yck40?=
 =?utf-8?B?Q1FnNHRJNzhjVTZMZnpDVEpCVWdHMFord1dwS0VOQUdOaG8wVWNESEVlSjJK?=
 =?utf-8?B?T0FZcUJzMk1MVUhXVXpOcnR5SmMvWGU0Tk1qbWswelpQL1JpTGkyK1lycmht?=
 =?utf-8?B?a0tiOEpGUFJ6NHRiUm9sanRPakI2cXpyT25mdXUwQksxb1E1Sm5hMGlVVDgz?=
 =?utf-8?B?VlBnRjc4M1hkL2Vjd1p2dEFCRHhBQTVCRU01L0IzRStEYkMwdXJDN3pkRy9s?=
 =?utf-8?B?MlptZGdhRzFuRit6bitsOE5PUWR3RThnb3NJTi96VnRlS3diRGI2b1J6eVFR?=
 =?utf-8?B?VmVTcyt0T2g2ZFZyOVh2MktBU1UvTmJtajRGSko0VEFYWkVQWDh3d25IdW9p?=
 =?utf-8?B?UWk3K2orRjMrRVFVMFg1NUM4UWE5N293RXFSaytoZEtoYzAyZ3p4WmFQcXc1?=
 =?utf-8?B?MVVHRVdaR2NBcUxjcEVuRWdsM205MUwzNlhBMHZ2aGFtS2RvNWFORFppWnNo?=
 =?utf-8?B?aGpjWTNwRHQ0QUtyNXpRZ2E3djUvVjBLbFZBYlJGcDZlbStNdkVqZjNSVHc0?=
 =?utf-8?B?NlV2WS9lbER5bGNpb1BOVkFsNitEQkloc3Z4UkVKWEU5N1ZvSjAxVTVweEFy?=
 =?utf-8?B?L3J1WlJIZUVMcDJ4WVBHWWRsUkVxTkhHVmRJSzlxVXh1bDFhMEg0MHJBT2c4?=
 =?utf-8?B?anFraURkQWVSZTBRcDd2cXI0RVo2TlcrVGtQeExHSnIwV3ZUT1RRbmhoSExC?=
 =?utf-8?B?amh0dmJDTzhqUUNQclJqMnh6QXhzQjIrTzZkV0JBU1k5Vno1T2pzbWU3U29m?=
 =?utf-8?B?Y1RJNCtlRFVnYXluQ0hQL1VpYSs3QytiVUtPbmhWRVAwcjRuKy9tQXdVM0FU?=
 =?utf-8?B?cEpjOGU0VEkwRWdyeXgxazdNVG9vM2tyYUl3Q0FhVzhFM2JOcm1kSSs1Uk5l?=
 =?utf-8?Q?FnzUzjR0aOCbdjOu0TeAffQpl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df045734-f500-4124-c583-08dd833aca17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:17:48.1581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Dj2eKKH87XieiVG6o8v2qm4clDKbLigSK3fZo+iJwigWsS3pnjy74tFwbl2kLRLHRNJdUp+PoIWXOOryI81uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123



On 4/23/2025 10:04 AM, Jonathan Cameron wrote:
> On Wed, 26 Mar 2025 20:47:05 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The AER service driver includes a CXL-specific kfifo, intended to forward
>> CXL errors to the CXL driver. However, the forwarding functionality is
>> currently unimplemented. Update the AER driver to enable error forwarding
>> to the CXL driver.
>>
>> Modify the AER service driver's handle_error_source(), which is called from
>> process_aer_err_devices(), to distinguish between PCIe and CXL errors.
>>
>> Rename and update is_internal_error() to is_cxl_error(). Ensuring it
>> checks both the 'struct aer_info::is_cxl' flag and the AER internal error
>> masks.
>>
>> If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
>> as done in the current AER driver.
>>
>> If the error is a CXL-related error then forward it to the CXL driver for
>> handling using the kfifo mechanism.
>>
>> Introduce a new function forward_cxl_error(), which constructs a CXL
>> protocol error context using cxl_create_prot_err_info(). This context is
>> then passed to the CXL driver via kfifo using a 'struct work_struct'.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Hi Terry,
>
> Finally got back to this.  I'm not following how some of the reference
> counting in here is working.  It might be fine but there is a lot
> taking then dropping device references - some of which are taken again later.
>
>> @@ -1082,10 +1094,44 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>  	pci_info(rcec, "CXL: Internal errors unmasked");
>>  }
>>  
>> +static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
>> +{
>> +	int severity = info->severity;
> So far this variable isn't really justified.  Maybe it makes sense later in the
> series?

This is used below in call to cxl_create_prot_err_info().

>> +	struct cxl_prot_err_work_data wd;
>> +	struct cxl_prot_error_info *err_info = &wd.err_info;
> Similarly. Why not just use this directly in the call below?

The reference assignment is made so that err_info can be initialized above and is then
used here to assign and later passed below as part of the work structure.

>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
> Can you talk me through the reference counting?  You take one pci device reference
> here.... 

This will add reference count to the PCI device (not the CXL device) to prevent it
from being destroyed until scope exit cleanup.

>> +
>> +	if (!cxl_create_prot_err_info) {
>> +		pci_err(pdev, "Failed. CXL-AER interface not initialized.");
>> +		return;
>> +	}
>> +
>> +	if (cxl_create_prot_err_info(pdev, severity, err_info)) {
> ...but the implementation of this also takes once internally.  Can we skip that
> internal one and document that it is always take by the caller?

Yes, it can. I will have to verify other the 5 or 6 calls do the same before calling.
I was wanting to make the reference incr as early as possible immediately after error
detection and also not forcing callers to do the same setup everywhere beforehand. I
see your point and will consolidate them.

>> +		pci_err(pdev, "Failed to create CXL protocol error information");
>> +		return;
>> +	}
>> +
>> +	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);
> Also this one.  A reference was acquired and dropped in cxl_create_prot_err_info()
> followed by retaking it here.  How do we know it is still about by this call
> and once we pull it off the kfifo later?

Yes, this is a problem I realized after sending the series.

The device reference incr could be changed for all the devices to the non-cleanup
variety. Then would add the reference incr in the caller after calling cxl_create_prot_err_info().
I need to look at the other calls to to cxl_create_prot_err_info() as well.

In addition, I think we should consider adding the CXL RAS status into the struct cxl_prot_err_info.
This would eliminate the need for further accesses to the CXL device after being dequeued from the
fifo. Thoughts?

>> +
>> +	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
>> +		pr_err_ratelimited("CXL kfifo overflow\n");
>> +		return;
>> +	}
>> +
>> +	schedule_work(cxl_prot_err_work);
>> +}
>> +
> Thanks,
>
> Jonathan
>
Thanks for reviewing Jonathan.

-Terry

