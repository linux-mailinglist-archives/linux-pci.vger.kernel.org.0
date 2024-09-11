Return-Path: <linux-pci+bounces-13060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E18975AE8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 21:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB5AB21E93
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828121BA276;
	Wed, 11 Sep 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lOcWpKgR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7AD1B5808;
	Wed, 11 Sep 2024 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083508; cv=fail; b=J/6lbR1K0CljRQWN30X6Ei8zRCVXRaBANRdb83W2Hc9jVJh6YMUaWhFaisrN7q4qDWFyPRyeJIUAxbVTH4opraULdkIxAaBudlPKSPQcBhM15XO0iWxNUBUA9SDYZY7bDxoECOWLQQm5SfayWUYIx4ZSkSuUJLEEKuwXHzFSG0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083508; c=relaxed/simple;
	bh=0MD7lBWI5ZJRY/YKsD8DW/VM4zCZwot3Yhg1KOo5z2Y=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uDiVVT2tuHGqnKXMpUb/1y46ye5KjneRl/LlBRkFqQbS15HtJBI0ZQg5U90gprhunDfaPX35hnmMVWS3b0VAPWydpozmn2fyXILe3LjoQKiEAz2iI7MUYUWQaVj9m2fnmE17N7fjrJm3n8A3hVyrbHuiHzTxZQLjxrpvtopmCUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lOcWpKgR; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9akrl+Xb38pA8gqEeb3niY5WC2zeWA6KaO5XwFB7GzoBN+aHkjebNATrLX8q3SOubKtjd9lcNEQ8c9i8LGGKWUaErh6zbCyx/Oi6ZLRaXzLO5KuNEBb6Hv1wiS5VA96qZqTkKX6ym5c3nzfaSNnKxP5jM+NVrHGbp+4ai+CTFnC2tOJWRx3fIBiLzfgZjLcYzsLal2yE3ulBjNwSbUpkEKqv+tBvgJVs2gD0hiOlykDT2/qsq0rzVX7y5irLFUMx5dR8Ao4gzTnFQV8qHJFTWBHKUQ4WXDy2scMXDRIDfscT3ulHrI9J+Br0GqTrSMsnw8xGe7K24BfSs6vB7aSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt1S4DRpuRbAcNUIYopADtqHGDV4yGhOAj+nXlkOsgE=;
 b=VDbrc9BC76gQrezn9r6pUpxYRIpTVOBvtXKcsjR6eanXGIQcRrEqKwY3acGPi/utVDg9LI9KZ83J+kj/WHcpREqkp08kVG4k6TSyGm+PNwZ/2rUcm2fxpEqn4l9nmUjIbU5e7Ew+YBLgmb6018XgSJLWdFvnrQj7q5Ujv0jo1OFw9si/ItIVejJRbqZu8Gb3uxbhkUYiAUuhJmaH6/2QgKfwAyUbMe7iTLSMbXaw654JtW84FZRQCNzftHs90RH9X3+My+AFvb0d+/SOKRzHT0d+ZyjrLGhv9pZoEHJAIJGm5R2jCwZR+m1ZtyCq1R0TiUFbITb9+ygzUBZcnDtcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt1S4DRpuRbAcNUIYopADtqHGDV4yGhOAj+nXlkOsgE=;
 b=lOcWpKgRp1qqnO4Uvb+lOBPKIIpDrBm1Jri5oyhwpp71cfiF5rdGvefDnHcTdCNzbbWaMYFAbz6fSf9hHI/vqI92qbqGhEcf2ngNNsqHGMSNQZKIQ0O0FGesuenI42CFXfBhCPUgem3r//k4sL7bQ+/S1TSkUrHUwF37Sr1Rz34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Wed, 11 Sep
 2024 19:38:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 19:38:23 +0000
Message-ID: <fa504022-acb3-4930-b6b8-87a8dcb912c3@amd.com>
Date: Wed, 11 Sep 2024 14:38:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240911190516.GA644336@bhelgaas>
 <319e5419-3b12-4672-9f51-f90c5e142e29@amd.com>
Content-Language: en-US
In-Reply-To: <319e5419-3b12-4672-9f51-f90c5e142e29@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:806:6e::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e83ad7-f6ff-4fe9-7e15-08dcd2994c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVlCS2xHS2NWQkxMaHVqWnNXc3hRV1V1cjA0NTdlTGh6aURrK0lJSTh3bGdq?=
 =?utf-8?B?VWVtd3BzcXFiZDQ1Rmk0WmZWcTd4WnBlb0N4U2NWQ1BRTFcwS3VnZzFvQWsx?=
 =?utf-8?B?ckordGVBUDNmYXZvYjQ4c0pYL0J5ZFFMT0tvQzdIWlI3YmtaaytwMXAxNmtH?=
 =?utf-8?B?U1FoVnpMS09CaUJPczhsRVJsU2ZTTWt1NVBaK1FlV0NNaUIvU09kcjM5THhs?=
 =?utf-8?B?WnZ4WXRwVlUrV1kvQ1RBaDB5Y1llQ0luT2tpcTdpemZqa294N21sTW9WRlBK?=
 =?utf-8?B?UVFiWHdsOFhPc01Xbm5VcGdjTkdJWkZsblVGbTNNUjREVzhtMTRVQXhCQzh3?=
 =?utf-8?B?VytDSHltNEpSbEs2YWV6enEvMDArdlU2MlNoaC9BSXY3aGJiM1Z0c1R5cm5N?=
 =?utf-8?B?cUxjVkFocDBqSUxVZk9ZVHEvYjZaWDR2TFZldDBtYmxjUENMS2pjUVZFeUdT?=
 =?utf-8?B?SjFTaDU1bzQ3MVlsaWhwVWJ2V3JGRmp2ZDFuV3E1Yjk4NlNlVDNYSUVSZC9F?=
 =?utf-8?B?bEQydm9rV3M1b2EzZ3FKdTJabk9YTGRaSU9EbVVneW9QMTdwU01jWC9xZ3Qv?=
 =?utf-8?B?OUtGOU9QUmJLdnM1U1Q3UERJajVlNXVsaVJxVlh4Sjd0K0kyZ010bFlqOVFT?=
 =?utf-8?B?Y2YzYjV1RnR5RUQyL2lGRkVsK0JLVFo3K094UEFZeHVJU09sQ1pFTTRQQ1cw?=
 =?utf-8?B?WkdwTDMzY1pCUExHci9XRGdWOE5ncTI0RjJHSndNQUFxczB3anMrcE1LY0xa?=
 =?utf-8?B?U1NIb1dMRjdnYktCWjlHOGlqYXM0eTFSd3FteGVaZnpkMWR6RVhyWnFXbS9x?=
 =?utf-8?B?Y2pMVEE2Q3VqL1IyKzVwOVE3b2xyWGVnQW5DWHhMaTdzOFNCZ0pmMjVtdjRD?=
 =?utf-8?B?TVNybVl3NklwWjV1ak1ESGFESUxTUituN3d6b0hCZ0hHc1Zva0FDU2xvcnli?=
 =?utf-8?B?QTVaekdqY3JGQTRzdFpIdGxDQm92QUQyQkNWSk1TcXI4OUlic1hiUlZXRTNY?=
 =?utf-8?B?MEpxT1pkOEtyVXlUeEtTdXdwUUZ4QzFtK2VTWjIwdURWU3BYS2ZUN1c5c1Uz?=
 =?utf-8?B?UEMxZmVjQTduV0o5bEt1M25hMkpuTU44bk9TaEF4dzVobjdhclpHWGptc1FE?=
 =?utf-8?B?YVladGxyZmI4ZkRRV09IY1R0OTJOQThTcThLU1NIb3dZa3dGSGhDbDFlV2Fl?=
 =?utf-8?B?N2dvUllaMk00bHdja3ppcmxyRnRRSHo2TkVlUEJUTFFKbnZGWklVazhLSzVu?=
 =?utf-8?B?QlAxUjVQdXYwSnBuczZlT2o1S3FlSWc3aEFwQlZKQnJZVWViWk5OdXhVc0Nh?=
 =?utf-8?B?ZFpRNlFUaXF4NkgwWmx4SFFKeHQ5cVpreU5ralV5emUyRm5JQkM5Q0l3a3RZ?=
 =?utf-8?B?RTlWQTJvWVhkWHl5L3J0K3JSaFZLS3FLWUpMTlFhdmQ0QnJqNGZxWmgzaW1R?=
 =?utf-8?B?cHFpWDhpRU5yYjRZdFlTWVhvWldNcEJ1L3V2ZEF4Y3l6UHFuN3F4NnZDZ25y?=
 =?utf-8?B?VENEd01kSzJvWEhjSEZIVHJYbVZVdXR3SFlqaFR0cmQveVFBVld5bzNYV3pt?=
 =?utf-8?B?bGZiUHJ1SzRuY0V3bGs4NkE0MytpdytkU0VwaFh1NTU0TXZ5WE03K1VZUDVT?=
 =?utf-8?B?d1F0RGRqZU9jejltU1BpNnFCTVVXd2IyMTgvcDBMeVNXenRxM1VDSVJ3d2Q0?=
 =?utf-8?B?NEJvc0lLWnRUUkc4YmEzTE0wTHh1dDgwaUUxS0ZvNzlIT2x3Q1podlpuaDEz?=
 =?utf-8?Q?/UdJypK1gtPLexd7PI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2QwTHVtQ1BEVlBITWVrbXdQaXZyVmQ2cTIzWmdKRVZTY081OFRZVVM5eDhO?=
 =?utf-8?B?WWZOK0ZJM2VIR0FMekpLNDJ1Zi9NdDFNTHJJSHprdXQyV0oxSG9IVHRKNUU3?=
 =?utf-8?B?QkRneGtpVitZd3Z6U2o2ODdQOWV4cXlZampSaGJzOVFkZWptSU5QaGtybE01?=
 =?utf-8?B?dkJYYU55UXVxWitKYlZEM0hKSExvOWIyYmYzTXR5M1hNdXA3M2h4N3htN2Vk?=
 =?utf-8?B?amJRejdkd2hYcE11Zk5WMHBOcGNHb3dlZDFYUFRwaW9Bc3ZGQkVRUWZXQkhY?=
 =?utf-8?B?ekNHSzgzWE5IMUJqbWI1MGJxS3FyVmp6RUFvbWp2dHNMOU1jUHl1QWJEL3lY?=
 =?utf-8?B?cGdRaHY3ekprK1M0RHpDZW9QQ2pISmVDcnZUcWZYazNNMG1CLytnUHNJQXN1?=
 =?utf-8?B?NDlQUVBSZS9nNHVnS3VRc2tRRjc5TzdydzkyUWxpdTAxMXQ4c0owWk5mMWYz?=
 =?utf-8?B?T281amxjRURkWXA5WWd3UTI4MnNVc2M4dlNONDFaYm1xRTRsQ01hcGdyNWtR?=
 =?utf-8?B?NTBaallWbnJsVmVPOFU4QnRNeGNqaG43RkZGRjQ1SktQMUl6clEyVHpjS2dh?=
 =?utf-8?B?bDhDN3QycytBMmgyR3ZpZGo1K21iekp4UXZma3pKa3NjZWpRdDUrR2wxUEVN?=
 =?utf-8?B?WG1uVVl2cGVOMzNkdzNwZVZWVHpQRHUyajhrQ0Njb2VOMmZQK24vamcybFVF?=
 =?utf-8?B?VEcwbU5IZWo5WjA2Skl6U3RyS24raVZHdXpBN0N5NWNhdGZZOWQ0bUdrVUFw?=
 =?utf-8?B?Z0t2MmRSOXM2MzhRN0VvTSsrK21wUW1jVnNCRU93MUgyYzZWZUZ1NHdBNWEy?=
 =?utf-8?B?bXNuWEFmaFE1MjlNeTdCaDZWeGIycyt4cDFLM2Y3TlQvR3IzRHl4Um1FcHNQ?=
 =?utf-8?B?S1RSVnZYVFdJYllMeGxIN0lSU01Ib3Y4dkdrU091RkFtVTVhd052OWdLTmE2?=
 =?utf-8?B?cjhGNWFwd1YyVmlCSlBxc0MxdVYwckhQeUdJOWNTYktsTGVJcEpsV0hJc2g4?=
 =?utf-8?B?b3ZQTU95cU5IQm42TzI5eVd2OHYvL1V2ZHp3bHpxUzl4NS9IUDE5RzBNSW9F?=
 =?utf-8?B?bWlvbFNQcWN0OXVnUG1wVTlRYUtCdTVha3RYQkl0alBCWTlPRnVRWVNybVB1?=
 =?utf-8?B?U3psMjdkUkR5My9hYzFSVFkzaW1KK2tVRWZXYi9oVTQvUjI4MUJmRmtVbWZB?=
 =?utf-8?B?b2Z4Wlo3S2VyZlhSQk5XTVd3YjFiSDg1SHZXS0JSa2hrbjJsQklCYkQvWW9R?=
 =?utf-8?B?cy9TRXJnYjhKNTAyRC9GUzhTd2N5Vlh3RDdMd3R5QjRsZVhCSUlkY0ZRSS9T?=
 =?utf-8?B?czFIKzdUVVBWQnpYb0JEejU5TmNJZWVaa3dlLzNoWllvYnVySHM0b1NnUkhn?=
 =?utf-8?B?d1JLZkVKb1A1T3Q2R2lMVnlWSjBlRkM4RWlPYjE2dzMzRmcxbWhSQ0VGZXQ4?=
 =?utf-8?B?K3g3cmZxaVdCRnRCVmZhU3AyVG5yWWR3SkUrMlkzM1FZUEVrd3NPcjNIQ1hI?=
 =?utf-8?B?c3BjaDgzZERtQXdOKzhQNU5CMVJUZnFXNCtlZ1VRczAvYlVIZnFiWldrbHJ1?=
 =?utf-8?B?Z1F4QllvYXFEbXhFeXJ6UVBjclNNVmNZSmdBVm93OVhPK2kzRnFRQTZNams4?=
 =?utf-8?B?WWROb2dtTWl4SnkvL0g5OWxjNUpnKzd2VlZZMjkzclVyMGNwbGp0bmZTRTF0?=
 =?utf-8?B?QldSVFg1emxnV3NYT3U5SjA3K3NWN0c3UTRiL3JZQVdCZUlKZ1NnZE5qejFu?=
 =?utf-8?B?LytjM0FrdUVDYVgrODFMajZrd01KK2pucFp6NmV6MTdUakJrdzRkeUZyRGFE?=
 =?utf-8?B?cG9IUkxQRFlEQ0FQUEJWdVBQckJPYkJTeDFobEVDS3l4ZVhlZzc3QzNMeEVk?=
 =?utf-8?B?L0o3bzNXaklmSmVDemdueEtjMVptd1p2aEYrZnRCRHNkSVVoejdvVHpPRXll?=
 =?utf-8?B?WFdJb3YwQTljMGozZTNOZVNYSUZuTFQ1VzJVQjlXWnkxTW5iMUF6UFA4aU8z?=
 =?utf-8?B?STJmc3NqZlN2VitOWEdEMDNuMCs5c2QxRU9DaHFOQTlVdCt5azliMHF6NDJo?=
 =?utf-8?B?d1VMMnJLSkwyOWZhemdTSzhJTHBiVGQvMzdnMWMxSTZ0aEt4aFNyOVBQWHZ3?=
 =?utf-8?Q?RFEz+3M0vkbI2CiGbl3qmAMIV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e83ad7-f6ff-4fe9-7e15-08dcd2994c48
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 19:38:23.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoQWALV70/NnuSb4mbSafFXNxexGF72IVEkP6KqT4VgR4iqWFcaTGp52Om/2REgOODgHFeLmqSwxqz1WrSsZow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

On 9/11/2024 14:16, Mario Limonciello wrote:
> On 9/11/2024 14:05, Bjorn Helgaas wrote:
>> On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
>>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>>> connected.
>>>
>>> The following error message can be found during shutdown:
>>> pcieport 0000:00:1d.0: AER: Correctable error message received from 
>>> 0000:09:04.0
>>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, 
>>> type=Data Link Layer, (Receiver ID)
>>> pcieport 0000:09:04.0:   device [8086:0b26] error 
>>> status/mask=00000080/00002000
>>> pcieport 0000:09:04.0:    [ 7] BadDLLP
>>>
>>> Calling aer_remove() during shutdown can quiesce the error message,
>>> however the spurious wakeup still happens.
>>>
>>> The issue won't happen if the device is in D3 before system shutdown, so
>>> putting device to low power state before shutdown to solve the issue.
>>>
>>> I don't have a sniffer so this is purely guesswork, however I believe
>>> putting device to low power state it's the right thing to do.
>>
>> My objection here is that we don't have an explanation of why this
>> should matter or a pointer to any spec language about this situation,
>> so it feels a little bit random.
>>
>> I suppose the problem wouldn't happen if AER interrupts were disabled?
>> We already do disable them in aer_suspend(), but maybe that's not used
>> in the shutdown path?
>>
>> My understanding is that .shutdown() should turn off device interrupts
>> and stop DMA.  So maybe we need an aer_shutdown() that disables
>> interrupts?
>>
> 
> IMO I see this commit as two problems with the same solution.
> 
> I don't doubt that cleaning up AER interrupts in the shutdown path would 
> help AER messages, but you really don't "want" devices to be in D0 when 
> the system is "off" because even if the system is off some rails are 
> still active and the device might still be powered.
> 
> A powered device could cause interrupts (IE a spurious wakeup).

It's a bit of a stretch, but ACPI 7.4.2.5 and 7.4.2.6 are the closest 
corollary to a spec I can find.

"Devices states are compatible with the current Power Resource states. 
In other words, all devices are in the D3 state when the system state is 
S4."

https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/oem-supplied-system-level-control-methods.html

> 
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>>   drivers/pci/pci-driver.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>> index af2996d0d17f..4c6f66f3eb54 100644
>>> --- a/drivers/pci/pci-driver.c
>>> +++ b/drivers/pci/pci-driver.c
>>> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>>>       if (drv && drv->shutdown)
>>>           drv->shutdown(pci_dev);
>>> +    /*
>>> +     * If driver already changed device's power state, it can mean the
>>> +     * wakeup setting is in place, or a workaround is used. Hence 
>>> keep it
>>> +     * as is.
>>> +     */
>>> +    if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
>>> +        pci_prepare_to_sleep(pci_dev);
>>> +
>>>       /*
>>>        * If this is a kexec reboot, turn off Bus Master bit on the
>>>        * device to tell it to not continue to do DMA. Don't touch
>>> -- 
>>> 2.43.0
>>>
> 


