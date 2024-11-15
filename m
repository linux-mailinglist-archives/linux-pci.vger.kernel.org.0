Return-Path: <linux-pci+bounces-16880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B99CE0B3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 14:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A888B28E48E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC21CDA01;
	Fri, 15 Nov 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K7q5xjAz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B191B85EB;
	Fri, 15 Nov 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678888; cv=fail; b=G9HxE4ktW0eNBzfkJikSN9SQHo+AI6ZBy50khHDDD1Ng2JI8/OSculIevQei7nYEyux4JthJfeOQTibQnUvOYq6KmsheIfb7WXPIEtG7mlVpRnC9w8bTxlVDh8wwM3CqDxv7DLnHi5AH1Qf/rGDFpI4cCcbn0WMejuehNUfpJWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678888; c=relaxed/simple;
	bh=ZCjLD9rsHfTetn2mPViwWgt95Wn90n3q039ABsFzH/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vi4XVnIhUpViWEDyX4ZMlkoJKg15ij7thk2pfjqp6wmbRy8fRJ4Q8P2BwKwUrtNWUdx8i1ADIzA0YzDbClz7lTqcHx9KF8HkrkNTpDo20t6nCOYIKvbH5ycGVIws41f4Emo+Dr9Ph9invAPvw1sRVzt71NyfIgTdOCxTQ5IkNMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K7q5xjAz; arc=fail smtp.client-ip=40.107.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p90CTSNIqEdk8QROx068nf/7IbgRWtJ8wM5rovGR9+aidJVhK4nl2i9ZEkJWX28EeCSVCMHetw3UG5YLpIIZRoABZC1hRUYrUsdY+oRNxkIb7511N1RSfMbHcOSf2UorXdUHnrOe/lZvFXFQ2Bl2oN9t1tnNNXWKd0aLWGaiKEljW3VRWvlItMoJv7gC7iamwr0yAj3o2R6JCSperlV9YF9i/vBCYxydwXrSNAF/UVKxBMkb2b3sUncmEnMW1kgw1QG6OXsVQe5zTBVJPEtQhLMYVW5g8ZQggHdS4P3+1L853uIJOqs7AHfS47QMDmb5I3v0M1UIo6oxAInQhVKtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnJCsGeb2GVl3oDAOO7o/8aWvWztxjPotux7wHOiHcQ=;
 b=J+NpzbuA2C6FLTXS3/JNe8m47xSJTevvyNSVcDGKlthHNMwixgsZLmPXTZwo22LI+18ir+cmfPOtMigltXHr2L0Fcs78m6YisGtbQPWczuWWV45o58an1azN04C4IxtNKJ/pJ3Sn25IL600RydxQUpP9Vfqn+GCC+k9fMh5+FO5ta57n2H+UVw7xIn6bZBcvuh+b6a1Z57I+E7S0mzow4AFfpvgtiU5guJut08cT64KZvwizuG4LzUWjge1y1doaK6ahoD3KGwZIqJhF4sIbzED8Gv9o+g3dFJ4q6xoaWFUFewepoX4UC6TMB8JAtxgd85iCdKHbB27jM6R3ai/kaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnJCsGeb2GVl3oDAOO7o/8aWvWztxjPotux7wHOiHcQ=;
 b=K7q5xjAzkcUzPtqMHQwhC4ue3Umdmfk8iJ0FYroKa914RsUD5O0mHWF2vBPKxXJEZsd4lOt1W3PE+st5+wWWxprn6upvGB03WRtUxmmcz3TTxc5CqeDzjKmKyYX4FJQ4TXIzbHan6BeauhM+mRTA5MI0jS4Sedkycn11jBLEHlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 13:54:41 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 13:54:41 +0000
Message-ID: <f8fb0737-3450-4dcf-87a1-3b9f03ec94f2@amd.com>
Date: Fri, 15 Nov 2024 07:54:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] cxl/pci: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-4-terry.bowman@amd.com> <ZzYbHZvU_RFXZuk0@wunner.de>
 <ffd740e5-235a-4b74-8bf9-91331b619a7f@amd.com> <ZzYq2GIUoD2kkUyK@wunner.de>
 <e686016d-2670-4431-ad9d-3c189a48b1e4@amd.com> <ZzcKoOXTVVj3bTnE@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ZzcKoOXTVVj3bTnE@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0067.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbfa423-47a7-43ae-9e47-08dd057d0d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjlMZGFLNjFxd3Q3WFJDTUZTMTlDSm44R1RkWW5mZFdhelRRY2xuUy9ISStp?=
 =?utf-8?B?UEpVRlpyYVdyUmx2YXZGK1MvdXFVc2FQZEdEdXVTWXIycTVGcDlyYVFyc2kz?=
 =?utf-8?B?ZVNjUkR1MURtSzNpRWh2YWxldXpCcUJybDBJL0dNdXhiOWVFNEx6VTgrb2RP?=
 =?utf-8?B?SmpGNTYxenJqbjljeTJMN0xFQW0rT0QreDBreVM0T1pyQWZNRkgzeVFTSmJH?=
 =?utf-8?B?bnMvY0hiSkhneEN0Tzhia1RFdVpUOElnWEFUSlV6OHZNT2VXNmdIcnZIekNR?=
 =?utf-8?B?OUlJU2tvQTVIVGE3d1ZJNEJrcnh5UUxYZldEb002UmlQQlVqenNQYTFpOWdB?=
 =?utf-8?B?U1dsbFFIbnY0dmFONXNabkNReS81ZnZIT2c4S3VyaG5sU2RXbzE5M0lsVGxn?=
 =?utf-8?B?SEpVY1RmUDBCVXZweG1tS3NxeGR2VmZvQkJhNnhyWDF6RXphUFNuVWwrbEZF?=
 =?utf-8?B?MmVFZ0F6V3pLN2UxVU1mZ2ZUOWNqM0J2aDFMRmlJVkRDQUxzWFduS0hQeUIy?=
 =?utf-8?B?UUZ1Z0lLZFRBaEw3L1lwaGQ5NFpFK0ZITzJyaE1vSWV4MTMydk9PR1dHQkxI?=
 =?utf-8?B?TEpHb0FVc2trUytBbk9GZVBlbjA4QjFIc2pNYUJtVEMzVmhkMFczTU1QUkNT?=
 =?utf-8?B?U3BsaEFIZ0F6eDY4ck01ZFRtdjhkQyt5YVVyYjE4UkNZTldsUGhkbUozQ2F0?=
 =?utf-8?B?OGVYZkxhYU9jREk5c0N2TEFYbWhJWmFuWVJKWUdzOFNnbVpXWFdmSWxIcWRs?=
 =?utf-8?B?anNQeHNXT3AzVG5KcFZDV0RUL2l5YnpCNzVPSGFScXZEdHU5UkxTOERnVFA1?=
 =?utf-8?B?UDRoUDM5UmRKd25GUFI0UytJRFErWnk0cDdyYmZ1WDF6Y1BNRU9BOWIzbHU5?=
 =?utf-8?B?aDd6ZmpDbWkveUQ4RVJ1Mkg2NUZxUmF6QkFhSnlUVjBzMVl5cytVZDZkOGJt?=
 =?utf-8?B?Y25YV2lsdTJ1RFVTS1c1c3dZaUxkM3BlREROOVZ6YnVRcWkveVpackdvUXV4?=
 =?utf-8?B?TmJRa3NuWEVoQklIVEpxcGJkbWpLZHlHMzhRZ1dTellEL0Y4clZQMk1pVncw?=
 =?utf-8?B?Z1YxbnhqcG9PZTJRbU9MTG8xMVdJQWpOVW9veTR5ZmxQWmZtVnloTUJTL1FT?=
 =?utf-8?B?ZG1kdUIrSlY2VUFIVHBGT1NxclBMUU5pMlNKWTYwd0JROFNpZFBJeGtwc2x6?=
 =?utf-8?B?bm84S1U3cDRmdVpHQzA0MWhtcEIvSUt3RnFTVU55UmNVRTAxZ3UwSmViK1FX?=
 =?utf-8?B?azMzV1l3d3dXNjJYM0FHVjBOTDlaVEVmZ1J2b3duSW5pQitDMkRSV0F1clQ1?=
 =?utf-8?B?b2VhTFNOaDFHMlQrR2pQRWhUb0NhT2pZMjlEVjVNK1pOR1ppSmtMWjB1cWxK?=
 =?utf-8?B?VUc5SkJiK2NjMjlQbjdQY1o5SzllTjVDemZ6eXRsdU82VWdvQjZFYW04RUdT?=
 =?utf-8?B?R1FJdWRJL0xPZXhJanNneWl0Y2RCSmt3U1RUOFdlWGQwQUZHRDdUZ01hcUVM?=
 =?utf-8?B?SmdmNXNlNVd1dmlOc3V0WVBGUW5zZERoc1ZhaVlYbDl6V21pWHd2QXNoVXYx?=
 =?utf-8?B?Z2I3bU4yWk42UGFCZmZHTlBrT2lZSDgwL1lBSHZ4WmtjN0lUVDhxbjk4dlJk?=
 =?utf-8?B?Y0lvVHpEYXZ0cHJrM3JWZWw2aWJpOFVxdkRGM21Jc0J0Z0tXdEkxaFRSeTBY?=
 =?utf-8?B?Tlc5RzRxVGpwNXh3d1NNSlg1N0dkdmZDK0hwakFzNDQ0TXlhYnhidTVDVnRp?=
 =?utf-8?Q?mJFQaVJRcCIkLPGQ9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlhNL1BwRmh2R2o5L3lBb2lObmxtU0hRMWhFZThLWWwwR0JhM00zQ2pSUUhv?=
 =?utf-8?B?THh3cWRlQ3VmRXRGOG54YkRXV21lei9rYWVwcFU3b0p2eWFJMWY2ZTdNRVVi?=
 =?utf-8?B?S05LNWl3bEJqQWlUaTFYLyt6bStKcnRZbEhndzR2bVIyWjNtZGYzM2svN0pC?=
 =?utf-8?B?aDNVUHJVTkVLcEl2U21aZm9aTDF1V1BjNEhqdlBSN0E4MWcxUko3NGF1a04w?=
 =?utf-8?B?UXZVRDV5VVFLOVE1YkpyVy9OZWhzWjRsYlROakUzaXJ0bzE0aUw3YVhIRWMw?=
 =?utf-8?B?Z1VvYVNtV0hFcEV4WTlwdzh4aTRhc3NoeFVwTFpuWWdxQXBvdXVSa0M1VUNI?=
 =?utf-8?B?Z0F2QUR5cHU3U3NCanBvc2RBT3pHMUE4YkV2VUxRYXprTW83V2lpWWFVMUVW?=
 =?utf-8?B?UzVLYjVJbGtySytFSHBxU1pYUEJuQVFxQjg0QUVsc0VNM3B5NndNelQyM0Ur?=
 =?utf-8?B?dXV3MTJqVjMrY2k1NVR5QXh2d2twWnAyamRaaVpqZUwvRC9kYTJ3QTJOaktW?=
 =?utf-8?B?K2hBWThzSE8wbEFmcTB3WlFTencwNFd0dlhTV0dpbVhKdGxVdEIxNFFRL3lu?=
 =?utf-8?B?dFNnN0V0OHo1UDA3RTc4RE5TSjZJSDdtRjFFY2JJcjR6Nmt2alZXeEhDZVNL?=
 =?utf-8?B?T3lCZGJnaVFlY1hkeWdwUEVRM3N3N1FNa2RKTWlKbU0xRE5GUWlweEpzWDYz?=
 =?utf-8?B?SkRDdVpjMGNWVGs5VGFud1VpYUgzaHRDOFJNWFFsQWpObTZzeVR2L1BTTTVE?=
 =?utf-8?B?ZnNCSXlMTU8rVmt2ekZkNFpvK1o4bzRWNEZucllOYzBCcGttN1IycENMQWUw?=
 =?utf-8?B?Ym1MR1U1WHdpNDJqejRvRTRuVlZ1eUtSOU4vNXFxYUx2Tnc3TlhEdTQzdDFI?=
 =?utf-8?B?a0p3YVc2RG5HVEJNN2Q1a3h2clFVbForQi9sMDlHaFd1Skg2YnRUbEl2N0tN?=
 =?utf-8?B?Y1ZzVEdXU3hrRU5KbktBN0QxSVgwMTJvakI2WVJLdHA1Nk1yaDhwYnhlWHBH?=
 =?utf-8?B?Zi9UTEpya1hYUFNZTS9HWndnZ1V1RjdxeXNyd29YTCtNdnpycmRrR1NIVi9a?=
 =?utf-8?B?ZVpPNEx4bVpRQnFQOWx3dU9QaFZINWczN2twd3U0d1dxMFVXRjNnYjFmT2wx?=
 =?utf-8?B?aVkwU0lCTVNFNlVRa0gwTFpmOFBkdGQ0R3RJN1NlUHZUTkp6QTVqWWJuRGR0?=
 =?utf-8?B?OWZ3K1J0V3dxZ1QyWjJyTmNlN3A5TVlsYmJabnd1NHZvVlBkZVB0MVdlbGgy?=
 =?utf-8?B?QnNrazhoa0dpam5PWVhqUm1xUjN6MnZiOS84bU1OdDVmOUVqQ3U2OStkTnZE?=
 =?utf-8?B?Und3bmU5ckx6ZDc4V2cxM0FXMlVlZVVabWttSzhXUHQxTTluTnNnSXdRZVdC?=
 =?utf-8?B?emExVTcrUnplNVFtUEcySGNxaE9QbjZHb0piUmtFTTBPN05hcWUyMkprNVpx?=
 =?utf-8?B?amY3QzhGa1ROYUo0Wk5ZcXZmaldrN1J4TTJtdGpBZVRaaDRoU2ZBbXRKR3pm?=
 =?utf-8?B?Vmo0MEVLelJRQVB2WFVYdUpWSGUzMm5OS1VzYjBhZWxrQjU1RE1rc2M4MWlh?=
 =?utf-8?B?NG4vTDgrb0JyUis0T0NXU2pXNHRMNUhhSXo3dy9TdzlleTlUdm53K1BJbis2?=
 =?utf-8?B?T0Y5MUtQbGFva2ZYYVNsWWt1VEV5NldGUXRSd1Zua3ZJamxwVDhmY2Z1WXJ3?=
 =?utf-8?B?UUxJTUI5YWhEcmtZZTYrRFNXTU52UmVDT2tZOTJVMGFCY3lkUkVoV0JmZXBZ?=
 =?utf-8?B?VVFzOXZNUi9vSjZuQ0w4OHg4N3BjRjNQVWdOcU9OVVdZYWFNbDJ3allNZkNa?=
 =?utf-8?B?QUFhQmptRlloZEM2TGpPL2dFWmlucC96bGNSaGI5a0RQViszVTRGSnVJbDhm?=
 =?utf-8?B?SjZLaG5mN2tEVDFEMExMT2hCeE95Qkp6c3NYK3p4VndEeXByeWNMNzJDLzlt?=
 =?utf-8?B?UkR1bjRPVW9HVGRpN0pJaG5XVUF1aVNNMDdzZTd6dUNnRElMNjVWbFo3NC90?=
 =?utf-8?B?WlZNWkp3U3NWZ3FxVGpKY3NVNmNNSGtlV3lZL1NuQjVhbys4UEpYdURYTjlz?=
 =?utf-8?B?TVVSQlpwZ3BJaUFKSk1KcU1oYmlUeDh6Q0FpT056Z3hyWGZpcE1jV24vM3dB?=
 =?utf-8?Q?pbdxQJGpceVOXVTmXFQUf8ZqU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbfa423-47a7-43ae-9e47-08dd057d0d74
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 13:54:41.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYG8KshHjRri4AqsudoY3JuNo4K015l9yRZmF4Qz1N12oxYYxdHtnpscDwytnK/EY394sArAOwVwRNkAxJxJKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741



On 11/15/2024 2:47 AM, Lukas Wunner wrote:
> On Thu, Nov 14, 2024 at 11:07:26AM -0600, Bowman, Terry wrote:
>>> Can you have a CXL port that is not a CXL device?
>>>
>>> If not, it would seem to me that checking for Flexbus DVSEC presence
>>> *is* redundant.  Or do you anticipate broken devices which lack the
>>> Flexbus DVSEC and that you explicitly want to exclude?
>> No, the CXL port device is always a CXL device per spec.
>>
>> This was added to short-circuit the function by returning immediately
>> if the device is _not_ a CXL device. Otherwise for PCIe Port devices,
>> the CXL Port DVSEC will be searched. I was trying to avoid the unnecessary
>> CXL port DVSEC search unless the other criteria are met.
>> And I expect most cases will not be a CXL device.
>>
>> I will remove the "if (!pcie_is_cxl(dev))" block as you suggested.
> Ah, this is meant as a speed-up.  Actually that makes sense,
> so feel free to keep it.
>
> If you do remove it, I think you'll have to move the cxl_port_dvsec()
> invocation up in the function, in front of the pci_pcie_type() checks.
> The latter require that one first checks that the device is PCIe.
> That's done implicitly by cxl_port_dvsec() because it returns 0 in
> the non-PCIe case.  (Due to the "if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)"
> check in pci_find_next_ext_capability().)
>
> Another idea would be to put a "if (!pcie_is_cxl(dev)) return 0;" speed-up
> in cxl_port_dvsec() so that the other caller benefits from it as well.
>
> Thanks,
>
> Lukas
Ok, I'll look at adding the same pcie_is_cxl() call and check in cxl_port_devsec().

Regards,
Terry

