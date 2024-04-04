Return-Path: <linux-pci+bounces-5730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 512FB898A53
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDC81F213F4
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF912B95;
	Thu,  4 Apr 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfofWFIK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE311BC3F;
	Thu,  4 Apr 2024 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241769; cv=fail; b=BKb6TJZCLuQezvJbpcNdSlvp5KAw1/bGIu2uwuR8hq5yZv9m4ZskX01etM0OOIbD75E+3YXiBAdrlZaBboxkAZwsG5UtqK0b+bAWEKLNdVzlSsspiV3VJbZyU/2KzjuMuLqrjdybpzBisIUGyJmwxzxnae8mftpsHjGykTO6mmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241769; c=relaxed/simple;
	bh=SzqlrfeSBImTt8bFsZwc5F7wSLldsgvRe2xCaH7NjH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pQ7iYgCQrMDC8ds7+kpshYJ7Io0gP/FHMKznPl8omSVRxW/q84QUSdPKH4A2q72HROP5Y9eqAC2DXfEjGgUHoABcw0B/0qKBVdQ/eoGwPlGXBFtr91jeiRndCgP5Aou7hc3/DOI3IiX+tLX3CifK76zqW2P2tnhPY/pAkoPw5Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfofWFIK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712241767; x=1743777767;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SzqlrfeSBImTt8bFsZwc5F7wSLldsgvRe2xCaH7NjH4=;
  b=NfofWFIK1FLlwOgorAVLz7NTU730JlnXjNfoqW8AEYbcsxwzMWUgA4UG
   cODhfjVHrZX8pEesEldQ8hNfCwL/Y4L92ghijWE7hJa+dDgeOKfVrEXXn
   KkxPGHRDbfti7xP5Ne0+VVHObWIjPtd2kOIvcjWDAFOJwA63Wz3DQLfmr
   sT+BYGAL4VJQ2A1vbuJ1NyAu6v3/KicSebmqWz4pDjIRtLkruJlsjt+KG
   piaWgeN3z//d0NvjJ5f5Vn4XYwPnzsNdBaT/u8B2f8VbDmQ0y8y+2YcU3
   32BlI8JcVkPJWFfqQ6fn+CRCjOilVqK6BMaPAPrxjEt6DqyTivy/lC+e7
   w==;
X-CSE-ConnectionGUID: Bqdf2dPjSQiJxV6Lo+38Gw==
X-CSE-MsgGUID: 2UU7mlkAS2iywTb5rR5V5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18259495"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18259495"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:42:46 -0700
X-CSE-ConnectionGUID: fdjdo0znTFS8b5iPha8nmQ==
X-CSE-MsgGUID: Bj5cwf+/Q9mJ43QqJjEY6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="19248264"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 07:42:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 07:42:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 07:42:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 07:42:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 07:42:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Agz84YXgKzZRHytJSa/2xSBw5a0sCr0F15GFiibh8XULxxhpt/+UcJrCgE4Gia8ICQJBvvLyWVzo/wroWm6X56cAnd1HijKi9esPotb82vOa4c3hDYmTLunrhQ+mmHd7f5mgpbEGYQIDfe6XU1qA3FJu2yAwOa+ea14zJwPaFEjPBIVicbGC78A+rGhIcbyPaj8INaAIUC3COS/+IUp6g8m4y8yZTmH0j22SBCw+P48nCI2y6zaMcJtDgWC/DyJIYqT0JHH5Ldy/sinws2nEdS/PTw7mIpEJs6E0vTYgTQ6EtWuW3WtSQxIpaSYmMnro7HhogBhjOxjNmvu7vm+Mww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQztveMbYQxznx/Hz5PVaGfjavgHJVnmf/JRhSSpe2k=;
 b=PIkDOKBIMVfxI1tJx9MspkKIGqBsENutC08LyT7wkLSH6gNFK1eTmdPCMcyP4DnNJ9XaiW8ZM5TV11mvH/pvD8aMLzPX7/csMWxnGPGkm3J9/JIDHQvdlVKn89UU5wnf5qwk8wc/9GA5ZpJUIiiuMEZiSm7Pxq6qQYiXHaANbEHzQj2aP6IHNLXYErbx0nw1AfxDYwtlyFLPj5u8/QCh3f0+nugKBvn3zhKKrmWT5Nx4xvLzLBM+VEoSFNwTHMQJKM/MbRYM4koeHgAe5Sskky7SrfKWh9NGaxVwPkEj762g130Ijjw38TYI4zgxCCoS+LG8GECnPNCL9BVCPRKkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7509.namprd11.prod.outlook.com (2603:10b6:806:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 4 Apr
 2024 14:42:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Thu, 4 Apr 2024
 14:42:43 +0000
Date: Thu, 4 Apr 2024 07:42:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <bhelgaas@google.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 3/4] PCI: Create new reset method to force SBR for CXL
Message-ID: <660ebc608e2b3_2459629474@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
 <20240402234848.3287160-4-dave.jiang@intel.com>
 <20240403160911.000016c0@Huawei.com>
 <3d4a14a8-7720-4ecc-9099-1bb94b3e7013@intel.com>
 <20240404142909.00002084@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240404142909.00002084@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:303:b6::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7509:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFcdA6lHTokmH7f7l56jiDhh8sM6xokYK2SvY2yvV1l2ucI4xMh91hXKsX2vcrt0En1FdsJCTuB7tTGBkq7+0/oKvueERzfn2aibHU9h1+Ql2/2YYdtG2t6j6Dma17qLzAbj7p1YI0TO7drX2LOtSqH45PLQYNVk4wbe1ae3AKGXEBkcZ10hXOTPRMdeeEgMI/qGM+MCkPej4B8HFZOgOO8fAnHHef5PtVjLHf2Fr7DdCdMjvGbnBUtmNC1B5VDpC4dhs8N+uDNDXM3Rw1hQPPTi6nz9eDwCJ7cxMRCRTUPehmzwEcjPqGcMWXg+/IYsfdZa1mY2kEHOl6WaiRHH66JVN3V4LkvYa3E9L/lvrVa0K3K/+Yx0tOTNCri0uGEdhnhmUYHsTf0TPiPO76a/l6SYEJrXWN5jqSLbcpl0KPwXahXlaHzKeTawsz5rzA6op9xtstKpzojFCRVVHIfywe4rsIqXDIjbb7k5c58OlJureUuScg1VixpuKEwtfTkMmh6kHkH8kuy0BLs01s1WbQtZ/xVl5hOeoxIgyaaCznyrr6y6yKxS1Fyzjp62hNQ4Mwoy9wjJszCPlh0RPaorsbOl6nHRxex8CoBfswchPu8l7ZGIJUOdRzfRkMF5x3zGAwwomC0ej7qyY0NMwhgADzfsfg0/nMkVFtM2g1eGjPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eoyqBaCtfc7C6pqQNlHEBxqQhECEgLJ/Ug92cYZN8+x+OW52FuHatbNZVzn1?=
 =?us-ascii?Q?MNelK5SHjrDWzElmg8r8gkOXMw674AKDCcz8rOM7Z6Ymngs6vH1sAjC7ryzC?=
 =?us-ascii?Q?Pkl2Ewz/Cx4qYblLSvv+s43+G3mnoNmgKOIxSOtFfzcSPbqwAjl6FXfXupD/?=
 =?us-ascii?Q?PTp4+QC4oK0mvKV9T8ySZrb1CMi5pbjZ9ib+k0/ETlFnKl3tf1zsIq05+xAf?=
 =?us-ascii?Q?b1h6oXVipgZMVFJksgMKkbyAJ4sB2djm8N3Ti/3Nsa2hscLq2UE+3x4b0qIH?=
 =?us-ascii?Q?bMGPSCCCCI+mvUNtdpNNsiF+7sYpoSsO4EyJ7ptXlS461x5N9IqrdzA+XX7T?=
 =?us-ascii?Q?ReJLaOMkJznop1afUjSvAX+8nzUU+YhP9jQ5nq/sU4GFOtBTwJ2sQjZChZiF?=
 =?us-ascii?Q?5UGeqSrTFWuFNwoulSjwqCIhaEmUEGBB+DPEKgnX/y2EY5t9vgkUM56F8Mu+?=
 =?us-ascii?Q?ZBLlAM6qBD+DAysF5NWqdC2d3bT8KRCU58XF5ua9yKBQl5Kzts2mnrpXHBil?=
 =?us-ascii?Q?OyfLRKij9yLTsP+W8gDYVX4SxsEjOQu9SocVqBv2Ntm6imJPD5oFC31kgpYQ?=
 =?us-ascii?Q?2nWaGdoKFpsx0Y78Ssc7qIHV29z/s9zAAWVHWe3VZH160CXznflQQIkLWNs0?=
 =?us-ascii?Q?doPY30IyZrz6TQU02zj/fpZ1AJn9Nkb1CI/b+8B/KtCHj2yeJxzQFKUUDbDQ?=
 =?us-ascii?Q?FonFJmJuRCFpohLGkPfmMT1ZJzrva4as1XeMOcL7W198ycc5j1m01dTVJN3X?=
 =?us-ascii?Q?bzBtw9S+vpHbPQfJjUWge/Ncybk7staCnhFC4rwR3pH/IInk0VoCs2AF3abz?=
 =?us-ascii?Q?b9sV72SBVS1CigQSpJRHpNhBgsUww3xPe91uHXwsBQhKOHAbdezwhVJfJnN6?=
 =?us-ascii?Q?0PkfFJaeC9W+Rckipd7fKH/HCGlUXz5pRDMbeY7y4E8xG2pIWm8Yf+KVybgh?=
 =?us-ascii?Q?N8pXK0SQ2XUXaH31/Tmn2Al5zSu4ITI7lzf07ctAAXSG1uph3+IkwnKzrUqn?=
 =?us-ascii?Q?SNUfUpSOYehE3MTV8W9mrsrNeC+xpPESEs14bMwr+I6yXIcDyycXO5IfOJTX?=
 =?us-ascii?Q?T5Af//d2lA1rij/a1GFz8uD8jmqE4a2O86C56hc0v1xDIzPN2Z/jGQT47A/5?=
 =?us-ascii?Q?XJv80q2mZ+boZV/w0b9f9eAyaUYMznUUxehGS3AXPYEBnCAwBPSUAfL4iuK9?=
 =?us-ascii?Q?RyQIHsaH7haUeeAzXNrFk8VrEapehuJcNs+IykyxLlsaU966v7CQ4f5a+Z8S?=
 =?us-ascii?Q?q193ubXd9nlLS6+7IKI0kug+bvVwZTuwc3a8RK+tgNJnb8+upXCvD4LxHFrT?=
 =?us-ascii?Q?/hRez9UnNZHTd6AlDbRValuhQnsdSdpN+aVz//QRYoNwu/LSjD9M2U1wfxy/?=
 =?us-ascii?Q?0xlELgSsylisjqUVdQs6DOwxjS2DHOHYS25h/3Z8Z+2AQtp9TTr5IiVIXVTh?=
 =?us-ascii?Q?vpjGIOowK7X4kaeZwqrhH11FpNkHHlhNYaEs14Tt78M6cDG5ytEdBXsdaMHT?=
 =?us-ascii?Q?GtqquQsJdPLaUN2kRwa2swDVh+3JiiYxHMQM2hv/Af+UHtzruwbsI0Nk4jFR?=
 =?us-ascii?Q?Q8NxSFSQANaO9UeY0YvUVFnNzuidFtsr9AXd1ve1DuaUZ9ee3yULJQnUK7n+?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2a20e0-bcd9-4d8a-363b-08dc54b57c47
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 14:42:43.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8krjJaWwiuDnnd8sORbvgAHsuWcleK2JJBuV1L3SA2r9m9OTsIImwyhtFhsGP9IclY1FujiKXBrmZDFJ1Vb8f3BDpA/9tGS76FdZAnOlWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > > Maybe a guard() use case to allow early returns in error paths?  
> > 
> > I'm not seeing a good way to do it. pci_cfg_access_lock/unlock() isn't like your typical lock/unlock. It locks, changes some pci_dev internal stuff, and then unlocks in both functions. The pci_lock isn't being held after lock() call.
> > 
> 
> You've lost me.
> 
> Why does guard() care about the internals?
> 
> All it does is stash a copy of the '_lock' - here the bridge struct
> pci_dev then call the _unlock on it when the stashed copy of that
> pointer when it goes out of scope.

Agree, and I suggested offlist to just use pci_dev_lock() similar to
pci_reset_function(). There is already a guard() for that, and
pci_dev_lock() is amenable to lockdep.

