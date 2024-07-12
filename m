Return-Path: <linux-pci+bounces-10207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1676C92FD12
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7401F2433E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42C172BD9;
	Fri, 12 Jul 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jWmWSxml"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92587172BC8;
	Fri, 12 Jul 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796352; cv=fail; b=TmL5eMwZS10z6h8kYXAMwCOhmc6OaCpt/OjVSyeksrHsokRTxmGHIOx//ee9Q35augaM0fEwB8APLtyfnshS/yjB5d0U0XTsWV0a+l1+/8KZrDCLw193SGPW24W/1jLa5826SrOnABPGZ8pu4IEvHUkAjzhRh4bWhanlx1QuVoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796352; c=relaxed/simple;
	bh=14trOAk1AEl+TAk18JMo+OMFFX0++xTxGLpaKC0865g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kWgfFCMPXeiRuo1uQGPunbLihF41FaSZdI0uzxLCDTw6kbsHStDi2orXP1RFM7D6OO36no/tKEfYFMUcFOYFm+RrlnqxxDqbLMQdBKQlrNn2qmgpG/b+WErzYATDaRo4xISae+8pRFa3ZDAzvXRs0G+WmxGuvcuYRujhg+vP3cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jWmWSxml; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7BceMsg66sZoQvNg6D3rb9Cb1rZPKL8A+6u1VjlTobpH3z8uohnZC6WNaOtDZGCcjPyjiFI7kTI4TyjfhwXbmBflxqa0fjGoR61YQ9FEdagdSpPGlkQP+ium74r/WZ1AjsX9MKbu2yt/BFu4xJBfmYlqcvv3HObA2HkVZ738AWaNRsDZkWvYvej7Ls0uz18SzVz4a3jFesf8UrMcknj+6EOB59mVjwBrWSnt4uH4aPgydA19CkEkxzkF02l3EbYVdPUghnU/exIZ2NaQ74sXaDr41UeRZy0QW4n1+3/De9L7PLy27FpWcIQ3zabodxRBCmSt2UAG7NjWGc6o2NpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBWKaNWTI9yZS+Tmlf2Mz12hkjPy3SRsXg2JvM9difk=;
 b=iTHQVq8btl7hlDeAj1n1HuZ4k2EA6UCq0hJ1/JAlYLLpmbYvEdBovkJ3EO1TVDvD8PWo6zXN/0JBoWM/UWisLy3OF3wnT3HcdtR7fXI2eI2xs9XYe1fvq1UtEJELSkJpUf2J+GmdVSWHKiaO4V1e/n45P+W5XL4t+YlGcarlEYBvDZCkjpRdpd/Jz5ta14R/uFF44hr/kDl8iioE650cE6TovGMwo1uc1OTQC4kta1CqH/RbsqEfhClJN8gwuFRGXsNHR874rQ0kdKzvPvswH4Sz7Ke2mbSbfNG6OIw3jm3ty64G2GMV7G/Ll/O88IGRqddTXwq8hhig0h+2yvarNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBWKaNWTI9yZS+Tmlf2Mz12hkjPy3SRsXg2JvM9difk=;
 b=jWmWSxmlK0nmAeMjBwHpiI0+R42K0kdMjcKXDL54b3CxHUbIqcRWTsTNsw1A/96KXJkiKxR0GWrhguZV5ocLdjSBwYyLOqgbCSSLzwqW1hSejSSyoifPVBEnxRNUdn7ZD+lwow3IDYAROXnF9E4dQscpAODCJgQtlhMlEFvDA9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.41; Fri, 12 Jul
 2024 14:59:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 14:59:07 +0000
Message-ID: <9d2f1619-1c61-4e8c-b28d-d4eddefa45c3@amd.com>
Date: Fri, 12 Jul 2024 09:59:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc: mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20240712062411.35732-1-kai.heng.feng@canonical.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240712062411.35732-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0107.namprd12.prod.outlook.com
 (2603:10b6:802:21::42) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ea0fc1-c00f-4eab-37a1-08dca2832daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk05OHNmVXdCaHBMdHlaeXpJV1VWanRLbzhTNjhMQWtiY0crRUNKYm9nSEFB?=
 =?utf-8?B?ZERxRGNZazNuLzQxaGR1ajZEVXMyeVFwWE5uYW84UjBSSjRKWk9XeW96Z1B2?=
 =?utf-8?B?eHk5MkJsb3RsY0N0U1JpU29JRzJyWTMxRWx0alVEUmpEdXJXVkQ3TjlIdjRQ?=
 =?utf-8?B?Y25RRDMwY21iaUxIRHA4a1NmYnIweUFIMjBMRWpPVHRkUktnMEx2QzhNbVY3?=
 =?utf-8?B?RlczcC9Zdkk5UFM0ZDJ2ek9EcEtRNFRPN0hOMC9CbEdTbGlTdk9FSnFCS25W?=
 =?utf-8?B?WmFKdTBtT1hDWHQ3aWUySExPNmhLcnpkR3F6eXE2K3BhakFhalhnb1JneFJT?=
 =?utf-8?B?WldMVlhhd2FuckhhYzR2Q0p3VGJIa21IendRdnUzdVFPQzV3ZGNhVEkza1Nl?=
 =?utf-8?B?ek56ajhsK1JPc2VBZnlXVGxhWkJQbC9lS1R1R2pvaFZLbXFibjl0cUJ4VUxw?=
 =?utf-8?B?TXZ4NkxWaWlQcEJiMThnWHRON3dqQTNGaHkyTVlocXlwVEdqYkZSUHhRcmZ3?=
 =?utf-8?B?OEpLWUlqdVI5NVNSZVFNZjJtK1ZsNThwcnhXK3BXQ2ZNYXN5aGZFTnozd1ZV?=
 =?utf-8?B?V1I1UGowbExqaTJnS0hjRjVHR0tzSGZweDhkbFRmT3I5b2U3Sk1FSjVaTnM2?=
 =?utf-8?B?cEpYTk81a0FsOWdpbDRybkpjTkZPcHFSSUJnb1JUSmZMS3VWUnl5WUhldDlm?=
 =?utf-8?B?eWhlc25YeGZaMXVZQ3ZlZ2oyeDFFYUw0TWdqQkNWQnFFU1dyTW85aDY5ODJJ?=
 =?utf-8?B?NXAyWVRXbUhXdmo5THN5SFJEWUszVHpEV0x5WW02aHJwOUV0V1k5akhHY0xN?=
 =?utf-8?B?bktJOGtNVmpWdSs4eks5OFo0S1ErenltbndIYmpVN2lDUUs0eXZuMVpubENs?=
 =?utf-8?B?dWlmRVRhLyswcm5uUXRkcCtnRGdxaVFFRUptVGFKMlpOU2NmZHp0QU5YanFu?=
 =?utf-8?B?Nk1XS3JmSkg4eUdGcGw4Qk5sZkJ1bHMrd0szU3VpRWJjUG5naCsxT1R4NFI0?=
 =?utf-8?B?MnpHZmprTHBxSWN1ZllWRWpTdDNSWjh4cERrRzNYeTRJZ1oxSkJselVTSnVS?=
 =?utf-8?B?R3dvVmFVcW8ya3RzU085dW9ManViS1ZRZXdoTnozWXQwWkljSjYybzVRd1pZ?=
 =?utf-8?B?cmUwbG9jei8rdkgyZkI1TDBOWCtlUWxXZ0k2S1dQZ1ZWTG5nVWdFTGE3eTdT?=
 =?utf-8?B?RVc5SE1adVlGMDBpaHFicXpyRWlBODcrcWRBS2JNV1FOY0E2U2V6Ly8rVCtH?=
 =?utf-8?B?UmxqZzNuYVNzMlJ4Y1dLVzFNSzBUL3Q5dWY3Q2tQZFdIcGFSUlNIamR1eFQw?=
 =?utf-8?B?anlOSUUyTHpZZzhyMng5R0JlRmdVYVFjdlgzMFpRY2dBQlFYcnpjMVJGdk0w?=
 =?utf-8?B?NGVVN1VJTkg5UUJiL2JWNTBOWjVRQUkxMnIzazlrY1VQQS9EY2hrT20yYzJN?=
 =?utf-8?B?L01FNW56QzYxWXIxM0U5eFlGUEh2TnB3RWJZdDZUL3BUaVNyb252aHFLeCt3?=
 =?utf-8?B?azVUcXJUMk1FanVqYU1qZFJkakN4SGJ6NDBpbVZsQmZsN2MvbkpGeEorSlJC?=
 =?utf-8?B?TVg2NTR3NWpHMzhHY05uRkE5Tms5RVVyZnJ1b1EvNnp5V1k0OXorVUhITnRK?=
 =?utf-8?B?aEU3UDBLYkRxOVd3clhQb0dudlJvdzFhd09JcVBHSnJYcFFCS0RqekFrUzVX?=
 =?utf-8?B?UTllN0xoRDBQSUxjQkUvcEVWNElORDFFSWZuWG9ybEhuaGpFVHVoOVpMYTVu?=
 =?utf-8?Q?0qUTMG/yJvqICFAL90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2R5ZU9oT0EwdXJpTUhodExSUWJMRGhSSy82V3hGU0xjZlF1RXo5dUgzR0tR?=
 =?utf-8?B?aVZRN2Jlampld0NUaEFLMkJCZWdlY3hNd2dtQTNyZEIvdUV1YkhsN1RKUVp1?=
 =?utf-8?B?QjR5M0VFd28rMTJSemNUYXBrNHkvRE1TVUNCQ2lxa2hLQ2VrVllhMUlBNm42?=
 =?utf-8?B?T0p2TGIzMVAvbUJxMHRWNWUybk1CUUNqVXdZdC8wd3pLcGNVd0MwaEZ4SVF4?=
 =?utf-8?B?YUVtTnhQOEFpV28rU1E5MkE1OWlESlZWYjQ3QTVQKzJKL3pMbTZ3SkpvME9Q?=
 =?utf-8?B?RjFOZkFVNGg5YXNVUzA1OG5CdzZ6ZTRrNy9mV0FIVmJ2aldRa0hXekZDcmF1?=
 =?utf-8?B?cWRVZG9Fcm13VmhLNXQ5eHMwZXk3NkEzL3ROeUdtZVpURWgxbm5XM0VWVi83?=
 =?utf-8?B?MW1QQ2xTVnd5NzJINkpuS3kyMlZ6RS9zbnZ2SEpPWlh0RjhuVmRLdXNzSHpm?=
 =?utf-8?B?RjJjZDNFcEpBelE5VGk0MWFsRndoeko0dzhhWDdXNnM2U1ZEbmRXekNJV1cr?=
 =?utf-8?B?bGVuMDJTajY5NDNXSFZTWE9tVTNmRk9EYmhDWVMxZTF1Q2Ryc1hhM0dTa3JH?=
 =?utf-8?B?cG9wNW9yei9mRWtCU2MxcllVbUZrTmNMZW5LRkFydHR1b1VnNzBOYjhtV2lz?=
 =?utf-8?B?Vi9yeFplcmViQkVQZWNNU1JpMDE4dHhIUXNsVXF6UlJoa29UeC82aDBZMWlL?=
 =?utf-8?B?ZEhlang5aVkvNE04L3RONHR2c2dTRjJkdmdTbWo5RzFnejFtRGQ1UW9zWDNY?=
 =?utf-8?B?ODA5RGxzb25ZYzR2K09HSUVwQjd4NVRnWFZUY25GcVdtcllEVWJIc2dDRmpZ?=
 =?utf-8?B?WG04MUNHTE8xTDJtbldad04yUlV2ZTAxTHY3OHlyRkp6eFZlRTBnUElYRnI1?=
 =?utf-8?B?UEZTekRybis2SjJkR1VQM2RoS1pRRG1hSzNWQ01mZnlXNW9SeVVyOUVKTVdK?=
 =?utf-8?B?UlNkVkR1RHdjemhvUUtOa0U1NFZRMnE5VEUwL3p2bXVqSXpiUDFDdmRFY1JG?=
 =?utf-8?B?Ny9oWWgwakl0ZFg1a21wblVvUjhaMzU3OW9vVEJuek93djIzVmVreERJK3V5?=
 =?utf-8?B?VjlYNXc4UXlXLzFYUkdKV2FVZHYxRHV4MUdOK0pManN5SWNCd3oxQllaaktm?=
 =?utf-8?B?QzRVY2tCRE85MkEvWTRNR0VmWFdRbVlRRWdVaUFHKzE0MEExaTdwTVZqUkw2?=
 =?utf-8?B?YWlRZ0szV2ZQdFdmQUNhOUtaZU1vTFhScW16QlJHd2h4aXJXUmhiczZnaUoz?=
 =?utf-8?B?TVIvd25YVElPSC9HaVY2QStyMUhrV3p5UW1wMjdTVEdGSVR3OWpIOGt3TUFX?=
 =?utf-8?B?U21NcXU2L1NIcjk2cURBb0RVU0NwdHFFeExLUThxSWl1MEo4QU9tUlp4OVRQ?=
 =?utf-8?B?QndzWmJlVEVUUzhWSkhtdmpLWnloeVVJckZQRW13QTBUeHBzUjVkYUxwQ2pj?=
 =?utf-8?B?YzRRWFJEb3J4cUIvTWpqSmhxVXVQUkFORGt0YjArUkZGNE1WSEljeEdtTWFl?=
 =?utf-8?B?KzN1ais1d0pUdHJzR2dvQ1BIWU1ILzVnUGhMZXBoeWVqcHREbWlnL3VXSXJN?=
 =?utf-8?B?VzlnSVV3WDV4dWNPRjZJT2hicUF6VXZUUUdrN08vNEcwelJzek95cHZQdmI1?=
 =?utf-8?B?R0tWcnppMk83ZCs3Q29GNEJKUHRBdkQzWnllMmxpM0JRdzRDei94S0NVMEMw?=
 =?utf-8?B?QmpNRnlpZzhZdTA1SnpMTFVPcXplRDRUcHh4MHd6dS9sQWRJZWZsMnFMT0Y3?=
 =?utf-8?B?RnZIVHBlTGRHQTJVd2pMSWhUSGlNTUk4emVacDN3RWQvQVc1VWNkeGR2UDZa?=
 =?utf-8?B?dTZoY3l6aTZSM1g5UFp2VFdvRnI1VUNXSG9Gd1AxTWYwQmE3WERDODRLRlNt?=
 =?utf-8?B?TGg0d1FGNXVvSDdpL2tsYi83Tll0ZnJ4SmZUVnZrOFJjYUFIbnYyNUMxYmFm?=
 =?utf-8?B?Y3NIVlI2WlQ4dEdZRllQSTZ1NC91ajI4T1BkYXZzWUljdERRd050OFVObU93?=
 =?utf-8?B?eG94dkNrdXMvaEE3UFU0Tm9QL0RCS1pucSt4REdIeDh3NDQySHZFOEJROTZ2?=
 =?utf-8?B?dFdzZG5ZbFEraU5BZ0JTK0pPK2lkcXNmN2lyQUlPcHJFYlFzS1Q4WE9qd2l0?=
 =?utf-8?Q?O7vfRDNV/F8aDOOS2NJYDtEqU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ea0fc1-c00f-4eab-37a1-08dca2832daf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:59:07.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7NuayO+qHGM69Exbqah4fcOUwXPESKK++ORKNalbBrdwHcwI6W6EUQOSSKrE4H69QMAiKbTUB3switvDod7zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500

On 7/12/2024 1:24, Kai-Heng Feng wrote:
> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> connected.
> 
> The following error message can be found during shutdown:
> pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> pcieport 0000:09:04.0:    [ 7] BadDLLP
> 
> Calling aer_remove() during shutdown can quiesce the error message,
> however the spurious wakeup still happens.
> 
> The issue won't happen if the device is in D3 before system shutdown, so
> putting device to low power state before shutdown to solve the issue.
> 
> I don't have a sniffer so this is purely guesswork, however I believe
> putting device to low power state it's the right thing to do.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

This is directionally very similar to the proposal that I had at the end 
of last year.

https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/#t

I definitely think we should be aiming at all devices that don't wake 
the system as being in D3 at shutdown.

> ---
>   drivers/pci/pci-driver.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index af2996d0d17f..4c6f66f3eb54 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>   	if (drv && drv->shutdown)
>   		drv->shutdown(pci_dev);
>   
> +	/*
> +	 * If driver already changed device's power state, it can mean the
> +	 * wakeup setting is in place, or a workaround is used. Hence keep it
> +	 * as is.
> +	 */
> +	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
> +		pci_prepare_to_sleep(pci_dev);
> +
>   	/*
>   	 * If this is a kexec reboot, turn off Bus Master bit on the
>   	 * device to tell it to not continue to do DMA. Don't touch


