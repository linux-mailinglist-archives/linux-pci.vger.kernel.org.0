Return-Path: <linux-pci+bounces-38417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B1ABE6421
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 06:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AF96226B1
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 04:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB33E23E355;
	Fri, 17 Oct 2025 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R601rIdt"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CA1758B
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674036; cv=fail; b=RKbGieLWOkJRbxPuMocFXyk+J9oIQ4HQQPmDqUEQo5L5UGXm5l6TVLc8GkTTUryvVNOpPmJuqLAikFm3d+C0khQjXUhYnp64KzPl/Fp4WFbsdPQn2JNkMOxn4ASXlp5J/z1yPhEcqF/cTtSsfq8grj97Bxo2wAGGr/CZ9Av5v9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674036; c=relaxed/simple;
	bh=8mtmSGngfXmYLTh6SoO5FMI8hxrit1NpDXiD0rJWA1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YA7bZXhUZu1iGEZvd6qDancsEEXfx9EU8HQt1WSo+0dbh/EpyUE6dZSu7MDnTZslqX/ZdLFTVtgAM98r2dRQ1hcNcPqu2GzXzy1g1sr+xWAgeatI4JCnEKkd9ireiVBJ1p9FPjdI+KTwrB68XezOfts+HFG0fJsOrEgD+Lzc0U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R601rIdt; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhMg+df8Kkp5ysSIGa0OU9IPp3Zw/V5iF4+Sp4fpflKHh8F0w3mxN3eiJEvDOQlwyS1XwgVJWoeF2OtWWdPhmq5mNYTQePflHYjw0TklzeHNgTNDYXAXf2kwRhMYUEIZr1tnQOFaAGuImwtgrX/xjbKx+NbUdwnVZfOGJmKujCi5+TTnNa9ozPhxA5XycjRZUqXcfguSWmktneTRDMNxa/L/kLL/b7c4xWi2IiX+0aDa0IQsFodlZ3doy1hz8RGWQP3kfg37xZjVhCnsoIHU0/DTD7LXb+2RMQB4PPPvKIcYP/T0X9wteWshHRDdXpSG3vFV4Mu8PJASyNl+B0M5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8NNpnjY8pVN0TGDkbYkqkecMrF/LM3UiKpQglHl3o4=;
 b=nDrCzBEzcWUwpdbdOHIzUdl+KSQECAWnVA9oDCtO04DOpKGtgS44NjAchpVkutsFomFx26G4hmx1uiD4IOU1f0+VaXP4ZxIUmJZHTxy3pwKmDG1ow0/YviJHsBT8JdCc2iF9XxtXdPY/xvZd4cBVxd+H6f1qB3voeS7F7LkbbQUhqKNMGTau7LTGFVo/b+WdHBNaU0QwsmaG+1HV7BwLxuxO7TZ/Tu3LwXoB5Y36s0yIzIaeyqfZwaBIXnpqrejGa28HIktYraP530za4Pg524hh8WcfK+0isEsEYeRf1nXdc85zGFaIgUFfLTEPl/+c7A1ZYc9iBr4T9yQprmyBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8NNpnjY8pVN0TGDkbYkqkecMrF/LM3UiKpQglHl3o4=;
 b=R601rIdtqHa55Anw+RNKaSeRVzvfx4TMHNUSdfuiM/MY1O3Yn/Wx0XskUXJ2J5KrxGBaACpdNyOVwDxFmE701GCETFV5Zkbn97QHhqAregKhryXWjTVwnb1nLrUisI2MgADr5sLSfJtyhlAEBRG+8wUpUfTdZoEEecmCmfZSBi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 04:07:07 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 04:07:07 +0000
Message-ID: <3d100559-8eb8-46cb-94b3-34ca9fb6dd96@amd.com>
Date: Fri, 17 Oct 2025 15:06:28 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
 <68ba3f725b284_75e3100a5@dwillia2-mobl4.notmuch>
 <14144093-c3e3-49a1-96d3-acd527cfe32a@amd.com>
 <68bb95a07043f_75db100bf@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <68bb95a07043f_75db100bf@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0146.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::7) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 522359d0-2306-4b23-1719-08de0d32a323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDRkVHgxZTlOb2JGbDBxc2NnZ3RCaEozQ0U0SFVrK01YbXNlNzY4YWRXU3RC?=
 =?utf-8?B?eSthRk85bStPclpFY3RmbG03L21tckw5c2dqbTFFM1pydm82dlZqTXNSOXo3?=
 =?utf-8?B?RVFyY01BMXAvQjZKeERRNlNIVVdQUjFkb1dIN2lCQWtSYXFURTFCUVVpbGNm?=
 =?utf-8?B?dStkOE1OTWlXakZWTlFOcGhPSDB0b1BzU3ZoQVc2Y01XcFNXNlZVcHpZMTFu?=
 =?utf-8?B?bHdFTFVCVHlJRkVCR2pMcFI0c3Bodjg5T0duL0tzdjdxWWVZNDNUdjUrRHBE?=
 =?utf-8?B?Yy9QZTJzZWV6OUNSNlZzbXE0cUVWcTUwUWdpd1NZUllkdG5SSFJRVWE2M01a?=
 =?utf-8?B?RElEWDN3Q1IzVkgzdGtFSnhRUlQxbFRDcTE1cnkrTjlqdERIeFFOaDd4dlBF?=
 =?utf-8?B?TVVRSmdCZmwyRkpYMTk5dzdUejFEekh4R282L1FiSkhhb096enRJa0VnNWRZ?=
 =?utf-8?B?MEtyYkpvZnJFeHpsYW1WclliSGIwWmNBMG1RWWtCT0lTK2VPZGJKdlk4ZWRH?=
 =?utf-8?B?QklJMzZ0WW9yb1dLdGpUeG5ydFRwRFZKOHlVaE1qSEo0Zjl0MkVZaGpwZkF0?=
 =?utf-8?B?L2hnUE9nZ1krOTlzellyMm1yb1N1NjBWbGhoUUVKaWhEV2g5MkRnWVBNdGFj?=
 =?utf-8?B?MHBhVG93dVlyM3hNNzNsUG51cnVNWnpzYXdLRXFpUG1OODhWRDA0WUdrS2tR?=
 =?utf-8?B?QlNFVzJJZGVMbGxhZ0tPYk05OHlPRHZrU2wvWDNTek9GbWJUYURkVmRJVWtB?=
 =?utf-8?B?TlpNWHM0cHJhZ2N5bzNGZHpLaXJQUm5wSi9Za1hwYnkrOGVOYXprNDN6VlpW?=
 =?utf-8?B?QUNibGZlZGpKUFZSemRTUlhoTFBiR1lpa2hhNEsyWVdZSVh2UUVZRXdCWHRr?=
 =?utf-8?B?WFAzbThobGkrVmZMSUpHR0ZOQ0p4ckZMZmFkVE9PL2xSNEdBWjhBZkxDemhJ?=
 =?utf-8?B?RmxRYnRxQXFmQXJ3RzRmNWlIUUZHQXdPWjZpQ3A3dmU3MkFIa0dsSkk2NE5s?=
 =?utf-8?B?SjlRWlZxM0VUMFdXYjljUklSK0w5YU55bGQwRWlUS3Bka3hOVENzMnV6VCto?=
 =?utf-8?B?Zm0yZG5oWldWdUhhaFI3dFY5Y0FNMXh5Y2Z4ejVtNzRuWnpBMGZaSEZZS0pV?=
 =?utf-8?B?TWtZbW5JK1dWOEdBNFNoQzY2QjgxeDIrK1NmaFJOdkRZS1BYVmRyNVp1MFhz?=
 =?utf-8?B?WHUxUGZNODRFM1ZiVXRlU1hiN0xyYWJhY2p6SC8xdFoyUHhORTQ1SGR0V1VV?=
 =?utf-8?B?QldRU3lOMGtobEp1dVlPRGpWMHZkYmZmRlZseE1nRVVseG05RUNqZDVnbEp5?=
 =?utf-8?B?YjI5QUpnR0kwaG1aMHlZRGNkTWd1RWt3OHJGSDZuWW5vV3MwYVMxSWlLM3lU?=
 =?utf-8?B?Smg2NDVrU3o2UWlpek0vK1VRRGhEUVJrcmRlOXF4bEUwZ1lCMUoxMy84SG1E?=
 =?utf-8?B?UnozcXpNQ2FCZU0wTW0xaWRjUzQrNlE0SmV4TTcvU3FuakdvL2dOMnF4ZVJM?=
 =?utf-8?B?QzBhb0dFejdKelZWZG1TY3UxRW1ZbE9xY3hoSGM5bmR0NTk1U1pUR1VZY1ZE?=
 =?utf-8?B?dDR3OEJxN0dmZ2NKRnZDNUlBRkUxM0pxRmx3MjNPdE56NGx4Z2N3YldpNk10?=
 =?utf-8?B?RXJIMkMrd1p2VXEwbUlRWmxYN0F0bWpEWkRhYllrUFZmTi9BdHhlT1pYdGhP?=
 =?utf-8?B?MTQxWENUaFUxWXZmUUJHc24zWHYwNnFXZXEzdFNrU2szbjBoWm44VCtxWjRa?=
 =?utf-8?B?VkhjL3FNalNPSmVaamtlQXBkaWlZUjFOTURpWDAwT01IZVlUZ2NYbmZtbm55?=
 =?utf-8?B?clExYyt5ek5lMHpDRk8zOFQ2RXpyZjhiYlNONVhmdXZPSVhVMlpYemlCMG1F?=
 =?utf-8?B?emNEaTNlMlFjYWJlV0tHdEx6am5YTWN6NnE4b3NFSC80Zzlia2Q4NDJKaGEv?=
 =?utf-8?Q?bj9K0HSLaLKNMUZqmPuyD7tWiDGiYyft?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm9IRnJ3YkJBNktUVFdMWUF3Tjhabmk3TzBOM2pzZkprTzJlTFNITXFPQXMw?=
 =?utf-8?B?R0Rkc29sUm9LZVM2RjBjbmFOMFBsMlJZV3Q3ZVpvYmN1RlZDV05DMHV3ZDRr?=
 =?utf-8?B?Zk5TazFjOUUyd0xNOVBtVUNXbndYdmZxcExyR1djS3l4bkxEbEk4cGxCOWVy?=
 =?utf-8?B?NW84U1dsRTcyU291bmZqYjl1RUJhQnJIV2Vod1oxOGJyVmpwcXdwakNSTkN6?=
 =?utf-8?B?R09wZnNzSU5iYUt3QXg4aGZZQTlYSldFb0o2MEw0YXZicllpM3MxSStyVDhF?=
 =?utf-8?B?TzRKNVBQV1NYQnZvNUJ4Wnc2YTJhbnFnaXRDQkFveUpXMEdCSzZUUGVzb0pE?=
 =?utf-8?B?bmVzUEdhbWRkUkZOVTlHV251cldpTU5xM1BmMmJXUjA4M2psTHNRdnkxcStP?=
 =?utf-8?B?enpyL1BiWkFaWmlNcFViOG92SERvVk40NTZ2VnMwbXBuK1MwTG5yU2NpL2d5?=
 =?utf-8?B?VHdUR3Z3N3RXRkg0WjM0bWIwOVBQaDZhQzc0NTVja1Yya1RSaU9YSjJyQUpm?=
 =?utf-8?B?c3Z1ODAxdHJ2ZUhINU01WUo0M3pkaGh5ZW5NaGgyOGEvc3VRSm9XM3dIeW5N?=
 =?utf-8?B?MjVLNHl4djN0NFdhb0NKRHo4SGhrT3FyQkxlUUs0OHRTNmVNOXJVck5xU1hq?=
 =?utf-8?B?aFdUQ05XNzJjUDB0UCtscWQ5M21oRDk4a2IxdzhOK0JjZVZXZFY5SWFLS0ht?=
 =?utf-8?B?Z3F4TDBXUHhOdDlDODdlNnJKVCsvcGlNTm5FTnFEbUtJc255eCt5a3A3d1lw?=
 =?utf-8?B?U1ZJL20yYUFCS0JvVkg3aWQ5K085RktlU3BsUTl1N2pCMWptbWJaWXQ1eHlk?=
 =?utf-8?B?dVRYclYxckp0U1VLSmJqdGZXSWI5K3FPaEplVS9SaE5TeFJjVTkxY3ZRa0Zi?=
 =?utf-8?B?NWVGZDQ1Wm5FdjJRWi9WdG1aSHZObUhXQlIyYWkrblBOeEc4T0FqcUwyTnYx?=
 =?utf-8?B?SlgvWVpzZE9EdkM5NkdYM1NhdlIwMHd0Qkxaemkvb3pobjM2WmRUR2w1a0Fa?=
 =?utf-8?B?bFk5S0ErQmkvM25ZSUlueWRmbGFMRXk5UlE0eStkQ1o2dU1kTHA2NGE0TjRX?=
 =?utf-8?B?MDNCS1ZnZjdQYnJVeDVadzByTlZWNFlhdUdyK0NJdFJnOUh6RitPcitRRVhl?=
 =?utf-8?B?TUxFRUV5SU8vUGdYZk83d0hpSVFudzJyU0pzZTVMWmZ5dmh1SUFCVFlQemVW?=
 =?utf-8?B?UW5KVGdGWDdJN3hHWFFJMWJxWHNFT202VVhTakFXNm13cHQ2QkxUK3Q3WnQ1?=
 =?utf-8?B?elB6Qkc5OVVqdHhieGcxV2NtT0xmekYvOVFEb0JPZ1VJUnRaSFlRdm1iVFht?=
 =?utf-8?B?bUZadG5FMU53UzhRNm02bmFRYTFNQS9uWlNIeTlEWktia2RnRlN4NkV1eWNH?=
 =?utf-8?B?SkQ4aEk1MDhrRm9YbHVuRHRPaThNYWx0L2JCdmo4aWR5a2t0U2FpLzc2UHho?=
 =?utf-8?B?WnFpKzdNYlNudkJCUStaOU9QK3F2UStPOFVnckRVRFg1R3dYMXBBUlI2VUVS?=
 =?utf-8?B?cFljUC9SeWpLZFJ4NGF3c2dOYUNLc0p1bWQvVzNhQjBtZXBMZWZET1NBV2hZ?=
 =?utf-8?B?U1psQ2JDZTdPN2NlS0JHNkw4VFhnK3hvbE85U0k3eDBxZGNxSWNNdGZCRjZu?=
 =?utf-8?B?SEFuSXRvTEtLYmRkcTNZSzhEem9Ga05TYjRmY3ZjYXhVWlNodzQ0OWJENUNK?=
 =?utf-8?B?TmNiUVFiK2s4Ykk1dDNYT0pPSjhkNlp6N05GeWVaVW5DMDNUN3RSbWwydkg0?=
 =?utf-8?B?RG9PSXFwZ2ZDK3hUVUlZVkh1UjlBeWc5MGMrL0xOTnRUUk9hYURGSnhLei9S?=
 =?utf-8?B?Z3ZmZm5DYWlvdE9aS3FRQkZtcW9mNytVRk9rb3lGOGRDdzZEajBmanpqd0NN?=
 =?utf-8?B?THNqNE5lMktvdTd3ZmY1VVdyTm9BcnhRTHdzQVVOV0d2bHhTMmhQbkRoMEpy?=
 =?utf-8?B?WlZ4eDY2V0k4ZGpuZm9QbnF6QWM4U1BMNWZyTUpiV2ovMzBSNW15ZlhxV2p6?=
 =?utf-8?B?bnVDdUhMbTRYRUhmQ1BuVUpGSHRDTi85cmxOSjEwQkY1ZjdaZ1d6L3lPNFdv?=
 =?utf-8?B?MXFaV2FxcnRzL3VpVjU3RFA1UVFhcWRLeHFQQ2ZCNVdCWjBtZHNMTklhUDcr?=
 =?utf-8?Q?zXItL5xXBSwvPw22TqeFhXKfP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522359d0-2306-4b23-1719-08de0d32a323
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:07:07.1617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBqOFHTHSa/1zE04xTRuyRwxcUY2MwLWxf4ginUtD4TprCS9sETTGhocpRlo5Ws+5UVXn9oGRJj+JDxEl5ft8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233



On 6/9/25 12:00, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>>
>>>> Ah this is an actual problem, this is not right. The PCIe r6.1 spec says:
>>>>
>>>> "It is permitted, but strongly not recommended, to Set the Enable bit in the IDE Extended Capability
>>>> entry for a Stream prior to the completion of key programming for that Stream".
>>>
>>> This ordering is controlled by the TSM driver though...
>>
>> yes so pci_ide_stream_enable() should just do what it was asked -
>> enable the bit, the PCIe spec says the stream does not have to go to
>> the secure state right away.
> 
> That is reasonable, I will leave the error detection to the low-level
> TSM driver.
> 
>>>> And I have a device like that where the links goes secure after the last
>>>> key is SET_GO. So it is okay to return an error here but not ok to clear
>>>> the Enabled bit.
>>>
>>> ...can you not simply wait to call pci_ide_stream_enable() until after the
>>> SET_GO?
>> Nope, if they keys are programmed without the enabled bit set, the
>> stream never goes secure on this device.
>>
>> The way to think about it (an AMD hw engineer told me): devices do not
>> have extra memory to store all these keys before deciding which stream
>> they are for, they really (really) want to write the keys to the PHYs
>> (or whatever that hardware piece is called) as they come. And after
>> the device reset, say, both link stream #0 and selective stream #0
>> have the same streamid=0.
> 
> Ah, ok.
> 
>> Now, the devices need to know which stream it is - link or selective.
>> One way is: enable a stream beforehand and then the device will store
>> keys in that streams's slot. The other way is: wait till SET_GO but
>> before that every stream on the device needs an unique stream id
>> assigned to it.
>>
>> I even have this in my tree (to fight another device):
>>
>> https://github.com/AMDESE/linux-kvm/commit/ddd1f401665a4f0b6036330eea6662aec566986b
> 
> I recall we talked about this before, not liking the lack of tracking of
> these placeholder ids which would need to be adjusted later, and not
> understanding the need for uniqueness of idle ids.
> 
> It is also actively destructive to platform-firmware established IDE
> which is possible on Intel platforms and part of the specification of
> CXL TSP.
> 
> What about something like this (but I think it should be an incremental
> patch that details this class of hardware problem that requires system
> software to manage idle ids).

(I know it is not a real patch but I gave it a try anyway)

> 
> -- 8< --
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0183ca6f6954..2dd90c0703e0 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -125,17 +125,6 @@ config PCI_ATS
>   config PCI_IDE
>   	bool
>   
> -config PCI_IDE_STREAM_MAX
> -	int "Maximum number of Selective IDE Streams supported per host bridge" if EXPERT
> -	depends on PCI_IDE
> -	range 1 256
> -	default 64
> -	help
> -	  Set a kernel max for the number of IDE streams the PCI core supports
> -	  per device. While the PCI specification max is 256, the hardware
> -	  platform capability for the foreseeable future is 4 to 8 streams. Bump
> -	  this value up if you have an expert testing need.
> -
>   config PCI_TSM
>   	bool "PCI TSM: Device security protocol support"
>   	select PCI_IDE
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 610603865d9e..e8a9c5fd8a36 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -36,7 +36,7 @@ static int sel_ide_offset(struct pci_dev *pdev,
>   
>   void pci_ide_init(struct pci_dev *pdev)
>   {
> -	u8 nr_link_ide, nr_ide_mem, nr_streams;
> +	u8 nr_link_ide, nr_ide_mem, nr_streams, reserved_id;
>   	u16 ide_cap;
>   	u32 val;
>   
> @@ -74,14 +74,13 @@ void pci_ide_init(struct pci_dev *pdev)
>   		nr_link_ide = 0;
>   
>   	nr_ide_mem = 0;
> -	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val),
> -			 CONFIG_PCI_IDE_STREAM_MAX);
> +	nr_streams = 1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val);
>   	for (u8 i = 0; i < nr_streams; i++) {
>   		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
>   		int nr_assoc;
>   		u32 val;
>   
> -		pci_read_config_dword(pdev, pos, &val);
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
>   
>   		/*
>   		 * Let's not entertain streams that do not have a
> @@ -95,7 +94,65 @@ void pci_ide_init(struct pci_dev *pdev)
>   		}
>   
>   		nr_ide_mem = nr_assoc;
> +
> +		/* Reserve stream-ids that are already active on the device */
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);


PCI_IDE_SEL_CTL


> +		if (val & PCI_IDE_SEL_CTL_EN) {
> +			u8 id = FIELD_GET(PCI_IDE_SEL_CTL_ID, val);
> +
> +			pci_info(pdev, "Selective Stream %d id: %d active at init\n", i, id);
> +			set_bit(id, pdev->ide_stream_map);
> +		}
> +	}
> +
> +	/* Reserve link stream-ids that are already active on the device */
> +	for (int i = 0; i < nr_link_ide; ++i) {
> +		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 + i * PCI_IDE_LINK_BLOCK_SIZE;
> +
> +		pci_read_config_dword(pdev, pos, &val);
> +		if (val & PCI_IDE_LINK_CTL_EN) {
> +			u8 id = FIELD_GET(PCI_IDE_LINK_CTL_ID, val);
> +
> +			pci_info(pdev, "Link Stream %d id: %d active at init\n",
> +				 i, id);
> +			set_bit(id, pdev->ide_stream_map);
> +		}
> +	}
> +
> +	/*
> +	 * Now that in use ids are known, grab and assign a free id for idle
> +	 * streams to remove ambiguity of which key slot is being activated by a
> +	 * K_SET_GO event (PCIe r7.0 section 6.33.3 IDE Key Management (IDE_KM))
> +	 */
> +	reserved_id = find_first_zero_bit(pdev->ide_stream_map, U8_MAX);


pci_ide_init() is called when PCI is probing and at that point no stream is enabled so reserved_id ends up as 0.

Since my platform only wants 1 stream, should I have called pci_ide_init_nr_streams() with "2", not "1"?

pci_ide_stream_alloc() fails to find a stream - fails in:

  struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
          pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);

as nr_sel_ide==1 (my EP has just one stream). If I go with reserved_id==0 and set ide->stream_id=1 in the PSP TSM driver, then streamindex#1 gets programmed (which is beyond the end of IDE cap) with streamid=0. As if reserved_id is actually reserved_index but the device wants me to reserve an ID.

We could simplify it by assigning something like "255" to all unused+disabled streams. Thanks,


> +	if (reserved_id == U8_MAX) {
> +		pci_info(pdev, "No available Stream IDs, disable IDE\n");
> +		return;
> +	}
> +
> +	for (u8 i = 0; i < nr_streams; i++) {
> +		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
> +
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
> +		if (val & PCI_IDE_SEL_CTL_EN)
> +			continue;
> +		val &= ~PCI_IDE_SEL_CTL_ID;
> +		val |= FIELD_PREP(PCI_IDE_SEL_CTL_ID, reserved_id);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +	}
> +
> +	for (int i = 0; i < nr_link_ide; ++i) {
> +		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 +
> +			  i * PCI_IDE_LINK_BLOCK_SIZE;
> +
> +		pci_read_config_dword(pdev, pos, &val);
> +		if (val & PCI_IDE_LINK_CTL_EN)
> +			continue;
> +		val &= ~PCI_IDE_LINK_CTL_ID;
> +		val |= FIELD_PREP(PCI_IDE_LINK_CTL_ID, reserved_id);
> +		pci_write_config_dword(pdev, pos, val);
>   	}
> +	set_bit(reserved_id, pdev->ide_stream_map);
>   
>   	pdev->ide_cap = ide_cap;
>   	pdev->nr_link_ide = nr_link_ide;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 45360ba87538..6d16278e2d94 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -545,7 +545,7 @@ struct pci_dev {
>   	u8		nr_ide_mem;	/* Address association resources for streams */
>   	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
>   	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
> -	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> +	DECLARE_BITMAP(ide_stream_map, U8_MAX);
>   	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>   	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>   #endif
> @@ -617,7 +617,7 @@ struct pci_host_bridge {
>   	struct list_head dma_ranges;	/* dma ranges resource list */
>   #ifdef CONFIG_PCI_IDE
>   	u8 nr_ide_streams; /* Max streams possibly active in @ide_stream_map */
> -	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> +	DECLARE_BITMAP(ide_stream_map, U8_MAX);
>   #endif
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>   	int (*map_irq)(const struct pci_dev *, u8, u8);

-- 
Alexey


