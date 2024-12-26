Return-Path: <linux-pci+bounces-19064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5D9FCC63
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 18:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B959162C2A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 17:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C17126BFA;
	Thu, 26 Dec 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lDvhLheJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA82AEE0;
	Thu, 26 Dec 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735233585; cv=fail; b=ZjKK1PgRC1L/HYTT8Buif0GMrdlwd5EeHKKPjWCEXD0cNfZhd48pRClk7U5zT9fORjmEmLy6ilKEHGyvsK8uPQSMopHX3j9KsP79WSr9VGZm6waG2+DtlSKIMpzEHaRdpC5dOBP93ool8KLGP7J8OiXD6FCjGA463BU0rE+M1bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735233585; c=relaxed/simple;
	bh=JtDgzzij7EyRzRSpG0LhfTahGvL+b2aKPyVZQwpBHaE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bCrnzKw0rhd+CGVaJwDQMw6FPhNKHzRenA/W7ODjMhpJeZBvtgOk5Rkas8xecKOycDObkd3NAWLIp1oHjtrW/R8bGjXuW9MjCsorc4wnlaWZI3DIMgLfXOCaeEq5K5amPTZCBdgI5yyYNSSDIoMuLCswV8R3FurjTWN4783uJ4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lDvhLheJ; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa3DEmsmF6/FwBZdHUmBJRMFiTWYSNHcLnTlXZHDwvTnf7x+8yi3L165FsPIq/yj/3A3LafxNdenTBAcEm4PT2b+eSF2BCtERRzXHeDPaxH+Rf4FqW+stBgMrGo/qZjuaItB2V74hGVDKYgD1Zl9ZYkKsZxiBSAS+GZDtBBx8AwL4AfJYB5Xhq18Qni2w3YX5M4wOeKZnlKdxaDnAnHKEAT7cyMqbF2/M33QB29dtfTFhsadFd11gxmh2Ir1DXumWY5iPZ7TV15GQQOFaCerNMaa5lNr7eyZwHkr4n4hhsdXkAdiQ9hjBDgmLS2eiI++N00f1u4oyybSRDl9QnqICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBgt7S6BiMPp1a/R7PWuABvVyCGr+++9nOrsVgs7UeI=;
 b=NhU/WvEVsiHUyC2b/P1abqK8JyqOjwdx/fXcu53IwX6GncOjJM6ZYQKUoSxebTs+7HUWofyouNLu28Ehyzv520ry8/c7p9uAPtVI8KTU8uOoHWM6nhOw6CAghu84NVeKcpJosCjdLavtt026PoQljqhkcH7alNKrRXjasncH6W/lpi/pgSuA8Vm71qLyfCp22OK+542lhIGC1tnL3ho/Mo2SfT1h0UkzzIXE6AtWQLDZWmCHuFMrdz9H2kI6z2ucjvqVWinua/4kZL9sdaO889fuipZfrQF6IVRybzQr53svyH6YOJq2jbFuwaO/lL7PClBnPeLD5EyH5bvuqbM2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBgt7S6BiMPp1a/R7PWuABvVyCGr+++9nOrsVgs7UeI=;
 b=lDvhLheJ/2OJIv1oky3Au0LtXvenab7cB3sVrJJRBEQKmcwVJtgMOBlsAi3u7ej5/Wct0MHwBiYF7JBZTnUhKl/d1Vqa7S1+AR8ikC21sWkpjeqhv2Dz6tROpUCCpxIr6HHdjuPSTDoRgb7Zpbl88azUbEhSC7xO87mCLETHYlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Thu, 26 Dec
 2024 17:19:37 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 17:19:37 +0000
Message-ID: <ff6f747a-3d7e-4460-8e71-b7cc50ba8f7e@amd.com>
Date: Thu, 26 Dec 2024 11:19:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] PCI/AER: Enable internal errors for CXL Upstream
 and Downstream Switch Ports
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com, Li Ming <ming.li@zohomail.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-16-terry.bowman@amd.com>
 <20241224185346.00000886@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241224185346.00000886@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:805:f2::27) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 38901c24-c51f-4f9f-76a8-08dd25d1795e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjMzOUdHV3hHU2dPWkxNdFpFaDhkaFdqMitoRHVJbWU3NmZtMDJ6ZVlScGVE?=
 =?utf-8?B?Q2tvcFd3Y0h2VG16YUtrMEhJaDczaitLVHhFU3UzQmlmdDhFWm0rV3QxVDBu?=
 =?utf-8?B?VldpSzgzWHVVQUgyTjlzY2QzU0l2eGNabW03RmFCcmR6RWJ4d3AzcU02eE5l?=
 =?utf-8?B?TVVrOXpXd0ZhTElCbGFUWVNvV1U3dXZ3T1A5OFFjRU9xbUpoRjJaVkNOeDUz?=
 =?utf-8?B?eURQdHAwUzFrdjhjSWpsY082VkNpWUhsYUZjc3lQNVF1aHI4aU5QenJWencz?=
 =?utf-8?B?SzlRME5jcmVDU0p3K2RZdytCNU4wVVpGaHhBNlFmZHFUdXZ6aXBla0hNRFY5?=
 =?utf-8?B?SzhsbDUwSThlSHJpMTF4R2tnbEJuRi9vRjNCQlhtUHIrOHl2N29TRXhFWmlF?=
 =?utf-8?B?cjlQUDc0Q0hHQytJYXMvZXlpdE03d0xiWUlhKzB5WndEQ2V2T2pUdzl0VUVW?=
 =?utf-8?B?T2lSVDgrN0lVUWthT0JhWFFrSWt2Z3crSnpDTmFUVnNhM21nTE02eGRoMFk3?=
 =?utf-8?B?a2xUYkp3REtKcXVLQmFDVTFFK1NRTU9sMG0rc0hocGk3eGovZjd1M2pTOG1z?=
 =?utf-8?B?bHNEUndyRUZJV0s3ZzI0UUdzSnliSG9yUFhWUHd5VTgrSDgyZlAwbTBxMnpm?=
 =?utf-8?B?UFdtKzhyQXEzQmZoYUZpL3NQUTREZVRsWE5mV05xWWtHemtxU2lrRjBhYlky?=
 =?utf-8?B?OEJnNzhUcGlDa20zb21DVGJaYS9Da0RMdnAxSDRPUWMyS1VQaWNIaHNES1FS?=
 =?utf-8?B?b3g2NWJMeW93K2FmNkppSHl4WW9BU04zU1VwT2ZjazRrb2hubElDdFUzNDFp?=
 =?utf-8?B?M0ZQNVd1MHlJVXVDVk94TXFsM0RMS1BQWEFBYlE0cFBibVloeTFUb0hFaHZM?=
 =?utf-8?B?SDI3YTZTc1h0NFRqYXBtS0FHUnJ6OENwaGE0enozU1R0N1JqYzNUMHV4c0Rh?=
 =?utf-8?B?R1N0bis2M3orak8vUVoyZWpRV09IbitNUGRkVmRsbmszZnNWUjdaSnhyQVlx?=
 =?utf-8?B?NDhiR2k1anVmR0JyUW1xbEd5eHdiNTZqYTliTk45YWh2bXdvUGhxeVJZY2Vj?=
 =?utf-8?B?dHphSTllQUFjekpaYk1hNDhDazdZOWd2M1lWc2QrOExBNmxzWHNJZ1crSEhF?=
 =?utf-8?B?VDE2UHk5TEwzM3B6ejBLaExPTmdHUExBbmRxVEZTK3BFeUJVMFQvUHplYXpZ?=
 =?utf-8?B?ZkRreFl4NGFaM0pDQURFdkIrQ1Nua3FFcVVMakEzWXZBczBPMEVwZll0aG9W?=
 =?utf-8?B?Q1Y1YUEvR2U1dnJHM0h3b2YvYjRKR25MUFRRRmlGYThhd280NWZHSVRkMXBw?=
 =?utf-8?B?bHJuQ0FhWk5aTXlPRHZWRTlKWG9vSUQyVjJOZTkwN1Z2REw0UnN6Nm1uKzFv?=
 =?utf-8?B?UHVyUEtXaGJGajBCZG9ZamhBZUpwN21BTE9TQ3FOTkFwMGFRVmtUWUYvRisz?=
 =?utf-8?B?QVNvUXdzSUZpZVZ4NVE2d1d4U0FVdkNsSndxbDdOd2UyL1BHbzN0MWZNdU1n?=
 =?utf-8?B?clFTL2hjT09CbDJlaEt0Z3ExSllsaGJWUXYvRXcwVEF5L1dhYzRzQjlmOUg3?=
 =?utf-8?B?THBySC9tcHFrQUF5VlZqS21KOUJkUG16T1k5NUcvbTJ6L1BDMHh5OFE2N2Ew?=
 =?utf-8?B?ZnpDSytWVDg5V2hLcGlVd3lLejU1cU1FOVd2TXhkc2Z1cGdJNUlBUldOL3ZG?=
 =?utf-8?B?dWVzSlVORWJ1RCtSM25FRTc2akpGZS9lZWFCcWFrTWVqM3RwajhxZXRBRVFM?=
 =?utf-8?B?N3kwYzg4czg3U2xvalNEcXZkdm1SRnQwbWxCRnNPYk5RSTB4L2V1dUZhQzZ3?=
 =?utf-8?B?YUpXaC9LOTAyNEFqNGRFK0NLekpBbUxyVnB0b0FTcTZtaFhzZkdSU0grSkdl?=
 =?utf-8?Q?urCCIugqOCmtz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkZqeHJ1elZUYWFXOU5YMkRiclZrYUdyWDMra1BmU2srbUNETU9QMjFEVzZn?=
 =?utf-8?B?R2hZbnlCWExwRENvLzlhVzN0c1RvYm1Bb3IySHZ2SWtvSEtLNGY1RnFuUHBx?=
 =?utf-8?B?S1FBaTVyeFhreWhWOWhWNlVEbjMrajFBT0ppOGVTblovTFVZUElXVGhpQ25L?=
 =?utf-8?B?Qmdrd0NUc2w3YjVSNnpTaERicTJQVUZjN1I0bkNvWmZuRE95N1ZMaEZMaFkw?=
 =?utf-8?B?TnFxY1UyS0ZhQlF0NjkxZzVad2NLcm1VaGU5Ri9SNjZRSWZuWlQ0aFRXcnFV?=
 =?utf-8?B?djRwUE1rYVBNM2FkVzBoQkJZNlM4TlJiK2VNdTRRYVZseXNMZUsrSUlQc1V2?=
 =?utf-8?B?RDA0Z3BMcWJGQzRrZ0gvS1RjdVZaSFBoNFo3ZXBqOHEzZkxYSnN5VDRtczht?=
 =?utf-8?B?b2NCbk9ERGU4U0FTbURTQm42aTVRaHMvNGtBRFE3UDlxaGIxNWh2NmlRWGVC?=
 =?utf-8?B?YjV6UHZPVjhUcVFwMUlzcHJBWTJjd1Nqb001OG41VlhJT2plbDc2WndScTV3?=
 =?utf-8?B?RFZGTXc5blo4dUZlRThDQ3R4bDdjaWg5L2ViN25tZ3pyckpER2F5NDJ5aFZn?=
 =?utf-8?B?Nk05ajR6QmFudHlLaUUwcFVEcTJHK1VQRUpOMGI2QjEvc05pS3RjYjhKcTMx?=
 =?utf-8?B?SEExTDR5K292SEd6MDJuYWRLMTZKZnZMYUdkeTVSbFpUK0hibU5QQlR6bElm?=
 =?utf-8?B?T2xRV2xQaHdIdnhFRUJzN2xjMDZmRnNyTlhDbDdJOHZqK1Y5VVc1MVFrczJ3?=
 =?utf-8?B?UzR6UVJNQTFZYlQvMkNJc2o4emdUUElGVzV5WFc2UzZOallUbjhYUkh4VU01?=
 =?utf-8?B?ai8yaHozcE8wOUZQWHlENVQzKzZjMUF3b2VWREtya0xyWnJ6UzFFUWJub0FG?=
 =?utf-8?B?RUtqRnBoUXo2NFV1V29MSUlTY0RpUHNLUkdpQ3FGejVnczJ1K3RHTGM2eldK?=
 =?utf-8?B?eEZnbmdtdW9qejdzbjFNNmVlbkg1K1hIUFo3eDg5aHhkREFqQm1PT0R6cEJv?=
 =?utf-8?B?dkxML01LN1F2dll0RDgyb0M5YXl2Z0FoeHpHMVdJU1BuYlJsdjlrYW1SVVZ0?=
 =?utf-8?B?NnZIbGVzQXJxQkxmSHc2Y3lxUnNkWThpK3F4NkoxRnVFV0tPNHlVK2hodXg0?=
 =?utf-8?B?bVNZV1lCMkxpNExKdkVQNm42Z0VVelg2MjNiU3diMkF6RkVCOSszOU9TbXBk?=
 =?utf-8?B?VSt4QVRYZDlmZE9IR2N1MVVsKzBDRGcxVWpXbmpyUGVsNkpTbCtEVFN3N2tj?=
 =?utf-8?B?RFJEN0puNFhMaHdLQUhiMTMwRlY3WnlxbXpVR0d0U093KzYyZXozRVdXVGVR?=
 =?utf-8?B?Z2ttZHlscHV1d0hhRzRyaFcyYnVFdlAzbzJudFdxQWpESlFISWpUWTBxZGVE?=
 =?utf-8?B?L29NSzJueUx6dzRRUU9FYzJIb3dZdE9KcTNtd1NRNnV3azc4Qkc4VTlQY2x2?=
 =?utf-8?B?RGk4bFpWWVpnaC9UTmVJcFFuV0MzRzJENHdVdmZrQnU2TTVYZFFjSDNVRisx?=
 =?utf-8?B?RmlzK2w5eXdCTEFRRUFDNVZ3c2NIQlFUc1lUTDg4R1BSanVzK0xWZFl6R2du?=
 =?utf-8?B?UTZobGdHM0pPaldZTGVqVU5lVXhodFpYTU9yQm13OUNFbkl2TWYvbnlyRTNm?=
 =?utf-8?B?V0Zka3VCMTZNY044VFRUTjhYOWVURmpBdWE3K3NQNFJJcTgvTndBVndkYXRp?=
 =?utf-8?B?b0RRVHlCWEtBODRQcS80U0VCVmZqdkJENEZiZ1JtalVIMzVqaTMwa2k1YXM5?=
 =?utf-8?B?Tk9EWW54OUpDUXZxKytvTDRVOXpXYkVXMElzblQ5VmRYN0JVWVpJRm1wTzNK?=
 =?utf-8?B?VlBFbTNDMElHZ2ZIUjhFejZDWXlLMDJVMFVFZlZYd1J6QXlhM3gyN1NESHVj?=
 =?utf-8?B?TFpyM05MaTdXQnRQclMyZS8vQVdyNEdYQy9Fa0ttSjMrRjdlRERBbGxJUk9v?=
 =?utf-8?B?SElZR0Y3c2NLZm1ZSEJpUXlhZzFMZXhJS2VQaWJOQmM3bzkrTnN1a1c1MTYv?=
 =?utf-8?B?WmNtZEwvZzFjRUFOS0J4b2ZaTlB1NS93K0tZUi8xcmppdkdsRStHdnpuRlVw?=
 =?utf-8?B?MTBuOW1RakYyQlRtZWU0UlBzSWRKWlp4cGErNlYxUi9sZHVyT2ZOTVVMN09P?=
 =?utf-8?Q?YR6eicSircJeOzi21Jjzw7kPr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38901c24-c51f-4f9f-76a8-08dd25d1795e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 17:19:37.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTbOiEF4O+dmOpyCEaGsDk3NSX928D5UuKnDpCJ6Z9kJnVrLkdxHBiIFPOK7hUqMbnN6qGT7JhvyslPOP5uq+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027




On 12/24/2024 12:53 PM, Jonathan Cameron wrote:
> On Wed, 11 Dec 2024 17:40:02 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
>> Correctable Internal errors (CIE) for CXL Root Ports and CXL RCEC's. The
>> UIE and CIE are used in reporting CXL Protocol Errors. The same UIE/CIE
>> enablement is needed for CXL PCIe Upstream and Downstream Ports inorder to
>> notify the associated Root Port and OS.[1]
>>
>> Export the AER service driver's pci_aer_unmask_internal_errors() function
>> to CXL namespace.
>>
>> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
>> because it is now an exported function.
>>
>> Call pci_aer_unmask_internal_errors() during RAS initialization in:
>> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
>>
>> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Whilst I'm in favor of just enabling this across all devices I guess
> I can cope with this more minimal form and it will create fewer bug
> reports :).
> It is a little messy because we are tweaking it from the 'wrong' driver
> but I guess that is fine.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> And on that note, happy Christmas / holidays etc all. My backlog
> of review looks much less scary now but I need a beer!
>
> Jonathan
>

I'm not aware of a better way to enable the interrupts in this case. But, I am open
to anyone's ideas for improvement.

Happy holidays everyone!

Regards,
Terry

>
>> ---
>>  drivers/cxl/core/pci.c | 2 ++
>>  drivers/pci/pcie/aer.c | 5 +++--
>>  include/linux/aer.h    | 1 +
>>  3 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9734a4c55b29..740ac5d8809f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -886,6 +886,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  
>>  	cxl_assign_port_error_handlers(pdev);
>>  	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
>> +	pci_aer_unmask_internal_errors(pdev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>>  
>> @@ -920,6 +921,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  
>>  	cxl_assign_port_error_handlers(pdev);
>>  	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
>> +	pci_aer_unmask_internal_errors(pdev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>>  
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 861521872318..0fa1b1ed48c9 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -949,7 +949,6 @@ static bool is_internal_error(struct aer_err_info *info)
>>  	return info->status & PCI_ERR_UNC_INTN;
>>  }
>>  
>> -#ifdef CONFIG_PCIEAER_CXL
>>  /**
>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>   * @dev: pointer to the pcie_dev data structure
>> @@ -960,7 +959,7 @@ static bool is_internal_error(struct aer_err_info *info)
>>   * Note: AER must be enabled and supported by the device which must be
>>   * checked in advance, e.g. with pcie_aer_is_native().
>>   */
>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  {
>>  	int aer = dev->aer_cap;
>>  	u32 mask;
>> @@ -973,7 +972,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  	mask &= ~PCI_ERR_COR_INTERNAL;
>>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, CXL);
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>>  {
>>  	/*
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 4b97f38f3fcf..093293f9f12b 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  int cper_severity_to_aer(int cper_severity);
>>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>>  		       int severity, struct aer_capability_regs *aer_regs);
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>  #endif //_AER_H_
>>  


