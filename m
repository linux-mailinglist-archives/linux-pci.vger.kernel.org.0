Return-Path: <linux-pci+bounces-5016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D088739B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 20:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A70C1C22191
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318C9779F1;
	Fri, 22 Mar 2024 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfNlI3DV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE776EE1;
	Fri, 22 Mar 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134649; cv=fail; b=cAwb+qQ3UCKCqgvmH/CbtDkCjlG2r2mp2enEU9ZOhNbcZnm9AyXd46oHrjvA89r3Uxki6kWpUMSmbhAYDAbKYlyLnuJHy0FUcBweewnK5D8gc+VXKE840KSvFxsXuwp/YknNf3fG70rIz04Zuvna0NdHg1udKcOS/1XRWLFW1r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134649; c=relaxed/simple;
	bh=fvTa53pShSmhnpkIqY6kBUPQje5o6DbfsRAQofeHhS0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mUZBJM2gJ/1+MF+qrn1KkBg3KkhWAlZV+uCDRcK9g/EbpGVk0lcZIEBfj28wroZis06iPWzI+fysAyuLlffsm5FDh8ZC5qU07BChVqO8Tu7x2LQ2ftwsMM04cxEwwh8V0a69GuOOcCn7Md9r2l3B4hSowc8UWilWTeZ9jdKFJdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfNlI3DV; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711134647; x=1742670647;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fvTa53pShSmhnpkIqY6kBUPQje5o6DbfsRAQofeHhS0=;
  b=DfNlI3DVuaP14aBf1IZjUjHudBT3or6lesDadYTf5ZSenw4fC9SLD5ZJ
   Lz0O90LUroe318nKVHLiPAX+rgkmkULo0t0mDTnUR400QyjH12gFVUspl
   UZQlSYi7hvVveVrMzA6uqetLS71JP05XYrcPUAo2O4uRHgsBRX9ppjFHA
   Y7VzFh81rndE2d05Nhj7hzZ9oXfF2wyvltIXy+dhyBu8MGwLQ/iQyn2TE
   qe8nh0JeTXaN8LzhbMXyChEgM6aYOkrKTUTUyl+3+Pmsx2aq6uPHxaShA
   M7PicX719pVudRLz010dAy2diEErDZyh3gqHvb/RYG8iR94aSgIHDjnoc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28676487"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="28676487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 12:10:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="14985436"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 12:10:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 12:10:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 12:10:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 12:10:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 12:10:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwKgWjajEJ3yUXCQkwGeAYm8W9x7sRfBWqpfF3p9qbd1f3nxVTMeJ9XBJQEU7qCThE1klF6hVC0JH2b2LKnxQLPYZFv+h/Afw0G7DCeSYPQIIQ18orZAMijneq1fK5oSzg9EbJl4Ok/GBaxr5ruMj+4kU8mn7mYGQsmh69LqqIGGPJl9OVAoYrJixFVIzz+wmaH0N1RzR9N29hk+tVNk0+NgX4Sbf+v/d3bRMQgbTTa7rvhH42AtyPlgWAi1Qgn/CAAFasyD0Vs7qkLnWVhs8MME8CING4SCvQMCOY89uI/RxV3krTVWl1LeyFhsMGzRHgtvg1z/QWoUzXZhpnIblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NImZtB3H1MElTLs6szKVIT+kDojidHPCGJbZL9gUB50=;
 b=DDSzexFMHP9pWxtDsjSVch0G/MrSSaCbfETarJeb3AdnWFg5faix05Ib6qalp9OUtBoTKjGkDRr3hWhSYfgJuh6Ioyyrf++UL0DbVwJyt2Li9oF16Gp9UIRnsEZ0fxw7ic1Md74lBwJZcEvuviii0ZH/k61E1eu/ozQEzgnNfFeFf8MKCt/9n5SFSYtCR2dIa2vrcCVmPsNgJg5ol+ga9vDXJI+KAJlHv9EYD0znvRXfar4P2aLx7jylG5MYrSULsC/xd8fjFIHs9dLhVNHqCYk8zrw9ItDAMAqW5WardGaom2mBhZud/521tDFzl9EAcB1zawwDUNewjrkobqhINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Fri, 22 Mar
 2024 19:10:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 19:10:41 +0000
Date: Fri, 22 Mar 2024 12:10:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <torvalds@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Ilpo
 =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Lukas Wunner
	<lukas.wunner@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] cleanup: Add usage and style documentation
Message-ID: <65fdd7ae82934_4a98a29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <20240322090630.GA40102@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240322090630.GA40102@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 918a4db6-027a-44b1-dad2-08dc4aa3c42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LR7Hwmq9YXliEn1vHHsymFCr3YnPDIdfcwNoyt5z/ZoQvJ6JrSkzDi3/NfT3kxunUDevClFZUy5hzoyXn7XCdYYPECumz4h4DexyTyWBHcDslH5a5SgzPaQsiNS6ikH/CqB3Q9/d/MtvQtTv5kUHK+0Le2x6SenGVvZGY7UU9UFXWjSRInxJBQy4pyL6moZDcmWVzJMlr7OoA4LoL8D14Qm9kmwIsf8EHSnKo3mqwQ4ZNerjlwfVajK5ivKxsv0aBvIcNO14urntbmJ2BPZwFzPX5Hr21Yn41xFjwAE5ZNHhvMfd9NDZXjncB85tfx7kDUA30f6+sY5nJnHfL6czujBVJFKiSJV1Y2eplDWJySRdkb+qEPFGERynsXaAfglf4heaZVrqrOidfeFjciYrFWekNzZ3HS/CWplhPOJzlBpsST0QNSVO7EmoqkzxX+Sz2chy38VtwlJkwL8LA0qpcb00nMlwvJxGQlPVcqOyOyK4wpfK+bCbTjpVg8pOFU1L0MfLjKdqQGDwUJe1wa5cskIgz5IDyLhOkZvo8wUr2Zv858uBHBswcm76OZ3kpRa6+2hWzpi7NtC7fgnssm88RSyuqQ7wvib74UO4ScyJPkUlitKry4JnMMjggpv2nnALMb2tv6B9grFiz71+u8+jFMGtKcmRK6Lkocg5rL1hWHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RIWC4LgefcY/dI/JwvYqZ5SuC0FQoxuLBjakrduQp5TnniPYPR7XsQmtIF28?=
 =?us-ascii?Q?CwdGYUCt1FXffuNQxE57mXKawgiNIpCCRqxf6eyFl515yAPZdDagE/txNFb6?=
 =?us-ascii?Q?crei75uqB+PBeB8fDK1gAe1VNA4sV5VJfBOPs3uTalYxgKuS0tAE3bYxHdXs?=
 =?us-ascii?Q?NrOigkcULORAnhxIsJIGw57tW9+C1/5UeXt8ZvLb62YyyJ3MNA8tM34pC6mT?=
 =?us-ascii?Q?l017ZtUWGEht20WlGLdu8LSiEtUk9K02hm4Iq3Njzt95ffJkdo/1XIQlOYFq?=
 =?us-ascii?Q?CuVdwgfZze17sot+OnzO8fWeBDsdLC4+qMXgQz6XJRxpKvJSAKztwoCdoLPA?=
 =?us-ascii?Q?PnOwNTRrEOudk7RyzJoTXhBUVp+8SkcZmzVDq9Hsv2sjLrGUFW23ZlepnKzl?=
 =?us-ascii?Q?eAP8zkrsJ2rqnPTMWh26BiimBhnSFVkj6cNGPVlINdoqVuVYIrSnFu0RtW89?=
 =?us-ascii?Q?vLbFrBeILGhBdLjx5U6hjqfqeaF9edv6QrrWWm6gXwoJmYF4GLOUMGA01ieG?=
 =?us-ascii?Q?FGLPxxxBX3idZDPIgbj1kgiWAemyF35Mq4uIXQ7+0wHLfCXeUYa+FpSS66HP?=
 =?us-ascii?Q?GpUFSKrZHATOHZrz/saLXoF1zg0exzo748I61jkRXc+8/fiKxFIf7j2q1mj0?=
 =?us-ascii?Q?wEDKmY2EBlBqCb0jaIZRBTZ7GjCCJDxRgxG+4a/+fAMB7q3QzM5RPoek3xmi?=
 =?us-ascii?Q?a9bYCyqskphimJbRxYBKqhSFB4a5WifEyCRf/B79hL4l7jhcc+vckmFbXNga?=
 =?us-ascii?Q?QQ5FdGN5ojg4O9kqa/HvS3p9fRv86k+9LFv9KM01jxopQuDxcmvO5GSnWNUP?=
 =?us-ascii?Q?Tvh1ej0OfGunzuiYOoi/RqJVtxfYWjwqaX7zL1EYUh2G6NJV/xQV4x13495e?=
 =?us-ascii?Q?K8KHr2rYh13hMibcNll+9+HIJayfQ6SYVrOQ6Ewe6mLHqQxabYiECBIW4SdQ?=
 =?us-ascii?Q?EwZGRlf5FFyh6or2YioxKBHw79emnBBXhqtU+/31WkW6IGwIh4TirPv4aoek?=
 =?us-ascii?Q?oa7qGq8FN7IxwuDDJCvRvDZD1qul2kMY+00KDxxTXw1+ENSbaZJxrXH24p6o?=
 =?us-ascii?Q?+E25IhEmMWLp9iTE8mCwpL8bWX71dtLJOBZiWLN8NcWaXk/Bk3OD/N1yxYcV?=
 =?us-ascii?Q?WE7aL2njJ2CzmYdssPUfQ32kMZlV/Dw92Ygk3zCTHDolVfVIKTxPIOlfzm8v?=
 =?us-ascii?Q?zLN5LiUCj7XXJRdBtw9JyXl6X5FxfPnuo1Qb0lA/JifCTggv/ksGfq1o6v7N?=
 =?us-ascii?Q?dNgZh3Ix1FAzpjbyG7GgApjhftBm9X0jegVELLAGrE9PZwTsSSVt/LfNUhJY?=
 =?us-ascii?Q?ZJiBxxCle6Wi0GmuzzcWQF9dNTFqElxyMcEQ90yaH2AsxM4o2kMjshfPqqDk?=
 =?us-ascii?Q?sWkr9kyEyqCMHNE8X2EPmMVhHntUYuP6ZR/AGsuF4ryQlqJZ6y2cmNOz/ZAb?=
 =?us-ascii?Q?yILrAMZw6zjB99voiA1qkx7CFpQ32OlOD3EAgSdAvrv7vcrzCNYNLgy07Hvo?=
 =?us-ascii?Q?5eAnBjeY0XHGOi7Ej0VJg6nyn9DraCMVSAP4a5YbDLOkTIBk+PxSEZrydNiA?=
 =?us-ascii?Q?vulJo+e049ypKXZvCsscMLFGTM3vcTYpK04aEpgVnhflqRNzHdB9knkdKkIX?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 918a4db6-027a-44b1-dad2-08dc4aa3c42a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 19:10:41.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFtJ2zf7PsFsrn5J0XN75koC5VupBLfDyAk5iCVKmjIzw6a1YfQ5NppWtTik0iTlDrbMyeXuSBkZ+0dO7E8H4o47bYuKtYVvryX1iLYwEaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
> On Wed, Mar 20, 2024 at 03:04:41PM -0700, Dan Williams wrote:
> 
> > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > index c2d09bc4f976..4620a475faee 100644
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -4,6 +4,118 @@
> >  
> >  #include <linux/compiler.h>
> >  
> > +/**
> > + * DOC: scope-based cleanup helpers
> > + *
> > + * The "goto error" pattern is notorious for introducing subtle resource
> > + * leaks. It is tedious and error prone to add new resource acquisition
> > + * constraints into code paths that already have several unwind
> > + * conditions. The "cleanup" helpers enable the compiler to help with
> > + * this tedium and can aid in maintaining FILO (first in last out)
> > + * unwind ordering to avoid unintentional leaks.
> > + *
> > + * As drivers make up the majority of the kernel code base lets describe
> > + * the Theory of Operation, Coding Style implications, and motivation
> > + * for using these helpers through the example of cleaning up PCI
> > + * drivers with DEFINE_FREE() and DEFINE_GUARD(), e.g.:
> > + *
> > + * .. code-block:: c
> > + *
> 
> So I despise all that RST stuff. It makes what should be trivially
> readable text into a trainwreck. We're coders, we use text editors to
> read comments.

Ok, I will rip out the RST stuff and just make this a standalone comment.

