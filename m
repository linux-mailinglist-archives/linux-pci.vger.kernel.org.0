Return-Path: <linux-pci+bounces-27817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC1AAB91F2
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 23:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166224E364A
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 21:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7802A288513;
	Thu, 15 May 2025 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VYJgdwjJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837F19CCEA;
	Thu, 15 May 2025 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345943; cv=fail; b=S2OPKGCwEcchZfkUOBExJVKqYkwxsoOCuQlju2khXx64KEf1ViGJwXtIQYFfOyWpG9pmsZgRFpgWIFSQWn8gNYscjtUiFL7AlI5kyKKUWVhUMIqqhn1XjaMElbDqeT+T6d6OmgvTQA/21RmUHoJr1d3TsqjCvA7Z2SWQZxIMsnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345943; c=relaxed/simple;
	bh=PmXD88xXhAMsUVbkhGCwVXZsbG/hDaLl08fnZoB+qnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gPcFekIPSWCTJ677Aat/qNRB1DcbL8kVch38ymE5InXo6nnRUGMRr1sYNxnjjXMCZjBQNTQzDHH5CEIBkehDYU/BHeZ4+RGZhG1JZ46F/0U9Qkr+xBfe+sFPVj6mqnUB7AG4TaecMCL5OV2xVmDorjl1ZriqvnRfsPIM9D3Oj4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VYJgdwjJ; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRcmeMjeMNa+82bpdPbIOJBnNlb/dE6AIdRkGXcZZW6ohPs4ECvUnZ2cSYPWP8jAeAAstoRXim7y+XVUghQRiUf7WumkOjzUxjvqSJae6zBk37ZnfnwkECwvETZuXL6Rh488M2uJkOG+F7F6VuVoi5oNmhflgVpv560Vxy9GMZdRxCfi4HoSIYxVUEjCYuyXjCVAKQ+8NkZBJUEyeL1IH6pURKp8h/hvrIMcZdBcpxHGyPwXzkfP8CUQAKLazyjWCW2ymDMBMzdEcn8/TNCYy3ce9c4uOYLaFaK0nRlkIKjra0qvfWDx+qQvQqIwhSZ9gpG+JQ/SGmmlPriRJP0P1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9LHcfKnu6nytDsCideSWczB1K7xDU4R0eZrdZN0Fbg=;
 b=XjbXkOkLY1/snqvVRdZEFY5T3CAf/UJE5POQKesIJ63zd++7syG5qBczbD8ybVeQcPNcXsSzvdEbeI2khvdsuyQQCC6aNHIujXJxy0Wd87LzyxDb5hBNv18rE5hieWmbkQfzknTN6guqdbnp+FYrRGEusgoejO8K48zdeKYka0rU5ZI5znlT8tOxWK0dsfHaej9m7bvS0KLS/wT74qRg5YkKZK90zrvmBLfLQKWUwwIxGPurrIEU6Jb1RM7/DLhBOqNXY0pTFLH7HT/zrJNWCnOarJ5IDgI0PxNDf1F6mNfd+bb09J6jBgvpS6nPknggpK5pU+U2SAkZD1X6faHIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9LHcfKnu6nytDsCideSWczB1K7xDU4R0eZrdZN0Fbg=;
 b=VYJgdwjJbpSbvluGlk5IOj8jqILimbq2pXOCd1j5TEjizwCMrojuRQB6AfnIHCPcn9WU98/Fiyz35H9aP11tj10/DuvsGoYUSSbnnXlMs7Rqu3+X/qctzOvmCBSRNWthNzbCQumE6Vhy9jm5eOpwNz7djERVXHt1eIGdDFl6wf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 21:52:19 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 21:52:18 +0000
Message-ID: <8042c08a-42f0-49d5-b619-26bfc8e6f853@amd.com>
Date: Thu, 15 May 2025 16:52:15 -0500
User-Agent: Mozilla Thunderbird
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
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
 terry.bowman@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-5-terry.bowman@amd.com>
 <20250423160443.00006ee0@huawei.com>
 <e473fbc9-8b46-4e76-8653-98b84f6b93a6@amd.com>
 <20250425141849.00003c92@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250425141849.00003c92@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:806:125::10) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea37fc1-f6d3-4d5b-9e20-08dd93fac364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnNDOWV4Y05BTEhaQVYzY25aZVVzRWk3YnFJT3pZVHVQMXpSTUJra2pYeDZC?=
 =?utf-8?B?aWx1S0VjTmIrZVo0MGx5d253TTBGY1lCTkVMSDlScHNTNm9SQThEVzJJR3U0?=
 =?utf-8?B?SzJkTGl1dzV6VTUxOHdFMERaR3gxM2svd2laSmRmWUFESS8rT0J1RFprNDFu?=
 =?utf-8?B?UDZWSkg1UEhDTTlNcVlSV014VXpxYmdadHNKejB0S0t4VGU5S3BRdi9QdUUr?=
 =?utf-8?B?S1NUTTRWS1NBOUZPdVJRSWc4SU5aaml1ZXh6U3kxWi9SMHhwU3ZMdzcxSEQ4?=
 =?utf-8?B?THZtelVyK0RDRW50SzJvcm1FY3VrNG43RUZXYm80K3ZWd3hvY1JnZFF2RERF?=
 =?utf-8?B?Tk5HYVUrT1ZwSVlYTjBKa083NmpsTFBxRld6SFA0RzBqeVk2NXpKbXhFQzJC?=
 =?utf-8?B?Q004YkRWKy9kOUlNa0NYaStuSldsc2lVQXVYSlIxR2FTVGdkM0dkZUNMeXVk?=
 =?utf-8?B?Uy9mb0N2TUlTZUpoWHZacU9NWnliMDFHRXBCalFMNFVTdWJTVGd4dk5wZDJI?=
 =?utf-8?B?M2tIb2dleXVOZzU2YjIyREVKQVI4RE5qTU4yVXNuYlRtUUphRVFnVVptUmdS?=
 =?utf-8?B?SVp5N2hnbnFOUERramx1bS9QMExTdzdZREpEZ1g3SkV6cURzejlKTWd4WTdB?=
 =?utf-8?B?MkRGU0hvMDM0TkVOV0VBbmwzYkszMUoxZGZYWHZ6cDMyMndVY0xWeXVISWJW?=
 =?utf-8?B?ZnJoS0xlNkRVVWZXK0NlSzVLczNIR2k3K2tsYkFzUlVCT3BMWVhBZFdkOWs0?=
 =?utf-8?B?N3JpWG1ldVBXZFJMRm1td3NCL01GM0IrSVVHdGQrdEtISmJlVHdNeUpHcldr?=
 =?utf-8?B?UngzdkZ4ekZkUGtNNyt5UTJPNkFTMXZPVTNnMTd4b0kwbTVjN3lodWFXTHBW?=
 =?utf-8?B?QXJTc05MSDFvMlJPT2Z2ZURSb1JzTm5pRzBJdUVWcStXYkRtRnFxZTNFN3la?=
 =?utf-8?B?d28vRTRERHc0OUgvc0Z5Q2laT2dXSVlwU2Z4eFgyeWNVT0taN3VHZzNzYjRu?=
 =?utf-8?B?WEd1V3h1UGdGSm9LaVNkVFdxcTBDQjRQTlRGdEZabDhDcWpQdlJoZGhrT3Zw?=
 =?utf-8?B?T0R0d3hUcE1xUXAvTjJrSnF3QzF0ZHZEV0JQWGE2dDhBMDB5YkVQaUY3YXUx?=
 =?utf-8?B?U1Q3TnF6NFUvSWFXZjRydEtWVXNvS093NHJDR0o4dWdnU0JsV1o0cUhZWmpm?=
 =?utf-8?B?R3BjY3h5QTJtNXowRlJtUnlNRFRvdTRsVSsyKzl2SlRBaWpqRHYzdjBxTDhJ?=
 =?utf-8?B?bHNLMkxmNGF3Q0VBN2ZaaFNVSmExa29uMG56Ukk3ZzFuaStub1QxYjM4b1ho?=
 =?utf-8?B?blpPVEhGMzlwQU4wcCthRzRyTllVTFRSSmRwai9wTTdmUUF0MU9IOXEweXlM?=
 =?utf-8?B?dzJ5UzNtcUlkWmhkbUpuOUEvL2tsaW5RTC83THFiWXQrbFJtSDREc3N1bnpN?=
 =?utf-8?B?QXdWVFVHWjVxSUlmRTJXTGs4RnVXcmtlWk5CaGZPQnNzcnJkMlUraG5VT1Zp?=
 =?utf-8?B?d055TVpOandVTzlvb0RXSitocElJVXNmYmFkYUo5N1orckRQWE9IK09OdmIy?=
 =?utf-8?B?bmttVmxHMnlQRjJ6VDIxMlVJSTB5TytTN2pCQ2tRelhwTktVK21xQ3h2eXFR?=
 =?utf-8?B?SkYxT3ovZEdOaVNVS2lWRkwwYXVUWjYvQkVobWpQV1FEbFV2dklJeHJxdlJX?=
 =?utf-8?B?OEQydmQrVDZSWkVwOXZtS2RMRzNkRVZ6QUlhYTZJRjVKVEZ1bzVXVDZ0Y2pL?=
 =?utf-8?B?WGpIRGxianNaaTJUNFJGVTl5b0Nrb1BhRGdwTWFBZGxCTElOMUsvRFRFbnk5?=
 =?utf-8?B?ckE4YXBSZ29LL1pETDdPVTNEQWY0WHJTM3lnRnNrdjZNLytJUnNuVG0rSmkz?=
 =?utf-8?B?c1ZYbGFtek5jUjZ4THpkWWZXNnBQL1NJdEFrTUxLbDNqZS9mT2NzTVFEMFBN?=
 =?utf-8?Q?BbMAcpSTxXs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1N4Qzl2RVdjSGxWZGp6eWRwVjRiMjVoSlRTck1TZk16L3ZpYnJaR05ETXdT?=
 =?utf-8?B?amxRU2tYV2VCSnl5UkN6WnoyM1RZSVVhRHpjZCt1WmNRTjY5RmZ1Z1FlcG93?=
 =?utf-8?B?TTVtcWRzTm54ak8yT3JBeTdIYlZ6U2FteDNtelNSVEZPSGp6QkJGRThvNGRs?=
 =?utf-8?B?RVA3dURtSXNqVkpnbW94Snk2QXE1OFA1OEdhbzRtejMyMkVibnZNY01Bdnk5?=
 =?utf-8?B?TTZKK3IwVVNwR0NMbEdXMStrWDVMWXhDazRyMnhiNmVSS0IvSFdVRTJqd0lE?=
 =?utf-8?B?MjQxamxEMkYvQmRaa3Zsd2hJdTVuRG5FYzJDcHRQTFc5R1lZd2xManhuL3k0?=
 =?utf-8?B?QVR5N09TQWJGQUJSYmJsQ1pmekhRZjd4TTVUV0JwNWFQU0YzUmpzMVdURmVj?=
 =?utf-8?B?eTdoY3VYL0RZVlkzdzkzdzhRTjJPUDhUS3FNZTk1a1FqNDVEMkNjWlJ3V0JI?=
 =?utf-8?B?eCttSFQ0U2RweDBENlJ3TVVhc2pNR1hodXI5S1FIcXZyc0gxVTV6ZXRlb2xl?=
 =?utf-8?B?Z2I1aTFhQytoODk5cmp5aCtxbUVUdWFrTmtBV0dkblZHR3N5aTE3R2YyR3hM?=
 =?utf-8?B?eE9pQkFDZER6SHVnRjBoUmFhUGJtakhMNzdGQk5teGg4ZlJlU3BEL3BJMmox?=
 =?utf-8?B?WXhPWmV0VmlLUzhnWFN5K1M1ek0xd0ZlYUVqWFNLQ25reUhIVE14S01tL1VH?=
 =?utf-8?B?emhIMzBuNEplem92aVJoM0M2VGNsQVhMZFdKNkhLQ29mQnVLY2hnUGVabzJM?=
 =?utf-8?B?WkxSUVdIaW5MNE9PMmdxYmdkekZQSUdtMEVGYXgvR1ZUVDUvdGgrc0FTMlpl?=
 =?utf-8?B?NW0vUE9JdVE1S2Y4UmJia252L2JvRUpPbzA5d2dydmJ2bFBmdm1XOU1LSk8w?=
 =?utf-8?B?OXRHUFRWTlRCTytwVU9GbjdjK3hZR2dNdlllcE5WckhSTUpHcWdnZzNsb3VG?=
 =?utf-8?B?NkVvaTNuM25QV0Rob2FJUXJCM2Z0K3FacUo1YWEyNjZoUUdDeXp0ZWNWNUpL?=
 =?utf-8?B?WjRKVzhUT2R0dUVoU1dQYnJzRlFRa0ZEbDJKZGRUcnRjeldzb3ZDQzR4SEQ4?=
 =?utf-8?B?VWliblRZaHNOUmVXRXlnQjlpNlpHdHIxbEJWRFF6RnJDWUpkejZiZExDNExC?=
 =?utf-8?B?UitDc0RoVjNlaStEdzZvTlVtYkxlTEFCREMyNHZDWkxJU1hjYklTYU1mcE81?=
 =?utf-8?B?YWF1Y1RJaE93UVlRMlRaZTJ6QW9QMVJhdFVyZmhZTStLUTZHUjhjN3VkNkVs?=
 =?utf-8?B?NTluWU9WNlo0eHRKOFUzOUJNNWl3V1UvcEdNUStjZnBodmxWSTVISCs5cnU5?=
 =?utf-8?B?NVhiVzhxSUN3R1ZONitpZTVnSHVvUmdFOUhTZCt1TWNGV1JZR0hFb1ljVW5R?=
 =?utf-8?B?ZG81alZYTloyUzdWU09WMGM0N1J3c3c4K0VCY2luME41eUZ6NzRSV1ZJTmJ6?=
 =?utf-8?B?L2swRUtGNzcxUzJOTStOdmVLeXJyM08yVFYyNlVsak1sZkh2am5tYXpnY3RM?=
 =?utf-8?B?UUtBeU94U0hlb1JsQXROaHoxMk10NHBkM3IzYjc4OWZYcENhejg4S1MvR3Uy?=
 =?utf-8?B?aVpSaHkyUnRDb1dxb2tEa2dZcng2UXpveDBpQWZiclEwQkF1NmJ6UithSDNp?=
 =?utf-8?B?Tm1VUTBCR2JFQ25yV25SdnBOTkd6cy9oeFdsN2M5aDZqSFErbEhEYmwxelE3?=
 =?utf-8?B?Q1k4azk4TVZ5R2d6b2l2ajlqN04xRk9nZnpNS2RTTkc2SVdCZkx4Z0JLR1Np?=
 =?utf-8?B?YjVoWTRodXVJUUlzWlB6NjJNQ0hYblA1RWI1RTlvSCt5R3pQTlUzTVdUZG84?=
 =?utf-8?B?NGJKVWY1QW9sK1k4TzVSOEN5Q1A4NE9hTjRuM252WFYrenVsSUxRRVhhbnla?=
 =?utf-8?B?NkJVZXM3bkh6cjdSdWxHUXJ0YXFyY1FLWkc1K01yTURCVWtSeXBOVDlnYldv?=
 =?utf-8?B?QzY1OXNGaTVFbVhISXFYUHBhSGtFc08wdHhuK2RBK2d6Yy9uNVZOTm9mMWtW?=
 =?utf-8?B?bGFZbmIwOE9sSGpXNi9HeHo0R3RUdkJldnA2RnlVSHRCRVBIOE8yWFFXV0Z2?=
 =?utf-8?B?WTBFOFhXQ3lOdnlOZ2dpc2gwVWthelpCaDA1SXFlU2tlOFlNR3ZoY29xT1VL?=
 =?utf-8?Q?L3n+SS6UE48XCZWjWm085Xyw+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea37fc1-f6d3-4d5b-9e20-08dd93fac364
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 21:52:18.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ll/26+bhw0gbSp01S6KlH3LBXCfgEB2xNJzi2445yStrwTXEzzVtHR2DmSiZN8sEYk0k3EMIK05RjICfwPCI+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720



On 4/25/2025 8:18 AM, Jonathan Cameron wrote:
> On Thu, 24 Apr 2025 09:17:45 -0500
> "Bowman, Terry" <terry.bowman@amd.com> wrote:
>
>> On 4/23/2025 10:04 AM, Jonathan Cameron wrote:
>>> On Wed, 26 Mar 2025 20:47:05 -0500
>>> Terry Bowman <terry.bowman@amd.com> wrote:
>>>  
>>>> The AER service driver includes a CXL-specific kfifo, intended to forward
>>>> CXL errors to the CXL driver. However, the forwarding functionality is
>>>> currently unimplemented. Update the AER driver to enable error forwarding
>>>> to the CXL driver.
>>>>
>>>> Modify the AER service driver's handle_error_source(), which is called from
>>>> process_aer_err_devices(), to distinguish between PCIe and CXL errors.
>>>>
>>>> Rename and update is_internal_error() to is_cxl_error(). Ensuring it
>>>> checks both the 'struct aer_info::is_cxl' flag and the AER internal error
>>>> masks.
>>>>
>>>> If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
>>>> as done in the current AER driver.
>>>>
>>>> If the error is a CXL-related error then forward it to the CXL driver for
>>>> handling using the kfifo mechanism.
>>>>
>>>> Introduce a new function forward_cxl_error(), which constructs a CXL
>>>> protocol error context using cxl_create_prot_err_info(). This context is
>>>> then passed to the CXL driver via kfifo using a 'struct work_struct'.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
>>> Hi Terry,
>>>
>>> Finally got back to this.  I'm not following how some of the reference
>>> counting in here is working.  It might be fine but there is a lot
>>> taking then dropping device references - some of which are taken again later.
>>>  
>>>> @@ -1082,10 +1094,44 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>>>  	pci_info(rcec, "CXL: Internal errors unmasked");
>>>>  }
>>>>  
>>>> +static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
>>>> +{
>>>> +	int severity = info->severity;  
>>> So far this variable isn't really justified.  Maybe it makes sense later in the
>>> series?  
>> This is used below in call to cxl_create_prot_err_info().
> Sure, but why not just do
>
> if (cxl_create_prot_error_info(pdev, info->severity, &wd.err_info)) {
>
> There isn't anything modifying info->severity in between so that local
> variable is just padding out the code to no real benefit.
>
>
>>>> +		pci_err(pdev, "Failed to create CXL protocol error information");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);  
>>> Also this one.  A reference was acquired and dropped in cxl_create_prot_err_info()
>>> followed by retaking it here.  How do we know it is still about by this call
>>> and once we pull it off the kfifo later?  
>> Yes, this is a problem I realized after sending the series.
>>
>> The device reference incr could be changed for all the devices to the non-cleanup
>> variety. Then would add the reference incr in the caller after calling cxl_create_prot_err_info().
>> I need to look at the other calls to to cxl_create_prot_err_info() as well.
>>
>> In addition, I think we should consider adding the CXL RAS status into the struct cxl_prot_err_info.
>> This would eliminate the need for further accesses to the CXL device after being dequeued from the
>> fifo. Thoughts?
> That sounds like a reasonable solution to me.
>
> Jonathan
Hi Jonathan,

Is it sufficient to rely on correctly implemented reference counting implementation instead
of caching the RAS status I mentioned earlier?

I have the next revision coded to 'get' the CXL erring device's reference count in the AER
driver before enqueuing in the kfifo and then added a reference count 'put' in the CXL driver
after dequeuing and handling/logging. This is an alternative to what I mentioned earlier reading
the RAS status and caching it. One more question: is it OK to implement the get and put (of
the same object) in different drivers?

If we need to read and cache the RAS status before the kfifo enqueue there will be some other
details to work through.

-Terry



