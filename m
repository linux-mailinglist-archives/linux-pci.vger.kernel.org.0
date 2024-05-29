Return-Path: <linux-pci+bounces-8036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0D58D3ABE
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 17:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806021F26D08
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 15:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911F917F390;
	Wed, 29 May 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SU8aZY1Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C817BB17;
	Wed, 29 May 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996182; cv=fail; b=QuOcHRgEVrulW1UzCbLJrbc72r2w4hHDcNxtpqdYZpJkQ7aW59WiCJI0lsYFEAAcUWo79slLVs/JP/y6MGxBZnw+RabAeRWI6x4P6AXLDUpMaTk9yiPFDY4nQl3I0DE3rNJUhPhUsjYdo/Pa8A46j9CmsH0hFi6Pw5P3Dr1Y/DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996182; c=relaxed/simple;
	bh=cPnF5mKa6FIq5g/ypxdPKA9FAX/CmgCm6lXtVadimoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iG1JF7Lp35zkIQHgchBOMSHzXCkRI+XF3wA1+Dqce7JTivKUL3rj8HvpkK9WJNbwT682kqzP+/Z0xnUarK9hI222DGnmA/he2V2ahv+/g3OF7/num9rQrEahNRWtOr/nSgyGqyAWQpjmSPZEx2rNzSum+njJnH2t/Hvtx8X+EGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SU8aZY1Q; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716996180; x=1748532180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cPnF5mKa6FIq5g/ypxdPKA9FAX/CmgCm6lXtVadimoU=;
  b=SU8aZY1Q2RHmWBfnjaOFDDEsubXet4J7WxJyyr4yEHk/HdqnyHQvzTWl
   /cCVDea5sGQJRopfqv0Uj/IZgKZO9H+V7wdMEYzwH5v6A3SmI1mRTHMzD
   +UPinHWTEtXymk29eKXrbfWjBB1wgwn2vfEnSkQ7BVt77Nt363uwxZ5TZ
   OECz2SK671vAKbIyBHPdDfGpW4BBU0DB4WAR/yezUrm4gONFYs2IJnl+b
   g5QjofsClEM8M1OlLaWflGhVzfiRIWME03rEyhlGS01Ol/zC5iRnD21qZ
   3u7xQQBd23IRztpSj7/TIt1ggHR4SlmjcqdQlxpRzVdXbpc2ltMZ6aWlU
   A==;
X-CSE-ConnectionGUID: F1FFqtXJTIyNEvcGocracA==
X-CSE-MsgGUID: rzOIg8huSu63D1mf4IaEQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13357192"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13357192"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:23:00 -0700
X-CSE-ConnectionGUID: 2e9THcALRLKYZydUrex+Zg==
X-CSE-MsgGUID: CLv8YyVRSZC1VxyptnQUQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35557565"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 08:23:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 08:22:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 08:22:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 08:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8E8u9Y9QOBpYjYjP/fSjWsbH/iME4Ov7XzYfPhfU/pt/xKNZfepAU7KvCbQaLDOFvJw6+jGVhvlRoR6VJEYY9qjpbBp3Z9AiUPQ60Wz3yrvuAB9GKUks6jNSbNAGAVTG/FZ8deuS9soUpjiX0jiDXVGDjvj3J3i+M+nV3/eKaOcV1gNJLm2dSRirEK1grDYEYEZwRSEJxS6Yp/D+W+k3d63sU3rF1NVY+stmlLaCh9ufDgEZUZCReTQ9IaqX6lBYmDeOujeeUzCzoQBDzxfoakbo5ASPLflkvNe4Lu0smXvNz101Lji40M4MilC14PiTwWnS76vdfooUjJ8L5Rwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPnF5mKa6FIq5g/ypxdPKA9FAX/CmgCm6lXtVadimoU=;
 b=VnSORv/eSqtpy602AaSMbQzCOS+JoCy/4Xrapz57Q5Tq5COdMXSPzaEKhcl9690FJha7WeGiagL1IFOZ6bINI3Oy8XgR6FJlSORsnNpoON+RdpWovk0qJ0WRG/YSk+3rIwbEt4uph1ncD2cP6Bd6YdnpQsToWPkyhZB6Y6f3zewucEvEqLZpvLWABPu7bt7k56oqQewCwZE3jmOY3+F8oKRCCRPUvwF5oaB22oALuI0bFB8E3vh8Lteo8vjDsPX3pOfCpoAj11sPouLgIHv6MmL8kg2U/euyOzbRJGl+GPyJoDvhjrtOkaCdQp0+nyxdGMqviRGvCxtmQkYXQFK9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) by
 PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 15:22:56 +0000
Received: from DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::f6db:9044:ad81:33d9]) by DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::f6db:9044:ad81:33d9%3]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 15:22:56 +0000
From: "Saarinen, Jani" <jani.saarinen@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: "Jiang, Dave" <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Deak, Imre" <imre.deak@intel.com>
Subject: RE: [PATCH] PCI: Make PCI cfg_access_lock lockdep key a singleton
Thread-Topic: [PATCH] PCI: Make PCI cfg_access_lock lockdep key a singleton
Thread-Index: AQHasVX/6VVmL2CGN0OBfMQhFT/EhLGuVH3A
Date: Wed, 29 May 2024 15:22:56 +0000
Message-ID: <DM8PR11MB5655866DE2EA8E5AF7700B5FE0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <171693842964.1298616.14265420982007939967.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171693842964.1298616.14265420982007939967.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_|PH7PR11MB7049:EE_
x-ms-office365-filtering-correlation-id: 0f37dce4-2601-4dd3-652a-08dc7ff3374a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bVgxV1BGekZMOElIeXI3MzBaZUhZditIQVNxMTZaOUMwVTlNSUd0NnhjVEZV?=
 =?utf-8?B?cnlybC82MWc5Zy9jellMdHpGZ2hTdTlRd0REYVB5QjJYYnRPNEhZc0JEdkh2?=
 =?utf-8?B?N3N0OGxieGhHQVNrY1pVdnlONUxvUnd3M0RWdGM0VUdHWUZvamcyYVk0VFZm?=
 =?utf-8?B?RlhOVHB0NVBxNGlEamZ5RkNjNFRTQ04zMWNYc2VKRHFpZWxBbVFUR0xxVGtZ?=
 =?utf-8?B?WEovcFFpRkVJSElPZW0wU2pINGxZanZZVm5NTzdPdFBHazdaOVRVQjh2ZGll?=
 =?utf-8?B?SHhFMmJ4MDlZUmpvREZBQzh0NkdzS1RiRkJKNERGcU5SNFNRY2Z5d2NFRU8x?=
 =?utf-8?B?Q01yd0FGMTdaVDk4aXloTTNCUG15d05Hd0lSQ3RUeTVYMEdCOVZQZk40cWVz?=
 =?utf-8?B?bTNpTG9OSTk2VFdoeGtRYkQ5dlNVbWhBSzRjeWhxYmlCT2dvNFlkbktDL0ZR?=
 =?utf-8?B?OWZyVEFYUm1ZVDJDcEVRM3hYeGRhYlBCSENWajMrRCtUa0lVQ0V3OHFSTVB5?=
 =?utf-8?B?QVB0R0V4MFRscFVBRU1nSTBCbEtyeW5pZWVCc2tKaE56bFRIY05LOFJLOTBI?=
 =?utf-8?B?RWRyT0prWHhNRm4xcDc4T1VBUDZHajl5QUhRVDNzU3hVanBHNWVQNVFqZmV5?=
 =?utf-8?B?OEU3eFZFck5EMGY2UERCejBLRDlWRTAvSXF6NlVaWHZvdndxVzlEdjVqdXpF?=
 =?utf-8?B?VHgvTkkzaUtwVDh2a29mM2lEVTJuTHBoOEp1cE4rbzIraDJKY3JQN05oSjJR?=
 =?utf-8?B?SkRnSEZ0VEh3VU1zNjh3VlZOcWpBMStaODlJWXRoN25jRjdqVEdkK3ZNcHU0?=
 =?utf-8?B?S0R6NFI3KzlESzA5bDRUaER3aHk4NUQ4QnFCcnBWUkVUSC83Y2JLeVd0VndH?=
 =?utf-8?B?RTRhdVZKZlVHK3BTdEZhdEdzODhVZUJqLzhhSUh5N2l0VG8xVWUvdEs1WGFt?=
 =?utf-8?B?a1NaUFVwSFBNNE14WitJVG1jcXNjbmZiUTBaVVFQQUpLL1g3Mlg5djdxb0JX?=
 =?utf-8?B?ZjBnL0d1cDhwZ0t2c0NVQndseHVpTjZEUWd5dDFOMHl1Nm5vNlZQajdHd1pO?=
 =?utf-8?B?STRCdEdYV2dxS00zSGxaTEVvdi9NanhvemZXblN4N3hWbDlCWU9ZYTFCdHF5?=
 =?utf-8?B?clVROHpkT0I5cVZRaEJZUkEyNUt2SldDUVdsS1o3R1hqaERpV1R4NWVEc3FO?=
 =?utf-8?B?RlpnME1WQUlUbE9CY3VBK0p3WURTUk5vekMrWlVYSTRnUHRXbnkyWHp6aC9L?=
 =?utf-8?B?UFJVdGJhSEtyMkNpd0QrYndRRlJhUDQyTzNKQnNUaGY2WGhxQTk5cDh5Wmxw?=
 =?utf-8?B?bGxEams5TGdIZDRYOENSQlZLd1BWZC81cENLTnlkbS9kMy80VFJHVFg3WTR2?=
 =?utf-8?B?bTl4QmlQS0JtRStjcEp3TVUxVW05WVZxc0I0N0tsTDg0ZFNvcUlReXYxSC9T?=
 =?utf-8?B?elNyVE1maWFvMkRlWFRBRkg2bXF2dlIxdjE0TGY2SzM1QUM2dUo5YWZSY0Qz?=
 =?utf-8?B?NjM0VXFHREhhbnV3dTdidEdNWmthNjFSa0QrMjBwVGNyZk55YmdzSTlTWUxl?=
 =?utf-8?B?RlZBRkl2WExBUDVTZlNoMzI2d3U0d3N5TXNuU1I5ZmhkZWIrVlNQbGc2Tng3?=
 =?utf-8?B?S0ZoL3FiMzRRamk2YWdyNDhYMlJUbklrWFVGZWZiTDFYRnBrSnJHT3h4WVNC?=
 =?utf-8?B?RVFkZVljYkMrc2xLd21NcEpMQjZNV0ZucFFnemxMbndSOTBLTFhEdkJCbGJB?=
 =?utf-8?Q?1XFQwK9U1kJJPSr2nM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUtlVlR4V0RmQTFITFMvS3ltdXpJc0lpM29JbThPOFNPUk9EbFZsUkU4cnN1?=
 =?utf-8?B?ald5VmpXclBiZVpNR1NCYm43a2NUNkI4c3E1ZTYyNHVQcXBCM0RWZUNaOWZP?=
 =?utf-8?B?U0hBeUlSOW5ndDNaWHRHOU1NVXZ1TEgxQWZCWHFkZXdUWERwVUNxT25sRVFw?=
 =?utf-8?B?YXJjV1dKdGZNcnlNTzZzSlQvUm4rUUhtclpkckJ5cjlCVzZVOTZSN21INTJX?=
 =?utf-8?B?WmtHT2c0YmwvTkJJZlBnSkRXNEF0SUtiZWtpYmJJOThHYkd2b0hhT3ExT3lL?=
 =?utf-8?B?QkRpNGdWOFc0RytnNUlxbVc1Ny90VXdUQ1llOHdZTkZtU0w4QTZYeCtSTktp?=
 =?utf-8?B?b3ppWENWYzBSOW5tYStITjJsNDRPd3lSck51dlExNVNMRWhwVCs0ci9LeTV2?=
 =?utf-8?B?S0VPRE5mSlZ1SFA0TFpBcTRURkxMeEorNUdPWTR2cERVTHMxbVZrM2xNZ0g1?=
 =?utf-8?B?MTZCZnF2SFVoNTlNTFR1dUhtRVNSKzBhYUF1YjVLQUpubVF3MnFHY1JGWWlj?=
 =?utf-8?B?aXk3OG5HTE8ydzFUQmJzNVo5aVZEM1RySGtVSkVlU2R3Znk2NDc4aFZuaExT?=
 =?utf-8?B?bTdTSUVSQXVIaGNFczdCM3hzUmRWTTJnU2hCajlzOWV0NDNUa1NpaFJWQWUy?=
 =?utf-8?B?Yk53S2gvbUNITVlKZHMzMjk3Wi9EaGdtMlVOOEh5QlNGZlNsZXdvZkVWaTRU?=
 =?utf-8?B?bURpR0hkTmN0L3BjbHZ2N2lNUTlieGVYRHhCMjRuODNjK1VJN29Qbk40MURv?=
 =?utf-8?B?R3p2UFpoNmRoUkNrUjRYYVYzNERJNFJDMTM5ZDBCSEFILy85ZGVkQ0ZEbWlU?=
 =?utf-8?B?SXNtU3ZzckhsbC91YUVkVktpTU11RGJUd0R2dS8vWEgzVFFvOFNIUjN5RTg1?=
 =?utf-8?B?T25qWDZZdG1OdVRIbVZwOFJ0M052SnVIWVRJYkh3eEJDSkcvVjRxTkxnUmFR?=
 =?utf-8?B?Sm83bWNpQkNZdjdzNTZWWE95UERuMTV3b0JTa2Rkam9Bb0MrNUxPeE5mUDFL?=
 =?utf-8?B?eEhGYTRZTjc5UXhGQ1V6dU5OaFFsYXZia1c4T1hTWHpIQUV3Vm5vV1VOWlRs?=
 =?utf-8?B?TUZYeXdWUW5DazZwQitTYm15dUFmWGNsYUNpSk9xTVVFVER3bzNIQXk3bEU0?=
 =?utf-8?B?bnlFUGI4SFN5elpiTW5sYktsTzlDNEtQdGJNd205eGhyNjFNOGVVUERHRFJG?=
 =?utf-8?B?bU1ObE9KdHJMZ1dHSmdOeW5ZYlBacnZIcTAxeGd1b3BWZDhrdHBIMnRVVkNi?=
 =?utf-8?B?U3dmSkJIeHJpZVZyeVV4MEdnVmNwc1kvSU1GdTlkRXg1VkhOSmVoSDFaOUJO?=
 =?utf-8?B?TFk5TDRvSm9hQXkxSG1OcHpXU0ZaZzFqL2VESkVSSGZQbVhPaDQ0VWJVOUM4?=
 =?utf-8?B?NWhkblFtOVVoRW9RSHN1cmFqQTRWajl1SGtLWEtiSk9LWHFSZ2ZIaTNXa2gr?=
 =?utf-8?B?UGR4RXN1WUlBZFpTQmpzS0xVclZPSlhtMEpqSmdKcG1xbXQrU1lYSlR2U2pV?=
 =?utf-8?B?c1NOa0N0YzVzUEJnRnJxRWpjZmE2cEFINDFEaC80eWNPa1BXOEx2dEFTUHhK?=
 =?utf-8?B?VkNYSlY3YTlXTFBYMWhwUTJPTG9OY3JnVWl4Q1h0NXF1U2ZaVUxyVVJ2bUlv?=
 =?utf-8?B?d205M3pGVmJTWEh1NW9QT21qZHczS2NWTXJKTU1GOTZlbFV3eWhrdUUwZEpl?=
 =?utf-8?B?V0ZZaGNyenBRd3VpYVE2eHV1bGpRN2d0NW1TTEc1NlN3eTA3R2J6dkE5aUdC?=
 =?utf-8?B?TjJ0bklVWktBeWFKYXd3VkpKWDNMMFNKTzJzM1RkWmU3UmhWeEV6Si9LL2Vx?=
 =?utf-8?B?bGtBQXBIYVBacjZhRjlQRG5KY3djdFdIbm1ORGZGQ0w3Z3lQdUJUYmlaQjI4?=
 =?utf-8?B?NFZMYStScDdHUGFsWjNOdEp4WmRCTm9jRm5RVmJyUTNqNGhrQ0xtN2NjUkdD?=
 =?utf-8?B?SnVxOURvQ3dqMnNMd0VpMytNOFgvVHRkT1RsMWlpUHNhWEFHNzlkdUpSU0hU?=
 =?utf-8?B?RXdob0hCUVd1R3ZCT01xRXBmaldLbjcwbDFnNk5jbzdUL0tLSHRDdk1SSW1p?=
 =?utf-8?B?My9PeWZWM3NKTUY2RGVPSTcrV0x5MXJGbks4ODdIaDdjdzJ5T3JJYzdJaUll?=
 =?utf-8?Q?o4aIGEhCu3ksGx+IfTZCfoGZD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f37dce4-2601-4dd3-652a-08dc7ff3374a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 15:22:56.0974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCjKK9ejmdLxCkAVX00A0iPuTQFCz/olJaWTsUdCQ88AfKyTtQkWzBHhFA836/JYIFchHOs0KUujgaS+/zwrlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-OriginatorOrg: intel.com

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2lsbGlhbXMsIERh
biBKIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMjkgTWF5
IDIwMjQgMi4yMw0KPiBUbzogYmhlbGdhYXNAZ29vZ2xlLmNvbQ0KPiBDYzogU2FhcmluZW4sIEph
bmkgPGphbmkuc2FhcmluZW5AaW50ZWwuY29tPjsgSmlhbmcsIERhdmUNCj4gPGRhdmUuamlhbmdA
aW50ZWwuY29tPjsgbGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIFBDSTogTWFrZSBQQ0kgY2ZnX2FjY2Vzc19sb2Nr
IGxvY2tkZXAga2V5IGEgc2luZ2xldG9uDQo+IA0KPiBUaGUgbmV3IGxvY2tkZXAgYW5ub3RhdGlv
biBmb3IgY2ZnX2FjY2Vzc19sb2NrIG5haXZlbHkgcmVnaXN0ZXJlZCBhIG5ldyBrZXkNCj4gcGVy
IGRldmljZS4gVGhpcyBpcyBvdmVya2lsbCBhbmQgbGVhZHMgdG8gd2FybmluZ3Mgb24gaGFzaCBj
b2xsaXNpb25zIGF0DQo+IGR5bmFtaWMgcmVnaXN0cmF0aW9uIHRpbWU6DQo+IA0KPiAgV0FSTklO
RzogQ1BVOiAwIFBJRDogMSBhdCBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6MTIyNg0KPiBsb2Nr
ZGVwX3JlZ2lzdGVyX2tleSsweGIwLzB4MjQwDQo+ICBSSVA6IDAwMTA6bG9ja2RlcF9yZWdpc3Rl
cl9rZXkrMHhiMC8weDI0MA0KPiAgWy4uXQ0KPiAgQ2FsbCBUcmFjZToNCj4gICA8VEFTSz4NCj4g
ICA/IF9fd2FybisweDhjLzB4MTkwDQo+ICAgPyBsb2NrZGVwX3JlZ2lzdGVyX2tleSsweGIwLzB4
MjQwDQo+ICAgPyByZXBvcnRfYnVnKzB4MWY4LzB4MjAwDQo+ICAgPyBoYW5kbGVfYnVnKzB4M2Mv
MHg3MA0KPiAgID8gZXhjX2ludmFsaWRfb3ArMHgxOC8weDcwDQo+ICAgPyBhc21fZXhjX2ludmFs
aWRfb3ArMHgxYS8weDIwDQo+ICAgPyBsb2NrZGVwX3JlZ2lzdGVyX2tleSsweGIwLzB4MjQwDQo+
ICAgcGNpX2RldmljZV9hZGQrMHgxNGIvMHg1NjANCj4gICA/IHBjaV9zZXR1cF9kZXZpY2UrMHg0
MmUvMHg2YTANCj4gICBwY2lfc2Nhbl9zaW5nbGVfZGV2aWNlKzB4YTcvMHhkMA0KPiAgIHAyc2Jf
c2Nhbl9hbmRfY2FjaGVfZGV2Zm4rMHhjLzB4OTANCj4gICBwMnNiX2ZzX2luaXQrMHgxNWYvMHgx
NzANCj4gDQo+IFN3aXRjaCB0byBhIHNoYXJlZCBzdGF0aWMga2V5IGZvciBhbGwgaW5zdGFuY2Vz
Lg0KPiANCj4gRml4ZXM6IDdlODllZmM2ZTllNCAoIlBDSTogTG9jayB1cHN0cmVhbSBicmlkZ2Ug
Zm9yIHBjaV9yZXNldF9mdW5jdGlvbigpIikNCj4gUmVwb3J0ZWQtYnk6IEphbmkgU2FhcmluZW4g
PGphbmkuc2FhcmluZW5AaW50ZWwuY29tPg0KPiBDbG9zZXM6IGh0dHBzOi8vaW50ZWwtZ2Z4LWNp
LjAxLm9yZy90cmVlL2RybS10aXAvQ0lfRFJNXzE0ODM0L2JhdC1hcGwtDQo+IDEvYm9vdDAudHh0
DQo+IENjOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gQ2M6IEJqb3JuIEhl
bGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFt
cyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiAtLS0NCj4gSGkgQmpvcm4sDQo+IA0KPiBP
bmUgbW9yZSBmYWxsb3V0IGZyb20gdGhlIGNmZ19hY2Nlc3NfbG9jayBsb2NrZGVwIGFubm90YXRp
b24uIFRoaXMgb25lIHN0aWxsDQo+IHdhbnRzIGEgVGVzdGVkLWJ5IGZyb20gSmFuaSBiZWZvcmUg
bWVyZ2luZywgYnV0IHdhbnRlZCB0byBtYWtlIHlvdSBhd2FyZSBvZg0KPiBpdCBpbiBjYXNlIHNp
bWlsYXIgcmVwb3J0cyBtYWtlIHRoZWlyIHdheSB0byB5b3UgaW4gdGhlIG1lYW50aW1lLg0KDQpT
ZWUgcGF0Y2ggc2VudCB0byBpbnRlbC1nZnggaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Au
b3JnL3Nlcmllcy8xMzQxODYvIA0KPT4gaHR0cHM6Ly9pbnRlbC1nZngtY2kuMDEub3JnL3RyZWUv
ZHJtLXRpcC9QYXRjaHdvcmtfMTM0MTg2djEvaW5kZXguaHRtbD9ob3N0cz1hcGwNCj0+IE5vIHRh
aW50IGluIHRoZSBib290IGFuZCBzeXN0ZW0gZG9lcyB0ZXN0aW5nIGFnYWluOiBodHRwczovL2lu
dGVsLWdmeC1jaS4wMS5vcmcvdHJlZS9kcm0tdGlwL1BhdGNod29ya18xMzQxODZ2MS9iYXQtYWxs
Lmh0bWw/aG9zdHM9YXBsDQoNCldpdGggdGhhdDoNClRlc3RlZC1CeTogSmFuaSBTYWFyaW5lbiA8
amFuaS5zYWFyaW5lbkBpbnRlbC5jb20+DQoNCkJyLA0KSmFuaQ0KDQo+IA0KPiAgZHJpdmVycy9w
Y2kvcHJvYmUuYyB8ICAgIDcgKysrKy0tLQ0KPiAgaW5jbHVkZS9saW51eC9wY2kuaCB8ICAgIDEg
LQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2RyaXZlcnMvcGNpL3Byb2Jl
LmMgaW5kZXgNCj4gOGU2OTZlNTQ3NTY1Li4xNTE2ODg4MWVjOTQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvcGNpL3Byb2JlLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvcHJvYmUuYw0KPiBAQCAtMjUz
Myw2ICsyNTMzLDggQEAgc3RhdGljIHZvaWQgcGNpX3NldF9tc2lfZG9tYWluKHN0cnVjdCBwY2lf
ZGV2DQo+ICpkZXYpDQo+ICAJZGV2X3NldF9tc2lfZG9tYWluKCZkZXYtPmRldiwgZCk7DQo+ICB9
DQo+IA0KPiArc3RhdGljIHN0cnVjdCBsb2NrX2NsYXNzX2tleSBjZmdfYWNjZXNzX2tleTsNCj4g
Kw0KPiAgdm9pZCBwY2lfZGV2aWNlX2FkZChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBzdHJ1Y3QgcGNp
X2J1cyAqYnVzKSAgew0KPiAgCWludCByZXQ7DQo+IEBAIC0yNTQ2LDkgKzI1NDgsOCBAQCB2b2lk
IHBjaV9kZXZpY2VfYWRkKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0cnVjdA0KPiBwY2lfYnVzICpi
dXMpDQo+ICAJZGV2LT5kZXYuZG1hX21hc2sgPSAmZGV2LT5kbWFfbWFzazsNCj4gIAlkZXYtPmRl
di5kbWFfcGFybXMgPSAmZGV2LT5kbWFfcGFybXM7DQo+ICAJZGV2LT5kZXYuY29oZXJlbnRfZG1h
X21hc2sgPSAweGZmZmZmZmZmdWxsOw0KPiAtCWxvY2tkZXBfcmVnaXN0ZXJfa2V5KCZkZXYtPmNm
Z19hY2Nlc3Nfa2V5KTsNCj4gLQlsb2NrZGVwX2luaXRfbWFwKCZkZXYtPmNmZ19hY2Nlc3NfbG9j
aywgZGV2X25hbWUoJmRldi0+ZGV2KSwNCj4gLQkJCSAmZGV2LT5jZmdfYWNjZXNzX2tleSwgMCk7
DQo+ICsJbG9ja2RlcF9pbml0X21hcCgmZGV2LT5jZmdfYWNjZXNzX2xvY2ssICImZGV2LT5jZmdf
YWNjZXNzX2xvY2siLA0KPiArCQkJICZjZmdfYWNjZXNzX2tleSwgMCk7DQo+IA0KPiAgCWRtYV9z
ZXRfbWF4X3NlZ19zaXplKCZkZXYtPmRldiwgNjU1MzYpOw0KPiAgCWRtYV9zZXRfc2VnX2JvdW5k
YXJ5KCZkZXYtPmRldiwgMHhmZmZmZmZmZik7IGRpZmYgLS1naXQNCj4gYS9pbmNsdWRlL2xpbnV4
L3BjaS5oIGIvaW5jbHVkZS9saW51eC9wY2kuaCBpbmRleCBmYjAwNGZkNGU4ODkuLjViZWNlN2Zk
MTFmOA0KPiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9wY2kuaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L3BjaS5oDQo+IEBAIC00MTMsNyArNDEzLDYgQEAgc3RydWN0IHBjaV9kZXYgew0K
PiAgCXN0cnVjdCByZXNvdXJjZSBkcml2ZXJfZXhjbHVzaXZlX3Jlc291cmNlOwkgLyogZHJpdmVy
IGV4Y2x1c2l2ZQ0KPiByZXNvdXJjZSByYW5nZXMgKi8NCj4gDQo+ICAJYm9vbAkJbWF0Y2hfZHJp
dmVyOwkJLyogU2tpcCBhdHRhY2hpbmcgZHJpdmVyICovDQo+IC0Jc3RydWN0IGxvY2tfY2xhc3Nf
a2V5IGNmZ19hY2Nlc3Nfa2V5Ow0KPiAgCXN0cnVjdCBsb2NrZGVwX21hcCBjZmdfYWNjZXNzX2xv
Y2s7DQo+IA0KPiAgCXVuc2lnbmVkIGludAl0cmFuc3BhcmVudDoxOwkJLyogU3VidHJhY3RpdmUg
ZGVjb2RlIGJyaWRnZQ0KPiAqLw0KDQo=

