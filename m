Return-Path: <linux-pci+bounces-32965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999D0B12B0C
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 17:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3059A3BDC33
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E361C84C6;
	Sat, 26 Jul 2025 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAtYCUI2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233ED13D891;
	Sat, 26 Jul 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753542069; cv=fail; b=BtZtmSBXyHxwQGuBEr5zOaTUwrsBhf0Y4JWWzxkpKZwym+OEuvjLg2hCFzro0/JsHH+4C7Nz6qUK0Z59XYxXo4hFLXXDQEOxaOZA7H3Mgz5PGFEgL8mzVWer4HWgr/aI5m1wgpWWtzQtS6xLj9Ub6Wz162EhFDNanXCwKTNrzrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753542069; c=relaxed/simple;
	bh=cRQXsMRpA4UTHE5iSZp4oWpdGVdWOfNcMDoi1apDtBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dYvHYkpKRL0/exMb3MQWMux3VZqeHyU3JzoGMWiFjBXmGx3Rjm+BcnpdjuOFaL7HF9AdeReLr0zvK3BH8R1tLAI3z67guuZY5hpNnNIGYYDyh+/LdJdULQ3zdhis1EUDSJQlPLcScLhJ/fNwf5iH4s2gGiFGvaboWbrd9e1iBuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAtYCUI2; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753542066; x=1785078066;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cRQXsMRpA4UTHE5iSZp4oWpdGVdWOfNcMDoi1apDtBA=;
  b=LAtYCUI2WCGKuPXsLCGhl9TlzVBnOF4tQkUS8K5jE3zwfhBBsGy5Bean
   N84WztGus8m1pgmJLPMCUzA05qtd8u6EAkf8FrYe9VT3Mb3HHYmCwvXsZ
   iXDB06rxT/5GXVAWCXlNAA9H8og87rGj7H70zlQglXSihlnukeyHx0kPf
   XJvSPnf4k1r1FoIr+SAhpxwxTEcWBN83ePo2iGbemV8t/xYQB+ourgZjc
   WO7F5TQYczOiLdidAlPP9LJ83g2Uhk3fNdldnVYISQcA8P5ekdZ/Qh/1f
   UygQpoJ/3VibdFW9+XpO/B9qDOJVEpVLqNN8boBuIrhRcK3dSLy26A7Ki
   w==;
X-CSE-ConnectionGUID: 9y2NqbVaSYCVMj8037+HIQ==
X-CSE-MsgGUID: KDL8zGbbTFmPr/F6xfgInA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="43465817"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="43465817"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 08:01:04 -0700
X-CSE-ConnectionGUID: GQzKiYb7T/imabjORKPdXA==
X-CSE-MsgGUID: TBaAwNWnR0+nFvk9shjhEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="160793769"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 08:01:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 26 Jul 2025 08:01:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sat, 26 Jul 2025 08:01:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 26 Jul 2025 08:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq2pDRTAb5iqXx5NKSmGx4f8ZhqhaQ8rvqHe0KlPw+YZ9ShWDYQYg2CuIWnPyBWc0cy+L+nlzABMgW1JsygbwFghAG/R1q8aUDxiwUW2CKU2MT7q3TdfkTfjTHzd51tG/MyikuOreujdLZjDwiSrXZLu8fQwdfyH9Agt1MIqkbCosD6SrR+Ve6zIHGRfxC2CStuTcQkS5I0R3saCwdOMsT7XOnt08WOmSLaPT7s6FtTHFZqNCfc6IX8QEvZDqt1cYaaB7itSuiaCWSOUCyGukbkfrM1Cwwl2ApZDjcblPWJiyZvpLKmk00+3zAG1bES9PwCHUH+fVeNGsJnLOn3xSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRQXsMRpA4UTHE5iSZp4oWpdGVdWOfNcMDoi1apDtBA=;
 b=tjWkBK9lB9NSxartbDyzLjhjMmJCmbDK2ryBughb+JO2SsaFsdBIA/g563li12+oOmhbuQkWag8xplJPOU1fciCdsfNyIo8YX/VNb5ucS/ISfqua4MLzx/k+S8VjKUXWwqC/crHBsO5yMRNOrvhLXA3dHi1+pYDZfinV+z9y9z35zpPf76LghGJOADq1deXuTyZHxepe2O1GP29DICBzlSQON49N40vmq3O1yqETRvYx4R6WWXK1WebZJylA4aRAoFe8QfUxKAObjdwyO0aQN0A9fcRMM6Q0+nif67QQzE6VF6yF9YnQLo7r05pLuWX+L4NuC51eYXCW0tYe5qIChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sat, 26 Jul
 2025 15:00:17 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 15:00:17 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v6] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
Thread-Topic: [PATCH v6] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
Thread-Index: AQHb/UBu4h3C8C17uk+M4vpfN3sVfrRCi8eAgAHxNVA=
Date: Sat, 26 Jul 2025 15:00:17 +0000
Message-ID: <PH0PR11MB7585BF34D444D211384B0197F558A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250725090133.1358775-1-kiran.k@intel.com>
 <fabecd3c-e715-4ef5-bf79-72e2575ee372@molgen.mpg.de>
In-Reply-To: <fabecd3c-e715-4ef5-bf79-72e2575ee372@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SJ1PR11MB6252:EE_
x-ms-office365-filtering-correlation-id: 60f2e6f8-ae7e-4779-e18e-08ddcc552221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NjVubmM2MGdPU0VkZGM2R3pwaXNYSXNUTHhidDc1Rzh3NDEzTXhSbzFJemx5?=
 =?utf-8?B?TjFBeENpUTh4NEtuYld4eGRwSjBOdWZhcVFic1N4Z2ZtYlU0YUZBRFl2SXUy?=
 =?utf-8?B?dEZsSmdqQVRScEExQWhYUzA1S2tzV3d1c2pRRVRybmZSR3E0bUptVWQ2VkUr?=
 =?utf-8?B?WlR4SFMyVmlPaXpiNzZ1ZXZlSE9mdUJzVUcvN1Z2NXBLOTJ1V2J5UDdOdUFz?=
 =?utf-8?B?UkFPSlVUSGpLMEF6YXpqdEhlejRLSXVuOG8zTy9mTncyVDIzWG1YYk1zNDNa?=
 =?utf-8?B?WjZmWFpNQWJCNEFIMlg4Y1RUTkhBQ1FYV2ZHQ1pPQ3pwRDFKZ2V0cUJnL1VJ?=
 =?utf-8?B?UEEzRU5HRVRQWEtwODk2UEdsKysxaEEvRVZNL05QOXlIVTNISkdpRFAyaEFN?=
 =?utf-8?B?aFF6VFZxcVNFNjJRN1ZESTlTVlFJeFpPVjNBY0I2SHhGakRna0lQZ2MvNWRO?=
 =?utf-8?B?RkdJQk1OclhhSXRzTFMzcHBJcGFtN1BkeWVKNUc0RXl2NDJhMWUyQnQ0alE1?=
 =?utf-8?B?UlMyL0pHVWRBV05PVDJoLzVqMXVYRW5DS2xzU3RnVVhndnA5cktZdmdoajR2?=
 =?utf-8?B?dHJ3cXVYUDVLdEZlcm5Pc0YrR0VUNFFJNXFvdWpqWVVVMUdMUkVmcDY1Tm1X?=
 =?utf-8?B?RlBsZGYyYVhIN1FKUUJSbkpwUDhBdDJiNnJySUxGYnpmQnZZQ2UzOW5qckZT?=
 =?utf-8?B?cHpsdjlkT055WXdJWDVQR0hMYmFxWW9JL29VdThOek10c1VydmVHUTNkSzd3?=
 =?utf-8?B?VXErbG5FOTY0MUI2ejNydlRrMWJhV3RzWXZzYkVGTmVkTjUzYzZIUWVUYVBB?=
 =?utf-8?B?YVFtR3lzT2xFRDV3dGcrUDFDNnlkbDNJQ0QwdVVEMTI2VVN1dmdmWVF5SC9k?=
 =?utf-8?B?M1hpQ3dJT2tnUDBLKy9pd1ZCWlZiV21paXU1RndCRGhseGVIYjV3andFZita?=
 =?utf-8?B?UHUybHcvOG1GdElTV2RkRUxaeW5hSUVTc1BBejM3NXJyb052S3NCeWlzM1VS?=
 =?utf-8?B?Q3hJUjFpY0NOSU1zY25aRzdkbUdrb1BLUmVHWnpPYUpEZVVEKzRORUVpMWd5?=
 =?utf-8?B?SWhZeGkzSWczNXJ3VHpsT0JmMXZoRnpsOEc3TTQ2QzV5KzlNaTE2OWJ0VHpw?=
 =?utf-8?B?cDdzMmhRVjNjVVNDV09jRnl6MHdXa2Z4dExIdDZVdEE3bVpsczZhT291b0tW?=
 =?utf-8?B?T1plSVM0eE8rdDdCc3NCSVJFWjV2dy9mV1Jmam5odzJ6TmR6VWEwbFJWaEpU?=
 =?utf-8?B?QjVXSG1QOE1YQVA0c3hNTEwydXpNQk9RakdYSVE4eTFKUnQwMmhRcy8yV0Jo?=
 =?utf-8?B?Y1ZoN0ZEWm41TXhXMncrRUE5QzZ6S2Y0RUthR2hpSDRWS21LNGRwY2hRb2la?=
 =?utf-8?B?bzhYamgybldGRlR5YTdIWUs3eldESE5ia2dmWS8vOWJNRVhwUnNJSzd3OEFR?=
 =?utf-8?B?YzRVbWIwWVRXRkZhaUhXNXd0YjF2R1lwa3pmdzdQRDQxRmZEMDBFUUN3WUty?=
 =?utf-8?B?NEpraXgrR084R1RhbkVWVDhkdTRPQzhJOHRMZkdndHVnVzVjM3BPMkxUYlpV?=
 =?utf-8?B?eUo1QVovdXVkVUlJbmhmUytHSTB6RE55Q0JwL3lHTzBITHhYZDBwaUJOSy94?=
 =?utf-8?B?dDJNMmIxdkV0U3pmdGlSRlA5UmhDMEY5c0FJQkV6cHBLeDZEYkxGVTlhN0Jn?=
 =?utf-8?B?TGpNMEowUmhDc0Z5V2QzSG1DYkFxT1JDNnI2QnI4b3ZVZUlDV3VyMkgyNjhE?=
 =?utf-8?B?bTNwUXFGeG1xQ3N3RmhUNEt3QkE2RjVpQkJHRERUUDFMak5VU3dNdnlPY1dC?=
 =?utf-8?B?V2pxQzgyTXlKc2VxeERkdkJ6QmRjN0JQU2ZhcTd0SlFhMkpKZGIwbGhvbWVo?=
 =?utf-8?B?TmZNZ0VaQmpkTHRyNm95dzF3d3U1azlpRlZldkgxZkxHbVh0aU9US0xoUHNR?=
 =?utf-8?B?dHhKQmdZY0l0b2FqT3pWVi9ZcmgrK1RHejhVZnVEQjlqNVhoN2V2ZHNhaVY2?=
 =?utf-8?B?NW1XakZOSXN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2s3d3NQWHlIVEJwQVJFU2pXVzNNUXN3UEpOdGdrQitXSUdjK0J3Sm8rR01B?=
 =?utf-8?B?N2w0V25nb2Vrb0VpZGlUaDEydFFNWGtRVEh6WUZMdkV2cGREckQ3VXBrSW9G?=
 =?utf-8?B?ZysvUnM5WHpXOGp0bXN3bGZmOFJCNEZqeUlwT3BNbWsvV3lMcDdzNUsxWk9V?=
 =?utf-8?B?b0h4bG10ZGFseFZnNURsb09VM2RSYW9PdnFmcnBsMmdETU80WU1zaGhQUTJx?=
 =?utf-8?B?ZElaM3l2R3NMT0x1TlpENWRkcjNaT2xDSzF3b2JRcFlSOXhDV21Tand5S09j?=
 =?utf-8?B?bC9KSmlubGQ1Q0o3VDNUZFIwVG1VOXR0K1NsQzF2eFR2eHpXWGQ4ZnR0Qy9W?=
 =?utf-8?B?OXFDWmZCV05yV3hQM2hHalpDczJNaEo4a2JqUDRvUjhLSFNuaFFoaEYrckcr?=
 =?utf-8?B?S0QxNlRWazNidjZabUh3L05UTHBDU0JiKzZUeHRpVEx2YTA1amZQWnJRQzRN?=
 =?utf-8?B?Yng4RUwzNkZEczhxRk53cXlpbVQra0pJTEV3V1ZnRjFzWVVYMG9wNW1semhK?=
 =?utf-8?B?NnRDdjhGUzd1WmFDQ1g3UUh2dlQyY0VkWEdFYmZCckRUZlpFWGhYcFgwUmE2?=
 =?utf-8?B?amEyZG8vNzkzY1lQeVR4UzZXTXpHL3NybHRyZFBFMmlFUXNJZURHMG5MOHBB?=
 =?utf-8?B?TitSVVdLb1YwTWU4Ym5iV0YwcFdZUGo5UENGQzhNV3JZSDIxU2NGVHZzZ09t?=
 =?utf-8?B?RUJwdFpBemJ6Qi9JRlRIaVNXM2NkOTJra1JVaERJYzlKT3MxVHdpK0VQcGtu?=
 =?utf-8?B?R0YzVnhtQXJrR1o5K1d5ZWlDNTJFK1M1T3dyWGRnOW1JYkhjdCtoSVR2S2JU?=
 =?utf-8?B?Q2V0T2phQ1FWTENDVGYwYVRQZ1BLZHlKSGlmR25IdlFQRjZnNHQwd1FNVThM?=
 =?utf-8?B?KzJCTloySTdnN1QrTzZtdytnSythdzQvVEZncWxXcHVMUmhoOEJWME9wWG1o?=
 =?utf-8?B?a1VMcGNOUVRXbFU3V3NXT3VrL3dDS0M2eXhJb2VXOXFTZWNaVUJkM2JyU3Fl?=
 =?utf-8?B?YVVnY1hnZ0JFSm44MWpVZTVXUi9IOVZpbXUyWlRJZDl2THZsWVVnWDBBcjVU?=
 =?utf-8?B?SU5vRjhEZGNBMFFydzF0Wk9sL0Q2MEltbUxJODhwN0FkdWNITzVad2EwRzBE?=
 =?utf-8?B?TkpPY1cxYmVSUlBPNzBnUjRNaUZoZVBaK1RnMndTZ2dCUUZuWUh5dk1nZlhp?=
 =?utf-8?B?Ymcwc0d1aEh3VVlSZzkxSnoxaCtROHpkS2tlcEtXamt6b3FmbkVKRHI1K3JD?=
 =?utf-8?B?RStML2VwOFY5Snpod2haenJsWWd4cDl1UlkyNEh1TGlrRGIzNWZsa2U4aStM?=
 =?utf-8?B?dCs3SVlDZFRWN3hqSHZzNjNYYzFqV1NpS0Y0TkQyeUJiakRUdzY5K29Wek1K?=
 =?utf-8?B?azFvaUxhMytNSER6TjNVdXQ4aHh1RU9aeXdkVmxIdTdVUHhQc01wZDJDeUhq?=
 =?utf-8?B?Skt0Wkw2bm9FOXBFdCsrL295dC9DVGJnbzFrbE9NOVpqamEwcE5peU9FaWJj?=
 =?utf-8?B?YkZYRVVSc2xVbk40bFRUWk1GRXR4dENGcDBPNlZUTzRaVHFUTTF1UlNkc1NX?=
 =?utf-8?B?SzNlTGVyS0FQVjBEQ09WeWRiM0k1RngrMGd0aHdZdkZWYmtnWTlnT2NpOHl4?=
 =?utf-8?B?VVBqSlNYVXNTV3JXK294aW4veXZQQ0paSmFWRk1BNkF0cVkwdTloMXpUM3pn?=
 =?utf-8?B?bnk5eExHN1FuTmc2cW9nRnZBRXRCVDNXM0dBWXBkV0hnTHk3MjREdU1JSW1n?=
 =?utf-8?B?MWRBUUw2MEN3WStITGQ4Q3FreEpSZjg2MUJyT3UyZjRNYWxxY2JlcmlIYXh1?=
 =?utf-8?B?TzliblJXSllDUk90WitZc1JuSDM4TGw3RWpCQ1VucUVvTU5MdWwwa3NKVjVy?=
 =?utf-8?B?d3c5LzhBeHg0b3RwSEp2T0JOVjFOMEZOZUVFSUdWS3MyT2N0YUF1YWZ2ejZm?=
 =?utf-8?B?QTd6Vlp6eC9USHhBRlluUWlCTWZ0bjNoYUpYK0czWDNlMDJMVUtHeGtQdFpl?=
 =?utf-8?B?SE9yUVh0bFJ5bVorZVRWby9iZGYwMjViVXM1MlNaaHlmYmgyWkZRZyt0UTYy?=
 =?utf-8?B?RmVxaFZHYjJFN0RWZEsrU3lsa1hQemIxekF4b1Q5Y0FVSm5SazYvd1lsSyti?=
 =?utf-8?Q?DxoU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f2e6f8-ae7e-4779-e18e-08ddcc552221
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2025 15:00:17.3268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GC56daxDTbQ/IOE3XRaIultck3il/axKBe9FahCcCjDlF0c2+sFWqJxOa7rCR69ad2CE1ShOCvtS8MSpE78xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6252
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGF1bCBNZW56
ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj5TZW50OiBGcmlkYXksIEp1bHkgMjUsIDIwMjUg
MjozNSBQTQ0KPlRvOiBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5jb20+OyBEZXZlZ293ZGEsIENo
YW5kcmFzaGVrYXINCj48Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwuY29tPg0KPkNjOiBs
aW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBTcml2YXRzYSwgUmF2aXNoYW5rYXINCj48
cmF2aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3VyIE5hcmF5YW4sIENoZXRoYW4N
Cj48Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29t
OyBsaW51eC0NCj5wY2lAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2Nl0g
Qmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IEFkZCBzdXBwb3J0IGZvciBfc3VzcGVuZCgpIC8NCj5f
cmVzdW1lKCkNCj4NCj5EZWFyIEtpcmFuLA0KPg0KPg0KPlRoYW5rIHlvdSBmb3Igc2VuZGluZyB0
aGUgaW1wcm92ZWQgdmVyc2lvbiA2Lg0KPg0KPkFtIDI1LjA3LjI1IHVtIDExOjAxIHNjaHJpZWIg
S2lyYW4gSzoNCj4+IEZyb206IENoYW5kcmFzaGVrYXIgRGV2ZWdvd2RhIDxjaGFuZHJhc2hla2Fy
LmRldmVnb3dkYUBpbnRlbC5jb20+DQo+Pg0KPj4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIF9zdXNw
ZW5kKCkgYW5kIF9yZXN1bWUoKSBmdW5jdGlvbnMgZm9yIHRoZQ0KPj4gQmx1ZXRvb3RoIGNvbnRy
b2xsZXIuIFdoZW4gdGhlIHN5c3RlbSBlbnRlcnMgYSBzdXNwZW5kZWQgc3RhdGUsIHRoZQ0KPj4g
ZHJpdmVyIG5vdGlmaWVzIHRoZSBjb250cm9sbGVyIHRvIHBlcmZvcm0gbmVjZXNzYXJ5IGhvdXNl
a2VlcGluZyB0YXNrcw0KPj4gYnkgd3JpdGluZyB0byB0aGUgc2xlZXAgY29udHJvbCByZWdpc3Rl
ciBhbmQgd2FpdHMgZm9yIGFuIGFsaXZlDQo+PiBpbnRlcnJ1cHQuIFRoZSBmaXJtd2FyZSByYWlz
ZXMgdGhlIGFsaXZlIGludGVycnVwdCB3aGVuIGl0IGhhcw0KPj4gdHJhbnNpdGlvbmVkIHRvIHRo
ZSBEMyBzdGF0ZS4gVGhlIHNhbWUgZmxvdyBvY2N1cnMgd2hlbiB0aGUgc3lzdGVtDQo+PiByZXN1
bWVzLg0KPj4NCj4+IENvbW1hbmQgdG8gdGVzdCBob3N0IGluaXRpYXRlZCB3YWtldXAgYWZ0ZXIg
NjAgc2Vjb25kcyBzdWRvIHJ0Y3dha2UgLW0NCj4+IG1lbSAtcyA2MA0KPj4NCj4+IGRtZXNnIGxv
ZyAodGVzdGVkIG9uIFdoYWxlIFBlYWsyIG9uIFBhbnRoZXIgTGFrZSBwbGF0Zm9ybSkgT24gc3lz
dGVtDQo+PiBzdXNwZW5kOg0KPj4gW0ZyaSBKdWwgMjUgMTE6MDU6MzcgMjAyNV0gQmx1ZXRvb3Ro
OiBoY2kwOiBkZXZpY2UgZW50ZXJlZCBpbnRvIGQzDQo+PiBzdGF0ZSBmcm9tIGQwIGluIDgwIHVz
DQo+Pg0KPj4gT24gc3lzdGVtIHJlc3VtZToNCj4+IFtGcmkgSnVsIDI1IDExOjA2OjM2IDIwMjVd
IEJsdWV0b290aDogaGNpMDogZGV2aWNlIGVudGVyZWQgaW50byBkMA0KPj4gc3RhdGUgZnJvbSBk
MyBpbiA3MTE3IHVzDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhbmRyYXNoZWthciBEZXZlZ293
ZGENCj4+IDxjaGFuZHJhc2hla2FyLmRldmVnb3dkYUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gY2hhbmdlcyBpbiB2
NjoNCj4+ICAgICAgIC0gcy9kZWx0YS9kZWx0YV91cy9nDQo+PiAgICAgICAtIHMvQ09ORklHX1BN
L0NPTkZJR19QTV9TTEVFUC9nDQo+PiAgICAgICAtIHVzZSBwbV9zbGVlcF9wcigpL3BtX3N0cigp
IHRvIGF2b2lkICNpZmRlZnMNCj4+ICAgICAgIC0gcmVtb3ZlIHRoZSBjb2RlIHRvIHNldCBwZXJz
aXN0YW5jZSBtb2RlIGFzIGl0cyBub3QgcmVsZXZhbnQgdG8NCj4+IHRoaXMgcGF0Y2gNCj4+DQo+
PiBjaGFuZ2VzIGluIHY1Og0KPj4gICAgICAgLSByZWZhY3RvciBfc3VzcGVuZCgpIC8gX3Jlc3Vt
ZSgpIHRvIHNldCB0aGUgRDNIT1QvRDNDT0xEIGJhc2VkIG9uDQo+cG93ZXINCj4+ICAgICAgICAg
ZXZlbnQNCj4+ICAgICAgIC0gcmVtb3ZlIFNJTVBMRV9ERVZfUE1fT1BTIGFuZCBkZWZpbmUgdGhl
IHJlcXVpcmVkIHBtX29wcyBjYWxsYmFjaw0KPj4gICAgICAgICBmdW5jdGlvbnMNCj4+DQo+PiBj
aGFuZ2VzIGluIHY0Og0KPj4gICAgICAgLSBNb3ZlZCBkb2N1bWVudCBhbmQgc2VjdGlvbiBkZXRh
aWxzIGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlIGFzDQo+Y29tbWVudCBpbiBjb2RlLg0KPj4NCj4+
IGNoYW5nZXMgaW4gdjM6DQo+PiAgICAgICAtIENvcnJlY3RlZCB0aGUgdHlwbydzDQo+PiAgICAg
ICAtIFVwZGF0ZWQgdGhlIENDIGxpc3QgYXMgc3VnZ2VzdGVkLg0KPj4gICAgICAgLSBDb3JyZWN0
ZWQgdGhlIGZvcm1hdCBzcGVjaWZpZXJzIGluIHRoZSBsb2dzLg0KPj4NCj4+IGNoYW5nZXMgaW4g
djI6DQo+PiAgICAgICAtIFVwZGF0ZWQgdGhlIGNvbW1pdCBtZXNzYWdlIHdpdGggdGVzdCBzdGVw
cyBhbmQgbG9ncy4NCj4+ICAgICAgIC0gQWRkZWQgbG9ncyB0byBpbmNsdWRlIHRoZSB0aW1lb3V0
IG1lc3NhZ2UuDQo+PiAgICAgICAtIEZpeGVkIGEgcG90ZW50aWFsIHJhY2UgY29uZGl0aW9uIGR1
cmluZyBzdXNwZW5kIGFuZCByZXN1bWUuDQo+Pg0KPj4gICBkcml2ZXJzL2JsdWV0b290aC9idGlu
dGVsX3BjaWUuYyB8IDkwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWxfcGNpZS5jDQo+PiBpbmRleCA2ZTdiYmJkMzUyNzkuLmM0MTk1MjE0OTNmZSAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiArKysgYi9kcml2ZXJz
L2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gQEAgLTI1NzMsMTEgKzI1NzMsMTAxIEBAIHN0
YXRpYyB2b2lkIGJ0aW50ZWxfcGNpZV9jb3JlZHVtcChzdHJ1Y3QgZGV2aWNlDQo+KmRldikNCj4+
ICAgfQ0KPj4gICAjZW5kaWYNCj4+DQo+PiArI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPj4gK3N0
YXRpYyBpbnQgYnRpbnRlbF9wY2llX3N1c3BlbmRfbGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHBt
X21lc3NhZ2VfdA0KPj4gK21lc2cpIHsNCj4+ICsJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19w
Y2lfZGV2KGRldik7DQo+PiArCXN0cnVjdCBidGludGVsX3BjaWVfZGF0YSAqZGF0YTsNCj4+ICsJ
a3RpbWVfdCBzdGFydDsNCj4+ICsJdTMyIGR4c3RhdGU7DQo+PiArCXM2NCBkZWx0YV91czsNCj4+
ICsJaW50IGVycjsNCj4+ICsNCj4+ICsJZGF0YSA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4+
ICsNCj4+ICsJZHhzdGF0ZSA9IChtZXNnLmV2ZW50ID09IFBNX0VWRU5UX1NVU1BFTkQgPw0KPj4g
KwkJICAgQlRJTlRFTF9QQ0lFX1NUQVRFX0QzX0hPVCA6DQo+QlRJTlRFTF9QQ0lFX1NUQVRFX0Qz
X0NPTEQpOw0KPg0KPkkgYmVsaWV2ZSB0aGUgYnJhY2tldHMgYXJlIHVuY29tbW9uLiBZb3UgYWN0
dWFsbHkgY2FuIGxlYXZlIGl0IG91dCwgb3IsIGlmDQo+YnJhY2tldHMgbmVlZCB0byBiZSB1c2Vk
LCBvbmx5IHN1cnJvdW5kIHRoZSBjb25kaXRpb24uDQo+DQo+PiArDQo+PiArCWRhdGEtPmdwMF9y
ZWNlaXZlZCA9IGZhbHNlOw0KPj4gKw0KPj4gKwlzdGFydCA9IGt0aW1lX2dldCgpOw0KPj4gKw0K
Pj4gKwkvKiBSZWZlcjogNi40LjExLjcgLT4gUGxhdGZvcm0gcG93ZXIgbWFuYWdlbWVudCAqLw0K
Pj4gKwlidGludGVsX3BjaWVfd3Jfc2xlZXBfY250cmwoZGF0YSwgZHhzdGF0ZSk7DQo+PiArCWVy
ciA9IHdhaXRfZXZlbnRfdGltZW91dChkYXRhLT5ncDBfd2FpdF9xLCBkYXRhLT5ncDBfcmVjZWl2
ZWQsDQo+PiArDQo+bXNlY3NfdG9famlmZmllcyhCVElOVEVMX0RFRkFVTFRfSU5UUl9USU1FT1VU
X01TKSk7DQo+PiArCWlmIChlcnIgPT0gMCkgew0KPj4gKwkJYnRfZGV2X2VycihkYXRhLT5oZGV2
LCAiVGltZW91dCAoJXUgbXMpIG9uIGFsaXZlIGludGVycnVwdA0KPmZvciBEMyBlbnRyeSIsDQo+
PiArCQkJCUJUSU5URUxfREVGQVVMVF9JTlRSX1RJTUVPVVRfTVMpOw0KPj4gKwkJcmV0dXJuIC1F
QlVTWTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlkZWx0YV91cyA9IGt0aW1lX3RvX25zKGt0aW1lX2dl
dCgpIC0gc3RhcnQpIC8gMTAwMDsNCj4+ICsJYnRfZGV2X2luZm8oZGF0YS0+aGRldiwgImRldmlj
ZSBlbnRlcmVkIGludG8gZDMgc3RhdGUgZnJvbSBkMCBpbiAlbGxkDQo+dXMiLA0KPj4gKwkJICAg
IGRlbHRhX3VzKTsNCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQg
YnRpbnRlbF9wY2llX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+PiArCXJldHVybiBi
dGludGVsX3BjaWVfc3VzcGVuZF9sYXRlKGRldiwgUE1TR19TVVNQRU5EKTsgfQ0KPj4gKw0KPj4g
K3N0YXRpYyBpbnQgYnRpbnRlbF9wY2llX2hpYmVybmF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpIHsN
Cj4+ICsJcmV0dXJuIGJ0aW50ZWxfcGNpZV9zdXNwZW5kX2xhdGUoZGV2LCBQTVNHX0hJQkVSTkFU
RSk7IH0NCj4+ICsNCj4+ICtzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9mcmVlemUoc3RydWN0IGRl
dmljZSAqZGV2KSB7DQo+PiArCXJldHVybiBidGludGVsX3BjaWVfc3VzcGVuZF9sYXRlKGRldiwg
UE1TR19GUkVFWkUpOyB9DQo+PiArDQo+PiArc3RhdGljIGludCBidGludGVsX3BjaWVfcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmRldikgew0KPj4gKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3Bj
aV9kZXYoZGV2KTsNCj4+ICsJc3RydWN0IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhOw0KPj4gKwlr
dGltZV90IHN0YXJ0Ow0KPj4gKwlpbnQgZXJyOw0KPj4gKwlzNjQgZGVsdGFfdXM7DQo+PiArDQo+
PiArCWRhdGEgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7DQo+PiArCWRhdGEtPmdwMF9yZWNlaXZl
ZCA9IGZhbHNlOw0KPj4gKw0KPj4gKwlzdGFydCA9IGt0aW1lX2dldCgpOw0KPj4gKw0KPj4gKwkv
KiBSZWZlcjogNi40LjExLjcgLT4gUGxhdGZvcm0gcG93ZXIgbWFuYWdlbWVudCAqLw0KPj4gKwli
dGludGVsX3BjaWVfd3Jfc2xlZXBfY250cmwoZGF0YSwgQlRJTlRFTF9QQ0lFX1NUQVRFX0QwKTsN
Cj4+ICsJZXJyID0gd2FpdF9ldmVudF90aW1lb3V0KGRhdGEtPmdwMF93YWl0X3EsIGRhdGEtPmdw
MF9yZWNlaXZlZCwNCj4+ICsNCj5tc2Vjc190b19qaWZmaWVzKEJUSU5URUxfREVGQVVMVF9JTlRS
X1RJTUVPVVRfTVMpKTsNCj4+ICsJaWYgKGVyciA9PSAwKSB7DQo+PiArCQlidF9kZXZfZXJyKGRh
dGEtPmhkZXYsICJUaW1lb3V0ICgldSBtcykgb24gYWxpdmUgaW50ZXJydXB0DQo+Zm9yIEQwIGVu
dHJ5IiwNCj4+ICsJCQkJQlRJTlRFTF9ERUZBVUxUX0lOVFJfVElNRU9VVF9NUyk7DQo+PiArCQly
ZXR1cm4gLUVCVVNZOw0KPj4gKwl9DQo+PiArDQo+PiArCWRlbHRhX3VzID0ga3RpbWVfdG9fbnMo
a3RpbWVfZ2V0KCkgLSBzdGFydCkgLyAxMDAwOw0KPj4gKwlidF9kZXZfaW5mbyhkYXRhLT5oZGV2
LCAiZGV2aWNlIGVudGVyZWQgaW50byBkMCBzdGF0ZSBmcm9tIGQzIGluICVsbGQNCj51cyIsDQo+
PiArCQkgICAgZGVsdGFfdXMpOw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArY29u
c3Qgc3RydWN0IGRldl9wbV9vcHMgYnRpbnRlbF9wY2llX3BtX29wcyA9IHsNCj4+ICsJLnN1c3Bl
bmQgPSBwbV9zbGVlcF9wdHIoYnRpbnRlbF9wY2llX3N1c3BlbmQpLA0KPj4gKwkucmVzdW1lID0g
cG1fc2xlZXBfcHRyKGJ0aW50ZWxfcGNpZV9yZXN1bWUpLA0KPj4gKwkuZnJlZXplID0gcG1fc2xl
ZXBfcHRyKGJ0aW50ZWxfcGNpZV9mcmVlemUpLA0KPj4gKwkudGhhdyA9IHBtX3NsZWVwX3B0cihi
dGludGVsX3BjaWVfcmVzdW1lKSwNCj4+ICsJLnBvd2Vyb2ZmID0gcG1fc2xlZXBfcHRyKGJ0aW50
ZWxfcGNpZV9oaWJlcm5hdGUpLA0KPj4gKwkucmVzdG9yZSA9IHBtX3NsZWVwX3B0cihidGludGVs
X3BjaWVfcmVzdW1lKSwNCj4+ICt9Ow0KPj4gKyNlbmRpZg0KPj4gKw0KPj4gICBzdGF0aWMgc3Ry
dWN0IHBjaV9kcml2ZXIgYnRpbnRlbF9wY2llX2RyaXZlciA9IHsNCj4+ICAgCS5uYW1lID0gS0JV
SUxEX01PRE5BTUUsDQo+PiAgIAkuaWRfdGFibGUgPSBidGludGVsX3BjaWVfdGFibGUsDQo+PiAg
IAkucHJvYmUgPSBidGludGVsX3BjaWVfcHJvYmUsDQo+PiAgIAkucmVtb3ZlID0gYnRpbnRlbF9w
Y2llX3JlbW92ZSwNCj4+ICsJLmRyaXZlci5wbSA9IHBtX3B0cigmYnRpbnRlbF9wY2llX3BtX29w
cyksDQo+PiAgICNpZmRlZiBDT05GSUdfREVWX0NPUkVEVU1QDQo+PiAgIAkuZHJpdmVyLmNvcmVk
dW1wID0gYnRpbnRlbF9wY2llX2NvcmVkdW1wDQo+PiAgICNlbmRpZg0KPg0KPldpdGggdGhlIGFi
b3ZlIGNvbW1lbnQgZml4ZWQsIHBsZWFzZSBmZWVsIGZyZWUgdG8gYWRkOg0KPg0KPlJldmlld2Vk
LWJ5OiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KQWNrLg0KDQo+DQo+DQo+
S2luZCByZWdhcmRzLA0KPg0KPlBhdWwNCg0KVGhhbmtzLA0KS2lyYW4NCg0K

