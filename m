Return-Path: <linux-pci+bounces-23349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3134A59E32
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 18:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B64C7A84FD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 17:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C0A22CBED;
	Mon, 10 Mar 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBgrvaAB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0B230D0F;
	Mon, 10 Mar 2025 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627736; cv=fail; b=oQBgQRWLe3eo66REYk6ouTmNZUnJVv/POPFW+7XDHrd36fzoPK4thlXpFybcDO0fKi8aMMr6MEIdH7afn6TuCVQUP6fTzSYjPXcOxTi/adX/U3Rv9zHcQq5d7qwkU7UP5IPM8HVtfPgy7/7/i/gj2GxGkYYFzI3/n218PKzt/GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627736; c=relaxed/simple;
	bh=w17N3N4Ss8YQmZral/E/q8CtLAYnmfb4lhrLY3Gur/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KrdYDsc6aaSrshWxc9TCyDAiavPpWCyBH5NDW3wU2yzNmmOM4oJL8uhHDhUisF2Z72GaxNPZ4IZ44VwpVVbNIbLuFQRlc74omxoWtGcfWPaXNnzaA/Y+ozm6rbZz7JAoOAAp+SuQBh5sWRLI716UcZqEGSXGsyCqnd7V/QFD+AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBgrvaAB; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741627735; x=1773163735;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w17N3N4Ss8YQmZral/E/q8CtLAYnmfb4lhrLY3Gur/s=;
  b=cBgrvaABFX7+CaCzIbB5sxwZ2gydsDv7TlvWve/je8+tRD8GU8uHgFbq
   j4tPCQ0lBh577vsVrhKBFJvkXOV9EQMsPcBkqJLjSAbRoAMIVYOSBS139
   XgkcXdxG0TflX3/8pDodl3xovAVXC/7iNU+a+cd/sP+zOZWUWN58LtPco
   lMLHPrNdf6xw0Ysf6Ss+iYNyokwTwRa++T9nPovBJ0pB7Wo6i+/TdUGCF
   hOhtpNFR6gtj8x9X+L1GsWi7HoEPqiBNA6QZ7M+hLUzCLO030i1226Kpz
   ew/7SqbOWJQsdVLJ18ESEkeNRrOT+OKTA7zj9me2WhLAx6CFfy3xYZQTT
   g==;
X-CSE-ConnectionGUID: KGjtUIPHTJyfWY4xf10DNA==
X-CSE-MsgGUID: bzKFu4DgSBGrLELh57BVSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42670803"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42670803"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:28:50 -0700
X-CSE-ConnectionGUID: GdmQBfaRTAauy9IOJznb0A==
X-CSE-MsgGUID: SSzUkA0lQyqr05alT2MULQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="125278651"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:28:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 10:28:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 10:28:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 10:28:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mY2VMMIBXJwlX5+x+GwCY91QViODIRGHBa4iHgXasQsEx5XrtnTE+cS6IqZyBbtMcKuKXJY5cmuzJIYAXpNiFkbGFTxjlbsZkOskVoYaHMm3yUDb5MND5WkNmZzaSI2ArfkoDAhPOSRsGQAPdfuwl801ASG46lde7OvnUJvqTz950xj2+F13bBVEtsbP9dnVY8XZUSTm/cPLaleqwXW9GSnPfNQIV96g2Ccw4ImIJTRkSpWEj6Xvaq1FKwoDKw4cSPFObEtcnqemnxyRf4e1O5Lj8ScxASFOMibMXTYDWCsSqAcFYUsRV4tXpA4xHu9b6RXbl+srW7MvcJHrzG6vPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zafl0OVxf975Gpzc5S5jgEkdq4mK+jtHh1Mgqz6csac=;
 b=whB0WkRmtJVGf9fIw9MR+4op2dOWCXSwmYgE1yHhAsRevW7dQTJScINTSRfKR/W15AQeHWS3mZKu3aesQhOlLtOXKF+u5NMBxNnOM/umwSmeaTGva8lyC9/hOAbZuq2T73NoosaIdBRQYos7f7fyZcV9CpBVboOVsPRvk8vkkArNDtSobAcRmjDkIKFrFkz4EBGUa9wE0LGKXJiRybHg9sUOcuihIzVm/5BEPvrwAA+QdDdrji4I6pilQsOIqmBRzp4zvhHj65kD0OfSx/j0FAXdgomB+swk9SXLlcUC4M4TJCKQmc4rEo9p6HjOMAZljjFOyx9VGXvkGeuZBnOtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8427.namprd11.prod.outlook.com (2603:10b6:806:373::19)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 17:28:43 +0000
Received: from SA1PR11MB8427.namprd11.prod.outlook.com
 ([fe80::b156:b61b:d462:b781]) by SA1PR11MB8427.namprd11.prod.outlook.com
 ([fe80::b156:b61b:d462:b781%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 17:28:43 +0000
Date: Mon, 10 Mar 2025 13:28:39 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Anshuman Gupta <anshuman.gupta@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <badal.nilawar@intel.com>, <kam.nasim@intel.com>
Subject: Re: [RFC 4/6] drm/xe/vrsr: Refactor d3cold.allowed to a enum
Message-ID: <Z88hR4PN2wuAhdE3@intel.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
 <20250224164849.3746751-5-anshuman.gupta@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250224164849.3746751-5-anshuman.gupta@intel.com>
X-ClientProxiedBy: MW2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:907:1::34) To SA1PR11MB8427.namprd11.prod.outlook.com
 (2603:10b6:806:373::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8427:EE_|PH7PR11MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: d50b9b45-6b55-467e-0625-08dd5ff9019e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hXjdkjx7mTYcc61BQUMqljNsz7Am0d+KqI4NaA1Od9PADC2S75MZT20g7zBi?=
 =?us-ascii?Q?p+WQMGwzoz19QgQIk8cg/hr0grsZ9vjS5XHQW8BUO5paxT5QHBDnhTjLxmH7?=
 =?us-ascii?Q?tIUiNCRsMrQU7qecCUPESemzSUSBkbq12h+eR+MdDpoEzk9MWUP/ws5nicOj?=
 =?us-ascii?Q?KFG9quVyJkeEO9h8GGNaD7eb5w0fbuW187F1yHGgrssoOXywVi9BLLv2R8U8?=
 =?us-ascii?Q?LPrq83mQr4+D2jf01VvMkRyTVVh680bb9062DQNFNdTqkCABMC1U4LpzWYJr?=
 =?us-ascii?Q?qgj/cm9ASDVJhJhrMKp864Lx4TdS94+tWCw2QLoBLnx6+WuuaghI1bhBvpIM?=
 =?us-ascii?Q?hcxfghBrYmd48mbdidUYcv0VLKtkGAZpOKrulH+ZI6tLEpU220MJnFbR52a2?=
 =?us-ascii?Q?s5fLPCJRu+IIgCIe7KjdGnoqf2NTIEksPdR0GMDk4DoNjb2BF8H0UowseZhx?=
 =?us-ascii?Q?BVznZUOsskYHWbVz1/XSxyu80OsdwW6uKFndm5hioFSDbwta5IZsVOsjUxak?=
 =?us-ascii?Q?5IWQtVzfcjkyrZ8Yc7dhu+CnaKKWr+9NayGEtzkVDuYp/4THPne5FdhzaaUO?=
 =?us-ascii?Q?ocHykI0K8LmKrbscgvOyB1m8oYGdgz38Dyh7UJ0RmHyMVZb73Ju4N74CgOWg?=
 =?us-ascii?Q?F8Kz1XA9Mwca1YJOS/ubisEvqyxPPrzr1gsfnMkNBSPHwvwGsAGHcwUWuuoY?=
 =?us-ascii?Q?K6h8yQobtmG0e7hAdKWfEl0LJ806gHZgDMyIbVi5LYJQsgHjeeAaCpxt6dWS?=
 =?us-ascii?Q?37mJZXm0MzN7dr3Fx0B4oBqiRGrKXumgEtY/DZ8G7mBTea+1PgWketQ7GlLv?=
 =?us-ascii?Q?XVYSnWxcR8jYsrlhWgDuXJSliBgdg2HFmv9sF6LPu5bKHcHKOyQFp8MKGIMz?=
 =?us-ascii?Q?0wwOSExM2pcURU84VVkGt+vcJtLfo1OqnfHEkDekKjPDt184ayOZDPCJ+IwQ?=
 =?us-ascii?Q?KVVUtU9iGoTs5wSzPAuI9rKUd+GVLn8TF18ifpGfUlxUWsmU2elu2Ugpa2wi?=
 =?us-ascii?Q?V8AxleOehSmn730Ct4qfV9sOUl0AZFPQvWRQjiiFbmEDEvGkkXnvdnba0wFt?=
 =?us-ascii?Q?dEj2mnMAcF7L++3qOfxoiQ0ri9FS9JIFe2OwOpwbjp6M6g/NM7C/EXELXwZ4?=
 =?us-ascii?Q?mYuzcAGnBsgpKiU+OidN1Qd3ou2Q9bQZFaeLKceea6iPY1tMrR6MDgWP6vgC?=
 =?us-ascii?Q?YQ3CPXXzyKBKSPnK+ElZoarzESWaE5e4WQ7NOaB0s+Nnxl3FRch+qI/CY6HB?=
 =?us-ascii?Q?VFE5pU1i35eJAX0RBmv68Tey8Kf/sAxYzfUv12UAGPo7IupHjLYcRJfV5Io2?=
 =?us-ascii?Q?Ckrv9F8zvW1Y/TvfwT2JAQGROwivNyRINHXjbqUY9+4Rhwhxbka/MAV1P5JE?=
 =?us-ascii?Q?CjYZ85VmPkIwtWQ5GouYmDNM6b/k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8427.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bzw4fRn/Ph2gyysr3EYUEe3gL95pTMJmIbyHBBIAmwH7Ol/H/nxekEPSNG+W?=
 =?us-ascii?Q?75F733rKajhszo4Nw18WpzUi9vqUz4ikVhNuNti9Ws5Txc8ysF65DdgsySE6?=
 =?us-ascii?Q?cF7a27b5NIcb8sJKH6hOe24mUCrQCYrClCBGYOZhSpmj4OGn3bf4RJ32QPd8?=
 =?us-ascii?Q?lQ7MbgRJDPsoKmsfWVS5oFy5pRt6k7YGSSqQPzZZboojh6r3j4mGL/w8NH5n?=
 =?us-ascii?Q?hd/j8vQTQBPyEkwawYl5iS6hikh+xGY1acaPbveqBHtNo7qdo9Kn7vSkDC14?=
 =?us-ascii?Q?cGTMIPRfMKiD5o7qxd7oazjFfkbPSSYVdbwH6ajASY82ZuW/kjq9FEXNoKDQ?=
 =?us-ascii?Q?KPLEXiYFXb7K0i9t4eG8W7SMAx4wbjuogxljHVxLxpeRp5KqsOPUu+xnLkhZ?=
 =?us-ascii?Q?2+gHvAPHjeAjABEfOeh2HN7ulifiBQPv6y4DsI92dvTyTwWDknS0x/rKefLR?=
 =?us-ascii?Q?yrX96idfneuK1tpBGfTlOlKeU9b0Uwm/eA2U2EZyqFNTb7ijvQWieWbU3QWF?=
 =?us-ascii?Q?rffcyb6TBU/TXQVBmJ/AgyQHIYWvoJv04LdtfmwtUXnehcobIhkMLGhdBHXs?=
 =?us-ascii?Q?5SyJyUi6KtS6HSWAWjWyRDLvCBh8ncP5dSRMxvXD1qvkf8LfE4UOIjqrsWhC?=
 =?us-ascii?Q?6ge+XaSC8XfRL8EQrsIuh+pCSzzyYQBYMX2PCxO8m4XS7K/noZ8EBJJTbnkF?=
 =?us-ascii?Q?esMYr0LY8gq4EEmI7k9s8Z8Y9m08bebH7VXG4Pv/pBrYVJA8yCVvnFa/q9wP?=
 =?us-ascii?Q?p0wPzi7aomIUurPHfWDh+wye7sZDYiMV9ejGqK4IH9FLuuLpl23oL+resYPE?=
 =?us-ascii?Q?xt7xgLSg3oseh/ijy356QrN8KzKYfS1DJbdLDq8TbZpwi/RFX9ZAn6wnyQW7?=
 =?us-ascii?Q?sb3mIDWfotPcOKxGGdGzUR03zWdjs/mD1I+nEENffo9JgZ/Y0S+lhEY3bgCJ?=
 =?us-ascii?Q?WjGrU0cdqnwAC7KSF21kAl07nqoKvcT1yEXBUZPoFXKZ62QPY27QVl3JSAFT?=
 =?us-ascii?Q?czD83apSkfjzSHHVVUNqIrMVWY7iomxfTES/2KR9t3t3nJGCz4lWv7YJA1dp?=
 =?us-ascii?Q?yHAv8whbP5BpVt5geG6iMXyBjghTB4WSsyNPY+jFKk0546LpUS8pFJkllFsS?=
 =?us-ascii?Q?R81yhQ3XEJciMvdDM3n6kSU8w9olryc13rNq/SGCnYvicRiYdlLiAJ+4fQ/J?=
 =?us-ascii?Q?GfwU8z4bDc4kaBh5P5pbd87Do0Zz02Kw7hC/11iQeL73nAeOU5VAECTyMdqK?=
 =?us-ascii?Q?6yfrBoMzQgmys2Wb/UmCBZdE20WpgCZfNuLMj8Y9in748hOLyLz7+HGQT0rh?=
 =?us-ascii?Q?Z9u8zUNz+z1hRqYsOZsYRmVjiwLchNnx2hejT56SrRc7Tu0zjEel48AKwhZT?=
 =?us-ascii?Q?5+at2Mq3oSJ2vEUvVnXkpNDSpjhzKWfS2I30CJw/SJfE9H280nEztq6DRMjE?=
 =?us-ascii?Q?EX5rae1d1UVScrYtjUIPSEbgbcU6oNtr9tJrAvpjjfgDxViIdXmtbIGF9S3p?=
 =?us-ascii?Q?JDWOThkijry9dCl38c6mMkCOZ+YyH47N4tpSog5hVsj3b/SuycOPJ9c6Ul+w?=
 =?us-ascii?Q?bRTwNHx9glr3aWEhHHIs8wBns2/wxqjywl8CU7NBSUrwvNTAE3AkI+v3TQ+C?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d50b9b45-6b55-467e-0625-08dd5ff9019e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8427.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:28:43.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPfTuDu/ZxnNLAsajrBKA5ghV8xFz8de4MU11DEwCZGcMf2HcU55xqvmMgAa4B36P2b8cc4ugP0Zda4EZ3/YXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com

On Mon, Feb 24, 2025 at 10:18:47PM +0530, Anshuman Gupta wrote:
> Add xe_d3_state enum to add support for VRAM Self Refresh
> d3cold state.
> 
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_device_types.h | 5 +++--
>  drivers/gpu/drm/xe/xe_pm.c           | 6 +++---
>  drivers/gpu/drm/xe/xe_pm.h           | 6 ++++++
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index da7946b75cd5..937461939ecc 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -19,6 +19,7 @@
>  #include "xe_memirq_types.h"
>  #include "xe_oa_types.h"
>  #include "xe_platform_types.h"
> +#include "xe_pm.h"
>  #include "xe_pmu_types.h"
>  #include "xe_pt_types.h"
>  #include "xe_sriov_types.h"
> @@ -488,8 +489,8 @@ struct xe_device {
>  		/** @d3cold.capable: Indicates if root port is d3cold capable */
>  		bool capable;
>  
> -		/** @d3cold.allowed: Indicates if d3cold is a valid device state */
> -		bool allowed;
> +		/** @d3cold.allowed: Indicates d3cold target state */
> +		enum xe_d3_state allowed;

let's also rename the variable name to 'target_state'

or xe->d3cold.allowed = XE_D3HOT //becomes strange

xe->d3.target_state = XE_D3HOT sounds better imho

>  
>  		/** @d3cold.vrsr_capable: Indicates if d3cold VRAM Self Refresh is supported */
>  		bool vrsr_capable;
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index 32583651988f..81e67b5693dc 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -859,7 +859,7 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
>  	int i;
>  
>  	if (!xe->d3cold.capable) {
> -		xe->d3cold.allowed = false;
> +		xe->d3cold.allowed = XE_D3HOT;
>  		return;
>  	}
>  
> @@ -874,9 +874,9 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
>  	mutex_lock(&xe->d3cold.lock);
>  
>  	if (total_vram_used_mb < xe->d3cold.vram_threshold)
> -		xe->d3cold.allowed = true;
> +		xe->d3cold.allowed = XE_D3COLD_OFF;
>  	else
> -		xe->d3cold.allowed = false;
> +		xe->d3cold.allowed = XE_D3HOT;
>  
>  	mutex_unlock(&xe->d3cold.lock);
>  }
> diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
> index c9f176912b46..b7b74757ce21 100644
> --- a/drivers/gpu/drm/xe/xe_pm.h
> +++ b/drivers/gpu/drm/xe/xe_pm.h
> @@ -12,6 +12,12 @@
>  
>  struct xe_device;
>  
> +enum xe_d3_state {
> +	XE_D3HOT = 0,
> +	XE_D3COLD_OFF,
> +	XE_D3COLD_VRSR,
> +};
> +
>  int xe_pm_suspend(struct xe_device *xe);
>  int xe_pm_resume(struct xe_device *xe);
>  
> -- 
> 2.34.1
> 

