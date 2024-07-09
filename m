Return-Path: <linux-pci+bounces-9969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B72892AD3C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 02:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C1828247E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 00:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D611EA80;
	Tue,  9 Jul 2024 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UteIjJb+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999410FA;
	Tue,  9 Jul 2024 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720485945; cv=fail; b=mZm4jxpFYn1xJPcIiEYxD6qYPKhyhMwXSftw+TixzHtOJtk6c3AWKT+khTB4cEvpv3xZfFWr63L/IUqDx0Wtl9V7NkztrzaEcQS16bE0BQ21izTdgGA7t75tw5OC1Cyccv+CQDqkb4dQtBzXEVrWV/2/XpH1HGWeBeQUncqut8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720485945; c=relaxed/simple;
	bh=rGFr0jN3Ie3bvyaORMNdQ0xbRTSgux4SNRR2pP4kHKc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rz5/5frlkAqaBXE1dfHtb8Hic9TwMSgdTEHeaZIbJZcYgBPG1Ey8bQQtSLQ+CqeErlBEFTPM7r5d5NpeML/WZHMtJYVyGqNjK/ff42Xny+cKrTTL+8PU1qiDZg8ZKIw+4IK+GJ/bNq6TXgcOx6BSaZJnjanFmJQ7TgorfJCMWHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UteIjJb+; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1WQ2z7m90w22TI2ebD8PU6ev5B1ibXbPyJBZ8yTmjiaf3nDsoMDIUxHkE5RJHMQsH5iJ5V0Nn82auxXl1aZJE8ZAkOJGgWGiwJi1KCxkEJkOs2W5Rx105+z7dU1ugYcX2I28S5F2Sl8lwwOYjtU0PCTo9cmCwlce4bcCTud1yWI+cwTZwaN28QV9k5yhM7LW48mTBeFNLAimp5E7lhlbq97SIRqkDcJ97zd+YNrNgyQ1NWW+nsZFAIti39BNFapCp8/bsAFQrG5y0yNkVyoKtGNOpiZ1ecF+2iWcuap2Dj6NDlJ8b9rr4+HoXXHUUry/7Hu4jesz+OxFf4OA5vuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUTfeJBv2PsoDPUeHTGIRl0vzv6SecbVWj6TOPuNzrc=;
 b=lWYl05ho7GSmBfP9ko1BR03JvoERcpdbN/AcbCr8WLWPrDUtwqxnC8JjtsPRtIZaERoZiZkMBNvsTQ3r8lEQTFY123GQBo8cGTcK9Kc/+sGPjglTlydR0BkMfa2nPS1plRrkBOCnR1ARbve59EPWUfrUevzwBpYa7GMNJG5Kru9++m9keKl3fcxMWkjr49StfV9Ilg3PrtcBvEKqQN4F1W14H00+pDsKTqMvl8j+URT7bdNOCKkzBs/RW+eZ04iPP9e8i3GGrlg34LI0+bM4imEayFfeEVhtVJEFEcqjz3Uc97Gs/oWwuIUy0lKirz7jVZYsCgohyrG4did9GiF2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUTfeJBv2PsoDPUeHTGIRl0vzv6SecbVWj6TOPuNzrc=;
 b=UteIjJb+nodnJIRIJDUvHf2//toi7Tv05XOKyKtcH406PCr1M72xA2XiK+fSxKU9mJRFyLLPRI7edWTkxyRuJhbd+6K6y2mr6FpF2EkeOeyrLd1AHY6floOc1a+ECX1JmZPLzRrJNC9/g6ZnMVT147+zLXL/rPHttLX9FI0GQxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 00:45:40 +0000
Received: from LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::dcd3:4b39:8a3a:869a]) by LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::dcd3:4b39:8a3a:869a%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 00:45:40 +0000
Message-ID: <ad7b3e48-2e61-476f-8fea-28424f46d306@amd.com>
Date: Tue, 9 Jul 2024 10:45:27 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 07/18] spdm: Introduce library to authenticate devices
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxarm@huawei.com,
 David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 "Li, Ming" <ming4.li@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Dhaval Giani <dhaval.giani@amd.com>,
 Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
 Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>,
 Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>
References: <cover.1719771133.git.lukas@wunner.de>
 <bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
 <26715537-5dc4-46c1-bdcd-c760696dd418@amd.com> <Zovha33CS76PwAMF@wunner.de>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <Zovha33CS76PwAMF@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0108.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::14) To LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9213:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea6bc1a-6da3-4e26-d3c3-08dc9fb074ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGNLRHZMUW16RndqVm9xdWk1YVZSdHk5c2ppT2hrb28zUWN6Q3dwOFlleEpp?=
 =?utf-8?B?VGdHSGNNODYzZzJHSzhocFlwWSsrTXZhc2I1S2pHUk12cWozZG02ZDVTTk1q?=
 =?utf-8?B?T3pNOFc5S1NVRmw3VG1jaXZoN3owSU9vb1Bzc2dFeFhwdzNOVHlBTURpdHE1?=
 =?utf-8?B?Q0lIMzVxRzJCSTl3Umtib0JMZEhUNFBRM2QwRjBnTXpLcVpSVkNlalk0NFFT?=
 =?utf-8?B?eEN1c0szdUkvL3g2MWUxQ2FhejJhZUd2M3MrSVVONjdCL0tjTWx5dDVWOE0v?=
 =?utf-8?B?VTNRODVnK3JQRE5LUlFGckQvc1o0YVZCcW9EWEtEZ1pROE9SK1J6aDFLWE5n?=
 =?utf-8?B?dVRnc21ta3lzWTE4dFhrZXFnK1EyNjV3MkxEU1BrODAxY0lIN055S3pkNTEz?=
 =?utf-8?B?ejc3bWZRWllreldkcGN1NTRWcWxBT210cTNtZEdXVk1QeThrVUJ0QlV3ZjRF?=
 =?utf-8?B?aTFDZ1J1cW1TVE5BakI2NDFRT0YvNnJtelplYkNZbDNmT09RQ05KeUdYR25B?=
 =?utf-8?B?eUtpWXFCTmtGRk1OVm8wc0JGNllOV0MvQUtVU2x6TE1Gd09xRkFVRVVGSXNm?=
 =?utf-8?B?Mkh4TlZFa05CalFxaHN3VWtscFpnbklidGZ6RWhmODVYa2QyczFYRkNQdmxM?=
 =?utf-8?B?V3JoalkzcFVVUngvUzYzNk1IcUgwQnpkQTRrRHhjcFZsMkFWcUZVQXBPSFNO?=
 =?utf-8?B?RWZTYUdIeU9GcGx6a1MrNmc0YmJLMTU4OG9TbU9EOEhzeXN6T0hGMmJBVFNx?=
 =?utf-8?B?dTBVa2RNNFBqV1VVNDBIN091cURreENWTWFVajZEb2xPQ29YbGFCcStFbGR1?=
 =?utf-8?B?ZEtzcjUxQ2YyeHZJZ3hKK0ZBaEVnWmQxUUptSGYwaXNZWldZMmhJbEhUT0lK?=
 =?utf-8?B?TStLR1Q5aUJnNVFheXVSM0crT0dXbTRSY3lvL3NSeEFNUmhqQ2lKZTR1MzJM?=
 =?utf-8?B?N0s1Vy9hNFBydG92Q3RSOU5DU2NwR3hNNUxndlRaVWpENWEvTUhySWNneEhp?=
 =?utf-8?B?M2c2d21oaDZuMXZ5OEJuMmZQUFRCQVh0V0QrcENsSlVmT2IxQkdOVU5mVC83?=
 =?utf-8?B?OXV5WEhiSFlWZTEzOFl3d1NrWG5VMTF4bVdKUlBvZmNQS3plYkFHbmowT3Nr?=
 =?utf-8?B?MFcxdkVlNzc4cGFlNm5FaFlyWVV0MmlhclpMZkhYWDJzNnY0K3crQThqOCs1?=
 =?utf-8?B?RjNLcXVXanp5dzRidytQaEJkRzVSd3JlbXJYRVZVcUVqTnRxSllvSW12dzlX?=
 =?utf-8?B?eCtQbkJFU2w5WXcwRU00a0FXcFdCWkw1VUV2SWs1cWZSUTd4RzZNR3plMlpt?=
 =?utf-8?B?VXliSHNPYkp2WkhITU5WRTEzazRzY1JZL3cvMmEvSHJFOEtkbzh2YXU0eDFT?=
 =?utf-8?B?MmQ0cWJRTHhyeTh4Tm01NWp4YTkrQmdWengyS0ZVZTVhMURrUEJuQkVZZ0xC?=
 =?utf-8?B?VU5IZSsvdWVjN2hhWHhuV3pINGFEOU5JeXM2OTcvUDBmeHhLZEFXdE1LdTZs?=
 =?utf-8?B?NGZmeW9neDdYQVRYQU56MzBwRU9Kc3ozUkxKaGxqYm9qb1hQR2Rza2R1clRC?=
 =?utf-8?B?dmgxc2g4UVQ0UzlXSFBVWkhDMGRzUjJCL1NUaWN4ODJuaEJhY05qVGJtZG9p?=
 =?utf-8?B?VkRMWkkwU21tM2RrM2JTQ0EyeUNGWlNpNU9HWUxLc1RKQjVvYmg4Y2dSS2NZ?=
 =?utf-8?B?ZWw0QUp1RDZqbWIxNGhrWDh1VHRqSmVlYndvYVJHUjF5THZzdlFmWkUrUDFi?=
 =?utf-8?Q?AeEvQf6qrFnLQgchj04uE5tJL+l6/yYC9yKBOTx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9213.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2xqUDFiZk5GZHdXbVdIMERuVGpNc1JUWXFKVkZ2RFVNK0JNbDlLUmY4U0Z1?=
 =?utf-8?B?NnhQamh3eTRwNWc3ZmJZT0VtR3d4T3NwdEk1bVVOUmx0RmFoaldWRXVnRmVS?=
 =?utf-8?B?S0RZSU1ldVladWxhK0hzKzNEUEtTZ2M1MGp2Q0ZQK0pja3JQbnd6UEJvVU1q?=
 =?utf-8?B?c25wMk5peEt5OExMR080bzhSZEQ5SzdrV2gyaE9VY2JvdjVMUTVTUVVwR3Ir?=
 =?utf-8?B?bGtnVGE0V2VCamc3eXM1dUVWVFU3aEQwYThjejNpWmxiMG1KaWhLc1hwQjg0?=
 =?utf-8?B?dGNqUFkwT2ttYUlVSmhrdnl5RUF6S1RFeVhkK3JnMjFOQ3l0SEF2YnBrSUZq?=
 =?utf-8?B?L2d2cWREbEF6ZTRnYy9CTmZqczUrQVY3ZUVnNldUczhlWFZ6ZXVVU3NoRWhZ?=
 =?utf-8?B?V21UWEZjMWtTdERlQkJBQUVmcFhBR2VSODRKcDEyZ0lkVXZPRVgwWHFvRXM4?=
 =?utf-8?B?d0lUSXhsU1RJQkM5VEI0Y0ZGZWl4anlxc2F4MlcyTkNHSlZEM1FiQmRZdmlT?=
 =?utf-8?B?dm1laXpJN2NWa3IvZkhtNXdHZHNPTmw1czYrTmlIYUMwcXlpSFJQTGZZb3dZ?=
 =?utf-8?B?RkRQdm1pMkdnMzc3cCtLVm93cThZNDZFa0FUZHFxUG9JTHhlTWxRMExHaEt5?=
 =?utf-8?B?Ty91dmh3STI4WGIzeHZRcDFNbWtSMEtsM1hCWWZCQzA0OUMwaEdqS1Y5Tmla?=
 =?utf-8?B?YWJKZ0ZXUWVHSWtGWVI2L0VyZXowV3NLNjBIMzYzdElSQ3E2a1Q5R2hoNGxp?=
 =?utf-8?B?OTdDSnVaend2ZkYxK0RSRzBjeFc3L1RBL3FHb3orMjVUd0tlYWxvNmtRME9p?=
 =?utf-8?B?YjFKb3c3TVpOZGNyd0kvWGdVYzJKYjd4bTJmZHhNVGp6cDlzbC9SZWp5RDFm?=
 =?utf-8?B?SHZKZWNMT3lyZkhEYjF3aVV5ZTFTMTZvUzk3ZXcvKzNTR0JYbi9JeUgra0hC?=
 =?utf-8?B?TmoxY2NNbjJBV0tHS2dnckZlNk9pOXdnSmJsZWhSa1JtbVA3TEYxS3BncjBL?=
 =?utf-8?B?TWRDSkZKT0h0RGg3dDZBSlg0b2lITHcrMGRNZUtsVDZnMmJkOWxTb2xxZUxk?=
 =?utf-8?B?ckRydjA2NUN2TGlKalp6UzFCNG56ckdrSDk3YVRYdDdkeG9vVHROWkpHZHVs?=
 =?utf-8?B?a2FyMGNNK0FjNVo0bXFCQmJWV1B3TDlZeldpb2FzYTUwbERSZ1piUnBZVXd0?=
 =?utf-8?B?ZnhvYytKdzZRaUdJemo1RThDKzlTeE9WQVVzN094OFhuNHVGaGlGcHJ3aDhN?=
 =?utf-8?B?a3BFbmlFY0M4bDVBdUhDODc0WFVydFNobXZzbU5SNlVSRDBUNjRYZVdxanU5?=
 =?utf-8?B?VTlBN1dYNUZsZHlJM2lvdTdJRU8xdXVVQmdPdTBTR0NvQUxhSGR1MEtRaElz?=
 =?utf-8?B?aWFHZThnSk5jcWZ0NzRDMW53VkdFYkJ1Q3ZqM200R2dwTXRtZUFVTGg5b2M4?=
 =?utf-8?B?RjJRUG9UYUFGV0VOVXdWVHhsVTI3cmxzOVVGWE13b2NkRjlhZ2NQWFVzZmU3?=
 =?utf-8?B?VTAyc2hOY1pNN3h0Z1JTbG9RdTA1U0VObTdmOVNZdXY4cEFXUyt2ZnhoaVBm?=
 =?utf-8?B?SmVFRHIyRVBmQ09NUTB3dTlIUVBqdGh1OVlXMFNhei9mN1UybndqZWl1cjhi?=
 =?utf-8?B?cmJMeHdEVlJQdENYY1Zycko5dlArUHBVR0ZWNUc4eUZ4RkcyTWxWZXFWdGdZ?=
 =?utf-8?B?WWwrQUkzRVIyd1lYRWNsbVBNUVpRSjJPa2J0Rlc2UWwyN0VtVUc3U0RXUm9P?=
 =?utf-8?B?cUs4TGducmV1Um5lL2JEeXF1d2VYOFV6QzBLNUx0VkVFcllKR0x0ZzRtUDNZ?=
 =?utf-8?B?UzMrZGpnaUJFR3pua2JhNkNZemZBOEVSLzlreVdPa0lTVE94R0xkcXkzSFF1?=
 =?utf-8?B?OElqcGhJbm5CenNhRlpYemhNRmYzYm5hc1kwaGR4K3Noa1kzUWxVQ3NadnF6?=
 =?utf-8?B?Z0pyQWd3WGRQYlFUTXUzeWVMRmp1QTZiVC9QbnhJZWhYL2dJeEI0ZVFWa1RL?=
 =?utf-8?B?N0hVRmowNElkdW5DZjd6TTFBbDBZNGZUV1p1dWVKcy9GdFFYeVFFZ0JlZWRI?=
 =?utf-8?B?MW81QUFFRVEvR2hXeHhZd1J1MDJvV1kwbXc3UklrUGorSkFuMzFqbmNoM2JP?=
 =?utf-8?Q?s3JO7VTv56xyN5hxCziOIqHL8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea6bc1a-6da3-4e26-d3c3-08dc9fb074ba
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 00:45:40.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQdoAJXpF0A+Qq0uZcSshjvhBtLQieNq/6YlFcrxU2dkLgsfiQgUs/vWTmAJbCf1sL7S8HAmtyj504dxwBFQug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420



On 8/7/24 22:54, Lukas Wunner wrote:
> On Mon, Jul 08, 2024 at 07:57:02PM +1000, Alexey Kardashevskiy wrote:
>>> +	rc = spdm_exchange(spdm_state, req, req_sz, rsp, rsp_sz);
>>
>> rsp_sz is 36 bytes here. And spdm_exchange() cannot return more than 36
>> because this is how pci_doe() works...
>>
>>> +	if (rc < 0)
>>> +		return rc;
>>> +
>>> +	length = rc;
>>> +	if (length < sizeof(*rsp) ||
>>> +	    length < sizeof(*rsp) + rsp->param1 * sizeof(*req_alg_struct)) {
>>> +		dev_err(spdm_state->dev, "Truncated algorithms response\n");
>>
>> ... but here you expect more than 36 as realistically rsp->param1 > 0.
>> How was this tested and what do I miss here?
> 
> I assume you tested this patch set against a libspdm responder
> and got a "Truncated algorithms response" error.

It is against a device with libspdm in its firmware, likely to be older 
than 3.1.0.

> The short answer is, it's a bug in libspdm and the issue should
> go away once you update libspdm to version 3.1.0 or newer.

Easier to hack lib/spdm/req-authenticate.c just to see how far I can get 
with my device, now it is "Malformed certificate at slot 0 offset 0". It 
is just a bit inconvenient that CMA is not a module and requires the 
system reboot after every change.

> If you need to stay at an older version, consider cherry-picking
> libspdm commits 941f0ae0d24e ("libspdm_rsp_algorithms: fixup spec
> conformance") and 065fb17b74c7 ("responder: negotiate algorithms
> conformance").
> 
> The bug was found and fixed by Wilfred Mallawa when testing the
> in-kernel SPDM implementation against libspdm:
> 
> https://github.com/l1k/linux/issues/3
> https://github.com/DMTF/libspdm/pull/2341
> https://github.com/DMTF/libspdm/issues/2344
> https://github.com/DMTF/libspdm/pull/2353
> 
> Problem is, most SPDM-enabled products right now are based on
> libspdm (the DMTF reference implementation) and thus are bug-by-bug
> compatible.  However such a software monoculture is dangerous and
> having a from-scratch kernel implementation has already proven useful
> to identify issues like this which otherwise wouldn't have been noticed.

True and a bit hilarious :)

> The in-kernel SPDM implementation currently doesn't send any
> ReqAlgStructs and per the spec, the responder isn't supposed to
> send any RespAlgStructs which the requester didn't ask for.
> Yet libspdm always sent a hardcoded array of RespAlgStructs.

Uff, I see. So it should probably be "Malformed algorithms response" 
(where param1 is actually checked) than "Truncated algorithms response", 
a minor detail though. Thanks for the explanation.

> So the *reference* implementation wasn't conforming to the spec. :(
> 
> Thanks,
> 
> Lukas

-- 
Alexey


