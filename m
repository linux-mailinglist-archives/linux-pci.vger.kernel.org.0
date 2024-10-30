Return-Path: <linux-pci+bounces-15636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBC89B6862
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4B42845A0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315721314E;
	Wed, 30 Oct 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U6NdSzJn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF8213EF0;
	Wed, 30 Oct 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303487; cv=fail; b=NFVHyOBUlxP9Yx5gsEsg6qCLFtn+Vb8zF+RTgdvuk3j2WU+ngLvUQUmvSbiTQe4zBqFWQEOiZR/0PwuYLIA8H5WDRFiiioPcP+A5XgF07ZTamgRp0IxkRPYHFcBV0Uj3GwlyGX6YsKe+q49JgUPnqGBX60Bj/GwQEHqVH3FoTUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303487; c=relaxed/simple;
	bh=fDsT3V0t5enZ09Lb4gBsjRdnA5mN5zq4lkHMixRfa7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TbX94/DwxHLr+wMxGN++emQSnbLFs4wdQOApQ9JSwCUkkSy4MPbXz+bB2ilWb65d7/iqx01HL5is+Cn/x2MZpXKLVN6jOfMY48HJG5pgHeQhVDGYm2Ha9QaB7CsfAQ6T8SyW8V4ui14o8Miz0RquexO0dBn78HgQiJ5lwO1GFGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U6NdSzJn; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x01SC2iiex7/oQ5WsMF+JD6P0pckbfOjv8v5KeHWwPEMdOUfdnzuv6NOB54pSHmD8cXaXjdC3sGG93B3KRc7sLgx1EX4u38xUFzyXaMx5FMJieZD6kGNPSsQ/VWKKnsQuIr560RfIf+KIT7Qy3e3pDF6Flpi6oZo1v0weD8B3Q+Qr+VrSKKywL0/cYY107EJPFG2RhO9W8JDFiW+LB0DlLu+jgPqlCQEmJg7IiqpLDcMSRlVzsqYICE2Q2n9SoXHKbWnQJj0SJo0ZtiSbpOEMc/FVu7eHzrsKHfSIUY4Mn1bjEt+u2HbCqzYk600rhEggEkCiEmPgWMoFdHg8Mm7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fFy6Hdg3gntNS0vGH9F4+YQOiCxBdKlzsTt7tc8ROs=;
 b=nON7vBJFf3dYBZPNjI72MhRIdJbj0RURjR7uUsWnb2PgkPc5mW8wAu8ZZhkxnZ2FZYvGTPrcEBHv2K6yJi5QvO5UAp6GIaEvL6j+zzOiTDz7E9beGv9E1AoZ0XJLdSIEiFRRBkZ0ybsi4CIHaDmoCPFZ5x6/7aSNz4Q8oi3sc78SYByT3+tWdcOe7XXD+jvN3K4+V92zDZDfXKNCdiyXR8jMKPVZyiMKPr9hMsmmyaTUJzBvDyCLzRLdque5fNju3F9kPdV9ooJ6JGx84SAOnRQC+XwZFjSEoGdLxT7E6VsnNPQteH0njFO5BZnzUniREulAjxyNssfvrOEo5YHFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fFy6Hdg3gntNS0vGH9F4+YQOiCxBdKlzsTt7tc8ROs=;
 b=U6NdSzJnYDl+dtFq/QSj/daz346FclqYsKlxACKgW9cbDcSZRPnu7kMVrHlpMBNbBThZH5fQsemIcW1+sYM+wjZBnFp5hSJApprplfjp0K9nPGvTsCxzhGDORBxROH8dHzmkS2Im7IGrR3vxVJ3JsV1bKHBDU6dh4Sq5KLkVlZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 15:51:21 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 15:51:20 +0000
Message-ID: <e7702a99-5386-445c-9b65-cbc189eef9dd@amd.com>
Date: Wed, 30 Oct 2024 10:51:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-6-terry.bowman@amd.com>
 <20241030151308.000005d5@Huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241030151308.000005d5@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0169.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f54a8f-aaef-46e8-dc23-08dcf8fab282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFo0UWR4ZG5OU1R2U2pZQ1NhL09kL1J4dFBzd3BubG9Za1FRbU1hZ1Z1bG9a?=
 =?utf-8?B?V2pQRHU3WnVMa0V0alZyTW9VUGpCdy9LOFJhVFNUcDJ1VHduTU9GbnRzTGF3?=
 =?utf-8?B?QkhydjlWbnd4NU9FY0R3UGtUQStGVTlCdGZVQ2p4ZlBrZ0xBUzN3MDJ4dEJK?=
 =?utf-8?B?Qy8vU2YxZHJOMCtsMGFaMnRIbFdZM2svUFl4MjlMMFFzbEN1VStaTXptOWpR?=
 =?utf-8?B?U3dDN2RtQTVFdWFXL0V4OWowdUsza0tJaGt4aXgxakxUYkpmcHROaHQ0TVVD?=
 =?utf-8?B?UnpmMVpNTHNDMjJOdDN5UjVTSC83cDdWeGJ2M3VrRFJrTGJvK0ZEbDVET2s4?=
 =?utf-8?B?ZTBsTEtoZERWZnM4bys4TFcwOHUzcnJQK29CQUZ1Q2FUaHNxL3QwMW9HQ0RN?=
 =?utf-8?B?OVdFOTB1aUZQdGFOQnJsbVVYSE1jeWp2c1VwdW5vaFkyMTFFcG9FWkVZc3k4?=
 =?utf-8?B?SGx0MTRvTVNwWHBic1ZvNU5LVTdSajhUYzFOTitLMlNrQ1oxUmxubXFJVkpE?=
 =?utf-8?B?VHdiejNXWmRsUVM1R1NmNVVkdHlIbDZqZUVQVjNpZlBWaUJ0R0Q1UzlWQlRH?=
 =?utf-8?B?enY4UnoyU0t5QUdwRVBjSmpTMy9KS2ZCcFdDcTBFdklZNHpoTWtYWm05T1hL?=
 =?utf-8?B?cFRPMnE0SG4yaHplanExc0hhOTVKRTZiVUlVYmNlNU5vK1c4azI4OC9sTk9k?=
 =?utf-8?B?SEdSMURrZ1hNZ3hTelNmVkNBQ2JoOERSRXZHeVhZMVlhSU1tZlRpZW1LOHhY?=
 =?utf-8?B?ZzlwWndIOWZSYUJFUldGcFl3elN6M1NHQUVEbzJqRy9FZ255b2d0RDNzak02?=
 =?utf-8?B?ZWJqSlhjK1BzbktxbFBIZTZHQitxN2s1WnR3Z3NzNEFlbVlldVUzTm54MWtK?=
 =?utf-8?B?Q284USt2NFhYQ3h6Vk1iMk5IS0FSZzRQYXpWeGlKRDFMZTF0eTZ4ckZIS0pz?=
 =?utf-8?B?cVRkTVdaUGVGTFhLMmgyeXY0ZlV1YmpPSUM0M3dKYWN2RjBDeGhTbVMwbS9K?=
 =?utf-8?B?b1BYQmVab0lHeDB3Uktnbjh6L2hpd3FmcVpzYzMweThXYXQrYjRpZGRwRXpy?=
 =?utf-8?B?YjVBKzZoN2xEYU9IOGpOb3Jzenc1ZXByMndzRURkTktRcU1hc1dob2JOZ0FS?=
 =?utf-8?B?QkxxV3ZFVzBNMVM3dzZNdktPMll5L3ZCWlJHMmhhczJjSWFvYXY0azBraTN5?=
 =?utf-8?B?T253MmRIbnpkVUdpTzlBRlN5c2dic0ZpRmhsVENBdVM0aXpSVG5SYW1QOExY?=
 =?utf-8?B?V21DQ3dNckUyRGNqZXRqdDF3Z1FVSXc1WUhPVzcvVHcrM0dMc3ZXZ1I1SXRk?=
 =?utf-8?B?SVV0TEx1VUZkL2dVYnQxZWMvSUJkQ3VLMlg1eG5ENFduQzc4MkJHQXp3cjZt?=
 =?utf-8?B?dDVhTm13UXZ5d25TMUl3RzVPc0FGTXZzemJ1NGJFOWNOU252U24vMTMyK3NG?=
 =?utf-8?B?UW5MN3cxSm5kelIxM3AyMHFVSEtaYllSSTNmOHp1WWZweUV5Mlh0bHp3MW1J?=
 =?utf-8?B?RmNNaWNYdkxTREltR0VvaytEeUJOaHJuSmtNUVUxbDd0dlJNaEU2K1FGZFcw?=
 =?utf-8?B?UUZqWkp2b0lwZ3I3YnpMWm81YWdUWDg5OTMzNkx3YXplYzcwdjhySW4ybzFW?=
 =?utf-8?B?NmZwQTFkZlBmZTdIVE5nV3VHYWxtRzVsQzMwZnZ0Mi9WREZpSTVsT1R4anVn?=
 =?utf-8?B?bEdwMGV3OG9NWENjc0cvTTlqTWNYejdyUXVXYzdCcDh3WXB0blRtUXNwOWNS?=
 =?utf-8?Q?QddVZPUD6gLDnnkl/0yUq/OJpGjAD2MXTqm20gu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGNaSU9GY083MkpoN2puVGxrNVpiTm9kakd6MDlmM1JmSGI0RzR2WUZ3Sjl3?=
 =?utf-8?B?WHBZTnQ1WmRDanlBME5qSDJxVG94d3hSVEtqYkhGeFIyS3V4eVJzdk5JVmE0?=
 =?utf-8?B?MUlsQVVRV1puRzdaZGxkYzNzbFJyNUJHRCt5UEVVUUM3S3hkaW4yM0xLZlVs?=
 =?utf-8?B?U2JqSVlqQzVqQVRNN1hIMUxjSnRhekR6Szhkem0yc2NDdlluR2VVL0Q0dkY5?=
 =?utf-8?B?R1VFMTB3R0V2NTJ4cnVZT3J6eW5waGlmd3A2TDhLWVpPVmpwSkdJYzhhUlhD?=
 =?utf-8?B?UHNBejg3bTA3UU5ESnNTL05uZzhhaVhxMjQyUkJEQ21tUDJzVVJWaUxEZC83?=
 =?utf-8?B?WkFJcnc1UWtpb3dSaE1sdXZXQUVDQU94bUNsa0lnc3ZmMnQ3N3ZtelVxWk95?=
 =?utf-8?B?TDBZZFZueDdmMWJNMkZHTGRMa2lFc1h3RHFOT3QxWGRvWkZLVGNpeE43cHB0?=
 =?utf-8?B?K3FjWmhYK0IzMndOWFZMcXRLSGVFa2FhcWh6VlEwcXdRbEpicnZTaVZ5VDc2?=
 =?utf-8?B?eUMrcTA4S3pMRHlkR2NjQm1mZ21UTE44MjFrMjh4Q25LT2NWaGw5TzRhekla?=
 =?utf-8?B?UDREVFFBM3Y5bmcrYUYydVRBd2xNVFhOMFhjNXVWbVBQY2RPREYvZCtPMFJo?=
 =?utf-8?B?M2xOd2svNERoRjFjam5XTEFWNW5xbS9CSGhQSlZjYitScC82YjRNK05LUGFU?=
 =?utf-8?B?L1IrS0FMZWRFYjkvYW5ENzVEbHpVY3BUZFVkSEpqMGRwV291cUNkZGhFRGx4?=
 =?utf-8?B?akJnaVhBOTZnc2ZBeG5jNzAvZXhuM3REMVVSQXE0ZjB4a3VRUHJEVkZBTnNI?=
 =?utf-8?B?NjRSQXRxUzdjYWZkSzA2YXhHMWZZNUxVRzhLYzNSdVJ0S29BMURjek5rZktx?=
 =?utf-8?B?WnF2L0p4b3lFcjJuVVNEejNRMXhPR3I1WG1EVlBMcXpVRGQ1SXBpZkhwR01X?=
 =?utf-8?B?bnN6MDFueUZqclp1VFozYmRuZE9lS25uOEk3R1RxWlRaek9XZDNxU0ViYzJI?=
 =?utf-8?B?S1FxWnZMSmxnR0dhdnhpTjNYMFVlazZFL0pocW1Xakt4NWNJckJNd1JuL0tw?=
 =?utf-8?B?S2drYjZWdy9vV0ZFbkdTUkRqVWJGREg2OVllNGxRWW54bUtHNkRKek9sUnRN?=
 =?utf-8?B?L3RKNjFTRkpsaUtmSFJmak11Qi9sTGZkcm8xeXJkUTV4eWRTd2hUaDRxNHEx?=
 =?utf-8?B?NnI1MW16MXpDWWwrVk1OVmltYzZSL3pUOWhENkl1a0ZQL0NlQ3ZyS2ZpUFFw?=
 =?utf-8?B?bkhBTnBCLzBibUMwajZkd3FyeDM1RXdOakh6YzJIVm40SGxndFJUODlYOFhR?=
 =?utf-8?B?V29WbnhSZlI4K2FscDQxcktRVWlmNGVpaXhMVUJJKzU1ajBvczdOVlRkSTZm?=
 =?utf-8?B?K0pwN1pLT0ZLcU5zK0JQQzhleFJ0NlB2bXRNRjI3c2RveisxMWFPM0txSW5I?=
 =?utf-8?B?ak9yTzhReENQdThqTmIzN2RsekZqRkNCRHpMaFUyaGllVFB4WXdDWmtlbjlK?=
 =?utf-8?B?RFdvd3l5ZEJkUGg4L2VLWnBTdkFsZHZLR3hHSXA5ZEk5SGZNa2dBUUp0aUtE?=
 =?utf-8?B?TWRPamNLZlcvZEU5YnNobXBIZHVhK2ZrOGZNSUh5THlRS2lJaE9kVzJoU215?=
 =?utf-8?B?V3NOVk56RTVYZTBLOHI3U0w2dUo0NWs0S2xaVXZRSHJoS0Z1czJJeUJYWmVi?=
 =?utf-8?B?K0l4eTd1MzFIMitMelIxZnc1UjNaUTVSNHMyMGk0Q3J3UEN3ejRlTU5HK1Zl?=
 =?utf-8?B?bEFETjdZZm9tNkYydi93SGoraitwMHJnSWt3bEhvenpzdFVTU0txMXBNNzJT?=
 =?utf-8?B?MHBLMnNoZkRRSkJwT280cUZGRnYrL3IrSzlIUGtJT2ZWQzlQd3BNc2RoS1di?=
 =?utf-8?B?MUxJNkgrUUtYTXlBRVNyL080czA3eXlLNE1Mckc3cnAyeUl2bGZRU05oVysv?=
 =?utf-8?B?VkFBUmVWUFhuRUN4a1JEK2xVZ2RjUHJIZFllY3pVY1V0QkJtc2ZrV3Vkcjls?=
 =?utf-8?B?Y1c2SzZNYjNFaHFLM1RTaitGbS9oUzdLZWh0VFdWVU5BTWFrVGJUQUh3S3J6?=
 =?utf-8?B?ejhKMDV3QURvVTJEdTJBdnQxblVyaXhnQVhESHAwY0dROXgyUytxN25LSVBu?=
 =?utf-8?Q?58QtyO0aPtINUTXfLuBkPbKZp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f54a8f-aaef-46e8-dc23-08dcf8fab282
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 15:51:20.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ge/HDHgsQgGYAlDe8YlJtR+pPQSJVOR3zjcJ3gIcsy/+lOi+wR1FHqDOfK68RCZf3ovm5jrCZnXNUs1k/pNN3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880

Hi Jonathan,

I added responses below.

On 10/30/2024 10:13 AM, Jonathan Cameron wrote:
> On Fri, 25 Oct 2024 16:02:56 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The AER service driver doesn't currently handle CXL protocol errors
>> reported by CXL root ports, CXL upstream switch ports, and CXL downstream
>> switch ports. Consequently, RAS protocol errors from CXL PCIe port devices
>> are not properly logged or handled.
>>
>> These errors are reported to the OS via the root port's AER correctable
>> and uncorrectable internal error fields. While the AER driver supports
>> handling downstream port protocol errors in restricted CXL host (RCH) mode
>> also known as CXL1.1, it lacks the same functionality for CXL PCIe ports
>> operating in virtual hierarchy (VH) mode.
>>
>> To address this gap, update the AER driver to handle CXL PCIe port device
>> protocol correctable errors (CE).
>>
>> Make this update alongside the existing downstream port RCH error handling
>> logic, extending support to CXL PCIe ports in VH mode.
>>
>> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
>> config. Update is_internal_error()'s function declaration such that it is
>> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
>> or disabled.
>>
>> The uncorrectable error (UCE) handling will be added in a future patch.
>>
>> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>> Upstream Switch Ports
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> This is a fiddly patch to read, but that's at least partly diff going crazy
> in a few places.
>
> Anyhow, I think it is fine but I would call out that this changes
> things so that the PCI error handlers are no longer called for CXL ports
> if it's an internal error.
>
> With a sentence on that:
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I'm not 100% convinced the path of separate handlers is the way to go
> but we can always change things again if that doesn't work out.
>
> Jonathan
I will update the patch message to mention ports use CXL handling
for CIE will not call the PCIe handlers or PCIe recovery.

Note, port devices are bound to the portdrv driver with fairly generic
CIE handler.

Regards,
Terry

>> ---
>>  drivers/pci/pcie/aer.c | 59 ++++++++++++++++++++++++++++--------------
>>  1 file changed, 39 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 53e9a11f6c0f..1d3e5b929661 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -941,8 +941,15 @@ static bool find_source_device(struct pci_dev *parent,
>>  	return true;
>>  }
>>  
>> -#ifdef CONFIG_PCIEAER_CXL
>> +static bool is_internal_error(struct aer_err_info *info)
>> +{
>> +	if (info->severity == AER_CORRECTABLE)
>> +		return info->status & PCI_ERR_COR_INTERNAL;
>>  
>> +	return info->status & PCI_ERR_UNC_INTN;
>> +}
>> +
>> +#ifdef CONFIG_PCIEAER_CXL
> Diff was having fun.  Maybe put a blank line here? I think that's
> what has tripped it up.
>
>>  /**
>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>   * @dev: pointer to the pcie_dev data structure
>> @@ -994,14 +1001,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>  	return (pcie_ports_native || host->native_aer);
>>  }
>> -
>>  /**
>> @@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  
>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> -	cxl_handle_error(dev, info);
>> -	pci_aer_handle_error(dev, info);
>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>> +		cxl_handle_error(dev, info);
>> +	else
>> +		pci_aer_handle_error(dev, info);
> Whilst not calling this for the CXL cases probably makes sense and
> given new code needs to be the case to avoid a double clear I think,
> I would call that change out more explicitly in the patch description.
>> +
>>  	pci_dev_put(dev);
>>  }
>>  


