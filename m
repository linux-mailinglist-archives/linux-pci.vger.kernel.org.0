Return-Path: <linux-pci+bounces-40437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EDAC386AC
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 00:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32B83AC95A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DE1299959;
	Wed,  5 Nov 2025 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/xrCf8Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBBB1FA272
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386718; cv=fail; b=EysNsOrVxUYoV8Q+cgQXu8R/3QRMmIqi7Euz+KBm2vHlZ4dwaqi9pH8dM6TN3emQV8O7IndW7TnpFjQK+34e4XGoJWKHRxc6PDhIEnFnlh16Gq4QOqxpOyAO2SOHp1SDomBGFHAlweQJ5PFkwVhJ1Dq0odNpni0RsSchxgrEvaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386718; c=relaxed/simple;
	bh=xuHvhPqlUAV6BjQZJ58RCi9FUEjZRXxzIWukcgnsxFo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=UsOgHidTT4p4rrnidrK/PEYimoxxuN2dbMw/eH/BESmczaIxf/1sDxP1RehZ1/RSW6Yzm4bS/m3mbMS4iFiCvSmIXUqjaWHRkeCknc86DUHK3NDfz2IZUlCFJIsXCQLxDv3nt8KVKW1qPvzqQbbKuUEN5MwHVpuLiYOMzdZIBH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/xrCf8Z; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762386717; x=1793922717;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=xuHvhPqlUAV6BjQZJ58RCi9FUEjZRXxzIWukcgnsxFo=;
  b=l/xrCf8Zh6sHo1TpqS533r70yvdLM77uagQXSDCPEYJT2Udo7e8ucRLr
   r05gtIL1lon8dGQ9Vf8YNt/tmgyw0CFpA23RgMtp7FoaKVT3UWWVhA9Ga
   GIKigsCGnE11FcQ+b/3BzriCQEpQGko8mZ48YbM0pPvvsYBwH3aaUDF/5
   tp6i7JGGjJtSR1iVu0Or8lYsZPQsTn8DYSyM06j8AULDwp1p4plrS8YsV
   wT28/CHEk5/5a3ULWN8q2aANqrRKWbgt30SPFSlxrZVWt77Js01i6vR9I
   7nUn2gqbgcd7b6FRGBsIVoaxUezwpbZKFPsdxd2hw8mDY2ZK1vJ/T57gF
   w==;
X-CSE-ConnectionGUID: v3TCtIcZRwSjWyLdm5UxjQ==
X-CSE-MsgGUID: gqmy7kaUQb+36LGQx+/Y/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64665770"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="64665770"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:51:56 -0800
X-CSE-ConnectionGUID: OzVCbvBgTDWzhYtTlwLjNQ==
X-CSE-MsgGUID: v7oWn3ReRQG3f7uUNcljPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="188047266"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:51:56 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 15:51:55 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 15:51:55 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 15:51:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9OgAGrILPdD8xF36+N8jEeNfoK3JvbI7YayL2fLp1REeiIgmz8AqMDf9LgH+9sRaCGTK4gWLGOuHM9sTxG8R9rgQzCj7YmG5uiVsH7wadFkYuhXmHkKg/FtThiTS/Nz0X0gZvcNDsvJkWvTiV/0xBg4Y9f+VK16yQc2ik8w0+zZjLN/6R7GEo8veO21PbI11RR3LaBQ9AlCm/0fJkBVGA7NY1iC+09sj9GAhYvfHC0OoRZQoTKo2ttva6UDx2Vzh/SqM+QfYyhLvHw0ViA6EarzUya2T9KlqLJ30AxsnhG6edRGvymCgzmvJF11gDtCaVdKBU889x/jRr21KWiPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPhcK6HaTBSwMeMyeLYUHc69dCiYB+n8n7j8ZQByIgA=;
 b=ny78YVi1uK2TQp1vz3Mo3WMo8RFvS+gwyZBb7950qDntmbDVl/GpziGXily2k5tYrhm5AAQeXVgsKemOYdhmWim03lB4xOPzzBkEYVrC2Fznnxa4SzLAApNlTrZWRLXkrzPQBT4esfGWSwcKvF0WquZDKaDULnkab07EE6zsPKmr2kgYxRLBNKlCO7GkrkqHg4ZGVi1C7ogc0VLoxom1Ie8V6UniSYJ0oit3ZbieUVmjyCAWlS2NdY2N3AlKgbGbRPCmikJZDhtJin96jd247f3V6nvGb9KtYsCv3WAS73zPS8Zcv2N7F0E897HyBjt99iKCOHejngrFitxRJCD4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPFEF920636F.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 23:51:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 23:51:51 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 5 Nov 2025 15:51:49 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>
Message-ID: <690be315ed059_74f761007a@dwillia2-mobl4.notmuch>
In-Reply-To: <20251105152704.00002741@huawei.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
 <20251105040055.2832866-4-dan.j.williams@intel.com>
 <20251105152704.00002741@huawei.com>
Subject: Re: [PATCH 3/6] PCI/IDE: Initialize an ID for all IDE streams
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:a03:80::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPFEF920636F:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3a351d-8dec-4bb2-7dbf-08de1cc64a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUlIOHlpUkFpU28xQTA2OGQ5Vk95RmZrbVc3RTlrYVV5SmVzWVJ1eDQzNkFz?=
 =?utf-8?B?bWhSbUtzUThwZDVwb1lVek1ad0U3U241SW90akRCcXYzMnNsckExdkJwRklZ?=
 =?utf-8?B?eEdlK1NtOE5JNGFYUCt3RFFCVGhFWERXc2NPM29OQTN4MnZCQUpBNDBKODN5?=
 =?utf-8?B?ZmlBWE5SOVpsNWRZNUxKNVFJWVkzTUFMTSt6RVAyUGxXMUZhbDBIaU5kaWpD?=
 =?utf-8?B?YUVHdDU3a0dCdE5PUUhHYSs2L1NpNnM5b0F2WmFlQ1g2NDc3VHFFbVBjdHls?=
 =?utf-8?B?KzFnRllSR0xFR0FNL2VYdzNEaldEcm5XTEdRcTlhMmxCcE9ndXIvRW95U28r?=
 =?utf-8?B?Sm9QcUpsd0F6Q1dyTzU4YTNBL0wxWDMzR3lMUHAxYjZsakRrQjJPZXBoeHp3?=
 =?utf-8?B?a0ZoR3RKMDlNWTVMTGh6clZmUzh1dTVGeTNFWnMwU1l5UmwvSFJJcmhzdnV6?=
 =?utf-8?B?YUh0dVFOdWxYa0lFWUkyMXl2K0daZ3NKVWxnbHphMmo3MlZHQ1NveG5WWWs1?=
 =?utf-8?B?NnZjRDcxaVk0WDAyYjBLYkNRZlNEU0QzTUtyVzI0N2RwZndKRGIvSXVwMDFL?=
 =?utf-8?B?TVh2MmhaS2k3bFpIbnM2bjRjTWNFelAyWVRQM3JMSjRkSHZtMDVmOXhtRGhF?=
 =?utf-8?B?ak5hNjJwSjdGNXQzU015dG9aVitZaGhlTmJubk9zdXRkWVJjUmFteFYzSldN?=
 =?utf-8?B?Q1hjWDVpUEs0RVVOOTc2MGljK2ZJeGdGUTNXbUlmamVTbnZ2Y2lnZzJVSEQx?=
 =?utf-8?B?aFJvUWN1M0VIOFEzZGNBa0ZnQUFCS2Z1QzZnSVRjR01MRS9sTFZTU21nNUxo?=
 =?utf-8?B?UjZUMGp1WXpENkwvdmE3N3lFdG80T2grZzE1NzNHcWlYbTE1elhkQkR6ejhl?=
 =?utf-8?B?aUdaTmlqYzR1bUdEMVYvYXVSM0dXVWNwak5CcktJWmZpU1daOXVBNHdsNENW?=
 =?utf-8?B?Q3RtaTFTSTZic25rRzJrMlFPanJCVmhPLzQxcDBwQ25Wbml1eFA2bjVCZTVw?=
 =?utf-8?B?WHMvcTZTMTlpbC9KN3dtcTRiUzJpVWoxcmsvd0UwYmx4bEZQejBhaUc4MjhK?=
 =?utf-8?B?ZXJaNk85aHVoQUJKbmRPVEpSdEg3TU9STWxzKzU5MW9BU2lSY1E2VVJEemZ6?=
 =?utf-8?B?Z28rS2xkNlZpRTkwTXJuSnh1QmlpcEQ5Q1hwM1RJQ2ltc21vdkNkeTF6OVNn?=
 =?utf-8?B?c2Z1bWJEWk1KOGRIVi9aWUtVcERzWC9Cam1BTWJCY3kwYzRyMlNCcWpkc0RF?=
 =?utf-8?B?ODZwWVJZTTQyWnAvREdob3d6blk0ckNhTDNXWkdrWG5zaXYreUEwNUpWOU5C?=
 =?utf-8?B?My90Uzg3T2dNcm05bnhPd2k3SHQ4M0lYTEpabnRNcVhIQk1RL1Y4Q2RNbjI2?=
 =?utf-8?B?L0JSM3lvNFpkdGwzUFBLVStvK1lHUUwzU3l6eC82dkdwRThEVWROUDh3ZmNl?=
 =?utf-8?B?L0tiNWxlZXc2RWFlSTJ2cEdJSXNoZzk0aGJBcmh1dloveG1aL1JLSmZFR1Nk?=
 =?utf-8?B?TkVLa1VWc291dzl4dWpVNHBJaEp6S2RCb28vdXdaWnh0MXU1N2hKTXltZVFV?=
 =?utf-8?B?NnJadmRQcXYwbGFreWwxaUdteW0wa2sxYmdGWk9LNmIwRU96WHgyOVI1U1dC?=
 =?utf-8?B?UFNLTitpdmpyeWFSV002bTJxaFRCSTV0MjRqZFBBV0d5YkFEQnZwQUtRaldS?=
 =?utf-8?B?cWc2amdQSnFmQ285NjExekxXdDFucG1va0J3OEpMTFY2Z0QrdmdyTUtvZnVZ?=
 =?utf-8?B?U3NaTFBWd2g2ZVNTQkQzWWhhQkVENkMyVklNWFZIczBjV2pZUFlBVFVOU1dC?=
 =?utf-8?B?UHNSb1NHTFlCeFJLWEhTeEdlMEpiVVZIWWsxcWJDRUpnM2QranhsQnJSa0xI?=
 =?utf-8?B?S1JSbUZESzYvN3UwZ2JMbWdMVGluaVFuSW05ZUVhMzZaenZuWXJnM3R6VHZK?=
 =?utf-8?Q?2Ln6jRorWGpgTFvxfPbW+nJLxgWNzHsw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9DdFZ1VmhxTlU1dUZqWmFZWGYyRS9yZ1kzdzREYTZyQ0VaTTVlaXh2eG1m?=
 =?utf-8?B?QWIrNEhDcVJSY2hBRkhvb2N5L3pCanhIRVNRR2JvZHlFNEFGNWV4Sk9BR2Zx?=
 =?utf-8?B?SVgxREZMK3J6Z0xVaDBMRUlIN0VqOWpFRnpNOWx5MmFJZXJ6U3pBL3JnWnMw?=
 =?utf-8?B?MGsxYkdCKzZIRXo5TkpXMFFuak45QVNBQ0w0RW8yUXNXNWJ2R3A3OEpKNkQz?=
 =?utf-8?B?bnhlMjQxSWkyQVRLemJkdnljR2p0cFg1SG5MTkZrd2V0blg2bHdLeHUydkNR?=
 =?utf-8?B?WnBteVd1bVRQeXlBVmZFN3pFS3ZITXJqQTEySFpxU2c1eEVSeTBDSzBmTHQz?=
 =?utf-8?B?MVNsa1dHZjJRK2dkNVc5T0h1ZUNCaVM4Y1FMdW5USHFBdjRMYjZUQk1yMVY2?=
 =?utf-8?B?Q2c2QUxYSmVpNUdkTWtheVIrQ05BdkJPT043RDU3dG1BVDUzcUZLU1AyZFFN?=
 =?utf-8?B?L3B1UmNicitSOENYSy9RdnE0R01IZ0FLQkE5ODFrbWJPYWloaXF4YS9FNEEw?=
 =?utf-8?B?emdWd0JWbXAydGFOYkViOVFmQi9XMkw0WHZ2Y3ZiTTlvRUlLRlF1WStPalhm?=
 =?utf-8?B?Q3hiaGJMdkI2RW01SXU2K0VreFJ2WmZVcWltZVhzS1RoWW9tZHAwTHlqK0Y1?=
 =?utf-8?B?bHd3emw1bExqWmxIQkNsQk91V044Z2R4RmpucHVEMWdSY3RsSitzN2NtdG1s?=
 =?utf-8?B?R2dtSnJ6TUJxd2hRRmtTZnZqSGVCTTdodWdCT28wK2ZIWTBUQWJFNlhFTXZB?=
 =?utf-8?B?Tk5Yelh6Q1piUmVOemZ0U212NlBDVWVpY3d1SXh6UnNha0ZGRlNNY2J0WE9z?=
 =?utf-8?B?QjhwWWFLU3phcitNU2ZUU0p6ZmhpYkZCN2RKUGY1dFc4VFh6NGphNW4rTHkz?=
 =?utf-8?B?NUhPUmJNYVBOMHUxZlFsaTgvQnZodnYrNCtrckJ1QzBza2RES3NzaGRXbHVK?=
 =?utf-8?B?VlZzd0NwNnA4MUdjdVA0Ym8rcG9xVkw2aDRiUzR4SDdwWVFpYTZPZlpBZ2lI?=
 =?utf-8?B?TDlvSUgwWEo2T0NaL2VmUWVJbFBSR2JMdzRoSnBZazhjSkJHNDVNckM5RVN6?=
 =?utf-8?B?RHhLaU9sTzZ1azhoVVZTemtqZldLbXRmYitVVFVKOTE2Z0tnQWMrbmNNbEJW?=
 =?utf-8?B?TXordkpiSmdaU012bTRLZkp5UVFnM0FRdmVLVU4vaTA2SEJSc09XRlBjQVFz?=
 =?utf-8?B?THd6S2VrU1cvMGJObWtBRS9USjhuMEdHbzRIck45cnFIeGROSGpVa2hydG9M?=
 =?utf-8?B?OXdxMjVDa1VVeVdmUnRmait1ZENSZWY3MXM4SlVaTi84YzBobWUvdUlHQTQz?=
 =?utf-8?B?THhsRzIyWXdYT3dwaXZweHhSUU80VTRxRjN6cXVjYVBWMkVzbjNXd2RuSk81?=
 =?utf-8?B?MHhUL0YvQnlYaXBaVzZVVmoxRTZ0YzZRTEpvaVdVSEkxQ2JXZCtqbE1FdHRM?=
 =?utf-8?B?b3hZTU93K0s2eXBxQkV4Z3djZlprMGNESGVtMDZkMi96Y1pVM3VFL2FTU0lK?=
 =?utf-8?B?aDZEejFBbi9Pbk4rbEZOSWxUYmx1YnhNdnVRdUNaN29rUE1aWDJKUUphN2lB?=
 =?utf-8?B?MW9JRHUrLzgyTFptZ0NjdWNhNGFCc2ZEcXMwSVFsOCtLalVILzYrRlNXY2d1?=
 =?utf-8?B?TFNsZEdpUGVuOElFRGh6d1RaRDdHNFdlTUgzajd2OUZSU2FvT09ucnVpTlRM?=
 =?utf-8?B?WEMxVGxBS2hWUHFKUXIvRjJjbkwrblJLZGlOUm15OTZDQlRYN2dzanRQbnJQ?=
 =?utf-8?B?SklXUUJ6REVqWDZDTUQ4bXViVXBnTjg0SGtXMmxHQ0VzTi9yQUY0UXpkZjhu?=
 =?utf-8?B?MXUwZVU1OXFYdkxMNnN4QTFYR3NLb2lVWkVzUStMYTZoQVhOQjZkdzd3dldD?=
 =?utf-8?B?dCtlTDNFeEtKMU8xdi9EWjRKRGhLaTlVeGNrSFNqNElPaWJMeEwzOU1Fd3lT?=
 =?utf-8?B?T0JFeDBMN2swTndCOGlpeis0YjNOR3I2WXFzR1lxbnRWZ3krL3MycXpBYkhh?=
 =?utf-8?B?Q3FWUy9ybUJnZyttSmNNL1Y0NHhzQTVhdlhCWS9XRkZZQkN3cjMxREFoNEN4?=
 =?utf-8?B?TE1ZN0crTVd0UENZc01WT0FNWnI1b25OMG5NcVBwN3RXT1BQV3ZrSytLNUVN?=
 =?utf-8?B?R2ZZdG5LMXNMd1l1b2F4Q0FKQkRyVm02TVBabXRjS1pSMHl3NmtLQ2ttL2kv?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3a351d-8dec-4bb2-7dbf-08de1cc64a78
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 23:51:51.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/6gW0ONZRth2p2bvMbD4dbg0UZ7jR9FfFkvk4nOLoEYDOlLrjQqI0LBxCUtqdo426VesJNZt0Sa86ao+jcen/3Ld16S5eFv+k/1A34cX+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEF920636F
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue,  4 Nov 2025 20:00:52 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The PCIe spec defines two types of streams - selective and link.  Each
> > stream has an ID from the same bucket so a stream ID does not tell the
> > type.  The spec defines an "enable" bit for every stream and required
> > stream IDs to be unique among all enabled stream but there is no such
> > requirement for disabled streams.
> > 
> > However, when IDE_KM is programming keys, an IDE-capable device needs
> > to know the type of stream being programmed to write it directly to
> > the hardware as keys are relatively large, possibly many of them and
> > devices often struggle with keeping around rather big data not being
> > used.
> > 
> > Walk through all streams on a device and initialise the IDs to some
> > unique number, both link and selective.
> > 
> > The weakest part of this proposal is the host bridge ide_stream_ids_ida.
> > Technically, a Stream ID only needs to be unique within a given partner
> > pair. However, with "anonymous" / unassigned streams there is no convenient
> > place to track the available ids. Proceed with an ida in the host bridge
> > for now, but consider moving this tracking to be an ide_stream_ids_ida per
> > device.
> > 
> > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> A small side discussion on whether a new type of cleanup helper makes
> sense here for allocations that need to stash some data which is never
> used except in __free. Bit of an odd corner case but could see something
> similar for pool allocators (Which is kind of what we have here).
> 
> > ---
> >  drivers/pci/pci.h       |   2 +
> >  include/linux/pci-ide.h |   6 ++
> >  include/linux/pci.h     |   1 +
> >  drivers/pci/ide.c       | 133 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/remove.c    |   1 +
> >  5 files changed, 143 insertions(+)
> > 
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index d7fc741f3a26..33b3c54c62a1 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
> > @@ -35,8 +35,54 @@ static int sel_ide_offset(struct pci_dev *pdev,
> >  				settings->stream_index, pdev->nr_ide_mem);
> >  }
> >  
> > +static bool reserve_stream_index(struct pci_dev *pdev, u8 idx)
> > +{
> > +	int ret;
> > +
> > +	ret = ida_alloc_range(&pdev->ide_stream_ida, idx, idx, GFP_KERNEL);
> > +	if (ret < 0)
> > +		return false;
> > +	return true;
> 
> 	return ret >= 0; perhaps

Sure.

> > +}
> > +
> > +static bool claim_stream(struct pci_host_bridge *hb, u8 stream_id,
> > +			 struct pci_dev *pdev, u8 stream_idx)
> > +{
> > +	dev_info(&hb->dev, "Stream ID %d active at init\n", stream_id);
> > +	if (!reserve_stream_id(hb, stream_id)) {
> > +		dev_info(&hb->dev, "Failed to claim %s Stream ID %d\n",
> > +			 stream_id == PCI_IDE_RESERVED_STREAM_ID ? "reserved" :
> > +								   "active",
> > +			 stream_id);
> 
> Good to have a comment on why we carry on anyway.

...but we do not carry on. When claim_stream() fails pci_ide_init()
fails. So this dev_info() is there to clue in an admin wondering why IDE
capabilities may not be available for some devices.

[..]
> > @@ -83,6 +129,7 @@ void pci_ide_init(struct pci_dev *pdev)
> >  		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
> >  		int nr_assoc;
> >  		u32 val;
> > +		u8 id;
> >  
> >  		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
> >  
> > @@ -98,6 +145,51 @@ void pci_ide_init(struct pci_dev *pdev)
> >  		}
> >  
> >  		nr_ide_mem = nr_assoc;
> > +
> > +		/*
> > +		 * Claim Stream IDs and Selective Stream blocks that are already
> > +		 * active on the device
> > +		 */
> > +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CTL, &val);
> > +		id = FIELD_GET(PCI_IDE_SEL_CTL_ID, val);
> > +		if ((val & PCI_IDE_SEL_CTL_EN) &&
> > +		    !claim_stream(hb, id, pdev, i))
> > +			return;
> Related to above, I'm not sure why we just eat this problem with a print.

Explained above.

[..]
> > @@ -301,6 +393,28 @@ void pci_ide_stream_release(struct pci_ide *ide)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_ide_stream_release);
> >  
> > +struct pci_ide_stream_id {
> > +	struct pci_host_bridge *hb;
> > +	u8 stream_id;
> > +};
> > +
> > +static struct pci_ide_stream_id *alloc_stream_id(struct pci_host_bridge *hb,
> > +						 u8 stream_id,
> > +						 struct pci_ide_stream_id *sid)
> 
> Doesn't feel like an allocation function to me. Maybe a rename if
> it doesn't gain some allocation abilities later?

No, it does not, rename sounds good.

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 33b3c54c62a1..60c22a6ee322 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -398,9 +394,9 @@ struct pci_ide_stream_id {
 	u8 stream_id;
 };
 
-static struct pci_ide_stream_id *alloc_stream_id(struct pci_host_bridge *hb,
-						 u8 stream_id,
-						 struct pci_ide_stream_id *sid)
+static struct pci_ide_stream_id *
+request_stream_id(struct pci_host_bridge *hb, u8 stream_id,
+		  struct pci_ide_stream_id *sid)
 {
 	if (!reserve_stream_id(hb, stream_id))
 		return NULL;
@@ -437,7 +433,7 @@ int pci_ide_stream_register(struct pci_ide *ide)
 	}
 
 	struct pci_ide_stream_id *sid __free(free_stream_id) =
-		alloc_stream_id(hb, ide->stream_id, &__sid);
+		request_stream_id(hb, ide->stream_id, &__sid);
 	if (!sid) {
 		pci_err(pdev, "Setup fail: Stream ID %d in use\n", ide->stream_id);
 		return -EBUSY;
> 
> > +{
> > +	if (!reserve_stream_id(hb, stream_id))
> > +		return NULL;
> > +
> > +	*sid = (struct pci_ide_stream_id) {
> > +		.hb = hb,
> > +		.stream_id = stream_id,
> > +	};
> > +
> > +	return sid;
> > +}
> > +DEFINE_FREE(free_stream_id, struct pci_ide_stream_id *,
> > +	    if (_T) ida_free(&_T->hb->ide_stream_ids_ida, _T->stream_id))
> > +
> >  /**
> >   * pci_ide_stream_register() - Prepare to activate an IDE Stream
> >   * @ide: IDE settings descriptor
> > @@ -313,6 +427,7 @@ int pci_ide_stream_register(struct pci_ide *ide)
> >  {
> >  	struct pci_dev *pdev = ide->pdev;
> >  	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> > +	struct pci_ide_stream_id __sid;
> >  	u8 ep_stream, rp_stream;
> >  	int rc;
> >  
> > @@ -321,6 +436,13 @@ int pci_ide_stream_register(struct pci_ide *ide)
> >  		return -ENXIO;
> >  	}
> >  
> > +	struct pci_ide_stream_id *sid __free(free_stream_id) =
> > +		alloc_stream_id(hb, ide->stream_id, &__sid);
> 
> Given the use of __sid as magic storage, I wonder if this can
> be a CLASS with that storage wrapped up alongside a flag
> we clear to make the destructor a no op. Similar to what happens for
> spin_lock_irqsave where we stash flags etc via __DEFINE_UNLOCK_GUARD() 
> 
> Would need something a little more complex than current retain_and_null_ptr()
> as it would need to set _T.ptr = NULL rather that _T = NULL.

Interesting. It is rare to have this kind of request model in core code.
Most of the "discover the platform published resource + request it"
happens in driver probe contexts and devm cleanup is available for that
(e.g.  devm_request_mem_region()). If we can find more users for such a
scope-based-cleanup model I would cheer on the person that wanted to
take that on.

Otherwise the "magic storage" approach is also taken with:

    struct stream_index __stream[PCI_IDE_HB + 1];
    ...
    alloc_stream_index(..., &__stream[...]);

