Return-Path: <linux-pci+bounces-19736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D07A10C61
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDFA37A2134
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED4F1C2324;
	Tue, 14 Jan 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPkkGyLo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A17190077;
	Tue, 14 Jan 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872566; cv=fail; b=T8R8qq6gtPzcd2yTwCoj+hxCx8V7EXz7eRKFkUeCjXqQ36PSI+9TKEbMp9LUcwKgLagVivp/19EQKcRDycCBqP+7RlDuq66i/FA/l3Ed2TpCEA1NQ9JGlJ4GX8jFw8TSdqvmIPSmxPOkEkgfOC7IIMSwhnV/nfS8oNrhpcdrVD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872566; c=relaxed/simple;
	bh=dkxSjXpcex1np8gxUm4SqU+QPxIFzU0+Sfs3EpVUqJU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YYM269Sb3DoQKW31Bc+CfvLaj90bf4s10yEjK4+LiSagv9FvUMAi6UNOkkiwDNXr68sNIt0Ysk0WE9RctrcAcStKoV8GQQiBV1mh8nrQqEcfJOZHiZlKL7R3WyQ4myHaK5XulRnCycvDmrw8wiWITYStlEK54VNFRpGsXwr2tYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPkkGyLo; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736872564; x=1768408564;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=dkxSjXpcex1np8gxUm4SqU+QPxIFzU0+Sfs3EpVUqJU=;
  b=mPkkGyLogseUJyAABjCZvCQ3qOQFSCB8wo9z6uMwr98uaMeD5CVhAJST
   /yjPojUZ7Sc/MybWP0P0DoXjqVpHxuMAziJCeOE3upx/UpymEDQW2vQNs
   5bN8PUgGHvlb95rg2QHscqBGEMfOYpmBBASO+qIJdkSrTcWOrlnwf4Dam
   ZIVt9VZD5tEvJfWnw7QgbFUHlia0PV52Vxzf+ptDEPXJxwcIKsZqR/mmH
   WjlcCw8Zjoqnd3hv3ExnfzQZ9LeDH97p76g9v0OxkS+aEAhz8vL4PtxXY
   m9QMhtyqhvCEfQtPEDLReoVeVqX5woq0q+iAjXHGJWVs1v/1r3v7O/Spu
   Q==;
X-CSE-ConnectionGUID: l4KMPAeFTHy7kJTp2iQZaA==
X-CSE-MsgGUID: pAt+wRRQRyGpZrbh67NWKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37290492"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37290492"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:36:03 -0800
X-CSE-ConnectionGUID: A48zZuSSQveONaZCyi5zDg==
X-CSE-MsgGUID: Y/jOfquuRK6mAKMyPMozwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="109799386"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 08:36:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 08:36:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 08:36:01 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 08:36:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2ZtY2uCfTgiGkSr0go9MEwNoHo5gWEgQdTj/0iIBXJ4lVknDyYbuHCk1/TJmEZGri5QcWxpsi1xBuAVBD7Mi/VdiNj0UR1PX2Fo12d7usYr41Xa1froLpSwiJ+eO76vYZr30YqoVH+6NfUf2KtP38pKMGHkMxRhwtTSiZqn+Hr/DzO1Gv46wXrnlVNcOBwHMyQl3S6TsD79PikGzrZt+j5tHSHqpHUD0zR4GPNSllNszuKyteE0x6b9u4a9BkDDBxW+2qYs+kC0Bv+/9E84RNZNOdD++0QfwnbzGCswISahsTO5ccE2mCp2FB/9GZYPnne14XvFKy5A2qpH9eMLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wA2yqA1lYX+HHhRzcvOWmkR6IajegJbvGUOoqIWaTo=;
 b=LB9mvzto7hiMug2XQW9I82TcKl/ReHeX4xx2Rf8ip/XW6YZQZnfAsLlCR4k1famXPZQu2+YNtB9y+9XUwTEM4CaoSv73D5QC1wbiJ2V/8e4DMsDcvgaGbjqm7U/+eoEwfyZjQVHZLMkiifjUnvtNE2hNByz2ShMeUvj/iDdV/m1eXX0Vb8ASpmm5SJO8g7R31OkuoZTx53I//QRZ9nJA5tBYi4ew60f0fnKSJsUA4lM0StI2CtTBf8LCwVseg6UhPhDd8XHVagXuhMFbj312RHuCDOJKPzVfLKx85cDqwSjCiNbVqMNgHwqxCaC82QumM6L8qIR/583aRKkZPGLiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 16:35:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 16:35:44 +0000
Date: Tue, 14 Jan 2025 10:35:30 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 05/16] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
Message-ID: <678692525b2be_186d9b29445@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-6-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-6-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CYYPR11MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: b7990eba-442e-43e6-bc82-08dd34b97def
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nyXJayNNVgqYvz6Newl/1Nn4Xxl4tdSxl6B/O+JHLclUbUrSbCagezVjdjSj?=
 =?us-ascii?Q?hnVSoljaK5gGvbuCsidiTtgSDA7CSyLZQfEn/wo6dgQ7ZnXIeTfJj0ut54ag?=
 =?us-ascii?Q?WGtGF66KfB6en0aQMDr9tPVrxNHKK4Vqmo79xpGeIQ5UpuP7iUj+7pmnEtlB?=
 =?us-ascii?Q?bAIT4YFtOiSBgPumQp/H3kpSjIFg+1apRuaZ7Osw9e8u7pKlgJTFQo0J1jGd?=
 =?us-ascii?Q?9J5gzfVVrCasmftq5Zg4D3IHojWj7P/UuM7snDecAhbdDdlEQ0a6MI4/6gYG?=
 =?us-ascii?Q?f70vnHv2N4JGeyjhuig7PSeJKu+xFUUgILUntkNklwqGEt+931z1zPPuMk0C?=
 =?us-ascii?Q?lywZo8099p+QtN4+4Pp3cBpx4A9sNZgldiaiCheMHfSRe7bHksvwNSVPyEbr?=
 =?us-ascii?Q?Tkm/e23cJ9huC991y+KWe48oWrRl/cO7GYiVDaITZRs1VtM4cIsca7op/+h7?=
 =?us-ascii?Q?QOuKFEdgWbkGwXU+yMvRk2upaaMXrbTNEkZ61j9eiWBM9Tq7BUpdz6qP/pNz?=
 =?us-ascii?Q?16ftkina515SCqHRY7TcEM7EcyyAjhTUM26hdcLSHTgXeTEHLNKx/bbFAk+s?=
 =?us-ascii?Q?dyJS3NB0J1vvPpPZihNns1MduePL8tdWHc2pgOYcUcRq2YLsDj9VtXkd/JuM?=
 =?us-ascii?Q?34RcaprT5PhaqS9nJDU2BktnccrX0hvmp1g2bcBn4E0x0giqBvJrtyeFtOf/?=
 =?us-ascii?Q?bv4xsdQk2gU6DaW9JvwEyQuXr0rDaLcPI3ITB8HWeuUuqD+RFiQkHij1dzB0?=
 =?us-ascii?Q?V9xISo4KxsvIq/WAhwUF2hIgsSDu6RUTGd9RUmlUd36MkPbiD32O2fYYQsXb?=
 =?us-ascii?Q?9NZegu/mrBPlI9TzUKRikru21E8l0O2DNYemcyFYp8cUnniBEycGR+kTzZ1C?=
 =?us-ascii?Q?pCACEHJGD9B7yn+Cu90P0qJrHokiyewCfeZfm0eQX9SVI7us35jGi00n7QSn?=
 =?us-ascii?Q?L1Zs9nRrfxtHpTb2hokUFbbCB7yk9dOxuXcSvdrEeANlr/OnyTfRMTURIdTu?=
 =?us-ascii?Q?Lbbleu93iJ8ta8WGB9yDwnKvffiREktGGtS9MLW4zfHLaDVxUabp24t4bUjQ?=
 =?us-ascii?Q?okSHjMKo4QkQ5zzeSBhiXclZB86xUMTpOeYu1AIa10i+Eq+Ms3vNZhDE43tA?=
 =?us-ascii?Q?rtHGxKkJC18oHxhLhMx0CmCBotVb43cChfjZruHkzu8MXLIejOI129zMuRYO?=
 =?us-ascii?Q?kIc42G5tOmVcw9URtGDqA0FUrJBQR8ChkGaOQmFpoUP0mSD7fcayTM7sdKH8?=
 =?us-ascii?Q?yAJ5w316c6twHjcKop4U73Tr4+jtIL5uUBCgFZg29SNsaq8fdwqSDpATDrJp?=
 =?us-ascii?Q?d79NhKUa3DwVmE3jBUINY9JHTpXjfueUWtzMApfPjEzDjZg+g+RfGecZK7ws?=
 =?us-ascii?Q?6Xkb5sQIuAOjkFbhSpDhqFEiw+GEM5w2taOPCtgEGpcwuuBPaafn9/oWE3HG?=
 =?us-ascii?Q?bVQNl5eXn00=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B0y/Qr4tuxuAW8yR7qp9Qrsyj1ax/Jx/T3cb+vnOy2uFVJIYwnJZSH6L1xDp?=
 =?us-ascii?Q?yv3vdMvKuXCg4h+EkutHs+7oel70phTqGfrA1hGn1g1R/IUHUz4wTmIV4CRE?=
 =?us-ascii?Q?K52nQ5MHq7n+if0z3l6OnQoqLu17rly4f5KXufpypYKAPMBsDdKwrXpS5j3F?=
 =?us-ascii?Q?J43xEy7/BOM25Fm1Sl1eko9fKFORC+kDHtkca9MWnEUIR+g26IHZ+N/rqs24?=
 =?us-ascii?Q?BHUxINgBeCUOnYtduGNXVFXKoXrxVdBwyZUafaW2NzhdvgQMjUM+vxyE3uVP?=
 =?us-ascii?Q?u5eJLcqbiJP8Wi5zYwNfg0cG4JjClp96OlwRGSzMiJD4iXXXegv0Kcq6bxDo?=
 =?us-ascii?Q?y5RXGKsUiABYwkEGCta2XdhXEKIEqTBkvaLJUVmWXD1cmHoSlaSeqvGBY+ue?=
 =?us-ascii?Q?Vy+J8ct+SBfEJql9jiQaYV7Z7NDgYDhNdMRskvIkhooKBMz2KDdjRHW4tEWz?=
 =?us-ascii?Q?Q61F0wyWY6ADcsaJ0cVLE3ycaJbzla9lZ/MN/azZ91H8h9zPP2toPVrMvGaa?=
 =?us-ascii?Q?gTybGbYwavPIq5D6KYFTrKpP3JKrH0jSbkXfy7TgR8+dpAIxN03Bl1H7gV7N?=
 =?us-ascii?Q?3gwNzish1oXkW6NGjWIYAZ9oHk8zKXeNKCZp0wv8lC1JOpHbwpmirwhI1m/x?=
 =?us-ascii?Q?Qi9gSIRLTNZoiKX414erow5Gc1nHqAIX4NpiInhtTmuEqo3PfW7LlBi+grP7?=
 =?us-ascii?Q?l3KgwYwiVCBqR5Iozk1PgjkSES+x9K3X6gQFkjakHoKChzsavZkrUUim6wSl?=
 =?us-ascii?Q?1h2j6H9jzjim5xA7eNFcZWgk4z4vou58qem02is7vwaNwwf/xqzUmTxGnZvY?=
 =?us-ascii?Q?+plU8R//bxxH7jtONwQSfm3vPSAtoWhKpjLibq/77iEp7dR10lrYdxpNiEaf?=
 =?us-ascii?Q?OG7CAiw4CjJdnhdqR7nne7lO3kyioJAO8D/gj+97wkusMOkF4gSYuC9Y+9YQ?=
 =?us-ascii?Q?GMqUD9lV9zK/HQTMJr/0GVdsS6Mer8JitA60bTG5YlKBp4/a5iRk0b402gjm?=
 =?us-ascii?Q?LAkKLbzi28Aifnxh1Z+LrECzKbnyQm3B+FSVOs7OL2yk0Wz/MO7PR7AsH0DV?=
 =?us-ascii?Q?LBYLysjsYGGx9sdWkfqacRmpO3U6drKllqopksN12o/JJh7mSzz+fBjFKnu1?=
 =?us-ascii?Q?uwKMOkt3XN+sba4f8U0+rrj8m0OCPccuTY7ZRwp/qYpI1Ma195nvG2qP5fCS?=
 =?us-ascii?Q?chKUxwnzGR5l/1v3jO0KKdl09BAzgVKpTMQBY+XgIWhWHU6QhUH89v2YESyx?=
 =?us-ascii?Q?o5VQleXLg03GTRw4xQobdvWI+/ocs4i6Ar3N8dhOAQkGbT34RWvtFCJBewVg?=
 =?us-ascii?Q?hJwIeN4OdgLH9pfzKeXZpZAwH9IlI/c4SSX5XdBG8B7mQupTtOXdyBjP4bdu?=
 =?us-ascii?Q?PHXHjzxXVlR0a9xBczToiBxVE1vtbfS3OeenOEG9SZF7v0RX4YlQlt4swunQ?=
 =?us-ascii?Q?1i9DK5bgK99cQ2suqrg8/6hNUZy+PTl33zhJoJWUrsraijE9ZMFgqRFF4Lus?=
 =?us-ascii?Q?TFKESFAVf78R/v4aGMJCYC243VhSMSuLTSJUK1QqUt28Agg5BRPo++Rd1NNS?=
 =?us-ascii?Q?pERU+yB3Hjv5yMF+Ov/yl+d9NB2BaLPY56WXVDY/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7990eba-442e-43e6-bc82-08dd34b97def
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:35:44.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5B9Wh+k+LxNVBjZX5bFANFdmD1hYruHOEgJeHAqlhjbBdy2eEwnXQzKnN5Z4NcRhTjTzrdQbyIpMRJSNrXsbfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8429
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER service driver supports handling Downstream Port Protocol Errors in
> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
> mode.[1]
> 
> CXL and PCIe Protocol Error handling have different requirements that
> necessitate a separate handling path. The AER service driver may try to
> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
> suitable for CXL PCIe Port devices because of potential for system memory
> corruption. Instead, CXL Protocol Error handling must use a kernel panic
> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
> Error handling does not panic the kernel in response to a UCE.
> 
> Introduce a separate path for CXL Protocol Error handling in the AER
> service driver. This will allow CXL Protocol Errors to use CXL specific
> handling instead of PCIe handling. Add the CXL specific changes without
> affecting or adding functionality in the PCIe handling.
> 
> Make this update alongside the existing Downstream Port RCH error handling
> logic, extending support to CXL PCIe Ports in VH mode.
> 
> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
> config. Update is_internal_error()'s function declaration such that it is
> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
> or disabled.
> 
> The uncorrectable error (UCE) handling will be added in a future patch.
> 
> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
> Upstream Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

