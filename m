Return-Path: <linux-pci+bounces-32861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7501AB0FE9F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 04:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0909B58815D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 02:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680335979;
	Thu, 24 Jul 2025 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfB2fbd6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5BA6FC3;
	Thu, 24 Jul 2025 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322539; cv=fail; b=qqfBzKuTrtEfCGMpHxC4i//xP0qb6iGjEu0QnfyVhxVf/vO1TiDECbXXxu7pcaPMeQ0qYsgKDHwPdctiCYzMmGeEcR18sZc8L1f2fF+C2eyYH7PDEt3JwiVF1J//ogA0uEjnfX+5L/N2sODbTflsYz7ye9V5fjpotUhwS+TsLqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322539; c=relaxed/simple;
	bh=J6Z4WpbAjErKxR1f+1iU9SKIQKV42KmyQ0nCMnslLOQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CL4+oV8nIn+nnNyhK0QarfVR/29BVtmOeZuf9LzeiGYFdfzfWVx/758482rWS6UIPW9XaMmQ1Q+PqdYteZG8pq/4naMTKQ44HBR5kCOiSr/JErNTBQ3RKqZ0Lgf8rfHHo+UY9W/KHY0YlrpoUvAPzZLIpfR9e18PUOZZftD2WHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfB2fbd6; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753322537; x=1784858537;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=J6Z4WpbAjErKxR1f+1iU9SKIQKV42KmyQ0nCMnslLOQ=;
  b=TfB2fbd6fp/GV05Gsq6IE7gBRXyJqwLL8/vB/koVaC6hXq+2jtThnKpj
   ViOkVhDYJnlrw+E3z2Sf0yLpTejPVm5YA8KTTHxzIdeAKoiJIUckaXB1h
   Am9g96hDQb7KaglFRNED6riZ6dYoLNFthWHQw7uu7vk+pWzWE2VI427TJ
   AXwIFKBz7eweYK3aK3GVWerwuaNUK6nGJp671US6xIaOyCUQAr59ZswrB
   KEnSjGNH94lMHx6zxZ2hy9TwFuMO0sFmz2YcVUCoQglxTtyPas9uPZp1D
   VZvbFFE4LKUmjlmMIWOV8tnCZg2tqpVbZ0Uq30YTWiYsgGH9LFG1cdaT+
   w==;
X-CSE-ConnectionGUID: lkL5NZKjSwyvcZvzu9yoVg==
X-CSE-MsgGUID: ntqOz7snQQuzIS1yW/Ot9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66693628"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="66693628"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 19:02:16 -0700
X-CSE-ConnectionGUID: 0Qx7V2JLRL+EWBSbyCmhgg==
X-CSE-MsgGUID: bQ9C9P8kTNmtraRt/6CvjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="164129488"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 19:02:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 19:02:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 19:02:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.79) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 19:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNPUtkLhgBlQ7xVebr6NRaBQawP1Qzv/kCF6Cq5Cbp5MMC6AiK6NNaxzeoLQa+f1ycm17F+VbIcIbpn9CBbqmlzAH2CBWl5bbip/Q+xrwj1jb/LvKu8/Vm9VvIBm86xbaAAY8X9/RWo/i5zC1dgo6HRfJJC9KX0TLWWgIK5XJeefQASix1/6pBKXMApBZncXD2LJuRBbXQCjL7+OtKrOUQbKOnfn2eJxE7g/mAiGYYtFJ6VBe9umEzxqLp+ViTbyT47uS7bG+M0noHTW8JyC34G4/nLWl9P59lDE3ZAEcYAiLYQxb7ycUit1PjFlFFiR+l/VpGbD6576DUUP5uO8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+pGXsQUlCRayfloecpsGp+GJfC//irVgY9Y37GLt38=;
 b=rO4qsEpQeyUkDCfbQ6F0uT2Pimdb8I3Zdrj7V8iKNKQSC4Y58zDAnRfJej2p4jJxQhx0Skx3WXOON7sa1tKE0tLzX4euH3ZVXGmw2ThRkWLkmGnDWBlBStMU205Xz9PDMy2i9rFUP5JpqMLAa83bim2KnMbHe59qEuOF0cjCq5f2WJjQZRf++CMKnlD+tT92B0a/X/P7rikvyxpjb76+vduZ2xr9/m+eklmDpEUq1RvcA7fkEs01mG0m3e2bJsgieI/Zbb14fQLENbsutWPJZfoRvVFuzNJOUBvUoEB3cHEoF/yAPeGFMO8+XFjHjQ9ysvKB0UFutPLdHSIpeUTJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB9501.namprd11.prod.outlook.com (2603:10b6:8:28e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 02:01:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 02:01:26 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 19:01:24 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <terry.bowman@amd.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <688193f446411_134cc71007b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250626224252.1415009-6-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-6-terry.bowman@amd.com>
Subject: Re: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL
 errors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB9501:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1674e1-c3db-4872-5266-08ddca55ff83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2J1TEJMMjA4N0tnNGxrNm5UQks3L0V3cCswaEhMSURIbmFsVkp2cCtwUFE4?=
 =?utf-8?B?WlF0dG1lUjZLZ000cWpCZGxDSHlPUHFyeThtRUdRZFhJOXpTRmxBVXUrZ2pQ?=
 =?utf-8?B?dVdGS1NzMWk3WTkrZWUxNFN6MW1VVmFHR2dHeWVtU1ExV2dwODR3U0hIVDNC?=
 =?utf-8?B?MnVTRmhsODVoUGYvZEtJMTB0cW1Ldm5KL0FJVXp2SEZwNmU4bS9VUm8zaGdp?=
 =?utf-8?B?OUNieDRuSmkySGZtSWlpV1M5ZEVVbUJNU0sweTc2VElTWnkwMTNaN0V1cXNI?=
 =?utf-8?B?MVhjU2RSeG1MYVcrR2E4TGdIV3hCamZ2K1IzNTZZTmg0VzdoaTd4NDJ2bXRy?=
 =?utf-8?B?WUUwS011ZlFmZnVya1JtVmhmYTVRWlJxM0txNUg4TGZHRUFqNGRWTndTR3JP?=
 =?utf-8?B?Z2NKRlJJb1ByVC9oL0lIRi9XaVd4bk1SallXTGVYOTlGeENmZ1U1aitnK0xM?=
 =?utf-8?B?UHI4YWVrVkFmTXBtWk5adVFhdXZTUXEvMHE3Vng5SGZvREhVNUxYVWpvWE53?=
 =?utf-8?B?TSt5Z2Q0UXBBWSthWVFaekc3K0U1UjFudG5zWkxBZUZKU2dmTzNJUy9BWkF2?=
 =?utf-8?B?VStmRS9OWmEyVnJBM3NYMG56bVBudTkzTGlaTEtuSVh0NTMzdTE4K1U5RmlP?=
 =?utf-8?B?UEdQQVRKb1BOQmNVZVgxUzVDc3NLaGQ5bnlNWkFYMk5CMjNrNUhkUGwxMDJH?=
 =?utf-8?B?WHh6UnRCUXRRa3NGeXFsS3ByNDU5ZFp4RmpJYVA5U1Y2UHU2dmNYVGlGRHcx?=
 =?utf-8?B?SDdVNEhQaVF2ZjBqSjdWa3dqeEtRNGpCZ0lhU0RRUWEvV1RGV3NJNDNWL2Jq?=
 =?utf-8?B?Ly9nY2RQL092Z09GMFdDODZkUksyYVBlWHV3Sk5EKzJZcUtlOTV0QzNBczYw?=
 =?utf-8?B?YTdqU0NHSGkzY2syQ3ptRTFQSFdBU0pJaXhvMFFySndLV0pCd3ZmSUk3bWtX?=
 =?utf-8?B?NzJCNUhla1hsWEs5NXNCNXhsNlJkZ1BYemZqM3E0OVRmZVRXazZ5bVl2RzN6?=
 =?utf-8?B?VmhnVXdlZm42ZUZLTjFDRmpqS0NCWEg0ZmgwS1BYc0d3N3JwOUZrWE5aWGFR?=
 =?utf-8?B?K1FENmVoRHhkU0tvZHpmTnBrblYxZ054T0ZzZllpTklUeWRFdjNBVnRJclZ3?=
 =?utf-8?B?THZiNW51aElKb09waE1zVjNRTmtqdmc2eUhlNzBIeUlDMVNnK2xQSEVzWFdh?=
 =?utf-8?B?YStQTjY5Z2ExWFdIS0V1OHNxWXB2emI4L2RLaEt5Yk5xT3B1OFBqdmJrUTIy?=
 =?utf-8?B?a0R2RFFTSW1sK0VTbXZ6VTJoQUIyWWFRUytiVVBTR0JUSUlKTHZraE9EblpU?=
 =?utf-8?B?WjdPZkRiTXM2WXNGdTBSMUo0dE42dTE3eTF6WjkrTWxUMDVqTU5zekI0cnZa?=
 =?utf-8?B?VzFoWUtZMVpremJFdHpsdTgxdlFKaDJ4K1pQajFzSFNuMEs1TU5ibFdjdTRZ?=
 =?utf-8?B?ZGVKdkxwRWdHMlFnQ3QrQzNBYkw3d1JVK01aanhydnZpWm5CT2UrNUpYRmJN?=
 =?utf-8?B?b3pwOGM0cVg4WVYvSFkyL1ZFdi9pSXExamJkRS8yaDRLUUpxelhObFlEYytN?=
 =?utf-8?B?YVN6djZFUmxuVnptaTFqM3A4UHh2V1BUbEMyZlg1RUx2TytGV0tKMVVENUlh?=
 =?utf-8?B?LzkyUTgzd25vV3M5bUJMck5QZ0FGRURhS1R2WTFpS3dNdHNQT1BYN1RSQWVD?=
 =?utf-8?B?cjFYbkFHNE1CRWc0SU9wcUpIK01YQ2ZjUzQ5NGwvSkhIcjFaKy80TnI0NzhZ?=
 =?utf-8?B?U3JXWW9Ebyt2QXRTSlp4bG5nYkpYZEUwK2l6aUIwNGQxb1BjMVE0dzJjT3pn?=
 =?utf-8?B?cnQ5NmRsYjd3WGpWVHErTUJQcm9Rb1pCVU1PV0tGazRKQWRvUVE2V3RaVDdT?=
 =?utf-8?B?OWx5bWlTMHBzNmFyck5NOXBkQ0hrQ29wN3NHaGdmcjdLVFZTZHpsUVFQQ293?=
 =?utf-8?B?VTI2Q0NFQmJ5V1hjeUxLS1NNN0FSajVvbHpOZUkyYzcxWm5xYllkbnVlcFZX?=
 =?utf-8?B?cmkwRDFHMHpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2tueFFkdk0xT201alZrN3diUVpLOXpnMGsrUllUVmRHTUJWZEpuTkd1Z0ow?=
 =?utf-8?B?a1dCYk8wMlJxREZZYnRoaUhKSndabXAvT1ZFNTk5VjljKzF2N2lOcGMrVGo2?=
 =?utf-8?B?c2NuWThtZ0FJSW9aRzJrMStXRDUxMDVtY2RXbVJYeko2ZmtFR1lkOWFjTHlB?=
 =?utf-8?B?OGs1L2xWK0Z2MHJEVW1PMGdEc0JlMS9pZHVLZDhySkNQZnQvTFpYVlVCMXJw?=
 =?utf-8?B?ZGd5MWF3b2lDcFNORitHZDVsVFo1VWNjVkpaVXdIQU1Xc0QvVHd5TmlScFBP?=
 =?utf-8?B?Y0F6Q2NMaEFybTB1cE9iYzJEVXFSTXlrbHg5S1dzayt0WFljc0hXRTNtTHFP?=
 =?utf-8?B?RldEL2tvQVNoQzNOVVRoQ0NoM0V5RDkrMEUvZm45MWVaTXg2Y2kvSjc5RU1M?=
 =?utf-8?B?bjhmRXo3UmNRMU1kMHVPQ0QveStmYjkrNGxQYkE2UHNINGE0RVVUaHV5eDFu?=
 =?utf-8?B?S2JQcmZtUER6VjVaaVNSWnhUaU5qTjJHVW5NVVBIUFE2UnVZa2VZNGJmdGh3?=
 =?utf-8?B?TmZHUytCdUQ5TjNGRVhHTVpXa0svRHh4TVpKSlhYYlVBa1J2ZWJTT3BlMitk?=
 =?utf-8?B?MmRiMWw4TVNsRDBnVHYwRWRiN3pqejFZVGdGcUdCOTJqSGk2Z0t1bHFTdkcw?=
 =?utf-8?B?NEtWUmxXREZwbXIvUlR5VHgrUythbm9NRE10UXByclNhYjV3T3I2YTF5MDhs?=
 =?utf-8?B?ajlITHpSOFBMcEQ0bVdsaVgwU3NkNG1nRms4YVJPTGVEenluK241cDhGR2hh?=
 =?utf-8?B?SFExZG53SndBaENqYytLdTdVTFcyNVJvdUllM1R2VVVjNnluYjZlQ1BJTXFB?=
 =?utf-8?B?VmdITjFva1JpaG9HY2NiT1JTU1lKYk1lS3pQYldIcGFzSUp6a2V0VGsrd3Rk?=
 =?utf-8?B?WllKbE9oSTZmaTlzT3hxRkNoL05VZi9JdmcyZlFnZ09MNUJmM2RKNy9sZnF0?=
 =?utf-8?B?MVBvRHFkQUtDckhIMjdRUGp4RW43ekJZTm1rOWlDZmxpYVJGeUNoSzZJSzU1?=
 =?utf-8?B?SzlJQzV1aEpxNFdleFNOblNabTNNdHVSZ3E3ZjN2SVV6dS9XVGwxdWp4eFlM?=
 =?utf-8?B?a2wxekdqSEVUbjZxUXVaMElIZXJLYytYWFNUQ2xyU1NSbi9XUDNwR3J1ZitN?=
 =?utf-8?B?T0luMUZGT2dCVFYzY0ZQbktZZmp5VXJSUTdPbVVRZVBvUXBZeU5GcXl6R3o0?=
 =?utf-8?B?a0xtOVJROWEwY3pKVldycXNxem1DK0ZLN1Zlc2pMendFRDNYV2c5enFyQjRF?=
 =?utf-8?B?MGxRUmgvYmdTZytJT3llanFJTmZRWWVHODRlWlFwUm1ZcjczU05nOWpDSm84?=
 =?utf-8?B?Z1NoUnd1bHA2Y0R4QmxJdWJqL1ZlOGUvSVhzVm03MHZXalVzZjdDMUZoampS?=
 =?utf-8?B?d3ppZVZrSk9NUDdyc0J5bElDYkxpcDdEbmdEaUtuTnhyRkJDM2tTbU0rYUMy?=
 =?utf-8?B?cUNTUEZFQkhuRENWejV0bm5qVTNqUmI0VnlzT0tYcElIaVhEY01iRDgvRzhy?=
 =?utf-8?B?RTIxaFg5VUlCVHh4ZGZ1eUNsdDMrU1N0QjZCTVZBblpHcCtHZ1hROHNIdVEx?=
 =?utf-8?B?WXlSZ1ArcmJIVCtxc2R2bFhSTmtDZEwrZ1J3UTdMb2VHanpxTEl6V3c3UHl5?=
 =?utf-8?B?Q0h5cWJha09CZmV1TTdrWHY1OXhBanJFQm5xVnRZT09GSzc3cUpqdmVxSkRZ?=
 =?utf-8?B?QkhheUk3WHJvRUNNK0JEc1UrUmNUeERDMUJpZGhhVHFCa3NXMlJKdnZjcjMy?=
 =?utf-8?B?WUs1eS9UdHRxZXFHMHdvblZ4cVdxZTZMYWFPcVdOMkg3VVMzb0xkWW1qc2pp?=
 =?utf-8?B?MGFVRVRJNWhzMmdOUlNFVVpWK1JhSElKQ3RTT1NKcEphaHpscmlRQXpRbFJm?=
 =?utf-8?B?SUMwTllOdzdXRnVHWHF3cnVyM0xjSDVWVG4vRSs1ZG92bnNzNFQ4VHNZQU1P?=
 =?utf-8?B?eHEvSFE0T2hML2dvUU5xYTQ5dUFYcFpIWUdESWpGSVprMHM1RXZyNkV0cmd3?=
 =?utf-8?B?em8zMnhpSGNySzBWRWw2eTZ3VzZlL0ljMWl2bVRxY3oyNFdjYWpQZjZteEtV?=
 =?utf-8?B?bW9KL0NXNEVNWVduNE5kYVdBeEVYdldOelIvUXUraHZaaVBOdlRUQmE2Rkg3?=
 =?utf-8?B?MkRxUlZlNW5vMjFnaEdtdzh6ZXFlYUVvQUEwUnh6TVRGTmtEQVBMV3J3OFFk?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1674e1-c3db-4872-5266-08ddca55ff83
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:01:26.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpR149SzlnxsLoZpjQqr/hSeSGn4pQWk7a3W0aLIwN820yNASElrkgyhyZYjdmuTCaz5PrDYjhOpQir9Qhc602eJhiYSPv9SW/Q9SElaqkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9501
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL error handling will soon be moved from the AER driver into the CXL
> driver. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used
> as an indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> First, introduce cxl/core/native_ras.c to contain changes for the CXL
> driver's RAS native handling. This as an alternative to dropping the
> changes into existing cxl/core/ras.c file with purpose to avoid #ifdefs.
> Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
> conditionally compile the new file.

I see no daylight between CXL_NATIVE_RAS and PCIEAER_CXL, one of those
needs to subsume the other. I also do not understand the point of
"NATIVE" in the name. Will not CPER notified protocol errors be routed
to the same CXL error handling infrastructure as AER notified protocol
errors? I.e. the aer_recover_queue() path?

> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> 
> Introduce 'struct cxl_proto_err_info' to serve as the kfifo work data. This
> will contain the erring device's PCI SBDF details used to rediscover the
> device after the CXL driver dequeues the kfifo work. The device rediscovery
> will be introduced along with the CXL handling in future patches.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/Kconfig           | 14 ++++++++
>  drivers/cxl/core/Makefile     |  1 +
>  drivers/cxl/core/core.h       |  8 +++++
>  drivers/cxl/core/native_ras.c | 26 +++++++++++++++
>  drivers/cxl/core/port.c       |  2 ++
>  drivers/cxl/core/ras.c        |  1 +
>  drivers/cxl/cxlpci.h          |  1 +
>  drivers/pci/pci.h             |  4 +++
>  drivers/pci/pcie/aer.c        |  7 ++--
>  drivers/pci/pcie/cxl_aer.c    | 60 +++++++++++++++++++++++++++++++++++
>  include/linux/aer.h           | 31 ++++++++++++++++++
>  11 files changed, 153 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cxl/core/native_ras.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..57274de54a45 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,18 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
>  
> +config CXL_NATIVE_RAS
> +	bool "CXL: Enable CXL RAS native handling"
> +	depends on PCIEAER_CXL

This nice helpful option is hidden if someone forgets to set the
PCIEAER_CXL option which does not have helpful text. Given the
dependencies, I am leaning towards drop this new option, move the
help text to PCIEAER_CXL... but let me read the rest of the patch first.

You can move PCIEAER_CXL to drivers/cxl/Kconfig if you want to keep all
the CXL options in the CXL menu.

> +	default CXL_BUS
> +	help
> +	  Enable native CXL RAS protocol error handling and logging in the CXL
> +	  drivers. This functionality relies on the AER service driver being
> +	  enabled,

No need to put dependencies in the help text the tool will tell them
that PCIEAER=y is a dependency.

>         as the AER interrupt is used to inform the operating system
> +	  of CXL RAS protocol errors. The platform must be configured to
> +	  utilize AER reporting for interrupts.

Per above, does any of CXL CPER reporting make its way into this path?

> +
> +	  If unsure, or if this kernel is meant for production environments,
> +	  say Y.

I think: "If unsure, say Y" is sufficient.

> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79e2ef81fde8..16f5832e5cc4 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> +cxl_core-$(CONFIG_CXL_NATIVE_RAS) += native_ras.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..4c08bb92e2f9 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -123,6 +123,14 @@ int cxl_gpf_port_setup(struct cxl_dport *dport);
>  int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>  					    int nid, resource_size_t *size);
>  
> +#ifdef CONFIG_PCIEAER_CXL
> +void cxl_native_ras_init(void);
> +void cxl_native_ras_exit(void);
> +#else
> +static inline void cxl_native_ras_init(void) { };
> +static inline void cxl_native_ras_exit(void) { };
> +#endif
> +
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
>  cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
> diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
> new file mode 100644
> index 000000000000..011815ddaae3
> --- /dev/null
> +++ b/drivers/cxl/core/native_ras.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <cxl/event.h>
> +#include <cxlmem.h>
> +#include <core/core.h>
> +
> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +}
> +
> +static struct work_struct cxl_proto_err_work;
> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
> +
> +void cxl_native_ras_init(void)
> +{
> +	cxl_register_proto_err_work(&cxl_proto_err_work);
> +}
> +
> +void cxl_native_ras_exit(void)
> +{
> +	cxl_unregister_proto_err_work();
> +	cancel_work_sync(&cxl_proto_err_work);
> +}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..8e8f21197c86 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2345,6 +2345,8 @@ static __init int cxl_core_init(void)
>  	if (rc)
>  		goto err_ras;
>  
> +	cxl_native_ras_init();
> +
>  	return 0;
>  
>  err_ras:
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..962dc94fed8c 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -5,6 +5,7 @@
>  #include <linux/aer.h>
>  #include <cxl/event.h>
>  #include <cxlmem.h>
> +#include <cxlpci.h>
>  #include "trace.h"
>  
>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..6f1396ef7b77 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -4,6 +4,7 @@
>  #define __CXL_PCI_H__
>  #include <linux/pci.h>
>  #include "cxl.h"
> +#include "linux/aer.h"
>  
>  #define CXL_MEMORY_PROGIF	0x10
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 91b583cf18eb..29c11c7136d3 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1032,9 +1032,13 @@ static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>  #ifdef CONFIG_PCIEAER_CXL
>  void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
>  void cxl_rch_enable_rcec(struct pci_dev *rcec);
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
> +void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info);
>  #else
>  static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
>  static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
> +static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
> +static inline void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info) { }
>  #endif
>  
>  #ifdef CONFIG_ACPI
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 0b4d721980ef..8417a49c71f2 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1130,8 +1130,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_rch_handle_error(dev, info);

No, can not just drop what was working before, even if you restore the
functionality in a later patch in the same series.

I would expect that this patch at a minimum maintains RCH handling and
forwards anything else to the CXL core for VH handling.

> -	pci_aer_handle_error(dev, info);
> +	if (is_cxl_error(dev, info))
> +		forward_cxl_error(dev, info);
> +	else
> +		pci_aer_handle_error(dev, info);
> +
>  	pci_dev_put(dev);
>  }
>  
> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
> index b2ea14f70055..846ab55d747c 100644
> --- a/drivers/pci/pcie/cxl_aer.c
> +++ b/drivers/pci/pcie/cxl_aer.c

With the RCH bits moved to its own file then this file would be 100%
concerned with typical CXL VH error handling and deserve to carry the
"cxl_aer.c" name.

> @@ -3,8 +3,11 @@
>  
>  #include <linux/pci.h>
>  #include <linux/aer.h>
> +#include <linux/kfifo.h>
>  #include "../pci.h"
>  
> +#define CXL_ERROR_SOURCES_MAX          128
> +
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
>   * @dev: pointer to the pci_dev data structure
> @@ -64,6 +67,19 @@ static bool is_internal_error(struct aer_err_info *info)
>  	return info->status & PCI_ERR_UNC_INTN;
>  }
>  
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	if (!info || !info->is_cxl)
> +		return false;
> +
> +	/* Only CXL Endpoints are currently supported */
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
> +		return false;
> +
> +	return is_internal_error(info);
> +}
> +
>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  {
>  	struct aer_err_info *info = (struct aer_err_info *)data;
> @@ -136,3 +152,47 @@ void cxl_rch_enable_rcec(struct pci_dev *rcec)
>  	pci_info(rcec, "CXL: Internal errors unmasked");
>  }
>  
> +static DEFINE_KFIFO(cxl_proto_err_fifo, struct cxl_proto_err_work_data,
> +		    CXL_ERROR_SOURCES_MAX);
> +static DEFINE_SPINLOCK(cxl_proto_err_fifo_lock);
> +struct work_struct *cxl_proto_err_work;

Please make this one combo object with one registration entry point. 

struct cxl_prot_err_work {
        struct work_struct work;
        DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
                      CXL_ERROR_SOURCES_MAX);
};      

Bonus points to go back and clean up the CPER code to do the same to
reduce the amount of "registration" APIs.

> +
> +void cxl_register_proto_err_work(struct work_struct *work)
> +{
> +	guard(spinlock)(&cxl_proto_err_fifo_lock);

This lock acquisition is not protecting anything. 'unsigned long'
assignments are already atomic and forward_cxl_error() looks like it
happily de-references NULL pointers without checking the lock.

I would make it an rwsem. Hold the rwsem for write at registration /
unregistration...

> +	cxl_proto_err_work = work;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
> +
> +void cxl_unregister_proto_err_work(void)
> +{
> +	guard(spinlock)(&cxl_proto_err_fifo_lock);
> +	cxl_proto_err_work = NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
> +
> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
> +{
> +	return kfifo_get(&cxl_proto_err_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
> +
> +void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	wd.err_info = (struct cxl_proto_error_info) {
> +		.severity = aer_err_info->severity,
> +		.devfn = pdev->devfn,
> +		.bus = pdev->bus->number,
> +		.segment = pci_domain_nr(pdev->bus)
> +	};

...hold the rwsem for read when de-referencing a 'struct
cxl_prot_err_work *'

> +
> +	if (!kfifo_put(&cxl_proto_err_fifo, wd)) {
> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");

In the case that 'struct cxl_prot_err_work *' is NULL, perhaps this
should be a dev_warn_once() to say "hey, we're seeing CXL errors, but
nobody registered the CXL core!?".

> +		return;
> +	}
> +
> +	schedule_work(cxl_proto_err_work);
> +}
> +
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..24c3d9e18ad5 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/types.h>
> +#include <linux/workqueue_types.h>
>  
>  #define AER_NONFATAL			0
>  #define AER_FATAL			1
> @@ -53,6 +54,26 @@ struct aer_capability_regs {
>  	u16 uncor_err_source;
>  };
>  
> +/**
> + * struct cxl_proto_err_info - Error information used in CXL error handling
> + * @severity: AER severity
> + * @function: Device's PCI function
> + * @device: Device's PCI device
> + * @bus: Device's PCI bus
> + * @segment: Device's PCI segment
> + */
> +struct cxl_proto_error_info {
> +	int severity;
> +
> +	u8 devfn;
> +	u8 bus;
> +	u16 segment;
> +};
> +
> +struct cxl_proto_err_work_data {
> +	struct cxl_proto_error_info err_info;
> +};

Why not use cxl_proto_error_info directly?

