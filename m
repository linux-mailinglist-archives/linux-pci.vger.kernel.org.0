Return-Path: <linux-pci+bounces-12028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AF695BB27
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 17:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D681F256B4
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0E1CB147;
	Thu, 22 Aug 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vDGPo+JJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF41CB33A;
	Thu, 22 Aug 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342200; cv=fail; b=ui0ks9If6kmYACS6VDGBnhtb4+CzEpUy0opjA7wrs4FacEFqXpcu6RNTfRvkK4bbHDrEWYEW3mCG8bdr0ela0TiCf2IYH9WSqT1mijZB6mI0KkSeEa/UPG8F/S/QBXxf5+oKubBLEjtPHDTdVwrgRuR8j2WL0tLGndNIaz7TpwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342200; c=relaxed/simple;
	bh=FWQVHfNe7CLQ2uW6Dn8V15lYIfjRKXcv4PRZ7jlzpKY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SIsEXoCxNXgJhrlqqkN+L/wkIdsoFISMXroCbE1NBVhWC0bR0WwICYOF+qhov5uVnENsE6lmkNJ526NlXjxpmPzpDc6IEfY+Fj4VlG7+yPZ1YpENBVLTnwm2olRdBw50xEqSJvCObdIPeQrLvkTwZpTNdKUIPrfYKWa+0kY4i5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vDGPo+JJ; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfy3a9Z0ZY5ejg39Nt/hF6VK8ynygwGE5jsR4himL245Pa+sdk2DTCMW736UiCUwaKRlYR5DqMuEDAVFg27KEutROLzF45EqX6YH2AYecO2rCbF9VeuchsL3dyVCm6627k/IfO+1XORhIuIGRIbOPWFCMcpV1um5oUt9KG4R7+STfT7qFqOr93EBkDiVYbLKcKXhhBuAZtJMPRHm98YcgQMr3T5vD09L/SkSCF6ioA/dSe9fsdxWswQwLiU4xzj3jeuX9DBqK1TOm0iSBqunw7Uxc1ROTq9lAousJRxuXCoPKZS72Y1vPo7jwUVl2S09L5ve7xKsBcdUe/S37uQJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akfc+RwRmY9i9NyVWHGo6wLRIhVcXFQxjGhiSkFanA4=;
 b=b62IDHDWj2cOHrn/Dgr1qMoLpwflD49PfvNKR64VjyFY0mOS/v6fCk/trWhsEoAohez6HLXDU0NADMeY5Yj34jDgUoVBbDoerRl+/XsJpnV/q4BEGXkbjNfsqY9r2ZkzpZTlzy6iAdXHFdJzXsYoK2Ejrz0fowOLvW6HuMh0IG508he52NskzaTalu9la9TJdS8e1PcZ4WCJCDDTqbogqxdIxtMG7GkoA0SRi/V0O9TOvLoPjM0opwQiMUhLo6TLT0HdCye2+0cxa+90EmONQAydR0qetHItwPEjZjRGD3TaRYdd2Z6x2g7hivfVI2p5tOTxvzmfnKGpN3aUsdfQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akfc+RwRmY9i9NyVWHGo6wLRIhVcXFQxjGhiSkFanA4=;
 b=vDGPo+JJYcNsvloJDqIa75cF45jUJ3x/8AD9dcrLiqi0JWicgH7A6K7Bej2xkyAbhTZFEfQB/xdImKvlduLZeJYuXNSkg1dNcFCRSl0l6yu3zrrgzhd7rokKhRQ7zmWHTZAp5O6NFGDU56SJYBLca7rxIUK0vx9EJOG96F/vqSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 15:56:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Thu, 22 Aug 2024
 15:56:34 +0000
Message-ID: <54feb448-b8b9-49ca-bf29-02b9884c048c@amd.com>
Date: Thu, 22 Aug 2024 10:56:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Detect and trust built-in Thunderbolt chips
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, iommu@lists.linux.dev,
 Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org>
 <6da512d2-464d-40fa-9d05-02928246ddba@amd.com>
 <20240822155329.GI1532424@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240822155329.GI1532424@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:806:120::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: c8032cc6-cdca-4783-d4e1-08dcc2c2ff7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDNzajczSlNXaHpyQ2kyc0ZHMDhkVkdSdjQ0YXIwVkU4QUc3UWtOa2lUeU0w?=
 =?utf-8?B?cVdVWm01WThrK0t3WTA3Q21lZWpZY05pbVh6YW5OeG10c3JPTkNBc0c4M0lw?=
 =?utf-8?B?TWE2cUNWUEw4V2ZjVG0zbTlRV000M3AvdThBOWc2UGo1dmk2MmZ5QnRySHNx?=
 =?utf-8?B?OWVQTGlQVEhhWlpwd2cwRnFQTkdJckxmS2dyRGZCL0xnckJLR2RQb3E1K2Vh?=
 =?utf-8?B?aGFBR0pJdloreEd4b29LdGRiSmhSN1RmYTZ5VkpRQkZQR3pmVHNrbXBkWk1C?=
 =?utf-8?B?bGppSitPanV4SXFKMU55RUZEdHVEdUw3R0lVblpKQ25HcDZRZk00YmVraHZ0?=
 =?utf-8?B?emRId2lIemVwVi9Ba2RtbjVhT2VsbEhnMEZwL0JHenErUGpGbm41RHJvV0tI?=
 =?utf-8?B?cDZ2ZHdQNVVSMVVtN1VXT2dkYlUzN3dVcnZhVklCT0RCTENxTDlRQ1pzczZt?=
 =?utf-8?B?NzUvUG15VnArU041YSs5T3h6QXpFbkZEU2I2TEprR0YyREVGLzAwUzNDSDJN?=
 =?utf-8?B?NmdXcXQwNmhFMWpGamZVSlF1ZzBRUHdwSmRmcStXdmx1ZFJ4akRFeWUrbGJV?=
 =?utf-8?B?U0wvNFBDeEVGRDFueDdldG1zQnpWTUVscnhnMWtLZDRtQ3dXRUFUakpnR0k5?=
 =?utf-8?B?WlZ4a0ZZdVdiM0FCb2VsRTJoZld0VEpOT2xqUUZLdjExY3RJaXNZSi80Yk9x?=
 =?utf-8?B?SEQ4UGRHelpkNEt5bU5jTVV1dDlZeTVpa1l4MmRNbzRQc25UNitiV0hPYUxj?=
 =?utf-8?B?cll3bU81R1cxbGJJdjl4dEQ4SlZKVEc4WHlOY0NOQUlwV0tON3NLZjhCQmtV?=
 =?utf-8?B?ejVYWGJVbFZPRXVRVjkydU9nVmJLVUZCcys5S1FHYThjMzNOYU12b2h5VFRT?=
 =?utf-8?B?alhsV29Wb1Z6NTQ2RWpIMHNnUUo0MENKcmluZnlvcTdlR3Qwak43bzhEdW5T?=
 =?utf-8?B?SGovbkdzeXlZajNMbVYyMmxTMmNFS2U5UWVWL0g3Znd4SGdlV1I4MWJXaUZh?=
 =?utf-8?B?V1dDMjJwZ085VTNJQXFva2hZbUZUbHJwUWdZU1VlM1R6SWZ1d1VPbkhwcHBv?=
 =?utf-8?B?Vzd0emdtUnp1UkUvSHpPenRQNG9qajJlVjlOOU1xWjRpNVR5Tm5FMTRHK253?=
 =?utf-8?B?blRZajEvR3Arb0lBclE3MFEzNDY2TE5XVTlzQVh6K3hGUW0zNzJYeTNGQWpF?=
 =?utf-8?B?akJxQzFwQ2pKNTQxTFY2VmhuS29LcjJWQmN4YUYyRnZGTFBPYVVLYUtwaU4y?=
 =?utf-8?B?NFJDYzdoSWduZVJ0bFM1STQybDlTMkkxR3ZtOVFjTEFIUllLOXJUbjdQWjdQ?=
 =?utf-8?B?TzVDbUpXRnVxS2h5UHNIT1JQK2tjTjhjMFQ3NG9MQjJRRVFHRldDRk9IeW9u?=
 =?utf-8?B?dUgvN0FQYjhUVW5jRVVVaEFVbEYvTUJUSzlWejdBUUxRTUx2L3I2SU5ncG5n?=
 =?utf-8?B?blF5VndqNzRWSVlYVW5HRHlFOGd3MEpJU21xcGgrMDdSTlZJcDZHZFFWMUxU?=
 =?utf-8?B?NmwzS2k0c0R5bEFUbGl0ZXQvTlVZSlQvbDVJYnkxZEx2L0hwdldyYnB5RytP?=
 =?utf-8?B?WHFpdFZCTm83TE9ja0U2V1J3V3ZXNHp6bEVseG9iZXlPRDdZNGpTMGR5Mm12?=
 =?utf-8?B?WFV4d1dNVDZPZWhpNG5EcThRQ2Y1VlRqQlV6N0c2VHNLZktkeGpBeXFodmdK?=
 =?utf-8?B?NTNadHZpa2VpaTRWQTFNNXlFOFZvVE5sOGoyM0JQUUkyVXA2aWFCeHBQOGRu?=
 =?utf-8?Q?DPFhB1xAz44U6QOVFvg6oy7RMdlSwl5y9ELo4AN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXVkNlIwZUFBekFwZjNUTGhxcWNrakRGdWxLcEJQZjRueTNRNk1vYmJiaTJT?=
 =?utf-8?B?WFpackJheEN3RldtTE9odkdGT1BNZkNGdWpWYzhMUGdReHh6bGhLMHVyUnUy?=
 =?utf-8?B?VUNQcURCRitZdi9reHo3dC9SUVlSZG1uWnpCRmUxc1E4eGhTbWhrY2EyR0Vv?=
 =?utf-8?B?TXFsamNoVE9TN2FQeUhtWG5ULzFnZklWZHQrTkpuSWxseHNqcTUvQzFzaDNi?=
 =?utf-8?B?clg1VzRQVXI1bmh0MEZFYVVleVdoL0RkVHNsSzZmVTUvN1hrMTFSWlFQKzRw?=
 =?utf-8?B?c1pubG1CcDZ4dWQ3Q0F1TFhCWGlKYTROdW96UGlHQVhma2JRY3k3d1J5OXN4?=
 =?utf-8?B?M1Zuc0dBV29CUllOL2FYUHNGTkpva0FHREEwWGxjWjBnSk5lTUh4NzZpKyt5?=
 =?utf-8?B?bzdySWsreER5YU5iNzErNmtWUWtHQXd1dmtHS2kwNittNVYxSjZDc2JPa2pT?=
 =?utf-8?B?Nm1VSFBkNEgvd2Z0b3A3ZUJkNGtFUlRIazVqZytKUkY1M2VDcjJHeWZmYVp4?=
 =?utf-8?B?MTkvYVRhM2pwL1R6TkhHKzhFbktQcktPL2N4aTJTQWdRd3QyK0pMZjMxUkJO?=
 =?utf-8?B?R1pWWEJ2UmgwS0JEdXpBS0VRdEdRTGZsWjZtZzZEWWdqcWNqeU8rZ1V4YW1u?=
 =?utf-8?B?NThncUUzUnI0UjBUTDUzQjNlVko5OGNwRjE5aDFvMisvM1JUSnhsaW40UTJQ?=
 =?utf-8?B?eG5PZ29QY0JEK0R1eExYZFVBMW9Sc1JhT2JyeGdvV3I0UHFpM1NoZDVHTk5Z?=
 =?utf-8?B?QXZHQlZDdjZUczBUeE9meXU0MTdWTm1EUjFLaGw0YTczckZhK1BGeC9zTjI2?=
 =?utf-8?B?a1hiYWlGQ1VsL1UwclExaXhwRk93aEVpaUo4NTVydHNYSm1ucW90TThIdlZ4?=
 =?utf-8?B?S1F1VlNJQVh4Y0pxQzhSSm9qc1dDck4yOTFUZG9vNTZ1UmVHRm8vTFZjNkFq?=
 =?utf-8?B?b0VqNDRCa3N3cVFjWVlxVUQzWnpyc2EydXlHOWdGK3A2bGdWd2hwU0tCZmZv?=
 =?utf-8?B?Uy9ORlhUemlGRmFLbk5pY2x5UXByNE5Oak1DSGhrdnp0UmVUOXRCM2F5bXNT?=
 =?utf-8?B?T0kxczdFV2M5RnlKY3JFbGs5Q0RtVHBYSmhhQ0xPZXF3UWh0ZUNWcTBRcXVZ?=
 =?utf-8?B?UU5oMWJ3dlIvWFJZai9MVG53MzNtQnM0SXlWNXdwYjFRUkc3RkE1eVdNZ0R4?=
 =?utf-8?B?ek1Bbkh5NXl2NDFqckkyeUxQeVpUVVlDMmtETWVCYmpWTDFYNUI3eGNCcFFr?=
 =?utf-8?B?UGlRRWtncWp5L0tMWlJ6N1UzUSs2Vlk4KzFqcWRWSG9uNy9CLzAyalZwQU14?=
 =?utf-8?B?Rk43bkFwMVVLY056L0x0NklkQURaQi84b3Q5VGtsZnVRMjhpblNUSlhsd2JB?=
 =?utf-8?B?eTd4RHRQa2dLK0N2N3JhZmZsR1RBTWo4TXJ2djNVOU9rcTdNd00vL2g1ZkRT?=
 =?utf-8?B?QkhyTThNZDV4T1pWNWE2NDVNM1VXblcvUlV1am1hODJBZ3p5MWdmTHdvalkr?=
 =?utf-8?B?bklMNktiSnhpamRUeHVQTmNqdFF3OFZvNmZLcnVmY3Q0WVNvbEJ4SEFTUndB?=
 =?utf-8?B?bi85SHdHalh6K21aVEF1am5jSmpOeTFUcFhvRThUbmdTRExFZlZoRXprZkpW?=
 =?utf-8?B?N3U0Rlp4ODlQamp6Y21uOHdDbGlBdXdyOWhXV3UvOUxUL3cvUUVRRVFyQml3?=
 =?utf-8?B?NnRUb0UvTFZXSTRWeXdBUXkrREFaNUZ0clU3NldRNDhUVnJjajJSL2tmZzNB?=
 =?utf-8?B?Z1pYWURaeURzZ1J5MEN2aWl3RUlnOHV2c2NaUlpiMzFzazUyZlF2QzNXNWxX?=
 =?utf-8?B?djRFQTNJdUhyaE9VeTdadkZNT0R4VTIxd2ZHRUl1RkxONUVobmpORmlJdWFV?=
 =?utf-8?B?RmpJVDNHcWE5TGoyTnBEbHF1cEY2cmJSRVphdzR3TTFXV3gxN3ZYWTdHb1V1?=
 =?utf-8?B?ak15OTdjUHZnMURRSFFuTDNoSlJpUnh1TzYxYnF5N05WUmtscWhPQUh1MlQ0?=
 =?utf-8?B?bFBFeEZnMlZ2RUJ2Z2tYOWNvRVorQ1lQTWliakhnK0hVZ0FhSEcrTTZWWTNT?=
 =?utf-8?B?Y0pDUkRHY240Z0lEOE0zTzUvRGNaUHR5Y1lNNktveWxLeVZpNFlnU1BxNkc4?=
 =?utf-8?Q?ZMCAVtK5VN3GhJkvW/3z1Zb/j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8032cc6-cdca-4783-d4e1-08dcc2c2ff7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 15:56:34.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +74aUJjiBsWJpac7K9xDleRB25KQOlcq+VC8MVX726qEoqoSP456tXV+g8753GfO0w7jgNNMVLbI8hAJ5DDtlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

On 8/22/2024 10:53, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Aug 22, 2024 at 10:29:55AM -0500, Mario Limonciello wrote:
>> On 8/15/2024 14:07, Esther Shimanovich wrote:
>>> Some computers with CPUs that lack Thunderbolt features use discrete
>>> Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
>>> chips are located within the chassis; between the root port labeled
>>> ExternalFacingPort and the USB-C port.
>>>
>>> These Thunderbolt PCIe devices should be labeled as fixed and trusted,
>>> as they are built into the computer. Otherwise, security policies that
>>> rely on those flags may have unintended results, such as preventing
>>> USB-C ports from enumerating.
>>>
>>> Detect the above scenario through the process of elimination.
>>>
>>> 1) Integrated Thunderbolt host controllers already have Thunderbolt
>>>      implemented, so anything outside their external facing root port is
>>>      removable and untrusted.
>>>
>>>      Detect them using the following properties:
>>>
>>>        - Most integrated host controllers have the usb4-host-interface
>>>          ACPI property, as described here:
>>> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
>>>
>>>        - Integrated Thunderbolt PCIe root ports before Alder Lake do not
>>>          have the usb4-host-interface ACPI property. Identify those with
>>>          their PCI IDs instead.
>>>
>>> 2) If a root port does not have integrated Thunderbolt capabilities, but
>>>      has the ExternalFacingPort ACPI property, that means the manufacturer
>>>      has opted to use a discrete Thunderbolt host controller that is
>>>      built into the computer.
>>>
>>>      This host controller can be identified by virtue of being located
>>>      directly below an external-facing root port that lacks integrated
>>>      Thunderbolt. Label it as trusted and fixed.
>>>
>>>      Everything downstream from it is untrusted and removable.
>>>
>>> The ExternalFacingPort ACPI property is described here:
>>> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
>>>
>>> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
>>> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> ---
>>> While working with devices that have discrete Thunderbolt chips, I
>>> noticed that their internal TBT chips are inaccurately labeled as
>>> untrusted and removable.
>>>
>>> I've observed that this issue impacts all computers with internal,
>>> discrete Intel JHL Thunderbolt chips, such as JHL6240, JHL6340, JHL6540,
>>> and JHL7540, across multiple device manufacturers such as Lenovo, Dell,
>>> and HP.
>>>
>>> This affects the execution of any downstream security policy that
>>> relies on the "untrusted" or "removable" flags.
>>>
>>> I initially submitted a quirk to resolve this, which was too small in
>>> scope, and after some discussion, Mika proposed a more thorough fix:
>>> https://lore.kernel.org/lkml/20240510052616.GC4162345@black.fi.intel.com
>>> I refactored it and am submitting as a new patch.
>>
>> My apologies on my delayed response, I've been OOO a while.
>>
>> I had a test with this patch on an AMD Phoenix system on top of 6.11-rc4.  I
>> am noticing that with it, it's now flagging an internal PCI host bridge as
>> untrusted.  I added some extra debugging and it falls through to the last
>> case of pcie_is_tunneled() where it returns true.
>>
>> Here is the topology of the system:
>>
>> -[0000:00]-+-00.0
>>             +-00.2
>>             +-01.0
>>             +-01.3-[01]----00.0
>>             +-02.0
>>             +-02.1-[02]----00.0
>>             +-02.4-[03]----00.0
>>             +-03.0
>>             +-03.1-[04-62]--
>>             +-04.0
>>             +-04.1-[63-c1]--
>>             +-08.0
>>             +-08.1-[c2]--+-00.0
>>             |            +-00.1
>>             |            +-00.2
>>             |            +-00.3
>>             |            +-00.4
>>             |            +-00.5
>>             |            +-00.6
>>             |            \-00.7
>>             +-08.2-[c3]--+-00.0
>>             |            \-00.1
>>             +-08.3-[c4]--+-00.0
>>             |            +-00.3
>>             |            +-00.4
>>             |            +-00.5
>>             |            \-00.6
>>             +-14.0
>>             +-14.3
>>             +-18.0
>>             +-18.1
>>             +-18.2
>>             +-18.3
>>             +-18.4
>>             +-18.5
>>             +-18.6
>>             \-18.7
>>
>> Here are the details of all devices on the system:
>>
>> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14e8]
>> 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Device [1022:14e9]
>> 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14ea]
>> 00:01.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14ee]
>> 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14ea]
>> 00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14ee]
>> 00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14ee]
>> 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14ea]
>> 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 19h
>> USB4/Thunderbolt PCIe tunnel [1022:14ef]
>> 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14ea]
>> 00:04.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 19h
>> USB4/Thunderbolt PCIe tunnel [1022:14ef]
>> 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14ea]
>> 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14eb]
>> 00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14eb]
>> 00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14eb]
>> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus
>> Controller [1022:790b] (rev 71)
>> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
>> [1022:790e] (rev 51)
>> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14f0]
>> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14f1]
>> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14f2]
>> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14f3]
>> 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14f4]
>> 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14f5]
>> 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14f6]
>> 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:14f7]
>> 01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
>> RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
>> (rev 1c)
>> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5261 PCI
>> Express Card Reader [10ec:5261] (rev 01)
>> 03:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd
>> NVMe SSD Controller PM9A1/PM9A3/980PRO [144d:a80a]
>> c2:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
>> [AMD/ATI] Phoenix1 [1002:15bf] (rev 03)
>> c2:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI]
>> Rembrandt Radeon High Definition Audio Controller [1002:1640]
>> c2:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD]
>> Family 19h (Model 74h) CCP/PSP 3.0 Device [1022:15c7]
>> c2:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:15b9]
>> c2:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:15ba]
>> c2:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD]
>> ACP/ACP3X/ACP6x Audio Coprocessor [1022:15e2] (rev 63)
>> c2:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Family
>> 17h/19h HD Audio Controller [1022:15e3]
>> c2:00.7 Signal processing controller [1180]: Advanced Micro Devices, Inc.
>> [AMD] Device [1022:164a]
>> c3:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc.
>> [AMD] Device [1022:14ec]
>> c3:00.1 Signal processing controller [1180]: Advanced Micro Devices, Inc.
>> [AMD] AMD IPU Device [1022:1502]
>> c4:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc.
>> [AMD] Device [1022:14ec]
>> c4:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:15c0]
>> c4:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device
>> [1022:15c1]
>> c4:00.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Pink
>> Sardine USB4/Thunderbolt NHI controller #1 [1022:1668]
>> c4:00.6 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Pink
>> Sardine USB4/Thunderbolt NHI controller #2 [1022:1669]
>>
>> Here's the snippet from the kernel log with the patch in place.  You can see
>> it flagged 00:02.0 as untrusted and removable, but it definitely isn't.
> 
> Is it marked as ExternalFacingPort in the ACPI tables?

No; it doesn't have an ACPI companion device.

