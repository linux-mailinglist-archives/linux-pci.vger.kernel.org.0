Return-Path: <linux-pci+bounces-3268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0184F004
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 06:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9784F28B1B2
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 05:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DBC56B7F;
	Fri,  9 Feb 2024 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hd62pLNN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5F4C80
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707457910; cv=fail; b=k7GArr7kj5mBla/BNY0IsW/mrR4qu6IfUGjvtULv5ujyF33ZasaT5Df3XOttQu3eMv/N0JB0u4HBfJ3RDIqQlXsN7e8YwZ1ksqB2D17sccyoeiNdDWKlH4MBgmS85Raa5CC609TR9Bwy5kuk6xOu1cdN3CRRPQF4X5yGtbY7Z2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707457910; c=relaxed/simple;
	bh=pLxxHVcgm7jaWGTcKZ1NBETeOfdKVuSMqk0EKjHCceA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oAtXHlK3VcxbShDIyX/d0/jJT/izemCRUeNz/KRf0S995Bat9kykStI9R2n+QD4eLVntz8TJ1xcJREX2SO5Gew2lX93ZHsgH9MJmKct03OlSI7V0r09UPRGKKwLi3keWe6vud9wUX34zIFzNwaq2bA0W1qOS1SAkU80NX3ektBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hd62pLNN; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707457909; x=1738993909;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pLxxHVcgm7jaWGTcKZ1NBETeOfdKVuSMqk0EKjHCceA=;
  b=hd62pLNNHpwBx8I1E85EZN1ON69hn9kYP1QXF9j46foDOpFX+1rtbf4l
   4KZC2V+QFqRH7GMFnjsYVCZcHZlO5Zl3w7ra0HqYGAR1mB0jgdHaKG8fS
   pddkYe/+oL7qNKmrrb1uCnuQFxOU5FxgF3GRDqwanCk+gFHO0wScv/e11
   rBcmji5BwOKaXnBxH4ImUIvhCgO7MZdtzvoNdFZI3k0swTwQmr6FrThjF
   Uj4ub+79er/e2XD9VqqzWGU4Rg6nv6GF/DxBQIVAl+Ws8tvXA7+ESKfTn
   jBTtQnu1rhGzZKyioY358erMxaCNHSQi+5EjJSt2wOe3wmuNMt9405S/Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11946356"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="11946356"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 21:51:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1849929"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 21:51:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 21:51:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 21:51:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 21:51:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 21:51:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4SmQfGWqLdcwfBwlzj0QJGE9phBVnGADKdUNRRdbFfzJR3CCKzEJb+iKwhc1lzo2O0oJ3Z2LdQFTgySxEIYzxRqDVbGbGMAYxFQ31IxHXTHm59qOYSFvX0f23KU3mUfqeulsrAQ1ZtrZFyKU1zuXYFcLp4DzbpWn7Q25L8hXCCJ4vj0xeIC5LapJa088HiCwdiaIbsad2owxSIrUuVLugBiPFUW/r7OEPgD8q4I9UfIyaNfD4zLuei259NW+QWQFbK9Ft/aZqdwSXI+xWr5zy1QislvxYZNpcJPvx17yS/0HkJWWOCmD+S2/noDKlei93Y5SsMuvt1nYZxc9yiBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P66E99oEgHXqnYBFOLzaBeE3L20xELLbIsz/Dr7gDJ8=;
 b=LhPQEdCWBZV9a1LNR3u/FiTN7ERONUKSezZ5R7cb8mzLQT+qoK3D7tKn3Y+kDwxMldPG9VR5JyVdJ2Sm1ebi2b0CPYxW77W2DroYTI7/CnZjVlZAdK0WpIqGPf4JKjQq2CGgixYJfs2frC8TSlpbEhop7JNPza2y8536eLGNf6LGvOfxNnneo8SbnYeCC9KOTROuwUSklZPGckKKwSCuRKYhvai0cHEKQw4pjWRo+x5DaruEeRDPtPIRy/egqpoXfIqKIoJJkyPnicVqyge9jgAiaShuYYzs7lYt1GJ88ttsF62Z1Ep7QdwdzKdLCg5CQhBdkBPBsAecQmy6JgaVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Fri, 9 Feb
 2024 05:51:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 05:51:43 +0000
Date: Thu, 8 Feb 2024 21:51:41 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Wu Hao <hao.wu@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <65c5bd6d7243f_5a7f2941a@dwillia2-xfh.jf.intel.com.notmuch>
References: <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
 <20240208221305.GA975512@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208221305.GA975512@bhelgaas>
X-ClientProxiedBy: MW4PR04CA0379.namprd04.prod.outlook.com
 (2603:10b6:303:81::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 912f3f27-188e-4fcb-1f21-08dc293331c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z52X1Oh4uXQJZsZM27Ho8TuXIS8XHc4Sv+SutTZ7C4WQ5pt37X1w0xd4ag0Src/cf0OnMdNaIOxJInkeOZnjOVN9MHyk7k13Q1QgbOCxeo9X6OVCwVoROb2vmp3V7Hsabm18keGRvKx8w4CLjS5ILtrMODqUO+Qundtt2UedYi3hnpG1xskiTixnk4IyvA6TpCZfjIInnTORU87VQS4wu7MOJprJXLYb8hsSc0uumPBfo3g90fXLaohZ39Rlu5kcqYqAyPRvbamTXjz+Woy8Ii+MuCBucmnW7o+ybyUGfoCdnzvh8yGJPPTTDRgrq10t8svOzvNb878FwfJataOWwuaY3oyquWnQfzHL+4NPMwuZ8Ohsgb32/mQlB9TOy/z8/Hza5PToVjmF3wb2uc3P+86+UCNvFsgXMMAUNl4hhW5shyneutE7vowjHfAANDl4gZroOr6yK7+860/NseiVpHIv66FiqERZORlGX89+hmXz0At43oAImu7bBwtM9dhhAQPI1wR2AwyvKvxXh9fAH4p2ELF6bzS8z+vHQxJoaONu8kQ6QtQvXDPxBfD8nZHa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(82960400001)(38100700002)(6506007)(83380400001)(9686003)(41300700001)(86362001)(66476007)(4326008)(8936002)(6512007)(8676002)(2906002)(6486002)(478600001)(110136005)(5660300002)(54906003)(316002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MzTMjcMLLpwDrGGpKeQXqv4P37wpwMdyiJ+qKL/26BSDtGg3kal/LjR7/DSC?=
 =?us-ascii?Q?SgpVZUURtoe33cWEn3tOh7kKci6ulbOIRVeJz7H4M8twX91gZkNuYjN3lq/w?=
 =?us-ascii?Q?Dtt1I4ONuZ0IS+QnTTC9QuleytTyq+bT8d8oJXdEm8sxUxc/25GKAZrSKpV+?=
 =?us-ascii?Q?NRV97644O6xq8A+tW0AVH0/JMtd7IhFDvplYZ3vczGKE1iL5TUGfy19aPO+L?=
 =?us-ascii?Q?mGNund55PkqHN/Ii/DsUsOcT6Rf3fVZRmoAaNh4p5zZcxGlIn8VC3Rp38s3n?=
 =?us-ascii?Q?ZgfQoW2Cuk2tE3QHIS2vo5FobqfSETIk3XYY7XoOz/cA8um+R013qwTBaqIs?=
 =?us-ascii?Q?tGQ/pEs/5V+jdnl9crSwH5Iqpw9eEw7o2BiwDcm4+07B5we+n3ULItM+PivA?=
 =?us-ascii?Q?krCP2olxhMD0gY6BWpOrs0KaUE1W1RDLHSClfGzaODBDqM/43GEl1OHIKT4D?=
 =?us-ascii?Q?wBjbWgc9QF7KCvbK1S4ON+Jl1vTS1czPX52aJU+Mz6vINzJE9+HlRAmtsHfD?=
 =?us-ascii?Q?r8U6zWoEsQRHxMYj+Kn1xdxHW5l/4nEiTMggmKAwWoH/J9S7Qv2EcSDAtdkL?=
 =?us-ascii?Q?wtfc0/2kLpiElUsJsPLRV+tErBesx+5jPp+W2fcYoWVucne1k4RgX+FfCh0N?=
 =?us-ascii?Q?Fvekxh2s4bhg5MYI7XxN4MOHuGCAOzcintssVSRNJ9PEp117eRfr59XW2lP7?=
 =?us-ascii?Q?h/nAl8eBkKxIDS3VTx66UNRzIMwU67ru15g62T3oiG03KUT5K/5b2l2Ua1dW?=
 =?us-ascii?Q?DoDdx8yiAyecIYkC+QvzxP20CgWDOKl4ZW/PdHRsrn0NdAc/oTLV5B1c6ECx?=
 =?us-ascii?Q?D/R6w+bk3MuVXaVYsVJ85cWQVEgpnaa5jQubYQUWXkgFOjDMVaguh2JIfrNh?=
 =?us-ascii?Q?qvEBxUBQrvQrgOGjg9ILKkVVWIfBAsk/++0TWWeqTv1pAAwajzMd1VARXEDh?=
 =?us-ascii?Q?6aawKb+aXo2QqO/370/puYCscKJvDWzb8Kz85gaE9kfhPxXHfp3cI2ZT1XDp?=
 =?us-ascii?Q?duRmn2sG880iiXcYVGLEvHm5eeKJ8hytd7o2KJD63ac6APHgDmiGaxaJFf8J?=
 =?us-ascii?Q?DRHYU1XNvdznImVzYVlYuGRahjZEmX7N0zFECrdVr8p7SQQqyF4Uk9/ri5K8?=
 =?us-ascii?Q?hKQEsPbBEiSxM9Ut1Ba2Yx9XT6Xa1sfwLy8cEi9RW4TMxKEg75fKuEPq9+x4?=
 =?us-ascii?Q?uPqnFuocd5J93Ks0kj99TQz0V4VmqzeuMGLtueuzMxrx9co8APnEhQR/CD6h?=
 =?us-ascii?Q?EqiebsAWkQvQxd/TkXSl0uo+pSkj8rBqXM/tYazsf3N/8o5iGxZdU4CCu9Sr?=
 =?us-ascii?Q?LKL9z37ilFGc+SIm9ggNA4ERifjZFAUtnoyO3SbzOBhk/00zKaplrAioJ4sB?=
 =?us-ascii?Q?kSkeZ7Aq8gnbY98KO2FsW6/wWio2zOUbeFE02BZP0iA8okZnVzhwkcgDmmbL?=
 =?us-ascii?Q?1/lTzoFeOaQyJNAKOzlcqGM4dq67gu2DP0gg+3laoBCR9aC84ecp6KkNQgU1?=
 =?us-ascii?Q?Puo3DPfWGbuUF9UB+CJubmIsvtjznlrb6SEZ/k6RhlWa8LjQF/+0GM8GtgTp?=
 =?us-ascii?Q?V0gkUM1UUhUdVDr+X+6oj/bQX/Y9gGV2yLfjF2JEq7unIAxegfm39Owq6W7w?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 912f3f27-188e-4fcb-1f21-08dc293331c0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 05:51:43.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiGVXi1ddMI1H30exUCByNV8ry4MhH7mePUzmBMo4/LWP2/lkf4miXpvzETa9Qb5fuYit2crTn5tpPVjwMERdFvF5O8BTXWkHNXQOasu3lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Tue, Jan 30, 2024 at 01:24:14AM -0800, Dan Williams wrote:
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
> Gulp, this is a good start and covers a lot of what I asked about
> [1/5].  Should have read the whole series first ;)

I should have at least left a breadcrumb that the acronym soup is better
described in patch5. However, the specifications are certainly dense and
it is funny, in a laugh to keep from crying sort of way, that the
acronyms nest. "What do you mean the T in TDISP stands for TEE!?"

One interesting sidebar I had with Lukas about the naming was an
assertion that "Bjorn will want to call this the TDISP layer not the TSM
layer". The rationale being that the name of the PCIe specification
chapter that talks about the role of a 'TSM' is "Section 11. TEE Device
Interface Security Protocol (TDISP)". However, if there is one point I
want to get across in this posting is that TDISP is a protocol that is
spoken between the platform and the endpoint, i.e. between the TSM and
the DSM. A protocol abstracted away from Linux's view. Everything that
Linux needs to worry about is behind by the OS-to-TSM interface, and the
TDISP specification says next to nothing about what that OS-to-TSM
interface looks like. If it had standardized that, the job would be so
much easier.

So, I think Linux's role here is to act as a "standards body of last
resort" and try to hold platform definitions to a common understanding
of how much complexity is reasonable to export to Linux. Assert that the
per-platform portions intersect Linux at the same level of abstraction.
Basically, please no vendor-specific layering violations sprinkled
around the kernel, and enlighten the PCI core for core concepts (like
authentication). Do not build sidecars.

