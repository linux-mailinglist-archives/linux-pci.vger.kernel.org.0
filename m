Return-Path: <linux-pci+bounces-23390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD702A5A9FE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 23:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED251891447
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11811E8359;
	Mon, 10 Mar 2025 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAi4zCTh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A640BF5
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741647473; cv=fail; b=EOpaFLPyewBAn4GotdH0OtSNlN1/Gf9NDYF/wbV6MM/qo0CzRBYfF7yBQ10pe1fP5hmcKaEPs803W/mzHMt/8fhwfJ9F6/d3G1nxRlrY0H600crJ4LlM9ny84F7G06h/Cpq9ZA/B+2OWMxEuJgqWgNF3SkH5D5cdU8pzdqYzXQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741647473; c=relaxed/simple;
	bh=ik4AXkgVfH5w1qZSTbpD6oKSM3nYSTg/9QB3gnyl8xs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTEI8Ic2Ft2SZJxnPgDAdlKoxdmOzPV/aKlKM2CEA/YE+Kj9t9hp3k/ul86UEe5L+7kvHeK1qDGXvmaeRBWxGyx/bEZBpWx1QtYn5JvtC26+OG2UR7p6w4jZ18zftUAY5xlKHVFuCLfpauXziTYAmKB44XgGbDhb0p6yzch4SVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAi4zCTh; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741647471; x=1773183471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ik4AXkgVfH5w1qZSTbpD6oKSM3nYSTg/9QB3gnyl8xs=;
  b=BAi4zCThQM3+zLf9LaGlxA5++c8CnOPyLNklNpWM/CDNxUzjpN7LlGRc
   /M3/0nnq5/qaOWk6YzQ5y9ub0jR9fPrKzUaqozIv/888OTf3UbF47rmSr
   LprF8uoRadi0p4kdMYxMwjYDg4Jy1fi0tp2pViWsN3JpGCl3U97bAj71d
   kwuNt2HcGyKLGQn2g/CNdxuAzGLhk6MZD8tpXI5XNjfq7dvR3r8GnZGN6
   3nHe5lWtEhIwV6a2MGSCzSkCjESGEgJSpHGpjVZjoRQGm3e9LzsT6YXiu
   U5q+awA1qVl8sY0dn8UosjAtUpSn1bt82xSnwdRFbUwOyoMMzcMXr8VHz
   g==;
X-CSE-ConnectionGUID: XgXZj0/WSIyGd/IkV+NrFQ==
X-CSE-MsgGUID: N40AC0GZReuBLDvcUuVGcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41832536"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="41832536"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 15:57:51 -0700
X-CSE-ConnectionGUID: 7+JP+tukT++Nm1xC7xn74w==
X-CSE-MsgGUID: G9ViSnKpTP+3gA19D26gaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="119844574"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 15:57:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 15:57:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 15:57:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 15:57:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPa+OGjlRrM4E2N5UoGWHB4t4bg/hyEWl/kZx6KS4kieXV9dW/qRzDY2ORjB+3TUaUEYgd4hAYxfJGh0qbg1YhcEhm0F/vAgd3XJHCX5Gb7e1sjJSn3ZcbpYV3lz2KZppMb9NzUQyr5gcg1EvZlLKnGhSw0ZmTazZuqIah0Mwc2b8HTxM2J3n5pWJ16pOx2U5Fd05M4s3RD/AlS8o3v3pF+PZj68y7d5+3J9Mo/yNix9IKZ/BSYJWZADFcX0PdXqO+tpX68hP4ttziwXQSXb5c6AdRMMfwSjot7mQFALA19Ue5/KmmNV+39BaTB7gMq1ok8/d/qZoKDffygWDLk0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik4AXkgVfH5w1qZSTbpD6oKSM3nYSTg/9QB3gnyl8xs=;
 b=Gl+FsaCqnba8K9jYhGGRaVNi0mdmnaB6tofijveE+p4hSgJyANdNCctWvqlHv/m0ajfGMMX+vIdQfCfEqJNp9dbkyF2u7FtIxDNAxcbIrVw1xRRVJuMDG7WmbIAVbhlw91LmJxkSMoxfXxsNt++lwiVkO+dFHS6JxWwEf+r0nfQkJd3BBt23q8qDGP2LYLi/Z1ZqNaXxyQFldpO1IGm6prH41HLo6iwdbhXTrrD8XXXvOZejCP030nQseuAjmdWpjE/Z4zZixsI7Pz2Cs7Y0lCPbwStqGC7/j54wKOjqlirsGC7NfTHXItARu2V21GEcCA0i+YCBp1rs80bcI0fKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:57:48 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 22:57:48 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: "sameo@rivosinc.com" <sameo@rivosinc.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "aik@amd.com" <aik@amd.com>, "hao.wu@intel.com"
	<hao.wu@intel.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>
Subject: Re: [PATCH v2 02/11] coco/guest: Move shared guest CC infrastructure
 to drivers/virt/coco/guest/
Thread-Topic: [PATCH v2 02/11] coco/guest: Move shared guest CC infrastructure
 to drivers/virt/coco/guest/
Thread-Index: AQHbjNXvftyE7fhvjUqB4WGZ5WxFKbNtBf2A
Date: Mon, 10 Mar 2025 22:57:47 +0000
Message-ID: <e196f01be3b5e744cd51014fa7a3cf5595a9ef5c.camel@intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
	 <174107246641.1288555.208426916259466774.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174107246641.1288555.208426916259466774.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA0PR11MB8335:EE_
x-ms-office365-filtering-correlation-id: 1b5b773f-7583-4560-6418-08dd6026fa3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TitieUdreC9TTzYzNzNtbkI0NXR3WDZueHJpdm54cklWVVlZajE4T1lKWlNw?=
 =?utf-8?B?YjJKWEZnRXFES21DUFk1cVR0YjdYalRTR3ZiaXo0R3FnMlVyQXpjZHAwck5F?=
 =?utf-8?B?VUxtVG1KQ1RLTGlObDA3MXdFcVRNK1pFRmZOZHh4dUhsY01GSXZjQkZ3WUZ5?=
 =?utf-8?B?NmNZbkY5VkcyUVlIcVlXZUNBQ3hXcUN3d1RRb0hwRUpkNG54Ym41bmpJamRG?=
 =?utf-8?B?c1F4d2tKVUc2Tk93ay85Nm9hcW4wWS9HV2dicUJYekphWkdWY2dKdjFtMWdq?=
 =?utf-8?B?T3dETS92SUZSK293czc2bldaVHlmcVFxRzFWME1iejJFT2dDek5vT1dHYU1m?=
 =?utf-8?B?ZFV2L2lETGZiTUYycGlObW8rR2FIYW5rU2xXYlF0cUVVZm1USngzaE5rcGdu?=
 =?utf-8?B?dVF6NElCR2Z2cVh5eWtranpjUnBENXJBYnhPcndRKzJOUmc5Z0hiMHBSZ25q?=
 =?utf-8?B?ZGprVTBLSSs0ZVQzQWp6THBqb1pFZnRFWGxucDdNT2F4UXo0NDhIY2dsNDZX?=
 =?utf-8?B?NnVwK3drZ2ZHOWNYbEtBY0EwRUV4VmxUUXVUOEdXY0JmNjFsSk5uenduNC83?=
 =?utf-8?B?TnpZYkpHR3N3YWZreGFvUnNubGxyVm83bTdPN1VTWk54V3dVMStrOHFUWDFu?=
 =?utf-8?B?OEoyWUdhcTVJYlpvV2lwdDczZmV3NzQxRHMrTUFWZGZGd05wVWN5WjFjOWRE?=
 =?utf-8?B?SmNsRTlrcXhLOE1vc1AvazQ2cjk3THhsQnBxM0hVRU90RXVscmJXOFhqM0d3?=
 =?utf-8?B?WkZnb1RLb2xBN3lWbGNPL0JuQnZpZTB0ai85Nnk3UThXazFnUkgxU004ZXpW?=
 =?utf-8?B?YXREeDJWb1BjaFVKVFBnWVkzOWVRMDhid2pJejRjN25idlk3NEtBQzFvMG1K?=
 =?utf-8?B?N1VRbUwyWDhhM1U2ZDVHZzNVMVlFZllRcUU3cnU0b04wMDZ2bEVMRWxsVGl1?=
 =?utf-8?B?b0YybWJoZkZ3SUQ1ODdSZzlzL2huWGluOWFsVGlBZUJYcXFqZ1pVVWtCdkRW?=
 =?utf-8?B?ckJndE9vR0JybUN2Wnc0bGdyOGpmRURudnozd1ZuaVA1c3ZxVCtUK3d2bGJ4?=
 =?utf-8?B?YVQ2WUhKOXI2a0t3SUtWekI2QlNJbklhSU13bmljRXl2c1RVdjlUdWs5dkJV?=
 =?utf-8?B?bDRGTCtTVXpPbnFzVmlTSkJ5MTl6anhPQk93cVlQeDBDekg0V0JRNzRqUWo5?=
 =?utf-8?B?NW8ranJsUEZEU0RCQmdDU2dDeVVwbVFrK2hKdWMySHVBQW1XV1NrOWdOR1F0?=
 =?utf-8?B?bjNVcGppY3k4LzV4L3oybFBpUzByRnQ0RlRQdlR3QVlaSG41NEZLdEJ3aTBY?=
 =?utf-8?B?eG9JcnIxUHhRRXFOK29VS1RQTFk1MEFDbTZHQ25GVEJ3UDF3V1JUTGpPZERR?=
 =?utf-8?B?Wm9pcW9CeU1MZlBKT1ROSGhqRi8rbzlHaG9aVHhIRUdpUlhaOG5rWXBsM1Jv?=
 =?utf-8?B?M2ZsOE9UeTJUZUhoRVJlMktWdi9KaWpjNFhDNEJjU09zYXpjSXpHbktLNDJk?=
 =?utf-8?B?MnhSRkh4clUzMy9TZElHbnhaNitueW1EOGNURVBoNXEyRTRNNUt0eW14VXpz?=
 =?utf-8?B?TWhpMkFhZURWRm11d25yM2pkZ1RXdTNFVkhpTVpYdnBIZHgwQTZqZGJndThq?=
 =?utf-8?B?MlVCbTNLZUx0WFlmMW5vcFphVk5ZODkyOTE3cFJ0TDhOdCtySUdYSUdDSGJs?=
 =?utf-8?B?UjVEMEJkNUMyVVZBN3Y5U05jalR3QTZaSmFveUtLdkZOcnNWRVBFbXAxZEQ2?=
 =?utf-8?B?RzJrRjlnNGU3VG4wVWNFVVRLemlwQ3gxTXlhK1M3QlptanFJU01NRmFlMEpZ?=
 =?utf-8?B?ZmIzOEkvYWpGeTJFQ2FWNFNvb2V3K1Y3TStXYXZicGd0QmZDcis3dFFzMzh1?=
 =?utf-8?B?L0VCY2hPQnA0cVNQLzhHZE5VVU5GenJuN2pvWjlJb2pUWEprV2syclViWFA3?=
 =?utf-8?Q?KPPkKXrD5KtJczZxasIXi80bS7N3iNhw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXhWTURZRW55aCttTTg1NDVUdmh0TzVBMXIwbFpjUEE3RzBpWWZnSHNac3pZ?=
 =?utf-8?B?SkpxNFpnV1oza3ZIRnhkUTVGVjRtRitGTktTMFR4cTBiRGpRa1BUQVZ6ai9v?=
 =?utf-8?B?MVhBdkNCT3NwaDZPcCtsU1pSMFd1eGVhTG1SME1NbkhtRmp1SkVJWG1oNUNZ?=
 =?utf-8?B?Y3g4MC8ySHR3TWJTaTEydWF5UGJOcmZLakdBVFkyRzg2WkhVV3VOQy9QV2ZC?=
 =?utf-8?B?cWo3emtGcDZXQjVqbTQyQU9jdi9yRTlvUE8wYWZ0TzBoMjYyR01ISDVXOXRF?=
 =?utf-8?B?V1ZVUURMZUVqNEF2QVgvaDU1djJGVlVBV2J5azBiRzF1V21YdmJlTG9DdFI5?=
 =?utf-8?B?K1c2RUY2T2hYVjR2dzNyYUNtajN2V0hDQkF4WURweTFMK3V4d2FDM0tUZ3BT?=
 =?utf-8?B?a0dBQ3VxVnVjMTZWdTFvWllWTXZoZTZHYUVFTUVaM3hmNlAxQnBmOG9rSkxn?=
 =?utf-8?B?WHFsZml0MGRXV1FMWFBhcGxhMzUza2xoK0lyd0l4RHJhNG1pdjErTHo4WW9D?=
 =?utf-8?B?OXZNVTBYMkhYZG9jOTJCd2xBZUFxR1FlOGRlaWllZ0xleURGTnBaSkxubmtY?=
 =?utf-8?B?SGUzTi9DZ3M1Wnc2dmsyYzhYK0l2SmlITjNJQlQxTzdtOFN3dHlDQjNsMDdZ?=
 =?utf-8?B?c09rWGZsWHlodFpRcExxdnFxMUo2MGh3Z1FGd0lVb3Z1SDFRVytTUlYveDNn?=
 =?utf-8?B?VWY1NU41dzJHbzczRy92cEpseHNJcUZTL1UyWSt5MVRjMSttVUh3K2hGazBa?=
 =?utf-8?B?b1ZHQWdMc2dsTzNkRU1IQmV4TitMdU0vQWE4dUdsc1Y5S2ZPM0ZFWEdaRStn?=
 =?utf-8?B?SU1scGpxZDJBZ3dHaWU1R29zckFZRjQ4YW05eEE2M05LQWpSUEZvb1VNbzBn?=
 =?utf-8?B?bFFnR3FIR3d2YXdzRjRWR2lhZS9raWVGZnJKSDhUVGdub012OVVJUzVRcFlZ?=
 =?utf-8?B?cmNnbUxXZHZ3WGZzQmxob05MWFp2NHZQd1FaM3NEWVg4aFpucHUwMjNWUDFa?=
 =?utf-8?B?bmpIZTNnTno5blAzKzFwTnVTbzZJV3VTMHlpYmNuL09EbGFqTFVESFpWTngw?=
 =?utf-8?B?aHpZY28wNkVla2Q0ZjJDWnZyZEY1YzVibThkT0R2NzVEalI5S3lFWmNWd0Rz?=
 =?utf-8?B?Vitva3FWYlUwNk1ZNGNOQ3FYZHI1QVZ6SmdoRjFvNjBCdVVTb3ZlZ2FyN2Vw?=
 =?utf-8?B?TlVUdE9RTmVLNnNML1Z5UmhhOTlZYVExMkw3VXNaSjhGeGU4ZmhYby9LblFh?=
 =?utf-8?B?RGs4b2NwcEpsSlZqcUdiTFBiSDA0anFCTGpTVnZOMVBIMnJRQjNTNkgzTCtE?=
 =?utf-8?B?QXoxbkREUkV1NkxtWDhRU2F2Y2F3cWpZUXRzYmR2YTUvWmlPS1JiRWI2Q0Rw?=
 =?utf-8?B?dlJkL1ZscVgwSitXMVY0OW1kL2hEQkFiL242ODZRTWpuYW9XRnRVUkpxKzJq?=
 =?utf-8?B?cVVtUm56S0l4ZDJmcUF2S3d5LzJYQWVQN3ozN3VSUXVoYnJsV21CdmdUKzBK?=
 =?utf-8?B?aGJZZ0xMSGtIREdHcXVFMXFUYjArRnRBeXRUa2w1SlRLc1hLNWdmRm5DQWRB?=
 =?utf-8?B?V1VVZmYrMG8wN2c3M1JreVQ2WW5jWnc3eFRpbGFaWkRNZGpMbW8vSGcxOG5V?=
 =?utf-8?B?ZnhhZFJoTm4rMTMvVUc1Zkx2SFlYMDY2N3AyR2s2L1pPVVhrSWdnOWxtOUcw?=
 =?utf-8?B?bXpXSTBHTllNeUFtbDIrM2hmZ2hPSEpIdEFoUm1BY1k1d1p5TTZLWVhhMktv?=
 =?utf-8?B?RGdjNTBTV0xPVml4T2tMZ1FrVEtVL09wWHk3TmxDM3lvYXNHV2ZKcVNvQjQy?=
 =?utf-8?B?Ym93cm1VTTdzaFJUa3YwTW5OVHhmamprYk9PL3IvYW90ZG5qejR0SXloT3hK?=
 =?utf-8?B?RzdMUHFua1ZtNjJlc2QvZExTa3BxdlBJOW4yS284Vko3bkJab2l3ZndmSGZ0?=
 =?utf-8?B?TWJ4bkZwNHY5UjVZZnlmSXhPT0lOZkl6ZFRCd1loam9jVzZUTVAyU29NR0Ew?=
 =?utf-8?B?WVRMV1R4OEtGa01lNkNPcGpRWGR4NlFkaFA0dzlmTFkvdHJRQS9iUkhVZHJ1?=
 =?utf-8?B?bU1HRHdtY2NRL0xPVEVOSkVvR0N4Yi9ySis1NjNkZXJUUGlFNFdtQ0NBL2py?=
 =?utf-8?Q?oMHTLz++c4fiPSqbxulIGhdDG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D69C0F614534764195CD2F77AFFD2B56@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5b773f-7583-4560-6418-08dd6026fa3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 22:57:47.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgBFZLro82D6Rehae6PsMHtvxDph6tmReYsRUHmwIw0lii4h0tYQ1Ncs1TPN6Ie+5oNrOwBt5Liga1LDWB9qCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAzLTAzIGF0IDIzOjE0IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEluIHByZXBhcmF0aW9uIGZvciBjcmVhdGluZyBhIG5ldyBkcml2ZXJzL3ZpcnQvY29jby9ob3N0
LyBkaXJlY3RvcnkgdG8NCj4gaG91c2Ugc2hhcmVkIGhvc3QgZHJpdmVyIGluZnJhc3RydWN0dXJl
IGZvciBjb25maWRlbnRpYWwgY29tcHV0aW5nLCBtb3ZlDQo+IGNvbmZpZ2ZzLXRzbSB0byBhIGd1
ZXN0LyBzdWItZGlyZWN0b3J5LiBUaGUgdHNtLmtvIG1vZHVsZSBpcyByZW5hbWVkIHRvDQo+IHRz
bV9yZXBvcnRzLmtvLiBUaGUgb2xkIHRzbS5rbyBtb2R1bGUgd2FzIG9ubHkgZXZlciBkZW1hbmQg
bG9hZGVkIGJ5DQo+IGtlcm5lbCBpbnRlcm5hbCBkZXBlbmRlbmNpZXMsIHNvIGl0IHNob3VsZCBu
b3QgYWZmZWN0IGV4aXN0aW5nIHVzZXJzcGFjZQ0KPiBtb2R1bGUgaW5zdGFsbCBzY3JpcHRzLg0K
PiANCj4gVGhlIG5ldyBkcml2ZXJzL3ZpcnQvY29jby9ndWVzdC8gaXMgYWxzbyBhIHByZXBhcmF0
b3J5IGxhbmRpbmcgc3BvdCBmb3INCj4gbmV3IC8gb3B0aW9uYWwgVFNNIFJlcG9ydCBtZWNoYW5p
Y3MgbGlrZSBhIFRDQiBzdGFiaWxpdHkgZW51bWVyYXRpb24gLw0KPiB3YXRjaGRvZyBtZWNoYW5p
c20uIFRvIGJlIGFkZGVkIGxhdGVyLg0KPiANCj4gDQoNClsuLi5dDQoNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydC9jb2NvL01ha2VmaWxlIGIvZHJpdmVycy92aXJ0L2NvY28vTWFrZWZpbGUN
Cj4gaW5kZXggYzNkMDdjZmMwODdlLi44ODVjOWVmNGU5ZmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdmlydC9jb2NvL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvdmlydC9jb2NvL01ha2VmaWxl
DQo+IEBAIC0yLDkgKzIsOSBAQA0KPiAgIw0KPiAgIyBDb25maWRlbnRpYWwgY29tcHV0aW5nIHJl
bGF0ZWQgY29sbGF0ZXJhbA0KPiAgIw0KPiAtb2JqLSQoQ09ORklHX1RTTV9SRVBPUlRTKQkrPSB0
c20ubw0KPiAgb2JqLSQoQ09ORklHX0VGSV9TRUNSRVQpCSs9IGVmaV9zZWNyZXQvDQo+ICBvYmot
JChDT05GSUdfQVJNX1BLVk1fR1VFU1QpCSs9IHBrdm0tZ3Vlc3QvDQo+ICBvYmotJChDT05GSUdf
U0VWX0dVRVNUKQkJKz0gc2V2LWd1ZXN0Lw0KPiAgb2JqLSQoQ09ORklHX0lOVEVMX1REWF9HVUVT
VCkJKz0gdGR4LWd1ZXN0Lw0KPiAgb2JqLSQoQ09ORklHX0FSTV9DQ0FfR1VFU1QpCSs9IGFybS1j
Y2EtZ3Vlc3QvDQo+ICtvYmotJChDT05GSUdfVFNNX1JFUE9SVFMpCSs9IGd1ZXN0Lw0KPiANCg0K
V291bGQgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIGFsc28gbW92ZSAncGt2bS1ndWVzdCcsICdzZXYt
Z3VzZXQnLCAndGR4LWd1ZXN0JyBhbmQNCidhcm0tY2NhLWd1ZXN0JyB1bmRlciB0aGUgbmV3ICdn
dWVzdC8nPw0K

