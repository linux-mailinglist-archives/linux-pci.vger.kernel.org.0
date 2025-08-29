Return-Path: <linux-pci+bounces-35078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AE0B3B0FA
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 04:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D37916AE5E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 02:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E2D1991B6;
	Fri, 29 Aug 2025 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pm1BhrFc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021A1BC5C
	for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756434086; cv=fail; b=KphwKolt4ZyyEAgd5SeZSgqTXxRVNROKn1hOD0c1UYQUjvS8pgyedGp1DNbLEneYWJhaSFq3XEsuLr+5WP/8m4RrpUWLOK6dFwL8QEcSRQSFMwJekGdfI3gSlNhaZU8Z1j4zIfTLgw49YfSkXq22wrz7+WYs4OeQYbCd21beySY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756434086; c=relaxed/simple;
	bh=MxaefC71zGM4A4MOQe47NsSfdzx7BKkthk/bKgcUTio=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uSUyKT6dssrAYe8ZVvRUYCQeIaknj8M86DiK1lITGV5Zyb0Y9u9AXsqRg8pLDsVHHLidTBM0XqQ3k66b80VbTmEzG4m1W9xkeG5b7+LFJ/fgvq0AKbR+P7aOD/V+ahVq+rV8LQhcv99meNbnyHuKIp4ljioT0BreQjeYUrSMA/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pm1BhrFc; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD6QXhbG35Gpy0SIyeXg1GfboZkswh51W2fJySIJS38H58jTpU0QiTo4P2izoajfigmPZ4Qrt9yl73r/HG3igciDuEgSFQ5NhKrBApnuqepSNg7qA6lUwAl2wNM79lvC34YmWd1FFUohkafKQ+dDZl04wuK0z43Ry4jyKr6kEC5yacRGkzcmF6Unwj9RyZdLYvT0SsLM/NYYzftHVL/SGhVl3aU6tisVl1PHGUl2+toLmUqEbw5+aJEZUYLS8ib5bwY8YfLdqDH86vbCTOiAUHEIZwg+flA3KnOi/SQFXDHQsIFkr+C/LQA3ECKTjMIDc2aIlXX7T6IOW9UhyZMCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlBCt1WO5EQJlXSzj5lJIDYrgnh4XJ0+7w0yaIAiH9U=;
 b=RqKmg1r3tazi4GxzzCgOZv3syRHDE9Hng43uducF8CusJkYnpufJt20LynXRBFfDF4qLM7WhBY673phbZfUrNxj+LLch7lsCl0+ON9nLHbA2ZZu1BLfOO0Thz8jIzTHWLi6886yxaJ26EcOCMVdx8ZUrQ2oUcij0peCjR+DrFJhxVamS1RrVAdlWwaHtm31DJAJ7fnWPUurNNNsR/Yh6dfHBsJ+CG0QwVSuvkBT2zhd9g2CS39OpK3FLkrZ3oauLGSjv9EPHLskwc3vHU2wix8jk3cGqLJMAGZf7b0o98fYcCLOzovpmSCStkgzOi71CDxTa+DKZFG7Z2wzRTxeL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlBCt1WO5EQJlXSzj5lJIDYrgnh4XJ0+7w0yaIAiH9U=;
 b=Pm1BhrFcWwaFieiMOXm8qDqmexd1IWY6vARoZL2n2/P1IlhoQ47ilg/97eBcvA9Hi1meoxtB9gbXXweJSPAeqWbAnazoGDyp/8pbrpP5qlEcwLr0wG6FxL44OIxwwj1kx+VvW1cq4v0aQQvhFEStsG6Lf2ePHyugATJmU75b9KY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 02:21:15 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Fri, 29 Aug 2025
 02:21:15 +0000
Message-ID: <101dc0bb-d6d1-4f29-81fb-fb1ff78891ba@amd.com>
Date: Fri, 29 Aug 2025 12:21:09 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com,
 yilun.xu@linux.intel.com, aneesh.kumar@kernel.org
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-3-dan.j.williams@intel.com>
 <e680335b-bd40-4311-aa13-58bc2b0b802c@amd.com>
 <68b0d30e2a18c_75db10050@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68b0d30e2a18c_75db10050@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0138.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::14) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3f3768-e5ce-4316-8478-08dde6a2bad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3dNMUVQTFZoUmIwZmQwOWorQWxBUHJyai9LdFBVNWJzOUdwaWg4SnFnY2g2?=
 =?utf-8?B?UFVmTEFwc1RscWVvWkFOcFhxRWNKWU9pNzlqZDJvaHlIRFUwZ2JnTFNDYzJ0?=
 =?utf-8?B?LzFnYWc1dDhvTDZ2SDJFTXJjTkNpejJSVmpsS1Y4RVlWMDVYUkM5KzMvalVR?=
 =?utf-8?B?YW1iQU5Cd21wNTYrbitqbXJGa1p0Qkl0bnl0bEFuTmJlZzVsMlR0N1A1Ly9i?=
 =?utf-8?B?djJmbDAwam9jRzZtV2RHaHpXWjNscDJpdnIyYmhQSDZYVXhHWHgrMHpmQXI2?=
 =?utf-8?B?ZzRRaE90QTM4K2tYSUtvdFhzb20zVGtQQVJJVHhHSWM0L24yTkRTK2U2U0Zk?=
 =?utf-8?B?T05IQVZtSjVVd25TOHc2TnlzOERBOXhteGJvSmZBaXQrUlpuTFp5UHdEak9V?=
 =?utf-8?B?ODNCZTlGeS94RmVQSmpiZ1hJTFc1enAyM1E4Qk5SZFNCTEp3Y0FGNjNwTmto?=
 =?utf-8?B?VFUvU3NwTy9BeHlPcUlycWgvTDBaVXhCVVZFb2E4Q1ExTEZEb2NUTTg2bGgr?=
 =?utf-8?B?bFZnWTFLSUNhcWdRdUg5b0cyaVBEd29pbGZHcnM1TmlMOTNEZ2llUi84OGpo?=
 =?utf-8?B?R25Ib24xTWoveTNNNSt3TmVhY0pYVStLcGROSjE2WHRWT2lVKzdhMTRjTnVY?=
 =?utf-8?B?VmUyQnIveXFtb2Z1TE1OOWpaV1hyMnluM2dnZHE0eHhNbG1mY3k3Ymc0MWxw?=
 =?utf-8?B?dnA5MGNjanFzWHY4OUY0cEsxNTJXbEpjdlIxRFkxcGNoNmVPZkIxaThxSWVa?=
 =?utf-8?B?ejVRT1F1MDFtekJBOUlrRVlmbS9Rd2xRRHhuTm00M2JqYmtnVFFNMEpkT0I1?=
 =?utf-8?B?em1SUmNHdmx4aUJ5T0paZUIrVTFJc212SlpXanV6cmlrZWxFMVYvcVBGOUJo?=
 =?utf-8?B?L1Axd01aOEI0cEdFcVFrV1pEdkZ1emF2bFJoenhlQzhuaWtsSWs5b21DTDQw?=
 =?utf-8?B?VXlpaFFPbmZBSFlwZE1DQUovOFJLQkxpY0N1c3I1VG9XSkQrQjBBQm4wN1NX?=
 =?utf-8?B?bVFzN2gxbEdHcUt3dnpFam5tYkg4Y2hjV1RBYmJmaytvYlU2azhUeHFibzgw?=
 =?utf-8?B?Ukl0RExtVlJaYVgzenpYcFpHeDJqOGFQR1NUTmJoeVh2SFdjVGozR3dLMjl4?=
 =?utf-8?B?eWg5eUF4NUppRWNTUy94TmxVRHpkUG9qRnVPdm84ZVAzNzRCUUxKUG1SekxO?=
 =?utf-8?B?Ukg1c3RwTmxhTWFwdWhLNkU4WDY3VW9PYUt4dFltZXRTQlh1WkYzSFdCaDdM?=
 =?utf-8?B?Q0c5Uld4VDNvelUvOTk3azMwenFxcVdBREFVMkNURUZCZDZnSEkrSEQ3QVd5?=
 =?utf-8?B?TVhPM1MybmVJdGxOaHBBZTgrb29pUElVaTloRVBaMUJLenZFZkRHQXlsbEVx?=
 =?utf-8?B?eThIYjdDazZNUjczRXpXeGFTVzZBQ2x2b2UvRTQyaEpENlExZU9zTWhDS2Jr?=
 =?utf-8?B?aFVaNGR0TEJhc2RpdksyWGhLWVRCemx5WEx3eW5YQzhQalp5dDZMVDZaOVF6?=
 =?utf-8?B?ZWxoM0J0WVBMeHhuNXRiYUIzQXFIeGd2UXhYb2M0SFNVM1ZCNVlnOUx0cTNm?=
 =?utf-8?B?RUtmclNpL08wNWUvQy9TVlQvek80b2Mwc1c2SWsvSWUrMFlkQlhFZnB3eXJj?=
 =?utf-8?B?VnErWmxjaCsxYmY2TzNoaFpXWXJlcElrdTgrTWlqNDgrQ3RaVkNYWE1GM1dh?=
 =?utf-8?B?NGJQNytjZG1xZ0trQ1BEV0lvNEZzZnZmWlQwcmlnY0N2S3ZxVGVqTVdDUzd6?=
 =?utf-8?B?Ky9nQnY3THlZbzBjTkhkUDBpcXh0UEJSTk1HMW5KM1JyNlpudno5OVhuYlBu?=
 =?utf-8?B?bnp6Rlkwempqa0RHWW1XRVhQSWFsQm1PTDBCVW1rVnFKZnpVY2pEeXJpNFBI?=
 =?utf-8?B?ZG43MmtRNlhLYmpwNklYSmxTRktPS3JwN2RNSkpOMjBTbktzTjNQbkdxRGg1?=
 =?utf-8?Q?XXUpS/CEncQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzhQeEpnaVE4QWdyQ1JaTkFULzlWZ3hkeThxTkYwZC8rQVZNV0FpL0Z6WHZM?=
 =?utf-8?B?YUlnbmxhSW14TExkTS9KYnlkbmJZQ3dRVjlFNkdxT0dWTnRMN05aM3k0SDd5?=
 =?utf-8?B?TUo4S1NEY29PeWRoN2RHZWExWUJvK0RpNW1TYXZKT1E1bVo5b0FuYnB0VklO?=
 =?utf-8?B?V0E4R0RnNy9PcVVjNWxhQkZiM1NjUkxSUVRFVGgvRndwR1RrS0gzUWJQdUdv?=
 =?utf-8?B?ZjFqMEVtQ3R6YjVDbWFrNjdNb2Rzb0lyOEJJVDdiaGRtN2tiU1RuVXk3STFk?=
 =?utf-8?B?amw3Y1NHbVlGZTVkVTExYllYeGRlK1AzMVhYSG42UHdLckVCSzViMVFyY0Qz?=
 =?utf-8?B?MWxtVWRZSEtQUUtjOWRjYnFNdFZXSmZUR1FuWm5VNENyVm5ZQTZaSmJpcEZW?=
 =?utf-8?B?VWE5UVBoelpWck1ZWlQwUnlPWFczTHAwNC9tai9uRm1Xdk1rOTdBODRZMmpl?=
 =?utf-8?B?L3NMTnljMkt0c3owOGtkM05EdmRLcVRtRzlSZ0x6VkJ0dHlHdWlPbzNqZDJi?=
 =?utf-8?B?T0dFaUxOQ1FPejhsMkFteCsrdVhHNml6WFJ0TkVoT05HV1prTThHTUFLNXBi?=
 =?utf-8?B?UUNVWTlZL292SVV1dm16TkhHWmJ1OFpuZHJhalcxVCtRY2JDMC85VHVnRzBu?=
 =?utf-8?B?bU5kMC9IR0U0QWdleEJiMStOODZ1S1pxRWpWRXl6RTdFRHFIMEpkdnhEYmxx?=
 =?utf-8?B?T1FOay91bXJSdjJEU2JWQjZYeVRVeTd0cEtrYjNOdW1MeHpOZFF1Z05xYWRO?=
 =?utf-8?B?UWN1MDVaNDNBaEcyWGI4RzNacXN1Tlo0SlA2SFA5SG52VTBtZDFzY2hMejZp?=
 =?utf-8?B?cUs2U0pVV1YrVFpHcmRmdlVneGxQYmtRK0E2VE5yN3MrUXR6QlBORldvSzcw?=
 =?utf-8?B?ZUtJTEp0WkVqUlJyaDJtZ2JWZlM3NFJxNG50bHl6YTdKOEY1cWNQdURaNjZK?=
 =?utf-8?B?SUVEL0FDV3JtV05ZZ2ptSU51R2hSUUlmNHFDY216Mmt5d3ZsTW1PWDBIeVh5?=
 =?utf-8?B?V3RmQW5wZG95czNscFlZdXY4Rk10ZU9tQUEwdXNUNk80b1NaeDFsak11YVFU?=
 =?utf-8?B?NUh2RzcrRzBiUFdySU04UVU5MHhrWjZvbXZYWDVFUjBaU1FuMU1vMGdiYk41?=
 =?utf-8?B?cDJISWc0UjllK0toWGo2aWwzMTVnTjdWWUFMeHo4aWsxWjdyVEM2UXNPQnJL?=
 =?utf-8?B?Tmhjc2ZWUDMwSG1HQmc3S2ZKTFkyeE1XWG80YVhwdC9hSE02T2ptSndlYmk4?=
 =?utf-8?B?QUtubFNkVVEwZGVROEx0SU1SWDZ3Z2YrYUNjc3FMaWZqN1JMR0t3cXFTTkI1?=
 =?utf-8?B?c21MZ3hvWndxWGlRdndSSDltaGppMmFuVU1aTElqR3p5N2dtMUdLVVVMWG53?=
 =?utf-8?B?dkVleVk0N0lQMFlyNFoxQVNKMzlpMU50M1F2a3Z6SSs4OFZQTzRQelBQTDFv?=
 =?utf-8?B?cXBXYytCeTdGa2NybGhuZXhCUmQ3dUxFb0ZNckZhQTJLWFp1UHRQRFlKQ2ow?=
 =?utf-8?B?cFBkS213Snc1bkRVbmhvN1cvQnI2SGd3SzczWTY2ZGlVa2ZDNjVkeTlVbkR0?=
 =?utf-8?B?UEt6Vmp0cWJqQm04aHIvdWtvL0pQcjY2eGg3azU2eWc3VHdYdEFHN0VxclFk?=
 =?utf-8?B?dGYrUlNJbTdSdkRHY29JOG1jSkhraTRoNTlGY29RTUI0OGgxek1SQVR4VWQ4?=
 =?utf-8?B?S2c1OE55TkhWZm01d0JBSGNva1FIYWwyMDF0VlFCU050R0pwVVIxMEpialFn?=
 =?utf-8?B?aFI5eU41WFJ3TGx1MDVBY2hDRnp0RFdKSTdNQmdmWkpwaVFJbWhGQ2NHL1hO?=
 =?utf-8?B?TVN5NGU2QzZ5QjZCWGdXUUdtOTlGbUs3cFVESFdxMVoxWWdHMjBaZFJrM0JF?=
 =?utf-8?B?bmNOdndBSUg3bUFqZnVNcW0zdHd6QTNNTVNTUW9QdkVJd1MxeHE4NDRLdEN5?=
 =?utf-8?B?bzl5ZnlOMWJVNUNhc01QY2RBTGMwTTZHVFlrcXl4WkJacVdPWHhRTU1UTS96?=
 =?utf-8?B?TXdvMk5reFVVdndLNHBPdzlSRUNDNG5yMjdQYnRvZXlGM29MRHAxTEN4U3c0?=
 =?utf-8?B?ZDJ2Q0JQYWtNWmFTZTdNRVVqR2V1SytIcE11bmtVYlJYdllRWGtCbWVrZ1Zn?=
 =?utf-8?Q?rdQdDm2NhI+OXQJytyipwOsd5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3f3768-e5ce-4316-8478-08dde6a2bad8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 02:21:15.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3xn+YQON/7FvnPObWgqbRK9x2gl3gg6uGe6RC4RovsdxCY13fFDgg58xARM7ia94UP4wPP83rCoK1DelcIOYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438



On 29/8/25 08:07, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
>>
>>
>> On 27/8/25 13:52, Dan Williams wrote:
>>> A PCIe device function interface assigned to a TVM is a TEE Device
>>> Interface (TDI). A TDI instantiated by pci_tsm_bind() needs additional
>>> steps to be accepted by a TVM and transitioned to the RUN state.
>>>
>>> pci_tsm_guest_req() is a channel for the guest to request TDISP collateral,
>>> like Device Interface Reports, and effect TDISP state changes, like
>>> LOCKED->RUN transititions. Similar to IDE establishment and pci_tsm_bind(),
>>
>> s/transititions/transitions/
> 
> Thanks, not sure why checkpatch spell check sometimes misses words.
> 
>>
>>> these are long running operations involving SPDM message passing via the
>>> DOE mailbox, i.e. another 'struct pci_tsm_link_ops' operation.
>>>
>>> The path for a guest to invoke pci_tsm_guest_request() is either via a kvm
>>> handle_exit() or an ioctl() when an exit reason is serviced by a userspace
>>> VMM.
>>>
>>> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
>>> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>    drivers/pci/tsm.c       | 60 +++++++++++++++++++++++++++++++++++++++++
>>>    include/linux/pci-tsm.h | 55 +++++++++++++++++++++++++++++++++++--
>>>    2 files changed, 113 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
>>> index 302a974f3632..3143558373e3 100644
>>> --- a/drivers/pci/tsm.c
>>> +++ b/drivers/pci/tsm.c
>>> @@ -338,6 +338,66 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
>>>    }
>>>    EXPORT_SYMBOL_GPL(pci_tsm_bind);
>>>    
>>> +/**
>>> + * pci_tsm_guest_req() - helper to marshal guest requests to the TSM driver
>>> + * @pdev: @pdev representing a bound tdi
>>> + * @scope: security model scope for the TVM request
>>> + * @req_in: Input payload forwarded from the guest
>>> + * @in_len: Length of @req_in
>>> + * @out_len: Output length of the returned response payload
>>> + *
>>> + * This is a common entry point for KVM service handlers in userspace responding
>>
>> KVM will have to know about the host's pci_dev which it does not. I'd
>> postpone mentioning KVM here till it learns about pci_dev, if.
> 
> Oh, this was a copy paste mistake that I meant to cleanup after Yilun's
> clarification [1]
> 
> [1]: http://lore.kernel.org/aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050
> 
> So, the plan is *not* for KVM to have PCI device awareness.
> 
>>> + * to TDI information or state change requests. The scope parameter limits
>>> + * requests to TDISP state management, or limited debug.
>>> + *
>>> + * Returns a pointer to the response payload on success, @req_in if there is no
>>> + * response to a successful request, or an ERR_PTR() on failure.
>>> + *
>>> + * Caller is responsible for kvfree() on the result when @ret != @req_in and
>>> + * !IS_ERR_OR_NULL(@ret).
>>
>> Uff... So the caller (which is IOMMUFD vdevice) has to check and
>> decide on whether to kvfree. ioctl() is likely to have 2 buffers
>> anyway and preallocate the response buffer, why make IOMMUFD care
>> about this?
> 
> No, iommufd does not need to preallocate the response buffer, the
> response buffer is allocated by the responder.
> 
> This follows the example fwctl because this guest_req() transport is in
> the same class of kernel bypass tunnels. No need to reinvent a common
> device RPC transport mechanism.

ok, time to read about fwctl.

>>> + *
>>> + * Context: Caller is responsible for calling this within the pci_tsm_bind()
>>> + * state of the TDI.
>>> + */
>>> +void *pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
>>> +			void *req_in, size_t in_len, size_t *out_len)
>>> +{
>>> +	const struct pci_tsm_ops *ops;
>>> +	struct pci_tsm_pf0 *tsm_pf0;
>>> +	struct pci_tdi *tdi;
>>> +	int rc;
>>> +
>>> +	/*
>>> +	 * Forbid requests that are not directly related to TDISP
>>> +	 * operations
>>> +	 */
>>> +	if (scope > PCI_TSM_REQ_STATE_CHANGE)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
>>> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
>>
>> Why double braces?
> 
> Because of the assignment used as truth value. The evaluation of the

Ah -Werror=parentheses.

> ACQUIRE_ERR() result in the assignment was a compactness choice that
> PeterZ made in his original proposal [2] that made sense to me, so I
> carried it forward.

oookay :(

> 
> [2]: http://lore.kernel.org/20250509104028.GL4439@noisy.programming.kicks-ass.net
> 
> [..]
>>> @@ -50,6 +51,9 @@ struct pci_tsm_ops {
>>>    		struct pci_tdi *(*bind)(struct pci_dev *pdev,
>>>    					struct kvm *kvm, u32 tdi_id);
>>>    		void (*unbind)(struct pci_tdi *tdi);
>>> +		void *(*guest_req)(struct pci_dev *pdev,
>>
>> We have pdev in pci_tdi, pci_tsm and pci_tsm_pf0 (via .base), using
>> these in pci_tsm_ops will document better which call is allowed on
>> what entity - DSM or TDI. Or may be ditch those back "pdev"
>> references?
> 
> Not immediately understanding what change you want here. Do you want
> iommufd to track the pci_tdi?

I'd like to either:

- get rid of pdev back refs in pci_tsm/pci_tdi since we pass pci_dev everywhere as if a pdev from pci_tsm/pci_tdi is used in, say, 1-2 places, then it is just cleaner to pass pdev to those places explicitly

oooor

- pass pci_tsm/pci_tdi to pci_tsm_ops hooks and use pdev in those when needed, this way it is clearer from the hook prototype what it operates on.



>>> +				   enum pci_tsm_req_scope scope, void *req_in,
>>> +				   size_t in_len, size_t *out_len);
>>
>>
>> Out of curiosity (probably could go to the commit log) - for what kind
>> of request and on which platform we do not know the response size in
>> advance? On AMD, the request and response sizes are fixed.
> 
> I don't know. Given this is to support any possible combination of TSM
> and ABI I took inspiration from fwctl which is trying to solve a similar
> common transport problem.

If guest_req() returns NULL - what is it - error (no response) or success ("request successfully accepted, no response needed")? The PSP returns fw_err (which I pass in my guest_request hook), does this interface suggest that my TSM dev should allocate a sizeof(fw_err) buffer at least, and if there is more - then sizeof(fw_err)+sizeof(response)? I thought TDX does return an error code too, surprised to see it missing here.


>> And the userspace (which makes such request) will allocate some memory
>> before calling such ioctl(), can "void *req_in" be "void __user
>> *reg_in"? The CCP driver is going to copy the request and response
>> anyway as there are RMP rules about them.
>>
>> And what is wrong with returning "int" as an error vs ERR_PTR(), is
>> there a recommendation for this, or something?
> 
> Keep interface innovation to minimum and follow an existing pattern.
>
> [..]
>>> +/**
>>> + * enum pci_tsm_req_scope - Scope of guest requests to be validated by TSM
>>> + *
>>> + * Guest requests are a transport for a TVM to communicate with a TSM + DSM for
>>> + * a given TDI. A TSM driver is responsible for maintaining the kernel security
>>> + * model and limit commands that may affect the host, or are otherwise outside
>>> + * the typical TDISP operational model.
>>> + */
>>> +enum pci_tsm_req_scope {
>>> +	/**
>>> +	 * @PCI_TSM_REQ_INFO: Read-only, without side effects, request for
>>> +	 * typical TDISP collateral information like Device Interface Reports.
>>> +	 * No device secrets are permitted, and no device state is changed.
>>> +	 */
>>> +	PCI_TSM_REQ_INFO = 0,
>>> +	/**
>>> +	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
>>> +	 * UNLOCKED->LOCKED, LOCKED->RUN. No any other device state,
>>> +	 * configuration, or data change is permitted.
>>> +	 */
>>> +	PCI_TSM_REQ_STATE_CHANGE = 1,
>>> +	/**
>>> +	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
>>> +	 *
>>> +	 * A method to facilitate TVM information retrieval outside of typical
>>> +	 * TDISP operational requirements. No device secrets are permitted.
>>> +	 */
>>> +	PCI_TSM_REQ_DEBUG_READ = 2,
>>> +	/**
>>> +	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
>>> +	 *
>>> +	 * The request may affect the operational state of the device outside of
>>> +	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, and
>>> +	 * will taint the kernel.
>>> +	 */
>>> +	PCI_TSM_REQ_DEBUG_WRITE = 3,
>>
>>
>> What is going to enforce this and how? It is a guest request, ideally
>> encrypted, and the host does not really have to know the nature of the
>> request (if the guest wants something from the host to do in addition
>> to what is it asking the TSM to do - then GHCB is for that). And 3 of
>> 4 AMD TIO requests (STATE_CHANGE is a host request and no plan for
>> DEBUG) do not fit in any category from the above anyway. imho we do
>> not need it at least now.
> 
> While the TSM is in the trust boundary of the TVM, the TSM and the TVM
> are not necessarily trusted by the VMM. It has a responsibility to
> maintain its own security model especially when marshaling opaque blobs
> on behalf of a guest. This scope parameter serves the same purpose as it
> does in fwctl to maintain a security model and explicitly control for
> requests that are out of scope.
> 
> The enforcement is market and regulatory forces to make solutions are
> not bypass security model expectations of the operating system.

I get the idea, it just sounds like it should be a mask - READ|WRITE|TDISP_STATE|DEBUG. Which category would MMIO_VALIDATE fall (set "validated" in RMP)? Thanks,


-- 
Alexey


