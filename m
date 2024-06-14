Return-Path: <linux-pci+bounces-8781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50BB9081BD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 04:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ACF4B21D4B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 02:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F808183092;
	Fri, 14 Jun 2024 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5fBzstB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE1183085;
	Fri, 14 Jun 2024 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332792; cv=fail; b=Kea/rpp9bF8roPsFhBttMFEozQEjUo9YACqjLR/h8yJIgWph1x1SXoi/Mm7QRb1gAmG2KzXA3ffIVrbpSC34sxSVZWgXAEFcaTgZusg+rdsNd5c3d7lHTd+fwrYYxR1Ci2GzmAQlnrJ9LkMK4TG95w27rel5A92RbPnJ98WRFdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332792; c=relaxed/simple;
	bh=0SpWKrms84+5HbC3vrJFOv4m7IOV4W14xSYiOQV29bM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NtLp7mTBxCOkJL7tQlzwnCf/wMa72zi8pv4+cuvabbCytSL1uhiAHGDIffLFNomryldGjOPSq1+wfZpKYR6uZPXZ8sqiazapKrrP+A2sg7AW2vtacAkO+SbxYkd3I5adFsnrE5LyNbaSo/8OsS9w+SP2qZ0a0dPE63m3ToHkwM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5fBzstB; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718332790; x=1749868790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0SpWKrms84+5HbC3vrJFOv4m7IOV4W14xSYiOQV29bM=;
  b=I5fBzstBTyWK+2b+tDsHSTxPvPIfICALMOOvXyG+OY1ce2eBHjmBBfPr
   fF94oR9o7PpW5GqvtW1iW8v6o8ApcJnlUFauh7z5eTSS492G6zPXVi8vN
   LjyaqKNJdkdjVdJCr0yn1dpnx/D7Uq1stXt6nZrKDvf9viCK87dvQ7bvk
   AwwfNUXlltG22Ln9gYq2v1CXzzxHAnVCXtS00j2O1FlRF4I+wKqSXmEVz
   zRvlOj7BzQ64OqZiPxOLxCBEZwTJdcRr5MYE2cg38d0v++8+B9M8vJiVb
   w56hLmysSTgTQzyYJFuLEu6t5NxAwE18xztsNhBRtaJGc7Bis0Sf5Wj/L
   A==;
X-CSE-ConnectionGUID: s+BEr5k9Q1OcnsprubUbZA==
X-CSE-MsgGUID: k6a0RbEvSjSXV//IryMw+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14937384"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="14937384"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 19:39:49 -0700
X-CSE-ConnectionGUID: m06NWP8wRhC+8h/yJBN0gw==
X-CSE-MsgGUID: fVXCtV2YQ3mBYb5XwwqZWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="44736721"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 19:39:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 19:39:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 19:39:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 19:39:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 19:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3LdVuuK6zJXx4QIkkNava3U8ipO4Gb4jkIqb79e4voT3O49/IDVNmXInZX5I7yOyIuTRzKkz40odf6RA4DoCzTwdmz7T2thMQXgLyZZrn2dTcPhbQ4Q2/ALRmbV4U3B4nP4rFg5hESYl6fXrUgp/RADzPJUpYHVP2knnLFVXPxg/UPDLXmaOB/Cs9uog2yvvBHah+ZKPw7xThZgHCg9vuBG6yGqsAxeFqrayGT9A8uXDKQqkqMMb4bmdxa2IkI3pw9cslPDmSyvitXTc6eNFuhVXCcmrHD3clj2PpNL0Kjf6G7ZKiD3mcXUYmDxPTzGcorMKzZOozBoZAvLPK2+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SpWKrms84+5HbC3vrJFOv4m7IOV4W14xSYiOQV29bM=;
 b=Hu82VyD7wDCvcTCpj+oRCAcn4hX7FMtw2uEL1/vEqpc+QoWJFQmo4uqBTLbNmnXWdBLVWzFchr/D1hOOFyf4ShOfPD5rnWY8dMLuVZ5gDO4q6ZBC0GhV2Wkfzk5KlOibdTDKaEhGBCum+n/TERV+u3vNvCK4mW0SZmp8JjF2D743+Gp0AgTeDFZKDusNUTfCdwWybzFEBilH0ItUKqhKRnzCn1q9rRoy7d90XDVEvVrF+j8Ox9FotFvNdFVN8fZqeMg+pUd7t8L0KmCwSivNIE02LleN1Df4GJN4FCuWsaBYR1zJyANhuDAqGHr7JwLnsidNukP5Ma8cSlRqBvG/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB7855.namprd11.prod.outlook.com (2603:10b6:208:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 02:39:44 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 02:39:44 +0000
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
Thread-Index: AQHaoe4ZJMeXZIOhf0eJ3UI3E3k9JbHGbOgAgABWQ4A=
Date: Fri, 14 Jun 2024 02:39:44 +0000
Message-ID: <SJ0PR11MB6744B7733567E065F5F3C5C892C22@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
 <20240509084833.2147767-2-zhenzhong.duan@intel.com>
 <53a3795b-4ccd-458e-88cd-d510031bc6b6@linux.intel.com>
In-Reply-To: <53a3795b-4ccd-458e-88cd-d510031bc6b6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB7855:EE_
x-ms-office365-filtering-correlation-id: cf53f6b0-5ef5-4691-bdcf-08dc8c1b4017
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|376009|7416009|366011|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?Y1hGazlMaHZmbTlZRHBnVUdVa2k3dUR4d3lxZTdzRG56aFc2eHhDbEphclRy?=
 =?utf-8?B?bXhTZ3YrZ2l3ck8yK2NXZ1VlZEhSdzRaYlpQTlpteXhRaDc5OHJpMEZHSmMr?=
 =?utf-8?B?anhqeEF2NjM4bjlhM2lnR29wQjQ1UUdOUTF3emtpVFh6aUc4TFFVZTBDMkJr?=
 =?utf-8?B?QXpYbC9rR204ZlZYYmZXSmM5NjE0Ui84NkR6ZG5oWWViUVNuQ3R3Q01LSVpZ?=
 =?utf-8?B?M0crZnJvRzRrSGZLaW1MeVBqNElVWC9RMDE2WEpJemZkMTlyWmRxZlAvS1Vy?=
 =?utf-8?B?MFZxcXNZK0I2ZHd5T2Q4elFRaWhCRGlLSk0zM08zRiszSTdXQkdZNE91bklN?=
 =?utf-8?B?WGx2WGh4cEpVUGtzRXpIU2hEZTY5TjBaVEpOM0VEeWRnUklTbHh1d1YyUHdx?=
 =?utf-8?B?Ynp6MmZqQVBqRmhyV2hET2NDeitJUGNrSjNRazVRMGkxc1Z1SG5tQTNtZkpm?=
 =?utf-8?B?SiszcC93MFY1WkZPL3ArdFRERGt6Z3pGaElySmFWcy9neDJGSkZESmsrbk11?=
 =?utf-8?B?cWZLRXJ6Wm4rc2toRThpT3FjWEcyNzNRMlNyU2wrVDdsbnlJRDVoOFJHMnVU?=
 =?utf-8?B?MFl6b1ByelpxZkpJeGcxMXNvV1gzcUU1NkdLRkdpQk5QY3Q5ZVFyQUYycGxH?=
 =?utf-8?B?eDE3SHh6ZllxZmpneXBtOEs1ZTgrekc4K1IrRzJ6ZGRFeW52WXFEcjRXdG0r?=
 =?utf-8?B?U1JiSzQrT0pycEovVnRLWUZYcXp1QTJ0UGw4WXNkR0Fhdk5iOWJsb0VsZDZz?=
 =?utf-8?B?TVRyM1FkSld3WHFQUnNHTlpqM0xIcjJmYzlSWGtPN3FLKzFjVGhxQkVBa2tF?=
 =?utf-8?B?aXpseVkzZ29xaXpPTGNyOUlzbVFycnlzZjNiUWdOdVhWSHFNd1pQVEoxcm5N?=
 =?utf-8?B?VUtVcE5WZVo4a3V0RTdsMWtMTEEyaTlmNjNkYnkxVkFEQUdXWE5ORTR1cVVs?=
 =?utf-8?B?c3R0UlExT0xja0NHMXkvb2QxNy9JK3NNMEtBVExYK25UVXpYRU9mRnNBRTYr?=
 =?utf-8?B?R2Z2N3UrNDl3N0lzSmFmdGt5RXVTVUU0NHpNTk9uOE5ybEVCS014Vkw4L1ZZ?=
 =?utf-8?B?WTloVmVvMUlLdHdHcUkyWVMwRUhrZ2czTmxQeC9xakVmWGRkRmJUbnpiakRV?=
 =?utf-8?B?Mzk5ZndOenBCaXlKcCszK3BTSk1GdGFRcUxkb2V3MlQwT01YaVF5aE9GZUIr?=
 =?utf-8?B?Ty9LUHpUamtIUkJsSTJDN1phdURNQ1E5QUtsSmVvUFVPZWR5Y2lpVEMyNDVS?=
 =?utf-8?B?T1hMaVJsbXN6bXJiaGV1OGdhdzJ1R05GdFNrU3k5MWY3THk0bFI0SVN1WXZl?=
 =?utf-8?B?dG5WL3JsQ1F3MHBOVlVhRjZ4cjdSVi9GaDV0VmdnV0FBRUorOTVpZVZPZ29a?=
 =?utf-8?B?QTFWaGJvVjEzSVhIMURpRXNSMUpMMVRNbDlXQjZmdXBoU3NPT3JlakYzNEJN?=
 =?utf-8?B?KzBsVHJrbmFDaWcwVGMwclNZZ2Y4VEhnQ3JjOThqRlhSV0ExWFRaT2tpNEU2?=
 =?utf-8?B?enk4U20xMFZuRUdWZ1IrcUY2VndzaHp0NmtFbHJCK1VLVnpLNVcybmZhVXJh?=
 =?utf-8?B?ZngwMDBCanFRZjdkRDNpMUVONC9sbjZEQXNraHhlS2lmT2dSOVFXdFRiaDRQ?=
 =?utf-8?B?bnhwOWp4Sk9RdnVmR3I1b3RmSTNYZCsrT2RxdVd5Uy9nOHlFY3hrcCt6U2lx?=
 =?utf-8?B?TnRGUXBqNjJLMU14MDZ6dDZ1QTRaU0hXajlBak5GMldRTDB2SGxxaDdoSkVW?=
 =?utf-8?Q?wHpeAThjWv3fw9F/mboCONCnYxby4toj3vQKTow?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(376009)(7416009)(366011)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWFMeXRVQjhvdHJ3VHRRZll6Y1ZpQnpmekRjdWRXYzhiMlpIN0doSWt6bytz?=
 =?utf-8?B?cWtodnlaRnF1VTE4Z0ZiUVlqRzBmekRqdTdiK0hGcy9uUkFZbXRoUzF6VE1F?=
 =?utf-8?B?L0huYWpZKzhXQVR2L3RMcWsxYUQrL0hSUTl2aW85dFE0SFBhUlk0VFhzWFZz?=
 =?utf-8?B?ektHd1lucnR6YitTQ01vYklEanNFTGlLQ1dEMkVUY0FiWE5jMkJoRmwwbmlp?=
 =?utf-8?B?aHBNOGpqQmIwRVFOdGE5UzZjdTZrWjJ4YnFwVndnaDJ3SVU4WkpmVkt5akp5?=
 =?utf-8?B?aWR5bjdRdzRnUzZYMis5UlUwWVVvbjVONW16NmorQkk0cFpreFBWWFdyK0tv?=
 =?utf-8?B?bWhUbkJHSWFiVGlnTEYwYWlMTUg3emJNUFE0Q3plWmJyVE0vYkllcnZnclNW?=
 =?utf-8?B?blhFQTJONnhyVVNzY1VISmo4S3ZDQUlaUnlTUERyaVN6R3FjdDNscFQ2UTIw?=
 =?utf-8?B?ZytkeUxoYm5qL3g0M1hFTjFrQ3hRUUlPRWNmZCtiREFEYzhFN3I1TE1VVito?=
 =?utf-8?B?TTJNZElzMXJNUGM4bUhKQnBZYkV5M0FXd1Bzek1IeENGb2JQRzNPb3UvR2ZF?=
 =?utf-8?B?QWJVSEh4TWRZdDBzQzIrUjU4amxOckV3MzZXMHVIcXVsK2VHS3Z1UUNqdGda?=
 =?utf-8?B?OU9md2gwWVB4SExBeE45MUVhcjVCNmM5U1NjMS9FZStVYjE5U2JJNmI2Mm13?=
 =?utf-8?B?aUpuY2E5ZHZyUlZmVVNmcXlweitHemxWUExYSTA2REl6dDV3aWxGMHJUWGtF?=
 =?utf-8?B?WnVQQkdING1FVjcxNDhYZjg5V1JPekV5THNDaHRFV0FjOFpjV3dsTnh3WlRE?=
 =?utf-8?B?Z29wTHFmYkpHT2VhYzZqQkNXMFhTZE11SER3WjZiQTdhT1RuUWpHeWZOY2RD?=
 =?utf-8?B?SDZ4QVRHNFJtMCtweGJKOHJRSWkvQXNvRGZ6NWZzRnBHajlDaitLTHlNY2tw?=
 =?utf-8?B?a1RxYzVqbDZXa01pZFNzL3RUd2N0eFRveUZLQzNYUEttOGZES295dHR2OTJI?=
 =?utf-8?B?TXRNUk55aXc5ZTBWMlFEMVpkRDRGTWNXMUNsYUtCdkFxT0MxVUFIU0h2SU9D?=
 =?utf-8?B?bTNLQTh2bmFwcSsrZHU1OERKT2pvRFMxZThWQndaQUI4REJKZkFGTUVWbUZ2?=
 =?utf-8?B?Wm83UWU2aHRCUkFSUFc4dURuQ1UvS3JSR2hkOUsvMmRvUzR1UzRWMWpES0NO?=
 =?utf-8?B?TzZwL09ZMm1MRld4REhvc0Npenhmekk0ZmZmekV1c3dVNUhaVis0aVRDai9L?=
 =?utf-8?B?dlp4MzJ5Q3hZcDBNeFFtWVhQVFR6a2hkSm5RVmVTZ25OQWpUNm13TGlUNGRM?=
 =?utf-8?B?Z1VFV09va2pORkV5SmNiQzNJY0VHOHJFV3pPaUgzcStxVzJ5UmF1bnJjQUdD?=
 =?utf-8?B?endhdHB0RS9tLy9PVEFBYVB4dmR5LzI0eDJ2QThJdXFyN3Bsc0psOGRUMzRJ?=
 =?utf-8?B?UGszMkZMMFdGdEtnVFRwYjhFZmJPQTAySWlpeHBoNEQvS3kvUVp2QytiTFl6?=
 =?utf-8?B?VURhZkw2c1gzVkVWS0JmM2xZSE0wZGZpSUNUYjkwRWdYeUtVOEZTVG9HV1V3?=
 =?utf-8?B?M1lsTXNZOXVrbnU1VC9VUHN0VGpmUWljSG1BUCtNcFpXUjNaT0JYaHBQVFE0?=
 =?utf-8?B?UGZnU2hkVWNZcnJUQWt5UE9Kc041dDRTTkc5Y0h4U05kSDB2L0h3WEtOb05i?=
 =?utf-8?B?aVozVCtpbnE1R1haTUJzWjBVOGRpTjBjZDRWbDlxRGdMclJJcHJ4QXBRNU5Z?=
 =?utf-8?B?cWdsQWs1MHB5YjlrTmxhWVJvRTlsbjZ0N1NtRDBvNE9ERUkya2ZOZVlqdERG?=
 =?utf-8?B?YlQ2UDhwcHBYbzFtMHBxek1GaXlFVjZFVlVXMXdkZENQMmxiQVFHaUpoeWZk?=
 =?utf-8?B?c3VnWlNvUWVENGFuaXVTZFQwSEJTTDZXcmV6TWRVb3BZT0dGaHZYTkFrSk9P?=
 =?utf-8?B?bUl4dmgzSldtUzY5Lzl5Ym8zUlRMc1RjeXRxOXVXY1NvaVBOOUlzS2d2Qmd3?=
 =?utf-8?B?RVRiOWYrNkFVM1VEL0gzSjRJeG1ZK2FYKy82d3FRQkpNOTZ2U0RUVGYrRWh3?=
 =?utf-8?B?dEQzbEw2M0VjVURWSHVSV0x1RE9ldW1rT01oVkIxNmQyLzlmTEIvNzF6ckdx?=
 =?utf-8?Q?B7G4s+7KILvX2mEKogmKv6CYW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf53f6b0-5ef5-4691-bdcf-08dc8c1b4017
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 02:39:44.6941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxOPRL3NP/1otlwWNSGAlB9tZW7Vt8QRhaYzMsphL7OEgqo1YHq4mCoguoQWsBXwwu4V9YHIDw2IHfWoAV+XtDE3ueReGg1qXNhE2NyoyFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7855
X-OriginatorOrg: intel.com

SGkNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS3VwcHVzd2FteSBTYXRo
eWFuYXJheWFuYW4NCj48c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29t
Pg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS8zXSBQQ0kvQUVSOiBTdG9yZSBVTkNPUl9TVEFU
VVMgYml0cyB0aGF0IG1pZ2h0DQo+YmUgQU5GRSBpbiBhZXJfZXJyX2luZm8NCj4NCj5IaSwNCj4N
Cj5PbiA1LzkvMjQgMTo0OCBBTSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJbiBzb21lIGNh
c2VzIHRoZSBkZXRlY3RvciBvZiBhIE5vbi1GYXRhbCBFcnJvcihORkUpIGlzIG5vdCB0aGUgbW9z
dA0KPj4gYXBwcm9wcmlhdGUgYWdlbnQgdG8gZGV0ZXJtaW5lIHRoZSB0eXBlIG9mIHRoZSBlcnJv
ci4gRm9yIGV4YW1wbGUsDQo+PiB3aGVuIHNvZnR3YXJlIHBlcmZvcm1zIGEgY29uZmlndXJhdGlv
biByZWFkIGZyb20gYSBub24tZXhpc3RlbnQNCj4+IGRldmljZSBvciBGdW5jdGlvbiwgY29tcGxl
dGVyIHdpbGwgc2VuZCBhbiBFUlJfTk9ORkFUQUwgTWVzc2FnZS4NCj4+IE9uIHNvbWUgcGxhdGZv
cm1zLCBFUlJfTk9ORkFUQUwgcmVzdWx0cyBpbiBhIFN5c3RlbSBFcnJvciwgd2hpY2gNCj4+IGJy
ZWFrcyBub3JtYWwgc29mdHdhcmUgcHJvYmluZy4NCj4+DQo+PiBBZHZpc29yeSBOb24tRmF0YWwg
RXJyb3IoQU5GRSkgaXMgYSBzcGVjaWFsIGNhc2UgdGhhdCBjYW4gYmUgdXNlZA0KPj4gaW4gYWJv
dmUgc2NlbmFyaW8uIEl0IGlzIHByZWRvbWluYW50bHkgZGV0ZXJtaW5lZCBieSB0aGUgcm9sZSBv
ZiB0aGUNCj4+IGRldGVjdGluZyBhZ2VudCAoUmVxdWVzdGVyLCBDb21wbGV0ZXIsIG9yIFJlY2Vp
dmVyKSBhbmQgdGhlIHNwZWNpZmljDQo+PiBlcnJvci4gSW4gc3VjaCBjYXNlcywgYW4gYWdlbnQg
d2l0aCBBRVIgc2lnbmFscyB0aGUgTkZFIChpZiBlbmFibGVkKQ0KPj4gYnkgc2VuZGluZyBhbiBF
UlJfQ09SIE1lc3NhZ2UgYXMgYW4gYWR2aXNvcnkgdG8gc29mdHdhcmUsIGluc3RlYWQgb2YNCj4+
IHNlbmRpbmcgRVJSX05PTkZBVEFMLg0KPj4NCj4+IFdoZW4gcHJvY2Vzc2luZyBhbiBBTkZFLCBp
ZGVhbGx5IGJvdGggY29ycmVjdGFibGUgZXJyb3IoQ0UpIHN0YXR1cyBhbmQNCj4+IHVuY29ycmVj
dGFibGUgZXJyb3IoVUUpIHN0YXR1cyBzaG91bGQgYmUgY2xlYXJlZC4gSG93ZXZlciwgdGhlcmUg
aXMgbm8NCj4+IHdheSB0byBmdWxseSBpZGVudGlmeSB0aGUgVUUgYXNzb2NpYXRlZCB3aXRoIEFO
RkUuIEV2ZW4gd29yc2UsIE5vbi1GYXRhbA0KPj4gRXJyb3IoTkZFKSBtYXkgc2V0IHRoZSBzYW1l
IFVFIHN0YXR1cyBiaXQgYXMgQU5GRS4gVHJlYXRpbmcgYW4gQU5GRSBhcw0KPj4gTkZFIHdpbGwg
cmVwcm9kdWNlIGFib3ZlIG1lbnRpb25lZCBpc3N1ZSwgaS5lLiwgYnJlYWtpbmcgc29mdHdvcmUg
cHJvYmluZzsNCj4+IHRyZWF0aW5nIE5GRSBhcyBBTkZFIHdpbGwgbWFrZSB1cyBpZ25vcmluZyBz
b21lIFVFcyB3aGljaCBuZWVkIGFjdGl2ZQ0KPj4gcmVjb3ZlciBvcGVyYXRpb24uIFRvIGF2b2lk
IGNsZWFyaW5nIFVFcyB0aGF0IGFyZSBub3QgQU5GRSBieSBhY2NpZGVudCwNCj4+IHRoZSBtb3N0
IGNvbnNlcnZhdGl2ZSByb3V0ZSBpcyB0YWtlbiBoZXJlOiBJZiBhbnkgb2YgdGhlIE5GRSBEZXRl
Y3RlZA0KPj4gYml0cyBpcyBzZXQgaW4gRGV2aWNlIFN0YXR1cywgZG8gbm90IHRvdWNoIFVFIHN0
YXR1cywgdGhleSBzaG91bGQgYmUNCj4+IGNsZWFyZWQgbGF0ZXIgYnkgdGhlIFVFIGhhbmRsZXIu
IE90aGVyd2lzZSwgYSBzcGVjaWZpYyBzZXQgb2YgVUVzIHRoYXQNCj4+IG1heSBiZSByYWlzZWQg
YXMgQU5GRSBhY2NvcmRpbmcgdG8gdGhlIFBDSWUgc3BlY2lmaWNhdGlvbiB3aWxsIGJlIGNsZWFy
ZWQNCj4+IGlmIHRoZWlyIGNvcnJlc3BvbmRpbmcgc2V2ZXJpdHkgaXMgTm9uLUZhdGFsLg0KPj4N
Cj4+IFRvIGFjaGlldmUgYWJvdmUgcHVycG9zZSwgc3RvcmUgVU5DT1JfU1RBVFVTIGJpdHMgdGhh
dCBtaWdodCBiZSBBTkZFDQo+PiBpbiBhZXJfZXJyX2luZm8uYW5mZV9zdGF0dXMuIFNvIHRoYXQg
dGhvc2UgYml0cyBjb3VsZCBiZSBwcmludGVkIGFuZA0KPj4gcHJvY2Vzc2VkIGxhdGVyLg0KPj4N
Cj4+IFRlc3RlZC1ieTogWXVkb25nIFdhbmcgPHl1ZG9uZy53YW5nQGludGVsLmNvbT4NCj4+IENv
LWRldmVsb3BlZC1ieTogIldhbmcsIFFpbmdzaHVuIiA8cWluZ3NodW4ud2FuZ0BsaW51eC5pbnRl
bC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiAiV2FuZywgUWluZ3NodW4iIDxxaW5nc2h1bi53YW5n
QGxpbnV4LmludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3BjaS9wY2kuaCAgICAg
IHwgIDEgKw0KPj4gIGRyaXZlcnMvcGNpL3BjaWUvYWVyLmMgfCA1Mw0KPisrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgNTQgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2kuaCBiL2RyaXZl
cnMvcGNpL3BjaS5oDQo+PiBpbmRleCAxN2ZlZDE4NDY4NDcuLjNmOWViODA3ZjlmZCAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaS5oDQo+PiArKysgYi9kcml2ZXJzL3BjaS9wY2kuaA0K
Pj4gQEAgLTQxMiw2ICs0MTIsNyBAQCBzdHJ1Y3QgYWVyX2Vycl9pbmZvIHsNCj4+DQo+PiAgCXVu
c2lnbmVkIGludCBzdGF0dXM7CQkvKiBDT1IvVU5DT1IgRXJyb3IgU3RhdHVzICovDQo+PiAgCXVu
c2lnbmVkIGludCBtYXNrOwkJLyogQ09SL1VOQ09SIEVycm9yIE1hc2sgKi8NCj4+ICsJdW5zaWdu
ZWQgaW50IGFuZmVfc3RhdHVzOwkvKiBVTkNPUiBFcnJvciBTdGF0dXMgZm9yIEFORkUgKi8NCj4+
ICAJc3RydWN0IHBjaWVfdGxwX2xvZyB0bHA7CS8qIFRMUCBIZWFkZXIgKi8NCj4+ICB9Ow0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2llL2Flci5jIGIvZHJpdmVycy9wY2kvcGNp
ZS9hZXIuYw0KPj4gaW5kZXggYWM2MjkzYzI0OTc2Li5mMjgzOWI1MTMyMWEgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL3BjaS9wY2llL2Flci5jDQo+PiArKysgYi9kcml2ZXJzL3BjaS9wY2llL2Fl
ci5jDQo+PiBAQCAtMTA3LDYgKzEwNywxMiBAQCBzdHJ1Y3QgYWVyX3N0YXRzIHsNCj4+ICAJCQkJ
CVBDSV9FUlJfUk9PVF9NVUxUSV9DT1JfUkNWIHwNCj4JXA0KPj4gIAkJCQkJUENJX0VSUl9ST09U
X01VTFRJX1VOQ09SX1JDVikNCj4+DQo+PiArI2RlZmluZSBBRVJfRVJSX0FORkVfVU5DX01BU0sN
Cj4JKFBDSV9FUlJfVU5DX1BPSVNPTl9UTFAgfAlcDQo+PiArCQkJCQlQQ0lfRVJSX1VOQ19DT01Q
X1RJTUUgfA0KPglcDQo+PiArCQkJCQlQQ0lfRVJSX1VOQ19DT01QX0FCT1JUIHwNCj4JXA0KPj4g
KwkJCQkJUENJX0VSUl9VTkNfVU5YX0NPTVAgfA0KPglcDQo+PiArCQkJCQlQQ0lfRVJSX1VOQ19V
TlNVUCkNCj4+ICsNCj4+ICBzdGF0aWMgaW50IHBjaWVfYWVyX2Rpc2FibGU7DQo+PiAgc3RhdGlj
IHBjaV9lcnNfcmVzdWx0X3QgYWVyX3Jvb3RfcmVzZXQoc3RydWN0IHBjaV9kZXYgKmRldik7DQo+
Pg0KPj4gQEAgLTExOTYsNiArMTIwMiw0OSBAQCB2b2lkIGFlcl9yZWNvdmVyX3F1ZXVlKGludCBk
b21haW4sIHVuc2lnbmVkDQo+aW50IGJ1cywgdW5zaWduZWQgaW50IGRldmZuLA0KPj4gIEVYUE9S
VF9TWU1CT0xfR1BMKGFlcl9yZWNvdmVyX3F1ZXVlKTsNCj4+ICAjZW5kaWYNCj4+DQo+PiArc3Rh
dGljIHZvaWQgYW5mZV9nZXRfdWNfc3RhdHVzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0cnVjdCBh
ZXJfZXJyX2luZm8NCj4qaW5mbykNCj4+ICt7DQo+PiArCXUzMiB1bmNvcl9tYXNrLCB1bmNvcl9z
dGF0dXMsIGFuZmVfc3RhdHVzOw0KPj4gKwl1MTYgZGV2aWNlX3N0YXR1czsNCj4+ICsJaW50IGFl
ciA9IGRldi0+YWVyX2NhcDsNCj4+ICsNCj4+ICsJcGNpX3JlYWRfY29uZmlnX2R3b3JkKGRldiwg
YWVyICsgUENJX0VSUl9VTkNPUl9TVEFUVVMsDQo+JnVuY29yX3N0YXR1cyk7DQo+PiArCXBjaV9y
ZWFkX2NvbmZpZ19kd29yZChkZXYsIGFlciArIFBDSV9FUlJfVU5DT1JfTUFTSywNCj4mdW5jb3Jf
bWFzayk7DQo+PiArCS8qDQo+PiArCSAqIEFjY29yZGluZyB0byBQQ0llIEJhc2UgU3BlY2lmaWNh
dGlvbiBSZXZpc2lvbiA2LjEsDQo+PiArCSAqIFNlY3Rpb24gNi4yLjMuMi40LCBpZiBhbiBVTkNP
UiBlcnJvciBpcyByYWlzZWQgYXMNCj4+ICsJICogQWR2aXNvcnkgTm9uLUZhdGFsIGVycm9yLCBp
dCB3aWxsIG1hdGNoIHRoZSBmb2xsb3dpbmcNCj4+ICsJICogY29uZGl0aW9uczoNCj4+ICsJICoJ
YS4gVGhlIHNldmVyaXR5IG9mIHRoZSBlcnJvciBpcyBOb24tRmF0YWwuDQo+PiArCSAqCWIuIFRo
ZSBlcnJvciBpcyBvbmUgb2YgdGhlIGZvbGxvd2luZzoNCj4+ICsJICoJCTEuIFBvaXNvbmVkIFRM
UCAgICAgICAgICAgKFNlY3Rpb24gNi4yLjMuMi40LjMpDQo+PiArCSAqCQkyLiBDb21wbGV0aW9u
IFRpbWVvdXQgICAgIChTZWN0aW9uIDYuMi4zLjIuNC40KQ0KPj4gKwkgKgkJMy4gQ29tcGxldGVy
IEFib3J0ICAgICAgICAoU2VjdGlvbiA2LjIuMy4yLjQuMSkNCj4+ICsJICoJCTQuIFVuZXhwZWN0
ZWQgQ29tcGxldGlvbiAgKFNlY3Rpb24gNi4yLjMuMi40LjUpDQo+PiArCSAqCQk1LiBVbnN1cHBv
cnRlZCBSZXF1ZXN0ICAgIChTZWN0aW9uIDYuMi4zLjIuNC4xKQ0KPj4gKwkgKi8NCj4+ICsJYW5m
ZV9zdGF0dXMgPSB1bmNvcl9zdGF0dXMgJiB+dW5jb3JfbWFzayAmIH5pbmZvLT5zZXZlcml0eSAm
DQo+PiArCQkgICAgICBBRVJfRVJSX0FORkVfVU5DX01BU0s7DQo+PiArDQo+PiArCWlmIChwY2ll
X2NhcGFiaWxpdHlfcmVhZF93b3JkKGRldiwgUENJX0VYUF9ERVZTVEEsDQo+JmRldmljZV9zdGF0
dXMpKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKwkvKg0KPj4gKwkgKiBUYWtlIHRoZSBtb3N0IGNvbnNl
cnZhdGl2ZSByb3V0ZSBoZXJlLiBJZiB0aGVyZSBhcmUgTm9uLUZhdGFsDQo+ZXJyb3JzDQo+PiAr
CSAqIGRldGVjdGVkLCBkbyBub3QgYXNzdW1lIGFueSBiaXQgaW4gdW5jb3Jfc3RhdHVzIGlzIHNl
dCBieSBBTkZFLg0KPj4gKwkgKi8NCj4+ICsJaWYgKGRldmljZV9zdGF0dXMgJiBQQ0lfRVhQX0RF
VlNUQV9ORkVEKQ0KPj4gKwkJcmV0dXJuOw0KPg0KPllvdSBjYW4gbW92ZSB0aGlzIGNoZWNrIHRv
IHRoZSB0b3Agb2YgdGhlIGZ1bmN0aW9uLiBZb3UgZG9uJ3QgbmVlZCB0byBjaGVjaw0KPnRoZSBy
ZXN0IGlmIE5GRSBlcnJvciBpcyBkZXRlY3RlZCBpbiBkZXZpY2Ugc3RhdHVzLg0KDQpUaGUgdjMg
anVzdCB3b3JrZWQgdGhhdCB3YXkuIEpvbmF0aGFuIHBvaW50ZWQgYSByYWNlIHRoYXQgTkZFIHRy
aWdnZXJlZCBhZnRlcg0KdGhlIGNoZWNrIHdpbGwgYmUgdHJlYXRlZCBhcyBBTkZFIGFuZCBjbGVh
cmVkLiBDaGVjayBpdCBhZnRlciByZWFkaW5nIFVOQ09SX1NUQVRVUw0KY2FuIGF2b2lkIHRoZSBy
YWNlLg0KDQpTZWUgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjQvNC8yMi8xMDExIGZvciBkaXNj
dXNzaW9uIGRldGFpbHMuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj4+ICsNCj4+ICsJLyoN
Cj4+ICsJICogSWYgdGhlcmUgaXMgYW5vdGhlciBBTkZFIGJldHdlZW4gcmVhZGluZyB1bmNvcl9z
dGF0dXMgYW5kDQo+Y2xlYXJpbmcNCj4+ICsJICogUENJX0VSUl9DT1JfQURWX05GQVQgYml0IGlu
IGNvcl9zdGF0dXMgcmVnaXN0ZXIsIHRoYXQgQU5GRQ0KPmlzbid0DQo+PiArCSAqIHJlY29yZGVk
IGluIGluZm8tPmFuZmVfc3RhdHVzLiBJdCB3aWxsIGJlIHJlYWQgb3V0IGFzIE5GRSBpbg0KPj4g
KwkgKiBmb2xsb3dpbmcgdW5jb3Jfc3RhdHVzIHJlZ2lzdGVyIHJlYWRpbmcgYW5kIHByb2Nlc3Nl
ZCBieSBORkUNCj4+ICsJICogaGFuZGxlci4NCj4+ICsJICovDQo+PiArCWluZm8tPmFuZmVfc3Rh
dHVzID0gYW5mZV9zdGF0dXM7DQo+PiArfQ0KPj4gKw0KPj4gIC8qKg0KPj4gICAqIGFlcl9nZXRf
ZGV2aWNlX2Vycm9yX2luZm8gLSByZWFkIGVycm9yIHN0YXR1cyBmcm9tIGRldiBhbmQgc3RvcmUg
aXQgdG8NCj5pbmZvDQo+PiAgICogQGRldjogcG9pbnRlciB0byB0aGUgZGV2aWNlIGV4cGVjdGVk
IHRvIGhhdmUgYSBlcnJvciByZWNvcmQNCj4+IEBAIC0xMjEzLDYgKzEyNjIsNyBAQCBpbnQgYWVy
X2dldF9kZXZpY2VfZXJyb3JfaW5mbyhzdHJ1Y3QgcGNpX2Rldg0KPipkZXYsIHN0cnVjdCBhZXJf
ZXJyX2luZm8gKmluZm8pDQo+Pg0KPj4gIAkvKiBNdXN0IHJlc2V0IGluIHRoaXMgZnVuY3Rpb24g
Ki8NCj4+ICAJaW5mby0+c3RhdHVzID0gMDsNCj4+ICsJaW5mby0+YW5mZV9zdGF0dXMgPSAwOw0K
Pj4gIAlpbmZvLT50bHBfaGVhZGVyX3ZhbGlkID0gMDsNCj4+DQo+PiAgCS8qIFRoZSBkZXZpY2Ug
bWlnaHQgbm90IHN1cHBvcnQgQUVSICovDQo+PiBAQCAtMTIyNiw2ICsxMjc2LDkgQEAgaW50IGFl
cl9nZXRfZGV2aWNlX2Vycm9yX2luZm8oc3RydWN0IHBjaV9kZXYNCj4qZGV2LCBzdHJ1Y3QgYWVy
X2Vycl9pbmZvICppbmZvKQ0KPj4gIAkJCSZpbmZvLT5tYXNrKTsNCj4+ICAJCWlmICghKGluZm8t
PnN0YXR1cyAmIH5pbmZvLT5tYXNrKSkNCj4+ICAJCQlyZXR1cm4gMDsNCj4+ICsNCj4+ICsJCWlm
IChpbmZvLT5zdGF0dXMgJiBQQ0lfRVJSX0NPUl9BRFZfTkZBVCkNCj4+ICsJCQlhbmZlX2dldF91
Y19zdGF0dXMoZGV2LCBpbmZvKTsNCj4+ICAJfSBlbHNlIGlmICh0eXBlID09IFBDSV9FWFBfVFlQ
RV9ST09UX1BPUlQgfHwNCj4+ICAJCSAgIHR5cGUgPT0gUENJX0VYUF9UWVBFX1JDX0VDIHx8DQo+
PiAgCQkgICB0eXBlID09IFBDSV9FWFBfVFlQRV9ET1dOU1RSRUFNIHx8DQo+DQo+LS0NCj5TYXRo
eWFuYXJheWFuYW4gS3VwcHVzd2FteQ0KPkxpbnV4IEtlcm5lbCBEZXZlbG9wZXINCg0K

