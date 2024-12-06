Return-Path: <linux-pci+bounces-17833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7F9E6935
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 09:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD19280DBB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E81DDA3A;
	Fri,  6 Dec 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBgrMOjP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106E1DD0EC
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474688; cv=fail; b=mOC3wohFl2NUMnulaUyNO0nkO3rrjYnjqoj0wjTQtAcYF3B8PV45uC4EwthVcukq++kXP2gBOXkfZDpVWg7o7Whqc0+UKHBP9B6zmghi9XYH90rplfbD3oorF2YfUk6prv+3v9cwUvS5+hY4cF0TddHDAMWdUsZQcyjDSddeo0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474688; c=relaxed/simple;
	bh=OHl5AScEQftnBrLZqncfp9BB8XJvvwtv5qZaH3ZULa0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rb+5bJKcu2m1UCS7W5lY2z6h85FWSMr6sxXFecd/j2AwerDbzHOAe4cQ/P0mwqlgYgfAECPS9qeBqb+QUcUgqivvW10PLzkg7RR5hYVtYftlWmyZtAcyMt78uzdJjDwE6Zau22wEWsAVB4gzHpAep3hljw85oyrBxotqjoVi0ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBgrMOjP; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733474686; x=1765010686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OHl5AScEQftnBrLZqncfp9BB8XJvvwtv5qZaH3ZULa0=;
  b=TBgrMOjP3TVkAVe70fZpe5MktPSjGw5eQoYmhHBwIMlXYE1hvwTVpTxt
   ZstlDbEc7CfbmJ+RjWPmeGclWia9+vu1J5MxfEtxPYVx3UiM8nVF2qQVt
   EF/NSBX6gyYKJC/tqjSyS0bi5QetXNuT+UQ0IBRnJeiI+nIfplS5DNq1D
   gBews4qmMK4zK+mmhmAoc/nkMpY4ApZudjfLH5oPO6tG3TSNaYx5thmhe
   wIMuXRe38E71Hl0lm6ZiYLTS+f1meGrtGufQ1fBbDkefZSLLEedSNYgGU
   fgidk7M4P+FY0DrlV6FaOH0641KrFPt++yikS8AP1pUOQiUBwFtZQGUXC
   g==;
X-CSE-ConnectionGUID: lFwjGJaRTyizR4sUgRvdpw==
X-CSE-MsgGUID: JSWFBSqfTJy8sJsk2kX78w==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="36653408"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="36653408"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 00:44:46 -0800
X-CSE-ConnectionGUID: cK83ce31RoqE1s2n1rkbvg==
X-CSE-MsgGUID: U70cHEikTVy4AUXBLCtMPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="117596707"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 00:44:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 00:44:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 00:44:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 00:44:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KImXlwGI2ZfXBk3r+UlUOgo85LZRqiTEnVFZW/veg3nrWJd5cWn3sNVbTXKQIZSQx8XUa1qVW1TMo+zTvzzVrlMu06PtSHm2DD7gqqWdWrwqWKm2C6+Xh2IbIsWCzvVExIz9JMW9DyYTIBR5To0ETgl2gqigI1DQSReM2V6ks3htG4Q4O/TiqRrFWnZaDKYPz25UrkS9fe8iRnoiHZkuQveCRXlfw4+hL2y1unE/HCRvf9DXil4p1CgrcVIjjQmKaA6Y2l5xUReJEqjfdJAUDRAREl4gatBUqsXTO09osgDTPWA+3YMCSmfC2BForuqR18hgkPoqG2bAc3D6YLiq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vg9gizakY/2dVti3YNm1UWVj67vyLv/grydtQUub5PY=;
 b=hhQOvJO6v39buHQRUZ56F7aPJOW9VXrLEZaDBcLFytU/L4YVOykWCK4S0juFo/FLKgV3CxQOhGAdLJ/BK6OFoiaaEuzX4RBURnK7sJb8260M1LGUriFCJlZdp9oQ1ZPlixH1G4ryXQ1RnuTV21Ixbp6za8m/NR/mRPmrPuBrEJe0yw3CZY7VOvFYzo4LHXVRCVtq7yA1j8dhoOtTDzM39T4qF2xCLP/e6UZ5QYALDaoNCCel7KDQjtGWPRNKATu+DrHn4jifK5N6E+p3d8WsWjrf8aucrmCENpgRxIOQQinqfmm0lBqX98da+19bdsZPMklrBlIEl4WPeOkTlud1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7213.namprd11.prod.outlook.com (2603:10b6:8:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 08:44:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 08:44:41 +0000
Date: Fri, 6 Dec 2024 00:44:39 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Isaku Yamahata <isaku.yamahata@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Wu Hao <hao.wu@intel.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Lukas Wunner <lukas@wunner.de>, Sami Mujawar
	<sami.mujawar@arm.com>, Steven Price <steven.price@arm.com>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Yilun Xu <yilun.xu@intel.com>, Alexey Kardashevskiy
	<aik@amd.com>, John Allen <john.allen@amd.com>, Ilpo
 =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 00/11] PCI/TSM: Core infrastructure for PCI device
 security (TDISP)
Message-ID: <6752b976f3241_10a083294a6@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <2024120625-baggage-balancing-48c5@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024120625-baggage-balancing-48c5@gregkh>
X-ClientProxiedBy: MW4PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:303:b7::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bda934-fe18-41a8-5183-08dd15d23a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+rI5mbPiCGRc90bahyG8Fn0FDqDQNaof4eGkWqk9ola8oOaj7IxRYsX3WZ+8?=
 =?us-ascii?Q?PBYxRV/hUBCJjgt2sBY5IKfhcl4NnCe/axrJJ9cr2LV8SSgw4aNtYVueiZTu?=
 =?us-ascii?Q?dnkOtyaR0bhkKRpPzGxs2Cs4dedSUQ5E/CHNal4XfGoVXwFbDczACjV+oT71?=
 =?us-ascii?Q?98FDcAsSMy3FukMTLYcjDapgN+yAgieK2qmSxpyCSD2umLNY76NKgWOeySps?=
 =?us-ascii?Q?ecSEZTwJ/KOMPKwItUcQfnJSvWAbZrueYpl5m5Cm/AqoF4M2HzX7HVjuYpxW?=
 =?us-ascii?Q?LztbEvx1GS3+gwL/ERz7LDJ2lK2BzyWuq0ZvpUVnVNk0J74DqBtyT7AW0Yx/?=
 =?us-ascii?Q?N+JyvmnXx1vA9Dy0pgh84cPL3Yjn9Km270tfuPCKqZAttYGuVwc7rEreAa3h?=
 =?us-ascii?Q?rbRb3HBNrWk00aTXnpqlv6+X17v9mxG9t/2lnOHR8XWfSAaRIGFC4t+gQW79?=
 =?us-ascii?Q?E1pyBxjfAJ+4hv9iujyQZNT/E75AmDY/dbwPm7aRIlV8bMQRZ/ad2LQbcJpt?=
 =?us-ascii?Q?RPBmneXioe0kba7/Jo1+uAWNA4q1JSNOCkyzbHoFiyxp6jeBw1NMbYwHwi1j?=
 =?us-ascii?Q?5vCbhSK4akLkJRps/ScKJzFTQAsCeAmK+0EZMTtNoW9lo1GEVmuu17O40TQ4?=
 =?us-ascii?Q?rUzEMmmRQIP9c3AU6WVaDDgRDphRK1g9xBe375btkGNj3AAwHiihVTP11r8M?=
 =?us-ascii?Q?JHZE+chuNn+nRqR3MnyivQb8Sz/EmzpgKV/WiefXOp3tcK9ZGJutDPwNLG6v?=
 =?us-ascii?Q?CbVrJLl9p199OfjccUo3MjFNBlvIyEQqKhyYDpJQn5Z5ee0GU/tHPOB8bflQ?=
 =?us-ascii?Q?YWSNrayvpGFOiFtrGrR+qrTr7OxFGnrNmLz8AA4BUQxtjXe3Ney9SnnxoBhb?=
 =?us-ascii?Q?vS100zFdPGw//7Kzk2ghxAV4y3m3MF9d2jxHff/ZxNC8Jc7zcLZtR06zVBVe?=
 =?us-ascii?Q?yDxSLvhGy6eBV/e0vjvi2Ee6ks9zXtxDXX+jqGs9HCsjsMvgLEgXugEG6ZjO?=
 =?us-ascii?Q?4+5+OpHfD6hZBQ/AWZSABSEqEAqU5ZgOVchfGU7gkC5/beyK9IFr038LhntA?=
 =?us-ascii?Q?OLZ9g+2dyS20jVVp4xgZRpqVv/EHoVNBUwT3luoYQUclelpuBVSw9R2ITZb7?=
 =?us-ascii?Q?sJ4lWciGI8ir7IiH+7wzPmV9tVudYxcH91ieJjbGKQtUcIwN1kadLRu6Abb2?=
 =?us-ascii?Q?yldN5IgykR0jCeCT8Wvo29BnnnFwdUvpmr7rAgfhexVfgDfXcQF+khSCRNFt?=
 =?us-ascii?Q?v4L/nysfaFlVyNVWvhekRTHqWiz1X1Xs+vRE5gDq7vHA49FPEjGQ3uoPX+ge?=
 =?us-ascii?Q?AfGjPxzYk4JT6TMrTQF+ew67CNXcguGBUpOHBSxgZYEtXhJobPjFZOnioUH7?=
 =?us-ascii?Q?8PV7GTw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MU9HdAT7Ogf39D+wmNnzG0z/3+tXpK6/qsfTlpx0wXU7SZlMB1kGk+p2f4JW?=
 =?us-ascii?Q?YQIzTb7kE0i3Z7hGudBtarmXwVhF4Xvkqvdwqp9hJPRA3wqJzpXjTto4+0og?=
 =?us-ascii?Q?KXKhAUwm1IjlKwSHpvQKAr483WoNTT8AOK+Rqoqiys3RSYvPxjGvmqwtsTvC?=
 =?us-ascii?Q?rCdyyBMe54WmlRjZ6tmuWZRf5zLwKR3jJGFivPfkqOKmqN4dehOpUF0kL3CW?=
 =?us-ascii?Q?s/mVqArKEmOvIAGs0lvrNXwH6e7Bm3GSkRaltNC6HKYNfWpcdrbFwEhGY/4U?=
 =?us-ascii?Q?2yS4anFS6pOnPGjTRxX3AvORK7gc6gMOB5P84J3te/M6SM9ONr/X+OAxa6J4?=
 =?us-ascii?Q?D0+7NHTfN98KymZyAzqmpx+TmVbx+KWMig8vZl3OIU+c03QTU1RA24daycxe?=
 =?us-ascii?Q?45107H7v80Ck6eQW/Xy4eUEof/OQ9/ueB1A9EmYAcZUgOz6buoqKw/rhuWzo?=
 =?us-ascii?Q?anbBK2+s+ntobQGxm9pdpZynGa1OxdyM7JMRRMa4BJm12NFr5JZ7qcCKrPls?=
 =?us-ascii?Q?N+qPxNERqCjNRbiA+syvmCIhG1hBxj1QEs0TsGIFAWp6SzM+IFYl6HD7+fRU?=
 =?us-ascii?Q?OVs4wInd6QZ7CvkIMxhnO4Iq61xiYG5sBsdCVrOiTEYTmuouBjwVuJieNotO?=
 =?us-ascii?Q?5QOvQiMu+nfcmo5poq1U6IE5OLmwQWDraE1pb4fiNeH5DjtPT18lW++y0JKi?=
 =?us-ascii?Q?SOMCAFoiuzd0O45ReLyLwBUIxXn+3Ok9SgQhtPg/FHHoEejGS07M9Tuan5xr?=
 =?us-ascii?Q?peZFZPpBVpZkfYZZvppF/dHCwSfEjIwp/EvW8J0SZAmyfvZdGy19kcHJYNQi?=
 =?us-ascii?Q?DeNHPkQ40I1W7yIJr1WHNglAfFjuh1Dn7l+X00sPWRSWPlaOF2b9HLUNnM+5?=
 =?us-ascii?Q?le70GbNsUVQMnY73Ys7JwZ/Kxz4uDHUCILSRvNvADnE1LLK0DJWORamiABIo?=
 =?us-ascii?Q?PzIDlXkMcWC+Y5/PYr/dIGMqXmDmOf92/fQWTojqtTt9M+aVaspvuQVnAO7+?=
 =?us-ascii?Q?tAk5AdI+sKSDzCaoic0YLtcsqzyGtFc+jssRG3uvrqzA4LQUeOPSnal7vuTv?=
 =?us-ascii?Q?VvYAvpsNy2gANlvUNGh/WF10v5/f8HEaIMAzSUGivcMnf2K6HhdEs6MOSbMl?=
 =?us-ascii?Q?Brz6SKLVUd6Pbb50mGd4pA7k+cB2A7aoPe1ZJz3VBlJcqSQrfLO/ARWucGY/?=
 =?us-ascii?Q?+3ytiTx6rtBM+MbYMpw6eErtm3ViuzxDm6caw9Fi/HEbwSRykBCN01u5gS/h?=
 =?us-ascii?Q?SHR/3+vEPrroeELAfr+Bcg2DwXed3FLFxIYUlaGFqPjgad6POnkfgPqE5kWk?=
 =?us-ascii?Q?ljm9uG1fe4lkFu4eg9o7AAeK9/s9PXkEbG1Opz8eAKssUfpEkZh1z/wtoKo5?=
 =?us-ascii?Q?7hkmScFnomdo+Lbrp2dodf16kAsXUBGqfUoMXDAtOYV5KBDSZNjAf3hmo/IU?=
 =?us-ascii?Q?DNTlzlk6b2UHy06bUoYWHEO6JgRiKTVi/r71txzciQVnce6B5KtH53IRkJg2?=
 =?us-ascii?Q?wOFlWP8peMa2PTtH/h2uGogXWYSKL6CimWI/SgPkCq9QWwbYEwEV1JJLuqcq?=
 =?us-ascii?Q?Ezn1VCOfAPJrZXh4TY8DQwEQCrheFOy+th8U5pmhKY8SKQPq1QkVbk54z0vK?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bda934-fe18-41a8-5183-08dd15d23a08
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 08:44:41.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Afq0elkG/213LUES61vu0c5rlEsrDmd0xnvCXAY1hGSDMzFhK/kgD4K+hKSu0HXyHTuyV8NaLCGJaameSlUquuZvrgUCabrVxy/SNE2YUWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7213
X-OriginatorOrg: intel.com

Greg KH wrote:
> On Thu, Dec 05, 2024 at 02:23:15PM -0800, Dan Williams wrote:
> > Changes since the RFC [1]:
> > - Wording changes and cleanups in "PCI/TSM: Authenticate devices via
> >   platform TSM" (Bjorn)
> > - Document /sys/class/tsm/tsm0 (Bjorn)
> > - Replace the single ->exec(@op_code) operation with named operations
> >   (Alexey, Yilun)
> > - Locking fixup in drivers/pci/tsm.c (Yilun)
> > - Drop pci_tsm_devs xarray (Alexey, Yilun)
> > - Finish the host bridge stream id allocator implementation (Alexey)
> > - Clarify pci_tsm_init() relative to IDE && !TEE devices (Alexey)
> > - Add the IDE core helpers
> > - Add devsec_tsm and devsec_bus sample driver and emulation
> > 
> > [1]: http://lore.kernel.org/171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com
> > 
> > ---
> > 
> > Trusted execution environment (TEE) Device Interface Security Protocol
> > (TDISP) is a chapter name in the PCI specification. It describes an
> > alphabet soup of mechanisms, SPDM, CMA, IDE, TSM/DSM, that system
> > software uses to establish trust in a device and assign it to a
> > confidential virtual machine (CVM). It is protocol for dynamically
> > extending the trusted computing boundary (TCB) of a CVM with a PCI
> > device interface that can issue DMA to CVM private memory.
> > 
> > The acronym soup problem is enhanced by every major platform vendor
> > having distinct TEE Security Manager (TSM) API implementations /
> > capabilities, and to a lesser extent, every potential endpoint Device
> > Security Manager (DSM) having its own idiosyncratic behaviors around
> > TDISP state transitions.
> 
> Wow, you aren't kidding about the acronym soup problem, this is a mess.
> And does any of this relate to the existing drivers/tee/ subsystem in
> any way?

No relation to the subsystem, but if I understand correctly the modern
AMD security co-processor that runs SEV-SNP firmware is a descendant, at
least conceptually, of the 'amdtee' device.

Meanwhile Intel, RISC-V and ARM implemented new CPU execution modes to
run their platform security software.

> Anyhow, this patch series looks sane, nice work.
> 
> > Note that devsec_tsm is for near term staging of vendor TSM
> > implementations. The expectation is that every piece of new core
> > infrastructure that devsec_tsm consumes must also have a vendor TSM
> > driver consumer within 1 to 2 kernel development cycles.
> 
> How are you going to enforce this?

Mainly by moving slowly and carefully.

> By removing infrastructure?

If necessary.

> Normally we can't add infrastructure unless there's a real user, and
> when you add a real user then you see all the things that need to be
> chagned.

What you see here is only 1/3 of the solution, and it has taken quite a
while to get to this point. Meanwhile there are several "hardware
validation" / RFC quality stacks floating around with the end-to-end
flow supported (3/3 solution).

So, there is a wealth of RFCs to draw from and have near constant line
of sight on the next topic to build an upstream consensus solution.
There is low risk that upstream carries something that does not have 2-3
vendor implementations in mind or needs more than a couple kernel cycles
to follow in behind the sample implementation.

I hope to corral all those vendor staging trees into a unified staging
tree where upstream-ready infra can bubble out of that cauldron, similar
to Paolo's kvm-coco-queue.

> So are you ok with the apis and interfaces moving around over time here?
> I think I only see sysfs files being exported so hopefully this
> shouldn't be that big of a deal for userspace to deal with, but I don't
> know what userspace is supposed to do with any of this, is there
> external tools to talk to / set up, these devices?

For this first 1/3 of the effort I expect just a simple udev policy to
say "for the 4 potential PCIe links that can be encrypted on this host,
these are the 4 endpoint devices that get those resources, echo 1 to
'connect' when you see them".

For the 2nd 1/3 of the effort the ABI changes will be augmenting VFIO,
GUEST_MEM_FD, and IOMMUFD ABI to coordinate secure device assignment to
confidential VMs.

The last 1/3 of the ABI will be guest side to fetch and validate device
certificates and security measurements. Here I expect work-in-progress
efforts like the TDM effort [1] to be the consumer of a new netlink ABI
to pull this security collateral. At least, that was the consensus ABI
discussed at Plumbers in this year's PCI device authentication BoF.

So I expect to still be enjoying a large bowl of acronym soup well into
next year.

[1]: https://github.com/confidential-containers/guest-components/pull/290
     (Samuel, is there a newer version of this somewhere?)

