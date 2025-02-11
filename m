Return-Path: <linux-pci+bounces-21245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9351A319BE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7920A3A7699
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE1326A0A1;
	Tue, 11 Feb 2025 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWvlicQt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7881F153C;
	Tue, 11 Feb 2025 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317658; cv=fail; b=PhmTEgTyZgVXh/y+DuldobVlIk1XUU22S5F9R5uPUnk12IuewD70+DKGNCO9xSGd0iGcIwgRl6PUbPFvVXaLJd4vIspq3mBUXCBTFlTGuAAQcakFpQNDa9roOHYcy1HOKPlAeFl+J8gTITMUPhNGl64qS1bNHNBaVDixGS7OiIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317658; c=relaxed/simple;
	bh=Mxl4f/6MFpO6fh2x92wcQIjIN5pS21nvld3wQN6AR8Y=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BwENWwB74d3bSTz1W+zzKMcKFqj8GjYgv8AOA3hLUUsl0OZk70Aof5owCeUnGQ2jSeCxBVPiJaGAjHz23r1rtsrksLnA68E8YLbzBih0bs+ChHbqaskK2AyIhidL/l+5FATwtz18sLG8g+n9GOLNqfFoufF67fZyM2s3MQfmv8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWvlicQt; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739317657; x=1770853657;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Mxl4f/6MFpO6fh2x92wcQIjIN5pS21nvld3wQN6AR8Y=;
  b=fWvlicQtl+RDSleVqmgOGHMWzGkGP8KehrkY9VGaGWou1iB/u/Nekzqq
   upk2TursMx6YOIh/q7naMlw13FMF3Ul6Fze1pJHP8CcW1xSYZ5uKTbvKX
   YVAgmCO43oWQwEC8ur+E4v5itoVx8Noy80W+eHKKoS500hWv73X322NPW
   hPU0pjhBIpOwerDtPiXOFnn/cClLCEvzX9tVOjjo739NECw+vVzlMYNw8
   6f66LUsEKsEzG36ZfsH45NPhkG5wW5r3OP3WdGJ10Rwn+kSX+H6M8Wj4X
   grbe3A/xe5YCNIQmfxOwuzgRmteVy8LndJcN/hJ9AlxNHgjmL88vKTkAX
   g==;
X-CSE-ConnectionGUID: n1VEES77Rpe4YwwJDjUs+g==
X-CSE-MsgGUID: 3wbKjftFRISUXJBnTB96WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50943723"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50943723"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:47:37 -0800
X-CSE-ConnectionGUID: HC4HFo5aQzaeti114HTlOg==
X-CSE-MsgGUID: OzvO1VuYQ52IIxOtTW4pgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112482567"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 15:47:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 15:47:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 15:47:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 15:47:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBTYJ0Q6Gv9q/FA3MDpvU/IEhmTXg5qKaF5niZAFaxqXyRjd8oLHrUaHbO5gXzYm007Mo0Jj9OFG5B4wDjqgR6vkA50n1Xar3pzUplHRqoYDDYyLFx48lrE0XRciLBjImRv3sog3zL8us1nx/yaZ+McxdTpwCuD4NChXJwfvU6Wk7YY5lKsEPEz3Eby9DYo4Ay8SPb/FK1/jAbO+E265Jm2/l4XmF8GKSN+w9espyYuAVaospPWXxqQdibYF8vvW7SUeOTuG5bDaeHTXI4EdczhsgIzx0PLkH8BRo7d9sthH0LdWdIGi7YWPuURKFaSIpqyG6FuKFvwfNqPyau+iJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyeVsh2WQMY7DmTqLDh4XSkiGFnrOfLWj40G3+jNHWE=;
 b=dIZtediO8GynFtvIfhF2h5fip3m4pwocrDLd7tkeA8iTAe/1ryuMWvCIWjJes38m/fCZmp74GHWXw+fEsc8XXibjiBWHEPQKqamGvDFbFFmKXOdMqjubO2BShTLY1DuVOH5ilujXWUCE02bAFH/zNv3Kuu42FPTLO8kSHhOqaJhMHVE7MHWX/t53ZSoOUpGVgy7o4Abp3MwzqsEx/SU6hKeVldnjjSxXyLv8Rl72STHvyJyUXyuH7L4rGQAPm6TDCprTw7NzYb/Llz3a4qyoYxUYQ5qdnKh+ej/KmnBULO9CCkNFNSh/R46BblZBPxTNWR0M/ArkHdCUYUvfyOa2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6885.namprd11.prod.outlook.com (2603:10b6:303:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Tue, 11 Feb
 2025 23:47:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 23:47:31 +0000
Date: Tue, 11 Feb 2025 15:47:28 -0800
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
Subject: Re: [PATCH v7 04/17] PCI/AER: Modify AER driver logging to report
 CXL or PCIe bus error type
Message-ID: <67abe1903a8ed_2d1e2942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-5-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:303:b8::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: d3194619-9b53-4012-a977-08dd4af6734b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aFw4rSU/kko9fvkFQKWLbYxXqDgtMIxU1VVUv/30n+vO8r5NCeeGsOxHpqr9?=
 =?us-ascii?Q?dDf+DCuy+tDIwjIEikuIfH54KfPt1YBrZfdXMaspfNmrsyRVO9bQdlXqdcjy?=
 =?us-ascii?Q?Pm/dbs05/dikbJ1VKyw2n8iEPbNgjr5+RoZM5lvnc0henPknU1lb1wm0uRlY?=
 =?us-ascii?Q?OFaAha4s4qycexLFj2VTtPAU/6qVSFoEnlfSmwCqn6AxiTu+5cWLLXF+iMI7?=
 =?us-ascii?Q?uIiJHaLwomNxlbIL2rXLM3MMRDBlDdqv8wOkKzQsjo8psyDCpHXLnDW9q+z6?=
 =?us-ascii?Q?2f3UFc6uKxK3iWzCF5dY6UMI1t4iQrcwBnn9XkNMSoxSciUs7311hB2qrfj1?=
 =?us-ascii?Q?A8RmoLovxCCmh3/77b+8liHjhLF5yVNnAKhIQTFRaAsU91k8FNcgArXDAI22?=
 =?us-ascii?Q?H6jkSiczH/4kGdRQ2buA8Ojh0cjbzVy3YdVdd556YW9Oz8eBhKYD4X4ifUM6?=
 =?us-ascii?Q?XJBOSzalLIbCicP9vALeX/nZJUEjcRZ0fnhvfa8fYo4iT3VJZWh6EJhRoWmk?=
 =?us-ascii?Q?HbYTgGZBtwDS2A35siB9PlcvqykHtPtd6OQbwKD8Ioh9/JCH9jN9Oji5gZ0h?=
 =?us-ascii?Q?PYsJtvGddmoYG5UmBnmcFPGOTW5uLK7lXrJrzh2KkP9pGw/Nju8O0uw4uodF?=
 =?us-ascii?Q?rSB8OjZuGjEPFWruOdhiiY9ShAYa4xvPx+WNj3wZA7BkelYSlCs82TWfm9qD?=
 =?us-ascii?Q?4NimfpC5LK7J1injmaAfYcM9DbSiDyLenEd+jU4B7LxQuIA2bGvMRnsEf9Em?=
 =?us-ascii?Q?vNlejCCDKNwzM65txx0vwie94LzOfqNSMD1/NvUY/d12nYi3NjWhxCOf9md+?=
 =?us-ascii?Q?XYQiVRLFMg4rk1aZe9NeDKEioUoc6UvjhjANIQyj9s+T0pEKPo2oz5bdk556?=
 =?us-ascii?Q?UMhufWbrsdGxxXRYEfsKAtXH6LGfXtT5PDnOo9f/RqrgWPtfKin8bOfnY22o?=
 =?us-ascii?Q?xImVAU6GXxph0csEOAbL4xKn66cJSCAt7BreAHnkJYR0vTjSko17trh1LwPr?=
 =?us-ascii?Q?nixdlHzRBpKQ+mBvhJbANbx9t4B1B2jFEb7CoJNB/1o303Jgg30RCGawhJ+p?=
 =?us-ascii?Q?LcC7VSHzHfgyb+oH8J3NpvpmcVzMbkH3EFMGH+xUEW3IGgOH5FK7oXhZghIB?=
 =?us-ascii?Q?Tlfqh4dLj+S/s04dRiWhyGRkFTzKSugpNfmsJxZnUoif53rsjqH3Ii9wlfJe?=
 =?us-ascii?Q?W8qIeCXeDQLsePdiD2J2wLYKSSij2lp39sia7fiz8XkK/3Tq+qjANn29qjsD?=
 =?us-ascii?Q?keXxhHhiUA8o+lRwTNOO3A8T3yH387aqh6uExz0++jKWENOVaWPiwDM7/bhy?=
 =?us-ascii?Q?J06TVezqiAeVx4JBLOeBwfJ5HT4P98MhkFnNNDIqRMa7JWVOxbMjES2o0QpZ?=
 =?us-ascii?Q?+OUKunsUPU5eAGUMC9NJsMNUXArxb0YbMWrMgosACkXMYx3mjWWDmMIJ9fqK?=
 =?us-ascii?Q?kq+FoRl/Cs4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BJ2kZfyxLcMCh5z8ObBj2+i1J12eGZK90vWUQFSHhvX4KGTyPb7Jb9bMCUfZ?=
 =?us-ascii?Q?BfkncdM0kvg2MooB9IFHNoB0t5e6qM/RM9XL7BySPVmaaq33HVOqafuFPU9j?=
 =?us-ascii?Q?BzKeB4wV0b5YD/HgkJemeIDBop0ML0J5VY17sUISacJ9keR5B+vnFxBrrucK?=
 =?us-ascii?Q?mkRzkbWYHgGjaig8xzi9giySGQQQeeH9gCUR024q3n2+BGT95D981LGmbJx9?=
 =?us-ascii?Q?JIYZsf9YsKzXg1KYs42qZhw1o7Cf03lfi6TBlFJEoTSM0RKReTu+ONsvDp0m?=
 =?us-ascii?Q?EINXZsw4FHsxc87RVbIGFyXzq/CPSVBYgbKdP5UrTvofYsFgVFd75UA31i6T?=
 =?us-ascii?Q?/XfKKrmzAOTtynFInNJKgAcSQJyPutx2Y+Fdz1Ew+VOGSurHw/Uu7rlhGgIJ?=
 =?us-ascii?Q?xR66sVtdjaTht/bB0DiLtv9HNF+NZMrpVpyAK0R+vlis2326dNPAgFadeWYs?=
 =?us-ascii?Q?J5radtr9XmiVAZmG6OQT0WMJp8HLM3ds7XYT+/386+MJj2aMFPC9ry/c422b?=
 =?us-ascii?Q?PNBNpvc4JTh2mc5GEIOOjx6Aduf69J68LgXkHe65hB9/9keQWDotTUzoLG5i?=
 =?us-ascii?Q?rYaadfxotg39Ze7wmQZDNSg75sRqqMfEh8865YGVdvx7PxEh2NoNfLhmNsBg?=
 =?us-ascii?Q?axbxNmQqNkkklUgi5G6YOeybfqu9u9fFTQ80fNnSJJm6BD9sK+2nsN/xAahS?=
 =?us-ascii?Q?6kEVi5qgDh9aZZDrMAVP+Y+ZpsWMaipzSADPl6sgA4E0wNwrVVPR1QbNElfE?=
 =?us-ascii?Q?CxfU+lBKHB0KpDn5gdAl9zT16rGmAC3J5lPnmrfhV4A8wUTJM96DWDyFPBvU?=
 =?us-ascii?Q?rnPMXaXn3hH1bKNQFEWA00qVd2KjQr6vrhSH+6Q16PssHi9mr5hJPcq/LSk3?=
 =?us-ascii?Q?gVOsYx48nC8sd/+R+TrOS/XrT87jZhVufpXldQRsgheCl7EhBV9LJFV2uiyd?=
 =?us-ascii?Q?VTG3IDDYMp9dX4VhGGRXw5lMjpFI04TDX9LpruKUJYaLIbPDzfMk62JvOjCG?=
 =?us-ascii?Q?O69ItVvBELOMj4LZEuT5oIhwcAg6aBg5uBJrZGFkAlkTgVyzAvgHJnldB3Y1?=
 =?us-ascii?Q?outjCp0ixITa2Gy+ZBjXugV8YdeVrzy2Ig8kQs9L6KWSOoKe+QW5R9mz5XJA?=
 =?us-ascii?Q?UBlsZ4mW8QacA2QVJco6+lnC+yUxXkMCh/2+WSNR/ZgM1xEOeQSOmrgnguwB?=
 =?us-ascii?Q?TjCo4rFBaQEEvCCNAQq+LpnIdXpQIoEqTo9XETBUUHQEsJnAG0sARihAHOwS?=
 =?us-ascii?Q?nls+dHC/NQGDYQkG71yTd2lXjlVzsq5n0IMjuxgCRsxoL5lZ2mV/Xa4sFGKr?=
 =?us-ascii?Q?5TC1T43qUv7cGRBMzNc3GqJ9Ojl+FgYUrfPz0eZpt+GnyZjKmmKYFTlKNwyE?=
 =?us-ascii?Q?4FOKw/QN3FohWdQApSeR8aEc6K5iIWvSb2AphgfcJFClhR4SfeQJ4heEWjWU?=
 =?us-ascii?Q?gHIUE4XltSDXI//aD4+eWFKwvjp71A9PZiGWCCmJv7d4wwNXx/cm+aF9msvS?=
 =?us-ascii?Q?QpliIJoqIN1MILpqvT4ggj9f8IfG0GOr6zBYm7enJWWyjOZ2AqxEgUnrPG82?=
 =?us-ascii?Q?hZ4UF3xEAnnQg0sOQhc/KpuX4FEeUxlzB9XMA0ikCdUuyDiUWJQEr6ZMKV2M?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3194619-9b53-4012-a977-08dd4af6734b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:47:31.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OiSPm4eEDKbnxvtY2pQ9lK9Z9mtTAogIRwckppb6QFWdnBja+QPGRz/thDJctGhN/R9KsaU/kutnw7I6WPLK5LI+P4DlyZ7FGPIlbnlk7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors.
> 
> Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
> device errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/pci/pcie/aer.c  | 14 ++++++++------
>  include/ras/ras_event.h |  9 ++++++---
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6e8de77d0fc4..f99a1c6fb274 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -694,13 +694,14 @@ static void __aer_print_error(struct pci_dev *dev,
>  
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";

I was expecting that this would be more than just a CXL link check
because CXL AER events are only a subset of the events that can trigger
an AER interrupt on a CXL device.

Also, with CXL protocol errors the TLP log is sourced from CXL RAS
registers and is distinct from the PCIe ->tlp in 'struct aer_err_info'.

All that to say that I think this patch probably wants to decorate the
bus type in 'struct aer_err_info' and then use that rather than just the ->is_cxl
flag of the device.

In the interest of moving the patch set along perhaps just do something
like this for now and circle back to make it more sophisticated later:

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..eed098c134a6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
 struct aer_err_info {
        struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
        int error_dev_num;
+       bool is_cxl;
 
        unsigned int id:16;
 
@@ -549,6 +550,11 @@ struct aer_err_info {
        struct pcie_tlp_log tlp;        /* TLP Header */
 };
 
+static inline const char *aer_err_bus(struct aer_err_info *info)
+{
+       return info->is_cxl ? "CXL" : "PCIe";
+}
+
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 508474e17183..405f15c878ff 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1211,6 +1211,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
        /* Must reset in this function */
        info->status = 0;
        info->tlp_header_valid = 0;
+       info->is_cxl = dev->is_cxl;
 
        /* The device might not support AER */
        if (!aer)

Other than that, this patch looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

