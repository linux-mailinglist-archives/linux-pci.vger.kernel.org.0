Return-Path: <linux-pci+bounces-28389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E2AC33D9
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 12:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C76174C74
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 10:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AFB1EF387;
	Sun, 25 May 2025 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNVfYB0d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAF1EA7DF;
	Sun, 25 May 2025 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748169012; cv=fail; b=dFCUhgnaSEjIgG4fK4TCj5Cckkdz6aGSy7Ng5ciw7J2ab5U9yCqCnbM3sjBQ3g3gsMV4HQvnVhDKLFlOeydNPKS6/Oo2PSgle1SXy7jfRDXyFdixvtNupVhPV+Y7mz9BrRhMEr6nAKrFNc5Ya5rlM5o1W6+AfM1Rdzqif88hmjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748169012; c=relaxed/simple;
	bh=x73kRLis1t3M9t8OK96XbZIX7lQWjgnWv/qNL5x2+z4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FIeO+P93r3jl8ohS/e2aAT8/5YJCYx/kEitoCTtE1KmpJyHD2PSEHnbKbYEaVFFvaau7u9Wq83nspxWiv/JKTnfttbeaIgcgWjUM9qOyDqXDP1gAS2DsXnp3GLgII/leiIoNlHgcjlKMW4yCcYWwCtUpA4+itY/M4RQ5NhccKjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNVfYB0d; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748169011; x=1779705011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x73kRLis1t3M9t8OK96XbZIX7lQWjgnWv/qNL5x2+z4=;
  b=HNVfYB0dS1VwnGAAAslmY5mHAOt73VxBVAq7AkUYt+bSikY+czmpduHq
   CHCl8TDanBDjQ9JPjJvIRvZxalScpoi768WlM3DnlOoZI1Y/nWjxVChS1
   nfCXPWKG1IMrQ6fu06Ipw5zmkFjoo+4WzwZX3S+xgU6lCQrfxFukh4RW1
   5zcIoau8OKYkhFsyGK3iazfP9lDj7Tij3a4oXEW7mIPdUXFQLl13O6gum
   5ud7dKUvO+HnkT7dBO3o4q33My41P8qLWLQCkAX0lR2SyaSV6nAqRRRAF
   Xgw4SIJjt6kTW8yRUTAPhPK9c5cutY2iEDKSa/RcVBLMhrATz+ep5qZY/
   w==;
X-CSE-ConnectionGUID: Lid71mzTQpWEU4TUSO04tA==
X-CSE-MsgGUID: FdssSIMMS/Ss3826Ic4A5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11443"; a="49413492"
X-IronPort-AV: E=Sophos;i="6.15,313,1739865600"; 
   d="scan'208";a="49413492"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 03:30:09 -0700
X-CSE-ConnectionGUID: m4CDg/cOQTqF4F+blakxYg==
X-CSE-MsgGUID: pq2nhEJDRaGOTwoa2Sbnfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,313,1739865600"; 
   d="scan'208";a="142830772"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 03:30:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 May 2025 03:30:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 25 May 2025 03:30:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.66) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sun, 25 May 2025 03:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOvJLwfnnvO9RcVe/7KTdlO2mckRpxgiPwhEbOzpONJW4MHjsh/s/XT+Lju3y/41WIoGRHNiNQqf8U0IfRiP0/Ydmh0HAsnIPXKAK9RFOpjCGTp6WyTFZBh4uhnao3oeneQVMo19rEF4B3fEB+1yeRY2V0g2+VFfVUyXfam/JS4kVMYWMp3LsQYydNJyXnK9wPI6QUE+dpJbyGeQViz/nYW4wSto4jwYhLzzsjtzzkVgID+yS0yoldAvOQXHD8br0wvAbcEKcK+qeNrJeOvqt9br9Qtvmz+MR3rnC7tVkSK/pjGb0egIz+DTqxbyP2W+gyk2tsfGgzkTcOSLkCPmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x73kRLis1t3M9t8OK96XbZIX7lQWjgnWv/qNL5x2+z4=;
 b=a+DOx0PALDxsZKPni31b3Ck8HARg1CBC0pbIbhuWjk+AFFyBOXuYhkUHzC1CP5r0/odIgia8EecNAweom08m945bI+HAl4z2N1PZbpaW1Shu25hglCLypGwTAoKcr1LMGPeFMiUalUBurPHuO9tBDgl164JVX6P/QDM0Nwxknwv2s7wgfZEVz0vYNcwUozZD9owTYVjyXpnrQvHNZXE5HqiZv1HdCap2annNcO4/4PmR9EBcFLAZN7fztPzqJD5UuueU4fOqfTmWmsJLGgH5BtMMHOP6Za94exU9KLHRk55WM2iA2gZWIFTI2UzK6yMRzIsHznuBND7SltF4quAWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by CY8PR11MB7244.namprd11.prod.outlook.com (2603:10b6:930:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Sun, 25 May
 2025 10:30:06 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%5]) with mapi id 15.20.8769.025; Sun, 25 May 2025
 10:30:05 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
Thread-Index: AQHblKzeDklmZn7b3kmCAVRfk0TayrNzCIqAgAX5lQCAAA6ggIBqhUUQ
Date: Sun, 25 May 2025 10:30:05 +0000
Message-ID: <PH0PR11MB75854C967A16F610A5F4E782F59AA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <CABBYNZJQn4ZYMxLqCkJwA71a_VWhu4QXTkU7vt7wiQXf3bdYdQ@mail.gmail.com>
 <20250318154727.GA1001403@bhelgaas>
In-Reply-To: <20250318154727.GA1001403@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|CY8PR11MB7244:EE_
x-ms-office365-filtering-correlation-id: 246432e3-10ef-4384-aff1-08dd9b771dc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V2pJR01PcFpkSysxV3Mzb3l3WVpIYkJjaFYyVzQzczNPTzZWc2ZrMHJBbHNZ?=
 =?utf-8?B?NlFLaFdXSjIyMnpjd0ZkUmwvbnV6M0thSnlyT2tFL204S3dMWmlmd2hZelBy?=
 =?utf-8?B?OE9vYnB3QzQ0RnhLbDVoc3BBNWIzSFF0VDZXU21CYTliNGtZcXZKNlVuVGdQ?=
 =?utf-8?B?bFpCZDA0Rm82WEtNdDlTK0I4TFBwVkhURlVOREhCMk9uWjlLZWovbExKcTJy?=
 =?utf-8?B?b1p1bjVXU3FpRENtc2xVQU9uRGJ5MitLTDNNdGloRklRTndhYkxsYzVCUUVU?=
 =?utf-8?B?TU9waytKQ1ZEYXlOTjdUTi81QzN1UFZ2T01obEpWYXZhSUN4dWxKMkJGQUZR?=
 =?utf-8?B?bXRJTFNvWk5LTExBM3dsTHZiR2Y3d0hYcDhGdHY2TUhXc0gyU1YzRWxBMWJN?=
 =?utf-8?B?Mm4rYXpuTHVLU0NTKzQyWE9kS2k1N2pUc21XdWtMMDA2cktyWHlxN2xzVktu?=
 =?utf-8?B?ejB4YjIxYjg0ZUxpb1F0YXFEbFFVMUdKRDE1dWI1ZnM1YlFodW03a240dmNq?=
 =?utf-8?B?VjB1eVJoSGllYXlxWUhkVWlDMUxSR2xCLzBBbFpJaVpBOS8vaGZNTVVEci85?=
 =?utf-8?B?dEJWMUpDcDNQdWp2TmxTSGR4NnJLL1ROUXVhVHRHaGNKL24wekk0TEJoUWFP?=
 =?utf-8?B?QkIzaG9URnpMZUxCZmx4TWhwYnhrUFRXVWRSTzhoRHhkS0FwaS9Na3VaSHU2?=
 =?utf-8?B?eEtHS2NIcXpzeVVxQkJCbTB5Z3NPeGN5aVVmMjgzMHpiSkk1SC9ZTkl2QVNk?=
 =?utf-8?B?UUlOVVZoV1IzTE15QmdtY25US05CTTdWa3M2Yk1WdndaTWRxV3EyQkJMUnNs?=
 =?utf-8?B?MXJydjVYaktxWk1UNzhvbTZJWUpPVmdYS0l1d3B5Qm80Q2Q3ZEMza0YybFdD?=
 =?utf-8?B?emZzWlRNcXl5RzhYQ29YWjZ5UTEwYVJnb3pzeTlNUVd6VEFhQ0NCcVlXY0FE?=
 =?utf-8?B?NXo0aGQ1aVp5enc5VmlPdGkrZ1dJajlFMm0xRW5OSUpCajhueXp1NmdjZFQy?=
 =?utf-8?B?TDdDN09vVHc4bkZ2eWJWL1ZaaDkwaDU2TmFBenhPcG9HSUt4a3Y2anVlanZi?=
 =?utf-8?B?dnRPUmlwZzVpTEh1cHpXN1doU0g0S0tIYWNpakpJMkg4ckFWNHlLTVZVTGgy?=
 =?utf-8?B?QkN2ZWlmdG8wOEZ0OGRVUVFLVmtia3hmSXdBc3lkcmZ1MGhCZ29YWnlPekNQ?=
 =?utf-8?B?dDUwZU5LMEw5ZEhQcDFtQVE2bkdUQk16WGF4RzVjNGhSQkVUcnpBL2h4U1ZG?=
 =?utf-8?B?Y3diVVlPbENWK01EdkZnNEFKV2tCejJqU3EyY3NDaVMxaVJqVEJ6K096K2pC?=
 =?utf-8?B?UUY0aW9PZGxocHJmekZBc0R2aUhocGdyNjA0S1dxV091QjRDZFBuRlkrcm5B?=
 =?utf-8?B?UWdBdUNpYzVIcVJETUdGQktUdllrTEtFOUtSRmRLSjFBMjdLMVVkeENFMkx1?=
 =?utf-8?B?bGVES2tSTi9velFvM1NHbTJLQlRjQk5RbXVMYUpGeXI4aUl2anQrMjJIcUNC?=
 =?utf-8?B?SU1mUzZTYkxyR2FKM3l5bCtqVDFWbTNlK0VXeGFqaTQ3VGRhcnJ6QkRvRG5j?=
 =?utf-8?B?S09HcUovbzNWcVVoZkxjYzdkR0l1NHUwZ3kwb2Z0dGpYbERpaERTZUZjeWUw?=
 =?utf-8?B?L2p5ekc4ck1XeTdhb2JNNEsreVNIclY1L2NvMnhpV2tlZGRGZWR2VU9NdUQw?=
 =?utf-8?B?V2FpenRiYlZXbWJWbTlRTjJaY0JDWmdMRlpHdER0dUlHK0RWSEpwRGtyS3Rt?=
 =?utf-8?B?Q2MxV3Q5YitmSHpJdVR1Um5CZkJPSkowVXh3RHVUZ3lOaUhKbFRCUWpMTVhO?=
 =?utf-8?B?d2xESjRIcml2S0JrR28xUVBEa1hKcUhqRjlHMWp2bWNVZVN5NCtKckFTM2o1?=
 =?utf-8?B?VHUvNG0rQ3h6U2ZUeU8ydGZRUk5pSUwvOFJkU0pQVG44T2pTNEF5VTl2MjF6?=
 =?utf-8?B?c2J1ODd5UkVlZ0EwaEt5K1RudXZNdktCK1A2dFNHYU9FLy9CZkRIU3VuQnBS?=
 =?utf-8?Q?t/35ZZMTZFGXYgghweweu0OuMl1QVo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFNNckxINHIyT2RrcHQya241ZHFZVnpGUEU2eFlTbHNPMmJXUXlvQ0EzenhL?=
 =?utf-8?B?emplMlM1WGVMVkMrRXlVWjYrTnQ3c0daZmFNd3VBRHV5Y2pGeFlreUlnOHll?=
 =?utf-8?B?R3AvSnl6dUM5bklteGQzV3F4UVJoVVo5YS8yd29uc3d6WjFvL0tRTDcvNlFG?=
 =?utf-8?B?QStKZDBRbVpGRVQxcFJINmt6clVZNnZHTExoQW5nRHhXZUZmMnpFYVRYRytR?=
 =?utf-8?B?RytWekE2MGd2OWJTMlhwSG9OU1hQenZQRFMvQ2lvWUIvTEtVbVpQMlhRa3ky?=
 =?utf-8?B?eDFVM0o0b1I5VURjc2tFZ2t5SlhJNmJETmIrLzQwNFl0a1l0ZDlLdVpiR2VM?=
 =?utf-8?B?SEtYRjJMb3ZxRHphbHZoenFsLzFISW80Z2lJcUkwOWxxSkdSaHBKZW8xOVRW?=
 =?utf-8?B?SGJzWmNRem1rNEREVVJTK1Z5UVpmTTdaZnhFeUhjRHdka1NjQlI1MnNIV0Iv?=
 =?utf-8?B?dzVTNEdibXJZZ2N4OGNSRGlZV1I5ajI5emRrMzJFUDZlb3JDcWR2aUs4TktP?=
 =?utf-8?B?eVZ1ZHRTS2JMZGF1WWNxL0FnQU54TnNKUExKcld2OVlEUllwbVlEdyswV0hh?=
 =?utf-8?B?d0F3Y3NaWmlhTEZLa1JoWm92ZSszSDh2NTlta3BOQjVLNlEzY1ZGZVFwMWZL?=
 =?utf-8?B?UHdsbG5TMXRGNy9pK09nK2NGWkRZVE9QQVhLQVR4V1U5UzRhMTVEakdYVzdU?=
 =?utf-8?B?dFZFQnpMdlhHMlpmdVVnV29MZ1BGYkE4ejQ5UTBVcE53U0Q2WW9lQ202ekp0?=
 =?utf-8?B?THRqTHpwbmpwU1J5ZUI1TC9mZWt2dE56eXVrUmJaUy95Y2FNMFczL1ZSSkd3?=
 =?utf-8?B?clFVcFBPTmkvSEQ5VmtEK2JoTFdFMWk1NHlTVVlpb2dGV1dxa3NwR3RwQkpU?=
 =?utf-8?B?bjVxWDNpb09peG5EN1RZY084d3ZMblplZlBsczJxaDNLTy80Wm56R1ZxOFFB?=
 =?utf-8?B?c3g0WHFCVEpJMWg4Q3B0NHIva2RNdjV0N25Kd09ud2s5enhQd0tXS0ZpZTla?=
 =?utf-8?B?bExWV0tIWHg4VzBybUt4bGZGQTVkelU5TGgvbVhtekxmYjJTa2pDVUp3M0xi?=
 =?utf-8?B?NUpSdW9XRGd3MjVJeHVtZHk0MVZhangrMDlTRlhtK2F1MlQ0SWdrMFU3di9m?=
 =?utf-8?B?TUZNR3pVTFo0TzN6MlRtYjdJZ2dBTXl2MmtXaHp2TnR3ZG5RVUlLVm0vS01N?=
 =?utf-8?B?OGFhdTVqV09mMFJpaC9raGlzS1ZlcHlhNkJLb29KbTNpL0VERVRtMVVCdTdh?=
 =?utf-8?B?NUtkY3ZYdzF6bUJPMWh4QkNpbkFSOVYvODVUZHVxcGdnREx2cnB2ek9HWmFt?=
 =?utf-8?B?MHQyUmpseEorVTVSR1h5OFUwQUMwVFJzMkdiZUVXdjlrcEV6K2owZDk1YWxF?=
 =?utf-8?B?bW9yMXdya3FxelJHN0kzcStnSXBVamZjZVJMQkVIcGhzVVo0UDQzdS9UclZE?=
 =?utf-8?B?aEMzODVaQTBKVXhuVVBkV1M5UWg5d3FxaUpmUjdrQitob1dmWW5wNVNDeFZp?=
 =?utf-8?B?aWUxb3QvbzY4UzU3OG9pUVlNekZ2enN2NktYeG56OEx3MFRPV0tjUiswZGt0?=
 =?utf-8?B?UXR2NzlwekZaQWlkRHB5L0M4ejZPYm5Ycmw1Zk04dDJzOXViWkNyalhHdk9N?=
 =?utf-8?B?UUFEN0xNSDR3S1lSbTJ5UTVjMG5vclQzZis5dncveXlzY3IreVg3OU9qd2pL?=
 =?utf-8?B?blFFcFVFM1JDdG4rQjRaWkhoKzdVTElydS9SRUw3NDZSVUJGOEdGOGs3aVlB?=
 =?utf-8?B?c21VelBNa0kvL2lJRkdLVWt1VXdES0tUREhQNHMxQlA3N2pLcVByQ1RMZ240?=
 =?utf-8?B?ZHBsaHpzSHdqdHIrbWl4Ti9TMUZrUmRlRTROSHZxN0xEV054RDRJQnpsR3k0?=
 =?utf-8?B?TSsvZTF0dWFvQVVSZExCT1JmWFFnV2VvWndYNkxYcVQ4Z0RRcTlBSmxacnkx?=
 =?utf-8?B?MC9Id0pMWEdqazQraXcxc2tuRFgvdllPTmVkaWlaRmpGbG5hWXhFNUYydjI4?=
 =?utf-8?B?MXEvc2ZtMThtQjg5cXZhQUlGODQrYUF6ekk2M1lFV1BxV2o4NkcwU0RTbzRm?=
 =?utf-8?B?QWw4NGtwZlkxOFhRcmtJa0pwMjY5VHhYUGVvb0ovRzJDMmgvWlZjejlvMjAy?=
 =?utf-8?Q?IvmA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246432e3-10ef-4384-aff1-08dd9b771dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 10:30:05.8969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sU3gdceh1dt1/y3m9XtfQBWptehOcRArCRUaPFJoHleYYFevMR0O9hmq5LtwDg7UAqF4779YoaPIG/v8k5W4Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7244
X-OriginatorOrg: intel.com

SGkgQmpvcm4sIEx1aXosDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLiBJIGhhdmUgcHVibGlz
aGVkIHYyIHZlcnNpb24gb2YgdGhlIHBhdGNoIGFkZHJlc3NpbmcgdGhlIGNvbW1lbnRzLg0KDQo+
U3ViamVjdDogUmU6IFtQQVRDSCB2MV0gQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IFN1cHBvcnQg
ZnVuY3Rpb24gbGV2ZWwgcmVzZXQNCj4NCj5PbiBUdWUsIE1hciAxOCwgMjAyNSBhdCAxMDo1NTow
NkFNIC0wNDAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IHdyb3RlOg0KPj4gT24gRnJpLCBNYXIg
MTQsIDIwMjUgYXQgMzo0MOKAr1BNIEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4g
d3JvdGU6DQo+PiA+IE9uIEZyaSwgTWFyIDE0LCAyMDI1IGF0IDEyOjE2OjEzUE0gKzAyMDAsIENo
YW5kcmFzaGVrYXIgRGV2ZWdvd2RhDQo+d3JvdGU6DQo+PiA+ID4gU3VwcG9ydCBmdW5jdGlvbiBs
ZXZlbCByZXNldCAoZmxyKSBvbiBoYXJkd2FyZSBleGNlcHRpb24gdG8NCj4+ID4gPiByZWNvdmVy
IGNvbnRyb2xsZXIuIERyaXZlciBhbHNvIGltcGxlbWVudHMgdGhlIGJhY2stb2ZmIHRpbWUgb2Yg
NQ0KPj4gPiA+IHNlY29uZHMgYW5kIHRoZSBtYXhpbXVtIG51bWJlciBvZiByZXRyaWVzIGFyZSBs
aW1pdGVkIHRvIDUgYmVmb3JlDQo+Z2l2aW5nIHVwLg0KPj4gPg0KPj4gPiBTb3J0IG9mIHdlaXJk
IHRoYXQgdGhlIGNvbW1pdCBsb2cgbWVudGlvbnMgRkxSLCBidXQgaXQncyBub3QNCj4+ID4gbWVu
dGlvbmVkIGluIHRoZSBwYXRjaCBpdHNlbGYgZXhjZXB0IGZvcg0KPkJUSU5URUxfUENJRV9GTFJf
UkVTRVRfTUFYX1JFVFJZLg0KPj4gPiBBcHBhcmVudGx5IHRoZSBhc3N1bXB0aW9uIGlzIHRoYXQg
RFNNX1NFVF9SRVNFVF9NRVRIT0RfUENJRQ0KPnBlcmZvcm1zDQo+PiA+IGFuIEZMUi4NCj4+ID4N
Cj4+ID4gU2luY2UgdGhpcyBpcyBhbiBBQ1BJIF9EU00sIHByZXN1bWFibHkgdGhpcyBtZWNoYW5p
c20gb25seSB3b3JrcyBmb3INCj4+ID4gZGV2aWNlcyBidWlsdCBpbnRvIHRoZSBwbGF0Zm9ybSwg
bm90IGZvciBhbnkgcG90ZW50aWFsIHBsdWctaW4NCj4+ID4gZGV2aWNlcyB0aGF0IHdvdWxkIG5v
dCBiZSBkZXNjcmliZWQgdmlhIEFDUEkuICBJIGd1ZXNzIHRoaXMgZHJpdmVyDQo+PiA+IHByb2Jh
Ymx5IGFscmVhZHkgb25seSB3b3JrcyBmb3IgYnVpbHQtaW4gZGV2aWNlcyBiZWNhdXNlIGl0IGFs
c28NCj4+ID4gdXNlcyBEU01fU0VUX1dESVNBQkxFMl9ERUxBWSBhbmQgRFNNX1NFVF9SRVNFVF9N
RVRIT0QuDQo+PiA+DQo+PiA+IFRoZXJlIGlzIGEgZ2VuZXJpYyBQQ0kgY29yZSB3YXkgdG8gZG8g
RkxSIChwY2llX3Jlc2V0X2ZscigpKSwgc28gSQ0KPj4gPiBhc3N1bWUgdGhlIF9EU00gZXhpc3Rz
IGJlY2F1c2UgdGhlIGRldmljZSBuZWVkcyBzb21lIGFkZGl0aW9uYWwNCj4+ID4gZGV2aWNlLXNw
ZWNpZmljIHdvcmsgYXJvdW5kIHRoZSBGTFIuDQo+PiA+DQo+PiA+ID4gK3N0YXRpYyB2b2lkIGJ0
aW50ZWxfcGNpZV9yZW1vdmFsX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3aykgew0KPj4gPiA+
ICsgICAgIHN0cnVjdCBidGludGVsX3BjaWVfcmVtb3ZhbCAqcmVtb3ZhbCA9DQo+PiA+ID4gKyAg
ICAgICAgICAgICBjb250YWluZXJfb2Yod2ssIHN0cnVjdCBidGludGVsX3BjaWVfcmVtb3ZhbCwg
d29yayk7DQo+PiA+ID4gKyAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSByZW1vdmFsLT5wZGV2
Ow0KPj4gPiA+ICsgICAgIHN0cnVjdCBwY2lfYnVzICpidXM7DQo+PiA+ID4gKyAgICAgc3RydWN0
IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhOw0KPj4gPiA+ICsNCj4+ID4gPiArICAgICBkYXRhID0g
cGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPj4gPiA+ICsNCj4+ID4gPiArICAgICBwY2lfbG9ja19y
ZXNjYW5fcmVtb3ZlKCk7DQo+PiA+ID4gKw0KPj4gPiA+ICsgICAgIGJ1cyA9IHBkZXYtPmJ1czsN
Cj4+ID4gPiArICAgICBpZiAoIWJ1cykNCj4+ID4gPiArICAgICAgICAgICAgIGdvdG8gb3V0Ow0K
Pj4gPiA+ICsNCj4+ID4gPiArICAgICBidGludGVsX2FjcGlfcmVzZXRfbWV0aG9kKGRhdGEtPmhk
ZXYpOw0KPj4gPiA+ICsgICAgIHBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZShwZGV2KTsN
Cj4+ID4gPiArICAgICBwY2lfZGV2X3B1dChwZGV2KTsNCj4+ID4gPiArDQo+PiA+ID4gKyAgICAg
aWYgKGJ1cy0+cGFyZW50KQ0KPj4gPiA+ICsgICAgICAgICAgICAgYnVzID0gYnVzLT5wYXJlbnQ7
DQo+PiA+ID4gKyAgICAgcGNpX3Jlc2Nhbl9idXMoYnVzKTsNCj4+ID4NCj4+ID4gVGhpcyByZW1v
dmUgYW5kIHJlc2NhbiBieSBhIGRyaXZlciB0aGF0J3MgYm91bmQgdG8gdGhlIGRldmljZQ0KPj4g
PiBzdWJ2ZXJ0cyB0aGUgZHJpdmVyIG1vZGVsLiAgcGNpX3N0b3BfYW5kX3JlbW92ZV9idXNfZGV2
aWNlKCkNCj4+ID4gZGV0YWNoZXMgdGhlIGRyaXZlciBmcm9tIHRoZSBkZXZpY2UuICBBZnRlciB0
aGUgZHJpdmVyIGlzIGRldGFjaGVkLA0KPj4gPiB3ZSBzaG91bGQgbm90IGJlIHJ1bm5pbmcgYW55
IGRyaXZlciBjb2RlLg0KPj4NCj4+IFllYWgsIHRoaXMgc2VsZiByZW1vdmFsIHdhcyBzb3J0IG9m
IGJ1Z2dpbmcgbWUgYXMgd2VsbCwgYWx0aG91Z2ggSSdtDQo+PiBub3QgZmFtaWxpYXIgZW5vdWdo
IHdpdGggdGhlIHBjaSBzdWJzeXN0ZW0sIGhhdmluZyB0aGUgZHJpdmVyIHJlbW92ZQ0KPj4gYW5k
IGNvbnRpbnVlIHJ1bm5pbmcgY29kZSBsaWtlIHBjaV9yZXNjYW5fYnVzIHNlZW1zIHdyb25nIGFz
IHdlIG1heQ0KPj4gZW5kIHVwIHdpdGggbXVsdGlwbGUgaW5zdGFuY2VzIG9mIHRoZSBzYW1lIGRy
aXZlci4NCj4+DQo+PiA+IFRoZXJlIGFyZSBhIGNvdXBsZSBvdGhlciBkcml2ZXJzIHRoYXQgcmVt
b3ZlIHRoZWlyIG93biBkZXZpY2UNCj4+ID4gKGF0aDlrLCBpd2x3aWZpLCBhc3VzX3dtaSwgZWVl
cGMtbGFwdG9wKSwgYnV0IEkgdGhpbmsgdGhvc2UgYXJlDQo+PiA+IGJyb2tlbiBhbmQgaXQncyBh
IG1pc3Rha2UgdG8gYWRkIHRoaXMgcGF0dGVybiB0byBtb3JlIGRyaXZlcnMuDQo+PiA+DQo+PiA+
IFdoYXQncyB0aGUgcmVhc29uIGZvciBkb2luZyB0aGUgcmVtb3ZlIGFuZCByZXNjYW4/ICBUaGUg
UENJIGNvcmUNCj4+ID4gZG9lc24ndCByZXNldCB0aGUgZGV2aWNlIHdoZW4geW91IGRvIHRoaXMs
IHNvIGl0J3Mgbm90IGEgImJpZ2dlcg0KPj4gPiBoYW1tZXIgcmVzZXQiLg0KPj4NCj4+IEkgZ3Vl
c3MgaXQgd2FzIG1vcmUgb2YgdGhlIGV4cGVjdGF0aW9uIG9mIENoYW5kcnUgdG8gaGF2ZSBhIHNv
cnQgb2YNCj4+IGhhcmQgcmVzZXQsIGRyaXZlciByZW1vdmUrcHJvYmUsIGluc3RlYWQgb2YgYSBz
b2Z0IHJlc2V0IHdoZXJlIHRoZQ0KPj4gZHJpdmVyIHdpbGwganVzdCBuZWVkIHRvIHJlaW5pdCBp
dHNlbGYgYWZ0ZXIgcGVyZm9ybWluZw0KPj4gcGNpZV9yZXNldF9mbHIuDQo+DQo+SWYgdGhlIG9i
amVjdCBpcyBqdXN0IHRvIHJlaW5pdGlhbGl6ZSB0aGUgZHJpdmVyLCBJIHRoaW5rIHRoaXMgaGFj
ayBvZiByZW1vdmluZyBhbmQNCj5yZXNjYW5uaW5nIGlzIGEgYmFkIHdheSB0byBkbyBpdC4gIElm
IHlvdSByZXNldCB0aGUgZGV2aWNlLCB5b3Ugbm93IGtub3cgdGhlDQo+c3RhdGUgb2YgdGhlIGRl
dmljZSBhbmQgeW91IGNhbiBtYWtlIHRoZSBkcml2ZXIgc3RhdGUgbWF0Y2ggaXQuICBJZiBuZWNl
c3NhcnkNCj55b3UgY2FuIGFsd2F5cyByZXVzZSBwYXJ0IG9yIGFsbCBvZiB0aGUgLnJlbW92ZSgp
IGFuZCAucHJvYmUoKSBtZXRob2RzDQo+eW91cnNlbGYsIHdpdGhvdXQgdGhpcyBkYW5jZSBvZiBj
YWxsaW5nIHBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZSgpIGFuZA0KPnBjaV9yZXNjYW5f
YnVzKCkuDQo+DQo+Qmpvcm4NCg0KVGhhbmtzLA0KS2lyYW4NCg0K

