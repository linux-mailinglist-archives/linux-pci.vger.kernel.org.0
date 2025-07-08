Return-Path: <linux-pci+bounces-31652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48580AFC266
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 08:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4D31AA57CA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 06:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0D79461;
	Tue,  8 Jul 2025 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bM85CeVs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E15383;
	Tue,  8 Jul 2025 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954749; cv=fail; b=fQ/bitaETCygP7ONVgzrC+mAfbF3RnTMIMYbByImosX1dZxbyln8gtkDJ0GHaPX2jQwoL+NCoS6Ya+PJqZVivHFYUpZahKT4oeb2e3EyLx3Yx5r8JeCZTXU+2cWEaFcmfpfRpnutFSnNmJJzdVIPy63BbZBAvnLIABpwI8EujPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954749; c=relaxed/simple;
	bh=BoRoc5FK9gup65uqMQ1i1J0odnoRaSTa2KrJTpB5K+I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aoITlizA2EuYh3WK724rDuWf5/feWULkz+7adGaSJ0FV5yOcXxmnhpLdVXMt3n0LYECG22JaTcT9Hp2VHrOojXyb9N+C6cw5xEkPJoPfQ9hGt/uEgNJ8Qv89hIiKj2TgyFSHD/kb5mpX8UGnA8D5Gbh3eoszJYpIuLT/hI4mJLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bM85CeVs; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWwWmFGepl4DydmXiqW0IIk8wUHBaN5OkXsR5bayWYPT/M4yMZSCSC5bPbSMClUYvrIPpKC4EGdJveN+Cvovnq9Nlt3mGUOlDVBdyDG1RzwVx4S/C/AxhL1UaANQAvJC6fOqhZ/bZ/R/TR4v0cVsEYX5odWJDXXmDsMqR7bx06RRDYMVMSRBudde8XE1EleanrwFOZ3UbSz94nBfebC0kmWMpGGy2qDJcu6kHoJJ+rODIUSlNSM2T9usuW4ahoBUW9fk4RUlYgkhFQPcv3jq+AeYkZEnGZNWXOtLZc3PPYmcaC7g2aCBKvuuqMEaEUJ8WDxPZP8wngIsISKLvznHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEmJohHd+pRDcujK//pUjCZ07vnF2nODQv1chdSJluw=;
 b=iSHQmkdApwhv6HLGRO1GzuzgZfQ1T4zIkyR3MtmsD3Hzs5lkIvPExH7nbpaZbFAEK8INskFg8gP/pDV9gXPW11iFSa7MZU2dOjAI3fHowwZBupo+e2lr8kNbf+Pq0YCORkJg1EiOUd3i/Kr8p8UVl5UWxpFKrfmjsijcAE7n87Ii15qY5A2jkdzV8taZTXdTEjVh2kqr3tWm/Qi3no18ZlQYlsimYMx7X+YCjNKwRDtu6+W9kxbo1g146bbgTtEUXKqi4IpyvbUJvhInJm4DhqOUdR7GVCBgwtegcRTMUEqmym/r1uS5gCXh3r74mp2uqqXpkO5iqHDNGCEsS7X3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEmJohHd+pRDcujK//pUjCZ07vnF2nODQv1chdSJluw=;
 b=bM85CeVsah9OifQtCzDbCrTonYPmDl8Gl71ue+May+5EV4ZqpASArw7j+3UNlK8BxQwDVuVu1U53Mr8ysGGGI5B1uqP86O8c6Fr0sYXmFI56ltL7zWAZQuds8f0znBdC1GUfwnCYzDYFbLoWZMRwUsn2K8rBdHHLxABNcu08Vis2nWDVdjnzYTcHwQ+G3fuVLq8w8IxJIvrqCXmGlFpBOVNavnI21Oj2KmOKmj6HTcs5vRK/C817pt9DEqFIzMyVxexvt38JoGLqFOxM+0Il/vP0gSMVi77AKu7Vts7eTnwAKLSmJjfGNOA3yeBtkPGgKQEFspRxNcnY4wLULoAyXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Tue, 8 Jul 2025 06:05:42 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 06:05:42 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: Add dma_set_mask() and dma_set_coherent_mask() bindings
Date: Tue,  8 Jul 2025 16:04:50 +1000
Message-ID: <20250708060451.398323-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5PR01CA0071.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 636f8ab3-c11c-4049-7db5-08ddbde57808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmVUTlNNOUQ0S0hMbDhaNGdBanJ6bnVxRE9wdUQzRkpLRitWS2tBeUkrT0gz?=
 =?utf-8?B?cmZKTUlxOFo2Ym5VbC9tVFdGNGplWGZOemQrK1pjU09tM2JralJkTGFlSzFz?=
 =?utf-8?B?aWJYTU84ckM2YnlPSXQ4V2tKSjBDbXUzYUQyall4RXJuS29OR3pyL3ZHa0NJ?=
 =?utf-8?B?QlFBUWhVcXI5UXhuV3dZckppUzVhMUZkeWJEU3NsK0xTNEdCWWdVc0dyMXlL?=
 =?utf-8?B?cmxIbE9nZysyWU5ianNOdlp3OEd3SFNsdldpRVQrSDRJekpkclBrbURGVEZW?=
 =?utf-8?B?UHZvNjdMcUZobERHcXZWcXN2N2hJeC9iVUlOTkxyL3hxUzRCQ212ckxUT3Rv?=
 =?utf-8?B?eUNsZmt0ZnJuZ0tMZHg5NVdUUE5HenE5MU9TYVp4dkZMZ2lPR3JiUWJrOFhW?=
 =?utf-8?B?OXZDa1MvQ24zWVFyWEsyVmRFU1dRNHNTbm1TK1N6ZjN4SjN2L0ZldW1zditr?=
 =?utf-8?B?elcraXZudSt5anlDNk5xa0UwUFhqZ1BmRlVuUzB3Kzg3b2pWTEd1Mk82Q1VZ?=
 =?utf-8?B?T0Q2NFVqT1N5SUpmcjJCWXRZNUwzb29nck9RT293cmdGWWhSS0lDTGxHTXhK?=
 =?utf-8?B?eDRXZGU4ajg3dHROQ3ZaTUloTE5UTjhXVGwrVXhNWmFtTnMwQ2RWTnZLRmdE?=
 =?utf-8?B?UDh6bXFqaG9Vb2FjT3p4d3Rxb3B5cU5pMXVhdUtwWnZxVmhtajVmSHNpbmJI?=
 =?utf-8?B?QlVScTVlYWRxMEt6K2Z0UjE4SzhJTnhHNVJQaUZUalJacFlYbmlIb1AvUUFn?=
 =?utf-8?B?K1R1NFNnYXdsbnFKY0RHeDZ3UFZzSFBMOXgxTVlOdXVXZ1ZhRmhPUGFPMzFW?=
 =?utf-8?B?WGxOdHhXVG1OZldleWE1QTlLdndWa003L3RtL0d5eHc0a3QvWllMZUNCMDMz?=
 =?utf-8?B?dXQzZFdiWkdacDhTYnAzMHB4VGh5c3N1Y0NpRjlUSVJVM3dqcjJwRS9VRWpz?=
 =?utf-8?B?K0x0cVRaSGRKeWhUZlhEVjBoMlMwNzRKNzlBSkNuR3B6cnhJaHJOK01aaFFH?=
 =?utf-8?B?NTNHNm9nSWhFdE92dnpPckdTUjRMUUxDWlVHajFVejc5T0dkYkR0REVhTFZM?=
 =?utf-8?B?UkZzR3lUdkczOFJIZVUvUnRnRXBCZzd5dHJKa0lkUjcwNG42ZVNGSzYwNmg4?=
 =?utf-8?B?WG1UbEVtSlZManNscWVsL1o4eVBIR2xZcTM4ZWhLSHpmRVhWdUhZMU9kSXg1?=
 =?utf-8?B?aEN2MVlCemJVK1MyeUtFVjB3dWlpN29vQ3FLTkJaMVg2ZDVtNFJKanErUjdr?=
 =?utf-8?B?SWVNeldBaEF6TzZxdEw2M01VTHd6czd5ZlVCbncrV01UcmsxUU50TnR1NHdQ?=
 =?utf-8?B?VXkxdXlxdzVRUzlGbnF5Z2ZiaW9iSTI2aFdsVmdWV2JBY2s2d1FnaTJSLzZL?=
 =?utf-8?B?b0t5ZUVjVUVFeWc0WXhWdi9lQmtOUGdtZVhyQzlBUnFnUG9HTklFSUR0Nkd1?=
 =?utf-8?B?RDhHYkdiZnFrM1JxTnBEdERPZjFDWEhlRGxPMnVuUkFPSDd2THYwbUdZT0hJ?=
 =?utf-8?B?NU1UaFkzRXJEb0t3TkF1dGtwR2dmR041NldNenE4Sjdaelo4UG5kVkN3a3BZ?=
 =?utf-8?B?aWVvdTdScGlBdm5XRVlaYVYzNXl6NDhiL3pJa3hsbUI4aFl4bnRJOVFTY0I3?=
 =?utf-8?B?WlMwUmV6V3BaaG9YUzlYQzlTY21RZVY3QWZCTjR0Umpna1BBdU5uTWQ2RFo1?=
 =?utf-8?B?OFJKUCttTG9BamFvMHZZOWxINGE4ZlB4T2hsT3dnWjgrajFZcDdMSjlOVkhQ?=
 =?utf-8?B?blp0d3g5TS9ab0FVNjR4MURlYlJQNHNISUVES04yYzZzWEZwUStOUWRBSEpV?=
 =?utf-8?B?SENFbWVxbmxxRzErQko4NjM1NW1iekJaSmc5WVRCSHd0ZWVBelhIaHdwMTJ1?=
 =?utf-8?B?VTAxVXJVTEsrMHBUUnQ1aS9DV3orOHpiQ0J1VTc4Q1JhNTZPTW0rcWJBdFVo?=
 =?utf-8?Q?0BigI3f82V8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFpCSHEwVVJuYi9uVHNXem1zZTNNdmZqQi9ISTRtV2RhM0g4NCtwakw3QXdF?=
 =?utf-8?B?Q1dKT05MRDZlZHc0eE9ZcXZhMU00T1NhblRGVUVBK1pReUFiV3J6LzBCZklq?=
 =?utf-8?B?ckZzUmZneVR0cm9wc3R2RWgxbjhVd3l1ZnNwVTA0ckJGcE9iQlFEWEpRQlBm?=
 =?utf-8?B?bGNHMjV0RGtZMTJPbnloamFlZDlDNFU1VHo2eGQ4VzRzMndvQ2JteXJoMlEr?=
 =?utf-8?B?WDJqbllNd0JlbVN3dngwQjl4dzFyM0pibDBVQTBmMW9RU1ptOVhVVkl2VW1l?=
 =?utf-8?B?RFN0OVo0ZXh2UkZ0VUVEdkhpWFptdEs0V0o5azJHR3pFR09kTUpkaDRCMlI2?=
 =?utf-8?B?Q0dJejY5aTNPUm1Md2hwRE05T2g1dDE0SEVRU1gxZER0eS83SGhHNlU4Tnk0?=
 =?utf-8?B?MUkyMFlxZ3ZxRFg3N2pzQUl1UTYxYm5LY0VqQjltU0FzSDFlQnVmdHJtSUJI?=
 =?utf-8?B?bGI4SUdraEJnUnZwSVlpbFhNb1gyRkpST2laUzJYcVdCbGgzVFhQdlUyTng3?=
 =?utf-8?B?dTJ6TEVLVEh3QlJ1V1EySjk1U1FPbDNHWlk5OUsvRTdlaUlSZEVFa2tJZ2hP?=
 =?utf-8?B?d1ZtTDRrVHVmNlMxODNiUUFCV3FpZWQ2YktPb1gwLzRzSzcxMzhwRnU1czF6?=
 =?utf-8?B?SFVyT3Y0M0RCMk5sTGx2U29zL3ZlTlJqaWRzQzdKTEM0d3hTbU5RdmN1Wnkx?=
 =?utf-8?B?WkJBaW1ZbVBTbC85YUMwOVpuZDNCOTI4SmhCV0dhVERxdFZCeG1EbExzV2xs?=
 =?utf-8?B?blhjWnpYQlhoOWVHSEJHWkhUL1k5b2ZFYnFrQm9ualhlUi9oR3hJYU1Kdnhp?=
 =?utf-8?B?WUY2NVI2dFE5SUFxdXQvWVVwRk1ONFg2R1VrcktpdlhydmhRVThPR3pkTCs1?=
 =?utf-8?B?MUVxQzErTHozYlZCRUZCS0tuRmtPOW9mN0xHSXh4ZE43dEpFc2VUWG5NSmJa?=
 =?utf-8?B?ZkZOVzIvOHJtSmlqQ3Z1U3o1Q05odk1mRS9zYmlOT3pEczk3ODBQcGRLVzAx?=
 =?utf-8?B?S2F5S0pkb2J1U3NKQlV1UCtiaXg2SXpqR2cxbWFTT2pPdGtvZFRqMkoyVjBy?=
 =?utf-8?B?cnZwT3NWM0c4TWlydnBzNGcrK3FMYkFRZ3Y0MUgrbUhHM1poU2J1ZWJXeldE?=
 =?utf-8?B?TC83YjJwV25KZ3gweXlPbEkyNEttaEhqYmhPM29zTDQ2cE9wcFNzM3NQakhu?=
 =?utf-8?B?QjRyMGJENDJ2bHE3REgrWW1uOHdyZjE4Wm92OFc2MlNyajJ3UWdrM3RiOUg2?=
 =?utf-8?B?cEppblc4NE1tUzdLTzNHYkdLUmNLaTBmQXB1SVlFK3g3V0kvejAxTEtvY3Rq?=
 =?utf-8?B?TkMxdkRQa3ZKMnU0ZU9EK05PUERvakNlMjdiOU1BMUtQZWZpR1JNTHRmbFIw?=
 =?utf-8?B?WGZDemxpeW9qK3cwTmwycjY0M2FaRFRURVZxN1dMbWlqczZPTVlRSlpyMUNz?=
 =?utf-8?B?K1h4NEJtYzRtN2hCdGZ3LzEvTUpkWFphS0UxWndTRllkMThrVklOVXRvKy9M?=
 =?utf-8?B?Z2o0eHoyZHpQT2I3WDJxdFFNSjM0M0JxazNBQUxiY0dNRXhhaGRXSVJObkdT?=
 =?utf-8?B?dlRrSlFzcFkyU3ovalBHQ2JHTXJOTHF6My9wZE40N2VNb1lhVlVhUndqdWw2?=
 =?utf-8?B?R0JjL0k3VWhSaVVPMXMvNVlyNDZ6VFZOZDhYZUIzUHBMVUhJaTAyRkNBY0dB?=
 =?utf-8?B?akl0ZWQwVGFTeUZ1b2dFd2xHRmE1YlA0clNoRXl0alU5UzV1WkxNRU5qbS9E?=
 =?utf-8?B?QzhUcHFsZXhzQlF0akUzaE5SbEdQUXp6Z0t2WlhQM01DdzRpaGpWNzRyeHBC?=
 =?utf-8?B?YVdhWFZmUFlJb2FYS1F3NTdnRFNKWHNlYWk1TmlXTFpFMi9ZZDY3U3k1dHc4?=
 =?utf-8?B?cGFXZEJTQnU3SkZ0QURmMnNPMndTd3JWbURKKzVLRlR5Mzc4M1I1K0pMNHJV?=
 =?utf-8?B?OVJlTkJsSkhlRGFLTk5YZzk0Q0hYVzRxQXFVcHlTWFQ5Wm5vWitLQjR4dzFB?=
 =?utf-8?B?SjhrNXMycTZncnQwcTNUOTFOaWtPbjNyTmtCQ2NmdnFHUS8rbkJaV0RXbUhI?=
 =?utf-8?B?MUlYazIzeXVOZDFHZWJmVzBjS012ZDBDeWozNGJBZDl5U05JTjBGdFgydTk4?=
 =?utf-8?Q?h0e6QtojLPgV/2GckbpkpL/c2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636f8ab3-c11c-4049-7db5-08ddbde57808
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 06:05:42.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EJdQBencR29DzfCG8RFRrCMPkaF+BTSJcX5SBIPaeaBVYbblzC43SLDKIv6ASq+FRZ8ivwgANcdCV48cDRXUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

Add bindings to allow setting the DMA masks for both a generic device
and a PCI device.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: "Björn Roy Baron" <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 rust/kernel/device.rs | 25 +++++++++++++++++++++++++
 rust/kernel/pci.rs    | 23 +++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index dea06b79ecb5..77a1293a1c82 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -10,6 +10,7 @@
     types::{ARef, Opaque},
 };
 use core::{fmt, marker::PhantomData, ptr};
+use kernel::prelude::*;
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -67,6 +68,30 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
         self.0.get()
     }
 
+    /// Sets the DMA mask for the device.
+    pub fn dma_set_mask(&self, mask: u64) -> Result {
+        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        let ret = unsafe { bindings::dma_set_mask(&(*self.as_raw()) as *const _ as *mut _, mask) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Sets the coherent DMA mask for the device.
+    pub fn dma_set_coherent_mask(&self, mask: u64) -> Result {
+        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        let ret = unsafe {
+            bindings::dma_set_coherent_mask(&(*self.as_raw()) as *const _ as *mut _, mask)
+        };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
     /// Returns a reference to the parent device, if any.
     #[cfg_attr(not(CONFIG_AUXILIARY_BUS), expect(dead_code))]
     pub(crate) fn parent(&self) -> Option<&Self> {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e38..7f640ba8f19c 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -369,6 +369,17 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
     }
 }
 
+impl<'a, Ctx: device::DeviceContext> From<&'a kernel::pci::Device<Ctx>>
+    for &'a device::Device<Ctx>
+{
+    fn from(pdev: &kernel::pci::Device<Ctx>) -> &device::Device<Ctx> {
+        // SAFETY: The returned reference has the same lifetime as the
+        // pci::Device which holds a reference on the underlying device
+        // pointer.
+        unsafe { device::Device::as_ref(&(*pdev.as_raw()).dev as *const _ as *mut _) }
+    }
+}
+
 impl Device {
     /// Returns the PCI vendor ID.
     pub fn vendor_id(&self) -> u16 {
@@ -393,6 +404,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
+
+    /// Set the DMA mask for PCI device.
+    pub fn dma_set_mask(&self, mask: u64) -> Result {
+        let dev: &device::Device = self.into();
+        dev.dma_set_mask(mask)
+    }
+
+    /// Set the coherent DMA mask for the PCI device.
+    pub fn dma_set_coherent_mask(&self, mask: u64) -> Result {
+        let dev: &device::Device = self.into();
+        dev.dma_set_coherent_mask(mask)
+    }
 }
 
 impl Device<device::Bound> {
-- 
2.47.2


