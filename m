Return-Path: <linux-pci+bounces-32572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD0B0ABC4
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 23:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCD4169D51
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 21:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA83220F38;
	Fri, 18 Jul 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pil+gRzR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41A21C9F4;
	Fri, 18 Jul 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875734; cv=fail; b=cj5Kg9cs/maywo3SG5tic11TQhEL/Z69BEcR+Rc3d9UU3yrsSWvZhfG/uAU3inQb65Svlw5PSG9uu2q+maM7cKS/5UY9KndcKouzF2PHDiNpZcw1va2JqC0ns5S//0acXY6E3GQyKEpB9BwKlGpGwmNkWPVLQ1fE+4TAeYg6jf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875734; c=relaxed/simple;
	bh=L6x3gYjXAkfEm7Gn4HRtuy0IllTonwrJdkH2cBuQ0Bg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N/iaicQzdi8rJt1Pt6YNN0HSEK3Xy8oLtNeJzd6BfIeaTRIFqKC//0/ZzwkiVZdQEvBYT0OQMfvNaKRMWJEWH7R9nvH+DSSHcKW0DwnVksAOeoS3A8kc6P+nMjNH6n5DmTqrDqr9tCWuFD0OVdV6jCNraYOj1ZIwsJYxILCswMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pil+gRzR; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6WaKSvMJSwN0cF834SkpNDE92khOUqlCK03gnL650xj40blkQdEdvq1CaPz4XsDDDMoaa9Svn9kvrFbCXsvP4C8FIpuMyTqDxKuYzeR5BG+rbKe0JN/xKf9EIp9azApYDS2Vh/K97UtdyJOFKxzV2hf/DYTumNgK+LozkVWJndsS3xsDMkrxYX0YzQ2VCwPU+2A14U8Smf0MWcpe9USejtpBpM0TS2tFNw3u8g+ZVu2uVzqABOyQC+xt6Yd/kpl/r6S+XsKvRzlHZokH84qz2dIE1K/qofB7rXNKDHTd7nncJZyvIEF+fLLRJFiKW6YysU10Zvb8FmneUtlg9h2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PNYqPUB8reXSZsZBwh5bgUWz86HHNOw5kCEDLjs2XA=;
 b=RfDa3wd503jKalUQEOzX0iaILayduo9VYYy5ZGx96RJXIDBSfHqIWjEnLPMyoVNj6rG2lpKdWNU6sykixH3ObjHUfWMuN4Lg6fbuCD3zgAXhaKVnSllaDldxRCnQ+hKQJ9ECYRlv4Ow4B5XrnTEDKj9Iq370PioKHZzVkbjYDXaw25UXEuqIewXcnWMJNVkK7lnXOLs/BoqXwFAtNTNW4R7gtqVbJAXSUSVtWaN829P8pVt2AYpyOcVDiwbJqeil/MTE/Xt+nqvYmBwukc6N00lkoA2ENRsDeiKP84GTQ8ll94oDBsPw+yJ63nBf5RO4inp7MhtyXGILnEZTURJLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PNYqPUB8reXSZsZBwh5bgUWz86HHNOw5kCEDLjs2XA=;
 b=Pil+gRzRlKMec2zXxQf3nEvGH9rGXvWPmdiSBl8hMDunM7bimmiEW8hBMhMACriGx/Mv8V6HFaVs8+fDXoAjGQWMrSXVYnyQmjNe/+5hJBdPDimEuXmkaybCgDG3ScRLUbfvDyLCHHvXEefMYx/Bm5lgJVFDvMX2MLP5dhriUZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Fri, 18 Jul 2025 21:55:28 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 21:55:28 +0000
Message-ID: <164c69a6-fd73-4fc1-990d-37e920582d81@amd.com>
Date: Fri, 18 Jul 2025 16:55:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/17] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-10-terry.bowman@amd.com>
 <a5b917d5-126e-48a8-b9c3-91d7bb2466e4@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <a5b917d5-126e-48a8-b9c3-91d7bb2466e4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:806:130::35) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: c7399680-a209-48ca-75ba-08ddc645ced4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVNnMVJrL0dibUJVTTRkNitDTm1jV3FpN1VoYk4yeUpuT01zY0hDakVXVm9k?=
 =?utf-8?B?WS90RXJNR2g0Ly85ai9EaUZONTVNYXNSTFdLOFNxcWVHTkZ3a280Y1JQQ09u?=
 =?utf-8?B?TUxObGFydGlKZW00dGxWVTcxYXBSSlphSEU2YnRyR2o3QkFkN1RkM0J5Y3l6?=
 =?utf-8?B?cW0yR1lCZEFXUmw0TzdMR3ZMT0RVOEd4QlM3WE9nRjhMbEQrS3pmRElQQkRW?=
 =?utf-8?B?OW0xb0gvVTdXcjZWa2l4QW1iSm1vd0EwSnBqL3BkZHp2VmdJMktGNzFxdDkv?=
 =?utf-8?B?UE1qZHlSN21QSnNwNjFXZGpvTURIdUFHeGhwU3o2NWFSa1NodHVkckhBY2sr?=
 =?utf-8?B?S0Rybkw4Y003TzZaRDF1dG15RDNuSW8xVWZTUE5NVmpvLzQ5ZWMvanFHbS9l?=
 =?utf-8?B?bjl5RnFHeDR3RHhVVU5WRkF1a05ybU4wd2F2TlBVYU5TUzV3WmVqWE9JaGxZ?=
 =?utf-8?B?bVp0ZzFGYWtvTkNvUmJHY28vNHI5Mjk0RE4xd09VVDhGblR4eElWMnNkQUwx?=
 =?utf-8?B?K0hocDhQQlR0NzhzUHhtZHY2TmwvRitMZFNvZFNmZVJXeGFNNFVGTVRCdzhn?=
 =?utf-8?B?K2VWQ1lmS0YxdHBtZUhSc1lWM09rZ1QrTzQ0R2ZSZzJoU0tWeVR5Uy9JQ2JI?=
 =?utf-8?B?THVLNFd4SWNxZXJaSVJySm9YeUh4aHBwR2hUUDlKOXFjdCtwaHBEbTY4eU02?=
 =?utf-8?B?MENrWVc2VTdHRU93QVhCNVM1OEJnM0ozWEJKTGZ0QnhEajc2T2hkdWtpaTdt?=
 =?utf-8?B?a0hSY1NhUnNxTW1PdTg3SVpjSHJ4UEpoaDA4UzIvV1F3UWNSME02VnhzdVI3?=
 =?utf-8?B?N1hkVUNwYXFJeDBMNXl0MlRHNWgzRkZjd1pmQTA1eGZYbHp2WFhaKzJpblVq?=
 =?utf-8?B?TGN3NDUxUG85eWtMTVlXRFBGbDJDWjJ1RXY3eHAreUZTQUFUcFFtY21tQk03?=
 =?utf-8?B?Yk00V3ZHVi91NjQwd1JxLytvakpYRWtqSzA4M0hTTUV2ZTVJL0xTMVpjYnNk?=
 =?utf-8?B?TDJIeG1lVWw1eVR4aVE5ZmJPWS85Q0xkS0Z2OTZVaTFEZUh2OWQ0dkNreXdI?=
 =?utf-8?B?TGw4U3RTbTFReUo5VjJ5WUZXMUxuZWJCTCtOZkVXbzVJQmpmOVZvVTZPYWlh?=
 =?utf-8?B?RzVmbW9hNlc3UjRmYXc0ZERKWkhIREVtUllHeGMrakM3Mk1pemNBODZQV2I4?=
 =?utf-8?B?YmliOElSbWhLTzNNd3FxQ0V0M1NxZEZXbnJwYjZlcUtuQ1ZhN25LckpGU2lT?=
 =?utf-8?B?SVMxYklVMHhOVVoySTJRUkIxM01UaHBUSlVXYTJwejRuNSs1WG5QbndXMytG?=
 =?utf-8?B?ejh0THNGTVczZ0Joa05BakxkUkVnNHdUTkFsUkVpWjJYREw1TVBtbmwvT3Bn?=
 =?utf-8?B?SUJBUUdXeVArVk5UNjVlaXpDUUJHcGJLcGNPL3RvU1ZsS3FHejJSZVJuanBB?=
 =?utf-8?B?MTlodVFzNURMOHJScUttUmtaNzlWZlJ6UVJpbk5RSTBjNUs5UUZwbzFjK2xn?=
 =?utf-8?B?V0lEaDNZQWMxSmRRcEFKUUR5MVRoMjlUcW1idVoyZGtnSlRqRksvQnNaM0lP?=
 =?utf-8?B?SnMzMjIvMTB0MGpYWjM4NWdVSVhEeTR0cTI5RVg1emQ1ankwY1pOUjBwRWVq?=
 =?utf-8?B?WGVsczdKaXh6VWhLUmxwWUdYb0hIMzYyMm1sNG5YVlk5WVdJdkxlMWZMblNE?=
 =?utf-8?B?aUFNL1FSUHQzOXNJd0ZnV3lYamJscGRzSzFxVGVWaXUyb05tajR2UXdZSHJT?=
 =?utf-8?B?QWhEbjQzZDBZc3FOUGxNQ1F4bXhxWUFDS2VIaU5icWtIc2ZQRDhvTE8xU3Uz?=
 =?utf-8?B?RkNmWnMrTTFBUUlYZjd6V0JCanZVSllOZEtFdGpsaTA5ZmI1SmVJbUp0eTg2?=
 =?utf-8?B?NVpMOG5XNW5ncVNKUURsUVArV2MvNWxUaGJPVFp3dXBDSStJV1dtWU9WOUVQ?=
 =?utf-8?B?N2dmSGkreWRoakpFQWQvbXJPd3l2aTV2Vm9jOFFuQmpHWjJhOFd0ZjBKd01Y?=
 =?utf-8?B?T3Y4OHVGeHZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTJYS293VkMwTjI4RzdlNndMeER6ZkFDWTJ0NUlCYWNVSUNxYWtoN0xBMDJo?=
 =?utf-8?B?eDBYa0ZCVm15NG1HOFNvcUpmT2x5U3NodUduTnVDa1hqV1Vvb1krZktKcW4r?=
 =?utf-8?B?azZsY0J6ZDBvVU5KK3BZMHhFY0ptb1RDM2thZ0FvWjJwUDhtMlgrYWtLc0lT?=
 =?utf-8?B?UGFHMHNYcHB3M0NWN2wxVFB0UEV0ME1jelFWMkdVdmJxMVBMSUxqMVBXOWVN?=
 =?utf-8?B?Z2crb1R6Q0pVa3I3Qk5XN0xwc2tocjdwWXp2K0w2RTQwaWZ4RWFQV3R4MWdp?=
 =?utf-8?B?MUtQdXA2Q1U5OTJHTGF2NlNhblcrdUdVcmZWcVVMcENuTU5NREMrRmRxdlp6?=
 =?utf-8?B?WGJ3UEd4RmZxZjZLYWFydmpWWlpYSEZmS2pRZWlGbFczcVZ1cExHNWZlalg2?=
 =?utf-8?B?NXdCRVVrbG1laFpaQjNqNUphVzFKVU40L0FjK216VnkzcVUvTjR3MjN1MWNt?=
 =?utf-8?B?RVNhbnh5bXNxa3FMclZoZTMwNXY0L3RLdFZwelV1NDNmZWV3RkY4UzdZUXVU?=
 =?utf-8?B?dVV4ZlVMbldTUVNZU2JuVzlKRjI4L1RyTEsvSHhvKzhOMi94R0NWTFlzcDNY?=
 =?utf-8?B?WXRnUHpSckw4VFhPOW5FVmozaVVMYWU1c1dtOGowTCtRQTU3N3NIQVVHSTlP?=
 =?utf-8?B?NXM5cUFHWW5GUFFYSUdHVUtiemx2VkFrYzhrNkJyREZqemZOVzNQU2JCaGJv?=
 =?utf-8?B?c1hSWklxcjNvM3hBVFhSdFlERG1VU3NlcHpCUGVmT3gzTzFZQlBXMXhtU1Qz?=
 =?utf-8?B?WE9ReVphVXBWWG9WU3ZWWmg1Yk1sQVlpUUkxYTdRUng3Q2JFZ1BMRjFYdDdH?=
 =?utf-8?B?RkRudTRTUkZDaTVtRnRFUmJ3SHkxQ2ZYNDV3UTVhZmVlOXlvUFF0bE0zSVNP?=
 =?utf-8?B?aWFiYW9aUEloQlBTWjFUdW5QenJMRVEvSnFhTDRWMGJ2aStPMTRCNDVhTjBs?=
 =?utf-8?B?WGJxVGZRR2s3d1Jya2ovSmJONDNobnZ1bjJnaVZFN0pWVmxyUEtJMWt4eEZT?=
 =?utf-8?B?ZzlhNDVieWswbWM0dUVBNEl5eng3Qms2cUh4R2dRVWJDRlJ3YUJ6STFmTG5Q?=
 =?utf-8?B?QXBteU9GdlJvTWMwZlhwTlpYV0pwMzBuam54dTN0eVAvcmlyS280WUNQUEVw?=
 =?utf-8?B?bSttek5jNDRjMkhWUXNWZk8wNStlbjFNOFE1RGE3Mnd5VTlTMFhmNW5uSXpI?=
 =?utf-8?B?WGE2MDNEZWtYbDBnRWdpcmhXVVRmZ1pHaVJ0RUVkRkR6NG5vdHJkVEtKQ1Fp?=
 =?utf-8?B?MHpJaXgxV2FrajIyeUdYdzdrUEhEYU1tdkRWWUxTMUhyaXZ0My9FNyt6N0FW?=
 =?utf-8?B?dm9mNDVSbHlVZHNlaTR2Vkh5MjkzcnhkZEh5TWhBOXRxaGlJWTZFYzE2dm9G?=
 =?utf-8?B?YmZnRXA1aG1XYjFsSzhlSy9YS3JhaTVaeGhINUdjaDcwMkpmMDNBSmJHUFVh?=
 =?utf-8?B?ZmNEajBLdTllTWFPSVVBV1J0SFVZNUJVNGJCWEQxZHFqTzJtT3lRbFoyZDQz?=
 =?utf-8?B?Uy9veHRQeGlydWpYMStESGpIVmF1WlVhRCs0dzA3anR0VUE2NXB6OEtXdytq?=
 =?utf-8?B?OXdFVVdhem4rcnFYWFA3cG9vTFBhVi9oTkdCejNRNXlGTjBRUmIrMVZvWmV0?=
 =?utf-8?B?TUVXYnJhS2lOR2RWRGtZeHh3dzBBY2d5eE5paEdVUVdmYVJoOG9qcFByZ1Fo?=
 =?utf-8?B?ai9aZkkyN2s0SXREM1lvSmpEbnY1T2FSUmtReWI1SkVkSnYvSkd0aDR1TXEz?=
 =?utf-8?B?MGNlWngyY2szaFhVaklkMGhVWGNMdGJES1l4U2ZVVDd6aTZVaHd5dU5FNklP?=
 =?utf-8?B?WnhYdHBKNVlkY0RkWkZCNXZmNWE2QU04dDgvVjI1MzNkV0VrOFdseWJvNHF4?=
 =?utf-8?B?bGpUaG1iVXB1ckFNTUk5ZGJLSDE0MURjR0NrMlN5UkZxTWswNTNQdFU2SnBD?=
 =?utf-8?B?QjA0NVVLelhjVlV6TmhnTHRzSFEyZ2RsbTBUTCtEQkluMXBnVDZDU1p1M0lK?=
 =?utf-8?B?bGw5eFd5Y0dKdituNjBDYkpXZmNiMVZRUEZtVkZQb3hXUUdCYkVNT0Ftamxu?=
 =?utf-8?B?UEJmZDlDeXN5b2NZK2NTdGtldndKQ1dzbW9FQU5OR3FOSDJDWU9tMEtoL0tX?=
 =?utf-8?Q?h9f9tSk690NtsV6P6ia4+TN7q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7399680-a209-48ca-75ba-08ddc645ced4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 21:55:28.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlYymdjIBGKPozRPZhg/T9Hf2UaVYK2a9driiGyfbvLX+IqRJqtUwDZZ8GrhWoL3bcMX6u/w8mR4RErG6zaTDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938



On 7/18/2025 4:28 PM, Dave Jiang wrote:
>
> On 6/26/25 3:42 PM, Terry Bowman wrote:
>> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
>> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
>> mapping to enable RAS logging. This initialization is currently missing and
>> must be added for CXL RPs and DSPs.
>>
>> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
>> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
>>
>> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
>> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
>> created and added to the EP port.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/cxl.h  |  2 ++
>>  drivers/cxl/mem.c  |  3 ++-
>>  drivers/cxl/port.c | 58 +++++++++++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 61 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index c57c160f3e5e..d696d419bd5a 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -590,6 +590,7 @@ struct cxl_dax_region {
>>   * @parent_dport: dport that points to this port in the parent
>>   * @decoder_ida: allocator for decoder ids
>>   * @reg_map: component and ras register mapping parameters
>> + * @uport_regs: mapped component registers
>>   * @nr_dports: number of entries in @dports
>>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>   * @commit_end: cursor to track highest committed decoder for commit ordering
>> @@ -610,6 +611,7 @@ struct cxl_port {
>>  	struct cxl_dport *parent_dport;
>>  	struct ida decoder_ida;
>>  	struct cxl_register_map reg_map;
>> +	struct cxl_component_regs uport_regs;
>>  	int nr_dports;
>>  	int hdm_end;
>>  	int commit_end;
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 6e6777b7bafb..d2155f45240d 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -166,7 +166,8 @@ static int cxl_mem_probe(struct device *dev)
>>  	else
>>  		endpoint_parent = &parent_port->dev;
>>  
>> -	cxl_dport_init_ras_reporting(dport, dev);
>> +	if (dport->rch)
>> +		cxl_dport_init_ras_reporting(dport, dev);
>>  
>>  	scoped_guard(device, endpoint_parent) {
>>  		if (!endpoint_parent->driver) {
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 021f35145c65..b52f82925891 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -111,6 +111,17 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>  }
>>  
>> +static void cxl_uport_init_ras_reporting(struct cxl_port *port,
>> +					 struct device *host)
>> +{
>> +	struct cxl_register_map *map = &port->reg_map;
>> +
>> +	map->host = host;
>> +	if (cxl_map_component_regs(map, &port->uport_regs,
>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
>> +}
>> +
>>  /**
>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>   * @dport: the cxl_dport that needs to be initialized
>> @@ -119,7 +130,6 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>  {
>>  	dport->reg_map.host = host;
>> -	cxl_dport_map_ras(dport);
>>  
>>  	if (dport->rch) {
>>  		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>> @@ -127,12 +137,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>  		if (!host_bridge->native_aer)
>>  			return;
>>  
>> +		cxl_dport_map_ras(dport);
>>  		cxl_dport_map_rch_aer(dport);
>>  		cxl_disable_rch_root_ints(dport);
>> +		return;
>>  	}
>> +
>> +	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +		dev_dbg(dport->dport_dev, "Failed to map RAS capability\n");
>> +
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>  
>> +static void cxl_switch_port_init_ras(struct cxl_port *port)
>> +{
>> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
>> +		return;
>> +
>> +	/* May have upstream DSP or RP */
>> +	if (port->parent_dport && dev_is_pci(port->parent_dport->dport_dev)) {
>> +		struct pci_dev *pdev = to_pci_dev(port->parent_dport->dport_dev);
>> +
>> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
>> +			cxl_dport_init_ras_reporting(port->parent_dport, &port->dev);
>> +	}
>> +
>> +	cxl_uport_init_ras_reporting(port, &port->dev);
>> +}
>> +
>> +static void cxl_endpoint_port_init_ras(struct cxl_port *port)
> Maybe rename 'port' to 'ep' to be explicit
Ok
>> +{
>> +	struct cxl_dport *dport;
> parent_dport would be clearer. I was thinking why does the endpoint have a dport for a second there.
Ok
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>> +		cxl_mem_find_port(cxlmd, &dport);
>> +
>> +	if (!dport || !dev_is_pci(dport->dport_dev)) {
>> +		dev_err(&port->dev, "CXL port topology not found\n");> +		return;
>> +	}
>> +
>> +	cxl_dport_init_ras_reporting(dport, cxlmd->cxlds->dev);
>> +}
>> +
>> +#else
>> +static void cxl_endpoint_port_init_ras(struct cxl_port *port) { }
>> +static void cxl_switch_port_init_ras(struct cxl_port *port) { }
>>  #endif /* CONFIG_PCIEAER_CXL */
> I cc'd you on the new patch to move all the AER stuff to core/pci_aer.c. That should take care of ifdef CONFIG_PCIEAER_CXL in pci.c and port.c.
>
> DJ

Move to core/native_ras.c introduced in "Dequeue forwarded CXL error", right? I just want to be certain.

Regards,
Terry

>>  >  static int cxl_switch_port_probe(struct cxl_port *port)
>> @@ -149,6 +201,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  
>>  	cxl_switch_parse_cdat(port);
>>  
>> +	cxl_switch_port_init_ras(port);
>> +
>>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>>  	if (!IS_ERR(cxlhdm))
>>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>> @@ -203,6 +257,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  	if (rc)
>>  		return rc;
>>  
>> +	cxl_endpoint_port_init_ras(port);
>> +
>>  	/*
>>  	 * Now that all endpoint decoders are successfully enumerated, try to
>>  	 * assemble regions from committed decoders


