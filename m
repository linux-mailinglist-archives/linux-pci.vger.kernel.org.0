Return-Path: <linux-pci+bounces-10632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6193D9398DF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 06:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD79B21A56
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 04:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F78413B7A6;
	Tue, 23 Jul 2024 04:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PxYCqLOu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490161FE1;
	Tue, 23 Jul 2024 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721708802; cv=fail; b=tfYU4jJjubmXlDKmIWGHjD5rLwiU5cvVbCGFBvTG47I366KDAW+BfLoIxBYnlrXDY82DNYNi7N6JEUwU9l8jIoRIFWXz9P908boaQVvOfVmE9z35b6klRDII3mY4jpnKhPtce+0ebodCYwbBmpc0vZebso4XvHPgxILO0DcTUEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721708802; c=relaxed/simple;
	bh=e61On6m6dF/5KiRdTyXF3Ld+xwJme8LARgHlozjUUz8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rIlYaHrkdKJu0YTO8z9Bmoh9+3lQghXou7I94yaFzun9Uy1OHZ1/O/1XSQ1gYzk0GA0ylWYYn9kH5SSyxP2uOPBbPxdrgYvmElcEx/9NdeOKmv4Qkyj89ByuQCfXZ53TkRBjnv7zGCSp+1XbHl593mkyEWR/7gYL85GgPEncU6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PxYCqLOu; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl/yPgMkMBVq3TTWE2iTTy2X6V3DoeicWOZxcQ68PK6Ta+2sa9EsKMKswbNpjDhLEyRE1zCmflaVDfQxXs+RCp1KHK/tpjXyFDR5hE0NRLSLjLemOz2RKoqE7JTF5jXi16ig6h0fb1Dz7U42tjnPoCRVGqxtOEoNTxRQSL9rLDPC8XtPRMHkqXtgy3qT/tOfEbaVsXE9rczwoBhWQb/01KuOQ7c2ryY0Ka9zbwwYlKRtWBJrfFiDtJAPrGTFOLXSHNxfL5iYtI4mHvGy90tikUEb5Nu9iQtFdB0sL+AfRMC5r1t7EVZ2GFZ2i1AT3cm2eDUd9ADaHqzcyZhr1teYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TGROUxPvSJkYfyB0Pn+qgfE4jGUky3H4j54Ymi6mCI=;
 b=QLxn7o3fJtHA7UBmTaeORix/BhZ56AmjWLSyRVcpR7oF+x12Xs3jQdYs6JuqAaNN+dvUje5KoWCQpgsCDYDMXaCi+IK6EdqcO2lOnkJAD0AYAj9Bk5v4JZspAtat8rFsGoEnKYZhbCRq63B00Dx+97ibRjkSxmNlNUlsYFz3dt3kjeo3N3VBUXpl2lzAfGnVmKq6ZQgB7hb46NbMwiqSNztylA8WE0lzhcv8uCM2jEMByac/tUaipQkNK+rbVO4ShwWf3ycGs/nYrEQwmL7DjPFnrug00jFnEq88KZbFFNmwJRld/p0tmiy0w/dvJ19uenDorlNtQDa7bj7xlBVAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TGROUxPvSJkYfyB0Pn+qgfE4jGUky3H4j54Ymi6mCI=;
 b=PxYCqLOuwlAhpZc3jVHfsMAQoobizIjNbql+haQlhqoyGPJo4LvWO8Twi1nQFt2ZgMoAoUY5/Rn9Vg4fO9UuRyo4Wkp0HjiKYalgg87Zx1OHcIYK2d9V0GUNL0YILQG1Lcw1w40mSLP0MOQha2NI2vrGgo4+kPXgq02REB5olns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 04:26:38 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.7762.032; Tue, 23 Jul 2024
 04:26:37 +0000
Message-ID: <de1ca8d1-b876-4b0f-9151-9303317b4d2b@amd.com>
Date: Tue, 23 Jul 2024 14:26:23 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <kees@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxarm@huawei.com,
 David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Dhaval Giani <dhaval.giani@amd.com>,
 Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
 Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
 Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Jann Horn <jannh@google.com>
References: <ZpOPgcXU6eNqEB7M@wunner.de> <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <6695a7b4a1c14_1bc83294c1@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715232149.GY1482543@nvidia.com>
 <6695b29d204e4_8f74d294f8@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715235510.GA1482543@nvidia.com>
 <b297cfe0-c54f-4205-b102-ba53ec40344b@amd.com>
 <20240722120642.GI1482543@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20240722120642.GI1482543@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:404:a::14) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c065df3-2abb-42c2-6bc3-08dcaacfa47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RC9TaVFzcmdnOU5GUFIwSXQ5M3p0NkljUXVJRzd6S0NyalhyTzVCaityK09U?=
 =?utf-8?B?L0dxWnh1N0Rodm9IZGIxWWhKQThvMXBOT29uajE0SjVkRU1uQnd4RWlkYnpX?=
 =?utf-8?B?WXF6bCtrZTdDc3d2VDVqZGp0UHVuS1FWY2hQQ0dZVElldTZRbXEvMHBudGor?=
 =?utf-8?B?QUE5a0M5bHRZTkR2MEp4eWp0UEk5WFNnUVB6SHQyYkFKOEFaaG5wQzEyNG5n?=
 =?utf-8?B?Z1ZONTVKWXZqVXJjcE5zZVVweWYvcGVRcVFWTWFsMFpSZW9NaXVDMElkK3Vh?=
 =?utf-8?B?dlp2aXRPK3VsOUVSTG96OHpJc3R2TnZXQ1ZLQzV3bVF6OUhaTW9iWFUvajFC?=
 =?utf-8?B?eEF4RnZxQUE1VEhNaTJRcDdMMmMrSTNSM0RLR3RYTnlBVGtFcWNmRyt0MGV5?=
 =?utf-8?B?Q1pKMjBEZzMxeDI5VVBKY09xdnpGYmN2azJVWVdrVEgyWERiYm5LQjJyMks4?=
 =?utf-8?B?YW9kNUdhZkZTMnVWb0N4Y3c2c25IMGRQVG1lNVpmM3JpOElVenFzMDBOQW8v?=
 =?utf-8?B?dHZ6b1JDK3pHRWpHakxrbTIzR3F6b0xpeldJY05NQzBSNkE2MkdINENiTFZI?=
 =?utf-8?B?ODNFbDNBVG96SEVaRWFXV1lucFpsYnlGV0NoRUpXY2ZVbURSV21zdVhxN1Ew?=
 =?utf-8?B?QnAwUW50ay84UGUrSjV4ZDE0M0tFaGxLc0VjSWs2ZllrTXhzQTM0LzVrczZJ?=
 =?utf-8?B?VUloeGJtQUlkV0hsUlZzU0F5N3BhUFZockxzSzFSQjlXbXRNekhhekt0blJp?=
 =?utf-8?B?NWd0WUw1dkpjNS9zNmcxTHNhUW9NMVAzd1V0V25qenNBZy8yWlZqbHByZ1Rw?=
 =?utf-8?B?RGQwNVlhZ1gxNEpNbDRDbm1NMExHd05pSHZXWWR4cGlJYzdvcGRoQTFZN1JX?=
 =?utf-8?B?VmRoNlhNMmpPY0pZektmZ0ZOZjBPZ0JyMUQwOVBiZW5EUW5SclZTbzZhQjFL?=
 =?utf-8?B?SVhIcFZzalpJbmQ0YmY0WGNIYnE4VFN2MXR4ZUlYdldxM1oxcDZZTWRYSTlY?=
 =?utf-8?B?OGJ6NXg4V3ZuM2czSHBudXZOMjZJc25HTjkyMlVuU2NKdUIrNm1ObjMwdWt3?=
 =?utf-8?B?cXg5US82T3NQQ0wzeEJTemdwY2RRSTZoYjBPRGNWTFd3ZHZ5czJVSlhmRWk3?=
 =?utf-8?B?Y2sydVAwVjZPWjFQUUM0YjJZakg1TzNIeWxVZEYycVUyRkFJdUZtVml2WjRI?=
 =?utf-8?B?Z0xGQkFROVJLcUhUQnVMR1BFU29PZEtiak1OOTNCTzJtYXB2NWRIVURYSUlC?=
 =?utf-8?B?NUIxMno2ZVpOZWZubVJkY2xJMy9TYS9yVnJMU1g4WDhvUG5zTnJpMXFvUk9h?=
 =?utf-8?B?MDJ1UlVlSERFNkJGTXB2ZzdTQnUvdk9WdkdtVy8wVkNndkVLcVlIZmhVd2tm?=
 =?utf-8?B?NVJDY2x1L3VkdHI5VnptTTJDZTloQmlVMVcyRVdIaVo3czFHejVKdXlSVjgw?=
 =?utf-8?B?VlFGQXdQcjZqRHcwekZKK1JKaEJDZUdyTitPY2JTbjB0RzM5OHVyRWZQTEdP?=
 =?utf-8?B?WWtKMGhXRUY2Q3NXMitCVUxqTFBtUVFrb3EzSTBkbVFKL1ZoaWRJVkF4Qkk5?=
 =?utf-8?B?MU5TKzVEQXlKMFUrTXYzckFnWUNaMzNlQ0ZBanBrRTZsaG1MYUdGTWsvM09F?=
 =?utf-8?B?QTNqT1N6a2FmVHZkbmxGVzJITFp5VlZ5YTJReE9HQ2RiYjRGZ204T3k2MUZ5?=
 =?utf-8?B?MUtHanM3SXkzTzRxaGJEQmdCTjcwUys1SEhiY2RFclplc3czd3QzSWk5aHVR?=
 =?utf-8?B?U2JUYWNaRHplM09mcSt0d1pTOUZNU0laMlprZkdISnpkU2N0YUZWVXQ0Wmh0?=
 =?utf-8?B?T0p4dktsZk9JU0d2YnZ5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlRrNnptbzd6SEdIYkpWUkwyTDNjQkI3WTMyT0hHZXdxdDgwQ09DMXBaUFE0?=
 =?utf-8?B?Z3RKTVh6RS80eGRNNjhvZGxIVGZzTVpXNFJLNVJXN2N6VURNakxGcUhGZjBz?=
 =?utf-8?B?VHNWSVlGV1VnWWpsc3ZnQmNjM05QY2pwOUYza2xkbDFIeXhUZUhwaUplaUpK?=
 =?utf-8?B?V0dqbDZtRFNySEV2VVFkbXFLZm1udWRPbWNoQ3R5RHU5d1cvdDJOZlhRNHRC?=
 =?utf-8?B?bmZPN2tDNHVPZjZ4L29zZitDck9zTzRYUUFHK3FpUSt6ZFJBc3FTTXFYd3V3?=
 =?utf-8?B?ZnNqTFVDeUI2bXBsRmdVSnEwTmN3V1pnSDlJa0JmK2hhTDUvZ09ta252My8x?=
 =?utf-8?B?OGwyRG9aNmlBU2xJalhvaElydExpTlVldGRsTTNOZmFiOWZibnpVdm1lTk1w?=
 =?utf-8?B?RWxOSXR2aHQ5dHAxVTR6NzZWWHJBTzZrTHFuSG1aNTlHQTNSb3pUSEQ3NTVU?=
 =?utf-8?B?eHN5SlNtNC9QcWhlcFpPbS9RekkvWTQ1bWZOUE82ZUoyckhBaElmRzdSYVFD?=
 =?utf-8?B?aDhRSzgzT3ZuMkYvZ1pJcEkzWjR5Z1NjbjRxVm1ReWFaMUxEREF6MVpRTXQr?=
 =?utf-8?B?aSt6aGtIZkJhR243OTlXWllFTU5PYTdzSDAvUldydVBjVjdhOXhIMDFYUGJO?=
 =?utf-8?B?RGZNUC9aZmY4L2xYRlRzbFR5eUxUUHV4NHVlYUEzYm5aUExoSm8zd05HS3o3?=
 =?utf-8?B?MUpFaXlyeVB1ak5JUjBqZXhSWnZnRTBvRjdNYmJiUTJyeFllRzJSSHYxTzZM?=
 =?utf-8?B?YzVyZCs2bWlaeGprRTBZalloQ2F1Vjhod2syaHpoak5mRmhBSjcvaUYvUzNP?=
 =?utf-8?B?TUEzMVpJUjY4NXdZcTlWZ0JxTHR4NDIreEVTK3crd1gwRFVTSFpBNy9pTlp5?=
 =?utf-8?B?NUtmQWhJUFhYWEYyMXFvYTdZZm0rNlZjRGgzTENQbzUvL0RNYzB5QXlwbG9y?=
 =?utf-8?B?VVJPVkJvQnc4aHZGZTBGTjQ2b0J0MWJ4eTJMbDdwOTVmOExZTmgzUG1DcHY3?=
 =?utf-8?B?L3RWMElxMUZNck9kQ1FqZEdJempEVzZvbFdGbWJxMWJGRi8vUEN3Vjhua2Z3?=
 =?utf-8?B?bG54dzlwd0ROZzU1RVhrVmEwVWhpRW5yQ0hTN1F1U3VRZnBwRGhnQWFWeWd1?=
 =?utf-8?B?UXZJZkg5MDFnVzIvcDU1VnV4bWlyb2hsQ05POENZeC91T1pwajk3VzhEdk9T?=
 =?utf-8?B?ckhxQUcrek1NdVdPako2MEU3cGUrYU9KcERIbHNIWHJpZWdSZzVnMkx2eFIy?=
 =?utf-8?B?OTdZRTRDbnJCRE9tSHZIVnBQZ2NkRTgreC8xYklaYWczQXhoczZTdnNTS3J0?=
 =?utf-8?B?VUF4dkt2MVVqbzlIMitZUnJFNnBqdzg3eWYxT2k1MndqRW1VS05nS2hTbjNP?=
 =?utf-8?B?K2I3ZXhJVTVjdUVjMEhCOTRMbEdEcEp2dXEyL3BTK1o4aXRVOVczUHRPMTlQ?=
 =?utf-8?B?NkJ1RXh0bmd2N1g3U08raHg4QlFuRVg4ejY1ZHFQdGIzcjhZWTdGQ0hPSDUw?=
 =?utf-8?B?SXh0b2N0SGVwYUdOcWJWenJvZkh1Qnp2US9taW1WQmRYZWpub1dTK1g3U2NS?=
 =?utf-8?B?bnNxWmc1aHR4UlJBcWxpOGptM21RWDhVSDBiY0puaGh4VWZQWGMwV3BneFVN?=
 =?utf-8?B?SndqMVlmYVZoMm1vM1Q5ckVTSFdXeCtGb1ZHd0J4WW1CeUJEaEk4eDltcnR0?=
 =?utf-8?B?bmVTODNnTUdrL2RTd1g2VWpiaVBPemdsMk45NHpaeFVaNXA2YmVNQ2p3cUts?=
 =?utf-8?B?R0dPeStxRXNDbUVxNFZ4dG1qZFBXRXpsNzJzbnVFcjBYYkU4blVHcEFuWEZT?=
 =?utf-8?B?N3dqUEt5bmZhekZoYldIdGdmU2dlZHQrRTJsbklYUk5BSUw4dzg5Q3ZKYVpj?=
 =?utf-8?B?bnRWWDhrODRaZC94b0dkVHNZb0ZTTmtqb1lLdncwRm96UFdiV1FJUmtiblJN?=
 =?utf-8?B?WURoWTJYZkVhaFZPWHJMc0ZZUTREWXZoMFJLSGNPeWZFc3ltUGVRY3pBK1lx?=
 =?utf-8?B?ditneDhVZm1wbE5HbmZRUEQ1VmNtSHdIenFxVlp2dmNPV1hnclZ0K0ZGMkIz?=
 =?utf-8?B?RnVPajYyaFF1OVFEYlczbTQydjZFWEI2clQvbEhXVmhJZllvclF0dzdyME1I?=
 =?utf-8?Q?P1wHysWBzwg61wtA6ci4X0Y4l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c065df3-2abb-42c2-6bc3-08dcaacfa47d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 04:26:37.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RwbfmKfAh1BBSIzbXxfSY5bHKDIPxLnC3sCf9xNZZh1KpwJx3TkixTqRFvMY3lnmWLKQU0PnTvMyvjWl3/hqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576



On 22/7/24 22:06, Jason Gunthorpe wrote:
> On Mon, Jul 22, 2024 at 08:19:23PM +1000, Alexey Kardashevskiy wrote:
> 
>> If there is vIOMMU, then the driver in the VM can decide whether it wants
>> private or shared memory for DMA, pass that new flag to dma_map() and 1)
>> have DMA memory allocated from the private pool (== no page state changes)
>> and 2) have C-bit set in the vIOMMU page table (which is in the VM memory).
> 
> Not all HW supports a flow like that.

Fair point but still, under what imaginary circumstance a driver could 
decide to flip T=0/1 when up and running?


>> My V1 says "all IOVA below X are private and above - shared" (which is a hw
>> knob in absence of vIOMMU) and I set the X to all '1's just to mark it all
>> private.
> Is that portable to other implementations?

Well, when used as a big knob - 0 or the max (== flip private/shared), 
then yes :)


-- 
Alexey


