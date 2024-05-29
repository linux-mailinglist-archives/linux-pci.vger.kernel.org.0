Return-Path: <linux-pci+bounces-8037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CC78D3B1C
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 17:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F5F286723
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36E180A8B;
	Wed, 29 May 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMBXCEus"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82305746E
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997026; cv=fail; b=MkdaUnciFP/DMBLchDpYLfhWURal0YOINBNCxy0zKbM66h702ghtKcVEQES3wrQyUqGicF7MSh2GJzK8NmcUGW+BZ9DNZkjrybFyT6ZUj2ExsOAm+aUuA02GIdyzVejCuHABeq5yGXREh0FQqINhr/gqS7hXyWWYWeX5vem4wuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997026; c=relaxed/simple;
	bh=5Lye3jaO6mUT0VeRAMNy4CcPdEdiYi7xANGrRUjuwDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oRqY32SSTRWVnzfFP8SpUhfUau21FVSW2OgIkAa9d+zw2+++YJa3uVdgQ9bDblCC0h4Rc5XqwY2r6cB2Hdaa8WgnkUqh7kNArAp9l89kSP3dIoauURo7yEuLxEjUGmOrpGQLB+fgPIvtkIe3MYaA461W6LH1bN8EUaS5r+0tyS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMBXCEus; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716997024; x=1748533024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Lye3jaO6mUT0VeRAMNy4CcPdEdiYi7xANGrRUjuwDU=;
  b=RMBXCEusQudyIVXsZrH+IELo7meYB9UkE/Zq/Dl0uInIoUXD6prOruo2
   XksTUOnFNlE3dW2kyRa5KVuygx+tAcZnV/5o2PwAT/x7U0SuQR3ETyxGs
   iZck3tks4mJA6uzDdc51yqjOVfiZpfNsAS99GYhsvv70oc+IIuWFrsIPj
   2xVNyEozzyCa5/J8YsSUszGwgeisMkXnupZaqQ75edP/w0gQ6t6OtiS/j
   K26prv5E444XST6pbGrpLsdqRE7SuDIEr2NmGLfcq7iVP7rbeAuc0IFtj
   8NevHrCquK4NPdUpjSm3buVh5WLpdXIvuKCnSl4vmrh0ugs2EdRvSCRn4
   Q==;
X-CSE-ConnectionGUID: mTJcOmOETNGZyOB8INxqdw==
X-CSE-MsgGUID: 5XzLTmsLQXue2sqkS3Hiag==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13182264"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13182264"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:37:04 -0700
X-CSE-ConnectionGUID: uPRwMUCnQN6Bf6DBGrci/g==
X-CSE-MsgGUID: 5MW1AE0uSx2tJNjbNvt4UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="39987009"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 08:37:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 08:37:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 08:37:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 08:37:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 08:37:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvHZ1zDnRx3WX5VjO988SzZ6GnjHsqQXg/nIbDVIwOiq/nCf6/X2vUiySF3fLG5my7mG0ky0G7IuhIFp65e8xufp5BUAYnMiGYHqlXkujkNyRC5ZS75n67xGorjSEH3VO368m5t8lHvfiZ7FghXHofaXxarflpSKRE1jeEUbLppXsOJnOlo4BibC8ztM6avqRa1lbbeghTii+5DzqWrYAzv05vZ6E7d+C/freEZSGG0Ak81jEgDdjdc5gnXUv+dzwNJGWlvQXjzunMsXu5sHxnfk2uslRwCaix3Sj5qmCOBMLKauppOpTNFiM2OJaCnGEMx9qjphtT9Qoephl05drA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lye3jaO6mUT0VeRAMNy4CcPdEdiYi7xANGrRUjuwDU=;
 b=D5v4bPwy8AI3UaB6pPUmm+bG7xFujp9hD7Q5i/IARZTDfVal0oXFZNn8+xsJk53oRFrtky4ThsU++Az112tpY0hK++ufknX0C2Wd7ukXEzgRSAbiHny/LRwUSrklUrdRjOWl7rIHY1dom8vOiWzyM8s9vzTq8YuboPj78T9shJd1JbnEge+GuIPUu3wKN+ztN9c3P5B6OARJnB9iNyUF50833/GMmiALU3a+rFDqucVhqpCmNVCQPzqSY4GXpykg8oB2Ey64GEm/UfhLBcucjZAUTLC1NRqDns1NF7CBFN3NJGLn4S4E9EiIJTJBPcRc94YGISeL60TPWvyvqu+JcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) by
 IA1PR11MB6467.namprd11.prod.outlook.com (2603:10b6:208:3a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 15:36:59 +0000
Received: from DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::f6db:9044:ad81:33d9]) by DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::f6db:9044:ad81:33d9%3]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 15:36:58 +0000
From: "Saarinen, Jani" <jani.saarinen@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, Nirmal Patel
	<nirmal.patel@linux.intel.com>, "Deak, Imre" <imre.deak@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
CC: =?utf-8?B?5p2OLCDmmJ/ovok=?= <korantli@tencent.com>, Jonathan Derrick
	<jonathan.derrick@linux.dev>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: RE: Lockdep annotation introduced warn in VMD driver
Thread-Topic: Lockdep annotation introduced warn in VMD driver
Thread-Index: AQHasPvGoTC05+utlkaEOOCd4uPGL7GtQa0AgACahYCAAF6cgIAAGWVg
Date: Wed, 29 May 2024 15:36:58 +0000
Message-ID: <DM8PR11MB5655FA22F73644AD0520EC16E0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <ZlXP5oTnSApiDbD1@ideak-desk.fi.intel.com>
 <20240528155228.00005850@linux.intel.com> <877cfdkpom.fsf@intel.com>
 <DM8PR11MB565579189DD400BACDF5493CE0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB565579189DD400BACDF5493CE0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_|IA1PR11MB6467:EE_
x-ms-office365-filtering-correlation-id: 6ebbfef5-9a1d-4b69-e7cf-08dc7ff52d9b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?d1FKTUxzREF0YWpoVzJ1ZFBjbTF5TythbllRSzNMb3AvcVdSWTBLZEZRazdj?=
 =?utf-8?B?ZWtScGswZFdnRy9UOUJJcEhCa3RocG9vUURMZXZuUHZCeURqcFhOcHB6UVYy?=
 =?utf-8?B?OXpiMTlNNWdCWDc2eFJXT0w1UFdyalowUTN2Ukg3c3BBd2dQaVRHamNBUlNX?=
 =?utf-8?B?Yk1aMFQ2TnlKUnhWcWZsdHgrZ1c0V01iN252RUREa25YaXVjeUxpQXQ4Yno5?=
 =?utf-8?B?QklOcTFHdi9zc1dqMWt6akZGblVLUXloV1pnanF2ZVN4cStHdklvOUVOUEtR?=
 =?utf-8?B?TVk5elZSa0JPdmtTaTErZHpveVBkdElFRUorN2RrWWUvUE12ZG9JNEZBWGhG?=
 =?utf-8?B?b3Z5cTRFMzQ5NEdwSGR5WHpLcHVkdFlBa1NGOVlpbHF3ekMzekkrcVE4Y0Rq?=
 =?utf-8?B?dGd4cWowRnpPWStRSXNnVGZ5Qk5iZFYzeTJNVTg4VnlIbTZIY0kxenF2b2da?=
 =?utf-8?B?L2JIdmExSlJkVkZjQVBiT01sWXRoR0sybmY2T3lMdCsxNDlSdHQxOW1YYWZG?=
 =?utf-8?B?WkQwNVRmVmxxOE9hSnM0bnM1RCtnSXBCc0F6S0xDdDg4Z0tCNlZnQnVsUUc4?=
 =?utf-8?B?bGUwbU5zL2YyWTVQVUpxOUJpc2JTa0xPUGlTN3RqbEFVU2lKaFVzWGozR1BF?=
 =?utf-8?B?a2QrWkFWeUZkVHorMlY4ZmVOd0F6Sk1IWGJDdDJObkU3ZWczcy9HQjhqNFpG?=
 =?utf-8?B?ZzQrVEw4RXp4aW1HY2ZhbjZxcEVXL1dQVk9KVVNLclNTbGtMY2VtZTY1cjJo?=
 =?utf-8?B?YXRxU3NGYzhKYmNoVVNUYmxIa01CcVlmamlNd29rU0pFSmQwN25La29CMnV4?=
 =?utf-8?B?VGRPNTRhQTg5bHNFWTFKczMzYXVaRk02VDloL1BZdGlnMTFHM1l5SmRteWlq?=
 =?utf-8?B?U3RETFNid3dWS0ZCdmROMURZQkxtYmpmTk1VckR5Ynd5aHJTYVNqNC9xR1Jk?=
 =?utf-8?B?c3c1SXVTNlNxZjJ6clpIOXNoSVNSYnR6K0F0cUNYY0F2REd6U210YTBXMVhB?=
 =?utf-8?B?NGY2K0dzQzVtVTJEOU0wc2JvbktxbGxYY2JFZS9PQ21qVy8xZk9veGZnMEFG?=
 =?utf-8?B?T2ZPcXM1NmhlRTNnNnVMYk5xS3dBNVVqdVpUZzcxVHk4cDlDc3drY3RXdDJI?=
 =?utf-8?B?enRLWkQxUDVPNzAvWGtJTGVVRHdTajM0akdlUmdYRDFSblNLM21HRmdGVVh0?=
 =?utf-8?B?amdFQ1JqRGV3cHdkazhSTFdqU29WeU5FYkpaL0xPcFRYT3RTRFpHVi84RTM4?=
 =?utf-8?B?Zzl3Q1Q2bzFwWm9HRHRFanNWbiswQW9FOVJJZTJ5Umc1YkVRdFBtTHFPU3lY?=
 =?utf-8?B?YkVQTlc3azNoaTRMZ0FGa0JzRlpMSjdPeE1UQzJNcHNIbEpOV0pBcHdJTUVW?=
 =?utf-8?B?c2NoL0diVE5NT3ZKb3V4Lzhud3I1aEdEbGEyV0pkVkZLNGVlYWhHQ0tadjdu?=
 =?utf-8?B?MU1tMUxhNTB2Z2N3MkhzUDNxNXlnRTY1VVFqTFpjWDFjM1JBbHVBejZLYmp6?=
 =?utf-8?B?VWhtTHg0TlFxWkFXblF3a0VVTzQ5WFFrTW91WkRxd1FKd2pmcFlkRkFZcjlu?=
 =?utf-8?B?YVZRY0JaKy80QTg0bjVjSXg3WDhVVVdqZDlKYml3TUpHNUhQOVcwbkI3WVFV?=
 =?utf-8?B?bUg4dzF6Z2U0UkNPMmc5bU5wM0ZpQVZPaDZXRjUwNnZaK2Zaa1lwVXB4RVE3?=
 =?utf-8?B?RjVyOFBpbzdFa1cxU1UrOEdXMGtjUkZkdlBxQ3ZEa3I4cHRWMGpnWXUvZi9M?=
 =?utf-8?Q?UbbQt+GkGNaxUXXwCY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDZyck54Q2I2aUY1S3BwY1o3Y3kzUElEakpuckE2OStrN1VaTXpxNEQ3QnpH?=
 =?utf-8?B?eW1rOUV1MkljZE53R2RQZjFMMkRxWDdMV1NSYklBZUhneGd4NTBud2M0WkRC?=
 =?utf-8?B?Ty81Tmx6MjVORHV0N1puZlE3M09sOVpTZHZUeHdEYjhzVCtITnV3dVJjTjN6?=
 =?utf-8?B?SGpHTEJ5cWpXU0NLWllFajVheGF1T1pZY1VmWHVEckJrWDBYSlkraFdtTWlW?=
 =?utf-8?B?ZWorTnY3TE5IZU40aTY2VnY3SGdUMmNBaFRxeUFyV2dHTGJuZDJYNE9leVd3?=
 =?utf-8?B?cWV2Z1NMQ0Q2RHZDdjFUWlh1aVdqTXZFVzhtSG1vZ0QwY1dicmtrc2RnQi9t?=
 =?utf-8?B?U1pTZFVIWXdUVVNYYU10cndmYmxPclZUazJjVU9SaUNmMjJLeDhyUXpOS2pB?=
 =?utf-8?B?dXJJL3JXNnF4cEFVbE5vSEJjK0M5T3VYVFU3UGhvSXRsVDVwZEZsZTcwWVV2?=
 =?utf-8?B?VWw3SEg2eEhER21kc2t3YndjRDRtUFFKVTBCdlI1NVFOWmF4c1AzQjZlRTB4?=
 =?utf-8?B?a1dHQW5ab1VKbEVINWlLRVdtSjdNb3JoNXlvKzkvLzhPNXRLcEZOdEJ4UDNP?=
 =?utf-8?B?WkpHQVk3UksraDF6dENncGNoc0toM1ZWWUtRYURyZTMxSFJBVkl6eTVNbWxv?=
 =?utf-8?B?cFljMHdheXFhZEp5Mjl4MFRsaTVoSU5nWXI4NTJjeW9MdElmVG5zSWwzQ1JU?=
 =?utf-8?B?VWt3Qm1MTjJxbkxjUzJTMS9WNGNCazZJVDhzc2NSdk1SMnJRVlRJZ09BUStz?=
 =?utf-8?B?QW1LUGVZZFZFUjBtVkl1REZSTG5hNUd1NllqT3JYVHk3aEVZcEtMbDJqK1pM?=
 =?utf-8?B?WnhjbCsxVldMS0Y0em1aYUowbmtaY0VwdVVCb0puL0tBeDBXQytBa2pIQUN2?=
 =?utf-8?B?RHNsK3M4Z2k2ZEp4T056SkZnWmVNNDRvOGdxZUJ0NVdGaDNCTlQ2WXBFanR3?=
 =?utf-8?B?Z2ZyM2NJTVJNMTFFQy90Y1FyRTNsbkVlYWMraDEwRG82SXF6VStJc2FiaXV3?=
 =?utf-8?B?b25jNm11N3NPM09MSk1JTkcvcjBvaHM3b3UvaVdXRU9UT0gyUHNQVGtxd2lC?=
 =?utf-8?B?YUc2QWl3M1BUbkpYWjBlZGdMVkZIYVRqYkZJemovTkhsTEsrcVUyUHpzbXdQ?=
 =?utf-8?B?NHBhWlBRbVE3TzVpY2dJYk5sZkFaMmxsT25zSFEyc1BaN0xpQ3Y0TjBrM0hW?=
 =?utf-8?B?RC9mdG9pdFYwNVdCMEhxNDE0NGJQdzM1N25CTnJmS3MwY2FUWXR4NkUyc0pL?=
 =?utf-8?B?UEwrNDRkL0tHdU1UT3ZmSk1rTG9VZUc4LzhRWDZWUkplaVc5VldGMmJhUlE1?=
 =?utf-8?B?cFZXVkFyTUtrM1hydm1rK3dmdHpFTmJ4QVJqcENVV3dxTUloNlFOK2UwU3pX?=
 =?utf-8?B?WEx3MDI1L2pJWHNDNTFVQ3M0aExNSlE5Wk80M3ZkeWVxVlI1d2F0VitzejRT?=
 =?utf-8?B?disyUVkzdXYyRkVxTXNwQTdDb0YvazRCaVhjQzZoTFFuRGtjZmh1ckpwMXdo?=
 =?utf-8?B?UGE3NDBlb3l2TG1RbHNzTkdtMFloRDJDQTZlcTdvMzlDdDVoRXFKdTBCMjVp?=
 =?utf-8?B?Q3RmSUNSRkNvZGViL2F1Zm5WY0NZWEhLTDU2aEp6QkJFTSt4NitxWXdDbVpl?=
 =?utf-8?B?aXhxZzRWWUJBeW9uanJUR3E4UWlZL1pkdENsK05sR1c2UVdCWk9ZVDBwbGpX?=
 =?utf-8?B?Q0JnZlF0b29ham9KQUhXN3FkMXVjWHVCZ24yVWtXRlRMOGsvTHA2aCsrTFVT?=
 =?utf-8?B?ay9XcStpM1lHelRaSWNuenp0bVRYOVhYVFN1aE41cU1yV0prUEtaU0I5OXU2?=
 =?utf-8?B?enBOd3JpV0V3MGs1WTBSOGFWYlVCNWgzTTJ0bnZUQVBBVWpnaTNaZVFzOFRW?=
 =?utf-8?B?eTRRaWdBSzlMWnVqQnBIY0FPNml0dW9LV2J5TzQ2MHhlcm1tT0VWZnFhUzFT?=
 =?utf-8?B?NjBjZGlIWGRHNzRGQm02TjVmb1R5eUswZTNqWHdGRDBwSzFic0FpYm5qUG44?=
 =?utf-8?B?clF5VDVmdVlDVk5TMzhLcWQwcUZnUkh2MFkxOXgwSDhGSnF4TkEvNUhZdHl1?=
 =?utf-8?B?RU04cGw4bG90V2FYQkswUlpEbTVWK2wvNXBNUU90dkoxVEFxRzBYUTZpN1M3?=
 =?utf-8?Q?ZTgg/agVNswwIwqleFWFBPDjG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebbfef5-9a1d-4b69-e7cf-08dc7ff52d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 15:36:58.8647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XglxstRXHRh+o6Et4A+Wwew5POHeQn8nPN0BY6bsbOUtolXc+05qI0nQ6wIwtxDALQRpu9fqaY8Utn+RCgEAYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6467
X-OriginatorOrg: intel.com

SGksIA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYWFyaW5lbiwgSmFu
aQ0KPiBTZW50OiBXZWRuZXNkYXksIDI5IE1heSAyMDI0IDE2LjQ5DQo+IFRvOiBKYW5pIE5pa3Vs
YSA8amFuaS5uaWt1bGFAbGludXguaW50ZWwuY29tPjsgTmlybWFsIFBhdGVsDQo+IDxuaXJtYWwu
cGF0ZWxAbGludXguaW50ZWwuY29tPjsgRGVhaywgSW1yZSA8aW1yZS5kZWFrQGludGVsLmNvbT47
IEppYW5nLA0KPiBEYXZlIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gQ2M6IOadjiwg5pif6L6J
IDxrb3JhbnRsaUB0ZW5jZW50LmNvbT47IEpvbmF0aGFuIERlcnJpY2sNCj4gPGpvbmF0aGFuLmRl
cnJpY2tAbGludXguZGV2PjsgQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IGxp
bnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IFN1YmplY3Q6IFJFOiBMb2NrZGVwIGFubm90YXRpb24gaW50cm9kdWNlZCB3YXJuIGlu
IFZNRCBkcml2ZXINCj4gDQo+IEhpLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+IEZyb206IEludGVsLWdmeCA8aW50ZWwtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnPiBPbiBCZWhhbGYgT2YgSmFuaQ0KPiA+IE5pa3VsYQ0KPiA+IFNlbnQ6IFdlZG5lc2Rh
eSwgMjkgTWF5IDIwMjQgMTEuMDYNCj4gPiBUbzogTmlybWFsIFBhdGVsIDxuaXJtYWwucGF0ZWxA
bGludXguaW50ZWwuY29tPjsgRGVhaywgSW1yZQ0KPiA+IDxpbXJlLmRlYWtAaW50ZWwuY29tPg0K
PiA+IENjOiBKaWFuZywgRGF2ZSA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+OyDmnY4sIOaYn+i+iSA8
a29yYW50bGlAdGVuY2VudC5jb20+Ow0KPiA+IEpvbmF0aGFuIERlcnJpY2sgPGpvbmF0aGFuLmRl
cnJpY2tAbGludXguZGV2PjsgQmpvcm4gSGVsZ2Fhcw0KPiA+IDxiaGVsZ2Fhc0Bnb29nbGUuY29t
PjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgaW50ZWwtDQo+ID4gZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBMb2NrZGVwIGFubm90YXRpb24gaW50cm9kdWNl
ZCB3YXJuIGluIFZNRCBkcml2ZXINCj4gPg0KPiA+IE9uIFR1ZSwgMjggTWF5IDIwMjQsIE5pcm1h
bCBQYXRlbCA8bmlybWFsLnBhdGVsQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiBPbiBU
dWUsIDI4IE1heSAyMDI0IDE1OjM2OjU0ICswMzAwDQo+ID4gPiBJbXJlIERlYWsgPGltcmUuZGVh
a0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+PiBIaSwNCj4gPiA+Pg0KPiA+ID4+IGNv
bW1pdCA3ZTg5ZWZjNmU5ZTQwMjgzOTY0M2NiMjk3YmFiMTQwNTVjNTQ3ZjA3DQo+ID4gPj4gQXV0
aG9yOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gPiA+PiBEYXRlOiAgIFRo
dSBNYXkgMiAwOTo1NzozMSAyMDI0IC0wNzAwDQo+ID4gPj4NCj4gPiA+PiAgICAgUENJOiBMb2Nr
IHVwc3RyZWFtIGJyaWRnZSBmb3IgcGNpX3Jlc2V0X2Z1bmN0aW9uKCkNCj4gPiA+Pg0KPiA+ID4+
IGludHJvZHVjZWQgdGhlIFdBUk4gYmVsb3cgaW4gdGhlIFZNRCBkcml2ZXIsIHNlZSBbMV0gZm9y
IHRoZSBmdWxsIGxvZy4NCj4gPiA+PiBOb3Qgc3VyZSBpZiB0aGUgYW5ub3RhdGlvbiBpcyBpbmNv
cnJlY3Qgb3IgdGhlIFZNRCBkcml2ZXIgaXMgbWlzc2luZw0KPiA+ID4+IHRoZSBsb2NrLCBDQydp
bmcgVk1EIGZvbGtzLg0KPiA+ID4+DQo+ID4gPj4gLS1JbXJlDQo+ID4gPiBDYW4geW91IHBsZWFz
ZSBwcm92aWRlIHJlcHJvIHN0ZXBzIGFuZCBzb21lIGJhY2tncm91bmQgb24gdGhlIHNldHVwPw0K
PiA+DQo+ID4gSGFyZHdhcmUgbmFtZTogSW50ZWwgQ29ycG9yYXRpb24gQWxkZXIgTGFrZSBDbGll
bnQgUGxhdGZvcm0vQWxkZXJMYWtlLVANCj4gPiBMUDUgUlZQLg0KPiA+DQo+ID4gS2NvbmZpZzog
aHR0cHM6Ly9pbnRlbC1nZngtY2kuMDEub3JnL3RyZWUvZHJtLXRpcC9DSV9EUk1fMTQ4NDIva2Nv
bmZpZy50eHQNCj4gPg0KPiA+IEp1c3QgYm9vdGluZyB3aXRoIHRoZSBhYm92ZSBjb21taXQgaXMg
ZW5vdWdoLg0KPiBJdCBzZWVtcyBmaXggZG8gbm90IGZpeCBhcyBzZWVuIG9uDQo+IGh0dHBzOi8v
cGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvMTM0MTgzLw0KPiA9PiBodHRwczovL2lu
dGVsLWdmeC1jaS4wMS5vcmcvdHJlZS9kcm0tdGlwL1BhdGNod29ya18xMzQxODN2MS9pbmRleC5o
dG1sPw0KPiBTZWUgdGhvc2UgcmVkIG5vdCB3aGVyZSBib3RoIGFyZSByZWQgc3RpbCBhbmQgYWxz
byBib3RoIGRtZXNnIChib290LmxvZykgbG9vaw0KPiBzdGlsbCBpZGVudGljYWwuDQo+IFNvIGVn
Og0KPiBiYXNlIGJ1aWxkOiAgIGh0dHBzOi8vaW50ZWwtZ2Z4LWNpLjAxLm9yZy90cmVlL2RybS10
aXAvQ0lfRFJNXzE0ODQ2L2JhdC1kZzItDQo+IDEzL2Jvb3QwLnR4dA0KPiBwdyBwYXRjaGVzOiBo
dHRwczovL2ludGVsLWdmeC1jaS4wMS5vcmcvdHJlZS9kcm0tDQo+IHRpcC9QYXRjaHdvcmtfMTM0
MTgzdjEvYmF0LWRnMi0xMy9ib290MC50eHQNCj4gDQo+IERhdmUsIHRob3VnaHRzPw0KQWxzbyBJ
bXJlIHRyaWVkIHdpdGggMiBQQ0kgcGF0Y2hlcyB0b2dldGhlciBodHRwczovL3BhdGNod29yay5m
cmVlZGVza3RvcC5vcmcvc2VyaWVzLzEzNDE5My8gDQpBbmQgc3RpbGwgbm90IGdvb2QgZm9yIHRo
b3NlIDQgc3lzdGVtcyAobXRscC05LCBiYXQtZGcyLTEzLzE0IGFuZCBiYXQtYWRscC0xMSkgOiBo
dHRwczovL2ludGVsLWdmeC1jaS4wMS5vcmcvdHJlZS9kcm0tdGlwL1RyeWJvdF8xMzQxOTN2MS9p
bmRleC5odG1sPyANCkRhdmUsIERhbiwgdGhvdWdodHM/IA0KDQpCciwNCkphbmkNCj4gDQo+IA0K
PiBCciwNCj4gSmFuaQ0KPiANCj4gPiBCUiwNCj4gPiBKYW5pLg0KPiA+DQo+ID4gPg0KPiA+ID4g
LW5pcm1hbA0KPiA+ID4+DQo+ID4gPj4gaHR0cHM6Ly9pbnRlbC1nZngtY2kuMDEub3JnL3RyZWUv
ZHJtLXRpcC9QYXRjaHdvcmtfMTM0MTEydjEvYmF0LWFkbHAtDQo+ID4gPj4gMTEvYm9vdDAudHh0
DQo+ID4gPj4NCj4gPiA+PiA8ND5bICAgMTcuMzU0MDcxXSBXQVJOSU5HOiBDUFU6IDAgUElEOiAx
IGF0IGRyaXZlcnMvcGNpL3BjaS5jOjQ4ODYNCj4gPiA+PiBwY2lfYnJpZGdlX3NlY29uZGFyeV9i
dXNfcmVzZXQrMHg1ZC8weDcwIDw0PlsgICAxNy4zNTQwOTVdIE1vZHVsZXMNCj4gPiA+PiBsaW5r
ZWQgaW46IDw0PlsgICAxNy4zNTQxMDRdIENQVTogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5v
dA0KPiA+ID4+IHRhaW50ZWQgNi4xMC4wLXJjMS1QYXRjaHdvcmtfMTM0MTEydjEtZ2FiYWVhZTIw
MmRmYisgIzEgPDQ+Ww0KPiA+ID4+IDE3LjM1NDEyOF0gSGFyZHdhcmUgbmFtZTogSW50ZWwgQ29y
cG9yYXRpb24gQWxkZXIgTGFrZSBDbGllbnQNCj4gPiA+PiBQbGF0Zm9ybS9BbGRlckxha2UtUCBM
UDUgUlZQLCBCSU9TDQo+IFJQTFBGV0kxLlIwMC40MDM1LkEwMC4yMzAxMjAwNzIzDQo+ID4gPj4g
MDEvMjAvMjAyMyA8ND5bICAgMTcuMzU0MTUzXSBSSVA6DQo+ID4gPj4gMDAxMDpwY2lfYnJpZGdl
X3NlY29uZGFyeV9idXNfcmVzZXQrMHg1ZC8weDcwIDw0PlsgICAxNy4zNTQxNjddDQo+ID4gQ29k
ZToNCj4gPiA+PiBjMyBjYyBjYyBjYyBjYyA0OCA4OSBlZiA0OCBjNyBjNiA3OCA1NSA0NCA4MiA1
ZCBlOSBkOCBjNiBmZiBmZiA0OCA4ZA0KPiA+ID4+IGJmIDQ4IDA4IDAwIDAwIGJlIGZmIGZmIGZm
IGZmIGU4IDk3IDEwIDVmIDAwIDg1IGMwIDc1IGI1IDwwZj4gMGIgZWINCj4gPiA+PiBiMSA2NiA2
NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCAwZiAxZiA0MCAwMCA5MCA5MCA5MCA8ND5bDQo+
ID4gPj4gMTcuMzU0MTk5XSBSU1A6IDAwMDA6ZmZmZmM5MDAwMDA5N2NhMCBFRkxBR1M6IDAwMDEw
MjQ2IDw0PlsNCj4gPiA+PiAxNy4zNTQyMTBdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZm
ZmY4ODgxMDU2MDQwMDAgUkNYOg0KPiA+ID4+IDAwMDAwMDAwMDAwMDAwMDAgPDQ+WyAgIDE3LjM1
NDIyNF0gUkRYOiAwMDAwMDAwMDgwMDAwMDAwIFJTSToNCj4gPiA+PiBmZmZmZmZmZjgyNDIxYzQw
IFJESTogZmZmZmZmZmY4MjQ0MWM0YyA8ND5bICAgMTcuMzU0MjM4XSBSQlA6DQo+ID4gPj4gZmZm
Zjg4ODEwNTYwMTAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAwMDAwMDAwMDAwMDAwMDAw
DQo+IDw0PlsNCj4gPiA+PiAxNy4zNTQyNTFdIFIxMDogMDAwMDAwMDAwMDAwMDAwMSBSMTE6IGZm
ZmY4ODgxMDA4YzgwNDAgUjEyOg0KPiA+ID4+IDAwMDAwMDAwMDAwMDAwMDAgPDQ+WyAgIDE3LjM1
NDI2NF0gUjEzOiAwMDAwMDAwMDAwMDAwMDIwIFIxNDoNCj4gPiA+PiAwMDAwMDAwMDAwMDAwMDdm
IFIxNTogZmZmZjg4ODEwNTYxNWMyOCA8ND5bICAgMTcuMzU0MjgzXSBGUzoNCj4gPiA+PiAwMDAw
MDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4ODgyYTZlMDAwMDAoMDAwMCkNCj4gPiA+PiBrbmxH
UzowMDAwMDAwMDAwMDAwMDAwIDw0PlsgICAxNy4zNTQzMTNdIENTOiAgMDAxMCBEUzogMDAwMCBF
UzogMDAwMA0KPiA+ID4+IENSMDogMDAwMDAwMDA4MDA1MDAzMyA8ND5bICAgMTcuMzU0MzM0XSBD
UjI6IGZmZmY4ODgyYWZiZmYwMDAgQ1IzOg0KPiA+ID4+IDAwMDAwMDAwMDY2M2EwMDAgQ1I0OiAw
MDAwMDAwMDAwZjUwZWYwIDw0PlsgICAxNy4zNTQzNDhdIFBLUlU6DQo+ID4gPj4gNTU1NTU1NTQg
PDQ+WyAgIDE3LjM1NDM1NV0gQ2FsbCBUcmFjZTogPDQ+WyAgIDE3LjM1NDM2MV0gIDxUQVNLPiA8
ND5bDQo+ID4gPj4gICAxNy4zNTQzNjddICA/IF9fd2FybisweDhjLzB4MTkwIDw0PlsgICAxNy4z
NTQzODBdICA/DQo+ID4gPj4gcGNpX2JyaWRnZV9zZWNvbmRhcnlfYnVzX3Jlc2V0KzB4NWQvMHg3
MCA8ND5bICAgMTcuMzU0MzkyXSAgPw0KPiA+ID4+IHJlcG9ydF9idWcrMHgxZjgvMHgyMDAgPDQ+
WyAgIDE3LjM1NDQwNV0gID8gaGFuZGxlX2J1ZysweDNjLzB4NzANCj4gPDQ+Ww0KPiA+ID4+ICAg
MTcuMzU0NDE1XSAgPyBleGNfaW52YWxpZF9vcCsweDE4LzB4NzAgPDQ+WyAgIDE3LjM1NDQyNF0g
ID8NCj4gPiA+PiBhc21fZXhjX2ludmFsaWRfb3ArMHgxYS8weDIwIDw0PlsgICAxNy4zNTQ0Mzhd
ICA/DQo+ID4gPj4gcGNpX2JyaWRnZV9zZWNvbmRhcnlfYnVzX3Jlc2V0KzB4NWQvMHg3MCA8ND5b
ICAgMTcuMzU0NDUxXQ0KPiA+ID4+IHBjaV9yZXNldF9idXMrMHgxZDgvMHgyNzAgPDQ+WyAgIDE3
LjM1NDQ2MV0NCj4gdm1kX3Byb2JlKzB4Nzc4LzB4YTEwDQo+ID4gPj4gPDQ+WyAgIDE3LjM1NDQ3
NF0gIHBjaV9kZXZpY2VfcHJvYmUrMHg5NS8weDEyMCA8ND5bICAgMTcuMzU0NDg0XQ0KPiA+ID4+
IHJlYWxseV9wcm9iZSsweGQ5LzB4MzcwIDw0PlsgICAxNy4zNTQ0OTZdICA/DQo+ID4gPj4gX19w
ZnhfX19kcml2ZXJfYXR0YWNoKzB4MTAvMHgxMCA8ND5bICAgMTcuMzU0NTA1XQ0KPiA+ID4+IF9f
ZHJpdmVyX3Byb2JlX2RldmljZSsweDczLzB4MTUwIDw0PlsgICAxNy4zNTQ1MTZdDQo+ID4gPj4g
ZHJpdmVyX3Byb2JlX2RldmljZSsweDE5LzB4YTAgPDQ+WyAgIDE3LjM1NDUyNV0NCj4gPiA+PiBf
X2RyaXZlcl9hdHRhY2grMHhiNi8weDE4MCA8ND5bICAgMTcuMzU0NTM0XSAgPw0KPiA+ID4+IF9f
cGZ4X19fZHJpdmVyX2F0dGFjaCsweDEwLzB4MTAgPDQ+WyAgIDE3LjM1NDU0NF0NCj4gPiA+PiBi
dXNfZm9yX2VhY2hfZGV2KzB4NzcvMHhkMCA8ND5bICAgMTcuMzU0NTU1XQ0KPiA+ID4+IGJ1c19h
ZGRfZHJpdmVyKzB4MTEwLzB4MjQwIDw0PlsgICAxNy4zNTQ1NjZdDQo+ID4gPj4gZHJpdmVyX3Jl
Z2lzdGVyKzB4NWIvMHgxMTAgPDQ+WyAgIDE3LjM1NDU3NV0gID8NCj4gPiA+PiBfX3BmeF92bWRf
ZHJ2X2luaXQrMHgxMC8weDEwIDw0PlsgICAxNy4zNTQ1ODddDQo+ID4gPj4gZG9fb25lX2luaXRj
YWxsKzB4NWMvMHgyYjAgPDQ+WyAgIDE3LjM1NDYwMF0NCj4gPiA+PiBrZXJuZWxfaW5pdF9mcmVl
YWJsZSsweDE4ZS8weDM0MCA8ND5bICAgMTcuMzU0NjEyXSAgPw0KPiA+ID4+IF9fcGZ4X2tlcm5l
bF9pbml0KzB4MTAvMHgxMCA8ND5bICAgMTcuMzU0NjIzXSAga2VybmVsX2luaXQrMHgxNS8weDEz
MA0KPiA+ID4+IDw0PlsgICAxNy4zNTQ2MzFdICByZXRfZnJvbV9mb3JrKzB4MmMvMHg1MCA8ND5b
ICAgMTcuMzU0NjQxXSAgPw0KPiA+ID4+IF9fcGZ4X2tlcm5lbF9pbml0KzB4MTAvMHgxMCA8ND5b
ICAgMTcuMzU0NjUwXQ0KPiA+ID4+IHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMCA8ND5bICAg
MTcuMzU0NjYzXSAgPC9UQVNLPiA8ND5bDQo+ID4gPj4gMTcuMzU0NjY5XSBpcnEgZXZlbnQgc3Rh
bXA6IDI4NTc3Njg1IDw0PlsgICAxNy4zNTQ2NzddIGhhcmRpcnFzIGxhc3QNCj4gPiA+PiBlbmFi
bGVkIGF0ICgyODU3NzY5Myk6IFs8ZmZmZmZmZmY4MTE3YzA2MD5dDQo+ID4gPj4gY29uc29sZV91
bmxvY2srMHgxMTAvMHgxMjAgPDQ+WyAgIDE3LjM1NDY5N10gaGFyZGlycXMgbGFzdCBkaXNhYmxl
ZA0KPiA+ID4+IGF0ICgyODU3NzcwMCk6IFs8ZmZmZmZmZmY4MTE3YzA0NT5dIGNvbnNvbGVfdW5s
b2NrKzB4ZjUvMHgxMjAgPDQ+Ww0KPiA+ID4+IDE3LjM1NDcxM10gc29mdGlycXMgbGFzdCAgZW5h
YmxlZCBhdCAoMjg1NzcxNzYpOiBbPGZmZmZmZmZmODEwZGYyOWM+XQ0KPiA+ID4+IGhhbmRsZV9z
b2Z0aXJxcysweDJlYy8weDNmMCA8ND5bICAgMTcuMzU0NzMxXSBzb2Z0aXJxcyBsYXN0IGRpc2Fi
bGVkDQo+ID4gPj4gYXQgKDI4NTc3MTY3KTogWzxmZmZmZmZmZjgxMGRmYTE3Pl0gaXJxX2V4aXRf
cmN1KzB4ODcvMHhjMCA8ND5bDQo+ID4gPj4gMTcuMzU0NzQ3XSAtLS1bIGVuZCB0cmFjZSAwMDAw
MDAwMDAwMDAwMDAwIF0tLS0NCj4gPiA+Pg0KPiA+ID4+IDw0PlsgICAxNy40ODcyNzRdID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiA+PiA8ND5bICAgMTcuNDg3Mjc3
XSBXQVJOSU5HOiBiYWQgdW5sb2NrIGJhbGFuY2UgZGV0ZWN0ZWQhDQo+ID4gPj4gPDQ+WyAgIDE3
LjQ4NzI3OV0gNi4xMC4wLXJjMS1QYXRjaHdvcmtfMTM0MTEydjEtZ2FiYWVhZTIwMmRmYisgIzEN
Cj4gPiA+PiBUYWludGVkOiBHICAgICAgICBXIDw0PlsgICAxNy40ODcyODJdDQo+ID4gPj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSA8ND5bICAgMTcuNDg3Mjg0XSBzd2Fw
cGVyLzAvMQ0KPiA+ID4+IGlzIHRyeWluZyB0byByZWxlYXNlIGxvY2sgKDEwMDAwOmUxOjAwLjAp
IGF0OiA8ND5bICAgMTcuNDg3Mjg3XQ0KPiA+ID4+IFs8ZmZmZmZmZmY4MTc2YjM3Nz5dIHBjaV9j
ZmdfYWNjZXNzX3VubG9jaysweDU3LzB4NjAgPDQ+Ww0KPiA+ID4+IDE3LjQ4NzI5Ml0gYnV0IHRo
ZXJlIGFyZSBubyBtb3JlIGxvY2tzIHRvIHJlbGVhc2UhIDw0PlsgICAxNy40ODcyOTRdDQo+ID4g
Pj4gICAgICAgICAgICAgICAgICAgb3RoZXIgaW5mbyB0aGF0IG1pZ2h0IGhlbHAgdXMgZGVidWcg
dGhpczoNCj4gPiA+PiA8ND5bICAgMTcuNDg3Mjk3XSAyIGxvY2tzIGhlbGQgYnkgc3dhcHBlci8w
LzE6DQo+ID4gPj4gPDQ+WyAgIDE3LjQ4NzI5OV0gICMwOiBmZmZmODg4MTAyYzFjMWIwICgmZGV2
LT5tdXRleCl7Li4uLn0tezM6M30sDQo+ID4gPj4gYXQ6IF9fZHJpdmVyX2F0dGFjaCsweGFiLzB4
MTgwIDw0PlsgICAxNy40ODczMDZdICAjMToNCj4gPiA+PiBmZmZmODg4MTA1NjA0MWIwICgmZGV2
LT5tdXRleCl7Li4uLn0tezM6M30sIGF0Og0KPiA+ID4+IHBjaV9kZXZfdHJ5bG9jaysweDE5LzB4
NTAgPDQ+WyAgIDE3LjQ4NzMxMl0gc3RhY2sgYmFja3RyYWNlOg0KPiA+ID4+IDw0PlsgICAxNy40
ODczMTRdIENQVTogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIFRhaW50ZWQ6IEcgICAgICAgIFcN
Cj4gPiA+PiAgICAgICAgNi4xMC4wLXJjMS1QYXRjaHdvcmtfMTM0MTEydjEtZ2FiYWVhZTIwMmRm
YisgIzEgPDQ+Ww0KPiA+ID4+IDE3LjQ4NzMxOF0gSGFyZHdhcmUgbmFtZTogSW50ZWwgQ29ycG9y
YXRpb24gQWxkZXIgTGFrZSBDbGllbnQNCj4gPiA+PiBQbGF0Zm9ybS9BbGRlckxha2UtUCBMUDUg
UlZQLCBCSU9TDQo+IFJQTFBGV0kxLlIwMC40MDM1LkEwMC4yMzAxMjAwNzIzDQo+ID4gPj4gMDEv
MjAvMjAyMyA8ND5bICAgMTcuNDg3MzIyXSBDYWxsIFRyYWNlOiA8ND5bICAgMTcuNDg3MzI0XSAg
PFRBU0s+DQo+ID4gPj4gPDQ+WyAgIDE3LjQ4NzMyNV0gIGR1bXBfc3RhY2tfbHZsKzB4ODIvMHhk
MCA8ND5bICAgMTcuNDg3MzI5XQ0KPiA+ID4+IGxvY2tfcmVsZWFzZSsweDIwYi8weDJkMCA8ND5b
ICAgMTcuNDg3MzM0XQ0KPiBwY2lfYnVzX3VubG9jaysweDI1LzB4NDANCj4gPiA+PiA8ND5bICAg
MTcuNDg3MzM3XSAgcGNpX3Jlc2V0X2J1cysweDFlYi8weDI3MA0KPiA+ID4+IDw0PlsgICAxNy40
ODczNDBdICB2bWRfcHJvYmUrMHg3NzgvMHhhMTANCj4gPiA+PiA8ND5bICAgMTcuNDg3MzQ0XSAg
cGNpX2RldmljZV9wcm9iZSsweDk1LzB4MTIwDQo+ID4gPj4gPDQ+WyAgIDE3LjQ4NzM0Nl0gIHJl
YWxseV9wcm9iZSsweGQ5LzB4MzcwDQo+ID4gPj4gPDQ+WyAgIDE3LjQ4NzM0OV0gID8gX19wZnhf
X19kcml2ZXJfYXR0YWNoKzB4MTAvMHgxMA0KPiA+ID4+IDw0PlsgICAxNy40ODczNTJdICBfX2Ry
aXZlcl9wcm9iZV9kZXZpY2UrMHg3My8weDE1MA0KPiA+ID4+IDw0PlsgICAxNy40ODczNTRdICBk
cml2ZXJfcHJvYmVfZGV2aWNlKzB4MTkvMHhhMA0KPiA+ID4+IDw0PlsgICAxNy40ODczNTddICBf
X2RyaXZlcl9hdHRhY2grMHhiNi8weDE4MA0KPiA+ID4+IDw0PlsgICAxNy40ODczNTldICA/IF9f
cGZ4X19fZHJpdmVyX2F0dGFjaCsweDEwLzB4MTANCj4gPiA+PiA8ND5bICAgMTcuNDg3MzYyXSAg
YnVzX2Zvcl9lYWNoX2RldisweDc3LzB4ZDANCj4gPiA+PiA8ND5bICAgMTcuNDg3MzY1XSAgYnVz
X2FkZF9kcml2ZXIrMHgxMTAvMHgyNDANCj4gPiA+PiA8ND5bICAgMTcuNDg3MzY5XSAgZHJpdmVy
X3JlZ2lzdGVyKzB4NWIvMHgxMTANCj4gPiA+PiA8ND5bICAgMTcuNDg3MzcxXSAgPyBfX3BmeF92
bWRfZHJ2X2luaXQrMHgxMC8weDEwDQo+ID4gPj4gPDQ+WyAgIDE3LjQ4NzM3NF0gIGRvX29uZV9p
bml0Y2FsbCsweDVjLzB4MmIwDQo+ID4gPj4gPDQ+WyAgIDE3LjQ4NzM3OF0gIGtlcm5lbF9pbml0
X2ZyZWVhYmxlKzB4MThlLzB4MzQwDQo+ID4gPj4gPDQ+WyAgIDE3LjQ4NzM4MV0gID8gX19wZnhf
a2VybmVsX2luaXQrMHgxMC8weDEwDQo+ID4gPj4gPDQ+WyAgIDE3LjQ4NzM4NF0gIGtlcm5lbF9p
bml0KzB4MTUvMHgxMzANCj4gPiA+PiA8ND5bICAgMTcuNDg3Mzg3XSAgcmV0X2Zyb21fZm9yaysw
eDJjLzB4NTANCj4gPiA+PiA8ND5bICAgMTcuNDg3MzkwXSAgPyBfX3BmeF9rZXJuZWxfaW5pdCsw
eDEwLzB4MTANCj4gPiA+PiA8ND5bICAgMTcuNDg3MzkyXSAgcmV0X2Zyb21fZm9ya19hc20rMHgx
YS8weDMwDQo+ID4gPj4gPDQ+WyAgIDE3LjQ4NzM5Nl0gIDwvVEFTSz4NCj4gPiA+Pg0KPiA+ID4N
Cj4gPg0KPiA+IC0tDQo+ID4gSmFuaSBOaWt1bGEsIEludGVsDQo=

