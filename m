Return-Path: <linux-pci+bounces-10018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF692C31E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 20:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4943B1F23540
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 18:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C44F17B044;
	Tue,  9 Jul 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bvo1e0lO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AD17B03F;
	Tue,  9 Jul 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548669; cv=fail; b=QOoWHLdbE3MTcPNLGl6ef5sh3iea4PVvF5DB/l74T+J30UOULas2bbirIuByWEdv+zelJND7OL2QqUsm7Her3GAuZDc0iCdT/D6m+KdiD0H35kWmIxyVxArebctnldgD+p1RvDsL2vD1cPi5FbGVe45l3jgD+1EORQOSEnpEYP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548669; c=relaxed/simple;
	bh=2GPf1a/x6YvmPR0mIJcWeG2fUXBfTkPBwQSeJrnPG38=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E2NDQlAZIHmlBsq8EBndPHl+u+vgqy7EHlJTLyCFPBG1Vqkq1wkmO0Wnq5ZdS63K7Iml30l0pKrbG0QoM55s/JxaqRdpAgx7pNovr71tnOQv1it2fROHfygn+XdAALlduFGHZmBF0dDdDeGSpAdl9f5vLeoR8obOgfh9jeA4mf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bvo1e0lO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720548667; x=1752084667;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2GPf1a/x6YvmPR0mIJcWeG2fUXBfTkPBwQSeJrnPG38=;
  b=Bvo1e0lOW1OxBxv9fcflB9gKjukeO5fCEDaT2MtTxygDTxZEwS28hO9N
   MN51W8BaD94lXVD/04cKDGGC2fp5jzf8HLry5Uo/6w1vPgIpodxYqAni+
   7QXPKdt8JVWvDvOnOcXu8lMA/qPONRoFFUq12SQomViDHNoZWAYTnCrTH
   wKRNNm9LClMLEcRIlCKqj0OoNAGg8KxfP9KEggYApD9Wj7lTN8lbmpmjE
   ACaa09t/0Fqh4suT9El37Uaz/r5S+AEXCFOc8mFdh4r5evSsbTOJVh5gZ
   3xQPg2rx6H8tZoWeNBKpMjS5GDrDf33Qd5+e4Fd5BOAkpZpGnceXPVU/v
   g==;
X-CSE-ConnectionGUID: a/fkB1K0TYisOh8EVxnJvA==
X-CSE-MsgGUID: gi5zCQhoSu+oIB32gAFRBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="29226592"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="29226592"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 11:11:06 -0700
X-CSE-ConnectionGUID: cwoxsYOiRwOTy6U35VBzGw==
X-CSE-MsgGUID: UkA4maELTMm3zzJlCbXZGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="47923296"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 11:11:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 11:11:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 11:11:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 11:11:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 11:11:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gv3LyoligWbiCww6GffnUxqmLZzVfPRbsaBXOnnuIalxrrd2N5Os2yX5sTjAMtCgoAe/qJ7/L52Fz0d9c5GzCSDFN4JatOjcshXbaVWXFVQs3Nw6qSEEToTl7S9tZxAUTyBF8mncQUqiKaec9tFOwA7dGxRhuAATZZGysNL4LDgk8vCMw+1lgAd7vo75qKCfB7AYZIXJBpkadvkIIjqDazHdKj1dptmGt23R43y5lJSUzypPo1vp2W/gOPViIbCIa/HhEYKLEW+rOEwRkD98gMM/JccC09M0+d4KSUzARj9nv/QKtUjCBMnUwA1+PoSWte6SbHigYTNwLBpsyRHcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbpNesa2f3pzgNgzam4ZsFC+6aPophRPQbauZocJH+0=;
 b=TTMp8I/Jduljw8g40H8ZqjOsvSgbP3RS5RHGy4bXX39T+oG87TtLuK7RQNHiaEwQON8BD8aNkkf4fcBBOE7nQ7RcQ67opzOv420tOspOP073YQSAH9bs0zbIF2mr9ulp2mauDib8ILfsPXDWhDHk7gQNoySDhAR0wmvTHlwpDKbHKERLH2vqC5agbA9rBCLb0p0fRsYrvdxfu7VqwgTLdS2QBKOxNSqSI3Pb+yUzZ+3FYsRAaEDGtiZ0pLc2eKdf57jighR5hwlwgukfxgeDd6xa0Rh9CSAQWAXS4th7OU/hi4COmPsRyFEenEoYNPyEOmKKNZGHaI/oHnhuzBv3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4726.namprd11.prod.outlook.com (2603:10b6:208:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 18:11:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 18:11:01 +0000
Date: Tue, 9 Jul 2024 11:10:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, "David
 Howells" <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
CC: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal
	<dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani
	<dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, "Jerome
 Glisse" <jglisse@google.com>, Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <668d7d318082b_102cc2942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1719771133.git.lukas@wunner.de>
 <6d4361f13a942efc4b4d33d22e56b564c4362328.1719771133.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d4361f13a942efc4b4d33d22e56b564c4362328.1719771133.git.lukas@wunner.de>
X-ClientProxiedBy: MW4PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:303:b4::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4726:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f21f964-51e0-4a6d-c92a-08dca0427d68
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VcEPj+5t+9LMS+L44Z4P4oSes16bzZvlGzcp1TeWE0mbIlhCX7XMrW0DwrcP?=
 =?us-ascii?Q?JpNnEkzTUfwJ1xXQkzKYFpb/2QYqct6UzpEuqVU5INvwR66GKb2cm3Oj/saD?=
 =?us-ascii?Q?5vZxxS0/OkLy20xiLc72UR49XQdg6iTSdL0eY1HyuBmJmng5umJYnmbnL5HW?=
 =?us-ascii?Q?Wsv0pIcKzSWi1KnFwRMx/T8mindhuihPtowDEn8Sy1UEStZSWNUi6imR0YWB?=
 =?us-ascii?Q?o4gMaypIVCFsPXVHV0cE58UAa0WNzttw8s8nhEoEo0KbKqyhD+MiFMM3VKHn?=
 =?us-ascii?Q?l1stGhkvpJZpa4+D4P4ZwsJUrZqCQyQrjzvBIo4n3zuh6XyFBkXmijCtMNDC?=
 =?us-ascii?Q?IQtOSkJ/WnN9W7VxNAsw9uSdJA33D0qlEMz6VVsElnQwFSMt/2lWMj4+d7/U?=
 =?us-ascii?Q?76dTKBXI648iTNO5Smcl0YNfx/m7ogbf2ObbsUjSMexCAi8M7tUQNy8KGxhN?=
 =?us-ascii?Q?ixz9zH0A23TwjZCD7Ti0OLDvRcWxb1lRGJXTlBCWIL7yDbz8s1TfVBZEj5X+?=
 =?us-ascii?Q?+DABjah43DoYtK93Rw78A7jXUr9m2psZfVVsZETH5ec9zBdeHlWnydCTthQs?=
 =?us-ascii?Q?WD7tMNbxawgBBugMy2fqVMGfmwrhgTqmLnl1YlYCFA1rjwF+aSDHp7XHtvFI?=
 =?us-ascii?Q?NijePiOBh0fic8c650ejApDBMS/sEzew+JZp6XvktbEYayPuB6zIYbS8yN+A?=
 =?us-ascii?Q?fCwfzFAbCtb/uTQ/kdxgV2PoQnBUYPmzCpNyNZ59MikTtWy47sHoSaSZPlNW?=
 =?us-ascii?Q?eIr6VS2CvGbNKHOVlozfFgvulk/pxqPQFAKsfvMO1i9tyRcxappR1h87TwHx?=
 =?us-ascii?Q?ikttECgNjZzzdd6zT1gGlGwJxwMbfkRpwwq2J2VyOlKKGh0CaIqOQ3D0OxrA?=
 =?us-ascii?Q?lxdyO2W14TVj1eQsufnJHwB+VCCI1UaCZp6OkofKXO0OSIYjPH7ru5W7zbeh?=
 =?us-ascii?Q?Rnx7GO/9WBu04F/MB7yWQ56GMd/ewEy7m0inMMFcezkaS4VZSTdT/w30IfPl?=
 =?us-ascii?Q?xoERy2luHDSjvanxLokkN+tnu8fryPpiM2VO/Q/xQ6BztykKpiBYJOyoiyGm?=
 =?us-ascii?Q?zL2/YwxHflsxbn6G7K6IEYjyYqn4IJvNBdQbkqjrAhFIfnmEekkPpp9o7leG?=
 =?us-ascii?Q?6sMdWkybfS2eqVGUTpKOChhoVw7DJ6cydHzaTpT/qk5/Jfb/cCI2R2bE6AKr?=
 =?us-ascii?Q?f2n2zfc0g7mw+IUljwzjwwlr9YWOooHoROdTS08ODYzT+92v8NgYufKDiGU0?=
 =?us-ascii?Q?MpKdwSu7/6u4mIUCPDbslQBO4K2P6a24JQytXGVwDQiDv31kqxdBR/vRXjuu?=
 =?us-ascii?Q?Bx+ATxMsdkjxUNXd850IsiFqodeOJMttzAkA9SMR0dhqaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92U682LqZr0QenNesmWGt6RU/tS3dksb53PFURYq4TlHO7sZNVUXJ5WwliSV?=
 =?us-ascii?Q?b5KjGVvky1BUpP93GgJWS1DS0cmde2xH+vZz+fjcq8uOeK7zFxJNAec0xrSN?=
 =?us-ascii?Q?R2nj6fEDa/7HU4M4rmVuKk0DrPkaXhObOyhBSpZnlHhZaZvaQWXwv05vAswM?=
 =?us-ascii?Q?u5IDxzpmPN69UEn13SP4a66TsmttGJ4+KcSSqHsGHDMK4l2Hg0bIz4BubVu1?=
 =?us-ascii?Q?l/xB1tVzPaTPwsHFBsA9s865RVBHt5TmNJ7PfK2AtR3y/78SCaMlw3HAOvjy?=
 =?us-ascii?Q?uD6KoQAhTZaA2FEjjIaN0lOvmDtGhqOCKDOXH7dxxz130l7ngnBfbN7AN4K6?=
 =?us-ascii?Q?w4dA0sy8umIdW2GFYoFRLe/G0l2Q03m929gq1aSYTtSUx+u3W3FZsCEqsNPO?=
 =?us-ascii?Q?ljROoLhbyV/Gk3/NsVesUflJBQA63xrrJVGdMKyqCmP84s/Jp4Uy0opnZRMJ?=
 =?us-ascii?Q?+mciIU8f1Agyin3s8ARilCiAXUszvj/4fDU+ZRQaq8wqTiTfluVsirgdT4ZI?=
 =?us-ascii?Q?ypDbNMYcTFhqlmNfrejEXmQvlRI8vYMfxHul95oZKAiTIIqB7XU4MaNZUCzz?=
 =?us-ascii?Q?ZjaYvhU3HOqE1LjzjJbVj90QvPJdziP0hagHmydwTqCdtXnTht9fTLKlv6sK?=
 =?us-ascii?Q?zO8/F9h+mHOJuRzfozSbp1p9bGU6AcYkRPzlZacL9J4Tq96cqZ9iJMALvpTT?=
 =?us-ascii?Q?o56hzlR6DtmFVYsYC5s8Iuge8Q/FvAv9mXSmWzhZcC1UqvSAI6XLBYd+atc1?=
 =?us-ascii?Q?qjW9CGtTz+P+7ZWEuVIiVgmkR0GrArn8WAlalRZl0lpu+pW03roGjxgfKZYT?=
 =?us-ascii?Q?zk9THT/zKt4ciEE9i2mED9oFm8myHIK/rdoBI4m0DkEzWla1QUKa6c/FJtbu?=
 =?us-ascii?Q?W8njHHDC9/EfUCFM2f/ku216RxAdWH3ebjRVGoTgOhvaPhYy0A5XzSrFeeCf?=
 =?us-ascii?Q?K/5PetoSmWCDC2XCMHN2fBaVLOMqcpfpBunGAB4e7m4mYtBsCuPaOO3lUA75?=
 =?us-ascii?Q?fU7aI3ozzyivUb8TytURsEdZdAxQqei+HIYh7dSHK/PYWyuQEuiKONxAaru4?=
 =?us-ascii?Q?WGPCbKLO7vEYq/v9zCNAyCbEQt5YIWaGf/WCCg9KCiZ5z8PCQP1rBKa9d9EE?=
 =?us-ascii?Q?ocyXyz6c0OYroloyOVXSgSdkT5l2WR2Q1eTgVXLIH7wE0AXCCVQHBZdJeICQ?=
 =?us-ascii?Q?/xPlW82FhzzC5oUjsivgBv4Ub3hznpCCat1KrLU4od2wowH4VRTm8RUfBeBq?=
 =?us-ascii?Q?zJMDw7YXCz1K7uF9YJPYUkLftHECcipjpQkhtkRPLG4+/GngvR37nHX5h3x4?=
 =?us-ascii?Q?RGO6ezchlG9V/vtUvzQL9DKHMDAUErafRYBA5LuMFHVdyipRZ8uvpgz75o/2?=
 =?us-ascii?Q?9Ln1ssW2YvfVoAd077scJX+wZnkT3r4gzs6hllUU7/C2k9TjiHA96Oq8i2c5?=
 =?us-ascii?Q?+rAGzpiEwoE0eSVg88Og4Pkys6CwYUQI9D3y8QjRf1b0H0RWAPsJiXaOucpU?=
 =?us-ascii?Q?t0w8B/iidN5XpW1d8xdZhDA4nRLuV5JtYgSrq+W2ZqRzKs6SguePjXMci6vb?=
 =?us-ascii?Q?Q5G29mKfGFQ8KQZLOryG+uqHv85/jljP6ELBCYg4omcjDipSpV64r5fs62r8?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f21f964-51e0-4a6d-c92a-08dca0427d68
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 18:11:01.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zszulSnCCzmLUbZSbTaUet7NrvAHtTEeJmAQw8XxRhP0BNI5N5pEzkKSp+M7kQItw+OxXNEmFeqk4brHrJZVgpKsF514HTRItzwDSqVicic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4726
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Component Measurement and Authentication (CMA, PCIe r6.2 sec 6.31)
> allows for measurement and authentication of PCIe devices.  It is
> based on the Security Protocol and Data Model specification (SPDM,
> https://www.dmtf.org/dsp/DSP0274).
> 
> CMA-SPDM in turn forms the basis for Integrity and Data Encryption
> (IDE, PCIe r6.2 sec 6.33) because the key material used by IDE is
> transmitted over a CMA-SPDM session.
> 
> As a first step, authenticate CMA-capable devices on enumeration.
> A subsequent commit will expose the result in sysfs.
> 
> When allocating SPDM session state with spdm_create(), the maximum SPDM
> message length needs to be passed.  Make the PCI_DOE_MAX_LENGTH macro
> public and calculate the maximum payload length from it.
> 
> Credits:  Jonathan wrote a proof-of-concept of this CMA implementation.
> Lukas reworked it for upstream.  Wilfred contributed fixes for issues
> discovered during testing.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Co-developed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  MAINTAINERS             |   1 +
>  drivers/pci/Kconfig     |  13 ++++++
>  drivers/pci/Makefile    |   2 +
>  drivers/pci/cma.c       | 100 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/doe.c       |   3 --
>  drivers/pci/pci.h       |   8 ++++
>  drivers/pci/probe.c     |   1 +
>  drivers/pci/remove.c    |   1 +
>  include/linux/pci-doe.h |   4 ++
>  include/linux/pci.h     |   4 ++
>  10 files changed, 134 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/cma.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dbe16eea8818..9aad3350da16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20153,6 +20153,7 @@ L:	linux-cxl@vger.kernel.org
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
> +F:	drivers/pci/cma*
>  F:	include/linux/spdm.h
>  F:	lib/spdm/
>  
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index d35001589d88..f656211d707a 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -121,6 +121,19 @@ config XEN_PCIDEV_FRONTEND
>  config PCI_ATS
>  	bool
>  
> +config PCI_CMA
> +	bool "Component Measurement and Authentication (CMA-SPDM)"

What is driving the requirement for CMA to be built-in?

All of the use cases I know about to date are built around userspace
policy auditing devices after the fact. Certainly a deployment could
choose to build it in, but it is a significant amount of infrastructure
that could tolerate late loading.

PCI TSM will be late loaded, so it is already the case that depending on
the authentication mechanism chosen (native, or TSM) the system needs to
be prepared for late / dynamic authentication.

