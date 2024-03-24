Return-Path: <linux-pci+bounces-5038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121C4887B47
	for <lists+linux-pci@lfdr.de>; Sun, 24 Mar 2024 01:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340751C20B66
	for <lists+linux-pci@lfdr.de>; Sun, 24 Mar 2024 00:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED064A;
	Sun, 24 Mar 2024 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECrqZu9D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842963B;
	Sun, 24 Mar 2024 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711241879; cv=fail; b=rEzNZvHdA3YY/x5Ghhu0f9HToEtHkhVTdQoIFuuOD+F570p4dIrbnVm/K1H4ZQZK2SFAQ22+h0qNNBGyj5H/GwzFWDiSWw2Yr5D1jwqShja/VrtjFOc6nNJ+8D0PqD5N4MxMvtQUFSklFQ4flCUi94kgpMM5uz18D4QFGhvW5Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711241879; c=relaxed/simple;
	bh=nGBCvkan/8xW63EV2wWN1hNdvq5UCLCL2twsU6Qj4vo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PlS8ZSREx+5JBGZWbDufoV9/aLhhb/s9JemR2XWAQvJlC0UE+PXrIm1gqpVSzKVGFl8KbD8IhsCViz/T0b1qx1BHcDBn4xQe8H7UOwMp7ovVXFSxlQxeJAYeOShhyC2pdDN1y67TcKnW7YT2TXBW4GdhOcwdSC3p3ov8vXIyeNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECrqZu9D; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711241876; x=1742777876;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nGBCvkan/8xW63EV2wWN1hNdvq5UCLCL2twsU6Qj4vo=;
  b=ECrqZu9DHvCA80QfjePQQ/HswgbglmtSzZbUVrRZ/prAirRoS5e3fXsR
   Im4BjaMJxVOByX2IGLxvimzfN6Iq07vWY8bfL1yoMs4mRSnokgYp0ISff
   UDEZArjdFgm9SdaqX5PnaN61AH+q7WuuN4lDbk1c78x2EZF0d+ibyqZe2
   57vJ1CLkurATX9OGBwK4mqVdsZKThDGioPyMzGFyT8AVpqnmek+BDC2qN
   Z7EjKEnh/WxWK/cKdU30sFz1/GCANFbIMONijtm1ExaQol8I1EuW2D5V/
   B3UbVaDwSNW1FXruaU3uRzuYO+V2QBP+wrssR1LjSMyGA05iMrVlPYC2W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11022"; a="17661511"
X-IronPort-AV: E=Sophos;i="6.07,150,1708416000"; 
   d="scan'208";a="17661511"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2024 17:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,150,1708416000"; 
   d="scan'208";a="15928955"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Mar 2024 17:57:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 23 Mar 2024 17:57:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 23 Mar 2024 17:57:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 23 Mar 2024 17:57:54 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 23 Mar 2024 17:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyKDYoUpAB6ce3TyxJOQZmFFfLsJRAQIYOH7UMcglEokgh1E3VUJLChcg/vSmh7KX8DYvI+0AS0zm/hZbL9h5DiIND/md8PNScma6y8mHTP/CCSQ34Ayu7TGgqjWQqxrSC5+kf5HwXDGW1kJjNbIoZ5c/cBY1E8FEsE8ICfh+D/4O3gL7WHq0t4jU++hDia2MvtSF4Mhsyy5q1/aP7lgFteuahm2WsnU7QynTBy4riC1Ogzf9uWnxaUU7jV0wE10AOjXwrK/IJh2uEN9c72N+gUYIU26zgLiNOOgY9SlydL9VtMAF57DoUH6OZx1TyE5wFmsfvsC8+bQRH/nRlYo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3GWDz661IK5SPW429ejk1E8cxYOAT37t9T0/LJBgY8=;
 b=CPxs3zJfsxEorK+JCTs3YdeSQIsS3JOX54It6hAgj7koKIogwoIzZKX2R3TwHMSPew3pRCb93gAsIS2nSNsn0UwKc2aB6PEQN2bJ0SMDPflLPeFgTgZy01wBA3vukejAZeshf0RKl5kg2jwucDqyYX5yMKx0eS17TX8dMSqtGyzoKCDgQnQt17jJfHl7TRF/beuhpedialNXv8QtFksFEw5gRGlyQlhSirR107lJzzIX6oIZpRs6em4t6M0B5QYs8lkSaSumdst2Lj7TWc7aw44khAnbMMkiThkqu67QMthY6C0OhEH/eb/Cna/3jtRzu7YzM/8zXCloVOl4sSi4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6447.namprd11.prod.outlook.com (2603:10b6:8:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sun, 24 Mar
 2024 00:57:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 00:57:47 +0000
Date: Sat, 23 Mar 2024 17:57:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Matthew Wilcox <willy@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas.wunner@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH] cleanup: Add usage and style documentation
Message-ID: <65ff7a88e93fb_2690d29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <20240322090630.GA40102@noisy.programming.kicks-ass.net>
 <65fdd7ae82934_4a98a29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zf8_RYHW7QmCzl2-@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zf8_RYHW7QmCzl2-@casper.infradead.org>
X-ClientProxiedBy: BYAPR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: ba640d0a-5870-4119-6d41-08dc4b9d6bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObO0ZL+4bKX1YYAtY2TXmVKHphLaSL6Pa1oI5CRCwHarlsCY93kjv8GrgTjXwz1f13ngQaaCL5m94aP52dCytQjg+1LiKsyvxu1L4pYiM6ojPuu/BFmrvIpTr/I+9yMl/3mHETsLFrd92xcvjSLPJZv1s5uNEroqn6aHHnIJBQIeZl6ipThrRWkibzGTENmT1tgr9z46SYYDCQFfA9ogjHNAbSKro8m5WbWQXp+bJr2si4h6wDn6KFQhiboC71yZseVzfYaf9iYXMPWN+D1HdtSBJZNoT+hoDlQX39fe83lcrNzJi0aY2jUjJhxaZdaXQGIhEUmPvX8W1EbXFd9ly/DTeVHtWJwtsuh7PmUbDl1+654mCuNGeleKZtm9/uzHgdfJvdx3QinTJlhJ7VSj2xWgGBMJ7Wp6mdXrTI47NkhLEKsp5goiFdGEBP8P6G4WZrovnh8m9dedxtNI5r17V4UMXCSrZ192SAfX2uo++PNxd6HWD70o3mAdvazu9ErUwl338z0UvQf7EvvxgOqVsXSmsJ3Wq8c4CBDZ/PAnjb/h6FuyekSy98aJ+wQD/zhybPmr3JtUsOolT4IMoxjfee+9hyeTE3Yw0MFpHVfjCJ/pWHdVc49hNplepicbGRhWaYJmCQ6kx2eMU6U3cph4ZRezwWwyFPGDQgv2ll6d1Xw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AgefWEyseVXz2vpwu40bJvDOgNsL/F9bb6iGohG9B7eH1yROCSCkJ3IiFLz6?=
 =?us-ascii?Q?cNe27ftssJz9Yu9Kt1zNQyPVwcbp/H35ziFLfphv4eQs1DMZA2XC2J79DtAO?=
 =?us-ascii?Q?QgDk0NRyWSh6PYY3pQASYi6xw/Hpm0Tu0hAzf7tG/cEHkmdFqM1VOgXcXO0q?=
 =?us-ascii?Q?HFl+lgVLXx6Pp6x6b+PPcG4KtCNz1fRogoZvxzKiuokXKaterT1A7cGP0qpI?=
 =?us-ascii?Q?QqSx0GPhEmT9qMIAoNnATCX46uFJQ7+MbFd4T7A922bcREk5wFo74ZGIueNj?=
 =?us-ascii?Q?2JcEu4x2sCH14y8rb2fgoago5t+4D3+EtC85IbriuPILs0SeEqXZ0hN9OS0E?=
 =?us-ascii?Q?kLcq6J3yNQvJjZ3lI4HMRn9IikToO8Ju/4yYK5Rwb0L789ghridOeUDdhnqn?=
 =?us-ascii?Q?8o0z4j+TI7yuJpMSgsbiyeB0M3xfAYTFVx4jKrdaMANryUZdPb4MIjmVNd2w?=
 =?us-ascii?Q?W67itzN8wxu3lDLfWhLkKDsVzE4gFmnRsaAraowd/SU0dXbyK/kXr5+cYQ5a?=
 =?us-ascii?Q?PwidapE2FZDmGyA2NRHhcFxtX4Ya52Q4Mej8SldTClUu6QyVDzvgLYrr+v5F?=
 =?us-ascii?Q?Xh3o9hweut2bYEnsXZjQ6bbEsQctqeBdG2IoP+Ci1kaTyki/UFRNhRh0l+fm?=
 =?us-ascii?Q?LgdiL2bJhJl3eVFzMssqI0ja4r8yP1dJEVg9hUCaztYuEeMpnSX2/wylfkvF?=
 =?us-ascii?Q?lHYLqXzoYNo4YBiyeeAJ9AImYSrNQadqNEx565Y6sXbf/L8QIyeT0Zov/PYu?=
 =?us-ascii?Q?FAAqfa5O2SWNDOz7hau18QiF9ea/+VAFB0nLJD0mCP3gI7uVCYRk/ZINxEfk?=
 =?us-ascii?Q?WwXyJJ8ApIt+ZfbV5u8+Nzn8KofLkcMiEpJ3Urmzy0r3WrdmgSVq76Q+HNQh?=
 =?us-ascii?Q?s3k5Mvdxvb+W4CWlEOODlz6CeC6NCsLqF3Chtwuq9i0FguKLAOIuXXluzpU0?=
 =?us-ascii?Q?Z9kP6NhxgevMPY99MewFa2BHILOXuZSXtaMrFrV45IcdODlZNcCD9XcvNDI7?=
 =?us-ascii?Q?bSnwpqoddkh22Vvaj3ZgNI0YuxQJjrFbNZIrysv4OqCwFUUiVYLlMov3zjiq?=
 =?us-ascii?Q?sZWVxs2YHN7E86oTI49FcX5b9g6gFgh8zCsdI9FE7ek5XZPI1m2YYVXbKX6c?=
 =?us-ascii?Q?lQglJzSDkWKzZAIpyHu4TWs/6jqAOmo+guNNy8Yqs0qkXJ84IHpnZHyXu1Qj?=
 =?us-ascii?Q?iy3grPkVQi/HyZ6tPOqB+QxejJ2QUuF9tuSGxqFN2JskNrgfkBPVj3A4r74/?=
 =?us-ascii?Q?hdZvTgUUc+LtEGXHp9XB9j2ScPRLoh1RwpuyVYfL5SJIYDqM6kih2t9FG7Wy?=
 =?us-ascii?Q?RMiyG04NSjoORS9z12ceVi0f8SvmGzkUcov13UtR1WpqeOEoV1bJO7ZH9X7N?=
 =?us-ascii?Q?hyP7C9bNUHbA90kNvmEnntfjHxbzydHaRqORsPcgTCmCUbblmeTV2pN4zjGu?=
 =?us-ascii?Q?ISy03lq2AjDwir0x4VBhtjjAr1aQSQm7POMKDXXi1y4li6zXzmArwRuAqdtH?=
 =?us-ascii?Q?Uf/+r24ez+RJj1Dz5e/pUcYnK1XvnWQUeoJkQmANlwq3TLcQSQ4O1RQRcQi1?=
 =?us-ascii?Q?GmFbsF19zEKSU0W2Zi9E7EqDdW600Y7e8pEOz56dDDA0PQWuxijlA9QVyzOp?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba640d0a-5870-4119-6d41-08dc4b9d6bf8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 00:57:47.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDYwBeN3nIluDMxtustRVVLFKJDcabeS8c3OngHqWhqtyPDZasckxm/xp72NjAWReapG0ZSciOnwdPhstYeRY8D+X8C0AIKug2ZP4q1W1yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6447
X-OriginatorOrg: intel.com

Matthew Wilcox wrote:
> On Fri, Mar 22, 2024 at 12:10:38PM -0700, Dan Williams wrote:
> > Peter Zijlstra wrote:
> > > So I despise all that RST stuff. It makes what should be trivially
> > > readable text into a trainwreck. We're coders, we use text editors to
> > > read comments.
> > 
> > Ok, I will rip out the RST stuff and just make this a standalone comment.
> 
> I would rather you ignored Peter's persistent whining about RST and
> kept the formatting.

Hmm, how about split the difference and teach scripts/kernel-doc to treat
Peter's preferred markup for a C code example as a synonym, i.e.
effectively a search and replace of a line with only:

	Ex.

...with:

	.. code-block:: c

...within a kernel-doc DOC: section?

Might be easier said the done as I stare down a pile of perl. Maybe a
perl wrangler will come along and take pity on this patch.

