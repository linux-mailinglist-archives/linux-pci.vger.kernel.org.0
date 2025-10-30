Return-Path: <linux-pci+bounces-39745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D29C1E010
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 02:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A32A1885574
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 01:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347537A3A5;
	Thu, 30 Oct 2025 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wS7j/aqx"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B92CCC5
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 01:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786920; cv=fail; b=orcmb2caVDxuj/SihYSKJ0yPhRXqYn6GOrXTkWwE/y3b7S+A2mPgDlK5+5PmJNtO8GYJ/YkuPGwnfB7Ci1K04JML2aL4Zp/jZ5WO3cZUBeOd0aOVfDU5SjOronFR3FQVMD2uQ+UsRANUNI08XpHFHyZ/dYxel4x7r6bKbNpLo8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786920; c=relaxed/simple;
	bh=hVW3EJ5t4CB2hQGYQ+S7uXa2HNsqCEjjNlkVoVLCAxE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TdrJ0yAw6LTBTkW36OKS+6auztVbpmkJzwDryJh5ALBFiZ7waycItEuQd7y6Si8frjzUML31gfsmpWFwvf0K0f7guhqXFoxUQ7RfHUNlT26oUx/Qmky14oBOvxHkM62bqDGzBEi4wv/keih101+zin7UBikr2qjmkgYNDj9EIDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wS7j/aqx; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geharLvD6GJ+fnSeqjy1wc0oapCgr1jjg9EIUKmYbqslW2i4D07v1AVe6v3JBfofYwC/rzOAPPgLdjwDxiTyXkL+Tiboqe89RkHWVJ74DesgnEvY+Vn3J/Hczdue21THCIxuW7Rxi2h8F6f6TCyV1LwPlrLsSQQ9gKFhDNgwPWGy9WGGRHQHQR5vBbGbur5pmY004gvgmlsDcUIvkbosh6T6b7Zscql3SmzGPKtE/WmtVKmFKKGWDR2EfsoAtaIY8IiWQjJudvmkisz26GRwoJY+DDowoDNEG0f1Q+nHRixQwq+zd09sGl8hNcBlxob+HDN/HyNoF4jA0LqwwZPc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze99NLQU5lSdnmeNRoqSXB/QSw5mf+29OFlnzUegYTA=;
 b=GWhZjGguWC9qSVRONshW9kiaquNrpBjcgzNhPt29i74cQRzKwJv8mlN/WNJKQB5G5EmdBNnxsRoKFi1lHYS4GKqNqg6jWoQOPdWE7vEvS2H1gxV7t9UKOuJTTWwN7TA+poaq4DNQJtBsfs3SiVEMwIdGqE4IipAzXNOB++/1hO59IRslPaMuMvLQggrhHekjj6FMHh7Knoq4+6nfH7inGF/y+s4XJ9JQmO27dVtS3ZQMt2jOoqdp045Gd9sgjQ6QCnzJypCGnDqN16yTzMLgpIcRgL9Thxfwffpn4GeceDRPHOyGVjGy3ro1dO8KK4QTys2roly07Rw52mkqA8oFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze99NLQU5lSdnmeNRoqSXB/QSw5mf+29OFlnzUegYTA=;
 b=wS7j/aqxpyu23/Z+dScedmvmy+R4rOtCRaViYU7Mziy/KE378zkOkNEAFGCkZILFjD9n7Xm/R9pVUvTZJQM9OfrtBET+6YIzUapF9jy1DIJMBIrhSHCPFJXXU3ceEQkbbd/+QNIDbRJPZuPFIStA0s4BllAFO5D8X3LtCo2KbG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 01:15:14 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9253.013; Thu, 30 Oct 2025
 01:15:14 +0000
Message-ID: <56542c55-6d58-4cf5-9d95-b88cb7b3196a@amd.com>
Date: Thu, 30 Oct 2025 12:13:53 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 4/9] PCI/TSM: Establish Secure Sessions and Link
 Encryption
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org, bhelgaas@google.com,
 gregkh@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-5-dan.j.williams@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20251024020418.1366664-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: e740d613-12c8-40e5-f9d7-08de1751c763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmVlcUk1T1lSbEx0ZHMvenFkcFZKcHBmQy8vUTJvc0QrbzkyWUVWeHJRbC9R?=
 =?utf-8?B?dE1Pc1ZmaTNrUHdjQlEvSG1pRHVVVjk1bFB2bmI2cXk4YXlqSDUyWStZcU1t?=
 =?utf-8?B?RGx5Uk1Kd1BHYWc3UVdMVXQvdWs0S21PSTRUM0hRdVQ5c1p0OXRBSVNYemtZ?=
 =?utf-8?B?Y0hORitGNmhya0d6cHg3eEhhM0tCQXJjL0swNEI1dW9rOERkUUdVNnZvUDRo?=
 =?utf-8?B?c2FkY3REZlhJOUtWbm5FMkJYWnJCVmhuM2U0ZG04SkFxNlZWNjh0MkpWcWN4?=
 =?utf-8?B?VUUzVVUyaS8yUjFZc283KzVEOGY1SjBoMlAydThobHFBeHRIZHQ0dm81aVVy?=
 =?utf-8?B?UzduTEM4ZmlibDBHUzBPVjZMbmFBcWhWcGo0QzcraVBIeVBXdFVoRVJXU3Ew?=
 =?utf-8?B?elBuMzJWTnA0OHNhak4vSUY1Z2lFU05Ob2dPNW02THhjMUl0S2lBb0NvSG5o?=
 =?utf-8?B?aUsxMjVWQnAzTlo3QXZPQVJIcDRQOXllcS9jNGtQeDBxN2diR1I4MFFTdVhL?=
 =?utf-8?B?dHVwcmtSczVmRGpaN3kxeklkTmlkRHpVeUN3RjhPUmZVWXRSeG9QQk1Wc3RY?=
 =?utf-8?B?cUpkT1doVkl5WWwzQm9STWJuMzV3bjFwSzVKNVpjRm5hTUcxY1czNlF2VVNo?=
 =?utf-8?B?T3o2aXk5Q2xNMW5hTkc0Zzg3YWpYMU90cEg0TjJHNTFCQzBGOTRQL3ZXY0tP?=
 =?utf-8?B?bHpuVVhSTlZTTStBQ29GWEFRR0tjKzdxbVpsVkZUZitlNVoraVJVNjMyY0pY?=
 =?utf-8?B?SWdtYkE3citJTWl1Z0dzKzhNZVNsVVpjYTltSS91TmpnUWM1VFpNT2Jkc2Yy?=
 =?utf-8?B?ZVEzU0FvdUQyaUczbVloKyt1d21uRkpLcTVScGM0dERQZGRFR3Y3WlFsMXJX?=
 =?utf-8?B?VDdyU1JVRU85bVI1RmFrNllWSVJHSlJhMVk0bmpVQzNBY1ZDa21kSW5aWXJr?=
 =?utf-8?B?RnNxODhNUW1UT1U2ZmVEMmpUQXVxelI3TjdRZ20rck9zU2NBUmtERVlTSDBj?=
 =?utf-8?B?RnVHRzlyQnVEbTZ0ZVlqRXZ4RjZINkYrdVllSkdTb2hpTUpLRUEzSmd6a1Fo?=
 =?utf-8?B?VURtMlNvaHJpN0l2eklPQkt3aE10SVYwcWVZNE5hVDljQjJRQWJWY0p3RlpD?=
 =?utf-8?B?ZHcrTHIwRTB1cmNKN2FzMlV2VzVsY2NOWXdta3JYRi9KZmhGQm9HQ0pialZ5?=
 =?utf-8?B?REtuR0dobjBZb2dXdHlrZXFPL2pmVlZMRWNJdTVva0FKdWNPaVd1M1o0SDJP?=
 =?utf-8?B?d2thcFEwNmtZU3BIVWVCbWtzRU15UjV4NVJvNmhQa2RyMjVXdWo3b2RaK3RU?=
 =?utf-8?B?bWE0ZFd1YlZxZ2tLZTlLM2NvaVJpQ2JmNUJ5UWh5M2hpaGRKaW9SaGZVT2dT?=
 =?utf-8?B?Y2pFcGQwbnN2UUdYaVNDOGRhQWVTU3Q0clE2ZEZUMHVQMUF1N0VIUlNReTEz?=
 =?utf-8?B?Rkl2eno1L2N5STJNK2dHazFTREtneFJUc2ZuR1NjSTVsdTVQb290OXMzL1Mv?=
 =?utf-8?B?OFh6Zkl5UEYybU92ekFDWkl1VUNTRHJ6SHFETTdDNk5sdzJmWmVRSCsrZTR1?=
 =?utf-8?B?bzNLL0ppN0QwVDRhTEJRRUZOazhnSmFkVkhnYjBRd1VvMXRNN1p6dXVrYXov?=
 =?utf-8?B?RDlacElUMFlrVWhQL3BET05hUzBwMjRNUkd3c2p6UjhOQXJyNG0wYTdCVU1R?=
 =?utf-8?B?dDlseVVId1dqUXhRaE4ya0Jhdnp1T293ZThmVkJiQTNaRkI1ZXorRzd2bmlo?=
 =?utf-8?B?RjZhckppUTUxMEFwR1RwY01KNlcwNkFPbXllWHpQajJXMFIwalVibGNiTmcv?=
 =?utf-8?B?Yk9ySVFycFJCNnhOQkRkWmluV1NMTmR1R3JMeU1iN2dSdXVvQnJsWHJONzdk?=
 =?utf-8?B?V21ITmFubXdhQ3pjZFlqWjRiUGQzOWorTXRPSWNTSmt3b3prcENjekhwdGJk?=
 =?utf-8?Q?X5BoaKh/iz56uQfNXhptpFCJp2ppc7UD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUEwUXAyN3pjVXNkTzRQNHBXRHdvYWVTdTVPZ1BBeTU4TkJNM3Z3VlBtTlgx?=
 =?utf-8?B?bWJ6YlMwWjIxSnNzN2hxaENiVkI3eVI4MXFPbWxvTXZrYjFDZjBUTURyMUJE?=
 =?utf-8?B?VjRKTnllYnF3WjRjRUNsVUprL2d1VFZOSmJkNkwxeWIybHliblBXS2Y3N25M?=
 =?utf-8?B?MjhJUFA0R2FMZmZiZVNsL3pWa3hMQm1TbnlVMXZaM0EvZTV1UGdLVEQzcmQ3?=
 =?utf-8?B?Z0pLZmJOSzJpMmNGektQNlBRdXVjWU9pRUlJSUY3emhMQ1Y2MlEvbWNQVGp4?=
 =?utf-8?B?dWpMd3hyUzFUZGM2cUh6OXkxd0k0bXZOUWtFRmtTaEZIS3RhSFFFcTNpRGtM?=
 =?utf-8?B?R0tCd3hjK1VJSEVsV1lhemV1Z0ZIYWUxNXpVR09CM0pWdFpub3BGRTZyVGZv?=
 =?utf-8?B?K3lBbXNXTW5zWUhNRnZPb3BXc1lEOGowMGx6OVBDVkk0VkRRL3pnVm0zMHZl?=
 =?utf-8?B?TG8yZEZJWWtLcnpuWjF6clZYZS9jSmZCNWN6VFkwUXVYVlNOMU9OYkZGVmtm?=
 =?utf-8?B?THFZTWRqa05iYW5yek9LeDc2L1lsbGYzcmhFRSsrUkFtK3hvWTJBOXViaUVa?=
 =?utf-8?B?Q1orUDRjL3VlL0I3VXJZakJRd3NPUm9STkdkdDBaR3I4eFVkUUtRU1JjczYy?=
 =?utf-8?B?TVFtLzBqTjdVd3F1ZENqUUV3R29YbXJLa3lNb0o1OEpKSG0xWUJ2d0dxNmk5?=
 =?utf-8?B?RUl3cHZSNWxVOGg1RFVtTzZucXhpcG95cE9weGtrK2lWdmZyR3N0Nzk0ZnM4?=
 =?utf-8?B?cTMydWhnMTFPOWZuQi92Njh2dlFDS0M2QWZQZUZRUkhXbXVGMGhqUmhZR2h2?=
 =?utf-8?B?V2NJUFpXT1ZJSk5hYVQxeUx1MlRXcjg4Ukp3YVZOaGNDRFhsNVY4TzFsRVRF?=
 =?utf-8?B?WFNaZW9DT21aMjlrc3RKN0Z6N0N4R1NRdGFKQVo1OEl3L0wvaE9ORnJvYnBt?=
 =?utf-8?B?cnZ6TGlJQjZRL21neHBJZnpDTDg1VVc1RnUrcXd5VEk0bHVjaHdEU1h1TWs0?=
 =?utf-8?B?YWdoNGZYdHRlRDJtdmY1N01oVjQ2WWRsVTFyeGVMdmtIaVVxbE1DSmpDV2Qv?=
 =?utf-8?B?WTZOVXBsVkozSS9lNkRWNVhneFptUmNwRGt3ZXQ0VlJ3ak9XYnVKUGhLdGcy?=
 =?utf-8?B?K1JJeUhORmRJbUo5MWF3VXVRdklzTVcvNTJJTE81WGN3Q2loeWZYeFV6eVkv?=
 =?utf-8?B?czNlVEVkNFU0cVpLempueFhlL2E5KzdCYjlVbEp2aENBaU1HT2hhdDlSTWF0?=
 =?utf-8?B?c0wrRGp5OGF2dnBpUGE4NXJURkt4TXJKWG01NUFTaEdsSC9iR21LZXUvcUZT?=
 =?utf-8?B?UHBQUUs4SXJBVVlXOEI0WFl6R2VUSTZNQzhoL082RXhIczk0dUIrVlJvbE9I?=
 =?utf-8?B?ZTR4bDN2M2x3WGErU1pjV0lLQ2NHa0tkUzl3RDdET3ozQzArZWo0RElEMG1p?=
 =?utf-8?B?MWI2SzlyQ2o3SDBXOGJGTElSRG45UG50LzJKN1dGMmIzRFlWd0NSZkJneGlO?=
 =?utf-8?B?d2g5UFJURktET015QlNOckdUWERvUlRDc042MTUwWXRqVmxkeGltaE1MK2Z4?=
 =?utf-8?B?UkNPS2FMSGcxR2gxaUUwbnc3U2s2MHI0OXpQYWRUUVQ0QVFIN2tYK1Y2Rkto?=
 =?utf-8?B?RTRmYjFLQ283L1Eya3lteEQyN2NzeC82ajVQL3FNdEttblhXU3cxYmU0aStS?=
 =?utf-8?B?STB5RkFKVHRBSzVtUERLSVY2QWpoaGVRR2NpNVlTNTFXZGJLWFZlTzNXWkJn?=
 =?utf-8?B?YXVweXBNamRZMDhsM3UwS2FuekpGanN6b2dZU0JWNU1CSmtkQW5IZS9uamV1?=
 =?utf-8?B?bHV3bm5nWmlsaEhvSzgrcXRkTGhmUGlraUVoaG5QYVBBdU9HQlRpMW5Udjg1?=
 =?utf-8?B?N1R4YkFtNHdWSzhyYlg2NG5ZTVd1VjVPOWZuSGh0YjA3YnlBNktYRUxJckRC?=
 =?utf-8?B?QTJiS2RjTElrK0VWWDI3Zjg2YTRqZGlSQlgvZ2lTWWxLSUZhSzFtM1NVbW1V?=
 =?utf-8?B?TnFrNnhYZXBOMUF3VlBQNTRpcytlOGg4T1pNVmZkSEtWclFXaWo2MnAxYmhT?=
 =?utf-8?B?VnptaEkwbk9EaVVtM0Y0RVArOVdJV0JBdGZWdUh4aDRIMWlIcWNqWXZkR3RO?=
 =?utf-8?Q?2B6Bm1aSqq4ke9thvkfKuTktF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e740d613-12c8-40e5-f9d7-08de1751c763
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 01:15:14.1721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBix8/8GZcZFcYoCWw/du0kbNvlYP25Jhg5lPc033mZrNgVJszuTsmVrtI1Z2T4zxQsucJ+pAJH28aJAt0iDFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225



On 24/10/25 13:04, Dan Williams wrote:
> The PCIe 7.0 specification, section 11, defines the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> protocol definition builds upon Component Measurement and Authentication
> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> assigning devices (PCI physical or virtual function) to a confidential VM
> such that the assigned device is enabled to access guest private memory
> protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
> CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
> 
> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> Userspace can watch for the arrival of a "TSM" device,
> /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
> initialized TSM services.
> 
> The operations that can be executed against a PCI device are split into
> two mutually exclusive operation sets, "Link" and "Security" (struct
> pci_tsm_{link,security}_ops). The "Link" operations manage physical link
> security properties and communication with the device's Device Security
> Manager firmware. These are the host side operations in TDISP. The
> "Security" operations coordinate the security state of the assigned
> virtual device (TDI). These are the guest side operations in TDISP.
> 
> Only "link", Secure Session and physical Link Encryption, operations are
> defined at this stage with placeholders for the device security, Trusted
> Computing Base entry / exit, operations.
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem
> synchronizes the implementation relative to TSM registration/unregistration
> events.
> 
> Thanks to Wu Hao for his work on an early draft of this support.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Reviewed-by: Alexey Kardashevskiy <aik@amd.com>

> ---
>   drivers/pci/Kconfig                     |  15 +
>   drivers/pci/Makefile                    |   1 +
>   Documentation/ABI/testing/sysfs-bus-pci |  51 ++
>   Documentation/driver-api/pci/index.rst  |   1 +
>   Documentation/driver-api/pci/tsm.rst    |  21 +
>   drivers/pci/pci.h                       |  10 +
>   include/linux/pci-doe.h                 |   4 +
>   include/linux/pci-tsm.h                 | 159 ++++++
>   include/linux/pci.h                     |   3 +
>   include/linux/tsm.h                     |  11 +-
>   include/uapi/linux/pci_regs.h           |   1 +
>   drivers/pci/doe.c                       |   2 -
>   drivers/pci/pci-sysfs.c                 |   4 +
>   drivers/pci/probe.c                     |   3 +
>   drivers/pci/remove.c                    |   6 +
>   drivers/pci/tsm.c                       | 643 ++++++++++++++++++++++++
>   drivers/virt/coco/tsm-core.c            |  39 +-
>   MAINTAINERS                             |   4 +-
>   18 files changed, 967 insertions(+), 11 deletions(-)
>   create mode 100644 Documentation/driver-api/pci/tsm.rst
>   create mode 100644 include/linux/pci-tsm.h
>   create mode 100644 drivers/pci/tsm.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index b28423e2057f..00b0210e1f1d 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -125,6 +125,21 @@ config PCI_ATS
>   config PCI_IDE
>   	bool
>   
> +config PCI_TSM
> +	bool "PCI TSM: Device security protocol support"
> +	select PCI_IDE
> +	select PCI_DOE
> +	select TSM
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform agent
> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device functions
> +	  (virtual or physical) to confidential computing VMs that can
> +	  access (DMA) guest private memory.
> +
> +	  Enable a platform TSM driver to use this capability.
> +
>   config PCI_DOE
>   	bool "Enable PCI Data Object Exchange (DOE) support"
>   	help
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 6612256fd37d..2c545f877062 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>   obj-$(CONFIG_PCI_IDE)		+= ide.o
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 92debe879ffb..6ffe02f854d6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -621,3 +621,54 @@ Description:
>   		number extended capability. The file is read only and due to
>   		the possible sensitivity of accessible serial numbers, admin
>   		only.
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a physical device function
> +		supports authentication (PCIe CMA-SPDM), interface security
> +		(PCIe TDISP), and is accepted for secure operation by the
> +		platform TSM driver. This attribute directory appears
> +		dynamically after the platform TSM driver loads. So, only after
> +		the /sys/class/tsm/tsm0 device arrives can tools assume that
> +		devices without a tsm/ attribute directory will never have one;
> +		before that, the security capabilities of the device relative to
> +		the platform TSM are unknown. See
> +		Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Write the name of a TSM (TEE Security Manager) device from
> +		/sys/class/tsm to this file to establish a connection with the
> +		device.  This typically includes an SPDM (DMTF Security
> +		Protocols and Data Models) session over PCIe DOE (Data Object
> +		Exchange) and may also include PCIe IDE (Integrity and Data
> +		Encryption) establishment. Reads from this attribute return the
> +		name of the connected TSM or the empty string if not
> +		connected. A TSM device signals its readiness to accept PCI
> +		connection via a KOBJ_CHANGE event.
> +
> +What:		/sys/bus/pci/devices/.../tsm/disconnect
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) Write the name of the TSM device that was specified
> +		to 'connect' to teardown the connection.
> +
> +What:		/sys/bus/pci/devices/.../authenticated
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		When the device's tsm/ directory is present device
> +		authentication (PCIe CMA-SPDM) and link encryption (PCIe IDE)
> +		are handled by the platform TSM (TEE Security Manager). When the
> +		tsm/ directory is not present this attribute reflects only the
> +		native CMA-SPDM authentication state with the kernel's
> +		certificate store.
> +
> +		If the attribute is not present, it indicates that
> +		authentication is unsupported by the device, or the TSM has no
> +		available authentication methods for the device.
> +
> +		When present and the tsm/ attribute directory is present, the
> +		authenticated attribute is an alias for the device 'connect'
> +		state. See the 'tsm/connect' attribute for more details.
> diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
> index a38e475cdbe3..9e1b801d0f74 100644
> --- a/Documentation/driver-api/pci/index.rst
> +++ b/Documentation/driver-api/pci/index.rst
> @@ -10,6 +10,7 @@ The Linux PCI driver implementer's API guide
>   
>      pci
>      p2pdma
> +   tsm
>   
>   .. only::  subproject and html
>   
> diff --git a/Documentation/driver-api/pci/tsm.rst b/Documentation/driver-api/pci/tsm.rst
> new file mode 100644
> index 000000000000..232b92bec93f
> --- /dev/null
> +++ b/Documentation/driver-api/pci/tsm.rst
> @@ -0,0 +1,21 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +========================================================
> +PCI Trusted Execution Environment Security Manager (TSM)
> +========================================================
> +
> +Subsystem Interfaces
> +====================
> +
> +.. kernel-doc:: include/linux/pci-ide.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/pci/ide.c
> +   :export:
> +
> +.. kernel-doc:: include/linux/pci-tsm.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/pci/tsm.c
> +   :export:
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 86ef13e7cece..6e4cc1c9aa58 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -619,6 +619,16 @@ void pci_ide_init(struct pci_dev *dev);
>   static inline void pci_ide_init(struct pci_dev *dev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_TSM
> +void pci_tsm_init(struct pci_dev *pdev);
> +void pci_tsm_destroy(struct pci_dev *pdev);
> +extern const struct attribute_group pci_tsm_attr_group;
> +extern const struct attribute_group pci_tsm_auth_attr_group;
> +#else
> +static inline void pci_tsm_init(struct pci_dev *pdev) { }
> +static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index 1f14aed4354b..bd4346a7c4e7 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -15,6 +15,10 @@
>   
>   struct pci_doe_mb;
>   
> +#define PCI_DOE_FEATURE_DISCOVERY 0
> +#define PCI_DOE_FEATURE_CMA 1
> +#define PCI_DOE_FEATURE_SSESSION 2
> +
>   struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
>   					u8 type);
>   
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..e3107ede2a0f
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,159 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +
> +struct pci_tsm;
> +struct tsm_dev;
> +
> +/*
> + * struct pci_tsm_ops - manage confidential links and security state
> + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> + *	      Provide a secure session transport for TDISP state management
> + *	      (typically bare metal physical function operations).
> + * @sec_ops: Lock, unlock, and interrogate the security state of the
> + *	     function via the platform TSM (typically virtual function
> + *	     operations).
> + * @owner: Back reference to the TSM device that owns this instance.
> + *
> + * This operations are mutually exclusive either a tsm_dev instance
> + * manages physical link properties or it manages function security
> + * states like TDISP lock/unlock.
> + */
> +struct pci_tsm_ops {
> +	/*
> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> +	 * @probe: establish context with the TSM (allocate / wrap 'struct
> +	 *	   pci_tsm') for follow-on link operations
> +	 * @remove: destroy link operations context
> +	 * @connect: establish / validate a secure connection (e.g. IDE)
> +	 *	     with the device
> +	 * @disconnect: teardown the secure link
> +	 *
> +	 * Context: @probe, @remove, @connect, and @disconnect run under
> +	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
> +	 * mutual exclusion of @connect and @disconnect. @connect and
> +	 * @disconnect additionally run under the DSM lock (struct
> +	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> +	 */
> +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> +		struct pci_tsm *(*probe)(struct tsm_dev *tsm_dev,
> +					 struct pci_dev *pdev);
> +		void (*remove)(struct pci_tsm *tsm);
> +		int (*connect)(struct pci_dev *pdev);
> +		void (*disconnect)(struct pci_dev *pdev);
> +	);
> +
> +	/*
> +	 * struct pci_tsm_devsec_ops - Manage the security state of the function
> +	 * @lock: establish context with the TSM (allocate / wrap 'struct
> +	 *	  pci_tsm') for follow-on security state transitions from the
> +	 *	  LOCKED state
> +	 * @unlock: destroy TSM context and return device to UNLOCKED state
> +	 *
> +	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> +	 * sync with TSM unregistration and each other
> +	 */
> +	struct_group_tagged(pci_tsm_devsec_ops, devsec_ops,
> +		struct pci_tsm *(*lock)(struct tsm_dev *tsm_dev,
> +					struct pci_dev *pdev);
> +		void (*unlock)(struct pci_tsm *tsm);
> +	);
> +};
> +
> +/**
> + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> + * @pdev: Back ref to device function, distinguishes type of pci_tsm context
> + * @dsm_dev: PCI Device Security Manager for link operations on @pdev
> + * @tsm_dev: PCI TEE Security Manager device for Link Confidentiality or Device
> + *	     Function Security operations
> + *
> + * This structure is wrapped by low level TSM driver data and returned by
> + * probe()/lock(), it is freed by the corresponding remove()/unlock().
> + *
> + * For link operations it serves to cache the association between a Device
> + * Security Manager (DSM) and the functions that manager can assign to a TVM.
> + * That can be "self", for assigning function0 of a TEE I/O device, a
> + * sub-function (SR-IOV virtual function, or non-function0
> + * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
> + * DSM).
> + */
> +struct pci_tsm {
> +	struct pci_dev *pdev;
> +	struct pci_dev *dsm_dev;
> +	struct tsm_dev *tsm_dev;
> +};
> +
> +/**
> + * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
> + * @base_tsm: generic core "tsm" context
> + * @lock: mutual exclustion for pci_tsm_ops invocation
> + * @doe_mb: PCIe Data Object Exchange mailbox
> + */
> +struct pci_tsm_pf0 {
> +	struct pci_tsm base_tsm;
> +	struct mutex lock;
> +	struct pci_doe_mb *doe_mb;
> +};
> +
> +/* physical function0 and capable of 'connect' */
> +static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
> +{
> +	if (!pdev)
> +		return false;
> +
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pdev->is_virtfn)
> +		return false;
> +
> +	/*
> +	 * Allow for a Device Security Manager (DSM) associated with function0
> +	 * of an Endpoint to coordinate TDISP requests for other functions
> +	 * (physical or virtual) of the device, or allow for an Upstream Port
> +	 * DSM to accept TDISP requests for the Endpoints downstream of the
> +	 * switch.
> +	 */
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_RC_END:
> +		if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
> +			break;
> +		fallthrough;
> +	default:
> +		return false;
> +	}
> +
> +	return PCI_FUNC(pdev->devfn) == 0;
> +}
> +
> +#ifdef CONFIG_PCI_TSM
> +struct tsm_dev;
> +int pci_tsm_register(struct tsm_dev *tsm_dev);
> +void pci_tsm_unregister(struct tsm_dev *tsm_dev);
> +int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
> +			     struct tsm_dev *tsm_dev);
> +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> +			    struct tsm_dev *tsm_dev);
> +void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
> +			 size_t req_sz, void *resp, size_t resp_sz);
> +#else
> +static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
> +{
> +	return 0;
> +}
> +static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
> +{
> +}
> +static inline int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type,
> +				       const void *req, size_t req_sz,
> +				       void *resp, size_t resp_sz)
> +{
> +	return -ENXIO;
> +}
> +#endif
> +#endif /*__PCI_TSM_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b6a12a82be12..2f9c0cb6a50a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -546,6 +546,9 @@ struct pci_dev {
>   	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
>   	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>   	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	struct pci_tsm *tsm;		/* TSM operation state */
>   #endif
>   	u16		acs_cap;	/* ACS Capability offset */
>   	u8		supported_speeds; /* Supported Link Speeds Vector */
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index aa906eb67360..ee9a54ae3d3c 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -108,9 +108,16 @@ struct tsm_report_ops {
>   	bool (*report_bin_attr_visible)(int n);
>   };
>   
> +struct pci_tsm_ops;
> +struct tsm_dev {
> +	struct device dev;
> +	int id;
> +	const struct pci_tsm_ops *pci_ops;
> +};
> +
>   int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
>   int tsm_report_unregister(const struct tsm_report_ops *ops);
> -struct tsm_dev;
> -struct tsm_dev *tsm_register(struct device *parent);
> +struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
>   void tsm_unregister(struct tsm_dev *tsm_dev);
> +struct tsm_dev *find_tsm_dev(int id);
>   #endif /* __TSM_H */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 05bd22d9e352..f2759c1097bc 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -503,6 +503,7 @@
>   #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
>   #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
>   #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
> +#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
>   #define PCI_EXP_DEVCTL		0x08	/* Device Control */
>   #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
>   #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index aae9a8a00406..62be9c8dbc52 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -24,8 +24,6 @@
>   
>   #include "pci.h"
>   
> -#define PCI_DOE_FEATURE_DISCOVERY 0
> -
>   /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
>   #define PCI_DOE_TIMEOUT HZ
>   #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 9d6f74bd95f8..7f9237a926c2 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1868,6 +1868,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   #endif
>   #ifdef CONFIG_PCI_DOE
>   	&pci_doe_sysfs_group,
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	&pci_tsm_auth_attr_group,
> +	&pci_tsm_attr_group,
>   #endif
>   	NULL,
>   };
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4c55020f3ddf..d1467348c169 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2763,6 +2763,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>   	ret = device_add(&dev->dev);
>   	WARN_ON(ret < 0);
>   
> +	/* Establish pdev->tsm for newly added (e.g. new SR-IOV VFs) */
> +	pci_tsm_init(dev);
> +
>   	pci_npem_create(dev);
>   
>   	pci_doe_sysfs_init(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index ce5c25adef55..803391892c4a 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -57,6 +57,12 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   	pci_doe_sysfs_teardown(dev);
>   	pci_npem_remove(dev);
>   
> +	/*
> +	 * While device is in D0 drop the device from TSM link operations
> +	 * including unbind and disconnect (IDE + SPDM teardown).
> +	 */
> +	pci_tsm_destroy(dev);
> +
>   	device_del(&dev->dev);
>   
>   	down_write(&pci_bus_sem);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..094650454aa7
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,643 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Interface with platform TEE Security Manager (TSM) objects as defined by
> + * PCIe r7.0 section 11 TEE Device Interface Security Protocol (TDISP)
> + *
> + * Copyright(c) 2024-2025 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "PCI/TSM: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/sysfs.h>
> +#include <linux/tsm.h>
> +#include <linux/xarray.h>
> +#include "pci.h"
> +
> +/*
> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a TSM instance
> + */
> +static DECLARE_RWSEM(pci_tsm_rwsem);
> +
> +/*
> + * Count of TSMs registered that support physical link operations vs device
> + * security state management.
> + */
> +static int pci_tsm_link_count;
> +static int pci_tsm_devsec_count;
> +
> +static const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
> +{
> +	return tsm->tsm_dev->pci_ops;
> +}
> +
> +static inline bool is_dsm(struct pci_dev *pdev)
> +{
> +	return pdev->tsm && pdev->tsm->dsm_dev == pdev;
> +}
> +
> +static inline bool has_tee(struct pci_dev *pdev)
> +{
> +	return pdev->devcap & PCI_EXP_DEVCAP_TEE;
> +}
> +
> +/* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm_dev == ->pdev (self) */
> +static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *tsm)
> +{
> +	/*
> +	 * All "link" TSM contexts reference the device that hosts the DSM
> +	 * interface for a set of devices. Walk to the DSM device and cast its
> +	 * ->tsm context to a 'struct pci_tsm_pf0 *'.
> +	 */
> +	struct pci_dev *pf0 = tsm->dsm_dev;
> +
> +	if (!is_pci_tsm_pf0(pf0) || !is_dsm(pf0)) {
> +		pci_WARN_ONCE(tsm->pdev, 1, "invalid context object\n");
> +		return NULL;
> +	}
> +
> +	return container_of(pf0->tsm, struct pci_tsm_pf0, base_tsm);
> +}
> +
> +static void tsm_remove(struct pci_tsm *tsm)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!tsm)
> +		return;
> +
> +	pdev = tsm->pdev;
> +	to_pci_tsm_ops(tsm)->remove(tsm);
> +	pdev->tsm = NULL;
> +}
> +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
> +
> +static void pci_tsm_walk_fns(struct pci_dev *pdev,
> +			     int (*cb)(struct pci_dev *pdev, void *data),
> +			     void *data)
> +{
> +	/* Walk subordinate physical functions */
> +	for (int i = 0; i < 8; i++) {
> +		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
> +			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +
> +		if (!pf)
> +			continue;
> +
> +		/* on entry function 0 has already run @cb */
> +		if (i > 0)
> +			cb(pf, data);
> +
> +		/* walk virtual functions of each pf */
> +		for (int j = 0; j < pci_num_vf(pf); j++) {
> +			struct pci_dev *vf __free(pci_dev_put) =
> +				pci_get_domain_bus_and_slot(
> +					pci_domain_nr(pf->bus),
> +					pci_iov_virtfn_bus(pf, j),
> +					pci_iov_virtfn_devfn(pf, j));
> +
> +			if (!vf)
> +				continue;
> +
> +			cb(vf, data);
> +		}
> +	}
> +
> +	/*
> +	 * Walk downstream devices, assumes that an upstream DSM is
> +	 * limited to downstream physical functions
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
> +		pci_walk_bus(pdev->subordinate, cb, data);
> +}
> +
> +static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
> +				     int (*cb)(struct pci_dev *pdev,
> +					       void *data),
> +				     void *data)
> +{
> +	/* Reverse walk downstream devices */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
> +		pci_walk_bus_reverse(pdev->subordinate, cb, data);
> +
> +	/* Reverse walk subordinate physical functions */
> +	for (int i = 7; i >= 0; i--) {
> +		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
> +			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +
> +		if (!pf)
> +			continue;
> +
> +		/* reverse walk virtual functions */
> +		for (int j = pci_num_vf(pf) - 1; j >= 0; j--) {
> +			struct pci_dev *vf __free(pci_dev_put) =
> +				pci_get_domain_bus_and_slot(
> +					pci_domain_nr(pf->bus),
> +					pci_iov_virtfn_bus(pf, j),
> +					pci_iov_virtfn_devfn(pf, j));
> +
> +			if (!vf)
> +				continue;
> +			cb(vf, data);
> +		}
> +
> +		/* on exit, caller will run @cb on function 0 */
> +		if (i > 0)
> +			cb(pf, data);
> +	}
> +}
> +
> +static int probe_fn(struct pci_dev *pdev, void *dsm)
> +{
> +	struct pci_dev *dsm_dev = dsm;
> +	const struct pci_tsm_ops *ops = to_pci_tsm_ops(dsm_dev->tsm);
> +
> +	pdev->tsm = ops->probe(dsm_dev->tsm->tsm_dev, pdev);
> +	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
> +		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
> +	return 0;
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	int rc;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
> +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(tsm_dev, pdev);
> +
> +	/* connect()  mutually exclusive with subfunction pci_tsm_init() */
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	if (!pci_tsm)
> +		return -ENXIO;
> +
> +	pdev->tsm = pci_tsm;
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +
> +	/* mutex_intr assumes connect() is always sysfs/user driven */
> +	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> +		return rc;
> +
> +	rc = ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +
> +	/*
> +	 * Now that the DSM is established, probe() all the potential
> +	 * dependent functions. Failure to probe a function is not fatal
> +	 * to connect(), it just disables subsequent security operations
> +	 * for that function.
> +	 *
> +	 * Note this is done unconditionally, without regard to finding
> +	 * PCI_EXP_DEVCAP_TEE on the dependent function, for robustness. The DSM
> +	 * is the ultimate arbiter of security state relative to a given
> +	 * interface id, and if it says it can manage TDISP state of a function,
> +	 * let it.
> +	 */
> +	if (has_tee(pdev))
> +		pci_tsm_walk_fns(pdev, probe_fn, pdev);
> +	return 0;
> +}
> +
> +static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tsm_dev *tsm_dev;
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return sysfs_emit(buf, "\n");
> +
> +	tsm_dev = pdev->tsm->tsm_dev;
> +	return sysfs_emit(buf, "%s\n", dev_name(&tsm_dev->dev));
> +}
> +
> +/* Is @tsm_dev managing physical link / session properties... */
> +static bool is_link_tsm(struct tsm_dev *tsm_dev)
> +{
> +	return tsm_dev && tsm_dev->pci_ops && tsm_dev->pci_ops->link_ops.probe;
> +}
> +
> +/* ...or is @tsm_dev managing device security state ? */
> +static bool is_devsec_tsm(struct tsm_dev *tsm_dev)
> +{
> +	return tsm_dev && tsm_dev->pci_ops && tsm_dev->pci_ops->devsec_ops.lock;
> +}
> +
> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tsm_dev *tsm_dev;
> +	int rc, id;
> +
> +	rc = sscanf(buf, "tsm%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (pdev->tsm)
> +		return -EBUSY;
> +
> +	tsm_dev = find_tsm_dev(id);
> +	if (!is_link_tsm(tsm_dev))
> +		return -ENXIO;
> +
> +	rc = pci_tsm_connect(pdev, tsm_dev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +static DEVICE_ATTR_RW(connect);
> +
> +static int remove_fn(struct pci_dev *pdev, void *data)
> +{
> +	tsm_remove(pdev->tsm);
> +	return 0;
> +}
> +
> +static void __pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +	const struct pci_tsm_ops *ops = to_pci_tsm_ops(pdev->tsm);
> +
> +	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	/*
> +	 * disconnect() is uninterruptible as it may be called for device
> +	 * teardown
> +	 */
> +	guard(mutex)(&tsm_pf0->lock);
> +	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
> +	ops->disconnect(pdev);
> +}
> +
> +static void pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	__pci_tsm_disconnect(pdev);
> +	tsm_remove(pdev->tsm);
> +}
> +
> +static ssize_t disconnect_store(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tsm_dev *tsm_dev;
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +
> +	tsm_dev = pdev->tsm->tsm_dev;
> +	if (!sysfs_streq(buf, dev_name(&tsm_dev->dev)))
> +		return -EINVAL;
> +
> +	pci_tsm_disconnect(pdev);
> +	return len;
> +}
> +static DEVICE_ATTR_WO(disconnect);
> +
> +/* The 'authenticated' attribute is exclusive to the presence of a 'link' TSM */
> +static bool pci_tsm_link_group_visible(struct kobject *kobj)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	return pci_tsm_link_count && is_pci_tsm_pf0(pdev);
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_link);
> +
> +/*
> + * 'link' and 'devsec' TSMs share the same 'tsm/' sysfs group, so the TSM type
> + * specific attributes need individual visibility checks.
> + */
> +static umode_t pci_tsm_attr_visible(struct kobject *kobj,
> +				    struct attribute *attr, int n)
> +{
> +	if (pci_tsm_link_group_visible(kobj)) {
> +		if (attr == &dev_attr_connect.attr ||
> +		    attr == &dev_attr_disconnect.attr)
> +			return attr->mode;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool pci_tsm_group_visible(struct kobject *kobj)
> +{
> +	return pci_tsm_link_group_visible(kobj);
> +}
> +DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
> +
> +static struct attribute *pci_tsm_attrs[] = {
> +	&dev_attr_connect.attr,
> +	&dev_attr_disconnect.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_attr_group = {
> +	.name = "tsm",
> +	.attrs = pci_tsm_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
> +};
> +
> +static ssize_t authenticated_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 * When the SPDM session established via TSM the 'authenticated' state
> +	 * of the device is identical to the connect state.
> +	 */
> +	return connect_show(dev, attr, buf);
> +}
> +static DEVICE_ATTR_RO(authenticated);
> +
> +static struct attribute *pci_tsm_auth_attrs[] = {
> +	&dev_attr_authenticated.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_auth_attr_group = {
> +	.attrs = pci_tsm_auth_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_link),
> +};
> +
> +/*
> + * Retrieve physical function0 device whether it has TEE capability or not
> + */
> +static struct pci_dev *pf0_dev_get(struct pci_dev *pdev)
> +{
> +	struct pci_dev *pf_dev = pci_physfn(pdev);
> +
> +	if (PCI_FUNC(pf_dev->devfn) == 0)
> +		return pci_dev_get(pf_dev);
> +
> +	return pci_get_slot(pf_dev->bus,
> +			    pf_dev->devfn - PCI_FUNC(pf_dev->devfn));
> +}
> +
> +/*
> + * Find the PCI Device instance that serves as the Device Security Manager (DSM)
> + * for @pdev. Note that no additional reference is held for the resulting device
> + * because @pdev always has a longer registered lifetime than its DSM by virtue
> + * of being a child of, or identical to, its DSM.
> + */
> +static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
> +{
> +	struct device *grandparent;
> +	struct pci_dev *uport;
> +
> +	if (is_pci_tsm_pf0(pdev))
> +		return pdev;
> +
> +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> +	if (!pf0)
> +		return NULL;
> +
> +	if (is_dsm(pf0))
> +		return pf0;
> +
> +	/*
> +	 * For cases where a switch may be hosting TDISP services on behalf of
> +	 * downstream devices, check the first upstream port relative to this
> +	 * endpoint.
> +	 */
> +	if (!pdev->dev.parent)
> +		return NULL;
> +	grandparent = pdev->dev.parent->parent;
> +	if (!grandparent)
> +		return NULL;
> +	if (!dev_is_pci(grandparent))
> +		return NULL;
> +	uport = to_pci_dev(grandparent);
> +	if (!pci_is_pcie(uport) ||
> +	    pci_pcie_type(uport) != PCI_EXP_TYPE_UPSTREAM)
> +		return NULL;
> +
> +	if (is_dsm(uport))
> +		return uport;
> +	return NULL;
> +}
> +
> +/**
> + * pci_tsm_link_constructor() - base 'struct pci_tsm' initialization for link TSMs
> + * @pdev: The PCI device
> + * @tsm: context to initialize
> + * @tsm_dev: Platform TEE Security Manager, initiator of security operations
> + */
> +int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
> +			     struct tsm_dev *tsm_dev)
> +{
> +	if (!is_link_tsm(tsm_dev))
> +		return -EINVAL;
> +
> +	tsm->dsm_dev = find_dsm_dev(pdev);
> +	if (!tsm->dsm_dev) {
> +		pci_warn(pdev, "failed to find Device Security Manager\n");
> +		return -ENXIO;
> +	}
> +	tsm->pdev = pdev;
> +	tsm->tsm_dev = tsm_dev;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_link_constructor);
> +
> +/**
> + * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' (DSM) initialization
> + * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
> + * @tsm: context to initialize
> + * @tsm_dev: Platform TEE Security Manager, initiator of security operations
> + */
> +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> +			    struct tsm_dev *tsm_dev)
> +{
> +	mutex_init(&tsm->lock);
> +	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					   PCI_DOE_FEATURE_CMA);
> +	if (!tsm->doe_mb) {
> +		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> +		return -ENODEV;
> +	}
> +
> +	return pci_tsm_link_constructor(pdev, &tsm->base_tsm, tsm_dev);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);
> +
> +void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
> +{
> +	mutex_destroy(&pf0_tsm->lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
> +
> +static void pf0_sysfs_enable(struct pci_dev *pdev)
> +{
> +	bool tee = has_tee(pdev);
> +
> +	pci_dbg(pdev, "Device Security Manager detected (%s%s%s)\n",
> +		pdev->ide_cap ? "IDE" : "", pdev->ide_cap && tee ? " " : "",
> +		tee ? "TEE" : "");
> +
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +}
> +
> +int pci_tsm_register(struct tsm_dev *tsm_dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!tsm_dev)
> +		return -EINVAL;
> +
> +	/* The TSM device must only implement one of link_ops or devsec_ops */
> +	if (!is_link_tsm(tsm_dev) && !is_devsec_tsm(tsm_dev))
> +		return -EINVAL;
> +
> +	if (is_link_tsm(tsm_dev) && is_devsec_tsm(tsm_dev))
> +		return -EINVAL;
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +
> +	/* On first enable, update sysfs groups */
> +	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
> +		for_each_pci_dev(pdev)
> +			if (is_pci_tsm_pf0(pdev))
> +				pf0_sysfs_enable(pdev);
> +	} else if (is_devsec_tsm(tsm_dev)) {
> +		pci_tsm_devsec_count++;
> +	}
> +
> +	return 0;
> +}
> +
> +static void pci_tsm_fn_exit(struct pci_dev *pdev)
> +{
> +	/* TODO: unbind the fn */
> +	tsm_remove(pdev->tsm);
> +}
> +
> +/**
> + * __pci_tsm_destroy() - destroy the TSM context for @pdev
> + * @pdev: device to cleanup
> + * @tsm_dev: the TSM device being removed, or NULL if @pdev is being removed.
> + *
> + * At device removal or TSM unregistration all established context
> + * with the TSM is torn down. Additionally, if there are no more TSMs
> + * registered, the PCI tsm/ sysfs attributes are hidden.
> + */
> +static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	struct pci_tsm *tsm = pdev->tsm;
> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	/*
> +	 * First, handle the TSM removal case to shutdown @pdev sysfs, this is
> +	 * skipped if the device itself is being removed since sysfs goes away
> +	 * naturally at that point
> +	 */
> +	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count) {
> +		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +	}
> +
> +	/* Nothing else to do if this device never attached to the departing TSM */
> +	if (!tsm)
> +		return;
> +
> +	/* Now lookup the tsm_dev to destroy TSM context */
> +	if (!tsm_dev)
> +		tsm_dev = tsm->tsm_dev;
> +	else if (tsm_dev != tsm->tsm_dev)
> +		return;
> +
> +	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev))
> +		pci_tsm_disconnect(pdev);
> +	else
> +		pci_tsm_fn_exit(pdev);
> +}
> +
> +void pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	__pci_tsm_destroy(pdev, NULL);
> +}
> +
> +void pci_tsm_init(struct pci_dev *pdev)
> +{
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +
> +	/*
> +	 * Subfunctions are either probed synchronous with connect() or later
> +	 * when either the SR-IOV configuration is changed, or, unlikely,
> +	 * connect() raced initial bus scanning.
> +	 */
> +	if (pdev->tsm)
> +		return;
> +
> +	if (pci_tsm_link_count) {
> +		struct pci_dev *dsm = find_dsm_dev(pdev);
> +
> +		if (!dsm)
> +			return;
> +
> +		/*
> +		 * The only path to init a Device Security Manager capable
> +		 * device is via connect().
> +		 */
> +		if (!dsm->tsm)
> +			return;
> +
> +		probe_fn(pdev, dsm);
> +	}
> +}
> +
> +void pci_tsm_unregister(struct tsm_dev *tsm_dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (is_link_tsm(tsm_dev))
> +		pci_tsm_link_count--;
> +	if (is_devsec_tsm(tsm_dev))
> +		pci_tsm_devsec_count--;
> +	for_each_pci_dev_reverse(pdev)
> +		__pci_tsm_destroy(pdev, tsm_dev);
> +}
> +
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
> +			 size_t req_sz, void *resp, size_t resp_sz)
> +{
> +	struct pci_tsm_pf0 *tsm;
> +
> +	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
> +		return -ENXIO;
> +
> +	tsm = to_pci_tsm_pf0(pdev->tsm);
> +	if (!tsm->doe_mb)
> +		return -ENXIO;
> +
> +	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
> +		       resp, resp_sz);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index a64b776642cf..4499803cf20d 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -9,15 +9,18 @@
>   #include <linux/device.h>
>   #include <linux/module.h>
>   #include <linux/cleanup.h>
> +#include <linux/pci-tsm.h>
>   
>   static struct class *tsm_class;
>   static DECLARE_RWSEM(tsm_rwsem);
>   static DEFINE_IDR(tsm_idr);
>   
> -struct tsm_dev {
> -	struct device dev;
> -	int id;
> -};
> +/* Caller responsible for ensuring it does not race tsm_dev unregistration */
> +struct tsm_dev *find_tsm_dev(int id)
> +{
> +	guard(rcu)();
> +	return idr_find(&tsm_idr, id);
> +}
>   
>   static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>   {
> @@ -42,6 +45,28 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>   	return no_free_ptr(tsm_dev);
>   }
>   
> +static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> +						 struct pci_tsm_ops *pci_ops)
> +{
> +	int rc;
> +
> +	if (!pci_ops)
> +		return tsm_dev;
> +
> +	tsm_dev->pci_ops = pci_ops;
> +	rc = pci_tsm_register(tsm_dev);
> +	if (rc) {
> +		dev_err(tsm_dev->dev.parent,
> +			"PCI/TSM registration failure: %d\n", rc);
> +		device_unregister(&tsm_dev->dev);
> +		return ERR_PTR(rc);
> +	}
> +
> +	/* Notify TSM userspace that PCI/TSM operations are now possible */
> +	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
> +	return tsm_dev;
> +}
> +
>   static void put_tsm_dev(struct tsm_dev *tsm_dev)
>   {
>   	if (!IS_ERR_OR_NULL(tsm_dev))
> @@ -51,7 +76,7 @@ static void put_tsm_dev(struct tsm_dev *tsm_dev)
>   DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
>   	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
>   
> -struct tsm_dev *tsm_register(struct device *parent)
> +struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
>   {
>   	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
>   	struct device *dev;
> @@ -69,12 +94,14 @@ struct tsm_dev *tsm_register(struct device *parent)
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> -	return no_free_ptr(tsm_dev);
> +	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
>   }
>   EXPORT_SYMBOL_GPL(tsm_register);
>   
>   void tsm_unregister(struct tsm_dev *tsm_dev)
>   {
> +	if (tsm_dev->pci_ops)
> +		pci_tsm_unregister(tsm_dev);
>   	device_unregister(&tsm_dev->dev);
>   }
>   EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06285f3a24df..ebf6988666eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26103,8 +26103,10 @@ L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
>   F:	Documentation/driver-api/coco/
> +F:	Documentation/driver-api/pci/tsm.rst
> +F:	drivers/pci/tsm.c
>   F:	drivers/virt/coco/guest/
> -F:	include/linux/tsm*.h
> +F:	include/linux/*tsm*.h
>   F:	samples/tsm-mr/
>   
>   TRUSTED SERVICES TEE DRIVER

-- 
Alexey


