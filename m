Return-Path: <linux-pci+bounces-13112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A151976A04
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 15:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C121F235F6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD91B1AB6DD;
	Thu, 12 Sep 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vFY1xnLV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E21AB52D;
	Thu, 12 Sep 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146607; cv=fail; b=f3bw3cTTgwrMOdiunV7s9d7ehxa9S2u0XmD2mn9fuAMEh4hrLWPVLL5Sczs72MXS6XyF2fNTjCZce2E+KcbTrEjx/oKgCeCj3yxGiBO3C6Zo9MB89xpMHOgVm+h5SwyL5aFv0xkT7/xLFbRzPAIYAM7rgRhQ0vBnzLJvbChSIKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146607; c=relaxed/simple;
	bh=4rZV+sXlWXl8tvj1vFLDUbUkbhP7PkkcSgT7g7lVttE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gZa/4/YpKCKB9RPTC7pz2Ct88NIBdhb7CM+wlYZDfn3OuzxnizatqdacWo+HFUDNmkNExGJGDhnmmFlfxOhLTab71IE/TSzAlwA5dxYPiCWOLRkinNM9eOjsplhWsZ1OiwvOdsR81WLG1TiZgkUhRTkhie06FX4S70+5gyO/VjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vFY1xnLV; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3HqkEXdXPytAxKFsq2F3NxYv+yg/ZYWpa8zhKcAeOmUBrWvJm1c4lIwPayGH6zcN/vPuu9hLuaW6K4x2Q6+kS4DdVwktm30sY+5RnaT7IDQxNDNwZkmQ+E3puMSjFfCsa+KbXew7JFCGg2Fa9iAxyU4Ete37EaGhnpMtiYbbt1Xkhg3b8fQNCeF4xe5eZE+T4HH8eay25sUlwZwSRjCVnjMrtdI1K+GpqL4e2RJLQILCKnDfYYNVZtMShG/dg/UJyfm8/20jIeGBH1CkXwLvdM8cD9TxPBu9fpnM7Qc1JQYOOOjSgyc1XjRJ7KXOz+Xe0nZ6Tc+wTxw3MiW7kQFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKJn7QqIZqsqFOjbpTCOylBkf7sTDUhgJ+mr8/Xb3FQ=;
 b=CifKHIh+vMIhgigl8ZSPi4+YEN+S2yp9pm+yoL5t9OGHnZfhnLQVSJ/ASGCOaHFioQ1RgzEEymvcGtuW3SmqkxDndor7FQpmY8GPuNm/rRt6aSftpJ1NnXDoRsNAQg396TgZnTjcgWq+t+GdvG9oDhLfmKpAZexGqHUpRMjmL+cfjBzc2LuEySo2XBF94FfV1sclLlSjfnRhv3r3+lvhMDroLWh7lGViz5f6uyZJpsWPiPgv1DBUK7VS7YoB0BbJAR0QHpzoW2/8cHX7HerEEg/F0kPjA+aborzKYtaiE+OtGt2ZDU5Q88ir2g2WpaO2RLam/2bDOS5zlCIU+WyTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKJn7QqIZqsqFOjbpTCOylBkf7sTDUhgJ+mr8/Xb3FQ=;
 b=vFY1xnLVWfe3Lbk5iR8t2+cm2HVLBTmeJnm8Z+yulCPKTvgaur/Q5QCdO7mqoVat/iC+crp+eor4BaEFUM1BQ4QMspmuSECdPq3qSo/oTWuqpnbEo/G19hYIroQDEDtb2eYeuZreeRU4Xz4BR98SaHJunethshUpud4w3E8idb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Thu, 12 Sep
 2024 13:10:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 13:10:03 +0000
Message-ID: <08bea3c9-89bc-4483-bcf0-81c298fce80b@amd.com>
Date: Thu, 12 Sep 2024 08:10:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
 mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
References: <20240911190516.GA644336@bhelgaas>
 <319e5419-3b12-4672-9f51-f90c5e142e29@amd.com>
 <fa504022-acb3-4930-b6b8-87a8dcb912c3@amd.com>
 <CAAd53p4ZpCF0GpGhzUx_7V8M2+YCsxgMz8CePPGG_fBTG0JzZA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAAd53p4ZpCF0GpGhzUx_7V8M2+YCsxgMz8CePPGG_fBTG0JzZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0159.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b615d2-a1f7-4e45-5826-08dcd32c36c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkdDSFN2OFFJY1NpNGRUdTBUWnpOSllpSTMvb0J0RzBHZDhGZzFHODI0K3pP?=
 =?utf-8?B?TVQ4am96b1Z0cUtVYXBoTzZCeTZ2R05wWE9qcTJTZVdwdnBJT1ZTWVVEdGlw?=
 =?utf-8?B?QmJLUkowTmY5anorZ1lBWnZkWlFFbUFmdkZOUituYnRINWRlQ0NRS2dSSmtM?=
 =?utf-8?B?TXN0TlA3NFVkU294dVRFY0FPcmpaSXJ3STdwZ3dLYXFlNzVqZU9SY2lyek9r?=
 =?utf-8?B?NlFPbHlVa1RMRUViSTZLSktyVGtoK1pDUjhVNGZ4TTRnZVlMY01oZnJEUnh2?=
 =?utf-8?B?bnV3NGxBY3NNWk1icy9OeDNOYjcrMnZMTHJYVS9ESkVPNkZnVm5KdEdKcDdY?=
 =?utf-8?B?R1Z3YythSDdpWStZbWhkcjlWSTFjdDRCUzFueU9reHdPa0haWWYzZE44QXBN?=
 =?utf-8?B?NmFnVis4YnNkUEIzZnZYZ0VaS0hIL09hSFU0YWVndWlkdGxQU1dOUXpoT1Vy?=
 =?utf-8?B?VGlBb3lxb3ZOY3J6RUFVR3IxSE9KeEdudDRzeVppRklzVzhyZWxiMVhJTmZN?=
 =?utf-8?B?V2NkVGJPcWxPMmdBQkt3MEN0dlllMURnT1o3RmdtRGxYcnV6YzhnWm90UnFE?=
 =?utf-8?B?dE9DSDNEV3B4WVM0KzY5WDlsZU52eFI1UmpnTGczRFBDbzVaQXdmSlppMDF2?=
 =?utf-8?B?UXlkRkZjVFVPaDdnbVpweVh1MkJlVEZpYlJsS3A1SHVxRGt5Q3E4b3UwVUNk?=
 =?utf-8?B?MzFTMHlZaXJQUzBhQTdqMHdjcExMdDV6WWtpWmNCTkxvbnJIcHpHdWJGQnJ1?=
 =?utf-8?B?cVlmdmYycTA0V1hqYi80V2ZydHRLS25mc1BwN0FpSzQ2N3RCTDZCTnJqdW5S?=
 =?utf-8?B?ajYrdTBodTcrblN1YkJEZWlUdGtmM2c4N0g3bUV3U01uaXVTUnVQU2VtN05a?=
 =?utf-8?B?RFFtTWVxUkdhamJQVlhyR1BmalVoNEUvanpBdUxpVEt6eCt4WmxUY2E5L0FK?=
 =?utf-8?B?WGNLZ1hpQXoyU0dCYmViZGw4dlZhT1grRU1JTENYbjhGbXluRlJmZ0ZLWWpr?=
 =?utf-8?B?b28rVStuR1hNMitjV3N2ZzQ1L0ZUNXI3ZW80ZEFwaU5mdStjWU5LUHljbmhy?=
 =?utf-8?B?ZjR0SXZEWU1qS3Y0bWpXaEZUbm5iRlJuREtKVU5mbXNxWEFNRm5MRVl2SjNk?=
 =?utf-8?B?MnVCZkhvNUVWVEFjalNWMURtdWl4VFFrZVFtNzUrVHVvV0xaQ1Juc1RtSXdu?=
 =?utf-8?B?Yjg3bG1yak5tbmR1NmNJN1laa2loK1BRc1hlaG9zL2x0Nkw3d3FRMWJhWGd3?=
 =?utf-8?B?WU4wQyt2TFV0RmRWQ0N1YUF3T2dTVU85dENrblJoRzFjbWNJdU5TSm1Sa1ZW?=
 =?utf-8?B?NGFFanB2TENqN2VIcWVUYmFsaWo3cXplNFFpdnM4WHp0VFVXTlFPR2ZWbnJa?=
 =?utf-8?B?VlZxa2hxVTJQRFN1RkVGMVQ5SnpwcVFibWJoUTA2K2RMVlVFdW9uUm9WdGlF?=
 =?utf-8?B?ZU9wY1gvSTArcjRqbllsNlk0UGRIb0NmSHhCb2lMcS9MUFpmY2dJVnAwaTVO?=
 =?utf-8?B?ZEd4Y2I0V0JYc1pIYmtMYkl1NGRMSEFQRFFnSUNJOWVRTmx4cGJiVHJqZW1F?=
 =?utf-8?B?ZHRMZ1ZlNUpJaXg1SmZXdlJEWkRCL3NocEZaTEUzYnArWWtuNjJTcUhtb0pK?=
 =?utf-8?B?cGxBai9FYTNveW9NSG9iWGxzM0pFeGhOa0NTcTBjYUZlbnpDQXhXZ0k5TVdL?=
 =?utf-8?B?OVB0amxhY0xwTXQ5MlJzY04wU2ZLNGFSSTBtVDVTUzVKenc0bmJ0czViMzBR?=
 =?utf-8?Q?h5H2YvVOhgVHJRKJEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0JncUtCRVRUWFRmSW9SL1NWZ0cxNUxJNXFoWFdyMmlFdW9RWWZyVXZsTllB?=
 =?utf-8?B?b3RwN3FXZHhWa3k3dFlrQUxEVVZTdjdwYWZMT09VRE9kZjlvSzNtK1pmRHFQ?=
 =?utf-8?B?TE1HNDlNYnJZMnc4M2ZpVkhreERkMkdoY3Zkc0Y5NmRacDFMSE1JM1NWRkk2?=
 =?utf-8?B?K3IvNWYrOG5tamtRNXJIQ0VLdFU1U0VOaFdZajUrenY4Z2VJSUY2OFNJbEY3?=
 =?utf-8?B?VG80UUpMMlZLaEhqeWxkbGsyVWJzN1VlNXRaeWpMQkRyWWxuTWdwNzJySW9C?=
 =?utf-8?B?NEFIL2dKRUtLQ1lxN0Y3OVlMVGJhYnpwTWR6TXYzNHBpVDBYWWpiKzVmdDVp?=
 =?utf-8?B?ZGxHbHpUeGdFZ2U4VzZvWUZsanFvNUNYQ1p5c3JNT1Ric0pWcXJnNG82V2ZU?=
 =?utf-8?B?L2VzWnZSQ09oa3VXR0FkT2ZlTTZ5QldJdFQ3NEhORHdnaEVRb2dLdmRUVFpU?=
 =?utf-8?B?YVZuTlNxeHJWaFdHc0Roa0xFbi9RakNzejNNWXVoeFFDTTJ6dDJ3eXc2VG4z?=
 =?utf-8?B?MGhsR3Mrb2ZRQ3RhdmsyWTg5cjdkWlltTmo0cExSNFMvb3FWQjlTbmxKZmRM?=
 =?utf-8?B?RUwrN0wvd2tEdi9nUHhZWmUrNTlDQVA2RE11QThxUmtvaTd2L2R6c01YY3lR?=
 =?utf-8?B?NE1CSVJkeU9SbTgzTVZhY0l4L0RDbXBBR1NyKzN2RFpVRXpBVnU1SmxDZkEx?=
 =?utf-8?B?UW5FQmtuMExJZm9SaFlrS0VkWFQ1eVBFaENaaXplT1I1eDV4R0hpM09FWklE?=
 =?utf-8?B?aHo4eVJtRkVNRzBPclJJV1psU3dWL1J0c0lsZDZxR3NnRFNXM3ZsaWRGTTd2?=
 =?utf-8?B?c2pIeWNrd2Y3K05qaFFGZFJBVGRvVld4ZXozMXZmVm5KK0tnYU4rNE0yS29S?=
 =?utf-8?B?bnN0RXdJbWFhT1pkQ2Z6NkYwb1BJYkxRSG9NcXVUemRaaVVXOXlFRVVtSmYz?=
 =?utf-8?B?RTdFM05CNStnTmJYTlRvYUdDeUpkZjdiaEhla25DQURSK0VBNENrOEh0cnpK?=
 =?utf-8?B?ZEFVeG9yblphejFvbEhSZkhZamNXOUlybnBrMmhsbm5LRGRBbkZRYnZ1WHdl?=
 =?utf-8?B?K1pFeTA1UkF6MmxVZDh0NndSYVNWc0REaTJ4eldQTGQvYmlYSkNkaklYM3Zv?=
 =?utf-8?B?bjBwTmg5RmF4cENsTW9KN0pLSk40V3Q5aTRMOVRlZnU5cThTQnQ0Y3VFQ1Vm?=
 =?utf-8?B?c01tTktQem5PcExMa2NMcGpuNjhlQ3Rrc1daUjRtMTZrTHdxWjdnQVpMNC8y?=
 =?utf-8?B?bmtSOTVrcVZhVUFwdjlsZjRVZXp2VkxVQkNMSzdDUjRBREh5a3ZkSFZudkR5?=
 =?utf-8?B?clB4bWZxS3Z1Y3U4UmZaUFJiTThlZyt4L3dOV1cwcHVmK2NxVWttQ01ONkdT?=
 =?utf-8?B?VUxONTluOExwcE85Vk9nRmxsZHh5cnY3M0Y4QW9Cd1JRTXMxa3ZwLzR5bjJI?=
 =?utf-8?B?aXgwZEZMRlRvbExSSStOUEZSZ3BiTEVsSFVsZC9YRjZiMUpkS0QzV0lPL3Qz?=
 =?utf-8?B?TXBpSDl6YVNkVG1ObTBQK3BnZ2dvSXlrS2tlSGdsR3VOckUzVTJJdHpTNEp6?=
 =?utf-8?B?WlRxS2xNOTIwM3lBRzM5aEcvSjVaekUxVnFTdlVMbG50aFRsWGd5ZHNUeU9p?=
 =?utf-8?B?WkNQTm5aUGxLRGJ5T1E2Z2VOMlVLSXE0MG44eUFHL2NVaFhma1JLR0hxWkdJ?=
 =?utf-8?B?Rm1LUmNuNHgyR0VzanJaUjA2QXJ2ditvdFpBc0N3dEFhZWlkSWNSeVRydGRR?=
 =?utf-8?B?UXlCNElMcEhpbUtsTHg2OWRVczZ0WlhBMTVZYVQyS3l5UlpmR0hoS1FTU3BW?=
 =?utf-8?B?R3hmV2Zvc0VNTzVkUHlOQmN1ck0yNXIxc3FuRkNzNlkzM1NRVzNCVVpiSXZj?=
 =?utf-8?B?VFR4RmpvbHZEMldYNDhNZWlKNVB3Sm84Z1M1MFlQWG9FQXpjTzJsNXhlTit0?=
 =?utf-8?B?UnZxcmFmcU5OVlVrZDl1M2hxamVRczhEdjZkbXoxUjFvY1ZjZEdnME9NY0py?=
 =?utf-8?B?N0dESkRUSWlsQzdLU3cwREMveHFhVkJzTnFzR3E2QmU5WU1lVll0VlhOdi9N?=
 =?utf-8?B?VzdmbjRUWXVKN0NIL2M4Y1R4Vy9zQWVHZTE2aU82UlFFaWJ1NWVibHVVcXlJ?=
 =?utf-8?Q?1yVonT6XrTR+x9KeXb+DkUnCE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b615d2-a1f7-4e45-5826-08dcd32c36c4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 13:10:03.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmwoKrsc9yIFlxzSqIjN51/OpOKmQ+SUHl0xkntllR1uDUK4pFlpXxJ4dfC+yhraQnIAcgHSVc7mptEyIM6G5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181

On 9/12/2024 02:02, Kai-Heng Feng wrote:
> On Thu, Sep 12, 2024 at 3:38 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 9/11/2024 14:16, Mario Limonciello wrote:
>>> On 9/11/2024 14:05, Bjorn Helgaas wrote:
>>>> On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
>>>>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>>>>> connected.
>>>>>
>>>>> The following error message can be found during shutdown:
>>>>> pcieport 0000:00:1d.0: AER: Correctable error message received from
>>>>> 0000:09:04.0
>>>>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable,
>>>>> type=Data Link Layer, (Receiver ID)
>>>>> pcieport 0000:09:04.0:   device [8086:0b26] error
>>>>> status/mask=00000080/00002000
>>>>> pcieport 0000:09:04.0:    [ 7] BadDLLP
>>>>>
>>>>> Calling aer_remove() during shutdown can quiesce the error message,
>>>>> however the spurious wakeup still happens.
>>>>>
>>>>> The issue won't happen if the device is in D3 before system shutdown, so
>>>>> putting device to low power state before shutdown to solve the issue.
>>>>>
>>>>> I don't have a sniffer so this is purely guesswork, however I believe
>>>>> putting device to low power state it's the right thing to do.
>>>>
>>>> My objection here is that we don't have an explanation of why this
>>>> should matter or a pointer to any spec language about this situation,
>>>> so it feels a little bit random.
>>>>
>>>> I suppose the problem wouldn't happen if AER interrupts were disabled?
>>>> We already do disable them in aer_suspend(), but maybe that's not used
>>>> in the shutdown path?
>>>>
>>>> My understanding is that .shutdown() should turn off device interrupts
>>>> and stop DMA.  So maybe we need an aer_shutdown() that disables
>>>> interrupts?
>>>>
>>>
>>> IMO I see this commit as two problems with the same solution.
>>>
>>> I don't doubt that cleaning up AER interrupts in the shutdown path would
>>> help AER messages, but you really don't "want" devices to be in D0 when
>>> the system is "off" because even if the system is off some rails are
>>> still active and the device might still be powered.
>>>
>>> A powered device could cause interrupts (IE a spurious wakeup).
>>
>> It's a bit of a stretch, but ACPI 7.4.2.5 and 7.4.2.6 are the closest
>> corollary to a spec I can find.
>>
>> "Devices states are compatible with the current Power Resource states.
>> In other words, all devices are in the D3 state when the system state is
>> S4."
> 
> In addition to that, vendor collected the wave form from the device,
> Windows put the device to D3 while Linux kept the device in D0, and
> that asserted one of the PCIe interrupt line to cause system wakeup.
> 

I did the same collection and confirmed the state as well of many PCI 
devices on the system, elsewhere in this thread.

https://gist.github.com/superm1/f8f81e52f5b1d55b64493fdaec38e31c


