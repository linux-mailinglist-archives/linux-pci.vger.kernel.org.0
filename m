Return-Path: <linux-pci+bounces-21228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 759ABA316D4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1719D167B6B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863D2638B9;
	Tue, 11 Feb 2025 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tsn87yiR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B91D89E5;
	Tue, 11 Feb 2025 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306556; cv=fail; b=HESHWU5iIbh44Mmk63MYNxBy2RZ4VDb3LG6HLMhdo1ulgIdvOenl5FuKCiIpN3AryCFPMmv1HDP0OUfkMk2qNfe7ddB/RZP38k6QwWUuEX2VDGmue4De+JsbE5zv3AQvrV5d851hns+EozLoSOXGrXKbWvdLGPwXlA2fOJozlPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306556; c=relaxed/simple;
	bh=euUrD7f3L9pRXao7vCGd+yFmm/+EiP2rzAsETCTk/IY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WkV2rR/c/9R89DMy4q5qPwi5VhGJYJN2jezJon582s1d1QJ/fSpyvJOJF4j/XNMFFfLh60WccAcfGaixExRcuWZw9btydmtnI2EpGvfYlIxS1rveg0l02vMWE/v7TcmdtNQPZbpYDplYvxixDSAIuOHvyIolXiHO3ZxFcMVT7Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tsn87yiR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739306555; x=1770842555;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=euUrD7f3L9pRXao7vCGd+yFmm/+EiP2rzAsETCTk/IY=;
  b=Tsn87yiRqoIxKSCcDgVzMYQKN64cAuzwlk/PbhaCv2TaEqLLiTfkkKRF
   Kt4K0lwcreajrwQ34TjClIsbKnxJP7rDxyUitJztJwIiG6p0m+8FGefC2
   Fv6tKz8/rAgWOcA+8CsnrvH+suetnC8kuxwD0svlnxu+xP5j89Vnrp11G
   8zkeRzdNdyHrzfPpSMnvspzrxmWxxQp96DtI8KGEKZPkm5J07oHWxg6zO
   AB6JSGygbgnNEaojpczPbL/SQM0/H+1tNxzzG5JARo4RFNIHZGODExdTb
   J4YSDFr4oCBf7gvGCvUKx2Dmfwv7OuMoU8HoWr+SpV2YHw4O8E5qxO+kC
   A==;
X-CSE-ConnectionGUID: xSBnuzp3Sg+1/pwkkveXYw==
X-CSE-MsgGUID: 1SIl1gRIQAmoOIhYVNEc7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50168491"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50168491"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 12:42:34 -0800
X-CSE-ConnectionGUID: nn1zdZklSHKWdJ5OZWbFaw==
X-CSE-MsgGUID: 3DVMln0cTo6+HVL6QfZpwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135883234"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 12:42:33 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 12:42:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 12:42:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 12:42:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfybSc2YrrQrYTpkxLR0sjjplN/if9qYWaqNo+6sjSGD7SnSZEuB/gulLMW2PsM3QbSXp2y2ZafUb4eELSuwEOjHjLxhwqEDpE0f86lbsSQJSd5iEWYz0ZV+QyUAyDuvjwgSPptpC1LIwUIlYd/+KspwD6v7uN83maJKQ84V4l0bHMrk3ZB+9Ak0se9XXTc5DMvnb2oYDJa5zGQXlvP8D32XVReHJCjGhSh2BuYiv9wioKzmw5n+ZapAgX6GY+ymw/D9/G6M2vlep2bg2bkMHDsGt8g3f6nCtxnK8bA2AnJm1LrhY7gD9P4QdtJBg0u1wQTpvw6pY7moVf7/ghxLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh2gs3ZYiqfsZ2Syg5XaAIRrOTDIcfyajZLFPFfVn/I=;
 b=Xb3QKNjMIvN8Iuz9PHfyCtnmSxFTNJHpeJ/qZ13yqfgzPwWtNd7GQJpkptk8JDho490FzkjxuHF5P9NRUTHnkLnXU00sC3I/WGuf/J1EYvthq/Jv1pV5nnJEiNsd9ro/nLiDmqMu/KPYER29MeBU0aP6fdIJpYWfPZ28jxo7AEvpq1Igkej8FT2FSHdfFRHdUnS6ijtVL+2mdaJjtUqGnGBm6kv1LPSy7BlpItdc9svOOIHFrqy3tNXJ12MRu7U60tLIRiwq9KO5p/DvGP3lR0LJaR5ZG+nhf3RY3TM1OKepQgTRcFxCTLJzxfTBrAFP0gwS0B2FAC/I+x0xAEq+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7488.namprd11.prod.outlook.com (2603:10b6:806:313::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 20:42:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 20:42:28 +0000
Date: Tue, 11 Feb 2025 12:42:25 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 01/17] PCI/AER: Introduce 'struct cxl_err_handlers'
 and add to 'struct pci_driver'
Message-ID: <67abb6316492_2d1e2947b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-2-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: f852a4d0-8e57-42a3-0091-08dd4adc995c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vN9C4bxZ8cXL8+bdx6ECnFRoBjWkH2fwtQ17uYHCIbNjVMGMoTegIZlNCuxW?=
 =?us-ascii?Q?aqabPuOjEOTgipji3Gt5azNffDcysDfny8hbgi1bfK434oJReGtKBKrB0CRa?=
 =?us-ascii?Q?MDHj2/KIBzBRbExxEL3H6fyD+hprFCtxuR0AcRC3xd48udEHnVB5pngeHPJJ?=
 =?us-ascii?Q?0s4Y6of038kMOpzG4zi1GPLMxj3M9ptj09UjSz59yUcXylBZWMJBNt1Dl9t7?=
 =?us-ascii?Q?V8GvsNUUD0av78Mtte6l/p4wDPezlon29cFr1YjiKcbcxWDJuB8D/dXOcHxG?=
 =?us-ascii?Q?DE1mje/7Inwarippa/EgWqp4hVc+aN1asmTEHc/DM07ijMp2cuvyCrZkmuaD?=
 =?us-ascii?Q?1eBEpTdpj/G3A4NwkuwjdmkNas00yx02zyps7NYohIHo0qRJJ8J3lPGJlTos?=
 =?us-ascii?Q?UQTt6WutYsbaGUO/o+RDtKm+otmZV/vaUr1t6dbSX8nt9YXQc/p4rLdUhiRs?=
 =?us-ascii?Q?ESoFXBd8CRYFt+MVmi4fd+7eAPOgFt70erp+BVwubF/mojTznN3acpDTqTFC?=
 =?us-ascii?Q?S+V4Y2Fd5naAG2+GsCoXhMwvtkuCw79D27+qQl6RVLeu9sYdp5mDjixCJB7O?=
 =?us-ascii?Q?zplRpsoJX7+kDxG/AmRkuAqoSPfgdMBp6lXT7IW15sZq9X2Yv3mzeWl0UT+H?=
 =?us-ascii?Q?Dgb97vHm1VLumD7abWJ1vsQfe9WZKALAL2xEabo0BVuE9aMM2stpS7Tjzi8X?=
 =?us-ascii?Q?m1vhKwAOltm61u1xHehEfVguJJ1SkGya5K25kBMbn7anDa/WmnfG6pafMtcg?=
 =?us-ascii?Q?oF2lO2WcUk49ur2efHJJuylkdh35MKGDacoNWmaBhbTFYQkbfWnjSLBKfXl6?=
 =?us-ascii?Q?ePvCmLiBHx9jX/aaeoEBkZw4vfHYV9O49OQ7ZV/2pumyGJZUuZceMQfB+Ay3?=
 =?us-ascii?Q?j+fQ7XesE+TDUQbVjGwEK6iCb7qpFo/gdropir2SxGPXBMBlFodYTXAYnhfl?=
 =?us-ascii?Q?B6Zxp2AAV6/8VuHgOLU80cc8KxwuWAP0cW+dewKLTYtVtdIdt3N2t+ZFWYla?=
 =?us-ascii?Q?QikSdQ4bq1z579FiDfKcNevYgywl4FdVRIM09jr8qTAPIABgM2MZItv8AkFx?=
 =?us-ascii?Q?NG1jzSDI747WcxLWY20J9DgVP15d7zcfGscl6m08Qn/isfFHIh2fxsreBjuH?=
 =?us-ascii?Q?fMxUJzpX3iKFTRFYsWegqfVR7eKLNiO+tLJBbHkZFaZg0b9B740GL5wRBohB?=
 =?us-ascii?Q?CVs2O/i5BR/v4R6aYZyJZHkoyC07KrgkV6doqeBCkAdB2mxmvbdxT8FU7NUg?=
 =?us-ascii?Q?yqOe8CcdR6/YxZ2Uz6wjhdRjFlchNTws3RWuQxWTXI9MWWtUq1xAsGhwMQTv?=
 =?us-ascii?Q?brSpq8g4Qa10b4emO4Yxzs5T5ZW1qsWIbLZJ9skDd6Rq93bN5JohPS6tzCFY?=
 =?us-ascii?Q?BeFEfrjGkLRpOGSNlfTyOcO8bNXQ7r715nyQExxvD5RcN3f464kq2u++yxif?=
 =?us-ascii?Q?XzQMyCu7SIw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/AoK6UnLdylcJR3sqZvTY3H0KPcs6yJT6Mdv2cs0YWlLSAQe7DKWKGWViAYY?=
 =?us-ascii?Q?RUj+3CSeo2fdRxMd3hZy107srpRrio05d2L6QuvpAs8cCAloOtzKY1ksAxNk?=
 =?us-ascii?Q?XyH1xz5eijRucfJH+NzxaMTKTOGW7d0yUFApWrWygCq8oDOSWOuVcAHyPz/2?=
 =?us-ascii?Q?KLsMCHK2gq6mc1LXtAQM1li1Lobzh1w/KQCB0A2pJVzP5C0axPSb+DL1b7Jz?=
 =?us-ascii?Q?+ujKjar09E7j5x9oQHAJvladoBDxkg667ce6ynhiF4eb6R1UKZU+5UhcYdB0?=
 =?us-ascii?Q?8KpJWwpv1J7o+wPbTR4g1NVhSylGx/1dfLI9egn/lr5pbL4DExJ+fn2+cpin?=
 =?us-ascii?Q?iAZ+1w6pDA68AqhEOixz/KH3h5urdOD7SlJ10SORRoe0bsnD3rOV6bJr84O/?=
 =?us-ascii?Q?u/eri0nmejWf72jtIVtKiHF6/30z91ZRacA5s7Mf3zhV15heGmOucC+JYskf?=
 =?us-ascii?Q?ka/iKO6EBYknhGyxcpUb0KR4WGrXmWrQXIgPkwPw9gSvamVuz5s+t2nA5517?=
 =?us-ascii?Q?W/A2pcmsAnFM5zeX+MHOQsDZGCXvz3qpWRtCwRt6GgaJqawPnVg1CNAksXJk?=
 =?us-ascii?Q?LXwOaTLwdBxXpghkXtkcBNTjHCTyoxPYVpXkTmtWeHsxD0bbeiqUE05lgri3?=
 =?us-ascii?Q?XatcwiXc8qG9Of553lA5xScZppkQbv+a2HWRjEeI3ccfyTOLh0T5wO79kKJU?=
 =?us-ascii?Q?xB8DayEo26OCiR+cjlnvyvdA+rohT65ICZkKxjYha3pnViawwGUXp6XT42BD?=
 =?us-ascii?Q?lHfn/caoRz63lKaF9FUpHUCZz/B8wYsbJsE4ZiSioYUf2oT5UU2sMWx/BYO9?=
 =?us-ascii?Q?3okM3LCfxGy1QvxIONb7OQmt4fFsu4mvffnV/aFjUPReG6EGv3vHuzapyQJD?=
 =?us-ascii?Q?rHSVKuB1cVfB5kEaLglIIywGFgVf6ledFwzoZSwhmCaQBty/2VuGZ2i1YjvS?=
 =?us-ascii?Q?wbG4FsuJabLXdVglvtujr1ysq4u80orfmCOVMbe+Ow5fk107KBttC1kutbRM?=
 =?us-ascii?Q?olJXwEyu3SQSA9680yH2LqKaU15FsbOAepVJIFUpEsZb8Iq3lKmZD1c/OaXE?=
 =?us-ascii?Q?fkoxOUF+exay8nfRqMTFOBMdH+blOPxdMEUeHujGpB82G7/S/Tk5KVtYDyLL?=
 =?us-ascii?Q?SIzfG8BBZEdwo2QkSwS0Y3zQOWuOP8+HO/7a+9mxMNoQwQoiKm3LCpsJmRBi?=
 =?us-ascii?Q?r9xN0Qc7SrUquzSrUeo3StBQkXGZGq1c70oPs+sTTzdu4j6Xre263ZNYuxqA?=
 =?us-ascii?Q?He9t61X89+cPbojs6do6icl/Gxa/PdmBhnBVlqSliZNB/rf8db3r51crl6Qf?=
 =?us-ascii?Q?sCrAxbDbsM4shCGDbb8G5KXYbCCn+uX4YFsgdkdTtCdChRwubrwxUd9aQ5jD?=
 =?us-ascii?Q?9/Ipmr3nOpBhKd5ltkaAWPK5WrSi5j2MDCf/2QtVNF6vPbl0xVpK/qxBF3Ts?=
 =?us-ascii?Q?Q7+Z/Xg5ielI9AKoUu5m2GjkCKGhQM5Pxp5zRhtC9j1tPXRwnUjDqWvR2ad8?=
 =?us-ascii?Q?bAplLhxvcaRSNzZmJR7Jrq1+JMEGl4TjF8e0+H09zzskXWSCC4gNvhXc18uq?=
 =?us-ascii?Q?0mpmMZtTp7VXaMD4knFcGau7WK6+juiIKJAespvWNwihZ/WXasJ5Mjepl/T/?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f852a4d0-8e57-42a3-0091-08dd4adc995c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 20:42:28.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rto0bV2f2YGzZZG7/WqsD3HfHXlM7gpjW3fTn7BKkY6OciR4hPori2tjF89zOjXu6ObklKOYCfwT5ASmCj8WJPp2+SaYIwT+xPv1pKdQSzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7488
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL.io is implemented on top of PCIe Protocol Errors. But, CXL.io and PCIe
> have different handling requirements for uncorrectable errors (UCE).
> 
> The PCIe AER service driver may attempt recovering PCIe devices with
> UCE while recovery is not used for CXL.io. Recovery is not used in the
> CXL.io case because of potential corruption on what can be system memory.
> 
> Create pci_driver::cxl_err_handlers structure similar to
> pci_driver::error_handler. Create handlers for correctable and
> uncorrectable CXL.io error handling.
> 
> The CXL error handlers will be used in future patches adding CXL PCIe
> Port Protocol Error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

