Return-Path: <linux-pci+bounces-4074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC278688CE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3A1C21010
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 06:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C89252F98;
	Tue, 27 Feb 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHz7kOSH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451D52F87
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709013613; cv=fail; b=OcG97i1ZCJkouTa4gff15UEgZw0kYti5gvtv8PVc4TQr/1Evsm79dWLMGxwMR5m/tz7lCr6hNvf3EFZi9jzNaYdtrXp40AHDWMC1STVeQoA+3rq5UZ4EezJCzTU4jM/Z+RleqmbTkTMP2s6jke5hmU6OE0Gxmm8qCJJ9kBKKo9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709013613; c=relaxed/simple;
	bh=ImakxVXNCTNaOgU3MR5jtw0u5ayBBVLwohkDWJQIRIw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p1pVfO/iXP4cWixsRU9ahYCouIiUXTgwz/FeucTcpOEyKIvMq9AdXBMlM1F5Bv7z9uQfe8oALNOXjfqz00dHEd9acE7/nLm+ny/cSoyjNdowAuZWInZv0A+LGbk0evid3fwA4bW/nMF6DhWkhjkHneuicSKTFU9oe8usUO9TWCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHz7kOSH; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709013612; x=1740549612;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ImakxVXNCTNaOgU3MR5jtw0u5ayBBVLwohkDWJQIRIw=;
  b=WHz7kOSHIEPoDIxo36Vi/9wtmCCOuzVHiyePfSYXvTNvuOAvmDFbeC4F
   abu5biPdoEIbbtFpdc424+vN58YEZx88sNo4CheK9lEYo2z9y/r73RFKe
   yj67ai+GEMcyOXda9bzzbGF9dgOXqogu6FJRbyOQnBaE9BScRZ1zyau7c
   QslBkwBwMCe79dGNG+nPsOSUfdVVdhD5IV+HhQ0cpL+NTDTCUp7HOJoLo
   oVmA7mfCBmb1Z3sKHyXIhYQMVxRAmOmnECjgMDWvDuREyrKoBpVPIVFQj
   eJuq3xfwhEUTT11p0D0Tz5xVuNK839QGtqGzX/M3YK6AXWAyumr6tZRyB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3213897"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3213897"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:00:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6957483"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 22:00:11 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 22:00:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 22:00:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 22:00:09 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 22:00:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx5l5Rxe37NpkBwrYSGXifYHysLgwQO2KInC0PBYEIxGNmGOhVCYRrC8FfdoqOeVgSpneMUHmlu31qHuxG8F6r9QpBGpKSQ4d5gbRhaxMXLssNri1pUEVNuZB/eYr9BYdh0yiY2hcl3081iS+ttX1WxxPhMRt2EPS6spGeQXN4wS2GVZxcfygLjKRO1o5eX2UgPxv8o1m2BbTevk8vqKwe7dry9h+FxslrPD6q3R++Al7V9OtL3NmTQmXyn8PjTN+UHSiql7P2DmEs2brxDW9/r/UY2JwhdAa7GfCU/LRZCdETB/Zeckuy04AUAdkLkG0l6Ypfh6nhP1aCWCIv37sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DvWVyhwx5A8R9H5hfOyCVFtMe4HWWOPtOcm7OD0JwY=;
 b=cXVp/SDN1Zdas1KY7ClPxsXcpBkD+Onoc1oMlMUKy68QcfN31EOvobn3SAfcXexplFqP76hew/U1jK1MUPasglvR5h/9zd7woBOsQp1pQr1NltC6oWLC4SjEy6mrAz913glEI4jlr38UjNXmjD12ML1X+ewqFbWc8oxiiYysmAjMrozndQURvrdlncfNm6aFCs3EDEwJ/7kFKsgDEhAcuUojokYYagymOXmEzDZd/XF/xCB9mrc2c972dkwupXo9Y+qYofXEhO8g7i/fpehmiBv/mDMHjn4W3IEOccMKTnSdhzeHqWi3rkue2XIJuc4ymGCt3+Xc42ISfoxfeBbNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB6001.namprd11.prod.outlook.com (2603:10b6:208:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 06:00:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Tue, 27 Feb 2024
 06:00:01 +0000
Date: Mon, 26 Feb 2024 21:59:58 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>, Lukas Wunner
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <65dd7a5e78ded_1138c7294f@dwillia2-xfh.jf.intel.com.notmuch>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
 <79921a75-6d90-4d7c-9aac-5df4430cf985@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <79921a75-6d90-4d7c-9aac-5df4430cf985@amd.com>
X-ClientProxiedBy: MWH0EPF00056D11.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc2a224-3bf2-48e5-0af3-08dc375955b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMBi2wIJIpNHD7uHFQrT2gGNpNAEWT6m5eRzBMu2QTqqvbX/LICgUQzJ/d5BgK4KVNnoQ6F5dbcpyb7qECljooLRPTjscRTldI7f30C5J8l4g3xX1VAYDnrtYRURjGOj7ufsdsZxI1IHAOqXCYoSJQ3ID67JF72QAx1b7rNRdani2NjQcVpf4FviW+j9yLSEps9iqzN70mc8A6lgUZBd55an/uR/bZzEDxR6CrwTf+YaCLAcoT2sRJX0X5cZ/od7B/3S0agwBUfDFXgr6p7fkXf3tEDKe/JmN64qH2SQo2u3jyuQernT8eT1hDdBP8a3f7GsFrkNAfKwxGVbjcKfW2Dk163HK42Pxrrs+XlFn7LrenbV7vAdBx4MV7oUJTfaxW01IOGbvKm1ijgtvBmium0WW8JxSKi39FAreY0SMbjMDu9oJaedkWaWKVx4VZMg33YvtFgkgDJvpO018mmzQ1mFhZjjHF2mpnr/z+3RBKnr3N5X6AA7Fsgb+xrmw4DaD0HgkA/F9qTXQLqvO17tsTAon5ScqQzyE+0hr54smnLq3YTzfvxrA3d3Vrf97VwM1ATNOQrd+aOSlwGcKeu7YiCt8Np0/mWK3DaJ3M5cCDTCLU1eCNw3ZV+a1K74nmdZDOdJZQ1VWogfJFDYZqn2MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Nt2UEb0/bHnjZp26EPVwEJ1Y88KClINBMaMKi11E45/2mb8YOoAS5eKTTHb?=
 =?us-ascii?Q?kUDj8Uobw2Xj/e+VDDjHp8E4zdhYO0nwKxh4gqmfOFHTRaJ/7l7e5RQW7gGf?=
 =?us-ascii?Q?VhUtXvCWbimfOngseGU2q2J+ZsxDm27y8aSMZ2JKwEl2cAt+X6gG/Hhz7h3R?=
 =?us-ascii?Q?eyOWHc+KuyyVH5DpAR2lGlEymysUhO/3GVY2ZDOsy2CK73pIJi1hUDGnxY9e?=
 =?us-ascii?Q?Cy+KfOs4uvqpW1I7MGEVyqU58+RA/jBCimDy5DUgMLHPO7P+bG88z/98A6ny?=
 =?us-ascii?Q?cRUWoyZ0Gw9M+QiDA1peePscpwY82Q/2+RQcl/mqo2i+RXSsx7fFF4BYCrYp?=
 =?us-ascii?Q?gHuA2W6xx8eaoS2tQvr0Og2pwO/U4nKv4qdl6SaDdhsPFOQYdfMC6dBM8cxj?=
 =?us-ascii?Q?ysPwB59dEhzE2mtGjp/zd23bMbba6zpTR4Lnfbt30io0/WjRB3NB2waXvstP?=
 =?us-ascii?Q?da7hK62+7soi7VdYijQ3yMTYa8CgD6qsdkLesggpJALWbH4f4MU+Y0/aNrtV?=
 =?us-ascii?Q?MnQ4oJD7SGi4RkWxJaNq21xn3LhIyZVhE6/yOD/WyGG/sBfeplCZv/pmW75Q?=
 =?us-ascii?Q?lfqQy7hw8Xacv9NXsaD8uSgLoPpu0oAhapR2+IEHYFzeyvtvw6UzRYoKsW+G?=
 =?us-ascii?Q?Rc2VL13j7Dbxkk+CsIyCSfK6bNs369wc5H77EHake43Rmj9rRhsgk5xTmVrZ?=
 =?us-ascii?Q?Z4xY5yaJL5qkrxShXUrOLLhu1q44lLn0p9c4rCsR6gR2zpELbbXH7/9X8xYO?=
 =?us-ascii?Q?+2+zXXjfzqxleUUIBJ/o2AtsSfTKr2ubANgumJT77uqEG6W0JAXsBGOz9med?=
 =?us-ascii?Q?QHTEsO80RcNeVOe26jyjJEjqsLafCEJnraNopd44oWJ2lb/hn29j33eNWoTm?=
 =?us-ascii?Q?NIL/akfORbkhqarWg6kjQOG76/ft7H0P7F9otXo8mMiJFNEnv3xhZ0e+sZXb?=
 =?us-ascii?Q?FpfsWl91BVEfcuV8kmHfCKJtdyLdFZiGGMgLjRmWIM3BT2mSmAkFaDXiyPU1?=
 =?us-ascii?Q?Efb0j/kcSljOus01vSmzy4CxdasOeOLfeL1LCU/k+Zz/tuOlreUjh2A+/fHL?=
 =?us-ascii?Q?BphJLeQBuwlhKPSxQZ16IqT749DdqDNEEI+Ixch/MRSrKE6oIFCy/bWk2BhN?=
 =?us-ascii?Q?2sDp6nnGkAVGidR97e7fBifzDNAArtbB7/A2nao5SsESm8pzRs56zCHR/e0D?=
 =?us-ascii?Q?F6H6dzscJK2km5QSshNo8Cbzp9KnX+CXUZ1V/aAFhk67abHItA0CGT46IOto?=
 =?us-ascii?Q?dr5yQ8eF4IqfE+Yomuq3XFgGw3Ok1v5z5k5gwUqc4Zbm7ep+HiD6YzZPxLk5?=
 =?us-ascii?Q?2gfxY8sE7X3AeB1DA7vmWT8XozDoffiiTGGVaa8KuZ0AMwiRKAOG6J81Es87?=
 =?us-ascii?Q?L1KnQccqM1pKdSCi2h1VtUjoUWgiiTIjjfdpKrI7CucwVx2X0qr/RuagQXyC?=
 =?us-ascii?Q?DASzTvFK9ywu3hXxOXugQ51O/bbFlOXxOpZSPI4uCaROJA951SrqNwM6+/FD?=
 =?us-ascii?Q?58ARF70sdT72Fir5tgHKUOHnufXlqYPAFcyLMTQdQu+0KMiVKTKyxpLBiXpT?=
 =?us-ascii?Q?9yo3CCfIbb75zFdgLALmcNx3WZkCK61fAcP5XrxEeaCvf0TOLwp1+EDL+qf7?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc2a224-3bf2-48e5-0af3-08dc375955b2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 06:00:01.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20xIzhBKD5M+AZCv5tyiHROwFqQQbnaclt18EAdnTBNkS47ZdWhvN3fAlJ0JrzMDih/NjKEdn0PxIu9NUhvsiPnkMhPae9xK+lIE/oDOUCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6001
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> > index be7d2bb21b4c..5a69e9919589 100644
> > --- a/drivers/pci/cma.c
> > +++ b/drivers/pci/cma.c
> > @@ -39,6 +39,9 @@ static ssize_t authenticated_store(struct device *dev,
> >   	if (!sysfs_streq(buf, "native"))
> >   		return -EINVAL;
> >   
> > +	if (pci_tsm_authenticated(pdev))
> > +		return -EBUSY;
> > +
> >   	rc = pci_cma_reauthenticate(pdev);
> >   	if (rc)
> >   		return rc;
> 
> btw is this "native" CMA expected to migrate to tsm_pci_ops? Thanks,

No, CMA is independent from TSM enabling. So you have the option to only
ever authenticate devices via kernel-native CMA, and ignore TEE I/O and
the platform TSM completely. Or, once CMA authentication succeeds then
the kernel additionally allows transitioning the device to be TSM
authenticated / connected.

This keeps the Linux device-attestation ecosystem healthy, standards
compliant devices with managed certificate distribution.

