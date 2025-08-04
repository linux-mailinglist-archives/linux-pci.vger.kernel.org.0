Return-Path: <linux-pci+bounces-33351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA8B19D9A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 10:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF953B2625
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521B624169F;
	Mon,  4 Aug 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g2IYQzAv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3210241679;
	Mon,  4 Aug 2025 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296072; cv=fail; b=KIY2+zIhGs/KvnUEg5aDvI1m/9uxzD6tCSape2kKm2q38LCIsL3oYaceb7yxDmve3AJSJsTCr02MHktXUw4uUpkuXuZdIJb3eSzo7s1zFUvgxBty9ljrLOwtYN5KeSceOnx+6xOc+UBu0thIVOpD3HvZj8CaMu03ADLAKqh5sxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296072; c=relaxed/simple;
	bh=oO83fa2VRzytxbD/DBvsUbaV12iPWWkPDyNVVk0EQGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IlVfWBGfmIqGX8hQnUQklw2P6smApzDEVlqzFzSbT8jsdwqWuWh9hO555AG3S7u8Ueg7fUXrq1T04RdoCj2Q5ELEOmSlEEUS+w5SzV2/SQjNq4eLEMj67a+agjOpEalxRaeWUXqmXxZRdT3GD8DBk/2RUpBm248h1ko5pwLiaQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g2IYQzAv; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RihA4P2nv3nhhH8fSRMcEohIK4BRQ2fp/u35uWo1gq5dU85y9ijb2wFVR2kTp9g6LEqleFxq9L1l+XiEC3cRN12XnKsXEnpXjunia9J0pS67VnvWTTgzpuWccuQFGcpYz0ousYppLISsrFGRs4oMlicsotrdU+qN6Cyy7Io2DeVvR3s1hNsILX+3fS8YGKumBdohh6wzYyhj3QXK7E2/bsi0hs1O8483Pd+VOG2n8zPC/HQiWbvkiaMXE+bywtKyn65gSrFqJIDL6WpT58GYMYHsVlUw96mTpTPBMeUDSFXt+B3EYrSN5ORjrIb6dn9UPOdkPfe+qlYYq1U0jFDgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VIPzQjkLw+4CVlO/OoH5ItALNwKOFkzaQkrKFdIJSE=;
 b=LUzuOiY2KnmKgJmaPf4qKsKg//310hQk4zCOgMupwRNsUsvc9jX4yikwXn8e1Ce4UxQ/AFg3aaHOx72ZPW2zFEk8XKju5r+MHmBAuuI0M6mOXV0gulNvBc8LlK2G/ODVuK8cYaIeJcTDr72wHcusFqMqEfjxHNsAfQRyAcZrdyP+vCUk3tRo0gEgAZ0uUkro4kL1CdH1sLlFOq+phpIgvctF0O4C/1twEIUm3T1qVVKha1tdqgAis+gLEKm0fViXu/rTXvLbCnHPwwiqZMYn5YINEl+bMmWwcXqYAJcvBpkBzXRPWmGLuxDAfNZUETuYWAYdZ6RJAhQFkp5nSlcjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VIPzQjkLw+4CVlO/OoH5ItALNwKOFkzaQkrKFdIJSE=;
 b=g2IYQzAvj7ApQ0ZbRZcDW6vjxCdhkVsxvCQnvXvAXvBBv7csBwd22Pcq6XqlFYJ9CIbNp0WZvrUXxrmdm4kQVY1jDCWF78QdD4N66676RzHxCaftiDiqnYZoSbu59mhA8xGQW0CkhB7rsIIvTU9KqE+4MCdTPOidOZR9goYetjTd8RZaCG+HInwHGvXvj7VGR1PBNMPg2z6LQJza3vbjuuNerE5Z368b2ZzGbwPUWCO9/uZgIMkDeMVY0U6D4CoV326FTHV//sQ7vyVyj2W8NFkLRwWv/S1kijNRyuB+lL7V9Kwo2KJMLjP+U94pBVpRU/8yjFu3DY6ZWs59SUHHHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Mon, 4 Aug 2025 08:27:45 +0000
Received: from DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003]) by DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 08:27:45 +0000
Message-ID: <3a323046-3f67-4e1f-903d-4ce090059cad@nvidia.com>
Date: Mon, 4 Aug 2025 11:27:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
 lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev, linux-coco@lists.linux.dev
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
 <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
 <yq5aqzxr8udy.fsf@kernel.org>
Content-Language: en-US
From: Arto Merilainen <amerilainen@nvidia.com>
In-Reply-To: <yq5aqzxr8udy.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::14) To DM4PR12MB5391.namprd12.prod.outlook.com
 (2603:10b6:5:39a::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a575f97-dab5-4332-fae4-08ddd330c92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWt4cjBVOHNha0hUcVoxWmJmcGZYcXpvZkJWVFBuOUo5QkFXN0haV24wOU9m?=
 =?utf-8?B?QWFGTFUzLy82a1VadVRWQ1dKZHJxYkJZeVZsbTZRbGJ3SUNWU3RRalp1NS9P?=
 =?utf-8?B?WCtwUytPUFB2SVZLK0tyemROcjVRczZNaFpKT2pqcytRZVFNM1pUYUpINW5T?=
 =?utf-8?B?Y0tXOThkQ2ltQnV4Wm5MNmkvZ2pqMWFvTWo2Z3ZRZU9JbS8rNDJoSW5lWGtL?=
 =?utf-8?B?OFFBR2c5M0syLzZvZ1dIRGFwQ1FjTC9SVEFJSUQyNFVodkV1MGhFUTlJakdL?=
 =?utf-8?B?NjJxNktzeDlidW1qU0x5MXJmbGtVVmhLL1R3R2RhNFN5WTZQV01ub05IeStF?=
 =?utf-8?B?T0U0Q3pkUFZxcTlXSU5DKzJoblJoT2NLaDIwTjgreDVGUnlGSWtOUEtBOHdj?=
 =?utf-8?B?WGVCWE1JN3p0Vk1icDVzYkNlVWJLVzZVSHA2M2JtU2Zvb013RlRLVE5DN0p5?=
 =?utf-8?B?dVdxbFIrWE13L0txSzJ0aVNEdWJCbmQrVWJPeDdFMmY0NjVOSEZUek52dEha?=
 =?utf-8?B?Nm5tRG5Xa2U5SENETm11YmxZOVV6YXpkR3lMci9Ba282QmY1MGpLQ3lubC9I?=
 =?utf-8?B?Z3FUMHhZaUxueFZpWVRFYWt0SEhGSGY5OG5MMXE3Nk9aT0ozMm85Q2hzaWd3?=
 =?utf-8?B?Sk1vUXJseWNseFZpY3AvZkJhdEpXTVNvVVlJV3d2UENxVHlGUXEvSVZEb2tF?=
 =?utf-8?B?TGRkdDhoRitvYVVIVWx4MXVaZ0pVNHhhWmUvL1pYbHUyQ25IQyttNk9aMktl?=
 =?utf-8?B?RU9uZE50YmJxVFBUL1RzNTNaSU1jT1J2ejZvSnZFRTJHUjZMa3IyWGJNaDV5?=
 =?utf-8?B?K1ZFenYxOEQyT3l3WlhRbG5qSWlsQk5VSmd3TDJKVi9FcmhWMTRjNldqNmVv?=
 =?utf-8?B?aXFFdHEwbzFoOG1UTVFBNHBRR2dGYis5NjRWS0Y2dGFFbFFBYTd1OURsTG9Q?=
 =?utf-8?B?cDV6UmZjZFhzK0xEZ3dDRURWVDR2dkY5SGhZQjEvdWIxRklFczFnVmVYWDRY?=
 =?utf-8?B?MUFIYXZmOXcyT3k1eWxaVE1SbVF3dE5vcVU0QkJjOEVtaGMxTm0wd1hBWDQ2?=
 =?utf-8?B?MDRqYk5zY0U4WVZZTXlPOE5FN0lvQ1Zrc2NNUDkxLzFnM2lwYlF5QU1JWnZk?=
 =?utf-8?B?anZGVVBmRnhtY29yYmNYK2FhQVF3d3gxUWFoU2EvNk9aMWxaYVlJOURzcFE4?=
 =?utf-8?B?UkhWeDFwWlpCWTIyVEx2QjZhUThsVzJ0cnVwWkVEOXRlUGVUYVp1b0VXUGhY?=
 =?utf-8?B?STlFRnhuV3ZyMEtTRml3bHV4alBSZWZkazdSRjdLMWlWd3NXeWE0Z2M2TkFW?=
 =?utf-8?B?MW9OZ3FFdVR0U3VVTFYvS3BIdmV0bnN1NXlocVZUeGhlUytwYjJjc2NGRms2?=
 =?utf-8?B?RXBQREtVL1NoSC9xWUw0RVg0VUVjajlrbDRwVjNOY29LK3p5NU9oZzloei9D?=
 =?utf-8?B?M2VKdWJHdzNjQ1AyT0h2NUJ0NnFtVEx5ZEV1R1FpS0MwM1hDNjFBZWU4NkdY?=
 =?utf-8?B?TTFBRWRjTnArUDByZkNzK1AvSGhCdnBoTkdzL3ZyZ0VCdE9CcHF2OUEvTlE3?=
 =?utf-8?B?eTBxWnNNMWUwYndmaDNTTlhUVEt1dTRxaHFFVEVjL1dKVFF1THJ2TUVMYlZD?=
 =?utf-8?B?MGdGM1U2ZnF0TVFUUXA4V0ExSUdhZnpURktiWFJHWW5UMVFXNTkrUUpReHhl?=
 =?utf-8?B?c0Rka1ErT1gvako4eVZ4Z2NRWlg2YU9zb3QxTXZONFlFU2RQNC9xaGNXNnZy?=
 =?utf-8?B?MHBiNk44SXVwTGFBZWNhMStNYlFmdFlBSmFBNEFmV2RuaTMxUUptQ0dzUTcy?=
 =?utf-8?B?T0FCNG1WSFZOZG9OSUJRT2p3b1hqREM3T1ZvNHI4Tzk2SmlWdE42U3I4Z2hk?=
 =?utf-8?B?bzhHQ20xM0J3Z3dhSjYwZktmejBrMlVWV0p4dkw3UEdsNDVBdGNyUnpRNzVp?=
 =?utf-8?Q?igur/etNlc4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5391.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXNsdGRQQU9NWnFVTlozbXpEeFN2bDdKd3Y5eEdBQ3VoT3dlVGVJRXpUdklU?=
 =?utf-8?B?dVRNVm0yaUtXa2VyWTFQYUR6bWI1NXV0VUJuT0l0Y3BldjJxQ2ZONEhGTVpX?=
 =?utf-8?B?dFVTNUk4WXhtcjlZeG1sTFdGdWplUy9Mbi9tdER1ZzJPL0QvcTVUNDUwdUJV?=
 =?utf-8?B?NTNJdUxsMTlCMGdLQnlzYXlHZzJDTjgweWZjVjhybWUzYXBDeWxhNU1uNlhi?=
 =?utf-8?B?Vkh0S2xEN3AvRmZTUUh6ZGdIYks3UUNqU20yek5FM1M1MXUvcjh6Y0VRaGJE?=
 =?utf-8?B?bzZ2emk1V0tJcmlBb0hqMXc3MUdoZFNNWkFLSUFjSVJ1eHpJMEw5YTlacFRp?=
 =?utf-8?B?WTNiMDRsZGk2N243ZnZhWjIzQk5pQnNNYm84UnIzUHNjQWFhdzVsZFN3QW1x?=
 =?utf-8?B?RlBoWS9uUXhuKzN1bzlXdlVIYWNkYXNXa0R5bWVjcFZNYTQ3dDY2Qlphc2Ux?=
 =?utf-8?B?cnpETlFuK0pybzZka0JSYzFEM3hvUzM5RlYxMTlwTDVhSzdxVEdRcUFYbDZC?=
 =?utf-8?B?NllDTnFTc25CM0g5a3h2dVM0UmhaN0xBUlRGSGNoYkhPYmR6SWlyY1V4b01Z?=
 =?utf-8?B?ZDFacEFtUU5OM1UzTk1JV05XQzBFMFdxdThobHptSXpQOXVIcW91T3VrN2Rp?=
 =?utf-8?B?RVM3d1JHb0xPdVliUERnY1VwSGkzKzd0VE85eUM4ZmhHeXoxaERIdVJlSnhR?=
 =?utf-8?B?eU5ja1VMdnBRc1lTd0RPemZqWHdyVmlCOEc4bVl1QzB1NE0zdTJFVDUwbFdp?=
 =?utf-8?B?QTgvYmZ3aHdiVzFvK1dpUlBxVVNqdXJDbUtTK25Yc1NBam1qT0hMYWY2aHNT?=
 =?utf-8?B?MFRFUG1TSVZmK1hDUnZzRXJXbEZBcitEM3NiaXhhY3VtaXNFcVR3UUhmYTZk?=
 =?utf-8?B?V0NIYk55b3ZLck5hQVM1UHF1OG85bVhYODRpYzlBN0UyKytJcWNZK3ZFVkxu?=
 =?utf-8?B?eWY4SHBEV2hHTXEzTHRYTTZMOHZFNUxqbUt4NGtKM3I3L2ZUSGhrMVZJQzg2?=
 =?utf-8?B?K0xYOWtwcCsxMU9DZmpFdGM5eTVQQkpkVWN0NkV5Y3BrU2NDSFhvL3hQVE1w?=
 =?utf-8?B?Lyt6ZkdER0J4ZitlbzdlbGdRQmFYK05xQldINE1JdlFjclBmaHFPaUFDSG1C?=
 =?utf-8?B?dkhvVEpnNHlMRHh3S3JFU2R3RklKRjh5d3RLalJqQmhkbTVTNFdMUXJ3WVc3?=
 =?utf-8?B?Ykd5ZlJBWmwyMXNjbXo5dkJtcnUydE5hQ2xsTGpxSll6eUpPSjJwdzJiUVZL?=
 =?utf-8?B?SHF2QTdVUG4vUk9lZGVlanZwYmJObis0Qk9jWkZCNVFMWHVsZmk1R0EwZFJG?=
 =?utf-8?B?RlJFQUUrV3hScUFJbEQ2bTBuYXJCaTJCOXVJeDF3bTBhaUFpWGxXUjV6eHND?=
 =?utf-8?B?VlI0OXdvRVJsc0RkUDhVMk51cmszZGxUK21DSGhNTWNuMGI1VHlBN2pWU0tF?=
 =?utf-8?B?R3BvdVU3dFR2eW1Nc0xMWS9CSW01MlRuTlNIK2M2OXQ5OVpMSmJhV2d5Vith?=
 =?utf-8?B?dmVHczhsRWVDWUhZb01maFhITHg1YkxDWTE0YUl5Vmh1OWVuQzMrVGM5MjVY?=
 =?utf-8?B?TTVNaUQraW1NcHlpenZEMmN5QWtSeVdmZnBRREV0UU5RNkpOTXlSb2FWWVNT?=
 =?utf-8?B?R0pjbGtkaGpVb1crOE0xekdLbFV5Y2dZaDNxNGcvenl2VlRhME9zVDJ6ZlZk?=
 =?utf-8?B?L1piS1UvMFJORjBkT1pnR3I4a2hMdkpCNXdEWkxxWWlJaHJpdUt5ZHEwUE8v?=
 =?utf-8?B?RUltNjBUZFRMS2M3cE9zNmlJTGJPTkxGMUI0dkozTU9acFJINzczNGxWMkg5?=
 =?utf-8?B?d1hudTI0T0E3OHVTZWhJOEp6UkhySWJBYkhtYzYrZTBhZ0tEbCsrTVNFVEwz?=
 =?utf-8?B?ajFlVldLQ2lpOEVkRzQ4anphNzFSQysyejdjdG1rWXNTSU0yOTY0bDNKSGEr?=
 =?utf-8?B?cnVHQ01Tc0lBZU9Wa2s2M2wrWlNxdE1GbVZQZnM1akZIUWNlRFhZbFFUZ2hx?=
 =?utf-8?B?MjRaLzJhUFA0YmVDak04bVl3YnliZ0hzbjIyOHRZSTY1eG4xS1gxeHBzcTlM?=
 =?utf-8?B?TUV5Tk1pVloxTytKMDN5UjNHcWE4VWgwcjdhMHA3YjZlNGpjRmkyK1RVSTZm?=
 =?utf-8?Q?BV1Of+kgvNoQcPdzoaAz0KD2f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a575f97-dab5-4332-fae4-08ddd330c92c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5391.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:27:45.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wBpQCG8yCJjMFvI2nRXW6N1k5In4qDx5nV7TR4cm1d2nINDSUPs9hBpyLX/nXrltgC7STd4gkkMHEHSMxgHfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043


On 4.8.2025 9.37, Aneesh Kumar K.V wrote:
> Arto Merilainen <amerilainen@nvidia.com> writes:
> 
>> On 28.7.2025 16.52, Aneesh Kumar K.V (Arm) wrote:
>>
>>> +    for (int i = 0; i < interface_report->mmio_range_count; i++, mmio_range++) {
>>> +
>>> +            /*FIXME!! units in 4K size*/
>>> +            range_id = FIELD_GET(TSM_INTF_REPORT_MMIO_RANGE_ID, mmio_range->range_attributes);
>>> +
>>> +            /* no secure interrupts */
>>> +            if (msix_tbl_bar != -1 && range_id == msix_tbl_bar) {
>>> +                    pr_info("Skipping misx table\n");
>>> +                    continue;
>>> +            }
>>> +
>>> +            if (msix_pba_bar != -1 && range_id == msix_pba_bar) {
>>> +                    pr_info("Skipping misx pba\n");
>>> +                    continue;
>>> +            }
>>> +
>>
>>
>> MSI-X and PBA can be placed to a BAR that has other registers as well.
>> While the PCIe specification recommends BAR-level isolation for MSI-X
>> structures, it is not mandated. It is enough to have sufficient
>> isolation within the BAR. Therefore, skipping the MSI-X and PBA BARs
>> altogether may leave registers unintentionally mapped via unprotected
>> IPA when they should have been mapped via protected IPA.
>>
>> Instead of skipping the whole BAR, would it make sense to determine
>> where the MSI-X related regions reside, and skip validation only from
>> these regions?
>>
> 
> Yes, that was added because at one point the FVP model was including the
> MSI-X table and PBA regions in the interface report.

The issue I am raising is a different one. The MSI-X table and PBA may 
reside in the middle of a BAR range, and the BAR range may contain 
registers which should be accessible only via protected IPA. In this 
case I would expect the pages before and after the MSI-X table (and PBA) 
to be validated while the pages related to MSI-X structures would be 
left unprotected.

Given that the MSI-X table or PBA regions shouldn't be present in the 
interface report, the code needs to first find out where the MSI-X 
structures reside, and use this information to determine which 
"sub-ranges" should be skipped over during validation.
> If I understand correctly, we shouldn't expect to see those regions in
> the report unless secure interrupts are supported. The BAR-based
> skipping was added as a workaround to handle the FVP issue.
> 

Correct. Assuming that RMM doesn't lock the MSI-X table, I'd expect 
these regions to be omitted in the interface report.

> I believe we can drop that workaround now—if those regions are
> incorrectly present, the below validation logic should catch and
> reject them appropriately. Does that sound reasonable?
> 
>                  /* No secure interrupts, we should not find this set, ignore for now. */
>                  if (FIELD_GET(TSM_INTF_REPORT_MMIO_MSIX_TABLE, mmio_range->range_attributes) ||
>                      FIELD_GET(TSM_INTF_REPORT_MMIO_PBA, mmio_range->range_attributes)) {
>                          pci_info(pdev, "Skipping MSIX (%ld/%ld) range [%d] #%d %d pages, %llx..%llx\n",
>                                   FIELD_GET(TSM_INTF_REPORT_MMIO_MSIX_TABLE, mmio_range->range_attributes),
>                                   FIELD_GET(TSM_INTF_REPORT_MMIO_PBA, mmio_range->range_attributes),
>                                   i, range_id, mmio_range->num_pages, r->start, r->end);
>                          continue;
>                  }
> 
> 

First, I think this is skipping over the whole range => if there are 
registers outside of the MSI-X structures (but within the same BAR), 
they won't be validated.

Second, if the MSI-X regions are present in the interface report, 
wouldn't it - in the common case - mean that the device expects the 
ranges to be accessed with T=1? If this happens unexpectedly, it sounds 
that MSI-X wouldn't be usable. I wonder if the code should simply return 
an error instead if informing the user via pci_info()...

- R2

