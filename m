Return-Path: <linux-pci+bounces-2598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3AF83E20F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 19:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7249B2159E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884D21A02;
	Fri, 26 Jan 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhdkF37+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8313210FF;
	Fri, 26 Jan 2024 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295501; cv=fail; b=EoZZcGK0d3RgawkODgWqW4a8IZqDy+Wr/+wH8nXPJTBX+UMS9T6vDjYjxtuF2SR/VHwhZoRjyoeHw4ex72itByO1CHfIMy9NmwcLp8nL2VVznQRMZbbuPgjA8arppT4lgmSKBxhiSmqItJAoAXmpmOYxw2K/javMaOH69Kqo9jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295501; c=relaxed/simple;
	bh=L7JKSeE2xbpkG9CILERpBoyyK0ZNB0NdGweyoYbsJ6s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GTK5x/TsNSKg3b4jr471fa9n2jSAL37qGy1EMkvRtowlvpTMQ3Rb578UPXyp6IzEkKwdT48jXBQZ+hT/K/RBHBHaFWCRIh1Xx5j6DEjrErlEealfMGF6AmRLDiJfPqVMRGNfnH87lnDcxmyIql5frnIUB2Fci0m+U2ygV5+y8+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhdkF37+; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706295500; x=1737831500;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L7JKSeE2xbpkG9CILERpBoyyK0ZNB0NdGweyoYbsJ6s=;
  b=AhdkF37+wSCRyEXHiUtaI9LlavDyZcOZFvb0YYQiSjiNQU4AinNUD52I
   Oy5bnOGhQzGZsYaIqVTmV4sVzPTThKXF2/7um/jMpPWv804WOc5BH4U96
   QzBng1GVHNT1qqwSAJzNMaCp0l8Grkk35u3ZdkGqq+Pd0WsFtdjLmDVHU
   N5fMeQ28Pb/sLGh6soL0QJDoTuLQlyD8zvXfs07Lv8uODe4OA06urDmKr
   CDpfEb5rLRao7TlWXMHvyiviLfBPN7sZPTNupZZ3bH4HAmjDyc081BQUm
   uyaQS+goCgs9CN91R9+JAF1JzB2p7oyvd2GAZH/2zvbOTCFTSv0zvQKpI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9658773"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9658773"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 10:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2805919"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 10:58:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 10:58:13 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 10:58:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 10:58:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 10:58:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHcR4Mi8uwEK1s9KZfaSJCR8jx6yP7WpN4BHKDw6YV8Z0xsGk+ljadJ4u6zibBlRK7tP79gMbw1t9o/Zz8L6YVQ4PZ7Kx17GNB+5lbMOAqvyL0DCTjZTdzT4D423lXUuka8WrnKPSjK4ZgQtdl56Q4tPLc/lByNB4dx8T3DkrINjqhRt/M9Sk5kfFPpWtyuER55MPGJf+PEwL78NY6mg3BYt96FiUojIwfNaRrqePqZQxLRYmX5DKlXjIzSL4EPrcrreLPkN40yVfd2a8NSY/d3xsfZ+4mC6C9YQNdLrKFk17BSAOym9J5Qfgt/TIDPPLuIeXLMvjyNJcjE42hYWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H14TL+X+joOwya4uOGnDylgPjKGLMI/0dqwsvpp7pmw=;
 b=czCKa4MvE0z9mPkkMlBcPijOk4JBMDioRGYxeR2xslIXCfBv31IIXWK1noDZBFKFhbKT0w+5csin/rOUjlAj9cN+Xvsuc5QD4czuPRXnte8WKRyHSJPzjc2w1nT1DH9KqDdP0EPH2h5bctQW6OA5XYLMj3nwqZLSBqkrszav0PZs0uR+Rai2L/9ilMfUk7L74VUW0FDfSB7WFExuydT8Cuh9nsdCVtirOw+vCLihYDekMuPnBLm9a15vbtBwezWtgYE0FW7iZDeUywDGBKkMGECuY4bUJbic5M/UZZj3SqICDrei2WbwwaWsjq+vGEp5ZiRofqdi4t3jFulMGbDTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.26; Fri, 26 Jan 2024 18:58:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.035; Fri, 26 Jan 2024
 18:58:10 +0000
Date: Fri, 26 Jan 2024 10:58:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Greg KH
	<gregkh@linuxfoundation.org>, Alistair Francis <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<Jonathan.Cameron@huawei.com>, <lukas@wunner.de>,
	<alex.williamson@redhat.com>, <christian.koenig@amd.com>, <kch@nvidia.com>,
	<logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
	<chaitanyak@nvidia.com>, <rdunlap@infradead.org>, Alistair Francis
	<alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Message-ID: <65b400bf65c33_51c7f294c5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <2023083111-impulsive-majestic-24ee@gregkh>
 <2023083139-underling-amuser-772e@gregkh>
 <2023090142-circling-probably-7828@gregkh>
 <2023100539-playgroup-stoppable-d5d4@gregkh>
 <CAKmqyKOgej1jiiHsoLuDKXwdLDGa4njrndu6c1=bxnqk2NM58Q@mail.gmail.com>
 <2023101113-swimwear-squealer-464c@gregkh>
 <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
 <CAKmqyKOOSBF7qDpqAp6nn3+3wAnaGmqu88Fk3KY58fmgQ-44Jw@mail.gmail.com>
 <2024012321-envious-procedure-4a58@gregkh>
 <65b1739b2c789_37ad294f5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65b1739b2c789_37ad294f5@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:303:6b::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ac0c7a-99b6-443a-effb-08dc1ea0bd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuRnAx3EvAGepisGPMIhSx3hpW30qX3MibFupLN9Y+gpVFk6WGbkoqBO0o3dnr+P7LOQPDu8M/nWOJrK79VSJZcUKUXLlBgQah9vtaFEyO7Jo2gfW+anNRzFasGKYCI5bMHjyDfgATtphqn1s0eVjEFDzx3M3hQHosAaca1kKqYFQxKUplsO/c7FwFPGps0yCUOpRm7nT2t1tF6JYEPk3BVt7/ho025MVhiI2mCTPhQ1W2xE95C49AFHp+r6oqDR0V7Z/vz6NVoPnVBUonbrd+IkZmkJ+Cd1xk5jMk6MHWGkebw5Fif54CJCKil0oi2kLy0qt6dC/5Tno3zvCoGmwM1TAdJblLoq+pM5vtcbtjWWRFS8mRHRlpf78itohWlkbCmTKLA+A3gT4k+TX9afU30nOOEm2VoBY+j3PFT/ykPyfqxeHOwX91vymbJoj7WwBETH+/bWIKXmHPnenDgD38KgyHopSpQn4fn7SD80JIwtubMzkVHuxnoVCApZaH3xXJDZUV178QhrzNufBQdh7bBIzn6z6uSzYLuJyJFEQ+y5Jsk5Ne17uifO2Hr5cdYj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(110136005)(86362001)(82960400001)(26005)(38100700002)(9686003)(6512007)(6486002)(41300700001)(6506007)(2906002)(478600001)(5660300002)(316002)(66946007)(66476007)(53546011)(66556008)(6666004)(4326008)(8676002)(7416002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DXs6nuPKRHL/35E0ueT3MF1jso6u+J0Sa2WII8FF/cAwR6+pQL2dADGuCECj?=
 =?us-ascii?Q?CKPFQ9lX2fKxpzHWC4gDM1l6MWkRnV4ghIt5Dey1/f/SF67ErGHL77SvAnfV?=
 =?us-ascii?Q?+ntkzq0ss5aRXM1WC0VbPtBFwwsH88Vye7yH6kEyYkm3mHPYRMhtAqk+YZ9m?=
 =?us-ascii?Q?Aj7YU3+xImkbhxOHXYjLm1Lmu+ifluA2MzjhSbzzzMFvBbRJ56uUXOoheydD?=
 =?us-ascii?Q?J9Jddec7foZqoxhLxYGmr+WGe//oJLaS/CuZc8gW3GqtGAdPxgMuT36EKicZ?=
 =?us-ascii?Q?+qQ2oRNYpvhF7YFOm3l/EpAjJbjVYxMM47M/57yqkIBYA0aDF459WR+4eXYH?=
 =?us-ascii?Q?3cgfRaGX0Jny1ghvWUUoxdGNszucsprjuR902KQQN2XJ5dAyzsu8/HioySrE?=
 =?us-ascii?Q?qukjdYWnNnLWZ8gRkkyRT0iCDgD1NR4he3RUI20krW2jnHhIcwbpOEp2VMRu?=
 =?us-ascii?Q?16ZR/5SnHuBKSt9jgu43l9C13xkyrIvQrlm1opikceNddpfS74P385MS5mS/?=
 =?us-ascii?Q?trC6z+Y+TVHCYIDZAFFRb91ljw6dXqSXQcBMam3fJDDKDTT8pL5OqYKOKH0a?=
 =?us-ascii?Q?/oO6Rm3TCZ9UMSUJ++htGgvHuClaQjqS1kE1g4kNfWiLViFq91l0jj1DHjym?=
 =?us-ascii?Q?8rBMhcFffY6pTCBMP6uw9ztwyliYBfPXCvYwfZV5g5bcghurqIXGGgtMXLIH?=
 =?us-ascii?Q?EtXbfKc6Xt0H6DA1/SwLCYgD7GcPviqOg9Rt+7dE6ew69iHTU8NQZedmSuse?=
 =?us-ascii?Q?DXbAUoQE28dSjDPo/oap+Tojwj8mFRnKJw0R45C6edOgf4TSEo2NSn1NF735?=
 =?us-ascii?Q?QDZhNCgQLT1mPCfuQONIQEPOcb1YDxbngvywphR9VbM+dub37C56byV0b1bI?=
 =?us-ascii?Q?tRoLUOmcagYWr31By2Pw6XxP4eseGLHpKL0+dJt131doHDisYU2CwyhmCSc+?=
 =?us-ascii?Q?JSrYKEN5vw5V3s59z3KTp52MIr8eFYsFffCthqFzEKS1HvKh+3NCy8qA2VGJ?=
 =?us-ascii?Q?ehB6wbg61gXb3Zq1wHaXFDMW+MKQNfE4Ih3+yCPnIbOIzhh+tAEMRvmAylWN?=
 =?us-ascii?Q?OxjaVXh+WQz62VtJTUHMgaNha50XeqqqJKvCj5lJC1k5gYSDveRAmiaCzbSx?=
 =?us-ascii?Q?vwVqsgEtyVAhBPSgZe2c7u75jT7fz0k6iQsNKn4evfCymwtf1FCeaFSAG3qL?=
 =?us-ascii?Q?sxTWiKNLmZtRr2B4YvRJTN46+4SUdfBR/DbD+M2MeLk5duPwuNjeagJbkrUB?=
 =?us-ascii?Q?3swJtXlLkwWdFi8HsenlDsCqBJQk0ufnOQTjeDbejx2zBV3g611fTGNx9MSH?=
 =?us-ascii?Q?K8ylEMHllsP3/NtHQ3Ny7SkeMbUg+rP30dtJtn+mEJjyfFg+S8qYQabYSJAi?=
 =?us-ascii?Q?68kPP4/oQTdYJfvafCZhnF7enbV1vvoK5VO8p1eNIAS1fWHXUAUlbakwvWw4?=
 =?us-ascii?Q?HZGcJBday1oz8ojBZiuVQTT+Ga0ADX/BOTyzLy6u9QcQQI48c4JLNYGubOAr?=
 =?us-ascii?Q?g/4uZQ6ojpcgu2PT+NQGUxmjbzBCqIg37L1S1RbwUxjwzo3j3RAU5Mm128qj?=
 =?us-ascii?Q?A1VmP0GPtZfdnfU0CihH6UZ9tnJag/G5DaGcLiQ8oBdSeZRoZIqW/sf7yvS1?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ac0c7a-99b6-443a-effb-08dc1ea0bd5f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:58:10.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2myysOaHw+4skT8/8RC7GdVmwQw6JPg/f+XR2n3VTCGVR7Eq5Qj1M/rcyzTSPR4dHKehz80a5cRNyzUppa+6whUTF87rZo8UVgYHf0qWlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Greg KH wrote:
> [..]
> > > 
> > > Hey Greg,
> > > 
> > > I wanted to follow up on this and see if you are able to provide more
> > > details for reproducing or if you are able to look into it?
> > 
> > Last I tried this, it still crashed and would not boot either on my
> > laptop or my workstation.  I don't know how it is working properly for
> > you, what systems have you tried it on?
> > 
> > I'm not going to be able to look at this for many weeks due to
> > conference stuff, so if you want to take the series and test it and
> > hopefully catch my error, that would be great, I'd love to move forward
> > and get this merged someday.
> 
> I mentioned to Lukas that I was working on a "sysfs group visibility"
> patch and he pointed me to this thread. I will note that I tried to make
> the "hide group if all attributes are invisible" approach work, but
> reverted to a "new is_group_visible() callback" approach. I did read
> through the thread and try to improve the argument in the changelog
> accordingly.
> 
> I do admit to liking the cleanliness (not touching 'struct
> attribute_group') of the "hide if no visible attribute" approch, but see
> the criticism of that alternative below, and let me know if it is
> convincing. I tested it locally with the following hack to make the
> group disappear every other sysfs_update_group() event:

Hey Greg,

Ignore this version:

---
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Jan 2024 20:20:39 -0800
Subject: [PATCH] sysfs: Introduce is_group_visible() for attribute_groups
---

I am going back to your approach without a new callback, and some fixups
to avoid unintended directory removal. I will post that shortly with its
consumer.

