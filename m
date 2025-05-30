Return-Path: <linux-pci+bounces-28690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BCCAC8654
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 04:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6093B8BE9
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 02:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903AF1D554;
	Fri, 30 May 2025 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AMkSyprh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878264A1D
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573098; cv=fail; b=Y1KRxUiO/hdUXGGAIeWyottkQb1hoVW0NuaSutKnIOaPwmBKfGP21AseljgKfiDeenzGFGseL/HpC8MbofzcyX1wdHG+0wt6CoDS3uAkT+m4dyPPdRk05VdLa7R7C4kLSm8tA7yvE7b4feqjTRedA2UzRbskPPvpsRUpmi02TPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573098; c=relaxed/simple;
	bh=XBBCkzdRpIz9o2Ur9dmbtyFKYOayqFUr5G2DQSIquTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TvPV9e3sbFv8+5/AOUNJBR3/dQjsIfZct5t//hnGy+V4pKGCn61zz2x7afFNLF7KPmNKgdD/hra/lzB3GA6m049HUeU5MuNGgtnSVMoH4bFH+f2F7tZRclmx3CNgnRzALl4aeMyugpB6QsqgIFGNYzd5H0fnwDJYcDIGFGbdeEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AMkSyprh; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3BdAwG7BfOXdy9tVlPMpbAHgZpAOK6A3ZiysafEmuEpemE7/jxG5qJT4wCmcRIIvwzBH3i7m7yVqS8WfkoiEWdwqnC233eUXu4SNYNYpbsmdCB0Yz+Y5VB5IrYirgwP8noY+iSIks42swkWzpLtZXIuomzZiFBzKL7AcmOKS0DAHxB1/NKboMdaGLL7VwbY5nLMy0xQ+pGjKRiF9dIykEHudMKVsv66w20umranXE9/4D1LD3T4uAS1mpKs+IjQ9Bn26SvOj2XFtr28a3oacl0YSjXSoBiN6TaCr9yYfm1oP6cr57VAL5gBLU8GLp1/VeaWMbZjMMrN/FZohwqVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIO2TQZWLCdVO3pssgVzhCuLS+1E+JnF3Z3FCHdlA6U=;
 b=eT5qhb0IwYaXm0fqyvmH1CpJTIECyg61jQWcUsSTKem9zeAk5wuM2aWH01RBtg6Fx6cS4CUb5EnfEWb8Si13KmC9pvLjGIAlxu0rkoAjABWtSPSR/uZvGo8HTATJjfH2qR/4lSBKGFXrObUOxUciHnndWUEy2BhPTnZql+rxOtWiSYFBCsRtbTW5ZJub65ugHhGUgpWbvvQJEG7ssmdRTaLVpsfI2PLt+Wxb4G2ybNaBbutTxXeawz/qXyV2p2AbnHqYI/DtwOnD9y5ML9zXl/rdeJteAoeNnKiqJVb9aDOKWs5eQpiJZaZ/dRSGHQf+0qeAWN1yzkmY9OLM9ETSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIO2TQZWLCdVO3pssgVzhCuLS+1E+JnF3Z3FCHdlA6U=;
 b=AMkSyprhGdlUcvgWVA0RuSeHmLpToTwW/3hlZN3DY2NjR3UWaOIo6RVxYALNU63F/Ru3tGXdMX8mwJl20DVi7gnoJ79iPPDqUM5RZnYZQVNM7dyphbGUr689p6EQmlxgq1tS1NDHVIAz1gCt74+rV8NOP/fVzybK0mRYINmyWHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ2PR12MB7847.namprd12.prod.outlook.com (2603:10b6:a03:4d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 02:44:53 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 02:44:53 +0000
Message-ID: <0265c8c3-5aad-4482-83fc-cc459daa5042@amd.com>
Date: Fri, 30 May 2025 12:44:46 +1000
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
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com> <yq5abjres2a6.fsf@kernel.org>
 <b96cb784-6097-49af-ae3c-bf469cd609de@amd.com> <yq5a5xhj5yng.fsf@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <yq5a5xhj5yng.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0117.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ2PR12MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df513bc-f9bb-4267-c393-08dd9f23f470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ci9xTnVVSlc2RnRjR3U0ek04UkNzeC8zbng0SnRHRzNLNEc1ZTVlTlpIa0lm?=
 =?utf-8?B?Q3NYL3ErSnAvOU9XNTFROVZZc1hUUGYxcnAwTDNzeEo3ZVJ0TGhMdGozZEVa?=
 =?utf-8?B?RU5iL1dINE1YYk1FWVpMcWVsUTlwMXdEWFZBaDN6RUJhbE02bHJsK0lHVWxM?=
 =?utf-8?B?VjlVOXNML1FJQnpZMjYxV0hDK3RtMkMyK0FLL2hJbEhyNHZ4UFB4Smt2R2xY?=
 =?utf-8?B?dVFhQ2dLT3dGcWpLcXBMZXBvajIrQ2dVMEtJOGZSL1BpU2xRNW9lR1RQK2dW?=
 =?utf-8?B?OVJNalJEZ3d5TThTbHpMRDRHc1NWMEpSUHBDQ3dxZDNxTEh4a3F3N3VYcGdB?=
 =?utf-8?B?M1Y3V0Rka0M5QnpJL21yR1kyRXp0L1lBQUVLdXN3TGFqOWRlejY4WTJKejlL?=
 =?utf-8?B?WFdNRXRRV3FNaDFJZnByemt6aktjdFVIVWNIbDNRUzNPSDgzZlowK0c5Wmxw?=
 =?utf-8?B?YjZvakI3VVU1Y1IzbFVsbzhaTDNMd2dKZGk3RWdWaUZvMkdWd0lFLzNwQVhF?=
 =?utf-8?B?OG1PTEtuNXF4WGNsOG1heGcwOTFBeFBSNXNHV0ZKVld0c1djZWt0cFpUbkNP?=
 =?utf-8?B?Ull6ZWQ1OG9Sd29sWjBQdVBNYm9NMWlRSkdqQVl4RmRkaGk5VENab0xrNU5o?=
 =?utf-8?B?dHdHeGpWY2xTSHk3YVhQUitka0FteUlCTzNOUk85dENQRzB4dFFRMk1EdmRY?=
 =?utf-8?B?clJOMitwdUNjRVhjVTZjN0l3a3VrRzcyYlVoRUZycmxpbDdxZ284ZHpGVzUw?=
 =?utf-8?B?UmdOd1hpQWQ5RnpNcmd1QXJLZ1UyUmxRM3RqQ09PWHRGU3R1Y0xZaEpsQnpL?=
 =?utf-8?B?MFhCTmlVMVJsL3ZqY0JsRSsvVjBvaG5TZTVNcjRGSHJWOGtsM1ZWRVBtS3VI?=
 =?utf-8?B?TU45ZWNZNmNCZU9keVNUbkkzSmpZTGpoVnQvQytBVnJ1aGN3eXVYcno0aU5x?=
 =?utf-8?B?NmhodDU0VFJRVFdiTGlkQ2NVN1QrSjFacFJUcXEzemxlZ1JlWURxMTVwS0JL?=
 =?utf-8?B?MC9zak80OW8zMjJ3UkN5Uk1GN2Q0d2crN0F1SzF4SzFIakU2Y3dpNGFBTWsx?=
 =?utf-8?B?UmM5WU5HS0o3NnZXZ1ZnNlNvVlg0NnBxUlNVajNGVnhRY2ZrbzcwdzhlMTNj?=
 =?utf-8?B?VFhvbW1MMWdMZ0dtSzY3VWkrT1ZTbjJCcUNMRlJFbnVMVWRIM25NckgvdDgy?=
 =?utf-8?B?TTJCbXVMVjd6WjFRcWt1ajNaSWNUTU0reVJuYjRYRU9IK0cwWkxnWXlYek9N?=
 =?utf-8?B?UGo1cVd1THU0dmNmeTFpZEtwWVZxdFZxSUZ0NzNiU2tFZklONld0alVncnRH?=
 =?utf-8?B?aFgyUTh1WlpIdDQvU0R4V0dIYlJXL1hUblRXYTQ0RzFMNUNXMDZOYWN2MmhF?=
 =?utf-8?B?WWpzQndSTnh0TnNGck4zZXZPNWExSnUzeHBiNUl0V09lVlo3emlOQytCVE5j?=
 =?utf-8?B?bVpWNWZKTC9jbGI5dU90eWdHbU9HVXphUGJHSUV6VnZtdWlheFlqS1RUYm96?=
 =?utf-8?B?Y2FoZ3lBNG44QllnR3VDdUdJWSt5TW1mQnpGcFNzd3BYd2p3OU1ib2hKVjkr?=
 =?utf-8?B?RzltVHVzK2EzSTZKMVgzQUNzQVM4UlVXa1c2Ny9nSFpkclRQek1UcDdxc1JI?=
 =?utf-8?B?eUJpdGNwU0hBRm50SE9HQnF0UzJaTDNTSDRkNEpSZmdUekhGOWRCcDZNR0pl?=
 =?utf-8?B?TnU0VUxQM0sxbnpkcXovQmY5b3RBVU5NRmVUb1dORTZ3Q3Y2ekZRamJiMnBM?=
 =?utf-8?B?aGMxc3BQcHd1RmdlQlF0YlVwc1Zyb2ZqYm5VUlEvM0xjWFJFdlFidU8xbjhn?=
 =?utf-8?B?V3hTK2FCejFoZTNQcCtXRHl1WHQ1ZXEweGhGVGcxZHZvdE5aNFVaTGF1TWxG?=
 =?utf-8?B?OFNEVkhKSkUvUmFaSjJOaFNCN2M4TzNwSnd5WDRHcndRaDBmSmEwVDY3dVRS?=
 =?utf-8?Q?tQuWLobUXnc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmlYZzRQV1h3SElwa2xYQW5UMitCdXVIb3pzWWxDdi9odk9VYjIrdDZaV2ww?=
 =?utf-8?B?K3dWanZTN1NPSlpjQngrTjVGd2RtTzZZMmtzUzdpK09PN2VqM0lhMCttTTJh?=
 =?utf-8?B?QWxKam5VSUVyc21EL1dIdjVaYXQ5cm1yZ0pDSXozMzRYd0tmcURlSk4wdUht?=
 =?utf-8?B?VUF0RmFGR2FFTzl3cW8waThucTJLbzFNWmpiMzVnbGExQWIvQk02L1dGNG5J?=
 =?utf-8?B?MVJpRUhyQTJUQ2l1SSs1Kzlnd2h5OEhsdk5OZDVWMloxSGZ3TGQ3R3pVdk11?=
 =?utf-8?B?Q3JaNmVEU1N2b2g0TkhrdTZoSk1kT1g5Z2NBUmtaM0hYU3NWVEo1YTFBWmNS?=
 =?utf-8?B?YXU4V2FYME5lNnptQkZzKzYySTdqZTN4aUZjRGxyT3lROEN1cStZZkJrN2xH?=
 =?utf-8?B?RDRkZVREdUcrK1V3dVhBL0pZZURuNEZSTVNkdzM4aC9sNTlUSEhBeWJjeTdn?=
 =?utf-8?B?ZEJYcmtYY0RzcHV4eHRNRnd0cVZOOFFSbU9XQnNHMjFSQjg2YlVTYkptTVA2?=
 =?utf-8?B?WTlpcW9IVEdGM3RuTnVKeEloUWZCbmhTTTJpTTNhWDN3bDRhMjZpK3Z1RnQx?=
 =?utf-8?B?dWxCUm5lbG9iL3V6N0wzRmJJYnNsbHVDbkVML3E1VzBmRklsVGFtZ2lJaXl4?=
 =?utf-8?B?akszb2xQTEM1RkVqZEVWSGFpMnFSam4vbGdIYXdEMFdhRzByTHVsSW41YmEz?=
 =?utf-8?B?M1MrN2dicUQwR0FyZjJSWEtEeVI4YkhZck5EUHlNZlFJNzd2ajc4T0ZpeFJ6?=
 =?utf-8?B?Q0I2VGN0Q1RPTGJlOC9kcUV3bnNKWTRjREJTNE1nTVRQMTFWWGxmUmZEeDA5?=
 =?utf-8?B?d2xtT2VSNk5FZ2JhMGY3WXE0UTRPMGpVa2Q4SytoRUtmUytLWGJTMlBadzZ4?=
 =?utf-8?B?UGczdktIK0FsaklSRW1idkIwVTVKWW1rRHlwRVZENzNpMCtNT20zUXZzWHBZ?=
 =?utf-8?B?Sy9VaVVUQVpKc1dYajlrOUhtVkhXL213c0V3QjBiTnN4WENIWVBQaFRKMzZP?=
 =?utf-8?B?S3V5cnJwanFkenZhRk9LbDN1cGM0bXAzcnlUU1Rub0RxUXdkT3F2WENRbUZv?=
 =?utf-8?B?K0x5R0JtY0RUT1M0K2tFa05FMGlGRGFaV1RHVENZRkNYTlpTSllReVd5UHJs?=
 =?utf-8?B?VmFYVmU2Zjd2bk1uTFZqM2l6R2hDeDBKQUdZZ0VZS0FhSTRvOHNBV3FKRjhS?=
 =?utf-8?B?b0RuajNKcTlCNlRyNnlId2RYQVZoUDVlZ241TUFIZlBHQ0lnUisyRWxtNHNk?=
 =?utf-8?B?eFh1LzIvakJKUnJEYkFJbnJ1bFFJZXlGK090eUZKTGEvTmhMSXZhNG1mT25D?=
 =?utf-8?B?WEZ0dmhYckROTkphUnZBMXJ4aUc3NHZTVk13ZDgyanhjRWlRRlp0elVRaWhL?=
 =?utf-8?B?VEoxMEkxMDZlOWxhRnRKNVQrR1pheVhlVGxSSnkzYmZZNWg2c1JNMDVlbW5X?=
 =?utf-8?B?YUxpV2x5eHRxTEZGMHV2SHBpaGNNbzRiWHlma0FaZXZEanQrR0ZXNG1PM0dU?=
 =?utf-8?B?N05nNSs5OGxpbmxYU2pGNkk3TFArMDZuRlJjblpRMVFyWEoxblNNMWtYNy8z?=
 =?utf-8?B?dUE0b045ZDQ2NlN4TXNldllXekYzQUpLVkJ4Y0Q3KzlsRUVuSUprS1Q5ellG?=
 =?utf-8?B?QklnR3FQVml0VjVYVTRBYy84cVQzbjVwTnA2VTlsNW9NTTFWNWtGZUw2QXRS?=
 =?utf-8?B?YlROZFQxNlN4ZytIUjA3RTdwOTV5bnVQUG43dDlpMzF3QVF6RDl5Tk9SNUoz?=
 =?utf-8?B?RUt4bnZSV0VtUWR5NURWQjFSeExpYkFaL05hN3BZOVVibWF1THV1TW9Bb0Zq?=
 =?utf-8?B?MXIrZkVzQlMyMDloN0JKTHk4RE5Ja055VW9qcjM0OEpNU1FFaVFIdzNWNXFO?=
 =?utf-8?B?bzcyc3ZjMGp6RjV1a1ZubEkyd05OM25NSTlQRnRyZ3FCVXd6QnBqbGhLSTJk?=
 =?utf-8?B?eUFFa0JaZjRGdVFPS1lCc1NOVlZIMGYvZDlHdU5TTFNja3V2OG9GWmd1NHZy?=
 =?utf-8?B?M0lrTkg1aUUvU1lHdWJuTUpXRDVzcm5kNEs4UlREOTFBQ09sYlgxU2ZZdTRT?=
 =?utf-8?B?cU1TdXZWcEpuYi9qNnpWU1JRQ0VGa0diUHlvbmRJOUxTdlJqaWgwS2l5cW0r?=
 =?utf-8?Q?yfQFIcpYFMLdp6o7KprF+0qBT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df513bc-f9bb-4267-c393-08dd9f23f470
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 02:44:53.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLBcvl0I78A1ogQjklfdJK3marRTwveitoEhmkkJ9TxKl95RApJ35yPMnswkwMxcPlafDRvhbAur+CFFERdCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7847



On 29/5/25 23:34, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
>> On 27/5/25 21:48, Aneesh Kumar K.V wrote:
>>> Alexey Kardashevskiy <aik@amd.com> writes:
>>>
>>>> On 27/5/25 01:44, Aneesh Kumar K.V wrote:
>>>>> Alexey Kardashevskiy <aik@amd.com> writes:
>>>>>
>>>>>> On 26/5/25 15:05, Aneesh Kumar K.V wrote:
>>>>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>>>>
>>>>>>>> On Tue, May 20, 2025 at 12:47:05PM +0530, Aneesh Kumar K.V wrote:
>>>>>>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>>>>>>
>>>>>>>>>> On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
>>>>>>>>>>> From: Xu Yilun <yilun.xu@linux.intel.com>
>>>>>>>>>>>
>>>>>>>>>>> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>>>>>>>>>>>
>>>>>>>>>>> pci_tsm_bind/unbind() are supposed to be called by kernel components
>>>>>>>>>>> which manages the virtual device. The verb 'bind' means VMM does extra
>>>>>>>>>>> configurations to make the assigned device ready to be validated by
>>>>>>>>>>> CoCo VM as TDI (TEE Device Interface). Usually these configurations
>>>>>>>>>>> include assigning device ownership and MMIO ownership to CoCo VM, and
>>>>>>>>>>> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
>>>>>>>>>>> TDISP message. The detailed operations are specific to platform TSM
>>>>>>>>>>> firmware so need to be supported by vendor TSM drivers.
>>>>>>>>>>>
>>>>>>>>>>> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
>>>>>>>>>>> to TSM firmware about further TDI operations after TDI is bound, e.g.
>>>>>>>>>>> get device interface report, certifications & measurements. So this kAPI
>>>>>>>>>>> is supposed to be called from KVM vmexit handler.
>>>>>>>>>>
>>>>>>>>>> To clarify, this commit message is staled. We are proposing existing to
>>>>>>>>>> QEMU, then pass to TSM through IOMMUFD VDEVICE.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Can you share the POC code/git repo implementing that? I am looking for
>>>>>>>>> pci_tsm_bind()/pci_tsm_unbind() example usage.
>>>>>>>>
>>>>>>>> The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
>>>>>>>> Stage 2 patchset. I need to rebase this series, adopt suggestions from
>>>>>>>> Jason, and make TDX Connect work to verify, so need more time...
>>>>>>>>
>>>>>>>
>>>>>>> Since the bind/unbind operations are PCI-specific callbacks, and iommufd
>>>>>>
>>>>>> Not really, it is PCI-specific in TSM (for DOE) but since IOMMUFD is not doing any of that, it can work with struct device (not pci_dev). Thanks,
>>>>>>
>>>>>
>>>>> Ok, something like this? and iommufd will call tsm_bind()?
>>>>
>>>> yeah, I guess, there is a couple of places like this
>>>>
>>>> git grep pci_dev drivers/iommu/iommufd/
>>>>
>>>> drivers/iommu/iommufd/device.c:                 struct pci_dev *pdev = to_pci_dev(idev->dev);
>>>> drivers/iommu/iommufd/eventq.c:         struct pci_dev *pdev = to_pci_dev(dev);
>>>>
>>>> Although I do not see any compelling reason to have pci_dev in the TSM API, struct device should just work and not spill any PCI details to IOMMUFD but whatever... Thanks,
>>>
>>> Getting the kvm reference is tricky here. Also the locking while
>>> updating vdevice->tsm_bound needs some solution. Here is what I am
>>> improving. Are you also planning something similar?
>>
>>
>> At the moment I am planning getting/holding the KVM reference in the TSM:
>>
>> https://lore.kernel.org/r/20250218111017.491719-15-aik@amd.com
>>
>> but may push it even further to the AMD TSM (CCP, the firmware driver) as this where I actually need the kvm struct to get GCTX+ASID from kvm_svm; Intel folks have a similar intimate knowledge sharing between kvm_intel and TDX-connect. Thanks,
> 
> So you won't be able to work with already available kvm reference in
> viommu alloc? 

By "already" you mean 2/3 you posted in reply to this, do not you? :)

> I will send the tsm_bind changes i have done so that we
> can share the diff against that with explanation of why things can't
> work that way?

I am missing the point in having a kvm pointer in iommufd which does not do anything with the kvm struct, fget(kvm_fd) should be enough. Thanks,

> 
> -aneesh

-- 
Alexey


