Return-Path: <linux-pci+bounces-29284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E22AAD3065
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB41883083
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09431FBE8A;
	Tue, 10 Jun 2025 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pOVTz8rh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8D1A5BA8
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749544314; cv=fail; b=LBCnzPs+JfbbAy9PuTvYOcZrSuWuIUws9z4urHr62HSNfL5rOnq1AbkhhAjJGDNEEGV9qoiZcyoFMyRUkSWvzefKP6cv+xIpCGVYYRg3QQCSSO+2qTBOjj+hPMQahwzwJl5nr7VVpXL3EYnm1i5E7IEQ1Di/kYzC1BnXMxhu6to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749544314; c=relaxed/simple;
	bh=9iAuUqyuqgdkRCatRMMb7B+YNi/5P7l6VDZH7poETQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CmqTCfCfmjT1/voHiW7S0SI7m2HODDout5W8IBe0wlXziWTAFtvTWnGzmYhw7ZwyH6LXyQCnJMQqUElcB9Z4D/AFbllh/gv3NBCY5KKJllSC2gfjeLbNfe8kdrslW+1qv0GvKfkQiOtOJKiUsPh/jgN1TxAe575uTTitbsxDVVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pOVTz8rh; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+9FQlP4tyg88tXNRuAIbWi8lSrhy7JHfGEbF3Fcs4zPmjuY33v83/DK4HwPzoNcMi8aNLXv4ab/5xWXwnM9ls9n0J4SYYl5JaH3JjEd9mUR1gaNAKiuo3U3Bo6EGJsWW9xDn4UJIqLACGXSyPaKhXKKlmEuTV/Yd/iMlTEMIN1UXj7bwA+f/XBGBmmd/qE147+4ptX+Pag33R2qgPtfW+S/4MVdR2TjkUx40dRYag9P/M1vOx2eaZ7eiqJR2NqTzmRI95trh1q++yOMoG6VbCT5ebvSzdfwMiNld8fbW8wzukiDZAgZAR+zfmjTjhpN2zhOW18fkqDTdn9KtEjQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaQ9vKNpgXDCWbem69gs9zcDrcTTCTqJ1dSHe9cHlkw=;
 b=usyan/EfrQ1/C9xsyqyYVbGz/w6lW0pFXegpsAwPPuas54O7OzKIQ8WxDI/ePQ8iy2FnOjogDOcCQiMWdcqfoGfPbsIdgxOQ+O2J5RqqHX4f8JJNTQSaI7PQsVRxx2v2vq36y8A+SC87F0H/uzg4pyorQsymYLifVFf39Ym09zd2RpfVs0c+RJxIl0UaSHzFzJdG58W3pPVWlp2CO5PUMezif3sxeABb+uER7xf75ZpC8XDNNqB0yMb5+roDTKc2+JkUpCxW3adYAdgjsphikedtPmLFP5vMnez4Uvv0DYVsuCqmUrRXduPfUjqv1e8CvYykl3XakwRljfvNaa0Vsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaQ9vKNpgXDCWbem69gs9zcDrcTTCTqJ1dSHe9cHlkw=;
 b=pOVTz8rhAEA4pCStgnoJ9V30e+7TQs9nj1PkpsHyplDHnPFcbqur8iIsVoEGRRcJBbEqxuKzSbjCBuiWdKP9eA+tkTmgIXYV4eA/ZlVMoOyMtVNzCaslnLttBUw1Io92HyaEnuffsbzqsWRLvoXFJhvlJoY7smlOKEf+9xrPDzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 08:31:48 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 08:31:48 +0000
Message-ID: <14944158-4a95-4831-b942-5fc9fffa9f2b@amd.com>
Date: Tue, 10 Jun 2025 18:31:42 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
 Xu Yilun <yilun.xu@linux.intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
 <363a3220-e43c-4965-b138-b85f09a5907b@amd.com>
 <682ceffd717b4_1626e1006f@dwillia2-xfh.jf.intel.com.notmuch>
 <cc0e125a-a297-4573-a315-89f4f95324c4@amd.com>
 <683f76a7324e3_1626e100df@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <683f76a7324e3_1626e100df@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::16) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae1e8ad-1e8e-4524-27fe-08dda7f93d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTJNOXg4REErVkdpUUtURktsNEJxSERMaTFDR1VqcVdFdkN2YnZzd1l3ZnFC?=
 =?utf-8?B?NlNQakFyVHBVaFozekNaaEVTVGtpY2psRjg3ei9sQkZrUjhUZ3ZtZFVNSWk2?=
 =?utf-8?B?anA5cDNGVE04MkZUbC96eEpiajJKQkJKcUhleHlzZE1LbVlORnRlSjZnOFVx?=
 =?utf-8?B?S0IzT1JmWFFSa2lkTldvUnhOZ1I0VWN3eUVEcWZDRTZVSUFiZWRaVDhXNCt5?=
 =?utf-8?B?TmhsakY4UWFuZ0RqRVlNM0Z5N0xVbTdPdlZIYTVuS2grMWRmUnE2NTBjTUdJ?=
 =?utf-8?B?Ui9XcHI3ZXRxNXV3M1lEWUthTVBaY3U1U2VNNW5MRERid1pYdlYvRExQNjc3?=
 =?utf-8?B?UHV0WUZBZXJkMUZTNnVudXZFNitWdzlicEp4TEp0Sk1wQ0FtYmV0NDhtZzNa?=
 =?utf-8?B?Vit0Q0tMT3MvamVYNFpPQWU2dE5JU3hwQzlGYUxrWWNZNTdYOWh0Z2t1ZXhO?=
 =?utf-8?B?Q0x2c3lGZUFrbmRhY3JrS0ZYcUVwZDNSMHkrVWhsMWlvQ1ZoVzVaWnV4MU9K?=
 =?utf-8?B?M3NMZ0hjam9hOUFmU3g1R0lyZmtnc2gxcHNaa3V4cmt1V1NsbnErZGhDc0xu?=
 =?utf-8?B?YjNiZ1lTNCt6ZUJHY2hvVFV3Vk56SytIMzBzMUtzRXJ0N3pPVjZiMzJXc1dk?=
 =?utf-8?B?YTFXcWtsbWF1azNLcEdZNzFUbUlBQUNvV0V5V1ZOc1lRWnFsdGlYVHMwVjZm?=
 =?utf-8?B?YlhXNjhrWEovUE11djQ4Z3prTTlPdTJLZ3hmRDZ6OTVEdkRCTVBkSGNqWFJJ?=
 =?utf-8?B?VjdJT3kvcmFJaWl0MGJUK01OWDA1ZWFWOUhZZEJWdmJENVBXSG1IS3h4RFRD?=
 =?utf-8?B?WlFhd2NQSHFTUHpJSVlmR2ZDQzA3OElDTG9JeW91cmdvaVJjRlFTRS94R2V6?=
 =?utf-8?B?Y3lKeWZwenIxa1g4bituZHNUVTdabEJRd0Q2OGprdnR4OVlrLzRxUm5NZ2JD?=
 =?utf-8?B?T0FJYXB0cG1pY014b1JqQ0dtTHFVc21wNzBTS1F2aU9Hd3BDb3BtL3lTMTIr?=
 =?utf-8?B?SllEOWFLZFlwaWVmelAxbE83VE1OSHRaOTlmMkNZT29XZWVsbFlyMUV0MHBN?=
 =?utf-8?B?Vk5LU3I4S0REMnRYMDJtT1dJSjgvREovWFl6Y2VQNjdnZlAvMFA5ekdrVzhw?=
 =?utf-8?B?emd1Mk9PTE5JRG1VVzJBTW9sREczWkxNUENjM0VKc1gxZmc5VWsreWZ1WHBT?=
 =?utf-8?B?aS9HUldwZnBHVHRNblRobDkwQXZsNDBvS0dHTFU4K25QbktIMFMzM0h3V1ZH?=
 =?utf-8?B?amRpeFpvUTVvek1GbkdoaExHY25VWnExYms1dXFlUWVHOElsNGNLUnhjTkZt?=
 =?utf-8?B?aXBPamlvbmRmWElZVTM5UHVPZFZqN2hmVmNQRnhoK2gwL1VYdzhGc0FXeEtV?=
 =?utf-8?B?YlpwQzJJV3hIZ3BOc0VwaVBhbWNvQWY0Y29GVHVEMU54RU1TNVh1cFpMZjlN?=
 =?utf-8?B?bVREWkhtV1Y5ci80ZDk4TXlLODc3Nm5jZStPYURGT1FJVE9TWjhxWUpweERl?=
 =?utf-8?B?VTNqUEQ0dU1iRUlPSVRYQkw4Z2JZeWRubnR4QkNBNUk5cUlWdjlHZXh0dEZx?=
 =?utf-8?B?Y3JFNWl6bmIrUmxTNzZpRityYzNHQzUyeFREemQ1azQzTUtZdzlvMUV5NUM5?=
 =?utf-8?B?VVdoSUp3VHdpakI2QzZUWHVQYTVJNERlUW00RDJ0SU45R1hoM0g5NktnbkM0?=
 =?utf-8?B?NSs1ZXZ6dytrOFRSNW1hZFVsd1djajRZbHN0TjBZbVE0bVI5SCtQMUh0S2NO?=
 =?utf-8?B?bU5wbVo1Z0NBc29TMUczQzZGTXlWUXhTbC8rK3d5Z1BZM1d0Y244RVZFVWJo?=
 =?utf-8?B?bVdkbEdXZWF4OTVwdFJkRDBLY2xqOXlGSm4wVkpvNmplelhlZDVVMGFsMWVr?=
 =?utf-8?B?OXN1d0R2NzFaMUlCMlk2YnhSVXNaNEY3Vms3ZVhNY21DckdRbjRUUGVOdHUx?=
 =?utf-8?Q?aGk0VHdanek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHlEc01waTVXQnZjQWk4MGJ0OFVJZWdvUkJCS0hPYmtVZ0dCbFZpNlNjU3lF?=
 =?utf-8?B?UC9KbDdxcEd2d2dMem03aXpTdFVCYUlhUDcvcmJ1ZTRuclJLSmhJMzNVZ1l5?=
 =?utf-8?B?NTZQaU12a1B3T2l6dDIyMVZUaG5xa2RJMjVra21Nb1I2S3FpZGovMW5xZzBD?=
 =?utf-8?B?UmVlMjBjWDRDKzRPOHRlWDNYZTdrbEgxQjJjUW5namU2M0JsUmFPVE9xcU1y?=
 =?utf-8?B?aEpkWUdIWWg2VzB1YkhwZDN0TGJNd0UwQ2wwcVlja1p4eXJpaHZmYjRsYXh4?=
 =?utf-8?B?Z2ZvaklXeURKM25mRU56U0NCZ2M5cXJOYVpKeEY3R0R2SndYSWsyTUYyMEVK?=
 =?utf-8?B?NExEVFNwRjRXclhmUGxnQ0w1QUZqallLU2FiUmZ4Sy9jbkxSQmxCUnI3aThm?=
 =?utf-8?B?dXhuN3BpV1k5Zld3QWIxVXpJT1R6aTE5cncvYUNDaEZ6MlpSTysxanFSalZw?=
 =?utf-8?B?KzUxNitOT01VTFloeUNnSDJQak80eDlvdFNGdGlFL2pGdllUU0VNSitYUnV5?=
 =?utf-8?B?cktxbGNxSDlFNzJlRVZVc2tNSjNKUFFjYUtSRkNKbmlEbnlRam5ob1RPMG9F?=
 =?utf-8?B?S2o1TGlGdUFTTFBrTlpWcDljOTJSMGJqcllQZTl0Q1dJNS9teHZ6TWpUQjBQ?=
 =?utf-8?B?b3lzUjFxRXhrTFRsK0RhUGdlRHNrcmxTcWZvWDVEUkpCVm1yUGhOMDdJYmVO?=
 =?utf-8?B?cjJEQ25McG81SXltKzJzOHBOOGt5ak1RUXdIb3h0aWI5YlFLNi9pUktEalFq?=
 =?utf-8?B?cUlMOWRaTzk5SkUrWCtaemxsQ2MzWHMxd2toQ1pRVFlSek9ndklDZUM5R0U2?=
 =?utf-8?B?anRKTDd6SUMxTk45UXdPVjkwTjlZWUJCc1NiMEkyZEl1d016eG1aVnJDSE4r?=
 =?utf-8?B?Skp1Y3ErWGRHYXpicXZvY2pVSmhWVjN2S0xsQ1Z5Y3dOR2ZGcEw2Z2JuRU04?=
 =?utf-8?B?eFpveUN3R00xd2xHTTlpWWdVZ29VSHlqTHM0ejQxZnJEZXV3YkhEZTBoVWdK?=
 =?utf-8?B?UFBaZlQ1cW1rdGVvb1ZTamRIa1llMlRiZ1FmWHFERTE1Z013Z092Snd5N0ta?=
 =?utf-8?B?UWNSeE8zSUJHRzJYbDN4QjNhM1BneGtkZUpvbXZNck42MmVBRVhUb0ZTSDI2?=
 =?utf-8?B?MUU1Nlg0YzFpN29WQ0V4dkE1UGdUNmtNVUxuazdwNVExZGNLaHA4OXhOSURz?=
 =?utf-8?B?SHVBU3ZHem1aV09GUHlLZld6OVdZUUpvOGZwZS9ha09nTDRISkhlaUVJNktq?=
 =?utf-8?B?bFV3UHBQUUQ4V2l1UVlHZkcxRkt0MG43NFB3eDBVTmxxZHVnaWZWS2JuVEc3?=
 =?utf-8?B?NGpWRERPRzlNYlNwNm1zak56dnc2WGhzOVhRUWh4bGxQT3YrWTVvQmVIQzVh?=
 =?utf-8?B?N3pjZXZ4eGVyVW9BcVFhQktzV3hMbWcxVFczdURXUVZIUGJjTHQ3Tnlkb1ps?=
 =?utf-8?B?UmxYa2NNdGJJQW5MWHoweEppN2VYMUlnTmwvVEV0dy9HMTMvTzFwT1psakt4?=
 =?utf-8?B?UmZJRVp5UWNHVnZqTDRNL0tRcEVZZW5YamM4U1l4dExMcTZuNjhZSzYvc3lo?=
 =?utf-8?B?SDBWWUF4K3R4UURqdzMwTFZWc2NjUlZjbFdsNjgzdll6VjdDWXZtWXF2L1Rh?=
 =?utf-8?B?aDJtWFhjeHFYN2NnNnRXRFc4SzVCaHVlRkxLaTNTMCtaT3JrLzNHc2lCWEdP?=
 =?utf-8?B?ZE9URWU2QUNrSHZydFYwaFRJTXV4dlQzTGJ0ekJnOGNuTFdxK3o0blo1OFNr?=
 =?utf-8?B?L1BJV3FoTlpoUHlxZWVQTHB2TWxTbVltRVVMRVlqUnM1TkZpZ2JJdERZbXlE?=
 =?utf-8?B?SkoxVFVkWDVwZ2VZSXVMMEoxSitBTC9NZSs0cUI0T2liblNsQTZOd2NrME1L?=
 =?utf-8?B?emZUVnZDZkhab1J2czQwTlhLZlIzaTk5VDhOS3dvdkxlaDErdWxaM1FJZG95?=
 =?utf-8?B?TmRnTS8yNFlBV1JrQURmZXFPMFJLZjFhSzVBSFhsYnBDVi9HQ3dUWG9hVVhH?=
 =?utf-8?B?eUo4bkIzN1MzNVFqTElvcUhHanBRejNzRWtWUkRRb0pDaUlROUlGSWRsZXRx?=
 =?utf-8?B?Uyt4Yy9lMG55c2dleDk0em53K052eGxCRTF6aEVSU0NKemZPK3YrUjBLVWlP?=
 =?utf-8?Q?se/4zCfk9TZTiUNngAXvMKDfy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae1e8ad-1e8e-4524-27fe-08dda7f93d9f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 08:31:48.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nkvHOQ3V4cEWoxXpqOTt4DDb9cJbuaEANApcx5kWA5taaouGWAQq46YfVIz6pzYizWKhqAryjqEtrrKbKQTdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154



On 4/6/25 08:26, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>>> +static int pci_tsm_accept(struct pci_dev *pdev)
>>>>> +{
>>>>> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
>>>>> +	int rc;
>>>>> +
>>>>> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
>>>>
>>>> Add an empty line.
>>>
>>> I think we, as a community, are still figuring out the coding-style
>>> around scope-based cleanup declarations, but I would argue, no empty
>>> line required after mid-function variable declarations. Now, in this
>>> case it is arguably not "mid-function", but all the other occurrences of
>>> tsm_ops_lock() are checking the result on the immediate next line.
>>
>> Do not really care as much :)
> 
> Hey, what's kernel development without little side-arguments about
> whitespace? Will leave it alone for now.

:)

>>>>> +	if (!lock)
>>>>> +		return -EINTR;
>>>>> +
>>>>> +	if (tsm->state < PCI_TSM_CONNECT)
>>>>> +		return -ENXIO;
>>>>> +	if (tsm->state >= PCI_TSM_ACCEPT)
>>>>> +		return 0;
>>>>> +
>>>>> +	/*
>>>>> +	 * "Accept" transitions a device to the run state, it is only suitable
>>>>> +	 * to make that transition from a known DMA-idle (no active mappings)
>>>>> +	 * state.  The "driver detached" state is a coarse way to assert that
>>>>> +	 * requirement.
>>>>
>>>> And then the userspace will modprobe the driver, which will enable BME
>>>> and MSE which in turn will render the ERROR state, what is the plan
>>>> here?
>>>
>>> Right, so the notifier proposal [1] gave me pause because of perceived
>>> complexity and my general reluctance to rely on the magic of notifiers
>>> when an explicit sequence is easier to read/maintain. The proposal is
>>> that drivers switch to TDISP aware setup helpers that understand that
>>> BME and MSE were handled at LOCK. Becauase it is not just
>>> pci_enable_device() / pci_set_master() awareness that is needed but also
>>> pci_disable_device() / pci_clear_master() flows that need consideration
>>> for avoiding/handling the TDISP ERROR state.
>>>
>>> I.e. support for TDISP-unaware drivers is not a goal.
>>
>> So your plan it to modify driver to switch to the secure mode on the
>> go? (not arguing, just asking for now)
> 
> Effectively, yes. In the non-TDISP case the driver handles the MSE+BME
> transition, in the TDISP case the driver also effectively handles the
> same as BME+MSE are superseded by the LOCKED state.
> 
> So TVM userspace is responsible for marking the device "accepted" and the
> driver checks that state before enabling the device (LOCKED -> RUN).
> 
> This also allows for kernel debug overrides of the acceptance policy,
> because, in the end, the Linux kernel trusts drivers. If the TVM owner
> loads a driver that ignores the "accepted" bit, that is the owner's
> prerogative. If the TVM owner does not trust a driver there are multiple
> knobs under the TVM's control to mitigate that mistrust.
> 
>> The alternative is - let TSM do the attestation and acceptance and
>> then "modprobe tdispawaredriver tdisp=on" and change the driver to
>> assume that BME and MSE are already enabled.
> 
> My heartburn with that is that there is an indefinite amount of time
> whereby a device is MSE + BME active without any driver to deal with the
> consequences.

(out of curiosity) AMD can block DMA until the guest decides it is ready and enabled IOMMU for the device, cannot TDX do the same?

And what is the consequence of MSE being enabled? It is in the guest's best interest to avoid touching MMIO before things are set up. p2p DMA?


> For example, what if the device needs some form of reset /
> re-initialization to quiet an engine or silence an interrupt that
> immediately starts firing upon the LOCKED -> RUN transition.

The OS will have to ignore such interrupts, what is a problem with it?

> Userspace
> is not in a good position to make judgements about the state of the
> device outside of the Interface Report.
> 
>>> There are still details to work out like supporting drivers that want to
>>> stay loaded over the UNLOCKED->LOCKED->RUN transitions, and whether the
>>> "accept" UAPI triggers entry into "RUN" or still requires a driver to
>>> perform that.
> 
> Yes, I now think entry into "RUN" needs to be a driver triggered event
> to maintain parity with the safety of the non-TDISP case.
> 
> [..]
>>>>> @@ -135,6 +141,8 @@ struct pci_tsm_guest_req_info {
>>>>>      * @bind: establish a secure binding with the TVM
>>>>>      * @unbind: teardown the secure binding
>>>>>      * @guest_req: handle the vendor specific requests from TVM when bound
>>>>> + * @accept: TVM-only operation to confirm that system policy allows
>>>>> + *	    device to access private memory and be mapped with private mmio.
>>>>>      *
>>>>>      * @probe and @remove run in pci_tsm_rwsem held for write context. All
>>>>>      * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
>>>>> @@ -150,6 +158,7 @@ struct pci_tsm_ops {
>>>>>     	void (*unbind)(struct pci_tdi *tdi);
>>>>>     	int (*guest_req)(struct pci_dev *pdev,
>>>>>     			 struct pci_tsm_guest_req_info *info);
>>>>> +	int (*accept)(struct pci_dev *pdev);
>>>>
>>>>
>>>> When I posted my v1, I got several comments to not put host and guest
>>>> callbacks together which makes sense (as only really "connect" and
>>>> "status" are shared, and I am not sure I like dual use of "connect")
>>>> and so did I in v2 and yet you are pushing for one struct for all?
>>>
>>> Frankly, I missed that feedback and was focused on how to simply extend
>>> PCI to understand TSM semantics.
>>
>> That was literally you (and I think someone else mentioned it too) ;)
>>
>> https://lore.kernel.org/all/66d7a10a4d621_3975294ac@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Ugh, yes, it seems that joke: "debugging is a murder mystery where you
> find out you were the killer the whole time." can also be true for patch
> review.>>> "Lets not mix HV and VM hooks in the same ops without good reason" and
>> I do not see a good reason here yet.
>>
>> More to the point, the host and guest have very little in common to
>> have one ops struct for both and then deal with questions "do we
>> execute the code related to PF0 in the guest", etc.
> 
> Now that is a problem independent of the ops unification question. The
> 'struct pci_tsm_pf0' data-type should not be used for guest devices. I
> will rework that to be a separate data-structure, but still keep
> 'pci_tsm_ops' unified since the signatures are identical.
> 
>> My life definitely got easier with 2 separate structures and my split
>> to virt/coco/...(tsm-host.c|tsm-guest.c|tsm.c) + pci/tsm.c.
> 
> Here is the reason my thinking evolved from that comment. A primary goal
> of drivers/pci/tsm.c is to give one "Device Security" lifetime model to
> the PCI core. That means TSM driver discovery (host or guest) lights up
> TEE I/O capabilities in the PCI topology. That supports "pci_tsm_ops +
> mode flag" vs separate registration mechanisms for different ops.
> 
> I also am not perceiving the need for guest-specific ops beyond
> ->accept(), as part of what drove my reaction to that RFC proposal was
> the quantity of proposed ops.


But this is all the guest will ever need, why allow possibility of (not) dealing with IDE/DOE in the guest? We will end up with "host-connect" and "guest-connect" when talking about this, having 2 types of bind (VFIO bind and TDI bind) is already confusing people whom I tell about this TSM business. And a global pointer, why... :(

"tvm_mode == !!tsm_ops->accept" - this kind of knob should really be compile-time imho.

Is it going to be one TSM driver for TDX host and guest, sharing measurable amount of code? I am definitely missing a bigger picture here. Thanks,


> So today's "good reason" is the useful programming pattern of "push
> complexity from core-to-leaf". Where the low-level TSM driver needs to
> be "mode" aware for some operations.


-- 
Alexey


