Return-Path: <linux-pci+bounces-28982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A8ACE08F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC1D1883145
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4177728E3F;
	Wed,  4 Jun 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uq2SkXib"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0E28C5C0;
	Wed,  4 Jun 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047946; cv=fail; b=GurZqGhmKbZIpHZTFIwQdULr7VmykYpccgTletIPsaHHJO/wvHWkm5gD7JztFuV/nWa/hrK2b2A9gBnNJKwnpT/6tq2+LBfEt3TQwVG5mxb7qK/o+uxeGY7Z2iRIE73Wa3JYBW81lhGmxYZLHQTYL1RYRIDDnHRBFR67p77Hu8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047946; c=relaxed/simple;
	bh=klbSJM8z35hpC/Lsh+Q+P/6dMHizviScinqVVqXMwag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dKc7zYisgIplkIr7ltxjH+cWRIvNAOnhR+m3psO9YUsO/6ZzgAATe1MJriPgATZw0fTxgVMqNTcoUAtDBi1+53yG0YaUFXeX+kEiRNiDzCGi3S1yfJWI9rTIuAU6wH2Werq8rZWfw/QbdXumlpp/MvsQZuUmWj0wUQVzde/MRPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uq2SkXib; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKW67vmfH9c4IO0Hi78HCbpELftXZ67LNKuURJiphy/kaYDLcB7kNab2oX/NsPqWQrktGwb+oZ0DHhpvfQdIWeOpGB8typp9q+Nopl0/WXJw7x8POQw4RQiX4FHkve0s5fX5e+t/14zeeDd3RoFBl/DD7dc+37KLFqOzk7uj9HVdLZUMO11N9xPrrVhfgpptWxr2WOAMsH+l1MlmXzoDkOa2rhRjMsHSW6ZZXzvOLWNa/7SS1JxyBriWrhaeZ1WeRWhXTGRQnJaJQ0HkvwdE4eG8LGlQVGKCN/zXPifJsn7Avw/FcFQjbIhyQEi0PU+SY9IH5TFnCtSkX4XKEDD0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HDmS4V8n4x9ZyZwWw7aQvtEwXvnwukwMymDgwFPExQ=;
 b=gMHhNVX6eAmaf8Hlof1XinS5rgXV6/wU1ZkmafAWyui/ZqyUNvvEGsnmLoyxH2X6WbwX69fF+dfNG79rWYsFpu8lioLKptavyuwfKi31dvyU9jEs+5/tA/SsG98n7VPEDL3XL92Swx66hweJLlheOrOKlQsMrJXKx6FlEXqPF4cPhE3zglrov29rPygxBrbZHLF2v0ThAwM85apL9yQgmUj8AD30Q7WdAVS1JbMIomD+l18fAeMRxcuaV3KBspHuBq+sWyOQ7ZrQhR/59+9rhnCBHiht5WPqv/NCsuagGsWT9eL40EjrA6FM1rRk/7YA72asyIXtWYP6Xu0HLUQP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HDmS4V8n4x9ZyZwWw7aQvtEwXvnwukwMymDgwFPExQ=;
 b=uq2SkXibDaBZKFAKpijfGywIYJhyAseEbq6KJSlgXawdxQmGQa3Plia9PmULTYpcWIBBNd8tuOGbnzNfV+MFYDgY/m4NydpvjhsjEspqyNPHw88w9u4zU1pkKlWP6YOvcuuL9MhzHlJBzSAN+eACUg3V43aVylKlcQZMhaaum3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Wed, 4 Jun
 2025 14:39:02 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 14:39:02 +0000
Message-ID: <c11c30ae-85d5-4f00-a243-a3b7710b913e@amd.com>
Date: Wed, 4 Jun 2025 09:38:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
 <aD_iOk0vxDp88z8U@stanley.mountain>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aD_iOk0vxDp88z8U@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:5:174::38) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d53a050-d4a6-4a01-8686-08dda3758c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEhaUFhPSjYvZ1VnRFJzaDFOQVRJd1ZSM1ZYUkUyUzFZbnBVd1d5YjdOaDBt?=
 =?utf-8?B?L3RhVnM5TFVON3ZvYyt4MGoyOTN6SVMvRUFEaTdYMXhTTWJXdjR0dzM4WW9J?=
 =?utf-8?B?TWdDeDlWZTJjOHBxcnRhZFBkWUJMTTJoUklXTE4wVmxZMmxnN3hFZTVuckpK?=
 =?utf-8?B?OThBVGlTR0pYNGdVaWszbjAvQ0NsbGhxbnI0dksraml0OUFzamltV3lLR2lP?=
 =?utf-8?B?RkxabHd4OWZYVHJseUEvYmxHK0w4bHNZaTVhTEtib0RncGZRNWk1L2d6Q2Ns?=
 =?utf-8?B?aFcvQ3RoeUVISmlJRnpRTXZtVHp1dmtPRnpwckxsNEs2OXp5Rk1tRHhTOVZF?=
 =?utf-8?B?R1AxekpURzRESk1lNVB3TUE0WUN4OWdhQ043dUZ6SHBXUzRSZ2pDTG5jRVRI?=
 =?utf-8?B?dnZrdjZFUmRndjhEcWFSeWRDVGR2S3JxYTE1eklOaEk0OTd1NEFqQVhzZnJJ?=
 =?utf-8?B?YUQ3Q2pFelczUGlvaEpvZ3FLM1kvc3NvSktBMWVVYjZsNkJqWG52NHlOdTJ0?=
 =?utf-8?B?SXVaSHViSGdVbWJ0K1U1dGZpNUQ0Z2pnSTczVTAxeEN1V25EQkpKY0V1elRD?=
 =?utf-8?B?U0ZRQzFZbU5ZMldOZXdxaDZJS2RLZmFsTWVZTy9zeThncW1mN2Jqb1J4U1Jy?=
 =?utf-8?B?bG5tbXNmS0NnYTdFeVlsa3dKY015dGp6dDU2Q2JZZTJSTXE4QmwyeHR2Qi9w?=
 =?utf-8?B?bnlzT2ZtTU8yb1FjSU1qU21yTG1yTlBKem1ickl1Mld3Tkt2Y1IvNHBzMHd3?=
 =?utf-8?B?dlMzTmttNGtmS1dKZ2ZrZVczVnVrL0I3UVdsaUtJSmswQWU3cUU4bnBDeHZU?=
 =?utf-8?B?R3lacnVmcWxlTmUyc2pBa3gvOStHeEo2bjlMcmFNUXY1Tm8yMjYwUThSNTNs?=
 =?utf-8?B?eHN4V2NkcDdqRGY0OHhHZjF1ZVQ5bko1bkc5bUhaSzZCdnNSbng4TEJYRkZI?=
 =?utf-8?B?Wk42NUN4M1ZhVlN5SkczYURIOTVXVGlwVTdBbzVIa004cXdRU2ErMVFYL0Vv?=
 =?utf-8?B?V3Nqa0hxRGl4b254UEIvVUY5MDFLMnNyVXU4d2hLSmJlTHhWQnkvWTJTTnVX?=
 =?utf-8?B?TGF1dHRiOTArWGo1bjBoOGsxQ2FyT0E3ZG1wS2tpRjc2V0FHVVZwYlM4VjNi?=
 =?utf-8?B?bmZ3U09WKytSV2tMNHpONytrMElWTDJRYkN1M3lST2swNGlMb01wbVBEbjJK?=
 =?utf-8?B?N3RRd3VyNmRPTjY3QWkxVXNNYnY2TEJOWnpURHJnRGVtUFRGL0JCTUhJKytW?=
 =?utf-8?B?Q0dVQ05hU2NzM1N6SGJCV3JpZmJmQ2R2emVxRjhhemVtSTN3eEgxbE1TQWw4?=
 =?utf-8?B?dXVXRjlUWmRuM1ZNOFRXL0pEajNtYk54ZzFWaU1IUnVJWDFQNEJ5amJDVHZU?=
 =?utf-8?B?aTZmS3F5TEp3SzhQeEFwRGlmc2RiVmNLcExPUFczUHphc1k4bHFwYkJMUXB5?=
 =?utf-8?B?VW5UZVhXRmNBcTExWldiWkxJc1AxZS9qeEpNYWtRSGVDNEZGaCtwcmZsSUg4?=
 =?utf-8?B?UjVqcFF6czV1dVJ1YWNnejRMUUY3ZGNES0hDSndWRC82NFprZFFHRnF3NzBT?=
 =?utf-8?B?YjFqS3QwdU5EUWFEb095RXJkU21hb3g0WWwzVjhpUmRlbjRwUENueVp3T08w?=
 =?utf-8?B?cVBGRFdqYiszZ0luRysyZ1NBZjBJeVFDT0FqaFIzaTh2UGU1ZGdUN1YxZmEv?=
 =?utf-8?B?cjFCSDhydjZaUG1JdHgwNWtZRkpMRnRJc21oanluUU9jbEZVc1BBL05iSFFN?=
 =?utf-8?B?NHhvczZKV2srZ21aRkI2NFRKdDJLNUZQUERJTDVBMjk4dUYveDZNdjRqSkJ2?=
 =?utf-8?B?MFdueFZwak04UnVyTEpEREJjclpqL2R2NHhUQ0RCOGlUclcyc1pIa2N0eDZ2?=
 =?utf-8?B?TnI0NjZ1dXVTTG1QTU0vQ0JrUTFxV0F6V2FHWWFCd2x3UnhKV2d6M2JDOHB2?=
 =?utf-8?Q?ALjsEsTHeMA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjEwcFdHejA4Y2tWK2c0Q2pGZ09VVWM4b0xjZDdMb2p6WExPZnJKR1Zob25D?=
 =?utf-8?B?YjVIc1NKYU9qbnhLWkN5ZDlTNHIrRmFvdlV5ZFR3cFVpb2R0VFlTRGsxUFl2?=
 =?utf-8?B?MGVRS2ZxMVF3SW9NYkxGT29ic3FMamlUQnpwWVgvNURSZFpjRk9MNTE4NHBE?=
 =?utf-8?B?UmtGWTV3OW5od3c3WTJHbC9lVm9uRDQwbHBwdVhzSFhiWjVVcUlWTlp5RG9m?=
 =?utf-8?B?THBMRVl0TVJNUk9jb0lCZjhHcUVFaVAzWEVoUnd3UHh4NzdHMFhzN2lRRENW?=
 =?utf-8?B?Qyt3dTY3UVhIRWFBWVlUSm5PZGQwUDQxMGh4YkUvMWV5clhGTVZyUFZucWxE?=
 =?utf-8?B?bDhyMmxNS3pOMW1xMk1OS3BuWHFIVk9tVTNaQWVsdFByUzNsS3AxWGd4V2pz?=
 =?utf-8?B?eS94M0V4OWVONWs3aXhuLzBHdXFINjZiNU1KeDN0dXd5UWhrakQreHdscEJs?=
 =?utf-8?B?clN2VE9MYU5kQndHR241MlJ4bDJkaUtDcG9uR0dna3MxaXVYR1BPb281RmZa?=
 =?utf-8?B?SHlwVVlGOE5FMk1Na3JPbFZxc3NIR3puRjBtcU5ZWVlBUExEOUhJSG5HL2I4?=
 =?utf-8?B?YXpvRjFvdFZ6T1llV1ZvUEk0QUE5N0xDUnIrTVI1elE1N3ErZi9hV0FxWWpP?=
 =?utf-8?B?aHFSRlFuNW10RUJxNzBjYVBMbkUyaFRabFBIMlEwQkEyYnUwdGtDbmkrZ2o5?=
 =?utf-8?B?TzJTcVkwRkVQOFdVcDRuR3pic2VnMUx2RlBvaUkwa2gyU2pLQjg5a0lmcTBi?=
 =?utf-8?B?Yzk0MVJPdmxpQmdkc2NYU2t1dzgzZDJLbmx1cEE4OEdQeWhlaVR1ejRGL3Ez?=
 =?utf-8?B?bDRkSUFmZVFDV1BlaUJhMG54WWV2V0pkdkZocWpwRGZ0K3VnYlZuNVJzcHFC?=
 =?utf-8?B?OThhbDQ2RFUrNFdXRzJuVGNqQzZzQTVHNlU5SjJZbzVHb1U1aHlpQmlmZjhE?=
 =?utf-8?B?NnN4Ym5NaHpqQVVuZHpRUHZTSEg1dHpWY2Q1cEY0Zm44Q1oybVJkSC83cW5W?=
 =?utf-8?B?UkVNMG9CeEdvckowcFB3Q3loTDRtNXFVMlZjVEV2Rk5pLzdpdGNoQ0hrK0ZS?=
 =?utf-8?B?VmcrQVA2TjJ0bjUwSnB6eW9hWi9WejE4QU5uUXdNMm9Cb1o3WDVoTSs2VEFi?=
 =?utf-8?B?UGk0a1NaQnB4R1cra3kveVlNRnZUTThBNnZTTXEzSzkySGVrN0VDajRXSHNW?=
 =?utf-8?B?VkFmcTRnbVpBVlRZN1JlQVhEbjI3aXgxaFNEUG1vWUJXUmY0WFhHdDVrcFNQ?=
 =?utf-8?B?ZVJlclFqTzkvS3owVDFBdENiYktsSXdCSjFVMGpGakViaERNaUVCNGVzUHNZ?=
 =?utf-8?B?RTJvMzJKNEFBT3RVNldhckg3d0FXSVZXc0xlTDJqYllacjA5TXdFNDZrMlNy?=
 =?utf-8?B?M3k3VFFMcmpqS3ZNTHdLTFA1Y0twNmtRakRMSlZTUWYwMDZEbVNaeEhlRzhJ?=
 =?utf-8?B?cFdGc1ovNUZJRGlldDZKRytRVmw0bEx3NURock81LzNpTDR6SmNsa253cGRm?=
 =?utf-8?B?TjJVNFM4Y1JjdGg1RjVscU9iNmkyN3pIbFRWc1RvSUNzaDFsQVk0MjMvYlBW?=
 =?utf-8?B?YXJQaXFaeVRFY0Rqc2hURDRyQXU4VXBUeVUzTUUxWlpmV1hPbmdCcWdMN2t0?=
 =?utf-8?B?bmdjN0dNNUlUa3VIYkJ0VFEzM3V1alFaSjhVTjFsOEQxUlhKdHFxZlZSQ2Ro?=
 =?utf-8?B?UWJuak5DbG1Qd0ZnSklROXlQOUhoMW1jNnBGWjN4R2I4bXVseEFzekljZEs3?=
 =?utf-8?B?ZXhGOGxESFBrZmRnZVQ3QzBRUmZRdy95dVdnR1EwRitRUFZuQVI5dmpVVTRP?=
 =?utf-8?B?akJpakt5a1RjeUdGek5qRjJ1Z25SMXhzY09pU0hVTFJoL3FJbkxOalZTN2xO?=
 =?utf-8?B?Qm83THRkSmtaRmhIMjByWU90MnFoUlFOZDd6N2VZQndYRkoydSs0cEEzRHkr?=
 =?utf-8?B?d04vVkpYdXJ0ekhuRGNCM0xQZTFJbEJ2ajJMMDloMS9xeGhuTEFqRVN3UDZB?=
 =?utf-8?B?Sk56Z01veXNRK01FV25GdnBSdWRYUFBZK3ZjZyttRER1QmMvb01aNXdwY2Rs?=
 =?utf-8?B?eG51RUFGWU94TmwrbjRDT2N6RWhGNkxJdGpqNXp1Q1Q5eS9HSXZwVTNwK0k3?=
 =?utf-8?Q?+IkzVPSIhLkcR7BJU0hFfcXSz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d53a050-d4a6-4a01-8686-08dda3758c78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:39:02.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7XnDfNL6Rm02btOF6gcTDoqDWeH6mvCOIiebD8QD8x6rXQ6XUbBKcrTAp0NP/5wRMVBNmWKPb5DxdrUwsMThQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301



On 6/4/2025 1:05 AM, Dan Carpenter wrote:
> On Tue, Jun 03, 2025 at 12:22:27PM -0500, Terry Bowman wrote:
>> +static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
>> +{
>> +	unsigned int devfn = PCI_DEVFN(err_info->device,
>> +				       err_info->function);
>> +	struct pci_dev *pdev __free(pci_dev_put) =
> What?  Why is it freeing the returned pointer?  That should happen in
> the caller, surely?
>
>> +		pci_get_domain_bus_and_slot(err_info->segment,
>> +					    err_info->bus,
>> +					    devfn);
>> +	return pdev;
>> +}
>> +
>> +static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
> Ok, it does happen in the caller, but dropping and then incrementing
> the reference count  like this is racy.
>
> regards,
> dan carpenter

Thanks dan. This was an oversight on my part. I'll change.

-Terry
>> +
>> +	if (!pdev) {
>> +		pr_err("Failed to find the CXL device\n");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Internal errors of an RCEC indicate an AER error in an
>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
>> +	 * device driver.
>> +	 */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
>> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
>> +
>> +	if (err_info->severity == AER_CORRECTABLE) {
>> +		int aer = pdev->aer_cap;
>> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>> +
>> +		if (aer)
>> +			pci_clear_and_set_config_dword(pdev,
>> +						       aer + PCI_ERR_COR_STATUS,
>> +						       0, PCI_ERR_COR_INTERNAL);
>> +
>> +		cxl_cor_error_detected(pdev);
>> +
>> +		pcie_clear_device_status(pdev);
>> +	} else {
>> +		cxl_do_recovery(pdev);
>> +	}
>> +}
>> +


