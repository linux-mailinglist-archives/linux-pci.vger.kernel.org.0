Return-Path: <linux-pci+bounces-19768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41CA11295
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DE5188A56B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5742207643;
	Tue, 14 Jan 2025 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eqs7QIO3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFD8493;
	Tue, 14 Jan 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888209; cv=fail; b=Q4RfLmBJJw+o9+zRXhb6jt0jBpHuGuYDpL4FT+n/Y7b+Q8ObIVtyimmuiLSoXGa1rYs+nhi4jJXGg37JbY3ii864F/9/8t3m9OgCuPscmr+EZRUmfcMJ9K4SvwXylpc8KhRj7MLUdQ0NGPT+mD/oeHORkTUBqOQ5cYQI67nAAVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888209; c=relaxed/simple;
	bh=IlELOCz27boMHHJRgwgPXG3whrAgp18lojI4lriCF3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qHeFT+FGGqEhvsCpbTvGX3KXSdrfJ1FCQoxkW4Q42Ty/2loOGFh7m7DVpeoPk6cgsRuHQQwQ+7sJrADg1h6t9FwQyr3f1FK5B9wL/2e+lKwhnb5M3tvfua+g5fC0OPE1kgfhYEz3KNzMbNLBrXqWyQnTtp12HcQW1C6nZD75zBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eqs7QIO3; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cbik9YfSN06ZZR88aT9SxJQW5PLDtT6cEBhBIuoKzCf+P3jkHUN6aq0Hciwq/lCVV3i8I20hyF6ejZSD9cznIw6ycNe8LYLOeyaITbHUhV82itwuhK9xP/KkHcqlZvZ2eyX0HdizMq9LkQj5xkMnhC9KX/6n8EVPTmxReQfR72XL9z+LWKob3MxRb5TRa8JjhofyiA1VFow1IkUENfxITG5NzsvjPjWUk016Uqmn5utb59qNjzzDcaH5/hg6F9OIWSP2j+efWNkBkr4lGL3ieq35DfJz6pU70zslmfh4SNTiIj6Tz+s9wIXjxJOR/2n86WDpdX8n64ec+dfXEf0HSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yz49ctg8vcmAfa7dvD6okzOaFHRgC0FJ4bOZ1Ptrcw=;
 b=BEI03kRNXCauA4DDK3Ha8w63Y27zwe2k7hY+IxuS/0wQ4GeRXJwmqeaXv9e6UL6/UoFSOht/cAr1Y8DE09I9N1kiPr3oHN4XTujqtb2tnE9efnma47e4cOgYz2pXel38tvufnc7jOrcK407cU4SbGAK7NE8uOErsNkrkGPLhLuOu67tJhEG4YW59NHGlpzoiWlf2heBFHAoJ24xBquI09AND1Jc5qa45RWjo5D8DKaGYQy80tGO1qbt1E34TE9vxTZ5XtF1CWbxWhxPfVItCC1Hey1UmLo1hMRt4iecviJjSeGpv6rYKONOuhaiFdqoJXEdYTL5vDARfCc8roDIATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yz49ctg8vcmAfa7dvD6okzOaFHRgC0FJ4bOZ1Ptrcw=;
 b=eqs7QIO3WNE87C9Aab09w55/36wsdJOvK/AsbKvPLpNmtVtWoh0LTg+kOTvhJNt/tjsz4nKgdmegAjtwmA1sSNTDe5IRJEE+BnPQuDsEyMXkvp6mc8iJz79WoFxz79UsUlwlkCtGaoxZcftdffV1ntCmcuGE4/pEuigSNlta6e0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.17; Tue, 14 Jan 2025 20:56:45 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 20:56:45 +0000
Message-ID: <ede2efa6-1f67-466b-9f86-883b25092d2c@amd.com>
Date: Tue, 14 Jan 2025 14:56:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-15-terry.bowman@amd.com>
 <20250114114927.000022ef@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250114114927.000022ef@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:806:125::14) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d80ff51-5cf5-48b1-4980-08dd34ddf466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVZ0QVhKeEMycDNqVk5CZTJqSEhOYlhxY1dycUlEaU53ZzNpdzI5RW9LU21I?=
 =?utf-8?B?SEJ6a3Q3MDBrSzdVeDJKQ1d5REVxdnErMWJBMFVrdWJ5bFk1Y2FwR3RpbDZF?=
 =?utf-8?B?VlZNMXpMOGxsWktJL3BWem8xcnlXcmhvalRZSW45TlVnT2p4aWNaK3AyeGky?=
 =?utf-8?B?SHgrWTBiSHhnRkJ5TW9TV253RTdIcTA3RUoydXlDK2tmWGFCUDV2WnlRMEE3?=
 =?utf-8?B?MmowM3dicVdpN09rU1RrM0p5K2VTMHA0dHk0cXAvWTV3b3dEZEFvZ052RnlR?=
 =?utf-8?B?V1pMSDhDMXh0Tmhla08vSW1YWWxod2VzTFNMdzVRb05sSllnYUZUQ1VoRnlm?=
 =?utf-8?B?WkE4ZUJKTjNDQWpzUDJwYkVXSFpNZE9qMFR4ZlprS21PL2VDTHg4c0VITlQ5?=
 =?utf-8?B?WUtPQUlTUFdIeGJFbEZsWEpIc3BDTXMxaG53bWY1ZmVlTjB4ZVR4enhiL0Fr?=
 =?utf-8?B?VVpkalJiNFpoTjZMYmtVRDh5aFFMZmExSVVIRnp0cnFNZ2dncTRJajZFbklm?=
 =?utf-8?B?My82RTJMQnZ1QXlSS0RkekRFeGJjNEZMUWdoTURTSFNFZkZCdHlrWWplckEw?=
 =?utf-8?B?ZFl3bWRBc0o2UmJqWjRPT0h5aXN1ay90ZmNpZnI2eUMvMXNyOGFRUWYxQUlw?=
 =?utf-8?B?a1V6Q0JyaG95UWkrTEFIVEZiek5FdTA3U2xEOUhLb2xGd0NkMWNnWiszRzFG?=
 =?utf-8?B?MFdlT1R2U3hheVRxUENoOWhMb3A2aURCVjJDTlJYdUcvaDBCZVpqOTBVRkxH?=
 =?utf-8?B?Yy9Ja2VBUjk4TmQvcTRBWCtIV0VheUlVSzJsTGtzV3FpVjYzVHN5eW9Pc3hD?=
 =?utf-8?B?VEliQWpaUCtseE1mMTZSTUZpNVlkNVJIWlUwWmUzYmhoTk1nR2ZCOTJsLzJZ?=
 =?utf-8?B?bnAvczVJMzNZTm9CYlFSQUVlVkk0cS9PUEpvWHhBZ1ZaNUxlL3dHQlI1K0NV?=
 =?utf-8?B?UE9hYVF6N1lQZnVab1V1bDZ3TTlSNHlhKzgycW5YVGs3ZUZueVpaUHdmaVRo?=
 =?utf-8?B?Zi9RSzcrMjduYnc5YnNwL1grWjlJQW92T2xXSmtZMGVxajRtMXlNbmZDUytF?=
 =?utf-8?B?K3JoTFlaM2VUU0NVZVBuNjRZYW1wUDMxRmYyZWE0c0lhKzZKVzNJcktaS3dw?=
 =?utf-8?B?dGw4WkNyTHdCaXpRVGljdzF4ZUs2QzZTbTRCRVVEdmM0RDJPQ3NTTG83OXJF?=
 =?utf-8?B?ZGY2d2MwR3lrYVF2TnFoS3ZKOWZSSFZneEZ3Qm5waGV6b1FZNFBOZ3dKaFcw?=
 =?utf-8?B?MmR2SFN5eGtSeUJXM3pYMUFaVVlDdTdnWGNqL1JJN0pydnR1ZGRERWRQaTMy?=
 =?utf-8?B?a0ZZRVBqY3RybkhiUzRhTzliRFh1Y0FmVVZOTE1odUxLcXFkaytodVRXM2xa?=
 =?utf-8?B?RUk2MzdCTUpuVG1FUHg0Z1VQWnlkb3ZMZnc5RzJmRnl2SkJFTjI3V09VK1R1?=
 =?utf-8?B?MmdoM2JWSFpHbFV2Z1JVSUV2VFNYWnQyV250M1JBT1A3eHREdUFlYU83dFJX?=
 =?utf-8?B?SUFpRXpEVnplSzBjeC9XYWMyQUc1RjJDY0wzZXhVMmZVZ1J4OEl0cWtNMkE0?=
 =?utf-8?B?b1JkZHpIdy9CR29vOFBiNHdWSFJhVTYva2FkWUdUOXBsK05tZExDdUJyK1FP?=
 =?utf-8?B?UzFPZGYrUnlnbFU1eXhHbzZ2MDd4aFFaendPenU2U0NhaUsyVjVoRGdWaUh5?=
 =?utf-8?B?M0xjZzRjQ2Q2NjBUYzNmK0x5dUs3eXQ0eFBrZlh0RVhmZ1VEU1RpMG1iQUhM?=
 =?utf-8?B?RGg2VFFYeVVrNzQzdlRGMmp1SHlaRTNqSDh3SHMrOWlNUDRGOUliY2UzdFhv?=
 =?utf-8?B?bjI3czhXV1ErK0ppNG55VTkrYUFFS0JTNll2VGNCMk1vWjRKdDU4L3Y1YWc2?=
 =?utf-8?Q?d8j1oRAFWCVsa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clgrV050VkZkeDNZYnVvM0U0QXZxVDdXUGIrWG12OUxrTEFXcUJjRVBrS3V1?=
 =?utf-8?B?RHhKWjBNMHFZSUpIOUxzaWpwVEVvSzFkWGJuSmxoeHVlVm9GeWRuK3lmYU5B?=
 =?utf-8?B?T2ZoT1FBM293bnQyK21MTFVBQlEvVS9iRGc4TWdpRlcxa2Rxb0lhUDBLNjBx?=
 =?utf-8?B?bWNrWmpzbFpxOStOT0xxOHFQMHRnNFp4a1ZTKzQxR1dvekFlQllSQ3o2K2Er?=
 =?utf-8?B?QmtJdzFrMldEbUkzTHBmUUhkK01ZY2t3UGVsbjhjYXRQZkZYR1VsRHliVWZU?=
 =?utf-8?B?YzZmbkFMOW9xZW9lejdhbW82ajJ1NkkvdU5ML3NabFkvaUZITWlsRmFkTDdz?=
 =?utf-8?B?Q3pSRnVTZHFvS25iektsVm13SG5RejZMTHhJbzY5cXJ6NU1hWWlNbXNXWWsw?=
 =?utf-8?B?MUx5Y3RIV3FNMFpITzZDYlhZdlQyM09ad3ZRQlF3K1dhRTFLeUNEV3JCS0pk?=
 =?utf-8?B?TWpSMi9paG1FcXc1QnE1dXlNMGIwbHV0RVFteUx0cnZQdjBxT1FhM1lyNE56?=
 =?utf-8?B?NStyUG5NcnRUbSt6RGt2Q3g5OXViWWxQOVVibFV5SlhCZVNxTVp5a0Y4K3JV?=
 =?utf-8?B?ZEh6bDdQZ2hERUx6bUZUOG1UNkwwc2RncWVxNGhWWVp4b3FLcUVjaVBBNmJS?=
 =?utf-8?B?a3Uvc3QyOGVOMEM0aXcvUG5meTZyeWFsaGREb3lHZzFieStoTysxUHpBd1B5?=
 =?utf-8?B?QzVCaVhvOW5NTFZpUU8yMW9mNUlqNWtISmlzdnJQaFNwMGxZMERNbm4wQXFj?=
 =?utf-8?B?Ymx6RnhUQzRrTW51QXg1ZkN1ODZXWG9xd04rT2F4L3JuNEg0ZUxyOWxNY3hJ?=
 =?utf-8?B?eHNQcFdPQUdDN0tNL3RLekNMWDdwbXU1TVFnR1hKdk0wYkNqUVhER3ozUUZF?=
 =?utf-8?B?NW51STRhOTNqNllNdVVOMy95dktTM1dxcnhhN3cvTDh3emk4VUpoOU9td3V6?=
 =?utf-8?B?QlJtSGJvbjZjdW9FK0ZEdHQwSzNUWm52UlkrS0hpUGpXTDFCdStMemd6eExk?=
 =?utf-8?B?K3ZkTjV6QTZrZC9LZ2FXTjdOTy9PNjNrbkllUjQ0aEhYdUc2RHNZUGZ4aGph?=
 =?utf-8?B?bHZ4OWhBL3dHT2dvK3NNaDc5a1ZQYm9RQ1JhUTl0MmhTdnZ0blVWamFyY2hv?=
 =?utf-8?B?cnpYY2dEOGZiK2Q0c3RMWUNia1F5cVZJSGcvWm1WditiWm14OXZYOTZLdW1O?=
 =?utf-8?B?Ync5QmQ3R3AxQjdvQlE0SExqMjd1QTdyQ0pjV1ZTS2RqL21sYmpsRnZBazNS?=
 =?utf-8?B?cjVOdmZQZ3ZXTFUvTkRuS2N0MC81ZVpSUWdQVjVtVVRKRmVxY015Z2xnQXVO?=
 =?utf-8?B?bkJXaFVtNHZFSjYvZGNodFBER2FnWWNIT3dUZ04yQXg4UTBPby9hRGc4TGZn?=
 =?utf-8?B?NEV1ZFNvK1lwYzR4OEdDZ200bEdjYjFQSVcwM2FMeEtVbmVxcUlCWXhadHJF?=
 =?utf-8?B?L3UrZHRuRkM4WTluMDNNeldzU1VYekVzZXlUQzhJYmx4NjZrTVo5Q3RrK2JB?=
 =?utf-8?B?YXVMRldvYkVQbExjOFNsS1Q4MFBrcnJ1Z2NGeW91V0NvbGZYS1pIL0tIMXFX?=
 =?utf-8?B?OXlsOVoxWHZKK1ZyYkd0c3lUZVlqUmVxMGV5dXgxS3k4TlE3bUJ3RmEvVjhR?=
 =?utf-8?B?dERVOTF0cS9ITTNsVEpHUEJweTQ3eG5KYW9Qbms3ZHpGTm5jdXplcUd1TWov?=
 =?utf-8?B?azZVZDBPNW1TQUptQUprbUJsR1UvZ05ITlh0NE1zc3ZIYnp3NTUxNzRYV0Ey?=
 =?utf-8?B?eXZ6djdFejhFSU0zS014em9rOUx2OHhZL3BxaFJSMGhQZ2xQdmdaL0FaQUEr?=
 =?utf-8?B?UjVEZ2lUcUlRR0phTXRGWFp0NEtDSDkwMHFaMVVYOFl5UUlqbUp5WUNobmJ6?=
 =?utf-8?B?SmtjVUxZcWo5c1A2OUlIeW5uRm45WDdxMFlyeW1CVmxDcTZHTUI3WERUQzNP?=
 =?utf-8?B?aWJzclM5andDeE42K0t6ZHlEZnUrSW9KeXl4aE1hd0M1OTRiVk1LeWVQQ1ZF?=
 =?utf-8?B?bEo0NGlrNHI0OHAyN0xzZFBUY09vSElJMnViOXVxWkovblFUcnBwdmsrenhY?=
 =?utf-8?B?U1BUa2x4VkZzYWlnaXpDMnVTOTlyV00zSE1NNTd4YU5scXZOZENKLzljckhO?=
 =?utf-8?Q?pTYFREOdWsC5CpRUOS7tGCyGs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d80ff51-5cf5-48b1-4980-08dd34ddf466
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 20:56:45.0828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGYIAFj3TpA7gvTUDE/zCM9//4kPwlJE8J2BAGVs/sLfsZan4QnUV0E5JKK0vbYX/nh53HIHxNNaWq6oJ69FPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653




On 1/14/2025 5:49 AM, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 08:38:50 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The CXL drivers use kernel trace functions for logging endpoint and
>> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
>> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
>> Upstream Switch Ports.
>>
>> Introduce trace logging functions for both RAS correctable and
>> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
>> the CXL Port Protocol Error handlers to invoke these new trace functions.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> An example print in commit message would help understand what the tracepoints
> look like.
>
> Few more things inline following on from earlier comments.
>
> Jonathan
>> ---
>>  drivers/cxl/core/pci.c   | 17 +++++++++++----
>>  drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 60 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 411834f7efe0..3e87fe54a1a2 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -663,10 +663,15 @@ static void __cxl_handle_cor_ras(struct device *dev,
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
>> +
>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +
>> +	if (is_cxl_memdev(dev))
> As below. Drag to earlier patch.

Ok

>>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>> -	}
>> +	else
> and perhaps check it's a port mostly for documentation purposes.
>

Ok

>> +		trace_cxl_port_aer_correctable_error(dev, status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>> @@ -724,7 +729,11 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  	}
>>  
>>  	header_log_copy(ras_base, hl);
>> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +	if (is_cxl_memdev(dev))
> As mentioned above, drag this if to the earlier patch.

Ok

>> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +	else
> For documentation purposes mostly I'd be tempted to have an is_cxl_port() check
> before calling the following.
>
>> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
>> +
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>>  	return true;
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index 8389a94adb1a..681e415ac8f5 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -48,6 +48,34 @@
>>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>>  )
>>  
>> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> +	TP_ARGS(dev, status, fe, hl),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__string(host, dev_name(dev->parent))
> What is host in this case? Perhaps a comment.
host is a string initialized with value from dev_name(dev->parent). What
kind of comment would you like to see here?

Regards,
Terry

>> +		__field(u32, status)
>> +		__field(u32, first_error)
>> +		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname);
>> +		__assign_str(host);
>> +		__entry->status = status;
>> +		__entry->first_error = fe;
>> +		/*
>> +		 * Embed the 512B headerlog data for user app retrieval and
>> +		 * parsing, but no need to print this in the trace buffer.
>> +		 */
>> +		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>> +	),
>> +	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
>> +		  __get_str(devname), __get_str(host),
>> +		  show_uc_errs(__entry->status),
>> +		  show_uc_errs(__entry->first_error)
>> +	)
>> +);
>> +
>>  TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>>  	TP_ARGS(cxlmd, status, fe, hl),
>> @@ -96,6 +124,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>>  )
>>  
>> +TRACE_EVENT(cxl_port_aer_correctable_error,
>> +	TP_PROTO(struct device *dev, u32 status),
>> +	TP_ARGS(dev, status),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__string(host, dev_name(dev->parent))
>> +		__field(u32, status)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname);
>> +		__assign_str(host);
>> +		__entry->status = status;
>> +	),
>> +	TP_printk("device=%s host=%s status='%s'",
>> +		  __get_str(devname), __get_str(host),
>> +		  show_ce_errs(__entry->status)
>> +	)
>> +);
>> +
>>  TRACE_EVENT(cxl_aer_correctable_error,
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>>  	TP_ARGS(cxlmd, status),


