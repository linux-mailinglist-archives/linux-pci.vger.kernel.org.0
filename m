Return-Path: <linux-pci+bounces-29100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8A6AD042F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 16:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542543A25CC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C0615A848;
	Fri,  6 Jun 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mA+R/3SJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B1E199931;
	Fri,  6 Jun 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749220897; cv=fail; b=To7BVL+e8iIJFzv0VP+VpgL2M27dyVj29T/hfscZQ1o7u2hwINWKpFuunxAeQxIoxMg0YZpNjjT5k+wt5uO4vS/Fr1R+GjV1hXJz0EMo3y4CeyJpouT0YBFK4I+7gXh67USwNESE3HyVk6+5XRfqqTmxbP8A4dnIljJpTXbcGA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749220897; c=relaxed/simple;
	bh=IhzdR4Cog/rwAXoM9UnVtTmzBGXYX37lWXfAe7ie0X8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=htWKnOaHNPII0f5Uk/QoLQpiSHerMV9HEZF9MtOqFubeBF/QvznKOBqxwu3s7uGNgP8Tr9YaJGYD1kUkupk/+Kqi9E+G03rtK72J3Rl2oXPesOQ/DeSx3nMlW61UOj3or7HYOHDXhc3Jd+U5RwTMVsW691VsZizo5I2ceNNx7VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mA+R/3SJ; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJyt/gU5R72rVUrxFI1AxEEdp7jZAT5+Btu4wHnFD6hKKCu3lVuWfAHRgN1ETwMw3nZlHqZ9+Vh+sppmDFILpOnEql+MDEMzOjGcTNGv9n2wz32Su5SmGMzEScGuRGDqBm1Vt9wA+36PMpwjZEPzUqlmAl2cN5HEEP3CYLJ9kMW12UrdaC70V9Ry1tHOqNgYwr4f8rYLTzzPffZl9PGrSoEkBs/TIk18K+td3UaYosP9SOBaWHvjGg9vIQ/wbakagtyWLgQGlhCXeGzqdaTfTgvjXAlGwwrRWDqAWLJ8MZs/W5vwOm5rq34oxgMT3jJjHvJAywKmyIYCKBo/pTezHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLUbPqwG8qoL4f2BszTyZOEW6ywf65c6kofBmw6T9s8=;
 b=optUcTg9DKD718F21HvxR28UgaZwVdiPlb4NMM4QiEwBgZwv0TvPeULUyh7kPZQ5ObAwQXDYNoqoz0jrE6sGtjp5mA5OvupTdZGvzePgG9RcDCOeYNz91Qez/GxW3igehMZ4tneDXATcmzaACfZil38ExI9CZaurKn94GurKnLGcJXozXh91rdpOMRospqxF3XY/NgVoVnldwuWQOodLXcgPd9fSdisb5jFlHQIJVtk+spxXYvgygb+cMNMCCtL3WK2LEdagkd4t3cVg26XlhPSOW9V8KimsC95aeYIm5Sf2hkgLH82EQRmcfPYgSRA8otj8r+9sNLyh0+h3Xflc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLUbPqwG8qoL4f2BszTyZOEW6ywf65c6kofBmw6T9s8=;
 b=mA+R/3SJOuXjtKd8Jio753l3p6lOjdl6g5WayKpBxEy/updpM20vxAxSFxn+Rgp4JAOfrqGqKibNUndz7g8BvmaQdVXOOpx8y+AzMaPtbAdToPFj3U/BXhTI0o/UwjKjNDZT3jF2yqBOdmZ4Nr91AEAFddBB8V5W/q7OrhYbbjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH1PPF4C9628624.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 6 Jun
 2025 14:41:32 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 14:41:32 +0000
Message-ID: <3e022f34-ad65-4caa-9321-c181bb8ae676@amd.com>
Date: Fri, 6 Jun 2025 09:41:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
To: Shiju Jose <shiju.jose@huawei.com>,
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>,
 "kobayashi.da-06@fujitsu.com" <kobayashi.da-06@fujitsu.com>,
 "yanfei.xu@intel.com" <yanfei.xu@intel.com>,
 "rrichter@amd.com" <rrichter@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "colyli@suse.de" <colyli@suse.de>,
 "uaisheng.ye@intel.com" <uaisheng.ye@intel.com>,
 "fabio.m.de.francesco@linux.intel.com"
 <fabio.m.de.francesco@linux.intel.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-11-terry.bowman@amd.com>
 <959acc682e6e4b52ac0283b37ee21026@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <959acc682e6e4b52ac0283b37ee21026@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::35) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH1PPF4C9628624:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d38829b-1424-4dd4-77aa-08dda5083ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVh1V21vNnJGUVlYZ2c4RUwrYWxkaUFLV1NBSm9uWjd3NmY2Q0pzRWxrZjhi?=
 =?utf-8?B?UHlud2NXTHVYQTNIRjRDSURKMFpWZ0MvbXl3YlY4VzBneUI2cWIzcVBadlda?=
 =?utf-8?B?K3BzVzZSVkwzRlh2anhpVXpuRVJRZHdIUmM0cWZ4QXNYWFlIeFBtMWYxQlZB?=
 =?utf-8?B?M1h1WkYrNXdleENxRTNzY0haRis4bDFFYWlNUThTMVdrcTYydE9NaHZ2VnFi?=
 =?utf-8?B?MWhDOGxTbEwxbEtIR3YvUEpHSUR3R3ZGdTNSczFnaEo2V3hPamNtOC8wMWh5?=
 =?utf-8?B?Z2FoUWp1R041MHMxeGptdVhDbFlQM0NxWFIrejI2TnZjc3JrMHVLejljeUE0?=
 =?utf-8?B?cEk4VTBYZjkzVDBtY0lKbHZ3RmY0MlcrWTR4KzFiMmh6Zkg3WFNpclh5LzVU?=
 =?utf-8?B?VDBVRnVZa0tQVUt1bzdrVjhhWDZiNVg3L1pTQjRPQTFLd0pHL3ZnSnZJcXFJ?=
 =?utf-8?B?OFFRbi83ZzhFYU5vazdRNWg4TFJNTlM3MUYzMjlYdDgra04ydCtmaWtsS2xZ?=
 =?utf-8?B?Z3pUNk5SOFlIbDRHN2tWTldtanlqYzBQbXNqNytTMW1BZ1dGTXROU3MyMXpp?=
 =?utf-8?B?VzBJYmRQbExrYXVlcnpCemdMSmFBRWZnR2hHNjJBdXVPbWUwWDFHdTBMbGpQ?=
 =?utf-8?B?R0RKTGxaQTBPY3pSNVhMV3dUREpRNmZVMllPY0d0anlCY2FiYmJpM1lpOGhM?=
 =?utf-8?B?VWNPQnM1VE5NY0hham5PZUlsbWF0TE1Lc21rVzdIUEtLUVBtc2x1VGp5a1FJ?=
 =?utf-8?B?eFNyQ1JsV0EweGUzd1B5b3lrNW5mTlZ0VWFnTDEwa0RNVFhrZWwzaHFuM1FB?=
 =?utf-8?B?cm51THVXVXNOOXQvYWZPZUVzVzlKR2Y3WTVENFFQaGhRUEQrdGFqUnEzRngz?=
 =?utf-8?B?akNIYm95S1dHM1MwWklJcUZWSkk3c043WEhVd3NFVnd5S0pyV3gxTjRBVXAx?=
 =?utf-8?B?YlIxdHY5RUc0bWE1MUVSOHFmWTlaZStraW1YT1h0UjNCbEZENkFnM3BMclpj?=
 =?utf-8?B?Q1I2Wm0yUkNpMmhqR21rRlZZYU9qT096cGtGU3lrZTNDcXRGUGwvNDJPNExv?=
 =?utf-8?B?Q3ErN3BQb2Nrc1hrelRVdVkvV2ovSk91TDF0dHJKdnAzVlFWMEFWRDZtckNK?=
 =?utf-8?B?c3hsUlExU3ExM0tXdWNXd0lFWlZwbkd2MUZjT1REa3lTVGljMXFrOUE3VXpL?=
 =?utf-8?B?VjBhQ0JLbkxpdVpZajdaSVZrOFJENmRjdGthU3QwTHBUODBySUdRR0M3Zk9H?=
 =?utf-8?B?OTJKQXY5dVF2UUdaeStjaHBZd3lidlBCdkFQME5oeUVzbVUxa1ZacDVQMGw2?=
 =?utf-8?B?VEk4UnZRYzhpUjRkK3NzRUgxd3RsLzVmVVB1SVlLL0svQjhWWC9FSVlaWE9S?=
 =?utf-8?B?V2JGeG9YQy9oelNRbzBFaW51eHlCVEk0aTgrcVdPVWxpMzVZRkw2UytDTml1?=
 =?utf-8?B?S2RqbDF6U3pVRmdTUFJqOXI0WVV3QXBvS2N6RWFxQm9tZ3ZObkxpUDN3Mmhy?=
 =?utf-8?B?TUZ4bHV3QlUxS0hLS1hsZ2Q3dkZ5S0R1Wk9YaUQ2c2phUjM0eHdjS2daL29r?=
 =?utf-8?B?eTF4Sk8rSnZHUi9SMmhBbU45NUJpcWdyVW51T0J4VXp6ZnlIa0U4d1Y3V0Iz?=
 =?utf-8?B?MzVvMXl0cGdZdE9lTkpXcUZydjM2MFJVZXVsU0FVOS9rYnpxSGZ3a2pueVYr?=
 =?utf-8?B?RnhnTHFvNnd5UFRaUnZIL2dISGFKZ0M4eXhDSFN6NTJQWDJSY3pBeVU1U2pT?=
 =?utf-8?B?TzVrYWVNQzFIWjFwUWliUmtNcnRuMjdsanRtNDAwbGRtcnZsVTFlNitTZk9L?=
 =?utf-8?B?NERCbW1QU2U5RzJ6WHgweDY3RTE5OWVESmEzWFJkOGIzN1d4L2hGNnpyRlZE?=
 =?utf-8?B?VlFDd2tqTkRocmR0dXV5bVNvVU9nSUtIekl1NUNzWitnV2pUd0FmMzhOSEVr?=
 =?utf-8?B?RG1FRVlCemcrbEVpVUgyWDBrNGZzYUJsMnZoZCtIcEJMa3Q2Rm9nZlp1TUZX?=
 =?utf-8?B?TkxYVDFRMUd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3RYbDJvbFpIZFByRzJKVW15VGFHMk9xZ2YyQi9KN0IxbGFnYXhySWtxcHUw?=
 =?utf-8?B?TU5aT2lZYkplSzlwcDAwY3ZOVXdVcW9DMTE3U0NPR1d3MTBFaFloTmJXNEFE?=
 =?utf-8?B?a2I0UWdPYis2WFdDNk9yUERKU1VvYitoYmpBdzdUdzgzMll4eS9IdUtFaVZj?=
 =?utf-8?B?OG5HdTVEME01RGtVak9ZcHNkTXM2OFBjenJGKy9oV3hQQzNuQzVpN2tCKzJO?=
 =?utf-8?B?S3lXNjF1VkpJQ240RU96RnM3blJ1NTZ3U3VuT1hLZUNTTXB4TUkzcUMvbVlS?=
 =?utf-8?B?bFVxSTJWbUQ5anArTmVwaUh2dUd1Q3ZFMFFkaHR0aTJKOE1UbXRYQnY5dEd5?=
 =?utf-8?B?QWtsUk50MCtUVE1tQjNxK09QZ1grYTQrRXcrdDRlaGE5L0RmUmVnM1RwTGhX?=
 =?utf-8?B?amJyWlgrSzFjTklaSU1JNkVMUHFaaGtuY3lJWnRXS3hlTERIVlBPZGZBMlRS?=
 =?utf-8?B?Wmt0bkxpODNSM1pTVUQ3Qk1acTRaVHY1TFpGNXJ6WW5rblNRNmRrRmN2R1JX?=
 =?utf-8?B?TTcxQU4xc1FrUThSSEludFViRy9qM3pPZEh6V2tYckJLaXFIQjVKQS96YWpN?=
 =?utf-8?B?dFdrbUVMNGZkc3Z6d1B4WTVXK3lraVYvTFp1Q01BM3JZK3hubUZlZXBBME9N?=
 =?utf-8?B?YTVScmtXc2dEMnRhSnBlQ21ORndWZ2c0Q1kvMlFMcGoxUEU2cTNEZmRHNjlO?=
 =?utf-8?B?SnFTS2x6aU9NTmErd2t1dXU2ZDYreXhiVXdWNExhUkFRK0pzakRrWm14T1hF?=
 =?utf-8?B?bElNaTBFQ0hqWVdTSlVTWUtjUzE4d2NFK2NFU0Q4c2hCSUpiaG1ZY0cwK1Qw?=
 =?utf-8?B?ajVFVHg0NXVERzJMaHZLR3R1UkU1QVpDZWVmVUovNkhDMWJZVm4xNWw0aXRt?=
 =?utf-8?B?ZStVZkxMWm9TZjkzY0NHcUpmc244K2Ntdi9ZTVkyNjB6M29YaGprOSsyZGNF?=
 =?utf-8?B?UDk4WjREdGplaTJidlFsVGhyVkU3OWljSFErSmtvRFhPblhuRTdRVjBtbFlJ?=
 =?utf-8?B?T041Nm9SUSt0V1NkZ1hIS3cwelEzZE9iWnhhMzZGK01kN1g1UlBkS3VRKzV6?=
 =?utf-8?B?MldHbWZwaHMwMXlJY1R4VkJGOXZNZXltSTBmZ0R6U2JHQUp2K1ZiMm9zek9Q?=
 =?utf-8?B?UVd1ZEFzRERsVjJsWkdCN3NJVERWQVdsdWl4aS9YNUdMRG5zb1VORkxsNXBV?=
 =?utf-8?B?emtHQzA3cHFHTFdRdnlUenEyZy9CTVZ1b3pWUWhIaU12T1YzVStFTVh3TkVY?=
 =?utf-8?B?anZocHBucXRKZGdWTENRRmEzb2ROa2RqdEpNR2RHT2RrakZhRW8vSHZUVG1O?=
 =?utf-8?B?cndyTEFyM3ZNZVU5VTNkc2J4c0x1aitRVDFRbnVGb2N6SUdWUEVqekNCQjNY?=
 =?utf-8?B?SHY4ZzR3OEVVaVV4bjIyU3lXMnp6alBxbi81bHFTYkIyVFpBczZDblRUa2lN?=
 =?utf-8?B?cjdXd2czOGpmaHlnRjlic1F2eXhydXZwaUdCVTA2MVdVK2FDc0drMlA2VUlC?=
 =?utf-8?B?aGxsb1JqblU4WkxGdFAwTnE4WUM4SFpIVnVaWFJzSHFRTkNQMW9IQ3p0ZktD?=
 =?utf-8?B?VWp1c2FHaWhsM3BMN3BKQTFia2xZNE1kcytaNW9xYzVrVW9MTmZ2dnBmUDBO?=
 =?utf-8?B?V3kwS200M291N3cyc1NOVm5HWk83dGdIRElmWTF4OFhDZlcvNU9lNXZYTHEy?=
 =?utf-8?B?aXhhZzRYUi9VeGJtUTNPSnlsdmJYV1o1SDZKcGY3N2ZiM0V1cmFaQlgzYUhq?=
 =?utf-8?B?R1krQkJOemhxcHpGaEcxc0ZWRzBVZ1ViK3lpVm15WWtqN1liNHlIbW1zcVdG?=
 =?utf-8?B?d21QS0pPM1JVaGwzQUxudGVzQ29uYkRPdkw5Y0plQkV6T3dzcGw5QVVqQTVu?=
 =?utf-8?B?Yy9ndktmYnI1emxIQ2FpT2JORGJEOXVQYUMxczdBN2lKRVQ5YW16WUpwU2Qv?=
 =?utf-8?B?ZUtFTFppdG4rbzcwQmxjVnRJSDRmOExEeUV1VWpPdDlHdDdvd3N6Z2ZFWnMv?=
 =?utf-8?B?SVNOY2NkYThhd2JVdTdwbEtxa2RBQ3FQNmZHcGViTk1zY21URGh2NllsQUxG?=
 =?utf-8?B?N3VsT2ppUzlDRUcrRytCb3VuZzZqTVZqc0EyRzVOakgzOFdXLzVodVpIdm43?=
 =?utf-8?Q?iZj/wkjDKpuTYYkJ9lVvwxRar?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d38829b-1424-4dd4-77aa-08dda5083ac0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 14:41:32.2185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzssbnIBj8I7PC1CQfPBreho6enpVfJ1+riUKwGDI2JylIHycn1UoRSD3tV5nJ14aRY2H+nTes0ZXpzbiLP5EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4C9628624



On 6/6/2025 4:08 AM, Shiju Jose wrote:
>> -----Original Message-----
>> From: Terry Bowman <terry.bowman@amd.com>
>> Sent: 03 June 2025 18:23
>> To: PradeepVineshReddy.Kodamati@amd.com; dave@stgolabs.net; Jonathan
>> Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>> alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>> dan.j.williams@intel.com; bhelgaas@google.com; bp@alien8.de;
>> ming.li@zohomail.com; Shiju Jose <shiju.jose@huawei.com>;
>> dan.carpenter@linaro.org; Smita.KoralahalliChannabasappa@amd.com;
>> kobayashi.da-06@fujitsu.com; terry.bowman@amd.com; yanfei.xu@intel.com;
>> rrichter@amd.com; peterz@infradead.org; colyli@suse.de;
>> uaisheng.ye@intel.com; fabio.m.de.francesco@linux.intel.com;
>> ilpo.jarvinen@linux.intel.com; yazen.ghannam@amd.com; linux-
>> cxl@vger.kernel.org; linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
>> Subject: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL Endpoints and
>> CXL Ports
>>
>> CXL currently has separate trace routines for CXL Port errors and CXL Endpoint
>> errors. This is inconvenient for the user because they must enable
>> 2 sets of trace routines. Make updates to the trace logging such that a single
>> trace routine logs both CXL Endpoint and CXL Port protocol errors.
>>
>> Rename the 'host' field from the CXL Endpoint trace to 'parent' in the unified
>> trace routines. 'host' does not correctly apply to CXL Port devices. Parent is more
>> general and applies to CXL Port devices and CXL Endpoints.
>>
>> Add serial number parameter to the trace logging. This is used for EPs and 0 is
>> provided for CXL port devices without a serial number.
>>
>> Below is output of correctable and uncorrectable protocol error logging.
>> CXL Root Port and CXL Endpoint examples are included below.
>>
>> Root Port:
>> cxl_aer_correctable_error: device=0000:0c:00.0 parent=pci0000:0c serial: 0
>> status='CRC Threshold Hit'
>> cxl_aer_uncorrectable_error: device=0000:0c:00.0 parent=pci0000:0c serial: 0
>> status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity
>> Error'
>>
>> Endpoint:
>> cxl_aer_correctable_error: device=mem3 parent=0000:0f:00.0 serial=0
>> status='CRC Threshold Hit'
>> cxl_aer_uncorrectable_error: device=mem3 parent=0000:0f:00.0 serial: 0
>> status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity
>> Error'
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>> drivers/cxl/core/pci.c   | 18 +++++----
>> drivers/cxl/core/ras.c   | 14 ++++---
>> drivers/cxl/core/trace.h | 84 +++++++++-------------------------------
>> 3 files changed, 37 insertions(+), 79 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c index
>> 186a5a20b951..0f4c07fd64a5 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -664,7 +664,7 @@ void read_cdat_data(struct cxl_port *port)  }
>> EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>>
> [...]
>> static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data
>> *data) diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
>> 25ebfbc1616c..8c91b0f3d165 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -48,49 +48,22 @@
>> 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>> )
>>
>> -TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> -	TP_ARGS(dev, status, fe, hl),
>> -	TP_STRUCT__entry(
>> -		__string(device, dev_name(dev))
>> -		__string(host, dev_name(dev->parent))
>> -		__field(u32, status)
>> -		__field(u32, first_error)
>> -		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>> -	),
>> -	TP_fast_assign(
>> -		__assign_str(device);
>> -		__assign_str(host);
>> -		__entry->status = status;
>> -		__entry->first_error = fe;
>> -		/*
>> -		 * Embed the 512B headerlog data for user app retrieval and
>> -		 * parsing, but no need to print this in the trace buffer.
>> -		 */
>> -		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>> -	),
>> -	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
>> -		  __get_str(device), __get_str(host),
>> -		  show_uc_errs(__entry->status),
>> -		  show_uc_errs(__entry->first_error)
>> -	)
>> -);
>> -
>> TRACE_EVENT(cxl_aer_uncorrectable_error,
>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32
>> *hl),
>> -	TP_ARGS(cxlmd, status, fe, hl),
>> +	TP_PROTO(struct device *dev, u64 serial, u32 status, u32 fe,
>> +		 u32 *hl),
>> +	TP_ARGS(dev, serial, status, fe, hl),
>> 	TP_STRUCT__entry(
>> -		__string(memdev, dev_name(&cxlmd->dev))
>> -		__string(host, dev_name(cxlmd->dev.parent))
>> +		__string(name, dev_name(dev))
>> +		__string(parent, dev_name(dev->parent))
> Hi Terry,
>
> As we pointed out in v8, renaming the fields "memdev" to "name" and "host" to "parent"
> causes issues and failures in userspace rasdaemon  while parsing the trace event data.
> Additionally, we can't rename these fields in rasdaemon  due to backward compatibility.
Yes, I remember but didn't understand why other SW couldn't be updated to handle. I will
change as you request but many people will be confused why a port device's name is labeled
as a memdev. memdev is only correct for EPs and does not correctly reflect *any* of the
other CXL device types (RP, USP, DSP).

>> 		__field(u64, serial)
>> 		__field(u32, status)
>> 		__field(u32, first_error)
>> 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>> 	),
>> 	TP_fast_assign(
>> -		__assign_str(memdev);
>> -		__assign_str(host);
>> -		__entry->serial = cxlmd->cxlds->serial;
>> +		__assign_str(name);
>> +		__assign_str(parent);
>> +		__entry->serial = serial;
>> 		__entry->status = status;
>> 		__entry->first_error = fe;
>> 		/*
>> @@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>> 		 */
>> 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>> 	),
>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error:
>> '%s'",
>> -		  __get_str(memdev), __get_str(host), __entry->serial,
>> +	TP_printk("device=%s parent=%s serial=%lld status='%s'
>> first_error='%s'",
>> +		  __get_str(name), __get_str(parent), __entry->serial,
>> 		  show_uc_errs(__entry->status),
>> 		  show_uc_errs(__entry->first_error)
>> 	)
>> @@ -124,42 +97,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>> 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer"
>> }	\
>> )
>>
>> -TRACE_EVENT(cxl_port_aer_correctable_error,
>> -	TP_PROTO(struct device *dev, u32 status),
>> -	TP_ARGS(dev, status),
>> -	TP_STRUCT__entry(
>> -		__string(device, dev_name(dev))
>> -		__string(host, dev_name(dev->parent))
>> -		__field(u32, status)
>> -	),
>> -	TP_fast_assign(
>> -		__assign_str(device);
>> -		__assign_str(host);
>> -		__entry->status = status;
>> -	),
>> -	TP_printk("device=%s host=%s status='%s'",
>> -		  __get_str(device), __get_str(host),
>> -		  show_ce_errs(__entry->status)
>> -	)
>> -);
>> -
>> TRACE_EVENT(cxl_aer_correctable_error,
>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>> -	TP_ARGS(cxlmd, status),
>> +	TP_PROTO(struct device *dev, u64 serial, u32 status),
>> +	TP_ARGS(dev, serial, status),
>> 	TP_STRUCT__entry(
>> -		__string(memdev, dev_name(&cxlmd->dev))
>> -		__string(host, dev_name(cxlmd->dev.parent))
>> +		__string(name, dev_name(dev))
>> +		__string(parent, dev_name(dev->parent))
> Renaming these fields is an issue for userspace as mentioned above 
> in cxl_aer_uncorrectable_error.
I understand, I'll revert as you request.

Terry
>> 		__field(u64, serial)
>> 		__field(u32, status)
>> 	),
>> 	TP_fast_assign(
>> -		__assign_str(memdev);
>> -		__assign_str(host);
>> -		__entry->serial = cxlmd->cxlds->serial;
>> +		__assign_str(name);
>> +		__assign_str(parent);
>> +		__entry->serial = serial;
>> 		__entry->status = status;
>> 	),
>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
>> -		  __get_str(memdev), __get_str(host), __entry->serial,
>> +	TP_printk("device=%s parent=%s serial=%lld status='%s'",
>> +		  __get_str(name), __get_str(parent), __entry->serial,
>> 		  show_ce_errs(__entry->status)
>> 	)
>> );
>> --
>> 2.34.1
>
> Thanks,
> Shiju


