Return-Path: <linux-pci+bounces-44965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22314D255E4
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D64E230E8422
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6808B3A7E17;
	Thu, 15 Jan 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EKQ7K976"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057235FF64;
	Thu, 15 Jan 2026 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490800; cv=fail; b=DlHhAOrHN2Re28XZNC3Qr+nzmX0kMYp9OuejJ3NNn9cfHbYIEJ75DJH4DdncCagWWuJ3/dHmEqT7dssGcq8/8sTqhOPmdPg5FP6d5NCrTlLPrPFQo+K/+4UB+OjEx+Ut0/iLDiv+rYDrxTsRO5k0DqAksnt7A0Ux8TPiuAy6BVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490800; c=relaxed/simple;
	bh=rCyQ8NKeoJ80L84eV8aiNP9cU/UA06GxXprFO1v1whE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h/os54qq1knqW0CKqGsnZ0iGUXEqALABo7mIyMucARMR063QIeG+CzlqU7vEpgfZikG5ncGm3a1Z8dRV+KNUs3S+0hCNC9AP1BJAKh+0odDB3e3SiqPBdkjg/bRPcILiRkDlm5MYU62k9ENFwLBmvpPrYB6jKjH9dgQVrOkHv04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EKQ7K976; arc=fail smtp.client-ip=52.101.43.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSpehGm3Pxc3Hus2/KvjUBHBoiKc9/szJ69sLNTzaoeEB6u4oRpijfkob7cQss5xT8ID3t5rTAZVkbjEtvl7inhbWjHg/F9rT5MpT9+GYm78Bw2EN534E4U4SIlMTWmcxyYE+TpfNf87k/GE9CeVji+kXCzKJiosvuzAu1jlm72xinBYKG2ITbbUSbCNtBFRha83bHFZIvO8YsPDiYVitkKw3PLNvfpeTOB9nKuhgB2zy+XUPg3+RgAGPjiJeVMe4I2iJNc36kiys3+OZ7OVcns3yFMAs8GO2JUfnm0nvc7DF1mZpV4/531m2pNzrDBQ4Ss5MCWD1hT5Tuh9SZBJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abuPG13xYBMSgMLudVvGe4xbRdnvJujg+t0ECA3jtEw=;
 b=QgXZ2A2/fUrzc/eAi8SgYiFgbfQErg3pFnHNtAbOj+oSRh5z5Zwc1HjYvbA0JGnmcXrBGTKku0j8u/JfoMP4LWEPQOJlmIlba9nPwP03Rb5/hP6o3FAY+ElKdcyUwcvMq23S4/tRHWYUG0uLq1U/PazK4ppYaWFmThJWmu43AFsC5XB3VAlNVxDQ4S61WbmHYWTOcUMIG3VlWhRhfNjxMpZK1OmWrSnNFCL4Isfj76uvKDmPj8nkP4aCMjeoaULZ+Gm2pyDEl7AXai3DyVyV2q7gsWVCED92TauUOMRnasf6rAOdtm79x54TJqc3EBqAiZBNh5utsaGdGK3WI5EUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abuPG13xYBMSgMLudVvGe4xbRdnvJujg+t0ECA3jtEw=;
 b=EKQ7K976iJTgbUw1O8UWhxe9YBlTXfn+1/UcdQbzjM8U2xUib5PXzcw9ECXvlT1a9umDWL1KDlZzR8qkw4l3MJsMsoBXFsMZXUH+MeJ+RSApQ8dToRcUyK5w8r3rvhKTyRWNl73Et3CLMC2dD8WKQ4xgRg0DXR8EPWB74+TC2lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 15:26:36 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 15:26:36 +0000
Message-ID: <439ce199-2640-46b2-941a-087a1d42e01a@amd.com>
Date: Thu, 15 Jan 2026 09:26:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 32/34] cxl: Update Endpoint uncorrectable protocol
 error handling
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-33-terry.bowman@amd.com>
 <696813ae1d175_34d2a1001a@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <696813ae1d175_34d2a1001a@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:806:130::26) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b2721d-0517-4ef0-cf2d-08de544a7866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MldTTWloaVMwb3JnRFVsa3MwcENaT08vMEhXa3Nad2tCMFU4a0U2VHQ3R3Ro?=
 =?utf-8?B?cmNNL1VaZGJLbXJWdDcvNjFMSDBDM0tFamhrU3Z3dk9QeUJFbVQzZkZ2ZStZ?=
 =?utf-8?B?ZnJ0Q3IrbWRaSGY1OTN3RE9mT2NyWjY1UjBob29kSUhkVm5NbjBYM3JBMld5?=
 =?utf-8?B?OXZCS3ZjRW5wbitjampFS29RRDN2M0NEQnJjWXpLTG1xM2ducC9vY21oK1JJ?=
 =?utf-8?B?SCsxNk5tVWN3RUg3TjJEWDZ4enI5dE9XdHljdFlWL2tYdVhiR1FEbUpEQXBY?=
 =?utf-8?B?VWVLT3VkWU5NZU1BdTN0a0QxbHFORm1ldUtFQk9scmQ4eGR4d1p3MisxNm5m?=
 =?utf-8?B?cTNOQURZeGcyYmJuWUh4SXRUNjBvUmYwT3RWT1F2dEQwbmtXcmFYd00xVWNO?=
 =?utf-8?B?L1JTV08vZzNLcXZncENxdm4wV3c3c2lKOTh4bEE4VGpaYklpVFlOOThNSzRi?=
 =?utf-8?B?M2JQSk1CWDROVC9EOGZuUjRDQUNUdzgydnh1TGJ0Rk40dEZXYnR1S1o4SEZ4?=
 =?utf-8?B?dEF6MUJQUnhxZFVSR3c1SjRpazRMRktWN3M2TUJ4NGlJUTFkN3diNFJOU3ZP?=
 =?utf-8?B?SmlxV0ljYlB2SmZIVTVtYTNITWFqSkd4dXpEeFQzUFRNNmNtdTZyai9tVitr?=
 =?utf-8?B?R0hteEszR0NzbGlZZTV1TmZOckNLak5rT0pNQ3dDTUpSdzNlRHpJL0VuMGU1?=
 =?utf-8?B?N1NQVEtLdXdxdEpTVU1kdS8vMk1hUnpHbityYzdtc2I2eGEzcU83dVlqWERp?=
 =?utf-8?B?dTk0L1E0OE5RRGcxNFVQTEtpTjRHb3UzbGpaNnc0ZHNOb3lPcFJ0VndLdmJX?=
 =?utf-8?B?UkZVSU1obEtSOUZHZlRwaWtKem5mb2NCcGJ4U2U1NjZ6V29TSFVvYnVsUmVS?=
 =?utf-8?B?YnR5QVU0b1dMeEdIcXhvU0lnbVF5dzdDUURheU9hN3ZOVmlRZ2tqRzB2SGhB?=
 =?utf-8?B?QmZwM3BtdEpBdThqd0Zra1FGemg3MFArbWZBZ1A1Q3E4SVd3YlJOenFVQXdQ?=
 =?utf-8?B?R01oZmlZbVhFZkRCNTdubFVZYlRUQTNLOXJGUWFNREk3Z2kzUWhCZmYxTmRp?=
 =?utf-8?B?RDZUc3Z4RktWOFlFMlNkSDEyZ1JrZHh2Zk9hTE9oZkYrR3cxMm5rMlYxR3lk?=
 =?utf-8?B?TzdMcmgwQUVFbERqaExWRFhqejBrZGVVbjVITlgvV1JBRnh2OFM2QWNCQnFy?=
 =?utf-8?B?ODJkWDFSbWNIaFJRcVA5N3c4MmVBSmhJV0tkVENTM2M2MTBDSW5ITWhoVklL?=
 =?utf-8?B?ZVpBcUNSQTBsZXhVMGxBR2NwM1gvMWJhKzBmR3hweU5rMFN5SzFwL1lrT0pN?=
 =?utf-8?B?S1l6WFF5TlJzUFh0WW1GLzBnbERjYkpzb20yTmRBVEhTOUZ6RmNXUjNNTWJz?=
 =?utf-8?B?WTlJQTFGbmI1UDBXaEtDZ25lVm0xdkNvU01nUlBnZ0RpZ1NyUFZQY3VMWjVw?=
 =?utf-8?B?UVlGNmt6S0EzMENBTTFsdkN6b01JbG50QUErWHpaVk42NWdsK0dtb0U5dThV?=
 =?utf-8?B?OWczVXRIcGNrRzdCWmx0SmV5UERRak51SGs4UlRKMlRjMnFVeHY2S2JZTHo4?=
 =?utf-8?B?L0NWQmtlMUhoU0pHd09RYVhJK1ZIQ051b0hxWkJJZDdmNHVyNnFudkMvWkhy?=
 =?utf-8?B?UXZQb1JuWVFkUFJhNjVFdS9BWmErbFRmUll0MXVwNkxZZmtNK1ZmYTFqYTl2?=
 =?utf-8?B?SGl6L28xVzV2aUJBYzE0ekdNb1cwR2pTSEFjNzFkK0JEczFRd3hHdVdXQmNB?=
 =?utf-8?B?YWp5Q1BvV1c2RjkrKy8wYXlrTS9yMWh1TFpCcE9KblozNEFrTHpmNUt0eWlM?=
 =?utf-8?B?YXd3TU9iWGJZa3pCd0g5N0I4NzV6eDRUNitHTWxRMHZXUW1FbDNZU25YUXJ1?=
 =?utf-8?B?YmpDNUsvdmJNQmNFRU9aVTg3OXdod0NyL3pkcDlkb3pLTnV1bmJvYWUrRk5p?=
 =?utf-8?B?NjFmRnNObFUzcGdjY0FDZlVKbDNhOFcxclRUQkt2MXBqZWNnbkYwVkE0TzZt?=
 =?utf-8?B?akNNdlNIR3JXcExvc1VuK3dUeHFsK0J2ZzRqQUt5Zms5YXkwejEzSnYxWmRt?=
 =?utf-8?B?cUh2ZC9qazlKeERqcS9pcGRtVkkyUGUrZnhzMlpDaFI1enk1bHV0SDludDE3?=
 =?utf-8?B?NXJaTStwMjIwK1huNU1XVERkRGM1UCtOV2pnbmdyU1JTWmVxVjJPUCtDemtq?=
 =?utf-8?B?MWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0NwalFQUHJGNG1POVhiNnJ2K1dvanZ2ZUNBdFphOGNtdGYrT2ZraUhHS3NM?=
 =?utf-8?B?Q3NrUjdIZEh1WWFrejhSYm9JcTJ0RXlITFVYZ2UvOXRQd1grdWhYOXN1bEVJ?=
 =?utf-8?B?dkFuanl1d3d6cTkzSXVHdVFzVS8rVCtjZXVvditEdVFRZmF5TzBMZUVJY2xy?=
 =?utf-8?B?bzIreUxJRnZvWGFXVzJXOVpSQk96ajZuTTlsbGNlVDN6UTZiWWNydC9JL2Zy?=
 =?utf-8?B?K0hIMFZCcHRhTFJ2ZnMzUmF3N0JMMzE1VlhHakY5YjZ0ZzFnbGJaOTlwTTNJ?=
 =?utf-8?B?bVhKaXpreVdKUENhM2c1dGphU0VMM09hWGd3eWtOOUxhM0ZBQnhlUnVFcFV1?=
 =?utf-8?B?UStDbVUxTGluVWx3UHRRT3pUK29PazF4cmNEdTFLa1h5cTN4MGJQTm5hQlVH?=
 =?utf-8?B?c3dwazBpdjBKWWtQYmZxd1lCSUNhT1dHcWZoV3JkdXBoT3ZwV2syODRWQTBG?=
 =?utf-8?B?NHJsY29tUTB0WGI4ZE1rV3A2NTNNYzg2OGVvWnFWMnZocGVjSXpndnJmMFE5?=
 =?utf-8?B?cUlPTVRzcEJQV2R1dGVWR1IzR2ZqbTFYdWYxbVoyRFF1eWdwMnFKaE1pSW1Q?=
 =?utf-8?B?cUxIZk9VVzVMR1hERWNudVJQNG9PTDA4SllkMnpDQUtHWmhJc1F5VUdORE9O?=
 =?utf-8?B?aFFISGRwNElxa1l4NDB6RWJQSjIvcW1ibDhXbmpZWlJ0RjJ0c2hvaWd0WUdy?=
 =?utf-8?B?VHpEbGNwVHJVZGFOVGU3Q1MzWmU2RERrM3ZMRlpUZWhsMm14RFpYYWxrWEY4?=
 =?utf-8?B?Wjk1d1AyYkloNjRoMkFMVFZndmtnelRnU29wc1F2SkIyQVNUTW9BS3huWXJZ?=
 =?utf-8?B?UVZFcElZait2T2gzNWFUaFp4eExoMHhqNW9NUnVBREhTR08wNXdvU1VUTEhI?=
 =?utf-8?B?OFFad2RMQTNZNzVOWDhFS3NOVlp2dTA4ZFJlaVI5SzhPdW11TkgrVmJrQUZ4?=
 =?utf-8?B?U1IzWkgvR09SS1BKVVZ1aExsd2p2czI5eEhWVkl4akszbEJ1SDZlVzMzRnJp?=
 =?utf-8?B?NjNraWFBcGNPR0NVS24vTXdTWE1SaWlmVVh3SDMzbHJiWmIvSHFQc0xieGRJ?=
 =?utf-8?B?N2dDT1RDRW91Um5vOEtNeDhCaVRINDlLN3lLeGwrZFdxZmlvaUlScFRxZE1x?=
 =?utf-8?B?YXMrVWJqOGN5cm9OanZuKzB5ckVKd3R5MGhWYmpWbWN2alFZQ00zU1BOdTU0?=
 =?utf-8?B?MVN5bUxNZXMrdklvVUNzVktReS9qZTgvY2ZBbk40a09EdlRLNFQ3L280OHZI?=
 =?utf-8?B?TERGNkhqaWRhVUc1QkJwWnhSbk1vQjJrRVpMSTNwVkJ6ekdzNDlVSWFsa0t4?=
 =?utf-8?B?VmxpTk0vY053MWFLcXJqUHd0TFBlbSs1a2U2cnA1QmwwbWRqYjgzVzc0Y0xX?=
 =?utf-8?B?a2t5dk0xRnVvKzJMY2ZDSlBkUzNJNUNQU3BXUHMxZ0VQQmRQTjc0Sk94TVR0?=
 =?utf-8?B?N0JrRlRlTy9lcnFQYXY4RlZlNjh6a1pZcWw4NUoyWXRNN0Z2a1BVMGhKUUxC?=
 =?utf-8?B?eDErR2VZd0ljcW5vZ05hWGo5MVNjL3pieHVhdnFwOEtPSVdPU25WWTBORXBt?=
 =?utf-8?B?SzhxbnZid1RLeFlYRlhzRitzWk1EZVVLOEZJL2Z4b0loTHRyaWFnSElUUXNV?=
 =?utf-8?B?KzZubHZFb0lmZzRxN0ZEejlFQnNrZVdyM0hMa2tUbG9JMDFSNlJ1Lzhrc0Ri?=
 =?utf-8?B?d1hBNFJNeWhUazJnY1hXdTU2d0R2aTg0d2tscERSamNMSnZDYXR2RUFwamp1?=
 =?utf-8?B?dDJ6NmtlaWphb1NmY3BoMk1scUg4Uy9kUE94TnhXZGNYdy9kSjdqcU9JZnBu?=
 =?utf-8?B?M1BGUHRjUHlXV2hMSXlnSUJLcDFDbUdCZXZUMWdpbjdZaTBxV0FSeEZnVG5o?=
 =?utf-8?B?L1VYRjZ4MXlUbzhwKzkxVHZGZTE1Rmh0cDNWOVFhU2dNYkI2alVNZHF0b1Mv?=
 =?utf-8?B?bUVHQVc5dGpXQWN0U3BFbjRtUHl4MjZiL3pqUWpkVFUrWDAralRYU01zN0l2?=
 =?utf-8?B?OGZpWVNqZFpCdTB0OEIwd3VHUjRrRU1oWUR6R3B5bmdoSFg5c0MrbXVkOXJF?=
 =?utf-8?B?ak4ydG9wUXQvVHJ5aWMzNmlDb1dxZjFHZlFQMUtDUW4ycXNZN25VWklWOTQv?=
 =?utf-8?B?Z0VYWEkwWEpvek9YRnNZOEVRNWVtVFU3bElzbGoxUHlzZFh3Y1dpbGR2UkxZ?=
 =?utf-8?B?SDBybFFjc2JkWlJROW5ycHpYQ3J2WUJXNG5BVjExemhFWjJucHBFMnBwTjlx?=
 =?utf-8?B?dHRSRkttM2d3b2xEN1FkVzdMc1pWS29YK3NCSVVVR2paQklhSzR5K1FtU1Vx?=
 =?utf-8?Q?a3bUBobWr9seh/hzaF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b2721d-0517-4ef0-cf2d-08de544a7866
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 15:26:35.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLah3vB6vYuK/yTXn/ogxq/lDBecGv6fG1jNLRDnvu5Q9EXsx5z7ZRwlLN6vg3jCK0zqFuSlErohoTziiunrXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

On 1/14/2026 4:07 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> The CXL drivers must support handling Endpoint CXL and PCI uncorrectable
>> (UCE) protocol errors. Update the drivers to support both.
>>
>> Introduce cxl_pci_error_detected() to handle PCI correctable errors,
>> replacing cxl_error_detected(). Implement this new function to call
>> the existing CXL Port uncorrectable handler, cxl_port_error_detected().
>>
>> Update cxl_port_error_detected() for Endpoint handling. Take the CXL
>> memory device lock, check for a valid driver, and handle restricted
>> CXL device (RCH) if needed. This is the same sequence initially in
>> cxl_error_detected(). But, the UCE handler's logic for the returned
>> result errors is simplified because recovery will not be tried and
>> instead UCE's will result in the CXL driver invoking system panic.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>>
>> Changes in v13->v14:
>> - Update commit headline (Bjorn)
>> - Rename pci_error_detected()/pci_cor_error_detected() ->
>>   cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
>> - Remove now-invalid comment in cxl_error_detected() (Jonathan)
>> - Split into separate patches for UCE and CE (Terry)
>>
>> Changes in v12->v13:
>> - Update commit messaqge (Terry)
>> - Updated all the implementation and commit message. (Terry)
>> - Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
>>   pdev (Dave Jiang)
>>
>> Changes in v11->v12:
>> - None
>>
>> Changes in v10->v11:
>> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
>> - cxl_error_detected() - Remove extra line (Shiju)
>> - Changes moved to core/ras.c (Terry)
>> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
>> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
>> - Move #include "pci.h from cxl.h to core.h (Terry)
>> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
> [..]
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 96ce85cc0a46..dc6e02d64821 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
> [..]
>> @@ -373,55 +399,21 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>>  
>> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> -				    pci_channel_state_t state)
>> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>> +					pci_channel_state_t error)
>>  {
>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>> -	struct device *dev = &cxlmd->dev;
>> -	bool ue;
>> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>> +	pci_ers_result_t rc;
>>  
>> -	guard(device)(dev);
>> +	guard(device)(&port->dev);
>>  
>> -	if (!dev->driver) {
>> -		dev_warn(&pdev->dev,
>> -			 "%s: memdev disabled, abort error handling\n",
>> -			 dev_name(dev));
>> -		return PCI_ERS_RESULT_DISCONNECT;
>> -	}
>> +	rc = cxl_port_error_detected(&pdev->dev);
>> +	if (rc == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
> [..]
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index acb0eb2a13c3..ff741adc7c7f 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1051,8 +1051,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
>>  	}
>>  }
>>  
>> -static const struct pci_error_handlers cxl_error_handlers = {
>> -	.error_detected	= cxl_error_detected,
>> +static const struct pci_error_handlers pci_error_handlers = {
>> +	.error_detected	= cxl_pci_error_detected,
> 
> I still feel like we are disconnected on the fundamental question of who
> is responsible for invoking CXL protocol error handling.
> 
> To be clear, all of this:
> 
>   cxl/port: Remove "enumerate dports" helpers
>   cxl/port: Fix devm resource leaks around with dport management
>   cxl/port: Move dport operations to a driver event
>   cxl/port: Move dport RAS reporting to a port resource
>   cxl/port: Move endpoint component register management to cxl_port
>   cxl/port: Unify endpoint and switch port lookup
> 
> Was with the intent that cxl_pci and any other driver that creates a
> cxl_memdev never needs to worry about CXL protocol error handling. It
> comes "for free" by registering a "struct cxl_memdev".
> 
> This is the rationale for "struct pci_dev" to grow an "is_cxl"
> attribute, and for the PCI core to learn how to forward PCIE internal
> errors on CXL devices to the CXL core.
> 
> The only errors that cxl_pci needs to worry about are non-internal /
> native PCI errors. All CXL errors will have already been routed to the
> CXL core for generic handling based on a port lookup.
> 
> So the end state I am looking for is no call to
> cxl_port_error_detected() from any 'struct pci_error_handlers'
> implementation. Untangle that ambiguity in the AER core and do not
> inflict it on every CXL driver that comes after.
> 
> I think we are close to that outcome if not already there by simply
> deleting this last cxl_pci_error_detected() -> cxl_port_error_detected()
> "false dependency".
> 
> Now, if an endpoint driver ever thinks it can do anything sane with CXL
> protocol error beyond what the core is already handling, then we can
> think about complications like passing a cxl_port error handler
> template. I struggle to think of a case like that.

Thanks for explaining. If I understand correctly the CXL PCI error handlers
should only look at AER (no CXL RAS). We probably don't need a CXL PCI CE 
handler in this case either because the AER is already handled & logged by 
the AER driver. The UCE CXL PCI handler is needed to return a pci_ers_result 
to the AER driver. How does this sound ?

-Terry

