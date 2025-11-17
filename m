Return-Path: <linux-pci+bounces-41326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A7C61FDF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 02:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8555035CCD7
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9923BCED;
	Mon, 17 Nov 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJyQGcPm"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A1236435;
	Mon, 17 Nov 2025 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763343265; cv=fail; b=rMSpLzuq6065MKSs3fvhGtv8xI9hoPwqrYcvXHQwdJdTxInwRcM++8kGxVScrAg/8g7Sup/rkApb26840qSxGuK1Y99jBQK1I3OHO/1kkiPWTdimnxP4Cwt9bkXPNFz1aAbTRPIsy9RIXR3ZVW+HQqyIddl52kbbnqH6cKSy7yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763343265; c=relaxed/simple;
	bh=pJb2yvutTxC9p3/8sMR5Mu9ei7jJdZeyZIvjuwFubds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MEGM4TjgTcKhJJ6oT+JFsd0sknpucwV8vUrFXvx1B8fpvZoAMKHTKTsSYQWdhA8EfW76NfZQ52jOmUAHoxi+pfx+lrwzVKJksKu4KPQEIRwAEcipcVUs7a9mJeO8kVAAxSotkL6u+bhrOouLgjV4Q71E8ImTJy6SI8frCE+ZDso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uJyQGcPm; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDEMajLaGimmkNYcX6auQDaer7+zaIvFWfIhxo1RY7jO9tlZnEs/s2jX+Db0+kUmu9u6osCnBQWf5VruYgkY46Xxhtj3Uis064GJllOcgKECN9ETOAVcbF8gLfShY2ebYA11PokZmh4Xi0M0xfd21y1fzXZf6rKWOaKHsKZkcOMW4qOj1qsC0BpP3spd5wDQ91/6dWYEFjpP8hEAO/5gsVdTXvwbPc/dT8TOXUOYzxBLoIAtH9cAM2tJziXSC90zEUC3LLe41ERcqEC77cc7MB31DIe/OYCf40+jDN9F6LWHtpdoNq23WhMyEfW2W8pRJ5XlbApE1qgmKPGQRrBF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcT+74Z8Kej3TgAX3ohIhE+A7sQ3+AuY77W1pTyYM+c=;
 b=OQNJdRIy6nx0L3m1n0czbN0vro6DttjZFFtl6z+DSVlQ4P7NqO2YTnyr+SmEd6kdbpN5oTcrA20EJ21+yQFiTlYqrdQA/6zV4lWDi0pd7oeYY4Z7agNKweevL5hbfg7DpT9aYyKsBYXpGTY7TFoZnesCZXsbLTC5hZuWv66umv2YUTDT90wesVYCMWwkIAvTq8qBoxIHx+gfnElvXGfRRH/hAnYdQsNin4VzyuPm6fxPNL11145chNWLMaIPJIpBRTZgpbIyzIVtbRVdcN3HBToQ3Bu4Y4aE8Kgk/XLIxaFWuz+Kq8LU6egc0VK8AQbhbTs4kZ0jYPN90IEdvF3JUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcT+74Z8Kej3TgAX3ohIhE+A7sQ3+AuY77W1pTyYM+c=;
 b=uJyQGcPmjNvB5LuHbi91u6VvfgHjyCB7TgJ7tEPG1bjbqrHsEwYu/HzTAmW54umdkuOIyH7VNZtM7QeZ3zdW2EabFflZ/Xv9t9UhUetnPKg2+BIRfTpPpaH97UgoWnqi+JTIOyuGVPzBuAeSJIlPEdNKd/MlccQTPBGyUJgUp28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 01:34:16 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 01:34:16 +0000
Message-ID: <442d4c48-8d6a-4129-b21a-cc2de4f0fcd0@amd.com>
Date: Mon, 17 Nov 2025 12:32:57 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel 6/6] crypto/ccp: Implement SEV-TIO PCIe IDE
 (phase1)
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pci@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Ashish Kalra
 <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Eric Biggers <ebiggers@google.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Gary R Hook <gary.hook@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Kim Phillips <kim.phillips@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Michael Roth <michael.roth@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Gao Shiyuan <gaoshiyuan@baidu.com>, Sean Christopherson <seanjc@google.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev
References: <20251111063819.4098701-1-aik@amd.com>
 <20251111063819.4098701-7-aik@amd.com> <20251111114742.00007cd8@huawei.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20251111114742.00007cd8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0017.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::22) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd7af56-7022-400b-febf-08de25796ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTVSaS9Db2JEWUpOOUlUUitiOXpsb05MaW5rY0JDK1NHSDE0UDcyQ0JyK0FR?=
 =?utf-8?B?ejhaS2xlQjQ2ejlkeGY5RStyaGNQQ3BOQWVVRnMyTUVWZWxjZExjUWk1cEdU?=
 =?utf-8?B?V3JPWUYvak9ILzJCQTNZdXgxb3ZZdk4xUFhvTjAyUGg4SGZjU3BxOUdXZzlF?=
 =?utf-8?B?VFZwOFNkZnNwWkdBVHdGbUlueFNwZ3J0T1ZYOVVqK1dqaHNMeUJzczk3QkFQ?=
 =?utf-8?B?SERHdmRTVVFaK3VSNkhxbi9oN0p4WUFJeiswblFzMTBVd2pJUDZRSXRuQ0p2?=
 =?utf-8?B?OWRWdGxlR1g3cno5cmY4WWc4ajVjY0tvYmw3d1dHNGVoTEdjVjc4TGtVZFRN?=
 =?utf-8?B?VkVTQnBlRjB0aUJiSTZNUWp4YThzckxST21QL1JKTmphVFF6bE1XakhpbzVv?=
 =?utf-8?B?RkFmNjY1UlFsTUFnTjRhRWN2citxVjdiektocFFhVEhtaEhqazFOaThNamc2?=
 =?utf-8?B?SUc4aEhHWHU0RmprWDZFMW5sWEs3S1ZQcEQyRmNvZE9jOWQ5SHJKaEcySXdx?=
 =?utf-8?B?Q3Z2Zlh5ODRiN3NBT2dqOVRYems5dkJlQnRsY2szQWZmZGJjV1NvaTZFUUVU?=
 =?utf-8?B?QWF6STUvWHBkL290b3krSDFhNzV1V2diakcvWDBrSjcvQ0U3WHh1b1k3eTJQ?=
 =?utf-8?B?TjJPdGtscWVpazhDd3o4MjBzeFJRV1RoUGxOUjczaUFqTnh1SWRwUVFFZ1BY?=
 =?utf-8?B?d2lidEdYdkVrMWFoekZVZmh3MTVQMTBqbUVtbS9McHljWFhJejNQTXYvMnZ5?=
 =?utf-8?B?RWRod3h5RUVMTkdZS3RPL3JHR0VhQXZMQ3ZnWGRzUG4yYi84VzUzN3U2VWJa?=
 =?utf-8?B?cngvSGZrVTNEN3FjVWpzeC9jOVFiMFJVK1QzN21GVHpvTDFIQ25lcWZNeWhH?=
 =?utf-8?B?RjdjaTFrdElZKzJSTzBjY1FzWjU4YnovZTFlV1NCb0tKaUUyNFhSczZSM0Jx?=
 =?utf-8?B?N0FGa1dNWnRZTnZDdG9lVXZNcFdkZFVrM3g3S0NHZXJlR1pGUUxqYXo1T1Ax?=
 =?utf-8?B?S1lBcHBXQ09BdXd0di96L2dHNUMrcmcveXlpRG44dnpuYUZmTXdKTE84ckpn?=
 =?utf-8?B?WGExdVA2bXJFSVIwTXpDQzhEck4wUTBIQjZlaEg3N1U0Y1JtQzNrWTVOZHZi?=
 =?utf-8?B?ekt3VWl1Q2lHV1d4Vm10dXVmTm9xSktwUnBMa3lOMkJnTjUwankyaW4wZEtF?=
 =?utf-8?B?SjdqNExjNHppUzRuZU1xbVJ6NWhVK0tyY2lGUCsxVzdSbWdiaHBaQk9xRC9Z?=
 =?utf-8?B?ZWxNbUhlV005SW12ZlNPLzByUEdFR005YUJBQmthdjNQOHBUQnZpbG8za010?=
 =?utf-8?B?UmlCWW9KRkJpS0hXWVVlVHQ5WDBmQ2xMWEpEUkNOb2NBdkwxckMxNTJoaVUx?=
 =?utf-8?B?SHViMXRKVDg2UVF2ajNHK3UzSEhTdFJucUFKWWVnRDdxWGw1YjRvUTg2aVV2?=
 =?utf-8?B?WDhvOGpSR2NKOWNHeFk5Z3k2SERJenlkT3RwR0xvdDZMcFZBVkpaalpLMzcy?=
 =?utf-8?B?Z0ZId1RtYXgvb21PeWgrT0s1THE1bFZadUx5MG9PY0h6WTRZSTJGVTZOZWFu?=
 =?utf-8?B?cGd6RjNqYTRvam9FZUhTN3NFTjYwNDBkbzZxUWFZVTNxY1JVY0Q4aUVxMjRi?=
 =?utf-8?B?cGZWWjBCTkNHTmFFTzhuZ3Q4b21DTTR4S3Q3NmY4ekZpRXp6dTJ3THVLQUlM?=
 =?utf-8?B?RTNLZld4SmhZb2JOOGZRRjNWcE55Tk55Zi8zSGJDeTY0NWdjN092Mm43VlNJ?=
 =?utf-8?B?RVR0bjA3WWhwN0lMVjZvMFQ2QU1ScGFadEdrcDA5T1lJSVRCck4vK2NsQ0hs?=
 =?utf-8?B?ZHR4Y2Fta1NyRU5wK1dlYzUxbzBCaXl5bUtINVlxWjMwemFzRnZ6MDFwT2RV?=
 =?utf-8?B?c2FtazN1TnZINTlIUUYyM3RoVzQyQXUzbXdaenZWU2RwejJCczdmcWh2Wmpx?=
 =?utf-8?Q?NGsm4SRI44hne9qF5JPVbcV7pX1v+Fa8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXZrQmxxanBnRE9acFVSOEJOczBIMkRQQ2VCQVUzWmYwS2p2VVBnd0NDVHI4?=
 =?utf-8?B?eE1jNDMzaVhtM3FFNFVVWVB6K1lVMGRrY2d6aFZhbUFBSVA3QTd1aUJWdG5j?=
 =?utf-8?B?MGpuNkJBSHJuRGV2K3grVDl6c3JSWTBFYkh6UjV5V3FNZ2s5ZlJsbzZxamZi?=
 =?utf-8?B?eWhjWlBXZGxMWldwTEVtOFlaY0hYb3BjQTJYd3lwTGpxczdMdEIraTRIMXpq?=
 =?utf-8?B?MXNOSytDUlRwMlVGUjlVMXVBcStmdlpmcFhlT0lCMmd6OGNQNHJNYUtNek5D?=
 =?utf-8?B?a2o4TE4vQ3FBbUdIWDRmMjhmeUx6a0d0YVVVUEd5eHJWTWZrUHFaM1ByY0FC?=
 =?utf-8?B?ZjdCTncvVStwNTlHaW9hWE14UlRXVS9OcTA0cms0L0o3ZDlEVy9mQnhGcEQ0?=
 =?utf-8?B?OEkzWTd5cm8zMHRINFBsZ1hRdG1hTW5zY0FUeER6Sm4xNmNGQmFxY2RrUnU1?=
 =?utf-8?B?QjlvOW9UbVc5VlhjNG1PZFNVc3d5UTE1RHVDQ0ZkVXpWeHlERmhaajZ2QVVa?=
 =?utf-8?B?U1dQajBIMkt4NDBRNXk4QzdUQ2t1eDRlSU9VZjR3VUZZQmNZMDVZYllsTjVu?=
 =?utf-8?B?V20zSGF5V0ZyK3JYRWNtQ3Z4c3Z6WlBVdCtNWEFRTVQzMVM2L0wyMHV2YUY5?=
 =?utf-8?B?NXQ5YmZqUW9tTS8rK3NSa2liNUM4TjA2QzY0NXN4cmQwVDdzV1NxTis5dFN2?=
 =?utf-8?B?M2R6QnhCd0xFcVQvVmZGVjEyMFpGY2JVMU9TR0YwZ0JsTk53bnZQY3ZHbEsw?=
 =?utf-8?B?WGJNR3kva0REK0JRUGttWCtGVmt3WWZzQ0xwTzFXRng1L05rNWJ1L2o4NWNR?=
 =?utf-8?B?dERaOTE4OFR2L242bWJnYmhIVlFQWThTbW43d1FzWmRIa0R2dFpnM3N3SXpu?=
 =?utf-8?B?am1yMEh1WGs2U0dyRVFMdldiZkw3NUJzYlNBWkkvbGJXM2dtQm43VG1MQ0JL?=
 =?utf-8?B?TkZ3RjBsUEx1SzVKQS9Gcno4Mnlldkt1Nm9yRk10TGhyYWpuTHQvS3FZOGNh?=
 =?utf-8?B?Y0JCQzAzbEhoTmJjQTZRRGk0cFVhamkzbmR2bFI2LzJaYm9vdDRBUDNTNnRZ?=
 =?utf-8?B?NDJJeW9TM3hPcnpzUnRBV1FlNU0wVE9CZ0trZW1CWGxIN2Z2MWdidllxUkdK?=
 =?utf-8?B?QlhjVVhXZnVQcnVjUGI2NFpIUi9CNGprK3lydXZUanc3YjJCaFNxRXQ5UDdC?=
 =?utf-8?B?MDg0VUdzSU5Ea05MZDVPWUtnaXVSdzg0UmQ5NHJEanRNeEp4ZFMzNXExMEdU?=
 =?utf-8?B?Vzg1OFgvQlI0UEpDZ1lGYnFET0E4VFpvVUFVbU9mMmIyZWNaSVBKKzQ3YURV?=
 =?utf-8?B?LzVoYTFzUjd2RWFLTFpWWlJrdjZlNENSWHJQU0E4eXQxWmJocW8yVDA2ZndS?=
 =?utf-8?B?V0NhUEx6allUaUZmU1NFYzZQYSsyYk02K1ZiNDRJQ3pKMWpJa3d3ZjdTei9s?=
 =?utf-8?B?UVVTalN4VWd2ZnFXWUR1UU45UkdjbG9uU1FPRkRET1BnRnRzVkUydTBwZlRq?=
 =?utf-8?B?M3dPaGFucGN0Q2VPcnV1TjZXMlFEUDhzY0NkdGszWjF1TmxFbk56NWRNQktS?=
 =?utf-8?B?RnVLS0REVzBSczVxTEhkR2VDcC9QUjA3UUZCWHBObGlaL096aVg3SWdqVU9o?=
 =?utf-8?B?cEgrbnVGTlF6ZnJISkROYlJpTGgvbG5YSGpaMFd5Vm1NUC9KSG5idndIcjNj?=
 =?utf-8?B?RExuRHVpL2JqSmVGS2d3Vkplcnl6NUt5SGd1TnIwK0pETGJhODVoQW82RHBV?=
 =?utf-8?B?R3lvZFNXb3pabXZYcGNVbkMxY2t5am5mSks4ekJvTzZtZXpOK3lJUG94WVBE?=
 =?utf-8?B?eUFJRkhOUnk0TzFTRGR5S29VN0pXQW1hcnFLay93eXREcDRua09ZWTdpQUhh?=
 =?utf-8?B?RWVIVWpCNWsvQnZMWkw5Z0N0TUVnMm9PMlVDaE51aElJS0RINW5saVhnRDBB?=
 =?utf-8?B?UDg0ZlRwUGp2OFhXUHdhRHJHVXMrUjhsOWgrYUdZTDc3MVAvNUxxQ2w0SmFh?=
 =?utf-8?B?Wnk1MEFtMlJsRFgraGNlWHJSM1p3Y0pYaVNhSlRmd09lMjVraGE1MzVnTXBt?=
 =?utf-8?B?NkVpZ2dXRGZieFNjdi81b0JGNnpQU2hpQmlXQ2tCR2djSXRpRU12aWZOMXh3?=
 =?utf-8?Q?JKIluxVWqRxBAvcF41WYMwEn/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd7af56-7022-400b-febf-08de25796ba5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 01:34:16.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dzF8i2rBp9na28QKaavHBsCnCcQeBfhm8eqNx24lwSHqsVv7jF3uTaZeYBaq1tAlbNWCYwDbwq09noi9a7mLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821



On 11/11/25 22:47, Jonathan Cameron wrote:
> On Tue, 11 Nov 2025 17:38:18 +1100
> Alexey Kardashevskiy <aik@amd.com> wrote:
> 
>> Implement the SEV-TIO (Trusted I/O) firmware interface for PCIe TDISP
>> (Trust Domain In-Socket Protocol). This enables secure communication
>> between trusted domains and PCIe devices through the PSP (Platform
>> Security Processor).
>>
>> The implementation includes:
>> - Device Security Manager (DSM) operations for establishing secure links
>> - SPDM (Security Protocol and Data Model) over DOE (Data Object Exchange)
>> - IDE (Integrity Data Encryption) stream management for secure PCIe
>>
>> This module bridges the SEV firmware stack with the generic PCIe TSM
>> framework.
>>
>> This is phase1 as described in Documentation/driver-api/pci/tsm.rst.
>>
>> On AMD SEV, the AMD PSP firmware acts as TSM (manages the security/trust).
>> The CCP driver provides the interface to it and registers in the TSM
>> subsystem.
>>
>> Implement SEV TIO PSP command wrappers in sev-dev-tio.c and store
>> the data in the SEV-TIO-specific structs.
>>
>> Implement TSM hooks and IDE setup in sev-dev-tsm.c.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Hi Alexey,
> 
> Various minor comments inline.
> 
> Thanks,
> 
> Jonathan
> 
>> diff --git a/drivers/crypto/ccp/sev-dev-tio.h b/drivers/crypto/ccp/sev-dev-tio.h
>> new file mode 100644
>> index 000000000000..c72ac38d4351
>> --- /dev/null
>> +++ b/drivers/crypto/ccp/sev-dev-tio.h
> 
>> diff --git a/drivers/crypto/ccp/sev-dev-tio.c b/drivers/crypto/ccp/sev-dev-tio.c
>> new file mode 100644
>> index 000000000000..ca0db6e64839
>> --- /dev/null
>> +++ b/drivers/crypto/ccp/sev-dev-tio.c
> 
>> +static size_t sla_dobj_id_to_size(u8 id)
>> +{
>> +	size_t n;
>> +
>> +	BUILD_BUG_ON(sizeof(struct spdm_dobj_hdr_resp) != 0x10);
>> +	switch (id) {
>> +	case SPDM_DOBJ_ID_REQ:
>> +		n = sizeof(struct spdm_dobj_hdr_req);
>> +		break;
>> +	case SPDM_DOBJ_ID_RESP:
>> +		n = sizeof(struct spdm_dobj_hdr_resp);
>> +		break;
>> +	default:
>> +		WARN_ON(1);
>> +		n = 0;
>> +		break;
>> +	}
>> +
>> +	return n;
> 
> Maybe just returning above would be simpler and remove need for local variables
> etc.
> 
>> +}
>>
>> + * struct sev_data_tio_dev_connect - TIO_DEV_CONNECT
>> + *
>> + * @length: Length in bytes of this command buffer.
>> + * @spdm_ctrl: SPDM control structure defined in Section 5.1.
>> + * @device_id: The PCIe Routing Identifier of the device to connect to.
>> + * @root_port_id: The PCIe Routing Identifier of the root port of the device
> 
> A few of these aren't present in the structure so out of date docs I think
> 
>> + * @segment_id: The PCIe Segment Identifier of the device to connect to.
>> + * @dev_ctx_sla: Scatter list address of the device context buffer.
>> + * @tc_mask: Bitmask of the traffic classes to initialize for SEV-TIO usage.
>> + *           Setting the kth bit of the TC_MASK to 1 indicates that the traffic
>> + *           class k will be initialized.
>> + * @cert_slot: Slot number of the certificate requested for constructing the SPDM session.
>> + * @ide_stream_id: IDE stream IDs to be associated with this device.
>> + *                 Valid only if corresponding bit in TC_MASK is set.
>> + */
>> +struct sev_data_tio_dev_connect {
>> +	u32 length;
>> +	u32 reserved1;
>> +	struct spdm_ctrl spdm_ctrl;
>> +	u8 reserved2[8];
>> +	struct sla_addr_t dev_ctx_sla;
>> +	u8 tc_mask;
>> +	u8 cert_slot;
>> +	u8 reserved3[6];
>> +	u8 ide_stream_id[8];
>> +	u8 reserved4[8];
>> +} __packed;
>> +
>> +/**
>> + * struct sev_data_tio_dev_disconnect - TIO_DEV_DISCONNECT
>> + *
>> + * @length: Length in bytes of this command buffer.
>> + * @force: Force device disconnect without SPDM traffic.
>> + * @spdm_ctrl: SPDM control structure defined in Section 5.1.
>> + * @dev_ctx_sla: Scatter list address of the device context buffer.
>> + */
>> +struct sev_data_tio_dev_disconnect {
>> +	u32 length;
>> +	union {
>> +		u32 flags;
>> +		struct {
>> +			u32 force:1;
>> +		};
>> +	};
>> +	struct spdm_ctrl spdm_ctrl;
>> +	struct sla_addr_t dev_ctx_sla;
>> +} __packed;
>> +
>> +/**
>> + * struct sev_data_tio_dev_meas - TIO_DEV_MEASUREMENTS
>> + *
>> + * @length: Length in bytes of this command buffer
> 
> flags need documentation as well.
> Generally I'd avoid bitfields and rely on defines so we don't hit
> the weird stuff the c spec allows to be done with bitfields.
> 
>> + * @raw_bitstream: 0: Requests the digest form of the attestation report
>> + *                 1: Requests the raw bitstream form of the attestation report
>> + * @spdm_ctrl: SPDM control structure defined in Section 5.1.
>> + * @dev_ctx_sla: Scatter list address of the device context buffer.
>> + */
>> +struct sev_data_tio_dev_meas {
>> +	u32 length;
>> +	union {
>> +		u32 flags;
>> +		struct {
>> +			u32 raw_bitstream:1;
>> +		};
>> +	};
>> +	struct spdm_ctrl spdm_ctrl;
>> +	struct sla_addr_t dev_ctx_sla;
>> +	u8 meas_nonce[32];
>> +} __packed;
> 
>> +/**
>> + * struct sev_data_tio_dev_reclaim - TIO_DEV_RECLAIM command
>> + *
>> + * @length: Length in bytes of this command buffer
>> + * @dev_ctx_paddr: SPA of page donated by hypervisor
>> + */
>> +struct sev_data_tio_dev_reclaim {
>> +	u32 length;
>> +	u32 reserved;
> Why a u32 for this reserved, but u8[] arrays for some of thos in
> other structures like sev_data_tio_asid_fence_status.
> I'd aim for consistency on that. I don't really mind which option!
>> +	struct sla_addr_t dev_ctx_sla;
>> +} __packed;
>> +
>> +/**
>> + * struct sev_data_tio_asid_fence_clear - TIO_ASID_FENCE_CLEAR command
>> + *
>> + * @length: Length in bytes of this command buffer
>> + * @dev_ctx_paddr: Scatter list address of device context
>> + * @gctx_paddr: System physical address of guest context page
> 
> As below wrt to complete docs.
> 
>> + *
>> + * This command clears the ASID fence for a TDI.
>> + */
>> +struct sev_data_tio_asid_fence_clear {
>> +	u32 length;				/* In */
>> +	u32 reserved1;
>> +	struct sla_addr_t dev_ctx_paddr;	/* In */
>> +	u64 gctx_paddr;			/* In */
>> +	u8 reserved2[8];
>> +} __packed;
>> +
>> +/**
>> + * struct sev_data_tio_asid_fence_status - TIO_ASID_FENCE_STATUS command
>> + *
>> + * @length: Length in bytes of this command buffer
> Kernel-doc complains about undocument structure elements, so you probably have
> to add a trivial comment for the two reserved ones to keep it happy.
> 
>> + * @dev_ctx_paddr: Scatter list address of device context
>> + * @asid: Address Space Identifier to query
>> + * @status_pa: System physical address where fence status will be written
>> + *
>> + * This command queries the fence status for a specific ASID.
>> + */
>> +struct sev_data_tio_asid_fence_status {
>> +	u32 length;				/* In */
>> +	u8 reserved1[4];
>> +	struct sla_addr_t dev_ctx_paddr;	/* In */
>> +	u32 asid;				/* In */
>> +	u64 status_pa;
>> +	u8 reserved2[4];
>> +} __packed;
>> +
>> +static struct sla_buffer_hdr *sla_buffer_map(struct sla_addr_t sla)
>> +{
>> +	struct sla_buffer_hdr *buf;
>> +
>> +	BUILD_BUG_ON(sizeof(struct sla_buffer_hdr) != 0x40);
>> +	if (IS_SLA_NULL(sla))
>> +		return NULL;
>> +
>> +	if (sla.page_type == SLA_PAGE_TYPE_SCATTER) {
>> +		struct sla_addr_t *scatter = sla_to_va(sla);
>> +		unsigned int i, npages = 0;
>> +		struct page **pp;
>> +
>> +		for (i = 0; i < SLA_SCATTER_LEN(sla); ++i) {
>> +			if (WARN_ON_ONCE(SLA_SZ(scatter[i]) > SZ_4K))
>> +				return NULL;
>> +
>> +			if (WARN_ON_ONCE(scatter[i].page_type == SLA_PAGE_TYPE_SCATTER))
>> +				return NULL;
>> +
>> +			if (IS_SLA_EOL(scatter[i])) {
>> +				npages = i;
>> +				break;
>> +			}
>> +		}
>> +		if (WARN_ON_ONCE(!npages))
>> +			return NULL;
>> +
>> +		pp = kmalloc_array(npages, sizeof(pp[0]), GFP_KERNEL);
> 
> Could use a __free to avoid needing to manually clean this up.
> 
>> +		if (!pp)
>> +			return NULL;
>> +
>> +		for (i = 0; i < npages; ++i)
>> +			pp[i] = sla_to_page(scatter[i]);
>> +
>> +		buf = vm_map_ram(pp, npages, 0);
>> +		kfree(pp);
>> +	} else {
>> +		struct page *pg = sla_to_page(sla);
>> +
>> +		buf = vm_map_ram(&pg, 1, 0);
>> +	}
>> +
>> +	return buf;
>> +}
> 
>> +
>> +/* Expands a buffer, only firmware owned buffers allowed for now */
>> +static int sla_expand(struct sla_addr_t *sla, size_t *len)
>> +{
>> +	struct sla_buffer_hdr *oldbuf = sla_buffer_map(*sla), *newbuf;
>> +	struct sla_addr_t oldsla = *sla, newsla;
>> +	size_t oldlen = *len, newlen;
>> +
>> +	if (!oldbuf)
>> +		return -EFAULT;
>> +
>> +	newlen = oldbuf->capacity_sz;
>> +	if (oldbuf->capacity_sz == oldlen) {
>> +		/* This buffer does not require expansion, must be another buffer */
>> +		sla_buffer_unmap(oldsla, oldbuf);
>> +		return 1;
>> +	}
>> +
>> +	pr_notice("Expanding BUFFER from %ld to %ld bytes\n", oldlen, newlen);
>> +
>> +	newsla = sla_alloc(newlen, true);
>> +	if (IS_SLA_NULL(newsla))
>> +		return -ENOMEM;
>> +
>> +	newbuf = sla_buffer_map(newsla);
>> +	if (!newbuf) {
>> +		sla_free(newsla, newlen, true);
>> +		return -EFAULT;
>> +	}
>> +
>> +	memcpy(newbuf, oldbuf, oldlen);
>> +
>> +	sla_buffer_unmap(newsla, newbuf);
>> +	sla_free(oldsla, oldlen, true);
>> +	*sla = newsla;
>> +	*len = newlen;
>> +
>> +	return 0;
>> +}
>> +
>> +static int sev_tio_do_cmd(int cmd, void *data, size_t data_len, int *psp_ret,
>> +			  struct tsm_dsm_tio *dev_data, struct tsm_spdm *spdm)
>> +{
>> +	int rc;
>> +
>> +	*psp_ret = 0;
>> +	rc = sev_do_cmd(cmd, data, psp_ret);
>> +
>> +	if (WARN_ON(!spdm && !rc && *psp_ret == SEV_RET_SPDM_REQUEST))
>> +		return -EIO;
>> +
>> +	if (rc == 0 && *psp_ret == SEV_RET_EXPAND_BUFFER_LENGTH_REQUEST) {
>> +		int rc1, rc2;
>> +
>> +		rc1 = sla_expand(&dev_data->output, &dev_data->output_len);
>> +		if (rc1 < 0)
>> +			return rc1;
>> +
>> +		rc2 = sla_expand(&dev_data->scratch, &dev_data->scratch_len);
>> +		if (rc2 < 0)
>> +			return rc2;
>> +
>> +		if (!rc1 && !rc2)
>> +			/* Neither buffer requires expansion, this is wrong */
> 
> Is this check correct?  I think you return 1 on no need to expand.
> 
>> +			return -EFAULT;
>> +
>> +		*psp_ret = 0;
>> +		rc = sev_do_cmd(cmd, data, psp_ret);
>> +	}
>> +
>> +	if (spdm && (rc == 0 || rc == -EIO) && *psp_ret == SEV_RET_SPDM_REQUEST) {
>> +		struct spdm_dobj_hdr_resp *resp_hdr;
>> +		struct spdm_dobj_hdr_req *req_hdr;
>> +		struct sev_tio_status *tio_status = to_tio_status(dev_data);
>> +		size_t resp_len = tio_status->spdm_req_size_max -
>> +			(sla_dobj_id_to_size(SPDM_DOBJ_ID_RESP) + sizeof(struct sla_buffer_hdr));
>> +
>> +		if (!dev_data->cmd) {
>> +			if (WARN_ON_ONCE(!data_len || (data_len != *(u32 *) data)))
>> +				return -EINVAL;
>> +			if (WARN_ON(data_len > sizeof(dev_data->cmd_data)))
>> +				return -EFAULT;
>> +			memcpy(dev_data->cmd_data, data, data_len);
>> +			memset(&dev_data->cmd_data[data_len], 0xFF,
>> +			       sizeof(dev_data->cmd_data) - data_len);
>> +			dev_data->cmd = cmd;
>> +		}
>> +
>> +		req_hdr = sla_to_dobj_req_hdr(dev_data->reqbuf);
>> +		resp_hdr = sla_to_dobj_resp_hdr(dev_data->respbuf);
>> +		switch (req_hdr->data_type) {
>> +		case DOBJ_DATA_TYPE_SPDM:
>> +			rc = TSM_PROTO_CMA_SPDM;
>> +			break;
>> +		case DOBJ_DATA_TYPE_SECURE_SPDM:
>> +			rc = TSM_PROTO_SECURED_CMA_SPDM;
>> +			break;
>> +		default:
>> +			rc = -EINVAL;
>> +			return rc;
> 
> 			return -EINVAL;
> 
>> +		}
>> +		resp_hdr->data_type = req_hdr->data_type;
>> +		spdm->req_len = req_hdr->hdr.length - sla_dobj_id_to_size(SPDM_DOBJ_ID_REQ);
>> +		spdm->rsp_len = resp_len;
>> +	} else if (dev_data && dev_data->cmd) {
>> +		/* For either error or success just stop the bouncing */
>> +		memset(dev_data->cmd_data, 0, sizeof(dev_data->cmd_data));
>> +		dev_data->cmd = 0;
>> +	}
>> +
>> +	return rc;
>> +}
>> +
> 
>> +static int spdm_ctrl_init(struct tsm_spdm *spdm, struct spdm_ctrl *ctrl,
>> +			  struct tsm_dsm_tio *dev_data)
> 
> This seems like a slightly odd function as it is initializing two different
> things.  To me I'd read this as only initializing the spdm_ctrl structure.
> Perhaps split, or rename?
> 
>> +{
>> +	ctrl->req = dev_data->req;
>> +	ctrl->resp = dev_data->resp;
>> +	ctrl->scratch = dev_data->scratch;
>> +	ctrl->output = dev_data->output;
>> +
>> +	spdm->req = sla_to_data(dev_data->reqbuf, SPDM_DOBJ_ID_REQ);
>> +	spdm->rsp = sla_to_data(dev_data->respbuf, SPDM_DOBJ_ID_RESP);
>> +	if (!spdm->req || !spdm->rsp)
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
> 
>> +
>> +int sev_tio_init_locked(void *tio_status_page)
>> +{
>> +	struct sev_tio_status *tio_status = tio_status_page;
>> +	struct sev_data_tio_status data_status = {
>> +		.length = sizeof(data_status),
>> +	};
>> +	int ret = 0, psp_ret = 0;
> 
> ret always set before use so don't initialize.
> 
>> +
>> +	data_status.status_paddr = __psp_pa(tio_status_page);
>> +	ret = __sev_do_cmd_locked(SEV_CMD_TIO_STATUS, &data_status, &psp_ret);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (tio_status->length < offsetofend(struct sev_tio_status, tdictx_size) ||
>> +	    tio_status->flags & 0xFFFFFF00)
>> +		return -EFAULT;
>> +
>> +	if (!tio_status->tio_en && !tio_status->tio_init_done)
>> +		return -ENOENT;
>> +
>> +	if (tio_status->tio_init_done)
>> +		return -EBUSY;
>> +
>> +	struct sev_data_tio_init ti = { .length = sizeof(ti) };
>> +
>> +	ret = __sev_do_cmd_locked(SEV_CMD_TIO_INIT, &ti, &psp_ret);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = __sev_do_cmd_locked(SEV_CMD_TIO_STATUS, &data_status, &psp_ret);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
> 	return __sev_do_cmd_locked() perhaps.
> 
>> +}
>> +
>> +int sev_tio_dev_create(struct tsm_dsm_tio *dev_data, u16 device_id,
>> +		       u16 root_port_id, u8 segment_id)
>> +{
>> +	struct sev_tio_status *tio_status = to_tio_status(dev_data);
>> +	struct sev_data_tio_dev_create create = {
>> +		.length = sizeof(create),
>> +		.device_id = device_id,
>> +		.root_port_id = root_port_id,
>> +		.segment_id = segment_id,
>> +	};
>> +	void *data_pg;
>> +	int ret;
>> +
>> +	dev_data->dev_ctx = sla_alloc(tio_status->devctx_size, true);
>> +	if (IS_SLA_NULL(dev_data->dev_ctx))
>> +		return -ENOMEM;
>> +
>> +	data_pg = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
>> +	if (!data_pg) {
>> +		ret = -ENOMEM;
>> +		goto free_ctx_exit;
>> +	}
>> +
>> +	create.dev_ctx_sla = dev_data->dev_ctx;
>> +	ret = sev_tio_do_cmd(SEV_CMD_TIO_DEV_CREATE, &create, sizeof(create),
>> +			     &dev_data->psp_ret, dev_data, NULL);
>> +	if (ret)
>> +		goto free_data_pg_exit;
>> +
>> +	dev_data->data_pg = data_pg;
>> +
>> +	return ret;
> 
> return 0;  Might as well make it clear this is always a good path.
> 
>> +
>> +free_data_pg_exit:
>> +	snp_free_firmware_page(data_pg);
>> +free_ctx_exit:
>> +	sla_free(create.dev_ctx_sla, tio_status->devctx_size, true);
>> +	return ret;
>> +}
> 
>> +
>> +int sev_tio_dev_connect(struct tsm_dsm_tio *dev_data, u8 tc_mask, u8 ids[8], u8 cert_slot,
>> +			struct tsm_spdm *spdm)
>> +{
>> +	struct sev_data_tio_dev_connect connect = {
>> +		.length = sizeof(connect),
>> +		.tc_mask = tc_mask,
>> +		.cert_slot = cert_slot,
>> +		.dev_ctx_sla = dev_data->dev_ctx,
>> +		.ide_stream_id = {
>> +			ids[0], ids[1], ids[2], ids[3],
>> +			ids[4], ids[5], ids[6], ids[7]
>> +		},
>> +	};
>> +	int ret;
>> +
>> +	if (WARN_ON(IS_SLA_NULL(dev_data->dev_ctx)))
>> +		return -EFAULT;
>> +	if (!(tc_mask & 1))
>> +		return -EINVAL;
>> +
>> +	ret = spdm_ctrl_alloc(dev_data, spdm);
>> +	if (ret)
>> +		return ret;
>> +	ret = spdm_ctrl_init(spdm, &connect.spdm_ctrl, dev_data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = sev_tio_do_cmd(SEV_CMD_TIO_DEV_CONNECT, &connect, sizeof(connect),
>> +			     &dev_data->psp_ret, dev_data, spdm);
>> +
>> +	return ret;
> 
> return sev_tio_do_cmd...
> 
>> +}
>> +
>> +int sev_tio_dev_disconnect(struct tsm_dsm_tio *dev_data, struct tsm_spdm *spdm, bool force)
>> +{
>> +	struct sev_data_tio_dev_disconnect dc = {
>> +		.length = sizeof(dc),
>> +		.dev_ctx_sla = dev_data->dev_ctx,
>> +		.force = force,
>> +	};
>> +	int ret;
>> +
>> +	if (WARN_ON_ONCE(IS_SLA_NULL(dev_data->dev_ctx)))
>> +		return -EFAULT;
>> +
>> +	ret = sspdm_ctrl_initpdm_ctrl_init(spdm, &dc.spdm_ctrl, dev_data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = sev_tio_do_cmd(SEV_CMD_TIO_DEV_DISCONNECT, &dc, sizeof(dc),
>> +			     &dev_data->psp_ret, dev_data, spdm);
>> +
>> +	return ret;
> 
> return sev_tio..
> 
>> +}
>> +
>> +int sev_tio_asid_fence_clear(struct sla_addr_t dev_ctx, u64 gctx_paddr, int *psp_ret)
>> +{
>> +	struct sev_data_tio_asid_fence_clear c = {
>> +		.length = sizeof(c),
>> +		.dev_ctx_paddr = dev_ctx,
>> +		.gctx_paddr = gctx_paddr,
>> +	};
>> +
>> +	return sev_do_cmd(SEV_CMD_TIO_ASID_FENCE_CLEAR, &c, psp_ret);
>> +}
>> +
>> +int sev_tio_asid_fence_status(struct tsm_dsm_tio *dev_data, u16 device_id, u8 segment_id,
>> +			      u32 asid, bool *fenced)
> The meaning of return codes in these functions is a mix of errno and SEV specific.
> Perhaps some documentation to make that clear, or even a typedef for the SEV ones?
>> +{
>> +	u64 *status = prep_data_pg(u64, dev_data);
>> +	struct sev_data_tio_asid_fence_status s = {
>> +		.length = sizeof(s),
>> +		.dev_ctx_paddr = dev_data->dev_ctx,
>> +		.asid = asid,
>> +		.status_pa = __psp_pa(status),
>> +	};
>> +	int ret;
>> +
>> +	ret = sev_do_cmd(SEV_CMD_TIO_ASID_FENCE_STATUS, &s, &dev_data->psp_ret);
>> +
>> +	if (ret == SEV_RET_SUCCESS) {
> 
> I guess this gets more complex in future series to mean that checking
> the opposite isn't the way to go?
> 	if (ret != SEV_RET_SUCCESS)
> 		return ret;
> 
> If not I'd do that to reduce indent and have a nice quick exit
> for errors.
> 
>> +		u8 dma_status = *status & 0x3;
>> +		u8 mmio_status = (*status >> 2) & 0x3;
>> +
>> +		switch (dma_status) {
>> +		case 0:
> These feel like magic numbers that could perhaps have defines to give
> them pretty names?
>> +			*fenced = false;
>> +			break;
>> +		case 1:
>> +		case 3:
>> +			*fenced = true;
>> +			break;
>> +		default:
>> +			pr_err("%04x:%x:%x.%d: undefined DMA fence state %#llx\n",
>> +			       segment_id, PCI_BUS_NUM(device_id),
>> +			       PCI_SLOT(device_id), PCI_FUNC(device_id), *status);
>> +			*fenced = true;
>> +			break;
>> +		}
>> +
>> +		switch (mmio_status) {
>> +		case 0:
> Same as above, names might be nice.
>> +			*fenced = false;
>> +			break;
>> +		case 3:
>> +			*fenced = true;
>> +			break;
>> +		default:
>> +			pr_err("%04x:%x:%x.%d: undefined MMIO fence state %#llx\n",
>> +			       segment_id, PCI_BUS_NUM(device_id),
>> +			       PCI_SLOT(device_id), PCI_FUNC(device_id), *status);
>> +			*fenced = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
> 
>> diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
>> new file mode 100644
>> index 000000000000..4702139185a2
>> --- /dev/null
>> +++ b/drivers/crypto/ccp/sev-dev-tsm.c
> 
>> +
>> +static uint nr_ide_streams = TIO_DEFAULT_NR_IDE_STREAMS;
>> +module_param_named(ide_nr, nr_ide_streams, uint, 0644);
>> +MODULE_PARM_DESC(ide_nr, "Set the maximum number of IDE streams per PHB");
>> +
>> +#define dev_to_sp(dev)		((struct sp_device *)dev_get_drvdata(dev))
>> +#define dev_to_psp(dev)		((struct psp_device *)(dev_to_sp(dev)->psp_data))
>> +#define dev_to_sev(dev)		((struct sev_device *)(dev_to_psp(dev)->sev_data))
>> +#define tsm_dev_to_sev(tsmdev)	dev_to_sev((tsmdev)->dev.parent)
>> +#define tsm_pf0_to_sev(t)	tsm_dev_to_sev((t)->base.owner)
>> +
>> +/*to_pci_tsm_pf0((pdev)->tsm)*/
> 
> Left over of something?

Actually not, to_pci_tsm_pf0() is a static helper in drivers/pci/tsm.c and pdev_to_tsm_pf0() (below) is the same thing defined for drivers/crypto/ccp/sev-dev-tsm.c and I wonder if to_pci_tsm_pf0() is better be exported. pdev_to_tsm_pf0() does not need all the checks as if we are that far past the initial setup, we can skip on some checks which to_pci_tsm_pf0() performs so I have not exported to_pci_tsm_pf0() but left the comment. Thanks,

> 
>> +#define pdev_to_tsm_pf0(pdev)	(((pdev)->tsm && (pdev)->tsm->dsm_dev) ? \
>> +				((struct pci_tsm_pf0 *)((pdev)->tsm->dsm_dev->tsm)) : \
>> +				NULL)
>> +

-- 
Alexey


