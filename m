Return-Path: <linux-pci+bounces-39171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3950AC026B3
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2BE19A7930
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E2A2D24B7;
	Thu, 23 Oct 2025 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xz8GxiVg"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376126F2A6;
	Thu, 23 Oct 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236561; cv=fail; b=rXL5swHgZ7xMxu0227gO5k2H8CQ2FivblyVwOGLf7VDuWuRzWKZRCmK0tMu9S1RKyHsbk/EuMePwpe6S2XmhL5hWw+neT1szAzmgMja4khlxS2h5YfXcg/pHaMr2uRBV0A5fat2UL+yMSpA6SvGTUPyM6Homlu0FsM61Eg4VuaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236561; c=relaxed/simple;
	bh=fxZlxvWhYwtMHH6M1XCeKNY5RmeNotokPoTUxux+aeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rj1RFRd5yzic7Eqt5t0gHt6fHnaz3npfCZCcGrJyXPjnv/VeKc9r5BqYEaBkAMzE2kBx0C4kFV1dK+zvleRI9HseUNGTM+xZhDJzMo3deeCOMg4o/InETjV/KKuqZZ+ypnHGvH6ZdXL2Qg92NJEz/y8wzXvkgZ4Ni4WmHNBhhxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xz8GxiVg; arc=fail smtp.client-ip=40.107.209.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWduZHQoFM+j9q364by/JCtSQb+WsC2UYzLlzFcjEU3wpscRAwNkArvbzvyUrHL82UXc79tR+Hs2YMO65ANKxNceP8pGJkdGEN6PTcXX+dxAhzbUHubSNYIcWhBJbruaFosLOvcJQSoLK8522n6Y/iDT5XYR1yKZT30nFMQ8/Pm+jdm70GCNG/dboapnzmshCHb6LqtRwlgYr8kx2iY0mB8JUWJC5oC5l9befSXmszJiaqxEuwF6Gyg9UpCo72Qh2fYkaGKrXhtMSmKCneeBpu07WpJbsN4F/ISvt/czeu3fTSPl98RhVEB3Uu0T5X6vLD8lpkI9ftf9UYda/exhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP9XQYbDDrhVk/avyMuOt9n3Mj9YT5Dzm62BQGnLshU=;
 b=UQ405w3mCQ6dlKmmYaCD+6OA2J4D6nwSu+2ANpf029FcHD2a5J/suKALVjGteaQ3lUGLMR9XXmg1NSQhIF1NBjtX97Efldb/meDlOniiUUr47TNAk5GyKLtp6YprPkbpCqjgWn0h9IPKW3I3yjZfgl/L3bZa405XQT4sHijH7fIrJvlafxFfWK3z3wOk/wmKnEKBBk9gf0QeOb8t14wWyPVGW9uzjrMz3jyzq7NF4gvrb0gzkdVS8fGjxXeDyzohQ+72rwKy7cfw2jOVryQjUK45sQWMHOc5cV+ifTYI67rq40E5TRX/usNsOIAtA2JCtHA1VLZ17PSuXTL2gyhB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP9XQYbDDrhVk/avyMuOt9n3Mj9YT5Dzm62BQGnLshU=;
 b=Xz8GxiVgTRT59mpYkY3iV8inh52bubbN8osBXDE4pihgcomQD8xcnx6IMRetWBxqSCOEjIm9Qt1G4AD5O87vvK7cS//AclbL9SL10XlnY9X5lRcNK+/C0/a+KhhCCGYXXMGfRcMss3PCTWpfZOp1PHTCmIwIJqaEdhwM1ur8I/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 16:22:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:22:36 +0000
Message-ID: <5764e711-4c3f-4476-9ecb-1f7643e3b60d@amd.com>
Date: Thu, 23 Oct 2025 11:22:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
To: Yazen Ghannam <yazen.ghannam@amd.com>,
 Michal Pecio <michal.pecio@gmail.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux@roeck-us.net,
 naveenkrishna.chatradhi@amd.com, platform-driver-x86@vger.kernel.org,
 suma.hegde@amd.com, tony.luck@intel.com, x86@kernel.org
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
 <20251022011610.60d0ba6e.michal.pecio@gmail.com>
 <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
 <20251022160904.GA174761@yaz-khff2.amd.com>
 <20251022181856.0e3cfc92.michal.pecio@gmail.com>
 <20251023135935.GA619807@yaz-khff2.amd.com>
 <20251023170107.0cc70bad.michal.pecio@gmail.com>
 <20251023160906.GA730672@yaz-khff2.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251023160906.GA730672@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:805:de::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f17daa-c3eb-4827-2232-08de12506081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGJ0SExTNVgxa29Vb1NiSWlwN0tXdWU5cXU0SWFOd2FhVjhjUkZscVNRazUw?=
 =?utf-8?B?OGdSSE1ybURIcEdqUzNyNE5DcVVqVDFtVkorUnFIUTdwYkFPZEg2Yk1paDQx?=
 =?utf-8?B?VXJxYkUyTXlTYndZZXVjUk1oK1huelR0a1pFU1NJMmdXYW5SVGRaNUY2MjBw?=
 =?utf-8?B?SzVzU2pGZlh2SnBlNW9hMCszR0ZsWkVzZVVIakVPMXRYOGUwbUFETWZLUkJR?=
 =?utf-8?B?Zi8wYy9BZHdjQWRNdTJ5YTJRQ1NwblpRM0ZudFpIRGxiZkhMU2NjVWpwTTgy?=
 =?utf-8?B?LzlCWXpMaHFFVXRyeXVwcmZoQ1FSWnRMUnN1Ui90R3JIK1BST2JxWVFISXNG?=
 =?utf-8?B?NlFuN1VRSnJLVExHM2ErV3pwOUtUZzBUYi94dG9UbHh3OXZsT3RlbU9OVFR6?=
 =?utf-8?B?NUp3dHpwaE9mUDBFTVc0ZTlVUFdFT1JyZFpjZDVMSzg3M29kZFVxR05kNTdG?=
 =?utf-8?B?bkpFYVp0NVh6RDFtVS9ZNVZvc1pYNDhqT0h0SEVtRUh3QVhHZjNyMkpZUVhy?=
 =?utf-8?B?eER4TmR4bWV5MmlQLzlNVURpcDNVemUwZVlqc05GWEEwZS9mMzVFd3g1a1lo?=
 =?utf-8?B?UERUQzhiM3hadWZTYmI1SWRxZ3RRcG8yb3I0WUQ3U2EwUlk4MmlBR0J1SHdU?=
 =?utf-8?B?aGpXNEtITEZndHB2a2FKKzZVSnVoVlF4REtCVnNoV1NWczgvYWxqSmc3ODFL?=
 =?utf-8?B?TnJzUGlYS1hQd1d4SXpqVVBDcVlmVlp5ZU1tV0w3ZURvV3JSRU1wRVNWdzFq?=
 =?utf-8?B?RS8yWDhaa0FsUC8rOGNCK0JXd3dVdmZXeEVYY09DbzRRdE1oY21vQWtDMzVO?=
 =?utf-8?B?MjlJczFidU9Td0o0K0gyRGlueEZoR3hsZExGbmdOaUthbE1NbkFPWHUxeWQ1?=
 =?utf-8?B?TENSVXZDVERVVjBIbDRUeUpSMk5oQkxqVnNQcDNPVVlsV1FCVWtwOU5kck1h?=
 =?utf-8?B?cnM1SjZHd0hTa3RBM005elFURmRIMVBJVjJLNy8zSEh1cFJjKzFtbUJ5TjRZ?=
 =?utf-8?B?UHVubjczaXpibER3UkVSemNNTHArK0R6RjNPV1ZFem5sWGlRcmtSMUE1RmZ1?=
 =?utf-8?B?VVZmb2NuRnhiek53NkNhMlhBcTVveHdDM1dYck1iU2VaK25jN051cUcrcE02?=
 =?utf-8?B?NnFXSnVHeFFJUUpZK0p6aEZ2Wjlib0wxVkhDU1B2bVUzTTdKOHFwOEc3aWwz?=
 =?utf-8?B?bEltZHRueHVUQXN0RUJ5c2xWdEZ4cDllaTRsNmxseTMvVlUyYVJkYkFKQm5S?=
 =?utf-8?B?d1dqQjRIazZJUEFvSWVsRFc2SEJQSG5sR2xRbnlOUytjWUcvRlR4L0RpN3Vq?=
 =?utf-8?B?aUszQU11WnRpc3lpWnRIdUxDRW9QaVVzYmNhWkhkTCtUT3A1SFhYYTQ2aDBS?=
 =?utf-8?B?bGpCWVhoa1VmeDV1dS9GREJhMDJSMjh2UjJ4MDFrSUZxcFIwdU14S0ZpZDFB?=
 =?utf-8?B?aGVmNVdHV0g5NWpHQW8xZVI0TjdIZC9xY0NwbkgrRm82UXF0VXA5RVc5NUNu?=
 =?utf-8?B?SnlGd205bmpEeS9SaHJ5eFUwUWFEanNvVnBvSEFYSUtGSVU0UHlLdDBwZE5R?=
 =?utf-8?B?YngvRTI3aUJtRGRuZFhCTGpldjRMdkxiRFRzOGlMaFBRdlh6TXo0d2VyTk10?=
 =?utf-8?B?NVMyRXVTcVNwRkhneDEvNnZqbitKNXZwYnZrR2VaOUhmMGU4dmF2NzBEQ0hs?=
 =?utf-8?B?OUtMUjREdGFHTE50Qm1TNGJVMlhBSXFiNlNGTGVsSFMyYmk0em5naEFkcGpM?=
 =?utf-8?B?dGF1N0xMZnFiSkx1cEczbytsNGNzUE9CN3VxcEtGOVFNYS9zN3BOQTJqRDVF?=
 =?utf-8?B?Q0loMEl0UVViUU9xYlJ5NHBsVFZNTHRyOWRBTWdjTmlVZHFyTnhtaTBCUlVo?=
 =?utf-8?B?dWVYMzJ2Sk9ZSFB1U1kxNWV0WTJWcjQvWTVqb1pFa0I3b3B3TUp2NjluQU9k?=
 =?utf-8?Q?qOTVzXLKJhOL3eJ/353evLZApRyqHCE0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjJndlN4ZjVhanczdHZXcFZWT0NsRldFYXpBOGMvQTk1UWo5SjJDMm9sQmR6?=
 =?utf-8?B?YWxCb0pRTHo3bFgzSGZHajJybjVXNFZSbC85dFdlQk51ajdubjllaDdRUndu?=
 =?utf-8?B?NHNsUHpiWFE3M0VlWVU0TDI1WXJNUEdnR3ZOcURWTFdaTWlyeDRodHVqaVZz?=
 =?utf-8?B?YUN6MnJpSXZTTkxSMTdTMm1vM3RtMmlLNHg0V1NEcGxCaDRyMU9RKzlJR2da?=
 =?utf-8?B?M1BtemZlejY5R1IzbE9uZE54OVpkanUwK2pEcURqYnpMWUtQdGlXMkYvOWVY?=
 =?utf-8?B?K0RYVnJTQWJaOHc5SjQwaUxvVC9sbVFndSt4TU5UcW5Id1VFSWxSbzVkcURY?=
 =?utf-8?B?cFVuQW5tTkY5R0JINFNneGEzZnQ4QUphd08rVGtyeW1tYllrLzk1QjIyVFMx?=
 =?utf-8?B?WGNOR0ZxandoQ3RxUUpxR0hRVEk3dlYrV1J5S1lLOVR0TTRGdnR5cHZHUTZR?=
 =?utf-8?B?WjBhQU9jRnNQMEs4aGRzZXkrSlcweEFkTG96dVJQSmtQZ1ZmdkdRQ2RoQlBG?=
 =?utf-8?B?c1lrWno0MytXd0JBWjZua3prQ2IyMGtiTUdBWStnazQvMGV0bkgwVGRJWWNR?=
 =?utf-8?B?TDJHMEJHQ0p1c1BKQURlOEV1MHVUZEQvcktUQUVCeEhBRFFUaGRNTldWaHBU?=
 =?utf-8?B?eFcxTE5OaVJLbmVvbHRhZ3haTFVhbmx4c2ZERVZPSHgyZXV6NmFoK3lTajFB?=
 =?utf-8?B?cllKelRrbm5xTDRDSHY1RytBNEZ4WXBNRC93U0R6bWlFVDVMbTlHdGFObVJp?=
 =?utf-8?B?MzlzdE1INDd1TTFCaGpjSkpTaTNRQ085RGwwZTNQd1R2eldqVGtyQVJNNWxt?=
 =?utf-8?B?QUJzWGp2c0FqNG1XdVRFTWp6ZzFUOUErYmVtbnJJcDBQYmwyVkthWVdaRW1T?=
 =?utf-8?B?alVVaDVXQTZTN2RVR25HNTVaU2xIekM1MSsxQWhFci8vUUNNOCt1cms2cFVD?=
 =?utf-8?B?N0JtbmFxbHg2OTh5VUFmWnh0YlB4Tks5ZUJaMEx3cVFNaE9KKyt0NXBHRlBP?=
 =?utf-8?B?L1BtWFVKUVVwTFhuMlk0QkJ1MkRYU0w2WTlUWi82dnBwSVNHMWlhQjlza3dw?=
 =?utf-8?B?SnFiZUNJcE1iVmZrM1V1TXM5bzduMFVZVjZOWHp1ekNKdjFPVTZaOHBOY1B2?=
 =?utf-8?B?WWFrdUx2KzgwK3V1a2hqU2tJSy9IWFBKQVBZZmpBZ2NaZXhjbW43S0FKSXNN?=
 =?utf-8?B?TEZxbUlxSVdmR1BaZW9IRmpGVTFlVmRvWDhGZWtIWDd0U2FISjl0K0JlZXA1?=
 =?utf-8?B?Z09vTHE5WXdWSjRYUmkrUXN5dlhIRmwzaFpjRkZxZ2hWcHVHekdwOFE2UE52?=
 =?utf-8?B?UTNGK3Q1SmhRUTZ0SHJsRVhhdVN5NjgvdXFCN2dGUk5CM3FxMktJN2VPUkxi?=
 =?utf-8?B?UGVDK1lTd0RXRURsSVFvVm0wczJ2WXExUXZGT0ZqWG5jZlZ5djdCZTJ1eURG?=
 =?utf-8?B?OTVUY0JDZ25LemV5TVMra25IQ0ptc3orc0hwdmhISlFUK1EwWC9vUDU0YlpZ?=
 =?utf-8?B?bUlCRXduYjZQUjh5NXUwa2NMN0R4Z2NBdUZ2bkdaSDFNM1NpNEFJNHoyek5I?=
 =?utf-8?B?SC81Uy9UWHVCMkYyZGFxNVZKNmtXYU1zakpqUGhpbjFOMGNsU0JxM2JxdHN4?=
 =?utf-8?B?SHRIeHRhM05HZUR5NmdWbHJMc295aFVzOG4yRWliQ1VQTVBoVE9pbEd3TVE1?=
 =?utf-8?B?WXlyc0NQZERiejEzYjV4MVRwQjZEYUppdFFGQ1ZtQzVRUUlsbjZqOU82Y0NV?=
 =?utf-8?B?bEpQcVlBU0QyaWhxOHQybEIzWDR2NStDMURUZml0c1M5T1NvZ0t2QjNVU2V0?=
 =?utf-8?B?Mld6b1JvYVNXeVpuMWN4NVc4L01IeGpSZVp4VmZzQ0pJemRZbUVKUGU3Zi9B?=
 =?utf-8?B?Ny82UEZndGkwVWpINUtQRGROZzk0cE0zSllQeWlyODZIUFZqUnZQQ1NBMlF6?=
 =?utf-8?B?SjZtdzdvelRTVzQwcjNzdUxmSlM5eGgwMHdWVFpaR0RueG5TaWx1TjFjVmZm?=
 =?utf-8?B?VktyNlZCM21Bcy9VWXpPaXFhN0tEOHpEemtUNkQwQzRHYUJkWkNsQ1FxZWI1?=
 =?utf-8?B?dTVEckZGVnFuVmorbnNhQ0xMYWVZbXB0dFFSUHpWbHdPUGk3UHI1R1MxVnVQ?=
 =?utf-8?Q?qzqZWsEXhSSFwo//xqRw8NArh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f17daa-c3eb-4827-2232-08de12506081
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:22:36.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQMw/mmdwQrdUzCki2osyKUY/iKKv2SROhdlnK11W74sjDIdLWQw9YAmQXv+bu29KjtgrHPqmr7gJsISncErLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779

On 10/23/25 11:09 AM, Yazen Ghannam wrote:
> On Thu, Oct 23, 2025 at 05:01:07PM +0200, Michal Pecio wrote:
>> On Thu, 23 Oct 2025 09:59:35 -0400, Yazen Ghannam wrote:
>>> Thanks Michal.
>>>
>>> I don't see anything obviously wrong.
>>
>> Which code is responsible for setting up those bitmaps which
>> are counted by topology_init_possible_cpus()?
>>
>> I guess I could add some printks there and reboot.
>>
> 
> The kernel seems to think there are 6 CPUs on your system:
> 
> [    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs
> 
> We don't seem them enabled, but they may still get APIC IDs. If so, then
> the IDs would be beyond the core shift of 2.
> 
> APIC IDs b'0 00 -> CPU0 on logical package 0
> 	 b'0 01 -> CPU1 on logical package 0
> 	 b'0 10 -> CPU2 on logical package 0
> 	 b'0 11 -> CPU3 on logical package 0
> 	 b'1 00 -> CPU0 on logical package 1
> 	 b'1 01 -> CPU1 on logical package 1
> 
> 
> Please try booting with "possible_cpus=4".
> 
> The "number of possible CPUs" comes from the ACPI Multiple APIC
> Description Table (MADT). This has the signature "APIC".
> 
> Can you please provide the disassembly of this table?
> 
> You can use the following commands:
> 1) Dump the ACPI tables to binaries:	"sudo acpidump -b"
> 2) Disassemble the APIC table:		"iasl -d apic.dat"
> 
> Both commands are part of the "acpica-tools" package.
> 
> [...]
>>
>> BTW, I forgot to mention that I have a second seemingly identical
>> board with same BIOS running Phenom X6 1090T. It is not affected.
>> Not sure if this is helpful. I haven't tried swapping CPUs.
> 
> Can you please share the dmesg output from that system? And the ACPI
> table too?
> 
> If the BIOS is the same, then I wonder if they hardcoded 6 CPUs in the
> MADT then mark the extras as "not enabled" on parts with lower cores.
> 
> Thanks,
> Yazen

As this is an ancient BIOS this reminds me of some related commits:

aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
a74fabfbd1b70 ("x86/ACPI/boot: Use FADT version to check support for 
online capable")

Does reverting that second one help?

