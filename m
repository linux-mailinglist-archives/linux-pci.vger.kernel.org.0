Return-Path: <linux-pci+bounces-18389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BA9F1080
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9095B16238D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF11E1C1B;
	Fri, 13 Dec 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M7TJysdQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444981E102E;
	Fri, 13 Dec 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102647; cv=fail; b=EKSWVls2FYpqRS31E2oz5NVSvxGvA0eNKJ4JnFM+VtZ7IYoEcFE3LxIF9dlr8yc9iyrj0N3yLXwaRkxr3A2cYcUZ1zMDr1jz0IN6l07usmkT8oQgMB5gEIe1fnc25SECc7fE1ioBdirg9KmWldYqkyqaIKz2Bk9sGDBca4Z7274=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102647; c=relaxed/simple;
	bh=d3QjN5JgRZ0C6aJEYgEtDjwEG8EaRZVb08QhwzEFzIM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pFHWVrxQ5DsN0Fu081iyNljGPYaY3hlf6T/GCdUhRtFNU1SS53BFAN0uQRHW9PEeQNC5B2fWbywAwKV8OnTE1OyXpuJWLZwg0ZuYZJteJrQk66JcYQEcYr/UF2LkC9DoSyb72vS/jmBHATHNyMQMN4+7uyH9w9+zv9cEQrkFrik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M7TJysdQ; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp2U5hDXm6r50+LA2V+9SQk8RD7jSXHtJzaWtaWMLUQfu3Su7wYTVhp5rH4dnRQDQNhvOOwjOPj75L/pjK9inbQcG4pcDDriyzHrsvWPckMrXEPBfbAdnV7e7NImuJDnirTl1R23mKgK+hf6tBuMJG3+PZ9S7LQI7fJoILnaPSEQBwjbR5K7be/VdueccsPCMwbWn57NQx7VRuQIY7yidAnPh3gSUJjsVqZjn4LPjtF6R12DNVBlV3l8YUcEMSGLTeAiXh0ATy5X0yZ8Oqz2dl81e+CXKzz23fu64Uha4FRj8pvIJAp8jGauMEjx/oI8efDgyrIurGOiEq2dFUk05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7nwbPPF39drVVCP0sFeFes7Kr4T6/gp0HvJVP+ykew=;
 b=nyTP/GpHWUloiGGM9dmW2Wf6JmQjE8wjrwBH7r6MTAjr70M6oXFwKVPUIbW37m5/4yOMla9u2Jn1nwmeiGwu9d/VppzaLOFDODLkYA/3hPKnKpryjQHc7/L+Uqbc0alV+otVRGaL5X54GSbr09AceJYtjVsadNxyccInA0byTt5VysAHllcw/RD5F991pwMBCyagz9A7XN1VsSuYxD/FwFbVw8/H9wxDEe4lM7vaCe1uBe0Kzs/iIYDhJ9vlUQJ+KUrNVlwG7dp45LGETYiCABGAmTyUk6t6t/dQF7SaOoAaUptb6mj/iWPVuWo9uWvhBKubmg59uYSV9vsYclYXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7nwbPPF39drVVCP0sFeFes7Kr4T6/gp0HvJVP+ykew=;
 b=M7TJysdQI4i4JNNGxDELL+Wp1GYnuXY4zuYKkylYMH8J/kHxHAshhra99fy9qmZfBWzPfIvACcqLYR3tfjB5Cm96+OwGhnSuHtu8NDwVrpf7dwpBGJvuBdN86kiULbku6MIZAell+UU4/1dSL4+fvPMe85dVz4H7CXSsIgHp8mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Fri, 13 Dec 2024 15:10:39 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:10:39 +0000
Message-ID: <32a1f6fc-9c37-40f6-a2e3-222f926adf1e@amd.com>
Date: Fri, 13 Dec 2024 09:10:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com, Li Ming <ming.li@zohomail.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-9-terry.bowman@amd.com>
 <a3aba79f-ceb9-324a-d683-0c58876f6e1f@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <a3aba79f-ceb9-324a-d683-0c58876f6e1f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 6854c3b7-455d-45e5-36f1-08dd1b884dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZExkZ3FEbUVMRGh3Y1EvVXQvSnpuMTVYNUEzQWY2bkg5cWpaMEZtODlNWURT?=
 =?utf-8?B?YXFhdHRsWDRNUXRxY3E4dlhJQjFVeExMRTB4ZEx2TVZjekZNbkRHVGJUQThN?=
 =?utf-8?B?UXlXMnpPeW1VV3paR1RRQTB5YXkyQWtEZHRRNWJLMU9tSkJaSW9iTXdqK2xQ?=
 =?utf-8?B?Mm9UUWM0QmdWV04xMExNVExaYXhUK2RRT2FjZW1yOWtPdWtsN1BnTlJ0Tzkr?=
 =?utf-8?B?U3BUQ0FQdHd5cENQSjFYNk1Cb2hBYmFaUy9mN1BTSHhJMk4wKzkrWWZwbkgx?=
 =?utf-8?B?L2l0MFR0bjdmTEY4QWlUTGhocUkwSGIwWWVzeFpBWEZvYTB0YkhXZ0pMYWd4?=
 =?utf-8?B?elU3RlkwZlJVSEVadHIyRTZBME92bnprUUhBL2JrZnZxa05GRW5pQlhBTmcx?=
 =?utf-8?B?Q2pjMDFaWUk2WFZtN1l6NThHVW16MENoN1Y3M3B4OW40ZzBNY3BwaVRGay9m?=
 =?utf-8?B?UEhrdjZGR2c2VlVIWkJORXgzZ1FycUQyUVRiNnJlVUdDSlVhV21RZlZqYlF6?=
 =?utf-8?B?dWhwUjRLOVZ2SzlPbDNIZWlHdi9XTE1oTzZJSHViUGk4MjhPSzF1QUpvWnFx?=
 =?utf-8?B?QWFWcFB5bHZZQ2NuY0V4amNHWHpra2tqVGpiZnBubngxRktvS1pRZW1uZmh3?=
 =?utf-8?B?UEo5TmNBZmREWFJzc1Z6MEtYWCtQVVFkQWZQNnJrOVV3MUttRG4veVk3ekZm?=
 =?utf-8?B?MkdQbmlrOXljUml4UHdXZ0VnMzR1SGF0NGRMTW1VS0o0OGhoNHNpeUJaRGhS?=
 =?utf-8?B?SGxlMHB0emRhZmdoYmVuS3RXd0NSb3dQZjJWVFcwZGc0c3I4aFh3RFFNdGRx?=
 =?utf-8?B?c05vMW5VQlhjM0d3VWNFYzVDUDBYY21PbEtCQUpMM2JkRS9SRmhQUHVJNjZL?=
 =?utf-8?B?dDM0czFtaHVqaWIzK1hQSjlySEZDRFU2aU9oeEdxNU9IcVlXcEpjVVpHb3pj?=
 =?utf-8?B?dUkzMGw4R01iSm5GOE1iaDh6OTFrUnBMWnN0ZmVTVWdlNG9wOEZ4bnAxd2ll?=
 =?utf-8?B?WCtNUjJ0L2UzK1pOSUU5SjhscGJHMkhnbDhLaXNZUmtaZlpwbXYvV3pSVUg0?=
 =?utf-8?B?UlVHYjhza3JMSDdMdkk4M0EvOXZ6aHFnWldYdlljLzdMZGpHdmY0c0o1MjQy?=
 =?utf-8?B?dzR6MElDMEpsUDR3VE5MUFBpUHlQcUtoTnI1cERBOXBqSTg5Y3JUSUphV0pZ?=
 =?utf-8?B?YnlCTURqeVl1SUZwelRKSi9vUlR2RmFucFEzZUJ1ZXJ4SzIyTDR1SXJoN0dX?=
 =?utf-8?B?QzVjNnpDS2tHWTEzaEVlSzhpVnpFUzFJSHhsV2p4aGZ6Rmk5YWszVkczTTN2?=
 =?utf-8?B?SFVObkdkS3FrYnRXU2RRY2hoanYxVnY4TGl4enZvZDVRNjl2ZnJka2kzeUtn?=
 =?utf-8?B?dkxENVRma2tTWVNzWHFSeTlObEgzVnAxcmtHdUljWXNCbzBuM3NTdmNqOHZa?=
 =?utf-8?B?YndoTUU1YURNZ01GWEtXbnMyTnV3YUJtYkw1dzgrWnVFZHFnbkdtQ2R3N3NQ?=
 =?utf-8?B?Y1NSaGhhN0g5NkhwWU43OUdDVk84WHIxcTRHUS9IWHNQcDlUMHkwNm5mSk5h?=
 =?utf-8?B?eWh6M0F3RWhoMEp5eldMSElyUWlkdTQrUUZTNzVFaFltWW5waW82RmNJMkVJ?=
 =?utf-8?B?Ui8rY3BVL0ZHVGsvSGVvZk5yZ09BNFY4VkRsU29WNVgwR3ZOMHBWN0pjM1RR?=
 =?utf-8?B?S0VueTMzTGJzd3F5ZXl4Q2VFNHZ5VUYwZm5LSmo5WVVHOHRxMW9YRUs5OHQy?=
 =?utf-8?B?NUZURW90UFA2WTFHL3l2S21TRTRzeHA5Q3I5a281S3dWdHVjTWJWMzRadkw1?=
 =?utf-8?B?SXVxWFFVNEcyRis3RmlFT0Mzd1BmTVhGU0NISG1ndGVQSWVOTXVOMlZ5RzAx?=
 =?utf-8?B?cGJybmlmbVRCZ2wvOFl1bXRNOXVSOVFURWpLclpDbTNFL3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUR0TDhzMlVuajJ0emJoemFvRis4TnhQTTcwc0VoL2FiU1Nzd3M3NVc1VUJM?=
 =?utf-8?B?THZmZWN6Z2dXZGo5S0RtaFA2Z2pUQS8zVEROcGcvZkFsT1E4VkpTSmRSUXg2?=
 =?utf-8?B?b3FTV2hVeWk1UG5KdWl0N1ZnVEpTZ3NBenZ3UjVYMm83ZkZvb0tiWUljZmNE?=
 =?utf-8?B?VkNIcXRzSGkydnk5OVgwWVFXYmovZVpsdEFpc3ptK0ZDVjNGWnlXSzQ1V0tJ?=
 =?utf-8?B?TnJmTUNma0hWNSt3OTNrRFhRbExwQkVPeUlzbVY3MVZXNGV4WmUvYVBieVQ0?=
 =?utf-8?B?M3hZQXhUTWhnaGMrbFprcVhDTW5ZK0k2Q3owaWlVcm5yWERiZGt0bEh1UDMv?=
 =?utf-8?B?QUNmdU5HbW1aVTlGQ0VkbFpibFk4dEg5NUdUZ0psTnlGSlhtK0RaSURGdWNJ?=
 =?utf-8?B?OXhTUHVMZ3ZuQjNyT2VkaURGcFRjbFpMZ05BTVY2ckk2bDZBaFY1NkF6NExP?=
 =?utf-8?B?eVJLTG85dCtOa25IcUNCWG9aUjRhcDhISFRQWU5yUHRBN1M1RUVjTFIvcHdw?=
 =?utf-8?B?MUNlaDROWmxoMk04K0pZWlgxTVpLcUJsMXNiWnVXcDZPcmhCY3JtZjdpN2p3?=
 =?utf-8?B?d3hsZndyeklJOFA4UXVUWEFheW5vdmlERldxU292RUlKN2RMU3VDd1JVNmx0?=
 =?utf-8?B?RXVjU2NhZ20vN3F5b1FucFVFck14U2xVVHF2bkVQTmF6R0ozQlNmUFB6bEtT?=
 =?utf-8?B?NythUmZpWUxGcnRtVTgzZDV5ZGRjeEtNQXJCbjhCT3Brc2llaGZYOHhnc1lU?=
 =?utf-8?B?bE5iZkl1UHRBS3B3Nlh0UW1qM3MrdXQxQ0RRRTBkNk9JTmtSM3BWTzQrS1hR?=
 =?utf-8?B?bG9qd0VlUStSSGF0eWdkWjZuYjJWd0g3RHJySGZMc0VqT2czWWMvcVkrSUR3?=
 =?utf-8?B?em14SjR0Y2lmSDZuNzZDcXFmQkx0bTV6VTVyaVVrMmRmZWswNnF1TXlJbC9M?=
 =?utf-8?B?QTJuZVhncFcwK3FDMWlsa0FhbERwdXFnRWlsRHRUeFp0MjNDalArVTlCY0tS?=
 =?utf-8?B?MDhqWE5UVzZTc2d5MFRGcmcySVNITGlIaDNseGlsNFFzQTlLQ3YzdVNyOXV5?=
 =?utf-8?B?aWVVVVB2anJsemIzZWtDN2gwN0cwK1RQZlllb09DdWNOVmdxNkpXaFlLZzda?=
 =?utf-8?B?cmF2emVCdm5GazVEa29tWmNlakwxTlVzSFBCZHpHSVVzR216YnBXZUZ5azBr?=
 =?utf-8?B?RmJNUWVtbUdFczFVL2pPcGQ3R2xQWmJVVmdRd3FiUXF3Q2dLY3k3VVVEckMy?=
 =?utf-8?B?a0M4cGx3UEN5Y3V6WmJ4ZE9DWkdjcEZXMkljTjdwMC9jdmN4UnlUYWxIZlhN?=
 =?utf-8?B?OGs2Wmw4aE9yNjc0QWoyTXluQ0xONjFWWUFRQWZ2M0U0blJObHRoM2hTTUdt?=
 =?utf-8?B?cDRRWmMyVlVYdkE0enNsRlBUeGw3dWwyYjhycXFUWmJ1ZTJkRzVZVzBFYVlt?=
 =?utf-8?B?Q0gzZENyYXg5cUZHQzZTd0NweStOcndPY1NMVVhsY2VMNHViN0x1QnVEYytL?=
 =?utf-8?B?c1NzMDFSZGxvaDRpVjlMamhNZlpsMzN1RnRnTUp4UlpsdUd6MEFBSnlXNVV5?=
 =?utf-8?B?bDl6Sk5KODc3TVZHTkNTRHQ0ZUhmcU9VMDdSZmtBY2prNEMvT2xXMmwzUGkv?=
 =?utf-8?B?N1NvY0U5L1JqeWFOeHJZOHBOUnpkVGs3NG4xNXE3RDduM3VIQnVFYXV5K0ZI?=
 =?utf-8?B?YlZvbDlQdURWUENjUEFEdmFvNitqNW5EbnF6OEs2UCtWbTdWcFpBTGQwZTYv?=
 =?utf-8?B?MkRpdkMwVVpNRlE2b0JwQ0VxeFlTRUw2eVE1N255STFjQjdyWXdvQmc0Nk9D?=
 =?utf-8?B?enEwL3FwVG9nUjUrT1BhWnNscTRIdTdVQ1V4OGJRbEI0Z1NxdkZPTkZwVXg3?=
 =?utf-8?B?Z2twRjQ4ZEZQYUYwSUVFOTQrZjVSOVFLRExmNXFFWE93aW1ScWtMbktWSE80?=
 =?utf-8?B?QXc1R1Fkakd4QlpndzNEUVNTRFE0TjZSeFlKN1VBT0JGZXJuRGpyYXBKajhD?=
 =?utf-8?B?RmR1V0RiVVRVMFQzOTNTSk0yd1h4M1M5bms0WkYvRW8rTnBqR0xxd2c1RXFi?=
 =?utf-8?B?T1JCV3NTM2NuZjNjay9tUlRhZ21DY1BRd3hMQXNrYTd2UHRqdnR0czJQYzlW?=
 =?utf-8?Q?ZjP8tp7lOtwqfPGUMd+lzMt+U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6854c3b7-455d-45e5-36f1-08dd1b884dfd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:10:39.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLAuP3YxuN2s+nTjxJPnWCCec3FqqM4cOR5I67EnqN+kGvYJGeFuRpQAsQx2J9dZM4N3oaKDprGFD9K/DWSpMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691




On 12/12/2024 4:36 AM, Alejandro Lucero Palau wrote:
> On 12/11/24 23:39, Terry Bowman wrote:
>> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
>> registers for the endpoint's Root Port. The same needs to be done for
>> each of the CXL Downstream Switch Ports and CXL Root Ports found between
>> the endpoint and CXL Host Bridge.
>>
>> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
>> sub-topology between the endpoint and the CXL Host Bridge. This function
>> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
>> associated with this Port. The same check will be added in the future for
>> upstream switch ports.
>>
>> Move the RAS register map logic from cxl_dport_map_ras() into
>> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
>> function, cxl_dport_map_ras().
>>
>> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
>> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
>>
>> cxl_dport_init_ras_reporting() must check for previously mapped registers
>> before mapping. This is necessary because endpoints under a CXL switch
>> may share CXL Downstream Switch Ports or CXL Root Ports. Ensure the port
>> registers are only mapped once.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>
>
> Just a nit but, regs mapping could fail, what is properly reported, and 
> the __cxl_handle_ras function checks for the regs iomem being there 
> before using them. But if the mapping failed, any report there is 
> silently dropped. If the AER is happening, maybe to add a WARN_ONCE there?
>

Good point. I'll add the WARN_ONCE().

- Terry
>> ---
>>   drivers/cxl/core/pci.c | 37 +++++++++++++++----------------------
>>   drivers/cxl/cxl.h      |  6 ++----
>>   drivers/cxl/mem.c      | 31 +++++++++++++++++++++++++++++--
>>   3 files changed, 46 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 5b46bc46aaa9..8540d1fd2e25 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -749,18 +749,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>   	}
>>   }
>>   
>> -static void cxl_dport_map_ras(struct cxl_dport *dport)
>> -{
>> -	struct cxl_register_map *map = &dport->reg_map;
>> -	struct device *dev = dport->dport_dev;
>> -
>> -	if (!map->component_map.ras.valid)
>> -		dev_dbg(dev, "RAS registers not found\n");
>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> -		dev_dbg(dev, "Failed to map RAS capability.\n");
>> -}
>> -
>>   static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>   {
>>   	void __iomem *aer_base = dport->regs.dport_aer;
>> @@ -788,22 +776,27 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>   /**
>>    * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>    * @dport: the cxl_dport that needs to be initialized
>> - * @host: host device for devm operations
>>    */
>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>   {
>> -	dport->reg_map.host = host;
>> -	cxl_dport_map_ras(dport);
>> -
>> -	if (dport->rch) {
>> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>> -
>> -		if (!host_bridge->native_aer)
>> -			return;
>> +	struct device *dport_dev = dport->dport_dev;
>> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
>>   
>> +	dport->reg_map.host = dport_dev;
>> +	if (dport->rch && host_bridge->native_aer) {
>>   		cxl_dport_map_rch_aer(dport);
>>   		cxl_disable_rch_root_ints(dport);
>>   	}
>> +
>> +	/* dport may have more than 1 downstream EP. Check if already mapped. */
>> +	if (dport->regs.ras)
>> +		return;
>> +
>> +	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>> +		dev_err(dport_dev, "Failed to map RAS capability.\n");
>> +		return;
>> +	}
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>>   
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 5406e3ab3d4a..51acca3415b4 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -763,11 +763,9 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>   					 resource_size_t rcrb);
>>   
>>   #ifdef CONFIG_PCIEAER_CXL
>> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
>>   #else
>> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>> -						struct device *host) { }
>> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
>>   #endif
>>   
>>   struct cxl_decoder *to_cxl_decoder(struct device *dev);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index a9fd5cd5a0d2..0ae89c9da71e 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -45,6 +45,31 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>>   	return 0;
>>   }
>>   
>> +static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
>> +{
>> +	struct pci_dev *pdev;
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return false;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	return (pci_pcie_type(pdev) == pcie_type);
>> +}
>> +
>> +static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
>> +{
>> +	struct cxl_dport *dport = ep->dport;
>> +
>> +	if (dport) {
>> +		struct device *dport_dev = dport->dport_dev;
>> +
>> +		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
>> +		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
>> +			cxl_dport_init_ras_reporting(dport);
>> +	}
>> +}
>> +
>>   static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>   				 struct cxl_dport *parent_dport)
>>   {
>> @@ -52,6 +77,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>   	struct cxl_port *endpoint, *iter, *down;
>>   	int rc;
>>   
>> +	if (parent_dport->rch)
>> +		cxl_dport_init_ras_reporting(parent_dport);
>> +
>>   	/*
>>   	 * Now that the path to the root is established record all the
>>   	 * intervening ports in the chain.
>> @@ -62,6 +90,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>   
>>   		ep = cxl_ep_load(iter, cxlmd);
>>   		ep->next = down;
>> +		cxl_init_ep_ports_aer(ep);
>>   	}
>>   
>>   	/* Note: endpoint port component registers are derived from @cxlds */
>> @@ -166,8 +195,6 @@ static int cxl_mem_probe(struct device *dev)
>>   	else
>>   		endpoint_parent = &parent_port->dev;
>>   
>> -	cxl_dport_init_ras_reporting(dport, dev);
>> -
>>   	scoped_guard(device, endpoint_parent) {
>>   		if (!endpoint_parent->driver) {
>>   			dev_err(dev, "CXL port topology %s not enabled\n",


