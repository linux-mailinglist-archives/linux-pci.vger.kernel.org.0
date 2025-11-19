Return-Path: <linux-pci+bounces-41577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C111C6C931
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 04:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BF85347E1A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F182EBB8F;
	Wed, 19 Nov 2025 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZ5VUZo/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4382D8396;
	Wed, 19 Nov 2025 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522420; cv=fail; b=EltxYV5+M4h24vBkmHFUVEqGVcpQInt9wVJrhpgTvy6rFEOOk6Xn1tc30z5R5clKTzjY0ntPEREgIXTDJXO/6OFyD2/VR7jttQPqSvsdvKX4P57/J8YqGsvfueMH/XnKENc6I6EWCrgwdRPe04JMJ0EasPpfndQwTCL5XDKJ51Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522420; c=relaxed/simple;
	bh=zzcxpJpbEST958dcCEd6A2g0xXIJT3J/UjR+j9SJAUo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WFzkhv145TysnTEPe+QlfMUh7mvS5y7SycrPrb7DS0QaJCpjSeyhQViPttHKKEf1LabWZA5Vyh3nenCr0nMoNEOJTlmQyf9bdH6/tRHiV81beQr2SNIZlj//PlRCMoZIcEDkBxjE/jpU4b2tU5YqeNuf7Fh1lWet2m1fWgEjfAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZ5VUZo/; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522419; x=1795058419;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=zzcxpJpbEST958dcCEd6A2g0xXIJT3J/UjR+j9SJAUo=;
  b=KZ5VUZo/8WvSRYX4uLY/SIXpqE3jbViIPaqOK8Mwd3pjy52WbtHwGOD2
   ybtWUYD5fWHbEuJufv0dP1cwv8k6x9XIH2QOuNxcAedTcjVPTN057XKOw
   RmCmm4CNZ27lhcsqX1td+mGpRtExXPBfPrh5YGv3CVFDgR/h9wTocyLg7
   RzxMf0HzVm/dlmxh0NKyX/JlXj5svd/hqJAzMrQLVOuCyWc4af0zEnDp3
   09qTn5puNI3WA9cbLSJwPqDSQHO4gDBf5/7fuF9salNAZn6wHYJy5fRDH
   lDWi8jhfUgoBbcLJnqA0IsVAkjdJ12203u8KbjzZEmq62Ec6vgoQUOxty
   Q==;
X-CSE-ConnectionGUID: 7k56SyI+RZqSmdMBBK0eQg==
X-CSE-MsgGUID: xb/sPYx9R8ifzWOhr8LSTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="68163031"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="68163031"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:08 -0800
X-CSE-ConnectionGUID: bVGSrxR1SySEJ64sn2BcxA==
X-CSE-MsgGUID: L9j7sFrhQ2uxs6Hs6RDuew==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:06 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:20:06 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAcXaq8GlY0MEk/GoC6LLvQT6XifHIlGjvPaL0NkiwU4IWwsdFK9unScbVwPyw1d4RbOdQIbVAK4SbV6XX3j29eOG1St3VGoYnj6L7Pmhm27t2h/Hv/2Jh9E9TfybS1mBH9t2Tb26KjtI2Q4sDExPc7wvjc1ETdjifO18q+Ttk9c/FNdq/G5DhzS/P8BUGcAv40eEAGQmH70QoWpK0DmJwip4MiXjSgPEllyyhRYJKnyLCG1LZOL0T1H/jqT0DMRWR8al9R369RHCMKJb6bE0MFxoYbo9D8WEE9PKzTArpho61UiECPWU3COoNRhYMtr5IJzjfjbgELNLkmX5gAlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtJommezSvsU+3B5QbHoNt1JqxuE1ZDhwSS8dvxgdn4=;
 b=mIWPWHZZcPAlHcdI4dX5cDWxtJPxjtz/tDnVwnlA6rl9midDc8jdsNUbwOpOmgFfVw7mAw7EdsYkwmUxT7fMZVVQQwedR7t3muf+P/Q7EL+ia7y7YSNDmiPkDHI+VIYzhbL4DTSBN4g3cECc1D+XCfh25qXcj4Tmrxrir8AiUonVhwI2q9ZMbJPSDmSOE20RjWrMI69z8b2nYfLd4iRnnMLNOVTZA0FDJ/yq+3X+vjWyxsXw4EktvJQvOp8ef6zXrE/CxmXlbTmxrxcomOPaZhUGnqZlnv1kkTWbcEbhGJD2W6wcdGyT1xy+MGlfGbjWFjLvxEINm31f7Y/YI1A3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB8937.namprd11.prod.outlook.com (2603:10b6:208:57c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:20:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:20:04 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 18 Nov 2025 19:20:02 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <691d37627bcb4_1a3751004@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-4-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-4-terry.bowman@amd.com>
Subject: Re: [RESEND v13 03/25] cxl/pci: Remove unnecessary CXL Endpoint
 handling helper functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 01608658-da63-413b-8bf0-08de271a884c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nnh0dnB2bTUvTVlvT05iNU42ZVEwT0V4RzlTb2xmS2ZNRU9iY1dHMVZZRTA0?=
 =?utf-8?B?UW91eG1NM0xNYmx5T3dDNU9qNDdkeDdJaFNuUHhtR0dZLytudGJ5Z3Y2MEF6?=
 =?utf-8?B?RFZtOS9vclQybHZYTjNsU1ZRY3BmaFVEYmJvUHM5VldzQ0YxMy8rNmp6U1Uy?=
 =?utf-8?B?R1lTY1hoMG4rVWh5eEs4MlViSjM4M2Z1aE9iMmFydG1ycTJ5ZzdHcDh2cWVu?=
 =?utf-8?B?Ylo5eHQ4d09qN3hTVkJma1J2em1VRVVZbzZZN2NMRkpXdkNFbkd0QjVyc2Ft?=
 =?utf-8?B?WjVxbjFNTlBTWWQzZDNaYkFBa29WdFAxNE5mZHpPLzdDQnVvM1VQL05jVkNn?=
 =?utf-8?B?OXR0bk5YU3RkdlpsUGV4V0pvZ01FdkI1ekRaZmlXNlRpSFlxS2hKZGxWbXd3?=
 =?utf-8?B?LzFSczRQL1dDSEQ3VFNZMlRuZ25PVHArZFI5U0VGZnVXVmE5MU5WRW5aY21a?=
 =?utf-8?B?OVU4OEg3SzJtb2NQM0txVnk3djVsaVJqVzBlQ2F2SXp2MmRKNi9yWU8yT1p2?=
 =?utf-8?B?TVB1aXhxTkMrK0lqVTVYM3lid0dxMkxnNGxoRkVnQVA4bStLUUFNQ2RYS01T?=
 =?utf-8?B?S1pwUTNkK1MxNFY1eUdxRHp5R2VJYzdsMFNoWUpJNEZHd0wvdE11TkVhakxw?=
 =?utf-8?B?NEJWS25SSWNmZndHcTcvUG9OdldGcERSa2w1Q1F2RllyV09Rc0JEOGIzTWFH?=
 =?utf-8?B?N09rZjk2K1ZvVnI0T2ZhZVN0RkR3RUlobk1DeWRWbS9zR1V1c0FjckFkN1BY?=
 =?utf-8?B?NFZOOWdjWnVrVU9zQXFINWRpak5ZSGVZRWZTYlNHVzhqQjN6cUJKanN5M1Zt?=
 =?utf-8?B?NnE2WGo2QlBLYzZKdUU2R0V3ZzhJUVdhbnNab21MYldRWFo2NmxNWUpBMlRq?=
 =?utf-8?B?dytHWTZDS09vdDYvOHBCbnluMC9yZkY1UnZZZDZCc29JTzA3SXk3T2FWNU5t?=
 =?utf-8?B?Q2Fjc0lvQ2FRdkVBN0FIYWZPZm1tR29WVHN4dWduTFJtSk9GUnd5bGM3Qm9v?=
 =?utf-8?B?Tk1vb3ZKQXFkem9qcnJyOUlHWFdNb0VPTU4wdzFLaWlCN3FvQ0VkRExBY09H?=
 =?utf-8?B?dDQwQTgyS0xCV0lrOHhneDZZNEd2Q3BVOFNvc1pMNXlMUjZKSjM1WG52VlBw?=
 =?utf-8?B?eTFMaGkybFpMUy9ZUk5HMDViOGFaTHBPNTV4cDFyS0VncWNDUFdDQi9Td21a?=
 =?utf-8?B?Vml4Q1BJVktFWTJ1bHljNzFmNC9TeFlDS0RMcGZzbUhPdVdaVXRsc0pycTVt?=
 =?utf-8?B?L1pjbVJyeUVwUEY1ejBBUTZST3FJVFpUeVRZSWhSanN1aEVWYkMvRWQwZmI5?=
 =?utf-8?B?TmlsWmVlQksvQnZxRVp4ZkF2SWtyWERxemZsdndlZ3dmNWVoQ1BodnZWOUhW?=
 =?utf-8?B?NHJFaGZvNWw0NWV6QmRzV1kzQjdiWUFqWHVpbHRxTGJtMkV3UGUycExzdUJH?=
 =?utf-8?B?RkFSc096YlI3Y0l4alFJZ0twdndQcld0amh0Z3NEcEw3ckE3TWJ5RDRqVWtB?=
 =?utf-8?B?cG04S0pFNnJLbTJqY3Z6UkMrNFRGd3dDQloxZzJyL2lHeWRIbkg2cWFQQUZE?=
 =?utf-8?B?R2NzQ0pDNDV5aFcwQm1xOXJqeW5zVm9uWHV3WXE3ZjMxOThvNWRNenY1aDhl?=
 =?utf-8?B?eFdLRmM1TURCRm1FQnZwd0VLRkVSZnJvRldDekVqa3FGR1I4VVNKWGxpQ2Rm?=
 =?utf-8?B?MldQb0thQjZYSHpqVWh6Snh3a1lQa3YrTTlFT01QdGtBYlJQVFJYNklpM0Jn?=
 =?utf-8?B?ZTRjd29UeG5paU5zZm1xK3g0emQ4bm9vK3JFRjd2TG01NTF6T1c3TkFTN2cw?=
 =?utf-8?B?WExsTlR4T0daMmVOUy85MVllSlFaZFoyeVJicGgyQmVCeHIyU0dmaCt1dGZD?=
 =?utf-8?B?b0RHN0k3YmhGRlFGZUxOTnFoZTJiYXVXMWF4bWcyM2FrLzBwLzQraFJkalBT?=
 =?utf-8?B?aC9CeTdQc3VzMzV5RGRHM2hqL0pvbURuWG00dkZCQmJTUHZ4cVg3aFpQVGMy?=
 =?utf-8?B?UkNlT2VzUDNGbFZBVjRYUkVqNU56TU9abDBZL0dEaDF3NTYrL2F0OVJ0dlBP?=
 =?utf-8?Q?SsZbN/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ZUMzVXT3AyOVB5OTJCTHkrcnBiUnJ0YlpXSG1oa0xDb1J3aWZ5R2Rha1Nq?=
 =?utf-8?B?bGhmRHJSNStHeEEzZ3B5SnJ3OFEzR2hlZE9ocHdoOHNFWjQ4TUdjdC9zbThD?=
 =?utf-8?B?OFlMbGZqR09YOTliQnZoMmVjdlZwdDZEVW1MMEluRS9acC9hSXRDY0tHM28r?=
 =?utf-8?B?eEJobi8zaEp6SkFkeG5LcUFEMXoxcWNTaFRrQTVzNFl1Z3lPbWtrek9lR2M5?=
 =?utf-8?B?S3R6Y0pZN0YvbUpoRDkrbHVueVgrOERVdmhJQUhlS2NPaExmaUx2SHNXV0I5?=
 =?utf-8?B?MGoxYzVjaURHUDFFVjhkSzVXVEc0ZFpqcStSVDNseWtCUG5hRk0rK2dFY2J4?=
 =?utf-8?B?QjZ5NUpkR3J6TTBqeVpMMGJEc1dFSXBnUTFNSVZET0hYaTlPM3FFandON3lp?=
 =?utf-8?B?N1RQb2gyZXY3STNNdEY3bVFNbnk2MUN5KzNVSE0rTGh3MGNoUDV2YW9QcHN6?=
 =?utf-8?B?WjYxV0tPQUdFblpVZ0hUTDN3aFNIRGllRloyMXBwQjEzUmpaV04vVjVuWEl0?=
 =?utf-8?B?SGxabnRrb0Z3aGNUQVZZNEdVdWllenZRWVRoZ0tSSDRjVTdLbStVdmoxZEox?=
 =?utf-8?B?MnRlMmU3d3RPUjI4c25HM0JqU2VwenV5dGZJMEYzWU83MlNZWVlKU2hHRTZB?=
 =?utf-8?B?T0gvZUU4ckF1R0x6ejZqL0lzbTl5MDFHbkJGVWZtUzN4RXJGc2ozZ295bFJD?=
 =?utf-8?B?L2R4T1FEZjluNGdmUml2SVdQWlNZV3d2Q0ZsMnArRWhZZXNrUVhvVmhqekFj?=
 =?utf-8?B?eFZqZG50SHlvWmduV1p2MkpSN1U4eHBKdW5vMmdwR0Niczk1MUp2UEpOOVBZ?=
 =?utf-8?B?U0VlS3ZMVnhCZStVdFZsKzJEZnEzbzBGZGREMExKRE5WdHNDQlNhUHRXeHBp?=
 =?utf-8?B?V3NyUDE0d3BEMmFQaDVUbUpJVHh3UlEzYkp5dG14TDVoME55b2QvVHBHNkFD?=
 =?utf-8?B?Sm5LMlZhZXNWSkpLbmd2NDZ5c004MDJNNE03TEhMSTFDc0NhM3g0eUwwaVVi?=
 =?utf-8?B?eTRNaWN3Z1M1bUUvSkVRUFFBU1pOalN3VWU1Nm5sN3BhTzRkdVp5RTRKcUU4?=
 =?utf-8?B?VStGZUtJUjduc0J3SFVWN3ZuSloxUE1QYWMwSmVlVTc5dUY0VElEUk83UjZF?=
 =?utf-8?B?dVRWWmFhTTZnT3JNVjN5SDFPcW5sOUZSbXBrUHF2RnUvbTMzdFNHVmtrMXBa?=
 =?utf-8?B?aEk1YndxK2hqRjJFTmp0YWlCME54T0FnVEN5ZjkzMWJRRjVKanN0eFN0bnJ1?=
 =?utf-8?B?RkFwbUhJdW1FR05RdjlKOFhTYjU0a2xVTTB1WVZYTnpIekZaamtSVERSbytn?=
 =?utf-8?B?MXI3bXluYWpzc2lQZjJYZm5heDIybXcyNWpKeGRvUExjbVJRLzZYMXpGdFVO?=
 =?utf-8?B?dlkxcEgvQ2F5SkhrTEFaaTB6bnpFWmI5dkhDRTN3Yk15R1JHMnczYTVydTJC?=
 =?utf-8?B?OTRMcTlxVDBURWdjZU9zWTZpREl5Mys1VGZQcDlSbDRnM3RuTHNXRU54dFov?=
 =?utf-8?B?bDJsZ0JBN0g3eHZGQmJyVlNWSkQxemtWb3FzTllRdGZmZUI5QkdORTVzQkx4?=
 =?utf-8?B?TENvWnV2bE5yN2pwYzBFQ3czTnRFWXBGcHJzTEtBYjJSbldPR1UyenRweWFS?=
 =?utf-8?B?aXAzclgzTEErbHd6a05hSDJ5TVBMRlcrd05KMy9KRjNlYmJkQk5IeFNlUUY5?=
 =?utf-8?B?c2U0QjBiM2pPZlRiWEpTdnltU1hvZmdiUU5GNnRLNHVXR1E1bW1jMXJXZ2Vh?=
 =?utf-8?B?ME9sblpvVDFHcHpVZDB3VHZLa04rclVIcVhHd0swTmdqTDQ2bzNUUFU5aW1C?=
 =?utf-8?B?UjhyaVFLK0ZjTFlVMHNVcFlKRlUrZTNsRlpVeXdIb2d2NDRZSEc4cnNpTWIy?=
 =?utf-8?B?dDlqTUl4TzdudDNrODZTZTlnYU1nNmdMNXlKeVJYN0pjdHdxVDRZM09FMUto?=
 =?utf-8?B?dVd6QkhXNFFmMEd0NTdZRzhRQzBSZnlwdDB0OHNBM00vRHVlUUFnS3NPTHdS?=
 =?utf-8?B?NDhFUkQ2cWIxUVMrWGlsQjU2a3htR3NNUmdzWlBkVXJsK1lmWTl3dmxTVk9a?=
 =?utf-8?B?NlhaMUh4cER1cEJPeGJYUnNuYVR3cWo4RTRYWm9XakhDNWFvd3FrVXF2T2gw?=
 =?utf-8?B?bnhVamlZTFcxekZ1RXE4NXhUNkMraGVjbUJzdFFGT0s1WHZKQXBnUFZrSGxm?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01608658-da63-413b-8bf0-08de271a884c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:20:04.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cdQwVqb7uoXzMjLaPWfsjXEA1PuLICvSnUpX6Nc19xiyv6ZBCw2TYzZUdSSNlS8RZPoUNlBy0Bvaa1cMOWok3VPzAYgcicKDOinO44auIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8937
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
> are unnecessary helper functions used only for Endpoints. Remove these
> functions as they are not common for all CXL devices and do not provide
> value for EP handling.
> 
> Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
> to cxl_handle_cor_ras().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

