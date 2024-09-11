Return-Path: <linux-pci+bounces-13038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A949754FD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 16:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3041C21459
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 14:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4E224F6;
	Wed, 11 Sep 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UZ0RHW81"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF218592F;
	Wed, 11 Sep 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063746; cv=fail; b=P/u8Jn2Mjmy14ai3Z4nKzM+N5FD8q4w6FTqsdjV15DXvZbvYUBLj9j3f/QDJfiuaKAzHVAvN+rWEeG42pwP51W9pD12VERT01r57AasTNP8a5HDaHpK5yqwi5Ct1yxQsaVUPFiHsgMas3Z+KEiO/5zBhCwoLQsGOQcbCx0KIYQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063746; c=relaxed/simple;
	bh=28b88R5zrxL6lrXaMLvK64IA1IKNzlPFAFFRZT+uijo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QA0nBUZHeEnQC/U0L7OR/1LbczKBsbI5Y0jGiDDomoJpiAFPOfM6p1aiYWdNboeyc2Vn8+/fbK+diOlkT/10LTBKaPEoSOq2+76A3dIYpNfHPsotoOdI8maUeXDU6KuHF4i9Lw/V50LkK8Qe0qApFZbveYvl2TMimf4MF4jHqHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UZ0RHW81; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E01KkNsIRb+vtiULDazAQUS7Nn1ZhXlYLJJmrBmGKH3cqRnz3k1yMUzOFU60ipVGHL8LECAd892qgvjDQibOUzQFB7BsipbWru96MfoRm5LMoiubKPKsCh11XnEk/bzffa51d8Mb5trcOYZnTovD5xPDs2YwCcG/qp4knkdpIe5Zg7NxeygdRl+vk+MUfMM/5jKMjxn7d1dAop0fHWD+8OkOf4GplexMUK16zdzXMLz3FGCIwCP93qDnDOwIIzy/13Bn78i5bo27GYi0fh7/TxgI4Mtv+gIaos3iASlJFqMQ5lFK79d2YZ3LGOfc8vNbLl/EQ3fOzg8yjJlqn35LDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2Fw4Aj48HrtHVkPuJq1GGggsuv1hnOPCjk89OSeDaQ=;
 b=eNHxq1MWb1zN5yCgsTMGZ98jHWy0+VYliG3XLFWfF4NSMQcrUtzrFksYozWbUFh8xjJ0k1pPsYe1Uc3Z5rvbMB7UFPSYJ0B8ELKNBrMZW6d9nQxRYi84cgXy+O0gEK1sTWAwPvOZN8h77NbMdK48h+df4Ug60YBy4tfKS00R8pZSjBrSmLWvkIPtYiCgAgCEY2gLoar0nMJmRuvauhWz/D7z5+Kxjh3N4/NOJ4eb1c4RDV+dOYnbHKzGfLXuuvo8/pOYbgLPVYKXV99PRkFWoVVZ/HoMxlquSSbpZ+gduOAbTqqAsnK4o6BOuk2M7dv2QPla3Vu2NbuqWLNYaoJUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Fw4Aj48HrtHVkPuJq1GGggsuv1hnOPCjk89OSeDaQ=;
 b=UZ0RHW81mn3M61PifW2rB7x2E+u7wbWC63+7ZVasK6ixiaW7rwjUKwzg5Voctyj5+uidZnQ2EwlUdbBhmEQX6UW/EQXo3yhVNz9kldxLWpwhxthIIs96oHvUjAqVothCczRcP5HblZ1b26IqK3qjse+GLtZcP1DP0ZApHdsnl/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 11 Sep
 2024 14:09:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 14:09:01 +0000
Message-ID: <2c435689-d2dc-4cf8-9d9c-dbe3ffd69c0e@amd.com>
Date: Wed, 11 Sep 2024 09:08:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
From: Mario Limonciello <mario.limonciello@amd.com>
To: bhelgaas@google.com
Cc: mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20240712062411.35732-1-kai.heng.feng@canonical.com>
 <6685e124-4a7d-44bb-80a9-fc5fa51269a9@amd.com>
Content-Language: en-US
In-Reply-To: <6685e124-4a7d-44bb-80a9-fc5fa51269a9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 928a721d-475c-4840-99d4-08dcd26b495b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0tSNm52U3FLYXRSMVdBYW9VSmN0a3Q1dmRIakxBTnlTM3l1SG00TnVEUjZn?=
 =?utf-8?B?bW81VU15Q0I0TVlINzJSSmwvU2wwSnVhZTkxNUtBWlF4aXJuSmc3K3ZjeVc0?=
 =?utf-8?B?dGZQakVlcnNiSXJ4b0FFUC9IdTdRYVNsUmFnSW5qd0x5bVR3eHFlcTBXNGd3?=
 =?utf-8?B?aStYMVpyTkRabC9zRHJWbC9QUFJsUkRGR2gzQ2dOblB0aGhXOHdJcFd1Wldu?=
 =?utf-8?B?dWRSamovUDRkVjBJeTYzTm9VMlVzMU50Rm15aEZOOE0zTGZxU2VuWDdXOERz?=
 =?utf-8?B?cFBqN2xpcStRSUU2MWo5ZU1XV2tuVTY4aHBDWmZCREpiNzN2VlVqbHhzc0g3?=
 =?utf-8?B?NDFxbUxLUXgrRzhTRzJDMWN4SkN1d3lWRUIvVG9FdEJ0M0o1MUM0eEN3azZn?=
 =?utf-8?B?REV5TzV5ZXUyY2thRDZIZ1drUWlzS0N2YUVHQ2tCMmJrd3JJKzV3a3RVbjBB?=
 =?utf-8?B?RTVSaUZ0eVdKMjZtdWFLbE16eUEvb1RGMlpOd3l0cGxLVmpYQlMwb2VxM2Nz?=
 =?utf-8?B?ZHdMSmFIYmQxNlJ5VGhvQVNOS2dSRm1DRkZGMUVFSmhZbXB1L1VsYUtTeWJv?=
 =?utf-8?B?dGxySjdTWmdqK3d4OXdQUnZ0WVRlaU9UUW1ka1M0Zno4blpmQ09tZ2hrUW5m?=
 =?utf-8?B?WDEwbGYrOU1JUzZSdG1laWI5bk5VcGlvNXhLUFM3ZVhJQzdpS1RLaEpOR2R2?=
 =?utf-8?B?cndyUHVvbjYzYktlSTVibU5KVVdKRUw0RThVR29BQWw3R3RmVHFwa043enNY?=
 =?utf-8?B?T3R3eEVxbzRWZndrd0RRUERwUUpVWkFER1FqT3FQbTc0dmRsZ3ZHTkNYWWlX?=
 =?utf-8?B?M3BoWkhycWhqUit2dVdXeGNmVm1pczVrdk1PTHM0RHp6NUdFdFB0SHVWNXBa?=
 =?utf-8?B?UUx5dkJNV3Bqak84TjdielFWVEJSU1U5bEJtUGROcWwrdDVjY1c0VUduUHoy?=
 =?utf-8?B?UTU0NTFUdFI3WDE4MTdJTmJNOXFUUm5MV25JK2IzeWFEY3hBeHE3V2hpNFlz?=
 =?utf-8?B?Y1RWOVJZQ2RxQ3BZRC83a0ZhM1p4VU9DWEl6ektXN1JJUkZLaXRRTW1rR3Jn?=
 =?utf-8?B?aDlKUHZEZ0ZlNzVPeTlOODdTcWsrY04vQS9TaGQyaUtzdkw4eWptMTBBUjF6?=
 =?utf-8?B?R2hQZzlyanYwek9uVHlYOERQdG8ySXF5RGd4NjRjYW9DajhsT25tN2J1SDVS?=
 =?utf-8?B?R2VkMHlHNEUvL3F6RHhYQmRVbWNpUm94TGZoOHJnUWcvVTRUVzBYV2xISUF4?=
 =?utf-8?B?UmtBWWZHcnBEQ1h2em1MeTRFekxWeWswNmo3VG9sdm9Pb0U3VnFBbWk5SjVP?=
 =?utf-8?B?Qy9IZUhmeHNob3RTaUk2OWgzL05qNjFkeGRCSlR2Z3Z6TzdZN21JSXpJb3h2?=
 =?utf-8?B?MFRNUkpESGRWV3ZId3J5N0RKN25jVkZ3YUZLZVV0MkRNR25MUWFQWXhiSHBq?=
 =?utf-8?B?N1VLaXl6WUd0djZKaDRsUjI5M0hlUjhVeHZLcHkzMzZmNTc4MGVQaVB3ZGdU?=
 =?utf-8?B?d21DVkYxVmxKbnpxRFVqZiszSWJpeHhVSjJRNzlZUk1PSEt5bmVLTUU3TTZS?=
 =?utf-8?B?YnFaRE5RZE9sa1Z4d0w3c1VUV2oyaXpkMVJYWkx6TXlXVE1yRy9qVXpFSUx5?=
 =?utf-8?B?RkU3SnllRmhJdElBUkhjQk5WR05iaFZrZXI4V2FwMnZXeGpGY2JJSUt3Tng1?=
 =?utf-8?B?MllhVVIxUUJZZGxibUFWLzVwM2tsWnpNcHFIUXlRMWpRcnJXVjFhZnZhRFFB?=
 =?utf-8?Q?/X5R9FqVTEJH5kK0sw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVZ1Q3J4dHJuOWhWTTF0RERUdThmZnZCRkR3b2JjOGRqUGVyWXVrZnU4WlEy?=
 =?utf-8?B?eUxqeVUwdUpXQWRxa2V4Q0RuV3phUkVNNWR0dndXQk8yd0h5WmhuL2ZvaUxQ?=
 =?utf-8?B?WEtaZzJRQkRmQXNBTTJLMy9WenBFTlJ0SGZrRml6Si9CWW1PYnJrTU1oQ1RV?=
 =?utf-8?B?KzY0UGovK09STTBINDd6TjNSOGZqTGlGYS9sMzRDVG96aDl3YmIzYnR6NVNx?=
 =?utf-8?B?aWwyVFBadFpOZmlWd3pKMjRaL2x1L3dZWWUxLzZ1a3RlRlNQdzdnd0NiOVJP?=
 =?utf-8?B?TGdlbHczemJDQnZsUzk0MnRYVzVJMU9uQ2FxZ1lOL3hPbHFrS3gwLy9weFhs?=
 =?utf-8?B?YjNmdlZrQmZMR1lsdWtyRUQyd1IyeWJLbVA5cmVNclh2dW0xWkxoRVhVZWdK?=
 =?utf-8?B?WGVGdm52NXFRQmgrcXJMVlBiVzBCcGdqamNZSGZqTUtVQm1USUgrSVdRUGc0?=
 =?utf-8?B?U1hLRWNSWEtpaXA2TytTbmVwblI2QllzaUxZbFpITEwrMHgrUlgwbnlvYTR3?=
 =?utf-8?B?TkdpVUUydnJlUEFzSUF2MHcxd3dVdjhXd29tb041S1U3QXJOb2RMckRBdjhS?=
 =?utf-8?B?NUhDS05QRVVnQS85S2xPNnE3RW5RV2JOR1BDWkEvMDVDckZQSUZqSVdJTzFU?=
 =?utf-8?B?SGFsSVFkWldyMERzTW1wblJmNTdSZ2dudVo5cFVMVk9PVTdmam1WeDFvUUgw?=
 =?utf-8?B?L28zQzg2Q0k0RytZOElnbVkyR084MGdwc2ZBaEVoZGtTMmRxVVFUWHJkdTBm?=
 =?utf-8?B?VE03dVdrUERTMlpWdE4ydGMyWExzRE1sQ2ZmSDRyZUdNdlZQMzBYOEhHcFhK?=
 =?utf-8?B?TDEwdjM5Z3JNQjFTQ3pSVXhldGdVb0NPdzN3eTRNWWJZN1V6UkJSbzBzdUJ5?=
 =?utf-8?B?MXhyZFo0NU8rZGhjS21uVkJrK09ZMzJuWDVZT3NxajJhS1VBS0tMMlQ1cFMw?=
 =?utf-8?B?K3BkWktYVjZRSnB0d3ZtNFBjc0xTampEdmlhSFU5NmJsRVRldEpNTHNkaWg0?=
 =?utf-8?B?bXlhZzBOODhpQUR3Q2xmN29pWXRQaEZTeDJyQWo0bjlOalozdXVmenpzUFdw?=
 =?utf-8?B?ZjdIRVNNOE5WWG1zV3hUWXo3ZzRUUTdVakRqbHRqSlVIN2oyQkdBYm9mSTNF?=
 =?utf-8?B?OVJGWi9vNTRvWndVYlZpR2NvN0tYc2ZEa2x6bUcvUGZWUW03MWtldjVpa05q?=
 =?utf-8?B?R2dhSytLWDhlTi9RaytDU1NYaFVDZVovTDgvbFppS2pPR3VnNU91Z2NLU1Yv?=
 =?utf-8?B?TzNvNUF5K3RmanpHYS8ybGRPb3R3d2lWeE9Mdk5vZTJhSDBLM0JqT0g3MS9z?=
 =?utf-8?B?NzRreEtPVUNzSXRmaVF3V3RWYVc0UTk0Z0tFYUJ1ZmkxUm1mNzdOQ21oSWIw?=
 =?utf-8?B?b3RXTkRMMVlFZWJIZ3hhWlhGMnExVHM2cDVUSExoS0JDelJ6NXpsUGJ5dGkw?=
 =?utf-8?B?SHFRSENwU2ZqeHFldUJEd3dma2dqUTRuaTMzZEZTUGoycWU0dnp6bXQ1RWRF?=
 =?utf-8?B?WVFEbzVHM1FPYmQ1RVFDeWswWFVVZFVLSFNwRkVCN3F6RVpadjd5T3NBTjJ4?=
 =?utf-8?B?dm16VEhWWGlGdVlTZHd5c3oxKzVCcUZ1bWpOc2FLUXdNd2FDQlUya3lOS0VT?=
 =?utf-8?B?T0lRZWhyTVY3aVJQUkhqNUsrbVpKRWZyc0E4Zzk3SjIrbWlEaWtBNUc4d21M?=
 =?utf-8?B?eWNTVWQ4bkV2Wk4zd2hFSzlwcytBTGdRSXUxK2xvcmlMRlkza0tIZW5TVHg3?=
 =?utf-8?B?RWVxcE02WWhRRGVabVJoU0htRTBFNkVQVDVZT0tZV2dwY0lNT2pMbHhQU1dB?=
 =?utf-8?B?WFg3aGdqV1RBSFRuWEtlK2M3MHM4aWlxWVVwS2UvcGdGcS8vZk1XT3V1aity?=
 =?utf-8?B?QnAxVmFKSGlyNVd4cVdBMVE5KzkrbVExamZoenY2T3o4dUZuaGlPUHN5cWdD?=
 =?utf-8?B?QTFsdkxqSmhCSXZsQmFVaG12L1k5aEQ1RUE2TTFjck1RQzEybHpkMWxNVEJY?=
 =?utf-8?B?SEdraGFnZFhMNjV6YVUwM0x4eDZQZGVQWDFwUVI5Y3h1NGhPOVhTU0REbThM?=
 =?utf-8?B?QXVZeEx5TWx2MjVNWjcrQ3N6K3QzWTU4eHBDNVhtOUVLc2lsTE9qTjFJTmUz?=
 =?utf-8?Q?RePqdNyaDK8vGOmQwViD7w0yg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928a721d-475c-4840-99d4-08dcd26b495b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 14:09:01.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUUUYTFzsMP8U0tiU2pA2p6G36jYyfgH65A51QKLA1Ck6wcsc7RIh9T67U7t6iyBXJD+iy+4wUWStdNFhwmj3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414

On 8/22/2024 14:28, Mario Limonciello wrote:
> On 7/12/2024 01:24, Kai-Heng Feng wrote:
>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>> connected.
>>
>> The following error message can be found during shutdown:
>> pcieport 0000:00:1d.0: AER: Correctable error message received from 
>> 0000:09:04.0
>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data 
>> Link Layer, (Receiver ID)
>> pcieport 0000:09:04.0:   device [8086:0b26] error 
>> status/mask=00000080/00002000
>> pcieport 0000:09:04.0:    [ 7] BadDLLP
>>
>> Calling aer_remove() during shutdown can quiesce the error message,
>> however the spurious wakeup still happens.
>>
>> The issue won't happen if the device is in D3 before system shutdown, so
>> putting device to low power state before shutdown to solve the issue.
>>
>> I don't have a sniffer so this is purely guesswork, however I believe
>> putting device to low power state it's the right thing to do.
> 
> KH,
> 
> I did testing with your patch along with a few others, and found that it 
> does the best job to put a majority of devices into a low power state 
> properly.
> 
> I have the details of what happens at S5 outlined on this Gist:
> https://gist.github.com/superm1/f8f81e52f5b1d55b64493fdaec38e31c
> 
> * KH column is this patch.
> * ML column is 
> https://lore.kernel.org/linux-usb/43594a1c-c0dd-4ae1-b2c4-f5198e3fe951@amd.com/T/#m03d0b36f86fb4722009b24a8ee547011128db80b
> * FS column is 0fab972eef49 being applied again
> 
> I also have power testing data from an OEM's system that shows that it 
> improves things well enough that a previously failing energy star 
> certification is now passing.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>

Bjorn,

As we're getting close to the merge window, any thoughts about this patch?

Thanks,

> 
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>   drivers/pci/pci-driver.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index af2996d0d17f..4c6f66f3eb54 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>>       if (drv && drv->shutdown)
>>           drv->shutdown(pci_dev);
>> +    /*
>> +     * If driver already changed device's power state, it can mean the
>> +     * wakeup setting is in place, or a workaround is used. Hence 
>> keep it
>> +     * as is.
>> +     */
>> +    if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
>> +        pci_prepare_to_sleep(pci_dev);
>> +
>>       /*
>>        * If this is a kexec reboot, turn off Bus Master bit on the
>>        * device to tell it to not continue to do DMA. Don't touch
> 


