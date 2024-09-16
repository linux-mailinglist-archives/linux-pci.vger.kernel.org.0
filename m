Return-Path: <linux-pci+bounces-13243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE9897A78B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 20:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0298285360
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 18:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554292628C;
	Mon, 16 Sep 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1QP1n4Xt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521B3BBE5;
	Mon, 16 Sep 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726513138; cv=fail; b=OZjoawurSZ4kg5M/eglQOm/AvXGEtpydoW/3bUCfZxitwg2UCSICu51gk6xxnLu6q8MV39HMhLD2NUQG2gn5aX6wHgzCGlYQW7CYo1dJBM7b7kQT42JiYQtoIIcC28LURZT+3NnV8XZXD9LyrNXpjIubLk8xzn21fKOI1wCjupg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726513138; c=relaxed/simple;
	bh=BtxQcPZs33W/KRxKOhSZ7PFdM0Q6ZaP1asw7Aoz7tk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MnG9UXgtOU8jUNTK8zenQv06dPpbiWZA1/FzcfHiHHmy8+hNMre5G6cSdI9PavOlpNG8WhVH4VCvmM9zZn/0+WwtQss0/sVpnnKTx0pPHO35WBExFPdLopRBFh8os3QH8ykMNL3dD9SRTyOWjDc3xuEUKXTszGQmB0ViTkXKxTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1QP1n4Xt; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eF+XXyy2CDnWd0Z8I9Hj341qfcKgi+5fQpAUJ6/DFEw0uaPeYitawTjUq8kTYztI7UtaZVqDkPoChMTIzDaUdECNwQMf28f4h1Fo6y1NMtB3kfbzxsbpFEzUbM17hV6IfFaT1X9YqbI4f4Nq+3hAbRSM/ZByVYRcBOEKFCdGoyNtgIhnMd6ecUWwMBTBPmOA9OgR+r2FJK/8Fxc39aXVJOLa7ORTdnmWe8V+owiqgFkRBuioxogC/ltM1wLQ/Ha6ibfVik3oRmbT/HK2/QtP44BA12XiNDgL14tljuM07yvJfYZGxVVjFTG//jAvhERMYAiwwATZQca4KqYbwebMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZN6FQ0ekvVrlkI4aSGDzztJE65FgLr6DoSiFEfFs1g=;
 b=iBtF5p/UzFzU8/gSODQZRUikOz8BKvU/4QVIn4f68/ZZq7hQArRnIXy5g7SgVBSCDvyx3WaY9RNHJ1Cu4GbQsgICd7aHPLQ8yGrgBoO5DJC6pMOasn/YWG4R+CHsn8/bpf5tUqLmJB0dwjgKSkHJf4eGjTAbfc+q3vmyqwdebknwFToNskEe5/MJxDrB7o4xuhafi/v8552E8hoGev9LDcScf6nNHV8O3FfjJ4rxPJXlpJ8YUaCtE4RuSm/i5eN3uXeszYkbD6gCgt4eouREJrJEkkfR6iRD24OBk5F+RY+nMne2ioYsMvdQeFnNIJJ8Zm9jg9EpOgszCL7njCCZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZN6FQ0ekvVrlkI4aSGDzztJE65FgLr6DoSiFEfFs1g=;
 b=1QP1n4XtM49mFWg6r36EUaL93NKEW1DW93YRSN/m5LIjdtDfeUNzif4wEH9nURIYtpfmApK0Hdq0ImkcZol2/fHVvugWTDbdjw8RcSQLAIMt3i3LrhmNRg6SGsA1fx1VRK04h76XOx9CaizvzbqOVOKF6CZY6KfGZyizQdQLGUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 18:58:53 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 18:58:51 +0000
Message-ID: <c7961ec8-61b0-4ef1-a8fe-ffdaf1f03b21@amd.com>
Date: Mon, 16 Sep 2024 13:58:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 08/12] PCI/TPH: Add pcie_tph_get_cpu_st() to get ST tag
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240822204120.3634-1-wei.huang2@amd.com>
 <20240822204120.3634-9-wei.huang2@amd.com>
 <41d2719f-c5d7-e432-756b-3e39fe49fc8c@amd.com>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <41d2719f-c5d7-e432-756b-3e39fe49fc8c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:806:125::17) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e56f6c-cc7f-4fbd-f76e-08dcd6819a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEpScERGSzJpN3ZOWW83c1ptT3ZsMjJDVGdlYmJWQVUvT2Y4YzZRTktqaVNJ?=
 =?utf-8?B?R3loNUVIRTQyZy9SMzBOdGZyU3V0alRIY0N0WE4zVEVqN2xiYkcrSkUvRXR0?=
 =?utf-8?B?V2ZVaGpZR1Z1QzFueXZZQWowMFBrWnVsQi9ONGx4SGVmYm55Yi9RRlhkc0hE?=
 =?utf-8?B?MHdic3o0ZDlyUEljeEcxa0NzRDA4NG43RmZETVBiTUYzUXRvVDMydm8xSjly?=
 =?utf-8?B?T1JWU05FVHhDVVlQQTg4TnpwNTMrRjdlRjdkblJpTDlHa2E5eTlSdEFsaVdF?=
 =?utf-8?B?bDYxMWlqRFFyWGxXY1lhY1doTG5tVnBhcGs1blhiNVVUM0srMC9nREQvNExF?=
 =?utf-8?B?RHNBTFFNa1Y5bEVyWTNLYXBoa1BRbnBpYlRIemVrUjhrVGNQK2QxdjFXLzRT?=
 =?utf-8?B?OG00M2t0S2NNekpTdDVSQjJBZnMvVVdvYjg1RzcxRnNlYWdZdmx0WFJYUUV1?=
 =?utf-8?B?L0ZqRVFEMXBzRS82blpqYTQ0K21ieVIyWkVJSStWRDgzaDdVTzZTaFVZckY1?=
 =?utf-8?B?NE0yTDlrTnNlTmt1MlQyQ2dNcmVOVjhMenlPUERqZGVPM1NvVzVmdEhzU2NQ?=
 =?utf-8?B?RTlMUW00TGt0SmZlZzVkdXNaQzkyU0ZIdHFkT2hFUDdYMmtHQ3puSi96b25H?=
 =?utf-8?B?RkZVRHo5UU1yR25tcmlDTG0ycVVWZzVhblcvamhzL0s5dG1KOHJnWnlUUUtR?=
 =?utf-8?B?aDNtWHNXNXgrV1V3bTRmY2lnWFl5ajBrWmpGMC9kR3F3UkpyL1IyTjVLWk1N?=
 =?utf-8?B?SWlxQjBVNitERVhlWGhxWHJvODlUY0oyRnk0ZWVaSjhOb0l1VlVvM3R3SVk2?=
 =?utf-8?B?WDJ6cFc2Rjh3RXpPaFg5ZmIzWlY4ZFRydFlLZFNsN1NIRUpZVnpkQit0Situ?=
 =?utf-8?B?V2d3eDJWOUtLcTN0bGJDSjBKRG5nUk1pQnMyL0VUcW44bzd1RnRIR0dPdlg5?=
 =?utf-8?B?dXJ4NlJyOU1PaVRsQ1N4RFhTYUthRm5pTXpiVzZIRVlKRTdhTkF0WEpxNVRY?=
 =?utf-8?B?M1kzd1d6YmhDOUk2Qk5Ya2R1elNrbU5PYTBReVkrQ3BOTFczVk1KbThBdjM1?=
 =?utf-8?B?a1Zjd3l3aGxtM0tEWEJjNG9nNWlEaldGOGhtaFIrSkJDRWJwMGltSXJuTXB2?=
 =?utf-8?B?dXhYeXJTcUpsTXYzZ3BCWTBNWTFRTEx1aVd3NjQzbklvQVdOYVZXUVRKeDRU?=
 =?utf-8?B?Y09sWjhNdWE2Qjh5OEhDd3dpMlB3akd0VUlMR01SVndCdEh6VVZWUldVRzNO?=
 =?utf-8?B?QXowR2l4TFl1d3ZCSGtKZCtaOG5mRE5lbzhXSWg0NDc0dHZSQ1hRdzNwQVJv?=
 =?utf-8?B?aS9NYWlZRythMnVzMW1XSEtHQ0FFU0h4NTRmRVdlRUxFcVVpaUxxZ0ZnMWlG?=
 =?utf-8?B?MFZOUWFGblB5RlFrSldObGxUelZaUnhFU2k2MGR0NnR6dzBQUk5lNVNaRTE1?=
 =?utf-8?B?aDZUREEyMmsvWWkwczZzemNMZWFXeEp6SGFLU210QVBMRmw0THc0dFgwaUZC?=
 =?utf-8?B?dW15Sy91ZGxFMUNxN3c4S2VNYUFObURkRjRidGNyMldxb0IwNGQrWWhRRFRa?=
 =?utf-8?B?UVJ2alJLVFlFU3hzWDN4RGpuTHlDd25YWDJmZlBRbGh3R1F4ZFI5b1dRaWM2?=
 =?utf-8?B?U2hnYjdqb2ErNUkva1Q5b3k2d0wzVkt5ZUdJdlArN3dud2VZbmdoR0VwSzFX?=
 =?utf-8?B?UC9zZFFHdkhQUStNTDkxQjFRbS9CN21kOWQzdVFnNWlJV1RGb0lrYXZyby93?=
 =?utf-8?B?OWNYVHFwS2Z5OWRoQXJRR2Z4UVhHR2xnSFJVQW9YK2lSNnIwbXRvaitJblFY?=
 =?utf-8?B?NSszdE5jTFRDekd6Wksydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWRMUGxOUXpVcmdPalR4d3l2a1VoTlROS2oxOGtjSVVSc1ZxL25qR2k2R1ky?=
 =?utf-8?B?OVhxa2cxVSs1cGhxazBkaVlqWlZSSXg1Rkgzc1VrdnI1WjVhc1VVbWdidUdD?=
 =?utf-8?B?ZWJ4ZjR0WHRFbVlZNVZLRCt1ZTV3N0JmcWo2THo4MTRzeEVmS1Z6UlYveTNE?=
 =?utf-8?B?aEhIbmFaQkRKZXNxcnJJTG9iV1Vnd0ZuVzUyMjVYRHZ4dks4RGUwWnBMQ05C?=
 =?utf-8?B?a0ptYW1Qb1JKUm5KL1ZsSjh5bzBOUmtBV0xFV1NOTkx2c1o1MVhJS0dRRUg3?=
 =?utf-8?B?d2pNcnJhYUhvaDFzZTljNFBLNW5kZnBUdTJCMzNSRHNPRy8vQ3VLU3VianFm?=
 =?utf-8?B?WmRKTHJPS1Q2b3o3VDFjTGE5NWFYZUhRQTZMb2xjRWltb3I0Qld4QUhtUklS?=
 =?utf-8?B?OHZ2enA4dzJwcGtrbisxUDdwRmErWHFnZitENG5RZjhvSk9XSE1sWmJKd0o3?=
 =?utf-8?B?SmV1WGtVcGh4WGpadkFqZE0ramVCT2JJTk5WelN1ekJCSHBkaFJjQ2JxdEpU?=
 =?utf-8?B?dWFTOTV6SW90SUJ4RkhVNmFwQ1dGWXo2ZDIzSEFxcnNLZ0t2MGJya3M2djUr?=
 =?utf-8?B?SDN3eS9JQWk2NTFmTDJXSmxHaGJudGtDcnc3ajhUWW42TklMK0ZqQUcxaXJN?=
 =?utf-8?B?Zkt2Vmc2aHNXZGtVa01GekZVSzVCZi9xS1Fmd2pGb0JBRjNWMS9nc05IeWtB?=
 =?utf-8?B?WWR4cVNuYTJEbG9HQ0dCamYraTdtelIxRGxJOTdHZi93RWs2RGx1eStKUGRM?=
 =?utf-8?B?NWhLVER6alByOFJrSkRRQlF6RktWNEppRVlRTFB5THU5QncwWk9iZVVjQ3E1?=
 =?utf-8?B?TXJQTWZIdkhHMDRvODlTc0k2b1NSL0lET09tRWpvVGxHdjJrOFpTbWdXTVNS?=
 =?utf-8?B?QkFaNUs3NGxwdUxOQURZVmVZVG9EdmhnN3ZXc0RNcHBXdTRnclZIOHNVMjdG?=
 =?utf-8?B?MXl1UVZHai9uSVRMdkZyd0ZXMTdPTHJEVjlsMmg1MlZsME9Fa1dveE1kWTJh?=
 =?utf-8?B?Vk1OZ0IvL1MyZXJYVUQzdVBOVlVDT0szSTRSd0Z3eVVydU84dWowS1F2QXY2?=
 =?utf-8?B?bSsxZG9VejlDRTRyUTl6eXRXNmhjRWRMRXpBRGVnaEs5aUN6cjRaRmc1eHl6?=
 =?utf-8?B?UlYrb0JuSmtjc3RYSnhibTEvWmU3UUxZTjg3ZmdzYkU3S0Y5Q29XSlV1d1Bi?=
 =?utf-8?B?WUJSaGxtYURnRW1GaGRpdnVCT1pYejlQVzAyMmpESEl6aFBzQWwybXhxbS8x?=
 =?utf-8?B?Y2FnMHc0WVNpWlFxcHVOTllJNW1mN0NwQ3NTdmE4OUdPaXVOeHpQRXFxQ3V2?=
 =?utf-8?B?c3ZyWXlrcXp5aWQyMG9pdXFCYTR4Rmp4NUkzQXNKWjdROXBESFlDSjBEWG5Q?=
 =?utf-8?B?eUZObU9QUTRLNUdNWmE3V0FKZGFCeWMzYzl6R3ljVnhldWFnTU51VXY5QlQ5?=
 =?utf-8?B?SG9rNnJ5aXM0VHNEV0lYRy9aN0FQRDV5bytidnNGeXg0eU5aTHdiWjh6M3JM?=
 =?utf-8?B?NGFyd0RXVGxrZVVJZXUycWJSc0lNSEZVTkQwaXFYWXhZc1Y4ZW5KcVlpT01P?=
 =?utf-8?B?OE0zTmhzZnBWTElpTlR1Q09YaUNLMXBqd3lvdXFBUis5RnZJTWttMk1EWnpQ?=
 =?utf-8?B?QXM3THRET0lVVHhsOWw2Z1NCcFVaNE9RTkVVRXIrN0FXaUxpOHRrU283U2to?=
 =?utf-8?B?dWF4bDY5ek0xRCs2N2V5R1ZOVnYxWlpTcE53Qi9oOVBMR2UvWERuL21TeFB6?=
 =?utf-8?B?RDVVMGlKVDZGSTExUzYvZDd4YXQwcnJWL3FGMWp1RStWM2ZHYnByenlqSFM4?=
 =?utf-8?B?Umc0dVEvbXZIK0haUjBoa2Q2SnBEM2FISWdRSjF4aFdyKzRNVnFnSDBqQzlv?=
 =?utf-8?B?akdHcWxDdWJMK2Zqc0g3dGhKd0hnNWcwNEEwTDZTZFN1c2NDQjhRYzh5bkxH?=
 =?utf-8?B?b2JmeU56YU5NL2tRUHVRaHZlR25SM2xKYVhOZzBQWFNBVlFUSHlZNENJclNp?=
 =?utf-8?B?aEp0NG5oK29JdkVWSU80MXN6WmpQL29hNmprQzRJQmlVRTFrMm5EN3FOc0l0?=
 =?utf-8?B?WEF2MGxMUFBGNzZldUJmalFLK04zeXVsTjFvNHV5NEVqNFZjWjY1dW9FTzAr?=
 =?utf-8?Q?SSZk3ZWr5nap4lrgK5klfUoxE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e56f6c-cc7f-4fbd-f76e-08dcd6819a12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 18:58:51.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aDXRGI1a5RpPdh7FiW+M3dVT0mbrE1E6aXBrlfcVa3FGkHNWjm7HZgNNT99fuEy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085



On 9/14/24 5:10 AM, Alejandro Lucero Palau wrote:
> 
> On 8/22/24 21:41, Wei Huang wrote:
>> Allow a caller to retrieve Steering Tags for a target memory that is
>> associated with a specific CPU. The caller must provided two parameters,
>> memory type and CPU UID, when calling this function. The tag is
>> retrieved by invoking ACPI _DSM of the device's Root Port device.
>>
>> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
>> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
>> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
>> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
>> ---
>>    drivers/pci/pcie/tph.c  | 154 ++++++++++++++++++++++++++++++++++++++++
>>    include/linux/pci-tph.h |  18 +++++
>>    2 files changed, 172 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
>> index 82189361a2ee..5bd194fb425e 100644
>> --- a/drivers/pci/pcie/tph.c
>> +++ b/drivers/pci/pcie/tph.c
>> @@ -7,12 +7,125 @@
>>     *     Wei Huang <wei.huang2@amd.com>
>>     */
>>    #include <linux/pci.h>
>> +#include <linux/pci-acpi.h>
>>    #include <linux/bitfield.h>
>>    #include <linux/msi.h>
>>    #include <linux/pci-tph.h>
>>    
>>    #include "../pci.h"
>>    
>> +/*
>> + * The st_info struct defines the Steering Tag (ST) info returned by the
>> + * firmware _DSM method defined in the approved ECN for PCI Firmware Spec,
>> + * available at https://members.pcisig.com/wg/PCI-SIG/document/15470.
>> + *
>> + * @vm_st_valid:  8-bit ST for volatile memory is valid
>> + * @vm_xst_valid: 16-bit extended ST for volatile memory is valid
>> + * @vm_ph_ignore: 1 => PH was and will be ignored, 0 => PH should be supplied
>> + * @vm_st:        8-bit ST for volatile mem
>> + * @vm_xst:       16-bit extended ST for volatile mem
>> + * @pm_st_valid:  8-bit ST for persistent memory is valid
>> + * @pm_xst_valid: 16-bit extended ST for persistent memory is valid
>> + * @pm_ph_ignore: 1 => PH was and will be ignored, 0 => PH should be supplied
>> + * @pm_st:        8-bit ST for persistent mem
>> + * @pm_xst:       16-bit extended ST for persistent mem
>> + */
>> +union st_info {
>> +	struct {
>> +		u64 vm_st_valid : 1;
>> +		u64 vm_xst_valid : 1;
>> +		u64 vm_ph_ignore : 1;
>> +		u64 rsvd1 : 5;
>> +		u64 vm_st : 8;
>> +		u64 vm_xst : 16;
>> +		u64 pm_st_valid : 1;
>> +		u64 pm_xst_valid : 1;
>> +		u64 pm_ph_ignore : 1;
>> +		u64 rsvd2 : 5;
>> +		u64 pm_st : 8;
>> +		u64 pm_xst : 16;
>> +	};
>> +	u64 value;
>> +};
>> +
>> +static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
>> +			   union st_info *info)
>> +{
>> +	switch (req_type) {
>> +	case PCI_TPH_REQ_TPH_ONLY: /* 8-bit tag */
>> +		switch (mem_type) {
>> +		case TPH_MEM_TYPE_VM:
>> +			if (info->vm_st_valid)
>> +				return info->vm_st;
>> +			break;
>> +		case TPH_MEM_TYPE_PM:
>> +			if (info->pm_st_valid)
>> +				return info->pm_st;
>> +			break;
>> +		}
>> +		break;
>> +	case PCI_TPH_REQ_EXT_TPH: /* 16-bit tag */
>> +		switch (mem_type) {
>> +		case TPH_MEM_TYPE_VM:
>> +			if (info->vm_xst_valid)
>> +				return info->vm_xst;
>> +			break;
>> +		case TPH_MEM_TYPE_PM:
>> +			if (info->pm_xst_valid)
>> +				return info->pm_xst;
>> +			break;
>> +		}
>> +		break;
>> +	default:
>> +		return 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +#define TPH_ST_DSM_FUNC_INDEX	0xF
> 
> 
> Where is this coming from? Any spec to refer to?

See comment above: https://members.pcisig.com/wg/PCI-SIG/document/15470

> 
> 
>> +static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
>> +				  union st_info *st_out)
>> +{
>> +	union acpi_object arg3[3], in_obj, *out_obj;
>> +
>> +	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 7,
> 
> 
> Again, what is this revision 7 based on? Specs?

https://members.pcisig.com/wg/PCI-SIG/document/15470

> 
> I'm trying to use this patchset and this call fails. I've tried to use
> lower revision numbers with no success.
> 
> FWIW, I got no DSM function at all. This could be a problem with my BIOS
> or system, but in any case, this should be clearer specified in the code.

Please make sure both BIOS is the latest version and BIOS option is 
turned on. You should be able to find the GUID defined in PCIe ECN after 
dumping ACPI table.

> 
> 
>> +			    BIT(TPH_ST_DSM_FUNC_INDEX)))
>> +		return AE_ERROR;
>> +
>> +	/* DWORD: feature ID (0 for processor cache ST query) */
>> +	arg3[0].integer.type = ACPI_TYPE_INTEGER;
>> +	arg3[0].integer.value = 0;
>> +
>> +	/* DWORD: target UID */
>> +	arg3[1].integer.type = ACPI_TYPE_INTEGER;
>> +	arg3[1].integer.value = cpu_uid;
>> +
>> +	/* QWORD: properties, all 0's */
>> +	arg3[2].integer.type = ACPI_TYPE_INTEGER;
>> +	arg3[2].integer.value = 0;
>> +
>> +	in_obj.type = ACPI_TYPE_PACKAGE;
>> +	in_obj.package.count = ARRAY_SIZE(arg3);
>> +	in_obj.package.elements = arg3;
>> +
>> +	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 7,
>> +				    TPH_ST_DSM_FUNC_INDEX, &in_obj);
>> +	if (!out_obj)
>> +		return AE_ERROR;
>> +
>> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
>> +		ACPI_FREE(out_obj);
>> +		return AE_ERROR;
>> +	}
>> +
>> +	st_out->value = *((u64 *)(out_obj->buffer.pointer));
>> +
>> +	ACPI_FREE(out_obj);
>> +
>> +	return AE_OK;
>> +}
>> +
>>    /* Update the TPH Requester Enable field of TPH Control Register */
>>    static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
>>    {
>> @@ -140,6 +253,47 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
>>    	return pci_write_config_word(pdev, offset, tag);
>>    }
>>    
>> +/**
>> + * pcie_tph_get_cpu_st() - Retrieve Steering Tag for a target memory associated
>> + * with a specific CPU
>> + * @pdev: PCI device
>> + * @mem_type: target memory type (volatile or persistent RAM)
>> + * @cpu_uid: associated CPU id
>> + * @tag: Steering Tag to be returned
>> + *
>> + * This function returns the Steering Tag for a target memory that is
>> + * associated with a specific CPU as indicated by cpu_uid.
>> + *
>> + * Returns 0 if success, otherwise negative value (-errno)
>> + */
>> +int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>> +			unsigned int cpu_uid, u16 *tag)
>> +{
>> +	struct pci_dev *rp;
>> +	acpi_handle rp_acpi_handle;
>> +	union st_info info;
>> +
>> +	rp = pcie_find_root_port(pdev);
>> +	if (!rp || !rp->bus || !rp->bus->bridge)
>> +		return -ENODEV;
>> +
>> +	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
>> +
>> +	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
>> +		*tag = 0;
>> +		return -EINVAL;
>> +	}
>> +
>> +	*tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
>> +
>> +	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu_uid=%d, tag=%#04x\n",
>> +		(mem_type == TPH_MEM_TYPE_VM) ? "volatile" : "persistent",
>> +		cpu_uid, *tag);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(pcie_tph_get_cpu_st);
>> +
>>    /**
>>     * pcie_tph_set_st_entry() - Set Steering Tag in the ST table entry
>>     * @pdev: PCI device
>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>> index a0c93b97090a..c9f33688b9a9 100644
>> --- a/include/linux/pci-tph.h
>> +++ b/include/linux/pci-tph.h
>> @@ -9,9 +9,23 @@
>>    #ifndef LINUX_PCI_TPH_H
>>    #define LINUX_PCI_TPH_H
>>    
>> +/*
>> + * According to the ECN for PCI Firmware Spec, Steering Tag can be different
>> + * depending on the memory type: Volatile Memory or Persistent Memory. When a
>> + * caller query about a target's Steering Tag, it must provide the target's
>> + * tph_mem_type. ECN link: https://members.pcisig.com/wg/PCI-SIG/document/15470.
>> + */
>> +enum tph_mem_type {
>> +	TPH_MEM_TYPE_VM,	/* volatile memory */
>> +	TPH_MEM_TYPE_PM		/* persistent memory */
>> +};
>> +
>>    #ifdef CONFIG_PCIE_TPH
>>    int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>    			  unsigned int index, u16 tag);
>> +int pcie_tph_get_cpu_st(struct pci_dev *dev,
>> +			enum tph_mem_type mem_type,
>> +			unsigned int cpu_uid, u16 *tag);
>>    bool pcie_tph_enabled(struct pci_dev *pdev);
>>    void pcie_disable_tph(struct pci_dev *pdev);
>>    int pcie_enable_tph(struct pci_dev *pdev, int mode);
>> @@ -20,6 +34,10 @@ int pcie_tph_modes(struct pci_dev *pdev);
>>    static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>    					unsigned int index, u16 tag)
>>    { return -EINVAL; }
>> +static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>> +				      enum tph_mem_type mem_type,
>> +				      unsigned int cpu_uid, u16 *tag)
>> +{ return -EINVAL; }
>>    static inline bool pcie_tph_enabled(struct pci_dev *pdev) { return false; }
>>    static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>>    static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)

