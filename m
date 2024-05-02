Return-Path: <linux-pci+bounces-6982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F5C8B9379
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 04:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C80281CE2
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 02:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5817997;
	Thu,  2 May 2024 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPaoEVfR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805E418E06;
	Thu,  2 May 2024 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618326; cv=fail; b=U1Mtiwqdl33bv0wcNi6x5k1st14wdQL08zVgZvOklW769UKZzSKPIwERYiguHL4hFxWgTGR1HP3HUiD6cpmvEipPdQF9JUnsk+hbUF8EQL5+uq9toXqY/FUCSeln3Xlx0YxlLMBQ6KYMLN0Ar9xSTYBG8p6OATAEhbLPQcJv4Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618326; c=relaxed/simple;
	bh=d9HnFk4q3gQBKuO2A5HUrIf4PMikH7wDv6HsZM91PyY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CTWlPC2ISBemJsgflLYi4oltGY805lXTWWk/2VV9onaaBmZJyO0643qxQ6jFkPlmULkOysrfjnjYHVkvzrsLxYEUWq5aI5sjO71xatB3QhcKcyAY5U6mrlshwlQ+W4BBquP1mUQ/TEVg2QmJUoRGhO/v/qwPOScTGqHr64jbc30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPaoEVfR; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714618324; x=1746154324;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d9HnFk4q3gQBKuO2A5HUrIf4PMikH7wDv6HsZM91PyY=;
  b=XPaoEVfRyEK8hJwA7ZcJfzGV1EpO0Y67Dpvxts2bdOVabQybPbzaLQ2f
   EkiecW89WRJIB29uQHo1D9rPUnMx9PPbqoaqY9NtMEtbsfmLfGbQVrtES
   tatp8eeETVRGBYM3uJdpkQjOhv6GOLW0RzZP9ykLnGFjzwJYC9pxZhDYG
   7ommcIirp34taUi6ROccQDlS01KOUSUL9qGpBA5kGWFFApnsi3UKqsGY1
   /1p2q/E3NPzFGZyb9yXiMUH0E87RvQSPP4aYNKPgU3Co5NP3/cxfxxokL
   6cK675YARyeFers6kJIN3MfSiIgpiaExBMZruHFR7pNbh7ydJ6H9jDKCR
   g==;
X-CSE-ConnectionGUID: xao1KuywTd6QwHy6Vdgsow==
X-CSE-MsgGUID: DqGRRy9OQ7GfRy96S0KKOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="27898852"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27898852"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 19:52:04 -0700
X-CSE-ConnectionGUID: xYZpYd0/SAGAjy9Us1aPFQ==
X-CSE-MsgGUID: wtDtLswOTySOFbgkp5TzxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27381503"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 19:52:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 19:52:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 19:52:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 19:52:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 19:52:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG02fUZpKCHeEBAFpSdauQufuFWPHKqjDvRLeK7DzdiSRM5Odqqj/ieKSvN+DqyPEi06fOsfohTa3p/2OoizgjB3IGSCHwATSDhOBIsoWU8aXhDdlQrHfgaboVRLbCIEEc1oUhWqJBeJE6QImobAeG7G2ILWULdqq7JX/GLJ4CaBNuTRAdrMLILJdEdFC1HYkCruL+oZ1a3O4RrPYu5ah4ALnyK08DXL6eZilB2t77Wn6UAhbpTTb0gEPqgrZs+/6fZUyZioUkQgu1ad9Fq593P2YYUz9xND5MpQZYZ4OlnQKEA1fTJUB5l2a8XOp2aSNsHE9ZddJsJNuKhl9Sk2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q6s8LKq664xATsdv2aICoGNqGko2NHx+dI3lsxBG7s=;
 b=kasAM0ComZ0bcJ63HvDjHF9eqGLJ5Pqq1+hjce1pz8HYUB6KmJpdNdkrTSsWKK1+tQXYWHDEGznzeCEHVkT2A9bgz59m1nGlQ6vG7CAuT65/SLggm21hdnwx1QrDg5jdBFOCQxvZBxsvBg+hV20bx4UDUFF4BV5uWME94N/m0Z+GvQIUVd+v1ZG+Bk0QxPkUasqITsur6/QQ3rMfPWOd0f72bKcbXgNM6LpyTHZi5y48CbJHvY4Tir1DMyTS2qse5JCSgmNI5aXkmTnw2uMN3VrScMyLiLhVDLLD63XwOXxgyDF8Y69pBKBHqw3QXCYKkucKs5vBgw6EyfKBso80yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8164.namprd11.prod.outlook.com (2603:10b6:8:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 02:52:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 02:51:59 +0000
Date: Wed, 1 May 2024 19:51:56 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v5 3/4] PCI: Create new reset method to force SBR for CXL
Message-ID: <6632ffcca559c_1384629465@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240429223610.1341811-1-dave.jiang@intel.com>
 <20240429223610.1341811-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429223610.1341811-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ef43a5-388c-4047-a275-08dc6a52d61d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NwSPu2g3v38JcW0hLqDqLerm1WvkLH/OTjTpVO7y9SVJFPqLGpOqgSjA2izV?=
 =?us-ascii?Q?LVuoRVv0kewJ5p7BQAA4pb+Qjz9SN5oy/6FUNvoMBiG+Iz0uTduSyI3Gz55O?=
 =?us-ascii?Q?44AMwYKXOSbgpH4IrKmn3bFnL1lHvfE2mt+h09H6AWV3OQ69n10NGWhj9SZP?=
 =?us-ascii?Q?xajKP7TArI85FJbJpO2D7nnoK6ZtduY1kWlB2qdxkPwvkRObJzTEnHTrCZVD?=
 =?us-ascii?Q?J//b5TGL1z9edT2hThFsLk3Etw4DJAM9bzMgO6n8s5/IfTqJZzGKkm6Ztt0R?=
 =?us-ascii?Q?GJIGIqI0cRmCRt9PQH3U9gVJYLnWEuO3W07BhGTaMv+MZS1n6mWoxW0o9kfj?=
 =?us-ascii?Q?DD+mio4hUfGdMfIYzRNGc+44d8NRPpsfni4T6zIPTTacwwjWeqXRQ2rF8rtX?=
 =?us-ascii?Q?oOtkLUfhje7/+eBxK0eNcfvSeSrteIkGet29fTWSyN779d6aYmYbHdxUeD2Y?=
 =?us-ascii?Q?/ZStoq1uBYGYr1tUDLuOvrwnuuMTGlLwh/om8o4yOTXxYs1mL/e1+As2va57?=
 =?us-ascii?Q?HKy9R4HjOM+6qgThfIJacepSrNx1Qpik6fW3JaryPqFPk3to7BzGB7C4aZrL?=
 =?us-ascii?Q?MtCbmkfmq0A3jDXs4ypFsTupgZmfoG6+M+eWfoDO9+4NshceZ/IuxcCnfyOQ?=
 =?us-ascii?Q?GlrV/H1r+AQzg1+uxUhTjmu8oY1BbtfP0lTjs8qq2jnVHicq31GVipw3CELy?=
 =?us-ascii?Q?KNtvKhLf3zPVlyxd1d5Llh0QahtgjBsCaZY9Y6REudL+jj6/rGKBPNJtof32?=
 =?us-ascii?Q?fnTKfVnz3s1GUrYRyVDxFjBLIyuPoYx7HMeg4GWfTrayZa/kwPOJGfLR0JdG?=
 =?us-ascii?Q?2hWWHzAplFH8emB/5m7dhYtadcpeM4zeAWBW3lv10v+F8LgT1kNyTyZGyx/A?=
 =?us-ascii?Q?7aLHbsq+rureTLzLK4r4YPdVjQ0DYMrOIkE87hzHXPDaG2OY6YJ4gAY4FYL5?=
 =?us-ascii?Q?u4DZGzDhh+MA9Aun0w8hsLmH9JJJod49Znvp8VoRjZAO+/9NVHIZhf4g2Pju?=
 =?us-ascii?Q?gJKn8Eo20N8y7DaOp86QX7WZLkpC/t7P/j4JzieMb7H4F0oH9mXojZrfaqJz?=
 =?us-ascii?Q?whfRxNuf8bpsQkWr4eKokeQ536zqZZTOgKniijF/qgMB+7uPZN2EgVDFE2ml?=
 =?us-ascii?Q?zt0deFI6VY0ManEDP4c025urIDdHckBf7HVNILmCfuRvbVKzs0XMKFhKiCzR?=
 =?us-ascii?Q?Gsh1/PdsGihiSiljqXWKpu4QiUjrTtJBPmdC0LYqOfEHiGa61DxGz6qtCN2e?=
 =?us-ascii?Q?4Vc6oyjjRO3tNB9ttxfPgC448z2pE4hoSEeF8EAKQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k50O8pzHfUXqloCfOKciuZCepMagdcBZK9jeAyfv5xZ5ef7arJiH42vvkVzZ?=
 =?us-ascii?Q?K6ES/gDRruNhlNxIh8fLxjs17SurhwkzFd7898O0S97RSRmYzK7R0b/cf8c+?=
 =?us-ascii?Q?QJtYmkIiGYBamWOxpotcC/YZdJUo+77lJqwM0hVTgsytieTX3SxTykxkbB3q?=
 =?us-ascii?Q?M0oh98mlvPGTg3WwlF+PT2eRix3keg70bfzwlIZjmuTWopX2wo96cLxGPVDl?=
 =?us-ascii?Q?pIYqhSO/tg6/zm/DPkDFtLTNaPiEDuE5etZRqBrGjH9oPhayIEGSx83Kz4d8?=
 =?us-ascii?Q?WZBWMVhlR5RSGpMJGWumGaNxRNFGGBtCGrIidpNOtSa1xW3z++NRDUYqjS0h?=
 =?us-ascii?Q?3AkXbfOH2HQMhDbFt35Jol0+WA5JB9dIqRXynOnV7H9o0Lh47T7bCeVPBpje?=
 =?us-ascii?Q?Bn2QQgGdrQBI2jnzh5eEDLk33K1elIrU9UT+C6vyihWnlIAwd0ou8XqJb2uV?=
 =?us-ascii?Q?YsKi/2BzI97CfsR7yKB7jYHsCG7bm3eLJwxs5CdeXhgY3qS6MS7KmtgUbJFQ?=
 =?us-ascii?Q?VqVn4AwPu90l6a+TmQ+SDLsY7fcsVEgLWiLCC8bsV3rfQac08DMjBZgn5gTV?=
 =?us-ascii?Q?iRXWBtOKrfyQ4a+zX1WpFrqsQy+lYQaVhCRqg4LqM8ELrZJO8N9NkyaqHlqo?=
 =?us-ascii?Q?xX95Lx3j9xCOsarpHl8d8P2m5LWEd8JeoKOS8dTe98NBBMdYxM/NEBHpBOxU?=
 =?us-ascii?Q?s3GiDa8WYF03a9ZhhPh2um91Wtv/poZbg73k+OpHbMxwdxmzsiZV3UsRbw8k?=
 =?us-ascii?Q?4NGbTanEDwgkBBhxrNN8BPCEki51Bv1sG/iN0bHM1PnkX4f4yPkEztkZleGn?=
 =?us-ascii?Q?2kg55EQpXcftR0cXVyby1mByKPl353rMm+xbxHxNeE0ex26+KbsSkvEQ07Wq?=
 =?us-ascii?Q?bc6X3w1p3zKy+lnT6sgsiD2uLRWxFLAVMJs2J9/aeXWWcpvV9TfFiUuRufia?=
 =?us-ascii?Q?GNk2rZnLeOb+W64UFn1cqCCuMR26Rm7kQCHsnG0xItzTIzPljt+a8YeU3Acq?=
 =?us-ascii?Q?uZVVEVm8lWlt5qK29eHJimbUdUbHINoHjuKZ/WjXZE6oVT6icgnTn8TRmob5?=
 =?us-ascii?Q?SYiPzDOaVPzT4GSbKodHmosRg6+imJiyVg5GoldNvL9O9AygffL/KgWXzSy8?=
 =?us-ascii?Q?y3GKFanbH67FTTQzN8Cu/vPjtgSdwz9h8tadhyjrf+JQBj4O/Jdklfr8W17H?=
 =?us-ascii?Q?lSUHRDDm71L04Y/ErokV4N/V5bPLPQh5xWiBjvEoElfRLbcIvAZVQ6Ar/tQq?=
 =?us-ascii?Q?W94wocz9QQh6bYAvdRVLqjYH01pMaghI3t5tpiSrTHqGTwKfPXyAXBn7hcjb?=
 =?us-ascii?Q?KgIGs03jptoYgEOwcK3bCXU7zZcGzs/zuniTQeTpLJlepjWH0zrN9IosB0Vs?=
 =?us-ascii?Q?AqPiLdtG4mflZVtDCg9BCVQl4VNphySYiYWbv375oiim5QZ4VtAJJupfGMpu?=
 =?us-ascii?Q?5nsL8zT9atHrsPZXn8p0Jgm1XU9r4FPHaja0DBpB7UqEfTwx3QWeX1WcKWqf?=
 =?us-ascii?Q?jJSgr0x19HdshRhPhEmszU1y1gnnI1UNl9nPt6nS7LEkS2xsJaRfA6Lg6sXe?=
 =?us-ascii?Q?UZPyVB4PIFA28QS3ZIEqxkDOzMnN0Vj6AnkTqCYj9Zzn3D/KZmx0cYTP/Ul6?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ef43a5-388c-4047-a275-08dc6a52d61d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 02:51:59.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xz7YkX5hw234XYzrvrT4FotpZ+B4eseGy7c/YkwVwEtF890HqTTOFFzwJF6BhQa5SxDndyOWDsSyUdQpcXUoFC545uhFQbEiH2j1d+pxBuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8164
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> CXL spec r3.1 8.1.5.2
> By default Secondary Bus Reset (SBR) is masked for CXL ports. Introduce a
> new PCI reset method "cxl_bus" to force SBR on CXL ports by setting
> the unmask SBR bit in the CXL DVSEC port control register before performing
> the bus reset and restore the original value of the bit post reset. The
> new reset method allows the user to intentionally perform SBR on a CXL
> device without needing to set the "Unmask SBR" bit via a user tool.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

With the locking being handled elsewhere,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

