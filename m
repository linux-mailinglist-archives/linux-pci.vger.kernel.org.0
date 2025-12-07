Return-Path: <linux-pci+bounces-42731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0386CAB071
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 03:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BAA33058466
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9709D4315F;
	Sun,  7 Dec 2025 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSb9blvm"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A11E9B3F;
	Sun,  7 Dec 2025 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765074380; cv=fail; b=mu2+dXH/H72w5RmRVlNv6pz+PYpIEH7m1SCW/F4+Aj3cqdFVnEdrVXxMa3ZXZ446oK3nEMTB3j8JRnS1/k6Ng63hRfC49Peu4I7g/TFhw3wW/v93ZBT1szFo+q3FahUrRALbfUQAfxenKU51UlvpdvHU43xFMi2Rl1WtEpAdcLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765074380; c=relaxed/simple;
	bh=4qLvVWP2fbLF+EZauvbMIyiFKev0a4N67SoroO0kf0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JP7HVhfZGMPyRH4ms6WaVALYXoKgMwqugE6n84jG6YMP8CHWTTytGecm9+RjoPf+IqStBBuB+FzWxCEFI0TEHYx6pDYqKvwgodFYvTFuRDrMboA5b3uLxPcUB5/JY1bBpTuT3zm+6fWVyl6kqLFROKBhrog/MJoxik0F2jDsr/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSb9blvm; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIZiDbBOP+ziAOxWMLWDjYm+mEHVNI/vOqji1yPOR/VKzc02eF0oZNgLgUUvhhneWb2hQC7iulHfQNJXIfyTn6H34zIEfiPvoVYQCD9xo4dIV1EDS/wkWa4AUw9tG3fp8UVgIa0wxmkIzgxqokKNBCoZMryBM97nV5CijaJRRyfITPdJNVBgb0TjsQ+NlZ1gQck31vp+4HttyuVaCE9pPTGmIXqqImky0cbW8dDw66eo7zeWfJ+LmJ8v9MyWU0oaYUIYL6Y0IEjI/fwd8lVQpd+/GvsX1YAfRgEPq/nbn0W7MrCWr8SbR6xl9Jmle9NVVLtg2zcNeuO69LglzFSm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AAdmxC7KjFa/ReBa6p2XrwF9R1uVmXUsq4cqqOYfR4=;
 b=SMUvUjkcBn2iKDREvNSFS5vG9G6B8Om0MRh8VACZ419R7UDNj+y0dCSCVTY59YrduktIv2XC2yQJTXca5MgwC6yR/x8BjZ/xLddWGazXrfK7WnCd9/67e/ae0Kbu3tbbnO2ssuIHXBHPDyN/D5BCBvDDLEWmxhukDhwSO4RfEM16NX1lzsBpfkS/+wQL4zVYqdNrzp3PYVEA8oogWmcVD5kCebXGaa8FF5O2YPiHoDc035WYURJ6bZcD7+Nk95f5KS2mKvVGgt1AWPZCWd0dWLuaqNBjlUYiE/hP+/Ra6x8/Oh72wZP0M4Q6mD8ImYyhjeP0klSl0jXS3enLIGdyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AAdmxC7KjFa/ReBa6p2XrwF9R1uVmXUsq4cqqOYfR4=;
 b=TSb9blvmtb8VjXPTMHbCV+MzizhoG9AHk2h/SPxJ2K0DXk4/NrLYICudT1k4JjZdSk0XQBThWwex5EFxrS2vpyqpYf8qCJDtE7cdiU5qcWsarydwk23ZiN30I0D3CmN22MRQzMLYbcU7uILuIHbg5doUHDgLMLZGtNgZ8zFNE/c1NoM/xz3pJj7VLgq9+igp0xbB1kq1GwvzYn6RDt3N1wcuPMYh4xPVVQdvZNvjBEm9spC/xRFRwHmLa940X1s0umuOvFSXXuUfBkG5U3ZSa5vUShnX/UC5qnlRTq3JWmq0rS2HHEgCM62llCp6EKzAj54wOZ27dDOyeEdBTsJwAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sun, 7 Dec
 2025 02:26:15 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9388.012; Sun, 7 Dec 2025
 02:26:15 +0000
Message-ID: <47c05bcf-7591-4148-8783-0c107b0c3c9d@nvidia.com>
Date: Sat, 6 Dec 2025 21:26:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/7] gpu: nova-core: load the scrubber ucode when vGPU
 support is enabled
To: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: airlied@gmail.com, dakr@kernel.org, aliceryhl@google.com,
 bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
 cjia@nvidia.com, alex@shazbot.org, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 acourbot@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-8-zhiw@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251206124208.305963-8-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0438.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: e00227bf-46a4-477b-feb4-08de3537ff1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVBHSVR4UVRvaDJqc3E4M3JTZGt6RHZ1Z2VwSklSeVN0eG1tU1F2enY1anVR?=
 =?utf-8?B?N3llRjNtU1lFT1pkRlBFWG12Wi9jOE1KNC9xb3BGTWhzTkhuVjE1Y0FWdVFC?=
 =?utf-8?B?d2gvWXdJYUJyMWhNdFNWNXBvS3JNeURVYWFsaFBZa0g0ODVpc3NDQzBuZ1ly?=
 =?utf-8?B?VFRmM1YwUnRNQXNkekdNank2SVdLaXY0WmcxU2xnYTM1RkhYSkIyZkJpc1BH?=
 =?utf-8?B?OTViK3N3SGhMRjJTa0dld0Z6V291QXYwclNySUR4dDRQMk1OOXVMdWd2VnU5?=
 =?utf-8?B?Z0x3alprditHeU1SRHJwbC9VK0VRbXNMYjV1bUlmL3hJeURHdFFST2U0WUEz?=
 =?utf-8?B?S2pFYVAxNkcvYlRUeTJockhRVmt2ck94T050c3pPQTJZdC92SENFY0gwOVN5?=
 =?utf-8?B?S091aERpQ1ZhR0l6NjlodFNvRktrNmdIc1djZEpRbEp5dlBhMVJnaVdjNEhk?=
 =?utf-8?B?eDI2R1hrVUViQVNrYVhHNGZsOG1qck40M1VFcWoxaGtCUmVzQU9JbG1OMHd6?=
 =?utf-8?B?TUkxa2NKNVplK0p3UFpRTEFQem9pTkcyMVRQdDlKbHJxSDZ5Nkx6VlBPSWRW?=
 =?utf-8?B?ZU1JMnhRcWpvemxtMHl0cVpyR2RQNStNUDhlZWd3U3lpTVFWSFp4THhFV29L?=
 =?utf-8?B?UUluZC9jWUc5dDB4OEVPY2ZwL0dKY0k3MUgyODh1bnJOY2pIa1JSUXVWa3Jn?=
 =?utf-8?B?Wkp0VEd6bGFtanNhejBvN1Z4eXhIQm4vYm9uS1pxaUN5amVzNEVwVnZWVWpk?=
 =?utf-8?B?a0NsRk9nWDRvZUtPb2pRSmRXbnJSOEJUdlZ2dUZiWEc3OTdZOEkrOE5vWFc0?=
 =?utf-8?B?YTczL3ByWlNsVm1uNU9pNndzVnpxMGdaOXpVcWtKS2NGUDdXd25VdTlMYThj?=
 =?utf-8?B?VE9qMm1rZldnaW5TVUwyQXhQNjM4UkloNUF2YmkwRllYd1BOaGo0RlJJS3V1?=
 =?utf-8?B?U3dwSXBZRHFiK0Qzd2RSbUtibkFuRGhPd1ZuRXVyQnlCS05aaGk4TmgyRDNX?=
 =?utf-8?B?SndnL3NUdG5DY0dXUFhFbFFIR3NacHVydnIvQm9qRUMyeWxQN2o3U0JiSWdz?=
 =?utf-8?B?U1pseU1Fa3Q4R0Uvd0ZLZ1lXbk5nT3NXMkJaNitCVUo1YmxYUCtvMXNVRjVk?=
 =?utf-8?B?blRLMjBMeEg5SXVMREFBeFplMWpnVWQweithNFhqcjJ3eWtDT1pMYWR2Ykpn?=
 =?utf-8?B?NmtKZWZNQVBLZ3lBaUp0Z2h5dVlDa3ZHRVdiaVl5L3M0Zk9wNVVERjFBTTl5?=
 =?utf-8?B?Q1dGVDF5VHRMQTVyOFB1MHQyWTNTaUkzS001bWRSeVVVOWtIMnhtaG1rREFk?=
 =?utf-8?B?TGVYTTNvb0xMNUpnUXFDMlNCYkc2TDNySGlVOENhWW1MV3g3S3BBNXRDSURy?=
 =?utf-8?B?UC9TSVY2Z0R6SE0zWkJmaWo0bkFIdjMrZXNnZktzQm1ZbWtuaWprUGJ0V0ZJ?=
 =?utf-8?B?N2k5TjZHZmZjTkJjR1EyL1ZCaUhnNkpIalJIaGszNG41eFo3c3BreUZycER3?=
 =?utf-8?B?QnhqZStsNzUzcHdtbTBEUys5US8wZ0ZtN1U1TGVjRW9oeVVsdlp2OUk1WFB1?=
 =?utf-8?B?SE50YU1hMUhJNmlhVHFMT0s1TDh0NVJnSXpoQUY3ay83SUpuWXc4Z2x3Kzdo?=
 =?utf-8?B?S3dFL1NPU3UvNkhEd2ZEdlZyQjNYTDJzNWdWTkpZaGFmSStaVkZMRWVpK0FP?=
 =?utf-8?B?dzF5cUNmQjhaMEY4WkRUOExIM0ZGU0gwOTgySXU0OTJXTmxOS05hZG95b3Jm?=
 =?utf-8?B?T2ZyUU9EL3d1OUVpTFhTelR2MkJNdGJ2TXpZaFFWMlZGQkJpaWJjT0VJMWpC?=
 =?utf-8?B?Rkw5QmFnTHMrdDl2YWlNSEc4Q01IVEgyS3llMHRZZE9yd2tOdnZocXlWdlZz?=
 =?utf-8?B?dy9HUFpBVVpPbVNmSTBBT293bC9hMXNYZXg2TDB6YStVMzFGZWJuUXNZZTRC?=
 =?utf-8?Q?TXiGK0yXU7FZhzlJGva5Wsrx3Ye3KVmy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmdvOU5iaThRQjZiZ2FPMkRWMUJ2NDR0L0drMklCSU1GdUFiTk1ZTFJOY05O?=
 =?utf-8?B?SjhybE1JSk9LbEdFK0t4TTVhb0JaSDhTeWs3YzViZ3FwMSs1dGJMTFl6U0hv?=
 =?utf-8?B?Y2hHandqQStQc0dWdXJCcEM1TXdzU2IvTnN5SHYwaGp3dForbzJTdjlJQzdS?=
 =?utf-8?B?MkJyckFEQnAyNGFkK3V1Y1NkT01YeUxiVVlaNWZCdGltbUgwQTh0STFwV0dn?=
 =?utf-8?B?ZWFZWU1tRVk0MWpaZktxbWVlS2k0R0l0Z1lWWWRNZ1hDeHlQZ2dMZUtoUFJX?=
 =?utf-8?B?dmpBV28rK3JsdUNIM2dlNnR3YUFuT0pycS91b0hBWkVpU1NLR09jc2hwWTRR?=
 =?utf-8?B?Z0NFbDhQRDhsbjN4UDVZTlQ3SkZFbkFDalBMT1FGRHBodjAwN1NQYnNuRUsz?=
 =?utf-8?B?SjU3WTFEWHpuVlpFaUhPelhlNWpvQ2F6WXMrclQ1bFl2aGU1WnBCa0ExMFRR?=
 =?utf-8?B?VHNueWYzQnUvSGlsb0pIczhVTE04d1lmdXJoV3J0eFN5cWpZN0VoaXVDbUJv?=
 =?utf-8?B?T1hyV0RJUHE0NVNBdkxsSEZ2NjlMLzNjV2FWNUNPRVAvWDNHTkl5azN4b1VY?=
 =?utf-8?B?bFNGYVJ4RUQ4ZC9LVXN3R0Z1OTBRNStxZWJwZlhaRjRqY3E2VzNnb3hkSUpR?=
 =?utf-8?B?cWlxUDJYVWVtVHJBZnlFaElTb1FZT0NqVDhmQnJkRjBublZJbHlmcFYxOVlS?=
 =?utf-8?B?UDZUeVNEc2U4aUhTY2JrK3A5TldycGF4Rk9BWWh4SFdKbXE2THV4c085MGJq?=
 =?utf-8?B?VkhheGdJR1J1OE81TlozOHNGUHpxeURvTCtwQWVueWRSWnpSNnpoS1dxcWJN?=
 =?utf-8?B?NkY2a0xicXpOa0x5VS9DSzRwMXlqekZRRUpDalpjTERoYkMySStVTURVanpm?=
 =?utf-8?B?azBFTndWNWhiQkhHR1VUMSt2cDZtdGpjZWt3QWUrZE1udXhuWFNnVUZBTy90?=
 =?utf-8?B?eElCN0NLZmJqK1NIRnd3eWhUblRMcDJ1aEtaSy9pSnl5VWdlenpLZDFKZWxh?=
 =?utf-8?B?Q1YyTE1IWnRlVVc5eUxUTnkzek9teXprMlJTRjJMU3BXWHhQV0txZkl2aGJE?=
 =?utf-8?B?ZW5ibS92bjBzdE1FMkhqWWJKUHE5ZGpBVmo1d2JIREsrdzNrOWgxZUU1aHZ5?=
 =?utf-8?B?Y3pnY1dvY0xCS2xtL0tjeGNGSC9JN2NPTllPK1plSG83eDY3ZUE0d0hVU21s?=
 =?utf-8?B?SEdqS1FYMzY5Rk9ZbEhnUnZUOW11T0crenljUUFhdkxVckNSdCsvVFcvUDk2?=
 =?utf-8?B?V3YvWjFpOVJhcXIvNldCbGtqUE5vQVUydUJVZDZjUGVKcTAycDRuMGlwb1Yy?=
 =?utf-8?B?NWt6cGl4QlRBdnFmWlc3UkcxRUlrbWVXU0VieEduMW51aE9BVDF0RHBwcUlC?=
 =?utf-8?B?TkI1ekYxa0pDUHVJclU2OTVVL0NNa2l5Q0dDQ2NsdjF6S0xNQ1JFOWRPSjdh?=
 =?utf-8?B?Tm5udDFBM2NBbVk5RkZ3Ni8vcStFaC9BYzFRMzhpS3JWcFpQUWVhRmRVQUVW?=
 =?utf-8?B?cWdDQnErekExd01NUnN0R3hRanRHdnZXalhwLzNZQTRjRnpzN05aMzRCQTh4?=
 =?utf-8?B?WjRWLzJMRXFBREZZeGlLNGc1MkFGUHhaQmdKcTdVeXZJMEljMUlFTVF5dHo2?=
 =?utf-8?B?RmVnZWVtWmh2YUM2WU1ZSUdEMmZleU1FeW9odEhYQ09GaFMrTDA5Mzl3eUV4?=
 =?utf-8?B?T0l5TWF4WmIxQVBwUHFrQ0xEcEZyOGlzenpXUTRzU2JCMU9KcXF6MXRDbjJG?=
 =?utf-8?B?ZEp2dGxzVlZWRjlxZTJWL1BvdmFOdis5QW1xQWczWjdNdXRhblN5ZEwraEtj?=
 =?utf-8?B?SytiTmJoOW9GeERSL1IvVEJHZGtDYWQzeVhmMHErQWJuSzNkWGJKRkdNbHRB?=
 =?utf-8?B?bk5xSHBaWGt5U2RFeXlJc1JMd3VSMndvUGdoMVp6a2sxNkpSVnA0ZUJvY0tn?=
 =?utf-8?B?VnBtSlBtV1ZqV2dheUdrTGZ1TmFzSUNRWUVxVlBHeHpyOVVmcHM0UmxYYmYx?=
 =?utf-8?B?UkhKd3I3Z1plSldoWlBOTmxjOGxpY2pLU3RFYzd1Q2laTkZTb3RYTVdCcGt2?=
 =?utf-8?B?Mmo3bk5pcU5nbzRsZzQ0MkIzcCszS2cySlYwK25JTW5VQ0lVQkE4QnZmTSth?=
 =?utf-8?Q?we8DOJBLlmaVokgV59HDZ29De?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00227bf-46a4-477b-feb4-08de3537ff1e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 02:26:15.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9CP3/A6Ihm1Ale7wefttMh00bSG3PaiZg4IO/Jfs6eLhoE56kR/qzYc4GfgNB2BSQ8RcAC3F1Jgsk+vN3ACOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258

Hi Zhi,

On 12/6/2025 7:42 AM, Zhi Wang wrote:
> To support the maximum vGPUs on the device that support vGPU, a larger
> WPR2 heap size is required. By setting the WPR2 heap size larger than 256MB
> the scrubber ucode image is required to scrub the FB memory before any
> other ucode image is executed.
> 
> If not, the GSP firmware hangs when booting.
> 
> When vGPU support is enabled, execute the scrubber ucode image to scrub the
> FB memory before executing any other ucode images.
> 
[..]
>      pub(crate) const fn create(
> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
> index f107f753214a..f622c9b960de 100644
> --- a/drivers/gpu/nova-core/firmware/booter.rs
> +++ b/drivers/gpu/nova-core/firmware/booter.rs
> @@ -269,6 +269,7 @@ fn new_booter(dev: &device::Device<device::Bound>, data: &[u8]) -> Result<Self>
>  
>  #[derive(Copy, Clone, Debug, PartialEq)]
>  pub(crate) enum BooterKind {
> +    Scrubber,
>      Loader,
>      #[expect(unused)]
>      Unloader,
> @@ -286,6 +287,7 @@ pub(crate) fn new(
>          bar: &Bar0,
>      ) -> Result<Self> {
>          let fw_name = match kind {
> +            BooterKind::Scrubber => "scrubber",
>              BooterKind::Loader => "booter_load",
>              BooterKind::Unloader => "booter_unload",
>          };
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
> index ec006c26f19f..8ef79433f017 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -151,6 +151,33 @@ pub(crate) fn boot(
>  
>          Self::run_fwsec_frts(dev, gsp_falcon, bar, &bios, &fb_layout)?;

Could you elaborate on how the timeout below works? See comment below.

>  
> +        if vgpu_support {
> +            let scrubber = BooterFirmware::new(
> +                dev,
> +                BooterKind::Scrubber,
> +                chipset,
> +                FIRMWARE_VERSION,
> +                sec2_falcon,
> +                bar,
> +            )?;
> +
> +            sec2_falcon.reset(bar)?;
> +            sec2_falcon.dma_load(bar, &scrubber)?;
> +
> +            let (mbox0, mbox1) = sec2_falcon.boot(bar, None, None)?;

boot() already returns -ETIMEDOUT via wait_till_halted()->read_poll_timeout().

The wait there is 2 seconds. I assume the scrubber would have completed by then.

> +
> +            dev_dbg!(
> +                pdev.as_ref(),
> +                "SEC2 MBOX0: {:#x}, MBOX1{:#x}\n",
> +                mbox0,
> +                mbox1
> +            );
> +
> +            if !regs::NV_PGC6_BSI_SECURE_SCRATCH_15::read(bar).scrubber_completed() {
> +                return Err(ETIMEDOUT);

So under which situation do you get to this point (!scrubber_completed) ?
Basically I am not sure if ETIMEDOUT is the right error to return here, because
boot() already returns ETIMEDOUT by waiting for the halt.

If you still want return ETIMEDOUT here, then it sounds like you're waiting for
scrubbing beyond the waiting already done by boot(). If so, then shouldn't you
need to use read_poll_timeout() here?

perhaps something like:

 read_poll_timeout(
     || Ok(regs::NV_PGC6_BSI_SECURE_SCRATCH_15::read(bar).scrubber_completed()),
     |val: &bool| *val,
     Delta::from_millis(10),
     Delta::from_secs(5),
 )?;

Thanks.


