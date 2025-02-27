Return-Path: <linux-pci+bounces-22522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DBEA47539
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 06:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3483A6E8F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412E4A1C;
	Thu, 27 Feb 2025 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6WGwfGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6315666D
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634269; cv=fail; b=HxaTxOWzHMp3nVOmB97yKQP2YzqVL0y+fYWSZTB5Xyz8bp9wYyfIsyzx/ygGxuWtgv9VAQVZCg6iwSPHypO417GxpwcoUG0RhvFNSS8p/CphKg3Axn3dUwC1XZdk/bIePppgRXR4tsD2bDJSXSinIte+o/YoGwp/FhEkEJ13bWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634269; c=relaxed/simple;
	bh=ejyrXUhdixO71rIGpYMrm/7z3CJwr6LyFL7FtCPxfbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YrUtNkf1HNMADUcAuGJ9V3PfvzBAeeSsTUxsg56IXvbKd+SsYPnu6qtj2buX3yTPrQM6D1Vujev4jthIYRzd+5W2vRO1UdaBQiaJbGkOZU3dBCrEAU0NIBKTS563epiRllCaqucbnTgekiGnGS1McBVZCWM8HJ/d72d+UjTZekc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6WGwfGY; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740634268; x=1772170268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ejyrXUhdixO71rIGpYMrm/7z3CJwr6LyFL7FtCPxfbs=;
  b=Y6WGwfGY88RFkHUrqCyENk42UYUtN5BajBSkCSp6Fshg/h4rzKb0b78v
   20h/s7FKOnmoaV/Atd3HBH7ifOp8cW3VQDOlUG+GdgBDkJi1Y+OJspWxG
   w2gBxFjkidus1tgq6PxBUp1IUKwF4xE4eGOGjKotvs3mx20cual76CELN
   DeGt2uznTldb4NM5xbHV155+xvwRp/izw3xMYMz1NN3EqWoi6RwXV9Sm/
   TiJbbe2xo16XzEMzV6shdafx9c5ZeDrkgR2BkJrG1FChYTRtcepyztvdi
   MUlFhzu8a/oCPol9VSRKMNEY8akSDkTX/AwEBBkCPrieQLKcCSx5a/3J0
   Q==;
X-CSE-ConnectionGUID: f7PAEO9TQPq2e78N994bAA==
X-CSE-MsgGUID: 8KHbQSNlTRqjGc6nfFYxKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45164226"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45164226"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:31:06 -0800
X-CSE-ConnectionGUID: HlpswZSoRhCZ5ilXpG2FCA==
X-CSE-MsgGUID: Z0YdD9ZGSSKnxq+ZnWKLYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116791954"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:31:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 21:31:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 21:31:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 21:31:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKfFd/G8Ih5Q+zIsXZ5o9oCtRf+g/j7Ln6wnN3HR2wfYUTdrQkepbrLLi+L8ek9aEVlLBCb9RSRJraH8twodzYqQlrE+6nwkX2eOw1fHxxMRNknPaqmqhcDl1HIr4pz9RkqL8m3W/2RzsnIQi4b/qpJL4duvdzxG3Wk52B2MRB3DutyIN8GqZ45vcgoYnh4v+/qcNs4iK1NG8W2rhe6/QKz8vHPYPwbMxOjhqbAgA1fZs9h1OR9ztARzcB0FpMVwOYv0vbtFBJm81cmEGyrn6eMFeqUP6p0WZieYx6CSSJI/OXxbOol0Q5/VmuNstoc/S8sGE7ksYQrbbDGmP7zhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejyrXUhdixO71rIGpYMrm/7z3CJwr6LyFL7FtCPxfbs=;
 b=IDm3mGLTlrR4rTuy4eh6xKTcmlSl01079VzoXxCC2+qIpBSn62g5Wk+2rr35MZbs7nZQMG+DULyUOjznVxfNKdw2gkAPH17E9am9kzqjbsY9CKVFSRf0jFGI9VPqf4JrSTC9muck81c7sP8q0sW/3Hf/ta7GOns5v0anRQZJSmdhwUYnsEsfHuiONwwJb2LKB1iJuSGTDt+mmnyviZ2J8dxY/6J9+3/vmzvOppnLSRjeyPgYkSq/UBdZI43qZtEpHDxMr8+ao/vhJGqn13nsbgJb1nyJ/rtuyDHaOb0Sdp0hZyyZsXFjf0F5RkatCZbIHbrQbVr+gKxNZ2q9G8hyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 05:30:46 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 05:30:46 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Kurmi, Suresh
 Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>
Subject: RE: Regression on linux-next (next-20250221)
Thread-Topic: Regression on linux-next (next-20250221)
Thread-Index: AduIhAZ+norPQ6pIQMCNB7FNA6O0jQAFZLAAAA+3oIA=
Date: Thu, 27 Feb 2025 05:30:46 +0000
Message-ID: <SJ1PR11MB61297C8F1E46182D9A68BE34B9CD2@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129B4B298158496F8BD36B0B9C22@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250226215842.GA560520@bhelgaas>
In-Reply-To: <20250226215842.GA560520@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|MW3PR11MB4746:EE_
x-ms-office365-filtering-correlation-id: fbd4dd4e-8f6b-4191-f77b-08dd56efe349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YmtQUUZFVFVtVUphWnFOTWZId1BTNE05L2hLWHRXampvOG1oK0hCb2dqY0dX?=
 =?utf-8?B?R2MyZFVJSnJkeFU2T2FNNktnRHRjVndCa2JnNjBzbXcvaWp1TTNFempWdXJp?=
 =?utf-8?B?NUFEMUNYeW83MmtjQ2E4NW9SRFlOR2w1YnpzdjhCNlZzR2lNVFN5d1p6dFlN?=
 =?utf-8?B?a3M4azlFRmlYSXA5S0JTbUhKb0x5VjFRekUyTVVCTVozWUdFcHQvaGFiSWVl?=
 =?utf-8?B?NXZxczRleHNvNERpYTZWdFRNWWRzQkJRWnMwRU9GcUF1TE5IRk82OHkvTGdH?=
 =?utf-8?B?d2YvdkttdGdPL1doN3JyUDBBdEpXME0ycHY0TThXVzlFRkJ6bkNwNndHdGt3?=
 =?utf-8?B?S1hGUGJHUllRVENnREw1d1VBNnF0Y1ViRjFwWFVRb1Bac0tXeFlGQTJJOGNV?=
 =?utf-8?B?U0NyNVp3K20rbE5nVFlYWm1kZTlSdzVoNFBCVkQ5Uld3aCtYM3p5dnJNaFpE?=
 =?utf-8?B?U3l1Tys3L1RVTk11ancyVW1MSXNPZkdoRVBLRGtSMWt3MXI3Z1o5RmxGTFcw?=
 =?utf-8?B?c3pmME91LzhhaVQ3VnJjbHFzRVRPMDI4U1BSd2ZxRGlXT25PckJBdHRXdWtF?=
 =?utf-8?B?a3NYL1prU3g1UjAzTWJVRGlsd0lKK1k5MzNKT29nNHZGenZ5VVJOSlkzejNm?=
 =?utf-8?B?d3dNUXdPQnlOc2JXeVpZN2ZrYWd4UG1tQ29iditLZG0wZjlocEFPQTJKb3JX?=
 =?utf-8?B?aXVId0paSnNTdXYxT29YUHNYV1ZOOXc5V2tQa21FVEpmL1N0aS9xVVBYSzEy?=
 =?utf-8?B?aFBncTRGb0pwNXVUcTkrL01zRGpjM3cxRzkzQXVJbytucmhEcDZEcHdXOXU0?=
 =?utf-8?B?SFBLc25EZXg5a3F1aHZFWWlXaXQxWFNoSlppaHZJQnhmd1NpWG96V0VqcXpI?=
 =?utf-8?B?dWROUjA4aTZsZkROaDIyUzJGMmVRdTZCWkxPM080L05IclVLdCtocE95d3Yx?=
 =?utf-8?B?VytSWndYSGgwMDlPcE1xMUUrd0JVQlFvVWlZQmVSNURjbmYrSGRHKytEV3hM?=
 =?utf-8?B?WmlxZUlnbDFDWUZlUno0anp1ejEvdGlnaHAzZWprZG14dGRkNGZNL2VMNDRo?=
 =?utf-8?B?SFdzdEx4MG9JZ2VNVDBLZFVndituUEd2UmZQMTlSWTYraCtncXppMUdITktU?=
 =?utf-8?B?Nnl2bG9tUUdqakJKNXZpZ2hTY0ZwS1E0YU5qS2xXTGFtSzAxaUlNSktSTmRr?=
 =?utf-8?B?dVNLUEM3TDBjSFpDV3hJQnY4ZVFqMjh4TERTSjB6TVoyQ0tueEdUTlBub09r?=
 =?utf-8?B?Nm9zYjV4aW5rSi9raWJwZmpMSk9kMUlnTHRadnVuSHQxNXdGTDcwVjJnQkF1?=
 =?utf-8?B?SDkvdDJJQXVwb0NvditZRklqdWhGWDIzcTBXblkyWXlPU0ZwanhLVXU3UTY5?=
 =?utf-8?B?cVVOT0ticmE5aVZQOUEzWGNRK29HdEM5YVBLYTl2MjBJR2RacmI5ZHJvUEp3?=
 =?utf-8?B?MjRxeiswNjlUMG41K1cxNDZrRHBhUDc3ZGF4ZzVxdkYxNEhRSEhKVGFCdVp0?=
 =?utf-8?B?RFZiLzIreFR6Um9oK3E3ckJlUWFVZVVUU0Rra0QzSEcwYzZ0bEwxSWFEWGgr?=
 =?utf-8?B?QUh5WmMvT1dqQTkxM0dLMytDSWNndUlBOFNVMGtMOWhTc2graE5uempXdTM1?=
 =?utf-8?B?cm1qbVdVamM5L1QvbkRXZTh0Nmw2OTdVUGVaOE1RSm91NTA5dUZWcjVxSXNk?=
 =?utf-8?B?QzRRSTZWZmEwbk9iWDVGZjRzUTZIUWU3L0krekcrZ0FxZlRUSVdDZkNKdmRM?=
 =?utf-8?B?SGZJRmpVZ01aWmxLNXJRZkVaYkxCRkxhRW1QWTBZOEFRMUd2aXdxWEJnMDNm?=
 =?utf-8?B?cmhpMlhPeXJsTVl2SXhpSUE0NG1TNzB5L0xKYUVWTzc1ZUdnQnduUXlTYVUv?=
 =?utf-8?B?OHFOa0ZYdnVZU0dsNGtxd2JXOHVsaWkrS09nU2gvaVdCNThoK0R1SGJFM3NH?=
 =?utf-8?Q?IrYxIWcqpdy21DGtpRaXP2NasF4FWBoy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVVEL0FBZS9sWXMxY0xISFdUaDBuSVlYcVdoQTFRanNKK0dWaFZtUUtid2hi?=
 =?utf-8?B?MzFNZGhDYTVLSXNIUlg1aGVsSmc4TE5uM05CRXQ4TUE4SjF2VDh4YzJVWkNy?=
 =?utf-8?B?OE1ERldwLytGNHNRMHVDU2c3cHl2bm5sRmsrNjhNTGg4TktCMGpDU0gvTWZW?=
 =?utf-8?B?S01rbytTbDhXc294Zk1rKzlPQzI5Tm9WakZiUlRJS1NhODQ4dC9xbXpad3JM?=
 =?utf-8?B?WHBGZS9HOXhqS0hFUUJKTHJLbnQ5SGgwVFJGMlY1cGd6YVpUaXpseGw0ZHVQ?=
 =?utf-8?B?NXZkVGROSkNIRnZSR2Q4NENVcDdYTzY4ZTBMYVdsakRvMkZTSUdUL0NWKy9j?=
 =?utf-8?B?YzRUd252d25iSElIVWFDOUdMUEJlOGhFS2hEMFR2RGtTRkw3VGRYeVlWMHUv?=
 =?utf-8?B?NzVsNEN2aWRveVRndHJkQkQvQ25QbFdaOXBTYlZDZFJ3TStQSjkwMmpzODV6?=
 =?utf-8?B?Q2lORGxzOGQxTXFiTkZ5Y0pnR3djMmZyVm83NkpvOUo5Vmo1R0lhVjE3TUM2?=
 =?utf-8?B?ZkNCdzQwK0pvZUpaMTlFZ0F2T2FsamxZNjBCTHYrM2UyS0Z3cWNQVlkzenRB?=
 =?utf-8?B?YlpFMUJsNDR6TGhaaHo1YUtxSDFtaERWTkJuUVo5YmlzT0JmR3hiKzAxTFBZ?=
 =?utf-8?B?ZE1tUHNibXBzUkN1M2NWWTZONXZhcUltY0JEUS9iUENVbjlXUVA2TkRINGFs?=
 =?utf-8?B?emY5MlNQM2ZaeHhSSHZXWHRUYnJhN29EOElEdEdyU29kWklOazhHM3pyd3h6?=
 =?utf-8?B?UUZIOXRSVnpBRUoyNStKZG1UNlZ3MnJvSFk5bGZXYkJKay9ObFYvdlpEZ2I5?=
 =?utf-8?B?Y1F2allZWEljcERBVGRlTkxhMXVRY2ZDQTRma3J2cm1mZUdyRDV0TXIvancr?=
 =?utf-8?B?M2xTN3h6ZlJWVWpaWC9JSUkrMWVMVGlDY05zbWowRnlkU2JzSGUxRDREbk9a?=
 =?utf-8?B?Vkdxdjk0NktadWJQVWhLZ0lGcDdkZi9OUHc1cXpTL0FYRUpVcE9ZSkVMQnpI?=
 =?utf-8?B?elBMc0xCQkFHOEtUVnptTG1FUmZSeDVQbFdaSUtFSGp2b2NFSWJWVUVWVGh3?=
 =?utf-8?B?azB2VEtCbTRhTTJBQmdiRGdLL3BoMWQ1MER5ek5FRTJMRWFncWZYQkhlR3do?=
 =?utf-8?B?WnlhcndXb014VnBSYUlxS3lpVk5JWXRzU0tYZi9GMFYrcVpDWWROUzNONlhC?=
 =?utf-8?B?OTVveEcrajJMa2JicWl4NGtrRDQ2bm82VHQ5a2tFUUgzVzRwMXIrZ0lsbHBp?=
 =?utf-8?B?K0JXeUdWazJaN0tvRmI3enlNZUZlUXlhNlNXSFpmRVg5R1hBTzR4d2JSLzY1?=
 =?utf-8?B?Ym5lNzB0aVVucVErWkhLYmNOZXVYNlhOVm9na1BWUWtzZFMvTHJOVzJXb2Ni?=
 =?utf-8?B?UFdwT0RBNFBMUVZWcVdqaVpCWnlsb2dqZHQwRTF1b0U1SUVBVHFRTWZjSkla?=
 =?utf-8?B?WmxaZlg1Qm5EL3RQUXpmY3crVlVDellNWGt1OFVsVVlOOFF4K3dpemFiMHV0?=
 =?utf-8?B?d0s4YTI5WGdhR1E4bGxobm9MelNRNFJtVFJrdWEyd3ZvKzE1Zm5RTmZSaFJI?=
 =?utf-8?B?aDdRLy80OFJsYkFZY3JuNi9KbWkxWTJmL2phVElFTXNqUmU4V2wyTzdNY25J?=
 =?utf-8?B?YmZ4V2I2VUkyQ3FWeXRtNXlwNUd6aEEyelFDYnBuOVR3ZUhXOWE1c1dWRFFq?=
 =?utf-8?B?WTFoOElPTFVLK3RzaEluWVNkWUZOd3JMNEQyd2tFcWdFWGcreWRNQTJZeG5y?=
 =?utf-8?B?UFVJVUI2bWRrNCtPdHdFQjhFaU1SZ3Jvd3BOL0gxMDJkTFkzMVpNNDhqUUU0?=
 =?utf-8?B?TFM3N3pYZEhFT1hFU1NIQnNwVUVKVDhZUWZGZU5uV3JhSXFTMFBSNU1ESHM2?=
 =?utf-8?B?NHB0Zk92WW8vd2YrdHVsNkZoL2NaY2hIZnRsY1dDTVhZU1orbDg0TVhqbUtG?=
 =?utf-8?B?QmdQVUVEZFFzcU5NTk1nenRnZVZGYTI4QlV1bkNZd2NaQUVrK0h2VzZiL3Ev?=
 =?utf-8?B?SlZTT0FDTlJwMTVEMVdEL3VXU2tuYlAvVHcrczBKQ1VaM2h2Zk9ySHZIOGgw?=
 =?utf-8?B?NElqRHVRcU15VWpiSkVCZmViVnZXWjRNWGZWTW1ybkRSbWExRSt5RW56NFR5?=
 =?utf-8?B?d2pKZ0pqejdJVjhBOVBOTEZLZU8ycGRvMmdKemFtaTNDbExNNWFoWDE4dVhN?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd4dd4e-8f6b-4191-f77b-08dd56efe349
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 05:30:46.6456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ln4KqjXejiKHGg7mOSGxY3K5WPFIakmJzXVEMq3FLmG44CySRcHDTZOKZzE97xXsnAVAa9/TSF+A6s4sntZaDc3A+BhqJQXf+NV/xoOyLug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8
aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjcsIDIwMjUg
MzoyOSBBTQ0KPiBUbzogQm9yYWgsIENoYWl0YW55YSBLdW1hciA8Y2hhaXRhbnlhLmt1bWFyLmJv
cmFoQGludGVsLmNvbT4NCj4gQ2M6IGJoZWxnYWFzQGdvb2dsZS5jb207IGludGVsLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLQ0KPiB4ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IEt1cm1pLCBTdXJlc2ggS3VtYXINCj4gPHN1cmVzaC5r
dW1hci5rdXJtaUBpbnRlbC5jb20+OyBTYWFyaW5lbiwgSmFuaSA8amFuaS5zYWFyaW5lbkBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBSZWdyZXNzaW9uIG9uIGxpbnV4LW5leHQgKG5leHQtMjAy
NTAyMjEpDQo+IA0KPiBPbiBXZWQsIEZlYiAyNiwgMjAyNSBhdCAwNzozNjoxOVBNICswMDAwLCBC
b3JhaCwgQ2hhaXRhbnlhIEt1bWFyIHdyb3RlOg0KPiA+IEhlbGxvIEJqb3JuLA0KPiA+DQo+ID4g
SG9wZSB5b3UgYXJlIGRvaW5nIHdlbGwuIEkgYW0gQ2hhaXRhbnlhIGZyb20gdGhlIGxpbnV4IGdy
YXBoaWNzIHRlYW0gaW4NCj4gSW50ZWwuDQo+ID4NCj4gPiBUaGlzIG1haWwgaXMgcmVnYXJkaW5n
IGEgcmVncmVzc2lvbiB3ZSBhcmUgc2VlaW5nIGluIG91ciBDSSBydW5zWzFdIG9uIGxpbnV4LQ0K
PiBuZXh0IHJlcG9zaXRvcnkuDQo+ID4NCj4gPiBTaW5jZSB0aGUgdmVyc2lvbiBuZXh0LTIwMjUw
MjIxIFsyXSwgd2UgYXJlIHNlZWluZyB0aGF0IHNvbWUgb2YgdGhlDQo+IG1hY2hpbmVzIGluIG91
ciBDSSBhcmUgdW5hYmxlIHRvIGNvbm5lY3QgdGhyb3VnaCBzc2ggKGFuZCB0aGVyZWZvcmUgdW5h
YmxlDQo+IHRvIHBhcnRpY2lwYXRlKS4NCj4gPiBMb29raW5nIGF0IHRoZSBsb2dzIHdlIHNlZSB0
aGlzLg0KPiA+DQo+ID4gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgDQo+ID4gWyAgICA1LjgzODQ5
Nl0gZTEwMDBlOiBJbnRlbChSKSBQUk8vMTAwMCBOZXR3b3JrIERyaXZlcg0KPiA+IFsgICAgNS44
Mzg1MTVdIGUxMDAwZTogQ29weXJpZ2h0KGMpIDE5OTkgLSAyMDE1IEludGVsIENvcnBvcmF0aW9u
Lg0KPiA+IFsgICAgNS44Mzg3MzddIGUxMDAwZSAwMDAwOjAxOjAwLjA6IERpc2FibGluZyBBU1BN
ICBMMQ0KPiA+IFsgICAgNS44NDAwNTVdIGUxMDAwZSAwMDAwOjAxOjAwLjA6IHByb2JlIHdpdGgg
ZHJpdmVyIGUxMDAwZSBmYWlsZWQgd2l0aA0KPiBlcnJvciAtMTINCj4gPiBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
DQo+ID4gYGBgYGBgYGBgYGAgQWZ0ZXIgYmlzZWN0aW5nIHRoZSB0cmVlLCB0aGUgZm9sbG93aW5n
IHBhdGNoIFszXSBzZWVtcyB0bw0KPiA+IGJlIHRoZSBmaXJzdCAiYmFkIg0KPiA+IGNvbW1pdA0K
PiA+DQo+ID4gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYA0KPiA+IGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgDQo+ID4gY29tbWl0IDdkOTBkOGQyYmIxYmZmZjhiMzNhY2JiNmY4MTVjYmE2ZjUyNTBm
YWQNCj4gPiBBdXRob3I6IEJqb3JuIEhlbGdhYXMgbWFpbHRvOmJoZWxnYWFzQGdvb2dsZS5jb20N
Cj4gPiBEYXRlOsKgwqAgRnJpIEZlYiAxNCAxODowMzowMCAyMDI1IC0wNjAwDQo+ID4NCj4gPiDC
oMKgwqAgUENJOiBBdm9pZCBwb2ludGxlc3MgY2FwYWJpbGl0eSBzZWFyY2hlcw0KPiA+DQo+ID4g
wqDCoMKgIE1hbnkgb2YgdGhlIHNhdmUvcmVzdG9yZSBmdW5jdGlvbnMgaW4gdGhlIHBjaV9zYXZl
X3N0YXRlKCkgYW5kDQo+ID4gwqDCoMKgIHBjaV9yZXN0b3JlX3N0YXRlKCkgcGF0aHMgZGVwZW5k
IG9uIGJvdGggYSBQQ0kgY2FwYWJpbGl0eSBvZiB0aGUNCj4gPiBkZXZpY2UgYW5kDQo+ID4gwqDC
oMKgIGEgcGNpX2NhcF9zYXZlZF9zdGF0ZSBzdHJ1Y3R1cmUgdG8gaG9sZCB0aGUgY29uZmlndXJh
dGlvbiBkYXRhLA0KPiA+IGFuZCB0aGV5DQo+ID4gwqDCoMKgIHNraXAgdGhlIG9wZXJhdGlvbiBp
ZiBlaXRoZXIgaXMgbWlzc2luZy4NCj4gPiBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgDQo+ID4gYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGANCj4gPg0KPiA+IFdlIHZlcmlmaWVkIHRoYXQgaWYgd2Ug
cmV2ZXJ0IHRoZSBwYXRjaCB0aGUgaXNzdWUgaXMgbm90IHNlZW4uDQo+IA0KPiBTb3JyeSBhYm91
dCB0aGlzOyB0aGlzIHBhdGNoIHdhcyBkcm9wcGVkIGluIG5leHQtMjAyNTAyMjQNCg0KVGhhbmsg
eW91IGZvciB0aGUgcmVwbHkgYW5kIGZpeC4gDQoNClJlZ2FyZHMNCg0KQ2hhaXRhbnlhDQoNCj4g
DQo+IEJqb3JuDQo=

