Return-Path: <linux-pci+bounces-29111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E266CAD07F2
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 20:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2C9189B56D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23A41A2C25;
	Fri,  6 Jun 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E4PGXxnD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE142AB0;
	Fri,  6 Jun 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749233886; cv=fail; b=bhrvd7vG5gO24YrL/wGG3e2hRLZUNcFxWOz+D3cdskBZ9hVbOm99cGtyucInIfVf7HENXjO+nCfXDT0KQ2sIAvhy2AEhORhUi1mKg02ZW4w9Mqenp4Ny4Qe0gcj+Z3Pj1fYfuEguDf8jM0ELUQUt5x6SXq5sg3MRLl0vFVLOV6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749233886; c=relaxed/simple;
	bh=aR3bZrKuj0FYmZnpq9uHcmzl5wGzCCXCuHzajz7WprY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=quZJdYU+bGoBUZdtyTWpIfk2cpHqJgMYLA+k0QHjru3PpoFmgVWLk79MmmodHRvfQxMQoHRe2IbcGWHsEDfMpLCEntu+xwKU6CktwcmF7OCU2D706gwEdTk1hEoEhvVgXY8gsLldTLBZR3ZJFow/I490gkyYoPrV4k2Qus0/Ees=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E4PGXxnD; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh/CUxvYUIKuzafijPJjtSBZemb0oJ4H49fTt8kzlPuoQSu4XwcT1ulC6uN+p1IVuSulyKP6t2ICvLyGa0n5aWQ7tl1G9yrZkmNuP6hbchHvMYUPvcupFmystV+C5HLsYO+Ua4JklByoFc5kTpHKBYjmbN/Bz2L1yUZ2qeDIrHDO5aokD66yPG62Q5OzccL57kmNZ9/T0PpYQsOhuUVM1KqWDMG2kUNuVc9kM3h6o7H0JN36fi3X+c2xBHHMy3lHvmCwa0GAkGZoT0dJp4xlyc9sWAB98BN8EMl5aLpXFIw+Xp2lkqLN3V5kIMlCurhDNNCPK3GCNBQQIclRUxXGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMRJ0zUGUdfLc6JHI5PBG9PDL0dNoCLvBd8sclcPYQg=;
 b=TUV3rYSDhM61WFWctJBKt7u0Ysfa0CnIgEjPU5k8Xp9VZlj1AXeIl79JyCPUoEoeMu7jSxUtiiRwklp4YPl5muHa1EhUuByUgEEpcvjbNaOvO4ZVTAY4WTDUTLoeSGsCJ8XYonhVHZJx26i2w+FSabfDfmGPny+02xRtPaYs2g4UdLiB4PBuQm7GKW0onEDRBYCz+4j9pEeGE82Mt0gd1OXfx8jYRFVG3PPobvOCdQStDI5CMzV9x/JW682bHkwDZegbkdOCUIwswmI0XxpfxuxqXt3zYvC7/2OOCxVgSOUgeFqMZiX2iZZQBe588ZQwLYdM1BJMcCYSbeQb7tPj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMRJ0zUGUdfLc6JHI5PBG9PDL0dNoCLvBd8sclcPYQg=;
 b=E4PGXxnDo+8C+Ru70ZZ7SRgYZnA4QHgk+LF0ug9+FxaS/11y/nXylAOgVQcpjQQVwg+GH4Tvy4QvGvH0dJDKYO5iZ5m5xtGyxKCYxjhKGVTpzaAs7xJ86woOIFw67uwxipv5bccgaRBZ8wdR5e9pf5gtBjedT0y9q3q3OmzkIQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Fri, 6 Jun
 2025 18:18:02 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 18:18:01 +0000
Message-ID: <ed0a656c-a88d-4b26-9e39-670f0d246e25@amd.com>
Date: Fri, 6 Jun 2025 13:17:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/16] cxl/pci: Move RAS initialization to cxl_port
 driver
To: Dave Jiang <dave.jiang@intel.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-7-terry.bowman@amd.com>
 <6856e071-79ff-4b95-95ef-ebacadfabfbc@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6856e071-79ff-4b95-95ef-ebacadfabfbc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:930:a1::27) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 16511129-1f9b-4c5c-82ff-08dda52678b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXczYVN6Z28zMy9uMkY1SCtXa0JHZGUzTzViRjYzRktmaUw3Zm9LTmp5M0V2?=
 =?utf-8?B?SkFOMGpGLzZENS9TcDV4VzdRZ1BtdCtDeFN1QS85ZVZSVTJ1SHBEMDAwU3RD?=
 =?utf-8?B?bTk5TWlicU9Mc2hiOHdRVlZLZWp0anZlOVBLbTF1alRTb1krK1FCbkdLQUp4?=
 =?utf-8?B?M0FROUp2eGNRY0YvaUJBR242OGw4MGhKUGc4Z2ZhSk9BYVlCSk9odEV1dWVk?=
 =?utf-8?B?OFVsMjM5SzBsbjFyak94djFEekx0M3hjZ1N3dHp0ZDRKaGkvRCtsTmdjV3Bv?=
 =?utf-8?B?T2JTcVVoOEFtWGdyUlVUMGxhU0dhSXNBd1V0T2JMb25wNC8yVnFsbjJDMXBN?=
 =?utf-8?B?bEROaklhTWZJdGtCMVQ5OEpnSUwwSitsc2RXVzhId2N5bkwrNDNZV1lKVlZY?=
 =?utf-8?B?c1lmbERnMks0UjdldmFITHZiVDdWeXh3ckQ1c2tDcjlPeU4vUlB6MGJzdFhE?=
 =?utf-8?B?dHFXZjZuRWhyUUsrLy9TdDh1WGJ1YkJPU1Zhb1NtWWZ4V0wzRU5HSGRrUGY0?=
 =?utf-8?B?bmZGVXVLSXJjNUVmaVZIS0ZGNVk3cTlnaFZTRjlaaWJ0RzM4cHFtdGhIbTFt?=
 =?utf-8?B?VGxoSW5iUkJnMS8rMno0N280TkhMQ2k5RlJVL0lsUGh3WWp5dTZ3Q1VUQ3lZ?=
 =?utf-8?B?RzFyR3k4Wi82SHBFUm1uN25Za0ZMOTc1OXpuQWxaeUZNRzJkcWU4b0FpNDky?=
 =?utf-8?B?YzNMdmxWbHhwZU1sODdSOWhYdnBscE5vVlFzcGlHaGx4OTIzTVl3T2FvQkRu?=
 =?utf-8?B?MHFUd1FxME5UOHY0OHp1ZjJnZzB6UGFyS285bnk2VjJGeENhSWp0MDJjanB4?=
 =?utf-8?B?UDgxOEJJczZVR0loTnFSN0J3SHc0d3h0QVFHN2F4TnFSb0U4R1Nwc2Y3Ti9K?=
 =?utf-8?B?MGw0UTZMaTkwSG4xa3VMZEpVSUNHbGRGdGNqNWxzb0J2ZkVmYXU3TmNRUmMz?=
 =?utf-8?B?QzFrazVzTEpIV3QrRHljbTZmMmVaNzl1MnFsZkhLaGNnTVlpSEM3dVVac1Yx?=
 =?utf-8?B?dUhDU3FtZzU4VDlIYlRvYjlPenFTdHNNM2VCd0dMV0c2UzB3MWtGNjNsTEFl?=
 =?utf-8?B?dDlvVGNGVWZmenQ0RDY5QUQxU09vcmxidTh1OGYxQU1jNDRUN21HQUxlSm5o?=
 =?utf-8?B?WTRRd1JKZVYwMFpMYkxKbDZ4WExKMWNQSjA5QVNBMUwwYWVDVXpBR2xkR0lk?=
 =?utf-8?B?VVZVMlhLa2dKTHMwUWFSbStRK1JKYktaR3IvV2FiN0FSK3lsQVp6QlFqYnRa?=
 =?utf-8?B?YkRzL28xMDlETUxWVytmTHIxeGNzWnI4WHQxdnluQTRqZncvNXBJTHVWRXVU?=
 =?utf-8?B?R2pKcDlwNGlsQS93QWtmZHAzN2pxVit0NS9nWHQ5YVVQSytIQ1JQaXIrZEFi?=
 =?utf-8?B?M3Nod0JSWC83N1NiUkpmNGVZT29paXh6eW1GZEZ3Q25oRlNlUFlHSDBFamhl?=
 =?utf-8?B?TTc1WW5yZjMzOHRKSVdvS3VTYjVXcFVGWU8ySSsrbmprUnJ6TGpGOXVPaUZz?=
 =?utf-8?B?SnN2ZnNkSmRQYVp6R3NOdm8yTFYzazlHUEdOeHM0ci96aVVrWklZU0tJanR2?=
 =?utf-8?B?YXNQNTJMYjFBbEZOYlAxbVYzKzZiUkNXNWRxK3FDTldWSmw3Y3pGWnJtRm01?=
 =?utf-8?B?VlZuS2RQNnBtNjBXQTVhR3UycUNVN1Q1eE9jaTkrbnBSZ3pnWXlsSGR5bmhz?=
 =?utf-8?B?RWIzUG1QM3EvdHgrNlUxcjB6TitkaEhzdlAzQnY5cUhHNjBPc2J3Ri9wRUVp?=
 =?utf-8?B?dkJHQmRkcUZtNHRVT2djWklveVY4QndYUVErRGJkNndMUC9sMjlLc2lPK2tE?=
 =?utf-8?B?ZERzc2tVUElJaE5wOU5lS1RibzlrNWo3d1cwRmlLTmd4UGFKeHNHUzFsT2p3?=
 =?utf-8?B?YW5tTkczUC9qd0puSFpyR1g4WkNZU3dpVE1YQmtkbGc1VU1Ick1Oa2laTWpE?=
 =?utf-8?B?d3NBMXFDTHBEcnFPKzkwSVQ4TUdqTFQ2VVJEckhoZHRWN0FZK2poK2xOZlMx?=
 =?utf-8?B?NEE0RkN4eWlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aStOakJKdkk1OG05blVMUHpKeU5KQ2E3M2ljcStIVldYT1FmUC9wVDVveE5k?=
 =?utf-8?B?MGJKTDRmL2YvNEtyZzNPazBDMTVGTElvQjhvTXZKL0w0S0NFV0FUK2gxSHAw?=
 =?utf-8?B?OXJIVEJ1N1dEUUNoTnlpVklRay9uWHdjVUJ0R2JjWjY1OGozWUFxVTM4dk9R?=
 =?utf-8?B?aXlLUlZxSG5Eb2tWVzdsVUY4MW5pWGdNWjYyT1BwZnJHdGJLK3J3RjRNVlhu?=
 =?utf-8?B?MlNrdzNoMkdsMkZzd3B6UnVicCt2Uld0eWJSUmNrUEkwQit4Z3VoR2dYdUtQ?=
 =?utf-8?B?L2xScnZzVks0UWhWUjlUV3I0ZE10bEZBYlJWcXBwV0xNWXd0RXQyWEFEOThr?=
 =?utf-8?B?YmRwUHNQQnV6NjJseGFHL3NHaGxiU3NHOU9WWmdhdUhpRDhSSEdLUWN5NjVM?=
 =?utf-8?B?dmVhSmc1ZEU5Y2QwUEgvdEpVQSt1SzVMeDZ1dEZPTXhsYlc4aW9MdHhlR0RN?=
 =?utf-8?B?NFM5UVcxNWhIWXZ0MC9JU3Z1WitDcXNFZGhNQXdPTk1KNDVoeEE4MFZ5N0J6?=
 =?utf-8?B?ZkJTeUhoWTl5ZlRNNkhtSmZwb1BVTlU2VEZnTUJkMit3WkxuWDVIQ3VxS2wv?=
 =?utf-8?B?TkxDb3psczcxRTBGUGtRcThES29ZWXpDdWlYaTQvanNzK0NUUW9EbFVvWllS?=
 =?utf-8?B?UmszOG1UQkZ1TFFqenpFRjFZWXNuWVhBRFV1ZS9wYUw3QkROVVJ0MHZ2UXRZ?=
 =?utf-8?B?RnhZYnJraEdGbHNHNVdoZzNLVFYxTU5ablRRUkM4RkxUeWtSbXVMdi9WTUZI?=
 =?utf-8?B?YSt0VGtucWoxMTRhOHUvYzlLN0JZbFo4ZFNzUWRTNlJwRWdobDYwOTJRRGV6?=
 =?utf-8?B?R0t5R0ZGKzhTSmsvNkdXOXltU09yZTRZTG9ZSTIvRlMzRWU3bUY5QVNTcjVW?=
 =?utf-8?B?Ync4OXRFOENkb1FERTB6azR5blBoa2ZpYURlUXhDdlhFV0lHdFJ3QXdUMUhI?=
 =?utf-8?B?c3dIV1VjK2lmSEpVRE9MU2VTRWNySWZVREJYNStSZHBORi9VNkRLRXdRSVNW?=
 =?utf-8?B?K0o0dFFJaFFYZG43KzRpNXExWXBEZ1k2ZWZHL0lhdEhxdjFNbFZndkNCR0Qw?=
 =?utf-8?B?K3dhdXNWUzVLOWtWRUZFSTJRU0F3cE1Tam5BTUw3a0E1bTlpOWQweTJEd1Fx?=
 =?utf-8?B?Mm5FMDk5U25ndzEwa1ZORDl1dmNZN0JsQURXRnA5cFN2VDNNdmFkODRtQzd3?=
 =?utf-8?B?WGp4bENraUl1WHB1L29hQ0h4U2tuaHJkWTFwNDdQNkllTW1iOWpEcnd2cjUr?=
 =?utf-8?B?a1RBQkR3dXBjRmVOWUIzVS92bGxrcGpaZko1SU4rcGgySFJIY0ZUbmVxb1pP?=
 =?utf-8?B?MHgyUG9NSm40UC9zeE9taEtTU200SHpYTHNEQ2hlNVFDQjVkVFNlSURlVkly?=
 =?utf-8?B?UWd6cG4rVDJNQVhDaHhPT2cwRSswcWYzell1TFVrMWVCR29TU3ZXTWxoWGdD?=
 =?utf-8?B?a2dJK2dGMHVxNU1wOG5PK0ZNV0w1OE83bW5mTm14ZTc3NFh4aDJpVmRTQm1W?=
 =?utf-8?B?dmNhOU0rT3dISXErOXN3T2hrZUR0N3RFSGFzL3JEV3dIRnZtKzdadnd0dEFG?=
 =?utf-8?B?d0czVlFqblc1ajlUY0FEQnNnNkdGYjBPRW1EVGpvRFp2dDNJclppeTA2RUZw?=
 =?utf-8?B?V1FPTklONVhYb0NVKzNORlo3NlExQXZORUFla213U01GUlZaTTJQa1R0MzFE?=
 =?utf-8?B?LzdZVjVwOWVJc0lXVGVldDA0bXhjUkFHVElCRWtzdVdiUm9kOTQxN1dCSHJ3?=
 =?utf-8?B?aVY2OFhuc3NJZjI0STZET2gwM1Vkbjl0eFRGUk1LM0NZWTY3Sm1zRXNZK2Z6?=
 =?utf-8?B?dDJxNUR6S2owWVpYY3NjN3NMcGY0OVRLaEd3UFVGdjVjWmlvckNBRWQyVjRD?=
 =?utf-8?B?ZjZ5dXVhWnlvUllLSlJLMzdEelRtWjZFMTVQOGN6NWNvSU04RGRCUVFSclRW?=
 =?utf-8?B?cGpvVGpzcjBNelBMVFJwbE1qUHJhSncyTFU2WWhPaGo5ckw3RFhrL0JVd1lR?=
 =?utf-8?B?SlRHbXl5UWxaMDBaY1FybHNvOWZNZjExK0RaSGZiWnh2VEdYa1RtV2kvQkxJ?=
 =?utf-8?B?d1Y5dG9DYUd4Z1lSWVdxWm0yOUVzTE9rV0gveFI2VzREYWk2R2x4c09YOFNz?=
 =?utf-8?Q?FRo+DvTfCPH5sqsBomiQcOkiz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16511129-1f9b-4c5c-82ff-08dda52678b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 18:18:01.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNpw1kWHFXRUUALxCNTjPK+GgmVfJPlYtdr7ZicKqj/m7R6I7/T9BmEZf3XHsFvOkkkNrfj/kXyscqdQCY915Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374



On 6/6/2025 12:04 PM, Dave Jiang wrote:
>
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> The cxl_port driver is intended to manage CXL Endpoint Ports and CXL Switch
>> Ports. Move existing RAS initialization to the cxl_port driver.
>>
>> Restricted CXL Host (RCH) Downstream Port RAS initialization currently
>> resides in cxl/core/pci.c. The PCI source file is not otherwise associated
>> with CXL Port management.
>>
>> Additional CXL Port RAS initialization will be added in future patches to
>> support a CXL Port device's CXL errors.
> Is this the part that Jonathan recommended moving to cxl/core/ras.c?
>
> DJ
Correct.

Terry
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c  | 73 --------------------------------------
>>  drivers/cxl/core/regs.c |  2 ++
>>  drivers/cxl/cxl.h       |  6 ++++
>>  drivers/cxl/port.c      | 78 +++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 86 insertions(+), 73 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index b50551601c2e..317cd0a91ffe 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -748,79 +748,6 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
>>  
>> -static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>> -{
>> -	resource_size_t aer_phys;
>> -	struct device *host;
>> -	u16 aer_cap;
>> -
>> -	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
>> -	if (aer_cap) {
>> -		host = dport->reg_map.host;
>> -		aer_phys = aer_cap + dport->rcrb.base;
>> -		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
>> -						sizeof(struct aer_capability_regs));
>> -	}
>> -}
>> -
>> -static void cxl_dport_map_ras(struct cxl_dport *dport)
>> -{
>> -	struct cxl_register_map *map = &dport->reg_map;
>> -	struct device *dev = dport->dport_dev;
>> -
>> -	if (!map->component_map.ras.valid)
>> -		dev_dbg(dev, "RAS registers not found\n");
>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> -		dev_dbg(dev, "Failed to map RAS capability.\n");
>> -}
>> -
>> -static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>> -{
>> -	void __iomem *aer_base = dport->regs.dport_aer;
>> -	u32 aer_cmd_mask, aer_cmd;
>> -
>> -	if (!aer_base)
>> -		return;
>> -
>> -	/*
>> -	 * Disable RCH root port command interrupts.
>> -	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>> -	 *
>> -	 * This sequence may not be necessary. CXL spec states disabling
>> -	 * the root cmd register's interrupts is required. But, PCI spec
>> -	 * shows these are disabled by default on reset.
>> -	 */
>> -	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>> -			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>> -			PCI_ERR_ROOT_CMD_FATAL_EN);
>> -	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>> -	aer_cmd &= ~aer_cmd_mask;
>> -	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>> -}
>> -
>> -/**
>> - * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>> - * @dport: the cxl_dport that needs to be initialized
>> - * @host: host device for devm operations
>> - */
>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>> -{
>> -	dport->reg_map.host = host;
>> -	cxl_dport_map_ras(dport);
>> -
>> -	if (dport->rch) {
>> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>> -
>> -		if (!host_bridge->native_aer)
>> -			return;
>> -
>> -		cxl_dport_map_rch_aer(dport);
>> -		cxl_disable_rch_root_ints(dport);
>> -	}
>> -}
>> -EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>> -
>>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>>  					  struct cxl_dport *dport)
>>  {
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 5ca7b0eed568..b8e767a9571c 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>>  
>>  	return ret_val;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>>  
>>  int cxl_map_component_regs(const struct cxl_register_map *map,
>>  			   struct cxl_component_regs *regs,
>> @@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>>  
>>  	return offset;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>>  
>>  static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>>  {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index ba08b77b65da..0dc43bfba76a 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -313,6 +313,12 @@ int cxl_setup_regs(struct cxl_register_map *map);
>>  struct cxl_dport;
>>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>  					   struct cxl_dport *dport);
>> +
>> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>> +
>> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>> +				   resource_size_t length);
>> +
>>  int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>>  
>>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index fe4b593331da..7b61f09347a5 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -6,6 +6,7 @@
>>  
>>  #include "cxlmem.h"
>>  #include "cxlpci.h"
>> +#include "cxl.h"
>>  
>>  /**
>>   * DOC: cxl port
>> @@ -57,6 +58,83 @@ static int discover_region(struct device *dev, void *unused)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>> +
>> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>> +{
>> +	resource_size_t aer_phys;
>> +	struct device *host;
>> +	u16 aer_cap;
>> +
>> +	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
>> +	if (aer_cap) {
>> +		host = dport->reg_map.host;
>> +		aer_phys = aer_cap + dport->rcrb.base;
>> +		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
>> +						sizeof(struct aer_capability_regs));
>> +	}
>> +}
>> +
>> +static void cxl_dport_map_ras(struct cxl_dport *dport)
>> +{
>> +	struct cxl_register_map *map = &dport->reg_map;
>> +	struct device *dev = dport->dport_dev;
>> +
>> +	if (!map->component_map.ras.valid)
>> +		dev_dbg(dev, "RAS registers not found\n");
>> +	else if (cxl_map_component_regs(map, &dport->regs.component,
>> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +		dev_dbg(dev, "Failed to map RAS capability.\n");
>> +}
>> +
>> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>> +{
>> +	void __iomem *aer_base = dport->regs.dport_aer;
>> +	u32 aer_cmd_mask, aer_cmd;
>> +
>> +	if (!aer_base)
>> +		return;
>> +
>> +	/*
>> +	 * Disable RCH root port command interrupts.
>> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>> +	 *
>> +	 * This sequence may not be necessary. CXL spec states disabling
>> +	 * the root cmd register's interrupts is required. But, PCI spec
>> +	 * shows these are disabled by default on reset.
>> +	 */
>> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>> +			PCI_ERR_ROOT_CMD_FATAL_EN);
>> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>> +	aer_cmd &= ~aer_cmd_mask;
>> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>> +}
>> +
>> +/**
>> + * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>> + * @dport: the cxl_dport that needs to be initialized
>> + * @host: host device for devm operations
>> + */
>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>> +{
>> +	dport->reg_map.host = host;
>> +	cxl_dport_map_ras(dport);
>> +
>> +	if (dport->rch) {
>> +		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>> +
>> +		if (!host_bridge->native_aer)
>> +			return;
>> +
>> +		cxl_dport_map_rch_aer(dport);
>> +		cxl_disable_rch_root_ints(dport);
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>> +
>> +#endif /* CONFIG_PCIEAER_CXL */
>> +
>>  static int cxl_switch_port_probe(struct cxl_port *port)
>>  {
>>  	struct cxl_hdm *cxlhdm;


