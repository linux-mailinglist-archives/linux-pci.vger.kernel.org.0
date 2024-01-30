Return-Path: <linux-pci+bounces-2814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291D8429E1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977E01C203A2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2365B86AEF;
	Tue, 30 Jan 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGN2NkxS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE446A3
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633327; cv=fail; b=rWR03IrjjxFVDEc5uYHDXft2JocNySNbtpkVMNQSelhx7A4jYPPv7WQX/RfVA9z37aBZsjPZv6zDNchhCKOsrxzQlS3FFTe+Z6SFdFT/2UOVaeHwfi+G4z6CT/vU5iRmf/mLFVIFuUAqrdXazjDGWmWTBYVOxSUTN/lQjUQVaEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633327; c=relaxed/simple;
	bh=e8Nc8nb0XpEJS2rMKe8bMOlmHUdNF3IqD0GaxJ/tThU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cZgrVo7fBNvAHRbK5wiUHYzDBho7255qO7ENLInETaoIYKAXcgBbMic/zLADw24I4bhnF7JPlTFF/bhoAetYjyEzcY/GIMYbZQMmuxN8h4DzIJWv0/iMF+Z8WW9iTWkJZyrAayuMcBIciLzMm2HO/yUhX8NBRbWw7B0ykppk5b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGN2NkxS; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706633325; x=1738169325;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e8Nc8nb0XpEJS2rMKe8bMOlmHUdNF3IqD0GaxJ/tThU=;
  b=OGN2NkxS8cEUH27hVrIbglNwqjXq2Udw0sp1UYyx4Mv5Bz9Qb0kP5O1+
   FaLOXYz/nMjXHn2eVjnNyC168RJHfNJl1KCSpOBAKpGCkDAQ9hPsuU/K4
   GfKGTw2BkqTipBiA+n15HLYns01SN8DajIbQPMSdyJf4c0Pfd/Qn9mmnO
   6Ye/6NbzNrb2252QAwpMxA9CUjdXtbSNO23J1Ig89K5S0Fe3JgkK1qOB3
   TK9W3KMp+uI3XsymF6u1sgQyvFAVqcD98/QRhR90YLGOdxmRab1m6G4f3
   La+m//VQ0panxk5uaCAo2jOdpaj5kBfC8itUb4MzmSOY/YGrBE2RzDUaG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16718979"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="16718979"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 08:48:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907542309"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="907542309"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 08:48:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 08:48:32 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 08:48:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 08:48:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 08:48:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhfGa++1KqfiKisGjcIwdhc8ggKJBYExIOpiqsjuxsZ49r7JzuHclQFpS5RBQl2O1BugSNFbltwaOqsBBvudFZK/PTOzxEYlRDXWfJwhf/iYL+eMtIpg5dirm2HWLetcSjIJ0tJBk7FWMuvYdhARHXlN8LQoFg9RnJin7wtRJtYnUPtZMiI35ucxjjzF+lRd7PEKs+AWU2/ScI436mdGJaQgwWXfMz6hvI2d20tXl4AZav/jaIlCyq8mhcnpwo+9MI7wN0HxUIDvJUIJ77CsggefK8cYwsgkLojke3FYAsS8VH4qbd5ivS9ZQLfHKkvkJ90AJw5m43NVDyKfrRNi5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrf0oxSBXqSKdD4oS5I2LVsqyQhnKU17EMjPpEsllGo=;
 b=Q7WmGixJBo8ZOQ3woQIzghnUOrcxcQrI2xnUQ7GGGIrF1+V9Qb869gzUU3G7p/CmG/su5cFteTkxOB7/Y92p9LcsaFtSHkmp0gTIaAuYU28FpOezWQs93CPeZGXo8qgxWYaxHpFpRJXvt/fSv6XdMpU/FrHwbziE0ukTzAQCjydHQPzapOHmiS2deZ7W3Mn1ITpvUOOTLlO5U3C9j5i7fZ1lYp3wK+KU+3bccpjyo6fH/r+QBiW/5CwjboKtG4aY8sTQ7LzU6NZGdgvXwa6sPREw2otTNaLtzca7SZFtpEARUMZEXNN2iHap6yfnt+QajitLxB1PDj566TrkZszD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5113.namprd11.prod.outlook.com (2603:10b6:806:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 16:48:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 16:48:28 +0000
Date: Tue, 30 Jan 2024 08:48:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] sysfs: Introduce a mechanism to hide static
 attribute_groups
Message-ID: <65b9285a93e42_5cc6f294ac@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660664848.224441.8152468052311375109.stgit@dwillia2-xfh.jf.intel.com>
 <2024013016-sank-idly-dd6b@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024013016-sank-idly-dd6b@gregkh>
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4f91a3-078c-4b43-f805-08dc21b348fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0A/jzzAe/oaU/d/A/cCB2Xp7ofjaEjmR9uSl8AE4PUZwe6UxFPbSBejFhZi5MoEU63HuyMbsmu8kiNGqD25YD2TY0Xd7/4BKsKqMxu+zzsdu3fDe39OpcN8tX3CSnggnkkMVTO53KtWU1yPk/u8knMqPRSsYG/Pn5aBhUZvDDJUz7RnaDSNnCzlcvYs4Wlwm0LjaQBsy1fBztkHFKuORqdf/3MDvU6WYzzlFykbXuGXvD1e2LJCAz1f5lFMWTyJuVZoi4Udhtsq9fprU5P3uohS+owitWvfNdpjjq2WB2PPQf2f+MyVMuOB0WpdY9tinuRINSJ38NtmfNEDa/yW+0Unoju32ZjKqYlHHikyGhCGThPMD/B6Mw2Uk+P5+SS6jHJEYGNJHZ44FkjrM8UexSZbs1a+Xe2OLVs4Mg830bF6tJJXdpQ2lMyPJz2qlv6Ok+4UvAHYQlGQRZTLv1FFo8GOabq3knf9Z6FR8+d27jxhJxzoxjzvz5GHPuFHELvWlVaoZlu4n8LZHaS6Ptbjr8osyNTqE3TFLUFZkZaF/7Ai3N2n6btfFSe8tf6efDKuj8Lvu4CUlZtGQDPNJPulnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(6512007)(9686003)(26005)(38100700002)(110136005)(4326008)(8676002)(5660300002)(8936002)(478600001)(6486002)(6506007)(66476007)(966005)(2906002)(316002)(66946007)(66556008)(41300700001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CBVv4wmSG9bcwoSS5AhnvvXQ4z4LcVWT0uknX5Q1tnws0k47/E8Tj8L8R4nI?=
 =?us-ascii?Q?k1bHPW9khoTsq3nNU5hX54kICIebijUZ4/7ePLXL3masgFS/flWC1NzcEMGZ?=
 =?us-ascii?Q?HLNXq4itnfXR/GiVw8suQoGIA9EJ1xg7OzeS5itdi8aUbNLa8Z5KLfUxhr01?=
 =?us-ascii?Q?0J8zWz3CvF71ZbEfafbsbqS1wkY9ZeYU1Oq3ZEc5c5gOKdl+r9TXmdSkBMma?=
 =?us-ascii?Q?d1XlCyTPzfwTW7VqW60N610vJ8LJ5w5BGksakKNalNCQMHs33VA4tnz8ySiS?=
 =?us-ascii?Q?AeLBzy5dWL0WL0xmC4tGpqivIrH8qlxv2wC3uegM6xuow5/98RpdccfM3CFh?=
 =?us-ascii?Q?oYntH4Fo+7UXO8r8BBoQG7G+T+A15S0DyBw1SD5MPiNSO8cwxhvpKBEnmBae?=
 =?us-ascii?Q?8O7ACz3mugwmqqguNJ97GeO0SNuui0gboD0rx9HvnCu3Wctr22TCyiVFZ8zK?=
 =?us-ascii?Q?3xVbay8LBBg3drbS/LZFTFnHLy7kOZLrZlqyT71hm9qCXW1zKbdvX4lNJlul?=
 =?us-ascii?Q?/3g7xAtIx1vqKaJUr2Q3X7gTJDcW4xEe9rl8JS6tspsXH6Uo1P+BQ9dnZFq3?=
 =?us-ascii?Q?0IQ1QW9BHWFFf9TlBv/JRAD1RWf7KeVwwLvDEMaZD+cJbfhbzXjvjujYSuVB?=
 =?us-ascii?Q?ptaf5bR22QzF0SOABVWrKcICtBRylmwBCYIIGUqN/gQ5I2a5RcptVQVq0anU?=
 =?us-ascii?Q?j7q/1bjMWKnCirYI3tytYtQOOpWJns7HFbk1SdK5wetUanfMQOWc3k00cWhj?=
 =?us-ascii?Q?paN3SXhuTG3Yq3JD49OpjKcWvCPuxhHb/dn3xNZKCWxaZWGFvpYc5psnmYud?=
 =?us-ascii?Q?6P7S+krog7hi+R6b1tvHJKysi7ydvduJ0u+B7xAL2jJ8VwEEtUKWa+uoZ/XS?=
 =?us-ascii?Q?III5VTwi/B3jFRls20CJiLC4woqFMa9Loou8rK1zB2cj6Fq+PRMcA5VLaKo9?=
 =?us-ascii?Q?eerKn6o5M2G+b5cQGyO3CWqvL6Mxu6nwsNgStGsKmZSns6EvgxWJE8z6ZGPi?=
 =?us-ascii?Q?aD7+qmGt4mzuhfGQYDS8NOn7XD1WCJhM6DNZPaoIdqng8ecqqSAo6AfcSL0G?=
 =?us-ascii?Q?90eNK2akgsQeBCNA6GexVKnsn8bufIAZSLk+1YlVmaOToCn/1sQsL95mpbQZ?=
 =?us-ascii?Q?YRaQwzgWA7M6sv52MysyjtQqB29NYzDGqGIKrTMFEai/nVoZmju30rHLAzUJ?=
 =?us-ascii?Q?m8tOuKG70PT2llA4RKap/rkDyJmDsVAtbPwqRK99JFEqIh7XJRkj5oPcen4J?=
 =?us-ascii?Q?gEhwgC++AVwgP1XRL6RYItbTiLpWJrT8d4aGUz35b25KGWR7hEsddSVGXLBI?=
 =?us-ascii?Q?TUwOiW1VmizARoFNacOKtswLRfA4UxAhktmWaxugvJDoId6vUWp4QZrc/poZ?=
 =?us-ascii?Q?NeXQx9MU/vtERA4+5ZiPmvMDZXFAnwiibVsaOoHmwFx8FjwjSUOgkgY53ca0?=
 =?us-ascii?Q?bRyqe3SFDrVb75hlEskB5qFHO9MUATFWtIX4bVC95hjCPBervOS7BdlRJ6c5?=
 =?us-ascii?Q?Bg3senrSxfmQ0fC74wa7TxmbZux/tL+993o70inPHFBeUDt/UC7UtC0s7r2d?=
 =?us-ascii?Q?eZtPppOVSyISuUk1DsgYjrLRSZDrFkDZ1U5Ws9yT1bgQHiGHdCFnGyDxbAwz?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4f91a3-078c-4b43-f805-08dc21b348fe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 16:48:28.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FM/4egT64x52K9MpcYfjH0xlc4BVxVSaniD12/Zv+7Sx/SoaNj5Jyge00+NKA/zxcEGDnx2JjnMtO9OEXRIQhAC9FLxy3TwChP0sX0zanbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5113
X-OriginatorOrg: intel.com

Greg KH wrote:
> On Tue, Jan 30, 2024 at 01:24:08AM -0800, Dan Williams wrote:
> > Add a mechanism for named attribute_groups to hide their directory at
> > sysfs_update_group() time, or otherwise skip emitting the group
> > directory when the group is first registered. It piggybacks on
> > is_visible() in a similar manner as SYSFS_PREALLOC, i.e. special flags
> > in the upper bits of the returned mode. To use it, specify a symbol
> > prefix to DEFINE_SYSFS_GROUP_VISIBLE(), and then pass that same prefix
> > to SYSFS_GROUP_VISIBLE() when assigning the @is_visible() callback:
> > 
> > 	DEFINE_SYSFS_GROUP_VISIBLE($prefix)
> > 
> > 	struct attribute_group $prefix_group = {
> > 		.name = $name,
> > 		.is_visible = SYSFS_GROUP_VISIBLE($prefix),
> > 	};
> > 
> > SYSFS_GROUP_VISIBLE() expects a definition of $prefix_group_visible()
> > and $prefix_attr_visible(), where $prefix_group_visible() just returns
> > true / false and $prefix_attr_visible() behaves as normal.
> > 
> > The motivation for this capability is to centralize PCI device
> > authentication in the PCI core with a named sysfs group while keeping
> > that group hidden for devices and platforms that do not meet the
> > requirements. In a PCI topology, most devices will not support
> > authentication, a small subset will support just PCI CMA (Component
> > Measurement and Authentication), a smaller subset will support PCI CMA +
> > PCIe IDE (Link Integrity and Encryption), and only next generation
> > server hosts will start to include a platform TSM (TEE Security
> > Manager).
> > 
> > Without this capability the alternatives are:
> > 
> > * Check if all attributes are invisible and if so, hide the directory.
> >   Beyond trouble getting this to work [1], this is an ABI change for
> >   scenarios if userspace happens to depend on group visibility absent any
> >   attributes. I.e. this new capability avoids regression since it does
> >   not retroactively apply to existing cases.
> > 
> > * Publish an empty /sys/bus/pci/devices/$pdev/tsm/ directory for all PCI
> >   devices (i.e. for the case when TSM platform support is present, but
> >   device support is absent). Unfortunate that this will be a vestigial
> >   empty directory in the vast majority of cases.
> > 
> > * Reintroduce usage of runtime calls to sysfs_{create,remove}_group()
> >   in the PCI core. Bjorn has already indicated that he does not want to
> >   see any growth of pci_sysfs_init() [2].
> > 
> > * Drop the named group and simulate a directory by prefixing all
> >   TSM-related attributes with "tsm_". Unfortunate to not use the naming
> >   capability of a sysfs group as intended.
> > 
> > In comparison, there is a small potential for regression if for some
> > reason an @is_visible() callback had dependencies on how many times it
> > was called. Additionally, it is no longer an error to update a group
> > that does not have its directory already present, and it is no longer a
> > WARN() to remove a group that was never visible.
> > 
> > Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
> > Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  fs/sysfs/group.c      |   45 ++++++++++++++++++++++++++++-------
> >  include/linux/sysfs.h |   63 ++++++++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 87 insertions(+), 21 deletions(-)
> 
> You beat me to this again :)

Pardon the spam, was just showing it in context of the patchset I was
developing.

> I have tested this patch, and it looks good, I'll send out my series
> that uses it for a different subsystem as well.
> 
> I guess I can take this as a static tag for others to pull from for this
> rc development cycle?

That works for me. Thanks Greg!

