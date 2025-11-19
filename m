Return-Path: <linux-pci+bounces-41700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A8C71730
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 00:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 954C534741E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360322D9EEA;
	Wed, 19 Nov 2025 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9UjBIZe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C42D46B4;
	Wed, 19 Nov 2025 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763595279; cv=fail; b=diYJ/7emoqnx0DXORklVANJOGB9y9O1ASiYQmxbpZeuObokFKn42Q1fNOOT53+Xeez5F0MA3Sryb4hNTc5lMDcR/AaHzeCBXKvWVenknZqm3nsDU6mWHR/oE56+GhRRzRI5/a1DLrVeNs5SnN17P4dCC2zAjRF0LmJO1KZZ0Ki0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763595279; c=relaxed/simple;
	bh=NhOBld4NzlvP6xkCcQs7mEuC7c5yjFvO+73PLl2kIM4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=MGscKaqLUxeZgdMmoPyXCAGbq3E1QgZdfstwKPKVGECZF6qq8PLC5Udttyk9a+7806WZK8zA3auS32i06EHFdT33i0ZN81FEv+NfLXlReNg2Ed4cu3Gf4DZcCsQssrURirgBGAVjMeOF7BDKGQmVcEAz81fCXHOUJ9aalyP2UpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9UjBIZe; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763595277; x=1795131277;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=NhOBld4NzlvP6xkCcQs7mEuC7c5yjFvO+73PLl2kIM4=;
  b=U9UjBIZejb6l7Ppia/vyz39VtZ/Ui+MklMWHmEDYVUdsuFiCldjyoS5H
   LU11yk4VQTbgiDvC7SdUW+SBrR23Iguazw9dDMGaXGG62Dv2ZJnaGiSZ8
   IMbMivOch6w/7Uy/wZiPi49h1kFg4OvfBUsjlJyMDA0CDpnnpz1q7PdYN
   Et0uvszFQnMZ1aQrFgjjj73D9GnB4+NIwydnjIdBeZbg8JK+piym8rz/b
   AcLFDpGR1KYJsumMS+3rGvw2ra8Um5ulcIwVwD7g/I3w4d5Yd3Ud1fZIr
   w6Yv31I4b4P8ult2wkMN5I5FS/FsGVbZnvSahkx+t7VCGvGtCQ2Bq1jok
   Q==;
X-CSE-ConnectionGUID: t929tBM7SJitXJ05sx1z/g==
X-CSE-MsgGUID: z1PzoAbnT6idh5Y1ZqMv6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64659294"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="64659294"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 15:34:36 -0800
X-CSE-ConnectionGUID: +6/vOJ6US6uFpLn0B/Lp/Q==
X-CSE-MsgGUID: 6umedpAhSJWpdR8Z6kALYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="191632166"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 15:34:36 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 15:34:35 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 15:34:35 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 15:34:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIdyH+6GVKCVt3vZtH2e45lwBw0KwqjnZHTyAB8hTx5koDI83mbHL1MBz6yAmrPBQZCzLRKSPr45CLfUfmYcBZph39dp/ad3/VluxFBpC0+S+4VJ9aQVagYg3Pvw0RcMNlrJTgbjFWK6qGZSlnlcxdVyNHkgk29SckmCjc4cnZil6Hdpo1s+jGOHTOulXcS8Y4hnzDghJlTgOy7XBqKtTDFGrw3Zwnz4MtIE1gzVG38sHOMAOomRQyblDjiFxz/T39INPQN880vKoDEQocFCiiPP0LS0uvQMOCBT8Piz/BkNT9R2NaN5U5jFUySuRQdQENnG7M6LdDGyyUMYL/IceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGxNyRnn2fjENroz8h7Pki7bvEMo2zvdFXJ3W7tB6Hc=;
 b=D+nKtnUKew/xNSS14MLGceNaoib4112ZG/AixPWJEoC3zIKOrqNVJJN7hIw5zKPCXEna8OwPC973dfF8ZxZ9KfkzqaMHUOIuYrJEScHkGXseEDkAkXi/iwdgFm3mhwX1Q8zBtd5n2Fx8/xIVNtnV69A6m/gzk2A+LHv8teYvnut3DRID0Rh8tdgX/Df/Q+q0/59DqAD17o8JoFGFaRXyJedZh3oLkpAHA+kS0bI0i9WZcqYRiuCoBN/BQhY6AwrAImiYsHjiiuv3YmpF9pgGUJ5TxPlatDXl2FZVRRSEXmvddBbjSKm+Wma/T3lGMtnjQkm0yaXutC56eOb5TOHshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7380.namprd11.prod.outlook.com (2603:10b6:208:430::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 23:34:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 23:34:32 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 15:34:30 -0800
To: "Bowman, Terry" <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <691e5406e9b35_1aaf4100c4@dwillia2-mobl4.notmuch>
In-Reply-To: <930fcd64-92b2-462c-8301-6c753f41c498@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-3-terry.bowman@amd.com>
 <691d375d78bd8_1a37510040@dwillia2-mobl4.notmuch>
 <930fcd64-92b2-462c-8301-6c753f41c498@amd.com>
Subject: Re: [RESEND v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: d5045d5c-4308-49d9-ee79-08de27c43139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGRPTFF6b0ltMkxJRWNwMDRlbVprYjBkTEs1UWJoQ1JMK3hJWjBnQWRlMldZ?=
 =?utf-8?B?aHpLRzN6L01haG5leGhqTGcrcCtXdjQ3cmRDcWZpZnZxeVdnWGV3UWJ3Sk16?=
 =?utf-8?B?bkI4VGVKNHNWWTU4Q1E0T2VmeEtkcU85Y3Fza3lqSC9OTlhXRU1oUW10dmp6?=
 =?utf-8?B?R05ISzNBNDJQMEZqd3pkb0dEdnhBdFNpRmVtRXZYOUlpL01aUGJqQ25NV2RB?=
 =?utf-8?B?aHhOVjhEeHpxa05ISFNTQ0RlUHFmUGk1dTQ3ZzZhcVIrV3BWYjB3UlowR0VM?=
 =?utf-8?B?eFdqS055bzkwT2o0NHhzUExTMHlFUlBoVzk1Y2pEVS9JZ2FZa2M4Q2xJdURq?=
 =?utf-8?B?N1hSKzgrdy9ENkpFN2d3cHo5SDBmYVkwNTR3bjZ3azJucjFuMzVzaVNGVEtR?=
 =?utf-8?B?WFA4aUxRSUwvS3prSGhxc2hRc3hSREJiSDg1bWp4U2tEQmIzd3hBWHdJeGRC?=
 =?utf-8?B?RCtsY2tHa2t5VWFUZlkyUHE4ZTYxSW9vTGd4b3FTRzEySjlkb2tKbjZiZmJN?=
 =?utf-8?B?VERnZ2ZpMERDM3ZxeS9qM2owY1FlVUdRVGtoVXF6YUZ5cTlpRURQY2orYkdD?=
 =?utf-8?B?MHgxNzJWUXUxdWRGWHNXQ1p1MExsZERGZDBXc0ZSRFVvUGlNSUNObnFUcGJa?=
 =?utf-8?B?T3QrWi9paEU5cWVCZUUyTFhXNjcyVGZIZFhjdnlsanV4UmFWZUdlS05ocUlR?=
 =?utf-8?B?elBiRS9XN1EvNFZ5cnlicVVSUUR6MmVyRWphVHpYWjdGY0pGeFdvbHFRL1ow?=
 =?utf-8?B?OHoreUx4TTRSZGVWTkVvalhpMnRXcmFkYXpucm9TcWQ3eTJHS3Z0Y1M4N1Fj?=
 =?utf-8?B?T2tsTVRjbnB6ck9GYmltK3JhbmhOVGN0QjZEYXBQSVE1aCt0bUVhT3loNjVK?=
 =?utf-8?B?d2tNVzZhd1BVK2ZJcUJuRDdXZkVJU05XdkxLZG9rRDlMQkYyRk1rQS84SE9I?=
 =?utf-8?B?LzcrTHg0cEZPZlFTd1JsM3plNHVmUUFJWUpPMEpYYUZFaFJZenVpNDhLWmdl?=
 =?utf-8?B?MFlJNkZ6N2VoWkxuZUNWdWlpWUNQbnNNa1QzaUtiUVI3RFZCTE9BY3NTM29o?=
 =?utf-8?B?YjQ2UUpuQnUydytzWGtSRHJISU4wT0dJVkt4MUFtbVRuU1NCRjMzc2JFbkFT?=
 =?utf-8?B?b0VtUngwNjI0YmZxbWFCQ1E1T2FwWkpGV1lBN0h1T0NuMXI5YTRLRGthTlpW?=
 =?utf-8?B?dVVMSzZjUm4wYUdOQk9laTlaRkFVR3psRUFjTHV5aGF0UGdEOENQNVI4N1I1?=
 =?utf-8?B?MnFmN0QvTlVpZFQwY0krS1lVeWVaMXdScnAvekxGQXRnN2R2TmxIaENoMkJK?=
 =?utf-8?B?WlpyaTZTZ0tQYmdHelVJQVVoQzQvQUZaemNodDEwMmJEVjdRYTBXOTNXTzAy?=
 =?utf-8?B?d0IxdXVzRWFNaXlMOVJ6OUZLdzd4NlNKQmVYOGlvNnpkM3poNm1keWtkVm1J?=
 =?utf-8?B?elhxYjlNK3VPNXVwdmJkSDhQVG83VnBFUVZ6MDVyVDBISEtQcVpxRHNLMXZ0?=
 =?utf-8?B?Wk9yVStWY250Z3d2OE5QSEUxdmpiUGNTalNMaGcrTklHNVhDRGJDR2wydUV0?=
 =?utf-8?B?aGtEbFdCaFJLcGdlenBQVWF2Tlk0RVJJSG9TL0RKaUpDdlVoRy83bHgzdC9B?=
 =?utf-8?B?YzROdGxTT0Y4a0dxYVcrNHpYUXE1VG1UcUsrUmlxMHF2OER5U3N3emlWcjBK?=
 =?utf-8?B?dGs5K2ZoSG13c2xSYVhxNTIxQUpTZVpwcWdacEZRMlFzVEdzS2NHdEJPRUpM?=
 =?utf-8?B?ZkdxNnZwekN0SEY5ejJzVi94M0pBYmlQSEpNZkNmc2VwcUN5S2Z1RVRXVXZa?=
 =?utf-8?B?YXRtVkVMTjJacU9JSkY4R0lwY1gwYzdXcGZPeEFGY3ArTE9iQ2w4OGFwMDRI?=
 =?utf-8?B?K3RybmtVSnNmZVp5NVRRa1ZLVXV0KytqMEV2UVlRM1R4K0xJV3FHRnUzUExl?=
 =?utf-8?B?Q2M5bnhPM2tOVWNyRmRucU9ReTNXVTVacXhpK21zZnNRem9ReE9pcUVJNzRQ?=
 =?utf-8?B?SC9EeGhyTW1uMmlFb2Y5bGhjNFQvTms2c1A2b3JXNHJoS00vMzQ2ZnBjUGJK?=
 =?utf-8?Q?JUQt7B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHZBNjN6bWdJMFNPTDhCTXVvcTg4UEJGNWpMM002amN3VkxVNnJ3T2lJdzlD?=
 =?utf-8?B?MFQyR3BicjdnTWxVdjhRQ0IyOHhRcVN1TnBZNEIrdlNIVWJjOXBSQ1FrOHJu?=
 =?utf-8?B?b2FiaW9tekVXWXJDdHBqQ3BqZGRWTUpOVUV3M0dGeHp6WkF0SUpiOXJ5TEs1?=
 =?utf-8?B?ZHdnQ0gvVEh3eFpZSnBoN3hMTlJZVjVtMTRJT2tXTlJ2ektiZHl1aE5oQ0RC?=
 =?utf-8?B?OXFsSURJUnRjZkVCdU5xYktMTDYwL2ZOWnU3RzVFeFEyVnV1RHl1KzJQWXNl?=
 =?utf-8?B?eTc4blc0TERIbGdjR1F0Z2srenlrTmIxMkZFNmJhNkpTdzU5c3JWRVNRampR?=
 =?utf-8?B?NktnR3Y1Y1FZRmdyVGpCeW1INXl5ZlBDNk9xcStyNXRhTnhFa0JwRG1mMDdx?=
 =?utf-8?B?VEkrN0ZHbWtGWkE4OGJUYUh6S2Y3VUxqR3E0dU5oelZjYlZwZExyYTNFeWF3?=
 =?utf-8?B?RHFGbU1LNjlLdVdVMk9EUk85WXVZUkdHeUh5Uk90aE5POHJ6Rnc5ZkN0UHFO?=
 =?utf-8?B?dXFmZmZJTW02ZjFSaVYvWU43dEh1blJuMjhCdEhDUVVHQ1pEVnJtMUJJWFp2?=
 =?utf-8?B?djZsNjlGbmthOGtQYTNTbWF6MUlmQ1R1ZC9WNkxzYTMwQzJiZDVpQzdQVlJn?=
 =?utf-8?B?a3c1UTJjNTIvalhsRDltMzQzTEg2bXdrZFVQMG9jRm1TYUNBZzlXeVJ4NlQ1?=
 =?utf-8?B?LzlBNTQrYi9rZ0dQSGJLbnNjU0Y4UUVHcXRsbjdZdHEzdWJSSUhQYThwQk9Y?=
 =?utf-8?B?dTlSajJBZ2JsN3FWSUVJRjVYV1I4MW1PeTAyNURWa3pHQVQ1d0htUGxkWG0v?=
 =?utf-8?B?OXVUY3NnVkZ4V0hSTnl0b0dSU3Bub1VxWmpacDFtaHg5Vi9KcytsdzNXM2Vh?=
 =?utf-8?B?cTJZSjlHM1daeHlnNGdCaVl0NS9jSlhuNHlydXJFTjBHaUpZV2FZT01mU0JW?=
 =?utf-8?B?NWF0Zi93R1NYakFQTVZ0MmNiY0t6QXFNQzhOVnJPczR6NGlTL3VtZG5jZVRB?=
 =?utf-8?B?TC9nOUprbGl3ZlROZ2drQ21Ra1BqbEFuWDlIYStYOWh4RE5RKzFDamxVSkFW?=
 =?utf-8?B?TjBMeVlERndiTDUraG1xYmgxYzBUazVNbnI5a2ExRGhZYlErZXA0K3ZneklT?=
 =?utf-8?B?LzdHeElWVzd2VVJBcUFTM1RNL3RDaE5OQTFOZTYzZUdJMGFoVHhoNW5ycWF1?=
 =?utf-8?B?V2JraGpQTGh6ZCszQWpOMXF4ZUFXaHM2eXVzdEN5Yk5oNmdSdzg2M3ppVEhD?=
 =?utf-8?B?OHMxZ1BJZlJLV2xvZDdsQUdRNlhsNVYwY1d3Njl2ZkpmNjcwRTJUdXFTMUhJ?=
 =?utf-8?B?aUt4dXlDbzR4TlJNMS9QcG0weFVMM0tLd09DRWVkUVdwUC9BUjdIeHV1d2RX?=
 =?utf-8?B?V3I4RjFNQlNza1hqUWthekR2cXNVMG1SL0drak9qcURXbXRDaG5uRlU3Nmlv?=
 =?utf-8?B?SHdBSUQrQ1YrQmNHUGQ5K0VaWi9HY3hXY2E4TUtRMUVwN2dncktGN0t1ZTJp?=
 =?utf-8?B?SHE1bk44MzhXNk9Ob01ITE1TczB0MFdxSFovUmdDelZGWVBCdDA3VkV4STFE?=
 =?utf-8?B?dW9TdS9qdlF2L056UndjWDhIOGtGUGxMUW8wSU5EQ05oV3hLeERWRTVXS244?=
 =?utf-8?B?a0dKdG0wSlRkdVNUQ2ViVDloK1BxekNFcWhHNThjM1hPVFEzMTNJeExaUFpj?=
 =?utf-8?B?ejlDYmhZZ01XQmwrRmQ3ZFFnWm9XbFBZcThienhVNUorNHRxMjVYbUIwQ1lq?=
 =?utf-8?B?U2IyMXEyVkordG55QXFwQnBxVnRjUk9Kamd5d1oveE9reUg4SllrOGhKUGRC?=
 =?utf-8?B?UHY3QVY5VWh3SU4xbHRkMURlTHVtWnA5UkdwSW1hcC9pOTZWRjByajRTa2N5?=
 =?utf-8?B?MlNmcmIxTHJteStTS0tQN3RSbTJzUjdlTlc3VXNYSTZjN2praTFEcmVEY0F3?=
 =?utf-8?B?djdIYmpYL3FlSSsyUzBsSEo2L1RMbWRzQm9mSUtxTXo4SFgrOEc4K3N3RHpT?=
 =?utf-8?B?M3dKQ2l5N1l6TGQ0TzVmOHpONG5LVkE0VHpmRTMzaXQrWWdkYlpTR2hDRG1n?=
 =?utf-8?B?cmV3NVF6bW9ERGFPNHg2U2xzcFE2WXRHYjFhMFVpcmh2NzFmWFJWYnQ3VW4y?=
 =?utf-8?B?ZkFWTG5PTmU5KytpZ0h4aTIwdTVyT1Uzbm9RdjUvQkw0aFE5dGNxZUFMWlRz?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5045d5c-4308-49d9-ee79-08de27c43139
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 23:34:32.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAHKokQHpCuEp9d72UWJITpz8DH7ITNLBWCITXA6hcoSxuLZsN3cqRawOAa3Lo2BFktJmHB/zF2pf8RnhTFcdEYWXvTfWfi1xqPn1yzuh3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7380
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
>=20
>=20
> On 11/18/2025 9:19 PM, dan.j.williams@intel.com wrote:
> > Terry Bowman wrote:
> >> CXL and AER drivers need the ability to identify CXL devices.
> >>
> >> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> >> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
> >> presence is used because it is required for all the CXL PCIe devices.[=
1]
> >>
> >> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> >> CXL.cache and CXl.mem status.
> >>
> >> In the case the device is an EP or USP, call set_pcie_cxl() on behalf =
of
> >> the parent downstream device. Once a device is created there is
> >> possibilty the parent training or CXL state was updated as well. This
> >> will make certain the correct parent CXL state is cached.
> >>
> >> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
> >>
> >> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
> >>     Capability (DVSEC) ID Assignment, Table 8-2
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@li=
nux.intel.com>
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> >>
> >> ---
> >>
> >> Changes in v12->v13:
> >> - Add Ben's "reviewed-by"
> >>
> >> Changes in v11->v12:
> >> - Add review-by for Alejandro
> >> - Add comment in set_pcie_cxl() explaining why updating parent status.
> >>
> >> Changes in v10->v11:
> >> - Amend set_pcie_cxl() to check for Upstream Port's and EP's parent
> >>   downstream port by calling set_pcie_cxl(). (Dan)
> >> - Retitle patch: 'Add' -> 'Introduce'
> >> - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
> > [..]
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 0ce98e18b5a8..63124651f865 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -1709,6 +1709,33 @@ static void set_pcie_thunderbolt(struct pci_dev=
 *dev)
> >>  		dev->is_thunderbolt =3D 1;
> >>  }
> >> =20
> >> +static void set_pcie_cxl(struct pci_dev *dev)
> >> +{
> >> +	struct pci_dev *parent;
> >> +	u16 dvsec =3D pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> >> +					      PCI_DVSEC_CXL_FLEXBUS_PORT);
> >> +	if (dvsec) {
> >> +		u16 cap;
> >> +
> >> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFS=
ET, &cap);
> >> +
> >> +		dev->is_cxl =3D FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, =
cap) ||
> >> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);
> >> +	}
> >> +
> >> +	if (!pci_is_pcie(dev) ||
> >> +	    !(pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ENDPOINT ||
> >> +	      pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_UPSTREAM))
> >> +		return;
> > Why are downstream ports excluded?
> I thought we only need to check the upstream 'parent' if dev is an EP=C2=
=A0
> or USP as those are the only PCIe types in CXL that interface directly=C2=
=A0
> to the upstream dport device.

Yes, but in all cases the device upstream of an endpoint or an upstream
port is a PCI_EXP_TYPE_ROOT_PORT or PCI_EXP_TYPE_DOWNSTREAM device. So I
do not understand why this function needs to make any exclusions.

> And its the upstream dport device that must=C2=A0 be checked to ensure it
> has the correct is_cxl setting.

...but it will never have the correct is_cxl setting because that 'if
()' statement precludes the update.

> Do I need to update is_cxl for USP in the case of DSP-USP topology?=C2=A0

I think the only change needed is drop that early return 'if ()'
statement altogether.=

