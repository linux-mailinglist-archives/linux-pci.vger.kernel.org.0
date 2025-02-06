Return-Path: <linux-pci+bounces-20801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C3A2AA0A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840103A6A02
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9861EA7C3;
	Thu,  6 Feb 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dD2l+EZd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ll+MI9vg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EABE1EA7D4
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848781; cv=fail; b=t5r4rEOyKDwRK4kXNrF9Ey7AXs0jgpehrWqk32JigDpiZLyRF2xmpSClKRLgOdYfdNF4RZoA97xddldpE7qYnLFNnXWZpL7/K+xmgJVHt9MK9OQiRsdk00ceAKL4Im1Uf3eAOrV3TVRcj2OGARCy7IdCPEcdbFjEdrLlyR5NNJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848781; c=relaxed/simple;
	bh=pymdvlxP7CyKQQmZMpkbIxgk/SG0ApL1CiQtFf+ZgVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AoMtR+P+eZhsbG3vlK/WqnXqccxcTOrBkMXTXkO2b7/8IZlrHZpqtYPoOvTr254oZoi5wm3jn1qyrGycnYBCT1kFGch76NXXDWq94ZMc7Z8GmrK94U1kjvZlWIHDnIrTbLMFMOZjnBcf3KtSVywboYDYlArQw//YTEnKtBocoN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dD2l+EZd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ll+MI9vg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5166AuEd031571;
	Thu, 6 Feb 2025 13:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=E+Vt/VwbdOeF9VNB+Fdk4a/KSZsedip6O8hOslQ9idI=; b=
	dD2l+EZdjiLMcDbAlaIq7VadH+9Zs1NahX0Cuk2uKwRe6EBDGmp0rymU4BqoirEB
	0lDr41+u4oWArm1nSoBhJvaYqgqtTH6ewl41N+cm56d6MEViK/Wpwqvt4u4CsBR9
	oytIuAfRn4Wq5MQV8D1oUgY+JzTjK2XHhQxLnYKNBgUwZBD29IXnXJltipiCw4z5
	wYJOwdgu0Tb3FVwM32IlkQE5dfY5XgnvIbFheU3KT/0glfUfT8JmXn+hgI3RfQh3
	8gQSMENq1NSDDaTFf43p9jP9ZoMwq6/C7HpiOX9SdjRLx7VybWoyQdP6+wLdi6c3
	iEN3GEQi4RSiWRMbFsGrPw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44mqk88kvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 13:32:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516CVImu020657;
	Thu, 6 Feb 2025 13:32:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8frub17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 13:32:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPq+2dK+ftD14NcXOALuopIL9CHczhmo2ChbAdUZApih10A9AwOIa+39gQgt1/eHKr5m7fluCkITqtqec2sRjl2bZORGB9O3ySZWFmC9HFYcscWmAXhson7396dyzVzgMG32+EDqBtHnzY3PJP7kX0sOFlKTG4rlpCklCoDSf/Kf4NiMbCTKzD3M0L8KL2nXmcPuBCVTQMmLr6UV0Qii1Za54i5nlTxcGxLAQWHisVRTpIVVUEF8ktPq2BzNFvpaI1yQf5jdRE/2kxdDmXWemagfYR9KJHoJuIKymGBIijANTmPZ5N2/EtAWJGkstzcZPEJGIGkjgj0yzZdAcR17Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+Vt/VwbdOeF9VNB+Fdk4a/KSZsedip6O8hOslQ9idI=;
 b=dPPjImgvbEiC1EaME6ZhlMLa0xoxYiTb1ZWGpGxUEdKV3diIFL5uUi41yw08UBTRCfUix/mMFZrhJfwXQUAfGEGyewYKLP0G6kiENU90QPxBNkuPA6grR+/Fxwcsfm4jBEVk52t5WH/fA1j9hLj2x8LViovNy7F8m1xTMkuv6ZYa7L4JdKqUVANOti9yyrw8jBMD9He/2qMlr7RoCp49P/hnv9mGvpbs7iVTsQsxAwH6sMN9IuzNBPZvohTByFyMZyHkyP8JV2Xnl/C0zWOgpgnMufr4HB49KIhMSqmc5d1cK0i8b9cgv4r92IkJ9iBVn5CBKiTwWpv2ALgy49ugdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+Vt/VwbdOeF9VNB+Fdk4a/KSZsedip6O8hOslQ9idI=;
 b=Ll+MI9vgS0if7CAXKRAJK3POIeICSUYQ4wMG/igcyHi01bOY28Woy9ANxigCqBxEa7Ao2Ma5vlvB8fN7MEWR5iEDisjySMClBSbCktMwvdhVGwfZBxDYAv7i5VMWT8Ax4InhdvNh4qFJgWbGZC7GZ8iG5SqfHmOnGNj9D0Y0gnA=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:32:49 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 13:32:49 +0000
Message-ID: <8f26a854-5d49-4993-a838-efec7270155a@oracle.com>
Date: Thu, 6 Feb 2025 14:32:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Rate limit AER logs/IRQs
To: Jon Pan-Doh <pandoh@google.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250115074301.3514927-1-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0252.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::18) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|SJ2PR10MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 7119e407-bf8f-4ae0-b0eb-08dd46b2bfb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFhmYTlDVHJpV1l5bTFtclJqU2RnRkhWVEhVUUpnMExoYTlBd1JVdTRra3Fp?=
 =?utf-8?B?d3l0MW0yN2p0N3VwRnkrUCsweHpvS1FxQzVXMWhGdllXODhadzkzcGRtWUpB?=
 =?utf-8?B?RlZLZ3h1ays0bkNIdEsrVnhBd2pNUG04ZWlGNU5DYldTK1ptVVQ5UG9ud2JL?=
 =?utf-8?B?cnRVcnIwZzM2b1Q0WkxDQjRhUk1ETW5yRG1UWVBqQVo5bHRRcnVBNFhKZXY5?=
 =?utf-8?B?OE54Y2VZWEl5d2dDdE9ReUFPSzRXb1A4NWVDRXpWZlhxZXlKOVp3clhzai8w?=
 =?utf-8?B?dmN6ZVBoZHpIZEJhY0I0R0R4QWFadzU5WkNaOVZRUG9rTXlTQ0xjMTlBTThl?=
 =?utf-8?B?d3pwUS9obGZpTzhQcGF0eEVRTFBXS3lvZWsrSUhjbHc3Q3lNYUJPcWpkckpx?=
 =?utf-8?B?VFdHTWdBMUFoaU9YL2RUSVNtYmd5ekdETWl0eXprOEdwK2VFYnBld0J5T1ls?=
 =?utf-8?B?dUJmK3FaZHZuWDhFQmY4dy9BalpjN3VHczkrc21saHQrZE80c2paQy9Da1dU?=
 =?utf-8?B?dnR0aWlxTHJ0aDRIaGVWWFYrdHNNaFpidDZMK3RtUGg1dG5nOEtKek05TFU0?=
 =?utf-8?B?RThNcXFLU1Z3R21iOUhseTBZaGpTek1oYnRPSlYwdjVPR2o1ZnBKamwxUnF1?=
 =?utf-8?B?ZUNBaEVVdGptcjJoRWkzeEtUbDZjYVZucEpOMU4zVE1sNk8vT2syNGJJNXRr?=
 =?utf-8?B?NUNrNGx4QWVJMEpTQ0sySHlpQ0RQZzhFWWFYcTZrZ1JhUU9FQytub1FDSFpq?=
 =?utf-8?B?ditvQnB6bjdha3RXNVcxNnhyeUU0bzljLzBmSWhEYVJXaXRiZjRJYnBnbjhV?=
 =?utf-8?B?NTNVUEI5eW42MURGVW1xaUd3eVRZQVB1b0lzWStvckM5eGgyU2xnUTFHMmhp?=
 =?utf-8?B?Yy9LV05rR1E1QzFaTzF2cGZLRHJ5V3o2TlNCVUNsaVhNNkQ2L2J5Ti9tY2VJ?=
 =?utf-8?B?OTJmMWlGNDliOTNWa1kxVXdnaUZoa1VYbE1iejhmeFdHSFVvV09mb05UWlNn?=
 =?utf-8?B?Z3JSSlRNUzJoVlpuVUJUV0ZKRi9aOHF6VnY1MEF3Kzl1b09aalQrSWQ2Vllj?=
 =?utf-8?B?dllESFlad1cxN2xiN3dDWVMwb29zYWFocWJUNUQreXJreE1qSXNQeXRBT1Rh?=
 =?utf-8?B?MklFTWVzMldscHdsNklUcURyQW43UTZ6ZlhpTWQvbDVCVDJxdzY2R0NoMUVS?=
 =?utf-8?B?NFYrem5tclZFVjA1eDZSenpJaXZ2RHU0STB2UjF1NlBCemVQZi8yRGoybjBH?=
 =?utf-8?B?SU9IcGZvNDFueHpnbmYrcmc3eHZmaEMzNXpJb3VndzZocWNySForc0dydGlV?=
 =?utf-8?B?cE1ITVJReWsrNHRrT0RwcmFJU0Q4WU1PRTlXb3pNZXAwOWpWdHJlb0VpcTI4?=
 =?utf-8?B?bVY0M3hGSFc2Ymh1ZzBkK243V21XMktHaEF2eVZ3Tm1nYWVZejdxTWttTzQ4?=
 =?utf-8?B?a2sxYkJyOUVuMlo2RGpPMklWei9GaklNOHJpZjhrdC90OUp3bFEzYWFGVlRz?=
 =?utf-8?B?cDlDdVVqenhiT2M4Z1VIOHA4MFdWZkdjYW9XakpuQjM4dFJySm81S1NGeS9m?=
 =?utf-8?B?ZXlPSktkRVRIckdLamJtc0QrYXBJMWY5dUppRnlRQlZ2aklIMDBXMEtWV3BY?=
 =?utf-8?B?Wmxud0JXUThGMTVsMDhOTnZpMFpHem9NOEEreHNNT3h5S1p3cFI1TjhHWkVv?=
 =?utf-8?B?UllpdnlsZ0doOVlXQ2NjZVZTWkJBbWNyUTVUNFJITzc0cTNrTXdWWkx6alBT?=
 =?utf-8?B?anZmcXNqYzk0Y3BudmtkZTNnYTI0L2EwblhEWDR3cVhhY0w1blNiOVd0THhL?=
 =?utf-8?B?UzV6RTNZSUxJNmNoRVNMQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkdIWmpXZ3pDQVRBeHd0NS9kQ3VaOElXd2ZQRHRxVmlRNlR3RUIxY1RIRXZ5?=
 =?utf-8?B?WWN5WUJoZFY1ZHcvQVVhZE9XQzNTZ2FJUWNFV2NBRlhaenRGU2ExcTA2UnVj?=
 =?utf-8?B?YnJJVmxhQ3Y5YmNsUFJJZ0VjcCtPMnJmTXY2UnBzbGh1R0F1SkZrRDMzd1Mx?=
 =?utf-8?B?RmFkQkltWlhYaUUyd2xaeTRzZmkzV2hPeG9TOUVRTGdjTERzaDkzRDhjYUJZ?=
 =?utf-8?B?TTBSbXZlSElCNnYxcFJ6TVY1ZGhIUzV3cFpxMHZ3S1BMQ010cHZ3OHVtRjht?=
 =?utf-8?B?cmdvYlg3dUdwSTQzNjZQa0praWdJZjRNY1JGWlJwRlFTZmNpSmJWdmsyeTRR?=
 =?utf-8?B?cFd3UHMwV2g3RGtRM1hVeGZhQ1FqSk9MenpzUlcvTXB1cXBiMFdKMWxTdmg4?=
 =?utf-8?B?Y3IvaHEzZzU2dlVpOGphVU1JalAwNjZiVVQvVDVyTHBGbjJPVFRjSFBtcWps?=
 =?utf-8?B?dzRUbFBUYU1HbU5kZjNJc0hRVUFRaDBoRzlHQTlvZ2o2WUMrYUt0aWE0UDFN?=
 =?utf-8?B?RjdzY0lJa3lHT0V2VlJXVlFBT1Rrcm04ZjlHcVFMTTlFdWNrUS9UdmN6c2I1?=
 =?utf-8?B?endDU3ZoRjRaTmZlcC9VZUIzS25sVnVGOC80SHhpZjFXSVltMThwRzl3bE9V?=
 =?utf-8?B?UkVUTW16ejV3aVluVGlJb3FCcjFUN2VaVUcwdzJQTENwSmJZeEdHMGtZVzRX?=
 =?utf-8?B?S2FaQWRGUDVXYlpmeHg0UWYzWnlkWlhYcytUYTBOQ0QzU3pmcFp3b1k5U3gx?=
 =?utf-8?B?TFJnbmlEb1NneVhpTnE0L0tFaXJMZFVwSDdrRGtvazZPRG9KaHFLSzhBZjNy?=
 =?utf-8?B?aDdkc21RbEVuNkw4dDFINjVweUZrK3B6bUY2Qno0WWxlODdiOEtPSnYxZys4?=
 =?utf-8?B?bWxjUXVoZ0xxaDRVNEk0SEdhc01iTU9XOE5sd3l0NldQWVNzMmNvUC96Vm1P?=
 =?utf-8?B?Y1BtMGJ5VzRwNEUxdUtUbEF6alpDUUdjYUlxZ2MreG9zcUlUVGxnTFVBTVlS?=
 =?utf-8?B?aTgrL0U4VkNUbHBOUW84WjliTndPZGJ2aElIT21pMWw2R1ZLdWp2SVJxaWhZ?=
 =?utf-8?B?SWN1eFRIWVBWZEp5b1JUR09NZjM1bUI0SHhHVklVTzN1cHNwelFTNldkVFNL?=
 =?utf-8?B?ZTBTdWVNSTI5OFJHTVRNUmpxQW1lYmY4c3UyK2NpYUtQZC85aitIMDNHbkp0?=
 =?utf-8?B?UGhoVDZycG43NTFCVlc3RXRMNlM3N1pRSzR3VnZDUUQyVXhPYjljQ3NpL21v?=
 =?utf-8?B?SjRzS1Vzd0w2Q1p0eGN4dTFmWG5mNG85ZG9QSDBJcnBMbGpyN2ZIUUxHYjNY?=
 =?utf-8?B?bVo2OWZMb3JBSTVPTFptY3d3NEZvOTByZC9Ld3VBK0dZelJDWWpFTlpWZ1Aw?=
 =?utf-8?B?eDNieEE1NTBURTJSU3IzUGhtUmRZSGU0RDRTTlhPN3ZzYnNmQVRINXp3MVhp?=
 =?utf-8?B?NHphUUhDOUxlcmlzSDU3U054Y09uMG5VdGpmYWx6eExVRHNPcjhPQ0xkNXVH?=
 =?utf-8?B?YmdSMy8xR1NZWnM1Skc2eFdwU0dmOVdEU2JHYkU4d0FidVlDMGlHRXhTdTY3?=
 =?utf-8?B?cnEvYlBTNm9wbEFxbU91VGRzK09JK0NmSmxhOEx6WjIvdEVPbkFkMlo5QUJO?=
 =?utf-8?B?NndJU21xZ3JGLzJ2aDdKbFo3R2toYTI1TVV0aUN4K3lJa2lQNmxUMjZleTJV?=
 =?utf-8?B?ZlNTaHl5TVprMlJiVkhFNHRzb1dSc1VEK2dyd0pDQkdiZ1h2TStZbE1sMjV2?=
 =?utf-8?B?ZjUwV0VpWFBWbVU4L1lmUlQ3RktqSm50bXlUbmxHK0ZibmhQOFNxcEErTjZV?=
 =?utf-8?B?QjltdW5IYlk2Mm5CQXhXbkJ4U1BtL0dFQnRHcms3ZUF4LzVtMU40L3ZYcXhs?=
 =?utf-8?B?MVBWZGpkR3gzSkRxNEtsbUFURDRPUFp4RUV6K3lEdzljRzBoY0RJSGFGR1Bs?=
 =?utf-8?B?TWVLQit5Z29ielpodUpkekoxMGdPbU9hcnJIOVQ0eHpzOWIrdmRVK1drZ2VR?=
 =?utf-8?B?azNMQVdxMjZCN0xBRUk1NFY2bm9LUmtXVFcyTmZITnNpNmdlTFh4WGxjcW5m?=
 =?utf-8?B?YzM4V1RtR1BudjNnUjBUZXRYOTVFbUlBaStDbHE0NWR3dmlPa3gvQzZiTjcw?=
 =?utf-8?B?K1RrMEZ6MmE1UEhneGZzNWw4aXB1TDFPbGVUZ1A3M2pkcHpHdDlVWmN4Wkcx?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QeXWIAfXeqXtvQWH2Vq2qJdIIaEfdOeytXKZeUpJuP808kggSnqbssZTyfjwZ797ByDGJgR8/A2r+lN0XTcHDTcDccgwtUxFpL5TYBjEzComy+wi51ZDNfTmElcJVVxdkEVOxayNOC2RLqOItV+s7+fKznyDtBFS8ph/uLnDRUMK3MaCpDc6XkGEKc9u7dcUxn80O5PXlNw5vbO/aM5WW5yfjl4Bt1EAQmx2qcAOh8CRONrfa1eKiYElRNNAoi61k3PTFFXdlUAHHyhOBVDTJoXXlQqH6NjdCpOZEWMfFNIAToc59HtNRmubMvrCq0bGKytzHsrSCS/egM2Bi1j6xD7A3HyOtEo1OXAEtrIk89+DSaYdhmansARezzWtSE1tfTny0oT1iDaEGeNl8NHe+Rh2yhOiIm0EIocG/KmHP/FJNCtyhMOLbyK9Y4n4stOEA/jaUJ+LIXM60/dGNtZcFB0NXtDft7o5erSTqpJkFYiPIv9JeFgiDodhRzXg8hRUBqQdvnVrrEoEUNloWpuuUOLPGOJmzdQZwCF2EgfqjSFbe6z8Z+BuNsQAfL2mpuXBWXiJVYn7bUHGzMFMSh4rWlKsejUcs11qbxeoqFHKdQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7119e407-bf8f-4ae0-b0eb-08dd46b2bfb2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:32:49.3917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3mm7c8XPUtG2Gb0naqNgU6Tk54Uqzj9WVkJaGX0OHqek5lk+WN7Eh08FYjFL0iDWagiqsKrgi78vWaV+7DVQcNruL29/kSfInD7n12tBAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060111
X-Proofpoint-GUID: Oo__erqHrSGmvobre5_WIbViYiF7jXTB
X-Proofpoint-ORIG-GUID: Oo__erqHrSGmvobre5_WIbViYiF7jXTB

Hi Jon,

On 15/01/2025 08:42, Jon Pan-Doh wrote:
> Proposal
> ========
> 
> When using native AER, spammy devices can flood kernel logs with AER errors
> and slow/stall execution. Add per-device per-error-severity ratelimits
> for more robust error logging. Allow userspace to configure ratelimits
> via sysfs knobs.

Do you have any update on the series?

I'm aware that a lot is happening in the AER code right now, so I was 
thinking if it would be helpful to split up the series to get the logs 
ratelimiting in sooner. There are some concerns about disabling error 
generation that should be discussed, but I don't want them to block the 
logs ratelimit changes. I think it would be good to fix this first to 
save people (myself included) from overflown syslogs.

All the best,
Karolina

> 
> Motivation
> ==========
> 
> Several OCP members have issues with inconsistent PCIe error handling,
> exacerbated at datacenter scale (myriad of devices).
> OCP HW/Fault Management subproject set out to solve this by
> standardizing industry:
> 
> - PCIe error handling best practices
> - Fault Management/RAS (incl. PCIe errors)
> 
> Exposing PCIe errors/debug info in-band for a userspace daemon (e.g.
> rasdaemon) to collect/pass on to repairability services is part of the
> roadmap.
> 
> Background
> ==========
> 
> AER error spam has been observed many times, both publicly (e.g. [1], [2],
> [3]) and privately. While it usually occurs with correctable errors, it can
> happen with uncorrectable errors (e.g. during new HW bringup).
> 
> There have been previous attempts to add ratelimits to AER logs ([4],
> [5]). The most recent attempt[5] has many similarities with the proposed
> approach.
> 
> Patch organization
> ==================
> 1-3 AER logging cleanup
> 4-7 Ratelimits and sysfs knobs
> 8   Sysfs cleanup (RFC that breaks existing ABI/can be dropped)
> 
> Outstanding work
> ================
> Cleanup:
> - Consolidate aer_print_error() and pci_print_error() path
> - Elevate log level logic out of print functions[6]
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215027
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=201517
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=196183
> [4] https://lore.kernel.org/linux-pci/20230606035442.2886343-2-grundler@chromium.org/
> [5] https://lore.kernel.org/linux-pci/cover.1736341506.git.karolina.stolarek@oracle.com/
> [6] https://lore.kernel.org/linux-pci/edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.karolina.stolarek@oracle.com/
> 
> Jon Pan-Doh (8):
>    PCI/AER: Remove aer_print_port_info
>    PCI/AER: Move AER stat collection out of __aer_print_error
>    PCI/AER: Rename struct aer_stats to aer_info
>    PCI/AER: Introduce ratelimit for error logs
>    PCI/AER: Introduce ratelimit for AER IRQs
>    PCI/AER: Add AER sysfs attributes for ratelimits
>    PCI/AER: Update AER sysfs ABI filename
>    PCI/AER: Move AER sysfs attributes into separate directory
> 
>   ...es-aer_stats => sysfs-bus-pci-devices-aer} |  50 +++-
>   Documentation/PCI/pcieaer-howto.rst           |  10 +-
>   drivers/pci/pci-sysfs.c                       |   2 +-
>   drivers/pci/pci.h                             |   2 +-
>   drivers/pci/pcie/aer.c                        | 227 +++++++++++++-----
>   include/linux/pci.h                           |   2 +-
>   6 files changed, 216 insertions(+), 77 deletions(-)
>   rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (69%)
> 


