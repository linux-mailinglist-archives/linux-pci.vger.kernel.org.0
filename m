Return-Path: <linux-pci+bounces-8785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B5F908259
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 05:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46F028466D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC361836C7;
	Fri, 14 Jun 2024 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lInu4XKX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E94145323;
	Fri, 14 Jun 2024 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334848; cv=fail; b=YrSWbcC5LuAW0rfqybaQ4iI9HK8trvjTPnchmwqHr7FnjmrK1tWNB62DG/Ze3C/NxlaBleYB2G6V0yKwCl4/kW90kPVEno/0kMkirMMU5m+MJlVC28WuRFJ9xqyfZBrHVbCcuSOk5SnJkmLLH0Gd794by19elSEGOd6M0trYIks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334848; c=relaxed/simple;
	bh=0VL0JT+1HgS/XG2/KV5mg3hcw5vKyIfeKKmfPI/UBFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BA8p4DzI8LDvcIt+5J/EyeJB31WfTs+WilRRUfxFscu8iU8kqki4+4aTmeh+rwOCuUaZ82kQwkliiFvsAwJpTa31Aho9IZOixuSvoH3SIUAuLy/e9AbZvEqlgSJLpBWWkys6n3rWV/K31R5goGE8Ifge/7xjtdWjUCTkgQyr2V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lInu4XKX; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718334847; x=1749870847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0VL0JT+1HgS/XG2/KV5mg3hcw5vKyIfeKKmfPI/UBFI=;
  b=lInu4XKXh65PPk6i3v5/8EeUV+DFkN1omxB1V8O97AS0pjTC6nZ8zsl7
   ed8nu/I60Ab9Upmfy8G+Q9SK+UkjhSITUpi2Fh6MyNQLQHuiGwSv7jC3E
   R+rjqVmd4jU/eR+96tRHVE7aPVmo6yLMpPm63eTUuvRKHEI4ARCaiAujW
   gGb/nwCtt94u9GCliAajpAz3HSg7hDYEd5c8HJTtZ5DBs78EPBWHVdKel
   hdT/ocl/FeSCs7o0lFIeYzfKArdpM9fgo5Gyi3ABIndd4/uy7mVT6hjVW
   vD3gJwJRhpPtFdXx2ykxdMW5TC4uZ203XGUzcgxf79EW0kKj/J0MvSt4w
   A==;
X-CSE-ConnectionGUID: CkIKUgmnTQSsnzaEwts8Cg==
X-CSE-MsgGUID: ODZ1P1LYTCuyA0W5zGRw6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14940685"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="14940685"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 20:14:06 -0700
X-CSE-ConnectionGUID: Hd+Qv4ayRDyGK3rj+FMAXQ==
X-CSE-MsgGUID: auxYRzLoSqmG76foZBQkDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40247346"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 20:14:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 20:14:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 20:14:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 20:14:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 20:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIUijFa93al++/vywWYqnnH89EEqj1gJKoabXWvKCEL5vmK137faR64vh/nGsrK+8yHhi0s0dtOGzem8yIfqzjm375Jz157+wb7dJG9bk/76dlzqybgu2dw4EtO+VNZ96YcKULOgEkSw+lf/wfw37YuTr031RHh+WzQM+pbODvOyzraCBHJJ1pxXFtmBL2GSFTJQ/v43T0O/XCA5fif5yiVXKVIrifk5CDdmjT44l8/bvnJa6sgiq7ZP+KNKNGIfkT7+Ss3rZebxQaESJPfUCWNhWiHTSq3PnzLDIReACoQVtZF10QzWHyJNyFZ1WpQrYwINaXhjhb/D2Czf2wNbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VL0JT+1HgS/XG2/KV5mg3hcw5vKyIfeKKmfPI/UBFI=;
 b=E+tj8Ek9HQSFgcd4NqXmKHGV69j0IQVR9rxy5Uy7fNzsG6hZe+HtC4RZVftwS16cmI2crEBma+YPQe/weRU0kq3yUXFbiqSDQ81ASSh5UwZh4sRRmhcrRPkHHmIw4qBLDSs17HFlBNoplbHgVVMcrhVDGzCWrD3jjpeVBj/lpGUNWD5H5YyIoTRUux7LJQQVxDMmc4G7lC0rr4ATN2beN1WhoB52K4Sy4PJ0CF7IBSNnC6dJbjkiLACRxcET6diFWFtdpmIkWti1xjpfLb9mKfsSGTKmfdaagJa8pH8FUfyqZEDnP7KZX7AxQSSc6ltfBLqUVZb16S6lfDFBvhNpcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB6603.namprd11.prod.outlook.com (2603:10b6:806:271::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23; Fri, 14 Jun
 2024 03:13:56 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 03:13:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "Luck, Tony"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"Schofield, Alison" <alison.schofield@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
	"oohall@gmail.com" <oohall@gmail.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "shiju.jose@huawei.com" <shiju.jose@huawei.com>,
	"Preble, Adam C" <adam.c.preble@intel.com>, "lukas@wunner.de"
	<lukas@wunner.de>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Tsaur, Erwin"
	<erwin.tsaur@intel.com>, "Kuppuswamy, Sathyanarayanan"
	<sathyanarayanan.kuppuswamy@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Wanyan, Feiting" <feiting.wanyan@intel.com>,
	"Wang, Yudong" <yudong.wang@intel.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "qingshun.wang@linux.intel.com"
	<qingshun.wang@linux.intel.com>
Subject: RE: [PATCH v4 1/3] PCI/AER: Store UNCOR_STATUS bits that might be
 ANFE in aer_err_info
Thread-Topic: [PATCH v4 1/3] PCI/AER: Store UNCOR_STATUS bits that might be
 ANFE in aer_err_info
Thread-Index: AQHaoe4ZJMeXZIOhf0eJ3UI3E3k9JbHGbOgAgABWQ4CAAAhoAIAAAbwQ
Date: Fri, 14 Jun 2024 03:13:55 +0000
Message-ID: <SJ0PR11MB67440741E9625433755FFEED92C22@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
 <20240509084833.2147767-2-zhenzhong.duan@intel.com>
 <53a3795b-4ccd-458e-88cd-d510031bc6b6@linux.intel.com>
 <SJ0PR11MB6744B7733567E065F5F3C5C892C22@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ccb9b171-6315-4157-b1a3-cc652c9cf044@linux.intel.com>
In-Reply-To: <ccb9b171-6315-4157-b1a3-cc652c9cf044@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB6603:EE_
x-ms-office365-filtering-correlation-id: d19d5a46-2d5e-4cb1-1f64-08dc8c20068b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?UytJc011azRHL3RpQ0JPNW1sdERaOG5PTDhtQTBaRTZJQkpVV1RzWjRCNW5h?=
 =?utf-8?B?eXdEb2FsTjZWRENOdTV3TjBwWDYvanJjaE93bnhhWjlxQzVicGoybUhodTZW?=
 =?utf-8?B?QWNBcEt6ZXk4QkcrOEtyNGJPcmRpRDVXNktTSUZNd01xNExFbkIxVU8yTUxV?=
 =?utf-8?B?NUU5ZGJjeDlnSVMxcnFsRXh5MmFvMnRFY1pzSldYbDc1Q3Fvc3hoTFkrcmJo?=
 =?utf-8?B?RHA3ejNqUUhoRng4YVdIcW1kWERRU1F4M1JFMW5BenFyRVluNEVNWjdXS0JM?=
 =?utf-8?B?Tk5PejJuQ2RSWitGenloQnZlaHlpT0hiaXVZL3FQZmxjRW5jcVlDTytuL2JM?=
 =?utf-8?B?VUJ3SU1pekx3QVdENzRXV1VEc0Q4MDltemY3amZFaUhlWnNmcnZESDYrN2R0?=
 =?utf-8?B?WFZickpLb2trOUZBb0hmZUFsd3N0ZUR5YXZnQ2diMTNLNXJhTloxeFM2cnBl?=
 =?utf-8?B?VmhLOTJiUGhpN2c2VUVRLyt1SnJyK0dONnQ1Z1dzWDNxdlN5VmZKbGFjVko2?=
 =?utf-8?B?c1ZuWmpacjZPNW0yOHRMZ1oydnlsS2JTVEN4WDR3YlJJYVMvWit5R3c0OWFP?=
 =?utf-8?B?eUw3MlR0OHNnY2ZSSnpRQ2ZMTk1RRTNFZGRpM2F3a21Gd2Y2SXduR3hienJI?=
 =?utf-8?B?R01sRFFkYWdHTGRwUzhaOWNaMlVGWnJBRksxdENzYU1lY1RXcGdhSTZ4enZt?=
 =?utf-8?B?RzdVWW9GN2FHcTgxQTN4ZGs0NFdQdmIrdFdJNDNtRWptUTVtSTYxOGFORXc3?=
 =?utf-8?B?NXdiSFNobEZsaVpid2ZpMzErK1lRSWxtcm1UaGd6R1ZyVTRHM0NWYUdoNXc5?=
 =?utf-8?B?cW5aRVVLdWxRaVl5OXVCWXBiYjhBU0tVK1pCR2MvTTdXSXJmbDhUbXg4Mzk5?=
 =?utf-8?B?MmtPeVhMUDdLOVlGZEhoUUNnRzk5cTNremlrK3hIblk0NWoyZlR6L0swMVVq?=
 =?utf-8?B?dy80aHRqdE04ZWZ0NUNGL3hWUnE0c0RqMU5pNDNTUDFYQkRqemgxM3RrV1My?=
 =?utf-8?B?UHhZZGZVQXp4cjZxb2hMMEE3WWJxc0daKzNEYVROdmxHZEVzdllmcHUxRk1z?=
 =?utf-8?B?Z2hwL1NsWTZ0SXpwSlhyaElDS0VPR1ZkTFpkQVdwZHRqN2dZcXFTUDZxNlh4?=
 =?utf-8?B?aHRWRDNaRmJycUwvT3RNdlFGWE41YVptSFMzTm9xVCtQQXduanBCQ1I3bXd2?=
 =?utf-8?B?V05yZCtiTzkzKzlMWSsrV3h2OTFwMzJxa21aVUducE1YN1hGTzhrSXphVU1X?=
 =?utf-8?B?bjQzWjRCS1l0U1p4djRkemdSTXJjQjJjSUpFU3I1eWxpUC9CWEl2Y1dvMXQx?=
 =?utf-8?B?T0xqbzFESDVVZjB3eHZ1SThoSmxTMFM4VE5VQUorb2FJWnREMHUrbWhIcGxX?=
 =?utf-8?B?d1VGS0p2WFh6QUZjYm9LdE52Yk1vTVAzUVVydmtPYlU5NzRmUU9BZVpRUkhK?=
 =?utf-8?B?aGJ2aDB1YXVMUHFGOU9DZHl2Mm9obzZqRGJkSW5WTjdaSklzQWFaOWUvb0ox?=
 =?utf-8?B?ZmpVL0dvaW9xdW5TeWVWT2ZtTWp1eDQrNkdvZE5FWkp5Tm5Zem91R2FnNVBo?=
 =?utf-8?B?OEpWUWZYOE4yczFLQTRHYjV1dGVyWHNvaFJpK2F5ZkFQM3ZHWEJ0R0oyemRW?=
 =?utf-8?B?T1dKWFBMa3pjdzhEcjhBODZxVXMwZXZTYnNaMVJNRWhaMk1VbUZndGgwWTBE?=
 =?utf-8?B?U01GYnYxTTNoeWhMT3V6dUhOWnV1RmhqVFhXQk5BZHhrKzd5Tit0TTdxLzBo?=
 =?utf-8?Q?wzCPrqcGOwLDnQnVsVh+TFQdYa8L3birESLk13p?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qi9sd3dUL01zM3ViTWpuM2lBYVZaaDNlSzNqbjZ6aXkrY05xQS9LZTBzc0l5?=
 =?utf-8?B?U3dZYzdhN3REZEpmZ2psSHh1YVpFQS9NR0lmTVQxbXVucFdLQVBoaGhEcE0w?=
 =?utf-8?B?SkpyMVY5d0JpbUxqVGhBejBOY0NjN1gwbnIwazVzckU0bzJ6STJVQnZLSERZ?=
 =?utf-8?B?SE0ra0hhdDBIS3U4OUlkSEcwd2NsYithUVJSNlJKdEttUFJNQUtUNzUxaklU?=
 =?utf-8?B?ZmR6d1F3dGRTNk5YMmxDSDZWUzgzbTJEclpxWGI1Umw3ZUJRZnlUV3BBSU9X?=
 =?utf-8?B?blJMeVZmQ3ViWmtzTG8zOURCeGVkekhHK0g4aE9oQ3E0bzJyc0loMjMyalpz?=
 =?utf-8?B?RHFNMmR1STVvbDV2Z2dhN2loVE01QnVIVHRRWmxMMUFEa0FvWS83WXlLUHZj?=
 =?utf-8?B?dEFoWE91UGNFRkFZNHU0V3VycGswVCtXcWszekJWcWpkSk85akxlTXhicjds?=
 =?utf-8?B?SFhiNTVxR205RUZ4cW5aeHlqR05lMTdBTkIrWlRIZjJtWXlaV2xpQmFqWExK?=
 =?utf-8?B?QURkOWwyM09LTWlvZTVleHFTa0FjS3pKNHlTaFJpdWJkd2RVeExsRmpqZ09P?=
 =?utf-8?B?TW8zL3p6anpLOXR1cG83SUE2WG52UjF1QVhjOVBRMDdoM1RCcW9lenhBVlcv?=
 =?utf-8?B?ejhYbHJnWjc3TlpqQ25Semw1TVdrMFBiMUZxaHpuMjFQMCtSV1kra0s1bmNo?=
 =?utf-8?B?QUFRUUpsWGYwaXZVckhIeFpHamVxOXN6ZGxTT0VjaW03N0hZVGwyNFgydG9O?=
 =?utf-8?B?NjZWZzVJS1RFcm9sMUp6b2w5SkhITU12blVBT2lMcndHQzBtWnVPS1N3MHQ3?=
 =?utf-8?B?elcxTUYvNlpBdkdVTC8zVHJ2Lzk4L3dqNkRDTG5oRWVITW9BRmdYaFFYWm4w?=
 =?utf-8?B?NmtXZW84dnFTMUFvbDArcHZjNTdCS3J6TnFDL0cxSExoODVWak5KakV1YXJP?=
 =?utf-8?B?c0pTOGMvK2tsTVNRZ0lSZG5aaEppc1V2Z1ZLem1VblNvaktqSnVWbXVxSTBu?=
 =?utf-8?B?VHZUblA5dTMySjkrRHB2TmdjbUhTVmNwZk9lQVJFTWMreldSdnRuUnl0eUZt?=
 =?utf-8?B?N3pkaGtCMmZKaStOR3dLVGMwQUdvaXV1aWJBVjBCazZEM2dEd3dNTEtjSU51?=
 =?utf-8?B?SjhYQlFVbkZJS2dQOTJoLytlbFFqMDVjaWlnZDRCRWlDc0dub3VNMmhSSFJO?=
 =?utf-8?B?djJGYVBEMzdzaFcweGxDSWpKeXo4QVpaRUhyWGFtcXhzcFhkanErV2JOQkN4?=
 =?utf-8?B?ZitCNG5ab2xGYWVSNGF6M0haQ2lLeHV0N05sbmFyNS82M1Y1cEdqN2dJMTRT?=
 =?utf-8?B?SUFycTl3ZkF5SXo2ZnFNeE96RXcvR0FBc1FPOVZUQzB4Z0VDMldRbWZ3b0FK?=
 =?utf-8?B?MUs3MVkrVWE5aG92SGdXNnNXRzU4dWtBZTVlTVVhQkpWMk4ycVJUMVZvUCtX?=
 =?utf-8?B?RkhMU041bmlZU28xZzlyOCtDbFZTZ3ptMXFtMGFMRVpIU3AyOHZhdGpwUmcx?=
 =?utf-8?B?LzB4TVpLNzZPb3lnbFYzVysrTjRIcmc1VzM5K2ovNkc5REpkMitpUjArUE9M?=
 =?utf-8?B?RHJUeER1Z2hZSmttZHR4ODN3a3FEMlUzbzRFVklUaUxERXJhQkRiSFErOXhS?=
 =?utf-8?B?a1VObEp5QmV6d2RTZlN1VEFIczhXODVSYnJ5T3MvdkE4a1RCMjhIbXZXN1Bl?=
 =?utf-8?B?US9DcE5yZFZlMFFBMi84MHZsS0hCVjFTQ1dTQkRleWovM0RMb3FWU3EzSi9o?=
 =?utf-8?B?N3gzd2J2WmVWUjRYQ1lCMVpCeU5udWtia1FRYXB2dzBMV0FlRzlpVUVCV012?=
 =?utf-8?B?bG11OWVUZnlXTzZQajZNTTg4NExFbVAydHNKTnlLZlJUbm1SZHhnU1I4VFo4?=
 =?utf-8?B?VkJvc1Jqd0UwTmZvZjNNeUI2VTJqUXo4NUlheUlqa294ZWlVRmM5R1NxVDVZ?=
 =?utf-8?B?OU4zdFRrMFRPMGY2b0RGT0Z4bGZmb2FVTUM4ekdxMm5xNVhmNFFhTFFid0k3?=
 =?utf-8?B?QzNobVIzWG9wd21hR1d2R3R2QStIT3NkQTVpSjFzTWxoOGdHdm4xQkNaTWkz?=
 =?utf-8?B?eWpHbHllUkdaM2c2ak9ueFRBeGVjK0xJVVhNaXQ3UlphdzBWQVhPeGNoaHY1?=
 =?utf-8?Q?1m8Z0pttvVN81DM433SeyU9lx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19d5a46-2d5e-4cb1-1f64-08dc8c20068b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 03:13:55.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHiseqwmibsESfN9hAzriavRkfxeVcRoZ8Yzmi4dlGOd+p57e8F4SCQDtVdfQSMByaoqOCmBvuAfBUb+4DDSdS6/JT9qHThA5NrUFUwnwLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6603
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEt1cHB1c3dhbXkgU2F0aHlh
bmFyYXlhbmFuDQo+PHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4N
Cj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvM10gUENJL0FFUjogU3RvcmUgVU5DT1JfU1RBVFVT
IGJpdHMgdGhhdCBtaWdodA0KPmJlIEFORkUgaW4gYWVyX2Vycl9pbmZvDQo+DQo+DQo+T24gNi8x
My8yNCA3OjM5IFBNLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+PiBIaQ0KPj4NCj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlh
bmFuDQo+Pj4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4NCj4+
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvM10gUENJL0FFUjogU3RvcmUgVU5DT1JfU1RBVFVT
IGJpdHMgdGhhdA0KPm1pZ2h0DQo+Pj4gYmUgQU5GRSBpbiBhZXJfZXJyX2luZm8NCj4+Pg0KPj4+
IEhpLA0KPj4+DQo+Pj4gT24gNS85LzI0IDE6NDggQU0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0K
Pj4+PiBJbiBzb21lIGNhc2VzIHRoZSBkZXRlY3RvciBvZiBhIE5vbi1GYXRhbCBFcnJvcihORkUp
IGlzIG5vdCB0aGUgbW9zdA0KPj4+PiBhcHByb3ByaWF0ZSBhZ2VudCB0byBkZXRlcm1pbmUgdGhl
IHR5cGUgb2YgdGhlIGVycm9yLiBGb3IgZXhhbXBsZSwNCj4+Pj4gd2hlbiBzb2Z0d2FyZSBwZXJm
b3JtcyBhIGNvbmZpZ3VyYXRpb24gcmVhZCBmcm9tIGEgbm9uLWV4aXN0ZW50DQo+Pj4+IGRldmlj
ZSBvciBGdW5jdGlvbiwgY29tcGxldGVyIHdpbGwgc2VuZCBhbiBFUlJfTk9ORkFUQUwgTWVzc2Fn
ZS4NCj4+Pj4gT24gc29tZSBwbGF0Zm9ybXMsIEVSUl9OT05GQVRBTCByZXN1bHRzIGluIGEgU3lz
dGVtIEVycm9yLCB3aGljaA0KPj4+PiBicmVha3Mgbm9ybWFsIHNvZnR3YXJlIHByb2JpbmcuDQo+
Pj4+DQo+Pj4+IEFkdmlzb3J5IE5vbi1GYXRhbCBFcnJvcihBTkZFKSBpcyBhIHNwZWNpYWwgY2Fz
ZSB0aGF0IGNhbiBiZSB1c2VkDQo+Pj4+IGluIGFib3ZlIHNjZW5hcmlvLiBJdCBpcyBwcmVkb21p
bmFudGx5IGRldGVybWluZWQgYnkgdGhlIHJvbGUgb2YgdGhlDQo+Pj4+IGRldGVjdGluZyBhZ2Vu
dCAoUmVxdWVzdGVyLCBDb21wbGV0ZXIsIG9yIFJlY2VpdmVyKSBhbmQgdGhlIHNwZWNpZmljDQo+
Pj4+IGVycm9yLiBJbiBzdWNoIGNhc2VzLCBhbiBhZ2VudCB3aXRoIEFFUiBzaWduYWxzIHRoZSBO
RkUgKGlmIGVuYWJsZWQpDQo+Pj4+IGJ5IHNlbmRpbmcgYW4gRVJSX0NPUiBNZXNzYWdlIGFzIGFu
IGFkdmlzb3J5IHRvIHNvZnR3YXJlLCBpbnN0ZWFkIG9mDQo+Pj4+IHNlbmRpbmcgRVJSX05PTkZB
VEFMLg0KPj4+Pg0KPj4+PiBXaGVuIHByb2Nlc3NpbmcgYW4gQU5GRSwgaWRlYWxseSBib3RoIGNv
cnJlY3RhYmxlIGVycm9yKENFKSBzdGF0dXMgYW5kDQo+Pj4+IHVuY29ycmVjdGFibGUgZXJyb3Io
VUUpIHN0YXR1cyBzaG91bGQgYmUgY2xlYXJlZC4gSG93ZXZlciwgdGhlcmUgaXMgbm8NCj4+Pj4g
d2F5IHRvIGZ1bGx5IGlkZW50aWZ5IHRoZSBVRSBhc3NvY2lhdGVkIHdpdGggQU5GRS4gRXZlbiB3
b3JzZSwgTm9uLUZhdGFsDQo+Pj4+IEVycm9yKE5GRSkgbWF5IHNldCB0aGUgc2FtZSBVRSBzdGF0
dXMgYml0IGFzIEFORkUuIFRyZWF0aW5nIGFuIEFORkUgYXMNCj4+Pj4gTkZFIHdpbGwgcmVwcm9k
dWNlIGFib3ZlIG1lbnRpb25lZCBpc3N1ZSwgaS5lLiwgYnJlYWtpbmcgc29mdHdvcmUNCj5wcm9i
aW5nOw0KPj4+PiB0cmVhdGluZyBORkUgYXMgQU5GRSB3aWxsIG1ha2UgdXMgaWdub3Jpbmcgc29t
ZSBVRXMgd2hpY2ggbmVlZCBhY3RpdmUNCj4+Pj4gcmVjb3ZlciBvcGVyYXRpb24uIFRvIGF2b2lk
IGNsZWFyaW5nIFVFcyB0aGF0IGFyZSBub3QgQU5GRSBieSBhY2NpZGVudCwNCj4+Pj4gdGhlIG1v
c3QgY29uc2VydmF0aXZlIHJvdXRlIGlzIHRha2VuIGhlcmU6IElmIGFueSBvZiB0aGUgTkZFIERl
dGVjdGVkDQo+Pj4+IGJpdHMgaXMgc2V0IGluIERldmljZSBTdGF0dXMsIGRvIG5vdCB0b3VjaCBV
RSBzdGF0dXMsIHRoZXkgc2hvdWxkIGJlDQo+Pj4+IGNsZWFyZWQgbGF0ZXIgYnkgdGhlIFVFIGhh
bmRsZXIuIE90aGVyd2lzZSwgYSBzcGVjaWZpYyBzZXQgb2YgVUVzIHRoYXQNCj4+Pj4gbWF5IGJl
IHJhaXNlZCBhcyBBTkZFIGFjY29yZGluZyB0byB0aGUgUENJZSBzcGVjaWZpY2F0aW9uIHdpbGwg
YmUgY2xlYXJlZA0KPj4+PiBpZiB0aGVpciBjb3JyZXNwb25kaW5nIHNldmVyaXR5IGlzIE5vbi1G
YXRhbC4NCj4+Pj4NCj4+Pj4gVG8gYWNoaWV2ZSBhYm92ZSBwdXJwb3NlLCBzdG9yZSBVTkNPUl9T
VEFUVVMgYml0cyB0aGF0IG1pZ2h0IGJlDQo+QU5GRQ0KPj4+PiBpbiBhZXJfZXJyX2luZm8uYW5m
ZV9zdGF0dXMuIFNvIHRoYXQgdGhvc2UgYml0cyBjb3VsZCBiZSBwcmludGVkIGFuZA0KPj4+PiBw
cm9jZXNzZWQgbGF0ZXIuDQo+Pj4+DQo+Pj4+IFRlc3RlZC1ieTogWXVkb25nIFdhbmcgPHl1ZG9u
Zy53YW5nQGludGVsLmNvbT4NCj4+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiAiV2FuZywgUWluZ3NodW4i
IDxxaW5nc2h1bi53YW5nQGxpbnV4LmludGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogIldh
bmcsIFFpbmdzaHVuIiA8cWluZ3NodW4ud2FuZ0BsaW51eC5pbnRlbC5jb20+DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+
IC0tLQ0KPj4+PiAgZHJpdmVycy9wY2kvcGNpLmggICAgICB8ICAxICsNCj4+Pj4gIGRyaXZlcnMv
cGNpL3BjaWUvYWVyLmMgfCA1Mw0KPj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspDQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2kuaCBiL2RyaXZlcnMvcGNpL3BjaS5o
DQo+Pj4+IGluZGV4IDE3ZmVkMTg0Njg0Ny4uM2Y5ZWI4MDdmOWZkIDEwMDY0NA0KPj4+PiAtLS0g
YS9kcml2ZXJzL3BjaS9wY2kuaA0KPj4+PiArKysgYi9kcml2ZXJzL3BjaS9wY2kuaA0KPj4+PiBA
QCAtNDEyLDYgKzQxMiw3IEBAIHN0cnVjdCBhZXJfZXJyX2luZm8gew0KPj4+Pg0KPj4+PiAgCXVu
c2lnbmVkIGludCBzdGF0dXM7CQkvKiBDT1IvVU5DT1IgRXJyb3IgU3RhdHVzICovDQo+Pj4+ICAJ
dW5zaWduZWQgaW50IG1hc2s7CQkvKiBDT1IvVU5DT1IgRXJyb3IgTWFzayAqLw0KPj4+PiArCXVu
c2lnbmVkIGludCBhbmZlX3N0YXR1czsJLyogVU5DT1IgRXJyb3IgU3RhdHVzIGZvciBBTkZFICov
DQo+Pj4+ICAJc3RydWN0IHBjaWVfdGxwX2xvZyB0bHA7CS8qIFRMUCBIZWFkZXIgKi8NCj4+Pj4g
IH07DQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2llL2Flci5jIGIvZHJp
dmVycy9wY2kvcGNpZS9hZXIuYw0KPj4+PiBpbmRleCBhYzYyOTNjMjQ5NzYuLmYyODM5YjUxMzIx
YSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9wY2kvcGNpZS9hZXIuYw0KPj4+PiArKysgYi9k
cml2ZXJzL3BjaS9wY2llL2Flci5jDQo+Pj4+IEBAIC0xMDcsNiArMTA3LDEyIEBAIHN0cnVjdCBh
ZXJfc3RhdHMgew0KPj4+PiAgCQkJCQlQQ0lfRVJSX1JPT1RfTVVMVElfQ09SX1JDViB8DQo+Pj4g
CVwNCj4+Pj4gIAkJCQkJUENJX0VSUl9ST09UX01VTFRJX1VOQ09SX1JDVikNCj4+Pj4NCj4+Pj4g
KyNkZWZpbmUgQUVSX0VSUl9BTkZFX1VOQ19NQVNLDQo+Pj4gCShQQ0lfRVJSX1VOQ19QT0lTT05f
VExQIHwJXA0KPj4+PiArCQkJCQlQQ0lfRVJSX1VOQ19DT01QX1RJTUUgfA0KPj4+IAlcDQo+Pj4+
ICsJCQkJCVBDSV9FUlJfVU5DX0NPTVBfQUJPUlQgfA0KPj4+IAlcDQo+Pj4+ICsJCQkJCVBDSV9F
UlJfVU5DX1VOWF9DT01QIHwNCj4+PiAJXA0KPj4+PiArCQkJCQlQQ0lfRVJSX1VOQ19VTlNVUCkN
Cj4+Pj4gKw0KPj4+PiAgc3RhdGljIGludCBwY2llX2Flcl9kaXNhYmxlOw0KPj4+PiAgc3RhdGlj
IHBjaV9lcnNfcmVzdWx0X3QgYWVyX3Jvb3RfcmVzZXQoc3RydWN0IHBjaV9kZXYgKmRldik7DQo+
Pj4+DQo+Pj4+IEBAIC0xMTk2LDYgKzEyMDIsNDkgQEAgdm9pZCBhZXJfcmVjb3Zlcl9xdWV1ZShp
bnQgZG9tYWluLA0KPnVuc2lnbmVkDQo+Pj4gaW50IGJ1cywgdW5zaWduZWQgaW50IGRldmZuLA0K
Pj4+PiAgRVhQT1JUX1NZTUJPTF9HUEwoYWVyX3JlY292ZXJfcXVldWUpOw0KPj4+PiAgI2VuZGlm
DQo+Pj4+DQo+Pj4+ICtzdGF0aWMgdm9pZCBhbmZlX2dldF91Y19zdGF0dXMoc3RydWN0IHBjaV9k
ZXYgKmRldiwgc3RydWN0IGFlcl9lcnJfaW5mbw0KPj4+ICppbmZvKQ0KPj4+PiArew0KPj4+PiAr
CXUzMiB1bmNvcl9tYXNrLCB1bmNvcl9zdGF0dXMsIGFuZmVfc3RhdHVzOw0KPj4+PiArCXUxNiBk
ZXZpY2Vfc3RhdHVzOw0KPj4+PiArCWludCBhZXIgPSBkZXYtPmFlcl9jYXA7DQo+Pj4+ICsNCj4+
Pj4gKwlwY2lfcmVhZF9jb25maWdfZHdvcmQoZGV2LCBhZXIgKyBQQ0lfRVJSX1VOQ09SX1NUQVRV
UywNCj4+PiAmdW5jb3Jfc3RhdHVzKTsNCj4+Pj4gKwlwY2lfcmVhZF9jb25maWdfZHdvcmQoZGV2
LCBhZXIgKyBQQ0lfRVJSX1VOQ09SX01BU0ssDQo+Pj4gJnVuY29yX21hc2spOw0KPj4+PiArCS8q
DQo+Pj4+ICsJICogQWNjb3JkaW5nIHRvIFBDSWUgQmFzZSBTcGVjaWZpY2F0aW9uIFJldmlzaW9u
IDYuMSwNCj4+Pj4gKwkgKiBTZWN0aW9uIDYuMi4zLjIuNCwgaWYgYW4gVU5DT1IgZXJyb3IgaXMg
cmFpc2VkIGFzDQo+Pj4+ICsJICogQWR2aXNvcnkgTm9uLUZhdGFsIGVycm9yLCBpdCB3aWxsIG1h
dGNoIHRoZSBmb2xsb3dpbmcNCj4+Pj4gKwkgKiBjb25kaXRpb25zOg0KPj4+PiArCSAqCWEuIFRo
ZSBzZXZlcml0eSBvZiB0aGUgZXJyb3IgaXMgTm9uLUZhdGFsLg0KPj4+PiArCSAqCWIuIFRoZSBl
cnJvciBpcyBvbmUgb2YgdGhlIGZvbGxvd2luZzoNCj4+Pj4gKwkgKgkJMS4gUG9pc29uZWQgVExQ
ICAgICAgICAgICAoU2VjdGlvbiA2LjIuMy4yLjQuMykNCj4+Pj4gKwkgKgkJMi4gQ29tcGxldGlv
biBUaW1lb3V0ICAgICAoU2VjdGlvbiA2LjIuMy4yLjQuNCkNCj4+Pj4gKwkgKgkJMy4gQ29tcGxl
dGVyIEFib3J0ICAgICAgICAoU2VjdGlvbiA2LjIuMy4yLjQuMSkNCj4+Pj4gKwkgKgkJNC4gVW5l
eHBlY3RlZCBDb21wbGV0aW9uICAoU2VjdGlvbiA2LjIuMy4yLjQuNSkNCj4+Pj4gKwkgKgkJNS4g
VW5zdXBwb3J0ZWQgUmVxdWVzdCAgICAoU2VjdGlvbiA2LjIuMy4yLjQuMSkNCj4+Pj4gKwkgKi8N
Cj4+Pj4gKwlhbmZlX3N0YXR1cyA9IHVuY29yX3N0YXR1cyAmIH51bmNvcl9tYXNrICYgfmluZm8t
PnNldmVyaXR5ICYNCj4+Pj4gKwkJICAgICAgQUVSX0VSUl9BTkZFX1VOQ19NQVNLOw0KPj4+PiAr
DQo+Pj4+ICsJaWYgKHBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQoZGV2LCBQQ0lfRVhQX0RFVlNU
QSwNCj4+PiAmZGV2aWNlX3N0YXR1cykpDQo+Pj4+ICsJCXJldHVybjsNCj4+Pj4gKwkvKg0KPj4+
PiArCSAqIFRha2UgdGhlIG1vc3QgY29uc2VydmF0aXZlIHJvdXRlIGhlcmUuIElmIHRoZXJlIGFy
ZSBOb24tRmF0YWwNCj4+PiBlcnJvcnMNCj4+Pj4gKwkgKiBkZXRlY3RlZCwgZG8gbm90IGFzc3Vt
ZSBhbnkgYml0IGluIHVuY29yX3N0YXR1cyBpcyBzZXQgYnkgQU5GRS4NCj4+Pj4gKwkgKi8NCj4+
Pj4gKwlpZiAoZGV2aWNlX3N0YXR1cyAmIFBDSV9FWFBfREVWU1RBX05GRUQpDQo+Pj4+ICsJCXJl
dHVybjsNCj4+PiBZb3UgY2FuIG1vdmUgdGhpcyBjaGVjayB0byB0aGUgdG9wIG9mIHRoZSBmdW5j
dGlvbi4gWW91IGRvbid0IG5lZWQgdG8NCj5jaGVjaw0KPj4+IHRoZSByZXN0IGlmIE5GRSBlcnJv
ciBpcyBkZXRlY3RlZCBpbiBkZXZpY2Ugc3RhdHVzLg0KPj4gVGhlIHYzIGp1c3Qgd29ya2VkIHRo
YXQgd2F5LiBKb25hdGhhbiBwb2ludGVkIGEgcmFjZSB0aGF0IE5GRSB0cmlnZ2VyZWQNCj5hZnRl
cg0KPj4gdGhlIGNoZWNrIHdpbGwgYmUgdHJlYXRlZCBhcyBBTkZFIGFuZCBjbGVhcmVkLiBDaGVj
ayBpdCBhZnRlciByZWFkaW5nDQo+VU5DT1JfU1RBVFVTDQo+PiBjYW4gYXZvaWQgdGhlIHJhY2Uu
DQo+Pg0KPj4gU2VlIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDI0LzQvMjIvMTAxMSBmb3IgZGlz
Y3Vzc2lvbiBkZXRhaWxzLg0KPg0KPkdvdCBpdC4gSSB3b3VsZCByZWNvbW1lbmQgYWRkaW5nIGEg
Y29tbWVudCBhYm91dCBpdCBpbiBoYW5kbGVyLiBNYXkgYmUNCj5zb21lIHRoaW5nIGxpa2UsDQo+
DQo+LyoNCj7CoCogVG8gYXZvaWQgcmFjZSBiZXR3ZWVuIGRldmljZSBzdGF0dXMgcmVhZCBhbmQg
ZXJyb3Igc3RhdHVzIHJlZ2lzdGVyIHJlYWQsDQo+Y2FjaGUNCj7CoCogdW5jb3JyZWN0YWJsZSBl
cnJvciBzdGF0dXMgYmVmb3JlIGNoZWNraW5nIGZvciBORkUgaW4gZGV2aWNlIHN0YXR1cyAqDQo+
cmVnaXN0ZXIuICovDQoNCkdvb2Qgc3VnZ2VzdGlvbiwgd2lsbCBhZGQuDQoNClRoYW5rcw0KWmhl
bnpob25nDQo=

