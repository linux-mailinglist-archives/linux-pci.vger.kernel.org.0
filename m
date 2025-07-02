Return-Path: <linux-pci+bounces-31314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEDDAF63BC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 23:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB88417EFAF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 21:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127581E9B1C;
	Wed,  2 Jul 2025 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m0loVRhI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6EB1CCB4B;
	Wed,  2 Jul 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490422; cv=fail; b=JaSTCSMTsUlK0X0ERYrvz9SkFvdvNOmhlcVmIB4kA1w/SnfWo1d/Z2o6we8w4QWv6Ye5B+KLkjK0k8DRJsE8UW/zz42MclDdwxlpn/YRf4ujht3iLO9Nf2EnNtflwGVgyE0/esYYarQgx5AiKrFDG7Ay7e1pogY3PW6aChx+LhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490422; c=relaxed/simple;
	bh=Dv5Gds4lzg3bzAwVRGZsUI5ZP2OTUYSNgoBJ5Pcgv9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=niDMSfUN3ByvluBGS9iuje3Pjz79h86EDYCm3AvSA/JzB+68qTMQCYOsjIES8UbdfLNRfhMp28W/00zgK0bw9JyM3WDYCgL23qx/0ICNIvV/psJURhmsz24s2fP/9mhCDqA1OUtkKG5HKIVt6UMTJlS4Ia07hXqNOO1cnwdsIfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m0loVRhI; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5cpsDpruFsKEhNDTNlyhgbqK+b7RTgEFt9gi8CkJU/FPg3wYNn1IqYp/5aWRctYUIRGvpF4jf9jPZFkwJ+ERYAx7nW1e9dKItq9Hao+hf7zQlb+qVNC6KVLQbZkLgy8kEv409iuQCmA9mU3jwI1rCkpysETq6tW3jlsdKDODe54thQaZe2nLFp3JP1WEOZcJhO5gytVVlgI4SkbKAKoFBsAwQ06jRCA8ObtSMEJhSIYaGqQItQxGd7CfL2h+35+AVFfbzv0PPLXLNWoPxtZlMWgeDiJTCzkB7qBDeNvNSOQ3sH68K6ydU9FewyhKbZmkQbOP/EL9W3vjPNgg/3FPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1Qs2VFBL7P9b490/xWH/yu8hdGLdDPVLluar3oaPqw=;
 b=qjcJHSbjDQSMzDnrlvjGuVu37gGOMHi04oBMchxvqdzzZ5cO/mrO4bPhluobDnAw77sAhmbYmFRKkxmDp+jhNj8oVKjPJ7S8qTprmGRTK0nslTLjynayhMdbSqSkT2xsuBZ1udvJMhVo3fC1m7s2IU4OQbcyEw1DRHqYIn5ZW1TffWWEKgvxHae9EHo7fD6bt3o9q9gzCjdSxtFwy2h47EheGtXmcRVLi5Rr28aKInfI97LoW7oPBcoGLLEfwmebMaulTfsuelldll9wZ7gY/YBk0l3IUqJQedRhNEiyqrS2Dggxcdau5mDqkkeBWm+Pq7UiRiUvfQ//ZP9LENmtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1Qs2VFBL7P9b490/xWH/yu8hdGLdDPVLluar3oaPqw=;
 b=m0loVRhIFXo6sIZEX0sJbrkRpDKRqJA+rjdw/Bmt5IdCFvQobHYgxktb7jZst0kn+qFs2v76fFM1Gp3OS3aOzme5xPj9GcVMTmCXyfOsRmpTm2kWOcRywW45SKsMva5Svg3WZFkwF1nYvbP77n4m/b2Y2AOQAZqiticOQd+ccpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Wed, 2 Jul 2025 21:06:57 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 21:06:57 +0000
Message-ID: <447e3e84-af3b-415b-8f01-f3c60fe31ce3@amd.com>
Date: Wed, 2 Jul 2025 16:06:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/17] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-8-terry.bowman@amd.com>
 <20250627120541.00003a14@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250627120541.00003a14@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:805:f2::23) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: d065cd60-b265-4127-2958-08ddb9ac60f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnBkZjlWNE5pcjJsd0M4dzFYdXFoYlRCZ0hTalFtM09wZ2h1cTZoZFVQa2FB?=
 =?utf-8?B?QVNJZ0J6RFJZZVdNc1RoQXJkZ2s4UnEvR3NybG5laXFCUXk4eVhyQWY3RVpl?=
 =?utf-8?B?cDlaczd2YTVIdFA0ZEVWSmE0Ukxmdm8wUllHZ21TcUlZWG1uTXNSanlTcWVH?=
 =?utf-8?B?a0xnMXk0S01NcTQ1aG1LUEU3b0tUT3MrMlRHei9Qb1JlM3RKWWwvNXFSaVJU?=
 =?utf-8?B?aVVCNmEwNjBHK1lNYnFYV0hJZzFRajdNemdmbnZKRTZrWVFHcWRnblRkeUdE?=
 =?utf-8?B?My8rR0JRdXMrd0szZmhrVllnbmoydEpDa203N1VhaUhvbWpTS0RZUzRJQi9Q?=
 =?utf-8?B?bVBhRmV1M2txUlJGWUVCUU81dFlaT0dPVEhKSWltWEdIQU1xbzhxYXhKY0ZO?=
 =?utf-8?B?eUs1cnlQREp3TUVPVnF6bkZuRzVXaGFiTm0yNnFGSEVNL3RFYmxzRmlMY1BJ?=
 =?utf-8?B?eHNxKy9DL0lFQlp6QmkxNFlVQkd2Tll0QVo0OHVobmMxbGxXWVc4UXRmcmRI?=
 =?utf-8?B?dzkzUm5mRWM4czVRVUlVMUtRc0FGcEZ0N0E4TG5XbTRadkVWWk9zSWgyL1JI?=
 =?utf-8?B?dHVlbW1CSXMxeGxEMmV5MVlqYjh4KzFkTklVOWwzaWxaVXR2UWkvTmQvLzU2?=
 =?utf-8?B?QlNQbFZpcGEwZmpmMXRuMndmelY0RjdSVmNsVmRXWXZLTkVkeXh3OUdrNnJP?=
 =?utf-8?B?MEFhUGdUelpyUnNTUWR6aU5oQ1dBZlZwblJkMm9HclZ4emk2cm1RSFM5VlRU?=
 =?utf-8?B?QTkrSWVOSFdlSkhLWGdaZGlvUktHMHc5ek9TOHhVTlJ2b3hZdm5DQXdobGNh?=
 =?utf-8?B?TGZkQ3lZcUQ1U2FwbThINEZ0cENTTWtrQmZsRG13cklmeDlrcDgzZWIzOUdr?=
 =?utf-8?B?VWQ3MHVMRVV5WFdVOWVlaXJ2TGhoRkNXQnNzbnNzYkY3R2RMaURXOVhKdFRm?=
 =?utf-8?B?Qm5ub2tVZE1qWnVzdzcyQmVIMGVuSTAvS1NDNjk5OHpzMStncWUzbFYybTlU?=
 =?utf-8?B?eGt6REZobEVIbGFETG9sSFpMQnhYcmkvY0JsajFqRUp0cFJCU0w1MjBKQmxk?=
 =?utf-8?B?UFdSSlY2bVAwd1RzK0RIREtaM0JRb0trbTdCK2MrQ21maEsxRmZrN3VDZDAx?=
 =?utf-8?B?M0JGSlgrT042anpqVkxiRWxmVkl4WkpmS0owOXI4eG0zRHNDcTkybjl0MEpw?=
 =?utf-8?B?NStxTnZJZXNoWXRZQk1lbHlZVlVDb1pjNzVkK0RPaXBSRUxPREc5OTBVdDlS?=
 =?utf-8?B?VEV1NWFkUWNBVUx5aE02T1BKTnFyYXpwREc5dG1KRWVZL0d3ZnNOZkJWd1Uy?=
 =?utf-8?B?TkljTC8zMXJLR1VXQmNpZjE3aGIwTzdBSXZoUTRrcHJxQ0Q4cGF1K2dRbE82?=
 =?utf-8?B?SmdQZkpGaytESHlsdTM5QnMwSVljZEhaN3hKZnlZaGZ2RUllYllmeEFXZldx?=
 =?utf-8?B?aEJHMTdaZnhmbml6V3RKS3lhdWhlRW9BN2lQSGdYRzllUjZ0di82dTJrL25B?=
 =?utf-8?B?UDBZUHc0Mmg4WTZ4RHkrZVEzKzhLVFYrbytucXZvYmxXRk1FWjhEcW9pRkFj?=
 =?utf-8?B?ODVyY2NTZWpBUFFWYzR1K0Rrc21YM2taazZ5SU4xRDJHdXkrSnFzdTFDMEp5?=
 =?utf-8?B?MFRlOXRqd3NTVm8vU2s2T3dydURmOEtQekg2MjJYbm5BaVN5QWE1UEtUcVY5?=
 =?utf-8?B?OEsrbFBMM1N0NGpOTUcyWEhWUTB0U0VVQlJnOG5xNFpPekxaWUg2Ulc0ZHNy?=
 =?utf-8?B?MWd4RmdHMmZSUzVHbXYwS3lkWVJpdVBrbEx0TXFVWkpiTnRFSWRhZnk3bDlq?=
 =?utf-8?B?VmNobHlhQ0dUZlpqa1Q3WHoyUW8wT0RJL0NkYUNMcVYyRnNpTkZ6Nkdoc05o?=
 =?utf-8?B?U0gvbnFNZXJZN0FmQjhEQlBqMk9nMTEwS0NSU0NIQk03MkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFdaVTdwOWhwUlNubWpqRlFmVTdkTndoaGFpUUdxamhLN1RJZmlrd2l3dk9a?=
 =?utf-8?B?SGhpeVcvRmJkdkF1K0NYN2NDMGpraE5OUkZrSWtqSXc5TU9FbkJITy9SeCtU?=
 =?utf-8?B?QWlIMncwL01ZdFlWL0RkS2kzVjN6WHMwTnJlcmFONzFIZ0pUNWUyVldzYzIw?=
 =?utf-8?B?dVFyNDBVb3lkMVlUM3ROVDVpaEpKTEQyQXdjK1MvcW5HV3Jna0tCYnBaRkEz?=
 =?utf-8?B?aXRsejBsazdnK0dJUmdXVzZ4MGxxV1lSc3ZiZDZRaVk5MXhSUk4yUnpBdGJw?=
 =?utf-8?B?NmNIMGVRTG5nSkg1SlRiVXdIdUVJL29XV3ZnRE0yNk1uWEZZWWhwUlM0U0Mr?=
 =?utf-8?B?NHY5SmtsZVJ3MzVsajM1UzRCUFRDcTFQbmtFVDZEUW9IcGxtSEh4K1ZhR0k3?=
 =?utf-8?B?L2xxRG11SWxjR0c2Y0xpSjB2alBobGI2QXI2c2xmQzFVQ1lScGxZekQ3dlRt?=
 =?utf-8?B?UXQ1VURiMWFvZEVjcmRReTZ2eXRrQyttYlMzZUhVYmpNSkR2WW5yV1M4VXVE?=
 =?utf-8?B?bXo0dVVSaDdkZmczSUNkOCs0eUlKV2dPRFA5UmpwMXl6M0NOUlV6M3l2RjF0?=
 =?utf-8?B?bWwrZFJQVjUrLzFYa2ZJTmdxY1dEL2dlc1V0QWhKZVhVT0pmODVwWHNUWVdQ?=
 =?utf-8?B?NVdId3VTVEF6bmVmcG54M2dHRkZRMkxpOTd3QVBISkVTUjkvMkZMUVI4ZWZN?=
 =?utf-8?B?RTVxc3lFZDhpS1UzZEVVaWg4a2UxRktaMk82UUFSaWlRZGR3eW9tMUVGemhu?=
 =?utf-8?B?ZlZCUjQ5WTlxWTErWElxMGowQVZtNDZrVU9KSXpRVGViWmc3bitNdnNMdTZT?=
 =?utf-8?B?U0tRNVU0STFuSU93RW1LUThFeXh3KzR5QS9TdTlSSU9tWTR1YVVsQ1EzdHpN?=
 =?utf-8?B?MGJRS0h0NlJwdTFUNWx4eDMyZEszV05LeWp3UlNYNU1NYVdsZ3IzUFpSUUdM?=
 =?utf-8?B?UDFEcUNXN3VRZEJaZCtiMGRXTUtoU2hGVktNc2VLYVJHQXBlZjFiWWRTeGtj?=
 =?utf-8?B?RWMyNnJnclVLQ3M3aW83eVAzUW14UlFoa1pjN1dnOFVFbVdLSVBWR1l3eXhX?=
 =?utf-8?B?K1g4OGI2eHVtZ1QvSG5JVVgxbDFGRTZxeXI2Zmt2STJUbU03a2Rvd21IS1ly?=
 =?utf-8?B?cURMbFVOVjhWSmFxdHA2cW8wbWJkSlpVaUdjNHJhQzlaNnJ5emc2Zll5d1lH?=
 =?utf-8?B?WkVIUld3ZVMwY1JDWXFOcVhJNll6TGZ4RzBlN3I1cDduVUIrU1hOeTVoN0ha?=
 =?utf-8?B?aGF4TGlNUVN6TS9US0ZMbUgyNFh1azBwdHE0cmRWcFFydnRBMTdTQWw1RTJJ?=
 =?utf-8?B?MTZmMG5sNkROYlFidWRVN0RzaW83WFNMRmJnUFRwaXhKK1oxSld3RTJMMmxY?=
 =?utf-8?B?K0ptR1BvNFdIQ2x0REZhdXRzQWJGbXZ1N0Z2Zjc4WFRYSE96emtsaFZjNXJO?=
 =?utf-8?B?TGF5NkNpK1JmN29kUWVrdmZsbGVyVGt3RE1hZ3N3UUtLRWp5R2hYT2tTOEtv?=
 =?utf-8?B?QnN3alJwemx6WDUwMDVnVTV4R2wwa211aUc4d2RhQTBienQzaUJOc2s1NWor?=
 =?utf-8?B?TXJpZWN2dTRRemZ5Y1p1KzloQ2hDTmRvamdZc2I0TjFwaXdicmVZTVpDMUhU?=
 =?utf-8?B?b0hwYWlNZDRwdXZQbVhiaE44b2FhQ2RWVXNOaDVYVDUvUG02M01kZ1JaWVBH?=
 =?utf-8?B?cnFId1F0c2w4MW9XZWJ5V1RKMVQ5b2tYT1NBRkVyT2JVMERTanplUXFVbVV0?=
 =?utf-8?B?VGVzajNtVlhSREJuUEdQMXduemZha1cwbFA0b0NIYXZxS1hpd2VwVEQ2LzhB?=
 =?utf-8?B?dHhNMnJvNzVydjQvaVFKdy9Ed1k0Tnh5WFdaSnBJU2x6cEp3VUJaMWVQc2pi?=
 =?utf-8?B?U1QwV0VpZVJKOVdlUit0VXJaRklyUGUwUktUOXI2YXNIMm9ETElwUmdJZG1o?=
 =?utf-8?B?U3ZrMTRlWXZpalZrTW1KWDhJUVA1SkI4eGNEZ0tFS2xUK291VDI2SmdPOGNn?=
 =?utf-8?B?RWpML3BSY1BHbVkxblk3a3dsb3Z4REZldXZEU2lMc1pTbFFsUjlIWHJMeU9m?=
 =?utf-8?B?Smg2MzNnK2U1Tk13VTdwajQyWHdSN0ltOTFTWTFWbngvUitHZUFucFhUenhW?=
 =?utf-8?Q?kwblqCH1x9wHS3PCnNJwuNOd6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d065cd60-b265-4127-2958-08ddb9ac60f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 21:06:57.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liHunXCfB2eM1ShqNCkocgsg54ryuiCEYvCHEi282ScC+VLVhPUF87UGPhba5utFin9yPJUNk7R6gxvvfN+PvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728



On 6/27/2025 6:05 AM, Jonathan Cameron wrote:
> On Thu, 26 Jun 2025 17:42:42 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
>> handling. Follow similar design as found in PCIe error driver,
>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>
>> Export the PCI error driver's merge_result() to CXL namespace.
> I think this may be a confusion from earlier review.  Anyhow, it should
> be namespaced in the sense of not exporting something the vague name of
> merge_result but it's PCI code, not CXL code and we don't have the dangerous
> interface argument to justify putting it in the CXL namespace so I think
> a namespaced EXPORT makes little sense for this one.
>
> Jonathan
>
>
>> Introduce
>> PCI_ERS_RESULT_PANIC and add support in merge_result() routine. This will
>> be used by CXL to panic the system in the case of uncorrectable protocol
>> errors. PCI error handling is not currently expected to use the
>> PCI_ERS_RESULT_PANIC.
>>
>> Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
>> first device in all cases.
>>
>> Copy the PCI error driver's report_error_detected() to cxl_report_error_detected().
>> Note, only CXL Endpoints and RCH Downstream Ports(RCH DSP) are currently
>> supported. Add locking for PCI device as done in PCI's report_error_detected().
>> This is necessary to prevent the RAS registers from disappearing before
>> logging is completed.
>>
>> Call panic() to halt the system in the case of uncorrectable errors (UCE)
>> in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
>> if a UCE is not found. In this case the AER status must be cleared and
>> uses pci_aer_clear_fatal_status().
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index de6381c690f5..63fceb3e8613 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -21,9 +21,12 @@
>>  #include "portdrv.h"
>>  #include "../pci.h"
>>  
>> -static pci_ers_result_t merge_result(enum pci_ers_result orig,
>> -				  enum pci_ers_result new)
>> +pci_ers_result_t merge_result(enum pci_ers_result orig,
>> +			      enum pci_ers_result new)
>>  {
>> +	if (new == PCI_ERS_RESULT_PANIC)
>> +		return PCI_ERS_RESULT_PANIC;
>> +
>>  	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>>  		return PCI_ERS_RESULT_NO_AER_DRIVER;
>>  
>> @@ -45,6 +48,7 @@ static pci_ers_result_t merge_result(enum pci_ers_result orig,
>>  
>>  	return orig;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(merge_result, "CXL"); 
> Do we care about namespacing this?  I think not given it is PCIe code
> and hardly destructive for other drivers to mess with it if they like.
>
> I would namespace it in the sense of renaming it to make it clear
> it's about pci errors though.
>
> pci_ers_merge_result() perhaps?
>
> Do that as a percursor patch.
>

Good idea. There is a lot of changes related to just exporting this and changing
the name. I've changed the namespace export to be:

EXPORT_SYMBOL(pci_ers_merge_result);

I moved this and its related required changes into an earlier patch.

-Terry

>>  
>>  static int report_error_detected(struct pci_dev *dev,
>>  				 pci_channel_state_t state,


