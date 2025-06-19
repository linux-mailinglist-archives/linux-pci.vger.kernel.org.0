Return-Path: <linux-pci+bounces-30205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E96AE0B1F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 18:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9329A1883AFD
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D321C9ED;
	Thu, 19 Jun 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtqnOOga"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A621578D;
	Thu, 19 Jun 2025 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750349629; cv=fail; b=Em5LlB+a8ucXcoKFLYA7qIE/VfbUqgSF6FTTW8lnmqx/UnFEP8hHAEwzjiqSmVNGD3XB0B7hx8TAmv2a1CRFuDUTtPfEYUDHtOLBFbaJTND9kI+26n7kYSprjJ8rcxT0BhWqRN52ShHzJl//jLmJuRsXJbrExA8u1wE8HxBbgIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750349629; c=relaxed/simple;
	bh=0UoS2z9zCe2+bJWfU53AEO23uPKyIKmL6je8Vd2c7Oc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oS7DOpfWK646ezrjSuipcSReTPfsUvM/Fe4/cYWVMqdf68Ao9pYMJKtKHQOpMsg9UCRA5w5u1rVdTt+trzXYAHk97jZPU6a8h/wYGZSV5WXTKuYr9EF1c8wK4ZgbwOPsFGfMhhbXOQhje/9lr/8Ze2BFP2wbnb4IstfN/HaC5r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtqnOOga; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750349628; x=1781885628;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0UoS2z9zCe2+bJWfU53AEO23uPKyIKmL6je8Vd2c7Oc=;
  b=HtqnOOgaGbkn7oi7h6NXPIG7yM0hSl9vxo5DGB5fGTxxOO1df+p3MhER
   PUScPp37hP0fY/Gz2OMU7ibtRTQ0SXLsPHcxgPU5X9SBVa5/7OC60HWUO
   nonxzDjjF0yIewCrxFu0NB2yR45j8hHh01hAevzAcYPQGO0IIgesR/6vm
   ExY9j2PUayzKpucQefJQdJc1M4eii0m3GFeG0Ch18o7rKThyugicpchS0
   RkxnP+y1Q2Vi8KRLHGPDjWzP32Ita+U7GcPXPWOXF854jrF1H8Tx9Rsvi
   wSeV6v2Fs4YQj2e7/lj4dcZfH4QdV6THuHodiv4ECWJcLzRO5kB0paXSt
   g==;
X-CSE-ConnectionGUID: 6swpdBbwQaGxhitmHBeBqQ==
X-CSE-MsgGUID: wOqFC3CORzee1KgbsT4RLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="55238774"
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="55238774"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 09:13:46 -0700
X-CSE-ConnectionGUID: OqPUjujaR5eSSnH6Is3HJQ==
X-CSE-MsgGUID: 1EcX+U71SIKzMshhW4K/vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="151224303"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 09:13:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 09:13:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 09:13:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 09:13:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snTbNULZZ/0qaTa+ZJgXoDCwrT1XvrVQ94pOcy50YJxmkJsOYlOmuO5B39g9tchphQ4kq4Rj2vRLGMav1rdmy7Adu1/FqeVGQ7uD480pL7RXII3P62C7NqEniWTdYjvV2pjghJ2QSdM29r0l74ktvdt893JvczgjwpxGRKoS6QfbDy5Ryww8C9RrbL5ReuMZdn/4jymLcFcWrkWrA3wRqFoTQpGV3jtfxVNvvmVdG8GUgH7S2riv2G/Db+K4hZOwT+52NIsyiTo0aHtzaWV6XXmHpK14MkZWdF1PTFER2pV+7Z1L6YsQESQWU7VIBNwOmINDSNjkKMhlPC1gWELAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ3/bBq40ZMGgK5xBvuWb3lKl9+tqX0gWQuUSFWv4ao=;
 b=EAuU3ZcjsQxZ1dzG7zXevZgYI0xUANSmoq+/NQNDRKGB1IGUOqPyrdklO+QK0W6AVw0+FU4bnjU9j6rt7qXg29CFtPVg5fNJmUWYvMKLvIf9K/gDMuHBNT4I7YIikSlB4BDHp0abRjSmyjMaKliMjc9N4WoTw7+y6subrajEuVNvNz9Msjtk2e0TwKVMfD5Ce5oLekVb3wDJ3TzgFxMS2FbMSFtNjfW7dDB77TdzfY+VB34Oudi/4FxIdcz0K6O+Xv9SPD1zACJykw53yMOCW5dAdXw16NSGnu1TEOCL3AWHEesj5r1R3CO0JMQ2JsPt8TMyVWGfY8NcgzLE9PYUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8683.namprd11.prod.outlook.com (2603:10b6:8:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 16:13:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 16:13:35 +0000
Date: Thu, 19 Jun 2025 09:13:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Dan Williams
	<dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas
	<bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <6854372adb554_1f9e100aa@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250610114802.7460-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610114802.7460-1-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:303:b6::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: e209ee97-a653-4291-eb28-08ddaf4c3e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?EsnOqbA4FEQaB0nSSlZWku+yVlDVNj//P4tulkME/c86sfLDb5aqTiBboD?=
 =?iso-8859-1?Q?XP+vKsNgmjUQgB3N9csqI65l+1r+PfpTRUoA3zPPhOTKyU4ZkxMIKLZ9CR?=
 =?iso-8859-1?Q?XhF8PsTm9Lvl6XiyBB9g4VZqvqOj60fSAYyjU2CXSHXqQZ0TsGWat6DyKC?=
 =?iso-8859-1?Q?Z+ctGrhX1Ok2kalmy1VkKsHIaSiciT6K0qmHw22kJDNZmJUOBmTv0rg0JK?=
 =?iso-8859-1?Q?3OQHGL4TGg4eVwqzxPcAau6poT8V0jPkrqdKgA/gHv20N90BqTcxKN3pyh?=
 =?iso-8859-1?Q?25IgOvd+rA9gdJmKfpXiMNH7SRjfKo47PHf2U6u6JPl01MBLQcYLZ7uLrN?=
 =?iso-8859-1?Q?KzPgYfuP8FyG+Yn/XnR8woWheFVNpH3lH4MDQHVwdkOrZh7PyW1lPF6UBT?=
 =?iso-8859-1?Q?UTblJs5aMl3Qfn5NFWEiNzbu1E7NgZH5Oh/kxwMZpe9swTHUR+F1v+ymk5?=
 =?iso-8859-1?Q?EwWn2+yuGwu3P5xuQTUX9TrQ0VE94FLsca9kLJYowJoCBaV7nZmxrNbHTW?=
 =?iso-8859-1?Q?9tzYCdeztgYhtu8rbVkgCQh7vgpkhcPB9Z8RMDj3X57i/DE68o2TE0+4PY?=
 =?iso-8859-1?Q?LxWLJMu75rzcKC0KTpYIOxPt8CMdusa2J/vKhoxMcxxlcwpdmsBB7K5icU?=
 =?iso-8859-1?Q?NJVCgRM1gm6y4Ij+JHt1P0GpGYRo8WEvBtZDULHEnKeN3RtmrA/dFpv+jb?=
 =?iso-8859-1?Q?yDzQqMyXJAFMkr6O/fFuLD9+dbs/jiicS8NKoqN6LD9WAZHEXpeeztJoYs?=
 =?iso-8859-1?Q?cR/aY01snBPPOATSbzAPTkzNq2sBvsZNfPGsQ0rghGaYXgdvyiZIQ4Uaxc?=
 =?iso-8859-1?Q?NLn/fem/M2DUSsxtqALDPhCnhnORigROIDKXvh4GPeuiGvIo38u1o/069u?=
 =?iso-8859-1?Q?aCiBnDLNvHOwThPw1ogY8Bz3ynTx4d6BxJ1PtfeBdbxfpDp0pfDZ1VoMHO?=
 =?iso-8859-1?Q?FHH95jQddnDnhbneXXh6WJT5tLLxZgTk08l8zYl0RzJJq2UoVbmVsGRRhj?=
 =?iso-8859-1?Q?eu0sotT1nZYj3ZTbC/3AUpYEkrw9SStSuGDEdYckcVRHaqczfwDY12IkII?=
 =?iso-8859-1?Q?Wh8g73zDpHHVlYXqg3/SNLIizM9vIuhLP2Up4iNqLLuq2ub+y0JkTb7bzB?=
 =?iso-8859-1?Q?KQWENUhi0AwHhchZMWTd0iC+e3K2G+OUXaxZyqWi4gkRXpzhm/HwSxcL8G?=
 =?iso-8859-1?Q?u+hMWBruAJ+W8VZ+sZ6UmGy9fC0TKWQ1CkG2V8cSu9NHsgEulr1ATnGh6V?=
 =?iso-8859-1?Q?P82CkHbNeeGIO7Hr7gNY5DiSaDiDnCRBgOGjG7TCEBTMwPE6A0mxRBRbge?=
 =?iso-8859-1?Q?qcEmYPo3pKl251ygcwBUO9FHGPAftRA72EKQeJMNNIEGGSXBJ4Kmw+Oj2X?=
 =?iso-8859-1?Q?U9ipZBwS8rJf/qob5Cgzamo/otHqSMLWud63U1+nsUdiIhAfDRSu3C+igs?=
 =?iso-8859-1?Q?Me2amL9bg9KGkw1zbVnicwVLsbgZi997gvgIpS8YIXw0hkkbPlM+yk5yNA?=
 =?iso-8859-1?Q?yVO4sd2WdnPNOqb73tU8a70xfqNZhYGX+XBs+hmmaEHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0xUuE6QJcn6VsB6D38cmUnzomlm5lrhoajmG1NCqKVnt+plckrkYt9DqCd?=
 =?iso-8859-1?Q?hbTRCQ7Usc6tMR1CKeY7+3IkdFOf18HQ+BQfytfYNeMhhOvCpirFvIgODB?=
 =?iso-8859-1?Q?gUdKW+ac7BiawfGDDOOeg2MxnDeE2RL7uMfG8oxMhFIjPym9eTMlWGBMdz?=
 =?iso-8859-1?Q?7+mCyGQIja//Ej+kPZLCaLVtOAcOEmFlIrkqLuIr/mI07fNCyuX3t989A7?=
 =?iso-8859-1?Q?O9Uc8sY3kxVSskwOQYhN1QdhRHM9DDPUZuL42/4wiTkK1bXrYpc5ZbgsX0?=
 =?iso-8859-1?Q?640bxwui2wQBVEg03CaK1H0wnuf089vBy8mw99tJTQ5IjtFE8txAn2Hk3/?=
 =?iso-8859-1?Q?MiAgGbcLwt6826DWbOgQAaAMCCcnABSjVoQG6vF9koUQVFc59RBASUmSoo?=
 =?iso-8859-1?Q?OmJSdIj7wd6eNKT2EuwaYDfbHHsQmfmpKzu4mSX47eq4v35vAIHiQaJCwk?=
 =?iso-8859-1?Q?3GHxcBTcd+m0veoIMKZVVZTWhKe6dcdS/fl1J79GCCgh6zrSCHD19grwby?=
 =?iso-8859-1?Q?qG7fm9OUreU0WsnAa869Uvn1SZEWDGAzaEJYYPggrknGa2c82N5cc7NZy1?=
 =?iso-8859-1?Q?XEGtPSc3+mGRf/T7j5ul9QYTH3Z1Jo9pgmxX//EQAdZfxLcG/1vmQGxWlP?=
 =?iso-8859-1?Q?1fchvmmnOGxeH8RcSyo2/FlmrPPLBckh6AbbahjmP5e0D7f+H3KiPN4qLU?=
 =?iso-8859-1?Q?28K1HH/+r73BxlxikAw1SG86BUYjpTEBP4pnw2epSU0QlPm9Mx9dO6x2J/?=
 =?iso-8859-1?Q?c9sJ40TxTe3h5PjwXGgVeDA5GGMP7NWpg11/er0rTH1k0bWBOd4G2TCnQq?=
 =?iso-8859-1?Q?VfAh4F+sBIo7qpRr+ScuKcUWW2s11Pv2yysiNIWrgkVHUyqWBPVv/4mv+7?=
 =?iso-8859-1?Q?bE4wsQhkvqPzSA6REfUy0zsBu9kSkD1moy2QnmjpkfSC4t6xZvfIoJz/VE?=
 =?iso-8859-1?Q?rn+9MysnGLnfIWwzbdNoSbiuJ2zRB4mbvYetbF2XKIpyY6km8sYR73akTS?=
 =?iso-8859-1?Q?z4A/Uhv/wbZxwfVKHRuBI2BkU0u//OQ9qD7O5IBV2VIDGZzc/WpBxlMdLl?=
 =?iso-8859-1?Q?mVP1YjuP9Pdj0NRmAbBuq1+6usIFNMcDlYwJP9PQ7xnSIJ+sN5B6Jf/Bla?=
 =?iso-8859-1?Q?MzRZj95Jp3rrWn9x+k084Lk8OC9gJfe5DkbP0+sVMrZkspxEI5nHv4rFu6?=
 =?iso-8859-1?Q?jCp+MBzz8i7ONHL+tak8C/OPPXpb+8qmk1JeLB+T6YLaN7RqwCkR7D9WHj?=
 =?iso-8859-1?Q?lLaK351ravyjExey3EdwK/OqjnzBZsLWFRmd3pMw8abvjWmUmqOZl5U3vo?=
 =?iso-8859-1?Q?RVVzokRlgx3RwHl2WKTBQfVs11aj09iZbCzk2q0OO6MeX3KyZbnmiJkK8D?=
 =?iso-8859-1?Q?6iJyTu4nxtBXXDjSYJ8erKUEmY8mtTus0xjmLDB2IawD/u5w97SMfV6nUt?=
 =?iso-8859-1?Q?X76gt1QMu3N2sJcwZMOoVT39mgNATvqJrmPK8Xa/Tm5zSAlWUaoHyP6NJ6?=
 =?iso-8859-1?Q?5qtmPIr+IML2ApyW0NyOVNpFj3DC+hfBKynqE+pYN0TQDt/6P7/Nt4QUfB?=
 =?iso-8859-1?Q?Wzj6RNBWxJpBZ1tkGs438oc7v6NLCCFx15bpfdDUq/IO/BL3MhX8rREDJQ?=
 =?iso-8859-1?Q?eEyJ18ACgz+L+iWO/+pL+KW1NJbQ+CUnwj7kXjDQXdREq+Toa3XjPz5g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e209ee97-a653-4291-eb28-08ddaf4c3e34
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:13:35.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU/YIxJ0rJOQkCoQ8LOXoP+89nBUz1qymcHqbzQ5ns0YDo4nVOEat6nmlik44cY0vZYY/7Xjyp8eTvBFRh446HGffOI8DJsidPL15/6o5Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8683
X-OriginatorOrg: intel.com

Ilpo Järvinen wrote:
> When bifurcated to x2, Xeon 6 Root Port performance is sensitive to the
> configuration of Extended Tags, Max Read Request Size (MRRS), and 10-Bit
> Tag Requester (note: there is currently no 10-Bit Tag support in the
> kernel). While those can be configured to the recommended values by FW,
> kernel may decide to overwrite the initial values.
> 
> Add a quirk that disallows enabling Extended Tags and setting MRRS
> larger than 128B for devices under Xeon 6 Root Ports if the Root Port
> is bifurcated to x2. Use the host bridge's enable_device hook to
> overwrite MRRS if it's set to >128B for the device to be enabled.
> 
> The earlier attempts to implement this quirk polluted PCI core code
> with the checks necessary to support this quirk. Using the
> enable_device hook keeps the quirk well-contained, away from the PCI
> core code.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> Ingo gave his Ack on v2 but since the used approach has once again
> changed, I didn't add his Ack.
> 
> Mani did express his concern on using enable_device hook but suggested
> I send the patch anyway.
> 
> We're also looking into using _HPX Type 3 (suggested by Bjorn) eventually
> for this class of problems where FW settings get overwritten by the
> kernel (but it will take time to make it the sanctioned solution). In
> the meantime, this is a real problem for Xeon 6 out there so it warrants
> adding the quirk (which is now pretty well-contained).
> 
> v3:
> - Use enable_device hook to overwrite MRRS to 128B if needed. (Lukas)
> - Typo fix to comment (Ingo)
> 
> v2:
> - Explain in changelog why FW cannot solve this on its own
> - Moved the quirk under arch/x86/pci/
> - Don't NULL check value from pci_find_host_bridge()
> - Added comment above the quirk about the performance degradation
> - Removed all setup chain 128B quirk overrides expect for MRRS write
>   itself (assumes a sane initial value is set by FW)
> 
> 
>  arch/x86/pci/fixup.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Thanks for the work on this Ilpo, and thanks for the cleanup suggestions
Lukas. This version looks reasonable to carry the kernel until _HPX can
be relied upon to help the kernel apply quirks like this.

You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

