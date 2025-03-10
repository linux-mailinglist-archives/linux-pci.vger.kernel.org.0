Return-Path: <linux-pci+bounces-23389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A8AA5A6FA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 23:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9499A163667
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B31E5B6E;
	Mon, 10 Mar 2025 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOBPvaJJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B91E5B8B
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645181; cv=fail; b=G2nZw4vIqqp1CBUtEd0Y2kdGQKQhtjKqgde8IPumLko6wtXy7/uj9VkNmSXxPwH3w372++9ImFRuFOFho+MXulii/K4UpJJ/U1YZ5sJiSSZ66xOoCTkGXbUa51AWRXmzL3zJUtXEW4erC3uxM2z16rAOa76dmfcT4/MG4asvnk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645181; c=relaxed/simple;
	bh=nLdAw20U5eT2JVBse4u2/qM56DAnB/W10oThCCOLLh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmawGfoQ85lU6bn/zKYJ70VM6O0yhOBR4jRmy51+7MAz7RpRVMfTk66RqvuWV4YItV0gAx2qN03L/xMbOkhyWG/cmYzLm8sc9VBUhDCLo5ftBDFShD7UuMyH46LHnU3Rh2pPc0P5po4P109vmXw5O4nENH6WdPjAqPrrsqWik7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOBPvaJJ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741645180; x=1773181180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nLdAw20U5eT2JVBse4u2/qM56DAnB/W10oThCCOLLh0=;
  b=SOBPvaJJD+Et6dZEL0FZttbndXNLjE6e5+f9KAi2hP6+9K7Me9CPmXqj
   IlcPUfyr73ztqa5Vz0QhbHCcC8k/vso7kOwYjEkYPO82eGa3vckL9uajh
   Wqw8GUnW0gjsM9gzRT6+eP0VTQ0Lu/e22JQCowffwGektpB75FnirhDaB
   3gd+n53+86UkiaP1fm/NmZlg+hI72V/peQLRrkWRr4BmIreXKke2BSltL
   EYpstCPD9W8hBj2WBRjR9Ak4nv0Onhboa+fK5dLZysQXs9luS7qxL7Veb
   qQMQYSHlkFRWue6k6qShcu0l4aYWSadM72vr6lkGQaQ780CT6nls0M6zd
   w==;
X-CSE-ConnectionGUID: jtZFzaqTTfOxOtvoMYTQXA==
X-CSE-MsgGUID: CAcTQ6DpSu6y/+S/vpnSjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53303041"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="53303041"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 15:19:39 -0700
X-CSE-ConnectionGUID: Z4her7z2RkmJC1jYc7Of+A==
X-CSE-MsgGUID: E/WHKrD5QuOMJQ+d4Oj2cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="125342778"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 15:19:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 15:19:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 15:19:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 15:19:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjI2ZbIwYCB0wc2oCElhlooyGcU2iTyLTa8Hr6pfgQxozjASjCDTC6yQulWXFtVbgH9pZmYYJL8ftTh0781X127ObAjCqrMi8vc7p9+zfsFYzeTpwiUC/ryoeEXek2xF8Gj1AzVVlOdcFzJsToqu8/a+b4Xvrl3cCUhwJ9ZfKAxARQumo4gu3csSq6EPd58rynjVaBGgcrIS2hOW8nL8dK655yhJxrC9C0u81s8HlFv+QCYSIIgTaSmaNvLD7+tE1L5KQGEjU5PiVSYY4b+lpicxGSDoyYXy4RCK083jQfe9nOtJOhyvZECCozHTnKnUyurgpng1F+4m79NR7sfuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLdAw20U5eT2JVBse4u2/qM56DAnB/W10oThCCOLLh0=;
 b=QGGOmTpUEAWniNT5ex82UiAtkIApY/T3JJfkLBPO3T9CFXD5+oSo8Htq84Ctho1NbV3ax/ATaixbi5gWiE1DCtHlLbaFZlwTZcotR8oMiNVhW0CvLm1YfqMkSMpEjOsnoWvMs7JH/+B88+bI0Li7AuGbOrrocVRg0Pa9bV8VCGe2BdbF79ZkPQ75DxYh/trZG0LD7DdTftb0B2cmpLQIayQZMVc3d5YKCBYBGu19jg1XUFoEMawqdSroBL8fm+N4JViheZJ0SYhVXxhyDyFqSdpGpyGDctEOh+2ZZqbax6WLE/VP+dNx5RjhobwIcn9MNdjTj2whBosIUpFyHCrijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:19:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 22:19:21 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: "sameo@rivosinc.com" <sameo@rivosinc.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "steven.price@arm.com" <steven.price@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "sami.mujawar@arm.com"
	<sami.mujawar@arm.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "aik@amd.com" <aik@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>
Subject: Re: [PATCH v2 01/11] configfs-tsm: Namespace TSM report symbols
Thread-Topic: [PATCH v2 01/11] configfs-tsm: Namespace TSM report symbols
Thread-Index: AQHbjNcUgvJWHYcEL0mDR0scb2lVq7Ns+zoA
Date: Mon, 10 Mar 2025 22:19:21 +0000
Message-ID: <f448dffe4317fbd08222a5d702238d83ec1e7910.camel@intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
	 <174107246021.1288555.7203769833791489618.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174107246021.1288555.7203769833791489618.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY8PR11MB7947:EE_
x-ms-office365-filtering-correlation-id: da88f2b5-a838-4141-61f9-08dd60219b7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWtXbDBNUzcvMWxrMXhIMjduS2pYTmlZakI3Mno3a0tNUWdhL1dZQU1kQWVB?=
 =?utf-8?B?VmhCL1BlL2YvSkZ2bW42NmV1dVVqaVd6ak5MMmtlRnRkZGV6WG56eVNTWllB?=
 =?utf-8?B?SkN3clNiOVNuYUcxd2pFdTdiMjQxZ3NHSURpQ1NWckZMWDgyQ01xQ2JqZXl1?=
 =?utf-8?B?OEdGU3BqdUluU2d1TWwydVQwaFpEK1JSa1hmdDBkTGlwTEhRcysrLzVrUWtO?=
 =?utf-8?B?Y2l3TmpDRVo4Vzh5OTB6SG8zdkRtbW9pdVZZNUtwL0pOQ2NsVHoraGhmNjYz?=
 =?utf-8?B?UmxkS0MwYTVsUlo2YkFPamt3eGp0MktyOWg5b0M1ZVdDVGJQM0txTi9ZL0NX?=
 =?utf-8?B?SjViYWJaZmtaQzZXSVMxc0hWLzBlSWNZOTN5QkxteGhJNWR4cFlYLysxcGVh?=
 =?utf-8?B?WFVVL3l5aHN1Z2ZiKzZTWTZXaGVnbHpuMUdtYjAzakRhRnI1WERLdzlhMnM2?=
 =?utf-8?B?L0VuSExjVS92bDJOa0ZPYmpZR0IxcGlSZlF5akNzYlQweTBNZUpDT01hNm5T?=
 =?utf-8?B?akxPQVJkNzZlcVFTTVNsNEJXMXYwQW5EK0hFSmVCbklrWTlBVlFUb09TTDJV?=
 =?utf-8?B?V1N6Qm9hVlJQak9BZlZiZnpPT0FXZjlWcEkraHVIemRMUFZkWHk3a0hDNS9z?=
 =?utf-8?B?cG9pd0RNNTZuaXJvVC93UTZIU3V1bUlvWTMxMDM5aGtVL1N5dCszYUs1dWpF?=
 =?utf-8?B?Nk5za0s4ek9LZnppelh6c0lNWkI2U3NyV3dZWEJPRVV3WXhDd3F5Y2QyRThX?=
 =?utf-8?B?Sy82aElhcEpPVkVrN2EyY2h2UndOeEYwb1N4TXNtT1VaZmJOYVdseVRkTVVh?=
 =?utf-8?B?RG05d0VlUHVEbEVUdHUybzJZZTNjdFh2dEtSQmFBdkljMXNGWk5SS0E3aC8x?=
 =?utf-8?B?WThrbUN6d1JDWXNyYUFlR1ZnSXdtWmtZd1p1MU1PSDVQWnBsOUp4MmdTZW9Y?=
 =?utf-8?B?K3lIZzBCakhsS3BCZTM1SUZmZ2dCVVppNFBQWFRhbGZCY20xR2hqMGlaYTRC?=
 =?utf-8?B?MlVQK2NLTHowMHVGS1lHTldPYlkyU1NHU1VzV2JNSTcxSHdHTmVkWWNiOWZH?=
 =?utf-8?B?aStqdkkrdHlaOTcrY1hYNmpBc0NraWxiTEdEYXhpZFQ0dnZ4MGFYUkUraWkx?=
 =?utf-8?B?NDIvaEl2QzBaK3NMMWVZWHpKOWJCWml2VlpyaWptbUpFTWJyUEMrdGZ5c0hj?=
 =?utf-8?B?TGptbnBsUXI5U0hIVkJmbnFMNktaNnVNenMrdkxiR0JSSVQ5YUJQc3BDZlg4?=
 =?utf-8?B?MmNsaHQ5aWJLd2lVck9DMEUvdHVRNHJ2OXc3TGt5aWp4ZXpKUytuZlE2Wjc1?=
 =?utf-8?B?K2RKSmdmVlB3SEYybW50REUvdDlUb29vMnUvYTRydDdQb1poYmplcDQrRDM2?=
 =?utf-8?B?d2lHVDRqNHZQSTVyR0NQSmg0YXJ4amtFOVdsS1dPUGJYdUV6eHZKY2Y3b0Nk?=
 =?utf-8?B?M3FVMk53ai9zMU1kWGNPbmdOV2lNV1pLZjJUYmdWNkdOK2JHVGhOYnZRTmdR?=
 =?utf-8?B?ejhSb2ZpT2g5RGh6WUkwUnEyUHdrWmlqV1c4Z3hyby90V1JCcnMycmhSNU1U?=
 =?utf-8?B?TnI4Q3A1U2c5TXBZM2VkRFJmdmZRU1pyWGJ2MWRKS0o2K3QyeHVKZUhMZmlD?=
 =?utf-8?B?eFhLektZWHpYejU3aW9PUXZzSUIxeXhTZ3VYTGRBaVQ3NnovbitWUm03cmUz?=
 =?utf-8?B?eGVxZ1AyK0piWWJVcEtYUEJNaVZyNnV0UGdUT2dhTm15NSt1d2YvYjVzdDM3?=
 =?utf-8?B?MlBGODNDcHBJSXpmdlBUU3BUNDNnODhOcytqTk5vZFlmNFFDZ2RyMC80TWRu?=
 =?utf-8?B?S3RjVXJiOU9BeVRMdnpJckJ2RFl3Y2NHb0J6OGFMNU45UldCZ3Mrdi84ZStp?=
 =?utf-8?B?OEhZbXFZSzR2WHI4eEFJNkkwUy91STEzbEdWWUhvLzJheHA3VU9hT2JmaDF2?=
 =?utf-8?Q?2lvt5g2NMBAEDuw/wgATo01nOoZckfkp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RllOY2R5V0pjb1lSM2lFaVNuYmw1eU1EYWRzSWw1OEFZOHlGalVsWWF3bDVx?=
 =?utf-8?B?ai9aQ0gxbUpMRTFsdE9jR3NJZkFtVXFvQjBNQ2lHdDRlcE82b1RFU0pkM0Qy?=
 =?utf-8?B?NW5FVC9CNS9JaHkzMjE2YlI2TS91Sm5EcE9KdFRVWFhHeG96N3VjTXlXck1N?=
 =?utf-8?B?aFhNS09yd25ic0czTFhvbWk5TDdPNDNhYm5kUDBpdDgyTHorc1VhbWJsSHhq?=
 =?utf-8?B?ZkVGWERaN0xpbUxjTGlVbnJVbk5WeTBvWU5FN1lKN0dxTHB6ZHVOejFwSENo?=
 =?utf-8?B?bG1Rd1NjakJTN1FIWFVLTDZGMHgyd0pOeVhWTWVOSmdMenBNb2pkaHErQ2pw?=
 =?utf-8?B?cVZCWTNONWppMXVwRGpCVHFna2ZaVkkrMnlCTGVoQk9yMTNlWHl0Vi8va3NR?=
 =?utf-8?B?L2hmMHpuT3phekltZkh6UWhFNUkzMlkrUHhZSU0wSmFOa0RaV05KeDVDdnBh?=
 =?utf-8?B?dDY3V3I2NEFONkdkV09FUWs5bElvbXc0Nk52R3BhL0xKQ3k0S2hYRXB2TUg2?=
 =?utf-8?B?eEx1TWtkc0ZvM0VmWXd1K1FHTS9JcG8veUN1eG5XYmF3Z3pFU0R4ZGtTclhK?=
 =?utf-8?B?di9mS0tHdlA0YytaM2xhTEdaUkNBaEU1VmttYXl6UnREVUFDQXYzMTRvQ3JU?=
 =?utf-8?B?T25WbFZQcTBXUjNGUzZwMWdqdDNtMFd6Z1FneDByd2I1cVF5VzVZZW1uWi9N?=
 =?utf-8?B?M1B4ZHhkdlh3cmdQS0pxNXV4NjhuSmhlaVZWT3FtbXZKMXh2eHJqb3VCNGJz?=
 =?utf-8?B?MnhGYkhaK3dKc3o4WHZFU0VxM1N1SjU0TytQTDlZN3RaMndEcEE0UmVEZTBM?=
 =?utf-8?B?bm1QSGlIdTBxc2t2eElNbVNMeWJnNjFJUlZiZkpXL1draFhQK1FzSFM4VXBT?=
 =?utf-8?B?c3JDSWh3cXNLNDI5SkFzT3dFTit5R0I3VnlRSWpLU0JLU3ZDeTFabWtzTkpO?=
 =?utf-8?B?cGRwcWhWOEkwbzFOS0ZoUHVMUmlqWVo2QkpobkRpZEltOStyLzk2bTMxcUJI?=
 =?utf-8?B?dFRHT1dSaUdHa1VCbWpaVlZ1Z2JzNlBIeG15YVEvcTlkakFxSVNJeVVaUEJ2?=
 =?utf-8?B?Y0lGWDYrb3hzY004MEszZWtCRjVFSit5WjN0dWVYMm9TY2ZheHg3OXJlbHNX?=
 =?utf-8?B?SCtWQWxUNVZiOUIySE5zWnd2U3NSemE2VVNKZ1FCR2I4TzZRcXpHa2JwWTA5?=
 =?utf-8?B?c1U2ZFRDZm94MFh3YjIwemh5MGJMRkwwTWxMQjNFV0I2RS9FS3R4T3NjQXZS?=
 =?utf-8?B?RU9vMWVJSEovWmFod3NhTjRDQ2k5TVcreTdqRDFvYWxJYlEzMkNNWmlFaEFn?=
 =?utf-8?B?Sk1RTTFSZ3RhS3hiWFFCS2g5ZjBhdVVkTG5aUjkrSzM3eWFIekErZ2J0SVVt?=
 =?utf-8?B?V0FFNXlnMW9XTjFTaUJscnR6NFc1b3poQkRSVDYrcTc0MDFQcGJBbGo4UUYw?=
 =?utf-8?B?aWl3Qm1lZi84eFJDdjE4U3VJNzZSZG9ZUjliUEJROFRQNkRZaS9vWjdMUStD?=
 =?utf-8?B?anBlM0J0UTV2bndRYm5vUGZSWFI4SDlralAzaytVU3YwcDZEUVVmODUrdlVw?=
 =?utf-8?B?Y3JBODVuNGpnejhNUWNwRmhVMVJMMWNNc01COWFOaVVvZUJKNnh2UlFJRTZy?=
 =?utf-8?B?ZTVKdlYxcnpvM0dleXNneTVVRUF4ZVovWWRCTlpzUThOaW4xZDRuZCtDaHdR?=
 =?utf-8?B?MDFEbkRFbms4T3NwNUJIdGYyZmk0N2dtbHZsWHkxU2xCUVJ2eEZGcWlucE81?=
 =?utf-8?B?UjUxdWI4aEQ4SnVSMVJJUCtXQ0pGd29ZdU94dkw5dDlIeWJxNmVGSDJSQmlL?=
 =?utf-8?B?V0g2UXBiQ29wK1hYVzN5ZkcwVnBleWY2VFpyd2tKOStjU3JvSkgydkVEOUJD?=
 =?utf-8?B?dWMzS2hqTlNrd2xjSmhJWitiVnFXYktNM2hJenNUc0NyRFZCSlRmMHQ4eFhQ?=
 =?utf-8?B?cFh3dXdjdGZGN20xTVBnQittelpXcXViUU5kaHJuZWU3eVM3a1cvUnp6RWY4?=
 =?utf-8?B?cDd5NFdCOTlIRWtVWmVTcHcwcExVUmZVSGp5dTRCOGZ6LzRiMkoyZEJHdHRx?=
 =?utf-8?B?cE1zTVlxYS9nL1U5UFdEeFc0VWl2NHZ2eERMYU9Wd1lzSVo2M2dHKzU3SHJE?=
 =?utf-8?Q?txFSQd5eNKeihqr16tpJPA0OP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DDFA45F51F7494B94CC69FE4CF4AC2A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da88f2b5-a838-4141-61f9-08dd60219b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 22:19:21.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjP1zeTyntfXRClDMIh9hp06qiadbC9sPDF/uSlokm8SA9CNFeGwLkUefQtU+4JPxF04orC0WyIYWjWTkVgfrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAzLTAzIGF0IDIzOjE0IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEluIHByZXBhcmF0aW9uIGZvciBuZXcgKyBjb21tb24gVFNNIChURUUgU2VjdXJpdHkgTWFuYWdl
cikNCj4gaW5mcmFzdHJ1Y3R1cmUsIG5hbWVzcGFjZSB0aGUgVFNNIHJlcG9ydCBzeW1ib2xzIGlu
IHRzbS5oIHdpdGggYW4NCj4gX1JFUE9SVCBzdWZmaXggdG8gZGlmZmVyZW50aWF0ZSB0aGVtIGZy
b20gb3RoZXIgaW5jb21pbmcgdHNtIHdvcmsuDQo+IA0KPiBDYzogWWlsdW4gWHUgPHlpbHVuLnh1
QGludGVsLmNvbT4NCj4gQ2M6IFNhbXVlbCBPcnRpeiA8c2FtZW9Acml2b3NpbmMuY29tPg0KPiBD
YzogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCj4gQ2M6IFNhbWkgTXVq
YXdhciA8c2FtaS5tdWphd2FyQGFybS5jb20+DQo+IENjOiBTdGV2ZW4gUHJpY2UgPHN0ZXZlbi5w
cmljZUBhcm0uY29tPg0KPiBSZXZpZXdlZC1ieTogQWxleGV5IEthcmRhc2hldnNraXkgPGFpa0Bh
bWQuY29tPg0KPiBSZXZpZXdlZC1ieTogU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VA
YXJtLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0Bp
bnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+
DQoNClsuLi5dDQoNCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgdHNtX29wcyBhcm1fY2NhX3RzbV9v
cHMgPSB7DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHRzbV9yZXBvcnRfb3BzIGFybV9jY2FfdHNt
X29wcyA9IHsNCj4gDQpbLi4uXQ0KDQo+IC1zdGF0aWMgc3RydWN0IHRzbV9vcHMgc2V2X3RzbV9v
cHMgPSB7DQo+ICtzdGF0aWMgc3RydWN0IHRzbV9yZXBvcnRfb3BzIHNldl90c21fcmVwb3J0X29w
cyA9IHsNCj4gDQpbLi4uXQ0KDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IHRzbV9vcHMgdGR4X3Rz
bV9vcHMgPSB7DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHRzbV9yZXBvcnRfb3BzIHRkeF90c21f
b3BzID0gew0KPiANClsuLi5dDQoNCk5pdDoNCg0KU2VlbXMgd2UgY2FuIHNpbXBsaWZ5ICdzZXZf
dHNtX3JlcG9ydF9vcHMnIHRvICdzZXZfdHNtX29wcycgdG8gbWFrZSBpdA0KY29uc2lzdGVudCB3
aXRoIGFybSBjY2EgYW5kIFREWD8gIEJ1dCBJIHRoaW5rIGl0IGlzIG91dC1vZi1zY29wZSBvZiB0
aGlzIHBhdGNoDQphbnl3YXkuDQoNCg==

