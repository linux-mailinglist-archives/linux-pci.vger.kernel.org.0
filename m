Return-Path: <linux-pci+bounces-36457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F080B87DA7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 06:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF274E67B6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 04:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2370A1EA65;
	Fri, 19 Sep 2025 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RCvyvHZb"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D7E19E967
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758255462; cv=fail; b=X37aIVgV4Nt+MaKspfViVLZ5HDnU+bj+quX4JEv60oouhR+4TUhcTMQfrWIXv++yGsSa56Kf+stHlQzk19bePS3h7CrBgovHOE8Gr/nltF86uv9Bn3Pqb4yYFtynDyd9TNvppx8sOGPXWpMhZ2MeZiotPYs0wIghZP9OflIcmKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758255462; c=relaxed/simple;
	bh=ZlQjfQmQRcJOx5pfJ7on9jghhjtEDhrSSL3UH5sgR0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mo4BfRJDNtOAxsM8evHFg5nYBjAOOsrl8zy7Pj/FhBMZc28D3zr6HGtvqoixTP+QPdZx68/PTTxKercw35PZK4GzbxjkB5y4jv4ZixcXcr3A2go5V0yOmXsT5gaADDWT6bTXD1b+lXPPJl+vopzoP0+uZHhnPFgnAwHk/sG223w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RCvyvHZb; arc=fail smtp.client-ip=52.101.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3HAJ1f8zBjiQos1JL63K0e453jSNDBgF/zR9kJ6p3ZAJM6coJX6iSrFfhh0V7WBC4N/0+UK0cvB3aQO5pr+XdttoIPYXgZXMzKmRtjn4JqLFYGhwt0gXhSOFPIJH2IBoRO7BqUGGz7hS0Q7ZgEUmPVDK7PHRhwJp6k60fjE0HoK1zhkmwGQCtFEdMBAwHzK/CZ1QwlO4jV5UMxxB8+fXMx/HgjPQ8g+l7fYPROiDERVCGhihhE7mmAXwfcyV9fUrC4xts0ZEw87NnMuNWALvUQE+xuR57iRKtBUDUyfKujN/Ivl554uzS9OozP4fJUb7LH/3YBWMddvZG4H+N2GHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLytXec+bV6Z7WnK8JJxO43Kb9wWbSG+t7XAiKNSIl0=;
 b=GGo0SrefchCRDtUPUdMhlUB4MQ+FiG920Ced8/HKzgiqidTxghnbZavGQ4ddVOWrEJe9ZAl15qSnEFPdyUgEMK2dzUGHswXdHwEEUB+d+syBcHBkNYiMAh9y1xqu9fI6pzcEBFqpU3tq0qESwIliLLBxLJ4CQWF/Fx4Y/7K738YJ33brPfmNGcFBt27umGa6Yk4OxU1+qL9+vm542+SxCdypKP40LE946UipZ3U3OYSZ/uafFOynFBcd13RktJJCWBm+MCtxIT0j//lWBKm/7+fg+Sv4h6zR5idwjUPB0zf1am8ppmrOvd28nTX+jROxuLf93aw6DeD7OkHkMtdy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLytXec+bV6Z7WnK8JJxO43Kb9wWbSG+t7XAiKNSIl0=;
 b=RCvyvHZbRPRBLSWWahRFAxFkvhHprRiPnQjEmjKqCBCliSXvHF24ZNRQtzBwsGjrWdd0H7kLgIJOFQthM5DaY2rAaLdfQjLKPkEXk3drjiyw40OzsThhPh5rOpUZmtJv7iiO6ELxAQJGjkrEBhS0ADRZ/mXqnmsmWZYHTtjWlD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 04:17:35 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 04:17:35 +0000
Message-ID: <6e8a11ac-21ac-4260-b8ec-54bdb058fbe4@amd.com>
Date: Fri, 19 Sep 2025 14:17:23 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH resend v6 00/10] PCI/TSM: Core infrastructure for PCI
 device security (TDISP)
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, lukas@wunner.de,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Roman Kisel <romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <yq5azfau7fpq.fsf@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <yq5azfau7fpq.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY2PR01CA0004.ausprd01.prod.outlook.com
 (2603:10c6:1:14::16) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 922a36c5-4f9c-42bf-a047-08ddf7337597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzRsVC9DWFlVdldEMzJpNjNITDM1bENGMzBMYkZkeXhoNm5qT0MvQnk0anV0?=
 =?utf-8?B?QlpCQnlUbjkrZlZXblFuRGFKdmxzS1RpM3hkNGNzZ3hzM0QxYlNDdmRVODRC?=
 =?utf-8?B?YitOYWZ4alVESFZNWUNsR2FWQzkraGR0QXQ5Wk1RTElsVk55aGdJL2tabE1K?=
 =?utf-8?B?WU13NFdxZFJpYzNTUjE2cHBPdHhBWTZrSlBVNmhtVkgzVUo2aWV6bGNQUnFR?=
 =?utf-8?B?bjF3NXMwSmR3TU56UlZXaElvcGNGQ2JOb1liZzNneVI3eVFBZjBmWCsva3RN?=
 =?utf-8?B?ZXNZSUR1bUYrTHV5bGhYQTFBR1VuL3BTdUZCUmZ5ZjlqbWJHZEF6SjQrMGk2?=
 =?utf-8?B?ZTQ3TzZBbC81M0czbzFtQWdHdEdkM3BQMzJnVDMySDhBRktudUpON01oTVZQ?=
 =?utf-8?B?Y0UxT2Jna290LzNXcmZtbFpINHpFKzZ3bnNzTlhSZS9vWVlKMVVaN0p5ZURp?=
 =?utf-8?B?OGVWVllYcTUvQm0wL0RncWRyekRsZjBNeS9EVm8xNlJOTHVveU9yNEhwVHhq?=
 =?utf-8?B?ZDNSVEpuRjUvM1Q3MHY3cTEvUnFzTi9ObGxzYjFCbU56cEtXMithb2FJNnMz?=
 =?utf-8?B?ZVdPNHN1YmE2ZFhDdUkyVG5kTW9POTdGelMxTG90M3d4NEhMejR3ajdnTVpk?=
 =?utf-8?B?R1FwYWl6bEd3VDhMekVmUmNaemw5YzZIMjZJK3I5QURtTksrS1ZwY0c2WWNJ?=
 =?utf-8?B?bCt1Rm1zUXBtV3NxRmZlYldRYTN4dzBjTW0zVElxQjVGZy9nbnJOWGVpQW92?=
 =?utf-8?B?VlVVbXBneCt6dU9LRHRhNmJoR0RtMDFqM1RjREdQQ1o0S0VxeFJmNEllYVN0?=
 =?utf-8?B?THI4WGRvdTR1NEg0TEdMcU5TUm1wWXJ4M2VpMmRzWXg2elpnbFJXZkljZjJD?=
 =?utf-8?B?dW14ejNFY2NTYjNhTFFacHVVTlhSWnFBc1YyVVoyT3JnUndiQUxpUFFJV3Jv?=
 =?utf-8?B?VW1aMjFLcjIzZ1FnMWFzR003d29kam5iMHhzbE01emtzWEtTSXQzY01ZMGdL?=
 =?utf-8?B?QzZOaWZQeTQ2TlB1bVpCZEFqVVhOUlFiSERCUTY0Wmp1Q3dYdDVhVjV1NmZj?=
 =?utf-8?B?OG9WR2ozRHBJNUJETmwwZyttQzN2OFgvYng0akptNWhvMUdXTVNMMnpFNnlo?=
 =?utf-8?B?MXVqaXFyNXlhaDNTYXVCWm5aYmpkYTRyN2VqUGFiNzRtWG1QeE5CRUFXOXJr?=
 =?utf-8?B?TFFsRjZQVWhKa2l2K2R0SHl3Qk9Pak9Pdll1cHpTWmdjSEI5ZmQwbll2OUF2?=
 =?utf-8?B?M1k5NzlKNFFUamhmQlhGdnBvNUpxZUpxenhXSklRc2xFczhEZVhuWnNIRDly?=
 =?utf-8?B?UWh6ZTlqcDhpdDRoMXlwNTlJMjZIckNRdGFiVjV1OFBBU3hXbzlaS1hsOFZo?=
 =?utf-8?B?VkphY2lRaldhU3VKU3NJV0dSakY4NG9aalZLSll3aWptRmxLUUJneDZyekxY?=
 =?utf-8?B?Q1JzelNCdEpyUzZSdXJUSTNrMGVkenhZSUMybzlWWmV2eHF4cC9PZElmSUc0?=
 =?utf-8?B?Tis5VUlNS1pjMURXMnB5Z3Z3b2NqSURFdEJwUXg2N2tEOTVNN0htYmpzWEFk?=
 =?utf-8?B?TkVjNHpPYndSMGMxbjdWR2c5c3JFeWhFcytjb1haY3haZ3dzOCt1Nk9yeURU?=
 =?utf-8?B?RmVQQ3U3dnZJNGo2YkZLZTY5dm05S3UyMjB4MzRQRXJnNzBBTmNvYTk1OTlj?=
 =?utf-8?B?dDFnRzMxT2cwNkJYYTJ5UDBwYWYxSG5McDdNaTFDMWJCL0Y2cWdFWFFQUFMx?=
 =?utf-8?B?RDBablRwbk01eFhOTnVBSVRkSFFDQXk3NzZyVFlTd0RtNkZndEUxemQxZnY4?=
 =?utf-8?B?QlZYNjdidVFjYUJta0tsb25TOEVXZFgweE81cTJQZVZuS1NoVkozWXdCaDF1?=
 =?utf-8?Q?ShcFYy4+at1T2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXlpQnZma3BEdUlTOGFkYjQrc3QyaG84WUN3RHV2Vmovd2N6SjBweUhMR3JV?=
 =?utf-8?B?ekpCSGI3U0w4L010SXlHTUUzY2JqbkxyT1JFQS9vcXlRei85bjNQVisvNWNi?=
 =?utf-8?B?T3FLeU1FelAxR2dIL0NUMGxlRWI1QnVGSjVCdWxvY3dPVTJkNHYrWVo0NE9j?=
 =?utf-8?B?VmJVVlBxRnJpdExqVVVOMUJQSlU4SmhNdW1NYmNtdHF4ejVzNmxmazUrK0F0?=
 =?utf-8?B?YUdKUHhwVUNDVTV2eTNvTnVBYjVxSFB1aDJtUklMS0Uza0J4dEZobDRRT0pE?=
 =?utf-8?B?WURsWG9JTFFqdFJ5d0M4enlHTU5SVXpjci9rVHJhbE1SMG1HTmhteVQrcDRR?=
 =?utf-8?B?Ni9Va29BNmRNdTM3M01WSWZZVDJDSFZNeldFd2dLV2Q1ZTVoTTVjVTg3SGZ3?=
 =?utf-8?B?T21iVXQwVFJJUFJjOWpXYWhSVS9Pam92dmtlZWk4WmZPNE1xSXpGMHFUNUw1?=
 =?utf-8?B?VVZIM3ZvUmxrOFluNmY1OUo4WmxhZHFKaTRXMkNIT3RFdmRtMnBxbVdvS3p2?=
 =?utf-8?B?dlFOQy9WYkRpanEyWno3UEd0U0l0V2tBMHNkUlR5Skw5VlVaaUNJT1BQeUJy?=
 =?utf-8?B?MjY1T05VdW1NN2xwSzVhNkJRNXM4SDRHdmtiSzNDd2lHK0hZelJCVERKMkVn?=
 =?utf-8?B?bTVReFN3cmNua0tKMlB6OU43NGkwUzVoQ05QdytVdS9sNEhzblo2ZnpZMExU?=
 =?utf-8?B?Q0pFay9pbEdsVUt6aUV3cnVhZVpSWEpCUVpTdWdsU1gxcnZHaUg3SU1zazZU?=
 =?utf-8?B?aDVHbGVGVlJEeXBrWm5GNTB1MmF1Zmgrakx4cHd5akJFOHYzcmRCem5uaEFY?=
 =?utf-8?B?VFB2NzZXS29Mc2tVSE1NYm93cFVUSkVoWlJQRE5TaVZIL0tHS3Jjc2hVOWNV?=
 =?utf-8?B?bGNNNlAyYzhnU3B6bk5TRW56RHR1U2xPTERaS3JHOG1xYUNTbVdUZ3YxbUJS?=
 =?utf-8?B?ak81SnlxOFBKVUhEcCtRa3VKMnAyd2V6WUEzRDE4UEVJNTRlZzRZSGZGbEd1?=
 =?utf-8?B?YVJESjU4T3BOem52bXhybzBsODEzdlJKbXpCS2ZQYThJNGNZNS9GSU1tVUI2?=
 =?utf-8?B?TjhxYlA0UFg2U3A3bXRWcDlaNys3YVNDdGRiM3QyNWEwQmNBREJVUDB6aWtt?=
 =?utf-8?B?enQ5NEQrd2dyTUhYMFUxR1krTGpscVNjN0tBbFdNM3ZrK1YreUx2TXc5bm9p?=
 =?utf-8?B?Tks4M091ZDBscHJkLzE5b1djaEZobHJ6eVl2OEoyZmRJdmtiWVlreDBEWDhh?=
 =?utf-8?B?T3piMXVPaStkeUFvUXE2Q0tKTUwyWDEvbElMTVhiK0E2a3grcU9uL1JDQTBw?=
 =?utf-8?B?TFFhdjUyR241Zm5HdFYxaEt0U2RYWStUUjFlTkJRZmJxd3dOVjRmdmgzUmlP?=
 =?utf-8?B?RXhDc0lqNzJ4c0JRVm5vcVZzZ1VReVNrVWJIQ25rUUdYYkt2eG51ZUpIcG5s?=
 =?utf-8?B?dkg0cEZ5dnR3dTQ0UnRSYU1OZTZSMStSckZ3dkRpdC9HN0ROVkJzL2FGOWkr?=
 =?utf-8?B?T3VYYXF4WnBWckFEVjJmR1dPUzJFN2pUaFZRdy9sMjBvdm1jRWdsUFlYVito?=
 =?utf-8?B?T2YxeDRUd0habEgxOTI0L3pRZDZJZS9BeVBvOGhnZk9NcVM4cGovTVpIRzRo?=
 =?utf-8?B?TWZSeDBRUnprZmN0UjZybTZrTUlsK0J5WE9CSDBJcUlkZnVxMGE4YXp2K2x2?=
 =?utf-8?B?ZS9hQTNXcmpMQ2hLcGVJS3MrL255Yzk5dldJMkMxcG94U3VEY0tTdFhqaGhW?=
 =?utf-8?B?aUtRS2JHcEdQTUhXcHJhV1E0a2x0cUhleHExS0RxTHA5blJnZ1c4ck4weW9I?=
 =?utf-8?B?VUZLUTdxNWhCRG51OSs1SnpWd0syMDFTSi9ybmpFZzc3azFLTW5vWGRsKzRi?=
 =?utf-8?B?WWJBMjFZbVFucU90WUhZTkJZTzBTNEZCU3B5SHVlQ3drNXFHQ3NSR0J0Tkhs?=
 =?utf-8?B?Qm1wNFZQTFlMMUd5VTBHTDhjcU96aGRPMFhqYk5pZ0lZcWZZNW1WcXN4K1RW?=
 =?utf-8?B?YWFwWFZJcXpsejcvSnV3TjNHR1NTR09yK1dNMlkxQmVXbm1PTURRd2YzM1hv?=
 =?utf-8?B?U1QxWDdQRmJOeUMwcS81UjNZdHFUQ0N5eUFlTmJTc1NCdWZoY3dYc1Q4aHNC?=
 =?utf-8?Q?fcd8zUERibsOt8nzkNiFHmdWg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922a36c5-4f9c-42bf-a047-08ddf7337597
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 04:17:34.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idJp9nRocV6qwK8+hzrL5CCvK4qmJnaaQ0YXifm4PZIygxKO0W2pAJdaHlqDIV3JvAvcBkN5VKP+nMwiQjcE2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194



On 16/9/25 22:18, Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
>> [apologies for the duplicates, I flubbed my mailing list aliases]
>>
>> Changes since v5 [1]:
>> - Add @tsm_dev parameter to 'struct pci_tsm_link_ops::probe()' (Alexey)
>> - Fix to_pci_tsm_pf0() to walk to the DSM device (Alexey)
>> - Fix IDE establishment "default stream" setting regression (Alexey)
>> - Fix pci_ide_stream_enable() in the presence of devices that delay the
>>    "secure" transition to K_SET_GO (Alexey)
>> - Make sure pci_ide_stream_enable() has a unique error code for the
>>    "failed to go to secure state" case. (Alexey)
>> - Clarify that pci_tsm_connect() unconditionally probes all potential
>>    TDIs (Alexey)
>> - Rename 'struct pci_tsm_security_ops' to 'struct pci_tsm_devsec_ops'
>>    (Alexey)
>> - Add @tsm_dev parameter to 'struct pci_tsm_devsec_ops::lock()' (Alexey)
>> - Pass 'struct pci_tsm *' to 'struct pci_tsm_devsec_ops::unlock()' (Alexey)
>> - Rename 'struct pci_tsm::dsm' 'struct pci_tsm::dsm_dev' (Aneesh)
>> - Rename 'struct pci_tsm_pf0::base' to 'struct pci_tsm_pf0::base_tsm'
>>    (Aneesh)
>> - Make definition of 'struct tsm_dev' public, drop tsm_name() and
>>    tsm_pci_ops() helpers.
>> - Drop __devsec_pci_ops (delayed cleanup now possible with 'struct
>>    tsm_dev' public) (Jonathan)
>> - Revive pci_tsm_doe_transfer() (Aneesh)
>> - Fix tsm_unregister() to not assume that all TSMs implement PCI
>>    operations
>>
>> [1]: http://lore.kernel.org/20250827035126.1356683-1-dan.j.williams@intel.com
>>
>> This set is available at
>> https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=staging
>> (rebasing branch) or devsec-20250911 (immutable tag). It passes a basic
>> smoke test that exercises load/unload of the samples/devsec/ modules and
>> connect/disconnect of the emulated device. Note that tag also has a
>> preview of changes that will be included in v2 of "[PATCH 0/7] PCI/TSM:
>> TEE I/O infrastructure" [2].
>>
>> [2]: http://lore.kernel.org/20250827035259.1356758-1-dan.j.williams@intel.com
>>
>> Status: ->connect() flow is nearly settled
>> ------------------------------------------
>> The review feedback continues to slow. Various folks have had their
>> naming and organization preferences adopted so I feel comfortable
>> calling this a consensus branch. Let us leave any further requests for
>> naming changes to Bjorn.
>>
>> This version seems suitable for proceeding to linux-next inclusion. That
>> inclusion depends on the guest side TEE I/O infrastructure also
>> settling. That guest set definitely needs at least a v2 [2]. In short,
>> PCI core infrastructure for TEE I/O (both host and guest) targeting
>> linux-next inclusion post v6.18-rc1.
>>
>> Next steps:
>> -----------
>> - Stage at least one vendor ->connect() implementation on top of a
>>    tsm.git#staging snapshot.
>>
>> - Find an arrangement to supplement samples/devsec/ regression testing
>>    with IDE establishment / "connect()" flow regression testing.
>>
>> Original Cover letter:
>> ----------------------
>>
>> Trusted execution environment (TEE) Device Interface Security Protocol
>> (TDISP) is a chapter name in the PCI specification. It describes an
>> alphabet soup of mechanisms, SPDM, CMA, IDE, TSM/DSM, that system
>> software uses to establish trust in a device and assign it to a
>> confidential virtual machine (CVM). It is protocol for dynamically
>> extending the trusted computing boundary (TCB) of a CVM with a PCI
>> device interface that can issue DMA to CVM private memory.
>>
>> The acronym soup problem is enhanced by every major platform vendor
>> having distinct TEE Security Manager (TSM) API implementations /
>> capabilities, and to a lesser extent, every potential endpoint Device
>> Security Manager (DSM) having its own idiosyncratic behaviors around
>> TDISP state transitions.
>>
>> Despite all that opportunity for differentiation, there is a significant
>> portion of the implementation that is cross-vendor common. However, it
>> is difficult to develop, debate, test and settle all those pieces absent
>> a low level TSM driver implementation to pull it all together.
>>
>> The proposal, of which this set is the first phase, is incrementally
>> develop the shared infrastructure on top of a sample TSM driver
>> implementation to enable clean vendor agnostic discussions about the
>> commons. "samples/devsec/" is meant to be: just enough emulation to
>> exercise all the core infrastructure, a reference implementation, and a
>> simple unit test. The sample also enables coordination with the native
>> PCI device security effort [3].
>>
>> [3]: http://lore.kernel.org/cover.1719771133.git.lukas@wunner.de
>>
>> Dan Williams (10):
>>    coco/tsm: Introduce a core device for TEE Security Managers
>>    PCI/IDE: Enumerate Selective Stream IDE capabilities
>>    PCI: Introduce pci_walk_bus_reverse(), for_each_pci_dev_reverse()
>>    PCI/TSM: Authenticate devices via platform TSM
>>    samples/devsec: Introduce a PCI device-security bus + endpoint sample
>>    PCI: Add PCIe Device 3 Extended Capability enumeration
>>    PCI/IDE: Add IDE establishment helpers
>>    PCI/IDE: Report available IDE streams
>>    PCI/TSM: Report active IDE streams
>>    samples/devsec: Add sample IDE establishment
>>
>>   Documentation/ABI/testing/sysfs-bus-pci       |  51 ++
>>   Documentation/ABI/testing/sysfs-class-tsm     |  19 +
>>   .../ABI/testing/sysfs-devices-pci-host-bridge |  26 +
>>   Documentation/driver-api/pci/index.rst        |   1 +
>>   Documentation/driver-api/pci/tsm.rst          |  12 +
>>   MAINTAINERS                                   |   7 +-
>>   drivers/base/bus.c                            |  38 +
>>   drivers/pci/Kconfig                           |  29 +
>>   drivers/pci/Makefile                          |   2 +
>>   drivers/pci/bus.c                             |  38 +
>>   drivers/pci/doe.c                             |   2 -
>>   drivers/pci/ide.c                             | 584 ++++++++++++++
>>   drivers/pci/pci-sysfs.c                       |   4 +
>>   drivers/pci/pci.h                             |  19 +
>>   drivers/pci/probe.c                           |  28 +-
>>   drivers/pci/remove.c                          |   6 +
>>   drivers/pci/search.c                          |  62 +-
>>   drivers/pci/tsm.c                             | 627 +++++++++++++++
>>   drivers/virt/coco/Kconfig                     |   3 +
>>   drivers/virt/coco/Makefile                    |   1 +
>>   drivers/virt/coco/tsm-core.c                  | 166 ++++
>>   include/linux/device/bus.h                    |   3 +
>>   include/linux/pci-doe.h                       |   4 +
>>   include/linux/pci-ide.h                       |  75 ++
>>   include/linux/pci-tsm.h                       | 159 ++++
>>   include/linux/pci.h                           |  36 +
>>   include/linux/tsm.h                           |  14 +
>>   include/uapi/linux/pci_regs.h                 |  89 +++
>>   samples/Kconfig                               |  19 +
>>   samples/Makefile                              |   1 +
>>   samples/devsec/Makefile                       |  10 +
>>   samples/devsec/bus.c                          | 737 ++++++++++++++++++
>>   samples/devsec/common.c                       |  26 +
>>   samples/devsec/devsec.h                       |  40 +
>>   samples/devsec/link_tsm.c                     | 242 ++++++
>>   35 files changed, 3167 insertions(+), 13 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
>>   create mode 100644 Documentation/driver-api/pci/tsm.rst
>>   create mode 100644 drivers/pci/ide.c
>>   create mode 100644 drivers/pci/tsm.c
>>   create mode 100644 drivers/virt/coco/tsm-core.c
>>   create mode 100644 include/linux/pci-ide.h
>>   create mode 100644 include/linux/pci-tsm.h
>>   create mode 100644 samples/devsec/Makefile
>>   create mode 100644 samples/devsec/bus.c
>>   create mode 100644 samples/devsec/common.c
>>   create mode 100644 samples/devsec/devsec.h
>>   create mode 100644 samples/devsec/link_tsm.c
>>
>>
>> base-commit: 650d64cdd69122cc60d309f2f5fd72bbc080dbd7
>> -- 
>> 2.51.0
>>
> 
> The corresponding Arm CCA changes based on this version of the TSM core
> infrastructure can be found at:
> 
>   https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/tdisp-upstream-post-v1.2
>   https://git.gitlab.arm.com/linux-arm/kvmtool-cca.git cca/tdisp-upstream-post-v1.2
> 
> These changes are still based on the ALP12 specification. I am not
> reposting the series yet, as I plan to rebase the v2 patchset against
> the ALP16 version of the spec. Those changes are not ready at this point.
> 
> -aneesh

Here are my trees:
https://github.com/AMDESE/linux-kvm/tree/tsm
https://github.com/AMDESE/qemu/tree/tsm

I'll repost after I adopt "x86/ioremap, resource: Introduce IORES_DESC_ENCRYPTED for encrypted PCI MMIO" (hopefully soon).

Thanks,

-- 
Alexey


