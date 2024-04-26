Return-Path: <linux-pci+bounces-6691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75E58B399A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 16:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348B01F22988
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 14:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA71487CD;
	Fri, 26 Apr 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ro3xglWh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40431474D1;
	Fri, 26 Apr 2024 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141083; cv=fail; b=k8QuRqSwkwX8LlcvWXaoywKhn/+JcHVJ1hLLgFsIsFoahp9zXloqAPT7aPWjdL0w7uf7OwErVVEso0unteCvj8Sj+eWPQSoinq6J6+5rk+h61UJ3yXHQn8vwracUzZBJN/gB3HW+jRgOmoZFfrVEBka8WyfDx8/HdDm3bM7M3Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141083; c=relaxed/simple;
	bh=V5sIU7HXbY7SwkdIqk4cTbofCzfKv5rtcCOFt8ZmtwI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iiKirvLD8q53vJu3/naOi309nGRt46qmqTcweAIsHn0RHmTDkPbp6uiTa12Qyl+IXw0p6YEmsTu72McCSuTh8PVjkvCPCuwk00RmgHrL/5gEsCtttp4XW4ovsU/ukfJ0fJRfp3QP+us8BCSqreKXO/vh+zkyEdGLlrTZcxvoz5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ro3xglWh; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiM+lFosxXXjNmRl4O2MwkDZmJ+j7lHBWxyG6wqxbyi3CX+sFR+GadksWLmUu8y9to5skz1aLbupiyjwwT8vPs1AnFj+y7xadymJVG6rCJBsZ/ByYPmd44YIAH/WwQ0FsIDFgq2zI35Tz7IZMTR152MvUDiOkDTKuSTJks0aEGYZNjyzLC7+C/okAyWBSaZ1mx+z/dTBqIzGyNWvLJWEMV/KI9Z2hK4gr5Va+5Y1lEumuaFSuwBMOwfR+sqZB7CLa7oxlqQWg4+O6IgFneEkgCSMra1Te14JAJikaL8UQJqNeX9cklZ0Bd1tkItw5orRxFp5j7Nv34OnBkvNIBd9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqw9XgBEzEe6mWGmq6LePPf6K6oqxky7Za/gKT5gkCA=;
 b=B6FlccGY7petz1+nTsik05z2NGwW0DevZO3XJqpu7w2vml9HDShi9zhoXOQBF7OUr9vFlMgdG4oXZFcBwVf/3VmFLc7ofK6Qv3w969SdiEce4aaDcdv1zIVdAed4QdxsAKEPNT7xPVPlnhKPoF3Z8hcqDErFdmZ6SiNjokM4RCHdDelfGJr5WV/VpT9p90Gmi2FbyMVDUOGK+F1qaTL97FhZbt1WbJMTzRbNzihNXCO1GBh5uyUKZvI89wIfWEA06l93u6qEK5FzIE2lCP1LflCyIp1NXrAGZ66nULMZhCbVGz0abXCSitTpmSmAr94jaNJmXXoLVdh+VHb9dfdueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqw9XgBEzEe6mWGmq6LePPf6K6oqxky7Za/gKT5gkCA=;
 b=Ro3xglWhCoCr7+JWiiZ4hvEaCRIc18bjNhCJYF8PQdAeVSIX5KzZqnun06wilskGPw5Q+NnCOh6GAuv9qbnlagL0rd/932G/1dNcSQqa7GhHdXSlMBlvF2zncNVUOxtvPEQRzueym4HdbcA0uiP4QelMqRYoj77qgB2/v9sQxXYMzUttLxbdvOWIZQ8yKPTflgXJJOUkvNoK85zQebrhMQVVXywPrug808sCdgZF522Bg3czx6HE+PZhC8CJFOHfNF4bCMgCvMt0z+XPNIaozy57nPZSJmIJRas+3dMPE9pD50WezC6S4WBmlb4HrLQHpS1xZKKIP9kkb6OlJXhiwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 14:17:56 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 14:17:56 +0000
Message-ID: <b0367d26-8524-4fb2-8567-04ad1f290be3@nvidia.com>
Date: Fri, 26 Apr 2024 15:17:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: tegra194: Set address alignment for endpoint mode
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <thierry.reding@gmail.com>, Vidya Sagar <vidyas@nvidia.com>,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 Manikanta Maddireddy <mmaddireddy@nvidia.com>
References: <20240426122731.42499-1-jonathanh@nvidia.com>
 <Ziuj-mSFQ8xPutXX@ryzen.lan>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Ziuj-mSFQ8xPutXX@ryzen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0628.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: df61e19e-21a8-4946-8b40-08dc65fbaae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHM5U0lvSEFEeWtxR3BhTEZWOHpwb1d6elFCdFBlS3p2amtxZWlqMGJGVWNF?=
 =?utf-8?B?MS91WmNzQjY3U2FBWnV6NHJZWjRFOG9rOXpjNjYvSU0xcTBPWEMxMy9LSmVi?=
 =?utf-8?B?NUdUMFJ4QkNpQlNqbk5zQmhVK01UL2k2dG5KT2U3OXpDcjYxK3A5c2Z0dDlp?=
 =?utf-8?B?anlnRmgwSE5KRTRDS2RWdjV6b2lsZjcxN25sWEhqaFl3aHozb055QzJSYkV3?=
 =?utf-8?B?YlRSVG9JdTFMaURvS3ZoNk1rZUdTOTJuMTcxWURxaUFoTmE3cHhxWGNQTDN1?=
 =?utf-8?B?b2dtTWJreXk3R0h1RDVxVUtiUXBpbTg1NG9jbGNrWUpyLy9YQ2w1ZWdVWnpl?=
 =?utf-8?B?QmhsUlRaOGxTZ3lSYlJCcWNhSzJXNnZhSUNhWmdXNkVKdXkxWUFkNXJlM3or?=
 =?utf-8?B?L2prZGJrbjdwYXFvRElwdks3RnM2aFQxMWFvVTBJWk9jdWNocXliK0UrL3ZP?=
 =?utf-8?B?MHgySXZ1aEtmcFIrVWdRMmpOaHhVRkZhTm1MaFFLQTYvNTVOUHNsalRoeUlq?=
 =?utf-8?B?d0hHZHA2MGp6OGh0R21FS3RERlYrOFJtMTRINnFCU0lyRkhZbVQ0YUlLZUVH?=
 =?utf-8?B?R016OXJrTzc0anpLTmY4WjlOamlyNGRtSTVmakNocG51REVpRDZTVTBNMHFG?=
 =?utf-8?B?eDFzbFlROEU3M21vYzJ2aXhWTW1DRnpxakJrZ2YxU1d5Vk9tRWFxcUV5K290?=
 =?utf-8?B?bU9YSjRaaFdOaG9DZnVEczkyazRTb3RGMVZOSHlQS0l2MDllT082MVo2dE9h?=
 =?utf-8?B?cVM5L05nUlpCVStQQ2NIMVluWVQyVVMyVmZ6UENCekk2RjdGWnpqV0NnaFBr?=
 =?utf-8?B?Zng3R0paalpoSnhqdlVPZjVwYWNxV0VnanUyTk5nMFViN0l6RHNqS3MzcEFN?=
 =?utf-8?B?eUJOdFdXeVMwL1ZwUGpza0tQbXovR2V6SDNFUWQzTjk0VEhvcDlzMmJlSzhP?=
 =?utf-8?B?UTgweDQyaTZqVWZCT2JZUFZLT0c5SmFPVk1UU2ZyaWRrajBmTzlOb0UxVDFp?=
 =?utf-8?B?YVNyTGdnK2d0OVdIcHNHMVpUWFlRaVhqRGxBbnExSjEwT3B5cGprZjdSeE50?=
 =?utf-8?B?WGZ2eTZMZ21JVmtsN3UxOU5qVi9PK3BkWDQ5N3pWcG5tem90Vy80YmY4Rk9N?=
 =?utf-8?B?Q3VBREhjaG44NHZPUjJiRnlyNHpueXp2WU1neFdVdnM4NHBraEdlZ2dQc1cz?=
 =?utf-8?B?NWdqNU1CbjR3ZXdkTVlLL3lUaW5NUnFpVi8zYXoraXRMSTBQYTVvNlh3Vlh3?=
 =?utf-8?B?QjVoTXVJb1FPOTgyVW14R05RTjhwT0Z6c1NiTzVvT09YaUZqb1BmelpFOHNU?=
 =?utf-8?B?UDVFMTlLK3JyUGF2VTdvRWluTXhUTGxwVmJXdjhnWVpWdFpOT25NbnFHQkNX?=
 =?utf-8?B?VmJWdk1Vd0Z4YSs3a2xLV2hUUTJjSGNNTHJuY0c4NnBnbDQ2cXlDVjZzNUEr?=
 =?utf-8?B?RFNlZjFaOFNvOExlRDRRb2dLbG5kdGJlNTVudXVUQVFyTW8zazJsSTF3UmND?=
 =?utf-8?B?RjZYajBZN0lmd3VXZVo3NkFLZ1RlUXNBQ2pmN0prRENtcVBnSFRhR28xS0lL?=
 =?utf-8?B?THJBZ1FjdkpaczJCTW5KcDJzT0k1V3lZQit6ek5wenZIaGdtdVN2cVVYT1hR?=
 =?utf-8?B?UEJXVDZiVmRhWEx5eDJPQ3JTTWNURTd3Z2tzZEk4V2REREsrZGlUR2Uxakt2?=
 =?utf-8?B?SmJCcStVU09UcThVQkN1aEpvV0RyRTJWS3FQcnY5anVDamhSaHEzcnFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWN3QlI4RXJoaENaS0xIL3dDOHVvb3p0anhHWGNSclB0Z2MyVlk3OGdRUkY2?=
 =?utf-8?B?cXdhTnpDT05CNENwSEo5WEFMaVdmSFplY2tBUzIrbVd6Ym0xNzR1UVhtQklX?=
 =?utf-8?B?Z2R4U1kySnpJK2pVR0hpNzFHcHJmT1hmRE5na3FIalcwYktOa2Jzd25LLzVL?=
 =?utf-8?B?aVlhUnh2aGp6QzNYdy9QeGRJeHVGOTRrQlY2cWVuUFVtalVCQWJtaXdnTnly?=
 =?utf-8?B?bHpESm1udEhJQkJiMjR5YnJrdXJBVEdER1Vwb2dDMjlQUnlBSzZKN0pyZzRn?=
 =?utf-8?B?YTdjcGVZMU5FRGJzOE56U1JCWUlONGs3ZGpmSjl2a1IrRnV5cXJlYWdBdkE2?=
 =?utf-8?B?WXJlWjcrZXJ5TXNyaWdBditaQXhTbDl5TGZ0cFJUNE9zV1MyTHFRSlBPclZo?=
 =?utf-8?B?TCtzbDFIbEl6aytWR2lrVFEwSlVvS3prQ1MrOGRCUXRBMnFYODdNM00yUmZY?=
 =?utf-8?B?Y0U2NDQra2c5L1dUdERwSS9nSlRBaXVQL0FoN1JNQlZGejhJMml4Rlc0Qlhx?=
 =?utf-8?B?TURQSVRDUndHczNqN2hHK3VYTXJ5QnJmdHYzRlNwRGxPbmE2TStyMFlGVkZ5?=
 =?utf-8?B?YlF5OStsdjdXZ3puQk5oVkh6MDhJSkluZHpWbzJHZGNHV3JiQW9JMWttUUFn?=
 =?utf-8?B?M3FNTGhHS2J0RmoySUhHNVFIQmJqcTlzZ1lNTHpjeUJ2MVhTTUdXVXMrdkdy?=
 =?utf-8?B?RW9Xb0VTOXBpc1UxQW1VQVV2TE45WHozcnNQcGNpbjBOK3RFV282MDJvbE50?=
 =?utf-8?B?VFFFdDlqZ3libTRwczYxYTdMZUE3aFpnMEE0a2lNUEt4RnA2aDJ6ZG9IcHhk?=
 =?utf-8?B?a0pxUTVtb3IyRGhRVFJ5bFFqWUV1OVVUQnJZVEVVMnA5SllpTURUNTZ1eFA2?=
 =?utf-8?B?dVdDa3d2bUYvUVh0RWMyazZ4UHNlcmd6S0pKSk9CbUlYMWJaY2RBSlRsdStI?=
 =?utf-8?B?U3Q4alBvOGVnYjVRb3RURGtuWEl5enlPWlk2N3pneGhlZU9DNUFPdVlScTl1?=
 =?utf-8?B?Uzg0MGw5bDRYMHNIMzRQazJRL2FDa0VFT3JlczRaVUVCTmZSU2cwdTUwckx3?=
 =?utf-8?B?bW01d2xyNzE0ZDN4TkJzazFza2VPeU5yRUtydHkvYWM4dzAyZXhRNytsbXpU?=
 =?utf-8?B?YStDTW9aaDF0M29RTTdJY2NzNE80c2JJYk1NN1pITnE0dW9lZTlneDdGamtD?=
 =?utf-8?B?bnloRjU4UlA0MmlpWGVBOWhiWXZtVFhNVmlBM0lpSkhnRWR0ajVHQWlvZ2Vs?=
 =?utf-8?B?WkdQU3hmQkVQTFYxRFgxcDdvY2xmQXUvWmNTdmJ5YnN3VjEzT20vbUtlWjJm?=
 =?utf-8?B?ZVk2dE91TCtkdHpGUEFCOFlsc1pmUVhYYzdRRkVMejhabDVDeGRJanJTYmwz?=
 =?utf-8?B?Qkd3alkwMUNOdVlodll1eDFyOXNZeEE1YmYySVFMY0VaUHBtd0xWK0RCY2ZN?=
 =?utf-8?B?b3dFUHM0YlJwYVJZYko1dnI4cmo4emVOY2JUb2tiYVF2MUpUaG5SMlFvMnRz?=
 =?utf-8?B?NEhObFpJMVZzckhDMGFiN3F2dVowQW5ONWo0VjFzV1YrbkZ6RFRjT3BIWHRS?=
 =?utf-8?B?R3E1UXhwN2daQ1VXSTR1RVdSQmdWOVN6RFVPT3MrLzFHUFlnOFUxUHo5bTdt?=
 =?utf-8?B?QkljOVdoUVBNcHByY0NjN3VITFowUHBidFl5UUtQemR2K2dXZ3JXdUxYRlpo?=
 =?utf-8?B?SUt5STVrcXhpeSsxS3R0V0xOMnZvNUEzbEhkbStJM0kwenFkTVJsRHhXa2tT?=
 =?utf-8?B?KzQ4OWVzTmpRM1VCYlEyUk5yU1BFSFBaNWtlNW9qZ3dvZ3F6aC83TkYyb2VK?=
 =?utf-8?B?aHlaZXcrWDJKRktwcGl1NFRVUjJMdnNtQVBJZXRLdXdmbUVld203Um9SQVA5?=
 =?utf-8?B?NnMvVVBHM0c5NlRDNWpEaEhjZHNuTDhUNTJMMm9UZUMxTyszZklkKytvdGI3?=
 =?utf-8?B?SWdGUnhjc01CcXlKUWVrK29SRTAvME9VV0libWIrTjBDWll2T2cvSksyUmY2?=
 =?utf-8?B?aWtmYjhSQUtCV2V4aE5FZVBRb0hQNTBZR2l0YXB3WVFlUGh0c3BoQnhLL0hw?=
 =?utf-8?B?NjgzOFE4RzBBdFQ5cVRsOHMxMEt4Sml4M0pFaUtWTUw4WmlsV3UzWVd1QTVG?=
 =?utf-8?B?WHIyNkNUYmV1SnVXSWt2VXR5azV0OElXSU9vcDFDdlJiV1k1WnNyL1FoYk1C?=
 =?utf-8?B?cnl0RTRnM2p3TGp5UUZJQnA3VjV4eVVSQzhQYXlyakN5S29JTTgrd21sTGdI?=
 =?utf-8?B?TUNSTUVCWElMODNaeVpTSk1PdXF3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df61e19e-21a8-4946-8b40-08dc65fbaae5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:17:56.0572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PgtSpc9po/G9dhqjT6o+pCVoTnV49ArjgZPsat4HpjDySQZ9lmHh/XKfywRUuLBesU5OTfKPCV3fBk9Vm5k2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792

On 26/04/2024 13:54, Niklas Cassel wrote:
> On Fri, Apr 26, 2024 at 01:27:31PM +0100, Jon Hunter wrote:
>> Tegra194 and Tegra234 devices require that the endpoint address is
>> aligned on a 64kB boundary and therefore, set the endpoint address
>> alignment to 64kB in the Tegra194 PCIe driver.
> 
> Hello Jon,
> 
> While I think the change in this patch looks good,
> I think you need to rephrase your commit message.
> 
> The 'align' of pci_epc_features represents inbound ATU constraints.
> (So for BAR access.)
> See Kishon reply at:
> https://lore.kernel.org/linux-pci/dccb87db-d826-43fa-a499-cf36ea9b10d5@amd.com/T/#m7697d1d745d8499fc6b8db855b7f93dafd7ed5b3


Thanks! I will fix up the commit message and re-send.

Jon

