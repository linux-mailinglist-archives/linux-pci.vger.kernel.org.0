Return-Path: <linux-pci+bounces-29393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B53AD4A1C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 06:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B322117B44D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 04:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30D1DB346;
	Wed, 11 Jun 2025 04:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f23yF3vO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9229117E
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749616825; cv=fail; b=nOtipH4gYqKPUT4f6Dy/Ztksx0nl33j9zml3e19tyh5D9zht5mfop7gYstvl+35Q2kb7EMh8cq5yvTtrLG/8yJl9jpzTGFrbJVmlCkljHQuqcfXzdK3tsbQ0J0P2cjwlIKyIRQScDqW0OEJ99BXKbHA/n1HQ/xUXbTh4BIIhsVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749616825; c=relaxed/simple;
	bh=Jw+FX//PgeRSJCEC/ekSRByqYXlV6uN3l2EvT6LdlH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QH90ObgGilYFamMOyg6c6HZ0QfHG8f3dZcYpJ7q7SZyoqNqecbuMXGZxcUBFgvzJdMvHG2zbGQwKV0bRMCmD0dM3u9/+C0crwqUDloH1BvkU5CEpjH/GQCpT3LLB/HgVM7ISJJhZ7WtkqP+qsxReUTKUGnpKQeuwTORBL4OqrNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f23yF3vO; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw3w4IiTfOBUfQPt1L8ahMjPYIRe24IzMx0yAT4i6IQxx6QVGj34LjsvNqqPcrvQTIO0Bx+PhYCEzNfttHFJv3vtiwVwcdhZmXciaEqW+37zcZYAFVkpEnPhTIPp3XDDVyhB9x/q0FoFCH0UGfvPKEwtV+8rJ5JK97HIMGMb+LMSiVNUiRu1x17QLyI80yoK+rbaD6autg3Fk8ZrvfMqE5MfFaieNbc4bLN+8kVAL3LfbopBxdHto3p8xb/1a9bjrokdEg13Gj4Fho26wOmwjf4WnKjqxCblBnpTetwYgS4RqNbY1tQtOdCHEJLtbwGJUU1qWTEM4rXB0hl/Eznpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvzXvd+Z2n5PXX7Eno+7hkchK/pAj30rV451yKskFXU=;
 b=O9d+oSjILxFrN4YDHKMvf9IN0khtgC8G8QwbhwtgrkeldruqNCF7WD1Ot3032DjtqD/jSKxVaa08B5d6OU2Ctsh4fxmPeG6rZDHutuji6tTUmT2Y54Twi5j37CnFoULYtqze2w2sjfSqGxQPiE/0MpODO6gTjWwIZ47HNboifCD8343owTnMEIRVGpDhUHI8naIifN+Nx+NBWY6TFp3cbQ43x/XCCztgQFvv6TygZb59PdeqOp5GTmX3fDHldxsv8Q86RqUf4xit3IELb+cZDJG0OvZwFUTzBHsAf209pzewuX2Pnlkms/Mu1UOtHKj85vl6MhWMVLnEMTR6t56iGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvzXvd+Z2n5PXX7Eno+7hkchK/pAj30rV451yKskFXU=;
 b=f23yF3vO/VnLpPqgemhumiKy2ioC1bNoAAk5X0PbtX5kGA6C4uA2qfr+gW5LNEstyQ51E7B0YcDkHfYGYEOoz8U0XDIpzH3UkjPSg//jBAAH+ql+ehHeEdRWl5pU/nqpcbTVwQNAUki0PPvDabbVDDGMrtlP4mIqEhUNnsgbcQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 11 Jun
 2025 04:40:19 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8792.038; Wed, 11 Jun 2025
 04:40:19 +0000
Message-ID: <dcd28de4-010d-4919-8db0-64e807726ad1@amd.com>
Date: Wed, 11 Jun 2025 14:40:12 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
To: Dan Williams <dan.j.williams@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, lukas@wunner.de, sameo@rivosinc.com,
 jgg@nvidia.com, zhiw@nvidia.com
References: <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org> <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org> <5d8483bb-ceb7-4ef3-920c-d6286a7de85d@arm.com>
 <683f7b6fec30f_1626e100ab@dwillia2-xfh.jf.intel.com.notmuch>
 <53c7523b-5cf3-4047-831f-12e0422cdf5d@amd.com>
 <683fa6f622abb_1626e100e0@dwillia2-xfh.jf.intel.com.notmuch>
 <683fa76214ebf_1626e100e1@dwillia2-xfh.jf.intel.com.notmuch>
 <60812b1e-d01b-40ef-9e59-c6ab970e17e2@amd.com>
 <68439c325a714_2491100f2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <68439c325a714_2491100f2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0142.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::12) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 57418f9a-5bde-4a22-575f-08dda8a21172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NC9zMUV6alhRQm9SZXIrZzBIblljcVNzNzNJeC9zWHd3QURGQy9vbEVteS9y?=
 =?utf-8?B?b01aZjVwL0p0WmZlTXg5Y3B5U3BXZzFndHpxUGdpV3dkT29pcFZOaHRhS1N2?=
 =?utf-8?B?ZWk1dkRRSTAzd0UvMW5CUGcxcTBxczc0VlBMNU4rOTl2UmtMMXRiV0pETER3?=
 =?utf-8?B?c2ZtUzFpYXJQK1NSVnZBQzhCTkJxNnhZL0NiMjUzMFdiNnNlbUk4TVJydmpi?=
 =?utf-8?B?RU9kYzR3Ri81aGhzUDQycUtPdHRhOG0wZ1N4Qm9PUGQrZDdueUJscmhnQjJi?=
 =?utf-8?B?aTdJYTN1blZicUNobDUrVks4ZGtibE93NDVoUU1Hclp4TzkwM0QrbFUrN1Vm?=
 =?utf-8?B?ZllTcTFxQ2FKVHhsSWpMMjVlaHh2bHBUeGxidjcxcFNkRDBiVFl5ZkRlOTVW?=
 =?utf-8?B?SnFWdlR4OEsyMjdxVFdNTTBQNnhnQ0xnanh0Ym5WdkhsSjdDaXd5Z3NmM1B6?=
 =?utf-8?B?VGxheVRTTWlRdHhDTVV1UkhIa0ZSZG5WaUxOWmlKOVhtc1BkMXZXajZtM0FM?=
 =?utf-8?B?ZEM4YkxkbzRBcXRXTXJucFgrZDNUb1kydVZLWWdCZUR6bUxYcEFVV2RYVC9M?=
 =?utf-8?B?bGZmc1VKSkcvWmlrZzNQUUxRWGFRRjN0Tmd6RlYwS0RvTm9SSFhhR2pyVWwr?=
 =?utf-8?B?VzZualMyVHU4c2l1Ujl5RnFZS3VmOFU4K1ZkV2tMZFhKWUx6ZXM1M2hYdGFj?=
 =?utf-8?B?V2x3NW04LzR5aWRXTzNDc3FPN0tPZldMUTJTbTRwdHpWcWdZR3RmOGJIdVJl?=
 =?utf-8?B?aTRRMmRma1VIdGNCdFErbEhveGV3bExpVmlPSFVnNGU1RFNXSVpzUi9wUkR4?=
 =?utf-8?B?bFRqSEZJd1hZd1Q3bzhlRVFvUmJyRlJlMVc0b3UyTlc3NFRjVXB3VVZod1NB?=
 =?utf-8?B?N3E1WjdmTmIvMEJoUUFpTmd6cTg0a3g0bUF0a0oyNndJUVJUbzkwOU01NTZB?=
 =?utf-8?B?OWxuL0ZDRDVJRVpjSmppcFd2S3NvV1hoQkxkeUVlSkpDdEs5b25EQmdrUE44?=
 =?utf-8?B?emZqL2xlWHFzUnI0NkpIcS9EcWIzSWNQL2NCM0RuTWorOFdFZGFkOVIvUjRp?=
 =?utf-8?B?aGErd1llWTRtdVNhZVR1c2NBL3BaWXNzVmI1aHpJZUwyUEQ2VFBXWnhRcXBi?=
 =?utf-8?B?VnFCZ1BsRHRnZnc4ckp3eXJDOFV2bkFhMnA0ZDF1U0d0b2lGTVdQVng1ait5?=
 =?utf-8?B?UVQ2MlFyNFdVL3dHVkJEM2lhVXdCTENHc3prbFBJNlhkQkJPazdGODBDUHBz?=
 =?utf-8?B?bkIxd0Q4MEpYRTNJZWRzRXVQMDFzMGpWYmZXSU5NRUxDWFRmUFZIVU1hcG5M?=
 =?utf-8?B?U3JuV0lDK1dvTUJuOEZtSjdXd1VFQVRsa3dzNEw3S2JiV04yRWFpZ1hIdXRo?=
 =?utf-8?B?UDd3amxSVGxkS3l5SThxRzFxbEVuNWRjWEZUdGhmVDIxZUxEWDZRcjRKMDM3?=
 =?utf-8?B?T3RBd2JQQ1VodFBIa1J1WVdDVVZ1cTVDc2hzZ0tYNHRJQk1wVVlMbm5IQzc1?=
 =?utf-8?B?ZVloMTFJbm9aNjVZODJSYmlSbkZrS3Z5UElPYW9BckZjNFlVUHJ1bFZCRVFM?=
 =?utf-8?B?eS92SzkzUlFad0JWejhWazdXQ0lNb3FWR3oxTkZEdFY3TkpoZjFrUHFsQkpY?=
 =?utf-8?B?WXRYcVJVS1BHNzREOVFWczNnL2JEWTh1OTZEcWJRRkFmU1hxMXVwYVo2NVUz?=
 =?utf-8?B?Mngvc2xQNzZkd2JVN3laREJyeThmVHNjQlNwamI4c290eWpBTXloSE5ia0VC?=
 =?utf-8?B?dER3ejFiWlpiQktlNkk1MGw3cWFoQ0FwdHBFWmNpSy85Z21ETzhwZUcvTDNm?=
 =?utf-8?B?RU9saDFNcGUvYTFoa1lNTkpueC9HdFQzQ3Q1d3NSaElzTGZ6S3NxVm5KZmVa?=
 =?utf-8?Q?YsLJ8CCvDHHC/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnBXSHVvNzkyQnZyVFM2N3VJaUVTSjYvYU96VWYyUUJvSXZGR1l4Q3JFTVZl?=
 =?utf-8?B?a1VrQnBMZVU1VWZnSHlTemNYY1NYOC8vKzFPV3RyeWIxNUZpQ2t6QnlPVnNi?=
 =?utf-8?B?cHQ3NnhWWCtpOW1STXk0SEV1N0lPYkVlUjRLR1VVL1BPQ1drazRUclBPMFlH?=
 =?utf-8?B?cDd3aTk0WEFsN2dZZzVYU2k4L1RrcmFpemJzTUwvVzdOWW0xZFlwNndTVC9p?=
 =?utf-8?B?bWQyeklPMnJWYngvS3pCVlcvbm5za1lDU0IyRk16WnkrTWRvZ0d2czNXaCtF?=
 =?utf-8?B?OUFGa2JkSFc0VldZV0NPMkJrakNyWUdDb2JoL21GTzFDeFFNelRod2Y0YXNN?=
 =?utf-8?B?RVRaMEQ4cGl0YUNwQzdBM1d3ZHk1WmxwVnVYdXl3Vy96VTlEUUhQK0hEQ1Iy?=
 =?utf-8?B?Y1FxOVJiSC9FUHlhSXNhaDRTNVVMYXkwanM3ZjdPM3pjejhWckFnQ1NPbis5?=
 =?utf-8?B?TXZlZm4yT1ZkZGdYKzNMVmVHZkF3ZWNWclUwcy9KOHFLOFBoOGtDODJGQ2VP?=
 =?utf-8?B?NXppK2tzZmdZcHFyYkZBeDlwamh4RUxWRlE5bitjdmJTZlYrOE9HZmpScjRK?=
 =?utf-8?B?TlV6Z3Z3OGJnamhOeFBhK1pKZW0zUkIraUFqVWZqN1QyTm9GZitUZTdiYjZT?=
 =?utf-8?B?Yy9ySUtWam5yNmtOdzk4TFZ2SFQvYk11RmhsVzNtZGlpRHFxYTBMVEFMS09N?=
 =?utf-8?B?MWtyMlhKM2JKRDZWaXFpM0RxK3BjeTBRdHFPOEM4T3NYUm1vaThLdnBIVDFH?=
 =?utf-8?B?anBBY3BQZTNqZzBNSGVGMjJlbU9GYUV5TEFUMlJJVnppOWJVSzFzZ2xkN2VR?=
 =?utf-8?B?R0h3ZXpsUzM1Und6YWlZOElxWHcxM0t5VTB1VE9QSHBVbWNjM05manZOelNR?=
 =?utf-8?B?MDhIN056WGp6NlBGQmM4ZXg1dklaZFZsNGVFMzRyK1FyaG5MR0R5MkRxZmhH?=
 =?utf-8?B?QitqaC9lNGdjN211d2J1YW8zb211WG5QTGswVmJHQnJTd1RId2hyaGlCbmg4?=
 =?utf-8?B?Q2xUeG1PcTdSY0RaN3FmMWJLQUZLRDgybm5XYmZTSWhicjVsMzNGTUVHNlhJ?=
 =?utf-8?B?ampyUjRkQkNERC90dCtCSjNFZDVkNnpEOXk4cFFONCtiNjBZQXZ4aC9UOUl5?=
 =?utf-8?B?azJRdlJ1QXg0N2Z1RmRjOVR5VVFZQ2xzSFBoS1dpSHRaSjIyN0dTVVY1Zk9Z?=
 =?utf-8?B?R3dzMis5dHA4SWJRWGhlMFlWaVpMcC9oQjR6dWNDcFYyZW0zUS9YaGRJOFVS?=
 =?utf-8?B?eDE3YzczaFM5QS9YNDExNTFPRGJLM0pLVGIwUEZXSjcrRWFlSml3YllRbS9w?=
 =?utf-8?B?aEVtRFhoQm8vNm9JMHRqTDVoUTJNQ3NvMExrd0VMa01uVEtsaFdHN3BoS2Q1?=
 =?utf-8?B?TWpFZXlUT2xIZUorUVJxMXNWWGJsaXc5RjhFOG1KWlJvbjJydjY5YnhyWVdD?=
 =?utf-8?B?Ujg4Y1plemJTZHVRWTlpM2I2c2R5NkVZQ0JPY3c3Z3d1d2lSTUpydURxMUVa?=
 =?utf-8?B?MEZLcE5XOEpFT3FWUzdjVGRLQ3o4cXRFaDZPZ0RNbTFiN2drQ3NmempZdnJZ?=
 =?utf-8?B?NG12dGx1bmZhZTl6Yzl6aExxK3pXMjBEUmpWdjBPT2JIT05rMFZ1TWpVMlNZ?=
 =?utf-8?B?WVBaMFBhV1pidG5IY0ZEeUlXZHVVUXdRSUIxakk0aXFScU84cEpTWHU0cncr?=
 =?utf-8?B?TjJaZnNSaHowbDBtVUJJbDJmMXFud1czTDNpM09uZjF1V2JZc0FnMjVRY2Vr?=
 =?utf-8?B?Mjd5aXlYYUZqcXJwQ0RNTTd3dkZXN3RzNk5hOXNmUkl5RjdIUFRJdFdLbHc0?=
 =?utf-8?B?UnBBN29GeStiU0ZKbFJkR2Q2UFlCWnZLTWZxVEt3aTQ1WjhWRFk3M0NrMXBD?=
 =?utf-8?B?d2M3VnBLSkNXV1hkdDgrb25CYS94QW8rU2k1bzQxWC9RQ25xWGJTaUJhODQz?=
 =?utf-8?B?UTVIaFU3QUdINmtTMFdiWml5NU5HMm9LeFJ6dzZ3R0N3YzdKdjBCYXN5b01w?=
 =?utf-8?B?T1JvVW5oM0ZoUU8wTDNhWTBOY2hrS25XYUdkSWd3aHdGcjdSQ1hUYVZhOGZt?=
 =?utf-8?B?dGtWNzhQbUJFVjFjakZZdkN1bTZyRmVDMFJoZDVDL0QvK0Q5MDJ2SmwzaFUx?=
 =?utf-8?Q?1f+h9M5AP0DYntW6pnQrFhE2C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57418f9a-5bde-4a22-575f-08dda8a21172
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 04:40:19.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adO+lY7tBRu8/y4azRaeswOtOv6V7n97jy0yVo9Az44fVlO60aXd4zjEBollfSoYZiGBX6sSq+mnhul52uJrpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652



On 7/6/25 11:56, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>> but the point is still that we
>>> have not even got one implementation of a bus Device Security protocol
>>> upstream, let alone multiple.
>>
>> And my point is that TSM does not actually do anything with PCI except
>> SPDM/DOE which can happily live in a library or DOE (and called from
>> CCP or TDX drivers) and the rest can be just "device", not "pci_dev".
>> I wonder if+how nailing TSM to PCI makes your life somehow easier, it
>> is not going to help my case. Thanks,
> 
> The goal is not to solve Alexey's case, the goal is to solve the TDISP
> enabling problem in a way that all impacted subsystem owners (PCI,
> Device core, DMA, IOMMU, VFIO/IOMMUFD, KVM, CPU arch/...), and all TSM
> platform vendors are willing to accept.

Right, so I need to understand how this TSM makes your life easier. I did show my complete solution, still waiting to see yours or any other really. For example, DOE bouncing.


> "TSM" is literally a PCI-introduced term. It comes with a full
> device-model and state machine for a protocol that we, OS practitioners,
> have a chance to agree what it means. If another bus wants to do "Device
> Security" ideally it would map as a strict subset of the TDISP model. If
> / when that happens it is easy enough for userspace to see "oh hey, bus
> $foo now has tsm/connect and tsm/accept mechanisms too".

Quite a chunk of it is in the SPDM specs which have all sorts of bindings. No strict PCI.

VFIO started as PCI and look at it now with all these platform and mediated devices.

  > Just like the evolution of the "new_id / remove_id, and authorized" bus
> attributes, other buses add workalike functionality as a matter of
> course. Other buses can add "TSM" mechanisms to their device model,
> "TSM" is not a device model unto itself. Similarly, nothing stops
> 'struct pci_dev' properties to be promoted to 'struct device' when
> needed.
> 
> I note IOMMMUFD has the bulk of all the interesting cross-bus shared
> work to do here and it already has a generic device object model for
> that purpose. It is another example of "extend existing objects with
> 'Device Security' properties", not "add a new tdi_dev object to manage".
> 
> I am frustrated that we are still spinning in this philosophical debate.

That's because I did not do very good job explaining my TSM, my bad, I'll do better, it is too bloated now, and violates sysfs, and should integrate with Lukas'es work, my bad.

But having this all in a single built-in (1) with PCI nailed down (2), globals (3), one tsm_ops struct for both host and guest - this frustrates me.

(1) means annoyingly many reboots vs rmmod+modprobe
(2) TSM does not IDE (the platform calls the IDE library) and does not do DOE (the DOE library should, called by the platform)
(3) bites every time when there are development bugs
(4) leads to ugly "if (tvm_mode())" checks and bugs (when missed), been there, done that with my first TSM, did not like it.

1/2/3/5 are not necessary, do not really make anything simpler and most likely will requite untangling later.


Say, there are assumptions already made for IDE which I believe we do not have to make (like, same number association blocks in all streams) but it is internal IDE detail, can be changed later if needed, but the API is sane so I am ok with the limitations (thanks btw!). But the TSM just is not there yet imho. Hope it all makes sense. Trying now to move to v6.16-rc1 + dmabuf + this series as we speak so you'll hear from me soon :) Thanks,


> In terms of progress towards the goal of "shared commons that all
> impacted subsystem owners are willing to accept":
>> * Bjorn acked the PCI/TSM approach [1]
> * Lukas is doing native CMA and SPDM work that may yield a shared
>    transport for multiple use cases (SPDM/CMA and TDISP) [2]
> * Greg gave a nod to the PCI/TSM staging approach [3].
> * Aneesh and Suzuki are helping out with ideas [4], and fixes to move
>    this forward [5]
> 
> This is not a competition, this is carrying a shared upstream burden by
> consensus for the benefit of ecosystem use cases.
> [1]: http://lore.kernel.org/20240419220729.GA307280@bhelgaas
> [2]: https://github.com/l1k/linux/commits/doe
> [3]: http://lore.kernel.org/2024120625-baggage-balancing-48c5@gregkh
> [4]: http://lore.kernel.org/yq5att5f4osr.fsf@kernel.org
> [5]: http://lore.kernel.org/20250311144601.145736-3-suzuki.poulose@arm.com

-- 
Alexey


