Return-Path: <linux-pci+bounces-29110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9F0AD07EF
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 20:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3A4189B50B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD388433A6;
	Fri,  6 Jun 2025 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y5EF/js/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056642AB0;
	Fri,  6 Jun 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749233810; cv=fail; b=r+cuKa/uXqS/eQ7aaJjvzigRS9tnzwcnN08+mpMqOAdkRkVJK0IFgbqqKjXvtaMEyOvSZcm20TVsfbynme3Ze4tQIudiBQE96UpeqiGmguciEP0LwgKtLAJnRgRlthG5V64OiDL3Xjt0ZA70HoAq4Ys82qhmVSdFiX4zdJ9K7nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749233810; c=relaxed/simple;
	bh=pONyq/+K2cRz5oPShAOmm/7br43tvxCW9tzMdAFNKLQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DI25iCT9DZhYD8zmQgt29vLDLC4GSjLMyk2W1FMkSsQbzYbirw+tATvq06iOA1+RzS40iHLScC9Jru3eno4PDlp0sEKa4Wn2Mp28t6C4rZZ6qSmv7xqk8VGtvuU0Vo0GHjX9dKrzCFbEuij31FYjm6JIfHZesDMkuBo8LSK7cno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y5EF/js/; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/HB7bG8dlISD1/7pZ7HmvwyY0FxUTKO+hvegChMMZKGYuLGnXTa9Dk9vMsKVR4glieuFWHrm/vH7CTw/Mfwuv5w3AQ87/Gj59KwAEQIP65VS2xdvMAps3HiWROQuA0jvTxeFmKKmq+rYMIoCpYVAQ5htI9xHqbP3HqScQ+LZl1m49ZeNrT1kuBw9KzgPkya3KKFYhu7HhGIQuL8uv7JRyAGYERmP56sypOxAbfGNRXMYxJ31s1A6XBkKWcVGsiiZkR6oCK09fv3uHSTh2nb685hHnVzYa/BiAPw7DIf27Bep3JYCF6JhiHHFb1XfGv5CKJtOqoWZM8t49zvvQsjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Mtk1WntZIlSbHZnP9izWpWKfdjDXMNZm+416XUwHaM=;
 b=fNGsTOJqYWShVbgeu7Cw9qF2pgSMCxv0diDu6Uvplow75oJdjNWEGwuId7TDrDgDgpvxIxOaMPBs4bVtv7PEFD9hjnGpLbqcvNTuP5sZVdPWznjH+CE7NJAIkOfs7S/6Qr/EdVWaC4LpIcH/db41ufQ0Uy2kzd2ZXwfBpO659gEdQXQA3E974N6dffP/KaEliaoGw08gF8R+BpOkDy+MwtmqJhMCS8/kb6MWEK1N8Yd/vmUI1+Z4sbXvx6bQrvOYJw9ZU1EJvVoeNlkhMM3Q3ow6IwFAFJbfMZfFswKlCV2J9c8cLJe1gBtXpU2k1P651oMmcZuF06/HwWfv7ycexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Mtk1WntZIlSbHZnP9izWpWKfdjDXMNZm+416XUwHaM=;
 b=y5EF/js/Aqq6CrHGH2SS2r2WGKuffqRjooTyWRc1Bf3I6tmo3KraUcslxPEkkeSAU7afEYeW3XMVLRrHJhYOASl9b2lyUunHW3nb51KAIUPVZ/9u+2xaQuInmtJ/BRK+w32EG3DdqdCtWwahp/RNn5J/6EZmD6u1rEJ3VEJ5IlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 18:16:45 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 18:16:45 +0000
Message-ID: <10eb2550-e0c8-4156-8810-213a364403bd@amd.com>
Date: Fri, 6 Jun 2025 13:16:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/16] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Dave Jiang <dave.jiang@intel.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-6-terry.bowman@amd.com>
 <02f8b7dc-b9e0-4b0d-bbd4-b0fa66715208@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <02f8b7dc-b9e0-4b0d-bbd4-b0fa66715208@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0191.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 3949ef2e-6b3b-4b0a-ae84-08dda5264b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmNnaVVwdWNMcVMwL1pseVJYWWQxQVVtdFE1WXB0NTdDdDh4eG45bk5aUHly?=
 =?utf-8?B?SUpiN3VBS0tGMU1MSUlsWVFDREkxY3BVUS9sZmlndzE5dFdXTVpNdUFqMEV0?=
 =?utf-8?B?WThaMFp3UUtNbzVkaGthVUY4elU4OWFhVCtzNVd5Q3o0bjJWLzhNYzlKUFdC?=
 =?utf-8?B?S3hxNnB5YTA1WmNRVWd0eU85a3RzWlZVaGhvQUpPeWovMXFZSy8vakxwcVZN?=
 =?utf-8?B?YjZFbUhzTlkzL2FsY0xXMlRGR3VHRkVqcy9od2Q2RDZXZHJuR2wrSXc3WjFG?=
 =?utf-8?B?VDZyQVdETWhmYjBGeWtKUWgwck83SzVubjRZY3Nqd05ocURHWi9Na2ZtQWtw?=
 =?utf-8?B?OTFwUWdsRjFCTWxUaFB6OTdiM3pqcnh2dzdnL1ZZTDdZZ3JPcHJkb09hWUht?=
 =?utf-8?B?NGdqY0dFZzFsdTQ5SUZlT3NQcG1DM1M1WjNzT2xhWUxENWJIanIxZmtUMWRk?=
 =?utf-8?B?MTlxdXVJUHloRmR1NVN1UXlEWmFWd2VGaWcyVlR1QW1hVXRQNHJJbXZuNDdz?=
 =?utf-8?B?K1A2aUZ5aXg0dHZJSjlQL2M5V0xPTjE1bmROMkl4blVDSlF1Z0I1cHZ6Yks1?=
 =?utf-8?B?U2NuNHJKVUM0L0YyWkZqaWpNd0FiUlhFVjZGSXV0d2VTdHJHSFBDNmlGVkU2?=
 =?utf-8?B?T3UrZHJUNWw0T2FLSkhwcnJQK2dURmFJQ3NpNnEvckZDQkV6TWZHcjJUL2Y5?=
 =?utf-8?B?RlY1UGtiT3BtTFBHTFJIemFiR2ZsOG9oRnh0RWE5Z0tMaC9pZWcwSjdiRlEy?=
 =?utf-8?B?ZU9KYTMzajgzdENZSTdvNTlLK0RnZ21rUlhDZGlseG5EZFlsUDF3dUVsaTNx?=
 =?utf-8?B?WUEzMTVXc2xNb0ozdDF1UkVKbHpGbkxBVk9hMmM0NTJRa3hwMHFNSnN5VzEw?=
 =?utf-8?B?Sk0zV3pFNjVndWxuclFycVlEYlZZWitjSDBTSVdHUDRCZkgyZEYwKyt2V0RL?=
 =?utf-8?B?T0U0Tm8xOEdLYml5QUZQMDRwRTJLVE5ya3lUTklmN1NRT3BYZVFZeEpWV1Bl?=
 =?utf-8?B?U0JETUd5alU1cjRXd1lpcExIdC9IUm0rczR4ZDhBNVpWb25OUWpkU1pBU1Jy?=
 =?utf-8?B?SHVxUVlvbVJRMWI5eGJvR1ZpQWdsZVMzVUEzd05FczJ4b2djWE13bUk4MDFX?=
 =?utf-8?B?Q0tXaGQxLzVEZ0ZJSVZKcEJ0ZkEySm0xRHdoZ01WZVEzWTJHQzJyOVgxSFZi?=
 =?utf-8?B?QlM5YU8rNngrUkZFZUozS3VqbkhsdDRmVkxvRzRSSWE5eW9QL0VhRFRCV082?=
 =?utf-8?B?WWY0RGxpTjVIQVVSd0lTU2lxdVFwR0RYV2g0ZENMOXdmQnNuQUxZbG9wK0Ey?=
 =?utf-8?B?SzZxdFpiSE0wRnhoakRTUnJqMW9TUmF3OW0yMm1yT053VVdrVU8xWGtjOVc0?=
 =?utf-8?B?T2hDV0JEUG11VjZMZ05ZMlhOb1dGMUh2VitxWStJa0U3ZFV6ZGppOVQ1ZzRX?=
 =?utf-8?B?aS9TaGJtc3B0amp5ZHJDcTd4QXRmb01RZ0VpOW95blhGMGMxalRBL3BOMjdG?=
 =?utf-8?B?OTdUUTBtYk1EcjFnTnVFWnVaeEE3YmI5UUlQbVRjakNWREUydVBrV053TEZz?=
 =?utf-8?B?bUE5LzBSdUVFMHh4NE9DTE1rRm5pVWt1TVZmdFo3Q2VtWU9qK1dMVFIrVE5t?=
 =?utf-8?B?WXFTMXk3VU5zeUJNQUp1a2tqV1NZSjJIWVZZOGw0TU5rNzBiTjE1bW93T3Iy?=
 =?utf-8?B?M1VGMFlxUWZRVTJsNlc2bHdPWDhsRjdpaGhSR3g2anQ1TDZrZHcvVzdjMWdT?=
 =?utf-8?B?dUI4T1VKcUx2cHZOTCtuYkJrdUUzbFlaeXdmUkwzOUdMZ29mNmhoZmdBU2U3?=
 =?utf-8?B?LzgweWlEc0RhUEk3ZmxabjZONDVDWDg3NzJPQTVKb3NWZHJkaFh2ZUladUF3?=
 =?utf-8?B?cUF4ejF0ZzdmMmVCTm5WM0FCTzg4dDk0eTFPZVBKL0FQclVHQUlmMHhNV0xx?=
 =?utf-8?B?VGVET3NmMStFeW05czNaV2xCQVBKYjlZOUd3OWFnSDg0VmduTzhIdHdJRkdM?=
 =?utf-8?B?M016YmlOTU5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWRPOWJGN25ScVRsMU5wMHRCUDhGWGFUOEFwUDB6Q1lzeXN4dnNwTXp0Tksv?=
 =?utf-8?B?ZXNyeHYvWXRGa21lOHhqVXdtUElBR0hhdTZtWU85aUQ0YStvbG9QckVwNmFF?=
 =?utf-8?B?a1F5NXFsZUpNdjVjOUl4eTRQWlZrdWxITjRXQlNnMG0yUzRkaGxiZU1WVlB1?=
 =?utf-8?B?NklFMm1HRlVyT05LeHRYaTRRMURvZ2E3VnZnQU9HRXA4NXh4WG1oaVJ6azRJ?=
 =?utf-8?B?M2cvZmVtY1d2Sk1wamQ5bUp2T2VhekU1SEVCVithekJXc2lnRXVUaFN5Qnox?=
 =?utf-8?B?ZEFTbnVvUjBzZ3gyYUlPM1hIdXhxMXZUVStSMWJuZTRrbjg5eCtET0M1alRv?=
 =?utf-8?B?WnUwOXQ3UDZyeWRKQkpxd1VMSXZoVEJmNjNIYXlzS0RqNnBpNGZlSnVScEV4?=
 =?utf-8?B?VXJMVVd5VURZTllDeXFVTHFOOEVOeXdOeUkyL2cyMXgrWVBQalVUdjZ0Y1pn?=
 =?utf-8?B?cXV5N0tFRkg2RGdiWXV5WmFyUmpieXZ4STUyUjhYWW9jUGprSmtZUFZDekd1?=
 =?utf-8?B?NWdNU2o3NkhoVGJoM0VWMm9Eem8rMWtnSUJnRHVvL2xRVzB5NFNDTHZLVWVE?=
 =?utf-8?B?dE1nWjg4QzhtYjRUcW90bTErZUY4UmZDalF4UHd0TjJhamxQWWNJVHNnTDU0?=
 =?utf-8?B?T1FCRlBXSUxWbHlENThUbFhyZTE0ZUhpM2dHQTVUUXJDdytvaWNFWGJHWDF5?=
 =?utf-8?B?NzVSSDZBVm1ldWFyQ04xbVE3RC9uYlcwRS9OVC9ieVBGbGZCQWlFQi9HVERu?=
 =?utf-8?B?L1J6VzQwblJHN2pRRG5zczdVdUsrdzBlcXJjcytlbmxrZDVxL3I2NTZ1Yldn?=
 =?utf-8?B?cHAxVDRhQSszOGRYSC9DalVJbEtmcTlaRXFKSldFSmJRVzVSVi9YSksvZjcr?=
 =?utf-8?B?Uml4ei9NenFYdFErMm9lK014WWgyZDZYVDdla1dMbHZreWE4ZEl1cmRkcnhn?=
 =?utf-8?B?bFFqMENoSGhrVUx6a1o0akNXNDRHUVNCamI0RHpxVnhQck9oYkVtT1dDckh1?=
 =?utf-8?B?aTE1aXhoME5zek5ucmtGRlI5THR3OEsycGkyU2NoWmhqanNuNXVWYmg4VVdS?=
 =?utf-8?B?YVVycVYybnhBRU0vZTdMc2MxWTN5aWRRLzZUVHlrOUt4V2txRWhKY01PM2NG?=
 =?utf-8?B?MUFIdVV5bmVrV29KUWUvK25idm5HMTU0TitzY2lWM1Q3YjBQbXZEOEExb0h4?=
 =?utf-8?B?YlRqM0hVSGhpSHhBU3V1YWU4YVVpSGlFdkhPTVAzRENzNENaQiswUDhNc3Jp?=
 =?utf-8?B?ZUM0NllJdmFKSXJ0VTE3ZU8zaHdGbFAyd2NtKzU5dkswYStpQk9YSXQ0Q2F6?=
 =?utf-8?B?QzZvWlgyWVo5eTdoeGFnbXJIb05qQkVCTmhQZHhEVUNJTXJHa21YVFZHV3pG?=
 =?utf-8?B?OUdjeUZKUWxDR0F6cUtNem9zRGxIOFMxbjNtY1RFUlBzR3pzblkyeUF2dklD?=
 =?utf-8?B?Z25STTVtY3FWdEp5MVBMcWJHVHI0eElOZU5jc0RoTllwQ1pCOElCaXk0VHdM?=
 =?utf-8?B?ZkxEOEVaaVFEWE5pWnloelFVR2h4SUE2N1dPUHRuZXlsZUhGS3UxUmpuSzd2?=
 =?utf-8?B?YUFxNDBld043NmcvWGJRQ2RKY2xsMEt6dmtqQ2tkaUpvRHhHSVBVaEtkSnRk?=
 =?utf-8?B?TWxxYS9FV1lSZFBscUxsOG5BY0ZDZ0hSZk1DZDlUc0Z4czZpaDBxcXZNbmUr?=
 =?utf-8?B?TEp5TzRWV1lWWHVYSTZxc095Vm9sR2NYQ2dKZTQwWDZWSlFxNDBHenFPZ21r?=
 =?utf-8?B?VkpsZGplK1FSMWVXM1E3V0lCbmJQVlZiSnlhdGcvQXY2d2xxYlFiYUFHa0py?=
 =?utf-8?B?Tlo2Wm5KamRCdXprUlpyZTN5Y3ZieVViQ0dJMzNMSFFkakgwMm5qZUFNOTAr?=
 =?utf-8?B?UEd0dFZPeUxZZDF6Ti95Vi9YTnhtVEhqYXhUSno5SXZleTh4RjR3bnUxTjQy?=
 =?utf-8?B?aGY2QjR2VmFLdWV0dXI4b1BsRkRWcFdSYkxnZEkreHBBaXZNNHNXS3UrRnlR?=
 =?utf-8?B?YkQvTTFMdk5obTluNTV1cTl4RFZLemFSKzBLVjNWSTM3UWt1MytHQ3MySDdZ?=
 =?utf-8?B?M2krZGMyVXlxZUxIdHpaWkxGY3gxMWtidlFWdWlZbldjditQR09VY0l0NkFK?=
 =?utf-8?Q?Zwo+vyIs3ZzUVP/N49xzyILWG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3949ef2e-6b3b-4b0a-ae84-08dda5264b7f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 18:16:45.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wpFuNd9Odn095/IxqZ8tu8Ps3hZOye8k9tYMbSfpr/xq1TecVqN/BTj7Ir+ibI9F6ma9xYuoG3zDDXstjMDfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065



On 6/6/2025 11:45 AM, Dave Jiang wrote:
>
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
>> handling. Follow similar design as found in PCIe error driver,
>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>
>> Copy the PCI error driver's merge_result() and rename as cxl_merge_result().
>> Introduce PCI_ERS_RESULT_PANIC and add support in the cxl_merge_result()
>> routine.
>>
>> Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
>> first device in all cases.
>>
>> Copy the PCI error driver's report_error_detected() to cxl_report_error_detected().
>> Note, only CXL Endpoints are currently supported. Add locking for PCI
>> device as done in PCI's report_error_detected(). Add reference counting for
>> the CXL device responsible for cleanup of the CXL RAS. This is necessary
>> to prevent the RAS registers from disappearing before logging is completed.
>>
>> Call panic() to halt the system in the case of uncorrectable errors (UCE)
>> in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
>> if a UCE is not found. In this case the AER status must be cleared and
>> uses pci_aer_clear_fatal_status().
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/ras.c | 79 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci.h    |  3 ++
>>  2 files changed, 82 insertions(+)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 9ed5c682e128..715f7221ea3a 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -110,8 +110,87 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
>>  
>> +static pci_ers_result_t cxl_merge_result(enum pci_ers_result orig,
>> +					 enum pci_ers_result new)
>> +{
>> +	if (new == PCI_ERS_RESULT_PANIC)
>> +		return PCI_ERS_RESULT_PANIC;
>> +
>> +	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>> +		return PCI_ERS_RESULT_NO_AER_DRIVER;
>> +
>> +	if (new == PCI_ERS_RESULT_NONE)
>> +		return orig;
>> +
>> +	switch (orig) {
>> +	case PCI_ERS_RESULT_CAN_RECOVER:
>> +	case PCI_ERS_RESULT_RECOVERED:
>> +		orig = new;
>> +		break;
>> +	case PCI_ERS_RESULT_DISCONNECT:
>> +		if (new == PCI_ERS_RESULT_NEED_RESET)
>> +			orig = PCI_ERS_RESULT_NEED_RESET;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return orig;
>> +}
>> +
>> +static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
>> +{
>> +	pci_ers_result_t vote, *result = data;
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
>> +		return 0;
>> +
> Lock here before getting driver data instead of later?
>
> guard(device)(&pdev->dev);
Ok.
>> +	cxlds = pci_get_drvdata(pdev);
> Add a comment for the ref grab
Ok.

> DJ
Thanks Dave.

Terry

>> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>> +
>> +	device_lock(&pdev->dev);
>> +	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
>> +	*result = cxl_merge_result(*result, vote);
>> +	device_unlock(&pdev->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void cxl_walk_bridge(struct pci_dev *bridge,
>> +			    int (*cb)(struct pci_dev *, void *),
>> +			    void *userdata)
>> +{
>> +	if (cb(bridge, userdata))
>> +		return;
>> +
>> +	if (bridge->subordinate)
>> +		pci_walk_bus(bridge->subordinate, cb, userdata);
>> +}
>> +
>>  static void cxl_do_recovery(struct pci_dev *pdev)
>>  {
>> +	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> +
>> +	cxl_walk_bridge(pdev, cxl_report_error_detected, &status);
>> +	if (status == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
>> +
>> +	/*
>> +	 * If we have native control of AER, clear error status in the device
>> +	 * that detected the error.  If the platform retained control of AER,
>> +	 * it is responsible for clearing this status.  In that case, the
>> +	 * signaling device may not even be visible to the OS.
>> +	 */
>> +	if (host->native_aer) {
>> +		pcie_clear_device_status(pdev);
>> +		pci_aer_clear_nonfatal_status(pdev);
>> +		pci_aer_clear_fatal_status(pdev);
>> +	}
>> +
>> +	pci_info(pdev, "CXL uncorrectable error.\n");
>>  }
>>  
>>  static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index cd53715d53f3..b0e7545162de 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -870,6 +870,9 @@ enum pci_ers_result {
>>  
>>  	/* No AER capabilities registered for the driver */
>>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
>> +
>> +	/* System is unstable, panic  */
>> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>>  };
>>  
>>  /* PCI bus error event callbacks */


