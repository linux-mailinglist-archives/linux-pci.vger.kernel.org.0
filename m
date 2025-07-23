Return-Path: <linux-pci+bounces-32854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2359B0FCED
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 00:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BFC5879A3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D526E16C;
	Wed, 23 Jul 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EA3LOW0s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297422F177;
	Wed, 23 Jul 2025 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309869; cv=fail; b=UTdFBC/v8bafTMsGIMOp/wI9yhxNF0YcqehPek8lZ94dOl52YQ9jyEBQy1juWX1HV4TBBRUpFvF2jK9B5biAk2LitrYg62hRaIC7lru9r4OGxcErQxJhr2W2+HXyyOqR+VKxlCLdKckScEpJRRjOxjLphgvWmjAqCZxb+TwT5vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309869; c=relaxed/simple;
	bh=od42BngRh2FYD/buxeo55DLT9k7eyDmD3Jo64HOhXYs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=IBx39cWOFQ5kqxBFhHpfbAdSf7K77Gm98WQc9AmwVjAS86QaZYqooSxYMOtwy0jp27E1R+t2Hxdkw1Ms1JjMj8bA8rGZvsuQ8ojSJDNQRCQU1/cU/2Ug4Xrf6JpDTBpB1oDloj6L38Mvqs1vA5Qroqy+Hk2/YW6X9X2dQ5UIl9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EA3LOW0s; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753309867; x=1784845867;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=od42BngRh2FYD/buxeo55DLT9k7eyDmD3Jo64HOhXYs=;
  b=EA3LOW0s1W/qNJrFAFSPBHq+dEjtyi1Y8IA+k51x5bSi3KgksKYtnHOt
   8NwC2J4oQ9g108+m02Cuf7A1ZLiGhOzANt47oo6xB53Culh2PGQsABaVE
   qGduQi3/4hNKeY0EngbxZlgoevaHgiqpaitfk4cgPLA50aguU9936bUN9
   FIp1x3H77TTgNqoT32sxhBRCgZ535mC1qd1L+Yj+wDF4agIY9q6JWihOu
   17ljd4MI4NpiMvk8VCjG6JQCfywKHsdbYSvGmQaAWpSzCt7SAl7hjxGKU
   Ry7wQlUQmWZ0Ph8hGtTKEghzTOHXuJkqy8WLNvgoIrvhQR8AYhgVXc1DX
   Q==;
X-CSE-ConnectionGUID: x6D4wZckRNajCxj1fvsxPA==
X-CSE-MsgGUID: yR/lZsozSPaKR4drWT+3xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55486085"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="55486085"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:30:54 -0700
X-CSE-ConnectionGUID: T/KKyASSTRuaqReOvdy/kw==
X-CSE-MsgGUID: cKhuozApTjifeVYq4yiksQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="160188928"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:30:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 15:30:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 15:30:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 15:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnH8aZg1M6Fy4n3721CUIEXgcSU/4uXhbC3SMhK4vQeSAOuBmC5ueSmVSzD+Q0qXHKCXTUAXsZX81WENFPxzGXzQyem5wlddzLcdKXERo4O37+xdosBX6eldZoIJOg6DNFmr3uhcCh5IV6ryKoimunUTdATvIPh3/2bbXvYXtRsH7ZykJ+SH/KTYwYIJJlcxqFBDO0LRoV6H8F2+Gu5/AHWviumxPMH42yT1fbmqxcO9g2u2wlZrGOS3Y1E1ZqOZW4MTqlFXPLC1tU5esuH9oAfidIVTi+NSf1vPLBsdAikhq3jXmrD/5oEW20SqNZX5/kCNwDsaAsH05tA6a/JMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiNVp4359LbMFYGSyQKEoq3HKbjPqRP+yrcA+5cxYZM=;
 b=E52QXMA5xEoobtHMSw/xrrciH7BjEH+0gp2+Z/ufgpC5P+KbKOf4S884cvxa8ahyyGL0t03ylkFcau0mrx7R1MdVjZIEoFe4R+9/utr4qWYOulwNaVzrOQXX5UoPJmcRQ5Se9UBcc6oHW6HmwEvyWxOyiQZcHpshaVyhfRdTJIhd74jzCN4xutJaYgvMJaG7GulACBgxOPihIOX7bOskx7nRBLZ5OEnIySTVBUX3tKouPur7Aq2wC5AV6ABelt6eneitrwbgIZNWI4S7NCu9Rr3AdVLneBXbK52VeSo0NOVpY21hgDSDXsi38+8trvTvL/4DuJYVem1Fhb6QcArmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 22:30:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 22:30:04 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 15:30:02 -0700
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
Message-ID: <6881626a784f_134cc7100b4@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250626224252.1415009-3-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-3-terry.bowman@amd.com>
Subject: Re: [PATCH v10 02/17] PCI/CXL: Add pcie_is_cxl()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 3254ce4f-4653-4371-ca76-08ddca387814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXF1bDc2Z09yRll1RFgwaHlkeE9wNFFUWU5Nem9ZMWp4U2FWSXNUVzh5NXhN?=
 =?utf-8?B?RkloOEMraW92Rmp5MkYweTFMNFVuQVRKN0R4UEs0YU94SVdoOStqL3AvNFda?=
 =?utf-8?B?YXgvcUd5dTJOakU1UTFsWkw3TVkxYkgwSW43ekQ1TThlV1g1NDJnTmhINnkv?=
 =?utf-8?B?MUNkdXg2WE9CMzM3U0c1bElvMmd5dDVLMnV4dHJaUE12R1VUcmxsRmFpSjc1?=
 =?utf-8?B?RmtaM0hPcUp5NGs3RDcvQWxlSHVndlprVTErTmp5TE90SktKOHpNY2VqYkh0?=
 =?utf-8?B?emxHZW5jc1IrMnRIVlJ1c015MlgvYk1pMlVaZW1xS0xmZVk4bEFodENwaE1n?=
 =?utf-8?B?S1ZiRkcvd3ArdUpUYXJIR1V6aFg1RnI2RmNpbllBSWRhR25Kb216UklEbnI1?=
 =?utf-8?B?NGRhcnhTUDh5UVp6Z25UeU43bmJpLzkxV1dVU3g1TEw4aHBMNWdxbG5kTXlr?=
 =?utf-8?B?NzZNT2pNS1piejZyNi92V1Bsa2RjNzBMeGt0a0NzZmtNMmhsUEpnZFpBUCtt?=
 =?utf-8?B?SzI3MHEwOWVxZnkwT2dtaWFlMzQxV0FCc2JkdnIvT0M4SU1meWdyK2N1Wk1L?=
 =?utf-8?B?aklxNWNWQ3hETHlmbkQrMDVMT0YxZDhyeVJtbjZnUzExeWpyQzVyNE5RR3Jw?=
 =?utf-8?B?TkIzQVU0d2tNa1I2NVUyOVBMR3p2WHBtV2RGSkdaOUZWRGNYemNRRmN6Qzlv?=
 =?utf-8?B?R0dlYStsRVRjbjdQQ1d5L1N0dnFLZk9pT2Z2bXdtVEtmSk9raW44TCtCNWY0?=
 =?utf-8?B?MUVNWUJMMFpRQmF0N1pQVnZNZzJaL2lQV3hKRFMrNlJZR3hFN25KNHlSMjdS?=
 =?utf-8?B?Q2RaMlNDVnhUZ0RXbi9obkN1bUkyYkE1TEx5VmxCWVF1UDVYaFo5cFNhL3Fv?=
 =?utf-8?B?VTdNMGlPYTlxdnNNc2RWR2cwcXZqOEptOWNFNzZ2RzJ3emVJU2psaE1LbVJP?=
 =?utf-8?B?NTBTUTl3Vmc0eTZuQ0ViUGJsdHFnV0dscjBCMk0rTFQ2OUNZL01ZOGZJM0xz?=
 =?utf-8?B?cUhuTEJjQ2htL2g0a2lCMWFQUmM2OXkzem8vY0p5THZvdW02Rm1BZzhCOWFa?=
 =?utf-8?B?S3YxNkltclFrREM2VXlpWjdMVGoxenI4QzNLSW5GT21XMysxKzMwYkxVR0Mz?=
 =?utf-8?B?djgyenZpdnVlSW1XYW1UTnhEU1c1cUVNWW5yMnRSWUdqMFBaeXdrTVhQRFJt?=
 =?utf-8?B?b281dEYwK2piMTFaazBzVmJNdnY3QVJxU2JGQ1R6ZXhsbjhCMzR0bUlabXVi?=
 =?utf-8?B?aWR0R1F2bm4vYUl3akJIcE8xMmdFVTRMM2tpdFlYSU95bXd2VDJtV3VsRng4?=
 =?utf-8?B?S0xFMFd2RmVpYXpCSzd1MGptcnNTbW1mNFBiUE9iMjZLRUlwNU5QRjUzQVpa?=
 =?utf-8?B?bWRQNTlsU1BCelBRYVFLWVU0RFgxS1FEa2dsaTRoRnFRVFZ3Z3pPSEY2S2l5?=
 =?utf-8?B?YXFiang5WXc5SU42ZnN6VFZ5MENHOC9QemdnSFVsYVQzczdVY0doUVNmQng4?=
 =?utf-8?B?SStzeVkzMmJmaWVJUURQaGpjZ3phY0JzcHZKMVNEa0RhQUhhTkhoTFdkS01u?=
 =?utf-8?B?NWdDZjcvMDRROEhvbHpNQVNHdXdwV0I3U3R2TDVmZzBDQ3lOb0dwYU92ejFF?=
 =?utf-8?B?UkxtN09uY2dTQTRRMEtPNzZHa1F6ZExvUm1QU0hzbEl4YWxMWCtMYnJRWEpu?=
 =?utf-8?B?cjQwZUpDQldtQ2J3Qm4ycnJWMnQrOG1iNGdmd3kvSDZId1A2L0tmZ0xlZC9B?=
 =?utf-8?B?Y0pWRnpQRzZ2ZFVjdVVEb0NzQkRHVHlldHdrY0tVRGtndU9wdFNXOXVEd0Qx?=
 =?utf-8?B?SkUraDcrZmgwNmVSNlpOcEs1aUl3NDdZdS90cDhoUCtKWElzVEJRUUVxRGsz?=
 =?utf-8?B?TURTVFZEOFNpUGxlc1dGZmloOXdHRjN2UnB4cThwenA3WGJXRnNNSzhEV1Bq?=
 =?utf-8?B?K1Rna1UxYUFmL0lOaER2S05LR2trSzFBSEpOZW4vOTlGVFVKaUxaRVpjdWVq?=
 =?utf-8?B?Rk43bGw1NytnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnpEclBtWE9pa3g2SWpYSnU1SXJvcTJJV1ZNUTdtbEJ2NExxOGdQWnNNVlpJ?=
 =?utf-8?B?REpWYVVoYjVyQUY0VDBaM054YUg2dmIyYzVqSVUrb0dVamsxVjd4UkpLNFVp?=
 =?utf-8?B?Qk1NQjR6QUtCSVY3TUQzZTZyZFo4REtMVFZVeE9meGJBNzNNcHgwbkZxYm1a?=
 =?utf-8?B?RjNmd1p2eFYzYjVyU211VWxNWHhUMldmQjRNOUV3bFVibXhRZEZRU2xJRTNG?=
 =?utf-8?B?bTlzSVpOZlJnSEoyWHlWK2Y3Vmc4V1FkdUlFWEFiazdIK0NMa3FvVW5Uckxs?=
 =?utf-8?B?M1lUbVlIbzBlY0JtczFtcnBvcDBBQkhWNUplZkliUmE0c09QNnY1akllaFVT?=
 =?utf-8?B?S1pjSmpEVk1FVDJhcFFqYzA1Wng3UlFLdEpvYlNIRHpqcWFMNHlUZlBzdkxk?=
 =?utf-8?B?Ty9ybEY2aHhYdTRKL3VhaXRCSTRiM0l0TzVMbmZFNFo4UXplVXVRakwxQzJW?=
 =?utf-8?B?UmtOQWQxMDB3Y3BKbTNuVXdGWWpBNTB5K3p4UHBEWnZ5dVhqSFRabWxvdDNV?=
 =?utf-8?B?azdBcEZHeUJ0UytpSTF4cEhLWkxHckg5dFdqZnhOck5jT2NzdzlhZVl3SDQr?=
 =?utf-8?B?S1kyenRoeDlnbVBIeFJhcGwvc3g2VHltd09sM0FEVEQrWWRNQzh2REd0Zitk?=
 =?utf-8?B?dE1Lc2V0TDIrUXp6dktyUjVDRXE3dDNxUHZoaTVmdXpjWmtUWlBkVFY2eDZT?=
 =?utf-8?B?YWcycWRpQ1BsYWVsN0x1dlFqT0hHN1FxRVF0Slh3MjBLcDBZV1dOQW9SbjdJ?=
 =?utf-8?B?MUFmWmErWjFiU0U0eE11SzZBTGhWdVJjMm9hckFpaU9McU5XUmdZcEZiTDZv?=
 =?utf-8?B?TzRHNzBwRURWSU5vY2ZialErT0hURnVlMkdmS1BZSEhCNU5xRmR5Tlg3eFlm?=
 =?utf-8?B?Mk44OTZzM3l6dkVONDdObmZRYTd5V1U1bWNxNVR0QjRyOS9vbXN5RU5ia0RF?=
 =?utf-8?B?eWJBSEZONHdUVGlESE0rZ1dMbHZEVkZ0STZCaUVWeEcvRGFVQUREbDdRZGpz?=
 =?utf-8?B?OXZ4QlZIRVVjNzUzcEdndlEzaHFvSFdacTZPQTNGN1lWMFIwZ2hGaUZpaTdT?=
 =?utf-8?B?K2MrajlGZHhlLzE1OUpuTlhVc1JHVVhwWjAycmJoUFRXbDc5NnRublU3UVVL?=
 =?utf-8?B?dklGcTU2MUtkQklWeTJpd0JFQkZKTnp3MmZNbDN3L0VhK2IyeThodklTL2Jr?=
 =?utf-8?B?eXFWNzdjY3BmYWhOejgwcVlRaWJrRmVVODdRK0lnRHBYbGFONTl1UU9aaXpl?=
 =?utf-8?B?RWZwRjN0Rlc1NCt2YjVnSEVPTUNGdEVUREUwVWxHcmNqVzVlOWJaN0huTWxz?=
 =?utf-8?B?ZUtzb0lGc3djNmpveFNHWHRMdW5YRVlacURoTmhYTk9ZZGgzTXg1NUROWUFW?=
 =?utf-8?B?dkdIWHhlWkF1cGhnTisza3h1eGVhREU4Ty9CV3lvOU40K2l5c2o1ZVc2K2NS?=
 =?utf-8?B?V3dJQTZicS92QXFqV2hZaEZhc3dBL1U5WGxCWGpES3ZOTUZHMXptUmFEN1kz?=
 =?utf-8?B?bGhYK1ZkYjNKSEhEcFFjQzhrS21FM3hQcDd0dHZSeUxreGNDSkZEeDdSNjBO?=
 =?utf-8?B?bGo4TEQ2MkY3L0RnV1hudDZFMEMwOENoWnRvUUhUdi9zUERYYmN3VXZ3N3BR?=
 =?utf-8?B?c2lCRE9JbDdZMkZsdGxPQ2MreU42MkhVc0VVZTdaR2RVUnZQRVNLU2JMdzVT?=
 =?utf-8?B?bmlMNVdDSVV3azBYMFFRU3pieXFXaDRXbGdGalFxNjR5NitJT3k1eS9xUzc0?=
 =?utf-8?B?Q3czZVJmdlYxVlpiTWdwbktuMTVkOW9vMVNKZjN3a2E0M3NKQlZUVTV1NDho?=
 =?utf-8?B?S1Q0YU1ZczZ5SXhFN01WUVc1SUlsN3daMXIyM3pSaE1UTGlIMXFWL1JSV2RI?=
 =?utf-8?B?alhPd0E0cGNIWDl0bFlXZVpQYmVRelZqR1FCZTV5RWtQMXg2MjMzRVYydlEy?=
 =?utf-8?B?WWFwbEZOMmI5ZFVUSFc3Y3pndDdDV0lCNk5TUVhNTU1FOVhqQUZXWDBrODdO?=
 =?utf-8?B?Sit3cFFhSlZ4L2x1L0sreFFJWlhaR0V6QzBZbnZqMDNad1VycWF4RndDWEVG?=
 =?utf-8?B?Y01QVlZMVG1Ib3cvMFB3OEpBemdMVEYvTlFvdkw3ZStiWVhxRXZ0TUp0cHZr?=
 =?utf-8?B?L3NxTHFhNWNDVXI4Qk5KMzFObElBUWRBZUswN3AyRFRoWUxDQXo5K3dtYi9F?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3254ce4f-4653-4371-ca76-08ddca387814
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 22:30:03.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PFxKFCdtCbujS09zpmrl1FoGooYiS9nx7zJzIjksnf0RkMFFAeyMqVgNri5ivVX9M6BP7NwluK4tW1sIZ66SvpAtZuhoa3C/PoDpnvs6II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
> 
> Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
> CXL Flexbus DVSEC presence is used because it is required for all the CXL
> PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> Flexbus presence.
> 
> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/probe.c           | 10 ++++++++++
>  include/linux/pci.h           |  6 ++++++
>  include/uapi/linux/pci_regs.h |  8 +++++++-
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..5d3548648d5c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1691,6 +1691,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS);
> +	if (dvsec)
> +		dev->is_cxl = 1;
> +}
> +
>  static void set_pcie_untrusted(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent = pci_upstream_bridge(dev);
> @@ -2021,6 +2029,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Need to have dev->cfg_size ready */
>  	set_pcie_thunderbolt(dev);
>  
> +	set_pcie_cxl(dev);

Per the comment in the header below, in the case of upstream ports and
endpoints, this should walk to the parent downstream port and make sure
the cxl setting matches. I.e. with hotplug the downstream port may
transition from not-cxl to is-cxl. Update downstream-port parents at the
beginning of life of their CXL child-devices.

> +
>  	set_pcie_untrusted(dev);
>  
>  	if (pci_is_pcie(dev))
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..79878243b681 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -453,6 +453,7 @@ struct pci_dev {
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially
>  	 * execute DMA attacks and similar. They are typically connected
> @@ -744,6 +745,11 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> +{
> +	return pci_dev->is_cxl;
> +}
> +
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>  		if (!pci_is_bridge(dev)) {} else
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a3a3e942dedf..fb9d77c69d5f 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1225,9 +1225,15 @@
>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +/* Compute Express Link (CXL r3.2, sec 8.1)
> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> + * registers on downstream link-up events.
> + */
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +#define PCI_DVSEC_CXL_FLEXBUS				7

Please, let us not end up with multiple definitions for the same thing
in multiple places. I note that Alejandro introduces include/cxl/pci.h
with some of the CXL DVSEC definitions from drivers/cxl/cxlpci.h.
Although not all of them, I think a precursor patch to move all of them
in this patch set is the way to go. I.e. drop all these PCI_DVSEC_CXL_*
versions in favor of their existing CXL_DVSEC_* versions.

