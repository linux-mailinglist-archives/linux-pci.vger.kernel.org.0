Return-Path: <linux-pci+bounces-36460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312EFB87E25
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 07:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A664E1C86A5B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 05:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A42A927;
	Fri, 19 Sep 2025 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LNS9DESi"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82B64315A;
	Fri, 19 Sep 2025 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758258148; cv=fail; b=E4NsJL7S/nEd76eEW00CdNarrg2zyhz50Gs2J9XXlnEVEUNEZKg/EpoaXmhT/n/CNXtlyQtlNR3+cEHcOHMvsUDHoDghfNrtxSaFHSRVVHztjMQ1T+cRhEbfRdjs+7VkvIiw7IFp1IGhi3PdYpCXeZALYjbeYWBUas3Ig58ek0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758258148; c=relaxed/simple;
	bh=5WP4cKq2d+eTKVNun2Lh+UrLqXQJTIoZIXZxOjeas9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TyZMXY5IZSMRz+QpYXTmUL9JWO96texySh+o4Kel3sXkKEtdjkXx2j+ZVtTeSJ6y9LNOmHc7wKGvERnaQAwXIoy87tvWyjZ0dFm/FJpwHB9ZMuL4Pat9JJzmiGQXpbINZn77EqmT8fezKHOHiW+FJ7mbNV1ZuTtow2wWcsVcL2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LNS9DESi; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7YmS/BKl2gbAOjRsJWwaElDx94azmc4fcKTo4/k7JPQEotPPyoOnCTLT6lBKVDN8XcpO0bSqTQiviuQxjUxdSdb+QWjWYVI/A0mQeRIHS0Qwjke9HxhvJ3TwdRNIMMeUGcb34Ykbwt8YsVvaqrqKVQHIhTvLMqNDB0xyxKjDDftLO1/JFwre7TNoIIkw2+ymNBRemWzbQA5fV1nvhLPqqvBljoNpGOpjfHSn3ZhlwtJmiRz9MbcMPWMdIjDBkCjr4fh8BH0GA/qNQ2GFRliFJrRhEdyXEmsvIA974CxvHmpncpFDmCCtpxMrxpGNfboikATbpsduzzbp+ACiuJXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar+/pa6R5mhg4pt1ybE3hr6xXIlBDkx9arhl5Zrxhwc=;
 b=uY83zys6KDw7Y0YZWx7tn50mNdFHbyPr0a4iGToADvsIZx8V314VC7dOqSslK4hsyCj7YAKqcXqOjbrVJ8vBKJPuPziojGoT8i80ypFOEHG6n4pLUk+C21sqP49jiHdXxgWYvK0dVWxvSZM5vT3fNzn0zpa1XrWxgvETEH41baidKiOr4gBfm5DwCFAE39FMoUJ63bM/i0mSxkzWH3ObPklk/RE/TA3wR6YXKl6R+NmiWUWvtfLyYuP3dGO6pLfJs+sJcIM/JTxGuBa1QJ+qiG1P0K7BhE5ku45+02A72ZAr3CZq9eJzjIx1EEOOLFDx/HLy2T7qLjCh8LuoCDGUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar+/pa6R5mhg4pt1ybE3hr6xXIlBDkx9arhl5Zrxhwc=;
 b=LNS9DESimX/kmrdgG2Ht9cAVjIPZbzHiaVSVf+mSR0JA36c2eSbJo9zqqXBF7upmDV7YNjAqPOP2dBcD7/Y55Igzh05YDEh7Ah/nXnFx5Mk1W6SbCs9D0SH9XxxTSHrryduY53MLYvkck8U37DWczLuZZSVv7tREAK6HMw4ydVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 05:02:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 05:02:24 +0000
Message-ID: <cecdf440-ec7b-4d7f-9121-cf44332702d4@amd.com>
Date: Fri, 19 Sep 2025 00:02:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
To: Matthew Ruffell <matthew.ruffell@canonical.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
References: <CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0173.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: bdaded65-2434-4e7d-20b3-08ddf739b89f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTVuQWs2bE43S1FEZzdKNHBTZXozZFJXRW9kQkxPYkM2aWxzMGtDTVlQQXUw?=
 =?utf-8?B?N3g4NVpOcHB4Q3krM29KR0IwUXFrdklIYzE1NlRrNHFmay94bFdYRGFhaE5G?=
 =?utf-8?B?dFlNNGhXQ2J5a3M5R2lHM0xNUzdFWGZEMEJFbWZMMjc0alRXUHV4SUxXRGxn?=
 =?utf-8?B?dHBaOWNXejFOaWdGSHJqbkFnSWZnQVVXeXhLSWMzM0dSSUYwYVVkZUY4Wkh6?=
 =?utf-8?B?SHR5Qk5hdWp0bDA0TjhDM2p1NWkwcTR5YTdCRjM1bHlZbE9mRHdLWDRLNmVJ?=
 =?utf-8?B?aFN0bFNqaGhWeTllcDFvME9BQzNEazY0Qlh1K2QxTEhGZjlrcU5DSERKZzNo?=
 =?utf-8?B?UkVHQllVeVl6dGFWc2l6d0xxM1RTT08rZW5RcFoyUFJFZ3A4T2kydzg3aWZT?=
 =?utf-8?B?VmNpZFI1bFFhNWJCMTk3NU8vbGJTREcrUTNwQmlwa2FSWDREd3ZkbzJvVHcr?=
 =?utf-8?B?dFR6ZEdFbEIxSnBJeWNGeVhBU1dkU3F0TUcwakNFZ2Q2bjV6MXM1UkxWZC9j?=
 =?utf-8?B?clAybnpzSUVyVjlCdXRQQ2JQNVFOZ2xnVStEL29ibFBscG96dUdhQituVUJL?=
 =?utf-8?B?R0FlM3ZWQUFjOEV5SWRyaFc0NlR4QjNMVndxVmRrVGJNUDMwb3pSK0NjbXF6?=
 =?utf-8?B?ZGhSd3FDNjVoOU9nbkdNS1hiWnozR2pETnlsM2hpSElCaEs2S1lFanN5Ly9O?=
 =?utf-8?B?NFZDelBsUFZjNG1sRGJxdzdFS1BCVldQMFdpdEduT2ZvZitNSmF4Ni9iM2Ru?=
 =?utf-8?B?SEtaNnE4d1MwaFNRSmM2KytJK05FT2VLWFVLZkxwQVNHSDA5Zjlpa0t6S2tQ?=
 =?utf-8?B?TW42NjNsQUozcXhWUDhIMWl1VXc1S20wR2l0S2I1dnl2eW00QlVydVBOSDV6?=
 =?utf-8?B?WFBORlJEYUV3MCtYazd0WGdvMkFoM0NxUjY4RlhXVlN2S0NDMFA1TWpQSVVj?=
 =?utf-8?B?clNJSTlMdE1BRytrMFBoZFZFQjR0TnFyamFYMU42bFdJU05xSlNmQVZ6ZUVJ?=
 =?utf-8?B?dDRsc3RRNDJCdStMWGJmVm9KakEyN1hOZFk3WXVzaDVXdWVtVWorTWltRWd6?=
 =?utf-8?B?cGdkVEVtNzNkaFlPMklYYWhNb0thcHVlZWYwVmRld20xcHdYcHE0QUFOZ0Zj?=
 =?utf-8?B?QUFTYjZrd3dKdlNVRkNLSEdqaFdlcXlzcHNpT0F0czB1aU9YR29DMnRpOWpC?=
 =?utf-8?B?R2hPU1Fiak1FRlFuTXBKaWhud3NDcmhtaGZpc3Rrb1VnOHJyYkZCVWkzMnNQ?=
 =?utf-8?B?dStKWms5YXA0dm9VZjJUSFJZWWcreGM2d0NMMUtyQkp6Y0REZDRjODVCVElI?=
 =?utf-8?B?M1lTRWhMbEVQL2l1MU9mbTFPOEVvOUpwWUJNMEFDN0JvSVN6b3VMaitFUFd2?=
 =?utf-8?B?anlEQTJLampMT3U3Vi9OS0xRMXRIc1o2ZnM2T1pYQmNXcnlseGVPaHlVRmZn?=
 =?utf-8?B?TlBrbG9hbUhMb0RsUGNyQjN6RytaaTd4WWdLc0U5dUI2T0x4RHNDZUV1U3RK?=
 =?utf-8?B?K09RYTFVUCtCMmRJQ0UyK0ljL01VR1N2TDlINktGZnl5OFlPMjNXL2JINWt4?=
 =?utf-8?B?U0hYYUF6a2tPZEhvNW9CUXVOcUNta0o4OXNsV2dJcFZoa3p3UGVmZWZsdEQ1?=
 =?utf-8?B?cVF1VW15N3FXUmc3Mk5SdFEzbVZmYytWbXBTb0o2MkZPVUNkTzVrUjFRbE82?=
 =?utf-8?B?OTh5bFN5VEdqTElSbFMxUEdPV1RvZkovVTA2SVpEVFBoQVlrdE02akJRRW55?=
 =?utf-8?B?SGEzcHNQOW4wS0toVGNBY0txUXZEUGZtZTFQZGZaTUg0WVlCS2ZUWE5wamww?=
 =?utf-8?B?cGF4STE1QlIwYnRsbCs0bGo4a01LTmJNTjd2Y0xCUW8ySnhJc3kzVHJDV0x5?=
 =?utf-8?Q?wYvNHee5szOYx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkR0cFo5TVZrOEI2YmNaQ0tuc1h5YmxNYlFod1c3TDZEM01FcE1PZDJuOFBK?=
 =?utf-8?B?OU1CWXdmejF1SXJqOU4zYUgwYUY1TENJb3FGRHFxMDV3cHNON3BzQUVCVlFo?=
 =?utf-8?B?WTNsdnlCTkNlTXBqWmtQQkRnZUtPd2xJMXJwV1hPdTZBd3VYeTJ4cDNyTC8r?=
 =?utf-8?B?eW8ycGhrSmwwTzB3K3lXVWFwQkJ4amV2SDE4VWFhOUZmYURTbkxWMktqNmha?=
 =?utf-8?B?eWQ2VElWME1Vc1JSck1FTXUveVRPZi9qeWJtMnRqcVRkVWFoQ3N0M0tyMDdM?=
 =?utf-8?B?Sm4xelY3TkhxN3RTczV2VXN2SUVXQnlyYzRvUTIxeTdwTmNzSVF3UnF5dkNJ?=
 =?utf-8?B?MW94aDI4NHU3b2NORlIrQ2NPYnYveWFXb3NiK2xjVkxzb3dJcE5LWlZadnVN?=
 =?utf-8?B?VzJaZEVkNFVSSzhYcWR6RXhadUJEVldXQ0xmL2tCbUs1YWR3dElSWU9PMFFp?=
 =?utf-8?B?YnRsK3V4Y2tSbWx6Z0FoNFJLaHVsVjMyTExGNlhCdGt1Y0JLV1UvYkg2ZEhW?=
 =?utf-8?B?QUJlbW9DTGxlYVZ1QjBLNEJEY2dKeFpPMVRLd011dmoyUk5CZnVLL05DVXRL?=
 =?utf-8?B?YWVXUGk1eFVkMFM1ZmNoRUZNN09ZZ2w3Q1Jrd01Wb3lyc25lbjlRd1NSSXBC?=
 =?utf-8?B?TVNpRHdBbFBoZVJVa1hvVjhWWkx1YlkrRVNLdWF0NGNhUkpsVTJWQ2hTUlI4?=
 =?utf-8?B?dmNIUk1VRjllVFR5UjcrYzRVK014WkpObXhvb2JoVzMyK3dOS2pIdW5LOWZX?=
 =?utf-8?B?b0FyS1RxcmxHSGduRWpSV0xwaTZ2L01mSnhwQzNLQ2c2RlB4bEpTaGlzdHVj?=
 =?utf-8?B?YU1YNk9vZTdxb0ovK0VtNDZWUElGczZpZFpyWjJQVkxqbEovc05XWXlmMElm?=
 =?utf-8?B?YkFBRWlTOUN5SEJkUnd2bzU2bTFWMk5KdjJER0crUG4rY285OURZU3pUcWJY?=
 =?utf-8?B?TzRjbXIzWDlpTUtpZVkyYTVMS3VOYzRXVUVaMkVsc0o4RURkMUNlVWFEc1I3?=
 =?utf-8?B?WXM5b21kZUVaRmtySTk0QTJUZzdoS0xiU2ZJb2dyWC9NdGRtQzQ5TUprbUds?=
 =?utf-8?B?bmpQWmxyOXBGOGVBdUp3d1B3WUN1NzZiV2hEd01NdisvTEkxSVJwemdDUVB5?=
 =?utf-8?B?SkhzendZeXRmTUxmSDUrUUtVMkttSU1WSjJ1U2RwTjVhdlVBanlHQllxRWFY?=
 =?utf-8?B?QjBNQVRQdmFPd2l3b2JINzNsNjNOWG52bkM4WHdJOEJ4dmd2bUxYYVZqRS9a?=
 =?utf-8?B?UThzdVlpNmh6b3hFTmIvNmdIczBBRjI5UXVNZHI2UGNsNUcvY1VvZlplZ1BX?=
 =?utf-8?B?TFF4MElNeVZGN1kzK0JuWnpLdXNBMDl1OWVnVWlhTGhUL1RRQWsvOU5oOUJF?=
 =?utf-8?B?RXlhK2s3U0VjNFdveDBqWW9FNDU1VlZYTHZ4R2lMWTlJaklYczhNZWZoK3RW?=
 =?utf-8?B?ZlBPWkdsWCsyWHlTTmpFbkF5MEQzV3AydktsQmxRYUhtaFpzQmV1NTNRbDlJ?=
 =?utf-8?B?UnQ0R0xSbDFweENZbVZwby9OT1k1REtHQTJQZ2c5WXVzYkliOGxuTVcyNUFU?=
 =?utf-8?B?aVM4SExQQW41LzZIZWlLZk5leExWUGxXVk1kOVRnQ0cxZ3U2czZDQnU4Tkh3?=
 =?utf-8?B?Z2gwU3NFREhVM01HbmJuV3V3Zmp0ZHN5Ulh4S2MwdXg3K0tyMTFUc0IvTjBr?=
 =?utf-8?B?Q0gya2ZheFZZUVFuczVPNTNNS09IVFN4MjNVQUVmTEtyMjlNK2Y4VHM0cG5v?=
 =?utf-8?B?MGlJS0c2cnFqSGZ3WXFYRG1WVjEvTmxDTXlFWjdxdUsybnY4NnEwdGNVckNi?=
 =?utf-8?B?dUU0VFJGakh6a0YwWHZGNWNNYlpCZnYyaVFWRlhkZlNHbVBBY0ZweEQ4T3Fq?=
 =?utf-8?B?QlA0bmZ3NHRhcURKdDNsOVRMTFMrVlpoWVg5d0UzMzY2MVljUmhEdUpXVjgx?=
 =?utf-8?B?ckp0R2V2WnBOYUU0dG9rTUtGc3kySHFrcFE3aFZpSktDTVRIdXJ2RlB5SUxU?=
 =?utf-8?B?djRkeFUzdFRBWlZwQmZWbFhkWFUvQXZicHpaYlQ0MGFmUnhQWGFva3c5enQr?=
 =?utf-8?B?MVBFaUptakhUckFUc014N1JOYzhUVGpxSTZxekxFbUYvM1dhdk51Zm0za25x?=
 =?utf-8?Q?P5c0CXLWm8diZuUJTmVzNXUB+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaded65-2434-4e7d-20b3-08ddf739b89f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 05:02:24.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOAHwqVnlkRR1GaSp1Rpe90iYjBFl9Hp2lKvISxdC7WFr9dnX469qD1yDjMS4E7Gw/EM2A0f9ySYRyhRIFV2qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452



On 9/18/2025 10:52 PM, Matthew Ruffell wrote:
> Hi Mario, Bjorn,
> 
> I am debugging a kexec regression, and I could use some help please.
> 
> The AWS "c5.metal" instance type fails to kexec into another kernel, and gets
> stuck during boot trying to mount the rootfs from the NVME drive, and then moves
> at a glacier pace and never actually boots:
> 
> [   79.172085] EXT4-fs (nvme0n1p1): orphan cleanup on readonly fs
> [   79.193407] EXT4-fs (nvme0n1p1): mounted filesystem
> a4f7c460-5723-4ed1-9e86-04496bd66119 ro with ordered data mode. Quota
> mode: none.
> [  109.606598] systemd[1]: Inserted module 'autofs4'
> [  139.786021] systemd[1]: systemd 257.9-0ubuntu1 running in system
> mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT
> -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC
> +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2
> +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD
> +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
> [  139.943485] systemd[1]: Detected architecture x86-64.
> [  169.994695] systemd[1]: Hostname set to <ip-172-31-48-167>.
> [  170.102479] systemd[1]: bpf-restrict-fs: BPF LSM hook not enabled
> in the kernel, BPF LSM not supported.
> [  200.503000] systemd[1]: Queued start job for default target graphical.target.
> [  200.550056] systemd[1]: Created slice system-modprobe.slice - Slice
> /system/modprobe.
> [  230.922947] systemd[1]: Created slice system-serial\x2dgetty.slice
> - Slice /system/serial-getty.
> [  261.131318] systemd[1]: Created slice system-systemd\x2dfsck.slice
> - Slice /system/systemd-fsck.
> [  291.338906] systemd[1]: Created slice user.slice - User and Session Slice.
> [  321.546200] systemd[1]: Started systemd-ask-password-wall.path -
> Forward Password Requests to Wall Directory Watch.
> 
> I bisected the issue, and the behaviour starts with:
> 
> commit 4d4c10f763d7808fbade28d83d237411603bca05
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:  Wed Apr 23 23:31:32 2025 -0500
> Subject: PCI: Explicitly put devices into D0 when initializing
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d4c10f763d7808fbade28d83d237411603bca05
> 
> I also tried the follow up commit:
> 
> commit 907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:  Wed Jun 11 18:31:16 2025 -0500
> Subject: PCI/PM: Set up runtime PM even for devices without PCI PM
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0
> 
> and the behaviour still exists.
> 
> If I revert both from 6.17-rc3, as well as the downstream Ubuntu stable kernels,
> the system kexec's successfully as normal.
> 
> lspci -vvv as root (nvme device)
> https://paste.ubuntu.com/p/x7Zyjp8Brr/
> 
> lscpi -vvv as root (full output)
> https://paste.ubuntu.com/p/NTdbByTqjR/
> 
> Strangely, the behaviour works like this:
> 
> Kernel without 4d4c10f76 -> kernel without 4d4c10f76 = success
> Kernel without 4d4c10f76 -> kernel with 4d4c10f76 = success
> Kernel with 4d4c10f76 -> kernel without 4d4c10f76 = failure
> Kernel with 4d4c10f76 -> kernel with 4d4c10f76 = failure
> 
> Steps to reproduce:
> 1) On AWS, Launch a c5.metal instance type
> 2) Install a kernel with 4d4c10f76, note it might need AWS specific patches,
> perhaps try a recent downstream distro kernel such as 6.17.0-1001-aws in Ubuntu
> Questing with AMI ami-069b93def587ece0f
> (ubuntu/images-testing/hvm-ssd-gp3/ubuntu-questing-daily-amd64-server-20250822)
> with a full apt update && apt upgrade
> 3) sudo reboot, to get a fresh full boot. Note, this takes approx 17 minutes.
> 4) sudo apt install kexec-tools
> 5) kernel=6.17.0-1001-aws
> kexec -l -t bzImage /boot/vmlinuz-$kernel
> --initrd=/boot/initrd.img-$kernel --reuse-cmdline
> kexec -e
> 6) On EC2 console, Actions > Monitor and troubleshoot > EC2 serial console,
> and watch progress.
> 
> I am more than happy to try any patches / debug printk's etc.
> 
> Thanks,
> Matthew

When you say AWS specific patches, can you be more specific?  What is 
missing from a mainline kernel to use this hardware?  IE; how do I know 
there aren't Ubuntu specific patches *causing* this issue.

I just glanced through a Ubuntu kernel tree log and there are a ton of 
"UBUNTU: SAUCE: PCI" patches.  I didn't investigate any of these anymore 
than a cursory look of the subsystem though, so I have no idea if that 
has any bearing on this issue.

I remember a while back there was a patch carried by Ubuntu that could 
break a regular shutdown that never made it upstream.  Don't know what 
happened with that either.

So I don't doubt you when you say 
4d4c10f763d7808fbade28d83d237411603bca05 and 
907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0 caused an issue, but I just 
want to rule out a bad interaction from other patches.  If it would be 
possible to reproduce this issue on a mainline kernel (say 6.17-rc6) it 
might be easier for Bjorn or I to look at.

Now I've never used AWS - do you have an opportunity to do "regular" 
reboots, or only kexec reboots?

This issue only happens with a kexec reboot, right?

The first thing that jumps out at me is the code in 
pci_device_shutdown() that clears bus mastering for a kexec reboot.
If you comment that out what happens?

The next thing I would wonder if if you're compiling with 
CONFIG_KEXEC_JUMP and if that has an impact to your issue.  When this is 
defined there is a device suspend sequence in kernel_kexec() that is run 
which will run various suspend related callbacks.  Maybe the issue is 
actually in one of those callbacks.

A possible way to determine this would be to run rtcwake to suspend and 
resume and see if the drive survives.  If it doesn't, it's a hint that 
there is something going on with power management in this drive or the 
bridge it's connected to.  Maybe one of them isn't handling D3 very well.

If there is a power management problem with the disk (or the bridge) you 
can try adding PCI_DEV_FLAGS_NO_D3 to the NVME disk.

