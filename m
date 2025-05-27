Return-Path: <linux-pci+bounces-28435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00230AC45CC
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 03:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56713AE215
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF47BA2E;
	Tue, 27 May 2025 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="elUjde60"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5018136E
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748307687; cv=fail; b=HD6wJr5fW+HZGqb1fEjtcFNv/GSJaJAf+4zk2lk8EyI+OeXWsLjCWeMMwxqD2qgfHq1TQK83RcSZwHGoJMi7gv7U6d8+d0AEjbS2nRAMZ4zjei/5+qc1+ezzkRKjuAqMIAiOXOaY2urVBsiDQBKipSoIizcUOHCiWDSAZ3wES/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748307687; c=relaxed/simple;
	bh=/r5js7Rx4dSi0phtF4/ajIff895pdRYCakCuDZx3TY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HxWG0camT1bDRNkiXhvoD4zJS9nKU1WV7SLS/jyjJUz1nZah76qfywdezquQFjbFjV8E/TY8jOmcVO9WyBmeqeWRvBdl7wYPzTYw27vhMdNKAOiMvLERhaJHaVHAFD1xfMh7hyp65APxJ30O7HHhzHnU+4CEihMUT7BK30zbN5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=elUjde60; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUlwRoaMsaCVwrvMHc02aFjPodGFfkTP71bdhqfDT1augQv4W76+Ag5w4UY7m61vL9h7wgghuJG72bEbHXeNbe3W5G5FVqwvBlGmmMquVNbIETCSRpp2+NDFzMTf7tAKaghekep5mnLIphd3HbBWY8Ds8TOb/SsE16/MOzE+NlQxjwqtbrigkfjFS2i79Fo66zNOo3/Mv9VpbQ/ZsWzsEHb233CzdOoAEIVyuEvrql/j/PACOFxH2MpPEvJNTPL4h9LYhO8woXl7J9VIukgK2GwmajhbuxHFHhMhB6fLLLhELSL3FWITN8RO8w8Uz6Cn10nwR9v8Ao/mUgOQSoTIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4dsW2vY4bJqF30PoM7V4Jje0xOAK7z47ITI200anrM=;
 b=WV1ZZxmeC+zadtXu/JRTmuUZlgKAGSAqKrGCc4f5b8RHWEeV5Lhn9MFhye5dG4uhVCzvVH8Neinbax5UwFSXK7PmwmYm9ko9KqE0hlQFRbZPp/VoSYi+lI+hjd4CI5a3wHuEmPNhh6bqG82wEn0KOpIcZ7EHmQ/WOcUpUrMaYz0wJkoUecb+V2kzMWnicq/lCNfweF+iA1PR+UJ8dauhvn7+PoRS/tP59tgrYfORV/jHq1HUQHfx1rMD4Sjm0mtOcFbnC4bGrQB1xRLKn/ePEq+4GOTBUr/A9TGZZOXUIUbr4aBD4ZGb7hV2BxScFnHSFamkuihHrRYx1gT1xOeecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4dsW2vY4bJqF30PoM7V4Jje0xOAK7z47ITI200anrM=;
 b=elUjde60Naa1K9cY8jQeECS8Bk86cBTdgwmky8uFzq2fk5Pi/m6es6sWkxMhnvWyrR9X9ecNWK1FfYDOYaCnjw+aW1DLIsmmpO62vOTMXloK8xFMn8HE5XXxnPO3ntP8aG5UhRMucPMEpCnvUA7QRq1kVpzUaP5eTRYej4qmoCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA0PPF864563BFB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Tue, 27 May
 2025 01:01:20 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 01:01:19 +0000
Message-ID: <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
Date: Tue, 27 May 2025 11:01:07 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050> <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050> <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com> <yq5ah617s7fs.fsf@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <yq5ah617s7fs.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP6P284CA0047.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:1ab::6) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA0PPF864563BFB:EE_
X-MS-Office365-Filtering-Correlation-Id: e76796db-701c-481d-23c7-08dd9cb9fd6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTZIaDY3SFNHRCsxM05JUlFJd2dmeXczdERQMHVubkQwbmJYL1dFNU9QU1hn?=
 =?utf-8?B?RWtEYWJuUDRZWS8yVkFKbGJCZFZTQTd1b053MEl5cmhuSStZYnovSkNPOXU3?=
 =?utf-8?B?bWtGbVI1Ukl5eHRSRGpnVUI5S1pVa1NUNEJFcTlicm9YUWlobUdWbVRqR2l0?=
 =?utf-8?B?RE5WbG91Wks5NFpUWVJuamxsZW05MnQxcW43bksrSUw2ZGlXaHZ5aGcrV0lt?=
 =?utf-8?B?L3BkakRTZzBPWjNwU1VJSnhYZ3gzVTh1dXVXRlNEQ3p5Nmdkb2tmZUdxejZW?=
 =?utf-8?B?YURYZHp5NS9NQXk3TVM2TUFhazM0SVdhR3Q5STdpTm5pcU9Hbnd2dWwrRDBJ?=
 =?utf-8?B?eVROZ1AzVnFCUG9vS2FJeGFWbWVqdUorbE92a056ZElDZWRtOG0zWnJtOUdZ?=
 =?utf-8?B?QnpaZTRlbWV3UUtTVWtYSXJWRkdaZ3RyYXoreVA2SDVnMmdtN0hNV0IrVjNp?=
 =?utf-8?B?TlY5RHh6ZFErYVkrR3pZN2lFVHRwUXhQb2NDYTUyNHFWVmRoYm5FRW5DZ24y?=
 =?utf-8?B?TDFteFlZaDNxa3Y5aVNmV0V1V1Vlb2l2YmlGZnRSU3lPUWFndHFZOUcwakJv?=
 =?utf-8?B?anFpQzgzTGxiOEU1SmFqTzlyY1dXRVhpcXR0MG9XUFR1Rnk0YkJHTjFjczVa?=
 =?utf-8?B?MFhpZkNpWDg0QlRYUkYzNnNyRWpDVll4MmJxQngrK1E4M1ZGQTJGakZvajZN?=
 =?utf-8?B?aC8vT2w5V3RMeUVJOHQraGdNNWtqZnhMeU1FQnhsZUFEc3VtNkVnRjNHZFlH?=
 =?utf-8?B?bjhnSEY4QzdGNERkR0JiZzB0aCtpWjRBMEducnZxaU5LdUFrTVpHdUZEa3E3?=
 =?utf-8?B?VWl4bFJ4UTRGRUVTNjNPUHhhVGE4alJuSERYdTYxQVRULzZEYy9sSWhGNk5m?=
 =?utf-8?B?cXB0U1lIYXRieTVLM0dUUFBVZ05kcU82TVdpQTgxekVKTitmUHZldWN2V3M2?=
 =?utf-8?B?WndhNEtsUzIwODFwL0RVYWh3Y2g5WHBuQUsvOW95eUd0Zm1aRWdzanRvUm5q?=
 =?utf-8?B?UjJhUVZsRU5NVEV1Tjd3K3BHVEIrZlFnUWowR0FVVm9rdVVTVXErU24ra29s?=
 =?utf-8?B?UkZkVklxaWVTSkZFZXJ1ak5FSnBUQnRQR0RzdE5PLzhrdFFrWG9iWm1uYUZ4?=
 =?utf-8?B?VEhCNXVJVzYxSk5QSTJES3E0aW83NkhaR0I3NTZZSzR3MklaNjZNdXdYTEtG?=
 =?utf-8?B?ZkNzbVZMOUhRUDJqSWNTbDZGMmtyM2NLWldGb0dvT1JGV1dWV2pZRGJHV2U2?=
 =?utf-8?B?dHo1MHZHODEzTFdQZll1dTZMRGxUckt4YlhiLzlkbkZLSlk5dkxIYURNbGpS?=
 =?utf-8?B?c0FDeUFiTmplZ1Q3SFd1d2lncm43Y2VuUEFyNW5FWU0wNFNFQXBtcGRTcThu?=
 =?utf-8?B?aDhrb0J6NGVmTXBZenBqNzlPaHZaNzEwMHIzNzVUdWh5Q3NQbXk1YTZwOCtk?=
 =?utf-8?B?WFZLbzNteS90SVBPell6M1F4eDRDOHArZ3QvU3ZPK1o1bGNkRVlhOVlxM1Zq?=
 =?utf-8?B?RnQ4VHdlL0lMeDhUaGk3MW83V3plaUZkR0lacVhEeXg1cG11Zk1VNEV6Q0NN?=
 =?utf-8?B?ZzFJdUppUno2ZWRHczFLWEhnYng4MER3L05VMEVYUy9yWFZ1ajQ4U2pSZDdj?=
 =?utf-8?B?ZVFtMUp5ZjVZUlNiRDRVOTl6YWlpYzdzNi9NY3FoRG9TcTU3VTFpazlROXlZ?=
 =?utf-8?B?VkMyMnErZlYvakRPRzdEK1VYbDI3bmNkS3lxWmdkcU8wVVp1bTVtQ3Ayb3I2?=
 =?utf-8?B?am1QYTRsN1JJSGN4UGpQTGw4NGVmaFVLcncrNlBEM0crNWtMekw0aUdodnlC?=
 =?utf-8?B?RzZVWm9vN2hnRmRNc1RYdC9TV1ByQ0NJcWM4V3dreWppQndpeFJXN2RUVWhU?=
 =?utf-8?B?QitNVTlXYWZ1dTVHZ2JOZ3JCS21pOUZDamR6NVhvbkh6bWQ1Y3hSVXo5K0FH?=
 =?utf-8?Q?NZFyiduwsR4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEx5RXVHbFpPZjNMYmVaTVEvUXVkOW8zTEVrK3VVa0FpcURDaG1PWkFyQWk2?=
 =?utf-8?B?ZGhGTHZaMW5HdlBUb3lxVnY3ZTgwVHNxSVcrOG1pTGVFdlNsbkFaYktvKzdC?=
 =?utf-8?B?ZUl2Ukt4SWNQNHVsbEZNMGhqZkRsTWxqc0dGbFpVa1phVkM1b0NwR1k4WjRx?=
 =?utf-8?B?MTUxT3A3cHFKK0dPU0pjWFArby8zVGJXak4zbTNTR1EvQThpM3BuOEdjVGxj?=
 =?utf-8?B?bWtuMGFFMVNWT09mTWxteHhiVzBhTnRjSzBGakR3NDBIOUhTYkRBN0tHVjdL?=
 =?utf-8?B?TE5VOHF0UU5NelNPVTJwK0RYSGxWQWFzWVVRWHB4TlF6ME15YXA1VnQ2bWZP?=
 =?utf-8?B?Q0NnSFhaK2E2MUxhNWZtTWRIaUlhaVhNaVJzMTA4SW55NElYOExIOElVV0Rx?=
 =?utf-8?B?L3N5eWUyanUvc3dzeS9pSkpIdEhMODFibEhYWm9ERkdKbWNiTEVvcS9nRmUy?=
 =?utf-8?B?SkM3ZFd4SWQ3SlVJOVNUK1Q2Qkg4eDRNZUlsVkJVZTdIN1VHZVpkZitTZiti?=
 =?utf-8?B?WitvcGpXN2cyZlBaOTNFdmZOZERlcW94K244V1FudkdOM25NL1M3T1FQUUJs?=
 =?utf-8?B?bHlVOVAyQjJmUmVPc0w3SWgwR3JRYllta0gwWXR2Q1VNUUdvQjBvVzBzc0R3?=
 =?utf-8?B?UTR3VFVrVUNMcjZlTUw4dDByeWJjSmpLWno5em5renIvbWMzUVNmcEdlN0NO?=
 =?utf-8?B?TWRybDc4SnR1OGtQVHczVFFrL0dxL2NtcjBzSTd5dFdZZjdST2RpTGQ3T0ZT?=
 =?utf-8?B?YllybXYrZy9XMnBRU3h5RUs3Tnd5SDVWaVJWM2JPZmM0U0kvRHNEYldML3Fj?=
 =?utf-8?B?dnhMRWd5RHd4TjFzWHJBdmRvQ08vU0tRdFE2S3FrL09lRlA5UG5pcTF5d05h?=
 =?utf-8?B?VDRoNzJORmVMVnRkM1hGUE16MWIrYVprUVZ6VWVaWG4yZkZkVUdWOTg5K3VL?=
 =?utf-8?B?SHZ1TDUydGNSd3QxdFA3YWdiWEIyZG0rTzhBNkRRSzIxTXRjYmUvUG9IOEV3?=
 =?utf-8?B?cHZyV09wVWo1elNPUjVlM2JPSjkwbTBnOVRxVWJ4blVJTFM4eThwNnJ4K1dL?=
 =?utf-8?B?T3RVYjE2MmkrYmsyT0pERmRDa05Ycm9XTG5TWDI5NlhVSXNVcVYwV3VsVm9q?=
 =?utf-8?B?dzQybE5FclY4cFQ2bkR4MThSakdsTHBDbm5HTFUyVmhFeWtnbFdwaDA4Mkgv?=
 =?utf-8?B?T04rTVA0WVRaRDFROHZHSjhHdFAxcUEydFhjQmM0SVpXeWUza1BUWmlpSVFD?=
 =?utf-8?B?R0xHMDN6YituZE1CTkh6WDFId2hZdXRLd2F0MkxCU2x3ZHA5Z3dUU0EyN2lM?=
 =?utf-8?B?dXVDZS9mZERJSUlOWWxFS0NqUys5Um5EWUhCbm5tWVI4cmJMa0pLeGlPSytT?=
 =?utf-8?B?RExETmVVUGRYNlZ6Y2dDZ3NHZHhFTklQQ0RMVmNHa09xb0RibjZKZlN5U2lX?=
 =?utf-8?B?bGUzNjQ1UWRIeXlGTW80OFJESVpZSzZPNjhCTWJrZ3IvZy9lQ3RmRG9mb09l?=
 =?utf-8?B?bTJBOTBZZTN4ejNkYTFua3Vrdmp0dFExY3ZacGE5LzNOaWlGUzI5b2VUbFFp?=
 =?utf-8?B?UUJHNTVHQ1hLRW5SRko2YThJVlNQZ1ZGQ1ZNd1VNR0FCV0tmZWk5cU9oQzhn?=
 =?utf-8?B?QUI3VFFseEpCVHhncHJMV0RhTXdNSWZTTmtDK25rc3c2eFhBTFFFL1hqOXVU?=
 =?utf-8?B?eVhRbzAzYjVQZ0JwZTAwSEY4MlFqSXBFMHZJOVByZ2FUbzJZVklxTUY4V25T?=
 =?utf-8?B?MDd5bVgwUWRWYTFGeFdzWW5Rc3VOc2JXZG05L1R0dEpQaWtFWXQycUFRS1hV?=
 =?utf-8?B?dWtQNThmemdCazhzWlVrK0RHcllrWVlQUExYRjdOc0ora2F6WWFBdUVMYWUr?=
 =?utf-8?B?SUJVQ1pudUxFRkEwdkpaNFUzTnZ4WjV1L044dXJ6QUcxN0ZmaFhtNjgxRmEz?=
 =?utf-8?B?aEJiRGR5bW5WNG9oclc1NUJoanRmSlF5aGdzaFQ5N2F1OGFYSzE4eUJXUjlJ?=
 =?utf-8?B?RThoaU9RSlNWUnZCZ05CSHVTWktDT0d3QmQ3OEhWb1dZUWpodFR1WUJuMDJS?=
 =?utf-8?B?RDc1U2lPUnNhZmFZcHNESlhaV2ZCMzFncnZWTFpvK3RESUxDTjhBaHk0dVl6?=
 =?utf-8?Q?zxkmpCkcyHfqmG8Fzk9eHQiUz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76796db-701c-481d-23c7-08dd9cb9fd6d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 01:01:19.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjJJThQiZsqopkfnFvKJ9fG2ZpEtoMI/NDmc/OM6q7xNPPIzFVGk5wfF04Ts+eRuKzSSCKo27nSXtW3okDH1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF864563BFB



On 27/5/25 01:44, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
>> On 26/5/25 15:05, Aneesh Kumar K.V wrote:
>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>
>>>> On Tue, May 20, 2025 at 12:47:05PM +0530, Aneesh Kumar K.V wrote:
>>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>>
>>>>>> On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
>>>>>>> From: Xu Yilun <yilun.xu@linux.intel.com>
>>>>>>>
>>>>>>> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>>>>>>>
>>>>>>> pci_tsm_bind/unbind() are supposed to be called by kernel components
>>>>>>> which manages the virtual device. The verb 'bind' means VMM does extra
>>>>>>> configurations to make the assigned device ready to be validated by
>>>>>>> CoCo VM as TDI (TEE Device Interface). Usually these configurations
>>>>>>> include assigning device ownership and MMIO ownership to CoCo VM, and
>>>>>>> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
>>>>>>> TDISP message. The detailed operations are specific to platform TSM
>>>>>>> firmware so need to be supported by vendor TSM drivers.
>>>>>>>
>>>>>>> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
>>>>>>> to TSM firmware about further TDI operations after TDI is bound, e.g.
>>>>>>> get device interface report, certifications & measurements. So this kAPI
>>>>>>> is supposed to be called from KVM vmexit handler.
>>>>>>
>>>>>> To clarify, this commit message is staled. We are proposing existing to
>>>>>> QEMU, then pass to TSM through IOMMUFD VDEVICE.
>>>>>>
>>>>>
>>>>> Can you share the POC code/git repo implementing that? I am looking for
>>>>> pci_tsm_bind()/pci_tsm_unbind() example usage.
>>>>
>>>> The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
>>>> Stage 2 patchset. I need to rebase this series, adopt suggestions from
>>>> Jason, and make TDX Connect work to verify, so need more time...
>>>>
>>>
>>> Since the bind/unbind operations are PCI-specific callbacks, and iommufd
>>
>> Not really, it is PCI-specific in TSM (for DOE) but since IOMMUFD is not doing any of that, it can work with struct device (not pci_dev). Thanks,
>>
> 
> Ok, something like this? and iommufd will call tsm_bind()?

yeah, I guess, there is a couple of places like this

git grep pci_dev drivers/iommu/iommufd/

drivers/iommu/iommufd/device.c:                 struct pci_dev *pdev = to_pci_dev(idev->dev);
drivers/iommu/iommufd/eventq.c:         struct pci_dev *pdev = to_pci_dev(dev);

Although I do not see any compelling reason to have pci_dev in the TSM API, struct device should just work and not spill any PCI details to IOMMUFD but whatever... Thanks,

> 
> int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
> {
> 	if (!dev_is_pci(dev))
> 		return -EINVAL;
> 
> 	return pci_tsm_bind(to_pci_dev(dev), kvm, tdi_id);
> }
> EXPORT_SYMBOL_GPL(tsm_bind);
> 
> int tsm_unbind(struct device *dev)
> {
> 	if (!dev_is_pci(dev))
> 		return -EINVAL;
> 
> 	return pci_tsm_unbind(to_pci_dev(dev));
> }
> EXPORT_SYMBOL_GPL(tsm_unbind);
> 
> 
> -aneesh

-- 
Alexey


