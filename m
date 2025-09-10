Return-Path: <linux-pci+bounces-35798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE683B50D87
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 07:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0721BC37DC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 05:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E619262FE7;
	Wed, 10 Sep 2025 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k83U0vyS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F44A07;
	Wed, 10 Sep 2025 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757483273; cv=fail; b=M4fQ5B55yz4n0ePug1QTdz0mn4xUoem5R+XIr8yTUz4I72QdrcrIDIBRwLKTmPSIM6NyEu9xOJaOsoOe/wFklVw1J5yqmhqgNsBzdnewsu9Xq+umxRTTh4YHCfsVt33uwtDnF7dMTxJ4wCl5Z543U5lB+jJvwUoJQPb3W6dV/jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757483273; c=relaxed/simple;
	bh=p281xbqC+ieq8wSx2vGjtgbpuOZnc9NZ3b4BqHlIbDg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l30XxZ6LwdayD6MAMBSkloXvAKbyqvEhqmHPhyBId8iRmdqpDzsdbYU7BVHzDx8K4hMmFNdZ3Mn1D9HYtZHQh5b3TByZ0tm6aR7fq9zBCWsS0y9QX0LY9CuC1kvcC0mB+l7k+yKfgYhJNc2n75+kHPiRGQc3EEiSEg1STu/lE4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k83U0vyS; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRIti+YwgG0e0kmFs55yYEYezOqGRJmP2qSljSCRvNUgenrDsA4C8ie/CAu6xKEJ1e14t42jnlCxQ+RLIFs4ODud0CzB/0Db67LHprBDMd6knwpPsfk2iZuXBHZ9XVrYSOk+EIfyCLvFaEnFKpmJjgUySeNiXXuYJEKzFPROzIsa7TrGCHJiT36KN4i3St/UYrjiP8fM6cZzse2uJc+6GTxEBil5bGGsTaI1z760YKQwJzFqjJ1Z3RHx7M//FrNAZja4ZtmRjMy2imiQ1Ys+UqXm6MJysxBfdCOQriW6Vf+hsEWT925OgAIX2PyebSQQ99hMGZBdRFmrrTOLlfvtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii5arlZ5KOlkU6Xv9q+Z2Lli5GiKzMKurHn5BRcoYTU=;
 b=y5E1PPnuwvCQttT7x+zW+p5YcOP09zKYbnCVVkf0tbDFvOVbUzsVXaC5il3T/8Pd9cMCNGPb/68ysymCUCYuQZligN4YBr3+tPDlbtz5k2btV7laUwTklIoSEDUL8xdC4fSiPqZEJriw0PYYd2QzPrhjSx9nblXwr8lQy+RFRltWHWxSMHQAT05zEgcBNvcHq4BptFdrhAeul9xgTSfKnTFG3npKx6lxOQ+sYLmD+1g7O8ORVu95UBqIFaqVLDT3scQ7ofnuKiXEFFCyZySp4u71drYHMz5SoficzGq+I0SJjPW+kUELItvqvMBHdg37Khe5moJmSEwLhUTg7SLT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii5arlZ5KOlkU6Xv9q+Z2Lli5GiKzMKurHn5BRcoYTU=;
 b=k83U0vySrcewyunIdC4HtIuy75HfEfEBOJGyZyKSA1fV9OFfLcMaQyGlvsxgeW2D5lXem/+B/Xg9fVHhne1a2aeYOe570Wlir60bnjsfSs7yPAKNpvaPEKayi2NLS1FeyHORPPeMHsxXvgVCN4pTsbGkksZO3f1tSbtSxkgEEt8yEnG65jpHMPXTlJYe3aogNh90gFD0XiRGcDBwAie36uUBypGNULSRfWquecCtOipbUStcLQKRntrmZ/VCZNaDDiqG13BbpXxXTfa3Q2K3YqQxtJ9bGe+/NX/UlMENGqMYxeBJt9EjL5OMKpskoJwhK8ymPeCYYDmUXnYsMKAEjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14)
 by IA1PR12MB9522.namprd12.prod.outlook.com (2603:10b6:208:594::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:47:49 +0000
Received: from DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003]) by DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 05:47:49 +0000
Message-ID: <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>
Date: Wed, 10 Sep 2025 08:47:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
From: Arto Merilainen <amerilainen@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
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
Content-Language: en-US
In-Reply-To: <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0238.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::9) To DM4PR12MB5391.namprd12.prod.outlook.com
 (2603:10b6:5:39a::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:EE_|IA1PR12MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: de46d73e-b989-46ee-2244-08ddf02d92ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzNNSzZZR0xnTUd5SFpiQkdua29oZ0RJMGJCNXZsVmJxOW1DejRXQnFITlVk?=
 =?utf-8?B?QWlDdGJqbFJRR29mUzdBTGpuOFM5ZFNETll6c1FVNjZTb2pPL09qQ0JLdXMv?=
 =?utf-8?B?NTNmSXc1WUt2dnRwa1RGSnd5OEpyRW9yc3d0eThjOWM5bVZXUGM1TDFXWWxB?=
 =?utf-8?B?VUdzNE56b25EWjNsb1N3bFUyZk4vUTlHNk1ETDEvYVpEM0lJTnVDR2M4WG9w?=
 =?utf-8?B?aVp4MDQ4Z0hrRENFcjRZTkhlMjRyeE9GZkxwMkpmc0RzNW5aN2hWQnJrblZz?=
 =?utf-8?B?MGZzTHlwYVc5VC9UcXVaOC8yRDY2d3dud2x6SnJSTFJId3k1L2lMZ0x2YXNq?=
 =?utf-8?B?SkRrOFNFTytDc0EyUWFIVFpmTkhjbTFFOTZWMVVhai9HdWJuSkh6SndwN0NM?=
 =?utf-8?B?djVCMDdjdkFCSXgzRGxGS3BKWk5RZFF4OHFqdWR5Vll2bzRzZmpCQllPbkc2?=
 =?utf-8?B?SlQrN1ZReVNLc2V3b1NTUG1CMzdjMlAvekRtTFNNcEFBN3FsR05FYjJncDk1?=
 =?utf-8?B?VW5YaTA3czlCMmxFSmRYZ01seEM4RjdHSzJKNWora3hDK1Z2MU1XUmVTYktZ?=
 =?utf-8?B?NU1Nb21aaDAzanI4RWloSll2VWR3OEtKK3hpMENQa28zTDQ2b3hwcVZ6Mkp5?=
 =?utf-8?B?SVNGTFlaZEl2cTNncC95b3hIZDk2cUxpWjNCWUM5R2R1S1hHNHBpWXZJcHZi?=
 =?utf-8?B?c3NIZ0ZzUEk3NGZIRU5HeGtrTjczTktvMlBYeCt0Ukloc3JpU1h1SHNrNEdI?=
 =?utf-8?B?MzBWMzdWalZ5ZytqZ1NWQS9JQjUzYmsxWlN1NXp4WnA0bnlsYzByc0RqMWRS?=
 =?utf-8?B?VFNNL3d0UGhubmFBMUNjVWxPanNVcWx0eUU0SGYySmkrRUtUNnVTQjM2eVNM?=
 =?utf-8?B?WTJSWEdmWmpiV053U3FCY2R2Y1ZlM00zS1o4REovcXRybjVWZ25hNWtwclgz?=
 =?utf-8?B?dHdFekRzZ1l6OEVHY01NOUpXMUZCbEtmRHM4V25XdDlhQlNzdldKa1dsVEJq?=
 =?utf-8?B?WDZsODJDTlNiMjBadjUzbEdnTUlwNDZHMk14ZkRPcllPNUxEMWdTQmJubHdF?=
 =?utf-8?B?MStsRXhTaHJmZmFBa01GQ0hSUWZ2b3oxUTFMTnRrQmxpaWhLTEF4VmloT3dN?=
 =?utf-8?B?NWZUNGlyeHVRbDFOQlgzaDRsSXBPYUpJQjZDcEFFNmtyWktkS08wcW8zMTFi?=
 =?utf-8?B?VlN2S1RjQmxNVTFsMVRZQ2RwSldyMzlpNXRsQi8wSVVSbDl2SkFUMjM3WStL?=
 =?utf-8?B?bDU4VTJTaC8rSmFRRllPdUdTaDJ1Tk5ZNExVMzRzMjFnd3YrOEdYQjYrK203?=
 =?utf-8?B?cTNHZ0d6VHZ0emlhZWpzRHhLbEhuaitFRjFFU2Q5SHowOVBQWmY2bllWMTZz?=
 =?utf-8?B?Q1JrMWVqY2QrY2hOdXF1czVyb0F4VWJROVlCSFBZcTlmN3E3a2NXYzhRU2NO?=
 =?utf-8?B?KytYWktCVVAxUjFJQ3crK3RIN0xma0FVYUsxbVRidkFEOTlpOU5ibWJQWDdG?=
 =?utf-8?B?L0hKQ2JnZTRaODRWdHE1aDcwSitGN3U4WlFhNlVkNkZzdU41S3hpdFd2ODJ2?=
 =?utf-8?B?Rml1MFRoazNacllnb0o2YXJ4VE9UbEdadG41RUlDNll6ZzBCdGdIQlVPSTFR?=
 =?utf-8?B?Ly9qWkhhSkwvTTkyTWhYdDdYaDVWT1gwZjNmS05MakZaWG5YZFNnNnJZdzFl?=
 =?utf-8?B?QWplN2kvV1lxU2xrQy91bHBRQWVCRXpiZzAzMlVXM3VicVYxOWhVU3l2cU5t?=
 =?utf-8?B?RmpXMEljRk9iQktwdGVVeVFIN0hVVWZCRUhEYUc0M1pIb3pkUDNxN0Q2KzI5?=
 =?utf-8?B?cFROSjE4NVN5d2g5WHVpYmJqajFLZ1ZsOXd3cGhGK0E4SkllSGVwK3l1MEh0?=
 =?utf-8?B?NzdyU2NiVmdaT0lqQnhLaVRYUUYwVURza1dmVk1aVlVsQzEyR2hPZkZtYmdP?=
 =?utf-8?Q?ESZVARcAKps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5391.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmlZMGJPQnpFd2VGZ0lpRDhUNk5FL0l3bTkxTlBTdUdoWWFLVnUxd0xKdjlu?=
 =?utf-8?B?NlBFUWNQdFRLUXptUFdDTDB6bkZCM2o1alQ1NWd3dHJOSDZVQk4zTTZ3Tko3?=
 =?utf-8?B?aGxGNUE3WTZNYVhUZDZKeHYyZWdXL0tkdG15ZmVKQ05sZmhjSkpZVk0yWEZp?=
 =?utf-8?B?Uk11dGRwZmp1Y20yL2s3eURMbXVERDRnMWhERkN5bmh1UTduVCsyUy9DZ1VI?=
 =?utf-8?B?eStmLzQ4UGlYT1VMY2VEWXcrOTU3RUw1Rklaak9icENtS1lJT1FMa3ZCNEFY?=
 =?utf-8?B?M2p2bzdpRVg5czJ2TFFMQk83RUFrb0hJbDhTbkpwejNod2xrSXFlMXkyZ0lr?=
 =?utf-8?B?YzhFNkdaWlB3ZWdHbmdWWHR0T3J3RlVnemFFK2lvekpMV0FsSVpQbEZrQkl4?=
 =?utf-8?B?T1NHWUpTc2Z6a2VmOUR0azF0aFVKZ2FGTDBSMFUzamdUR2dDNEFNZ0wwTnAy?=
 =?utf-8?B?cjJDVk96Y2dOZGtzTGh1dzFHMW5kV1k2OGhJWWU4NXovcnAweVVFbGFRZUQv?=
 =?utf-8?B?Sk95ZWhPYVhLOGR5elhvSGx0Nk1sUTJVdDkwSWpHRnZZaGdsQ1BpVmpIQjJI?=
 =?utf-8?B?WnJDOWJGZnRJM2lPSENIOS9pUDE5YldpT09sS05jWU9POFh0aGx2d3A3ZnBx?=
 =?utf-8?B?K2h0ay9BSTkwRDlzM2RqWjZXYllINlNnYTEyWHJYUjhNeXRydjFiazRaeWVE?=
 =?utf-8?B?WGFzZThlMnpnSnhlSnlMNkFMZXo2U05qaVNwN0huc3VXQUNhN1RORWpnRXZI?=
 =?utf-8?B?cFJTMjkyd2dHcGNVZWM1QkM5OXRNOHFudlFMN3pGVlJxc0JQdzlQS2x6Mlpk?=
 =?utf-8?B?TGJDMnZiQVIvVUFZM1YraTg4TWIrdDlqckw4YWhVc1MydlZNSEo1THBadXAx?=
 =?utf-8?B?YkpiSUxDVFlsUHVGUHNVOWRHWVpzb2IzM05EcHEvWklBQXhDbDM4UlZqU1U1?=
 =?utf-8?B?c2wxQ3pYbGhickc5eHJHdU1kakJhNGhpRy9KYjVQZngxblB3ZlNha3dLTHNh?=
 =?utf-8?B?MGw2SmhsNTBOVGJhZjNWQml1QVBqSTNIZjJsQkVRNXFCV3IwMW5FbTRHaUhJ?=
 =?utf-8?B?NHloZGx2VUxrL1NRKzNIVW8ydmFCUzNpaE0xaHdvVGRESmltNE9BbUIwWXg5?=
 =?utf-8?B?V2o5VGR5Rm1sbWFnSEorc1JacythRW8zOWJZclBLQlovaWJ0UkRDdm84eEVE?=
 =?utf-8?B?MXlzVnN3VVFUendFTC9udVpaOU5ZbnJiMERxK3VseHdTU3k5R0M3OEcrNmhu?=
 =?utf-8?B?TVRFZ3BlUy9jVWJOdndFcTY1VmtmYXZSOUxUWXJHWW1WS0NFRUtWQ2FVNC9R?=
 =?utf-8?B?ekowY3RXSC9DNjl3alZWRmswNThPQ1J3NE02TXlFRXMxYVpXT1Jqdk5pVU1z?=
 =?utf-8?B?djl4KzhVamVFb3hwcjRuSytUOG9zZDlDblpEZWR1UWZ0TFdJeHdRUFBEYnNj?=
 =?utf-8?B?R2NLTFpUTUZlRWg4THErajBESnBsMURNakV4ZFR5aDRCU1pnZy9YQVVQS2lm?=
 =?utf-8?B?NFB2eklSZlI5SHdRaGlBUG5qTWpPYUtVU2VDNHBodWNjeXcvRFdJRm5yb2tN?=
 =?utf-8?B?VkNsc1B2aVBMb3hublZ0bTQ0b01FZkRWZmYvSFR4S09xU1YwZGdLRWFWbnRp?=
 =?utf-8?B?dzlsUmJjdlVHRHgyUHVjYzJsVnIxZW1Ncy96ZXdKZkZWUmI1TjVGTEpVSXNT?=
 =?utf-8?B?SWxHU09xOVA3QW9UcG9LcXRraGorZWFPMS91azZYUFhGYy8rMWtndm9Zdldx?=
 =?utf-8?B?RDFjNDlmTHZpN3RQaWRMU2xGN3lVa2Foa1Q2MDE0d01YR3EzMmQzYVZ0NTJ1?=
 =?utf-8?B?eHdiQWZnTmhkKzRTWTNnRExrKy9nc3o3QWkxVEpUcWVvUXBvZVJTamNzcnRo?=
 =?utf-8?B?RUxWK3FhT2RzOFZpVzBhWWRjQlloT1lEaFBHV3hjK3dEVXZHcU9pZnFWSVhi?=
 =?utf-8?B?amtHSk5MeTh6QldiK2xTUU9TUkJtL3gybDdBMlY5TnErcGVZTXcyYmlHUmZ4?=
 =?utf-8?B?ek5MMVpPbDhUODdON0VvYSsrZDgya1psUm1XaXRwc2NubTljTW1TakNuYzVr?=
 =?utf-8?B?WXZqUG1aK0tFb2k5UnN4NkNvWjlpNm9zaG1zOUl6UWxMUExEU0Z5YU9nWWpa?=
 =?utf-8?Q?ZFQp6/vApqa2ZaAF/L6/p4IlO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de46d73e-b989-46ee-2244-08ddf02d92ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5391.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:47:48.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6teuyhdwV0LZoi1VMUqr6D/wom7wZ/nZIptodyVTISyHaf2dBbAH4oKmej0H+ma/xOKRzVVzoq8vqkpCGS+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9522

On 31.7.2025 14.39, Arto Merilainen wrote:
> On 28.7.2025 16.52, Aneesh Kumar K.V (Arm) wrote:
> 
>> +    for (int i = 0; i < interface_report->mmio_range_count; i++, 
>> mmio_range++) {
>> +
>> +        /*FIXME!! units in 4K size*/
>> +        range_id = FIELD_GET(TSM_INTF_REPORT_MMIO_RANGE_ID, 
>> mmio_range->range_attributes);
>> +
>> +        /* no secure interrupts */
>> +        if (msix_tbl_bar != -1 && range_id == msix_tbl_bar) {
>> +            pr_info("Skipping misx table\n");
>> +            continue;
>> +        }
>> +
>> +        if (msix_pba_bar != -1 && range_id == msix_pba_bar) {
>> +            pr_info("Skipping misx pba\n");
>> +            continue;
>> +        }
>> +
> 
> 
> MSI-X and PBA can be placed to a BAR that has other registers as well. 
> While the PCIe specification recommends BAR-level isolation for MSI-X 
> structures, it is not mandated. It is enough to have sufficient 
> isolation within the BAR. Therefore, skipping the MSI-X and PBA BARs 
> altogether may leave registers unintentionally mapped via unprotected 
> IPA when they should have been mapped via protected IPA.
> 
> Instead of skipping the whole BAR, would it make sense to determine
> where the MSI-X related regions reside, and skip validation only from 
> these regions?

I re-reviewed my suggestion, and what I proposed here seems wrong. 
However, I think there is a different more generic problem related to 
the MSI-X table, PBA and non-TEE ranges.

If a BAR is sparse (e.g., it has TEE pages and the MSI-X table, PBA or 
non-TEE areas), the TDISP interface report may contain multiple ranges 
with the same range_id (/BAR id). In case a BAR contains some registers 
in low addresses, the MSI-X table and other registers after the MSI-X 
table, the interface report is expected to have two ranges for the same 
BAR with different "first 4k page" and "size" fields.

This creates a tricky problem given that RSI_VDEV_VALIDATE_MAPPING 
requires both the ipa_base and pa_base which should correspond to the 
same location. In above scenario, the PA of the first range would 
correspond to the BAR base whereas the second range would correspond to 
a location residing after the MSI-X table.

Assuming that the report contains obfuscated (but linear) physical 
addresses, it would be possible to create heuristics for this case. 
However, the fundamental problem is that none of the "first 4k page" 
fields in the ranges is guaranteed to correspond to the base of any BAR: 
Consider a case where the MSI-X table is in the beginning of a BAR and 
it is followed by a single TEE range. If the MSI-X is not locked, the 
"first 4k page" field will not correspond to the beginning of the BAR. 
If the realm naiviely reads the ipa_base using pci_resouce_n() and 
corresponding pa_base from the interface report, the addresses won't 
match and the validation will fail.

It seems that interpreting the interface report cannot be done without 
knowledge of the device's register layout. Therefore, I don't think the 
ranges can be validated/remapped automatically without involving the 
device driver, but there should be APIs for reading the interface 
report, and for requesting making specific ranges protected.

- R2

