Return-Path: <linux-pci+bounces-34868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D58B379A7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 07:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDE47A482A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EEF26E71C;
	Wed, 27 Aug 2025 05:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qMM5bAwb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20736296BDF
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 05:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756271206; cv=fail; b=fWoPwsxB0UcJeKNQtvCWUz7qUfS/e96KKjn51t1eqRFtTZCQg1CGnOkdLOb4EnzHWyun6cfkcnDPNynZr1wJPLXhYk/UcidCGPo5BfeN9e1ROjgOVFdsfnG3Tg1BLpBtFb8FqBgEnq8UFIAaoXdsdTWBJDbHOHVehrIrjj+v+b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756271206; c=relaxed/simple;
	bh=g8rVEnBwdYLRoCU5+Lg/wCNdohVylO7mXJTSCd1ErQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=drHuXI+QL/ObdS/2+jt3na2qXkijAsiiFCp/vNkiXWb8TURKLzG8f1zgIzl88Q3qyo0t+ziv+jHXWUXTFHPhq6Tp2Qa2SrYrdMCwTsMPYsk5qF/zdtE7lFYSixvtLVc4SUmt32OpPFmfrcxpHqRco9i8KFicK4xWJKNrbLFvOR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qMM5bAwb; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jR8U0OAUCRgo6hIV5QiUQVtAhmFKH254LgQuF7oxHqy3vyLBQLcFlxPyoF1gNW09h//zpB4KGRsiyxUYIOBxiiPU06mUfuKDXJ71an90aivC26OI7IuzlNG3YAYn3uIJktwWzYlPzLInLXauAbc3WByky91N6XO4OXcV/SBtGIjxU3e2o6bbPZ0Y82lkefSq95NPiLXoadeh8vOp9ChlAmzWaDeWWkXdKqU8PxXzEODMw46yw/NH1qfRFEBYBFjMHSoyQK6ZWZTKB8SWV+umjS/XpMnfLzdmoYuxEpxsQG+4s7P9y78w6ZClLuX/VG8e43QYKpk4PfhXMq9XXPbWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPJP/Ws5gDSkkMBlNnfZfhDfZpqZcP2PDAi1r867iH8=;
 b=kY6cpVlMoLeWOHcXdsgxznF4Wq98YciNqPKjja44yFEgGK1nG885QI593B6ymOFm6y02dCl7mbK+YpFki0TK290tM63Y/bUAkU371F+PTmr61UFVyEGC4EphUAcW72zdyqk320XraDhDY65TgR6WXzVkvGyBT1B+A7DB7IsB+1C4LOvMmVeh0umIPililCIvOw8xRaKot49ElLRJ9kfp8lOYkuwmAfV+lk39o6fDEiMKZ+Xa9lv/17ZkPCb5B+VW7r4OEYHQ1stWIh50qNC6djALO7rziIfNhT8WVGHPJT1UFiZeyl0di6EZoMSXpF8lrpVWLrkxd6s+G2VfBYxASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPJP/Ws5gDSkkMBlNnfZfhDfZpqZcP2PDAi1r867iH8=;
 b=qMM5bAwb6EO4Hxv+l5Rd8AmNfyt1lgoDDBaiWLQ6ONUKREIJtkl8xZmp5aQfw1Rk5AatRTtIY3TXewoRT0IuK5IRsaxEZ1E/GuwjuTNWrcOI1QXJRGm7YLNgbUyi1KdI+V+BUphl6pS8renTpMDqSezwIwjrEFgJFSot/lYHRnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 05:06:41 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Wed, 27 Aug 2025
 05:06:41 +0000
Message-ID: <e727d782-cb18-44ab-a812-87c16844473a@amd.com>
Date: Wed, 27 Aug 2025 15:06:34 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
 Bjorn Helgaas <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <b11535a1-0b20-41ec-be3b-05d7de3a6db9@amd.com>
 <68ae4a0c45650_75db10016@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68ae4a0c45650_75db10016@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0128.ausprd01.prod.outlook.com
 (2603:10c6:10:246::26) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d3a079-f424-47bf-90a1-08dde5278287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blUySTdIb3NLcklZRk0rUENSRWNqR1Bjc3pSb0Q0UVV5YjdjaWQrdVB4SFUv?=
 =?utf-8?B?cXVCVmNxeFZxSXdKb0lsNTlidmZSckQ4Vk1RWVU3dmc2N0NQKzEwWjJVKzNi?=
 =?utf-8?B?NmR6MlhVM2g3Vy81TlJNYXRIVThhcC85Sk1hNGN3Ui9XbE1iQjVuZlhzNGJX?=
 =?utf-8?B?VG1FczlKTURkQWRLUkx0Sll0TE03YkNUOEhremlLb0pMY3huNmYzcHNRdDFN?=
 =?utf-8?B?b3p0T21aaTRUVStiNG9kTDEvcjZTRWZOUnkwZmRHWnBYQlJGcDdMeENRaWF2?=
 =?utf-8?B?SEI4VEhnS21JbE50a2hQUm5pUVBsNkxPd1FqSytJeTJhVE1mYmk5bW1wN1Jy?=
 =?utf-8?B?UlZYSWUxUHhlOXBTcll6R1RJdEhrVGJmdGtodmw2RDQvdTQ2TnhFSmllTEt5?=
 =?utf-8?B?SlE5QkhUdExCS3JGamZBbXlSb2g4RS9qZnB0czhybHlrOFZJS0VPcTVYUW1N?=
 =?utf-8?B?cTN5SGZWZDhPRmpodjFqS1RFQ2dxOGRRT3dIdGJ6SXZqblFpa2ZDTEdVWUFY?=
 =?utf-8?B?TGdDc21kK2wzVTVJVC80WFZkclpWQm9zM0N5c29Zb1kzZGZUWUJ6eXpuZFY5?=
 =?utf-8?B?cXlGbitWRU9Cc0src2EvNVhkZmIxZWczUVJCcFhkR3ZKbmRCYkNCdzdBS1o1?=
 =?utf-8?B?a25VVUtZMmtGVTByeUU2L1hHQVc3K3NNc1FoK2ZlWjAyV3ozRDZaZ1FYeXlC?=
 =?utf-8?B?VXVMeERCbDFEc0lLbTN3NUs4ZXBNM1FmdE55Q3VTRU1reStsVU1VbDQ0SGp5?=
 =?utf-8?B?dC9PN0s1SHcvbDgzV1R0aSswUVpCR2orZjlkTUdCZmZYcE8rcFFOU0U3K2kw?=
 =?utf-8?B?emxmSTFpbzVITEVKa3hralp3WnZqeU1VSVUzQU9YOFBRMkhkOXhjWWJoTFpP?=
 =?utf-8?B?SXVLN05tUUFsdDMrcEZTYzR4STh2M25Yd2M1TGZxbXVMME1ydjBYNmFEcG5J?=
 =?utf-8?B?Qmx5STE1Y2hrQVNCbjVscnRGMVNMR0xkY0xza0tyekhGaXBzQ21GUlgvNXE0?=
 =?utf-8?B?UmdQdGIwRndUSkFRTTNmTjNiWUZwdExKUDYySTY1OVU3eHVBUmcrMnFDaG5W?=
 =?utf-8?B?RU1iczJLUGlqOGhVVHU4T3JQaFNNcThQMjBSeEZsbEVZN3J0YjQrL2VmQzhp?=
 =?utf-8?B?cUhzWll4anc0RDJnOUNYNm5vbCs1dEJWbTdBYlVndXJXYlRTanV2S2Jnd25r?=
 =?utf-8?B?aGlBWnR0ckt6MC93R3FBTEtDS0hmTXdVZWNxTkEzdTV4b3BvN3BKZlVDL09j?=
 =?utf-8?B?UFEyWUNtUEtqVEVOS0NvNkxIM2wrOUZXLzE2cHBtVXZvNmZlR1F2TGJMSEhD?=
 =?utf-8?B?eVFDeFRVaEhWdVUxUWk0UzZNM21PbEtNMDJycnJkQlF3Kzl4Rk1kejV2V2dI?=
 =?utf-8?B?Yk1yd0FuR3hrdldlaHkyOHVQbjlGc3NzQ2t1UTFiRE1vMmlsa2h1Zys3Ryts?=
 =?utf-8?B?Y0p0aFh1bHM2Y1BIV292Qi9WVHdRN21LaHdadk9Rd216cER5bDlzUVJQS1F4?=
 =?utf-8?B?TVhsZUVMRElYazNBQk5uMWF5MHJKUENRUEZMNkdBckpBWUZoWHM5UllhbGNS?=
 =?utf-8?B?blFEeHpkMzVJVGU5ZGdaRTJJSG9jWUZueDEvTzliOTFzNW85YlVRTy84cDUr?=
 =?utf-8?B?clpjL1VIUU52MlljN3FJMDNQUVpmb2loYk1idm5WR01RcFVaZ0NpNXdVcjha?=
 =?utf-8?B?eTEzdHlVSkdGWUN6dmJUM3RPQlZTcmxxUUJOQ0hzaTRqbXE4dzV5TjF5RmxK?=
 =?utf-8?B?T2t6SE9oYUFhOVNxSThUZk1XVEZFWWpRQUYzTVZZVTVGOWZ0MWtETGJTN2Fx?=
 =?utf-8?B?anhvQ3VCRXR5UmFTcnlhQlhEMTZ6dTdBZXIxa0pmY3Y4Q3RYUG1pU2xORU9O?=
 =?utf-8?B?d3VFVVRyWWdLZ2grSHIwd0kyVXBCZXBYQk52U2ZYYkVQYXh3ZFRoQk5QcWlD?=
 =?utf-8?Q?u4RZGZNwQbM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkRLZGl0YlFEMXE2RXJqNDVRMGNuTTBwWTZnZHdwSEtkUEVOZkY5TzJtekRJ?=
 =?utf-8?B?dGpOMTdkOTlvalVGb1hDNEI5a1JKbGxKVVF0TkZQcmhGWVNLb3NHcVAvcnRo?=
 =?utf-8?B?dGluVXliY2h3Wk0yaEIzckpSWVNwY0xSQkdJaGNIQ29kOVZBU1dnNzRRZVNU?=
 =?utf-8?B?OUwyVEM3dE9qNnNpQlB0ZU5ZeFR4UEIvQ2owV2pFL3Rra3NEenFNRGhHSFBp?=
 =?utf-8?B?aW1iMjkyUVZEYUFNdU93ck4wcmFVekwxMjVMSEcvbUFYSjBrejRRemVVMlYz?=
 =?utf-8?B?T3VhTk1mMUVXSU4rWlU1OEpxZ1hzWUFLampzcDJVT3lmSHVrN1hRejNWSWM2?=
 =?utf-8?B?OHdTMEdvSE9aaXM4azUzN3JIbnRXaXlHMys2RHMvOG1wZ1dOSjB4bmh1OTdU?=
 =?utf-8?B?emFVUmFjNGp3N0Y1d2JlOHd2YThvQlpZeVhwRTFnWWFBLzlJOHVIYXFrS2s2?=
 =?utf-8?B?WUJFQlhrWlMwMkJ3ODVhUHRwNm0zTE5DT0VpaUZWRVZoZGtRajlKd0JUK1Fn?=
 =?utf-8?B?VldyQVZoalhnM1lOcFlaaFNkTG4rM1VBaU8rSkdCbnZNejRlZnlLK1lZeVZH?=
 =?utf-8?B?ek5zanJpc2k3dGY5V210UldhNE9JNU55aitmTTZ5ZFNQbnVnQ1VmaUYyODh5?=
 =?utf-8?B?Y1Rtb1BDTElBV2QzS1pWcmp3REYxc0pvUisxd0syeFF6Ly9DY3N5U2VQTm9p?=
 =?utf-8?B?TWIwNkNYQTFmMGdZRU5Ec2x6N1FOZmdVYi9JR1NHbmltKzVQVlNOQzJpUHZ3?=
 =?utf-8?B?ZUZCaXU2MndYNktwejhhWk9YZHNoUWhaUExuRDdtQ3kybWVIVitvaGZ4ODk4?=
 =?utf-8?B?cmNveitzOUJ2THEreE95TzBjd1BramdPK0dvYkYybHBNTjlTRHhRVzYwWmwz?=
 =?utf-8?B?QXpWR2VRZldiVlc2Wlh5dlRtZ0JwOGhVamt0bFc2V1FMMHNScnBFQVdMeDVI?=
 =?utf-8?B?ekVhZTl2WGhDYjVrN0VVWjJ3dUtFNS9XamtPNWFLVVJkOVlXbzlZcHU2VVhW?=
 =?utf-8?B?bFVXYlpRRVU4RlZnN2UzS1ZxNFhiRmloclo0d3lpMENjYWhlYXlBRHJqYjdw?=
 =?utf-8?B?QVNWTnkwVFEzT25xNXZTTTJucXpWc3hrT2Y3dURsNnJXUnM4NitVdWZ1TmRw?=
 =?utf-8?B?SVExcVFIQUJ1bXdpdDVuVG43MWZyN090ZGtldmk1YjZhUnBqUU5tT2FjTnBI?=
 =?utf-8?B?Q0hvMWxGd3VZSDRDdDdQRVdXQ3hydWx6dnN1MDU2Y2xZUFVmZ3daeGRRS2Rq?=
 =?utf-8?B?YkJ1Qi9QVVhGWmpRcEtKOFpwcDhHdzhJbC8yVGFTbFMwd3BNRnpCQWtsWW9i?=
 =?utf-8?B?Q2J2MjdVZnhxRFZyeUlMNzhteXBCV2I5dURTVWYyWDFQdDhFVDQzZTFEWWRn?=
 =?utf-8?B?eWMvczhUbmxWUlBKaVQxVDUzY0R5Q3BrNXF0UEFRN1BZb2NUTXZ1Nmt0b1dm?=
 =?utf-8?B?am9CbkFjTVRUL1IwRk1URG55MjkxYXFmRzhCMjFCSzRoNDRTYVNYY1M1VTcz?=
 =?utf-8?B?T3RKUC8vcERSelNQMXJYYU9PSnNJT2Jvb05QSzh0ZS9KbnlkOFRzNnJhMDlL?=
 =?utf-8?B?VVQ2VWMwYVhSbmdhSFFDWEo4KzMwcVpuU0YwUlZtbDZacGUxc0JmSEMxL2dz?=
 =?utf-8?B?L2dkbzRLekFBa0dPbFE3RFN0T1FUYWFoZW5JaVNIS1pRdUp2aCswdXF3NFJJ?=
 =?utf-8?B?ZUg1cnBwaEhYVHBNNW9hWTZPWFpRaXk5WWFsajZYZHZ5bnlMaGZQTFJjTDhX?=
 =?utf-8?B?UXkzWEY2azluZEllTHg2TXptS2Q0dzNxRmo2L1FvQytOZzV0US82ek5ON2Zn?=
 =?utf-8?B?NWlzeWhtdDFkR1lJNld4WCt4SUdIUGx6b3ZCekM1bnpIWlJTRG5UZy83azkz?=
 =?utf-8?B?akgxakhaSUc1T2kzaGcwSnk3VTBNeDJmdnEwUDZKL2tJNTJzTVJzeTk5Umxi?=
 =?utf-8?B?bGZlTHZOcnJzbEhKTWdvRmxhd3Vkdkx0R3FZWmh6RHZYYy9ERnlvK3djdVZM?=
 =?utf-8?B?N2w5VWlxWXJhRDZUbm5QYm8vWlRvWVZFZGZPTExaNTNvL05VT0FzUzRiWFln?=
 =?utf-8?B?UHdMR3V5M0tNb3hrWjBBM0RIa05QMmpVQng3aTVDaWRVZW1zVHpCUXlCWnYw?=
 =?utf-8?Q?tBEIR/Bkec5q1wwk1YkqVmkHQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d3a079-f424-47bf-90a1-08dde5278287
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:06:41.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0VKXhyeachXipDgN/FgdPUN5J/rb6aM7UeDAC/+ydB0cfOMm5hXEM+Dod9vagxRYox/ov0p+7pLCii6OeiYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463



On 27/8/25 09:58, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..trim reply..]
>>> +int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
>>> +			 const void *req, size_t req_sz, void *resp,
>>> +			 size_t resp_sz)
>>
>>
>> This does not belong here yet - no user.
> 
> I had been pulling things out without users, but Yilun and Aneesh ask
> for them to be included for staging purposes. When this staging branch
> goes upstream a user for all exported APIs is a requirement. However,
> per your comment below this is worth deleting.


I did not mean to drop it just because of no users but it could stay in a separate patch as this one is quite big (679 insertions) and no-users stuff just adds unnecessary noise.

>>
>> But if you still want it - "enum pci_doe_proto" should go to pci-doe.h like this https://github.com/AMDESE/linux-kvm/commit/af12dec97ed98a9f365bbbb6925e76c556937d01
> 
> Yeah, I will move it over there.
> 
>>> +{
>>> +	struct pci_tsm_pf0 *tsm;
>>> +
>>> +	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
>>> +		return -ENXIO;
>>> +
>>> +	tsm = to_pci_tsm_pf0(pdev->tsm);
>>> +	if (!tsm->doe_mb)
>>> +		return -ENXIO;
>>> +
>>> +	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
>>> +		       resp, resp_sz);
>>
>> The wrapper does not seem to be very helpful - the platform driver
>> (==TSM ==CCP) which is going to call it already knows it is a DSM and
>> mailboxes are initialized (otherwise the DSM's pci_tsm_ops::probe()
>> would've failed) so it can just call pci_doe() directly. Thanks,
> 
> True, this is a weak helper the TSM driver already knows when and if it
> should be using the already exported pci_doe().

right, thanks,


-- 
Alexey


