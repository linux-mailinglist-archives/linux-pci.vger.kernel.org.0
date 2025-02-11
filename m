Return-Path: <linux-pci+bounces-21246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18113A31A0E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2129B3A21CA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680B27181D;
	Tue, 11 Feb 2025 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="We/KDln2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65357271800;
	Tue, 11 Feb 2025 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318316; cv=fail; b=KzHpbClJJGwswQBmh4CdVJtla3lxugaenNPAxZSuVAR0EOWkCDFDyA/fjqLMdTM0Z01gE1iqUY74WW5VZxZEtHAKII0QVyIoMrb8ktw4qz80jVwmhbfmEyJjUV19P/l2oC3c3BcXg66e9I0gIAi5MWKf/EeZysNwHrXlEM3E6Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318316; c=relaxed/simple;
	bh=Xzbwv3qpxzQ0SLgMjPfxJY8t/uChCxc2Ro73+Bvl0dw=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kEXyYcDd1r75zO2tXil30tG4yIxdM0NWf7HvZ+ksaTyX+pPaaauvFzvTCtrspjrFhkUR43XgUzwEoOMpRhCCJZnSPMLohrUXUY3MpNl+wwESwuVG03RlZqv3a1WFZdvLtb0uw94Gxe5AKmyhwdrCRJWxg1a7282IMGVVpT2S7CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=We/KDln2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739318315; x=1770854315;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Xzbwv3qpxzQ0SLgMjPfxJY8t/uChCxc2Ro73+Bvl0dw=;
  b=We/KDln2YRQd+Dj+xZaMegpdMM2NCVDTC7j/RTYVZvuQmAS2EVEe++4q
   slYvOsS9xoSW5OW0zc8eWyuT8km3IwJqT1/NDpUxLYVh5WOiSqQUctNyk
   annpByZC6PLA0TKWGLj06oK1MVbgm/WD0RxbOE8f38IEJOcZ+Y+lJdLsQ
   W8f/Q+lCTv0dyn3ftW/EdM4udWPVWtvMuZ50eBvuuUov6hHKs2jax643L
   R5OTe4mWJb/dgv71bFYhbK7U1G09RgP0LOLwoIydlieg3bif7VkYshJTT
   P/EQtXK/0dx17BpHpseTCnfX4vgm2hAtnjvGcvgqRHA7HzuU/BRnFJPf4
   A==;
X-CSE-ConnectionGUID: vM/tWL7mReuhsaiJFSL7Og==
X-CSE-MsgGUID: tXqMRCNfSp6mxutSiOvhaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39876771"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39876771"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:58:34 -0800
X-CSE-ConnectionGUID: /uLyga81ThGOjyUmNjeGww==
X-CSE-MsgGUID: 5gnHl1awTT6SGkt1RGipZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113135891"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 15:58:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 15:58:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 15:58:32 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 15:58:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAO2e0+KO1ew9b9KhgviU7OLsqbusyT6fs7acLEi0qMsme6kSfZlI+HsvClJQwRUGyx+Tkqi9BD4eCD1BiZtITVkCQ4uCieadCERodeKfbinNkck4mPqDIjnlb4AkbiJCw6cBIhrmWhjBP7Lx4Pgb2+KCDbCBfDm23mBfHB3BTyzlZjn6+I/QNdiAc5P030bsjgn1ql02GvVGZQXUUOp1Wv10cocicvIkEv4LkMHLzPR+jdsov1gEqZrdXCTJPtJB0jPEPOYdACAjF+Vl7pDu1Ze70K5HnBSFJ5caL8x+FKL5idOX6bQnA/pMeIUqnZX3mg+4xXC7tDbrJrvXxn1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNZ/M2HaXQqg+aqFYx4k5EGoWTbiEkvlm36d3IVyEzM=;
 b=Xyyb6kO880sd/f4Ft/qpwspx0G62HmRc+jHeC4br12yVbhDBfwVjiwxI2dwYD1ukZXJu4/s2ZydM2HXa313JvsjmCRIRrDDDcIvliLTmLk6bynYcCknyFwUoNLH1OK6jOvCLgFBnoHG40PuTZKa+NxeiOXOSaa6aIkrRTzgVPbuG3kN4kcdbfvBd6qEn8GzhLNDSwA3DT22LQU6qRqiBhD5xPh3JWWG42zAsmTF6KCGMs6suXxjcqfH0dWGXeQEkjcpvjrwietBeREtxlsu3xu0iqQpv7xFrfgnvlFk8kZ67ke9fIslOeXeqGNRFRJrnvj6dPLoji9KslWklJamq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4560.namprd11.prod.outlook.com (2603:10b6:806:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 23:58:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 23:58:14 +0000
Date: Tue, 11 Feb 2025 15:58:10 -0800
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
Subject: Re: [PATCH v7 05/17] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
Message-ID: <67abe412e153e_2d1e29469@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-6-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-6-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0343.namprd04.prod.outlook.com
 (2603:10b6:303:8a::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: b4756050-b8a6-4098-d13c-08dd4af7f262
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?layNYBFO85jNzBWVARWUv2xSEz9DvWRJbiFbcB0MeEV/kOpAzZgCyCPoJphC?=
 =?us-ascii?Q?j7DK8tNZSWbjJ/pUVcHhSrvs7Tol2HDijxpW9cFp37jNOorB5QlnemSfJfDk?=
 =?us-ascii?Q?3bYUEUuqEfA2fsEq26uPe54KBUxCk14vfmcD9dWmY+xlAWSgPftGiWUbfnk8?=
 =?us-ascii?Q?kXugveEg1pt33yVuRYHpJjy6UeIPYh1xs58yp60VL+JuG7nb4etGjc9ndgwU?=
 =?us-ascii?Q?C7T63+z1syZrPjPaaEnMl3aFITsVMjhtG6SyMCV3pRveFojz/0s779VhYHNz?=
 =?us-ascii?Q?r0Q5Ru7ZAnvo+ufkfjon8qPIKo1Lx/F6Z5yhdiHMiKiZhWGKityMhy2BmxEP?=
 =?us-ascii?Q?vDiAVY/dyZRf8VjMPVdO/fURxSGMLYedN/19KN9GVcAmS6RPlqwV2waBvgq4?=
 =?us-ascii?Q?uiZ8j2HO9OY4d7RXtX4F5WpWrdiDI6DsOMyjtwto7Sa5jcOt8NXvo9TSQ+Tl?=
 =?us-ascii?Q?ApUnLjwKymGDAqEt4yj//hKmnu8/z9zKgDmU3MrT2Jy1EJD7DZVX2VuF8qwg?=
 =?us-ascii?Q?AgkAmTeg/+87Ae792A6WephOqqzM1lj/vPsTNSN7SYBU/6jezJJQeF8q/lWV?=
 =?us-ascii?Q?6cq7DlBjnS26kexqVVLNqCGRZqt6GdTGjYsqb2FulsieD8eIPZfE/BLv5Q9I?=
 =?us-ascii?Q?2Pq0WAdabSENAjgb8qUo76Dtn4CHcUcK5n/rmImfE5foqVvklr8MUk9B7GKb?=
 =?us-ascii?Q?ZQ978vMQlzl3+kF2VrwlQz48jjAGlF1GQFw48p5SThnTBiV5QNrYMLqQqYlo?=
 =?us-ascii?Q?fwPYCu+TN6FWp5C19PJiv6v3mI8q71i70rssbrfjQ1nGt69UPFYVSajMpcg8?=
 =?us-ascii?Q?IlOrUC8kVPceFcA4/xrFpT/yjFXdK6ObYmCGIKDHCVLuabXg++VTSV0umB6r?=
 =?us-ascii?Q?ZzZOJxCmE5ARP7gCFJEqRxYLcpkbnmmOcuUSTVslqpM6tvbGtGpbt/EtHo7d?=
 =?us-ascii?Q?fT2l+de4yApelRa6fR/Zl2fl3qTbJ8BVXWk4WeGn+rTAjf7sStfM5+M6HWY3?=
 =?us-ascii?Q?/GNVBMCDvlsJ3/UXcbrG43riL6pVsnVzpXqwxDzWS+ZTx+/vGRAHkPLS0Uo8?=
 =?us-ascii?Q?uOqAWOWJvbys1UT0yiiIIrBiDS3kZReTJubrJ7ABotHpGYWZy16RYUSjxv0Y?=
 =?us-ascii?Q?6bVuxT4csx+QC3beViJ+Gr6aSj3AkcZo+vF2LQTfFqLjjSUADAYDLeBDUX+j?=
 =?us-ascii?Q?zpUmHPy8D7hYfxvla/gvEfu/Cb7yQ38xTrn472SPKbK1GUkaI/3qJ4Mfje1F?=
 =?us-ascii?Q?7ku5whb2kyJdIeHE/v1fzKjNzLVVb4dwONghn7DCMeL5cRDeKSp48xmd0VZs?=
 =?us-ascii?Q?da2rTNhTvXk1etj6tD7zhMFkU5kQdnrhALdUn1en25FYDjt7hPMMbNl4rRZL?=
 =?us-ascii?Q?iILNI5eQdv3XlJBzzMEgcjRXOFosLzG7M95K1caHEYNC4+IN82E8fL9B6/61?=
 =?us-ascii?Q?JJ740FP/rw0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?261XXNHy0m4F6vGdy2HxnjP0snMddiUPPeJESdmCaKFVx46twSWEUCyuiYao?=
 =?us-ascii?Q?UPLk3S0uOgerNR3oh0/+exh3bQmRiOnQujoQoAsd5xBiYGZHIlBIOkZ9BUxD?=
 =?us-ascii?Q?2gPY7tM3WH+PJzISaiWzDmXMZclwVRCBpNFTe5TzBFKt4hu8ePY5/EHnCn4V?=
 =?us-ascii?Q?+qsWDwIhAomYxmO3844WsUAQ8NxfTgD5yL5M0P0Xc9ZKLP6BbBGLAuhjuQK8?=
 =?us-ascii?Q?S6mgPHorzsyuLKLxxjG5mKw8gGirHrSokOTvQaODgZX4ImKSlwXRQB6Ib+zC?=
 =?us-ascii?Q?MofJLTetFxnAAQPiRC7LsAlYXIp7AOlHP8a0fnYu7N4ZsrU9tLQO/X/NG2Fa?=
 =?us-ascii?Q?h005l4fdeFy7LjHRXQvwogj4pX3+KK26wF2fa+/n39o2/nWUSzA7ABqnVygf?=
 =?us-ascii?Q?ABTRMVbNnU6k4h5RCVL79/2Fr0YnHlpTLgb7j+eFPN2Hb47q9Y+vX6ApN7yw?=
 =?us-ascii?Q?zJB9HwLpHevvG+E+z5HzpQK+fWDst8UMpIBAucaL0xADGoV7LdAhqK/2giyz?=
 =?us-ascii?Q?ESZXhsyzCXyC1AoiUSQmMa/8NV6XPnK759J7SMZSJQ15eM+/1eEwviRKFEU+?=
 =?us-ascii?Q?3LgWiXKSr8DULI4adfVJji3RoM7e1VBaThcpuT+Y/6ql0NxxH83uIdyUTQL7?=
 =?us-ascii?Q?3q3OFhGohVwAThn7bbOU9YwIlB/kR9xtHny4nHQI0sAyW2lgBzIE7QG6jnTN?=
 =?us-ascii?Q?yVBGbuTqtSmtGz/QQ1aeYmI+O+owNYC8QzWow6ZiYwL/LSI9r9Uxd4/AzMkm?=
 =?us-ascii?Q?I2ljytT11B/2PoD4J/rbGGEdKhLz+cjhXp7xQ782v6E0HmkH8LEXm/oqU23j?=
 =?us-ascii?Q?5f8X00npnMbg9bNm231hOh9O8b/TBbpkC4z6669Wa0s9aiTVnAHnC3Uc6GSp?=
 =?us-ascii?Q?IffREk9Y4Fgt37fbe3UZ5Ra5plbb1Vshv63J60U3ZNyFC2BCJB2PvOHqoV0/?=
 =?us-ascii?Q?jkfR4alNn0LAgpPrCS21bgdH5jYemi566TMWdbMewarMaDgeIJUzgjWwXFMb?=
 =?us-ascii?Q?s5F8KEn2emR4MZFs31FFv4g2W+wSS3rPoN8euxjVe/Wmd4uKzZDzz/GXi1ut?=
 =?us-ascii?Q?4BE3Weg3652G9PiAz0vdBobP0wopl1Cz7LDGPABp19444bR94Z67OvvALuMe?=
 =?us-ascii?Q?v4okVZCJknnK8ftXe4JWy2cnuohDSqKn8LqKXu525O6fl3aDcwJyQSCXqVpM?=
 =?us-ascii?Q?p8vbR/pMOrv6qEU/HrKRmIJkavRS/9/fHCnJs+jvKeIgYn9uq1ltU6FU5nPS?=
 =?us-ascii?Q?PfrwuDL7hUsCLS6EYqm7ZztUhetrDZ8K9nwvgF6T7LHZLDe1oigphEKC3xGp?=
 =?us-ascii?Q?Vc3MAlmZcSOMp7UUFd+Q8jPbat3TSRU0y0uYtjm66HvpNf9xSr1WmNBTxD6/?=
 =?us-ascii?Q?dHwHthmDMnlodLS75eX/hLtziTBd5u6xHWIzzBium/pEP+p1et8rZbpLZJMx?=
 =?us-ascii?Q?N6OjdmBUtxPpMobW+1n7XCvwfQWxG2n60Z1PxpVncJ8fcKP0awvEKHkNJu6V?=
 =?us-ascii?Q?dkUiQhl9GOFsZ5LgBf3mMzOeWQkty0D0AlukaVfqqS7FCKx+UKVBmpuz/l37?=
 =?us-ascii?Q?hezXGvD0R2mSXgdyuNmLvk9/sFrNOClK69Cn/2RwkRXZKUC1OKAJ1xF0qFHb?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4756050-b8a6-4098-d13c-08dd4af7f262
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:58:14.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3xfvjQSmirCXWN6TQK8KtHPl3M61LK/YZKemvWr8y8SLUhodtdXtNMjEmO7p0k9RWndD+HV1DCNCgBD8W/+7ECXNa60IX1aLX0EudFybnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4560
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
> Remove is_internal_error(). is_internal_error() was used to determine if
> an AER error was a CXL error. Instead, now rely on pcie_is_cxl_port() to
> indicate the error is a CXL error.

Wait, pcie_is_cxl_port() in isolation is insufficient, right? In other
words, I would expect that when the response may escalate to panic()
that the code should be reasonably certain that this *is* a CXL error.
At a minimum that is:

   pcie_is_cxl_port() && is_internal_error()

...or am I missing something that it makes it unlikely that a standard
PCIe error or other internal error type will not be thrown by a
pcie_is_cxl_port() device?

