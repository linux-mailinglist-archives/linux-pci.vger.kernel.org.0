Return-Path: <linux-pci+bounces-35077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C59B3B0B4
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 03:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2338D1C86837
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 01:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C4186284;
	Fri, 29 Aug 2025 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PuRW1oLN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7746151991
	for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432696; cv=fail; b=a4PlFGhs8C6GTRliRMNSeMeU9mfJD+zoX8mDVwTALgRAFNRJYYirChzn6tqDsLXmyab7Coqh/PRyK2p9k6q1L+Jy0jXMFaIKlYDu6pCS1p30H5jmLwn6P9Opuub2PWzvbpwEdkPyDc4HGwVqFe9ytE9IZA9Q+n8x1KJ0OMVtZyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432696; c=relaxed/simple;
	bh=/L+qPh74WOdOmjWTSm4kSWODYtNVJ54XDRbJGMQiWLI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iPdsr6jnGVyZOcGDFBpw3VnEy0lcdCXS5JDFnzM0sBYYnP5vNvfUk2LMYELCtSAev8monmmWYty6bHO/Azxm9EwgKYux+34z1rFH34DcLOc06vm0wikuX8UmzbO4ec0P9mahugmhXLZBYc1Pwx7H2rbNx0WLCnGcI/jHfL6s2ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PuRW1oLN; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+bl08pOwMbul2uzO3J9JH5TSUBKFlihjoK2vCxiIvLfqGDKK+DRbWFsrjgonHJHovImGQ8v4DOoIASwngxtVkUTbU3gMovmcSHnJdQ3z0YC2UPy9fvqYs5J5ycFeY5pqxuJREnuc1FBo5js0JtrxU9vEpG+23S/41/sfoApyQZJZch7ToWyQPWXGcqGT73jL6ZIkoMB1eLZnbpw9rpW1rC8xy0ckmfQI2cqkzSefWE2TGid5fchlvku1JmQOquxaCnmAMLi56x8//vEuwab4BkFi2PoC7dFMwCq8u8k+N7kDNTFR0YPa2neKOMikNdKU8mE5JBWHWDLIwSbXJTpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ye4WtlXFeFYcmO1a/VoIYzH0HAGPIjqjBiP7I/WLvyA=;
 b=rqmhoY/bZ8TvV0JKqbKYcrCIyGPmpjVMRWw/EmXiFPyLMtutbBCLPRgwH8RbhPFaqD5yZZHNBsYPF50ZwE+nbL06zvcPcyGCr6R+4lMmE8hr4vkzWSjBP4BjX4ZWkUJIzRwcEmisgbB2fDhXIn0DykxD5pqP9fwgKxPYKSwAdQ8ZOqqqFqY4sxPdlGSg6Uj7DtUHJQ+nVpuRM3Hfwf+Jv1b6HZLkgV2wLitIXGnyIfejKUiNkLlwfe/UOH5OvUY2C3lLi7HFpPOqEudj2IwzA6dZa95qnzaYjcjPTXrvBPuGJnyAjvg2FFQNsjLGZpBNO8trS+AQuKDzg/lCBI6kaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ye4WtlXFeFYcmO1a/VoIYzH0HAGPIjqjBiP7I/WLvyA=;
 b=PuRW1oLNvAlIrptRTaKlAzPrO73LTqgGuyk9a2I32oy6VDQSPp90dIy7UVBCtk/Slp/Sy801piyHkGiPhVMa59uvFz/6uWpyCZ9dSu4URz56G1L5LogQSvhMfelgRWeK7nXe/l2g66TL/V0HDIW/X0mQ8uhi3unHYk6Hl2Sm2fA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 01:58:07 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Fri, 29 Aug 2025
 01:58:07 +0000
Message-ID: <a7947c1f-de5a-497d-8aa3-352f6599aaa8@amd.com>
Date: Fri, 29 Aug 2025 11:58:01 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
 <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0029.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::12) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9ac19a-fc8e-46b9-9cbb-08dde69f7f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clhHT0N2eG9OS2ZKbmhEbUUrYW92RGI4ZTdPWWYwSzB1TWRYdVBYOGFIend2?=
 =?utf-8?B?ek11a0tTTmNkeGVtN211TnU2Ti9OdW1KUkRMS2k5SjB6ZnVlandQdjFpUVFQ?=
 =?utf-8?B?dzQ1RGNhVHZRUUM3dUxIdC9NODhySk45bDJlNlJuU0RaeTNtODNRbWVGQ3Bm?=
 =?utf-8?B?R25YUHBveGVNd3ZRNXB2Sks4S1J0eXkyaklraEtITEhXa091dlRmNVRpSUdp?=
 =?utf-8?B?S3N5QkNZellXeTNObGFKYllFclB2YkEyNXU5ZXdTS2l3QzZLZjBTZEJ1b3I4?=
 =?utf-8?B?SzNxYVE1UHMycWR0OXJnVnVkcm81bTBPb0RYcGw2TW5aK1M3aU5GRXJTQ0xl?=
 =?utf-8?B?Wnk5dDdTd0tSZElMTVVDTThQZ1RkSEdlMlJDUm9xRlpsVWFRNGtZRUJJdVVW?=
 =?utf-8?B?N0tGdlo4V0Q3VWxLVFdPMTROUHFlb0NZb3F1L01kQUFHR3pFRDNTZ3N6dkRB?=
 =?utf-8?B?d2srcHRLYnZMdzkrV29sK2MybHZ2NEVpSktHanRSSWJtT0FGelVhOG56RjRj?=
 =?utf-8?B?SHN4c0cwbjVXZ21kblB1UTJGeXhqNXY0QVZBVTJLTzFsMGRjQ2M0UEpMM0E0?=
 =?utf-8?B?Z2pVWTFPaURGZnM4UWlUQS9kMjczWks2bWp4a1FIMEtJY0V2QWlxa0Z3V0Nq?=
 =?utf-8?B?TFRmMUg3OHFMcWJqb1Y2d3p2Q0F6N0NhQWZFMjJEVkhMMTE5VWdlV2RCN3hJ?=
 =?utf-8?B?ZGdDdHZXRitOS2JiZm9NcC9ISGsxNm5MYkVlVGZVT0RLaHZneGM4ZHpIb3BV?=
 =?utf-8?B?TmRZWU1OZWlHbCtSOWtKUkE1M0MwdFg1QkpxVEdXUFAva005TFlNQnpzSzNE?=
 =?utf-8?B?Rk5sc2VSVktlQ0JrSk4raWI4RUc3ZFgzWGNLOVdhaWN4c1BIYmFvd0RoRVZF?=
 =?utf-8?B?VXBPQVdweTRJaElIMk9ENHNqTUU4U01NNzNZcFZPZUtOdHhUb05rbVBtbEpS?=
 =?utf-8?B?VnFmSXdFZlFqVGdjTU9NNUFlSElIbTdoWDRVV2g5d2lKakhiSG1iTWo0ZFRz?=
 =?utf-8?B?R1YwcHE5QVZXY3NlTVoreFFVQmtEUlVlS1c5UFhZNGs4VFlPV0dHQkFabC9B?=
 =?utf-8?B?ampZejFFRjRSQ1RGTkN3MndtalZGQWlhQit1VUd4VURQMWlQKzZ1eThqd1Zo?=
 =?utf-8?B?czF6QVNieDIvNlE5WWl4ei9ZUGx4ajBNREsza29JRXEvcWNlemZwM2NvK1NY?=
 =?utf-8?B?RFNZeUxJRFEzOEJEbi9Nc0dnN1pKMWdqYVFRNFg1VWRTTWhNUUUzaDQwbzgw?=
 =?utf-8?B?ektmMmRuTk51anFVOSt4UlNaSE9HUUV0QTQrNnBTNDIxWlBib0dZalZ0RnRB?=
 =?utf-8?B?MWhRdW9hT0JVZUZnaVovUWoxQWF0bG9yTTd4czZaTGFpenZ1SW5ZbExXcEg3?=
 =?utf-8?B?R1pqRGljMWpLeDdtdVNhaGRBQWtkNTA0d3lrSW91djhmQkZYc3YyZ3BZek1O?=
 =?utf-8?B?b004azJEU09rQktFNW16ZmlkN3p3WXBrWkExUnp5ZXR6cEdyRXQ1a3YrTytx?=
 =?utf-8?B?NjFDYXExRXBWMlBJbGIwNUFqb0QxQUkrT25PSU5QNzY1U1N1UUl3cFpVdEdI?=
 =?utf-8?B?anRwNEdJM2tGR2VySFZwakNPTUI5QkpYNjJBaUd6ZGduMkJvdm5YZVJqanEr?=
 =?utf-8?B?VU1nc1d4aWo0OHhOVXNTcVNiNnVjM0RvRW5EL1BmMHBsaVZXQTZ2dUEvbEEz?=
 =?utf-8?B?aUd3czFMT3lNdkZNclNMVW1TWlZSNWUwdkp0WmdoMldqRC83RFR1M2FnalRx?=
 =?utf-8?B?ZTZzMzZhUFEzVzgwQXFmZzk2MXZJQmE5WHBUQUtCaS9neEZLTllQRDk2bkl1?=
 =?utf-8?B?WnhZNHhEMGl3dk9RWnFYWkpWUFcrK1RpOXZaK3psbEw5T0RDRUxnRkhiQmJs?=
 =?utf-8?B?Z2Q1dEJYRHZTL3BEa2NoMmlLcVE0aHVldmpsalNlempKYy9TNzRJVm9MTWRk?=
 =?utf-8?Q?FR8O+75geAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0pzVEEwSVdhVmQxUkFidzNpS0NQRlpFczcrM2xYM1FBeDJmaGtZQ05mK2ha?=
 =?utf-8?B?eXkrV1laYVpGVG9jY1NJRlVGQWtaOElDdDZ3RFVod2xYTkFaNlEyalBPV1Jr?=
 =?utf-8?B?Z0RTTk5maGtraVBWTWFYTy9mN0lPdC9tSnhuOXYzc2hiY3N4NklQUVh6TjRw?=
 =?utf-8?B?dVo3Q0FmV3AxOVk0dHIxVEZTdGJLOENOV2ZEaHJPWmh0dlM0emRRdmRRZGo3?=
 =?utf-8?B?SWdQRlBSRnBJMW1rQXZqMk00SE9TcllKcURnWHhpajVPS0cxVEdNZjUyZ1FQ?=
 =?utf-8?B?RzZMdFhQTUQ1eStObHNGWW1Ma2VJRmtQc1FydFh6dWY3SytiYkwwTU1lSFQr?=
 =?utf-8?B?T3RobmZZT21jKzhPd3F0YTI3TkJzdW5sMFZvOU1DcitSVDc0ZVpzWDEra1Y1?=
 =?utf-8?B?Zjc4STF6dTZQSFliTmh1NHFjOGpBdWhKcU16U2k4MS8zU3l3WXZra1luZ0pL?=
 =?utf-8?B?QWowcXFjL3VXbEVzMFlpV2ZFRTAraW1CRjFQQkhMRXFnbkRrOGUzVHIyUWcw?=
 =?utf-8?B?RG1WZmxvbzIzMVZLUGVmak1VSUx4MnpoZUJwVVRDUXo5UU5WTG03SkNXOVli?=
 =?utf-8?B?b0NWcXJpUVEveHVNcXVXdzRMMDZ6RnhmNnE2WnRvU3JHV1lQNFltemJZZGlu?=
 =?utf-8?B?K1ZUTG9uUlppQkRHMENjaktScnBzOUpOcEMrRFYzN1BIODdKMzdVWG03MG81?=
 =?utf-8?B?eHZEd0tiTDJ2MjBsNmM3TTlyZWZqbFp4TnZwRDc5ZFBNaldDRklvcHdUTFMz?=
 =?utf-8?B?bnVSRFVaaFdsVGdvRlFNSkNhUFl4Y3VmOWZURGMvWjZaWWRUZldQb2NORjFH?=
 =?utf-8?B?d3BDOGY2V1paUVAxSVJJeDRTM0t4KzY3WFgycDRrYUFvL1dFdm00Y3kxbUxT?=
 =?utf-8?B?bzByZkRkcC96M3BFWldVRmNrSGxIWDJtcy92ajFsTW5wS3pCdk9uZmhUVjVL?=
 =?utf-8?B?czFnWlREbWx2MVFEMWhVd2ttTEsrVlhZYy9HRk8zT3lnOVhiOGxKeHc1N3V1?=
 =?utf-8?B?MlRoOFAzbWEwUUVmUlRNVExMNnZHa1ZXdUtWRzlXWGl1TVFMYVo2YkI4UlhM?=
 =?utf-8?B?UUVNNm1oVGZzNVg4QVNGVGtYb0tZeFhjRWFFeVBXM21RdDU3Tk9uTHB5ZzR0?=
 =?utf-8?B?ZGx1YlZaYkJ0OUdIM3h1YStaWHVhSmZUZm8wWFdBdXZqWTVPUkxhdnhGSEtv?=
 =?utf-8?B?VXBmVitFa3NxUDV0NDN3M3B5bGtCTGZrK2psWjhrVFFsNlNpRHk1QUI0T3V5?=
 =?utf-8?B?ZmJ5aGdZZ1dNMXV6dnhTeEVHNE4vVk5ESUhYSGdpZmlLVGh6N3ZZYnJuZEx5?=
 =?utf-8?B?ZDhWc3JRemVlQzZWKytrL1lXSTlHamJ0NlBFVTREeW9mc0xBNEh4dWhET2Ir?=
 =?utf-8?B?SkdtRVMzVXI0dGpZcG5aakgvTUtWVkVSSkxYMDRIamZZc3hDTnNOb3JsVnZm?=
 =?utf-8?B?KzJDdkVyRzhCUXhCVWk5QnF5a1ZVOTNFMENrY1ZSaEwxMUlteFlINDE1TURn?=
 =?utf-8?B?RGxDWU5NRGUxbG56UzNwTkpwQ3RKdzJoeUVMZjl3WkJQZnBqaXltZkJiTDNW?=
 =?utf-8?B?RkRSWEwvY0ZwMzZKekE0WldvdmVvcExrZHJPQTJyc0FUdEJXVHBKenZNRTkv?=
 =?utf-8?B?RHNpVG1GY0NuaWxTWVc2cWFnUzNOZVYwU1ZPUjE2QUttWUFxOUl0ZnNaa1FG?=
 =?utf-8?B?c2YrZ0g4b2Z1eXNCandSQ010YUN6WkxLcjQzTTQ1RFpWL1pYdzNZSlVzZ1hX?=
 =?utf-8?B?c1VHLzJ6aEZpYkpvSE5nQ2Q4L3BhUmU0aFhINjRxajhKeDhUWUluekRaSDMz?=
 =?utf-8?B?SWVZYWVFNms5MFR2Zi8vRW9PSk9EWnBRRmRBNUhjQmJSOFVqZUx4Q0U5TnNF?=
 =?utf-8?B?anRHK2ZCTzF4dTFDcExnalF2VGc5emhtRjF3RVFvWnFXczVod1JZZ3RhV1lm?=
 =?utf-8?B?UkhjOHk1SHl4Uit0NFdMMVA2cWYyU0Fma2VsUWdMdnk4UWxQUnlTelJjZnVE?=
 =?utf-8?B?VmhrWlZCV3UxK25yQmtpMGovU3hEYmtkS3lHSmZaWE1YeUF5eHNqRU9UU3Vl?=
 =?utf-8?B?U3ZyMFp4Um1uUDZSK0FlVlJucjdYcjNzS2tTRVRlZTFNOU9qa3ljeDB3aXo0?=
 =?utf-8?Q?8IEhfZ47VwLxFhQhQV/Ro6jwx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9ac19a-fc8e-46b9-9cbb-08dde69f7f7a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 01:58:07.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxDgvLZe25mym5mnDFcfUfYyRb8jRVvYnv20xO6glgd96FjUM4MQygpnnOXbPL6moYwGIuXeK0NT3BwpO8npew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598



On 29/8/25 11:06, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>> +/*
>>> + * Count of TSMs registered that support physical link operations vs device
>>> + * security state management.
>>> + */
>>> +static int pci_tsm_link_count;
>>> +static int pci_tsm_devsec_count;
>>
>> This one is not checked anywhere.
> 
> Yes, included here for symmetry, it gets used by the devsec_tsm
> enabling.
> 
> [..]
>>> +static int probe_fn(struct pci_dev *pdev, void *dsm)
>>> +{
>>> +	struct pci_dev *dsm_dev = dsm;
>>> +	const struct pci_tsm_ops *ops = dsm_dev->tsm->ops;
>>> +
>>> +	pdev->tsm = ops->probe(pdev);
>>
>>
>> Looks like this is going to initialize pci_dev::tsm for all VFs under
>> an IDE (or TEE) capable PF0, even for those VFs which do not have
>> PCI_EXP_DEVCAP_TEE, which does not seem right.
> 
> Maybe, but it limits the flexibility of a DSM for no pressing reason.
> The spec only talks about that bit being set for Endpoint Upstream Ports
> and Root Ports. In the guest, QEMU is emulating / mediating, the config
> space of Endpoint Upstream Ports.
> 
> If the DSM accepts that interface-ID for TDISP requests then the bit
> being set on the SRIOV or downstream interface device does not matter.
> So the initialization is only to allow future DSM request attempts, it
> is not making a claim about those DSM attempts being successful.
> 
> Effectively, Linux can be robust, liberal in what it accepts, with no
> significant cost that I can currently see.

okay, then may be put a comment there so when I forget and will be about to ask this question again - I'll see the comment and stop.


> [..]
>>> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
>>> +			     const char *buf, size_t len)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>> +	struct tsm_dev *tsm_dev;
>>> +	int rc, id;
>>> +
>>> +	rc = sscanf(buf, "tsm%d\n", &id);
>>> +	if (rc != 1)
>>> +		return -EINVAL;
>>> +
>>> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
>>> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
>>> +		return rc;
>>> +
>>> +	if (pdev->tsm)
>>> +		return -EBUSY;
>>> +
>>> +	tsm_dev = find_tsm_dev(id);
>>> +	if (!is_link_tsm(tsm_dev))
>>
>> There would be no "connect" in sysfs if !is_link_tsm().
> 
> Given this implementation makes no restriction on number or type of TSMs
> the "connect" attribute could theoretically be visible and a
> "!is_link_tsm()" instance could be requested via this interface.


But how? There is this pci_tsm_link_count counter which controls whether "connect" is present or not.
"if (!WARN_ON_ONCE(is_link_tsm(tsm_dev)))" at least.


> 
> This is the case with the sample smoke test:
> 
> http://lore.kernel.org/20250827035259.1356758-8-dan.j.williams@intel.com
> 
> [..]
>>> +static void pf0_sysfs_enable(struct pci_dev *pdev)
>>> +{
>>> +	bool tee = pdev->devcap & PCI_EXP_DEVCAP_TEE;
>>
>> IDE cap, not PCI_EXP_DEVCAP_TEE.
> 
> ??
If there is no "IDE", what do we "connect" then? This is all about PCI now, can we have active TDISP without IDE?

>>> +	pci_dbg(pdev, "Device Security Manager detected (%s%s%s)\n",
>>> +		pdev->ide_cap ? "IDE" : "", pdev->ide_cap && tee ? " " : "",
> 
> IDE cap is checked here.

"connect" appears regardless IDE presence.

> IDE is not mandatory for TDISP.

Is PCI_EXP_DEVCAP_TEE mandatory for IDE? I have seen a multifunction device with no SRIOV on PF0 (only IDE) but SRIOV on PF1 (and those VFs have PCI_EXP_DEVCAP_TEE). Not sure PF0 has PCI_EXP_DEVCAP_TEE there or has to have it.

Do you show "connect" in the VM too? There will be PCI_EXP_DEVCAP_TEE but not IDE.

>>> +		tee ? "TEE" : "");
>>> +
>>> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
>>> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
>>> +}
>>> +
>>> +int pci_tsm_register(struct tsm_dev *tsm_dev)
>>> +{
>>> +	struct pci_dev *pdev = NULL;
>>> +
>>> +	if (!tsm_dev)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * The TSM device must have pci_ops, and only implement one of link_ops
>>> +	 * or devsec_ops.
>>> +	 */
>>> +	if (!tsm_pci_ops(tsm_dev))
>>> +		return -EINVAL;
>>
>> Not needed.
> 
> At this point pci_tsm_register() is an exported symbol, it is ok for it
> to do input validation and document the interface.


Nah, I meant that the is_link_tsm() and is_devsec_tsm() checks below will fail if ops==NULL.

> However, given the realization in the other thread about
> tsm_ide_stream_register() not needing to be exported this too does not
> need to be exported and can assume that ops are always set by in-kernel
> callers.
>   
>>> +	if (!is_link_tsm(tsm_dev) && !is_devsec_tsm(tsm_dev))
>>> +		return -EINVAL;
>>> +
>>> +	if (is_link_tsm(tsm_dev) && is_devsec_tsm(tsm_dev))
>>> +		return -EINVAL;
>>> +
>>> +	guard(rwsem_write)(&pci_tsm_rwsem);
>>> +
>>> +	/* on first enable, update sysfs groups */
>>> +	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
>>> +		for_each_pci_dev(pdev)
>>> +			if (is_pci_tsm_pf0(pdev))
>>> +				pf0_sysfs_enable(pdev);
>>
>> You could safely run this loop in the guest too, is_pci_tsm_pf0() would not find IDE-capable PF.
> 
> I think it burns a reader's time to look at the top-level loop that
> always runs in the guest and realize only after digging deep that the
> whole thing is a nop because IDE-capable PF is never set.


Burns time too to read the code to realize that pci_tsm_register() does nothing really for the guest at all - the counter is not used (at least here) and other checks are very likely to pass and the function does not really register anything even on the host.


> Also recall that IDE is optional.
> 
>>> +	} else if (is_devsec_tsm(tsm_dev)) {
>>> +		pci_tsm_devsec_count++;
>>> +	}
>>
>> nit: a bunch of is_link_tsm()/is_devsec_tsm() hurts to read.
>>
>> Instead of routing calls to pci_tsm_register() via tsm_register() and
>> doing all these checks here, we could have cleaner
>> pci_tsm_link_register() and pci_tsm_devsev_register() and call those
>> directly from where tsm_register() is called as those TSM drivers (or
>> devsec samples) know what they are.
> 
> I am not opposed to a front end for the TSM drivers to have a:
> 
> pci_tsm_<type>_register()
> 
> ...rather than
> 
> tsm_register(..., <type-specific ops>)
> 
> ...but that does not really effect the backend where the TSM core
> interfaces with the PCI core especially because they called at making
> the "tsm/" sysfs group visible.
> 
>> (well, I'd love pci_tsm_{host|guest}_register or pci_tsm_{hv|vm}_register as their roles are distinct...)
> 
> I pulled back from "host" / "guest" or "hv/vm" when you and Jason
> highlighted this non TVM case:
> 
> http://lore.kernel.org/926022a3-3985-4971-94bd-05c09e40c404@amd.com
> 
> So the names of the facilities should match what they do, not who uses
> them. A Link TSM manages sessions and physical links details and a
> Devsec TSM manages security state transitions and acceptance.


Ah fair point. It is just that when I saw "link", I had a flashback - "link" vs "selective". imho "phys" or "bare" would do better but I do not insist.


> [..]
>>> +/*
>>> + * struct pci_tsm_ops - manage confidential links and security state
>>> + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
>>> + *	      Provide a secure session transport for TDISP state management
>>> + *	      (typically bare metal physical function operations).
>>> + * @sec_ops: Lock, unlock, and interrogate the security state of the
>>> + *	     function via the platform TSM (typically virtual function
>>> + *	     operations).
>>> + * @owner: Back reference to the TSM device that owns this instance.
>>> + *
>>> + * This operations are mutually exclusive either a tsm_dev instance
>>> + * manages physical link properties or it manages function security
>>> + * states like TDISP lock/unlock.
>>> + */
>>> +struct pci_tsm_ops {
>>> +	/*
>>> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
>>> +	 * @probe: allocate context (wrap 'struct pci_tsm') for follow-on link
>>> +	 *	   operations
>>> +	 * @remove: destroy link operations context
>>> +	 * @connect: establish / validate a secure connection (e.g. IDE)
>>> +	 *	     with the device
>>> +	 * @disconnect: teardown the secure link
>>> +	 *
>>> +	 * Context: @probe, @remove, @connect, and @disconnect run under
>>> +	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
>>> +	 * mutual exclusion of @connect and @disconnect. @connect and
>>> +	 * @disconnect additionally run under the DSM lock (struct
>>> +	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
>>> +	 */
>>> +	struct_group_tagged(pci_tsm_link_ops, link_ops,
>>
>> Why not pci_tsm_dsm_ops? DSM and TDI are used all over the place in the PCIe spec, why not use those?
> 
> Because the acronym soup is already unmanageable, please lets pick human
> readable names for major concepts.>
>>> +		struct pci_tsm *(*probe)(struct pci_dev *pdev);
>>> +		void (*remove)(struct pci_tsm *tsm);
>>> +		int (*connect)(struct pci_dev *pdev);
>>
>> Why is this one not pci_tsm?
> 
> Unlike probe/remove which have an alloc/free relationship with each
> other, connect/disconnect operate on the device. That said I think it is
> arbitrary and have no real concern about flipping it if you can get
> Aneesh or Yilun to weigh in as well about their preference.
It just seems rather useless to have pdev back refs if you still pass pdev everywhere.

>>> +	/*
>>> +	 * struct pci_tsm_security_ops - Manage the security state of the function
>>> +	 * @lock: probe and initialize the device in the LOCKED state
>>> +	 * @unlock: destroy TSM context and return device to UNLOCKED state
>>> +	 *
>>> +	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
>>> +	 * sync with TSM unregistration and each other
>>> +	 */
>>> +	struct_group_tagged(pci_tsm_security_ops, devsec_ops,
>>
>> Why not pci_tsm_tdi_ops? Or even pci_tdi_ops? pci_tsm_link_ops::connect is also about security.
> 
> On some of this feedback I can not tell if you are asking for
> understanding and asking for code changes and find the current naming
> unacceptable.
It is "both" pretty much always.

> In this case for a major concept I want a name and not an acronym. I am
> open to better names if you have suggestions, but please lets not use
> acronyms for something fundamental like the split between TSM
> personalities.

pci_tsm_devsec_ops seems more reasonable then.


>>> +		struct pci_tsm *(*lock)(struct pci_dev *pdev);
>>
>> pci_tdi?
>>
>> Or why have pci_dev reference in pci_tsm and pci_tdi then.
>>
>>> +		void (*unlock)(struct pci_dev *pdev);
>>
>>
>> So we put host and guest in the same ops anyway, what does it buy us?
> 
> Identical lookup mechanism pdev->tsm->ops as there's no need to waste
> another ops pointer.
> 
> [..]
>>> +{
>>> +	if (!pci_is_pcie(pdev))
>>> +		return false;
>>> +
>>> +	if (pdev->is_virtfn)
>>> +		return false;
>>> +
>>> +	/*
>>> +	 * Allow for a Device Security Manager (DSM) associated with function0
>>> +	 * of an Endpoint to coordinate TDISP requests for other functions
>>> +	 * (physical or virtual) of the device, or allow for an Upstream Port
>>> +	 * DSM to accept TDISP requests for the Endpoints downstream of the
>>> +	 * switch.
>>> +	 */
>>> +	switch (pci_pcie_type(pdev)) {
>>> +	case PCI_EXP_TYPE_ENDPOINT:
>>> +	case PCI_EXP_TYPE_UPSTREAM:
>>> +	case PCI_EXP_TYPE_RC_END:
>>> +		if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
>>
>> PCI_EXP_DEVCAP_TEE says nothing about "connect".
> 
> [You already said "Thanks," above and then did not trim your reply, so I
> almost missed this, please trim]

sorry, my bad, I am typing the answers all day as I go with the merge, missed this one. Thanks, :)

> 
> PCI_EXP_DEVCAP_TEE indicates potential presence of a DSM.



-- 
Alexey


