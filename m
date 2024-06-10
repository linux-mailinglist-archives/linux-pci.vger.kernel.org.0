Return-Path: <linux-pci+bounces-8554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EA8902999
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 22:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347A42843C0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE478C75;
	Mon, 10 Jun 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4i7icznB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA91B812;
	Mon, 10 Jun 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049632; cv=fail; b=QvWEMrIkxjCOY2Qg5Xf009uCCcN1kmBMhq7fa+WPTlb0pRuYoDqJQzS2inz1M9VynZT6WtchuB9G1Xlp3Qjpju9ihkwc8FDr60BZYAcHuRs0Lt0TxruAirqU8UHrmKU+6ZftB1AoaZ/6Aa5rxLcJCnqW0M1ypdw38TW8NlWl6gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049632; c=relaxed/simple;
	bh=ACLlPUUFoxvjQFkBbMKc88M8sVAXVOnv23hkWIImG3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cRhraAl70JNB4Hpq4e+OByle8+jWlorUmXOWFXMSxeoFo0SkvIYyF6i15g4OVkVDuB6pHfvOWx0H5YhENbGNAItNa7zybhSNtGjB30o46oA+aLKgR9xFKcqDsCDADw7MuUlCkZEbHoAgaMgZfswQf13+DQedch9sc19Ia3akkUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4i7icznB; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6X8hCNhi0AStvNsF9jIFFk/DaKgMLcupYMTkxgZpq6DNdhZdcLWVrkHSmw+V2XFIwB82uNUWZgi0MdMYEReUCCrEASLdAVcuoIHZxAlsPGgbpm8stHJ3gZqhYHxkWAB9Fn8NWbdIrkjoqJ6KHqIdXncIYUSs0a6Dk4DSDFFwLRqJ3s8VJbUwxTx+Kvzm6e45d6hfY2kB8P7K4RE6UP4OMTR3E+/bfMdpY2Y/ENkAQo/NJ5/zWcJgaJ+66vDxN6KIttSPIgtOqlj+pz8IT5A6neNaQngrMUGy2KPznf9Mo1pyOTZLF29Nl3ybH/gUHJfQNj01klT7Gl47tC8jzmBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCBmwUCXd2kne5kMvUPJAN0zdWlSn9KM4SdufarSikU=;
 b=jjx8rveXoA9GB2wbpke+iZu91VkEDOesjGV1jAR8YUm3McRG1SkpZldVITmloAF3bZGz1dUyu1NoPQLbwXq5FyaCXM2FuXRmVzcdg/uTvsXSFhVKOl+rpZf5JoO/k5eu/YSVALrWywZJmuyVx/6MCo048qurhnuKTY8U7LMkcqCPnyPwW3/GJtLxEOFlsPZZhHwPgn0f5n1DaFgR01s6QEcOBYwcdbGSdrV0sLmjclU4Xp3dvyq23325jCKkn6KHFx7MX0MdNGqqIEwgSIncbi+G73lIzHHCNqbHVMD1jY3Ebgf3YGobsngsONM1F6BYz61wBJ/Xu5KDsrbXhopzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCBmwUCXd2kne5kMvUPJAN0zdWlSn9KM4SdufarSikU=;
 b=4i7icznBF9+9/SfGJu8e28Wqh+SqU7PR0hVcGIjebWJgSmKstBUcJu0xjGBUuuAkaIcg5xH5OQcCgQ4Kpo0Bw2dQck4IfQPh2w8g/s0yKokVdy5UlrbYLXIteOFdXZLWkKktDvgGYvGeAOEzRHwrcjU8b9OxrwHoTO8L9S9qk3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 10 Jun
 2024 20:00:26 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:00:26 +0000
Message-ID: <3221526e-8698-4930-81e6-715cf3f1a18f@amd.com>
Date: Mon, 10 Jun 2024 15:00:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/9] PCI: Add TPH related register definition
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, bhelgaas@google.com,
 corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com
References: <20240531213841.3246055-1-wei.huang2@amd.com>
 <20240531213841.3246055-3-wei.huang2@amd.com>
 <20240607171716.0000216d@Huawei.com>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240607171716.0000216d@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::20) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: a11574fc-efe9-473a-85f4-08dc8987f891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDRDMTV1WDNpWUFpdlRkc1I0ek9TZWVDRWdWNCtiZFRPbStjWFllSlBKOU9E?=
 =?utf-8?B?MGhTemZrSTEwU3N0U2tpMGlqNG5ZNWczRENadDZYQnU4NFN2Q0lGR0ZtV0gz?=
 =?utf-8?B?ZjR1elkxcUdlL0FZWXlHSWZHb0tLU3MycEtTWnBiNmxnbE9UME04d0MwbUtI?=
 =?utf-8?B?UVRwOXkwdGI5TmpvNVhiNWt1bHpkUnk5VHpxdDRoNTNQQXh4QlE4dUNFSk02?=
 =?utf-8?B?WGpvN09KbGVzaEEvL0N2bkVCYVBNdXZQa0JLVXBscm9Yc25BejcwVGhSSlJZ?=
 =?utf-8?B?N0VjNE4ydFdhQTFuTmdYZzZUdlJxWi9lc2EwbXFocW1EUGNGWndYTnVKemFE?=
 =?utf-8?B?azdERFkvTHZFK2ZYLzhsUXhNS3d1TDNYZS9USEdYT09DU2I1bjM5cUlubW1E?=
 =?utf-8?B?T05ZOWdFT0g4WGNETzBUV1B0eEVKdklqc0g1Vm1kZTNUNkE0ZmpDemRFcTY0?=
 =?utf-8?B?K0dJWVo1RTRNeE1JU0RZemcycGNPQWYzMFB3TVB3UDhxVXhiVmZxWEM2U0Zy?=
 =?utf-8?B?cGx2dkF4cE5wUEFKREc2LzNCZkQwU2Y0MVJaVXhXWWhDZnJmNXpJTW5DL0Rn?=
 =?utf-8?B?NmJ6MlhFMU5RdjhlZ1d4VkNEeDdvVkpwdGhyVmVNbEp2WWN4QjFYWmh2eVBm?=
 =?utf-8?B?dkY0a2E2OVMwbkdVN1p2UzM5NTBLQUNHbjBlekoydUJxM1N6M1VWS2NIYlpK?=
 =?utf-8?B?N2xIZ0tXbkkrSnZ1aTM2NytPRHVTVkN2OExpNHQxdmJFZzAyQmcwRTNYMStY?=
 =?utf-8?B?NHhBaFdqN0NRZzNZTHl0Qkh4OHFLZ3NqREp6N2JSV2R6Nm1mYlJtMW1XQ1hP?=
 =?utf-8?B?Sk5xaDR4ekVvWG85WThPZGFQTnBlSVlpcXhmMmw1MHNtSy9uQnpuWVBNT3VN?=
 =?utf-8?B?K3o5QWFodGV5REM0QVV1bUxQREcwcmdON0dhQ2xHbnlqWm52UGRGclBWeEVk?=
 =?utf-8?B?UlFGdTFsUnI5QTlZcHBjbWdRc0ZzN1kyWUJQckZXeXp1a1pFaFVEdzBBUWRL?=
 =?utf-8?B?M0lYRW1za0NtdEtIQTJ1TjZ0SWRTVXNJV0U4SWRKM1UzbDF1bDZXbzVYTDZV?=
 =?utf-8?B?RXBYVGZhTXE5TXBHdUtsT2ZUYTFWdTFrUjVSaFdRbk5WbXRJZGUwN3RXeDNr?=
 =?utf-8?B?MURMUkU1ZU5lcUtBd0tCeHRoR0Z1VFpqZFlHRnBxbEdTTlg5NklZVmFTMS94?=
 =?utf-8?B?ekdxYnJCSEtob2hESDBHN2hZUFB1UEtLNUJvajdTWC9kUmlQSDZGVWdOL1RF?=
 =?utf-8?B?L1lIYWZsV2lNWDhuSGhMcVMyeEExZkVBTlpDS3ovZWhlNnVJT2R2MnE5b0w3?=
 =?utf-8?B?anU0U0hZQk5qenpBVFl1ZEVMalAxSWlnMHhyNEF6Ukdka0dRbWtJUXdWSU9m?=
 =?utf-8?B?UXk1KzE1NzF2OTBtVytCUzlFYVVLZ2Y0Wml3SjZhV3ZSVGpwODNQYmdJenNP?=
 =?utf-8?B?RnpWdHkrcDNaVnRIZnFqWkhQakw0aXdTbm9vUTlEazIzTDEwRDBNdEFRMGlW?=
 =?utf-8?B?MzhhdzkxK2k3ZTJ0V2pneHoyOUZzaHhNK1VDZVNUSlBaWmFjZEwvbGxVQURi?=
 =?utf-8?B?dEFZeXZmVUdJR3ZJL0hQallxSjkvRTNrRUFCY1psdlIxWW9yV0hjNjRTbFY5?=
 =?utf-8?B?Z3A2cjM3ZmRLeWZWK0JvS2lFT2w2cHlILzQ1Q21CSUgxRFVnakNrZTZ5Qmh3?=
 =?utf-8?B?UXRNNnNLNHRJS3BqM0pWUHZCU1ZzV015MFBxNzZVdHk1MmowQ0RjcTNhTVpu?=
 =?utf-8?Q?fFuGkOkQXt5nzq6p4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWdGdTNNOHR1V2d2MG1pQ1hxamZoVjQrZjZSMkhKUVk5aHNJU09RRWJXZ3dk?=
 =?utf-8?B?SEx1ZHJ3NS9nWmZmNHFlbnJ3bEdRQW9WcHlYQmxyVVU2YXdydWVKS2VIN1pj?=
 =?utf-8?B?ZURJdkFtOEJzL1F5QVZVRi8zWTBXWVNBazF4Z0JCUnMveUlncENQNzZzR0dM?=
 =?utf-8?B?NG9sQVVxTkJJeU56U3RieXV3QlBWUXVsQ3dGTGJFNDZ0bDhOWVQxRHhiUXV5?=
 =?utf-8?B?NzJ0WXYvNkNQR09NVkI1UlV2RkZBdWxSUWhvdlZXODB1T2pvUytKYVI5K0l0?=
 =?utf-8?B?N3gyU1FBYmU3WXFYQ2F2cW4wT0xWT3FLT0xCS3VZNHI4RUh1Z0w3aFZDN1Nq?=
 =?utf-8?B?TFZlMExyMHE3SS8wN3FnMFFyQ0VaVzliREVhc2p3eFlZdmpKeTE4MUJXckxk?=
 =?utf-8?B?RUMxTWMzcGU4NXJCdit3cTJnRVROendraldlZkRicWpnaHdTeFhnc0hqbThq?=
 =?utf-8?B?NHAvMSt6K2haLzdZOXFTbDNBZDdsQ1RHMzBDNCtxQ2Y1RFV4ZUhOaFBuQUhn?=
 =?utf-8?B?SGxCL0s1Tm1MRm1UUC83MVpEQzRYZEVhRGRwSHI2b1RLQnA5cDY5OXlKWnVF?=
 =?utf-8?B?ZHgraTNwM3paY1RDcDBjY252MUZVRGM5SStHYkZ6dFdzaVY4M3dNYi9YaDVU?=
 =?utf-8?B?MWVGNlJkNzBxeHRtNFJuaGduVUpVdlJWRTlRdmdFc0hIaUtldzJKRmR0VnJo?=
 =?utf-8?B?YnZmVWhtZ0VkUnFlWVdCWlhrRmFWVHlsSy9GcytIL1RKV0xQM2xIL3UrR2tT?=
 =?utf-8?B?eXJ2VGNuQmw3VmVqZU9maEtjZlRMam5sSURTaVZzVEQ2TnhrRm9ZTFRUMklq?=
 =?utf-8?B?bDBsN1FiL1lLUHJYanRYcWRvRU5kZEhrSHhSckFZY0xxQ1JibHJaLzFiSGxX?=
 =?utf-8?B?M1RDVWoxWnhMWWpPZUtackFPVndyK09zdkIyUXhGQnIzb0hsWkVIeTdWcVZz?=
 =?utf-8?B?a1E0allQbytLaHZVS1kyTk00SGtBcE1DeXMyME45Yy9tbW9CMUx5bklSZ0N5?=
 =?utf-8?B?cVZKaWNFRDBKRWlPenhVcE9DVFdHaHJzdEQ2MzVCWXRrTWttR0g3SnN0WUw2?=
 =?utf-8?B?RlNhallIMnNrbG9qd2s5YXFsSmhJaUw1Sk1wNGRRRWsxZXhvdzQ4bmUydk92?=
 =?utf-8?B?Nm8vWFpCbkhiWEdGVGt4bVVRUitRVXk2dUtCdmhqVXYxaDNrS1ZtV1VWdktP?=
 =?utf-8?B?S251VHNxVW5BYmtJQi8wYkNxWXlIdmtsQWY3SzRVK3RGak9WWTEvejBOQi9K?=
 =?utf-8?B?RkhqWkY2VkdQUXAxUEFJZloweXN2cmhXdDkzRlJFNTVIU2NDdDlIMWxFVDBk?=
 =?utf-8?B?WlkxbVZaNDBRMTQ3eUUvS3lCdzlOdS9Uc0ZxQzhsVW9HVWxrSXF0S0syYUM5?=
 =?utf-8?B?K3c2Qy9hWndiUXV3S2YvdFJhNTRHZjA5SFZXRVVYVGlvMTNKcDVNUERFTndY?=
 =?utf-8?B?MkNxS2Z3WTFhZWlOeHpUdjJackNQNHJiMVRXVlFrVEZUdXB2NVhLN2lybUpU?=
 =?utf-8?B?V2R4SkVzMS9BUXNPVVJaalcvRGJuY3FUQ1ZVOSsyeEVYcVgwVVhYWkhCeG1i?=
 =?utf-8?B?NUxFZUNJanhoYjBKeGVQdGtjTXo2RGoxVUNWOG5RUDlxNjA5bWxwS1NhVUNZ?=
 =?utf-8?B?YWxocXVxZVVHSXV5cWVoN1ZWY0NIU0I4QW1naW05bGNCSE9WcGNHMVVKRDdU?=
 =?utf-8?B?K1d4L2xGR2Q1U2lyNzl3Vk5oTXlMd25pS1JPTTAzdUdFbWgwS21PcGRwbTBu?=
 =?utf-8?B?ZUxRenl5blRSbDRGaVRSZGpZZDRDZVFPQlFHalFPdDlFQjJGRXk1SUVJN2FW?=
 =?utf-8?B?VkRHRnNDalpOVUo0QlRLVkZrUmdFMXNWZmpPTGNvSG5sd0hQVUdBSUFaakpH?=
 =?utf-8?B?TnJYdWVvRzZtRCtwZys2SExlT0lXSnc2azRhK3N3MkorWjBKT0hUdHlHSmJw?=
 =?utf-8?B?cmwzczN4L2hQUDl2cHNGZ2ZVWHo0OVdWSFEwbWxzUzBLL2RzdVRqZVo0Mi9w?=
 =?utf-8?B?K2I3dUhhY0EwU1dmTFhLWmY1ZEtNQ3JaSGVON3M1VUgzbXF2c3h3NjZnbnpU?=
 =?utf-8?B?WE9yRzFjTkdqWlQ5aGRDVkx0eUc0R3I0M2dRVDhuazdIeFR1czk3ZnhSNHFh?=
 =?utf-8?Q?HXt4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11574fc-efe9-473a-85f4-08dc8987f891
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:00:26.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tXXbBgCDl/l/rQX06OtiaBgA4AbbX7zb0virsAWnOIVVg2yEhDZ1KBNLQLzZbu2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758



On 6/7/24 11:17, Jonathan Cameron wrote:
> On Fri, 31 May 2024 16:38:34 -0500
> Wei Huang <wei.huang2@amd.com> wrote:
>>  /* TPH Requester */
>>  #define PCI_TPH_CAP		4	/* capability register */
>> +#define  PCI_TPH_CAP_NO_ST	0x1	/* no ST mode supported */
>> +#define  PCI_TPH_CAP_NO_ST_SHIFT	0x0	/* no ST mode supported shift */
>> +#define  PCI_TPH_CAP_INT_VEC	0x2	/* interrupt vector mode supported */
>> +#define  PCI_TPH_CAP_INT_VEC_SHIFT	0x1	/* interrupt vector mode supported shift */
>> +#define  PCI_TPH_CAP_DS		0x4	/* device specific mode supported */
>> +#define  PCI_TPH_CAP_DS_SHIFT	0x4	/* device specific mode supported shift */
>>  #define  PCI_TPH_CAP_LOC_MASK	0x600	/* location mask */
>> -#define   PCI_TPH_LOC_NONE	0x000	/* no location */
>> -#define   PCI_TPH_LOC_CAP	0x200	/* in capability */
>> -#define   PCI_TPH_LOC_MSIX	0x400	/* in MSI-X */
> 
> It's a userspace header, relatively unlikely to be safe to change it...
> This would also be inconsistent with how some other registers are defined in here.
> 
> I'd love it if we could tidy this up, but we are stuck by this being
> in uapi.

Alex Williamson had a similar comment in another email. In V3, I will
only add (necessary) new definitions and refrain from touching the
existing ones.


