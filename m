Return-Path: <linux-pci+bounces-45053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AE6D32E60
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 15:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA5B9313494C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152D394469;
	Fri, 16 Jan 2026 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fHMZO1Eg"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F13283C82;
	Fri, 16 Jan 2026 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574583; cv=fail; b=XVozlTPNnSV4F/2hqx5nmu3cBTWf82MjVhKfGpgslgOyXT+++OL5k5Xw9G98a6VfJeB3UiXvR8WtVT2ikiDdQGmCHSiEy8VYQqmOjMPCE4aGJtrHbw+y/Sy0VmY2MwncXH8QyWvd9tWjVRaeLoTQMjCHimxfD7lcBxESAiUzstc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574583; c=relaxed/simple;
	bh=fC9LVum/rZq4/tZc9kx9GHX617tFT+W2LPVOPGy5L4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O/E5TErHNGbysKgjS2uWaJno880pVrqv7B4PKGusj6P0nSTzAzVpeTYELmlg8imFX0WDpB5I04Tm5ubIRigAykyQuGADoAUMUxMXQUvTa9CaT6kuPIa4Z6qe3mQXz4NRljs5LC3cUFZAO/ZXFnNLlANbfAGEiAq/HD5zEw7n6dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fHMZO1Eg; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b14dQWAOblREx+Q0MR8et6+6WMfzn3RT3SuQZdepyT/24qZdET+NFynjRQrQnjzBFVvtEA5kncg9iARvxu8XiuRtnaGscfkVCPjMEPvBMP/NoPFGxQnLdRtvH7T5cmxqBz5rjsl1MbCBbYW/BcD0vOUnhndYQkZD0VKbzbgUgRJqkfazgng9oypa5a5tfEz4DPyQmNdbIYyM204GLo2ytD9obIkqnWeBTmfYgvdH/gvjRwjfhA+xbLsBlGX67UmdHOCGH6kLiu+NHYVPLPm3QB5RYRVHuCLM7TPgj23NjgvMubFBhHKTfkhkXjVhB40xzbxJ3U8g3qh/KNkB3iSYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to7tNTF30N68VBhs6H3hjK1UTA+LCCNDNiSOGDtGUJ0=;
 b=X4+gl6SAZ81STBEmm1A0Egk9AfolHpcQw4duBFkzQtvU6lxoZCSReVvBkrxjNMOaTBYcQFcHvw16RuSl63lbxY7JfTXEzDoH5I8hXyMJNlXzvoDsg9o5Hk7BMCezGjJm3IndCk6vbrQCb+5e2ukMY1KFrJU6PLA8qvzs+3U3BxclCIo0MWhldBGOg/XRCVomfHRlFWMjvNHQfnXYi1MTAxoxmMxLD3P5mtmT4C5GWuq65a191c4zpKi405zD/hhs24l6yws9mjNkQrv7O0fgJ0lna726f4P0iXUKb+0KCdeMOl1VlKMP5ODDI3+HGKluQkR063jn+MFcpIxxNB7EcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to7tNTF30N68VBhs6H3hjK1UTA+LCCNDNiSOGDtGUJ0=;
 b=fHMZO1Eg2M7T0K1sd5SWPqi1eR5K4m9jp1KV2WWwnNDBolS7whSDgILWaQCtvHDfxgU8irezT5du1+lT1imW1AC7Zu3zw8SQ8XBsCg0zzytYjNy91vq+H/tfpPunOaD1rX70SxvO/5uhkte24Ex3gLdZGYwlL5UuNh7ucQCe7zI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Fri, 16 Jan
 2026 14:42:58 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9520.006; Fri, 16 Jan 2026
 14:42:58 +0000
Message-ID: <d92c3111-e37a-4ac0-bfca-b6796dd1877d@amd.com>
Date: Fri, 16 Jan 2026 08:42:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 30/34] PCI/AER: Dequeue forwarded CXL error
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-31-terry.bowman@amd.com>
 <2ddecc1e-8134-4730-bb76-630691359269@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <2ddecc1e-8134-4730-bb76-630691359269@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:806:d3::21) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b20238d-4bc9-49a6-c58a-08de550d8a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGQ1OXpiNllPMi8zKzZBTFdGYlcrQ3JZU0FwR0YxSkxBbGt5WEpSYWxkaGZC?=
 =?utf-8?B?Nmt0TUlCSkE2RktkM0JuS3ZyQ1lqRHZwTzJteDFyZFhERzVLc3JkQWJ3VTQ4?=
 =?utf-8?B?YkRPelQ2djl1b0xMU2FHelIxa3h6L0R6SjhTb0pXdjlLNjJGa1NXcVQ1d0Rn?=
 =?utf-8?B?L1dzVkYzY0lGUUpyS0pkby9UNUJEVG13cDBWZHdPenR4aHQ5VXVkSitoL1Zs?=
 =?utf-8?B?c3U3eXp3N1l3L3NxU0kxc2pYa0dtQmNNM0VnYThJK1RZMTRCWndMM21reHQw?=
 =?utf-8?B?WlZqcFJIY1oybyt6ZklLYlQzSHlybTFUdnk2c0xqV0Vqem45ZStHUjlSVFNC?=
 =?utf-8?B?TFE2bHo0SFJpbEROendkYnZuME9aZlZxdDBHdWZ3N0ZCVGVPVERLNHQxUm9I?=
 =?utf-8?B?OEdvNkZVK1lrRC9EWGdmYVpvQnQwYjY2dW5oZUgxQ2Z2YVMrcjFyd0ZhRCs1?=
 =?utf-8?B?WXh5WlQrQUdHK2hiNlFGMU5peGloTS9TakZqc2tHS0szbTFFV3RoNE9INUxn?=
 =?utf-8?B?NUxnbFFTdXRQNTRnQmttU2hJUzVMN1VsMm1JS2dMLzJZVURTcldCaFdPSUlV?=
 =?utf-8?B?VnNzVGVRQnFKajRLVktnSE51UmhQN0hpUWpYVHhDZVVnc1NkclRUWUZZaGc2?=
 =?utf-8?B?emw5R0tLU01DMkJhRmlaK3BGTitwNWxMWnNJS2pCa2pTV1JyS3R6N2ZXbG5Z?=
 =?utf-8?B?ZHh4bFcrS05ueG1Xc1diSVhoTHlkRzBxVEJkR2l3TGZ1azJZV1ZNa0MwR3Nm?=
 =?utf-8?B?QzVUWWk5OE9pNjlRb01FVVQ5TFJiYk00cnRLNE50UEpJNk9vODZ3bW1ERjNI?=
 =?utf-8?B?ekhUZ2kzU2cwczhoRkFtRW42YkhwVzk5Q3VHdGNXdjNOcWg0NCtBTlRkd0ow?=
 =?utf-8?B?N21FWG1QalU4eGJ4R3NVZlJLbUU5T0loaE12d1pjQTJYU0ZIQ2U0U3FVaWlk?=
 =?utf-8?B?Z3ZYcmE1T0Z2Q1lyTGliN3NqcmZLZjdHcHJFUktsZFJBWEQrZGxxT2p2YURF?=
 =?utf-8?B?YnpqaUd0WWlzLzcrZnB6RHVSNnh5NnhrSGdsYmVmRFNCbzlwUk05bTBTUklM?=
 =?utf-8?B?eEdWSEhlN0IzblZGbUhBTitDRmJMZkJXS0JSQzlGSitXTmhXM0xwd1o4Vkh1?=
 =?utf-8?B?WkNpSmsyZUlZQlB0M3k3eFRpc0VLU21yMGRRMDhLQlZGYVN6dU5pTnp1WE5i?=
 =?utf-8?B?M2ErZDBVTU9nd0lOWnp1elZ6NUduN1ZidVBWbHdHZzZ1Tzg3dCsvZUxDeUJW?=
 =?utf-8?B?Y2xTclRibGJJWXh4TUpFaWVWaElESk5tTGtEVkZLQ0dTMnZSQXNqU29rQVVp?=
 =?utf-8?B?SHgraEdmM1pGYlN1RmpWL05ZN0VnMU5DVjFObGwvUGJVdVhub3JXQlJKUmlH?=
 =?utf-8?B?akFpSCtTQ2dsMUlZMWd5a0lHeWtQVzRRaW1lRnpoQ00zc21PVnV3dW9pMVZy?=
 =?utf-8?B?bDBWMUV2UWZkdnE2aTNraDZtSm9iZGN6WlNCejMyQXF5Z0V1QzF5czg4OWlQ?=
 =?utf-8?B?YkFsWkRLMEVzcGNIUUFzclVSY016OFcvY2NqMjdoYjRKVCtLN1JqL0N4dHE0?=
 =?utf-8?B?dmRYQXd0YkZiREJycG1mVUw5TEZaa1F5NEY4RWozZitjZHRLa283eHRzOVpn?=
 =?utf-8?B?Z0laRGRPOXQveEVPL3h3ZjdpM2dZNDk1NCtxRWpSQ3VsMmwreTRUZm4vSXpm?=
 =?utf-8?B?TXY2eERncGovSm5MWUZ2cmhUUUt1Vy8xZWtsUHNrYjRrMWd3ZDR6aFpqR3F3?=
 =?utf-8?B?ajZNQWhORjZJQXVFdDJhalhjaEIrOFd4MFlCN0JNTlptN2FoaDc1MitUVUxE?=
 =?utf-8?B?U0lLTGhWTmJ2akpmWFpGVHlxbnV3TzRzS0oyOEQyRFhCL3NZSHU5S0Y3ZStY?=
 =?utf-8?B?N011UVB1V04vbitoV092aFVaaVpXcFhuaHp5T1ZtSlRpR1NySUdoeHhKRThN?=
 =?utf-8?B?UmtJNSs1MzcyTURGZVZZUWNPaGFxTXRITmlnTW0veE1Ca1JNbnlxNG1hbk11?=
 =?utf-8?B?bC9VSTRaRWV4RHZwelhlZGxoQStxck9BWVU0TkdrTGZTcHVkQlVQRzhlaElF?=
 =?utf-8?B?K05DU1ZhRklrUkM5aGloSThiQVhaVGhSeGtEWGhZMnYya2J0YWV6RjViNGRz?=
 =?utf-8?B?V3R6d0g4UCtmOHZxeWJmZ3ZOV3RkMHRkdVpTM1dKQXVMd3NvdXNZQ05UUjlC?=
 =?utf-8?B?Z0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGZiUENlMTVKQjZ3TnRiVXJsOE8yWGdrZ0ZmUTZJMEgzWmFGeWxEWGFMbWJt?=
 =?utf-8?B?KzBYSnlBSWNnOSt5RWpZSzIvQnVwb0M3eHJUWG9XcElLazNaR0Z5TVlNOW93?=
 =?utf-8?B?d0J2ZTBmS0haN1BhUE1OR0NmdFVCYUxYWkQydEVVREU5WW1UZDI0YjA2Mlc2?=
 =?utf-8?B?Y3J1eVFsc3dXYkFPK3dKOGlubjFkMnhTVkZJZWJoYThBbXN4OXBrSDBjZVVm?=
 =?utf-8?B?YXhuRGFEaTZkMVlndUkreXhUQXRDUTJuY3ROMmdERGwxeG9wZ01JQkRtREVO?=
 =?utf-8?B?SG00Vm0vaXFuenhRNm5IRDk2c3VkNGhtVnR2dnUxVzhlVXBpU21IRENPY3pi?=
 =?utf-8?B?UkJUa1V6YXJIdERjR1lTSkRISVV3TFVlVnViTkhZUEtrUkFBb0pqMWI2L3hI?=
 =?utf-8?B?OG5Ba2Z1NkJnQUgzZVkrY0czUXBzQ01PKzd1Z2ZxcE56cTFFR2JnR0IxUFBN?=
 =?utf-8?B?cW9leGRHbndtNW50K0FsUlUwT2ZhOFc5djRoT3lxNTNzcGowYUJWS3lDNnpM?=
 =?utf-8?B?RXI3VGlhK2czdHNxUnhMMm9kL1o0VzdhT29RKyttYTZ2UVRiY291WjFBdE9r?=
 =?utf-8?B?ckxIUWk3TzVReng4a0o4SjhHeEFEaXV5N1ZMM1ArMDVMQ3U2T2prRFRrRW5I?=
 =?utf-8?B?N0pvWWZOcGliWVZhelp6ZCtyeGc0dUMxaG9ZRFBYbWhUNU5ZK3hDcnN0cUhr?=
 =?utf-8?B?M24wSGpyY2V3NXFTYVhTZkt6KzJxQXBrNlZEWTlzVVB2N29FREEvZDhGTFFN?=
 =?utf-8?B?NngrTnBPZVFRajBBVHZrT0VmRVU1dHhZR00zc2MrdC9nWkJRSStFWCt2cWJ0?=
 =?utf-8?B?RWpQeWpRZHRuR2FLNmlML2swZitVTHFQNVhwNkthUEtoeW5lbjZud2lXb28v?=
 =?utf-8?B?N0pQVG1zbUFvc2JNejVPNVM3bHd1dVBXREJrUllxNFhIVVBsMzhSM2VNa1RH?=
 =?utf-8?B?aWYzTlRHbURJM3NVcnpXSzdCbnN0bjZTdEp1WVBrUG92MGN2TXYrVnIwN3NF?=
 =?utf-8?B?QUxtYkxrWkxWQWNoZDBsdXFrM1JQdFVCN0ZQU1NFY3BlaFg5N25BdXBvMzBN?=
 =?utf-8?B?YnQxRDRQR2xDMmc1YTlnanJPaHEvZXRUZzBuak9tM1BPVm1CL0dKQ1RHQ3Yx?=
 =?utf-8?B?MDZ4WlUyZXRlS3p0YkpWZHVHa2MyR3J6MEpRMUlJVmpjNmI5VVV1cyt6cHNJ?=
 =?utf-8?B?SjMxWTVhamZ5QnN3Smd1ZFN5enBNYTl6OXZDK2NQNjBibGNmZlg0clRLQTFW?=
 =?utf-8?B?cWFQOVBnYWo3QVQvU1lpMk1yWTI1UkVLQ3JRQUpCTGMvZzNpUzMzTHQ4T2Zi?=
 =?utf-8?B?NnBCWWR5MlhkQnNrVGltT0gvcGdPTmRhWnA4eVB6c3FhZmYxMEJaeko4WnNI?=
 =?utf-8?B?NWdybWJ0cTJSald0a1JVeEtkN2xhWWxnTFliOFBCN3lzN1Z5ODIvam82ZXBL?=
 =?utf-8?B?U3Q2ZkR0bDdQZi9leUZ4Wkw1UkdxdUVtWDJVQ2twNWFqbFpyZFd4eTlZN2Jw?=
 =?utf-8?B?a1RidmV6M0szWWxSL0dQRDBRV3c0UGJ3a2pNSzRFMTFCSGZyTnpXUk1oUmcy?=
 =?utf-8?B?KzVIc3JsbDBVMkRjMUgrcitGaHlpV04wazJPK1RVbnBOSmRmY3JNdWxLZmFs?=
 =?utf-8?B?RDFXVk9CVHVEWW1ZMXJYRC9KY2Z1VzdLVDFYRVZZWWtFUnFVR2psU3AxNU5q?=
 =?utf-8?B?bWh3THdONWlTOWpEOTQrMmZVVGpPeWhXSnMwQlJKRXhUcUFQNm55KyszRFZM?=
 =?utf-8?B?Wkx6M214elhHNTl2ZWEwZmxVVEpmVk9VTVdLRllvYnk2aVM5T0FsZUlJVzRz?=
 =?utf-8?B?N2hGbmRJaWQvdnlKZi83a0pxcnFZSDhBOE5yNjhRMERlZ1g3K3pFSGNmM1Zu?=
 =?utf-8?B?OFFHTk9qMWRHMG5TRnhiY0h1K0ZrSjlxY0FmelI4T3pHSmU2blk0MGhwRVho?=
 =?utf-8?B?NjV5dUtmRHhMOS9oUFJwbkQvR3J1MzZTbm1nNzR3ZGRFbDNIZ3lCTUVyTzds?=
 =?utf-8?B?ZDNCN0Z2d0N5UHgwRk1wa2VPdEk5V3piZDN5R3FLZWFsem14SlUzVWtYMjB0?=
 =?utf-8?B?bjZaUGZFOWszV3ZPMjBPK1AyNE5jaXhIcVFEOTVlOGFrc1VjUnNBQmpBbFdz?=
 =?utf-8?B?RjI4dkVDbExYWUlyWDZWZDlMN3Z6cTdobzlTbkxUYmVkYWFUemNKVFpkRkxq?=
 =?utf-8?B?c1ZHM3dlLzBZR3lZQXdLeTZiSTJxOUsxZ08yUXFyRE9STVZ1VTAzME5iZDlL?=
 =?utf-8?B?cnFtV0Q3UUl6bVloRjRrSktBbFkwTHlsUCttdHd2QkUwTjdPSmRXM2dsMzMx?=
 =?utf-8?B?aW5PY0ZyemZVVDBEdEViZTlZSk1LQXIxWGk4VEZsRWlQZzNYNkhBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b20238d-4bc9-49a6-c58a-08de550d8a89
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:42:58.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlMLrd2sQhSLGbuclEdAM6tkYnqSDc4/SJMbEperuZezrlV6HgjHYMtnWWK8Kssb1xpHq2TCGQ74mvSg93mzcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

On 1/14/2026 5:18 PM, Dave Jiang wrote:
> 
> 
> On 1/14/26 11:20 AM, Terry Bowman wrote:
>> The AER driver now forwards CXL protocol errors to the CXL driver via a
>> kfifo. The CXL driver must consume these work items and initiate protocol
>> error handling while ensuring the device's RAS mappings remain valid
>> throughout processing.
>>
>> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
>> AER service driver. Lock the parent CXL Port device to ensure the CXL
>> device's RAS registers are accessible during handling. Add pdev reference-put
>> to match reference-get in AER driver. This will ensure pdev access after
>> kfifo dequeue. These changes apply to CXL Ports and CXL Endpoints.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>>
>> Changes in v13->v14:
>> - Update commit title's prefix (Bjorn)
>> - Add pdev ref get in AER driver before enqueue and add pdev ref put in
>>   CXL driver after dequeue and handling (Dan)
>> - Removed handling to simplify patch context (Terry)
>>
>> Changes in v12->v13:
>> - Add cxlmd lock using guard() (Terry)
>> - Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
>> - Change pr_err() calls to ratelimited. (Terry)
>> - Update commit message. (Terry)
>> - Remove namespace qualifier from pcie_clear_device_status()
>>   export (Dave Jiang)
>> - Move locks into cxl_proto_err_work_fn() (Dave)
>> - Update log messages in cxl_forward_error() (Ben)
>>
>> Changes in v11->v12:
>> - Add guard for CE case in cxl_handle_proto_error() (Dave)
>>
>> Changes in v10->v11:
>> - Reword patch commit message to remove RCiEP details (Jonathan)
>> - Add #include <linux/bitfield.h> (Terry)
>> - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
>> - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
>> - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
>> - Use FIELD_GET() in discovering class code (Jonathan)
>> - Remove BDF from cxl_proto_err_work_data. Use 'struct
>> pci_dev *' (Dan)
>> ---
>>  drivers/cxl/core/core.h       |  3 ++
>>  drivers/cxl/core/port.c       |  6 +--
>>  drivers/cxl/core/ras.c        | 98 +++++++++++++++++++++++++++++++----
>>  drivers/pci/pcie/aer_cxl_vh.c |  1 +
>>  4 files changed, 94 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 306762a15dc0..39324e1b8940 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -169,6 +169,9 @@ static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>>  #endif /* CONFIG_CXL_RAS */
>>  
>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>> +			       struct cxl_dport **dport);
>> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>>  
>>  struct cxl_hdm;
>>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index a535e57360e0..0bec10be5d56 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1335,8 +1335,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>>  	return NULL;
>>  }
>>  
>> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
>> -				      struct cxl_dport **dport)
>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>> +			       struct cxl_dport **dport)
>>  {
>>  	struct cxl_find_port_ctx ctx = {
>>  		.dport_dev = dport_dev,
>> @@ -1578,7 +1578,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
>>   * Function takes a device reference on the port device. Caller should do a
>>   * put_device() when done.
>>   */
>> -static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>>  {
>>  	struct device *dev;
>>  
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index bf82880e19b4..0c640b84ad70 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -117,17 +117,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> -int cxl_ras_init(void)
>> -{
>> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> -}
>> -
>> -void cxl_ras_exit(void)
>> -{
>> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>> -	cancel_work_sync(&cxl_cper_prot_err_work);
>> -}
>> -
>>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>>  {
>>  	struct cxl_register_map *map = &dport->reg_map;
>> @@ -173,6 +162,44 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>>  
>> +/*
>> + * Return 'struct cxl_port *' parent CXL Port of dev
>> + *
>> + * Reference count increments returned port on success
>> + *
>> + * @pdev: Find the parent CXL Port of this device
>> + */
>> +static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
>> +{
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +	{
>> +		struct cxl_dport *dport;
>> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +		return port;
>> +	}
>> +	case PCI_EXP_TYPE_UPSTREAM:
>> +	case PCI_EXP_TYPE_ENDPOINT:
>> +	{
>> +		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +		return port;
>> +	}
>> +	}
>> +	pci_warn_once(pdev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
>> +	return NULL;
>> +}
>> +
>>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  {
>>  	void __iomem *addr;
>> @@ -316,3 +343,52 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  	return PCI_ERS_RESULT_NEED_RESET;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>> +
>> +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>> +{
>> +}
>> +
>> +static void cxl_proto_err_work_fn(struct work_struct *work)
>> +{
>> +	struct cxl_proto_err_work_data wd;
>> +
>> +	while (cxl_proto_err_kfifo_get(&wd)) {
>> +		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;
>> +
>> +		if (!pdev) {
>> +			pr_err_ratelimited("NULL PCI device passed in AER-CXL KFIFO\n");
>> +			continue;
>> +		}
>> +
>> +		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>> +		if (!port) {
>> +			pr_err_ratelimited("Failed to find parent Port device in CXL topology.\n");
>> +			continue;
>> +		}
>> +		guard(device)(&port->dev);
>> +
>> +		cxl_handle_proto_error(&wd);
>> +	}
>> +}
>> +
>> +static struct work_struct cxl_proto_err_work;
>> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
>> +
>> +int cxl_ras_init(void)
>> +{
>> +	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
>> +		pr_err("Failed to initialize CXL RAS CPER\n");
>> +
>> +	cxl_register_proto_err_work(&cxl_proto_err_work);
>> +
>> +	return 0;
>> +}
>> +
>> +void cxl_ras_exit(void)
>> +{
>> +	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>> +	cancel_work_sync(&cxl_cper_prot_err_work);
>> +
>> +	cxl_unregister_proto_err_work();
>> +	cancel_work_sync(&cxl_proto_err_work);
>> +}
>> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
>> index 2189d3c6cef1..0f616f5fafcf 100644
>> --- a/drivers/pci/pcie/aer_cxl_vh.c
>> +++ b/drivers/pci/pcie/aer_cxl_vh.c
>> @@ -48,6 +48,7 @@ void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
>>  	};
>>  
>>  	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
>> +	pci_dev_get(pdev);
> 
> Should this chunk move to where the commit that implements cxl_forward_error()?
> 
> 

Yes, that makes better sense. 

-Terry


>>  	if (!cxl_proto_err_kfifo.work || !kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
>>  		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo error");
>>  		return;
> 


