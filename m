Return-Path: <linux-pci+bounces-41327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D13C62078
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 02:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F45B3B08FF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 01:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D91922FD;
	Mon, 17 Nov 2025 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AemkWRwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043C1F956;
	Mon, 17 Nov 2025 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763344190; cv=fail; b=QY4S/y4Vmkb8V7Sb1fsqQOs6lDD8pp+Rs7ewV8tVGaArGMHTPBPm/3CBEWgtLvSY07Hg39rydSDwTnoU5MXiXHk8PuYbVCe3oQkJHY48ySKeOggevUPiTxR7R/uSWWnkZCJNq+Frgz4UUWUwBFWADb5AsrxP6RKgnwvGk1qg+Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763344190; c=relaxed/simple;
	bh=1N2FOF68QDv6UBCNU6IOcBD4XJFjPOCryh8AzF617Tc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BjatkvZ8RUTrwFFTn6QOsdXXBGk4soSSGx1lAE3gdc9ihWBKlJFb0koR4jdgExHadu2ksnRacPdfu+4WUcJu9wl2ysO3bWoFm4hYgcN9yDu12tM33mw1rPZTEDmYQQvmxSQlRCfRWZunf2cSpIwbF52lJD8hNPg1KcapcNZD2vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AemkWRwq; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJC3FAIXFmK1uFO3NSyR8IGEucbiLESKza5obxkBFAAD8QymQQc8kGYy65HJh9Z11RxmY+esz1suPCjQUc9YfG2J6y4IuZjo8i4jx8lHLSdm+MGycm9OitaN90pSkGBU52xCnJsQloTrAea9pH1lCqgbB4ma+Wrmz1wKWr+0yLP4K7BiLD/jn5qs917/Gl70A+NNOiGVHIW+fM6n2Rdm5/nvExIa0qh70E2Vtmj3a48FsrqoSRD5UgOwFSrUywpijQeHaFuP6ugtPLc2nieSdt+qnVOwj4ohyhRWuDuWAlxWoDWF0IX66qLCHGVfnsn9kjhY9tMKmETuRJ+radOk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OyfJsFJ5xfkh9BncQsyToH4mFsr5PVKrYFyPwUExoI=;
 b=Q/g8b6wyzjr7TtUKo6T174xSXk49laxPCqVOf9iwVO9pjH3sTZYVZwCtw1036DWxql37jfREMIDd6VRuXueC0h9ZJDth8FRrtGqETOm38UCnzuJRjqfF4IRgzMpOQANRM5NjcI4vE0mKD7UlIsa4cRoQ+Jbu2EiTqzJONg+NCWQQ2RAiwxe7JAoNa7q3d67MK1T37Suf5V1Mbjr8CmDJDcZTaSEfwikT6RE5N3tGn53vI4rN/+WEjtJk9wTl13gkgZiqRCv213/jPtN/U9iu8VFA6qXK+9GqJTQ05D+8duUC0LSewN0RYhgMefmj68XmPIS5mgP+qNsglPqSiG7rEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OyfJsFJ5xfkh9BncQsyToH4mFsr5PVKrYFyPwUExoI=;
 b=AemkWRwqklmRfKdh1LRdXNPEVV1x1nXF5x0LnDHBSepSlJDjCjoLdePqInM8OUmJNsxbmAJKG2DvIoXDuZwu3jZKe7scrzuMzxuXRKtZNudayFBM580M9HBiPP9w3MGFumMtHWI3BfoW+q5k3AkZ0/L187fOa2OdGfzfzf9vYJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 01:49:45 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 01:49:45 +0000
Message-ID: <87e060b9-73d3-419a-834c-8c903f2d42c4@amd.com>
Date: Mon, 17 Nov 2025 12:49:27 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel 1/6] PCI/TSM: Add secure SPDM DOE mailbox
To: dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Ashish Kalra
 <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Eric Biggers <ebiggers@google.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Gary R Hook <gary.hook@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Kim Phillips <kim.phillips@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Michael Roth <michael.roth@amd.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, Gao Shiyuan <gaoshiyuan@baidu.com>,
 Sean Christopherson <seanjc@google.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev
References: <20251111063819.4098701-1-aik@amd.com>
 <20251111063819.4098701-2-aik@amd.com>
 <69168b145da7f_10154100fd@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <69168b145da7f_10154100fd@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0154.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 059fd07c-185d-4654-c6a8-08de257b95b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC9ZQ3Y4OWJERWlWYXUzT2owMHhQaW5Ob1NiSFF0RExZTm5BY0FXODlPVUJw?=
 =?utf-8?B?MzA2dng5bU5jYkRiT1RiL1BpTzJTRll0UlJYbloxcENxZENkYVV5bThOcS9t?=
 =?utf-8?B?aWZoVWd4Zm94VnlLOC9LVnlyNU83TUF1Mkg2dXBOaERzWTU1TUFMYURPUUhE?=
 =?utf-8?B?K1pFUHMxNVJKcFdMYzZBVHFQY1g2V3A2ZnhXOEZlUVJ3U3RuYmFMWmVNREV6?=
 =?utf-8?B?TVg1WFZwSVNNWlVkU3ZDQU1NUUdvbHJGTTdNR2h3Sk9CNkJiVnVBWmNFUFNB?=
 =?utf-8?B?UVJqeW9WRC9semtKbWhMZ25uY2l1eTBMUXM3azVlRmtEakppWjlLSkJQeEVS?=
 =?utf-8?B?ZGdwWS8waXo5U1VoOHFRSnRHcnRDZzAvYnE2VFpXUVlHMXpLYjlMaUpCSFMv?=
 =?utf-8?B?QjNNdWJmUHhoa1hVMFkwZ1RENjhWeENhSGVRQXNDdTBDa29Cb1hRUVFUN05s?=
 =?utf-8?B?WjF0V1ZoQ3crUkkzS3M0NS91SWRqdGhiQVBJVjNzRUhxNFdWOXY2WDRFY1h5?=
 =?utf-8?B?a2g0VklRcE55YjVHNW1peWY3ZC9mWkY3SUFqajJVa3lldGhjNDZ1Q0hkb0NK?=
 =?utf-8?B?Y1lRZDljWjNXYWtLN0wyRFJmcmlZSm9CY3hZWllOcFZTaFkzMlMyeG5Ubm1B?=
 =?utf-8?B?MkJrZ2pJZ2xnNG5xMENobjJyQUxJSk5CdTBNVHd4QVVMWVRvbEkwemFCaGsw?=
 =?utf-8?B?L0RXUW1acWdUc2NPcFg1ZS84NG01VDIyTVhuakR0a0dzbTA4Y2grQVgzUE44?=
 =?utf-8?B?UFFsbnZLem5wQWtmV3liZnErR29KYU9yQmVLQ3Ayc2ZBOWg3MlE1THNiRS8y?=
 =?utf-8?B?eXBNLzU1bmxjNG1XODdmVGZrRXE3dXZoeXpxUDRLcWtBVWFGLzZBTXpQUWFC?=
 =?utf-8?B?M1dHaldjVi9pcUdpVzJCaU5WMlpGTXB5TkRGRHl3QjIvYVQ0STBuUHFTaXJs?=
 =?utf-8?B?K3FzYnp0cmxYMnF1aTc1Ly9WZ1hsK0c1bEh1bklyazVkRllmc3ozbVF6WHpG?=
 =?utf-8?B?UER4aEQ0VkJWUmZHMXpIMUZUTytmdXZZclBFb0dOWERZLzlvbkFRWUs2Y3U1?=
 =?utf-8?B?aUVadlRoN2ZweTI2bitlUHhRQmRHZExQODVWRkpIajVGcnpMR3JQdzVmZmhq?=
 =?utf-8?B?Z29EUU9KU3RpUFEyeWRPZ3pQbytLR2JPMlp5c2ozM0FYbWtINmNxMSs0aUda?=
 =?utf-8?B?dFN0cXBNOGVmMHpWdkZFK3pXeExQYVdKNjh6STJnNlNaNzcrbnN1cjFLVjc2?=
 =?utf-8?B?T1o0TzFJNU93RXArNkFqRldVeDZMZDJIRlBIRnZGU0tkWmpVM3E4eVQyTklD?=
 =?utf-8?B?Smx5ZUp0V2xRYnorUDFVMWxYaTBGUWt1ZStqdFM3ZUZPcDF2czNxVjdHdElT?=
 =?utf-8?B?ZHRubncwaWZFTVI0dStoOVBIK3dXSkxMTloyQjViTDlKSWl1enVuNHlWREhP?=
 =?utf-8?B?WWR3c0U1eWVLdGdsYWNiMDVFbjZCRXB1dFFEN3A2azgyOElBVTFSVURLcXNa?=
 =?utf-8?B?MzZ5bmM2QzFEdXBvNjhVUDJoK3BRdXAxdlFQQUNSRkZNU05zcHVoampqNDFD?=
 =?utf-8?B?V29PM0tCT3pLdVlCTVFoRWNadU1lODRscW9iRG8vZkVEakJVWGNFMXhzdWt1?=
 =?utf-8?B?Sis3MXhFazJJMXJhcGlFL1c2NGs5a3E4NXBIYVdHR0hsUGpPNlp0Qm9teFc4?=
 =?utf-8?B?Ujg0Z3hHN25BN09HdU40cEJCRUlONDFGY0grY3YrSmVQalpUbmNHWDZKcWFl?=
 =?utf-8?B?ZXJvT0MwZE93am8vSUFab0R5c2J2R0pxcEw1Y09wR1poa2RFY0pTTGJEcS9j?=
 =?utf-8?B?dnJFdW1NLytLcE1yRGRLTDJLaDJzMm9uektCZTJQcnBTUlRFQWFQek5IMFdt?=
 =?utf-8?B?anZsaEliK1lIWnpyUmt6OFVvenNIUjBnV2JJZFpPdjdWeDZwa2lTbGJyYlVM?=
 =?utf-8?Q?3MOSp5D6llvR9noVOHWpD0cnkbdafnhf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk5yMTFLWWxrWW1ycjE2WWFNL1VXOCtkRHpDUEp6b0FkR2FqRWpZNHN6V3dC?=
 =?utf-8?B?bXZSeS9vY3hoU3MyMU8yWlEyb1pZOWtEOUYxUjljZ3pMS2MzcUVEeStmU3hQ?=
 =?utf-8?B?VWNRSzBkTkdOTTJCL2t0d0dsc1BxbjUxTkJUWTBZUkNoYlVSVVplUjljWWtY?=
 =?utf-8?B?dEJoT3I0U2haWHlkdW5FdzFEZXpHUnY5UllpRWF3MmxjMC83bGI1ZDJLYWxF?=
 =?utf-8?B?WHFlWnBlZ1pqWkJGOE9pMC8wbm9XbUpyNFh6M1ZVNjNLRElHNXU4bDJYaWRi?=
 =?utf-8?B?a1U2Z3BJalFlZUp1ZEJxaW5XRm5xVTlQdTczN0hVakY1QitMOGErNTNMN3E2?=
 =?utf-8?B?YUJkd3lSaGhNU1Zwb2JQeHRLTHg2cEFHdEFGMU5Nb1czWVVjSCtWeTBENDRu?=
 =?utf-8?B?L09PelFCaWwvTmRtRDZQRHJPTWF2Qnp4VkhRWmk1c2R0TmwyVTJiK0lCbG11?=
 =?utf-8?B?aEV6aXl3TXBpWHpLVFlWOFV6RUtpMjlEc3g3K05CNmg1VlIxcXVKR0FzMFdl?=
 =?utf-8?B?aG1UMjZoSDVvdXdEUnF1dlkzalBVbElPVlVVS2tvS28rbXc4WFAwSVNpU0xD?=
 =?utf-8?B?TkFiYjFEc3RqNUtNandlSmRvKy9ZU050VXRyazI1WjZURHN0LyszeFdwUjM1?=
 =?utf-8?B?blRnYmk3QmRkVnFJajVWaUlNSWJoQzFqclRqS3N1RDM2UGRsd0NhQ3JLcm5R?=
 =?utf-8?B?ZlhpUHNtNUEvekNPRklmelBCVHl5SFk0YkF0MnM2NHcyTmRJWVpPWkN4UHE2?=
 =?utf-8?B?R3o4WERxOWNiZjRseGNUNVM1QVl5Z2ZXZVBOTHordHRsTGFET3VURFY4SHBM?=
 =?utf-8?B?N0xxNGloaG1abWxFbXdtVGFrclN1M3NYM0ZmRXk4T1VHalZRUlQzQWpSSk9p?=
 =?utf-8?B?dnJqRE1ydFprdkF4TkhUSFZpdHZJVThVZlhsVVk2UUloV3lncXR1SVVJaHlq?=
 =?utf-8?B?U2UyMmdXd0NmMHFJR1ZZUWVHQi93ZXM0dlVtM2l3VHYyQnQvNGI0NEE1WXUv?=
 =?utf-8?B?QVlUSkVKM0NBN2dSbzBUK0J4Y3dGWGw0QjBFSmxneHFDUXdnZVZqM242ZXZI?=
 =?utf-8?B?ZGFkV1dnVjByUnJ1SkoydlBVQnZkYzVodytqMlVITXdIQjZ4bFNjNnpMem92?=
 =?utf-8?B?ME5WdkRuRlZHUkw2NW5WY3hJYm9BQ0dBQkF4MmM1VHBiWElId3dHSGJsMFp0?=
 =?utf-8?B?MmwvQ0NUWHhTOEEzVC9xVElRYUNIU1BzM2w4bG1kbXpCMFB4eFY0bm9UL0VC?=
 =?utf-8?B?a2hmVHhoMzQyTDh3Z0VsRVdIOGpkRGNSYjJmZUdKWVNHQWJTYi9BOGtRYVZ5?=
 =?utf-8?B?TU1pbEdRRk4yS0F5b1hFUGlpN0U0eDlOWm9IQU1aVkZZcEhYaC8zYUZwNHBl?=
 =?utf-8?B?M1JUeUxHZ1FDUkpEN3c2UXVWTjlvdmxFUnZlQjMyTHd1UkZ4V0dmbFNWVFNJ?=
 =?utf-8?B?WGU4aW5iakhMQlFMNmZJM3B4T2tHZTZiUTMzblIyd1VDRGs2a2JGNk5KV3FV?=
 =?utf-8?B?aDNva2hvTU81aXM0OXIxZWNOTmpPZmMxbVZwRGdhTGxmbHlpQ1lrb3ZvRG9W?=
 =?utf-8?B?UG01alZZMm83S3lGWWlBK1NocVRwQVZnZ1NUQ2FFU015RTBFWFV6SWRETS9h?=
 =?utf-8?B?UVNEM1R1SkJTRTk4aXVMc2FFZGg1QWJSbXZTTnB2Y2hGQzE3NU5aOHVUcEpx?=
 =?utf-8?B?eklmTmcxQWdob243T1pMYk0zM29OK2NEdm5KbDhqdXFvQVBFL0dreU41YlVZ?=
 =?utf-8?B?bG9yaXVJd0ZCV2hIK1RyY1NvdE1WUFBRN0k1MW5xYTJ0NEl4NXpPaUFjelJV?=
 =?utf-8?B?cmtzd3pjMHN5MDVza1FNS2ZUbS9iSnRtUzRRUElHWnloUCtyV3pxU2RBQzJk?=
 =?utf-8?B?OUFwS1FUZ1grbUMwaEgrMzQwOE1ZRkFMRmtaRFJtMDNMdkZZa2poaGhyQUEz?=
 =?utf-8?B?MTk4d1B5VGVxdmNmT01lU2d0OHlwdlQwRHJYWGlvclNQM1MrbXVhV0VSNlcy?=
 =?utf-8?B?V2QxcUNIWEJtNUVvRFBsb0U3eDVab1JCLzNVL3ZneFQxcEJ2YWpoU3p6WFlX?=
 =?utf-8?B?VE1jUXFybHFpT2VzU3RZMU1WdzhJekJPTGVsRGpoVkhvb2RXVXVxVUpBSkpx?=
 =?utf-8?Q?Zu5uUYuI6mOC12+GBzoWm07rT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059fd07c-185d-4654-c6a8-08de257b95b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 01:49:45.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsZvMxj+zvAaX4ae7UqK5bgef5yKJxSKnx7H6Syz22LHln8ld3DCoGqz7pP5wzvV+VajdHi5KOXjrRoGELO2Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817



On 14/11/25 12:51, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
>> The IDE key programming happens via Secure SPDM channel, initialise it
>> at the PF0 probing.
>>
>> Add the SPDM certificate slot (up to 8 are allowed by SPDM), the platform
>> is expected to select one.
>>
>> While at this, add a common struct for SPDM request/response as these
>> are going to needed by every platform.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>
>> (!tsm->doe_mb_sec) is definitely an error on AMD SEV-TIO, is not it on other platforms?
> 
> I think you just happen to have a multi-DOE test device, or a device
> that has a PCI_DOE_FEATURE_SSESSION DOE and not a PCI_DOE_FEATURE_CMA
> DOE.
> 
>> ---
>>   include/linux/pci-tsm.h | 14 ++++++++++++++
>>   drivers/pci/tsm.c       |  4 ++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
>> index 40c5e4c31a3f..b6866f7c14b4 100644
>> --- a/include/linux/pci-tsm.h
>> +++ b/include/linux/pci-tsm.h
>> @@ -10,6 +10,14 @@ struct tsm_dev;
>>   struct kvm;
>>   enum pci_tsm_req_scope;
>>   
>> +/* SPDM control structure for DOE */
>> +struct tsm_spdm {
>> +	unsigned long req_len;
>> +	void *req;
>> +	unsigned long rsp_len;
>> +	void *rsp;
>> +};
> 
> I would only add things to the core that the core needs, or all
> implementations can unify. You can see that tdx_spdm_msg_exchange() can
> not use this common definition for example.


Oh I missed that we have tdx_spdm_msg_exchange() now, cool :)

>> +
>>   /*
>>    * struct pci_tsm_ops - manage confidential links and security state
>>    * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
>> @@ -130,11 +138,17 @@ struct pci_tsm {
>>    * @base_tsm: generic core "tsm" context
>>    * @lock: mutual exclustion for pci_tsm_ops invocation
>>    * @doe_mb: PCIe Data Object Exchange mailbox
>> + * @doe_mb_sec: DOE mailbox used when secured SPDM is requested
>> + * @spdm: cached SPDM request/response buffers for the link
>> + * @cert_slot: SPDM certificate slot
>>    */
>>   struct pci_tsm_pf0 {
>>   	struct pci_tsm base_tsm;
>>   	struct mutex lock;
>>   	struct pci_doe_mb *doe_mb;
>> +	struct pci_doe_mb *doe_mb_sec;
> 
> See below, pci_tsm_pf0 should only ever need one doe_mb instance.
> 
>> +	struct tsm_spdm spdm;
> 
> Per above, just move @tsm_spdm into the TIO object that wraps
> pci_tsm_pf0.

Sure, can do that.

>> +	u8 cert_slot;
>>   };
>>   
>>   struct pci_tsm_mmio {
>> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
>> index ed8a280a2cf4..378748b15825 100644
>> --- a/drivers/pci/tsm.c
>> +++ b/drivers/pci/tsm.c
>> @@ -1067,6 +1067,10 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
>>   		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
>>   		return -ENODEV;
>>   	}
>> +	tsm->doe_mb_sec = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
>> +					       PCI_DOE_FEATURE_SSESSION);
>> +	if (!tsm->doe_mb_sec)
>> +		pci_warn(pdev, "TSM init failed to init SSESSION mailbox\n");
> 
> So it is surprising to find that a device supports PCI_DOE_FEATURE_CMA,
> but requires the TSM to also use the PCI_DOE_FEATURE_SSESSION mailbox?
> A PCI_DOE_FEATURE_CMA mailbox is capable of supporting secure sessions
> and IDE.

What does guarantee that CMA supports SSESSION?

> When a device supports multiple DOE, the VMM does need to pick one, but the
> hope was that "first CMA DOE" would work, but apparently you have a
> device that wants to violate this simple heuristic?
> 
> What happens on this device if you use the CMA mailbox for IDE
> establishment and secure sessions?

Nah, my devices have one DOE cap with 3 protocols supported, I just did not see any good reason to limit ourselves to one DOE MB. We will either have to BUG_ON on DOE MB which does CMA but does not do SSESSION, or just have 2 struct doe_mb pointers. Thanks,


-- 
Alexey


