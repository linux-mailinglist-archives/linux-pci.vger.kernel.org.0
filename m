Return-Path: <linux-pci+bounces-21866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70270A3D01D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 04:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FA87A8A32
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 03:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866B1C8FCE;
	Thu, 20 Feb 2025 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoQqqUP4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307A4C6C
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740022795; cv=fail; b=C741D/zrKws7eMXyG2Gi6vZuz9pEhvZ+tA4cKR3pCYPkjn5wwhB2/3U4GMhofR5lyzpqjiv8LNWaf/EQogV9YQ88IfuiW7b20HAu81NTVx/+D+aLMBT2yApIYP/y3KjZe9f4DGjcWlpgEbalgH1L0XynGHnTpbAF/+ARu98E/Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740022795; c=relaxed/simple;
	bh=V0fNT7AHHj0K/PtECaYLrxnUXhnW4+pulmb34fPxZOE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OnTdQczBjP7KDZG5WY+ehXusO6p8NkkFETDs5dXfFcgnl9W/+DfshUbV3x/Orxeo9IqLHa28yezqr6wf1/lJnBqHzspqWGZx61Sktw1Pi/2EYmA5smgEzrqW5qx4EYvEtbsJTHNopKJG8O2wokoAU9YVxdoKOjZivXd2zsTCcEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoQqqUP4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740022794; x=1771558794;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V0fNT7AHHj0K/PtECaYLrxnUXhnW4+pulmb34fPxZOE=;
  b=BoQqqUP4ixF4VB7N6SXaZWdjg0ofOr+qCojXatXbLFedapxLPHMdphRR
   YX1GN2iRUyR5eqrDnxv5/uon4qOC1elwY5/cGi5onBgx7pPMInZwCLV8o
   wCaDBHf5MQel9qAD5wUtuetapizbTGRGc2JeUihdAtDWwUgL1dafmJtBz
   FrmK5inkngA+M6efSCUCX6fG/vKHsK48bxh6SRusyeZQpaNXuxg6EIY4g
   4BfnLvnto0NEXx5rv8KiawKDLPpjTHLqgsPF4y57GWLlPrvaEh8RN1owm
   R2QCJC4ZGOsnVlaLNNdz59OS+gbCTgPY0bXm3W1zE0+7A9fpGvBIok7pZ
   A==;
X-CSE-ConnectionGUID: tIvskbo8RTGjGVOWohB5HA==
X-CSE-MsgGUID: sD/OjZ09StqMXaFXMuZ8tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40642520"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40642520"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:39:53 -0800
X-CSE-ConnectionGUID: PthBesmlRPeN3qMvU1IsaQ==
X-CSE-MsgGUID: oS5wMyjlRSqR9gVVYkElEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115585866"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 19:39:49 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 19:39:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 19:39:48 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 19:39:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqCEmn6uOs04JBDhKozybtMAtCqZPmMPnObCe8tFbVlEwe9bnDbku01zkjsg9ayogZXSVSJJsiTOTBXgSOpkbpULzLVB/6ge7YAn7znJEcl15lEk0AaadsibgzSgzGXEnKF7IgTkDt4e8sUV5oJwHFhOcrxr/kfTUEP2KcZJalZLSRFbAOu0pOjTMKHOCRDTK53e91l5qu9monvp5XEG+AXdlWxpVYv/EHAWhkcrlRCoT30dPMody02/W7zdQsr6jSyBDiN5CQuQZ71zH67lj4h2cgnFx4eRskoKf8b6ebKHFel+/yxR/FJmAIq/65tMo04EuVZc/NkBBZ3JrAo1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKIpTGWBBNiBx4G83+jwUsh3ZtX5z0PibdnrZ9tu0AM=;
 b=uSaFJ8nLhKcaeg8wAurPSGAgxD2asF5HlhrqbKxuc5hTJY7ez51cbRGdADsYHS6LWSXAyUXSDBx61+nMZ66rNFnBHnoJ2zPI+9HIg68+FnCtz4mICl1n3q3BsnM3xmXUG8RMwQxp/j9veVxH9XquvOp++dBmUTv+6X6NbrO9gSwdurVdD/kcuCZ1iEpTkJzqgoDJTHT9lg9ZPb2hP4gpaEQNjEt54ZG0DjFqsX1NW8IAEEHDPrNvyk2zFzzpqElzALaTDJaPdszqDgrP/dbgeIGvtiAD3LFcwp5q2oT1WGzjYTCLtw4wlfs0Ovd0IcVVOdesNrEBZxUQqs7akG4+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7503.namprd11.prod.outlook.com (2603:10b6:a03:4cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.22; Thu, 20 Feb
 2025 03:39:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 03:39:40 +0000
Date: Wed, 19 Feb 2025 19:39:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67b6a3fa7ffb4_2d2c2947f@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <yq5ay10oz0kz.fsf@kernel.org>
 <yq5av7vsyzre.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5av7vsyzre.fsf@kernel.org>
X-ClientProxiedBy: MW4PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:303:83::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 2839b958-f50b-44f2-8275-08dd51603530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P8Q3JczANKO9tEn2CvuSepLwnxPg7QJu3hKsehaGKMrQENACItQR4jFu40Bm?=
 =?us-ascii?Q?GhzrYctlCG9mxx5suSJM+I4t3lJkLoIZ7uBYpkITaDRS15cHSS1TJFbFtM7L?=
 =?us-ascii?Q?hO5tSG4htCTaJRffBPo4NFZKJxbfgP6I1Y6gqHZaFmmafM8rU+WsLlkv1/zY?=
 =?us-ascii?Q?dmCj6B2PJX7AQZ+46u3fAFJr1uMJH2gfuVOQyRgLdzuTgzF1UF6dYuz7qXVv?=
 =?us-ascii?Q?W0Cagcm5c+8H2c/cDOx+NV9IhI4ZCwtTzDfEnBkzSYvgXTTmK21bD8DHWTyU?=
 =?us-ascii?Q?x7HBP1vTN3dQ9PX0NmD1JFn3a89aEhPG6wfBw6UBPSYZCbFUy6DSljYQK73n?=
 =?us-ascii?Q?Vmy/Yla+1qQc+0boMWGjBJOpH/rkDACKfCa0GU9TkQ+N3TpZQjI1VyJkBIp6?=
 =?us-ascii?Q?0a8JzkkFQAwWTUlRieYwYVrjAzqNHx9XCiwtiuuwkLE40Epq6fSPq73cNXqN?=
 =?us-ascii?Q?5lNU/vhq4CfTw/fwuAkBai/8IjyEWvbNnx50OsCMWM8omhs229C37lA7o2IX?=
 =?us-ascii?Q?V0JATwStlWfWuzYyRmehCXEv/g1Vy7xQMhCEChJ+dw8KWXObuTNvZkifT39L?=
 =?us-ascii?Q?3uEraXTeyJGnoq89qwwkK0R1GVEneE4q3YDG6SRKE1jcRtQzPcS2LrSR18DP?=
 =?us-ascii?Q?wYuJjrc1W5GlTltXqOCOQqjjGG5K4HV22LmdKryKxYr/8vUZV5xChr3uJtTs?=
 =?us-ascii?Q?zdE3C9ZQ5MuZSPbMVNyUa50vbMk2druoBd6AjedatfhiVy1ZSeJs6sfjC8bk?=
 =?us-ascii?Q?odLJ92sC+sNu6cjM7i8LPY3cMQvPytoVRlUGezN9z3o+czB0cnQKYS6QxWkz?=
 =?us-ascii?Q?z6twlZ4IEY6CKUPLWFYZ3C86D9wKUT3lqrcyPt0aJozSDWAoqPerh+kJdzto?=
 =?us-ascii?Q?9KzcdW/MiNMoGcpMW8PpHtMfebqlmz9Zxw8KFuTmuSOTbGCYm/1IRx5mGrUH?=
 =?us-ascii?Q?4HVaIQma52WzA7flmgTQ/aiv42vHORW2Rdz0bri+6jhIJfjitgD4hcv2eozu?=
 =?us-ascii?Q?U2U9xsg3+N51GI5LQDpxe/6iLiBH0hh1fCVUdvw2ynX/fEYooWgQCUkJ77T6?=
 =?us-ascii?Q?1FS0wGcKruikor5dYZzEOBb6vIJrVeX07ekmr8HP1eORbagKOjIKi6D0+IAe?=
 =?us-ascii?Q?iSa/FlwTK0wYZEWO/F7GxLFFsNXleEwpsP7sRU6EbiJOBdCgKjAHUZzfFipg?=
 =?us-ascii?Q?RkYb0onjduGnmmZeyWqO0Ohmes+dk6Qgb+cBi7Njg2X3SSpaTzpSnEWbx28F?=
 =?us-ascii?Q?oWf+AY2NwRF+NokZgwy8xbzzS9BDs9W4ieOZNTnhczPkYUkkkSa8xuWSLKKU?=
 =?us-ascii?Q?GSTVr0XdefR4WJx0dvq6mDKL7e+c6Gv15JWCF4QJujqXlG6HP7XTZz2CfZhY?=
 =?us-ascii?Q?fVSICqKVgiy8EguOQe09BIjBv6wj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PANeR49EWkBLyDwhSIxV+J4IA2BxtUGBxFpqU6s5yLc+wgEe7DEiIn+kSwyF?=
 =?us-ascii?Q?PxqHDdubjqk3ddiDCF9vSXrvKZ2zVoQHwqHOXfxI1Yymo2cq6W1nk95HMkIs?=
 =?us-ascii?Q?/p4JcLJ+nMQq8B4VOpdPA8GlzJZeCNxBFXbYrdmEf1eVXIIYCiy+IkX/kgj6?=
 =?us-ascii?Q?LuPIayWKKX1E6cpClaTzQreu+PFxOgCn1LPKfQDL2qpH+hDZ9egdPh52gFq5?=
 =?us-ascii?Q?RNUdbqcnt3/zRrjWHJiQ6UibKxMARTzX2Cnw3yyGdi9kGqtgC3xBqRXtwJ/W?=
 =?us-ascii?Q?vyIChQqUDOx4fxhPxBGI96WMMT35cUcQk0RkJbw9RfZtViqk1ILTDxVkUCkA?=
 =?us-ascii?Q?+2NrVbmE+/eFP2rNYaprD57wYe2mldXjQlOtlff9tZlIqXPGnHlSXlcaE+/G?=
 =?us-ascii?Q?ZKmXjY55IitAeCcW79Ufj9F79bOxo7NkbJB4+7WPVpe9aD5SZ94tzkpf0qeS?=
 =?us-ascii?Q?+69ffyiJsmB49rOhbzp/6FjKXukinRIKknck8EVZE7F9h3nXBTslndnTn0QF?=
 =?us-ascii?Q?kBhmAJbUNwVovIvyXlzzTMtU8TYvQZXFYdMyPzlb2lDBR2OdPx3JhVf9zXXM?=
 =?us-ascii?Q?EOTcKRjve4ljQ+7BTAKMabaSzqLNAA7bnkXvNR4XP2mBXVZkagBeloXZOcQo?=
 =?us-ascii?Q?Ues9wGcq08hLo9NaTU+v7FaFzTlscg8mL1qG3NYC6/Xc7y4rMNRNlNgXf6le?=
 =?us-ascii?Q?+tTh/G9etw/2lHWtPdDPWOk2cucyearpwaJRVDcG4bTSbMTlwApy1Ty9TjTQ?=
 =?us-ascii?Q?nkHKYXCzdYcq6cGPPpDGb3dMgzrUHe+tjJYYndgNr2VkpHxs8J0rVBzDvxeN?=
 =?us-ascii?Q?m+ksjZBmHN7fwUNUyBH+nrYK7Zo8LyazUJZzN1/V8IvPfikdAtFETSJKyV1k?=
 =?us-ascii?Q?ppZECtFKBvlghrW+6P05HLlRwICL10yuZH3kOdmovBL4Z3IREhlXdyXSbM+E?=
 =?us-ascii?Q?51DjORFpg3K3wAF44FR42Xc3cnXVuFBCttIMrdPoLs6jB4eKmA292oRRXuhM?=
 =?us-ascii?Q?t1Y7SKlvN6+++0C1HnQxkieVw2jn6WMoLutHGPPG9uJMHsVbRI92QoYR8JI7?=
 =?us-ascii?Q?tsuVM8kXYuGy8tuHm1p8y2NAwvHU017YgFlExiCjC/JgSS0cIdAZZebWo7LY?=
 =?us-ascii?Q?VOU5Fk54AsFEEZXzThiDG1JnciyjoAXymutV1hd1nwHteqRNygm7bkUWkY0D?=
 =?us-ascii?Q?LlIlezQyb2L2DlTDbJTghbiuIE/k+BlT2W83nqd5oyhaDyBNfWU7xjBc3DMq?=
 =?us-ascii?Q?Z+7GiWSTpEBijju0DKHIvl6aQ9PqBlUoEAnlVOrXh/INmsKoYyiZSdI4PcVl?=
 =?us-ascii?Q?6t4bRjvzPsiJldAdETQlEAa/T8mbbD03fxJT5y0+r5DmJLxwnVN3W8YCFk8p?=
 =?us-ascii?Q?pnTlyBL2NXbMX+kyCzByRBiscqD5OTqbn+XfJgvFXR1YXRjDWPLwlOgUukCQ?=
 =?us-ascii?Q?keTpE2ByoYL4dS5tzQIDa571v/i8Te+ZTCU6FI5N7wEHCDHMblL2T1FCPvNg?=
 =?us-ascii?Q?FFcP4jRNVsjqdIv3lNZrjMEwJwVDxIiOaLZitf9AFS2Pg01J1NlFo9WQTPUw?=
 =?us-ascii?Q?DI7dwJGxkWwUIc6pnoROrfeNrv4osFijdVvEvW4dnnEgTjtNGEtrZHBoU0TW?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2839b958-f50b-44f2-8275-08dd51603530
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:39:40.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXQPnVLeDNwCCVVJP5PEIpbhse3Ba1zjNeSU5cvJxvRKXNrqHHVOJwXJ/BpwK2jtt4JBgnSTDvZlj5zPDGRVkremm5YfkPoC78k93Bzlbjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7503
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
[..]
> 
> Also wondering should the stream id be unique at the rootport level? ie
> for a config like below
> 
> # pwd
> /sys/devices/platform/40000000.pci/pci0000:00
> # ls
> 0000:00:01.0              available_secure_streams  power
> 0000:00:02.0              pci_bus                   uevent
> # lspci
> 00:01.0 PCI bridge: ARM Device 0def
> 00:02.0 PCI bridge: ARM Device 0def
> 01:00.0 Unassigned class [ff00]: ARM Device ff80
> 02:00.0 SATA controller: Device 0abc:aced (rev 01)
> # 
> # lspci -t
> -[0000:00]-+-01.0-[01]----00.0
>            \-02.0-[02]----00.0
> # 
> 
> 
> I should be able to use the same stream id to program both the rootports?

For all the IDE capable platforms I know of the stream id allocation
pool is segmented per host-bridge. Do you have a use case where root
ports that share a host-bridge each have access to a distinct pool of
IDE stream ids?

