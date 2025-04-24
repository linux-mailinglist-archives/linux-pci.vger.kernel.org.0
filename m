Return-Path: <linux-pci+bounces-26706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2DA9B43B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647EF1B81463
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B67D28467A;
	Thu, 24 Apr 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mq2sKnhA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8827F74A;
	Thu, 24 Apr 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512631; cv=fail; b=hSvHb36Ta7Ac4Es/4gck6DCRXCoJcgJt23zJ07Po4bvyC4j3OJ+MlQZZ8dUDAckSApdgnDZkOkeCYB7+qs2UqclQmUIur+xZvzvM1KOKbfGyb+ZkxbR5hGNrqGLpuYDCprxbjJT1dv1OPu1W2pUbKYfj0hO34RJcwdkcSpXP6A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512631; c=relaxed/simple;
	bh=n2ovZzgDcnamwQOTeao5gW1Ky7qf9K3V/tdgZOqdzzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=scddIoEaUtUI440+LrrSOgqgBQGNZKYInbW4NuRu5c4PNnBwkybUSw1uOcA4yxdy28p+1zVAySBgzNVB6oEgkGdUFs4mgTCO3coUBprp1fU6xw7Befg652gLdqLxQ1c4yMaHj/jV8WBXgOWcc8qCwiKIvDhzDAT+U+mmngPipN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mq2sKnhA; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOEk6aOe2IPzE+UvvIkMAhKi44ZjNxqXr60CuN5JqtpFD6U9ykCv+2mXvxeAtJ5yQ+ny2MrczQ3Hgif5W2dlstvejBL73eZK0IN8KtV69GI6A1qYAHx0DvNxgTpAC2YFa+0++HyJDNSaIzuvTE6Ua57mGtfNJHlp/uVZAigFSU9frOWvgGUYluaqbZ2C8r3HiQEID+0J8I9iRTH0kw3YdMH3D8m+iCqB3m8QjlJ+CVQ5DVGuHM7Pb6R2K3ytuZHKUMSEycAqQwerpCdvmqdwkyutk4s/ypGOcUChNK8p3VKehVSMGI22h5I63ONKt+lB5HH58mERylVJFGsRoGAv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RuLlA5tCx+gMglcNceYmcBGl1igUJfQvJPd9gc4Y00=;
 b=hYplB6tcRZV3cQbHxx8fhoKLMu6lTay0gv6fb2mhgGki7PaQxXYlG7Y8jt3RW0K9/naMVBstk0RXgZIFt9Cgn6mNV3Vb9ITU5f2Mf9O+tum1fR0H7EELK4SIO65Px30t2+34abZ8ml7SMfh7ikeAoYUXCeh/m/C2+441f+YAw5babpJLYKm7F1QyymFSzWu2fcQqhakoYSpRINLwVhiYfXo8UZTOE3bKj7h33pbKPvH8fuYEs7+704ZOHwWaQgwT5J1g6HFeZhtQgn9JeXdC7TXSB29mrnxAAuEbjUUmUH8m/kFcNsuIel+hSDsYWTHMaxBE2cjl0ehCUlHOzEUJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RuLlA5tCx+gMglcNceYmcBGl1igUJfQvJPd9gc4Y00=;
 b=mq2sKnhAalCFCd+YlGSCmIM9zLZKfYp+phzcDy6dEFH3niKtuQ4yn0MH/93vWfL4JFaS561GIUMJV2kJnHzK/ogJMWWophI8bccVUKmmIgoDZ2Ts3XMaldwXuzMSSArJF96MjXFJRi7hSiQjpzcxJ+q+vUm4ndCEUzxwKnakgJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Thu, 24 Apr 2025 16:37:06 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 16:37:06 +0000
Message-ID: <37b14a9f-8520-46f9-98a9-8e3fa8e15e8d@amd.com>
Date: Thu, 24 Apr 2025 11:37:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/16] CXL/PCI: Disable CXL protocol errors during CXL
 Port cleanup
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-17-terry.bowman@amd.com>
 <20250404180427.00007602@huawei.com>
 <97a53556-4e01-40ed-80da-0369f401ceda@amd.com>
 <20250417111309.00000672@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250417111309.00000672@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 126a239a-0200-4d84-91ad-08dd834e3fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW85UUYzK2N0L1hYaDA1RmZCNzlkKzF6ZGw5dm5tOEZxd1JiNXNvbGZVVjYr?=
 =?utf-8?B?RU9wTkFmdXBhSGRmcmdEVDAvd3VSbkJHY2VWVXp0MUdBcDg3TWNDKzBnelVj?=
 =?utf-8?B?UjNzVDh4Y05JQXJIYk56U3o4ZnV4M1VCN1BaWFQ5bDFZSXlZWkdwUUQyMklq?=
 =?utf-8?B?V25KZTNtR2hpRTYrM28xQkJnMWx4SG5aNHZwRW9YMjZiWDR5eklGN1JtNkd4?=
 =?utf-8?B?cjB1d0VhbVJiVlFpMnYwdzdzSnozVFZxTmh6WEhNVnN6TU9FTXRvZWNSNi9k?=
 =?utf-8?B?OSs4TWFKRkJFLzc1Q0FjRG9KcTVJR2padUZUKzNGbjExQVlyOHFvTTBpZjB6?=
 =?utf-8?B?YTJOUGpNQ1F6Z2lDRmtjaHZVUmtoT1NRWXh5SHI5bUptYVFURDBEdG5NRkE3?=
 =?utf-8?B?bTF2TG9WY0dKQUhydFlkNjZGMDhTeXVaaVJrQXVlSTg5Sm5jbGZMWUV0K0xK?=
 =?utf-8?B?UWp3L3BzOEdBekpBNnZsU2NMTk16Z0ZkRWsrdlFoUkdQVC9vNG1UQmljSllN?=
 =?utf-8?B?UndycmtGOTdyV244Q1dYZ1BRN2VuOE5PQ3hiSEhZZ1BuNTVpcXNaZ1JCWWRF?=
 =?utf-8?B?L3F4V3dsOEl3L0JwMlhxd3pvVWVQRFU3VndlNGplMjcvWWxkQUdrWXJ4YjhF?=
 =?utf-8?B?YTNXL1VrNlFaV0tYekQyVDdoa3NNZW5RKzQwYUFCcHdJWlFKWTMxaHVZbjNP?=
 =?utf-8?B?OXFSL2JSQWh3QUpvditNOVlXbVBQcmNDVThKY3pFU0xTZmZoRTNaNjA4aEo3?=
 =?utf-8?B?cUFjTnltR0prYUNneUxOcHdvTWJobWQ1YTF2RUN5eHUxTjNQb2hQdkdyYng0?=
 =?utf-8?B?RFVIbjVTV200MjBNdnA3U2JPT0Zoa2h2V25pRmhId2cvTFp1MUZpZDUrTTJH?=
 =?utf-8?B?SDczeGQvaWczRlE0SmE2OW92UFNFdll1dWNRWWdpY1FkbnlLV2ttSG5nNkda?=
 =?utf-8?B?WldUY3dHMEphVE9MaVRpL0o0WkJQNE9FYlkzM2Z5TmsvNnhqTld3RHR4UnhF?=
 =?utf-8?B?aTF6alR1WHNueGhmOE5GZTFIRHlEdXluUnBreFNxUlpFUFc2THQxWGNER3Zq?=
 =?utf-8?B?QVBVajNpZmpMVzNORDNCSkxNaWlCdUFRL0szalFTUVFndVd5YTVpSWliMDc4?=
 =?utf-8?B?LzNzNThYRFJweUVaWDBZSU12T0tpb3YrVEpZSXphZlRDREhuT0drd2VLRENp?=
 =?utf-8?B?cElEYWUySm85QitUbGlzM2xTNDRmYTJxK0pWUHZLR1p0SXh4MC9BcEdpU1o4?=
 =?utf-8?B?QlpDOEZWdkJaRzdoK3JVRlV3eUpyZGFqSlVySm1wVko4U1ZQK0ZvMzhhZXAv?=
 =?utf-8?B?MmVoTFQrSFhMeXU2Mm4xQk9GeEJpMUJsRlZBZm1aZE40NVZORGc4QzRIcVcr?=
 =?utf-8?B?eU4vczkzRFhaUzRNWjBFWFYwcy9qaWgxak9EaHdkK2Rnd3E1Q0x2WEdYWWJL?=
 =?utf-8?B?MHZIUTM3TFFHeGpXazFOeVZuUHJ1SEtGdUVBellNTzlGWllYcW1YYlBISVZp?=
 =?utf-8?B?N3phakRBSVFRMHpxZCsvVWpkeWNLOEIvYlUyV1NPZjVtcjk0VzdQNmkyb25C?=
 =?utf-8?B?Ull4K2dpYVlsYXdCU096Q0tjZCtZMmRkZHNEenF4QXF4UXRlWVYxSmd0dVFE?=
 =?utf-8?B?UDlDNThheTNNbytIUHZYYWJxNWhKK3J6ZWpsdC9zT3p0dzVHUDZtWEZGTEJW?=
 =?utf-8?B?VTlLSjVwdmdwSUs0Mkg4MmNLckQ5eUxNNDBhbTJJNkpVNE5rNGx1Qm1xaGlB?=
 =?utf-8?B?UE1FY3BaRU8wT291SGhJdGp6dUpPcFVuVm9ndEFTV0hadDBSNUFqeUhKTWIz?=
 =?utf-8?B?Y3BtOXY3U3dOS1NwWTlnK3JPUFZ3bGhFV0xhYXRIN1h4czRJS0lXWUNmZnI0?=
 =?utf-8?B?QVh2ZVowZ2kwN0JqaWk5SXM1SC8xREJpMzdPL3FYNVdLZ0IyUjdzQXlXM2Jk?=
 =?utf-8?Q?kHpEewiseN0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emdybHJsSTY3VU5zei8vajVQQytUUWYzcWV0dnlrcXFjNWdSVG9uQ0o2cmRm?=
 =?utf-8?B?cWpYNGtwbVFMZHR2dk43aE0wb0plVDFlWE9KNHIram5Qa3pGbjdLdnRaZU8z?=
 =?utf-8?B?Uk12RXliWW9zQnBKQkhpWHIxSXRoMkYxbjk0WkZFNjFGTHdRYWFoVjl5UHcy?=
 =?utf-8?B?TXRqM2JEa1F4ZXhkZis5Ulp5cWRrRmg3TUEwdjdNUkJ3c29kcG12V29OQkZX?=
 =?utf-8?B?TFdJOTZOL1dzcko1MFBTejZRRVVMeGxMVFQwenZSbnJvM3liVk83aEUwSlRl?=
 =?utf-8?B?Y1NNa21Cd0RGTExjckd5SUE0bUVsWEVONmJ0cC90NjVFTWFRSGVMaTMvU0ZX?=
 =?utf-8?B?OWtydmVtdmloaWtYcDA1RE5WUDQyY0RUR1FRaDBrTnJlYkV4akFPVGF6dy93?=
 =?utf-8?B?bmoyK2srZmRGTEJLTTV1a0RBUjVSdWVBSVI4UVNMcGN6SjdnMWttUnlWc3JY?=
 =?utf-8?B?dmZSeWlrcU5MQWJHQjZwZFBtbWZxVnBwTFZuME92TGgxTW5GTmg3K25VOG9D?=
 =?utf-8?B?bnJuZ2J5Q1VqWlI1dHVsQnI3N2g4Nmp4N3E0aGhBVm5Dei9FeSt2ejlXU01E?=
 =?utf-8?B?Uzg2aERlak9Lb2ZLajZ0c2paa2ZsUmNLUUNsTHBPTkFmck5QZ1I4a2phWkxs?=
 =?utf-8?B?bGdTdElIVnJKRDZJblJCT0pydWFhK1NGelVJS09LWUZyd1RWWWtqWERmLzFK?=
 =?utf-8?B?VEltVk93b1lLdHorVVdOTHBEOWU1NGE1bXdTZWoralVJc045L0drWXZzb0xx?=
 =?utf-8?B?ZDRuazhuMXIvV203M3FSV0x0UFpOb3o1QXMzOEU5ZW9kUVozcVdpUlA1UHQy?=
 =?utf-8?B?bjhvRnhrSWtOd2t3b3pYWFdiQWJOcWlPYVBkN29zaW5qVHlCUGx1NzhFcWJw?=
 =?utf-8?B?dERDejVQUkJsK1N4WDhOZWhVbkppMTVaR05Kc2dFVU9URjEzZHlvQXE2OHBQ?=
 =?utf-8?B?azNHRlhZT2d4dE03TlJJcHk0eVV3M1QrVTBuR0RxcnhLUGhrV0F2LzhyaGlM?=
 =?utf-8?B?dURNenlxK3ZxZWFNWnNYTThUODVUS2tER0Y3dTB4OUVydVdOS1Rtd2REbDZs?=
 =?utf-8?B?NndKaC9IZ0c4VVpwcWJ5MzgrNzFhSzBFTjFhcU0xUWZUMDYzVkVLcmRjalpQ?=
 =?utf-8?B?ek1HZzdBZTZlVHZwNUx0L3FCOFRMZStValhNcy9GS1NHWjlFNDRtSEExdWxH?=
 =?utf-8?B?cmFyMHR2MDJyNkw1NTY3SVlTSEZOdVd2NjZpZS9tNzJEcy80b2hZVVk3MTRW?=
 =?utf-8?B?N2dYdzBMU08rczB6NUU1UEw1S25jVktuQ0p0cVFsWk12YnVBcld1K0trZ3Ir?=
 =?utf-8?B?WU85RXJ2NFkrSURqZkhHWFJzdytMelVURGsyZnhFSmJQWXNoaEhHdHRYMG50?=
 =?utf-8?B?OURIdUs4TlR6RW1aM01JZHc5RVdqYk9xRWpjMlJnWm5ubDJuVk5OR2pnem8w?=
 =?utf-8?B?MHRSeEZVbGVvdkRrSXNFVjhSZHlYOXZMWGxyblpkVWd1N3krYTRidllxbHlY?=
 =?utf-8?B?d2kwUmVFSUtXTS90NE84V2dCeDRQNUcxVFJ4c0sydzAvdnAvSlFHRGhTU3dN?=
 =?utf-8?B?Umh1azRFTVJKZjlrME5XamdYVjErRDhQR2psU1VpT082aTFSSkhXVURES3Nh?=
 =?utf-8?B?akUwRzAzbm44WTRHbUxXSXFJRlFkbXpWandHbFVvSXpUTlVWajA3NDgvaEtK?=
 =?utf-8?B?UHA4OHNRTnh0RkgvTHo2SGhBWk5paG1hZ0NKbGY3ZWJUcmtualhvcXBINCsw?=
 =?utf-8?B?VERhbC9rbFA5dlg2aWtlcjBLZjYxbWlCWjlodGxGTjVKQW1uendBQkZCME5y?=
 =?utf-8?B?K1A5UjJQTFA0UWp3S1FoSTBKdUJpQmczcjVLTzJCMG5PemdQbHhtdWp3ZTIv?=
 =?utf-8?B?LzdoYURWYzNwU0F2b01rb0E1aHh1WXZPdmlCSU1BTTdwTlQ0UElXM1MrRDN5?=
 =?utf-8?B?Qk00VERvTGdicGpIeCtVVnV4K3RPU0hsOFVwQ1Nzd3pYQ0tQZVl4Uit0Q0tK?=
 =?utf-8?B?UmgyMllDeW5JSk9udTcva2g0NlJ1NU9Nd1FFZFR6aEtwUmVmNW54NlJnNUdl?=
 =?utf-8?B?Vlc2VjRkOGpNUE1oa0IrazFtZS8wUk1WNE40bXYzOWlINENMVDcwNm1wZzZR?=
 =?utf-8?Q?Ae1od1WllTusgpj1ZceV8Oz5P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126a239a-0200-4d84-91ad-08dd834e3fa8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 16:37:05.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yN0ietswETirW8y4z3BcR4vWqtfbZuU0RGCrYhSeobrx339u+GmpLyE8L4SrLdLAnRpT0vFmApyShRd2Lo0mrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233



On 4/17/2025 5:13 AM, Jonathan Cameron wrote:
> Hi Terry,
>
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index d3068f5cc767..d1ef0c676ff8 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -977,6 +977,31 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>>>>  
>>>> +/**
>>>> + * pci_aer_mask_internal_errors - mask internal errors
>>>> + * @dev: pointer to the pcie_dev data structure
>>>> + *
>>>> + * Masks internal errors in the Uncorrectable and Correctable Error
>>>> + * Mask registers.
>>>> + *
>>>> + * Note: AER must be enabled and supported by the device which must be
>>>> + * checked in advance, e.g. with pcie_aer_is_native().
>>>> + */
>>>> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
>>>> +{
>>>> +	int aer = dev->aer_cap;
>>>> +	u32 mask;
>>>> +
>>>> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
>>>> +	mask |= PCI_ERR_UNC_INTN;
>>>> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
>>>> +  
>>> It does an extra clear we don't need, but....
>>> 	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
>>> 				       0, PCI_ERR_UNC_INTN);
>>>
>>> 	is at very least shorter than the above 3 lines.  
>> Doing so will overwrite the existing mask. CXL normally only uses AER UIE/CIE but if the device
>> happens to lose alternate training and no longer identifies as a CXL device than this mask
>> value would be critical for reporting PCI AER errors and would need UCE/CE enabled (other
>> than UIE/CIE).
> I'm not seeing that.  Implementation of pci_clear_and_set_config_dword() is:
> void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
> 				    u32 clear, u32 set)
> {
> 	u32 val;
>
> 	pci_read_config_dword(dev, pos, &val);
> 	val &= ~clear;
> 	val |= set;
> 	pci_write_config_dword(dev, pos, val);
> }
>
> With clear parameter as zero it will do the same the open coded
> version you have above as the ~clear will be all 1s and hence
> &= ~clear has no affect.
>
> Arguably we could add pci_clear_config_dword() and pci_set_config_dword()
> that both take one fewer parameter but I guess that is not worth
> the bother.
>
> Jonathan
>
Got it. I'll change to use pci_clear_and_set_config_dword().

-Terry
>


