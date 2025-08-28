Return-Path: <linux-pci+bounces-35052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC33B3AAE7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 21:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741191B27B0D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C2D23FC66;
	Thu, 28 Aug 2025 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4uQYboH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807572356B9
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409556; cv=fail; b=sSCfKfj3lB220YuUScUUCh328gvTgkRujcyalD6kTnf0yGeNHGWwILosnu2VkKqvcPiKi+CNVonVTn4NLtclNTYuaNq+BXhCRHsIQC7BnYoIZMN4X2iAz5sq8QQ5FD9PG4IqyJMHt4lmgOGUouNnFAqx59ZcMDix0YrSRbeJIRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409556; c=relaxed/simple;
	bh=Yd/zoLc6AKACJB8IpBUDSUc7ZfKEx4GHY5xotXDa/b8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Xw3BTjkBfrVledPKytwH0ZLKzz3T1jx7mfR5T74gk2FwvwCEQU8XbtADRLrtORjyA04xm+iF/ZL7hTifyG8wji8iDqr4xsk0CIlNuMRbvjzkhZwpQYzBnp/q874OS8wJcBKSHNjnyqcx++II12LzteKL7UL0YxJp7Bvp1nH7XxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4uQYboH; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756409555; x=1787945555;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Yd/zoLc6AKACJB8IpBUDSUc7ZfKEx4GHY5xotXDa/b8=;
  b=X4uQYboHTw128qyk07xJ9lOMcp4M72IzhYXY045lSvZFspoQGyr8pPEY
   4hX4hxxV+hNQ3ewr9uky0/b4K1Uah5eJ6JaWPaEjVg769kNgcc33o8cq/
   UoEP5gj5F6iMpVJU4nRf0S5h522z6Dp1QgL4GNBVVv6eziFv67pBQryTp
   rfYOkjXPtTEDyEllWdMqHKP8JgHM6a95S5Fw51X4gRnL2PDcwgaAXzwh/
   YZr52gDRUV3RVZ8hBlIgNRZxrKid7pC87FlC+yH+eWf4ik3Q77DkoCcjB
   ip6t7VG8J/rP/p5p3FA1iSvtKPWoc54n0fp+YG7d5Q3YGc28yG2gaIlNA
   g==;
X-CSE-ConnectionGUID: bO3vc414RI6G+GQ6fzbKKQ==
X-CSE-MsgGUID: YJ9NfSScTaC7cxgltRVVCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69285658"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69285658"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 12:32:34 -0700
X-CSE-ConnectionGUID: h0p17YHASoS7ZgNxjoUTEw==
X-CSE-MsgGUID: odg4qHlFSSqBB5NY2QjOag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169784557"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 12:32:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 12:32:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 12:32:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 12:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Clo5erz2shCZfOEWFY+fnFvEby7uj3Ui3iIEg01pPpgJMZr6MGR8mUGLdz61Z75GN9PT/TVTrHx72NpoFXyuJ7w22UKScU9eL8qMIpZ7KeXtA6aad/uS4B2WYALvvBUJ+mjV1kpBD+IW1RiBfoYZr1fm6QZI45/VrL57dJrBoKtmM42yqK4gW8cmc8ZQxx9dhBQC0aPvnpK58UZEH7yXoVojUKdjUxKhalpuVx64G6Sp0iMkkFVr/WXMMyKBULQuvlftznayyN1HDMLM6+1VujUMGUSqfpd8NRZbT+eMGRtZCbGE2wwgiT14fSU82XgjbDTUnvI6L3UQO+rfrm44sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xXhYI+ALu7nitMJ31J5EXMnq5dt3Y01mcgUoUh27rg=;
 b=FpSUhr96IOwsWYo5TsqbHY2xgeRWMCJur3xK74FUhMaodEXRFp2aUuX60IF/QvQP8G8gQ7kn02ue24uxHc6ksp2tErLrx7RIIOkAZKIJ3BmUXStTHf9Ik8Tm5pOX1r9ey+XGC3KaxoQX3VfN7xfgoAYWHCJNp0Lsq1yVOpMVfgWAntinzZ4+0+iNft7B0RFbe4OE0h8h1hNQG6faBKDIfh581JWZo2pftHxcLvjPvvDaBUrZPk/PXpTghiRdCKou9t0R4twjwsriGNiValkZVf6DEV1IlLUQ3w5zRdWu5X0awDTXdjF7Dwu9ORtJ3UTHl55xzSNwsaVotK9DydLUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7483.namprd11.prod.outlook.com (2603:10b6:8:147::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Thu, 28 Aug
 2025 19:32:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 19:32:26 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 28 Aug 2025 12:32:25 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Message-ID: <68b0aec9911df_75db10020@dwillia2-mobl4.notmuch>
In-Reply-To: <d7ac4a49-da6f-4b84-8982-d181a76d65c1@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <80d568a9-f9a7-49b2-ac46-f3b4879c5066@amd.com>
 <68ae4e29d23b1_75db1006@dwillia2-mobl4.notmuch>
 <d7ac4a49-da6f-4b84-8982-d181a76d65c1@amd.com>
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: f16724b6-53f9-424f-8baf-08dde6699ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2gwbkdoZ3IxRlFCYzY2RkV0Y2hPMTBoR3IyMTE3Q2pwZThmaVhKOFdQYkdH?=
 =?utf-8?B?Vi91a1RPNjR3QW9BVFpYNG16STAweVNoVWkxQkF0cDE2VHV0YTUyTWR6UUJq?=
 =?utf-8?B?bk9TNEsvU1dPNS9GN05aNkdhbi9aNEtRZVA4QVJrVldKangzVUlxQU05dVRj?=
 =?utf-8?B?c2RiME5IYW4yemhzRzVuYy83WmRaZjlZbHMxbm5CMkN6VHg0TVR5em9jTk9K?=
 =?utf-8?B?SUNOSk5WaXFmczkvenA5L2xiWEVoa092OVo2cXk0TGVTK3A1RFViUWdkUjVu?=
 =?utf-8?B?VlE5bVdwOWJoWEwvckVhbXc4OWE3WFF3b1FVbmlJeUFpTnJWVjNQUnJ4UWUr?=
 =?utf-8?B?ZE4yWGdxSVdtU3ptWExJSWxaWEhVL0FZUG1XWVhFQzc1TFFqaFg4K2JVbHNl?=
 =?utf-8?B?TjRrQzdoYWo3N2hZcXBHRVNCNWtiRTEwSTIzamVQWjlRL2dQTXdLSzhhcVlo?=
 =?utf-8?B?VzVMZ0pJRzhxNFVSYmRQMHJjUER2b0xLVFY3VE1QL05OOUc1QVpZOW5EZkVo?=
 =?utf-8?B?YndTZTN4MFJlelFCdWZ1OWl2OXB6WUxzSmRSbDl4amt2bzZGVlljS0NwQnpQ?=
 =?utf-8?B?OHF3OFRlSlJxM1VBbTBCaHViMStJc2hrWGtrK2kyOCs4clJmMUxYOVE3cUYr?=
 =?utf-8?B?TE1WT0R2ZjF5WEo2YUNFaEJ4NWduQ3NodUtoU3JxbkE0Yy9tZlJIaXZ4Qnpt?=
 =?utf-8?B?T2E5aVNGcWZ3SGdXdlhOY3B1SkpuN24wWlBOaVFsWlo5bFM5bERVUW9ZQW1h?=
 =?utf-8?B?RG5nZjRxZGJXaTQ5QWJZcE9YZmVrMHkwNk01b1ViSFlESC8xT1N5RUV4OWZx?=
 =?utf-8?B?R0ltSVFvTW1vWDlNKytuSUdMalhLbHdPTHgvT0xzSzFMZDg5VHIreCswM2tk?=
 =?utf-8?B?QTVEQmF1MXhaZEdZUWk2N2k5MUg0L2wrY3k5bHdnU3FFa1Nxaks5djBpQ1kz?=
 =?utf-8?B?YU9UdDdqVnBwMGdRQWJQZ0toTzRWZlRZKzdLbHlqOUp0R3NTZCs3MTFXTXcz?=
 =?utf-8?B?VkRXUHNMRVJWVGR2MzhwbVN6YkdNVEVIUW01cytEMVlMQmJBRFhYRXEzSDBK?=
 =?utf-8?B?QXYzNG5qbG5XcTFVc3lPbzRKL3hDVm84TC9SSFR0U0F4MHFKL1BaUGJqaGhB?=
 =?utf-8?B?eTh1OWVMY2tvR2ZSc054dmt3TmJoWlZnaFdUR0tGbVBveUk1UWwrcmkrMGxt?=
 =?utf-8?B?OFVaNEErS0o3bzlPWmwwTEM0MmpZTFdZeTRQTnNzbHJONk1SQkVEUTNvRFkv?=
 =?utf-8?B?SUdrVjNENUQ1cERiMzNvODV1cFViNHlvWDJCaGJvSG1kRmQwQ2NIcWdxM215?=
 =?utf-8?B?Z1k5K3luWTB5Ti9FTTRmb05iVmU3MEd5NVlVSXhaVkVsRHFPejFXcHVYMWFR?=
 =?utf-8?B?eUp3Tk9xU1h4WWtCS3FDSDIxRFFGUEdhMVJXaGU0ZU5hT1UxYnI1RHp0TEFz?=
 =?utf-8?B?eGZTbzVhbmdxL3pwaWY0SEpGR2IranU4WnZ6dll5cjQ1ejhNQlorcTY0QVBX?=
 =?utf-8?B?VG5saDBrY29VQ3NqMERLV0dlMWg0Zno0Qzg2V0pPcm00TFZyb0FweEpNSmtz?=
 =?utf-8?B?aTA4SU1xZmFUdjduMlFhVGF0dk10SENNZ3FLTW5xd1lsTnJuY2ZuOUFKa1Va?=
 =?utf-8?B?UXo4YmRvbzZLWHUrd01xbC9PTGFMMXYxSklTOG01aFhXZng3OXJmcG0wYmJE?=
 =?utf-8?B?eUR4b212SGhvWVMzaXJIRVlRMDRNckNOZTAxc29iN0o5ZHBWd0VHb0drUEZY?=
 =?utf-8?B?RWRvMlZYbk1PSTRFSVpadHk5QUQycStqb2hITzVJS1FvQjI3WktxL1dPeHNR?=
 =?utf-8?B?NEY1NUhyalNoNzV0VmhtdW5BM05rZlpUUFYwSXptMzNzejVhNU9ndVJzVE96?=
 =?utf-8?B?OThJb1c4T0ZtRGtuQVlUWFYxZ1pORkw5SElWamk5WU5TbmdhTXUxV0llK0d6?=
 =?utf-8?Q?165VSxkmfXs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTkra0JORUxnN2d2MEJVaVJMbVF3Y2xEVHoxU2JOTVUwc1pnRFdUV2hzdytr?=
 =?utf-8?B?Q2JLQWp1ZFY5VUladHlkemxiVUNtYno3UmJvdWdNYXhBQWNqY0FPeDkrWEl4?=
 =?utf-8?B?enplV01nWkNTNGpDTEh0MDlwVnRMZEJQdGFrbjVua3IxUGtKeGpjLysvV1FR?=
 =?utf-8?B?bkV1c3FOS3VMRHkwcCsxQjJ5Q0Z6ZTNaRTVPTStlQ3VYMExiWnA0dGlHSUFa?=
 =?utf-8?B?cFlYSkM1a00yQ2xqbG5xNEo2c05oMVU0Tk5BS1NCUS9ER0pZSnU0M1FCRm5I?=
 =?utf-8?B?UVJPL0xvaWwyRnpBbDR0NVRKTmF4eWYyYkZmbE44MmxaaDJ1a1lhQkU0QXpL?=
 =?utf-8?B?K1pmZitrUVhRbjNPM1BuWmVTUnMvZmMrUnFYWjRpenJCcE83c0FTT3BEZ0Jn?=
 =?utf-8?B?SS96OFlHdWlRQmVhb0ZOajc3MEFxNk83NkhqbUpjUzB4K2wxM2JaZDJnK1FL?=
 =?utf-8?B?cGF5UFZsNExYRmhCemVwTmY5QlRlNEZUdUFGNjFibjV3ZW1XR1U5WG54N24x?=
 =?utf-8?B?L0ZpdmpTVHNlTEFZRXpXTk1Wd21rMEtCeVB1OXVUMjFrdUNTSG1nOWk5bWpp?=
 =?utf-8?B?S3Nnclh1NmRZcUZXNkg1b2FWdjZEcmZ2YjJMYnU2eGtXK0ZtWlhqREQ0SGZ2?=
 =?utf-8?B?ZHRHRGVPcjNoN0hnd05tclhGTVdTa1NiMDNUaGNIeGZuVW03R09nQ2xYMHVM?=
 =?utf-8?B?NzZzYkg2SFQyamlVd3pmTVIra21scHdyV3FpQzhGbU1keW5IVFpzQjFtbmNU?=
 =?utf-8?B?bmE2bzYrODBOVXBNQ29MKzY3TjRob1hSb2dvT1drZXNIUnhzNnliWFJOdXhG?=
 =?utf-8?B?eDNzaTBRUWw3Zlp1anhmNi9jbGZ6TmZsV1c5QWN4bjhnanhQeUl1b3NUVmF0?=
 =?utf-8?B?WEJiSnFBQ1JmMzBOTWRCUnpzMXRoZDJGaG1iU3Z3THN6bmhqOEtqV0FLV2xS?=
 =?utf-8?B?R3dlb3l3NS9pb2Q4Z2djN1ZTUEhZcEdrRXBkS1ppT1NoREc4SnpLVlVJUnlv?=
 =?utf-8?B?OExzUW4xQ3hjYUhxMHk2SW9rOVYyQnBHbDhuRENwOHo4NDR5M25NNVgxalFL?=
 =?utf-8?B?UVY3L0wyR3JFekhxZU5jeGdWRDBtazZyZGsxaGtGMnJlMzM3Wko3TklMSlZR?=
 =?utf-8?B?dm5DcFFCblcrcWpmRGl2TGdYZjJWdmpZYlBDQXlXVmFJRm5SRjBEbGFubEVl?=
 =?utf-8?B?Vkt2aStUbDdnSFBiSk5TT2x4RUpBQmZKVHVGNnVPMEd2S0tsZWwzbnYvcm1N?=
 =?utf-8?B?UStHQ1FxaDBJZDY5TFYvK1VzMlM4UjZHZUNxU3VHeWNWSFJWdGlOYUp2V0Jn?=
 =?utf-8?B?QVBQZUdoL1puTjhiSm0rbnpWVmdYK1M0dUZuMnFralI5QzNRWk16MTdVcVEr?=
 =?utf-8?B?QStISHBNczFlcXhPRi9mN3NDQmhUNHpxeUxiemk3ZkdtakNhNy9lT3kxQWYv?=
 =?utf-8?B?MVlXZDB3RkRRZitvdWMvRjM0WGZ4cmlaaFZqREs2U3JpbzJuc081SWpxZGFD?=
 =?utf-8?B?WjBpOUZZUHo0SkE0b0toeDJpQWJFOGpRNldWQmIzNVd3bUhaSXpqdmVpSnlI?=
 =?utf-8?B?SFBFdzFZbHZyVGdUOUtFeFd5U1l4c2xkMk04TTl5OWZ2dGhDZmowdEEvNVlY?=
 =?utf-8?B?czZZT1JKSFhvYWVnNVpibDhveVpkRGZScWE4ZkcxZG93QndPK2RubVVaVzRP?=
 =?utf-8?B?N0hSc3k0M1FqYzlSR2o2STlmYm5VNjc4b3FOL3FvVDk5ekZEUjM2RUFDMUtP?=
 =?utf-8?B?d2ZyNlFJdEFRUWRxbEg4ajhHNm55bS9BdUZob2xHcitLK00vUFhCejNoVEto?=
 =?utf-8?B?S2NuM3R3M0IrLzk1R09aZXJ1Y054UU56RHlnZFFKZWpxYUVtWEQ2bmdKaU1n?=
 =?utf-8?B?TzRkYnZaQVd1VC9GVmlsKzJaMDB6Q05kWkJpcnNEUFhYcXNROHBPbTJOUUM4?=
 =?utf-8?B?ZjJOTktjTkhjV1REa1lFR1h6bEg2ZnhWVlJyMml1MExOTVhIQ1BERDgweWhH?=
 =?utf-8?B?R1RGaU5kaElOMkxJMlZVcWJHWFRMQUZxbC9BVnpmVlU1YlB2QSswTXZlOWpS?=
 =?utf-8?B?MXhKOVRPZ2d1SENQc29XTDdycDF2YzdBM3dhaDNtSkZkNjFKS1BqM0IwKzZC?=
 =?utf-8?B?VG9GSHBMMFA1dTFTcHk0ZDREN0NoR1VlTmltaXcyVWQrMERUS21sZE82ZTNs?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f16724b6-53f9-424f-8baf-08dde6699ee2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 19:32:26.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtDyCcUrB++1Rn4pQDCt6gq37BXEf0yf7dAcKyZyYTwJDfLQ7RfrzscK99jzSf/YZC7gBbXHwoSTK7x/MLq87ll9imLVhrnsJikjZem45a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7483
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >> but this is kinda wrong as it is quite bizarre to call
> >> drivers/virt/coco/tsm-core.c's tsm_ide_stream_unregister() from
> >> drivers/pci/ide.c's pci_ide_stream_release(), i.e. "virt" from "pci
> >> core". imho the caller of pci_ide_stream_release() should just call
> >> tsm_ide_stream_unregister() too, and so on. Thanks,
> > 
> > So I agree it is odd, and I orginally did not have this tie until the
> > DEFINE_FREE(pci_ide_stream_release, ...) proposal. With that I want to
> > allow for TSM drivers to teardown everything associated with IDE setup
> > with one scope-based-cleanup helper.
> > 
> > It is not a mid-layer because nothing requires a TSM driver to call
> > tsm_ide_stream_register(), but if they do register it then the PCI core
> > helper will handle cleaning it up on error along with the rest of the
> > resources.
> 
> I see but imho DEFINE_FREE() is weak justification for such
> cross-subsystem jumping,

Interesting, I do not see 'struct pci_ide' understanding that one of the
primary methods of establishing IDE (coordination through a TSM) as
cross-subsystem jumping. It is unlikely that Linux will ever understand
IDE establishment in any other form especially because, as far as I
understand, all but Intel platforms enforce IDE establishment through
TSM ABI calls.

> still. I was looking at the linker error as, like, "find a Wally".

not sure what that means...
 
>May be then drop EXPORT_SYMBOL_GPL() for tsm_ide_stream_unregister()?

True, that can be dropped now.

