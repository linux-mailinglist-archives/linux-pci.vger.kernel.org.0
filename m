Return-Path: <linux-pci+bounces-31214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210D7AF07D7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 03:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE164E19EF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 01:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C828E3F;
	Wed,  2 Jul 2025 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fB+zhqsp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729F6F073;
	Wed,  2 Jul 2025 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751419133; cv=fail; b=AoMqc0PrOu2vLPDtJcoxe0hZjSuxFpkctsKRrjBGMnOjF4DvyhKe9xhXwCF2B0xB9NnxIMtfi+ZRuFEzIGxM70EazfGuE0MxlwWdXZh/+CX1LPC+TgDwC6IEjfAQ3USK1rIpNuSpMlcNdY1O82hNYEtCxXsO1g8Y4kNmbIobvF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751419133; c=relaxed/simple;
	bh=w3b9S55I6Td4c3ClcD0/6oNSk4c7A9RWoJU5LF/9F9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TZEDz96r4eRU5a+7MsEUTrfCWngLT8Qlf3n7WGsQAHJuoOry+1eygOpgFFT6N4CsnNMrTmP3pIxMwej7/OoIdCPE0O/s2EfJdm8MshQvK4+UHJ1Ortm8ns/m6ul0G5azqJ+rgkANvMbuamC8EWvCe8txH6zjufnbeHTrsSpMnw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fB+zhqsp; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751419132; x=1782955132;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w3b9S55I6Td4c3ClcD0/6oNSk4c7A9RWoJU5LF/9F9g=;
  b=fB+zhqsp8Q/DrOiPLCCs13dseW1I/5PpNxP7xEm3RKamAaj7lapiBxX4
   GMtIs8u+ChkLSH07MvFFUVrOk3Qot/MNk5yHEFlF/e1SWiMvQ97V3dbxp
   FaIkWXRf02ARg/4z+iXsPhDA0A2vbRFPZrlPtIfdNUMiambihsxjrXmAd
   UsWDDfFZ4SkEg0L0a30/F+WkSo6Dm/yrpD3B4L2EHGz71WsM28jBf66LK
   fFbyK4yGdtPLbq1wLoH3V6sTCEm/er/Jv3kmgxVc0GflfPEFLtBjWx0xU
   pnqxFs0nj+XEb2/fI7a8uPkRRotOrLbSC2iBjHiy9yYlsSs4k2Vugd04u
   Q==;
X-CSE-ConnectionGUID: z+miN4hCQIuE4m4ov/EVeg==
X-CSE-MsgGUID: AstslGUMRc2BGXbiVBSD9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57479571"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="57479571"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 18:18:51 -0700
X-CSE-ConnectionGUID: Iu80pLBaTeCqP0biKy8Kqw==
X-CSE-MsgGUID: ARe4zUMKRHmOdE9s2MPPbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="159444038"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 18:18:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 18:18:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 18:18:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.87)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 18:18:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TflaJpNPT2MVPs/m6XCWecPZ/hY9P/a4FRYZk8Ld2fyeFUk1H4BNgEcNzUrte7qHDF5YDQ2sK0pbiTg1BfWMflaLkLeo4/jkAhJHToerCVmXXi0ZxJrty+Qi2taVSHHkKZ4qrH2MP8mF1v7VWaGhXZaTJXJL70/kk7Wcewxy1HGdr7+W+8Ustgy2/tza/h8gFHRwCeSYvG8f2WLLg/EuYuQbJwW+8fKUVxAIL0jjWNFt+RFp8PLiUgnOjz9H+wafdO4sEkBIIA7eEZljnDaMaTUpWM6oRHfq7CHRD8DZ16lHuYOO47hrGxtMZtJ+4DPE27zjPJhQRmB8AAMJuB5u8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aogXx64OScUd0h/vObkWp3VOMqx2J3wohfKZejMcuRs=;
 b=tLOEhutnTVfhzir8uUwio3imh9rOik7HNGZ3BA9qhWR7AzJvMZola10xgCKHMCqT47WBFRpdCbf4OOWfmE8D6dRDNT+z8mQnAEu/p91358Li05PTAtontx0tTTbOMvxPz7yO5sliUy8NPYfyGsjNtlnY6ZBUPFjHpwTGuqP5W/JqzcO7XJ461LZZ7r3Cn0u1ih+vjZigXb9mIU1PgBPi1XTK3wcohk7U5BPoyDVPAxrTez+tOZCAEBmcLgvpMFGg/BrhRNDq+aF58+Vf/WwbZ2ppd59l4b0SmkQ7hX/rwYk6trKdYWp5n27elOkexKJ+4ZQ3UOY/cR4XnOf8cbFVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB8668.namprd11.prod.outlook.com (2603:10b6:8:1b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 2 Jul
 2025 01:18:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 2 Jul 2025
 01:18:43 +0000
Date: Tue, 1 Jul 2025 18:18:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiju Jose <shiju.jose@huawei.com>
CC: Terry Bowman <terry.bowman@amd.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>,
	"lukas@wunner.de" <lukas@wunner.de>, "Benjamin.Cheatham@amd.com"
	<Benjamin.Cheatham@amd.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v10 12/17] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Message-ID: <aGSI7oXthPW-AY6D@aschofie-mobl2.lan>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-13-terry.bowman@amd.com>
 <6b8b65df7c334043863b1464e04957db@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6b8b65df7c334043863b1464e04957db@huawei.com>
X-ClientProxiedBy: BYAPR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:a03:60::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB8668:EE_
X-MS-Office365-Filtering-Correlation-Id: e50d3185-32fe-4b52-b5bc-08ddb9066252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s/FvT+xcHeuqBT3JX0T9Rsgkd16mXGuC52z3nlMWHsx6x6C37/6mHmpN6Og2?=
 =?us-ascii?Q?6FNuOAFPh7b5IzFcJFNA7rau99qvwWsXZAwzPe7In1zoeSP2EzBHUqb1UZmS?=
 =?us-ascii?Q?0xDfgVt4EzRUouE5uHZ8o7bGCC1wMieadjCk8IjdafBjK1uNOZmBh8liYxwF?=
 =?us-ascii?Q?8k0aSbMBRMqWg5lCfCoR5p7MVUEL9zsQl154JhDMIr/aNaK9f4xaH3NyeHzW?=
 =?us-ascii?Q?vzZVzqML/Kf+di67QgmRATL6IAhB8XDLpTOxK+LsMiom4aH0crwUKcS+v+Pf?=
 =?us-ascii?Q?iB/zVQ/acQ/+sae3kuezis9F0AA79Z7Bz3F8dq0qi9CHPoYpesbdnfo0p/Od?=
 =?us-ascii?Q?pxrA6fSYRbnBUZVI1bOvQH4YHF30T4+YOn5soGswVrIpQRAND06aYyodvXdL?=
 =?us-ascii?Q?Vk+XJ5ztW6cmFiwOuMHnr+t8gxx2eHDYZT2AF+KrL5yTn2kVe+m9xkXH80SE?=
 =?us-ascii?Q?ZW3vZYm9wuIZ2CaX/HAfVKmrt68QMzwTZr6yfYTrh3AbFKBdeW1tn2Eq42d4?=
 =?us-ascii?Q?F+p2seM2VXLzzcAPppwBb+V/J1XHKz2iGaxPakrFPGty9z4W7pap+b9sQ4LE?=
 =?us-ascii?Q?5vmOHTYZfOxnepfuUnK/rZHI+BOrmnsPGNs/Dd+q8M3JztD55q5mdGXdGp/m?=
 =?us-ascii?Q?kG62h2vIT895zpwLDFYCyrdxMTP1VUvCDklPUZogCRkp06rXwkTxNS2jfTfr?=
 =?us-ascii?Q?p3lK79t2ZLL7mHJbLEQbS+ZmepuCMGsof+Qz38cRCuqZCXX+gOPgMVPwI5un?=
 =?us-ascii?Q?bF2amoTM5Wn7+VGNf4mcm1/RNdKcXklinOrhxE/yvfZy7+FIbR803mVS3RB7?=
 =?us-ascii?Q?dd+xMj8aOSgZLpaIqn5e1Eq9OBr7IQWVUAaL2DZQqofTeV5iBgdqLt7SW0sw?=
 =?us-ascii?Q?wy5zQ/oCGWhdy6DVcjCZzojtJ7/Ky+XpHGTnpAUEL8s4PGYGpXwcRTzu8QGf?=
 =?us-ascii?Q?ZQs4X/Vx1e/kmQKXDeIrNKwkjkeE1LpvB+1fzwLtYP3D27EuTLReq/uLglgO?=
 =?us-ascii?Q?j3CdBwx9yxNzn6IWgHu+rIIey66Ja+kKYT0DxSYutnUWPlEU4nvJYs8ChqLi?=
 =?us-ascii?Q?PgaPoHGO20/9mpdhhJH6fTwpBzZa91jNoNrBsDySluUW4CsVprXfOn06yr3H?=
 =?us-ascii?Q?llKHc2z6lTcH06vcSKbyCqDekFczPi93zTUOrXwc1JHW7bcOaEyorep0ROqP?=
 =?us-ascii?Q?cJt5inhlb3MY2FG36C4LL3reonxXNY6JBOtiXcAsuISLgJGyl8x30M/e6wgo?=
 =?us-ascii?Q?M0NUEyEDY250Qb3MdX9Gj9w0znjv69mF53YYR1eIqDzfH3bcwivk/uulqKsF?=
 =?us-ascii?Q?5Cd8Ku0rqBX1Ix+OgtJGgGCaCc/CPFjokkFiJcDnisKojvCPbokCCWDUd68i?=
 =?us-ascii?Q?PEV3Q3kJf6Aqg9t0fGeJn8HI7BDr/2BNPLwN/5sB8+2w7eIhJd2+OVXNHV2F?=
 =?us-ascii?Q?RhAqweQTV0M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ROuFpocBKzJghlpjt7WkYWg4nobo/xKsYb5N/Q+jStKf36zTc/TKLhQ48ys9?=
 =?us-ascii?Q?awyafdm7k/MhYVWmvIZjQBrw7z7FW+p6vzDQT3I5utIvKAMzAOOjiO6ZBSmn?=
 =?us-ascii?Q?o9Vch3A2R9PwOB60dk8SXeJT40s+KoZvACIyNOkZleYPbMjTFgpT2na7/os9?=
 =?us-ascii?Q?jnRxjIhxsff1jArB8IW6tmCZhWhb0m+JfwUp/lyXeAocegfCDinmp+E98Bwr?=
 =?us-ascii?Q?7iKUThQMiPzyEIh2xTojPrscq6a+dOAPbR4qZWK61KWpaHw5WDzBCjksrvCs?=
 =?us-ascii?Q?ZaXURl4fW6ZyPKcci5K63QqZCT/cGb6ZQlw/Klz5BQ+uPyYoi1kLHEMFwpuQ?=
 =?us-ascii?Q?m6qraQvGZvva3sWL87i7OzvAuL6yJfa9ybM3PJcBjiAPj0co2MGEI2nkg1JW?=
 =?us-ascii?Q?9NI9oBVOHo0bO5lp+N4gRBEFtPDgWWynov+LE1AVwUmewp1ouGavxNBzw2TA?=
 =?us-ascii?Q?zm4jPygT/xaoJV12/fHrbnsbkuKzEk0FJRLr5KMDZPK4twcqDODXGBZcmBJx?=
 =?us-ascii?Q?S0kc5bweyocqVec+jDkvpwvmP5MCC9rpjMm7kAB1n+8wi/hDLiEImJm3fR0S?=
 =?us-ascii?Q?4E7eqRKPFF6Q2Ea9ethNFGdedb8n+Kogx2hT5zZuoVA269/fD1h8lAdmdf5Y?=
 =?us-ascii?Q?O6jLTxH0FvGd4VVWJH5vRWfbwpSRPFtG/eHv92v4TNNcW0rRlAxMy8VDkM7z?=
 =?us-ascii?Q?ap2Y3xG7z5Z5V0Du9SZZMplCUUL8X8jvApq3xUKpSDMP+JEdPeqTkhMxYK+g?=
 =?us-ascii?Q?xJx4ok1AZjXHHjmPJcS6CuI3xO1E2k8BIwmt4HDaaNhci478QQ7WRWg9wd49?=
 =?us-ascii?Q?05Nw+vaq+Z/fmtCT8SqMo3EIYo8ivObdEtQhLCl6Y7oPs8x8VvW4OnSOw9c2?=
 =?us-ascii?Q?J9d23TereIIvN4NGlWuFXzJRKE1jLsf5HbQBvpMjhqRkYlrNImNxlKHWu+oI?=
 =?us-ascii?Q?QOiabDWC4rtXLkP2CrbHPCh7CVUy28Ew8UshGFA44Y+HXmsl+K9FpnfyMjy5?=
 =?us-ascii?Q?GWE9AaMT+TYX3BrH9wdpBXNRgXidaApZQTes9eXe3n6U4HE544ONbJ4PB+6O?=
 =?us-ascii?Q?whiZE3NV6wVLt/RhtlJGV5RasIeAbt3DTQTQ3FaA5qyqEp8SSjjiGWbROk6k?=
 =?us-ascii?Q?01tgn8or2sIlQiRlS8De+NrKTNPg6OkkWtMNvQOOz2sSlQ+D9IadeQ8Fjd6O?=
 =?us-ascii?Q?bY4KzAGuwGD57tnRACwF8CCs4L1C7ClDA2pwsHmcFVM+CBTATxzLC9Uf6AqE?=
 =?us-ascii?Q?Ah+a4jtAHLtcN1fp8MDUJ1GiOPUAiUtqU4h5sS4H1M0NNGfSDyG8rNzXnvn5?=
 =?us-ascii?Q?FygBa4LOkkAm4bhYT62kPPsn8WJKKAouOxfGc2Zfeg4vW2HeAKztRee2H2qj?=
 =?us-ascii?Q?pMh0qqyrKsB41wPb2enRefzD69BHhxQGmzgIH8/1Z38osSLL42GWvgSYfwhY?=
 =?us-ascii?Q?GmhYK3nlO6dF22GvfmCxFkufQQHsDSdHBXmEa96ji4+IRP2Il94OCP0bc4l7?=
 =?us-ascii?Q?8WjRlGsgD8WPXLVeggyu2IA3m7bFSDweZonlPK+gemwGqHbpDyj2hoe26skN?=
 =?us-ascii?Q?YMfyALoeoAo8wlPwRmezmE7iZuRoDv+lE4EZJPaxPY9saBHtC/djIRq5/mas?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e50d3185-32fe-4b52-b5bc-08ddb9066252
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 01:18:43.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKO+0fjenjXOpJOEPETxuHz6cokB8sjLOBwzbB1diwWUf+VbqfpMgXIyzpxBhbIKLJPo7SWbmKCezvm3P0RycU/gbJz3BRe8+MF8jx0vnjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8668
X-OriginatorOrg: intel.com

On Fri, Jun 27, 2025 at 12:22:39PM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Terry Bowman <terry.bowman@amd.com>
> >Sent: 26 June 2025 23:43
> >To: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
> >dave.jiang@intel.com; alison.schofield@intel.com; dan.j.williams@intel.com;
> >bhelgaas@google.com; Shiju Jose <shiju.jose@huawei.com>;
> >ming.li@zohomail.com; Smita.KoralahalliChannabasappa@amd.com;
> >rrichter@amd.com; dan.carpenter@linaro.org;
> >PradeepVineshReddy.Kodamati@amd.com; lukas@wunner.de;
> >Benjamin.Cheatham@amd.com;
> >sathyanarayanan.kuppuswamy@linux.intel.com; terry.bowman@amd.com;
> >linux-cxl@vger.kernel.org
> >Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
> >Subject: [PATCH v10 12/17] cxl/pci: Unify CXL trace logging for CXL Endpoints
> >and CXL Ports
> >

big snip -

> >-);
> >-
> > TRACE_EVENT(cxl_aer_uncorrectable_error,
> >-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32
> >*hl),
> >-	TP_ARGS(cxlmd, status, fe, hl),
> >+	TP_PROTO(struct device *dev, u64 serial, u32 status, u32 fe,
> >+		 u32 *hl),
> >+	TP_ARGS(dev, serial, status, fe, hl),
> > 	TP_STRUCT__entry(
> >-		__string(memdev, dev_name(&cxlmd->dev))
> >-		__string(host, dev_name(cxlmd->dev.parent))
> >+		__string(name, dev_name(dev))
> >+		__string(parent, dev_name(dev->parent))
> 
> Hi Terry,
> 
> Thanks for considering the feedback given in v9 regarding the compatibility issue
> with the rasdaemon.
> https://lore.kernel.org/all/959acc682e6e4b52ac0283b37ee21026@huawei.com/
> 
> Probably some confusion w.r.t the feedback.
> Unfortunately  TP_printk(...) is not an ABI that we need to keep stable, 
> it's this structure, TP_STRUCT__entry(..) , that matters to the rasdaemon.
> 

I'm not so sure you should be letting him off the hook for TP_printk ;)
It seems TP_printk should be kept aligned w TP_STRUCT_entry(). As a
user who often looks at TP_printk output, I'd say keep them all in
sync, and consider them ABI - ie. add to but don't modify.



> > 		__field(u64, serial)
> > 		__field(u32, status)
> > 		__field(u32, first_error)
> > 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> > 	),
> > 	TP_fast_assign(
> >-		__assign_str(memdev);
> >-		__assign_str(host);
> >-		__entry->serial = cxlmd->cxlds->serial;
> >+		__assign_str(name);
> >+		__assign_str(parent);
> >+		__entry->serial = serial;
> > 		__entry->status = status;
> > 		__entry->first_error = fe;
> > 		/*
> >@@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
> > 		 */
> > 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> > 	),
> >-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error:
> >'%s'",
> >-		  __get_str(memdev), __get_str(host), __entry->serial,
> >+	TP_printk("memdev=%s host=%s serial=%lld status='%s'
> >first_error='%s'",
> >+		  __get_str(name), __get_str(parent), __entry->serial,
> > 		  show_uc_errs(__entry->status),
> > 		  show_uc_errs(__entry->first_error)
> > 	)

snip


