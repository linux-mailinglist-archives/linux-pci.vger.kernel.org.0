Return-Path: <linux-pci+bounces-4979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B24886656
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 06:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256822833FA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 05:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3709B4436;
	Fri, 22 Mar 2024 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPg8C+uB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89409C2C6;
	Fri, 22 Mar 2024 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086236; cv=fail; b=YqSwti7YBv3ZQWbXHBwYBju6Ze7xs2z53RKrGeK2tU9g4dWaATusbUvFQ6Ac3xU0oUCTxDrFPl61+FRpGBLAB2s51t2mFfpCdnlctVsZgkR8zOgaovFR0NKqt2ZQSBDSSLS36xEcnEX4uu/9b9eRrOHWywYElNUmFmpPF3UJgv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086236; c=relaxed/simple;
	bh=4s6DeY3nw+vvAJIek8z47G6eoHCAcTXQPdBicu7+Cxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jB3smsKs/THDF00y5VGmzeYaQEs8kFM91B7oShRcrQzwWZZuuwObqlupphCR43nUp94xURaOzjzF+fwXI97iGoBAYn7qTD83OVVWSXwFM1NmHc21FekhM+qdDWCiPDBpH99eKRxiOMDulKqtBtpJQpoqgaQC64XJfnPgd7movcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPg8C+uB; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711086235; x=1742622235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4s6DeY3nw+vvAJIek8z47G6eoHCAcTXQPdBicu7+Cxg=;
  b=UPg8C+uB/pWM9k0cLbQ75bxkbeyuf2nHOMgwB87wN3wDYqVwv1cT6igx
   hOwmCuDvV04PDbjEXz2CDA31mZR3+rGju+JeHdscO+PODKqxotzqRBtww
   olR4Dape4+xhk8mJA/0ekBpebWeELs1pgT/mFG83gekbC2dhO7X9A2N5Y
   GGSBDYPXhd4u//W3Ym+3yJqXZBkOa1QtDe3FtMhfFixlzMn37ici0Lj2Y
   QMrvKkNuMi4vVP5GvSiKKOSW2zJ2F/BlRXNQdxFMSwBuhypUphwt8kV+7
   ThUtepXknsjjuPu7UTVnQXuN3G5Lu8MoNK9vbfRpDpH0DZT+L1rkIAi7J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16667621"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="16667621"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 22:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="45770262"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 22:43:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 22:43:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 22:43:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 22:43:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 22:43:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FawQlxy8npzg0ttNuJd5rkOD3NEtKpGIwE2GJmEKQGGDbJFdTzHc1ylsyOZD/OEoevzB4LI6OX9aaACl0+lEGcNvwBnbAgPWhR5orPeepd0HjOcSxzICt6YxxT0zjsovg5OHDAVPHpdJ2taBFd4IuY+Lqvlt59zPwwKBIp3aHyOjnJw2WQSHPbzzwOGQU8shC+pOGdcQGJ330OWyqc7O/O3wAc2u5LRhy8sMM3VuC5PLmDu8Hjejkdn/7jpLCVywx2nPy8+LbA5Dl9c3w4uB4QTro+Gxylz2KMKGTmMAgLXndCy0kIsNHhnMDyyk6zh4VcseAYPNuO09hAEn/FQhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s6DeY3nw+vvAJIek8z47G6eoHCAcTXQPdBicu7+Cxg=;
 b=haLyBiWK2MOatkIUyTFo9EpnhrRnwqByDIdd6R1wYAWiEWKPMilwiUNPwFtXg8OYXRhBAXUp+B0hjvTQap0pHVBWGzRsFzukv3weuovRAKm8Ne7yN2O/v3Z4n1hN7ANGQQyzz87BcwsCv5sEbb5uKWg3RqRP9GJyIMagkzvVjd+REaRD2q2tTjOb4Ld2eOPVF+iGVU/qQ4itD5XGSpvauTMH5w7QdNZeAn9Jdz02tybSuUT4ZORFjvI7TwaOCBciqdrJQALgChBJKtYOpvhK9Rn+6DCN1SCE0awrUJTrsSVZCVOoFw50rewlxc5NsONrxtSIOLHPm3KGjNnRP98htw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5318.namprd11.prod.outlook.com (2603:10b6:208:312::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Fri, 22 Mar
 2024 05:43:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 05:43:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, =?utf-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>, "Wunner, Lukas" <lukas.wunner@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH] cleanup: Add usage and style documentation
Thread-Topic: [PATCH] cleanup: Add usage and style documentation
Thread-Index: AQHaexKuuJipJ/U/xUOsX8+zjix42rFDQVEA
Date: Fri, 22 Mar 2024 05:43:49 +0000
Message-ID: <BN9PR11MB52764D455B465E7C69F3A4C38C312@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5318:EE_
x-ms-office365-filtering-correlation-id: 3f2d149e-f9c2-43e2-1fe6-08dc4a330cf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ms2rFnWUJHuj3+Rh56Z203JTRXhuAZxQdLrk7aIam/dExI7PthCbcCGf2RwhAWLdzS84Vd64QQFZZql5QQBVJ8j0b9rrKdMgO/ZdWUD/keY868jSy+FRE7yT+Gd+PbTc/VaSoJIJu+nOs1yjD0/RlR9rW2tKkaAKIcxEka0S0IybZ2mRsE+jwnfjB0WCm8tr+p6RWzP0WBMPyx4oFYGlBIq2cKPJkuSAZvqLKyUbwFG1qyPfyCnKd9NWsDeLfYZ4CBzIXrvIZ5N8GetLUMVxyRWpzRAxeag/c9HqXf215sIj4xfenfWTy790PcAFzNAJ3Y7SnfkMYby8j6508xTYYJXTP3Jjwp2JGKwTZzL3NpfBJe1dfGX1wubCby2uWYrXBREXg2Rpymjaaj0kscgZWicarflLihtJ2T05Dg8NgLFIXDU3nYuP2aJEHrcZekgHhPOVHUXO/UsZr3xhmrNe7oAuBBpNz8QgjtchemM0uNdGRmIQEWECy69zBKMlVbbO3k2ba7NoBimoyMIhPDvMfXI9sQu22Z/pa7I/0UCg9kAY/ltiVbfteSA/Yt6JwjWlU1x7eodJKYOEpn00B+InIXkyQ9Skvy4m+CVcuBJHkzgMrU0CN+8CYIwzHL7fa9WI2NJK7rStApSPatucMUOCARooowGcgFqOvHa9LxtSlIRk0NwNLzbhnx4oZg5E8IZqRDuLXz8fCi6Ik0aOj5znElVdgxPhAEkj5ymLRp/TGHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0E0OXpZQ09yTUlhWEJHeXhGekY1QVV5alMrUklSYUlGM1hWVVRxVndraVlL?=
 =?utf-8?B?UjNTOUdHZXU0aXUzNURtUllVeVF5VVdmOTFkMFY3cWNpVUNic3ovUlVCblZN?=
 =?utf-8?B?UVIxTDZwMzg4SnRXNUtTb0pFUXBiaEErcURyeE1XT3ZkVGcxUjBjazRUTEtM?=
 =?utf-8?B?bllCVWNhT2twcnBlMmZ5RmRoWlM2V05VNkhLcy9iWmkrYUgrbXg2NFN1SmV3?=
 =?utf-8?B?bU1QcmRDU0szZGxuZ1cyMVFySWtyUUFyWHEybWZWZTZMRUtwTmtCMG5pQzlU?=
 =?utf-8?B?SkZUK0k1RWFVL29vTzM0Ylo5LzRXSWlUaTdudGQ3ZkJ3UlFsV2VWWWlaTEpx?=
 =?utf-8?B?eWl1OXhhbnZJYVlEZnVkRFhyeXdhWjVrM3Evc3ZWblljVjg3enliWkxuNGJq?=
 =?utf-8?B?TkN0QmJLOFRDblg3WGtVQkF0RWJ5TUpydzI5eXgyR0JOc0pBalYvNWJNU0lR?=
 =?utf-8?B?YXZHNG9xaytZTCtpQ1Z0VCtsVVk2SVY5b1kzSkROakFZeHZPSjYyV3RPOTNt?=
 =?utf-8?B?eWpBMXBoREZyclgwZVhLWmROMit6MjYrNXhQd2VqcU1XOFNiUlJnelpDaVdv?=
 =?utf-8?B?T0I2MHg3MEJKb1AyUitmTDhMM0lnckkwL1p6Y1FDRFNIVFJKVXdxMTY2SmhZ?=
 =?utf-8?B?Q0dIWFNrU05BQ29CLzJZeEFNRHZ2dFR0bFN2c3FDaTd2RVJVSVh4aTY2MEZp?=
 =?utf-8?B?Z09JNG5XVG1TdHdVdTUvRk1UZytiZ0ZmZmtmYldIRm15M1N5aDd1anozZm5T?=
 =?utf-8?B?SWJIUzZlYmxvb2hxVE94OFVkb3hMNWFZKy8yRG8vaU1YODUzV1RWeDVpM1Ax?=
 =?utf-8?B?M051QUVOWkNISVRxaWhJWG5vMHl0UUh1WDd1dGRsWTVNR3A0M056ZU4xdElS?=
 =?utf-8?B?eDlWNEJ3dktKN1BDbnRXYXFJUUhUWFZ0VnlzVlV1bEZ6QUoyRVB5aU1aWGEw?=
 =?utf-8?B?SFl2OXZ2UktuNnRpRVByUng2MWcwTFdhVk9JMDJqU2xoRldYSnpqR1ZBWVlU?=
 =?utf-8?B?T1AwQldhaHYzLzhGZ0R2YklSSUh1M2lFZjluekw3Z0tzWWphZUFBZEZBa0hJ?=
 =?utf-8?B?VU5SQ1E1NFJXK1RXT2Qxa1pCZFRiVmwzcnQvWTY3WmZUSkRYcjVKbmttQUpv?=
 =?utf-8?B?bERlYW1uSU5rem54L2F1NTlNWnZuOWRMRjFXQjNteXZiUCtJSExOOE5aaW5U?=
 =?utf-8?B?NXZLWld6OXdldWhZWlVkTXM0eHJ0WjM3bjhSbjBKNm1aNEFCU3pUUC9oRGxs?=
 =?utf-8?B?Qk1DZTlLZWVoN2hoQXBMWHdwc01IMXRtTkNBQjg5bGg0OWUrUWdvK2d3VGJ5?=
 =?utf-8?B?cnNUSEZhYzZZakFLRDVMcWUrZUZaSXU4OVV0bWdjNU90YStic1IrRC9RLzcy?=
 =?utf-8?B?aURrdFBXOGVtREJiYnZWSDdtRVVKTm9zNzJaMnhPY3R1K1VrWjMzLzdYNXBz?=
 =?utf-8?B?UEFWSUtGZjNnZTE2cGlXd21XdGJpMEI5WWdyZHZrbE5NSnVhNS9TaHpTSU1X?=
 =?utf-8?B?V2JjUm9xbHhzcjFYT2RLQWpVV3NnM3Q5MzVRMEYyaWRPdkhua1Iyd0I1Tkph?=
 =?utf-8?B?VTVjN3gyU1JObUNEbFQvbVUvNnR6YURYeDRUM1RaeExDaWJjNnAxTktIeVEx?=
 =?utf-8?B?RUc2Z0tSaDJzNHJZaVZLc09lbzRoQlFVQnVLUDQwOEZyQkNHT2NRRnlVbHkw?=
 =?utf-8?B?cXRuNDJyanlvWm1XOFFnUGtVLy9uL2NMYmF6MEVUMmZqbDVaOWNRc2YzWVBY?=
 =?utf-8?B?S2JrVk1Rb3l6L3daMlo2M0VPWmFwR2V3a0trbytGYUVSSUM4b1M0a0VhbEtG?=
 =?utf-8?B?dmJOV3lycXM1aEFjMTc3dDdaNzFkMEhpN3c3Ylk2YzNKNHZsREMwVmkzK0V4?=
 =?utf-8?B?RnB0enJBdlA4TXlycFNGaHYxSGZGRDJmZzRqUlgzbVhTTXVTQ3Z5S2V5QmlI?=
 =?utf-8?B?WXNpV1lVaUtsaXRWeXJHY2lwZDFhMUd2bUxlOGh0czNUQ0ZNaW1QaUZJSjVP?=
 =?utf-8?B?cVdyMFRtWUtHdFF6ZERaZEZaYjdRaCtjemlSdDdTUFpuekVnSHJHNklmTXZ4?=
 =?utf-8?B?Um04K3JiUmw5aUQwaWNGd0xoSlNOWUVOMnk3QkpGajZYWVhCMnRKb2JvdlBk?=
 =?utf-8?Q?356Z+jIgP+X9kHPN4z8y0qHxS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2d149e-f9c2-43e2-1fe6-08dc4a330cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 05:43:50.0113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKvFboeKmsCMjkqq0xVA1bhkElCRIQZ/IJdFje4CYL4GEiS4CqK99LdcW9zZBrQRYkgRt/jkoEL3WM1yGDz1KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5318
X-OriginatorOrg: intel.com

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIE1hcmNoIDIxLCAyMDI0IDY6MDUgQU0NCj4gKyAqDQo+ICsgKiBOb3RlIHRoYXQg
dW53aW5kIG9yZGVyIGlzIGRpY3RhdGVkIGJ5IGRlY2xhcmF0aW9uIG9yZGVyLiBUaGF0DQo+ICsg
KiBjb250cmFpbmRpY2F0ZXMgYSBwYXR0ZXJuIGxpa2UgdGhlIGZvbGxvd2luZzoNCj4gKyAqDQo+
ICsgKiAuLiBjb2RlLWJsb2NrOjogYw0KPiArICoNCj4gKyAqCWludCBudW0sIHJldCA9IDA7DQo+
ICsgKglzdHJ1Y3QgcGNpX2RldiAqYnJpZGdlID0gY3RybC0+cGNpZS0+cG9ydDsNCj4gKyAqCXN0
cnVjdCBwY2lfYnVzICpwYXJlbnQgPSBicmlkZ2UtPnN1Ym9yZGluYXRlOw0KPiArICoJc3RydWN0
IHBjaV9kZXYgKmRldiBfX2ZyZWUocGNpX2Rldl9wdXQpID0gTlVMTDsNCj4gKyAqDQo+ICsgKglw
Y2lfbG9ja19yZXNjYW5fcmVtb3ZlKCk7DQo+ICsgKg0KPiArICoJZGV2ID0gcGNpX2dldF9zbG90
KHBhcmVudCwgUENJX0RFVkZOKDAsIDApKTsNCj4gKyAqDQo+ICsgKiBJbiB0aGlzIGNhc2UgQGRl
diBpcyBkZWNsYXJlZCBpbiB4LW1hcyB0cmVlIHN0eWxlIGluIGEgcHJlYW1ibGUNCj4gKyAqIGRl
Y2xhcmF0aW9uIGJsb2NrLiBUaGF0IGlzIHByb2JsZW1hdGljIGJlY2F1c2UgaXQgZGVzdHJveXMg
dGhlDQo+ICsgKiBjb21waWxlcidzIGFiaWxpdHkgdG8gaW5mZXIgcHJvcGVyIHVud2luZCBvcmRl
ci4gSWYgb3RoZXIgY2xlYW51cA0KPiArICogaGVscGVycyBhcHBlYXJlZCBpbiBzdWNoIGEgZnVu
Y3Rpb24gdGhhdCBkZXBlbmRlZCBvbiBAZGV2IGJlaW5nIGxpdmUNCj4gKyAqIHRvIGNvbXBsZXRl
IHRoZWlyIHVud2luZCB0aGVuIHVzaW5nIHRoZSAic3RydWN0IG9ial90eXBlICpvYmoNCj4gKyAq
IF9fZnJlZSguLi4pID0gTlVMTCIgc3R5bGUgaXMgYW4gYW50aS1wYXR0ZXJuIHRoYXQgcG90ZW50
aWFsbHkgY2F1c2VzDQo+ICsgKiBhIHVzZS1hZnRlci1mcmVlIGJ1Zy4gSW5zdGVhZCwgdGhlIGV4
cGVjdGF0aW9uIGlzIHRoaXMgY29udmVyc2lvbjoNCj4gKyAqDQoNCmFuIGV4YW1wbGUgb2YgZGVw
ZW5kZW50IGNsZWFudXAgaGVscGVycyBtaWdodCBiZSBoZWxwZnVsIHRvDQpiZXR0ZXIgdW5kZXJz
dGFuZCB0aGlzIGV4cGVjdGF0aW9uPw0K

