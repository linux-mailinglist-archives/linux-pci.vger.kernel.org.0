Return-Path: <linux-pci+bounces-18820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BA09F865B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 21:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5BB1893BA3
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 20:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4CD22612;
	Thu, 19 Dec 2024 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wTdy+1h3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7B1C305A;
	Thu, 19 Dec 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641657; cv=fail; b=bbq5d0847yRPUFDDauIo6XT2OUqVpDX7FKNBm5///0x85psnWdxGc4ovgWz664Ng02lxnBL8izju/Bweq9iALgGmmKMz7Pa72fxCB+WDQ0EuAOFt6eRzfnCKvwGw900AhwzVRjUUu3twlavdGtPp0VdnidIrCIPYhvzgwdfSDlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641657; c=relaxed/simple;
	bh=Q6oHewDbjsgEvBRDNWi8l7v3Bnvjc1dkpYAc/zLwkuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJa2W1MNqiTVJGRafSU30pOfDblECzupgaOxnmWtVL5VvDrl3V64uAayde6dkcKvQVzScaPsIQjwFohzv6GwrqtA+Zd//wHtCS7mvv8h5/qVslHgt67jWbeRI1VCtvY5iLVkpv0d0pxneRPK6zUSfHZsHp0sMLREpOTC6DHrXz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wTdy+1h3; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOkmmp0inNEq60jmTam1b9CYDDSncz4cQj5xqv0ARE1fzcLXPOg8eVlDQYPILCd7XF60Hs6KIBsa4ztK/bevnX8YuQdgZb7NUPk+HFh4MfJHs+30lJYgI0ecbwnRWJKKsNx1PIymW43HBzq8niMO0+9sJEz2F31qeOae6eaOPWTzRDPw87IhTARAtzUIf9rE5KF1jJPv4hsqSziGY6Fy8prJROlAzgj0yIdyMRusKubLEyCr8jaSAtKfQCu2JeJAROkLl+A7o0UomHluMuyIuTos4ogtMnwbDkoJtdLJ+dgqkvwlpqlEMNQd+qMI0tguMJyydeA7ykuSqfrgoKACMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlCnDpIfP2CSYwBpuuiYwD+5iA9023yL+7G6VCCYxfk=;
 b=tUqgOuczq7LdSjp24MjkGhgEbJcZOCbqfX2cNDBQu+GpLIjyL2mQBf9gcNzdz9hj4Ig7pgSv+3Gi2euNUK6OIyEiz9m1BGJAxivB5ElFV2D3mR4Jy7Tu6aUaQQY9SO542GecDWcsf5orBacFSZPKmHBB2gNbOJd04OHb6CW+2hjiK50cgyTm7fIu6vBPpYWPJEJKOiVmU9ToFPlObqDjf1nDHHp3/0J0QqYhVcaIvwHAffn6y61Jr/chEeeEFPBP3X9nJ21IzwBUfmO9qWWF5QZWrPaLxl1xmOohVKXVyBH/yK+LTiJKtKJFPohnaoyom7IoDTtrieJqmmZSDEzuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlCnDpIfP2CSYwBpuuiYwD+5iA9023yL+7G6VCCYxfk=;
 b=wTdy+1h3dhKXcqbiVr3BeVsF7KbMDTmcNv1Uan8fxhtHorYNP0Yo70NBaplY1aNorNVl3jzH3PmUi+OPsVSV1IMrJSTcQBN7axn2LJGWaq2NLyi48Cw0IUOwmIEPgmDu4u4Rbr2NOHnbeJrz9XOnInwhqpLBhULb6g/Zof0lNa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 20:54:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 20:54:11 +0000
Message-ID: <0ab38bf7-874d-43cb-8236-1f46697df3a5@amd.com>
Date: Thu, 19 Dec 2024 14:54:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Werner Sembach <wse@tuxedocomputers.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241218103433.384027-1-wse@tuxedocomputers.com>
 <85537504-f107-44aa-9b6d-f61eb067b330@amd.com>
 <9487791a-784e-451b-a88c-7c578a6ead2e@tuxedocomputers.com>
 <dfd46eef-1ca3-48ef-b1c2-fa5601e5fd02@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <dfd46eef-1ca3-48ef-b1c2-fa5601e5fd02@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:806:122::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: f61d28c8-df6a-495b-7b5b-08dd206f4a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0FPTkUzMUt0a3loVitIYzdCdDdadHAxMlk2MWFSWXdlUHRKZkNTRTlEdnM0?=
 =?utf-8?B?YWVQa3gxOXlKaE12MDhBYUJQTkt4ZjE1d2dLSVVHSkI5ekp4TzcvOXFCenRj?=
 =?utf-8?B?YjF2MXBYMDBFL3lUZ21ib2JnaFUwN1BPRzdtTmZFUHR6RG9hQ0Q1T1dtd2Jl?=
 =?utf-8?B?M3paY2JaN0FBdFhJTXBPZDhGSnduQmFpT2Y5RHM3aXJhYm5ERWh5clBRMXFr?=
 =?utf-8?B?Q1FkdU1qL095czlHRmEyZndjdktNNWVoVStldGsrMlpsYkxnMGpjejB0Y2Q1?=
 =?utf-8?B?d1ZacXZodUI4ZGsvdWNQZWRmL1ZxRjg2VXhBNGQxaXZmcVo3cG51eDdGd05r?=
 =?utf-8?B?UGxUS0xVTitWVkp6bFFhdncyZ3BzeUp6WnB0SWFJYkx3UlZWYjNKK3h3bkRu?=
 =?utf-8?B?ZFo2K1Nrcit1QjFVeWVSdGhmRnBpSGd4NVMzSlhGeCtiVVh4N1UvbURINFlL?=
 =?utf-8?B?enZnNis2YmVnZDRVeUFiblAxbnJUa0tEenhzMXFoOEpzaHozelJVeVlXOFFh?=
 =?utf-8?B?U05hRVU4eGw2V296bmJjL2VaM1hadURJSW51dmgxcmRzUGZDdjFIdGJnUm9X?=
 =?utf-8?B?R3ZucytCQ3UzZ1A0WVdZZTBCWGpRbUlrN1c4UXNxTkk2Uy9oaVgxNTY1anBF?=
 =?utf-8?B?WTRZVHlqQkF6Zlo3VmdQOHgybUF2K2tmd3MweGxOcVpRbDF3aStGVmh0TXcy?=
 =?utf-8?B?RDZKalIyVWRsenU4NWw5dU5DSWdLWGhrNkt0N2tyQmpLYUZQMk5TRS9uWFFL?=
 =?utf-8?B?V0F4Z29hRDkrN3MwTlVjK1ZGb25EVXJrMW9xaXpxQjRHWGxGT3dURC9TL2M1?=
 =?utf-8?B?WExxcVlJY1RKeTFoODlWbkREalN6VktxT3ErZzhBQ3YxQWgrTGhwVjMwbXpZ?=
 =?utf-8?B?RGhIZkFyUWlrQm5vMnM5VHRXUXFaZmRRdks4M2tuay9sNHYzMWRGWTNzYkl1?=
 =?utf-8?B?T1ZhTmxJMXowblpqd21WSGZzZWJMSGIzVXNFN2JjeFV3bFFkdzA2dDFXM0lX?=
 =?utf-8?B?RHpORm1sa2VHalE1aUlyYkxBWjdFcG94RUNTalN6ektXa2tLeEg2Nnk2allC?=
 =?utf-8?B?YWR4QVFGR3R1b3htamh5US9QWjREaUpOajd3SVBZc2NsZlJNVVVtcWRkbWNv?=
 =?utf-8?B?Z3ppdi8wVlJlQzI4Ym1HSGJtNXpnOFRqSWVCajRham5LdHNScktSWjRjV3F4?=
 =?utf-8?B?OUROaHB3RHU0Mkt5dUtwaEllb0MyNytPaVRMeFIwS1YrYnROQnBoYWxIa2Vh?=
 =?utf-8?B?SG9nVmVMR2plaFgwOEFNdk84bUVuSWJyN2lNNytuVWRlcDNyb1dJVHorS2Jz?=
 =?utf-8?B?L2YxMGhoVjRhUGR6cVpRd0tjSk9jZDBqS3phL0VXRWdNOWRPWThJQjBvSWdC?=
 =?utf-8?B?UkxLYk0yOFU4Zk4rd1dUQ3MvK2liQlBEWW9uYlZCaVByRHRac1JBZUxYNG9S?=
 =?utf-8?B?UjB3bjM4dVpQZGoxa1l5Vm54TXlzMjYvUThZeE9ENkNKN0hvNWF0R2RnUjJC?=
 =?utf-8?B?RUtDc0Z4Zjdld3dJZmtlRURRNXJITjBvSW1idVhrTUxOUmp5Z0FXMHMvSlZh?=
 =?utf-8?B?TDRwNnVvbmtoT3VHQUo3ZWlUY3phL0ttV21Za1NlNWRiRjNySWxnZktKVHZ6?=
 =?utf-8?B?ZGtwYnZIOEQvUmUwWFVXVjZ4aVZBbDgrVW5EaWNrc3QrejlST3psT2lGUFRp?=
 =?utf-8?B?V2ZNT0pDVXBmbUVVOHViTTRxRTJPL0doVDlSYTI5VFlEVVVCWENKVWRRdTkw?=
 =?utf-8?B?L0NKTU5BRXFRQ2twUFlISnI3VGU5dDYzWnRRUk94M0g0Wm5MemZheU8rU1Vy?=
 =?utf-8?B?cmtiZWdlM21oQ05VUStZdllGdGxaRG95bHlPOG9NZVNpWkdyTkFhQ2VNZDUw?=
 =?utf-8?Q?80o2/9BprbJFV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elNkNEMzZVJwTnVOMWR4RHUxRldscm81TkptWUhrOUYwaXhoQ3N5Zk4zcGp4?=
 =?utf-8?B?Y0FPRnRIdFBvbi9TM3l2eGg1dnkxSmE5QTh2OWExem52d3o3SmxSaExjeWJN?=
 =?utf-8?B?VWRjRzI4T3FlYWF1SFJOaDhtSHFiN1REWExDMTAzdGNrc3ZHSGhyMlZpVG9O?=
 =?utf-8?B?VjdBY0lVV25wRDlnby9DbE1OWUZBU2tuU0xDc2FnU0xmdmQ0T3FJQUkwaGx4?=
 =?utf-8?B?b1ZYOGVLSlQwUzB3Z05uQ0N3dmtvbHhsY1FuaEN2L2JCWGQ0dE93bGJSVDJq?=
 =?utf-8?B?MDQyOEZ2eDZibTFGejVoNzZLczNaaFF3Y3VSMXFRdGJYUGdzNFRIRjBMdkFw?=
 =?utf-8?B?dTBkR2JqTjZmS3NUMTlEMVNqamZWOTVjQ25BTnZsdllDdG44RmIxTUpnZFZL?=
 =?utf-8?B?SUZRYTNTajVPZ0VwWW1xNTZlNkxuMDloL2xFanFGUUQvODBoN2VLazJNMkZl?=
 =?utf-8?B?azQ5M0RnWFFCaWlIKzNmbkh1WFVYMFplWittd3k1dHZGOGYySXluQ0psVHZ0?=
 =?utf-8?B?Um5PRnh3aU1jdTRaRXlILy9GTXJVNFFPZFZFdmUyVllsd09TVThkMTgvMm9U?=
 =?utf-8?B?OWZDK1VQNEVicWdMRUNlNE44MWpvODJBOVIwRXNWZGxOVEh4TzBRR3dhSmcr?=
 =?utf-8?B?cWorcWowWnNJTmRsQldBOXVRYmFHVEd0MkE1RG1nb2FiSzNCWGpNcEdjc0w3?=
 =?utf-8?B?Qm9ybXRjOGVHU0hhZW1WR3hwZjQ1SmdLRHRnQWlkTldBN05mMnlyR2U1RWtr?=
 =?utf-8?B?djZqQ1p3VlNHZUgzVFhMVkFXQm1DcE5OQ3VTcTM3TDZJYkMyQlNaWFVqN01T?=
 =?utf-8?B?V0lDUjl5Rk1ZSWZTSW82Q29hN3JETFdJRmhKYVdxa3JqNHdaNVBuM3g0dXgy?=
 =?utf-8?B?cTZmalROUTJJMkNSbHBlKzQrQU95SUF1RWN0WkJITUJUYUhPbmtKK2NyNTVQ?=
 =?utf-8?B?aC9QclpWSnNiNUZMNXJ5MG1xMyszNEN5QVNnZk02NUZ1NmRSM1V1ejZXOUF1?=
 =?utf-8?B?U1FOTWszeFV4aHdyem5VN1hYZi9BSVlwTkxBd3kyMGRpSzlkdVc0TFo1TDlH?=
 =?utf-8?B?NTRxN2N6QnduVE10Yjc5RFFxSnVBc0xYUG94dVpIRDZhWUE1KzJjRThFMkxW?=
 =?utf-8?B?YU1FL1MweEtMclQ5NElDVnJvODZTTFl4Tlk2OHZwSW9ySVVwN2x6Z2lXMTRZ?=
 =?utf-8?B?VHRxemt5dFdQNmR3V3VYYklDRFBxRTYyc2VHUmhUVWdoYmRwZUJTOFczRWU4?=
 =?utf-8?B?b3JnQ1g2bTg5K3lRU1NSTlQ3M1dkcVBqcHJKZ3JwLzhJQjJtVHExakJCYTc4?=
 =?utf-8?B?Z0JoRytjd29zL0J0dTlwamtCSSs0VkdxOHE5SjdhZnI3V1MxNXMrVzRpVldz?=
 =?utf-8?B?SkprdTJMb3hEM0tTeHZvQm5iQWFBZFNTMThGM0Y5Yy9ucFNjYml4ZDRHQWVp?=
 =?utf-8?B?Sm51dUFSVWRnUldQVytmb1lONkhDQjVzRnp6RU1BSXRpQlFwbkVlbVZlRFNN?=
 =?utf-8?B?ZnBxSVJmdTJZODdtMG55ZDJnMG4wY3h4RDY1SlI5cjNCS3FvRnV5ZVIyUFFp?=
 =?utf-8?B?c1ZWRU82dE5zcVdvRTBSVDNvWFZLRGdyajI3Y05abEk3SHd3TDEzVm5DVWdJ?=
 =?utf-8?B?Q0tVVDB6L2N3YUdBZ2ZiTEc2K0ViZldNRUpJb0hQaytIVXhGdU5OdHd3QzdT?=
 =?utf-8?B?Q01mU0xKV0VGN3pRWGJONUwzcURiM2dQOXNUOGd2Vmd6ZndQTHBRWkNod2dT?=
 =?utf-8?B?Q1FuWHE1eFlFbUprUTF6RjA3QXdMWWtxd0NoUHhCbW9XWWVFQTBWQ0hET2dl?=
 =?utf-8?B?V1dlNEpLczR4QlNrWUcxTE9XYTZSd2ZrVWFuSTN6bU1NeStqZnFobkxJWE5a?=
 =?utf-8?B?LzdKeHRTU2ZZSXB1d3R1endMZlNFZnRzT2w0Y0F1NGs1VWM0ZTJXS0lkSnhz?=
 =?utf-8?B?dk0wd2haS1lmZVc0bmFQRFcrYnJJY0dPRXRyd0FVYXFrbTlaL0w5c1lXY2Ix?=
 =?utf-8?B?UVZSZGp4TzBId2FwU3RtOGd5eTJuKzdJZlJyS0N5NVFGSTRmOThpQzB0NFRz?=
 =?utf-8?B?UElRSi9KTnhEYXp4dXpNUmlMeEhkZnNubnlNUE9kd2xLamNzNWFRbVpKS3lt?=
 =?utf-8?Q?Auyvyk0WkamU2YNlojuABG9nD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61d28c8-df6a-495b-7b5b-08dd206f4a04
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 20:54:11.2685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb6G9YlIyWCndUuqOvcB+tfuKv+K7qkiiU9ERLw6H2ElfedUJXkrXxsCfWDDVyNHlnTdU/2dLaJFDWH8U+Dbng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315

On 12/19/2024 14:46, Werner Sembach wrote:
> 
> Am 18.12.24 um 16:59 schrieb Werner Sembach:
>>
>> Am 18.12.24 um 15:06 schrieb Mario Limonciello:
>>> On 12/18/2024 04:34, Werner Sembach wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") 
>>>> sets the
>>>> policy that all PCIe ports are allowed to use D3.  When the system is
>>>> suspended if the port is not power manageable by the platform and 
>>>> won't be
>>>> used for wakeup via a PME this sets up the policy for these ports to go
>>>> into D3hot.
>>>>
>>>> This policy generally makes sense from an OSPM perspective but it 
>>>> leads to
>>>> problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with a
>>>> specific old BIOS. This manifests as a system hang.
>>>>
>>>> On the affected Device + BIOS combination, add a quirk for the PCI 
>>>> device
>>>> ID used by the problematic root port on to ensure that these root 
>>>> ports are
>>>> not put into D3hot at suspend.
>>>>
>>>> This patch is based on
>>>> https://lore.kernel.org/linux-pci/20230708214457.1229-2- 
>>>> mario.limonciello@amd.com/
>>>> but with the added condition both in the documentation and in the 
>>>> code to
>>>> apply only to the TUXEDO Sirius 16 Gen 1 with a specific old BIOS.
>>>>
>>>> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Cc: stable@vger.kernel.org # 6.1+
>>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from- 
>>>> suspend-with-external-USB-keyboard/m-p/5217121
>>>
>>> These two tag (Reported-by and Closes) should be stripped because 
>>> this is now for very different hardware.
>> Ack will remove in next version
>>>
>>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>   drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
>>>>   1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index 76f4df75b08a1..68075a6a5283c 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -3908,6 +3908,32 @@ static void 
>>>> quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>>>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>>>                      PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>>>                      quirk_apple_poweroff_thunderbolt);
>>>> +
>>>> +/*
>>>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into 
>>>> D3hot
>>>> + * may cause problems when the system attempts wake up from s2idle.
>>>> + *
>>>> + * On the TUXEDO Sirius 16 Gen 1 with a specific old BIOS this 
>>>> manifests as
>>>> + * a system hang.
>>>> + */
>>>> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
>>>> +    {
>>>> +        .matches = {
>>>> +            DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>>>> +            DMI_EXACT_MATCH(DMI_BOARD_NAME, "APX958"),
>>>> +            DMI_EXACT_MATCH(DMI_BIOS_VERSION, "V1.00A00_20240108"),
>>>> +        },
>>>> +    },
>>>> +    {}
>>>> +};
>>>> +
>>>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>>>> +{
>>>> +    if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table) &&
>>>> +        !acpi_pci_power_manageable(pdev))
>>>> +        pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>>>> +}
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
>>>
>>> So it needs to be applied to /all/ the root ports PID 0x14eb, not 
>>> just one of them?
>> Don't know, I will look into it (I think because of the ! 
>> acpi_pci_power_manageable(pdev) it is applied to two of the three on 
>> the device)
> 
> I tried it like this now:
> 
> static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
> {
>      struct pci_dev *root_pdev;
> 
>      if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table)) {
>          root_pdev = pcie_find_root_port(pdev);
>          if (root_pdev && !acpi_pci_power_manageable(root_pdev))
>              root_pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>      }
> }
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1668, quirk_ryzen_rp_d3);
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1669, quirk_ryzen_rp_d3);
> 
> but that doesn't work.

OK; that means it's more root ports indeed than just the ones above the 
USB4 controllers.

> 
>>>
>>>>   #endif
>>>>     /*
>>>


