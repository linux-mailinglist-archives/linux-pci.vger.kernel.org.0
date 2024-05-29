Return-Path: <linux-pci+bounces-7952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2B8D2BAB
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 06:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D842857A0
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 04:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAFC15B137;
	Wed, 29 May 2024 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyUJpVYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAA6AB8;
	Wed, 29 May 2024 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716955862; cv=fail; b=YRgEpya5+oN6WYbG1XhkdF3WBvmjgce5BeQbXr7hpMuw+gIFrtn11x6UP4MNz7Yl661xC2WTd1dWOUAFWWhb4I0D12eE2w6fryZWHvXqTJA50DSSN637/lItbVkdJ0PGTReACRC3+FiWD1JMGTZMtctAICad6JKZ1SKzkStS0BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716955862; c=relaxed/simple;
	bh=8vSEXYrQK+htPItZR4PTN5Zizl9A6AM5hB8fJWCWd7c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kz5NwC1/4G/i9oiktuV/tgLw6mr4fIq64WG9YNHal6Y1gjbhoonEsUNwPxOa0z4t31HBqzrg3nCnr6KSxTiCKq7uBgDWQNWHY79bd7f+iPQaNqKC++YmL5Q8QX0S1OO5aKSa9LJGE2jChIB7L819NHLzlSNRA4YRSrwd9OZACfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyUJpVYB; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716955860; x=1748491860;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8vSEXYrQK+htPItZR4PTN5Zizl9A6AM5hB8fJWCWd7c=;
  b=PyUJpVYBnwcvONurKZEIXeUR46PcNaixK2lpcKGb8+8KUDxzbFXO0ChU
   9IomQC2+9OS/U5IwE2mVCnjkSh9NYFDWiosl4cbziwmnoJ7TMkd+erGRN
   DFgf9OLKrKXjgw7orz9QZLO/fn0EOeQHOKH1D5cpa2j42Mzy8OHSw7doE
   +P4WATCvl10Xb6Domk4gbcSivHy8dg2zQF4zpLDZXzbhM1pqH359MwYO+
   i/yvV3D7aGj2xaYIKZRQDeGX0yoSqZJedyLOqnykjidwkyPTXqfeQ5gba
   v4FmchFCJiMs/w0XxeoEJzd6lVWLxAEBGiIxfSXFByoaAIlB+VQIharTO
   g==;
X-CSE-ConnectionGUID: 2ppmjh66S8Ot1wcgPu7gcw==
X-CSE-MsgGUID: XoY5l/SrTgiti+WQ2iJItg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13159672"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13159672"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 21:10:59 -0700
X-CSE-ConnectionGUID: lQExc18XRjSP6E3Ga+3bQQ==
X-CSE-MsgGUID: 6xmv294UTi2yJ1N9TQ+nPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39820431"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 21:11:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 21:10:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 21:10:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 21:10:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 21:10:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoRnDqZ16tabAeGJ1aziivp7D17HVx4AzcLLeBVv9a9IYM7gAholrsAReoRMDtIZMNbFHvdKxtxtHvOo9pu8Eu8KTo+VYzAn5gSc/uJLhcVmQFMyoizT+ARZxtg59qVMBPZWjHPOYnei1V1+jFzzTJSlVNLMOeKrlGgzUvAfrwIg25302hHYCptmquH/Ce142HIJBUULhTP0p2CcbLP++6358o+S7rFHbmqrj9G+nQ2QzB0w1tOyzapH1i3VUppCpONIyhoDKaG+p0wcxaDZ8xm5ggtE/fx6PwRhPxeU82i2mt2NTdfMnLXSl0aXp+3Xb377bsG6eYvrmi0Xpn69zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IGnqn+9XjaYVQHDxO+LyzuqqGF151V1TgVknSpZwyE=;
 b=GnX4lsXrcrHVbWFeg1HFxghQCvUwmzCKISY/+e41424YsvJTRSLDGk6XZpgk2PrxfOf6bv9mk+9cfWqVLUad8O6Gin2jqs6r/EHNtwz7ot2qgM2bNSw+ehsEA4J/7DLo9e6GqxK+VzkAo8YpUACKFniGGBaSHuLspsQ4NpTBMZ/ZiNDksnYq/ShyH5UgD0V0+yYTbzldWt8sneUEVZCuZbUyPh2LU+sztcuyRVMxvxAM/6hlSbfwHY4ji0Gz8ituIOfFaIFZcZNG683FhD+65ka1wvyW95rRVTXRmKHtLf6tv8MKzEA3DckDBTMNYp7L7iV822MiN52eOkJ3VWYLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 04:10:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 04:10:56 +0000
Date: Tue, 28 May 2024 21:10:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Vikram Sethi <vsethi@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
	Vishal Aslot <os.vaslot@gmail.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>
CC: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: RE: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Message-ID: <6656aacd991e0_16687294d7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <E1AAAE3F-E059-4C57-BC23-6B436A39430A@gmail.com>
 <664ce3e1a25fe_e8be29431@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CY5PR12MB60607B123B05AF10568ED5EDBDEA2@CY5PR12MB6060.namprd12.prod.outlook.com>
 <664d10ebeb537_e8be29494@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <MN0PR12MB6053B7D06D63421382977913BDEB2@MN0PR12MB6053.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <MN0PR12MB6053B7D06D63421382977913BDEB2@MN0PR12MB6053.namprd12.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0201.namprd04.prod.outlook.com
 (2603:10b6:303:86::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: f81f105b-f4dc-4b8d-82e8-08dc7f9556db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TlsZVvEw7rQPPt9hqS5Cc7Laa7MpuAX52eAZCifNISkUu+4mf9Brax3BLWOb?=
 =?us-ascii?Q?OCY9/Uq8a+flgVfzjpEMMaieGq9SrTN0o30yzMhuO/Ywr6RkLCgRHgABTg8r?=
 =?us-ascii?Q?UD326sm5D6G62jKKFWxCMMNhCTwG4QshCPs8I7347sLFIHlFB+kElP9qyrnb?=
 =?us-ascii?Q?buMeu2fAR7W7pHIPu8ZZpe5C2ZBy8PHPQo6UXHxgczewU/gL1wGly9Cl20ue?=
 =?us-ascii?Q?y/rhXlO+Twq6kSIalPX6WwhBJVJZTLltUpl0TXvUW4Wi3Z/s+TMmZ6orI3D3?=
 =?us-ascii?Q?veAchf0H5uZyCJo6tmf/mm6jEy3puBCxoqQKrRkvotXT1/9kPvoNXBlP5DBK?=
 =?us-ascii?Q?f2NH1PgWjVHD5MW+JKjTe7B/hMFyJQBFu0ChoZwzaN7MBbgNtSUr/hvNVjMv?=
 =?us-ascii?Q?AzxkOwhbX8rGRYRRRpFxvJJA0Zhk0WPFKYPU23x0xnRFKJtWEjJXjkveH/Gq?=
 =?us-ascii?Q?rqUn7g2zADctu1anWJxNB11ejF2F8lL6GW2ht54mxif4gCziUjKDTvMyPXzS?=
 =?us-ascii?Q?i9opLkspoV6IlE+PxBcFNF4bc/eCorzVjFmdTLVyvSnx3RPNMxSFXthTwQEf?=
 =?us-ascii?Q?0O58pDCQmun4jnRIQDJxX9ELANs7SdNDiOBE3BYtBHhYyZel1vCQ6+oe4laR?=
 =?us-ascii?Q?iquW8A3Bab0dtE9o3RIDUIPEbP96V0bdFeNshx1FkV6QYIgiR9OsHbL/MIdM?=
 =?us-ascii?Q?2+M3cxVYfqjjC7Rsk3B+S9omFaN7vJ4i+0fYo3x97D1fGTVtz0O0m3iekBEV?=
 =?us-ascii?Q?50+2LoAyoflrisUWP2qzVHV0AlxoPsulyYoVfHETGcpyADEUDjHH+61ffuwc?=
 =?us-ascii?Q?22aiOn65qfol83v1SAznkEmmsLcPciqIX79PliO5ith9hvXUHKLAiQGvU4Ly?=
 =?us-ascii?Q?NQjDsS7Oz6UIjymU8N4SGblddSQBJuXK139FdlgDRI9J7dWhTLHxvp6tmgp3?=
 =?us-ascii?Q?e0nAwA+XmPKca4UMzGjLJIUBf2VJFmhO2aMB1oYPl75PZMSaSkDDgjswWV3N?=
 =?us-ascii?Q?rwHYZk1BbO3DmwFJdUAekllYU5zPb9Q4apiIB3+KDe/+5GlcvyWZU/5DwXa8?=
 =?us-ascii?Q?arsByImY92yVgj7uKpPnfkMbAxdyn4mDlj/YZmOf/Gwh7e8C63RyPAaDAkLO?=
 =?us-ascii?Q?o9mCZt65sWnk9bKgu4l+cxsA8WpOSXnVMlC2MXerMED0q3kjfY1EishPDPIW?=
 =?us-ascii?Q?0whUpzm8wwki3VxeboBZFskFSxtKyQIgECSBjrz+WY34vpD63x7VadtPBrdV?=
 =?us-ascii?Q?vkgbSFUWB1sSuko/SI/VjaBfmQmn7wPG/gqULQiZcw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wxqdUSPIR+qObnotLKekFpDxRlip3d/m/aS2b8SY5t7nghPTH3ZwhXASvLCy?=
 =?us-ascii?Q?9ssyf7yrtw2jHJ1mMgvKoTOycofN9OHFIFrZ9MvoaDxzI7xmz176tbiXiBY+?=
 =?us-ascii?Q?oaZmyb0H93YifOSucGzFaen2zOsmSLBcW/PtBYMjF96GWwA7wt0uw06fwYZW?=
 =?us-ascii?Q?LALZEjCtwAc7afP4TBwlHs4WGgZGcziFGNidF/Q2Bi1tSLsSSxy8h9RRXgJ4?=
 =?us-ascii?Q?qWmySsVxhnDvQ4Tibjf/WH5TTBvi5kHlkb++ytDMkTnCe0tVRIddRHK+fchB?=
 =?us-ascii?Q?SDRbOi6tpeAw1xyTslHYHGcYG3Ros9zhJ/WFNhIo22ygmmbmA6W1uimKsJ2D?=
 =?us-ascii?Q?1tXxfZfcqvlt6Q58jXFDfzJ9hEeCVyukxtpIqbsONbZHcu707ZTnKcughPH7?=
 =?us-ascii?Q?RGTZlpAT/iwiB99VU0KWGvXzBvu6isOVdVIk1CSPkUoXGfEoeETebwPJCgU0?=
 =?us-ascii?Q?SRyV2mxIWTZ+evhe5akjgPsUeAntNF6a2jK+ADEVBBgvfCG+uzuPvcctNUtA?=
 =?us-ascii?Q?/MxFWYAN+wX6p+kqJAT/upBauu/dnhRzZX8Zv5iilRMDCszb/3/YW10uMu+W?=
 =?us-ascii?Q?wokwIi/vU3FxA99lspfQ8QcfFuQjSQXTtqBxgmz3+RiGLqG12Zlkvep3ESRJ?=
 =?us-ascii?Q?erawVfvyUqwl7xcGGDS2E9OxPIEW7DJBaML1IC8RQudtytOlkyttO8rk1Jfj?=
 =?us-ascii?Q?qIl7oApbdIckwN3JBY7oVpOiz+8xVxDN4e3fikAF715XUBuPeIpUGPaO4Kwu?=
 =?us-ascii?Q?v4FgTLCcXSQHwiXie8a+9kX/1IATfBdaiHUxLWD9iHybit2SOz3OIGh3t+aI?=
 =?us-ascii?Q?0XkRrDzFRopffguxX/egJenWWPBWRB1j85qhcJlA23mtB2AHhm4gVWbccNan?=
 =?us-ascii?Q?xJ5Ab76onQT0o0Pt4137JUDVu7CPlNQJgKl1/+zpnP/FTRDAB/Wbs7Du5Yuj?=
 =?us-ascii?Q?5huP9cpKttyaeie0Aujipd/xdBLWXhsimhQLKYAgV0/5i1Eh/YWs9Q3hRhzo?=
 =?us-ascii?Q?BcgwaX/0sSho2piUdPJ8stLkTj9Vrz1b10MR5sknavVD+h1m1DaewWOtaXB6?=
 =?us-ascii?Q?h6gDRTPdiKgzlQZvfqsRHixbaZvDOmOKpSdssaBnjvY8OKqGuzgMdJ8xUMWv?=
 =?us-ascii?Q?dm/7z7My5r9CThxM9gErjk+sUshYcIOnNZ4dI2EM5O4Oa7LrH8Hc6ZFXJT3k?=
 =?us-ascii?Q?MFH8RcH1O2iXUrNGUC9cL/Qwup1stohuOVD/kLkgxcByqIlEPTpSC3vNYfQj?=
 =?us-ascii?Q?c7asXrFGCyzU5jdfn3YwOeg3EBylE66g8ONQbSIVay5Hl1pjPOQw2WueqNZI?=
 =?us-ascii?Q?OlEshM7k0fcd/f/pYFyh0MX2+3rWrfh72bKfN/FRA8X/2J55DcCVXk+5HZIF?=
 =?us-ascii?Q?wY6RDZliRg7Sz4olAKU75f2w4YllD2Z6qW7JJLhGICavu7qxZM3eAgZj5jGf?=
 =?us-ascii?Q?FsaGWBxVwyIG7V05b6X88VEDEpbUCk7/E0UFvF1S+WtXZ7ce0fRYdFrv0hL1?=
 =?us-ascii?Q?DmF2MpCFbrcTc6S/Zm5qRY7R6bcd4XJz7OfdXEsFz6WO74oRqnFWceEg0I6X?=
 =?us-ascii?Q?MoADhL3BHMFBDcFdsr0kAyxKKeQ7VjJ9nKQCHJFyGZUYI+IpEDuSym/HJImF?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f81f105b-f4dc-4b8d-82e8-08dc7f9556db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 04:10:56.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oINZBAyyhlCy5/c03/cb7wIa2rfJIHVY/sbPWmuSUjwp7iSl9zer/Xcu4qDCF/dOREilKgTzw050MZAisgrgcc1dxAL1gpWewXPeAba5zRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com

Vikram Sethi wrote:
[..]
> 
> It could certainly be done that way, but also seems like common
> functionality, so wouldn't it be better to handle that in the
> "core/bus" driver, rather than each endpoint driver to be bit banging
> standard registers for standardized resets? Perhaps minimally some
> exported functions that could be called by endpoint drivers. 

Right, when I say "endpoint driver reponsible" for something common like
this it implies a common core library function that drivers can use in
their reset handler.

> Another thing I've been thinking about recently is what the
> responsibilities of the CXL core/bus driver are around the equivalent
> of PCIe Bus mastering enable (BME) and shutdown/kexec paths for
> CXL.cache. It's been a while since I looked at that code, but IIRC for
> PCIe, Root Port BME gets cleared as part of shutdown/kexec paths.

BME does not clear on typical shutdown, but it does clear on
kexec-reboot to make sure the new kernel is not surprised by in-flight
DMA. Otherwise it assumes device reset will quiet DMA.

> This can prevent crashes due to errant DMA in shutdown/kexec flows,
> even if the endpoint driver didn't disable its own BME in its shutdown
> callback. A CXL host bridge would need to disable both BME for CXL.IO,
> and also CXL.cache for .cache capable devices. Unfortunately, the
> naming and control of the ".cache disable" is a bit convoluted on the
> CXL host bridge side and doesn't match the endpoint register naming.
> The CXL "Root Port n security policy" register in the CXL Extended
> Security capability structure allows for setting the Device trust
> Level =2 which results in CXL.cache requests being aborted by the
> host, which is roughly equivalent to RP BME disable on the PCIe/CXL.IO
> side.

> Do you agree this is something the core/bus driver must do since it is
> controlling the host bridge/RP registers and the host must protect
> itself against errant DMA from devices?

I agree some self protection might be needed in the kexec case where
there is no transfer of control back to the BIOS to perform the reset.

> There may be other similar usecases. Just thought I'd bring it up,
> that one can't purely think of .cache as an endpoint driver thing with
> no services provided by the core. I can certainly see the point that
> endpoint drivers must orchestrate their own standard controls by
> calling common exported services provided by a common layer in their
> own callbacks, which could include device side .cache disable and BME
> disable as part of both shutdown and reset_prepare callbacks.

Agree, there may be some cases where the core should manage common
features that would be messy to distribute per-driver.

