Return-Path: <linux-pci+bounces-13567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769CF9875ED
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80D11F27942
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 14:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA495338D;
	Thu, 26 Sep 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvmrZYKi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E988248C
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362134; cv=fail; b=V7ELIDagEsxFEc71z14OpV9RONGjmAGL5uiuck5MHGUlmObGLcg92q10AJntRi5RUtXubCmVowt18JTLt/hHy76VumetYOD1yJOOQ38yIjv6fv/RtxGPihzdxfDNlyOW0LDmIj+rB+RZP9mCbMch/v8jAxKUSSCvFQZLkXtpVvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362134; c=relaxed/simple;
	bh=zbkwWAMaHBKSvZCbsl35S2tB5oivRdGoYqvi4H+cMwE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qK5yMtsLj/5sogF9aGfzm6EoGbZi9S4s6Xa1LEF9hbAXkx8v926eu/XXhpzU0xZNg22l9dmZRumy19AUDYTEVrM/ZHQm/LtRM+nenGcllEiPJYgNV84c5oOEsRd+VjYpPf58jk+jZTjLPUXevxn2ifEfkttWZSahTdD32V2OMXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvmrZYKi; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727362133; x=1758898133;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zbkwWAMaHBKSvZCbsl35S2tB5oivRdGoYqvi4H+cMwE=;
  b=nvmrZYKi6gWv3U9M7SQ9TWb/U9bJHv+Dn8sMLFfNQlolOWAed0uZrF7s
   Vzl16eoFb2tbB/oKbyMZ6I/7iw2kYYr3cEH0nXuhe/ztMz6AMocgNPxg2
   IsC61zWHLJYwUzm7IiGvTp7Er9ozq3ZhEkEPY54sQwN1HLgEPGmNj2s/8
   kgl6s+ZDyQoHkGqpWaS4Qm/hL9i6qLTeH4KeVnTtWc9QodJAx3w/m9yiS
   if5IB0qsPJzFDPq/1SNn9w2dWXZhZVoBRKZq3CfNcDpcTQ5FGPUB4Utoo
   RHPBF733DRe4kotJZcKvqDTdqW+9QsXlrdvWSTMa2fKJ6sVVALDhvfRgX
   g==;
X-CSE-ConnectionGUID: mdkFolGHQ1qnwQUeSZ+cxQ==
X-CSE-MsgGUID: gauBWpqPTbmnktRTYQTVHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26619541"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26619541"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:48:50 -0700
X-CSE-ConnectionGUID: 2n1rAtQ+SYefwRs+vo+CiQ==
X-CSE-MsgGUID: cPrcjc/kQeeshaE22xpnCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="76964477"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 07:48:49 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 07:48:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 07:48:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 07:48:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 07:48:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXe7DtAnt3lUWq7F2m1EOj3eXg/fgmjRqSt4P3mGoS57GRaQgMYIREeHlYRVCT/jmHwxN3XUkjYbEMxcbz0kvN1kBJQT01h/CTtGEJ+p1SzhOyV4uUcEuy5bVQMGQUxqUxKrvLZwdS782LV5+FNMKh8JnhnKZpEWVTAlS9Yu04WOF0PJllKamPHSiV1eiCCSIF0/TIOQ2PUJsBZjnx+oILup7taPEJzUFqdqpWJv+Dqb/m10dTG++Q4YsTgIAGXM57rXX8/FpwmuCAyaTdlfVrU8fBPWSozPvZG3z9aZps/CHRDyaekxSTK3W1fhR9/ulbcpDkwGOZp/21Uw8rff5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/MSIKM8bSJgVAsehmXy0YHNUCRn9xKkdTsQTctxPUk=;
 b=SAqlIKImaW8skejaEDCUGlO9S690OuLOFApthbkzMR9fQZEzGb+EGPKA5cjJIr9Osg9qucsNANFel12NzpfBQtOY8uEgTzhXb+7PdZdlvLQ+FXeD0TB+7VVP9SdLgJBfo4r2n1EYutk4po32LGEqfOSqsHtWspyp3J63rKl8K2OV2SWGntYomM9IxKwPKN/uJ1rrNaoHaBVBZttNQK+k+uMs4TMUcpZeaFKPDcpi/xnR+GgplrTuABFv1Efrs8D4MPtJlnZtFblqAo2VNgdOPE9nObxrkgSQgQj47d5Y5H1TVYmtX+5y1wBnTj4oTqAdWNWiHPfPOgUSxgbiHo9R7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by SA1PR11MB8596.namprd11.prod.outlook.com (2603:10b6:806:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 14:48:45 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7962.022; Thu, 26 Sep 2024
 14:48:45 +0000
Date: Thu, 26 Sep 2024 10:48:41 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 5/6] drm/i915/pm: Do pci_restore_state() in switcheroo
 resume hook
Message-ID: <ZvV0STiWx6xyIE0E@intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
 <20240925144526.2482-6-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925144526.2482-6-ville.syrjala@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:303:8c::21) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|SA1PR11MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 32484e55-a31d-4f06-e6dc-08dcde3a522f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Et4TQq2sgtZMzqVWRxhUJzc13BOhDaPP4dV5iNk6RZsLQCqtTmR9+77721?=
 =?iso-8859-1?Q?wCJqlrCoaddWDeI+1fPIJpt2HAILoGrUCwIjPM1BImdcufDynICYwurBKW?=
 =?iso-8859-1?Q?n1SZ8L0sm1S2lA6iOgpAaH64UTsre3WTZTYQbJZE6E4FFueZx/i/Ypi2hj?=
 =?iso-8859-1?Q?OtyNNsthb9cy8es19VfM0Yz9IMOM7+BgGbMtKff35SiZWKZk0oYb8W1Emj?=
 =?iso-8859-1?Q?AgkaJ6LQa/EHWcmzLu5dSiyAjQdAb09OcymAQ1uVUVhGyeYt2absarpiY/?=
 =?iso-8859-1?Q?dEoRP0yWW8xX4ZB1tPd4a328h55V4M4lILbVYuowy98InAj0YirAFbN237?=
 =?iso-8859-1?Q?SGgP0LatgXoblWiU4ccZPWCm9LHb0ymhitbV8yj7P8sqaRNbHyMMk0e6jM?=
 =?iso-8859-1?Q?KVDSZCnzNypfiTicov1JnONnRcFEdjoRog7b/XEtnnzDO4pzBLVSusfKwR?=
 =?iso-8859-1?Q?+db3m6Gp+Z0+OfCst0kpNlqJyO/wG4bjLblt/YTooBAbSVhFY4HA2IF0fb?=
 =?iso-8859-1?Q?WzZ1HhmziSaLjI+XOCPE1q0Hh3Hf518qc0z+OoqI/LJUsvnr7XoT+SEBc0?=
 =?iso-8859-1?Q?1obEf+tBye2iKYk73YFC2vmbGII79RGFd5LKYGFBWAN+DFBQFCfhfOC5Va?=
 =?iso-8859-1?Q?nj2cTRK/cCLgrwJLYrFP8cvUK7iA+ynn3OAaL+Qrs1Fw07eFToHBk2FcYb?=
 =?iso-8859-1?Q?Vuyn2apfJ7p4O1KuvvxkiiFIDx5mdcjnpn+hv1dwCwZ9ZHIXp65NcNJzXS?=
 =?iso-8859-1?Q?cpkByyVqZ+1I1kOai5e9KX+6kRJXp/5DzbwNSc3XbRMITzxC8HUfZOpZdl?=
 =?iso-8859-1?Q?rstBqOA9G/Y2WF0U5SnC2sLlqeKAERKPKRcAqqQdn43YmrrkwA/rlYuEU1?=
 =?iso-8859-1?Q?DIvWQZydS5lfKfXGR9D4HlvzkEA9jpajKcHk9JUfZdrHEidw4YjeESRQaX?=
 =?iso-8859-1?Q?5IaSsmrG/dgdVEHXoS3Es1K1d/juZmbenv9KoH/BHWFuZt5DpcpCa+AuqE?=
 =?iso-8859-1?Q?4oL95ySOWYlXVgaUOx92KJ8RJ9jMTouJrtEP1a8Z68esX6GWO0aQtamk0W?=
 =?iso-8859-1?Q?snD5bneaMg6vWg2Em0g3n7IxOW1PEfoD4ZyRJI0M8uo4hpqvRmR0kczDa8?=
 =?iso-8859-1?Q?ifxQtKYh6NJBLRJ+ujXa3q0BLEcxgRUP+bZ3CkhkmTxWXIhzrBFfMYg7x+?=
 =?iso-8859-1?Q?3vnNRUyJ/88QpcnmLtBzZ4rlIn3MWA/7CQVuevR7t0c8g9eGMcgaJwR+V/?=
 =?iso-8859-1?Q?V47gTsVN5uOFfnTfy5z6yhsBBYyNCncXNcQhaYvKYVHy05cHRtzclCuyOn?=
 =?iso-8859-1?Q?zkZWjF3caluAjms6/rsPRFFewA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5Y8OeqTWf9nHy4SY1ra8V49o197S90S8/WBTJSKS4MOsapWPCg5DzuzkZ7?=
 =?iso-8859-1?Q?0lxOvoALT99hWTX2+fSWzCteMjAKSguwL1rr0bLpLiGtVUWlKjRe0m2W37?=
 =?iso-8859-1?Q?yHy7iqrGR4b+azxmzu05G5q/a1ZiMVJ7vDeVckrckjbUMo1U0w8m0P6xnk?=
 =?iso-8859-1?Q?sHRPF5n0AeRotkqNY8CF+dP3blf7bVqJACIDer+QUx+IRhAUCu/i01cpIv?=
 =?iso-8859-1?Q?+1RzLGX3WU/d1VjOBIxsGqeANdCw/j0crcOFxtw4iZGozWOWOxRruuE3fz?=
 =?iso-8859-1?Q?aId57dDgBzdyXsLxFFzmbW8rz8gTib8bNP+cBUSEj4T7djrJ/a/T2KxItE?=
 =?iso-8859-1?Q?x6RYcBfKfNG3I5qnYZXEVunatSPeDMzjBOZUAZf4/1DXwxE8yyESyUB3sf?=
 =?iso-8859-1?Q?RTF1x8ZoBZgoG/c4EKVBlj1GpuXLLec1PXTTohUuWJqvwgaWbkNeFKwz+e?=
 =?iso-8859-1?Q?FqGnBIFkPj6qW5/ESnCG3g3wmku88G/zJBmh/W6SmKnQGOnvM9e0N4G7aU?=
 =?iso-8859-1?Q?cOon73D1Ixj35Gt8F57qLIM6Vag9c4NBqS9URvOatObhGuU9ni2peBWp1K?=
 =?iso-8859-1?Q?WuiYrHQSdt87ogLZXKfhCsLBQbRQeA28U5hi0XAJB5ZWOPl9iJ8xYS7Hp6?=
 =?iso-8859-1?Q?KDo1XLGoqJHkBFkHpox0zD2mIKnIDVdZTT63ce8cJhBjK0neaKZvc2RYFG?=
 =?iso-8859-1?Q?9IdUvKnJjBVjIXz0woClriKN6UoJ528XdZ4k/dJ9NkY/7MEWS8eIJ0idU+?=
 =?iso-8859-1?Q?pijITwSh0jCGzxe2jXzd0KF8J+o935AozQSwOW6xOiWcRJ2EiM8Vc3A5Bn?=
 =?iso-8859-1?Q?eiYiboc6AyLj18YVU7BKzuksrwhVRa0T4/jT7L2e7rjwnSMPcMdtKa/GUW?=
 =?iso-8859-1?Q?TNWxrlolpwAXhvfGOGyB1KTegr9PYcU5WvUTQEVXNongiX8ewLFRhqSJGU?=
 =?iso-8859-1?Q?6q/BEfCPfuDI2SGrHgJEJBPWvwZxu7FfSLFO1Nf6aRhVk3K0zfU/6hqUVG?=
 =?iso-8859-1?Q?1UElnGKGPOW0zbzu5nTq5NDff441KZE7LL+0T9KysDUXtkuNJZiW/Z+993?=
 =?iso-8859-1?Q?TnzsBeR11WlS1eORJPFUewxmsbQ4pk2VRyH6hQgrQTfxtsdkUR5hoQw76W?=
 =?iso-8859-1?Q?ft5IMo+XlZFTGppZIIL8L+nfqGGBq/ZT0awrMeDwhW2+oTm+f7FmU9AS0l?=
 =?iso-8859-1?Q?+JrWVOskNyGZupyWKQ4cSQLvf47/we1MwOTAB3aNOkomhQ4WmZBGvPtCyk?=
 =?iso-8859-1?Q?f68+KnzVQC0X+s0ifPRRow6hOminHFrVGttP+M4JQ0y0QIBgehBDiHZ29A?=
 =?iso-8859-1?Q?hEX6IUaw2/bXigoP4vKSkkD+S3HJdQh5y1q9Q5hGP0rgsCce+HTM87gvBr?=
 =?iso-8859-1?Q?f6cbkjdamXnzOrnNmdB6kkwCi2/9b2kA2fvMA0JMRCf/UYnPlTTlujRvXF?=
 =?iso-8859-1?Q?PZfHGJ7iwaXWep59p44h7JvkfkLhSjswGkCF8INXRG/L5c6vuB0wV2smbd?=
 =?iso-8859-1?Q?tK4w5zqOir9oXPZJ4wTWfJIhEJ97p32rYeD2c7+AuVhI24SgiAesJfQ/D2?=
 =?iso-8859-1?Q?+zy48Vp7vocJX4vcLZmEN4WyV4sVpwDrexS04T3cU9hB+hxyscoWoDsc6m?=
 =?iso-8859-1?Q?3Hb4DtCbP6RFW7c6mViJhJuM3+HIy6laewxWx6V/tFPWr/KwYb89JZ9Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32484e55-a31d-4f06-e6dc-08dcde3a522f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 14:48:45.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpkmB2u9HQyVrGsT04AxgpjYtyRYJG7qgn6yl+8sJb8baGzUzypxqvIl6/KMCI3YdeLVxTu8GOl/XnTQ2PjXEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com

On Wed, Sep 25, 2024 at 05:45:25PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Since this switcheroo stuff bypasses all the core pm we
> have to manually manage the pci state. To that end add the
> missing pci_restore_state() to the switcheroo resume hook.
> We already have the pci_save_state() counterpart on the
> suspend side.
> 
> I suppose this might not matter in practice as the
> integrated GPU probably won't lose any state in D3,
> and I presume there are no machines where this code
> would come into play with an Intel discrete GPU.
> 
> Arguably none of this code should exist in the driver
> in the first place, and instead the entire switcheroo
> mechanism should be rewritten and properly integrated into
> core pm code...
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/i915_driver.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index fe7c34045794..c3e7225ea1ba 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -1311,6 +1311,8 @@ int i915_driver_resume_switcheroo(struct drm_i915_private *i915)
>  	if (ret)
>  		return ret;
>  
> +	pci_restore_state(pdev);

then why not simply call that inside the resume, for a better alignment
with the save counterpart?

> +
>  	ret = i915_drm_resume_early(&i915->drm);
>  	if (ret)
>  		return ret;
> -- 
> 2.44.2
> 

