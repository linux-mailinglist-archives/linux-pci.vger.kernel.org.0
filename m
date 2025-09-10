Return-Path: <linux-pci+bounces-35829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74904B51E0F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 18:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFBD3B5EA5
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3DB2741B5;
	Wed, 10 Sep 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NKllK5vs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93981E520A;
	Wed, 10 Sep 2025 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522637; cv=fail; b=GMYkhJyc830AfbEzzM9paDw80B8UCsYDbFX0ltMDyR/V19C7BvvVPOLhjoskkPbuGtcqbYaQgRev8mXm1eRVCqfnBwhLxvllc/cyNw0eiheOvIyXkqt2ivCZsdpvwMJrFI2tAIVjv8Z+MVjLp0oe9YWBUlXPSNgKRhsRj7st4RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522637; c=relaxed/simple;
	bh=N8CENjxPA7vBo79O6Ev9sqiCA7TQQCgwDivXhegh6hM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SvvLiTHGgeZVxekgM+SXn8CRMP82qypNOCiA9wgdL/83KO/Q0jhKgkWRrLtMetUgtqLZsUazGDlyXCVXUfgI5gXPePZys2YjnBLyv+4bTS2lPxxBGEafvOSmuyFS8sTJZ35/IS/nzEZZ6snuK3LFpHLlm1kFxNfqyio6MGFi04I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NKllK5vs; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoHOsDLKUqKETrr4Ir4t8XWynpDA46R0Hjno/fy4b+CmlGQ+ftcGRxoYEy/5FgoV8dnG6jHylXd5ZfMVT8qMa3NCSh1gdRSqe6+VxWysAKUA2F3qhOAqW6mvr6spu4xYPp8quhhkaF5t+wWum64hvFMUod9DqcoPKeA9LfkT5tPPlrwXOnu7HMSzCc3IWdj0u24DGj2Bqqm0UZGiAp/cUpbKbXXIG7jTCokLcrTB9VZWmHQIJYhivVXKp/eAStAFmU3koIIOXt1DRvgtj9ldwEmHW0ZAsX4idq3JsZOwG6BVHp5uj165W3YeKxlWF0EEZGeCi3nhCD7z+XLMYrL5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiDsm32dOkOeEMK+wv/wWzXjd9Rjqayt+8U1lXQnU18=;
 b=aBpUY9JjKDRMJzE18c6RV8ZI9XUcyP95Iypmvm8Hsm3fjGyvHtlsi8Z0hFY56JJ8xrmZ85XyZRIT3nd7H6jeXOTh9TlAvWJ1aLm/0iKwtKrk8m3jXFKDbZpdpN0LOtLWq3qKid+YoBtC8+5v5R2uibiCYvdjEpfRo9EwDLGJ/qPQ/7+zvKhGUUgFPJSCPABsig6ufXrAp4/CrxNxgE5cDLXFlTN0+t26BiZWdBLZhzpOjVjAA8uu8VqS9k8anbmKlldylMBVFWOSIoNGr/s+NPlwKI5IlErORlgtt3+vfF/YAPIni8pEf+v4QiblE2/1VXz8j8JNdc+SQjm+DiCx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiDsm32dOkOeEMK+wv/wWzXjd9Rjqayt+8U1lXQnU18=;
 b=NKllK5vsmTMW5Pd6WARPXxeJGadgd+CfcZv2TABVJwIvz0cHoT2/61MItT96sAuz92Yoh5Lqd0FnoogOh8Z1QW6qdKCOosUcbDV3FPAQg/gt1hURH7vur1SWozac2PNixC3C/QfA1BSMobBmpZXZrgoSwa6Ku2Iv/iZQdLKDORg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 16:43:53 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 16:43:53 +0000
Message-ID: <a4b1de6e-6969-432f-9620-7b4416f194ce@amd.com>
Date: Wed, 10 Sep 2025 11:43:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/23] cxl: Move CXL driver RCH error handling into
 CONFIG_CXL_RCH_RAS conditional block
To: Alejandro Lucero Palau <alucerop@amd.com>, dave@stgolabs.net,
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
 <20250827013539.903682-6-terry.bowman@amd.com>
 <12a3ea6e-56c0-4d7b-9d75-43c13c03e9a9@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <12a3ea6e-56c0-4d7b-9d75-43c13c03e9a9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS0PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:8:191::28) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: bf282718-86c9-42e2-1af7-08ddf08939d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2cxL2lMSzNkUGR3cnBvdWZKWU1yVTEzUndWVDF2L0RyQzFwODUzclJPMmR4?=
 =?utf-8?B?MGk5TnNDYXlmOE9nZjYzNVpZcEp6M3BtM2hLK2pnVUUwYnp5UVJsNmVVRlA0?=
 =?utf-8?B?TVAydkwyVmtvZW45RlJhZnRBUkNQRDIrMk9WbGlTdjdYNVpyVjRqMHlRTXk5?=
 =?utf-8?B?TE9tUjJjR0l5SUZ2U1l1VzI1MituNWgvRTcwYXhIYmo5UnphNlBLV1REWitL?=
 =?utf-8?B?SzRmcHYwNFhFKzZDdW56Tk40blgySUs0dmt0bW1vQlBxWnVwYm4xSWMyTm5Y?=
 =?utf-8?B?YkphSnZTWlhBRy95R05DdnRUSE0wZzNYS3prVXYvSXRNYjhqMGdxczA3QkVk?=
 =?utf-8?B?N2dMTHZ3eWI2YmlBNlZvNnB5blhrZFFGZ2NtLzJaeW4rNTlVWVRGN2UxZHMx?=
 =?utf-8?B?Q1dPaDQ1QURMdXJEL1Z3RHY1bmlDQk1xS1ZsRjNRUU1jMUpseUFhZFpJOVM1?=
 =?utf-8?B?YmdtTXNpT2RsUmQxdXllUmwybzFvZUpIdG5YazcvMnlYTXRuMkhzM3FQMkl5?=
 =?utf-8?B?ZjN1WWc4anloUlgvck0vT1BRTWRrSUhJU1FmTExvS3V0NVFnZ1JYbklJekxP?=
 =?utf-8?B?UzY5ZEl4dE83a3IvSE95SE5GQU5zZDhseWtrdWI3OWRxemdhRk9wWndSREI2?=
 =?utf-8?B?MEFhVStkbkVWeCtxU3RCVmM0eG5OZmg1UXZTbE5GdEhsMG13emVkWHVJYkI4?=
 =?utf-8?B?c3pHb2M1ZlJwY1djNHhaVDVnRmVubjNvazRJR2RXcGJBMTErTWFTNlUxZmxF?=
 =?utf-8?B?NS9zd0hneTVTbzdsS0R0RkpoZUtGY0duTSt1emhtWUU0N3VxSnMxY2U5NHJx?=
 =?utf-8?B?RkNoWHgzTnF5RkhMNTBUN1E4blMramRKemxVTWsrd0NQZTBKSlpCOU1ncFBG?=
 =?utf-8?B?OEhrSTJock9UM3Q0Q3UrVW5rMkg1aVJJNkhGeEw1YnlEck1mQ0xDd1FrbjFN?=
 =?utf-8?B?U0RReUEyTFZDRTJOUlJrWVVEcDRNRmlsUkhDZmoweThxRTFxbW5EYmgwekJE?=
 =?utf-8?B?T3cvemFieTlYU28xOGlVREdEdVhWZ2dOUFYzMmw3aldCVzlyb2oyVWZJcXV3?=
 =?utf-8?B?ellyVDRKNUxueDV3MzVFUk03aW5pUWIxcS96WVQvRkJWWkFlMzZ2ZG8xL2xS?=
 =?utf-8?B?R0ZoMEVWWnpDK2JabTkrOW9SeTczOUJNN1BsNUluUUZud1YwdXlCVWRrMlds?=
 =?utf-8?B?aVgvQTcydjFsdE1naWRMbjhwRE5DRE1oZ01JVE9JaEFkbW5SN0JMQTVQTTA4?=
 =?utf-8?B?MmxSakpJUUtkako4OFVBSTJGRVJYN29UVVdPbk03cGZEUGJCZThhaHIrZFhS?=
 =?utf-8?B?K3BLQjhOMkd1aFFibGw4dENRdVFaZDBrN2pIQ2hJQ2I3ZXJEaGMvZjRtc2pv?=
 =?utf-8?B?azhFWStiejBiTDRGUGV3VlFQSmVKNDNXeEIzWXc0OXhFRlZZWDBOSzdiK0pR?=
 =?utf-8?B?YWVvakpteDNtYnlTRWR0YVhRL0pkcHdxdlhiQWl4YTF4dUk3cmU1Z0xVT2tV?=
 =?utf-8?B?eWFjY1NWeURNcDRzdVJWRE53SUV0OHBrWUNSV2grOVd1RDE4UFEzMWhUcWtL?=
 =?utf-8?B?RjlWMFVJUFMvRDBGdWIzZHJjZE1aYWRPSGZ2QmkyYXArUHRUR3JZNG5ORVdT?=
 =?utf-8?B?VEJsRU8rV1F2OHZMS05YQnBTRTNYYUpOQmw3NTVEd29oQkI3aTFndmYralRx?=
 =?utf-8?B?ZWZCOTVOMUNXaTFxTXdaa1VXSnViV0VUZEpiNHRlUkNMYkNkWng3WTN4Unp5?=
 =?utf-8?B?Vk55OTczNXMvSUpUS0hhRnFPYVlnME84aUZvVkN0cmRoQzlzY0g3Wk5wczAx?=
 =?utf-8?B?dlhoSkJ0RlUwQy9CekFyZWhyUUpWRDlldjk5Y3lVVFZuTDVXdU1hbW44QnA4?=
 =?utf-8?B?T250elM1Y3dvbWQ3OE1iS2VaTHhrbnFMOW5CVkVVRDdLV0ZKQ1pjYlo5Mlhh?=
 =?utf-8?B?VVNYaml0cXlFNGo0a2IwTis1dkZsc2JmVjZqN3BUSXZQYWZnQ1pxdDdQK2N1?=
 =?utf-8?B?ampWR1hRT0pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzEwVXg1ekJtWmJGUVRGQ25wYmpIbXY0UzcyN3ROZXErZTF2QUw0SWhmN3hI?=
 =?utf-8?B?N0svcEwvQ2JxQVJIUmYyOUhMTjlrK1doam9sZ3NtYnhMVTFPMVp5bHFwS0Fo?=
 =?utf-8?B?bVlRMzJ3MFFkWHhhRmpHS2JhT21yTkNSRkw3ekFUUEJWWG9weGd4OStUVUNJ?=
 =?utf-8?B?a0dNWnd1TEtGdEpWOFJBWkZ3eWNlc2tKRWZlQjNSaWRjdTlrenQvSWVibHFt?=
 =?utf-8?B?b2w5MDR2K3Q3UXJnZEZjWExJSFAxbFBOOU1rcGtTdkpSRTlvSG9UeWltMEha?=
 =?utf-8?B?b3lWeGdrS1RNRlhOZDROVGxqU2lXNmJBVFpGU3ZGcFF1azRpOUZwb0hyNVRi?=
 =?utf-8?B?bjgrQmwvUlZ5YlFaa0NZSDNTVWlRMGZOSEFRVGRmUThNZHFaOWFGc1hxYVBk?=
 =?utf-8?B?NHQ0dkpNeGJtZlJNbEVFcXdRcUJlL2l1R3MvSi9TeFFlTmJvT2hQSXhnSnZj?=
 =?utf-8?B?MmRhZGpKamU1eHc5YWlJelUzVkVteitacVRaWXJqQUZhanBFSmVsY0x0b3Z3?=
 =?utf-8?B?ckxqeHRnTmtHRFRpak5iN1BQZVRhaVoxcGEwZ0FEZkI1Y1I1VXpnZCs2UEt0?=
 =?utf-8?B?R2NVTm1UZVRWbGRzYUsycnFqZnlOdzY1QVYzYUZxS1dhbmpJNUdtL1JnREdP?=
 =?utf-8?B?NTFuNFU3dUxlaWNKbWdYSTg3TWxLN08ydTNpOWRpZjFpNUtncWVJSWFCY1d2?=
 =?utf-8?B?eXRUdCtwQ3FadTB3OEpPYjZSNVlIRlNiM0RmeXFFMWZrQXNTYW91WmJ5Q0Vo?=
 =?utf-8?B?RUttRDFsVWNWUkVyY0E2cE5YV3p5RXU5M2VqSjlxQjJXemhVL0FpRHkzQkl0?=
 =?utf-8?B?UXJ2c25KNnpqQzZFWjRtbWpXVUNYZDdDNkhnS1ZSMTRsbTNpVTZVQzJudEd6?=
 =?utf-8?B?TStaajA0bm1mcFlueVhYNVF4NEphZVZhOHpxSkFpWU9NN3R0S0xCLzBBMFps?=
 =?utf-8?B?dURFOHVZcWs0TWJGdTFqcTVodjF4RlpkRXkvL3MvZllnSjBVUGlDVFpXUWlX?=
 =?utf-8?B?dWpIbHIrbFg1NTRSSG95SThZZXZjNTFBUWwzRlFtU29tYkZsZ2ozZWhocG1i?=
 =?utf-8?B?NjBBMVZnQlB5R3cwaUFjcGV3WGJTNHd6bVdTcmlaZmV1amIvNm1Rc2IwWEdC?=
 =?utf-8?B?OXlNR1g2dUxudHc1RXhuRU1ORlViajRaaTZ1OTJnTVVwUkZWMWl6NkF2ajRk?=
 =?utf-8?B?U3gxTnVFWFl6Y3dWbGRCV0hYY0dVcDV0N2pmSnJKaE4vZmZGcXdsUmFCMzh1?=
 =?utf-8?B?QU01NGFQcE50Q29uckxESmJRaHlIdkF2Y3NjaE4wbDlhUGlUV1RxMGJyaUJk?=
 =?utf-8?B?SnNBZmxYb2tGcFRrdlBMSXV3Mk1GTVk4aTh0TjFDSVJMWTRGcEhIRXdtOUsw?=
 =?utf-8?B?TWRZaHp3TjE5TEliMFZtRGpxNFFSU3BBQXRpdUNmNmNablZPTTB0Y1dOTWlG?=
 =?utf-8?B?RW9hMXhBcGRiTWlxRkpIdVRkSVRrdjFpRWZjR0VCRllRMVN4dE0zODZ1WHJ4?=
 =?utf-8?B?TUlKVjJQQXd2c3AzLzdEUmYxZFVHeDBIaElXaFVEUlRmWUxXdGttc3k1U3ZU?=
 =?utf-8?B?WU90aDViekFTTmxVMmxXalJXMVdZUzFDSkdBdGhFSC9GNFUzNmRldEZpUWt4?=
 =?utf-8?B?cG54NDUxc21pL09aV29rR2RlZnFYU3lkMnRlRXA2bUphMS9MdytvdW13eVVo?=
 =?utf-8?B?L0F3QjhiMG1LLzFKazV4ZHpKbUhXamtpYUkrYUZjVHZmM0hjekFRVVRIbEJJ?=
 =?utf-8?B?aC80VkxYY0dzUXJvaTVhYklJUzkwYXYzUyt2UFlQMURVMUFEdWpNTEtWdFd2?=
 =?utf-8?B?UFlMK0QxbloxVnI2R2IrL0JMTEdOYU5iRmNUelRKdEErUlV3K000bkhSQS9E?=
 =?utf-8?B?bmpxMlkvLy9kMHZSVm13WTJ4dE42SkZwUElaQko4NjlVMHBYbWxkSEJUWmdw?=
 =?utf-8?B?YStaVVlIOEg3WlJmekdPbkxPWVFvTGcrWTR2T2Nka1NmNUhhUWI1TTgwemlu?=
 =?utf-8?B?bFBkUWJXTkdVb2NZYlNRYUYxQnFTZWpaMVVXTU5JbllIWlRDa3BoV3k4cnp6?=
 =?utf-8?B?S2QzUksxS3BEYXQ5bkhMWjUxSnhXTkFEaFhuR3JnWXBHbzNJSE9pSWtQaHMy?=
 =?utf-8?Q?pRv4CPs342WZIeaz2JmQy2mi1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf282718-86c9-42e2-1af7-08ddf08939d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 16:43:52.9778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g94wqWdyId/mZlcMStdext2okWrFxtvHBNI76nKmFKLd+0t35xnLLDFcIgfZQDjD7QfqPElI8x8pkpDVUrJk8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169



On 8/28/2025 3:57 AM, Alejandro Lucero Palau wrote:
> On 8/27/25 02:35, Terry Bowman wrote:
>> Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
>> from the CXL Virtual Hierarchy (VH) handling. This is because of the
>> differences in the RCH and VH topologies. Improve the maintainability and
>> add ability to enable/disable RCH handling.
>>
>> Move and combine the RCH handling code into a single block conditionally
>> compiled with the CONFIG_CXL_RCH_RAS kernel config.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>> v10->v11:
>> - New patch
>> ---
>>   drivers/cxl/core/ras.c | 175 +++++++++++++++++++++--------------------
>>   1 file changed, 90 insertions(+), 85 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 0875ce8116ff..f42f9a255ef8 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -126,6 +126,7 @@ void cxl_ras_exit(void)
>>   	cancel_work_sync(&cxl_cper_prot_err_work);
>>   }
>>   
>> +#ifdef CONFIG_CXL_RCH_RAS
>
> You are introducing CONFIG_CXL_RCH_RAS in the next patch. Is it correct 
> to use it here?
>

You are correct. I need to move the introduction of Kconfig's CONFIG_CXL_RCH_RAS definition into this patch. Thanks. Terry

