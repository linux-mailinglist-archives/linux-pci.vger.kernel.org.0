Return-Path: <linux-pci+bounces-23108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D0A56777
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B12173F9A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F861FC11F;
	Fri,  7 Mar 2025 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iw6KA+Hn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v0IFZHbT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A41192D7C
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349132; cv=fail; b=XDVE8TIxBLcfqpquaemGxVi2HnZ3BRa+FiZEH4SaDt52sdkVBStfLobAbRcXmHYeL57u8Ap9j6qWvySKVss7GNcPZ08wc8fYWVeEPiGxjPCVjGPCH0mogdUqxVhBJcv1dGwNhdD9mwJmoHx4XTNaPEk8lEc9IYmui4yU00BkLYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349132; c=relaxed/simple;
	bh=egkwHKiZhc+2ccGTJuSqsuMvGXJzHNwFfZJeF2a8nR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t5RlrD1qjYVEjzvGEmPoIf889YBbfQYmP4tJjXB7a0jhc1C8hUg9qnNbLFA0xABWD93SARcq4zNcb7xdGOxOuo/Sw3JaULw9j83rZcJBqH9Sl/fwAbF/bvk3OwnFwep37F4v9tJb+506ZpDRFIVf0PdLjIhEGkddwyxFP5eR+BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iw6KA+Hn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v0IFZHbT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5271uDGW026337;
	Fri, 7 Mar 2025 12:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=k2AGy4u68rWRwQicbVcJye4NnBE1OjPxwJg1UFULh3c=; b=
	Iw6KA+HnctcT2v36OF/+oI8OpCV1LbqTL1UlM/vfo9iLl54ui3w5oGqzx5VjJyOk
	gHhZMv+W8EGkbzh+xaR/WGwWo0uhKivwCq3DM4j1GGHjdt+RG5Xz9mZLBfcC7h3+
	/sPwSH7JyWcIyWxCV6Bwqu7uw5x77zmt8PgTEm9CqEQ6IPCqhMsidZkoR6USRNw+
	uT+rL2XsKfXumI0UePgwGvPQAF0TahGjPFsTsqE9rXtHqED8uR5V0jtCQkgvWIg1
	Rht7Tx9sHSUKrlJPXYqMpqjQf34hxOQM/wRoCMYPlwR78g0dDgCol+TB5agjzy/M
	aywfE+7ymS1VB7+Y4TjphQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hm42x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 12:05:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527AC3i4040445;
	Fri, 7 Mar 2025 12:05:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpkq5tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 12:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffJIHDX35Was2I1O6soZJGWd9k0RKEkpZic5GUtHlZc4Eb/KbJ6P0f6UrBsbnFfpvKlglVLvDrWvllwEHgkoELPws2E80B7JyJF2fgyaH2L9Ox7j6oVKuaCR1+gOki5Ss9k7ffDc1HPr645ly4Pt3GX5kHeDiQEvuv8DiZqo3oDyRkFf62dEf3R+ir4ff+uEuDJ2AhtD0+Mp4NyMSAsA4bzv2VAFi3hae9n1woa49dF8+UgKzqfAIRyHPsJJ0FwFe5oGmBNDBR/6KfHax9iRR+FgE3CqPoTl+NKSFDeM5jYcjSL6MVJzqbqAEfCP5x9G6I7A5BTtllhL8J1J4hNINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2AGy4u68rWRwQicbVcJye4NnBE1OjPxwJg1UFULh3c=;
 b=Ih93wmxUWk7XY4iS2kHVmhrmVQo2LlxyxBWi4jpYhWMTitYETD8KRe7S1U2hVVg04WDyhD2Nr4w3IuQwwktdFb/YEuchpehhVIHydSx4HW1Sn2X6hkJt5ASvTPwcQPz4dugVjzDilc3+PQUlUjLpjvrKJJKBWw+fzPqEJxjLLvVBcJ2GwMELgPEEfIi/vgmAAt+pKvcqs2DxW1mHVwi4BqwISxNfajOZ4nySxBpz+G2YoQHc2qON/l9oDXoM9l3XmhKPa+5hMUpg4PfiGserdjkcjpWwXTe0jgaqR02jSqYjU2lw+yhVjpmJDfWER04Z1Ep+hiNCYpJC3zpV4p3jHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2AGy4u68rWRwQicbVcJye4NnBE1OjPxwJg1UFULh3c=;
 b=v0IFZHbTH8c6XkZewPIhrH4b+RXgBffWBWh5hvqiZHoz30Ow7nAqa0ylFAmBKC17ufm+nfP2Etx5h5dxrai2hgQXxMSsaeHL/ampjv1fz81fSEidjBJn9diDJ3S6Rk1FFEe4JHZteO1zH5F9z/B8BPdgzVhrLp7+Tl6r15pfmGQ=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CH3PR10MB7864.namprd10.prod.outlook.com (2603:10b6:610:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 12:05:04 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Fri, 7 Mar 2025
 12:05:04 +0000
Message-ID: <55988cb7-dfa8-47bd-a5e2-c96cd84d4159@oracle.com>
Date: Fri, 7 Mar 2025 13:04:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] PCI/AER: Use the same log level for all messages
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250304185910.GA251792@bhelgaas>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250304185910.GA251792@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CH3PR10MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6bc8e4-e9ad-4fcf-5c05-08dd5d704b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1g1VSs5aXF4QSszQzdxcUF6TXMzTXhheXFvNGlSaExSL2NBMy9UazNwMzdj?=
 =?utf-8?B?UzBFWWJ5enBKS3FWMFZMbmNBdE9DVFRINzNuNURCSlUrRDEyRUljeWdyOTl4?=
 =?utf-8?B?a3FBYkJtUlZnMDJDdm9IcklLNHYrR0NtK29VV2NVVm91TFg3d1drVXZyZS90?=
 =?utf-8?B?bzVFZTJrNlFOa1pITjRqbERYK2FmbFFzK29oMmthbC9CTTdGQmM3dW02L1Vp?=
 =?utf-8?B?SS8xSXFBd1N6em1zRExreFVxcDI5M1p3NlBhWTZxMlg3TXNVdUNZM1c1RVpB?=
 =?utf-8?B?c1ozeDE4eTFrY3MzaUFWQUx2UEFpQzJ2OEZNc0FaT2JoMnJTT0pqeXRsQlRn?=
 =?utf-8?B?MEdkeWRGb3BYT3NaVWhOcmVLT1MwRWkxTlo3T0VzR2paQnB2Mm5GZDA3S2RS?=
 =?utf-8?B?eE82aElWZTV6dUQ1T3BUZlZXUjJKR3BuUmFoT0NzVzlzSTV6SnZZYnpUYlVp?=
 =?utf-8?B?VUZ4bTM3QlRKUHRPRWhhZUJCUmhLY1BIZWVYcXdMUEdqOG4xM3JYSWM3WXhE?=
 =?utf-8?B?ZEMxdFp1bjVyUlhZZHpaQkhuT1V2cmcrcWJlQXc2NDkzVHlpaU94d01VQTVO?=
 =?utf-8?B?Z1VNR0ticTRUUVFSUnE0U2JDTHFFVzJZM0ZNdm10ZVlBdCs3T3RxNTdDb2No?=
 =?utf-8?B?TW93MitPV3Q3RHN3RHpsWndHaFU1ajl0dFBPeG9yRnd5Z1BGaG5veHNqYzZl?=
 =?utf-8?B?S213blZSb084RTB6SW14d09wYVVoM2VHWXAwcFFqL3d3bUU2bkFIRHo5OVRk?=
 =?utf-8?B?U0xWR3V2OUg1RlpMbll3MWl4UUlaY0E4YU9LeHZGWmVYVGFsMHRPYk9UMWRr?=
 =?utf-8?B?SWRQQnZlcGdsY0FiYi9zRFFYMGE4d2hkckp4WUljVTBMNmZReXJzeElwMVNx?=
 =?utf-8?B?UUJaSExhSDFwZ0hnWTd6TXMyOGIzSlJsWFdtNzBmcUVoUXRKZVZZLzIvY3pp?=
 =?utf-8?B?d0xieEIydDUvNUdqc0kxLzJDZ294SHJFdXhwWGsrZ0xpOHVjZHhFYTBDaWF4?=
 =?utf-8?B?QWdBLzI5SE1wU29lZWljeWFiMWNNVDBlSWVkVERvblBNNmFDSjlnSS8zZmZo?=
 =?utf-8?B?Sjd1WmhvSGx5K1lsVzY1aWVUcklUS0ZEYWEzRGErNW5aeVdpa004aG00Q1lL?=
 =?utf-8?B?RVhKc3VqenV6bVI2N3NielJseFptUi9JZWRzc0FuRE9QZEhFaWExSkprczZP?=
 =?utf-8?B?a3hkVVlXbUNVQVJQZDNyQWNiczFHUnJuSlFHL1dTcWVhc3lCZFhmYzRmZDZF?=
 =?utf-8?B?VzVjSjJzOFovYzVTMHhOUytHY0xxODE3YVJXNE5DM2J4elRQRU4zZkViS1ZS?=
 =?utf-8?B?a3ArMXpZWjhkaHFybzZGbCtjQnd3dzZJbFFCRmJISGErTFVQK3VLcGZFOVp4?=
 =?utf-8?B?eHZrSXZLdThPWGp4SzNQUmpwaXBXWEFGU2V3MGt3dTYrbGdLbFdEQk9NYytu?=
 =?utf-8?B?NU9KcUFCRkhLcG9XblBlSzRveEZxTktoSHV0S0dKUks3N3NvR1psY0hNZC94?=
 =?utf-8?B?TnR3UnA3L3F3dXp5dkhjV0hNNGNXZ05RR3dmSUlpaWJMbnB0TTZXeVpiYSsw?=
 =?utf-8?B?OWZtM3JvdHd5b3QvTVZJbXZTRjFCY3A4Zk1pb1BHMFZNMFIzMGREejJYK3N4?=
 =?utf-8?B?RXlvUHlTdmJGajRGcXhUMjhKMzZvUFl1QVJnZmpYb3gyTG5HZTZKSzRKWGV6?=
 =?utf-8?B?TGVMdFg0dlF0THorL1VtNGNMSk9TYmY3NG4wMnlZQnlhV0ZUVFdvamZRWXhu?=
 =?utf-8?B?UnJDN0w2Ylk2d0xoeWlmK1FZWlFBYS9xWWcxbGNZdFU3dGdManByUHA2WXk5?=
 =?utf-8?B?TFptL1RtUG9Ba2JMdklZQmxJQXNZZ1Jwd1RlSXZpU0IxVDlaS3IvNklzK0lm?=
 =?utf-8?Q?rQ5vSXeOD0ANi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHM0UmlKcENsVGRqL0FsUWlvdnFuTGNYQXhGQlBjMGlaaDI2a1FhUVBKNEl4?=
 =?utf-8?B?dm9OTmtUTmFrK211dlZlZUJ5OUJuOEJoaTQvbGZydlJiUTFZNDdjeUQxSDFI?=
 =?utf-8?B?Q1EvOW1ld1BRU3BhcWE2NmNGbUloem83dGlQRHo2NG5LT2ZBOW1vUWZuaWNU?=
 =?utf-8?B?OG8rS3JFVUYrUllnUFRtcTR5cVRpai9GYTBGbUtpM2NiQm5kblFaUmpadk5H?=
 =?utf-8?B?MlVKeEdsc0dTRDRjc3ZjT0dCUmdIck5raGhyVGRLbFp2T2VIdkNvMDNOMzRC?=
 =?utf-8?B?M1E4Q2Q4ME5kak5FSURxODdVODNRVkMzdCsyMHpaM0NhNU1FZkNsakNMZDRC?=
 =?utf-8?B?Z3BWaUxJS09oK0R6bk50ZU0yWVpTNEZ2TWZqcEo0Rm4vVDJtZlpqZXEvQS8r?=
 =?utf-8?B?S1FjUGhaT1NMbzNoVEZ2WHZuNlpDZW1PZCtjWWo4UThqMm82NzNXak9FblVH?=
 =?utf-8?B?cVdURXQ1RmtDZFBnekRMNmkwb1gvTlZpUFUxZHBmTXZLek1DbVAwZWhVeVBF?=
 =?utf-8?B?YW9ZUVptSDJscHdsS3ZNSy9xL2wvK2JiYnY4cmZQQmJpQXNwcGIyblN5ZHpk?=
 =?utf-8?B?cWt3NWpjbTIwL3VwcnhBeE41M3JIOVBHOEVTa0I2Zy84SmFvOWRYalZIMnBT?=
 =?utf-8?B?NFVXeTFaU1ltek0rUFQ1Q3JldWxPSUpNdElmYmFZSWVwOFhQdGZya2RGTE5k?=
 =?utf-8?B?aVRtZ3hpU0Q2cDBQZzBDN21rWEE5RVM1L2pKWjRWcnBTQUNIZFBsanRldTBX?=
 =?utf-8?B?WWU3ZXpTWTdzS01UZmZ4ZFBRSHZaME5nQWppUitMdm00ZWZkNWtHVjNkb0JB?=
 =?utf-8?B?Y3pVREQ3NXZpMWlZVGdoei9XQ2JkNWtsOGFZOVdBNThsTzk0Y0FnckZBMktu?=
 =?utf-8?B?aTgyVFJUVDBJU1JJUStwS1puUG9lRXJYZm5MZlVVdFFZd29Eejh5WnJBbkJ3?=
 =?utf-8?B?bTBpWDA5Wmc0c24zejZVTXdHbFA3NUdERmZ1clN6U3ZTWko0L3lOOHJiYzZ6?=
 =?utf-8?B?eldWVnFHck02UllsK1gzaEd1elRRRUF3RnV1U3BQem9KZE1tWHM5VGFnVmlS?=
 =?utf-8?B?R0RKZUFJN09ZenJsK2QwbENmVVVlbFA1VDR5ZDF6VFJrN1ZHN2tXQTNmbGtx?=
 =?utf-8?B?dWh1bnBvcWNlT0tyaEVUT1RkaGFqamNyL3pENmc2V3B5YnZ3THZvY2RqR2Mv?=
 =?utf-8?B?TXRyZmw3M2VXMTNSTW90ZjVaYkZqaDhHcEtLcUdvYU1qWDhXMGhsdVBJQWNX?=
 =?utf-8?B?OFhOcmVWb01ncWQ0T0xlSEc0cVJaK3BsSVNjWG9TVzR3STFISGF6ZVlZazV0?=
 =?utf-8?B?b0diSytlb0tjRm0yQngwLzhxZUo4aGN4TG5iSVM1MFBvK1R5MmR3ekVvMWNz?=
 =?utf-8?B?a0pxb0lLZjRNa2ZYbkNQQnlRSmZYNXVjU1pIejlxY25pamo5UEV6S3VnSGN3?=
 =?utf-8?B?Y0hkblIzUk85NUErYmFLc09GREJWL2JEcGJ0TnBoL2txSmF0WkZRNGlNRzNL?=
 =?utf-8?B?RlZHb3laMUw2Vzc1bjg2Wi8wUVZVK3orM1h0K0pEbFhFQ2o1VFp6NENrSUFB?=
 =?utf-8?B?U0RrRmpRcUkrSElhcmhuWWwxR2hXT3drNXhIT2w3Y2tza1dkMVA1WTM1L1ZO?=
 =?utf-8?B?T1FubzJpWUNoSjdhVjhhazNIek4yODdzOFdzaGVBWTJkOTc5aDZCT2NKK2ZJ?=
 =?utf-8?B?Z2JFamU5Y1dJNklTYWVwbVZGTFF4ZWNqVTNuZTFuVEx1YmlrT0dlREpmeml3?=
 =?utf-8?B?eUkxVmFSMzE3VHp3b2JCangwMHIrcG1INmd2Vi9kRVZDQnZPMkFabUsvQThh?=
 =?utf-8?B?SWl4ZUE4NTBqZGxQM2gyQlM5R0VYWkh6dDdXdUI2bHlhS2prbUtid0pFMi9a?=
 =?utf-8?B?b0VRejhkMjZ1TExDTmt4aUc2SmtaQXRZMVF3VEsvaGRraXNaRk9ub2Z5eEI1?=
 =?utf-8?B?VjFnSisxYWZSbzZSQ1BkblNPd04wbXJiUVNONmFBTkVzVmErRXBUazcrZzAv?=
 =?utf-8?B?bENHa1ZGUStxZFJScWwyNGRXS0lRVWlHMWd6cTdlNk1sOXpzYWJxQ0pLYXJl?=
 =?utf-8?B?aXBMcklIUForaTlkZGtzZU5qZS9QaFNVWFRjKzZnZGVNNlV4UE8zaWk5N0oz?=
 =?utf-8?B?WitVa2JQcEZ2STdsVlI1UU9nT2U3L0I3SVVwRGxQSU5sY0tIWFhkaElqay82?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d/6LspmXU2ls7TKahubVjJdTxuWaiyqQxIF9bNKg49radk1hHsK147wISGS9DnoN7qI/GVPDjKqg9cw8JDhTiGVGrHOPAepvejFJekj91TK19vk2zBuPxm+dGS9wQ0IIofx0otb5VS3T89MFCjn9Z/Kf1DjEY0uTdMecBv9GhGiTVmA2Sq1vXL2EMcv7oa33x7LsloLjZgfzoXsfE/HlyaoDKgHeCd2aArMJFaD8s4nN8dHvXk2oUTtcnbJF0c12Gi0+e21J+5/vabCPTIaW2o0sXqcIhUctkI4P0yHBI8wbHpCPWTNUu+/3bTLK4fZl8Ymjbe0G2I+tTj/40jkdJbcTUhf6uQFyYejkZEl/RgOkUKwETFmqd7I5mtArCUCcSiFLegKOxsQE5VBHpgsJgFvZc5c21yjkkIisDJcFtZfMTpq2XUONdJEa8HDz/8a3nCiuF4EgV1X/+4LA6QkkF7iv00GRDx9NkRKZYsjUg6p+GI/5KcLetcccUYHXPjrCsqOU7IyxKCyyo74tlHEWMGLH5rF71eVlS+jPPW17vyf9xcC5bqzWVFkrjWpqs/w+MDVmtBgt/6liJWjCeIVF2F1pYW0sTsA3tGk/O1J8XlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6bc8e4-e9ad-4fcf-5c05-08dd5d704b43
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 12:05:04.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtB6jQaFdOA2f2taFdJHaRkpEYaWQ1fEFWxLs031jXq3V8TBOw6ez/91oF70d7ooURiCKYGDAqlkOe2a5X+RmVJE+M3grEDRTyz6cC8i53k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_05,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070088
X-Proofpoint-GUID: ApB8T_hUnNzqMfynzWHEfRRFkkMw81tw
X-Proofpoint-ORIG-GUID: ApB8T_hUnNzqMfynzWHEfRRFkkMw81tw

On 04/03/2025 19:59, Bjorn Helgaas wrote:
> 
> pcie_print_tlp_log() also always uses pci_err().  Maybe that's only
> used for Uncorrectable errors?  I'm not sure what the rules are for
> the Header Log.

I kept it this way, because logging of the TLP header is required only 
for Uncorrectable Errors (per PCIe Spec v6.2, 6.2.7 Error Listings and 
Rules).

As for other changes, I agree, we can split it up. Jon, would you like 
to do it in v3?

All the best,
Karolina

> 
> Bjorn
> 


