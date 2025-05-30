Return-Path: <linux-pci+bounces-28718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FECAC8FF4
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 15:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D5C17E343
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ADA22C33A;
	Fri, 30 May 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AfKO2dJn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81922FDFF
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611318; cv=fail; b=Iv7FHLLjuwCa5RWjxF3jaN3w0GeYK5CdpM7wv7hAO7JFo5XcIE+68HKmitAtA6qWwj83MFf2KabHT8YQIIEYXvcJImLQC3aJB5oiCTSZhYN+E6QYWgWyPx+cQYB9numnLOa/TYkemGoUlXnJEg4C0wLW4Y6Lgwmu/hhGpCDPSNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611318; c=relaxed/simple;
	bh=3Iuc8wRAB7k3Y1f6yX+qTp3Lf2z7dzuO6w6SKdP3KpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ltKtUueZ81g98BY6Gq2nGwF+C+kWcmA7SPF/Uv9jIS3G7QEgnuZ8G1zvjzVOEwIiyENdU4gnK67BrrixhIrbrG0fzhq2+FsazYZXLaruaL44z5D0d7RfyZRym5vwZSWI1rgyM2Xe9Fes0Zb5iBkVgh4N4wlsxY3G6TTN6uOCHKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AfKO2dJn; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo3kJgNWlM7t0aZ3Tr2njsLIm1SQsoFoCYvipBCV0IMkypp7UoGdD8OrH3SHubsZrVN3QgN5wjdiPCnSAO4s2qctaXAMer1tXrXClYZh52qyBNeAerKopn8LO17+dNwvQl92UhEvPwUSj4gKmvBwk/nEunF6GpA54drS82+Pkx7W/UZufA4EgoffTYamMKTTLioy/qrWJRk53gYWLZZl/8oun6kvP+LthGc8JSnWzI1l2lEmkKm3cUWarICKnpDKCTkCfuV68RdIett/v+yZpEIyLz5qFg8bcN2uxjjMWAdIQ/UYQmfeu/yNdv6tjRkIn7khOayFfioj3srYHNm3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGLYGn6eXQBjPxq8D62EFy0OMMSZRsii3hnkBhP5GTg=;
 b=JQgN4DyPdqdf4MpNGDBa5g4w3FXRnWdWFZFsCXGMBr324MGct7jTdIZvN6LhAcbawbUN+Zw4r4i8W+rLwZrL4SEHfSjuGs2Nnvy0H10nEk8stBtiKgMczSuQCzHxFFMYsZJd0WgDkrNdJcuBpmfTm2hs/FC5ChkldV1F+A47tAVAgkm00a4tshvlIiMGwqDNvnYw52IuTSnNtORu6dhBO043pZ5N1vPOLMZL3flgEuxoYI8hV2hcXTIqgkxBs0ffar/vu+l485eUgHqnlsEFtSqMPwPtM7c8PM32xBOUAA5oALng0p/8YDhnwYjvCM2jwXriFPATlpvbXNIxfbYZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGLYGn6eXQBjPxq8D62EFy0OMMSZRsii3hnkBhP5GTg=;
 b=AfKO2dJnOpNG4uUnbIopEXffQnj456jVp3rd/wkz7ER55yD9psqVcJtTe5Jt0qTq9r5kVrLX9a+UNtDKyMKt6RLVOqwQTZVEGphNBtPd4XaEVSD8GryU5z+6RvLobBqApemXUxLC+o6sUzVffzmuro7jPnGy4lNOEVghEaYY4peWOK+GO48aYNufAx/s/qAooF1hkOF7yeohLlK0OQ1BkT+QASpxQuj52zRQpJagc4fsRBRDZn0Dp9L1JEUhgpGWOILJR39ZPTuYaYBrVfO3o+bB08HvKGpIUS4fbM5ldeIsaFul49xWLTVOTnMPem2WnPj1p+P3FrwqOZmExQ0Y0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Fri, 30 May
 2025 13:21:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 13:21:51 +0000
Date: Fri, 30 May 2025 10:21:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <20250530132150.GB233377@nvidia.com>
References: <yq5abjres2a6.fsf@kernel.org>
 <20250527130610.GN61950@nvidia.com>
 <yq5a8qmiruym.fsf@kernel.org>
 <20250527144516.GO61950@nvidia.com>
 <yq5a8qmh53qo.fsf@kernel.org>
 <20250528164225.GS61950@nvidia.com>
 <20250528165222.GT61950@nvidia.com>
 <yq5a1ps75y79.fsf@kernel.org>
 <20250529140914.GD192531@nvidia.com>
 <d7f14f9f-9ee0-428e-8602-1a11695690b6@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7f14f9f-9ee0-428e-8602-1a11695690b6@amd.com>
X-ClientProxiedBy: BL6PEPF00013DF9.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:c) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a28bc0-fe5b-404c-f9ef-08dd9f7cf05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3RjRmlYcXN4Nys3UmNWWWRBbm1IZzB2cnpWOTZ6RWMyVURHQjdzdEswY2Vj?=
 =?utf-8?B?L2Z5T1J4QVk2VXdwVXVMdWRic3hMZEc0UHQ5TGJKZWxGTWlHUEUvSDdTRTMw?=
 =?utf-8?B?dFpkUENxeWxZeE03N21GajVRaXRxUEZOaERQSHJ1TW1aR2FVbWFrOS9ZMDJD?=
 =?utf-8?B?a2loWkR0alg4dFZCK253RlZmdG5rWXprMjhaSUVmTE5CTDlEQjNjVmdHeUxo?=
 =?utf-8?B?YzVtdE8yZ285N3VjT29mTzA1M2xTODZUMTR6eFhONE9KcUFQVVl5ZnVCTUE2?=
 =?utf-8?B?WjJieDNSWS9HYUZpV2lncm5XRFRMV1o0ZUpSOHNDSDRNQ0ZpSDhCYjQ0aDZp?=
 =?utf-8?B?OGpGWmFpMi8ycGViL3RrNEE1SUpYUWRjdk53TjBOTm5KS2ZiQ2tQME0rSEkv?=
 =?utf-8?B?SFZmU2VjdStUNE5xZ1J5VWhTVzlhMDUwWDNXZG8yUm1rMWsyVXZBK3h6bWsy?=
 =?utf-8?B?Z3kyVHI0a3NVZ0RiV2NhcTFGY1pRa0x5TjVXS1JSc1h5WUYvVXp6RDM3cElu?=
 =?utf-8?B?NG42ZGVBUWR5cUFtZm42ajVRSFpvN3RXU0ovKzFnRmlRNnBCeHdOQnVGc3hU?=
 =?utf-8?B?QllvanVOczVmeWdSdzVsSHhGcWZBMVVaK1lERWxMbnJ1ZlJBTzc2TFJWSXNR?=
 =?utf-8?B?UTd1ZUF5dXJFeHRxa21PRDNxNlJERUtxTGZja1B6NU9mQXVjeERsc1did2l5?=
 =?utf-8?B?Q2tUM2FJOTF1VVByRU1oaDd2OXpBM3BaOVdPS3d4ZFo5ZVNxZzdIdVNiQTN0?=
 =?utf-8?B?S2Q5NmtQVWp6UXdKTStXakZuVGhNMUh5eDlhbUx3WkRBTmtYbzhyaGkrMElt?=
 =?utf-8?B?R0dOT3cvOFpqS29QZVlISmp3Z2ppSnlrb1hRRUh2VU9TWUNUYmRWUjltWHA3?=
 =?utf-8?B?ZTR5ZDFSeko2T0hvcFcrcDA0M2Y1elQyWmhwUXg0TUozZUhIZHljd0xsbWVi?=
 =?utf-8?B?TmFkcmsxTXNtRTBsZ0FOWUlRTUZZeEVHMDMzZlNBZE9rTWd4UCsySWhtY1dj?=
 =?utf-8?B?SENVY0N4Uy96SEg0YWJFVmt5Wk9SbC81UjZ5d2FlMGdoYW83VFBaTmp1dFJZ?=
 =?utf-8?B?L2FsRFNvSUxkUU1JaGl3MEpkVEVyUUVjYTU2a01mNkJKem5ubDZENGZBVElk?=
 =?utf-8?B?M1hZL3lHSzBLNE9ETk0zamFqMXVJck1zc0VSWkgwaWFIRmF1SWk5R29BYnZP?=
 =?utf-8?B?TExqVUFhVFpHSkJMaHpLcGZCSzZPZ3R6Y0c5UGNDZ2VEVDhISjN2NzFPWVJn?=
 =?utf-8?B?djdPWGVqSnJ3VzFiajd4TThUWjFydkE1SUVOOHcySFhiTlo5b3dKMG9qektv?=
 =?utf-8?B?M0grNnpMeHBMdjEvT1AxWjlOQ240WGVCd2tDK1lZbUhsOW5kVUxMeVc5eVZ4?=
 =?utf-8?B?UmJiMkVmWlU2YThGeDB1NCtrbVJHelBrK2RBeTQxT0VSTytkTzV6SkZPaEZp?=
 =?utf-8?B?aEdmdU9GaDgwUmpKUnp5MXVvd1ZRUkQ5Ui9SNHpRRGpybC96cThBVzUxeUph?=
 =?utf-8?B?UzZvTmdEMjFRbm5nUkE4U0RHT3BSMm93OTNvaHdFa0I4ZUhtS01jenVmWHZs?=
 =?utf-8?B?MW1vVzJVZnNnSi9QSkdXekE3Z09tY0ZDazdsemFNTlNuYXhubzhaa3RqVFR5?=
 =?utf-8?B?OFBHTnlRR1NmUTNXS3FwS25WNmk3Uk5zVUdLcWZhMjhPb0h0QTRhd0NocFZV?=
 =?utf-8?B?Ylp0M3lQd0NGbFdmZnBDaWRiS2tiWWwydE9vUjFoTm4yVU5USk5YVVRMVjdr?=
 =?utf-8?B?Y05vY2RhYmVvLzRMRHJOa0lwRkJXSEhJaTRxaTVoVnluMnhrWkpWd3dkZS92?=
 =?utf-8?B?VmdieTZlZUZoWUhvMlRSZzNuREowWE1DSzkvOWl4Z2lXdUg1KzdIRGdWVUts?=
 =?utf-8?B?enZSQU5ENy82dzlRTmF6M1dXVzMvbS9YK3RPY3h1Y3kvSEhuZW4rVEFIK3Fs?=
 =?utf-8?Q?olbaGpfS2po=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WCtsbG9yTlJ6d2xQM2hDSUoycnNpNERudFdXL3gxVEswYXA2UkdYTkVCa1VC?=
 =?utf-8?B?Uk44NlRod3Y4a2xFRG1XU3VQT0xubERGN0lCUjJvd1dIWnhrb291bXpqV25L?=
 =?utf-8?B?RHE0REdxQ0FvNTZaYVVjWThDTHM0aGdtWFE1MlVHQ3YrVW5xWDBYU2k2eFJ5?=
 =?utf-8?B?Qm1HaWxDK0tKZk9RTVl1dWdSZHpMWURJMFlrR1E3ZXBsbFgxd3NrUFEwRkUz?=
 =?utf-8?B?SkN3bHdmNWRRQTcwYWJiMHlRRWEvc3BnZXdCZW5BRFN0QTNicDh0Rzh5MnFa?=
 =?utf-8?B?TTFkOEZES3NjN1BIM2Z3SW96MnpvbjBPVEY5ZTVDUmtXQ0JoZU44WnFSMTJ2?=
 =?utf-8?B?UStsTlU2VzJUeGJkRkpNNXFiWVNxMzFBTmlEN2NaVk8vSGhjU3AxZUFwT2VK?=
 =?utf-8?B?b1hxZm5qWDVJOTljZm1pc0lrc1ptbWdhK2M1VlN2R3lKNWVhNGFQU2UxVlRG?=
 =?utf-8?B?Sm9BNFlkNlpsdmczdDQ4TW9saFB2TzRYbzJNOUN0dUlXTG5RR1RNN0djSjVX?=
 =?utf-8?B?RkNaU1hXaldjWTYyTnhTL3pZdmN6SzJGMXFuQkMyV09XZXkrQ1VoVDVUMlBI?=
 =?utf-8?B?OTlZQkJMMHRHR3FEaHJrWmkrN0lZYU5xN2d0QnFGZGhGenpGTkJZbGgxRGZ2?=
 =?utf-8?B?S3ZTNlZUaEpTT2RSWU5rQ3l0cFZUd0pweWErSkkyeG5ub0tRZ3ZZZ05kSEp5?=
 =?utf-8?B?Y2R0elNCZlVqWmNsYkdQZTQxL3lQQk50akRtMVJyQ293ZFR1cG5RZ0RyMjV1?=
 =?utf-8?B?U2ErYllsajhRakRaWWZPUU05LzlOSVI2a1Rnd1JQNE9XQlRCSW1tVmEzSUc0?=
 =?utf-8?B?cGVGbllDSG4zNCtwckVhRW12ZkFnQ3FlTUdSdW01L0ZaNjZDSkZWR2UrczJP?=
 =?utf-8?B?ZVBQN2ljTlo5S0g0a2gxSnpFVUJiWWJ1SEgwWVczbnpjakorL1RZM0NtUmph?=
 =?utf-8?B?WUtOc1lBZldHb2F1YTVsMFpWYmcwcmkvbytTb2kxSmxVenZuNnJzZ1pzc3M5?=
 =?utf-8?B?emFBQ1FVS3dwQnVacEszWWY0YTNGWmQ5MVh0SHRxQmhpWXZETFRYYUQvd2g5?=
 =?utf-8?B?ZmIzTFp5NEFBRnJUM2pZWkQ1TkRIMjB4NVdhL2tWWUl1TGk0WUkvQk1kQWRw?=
 =?utf-8?B?ZjlaejlRV3Q5MFlSMHJmdmF6aFREYTVkaGZBaE5sRC9Od2ROWllselZpd25z?=
 =?utf-8?B?cTZYbjJpR01RbE5PRTUrR1E5TFVPbVQwQ1VSUXR2SEtsZ3RuYVZOTUZJWUVh?=
 =?utf-8?B?VGk4ajN3WnVOQzB4czdGZGdZTDZ5M1E0N21zR21Iblo4N2RBYVJ6SWMrYzBa?=
 =?utf-8?B?VFV6MFhVOXhYQklMQWJaU0xQRDkyUWs0NkhaeHlpSVBWR3I3ZHd3S3VEcHZt?=
 =?utf-8?B?eGFJZlpVY25uR1p0VmswVmxFdTdzRno2WGxuZDVJR3Iza3VNWTRHem90ekZV?=
 =?utf-8?B?UDhwbmRnek55Y0V4OVY4SXRsT3l3cGM3RThjMEdwdUR1Y3VOdnN5blp1eHUr?=
 =?utf-8?B?N01WMFpHaStpVnd6eVF1aWRiUmtjT1pZSWxDdXhrSFJ5T2taOGJLazBOczho?=
 =?utf-8?B?V1RtZExBaTAxUGx4dUhKMmgrdHdtNHVRaEFFZXJuRXBEOFRXd1o1TWhiWE1W?=
 =?utf-8?B?UFdNQ0pPVndhaE9kRU1TWlU4OGl0N1I0ZTR5aXRvMjIwR3pDNTd4bmdhK2RH?=
 =?utf-8?B?Ym9laHQyOEluMVpGYkFQRlRTRG1NcFlJbmdvYW9HczZDZFAxVGFoVjh0WC9l?=
 =?utf-8?B?Nkh1MjFDSk81a2h0ZEx2Y3dndDZvVkd6N0F3dTBmUTR6c1YvckJHTFVZUENG?=
 =?utf-8?B?c1RITHIzNW9tK0JQQTQ5dXVGV28wUFJ5VnFBQlBCeUVlSmNJSDdOeUFTd0U3?=
 =?utf-8?B?SE9SdVNnbzM3YkV5VElnaDhQSUNDS0lUQlUrMVpTejBVRzZmSTlZdXJ1UVU1?=
 =?utf-8?B?dVlCUkFydXBQODhFSlk2dzlWKzc0aEJ2K3AvMGtCRE82YXFDSkhaZTJucUg4?=
 =?utf-8?B?cEQ5UUpibjVmR044TmF2U05EcmFqYUpOaGRjSHNiVjMwZHkwVW56MW9FcFNu?=
 =?utf-8?B?OEE1VnBhVkhTREpUVXpMZ0VFTHdXZ2Q5WjMzS3dOdjhhSVdYM3RnckZtbHhN?=
 =?utf-8?Q?EgQ+giLs8PkdcnhPgkxmkE931?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a28bc0-fe5b-404c-f9ef-08dd9f7cf05b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 13:21:51.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGi5TH0fX2LlJhVBmtAyM9NwmmKVZfyUjgzrU2SUhu5iYOKiWeDPPsjW3dcYz8EJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524

On Fri, May 30, 2025 at 01:00:41PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 30/5/25 00:09, Jason Gunthorpe wrote:
> > On Thu, May 29, 2025 at 07:13:54PM +0530, Aneesh Kumar K.V wrote:
> > > Jason Gunthorpe <jgg@nvidia.com> writes:
> > > 
> > > > On Wed, May 28, 2025 at 01:42:25PM -0300, Jason Gunthorpe wrote:
> > > > > > +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> > > > > > +{
> > > > > > +	struct iommu_vdevice_id *cmd = ucmd->cmd;
> > > > > > +	struct iommufd_vdevice *vdev;
> > > > > > +	int rc = 0;
> > > > > > +
> > > > > > +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > > > > > +					       IOMMUFD_OBJ_VDEVICE),
> > > > > > +			    struct iommufd_vdevice, obj);
> > > > > > +	if (IS_ERR(vdev))
> > > > > > +		return PTR_ERR(vdev);
> > > > > > +
> > > > > > +	rc = tsm_bind(vdev->dev, vdev->viommu->kvm, vdev->id);
> > > > > 
> > > > > Yeah, that makes alot of sense now, you are passing in the KVM for the
> > > > > VIOMMU and both the vBDF and pBDF to the TSM layer, that should be
> > > > > enough for it to figure out what to do. The only other data would be
> > > > > the TSM's VIOMMU handle..
> > > > 
> > > > Actually it should also check that the viommu type is compatible with
> > > > the TSM, somehow.
> > > > 
> > > > The way I imagine this working is userspace would create a
> > > > IOMMU_VIOMMU_TYPE_TSM_VTD (for example) viommu object which will do a
> > > > TSM call to setup the secure vIOMMU
> > > > 
> > > > Then when you create a VDEVICE against the IOMMU_VIOMMU_TYPE_TSM_VTD
> > > > it will do a TSM call to create the secure vPCI function attached to
> > > > the vIOMMU and register the vBDF. [1]
> > > > 
> > > 
> > > Don’t we create the vdevice before the guest starts?
> > 
> > Yes, vdevice/vPCI creation is before the guest start.
> 
> sorry but I still need clarification :)
> 
> vPCI == passed through PCI function (ethernet nic, etc), visible in guest's "lspci"

Yes

> vdevice == slice (say, AMD's DTE/sDTE) of viommu device (say, AMD vIOMMU PCI device) to handle a specific vPCI

Yes.. with general extensions of what "slice" means into the TSM
world.

vdevice is the hypervisor handle for the vPCI function the guest sees.

> > vPCI device creation is controlled by the hypervisor and is done
> > before starting the VM.
> 
> I am asking (again) because with PCIe hotplug it is not done before starting the VM. Thanks,

Sure, hotplug has to create the vPCI and VDEVICE before notifying the
guest of the hotplug.

Jason

