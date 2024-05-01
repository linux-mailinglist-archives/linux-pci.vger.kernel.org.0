Return-Path: <linux-pci+bounces-6972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB168B9032
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 21:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8566B282EB8
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 19:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAEB1607B2;
	Wed,  1 May 2024 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOloPSyp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AE182DF;
	Wed,  1 May 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592840; cv=fail; b=otAvDpPMLaJkYmEazzY13xHLalj6gZuI0gx1GpRRW7283CK3AkcDZOxoEQ3c7t4p/WjaY7Ql20v+Xh/9uPxeKY1neP8IYXZNdQ0t0KkZVYPPbQ8F6xWgX42wzXOfm4sk3dX138+Up+VjPhg7U7l/7EZ72u9nK3P14ocD1jJo1/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592840; c=relaxed/simple;
	bh=ccO7TjMz5KTqlbYATYftHqekswioGA7zqYJLI2PQCuc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HVwtjRH7iK0mw9UTHCVmzbBGvEEzhNFwp16/406nV3ouZRkLCxQDyPwa2DHEOzv3YBnF3TJiFxUVrmZGKASsnM1vToAvNPL5SSvjB+1NMzcUDdxgVphmoeoT+t2XNNI5ICyzwt/fILCEa9sLT/1lst2+zugPFww6E+NJ8RhBlhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOloPSyp; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714592839; x=1746128839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ccO7TjMz5KTqlbYATYftHqekswioGA7zqYJLI2PQCuc=;
  b=mOloPSypED9hHHQbpGdIS3PmFXZjDHgftDPCZl6AqmDYvP3Y/NknUeF4
   iecdoDOoxlkPiWODpzTnIu47UmfbzhJgJPpTJqNZxzV9yhos8Kt8dIXXv
   +AMw9uHbuv9iAUyST/Ls+aVGCTLTaZQ+e6dcthQ1Bx3A3jKBI6M+F4wXO
   BOhh7uv2bFNDnuOkVO2oDi524gm382U40+5cWvfenjCUfU7RgzzwMNIwo
   LjzNMi2zo5LSv9oh+kiuRvyV82fQjCmsduRDxLEl95iytfIKrIgz7Riwm
   QveUzSMC9TS4l2VdKgldYjvHjCXA+TXtmi0Gr7cSUtz7eMO/b2inA8Qq7
   w==;
X-CSE-ConnectionGUID: 4a++fpXOTSa4UkTy/ilzNQ==
X-CSE-MsgGUID: jbijygv1SFOcXCbhGdL4qQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14162722"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="14162722"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 12:47:19 -0700
X-CSE-ConnectionGUID: SuTJzio7RB2XDS8PfdC5sg==
X-CSE-MsgGUID: svMLpvhcRzCGxImur9NJFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="26964789"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 12:47:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 12:47:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 12:47:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 12:47:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 12:47:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTBb8LseyNtbjNWfejMagCcfi+OUaQUCzKsOfWBvBKVA1ekoqgByFmOBF2HaJSpigfIkUotXdXpd2+8iOcj2n7L3jQnAEh9SSNOe/fPsqukj7mgZzPaCgkfDIa/5uIslNpF8M9uHuTrj4WCT52F5HvFx5ilsABT3ALO1CzXMqV7kUSLCWU0/KtBJt2TElSN0RpkLhNGEJvoKtNXTjtG3nz2Y9yiJQxbCsJSlBlERivZKSOoA/Qw3Oa5megPbY0dqiL2vI8Ie2PjuWvMAhCfgFnD4V2REL9D0Tig2ItkDRz7Dj0qrkn1LJ6gttXh1fjD7aY1y+LZK4VS6XFhBnz5I7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uRGF0rwfmcvEIVWaq022EBRWvstHhPryPIdHj/tWGY=;
 b=bIdeasj7MagQEar0MVtFHxGM9A4olnH6viMFxHMH9vSdDPyP4QNz6LK2w1Pii7TeADIzpnQCSHMhbMh162e010pmLPxunqqP02ekR20aBRKtYcSS79IIvZ16PolQhCuvQ0sbr63Ad3OuKanpB5BqAF33fruH7aRLeRk2rdzSFEaYArhqSL9x7c5Dc0KC0mkK88VFEBwMrsByIl0GPVdcgiwM4L+LoQkiwqmGAzNAmCNEpiNyfKsWotm2ueYe1yE4tI+rJSC0aetQGZ9VpcV970pD1I4h6eWf/mXNluF0DrkhwrhG1FTxbgH2ENMyvZdQZqNK5uUNilAPXZumSQ75Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 19:47:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 19:47:14 +0000
Date: Wed, 1 May 2024 12:47:11 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5 2/4] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <66329c3fe094e_10c21294b6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240429223610.1341811-1-dave.jiang@intel.com>
 <20240429223610.1341811-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429223610.1341811-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: c0adbc10-f237-4c79-d6f5-08dc6a178014
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?clLpWmc1Rt95aXLdUkYo6+GZTyYqV3AbKkHZT5UsqtvdbtF4DrKNwCxLjTuB?=
 =?us-ascii?Q?4kFlSbbQ7cL4y+KhXM9fbsOCCMwLYWUoBaDeAkqTcSNtm3ekrIbs2k018o0J?=
 =?us-ascii?Q?AqWMhnA7Fzby3ZB5la3YWBpykp52y2TnQbr57ZLsnDatLHrOsLyJIv2099AA?=
 =?us-ascii?Q?yLbf0An0wWxoaURGLcgeaW4jX9UBQMUhJa5QzpqOMa2rti7tubvZO2gljhkU?=
 =?us-ascii?Q?ZDbOscmOKyUDm5T3AE8ed6IWDdMK0c2tGtnyq14CzCuuvkkcUGKBrIJD6qX8?=
 =?us-ascii?Q?KqDJm8npXG22dQTDS5rVbiipI23rhS2A/zkwWsLwouNa7Arhqs3RbY5PTO93?=
 =?us-ascii?Q?aWhi6SGDjLVf0ysUB5iVcJ4mp5MLJpi/4jk/WSB5Z9bPYY4Sgzr2+x73+ipF?=
 =?us-ascii?Q?WkBrF4MdNiouS6iiKPuQ7JdYIdPWqxN1kiA1Fb6XSXd7yFkycM5uIyqYMUIS?=
 =?us-ascii?Q?bZksLLv1FnVMX7/+hQHuDYIWGoD26Ge8MKIaWUSU7yg5N2r0H88G6g63vMpk?=
 =?us-ascii?Q?i7dRmHPb5zn09XepJ6DBmwWVc97+27pApMsHpD/lQgwtACKHw6xomwLdKR5H?=
 =?us-ascii?Q?4WSwpbS6Nf0RLwgY4f78iJ+8dOj3hJv2Pvd57QzxvWoPBAZKP/g0E+FyWrJs?=
 =?us-ascii?Q?MLqgDK27Bp1dnEpAMsngpUgY08UrLOB+wHCw/YS7Pf6wZoLSNkc9n275XfcU?=
 =?us-ascii?Q?dAqUTeal/rlZeaW9ZLNaAx4/9LpHy0cA2B1cf0SCbiHx02n+Giq3hw2Pp89P?=
 =?us-ascii?Q?13ynFCoYepxZcC4BaTEV5l594uiQKxczC3pHhqyA6xW0CkLj59NCquFvWULt?=
 =?us-ascii?Q?twoK6gvRi7adTpSbOuwEPiCJIZTVaTk4So2pH/k94frxGhruSxxnpU4JPlOF?=
 =?us-ascii?Q?rEWayCeYE2OZqBd4+fJXrK1Xv9kw1t+n7CJJWfs907ngcbYVLjzSeDH/JcuD?=
 =?us-ascii?Q?+ELR1h+XjQww9fbLc5BvMg3pB3w6HMF6u5GlDwHfktT9KsIbvLqPKzgtNnZp?=
 =?us-ascii?Q?rjwez2O4vrUGG7RK+M5hZs0TH/MLTfGWHGnqkgiNNK2nwrgn55Zs9Zemd3b2?=
 =?us-ascii?Q?+NqTlaHOB9xcu7yfmYA2Bxp+tOL5tIw5EqB22J8M+djHiItPU3YyVu2XFPS8?=
 =?us-ascii?Q?wamZykWNix4nMAiIXMTmaoStJb/1lznGfdqCU1X7z32xZlL2we90D6wtl8ad?=
 =?us-ascii?Q?dOp63OToLGqnzoo/+ypROntkE2RnkW/RkmJGkqYn1EJ5eUC51KrMoLJASKaC?=
 =?us-ascii?Q?2RQ5K3oLsi8f8Wah0gor8h58ejpfjGJ01niAojyG+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3mqujF3y6jJyVh1EJwtkL7it+2ln7Akto5mIk+c4zq8CzyGwbn6cbe/FtM19?=
 =?us-ascii?Q?ty+89Mi+VVHUY9cBRaHBQYbjn9pk9vrpzKArKNidgcQDByGLudWY2q3nlsGE?=
 =?us-ascii?Q?gsPjZenkdJFlSwTgA0053s+5ZgE/Mn7CjS1m0Hs7vRJvw/xmYkbVshbveJFc?=
 =?us-ascii?Q?ivk7tLwPoWEnvVDW4pv5qEzG/WXPN7QJvmrMFK45NwYWwNlQpphJ71eZgkKZ?=
 =?us-ascii?Q?BsTGaGC9l/mC49zfqj9BUjnjx9QjIohpElfl7regAKoGmcqiW5dzUOrz6VD8?=
 =?us-ascii?Q?n6AFeU4wCTYx0h6SIJ/892nFm6UzJ/LmEc+ky+AGDxHxH9v3leGchjH6J4Vy?=
 =?us-ascii?Q?XmBNtZ26DhOIwwWJ4Ec9pYFLxf8KUsFVCzQKrYryca3XHtoUAzW/kF7FdhUu?=
 =?us-ascii?Q?frQewmOgWsUGezCa2pgrEwaOk0E9MlFkb145migEGePDNXcZcujXXGVNvXpA?=
 =?us-ascii?Q?85mKRpGsoT4koj6UrLvo9KKG4fgK7DlZ1upMd5U29LKSmlchxJgFiOqjvFsv?=
 =?us-ascii?Q?FiT+TWmJHV5OcHMlw0DyZ425xFZFMXfZ0++aa4C7QPsRPGWsyLpzqOfX0i/8?=
 =?us-ascii?Q?cLptOgFHR6Pfwn+dkVmsl3aG0I/F5bBHKDXHCz0tdQCLzeKh+cpOrQMeq7pZ?=
 =?us-ascii?Q?iZbHAzNYJih6WnX6ZeO+xo98WXReue8seRhI7VAFc+VrcssPGEvsA6X5oZSP?=
 =?us-ascii?Q?b/EucqaHGh8bWXBGCi8BiMs54axjM3bS1f0txHyGEKtLPiA3CPoGF1mJZ9Nm?=
 =?us-ascii?Q?A/wHJJJtQ9magu9cBEkbWV4WVgSieFjq8JmtXGn9r8Hr/NEbu+UB3sRXFQC4?=
 =?us-ascii?Q?AuIK9QoF57WO6poYbzxGv2RzTlPTManLfZoFA+Gfg1ct5/DeN5dpvvsY5w+s?=
 =?us-ascii?Q?TW/jvwRmj/MKdBbsd1kGxfgy/W4OS+TJAcOaN9Pa9U06qCBSz8s6fveAGfjm?=
 =?us-ascii?Q?qFbJx2t2WTrb5+QPLSprGkvgeHLXeGodrzyH5U7aj87q9FHqsqU5UxdU6sHl?=
 =?us-ascii?Q?8z/KpgcYp6Wd5/NfEKmej8lf1IIBvrpZa95yHevp0vVu4tObpsQ6NzGU/+0I?=
 =?us-ascii?Q?JR7czu/R+xTkHK6VHwgsOzOFlWPYcnB4a5whfpyEIIMZkVRRSkCZ57GQpvBA?=
 =?us-ascii?Q?heQg9qf1g6rZQmP6br0mq/2iFlCBQ9MBzP4ax/FJws07jDOltqclUNzqL70B?=
 =?us-ascii?Q?7wLjVJViXP8+q6oG6gKwFM+xMPb+MNhS1agDqa4lS7cpYoaIhvgAUDEmnn2/?=
 =?us-ascii?Q?iZmTveTq7bLam3eoEKhl/nZ0TxlIdLzIdiPzTWzmWUvyJUpXAhE9L/DHN/xG?=
 =?us-ascii?Q?ZkcdlXCeGirXTlHPJpIWZdrCTxDW3wwJ7Ai1LkxuyXiOOZmXEElztn9DZrN2?=
 =?us-ascii?Q?FNn3t4QqNRnGu0coUfmrmoTwrQj4APV27cDiGYHeu553Fb5geFi4EkDrwZUR?=
 =?us-ascii?Q?HvQqdvf7k5gqs247+l2omfSN8fuI8D8+EZ8MgHAP8I6o+kg4J7yxjFcXDWEd?=
 =?us-ascii?Q?h3NkN4TQY8epyoPQ0uUGqG0vVek0vWpPdvnxgKxNAtJhRyiEoQERa5E0DyOQ?=
 =?us-ascii?Q?c3N6un9Sf2pUtWznqThHJKb9IQhyXz+UW6kbmiQj/iGBJWf9vxvLBNmjWC4I?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0adbc10-f237-4c79-d6f5-08dc6a178014
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 19:47:14.6778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ie7oERlAeMITbW/4sZWsokYd3XFdzPHNpWKvuMbjnvH6jYr11Tvv9e7BXubt0b576N4xHs13OXvzcCpJtoqmkmydrgW2Y5Z6u2mi1OWHBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Per CXL spec r3.1 8.1.5.2, Secondary Bus Reset (SBR) is masked unless the
> "Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
> path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
> the CXL Port Control Extensions register by returning -ENOTTY.
> 
> Otherwise when the "Unmask SBR" bit is set to 0 (default), the bus_reset
> would appear to have executed successfully. However the operation is
> actually masked. The intention is to inform the user that SBR for the CXL
> device is masked and will not go through.
> 
> If the "Unmask SBR" bit is set to 1, then the bus reset will execute
> successfully.
> 
> Add the locking of the upstream bridge in pci_reset_function() to ensure
> the locking order of locking the bridge then locking the device. The
> bridge configuration needs to be consistent for a CXL device. This should
> not impact PCI devices.
> 
> Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Add locking of upstream bridge.
[..]
> @@ -5245,11 +5290,20 @@ void pci_init_reset_methods(struct pci_dev *dev)
>   */
>  int pci_reset_function(struct pci_dev *dev)
>  {
> +	struct pci_dev *bridge;
>  	int rc;
>  
>  	if (!pci_reset_supported(dev))
>  		return -ENOTTY;
>  
> +	bridge = pci_upstream_bridge(dev);
> +	/*
> +	 * If there's no upstream bridge, then no locking is needed since there is no
> +	 * upstream bridge configuration to hold consistent.
> +	 */
> +	if (bridge)
> +		pci_dev_lock(bridge);
> +

This change deserves to be broken out and merged separately because it
is fixing a long standing locking gap for missing pci_cfg_access_lock()
while manipulating bridge reset registers and configuration during
pci_reset_bus_function().

Yes, the CXL reset type adds SBR mask management, but that does not change
the fact that PCIe SBR is inconsistently locked.

This builds for me and highlights the expectation:

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 6449056b57dd..36f10c7f9ef5 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -275,6 +275,8 @@ void pci_cfg_access_lock(struct pci_dev *dev)
 {
 	might_sleep();
 
+	lock_map_acquire(&dev->cfg_access_lock);
+
 	raw_spin_lock_irq(&pci_lock);
 	if (dev->block_cfg_access)
 		pci_wait_cfg(dev);
@@ -329,6 +331,8 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
 	raw_spin_unlock_irqrestore(&pci_lock, flags);
 
 	wake_up_all(&pci_cfg_wait);
+
+	lock_map_release(&dev->cfg_access_lock);
 }
 EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..63086d97eb90 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4879,6 +4879,7 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
  */
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
+	lock_map_assert_held(&dev->cfg_access_lock);
 	pcibios_reset_secondary_bus(dev);
 
 	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d89b67541d02..2f178cd6e723 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2544,6 +2544,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
+	lockdep_register_key(&dev->cfg_access_key);
+	lockdep_init_map(&dev->cfg_access_lock, dev_name(&dev->dev),
+			 &dev->cfg_access_key, 0);
 
 	dma_set_max_seg_size(&dev->dev, 65536);
 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 08b0d1d9d78b..5e51b0de4c4b 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -297,6 +297,9 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 		.wait_type_inner = _wait_type,		\
 		.lock_type = LD_LOCK_WAIT_OVERRIDE, }
 
+#define lock_map_assert_held(l)		\
+	lockdep_assert(lock_is_held(l) != LOCK_STATE_NOT_HELD)
+
 #else /* !CONFIG_LOCKDEP */
 
 static inline void lockdep_init_task(struct task_struct *task)
@@ -388,6 +391,8 @@ extern int lockdep_is_held(const void *);
 #define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
 	struct lockdep_map __maybe_unused _name = {}
 
+#define lock_map_assert_held(l)			do { (void)(l); } while (0)
+
 #endif /* !LOCKDEP */
 
 #ifdef CONFIG_PROVE_LOCKING

