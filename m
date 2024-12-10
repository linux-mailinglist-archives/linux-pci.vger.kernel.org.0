Return-Path: <linux-pci+bounces-17990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A809EA940
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 08:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6216280C34
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E067227599;
	Tue, 10 Dec 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LSmIJWXj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948822617C
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814435; cv=fail; b=mpnFd15j/f/K0PlvjLpxbFlgj1tMD5l7wnw8ZyoTR9bcMY15v6FgV2WtU1tfg2VCSgbNXKGTsPnxXYvbDp38iaA2rArV4c4MH9DCSgQR7O7lq/4P+gz13orUziz9/3Y5B6rHRF5k4hi1ANRlqNh4gJh2b4+iNmJNiu9a5WQRyyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814435; c=relaxed/simple;
	bh=oGGcQ3vaonF96XtQqGDl1COzu5maC99wJHn4daSF574=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d7bC3GdtZm4+l7ctSfFA25agcbbG5dCZiIqunQaLjRrJvQmbOQYqIWQToZAxAh5bJGCOlHy8FO+A3zOVxhiPsJDq06mZaXtQERFxaVH01jgTHen1r+yCVMjQBM+GR8/gyUCwNZyU4FOUh5bKtkZOfZKIWpOX/kg2gmk1Td3H4Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LSmIJWXj; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6Dgcdu0beZ6rPoPGsgBNZIFesy1uSPdov/8cVFC7+R4Zj+fAAt2yW2ZfOwqicgcXFHTAwSY2e2mAL/6ux70DRp4auB18N9CL2l2GNUStkw6eVPKBHMgNiGIRUmqDa9HAePT01DRnhJ447d27XpxwI790T9CHVB91pWcTtI3hB1lQveYam9+qfow+1xSIbtk6bPdT5RzeFjwWYNziQ9+FA0VeUxiXwUNOyQv68iB1Rk63/lbhGo/ARjmAZ9uS7/n+HUm+n4GdJyLzyyzj90x/9C++wd0RuHeTK0Q+34UqUZ8yqPkmls1PMEzfKJ8sY1gnmsCHQzeU5sH5sP9ufMdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv9GyS5N+qHeUdE0lVCf/1g4+lk702Qt7TBQHMxd59g=;
 b=V3LmUKjsse4q2mY86jY5repkVNNmPR4Ms7p8hiGy8deLVER3uk6T0fVfEpIAGTE+1+qwigEsj4WkDQFoEhNi9AgrGsYaE7lnnGCqz9R7m9Y9ToEv+c0yD2ueNe+p5bGrGaWgEtrfX8ZqJ4dPdRtyc2yEtSBD8qlV/tKMB1RIZHARsnK48yoG8KpeISIR8v36sHpYNPMZMN0VKgSYcOkwlUzO1GexiqD+QX5cFEa0OFP/QFJcaLCaaWPmnvcej2wc90z6dgBvepN80CN7t6t02mTlyghDZJDA4XU1ghb5hviJKVomgDYrnRt0qKQ+IgLCrVywua02wxaESgcKsQzrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv9GyS5N+qHeUdE0lVCf/1g4+lk702Qt7TBQHMxd59g=;
 b=LSmIJWXj9gNEyE3Egt+y8uHnKC5zUNq+zcIAbGgCNEcESwTw8Wa/lbHI1KjqpZE3gxMZXUj7X/IrIYMNNFyL6BBFS0GoTc2wbau0Mhh34mkjHbdwkGaES5ht19IAzGpyg//XluR7U+cmmwIknjZ9hLFrWHjWxFTEGg1BP+JtBOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 07:07:10 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 07:07:10 +0000
Message-ID: <ad512345-793b-4cfe-a71b-445f2be64df5@amd.com>
Date: Tue, 10 Dec 2024 18:07:07 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0036.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 53567468-8384-46b2-24de-08dd18e943cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlBKdTB0aDlrRldtM1ZvYXV1RHI4bmVBdTdlREU0cWFISlpWNVpnaHR6bjBE?=
 =?utf-8?B?ZGNFSHRITmRxTXJHWXBRMjZUejJpZGRZcTlMM2V1amE4STdOaE1GOG42NjBj?=
 =?utf-8?B?d2VlR2RsKzRqUmZkSUxMY0E5NlZLRWw4ait0L28wNm1Pemt3REkvWmV5SzFP?=
 =?utf-8?B?aEJFREZaQllBWVlROUx0dkhEM2Ruc1BnaGlvWnRGUmdURU4reVgyWGtQYlVm?=
 =?utf-8?B?V3VvUVpIUi9ndThwWDJMcHR0SWZDSitWTjIxODJ5WHNwTHplNmdnRklWN21Z?=
 =?utf-8?B?T3hTcUxkaHM3cTRDYTU0V0x5T1VDdlRyUXR6cWt4NXpYVURrTGNYYzhyRncv?=
 =?utf-8?B?Wnd4eEJwRlJocUJuRzBna0p2RkRQdW5PTzZxK0hxTDZIQUJ3TUdtQVNYbGhE?=
 =?utf-8?B?NFl6Vk96eGp1QmRlbytFVmwrTFJMWXNtUXNuNUNCN2J6OFJuRHdnczQra29F?=
 =?utf-8?B?V2lVdi9iM1BISlgwanpYcEs2NWNsS0ROL1pBek5oRXJiVkZ5ZUxCVVdUSzhR?=
 =?utf-8?B?b1BzeFRyMEV1RTlSRVRabFNSU0MwUFk1TmVVOG4zc29FSmlXOWlGTWtkbHdL?=
 =?utf-8?B?ZkppTGVNOGtjT2ZRM2tXOUtxUFA1cEhJVHRjTkIvYVRYWnYzWk16d1hVRW14?=
 =?utf-8?B?TklVeTFpdjVOZEowRVBQbGQxeUE1bEtheFZvOHltOVEyQlJob2lleXNJM1U5?=
 =?utf-8?B?emxtK1ltekR6MkRTTU5pdW5iNDI5T1dBNE9zTjRBclQ1NVZoUU85L2pzNW5s?=
 =?utf-8?B?aGs3MzgrcE9yeGsrdHBKZW1mYkxneFAxVnFJTWI4L3J2Z3IwTzBZU2dlV2RM?=
 =?utf-8?B?U1cwcmNKV1RQZy9TeFZGRlNaNU03NWl5T3Z5MXN6Nlh0WmlRZHNFc01mandD?=
 =?utf-8?B?RTBkSG9kMkpxUVhKYWJpMWlXWVRQUVp3NnUySnZNYkttNFpSWjNWS1ZxUWhi?=
 =?utf-8?B?UnZGdmJNM3l4b21GMzlwQjJmdUp2aXVKRUNlZVRNL01HQVJwcDhlVk5UVE5G?=
 =?utf-8?B?ZkJEUzFhRVpBR2RpdGliaFZlVFEzVW5VZWZLdzltZ3RZSkc0SXBjZzFsZUJ5?=
 =?utf-8?B?WkxxOThuNURDcGxoNjlEeWJBZWx0TEE5eXBwU1FtU3IyUWJDa2c4MVdRZ3A2?=
 =?utf-8?B?bm5aZVJ2bjVSZXRKUnQ1NXdaZGxIaEthZHJ2dGMxUTNNZFlCWHd2TUZBUFNq?=
 =?utf-8?B?WUNuL2JMdWJ4bnRCaFBGQkJMc1ZuWGV3ZGwvMWxMQk15ZmdSa3JqZE55VmRH?=
 =?utf-8?B?ajRqZWYvRkdVU2I5M3pKUUJQMVJmaUJIZWJHUzZtdk1GVGREaXBTUGNNWTFw?=
 =?utf-8?B?enZvL3JiczYzRCtORkhjTUczazRrTHJVUmVjcDFkUnE3ZFY4VUxhOGJvMlpr?=
 =?utf-8?B?NHpvNzBTS1JuVkNOL29lWVNjRDMwUElFU29EZng3MkkwcUw4bmJubmUwT3lt?=
 =?utf-8?B?dUhxKzc4TjVOWWN1dlhvbEJ6bmlrOFAyRUt2RWNkaTdialpBNXR2QmM5TDlS?=
 =?utf-8?B?bllHazVmSWx5ZEppTDJUNmJtYytsUk5aNGlMRWw2VC9lV1hoeUNqSTlsYm1S?=
 =?utf-8?B?ZmdRQWFVUHB4Q1FzZUVRTGhyeE9JZEQvYWpaWkNZVFBFbzF2aWZzMkNLa3JO?=
 =?utf-8?B?K2dFRVJLckVMZXZBM2xkMW9VMWE1aE5ONUxad3EvS1NLczJJWW9nMXgrbU5G?=
 =?utf-8?B?SDhsd3A3dnREMjhOWEpONG0vaFRjZEw5alU1eDJLaGtKTmQ5aXlhbEwvaGZK?=
 =?utf-8?B?T3dzbENtQW9vQnRsSWFXeWxSbDZtdnkyVG1tVG02cVdaV3B1WW9MQVM3ekdi?=
 =?utf-8?B?Q2RSb1A4TE1SOE9WVDdNQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Skt3YmxCbDZCQi9VK0NzTEZJU25qTzZ4YzRlbkpQVEc1SVlWVVJnbHFNcVUx?=
 =?utf-8?B?eUMzN2ZoTE1VS0w1c29OOWdYMzdoSytYSzNjSDVKam12NGhNMFZ4cnVwL0tE?=
 =?utf-8?B?c3Rndi9wTjVLeXlGMWZzcm80ZzhLSWNoWVhwQUV6WkI4YUlkQzdaQ3dSSkhD?=
 =?utf-8?B?ZXNjb2lHUFJ5dGxUbzJnQUNjZDB0T092S25zTngvTnVpdFErSmRMakl5MTVq?=
 =?utf-8?B?cWlxSmgzTXAzOHJpQmxTYlJNU0w3Z2liUmMvajZoa1lKYmE1ODZpbjJkUG94?=
 =?utf-8?B?RTIxYndQNjlmMHpNYlluM0Fsang5Q2pxQnFaSVlJTk44c0drVSs3TXduN0pj?=
 =?utf-8?B?Tlo5cE81NGUyekZUNnppb2RlbmQxdXZ3aGtXQXpJc1FmTDdGZDdONDBaS2wy?=
 =?utf-8?B?NEtVaXFTU1gwT0ZXUkZvWmFXM3ZNdCtJZlAyVHFoVTI0NmFIQUpCZElwMTVo?=
 =?utf-8?B?ZHhoQ1NNUWVuRHJqL3prRXVJQU94WWZpU1ZLUGNyaVM3M24rcm5maWliUlli?=
 =?utf-8?B?ZmJEL3gzRGdYeDFNZmtlaHZzTTdjWjRLcW03SUptUWZUYVhlMDJ4TGh4Rmdm?=
 =?utf-8?B?UWFweXJ0QTg0ZFhUbDNrdTl1dURuQ3RxZ1RUR1ZxZUhHcFZPRFg4dmgzWG11?=
 =?utf-8?B?ZEJoNTFLbEMyUmZBUVJ3TFMzcmFYd3FoVXdkdHBFaWJ5YXVqUzRGRERZMkI0?=
 =?utf-8?B?TC95Zmx3RUxKQU1BUElLYXlFd2NQUFV3TlpmVS9pY1hnMXBwWmNja0xCUnow?=
 =?utf-8?B?ODNhNktLaEZUVXRNNWt4MFFiWGlIVzlWRWIwS1pPeVh6cFl0SVY3TGNEZWR0?=
 =?utf-8?B?ejU3RFk3UTR6ZU9HUzVlZHB5QlV3c2o1UEVwMGNIblNXcG1MdmlMY1RrTDIy?=
 =?utf-8?B?NG9GVVo1SnV3UldNbEdOTWtJd0JGVXQyUXF1VHd1ZXVJZ1VPYm1DbDlIR1pY?=
 =?utf-8?B?OXdCZU0xbmdNREhSclQybW1NZEU5Q0FvTmFhZTdGekNtWHBsdlVlR3hDNUQz?=
 =?utf-8?B?UnUyS0tPQ3V1R2ZINWMxWEZkY2VHdVJFbXNmRFEyNkFqNnBiNExMQ004dEtt?=
 =?utf-8?B?SXBrdGQ5MDFlTC9EKy84Ums3U0dTZWhpVkxlTHdQUlpNTmtvNEs3TGNEbmJ6?=
 =?utf-8?B?VHBBZHZWdGRrM1JMbWJPUzlZMXJ4aTJKYzVnTzd0aDFJU2JSK2U2WEEweTl1?=
 =?utf-8?B?c00wZ1Q4TklBdGxkL2VDL29BUUpOUHY4VzBrTVZyMkNWZzVHTW8xL3hrdmUx?=
 =?utf-8?B?dnNxLytPUjZaN2tyRWhIOXdnVXBoMGpxd1ZVNjRPcmQ4aWhMc1pmeUZvbm9l?=
 =?utf-8?B?Wk92L1ZOeUR4QWd2RjZJUUVYbkFFdnVMSi84Sk90YjVQZWlHdWJ0d2g5UG1X?=
 =?utf-8?B?VUIxeVhOYXRkQllJNnU0WVVPL3NaSTQvZU13VlhYWVpGdFRrUGRzZzk2MmlM?=
 =?utf-8?B?ZVUrVTBDMHovTTA1dDUrWHlCNXdwL28rTmlJRkxWNWRKTjFZdkhaMzRKUnBT?=
 =?utf-8?B?U0c3Uzg1MFlCL09iMTlYcUo5ZjErM1RsV2d4d0ZWZnlFMktKeGVBQTE4VlNO?=
 =?utf-8?B?bkFlVC9Nc0daTVR6anBPZVVkQjBEb0FCeHR5b0lyZ2RGZFdHa3J2QzF0dHpx?=
 =?utf-8?B?LzBIYkhybExnWVdoOGZOc0NVcFlEZVVtRWFzTTZiSDRsYVlpVDFyNGtpV1Jk?=
 =?utf-8?B?SDRLQVhCaVNMb0MrZlpxcEw4ZUNEd09tZjZ5S2dIcDhFSWZNVjAwRzdScERz?=
 =?utf-8?B?R2dMV2dpNnhxMEJIY0ZaK3FTaU9vQVQ2dFVkcDlGQzBnd0ZwcjdUMmRYK2pF?=
 =?utf-8?B?bWV0alNUU2hndDdrRUJEZHFKV0ZGRzN3dGxiNUE2ZmVnVFhCdzJXMlBtRURp?=
 =?utf-8?B?ZUJLNERDL0hLeXh6dlQzUzFGV3dJUThabStCb2owTG1MbnpjTmdVU3RmTVc2?=
 =?utf-8?B?K2VHZENIT0RVclZCcXYrNnVlb2FySGJ0UWd0TWtUZE5ieXl0Z0g1dGFaWFdv?=
 =?utf-8?B?OFM2TDd3WHlmejF6RmYxNFFVcE8vK1JRNiswWmF0dEZIU3RCUW90L1EvMHJ0?=
 =?utf-8?B?QkNXc285N1pHbUQ5a3BsbUdsUG5oRjg1TnF4RW9rYjJGSGFEaTNCVGx5eU01?=
 =?utf-8?Q?0a+O7guQotb/p6lu016sNG9fx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53567468-8384-46b2-24de-08dd18e943cc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:07:10.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuSx+fPc1W7FCQUi/7jkpZBet2sDP+2DHl4D3/zxt1wa3Xj5H4nFJNvAK2wqkgRkcRxwAyJy9PvhQ8le1NTjeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872

On 6/12/24 09:24, Dan Williams wrote:
> There are two components to establishing an encrypted link, provisioning
> the stream in config-space, and programming the keys into the link layer
> via the IDE_KM (key management) protocol. These helpers enable the
> former, and are in support of TSM coordinated IDE_KM. When / if native
> IDE establishment arrives it will share this same config-space
> provisioning flow, but for now IDE_KM, in any form, is saved for a
> follow-on change.
> 
> With the TSM implementations of SEV-TIO and TDX Connect in mind this
> abstracts small differences in those implementations. For example, TDX
> Connect handles Root Port registers updates while SEV-TIO expects System
> Software to update the Root Port registers. This is the rationale for
> the PCI_IDE_SETUP_ROOT_PORT flag.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM manages allocation of stream-ids, this is why the stream_id is
> passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_probe()
>    Gather stream settings (devid and address filters)
> pci_ide_stream_setup()
>    Program the stream settings into the endpoint, and optionally Root Port)
> pci_ide_enable_stream()
>    Run the stream after IDE_KM
> 
> In support of system administrators auditing where platform IDE stream
> resources are being spent, the allocated stream is reflected as a
> symlink from the host-bridge to the endpoint.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   .../ABI/testing/sysfs-devices-pci-host-bridge      |   28 +++
>   drivers/pci/ide.c                                  |  192 ++++++++++++++++++++
>   drivers/pci/pci.h                                  |    4
>   drivers/pci/probe.c                                |    1
>   include/linux/pci-ide.h                            |   33 +++
>   include/linux/pci.h                                |    4
>   6 files changed, 262 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>   create mode 100644 include/linux/pci-ide.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> new file mode 100644
> index 000000000000..15dafb46b176
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -0,0 +1,28 @@
> +What:		/sys/devices/pciDDDDD:BB
> +		/sys/devices/.../pciDDDDD:BB
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		A PCI host bridge device parents a PCI bus device topology. PCI
> +		controllers may also parent host bridges. The DDDDD:BB format
> +		convey the PCI domain number and the bus number for root ports
> +		of the host bridge.
> +
> +What:		pciDDDDD:BB/firmware_node
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) Symlink to the platform firmware device object "companion"
> +		of the host bridge. For example, an ACPI device with an _HID of
> +		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00).
> +
> +What:		pciDDDDD:BB/streamN:DDDDD:BB:DD:F
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a host-bridge has established a secure connection,
> +		typically PCIe IDE, between a host-bridge an endpoint, this
> +		symlink appears. The primary function is to account how many
> +		streams can be returned to the available secure streams pool by
> +		invoking the tsm/disconnect flow. The link points to the
> +		endpoint PCI device at domain:DDDDD bus:BB device:DD function:F.
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index a0c09d9e0b75..c37f35f0d2c0 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -5,6 +5,9 @@
>   
>   #define dev_fmt(fmt) "PCI/IDE: " fmt
>   #include <linux/pci.h>
> +#include <linux/sysfs.h>
> +#include <linux/pci-ide.h>
> +#include <linux/bitfield.h>
>   #include "pci.h"
>   
>   static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
> @@ -71,3 +74,192 @@ void pci_ide_init(struct pci_dev *pdev)
>   	pdev->sel_ide_cap = sel_ide_cap;
>   	pdev->nr_ide_mem = nr_ide_mem;
>   }
> +
> +void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
> +{
> +	hb->ide_stream_res =
> +		DEFINE_RES_MEM_NAMED(0, 0, "IDE Address Association");

out of curiosity - should it be DEFINE_RES_MEM_NAMED(0, UINT_MAX, "IDE 
Address Association");?


> +}
> +
> +/*
> + * Retrieve stream association parameters for devid (RID) and resources
> + * (device address ranges)
> + */
> +void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int num_vf = pci_num_vf(pdev);
> +
> +	*ide = (struct pci_ide) { .stream_id = -1 };
> +
> +	if (pdev->fm_enabled)
> +		ide->domain = pci_domain_nr(pdev->bus);
> +	ide->devid_start = pci_dev_id(pdev);
> +
> +	/* for SR-IOV case, cover all VFs */
> +	if (num_vf)
> +		ide->devid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
> +					   pci_iov_virtfn_devfn(pdev, num_vf));
> +	else
> +		ide->devid_end = ide->devid_start;
> +
> +	/* TODO: address association probing... */
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_probe);
> +
> +static void __pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int pos;
> +
> +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> +			     pdev->nr_ide_mem);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +	for (int i = ide->nr_mem - 1; i >= 0; i--) {
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
> +	}
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
> +}
> +
> +static void __pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int pos;
> +	u32 val;
> +
> +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> +			     pdev->nr_ide_mem);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +
> +	for (int i = 0; i < ide->nr_mem; i++) {
> +		val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
> +		      FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,
> +				 lower_32_bits(ide->mem[i].start) >>
> +					 PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT) |
> +		      FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,
> +				 lower_32_bits(ide->mem[i].end) >>
> +					 PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), val);
> +
> +		val = upper_32_bits(ide->mem[i].end);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), val);
> +
> +		val = upper_32_bits(ide->mem[i].start);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), val);
> +	}
> +}
> +
> +/*
> + * Establish IDE stream parameters in @pdev and, optionally, its root port
> + */
> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
> +			 enum pci_ide_flags flags)
> +{
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	int mem = 0, rc;
> +
> +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> +		pci_err(pdev, "Setup fail: Invalid stream id: %d\n", ide->stream_id);
> +		return -ENXIO;
> +	}
> +
> +	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
> +		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
> +			ide->stream_id);
> +		return -EBUSY;
> +	}
> +
> +	ide->name = kasprintf(GFP_KERNEL, "stream%d:%s", ide->stream_id,
> +			      dev_name(&pdev->dev));
> +	if (!ide->name) {
> +		rc = -ENOMEM;
> +		goto err_name;
> +	}
> +
> +	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, ide->name);
> +	if (rc)
> +		goto err_link;
> +
> +	for (mem = 0; mem < ide->nr_mem; mem++)
> +		if (!__request_region(&hb->ide_stream_res, ide->mem[mem].start,
> +				      range_len(&ide->mem[mem]), ide->name,
> +				      0)) {
> +			pci_err(pdev,
> +				"Setup fail: stream%d: address association conflict [%#llx-%#llx]\n",
> +				ide->stream_id, ide->mem[mem].start,
> +				ide->mem[mem].end);
> +
> +			rc = -EBUSY;
> +			goto err;
> +		}
> +
> +	__pci_ide_stream_setup(pdev, ide);
> +	if (flags & PCI_IDE_SETUP_ROOT_PORT)
> +		__pci_ide_stream_setup(rp, ide);
> +
> +	return 0;
> +err:
> +	for (; mem >= 0; mem--)
> +		__release_region(&hb->ide_stream_res, ide->mem[mem].start,
> +				 range_len(&ide->mem[mem]));
> +	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +err_link:
> +	kfree(ide->name);
> +err_name:
> +	clear_bit_unlock(ide->stream_id, hb->ide_stream_ids);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> +
> +void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int pos;
> +	u32 val;
> +
> +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> +			     pdev->nr_ide_mem);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
> +	      FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1);


FIELD_PREP(PCI_IDE_SEL_CTL_EN) is missing here.

And no PCI_IDE_SETUP_ROOT_PORT here, is the platform expected to enable 
it explicitely? If yes, then we do not need PCI_IDE_SETUP_ROOT_PORT 
really. If no, then this needs to enable the stream on the rootport.

Also, my test device wants PCI_IDE_SEL_CTL_TEE_LIMITED to work, I wonder 
how to showel it in here, add a "unsigned dev_sel_ctl" to pci_ide?
And the same comment for PCI_IDE_SEL_CTL_CFG_EN on the rootport. 
"unsigned rootport_sel_ctl"?



> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_enable_stream);
> +
> +void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int pos;
> +
> +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> +			     pdev->nr_ide_mem);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_disable_stream);
> +
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
> +			     enum pci_ide_flags flags)
> +{
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +	__pci_ide_stream_teardown(pdev, ide);
> +	if (flags & PCI_IDE_SETUP_ROOT_PORT)
> +		__pci_ide_stream_teardown(rp, ide);
> +
> +	for (int i = ide->nr_mem - 1; i >= 0; i--)
> +		__release_region(&hb->ide_stream_res, ide->mem[i].start,
> +				 range_len(&ide->mem[i]));
> +	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +	kfree(ide->name);
> +	clear_bit_unlock(ide->stream_id, hb->ide_stream_ids);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6565eb72ded2..b267fabfd542 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -465,8 +465,12 @@ static inline void pci_npem_remove(struct pci_dev *dev) { }
>   
>   #ifdef CONFIG_PCI_IDE
>   void pci_ide_init(struct pci_dev *dev);
> +void pci_init_host_bridge_ide(struct pci_host_bridge *bridge);
>   #else
>   static inline void pci_ide_init(struct pci_dev *dev) { }
> +static inline void pci_init_host_bridge_ide(struct pci_host_bridge *bridge)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_PCI_TSM
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6c1fe6354d26..667faa18ced2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -608,6 +608,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>   	bridge->native_dpc = 1;
>   	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
>   	bridge->native_cxl_error = 1;
> +	pci_init_host_bridge_ide(bridge);
>   
>   	device_initialize(&bridge->dev);
>   }
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> new file mode 100644
> index 000000000000..24e08a413645
> --- /dev/null
> +++ b/include/linux/pci-ide.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#ifndef __PCI_IDE_H__
> +#define __PCI_IDE_H__
> +
> +#include <linux/range.h>
> +
> +struct pci_ide {
> +	int domain;

Not much point in caching this, real easy to calculate in that one spot.
Thanks,

ps. I'll probably be commenting more on the same things as I try using 
all this :)


> +	u16 devid_start;
> +	u16 devid_end;
> +	int stream_id;
> +	const char *name;
> +	int nr_mem;
> +	struct range mem[16];
> +};
> +
> +void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide);
> +
> +enum pci_ide_flags {
> +	PCI_IDE_SETUP_ROOT_PORT = BIT(0),
> +};
> +
> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
> +			 enum pci_ide_flags flags);
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
> +			     enum pci_ide_flags flags);
> +void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide);
> +#endif /* __PCI_IDE_H__ */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 10d035395a43..5d9fc498bc70 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -601,6 +601,10 @@ struct pci_host_bridge {
>   	int		domain_nr;
>   	struct list_head windows;	/* resource_entry */
>   	struct list_head dma_ranges;	/* dma ranges resource list */
> +#ifdef CONFIG_PCI_IDE			/* track IDE stream id allocation */
> +	DECLARE_BITMAP(ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
> +	struct resource ide_stream_res; /* track ide stream address association */
> +#endif
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>   	int (*map_irq)(const struct pci_dev *, u8, u8);
>   	void (*release_fn)(struct pci_host_bridge *);
> 

-- 
Alexey


