Return-Path: <linux-pci+bounces-35311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 550B0B3F832
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C923B027B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A304E17555;
	Tue,  2 Sep 2025 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwISw5+y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410623D76;
	Tue,  2 Sep 2025 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801370; cv=fail; b=a8rM243XvwGQ60McGxBzC+2xAFQHcg/kBRropgBzkdv1jKiD+I9aa1RQpjJvprL7rc72ZFnlAmvxSN56UMK7SV+c70G49+kb8NDNj/2LNEbwInDWjYkZ6HQeCPzGqxflq+MQYJLKrMdidKbLhBeJl0hXJtD45mmbV840HqNMXD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801370; c=relaxed/simple;
	bh=j2Ni0WNrVGN/GNtyO1R7G0DYLEBK/EYG2NiYo1jG6vU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u7mV1IGrZaCmADfrRefYSfPLYwakpNr6f4naCM2hFvgGVwWg7WULss71a/8YVyqWhrlT55XVJzC1Wad4PlxXGo9pIGytD9hdW749aaUtOrfrL3T/ATbLAukT9gTt/9Gn09M47U5bp85w+FI0Ke66RpwjgWq1jdFDkBoxenpm68Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwISw5+y; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756801368; x=1788337368;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j2Ni0WNrVGN/GNtyO1R7G0DYLEBK/EYG2NiYo1jG6vU=;
  b=LwISw5+yOPj2ezHHCszJVuGOCd/XrMPwNXAyPZ+QfpPdeHH3QHnPwjFU
   BBHBMGy73ee1gYa+kU0BBlis78hgXaFuPTOuT0cWL3xceNm88ydynh2qB
   stwP+sEgfyjCF0sx+IeyuC6q2MMa7hWrzQUC6Lfcfl8ZS235dLcwm57m6
   G2NQUtdNG2TiM/mlKdNIEQLS6m3PHUnItvKGZ32P/SEqIIauubLBhK7JI
   NYxz03Mmhk2+gcVpKosY3C2kQvTcrZPBnWwrWDw2+JID9e+wywZ2h76f9
   u3Sviz58qrxtCpZsTqZN3RhRhpEhbL7mljuEiRJPfxI4yPE9NgSnkLj+0
   Q==;
X-CSE-ConnectionGUID: 5NBhl5XVRLSMwxBuEjpvTw==
X-CSE-MsgGUID: py6OwVpiRRmMRfO/UX6RUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="61701403"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="61701403"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:22:47 -0700
X-CSE-ConnectionGUID: gDmW/lnqTWCFTX2juAi1EA==
X-CSE-MsgGUID: kuKm/ljDTCCc0vkFg3YFbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176536165"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:22:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:22:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 01:22:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.72)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtFkVgW2bRynwJl4E++VGJ8JiKjs8IcX6yNoR2n3Bw6FpyPUIeTH5jZ34YdLbR/cHZOpDNaDSB9TqoJB1ZZWCtAplvBZc8pLlhvPq27IMHr+L168fR2TLOS1ZhGThz+KodOU3CUHwrV9en3sp6uc/4WVEUW9ttylG9bfTvU//OLZBLjXvpM6RgvXHhbnejBoBElkYNzjO15kcJnTv8is2eiz6qUwEY8Ty3tB9Tq9dsYHxIFrDCErIuRCVwEmv3jwWxsF+x6B5HQOoGFxvGeIfgAp6tctwBJsOJiYhyULg9cNP3KYO/9EN9VFXuv3lJU4W4/XDrWani4xFfLSeRDYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmiFOLaZc+gpI0eqrc/TCiE8mx5BYIUyu2AN6h27YNg=;
 b=YOSDlf3IMCfhvu5kvXbPZ/aDT3xoyV9O/Wl/mmGw1rnkgyOuoLq/oXtGBkquOso1zxDMS6/xo07wiRy/KTggNIPL4t1PWgWwdW7uNvyUpHcjw6xPOMgqR3zJCuqBT67x+pL1T7fAObT4Nv4KfS/GhElwPRl2V5akPlKwebV9zg30fP0hQ7MiZ8raALE2dtbJSXE0VNsQ4aOg5XiPmR8l6E9xgiPvmFTauM4hy4kDu9250HKgyNfgI/Y+WlFqsLljawf4W4hQU9QWntJhh3f/n6tG8xdIiWBKuVTu5lMvqlS0YBrOey8K0W2FjMGz9+ABLeuKL1KlSOjjWGdezY1t7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by IA3PR11MB9424.namprd11.prod.outlook.com (2603:10b6:208:583::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:22:43 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%7]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 08:22:42 +0000
Message-ID: <6754f4c7-5967-4239-8f0d-34e011cb3381@intel.com>
Date: Tue, 2 Sep 2025 13:52:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] PCI/ACPI: Add PERST# Assertion Delay _DSM method
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sathyanarayanan Kuppuswamy
	<sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
 <20250529111654.3140766-4-badal.nilawar@intel.com>
 <7bf8430d-fbb5-4e6f-9b09-11f6bc1ff67e@linux.intel.com>
 <CAJZ5v0jHbGZAePFPopDOWE86j6Ao+_rJ3FRHKyb1asmxgfLYJA@mail.gmail.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <CAJZ5v0jHbGZAePFPopDOWE86j6Ao+_rJ3FRHKyb1asmxgfLYJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::6) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|IA3PR11MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 43347818-aa6b-4e64-926a-08dde9f9e324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm9wcjF0bWRXUGtuRWtLUnVzSzlwYkNrL3l0RHFNQ2JYRWlXTVI1NHU0SXM0?=
 =?utf-8?B?L3ZPbXlZdGpIb2pDTXpXUERSWUduR1pBbXNiM1djUU9jdVAyMEFEalFIOW5a?=
 =?utf-8?B?TUtPV0xuenYvNGpXN25kdFhjbTNhaWtITXNwYzFrMy9oanF6YUFyWTg1OHJL?=
 =?utf-8?B?aEpKTlRpQy9oWUVONUhISmo2aUtlMEppUEt5OTRyYlZnamc0S2FUaGc5MlA4?=
 =?utf-8?B?WS9xZGJ1RTBRN01teHlQQlRScVRhQVNBa0J1TU9wSzNKdE5Felh4ZDBMMU43?=
 =?utf-8?B?STJMdzBUdGlaSFd4YjNZcHlsWGEzMFRZTWViaHdOWVZqRmRxNTBwNnl0NDY5?=
 =?utf-8?B?VExDdkZjb1BrSTVTdlAyODRzeWZmaTY1bmZzSFhpQ0YyeW5ibUcrajJLOEs3?=
 =?utf-8?B?NlFVSUsxK2IvTzNoRkd0ZVoxQS9RaDFYUDFrajYvdWExeVIwQ0RTWVFYUG4z?=
 =?utf-8?B?SkwzVGpkZEJod3pSUzJuemxRT1lMUzE1Z3h0enJpY3NSWTkvUEdsR09iVDJG?=
 =?utf-8?B?N3BhbzF6Y1dPREZxdTNFamxKS29aYlU2aHRJaHBsT0JQeTFtaEI1RkRuZ2t5?=
 =?utf-8?B?TEdZaVFhakZMNnNUMTA1QzlzREdoYTY3aFBqd0dpeWt5M2J5L0xNWWRZQklp?=
 =?utf-8?B?clp0cFQ1NWVLOVRSTStqUzB4L0EwSEw1YVN2N01KUWZUWG5DeElvZjJrVGo5?=
 =?utf-8?B?azRrcTlIL3BXUjVGaVNyZUF3eWhNWFg1QWE2R3R6S01xQ2tFR0VCYmp2UmRL?=
 =?utf-8?B?Vmg2cGZIWHRSa3hkbHlUcldxaTFINGRVZEhEWERRTWFZKzJSMlJuL0UxeFF2?=
 =?utf-8?B?ZVE2VnJzWUZnTkpIQWtPUEd3L1F5RHE2MloxSnRxTkdEWEsxQkdVdGFUWVEv?=
 =?utf-8?B?WG5qNXk0YmpyejVxcWIwdDIraWsxSi9aVUNScHAvQzBWSmhZU0pFbzhiOHZo?=
 =?utf-8?B?OWJ3eDJmdE4vTURQZTMwUlg3MzY2N0k2cTErdHBLbWVzVUdkOHREbjgzN1Vm?=
 =?utf-8?B?THZ6OGpkamJ4bzhIdTB3ZnlkNWlRRHhTVlZ6eDd5di9FQ0p1UUpnWExkRGFW?=
 =?utf-8?B?NEdraVFTZDdEMHBvTjUyVFZENFIybDZXMzR3c3h1dTl1ajduM3ZzWUMzYjhF?=
 =?utf-8?B?UDhTNWJWeWFQV2R4OVZndmxKaWtlS1E5TVRVb2hxUXpQVmxGZVVRK0pGZUZN?=
 =?utf-8?B?RmI4WmpTZXl1OThjRHY5U1ZVMEIwbWxKcy9CaCtZbW8yQ2NwY0ZIMFlZZUxF?=
 =?utf-8?B?eUNWaTZFWnB6c2FBcVVHSlNYUm5xVENjK3VhSXdVanRJbFJjYTloS0trcG5x?=
 =?utf-8?B?a1g4OU80VllneE52MHcrTWY3OFFPWERsd05CU29wOWxZdG9UTnpxSW1VaXBy?=
 =?utf-8?B?ODgxaENuTGVLT2F3SnNCRXc5VVpLc2NMeGNCVWZDenZiL3ZZZ1JjMlRPbEpC?=
 =?utf-8?B?YTYwVUhsWkRTRzdtVUVkYlFoemY3OHRJdFA0THltVkpUeTJHc0dKNlFhTjg5?=
 =?utf-8?B?REM2aFJ2MG1JajFsMlFMY3JaK3JkRWI4SlRMakRYeDFGVFY3QzZ0WHRPcjEz?=
 =?utf-8?B?bmlQYmFoZ2RTUnFUR3Ixekd2QWlsQ2gwR2l6a2ZqMWlUM1c4dStQdzZ4UW1X?=
 =?utf-8?B?ODdtQ0NOT2hLb3Jqbjd0Ny9OcU1oZG5SY01oN3BmeW9aME8vWnU1MDNFc2Fx?=
 =?utf-8?B?TkJxMzNsb011ZzF2dTFVYXZOQlR6WW5uVXpyMGw1ZVlnSWZPZEhIdUJDTEh4?=
 =?utf-8?B?NHJwY2JZa3FqdnU1VmlSMlc4ZHozWEFOd2oxaUhvNCtvdTc3SS9tNHI0a3BY?=
 =?utf-8?B?MEdyVUVpMEZ1S3BDQnk5dUg5eGVzSldBVllGbi9GZE4ycytqKzQ2M2VtYm9Z?=
 =?utf-8?B?am1QUFdwWFRuUmVzRUJDMjZ6OVhmSENTb3kxaFEydGpQdjhlZVVjMVphdk5q?=
 =?utf-8?Q?ePvxCxeNMFw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1WNFd2YUQ3TUtveUpCMHNuMW9IV1Q0ZkdTOFkzQ3N5RmE0Q0pDZmo0dkhs?=
 =?utf-8?B?bXZGRkI5K2wyN2lIY3gxWTlybjhRV2FHU3dxNzkyZ2g0UVFQbGJYakgzckF1?=
 =?utf-8?B?UnpxenRSQkdtN1lxa0tiN0dvelozaTZOQTZBbW5kbVcrQ3o0b1F6cU9UdDFC?=
 =?utf-8?B?bjI2ZGFrMTFhTDR4eVdoZGpacys4Z1d3Y1luaXdYbDYwUC8xQVRTZ2NmY2Y4?=
 =?utf-8?B?ditPekZ0M29mOVRsY08xeFhpb1dZN0NDNkNhQUtlbmlyMlRJRUFNczBveGFF?=
 =?utf-8?B?ZU5SL2cvVGtHRmpQU1piVmxnQldKdEFLcVRBMXB2bFFmaC9mQlNPYWIzQXFi?=
 =?utf-8?B?NDhoa0tWQWpjL2ZwekVmaTZXUCtmMmhFUUhVSSttNFA3UjJMTUV4VGJwSWJo?=
 =?utf-8?B?ZE5SelJQdWN5NVM2alRPWHNuaFEyaTJCREZ1blpiemxuNXlaRDl0S2lTM1ZT?=
 =?utf-8?B?bTV2OVphV2oreUVOaGpHMlZVdS9FZ0gxYnJYeEE3THFyd3UraGtvdGJjd3RF?=
 =?utf-8?B?S3N1aDRYbDlpTFVUbVRSN1lYblJ1Wm9mZWFOVjlmbmp4bEhnWkR4aE45RVFE?=
 =?utf-8?B?YnBzdmpQSFhSdkd5QU5oTkNHQ1NkbFNzUCs1ekxWeGlzSEViRE9TaFJoWnI3?=
 =?utf-8?B?ZmJTV3dDVWRnN01sdWdtSDFDYThIVHhURVNtN3Y4WmVqOGlwaWxYbUNYNkw3?=
 =?utf-8?B?QkloTXlQTUIwVjZJbGR0cmtIOU5pUHNsaWdSSW45a1pxY0hmeGMzM25RUDht?=
 =?utf-8?B?QmZVeXVrbGpxTVAwemx3ZWVpZmVpUmI4VTJoeWtXUHdwcEN5Rm03WUpPRThJ?=
 =?utf-8?B?N3p1d0ZzSExxT05vdWRON1puVUpQaUpwK3EvWFcwT0RYNUNnelR4NjR0NllC?=
 =?utf-8?B?dVdrSHU3ZjBpT0U4RnVtZDlxWmVNTnU0TXRxRlFUdjlsVTFtdGJoQXBoRnhm?=
 =?utf-8?B?UUdsZVlJdVQ0QWdLM3pSN24zZnBHN0laWFBac2ZNUElGdDZJM3BZREF4V0pK?=
 =?utf-8?B?S3JBUDBIKzlxbjhibmJWK0drQ2g1eEQzT2g1TU5ZL2V5cXZCQ2FIUHV1QXh4?=
 =?utf-8?B?TUVvRzlpbzFLVWovYVdMTzFHOGJJVDBBZWRUbzV5ODVmTVc5amN2SHA3L2RB?=
 =?utf-8?B?VThmdG0vWlpxNWVMQWJCcEZYUnJPeUtCMnV6VnlQV2NPLzExdVUzT1NUcXJs?=
 =?utf-8?B?bDVqdWVMbldUbEM4dTlCSGZOOHN3TFFqNFJaUDdFWUUrMHVVNEhqZlp3Zldn?=
 =?utf-8?B?UWN2aDY2YkNjYmtaV3FBV2tDcE4xZjNDRGt6clVQRW9ITDdwZEh6Q0pIc3dx?=
 =?utf-8?B?elFhbE05b3pmQXMwVnlld3NpMnMxODBmWmlzQmhkNUw4aE1kYTRFRDROaDFW?=
 =?utf-8?B?by9naTBRSXF6SUhHSnNlVmFFMDJsa2FHeEJqQytMRFNPZlhueDdqZi82KzBu?=
 =?utf-8?B?LzhwbE90UUFWNloxSG1MblBNZDF3RjJoSlhHSWw3R3JsV3ZkOXpCV3c2bmgv?=
 =?utf-8?B?VGhIaytlZ05Zc3BIRnZBY0NyWlpjb0hDVU5QVlczZTVCU3A2T2FDdVF5Z2to?=
 =?utf-8?B?RlRJVTBxU2d6c3lPSDIzS2pWUFJJYS90Z0wzYXlPSWJla1hYL0E4VlRiWlZO?=
 =?utf-8?B?ZTl2RnVVVUpHY2d2ajZtWkZtMGxTZEtWdVozamFkbHpOTjlCc1pxQ0MzRGla?=
 =?utf-8?B?YWN3QVM2eWdUalMwdnQ3VWZoWUdITEdMTFRjd0tKL2VTc1dGM2YrbkJiVUdB?=
 =?utf-8?B?RnRXMWpKMWhOcmRxTGhNc0tCMFI5NDNEdHRhVTlDYW5CVVpFOTB6d3ppUHNB?=
 =?utf-8?B?eWJhYTVqTFAwVTA2SlZnK1E5bVhzbU5KVHl2dHFlT3RTcXEzQU9ZdmJteEd1?=
 =?utf-8?B?bmlxcGV6UU9keHdTTjh6YkJKRkFUanVRRG9IS0EvVGlRb1k0RHZwMTZLLzBp?=
 =?utf-8?B?REg1QmNkNzNTZjEyS1J3clRQSnVXeFJQK0Y4K2NvUHdoSHQ4QmJyUWRYN0ZK?=
 =?utf-8?B?M0c2ZUdFWFFOZWxuWVM2RHZSaUcrYVExOExKcEZuZCtWS1JDeFpPaVM2Z1NR?=
 =?utf-8?B?bUZZTVdRSGZERUY0RmNDUEZ2Z0dnMHVjTHFaZTREMEdvOEVBYzUxMVlFQVFP?=
 =?utf-8?B?UytLRWxOeHpvWmo1RngyR0NmOFpmZ2pEMnozVTRSQTV5aXNvS3lDekRoeldK?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43347818-aa6b-4e64-926a-08dde9f9e324
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:22:42.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4mD5JuvmP6OhvLMAMGSHOYbM5o8wQwbV6wyP0pJ1T/6nLjTqY/VqnkJdM1A/HvoaU7sHHse0TIQ0ecgeP8RPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9424
X-OriginatorOrg: intel.com


On 02-07-2025 16:55, Rafael J. Wysocki wrote:
> On Thu, May 29, 2025 at 11:57 PM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> On 5/29/25 4:16 AM, Badal Nilawar wrote:
>>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>>
>>> Implement _DSM Method 0Bh as per PCI firmware specs
>>> section 4.6.11 Rev 3.3.
>>>
>>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>>> ---
>>>    drivers/pci/pci-acpi.c   | 57 ++++++++++++++++++++++++++++++++++++++++
>>>    include/linux/pci-acpi.h |  8 +++++-
>>>    2 files changed, 64 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>> index d33efba4ca94..88044491feaa 100644
>>> --- a/drivers/pci/pci-acpi.c
>>> +++ b/drivers/pci/pci-acpi.c
>>> @@ -1531,6 +1531,63 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>>    }
>>>    EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>>>
>>> +/**
>>> + * pci_acpi_add_perst_assertion_delay - Request PERST# delay via ACPI DSM
>>> + * @dev: PCI device instance
>>> + * @delay_us: Requested delay_us
>>> + *
>>> + * This function sends a request to the host BIOS via ACPI _DSM to grant the
>>> + * required PERST# delay for the specified PCI device. It evaluates the _DSM
>>> + * to request the PERST# delay and handles the response accordingly.
>>> + *
>>> + * Return: returns 0 on success and errno on failure.
>>> + */
>>> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
>>> +{
>>> +     union acpi_object in_obj = {
>>> +             .integer.type = ACPI_TYPE_INTEGER,
>>> +             .integer.value = delay_us,
>>> +     };
>>> +
>>> +     union acpi_object *out_obj;
>>> +     acpi_handle handle;
>>> +     int result, ret = -EINVAL;
>>> +
>>> +     if (!dev)
>>> +             return -EINVAL;
>>> +
>>> +     handle = ACPI_HANDLE(&dev->dev);
>>> +     if (!handle)
>>> +             return -EINVAL;
>>> +
>>> +     if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << DSM_PCI_PERST_ASSERTION_DELAY)) {
>>> +             pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", DSM_PCI_PERST_ASSERTION_DELAY);
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>>> +                                       DSM_PCI_PERST_ASSERTION_DELAY,
>>> +                                       &in_obj, ACPI_TYPE_INTEGER);
>>> +     if (!out_obj)
>>> +             return -EINVAL;
>>> +
>>> +     result = out_obj->integer.value;
>>> +
>>> +     if (result == delay_us) {
>>> +             pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);
>>> +             ret = 0;
>> I think above is a debug message. If it is set properly, why would you want to know
>> the details?
>>
>>> +     } else if (result == 0) {
>>> +             pci_warn(dev, "PERST# Assertion Delay request failed, no previous valid request\n");
>>> +     } else {
>>> +             pci_warn(dev, "PERST# Assertion Delay request failed, Previous valid delay: %u microseconds\n",
>>> +                      result);
>>> +     }
>> May be you don't need to elaborate the error details. Will following work?
>>
>> pci_warn(dev, "PERST# Assertion Delay request failed, result:%u micro seconds\n", result);
> Or even
>
> pci_info(dev, "PERST# Assertion Delay request failed, using %u ms
> delay\n", result);
>
> And it doesn't really need to be pci_warn().

Make sense. I will incorporate above suggestion in next rev.

Thanks,
Badal

>
>>> +
>>> +     ACPI_FREE(out_obj);
>>> +     return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pci_acpi_add_perst_assertion_delay);
>>> +
>>>    static void pci_acpi_set_external_facing(struct pci_dev *dev)
>>>    {
>>>        u8 val;
>>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>>> index 6079306ad754..e53d4893cf56 100644
>>> --- a/include/linux/pci-acpi.h
>>> +++ b/include/linux/pci-acpi.h
>>> @@ -122,6 +122,7 @@ extern const guid_t pci_acpi_dsm_guid;
>>>    #define DSM_PCI_POWER_ON_RESET_DELAY                0x08
>>>    #define DSM_PCI_DEVICE_READINESS_DURATIONS  0x09
>>>    #define DSM_PCI_D3COLD_AUX_POWER_LIMIT              0x0A
>>> +#define DSM_PCI_PERST_ASSERTION_DELAY                0x0B
>>>
>>>    #ifdef CONFIG_PCIE_EDR
>>>    void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
>>> @@ -135,7 +136,7 @@ int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_de
>>>    void pci_acpi_clear_companion_lookup_hook(void);
>>>    int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>>                                      u32 *retry_interval);
>>> -
>>> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
>>>    #else       /* CONFIG_ACPI */
>>>    static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>>>    static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>>> @@ -144,6 +145,11 @@ static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 req
>>>    {
>>>        return -EOPNOTSUPP;
>>>    }
>>> +
>>> +static inline int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
>>> +{
>>> +     return -EOPNOTSUPP;
>>> +}
>>>    #endif      /* CONFIG_ACPI */
>>>
>>>    #endif      /* _PCI_ACPI_H_ */
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
>>

