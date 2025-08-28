Return-Path: <linux-pci+bounces-34980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CDEB39716
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 10:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC373BAD4D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 08:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F82BEC2A;
	Thu, 28 Aug 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wyCfGT/H"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529DF1E47C5;
	Thu, 28 Aug 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370139; cv=fail; b=trN+E1Vf66EncKP2rZBdYudGOUPyYkwVN2nfdHSV3IIX3tMwGN5ls/fgXkNMFjyDd2hz6dLmsjGlcKhksz8yf9wCw1T1RLd/Ah6V3RYDhNZskOFMC9+gleA3uIWGBfX7MoAau1Wrcmen+LlESkKf+tbhcQfE+PZ5rGBtoHig4PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370139; c=relaxed/simple;
	bh=m+dpoOTQznSLkfIrG/mDOLL3VPwnh/YGej5Cg4Lrmto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=icTilKwTZWjQOE68hobDP4vZodd1qs+MdQlFGC+WPTr1QmyP4LpaJDSC6mIBJ1EOnu8Su8iywkvFwLtddMgUk0qy3xff9nqt+XXQHYv3mvlCFCxzlWwUvPQb1uiHf5G0eqNlI9eQC2Y1l1xiQHznpYYh781sarN8aaWHvwgu+eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wyCfGT/H; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnsfHcnJaKXOS0Ne04YGP5nINGX86IcS5CRxb91JGaCZKLTCohd5AIipcskYKd8dcgbIVj9Q1ftAug/4YOhOPQqlDjLyb/0uipRNovA2cLtdRVwzccWfBJl+P8hkswd6duPkBv6+8xyJzT5yNXpirm12rA2k5l7QQcrzmIKO4QSKm/1YPVJg0fZuBxk7OQgZ5TEzyE0OLMNOjemVw+YgUqu1t4uf1Nzb4pZOXJNxckW67FucKq1n5F9dvDAvV3Odw5Se7/AFDCK8T7jdGvcrAj/uoCnTxuD54GbUMdOgZtceAHwlTTHO2F2zgGTm2LCErfZH+c5c1aBfqfj2bWH7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg5xYl1yquVxj/KrcVLNf/7AqlAosNOkDWzrnqnOvhU=;
 b=Lvnusgkqituh6dKFFm6l7bylW74OVXuLlOqKTkv4NDvjVjmTVQ4KGTbUAt26ojSi2Ivs8hac3RfLgvia08AuTB/t27hurnDHjhh+ke4FLqPHAPWuNRv70XVWwRYyYD1Fpbnv/VvbsvKFYY/RYmL5xWGs0RquOkt6qPJduJr52hZLggsLZHP4tYStzaym+OVzMJEJKtJ01xL7YkvLYexlZeTiRjX3X56eKjCs9RV9BQMXKz9iLrG51joWERBhL2yLvOhC/e19mRIjBcnrRWYKOL0F5ucMynxyCSDIfKZcR/7SveomqjGK/PIPzxCH40tGlhgzl7U2J0xjMkKILz/tCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg5xYl1yquVxj/KrcVLNf/7AqlAosNOkDWzrnqnOvhU=;
 b=wyCfGT/H7VlsS7S7rYFtKQN8BpmdiCvuk0uj9RD+6ocjklew9172p/kg4tjr0sCuMBcoJPIpquSJkpO/kbUJN8yuaK8RQxssxC3uB9EfL+lpTIsI8eatsxCjJQwdGE+kKMJsK2HCUV639zz9C4fDhlTg+Utj5qVzTtoanCC56h4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Thu, 28 Aug
 2025 08:35:34 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 08:35:33 +0000
Message-ID: <cb5cab2b-5cd1-4fec-99d4-9e8d9517b487@amd.com>
Date: Thu, 28 Aug 2025 09:35:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/23] cxl/pci: Remove unnecessary CXL RCH handling
 helper functions
Content-Language: en-US
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-5-terry.bowman@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250827013539.903682-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: e34c8a07-c8aa-4100-4ffb-08dde60dd9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWpyaVZrejBTREQrQVJpMlBJWktPdXo5d3E3T2E2WVhueGgyTXI1dncwWjYx?=
 =?utf-8?B?dmZOMjAyWUx5NzhpNVZQU0twRm5hSHAxQWVjVUw5TlJ0UFkzRCtqN3AvYTFu?=
 =?utf-8?B?OUxGQ3pndm5pOFhraTFqWEdIVlk4aURwcjVZTXhBZkd2N0JDZUl1WFF6MVpH?=
 =?utf-8?B?cm00N2kvb2dBNXZpSDQrMlJibE8rV1dpSDdQSTlRTUVINStzRHRzUXhoWG1q?=
 =?utf-8?B?eHVtbFdNL25BOU5zNVRqRkhmeFg5VHI0d2tVM2xDck5vUTNaL1VBTExNaUU3?=
 =?utf-8?B?eWErbUxiZTk4WGpVSlZnZm5VS3UzQWNFQVVKRnNxWSs0SDBMeUhSRUFmWEs4?=
 =?utf-8?B?WXQrcGZpWm9SNlhaZ0hTNm5ZbFVZTEkwOEx6aEdaejBwU2NUTWpmK05QalQ3?=
 =?utf-8?B?Qi9vWWs4U2QvNFl6UlRPWDBJVExUSW5vU0Vpd2FEdmg5cjI2R1Zia1B4cXBU?=
 =?utf-8?B?TzBESk1wc1VaMGRja1hBOFB3ZWJ0K0pEcDM5dXpZWkxQY0hIWiswWWJTR3dL?=
 =?utf-8?B?M2I5TDBLWjlERFh4bFFpR1dvVjBHMjZRMEpGVjJaZjRpdm1aU2VQOWE3TWFX?=
 =?utf-8?B?YUhQNGVMZlJ6Nm9XRE4ybThhdjBBdWQ0eTVuTFRQOXgwcXV1WnlLTkJPcTNK?=
 =?utf-8?B?aUdZR25uaDRRRzN0NnVTcHU1czJ6TWdaS0lXYTg1VmZXWVAxanEzdWc0T05D?=
 =?utf-8?B?L1lKZS8vbWE5eEtnNU85cUIvUjltV3krUU9VMzR0NUVXTk90K3p2a0VNRTZR?=
 =?utf-8?B?SERleHlndEZ6Z2dYRFhqRVNXNHQrL2QxVXd5Vm5VQzlVYnJsR3J4WTdTZnAy?=
 =?utf-8?B?NytDRUdJMi9QTTlubzUya3VpZG5aSElwT1ZEZEJzNSsveFBwcmtSMXN6UHps?=
 =?utf-8?B?STIvczhZSzc0c1JHNnl5ZHduZEpaZXRrY3duVHBoMDZQWHQzbkRPV2tvZTMy?=
 =?utf-8?B?RHlQZmpaV1RPdGFrc1k4MDNBTWRoR0c4TUtTNDc1VFZyOC9CZEFydkFHRG1Q?=
 =?utf-8?B?OWhjWmNVcDY4MHpjS3VEdkt3Rkg2YmVWMURXK0RrdGlOMzZpNzVIWjVUMlpO?=
 =?utf-8?B?azVtNksyR3JmR1l2VVJGUk8wenR4QzduaWF0WHRFcml5TUNXWkNKbEdKbUYy?=
 =?utf-8?B?VjRjbXVtTXJyelVXQ3Z4MnZlL0JRK0lqN1BPOFAza29KcTdKcGJlZHJObzJZ?=
 =?utf-8?B?RTJNcU9YaEdTYXlmY3E3MG9QdFdlUjUzbGM3T2tpOXJMZ3lOWHdzck9ycTJ2?=
 =?utf-8?B?UmdUZzVDdUtuajFITzdBZGRCS2Y3aTNDQVNTcC8vaTQzYThET2J4Q09vZ2dR?=
 =?utf-8?B?ZU1VK0gveE0rc3hObm53Q2dsb3lFakhRLzhIR2JZeFZudlYwYjNDTGYxNlll?=
 =?utf-8?B?dmtyeVhIckZRa0tPRk1rZTVsdnJrY0IvT2YzRnNjOFVaNkE1aW85Y1hLUUcw?=
 =?utf-8?B?dFZrZDhrVEI5bFFmVHBqcno4NGpISm9SOEZieGhUbnZYdGZ3WEpsZ0lQYlFa?=
 =?utf-8?B?Qno5TUZNc2NoKzZIN2xqeWFqQ09jOHNESCtaQ1U2ZnJDcDRIMVpHd0RMWDJN?=
 =?utf-8?B?NmJ3R1I1d1E4UitaTGt6VWVNUG12OHRSbkV0RnQvb0YyWjN3b3FoTUh4aFJW?=
 =?utf-8?B?TzlIUEpGdjlYQmxrUXNXR0hPR0JYSGVtNWx4RVo5YThReVJMSXFWZWtIam01?=
 =?utf-8?B?SzJIdVRIdjdsQWZjVjY1SXFody9wcVVGOVVBTkRjSHU4KzF5QU9ML3hzNjNE?=
 =?utf-8?B?UkFlNWVoRStYcHZwMFlzNmk1Q282RGxWcFJKdjVJZ0dMaXRtb1NGTUI4ZUxT?=
 =?utf-8?B?eVROOHVEQmRNWjNseVdmdkFwMW8zV1QycS8xMTVhamR2QXRIQnBnSWRqTktY?=
 =?utf-8?B?ellmUmdVU2pmSFltK1BoSldrRUlpTlVSOVpHZE12YTROY1ExSzlsWWVFV0p3?=
 =?utf-8?B?MHdKdkZnZTl6ZXBZVmNJUGtyWCtBRnJnenF5K1F6TEFwNnFrS2trU2RFVDlx?=
 =?utf-8?B?elpBZHBuUFRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3ZhWit1V3E3OE5nT2cxNi84RVo4VDRHdkZkME84cUk1aXNTOFRuWVNhVUVm?=
 =?utf-8?B?dmI5S2VrRnBmMXc2a2MybGVQL3Ara2ZmQ0NWdmFhSVJQbG9hRlFEV1crQWtq?=
 =?utf-8?B?alRwbnd2NDVyMDFqdE9YeUlLRkZWSWJMU3VGa1RkRHZaQm1tbGN3bW9MZklL?=
 =?utf-8?B?SG15bzN1OXdtZEV1TkJGZkRUN0k4dDNCcjVOb2wwaUcwZ1VqVFdBdk9QeVBr?=
 =?utf-8?B?cEUyaVhjb2tVdDZNYk9ZUnJlMUE2VVlFYlFrZnFFcmRpQWVnYkZGYUlRYzJR?=
 =?utf-8?B?Y3BlckpuUFBlT2Z5aHZmeWhrWTY2anlqSTFabSsvTmJTbXNnYW9jR2k1OEEw?=
 =?utf-8?B?QlIvRFhpc1RTaXFUeGhMVlh6Y0VRY1VxcEhlMm0rcVdPMnltNUJsTTVjOHRs?=
 =?utf-8?B?b29rR2tnY0FGWjlua3k3Y1A3RG9taGZoZzU3K3A1T0hCc0Vvb0p6RWFLc0Fz?=
 =?utf-8?B?VFJQT3pScHV3WHlaUlhhc2kvNWVpZHZseEtXNUttSzVabUxUMlM2MW0xVFpK?=
 =?utf-8?B?YUtLN3BFT3M1bnVOdUZXaENsL2dFa2FOZDBBNmdZRkdVTUREMlJlZnNHQzU1?=
 =?utf-8?B?cGFjNE9HZXJHaURDKy9pbk5DOHJId1ZJM3Z2S2loYVc4T0dqbmVLc1lWMHJL?=
 =?utf-8?B?ZkNjMW54WVJheCswb2lhSTBQaUh4Q2tyZ2poMExNMGEwc3E3MnE3b0txWWVt?=
 =?utf-8?B?QTZLcUhXTkdIWDBObmtubGFEd0QxVE9ObFNNQ3ZwZjRqbDU4MENIdUdQUWxo?=
 =?utf-8?B?MnNGdDhZeW9KMDgzazZWS0Y4aWpCS2VEM1FkRUtTaXhLdUk3SURYZ3E0MVpX?=
 =?utf-8?B?b1ZzTnhrRjJ6bWlzYUpaVUtQcUYzOW5FMDZxK3dZKzhydldmRUtTQlhJQW82?=
 =?utf-8?B?QTJiWGdzNVIxM05ZVWJGMndZN2VlVUsrQUpDRXNvS1daUC9qTTdnVUJYdDZ2?=
 =?utf-8?B?d05JLzFabW9reGFRQlNrZWxCcjNFUEttZlFveGoza0poNGpQcW4yWTZoN0NQ?=
 =?utf-8?B?bDk1R3NuNm9jZHFPZkFJSHVnaTdXT29SUG1tQWtoR2ZVOHVMS3NSQ3N2NXJ2?=
 =?utf-8?B?NWY5UUZLaFl2VmRIOW1SR1ZNZjM0UkMzaEF0b1hERVRKSUdSLzlaWWJKcWlT?=
 =?utf-8?B?MFIrLzRkUmM0UHRsdXRXdENuTllkQm5wTFdPcXNqRWJyVDRtYkx5T3RyZjla?=
 =?utf-8?B?NXlKbHJCR0VReW5Od3JQV1RrMGVRYXRFdjZzWjl5VnV5QlBNbGpxbzlWTlN0?=
 =?utf-8?B?Z1MxcERVbkNRVGlzWGI5YXVzYU1DMk0zT0k1Tzk1dk1sK0tHeFhyTHB4dXpR?=
 =?utf-8?B?YXllY2FmZjdqcFFIV2pkaXRIVnppcXdjQTNtL3RWL0J4NzY5NEVwK0EwRmRs?=
 =?utf-8?B?SEttVERET3MrVEw0Z2pCUE5PR2JYczNVcVc0WWFtYkZPREZlS05Gbkc3Wm5u?=
 =?utf-8?B?elk1c2ROTTE0dmZOdldtOVFrbXZnaUxxN2xySnN4V05pWW5tZ1ppYXJrWUhY?=
 =?utf-8?B?SHp6VWRJWVhtbEh2S1NlY0xDd09nR2RtRkhDRjNHZlFHUE5tYUk1QjJZbzE5?=
 =?utf-8?B?eWxlYmxaNGtvekIxK0U2N0Q0dnpQdEdJQUFRRjhZcU8vRXozZEZkRHBiNGdJ?=
 =?utf-8?B?M2twUGppOGhsVTR6K0hTSDlNdjNaTnpLN2crODRLR3V1T29nSWpOdnpNWGFW?=
 =?utf-8?B?QzlhMTBtT0pHc1c0QXZ6YVJoVHd5TVE4aE92amI1YVljaURvVENMdWRkRlZO?=
 =?utf-8?B?NUNVNGYwUEw5Z3NXM3R1QUtwdm5yRXBqZVA0MWkxZU1CYXZLenoxQXVreXFQ?=
 =?utf-8?B?WXhIQ3lzWGFyVVM1YnhFT1pQWDBJdklBWFZkbGwzb0dqNzg1Tmx1SE81bUZx?=
 =?utf-8?B?QUJRK2RGZ01Wb0ErZ3EwcUp1UFRWYVNIbW1BandGczhadm1zSGt3eWVWUXVm?=
 =?utf-8?B?WnpIb3QxSXpiV3p5bzNCa2czWkowelRpWmFrM1UzbEtSNEtRYTlWa29OeDRp?=
 =?utf-8?B?enFodWZNbFM2RmdNWi8zM2ZRclB0S3NMNEFGbVlSb3p5eG1veTZlSFg0a1Ax?=
 =?utf-8?B?dXNFNFRnS2Q0emVWSUxLUkpsOXoxZTNoNmpkbHRxaCtveTZXS2NrSUszMkZO?=
 =?utf-8?Q?/v8them0asdSe1neFdU0LgM5H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34c8a07-c8aa-4100-4ffb-08dde60dd9cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:35:33.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtcczxLikKRLa9+rzDNWvJxVQSYfNnvlxNZ8u0ZxPRkLO4nD0qRUTNMKwj4w4kGSxSdATTkr+EuEJMnPifwzmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658


On 8/27/25 02:35, Terry Bowman wrote:
> cxl_handle_rdport_cor_ras() and cxl_handle_rdport_ras() are specific
> to Restricted CXL Host (RCH) handling. Improve readability and
> maintainability by replacing these and instead using the common
> cxl_handle_cor_ras() and cxl_handle_ras() functions.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>


Good and simple.


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


> ---
>
> Changes in v10->v11:
> - New patch
> ---
>   drivers/cxl/core/ras.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 544a0d8773fa..0875ce8116ff 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -233,12 +233,6 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   	}
>   }
>   
> -static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
> -				      struct cxl_dport *dport)
> -{
> -	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
> -}
> -
>   /*
>    * Log the state of the RAS status registers and prepare them to log the
>    * next error status. Return 1 if reset needed.
> @@ -276,12 +270,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>   	return true;
>   }
>   
> -static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
> -				  struct cxl_dport *dport)
> -{
> -	return cxl_handle_ras(cxlds, dport->regs.ras);
> -}
> -
>   /*
>    * Copy the AER capability registers using 32 bit read accesses.
>    * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> @@ -350,9 +338,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>   
>   	pci_print_aer(pdev, severity, &aer_regs);
>   	if (severity == AER_CORRECTABLE)
> -		cxl_handle_rdport_cor_ras(cxlds, dport);
> +		cxl_handle_cor_ras(cxlds, dport->regs.ras);
>   	else
> -		cxl_handle_rdport_ras(cxlds, dport);
> +		cxl_handle_ras(cxlds, dport->regs.ras);
>   }
>   
>   void cxl_cor_error_detected(struct pci_dev *pdev)

