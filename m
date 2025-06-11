Return-Path: <linux-pci+bounces-29386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A05AD47DA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 03:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE961886CF4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 01:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F9A7080E;
	Wed, 11 Jun 2025 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DW+HPicH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5FC8CE
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605200; cv=fail; b=CoJhWh59nxCVU6dT/l8jJWBP/Bqz+PGa+iedhCRllD1ybmHWmxPZPUuGV3xjLkn6TTKQXTmb8QDWTJJC9uaCUi0spTYfZGBicznivMsRQqz33NvB8KdW9xFkJbn0ywbGQja5VjeUVaQdhIxyCnJNlbV5zXXUBSgyCs+/cTzX3dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605200; c=relaxed/simple;
	bh=ZNtL7afJE9/SeGS7kuSTi2uZHJOx1au42dwrNN94bHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d+8OPLgRzUH3mSEIaxwkngZWrYz2+t5W23vri8aFO78dRzgmCqlozcn7HnjUDRClKp5S+WRXnuegVSngNnKpMcLWS/PTgRq+nYoikeMjDzEVssL0BM3GKYVo77PpO80qvUs1s6Q8sA+IfENccOEN8AgADIys3p7BbP6WWP0/BN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DW+HPicH; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II+ofvYZA9mAdDsJDoovpTTpDWwTRXpd2feCapJgHLnAe7UYEbcKx9JJiNQvcjXnfTqXpTBK3dvOh9tVkhWYRnobMgRIsyP+FplBFv1SaPtSGyKib7aNcoTygvqKQ6OHsq6ks9G+dAnFMpqtspphuTgHxCwWdZLJWdePNjgLEIWSCuxf/TGT7g3twGK0eF1ACR/qBqwVw6jDdx/nOeU0ZCuJE1qxMgXbMYy+OG5DxZu4WSvojOI72QMXlZ6u6V0IXHTsK91afbP/TE/opx5+6gc3k9Ec4NW0Gm6AA1ZqIo3xmE5CXFUYrRj7+mHoAPhRjW6R3d8ubFZLvdk8EExowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYyOmX6rEAh6U6f++/m+6ZnyqIJ1eCBnGeqT5epeT3M=;
 b=xNZohuAm9imdnKisi1Aytm2tokeA7zIISBKt9yI1o/CIls2I1Xmq//94HlL45hlE+gn0Uq5f2nE+euUgYfxHJ5nOWqGAYT8se0W8JbtYYGWEYt879cXi1V8l7VNLcpLR310vjmVQdaEUa3JBlgzqHwHjr6M9JOv+EjFB7vf2ObymZn0d24cel1HpIlLsly7GKpxL4RO3pEkl5I+N3Ew+jVCq975Oo6/U47l11XV3zWmoLzQhP9NPezMTdGkv77k13f2BXtbK72euZXBslyQvB05Sc1EKylZSGVEXcRwTF4GCq+glAIxvB3dqBRFKvU0ciCAVuc7q+uB8Klpjbr452Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYyOmX6rEAh6U6f++/m+6ZnyqIJ1eCBnGeqT5epeT3M=;
 b=DW+HPicH4JqSipz1ME9EoxD2YZZCa/lx1vZCB78e8mQ69fCeSUbOiDEQjNIgh3+12LE2+G8Wr4wHJxGpfOOUhKFaM0mhP+ik+KDNmJcGAE39nAzuYWPjAWCVhqhWzOlt/CFHR6gwzIdHc4OmBmB8eJdBw+vnW7Ej7/fwFpVy1bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 01:26:36 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8792.038; Wed, 11 Jun 2025
 01:26:36 +0000
Message-ID: <427483af-ab2b-4f02-a397-e5ee85b27441@amd.com>
Date: Wed, 11 Jun 2025 11:26:29 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 suzuki.poulose@arm.com, sameo@rivosinc.com, zhiw@nvidia.com
References: <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050> <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050> <20250602164857.GE233377@nvidia.com>
 <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050> <20250603121142.GE376789@nvidia.com>
 <aD/gn2tb+HfZU29D@yilunxu-OptiPlex-7050> <20250604123637.GF5028@nvidia.com>
 <d56b85e7-3081-4c99-b3db-7adf6604951c@amd.com>
 <20250610181954.GK543171@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250610181954.GK543171@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0009.ausprd01.prod.outlook.com (2603:10c6:10::21)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e9e150-4022-443e-e4d4-08dda88701a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWgva2NxTmJRa3ZpZ0pDaDZia3ltSEtjMW9EaWd3NkpWVmFSd0VTQ0M0dE5i?=
 =?utf-8?B?QlQ4VnV4czlEQnFtWmVYQktvMUJqeThFaDBWOG1JNk5jWmpLVHdhSmQ3WHBI?=
 =?utf-8?B?VUpDVmRBaWJoSWJlTWFJc0V5SHF1VUl2eElibVVJV2JhYi8yZ3hsNTBQVG5m?=
 =?utf-8?B?UGU5b3pDaCtybSs5ck1OaFJkYmtXMVdLN3ppMlVhZEZtaEFqd1VFK3VkV3Rn?=
 =?utf-8?B?Rm9WT0hwUkJYRWcyZkZQUDh0WWY2cmx4UnplMXR0RVBTOEJVcVNpR1QvS3FE?=
 =?utf-8?B?QTY5RHFBVUZMUmtEVTNXTmR6Wm1SM09TZWFSYm5MMUpFZ2c4Um92YWRaZDd1?=
 =?utf-8?B?TThreGNFLzM1MXVxd01qN1BzOGxWTzQ0a0JKSGVITjgxSEF0dW5OVk5MU2xT?=
 =?utf-8?B?MFpLZ05NVk9YcnRLTTc2MGdTUTkvOWNzTDk2UXRhVHlRR3MyWDJEZTVhTlNF?=
 =?utf-8?B?NjFSUDJCR0ZTQWNmRTR3MXhPRmhmQVBseUVhMWhOakRMUnl4enFzb0QvNW5N?=
 =?utf-8?B?aTZTN3pvQ0picE5ZdU42cVpBMm1OT2RqcjlsOFliME9ubVRheUE0V2ZXaUVH?=
 =?utf-8?B?VVA3TjNJVDkwU0xEZGZTUEZpUFArVGNyQTI1YmtjZ29GVGhWZkk0WmNrdjhV?=
 =?utf-8?B?RnJMNFQ5eUdWUDAwSnZXV2Q1UWg4c3lmVnFnMTBLRXAvd2orTE1TL2pJYW9v?=
 =?utf-8?B?a0JYRXg1c1k0SmE0eXQ2VHpNRTYrKy8wY2kzdE55N2YrZVRTbFpYeG1hZUVQ?=
 =?utf-8?B?UHhZV3VsenBiajl1NUloMDZaR1ZBV0g2citTZVRvMGhsbERtc3JqMHZGK1Rl?=
 =?utf-8?B?WWs3dFEvMU5DM2VpVld0WmNTM1lSNTNxSERHanZnUnFoOTNDY1FDdG1vbUNa?=
 =?utf-8?B?VDNrdHBaY29JRTd1ZmF2UXF4ZlQwOUVpdTkwVGxQZjhvNDNMT2N4M2oxQVoy?=
 =?utf-8?B?dm1UTmRvK1JVZkJKcVpBWjNGRGZoN2JOU0VNZE1nbXc1Q1JmTHRHWVVqSkU3?=
 =?utf-8?B?M3E1Q2VRaUpESVBNUmpjeHNGRGdKeGI1K3d1U3VQbVVLZkk3Y2drVFZ0MTV0?=
 =?utf-8?B?S1JNaU9jbnRuOGdOLy9HTzBUWndSbjNnNmc0aXFUZTVBQU1kV1Nob3dubzZY?=
 =?utf-8?B?MVd6N25iNDdGcmoxOExYenBHemMxQUZxSE5CRFhveWd2TFd6UkZhM2RvN2t0?=
 =?utf-8?B?M2Y3czMraTZENnM3VDlZRHlYckpOeXBNd3gwWC9vMXhYdmxrNDh6K3JXY3Bu?=
 =?utf-8?B?b0FIeFFHMkN0ZXd0dTA1WFZVbHRBcjRWMTVQZHh2cHNvWngva3V6NmJaMElh?=
 =?utf-8?B?L0lRMHUwRFVTQ21vZ1JaM0R3UDZxd25VODVDQkU1MS9OSnRHNTFzWXNha3JI?=
 =?utf-8?B?UC9JZGZBWEtsRzBiOW9uZnpEUUVFVTQvYmJIdjF6cFFsQXVFTXJwVVJJUTgr?=
 =?utf-8?B?NnNMaXRCdlBiekhlU1JBT3doQlJQeHR4TkVhN2VMbW5TZGpzTTBBVXNUa05W?=
 =?utf-8?B?NUpqdWRYbCtVMXRmMmw3NnBXSVlqK0UzeVNuS2oxNG1BZXNwVUMyaVBrNUxT?=
 =?utf-8?B?YVcxQkZwM1BDNDZoOVp0eDlML1RQdm16Z0g0S3dsa2lNWFdtSmc3a0R2aWNa?=
 =?utf-8?B?eHBySi9jZnhESUlxOFhzUmc2RGdLVkQwMUd0TkZzaHg5Tm01SFo3R1Y5dFRF?=
 =?utf-8?B?UkI4enYyM1p0S0todHQyOVZJcGc2MmNvQnJzL1F2Y1ZtcmhFQVlFaEVlZmVB?=
 =?utf-8?B?OEwvcFpjeGc4WnA2VnpIVkR2c3BNMjg3ZG1ZMG1wMVg3WlhuZzRWSjJYbENv?=
 =?utf-8?B?bkZ4dm1UMzlkVlZwbGh4Q3BMU05rbUpSWjhqUnJTT2wrQmc2UDVMNkJZVlpz?=
 =?utf-8?B?d0FMcEVMdEN2UlJGNk9sZEdyTm5ldkVtcktBa1R4M0MxOFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3U3VVZjUXcwS21RZ0IwdExON0lqUDlzTU16NUlwaW5QS2pFeTVlci9iM2NE?=
 =?utf-8?B?Znk1QU9UMlFNbkZVbm9VMWNNelhpSUJZVzNCZU13Zk50WTFFUjJZbHRFNEMv?=
 =?utf-8?B?UnlTMVQwSHBFcndqNkpVNzNJTlZVT3hweDRQenlLT083Vk5odUxaMzVuaFc0?=
 =?utf-8?B?MEF5TXVweHdQSjlJOGRtWWdnbmljZHBQZE1jOUU1bGJHZm9hWFNDU0UwcXJZ?=
 =?utf-8?B?RlZWNWpZV2hCbldnZEpNb0JaeUxkZFZSaUR2eVpmMVlURlp3TEluUlN2RXhm?=
 =?utf-8?B?ODhZQ2lyVW9WZFl2QWc2OGRMVTVEbGFORTZ5OFdRV0tVUndHQTEycXVUS1A1?=
 =?utf-8?B?RGRjRXZqVDNGR3FLVktjeXhBOFBUeGJNWWNqM2VKVVlLaVZSTWtPcG5ONEJW?=
 =?utf-8?B?bWlaQ29qa1diTSswNy9UOGlnbG41NEN4Q2xWbFBkdzZvNklNZVZSZDA4Zjln?=
 =?utf-8?B?TjB3NlFZT0lCREprdGVyRFhSTWQzWGVYVWI4SDlMNnRlZVd0aFhOT2hHY3E3?=
 =?utf-8?B?WGxJbWV0c0IyQ3U1T05iaStId1RvMkorbkxGUkpsZGlHWnM1dy9VRVZwNUE1?=
 =?utf-8?B?MGZ1ZnFlTis5bDRyOXZPLzVQVFEveCtxYWNPb1BMYWx6bFJnY2p2KzE2RzBp?=
 =?utf-8?B?N1FIM3VJc0poNTV0Qms1VFM4SU9CNXhsSFE3MkgrN2xpSzZFL2F1b2lDQ1M0?=
 =?utf-8?B?anJ3QTZodW9ENHd6NnpCVloreDE1b0s4dHJPdy9DK1Zrd3pGNTNPTDA1ZzhV?=
 =?utf-8?B?MmFiclJ4eXFpeGgyczRLRDFic3d0SStiSWpJZEdlaVZ2WWRVYTRFcFVDQkhF?=
 =?utf-8?B?dGd1UnJ6Ull4bVFtNHBZcFplaGY0Mm9PZDkzNW1TUmVsb051RXk4VTNiUEJn?=
 =?utf-8?B?SUk5ektjNDJtTTJwM2l2QXg2QXNwaFhRY1BoNFpXeWw5cnQ3R1dWUnkzTmlT?=
 =?utf-8?B?OTg3WnlEck5WL3E3N20wbENUdzViekFIZ2ZMb3J3YkdidWNHTXFhd1Q5b1dl?=
 =?utf-8?B?bWNFUjlVamVRVXVDQ1U1dkVWVWR5eExKQTRsNnRBOTBQTW1CUmxNc1hHMVVr?=
 =?utf-8?B?SnZsb0MvUUtSeXFNV0RTYU1ORDJyNlNGcXB3c0crMGpuZ1lyc0l0Vlp2MXdD?=
 =?utf-8?B?ZWo4ejJZNVVBRVZnek5QZmFaYXNOZVIyT3FtTmRCT01RMGF1eDRIUmFJdEdL?=
 =?utf-8?B?Q3BjOW9CaXZucDhndTk1Y25XUVIrR3lxZ1pTOTJHbytrdStWcWJJRGREM2Fo?=
 =?utf-8?B?Y3IrUXVyckFmSFJlOG52S2pPaGNWSHpiK1B4b2JEaDA3SUFwYmRXNGtQaTBD?=
 =?utf-8?B?bW5hNisvdFc3Q0JZQmc0UXhELzFwL1NhRkJSWTNTWEwydm92ZFprdVp3NlFJ?=
 =?utf-8?B?YnBSSHJYMUZrZjI0S0lXNzl2V3QwZlM5eFoxRzFHSmZ2RmJpRFFVTit1SjN5?=
 =?utf-8?B?M1EwdThuSmJ2dGF0NUNBdisydnY2WnJja2VLeVFleWI4d2lUSDdjZEhrNHBN?=
 =?utf-8?B?ZFlrN202SHV6Y01WVEJwRVptWFUxRU01OU5wRUxMNjJWclZMUEwxYWlVSDE5?=
 =?utf-8?B?a0k4T1dpWXVWcmFuR0hWdkdhR3dENFYxTW1wY0lOQkNGSVNvUXBDdDgyTzlr?=
 =?utf-8?B?Q3BNYjV2UE11bDFXS0NxTGJJUXhKeUJ2ajNkMFo1YjFtVlljL202aitEK2d6?=
 =?utf-8?B?RXRwS2FYQkdqK0szZWQ2eHMwdHJReUZaSXo5MlJ2ZUFxalNRRWFxcnNjY1Np?=
 =?utf-8?B?UFFVWGJ6MGhwbXVlY2JYZDBFeFVCRnBjTU9tNjZWSkZ4VHk2NUx6VllLTFRP?=
 =?utf-8?B?SVVlN1RqbVNHNHVheXE2a05CNUdFa0h2RHRKTDJWeGlxTEJLK3RySFF1eWNK?=
 =?utf-8?B?aDc1UXVqMCtzTTBMQVFLV3FLMVZiaFc0anN5UDA4TjBDRHZKSjBvSHdLbi9m?=
 =?utf-8?B?YVplT2Y5aDFFS1NGdVduWlFGSSsvYjF5TkQyQzF0NnpBVFNqb2R5bWl0NWF3?=
 =?utf-8?B?TkhIZi9FT1BvRkl3TEpSbS9yTGJEMldZdkRUOUJFRnVuYTBDMnF0YWhKQXQr?=
 =?utf-8?B?Y1BUdUVFQjdlMThrQVZYemhOMDFDYVJqeU05VDNWd3RUeUkwOFNFTEJjWlFG?=
 =?utf-8?Q?Hogsyu9f7lcGilS9P7eHEmSTy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e9e150-4022-443e-e4d4-08dda88701a0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 01:26:36.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxiixlAgfSOc/PTAg2swtvAS8NNKngceVu3M+L0Cyxz1dpMR82pTATOB/EtGl6N9Fdmh07Vx7CPpcTWz+DV5GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166



On 11/6/25 04:19, Jason Gunthorpe wrote:
> On Tue, Jun 10, 2025 at 05:05:21PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 4/6/25 22:36, Jason Gunthorpe wrote:
>>> On Wed, Jun 04, 2025 at 01:58:55PM +0800, Xu Yilun wrote:
>>>
>>>> But the p2p case may impact AMD, AMD have legacy IOMMUPT on its secure
>>>> DMA path. And if you invalidate MMIO (in turn unmaps IOMMUPT) when
>>>> bound, may trigger HW protection mechanism against DMA silent drop.
>>>
>>> As I understand AMD it sort of has a single translation and relies on
>>> its RMP for security.
>>
>> Well, two levels with the first page table living in the guest
>> memory + RMP for the second page table in the host memory.
> 
> Yes, 'level' is a bit unclear here.. Intel and ARM have four levels.
> 
>   T=0 S2 lives in hypervisor memory
>   T=1 S2 lives in TSM memory (S-EPT)
>   T=0 S1 lives in guest shared memory
>   T=1 S1 lives in guest private memory
> 
> So compared to AMD both the RMP equivalent and the secure S2 live in
> TSM memory and provide protection..
> 
> I've forgotten exactly how AMD manages to secure the IOMMU S2 in
> hypervisor memory, but it seemed unique to AMD.

S2 lives in the host memory, unencrypted, same table can work for trusted and untrusted devices. But S2 lookup results are then checked against RMP, and this is unique to AMD.

> 
>>>> "If a bound TDI sends a request to the root complex, and the IOMMU detects a fault caused by host
>>>> configuration, the root complex fences the ASID from all further I/O to or from that guest. A host
>>>> fault is either a host page table fault or an RMP check violation. ASID fencing means that the
>>>> IOMMU blocks all further I/O from the root complex to the guest that the TDI was bound, and the
>>>> root complex blocks all MMIO accesses by the guest. When a guest writes to MMIO, the write is
>>>> silently dropped. When a guest reads from MMIO, the guest reads 1s."
>>>
>>> Sounds to me like the guest has to do things properly or the guest
>>> gets itself killed. I wonder how feasible this really is..
>>
>> What does look especially worrying? So far the process has been
>> pretty straightforward.
> 
> I think it makes debugging guest bugs hard if the guest explodes on an
> errant DMA.

Well, my machine prints IOMMU RMP event in the host's dmesg, the guest does not receive the write, the device driver barfs timeouts or errors, but nothing crashes.

> 
> Jason

-- 
Alexey


