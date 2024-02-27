Return-Path: <linux-pci+bounces-4073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A498688CC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 06:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3866285BB0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 05:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383DCEAD5;
	Tue, 27 Feb 2024 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlJ6GjBL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569C52F98
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709013179; cv=fail; b=n2mXdU7cLDs2VjE2Y2BaUIo9LKqr9TVVCfe5PLiP3XU85SDK0i/eeYfJ3i2J+f+3jQZpJTwjEGmERLNR44WZ1hR3GBFqrMnHeWkUtFlZD9VZZEaGhtOLmTbOsMzWWUvQND05K1lSvfO60m3gmDad2yMi84gHf73uQ0FnRFnfWL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709013179; c=relaxed/simple;
	bh=mjxlPonWf3ALO/y78Gf5ODYxS4GRXnIcLOa9NaMAxps=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qmWQAu4/2dR6pY5UPp3xqViRZuoWdokhWWLU9DgzruPVwW9vOiR5nZaOQAoACcvNM+M7JYzBAlDLoZzoqZvRgokM0OahevN7mWYHo4D+eNHOVDJZE66dxinKAWnLgtk6TlLysYt73qhqzq/p7Meuw046gvRrk6FEJntDGthgv3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlJ6GjBL; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709013177; x=1740549177;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mjxlPonWf3ALO/y78Gf5ODYxS4GRXnIcLOa9NaMAxps=;
  b=NlJ6GjBLkBl9wsAOooy0uD7PwtQHFgbvYuw0esnM7Zhkaw69+UNKdr19
   JS5x+PuEGqXztofO2YmtjN5EtXU/awlj8PmQVoiZzVhFskglS3pXEd9GC
   hR5Vm8p9pi4qhf26gVeRYqGvNi59sd0IZmxaYUWYsqOpYTMVkpIr0XAHD
   6SWH/rDPahJqilSbZchMk0tKc/jMhaEBva8Mz2neUvQ3lT1LzlpvbCqGs
   mFHr6aKzTWZdm4trVWlXyDlOQvWlQDnn++/8NC0UivCRoKbVLAa180L9j
   v7uSQhig9d9Ky3QwEGI1qX3HkkUO2lliwZM5oVhTt9gtQKJ2JmlD4+Z4M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3184332"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3184332"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 21:52:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6798513"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 21:52:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 21:52:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 21:52:55 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 21:52:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHi4O20aAvi4mTnWj6X3NaI2ijfoEvvoOQL2tuDKaZZBAkc7R+8yQI1m+u94Y8jPrz5E3GJwm04SmY3+t0LOVDd5ItPvdqv96I04jsBCcMudHBL4hBWTWuUwpHyHZtrhTYCF4k4Qm5RETuVO2hLdZpP5SyoA+wobLF9lHiuUmwo+lnJqECrxQWNZaBQexwSyQYJ8fq2f83QTION1qpJ7JAZtmer2bmRRWuXuohoRInLwYnqDar2qW5eyNDnC3ypfHJv/82af+xVNYhZ+z83+Vj5DPDr7Y0flOxvxgEhm63zv91t1LhweQzT01r4wAdVlvC2/UpmtxGHmDkM1FaFfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sClvZHJYYA8griyIrIECd1KMnGB1cowwF8AyymxAijE=;
 b=ZET06m118xoOiYY8wUmKM84E7G3Ykqp5q+9XJtLa3RZw9RMhRewprcW7R3meFUhYDbQ/LYC2cRAvIL3dCv11y7izMouWRvo/Uiuxj4IYfXiCRZloyJRGx4DQ6M6Uaz/sKv8j7CCQlzO3N1wVT9gCfbKJVbdDTtAMrPpRtJHaU79Pnb9Z5N7Zshv9r0GgQd0MDya5uVKEwrrXaWatw3i+c6dv5xa2DR9k7ti+r2CTPL9+YLsSLEIQmByybkKVWPdDnTNA95BP7Jd34ylzByIt7uQTqK6LkRYn4RZsx32rvo/CuhnI7DNyh0DQzxJVxD4tJCsNiPsympBdXQ1EkTlpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Tue, 27 Feb
 2024 05:52:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Tue, 27 Feb 2024
 05:52:52 +0000
Date: Mon, 26 Feb 2024 21:52:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>, Lukas Wunner
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <65dd78b16a665_1138c72946d@dwillia2-xfh.jf.intel.com.notmuch>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
 <dc849a4e-e07e-41ae-989f-c76dbd876377@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc849a4e-e07e-41ae-989f-c76dbd876377@amd.com>
X-ClientProxiedBy: MW4PR04CA0137.namprd04.prod.outlook.com
 (2603:10b6:303:84::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b1be37-f5ae-4800-2362-08dc375855f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rk3dLKEXfF2OYGitjI0+mp4LC48G1lH2UVyXvpTufkZyFBB3Xvc463XHJTrAwVyppCDx6CEqwP0g0JnBV0MOeydDqkEdflgX5D3C/fqd3S7j0LeNCVHuAOI0Rb5qZS6ux3Ow3ZjvqGF+fAt1Z9EGekeLYGaEuDjB+b3x+Np+s6nvbC9ofvKSQZlgYtVr73v8nMe4ZZ2+LfFP2r878sJG96EOzGzKXPV15XbRPO2ZCfnoEhmaIArLVCUeclVygbXFa2HEC1DPqFUKZaGnyXjELJ6ufepoVMp8aHVzHlbayZvgn0szYmmsCfg0cZnp+h+FoA9oE8vjwvrpjw4rpGUk9lsShBxuBb5ebK+Mm9Xa23+7m1bFs+naM29syNE3xX1rK4I+7HEs35us07pcLnvNUMmfCPRwwKA7MQL8lhiQnglTvYPGheT8njNLoyOgwhCJDVbkuGl32VAOotrsN4xBC1lnf8Q/gO/ioEQmqkYykxvOrvc8WH3CTmjEAQojbrIamdXAHawyWX4kTYrE3sqGecmChx7D26cMpBekacRBmLWD8csQ9wD0vcqpdFckZJHH+iA0j5tPUgR1uGzG7gJ5lk7qDXUhKIf2ArTJXWTLg5lYTWhVns7G1B8/KEO3CElEhyDt641pTfG/gj+czN0d1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oliQ9FjLJJI7xI7TCGWzJefWg4lqWIi/o9SQXfLIJpABhZP9pXtHMLmY8S7+?=
 =?us-ascii?Q?ircFDnYA3Y0J2g5v397egDf8crGbLrjbMcJKK+uJuQzoQDKv5pP4t2jnXrGR?=
 =?us-ascii?Q?AXsvR18BmVy4gkWLYzMxFfiBqcVc3rtnakLPjpnO96MwrBmf9DRh+znyvnl8?=
 =?us-ascii?Q?s6tIalUrxL2xBX8b3nTIJLfqUIGZVfGn7GEQstGXzDX9t/jtJ4umkywC9aLe?=
 =?us-ascii?Q?hljYRR1d3AW5PqWgmSJSdte3uoIbD4/BwPGm7MoWbQ8S3kBkODUUMqjKC4pG?=
 =?us-ascii?Q?f2A7Zt51l98Xw7w04Y0lvv26xsW/+uuR9128Hxzs1nhK1KUHUVloLtB3fOFr?=
 =?us-ascii?Q?1WsOFdikl+1aARyGOaBlvF/ljIhFL3CCNgoEb+UcYDzzhnmOHtb1ifofSIYw?=
 =?us-ascii?Q?vCeb2Sc5Hva+5mATKzT6zHGGctq11wtU51ybmBR1msrrr5NmofXYpAfdlELg?=
 =?us-ascii?Q?o7peerQuHan2bDhM7//1ADKwEWC4+uOtZcmSDAu8ZBMQFJJ5lZj+cNz4kojR?=
 =?us-ascii?Q?kB+cWcyxuM0BaVZ12fu3epGRnmX+ntZma8pNC5pIvGdcSF4LpPmYACPWXYhV?=
 =?us-ascii?Q?kMQe1IcqOrW3rgXtZ3M2glAJWDUVrqWNvF/5XSauvt3yurGW8kpGDaN+9ERJ?=
 =?us-ascii?Q?7Xr2G+MtOaJQXmZNutt/73VKY8hLm7LqNGI/Oe/zaVQDMGRernKZJWByOHnK?=
 =?us-ascii?Q?jFwy84e8KGmGNLzm2r/JvIh4FUC8BIeya8n7boeqInb3lP5TWgt3GuTbVaGJ?=
 =?us-ascii?Q?GblCq1xteQrd+rv5B6D+ZDQhj1cZHB0Zs15i/4YC4FhFLPw2VqiOqfsMBLYJ?=
 =?us-ascii?Q?JROeXC2Gc6bru5yiOX4NQrG45YwAWbe91wC21pYiIcJBphZrye6tmqJ/ifd+?=
 =?us-ascii?Q?0d17za/CZYfC37+3LAPDU+03/7IhNdJs4RwWFrHsP8v9JoLGIVCCBlYXZaJ8?=
 =?us-ascii?Q?MyFk2WiAv+wxR8+IeOvuyhY/f4ixmplQMxthbR2HSWG4KF1oNJ1GRnTQYV9l?=
 =?us-ascii?Q?lKJhMWaBi6olVanBVufU/Eai8+paCvXTD8Sp5h8xbTTTvbKSpcB9aoNfoeJ3?=
 =?us-ascii?Q?az9K7XPXCBMcKZRIu0vIiGCagWHv3NShNMvH7MY2JOLP20z/1bx4UsyE2mWo?=
 =?us-ascii?Q?wMETLPIWI4DVO2GepbMcTpzjZ6GYlAi07LSf7w4AU8rJgDZKB7Gqnz2A17b8?=
 =?us-ascii?Q?PvbUMzPQMf/cA1H7/nAQYfxHtCbLnKBWOGLZdlS+UXII/3wGV4vkUSFscFzg?=
 =?us-ascii?Q?qXRb6SJGBaNlBqi8cLQNKSbOsOHwbqQNWbRpc796SJqQWHwrf6pyy2wEnwi+?=
 =?us-ascii?Q?soFz8H2a4dTIsQQearRPjeznb5LR3TDLsPdH75qBAfatIT6HzTpZ/TiIJF3j?=
 =?us-ascii?Q?Ox4MdcNpxYcNBThb9sZEkQ3PWQPyE1Kl5yZgLKgPa1s4sK7emJM24U5L23aT?=
 =?us-ascii?Q?oT6XoOK6SUU2VGRmhBKPnu67BkgIx3gWM22/GdsUEtx9T+IZ3DCy0kZMV3Y8?=
 =?us-ascii?Q?JeSrP/ER26BKJUCAUGj5ERIfvTjyXQtIO7dJqAWUL/rzvNIpiVhZYhTjMJ3L?=
 =?us-ascii?Q?xflb8DXqkiEthdFfJ3Toj6yOxMeQudTpgvq3qvnkl8qNNi8VRTezdJ5OZSsP?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b1be37-f5ae-4800-2362-08dc375855f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 05:52:52.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4OVq9v+eZ0eocUEbcUeHlzVYiTlv756C+mjt5BYMFssUvxagXWCqBp++Q3rGdlfcPzKV15kMngP+K2v+uD2gHr2H7a/E0o/2u6n0Fsu9Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 30/1/24 20:24, Dan Williams wrote:
> > The PCIe 6.1 specification, section 11, introduces the Trusted
> > Execution Environment (TEE) Device Interface Security Protocol (TDISP).
> > This interface definition builds upon CMA, component measurement and
> > authentication, and IDE, link integrity and data encryption. It adds
> > support for establishing virtual functions within a device that can be
> > assigned to a confidential VM such that the assigned device is enabled
> > to access guest private memory protected by technologies like Intel TDX,
> > AMD SEV-SNP, RISCV COVE, or ARM CCA.
> > 
> > The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> > of an agent that mediates between a device security manager (DSM) and
> > system software in both a VMM and a VM. From a Linux perspective the TSM
> > abstracts many of the details of TDISP, IDE, and CMA. Some of those
> > details leak through at times, but for the most part TDISP is an
> > internal implementation detail of the TSM.
> > 
> > Similar to the PCI core extensions to support CONFIG_PCI_CMA,
> > CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
> > attribute, and add more properties + controls in a tsm/ subdirectory of
> > the PCI device sysfs interface. Unlike CMA that can depend on a local to
> > the PCI core implementation, PCI_TSM needs to be prepared for late
> > loading of the platform TSM driver. Consider that the TSM driver may
> > itself be a PCI driver. Userspace can depend on the common TSM device
> > uevent to know when the PCI core has TSM services enabled. The PCI
> > device tsm/ subdirectory is supplemented by the TSM device pci/
> > directory for platform global TSM properties + controls.
> > 
> > All vendor TSM implementations share the property of asking the VMM to
> > perform DOE mailbox operations on behalf of the TSM. That common
> > capability is centralized in PCI core code that invokes an ->exec()
> > operation callback potentially multiple times to service a given request
> > (struct pci_tsm_req). Future operations / verbs will be handled
> > similarly with the "request + exec" model. For now, only "connect" and
> > "disconnect" are implemented which at a minimum is expected to establish
> > IDE for the link.
> > 
> > In addition to requests the low-level TSM implementation is notified of
> > device arrival and departure events so that it can filter devices that
> > the TSM is not prepared to support, or otherwise setup and teardown
> > per-device context.
> 
> 
> It's a good start but I am still digesting this scaffolding.
> 
[..]
> > diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> > index 304b50b53e65..77957882738a 100644
> > --- a/Documentation/ABI/testing/sysfs-class-tsm
> > +++ b/Documentation/ABI/testing/sysfs-class-tsm
> > @@ -10,3 +10,26 @@ Description:
> >   		For software TSMs instantiated by a software module, @host is a
> >   		directory with attributes for that TSM, and those attributes are
> >   		documented below.
> > +
> > +
> > +What:		/sys/class/tsm/tsm0/pci/link_capable
> > +Date:		January, 2024
> > +Contact:	linux-coco@lists.linux.dev
> > +Description:
> > +		(RO) When present this returns "1\n" to indicate that the TSM
> > +		supports establishing Link IDE with a given root-port attached
> > +		device. See "tsm/connect_mode" in
> > +		Documentation/ABI/testing/sysfs-bus-pci
> 
> I am struggling to make sense of "a given root-port attached device".
> There is one CCP device on AMD SEV and therefore one /sys/class/tsm/tsmX 
> but still many root ports. How do root ports relate to /sys/class/tsm/tsm0 ?

This is a property of the TSM for whether it supports Link IDE,
Selective IDE, or both. Since Link IDE is a point-to-point protocol, the
TSM can only report whether Link IDE is available for Link IDE capable
root-ports.

For example, I believe some platform vendors are only supporting
Selective IDE with their TSM, while others additionally support Link
IDE.

For simplicity, I will likely drop Link IDE details out of this proposal
as most known use cases specify Selective IDE. Link IDE complexity can
always be added back later.


> > +
> > +
> > +What:		/sys/class/tsm/tsm0/pci/selective_streams
> > +Date:		January, 2024
> > +Contact:	linux-coco@lists.linux.dev
> > +Description:
> > +		(RO) When present this returns the number of currently available
> > +		selective IDE streams available to the TSM. When a stream id is
> > +		allocated this number is decremented and a link to the PCI
> > +		device(s) consuming the stream(s) appears alonside this
> 
> s/alonside/alongside/

thx.

> > +		attribute in the /sys/class/tsm/tsm0/pci/ directory. See
> > +		"tsm/connect" and "tsm/connect_mode" in
> > +		Documentation/ABI/testing/sysfs-bus-pci.
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index a5c3cadddd6f..11d788038d19 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -129,6 +129,21 @@ config PCI_CMA
> >   	  A PCI DOE mailbox is used as transport for DMTF SPDM based
> >   	  authentication, measurement and secure channel establishment.
> >   
> > +config PCI_TSM
> > +	bool "TEE Security Manager for Device Security"
> 
> (discussed elsewhere, I'll rant here once more and then will shut up)
> 
> It is bool and not tristate :(

Yes.

> CMA, DOE are the same, quite annoying (as in these early days I am 
> adding printks here and there and rmmod+modpbobe saves time but builtins 
> mean reboot) and imho no really necessary as (from 4/5) "only next 
> generation server hosts will start to include a platform TSM".

A couple observations:

* A significant portion of the overall TSM driver complexity lies in
  low-level the platform vendor specific init paths. Those
  initializations paths happen on demand via a loadable module.
  Additionally the successful outcome of cross-vendor  collaboration is
  that the vendor specific runtime paths stay thin, and those will also be
  included the demand loaded vendor platform module.

* The vmlinux .text size increase to turn on CONFIG_PCI_CMA and
  CONFIG_PCI_TSM is in the noise (0.01% increase). The runtime memory
  utilization when the feature is not used is just a pointer in a 'struct
  pci_dev', i.e. only a few hundred bytes for a reasonable laptop.

So the cost of maintaining this facility in the PCI core is negligible
from a memory overhead overhead perspective and the bulk of the
complexity that would benefit from being runtime replaceable as a module
(low level TSM driver) remains modular.

For that small cost we gain a facility that is easy for the rest of the
kernel to reason about and audit. All authentication state linked off of
the PCI device, all sysfs attributes centrally defined. The fundamental
object lifetime and sysfs lifetime is still pci_init_capabilities() and
pci_destroy_dev(), and TSM facilities can be tightly coupled with CMA
which had zero concerns being added to the PCI core.

[..]
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > new file mode 100644
> > index 000000000000..f74de0ee49a0
> > --- /dev/null
> > +++ b/drivers/pci/tsm.c
> > @@ -0,0 +1,346 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * TEE Security Manager for the TEE Device Interface Security Protocol
> > + * (TDISP, PCIe r6.1 sec 11)
> > + *
> > + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> > + */
> > +
> > +#define dev_fmt(fmt) "TSM: " fmt
> > +
> > +#include <linux/pci.h>
> > +#include <linux/tsm.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/xarray.h>
> > +#include "pci.h"
> > +
> > +/* collect tsm capable devices to rendezvous with the tsm driver */
> > +static DEFINE_XARRAY(pci_tsm_devs);
> 
> Not used anywhere.

pci_tsm_register(), pci_tsm_unregister(), pci_tsm_init()

[..]
> > +static int pci_tsm_add(struct pci_dev *pdev)
> 
> Nothing checks the returned value.

Yeah, it turns out that if the tsm rejects the device for whatever
reason then its state will never advance past PCI_TSM_INIT. Likely I
will make pci_tsm_add() return void in the next round.

[..]
> > diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> > index 8cb8a661ba41..f5dbdfa65d8d 100644
> > --- a/include/linux/tsm.h
> > +++ b/include/linux/tsm.h
[..]
> > @@ -74,4 +78,77 @@ int tsm_report_register(const struct tsm_report_ops *ops, void *priv,
> >   int tsm_report_unregister(const struct tsm_report_ops *ops);
> >   int tsm_register(const struct tsm_info *info);
> >   void tsm_unregister(const struct tsm_info *info);
> > +
> > +enum pci_tsm_op_status {
> > +	PCI_TSM_FAIL = -1,
> > +	PCI_TSM_OK,
> > +	PCI_TSM_SPDM_REQ,
> 
> Secure SPDM is also needed here. In my toy TSM project [1] I am just 
> using negatives for errors, 0 for "successfully finished" and positives 
> for a DOE protocol (1 for SPDM, 2 for Secure SPDM), seems alright as it 
> is all about PCI anyway (although "pci" is not always present in all 
> these enums and structs).

Oh, I thought the SPDM marshaling was opaque so the kernel would not
know or care if it was transporting clear-text or cipher text, I will
take a closer look at your implementation.

> > +};
> > +
> > +enum pci_tsm_op {
> > +	PCI_TSM_OP_CONNECT,
> > +	PCI_TSM_OP_DISCONNECT,
> > +};
> > +
> > +struct pci_tsm_req {
> > +	enum pci_tsm_op op;
> > +	unsigned int seq;
> 
> @seq is not tested anywhere.
> 
> May be move (*req_free) here.

Say more, why does each request needs its own custom way to free a
request? I am following the lead of proven mechanisms like bio_put() and
bio_free() where the bio does not have its own ->bio_free() callback.

> > +};
> > +
> > +struct pci_dev;
> > +/**
> > + * struct tsm_pci_ops - Low-level TSM-exported interface to the PCI core
> > + * @add: accept device for tsm operation, locked
> > + * @del: teardown tsm context for @pdev, locked
> > + * @req_alloc: setup context for given operation, unlocked
> > + * @req_free: teardown context for given request, unlocked
> > + * @exec: run @req, may be invoked multiple times per @req, locked
> > + * @lock: tsm work is one device and one op at a time
> > + */
> > +struct tsm_pci_ops {
> > +	int (*add)(struct pci_dev *pdev);
> > +	void (*del)(struct pci_dev *pdev);
> > +	struct pci_tsm_req *(*req_alloc)(struct pci_dev *pdev,
> > +					 enum pci_tsm_op op);
> > +	struct pci_tsm_req *(*req_free)(struct pci_tsm_req *req);
> > +	enum pci_tsm_op_status (*exec)(struct pci_dev *pdev,
> > +				       struct pci_tsm_req *req);
> 
> The pci_tsm_req is just an @op, three hooks seems to be more than 
> needed, could be just (*exec)(struct pci_dev *pdev, enum pci_tsm_op op).

The rationale for other ops beyond exec is to keep the locking context
clear.

That said I do need to rework the locking to make it finer grained, and
allow multiple physical functions to be acted upon at the same time.

> Or the idea is to extend pci_tsm_req with some void *platform_req_data, 
> is not it?

Exactly. req_alloc() is where the low level TSM driver gets to append
its data to the request before execution, and req_free() lets the low
level TSM driver unwind that.

> There is one "op" in flight per a physical device allowed in 
> SEV TIO, I suspect that is likely to be the case for others so such data 
> can be managed by the platform code in the platform data of a TEE-IO device.

Yes, I think one-op per device is a common trait that can be managed by
the core.

[..]
> > +struct pci_tsm {
> > +	enum pci_tsm_state state;
> > +	enum pci_tsm_mode mode;
> 
> Does it have to be either mode and cannot be both?

Yes, mode is "selective" vs "link" IDE. The TDISP spec also allows for a
third option of "TSM deems no IDE needed". However, in terms of what the
user can pick it needs to be "selective" if they want TEE I/O operation.

...and a TSM is free to not implement support for the Link IDE so that
capability can be hidden.

