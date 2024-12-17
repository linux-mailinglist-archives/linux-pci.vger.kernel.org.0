Return-Path: <linux-pci+bounces-18638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F59F4D64
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981A51881283
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFA21F7090;
	Tue, 17 Dec 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gbn0TlCl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F11F7540;
	Tue, 17 Dec 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444750; cv=fail; b=BEsT1e9r7MohsWpNhd4CZSchyH7tEVB4ljdYG7TmMi0/YP9dYR5BKWt0aWvZqLQp/YvRdWgfYI3EQXCnvsRqugOXp+RSOxoOI7A+MBTB5cKSZPq5MvRQ60Td1GPhQIXM2/rljpnw6SsAdhQHczKmar/wmNtOr8CxE/z4XH1iIs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444750; c=relaxed/simple;
	bh=ja2zL3Y8cEljPM91/8QgKb5q/QNAjoToMvamc/MMlxg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l/V+TwjCDfGXEK7ZihZmTNZd4BQcJ6DEZwhFH1tFjlWMSIPqv+V8BZ2KiiAG0sl2bmRUemlHN4mwKPeCkshi+umvvNlcNwofeOsehwkS6QPQXKdmowjQo132FzFn2XKCADMsMEbg7mtp7fRKmZwUn2KvzFe6QNKs6OFFlxFnqP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gbn0TlCl; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k47Cl3Gzq9MgtL+lv+9GNJJVV1YICA4PYPK+uDUPrfSVzOpVWtD79ZqgV8A+6yFG4J2vkXX6V9cNpQZY5T8LbOoGtnq7xREbalwHcrLi5TxBON0k3KwZjGKOpiHT21Ct8GrhJG90rn5CgG+DUPYLMasJEwdRTXFRwfgW+cq6qnJzggp4yYTpi60m3rErzBdsuA4gfMzGmVWJUoXS7QGOmWuuW9LcnaGOXXBshGKo5J9HOwfVcKtKatbnbUaaNwV2N68o7wNbzOzF2mFc6uiGdI6xF5SEafyogmSZEpUS9K3V3LdQLUFXEFjLgUw8nuL+Vd5KdY7p9fMMS71UKt0gbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0uk2U/8pBxjqqhxJFJnvwZCbTt+Fztca45yAbu+2Ao=;
 b=hX27po3QHkbH9xg9l+BiopmGdG9gl6/UQ77EnJgJGgPbqqSM8Gz1O/v6bI4ZR+GfhOYzQhAynR6BZEYNBJoC+Jxh6fe8Wp/KZXoeuHOj01351BhQyhC4s4MJr2oPh6Nsq6xrwEz/OhAIfohiccLekgbKE8Q0nWeIHz2OzE7LDuzEzfz1XdczL42W46h7w2yWKZFgAI0pYIyM0O/s4gQH+LfukUgnJuyRCF/0KXsNY96fcDf1ec1338DKd4lQMo4z8DVMz2/7M/hsUAqrpmIy4hV/5njm9cRSVosVVC8XanCtueV6Dhd9OH5GA2A+goDN3qrjDiLlpAG5qv5Yh42Kjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0uk2U/8pBxjqqhxJFJnvwZCbTt+Fztca45yAbu+2Ao=;
 b=Gbn0TlCl+k3cwHtqovrU6I2YJ0D8q6Hlf2rpZWIUL9f1ibXZCX3TAXIJxfu625LuytTD7V7pOI0aQvqeWH3bhQPvbJmc9RFnsY2v0BJx3CDxgcuvEdru6gxX++iyeraU39Prwn+uVEbML3YpJUVdjv/kAIyOonxVSGwFW5nKjfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Tue, 17 Dec 2024 14:12:24 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 14:12:24 +0000
Message-ID: <87e0a55c-447b-4fc3-a391-e2c2ea9b8e81@amd.com>
Date: Tue, 17 Dec 2024 08:12:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Werner Sembach <wse@tuxedocomputers.com>,
 Richard Hughes <richard@hughsie.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Richard Hughes <hughsient@gmail.com>, ggo@tuxedocomputers.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
 <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
 <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
 <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com>
 <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com>
 <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com>
 <6a809349-016a-42bf-b139-544aeec543aa@tuxedocomputers.com>
 <20cfa4ed-d25d-4881-81b9-9f1698efe9ff@amd.com>
 <vVLu9MdNWVCG96sN3xqjkmMVQpr_1iu61hX0w0q5dSQtFBi9ERc3b6hSoCjobPSTNgkIp3PBheheyUlayhMeQjShsx62zNqxWnPsrHt-xaM=@hughsie.com>
 <2b762f16-fe50-4dec-8f3f-dfe21977d807@tuxedocomputers.com>
 <C9ewaxwQKbro-b58prMr4pYnBsbGXBokgIk3OMYfT2OTCUPqSKeabS2ED02pN44ukBu88wjq1JCzyc4Rb9KHK5qce8L1WufgA27O3NKmTvA=@hughsie.com>
 <6c5eb555-4642-42ef-8e4d-9c0c61292ba8@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6c5eb555-4642-42ef-8e4d-9c0c61292ba8@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:806:121::22) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a69380-a667-43b8-acac-08dd1ea4d459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0ZEam95dFEwT3FBQ3RzMnVNaWlCZXpURkpabE5zQ3FzTW5jMGR4aERJcVhw?=
 =?utf-8?B?dGd4ejM5Y0xsM1lYdk1RU0g1Z0dsUERPa3VOUnVOa0dHWkNsd3YvR3AybHFO?=
 =?utf-8?B?OWxhSTFjam5QM0Z4em5Xcy9IcWZSNXZRNndzR3IyajN2Y3BOR0xNVmZFbzJG?=
 =?utf-8?B?RmNMaTNlcWp5YTIxaFhJVVVUbG15SWtNTGpiTmtqMWZLRnFqa0FRZmhuYnBJ?=
 =?utf-8?B?dGFjVVJXLzRGRDdBZ05DSnN3UzlkOWQ4NjJsdHYrWWg1Y0MzUmdyaDExSjNO?=
 =?utf-8?B?K2NjaEhuTGl1dENYRE9nMjBMejNOSU5EVmpvQUZxTW1DMk1TRTQxZDdwd0ND?=
 =?utf-8?B?T01tVXZIMVVxRjNONmdYb3lSZG9mMDRFSmU5QkVxdkhDU0orTS9qMi9UK255?=
 =?utf-8?B?OUMxWWptZGRBREhFSEcwdTFtd00wWnA2WmtheUhudXQrOHdCREJMWFhPR1p2?=
 =?utf-8?B?VE1wMjRnRHI1dk1VblhwQmVGWngyY3dFZkNoK2Q0K1RLZFBTbGpEa0RmYUhw?=
 =?utf-8?B?UVNiSU9nTDJWdEl5Vm15cENxWkxSU3BXK1VodkpUMStjVW5tS0wvUGVQL1N5?=
 =?utf-8?B?S2R4bW9YRFdOV2xMYzhNMDVyc2xpQWlzd25laFEyd0FDOUdpemNtekIwOERa?=
 =?utf-8?B?WXlWaG5BWFR5MzNaVkcxeEV3YXNRb29KWHdKYnlXNjBydU1zQThyUVh2VGdI?=
 =?utf-8?B?NTREbDVxY0dVdTN2eDQ3eWRURTdNUURXcG5lSUtNdHRvNUFUTFYrZ3lSbWdJ?=
 =?utf-8?B?ZEpsaWJWWFMyYlNhcXYrQWpxemFTL1ZudDZNWFFneThrVEF3bnI4OEtiU1E2?=
 =?utf-8?B?TmFjT2JWTTd0NmVxbnFKTzM5cTRwdGZXNkRpN1QwK0lUTEwydHNMNjNLcytH?=
 =?utf-8?B?RzNQNllkY01QVS9QTVVtOXp2dXV4MFN0M09DUGVxWXErQnZGVFo4aHh4VHlW?=
 =?utf-8?B?WnV5dXNUNmdRQ21YVitra1RIOTdONW9vakVFVmpCblNNenZ1NEZkdHFZbUVS?=
 =?utf-8?B?Rk9PbFhzb2NvVVdNOTNGdEJ5anVyeVEyazdKNWxINEZJOThjT29sVXBMa1Zh?=
 =?utf-8?B?VHQ4US9KNzE1dS91MUlxa21LTDhYWFRVc2YwWHNXSWZlMGxSMGd3U2NGbTh0?=
 =?utf-8?B?WWtZaFFJUlZ1RVdwRWo2c21KMjZBN3lWZGdRWXJWVGJOSkZtTFJWTzZ3WStG?=
 =?utf-8?B?eC9TcVVRMFZBandUSEl1R3lkL3dzWXdGdHFYSXMwM1VmWFgzZ2p5SEFUTUVw?=
 =?utf-8?B?UVdjRkxsTnVtRlE1WDNqQnN4L29GS0tUUG1wZURicmx2bllLa2VRK2NNWTYz?=
 =?utf-8?B?UVYvRUFVRUcwZThvak1DTFlrZllTSTdUTkhzcHg1eExrN2EzNWdNakJHM3hZ?=
 =?utf-8?B?TjBYVDVpQVlWbS8yNVo2aHRtZk5iSVhRMGVRb3BhZ3c4WUlSNWtOSDhpeU1N?=
 =?utf-8?B?VCtDOE8wb2RUSkJVSVozWVFoR0JvK24xMlZ6NTZhRys1Wm5PTS9vczVmMk52?=
 =?utf-8?B?Mjd4UEhBNHBiR0lLV1czL3lRM3VtMkw5bytYNGFQaEIzRnRTS1V3K2xMTUFJ?=
 =?utf-8?B?WkljOXZIRTA2RkdlS1Mwd29nTVdaa096ZGdKOE5ydnZic1JXZHlaWDZScGhV?=
 =?utf-8?B?YXhxUnQ0a3l1VThQbTFrTHM0REhPUjZHcDltTFFETDdEYTM3ZTJQT29WY21V?=
 =?utf-8?B?R0hmQVN6YUtQNE8yVmZEem5qSFY0VHY3cFdyUThqNmhIOFc1ME9zOGtDeUZB?=
 =?utf-8?B?WVY2VHZrYkV5ejVuZk1od2NManZNN3UvVjNUVk5JQlBIWmo4c29MZmRQd1JS?=
 =?utf-8?B?S3FqQVRPeEgxcWJVNm8yNzZiMGtUeGtTTktsRmtyN2twSDNXQmFXeTlEdUFr?=
 =?utf-8?Q?Ig1AbTC9g67MH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEw1RFZpbElaNEFEOWptMGtxbTNLYWtoNjJjcy93TFZLOXNRdDY2NU42TW1o?=
 =?utf-8?B?TGhmNmFSRnpWWmNJazZqOS9qV25OZXBaM1BaY25tVUtjVngvOXhwNVBucnpQ?=
 =?utf-8?B?U0oyUERwOURIYXo5a0w3am5rK0s5OXpkSDRMTTZvZktubFVqblAra0NaSkk1?=
 =?utf-8?B?R0hsMjVXKzdsdkdOS3dDVStLT3VOQzl2U3BVYmFzSnRBWVFnQTBCeXVsSVZN?=
 =?utf-8?B?UFdjTGovZ1VnaktzbVFUYUtycnNVd09DMHJ2ZCtMNmk0cU1CL0YrNEFJU3VL?=
 =?utf-8?B?YnlrM3BoN3NLRFVrajdSRDZVbndrV05QMkptMWNBcWtzNzltNmgvRTlnRUJ4?=
 =?utf-8?B?RUIzWHJEamdCZHF5eHVCcExwOHBZTG1OQ3RNSDNaMU9iakRMZEZ6bGROTU9k?=
 =?utf-8?B?WXliaWxMWkI4cm1nSjdaTEdxN1pWeHgwb3VZRkNyNEpoa0xDZUpXTkhrQjk4?=
 =?utf-8?B?QjliNUY2YUdqZnVBbHhoUkJoWkRraVZxbWZUdDljdXFHZ3EzbDF2S2cvdnYz?=
 =?utf-8?B?MjFmQVZQcVp6YWNRWTFwVW9PbXlJWjlMUkRyN3lvMWpyWVBMdWVBQVkxQlR0?=
 =?utf-8?B?QlkvZ3VoaGtmbThKNjEzSXFsOWoyUmxZbDJGNS9nNDdKdmJPd2lWTzJKYk1Q?=
 =?utf-8?B?ZHNpQzhqQktVcTg1UExMT2tNaG8xQUFMNDQwbUtvVVVuZFpNMWdrVlNEUUdS?=
 =?utf-8?B?N2xmRGJhTHI3WEpRZmM4dGdOUTRxK2ltbkxKK3pxNmMva0xNOGtZWGpqOWVh?=
 =?utf-8?B?SERhYkJ1Vzk1TStYNHFjQmMxTXZmTjRqY3B4S1FrY01lNmhOUXZUMm9QL08y?=
 =?utf-8?B?U1E5NnBId2dhQU9tWUhVUWlYZGVhaGVLK2xuOUV2bit6MXZGZ3ZRSldGVGVu?=
 =?utf-8?B?Qlo0WnpYS2ZINWNLNWhnMHlDUHFVZDlpOGREYUZ4VUNLK1dLWFhuVEpvNTFV?=
 =?utf-8?B?Tms2ZUxvblNqTUdnMzJVZ0xQTGkrREdISXBtQ2NzZjJMaGU0VnQ0QjExUGlp?=
 =?utf-8?B?Z25nRE40MldObU9WTDUwR3hkNi82OC9Hb01aS25YdFNwUFN5blpPL0JXWjRt?=
 =?utf-8?B?TklXV2xKV0R1akcyYklPekdwUDVxQ0QwOTZ0RHZJREt3dHhkVUMzK1ZWSlVD?=
 =?utf-8?B?Q0pqNTVTdW8yMEpRdlcxQmJQU0RzajV4dEZLSUdOdGVyMTNrZ1hFd0Y5Z0xV?=
 =?utf-8?B?TC9Wd2ZUa0tkY0pPR2tzNkdQeDF3bzJzREpUQXJVZU0xOXZFdzFqU3NEaHB6?=
 =?utf-8?B?RWdaTGo0QnU3U3dGNVNCZElDQmZKMTZHRFlaZFc4MUh2RCtEK3lBYVhMTWxD?=
 =?utf-8?B?dy8zNXRsR0pnTDkybGFWdWpJUGVjc01wVjM2QkxjTjhOV3dYdzhoWFk4SURX?=
 =?utf-8?B?cngycnB1YkliUHRBMlpYSHhKR0hTZzEwcllIUWFHOGJuT1E1ZC9ENFpMdUI1?=
 =?utf-8?B?dncxaW9OZGJicUY0c25MZzA1UXJPRlJGMTB2SVBscHFWTWlhMTVhZzFwM25w?=
 =?utf-8?B?d0ZDZTkzZzhUalF4b09oUTdtRFU1ZFgvNXF0T1M5VlJqOGhEY0VHMUgvdk9w?=
 =?utf-8?B?Zmp5NUJsTjFGSmY5NExlRTZaSE41TTE0Q0FNQks0YUVvSW1KZzAySTkzNmov?=
 =?utf-8?B?RjFvTy9kc2dCSzBIZnlqczhnYXl0T05KZjlnM3o4aHQwZGEvQS9jME1PWlgv?=
 =?utf-8?B?UW9IMzIySGN2S21aYnlvZ0pXOXRkZXJSMXB5aXJTbVBsQmhMWCsranR0Zzc2?=
 =?utf-8?B?NDluclJBRkZRaFNIdGppQktiZS9nRlNPUHFRd2hGZmQzSzJOamtaME9rb1VT?=
 =?utf-8?B?dTlWYXN5SmY1Vk9HUVo0Q0M5TVlsVDdKUW5rc3d4Mk5EUVoyRDk1aU5Udm5Y?=
 =?utf-8?B?TUlXUWMzUXBuYjA0RGlBSm9sZzFlbis0WFZCL3hpUTJLdU9xWmtjNElyUWFu?=
 =?utf-8?B?TFlpd0xlVnFoWkF4a3RZbUF1S2NBcnhXa1ZsbDZkbkRBOXNidHBLVkNPY2ps?=
 =?utf-8?B?T1RYVFA3MkJ6MlFETnBaL2ZMZjdDVmR6aXdFYjNmM0pLZVlYY0NDYUJiSzV2?=
 =?utf-8?B?UnJXSUhVemtrV0VBa2VESUJaanBnSGx1TXhCRk1UbjBYV2d2N3NzUUNnOHRo?=
 =?utf-8?Q?SnssxVWV34j0ygQ7QeMKgEzFT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a69380-a667-43b8-acac-08dd1ea4d459
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:12:24.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PCymD3Xn1iicymSvM8iunJNSSh3Z5dORqbjKC8xeR9CKLw/t945iPT6OFnbRT9S0HjHARkzqiSLDG5C1kh9Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456

On 12/17/2024 05:58, Werner Sembach wrote:
> 
> Am 17.12.24 um 11:10 schrieb Richard Hughes:
>> On Monday, 16 December 2024 at 23:37, Werner Sembach 
>> <wse@tuxedocomputers.com> wrote:
>>> - AfuEfix64.efi <bios>.bin /p /r /capsule -> overwrites nothing
>>> I tried to explain fwupd and the requirements to our contact at the 
>>> ODM, but
>>> just got the unhelpful reply to use the command above.
>> Can you name the ODM? I think essentially all the ODMs are uploading 
>> [valid] capsules to the LVFS now. If it helps, it's the same capsule 
>> needed for the LVFS as for the Microsoft WU (Windows Update) process 
>> and all ODMs should be intimately familiar with those requirements.
> 
> In this case it was a Tonfang/Uniwill barebone and I talked to a 
> Tongfang representative.
> 
> Want to point out again that I could determine that /k did do nothing in 
> the /capsule mode while /p and /r did effect the flash (iirc /p was 
> required for /capsule or the flash didn't start). I could not determine 
> if /b /n and /l did something (and probably can't without proper 
> documentation, which I don't have access to). I guess /x is irrelevant 
> as long as the flash works.
> 
> Do you have a Microsoft help page for OEMs about BIOS and EC upgrades 
> via Windows Update? Having some Windows requirements to point to often 
> helps when talking with ODMs in my experience.

https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/windows-uefi-firmware-update-platform

> 
>>> Do you know how these AfuEfix64.efi flags are passed over to the 
>>> capsule flash
>>> process? Then it might be possible to implement them in fwupd too.
>> The capsule, as expected by LVFS and WU, is actually a single *signed* 
>> binary that contains the flasher binary and the payload all wrapped up 
>> into one. The only time I've seen AfuEfix64.efi in use is for the 
>> system preload, as done in the factory.
> Yeah but since at least the /r flag influences the flash process there 
> must be some way the efi shell can pass on options to the flasher 
> included in the capsule ... EFI variables? Some bits appended to the 
> capsule?
>>
>> Richard.
>>


