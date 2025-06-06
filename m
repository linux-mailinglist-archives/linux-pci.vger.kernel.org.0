Return-Path: <linux-pci+bounces-29101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D1AD051D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 17:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138BD172B86
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6B62868A5;
	Fri,  6 Jun 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r7pF90pF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B69126C17;
	Fri,  6 Jun 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223484; cv=fail; b=tnfMmmw88JN6jZ9cUBCDf1xyiRIO9J2ysISmAZFeBdMoSW9o6FMJkIFe+QFZfdviZJ3VP6vvBdShXGjDeBtDjQqDZ3gTRZ7KuTwMNbShFfFmECWFuf0fxVaLHq0z+HSELRRqsFyfMXwAq8COxOIOveC98K3hcKcxWhFAkJ0XXvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223484; c=relaxed/simple;
	bh=ntscqIPWcgDNAVjoC62X78VjHbpdfg1YMoHLbAmtur8=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rZf/lwaZPIO8qpnjvon4s20tmJT28jl/1sGqUxunKDT5ODn6E1YIWbYIi28DLz/sxbp93G27Wv0/QhxZkVoYOeVPKKOSsQlxlqBp/jRqilViAEkb1cmwk9Q5uOpN9cY9W/E7PtgFCvmMcddIamsWui32hrTsIfB6hcbtjvHdjNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r7pF90pF; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caiOKZCEFUPWmKcCdtgxv5pZg/Rp1mJ8jT8cPJp9zNC/ju0uKIKcy92gbrMX6aVQ7mJ9290K9aaFHlasZQRzBkCJnzXtrFJ0yL8SlM1jX+H/LZ+cCEEfs2pPigqJze6F3gzPz6eZrQQWdr1UrTXDs603qs+FfUhHVot6mAZos6lvs3YaH2QEugH3GmIgjzomkbcluZEnPi4dF/81eW8WsK6phtQfvsFrQUOKEzIa+/NN29QcQohn/gyYinILTeXtaURCSxB1TiAN1HHqGqw9iKCYWccOLD+Xp8vpzi/nLZezMyrtbSWfFxQHt0aprSWaLKwuV4T+8su2MXJJ7ogDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOODe3MzEc0knQOg8Mgea4We0rj78J2xmOkNfi9E+yg=;
 b=mx0DVIazhPjCow9p4m/yQh10rJ9HRe+/o/hgtYCOtE9XRaJPc9hUpcnO72M+f+5eRDGlojW0EtgI0wkpq5NFm6GEKXz6Ts7JzZKGBfvS5Nn0mNcZS/77fmdMMW6ikzkOapq0vD0YOF8GI79VW0rsHLcY+bBeTo1//B5vaaiPzqOt+Ni2VGlObXP42Gu78z4w33zq9L/iZBBO3E8iKCyJtoSR8BLb8mvKWuoDoXEEWcx8GE2ZkDm8miT0BMy7jBO7CddO6IS3FHXFdnqmvEwpSNxcmh62bF3z5vYE3bwvPgn5ph4eiIWzrP15AFuHR+ERHVRLtxsGZ9tpgbJYUtdwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOODe3MzEc0knQOg8Mgea4We0rj78J2xmOkNfi9E+yg=;
 b=r7pF90pFSmFYRAGBiQAnda2ir7mhpaiVwt9iR+MZxNDTBLLIWysfI2mdodd6nf2BWJLzFhbSyuC6cPIfQX16IUNH7XADiuWofEnsSUxz9mHp7kNyX0IflqHPERKtntyVeHGVxhxYMKhBxZWBge6bvep5PysHw4LRUemRL+q4nCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 15:24:40 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 15:24:39 +0000
Message-ID: <e319c9b2-742d-4fbf-8092-90a4f96d7980@amd.com>
Date: Fri, 6 Jun 2025 10:24:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
From: "Bowman, Terry" <terry.bowman@amd.com>
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
 <3e022f34-ad65-4caa-9321-c181bb8ae676@amd.com>
Content-Language: en-US
In-Reply-To: <3e022f34-ad65-4caa-9321-c181bb8ae676@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP6P284CA0042.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:1ac::18) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: f18a27ab-3d3c-4349-70a9-08dda50e410b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm4wV2VYMVlIQUorR1ozVG1Lb1c0UjloTTNLWm1YVFA3VXlSaW9CTG1YZG1B?=
 =?utf-8?B?Y1ZRU0RQbGowaXVYMnd1VUlQZkdCUkx2b0N2VVpHaU5Qa2tybm1yWVNUSC8y?=
 =?utf-8?B?REw2TXlaNXJqb0ZScU9kK3pPclBoOXhrMHoxNEZBZm5sZmEzb3YvSWgzbUJC?=
 =?utf-8?B?YVlEU0RxTWtWcEN0bFpJZFBObDdaV0xRaFpKY1UyUDRJMVg2TXlLUG1SbWxU?=
 =?utf-8?B?aERQdnN6akgrM1JYdDgrbjc4UFRwaDA0L0hxRUlISC9WcGJMRmZTTUZaT0I3?=
 =?utf-8?B?T1FoZWQyUmc2VjdRbWJtSlRMWktkUmtyTmt0a0syTm8raTNYTzE4azBqNE1j?=
 =?utf-8?B?MDNkN3h4UHQ4NEpXVTY4QjZPY0RZYngrNUJFbW9jMGo3ZUdiemxLcTVhd1ZN?=
 =?utf-8?B?VmF3bEdyVHpqU1RYY2htdWEybCtpQUxNS29EOWhOdHI2Ym5nZ09Nd0ZxVDNF?=
 =?utf-8?B?SncvOVJCcEd2bEdPNnRWdUZkT09BdHpKZ1lvd1NGSS9lekVTY0Rvc1NzSnd1?=
 =?utf-8?B?SE0vQ0ZHYzRrL2R3MVFnWGFqbDJ2RlV6MVJXTlhacys1L0s2T3VyQXZaZ0VK?=
 =?utf-8?B?RlRhai9zRnk2b1FHQURhQ0FGYXVWT1dKSXRObC85eTI2Wlhub3c2cEJYb2dO?=
 =?utf-8?B?d2tWTHpEaFAzeUlSOU95TEM1SDBGOTFRQW9kWndtWFRRbyttajNqRUFKQ2M1?=
 =?utf-8?B?UTdHMWtsN2VvQU9waGp3TUNYd25ReXBSdCsvS0trMmF1OGRtK0RubE8zcVE2?=
 =?utf-8?B?dytuMVJabk1IOVJGSXQ1V2JIaEFiYlJzYmJzalRVWmRsMUpkRnpzVUxkMmk4?=
 =?utf-8?B?TDNYVFprRVdxemJKaHpsdTBvbUU5OUJ0NmhYUERpRzNVL1owMGVUWXBidWp1?=
 =?utf-8?B?VUpzR3RWMEt1V1h6N2QzTUYvWWI3cytMajMzOGE1dDRTejdjQTd4Unl3SWx0?=
 =?utf-8?B?aFRDWkhFSHlVTTRSUVhXM3NOcWZSVmVDdlRhTkZOeVlIdjF2YmpSbGZWWUVz?=
 =?utf-8?B?bUwzYXVvcFN0anF5cWZ5aGlBVjFoMXNzaVZiV3pGV3JlTWdlWURTY0dWbTIv?=
 =?utf-8?B?QU1MYlNKcE9iMmN2K2JMZzZYbmpEcUVoNUpaSXQ5M3ppTnZvVk12cVJBVDMz?=
 =?utf-8?B?bGNjMkFaOGJVT0xLTzdVczdWbDVyVEZxRXQ2YjF4S3J2K3pyZ0h3NmFiSE9t?=
 =?utf-8?B?RFBpbmZQZ1NxQUxtdmFIbUh3a3lHUmFTV1lPWDROSVZ0VVNJWE5rZmIyWTE1?=
 =?utf-8?B?MVlvRVExcHg3eDZHQU5TYlVSaUYxeU5ER3dCTkIyMkI4ekdOTVJObnBnc2hx?=
 =?utf-8?B?cGV6eGppTVUwajYwcW1mZWxoSk5iYUJRU0lxQ3RTSXMxWEttU0crdjZtbSt2?=
 =?utf-8?B?NEh0aFBpN2Q4Uy8xcFVOR2hmWFh3TXByU0FDbjRMV2lsYVBMRVR6YmxrZUlW?=
 =?utf-8?B?blFLK0JwTkxKRjluaS9VWVR6ZktCd0xDT0Z0U2JySHhNYzNvUHk4VmptQ1B6?=
 =?utf-8?B?RmplTVU0cjNSaFdlRUxzS2ptTE5vQ1pVbHFvTzQrZWFqVUJCL2VkSU4vcXhi?=
 =?utf-8?B?alRMcWdhTTZtSWNyMi9KSVRjTHNiYis5NkpRbzJ6TDF0cnBuWFhKSlJZTjlD?=
 =?utf-8?B?U2VwZGhJOE1ZZUQvWnNYc0k1aFB1N3BldjJDMzRCaVlHc056MUhiZEVpWVJH?=
 =?utf-8?B?UVZ2ZklCUjNpbkZiRVJ2N2xhWWs5SUxqYm1hdWEwZVNja2hIMU8xNHpNWHdo?=
 =?utf-8?B?MFpzaU8vTjk2bFZ4L2E4aE1mK3VnQytDWjRvQTI2QXhyZDc2cnpvbm5wcjZQ?=
 =?utf-8?B?clc2eHg4c3BhcEExODQ4V0treGhPckViRVlxZTZJU1FhOXJyS3BzdkZCZUNB?=
 =?utf-8?B?aFFRTm4wcmJYdlVxeG5CQ0hvTkd4M25CYXlFTytld3NwU24vMDU5YWFDTG92?=
 =?utf-8?B?b1FSd0dxbjl6OUF6cE94TFlTOWVZNGdLUkpCb1NTYllPNmxLeFNBaEQvZlJK?=
 =?utf-8?B?R1BablM1VHdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWlVZnlEZWxKWE5DaEphbHhTaEZta2xycWNJcHQzdm1PWWdMa0Y1TmwyYTR3?=
 =?utf-8?B?dTlkUFIwdGNzeG5SRHZuZjF0TUgrQTJpZHk0Q0F2cDY1SU5VNmlKbmIxWFh2?=
 =?utf-8?B?cFBndWFaYldCODFsNkpjYTZ0UGNSZkVLYitJYlFiRDBJUFNkdmpCbG1uZERO?=
 =?utf-8?B?VWhvcmNta2QyTTNDQ1BBUlpMcFl1KzdkdmdyVGpLRkJNckxBNVpVbkd0SDQ0?=
 =?utf-8?B?SGxYVW11OVRtQTRodng4MUZhNWdvNW5TcVY0Zmg4OGRpUmNQeDdzR0Viajg5?=
 =?utf-8?B?Q0tLbTQvclJNZDR4eHNMOE1XVlpVR2NVSjRtbUswS0k4TUZuWVdKelRuZnps?=
 =?utf-8?B?OEkzR29KQjFUaGdVL0ZlVGJmTHh3WkxnVWdtckVlVUk5WEFuQjlBQit0MnA5?=
 =?utf-8?B?REZoWUVHRUp6MFJSQ3ZrZXJJS1BWWmlRb1ZBeEdxMTUxL2hORVlTL0ZYSlVP?=
 =?utf-8?B?dytEVVdrakVlYm55MTVqT3RITW1WVFhlemFXQkxpMEx0VUR0ZGlmaWNsdlRr?=
 =?utf-8?B?ZEtwRXdkc1AvdEk5eU9aRTVDeXpBc3QyeHhYeXdSVm1GV3dqNDdJMERCTklW?=
 =?utf-8?B?R1VRa2U4RERQaEZndWw5UDNLNG9HeCsvZXR2ZURyWmxJWllnNjdwdVV4dXlv?=
 =?utf-8?B?S0o4TFJLMEt6RHZLNTF2ekxNbUhaMDZGNUJmakk1dmNQbTdSVDBaak9ZSXlE?=
 =?utf-8?B?TzRPcFhYK0I0SmgzTU85UUorSDlYbi9wUVUzRWVMK2wrMk1zaHNnS2M3bXhB?=
 =?utf-8?B?a2F4ZTNhaE5yeVBVZ05FeUlNMDJXVVRpdEdWZCtJbk9SSnhra09sRkF6MUNt?=
 =?utf-8?B?SDhXMUVoNDdJM2dpTldudG5tRHl4QUdhc3JCNElYNU13amJMZXdXZ2k1STJL?=
 =?utf-8?B?YkFLYk5GVS9xVC8zWlRkQldrSW14RlhEZnpjRWFVQTNIZzBYNjE3czQ2Z2p0?=
 =?utf-8?B?bFpYbXVLcldnajljOWhtdmN1L2JSOWhOWFpkOEltT1gzd2FrVW9lL0R2Z1pn?=
 =?utf-8?B?TmM2ekl1dmFRUmFYYXcwUjRWV04xQ3FwZWdKWktPVFY0aW55K2toV0Izd1lI?=
 =?utf-8?B?QWt5MEJqcDJLeHY4RENnenhNZDczWlFuekFzSEVlZmxwMHhoQ3Z0NGpXTWR4?=
 =?utf-8?B?RDlINFdZUDVWTUhobkJ1bkI4Qy81aElQTldZTHRtWkZ4bFh5OSsxYTBPWUgr?=
 =?utf-8?B?Z1h6Y0d0NDExeXk4V1kxaC9HY01lZndRMHBUNXE1eUFhZ1VoTFgrSWRlM0U0?=
 =?utf-8?B?Ky9YZXViaHpVVk83NGdENDhsekIwYWZuUkVLTGNOTko0cVhvYkc4SFYvU2lh?=
 =?utf-8?B?RkhSU3JGNXEvb0Q1cmVSMDl5RUNvUEN6MVE3WFBsbld1NUtQMmxrMjBpaVdO?=
 =?utf-8?B?cTV4WllKWlpRMkFqdU1RZlBlWWcwOGpydWtpQ2hCTGhkd202Nkx4cDNlOGpB?=
 =?utf-8?B?ZVVkdWM1a3UxV0o3U3dDSU42SVB1K1h2NkVCRE13VGNRKzgyWllMc0MzT0Yv?=
 =?utf-8?B?bm5JakpxNmRMTEN1MXlEQzJZNG04SWU0QjBnY1A1Nk1pTTJzUWEwTjJhS2VB?=
 =?utf-8?B?aG5SRmtPbENPYXBNSGowbnRrMGJ4Z0FMSFRmaEkrSXk3YlhKV0VjVjhveG95?=
 =?utf-8?B?cjA2MzlCaGRYdFc5QUczRHlwTWVweG5QcVF5a2I1bUUvbUF6SW5KMkszR01D?=
 =?utf-8?B?TWt0eFRRYkhkYjRxcmJhNVJwSW5ES05ScVk4cXFPQ3dTZlJUWUQ0ZGQ1UzBi?=
 =?utf-8?B?dGNpb2RFR3hobFhkNUJzelRhbjNIN3k4c0NlV2RxM3prc2ZzeWRia01WclJ4?=
 =?utf-8?B?SDl5V0NvLzZCWERuZkJwYWsyZkh6blludjBHTG9KdktBV3dNMVhlMWxoQ080?=
 =?utf-8?B?Z3JCcENycjFUNzVPaGV1aGlOR2ZCblM5SDFvT1RXREpaeVhMelF3VDFGSzF5?=
 =?utf-8?B?bERWTWRVR2U5Y0w4ZllSZ3ZQQ1doZTVtaTlBdUVQaTB5UVBCSVBVUTUvTElp?=
 =?utf-8?B?b2FkVGsxb21ycFlNY1ZwelBzcGQyaDJUbWxzeHZQTk00RHBDekpoVTBIcGdQ?=
 =?utf-8?B?bnR6Q0lxWG5RUTA4ejA2REwrQTF2bHFxUWoxYjg4by9jNEM2WHgyVU1aNS9G?=
 =?utf-8?Q?fhG4nFBz0Q5YtR/ltTC3iEYd3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18a27ab-3d3c-4349-70a9-08dda50e410b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:24:39.8767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ev74YpPtpJ4AjcadtbL1bE8C2ht6AqTWiqatZyn073P0W42rNWw47Y/RaM8F1kprEgDf31pWSJkdPf9R0rO3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185



On 6/6/2025 9:41 AM, Bowman, Terry wrote:
>
> On 6/6/2025 4:08 AM, Shiju Jose wrote:
>>> -----Original Message-----
>>> From: Terry Bowman <terry.bowman@amd.com>
>>> Sent: 03 June 2025 18:23
>>> To: PradeepVineshReddy.Kodamati@amd.com; dave@stgolabs.net; Jonathan
>>> Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>>> alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>>> dan.j.williams@intel.com; bhelgaas@google.com; bp@alien8.de;
>>> ming.li@zohomail.com; Shiju Jose <shiju.jose@huawei.com>;
>>> dan.carpenter@linaro.org; Smita.KoralahalliChannabasappa@amd.com;
>>> kobayashi.da-06@fujitsu.com; terry.bowman@amd.com; yanfei.xu@intel.com;
>>> rrichter@amd.com; peterz@infradead.org; colyli@suse.de;
>>> uaisheng.ye@intel.com; fabio.m.de.francesco@linux.intel.com;
>>> ilpo.jarvinen@linux.intel.com; yazen.ghannam@amd.com; linux-
>>> cxl@vger.kernel.org; linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
>>> Subject: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL Endpoints and
>>> CXL Ports
>>>
>>> CXL currently has separate trace routines for CXL Port errors and CXL Endpoint
>>> errors. This is inconvenient for the user because they must enable
>>> 2 sets of trace routines. Make updates to the trace logging such that a single
>>> trace routine logs both CXL Endpoint and CXL Port protocol errors.
>>>
>>> Rename the 'host' field from the CXL Endpoint trace to 'parent' in the unified
>>> trace routines. 'host' does not correctly apply to CXL Port devices. Parent is more
>>> general and applies to CXL Port devices and CXL Endpoints.
>>>
>>> Add serial number parameter to the trace logging. This is used for EPs and 0 is
>>> provided for CXL port devices without a serial number.
>>>
>>> Below is output of correctable and uncorrectable protocol error logging.
>>> CXL Root Port and CXL Endpoint examples are included below.
>>>
>>> Root Port:
>>> cxl_aer_correctable_error: device=0000:0c:00.0 parent=pci0000:0c serial: 0
>>> status='CRC Threshold Hit'
>>> cxl_aer_uncorrectable_error: device=0000:0c:00.0 parent=pci0000:0c serial: 0
>>> status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity
>>> Error'
>>>
>>> Endpoint:
>>> cxl_aer_correctable_error: device=mem3 parent=0000:0f:00.0 serial=0
>>> status='CRC Threshold Hit'
>>> cxl_aer_uncorrectable_error: device=mem3 parent=0000:0f:00.0 serial: 0
>>> status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity
>>> Error'
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> ---
>>> drivers/cxl/core/pci.c   | 18 +++++----
>>> drivers/cxl/core/ras.c   | 14 ++++---
>>> drivers/cxl/core/trace.h | 84 +++++++++-------------------------------
>>> 3 files changed, 37 insertions(+), 79 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c index
>>> 186a5a20b951..0f4c07fd64a5 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -664,7 +664,7 @@ void read_cdat_data(struct cxl_port *port)  }
>>> EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>>>
>> [...]
>>> static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data
>>> *data) diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
>>> 25ebfbc1616c..8c91b0f3d165 100644
>>> --- a/drivers/cxl/core/trace.h
>>> +++ b/drivers/cxl/core/trace.h
>>> @@ -48,49 +48,22 @@
>>> 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>>> )
>>>
>>> -TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>>> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>>> -	TP_ARGS(dev, status, fe, hl),
>>> -	TP_STRUCT__entry(
>>> -		__string(device, dev_name(dev))
>>> -		__string(host, dev_name(dev->parent))
>>> -		__field(u32, status)
>>> -		__field(u32, first_error)
>>> -		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>>> -	),
>>> -	TP_fast_assign(
>>> -		__assign_str(device);
>>> -		__assign_str(host);
>>> -		__entry->status = status;
>>> -		__entry->first_error = fe;
>>> -		/*
>>> -		 * Embed the 512B headerlog data for user app retrieval and
>>> -		 * parsing, but no need to print this in the trace buffer.
>>> -		 */
>>> -		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>>> -	),
>>> -	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
>>> -		  __get_str(device), __get_str(host),
>>> -		  show_uc_errs(__entry->status),
>>> -		  show_uc_errs(__entry->first_error)
>>> -	)
>>> -);
>>> -
>>> TRACE_EVENT(cxl_aer_uncorrectable_error,
>>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32
>>> *hl),
>>> -	TP_ARGS(cxlmd, status, fe, hl),
>>> +	TP_PROTO(struct device *dev, u64 serial, u32 status, u32 fe,
>>> +		 u32 *hl),
>>> +	TP_ARGS(dev, serial, status, fe, hl),
>>> 	TP_STRUCT__entry(
>>> -		__string(memdev, dev_name(&cxlmd->dev))
>>> -		__string(host, dev_name(cxlmd->dev.parent))
>>> +		__string(name, dev_name(dev))
>>> +		__string(parent, dev_name(dev->parent))
>> Hi Terry,
>>
>> As we pointed out in v8, renaming the fields "memdev" to "name" and "host" to "parent"
>> causes issues and failures in userspace rasdaemon  while parsing the trace event data.
>> Additionally, we can't rename these fields in rasdaemon  due to backward compatibility.
> Yes, I remember but didn't understand why other SW couldn't be updated to handle. I will
> change as you request but many people will be confused why a port device's name is labeled
> as a memdev. memdev is only correct for EPs and does not correctly reflect *any* of the
> other CXL device types (RP, USP, DSP).
>
>>> 		__field(u64, serial)
>>> 		__field(u32, status)
>>> 		__field(u32, first_error)
>>> 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>>> 	),
>>> 	TP_fast_assign(
>>> -		__assign_str(memdev);
>>> -		__assign_str(host);
>>> -		__entry->serial = cxlmd->cxlds->serial;
>>> +		__assign_str(name);
>>> +		__assign_str(parent);
>>> +		__entry->serial = serial;
>>> 		__entry->status = status;
>>> 		__entry->first_error = fe;
>>> 		/*
>>> @@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>> 		 */
>>> 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>>> 	),
>>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error:
>>> '%s'",
>>> -		  __get_str(memdev), __get_str(host), __entry->serial,
>>> +	TP_printk("device=%s parent=%s serial=%lld status='%s'
>>> first_error='%s'",
>>> +		  __get_str(name), __get_str(parent), __entry->serial,
>>> 		  show_uc_errs(__entry->status),
>>> 		  show_uc_errs(__entry->first_error)
>>> 	)
>>> @@ -124,42 +97,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>> 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer"
>>> }	\
>>> )
>>>
>>> -TRACE_EVENT(cxl_port_aer_correctable_error,
>>> -	TP_PROTO(struct device *dev, u32 status),
>>> -	TP_ARGS(dev, status),
>>> -	TP_STRUCT__entry(
>>> -		__string(device, dev_name(dev))
>>> -		__string(host, dev_name(dev->parent))
>>> -		__field(u32, status)
>>> -	),
>>> -	TP_fast_assign(
>>> -		__assign_str(device);
>>> -		__assign_str(host);
>>> -		__entry->status = status;
>>> -	),
>>> -	TP_printk("device=%s host=%s status='%s'",
>>> -		  __get_str(device), __get_str(host),
>>> -		  show_ce_errs(__entry->status)
>>> -	)
>>> -);
>>> -
>>> TRACE_EVENT(cxl_aer_correctable_error,
>>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>>> -	TP_ARGS(cxlmd, status),
>>> +	TP_PROTO(struct device *dev, u64 serial, u32 status),
>>> +	TP_ARGS(dev, serial, status),
>>> 	TP_STRUCT__entry(
>>> -		__string(memdev, dev_name(&cxlmd->dev))
>>> -		__string(host, dev_name(cxlmd->dev.parent))
>>> +		__string(name, dev_name(dev))
>>> +		__string(parent, dev_name(dev->parent))
>> Renaming these fields is an issue for userspace as mentioned above 
>> in cxl_aer_uncorrectable_error.
> I understand, I'll revert as you request.
>
> Terry

I'll update the commit message with explanation for leaving as-is.

Terry
>>> 		__field(u64, serial)
>>> 		__field(u32, status)
>>> 	),
>>> 	TP_fast_assign(
>>> -		__assign_str(memdev);
>>> -		__assign_str(host);
>>> -		__entry->serial = cxlmd->cxlds->serial;
>>> +		__assign_str(name);
>>> +		__assign_str(parent);
>>> +		__entry->serial = serial;
>>> 		__entry->status = status;
>>> 	),
>>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
>>> -		  __get_str(memdev), __get_str(host), __entry->serial,
>>> +	TP_printk("device=%s parent=%s serial=%lld status='%s'",
>>> +		  __get_str(name), __get_str(parent), __entry->serial,
>>> 		  show_ce_errs(__entry->status)
>>> 	)
>>> );
>>> --
>>> 2.34.1
>> Thanks,
>> Shiju


