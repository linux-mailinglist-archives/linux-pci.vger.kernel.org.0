Return-Path: <linux-pci+bounces-2625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45983F2C6
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 02:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9BD1C20F3A
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 01:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1961373;
	Sun, 28 Jan 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUcb6vDw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A41D1362;
	Sun, 28 Jan 2024 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706406185; cv=fail; b=Utivj9U2FSVPRwGCL6slF+VUAwGKeLlJUmvW8NtN7KyiI4LEcUcMTXfcrIiYFNDMr+aWBz3EePIZPdlL2zV0MOk5UMlYWVJDaVLstXmTC3yupa364spQsqakWvCMwbhZxz9mj4iIuBD0k+CsQXEAsbIV8vxKsGPYnFaNeJA8QR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706406185; c=relaxed/simple;
	bh=hnkglSjCZ9GCktDNxtf7jdeimuuO7cr7sEJEfCmz+KI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aNFAK1ec8FG7V8mQ31/ryCQ5k2iqVh6Lhq7Afz1pkgZhnX9kpUUEugwg9x15ZfPahohVFcslahdh09/NBn1eXvtsP8X9jwGtkr5Ba6gU2aFwZA+E+M7VTWjIfn2IcV/wI3oR2BPWbLGCJzFbNW9G5Uesi5frgbOhSH6AVcC+WIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUcb6vDw; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706406183; x=1737942183;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hnkglSjCZ9GCktDNxtf7jdeimuuO7cr7sEJEfCmz+KI=;
  b=PUcb6vDw30xajUscjDRIZrKGWl0Ac138l8LuW0XXH8no9wcWGEW+7xCn
   WYO77ZN4MRCXTpozZSpZO9jeuUCNT5roExlrlbsFXlCohSAcoLwa8QsY5
   LYvS5YNi97oTHAK40A5TcyS0Zf3TFj+t2OMX/h4JyJJjB6rVPnnaNBznM
   QGSOAyPyh2KfHqzxkC73VZ6HPkeRWMFcmZGYZf72DH8n8XWyiYuVY5eTv
   j+fdzQZVyerPLAtyBIMjnIqt6uzALd0yLQr59Fap3FTMcwjDVMRsl2ffO
   gGApexj+yB/pnIGv56/OVZhvuu9gkIJRwWMbNuXy55KnDYOOoVExLkQWm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="9405686"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9405686"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 17:43:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2958537"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2024 17:43:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 17:43:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 17:43:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 27 Jan 2024 17:43:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 27 Jan 2024 17:43:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJbLyQ1XzHT7epS/9lB10bMLKLLiD1+GI4scI586gQgTxWHB6h0qIKFtvQK0tIfFVm6XtPiVj+4tF7Iz7lllzuYZog+Fv2TrKssSv9BEFDHTjd/prOIab4yFRmUuGaw1u9N7dJoswU4JKSWlZPZFhe49qcF9eF9LoqOUWQrl79DGUDn/RgzCppEmmJsz4pGi3Q3fuzQnDLYMv99wzhNHwD4rtOWZCgPYzv+gqebnn7YULn1FBW9B5gkTl29XGkN+zsRMtqHd0LRBaPK/jBhFVZkurchDmh/T4Ab8R9qsDFr3f2DdbAJPb/IcNDQqeoBtdZKtON3x76yqINwp6sOpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eurbF/hcYQeBPnGAkSuO0PtHb65QRAKFYBp8PNVMMA=;
 b=fFgC0oBex86Kd5QnODGofS76bu9rwsDDLdeWvhsnlNaOVWrubgNG9AvK9KT8OmNY/SUiY8sgu2VLqUwK0rjnjaUdakpsDS4aPlm8HfrBJgcb++hRuH1K4C90jTXtpjS6Chw73kCygsUVwOuryaPz8KuoW2Be7lCufbQaQvGsUx9IWZ1yPWjIJB3eP3sewDTU8X5Jpx2e/HyyFpNkERBnfjcW8gemTyvpGDcWrlezBWdJAOjw7/jc2XNuWE2VioTprpYpOxAfMBk/7XqX1z+nN7OkEbDOYuRvD/HpZK3AupjaQpv/zd6hj4Z0WG6eqCqFARv9eqVD7VDbPehby9XNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8499.namprd11.prod.outlook.com (2603:10b6:a03:578::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.29; Sun, 28 Jan
 2024 01:42:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 01:42:58 +0000
Date: Sat, 27 Jan 2024 17:42:54 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Alistair Francis <alistair23@gmail.com>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>,
	<lukas@wunner.de>, <alex.williamson@redhat.com>, <christian.koenig@amd.com>,
	<kch@nvidia.com>, <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
	<chaitanyak@nvidia.com>, <rdunlap@infradead.org>, Alistair Francis
	<alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Message-ID: <65b5b11ed7af0_51c7f29463@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <2023101113-swimwear-squealer-464c@gregkh>
 <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
 <CAKmqyKOOSBF7qDpqAp6nn3+3wAnaGmqu88Fk3KY58fmgQ-44Jw@mail.gmail.com>
 <2024012321-envious-procedure-4a58@gregkh>
 <65b1739b2c789_37ad294f5@dwillia2-xfh.jf.intel.com.notmuch>
 <65b400bf65c33_51c7f294c5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <2024012631-removed-stuffed-ecc0@gregkh>
 <65b4112db4de0_51c7f2943a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <65b471ced39b_4e7f529431@dwillia2-xfh.jf.intel.com.notmuch>
 <2024012703-exclaim-ground-2b8b@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024012703-exclaim-ground-2b8b@gregkh>
X-ClientProxiedBy: MW2PR16CA0072.namprd16.prod.outlook.com
 (2603:10b6:907:1::49) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: be81bd87-4ade-408f-c7f6-08dc1fa27450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyKVBZhYq8y4fcOrhKat+rHfeQLhp5dVrBlFKv6JaHGe6BzjcvXa2fzND1I15KVZlefk4vaLgxiTdooa4+IJTl4rzfz0UVV9MBarbJBR95Tq2iaOcO98QbUui4jSHuHgbS/kPSgb4u9nicp4v58Xy1yuXSZeXC00rY4gzfvhQrSRwM/DyYDYFhOHFbJKzmwZHxJKi7GBBHdiaK4mp4yLogwqKH1yegSszdeHmPeVcr7bphivzmEBm0fcwitKg3IrXcqbBPdQXx3zY5ofl413+uvvFb6X2fKq/1cMHa60+SfwbZ4sm2BwpduNDyMgQCKnNgUININqS0M5m5hGFeyomk2tvpXRmy34LJrwSUcWA5s5fhRZ2ZeEQyXnEGleu/Mb6DVUsgxq8YkIvczxDEmDdJY1harDTcvtSG2aJ12l0AQBuEZ76SIkvtULU3fR0dmxAyIdkJ795MhShCfeW7fnW7uyFlyfnmvKEX+dPXY6Jv537PIwiC3Jydw392U6f1HqcOiEL86SKBG26kAm/d4ezwe02zFAyRXv0+6kSqrtl7W3fMfhyLVVTMWITiQ3RhSSAp0jYr96fh7t6ETIa+XnkuAkxeQOHcVQ8Vu27uFcw5qMIFylXRWG7p+476sMJgbg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(6512007)(9686003)(478600001)(53546011)(6506007)(6666004)(83380400001)(26005)(6486002)(8936002)(4326008)(8676002)(5660300002)(7416002)(2906002)(30864003)(966005)(66556008)(66476007)(54906003)(66946007)(316002)(110136005)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YVwVZeFws4CV8fmq7RVjE1nUNrZ6MqwpTqBONZQpwWqg/36olKfQLIMDLNgo?=
 =?us-ascii?Q?LjyBdbGbWWgRHAASfYhfegp/phkMG1cEIDZPoHhIbVtQcm+BFn/Ds6p4Fele?=
 =?us-ascii?Q?/aotZKOhhMiP3VUxi5T4w/VIFpS9YqX1v1i3WnQFtG+ntQGr2lHeS5RvH6lG?=
 =?us-ascii?Q?B+JuncUbMF1/hu/kibdU5Dx35n0gulJOPNxLP7G5zBocZp6L2fO2B1aux5qH?=
 =?us-ascii?Q?h2J8x6MMyef3bMmP11ffcZMBD7sMVyhxogKYAgq2NaWnGWaRl9rTkoiBfnCd?=
 =?us-ascii?Q?jaHazHqYOuyFzUKUVyqRgusm7Uy+wm8L6w0LSohES9gBT3vz42JMGlqhQhYj?=
 =?us-ascii?Q?NklNgnM5A/W1H7oNsDOjD+hlso1AjiIk8Bu3h99Z4a7kSfQcxT/6nir/qdKO?=
 =?us-ascii?Q?EIkU9sVjMFKcVuYskExxaGU4wPKdgU9dF3+4toZK2L52bZofy1tyaORrZSNO?=
 =?us-ascii?Q?AiT464PYQcGrXdcwRBJr1bWprBxBzbKgxEFPBM9NXzapkPxbWX4Q6U5ffDxf?=
 =?us-ascii?Q?q6VwaThw56YI3tHeOMGszOR1UXJtSrmzGkBaKJolJ9U+yXRf3FBBP3nNyj9R?=
 =?us-ascii?Q?cnEpLMG8eRkhC70FaAq8zaehWbs69D3+WSzTDfeObtd3fdXLz+7HRnO7gSZe?=
 =?us-ascii?Q?PsQ5NGzKERe7f2wdDWERdwN5ZqXNNsuFpKrDWf9qJiuyrK+ydo0gVohpZS/I?=
 =?us-ascii?Q?ezP2xIRnWH2qQh3tN/ldwwX6CuIQuIcI/A1QFPjSoze91a6F9QexzKAYwQeN?=
 =?us-ascii?Q?0ayG+IeSqLqHrnhZvVnoGksDoz2lwhLaTrLv0QVdlkSmBc8Nx4UfBo0kO871?=
 =?us-ascii?Q?WC4QU5zIOLzBfQOkN26f1T/T/RI+tBb82Od99ftezmxHnm+Ldj/GUYO1vcVS?=
 =?us-ascii?Q?7OFMI4Oo2CcUfk3IXypUQL+K4Q68qXV8LL/YQdb5tgYkXyX/aMGWea0UDoIn?=
 =?us-ascii?Q?B9DaoPIhGNsjYskyNnL2EapaTz7ByP0R7E1RcxFGB4fTQMZPijUuBB2QIxNW?=
 =?us-ascii?Q?f9t6+Ndwq6dzCr1GSJVrIVYEcGMnzLiOEamIJreRUnnXaIfV/g2hBJfAVpD6?=
 =?us-ascii?Q?anqa6XpIMmx6usC1xeboSyDi7l/jbiDQiuCb2iAeZ9RlC/qAR7j4QMh/FsOm?=
 =?us-ascii?Q?o5f5ghmlEQ2iDZEerDsDdhvoobXg0VDaD496RLFTOkUc899u+MkQGoFbadeZ?=
 =?us-ascii?Q?t0hcWdQ1+CkyWAjwgNk0NsCeTcuzY2eRx8pAfb08XHKs/bgfgqeQNihy0FAn?=
 =?us-ascii?Q?KRkrsiP5Gdmi6rU5CIc+nLRc+z6F3onEbQjFQvRQKrlcsI5ERbYGowqGnnLi?=
 =?us-ascii?Q?sIh8n8O5GiEDtH+ivhRMZdykDF6YSUdm3jXfLDCzbaMia19RfeRxqiyEiNZ3?=
 =?us-ascii?Q?l1ZivkmsXlrfGgtxM0dKHUOO36IBuDKriajtxfEDoRf02YU0m55qWt7Yv3nm?=
 =?us-ascii?Q?U6rOciTu1BIOjcvipMTYXutOCMTsT1jT20gDDFIhAI6sdw9/yqbZyw35ipdO?=
 =?us-ascii?Q?aM6QpD1mV37MHGM9QuAXCJGx/B4CQUsiGlbdt4eXZfvD5zOHEQwDsmcpq6pN?=
 =?us-ascii?Q?Xc1711cDE1EMABcoevJ+lqUL89qmPT5CnNY1AiotQf+00MgbPTmHkwrJ1r2y?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be81bd87-4ade-408f-c7f6-08dc1fa27450
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 01:42:57.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHp9NtioWdNqmd7Ai3feiQOpogXVCGykDHQjCx2w786F6f4L+sPoOyUc2S6S63XkPL3gVc1e2fzW9zN9g0665Cun6aI3Q86/qfdMNYLefAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8499
X-OriginatorOrg: intel.com

Greg KH wrote:
[..]
> > diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> > index 138676463336..90dd98c82776 100644
> > --- a/fs/sysfs/group.c
> > +++ b/fs/sysfs/group.c
> > @@ -31,6 +31,17 @@ static void remove_files(struct kernfs_node *parent,
> >  			kernfs_remove_by_name(parent, (*bin_attr)->attr.name);
> >  }
> >  
> > +static umode_t __first_visible(const struct attribute_group *grp, struct kobject *kobj)
> > +{
> > +	if (grp->attrs && grp->is_visible)
> > +		return grp->is_visible(kobj, grp->attrs[0], 0);
> > +
> > +	if (grp->bin_attrs && grp->is_bin_visible)
> > +		return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
> 
> This kind of makes sense, but why the first attribute only?  I guess we
> have to pick one?

Yeah, to not confuse existing implementations is_visible() must always be
passed a valid @attr argument, so might as well pick first available.

> > +
> > +	return 0;
> > +}
> > +
> >  static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> >  			kuid_t uid, kgid_t gid,
> >  			const struct attribute_group *grp, int update)
> > @@ -52,6 +63,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> >  				kernfs_remove_by_name(parent, (*attr)->name);
> >  			if (grp->is_visible) {
> >  				mode = grp->is_visible(kobj, *attr, i);
> > +				mode &= ~SYSFS_GROUP_VISIBLE_MASK;
> >  				if (!mode)
> >  					continue;
> >  			}
> > @@ -81,6 +93,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> >  						(*bin_attr)->attr.name);
> >  			if (grp->is_bin_visible) {
> >  				mode = grp->is_bin_visible(kobj, *bin_attr, i);
> > +				mode &= ~SYSFS_GROUP_VISIBLE_MASK;
> >  				if (!mode)
> >  					continue;
> >  			}
> > @@ -127,16 +140,35 @@ static int internal_create_group(struct kobject *kobj, int update,
> >  
> >  	kobject_get_ownership(kobj, &uid, &gid);
> >  	if (grp->name) {
> > +		umode_t mode = __first_visible(grp, kobj);
> > +		bool has_group_visible = mode & SYSFS_HAS_GROUP_VISIBLE;
> > +
> > +		if (has_group_visible && (mode & SYSFS_GROUP_INVISIBLE))
> 
> These new SYSFS_*_GROUP values are confusing me, more below:

Ok, SYSFS_HAS_GROUP_VISIBLE is mainly about preserving the long standing
WARN() behavior that flags broken usage of sysfs. If you are open to
dropping strictness I think this can be simplified.

> 
> > +			mode = 0;
> > +		else
> > +			mode = S_IRWXU | S_IRUGO | S_IXUGO;
> > +
> >  		if (update) {
> >  			kn = kernfs_find_and_get(kobj->sd, grp->name);
> >  			if (!kn) {
> > -				pr_warn("Can't update unknown attr grp name: %s/%s\n",
> > -					kobj->name, grp->name);
> > -				return -EINVAL;
> > +				if (!has_group_visible) {
> > +					pr_warn("Can't update unknown attr grp name: %s/%s\n",
> > +						kobj->name, grp->name);
> > +					return -EINVAL;
> > +				}
> > +				/* may have been invisible prior to this update */
> > +				update = 0;
> > +			} else if (!mode) {
> > +				sysfs_remove_group(kobj, grp);
> > +				kernfs_put(kn);
> > +				return 0;
> >  			}
> > -		} else {
> > -			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> > -						  S_IRWXU | S_IRUGO | S_IXUGO,
> > +		}
> > +
> > +		if (!update) {
> > +			if (!mode)
> > +				return 0;
> > +			kn = kernfs_create_dir_ns(kobj->sd, grp->name, mode,
> >  						  uid, gid, kobj, NULL);
> >  			if (IS_ERR(kn)) {
> >  				if (PTR_ERR(kn) == -EEXIST)
> > @@ -262,6 +294,22 @@ int sysfs_update_group(struct kobject *kobj,
> >  }
> >  EXPORT_SYMBOL_GPL(sysfs_update_group);
> >  
> > +static void warn_group_not_found(const struct attribute_group *grp,
> > +				 struct kobject *kobj)
> > +{
> > +	umode_t mode = __first_visible(grp, kobj);
> > +
> > +	if (mode & SYSFS_HAS_GROUP_VISIBLE) {
> > +		/* may have never been created */
> > +		pr_debug("sysfs group '%s' not found for kobject '%s'\n",
> > +			 grp->name, kobject_name(kobj));
> > +		return;
> 
> So if the group is visible somehow, but not found, then it's ok?  But:
> 
> 
> > +	}
> > +
> > +	WARN(1, KERN_WARNING "sysfs group '%s' not found for kobject '%s'\n",
> > +	     grp->name, kobject_name(kobj));
> 
> We crash the box if it was not visible and not found?

Yes, but only for preservation of legacy strictness. In other words,
without the new "has" flag this is as an unambiguous misuse of sysfs
APIs. With the "has" flag it is no long definitive that someone messed
up.

My preference is delete the WARN() and the "has" flag if you're open to
that.

> > +}
> > +
> >  /**
> >   * sysfs_remove_group: remove a group from a kobject
> >   * @kobj:	kobject to remove the group from
> > @@ -279,9 +327,7 @@ void sysfs_remove_group(struct kobject *kobj,
> >  	if (grp->name) {
> >  		kn = kernfs_find_and_get(parent, grp->name);
> >  		if (!kn) {
> > -			WARN(!kn, KERN_WARNING
> > -			     "sysfs group '%s' not found for kobject '%s'\n",
> > -			     grp->name, kobject_name(kobj));
> > +			warn_group_not_found(grp, kobj);
> 
> We really should not WARN(), but I guess we don't ever get reports of
> this so it's ok.

It's one of those "should only fire on the kernel developer's system
during development" WARN()s, and per above if it's not adding value, it
is now adding complexity for this group visibility feature.

> 
> >  			return;
> >  		}
> >  	} else {
> > diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> > index b717a70219f6..4fb4f4da003a 100644
> > --- a/include/linux/sysfs.h
> > +++ b/include/linux/sysfs.h
> > @@ -62,21 +62,32 @@ do {							\
> >   * struct attribute_group - data structure used to declare an attribute group.
> >   * @name:	Optional: Attribute group name
> >   *		If specified, the attribute group will be created in
> > - *		a new subdirectory with this name.
> > + *		a new subdirectory with this name. Additionally when a
> > + *		group is named, @is_visible and @is_bin_visible may
> > + *		return SYSFS_HAS_GROUP_VISIBLE | SYSFS_GROUP_INVISIBLE
> > + *		to control visibility of the directory itself. If
> > + *		SYSFS_GROUP_INVISIBLE is ever to be returned,
> > + *		SYSFS_HAS_GROUP_VISIBLE must always be included in the
> > + *		return value from @is_visible and @is_bin_visible. See
> > + *		the DEFINE_SYSFS_GROUP_VISIBLE() helper.
> 
> Here it gets confusing for me.  Why are you saying things like
> SYSFS_HAS_GROUP_VISIBLE and SYSFS_GROUP_INVISIBLE, when your example
> shows none of that at all?  Shouldn't this all be internal-to-sysfs
> stuff?  Why list it here?

True. I took my cue from the fact that SYSFS_PREALLOC is mentioned in
the documentation even though it is only ever used internally by the
attribute definition macros. I can trim to only the user documentation.

> >   * @is_visible:	Optional: Function to return permissions associated with an
> > - *		attribute of the group. Will be called repeatedly for each
> > - *		non-binary attribute in the group. Only read/write
> > - *		permissions as well as SYSFS_PREALLOC are accepted. Must
> > - *		return 0 if an attribute is not visible. The returned value
> > - *		will replace static permissions defined in struct attribute.
> > + *		attribute of the group. Will be called repeatedly for
> > + *		each non-binary attribute in the group. Only read/write
> > + *		permissions as well as SYSFS_PREALLOC (and the
> > + *		visibility flags for named groups) are accepted. Must
> > + *		return 0 (or just SYSFS_HAS_GROUP_VISIBLE) if an
> > + *		attribute is not visible. The returned value will
> > + *		replace static permissions defined in struct attribute.
> >   * @is_bin_visible:
> >   *		Optional: Function to return permissions associated with a
> >   *		binary attribute of the group. Will be called repeatedly
> >   *		for each binary attribute in the group. Only read/write
> > - *		permissions as well as SYSFS_PREALLOC are accepted. Must
> > - *		return 0 if a binary attribute is not visible. The returned
> > - *		value will replace static permissions defined in
> > - *		struct bin_attribute.
> > + *		permissions as well as SYSFS_PREALLOC (and the
> > + *		visibility flags for named groups) are accepted. Must
> > + *		return 0 (or just SYSFS_HAS_GROUP_VISIBLE) if a binary
> > + *		attribute is not visible. The returned value will
> > + *		replace static permissions defined in struct
> > + *		bin_attribute.
> >   * @attrs:	Pointer to NULL terminated list of attributes.
> >   * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
> >   *		Either attrs or bin_attrs or both must be provided.
> > @@ -91,13 +102,49 @@ struct attribute_group {
> >  	struct bin_attribute	**bin_attrs;
> >  };
> >  
> > +#define SYSFS_PREALLOC		010000
> > +#define SYSFS_HAS_GROUP_VISIBLE 020000
> 
> Nit, forgot a tab :(

Fixed.

> > +#define SYSFS_GROUP_INVISIBLE	040000
> > +#define SYSFS_GROUP_VISIBLE_MASK (SYSFS_HAS_GROUP_VISIBLE|SYSFS_GROUP_INVISIBLE)
> 
> Ackward defines, "HAS_GROUP_VISABLE" vs. "GROUP_INVISIBLE"?  Why not
> just "GROUP_VISIBLE" and "GROUP_INVISIBLE"?

Yeah, this "has" thing is only about preserving the WARN regime, the
other is reflecting the state.

> > +
> > +static inline umode_t sysfs_group_visible(umode_t mode)
> > +{
> > +	return mode | SYSFS_HAS_GROUP_VISIBLE;
> 
> So if mode is 0, then we return visible?  is that really correct?

If the mode is zero we return, "oh by the way, this attribute group
potentially has variable visibility, so don't assume that failures to
find the directory already created at sysfs_update_group() time are
fatal"

Just explaining it that way convinces me it is time for those failure
cases to go.

> > +/*
> > + * The first call to is_visible() in the create / update path may
> > + * indicate visibility for the entire group
> > + */
> > +#define DEFINE_SYSFS_GROUP_VISIBLE(name)                                \
> > +static inline umode_t sysfs_group_visible_##name(                       \
> > +	struct kobject *kobj, struct attribute *attr, int n)            \
> > +{                                                                       \
> > +	if (n == 0 && !name##_group_visible(kobj))			\
> > +		return sysfs_group_visible(SYSFS_GROUP_INVISIBLE);      \
> 
> This reads really funny, we are passing in "invisible" to a "visible"
> function call :)
> 
> Why pass anything in here?  I really have a hard time parsing this,
> maybe because of the negative of the "*_group_visible()" call?
> 
> 
> > +	return sysfs_group_visible(name##_attr_visible(kobj, attr, n)); \
> 
> But you only call this on the first attribute, right?  I kind of
> understand that, but documenting it a bit better here might help?
> 
> Anyway, basic structure I like, changes for a driver to use this I love,
> but implementation confuses me, and if I have to maintain it for the
> next 20+ years, and can't understand it on day 1, I'm going to be in
> trouble soon, which makes me wary to take this as-is.

Here it is again without being beholden to keeping the old
WARN()/pr_warn() regime when the group directory is not found.

-- >8 --
From 8fe87d28bb9517e4010d567ec7025acf2b8b2440 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 27 Jan 2024 17:37:44 -0800
Subject: [PATCH v3] sysfs: Introduce a mechanism to hide static attribute_groups

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
was called. Additionally, it is no longer an error to update a group
that does not have its directory already present, and it is no longer a
WARN() to remove a group that was never visible.

Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/sysfs/group.c      | 45 ++++++++++++++++++++++++-------
 include/linux/sysfs.h | 63 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 87 insertions(+), 21 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 138676463336..ccb275cdabcb 100644
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
+				mode &= ~SYSFS_GROUP_INVISIBLE;
 				if (!mode)
 					continue;
 			}
@@ -81,6 +93,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 						(*bin_attr)->attr.name);
 			if (grp->is_bin_visible) {
 				mode = grp->is_bin_visible(kobj, *bin_attr, i);
+				mode &= ~SYSFS_GROUP_INVISIBLE;
 				if (!mode)
 					continue;
 			}
@@ -127,16 +140,31 @@ static int internal_create_group(struct kobject *kobj, int update,
 
 	kobject_get_ownership(kobj, &uid, &gid);
 	if (grp->name) {
+		umode_t mode = __first_visible(grp, kobj);
+
+		if (mode & SYSFS_GROUP_INVISIBLE)
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
+				pr_debug("attr grp %s/%s not created yet\n",
+					 kobj->name, grp->name);
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
@@ -279,9 +307,8 @@ void sysfs_remove_group(struct kobject *kobj,
 	if (grp->name) {
 		kn = kernfs_find_and_get(parent, grp->name);
 		if (!kn) {
-			WARN(!kn, KERN_WARNING
-			     "sysfs group '%s' not found for kobject '%s'\n",
-			     grp->name, kobject_name(kobj));
+			pr_debug("sysfs group '%s' not found for kobject '%s'\n",
+				 grp->name, kobject_name(kobj));
 			return;
 		}
 	} else {
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b717a70219f6..a42642b277dd 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -61,22 +61,32 @@ do {							\
 /**
  * struct attribute_group - data structure used to declare an attribute group.
  * @name:	Optional: Attribute group name
- *		If specified, the attribute group will be created in
- *		a new subdirectory with this name.
+ *		If specified, the attribute group will be created in a
+ *		new subdirectory with this name. Additionally when a
+ *		group is named, @is_visible and @is_bin_visible may
+ *		return SYSFS_GROUP_INVISIBLE to control visibility of
+ *		the directory itself.
  * @is_visible:	Optional: Function to return permissions associated with an
- *		attribute of the group. Will be called repeatedly for each
- *		non-binary attribute in the group. Only read/write
+ *		attribute of the group. Will be called repeatedly for
+ *		each non-binary attribute in the group. Only read/write
  *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if an attribute is not visible. The returned value
- *		will replace static permissions defined in struct attribute.
+ *		return 0 if an attribute is not visible. The returned
+ *		value will replace static permissions defined in struct
+ *		attribute. Use SYSFS_GROUP_VISIBLE() when assigning this
+ *		callback to specify separate _group_visible() and
+ *		_attr_visible() handlers.
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
+ *		return 0 if a binary attribute is not visible. The
+ *		returned value will replace static permissions defined
+ *		in struct bin_attribute. If @is_visible is not set, Use
+ *		SYSFS_GROUP_VISIBLE() when assigning this callback to
+ *		specify separate _group_visible() and _attr_visible()
+ *		handlers.
  * @attrs:	Pointer to NULL terminated list of attributes.
  * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
  *		Either attrs or bin_attrs or both must be provided.
@@ -91,13 +101,42 @@ struct attribute_group {
 	struct bin_attribute	**bin_attrs;
 };
 
+#define SYSFS_PREALLOC		010000
+#define SYSFS_GROUP_INVISIBLE	020000
+
+/*
+ * The first call to is_visible() in the create / update path may
+ * indicate visibility for the entire group
+ */
+#define DEFINE_SYSFS_GROUP_VISIBLE(name)                             \
+	static inline umode_t sysfs_group_visible_##name(            \
+		struct kobject *kobj, struct attribute *attr, int n) \
+	{                                                            \
+		if (n == 0 && !name##_group_visible(kobj))           \
+			return SYSFS_GROUP_INVISIBLE;                \
+		return name##_attr_visible(kobj, attr, n);           \
+	}
+
+/*
+ * Same as DEFINE_SYSFS_GROUP_VISIBLE, but for groups with only binary
+ * attributes
+ */
+#define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name)                             \
+	static inline umode_t sysfs_group_visible_##name(                \
+		struct kobject *kobj, struct bin_attribute *attr, int n) \
+	{                                                                \
+		if (n == 0 && !name##_group_visible(kobj))               \
+			return SYSFS_GROUP_INVISIBLE;                    \
+		return name##_attr_visible(kobj, attr, n);               \
+	}
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

