Return-Path: <linux-pci+bounces-17889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813C9E849C
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 12:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53903281471
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 11:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70613AD22;
	Sun,  8 Dec 2024 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WssQl9MO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C428EEB2;
	Sun,  8 Dec 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733656853; cv=fail; b=U+UsIg4AIbUq0Z7ONz+XWGpAECw6VaYN0pXHEdnOiHSZkxOklNOAkW2Sx13O+T2k7plu2ZfZ88ZTtcG00TFaRZyJX/CYqipzb+mnDnQ7LVdJQkIAebhowvIV4ewaOmgI1/PljCiwZxrhCTjbzieX6HTP8tpHLYmWb6S1Dcmxc58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733656853; c=relaxed/simple;
	bh=vdm36gGvDqIlukTlPZGKP86OYKUzTjRXk8/6IPFtsZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E3tdkXwcb+BmEk+DyKzQ7tYHyoOMjiAuuY/O090st3j7rWluzml5Y8HgpBGRIinJ20PEXCqwUwcAkpicPtaIs3B76bCwoJuvycearugAAX4o4ujbjnjUhLfZrYE8/w3OOUeN/cCs8TerKleCmnq8SWaKDNoYu9NAMwf7M/5XjKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WssQl9MO; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whRkL1qFFWrj2jbDuMai71sMmnpwDCK7bnS6Hc2RwHMi3LakTUjIerPwGsQxJdy5uqSx1aH0SVPmRe/Yo1HPWUn2DqmTLNfWkFcDoXCosCV4SmXLI2svvgJwQki0Z5u5nl+4o38H4wF6psH3u03w78Vkjwukp5l72pxklIY+68xmNSyQRt1Orje+Iwm/3+qSfEO0rFIgfCG/rAKyUV5782kTs6MkhP+Yc78t+payV7jhOZ0XeJpKFnWPDLQdIfQO16Z1/RKNfQ1cNwcAi8vibEvW/zSQpUXGoh7f2pqOEZTg+MMQl37aWj1sHjY/VmTqJ0csc/r/PWPj16yDFvLp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScAs+VpAkJG3QFC9H3C6iT1GfsxT0P8XqY9CvvF8lgY=;
 b=iyzQvNEUr6/7hNROXlvvD2TlwJTWxSWRhcLaYKJ9dEvVl7WWRr88fK7WUJkl2gFaozwomm5aOkNeIeb2jdCeUGUTjtX2lYnBG+4Um8QiH3o5rrP9GrzhDhIWK6RyCvk4j1kGq8WhlCuQKXfIsdw+OqBhHbsJ2z2mqKlkY33TgCCJ/vV9kzq5zkiwVi8sgI4stH4/lAW8UyMra6exE6poSzHkuNrLZ0RAtqnQmbVMS6ftdlct3qkFwjJU7Wl2q6sXS7in+WHZDdAZ/uYjUUxORbFUHmJ8A96rrLeJFyyxsXNWjIDkU3iAYZ4pTfPHQ1msNuELXwoRb1thmBLXKiIBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScAs+VpAkJG3QFC9H3C6iT1GfsxT0P8XqY9CvvF8lgY=;
 b=WssQl9MOvcp7cvW4eLwDEaAHdQ2BZsTQKiJ2tsPRPzwgAFQd95mWYdPT/F3VkxhJzIcidPQvQ6IhoHIbv67U3UVJRcQW0WVglU95Wv/Y/z1cHOOjkH0gPpjR58y49bMIg3YxU7EuqN8UpfnWiq3Xf1qXWZ2+XwU8ZBKuRJ2wCTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sun, 8 Dec
 2024 11:20:46 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Sun, 8 Dec 2024
 11:20:46 +0000
Message-ID: <adfaf37c-7b3b-2b4d-3543-a521c885b4bd@amd.com>
Date: Sun, 8 Dec 2024 11:20:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] resource: harden resource_contains
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com
References: <20241129091512.15661-1-alucerop@amd.com>
 <Z1DgXiqhclSRN4z0@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z1DgXiqhclSRN4z0@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6bb046-229d-4062-e959-08dd177a5c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVIxRlRDOVNySEIxNFI1T1ZXZTV0NXEyL0lBMDVyQXRoaUZZMkhjRk5jL2VP?=
 =?utf-8?B?VkNRNExCbFFDYzJIVC9WL0JhMWhTOGg4SUt6RUxkaXIrNFNxSFplMlRFcm9J?=
 =?utf-8?B?Qi9YNjNaeTdweXRMMUYvTDVpajJjVHcyaTZIUkVvRVJhalJ6WjBnOGJFR1Zr?=
 =?utf-8?B?MTRyVkZoVnRadFY2QU9yMnN6Umk0Ukx0NngxWnZUanpRM014UDJiQlljODBC?=
 =?utf-8?B?U2dtUEhmaE04alpBQlgveGJSTE1NYjdJRWhtSmdkd0NRNTFzR3VGOWdMalc5?=
 =?utf-8?B?WW9xTjdmZERaSDYyWk5vWnJxK29RbG1OakpPNmRrT3Axc2xraTlRcXZoUG45?=
 =?utf-8?B?a0ZCVVdsZDZ5OXJrVHJDcWxvZVlHN2dtU09GYnBDcjVMWU9tMlB5eXdMbHNx?=
 =?utf-8?B?RzNPRXpkdk9memFpcERhYVJabGpBMy9RRStuaVJFdTZCSlgyd2dmOWZua0lj?=
 =?utf-8?B?c3JYanJBL1hiUDVWeXBTNnZ5YVJnVmRidU0rbVJvME9mZDBEZ3N5djhBUHVB?=
 =?utf-8?B?MSswQlRiWFBELzFVN0VubkRGYmd3VEpIYUdLQXU2RzArVkZtT1Z0dzkxZVlS?=
 =?utf-8?B?SE9IOEY2YUFrejBRRzVSbGNJazhBeFh2eWNxNElRZWxLdWQxSlViR1E1TFVO?=
 =?utf-8?B?ZjlXS3lXRTlibHQ3WWN6ZktNb1JSdERkeGtmNDB4UHo3VUhoY204RHVoVlJL?=
 =?utf-8?B?MDlQYThSd2hpcTU2ajJmNGVzM0pBS2xmRWlQa3V0K0JDd0wwS1ZidkdNTksr?=
 =?utf-8?B?Y0ZxeWM1VkdsTmYzSWNjRzc1bVRWd0U5RXViMktQc1g4L2N0MEliQXAwRTZT?=
 =?utf-8?B?YS9BZ3hHZnpJN1FUbFJSc2gxaGwzSWFIUEMwQ1BOWGJSeUtUT2VaTmJ3c1Nq?=
 =?utf-8?B?WTl0Uld0ZmNBYmpUYWdhWi9xc3BQL012SzJZYWJINy9xTjAwRTZkME5VSXJ5?=
 =?utf-8?B?Z2NNZGp1dDc2STMvTFhiWDllelJaaElJNWVyQmZuek9DL2dKRjk0clRERDlR?=
 =?utf-8?B?cjZodUZMR09oRHJjWHBiVVpJRHh1UTM2cFFvSm1nQ3laNytQalNjUlNKajZX?=
 =?utf-8?B?NDI2cG5xQi91ejBIYUhsVW0xb0V2eG1LQjdBbXd1d2U4aHBpNzNXUVdsbEN0?=
 =?utf-8?B?T3kzRDYrZ2dyajR3d2Vha0ZNZmhGREhiczBkQkRmSUtCNHduRFNqc2pML3lL?=
 =?utf-8?B?Z2gxb3ZGQWoyRFdTZFRLVTZDYjVQTHFJZyt1NmFZcElaK2ZaWHVUL0xhbmJV?=
 =?utf-8?B?dEF1MGNlSXJCZmxFVGkzV1FxbE9aUGJQZWdreTVDY2tKd0hKajFFYmtDd1pK?=
 =?utf-8?B?VTZRRDJpZmZpMGZUV2R5YXB2MWhiWUFCTjJrSkVBMUNhYlZHMGhSYnppNkU0?=
 =?utf-8?B?M1dEOVV6N0xFRXRjU3hpSlcyZjJqZHRoL1cwcjVhVXg4TzB2aUsveDJEWEo0?=
 =?utf-8?B?czREU2N1ZXhPUmVmQmlwaFRvdWtoNytoNTJPbXcwN0pmNk5tR3Q2NXF5RHFv?=
 =?utf-8?B?YmM1Rjg4eG00OVFld2dHbDdYbFpWdVpWWnpKMURxcjBCZUduRlVTM1Vjd3FH?=
 =?utf-8?B?b0s0QnRtUURTUWZQczZFTzMvaGFtVnR1VzN3REZXbHlqYUFJWGJnejBlY3Ft?=
 =?utf-8?B?TUxaQTQwd05MaTVDM2hXQUN6d2xmUm1uby9QNDIrVmJaWDRDTG1kQUJncWsx?=
 =?utf-8?B?RkVERVhaRjhvakI0bk41TGpPckdiS0tPMlVJNmdzN0dVR1pDN29BTm5iRkVl?=
 =?utf-8?Q?nkA/2RLKWgPvaZ5qOoU7sf9gdqKNoUcDN6hWWjh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zytkdkt5NHNPdHI2N3RDYlN5TDJOZmpTTmprQmxGczN6SVplRDY3Q0xMdVhH?=
 =?utf-8?B?MHhDUkpITmdkcVgzbUZlQ1pJTHA0ZitTZVB0QmxzMEhSWEVUa3hiZ0E1WnFi?=
 =?utf-8?B?Z3FjbnUweFZ4RVhlMW5VVGM3NUF2WFM2MXdYaDF4NmN3d1FRMlZIUjJ5dnFW?=
 =?utf-8?B?WWpqczZ6YnZTMFhyVkZvSk95U29NN1VEakhzUXZhbWg0WS8vZTIxYzBlVzlN?=
 =?utf-8?B?RFZGdXZEMHV2TlJEaDZlblN5REtQdG00NTBHQkFacUlCM2l1eHpFZXhXdWEz?=
 =?utf-8?B?UCs1UmtTOXNFUzdKNU45dGQyaGFhUjhKYzJES2tMc2ZhSnhIbDRTUUJlWkNZ?=
 =?utf-8?B?U3JhWVR6TDBBZkZzUEFJdlZOVGNFckpiZHpSTCtlU3kzNUY5N1NyWEpKeHJj?=
 =?utf-8?B?aWNpTjFjY0RnanE0V1NnVmRxc2tiUU5kbVozT1lpdEFXa3A2eGZ1UlhZUVdH?=
 =?utf-8?B?TytTYkhrdkZYRWRCRWJTb2pGOEROSXFBdTBuUHV5bndWeHJaUHNEUE9MTGM3?=
 =?utf-8?B?TlFhd25qbDRqcUNGck5CL0pnQkc5SUJoKzU4aUxpY25kaUp1NTc2Tk5rWUJ4?=
 =?utf-8?B?dmxzQnlnN21BTDZGeU1rbUZaWDFBaUlqQ1BCVGFOZEJ0dmF4cVlYeHNxZHMz?=
 =?utf-8?B?cVE0UUNMYktzejY4UWhpY0hXaHZFN2MyM2Q2MWJlbDVXY3pZc1BROW9FbGJx?=
 =?utf-8?B?WE9jWU9qY0FtYk53aWc1Q2pyV0pCRWcrRThUaHRhaGRITmlOSVNOb0FPZ0ZH?=
 =?utf-8?B?RU55YTFnK1g1WUFzL3o2QWg5WTlJSlIxS0FnbGV6a0ZFY29zZ1d1VlRXanpZ?=
 =?utf-8?B?NytZQUNUMk01Skw4VmI3QWFMNGlUQ3hWTEhxMDdzM3Q2UmxjQlFXR3lBYzFk?=
 =?utf-8?B?OTZwMzNzZU95QW9GSGFDMVQ4Z3FKekd2V2pQaE1IeUJHLzhtWlNpQnUvTFBs?=
 =?utf-8?B?NWp5TWJpNXpUUFRtVmVLckU1V09lTWt2SG9oZnp2eGIzMGZxa2w2YUFsUklI?=
 =?utf-8?B?UVJmbVVublExcjBKYnBwNHBic2NFTEpvdTdvMEdSTmN3SkFrb3JwT0FyN2xJ?=
 =?utf-8?B?Y3hBZTJRRjBHUzFtTWlBNUpsQW1mN2lUWVJXdEhQVFhvUUZkTFljZElEUWdl?=
 =?utf-8?B?dm41Ykc1alp5aWExa2VKWWVLeEN6Y1F3MmRzejRxRXJEMjlsbVJabGdVR1Jk?=
 =?utf-8?B?VEVvTVFseUdYc0xHbTRxdk9CZEcvbGVieU9IWFpQVjkrRDc5b3pSYXNwbWh3?=
 =?utf-8?B?WWZnd1Z6Y01vUVBVSDAzRkpSVVlZb1ZBdzhybEFWRy9KV3dXT2dlZDFnMWNJ?=
 =?utf-8?B?bG1Rbmg5d2dqOEN2VHhoS3FoWitxZnIrMG1VR3EzQ3JBUU12bWMrQnJoSW5D?=
 =?utf-8?B?TmEzUk10WWE3NnJyTmlJSnJYRlVuOWNFa1BGaTBoS3dxeDlCSmVFMHhkOEc2?=
 =?utf-8?B?MnF6dklsWEJOZERqNzF4VGhyc1ZYNVVzMHJFM1gxRTMyWURpeHNwaENrREFY?=
 =?utf-8?B?VG0xRWVHeisvenR3aVR3UmJ1eiszb0RwbEY4Q0V6VXZkMjN2SG1OVHp1ZUtx?=
 =?utf-8?B?UCtoVHZZTGpLMDNDMzMzd3JaVWhZYWZlMzZiaXZGVkZiOHNvUHlJTGJyOFhu?=
 =?utf-8?B?cFlFL3hGN3o1MzVtZXMvV1Nua1l0SmMwRVBaN2s2ZDNyRm9PTXlPQ1hTN1ZO?=
 =?utf-8?B?L29Vc1pKVVAvWmVBK2pKby9YWXR6SkorYlRSWDR5TjRxaks2TmFmTEhjcnd6?=
 =?utf-8?B?dzd5L0ttQzRkelZCQmw5ZHhmMmRicVFRbU9WZk4wU0tqQzlRY3JONi9OSmZa?=
 =?utf-8?B?SVpQVUs4N1ZGQ01YUFFJTEZIM1ZoS2NkNElUOURtTVR3MS9yN0ljNVFDR3hw?=
 =?utf-8?B?SStUZFRnL1R1cGxrdjJSc1lrdGNvQlBzVE82TTBycGJyS0p2bSs0RGkvai9B?=
 =?utf-8?B?V1JYV3F0VElvZU9qUmxtYnpHRkN3UXlpRDFDU1Iva29GT215T1p2bHo2SXU3?=
 =?utf-8?B?SzJHblU0Uzk2NXo2SEU0VWUxd2V5R2gwajROUWpiekd4VFUzYzdsWlJQZ2Jp?=
 =?utf-8?B?UmRuWExGaEpJV0xGUmtMNFRYVGlxK1lhTWl3ZXRjV2xOUTFCSjhjOXFYdDd6?=
 =?utf-8?Q?KHhmuGfpvNAZK9XlCesF2zZ4y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6bb046-229d-4062-e959-08dd177a5c94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 11:20:46.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yk/RuCUz/A9AR0oGvoskq3L6/Ihe56im0o2CuyhfXWDyiupWT9HEcRtNAkm2ONs4NgdnW2WPCPsodQORmlgEVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203


On 12/4/24 23:06, Alison Schofield wrote:
> + linux-cxl
>
> On Fri, Nov 29, 2024 at 09:15:12AM +0000, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> While resource_contains checks for IORESOURCE_UNSET flag for the
>> resources given, if r1 was initialized with 0 size, the function
>> returns a false positive. This is so because resource start and
>> end fields are unsigned with end initialised to size - 1 by current
>> resource macros.
>>
>> Make the function to check for the resource size for both resources
>> since r2 with size 0 should not be considered as valid for the function
>> purpose.
>>
> Hi Alejandro,
>
> Can this patch be included in the CXL Type-2 patchset, as a replacement for:
>
> [PATCH v6 10/28] cxl: harden resource_contains checks to handle zero size resources
> https://lore.kernel.org/20241202171222.62595-11-alejandro.lucero-palau@amd.com/T/#u
>
> Keeping it in that set also keeps the discussion history.
>
> DaveJ may be able to take it through the CXL tree with Bjorn's ACK.


Sure. I'll do so in the almost ready v7.

>
> --Alison
>
>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>


Thank you


>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>> ---
>>   include/linux/ioport.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index 6e9fb667a1c5..6cb8a8494508 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -264,6 +264,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
>>   /* True iff r1 completely contains r2 */
>>   static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
>>   {
>> +	if (!resource_size(r1) || !resource_size(r2))
>> +		return false;
>>   	if (resource_type(r1) != resource_type(r2))
>>   		return false;
>>   	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
>> -- 
>> 2.17.1
>>

