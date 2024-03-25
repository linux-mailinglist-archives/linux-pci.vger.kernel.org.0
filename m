Return-Path: <linux-pci+bounces-5124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4A88AF09
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 19:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F6C2A54CC
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7FB11733;
	Mon, 25 Mar 2024 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJvZYfsw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16071C02;
	Mon, 25 Mar 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392775; cv=fail; b=cdAsNkbObK8Ms1lbv8gEH/ZVnvgP6R1h2JM3aDJe99fp4FkugKB10Lakb3qq2uPNm7ihDbzNrCBTBob8hSOsDLCiFkOjRZ6cdk9QyPWtJXtJGtiYy/JJmhWV/dsXYXP8qVyhf02RAhiK95yLA0Ao82Bk8vTar7C369Gjy0jaFHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392775; c=relaxed/simple;
	bh=F0c+Ag9enOnCYPAZw7cRr/MxD4nJVoI+5T6qD7OtfDg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lD1+1+U6jPuu1j8caF62nScwC3mh0dnF8gzdvLAJS/UInS8q2jH2PwWU7r/E03S2B9SOdZ/3wGRYkM+KqsGehoxd8qLPPDzPz9AnnRptv/9Zn2ZRX7e+/GXwryXsvumqY0Dvlus8kcTqjF11w0kvjPQ+XwCyYa4eVGUwZk49hmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJvZYfsw; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711392773; x=1742928773;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=F0c+Ag9enOnCYPAZw7cRr/MxD4nJVoI+5T6qD7OtfDg=;
  b=fJvZYfswmAeU/Z9Cvg8uhOESWlvBn2EWOdZRp+x6pHc8BbfVcknv9/x1
   lETOx4+F35AVIGdpjtRxHfkpVaup1Kc/pdojvnNQuwiMQAamFjUXIF6Ff
   b88WCsTO9AGpj6JGWa64aaTzLUh8sbRHTK6A5uW6e7Mk0LHOmnjkr+BKO
   FeACl2T4r45TVnfahczn7w3nx42hb9yIkJFGnhcogENW1YezPeJWHv5ee
   UW56H3CZMsw8ZSE/+82it0yThDweggpGzxIxvojtgWCNrU1uXHRbthHSr
   qPLMBWDLRWp0WkvUCnzE0MAY26HfQ82Qga81daOiiiT8VXoIRssqxs5aF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6277509"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6277509"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 11:52:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15665367"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 11:52:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 11:52:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 11:52:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 11:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4uk1PknrainGQrLtaDajuV37L20Cnv9hAqE3c0FLqjoG9QolQiQnPaOkqfovpVl1Xuhtxa+mdjfyzw6uV1xKF0Vfjze13xho9U8lVWQYvEFP3pdnyZYA1aT7tWZZqb8EUtFqGEdvybIa4PQHQ2NhG71VYqj200kiW7dRIgf5XqEQOp1Sxhae6mtCwgtiZ80ISjBC2k4ipRmgdDHQi7+oPukCBYIA8PBmjdrdzJ3lOeCSFN+H5Ujq4HcdpLwQ8FrTzjszyP8hzJnWPhAqQrgYJp0q9q8FZZvnQKflQMBXnadcOMzo87fl+y6RRm95VQUQ2FcU8Jlj36gvDtzsi0+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES9YSVaq6EEdecXIajPyYc58O4qHFTkMX0zCe9WZqdY=;
 b=I8ZHt9s25jzUsJLlk2pcqDCKYpY+URZSF3SZUbKXqItIw7qIz8u4Ot8HsTNAlDnVaXwuLt2tx6GXFUCR9lQoB3gMyOT+GAs/0TaHUzNM2/EWmDRoChbJ99I+IeVnFLyKHRMXuQAHS+7PF78k1mbgfaS8VX4daCK7qIVFDM2KDtxJRddjBTO40imtLRSaLbz+i5iwB3pFRQobA02n9d4hL1/0Xi4CImVNBLRa2upE+hZbThXrkWFQCUY9ktf4VsN6pYK9PMrltMGqiYMa9Ap+F+ipsbB33zWW0K/JRGFNoxjCUoQASjs6dALrfbkE96gjyOoUGb2x3b+WTuNRSEqwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 18:52:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 18:52:42 +0000
Date: Mon, 25 Mar 2024 11:52:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <peterz@infradead.org>, <torvalds@linux-foundation.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Lukas
 Wunner" <lukas.wunner@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] cleanup: Add usage and style documentation
Message-ID: <6601c7f7369d4_2690d29490@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <20240322133434.GA1340126@bhelgaas>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322133434.GA1340126@bhelgaas>
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7345:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylsZUPJmF9lFv9hUw/5w95iNBM5FSB6CWumLBbSuYDlfMDEaA+pYWA/wFoe/RqsPpS1qiJCwfJKA6sa0Xt9qn8UN5+ycNxIvXMeEGtPfZpjBUlD8rXEOmiFfC+eK9ni6r8um/MsVl2QZlQxbw5rJpgjaJNVbGCuPKmDPCptd3zSaZ6rsIAEKZItTVOondh5DKSxYt7af5EAzN2IyxqsQs0W+R1K5q2RkQJ9uHDpu08LHvlFYeOhx5j/ICnSeWm8budb5XrlkfSHUi5fM+XuTSMyhcb889aeDUG6GwbwFdNtPB6uq4h1FPIGZwUMXbpliLgfpY5WEjQFd9pZYTMEMvIKlqSmjcDNupiX26cwy33Uwxe0VkxvCUKc0mtEzZHTXpYqsdbsUZjn0gnuOYCehzx7nvuthMHAsbNemYLcsMEOXqdpuNQk1KeHCmf2T++3N2qAIQ1ui/G4PmhNGC+zEsgxs2ogNTirkNwfnQoGj6TO1g6m6PpMQahdfqdGB/5sJEEQ9Ict1E6pax/2Ih7Z3ff3URxl0bfukJxEIAV+BTj1cZ1Fg4cxGoceuM/iwCozqc8EQM6PIb3VfKlhdhuaYo5cxIoHd3TQxokEq3j9nCfvLQj7cZ5GvSzaTZ8BEf18Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?da57CinJ8btJ3ICX1zsrdV9qjuIqQTUi02BoyUGiKE8z0WAks95fRftvFg?=
 =?iso-8859-1?Q?kTh623l/JbYoDoi/wxJtEez516CxnMei+FXSRMCgBlt7sDAuHndqit1zSK?=
 =?iso-8859-1?Q?eV39ePTrm1i4ildcqX95CPf0LRUG4fj67IzqPLISJV99t8D5VQKlFl9uS8?=
 =?iso-8859-1?Q?aS3AkImUflFFzTKEeA/EOeR1alNYJhi+/zsHbj68PvMICriDDwDWmewXjR?=
 =?iso-8859-1?Q?DHp8+GJsnah82xeGGhAEESX93EGr7PsONC5JierebqLNPVWdWJR0a9Wbxp?=
 =?iso-8859-1?Q?qCQ+8QwJB1eobxXB3q04gUZnPsHriYh6r5kBLj8+wwUzGJgZdnLoLPzOEH?=
 =?iso-8859-1?Q?446sunegGhbDRmlSeLXvi+ehdiqjWC3dFOxcbILaxKfeTTSS0OinpLGYY6?=
 =?iso-8859-1?Q?kzbVjZu+igPHpEfxJdpArZ4ynVNVZ32FFCNqGzQQ5Xn89e96BlnBEdv0v/?=
 =?iso-8859-1?Q?NLgDyBYYCE6Xv9nSxF5BWH2mUuxm49oWotHdhr17BD3Ydb2+GS5U03m6Qd?=
 =?iso-8859-1?Q?CjDBRU4dneLwn8c6C99MqseDP624QhqbCDqvs/YpMrHAwanXLEqieh+vXZ?=
 =?iso-8859-1?Q?T3K5h/snZKwSHLNFzUXXvQdLcUEoZ7QaFJvp4oaRDqVm+8HF9mEA3zO4CR?=
 =?iso-8859-1?Q?H48ahqIK4icyGYMWCdYT2hW6ff5Fa/VhN+JOHmwq2HMst8eSO/EHfHqoA8?=
 =?iso-8859-1?Q?5nirUJ/LkALr26k+b+ZjkyFr98eydkKbwn/hZ8E2/V4VGM8igF2O7w/Egg?=
 =?iso-8859-1?Q?FJZcsmXrmDWKybE3TiG9vlPArdWt5QglnUxTTLfGFp3SN0pDlUVdqmA3s0?=
 =?iso-8859-1?Q?Yu++waPA6GLl+K3vIPWSMsnQk/sHVlDLX5waPZmZY4r5pd9rX3L9aHC5o0?=
 =?iso-8859-1?Q?T3h8QY3S4b9AMSI2LXqG1Nl7hyHmUN5bWFINxXYT2OFpCnd4Ji41HttIwa?=
 =?iso-8859-1?Q?4N3J0oEjive4ohpHwAGy4lJ9G2S+/GHCuGGAMcEOSeCevSLmf57u3tmwJu?=
 =?iso-8859-1?Q?Op+oOdHkTIReV1a1AKcqVfjXHRdtUTJ4tL8AzkV8BUqEgwpaX0AAR/jp83?=
 =?iso-8859-1?Q?F+paRHj/jwO96opGRKiO2RbN9LQYoMKF864utEGDfXDgwLNjSGhQHVsJuA?=
 =?iso-8859-1?Q?O+UOb3djv+dgGuQ01ce2By32WIpnvdmeG8DBEJeJ79y9Ibp8aOSNJ2e4ve?=
 =?iso-8859-1?Q?MAJ4JnMaia+GGASaJU7yshIPJyztIOuegvlJlj1cUVKnvSYXAZrIuPzEc4?=
 =?iso-8859-1?Q?ZOatPXG0NkmD2d7AA1Zq8X/mVweyAtkVRnXIFfs35P71XbxhTtb4DmzpIv?=
 =?iso-8859-1?Q?4pzK7kV5Qui7EVhDjYZNVzsD4ZcQTleRRcIYYhfl0aJQAYpUBj2WjYOo+Y?=
 =?iso-8859-1?Q?B/kspyR6btcbtZNHOrh6M/9+S1W6KnELFghFnExjqP9s0nV8nbkrQfy/pb?=
 =?iso-8859-1?Q?cI4qD111VcARrCYKGyvvfAJMr3m1R6RTHdthSFAxHnh/QSrhUvbD1NcGJx?=
 =?iso-8859-1?Q?VumFSW8WX1x1Y6rMkyELrV88Pnf0Ok5haZ+OgS9x8zRkaWsM0E8gV/UW5d?=
 =?iso-8859-1?Q?s91hCa46cY7nnnn7KYJ5e9WzRUwp+7+MrCi3mJqpdyvTtyBrKL6o2tZ7lD?=
 =?iso-8859-1?Q?KBO/XNRsRtgvzn+E/7P0k1Ujj8df3uDdfmfPrSZ00tuKbPhGb+ERHAhg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe212a80-1618-48b0-ebf1-08dc4cfcc049
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 18:52:42.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EjBHCtbliCH5oJKLL9HTk6IIIAPg1dSuGqIvpZfBVOj0FLhcLiRQ6mnrVacORN+XTund0XZRFaf7Bf7nS0IQDZ8Q+Eysnh72VYbyX2O7EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Wed, Mar 20, 2024 at 03:04:41PM -0700, Dan Williams wrote:
> > When proposing that PCI grow some new cleanup helpers for pci_dev_put()
> > and pci_dev_{lock,unlock} [1], Bjorn had some fundamental questions
> > about expectations and best practices. Upon reviewing an updated
> > changelog with those details he recommended adding them to documentation
> > in the header file itself.
> > 
> > Add that documentation and link it into the rendering for
> > Documentation/core-api/.
> > 
> > Link: http://lore.kernel.org/r/20240104183218.GA1820872@bhelgaas [1]
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: Lukas Wunner <lukas.wunner@intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Peter, Linus,
> > 
> > I am starting to see more usage of the cleanup helpers and some
> > style confusion or misunderstanding on best practices on how to use
> > them. As I mention above, Bjorn found the writeup I did for justifying
> > __free(pci_dev_put) and guard(pci_dev) useful, so here is an attempt to
> > uplevel and centralize those notes.
> 
> Thanks for doing this; I appreciate it!
> 
> > +++ b/Documentation/core-api/cleanup.rst
> > @@ -0,0 +1,8 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===========================
> > +Scope-based Cleanup Helpers
> > +===========================
> > +
> > +.. kernel-doc:: include/linux/cleanup.h
> > +   :doc: scope-based cleanup helpers
> 
> Neat, I didn't know about this way of referencing doc in the source
> file, although I see the markup isn't universally loved in source.
> Either in cleanup.h or under Documentation/ is fine with me; grep will
> find it either place.

While grep will find it there are benefits to keeping the documentation
closer to the source. So I will keep this "header" markup, but switch to
lighter weight "::" instead of ".. code-block:: c" to minimize speed
bumps reading the examples.

> > +/**
> > + * DOC: scope-based cleanup helpers
> > + *
> > + * The "goto error" pattern is notorious for introducing subtle resource
> > + * leaks. It is tedious and error prone to add new resource acquisition
> > + * constraints into code paths that already have several unwind
> > + * conditions. The "cleanup" helpers enable the compiler to help with
> > + * this tedium and can aid in maintaining FILO (first in last out)
> > + * unwind ordering to avoid unintentional leaks.
> 
> I'm not a data structures person, but I don't remember seeing "FILO"
> before.  IIUC, FILO == LIFO.  "FILO" appears about five times in the
> tree; "LIFO" about 25.

LIFO it is.

> 
> > + * As drivers make up the majority of the kernel code base lets describe
> > + * the Theory of Operation, Coding Style implications, and motivation
> > + * for using these helpers through the example of cleaning up PCI
> > + * drivers with DEFINE_FREE() and DEFINE_GUARD(), e.g.:
> 
> Maybe:
> 
>   As drivers make up the majority of the kernel code base, here is an
>   example of using these helpers to clean up PCI drivers with
>   DEFINE_FREE() and DEFINE_GUARD, e.g.,:
> 
> Or just s/lets/let's/, although to my ear "let's" is a suggestion and
> doesn't sound quite right in documentation.

Ok will just simplify to the following which also removes the need to
talk about the statistical motivations that you mention are awkward to
land in static documentation:

    As drivers make up the majority of the kernel code base, here is an
    example of using these helpers to clean up PCI drivers. The target of
    the cleanups are occasions where a goto is used to to unwind a device
    reference with pci_dev_put() or unlock the device with pci_dev_unlock().

> 
> > + * .. code-block:: c
> > + *
> > + *	DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
> > + *	DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
> 
> I think DEFINE_FREE() and DEFINE_GUARD() are separable concepts, so
> possibly move DEFINE_GUARD to that discussion.

Ok, will make it a pci_dev_put() section and pci_dev_unlock() section.

> > + * The DEFINE_FREE(pci_dev_put, ...) definition allows for declaring
> > + * variables like this:
> > + *
> > + * .. code-block:: c
> > + *
> > + *	struct pci_dev *dev __free(pci_dev_put) =
> > + *		pci_get_slot(parent, PCI_DEVFN(0, 0));
> > + *
> > + * The above will automatically call pci_dev_put() if @pdev is non-NULL
> > + * when @pdev goes out of scope (automatic variable scope). If a
> > + * function wants to invoke pci_dev_put() on error, but return @pdev
> > + * (i.e. without freeing it) on success, it can do:
> > + *
> > + * .. code-block:: c
> > + *
> > + *	return no_free_ptr(pdev);
> > + *
> > + * ...or:
> > + *
> > + * .. code-block:: c
> > + *
> > + *	return_ptr(pdev);
> > + *
> > + * Note that unwind order is dictated by declaration order.
> 
> Not only dictated, but it's strictly first-declared, last-unwound;
> i.e., unwind order is the reverse of the declaration order, right?

Yes, perhaps I will just quote the gcc documentation here:

"When multiple variables in the same scope have cleanup attributes, at
exit from the scope their associated cleanup functions are run in
reverse order of definition (last defined, first cleanup)."

> 
> > + * That
> > + * contraindicates a pattern like the following:
> > + *
> > + * .. code-block:: c
> > + *
> > + *	int num, ret = 0;
> > + *	struct pci_dev *bridge = ctrl->pcie->port;
> > + *	struct pci_bus *parent = bridge->subordinate;
> > + *	struct pci_dev *dev __free(pci_dev_put) = NULL;
> > + *
> > + *	pci_lock_rescan_remove();
> > + *
> > + *	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
> 
> As-is, I don't see the problem with this ordering.  I also don't see
> why num, ret, bridge, and parent are relevant.  I think maybe this
> just needs to be fleshed out a little more with a second cleanup to
> fully illustrate the problem.

Hmm, ok. I think this wants an explicit example of the trouble that can
happen when grouping variable definition at the start of a routine for
legacy code-prettiness concerns like x-mas tree declaration style rather
than observing that definition order has functional meaning.

> > + * In this case @dev is declared in x-mas tree style in a preamble
> > + * declaration block. That is problematic because it destroys the
> > + * compiler's ability to infer proper unwind order. If other cleanup
> > + * helpers appeared in such a function that depended on @dev being live
> > + * to complete their unwind then using the "struct obj_type *obj
> > + * __free(...) = NULL" style is an anti-pattern that potentially causes
> > + * a use-after-free bug. Instead, the expectation is this conversion:
> 
> I don't think "xmas-tree style" is relevant to the argument here.  The
> point is ordering with respect to other cleanup helpers.  I think it
> would be good to include another such helper directly in the example.

Will do.

> > + * .. code-block:: c
> > + *
> > + *	int num, ret = 0;
> > + *	struct pci_dev *bridge = ctrl->pcie->port;
> > + *	struct pci_bus *parent = bridge->subordinate;
> > + *
> > + *	pci_lock_rescan_remove();
> > + *
> > + *	struct pci_dev *dev __free(pci_dev_put) =
> > + *		pci_get_slot(parent, PCI_DEVFN(0, 0));
> > + *
> > + * ...which implies that declaring variables in mid-function scope is
> > + * not only allowed, but expected.
> 
> A declaration mid-function may be required in some cases, but it's not
> required here.  I'm not sure if adding an example to include a case
> where it is required would be useful or overkill.

So I was reacting to sentiment like this:

https://lore.kernel.org/netdev/6266c75a-c02a-431f-a4f2-43b51586ffb4@intel.com/

...where concern about cosmetics underestimate or misunderstand the
collision with functional behavior.

> > + * The motivation for deploying DEFINE_FREE(pci_dev_put, ...) is that at
> > + * the time of writing of this documentation there are ~590 instances of
> > + * pci_dev_put(), ~70 of them with 10 lines of a goto implying that a
> > + * significant number of gotos might be cleaned up for incremental
> > + * maintenance burden relief.
> 
> Good motivation for a commit log, but maybe a bit TMI for long-lived
> documentation.

Reduced it to the mention that "goto removal" is a virtue of these
helpers.

