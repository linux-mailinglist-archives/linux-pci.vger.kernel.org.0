Return-Path: <linux-pci+bounces-29282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AECAD2EB8
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 09:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C3B1713D4
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80C21B8F8;
	Tue, 10 Jun 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c0ZzaLXn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893027FB09
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540713; cv=fail; b=oWhWBBW5SpWD1fPWuo4mPuKcqKR8TFdKMfi1MW6V0d9klB3Ydt7+b3FT6WbghHb7Yrl+iPISSiz1BZEW4fL2yIjfAUO461Gg7PoCP84v1/Z2O9lUH6z3NTZEUm1bQM8kTwQtAQs7UI2BSFWTJ7+4drCioWwhUtZfMnIab84SObU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540713; c=relaxed/simple;
	bh=vJPMGR6aiyVhDsHPLYg2i+EYqH3Qe941Hvq2sM3mpoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UQe6/xN9yRsMD+Ykyo7N0KKoHy60hrnFKzTR+BGtH9i6cZAp8IKFMrdNLBLzrIjeJwYc2cgrOifOUdwsNiqPCLphKcLXt+JlfQlC6vXdi0Ag/Y4IX1LRjEU8JZGILfVq5kXQd6oWyof3U13qNJVR1zjN7scXpRiB0dandh6wtZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c0ZzaLXn; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETBNOYpbD/LgrFWfCln1kAgOCiYpviAsigCu+7zj/VLznklR3L+AG1/f1Qt4+xAQr42syeXmz9wnWWV0O0hSKUfQIDfiHMdpsqdVZaiGN+GtDHSMobeORmWGe3EP62ARqSlV2prEp5Url6VezhHX/pVqOSfVBIpjAzJV9l/ONKwaJxLVgWnfNM/YFdHK6OxRT8zqM9ZBqEucFUn0y45PZL585CAsAmE8xaytWzpFEp0lnzXD0piBRQWuPEGOjJ7K+wWtONpI4RtQc8T+fI6iC2JR4FvxdTV6fMrODbnkfCukVy+xoYvh6Yd3cNPr5GDG56DHTrs89gYcjGHBisixMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNnDc5APFkIgTCUxeFqMxuEGb+1cbV4nz70fxTN9LRI=;
 b=EJSRKU1VUb+81ZqdCHoSKkayoa6zh0TQklWYiiILLF3OVaO0+Vve8ANZOSmYABgn18fbMJ13Q44a45lomuwsCa587vRmH3Dt8whS6AOksG8nA3+4+pj4J6pPyT5A2HaxCyawtktdTZQMcftMp+nW2FEKHaS2QzuB+RYXRNG2DXoUmFQPTumq8iqpIOO1saePrIvq4BHByYBJbb2IbDHrpF47Hjr1veKkcK/xwHcqbor8TD0RakaWkvPl4U15q4N0+aeDTKLU6VF+Hyfoe4f4B/BBtB7/oOhjVEibKig/5LtsyOQZZ3qIsquL+jX+ozkMrqyobpkCP5gPD9YYe8NAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNnDc5APFkIgTCUxeFqMxuEGb+1cbV4nz70fxTN9LRI=;
 b=c0ZzaLXnv1+ZwUwtmnTjkt8ZnEc0MvC+oz1jXqPaDlnm0dh7DYAqWiwop1LZUKboWD/4ine7LZWNcBYisZJE7iOqvOV5UlTeaiXrNeCwWSJYAjdiP+jKgSnlmUCfLZ+7BpxB+TcbE5UTyX4w0tVlrlEr8qj3U47uiCxqhkeEzaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Tue, 10 Jun
 2025 07:31:48 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 07:31:48 +0000
Message-ID: <bccd4693-775f-401d-a2fc-237510066366@amd.com>
Date: Tue, 10 Jun 2025 17:31:41 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
To: Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 suzuki.poulose@arm.com, sameo@rivosinc.com, zhiw@nvidia.com
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050> <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050> <yq5ao6v5ju6p.fsf@kernel.org>
 <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050> <20250603121456.GF376789@nvidia.com>
 <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0003.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 82002696-b86b-4bc7-5807-08dda7f0dbf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTZZZlpMbnZVNEFhcGt1bXgvbWFUTnN4VlRhVFdqM2cyMEd3UmdudXJ4Uk12?=
 =?utf-8?B?bGNhLythYWxUQ0xjT29PUE0xbmJ3YXJBR1UvY3FVbDVoMnR0TEpiQlViVkNT?=
 =?utf-8?B?QkZrTHh0NXNRK2hpMmZMTmZDYkRsTG5GTnVGQkQxaGNGeEZsVHdjZ3JuTkY4?=
 =?utf-8?B?ekpUK1FBalhxQktjeGVZRFVNSnRualJzTnhydjB6VnRRQzJ2MHROSUMzeHZp?=
 =?utf-8?B?eWROS1dEaThSMU5DSldvRG1ab0RrbUM5UXRnalJlbk80Zk1sSUNFdGJsQkdr?=
 =?utf-8?B?OHRXc05PcnlrQzlmVDBtdXJqMWc3cGJySCt3dWNwTHNxbXRvQys2YkpwbXNC?=
 =?utf-8?B?dE4zd3RDTk14RDdrR3gxWkRwUTduc0loaWY4bXQyVzJzT1RVTzlsMHRzamZO?=
 =?utf-8?B?cUpWYmhpMzMyVFJnSzEwN3Biek5RT3J4MHFKUTNFWDJ6cWtUZnl6TEdmbjAv?=
 =?utf-8?B?OTlUczBEKzU0WTB2enZYbmthd1o3OEpySWdTSDdiNUI2NEhGMDgzU2E0MXNj?=
 =?utf-8?B?bWkreXNCczFETXJhZkptbFYzc3p6aE41azFwSWRmZWZqLzJQSFlxaktsZUdP?=
 =?utf-8?B?dU5SbG5PbFZZdzRiZFF0S3RJUnNSaUplRzZZU0xYZlJzNHJXM1NhWkVVLzVn?=
 =?utf-8?B?RG83V2NQVnVucTlFbVErZjRHRUdGbGxaV0RUdno5RDczNEhTd0JQN0FNU0RH?=
 =?utf-8?B?Y2xJcnhLc01USVBCd3VKK2JjU3RaaW5TYU5xd2ZYc3JheDVzaG81V1hrS3R3?=
 =?utf-8?B?MnhKUjA1bXBFUzEzVml6M1RZdXJHZnowRVc4QXgyNkU2eldHMFVxTVZRR3VU?=
 =?utf-8?B?dE9XekJHOHNOTFl2M1hjR3dRbERYU1NuSGk4L1dlR21Od1E2OTRkcHhmY0JB?=
 =?utf-8?B?Z1MyODN3MG5sZ0ppMW9wSkxXN3VGeUtXSUpQVGp3ODFKWTY2cW03SVJ6TlZ1?=
 =?utf-8?B?Vy9OU21lR1hSU3BwWnpMQldwbG8yRFNFd1YveE5EdDBmLzJyWldLUmgrenJa?=
 =?utf-8?B?ejQ3c2FadGlmZVZsa2ZhT0ZzNnZScTg5dm5VWEVwWnlydUJtVk9lUlh4UlYx?=
 =?utf-8?B?T2xMWFVSQ0xFNk5kRjM0bTE4c0hHaUJ2UGcwUFNYUjRWOSt3TmQxZDROM1ZE?=
 =?utf-8?B?MGcwcmRLRnJBamdDaWEwVHNlclhhblRmQzNVQy8rbnd1clNXcVdXSG9zOXE0?=
 =?utf-8?B?TUlSVnk0SlNLRVAvM0RiS3ZhUld2a0VoVTRjOFdKT1VCMVJjRGVGNHFiNGt3?=
 =?utf-8?B?UHlwTHhTSmdzL05WZnM4S1lqbStmYkdJTUZpeEh4UEVrRE90RUt1aVVFWnBz?=
 =?utf-8?B?bk1SbGdKbkdmRDhlUVl5YU51RVJSTjR0MUYvRzBKOEl0YU4xbHFRNFpXempk?=
 =?utf-8?B?OTR4dWs0SWw1VTU3bjU0alBtc3lwNlllZm02VjJwdHVHWGdBZHZmK0djTHpq?=
 =?utf-8?B?djBlZTNkT1FSWUl4UkgzMm5VUUJDQ0V5eUZRdHRycUNpMU9CL0E0OTNQemlL?=
 =?utf-8?B?eWVEN2JYdzNZVTUrREI1b3lYOWZ2eXowM2hySjFQc1hKOFJSTi9uUWgvdDFT?=
 =?utf-8?B?bXJ6azhmL05FYnZFYnZ2aFVKL012NGs3N0pHbGQvZDFmQ0cvTUNNOUx0MDdq?=
 =?utf-8?B?K1Z4UlFmRkl3UU5LQ2dRTVUrVXJTWkkxSjhHUFNIRjhXTzN3T1RDMmJ6TUhZ?=
 =?utf-8?B?bUxKT3FGbytlR1FSazdOWWVJek0zVjZNekcrMXJVbjZBMjlHYnhRa1NmNmx3?=
 =?utf-8?B?ZUZaNUZZOUxOL0ZnbnIzanhWZW9QSXpCSnd6UXJqY1MyeDFxY2pyekRwQWlM?=
 =?utf-8?B?eTRQMkphMXU4ZlU4N3BlQitud3IycnVhRDJOOVRUc3pheEdDQXhld0V6a3JL?=
 =?utf-8?B?N2lkdCtSMFdEb2xRRDRwdkRrQ2ZYOW5MWTBEaER1ZngxOEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnRHalhqR2s2TUgrZHUrYk8rWUU4bGNSL0tuV2xLb3hKcHNvWDBES3FNdWNy?=
 =?utf-8?B?ZDh2QTVPVFd6K2JWcjM3MmtSdWhnRlNnY1lCbzNQWXkxNzNqb0FybzdsR2Zo?=
 =?utf-8?B?aXhNYVdvU0pEczM1Y1oySmV2ZnhQd1BCcGhhS1hNRWI5V0VGTE1SYWplOWV2?=
 =?utf-8?B?TXQ2aEpKQks4UDN1VEhUSVduT3FnSHo3M0lHZVVvejlhVTltWUVFOS9PVkhQ?=
 =?utf-8?B?SDdSbUpoZzZQODhvWHJKTVB4c0xyc1dyVEFsWXBoMGh1K3k3K0dOTVJ4OHhF?=
 =?utf-8?B?VGt3a29aN0U0VlZ3WllBOGtjUzBJMFV5NDhNckJBVHZjWTY4cEMrdkJxMHdH?=
 =?utf-8?B?cFpDV0VvMVczb2hkRWFYbm9TQkc4S3ZjcWdpb1Fhd1c1SVdOQ01YcXFPZzE4?=
 =?utf-8?B?RnVJSVovZUdrUjhtMC9MVG1TTDBTY3R4RkR2WmFJQS9McEs1VUhnUG8zQUNJ?=
 =?utf-8?B?QkRLQjFzOGt0WmJtb3lBV2tuY2FEbitsNTNyVndDanJNM09kTlpPeUJ3NXpn?=
 =?utf-8?B?eDYwQ0tWS2VucGk3czJvS0VtUDlac2NDNTNodmdWK2JGd0pQQWxENi9TU0o5?=
 =?utf-8?B?Y2FXMzhENldnYlpYclZ5clhEczlNeXZMQ3ovRVN3L0U1MzNtV0RzaTBNbVhY?=
 =?utf-8?B?dm84TGoxZnVQMG8yTyswcytYaEsxTTJPYk9kbmNmaGpObUZPVkZubkpLRm1q?=
 =?utf-8?B?aHEzTUFkeGlQK3FYeVE5bmdNVEs5NGxYVFI4TVozK3IrS21sVFV5c2xlNXZF?=
 =?utf-8?B?bnRpdlJBK2RFc1QrUllBZ1pLNXlLN3FxS2V1OFFBU01lcmJGM2tpSGRJUFYy?=
 =?utf-8?B?UmQ2cjVmcXE2dS9rWWVpN0hvaVZodUx2WGpDdUdpU1l0NG8yU0hIQSsyMFU2?=
 =?utf-8?B?VHU5c1M1aFNHWjBtWW1TVWk3MXl2ZzNBUkkvRjZLeGxKZlQyM0dxOUpWZVMw?=
 =?utf-8?B?aERQQitIOWsvTklWc2JJS1hPbVVxQ2hUWnIzNEZOQnhSbTJ5UzBoeXFGbkty?=
 =?utf-8?B?OXdMN0cydHJHVU1wazBXV01sNDgvbGpwY2ZQSFJBUjlLQlpRT1lhQWl3enVV?=
 =?utf-8?B?azRKQUE2TEdkYlBaZWtwdkRYTUJsK2NnSkp4MllRR0JhWnNPUUhCUmdjUWs0?=
 =?utf-8?B?azhnc3lWY0lOSk5oSndLczJyVTNXQnk0L0g4eWVwMnlERDR4YUl0VEhWYkxw?=
 =?utf-8?B?Z0h4NzluakpWcUJ3L085blFBVVROYWRDUlpyeWJPMGNLYlovM2JodzVuekNT?=
 =?utf-8?B?MkllUWZqaWowdVBWWE51dUx2eklTVGNucTBISFNtT0xiL1E3a1YzNm0veVF0?=
 =?utf-8?B?Ujg4ZGcvRkRxSWVGU1RXYmNJUy8xbHVUQ0taYm84S2dzL2d4elNvS0JpUGJx?=
 =?utf-8?B?dXNMZGxCc2QreFNZZjJ4TFlsNHhJUyt5VzI1WElWQ3pMMUpLVTZMdlNoWGJu?=
 =?utf-8?B?OStmNjBLQjNmeVdWRFR3ZTJ2TkVLTk1ibnQ4N0laZ1I4THQ1SWM2MmJ5b2Rr?=
 =?utf-8?B?c2NPWVpZMXlBL3l3a0cxWkphR3FnMGE1UGtMVnpwbkZMMmVUS2xLeHNaOFV0?=
 =?utf-8?B?bjBoZU1iWkhIc3pPN0xIL0crQWs3MFh0czNqZzdpZHJ5azZXeFc0V1pZRjdr?=
 =?utf-8?B?RWxiWVlDaDFSNURtYzNwbWdhQnlzcDZqb3N4RGRuME1JcnpGcEtGaUl0WnZG?=
 =?utf-8?B?NFpiMVU4TmJYcFBrVnZ5NGoxbVZPQ0tmMEtLZ2JaOUQzKzVONTZxajlwdVNs?=
 =?utf-8?B?ODNxUGU2TW1SZHdQbk84Z1hXQTJYZlAxTDYwWFhtWEora0cvWmhoblZRYTJR?=
 =?utf-8?B?QWJSdEpOZkM4VWZ0RFNETkxIS2R0M3JkTGo5VTZseUR6enYvamcrTmdEaVc5?=
 =?utf-8?B?bGg1YVJlMDFxaWRmRVVSbUJHVFFvV1E4RWRaaWVINU5ENkN1cWx0VGVuclB0?=
 =?utf-8?B?ODZ1RndGNE5DUFBHSDJEUXg2bDBFcWMxQ2Y5czB1cmF2VHFZOWVuZmU5OGts?=
 =?utf-8?B?TlQ3Y1I3RUZPcHc2cTQ5ZmNFMVd6bWxEam56WEJHUktGQWpMN284YmFXb29p?=
 =?utf-8?B?NmlEWWN5bWpuWVhncEZOL1plcTc2L0VjSkp6NHhmdnBYMFBiUW5EZ01aY2Zs?=
 =?utf-8?Q?Ybi4T3dAAC5o/XXMbJHTXeDh0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82002696-b86b-4bc7-5807-08dda7f0dbf6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:31:48.4080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEICkiZMvQwLJEcL4Uf4RwL76WtoRDLjgq0nH3t/hGM4yGUye1fC/A8bipSNZTzAMZuH6818+iI/1h+xlBNW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828



On 4/6/25 15:31, Xu Yilun wrote:
> On Tue, Jun 03, 2025 at 09:14:56AM -0300, Jason Gunthorpe wrote:
>> On Tue, Jun 03, 2025 at 06:50:13PM +0800, Xu Yilun wrote:
>>
>>> I see. But I'm not sure if it can be a better story than ioctl(VFIO_TSM_BIND).
>>> You want VFIO unaware of TSM bind, e.g. try to hide pci_request/release_region(),
>>> but make VFIO aware of TSM unbind, which seems odd ...
>>
>> request_region does not need to be done dynamically. It should be done
>> once when the VFIO cdev is opened. If you need some new ioctl to put
>> VFIO in a CC compatible mode then it should do all this stuff once. It
>> doesn't need to be dynamic.
> 
> But the unbind needs to be dynamic.
> 
>>
>> I think all you want is to trigger VFIO to invalidate its MMIOs when
>> bind/unbind happens.
> 
> Trigger VFIO to passively invalidate MMIOs during unbind is a TDX
> specific requirement.
> 
> 
> Another more general requirement is, VFIO needs to trigger unbind when
> VFIO wants to actively invalidate MMIOs. e.g. before VFIO resets device.
> That is the dynamic unbind thing.
> 
> The reason is the secure DMA silent drop issue.  Intel, and seems
> AMD (Alexey please confirm) both implemented some policy in FW/HW to block
> this issue. But the consequences are fatal to OS, so better we avoid
> this.

Why does it have to be fatal to any OS? A device which suddenly stops working is not something unheard of, not a good reason to kill an OS. Blocking MMIO or DMA seems like an adequate response.


> [1]: https://lore.kernel.org/all/aDnXxk46kwrOcl0i@yilunxu-OptiPlex-7050/
> 
> Thanks,
> Yilun
> 
>>
>> Jason

-- 
Alexey


