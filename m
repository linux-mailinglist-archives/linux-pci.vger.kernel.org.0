Return-Path: <linux-pci+bounces-7957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21F8D2EC9
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 09:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F6BB2842C
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 07:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D3168C36;
	Wed, 29 May 2024 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCXShSpa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE9168C24
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968767; cv=fail; b=DaMwwWw3hGExBoZ8kzEseNzKIVzjded01HdprWowQyQVCQXe3yvAE08Q/cXYPjBuH+pAWbW7ublIfTUZLBppUOQUlsykUaCnCBRj6H5xAJ+K9KXf0ZwN9uQlL98WYrJ50uLd79W6zqj7G/VeIEWuEbFiz9bVL8TzUr/4OFRZHic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968767; c=relaxed/simple;
	bh=2e9hh6o/UnnoGdMt+Qr7OuaT/z1iYFPC5SowOGwWiaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Za4X+K048gM3gtAW7/YjxVRyCPI3jFvvvtfo1/csClahSEDbAwjsWY/w63yYZnK5jW8foJT/zG4FmZt+qiErsS8JV5hWVhmoYxbaNkejGNl1Gv+rY9/O3iW2oXY2dhPCSMRNF+mJMbhK2Yzj6o0ItwmOCIHAiK5XPFDPcp5mAPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCXShSpa; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716968765; x=1748504765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2e9hh6o/UnnoGdMt+Qr7OuaT/z1iYFPC5SowOGwWiaY=;
  b=CCXShSpaj0neVt9fNhgzRVA3Vliy3Y2MLvP9bsrQwHV8zJF6U28JHoAX
   HaESOJnmmnBV9nt6U9tmNT8rla7ajWXcWmPeE5JZsiOYlxvlFyKBHsSnB
   5dsz29d7evd4+7MfkgbspYIWx6wfZN54ifwMGvCIOx30OAJIF+MiC6dCm
   P+POGBBAuxFANcX4xek9Xt58ph85mb9t/r/NvGC8eT2zQ5yO6I8hLqrel
   fyjhtM4HJQY+CR92FEhanQ7nKN27nz4wyZWVib5unOS8qVl7cSlHstiyh
   HWU8tqEi9/DJQXJmosSBRyrWR+kAxz67/bdV9rJ2pJn7DYKmb4Zpyvs2y
   g==;
X-CSE-ConnectionGUID: UshLwrmGRieUXlGFWKr+JA==
X-CSE-MsgGUID: rG4knZ/vQQSDW6qzDatphQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13303436"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13303436"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 00:45:45 -0700
X-CSE-ConnectionGUID: m1PR8fDfSuSgH9AVkPZ3VA==
X-CSE-MsgGUID: vyNyGxoDSE2wfYVLQl0RuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39778395"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 00:45:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 00:45:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 00:45:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 00:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iswycpo45s4L4wU5R7J7XUpxVvlo1XhZxs15zYmxVdLbmXNGrhB+qMaNFZb9QZi14oj9lX0gvjngrXXdRm0zaKdkoPFk7kzeDUNM+rJlvpKslSUyLW+e4PhX5ak96yLZe98NXQik9U1QyIc5s2WYX70fMpJBeoXrGGSkiD3cP1TTdV/NoyqNS9gaI3mpQlXOAl/uD95/XHW5fwSrZpaLd9e8wjK8vgm0X9gepuvu4meGhjuUCAPh789NkD5OX8oOQeQE6/r8xNpGX9xkCxl31iTohZYbusbrYhHekg+BtOk1x2Jpp29nLu+RiZhT/mNd9K1Nwf4sboDACihPifTu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e9hh6o/UnnoGdMt+Qr7OuaT/z1iYFPC5SowOGwWiaY=;
 b=Ne3MnEpOExTGOA1K8aUIsrTbghiPiXyrfdF1/mwIDY8EFbyTNU0OFgRuGc4Kvab2tWLHsbY9X/xN2x7A3iSIIx8u+/dVracx0kYsKHYtCyNEH1G0NsVTDbNgSrsxdPhDKCAsCfdoZGs5EMZ8syZn1YU0DCZZBK5fhALN0gFhrnpBm2f2+zXqBnyexvD9WlctcPYr9Y1+w7Tn6eV4gYl3t4veR5DRRFbtJUnWVLIjmCw9L6XcwehzPjF4+KqKB/dq3Gr9skIXlOWZ+uc9QYkhcPz6Y1nWBdrRFTdFA8CWhZJQZFD+qnyQniLz5FwWrj4YHlzL6Spuvkt4xmlXtecA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) by
 SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.19; Wed, 29 May 2024 07:45:41 +0000
Received: from DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::f6db:9044:ad81:33d9]) by DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::f6db:9044:ad81:33d9%3]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 07:45:41 +0000
From: "Saarinen, Jani" <jani.saarinen@intel.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>, "Deak, Imre"
	<imre.deak@intel.com>
CC: "Jiang, Dave" <dave.jiang@intel.com>, =?utf-8?B?5p2OLCDmmJ/ovok=?=
	<korantli@tencent.com>, Jonathan Derrick <jonathan.derrick@linux.dev>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>
Subject: RE: Lockdep annotation introduced warn in VMD driver
Thread-Topic: Lockdep annotation introduced warn in VMD driver
Thread-Index: AQHasPvGoTC05+utlkaEOOCd4uPGL7GtQa0AgACOemA=
Date: Wed, 29 May 2024 07:45:41 +0000
Message-ID: <DM8PR11MB5655204BCE54EAB8438038E1E0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <ZlXP5oTnSApiDbD1@ideak-desk.fi.intel.com>
 <20240528155228.00005850@linux.intel.com>
In-Reply-To: <20240528155228.00005850@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_|SA2PR11MB5082:EE_
x-ms-office365-filtering-correlation-id: 907ba9c1-71d3-4144-eec7-08dc7fb35715
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RmJFTVBVQk5MMW5oL2lCUUc1bW5NcUxxSExLQkJqMmVkdm82aFZUdnduQXRo?=
 =?utf-8?B?MGsxRTlKY0pVbm12ZGIrKzZzY2h2REVBUUtkekZvVVN2NmNqUFdmMEZMRERZ?=
 =?utf-8?B?a21wRklRVFhWUmxUWTZSSklXMG5wdUxLVEdWb0NRTmdWSlNaRXNqc3NjblUz?=
 =?utf-8?B?djFuTW9MWXpzZEJwZWxBMW5YeDhqQU5mMldLL0tWOXhteDNqUlBIeU5FbW0r?=
 =?utf-8?B?T1JWVDdGNldUMmJRY0dBTG9GV3ZnZUttSVFDZjJVd0g1dHNxbW0ySTlrbzRi?=
 =?utf-8?B?c0ZiRVFnZmlZekFrWVI0Q0MrUzB4TjhIY2hCRU00eVlMT2RKNURnT0w0K0Na?=
 =?utf-8?B?b3ZWZVYrTGJHTU1DNkpEblZ5QWlJeGxrMGE5enJKd3oxOEFrTDRiM0o1dHRN?=
 =?utf-8?B?N0NDU0luUHlTTU1Lc2o1V0V6U1BCSUNkOFRYNUJxWTRzVkhraDZiSjJjU1A4?=
 =?utf-8?B?TXBqOW9WanNMdjVFYjVWTWpheXBhU1BUUU9WbzJuc0VtRlJhVld6QWFMd1BI?=
 =?utf-8?B?eC9rRi8rL0M3MGFXd3Yrd1YvQklhMHYwN1JBbFRLTmtybStJekZBbEQyQnBY?=
 =?utf-8?B?alhkS3UxVHVjWnFnS0RGZmh2WTNTQXErUXV0blArY1J1c2lPTGQwcVNFcDQz?=
 =?utf-8?B?dzNtNFJYMWVRVEc4WFBLVWJadStZRmpqanFyRlRLcURnSUhQMzU5ZVZoUjFX?=
 =?utf-8?B?eUhpTnlZZWEwcS8zS0ZtZm8rTHRzb0drdmRSRm8wckpiekkvTTlpMEdzeXBT?=
 =?utf-8?B?Qyt3cVBHWjlTL0JYTDkybEVwRVlrRURoVXJrUS80L01ieUdpMUhOWXExZG9I?=
 =?utf-8?B?eWRHamF6SlRvRkcyRTZ4RnNMSW1FRDd0RDNZR2pTWVJmdlpvbm03c3BaWjU1?=
 =?utf-8?B?ZEhRbTRwNWI0MGRZR09SWXcwNUFmZTg1L0NxdXpWejh3WkhjbVRTT2JHbExv?=
 =?utf-8?B?NG9HVEw1cmxkSWdmemlrYTlhNE1lR2h4SWNIV0JLQnluU0c2S0QzT3lnQU80?=
 =?utf-8?B?WU9xeGhyd0pKQVdsK1puQ3NHZ2RNUkk1R0lPemROVWRJdmhDdkMxRmJmdlhq?=
 =?utf-8?B?Z0xzcGdDNm9FUUdzNjJEdHVCQW9ZcGdGWVVacThlS0xBSnEySTN6MzdyUUVN?=
 =?utf-8?B?WlVhMkxkUFN5UU44RGdUcDlzbTI3dlF2RHFYQjNpZ3RiK2lUbVNjZ2FiOEJT?=
 =?utf-8?B?VjRYOTJvenB6RmN2UlZDYWoxRXdQOVE5VUlvQTdTVzBobEllWUxPYjVwL3hD?=
 =?utf-8?B?UlI1azVVajVqZG5ORG9kdHZEU1R0aVhjS2ZhcnpDbjlmbnc3cXBUb2hVQnNK?=
 =?utf-8?B?YUx2WGRMcUFpT2J5SXNYa1FrcU4zVDJ5RmR4L0VPL24vY1JMeEVWYjgwbnFL?=
 =?utf-8?B?YmpGK3RIMmVRNXFESjJNZC9zSTVaRTNQUXZISWhza2lRMlQ3QXBuVmsrUGF4?=
 =?utf-8?B?MlNzNGFENmlDdmJmQ3I2bjVEaFZ5S2d4czBhbWZ5RXBGc3NFY0t6MytMYld4?=
 =?utf-8?B?S2cydFRxa0MyZW1VcXlDZXpONE1sOWh5cGdpUmpVVkwyUTlPc003enR6ZVB5?=
 =?utf-8?B?NFBoMTRuWS9tb2xET2Iwczk5WWd3R25lV2ZiVHVvcEx6M3ZYcEpKeDFFS0hQ?=
 =?utf-8?B?Sm5mMXYzb2NJR2JYWEZnbHlDdmlRNTZzamRvalpLTHZMZVdJYmZkMldhY0pi?=
 =?utf-8?B?c2d3bTFjMWk1R3ArcmRSUWFrRmxkTXI4bnl3Nmo1eUJyeloyUTM3OEZWY21E?=
 =?utf-8?Q?LDh9qFdRF/JxYkrZgA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3RxUnFPZWY5enhRcW5XUkJPckdwL3U3UStCb3BIUjVyUDY3cjVYcXRUUlQ0?=
 =?utf-8?B?dW9Wa1prbmo5R2MyWWN5Vzl0YUxFbTd3Mk90cHBLRUxoc2k2WWk5MWduL2hy?=
 =?utf-8?B?dTU1SzFLNm8vNGtjMmRqR0x6QmJzTTNKQ0tHUGFXTi95VVZITWNidm5ySlZ2?=
 =?utf-8?B?ejROQmlweFVyQzdmb3pQTjQxdVI1NzFCMVJpeWN2WFdKQ1h1VzRtUlpjeWhk?=
 =?utf-8?B?SmtjVE0rNzBnMGdmRWVLSU4rc1NwMkVTNlRKTlhESzBjWWVHNU96U3dCNDdw?=
 =?utf-8?B?aDZ6OGVRQnNLWDFodGY1Tmw3SVpuaERadzB6RVNQRm5qSm1RRDZsMVFrR0M2?=
 =?utf-8?B?YmxNMjFHLzNPMkJXYVlMNmROZ3JoSGdOQTBRdWlKVkhwZ1o0V01tdkVPSjVN?=
 =?utf-8?B?bVNINU9Ta2luK1JHZXozMWx6VnJWTkNLMTJ1TGZsai9iOEMyNzlGU1hKMzI2?=
 =?utf-8?B?eTJvU0tPWkZTdCt2Q1VUbXJuT2VpNXJ6N2V5R1dZTlp3RXBJNWV6Wk5FUWxK?=
 =?utf-8?B?dUdwYnVEZDA3ZjBVV0ZHT2Q5Q2UwWEg5dXI3bnE2N3A5a0NTSHFEZnd5WEZh?=
 =?utf-8?B?QnQ5ZFRQeUl0YkJiOTFGMDFrejNhM2IrM1kvWDBValFKZ29CVk0xeW9SSVRK?=
 =?utf-8?B?UGJVYmFxVzJvOTBlaFNBR2svNGtRM0FVaWlJSncvYm5YcWJrOTZkRThCVlJz?=
 =?utf-8?B?QTZtekk2ZzJKK3ZNeFI1bTRtTS9DZHFSR2NUNkZIcGQydWZkcnBZTWVFOFcz?=
 =?utf-8?B?NzZYaUpCVGp5RzcwTVlURFpjdDM0TytocURVSWE3UnJlTDJSRkt5Qmx5WnhF?=
 =?utf-8?B?Qjd0anRFOHhXRnRhSldXbHo2bTRFZ0NycUszZTlQcE9ycGkyczNZc2dEYVAz?=
 =?utf-8?B?anB3NkVKRllSNkpQMkpKUWd1OHJIVERVZHVzeFZjVi9LaUNZQlo1S3kvZFBU?=
 =?utf-8?B?KzdMNEZaeVZvOFIzTHVWcUhreHd3MkhPZGMrNXorUEVialhKcVp5a3ZLZHpU?=
 =?utf-8?B?akU2Q3lVa0ZCa0lrNkIxa2UzMWpZZ3RaOVBDbkNsVXdCWjRwSW9XWlVydVBS?=
 =?utf-8?B?djJ6TEdDeEEvdzVJelZ2aFhSUjFuYTVWWkpRdkQ4YkFGdUZqeUd1UlNCZWx5?=
 =?utf-8?B?NThaV3NaWlFUelhMSC8yZHppVVJOR2FGdzJ3dTJBL0hsOUJqWGo2Yk1OMnI5?=
 =?utf-8?B?d0tDNFJRMmovWlB1dVZodEhLUTJocmhnelQzcHJYYTFsN1Z0Nm5UNEhHMmhq?=
 =?utf-8?B?MUhuZm5uQmlBUzhoNUs3VFBPdHU3SUhTdHR2QmFWc1ZxWWk3cHpPbFUrWCs0?=
 =?utf-8?B?TnVQcTJjU0N0Vk1YbU5uTkNZVFRXKzFiNjR2VXBhMzcwNDVmN1B5V2oxV1F2?=
 =?utf-8?B?TUQrUjhaT1dqRjFqZXRqNW5BeHI5VjZBWS9NeTRiMVFhbEIxWlFCaHAwbW83?=
 =?utf-8?B?eVBueFRESHJZYmhKVGlEbm9wYkVzd2lGRmxXVnBZQmRUZkowTFRxd2I1bUVO?=
 =?utf-8?B?czE1dGUzUzdoM2dOSk9VRUNicGpLRTB3MDBjRjBDeStTUnZhbXY3eDZ3UzB2?=
 =?utf-8?B?ZzV6eDNkSGplcE5vTWlDY2w2NWdXKzRlK0NodU1FWVR5MWNpbUpwUkdlbW5h?=
 =?utf-8?B?c2tDQS9WRnBGbHZ2L0FWZUs0Vm5lb2orL0lXOTZ3cmFLOVZTdU0rTG5YeUhQ?=
 =?utf-8?B?dUt3LzV6bjUveHFtSHZyUTVvbVVnb1Vnb0craytMMHZxU25vSndFa0VNbWh6?=
 =?utf-8?B?M3RrNVJxeEdlc09taEg2cGtNM3RCYzR2dUtYeXZlNEpuRy9HSGdCczUyUjIw?=
 =?utf-8?B?SXltUjFYU0txbWdKbGk4aVBWcTQ0TFVCRVNZeFhlU3RxN3pVeGsxMVBoTlB4?=
 =?utf-8?B?eXAvWFIzM2RuMjZiTElJckQzTWt5WXo2Z3N1VnlMdFJDeWtpdVJwdGtPczd4?=
 =?utf-8?B?SFFnTmpURFphVzhNNjBwdDBoc0M1SDVQbmhGNXU4eGllZ3F1aUpjcnVONnFB?=
 =?utf-8?B?dzVuUCtPRk1HU05CbEVGMm5TOWdnSW95L3JNVklITXZJM2p1NitiMEVpQXJq?=
 =?utf-8?B?eldpbE9jT3dhN1d5dEVIRk81WFIzTmcrWjI5ZXJ5Ny9SVGEwTmRjVmljRGN4?=
 =?utf-8?Q?fW7K2uD2vkzxzNeRNFK7r5D8L?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 907ba9c1-71d3-4144-eec7-08dc7fb35715
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 07:45:41.6516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8v+aKPQRqzkcGF12gNoX4mWncez4xt8iP1lnHhHd4R/60eF6qji/x0mtXqck06Sm2Z0OySSnFsnyBY2s1VISw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com

SGksIA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC1nZnggPGlu
dGVsLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IE5p
cm1hbCBQYXRlbA0KPiBTZW50OiBXZWRuZXNkYXksIDI5IE1heSAyMDI0IDEuNTMNCj4gVG86IERl
YWssIEltcmUgPGltcmUuZGVha0BpbnRlbC5jb20+DQo+IENjOiBKaWFuZywgRGF2ZSA8ZGF2ZS5q
aWFuZ0BpbnRlbC5jb20+OyDmnY4sIOaYn+i+iSA8a29yYW50bGlAdGVuY2VudC5jb20+Ow0KPiBK
b25hdGhhbiBEZXJyaWNrIDxqb25hdGhhbi5kZXJyaWNrQGxpbnV4LmRldj47IEJqb3JuIEhlbGdh
YXMNCj4gPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBp
bnRlbC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogTG9ja2Rl
cCBhbm5vdGF0aW9uIGludHJvZHVjZWQgd2FybiBpbiBWTUQgZHJpdmVyDQo+IA0KPiBPbiBUdWUs
IDI4IE1heSAyMDI0IDE1OjM2OjU0ICswMzAwDQo+IEltcmUgRGVhayA8aW1yZS5kZWFrQGludGVs
LmNvbT4gd3JvdGU6DQo+IA0KPiA+IEhpLA0KPiA+DQo+ID4gY29tbWl0IDdlODllZmM2ZTllNDAy
ODM5NjQzY2IyOTdiYWIxNDA1NWM1NDdmMDcNCj4gPiBBdXRob3I6IERhdmUgSmlhbmcgPGRhdmUu
amlhbmdAaW50ZWwuY29tPg0KPiA+IERhdGU6ICAgVGh1IE1heSAyIDA5OjU3OjMxIDIwMjQgLTA3
MDANCj4gPg0KPiA+ICAgICBQQ0k6IExvY2sgdXBzdHJlYW0gYnJpZGdlIGZvciBwY2lfcmVzZXRf
ZnVuY3Rpb24oKQ0KPiA+DQo+ID4gaW50cm9kdWNlZCB0aGUgV0FSTiBiZWxvdyBpbiB0aGUgVk1E
IGRyaXZlciwgc2VlIFsxXSBmb3IgdGhlIGZ1bGwgbG9nLg0KPiA+IE5vdCBzdXJlIGlmIHRoZSBh
bm5vdGF0aW9uIGlzIGluY29ycmVjdCBvciB0aGUgVk1EIGRyaXZlciBpcyBtaXNzaW5nDQo+ID4g
dGhlIGxvY2ssIENDJ2luZyBWTUQgZm9sa3MuDQo+ID4NCj4gPiAtLUltcmUNCj4gQ2FuIHlvdSBw
bGVhc2UgcHJvdmlkZSByZXBybyBzdGVwcyBhbmQgc29tZSBiYWNrZ3JvdW5kIG9uIHRoZSBzZXR1
cD8NCg0KV2hhdCB5b3UgbWVhbj8gSnVzdCB0YWtlIGxhdGVzdCByYzEgYW5kIHNlZSByZXBvcnRz
IGZyb20gb3VyIENJLiANClRoZXNlIGFyZSBsaW5rcyBmcm9tICBDSSB0aGF0IGNhbiBiZSBzZWVu
IGZyb20gaHR0cHM6Ly9pbnRlbC1nZngtY2kuMDEub3JnLyANClRoZXNlIGFyZSBjdXJyZW50bHkg
aXNzdWVzIG9uIG91ciBkcm0tdGlwIGh0dHBzOi8vaW50ZWwtZ2Z4LWNpLjAxLm9yZy90cmVlL2Ry
bS10aXAvaW5kZXguaHRtbD8gDQpTZWUgdGhvc2UgcmVtYWluaW5nIHJlZCBvbmVzIGh0dHBzOi8v
aW50ZWwtZ2Z4LWNpLjAxLm9yZy90cmVlL2RybS10aXAvaWd0QHJ1bm5lckBhYm9ydGVkLmh0bWwg
YW5kIA0KZXNwZWNpYWxseSBodHRwczovL2ludGVsLWdmeC1jaS4wMS5vcmcvdHJlZS9kcm0tdGlw
L2luZGV4Lmh0bWw/aG9zdHM9bXRscC05JTdDZGcyLTEzJTdDZGcyLTE0JTdDYWRscC0xMSAuIA0K
T3JpZ2luYWxseSBmcm9tIDEwIGJhZCBiZWhhdmluZyBzeXN0ZW0gb25lIHJlZ3Jlc3Npb24gd2Fz
IGZpeGVkIGF0IGh0dHBzOi8vaW50ZWwtZ2Z4LWNpLjAxLm9yZy90cmVlL2RybS10aXAvQ0lfRFJN
XzE0ODMwL2dpdC1sb2ctb25lbGluZS50eHQNCnRoYXQgcGF0Y2ggd2FzIG1lcmdlZCB0byBvdXIg
Y29yZS1mb3ItY2kgdG8gd2FpdCBwcm9wZXIgZml4IGxhbmQgZHVyaW5nIHJjLTIrIHRpbWVzIGFu
ZCB0aGF0IGxlZnQgNSBzeXN0ZW1zIGJlaGF2aW5nIGJhZCBzdGlsbC4gRm9yIHRob3NlIDQgKGV4
Y2x1ZGluZyBhcGwtMSkgd2UgaGF2ZSBhbHJlYWR5IGZpeCBhdCAjMSAuDQpGb3IgYXBsLTEgd2Ug
YWxyZWFkeSBoYXZlIGZpeCBmcm9tIERhbiB0aGF0IGlzIHJlcG9ydGVkIGFuZCByYidkIHRvby4g
DQoNCg0KIzEgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2NmYjUwNjAxLTVkMmEtNDY3Ni1h
OTU4LTFiZDNmMWIwNjY1NEBpbnRlbC5jb20vIA0KDQpEb2VzIHRoYXQgZXhwbGFpbiA/IA0KQnIs
DQpKYW5pDQo+IA0KPiAtbmlybWFsDQo+ID4NCj4gPiBodHRwczovL2ludGVsLWdmeC1jaS4wMS5v
cmcvdHJlZS9kcm0tdGlwL1BhdGNod29ya18xMzQxMTJ2MS9iYXQtYWRscC0xDQo+ID4gMS9ib290
MC50eHQNCj4gPg0KPiA+IDw0PlsgICAxNy4zNTQwNzFdIFdBUk5JTkc6IENQVTogMCBQSUQ6IDEg
YXQgZHJpdmVycy9wY2kvcGNpLmM6NDg4Ng0KPiA+IHBjaV9icmlkZ2Vfc2Vjb25kYXJ5X2J1c19y
ZXNldCsweDVkLzB4NzAgPDQ+WyAgIDE3LjM1NDA5NV0gTW9kdWxlcw0KPiA+IGxpbmtlZCBpbjog
PDQ+WyAgIDE3LjM1NDEwNF0gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90DQo+ID4g
dGFpbnRlZCA2LjEwLjAtcmMxLVBhdGNod29ya18xMzQxMTJ2MS1nYWJhZWFlMjAyZGZiKyAjMSA8
ND5bDQo+ID4gMTcuMzU0MTI4XSBIYXJkd2FyZSBuYW1lOiBJbnRlbCBDb3Jwb3JhdGlvbiBBbGRl
ciBMYWtlIENsaWVudA0KPiA+IFBsYXRmb3JtL0FsZGVyTGFrZS1QIExQNSBSVlAsIEJJT1MgUlBM
UEZXSTEuUjAwLjQwMzUuQTAwLjIzMDEyMDA3MjMNCj4gPiAwMS8yMC8yMDIzIDw0PlsgICAxNy4z
NTQxNTNdIFJJUDoNCj4gPiAwMDEwOnBjaV9icmlkZ2Vfc2Vjb25kYXJ5X2J1c19yZXNldCsweDVk
LzB4NzAgPDQ+WyAgIDE3LjM1NDE2N10gQ29kZToNCj4gPiBjMyBjYyBjYyBjYyBjYyA0OCA4OSBl
ZiA0OCBjNyBjNiA3OCA1NSA0NCA4MiA1ZCBlOSBkOCBjNiBmZiBmZiA0OCA4ZA0KPiA+IGJmIDQ4
IDA4IDAwIDAwIGJlIGZmIGZmIGZmIGZmIGU4IDk3IDEwIDVmIDAwIDg1IGMwIDc1IGI1IDwwZj4g
MGIgZWINCj4gPiBiMSA2NiA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCAwZiAxZiA0MCAw
MCA5MCA5MCA5MCA8ND5bDQo+ID4gMTcuMzU0MTk5XSBSU1A6IDAwMDA6ZmZmZmM5MDAwMDA5N2Nh
MCBFRkxBR1M6IDAwMDEwMjQ2IDw0PlsNCj4gMTcuMzU0MjEwXQ0KPiA+IFJBWDogMDAwMDAwMDAw
MDAwMDAwMCBSQlg6IGZmZmY4ODgxMDU2MDQwMDAgUkNYOg0KPiA+IDAwMDAwMDAwMDAwMDAwMDAg
PDQ+WyAgIDE3LjM1NDIyNF0gUkRYOiAwMDAwMDAwMDgwMDAwMDAwIFJTSToNCj4gPiBmZmZmZmZm
ZjgyNDIxYzQwIFJESTogZmZmZmZmZmY4MjQ0MWM0YyA8ND5bICAgMTcuMzU0MjM4XSBSQlA6DQo+
ID4gZmZmZjg4ODEwNTYwMTAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAwMDAwMDAwMDAw
MDAwMDAwIDw0PlsNCj4gPiAxNy4zNTQyNTFdIFIxMDogMDAwMDAwMDAwMDAwMDAwMSBSMTE6IGZm
ZmY4ODgxMDA4YzgwNDAgUjEyOg0KPiA+IDAwMDAwMDAwMDAwMDAwMDAgPDQ+WyAgIDE3LjM1NDI2
NF0gUjEzOiAwMDAwMDAwMDAwMDAwMDIwIFIxNDoNCj4gPiAwMDAwMDAwMDAwMDAwMDdmIFIxNTog
ZmZmZjg4ODEwNTYxNWMyOCA8ND5bICAgMTcuMzU0MjgzXSBGUzoNCj4gPiAwMDAwMDAwMDAwMDAw
MDAwKDAwMDApIEdTOmZmZmY4ODgyYTZlMDAwMDAoMDAwMCkNCj4gPiBrbmxHUzowMDAwMDAwMDAw
MDAwMDAwIDw0PlsgICAxNy4zNTQzMTNdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMA0KPiA+
IENSMDogMDAwMDAwMDA4MDA1MDAzMyA8ND5bICAgMTcuMzU0MzM0XSBDUjI6IGZmZmY4ODgyYWZi
ZmYwMDAgQ1IzOg0KPiA+IDAwMDAwMDAwMDY2M2EwMDAgQ1I0OiAwMDAwMDAwMDAwZjUwZWYwIDw0
PlsgICAxNy4zNTQzNDhdIFBLUlU6DQo+ID4gNTU1NTU1NTQgPDQ+WyAgIDE3LjM1NDM1NV0gQ2Fs
bCBUcmFjZTogPDQ+WyAgIDE3LjM1NDM2MV0gIDxUQVNLPiA8ND5bDQo+ID4gICAxNy4zNTQzNjdd
ICA/IF9fd2FybisweDhjLzB4MTkwIDw0PlsgICAxNy4zNTQzODBdICA/DQo+ID4gcGNpX2JyaWRn
ZV9zZWNvbmRhcnlfYnVzX3Jlc2V0KzB4NWQvMHg3MCA8ND5bICAgMTcuMzU0MzkyXSAgPw0KPiA+
IHJlcG9ydF9idWcrMHgxZjgvMHgyMDAgPDQ+WyAgIDE3LjM1NDQwNV0gID8gaGFuZGxlX2J1Zysw
eDNjLzB4NzAgPDQ+Ww0KPiA+ICAgMTcuMzU0NDE1XSAgPyBleGNfaW52YWxpZF9vcCsweDE4LzB4
NzAgPDQ+WyAgIDE3LjM1NDQyNF0gID8NCj4gPiBhc21fZXhjX2ludmFsaWRfb3ArMHgxYS8weDIw
IDw0PlsgICAxNy4zNTQ0MzhdICA/DQo+ID4gcGNpX2JyaWRnZV9zZWNvbmRhcnlfYnVzX3Jlc2V0
KzB4NWQvMHg3MCA8ND5bICAgMTcuMzU0NDUxXQ0KPiA+IHBjaV9yZXNldF9idXMrMHgxZDgvMHgy
NzAgPDQ+WyAgIDE3LjM1NDQ2MV0gIHZtZF9wcm9iZSsweDc3OC8weGExMA0KPiA+IDw0PlsgICAx
Ny4zNTQ0NzRdICBwY2lfZGV2aWNlX3Byb2JlKzB4OTUvMHgxMjAgPDQ+WyAgIDE3LjM1NDQ4NF0N
Cj4gPiByZWFsbHlfcHJvYmUrMHhkOS8weDM3MCA8ND5bICAgMTcuMzU0NDk2XSAgPw0KPiA+IF9f
cGZ4X19fZHJpdmVyX2F0dGFjaCsweDEwLzB4MTAgPDQ+WyAgIDE3LjM1NDUwNV0NCj4gPiBfX2Ry
aXZlcl9wcm9iZV9kZXZpY2UrMHg3My8weDE1MCA8ND5bICAgMTcuMzU0NTE2XQ0KPiA+IGRyaXZl
cl9wcm9iZV9kZXZpY2UrMHgxOS8weGEwIDw0PlsgICAxNy4zNTQ1MjVdDQo+ID4gX19kcml2ZXJf
YXR0YWNoKzB4YjYvMHgxODAgPDQ+WyAgIDE3LjM1NDUzNF0gID8NCj4gPiBfX3BmeF9fX2RyaXZl
cl9hdHRhY2grMHgxMC8weDEwIDw0PlsgICAxNy4zNTQ1NDRdDQo+ID4gYnVzX2Zvcl9lYWNoX2Rl
disweDc3LzB4ZDAgPDQ+WyAgIDE3LjM1NDU1NV0NCj4gPiBidXNfYWRkX2RyaXZlcisweDExMC8w
eDI0MCA8ND5bICAgMTcuMzU0NTY2XQ0KPiA+IGRyaXZlcl9yZWdpc3RlcisweDViLzB4MTEwIDw0
PlsgICAxNy4zNTQ1NzVdICA/DQo+ID4gX19wZnhfdm1kX2Rydl9pbml0KzB4MTAvMHgxMCA8ND5b
ICAgMTcuMzU0NTg3XQ0KPiA+IGRvX29uZV9pbml0Y2FsbCsweDVjLzB4MmIwIDw0PlsgICAxNy4z
NTQ2MDBdDQo+ID4ga2VybmVsX2luaXRfZnJlZWFibGUrMHgxOGUvMHgzNDAgPDQ+WyAgIDE3LjM1
NDYxMl0gID8NCj4gPiBfX3BmeF9rZXJuZWxfaW5pdCsweDEwLzB4MTAgPDQ+WyAgIDE3LjM1NDYy
M10gIGtlcm5lbF9pbml0KzB4MTUvMHgxMzANCj4gPiA8ND5bICAgMTcuMzU0NjMxXSAgcmV0X2Zy
b21fZm9yaysweDJjLzB4NTAgPDQ+WyAgIDE3LjM1NDY0MV0gID8NCj4gPiBfX3BmeF9rZXJuZWxf
aW5pdCsweDEwLzB4MTAgPDQ+WyAgIDE3LjM1NDY1MF0NCj4gPiByZXRfZnJvbV9mb3JrX2FzbSsw
eDFhLzB4MzAgPDQ+WyAgIDE3LjM1NDY2M10gIDwvVEFTSz4gPDQ+Ww0KPiA+IDE3LjM1NDY2OV0g
aXJxIGV2ZW50IHN0YW1wOiAyODU3NzY4NSA8ND5bICAgMTcuMzU0Njc3XSBoYXJkaXJxcyBsYXN0
DQo+ID4gZW5hYmxlZCBhdCAoMjg1Nzc2OTMpOiBbPGZmZmZmZmZmODExN2MwNjA+XQ0KPiA+IGNv
bnNvbGVfdW5sb2NrKzB4MTEwLzB4MTIwIDw0PlsgICAxNy4zNTQ2OTddIGhhcmRpcnFzIGxhc3Qg
ZGlzYWJsZWQNCj4gPiBhdCAoMjg1Nzc3MDApOiBbPGZmZmZmZmZmODExN2MwNDU+XSBjb25zb2xl
X3VubG9jaysweGY1LzB4MTIwIDw0PlsNCj4gPiAxNy4zNTQ3MTNdIHNvZnRpcnFzIGxhc3QgIGVu
YWJsZWQgYXQgKDI4NTc3MTc2KTogWzxmZmZmZmZmZjgxMGRmMjljPl0NCj4gPiBoYW5kbGVfc29m
dGlycXMrMHgyZWMvMHgzZjAgPDQ+WyAgIDE3LjM1NDczMV0gc29mdGlycXMgbGFzdCBkaXNhYmxl
ZA0KPiA+IGF0ICgyODU3NzE2Nyk6IFs8ZmZmZmZmZmY4MTBkZmExNz5dIGlycV9leGl0X3JjdSsw
eDg3LzB4YzAgPDQ+Ww0KPiA+IDE3LjM1NDc0N10gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAw
MDAwMCBdLS0tDQo+ID4NCj4gPiA8ND5bICAgMTcuNDg3Mjc0XSA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo+ID4gPDQ+WyAgIDE3LjQ4NzI3N10gV0FSTklORzogYmFkIHVu
bG9jayBiYWxhbmNlIGRldGVjdGVkIQ0KPiA+IDw0PlsgICAxNy40ODcyNzldIDYuMTAuMC1yYzEt
UGF0Y2h3b3JrXzEzNDExMnYxLWdhYmFlYWUyMDJkZmIrICMxDQo+ID4gVGFpbnRlZDogRyAgICAg
ICAgVyA8ND5bICAgMTcuNDg3MjgyXQ0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0gPDQ+WyAgIDE3LjQ4NzI4NF0gc3dhcHBlci8wLzENCj4gPiBpcyB0cnlpbmcgdG8g
cmVsZWFzZSBsb2NrICgxMDAwMDplMTowMC4wKSBhdDogPDQ+WyAgIDE3LjQ4NzI4N10NCj4gPiBb
PGZmZmZmZmZmODE3NmIzNzc+XSBwY2lfY2ZnX2FjY2Vzc191bmxvY2srMHg1Ny8weDYwIDw0PlsN
Cj4gPiAxNy40ODcyOTJdIGJ1dCB0aGVyZSBhcmUgbm8gbW9yZSBsb2NrcyB0byByZWxlYXNlISA8
ND5bICAgMTcuNDg3Mjk0XQ0KPiA+ICAgICAgICAgICAgICAgICAgIG90aGVyIGluZm8gdGhhdCBt
aWdodCBoZWxwIHVzIGRlYnVnIHRoaXM6DQo+ID4gPDQ+WyAgIDE3LjQ4NzI5N10gMiBsb2NrcyBo
ZWxkIGJ5IHN3YXBwZXIvMC8xOg0KPiA+IDw0PlsgICAxNy40ODcyOTldICAjMDogZmZmZjg4ODEw
MmMxYzFiMCAoJmRldi0+bXV0ZXgpey4uLi59LXszOjN9LA0KPiA+IGF0OiBfX2RyaXZlcl9hdHRh
Y2grMHhhYi8weDE4MCA8ND5bICAgMTcuNDg3MzA2XSAgIzE6DQo+ID4gZmZmZjg4ODEwNTYwNDFi
MCAoJmRldi0+bXV0ZXgpey4uLi59LXszOjN9LCBhdDoNCj4gPiBwY2lfZGV2X3RyeWxvY2srMHgx
OS8weDUwIDw0PlsgICAxNy40ODczMTJdIHN0YWNrIGJhY2t0cmFjZToNCj4gPiA8ND5bICAgMTcu
NDg3MzE0XSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBUYWludGVkOiBHICAgICAgICBX
DQo+ID4gICAgICAgIDYuMTAuMC1yYzEtUGF0Y2h3b3JrXzEzNDExMnYxLWdhYmFlYWUyMDJkZmIr
ICMxIDw0PlsgMTcuNDg3MzE4XQ0KPiA+IEhhcmR3YXJlIG5hbWU6IEludGVsIENvcnBvcmF0aW9u
IEFsZGVyIExha2UgQ2xpZW50DQo+ID4gUGxhdGZvcm0vQWxkZXJMYWtlLVAgTFA1IFJWUCwgQklP
UyBSUExQRldJMS5SMDAuNDAzNS5BMDAuMjMwMTIwMDcyMw0KPiA+IDAxLzIwLzIwMjMgPDQ+WyAg
IDE3LjQ4NzMyMl0gQ2FsbCBUcmFjZTogPDQ+WyAgIDE3LjQ4NzMyNF0gIDxUQVNLPg0KPiA+IDw0
PlsgICAxNy40ODczMjVdICBkdW1wX3N0YWNrX2x2bCsweDgyLzB4ZDAgPDQ+WyAgIDE3LjQ4NzMy
OV0NCj4gPiBsb2NrX3JlbGVhc2UrMHgyMGIvMHgyZDAgPDQ+WyAgIDE3LjQ4NzMzNF0gIHBjaV9i
dXNfdW5sb2NrKzB4MjUvMHg0MA0KPiA+IDw0PlsgICAxNy40ODczMzddICBwY2lfcmVzZXRfYnVz
KzB4MWViLzB4MjcwDQo+ID4gPDQ+WyAgIDE3LjQ4NzM0MF0gIHZtZF9wcm9iZSsweDc3OC8weGEx
MA0KPiA+IDw0PlsgICAxNy40ODczNDRdICBwY2lfZGV2aWNlX3Byb2JlKzB4OTUvMHgxMjANCj4g
PiA8ND5bICAgMTcuNDg3MzQ2XSAgcmVhbGx5X3Byb2JlKzB4ZDkvMHgzNzANCj4gPiA8ND5bICAg
MTcuNDg3MzQ5XSAgPyBfX3BmeF9fX2RyaXZlcl9hdHRhY2grMHgxMC8weDEwDQo+ID4gPDQ+WyAg
IDE3LjQ4NzM1Ml0gIF9fZHJpdmVyX3Byb2JlX2RldmljZSsweDczLzB4MTUwDQo+ID4gPDQ+WyAg
IDE3LjQ4NzM1NF0gIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgxOS8weGEwDQo+ID4gPDQ+WyAgIDE3
LjQ4NzM1N10gIF9fZHJpdmVyX2F0dGFjaCsweGI2LzB4MTgwDQo+ID4gPDQ+WyAgIDE3LjQ4NzM1
OV0gID8gX19wZnhfX19kcml2ZXJfYXR0YWNoKzB4MTAvMHgxMA0KPiA+IDw0PlsgICAxNy40ODcz
NjJdICBidXNfZm9yX2VhY2hfZGV2KzB4NzcvMHhkMA0KPiA+IDw0PlsgICAxNy40ODczNjVdICBi
dXNfYWRkX2RyaXZlcisweDExMC8weDI0MA0KPiA+IDw0PlsgICAxNy40ODczNjldICBkcml2ZXJf
cmVnaXN0ZXIrMHg1Yi8weDExMA0KPiA+IDw0PlsgICAxNy40ODczNzFdICA/IF9fcGZ4X3ZtZF9k
cnZfaW5pdCsweDEwLzB4MTANCj4gPiA8ND5bICAgMTcuNDg3Mzc0XSAgZG9fb25lX2luaXRjYWxs
KzB4NWMvMHgyYjANCj4gPiA8ND5bICAgMTcuNDg3Mzc4XSAga2VybmVsX2luaXRfZnJlZWFibGUr
MHgxOGUvMHgzNDANCj4gPiA8ND5bICAgMTcuNDg3MzgxXSAgPyBfX3BmeF9rZXJuZWxfaW5pdCsw
eDEwLzB4MTANCj4gPiA8ND5bICAgMTcuNDg3Mzg0XSAga2VybmVsX2luaXQrMHgxNS8weDEzMA0K
PiA+IDw0PlsgICAxNy40ODczODddICByZXRfZnJvbV9mb3JrKzB4MmMvMHg1MA0KPiA+IDw0Plsg
ICAxNy40ODczOTBdICA/IF9fcGZ4X2tlcm5lbF9pbml0KzB4MTAvMHgxMA0KPiA+IDw0PlsgICAx
Ny40ODczOTJdICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gPiA8ND5bICAgMTcuNDg3
Mzk2XSAgPC9UQVNLPg0KPiA+DQoNCg==

