Return-Path: <linux-pci+bounces-42529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD58EC9D031
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 22:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DB4C3469C8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 21:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363432F7477;
	Tue,  2 Dec 2025 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sjTmePEN"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B512E62D0;
	Tue,  2 Dec 2025 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764709730; cv=fail; b=ZlLN03FQ4Mr0OqEl+H9exqmCax2HcB3B/ysPVBMwsqU0nXT9J88g5NGkzrJSB28F6vDmk7rnsyk8P1hKUyXFx7bIo4NdMBg0ClvyCIdA8Rk+9CNUWx7MSgFTkSwURrrm1HTgyikty+ZIFeIcJbpGQrYPy51NlXVrE71NKVC/PPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764709730; c=relaxed/simple;
	bh=1pjYXU3LXkIi3Gd4EMNcE4lqd0ER5l7gbtR8xGBL+Ho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mkiYSadrkobHg6NP2L+qSDNzTc3VIc5l2ZnU5TSH+gHhP9T9WsWA6Omsc9t2Mi05HnrtZuPs2bLLpkdpfC6gzCiQ8C8EoRHDI7WK6Hre7P+5SmuGBre5HufZYGegsSr8iBEZiRpHrHD/EQ83scK9uSWmvB+HI1xsqYjvj3V5Rtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sjTmePEN; arc=fail smtp.client-ip=40.93.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCyU1Ej9fU2AZDSCVTPHXMoHbj2C8ArDUHN0fpiufc/bQLlf1c0nxaGFzlm7CEQZvC/1QhoCFdPqT4WeoPxaZan09FlYdqRdWbUMRx3pAHJSAR0hx4YlVz3lVxtW/KvcaoVrWT1SOUajPt3Mou3RxsKb5MS2cuIRc0iFwDS/sNurlna5m8YIlKpa4sqbA/x7C1jy0ePkc76RgS4WnBaZHFd7meTZeB2sEOejjG/Di1NI8CIanaTz2XDtRx5BZsc6tlNuPlMS2mLjjAl/SfG/naRMF3FDthCmK9WIS79UKDdlbfiuWQ1X+J6O8lWFVt+Ia4Wx1SDMv9L5mU2SNm9cEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QwQhIrMuhP+hRKwtEHjKGf/vnuE/uLiqyK6fvJvYAI=;
 b=ZWBtJ9nZ3WFEf9WUJNWHSOqwK1qRa/zCtVN6au97URMmAz1vcW6Yz+JzSr3tn+Lc1R5QexjFCJZqOYhr68G1h+snsdWnfuYLEtqvm739NrrU2Bu9wib+qZFNkkUYsZmx93Qykn70y+xCHZm6S+5+tCV6Rk4uFk2n5E9Oe/SyqDm63UNPn1RBxoppbVgsrTVVfZqKsg2eR/Qze13lIj6fnEvetOuTSEbj7bB/Qcr2PhyZ1mPfPLjSed0s0hBoKI41S5K0Pi5SdbpdNVYtfmZCtjGlYIy1rrbEbe5CzbT4XBnnV9lipowrpxoDXIcISStKfuHeOS8pQIdFJT9Ux5Zxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QwQhIrMuhP+hRKwtEHjKGf/vnuE/uLiqyK6fvJvYAI=;
 b=sjTmePENWEaY9ju5xzY10OVjZ6i/15cgfmaN0TtjGf8nHTbNk8uWAABH28E7RVRf+9uhYlk0BkbGbvApjnEJni/5myRUqFo8sXzr/BDCTYq+XMSLE/QJG/9dzGpcyHx5FSOWfnHlSZWsYG9wmLa2c6v5gAc1+CEQlrHrZ5gm1Qn7zw3EQGL5HjNea2+CerRaQQzL6rYg/nv4BP/f8Kat2obAi3sTN58ohpx9HEwX9+EcA5MFBqzXzWasvCPq+ofPhYYAQgOZkFBOLqMOutXpq/KvjpSEYGMVjNOKYWjVC9DojVhkbaRxPVNTeU2JZ3T47ZF4/gTI+78wNOpARAYlfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 21:08:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 21:08:42 +0000
Message-ID: <3771655f-7aa0-430d-a348-decacafe1ea4@nvidia.com>
Date: Tue, 2 Dec 2025 16:08:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: pci: fix build failure when CONFIG_PCI_MSI is
 disabled
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com,
 kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251202210501.40998-1-dakr@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251202210501.40998-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:32b::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be8a0da-903f-4da4-c8c7-08de31e6f931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDFUbE1FWitiK2x6M2U5NnA4NUExWkE4SXpwbzlSNXNFQTAzb2Qzemhvc2VX?=
 =?utf-8?B?czFQWnV4ODlBRDNFTWREaFVsQ3k4NUFwU2h2RzhoN0dHSitVeU40Q0dUNmVL?=
 =?utf-8?B?QjIxd3VuZTgyNFVjN2VvUEZhMXB5QUIxdHR1T2NKdUdVUmJPWlB6Y3MvcHUz?=
 =?utf-8?B?aGZoMWJSZkF0ZTlyNE5PVU16MW84NmdTeHdJd2lXM29GNkpyUzhIaWgvMTUr?=
 =?utf-8?B?aFdCZEdYZEpQVDNXZURqejVtU0k2anFPM3luaWZ1K0NIdWM2UFVSWTN1OE0w?=
 =?utf-8?B?NVQydXZEdE9QSFRHZTZpNGRjcFliQXdKOTM1NXExSk1YTFVlZDlkaEY3TWkz?=
 =?utf-8?B?d3FwZExCSk1NbTFqbmlIYnc5VXdpR0ZTdkNtc044VnpQM3RlN3BpN0sxUnpw?=
 =?utf-8?B?N01ncm03WVlBY3IxRVpNS1RnTC9YNGw4bVBSRGJ4UUEwZmZydS9ucDl6UUhm?=
 =?utf-8?B?V2IvV2Y0TW9icThaZEJqWGNxcjlTYlprUnRvU0RjVEFySG9GYVQ2d2toTjhL?=
 =?utf-8?B?d2FPVEk0Y3ZmMi9DbTJWWnVKbEh1dDlQNXIzRUFNOFg4RXoyZ3UybmRUaFNM?=
 =?utf-8?B?RGJYdWdwMGE2TlAveHpJNm4vcXJiZFdHYjA1R0t0b2JtN1dKdDhoNVdSMGJ1?=
 =?utf-8?B?emNVRVd4bHEyY0lpWHFzZjRrYlpmNDBCa3d6TTZ5SUNrMFJPbm0xQUFuN3pq?=
 =?utf-8?B?N2pWZTA4cnNKZ1Z4eW5NemhzZysyOHR1Mm14cVRIM2M3Y25qZWxWaXNVZmg2?=
 =?utf-8?B?aDlJYkhyZzlMRy9GSWdPdTR4eVJGSHZ2SEZlOHJaU2hZT2RUS214b2RaNjBK?=
 =?utf-8?B?SzdTMUtyTllpb0ptTVFjbXRBSEp5TVBENEZ6L1JtRDYvUWJXSlQwMjFGNm9R?=
 =?utf-8?B?c3pNYkNmQThrSWFDYWNuSm5lSzN5TElINFdLdXBpeHNBNW1MUWl5SWpKaFdv?=
 =?utf-8?B?QXRKOUFydElobmIyWmhSZmtqdERmRlAzdUFoT1ZEK0JQTmpabW5MZjFYdmU0?=
 =?utf-8?B?UjF6U2tRK3d5ekNnS1Bsb1ZrYXhxSmhHWE8zSFBqS25YUHdXM2ZjM2tVT3VC?=
 =?utf-8?B?SW9YN0NWdUtlWDJCdlVsanN6TVhPWjRWWjVvQVNMbkJEa0dFcitvR25hQlph?=
 =?utf-8?B?MU5kcExmcDhRZWc0MDFPS1JQUVV5Z1QralVNem42b0txMkliME1wQ2hDSFJo?=
 =?utf-8?B?M1FXVnR2WExXQUJmdnNEd3lNUVgwRjVjM2tNOVVqSmxwWW5HUHZBckdLMXVI?=
 =?utf-8?B?Q3Y3aDVmTFp3Q1U1V0pLY2lLM1psaTNiaFNWaVYwQnNuZmdyK3diK1dNS25W?=
 =?utf-8?B?THF5UXhNR2xIVFI2Nk9TZ2hWbkZpQjFscXVCbEhnQnRwVU9hRnJockZUWXJq?=
 =?utf-8?B?OFJGbDhDZExlZ2dKZ0s3MXRLa0FkMEZ5VGlZcVk5Sko5N0FQdG01S085c083?=
 =?utf-8?B?Qkhwb2MxUTR4THg1aGlXdlpKSkQ5S0dPT2tDaWxxR2xlTUpwUFNJNzZFMnlR?=
 =?utf-8?B?a1JaNG1ESHQ0azRzdmZkM0N2c0Zma0U2US81NTV3S3MvejJwa1ROZVgxVnJx?=
 =?utf-8?B?Y3kvMUczRm5wdzRZNFdLNE8wYWhLUnFVNW9SZzJCVDVKNzlSRlhEZGdUa3Fa?=
 =?utf-8?B?ZjUzUkFBZ2Z1anFpZ2NhSzhnT29zRGhtNVlqMUlrd3JwL0c0L2JhQ0M1WFc2?=
 =?utf-8?B?TWZab3RCOStyTVZkOTg0L0xkU1VOakdMRThFUVhsQm5VWlUrUHRyUWp1aDFY?=
 =?utf-8?B?Yi9nWWVuOExlaUZ4eUtNai91VE0vVmlnaDdVeWF0dGFtNmlQcmYwVFE0YlBr?=
 =?utf-8?B?TUdLV203TUJSdjhibTg3a0VIZkxMMks2YzAyemQxa1pZUXVsWWZEczUzdFRp?=
 =?utf-8?B?dEt3bEJTRDh5Q3c5bDJ5bEFPQlNNZm8wZ0ZWNWw3SzZJbVFtNk1HUzRwSnd0?=
 =?utf-8?B?R3YzRDVtelN0VHdDTFl4UEJsejYySmh5UTFYOElpZWFNVUtFSEwrNFVNczdi?=
 =?utf-8?B?bTRhR1l0a3grRTdtK2Y2Nnc5WWRaSWNyNlpGbGpQbmw1bndsQ2JrN1VWNmVK?=
 =?utf-8?Q?X6yROm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0ZMeFBMMWg5RkhhUGhpbG1qYThNY2x5blZ2aWtoeWlvTmpKOTZORVp3YzFp?=
 =?utf-8?B?WlNOS0EzWS94NU9DNk1sSDhvVVpsU01CMXVjVGhqTmxhSkF2VjZSWDd2cVAr?=
 =?utf-8?B?aXl3NkkwQjVJZzhtbGFiMmhFVkZRL3ZjdXFRZmRxSjhQOHJibHhmcXVHampx?=
 =?utf-8?B?QnR1VThHSUJtNXhOd1hlS3JjNmZ4Tzc5RjNSM1A4WWJ3ZERSWkV1L21mSlBY?=
 =?utf-8?B?UTF0U2doa0hPUmhQZXIzY0gwTHNEdkh4Rm80amw5elJNMG5aSmlIbll6MkZj?=
 =?utf-8?B?OWxSdzgwRWl2ckNvTkZiMjdCeitGaUFmUzR2SnhWNDBueHdKbjlNTDdNWUJj?=
 =?utf-8?B?eEFlSXNSSDExZVdyTUZraU8vTFdFZXp6eUJ2T0QwYU9FZDJMOG5oU0dTc2ps?=
 =?utf-8?B?dTczcmpBY1ZsOUtsSG10citKWHZvb0lGSE1DSXRjNXFObkY3SFpaR25nd3ZD?=
 =?utf-8?B?dnpnYlRkdmkwM0FHZk5BTEVlYkt0MUgxd0RaNFg5SWlDRzQ4UlBFVFJOQlky?=
 =?utf-8?B?UGxBNWNXM2tudFB1My9xTXpscE45UWFXQTU4UnNBWStjK3ZVNHpiRjRhTzk3?=
 =?utf-8?B?VkxaVXdtZGpHUmY5azhFL3E2V210Q0d6akFuZDJpcDRvd3dPckM5SC9vRTN5?=
 =?utf-8?B?aEtMbitaeFRjUlFDaVNNWldiVDRRNHJ6Tm5oSHY1VzE3SitFcUxTRHovd2h6?=
 =?utf-8?B?dXN0NVN1YlI4L0dDY3pSOFBKRlo4NUlsZDdBdTlWUFMrZ0IrOE5PeXpYbHpU?=
 =?utf-8?B?d0gyLzVidnEwbExWVlZadFRYL1h2ektIbFcwYm82cGtUMjBOUXFtWVR1S3Rv?=
 =?utf-8?B?VGFHc3hnaVpBMGRrdUdrY1g2MGFoc0Y1NzZzUFo5S0wzY085WTc2THRvaXVS?=
 =?utf-8?B?cUJiakxJV2E0LzEzVEVhc0Z0QWduMWhjZG5uMkliWk1rYVVySEM2Z01lRC9l?=
 =?utf-8?B?dzZrbmwycTlCa3FvMVRiZHhEbm9VZENRRjhkWGRlVEQyUGU5TG4vbDVaSG5y?=
 =?utf-8?B?YTBxalM5bE5xa3I1RFJLMEZ0bVIzZ0VTa3MzMGkzUnZuallTS2c1bTJOU3pa?=
 =?utf-8?B?RmJHY21wTE9lYThrYWZEdDBFVXhqSzRVQ3pWeHlPbDlYWmRPTUg3eElkMlVa?=
 =?utf-8?B?bkhaYVErSzFHbzhFejlPY0g1MzNOU2ZXN1V5M1BaUlhqdVBzWkx1RTZGKy8x?=
 =?utf-8?B?OFRUWVZEaThtWG9iWVp3dDgzcGltK0pwUGZwYktpcVVtdGlLYWN4VkQ0Yi9o?=
 =?utf-8?B?SHlLYUdaNGQwLzU3UXR6cVhOUFZyNHdFeXVYaC9PaWxMdjJCWW9pSVpVOHBO?=
 =?utf-8?B?TUdaNHRBN29XUHhjV3h3K0Q5UUhOaXJIc09xZUdacy9WYllkVW5MZ1lSbER2?=
 =?utf-8?B?OGVHb2hGQXBXbloxa3Ewd250OUtNM3RGR3dvT0MzVUk1Y2F0RGUyVi83ancr?=
 =?utf-8?B?eUVyaGtiMFF2R1pEbUxhZ015bkdtRGlRaHBvMVVBSWRScU1GT0llTVlTL2tF?=
 =?utf-8?B?OFJxK0VjNy9IcDhhSVJ4WU5JbWd6c0FxNUVEQTZxR3ZTbHUveDNRWlJRNDBQ?=
 =?utf-8?B?Yi96dUswRmIyZDB5c3Q0UzZUR05SYWRhL1ZVcUtiZDlNWXIzcWd4M05maDNS?=
 =?utf-8?B?d2lTUzVCdUFYZGxGNXBWT1g5WTJsb0htZ3g4QWpYTkJJV1E0ZFIzZmNBcElH?=
 =?utf-8?B?ZW00eEY3Q012SXc3US9jWFg5VUhkSVRVemNWZ3FQRjBITFhRVHhTMHlJYUhy?=
 =?utf-8?B?VTFueTFsUGhwcWlDSUI0enpGb2ZRQ1JwMkhodnZkN3lUV3FwK0wvZHRnZnl4?=
 =?utf-8?B?R1I5VFJsQTc0T2VtMGc0NjZhZjUwQi8vRGRBd3NmS1R2TjA3dzdPWGlGb3kz?=
 =?utf-8?B?L1pSQWc5WFlEU29pakJlQ2Vyc1EwczdyS2dDR2hsRURodjd1RkU4TW84bm1H?=
 =?utf-8?B?a00rb2xJNTA0ODV6anQ3M3JSTzV4YjFmOTBUTWlIMng2Tk1HVThyWC8vZ2ZO?=
 =?utf-8?B?UDQ4ZE80eC9WeGlTQyt5RTMwdHNDT1JuaWwyUnRHN0g3a2NPRjFyYVBmU1lv?=
 =?utf-8?B?K0dmTTYvbWN4MU1vcTY1b014QlM1L1ZLVW0xclJ5ZjZ6VmZiVlQzWnRTUno1?=
 =?utf-8?Q?DpAMUocmmpNu43/VsNVlNiuFS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be8a0da-903f-4da4-c8c7-08de31e6f931
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 21:08:42.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UDOE5OE2yiG4FpHqke6YO5WcnyrK2JcpbH9hhIrIC6IWnT2Hr0xXFERyE1/C5RHz4kw1VRXgycALs2XWWuHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168



On 12/2/2025 4:01 PM, Danilo Krummrich wrote:
> When CONFIG_PCI_MSI is disabled pci_alloc_irq_vectors() and
> pci_free_irq_vectors() are defined as inline functions and hence require
> a Rust helper.
> 
> 	error[E0425]: cannot find function `pci_alloc_irq_vectors` in crate `bindings`
> 	    --> rust/kernel/pci/irq.rs:144:23
> 	     |
> 	 144 | ...s::pci_alloc_irq_vectors(dev.as_raw(), min_vecs, max_vecs, irq_types.as_raw())
> 	     |       ^^^^^^^^^^^^^^^^^^^^^ help: a function with a similar name exists: `pci_irq_vector`
> 	     |
> 	    ::: .../rust/bindings/bindings_helpers_generated.rs:1197:5
> 	     |
> 	1197 |     pub fn pci_irq_vector(pdev: *mut pci_dev, nvec: ffi::c_uint) -> ffi::c_int;
> 	     |     --------------------------------------------------------------------------- similarly named function `pci_irq_vector` defined here
> 
> 	error[E0425]: cannot find function `pci_free_irq_vectors` in crate `bindings`
> 	    --> rust/kernel/pci/irq.rs:170:28
> 	     |
> 	 170 |         unsafe { bindings::pci_free_irq_vectors(self.dev.as_raw()) };
> 	     |                            ^^^^^^^^^^^^^^^^^^^^ help: a function with a similar name exists: `pci_irq_vector`
> 	     |
> 	    ::: .../rust/bindings/bindings_helpers_generated.rs:1197:5
> 	     |
> 	1197 |     pub fn pci_irq_vector(pdev: *mut pci_dev, nvec: ffi::c_uint) -> ffi::c_int;
> 	     |     --------------------------------------------------------------------------- similarly named function `pci_irq_vector` defined here
> 
> 	error: aborting due to 2 previous errors
> 
> Fix this by adding the corresponding helpers.
> 

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel


> Fixes: 340ccc973544 ("rust: pci: Allocate and manage PCI interrupt vectors")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512012238.YgVvRRUx-lkp@intel.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers/pci.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index fb814572b236..bf8173979c5e 100644
> --- a/rust/helpers/pci.c
> +++ b/rust/helpers/pci.c
> @@ -23,9 +23,21 @@ bool rust_helper_dev_is_pci(const struct device *dev)
>  }
>  
>  #ifndef CONFIG_PCI_MSI
> +int rust_helper_pci_alloc_irq_vectors(struct pci_dev *dev,
> +				      unsigned int min_vecs,
> +				      unsigned int max_vecs,
> +				      unsigned int flags)
> +{
> +	return pci_alloc_irq_vectors(dev, min_vecs, max_vecs, flags);
> +}
> +
> +void rust_helper_pci_free_irq_vectors(struct pci_dev *dev)
> +{
> +	pci_free_irq_vectors(dev);
> +}
> +
>  int rust_helper_pci_irq_vector(struct pci_dev *pdev, unsigned int nvec)
>  {
>  	return pci_irq_vector(pdev, nvec);
>  }
> -
>  #endif
> 
> base-commit: d3666c1f8a31b7ff6805effcfedfac22454c6517


