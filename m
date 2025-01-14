Return-Path: <linux-pci+bounces-19786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C5CA114F0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718B81889554
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABFE21ADD1;
	Tue, 14 Jan 2025 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/OKlaPY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244D2253E9;
	Tue, 14 Jan 2025 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895855; cv=fail; b=U+HoJ4as0xtPVhgTNNd9ZYPCd+96GmMUTm166IcMOkF+x/hU772RhjlWIdL0aRC/bLnwdnuRx4mGre1D/SRC91rPm/y6uEE26KKfDBeR0gZw1hJbnKbw3bUb0r1fgDxjUi8ye7j5OtiCoV4DeLSH8dhRL2o2AJl7pd/s4S8b6q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895855; c=relaxed/simple;
	bh=UEqFJbPn1Ey+/G2P1/yAgt6a9eI47dfttvTtuGcWfSk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7sJT9uYbuj3Z6oA0z7/38TMKhhpoIPkCDbGX56PbznRIloJBTCcpzhJmWTxdNpu0uyim63x5VqigJQiMR7kxWEB4ujUAB0gxbxKfFpY7VCdEpR64/zmWnQMVRmMdchhRzyZSyiipp1MKVtSkdO8SByQ/w7e9whDWX4EX66GcyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/OKlaPY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736895853; x=1768431853;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=UEqFJbPn1Ey+/G2P1/yAgt6a9eI47dfttvTtuGcWfSk=;
  b=f/OKlaPYlsHx78veT6QyoFjVlHoeIimAiGtblyT6dvlAUbntRH4UdNAY
   ocab9XIcg06DYqWmm8PNff/OdBdTdqIOp/rKhzUAFLopyVFlySY9sxTGX
   kP6+bHY28koua3A8rW/6KEkSKU8c44CtYgEhX+9aQ4/urRo75X5VWCIkI
   qWfYoKUusQhzzTkEYhCU03N04pJBDtmxg7yhAE3KddQ7t8jKCiTQiK4X4
   nCSCYrpt0T201H80LK9sxT5kIcib1gbd+rrHDKTzHbxxhFlPn9oK7wEZH
   Igd+xYWIP8ri38xhuKPqVfyOrUDYRHYNZTcKA0/GlMp1CJr8aZz0aKXck
   Q==;
X-CSE-ConnectionGUID: V5O/lKEcQIeH1XI4CpHlTA==
X-CSE-MsgGUID: NnBxnHLISae9KF2TzbYCVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="24815045"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="24815045"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:04:12 -0800
X-CSE-ConnectionGUID: 5MnVfDxXSVSOIn4MmgLwhA==
X-CSE-MsgGUID: w6xuXmhtSlqmvJpjPtuvHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110084842"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 15:04:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 15:04:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 15:04:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 15:04:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaSII2D+IieKYvz5mAAJvIdAUx6A0/gCO87j9dOhyeYY6619csXwj/r5mzL9SeeG2DSs7mFIY5UniSuZFWw+gRC8kno4ADpCt6DZT938/QklRPgHjlv6aHscSdt4qS7tDh719tfUY8sZwHFgug8VyU7O7As7tZ+zwJ+sdXY+r7xMbnuGs94VQmy5osqajBHu6VDaQo6euSg4CxNj4AtbYNAF9l5cSEdH563HYITuccCjRudBEzdahjblmpx+z3/5up3jGEw6NV2saU8/SyN5nowTKt207l8Ay7LHoAKl8kLPzH1HnDJG+weiQ2UtLgdjZmeHoEgi+Pqdh4Py428LHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxM1OB5ERmvnNHbtzdpgHOPZ99f7TX4W+M2HnLlB8gc=;
 b=A9YzcRU9Ci5b16O99ocAkfPyH5rdluLrsYZ1h20+dO/87pr0c7odUMPR1L36AGbjW8AkWr1c26QIobiORU4n2jUFMYs2Ww4PDASOwzK+t8oB1blU634fLCuNqvkFKYSRByt2WWAzK8SnCAFGKyuMy7hZNXDKYbMIOh+Nk+vmyH+yfHQaz649yQLdQ9ElOEpK3R2xTfp66/RCIQ8JpMA9PLzie2mIrNymq+sOjH0nIRNLJcYKss5fHzIDXqb9cXWHn2czcoXsu2zlGu252mAtgZbw0L4NN9Tee5uuaCa+l+qRYCx+/l72cdEqLHWgCaAZGF4O9WGXNI9Jijn5MX9BYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 23:04:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 23:04:08 +0000
Date: Tue, 14 Jan 2025 17:03:57 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 15/16] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
Message-ID: <6786ed5d55c7d_186d9b294a2@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-16-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-16-terry.bowman@amd.com>
X-ClientProxiedBy: MW3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:303:2b::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f47c344-40b9-4002-9a79-08dd34efc051
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bS+sqARjS7203jdiaPyzw1HIwmZ03mnSFZWiVs4wFDiWvO7gzpi3LgKy9Jw5?=
 =?us-ascii?Q?b1qYZhIC76berIjX6jZ5x897MWes+Dmg/WVuMwJDymCvSel0TAmGe6BJd1Y/?=
 =?us-ascii?Q?DohfNDUo79LZnLiJspE8vB4lGzgblCAEq8FBlpDf2aMijPmv8fSAqA3KwHko?=
 =?us-ascii?Q?pzIyU0ImHZMZ7mG9BgaQvoEMDTtHguPYxAy4++sqUMoGwObgSrTIVg3nJz8u?=
 =?us-ascii?Q?/JEg5LxnnqAgJAvbKa2qbZhjH3bkMdv4jsOEOkAtY9QqNtYncWJk8ArJ4Um6?=
 =?us-ascii?Q?1GnxjVMhn0FlyxBXQ+6PqzOKv8ivDP7sZrNBe3Y3/Bojw9mllBf2bAn/gPvO?=
 =?us-ascii?Q?3bn2+/UYvhZzQXYGX/DSRSZU/baWscz1vwY/m4mXCKENUNdPNrFbK9Y7A8R1?=
 =?us-ascii?Q?k0WSK/0J+9f0KTcC92awKDymGYsiEpz2K+yjGvWERHpmaJOSe3M3kZWVMyjm?=
 =?us-ascii?Q?6zrAeef2W9rMJGWeCa2rhkvOUl79h1nn+uI1QT46+wBHtAWO/NxrIkwJiXeI?=
 =?us-ascii?Q?OIdCTVYnHPV1KhmzUpPImnhOEHzW2H7DsLcj++1A1FJqOMNLixg/9L5LCEZ6?=
 =?us-ascii?Q?bO2VdUSnz8DZMXeUSBaVnuWkOBMUOjUFGNSIKrEvFGnZB/0h5yr1Qnb79ved?=
 =?us-ascii?Q?3NcrM3goqIK+oT96ygvz7dDH9kZDgYwICq9SjQIoOzjNxY/qFwApgOy3jq81?=
 =?us-ascii?Q?0lQomtxeoFA+LX0skrD6ogz3ON7xBMuRcnMswUyzqk/kpQme7oPPQBajNmIu?=
 =?us-ascii?Q?WYCbJ12X3Qeeag0u4S1ICVYzj11WPNGgXttFJPZoxa/+iW7uJgENsa02mqKD?=
 =?us-ascii?Q?0fQDA4M829hUxEG/ZliG2aYN+PUJQzotevDc73q3mTUMYejhyweQkEkPTDXI?=
 =?us-ascii?Q?TehBEKiACPirLvOfi0B+zvAvXKcroh0Iy+YrEteGfyNeU89zuRsRrASlQ/zL?=
 =?us-ascii?Q?KejITZy+WWgRJfVakJnaTNXgPrznUBNAs11SIK1YHn1Zz0XyzM1pGgOYvQs/?=
 =?us-ascii?Q?ydkmdHS2QfhU1qoB7M7VwzQd/XuIhSqb/hZLz3iQ8HlKiabN/tk3MJwBGJ14?=
 =?us-ascii?Q?mq/0YsOLjd/q7/Rn6u5Cw2m82k0grvqhWFr8+FObBUNdXtz7BK/L6xfixRMB?=
 =?us-ascii?Q?qWlySeTQciBWvTTJfo7oETr71vr+pWEXqUZ0z0URzL+nPiGMMR4GTYI8qUaB?=
 =?us-ascii?Q?c6b+xgCicmoVgVpRy5SQ4klHnnB0Rka+QeRHp/YD8hB+pl4sZzq3omjXvz3S?=
 =?us-ascii?Q?ljY+wZz0P0n6e8T++6JIhVtGaFDYVOrq3DJAdPPcNArnYVBjMaosVFt0dpL3?=
 =?us-ascii?Q?fMc8yTmXt7ZENR+hKvE6hE0HFDep1Ns7NjLUnQQHvmeaJT3jscbhjo9G2Oj7?=
 =?us-ascii?Q?SCiUE2EK9Q+VdA3h3E53ZTDl8O11pUPebJpM2NIUc+Cu0wQYk0NcoEcfAp5K?=
 =?us-ascii?Q?yEeGrpriWME=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BIxMVq9GUTuBqCUyk7AbDzlKlJQz3eOE/s1KP83aFL4LTIW2VJ6WqxWvxgXp?=
 =?us-ascii?Q?ZgG08eC1seYyEmHbtsJ4/Idb34wYBC6kcaRAza5ecRLaZGICIkloUbIknWg4?=
 =?us-ascii?Q?3VUo6Ya42bQNwiFCcYufsl8FWMgmevwxw7yiLWhji2KyOesV+vD8pcDZN4t0?=
 =?us-ascii?Q?IaMUY3Cfee1yjNQnQuWwmPwMVgUca5c50lqgEx8JKb6T6xkZ8gw37hsCaHkZ?=
 =?us-ascii?Q?nSSjPheW+tKe8QbcdoR9rmy5m2wB3974EtM0hz6trjMq/D/ioWzKHdo32lUg?=
 =?us-ascii?Q?Ps5Q7lgpxAKMMTpo3uimgHOws1HXzwvm7S/76CyfVvk7B9qIHyFf75ULg/x3?=
 =?us-ascii?Q?l5Isjp57hef7pVs7zACjfPMIlD8HlNrjI8FKeoVI1o2XxPeLCdPM1hKjDe/N?=
 =?us-ascii?Q?tQhs8VeR/ikzgcPFyEt0OKtl01nK+VWGtcoN3FLwU7Zf+xStLrmYTyfUqtQB?=
 =?us-ascii?Q?+CAqThhMpWTUuXzmo2Z3yPMtRicK7qmjMIpnqcm4SwHz4O+A8AvDSiY1K9XJ?=
 =?us-ascii?Q?zbXjkolz3bzB2LKd7etMlbMt3rFl6/qjWLSnwnevP8VZxgjYPnrvNUSUrVJC?=
 =?us-ascii?Q?Hm7rHqGZKoOvIeTHHX99uRZiXrMKKni86WghrWazIW/4owA37Mvd6YOBrppG?=
 =?us-ascii?Q?8IhWOZ8ytymcsImnqb/2DxjCYYI9SG3FvlC7GyUtsybAjTHnJeTRCdnC0JUQ?=
 =?us-ascii?Q?R6u4mEzDVs2Kg9Q97Q6/WFCdlMY/ywZ6GiCTmsAxr55GsozKhOt9xbW+TEKh?=
 =?us-ascii?Q?O2MCeiVrC+yaEPr/5D8NqYp0q2Z2sBiicQXZI/3QSAs0xGo+R9yFojo1XkfS?=
 =?us-ascii?Q?5x8FOGhdswYxxp1DNs3r+QnqNosdVfdE0EYNkv9yfbTKOoahu33cfQLTb0D+?=
 =?us-ascii?Q?vEe3gkyW34Ch5ADuPt4EZ1JYU/5ZbhYlcz9R3Hask5OIa1IjT/pgK4ZRoY9u?=
 =?us-ascii?Q?rqh6FPVlCIThSvwzTmppclAmi9Mdt8VIYj8YyDG0xgwoDiWaMUoAR6gHSEdn?=
 =?us-ascii?Q?a/LEKyIt8BMM3qy4SKt8hzCAHK8nwK9gNDYz7MyEh1eIBXWtJqyNAYpsfjIU?=
 =?us-ascii?Q?FR/bWJDU/HJDiBdQz22rPXE1GMSESYVUxSgWYmAMFVtMnsUmN6RSWK3lgrvS?=
 =?us-ascii?Q?NHt9R2L/n/0tRkVcMsiHxDfmdjSUwwa97nbpE7xEdMn+q0WBSoN2V8frPwj0?=
 =?us-ascii?Q?4ZJCBdYxJcIk8HrZPkx19U1TpwqCdJZDmdLIa/zuBSS3dFjAWy1JeRzQzlnj?=
 =?us-ascii?Q?xRkWrJJVd0u34QF7jwst7XbcZXB5ysuZ80AXMKqq8m9G/96FgEvqKHggDHDU?=
 =?us-ascii?Q?Nl4Invl6RQ+/0QE9ibwZHC+mDYmE+oEm19frasrIZOa3QaSh+KvfczPm6O+W?=
 =?us-ascii?Q?1tqfV4afIgrVOruvfbArzKLgloDv1Sw93WN6CdqVNEnf17Ve2Y/Q8H+CPXQv?=
 =?us-ascii?Q?wsvJjyr2cbuAOdr2CKsA0rzvPfvmwzG/XV21AhSIjtf44S9cpjLT7eL3/dFC?=
 =?us-ascii?Q?0oTVe0orgZS6Ig9RK3UT/vq78ddVJ8UrWzFd0m35pNKUlfa4f9x1bwynCYl0?=
 =?us-ascii?Q?boo4r2IkctXjuSsJ+YuHotEroeiAkrqNQ5UOdJ8Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f47c344-40b9-4002-9a79-08dd34efc051
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:04:08.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8pjfCNoy7d4kmyDJrRmgD1bBm+bPppRlcxXJRY6iYh11QaIpjaD12KCz9vhm8yzKgYtcPIA4L2MrqxxHKiT5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
> The handlers can't be set in the pci_driver static definition because the
> CXL PCIe Port devices are bound to the portdrv driver which is not CXL
> driver aware.
> 
> Add cxl_assign_port_error_handlers() in the cxl_core module. This
> function will assign the default handlers for a CXL PCIe Port device.
> 
> When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
> pci_driver::cxl_err_handlers must be set to NULL indicating they should no
> longer be used.
> 
> Create cxl_clear_port_error_handlers() and register it to be called
> when the CXL Port device (cxl_port or cxl_dport) is destroyed.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

