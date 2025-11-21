Return-Path: <linux-pci+bounces-41837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E76CCC76DF4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 02:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBEB14E2F0D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 01:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB674258EC3;
	Fri, 21 Nov 2025 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bxZhD9bt"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A58214A9B;
	Fri, 21 Nov 2025 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689249; cv=fail; b=CtqC9hgYH0BLUf5XvoNhDWkp5gR95jH+3JFf1XmeA6o17so6DXBoVb5T85K2kNSJBUDvSkt7YtYRdCA/542W3hAyIKbsbYOzuCjbT6qOZvEUIW843cvds+LpVN7gSqJMMwtEUv8XTHN94kLST0lqtKb/Nl/x9wlrso8+11FU8zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689249; c=relaxed/simple;
	bh=2ejrn9l4eJc3y2GhCvAl6/9lgNCU0j91GN8lfUEK6Uo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nGyCucUS5x9vZ4o+2ixOvHuSHMIhSul+e5yQJ/jzsWnx6drULCQ3m8LZFeGcczx3HrD2KCG8sUsM7sSerp3XS3S19B183j/qh43AVkvfeDsFTJ0jOQ7i6HoCorFd/Mbpm1rHBDQHIgPv3hG8o6tIordo5y5MHF62QwCC5aTArZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bxZhD9bt; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtMfG6ILdViK8gXHmmQ8B461cFHAOKQh1lhdvW1GWSE7khYBYmP+Lc2An86aTZAqMgsY/ynKYClfgFPO9JdnXoWRyNqDq7Dvff0wzztIJcUAJXN7JZ8CoNL/UpR9BZVKvue9ojc0/G9QGdkgas76D89Rgd60jvWe31h94LsxUWvXPe8SmK7A81yD/FvbMauDav9rkO5Yr6G6nd9Eio+deJRSMhF7NmaGN5cUJ+7j3KHocdeSvscslSgRjq2tgy7v1yNuymzT+6bA/NZzVFnVZ1dqUvWeOei58dgyg4pap3ddzlGTRDSEXo+tQP74gaFyPnQXHoAhQZ+YYNengabRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1qiTRU2Z4Sql2DlqmqcbzTYwWq+xycA0b5OA/f6FMY=;
 b=VUXBz0OnnXDrTZfH1pmLHkWQEFx99cZf+zBlrQwhbHubeaLNxsaPQ+EHKs0exLwZjig1y2TvPDrOOW90ctsMbztTmHhQxTCZGaoYLvgjn+Jd8/3rP/EYxPx84DfoVSrrqi0fIaw7gEoVm0Cc1lMk9lGF49jJidtduHFaSniT4a4kmhSqj8TPKM9KiZdbrCoGri7Y0YSRS9A65X+K6pvtBGr4FeKU807iTaEkwtt8cQR5yaYrQNFD+E+u6eC0XYyW1Z44f2SybjJnCGiQcj+j7J88y05T3S41dVRrRbFnoLMhguCjmorBgm36IKpYnb6KZsPsqciaVQxfidc63YujEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1qiTRU2Z4Sql2DlqmqcbzTYwWq+xycA0b5OA/f6FMY=;
 b=bxZhD9bt/arsGypqMhBnqbLUhpMCrH2DLKdR0K5GErzicYVM8Cs+wMpFA3izYpGVSgI+vNrtPvuexN3yE8c18aRgbb/MekyPQLGcpe3eLXZYV5oqYi7c6i+54bDa47IH5o+e5Fmxvbk3lG3P1ofpf4Ht0yBY/YherRSSdzqG3Ko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 01:40:43 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 01:40:43 +0000
Message-ID: <a9cb5ce0-7042-420f-a2a4-e05b1dee9548@amd.com>
Date: Fri, 21 Nov 2025 12:40:22 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel 6/6] crypto/ccp: Implement SEV-TIO PCIe IDE
 (phase1)
To: dan.j.williams@intel.com, Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pci@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Ashish Kalra
 <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Eric Biggers <ebiggers@google.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Gary R Hook <gary.hook@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Kim Phillips <kim.phillips@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Michael Roth <michael.roth@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Gao Shiyuan <gaoshiyuan@baidu.com>, Sean Christopherson <seanjc@google.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev
References: <20251111063819.4098701-1-aik@amd.com>
 <20251111063819.4098701-7-aik@amd.com> <20251111114742.00007cd8@huawei.com>
 <442d4c48-8d6a-4129-b21a-cc2de4f0fcd0@amd.com>
 <691f880c7811c_1eb851006e@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <691f880c7811c_1eb851006e@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0052.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::11) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fb410c-d875-48ac-a01f-08de289efbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2NiRFNGYmc5ZXQyRHMxYXkrdERtMUlHVHBCa2xJalpzeE83NElDaGFGR3Iw?=
 =?utf-8?B?K3VTZm53N1FHS0JGZHVKVXhUM1pNTmwyWSt3VmRwWWV4V1JwWW5rSkpGZzhw?=
 =?utf-8?B?Um9ORTM0RkY4UFRJVGJVTG4wS2R2cGdWMUxRbGg0cTdhbERVdXJ4dXo1dlN0?=
 =?utf-8?B?a3VEY2RuaktoSWx0ZjVTMHJGcHN0dXhSN0lpUVFKNWxWSWlyTW1QS1B6N3g0?=
 =?utf-8?B?YUc4MnFnMXRaVHUrL0dBb2pyckVMdHNMR2lNcWtyTlZ2VGU4NWVSN2VhZTRX?=
 =?utf-8?B?VURKaURhMXBCcE1SakFtM0ZDK001SlZhUDJhUUp6bnBTdkZSSFpwL0hiUlMv?=
 =?utf-8?B?cWZxTzZxQVBSUEhRWnAxRTFWUGprRGV1RVptQ2REb28vbytpdXNib3dLN2tH?=
 =?utf-8?B?YUYrMXRZN0RlV3NWVDR1K2s2Qm50RllJYkVlaUV2Qi9tNTJGV3ltVVo2RUpU?=
 =?utf-8?B?ZHpxNVJ0N2hEV1o2YkxPaGRlV0tTV29PQjlOOEpzdnNCbWlwRFJMNGZpYW9Z?=
 =?utf-8?B?WXZEQWRHb000OFlkajlWRlo0ZmNQejdJamwvelUxM1UyM0JoRDZpWExxVnNY?=
 =?utf-8?B?Vms4YWFmckVjenFPcmhlc2MwdDNlMW5wQTlkMUUvMmVESjMxYlNZQzNTWUhF?=
 =?utf-8?B?WlV6ZzJubzNMRkU1eUFOdkxuSE5tckhVZDZuajZhMm1WVEo5bDF1SC9lSUFE?=
 =?utf-8?B?VUFHZERiU0ZxUE5zcnJ3REJyajVxM2I2dGZ6MWs4d1hnSnUyZ2hCODErVGF4?=
 =?utf-8?B?Q2l3NDYvT3RudEcyanR3T1RMdlVVRUFIcEtZSDFDa3F4UzZFRXV6aUQ0QU13?=
 =?utf-8?B?bk03NDdmSnpDS29pSDFTQTQ4OU44OVpuTmtubnc2QW5DUXhyVGI2WEpTbXJu?=
 =?utf-8?B?RXBzVnVGOVV2allZNU1VdWp6a0F4VnhGSlY3T09lSlMraXZ3Si9pMEpLTjAz?=
 =?utf-8?B?RFpMWDJLdVVvY1owYkRQTFFHdVhVeWdrTkxpY3FIank3VDRjR1lPWFRuZFdQ?=
 =?utf-8?B?aVpoOHVwS05RQ2JIZUhwMkROckdWNHA4b2tKUFlMS0lPSEVOS3hHWEFlSXM3?=
 =?utf-8?B?RHp3Y2JLcWE5dFh4R0ZWOGsxODQzOGZzL1Nza2ErcHY2SnNWeGNkSFFuZGZ1?=
 =?utf-8?B?aENnYkk1MDQ1UVpFMlc3L01PSVpBWkRSUzVWeVVFY2ZQZlE1T0ZPb1ZEZzRa?=
 =?utf-8?B?N1pMZHZnYkZDdzlTczhEZzZLd1IrTTZBSFNvblpWa201ZWhEMjRRUVFOZWlw?=
 =?utf-8?B?NFdDbVhjODBnR0hVRndWOG4zRmtFUWV1VDJBL1Z0ZEdLWHRnMnhjYmFpMnNi?=
 =?utf-8?B?SDdkcjJYMXJBZDR0YThtNW9pSDhaWVZmL0hvNTdBaVJoR2tjZUF6dkw2RnJS?=
 =?utf-8?B?YVJYVmtDcFo0aExVWWRQc0pLbHdLZERnT2JUdVErMnFiVm0rNmtPbnUyZXZw?=
 =?utf-8?B?Vi96ZVhFRlBNbUpJbVprSklqVzdYWTAwT0JmejJEUk11a2NPMHJDelJsN29E?=
 =?utf-8?B?MUdBdjZ3amloWExmd2ptenVQMHAxR2dFYmRFdU0ySHZRY0FzVUFoeU14ODBZ?=
 =?utf-8?B?Q1RkcjAzZjFISWlhQ2pBNTV6dWZBSFdXb1doWTFua2U1a2ZTR0J6Z0Q2RnBT?=
 =?utf-8?B?VStjRnZKdFhwN2lhUytYaURUY3VKL2cxZWVJVmdFSUlFTXBKM2VuQnNRNDU0?=
 =?utf-8?B?UXkxVXgzTnFudXBkT3ZiZUJvSnBBR3lPMTNxTkFyZlhYNXFvdmwxci91VlJH?=
 =?utf-8?B?bXc3QXdtRmRFcVpmSThURmxrc3ZvRVlSYTBjOVhKcDR1MDlhTVI0MkVJOWNn?=
 =?utf-8?B?US80S1ozWEM1QU5GRjJ0dDZTVGxwcU01T1pCSVB6dzM3RFp1NEEyN3NpRUZt?=
 =?utf-8?B?UlNlcWNYOHpIQ2NZWGloZ0ZjN2ptbm9BQUg4WmU4UUlnczNMbHVIcTlJYjFj?=
 =?utf-8?Q?HgYWUbw19kJxB4tn+Il9XlZxahU4okP3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bklaNHFIU2lGUG91ZlBVaWVONjF4ajdyYUNWUU15Slk1aEtzYllCR2hSdFp0?=
 =?utf-8?B?dTI0TDJta0lMM3picmZQdkhJb0JCUmVobFVoaU0zdkJHeDREZWZ3ZDhaQUQy?=
 =?utf-8?B?QlhUQktWcS9veEx5WmJBcmljWEUvVEJjMzhvWjRFL3BVN01xbEdabUoyUUZU?=
 =?utf-8?B?dVpjWVdvN1dXRS8zeGpFTUZKQUwvakR2WGVBWFJSN0lac0lnaTFkWTdkNnZo?=
 =?utf-8?B?NmVxS3BmeVVTeW1GbmxvQVNJaHVZVTdvQ2FIMkNMRTVZWUdwbHZET1JveUxI?=
 =?utf-8?B?dEtwZUFhUUFqUFJjUkRiVUU0Qk1LRHhnYncrdlRBTGxtR3huV1ZhdG9PcHRk?=
 =?utf-8?B?Q05saXhtSUZHQjlvWEltYk10bEY5VzdKQ1J4K3psWXhCdXI0RXp3YUNUa3N6?=
 =?utf-8?B?bmlqc3FJemFYSVYvTk41ZDBqcFZJUXZBM21xQVRjZWNxZXJiTTJOQWVDVjcv?=
 =?utf-8?B?blZ0RGFNS1RlWC96RHN3c1NUZDdUcWViY3VPMDNSUThLcWQ4Qm55aGQ1cno0?=
 =?utf-8?B?UzRxMXVINk0yZk9uUk9QZVJxcEkzY2lJUEl0TldwTW1McjZNQ2JJcFN6S2RP?=
 =?utf-8?B?bkVoajJqQUVpTy9XQTlzaXc5TExVSmNZYUFxMG5OR0w0eFhNM0g2aVhtMlRH?=
 =?utf-8?B?Unl4Y1VjdC9ocFA2MzNrZXV0RjNuSkE5RGFKVE1laks1ZDZTejdpdGFXRkR1?=
 =?utf-8?B?VThabktwa3VkdlFmUlZPZjhvSXg1Nkp5RHJYaTZrWWFtd2VkM0R4akN5WWVp?=
 =?utf-8?B?b1FIUm03RGVPdGFOWDIzVW9OTm1YYkVhZzBNdEc2dTcwQ3NjTEV3aVNtUFpa?=
 =?utf-8?B?cDNGQndKZlZxV3NmLy84VlF5TnI3Sm9KV0hFL1NQZm9GNkRQVFV4QXBSeGF6?=
 =?utf-8?B?MCthRS9ja0NGR0xMVjFRTFpmZHpybGZZOTFOem4wZklJYzZrNHIvUE5XM1Vk?=
 =?utf-8?B?VWlpOEhUcktsQTd2VElvOTZzWEpLbDFJdE9zS055UDFXYVpmRVJXWHQ0K3p2?=
 =?utf-8?B?RllMdkI4KzhYd3Y5dk9OcHhraWZMdUNacGdYQWhEY0U5bjlJcE1VV0RRL1RR?=
 =?utf-8?B?TElWdG1PMXZFMVBlUnovM1cyeHdQckRqS3N1c1dJREJScDNjNUFuT0NPWmZM?=
 =?utf-8?B?d1ZJOGdpdHQwM3VvTFdrMUMrV20zakVEUHdpTVlFblJ4eWlyazA3VUtpRlFi?=
 =?utf-8?B?czNxQVJBZ05ncGZBd213NDZrRm95aFVkQ3VhRHlEWEJRS3c4Qlp5aThUY0JV?=
 =?utf-8?B?dmgxWU9WSnl2T3V4OVZBVVJjbXg0T0Zrcm82cEIvdWZtMVY2dUxnK2VUbE9y?=
 =?utf-8?B?WE11djlieVJlTElSMGd3ZU9xeUhMVmlCaDJrMnJvYXIvdVk3QWVwQ3d0WDcr?=
 =?utf-8?B?UnB3MDF3aDFYd2lCQ0NaMTMzMUhaSC9lS0ZZb1dsN2ZCM0k4Sno4TWh0NGx2?=
 =?utf-8?B?SlBsc0xWZkJwSFZ1VjRrME5FVjc2M1BKaUo0ZXl0K1IrQnJLL0thNS9DaWpX?=
 =?utf-8?B?Sk54Z1FRZUVodG5LcXVSYVlqVGdkaUJmN1FhcEVFRVpBbGw4ZXlyV2RkRHZP?=
 =?utf-8?B?RnQ4c0M0Q3JKRkVFTEZiN1FiNG5HK2hSeURYdGd3WUhIdDA4d0M4TUNtaDRU?=
 =?utf-8?B?d2JFTjlnK0E2OFgvdm9nZHZCMWZXVmJ2QzN5cXFjMTI0UTExaERINDJXOXF1?=
 =?utf-8?B?OXdMdDgxRU51Qnc5MWdndUlmcFJJcXBXRTIwUzA1SGhIazVoaHB6L09QZjlR?=
 =?utf-8?B?djZKZEZDSTNkT0hQRnJ2Q05PNzJtKytLcExOT2FjN2tFdkUzaEwvVmhFaUp0?=
 =?utf-8?B?anFZV2wrMlBmZnprNVoyMDdWQ25wMUpJandoVHloNEQ1NUNDOUJxdFhNNGhT?=
 =?utf-8?B?SUFSTEtoZlZ0U0k4cStGaEQxZEZhUXVIMkpRR2l2UW1lRy94Ti9yeHN6cHpW?=
 =?utf-8?B?MHhVelQzcEd3Y2pmYk5maVUxejROb2x5Qm9wdGZod29CTlRyRmxqQVNob2xE?=
 =?utf-8?B?ZmZEU0xqZXVlb2xFdnpkQS9SR0RrU2JweUE0UzBYanQ3V2ZpVCtDcDJZdGM0?=
 =?utf-8?B?QWhYV2hvdnFidmY3SVdWMTNFWjFkWUZ2WHlhUEpKeVA5OWNBajFySlU0bHJq?=
 =?utf-8?Q?T0w54cNwnY2IMkWI/OVuYPFhi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fb410c-d875-48ac-a01f-08de289efbf5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 01:40:43.4956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoTfZ4KeDk6vbAiRabszkHiowRYGl1R4MnyW/MTsvEOFyh6oQcGQzJmHcHrwVU/AL+HMQAa5MlK9UZM33jAR/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073



On 21/11/25 08:28, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>> +/*to_pci_tsm_pf0((pdev)->tsm)*/
>>>
>>> Left over of something?
>>
>> Actually not, to_pci_tsm_pf0() is a static helper in drivers/pci/tsm.c
>> and pdev_to_tsm_pf0() (below) is the same thing defined for
>> drivers/crypto/ccp/sev-dev-tsm.c and I wonder if to_pci_tsm_pf0() is
>> better be exported. pdev_to_tsm_pf0() does not need all the checks as
>> if we are that far past the initial setup, we can skip on some checks
>> which to_pci_tsm_pf0() performs so I have not exported
>> to_pci_tsm_pf0() but left the comment. Thanks,
> 
> Why does the low-level TSM driver need to_pci_tsm_pf0() when it
> allocated the container for @tsm in the first place?


If the question "can I skip pci_tsm_pf0 and cast straight to tsm_dsm_tio" - yes I can and probably will, so so many leftovers are still there :)

If the question why I need pf0 in the TSM driver - for things like tdi_bind/unbind which take VFs pdev and I'll need PF0 for DOE.

Thanks,


> For example, samples/devsec/ does this:
> 
> static void devsec_link_tsm_pci_remove(struct pci_tsm *tsm)
> {
>          struct pci_dev *pdev = tsm->pdev;
> 
>          dev_dbg(pci_tsm_host(pdev), "%s\n", pci_name(pdev));
> 
>          if (is_pci_tsm_pf0(pdev)) {
>                  struct devsec_tsm_pf0 *devsec_tsm = to_devsec_tsm_pf0(tsm);
> 
>                  pci_tsm_pf0_destructor(&devsec_tsm->pci);
>                  kfree(devsec_tsm);
>          } else {
>                  struct devsec_tsm_fn *devsec_tsm = to_devsec_tsm_fn(tsm);
> 
>                  kfree(devsec_tsm);
>          }
> }
> 
> ...where that to_devsec_tsm_pf0() is:
> 
> static struct devsec_tsm_pf0 *to_devsec_tsm_pf0(struct pci_tsm *tsm)
> {
>          return container_of(tsm, struct devsec_tsm_pf0, pci.base_tsm);
> }

-- 
Alexey


