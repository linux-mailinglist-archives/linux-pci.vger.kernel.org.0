Return-Path: <linux-pci+bounces-4069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C4C868642
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 02:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721C2285040
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 01:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11655C82;
	Tue, 27 Feb 2024 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="be8wFHkt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20CC5672
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998440; cv=fail; b=rPWxmgm99Nsy+Hi1DeiIGOWaJE2v0fab6JnrKHaVtn1jqLGOsH+CupzMnhxQSt4ne+WbRhRbDuDPLB5B71oRB8QQBQcL2TaqDu/h3uwrIzMFvJmDJ0SUneGtBDiDwBKW1Jc86XFmQeLTs4RMxjfY6oEoQWIrQoZhmkaSBj4cRmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998440; c=relaxed/simple;
	bh=t3r2K58+L29Wr79yr0nmPU0fBvei5xEWD+aAx03PQvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GTy57t80wOd14pmzY6c5Ldn+1ZmlrrzoqGu88jjgySSoD76d5bGniQ6oJraUjRXcG39B2auNIAzH+AcmwXx7jEKEruuaK4yfquplBLvVoPIWDKtQuqG0BsK2z9sV+lOhgyE+CE3ASD0zvGR5g0swvoJf3GRKKbw+ePVz8y1RW40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=be8wFHkt; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708998438; x=1740534438;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t3r2K58+L29Wr79yr0nmPU0fBvei5xEWD+aAx03PQvQ=;
  b=be8wFHktlKaCLtgqLxwfnNfov71j2QsXk96sqLvgTQVbYlgcyrcDqNQE
   FbWKddFclyQ67TAyxNFpCDZTPFW5d03Q3YuwMcVETEUHDBCHB551jWVvH
   hbmvtlV+c3gmgBjjpUX53rMKZxENfKNueCfArE1sqAEulF36xwUNMqyJa
   O7i2xgXyD29HPUcDwjLMBtbr+xu48RiB5h9GsztOclH4rSyIsJXyxu1Q2
   jcMtVWgyx36YDa/En5cPk4pZgaLKRyIWQoHiJfMA11NWLFpyP5zsfJ9F3
   U6DqaYVr6iBy/jLgMenM3oJmvgVCEjWCQrbCef86kmRmRG6ffgR8bTrnW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3480476"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3480476"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 17:47:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11647325"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 17:47:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 17:47:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 17:47:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 17:47:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 17:47:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfqIhUWlqxAxFWPZH1WoctGHvpgzf0WvIQY27HeKMOXyEHuVP/Ucdd3F82jtRaontk88VxEk9z95KCR+d3KbEdeJ9nx0EFcBCiTpacvf1NeP+o+b1CfYlLg2o6tte3TVhPw5D+19mF/5rGEkk2KJtU4GFOB7uk9PXgKvB7fEO5X8zSswPF3yrh1MGvG5AXdSFJJxPp11/VWxDTuTy/6zBq7SUPsy5CLXzm9JV3Qa26o0ocv0FkUPUNilA/V/roqgZQtD16vxtIiYBEDjA5LiLhRQrjak18y7wKVMhrgSbRH8298ZkwxCtdhwydhJ+qHFYLvJ3PrG2j0DSZZ4s6jnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne59teCpdp8zyxM0Nb0a0Vf4i8ezJOrt6au+QyTLoPo=;
 b=D3ylezj4nvmLKCA/O22oM/MrJN50oCvKUrno21OLTYag+tzX42DXazo6U3wxaFJqvlm0BexoZMXLmQC8imDN9BKYw+M7zHyjtH6z8L1+Lk5gbnru+U349tzdJt8SlLKYG8MwI1VOsArzAf6zj5DjrTAYjWus/3p+eihBRu+NHPf1N8X+g7ZRUoKX9OlZWYAVSFvR/5JwJgmh3pnnQiFzjcDbrV0SR+okvc2k/CtbWmnNqp6tPQosxNGqJD1dN04s9XnK3smOYQK4ODdBSh39WRs5AFq3d9x6p5VZ09pkpGkdvD61YB/X+kCmyp7X0gC0lBng+I3Xlw8CrQ/b/bOZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Tue, 27 Feb
 2024 01:47:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Tue, 27 Feb 2024
 01:47:13 +0000
Date: Mon, 26 Feb 2024 17:47:10 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Wu Hao <hao.wu@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, John Allen
	<john.allen@amd.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 3/5] coco/tsm: Introduce a shared class device for
 TSMs
Message-ID: <65dd3f1eabec2_1138c72948c@dwillia2-xfh.jf.intel.com.notmuch>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660664287.224441.947018257307932138.stgit@dwillia2-xfh.jf.intel.com>
 <63f8e848-2fe5-40df-bb97-c628b83b1b06@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63f8e848-2fe5-40df-bb97-c628b83b1b06@amd.com>
X-ClientProxiedBy: MW4PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:303:6b::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d91792b-a9d2-4118-82d3-08dc373604db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6wIuoCXedvXLZeXTolYjjcgMFmxylvKDo6gNfQJhlGIKy6phcLSlmEu6NTYaYo4u6r7PYqQGUJGNIBmnbjDqwI3MoR86ZybXsVLs3PVFinmBaPdhavn9zef1EmWt1IRgXyDBopLe79RG32+6p5QB/NxevDQGRcEcZmILqMgn8nW24p4gvN7l0eJtPCptVitkux6P7CdS9JdhKb0t2QLmryO3Ga733BpqCjDeDSlhwABnpAWnYzmFWXeB8NfiDTkWQ9bcTQoFetjwZAq4t0fhH0Bv//JxU7NNWRFOQ0F1g0i+nNMU7e6SZ+3tX0pDqdApjrzi12K6Mb3iKxBTaqTEQFAQZkzLKaeCJrDbXUIkBvJ4Oxh2WktmNumaJv5vCoxG+djhSTmS6SvaxjTcg8n16qn+DQTiXOvhWTaqijqqfK58NnhTgtZ0jIYXWYsp8zOKMzpGT/nEhffUaJfHn5r10Xj19fplIoRYV2iTVbxMutwYgvCCc3ARHHhwQW9lMmVyIkK+dOq9/jFQT3D+YPiTYlFEF9zqGoF9JLROgS5Rf45N1SVcaNueLVPoxVPbkyQvDPQtFKtM+NRgzfRcq5zI9DRVizVY34pS7Hyc3i1j8nVSLt0EImBZ3sJRtfs4+qEHMijJvcuk7pmGMZpvxQONQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z9sxIcEYqTZVR85cYMAWuc9LJA8A0+9J1WyPWZMISUDjW7Aklte7lttG43w5?=
 =?us-ascii?Q?YFbpTZiHDylr4Gml/8ln6ga7I8RQ7gIZoYdk63fxFdAgZpUONGWBX9k/mX5T?=
 =?us-ascii?Q?musDM2jvqFncl46dPLIg8ffjiJPpRYAJ1sRpXwMAVSiFyJhpYYGwGvy5ASKt?=
 =?us-ascii?Q?I/mG5aFUJF3Z7RxxVLNOdNU8iAS1Xyf9jfF8OUR3bTfhW4X1JOnryU1T1zhb?=
 =?us-ascii?Q?7esRiqH0J38S1nhO1J6xJJsm167ArAYwHR7s0h5WR3CX/AYJDSoh6w/QnUoH?=
 =?us-ascii?Q?bpx+CM9NgYFEgAQxvKjYYdjnn1jsqazUoeWRS6lMwZT3KGXCkWytG8FuiM3P?=
 =?us-ascii?Q?fS59u/7NwhcthC5rieQZWo09pTUn9cDE/eE1u0b130JfDB4aoW/5g05kLwX0?=
 =?us-ascii?Q?XRmfS+WPbA9JX9Odts6OO2Qt0LnQBH7V9/+IuK8/Nzf4UqSTiP+oaIq4soN4?=
 =?us-ascii?Q?BsOgfbreY3s9lCs1VfoYH+iNWarzEJpm1gEFaC9KE8XVVx2liBxRpN+oZaX0?=
 =?us-ascii?Q?MA4gPMkD4/Du4FKjbOtHgFlleSmy0oMpe5PQ5xi2IGPmLao377wJZAr7mQur?=
 =?us-ascii?Q?OWd56am/n9DCqczPwb6QljPU1TwcI1z7OZgg8dIrezEiRxrmKTFJWqXX2XXx?=
 =?us-ascii?Q?heDPWiKirC3V9WT+w/UqlEqeJdlfDXJl3jkx+Hqqpqhn5aXpQVULyO6LgDU6?=
 =?us-ascii?Q?jpcm0kmlTOPDJ3oTkFG8L6OKZZz3lqQHUTvQKNA6PzYWjF1NGtoy7m26SOt2?=
 =?us-ascii?Q?IBT9VVF52/D1lGGtCmGAsyC06mQqkxgkZvpshqkdZyni5nJOnVKjqv8hFOZA?=
 =?us-ascii?Q?IwyzN1LSvdakSnQIg0/vPEVL3ixbSsVW18JL+f1u9zyE267nw9O0y/izVGpX?=
 =?us-ascii?Q?JQDklq/E7k0U4z3+SqyxHL1JSfZDZh7KtgssxPYnCwl+TdlmcfJyeUeY8WD1?=
 =?us-ascii?Q?Kxu9S/EGMqsREg6CQE1F0Zxwrf9QwKlxvhZQ+IY8dc0U24d+myz0I7mBLkEb?=
 =?us-ascii?Q?FL6APF/Mp5DuezArNyj2iKm8uRkW5FkM5yOxjkGfumw+wpPQgtyj6ykm2dJ1?=
 =?us-ascii?Q?LSNFfVLAnv+qOXDMngKvwf9jCzTv7gRJevpsHuLROFhaXHtWM9FTFzkkBx/z?=
 =?us-ascii?Q?xRhVrEuDbegAj7K1Xkes8JopuLMof+QX5d9cApdEktghBmhiHt8+4mSJrLmg?=
 =?us-ascii?Q?UTH3AkCnBdUgaKNIAa1EP6qvR2xAlaHUBLYvQ0KdmTG3YRpaoNTmLWsfoMpW?=
 =?us-ascii?Q?ZdQ6BPgSjutDGeWaYJj2jifBNO/9nRFrYRIlhAWDntpCNB68l6RJp6bSmIV2?=
 =?us-ascii?Q?baNkKqagkuG5toBE+S0EfWhqHx05VglfYDzQ0xSXrQsLNO8lHKjjxIXexenf?=
 =?us-ascii?Q?v2WA4c4T4nnvg2x7Ed6ISbqo7CuvPRDuCVT1TGo36kExaueXub68LYFiwT0B?=
 =?us-ascii?Q?xO79UHlLz9kff8htodymeIwDhzc4N83RiN+COQjfdfB+iKKTl8MA8MHx1MLy?=
 =?us-ascii?Q?68LYHbT4aZKUg4W8J9OuO8J+EDQYG+sB5eR1f5aM5fwEPV06tR1S/+DqVYL1?=
 =?us-ascii?Q?2CVRj7ItCEVKmA+zbth26vbQohugMHOpHq7fqrB4o25DwymuDd96H1kwfTPz?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d91792b-a9d2-4118-82d3-08dc373604db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:47:13.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFsexxS8aQrNxYiPopD8ATawbAhRVe5UZRjkr2E64UvmD6nNU/+Jb+ke6nt5KFsT3x6dt/IcC3cYA0b3RSPp4rLLkj7eimtC+rSzmkEr9/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5456
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 30/1/24 20:24, Dan Williams wrote:
> > A "tsm" is a platform component that provides an API for securely
> > provisioning resources for a confidential guest (TVM) to consume. "TSM"
> > also happens to be the acronym the PCI specification uses to define the
> > platform agent that carries out device-security operations. That
> > platform capability is commonly called TEE I/O. It is this arrival of
> > TEE I/O platforms that requires the "tsm" concept to grow from a
> > low-level arch-specific detail of TVM instantiation, to a frontend
> > interface to mediate device setup and interact with general purpose
> > kernel subsystems outside of arch/ like the PCI core.
> > 
> > Provide a virtual (as in /sys/devices/virtual) class device interface to
> > front all of the aspects of a TSM and TEE I/O that are
> > cross-architecture common. This includes mechanisms like enumerating
> > available platform TEE I/O capabilities and provisioning connections
> > between the platform TSM and device DSMs.
> > 
> > It is expected to handle hardware TSMs, like AMD SEV-SNP and ARM CCA
> > where there is a physical TEE coprocessor device running firmware, as
> > well as software TSMs like Intel TDX and RISC-V COVE, where there is a
> > privileged software module loaded at runtime.
> > 
> > For now this is just the scaffolding for registering a TSM device and/or
> > TSM-specific attribute groups.
> > 
> > Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> > Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Wu Hao <hao.wu@intel.com>
> > Cc: Yilun Xu <yilun.xu@intel.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: John Allen <john.allen@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   Documentation/ABI/testing/sysfs-class-tsm |   12 +++
> >   drivers/virt/coco/tsm/Kconfig             |    7 ++
> >   drivers/virt/coco/tsm/Makefile            |    3 +
> >   drivers/virt/coco/tsm/class.c             |  100 +++++++++++++++++++++++++++++
> >   include/linux/tsm.h                       |    8 ++
> >   5 files changed, 130 insertions(+)
> >   create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
> >   create mode 100644 drivers/virt/coco/tsm/class.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> > new file mode 100644
> > index 000000000000..304b50b53e65
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-tsm
> > @@ -0,0 +1,12 @@
> > +What:		/sys/class/tsm/tsm0/host
> > +Date:		January 2024
> > +Contact:	linux-coco@lists.linux.dev
> > +Description:
> > +		(RO) For hardware TSMs represented by a device in /sys/devices,
> > +		@host is a link to that device.
> > +		Links to hardware TSM sysfs ABIs:
> > +		- Documentation/ABI/testing/sysfs-driver-ccp
> > +
> > +		For software TSMs instantiated by a software module, @host is a
> > +		directory with attributes for that TSM, and those attributes are
> > +		documented below.
> > diff --git a/drivers/virt/coco/tsm/Kconfig b/drivers/virt/coco/tsm/Kconfig
> > index 69f04461c83e..595d86917462 100644
> > --- a/drivers/virt/coco/tsm/Kconfig
> > +++ b/drivers/virt/coco/tsm/Kconfig
> > @@ -5,3 +5,10 @@
> >   config TSM_REPORTS
> >   	select CONFIGFS_FS
> >   	tristate
> > +
> > +config ARCH_HAS_TSM
> > +	bool
> > +
> > +config TSM
> > +	depends on ARCH_HAS_TSM && SYSFS
> > +	tristate
> > diff --git a/drivers/virt/coco/tsm/Makefile b/drivers/virt/coco/tsm/Makefile
> > index b48504a3ccfd..f7561169faed 100644
> > --- a/drivers/virt/coco/tsm/Makefile
> > +++ b/drivers/virt/coco/tsm/Makefile
> > @@ -4,3 +4,6 @@
> >   
> >   obj-$(CONFIG_TSM_REPORTS) += tsm_reports.o
> >   tsm_reports-y := reports.o
> > +
> > +obj-$(CONFIG_TSM) += tsm.o
> > +tsm-y := class.o
> > diff --git a/drivers/virt/coco/tsm/class.c b/drivers/virt/coco/tsm/class.c
> > new file mode 100644
> > index 000000000000..a569fa6b09eb
> > --- /dev/null
> > +++ b/drivers/virt/coco/tsm/class.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/tsm.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/cleanup.h>
> > +
> > +static DECLARE_RWSEM(tsm_core_rwsem);
> > +struct class *tsm_class;
> > +struct tsm_subsys {
> > +	struct device dev;
> > +	const struct tsm_info *info;
> > +} *tsm_subsys;
> > +
> > +int tsm_register(const struct tsm_info *info)
> > +{
> > +	struct device *dev __free(put_device) = NULL;
> > +	struct tsm_subsys *subsys;
> > +	int rc;
> > +
> > +	guard(rwsem_write)(&tsm_core_rwsem);
> > +	if (tsm_subsys) {
> > +		pr_warn("failed to register: \"%s\", \"%s\" already registered\n",
> > +			info->name, tsm_subsys->info->name);
> > +		return -EBUSY;
> > +	}
> > +
> > +	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
> > +	if (!subsys)
> > +		return -ENOMEM;
> > +
> > +	subsys->info = info;
> > +	dev = &subsys->dev;
> > +	dev->class = tsm_class;
> > +	dev->groups = info->groups;
> > +	dev_set_name(dev, "tsm0");
> > +	rc = device_register(dev);
> > +	if (rc)
> > +		return rc;
> 
> 
> no kfree(subsys) ? Thanks,

No, that's handled by __free(put_device), but I want to make this
pattern easier to read with something like.

	struct tsm_subsys *subsys __free(put_tsm_subsys) = tsm_subsys_alloc();
	if (!subsys)
		return -ENOMEM;
	rc = device_register(&subsys->dev);
	cond_no_free_ptr(rc == 0, return rc, subsys)

...stay tuned for whether Linus and/or Peter like the cond_no_free_ptr()
suggestion, will address that on a separate thread.

