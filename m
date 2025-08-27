Return-Path: <linux-pci+bounces-34951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076F6B38F5B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 01:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B763B3B2D55
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 23:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C4821147B;
	Wed, 27 Aug 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z7KB/knP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5801DB127
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338439; cv=fail; b=DP9f9WngojrYk/FMUCZR0LReunXcZ2v56zAetvlRBKe+C0B8FqRhxVIoivJgoJe34Djd86RkYeA9KcrKlNxBQfKDk5ti44xi1zEjA9Fh3WBrMVbxaT5dzqWn+GVZKrmOh5aA7zVXd02lepxC0sU38asBmMNVZ5cWZ+/UAAHx+5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338439; c=relaxed/simple;
	bh=R9re1MGrWbmfZV9JNBVxowv+KE3ubwSfSUbcBCkqBok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UGWzFq8TWkubX4GoVozJjckhuGjPVbGbHuE8zQb3NIYjGP7UHysmsT2KCHiHlOX5CX/XRIaQapLr1crzNGhS0cX49sslqFSw5JWDTQz6tVRRGwDqMuvMo7BjCg7Kp83A/DVDyHGvDa3SEKdItnSMCcHwrqQXUjFnI38qEaUoXmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z7KB/knP; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=et4PeReCpeq4hJStxYfiDRWRoZqpA9F4K7rsFDOgsr3hoSSaF+oEO08Iw1OrkcM6iroiWaq7qUGMx58yBDSAhfE35aldBrmO/M4jmSdasC/pg4jm6bYFKyRXp6bXIRCU9wOCARf3gf5zRDDjfjmBBlrLh7GvZiTQpl3NgcWLRYtqUpQpIQZm15/4BA0iWnVA/qNZ0aCYXDeHHLXN44dAqupQq9uEn/GuoB3LxfeHfUTEHu35O5w6bdbH5sqqFIAgYm72OowHMDM+JabPWAH/RQehy0i40p9ebQgDNZUrJcFvMb3ce9yS1TcQnAFYb4qrwX0OvNW1AC0VHsPBb5cR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIn9ziB0haPDDv2UrrIOQFgW/PGc4fU3xzLMOe/Q9Ag=;
 b=ipqks45STkX1ta5B2Or+BW9WhGs5OaBzX9O/PEIkSkmC6NLLo9to7h7QyjvdR2IBJZuJatZvwwJfYBsDUBE5+iLfKgUMniWkR/PE3Usk5q/EETOsCf1Hv9zXBmabBMKMiLEjpIEz8fW+VVdK6t4jykTwKVXFb9CtlkbeikJ01Jb+969TWkJHY1fN/+XGmj/A1HmUlfCBUcwAkJbvG+ek/5sknJ0cheyYVc/uumgEMNUzy5PzbMHCAoqMnbQi+i0cOiy9jUN0Gsgn6HV3vO2aEoq1tUJEJCE7+QVWSj+k7QHfcSgK1JVAmyvMvsApW+Onf4rcMZKd4dOQjaFXHBEnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIn9ziB0haPDDv2UrrIOQFgW/PGc4fU3xzLMOe/Q9Ag=;
 b=z7KB/knPI5Pm6CxKm3/avjAWiEYx/AiYWu/oBvYkjr0N8lr0rbx1/odjfkTerTE33jxVJB5MoOH+H09/C9VkW2t89f2IwX+lOj2CEA2XllwR15Drq1s3EEX3jdyctIXJIZYCNHrYOomd74H+9481pBKrim68fs9YM681hKYtfgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Wed, 27 Aug 2025 23:47:13 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Wed, 27 Aug 2025
 23:47:12 +0000
Message-ID: <cdb17791-d21f-4d83-ac58-982d83de310a@amd.com>
Date: Thu, 28 Aug 2025 09:47:07 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6/7] samples/devsec: Introduce a "Device Security TSM"
 sample driver
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com,
 aneesh.kumar@kernel.org
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-7-dan.j.williams@intel.com>
 <20250827123924.GA2186489@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250827123924.GA2186489@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0125.ausprd01.prod.outlook.com
 (2603:10c6:10:5::17) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0283cc-c382-47b0-7327-08dde5c40b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnJ2Z0JpQ3pWR1NmRmpyMzRCVUdxbXlRZEdrcDVxbkM4OUF5bnhqc1A0N0hP?=
 =?utf-8?B?anN3Q01RRzFkYjQwK0NNanhXcm54eWRqSU82YVZ4UzRRTndOc3R2Vk5pWGx1?=
 =?utf-8?B?aVF1UFRnRGcvdFR5NjVYaHhnQkFwZzMwRkhLZ0t0WHFzT01OMmNNOTJ3RGlE?=
 =?utf-8?B?RkJEcWhiUjNwQmtjWldlWjhPOXNEK1dQNnczQnpJVlc0S3FtN05zakM1STRO?=
 =?utf-8?B?S0x6ZUtuN1JpZ0N6WUJHVVU3ejJmTDhxM1RXNHNrWjBwamRIYmdEcUlRVzl1?=
 =?utf-8?B?ODJKQjl6Zmw1OGN3VEJiUEt2RkNtRU9rOW5BOFdidzdzcGorcnhkNnpGL2ZH?=
 =?utf-8?B?aTJQc0tha1FoUzNydWxTbXZPZGJWMCtyRm5paW4wUWJ6MkNZMjNFajdkMlpH?=
 =?utf-8?B?cTZDL2ZIL3ZXa0F3TzRwZ3dWS3V0eU1lZGxZYTNQRURhVXJKUUJTSktWRmUy?=
 =?utf-8?B?WXFYVGErWnFFczBaQTdIa3h5ZmVaTTRjSm1xeXgzV2xKa1RCN0hsZWZnZndy?=
 =?utf-8?B?L3BMYitnNGdueVBIbm1ManNyR2F1clVGdzVPTVVTdFpXckRUS1YyWHZBb0Vs?=
 =?utf-8?B?Q3B2UlBQbVBpaCtjbTZFYWpVaGp0NkZ6MTFFNGIwNTdGN01ITE9pcjljSFNi?=
 =?utf-8?B?dzBITnhvU05Ob09wYXF4ZktIenMxVmc3UUxuMEx0aG4rS0Z2M3ovd1UrN2Fu?=
 =?utf-8?B?Z0N0eXRsZTBadThrbmZwc1dqbUxsUGN6ZENUNkhIZzZESVpvZ0wzQk4waWRo?=
 =?utf-8?B?K2dTSnVTdVNKTUF0enQ2NUNOdk14aEx6MWlTRlMzTCtGNjVhY0JGQTFFQ1Zs?=
 =?utf-8?B?d2M3WVR1OSttUzR0UjNXbDNObEd0MXpST1Q5Y2dOQzBnUTBhWm9KSEJnNmw0?=
 =?utf-8?B?OExLdWdKK2JwSDRnY2t0QWhTYXdCV3ROOGc4MC9NeGg5NW5kSnZMM0xxZ3g1?=
 =?utf-8?B?bzA1ZEJScXE4SGFtYWhGSnpJZnY4TEpTSUtQaWpuUUhueEcxRUdVWmplZi9C?=
 =?utf-8?B?U3lyUGtUcWZ6OEt1aE01YzMvOVZ5dzNwWmdnUldWTnJ6T0tYcUVkVUhybjhx?=
 =?utf-8?B?ZlRZKzUzVkJSWHNONzFVTkw1YWlCSE1Ua2dwa0N3NVhVTjEvNyt2MnpTWGdS?=
 =?utf-8?B?QXJiY2dXZDFqTHNMdS9vbHlmakU5aVQzMDM1UFhrMUF0TjQ0MmdxRHVmMzBP?=
 =?utf-8?B?aVJjNng1R0NHVEN0NWZiOFhUWS84dE95OUJxaWloeGh4VDJCOFBKUTlqYXda?=
 =?utf-8?B?bDgxL3dqNm54VkQrUndIcThkU0RmM01XMU5Hcm5tckFQMnd0TUwwdUIySTFm?=
 =?utf-8?B?RVNyUzBwOVl2Rm0rck5ZWUpaa1p4YStxYURreHlyRUxTU0VkdWdjRWEyU25m?=
 =?utf-8?B?Q0FaejRCVXplY0JiK0ZXaGVPUDFsYlV5VlFTdVRaQW5uck50blYwbktPK09Z?=
 =?utf-8?B?a1RseVFKak9saEM1NnBDdHdFVU9hemxacmJvN2E0Y0dMWTR3bVp1Z1JWRTZM?=
 =?utf-8?B?THNLMGhZYjYvL1VHNjcvSy91empjWVU0UGIvQUoxaWZzM2lKLzMrdURnQzJ5?=
 =?utf-8?B?OTZubVBSN3dXMlRRN2pPYmdhTFMrNG0vNVdYR0RNenVteG81emxpZkxvcTky?=
 =?utf-8?B?b1I1M29lQU5WRDRUbDZ5N0MxelBqU3F0SHNranNDTlFZRGZwQXhaVEhWZmRY?=
 =?utf-8?B?QXNFMmZjUTRhNE5rK3ZBanFzR0tJWU4rWGxtWlF3RENmTkp6NlEvQ2psdmpw?=
 =?utf-8?B?aGRGeHVwSDBtZmJvS2t1cnlUZS9NRzJQckVUMzJHUmNnS1Zhb3UwNGlMQTFH?=
 =?utf-8?B?NElkbUorYVF0MHRPMVg0bFJJVVVJL1MwWDlmWVplMVBOb2VRbzY1Zk9FK0Jv?=
 =?utf-8?B?cDlmUUpIUHNYOTdBSCtYU2F4UnJiVHA0UjhFTThlQmoxMnJuejJBSEx3N0dO?=
 =?utf-8?Q?6MRDNfFETKM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFJya0ZGYytoTDk3Y3Ixbi9sQkN3NW9VaE5HL0FkK1RmL09ubXF6eFdJSS9D?=
 =?utf-8?B?TjVWVFgrekJqckltdGR6TFFrSjFLVHRUZnZBRFJVWG5xSkR2Zm1lNnNWamp0?=
 =?utf-8?B?NHhQSVNYZUYyNWJXWUJxT0JDTDZUMGd6bUdrUXl1bi9DdUxheEdzUm9tVjhq?=
 =?utf-8?B?RmFPeUsyUi9MbytsSlJOOGlnVHpaNUtGNzZMMW9WRGZ4eFZCU1RBcFpIYlNk?=
 =?utf-8?B?aVVhN1U3YUprK2IzeHF2ZlE5YW9na3h2S0VMbzNFR2tYN3k5Q2luNUZPRkJw?=
 =?utf-8?B?VHNZRGl1bmVCNmNXejdzN05CVU95VDl5OUgxUm9xT2xVN0s3Z3Z3Qm1CL25n?=
 =?utf-8?B?a1JMZ1JXZVdWYUJwenE0UFMyZW9JMm9tQm96MVAvbm16VXg2bEhlQVNYUlVx?=
 =?utf-8?B?UVRRR0c4Q2owUTd1eUdWS1pYaEsxVU9LdFBqcnhQdTV0Yjl2bkE4L0J6anlV?=
 =?utf-8?B?VURLVjYzMXJEQkJ2ZWZFVU80TGhHOFo4T0RkSDJSSGdnNVcrNkpkNnJWbHhB?=
 =?utf-8?B?MVJ4TDVvUXNXcFVReWlFVEx6RUtYbjQ1U2ZpcXN6NkhrQ0ZkSFJ2QjNUQWhV?=
 =?utf-8?B?N2hsVjFhMGFhckgrVUQwVjE4WFlvb290VTIxNnpPU0ZCNHp5UTFCVGQ0NkF0?=
 =?utf-8?B?eDlxNUhQNjh1dDhhaHJldk4rRHhoSGk1K01ISkxMUE9lYk1tMm1PQm5ORlUz?=
 =?utf-8?B?UERqNytRbWVHazVFZEZ3NlFhUVo2em5XV1BRMWtYYytTbVlTZlllU2VOVzZh?=
 =?utf-8?B?MEJVV0RVVjNtYXpqSUtMSW83Rml3eGlYdTk1Um1NU21zdVd6RnM1UTR5VEk1?=
 =?utf-8?B?aXBQcVcvMHBSR2JCcFNQSndNaTZCejBKQlZjUG16MjhwYlZBb1MrM0cwNVhV?=
 =?utf-8?B?UGFRTXMvTk9xbWoyUkxGa0swWThIaGlvQVpVVlQvTDIvNGVzSHliLzJQRDFU?=
 =?utf-8?B?Y0tWRis5UVRPUk40dmE1dGsxYjQ5dXlKRlNxdHVjYXU0UkxFM3djdnJTWlRh?=
 =?utf-8?B?U1dTbGhGVWJkMS9neURqZ2wrZ1hyT2JJbXhkcGVKMUhRLzF4NDI1QUZqV1kv?=
 =?utf-8?B?S1ZDQUk4RCtyRUJGOGp4elZnUkEwODhlWEJNeXZUQ0Y4QXZWbWJGU0xNeFJV?=
 =?utf-8?B?bWZXRDJBbjBkWmVLU2tsd2JQYkczb2RiaVVaQ0NHaXFiYlBtN0VNc0VMN1k4?=
 =?utf-8?B?aDl3dkEzM3h3S0xDMlVXSk0xd28zVFVqaXJFb0p0Umh0SmlBMTRFRjh5bldQ?=
 =?utf-8?B?YW9TV3JZMElIcG0zN1NYdlIraDVjR3pCVHgvb2RWY3ExV1ZPY04xNnE2Vncy?=
 =?utf-8?B?Y2FQcGN5NjAyZE4ydldPdjF5d28vOEtXcE5NSFR1WHFzYzRwQ2RnRzZqbW1M?=
 =?utf-8?B?Ty84bVNEM2dEZEhhaUcvbVVoUUdRdVZyempuRE15Z0h4ajVES1JPU1A5RkNY?=
 =?utf-8?B?dzhUTEt4dW95eldxbWFMSUl1MHdZNjkrNTM3NFVDYUNvNGhZdmFQN2lFZ1dT?=
 =?utf-8?B?K3Z2czhyTncvMEhIdSt4azBBaktiZUw5a1V6NXRSQVU3anJucXNtcEdERjVr?=
 =?utf-8?B?eE05OCtsVkMzTUVIeUZoU2FVam00L3ozNzE5QWU1ZXdqL2p3V2JENUFrOVVJ?=
 =?utf-8?B?b2Z2Wk1uYmRlVlgvSTBvM2JOUDBGUzI0VzZLcEhsTUtMVXVLL1NPOUgzeUJ0?=
 =?utf-8?B?cUdpLzBvOTFobTZCOGVJU0JwUGVOSkZjYTdwYldsQVlvRUtXaXdldlJIU1ZN?=
 =?utf-8?B?bThueXA1WldDSGpPZTl6NVRIZ3RFUW91WVB3NG56QW1sZGRSaGVWSE9yTS9v?=
 =?utf-8?B?VG9pU0JWTjVHZ3ZCU01xL0lCSyttRGptR0VCOThlOThPTHp3bktwMEpwREw0?=
 =?utf-8?B?Y1Fwb2lEcjl0TVlsejB6Q0FmL0N0aXdOMmlCZ0g0UjV4QWZQdXZhM0Y5bFNy?=
 =?utf-8?B?UFpqT0FoaGNoejliK3M0ZGs4TzA0MVN6K2JCNHNpOVh0aUFUMUpKUDB6K0o2?=
 =?utf-8?B?d09wdFAwZXlKalVGNzFrbDlVS283QURPTjYrck1zZjlZWVpQdUNmQXMrZ1VU?=
 =?utf-8?B?YzRvaHA1WXJkL3FybFJJejlmUzMrWmZQcFgwczVIU0UzZXlXalFOSkZmc3V3?=
 =?utf-8?Q?SnA+dpsxCggUsyTqyyg8VdaRL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0283cc-c382-47b0-7327-08dde5c40b5a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 23:47:12.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBDG3Zp/5C5VBV9X6jMu9clIe72+v8cRk0a7I5sN+zy62cMjUiwslITjsk76yOtItXPmq4gszIchWvfuqqFAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119



On 27/8/25 22:39, Jason Gunthorpe wrote:
> On Tue, Aug 26, 2025 at 08:52:58PM -0700, Dan Williams wrote:
>> +static int devsec_pci_probe(struct pci_dev *pdev,
>> +			    const struct pci_device_id *id)
>> +{
>> +	void __iomem *base;
>> +	int rc;
>> +
>> +	rc = pcim_enable_device(pdev);
>> +	if (rc)
>> +		return dev_err_probe(&pdev->dev, rc, "enable failed\n");
>> +
>> +	base = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
>> +	if (IS_ERR(base))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
>> +				     "iomap failed\n");
>> +
>> +	rc = device_cc_probe(&pdev->dev);
>> +	if (rc)
>> +		return rc;
> 
> I really don't understand what the proposal is here?
> 
> device_cc_probe() doesn't save anything, doesn't this just get into an
> endless loop of EPROBE_DEFER? Usually the kernel will retry these
> things during booting?
> 
> How does userspace accept through the sysfs retrigger probing?
> 
> As we discussed in the prior chain we need to have a policy decision
> before auto-binding drivers at all in a CC environment, I don't see
> that in the code though the cover letter talked about it??
> 
> How does the kernel/userspace tell the difference between drivers that
> want this early binding and those that don't?
> 
> Can you write out the whole flow from a userspace perspective in one
> of the commit messages?
> 
> This also disables BME, we talked about that a lot, the commit
> messages didn't seem to describe what solution was settled on here?

My current flow is:
- blacklist the driver,
- let the userspace "lock", attest, then "accept" via sysfs,
- modprove the device driver as usual - at this point DMA is enabled (device::force_encrypted_dma=1) and MMIOs are "validated" (in AMD's SNP words);
- the device driver will enable BME, which is allowed to go from 0 to 1 in the RUN state (my test device did not allow it in early days, now fixed);
- the device driver will map MMIO as usual and iomap() will do the right thing as it knows by now if the region is encrypted.

Thanks,



> 
> Jason

-- 
Alexey


