Return-Path: <linux-pci+bounces-5629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497A897536
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 18:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E519B1F2B250
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6513714F9EB;
	Wed,  3 Apr 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEdnSZiP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7814A0A2;
	Wed,  3 Apr 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161659; cv=fail; b=rTIgEDX5RURfDJp42Yd6CWZxogCMfWYW86FRnvdQuKQE2Ej+3lzTvl1pZK+VyTJJpbTm5hAua3pAAZ02JtSF058805Nca7gSJ2qelYVBRymCvC4GrnwvSTXJmvtfRBHBv8VC2+qO7N+uRRmn8tUtg7SlVqcIpIcp+vgDEpv6pLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161659; c=relaxed/simple;
	bh=yejQ62EwgOOtIYboZvGcg7LVTaFwyOig929URyXaHQU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lNiAmhKcsgVzOJPLjVuZtT4+quFoxXhOuSeM+fqk7uuMYloTUva4IZmDMpds9gMM9fOM3XOhuTwSG3SySGB73SX3DESMppwv5iqLk9VnTbpm82SXNjiV5FhzOb76S+qSVOAgUiC/s9v4L4xq/xNLlEcoiEBxvjuIxeIB+y0DhDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEdnSZiP; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712161657; x=1743697657;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yejQ62EwgOOtIYboZvGcg7LVTaFwyOig929URyXaHQU=;
  b=gEdnSZiPssDxEtVXx6rm7bCpDZC0ngW79P6VIBq5FbIYd7ojqwjA0Ikc
   xu3NgTNousfZy5qkQgEOz5Y5dhinfHUh59KudGmKAQ637dK5knsrkRF7O
   cKT+NyHkbEf4mS2uqYe127fV89Ms03B+Bj/qVc7SnZvRg1BNFRaHscyQp
   uNONjhtmV2Y2PUXFNU9k4g4QjYhq5wVKsytt088ti1U8sXLdi07nRytAw
   pgNa8rqMYWyEiWFwgKqwh2N4kP9y/ON76kWib9ABHtXZmNhz6dU8MZysi
   WDIoB43pWtwjUBRfEFtz9NI2RnF0Nv+FeRM+aF9Cemaf3o7Y9VMfF1Mop
   w==;
X-CSE-ConnectionGUID: zQg9MQSHSTak1l4Rwve9gg==
X-CSE-MsgGUID: MVQpA0VcRXOJpiGvYNoWOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7639772"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7639772"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 09:27:36 -0700
X-CSE-ConnectionGUID: 6GFYJ4zaSKyPrQ+OYflzJg==
X-CSE-MsgGUID: 66hW9ednQA+SGoPTQvqfmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="22958929"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 09:27:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 09:27:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 09:27:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 09:27:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 09:27:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfxXWKGEZfGpGRK41wLPiX9T7VgreJof49VXHMD9z9yaUtE4UAagI21w7iG75Fko837b7v7XZxpkIn0KDCx4GqdFmfcRtNqjP+taLDTLyFr0KhlMILK073pf8xOUscD+KaXAVQE3q1xeNlZjHaNDlQBB+HfejYqCO8KjHk44BhqxdkC+2+Y71VYpBmrh9Vz6BOs6qe8nDcjD+vJOtnFK+MQitF/nVKScJ7cqeFIuc+DonJd0Es2tSW0ZbVE4SDp0gGOZLaIxLa78zSEkPHqqUFdCDxkxLh5RJmmhFY2zWST6BHC1VwK3h7G2oknHbhTZFbbhSHDzw8yaSLyEn1DMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpMeF2sDWZhaPu5WDgF34MxCMNV9gAaP7l3A9ZPhD1U=;
 b=n3B0cYoLvo+HIg//4B9TzXqpWcfh4fZbwh9+80lw2k4ytoGIeJkcQvTnlfML51VxEcgTz3Xfs/sEYuCYLpK07Mmw73ThVDECgSMSc7yM1LQAjbz8jNsTFeda4fqVCt4vA0Eks1DDW+iLHPCT8fGZrq/Hm8eRp+eBfZ7EbLBkKOIG2CYPStlmqAyUx5oDj9mb5wPipPH/UCSCMXZYaAlb9WThLnQaXzOsvz8ZyFkrhjd7rICn36/YuaapOLnlTlogateCGsD3BZHS4m5ZV23Np7WxGD7/uqs38jKzohHXMrKVtUmOUjigsl8ea9q2/vjspf6ELfvdcc5iYiISsrpjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6974.namprd11.prod.outlook.com (2603:10b6:510:225::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 3 Apr
 2024 16:27:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Wed, 3 Apr 2024
 16:27:32 +0000
Date: Wed, 3 Apr 2024 09:27:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <bhelgaas@google.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 4/4] cxl: Add post reset warning if reset is detected
 as Secondary Bus Reset (SBR)
Message-ID: <660d83708993_2459629416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
 <20240402234848.3287160-5-dave.jiang@intel.com>
 <20240403163257.000060e1@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240403163257.000060e1@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0294.namprd04.prod.outlook.com
 (2603:10b6:303:89::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6974:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/qnc3bbp1Tjd7jqO76t7NgzEOaC61B6ZoAZk8rgQb5YDs8bH/2Cv2ZGC5XUjfO8k6wnGKy3dbA/F2dZtl/+yFbZfqTxsHNbyG0F3tLXxTmm2q/H/ikCmwfT79fuyNFSal9zQaRK6pa6MP+CGmWw0++5kXM/9rbEj0Ddy2V30cN/Q1ki39CjBzFLxECQTTJdXQla3F0Ad1QpM0L57ysR5PMDDgw/C/sVHi36lRzsxp7XqiAOntHZTSo92rnkVNQcpToJw032aGe1qcrXV2UMoaibRSp0VkzWrfc4RBXpJp5gcxfXW+tANOWSke5jiHheXhV5IL00GsFAp06kAA5cDhe8GQUWoyB/hwnO/c53oR6wBtO737GxB/5Z8uV+BAa1OLZ23NG0+fa6pyTaPcae4w/SrT1mxzlYcFd4HMtnnWG9iU4Ws+bH4QpiPBBGsIqo28ch1xEmtR9M56fxvlCdv6tNINo9nXmUv6JqnbXxhJT0vppkXDV8+hRksEhbgEzv1LMXv5FIV1q0UYKG2tDkOVAY4CQy+5JcDEIT7Z79DrEygKpiZKYSeL7xdKqvlBFe8IuX0lIAIklf9HZCYOgaH3pn41xbr3A5z0NcX/fzb7yJKI6y91HX/4+BTxmeLxon726cM49PJYzazOe2CYIpL9qc6Y/hCXtJGuxjycvx3uI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0GIxh2KYljXq3vantS/uLYGt29+VA9OH/VN/taoG8FGyo/ceIW06oLpxrtPF?=
 =?us-ascii?Q?+FjMfHA6fg28ZY0l2MSJJ9P0YN4TtbM6893/TTRLHFUlQeI4d4c9Vjba2zk9?=
 =?us-ascii?Q?ApuUVB2WA2nEBE/fi9dhXl7/rV4TK7t9I3/cJVCDwzqGCdpkxSFwNkQ/gXP1?=
 =?us-ascii?Q?drIYvRS5b0nDTUgIX3mGYYYsF5Y9iumcM3nBe2qhqsvAUsJUSLSJfqMVu3L2?=
 =?us-ascii?Q?vz73SoEhqE1MLPXvGWkMBXmixss709ioT7n2oL2sYNXHO08mlBSypH71MVGx?=
 =?us-ascii?Q?3eisWIm/HO/pFnMoN2fAAnlNVgPAeGhw7mQa8VFOaZTWlL8wjaYcAKIjqF8G?=
 =?us-ascii?Q?wBwWpNLtVlyT21KUpKRPCPHKKlb342yOo3DFOwqp9OwVCymWmNwMtmmtDn2L?=
 =?us-ascii?Q?HOyFYn7pvdfMzKpzJmxOsKQR38Oio/wKm0Jk3+LBOVG9IDsf6YJK2GKzcNDh?=
 =?us-ascii?Q?kYSmtiEV1bX9UBB+QdAFXWpbtop/bwUaBmvExGmbvr4FqldNhytKBLgxEFnz?=
 =?us-ascii?Q?KxHkNZJ13q+3OZn0Lpv2n1iytfOouYXIrdqv7Hy0QJJdDXcbGfcVrqiPFIB9?=
 =?us-ascii?Q?2nnVE28gmeJgMOxuWVYQ32DrEOz6Aq0J1/p7046ES/IH6cJr+E2HpGcJbwZ2?=
 =?us-ascii?Q?WVLQsewMJ9lsEghxf5R47ub6ainIh/WTa4p0MITZwXh/c3Hie8gpcoGh6Ab2?=
 =?us-ascii?Q?T2RqzyilNmerYdxf7dmtLjnlGFN7OsY0qvFxFuVsUzfB1XeAVFZv2Up4tL5f?=
 =?us-ascii?Q?wCfobLin74WfGokH94uM6E4aThySSMIp58SjKR28HTOCmm/Lt37EUlfrgFH/?=
 =?us-ascii?Q?faDICov8o5Ym0ZrimFrkZlCCCCpAtmUAmAWnRmZRp8VJVA+JsKIwdaBxOC1U?=
 =?us-ascii?Q?r9QeYaW49/GSrpkpAaERpzjHjHQ2iCxMMdGLIco3QYRIRHDXFSejh+LzWT1B?=
 =?us-ascii?Q?lsijaaxbuwFbW07gzueSsrrMJMhUp0qwBrPC+h0awJBYOXbDclIlYAvgM0bb?=
 =?us-ascii?Q?vaJUmIVD2T+EDAzGvUGQS8Pam0+oXw+hdDjNNkhzOtW14FdRvvhgWXHlha/5?=
 =?us-ascii?Q?DLY/clua9hqeKWf70f38tUgR8KETI6TbYaPu8oppR7hVs5K6MiqcVuOsVUOZ?=
 =?us-ascii?Q?lRYng5eHCscknqPkTL2qPot6JK29EcaZQRh19dqkrn/MnOy77a7Vxb2c5hnk?=
 =?us-ascii?Q?ip3ejn5D4cftT6MuHGKS5aOFuYQTOk28yMoBvk0RhDIKZuWzP5KA16D5ikL7?=
 =?us-ascii?Q?o/f4jWmVhDAJ5gH5bWJsI7Os53y6MSzDTZbwVTvnzqm6g4nbpvr3Cy9QuR+h?=
 =?us-ascii?Q?9sWQh4IAGS/CgeqIa0H2Cdh+TE4aTxINR2QWvwFwCrAskS+hdzIr5d08GtjQ?=
 =?us-ascii?Q?FEF24eEQs9LYOVbJBgrMjD7aIEnEPLeX3U5/CYjhVeqIF/nhwhju3uBrAZeE?=
 =?us-ascii?Q?asKMIyF8ISsZxyl2f/whi6+SLrLmX06i1C2prqPcdRKV4u4da1v1qmHDbv+F?=
 =?us-ascii?Q?MudLb0r+CZR4lXP3xb14yzXyc1885a7BkGlc38tDeUT7anSFpb9gED6LA3sD?=
 =?us-ascii?Q?ttP4KkXGi7uY2B/9sO1+NhQk8Dywv3q/5Xs5O04GCr+QXMGK/vwP/ZCGn/1U?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae670d3-1268-46e8-659e-08dc53faf654
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 16:27:32.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ir5W6ded5iHANFT3jxPnXFy9URfZjJDEHiqf+SDASazXIxPaX7XIhjR0FM/4iJ3m0yT3EY8hrqpYFrpgXtTSKlJnlCGFF86cfL70DvnnPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6974
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 2 Apr 2024 16:45:32 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > SBR is equivalent to a device been hot removed and inserted again. Doing a
> > SBR on a CXL type 3 device is problematic if the exported device memory is
> > part of system memory that cannot be offlined. The event is equivalent to
> > violently ripping out that range of memory from the kernel. While the
> > hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> > register and the kernel currently does not unmask it, user can unmask
> > this bit via setpci or similar tool.
> > 
> > The driver does not have a way to detect whether a reset coming from the
> > PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> > detect is to note if a decoder is marked as enabled in software but the
> > decoder control register indicates it's not committed.
> > 
> > A helper function is added to find discrepancy between the decoder
> > software state versus the hardware register state.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> As I said way back on v1, this smells hacky.
> 
> Why not pass the info on what reset was done down from the PCI core?
> I see Bjorn commented it would be *possible* to do it in the PCI core
> but raised other concerns that needed addressing first (I think you've
> dealt with thosenow).  Doesn't look that hard to me (I've not coded it
> up yet though).
> 
> The core code knows how far it got down the list reset_methods before
> it succeeded in resetting.  So...
> 
> Modify __pci_reset_function_locked() to return the index of the reset
> method that succeeded. Then pass that to pci_dev_restore().
> Finally push it into a reset_done2() that takes that as an extra
> parameter and the driver can see if it is FLR or SBR.
> The extended reset_done is to avoid modifying lots of drivers.
> However a quick grep suggests it's not that heavily used (15ish?)
> so maybe just add the parameter.
> 
> There are a few other paths, but non look that problematic at
> first glance...
> 
> So Bjorn, now the rest of this is hopefully close to what you'll be
> happey with, which way do you prefer?

I will defer to Bjorn, but I am not fan of this reset_done2() proposal.
"Revalidate after reset" is a common driver pattern and all that
plumbing the effective-reset-type does is make cxl_reset_done() more
precise for no discernible value.

