Return-Path: <linux-pci+bounces-40849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD7C4C6CC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 09:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48E0189617B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C538B2773F4;
	Tue, 11 Nov 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PA9r+BGU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13CD2BDC2A;
	Tue, 11 Nov 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850252; cv=fail; b=Gs3/fpnXmt4VeQM146B0H/D9T4J1RIyoIXeV6tUX32eA/C8hbWPUrNIWS/f3VumXkqx2vU0aUqANozz3IcEgYI+W79WL8g4BwLdN4KK9nAAXMwVbMBoQhCJQieSUa394KlL5jtUt3gVsiPsek1cbur55i8YNcEREiArLJPbuJoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850252; c=relaxed/simple;
	bh=bxDoBz6ZAJuweefnXcxXxrrPV+l7sOGo40vnXq3AKpM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aw2uJ3klbVqgDYymfBOkgnvQ24wCLE5rtYgAfeT65v1vhW/Gc6xctpJvNoNLzN6LQGC56afBVlp7Flux+pH7LBoEzOOusr5JyZZHzkeOoyEHqvf19hcKofB11WKGJslAfNqMvs07Lbtcbavdj7HPouTD51dE24pkbfVxTrOtQc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PA9r+BGU; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762850250; x=1794386250;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bxDoBz6ZAJuweefnXcxXxrrPV+l7sOGo40vnXq3AKpM=;
  b=PA9r+BGUNNrrl0QMqImALePmLhj6sTakjfmbFxISwMajBwYDlsclkDWI
   gjPmIqSQyIypXlRs1YhsL2N77N8eMF5VrKHtKeo2dgXKe75dVLRQBZzkH
   4qr2Cg8zhXB8lfiiu76MMC808Cog4fuSp4BiucWp6+mKsOSVw1ukH2yoN
   JY35Cw9rR8f0JX9wrrh9tiRIbGf8dhdunBaWZL55k8Ps40umTkDkhMGVm
   AOR/RGQyLGXxNoL0/CImeHLT0AWVc0845zthp/hnKNpx6pOzyLkLxkmSJ
   +W6CiJOqTGBDZgrJGtvSkw7+yjmkplDLFKRgoM8BwDuxgCLxfnoEUcABD
   w==;
X-CSE-ConnectionGUID: 2CCZt+gGTyCyHRfOW0EeCA==
X-CSE-MsgGUID: Q2ubIDN1T4ec3it9nsD57Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="65065266"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="65065266"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:37:30 -0800
X-CSE-ConnectionGUID: nZqrXresQU6w+2g8IXWTfw==
X-CSE-MsgGUID: RuXNUA4KSzSVfDGFms7DEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189161560"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:37:29 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 00:37:29 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 00:37:29 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 00:37:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IO6aJupgvOvKYR9pGjvxeUgpbyyp0c1wEVU/AfM+K0XIIeEye2viTCW5LJp5aV5N7PI0NfD2Fosgjfh/y8EA0f12k8zdhyVEK8aYXsmRCuGgru3uye2QZqITZhX/rNFCZzNWkVFHmwOd3aHOkoRC3WAgkmN4Z4QTTcX7TCIcO9Zk8A98FVui2nkLpqeyOuKMoOOaRq6m0zF3RV7++xBQUDT4K0n1/bMs/twQM0rkzCjzEidbJF21heGbLj5g759yvMbkgqwfkJ+ftZMl8vjLslzOunnyjz9fiH0nPpeCEwIUPdcztfXjCgG/McG/QBvLtXC+72ewl3ElnGY38tZhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdBp5e4CXkCGk6pSfvaGYaMh2iyD5mQ+oeVnUKrCv1Q=;
 b=YtEoupmsjBUi+EmINy0mv7m3VbomDxiy5VckrUfFD29Xe9PNaGPXKDsirDUXEDKDKyzPnDVSz5QyGhyJdV45HO8QdUeTQrBHdeOtKvHeYa9ZM2r6uqF8gZfJSUwv37uUW3t9TQ11I1dIrbGr8goZdArGnigdBeUphHaPQ+eQZsycmWRNwJXyDCm7iJXu/JUV4EVzqkxwwSoWy/YXF+lY4c6OgywfJiK+TNz6/Bnj7EP6Ok79ALVdwKjtqiGEgJAcj+hobi/YFvvduuT82d6mMCznHLnsqo8D7Vh6yDq00t/mTGpBHl2gwtjLbAKg4UCc8YtGecw8ho42qMsfNDX9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by PH7PR11MB6499.namprd11.prod.outlook.com
 (2603:10b6:510:1f0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Tue, 11 Nov
 2025 08:37:26 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:37:26 +0000
Date: Tue, 11 Nov 2025 00:37:22 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
Message-ID: <aRL1wrM0xzZm2m76@aschofie-mobl2.lan>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-24-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-24-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|PH7PR11MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 727df0a7-c67e-4371-f1d8-08de20fd8aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uu5Ad0I4Q/0tH0X2kRShBRhfIEwiDO+E0pqDKzWA1f0+N+oE4gT79gzsYMEI?=
 =?us-ascii?Q?/Cxo4qLYcqZlkUmGvpgPY/o2JFeefGcVwDobwaAq2pT7i0NdwwBYIR3CZ6s+?=
 =?us-ascii?Q?fqIqjkqNiPmN7KpOZSq9hqswY+e/MJH355yc5G037j6tEFk6LS5qDi3fvEXK?=
 =?us-ascii?Q?8UXXhrt9nrxmXXFFoeG0ItMId+feC+V4nSpLcassHuNQj0E/d5oXl5N+xZoA?=
 =?us-ascii?Q?tsoL1gtloQ4LzpsYChwN3ZATtnrblEYC74b2TF6cI0t3AdKH2MFzPvDyPSjO?=
 =?us-ascii?Q?pkNU6PBfyGBesDvBAlbVb9aBFdJPAri+gvQGtTl9EtM70xiGbaE62cUtVktA?=
 =?us-ascii?Q?9pEbl6LD2aK3/mBMBGuXp96SacCGih9VwNlJj5++Sgmkai2/o7kd1duPZFQA?=
 =?us-ascii?Q?v1oMUBEZYFq3cDWFeRkVjslM/NyoopyWBIgv6KYbdhZcXj6vm8+UP0P3oPUO?=
 =?us-ascii?Q?hQPnq2pQrIMnptl3/bzSxk7QwqWxqQ8q81EAYJe/IDJqwxWbw5tGLO5rYMRB?=
 =?us-ascii?Q?a9dvs476KrJze1VvEAj3sadaWwLPg+C6JKHE7B4IYS9GliEQXbD2F77FBT0+?=
 =?us-ascii?Q?0UV8hO/panIGNOZB3KXapoO0pMGyAN+wyDqn/jjShA7NHB86CRuwtzaAc0ul?=
 =?us-ascii?Q?egaAziTjzS+CLrHat7fxNQsd0cpg+hNY6LrRjFDZJZybdxGGT36IJMYpEnLY?=
 =?us-ascii?Q?2PTuVvWiTuFWFpKq2owDo0sFZDn0VEW39mp/Cpkrt2MU6dbltHzPNbc3SDaN?=
 =?us-ascii?Q?oiNLAvBC8H5QLYAisDZcSl2eJAPDl+wCPpSiywQkldilw/0V9pCYaOsFn2IF?=
 =?us-ascii?Q?deD+ByGAjLDxvecm5hcJYBY1fnxJPkRxwjCLbnD1oS4dmcHiaV5p/pRWqyTi?=
 =?us-ascii?Q?8KhVLfR3gcw/9dOzAKxDdgkUXbXvZOT1gsE/8C5bChIJKPTvASD5xQCfaxi1?=
 =?us-ascii?Q?H5ArCKMnNKd6FQqiGrVJxZ94rpP1IJf5nJkvHbfduKX4yJjQtwMeISIWvbdO?=
 =?us-ascii?Q?g6UW9BFzgGEFFTffSb01QZ/N/lN/zKTgN6X44hO1nGPihb9bysnqh2zQZjjI?=
 =?us-ascii?Q?HikvXe1TbJYRqxetTPkv1o8Ktc3X37Zp4/q7MMOgOeYWu+DNKhftVN9/K962?=
 =?us-ascii?Q?j35kydXDg9Xq6bUxtGHDVj7llq8lJH7e3VuwMutoO+jkCwFp2z66q+KNKJOL?=
 =?us-ascii?Q?c+yr8MeGd1a/qPhldOC8SwQ5z09K9O+zvJrglytl3eVXDaTvNOgGn4w7iapu?=
 =?us-ascii?Q?u7axWVgAmwxP8eGvTX/dMSyI4nNlrziQSjul1m7Rtt3gSt8w2c7rydEblg8/?=
 =?us-ascii?Q?FJ30sTz/l1bVKnlXLgHvN4mpWt1g8soQMw+DGLYeX999kZ5XKUK7WDiP7drX?=
 =?us-ascii?Q?vdDkyH0voXWSWqQZ8xg1RSAttQJ+8SuL9a4FZxd0i+VL6EyQMJl3pwEAJ2sT?=
 =?us-ascii?Q?Bj2HFMKSz6bp7RScP0cniukE6dS3SKJP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F71p+yDo/x34JqdM+EHGxifo/OGmwCNKO5F8ntpYWnLvuJuF9HKkqCNp6NrK?=
 =?us-ascii?Q?Nek3B8w96QTH6oYYKflypXI66QUnc5aO21gMMfpfmldJgUC0exWwV5pJGL/r?=
 =?us-ascii?Q?zRYRHVXig/lZWSq3D2GgQXfOezbTky468DhwlYv3RpnRljuBVRxdP3Rj0ujx?=
 =?us-ascii?Q?F12l1h8DiBHDmdDAh/+orf24/iB04tpTSaCTpyHAJWV5eKdn65rg6zbggSo3?=
 =?us-ascii?Q?+oaUMmP5jRuu+GseMPnXqebTHO6iJF9WQ+kbEkxvABprrEAaYg5kWzKH76hZ?=
 =?us-ascii?Q?X6j6pg/TqrnZt6TwebiH3G6w6kjbd5wFMSyB6QAFURpaq42RfBTbcx+PZaVd?=
 =?us-ascii?Q?TzhXvWZbxzrPyF/fL2u+usaDXmeWskYFvDMgzFghmL0AkQLGTuZbRyeNWNwT?=
 =?us-ascii?Q?ndRWw3PRjTHSjfc9hhkDk43f0LFEgS81W99t1SLzsUEXFEKx+Og4DhFgaHl6?=
 =?us-ascii?Q?GTU2n2yCO8GdyQlVZM+fcJKMekd/iboCISFLnVJQJzocCHVZK2eovb+ZCeIh?=
 =?us-ascii?Q?hOZgC9v+cAxxMNUpgKfVF+UkARdev14qDH/E6SNotWgJBkILTmeacZw0Bsmu?=
 =?us-ascii?Q?4fauZD/zstB4P7lJl0uJlFX8jVWLAuLrZYmW6hCXkepE4OsJJsPfjz0SMVXX?=
 =?us-ascii?Q?GP5/+nF+o++eNsFtcfDIIvfBb47v+OsK2gi36iBKzey4REyhRl53nLvsozIa?=
 =?us-ascii?Q?WpAFb9VMN86KaOFPbcsu2GJOvi87KqDuGjbabIghZoF8r3bC+ks3wLupmZDy?=
 =?us-ascii?Q?/je7gIMt7pJnSyKiqP42UfllGJ2FX1LI0hTckT3bxlHAp0TOIpv1UgpwbF2O?=
 =?us-ascii?Q?eJ7HnhMhu5AWT3BxxjUUs8JBO0mxAA4h7v8CWX5Qs/POj5GHYhouoXrdvyfO?=
 =?us-ascii?Q?kn9vjQO10fMWmP9qRTCfyPQgbbVqFa5uT8fVpUZh3brC4JMfgabcttv3oL+X?=
 =?us-ascii?Q?AmGHLGkFIw8c5+Ry7KT202DisIZi/+vntQi1Tou/wo7S8J4zRtVwueVnb9Hk?=
 =?us-ascii?Q?VZMyQL9VfjJauBn/qFwOiAv8QqbHv1lDWg6pUBR/P8eZVr5aLD8iSf73J9+a?=
 =?us-ascii?Q?OJ3ndgBWv3jZd5dp6dhqGVpPd050WeniUVoT7YJZZ8V76Z+N/pupGAXmwEdt?=
 =?us-ascii?Q?wVcMntmsnn7gaVBRhaImNIbfL/fieuaRoR4hm6tyNQmOyQbIkKQRc4VOBstz?=
 =?us-ascii?Q?Ya1N3q8PJ2oKhNiGlzuA8M2pXJG2g0mGMJvcJjwJbTCkjeJU+YLiUYWkaeAO?=
 =?us-ascii?Q?cmgpplBDMEOigYHSNoER3hRudGc1WT6dTmdp2aCyq0aOtH0btDbvfJMVd3Io?=
 =?us-ascii?Q?aOOeczyVxDwsNPnRnGIakjiKl+1reRn08Jsp1ytSIlh4LRuptziVuqUyErb2?=
 =?us-ascii?Q?QBUg4nf1KD3O8ydfp6pBFPtIHIFv3ZmbJy0K46Z5LVjoWd+4ZrHFN3VAD982?=
 =?us-ascii?Q?3So8QBEIbpnPAzCic1oe6I2NwXp2gV+LYgaIQGhMnyZr+4g8W9zQW57b7fx5?=
 =?us-ascii?Q?2nrhkNFiQ+R3pG12/yBQxb8N+vCVhaxKaeqg4pEXLO1k3ZY7mUhKEdfqwvSv?=
 =?us-ascii?Q?EgiA413a/CQuhFGJwdEaD1ZXB6NkTDL18kw4+429h6vj7zdcKSS9MdSZmk3U?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 727df0a7-c67e-4371-f1d8-08de20fd8aa5
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:37:26.3495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+59fp/dPVxvccqF19xYx3txIP+2kN1CnkXaGW7a27/YEj6BXDBuGojd3G7fXJO5H6fH37YE/TaJc+7LzeOAp1auveYu902DFWHI+cvoRR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
X-OriginatorOrg: intel.com

On Tue, Nov 04, 2025 at 11:03:03AM -0600, Terry Bowman wrote:
> Implement cxl_do_recovery() to handle uncorrectable protocol
> errors (UCE), following the design of pcie_do_recovery(). Unlike PCIe,
> all CXL UCEs are treated as fatal and trigger a kernel panic to avoid
> potential CXL memory corruption.
> 
> Add cxl_walk_port(), analogous to pci_walk_bridge(), to traverse the
> CXL topology from the error source through downstream CXL ports and
> endpoints.
> 
> Introduce cxl_report_error_detected(), mirroring PCI's
> report_error_detected(), and implement device locking for the affected
> subtree. Endpoints require locking the PCI device (pdev->dev) and the
> CXL memdev (cxlmd->dev). CXL ports require locking the PCI
> device (pdev->dev) and the parent CXL port.
> 
> The device locks should be taken early where possible. The initially
> reporting device will be locked after kfifo dequeue. Iterated devices
> will be locked in cxl_report_error_detected() and must lock the
> iterated devices except for the first device as it has already been
> locked.
> 
> Export pci_aer_clear_fatal_status() for use when a UCE is not present.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
snip

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 5bc144cde0ee..52c6f19564b6 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

snip

> +static int cxl_report_error_detected(struct device *dev, void *data, struct pci_dev *err_pdev)
> +{
> +	bool need_lock = (dev != &err_pdev->dev);
> +	pci_ers_result_t vote, *result = data;
> +	struct pci_dev *pdev;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return 0;
> +	pdev = to_pci_dev(dev);
> +
> +	device_lock_if(&pdev->dev, need_lock);
> +	if (is_pcie_endpoint(pdev) && !cxl_pci_drv_bound(pdev)) {
> +		device_unlock_if(&pdev->dev, need_lock);
> +		return PCI_ERS_RESULT_NONE;

sparse warns:
drivers/cxl/core/ras.c:316:24: warning: incorrect type in return expression (different base types)
drivers/cxl/core/ras.c:316:24:    expected int
drivers/cxl/core/ras.c:316:24:    got restricted pci_ers_result_t


