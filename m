Return-Path: <linux-pci+bounces-39744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D855C1DF71
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 02:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F0C534BF26
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 01:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17B1EB9E1;
	Thu, 30 Oct 2025 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a2SE0mMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870F18859B
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786027; cv=fail; b=dW9Dn+7huZnsGTLGWCdqdu7yjJwV69RvpZ6HSXzDJn50j5gutRzamjpIOJtS7eQ9zUbZDCHTGIVyzAlsApZrmAgvk78y2PiqHuvli3h6XgL78XUgdQXwnR5OGKdG0D7v5xjbkYMA8DoOpZPzC6bmtGlealZY+g2fA8r1waaia+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786027; c=relaxed/simple;
	bh=lD/U8iIiVflOhsACt1qNQgRjg5Xg1b8wSbKf++/aEBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X6k4FsqcjLB5eiRaAFBT6ZxLju+nRF6qoxVVSTGX/sU405/d083LaO+qf11WmCdBAOo8XRXi0z10+9qyJBATM5td3gdnDwr91YJKwpQnsPoe+N8bwGU6UZ7EFozC+QGbjSPDRYDSwAVBEjD7kmgITjFrTb4ckYWCjLf9HtT/0S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a2SE0mMl; arc=fail smtp.client-ip=40.93.196.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBnGp4mSkmmVS4JQxFjXN8uXwGxhUgGeJUqrwM0jgefDIaVzudhUeyZjlCvB1/sKrd6ZwwhArSL+Dp63ZDUwsWzNge1h3tkkbU8n0F6OaEVs6LNOK16qh8qSvKMEQF4sbkgPXRfoWdlROf+L7x3kplUHA7WPiKVzuNWXsxRZHFyPqdjCzibcjfSEz0pDVtzqHVxqZ71IYzQxq9cRmzTlwwj4khWkZNCAcWOBp5nUmnVOoCre8vhSdpupdezgsvWZ0Z0Im+E+HgTMxoyzHSaXlfH2dGTQtKsZP+/mBAWTNHQAn2HdJub1haPdRA10skKNaA58ehyLrb/W0/LxUv9/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcsMnF2s7XQuANvXvUE3LEzrNJqjPyqDpr7O3wfhIQU=;
 b=RrTW4jZEn/O6d7TVQ5XmsWRXXSmN0iMrtIwPhKxGMICfdmi0mprFi9eRdzDecq+LUt2aOYNI+kwRwrqYwxuTynPSbeFHJsD4CN0YxIBXxZDV5EBT66WILwqRmK9RT7TBE0hjP2XU++esYPmwcO6MGb9lzkno+7CINte904l2vf5cyivGy0e67hOwQHnk2LVWH+t05hAhK2vuxyNAgifaay58uzme8gmOcUtuUoZ1ke9i3PjxP1BxjHnmA1M7bBtmFrfGLgl4b9DE6lYZh7OYQuJIrMqWi/QYU/2nGb8gtbW0/rjcy4jm6lHFiaaRH/FHLLmFtw02Cp9bEieYlXoldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcsMnF2s7XQuANvXvUE3LEzrNJqjPyqDpr7O3wfhIQU=;
 b=a2SE0mMlNlAGTPBXGo5WdDnz0A+Qn/LXBJ8omEfRs8A4qLGm+zwcYT6nINSVYbJcDqO1EjMfeEA40/rurDoibOgWzbbhtp7KB+akXf9P/DELoLMZaU+mmiryzAQewOuuMog82I/epxUB+iHC47Ta0yXv/VyP1NvGgwge+KGyk0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 01:00:15 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9253.013; Thu, 30 Oct 2025
 01:00:14 +0000
Message-ID: <74738e82-5861-4ac8-8e96-c98a22173afa@amd.com>
Date: Thu, 30 Oct 2025 11:59:30 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 2/9] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org, bhelgaas@google.com,
 gregkh@linuxfoundation.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-3-dan.j.williams@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20251024020418.1366664-3-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY0PR01CA0004.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::11) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e95857-6ce2-4939-81c8-08de174faf66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1pRVXdpOGJXY21taVNmODFCR3QwNGlaUHZvc0tvcUdIYncvcnM0SERrMERF?=
 =?utf-8?B?WEw4UGNQT2g4RUN2aVM1dFZkbE1jNHJCQWhsaFljKzllSjV6MkR3TGdwa053?=
 =?utf-8?B?c0NxMkhueG9uczZPU3Ryb1B1WXBjcWRVYVNaYkNJZ1FCMUtHbnYvTDZxQnVR?=
 =?utf-8?B?RkdxVlRBc3VqYi9Va0p1ZUhGUlV3NmxwRWNkWjM0SmhvbzZCNWhad0c2dTJ5?=
 =?utf-8?B?ckFtOHNMQ0ZKT3BFaHR1dFBEM1YxbG1sUmlRZTdTT1hrUnBkZFlnZXNwVEdH?=
 =?utf-8?B?L3d4bStlZlpUVXRQTlNLZERTeURCRTNZQlA5aUFKWHhWSElaa1hDQVA3dldJ?=
 =?utf-8?B?RXZtNzVkdm9KcXZrV1Q0RitHclNxMEZubVJ1YjI5V1AyMEpLTUhuZ1d1R01t?=
 =?utf-8?B?a3lWdzlrSnNLZUVwWWZZN1ZkcDBlbWJxNmNYY1U3ZTVhVU5kL3ZvNVFESmh0?=
 =?utf-8?B?K2JESHJiYWNLN3RSaVl4V0pDSWUxZW5NOEdEWWFEdTRFK3huWnNYTDFMTXZo?=
 =?utf-8?B?eWhpZDBTMHlMcHN1UjBrWU5zNmFaL0R0c1cxOTZ1ZVZUUEZWZ1pmcU1CRlBY?=
 =?utf-8?B?OWhBRll2T3U3QVV1QnU4dEkrRmF6M3MyNUdaNFRaRmliZ2NkTDdRdzhJaFNM?=
 =?utf-8?B?NGJYSW85dUJnUmpQMWlHd0hEQ1pxdy92OGk1bWdqYlRiUWtwQkJwNlpwaTVj?=
 =?utf-8?B?TkxlbVpHWUtQVktNTndtZzRsckVvY1JCakg2UEdTMnRkVWs5VFUyQlhJQTRo?=
 =?utf-8?B?eGkvVjVXUVdmUkpGNGNPcUxiSFVCUGFpWWNCUldiK2xaWTdhZXdEWHdyOXJy?=
 =?utf-8?B?dnpmL0xMamZFRTNPd1JiSHpDZjZVMVlYNzF2KzA4bnMvaGhaTytmVS9LZjkx?=
 =?utf-8?B?WTV2allMRmxqSGhkcEZtSXMycDZxQUNDdnJFMG92ZDhHQ2hkK0Q3TWxUb3Zx?=
 =?utf-8?B?UERvUkR2aVpUaXRISjNha2JmM3dkU2RYTWJFV3lhYmNHM2dhVStRTExHN3Ra?=
 =?utf-8?B?YWtzRzIveWpzWlpqZVhJcnVYVWpUL3NKazQxcG1CWW9GWmlPcXgzeGV4aUQ2?=
 =?utf-8?B?bHEzdlA1ZUNIeENuNHJHYjdlcEs4ZUpjWVdYdnBSMVFNazR3aXdvQkwyUTZV?=
 =?utf-8?B?ZHl1dFR2T2JWN0NEbGxSTnVpTVFwRXZENlpac2Y1TFJSNXZQTU5QMkpmdWhm?=
 =?utf-8?B?ZTJYVzF3VEUraHdJN1lYdFJIOG9vZ3ZDREEyS3VmT0VEVytST1BjbDMvUUkz?=
 =?utf-8?B?S2J3R2NERVdQaXdVN3VSRUU0b2toSVVDSUZpM0l2MTlHTUwreEh4ditrS3VU?=
 =?utf-8?B?VVJkRWFnb1Z4bTFEc3M4SU1oS1lKRmRpQ2dkQVZJL1Z3STREak9qaVN1amlw?=
 =?utf-8?B?NU9qZXlZNjdWUHlwVlVuWkwyeVQ3UDJFTmNCSE5DdzZWWXh0SmZYQTZZZ0Zi?=
 =?utf-8?B?QWNFNmI3WVNwZngxVmQybFd2dFJtTmtFUkpCblVzMWtIL0h1ZWd4aWxlalpU?=
 =?utf-8?B?UmNqeW9kd1Y5RjBpcHJ2MDl6ZG4vUXhNaUI5NXNKMmNoU2gzOGRDM3N6TTVW?=
 =?utf-8?B?QWQ1V2NiRHBsQ1FEQTFEc2JRengwb2VzcHd6bnZrc0FScHhBNUtHeVhyUVdJ?=
 =?utf-8?B?K0YzZjQ0MWVTMkp2UjlHT2NsUTFIVnplOEMrV1M4aWVnMjFKRHJlY2h4NlRN?=
 =?utf-8?B?WXpLUCszc2VuMjlWa2FIZFkwMjFsYk9kak5WUk1XaWVpQ09tcGlheHBoODlE?=
 =?utf-8?B?WEtNSXdkcUlQL0R6TXhYR1I5clhpMWRRcUIvVnJIc3BNeUpGRXE3VzBxeWhC?=
 =?utf-8?B?dVZmOVRlcE9oM1RVUGp1aWd0S1VxdkJOaEJmM0dLcjFLamxkS3BxemlSK25p?=
 =?utf-8?B?b1VxTzlWWWFSalZtbVBrWVU2MUdDeEFDUXBVT1VQcGVod3E0U2VBMGI3eFVs?=
 =?utf-8?B?bzJmRTVhZXBycHQvZzJtK3BrbHRWZThZdEJuUWhnRWEwMFNZVWFUbWZnTGVN?=
 =?utf-8?B?SXBXb1Y3QkJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnRGM0QrYWVVWFFtMWd5aW5obnVuaHFmR2NTY1VLbjh5VFduejl1NU9kbVU0?=
 =?utf-8?B?eE82Zk96SlZUV1p5YmhuRVMrRm9maStsYStzZFRpNDVENFkrRVplbSthNUZU?=
 =?utf-8?B?cXgxZ0JyT3duOXVEM0Z2S3NEdzBYWXZaUFp4WUtBeWhLY0d3Mjd4OE02bFQw?=
 =?utf-8?B?MEhpR0FrK291L09NSzU3OFFCNGFZblh6LzhZTFVIcGdlVCtVV3ZjQzhqS0N0?=
 =?utf-8?B?cXU4Q1NFNzJhcXhDU2VGZjArd3pwRjRJWlBWZEF0dXpQbmdESFhrUXZwTHQr?=
 =?utf-8?B?WWN0empUN3VicFBiTXR4RzhVNkg2WEU0ZHQ0ZXI3eDhGV0NUdThXQWMrbE5P?=
 =?utf-8?B?dFAxU3hKeHBZNzNreUNtTUFRWXcxNjllaVJYZmZqRmc3MVRLdGhHcEZmdXY5?=
 =?utf-8?B?QktCQ1FYbGVBbTZGNjIwUmVtM3crWlgxdGZFM0IrNEF6Q3VadVJTcGwreXZL?=
 =?utf-8?B?QXVDd2JxaHJtdllSb3oxekdZUmoxeC9pcjV1OXN1QkV3NkVJbVZaZzlHdmt5?=
 =?utf-8?B?czhJWXN6RjNXQUVnV2Q1eVJYQzdNWFN2eXZQNy8zS1ZoakNsRm1ITW5JZWZM?=
 =?utf-8?B?MzhNdzhqeEpUMGk1S1o5TE9yb1hCSzc5OWFCVkM4RHZCNW54WHJHT2pxVm9x?=
 =?utf-8?B?eUdlOFBkZG8xQnhxL3F3UE15Yi94ZUhqUDNvZWdPY29xK3FLbkY0SWpXblNj?=
 =?utf-8?B?T28rbFBIUnE3cktVREczTGV4SGZLRzVTUURTNTJWV0VWY2dOSFRTQkJPL2wz?=
 =?utf-8?B?Sjk0MWRQb0FXMFFVaFJsQnd1SktJblZxdmx6TE1lZkhTM1BJaXVKeUNZNHVW?=
 =?utf-8?B?NDNuQ1F2NUt4N0IySXl1TkxWTFRnVHdSZzRQNWh2MmNqaEVYODhTd252YmJH?=
 =?utf-8?B?cHlEbnVEWFlrVnpKTGgwUm9oVWdBQ2hIZmNzUFpzblF5WkFxQjdLWGlrSzU4?=
 =?utf-8?B?aURiQUlTZzRPMWNmQVhOdWR5U3pmSVphYXlPWW40YTJDZDh3Vml6NjlMQW5h?=
 =?utf-8?B?WEF0K0RlTVk2WldDOU8rNWx2cjNHU3lZaW9pcWREYWlGdDZvYi8ybkw3amhm?=
 =?utf-8?B?MkdWSFM0Ym9iRXhUZlhzUWNWdnRrcXRkZmxuYUFvdW9SLzZnZXBhc2hzaS80?=
 =?utf-8?B?M3FVUTRLMFpGWVVUanFaRTJHR01OVHp4SjNZUzA1YUNtMkRhSDhaSVdXTXZm?=
 =?utf-8?B?YVFXeDdLcy9CdWo4VTZaeVlMZjdlaUJrZFArNGlwdjJ2TnhQMUVqTFJmbEhT?=
 =?utf-8?B?TmtzZ1ErMHdSTjBMTEZzdUs1R3lvWFZSY3R3VE9sckFIK3d6YzJHWmF4ZlBF?=
 =?utf-8?B?a2c3bUhiQjJITTJJN0JMT3RySnVseFlVZzZRWFJibXkrcEx4WldRS2xTUXhF?=
 =?utf-8?B?Y1VHT3cvL0lYanc0MkQwZFVpRkNtcTNsY3lXaU8zZzZBbGI2WExKN2dxWVNP?=
 =?utf-8?B?NXBPWGN6OWpvS3g4TkxsN2gwTW1hU1dFZlJCVkU2aTFVTU8rVll6K0U2UFp2?=
 =?utf-8?B?Z2E0T0JlZXlNZGcrYW9iL3ROV3Jtc2RKM2ZHK1Q4Ujc1NmFuMDlmTHkxMytE?=
 =?utf-8?B?di8xMEVwMmhRS05QQ01DVUZtMlB3RVJOZlZNN1BsbjRLUkl1bEZaWFo5Umhu?=
 =?utf-8?B?SlBmeTY3T3hWS2M3LzFxRzRvTytGcUFZbzF3N1A5dDhrYzNvc05KSUQ3Z05I?=
 =?utf-8?B?S1h0UFF0UDhVMDJDMlNYeUd2VGNyVmUrYmRKZkFoY2x0YjZxT1NEcjBIRW1B?=
 =?utf-8?B?ck85ekRiUXZac2l4U2R4UTV6YllBcXNIUzFiOW1nTlpBVENaOFUzaC9pRGxr?=
 =?utf-8?B?N2hLRVNJQVlkWnNRbmJDMzlmc3kzS3FZRHFZcnpmSjI3bDN6ZmxjYmI5cmQ4?=
 =?utf-8?B?dEdOcmJZUEgrZHovdU1UQ1VHVERPV2w1aDY4bmVQaktHYUlOYS9Wc3F6Tjh5?=
 =?utf-8?B?L01BQlpIclBsamtkZEN0SUpwMEgwbFdHV3dhZTd2dEFLOUFJZzdEaklvLzdE?=
 =?utf-8?B?MmtDZjVYcklJbTRoN1l3Smo0VjBwTXplb2RUSmdCSCttVGpQcEpVWGVyTW1k?=
 =?utf-8?B?Wkg5d1BjbU5aUjhPb0c4Q0t4d01qSG9XOUhBVGtHWFQzME1LZ0l5TmhqdTgx?=
 =?utf-8?Q?TLwafg5uVDkXyqJugTSj+AWoP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e95857-6ce2-4939-81c8-08de174faf66
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 01:00:14.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtvU+05F00153XmqX3MT5N9/duUe+CWouUQIFUD834vQiFosLWfLRRcSSyHH5eY0cVzlic/bH6xGdL4n2lD6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729



On 24/10/25 13:04, Dan Williams wrote:
> Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
> 7.9.26 IDE Extended Capability".
> 
> It is both a standalone port + endpoint capability, and a building block
> for the security protocol defined by "PCIe r7.0 section 11 TEE Device
> Interface Security Protocol (TDISP)". That protocol coordinates device
> security setup between a platform TSM (TEE Security Manager) and a
> device DSM (Device Security Manager). While the platform TSM can
> allocate resources like Stream ID and manage keys, it still requires
> system software to manage the IDE capability register block.
> 
> Add register definitions and basic enumeration in preparation for
> Selective IDE Stream establishment. A follow on change selects the new
> CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
> both a point-to-point "Link Stream" and a Root Port to endpoint
> "Selective Stream", only "Selective Stream" is considered for Linux as
> that is the predominant mode expected by Trusted Execution Environment
> Security Managers (TSMs), and it is the security model that limits the
> number of PCI components within the TCB in a PCIe topology with
> switches.
> 
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/pci/Kconfig           |  3 ++
>   drivers/pci/Makefile          |  1 +
>   drivers/pci/pci.h             |  6 +++
>   include/linux/pci.h           |  7 +++
>   include/uapi/linux/pci_regs.h | 81 +++++++++++++++++++++++++++++++
>   drivers/pci/ide.c             | 91 +++++++++++++++++++++++++++++++++++
>   drivers/pci/probe.c           |  1 +
>   7 files changed, 190 insertions(+)
>   create mode 100644 drivers/pci/ide.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index f94f5d384362..b28423e2057f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -122,6 +122,9 @@ config XEN_PCIDEV_FRONTEND
>   config PCI_ATS
>   	bool
>   
> +config PCI_IDE
> +	bool
> +
>   config PCI_DOE
>   	bool "Enable PCI Data Object Exchange (DOE) support"
>   	help
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 67647f1880fb..6612256fd37d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
> +obj-$(CONFIG_PCI_IDE)		+= ide.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4492b809094b..86ef13e7cece 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -613,6 +613,12 @@ static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { }
>   static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_IDE
> +void pci_ide_init(struct pci_dev *dev);
> +#else
> +static inline void pci_ide_init(struct pci_dev *dev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d1fdf81fbe1e..4402ca931124 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -539,6 +539,13 @@ struct pci_dev {
>   #endif
>   #ifdef CONFIG_PCI_NPEM
>   	struct npem	*npem;		/* Native PCIe Enclosure Management */
> +#endif
> +#ifdef CONFIG_PCI_IDE
> +	u16		ide_cap;	/* Link Integrity & Data Encryption */
> +	u8		nr_ide_mem;	/* Address association resources for streams */
> +	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
> +	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
> +	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>   #endif
>   	u16		acs_cap;	/* ACS Capability offset */
>   	u8		supported_speeds; /* Supported Link Speeds Vector */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 07e06aafec50..05bd22d9e352 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -754,6 +754,7 @@
>   #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>   #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>   #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
>   #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
>   #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
>   
> @@ -1249,4 +1250,84 @@
>   #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>   #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>   
> +/* Integrity and Data Encryption Extended Capability */
> +#define PCI_IDE_CAP			0x04
> +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> +#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
> +#define  PCI_IDE_CAP_ALG		__GENMASK(12, 8) /* Supported Algorithms */
> +#define   PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> +#define  PCI_IDE_CAP_LINK_TC_NUM	__GENMASK(15, 13) /* Link IDE TCs */
> +#define  PCI_IDE_CAP_SEL_NUM		__GENMASK(23, 16) /* Supported Selective IDE Streams */
> +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */


Since you are referring to PCIe r7.0 (instead of my proposal to use r6.1 ;) ), it has XT now here and in the stream control registers.

I posted a patch for lspci with this:
https://lore.kernel.org/r/20251023071101.578312-1-aik@amd.com

Otherwise

Reviewed-by: Alexey Kardashevskiy <aik@amd.com>


> +#define PCI_IDE_CTL			0x08
> +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4  /* Flow-Through IDE Stream Enabled */
> +
> +#define PCI_IDE_LINK_STREAM_0		0xc  /* First Link Stream Register Block */
> +#define  PCI_IDE_LINK_BLOCK_SIZE	8
> +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> +#define PCI_IDE_LINK_CTL_0		0x00		  /* First Link Control Register Offset in block */
> +#define  PCI_IDE_LINK_CTL_EN		0x1		  /* Link IDE Stream Enable */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR	__GENMASK(3, 2)	  /* Tx Aggregation Mode NPR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR	__GENMASK(5, 4)	  /* Tx Aggregation Mode PR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL	__GENMASK(7, 6)	  /* Tx Aggregation Mode CPL */
> +#define  PCI_IDE_LINK_CTL_PCRC_EN	0x100		  /* PCRC Enable */
> +#define  PCI_IDE_LINK_CTL_PART_ENC	__GENMASK(13, 10) /* Partial Header Encryption Mode */
> +#define  PCI_IDE_LINK_CTL_ALG		__GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
> +#define  PCI_IDE_LINK_CTL_TC		__GENMASK(21, 19) /* Traffic Class */
> +#define  PCI_IDE_LINK_CTL_ID		__GENMASK(31, 24) /* Stream ID */
> +#define PCI_IDE_LINK_STS_0		0x4               /* First Link Status Register Offset in block */
> +#define  PCI_IDE_LINK_STS_STATE		__GENMASK(3, 0)   /* Link IDE Stream State */
> +#define  PCI_IDE_LINK_STS_IDE_FAIL	0x80000000	  /* IDE fail message received */
> +
> +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> +/* Selective IDE Stream Capability Register */
> +#define  PCI_IDE_SEL_CAP		0x00
> +#define   PCI_IDE_SEL_CAP_ASSOC_NUM	__GENMASK(3, 0)
> +/* Selective IDE Stream Control Register */
> +#define  PCI_IDE_SEL_CTL		0x04
> +#define   PCI_IDE_SEL_CTL_EN		0x1		  /* Selective IDE Stream Enable */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR	__GENMASK(3, 2)	  /* Tx Aggregation Mode NPR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR	__GENMASK(5, 4)   /* Tx Aggregation Mode PR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL	__GENMASK(7, 6)	  /* Tx Aggregation Mode CPL */
> +#define   PCI_IDE_SEL_CTL_PCRC_EN	0x100		  /* PCRC Enable */
> +#define   PCI_IDE_SEL_CTL_CFG_EN	0x200		  /* Selective IDE for Configuration Requests */
> +#define   PCI_IDE_SEL_CTL_PART_ENC	__GENMASK(13, 10) /* Partial Header Encryption Mode */
> +#define   PCI_IDE_SEL_CTL_ALG		__GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
> +#define   PCI_IDE_SEL_CTL_TC		__GENMASK(21, 19) /* Traffic Class */
> +#define   PCI_IDE_SEL_CTL_DEFAULT	0x400000	  /* Default Stream */
> +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	0x800000	  /* TEE-Limited Stream */
> +#define   PCI_IDE_SEL_CTL_ID		__GENMASK(31, 24) /* Stream ID */
> +#define   PCI_IDE_SEL_CTL_ID_MAX	255
> +/* Selective IDE Stream Status Register */
> +#define  PCI_IDE_SEL_STS		 0x08
> +#define   PCI_IDE_SEL_STS_STATE		 __GENMASK(3, 0) /* Selective IDE Stream State */
> +#define   PCI_IDE_SEL_STS_STATE_INSECURE 0
> +#define   PCI_IDE_SEL_STS_STATE_SECURE	 2
> +#define   PCI_IDE_SEL_STS_IDE_FAIL	 0x80000000	 /* IDE fail message received */
> +/* IDE RID Association Register 1 */
> +#define  PCI_IDE_SEL_RID_1		 0x0c
> +#define   PCI_IDE_SEL_RID_1_LIMIT	 __GENMASK(23, 8)
> +/* IDE RID Association Register 2 */
> +#define  PCI_IDE_SEL_RID_2		0x10
> +#define   PCI_IDE_SEL_RID_2_VALID	0x1
> +#define   PCI_IDE_SEL_RID_2_BASE	__GENMASK(23, 8)
> +#define   PCI_IDE_SEL_RID_2_SEG		__GENMASK(31, 24)
> +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
> +#define PCI_IDE_SEL_ADDR_BLOCK_SIZE	12
> +#define  PCI_IDE_SEL_ADDR_1(x)		(20 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +#define   PCI_IDE_SEL_ADDR_1_VALID	0x1
> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW	__GENMASK(19, 8)
> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW	__GENMASK(31, 20)
> +/* IDE Address Association Register 2 is "Memory Limit Upper" */
> +#define  PCI_IDE_SEL_ADDR_2(x)		(24 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +/* IDE Address Association Register 3 is "Memory Base Upper" */
> +#define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +#define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
> +
>   #endif /* LINUX_PCI_REGS_H */
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> new file mode 100644
> index 000000000000..aa54d088129d
> --- /dev/null
> +++ b/drivers/pci/ide.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> +
> +/* PCIe r7.0 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#define dev_fmt(fmt) "PCI/IDE: " fmt
> +#include <linux/bitfield.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +
> +#include "pci.h"
> +
> +static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
> +			    u8 nr_ide_mem)
> +{
> +	u32 offset = ide_cap + PCI_IDE_LINK_STREAM_0 +
> +		     nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
> +
> +	/*
> +	 * Assume a constant number of address association resources per stream
> +	 * index
> +	 */
> +	return offset + stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
> +}
> +
> +void pci_ide_init(struct pci_dev *pdev)
> +{
> +	u16 nr_link_ide, nr_ide_mem, nr_streams;
> +	u16 ide_cap;
> +	u32 val;
> +
> +	if (!pci_is_pcie(pdev))
> +		return;
> +
> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	if (!ide_cap)
> +		return;
> +
> +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> +		return;
> +
> +	/*
> +	 * Require endpoint IDE capability to be paired with IDE Root Port IDE
> +	 * capability.
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> +		struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +		if (!rp->ide_cap)
> +			return;
> +	}
> +
> +	if (val & PCI_IDE_CAP_SEL_CFG)
> +		pdev->ide_cfg = 1;
> +
> +	if (val & PCI_IDE_CAP_TEE_LIMITED)
> +		pdev->ide_tee_limit = 1;
> +
> +	if (val & PCI_IDE_CAP_LINK)
> +		nr_link_ide = 1 + FIELD_GET(PCI_IDE_CAP_LINK_TC_NUM, val);
> +	else
> +		nr_link_ide = 0;
> +
> +	nr_ide_mem = 0;
> +	nr_streams = 1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val);
> +	for (u16 i = 0; i < nr_streams; i++) {
> +		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
> +		int nr_assoc;
> +		u32 val;
> +
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
> +
> +		/*
> +		 * Let's not entertain streams that do not have a constant
> +		 * number of address association blocks
> +		 */
> +		nr_assoc = FIELD_GET(PCI_IDE_SEL_CAP_ASSOC_NUM, val);
> +		if (i && (nr_assoc != nr_ide_mem)) {
> +			pci_info(pdev, "Unsupported Selective Stream %d capability, SKIP the rest\n", i);
> +			nr_streams = i;
> +			break;
> +		}
> +
> +		nr_ide_mem = nr_assoc;
> +	}
> +
> +	pdev->ide_cap = ide_cap;
> +	pdev->nr_link_ide = nr_link_ide;
> +	pdev->nr_ide_mem = nr_ide_mem;
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a8..4c55020f3ddf 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2667,6 +2667,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_doe_init(dev);		/* Data Object Exchange */
>   	pci_tph_init(dev);		/* TLP Processing Hints */
>   	pci_rebar_init(dev);		/* Resizable BAR */
> +	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
>   
>   	pcie_report_downtraining(dev);
>   	pci_init_reset_methods(dev);

-- 
Alexey


