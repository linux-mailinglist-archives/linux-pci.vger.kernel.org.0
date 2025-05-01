Return-Path: <linux-pci+bounces-27077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35B1AA6503
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 23:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461414A6630
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 21:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481825EF8E;
	Thu,  1 May 2025 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FFyuonpn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210BA22156A;
	Thu,  1 May 2025 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746133255; cv=fail; b=WQGA0PYmdspwObJ1cy5sPQoK+jqR9uPDLKPxNvKODLvLGjUMIr4af2v3OGEppQpW9/7qnmBaJ2npGUXkw77GGSmxSoxZRk1VLrItP/vFbJm7SYxbKj1Y1rbDM4kxYW+4LQqbKPoU+lfb8wgxKCGS7iIflhx7iOfFWqH5SXq0iKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746133255; c=relaxed/simple;
	bh=WkcS294b/ii9ogtIIvfXG+zRm4VFxC57Bb2QYwS4VhA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/wsFNnb5ZSWQvZwwNS72OHg+hP9U5TdUgSo17CCsdeRY68G9Cku4BRJrnvVj4mOwJA6f+7JFhs+xQbwrwJjRppvlM//7LBgWQj3pGNUmvZmzEj0ek5gJZ/2tbjHRGNnAh19HN+W9Twp47mwaWnhATxA5Gjdgbzkdy9PCEDHj0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FFyuonpn; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSVnlG2XLDb8ZKm8WLnoNeBiaSj0ybZvkJbEqN5Hcv+AiaWlaxQoeusUUmhh7qByXF/qRlvdjH1ql5UZTXJUlirYqLE6nXT/dhmYbnREQkJzu68wjzVXTeUTJbjmYW5ZwSiDXE5nYkjqcbghD6VU3kawozZnezycvpl6xBy5ynjz3W+4/1cKU/wFgx83QYAzmDJ1a6NUg6FlKKt8KtdL6VxQMRaVZl4Pue5czrP1lbrYooaF2KPdQe9r8ksJOOTbLuEQb364twCXodhZevFnctkiGDBj5bSDgzBUR/YCoe1B/hCzI982UI+NnUDdbPQ6lGzkm/ZfzNL9Z6ZfPZpwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf1hc8ioBso5skW4fRWXvtd1yoWmPw6vdoxPFdArIDY=;
 b=y4nezt1RiJhpMGtSBYi66cUCzwxn4dWzNfkz9pCId1UPz5rvCgADVwBWDnZJlHblH5tSLxQaADubWja7WoZXPXiFHoG6ttbUSk3sF6eWLkcLn2+PTw7ZLqI1Kto8Aan9AQUw7GuP+ABxurQLYLO7vpkR7vnSVciaRXUJhHMq5o0u3jmKpTIu8ADueiUF+PJTjt+Hv0JZCsjtqjwGjNNQEId2XKaN0nANTrrpx9eKmyXsrYldef7UH2T/fxWb20Gpryx/MD3PjGeTzDZhz9RuIzFHKZA0EKG5Gap+EbV2WvhxuvpGfh83s86K8dAssxJSaQGL+nPGue+yh1MUIy13Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf1hc8ioBso5skW4fRWXvtd1yoWmPw6vdoxPFdArIDY=;
 b=FFyuonpnn9Dd4akRAYN+OoX+2hYUoufDaMh2PfRff0VuSYxz8mqqKrSHmPy++/W15Morn0oTObDAOtuB+ZOJ+OwxVoAJ08svJRRiFo0d7/mzq+M6jNiHXCf4ZPjQ+8A+3L4WUhIEgqPsucgLn3J9qpuWNtjbqolDGcD8PgyKYlog+QMIxgGLQ42oMFyI9BgG0MtFQSo57NmxpOtPceOdINlyMuYJ7ILg8Ai7hzY5floe+Q6V4HwDqlsObLJ5vueTvUoun26beaLiCwmyHiSiWCuaWuzB/C90GGJ+zMGUXIZpyuJrChC6oPRd+Ik5Sn2AUEOnhjVz1NZMvbqxZLGnAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 21:00:49 +0000
Received: from BL3PR12MB6643.namprd12.prod.outlook.com
 ([fe80::4c5a:f9d8:3aa4:4d2f]) by BL3PR12MB6643.namprd12.prod.outlook.com
 ([fe80::4c5a:f9d8:3aa4:4d2f%5]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 21:00:48 +0000
Message-ID: <5b74482c-38c3-4720-81b8-67c599184e39@nvidia.com>
Date: Thu, 1 May 2025 14:00:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 rc] iommu: Skip PASID validation for devices without
 PASID capability
To: Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, jgg@nvidia.com,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250430025426.976139-1-tdave@nvidia.com>
 <85cab331-d19b-4cd7-83cb-02def31c71ac@amd.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <85cab331-d19b-4cd7-83cb-02def31c71ac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::25) To BL3PR12MB6643.namprd12.prod.outlook.com
 (2603:10b6:208:38f::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6643:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 152f886d-912c-47bf-b63d-08dd88f33fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnJac0pueElYcm96dmZKQXlCeCtUeXZTdXd2ZFVWLzl3WHdPUU13a0JpanUv?=
 =?utf-8?B?L2RMV0RQSDRrdzRkakNNYmt2d1lhVUJwdEFnM01FWXJOZnZzUWhRS2lsZEZi?=
 =?utf-8?B?WVUrWHJ3aHhxcWQ2Y3F1UkdISndzZys1Z1ZBMis4eHRUUWtMUEwweVRPMkxI?=
 =?utf-8?B?UGIvZXFHZE9RVEZWMmFjSzBsTERqMWpHOVJ2TkZrRXNXUk13elhlQnJaVkk5?=
 =?utf-8?B?Z3g1UmdKczB4Vk45YmhTM3FvT204dDh3cmdYRnA3QjFQTE96R21UVlR1YXFO?=
 =?utf-8?B?ODBzQzY5ODIxWkI0Um8rcFNhVHBGdWgxZ0U4SytKbzhwMTNuTm9mUHNzVjZG?=
 =?utf-8?B?N0lyS2hzbXdZNEZiYkMwcVRiQmhIc2grY21tSXM0c0lxMkZpMVdWeC81UXVS?=
 =?utf-8?B?TFM5ZkdocGxRZjVMbVc4dFBiekM0a2padGh6Z2J6UEVzU3lWUlB6b3hldHdK?=
 =?utf-8?B?MTNVSWtKU21naWUvNmw2RDJRTE15bTlVSzFFS09Md3dkVmxvV2trU01Qbzh3?=
 =?utf-8?B?OElXUVI3NmNsUms3ZFQzaXVMRjBwZllMM0U0dFA3UVRoOVlSWHNydG1nSDQ1?=
 =?utf-8?B?WnRrbGFZanQyYmdIRFZXSGViS1IxYUxTeERrUEVhOUJFVWxKbHgrOXFXWURi?=
 =?utf-8?B?M3pNV3dEeEdZUldhNmNtRFJ6UThJenh5MlU1enB4V1htTjZPaEppdmtBaTVp?=
 =?utf-8?B?MXBTdVlTekM0Rlg1WTViNWdybm5XS2pNWDNhWGdqU1VoNTlWNXprNzh5MXR6?=
 =?utf-8?B?L09TL0xTSFVOd0wraFFENHFqLysvWW9wMHZjV09nbTlKZEh0a3djSzVJMjdT?=
 =?utf-8?B?OGZHRjlQTEZaTkxucjR2NVFHSkQrclV1UVJmRWY3TW5uSHRiUHRWU0ttdU5m?=
 =?utf-8?B?RGxOd3RZdXJhdUd1NWV1ZE91TEVtR1dCNWE5N3FCUWZ0NlRjVGlneGkrNUVt?=
 =?utf-8?B?NmZLZmprbkxURGJhMStaWDIrMzk2TkFlNkVIS0k5eStWWVJOU3M2NVRONzdY?=
 =?utf-8?B?TVM0ZU1VQ3pZUTJJSFFWMjNxR3B3akVIcVgwVFh5RmsvTnM2STQ5bFdmdSt2?=
 =?utf-8?B?VmhRR1JsOHVaU2tROGNweXN3UUxDKzVFQ0M0L2dSL2U5RXRGa1hERVBVcjRR?=
 =?utf-8?B?RnlMM2RDUUFON3VySTQyZ1UvMXdzQ3ZzcklmSXhhalM3SDZicW9kbnExcnhP?=
 =?utf-8?B?QVFVQVlkbUpOL2ppRU5HM3lZOGIxL0ZYdGwyTGtGTFBxMjZzaWpQWE9WNWk3?=
 =?utf-8?B?US95UndodXZ3eEN0MkZXM2h5N0puS3N0aDBxNEgwdGllZGxhNWs5M3ZTVVY2?=
 =?utf-8?B?RStTRk1ua2FtMjNpemIyd1pManFNaERSNE9sem9GTjNsRGw1T0VzOEU4clhI?=
 =?utf-8?B?T3hoOTBZRytZZzdyWUIrblVtY09sZ1R4STYyaE01ZnN2QWJ4aGRrd3p3OE95?=
 =?utf-8?B?dWcxVGcvNTh4d1p3aU11bU1SWTRRNmRWMnk2UVZDekw4WG5hWnFrZWMwUTM1?=
 =?utf-8?B?VWhKYTlxelZHZ3RKUEhNM1JGZCs0ZExIUTZVeCs0U0lrZGtKbFl5SExzU2tj?=
 =?utf-8?B?UCtBaXM4ZnRyRGhOWmlzVmZQaDI5YXRxTWx4MW9pajZqRW8zRkdYcTI0M2xH?=
 =?utf-8?B?bklWSnJTaWkrY1dyVXNvREE2Y0JiSnU3L250Q1RzcDdpOFJzQ2R1dG1welVk?=
 =?utf-8?B?ZWxINzErRy9sUXh5TlRyVGlNWHY0Y0UvazFvZDZoWFI3NnYycGZCMmh4K3hp?=
 =?utf-8?B?bkVnWEt2bjZvOFJFRzhYdTFzN2NjaEppNEc1R0V1Z1F2akd5WHg0KzIzeHEr?=
 =?utf-8?B?QzY5Y0kzZCtjVWc1OVNmdEU1VEJSVUxyVVovMFV0Tzk5V1g2U2VZUmh3ald5?=
 =?utf-8?B?RVhNZnNjMUNQL3puOE11dzJ5K0Z4QWxldFJENVVYTmd1R2EwVllVemNXcnVX?=
 =?utf-8?Q?YtFhjK7Uvdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6643.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlNyNDdRVkZad3d0M21iSlZXY2Y2clBsN0RRalkraysyUWZGNFJCQ3dab2t3?=
 =?utf-8?B?Y0l0eGVlL1ZEOVNZSjBjN3k0eHVvc2xDVkMvM1NLdUxYVDNOeS9jSHhyendI?=
 =?utf-8?B?WmxoOFFZKzFWbEdWMFd3ZGRpeGhORzIzRmNmdzlUZ3FScUpMRjFyblovVDlN?=
 =?utf-8?B?c2pZaVdLa0ZWcWl4NmVtLzJqOENVanpHNENVN0dQTHpOZDNIUTJVazUzYU5C?=
 =?utf-8?B?ZVVlV1NFRHF5b0FhQ05KOGR3eGQycS90NlpPNTNMWStUQURKY25OZFhPTDAx?=
 =?utf-8?B?MTcyaEhjajU5N0N2YXNLUWNTYkdMbERYV0Z2SXQxdHBzT2pYNFpBclBjRkdZ?=
 =?utf-8?B?VnlFZU55OWdSMjVBTG9WaWlsWUp1cXkvYktLOU5YNnVqcW5HZEEwd1dWUE1H?=
 =?utf-8?B?ZzR2LzF1TFU3RTRFclVCaXllRVZBTXdRaVZaQTFzdlE0clNEeENVWTNDMDQy?=
 =?utf-8?B?UDc4Yklac3NULy81SEtMRXE1azJKTGc1UytwVjdja3NzdVRxTGtCYTZjNXds?=
 =?utf-8?B?NmZQOVR1dWpBeitpWEpmZXlGMVpNZlpEQ2RLMVA0ZVkrZDZOUU4xOUg4M0tO?=
 =?utf-8?B?UXlxTHA2cGFiMjhuUHZFeDNERC9oZ2FHUFhaUnZUTGZxY0JFWlFVNk1OS2M2?=
 =?utf-8?B?Y1B6aXBoRnovQjgrdmJwdDZPRjdMSlJIemI0L0l0OG5HeGlyNFFMUkNwQ2Uz?=
 =?utf-8?B?TlowZjJPNnJGVnVKZ016ZHA3b2p2ZUI5bTk5Ulk0UXVVNnI0Y1Y4TlpMejJ5?=
 =?utf-8?B?bWN4eXlvaHhOS1JJTW1CaTFBQ0RZVG9GclFKWVlTMlEyRzh3Rm5qVFJpSE5Z?=
 =?utf-8?B?QW00QzVYd3BJWlg5cm5ma2tsUEJ4U3IySThPcCtwcTJ2bnpLZXU4K0pmazdI?=
 =?utf-8?B?UUZvK1JnRUd3SlRNd1U0ak5yeFR0Qno5bWFUb1dpMVJlYWd2WHFILzJSZXNn?=
 =?utf-8?B?VFVEZ2k1MXZyUnNERTRXK2RONjh0eThEOG0wbW1VUW5MYkZmYTZFbE10b0Jl?=
 =?utf-8?B?cys1UUtxMWtUOGluVXZETHNLTUQ1QnlFOFRqVm9QY1E1ME1Rb0FreTBoZW9r?=
 =?utf-8?B?ZnAyVGhCTk1VWHArWjl0Rm9QWExKL1VqQytUaWJPYWJ3cW5LTW1Gb212a1Vw?=
 =?utf-8?B?RFhqbCsrNk5yN2hHRlVIajIwcnBldFB1OFgvZ1FsUElyQTNMMG5aU3JmVlMx?=
 =?utf-8?B?dUN0bThYRkptOU1Ga2ZZYXNTa0dWbXh2RmFEaE02WVNtTG9pUGNRc21heVhI?=
 =?utf-8?B?SmFNQlFubGFJU25sVXMzSS95R2RNMnJBQW5aQ2FKcDBaZ3VHbTE3bzdmVm9Z?=
 =?utf-8?B?QVN6RU9YdTd6RWlKY1hmSkx4UGlhWjdxVWhnRHFBa1d6Qjd4NXFuZ0VaRGZ5?=
 =?utf-8?B?NnJ3WXR4aHFHNHFPaXE0K2FPTFhzbm9lWlQzbFNJK3R3OE1GamFobkJkSDBT?=
 =?utf-8?B?UG5GaFJ3aFhOSUc1UGFadUpwcDI5T3djakkrUTNra1U3aEtrRkxNdkQzb1Jl?=
 =?utf-8?B?T1NyKzlXSDllL0RkdFNWb2JnS2V5Z1NMUVRmT0NaM2FGYXpjeXBlMnRmclRH?=
 =?utf-8?B?VHRmUFBLMUQwR0c1L2o5UUNRakVhMC9zeTR5K1YyTjdWdTEzTzZ3eUpCUFFL?=
 =?utf-8?B?aFhkSWRZZUY3a0Izc1g5a3JWTkM5L2lKcXprVGI1cmhYcjZTNUlWZWdnY3R3?=
 =?utf-8?B?cHNiVjRndEZjbjJhdGY2TGxzTklEVzhRR2hvamh2T2lRSmlrNHlVUG5HTWxF?=
 =?utf-8?B?NXNSSDJ2SlBjeUhPbU15ZE5RQlNGOGVDMEIzT0J1cVU2SlRJRDVhSTMwWTRF?=
 =?utf-8?B?cHo4cGVDcW9LMEhPSDNtWWVXVnFqUUtoa0pXelJDZTJIMmZlWEMzRUt1Z3dR?=
 =?utf-8?B?aFhtVkpQS0YvZG5XNjFhYjF4MVNnQmlRWFI2UWN2b3ppemRsTndKTEpQakxj?=
 =?utf-8?B?TzVVenhLdmhVOElFOWRxOUN5WlFkWlA0K05FcmtQSTkrSjg3Rlcwc1BuZFZl?=
 =?utf-8?B?a2NYVHJPcUtWZHoyNU14V0JyTldiY0ZaRC9qR3NsWlIvVDlESmlKZlFHenNS?=
 =?utf-8?B?ajNsTmJqcjlCc2xMNVZsbzlGUnNTRG44V2J1cE01cHN0UC9NRzNQT1BBSlNM?=
 =?utf-8?Q?PrIchm6rMJNVw2qR+Ko1MLysS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152f886d-912c-47bf-b63d-08dd88f33fdb
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6643.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 21:00:48.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rp3yx4pkIt37gU9ex9aYm68UTkX1rN6UHZT/H+th1JkBvJ2wIVV26pVgaIYBOSmSXuij4eMFgMZH0Ulgw4PTOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723



On 5/1/25 03:58, Vasant Hegde wrote:
> On 4/30/2025 8:24 AM, Tushar Dave wrote:
>> Generally PASID support requires ACS settings that usually create
>> single device groups, but there are some niche cases where we can get
>> multi-device groups and still have working PASID support. The primary
>> issue is that PCI switches are not required to treat PASID tagged TLPs
>> specially so appropriate ACS settings are required to route all TLPs to
>> the host bridge if PASID is going to work properly.
>>
>> pci_enable_pasid() does check that each device that will use PASID has
>> the proper ACS settings to achieve this routing.
>>
>> However, no-PASID devices can be combined with PASID capable devices
>> within the same topology using non-uniform ACS settings. In this case
>> the no-PASID devices may not have strict route to host ACS flags and
>> end up being grouped with the PASID devices.
>>
>> This configuration fails to allow use of the PASID within the iommu
>> core code which wrongly checks if the no-PASID device supports PASID.
>>
>> Fix this by ignoring no-PASID devices during the PASID validation. They
>> will never issue a PASID TLP anyhow so they can be ignored.
>>
>> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>
>> changes in v2:
>> - added no-pasid check in __iommu_set_group_pasid and __iommu_remove_group_pasid
>>
>>   drivers/iommu/iommu.c | 22 ++++++++++++++++------
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 60aed01e54f2..8251b07f4022 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3329,8 +3329,9 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>>   	int ret;
> 
> initialize ret to zero?

Thanks Vasant.

How about:

         for_each_group_device(group, device) {
-               ret = domain->ops->set_dev_pasid(domain, device->dev,
-                                                pasid, NULL);
-               if (ret)
-                       goto err_revert;
+               if (device->dev->iommu->max_pasids > 0) {
+                       ret = domain->ops->set_dev_pasid(domain, device->dev,
+                                                        pasid, NULL);
+                       if (ret)
+                               goto err_revert;
+               }
         }

Let me know.

-Tushar

> 
> -Vasant
> 
>>   
>>   	for_each_group_device(group, device) {
>> -		ret = domain->ops->set_dev_pasid(domain, device->dev,
>> -						 pasid, NULL);
>> +		if (device->dev->iommu->max_pasids > 0)
>> +			ret = domain->ops->set_dev_pasid(domain, device->dev,
>> +							 pasid, NULL);
>>   		if (ret)
>>   			goto err_revert;
>>   	}
>> @@ -3342,7 +3343,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>>   	for_each_group_device(group, device) {
>>   		if (device == last_gdev)
>>   			break;
>> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +		if (device->dev->iommu->max_pasids > 0)
>> +			iommu_remove_dev_pasid(device->dev, pasid, domain);
>>   	}
>>   	return ret;
>>   }
>> @@ -3353,8 +3355,10 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>>   {
>>   	struct group_device *device;
>>   
>> -	for_each_group_device(group, device)
>> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +	for_each_group_device(group, device) {
>> +		if (device->dev->iommu->max_pasids > 0)
>> +			iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +	}
>>   }
>>   
>>   /*
>> @@ -3391,7 +3395,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   
>>   	mutex_lock(&group->mutex);
>>   	for_each_group_device(group, device) {
>> -		if (pasid >= device->dev->iommu->max_pasids) {
>> +		/*
>> +		 * Skip PASID validation for devices without PASID support
>> +		 * (max_pasids = 0). These devices cannot issue transactions
>> +		 * with PASID, so they don't affect group's PASID usage.
>> +		 */
>> +		if ((device->dev->iommu->max_pasids > 0) &&
>> +		    (pasid >= device->dev->iommu->max_pasids)) {
>>   			ret = -EINVAL;
>>   			goto out_unlock;
>>   		}
> 

