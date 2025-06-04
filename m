Return-Path: <linux-pci+bounces-28928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A9FACD4EB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 03:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF3E1641EC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 01:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FFF1C32;
	Wed,  4 Jun 2025 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x6VlNViB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B943C0C
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000918; cv=fail; b=S6ZDf6OX7pEB13rPrHyHeuYuPF59up/8VM+rVqr1Ae1J5WMj9Nbgq90YRg331KkAZFTSE44feYvIi9ApoPUdj/xwo0zB85/2Tibu6pzURlgAadJuOjp33aIsqdwXZsoxf5JzEalQBMySoJPfaGCXtWfEVYBAejldzx5sJjxP/lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000918; c=relaxed/simple;
	bh=J/w+jdgr4V/ld2gg4RopkO5B9o/IUV4Z6e8Wev/h6BM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kMaj6doBdRq4RdW2iJs++Fge4V7S3pIzaI339a+yRyLKVLuWjj/xwYd+7aWmK5S0tjCZJ9tPt7vZqFHJDMZPsPN0AFIbGmnIFRkvTeSxq4xvvdi9q/TMQQuwnlf03jrTB3hxzVkeDSlBifWA2Lz/NQ/BGj3f8XJ011NmmRBKUX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x6VlNViB; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+j6HoV4rk0K3Dnlk8d+KOAXeBoduHyYuaE2vDtqTTHJ+CzdMtLN00phOiuhXPhpSIwQY1c0LyjU38gpIlFVXsuTl5zLizCTBhIudV2KIDUw1xqxt/ekkdPiDnZ2RO27aOxfbA4AYyiLnpSlNTnG5btRkFda+f7OquVtUWBG/q77e1FCas4/bV0LOFa4B4wOfwE7JXS0ytJeqOfH9cOi9HK/2xBIbh0BsA+dCLv4Wc6cjOYD3BVafkbMgXHcA6JWvxMGoJa1SlXQqCMFjnxAsHiB1AY/qhj4rI+Q+Xl8A95vd63hpgNTtPNTOfjnecVJitezzAOVz/G4d23q4Rq4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLYOv7YdwLds4cQxnZuHh369TuhSL499Dnq0w5ItgUI=;
 b=pb0mxAUGTlJfWnt+Kpv6bUf0qVLBq5ewqdyT6GVM94dixSsjKy7PrcVf7VvU7CjINubtNOgRoGbw9LHJY7dkd8P0LQml1HuwEaJhBFLzqmPUkm7RgZJIop15NsWK+aW6rrc8mDc9PwirGnQmJcg74BDDcm1bavyRwL/d9EumCIumS7HrKNENW/gbyJvrRl2EGnbgNgrJ3uckbQ8ipntVpW6OFvfRD8J/NhgRd4pxSouyrXiST2VcXwszrc1sZGEOAn3ptsnsp33CqxdkWQT1a9hZ5tEU6TfQalpTlwZpaWJICsv79NLfPosgK0xkxA2XpfjJIgon1ypKm3YQYxRDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLYOv7YdwLds4cQxnZuHh369TuhSL499Dnq0w5ItgUI=;
 b=x6VlNViBLt8yYO1QjbAXkVFbmKwYGb/Za64ORI//d5qQ1LDCAKnk06wCZHl2Dd7+USIHutT0LJMUGmafBOPI8PYeedtk/a5QHV9HHskFJ1XiY8h311sWkTDYjuRDS82V2sUhbzlfEn3qu/RmM2K559Z6GsbdYpsxwrsUJrtD5bQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Wed, 4 Jun
 2025 01:35:14 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 01:35:12 +0000
Message-ID: <53c7523b-5cf3-4047-831f-12e0422cdf5d@amd.com>
Date: Wed, 4 Jun 2025 11:35:05 +1000
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
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050> <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050> <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com> <yq5ah617s7fs.fsf@kernel.org>
 <5d8483bb-ceb7-4ef3-920c-d6286a7de85d@arm.com>
 <683f7b6fec30f_1626e100ab@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <683f7b6fec30f_1626e100ab@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0091.ausprd01.prod.outlook.com
 (2603:10c6:10:111::6) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 909442f7-b5c9-4551-e066-08dda3080c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXh4UHFVYWs1V3ZrQ2NKckh6dVg0bU9ZQ2E4d1hPaWREbzlpMUFrVERJNHh4?=
 =?utf-8?B?WHFJbmxKSUJpaVRGNFQ1bGMxNkdvQzdOY2JrRC9zVnZQbEhqeUdPR1dVU1dr?=
 =?utf-8?B?UUlsc0l1ZzRzTFlPaC9qcDNSd0FVc1UvZFE1K240N2xHR0tYd1k4Mm5lZ3Rm?=
 =?utf-8?B?ZmJ1T2MvTXBwMU9CM3QxSHEzVkJSWjk1UjJyR0pBT1Q5aUhoU205Uy85eXk2?=
 =?utf-8?B?VmxxRVUzaUhNZEFTZ1k1RE5oc1MyeU9mdERHdXFhS2pXNkdYdGRoajd1aTVD?=
 =?utf-8?B?VHdadnJ6dG1zRTJweWFMVUpaM2JTQ215b0RCUlhQOUJ6Z1F0K25maWExNWRk?=
 =?utf-8?B?UEswWThkeFlCYlR4c3dsSU9ScG0zVzkyaThKQmdVKzRlc1g0alBSbUdNb2xo?=
 =?utf-8?B?SW9NZEpNZWE0MWFUbm1VSzhodHkrZklKaEZkV1l5WTdCWVBoSGdNUTFoYnRp?=
 =?utf-8?B?cE1xdDNGNVkxZFJyN3V4MmtCNzFpZ1RibnZhQjVNNFp2R2p6VWt1L1FKenhy?=
 =?utf-8?B?cFBJUGdOOUd2NEdkalZoZS90bTZjcksxc0NhcDdVREJIb3MxL2oyd3kzNURB?=
 =?utf-8?B?ckpPUXliTHA1Y1dXWE9ORi8va3hZaDdUYnF4WDRjcE44NW5YZzZuWWhIVzNN?=
 =?utf-8?B?Njl6RFI5TDJMcnlZeUExYUlaQzM4Ri9XSmVKang5NnRkNStRWG1OOVBRM1Qx?=
 =?utf-8?B?U0ZaeTUyaU9pVWs1NTFxWnhyejJRNG1DQkY4V3lWUGlUakN0NGhtZG5lZWhV?=
 =?utf-8?B?aE10ZXlOSEUwM0llMGNGek1rRTV0Wm1iMXpxOTVKY1FRVkluOFpldjdLQjdl?=
 =?utf-8?B?L3M4MndPTk0xbVZ2NjdxQjdPb0RjdERjWFFuSUFMR3ZpQ1c2TXZXTUNoWjlR?=
 =?utf-8?B?S3FWRG5jblpXNndxZzhsVllZTFFRSHh5NGxDNkhkWi9UU2tNalBhVzZUTlF4?=
 =?utf-8?B?NVZJSXQ0VVJ4amg2ZUhRZGpWNkNkcmJoZEphN016NitkMTQwckJSODZNUVVh?=
 =?utf-8?B?dXhRL1lrQ1VRT1hlamFsWWpsK212REJOalY2SUljRDF2dktXVCtyT0xsMGlh?=
 =?utf-8?B?Zm81TTNncmI2bFVXTlkwM1JpcjhSbTk4dFlGVkgrZFFFT2pDbXNNY0VHRXJQ?=
 =?utf-8?B?dXd2dEN2anFUT1o4M0pNZ1g1aEp2cThybjZibFF1dlNGMmZRdHVSZWtHbU5m?=
 =?utf-8?B?QzU5TkhSejBjMzZ4WExxSjlManF0d0k5aGk0UHJlSWkvTXVwMUF4QnlFdmd6?=
 =?utf-8?B?Q0xTajhpU0VNcVFDWTROcjNmV0VBS2xDZkxmbEdSUERvcGhKM1hOTFhwSEsy?=
 =?utf-8?B?Q0RrSVFwYzk4QTRteGRMWTBNT01SMHNucGtMay9kcDQxNDVDYXlFdmpCZ1Nh?=
 =?utf-8?B?YTV3VXliamsreGZmOHd6TFFvTG0xem9lUjQ3eE5uTnQ3eXc2RWxsa2FKOVZu?=
 =?utf-8?B?clZtSUNVRHZNYWxKOGR4elpET1F2UGFHKzhVMFRoemdySm5iMFd3RmV3dS9U?=
 =?utf-8?B?bWI4SE5ObnZqTW9Na3hFdld5Q0pYVHcvek9od3lLcWtiRkxsakp3ajdWbENT?=
 =?utf-8?B?eE43aElDOCs1OGNZeXljcWMvSXNaQy9mbnArcnZ5VVpJWTZqNTVJOUVTd2Nt?=
 =?utf-8?B?MVBBZy9aVk5UckpzL1N4MGVxN1JTS1JXZldPOFBRNndjL3lDSEdHYWR4ajFW?=
 =?utf-8?B?bk5hTGs5blFVMlJDSUpmZ1RmcWtYdGluclhpVUpJNzZpZmREYmpNTm5wL3c0?=
 =?utf-8?B?b3NwUWRpeHpJWGQ1MFRiZm5qbEp5Y2wwMCthb3I3OGNlb243aE0rRXZ2RlVG?=
 =?utf-8?B?YUFQemVIU3dtN3lqOVJhRzRxcUZpZUNreTdhUFNMYmFteXZPMTlXUEFNbEZm?=
 =?utf-8?B?ZVI1SDdjNkpvYkFYWVhtYlRnbEhEYnZnRTFoRTdNNzVzWk1oOWk1QXhVTmlJ?=
 =?utf-8?Q?WVVuxoQcPug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0xKM1Zsb2FKWmlYbDJtUDdWRTVxUkJRTXRCdnl0c3NxY2dWcW5VQU5hRGRU?=
 =?utf-8?B?Zi9aYVltVW5NSTdhdkhtcDdWYWtFQWtZeWwydUR2SmhDRTRGR0NsM0xYVith?=
 =?utf-8?B?Rm9CN1ludms4dnRoNDB4WVBpdzBnV0ZUbk43Zmp3U01KUjdYdC84YzU0YkNC?=
 =?utf-8?B?MGlMdHpLOENjaEZlYS9YUS9ZTEJRR3M4dktRODFxZko0QUp6dG15cDMySFgr?=
 =?utf-8?B?UEVSeDJWb0FPd2taenljYVZIUjZCSmQvbXJJRGUvM1dTNk5WQUdDSWFMZHc5?=
 =?utf-8?B?MmF3bHJybXB0eGc3WUdIT0VURjhrUmkxVldBcHhhNkJTNDM0amNGY0laMTFC?=
 =?utf-8?B?N0tEcGJQWTJ1V01TbWJHUU0ycmVKRVArRmM2MUhsckdoUW03V1prRkJaRFJv?=
 =?utf-8?B?YzcvdlRob0FPOXRhcFJRaGRWakNMVDNJRERaRDdnVWtqZzNPTDRtQjgzaEhm?=
 =?utf-8?B?bVNtOVJpWWRDZm9iTFpuWmhkdTdHdDR2VWZpeENxdkY2WlgvaENreEFsMWJB?=
 =?utf-8?B?T1hodW5kVUZ2Umo2TkZJQm9kSlk5NFIwMER5RzVCRkMxQ3BjMDZscXhQcXQz?=
 =?utf-8?B?K0s2VWlPOVgxU21DQzlQOU91UWVaUjUxbE4vZGNIa0pwa0REUGNFMXFoRE1v?=
 =?utf-8?B?bm5rTFdzYVA1WUpFckpqck9EQS94Q2RqMjlVUWcxYVpVd1JmdDJhYVpRdi9l?=
 =?utf-8?B?ZXFWR2h4aVhjKzZEQWtta3VOTThaaTdQbjJLbE1YOFd2eXdUMUtPWHlGa280?=
 =?utf-8?B?TWtKR0sydlNmdUZHTi94aUkwbElqUmZRV1pBSGU3VFVYQW1PSnRPNFBxQllN?=
 =?utf-8?B?ODlDYVMrQURrV1ByeUhQZHMxOHE2di8xZExyWFZVaWRoLzhIUVdGcm43QVdn?=
 =?utf-8?B?SmlOVlNtVk1YY1dFVVBIRHdVUTdPREJHRHZXMm4xV1pSSEljS25pWUhiQ1dV?=
 =?utf-8?B?ajVSQ3hJOE5uYWY5dEtSTUNqamtWY3hZWFIrUjdiL0o2UTRMeHhWQnVQNmRs?=
 =?utf-8?B?Ti9XUktsQ1ZTRHcvb20xb0syLzNPQVEvQmxuQW8zbmpITlNGaDRTdjdyNjhW?=
 =?utf-8?B?eUtiQkVMT2Y5SFgyZXFNRlJpU3o0TE01ZUpOUm5tdStIaXBpUUVibngyMDFk?=
 =?utf-8?B?bHRuUmpPbjdIdlBvZ2VDckExWm1oL0VCajNyOGlacThPMmc2VHFYdXphZk5p?=
 =?utf-8?B?cmJtZzI2eG9LWUpGMHpaRW9LajI3Wk1NOXYyV2FFbUdYSUVJcDdabExJL3BP?=
 =?utf-8?B?QUQzS3JmdnNIVDlWRW9LZ1R1ckZNUk82c0VSdFJQV0J5ZGhjQ2RCV3plVU44?=
 =?utf-8?B?MTZacWpnQXZVNUNGSmUxKzBBcG9EeWJKVGNkeHdvRXVGcWJpWlJYZTBTdkxu?=
 =?utf-8?B?dldWZ2hWejlLcU9ONHI3aUNudGtYSnJJd1pmUDMwaUVDTW5Sc2w2WXVCYmhZ?=
 =?utf-8?B?UThIelJwQXhRQWttazc2d3phOFFLZUxSWCs2ekZHMjZPUUhlaUZOL0JxTzRP?=
 =?utf-8?B?S1B2WFJwRVJXSDF6VktWM1lTazNncEYxYXJBcWV4c3pZS1JnazhydW4xTm9j?=
 =?utf-8?B?QWxzZmYvQWN0Q1dkNk5ta2RiODB5cXhnZEpuL1hUVEJKZXpyN28zcndhODRn?=
 =?utf-8?B?QTVZUVF1d2JrR1JOaWdyY2NSNTh2K3ZyS3ZtSzhXUFNud3ZaZWIydWMvN1Fz?=
 =?utf-8?B?TDdYdERDelVSbWxGV2VLdERselRrRVNidDM5WXpsZWd6OFJJc1NwYzBvS2RY?=
 =?utf-8?B?TWpWdGduNlc4RlZzSU9jcE53SVAvV3lVd3FvS1htZFc5NVg0TjhDTUhudlZD?=
 =?utf-8?B?VjVkcGFscGkxMTFIekdVZzFVVk5McytObGo0cWZBZXdrUGx2YVNKOXlmMTR6?=
 =?utf-8?B?THREemtFUmg2K1dFUG5hOUdnQUV0WDE1Y2U3bkQ3TlVzRU9HUGNWYTlqdkZy?=
 =?utf-8?B?bFQ5bTlGUjBLSXZ5c1RtR2pWVVhVTVJ4TkU3WW5UK0piaXdkTWhTZTdjQng4?=
 =?utf-8?B?K1B1Tm1IM1I4RmJRdmtWSW1lU0RZYVhZeU9xbXJXbmoxenE3NEw4TTZvRys2?=
 =?utf-8?B?MFl4NW5PR0o0UER0clB0NWJTdXdQMCtrcndEemdXMWx0NmFBNUF5U21sNjhn?=
 =?utf-8?Q?OPqMUO0wcgCQ6qvETuycxpOzV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909442f7-b5c9-4551-e066-08dda3080c46
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 01:35:12.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuAGe162Z5PI3Pkufhz7svmUwWWmLL+vYVnH962qNEl/oAvBgvLX4HCKqTxv4GJ4QAF9FXGYB+M2jSd8PRA1Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103



On 4/6/25 08:47, Dan Williams wrote:
> Suzuki K Poulose wrote:
> [..]
>>> Ok, something like this? and iommufd will call tsm_bind()?
>>
>> Remember that there may be other devices, AMBA CHI based devices
>> being assigned. Not sure if they pretend to be PCI or not.
> 
> I have been thinking about this especially with the relative ease of
> creating samples/devsec/ given the existing Linux infrastructure
> emulating PCI host bridges.
> 
> Why not require PCI emulation for non-PCI devices? The tipping point is
> whether the relative maintenance burden of not needing to maintain
> multi-bus Device Security infrastructure outweighs the complexity of
> impedance matching those other buses to PCI.
> 
> Make "PCI" the lingua franca of Device Security.

This is how virtio started, and now it has to behave like a proper PCI device, i.e. use DMA API. Or ivshmem which maps memory as "PCI" (which it is not PCI but the guest does not know it) and is deprecated now. Not the best idea to enforce PCI from day1 imho.


-- 
Alexey


