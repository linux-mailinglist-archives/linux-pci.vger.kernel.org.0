Return-Path: <linux-pci+bounces-40807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF08C4ABE9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 02:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718191884EA7
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 01:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863EC189B84;
	Tue, 11 Nov 2025 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YxluLoBE"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0933446B7;
	Tue, 11 Nov 2025 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824147; cv=fail; b=cFJvl9YgVAntmWlarRj6+qkqC6jZgcuDxYe4yMMKRPPHyIDgXZEhwS313UfL15rb/po1SBPmMn9/OdUXPRU7OboxawLFX0Mh2cViKC5Kkl9a2vJDPcWsJn+V2I+nYC1M2FYOgdM5ZV/WRQpCkWDfSH6FusdmK0nAvcm1fOyXEeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824147; c=relaxed/simple;
	bh=vgBmE8GKd2o8mWwJrk6O9pnc5xS7gUor05jMzNfQNHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bsQZw4uLuWqC7YMJf1MTjnmglHE2XxpTwahJ9HfKGO5h2LlwmuTVNJA0jW7ZQbY6cLi7vaDeU6r5pH1up+1bgA1eZhtDFWADvPVnYXdd9Ar03Pgm13h0F1HOej/ixTBGiXKJYu4IYJGoPrbQqvPmgUw/MkMuq3vFpv7aTpniHbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YxluLoBE; arc=fail smtp.client-ip=40.93.195.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdCHw9jxWcZSViFzM7sehki2WLtMqoOjki+SRtZdrhLn+Cyl7kTM9VTbvVxqmrAGCpLVIDG28A97DLdg9SohSl69V4NOHX7WhjXAhyExdzlPhKmTURreibr1VQyQf95Fi5g2O4QVcwOVZFbCpWjqdMrwrUa3vz9t+FxoE3BA8Ma7/t9X5ARltsSwMY03b1z/7XOzBC1siu+uku57y14CgbSA6ppNcaGqefhTATwmtt7fND7/UvEUawZH95RMcGH/TItXQlc4b+Gt6yPnBlPpcEO7ZKf9vXj6HN4rXrLVa7k2ildEWNCSrXcIyzXo/6gV/QDaAZeOKx96vrLJRFqy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duLeZCxOHMv5b9z5/m1C4wLTsgXl1hVjVPgUnU5O0uo=;
 b=WRy2jg0Wj6pogEqKOiwlMV7di1IINl+f62zAY5Jbss5VPX6/i0IIvoBTXdjdaCEETHL+HtcbSbcO6coJJdlXDyega/PTBXZl+i/nk9CjFQePz/u1UV/qOdhUvPCaohoCEWyroCv1ml1RM5mGfi5fFxuin6IZz9DwPtt3b5z50uJpBzTRt1MdYySzVCZnETYCnF00n1AP823NqY5qHZaRTGkkZswYWTwm5JJmTg9PEIVuhhhJuKfiGWz8kDvzXkh8DsMvv4PE1Tf0t8T8TXGx1cU/4KaD+5nZ2vZesc9qRcwbbIFf7uzqU+lMz+6uUTHBBYbDXsUXXf9WbpZvhRdkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duLeZCxOHMv5b9z5/m1C4wLTsgXl1hVjVPgUnU5O0uo=;
 b=YxluLoBEyT890AL5v8d2A+tFTR3nYkndgYbrE2nxlKijQFFYzXBF4tWT3Fioya3XRscHYsl/FQvqIhl6u+1rHkH/hrR2PJkkvPo6ETrPx+reSVCcmsjm31NBNXSYI8bIiLJKls5UZLCo/o4nBs3za6Hjl1Ue25YeCZVPS+mUrfoxhk4Y31oE9CWWQiACVfEk2kkQ+QHi79xijBDmnmOCDvtn9kkTaawK0ThrupeleK4YyDD/Jj6knzlX4zXsKUYkr2A24zJ7GmGW7f0utn094dIxSueorYLV19/26yrUHI0kJkUtnhg6904o6ghJmxLP3bQxbVJf8WK10dO/nLaINw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:22:22 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:22:22 +0000
Message-ID: <439c62a4-ddac-425c-b505-ed9a33aae289@nvidia.com>
Date: Tue, 11 Nov 2025 12:22:15 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kaslr: P2PDMA is one of a class of ZONE_DEVICE-KASLR
 collisions
To: Mike Rapoport <rppt@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Cc: dave.hansen@linux.intel.com, peterz@infradead.org, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Andy Lutomirski <luto@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Yasunori Gotou (Fujitsu)"
 <y-goto@fujitsu.com>
References: <20251108023215.2984031-1-dan.j.williams@intel.com>
 <aRA5-wgo6bm_TA74@kernel.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <aRA5-wgo6bm_TA74@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 89eb87f8-8909-4c5c-6548-08de20c0c375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1ZGRXl0VXIyZ0sxL2V6dlRmdkFHRHJmTVJzVGRDeVd6ZXVEUE81b3dPSXlX?=
 =?utf-8?B?L2hPZkVNSTNZRjNqa3QxWllqV2lKcWxtcHVBa29ldU02L3RGMDNVUE5YUWwv?=
 =?utf-8?B?Njk4MlF0MkgwT3lJL1dwQ1pCNjMyUHUwS2duQTNNd1hkRitSVFN3dHltVytV?=
 =?utf-8?B?TWhvaDZ4NEhKMVZMeXZieGRRbGt3V3ZLQTBjTThSMVEwV1NEUlJMcHV1RFk5?=
 =?utf-8?B?R2VmM0pZV2k4bHVaaE1KcHp5WXYvMFVCOXBid0l3d2loaWpFYmxZWFh1UDZ5?=
 =?utf-8?B?eWlwNFplYkxkWHhuY3FZY3d3NjhVSGNIQlMzSldmT2dUcC9oWmN3K285ZUlL?=
 =?utf-8?B?bUpDNDA4Tk1yc0J5bDNlYTlZVE9QSXE3QU4rOTIzOFAvYTVNWUY4dnB3Q0Jl?=
 =?utf-8?B?dWpZWW1YdGJaemYwaXM1VVNmMVpZL3JCWkE3ZDd5ZlUzczQxdDJqcjlzS085?=
 =?utf-8?B?UW9wL0RsOWowU0lyUE13OGtEckpaWU42VzRTS09YaGpJV3BqdGVsTUlxMGdC?=
 =?utf-8?B?andlb2M2UmlLSEVkdC9DWFl2WlIzNEhSeDFVY2pMQTlyMFB0NXk1UmxSNW9J?=
 =?utf-8?B?c3pDL0s3dW9zMGJWZUx3dFFVY3ZwdFpPR2Jub0Nzbk5hYUhNMlhQeGVTd3Fl?=
 =?utf-8?B?V3BhWEl2S1VROHM1dE80bDJVRXRCbDlNdnlveThQYk9GNFBJb2NYUUQyMlhG?=
 =?utf-8?B?V2ZhN3B2dThLak5BY1V3OVpJNDZlbGVNeldqUWw0QkI3NjJrTDQyRVJPT2gx?=
 =?utf-8?B?YlJSam55aTRYZmxNZ2ZTeGhiaWxocWlRRzZjdTZIaW5zUThwbzhTWkFjaWNG?=
 =?utf-8?B?WS95eHk4WWVwUzVHZFFsamkyZ2JXTFdSYUJnRG9wNmdJYVpob2NzRU5wNmNq?=
 =?utf-8?B?RlNRMVJZdWQrSTVCa1JCdERjdGR6KzFKeGV0bDZOZXJuSFFJUDZ0b0h3OFAz?=
 =?utf-8?B?VU5Fb3NMUFJOOXl5cUNkOWRqMzB6U2FrT1VtQVV3b2J0MDZJKzBTZVJKM29I?=
 =?utf-8?B?TFMzenBlbWFSMnRyNnNkWStVelo0Yyt3eENldHFVSjFGWVQ5SE9NUGdpV0hm?=
 =?utf-8?B?RHR5bWhSbEtzRjNaK21KVU01UXUwdW5hR3ZHdlVuV3gwRnc1QWpQV25hcGV6?=
 =?utf-8?B?dWZtYTBTK0R5ZlVYc3R3dWhGWUVhbWE0ajFTdXQ2eXB5dGdxVUswKzV5WmNX?=
 =?utf-8?B?TnlCL3Bpa0p6TW5GY2lrOVJRajlqcy9tVXZNU0VrNWd1bmJZK0JvaE1VUURs?=
 =?utf-8?B?MzlaTHlKTVJoRkNXc3ZWWk9HVHNDRHAvQXNtRGd4SlNJdGNCeS9mMUE4OGJa?=
 =?utf-8?B?eWtQUkFDOEhoM01ITVl1VzNreDR1NGw1R3VCRmZGb0Q5Tkx3c3JaZVZOSnVl?=
 =?utf-8?B?ZDdKMXgyRWdNdTlPWXRQL2FLSG9iWFFlWklmNkJaK1dsZE02WEhzT0thd2k2?=
 =?utf-8?B?U3pVemxKNDk4VzdsK0xpRExtVlh6M3J6MkVQMFExNU9VNG9ldTJZUUxPYzA4?=
 =?utf-8?B?YlZZOEJTV2J2dUNLdGNQMit3RFFFYlpyc0dsNG5la3N3eEg2RE5aazcwR2l5?=
 =?utf-8?B?Z1VGK1dTV0p0SXVMeEdRNlk3aDlzUlh3aVhubjNKNjZERVVlQXpFUGJPdnNy?=
 =?utf-8?B?VktiRkluaXBVWDlkUTJWdGQ3NVRXTnR0NlBud2daLzVQQTBJV0FQYW41VHVo?=
 =?utf-8?B?Q1hJajZUcVJCT1hCMVN5MERwUjFuVnVqNXdTcjRYSUkraStmbVNYTjJlZ1ll?=
 =?utf-8?B?S3I2MWJJSDZQYzRiOHRFZ2tlKzNiYnBrc21SMHpjYWZURWVWZFJMYkxjdnlX?=
 =?utf-8?B?Mi9CWTRISnlyK2FiRXlsYlBzR1QycGxucTJHTTV0cVNCK3k0RlZzSFFXL0ZW?=
 =?utf-8?B?aEpNdWVCWFJtRTUzckVmOGx6alNIbHVxNjZOMk9IblVVTkliS0xCSUk1ZDFL?=
 =?utf-8?Q?5GoohHFUDBq7AL6cwmNQhUgh+O8ofsOo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3liNklQTS9OVmhsTDhIUVVuS245VktFcjE3QTZqcWhIOTl6TmM5WUZyNjJu?=
 =?utf-8?B?RFUxZU5LdGRKZzh6SGEveWlZU09xNFFaZ3dGK3ppMnVTMlBmR1R2VyswTnBq?=
 =?utf-8?B?eklRWUR6YUZZK2VOaTVEdDcxd1FSUnNhdEpoNXdDY28xc0V3SUlwdms2aWdY?=
 =?utf-8?B?ajUvaGliOXdzWEh2Uk1zd1EyZStiRnQ5UFh2SEw4S3hBajI5MWViUmlNK21i?=
 =?utf-8?B?eWJkRW94SDRNT1Z0SWl5UG95UXhyMDdCSkFLZGJXR2t2UXJWVkxhTG9mTjR4?=
 =?utf-8?B?dWZjald5MUFuUlFmbXdrQmpzUENweXdEUi9nNVViT0xBTVJ3TytzUEhUNi9y?=
 =?utf-8?B?TVA1S3E5cGdRT2Vtb214WnhaRlQ5akp1SXZkSUc3YnZIQWVCLys0cFdnQlVa?=
 =?utf-8?B?NitpckVDeE8wcGdwTGdmbDlBakRzczg4V1daVDJBVXBLanExUVZJSElZamF6?=
 =?utf-8?B?R0RRVjRKSndOYzN1LzVBT1pQeCswNDBkRjAzeUNEZDZzVWRiQVhvek5uTWtm?=
 =?utf-8?B?bUFIUjRwMXB0NFpoTnBZTWp4NUNua3Fnak1JS05KUGRqU3ZHeHBOZWp5Q0I1?=
 =?utf-8?B?d0VxVHlRN0FRVHExQ1pEZXZTd2QzRmpOT3kvbEgwVlNKMmMrb0lVQXlBWnpV?=
 =?utf-8?B?MERjcHFvWFZoVHAra29Na1N4VE1HTzJRd2xpVVBueXJlSXpWQWF0M3NrcmIr?=
 =?utf-8?B?cnNWaTZoRG1ZMEM1QXZZVkR2SWFBbVFPdmNwZFpUZm81Z0VLbmFPOCtUd1Fh?=
 =?utf-8?B?ODdCV0NkcWZ6Ryt0M0wzQUxvNjB1dmd5aVVaRVloaS9MVGJSN0E2UzdVQjhK?=
 =?utf-8?B?YS9qaUN1WlRIenR6KzlFZHlhVzhEaTdQU0FGWFVYMzZhYmhXdlcxZXNSSjBE?=
 =?utf-8?B?M2dWVW93Tm02MjB3UlZZZHBTNmJ5d3ZzZE94SWRKcklINGRnZ3U2dWxvV3JN?=
 =?utf-8?B?TDFIS2R2aXVob2ZqeVQ1dDgxM3ZRRWdQZG5haGhFQmEzNHlmc3RsbVVWT1Nm?=
 =?utf-8?B?K2JUSFZwMVlHU2RiN1FBZ3JOWlNXb0tjck5VNlhuanlLSld4cU9KTVlEQWQx?=
 =?utf-8?B?VHpzYm0vVStWV0hVdjgzNzFDV3JjN2V4U0NxMnFCRllkbDNsRU13KzR1UktU?=
 =?utf-8?B?ei9FZ0RtRmh6cGNpN0NyTkxYM3NUNnFTOEhPTE84cklmZ2xxQmMrSUZ6UmU2?=
 =?utf-8?B?WHFYSmd0WVh1VkM4cm9tZXBmMzZwRExLNTlCeWQySGc0VzJFTm5yUVUxenQ0?=
 =?utf-8?B?cSswNXBjY3F5WjBIbmhlL2k1ajF0eDk4RmlDUkpkeVZ0andIejcvTnhQSG1k?=
 =?utf-8?B?aEZBakVvOUVCbHkzaTV0R2diekVOYndxOVByUHpQd3Y2bmZDVFJEZnRuYXlv?=
 =?utf-8?B?L0FRRzNJQXJreFNndUFzeVd0c1Y1MDUyT1NOVlBmSVU2SytjQUE0NGpSbmoy?=
 =?utf-8?B?ZG1MT2FZbG03VUFnT1NvaWN6UlBvTWQ1VGdGeFFwM2VNRWFwNDVlcFhXRkxz?=
 =?utf-8?B?dG5qdXFtMlNTTjBGdnA4M0IzQlpPbkV4L0FtNXVPQyt2TDZycHkwb2JtWEJq?=
 =?utf-8?B?a2J2UnhxUlBrbzNScThGSXphZmJ0dFRYTzlwTitCOXMyOWVZTTlJQkdKaXJS?=
 =?utf-8?B?OEFNd1pEbnhoTUR6eG1IWjd1VVoxWVowdmZkZEJ2VXZrSWJCdnhXNlFuSVlv?=
 =?utf-8?B?L2lIODdBdTlUYlRLc09sU0dKYUNvVzNyMzFZNTdURDI4L0dTNml1dllUc0Yv?=
 =?utf-8?B?TEpVMXVoaWFlOXlCVkJZc053dkxYdDV3M1BNL0FJU0pEWWMzcS9SL0pZWGxD?=
 =?utf-8?B?akNQU1RRQXlNTUJMWnFVbkVTcHlISEJETlNCU3Nvd1M5WmZ0US9JMTdtYkJQ?=
 =?utf-8?B?NUJVVVhVNVk2OU1iZHpQdi92ZGpNSWEvSk9XejhWbzNwZXdmd09JWkpwemZU?=
 =?utf-8?B?Ym1nMFlJbkdDNlh4T3ZrVjVNYlNPZnB6T3ZmbHdhby8xTXJZYTNjU0RCV0tD?=
 =?utf-8?B?QjAzeEhCU0dFdnNTWEdBWFdsbXhWVTFsZHA1WkI0Y29SUkpaK1MyNUoyRGk2?=
 =?utf-8?B?OUFYQmhFWGlzbUQvMlUrc3BzUGRqaGpEYzg0dkxUYVVYZmxRc01Ddm5BRVdu?=
 =?utf-8?B?bUx3OVVVRzRyRXZZSW1xMEVnSDMxL2hUb3NBTWFWWU1uMldrTmFMM1lUZ01Q?=
 =?utf-8?Q?e2CNrtJz4F3u3FMukpVYm2XkfxFarQ/3afFu6HLzRSAQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89eb87f8-8909-4c5c-6548-08de20c0c375
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 01:22:22.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXHZlLt09GmfV7MLMR9LaYfBiQJbxcOR8MGBXtvpA5J0MbgtoEVSrFMeTmgRYHhP1guO0KwEGEbhyRW6MBHndA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357

On 11/9/25 17:51, Mike Rapoport wrote:
> On Fri, Nov 07, 2025 at 06:32:15PM -0800, Dan Williams wrote:
>> Commit 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
>> is too narrow. ZONE_DEVICE, in general, lets any physical address be added
>> to the direct-map. I.e. not only ACPI hotplug ranges, CXL Memory Windows,
>> or EFI Specific Purpose Memory, but also any PCI MMIO range for the
>> CONFIG_DEVICE_PRIVATE and CONFIG_PCI_P2PDMA cases.
>>
>> A potential path to recover entropy would be to walk ACPI and determine the
>> limits for hotplug and PCI MMIO before kernel_randomize_memory(). On
>> smaller systems that could yield some KASLR address bits. This needs
>> additional investigation to determine if some limited ACPI table scanning
>> can happen this early without an open coded solution like
>> arch/x86/boot/compressed/acpi.c needs to deploy.
>>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Kees Cook <kees@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
>> Fixes: 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  drivers/pci/Kconfig |  6 ------
>>  mm/Kconfig          | 12 ++++++++----
>>  arch/x86/mm/kaslr.c | 10 +++++-----
>>  3 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index f94f5d384362..47e466946bed 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -207,12 +207,6 @@ config PCI_P2PDMA
>>  	  P2P DMA transactions must be between devices behind the same root
>>  	  port.
>>  
>> -	  Enabling this option will reduce the entropy of x86 KASLR memory
>> -	  regions. For example - on a 46 bit system, the entropy goes down
>> -	  from 16 bits to 15 bits. The actual reduction in entropy depends
>> -	  on the physical address bits, on processor features, kernel config
>> -	  (5 level page table) and physical memory present on the system.
>> -
>>  	  If unsure, say N.
>>  
>>  config PCI_LABEL
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 0e26f4fc8717..d17ebcc1a029 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1128,10 +1128,14 @@ config ZONE_DEVICE
>>  	  Device memory hotplug support allows for establishing pmem,
>>  	  or other device driver discovered memory regions, in the
>>  	  memmap. This allows pfn_to_page() lookups of otherwise
>> -	  "device-physical" addresses which is needed for using a DAX
>> -	  mapping in an O_DIRECT operation, among other things.
>> -
>> -	  If FS_DAX is enabled, then say Y.
>> +	  "device-physical" addresses which is needed for DAX, PCI_P2PDMA, and
>> +	  DEVICE_PRIVATE features among others.
>> +
>> +	  Enabling this option will reduce the entropy of x86 KASLR memory
>> +	  regions. For example - on a 46 bit system, the entropy goes down
>> +	  from 16 bits to 15 bits. The actual reduction in entropy depends
>> +	  on the physical address bits, on processor features, kernel config
>> +	  (5 level page table) and physical memory present on the system.
>>  
>>  #
>>  # Helpers to mirror range of the CPU page tables of a process into device page
>> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
>> index 3c306de52fd4..834641c6049a 100644
>> --- a/arch/x86/mm/kaslr.c
>> +++ b/arch/x86/mm/kaslr.c
>> @@ -115,12 +115,12 @@ void __init kernel_randomize_memory(void)
>>  
>>  	/*
>>  	 * Adapt physical memory region size based on available memory,
>> -	 * except when CONFIG_PCI_P2PDMA is enabled. P2PDMA exposes the
>> -	 * device BAR space assuming the direct map space is large enough
>> -	 * for creating a ZONE_DEVICE mapping in the direct map corresponding
>> -	 * to the physical BAR address.
>> +	 * except when CONFIG_ZONE_DEVICE is enabled. ZONE_DEVICE wants to map
>> +	 * any physical address into the direct-map. KASLR wants to reliably
>> +	 * steal some physical address bits. Those design choices are in direct
>> +	 * conflict.
>>  	 */
>> -	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) && (memory_tb < kaslr_regions[0].size_tb))
>> +	if (!IS_ENABLED(CONFIG_ZONE_DEVICE) && (memory_tb < kaslr_regions[0].size_tb))
>>  		kaslr_regions[0].size_tb = memory_tb;
> 
> A stupid question, why we adjust virtual kaslr to actual physical memory
> size at all rather than always use maximal addressable size?

The original changelog that introduced the changes has a detailed explanation, IIRC.

Balbir

