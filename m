Return-Path: <linux-pci+bounces-33408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02383B1AC14
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 03:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438EE7A65BD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 01:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2901AA1D5;
	Tue,  5 Aug 2025 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qj3PbdHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933919C553;
	Tue,  5 Aug 2025 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357360; cv=fail; b=QJrtiJ4q4ucI822PKPo1xm8GASM+trjkuZDfmSNvFgHplZuSr4cL3/AG1RJc2jtiiuCBFJ6ZozEBEjjUpv1NnSVcHMDFMem6l352qwneUYJ1Cv3sI2xliIOp4q5olgySoq+KF67rMAnHYh2zEAbIQHd8jqE4b+4gBqUL1N45igA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357360; c=relaxed/simple;
	bh=puxvDgBieMGfXRvyK+y6sjf0TxssXYehxYyoHEtOm2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LjgHfuqBt11FclNY+SNtBpb0PGpZOhscR5mK37519T6gLfVI1pRpDUQt5OTPfXD5Ad2+gc1EN0iRH70k2AxHSaukCxZp7ko3wDFFEZrf8vRcUjrU0QF3zBQjhquDjn4DTR8y2H5EL+UMyGcYdILwXDwb9XDGgAOlCAGqlzYu56U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qj3PbdHZ; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/pxLDyzruWK0eCascr9aOUfIBWDAyIXZRoYAdDdFxlyoc2f8HgzFh2JdWznYwsBAakWqXq5C96rbs5t7b2JAGe2bvdTn5DLUXga811SGyd1X53LAomFXsNTDfqxydwsVWkKroLNPpk2MnXZZvXAmmpp89m+hQo922o0nby4r+n3TT94HEFWVaNoRHdPl2SmjGpCjmf05ovD3I0Y/jpShSzPhTqSWoOU6V2P/Btt42lAg7T8loPupwZzGAb+AQFLCb46GKMm0U+uwaxTpMCDVuAjzOWAZ53qyZGUmGR2A2GMbzJoMkRVmQ4J3gCPlerPPT5njDdiefStF5oDLSWdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS03Zt79KmcMCL0e9lWI2jL6tRHK/fDxspMb3/moLs4=;
 b=qZeLUxzZfpTSNhnVniHBsgvSrMS4BCUiWP7bN4pkyH0Y1hJhZEib/wknwg7XR76WNWqOhRBqmzVBkMP2taMq9xlC7smMP/jPR7F1Dj0kHRTxUFVL70k0YAbxmKFDPu88bdm85O5lQ9Y1VvOmwWBhXN04tDLm7zAoOgPvi6xrIm1VJq0Pt3b1NO4JvK1pmfaNLU2Ja4e5npP73eY0HfFeRPjL9429JemRcC9ookZbV+HFqPMtElHaeEBOONrg8RjUgUfC0ViMHBPowbnPQiirDfGR+VMVook0JsMHwCyJqn5br/ToRcLjJZuCkaFHlhaKs+bZjTRw6GbIxz95+HBaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS03Zt79KmcMCL0e9lWI2jL6tRHK/fDxspMb3/moLs4=;
 b=Qj3PbdHZ1vXRSYFeBPgt/C+HGdPXfVIlUbmesnh552AZBrqu/zxKMHS2v0q4uIZP6deJwmIVmfGCwcLbjWdUJ9vOD/rwHpgGtOr2GKkwHuHWX/cQEP3WDKu6fwS/m50Z4AuP62W0/fFC8HwY/x3YK36qs+hMJgOd+sDIh+3xcEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Tue, 5 Aug
 2025 01:29:15 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 01:29:15 +0000
Message-ID: <8c52f788-0b90-46a3-9964-400745d544d2@amd.com>
Date: Tue, 5 Aug 2025 11:29:08 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v1 10/38] iommufd/vdevice: Add TSM map ioctl
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-11-aneesh.kumar@kernel.org>
 <20250728141701.GC26511@ziepe.ca>
 <bfac9ab6-9115-44d5-90c8-e22c3dbdb607@amd.com> <yq5aikj38p8a.fsf@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <yq5aikj38p8a.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYCP282CA0011.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::23) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8702e4-6903-486d-b78f-08ddd3bf7d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjlGRVpLdE5QcFowUjFFWUE0M3I0ei9rRFU3LzhERExkRllxSDFMQThQNXB3?=
 =?utf-8?B?S1pyTFh3TWVkMmRjcDV0cTdWRlFlaDBPNjA3aHQ3UHIwWEVBTE1Xdndid00x?=
 =?utf-8?B?UXpoTlN3ek84cEJ3UDNkVG1odmtpTmpiZWx1Z09waDVBTkNYclZKTjFKMklr?=
 =?utf-8?B?T0hJL2NValh0VmxaSTFWTmRpRkcwdFNzOWxhYytDekswR2NXRTBXSGZmd2xN?=
 =?utf-8?B?V01sbHhkTythNC9vNkd0RyttZmE2ZTZmM0M0S012Q1hXV2VjL0UxYzdEM3hG?=
 =?utf-8?B?MW1RamhhazRJRUV0UGhLTTlxQVNuVUtWNm1LNjVlbUMrdzRiUWJhdHJkSGlt?=
 =?utf-8?B?WlRJL0dnNFpmRmxXVURIaE1WbGFSb2tpeFdIZDBZM2RkbkU5OWtPZ3duWC9B?=
 =?utf-8?B?VmJndENaa0ZveXJCbHlWVW15RnNrNk16T2lLYm45ajJ2SnY3N3dHSitkVkla?=
 =?utf-8?B?QTJvWUlSS0ZUNWQwRTRDRGJobHhHbThnYjBRc0g4QlJrNW9aVjlHNHYrbUt1?=
 =?utf-8?B?TW5iWGw2Y0o4b3c4RU15aHdXQ2hyUml4dHRyUkNRSVdZUkRMVU5kL1V5eGx6?=
 =?utf-8?B?ZC8rSnUwK3BQa2l5MExHTisvUHB0SVhEYW0yUWI4em1UKzY0aVJHUDR0Tlpp?=
 =?utf-8?B?OXFISk1jYjRTQjJLQ0VnYlRtTVJUcVlhNlo1ZGtlR0RpbTQvbDVmZEl0NVZ3?=
 =?utf-8?B?Ym9leWRRcHRyNmxkc0s5WDBDd3NwTW53a3FYcXZ3MVh4TWZiWGVTMjZaaHNt?=
 =?utf-8?B?cnI5aVEzSEJQRU9XVXdwNE5wbmlINUpNK1c4UUdNQ21peXc2bXZuLzl5RUFL?=
 =?utf-8?B?c2J3bkFCNHp1RTFxT1RscmI3c09uWXMwSis3dzBvU2QxTGVBMXNzWFlONmoz?=
 =?utf-8?B?aVkxeU5UMUtVYjRmbTZ4SFNnc1VlMktIRW0yRlR5NWJack1SMjY5TUlOUXpS?=
 =?utf-8?B?V1pTUDloTm1DdVB0RlErRUF5TE5PVjNsOGg4VzF3YzNHYjVyd1p4MVJZYTVT?=
 =?utf-8?B?THE2T0p0VDNUa0hleit0OWRwdkFRdUhDMUcwRkFyYXhKbE9vUnp4bFFjUWwz?=
 =?utf-8?B?QVZwZE9SRndUMGd3K3VRaXhuVkROS1AwRTdJSTRFZ3ZBd1o3WEhuazlibHN0?=
 =?utf-8?B?aXNTVmQxb1Z0cUljb1BCNVI3eUd1TC96UE0vM2JGSXNZZ1ZlbHNhNVdaRjNu?=
 =?utf-8?B?K0ROQjdmaUJBaGptbWZoaEdrYi9JaENzUVBESm9sYUc5YUdFNWNCNU4wc2px?=
 =?utf-8?B?N2RoeWx6aGk0bDJTc2hjSWcveVhhSUlzMnB5NmRYY29SLzdkSUhsbDkwclU4?=
 =?utf-8?B?ZSt4T0JGd05yZHcwVGxOUk9sY1NYc1drZGMzM1UwQ3FyTng2bXlqMEhqRjFG?=
 =?utf-8?B?L3k2TXA3UzNLZC8zT3k3UFBmMTdwYVEzMTZza2JGZDZWRkNIZXRHM3NBSHU3?=
 =?utf-8?B?V0JGc1FDTytNUnhkZ1NLekhtUGJuVTBsN1c1THVBc1ZLSXNLa1hpeGMwK05i?=
 =?utf-8?B?bnJ2YVl1bS9icVVLR2pHQ2dVRTkzNzBseUszODF3cWIzVFFncGhmeVJ5NXRW?=
 =?utf-8?B?UC94UGhvVjBuWDFiRUJ1bjluamVYR3JDdE10cDI1c3NqNVg4ckFrcjZERS9M?=
 =?utf-8?B?SGlsQ1JqVXYwUW1rSmdRNEQxR1hDTjdzd0JrL0d4YTgvVHExaFI1NEN6amFq?=
 =?utf-8?B?aUtXdE03REFXNUk2RDVMR0FQcHBwWUVWdWV6UDFNaTh1cyt6NWduYkc3UWlz?=
 =?utf-8?B?dUs1UmFseUFwMGxaREJTT2VsbE5UajV3aGlYTCtnSGQ5ZXVRZE4yR1JKTzll?=
 =?utf-8?B?VkFsNDQ4cGQ4bkxmWkVHdnc2SFVGYUVVZzRtMHh3VUZjZWg3Tm9IVE1tRXFh?=
 =?utf-8?B?T1Z2RDZ4TExJSjBSZFZrSkhIRVdkcTFFaWxZMmFPcFR0cU5JaU15WmVLTjdE?=
 =?utf-8?Q?wCArI1yE84o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDJvMGNKekxER2NjVFBGa3o4UWJOTGtWTG55YkhtQ0lNd2pFWmI4RW16Y2dN?=
 =?utf-8?B?Z1d4NWRQajhZbElJQ0F2SWJFVlRsTHhTNXJydHg3NWE5Q0N4eXN5amFDSnhP?=
 =?utf-8?B?ZFZNeFBFN2RQMHVsWUpVT0FnTFBHMnQ2ZENaVnBoL1JxaGMvMUR0VjFEWkRi?=
 =?utf-8?B?WHNXNFRFTlRiTmhZWTdsZ1BaYnUrbEl6eWVRZEcxd0VBVGs3bEk4YVVzQVdU?=
 =?utf-8?B?OC9oSlRmdU92cjAraENKbUtzQmhvU2xwSzdCc0xmQ3NLU05vc3VhTnVRZnlO?=
 =?utf-8?B?aitQR1YyeEsvYUZ4ajlZdWtWN0J0WWNSbkFzWFpYd0lKSnJobEFJOXNWZFNF?=
 =?utf-8?B?MVdOTWFUakU4WENNZWFxYzFlbXBCMXVGazdQRFVWYnZPS3pFbjVBRnQxSyt6?=
 =?utf-8?B?aVNhSE92VHF3NnhCYVZsSnlEYW9RR0RQY2RCYjdWUDlPMFJxK1QyRXpSeGts?=
 =?utf-8?B?aGRjUy9XSS9jdUNTcTgyZFVWNHY1d0t1cHY1TTRURGJITGdObk5ia1oxUVVT?=
 =?utf-8?B?SEw4aUJUejZiUFRvN2Fnb28xdWFBcGxLWHVxTWJkanpvekg5djFkMWp3R3VY?=
 =?utf-8?B?eHIyL0VBTGx2bC9NQUlyTkZXc2laN24xbGlmaldTSWY1VEp2RzJCREY5T3pk?=
 =?utf-8?B?R2pOVWZBcDZrQllicXRMYjc0MXNvUnZhVzYxZ0xUbVNJUmF4ZlVQU2g5ajQy?=
 =?utf-8?B?Z3l3MFNaQkdqaHMrQlh3ZUptMWZxM0hibVFKUjJyZm5wRERqT0xjUjNIS1Zx?=
 =?utf-8?B?elkvaTFaYnRXWWRNeGNNOUkrV1BqcjNWV3V4THlvOWxxbENEdk1XTTlFcEpR?=
 =?utf-8?B?OElMOWhCaG0yRmIwWGtBT0ZIQi9zR0VQU3NoQUxnYm5jdklwTHQ5YWRjdTlX?=
 =?utf-8?B?VjhWUXg2VS9VSnh2NzlIYmdrUGc5ZWdFeFh0QkI4aDg5K2ZvdFBSOGloeTVD?=
 =?utf-8?B?alFEQ2ZXVm1kWnQ5NEUrSXVmRUlhUHJoYmcwM1dJOW1MZEtEWlJMQ1FsaTE1?=
 =?utf-8?B?NkUvOHhWS0pVMDJ4emh0UTNFem5xcWJiTFJMMlZQN3pkb0NSUVc3YnNXakhp?=
 =?utf-8?B?NG9nRW9mU0t6ZldTcjEwM3R0TE9iMVV4SXBJUFpGdG9GL0NtV0wzQU5ScGpS?=
 =?utf-8?B?K1piUEFvZnVadVYwRjY5YlJrRTRvYWlYRldnMzA0cE1rTVQxajl4enlHZng4?=
 =?utf-8?B?bU5RQTZkVGFERllvUjdtVmtOWGtuQk4wcGsweU1qdzZFT0lnVXJ0WG1TWEhF?=
 =?utf-8?B?S0d2WE5vMkZoR1VZNW16c0ViM1Fod0VZcHhyVDRHczJBdjRRR1luNU9xYm5s?=
 =?utf-8?B?d2RVU1dDL25sSG5vYnRNbkhiS1l1T1Z3UThjNjFzV1Evc2RlMk12SytqTTZ6?=
 =?utf-8?B?K1RmNDVsd1BMOFZ2NmFudi9nZ2VQTjZJU3d2UG9FTmZlaXNxVTJsOWJDM0Fm?=
 =?utf-8?B?VkRzM0FhK0MyekQ2QksrL21ZUWcvbmtMNWlIallXRW12UWZQQmRuL0FVd2t6?=
 =?utf-8?B?YXZvRmgzeCtvbzdtVUhsRGFXaFJLazBxVWxhR1pPeVZKanV5OHVWUk1acThO?=
 =?utf-8?B?cGR4T3N3eU5YKzVVR1VIZlBnaC9kVjJodzJqUjg1K0l5MVBHMnd0eVRoTVR2?=
 =?utf-8?B?TnZhbEU0dHdtUjFwVVZXQXE3UkdmaTRJM1YyV3V3ZUdjS3NCT2xXMzB5S2Jo?=
 =?utf-8?B?M2I5UEdBWFlIcm5vdUJXd1ZIQjl0ZTFXdmhidEozdXdlREV2bUppVk1xdVhM?=
 =?utf-8?B?RFNSUnBUYzEwTW9IWm9tRWFxaTVlVlJBY3FSRGdhczVNaXJPYi8vbExVMU1U?=
 =?utf-8?B?K1VtTmZPVWhuTnBXLzNkeEJ0MlJqVXVma3lJM1RiUzMrZ0NvclhyTDNMM2g4?=
 =?utf-8?B?U2wwelhOWEozbFo2a2ordW1ieU8zZjZyd05KWktTLzlkZ1ZBU1RlWnFBVUdh?=
 =?utf-8?B?eU1lWi9WNEYyMitGemVHQWdINVdIMGZQT21URFJLcTB4VldxaWdaTXNCeUIv?=
 =?utf-8?B?Qnl6cTlOMndmbkFaOVJkT2hzNUVQRnNKM0Z5VTR3WU5kSFlmSnZhZUpvRnBD?=
 =?utf-8?B?dENPaWtXSWFOUGp2a0pRU1NnWFROclF3UnRZblN2R0dCQ1EyNjIzSkhUSFNX?=
 =?utf-8?Q?QFRwbRbJeYcf9yEhTnBAnx4UA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8702e4-6903-486d-b78f-08ddd3bf7d7c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 01:29:15.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkaLtPH4eryRCI3Cw/icq8Q+g77BbUhjeMapd98iKtA5RNP2V+pbtMKoZwEvdDeDlXCVapveOkLFgBPYutO4pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085



On 4/8/25 13:58, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
>> On 28/7/25 19:47, Jason Gunthorpe wrote:
>>> On Mon, Jul 28, 2025 at 07:21:47PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>>> With passthrough devices, we need to make sure private memory is
>>>> allocated and assigned to the secure guest before we can issue the DMA.
>>>> For ARM RMM, we only need to map and the secure SMMU management is
>>>> internal to RMM. For shared IPA, vfio/iommufd DMA MAP/UNMAP interface
>>>> does the equivalent
>>>
>>> I'm not really sure what this is about? It is about getting KVM to pin
>>> all the memory and commit it to the RMM so it can be used for DMA?
>>>
>>> But it looks really strange to have an iommufd ioctl that just calls a
>>> KVM function. Feeling this should be a KVM function, or a guestmfd
>>> behavior??
>>
>>
>> I ended up exporting the guestmemfd's kvm_gmem_get_folio() for gfn->pfn and its fd a bit differently in iommufd - "no extra referencing":
>> https://github.com/AMDESE/linux-kvm/commit/f1ebd358327f026f413f8d3d64d46decfd6ab7f6
>>
>> It is a new iommufd->kvm dependency though.
>>
> 
> Was the motivation for that design choice the fact that in case of AMD
> VFIO/IOMMUFD manages both private memory allocation and updates to the
> IOMMU page tables?

IOMMUFD maps pages for DMA in the IOMMU pagetable, let it do just that.


> On the ARM side, the requirement is to ensure that pages are present in
> the stage-2 page table, which is managed by the firmware (RMM). Because
> of this, we need an interface that VFIO/IOMMUFD can use to trigger
> stage-2 mappings within KVM.
> 
> Alternatively, we could introduce a dedicated KVM ioctl for this
> purpose, avoiding the need to rely on IOMMUFD.

Right, if there is a requirement like this, and QEMU can do just another ioctl() - then I just do that, helps to untangle all these kernel module references. It is the firmware which makes sure that page tables are in sync so no much point teaching KVM about it imho, DMA map requests cannot go past QEMU anyway. Thanks,


> 
> For reference, TDX uses a similar ioctl—`KVM_TDX_INIT_MEM_REGION`—to
> initialize guest memory. However, that interface isn’t well-suited for
> dynamic updates to stage-2 mappings during shared-to-private or
> private-to-shared transitions.
> 
> 
>>
>>> I was kind of thinking it would be nice to have a guestmemfd mode that
>>> was "pinned", meaning the memory is allocated and remains almost
>>> always mapped into the TSM's page tables automatically. VFIO using
>>> guests would set things this way.
>>
>> Yeah while doing the above, I was wondering if I want to pass the fd type when DMA-mapping from an fd or "detect" it as I do in the above commit or have some iommufd_fdmap_ops in this fd saying "(no) pinning needed" (or make this a flag of IOMMU_IOAS_MAP_FILE).
>>
>> The "detection" is (mapping_inaccessible(mapping) && mapping_unevictable(mapping)), works for now.
>>
>> btw in the AMD case, here it does not matter as much if it is private or shared, I map everything and let RMP and the VM deal with the permissions. Thanks,
>>
>>
> 
> -aneesh

-- 
Alexey


