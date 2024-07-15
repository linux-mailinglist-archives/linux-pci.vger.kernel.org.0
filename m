Return-Path: <linux-pci+bounces-10335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6536D931DAB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 01:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874231C219D5
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52F140E3C;
	Mon, 15 Jul 2024 23:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6a/ejFg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1D14036F;
	Mon, 15 Jul 2024 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086639; cv=fail; b=JIDsogXraSPat3jcXIN3DqqVC5d2DedDx+X4vbqpEPXUFbO6bzgK+ET/y+/AuerRtLInYIZtSsJik3MPte2q0UdYGXZywEiMhEYVrDXyYbbmQkFX6lWaRcdquqLOnes7leC8/VdFoZOswuYcYF1jCyeq8esGGhnJrs1E57iHhdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086639; c=relaxed/simple;
	bh=cXPwJrxV0M9+PIAFHvVjUaeXlQKoTAT5dysdfdyBgXE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ciQpO0UPUYv+ylHTj7onepDoIf35GlzPE5YbNOeDGhoHhy/qy1Lb7scG15yKozyGdEMo/3sToeh1fyDFikc1/zWcArlenZHraBIZ9fSQjuhAY0z1U/3mQFqtITcrY0EPQIQT8opYLqtAnP4ZC6zCvbQ00cXmAxPJUL7Ehlc0GwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6a/ejFg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721086638; x=1752622638;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cXPwJrxV0M9+PIAFHvVjUaeXlQKoTAT5dysdfdyBgXE=;
  b=j6a/ejFgSBpzZ2yB/GdbKmQNs8aZnClDLG9dF6cShj9K+xca1bP0vGqA
   hchuMh2fHVivAIn8BwvgkhOBce0LqQfJOpQ7PQDnVz/WRyXnpjdCBJU5l
   0TbONwa0VWC3lAfgraDcqydPT0W1vv2wp9FEioKan2ABUKExeRIly4ds9
   LcLRnt55BVKDp+ZYOvEB3ExdE72BBt+INfSuHlp6QcLQOrP1jBDWB/fFr
   3rE03QDDVk4HAsQFdFlp4Kn3Z5rQNDbJ/bqoYnsTJFAEPz2/4Uy+Ve4ew
   PBkZxE3k350y4/cd6Eyh0EnHLsUuQsjrWVbnLa2jnNwBD0wUgmyHq8+An
   g==;
X-CSE-ConnectionGUID: CkQ6ZcC+RcyrTaVatCNMMA==
X-CSE-MsgGUID: kXrTXYk3Teydy0BFkmVXeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18610153"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18610153"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 16:37:16 -0700
X-CSE-ConnectionGUID: 49BeTD9jSzKRD/vC9ehISQ==
X-CSE-MsgGUID: D3fgZ1agQeeGJh2KKJwXfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49541178"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 16:37:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:37:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:37:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 16:37:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 16:37:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvGJe+3XAKTqnKHSAmuY4TbBC183vhUB4Orznr8yZY8m70QN0K9+timfBQaOZWesxI9EOI4f8mywDZ0PC25P1Xn43qaAEsVEEcIx+tqx01C3n+1BpIxd6Ohbtrj9xuwYKRkrSTTamakjKLGVN2dRQk2oOp1DjvJ1agJ8nW/B0EdLRLIRJiPNOItsTJY/y9MCvPTH/MD/yBI8WKy2IZopf/CQcWwXz6z5vdWlsJ7jCUWAVYsU+Ht2impMHzPTojtqvgwwRkaO5jdUve8C//VimM+y/5HXl1EI+VkdfMGRkrTFmFlN/2jk1fzhsbT+hWVRQDjqGYfhNCgXKnjJMlpxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIANK4Alhlx4dH+aYu6Ww6gsP2e3asKnZxmn05Xv0qo=;
 b=pQeACzarcT338SCc/dGaQVnIkJROZorkl1853v0ayPPeuOJsKRzjBUUpI50Ly/vZEom4DCkaGsbI3FtZnelGsmmLoaH7j5IPyRBBSxq7z4EEThGU7WDw8KHkbhbz31f1re3fFFmxCAerkvKvgZcl5aUiP9uA2dUhGlhYPkmHx15O9C7gDP3vrisKJ8kyovAmZnB0HGVYby4e56XY4OvDokz49K6ITx2SYfLODoGN/bcUKQlDFOKC+BAfERwsme7Qcp7SXe6+qepz+Qdggw7JLRHVly1HYE8n4pMPnX1ild88ukCJMYF2IQXaYy4v1dUDSx1ji0DoLPUElLfediss5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7666.namprd11.prod.outlook.com (2603:10b6:806:34b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 23:37:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:37:05 +0000
Date: Mon, 15 Jul 2024 16:37:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Kees Cook <kees@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David
 Woodhouse <dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@huawei.com>, David Box <david.e.box@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair
 Francis <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Peter Gonda
	<pgonda@google.com>, Jerome Glisse <jglisse@google.com>, "Sean
 Christopherson" <seanjc@google.com>, Alexander Graf <graf@amazon.com>,
	"Samuel Ortiz" <sameo@rivosinc.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <6695b29d204e4_8f74d294f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <6695a7b4a1c14_1bc83294c1@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715232149.GY1482543@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240715232149.GY1482543@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 646159b3-3158-4ceb-0dc6-08dca5270916
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?re0V/Vk+GO8rswOdstPCbkg3yDbRr85vRZzwRgSSyZp8cBU8cCquexw8UI5j?=
 =?us-ascii?Q?Fz5oGrkPBaWQuwz6kuWUXtVsRtbXbEz+giwAFF8gpItDEZiKK5FD7TZRrTW7?=
 =?us-ascii?Q?UCodFsK6KfDC/vDPCFVIDELdDGEJoW/WNJ57Xpgu+Hf1z6/9jgfU2OkcMG6C?=
 =?us-ascii?Q?4H5oNrDWbbcV1p548UqGj/VnCbL0Mpg3pg81U/8vBOvL2G9ZY5irleZHWHoE?=
 =?us-ascii?Q?P8/WIRUfNaNciSLpDew5FMQ66YHB/SVPEyVEw7K9Vkd5TSmtTzyQZ7eNtbkX?=
 =?us-ascii?Q?ukd7GCnynmTUPuNyWJmWiXK0OtSsnAhZF7AUK/xI0lnxdkjCsMNXX/gOZJ6I?=
 =?us-ascii?Q?mHAlnroRel1ODpXaAEJDU3O0869cORyORuyScmc7si3x+tEQhiMDDpfbjOrA?=
 =?us-ascii?Q?auG0hvm/beTPiMz4rbHVb+Q6/MYWV8OHMNUji8sCztf/Aalz0T+MA6C5XxWG?=
 =?us-ascii?Q?8AvW+41+5G5wQhWBghy9MzpptBSB2PPjIcyiHdHM9LLgP8WMwsAW7ZErDTRH?=
 =?us-ascii?Q?rYYY2b+WieIl+mAPrPIwqFVezo5yI5H88MWlHQXKmvfgWoUwX68GEYpIVfu9?=
 =?us-ascii?Q?TzTavpX91DQGLUrcm8vbRFvR25WjB4OC3sDeUNlf4gdFMEexr2c64H4o2O7D?=
 =?us-ascii?Q?6+X9hWPPfr0IHnsod88DihPqq+Gy+bnim6DEVN4LOsAfhFDtcMbg4d8Hmv60?=
 =?us-ascii?Q?vc3bW/emN1hwtnTtHZYODmGaVRZAJ/oAK2ACPgbDVzrKSbPcwupDginHCGN0?=
 =?us-ascii?Q?0D52J/R9W9LzyppOyN7zyzTqkPw3jLgPaC8WHYpTJRvaqZHZwnSgOaNLOhX8?=
 =?us-ascii?Q?JZViDU4fgLMNNkySKwpjxHGQtMM9GWfID3zsS14pGkwqe7tlbrGxAW/wFyZq?=
 =?us-ascii?Q?cMDmNsoWbDpfZnh7NAZwsqZDhX7iT5DLaJgqqv8OPyVjZ8pJmqRS2zKgYu7s?=
 =?us-ascii?Q?Kjq+QnD0Cc4UrNJ2tv2OnpX3tj7aUnqwf8id/aqRBnjy29KKSp2VCS61HIsz?=
 =?us-ascii?Q?xSWYBt1kYrajJf5zLFhEJxTSMUtc881QFchnm0/WzL9yh9i4XC9kB0r1A6l5?=
 =?us-ascii?Q?lPAXgjmsPoNaKVXApRMu92AwWlzuYim7T65rnIkBmoV9k9jLBbLCLAFMec7j?=
 =?us-ascii?Q?IaUU9vCPAyITKB4ezpHDztCi4IgqGxZsbkSCsVhE10WvqKsUdYael6AWB5nz?=
 =?us-ascii?Q?opaYj3YuX0MpcXpBO8iq+bAVIwP3k8DHbzWuwf1AXAm3tUIS4jz7f+WJdNPn?=
 =?us-ascii?Q?PEjdhk5wxJY+VfF/k7Uv0LNrkG62sirdmbiEDL9WbNR1oFkLVGReE809maUN?=
 =?us-ascii?Q?kyZB6LiYPVn2glOgzCJ+sFGu3gZzDawvjD5ePLigo/HPuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?22EN5A2czMvwBHMJiDms+1hW688dR6YI5fUgissVe+l+44JVB+6l3HdeyrQo?=
 =?us-ascii?Q?XWll/IshZPWm1/JiPCtI9c34ogwcrjz2Pj+w3TIS9BDsDNrJhNtFpVGlgVD2?=
 =?us-ascii?Q?iwHXTETl4jlLsNdjGMz7l+V9vJo/OSRFC787E4jjz9e7WJ/Er4iXuGfUzh/V?=
 =?us-ascii?Q?RNbhm2FyYYr1hO2dajkO+nxcJlYKsn3iK+hmQzXhalLjFelJ3evJM+oegKZ3?=
 =?us-ascii?Q?CqqBqChPq4hVX7d15YSDPnt9JHH+2Vg6OnufEzXgQKKbIYC9SO8xk00cjjLi?=
 =?us-ascii?Q?RyzgtDpdvwWQDUuZu88IDZ0xcONsRyuuxkP3zBgYq9ODy0EN13nBuRSOa5HE?=
 =?us-ascii?Q?ztLjdixAMHWQYf2gkb3/cUjjnhXa+hw16VCQdVqb5CE7fmiNkmFXlxqrVAa6?=
 =?us-ascii?Q?Ftqy3uEfaYZ/A3J/9HjRZRcxIRaFf20gizEKSoyXHjwDgXbisAN1qT5BkTMI?=
 =?us-ascii?Q?KiiSb49LK5bohVhHCH492eYGMpbpt2wVb7/F7anjRnQuiWmcMQW+L7rF0s/1?=
 =?us-ascii?Q?wzIdd9z7mjFK5fuW98KB6cJtJbRoIHYGRq0nfA0PXuGT+Wg/Ou7TmEJm7uyg?=
 =?us-ascii?Q?oAkc/Or3wft6KQW+e7ZByQBXwW1qwez0x8nh3yEMaguZXjERfvZX2qPj/705?=
 =?us-ascii?Q?a2OWGiwq9YzU374cwQs/eM2vvgWKHvyToX8CHpL3a8Eswe7G6OK23dGulcJ5?=
 =?us-ascii?Q?5hudW8ilSXxaacI3A0t1KliTLcDKcG5wdoQ5kjbuiuPWspF5/sfAj/8Co+F9?=
 =?us-ascii?Q?KRuojeUMfeNe1AY8M7X6TBGXWCawNDCqV7t4XAHpsXoxHPCA/EZ99dmpr1CO?=
 =?us-ascii?Q?qhk2rydebr2fwgdy6DoTRF731Hb8SUHHKMs8HQGzaJ21OAjn52Du+ud3CnL4?=
 =?us-ascii?Q?hq6UVv0npGl7M7LMqxe+kFDxrarR12k2sIwD79qy/CLI/dXRNZQWiq2/7ZbT?=
 =?us-ascii?Q?ty9iJ1ZZcuQMz2XS5Z6FFSMDYecyV49jw4LqNzOHhSwwSoUqVsrJ28o4umkc?=
 =?us-ascii?Q?tmDaFpJiK0FzLZ7wewZV4E/PzzDIOOMKs7J0QcH8JW8ss+UDSgXiiu/1OD84?=
 =?us-ascii?Q?Q2r8/1couWhrRbtxk5rHi90qECfx+YqGwHJCv7pPPjajk1NBRUHPknQ+JkrT?=
 =?us-ascii?Q?i402vOi/a93iAAwU/DWAkVc5Q9QMvWtdxLSY3vwQnwu4B93g6VgXd/9JhHDb?=
 =?us-ascii?Q?xHZ+4JP/7EJYejHRZuCE5O+dIRV79Fy5ClwZq6vFSDZH3EzyNYAG2Xk+kil0?=
 =?us-ascii?Q?Zqh4m/dW6Q/u8Qby84FSZyM9vAs5grg2EfPW+uSRo6rCOrFlv5cWV/I/DF5F?=
 =?us-ascii?Q?7vU2vMCcJmrLXOODk9ShfQtWEULEIxqnfFmws7OdLJmQ98ONAwJhCR0uEw9y?=
 =?us-ascii?Q?EnMBn/FLUUBY8t6asY6UN8WC9tme5KOqfxZ0VJ568HP29HL9dnWhPIygKtP7?=
 =?us-ascii?Q?NbA3vcOUaaIHMqpIIg4i6iuzRlY6MiiR9ifjeZjV+oEE587/K1b2hvd2pcJ+?=
 =?us-ascii?Q?KELAt69YSmgNmOr8MkA4ljfXJEr0Z+po22T/xkB/opnePFNJK0NE0pRs2EWj?=
 =?us-ascii?Q?DeXKeLY2LLr/N59QGPz3GPdjeF9jFAV2kv+qxs7npVejmmtBLQVRv6zyNrlj?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 646159b3-3158-4ceb-0dc6-08dca5270916
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:37:05.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1VM4oXVAyGQfbFqklRon9dI3xoaYwLKGkxyyHlVxLN5gG2mU+bSX0p86edLNdZT1ItESRj8qvXrl6njUuLvPOeBYY72swidkVtg2VaOggw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7666
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Mon, Jul 15, 2024 at 03:50:28PM -0700, Dan Williams wrote:
> > > > The motivation for the security policy is "there is trusted memory to
> > > > protect". Absent trusted memory, the status quo for the device-driver
> > > > model applies.
> > > 
> > > From what I can see on some platforms/configurations if the device is
> > > trusted capable then it MUST only issue trusted DMA as that is the
> > > only IO translation that will work.
> > 
> > Given that PCI defines that devices can fall out of "trusted capable"
> > mode that implies there needs to be an error recovery path.
> 
> Sure, but this not the issue, if you stop being trusted you have to
> immediately stop doing all DMA and the VM has to restore things back
> to trusted before starting the DMAs again. Basically I'd expect you
> have to FLR the device and start from scratch as an error recovery.
> 
> > For at least the platforms I am looking at (SEV, TDX, COVE) a
> > "convert device to private operation" step is a possibility after
> > the TVM is already running. 
> 
> That's fine, too
> 
> The issue is the DMA. When you have a trusted vIOMMU present in the VM
> things get complex.
> 
> At least one platform splits the IOMMU in half and PCIE TLP bit T=0
> and T=1 target totally different translation.

I am not aware of an IOMMU implementation that does anything different
than that.

> So from a Linux VM perspective we have a PCI device with an IOMMU,
> except that IOMMU flips into IDENTITY if T=0 is used.
> 
> From a driver model and DMA API this is totally nutzo :)
> 
> Being able to flip from trusted/untrusted and keep IOMMU/DMA/etc
> unaffected requires that the vIOMMU can always walk the same IO page
> tables stored in trusted VM memory, regardless if the device sends a
> T=0/1 TLP.

"Keep IOMMU/DMA/etc unaffected" is the hard part. To start I think the
assigned device needs to go through some violence to transition security
states and should likely assume that any untrusted memory is
inaccessible once the device is converted to private operation.

Once it falls out of private operation it needs some recovery to get its
untrusted mappings repaired / restored.

Implementations that want something more complicated than that, like
interleave T=0 and T=1 traffic, need to demonstrate how that is possible
given the iommufd maintainer declares it, *checks notes*, "totally
nutzo".

> IOW the secure trusted vIOMMU must be able to support non-trusted
> devices as well.
> 
> So.. How many platforms actually did that? And how many said that only
> T=1 goes the secure VIOMMU and T=0 goes to the hypervisor?
> 
> This is all much simpler if you don't have a trusted vIOMMU :)
> 
> > > And I only know in detail how the iommu works for one platform, not
> > > the others, so I don't know how prevalent these concerns are..
> > 
> > I think it is an important concern. Even if there is a dynamic "convert
> > device to private" capability, there is a question about what happens to
> > ongoing page conversions. Simultaneous untrusted / trusted memory access
> > may end up being something devices want, but not all host platforms can
> > offer.
> 
> Maybe, but that answer will probably be unsatisfying to people who are
> building HW that assumes this works. :)

The complexity of the v1 implementation needs to be tamed first, then we
can start tilting at the higher order windmills.

