Return-Path: <linux-pci+bounces-21293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36105A32BD4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 17:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD51188B0C2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B7256C67;
	Wed, 12 Feb 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RhAM3AQD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5B20A5DD;
	Wed, 12 Feb 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378093; cv=fail; b=mnWTe9nkISxS749g71gcxsSN50XvWFIw45sfk4gWkHCuNdlmpUnk6Dpo3XmuSGPkggmG0dKIab5FnPck4O8BrSQudBH/9MatssBhcszKrptR1rd57OqaeYYLSokn+/WSOFPIsWEFBt/rxZ4mUnCGWJXpQ2w3nTW0pjG4BzDOM8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378093; c=relaxed/simple;
	bh=j8Y6/cNty8+2rNhSPpIjnzgIHBLCrTYAncnmTqkhVXM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mXGdz4CwwEBhJC+TTH4QapvzFzEPx9JltfNXEMMYyZLzyNtWZTwt4zORCQb+WUSRbP3ByA9Mkt5nSHnB13f+pW29QUTyLVDd8RQsXLDFXknxznpLHWpEjcg/Y6k1SmR4jTWRRdq1sSGyr7blwxYC8grDa0+bvG0/ZnWXXyvFRJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RhAM3AQD; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HV5mr+JMCR0aNXT1u3GX1vA2MxTPCxNaqogGRpn2bGQRgq5I7oP2RjhE4VRgRgDmB2ZbGptvtuhdOsBNm/lWBGOi7UF/SG+EG8aPybn8CTJ/NV+SbwOM9NOasYR6VTHL6JHS7NI2vQElE39AIdzeMWD5l5gIwZ9aPsXHIqJVtphKXbqXnmdbtJNVUmbRMfJZ3qZoxMBlXtYWCno44vvJDMvuls+ZFRKXP0leLlIR1B3ygUEGJufwy6kSwFQc4w2fwHmSUmoNN/NRuFsA7qHvjY8WRWsNoPDfTqoZ38vSxIucQ2SaLqpkLDORbZwIX2YuSCEiaozGq9HtY0LvxcXGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO9cUFtk1dwBOc4A98aowCcuGCp1pwdlozEN/DKniq0=;
 b=TYKcIg2rU59h0OsrDySJBt7KpXQFhMcwWPcR4GUr6sn8S+s+lZBnPP+fStMQgF1OLJ2VoZSbwjIKoZP2ly658293IgJxMPGXVDBznez83o05e6R7dj5P+UbHtjFij1RyNA/S6DBQgsqQCLfu7jVr6XdhC0LdtnbAo9+5DO5iTExxXBrwtVpntjU2oUhpaLuzMeY6HoxWIWgv3XK9878ydG/DzIOopbNRr5gXkrKsC/MMiDxV5xJl5267cJyibN446EQoT+YIPdT4wrmYe2r4B54aUuxS2b4+j1tFnT4Qq7IJDLLAdmd6nObkXnLDKUGPiINgGkeeUwad+1CdpiuTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO9cUFtk1dwBOc4A98aowCcuGCp1pwdlozEN/DKniq0=;
 b=RhAM3AQDHWy3SZVCGnM05WYoEQyJspO0O5FfsXwvBmAJwmUtjZ0UYwwRxglBSeDE9/FJNQSqa6fV+NbGGroTGm426JiB5bOGgCsnX8N5VqjgxgkqTNlcd//EcX4dJEyD0zl5mWh46TGXVnoUVeA3CNTMc3tzgIEk0EEZEpkIM68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Wed, 12 Feb 2025 16:34:49 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 16:34:49 +0000
Message-ID: <6d53691a-c127-44ec-99aa-f2d98124a961@amd.com>
Date: Wed, 12 Feb 2025 10:34:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-13-terry.bowman@amd.com>
 <dc7bc625-0a14-4d25-9211-2e0639f02566@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <dc7bc625-0a14-4d25-9211-2e0639f02566@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::19) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: b777dcfa-bf65-4084-9e59-08dd4b832b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEtjNmFaUzVWYkIzQTNPNjdoL2pkRmtkeitqdmQ0bHFDY1J6anBTSUEwMVVV?=
 =?utf-8?B?QzJ5bUxaN2dvRkQyZjRsN3ErNG5VVFlUNUJrd0ZTWnEvMEFCNjQzL2FYYWlB?=
 =?utf-8?B?SHJvQVM5ZFhsaVJNTnpvdjZCWHNEcWRmTzF4Uk1kWjkxK2Q4V2NZcUp6QXg3?=
 =?utf-8?B?QWpPaTRiTERwc3YxQVZETGx5Vi9YNzZhRmp6eE12c2xjVWZPcTFiL3NrVmJh?=
 =?utf-8?B?bTJEZVRHUDgveVBnMDFQY25mY0M1L0U5ZlU2aUZHamVXY05OYzRSdFM4eHlS?=
 =?utf-8?B?OGszWW9WQndReDVtT2FaREFhblY3ZWdWT2d5aVJ1TGtSMDRmbTVBS3JMQnNI?=
 =?utf-8?B?QjdPWWpVWDE3YzR6RlFNd0hlUWxOSkpxTkNNdWp6SzNSck1JNGZFVUpMMExB?=
 =?utf-8?B?Y09DYzgrenlFZm1mT2svOWVZa1B3WUFOU3JCcGpFcEpjVmlONDFsbWs2alVH?=
 =?utf-8?B?NzhpZXJjb0NybmRvYzJybW5VOStCYlZOZG5zZmt0MHNPWEhVMUJuVVU3ZEhH?=
 =?utf-8?B?MVQ1bzBQNmx4MDVtU20yY2FidVhVTVBZZUV3TlZLMHZVU0RGT1ZKbWxzVFZK?=
 =?utf-8?B?OHl3dVdQTzBvZmtieHJEQUJ2ZzJwazBuTkZsTy91T09TSkpDS3dnc0xIMTNj?=
 =?utf-8?B?aVJNek82eWMwa0l1RGlvRXZjRjR1UWMwUTgxWFhIcmlsNjMreXFiWGhXNDBs?=
 =?utf-8?B?cmJ5VUxYeUJRN3JUQ00xSituUkdWNGUwUjY3UVBHbGU3c3BxUjFmWU9zbFhB?=
 =?utf-8?B?TWJLVHgxcUthK1BNd2FMNnRCbTZ3Y1cxR0F4TlhUWDJvSHBNeS9xMjVQaW1I?=
 =?utf-8?B?ZWdkN25PL0xod3E5VTBJK1V6OFhmVjFMNDZnTlBwZkl5OUxPcFpwOXZDNUdu?=
 =?utf-8?B?U0tEZEowVFM0YnFmL3Z0TmpGemJRSzN6eUVaZEh6NHB0WUIzZnFHYkhwT29E?=
 =?utf-8?B?UkJlaXlaVEQ5Tkw0Yjg4ajU2YlAzSFpHVEpwQU8rSVVJb0VTVXdubFdIN1Bh?=
 =?utf-8?B?QXlCekl2aFdvMWp6VkZZQ1RXYUVHL0lmdEhLSFM2VXFZdmhwQkFRVlFlNzdH?=
 =?utf-8?B?UjlrbldkTVNWelFxTXg0WE54SmN5aisyYzRhMGV4dUQ5blJSbWtFRjJNZGdK?=
 =?utf-8?B?dExJbFpwWEEyWXliQ0hWMURpV0xPVDAvYkZLNlpSVFpyZjY0c2daMzJFcitS?=
 =?utf-8?B?dDNibkdaaUg5VEt0WEZLc2JxL0EvdGRrVFhUWWtkandrMWtQNjV0dUprakM0?=
 =?utf-8?B?TjdnTnVnN0pIRUVoQXlHQTR6NVpzUzJzSWtpU0NxM0VFUnJNd1BCL0tSeGV3?=
 =?utf-8?B?UloxSW5SQ0E4ZGhKSDZnUHdIZEQrMk1LZ0dZTW5DaUsvbVZ1R1lLUXY1ZFJD?=
 =?utf-8?B?VlJnclFFZFRIejRyVUV2eEUzYURhbW1ETngyd2NKRzFmNDlibVA0Mm1zZWor?=
 =?utf-8?B?VGJnN1B1ZjZFZi9OZXhhVUswbzR4TkhMN1FGZE8xVTBaME56M3VybVRWa3lQ?=
 =?utf-8?B?NmdxUnBYUUUyNi9zQWF4VlVaN21uWmEyZEw3T0s4ZWdUYUJwNE8wM0dLZmVa?=
 =?utf-8?B?dWhzQ1JCb3o5OFdOUURaWlBNREFrL3J4UGpnUU9aL2syQkFLVzBHTVNSZTVu?=
 =?utf-8?B?SGpUMnA5T2ZXMDNxTmFPNGZjdEVMOFVUNGFiQVdVUVM0RGppd2NFWEU1SkFY?=
 =?utf-8?B?SytiZm9TNGNPV2x5OFBKZ2JlS0Q0NFBUYWZObGZGZ3dzVStSWnkyNlM1RmZN?=
 =?utf-8?B?d1Q2L3FTTlU5bUI4OU1WYUVHNnVmQ1hMT3hHNno0N0V4cUFJWGNreVkwK1kv?=
 =?utf-8?B?VEpscUZtZktPLzc2L3RKU2NjOWg4M2VoM3VyUkk0bndxR09aYVUvVER3UG00?=
 =?utf-8?B?eDNCZ2xsKzJ4VWVXdDc3NUhvOHJDUUhHRE1PUVZBcThjNWZGKzdWL1FqTUM1?=
 =?utf-8?Q?kEzpWK5dBfU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckJsQ1k5YWV1Um1WRklhdnNnanJsSHNkQmVWN244ekVVdEdhVDRNTUVMMlZB?=
 =?utf-8?B?ZEpRNmJEYW5NbjBNR2JvZ0c4TG01VXdNcDBRTUtEUWVvaHdQR0l5UjNzSTlx?=
 =?utf-8?B?eWlCRUtyUjNKRG1JT0hMN2V5ZjhQYXZYeC9uSVQ1dUxPZW5TSjRySjdITDRu?=
 =?utf-8?B?N1pDTDhhTFJ4N3hUVHBWWTBxRlhOTDZyWlRhTC84OGRyTnRVL1pYanIvWFNI?=
 =?utf-8?B?dk1RME5jUGduTGJFU2l1bGJxczQwYnZ0QW1OdFA0QTNmeHc1SnNRemVQTzUy?=
 =?utf-8?B?OGJVbnNVQXI0cU9lNUI3Z2s0U3U4RS9Rd09idWg1c2loMVN3SU8zalN4aXBp?=
 =?utf-8?B?RVZNa3FJUGpXNEY2djF2VTcwZ0RYUmp0RTE1ck04emVTVmtJZ3hYVWpndlNh?=
 =?utf-8?B?VmdJcVFTa3czQmpDQytOWnFVRUhKSE1hOVhENFU2SFBNMDZKLzM3QWlxRWUy?=
 =?utf-8?B?SytTOEM3V0ZRVTYxUjJzb1VtbDJQQUFFcE5jQ2YrZHFWczRhMDJTQ1o4WWZz?=
 =?utf-8?B?TVRKSXlNd1FQREZxRlhzNE1WbmFHSzhIazQyN05rZ3FrRmlNSUlCL29CZTQr?=
 =?utf-8?B?dy9uR2hNTkdWSlQzOWtmN0w3dFRIazhkUnF0UlNoTVR5ZTd6aE1yaWlPVC9w?=
 =?utf-8?B?WWRzQ0RGWVc3ZVhTS1k3SlhGZWFpUmcvSnFnT1ZTZ0pIWjVnazBKSnhrSHVU?=
 =?utf-8?B?blFYQzhsTXRtL0NxQy92YkVoUWphZ2xCL2lJVVF2Y2V5R3g4RE5QYWxoS3Bx?=
 =?utf-8?B?WlF3TWdOeWtmMWVxc0dyODAyaDdoeVhCdGQ3bXpJZERTc3FCRnFOREZ2MHl4?=
 =?utf-8?B?MmpieG5saXd3Y2NXMDNHS2V1Snc3US9BOGhlLzVsVktGc1kyaXU2aHRhQUIy?=
 =?utf-8?B?OEQwMFRpZnhzV0ttVXpFZm5EbkZRVnpIOVBDM2tQZHRYZEFUTG9CU0k2Y1hx?=
 =?utf-8?B?VUxKTGZDVUZJZjQ4blQ0a2V4dlYwZUVrZUFqY1NiMkllUnRaNkVPcXVxN04x?=
 =?utf-8?B?MGJlbG5HUDIwYnBjQVFhUXFOYUpqSDJzOHhmSHBHaDRZUGV0c0Jldi9HS2xY?=
 =?utf-8?B?MVV6VDZEemczSi9kTzAreDRIS21jN0xQUUJScGIrMGxyUUJDckNlRDIycld6?=
 =?utf-8?B?Q0NqNWhQMS9OY2RtYmZlK29EdW8vTnZ3QkxSTTRsdG1jaE9qNHdibDRXQmo4?=
 =?utf-8?B?WFRWT3RJWHZvaHRpYnVmNmRHRWVHSUNmTGpsMlhVM3F3cU5BbXdBZmJoSkhv?=
 =?utf-8?B?bTFYdGlWSFhVWVMxVlpyZmV1U3NycHFwQWsrNUdnbnpKNDVWSHo4OERTS1lv?=
 =?utf-8?B?TXYvKzBFb3RlNnZzemJQQk1aVFFNWTBjWjJMbGEvUDBhTFBOZjhhTVkyZ2x5?=
 =?utf-8?B?MjU2VEw2eU5mL0NkZUNPSGZqOGZSZjNsZzRabmZwVzlmV0VQYnZTeU9kczdk?=
 =?utf-8?B?L0lla3dvQkFkaHRTTUk0TjRzYUVmQU5qNUppN01SWTMzUWtpL2l3WEJ2UDhR?=
 =?utf-8?B?ditxa3FEMkZQMDdIdy9lb0syS2RLVTQ4MFRKTloyc2NpaWVpcWdoYy9PRGtN?=
 =?utf-8?B?eUdZdXZpQ1h5Y0RIRjNPYmhzb0lrQjRtcEJiVlc5ZG1jVDRwbVFNa09Na1E3?=
 =?utf-8?B?UkswM1M1V0pMdE5sdVBIcVVUNDVzTHBUMnAzZDRITjhRWXNJNVJQVEtybEg2?=
 =?utf-8?B?Qmt2SG02bWs1MzlmVmwzbXhOZTBONEEyY2owZmViY01vTnE5K0d2SHlLV2lR?=
 =?utf-8?B?d25YVG1YTkp0bGVRTjAwMXprSUJRa29STUppUGhzVzdqajl0RU9ldjRlRmxp?=
 =?utf-8?B?VGlHNjkrelZVMlYzRnlaeXE2WStkRXhtRDFFdVh6UTdGVGYxQnljcFhKUkJI?=
 =?utf-8?B?bkRpMytnSzVnMmc4bStQNWtnejM5bjRJc0tFS2p2bFl2eVJRM2RBTFFwNVVR?=
 =?utf-8?B?TnNTNDRGUDVXME1xb1Bka2xpYTdIZktBaVR0QXgxS0NzTGdCM3FCOG45dkNC?=
 =?utf-8?B?bVR6K1dPbVNxSXhaQnFmUWpsWEMwN3Eyem1wZzZpMm5HelYvc3AwY0cvanYw?=
 =?utf-8?B?MVRkcEFkTW56YjNKKzV0OEtCSVk0b2p1VmIyeDZIQ3N4OVF1Z1FGRlh3YThN?=
 =?utf-8?Q?tFH+tvZfFVlwxvmXHomBZZdfS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b777dcfa-bf65-4084-9e59-08dd4b832b0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:34:49.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gQkXedK1XCBRyapYoLhu3RdtSCX9rZYoluj+imsJNVIfAMJ3WK4JYWPH4CuVZVYWG9cXNBpQ5am00xoMtvBRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024



On 2/11/2025 6:11 PM, Dave Jiang wrote:
>
> On 2/11/25 12:24 PM, Terry Bowman wrote:
>> Introduce correctable and uncorrectable (UCE) CXL PCIe Port Protocol Error
>> handlers.
>>
>> The handlers will be called with a 'struct pci_dev' parameter
>> indicating the CXL Port device requiring handling. The CXL PCIe Port
>> device's underlying 'struct device' will match the port device in the
>> CXL topology.
>>
>> Use the PCIe Port's device object to find the matching CXL Upstream Switch
>> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
>> matching CXL Port device should contain a cached reference to the RAS
>> register block. The cached RAS block will be used in handling the error.
>>
>> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
>> a reference to the RAS registers as a parameter. These functions will use
>> the RAS register reference to indicate an error and clear the device's RAS
>> status.
>>
>> Update __cxl_handle_ras() to return PCI_ERS_RESULT_PANIC in the case
>> an error is present in the RAS status. Otherwise, return
>> PCI_ERS_RESULT_NONE.
> Maybe a comment on why the change?

Ok.
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 81 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 77 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index af809e7cbe3b..3f13d9dfb610 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -699,7 +699,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   * Log the state of the RAS status registers and prepare them to log the
>>   * next error status. Return 1 if reset needed.
>>   */
>> -static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>> +static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  {
>>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>  	void __iomem *addr;
>> @@ -708,13 +708,13 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  
>>  	if (!ras_base) {
>>  		dev_warn_once(dev, "CXL RAS register block is not mapped");
>> -		return false;
>> +		return PCI_ERS_RESULT_NONE;
>>  	}
>>  
>>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>>  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>> -		return false;
>> +		return PCI_ERS_RESULT_NONE;
>>  
>>  	/* If multiple errors, log header points to first error from ctrl reg */
>>  	if (hweight32(status) > 1) {
>> @@ -733,7 +733,7 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>> -	return true;
>> +	return PCI_ERS_RESULT_PANIC;
>>  }
>>  
>>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>> @@ -782,6 +782,79 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>  }
>>  
>> +static int match_uport(struct device *dev, const void *data)
>> +{
>> +	const struct device *uport_dev = data;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +
>> +	return port->uport_dev == uport_dev;
>> +}
>> +
>> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev, struct device **dev)
>> +{
>> +	void __iomem *ras_base;
>> +
>> +	if (!pdev || !*dev) {
>> +		pr_err("Failed, parameter is NULL");
>> +		return NULL;
>> +	}
>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> Can probably just do a switch block here for the type?
>
>> +		struct cxl_port *port __free(put_cxl_port);
>> +		struct cxl_dport *dport = NULL;
>> +
>> +		port = find_cxl_port(&pdev->dev, &dport);
> Just declare port inline:
>
> struct cxl_port *port __free(put_cxl_port) =
> 		find_cxl_port(&pdev->dev, &dport);
>
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find root/dport in CXL topology\n");
>> +			return NULL;
>> +		}
>> +
>> +		ras_base = dport ? dport->regs.ras : NULL;
>> +		*dev = &port->dev;
>> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>> +		struct device *port_dev __free(put_device);
> same comment here as above
>
> DJ

Thanks Dave, I'll incorporate these changes into v8.

Terry

>> +		struct cxl_port *port;
>> +
>> +		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
>> +					   match_uport);
>> +		if (!port_dev || !is_cxl_port(port_dev)) {
>> +			pci_err(pdev, "Failed to find uport in CXL topology\n");
>> +			return NULL;
>> +		}
>> +
>> +		port = to_cxl_port(port_dev);
>> +		ras_base = port ? port->uport_regs.ras : NULL;
>> +		*dev = port_dev;
>> +	} else {
>> +		pci_err(pdev, "Unsupported device type\n");
>> +		ras_base = NULL;
>> +	}
>> +
>> +	return ras_base;
>> +}
>> +
>> +static void cxl_port_cor_error_detected(struct pci_dev *pdev)
>> +{
>> +	struct device *dev;
>> +	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
>> +
>> +	__cxl_handle_cor_ras(dev, ras_base);
>> +}
>> +
>> +static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
>> +{
>> +	struct device *dev;
>> +	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
>> +
>> +	return __cxl_handle_ras(dev, ras_base);
>> +}
>> +
>>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  {
>>  


