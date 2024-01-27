Return-Path: <linux-pci+bounces-2616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54983EA56
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jan 2024 04:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232B4281847
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jan 2024 03:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03252BA28;
	Sat, 27 Jan 2024 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioa5jSJZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BC59475;
	Sat, 27 Jan 2024 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706324445; cv=fail; b=EtN2zJ24b9qNUCy9Glp3dci23kSUcg0fKhhkRKV4praR2n8gQAHRYYKQqVd1VBA/Kgidi4tA0LEj82MTpFGUwGtMlTlh6sU6YrB+B8CXjjLONIBC9rYaLZDHCUeXXv2rqVa/JDv0SmacJpcrTS/33lhfj/8i2gDo+hcoHDLbu/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706324445; c=relaxed/simple;
	bh=RO19XOQwT2cCDZVkfpRu2QOFTF3cxLMWAwdofOJHmN0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hcpTlibrsmLDCjI+pZU/jXiz7I4E7fM5+FPepoHYN4q9WHKjy6ouBQCXbpmj7AH/z3Nl3JdQ1DaBYK7cgZwVzfTipy/U64GQlV/iue5ttALiiVy6VZqr789ar3kFazZJKLR2W4vxNjtX/W9AzGTawPpaC3jxDlUemitnMGl6EF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioa5jSJZ; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706324443; x=1737860443;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RO19XOQwT2cCDZVkfpRu2QOFTF3cxLMWAwdofOJHmN0=;
  b=ioa5jSJZzSsduefEZYklC82wF296+noFgjMcGR3D5EXJ1wM4roun+7ke
   Vezu7p+02PGgEAm+PHI1tR0IzO5AyGyro7bfXQnllsbE1S1aH5jy873JT
   AONDp5JCRKOEw5IbOnv0Qj97z3GHIHr/MZzaA4QNB2P46viM+qp4dD+rU
   2+MssIMB1zW7uLx7p75K4vTcTT2frnpQvTWg4EZAjQjL62wJi2K2RmtfU
   meEwiIH9iaxAYrHBkY9psO9sAaqen/PizGJ/nHyq+XiAC8K3gwXzZsJof
   M2hQ0QgPN6Wo18+M+bRzOGhPmyJHIGWxzHPLGcFsmZ0tGYYusGkBIKVJK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="402285015"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="402285015"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 19:00:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857583722"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="857583722"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 19:00:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 19:00:41 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 19:00:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 19:00:41 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 19:00:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bkco/AHQ5j8ahJMJ1sLBnlRbiYWkEY7vG2BdFAxDB40oqt4RlQW9uQ+doBJU4I8wGNL5nQyAa6zGbpdAYxfMEiCEKviTOTXEO01bbKHOheMEbBedQRXz3g0Zcw32fhQbgc1URcLfhYrw1c+kc4fnHcLd1KKDRsnY8JAf9twzMzdP2n1Ba4E/fddYWqGU0k2Fu032HvSyk194s1GCGGJ2wDa8sGPbsqAHgrAyW4GSWRcJk7mje9Wgg3MnQVAeosRheg+CCoNMdMbg86dLHrChCSVqF4jx6WDe4IqxnCHGjnLFAWR5r3/2HvosweH8WcXUioQF5AFCD69ZqdUFNAmaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPFxS1BvvMRWwvtYxHkeMGgrsMwBEz6AxbcW902dPk4=;
 b=UtMqzC+XyG9eL30wFahvhpxiOfCbUKDFx56jB3g9v48ek0EqfGx7b+0rd2IZ5BkpwlaPg+1sG3PggpjWAQBoXFhKA+y3bN7ISe0z0XV2tNb8t8qfdtfajp4Em0ljZXcFQQAef9Ik1eGM8jYlBiu6I5PJibl8a83L2zjR5mgp6c+7jmUK9YdYmenFe6Z9tnoCl8qopJx7eGj28gvO9KZcDEvNgLoRADuyfzOcsChqRiTaDHWRC27o7dtaxVWjy3pMWfufYFRaa1lysAVGH5V5R3VLzomM+PRGXn/FmKLfamDE0ipTMG7RUVQk2QKNkYpHGyLBACjbv8YeW79YbWVSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Sat, 27 Jan
 2024 03:00:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.035; Sat, 27 Jan 2024
 03:00:32 +0000
Date: Fri, 26 Jan 2024 19:00:30 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Greg KH
	<gregkh@linuxfoundation.org>
CC: Alistair Francis <alistair23@gmail.com>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>,
	<lukas@wunner.de>, <alex.williamson@redhat.com>, <christian.koenig@amd.com>,
	<kch@nvidia.com>, <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
	<chaitanyak@nvidia.com>, <rdunlap@infradead.org>, Alistair Francis
	<alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Message-ID: <65b471ced39b_4e7f529431@dwillia2-xfh.jf.intel.com.notmuch>
References: <2023100539-playgroup-stoppable-d5d4@gregkh>
 <CAKmqyKOgej1jiiHsoLuDKXwdLDGa4njrndu6c1=bxnqk2NM58Q@mail.gmail.com>
 <2023101113-swimwear-squealer-464c@gregkh>
 <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
 <CAKmqyKOOSBF7qDpqAp6nn3+3wAnaGmqu88Fk3KY58fmgQ-44Jw@mail.gmail.com>
 <2024012321-envious-procedure-4a58@gregkh>
 <65b1739b2c789_37ad294f5@dwillia2-xfh.jf.intel.com.notmuch>
 <65b400bf65c33_51c7f294c5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <2024012631-removed-stuffed-ecc0@gregkh>
 <65b4112db4de0_51c7f2943a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65b4112db4de0_51c7f2943a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:303:b5::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b835878-7cde-4e32-61a4-08dc1ee42058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9atdVzhCupwGOlocLe46C/nptk6bww1RBd2aGftDzOqEJOktmYctT5nQBH9YIvSoAfP3FoZloRpebRygkYHzjYatMUvTLyNwEDEVGnEzybL6plXzbuotSjmsTkKwUSkfsTnhG2u7BaI3v5VO97q3/exGELIfPfNPF3t/qM/2l7S1lCHIDOEjBFSPTlU8dadzAVeA6n6lTS9oe4EJY7yUnDef+/IF8r0tzoRiKcA2M09gaSte09KAvtUP1CKcM7KZSknoiH/VYnGbbCrOP2vH7BQqLwu0jE4bTWK3+2RDhBThJoO7TXamzXz5S19GgNTE1wdhmAoCI0/U3dbXGNxa6ojXaJfOy8yNSPziHlU7uC83Lua8TuqY0P9vfuY4iAhIQWdg+suxMyo4rFeRdD0ZtotM1CyzuxouyvwaL5hIFXSsfz4BdSoH2of8y42SZqdL2nB8RCJ/d9uQ7liHFxvrIS/FArLZamUB6PJeCrN2iFMZVelwZRVXliDjgpJ9mDKXtpwUrGfVcWlz7ScXTgBV0aIgJjgDVKkORW+m1rjPSxsFKg7mfXeTs28Xv6QyDGMT4MjlgYPkO6B9qOkE3/7Wcm4YY/uI/QYS4mQ/zECBznPhMu3Uwt9QxCiHiTFZSWx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(82960400001)(86362001)(4326008)(9686003)(8676002)(5660300002)(8936002)(26005)(38100700002)(316002)(66946007)(110136005)(66476007)(966005)(66556008)(6506007)(478600001)(6512007)(30864003)(2906002)(41300700001)(6486002)(54906003)(53546011)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SN3nz1vOr5IVBsI6rYUmn+U57H97r5tZg9ZclXdWbPJgXw9uhDEyIngPaW8j?=
 =?us-ascii?Q?To1+oOFUWjq1dHd8hoDDkIkX0UMVRZO5CDmz2euxRyLXG8qAAUJjFFmCXLjS?=
 =?us-ascii?Q?XJ+tz4pT3vOzuYlSva/Kz8lj2PK0AKof9e0AQHREnijMH/3cZDknFnP7cBoJ?=
 =?us-ascii?Q?qzEe9Hja7vupyMDqRUWb4QkuWiCDu/fHqQJkNcp9EsGnMKXAi8Yh3JpQMbxC?=
 =?us-ascii?Q?YEksv3K9F0j8cK/UnzGweYisr6pPHS6mFtiDHongubCaxWukYjhOW6/s9C7f?=
 =?us-ascii?Q?HSHsusBrFi5GM+nbuErW9rymaYCE3bVsSUA5Cs35mVQg7NTpHl2R+snjWO03?=
 =?us-ascii?Q?4iZEGyZRehIYnweYm78cfS+AVyYw4xYW5uwmW8TFTjEAnENb8kgj4OPeY1vR?=
 =?us-ascii?Q?i9OKjxLURVr8AJw3XIfaMYNsrAYunFxsJn4bWuB2dFnTfub3D/5oY0OgeWHG?=
 =?us-ascii?Q?MXlp32TQtZ067lN8oNOY56tsbMdgc8av4P839XMmLAn3SBHX+Rhp1tWdFLsx?=
 =?us-ascii?Q?QyePTj0OxC1IyePx0i0gf+/XWKDJn0efLHOkZVY2nstyJOVHPbUlM2RVNR5/?=
 =?us-ascii?Q?X1uztVWy7gLAh8HDfAUCRDQdMA1tX0mIrqNspAoZDtG0DD5n1bR0x4f6Zrio?=
 =?us-ascii?Q?Q++rUtGIuy7/cWTIU3+cuKK5/8ACx4IyHLKOTXBPuOihejkCeIb360K61+/0?=
 =?us-ascii?Q?yyf85IaAcOPNZoa+MBH0nCxpuioyURiXqLjrtyBgkdCaRZnX484PN+MjRaF8?=
 =?us-ascii?Q?KOPy1B2Rq8Tp45BZ65UhPOahQpdiNYMsGIyHhXN3+S1Z0wXEwF7Gd6FYTWvs?=
 =?us-ascii?Q?VPQFwVr0VZ+jSPWtlEmKS0W6o/H1dley2V4ZL0XNx7EjewUtfPADlZvqXZjR?=
 =?us-ascii?Q?dNHSPk7/Dsaf6lpkQKECHqLrKKOoMqdNaVy0glwdiqNTMcoTe7uzbjD2C/CC?=
 =?us-ascii?Q?GgaHoFRHkCnZNeVqoW1bG5O75zPVrsJCDTS5wpWxj9WlIueZdq73+/BKTD05?=
 =?us-ascii?Q?qcDTG+W6cK+itALNWbfxEIIii8YD9+8SBEMXgQ8UtJrb95BJ459UCRks1aij?=
 =?us-ascii?Q?/dcwdotMxx/l3C3yVhe/vnm136dL7F4EajhLmHPVxD8ZWDLDge10rOpyvfuu?=
 =?us-ascii?Q?OE3DnhAalrKqjT6B6Wjr2yVVOHNvcKEAzC7KcLgvCFEfjVkHorcwm0w+E5Y2?=
 =?us-ascii?Q?WvMLG+zU7AU87w6ZSOtjjLk3VMSpK/tB0vNTYzvTGxOWW1M8mLQ6NnGgoMRW?=
 =?us-ascii?Q?gH7Sup4jlbCvpYrCTBefVfkHDlp66cT4ooTAwtRW4Ez88hCNCEhG5JWmPjwU?=
 =?us-ascii?Q?yxZ6PTmKjaC9B3Yp632eobj24wofbEaL7PO7ZPQD7LSkKGVDr/W5Li2P5gNb?=
 =?us-ascii?Q?l7MlaZQzgumkY41rczfaEwH0UKRNw2ALMNjji/W4ShhCfe72IBCHJ02q5GXl?=
 =?us-ascii?Q?2kiVN53hYkWFN0G+lLLkYPVkO7+CRHQWfBVkDy1vrEdzbi0EWJAGduk43dpH?=
 =?us-ascii?Q?LKcnqBzEKMDf+LRpsWlwXqc8G2SdKh3I+UXvdfBIptA3hcIY1RCv1nbNAsEo?=
 =?us-ascii?Q?ykVE7B6XyJ9tbOv2Z+XvPnAMMUfvJOvv/hvuWVo2oHOlWe4jfDkX4fJjCrGF?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b835878-7cde-4e32-61a4-08dc1ee42058
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 03:00:32.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkY349j3sKOVq4vA4uQIiNAiirH/X2CcsStikrtq3dwrpeF2g3qCUfB3bkduR2g00fQUFlSm7cVl4RdsKqZULKTu+Ss5kMKFwl258258liQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com

Dan Williams wrote:
> > > Hey Greg,
> > > 
> > > Ignore this version:
> > > 
> > > ---
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > Date: Tue, 23 Jan 2024 20:20:39 -0800
> > > Subject: [PATCH] sysfs: Introduce is_group_visible() for attribute_groups
> > > ---
> > > 
> > > I am going back to your approach without a new callback, and some fixups
> > > to avoid unintended directory removal. I will post that shortly with its
> > > consumer.
> > 
> > Ignore it?  I was just about to write an email that said "maybe this is
> > the right way forward" :)
> > 
> > What happened to cause it to not be ok? And if you can find the bug in
> > the posted patch here, that would be great as well.
> 
> It was an aha moment this morning that I could rely on something like:
> 
> #define SYSFS_GROUP_INVISIBLE ((umode_t)-1)
> 
> ...as the return value from either is_visible() or attr_is_visible() and
> not need to define a new is_group_visible() callback.
> 
> The only downside I can see is that there is no way to know if the
> is_visible() handler might return SYSFS_GROUP_INVISIBLE to decide when
> to warn about deletion not finding anything to delete, or update not
> finding the existing node to update.
> 
> I'll type it up and see how it looks, but if you're not worried about
> the is_group_visible() addition to 'struct atttribute_group' I think
> that way is less hacky than the above.

Ok, here it is (below the scissors line). I ended up including a way to
determine if an attribute_group is opting into this new capability, and
I do think this is more in line with your direction to just reuse
existing is_visible() callbacks. This was tested with the following hack
to a dynamic visibility group in CXL:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3e817a6f94c6..286b91e29c88 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2010,8 +2010,8 @@ static struct attribute *target_attrs[] = {
 	NULL,
 };
 
-static umode_t cxl_region_target_visible(struct kobject *kobj,
-					 struct attribute *a, int n)
+static umode_t cxl_region_target_attr_visible(struct kobject *kobj,
+					      struct attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -2022,9 +2022,22 @@ static umode_t cxl_region_target_visible(struct kobject *kobj,
 	return 0;
 }
 
+static bool cxl_region_target_group_visible(struct kobject *kobj)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+
+	if (!p->interleave_ways || p->interleave_ways > 2)
+		return false;
+	return true;
+}
+DEFINE_SYSFS_GROUP_VISIBLE(cxl_region_target);
+
 static const struct attribute_group cxl_region_target_group = {
+	.name = "target_group",
 	.attrs = target_attrs,
-	.is_visible = cxl_region_target_visible,
+	.is_visible = SYSFS_GROUP_VISIBLE(cxl_region_target),
 };
 
 static const struct attribute_group *get_cxl_region_target_group(void)

-- >8 --
From 293a9b1d451cba5e7f95897de8c980fddead43ab Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 26 Jan 2024 18:17:53 -0800
Subject: [PATCH v2] sysfs: Introduce a mechanism to hide static attribute_groups

Add a mechanism for named attribute_groups to hide their directory at
sysfs_update_group() time, or otherwise skip emitting the group
directory when the group is first registered. It piggybacks on
is_visible() in a similar manner as SYSFS_PREALLOC, i.e. special flags
in the upper bits of the returned mode. To use it, specify a symbol
prefix to DEFINE_SYSFS_GROUP_VISIBLE(), and then pass that same prefix
to SYSFS_GROUP_VISIBLE() when assigning the @is_visible() callback:

	DEFINE_SYSFS_GROUP_VISIBLE($prefix)

	struct attribute_group $prefix_group = {
		.name = $name,
		.is_visible = SYSFS_GROUP_VISIBLE($prefix),
	};

SYSFS_GROUP_VISIBLE() expects a definition of $prefix_group_visible()
and $prefix_attr_visible(), where $prefix_group_visible() just returns
true / false and $prefix_attr_visible() behaves as normal.

The motivation for this capability is to centralize PCI device
authentication in the PCI core with a named sysfs group while keeping
that group hidden for devices and platforms that do not meet the
requirements. In a PCI topology, most devices will not support
authentication, a small subset will support just PCI CMA (Component
Measurement and Authentication), a smaller subset will support PCI CMA +
PCIe IDE (Link Integrity and Encryption), and only next generation
server hosts will start to include a platform TSM (TEE Security
Manager).

Without this capability the alternatives are:

* Check if all attributes are invisible and if so, hide the directory.
  Beyond trouble getting this to work [1], this is an ABI change for
  scenarios if userspace happens to depend on group visibility absent any
  attributes. I.e. this new capability avoids regression since it does
  not retroactively apply to existing cases.

* Publish an empty /sys/bus/pci/devices/$pdev/tsm/ directory for all PCI
  devices (i.e. for the case when TSM platform support is present, but
  device support is absent). Unfortunate that this will be a vestigial
  empty directory in the vast majority of cases.

* Reintroduce usage of runtime calls to sysfs_{create,remove}_group()
  in the PCI core. Bjorn has already indicated that he does not want to
  see any growth of pci_sysfs_init() [2].

* Drop the named group and simulate a directory by prefixing all
  TSM-related attributes with "tsm_". Unfortunate to not use the naming
  capability of a sysfs group as intended.

In comparison, there is a small potential for regression if for some
reason an @is_visible() callback had dependencies on how many times it
was called.

Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/sysfs/group.c      | 64 ++++++++++++++++++++++++++++++++------
 include/linux/sysfs.h | 71 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 114 insertions(+), 21 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 138676463336..90dd98c82776 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -31,6 +31,17 @@ static void remove_files(struct kernfs_node *parent,
 			kernfs_remove_by_name(parent, (*bin_attr)->attr.name);
 }
 
+static umode_t __first_visible(const struct attribute_group *grp, struct kobject *kobj)
+{
+	if (grp->attrs && grp->is_visible)
+		return grp->is_visible(kobj, grp->attrs[0], 0);
+
+	if (grp->bin_attrs && grp->is_bin_visible)
+		return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
+
+	return 0;
+}
+
 static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 			kuid_t uid, kgid_t gid,
 			const struct attribute_group *grp, int update)
@@ -52,6 +63,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 				kernfs_remove_by_name(parent, (*attr)->name);
 			if (grp->is_visible) {
 				mode = grp->is_visible(kobj, *attr, i);
+				mode &= ~SYSFS_GROUP_VISIBLE_MASK;
 				if (!mode)
 					continue;
 			}
@@ -81,6 +93,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 						(*bin_attr)->attr.name);
 			if (grp->is_bin_visible) {
 				mode = grp->is_bin_visible(kobj, *bin_attr, i);
+				mode &= ~SYSFS_GROUP_VISIBLE_MASK;
 				if (!mode)
 					continue;
 			}
@@ -127,16 +140,35 @@ static int internal_create_group(struct kobject *kobj, int update,
 
 	kobject_get_ownership(kobj, &uid, &gid);
 	if (grp->name) {
+		umode_t mode = __first_visible(grp, kobj);
+		bool has_group_visible = mode & SYSFS_HAS_GROUP_VISIBLE;
+
+		if (has_group_visible && (mode & SYSFS_GROUP_INVISIBLE))
+			mode = 0;
+		else
+			mode = S_IRWXU | S_IRUGO | S_IXUGO;
+
 		if (update) {
 			kn = kernfs_find_and_get(kobj->sd, grp->name);
 			if (!kn) {
-				pr_warn("Can't update unknown attr grp name: %s/%s\n",
-					kobj->name, grp->name);
-				return -EINVAL;
+				if (!has_group_visible) {
+					pr_warn("Can't update unknown attr grp name: %s/%s\n",
+						kobj->name, grp->name);
+					return -EINVAL;
+				}
+				/* may have been invisible prior to this update */
+				update = 0;
+			} else if (!mode) {
+				sysfs_remove_group(kobj, grp);
+				kernfs_put(kn);
+				return 0;
 			}
-		} else {
-			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
-						  S_IRWXU | S_IRUGO | S_IXUGO,
+		}
+
+		if (!update) {
+			if (!mode)
+				return 0;
+			kn = kernfs_create_dir_ns(kobj->sd, grp->name, mode,
 						  uid, gid, kobj, NULL);
 			if (IS_ERR(kn)) {
 				if (PTR_ERR(kn) == -EEXIST)
@@ -262,6 +294,22 @@ int sysfs_update_group(struct kobject *kobj,
 }
 EXPORT_SYMBOL_GPL(sysfs_update_group);
 
+static void warn_group_not_found(const struct attribute_group *grp,
+				 struct kobject *kobj)
+{
+	umode_t mode = __first_visible(grp, kobj);
+
+	if (mode & SYSFS_HAS_GROUP_VISIBLE) {
+		/* may have never been created */
+		pr_debug("sysfs group '%s' not found for kobject '%s'\n",
+			 grp->name, kobject_name(kobj));
+		return;
+	}
+
+	WARN(1, KERN_WARNING "sysfs group '%s' not found for kobject '%s'\n",
+	     grp->name, kobject_name(kobj));
+}
+
 /**
  * sysfs_remove_group: remove a group from a kobject
  * @kobj:	kobject to remove the group from
@@ -279,9 +327,7 @@ void sysfs_remove_group(struct kobject *kobj,
 	if (grp->name) {
 		kn = kernfs_find_and_get(parent, grp->name);
 		if (!kn) {
-			WARN(!kn, KERN_WARNING
-			     "sysfs group '%s' not found for kobject '%s'\n",
-			     grp->name, kobject_name(kobj));
+			warn_group_not_found(grp, kobj);
 			return;
 		}
 	} else {
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b717a70219f6..4fb4f4da003a 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -62,21 +62,32 @@ do {							\
  * struct attribute_group - data structure used to declare an attribute group.
  * @name:	Optional: Attribute group name
  *		If specified, the attribute group will be created in
- *		a new subdirectory with this name.
+ *		a new subdirectory with this name. Additionally when a
+ *		group is named, @is_visible and @is_bin_visible may
+ *		return SYSFS_HAS_GROUP_VISIBLE | SYSFS_GROUP_INVISIBLE
+ *		to control visibility of the directory itself. If
+ *		SYSFS_GROUP_INVISIBLE is ever to be returned,
+ *		SYSFS_HAS_GROUP_VISIBLE must always be included in the
+ *		return value from @is_visible and @is_bin_visible. See
+ *		the DEFINE_SYSFS_GROUP_VISIBLE() helper.
  * @is_visible:	Optional: Function to return permissions associated with an
- *		attribute of the group. Will be called repeatedly for each
- *		non-binary attribute in the group. Only read/write
- *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if an attribute is not visible. The returned value
- *		will replace static permissions defined in struct attribute.
+ *		attribute of the group. Will be called repeatedly for
+ *		each non-binary attribute in the group. Only read/write
+ *		permissions as well as SYSFS_PREALLOC (and the
+ *		visibility flags for named groups) are accepted. Must
+ *		return 0 (or just SYSFS_HAS_GROUP_VISIBLE) if an
+ *		attribute is not visible. The returned value will
+ *		replace static permissions defined in struct attribute.
  * @is_bin_visible:
  *		Optional: Function to return permissions associated with a
  *		binary attribute of the group. Will be called repeatedly
  *		for each binary attribute in the group. Only read/write
- *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if a binary attribute is not visible. The returned
- *		value will replace static permissions defined in
- *		struct bin_attribute.
+ *		permissions as well as SYSFS_PREALLOC (and the
+ *		visibility flags for named groups) are accepted. Must
+ *		return 0 (or just SYSFS_HAS_GROUP_VISIBLE) if a binary
+ *		attribute is not visible. The returned value will
+ *		replace static permissions defined in struct
+ *		bin_attribute.
  * @attrs:	Pointer to NULL terminated list of attributes.
  * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
  *		Either attrs or bin_attrs or both must be provided.
@@ -91,13 +102,49 @@ struct attribute_group {
 	struct bin_attribute	**bin_attrs;
 };
 
+#define SYSFS_PREALLOC		010000
+#define SYSFS_HAS_GROUP_VISIBLE 020000
+#define SYSFS_GROUP_INVISIBLE	040000
+#define SYSFS_GROUP_VISIBLE_MASK (SYSFS_HAS_GROUP_VISIBLE|SYSFS_GROUP_INVISIBLE)
+
+static inline umode_t sysfs_group_visible(umode_t mode)
+{
+	return mode | SYSFS_HAS_GROUP_VISIBLE;
+}
+
+/*
+ * The first call to is_visible() in the create / update path may
+ * indicate visibility for the entire group
+ */
+#define DEFINE_SYSFS_GROUP_VISIBLE(name)                                \
+static inline umode_t sysfs_group_visible_##name(                       \
+	struct kobject *kobj, struct attribute *attr, int n)            \
+{                                                                       \
+	if (n == 0 && !name##_group_visible(kobj))			\
+		return sysfs_group_visible(SYSFS_GROUP_INVISIBLE);      \
+	return sysfs_group_visible(name##_attr_visible(kobj, attr, n)); \
+}
+
+/*
+ * Same as DEFINE_SYSFS_GROUP_VISIBLE, but for groups with only binary
+ * attributes
+ */
+#define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name)                            \
+static inline umode_t sysfs_group_visible_##name(                       \
+	struct kobject *kobj, struct bin_attribute *attr, int n)        \
+{                                                                       \
+	if (n == 0 && !name##_group_visible(kobj))		        \
+		return sysfs_group_visible(SYSFS_GROUP_INVISIBLE);      \
+	return sysfs_group_visible(name##_attr_visible(kobj, attr, n)); \
+}
+
+#define SYSFS_GROUP_VISIBLE(fn) sysfs_group_visible_##fn
+
 /*
  * Use these macros to make defining attributes easier.
  * See include/linux/device.h for examples..
  */
 
-#define SYSFS_PREALLOC 010000
-
 #define __ATTR(_name, _mode, _show, _store) {				\
 	.attr = {.name = __stringify(_name),				\
 		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
-- 
2.43.0

