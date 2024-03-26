Return-Path: <linux-pci+bounces-5197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61A88CB62
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 18:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC73C1F6694D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781BF1D559;
	Tue, 26 Mar 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzCJM6fa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EF1B59A;
	Tue, 26 Mar 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475671; cv=fail; b=svvOR2Qg1po0iHqO6g5bnpITTg0FOLrzeKHoSYfz83QCTptuELadWpFfmu4v3buQyAFR7Vb/Q1V6pnYB4xLsP+RTf/3BISlC9f+HXuoCgfjvz4ljGHZW16Vii3bjioX/t6nNA/NN2yjkDSJ0NivgWyGvNEEtF/4TNUc+eN5in8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475671; c=relaxed/simple;
	bh=U2WZ19lMs2aOwKPT3kIwO4rKHOraJmU63AQhM7cmPcQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sv6V3qzU5+aPxaHTRF1zreHZ6Zok9OxWcvObsntg6dN8rOXar/o1v+iUHnIzNwXv3ZD/R54jnrM7TXU8Kfsj3BbBNmgxmI3H70eNh0EtIaWCD4K7q9Ya2CScCK6TzUH2shgSF7bxKW8ZRLWz4SCKN3O63PePTOLgAzVtZy2Wkd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzCJM6fa; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711475670; x=1743011670;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U2WZ19lMs2aOwKPT3kIwO4rKHOraJmU63AQhM7cmPcQ=;
  b=mzCJM6fa6YpI/wEG1DdzDLuO5pXr+LpFay8ey4Kmx6SkkwoFIym0gKlU
   tlAOxcYswvfhUKHeicXQ4dN53XaFu7cWCuyYEIyjtGf81GAm4f+pZy0zO
   K9QoCvsQYz2M8V9D+seJiTccbxEtNSMwqJutswyd5DtuZAVtUR96rtTtk
   VUV2q+MN8HoCE9fW2Nwwhw6GENv9Nz/tnHmo3cTMx13Sq4YnRdMv9ddd6
   d6Q6y35NabP60GiUjxgqCAkqbZzViUbT6mgU+1a2hhtmeYSh94T85/RfH
   Lwa2wZitDuB/6IhmE0MjKrJBHJ9pNOULyVy4u76tf0Q7Q/evELuCXasbV
   w==;
X-CSE-ConnectionGUID: 84rRccnRSziZum1Ddz0MKg==
X-CSE-MsgGUID: Ch31hBOTQDikztKHgV4GtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6677708"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6677708"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:54:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16684726"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 10:54:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 10:54:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 10:54:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 10:54:21 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 10:53:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoWA4vKy02MPukHI7/wznhY7Yiq/HIBopdrHshqqsvov+rzvXFBqivNlb6Oiyqdz4xeSriQ1fn4itm+hdjJGHjiWQUN5uO6Z78BRtoUpgyOdPW0/fKt4YyhduDAaOA93lMOk5X9FhkkS8ZHNWxmyaQO8VgfZe2k+PRytjgj3BT9DXMX4BWMvIO2faEkESzBa88oVTRYNCE0hINURKKdTayLRGqiduUitKeoRlIcdxRW+SpDm8Va2VlcK8kDOTtTmbzdG2+MK8es9KA79CPO3aMoevtCzWCQii+nv5Du+NM6Y6DYAdNLYJdJZZKUY8udaTj/SPQSrGbpCgdfQpF6gJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKscYpnPJTIlENItGV9iOVbsLiN2AvrDoawRg9l2bgs=;
 b=GvvgzAeqb6A7RRN+XO5hQ+m1Hg4GoRuz7zQpE8fqFUw6+KtcpKzZTXagOIoNdXAvgnuDtwRHJbHqAewvGSO8KD2tJ4W5xg2AYmtP87tfeTD9k2ySfLJz1Bq0s8pKYllCq8n6EDthMrXeIZiBRGkfE2RWqSa2x6SrvcMdKDgbUzCRGIAl3IEoaKREM51rnhcSsjOjHcqMJmHM/EOLuFJc1bnmUJ7DTh0QMbJnNouUxHy4RDK/0e3GZM06USL7MeIzdGPwelabebEFa7datv2uL7pUJttODfugCsrIdVgfr6jPh+y5a75hf/H50S/8wpbHqiggY77IUJAsaE9NIYFuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7992.namprd11.prod.outlook.com (2603:10b6:510:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 17:53:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 17:53:49 +0000
Date: Tue, 26 Mar 2024 10:53:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <peterz@infradead.org>,
	<torvalds@linux-foundation.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] cleanup: Add usage and style documentation
Message-ID: <66030ba9d82d6_4a98a2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7992:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7JxhUXHAk+/euAXL0OAZvc1tjdu37byPbxMJF/m6uCVQ+C3SLmcF/VYpFrrSjkobNMxUGLtQ3OJMDmvnU0BcmsvXzHoAR0iafV3PFoGBXiURV5CmmMadSxxqx/sC7ZzmVLtVft5XSgyjqT2EZhCNSttAvzgHYORYExIY6pHNH3S4vy273sjvz4Dy5HQ02OROTdL89IlFVhGNjImWdibdHr+uGu8afdAobg/TuoGsW+QyDAg91Exu85HjPqJ6jMSFqZxpB4HNBd0gP3iLy3dnAE7ZtT+R5nq2f5r7/r5pyqS6QhO/D4XnXtFhQJ6cQJ5DWlezju/eWxyaqtkyB4XSj7ozNU5bbserYopJjsJMI8y777yqBXjzNR+KnSaS0xONECSr31Ig9KoT/V03H7KBPRLUDcBskFx+vqRLwcXaqH+3rkpyrNYYz6unIeKNASKJktmfgpPswNMuIWyYtW5Xk86ctV+/2v/8jMvx5quNquIa1tdI4TtudqodTIt45YoaKibSFWgI/KzKCrLZyOgqqocqfhWbHPlPwGAXdZh4JAC91/AK45H8iN2PIdpdCa0Kgeoc2VGDYlHpZUz6HwI9YchH2kclh9LfcTYNs7AIY2kqHT1CvK9HD0WEneF2AAzIQweNSflccqH0wEB7XWlLlvi2i4Ec+vD9j4ee1gXgWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7EHY23VJnRPvh7sFKJypKo61TjvgsFcqHi839cIT++fnIwulkCgjgS9tSgMB?=
 =?us-ascii?Q?HQ/s5iar6mVTr22r0DgJmPLC838g9e+ZVRKwvKJ+8fQaNlOavcmwcMgGc6Dt?=
 =?us-ascii?Q?/EzstukQ8XAAW8cqSoeKvSe+Q96oCK3obX09Mdc22T3aO7Qli38JPOud0/ws?=
 =?us-ascii?Q?+h1bBpXBugh6Vr8qB0wNr1QeLf/kiEx83OdRODzAA1U4n62bBni4mOA7xosY?=
 =?us-ascii?Q?1iJmgBqXaxjUn4IO+3VPqNa5ms6nm2QL3M28SGWpYuWW7Oa+JSa42wfi4L8H?=
 =?us-ascii?Q?kmpcF0fPjqVUinfDelxDney7weh5QmYkC9HRush6NfQnicb5BgS3uYXxMjY2?=
 =?us-ascii?Q?oxlVG9tgn/gzXx7Ey/hFIM5Eq5XB3ybYHtYIysPZt6X10vRHHvvTtOQ2Zx94?=
 =?us-ascii?Q?OeVPXJiKP3DIv4C4dsu8UNpH1VEVxA8Ha7VRoiUz6OAr0EUuSUqwL5onC9gh?=
 =?us-ascii?Q?uktFZ76h9oXITE0p5XlYpGNUhtInBuRGDaLN6LUBQ221N7Usjq6DZ4CC1pLw?=
 =?us-ascii?Q?X6WO9Unayi8yeZhS4+5OdsCo8Lm9KUy/koKLdktmZTfZmGwf22aaNvLFgwr5?=
 =?us-ascii?Q?6s3I9zLZ0y8sxE1EdS/546N9nHKWX+HPdg7+YbCPfoWureobIZFzn1rANPRl?=
 =?us-ascii?Q?/wHCvd48Ud92MEGomBg/9HqYVR9mO3AZkspk39yE3Opo5qCw93EHu6HYig1U?=
 =?us-ascii?Q?XfP9pBBrmIQhOahVu7yxOUiktEkWkBAKPuhRhQd49wTuvYlc2REie+KlU2NS?=
 =?us-ascii?Q?tbBXDq3NMGDGmcYsJXqR2kYR2ximzYDQQZV/zeBJT4/AvVOxVHZbyKAM34Ed?=
 =?us-ascii?Q?ZLgHepTLJjHQLom8VW2YgzM3UYfhAzPuVKn6cvOMRwBlBHZUbr1Uixwe5hRL?=
 =?us-ascii?Q?khw5xPezOhzeyW5KAmYX2uZjdl1KxsYZezdGudt5gfQFc75pSThymXe6okDF?=
 =?us-ascii?Q?5GJuxoDIShG7nckp3XSi2rJh/bUlUj2ODV6n7AVSOKsZ/E8JrwaeJb/64oHn?=
 =?us-ascii?Q?+8ku0w4x3fI6nLw/eg/8kvXx1X1bnSOY1wQ+og/3PBHTivDEV8DW49OmbCQC?=
 =?us-ascii?Q?Q3C14heQ1RVM9UF8l2mHK/VhGK2oNXqfJgwuh6rnHFNXWHFfAR/6Z6cXFBi7?=
 =?us-ascii?Q?Ls0ByB+MavZKvyOQrCyTwxwQT7KlkUVcbqwTBRdNGqcJ7AzhnrSurIYMnQHq?=
 =?us-ascii?Q?2G/z3K8U8T2i589bd89rVjnWItkCFLted+u34z1s+UKPDidWYxGmqYQmYIy4?=
 =?us-ascii?Q?FLd/6UEzDGrlsg5i309qBm+XZRg88+RLLpmD52l0oHZGVh7QnbZFQ1PhW6Pp?=
 =?us-ascii?Q?NBGwjBP8YK0omvuhy25GwgKFVFkK6TbAAVYU1EIexGx+nosq4YWuTIlLgch1?=
 =?us-ascii?Q?O7nqqVQSzmchYyomkTmYDyUIBdt8pMrW8FCCHoEy/4S6AgrwaYAVsZaCKuqu?=
 =?us-ascii?Q?A7/a+RSQ+b7D0mGaaW73Cfb4AZTttaXMDeRIS649RtJG21wlH23l1zflW5rt?=
 =?us-ascii?Q?F8ctEsJRRE6lkOyA6ApEDVC/9xx2Zao5CJ7FMmWGCk88yQtqlcM+AMk34rSN?=
 =?us-ascii?Q?ks6HA9NalQUFnAvRt8gW0ZuWQhA9eBD0D+WvEx1w/0p1ZDb03wkeUmuvGr2/?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7076ba-8bbf-4227-1cf8-08dc4dbdb0fe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:53:49.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s34+3/CgxkOLzzYnOqZjIwzsktF/8/j00SHI/KIpWdhSnqgcyUQwuQ2bySUwCPnc8WGKB+8Il8QON4kwRqmRdzv5ixHbpdxbQwJKs2kwk3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7992
X-OriginatorOrg: intel.com

Dan Williams wrote:
[..]
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..8ef2d91c2cbf 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -4,6 +4,157 @@
>  
>  #include <linux/compiler.h>
>  
> +/**
> + * DOC: scope-based cleanup helpers
> + *
> + * The "goto error" pattern is notorious for introducing subtle resource
> + * leaks. It is tedious and error prone to add new resource acquisition
> + * constraints into code paths that already have several unwind
> + * conditions. The "cleanup" helpers enable the compiler to help with
> + * this tedium and can aid in maintaining FILO (first in last out)

Missed this FILO => LIFO conversion per Bjorn.

