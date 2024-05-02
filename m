Return-Path: <linux-pci+bounces-6983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED328B937D
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 04:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DC8282B8E
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 02:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9F18054;
	Thu,  2 May 2024 02:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYAAk9bI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126017997;
	Thu,  2 May 2024 02:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618558; cv=fail; b=Vjh4P17UKn74UK7GRqH1RohPHzw9M829tr4Cmp2H4e3eaX4JrqCWH3AW3DiCrJpVzb6XG1FdEd+zbVRV2KXN9O0ccrBHaraUT+gfiBU/fanLnEb4NK+oFZ0DGxLs1JuQVVMjDFWzjfEXjwx1loM4xAKjPHZIgAusAAU67MI6cNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618558; c=relaxed/simple;
	bh=1xI6UeG2xK+6O4utE6gHT/E5RO7qpf1N/RVysKAaoBk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cCEhTv0OPFLV9a+rLU/RpTAXJ5+qzagshE9Cd//UfzdzO5Y6zWDVy0/qbnmyvMAjL+sU8hYKM57UimSou6DK+9Z+HA/S9Oyit9sk6UsbLKNf4rl1ABGAqcaoimIqiJZxoL3z6foC/Dcb/bovpie4hE0+f+un6IC9fc14cB9phEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYAAk9bI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714618556; x=1746154556;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1xI6UeG2xK+6O4utE6gHT/E5RO7qpf1N/RVysKAaoBk=;
  b=fYAAk9bIVpZ7p0cpDijGeuppvynmRNSgZRnY/Mo8QkGewM2w/P6rx5Q1
   3zwvUektei12XKEwook+24CWc/ejMto07AlmD2BB29Ss2mVEbYigjuPmq
   veaMmnT14nY6Hd44ztb2b8D0HnXiKt1OxHHC/mgLA8KRC94wvPFoi2GHR
   zxYjphdk8CXBkK6CkgrGVxfbraxgbpqOFY7EGpvrOJJM8CLEC7wQKm8ls
   TZ+xQC2Ita4s5Ko1X/iGsPXZoGtN/C7KUb+BAs75LiTi9ojMWu+C/tAG4
   ZBfAzm7SeO8SXLNtqRUz/7RikSIWPIlfN6UOikaRzD9wfH1bcyn1RJmzr
   w==;
X-CSE-ConnectionGUID: plQzZJZvT4KuaHfSESyXKw==
X-CSE-MsgGUID: CqOePumsSXuRw4oGGuhr9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10245581"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10245581"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 19:55:45 -0700
X-CSE-ConnectionGUID: WD6S3GFcSVasnvSEf3qoew==
X-CSE-MsgGUID: oKo7d3zCS+iwdLruMeFz+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27055251"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 19:55:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 19:55:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 19:55:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 19:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMzRVxARDazNuO4eFppAy35lWtcDl463rkDaQONzF4k941JvP7GGZ3idjRckJWaACsSBosrcdrq0V8Glv4DK4tx/aGLN4hsTRm4csmaGTXVukAzlPLt3EqnMoGHfh/JtfltsAUZu7txFXYMcdXsZq7PYG2nFv9+LcS+0PI4uxm2A01A/BMDhuc9JEfCaj2PIwmXOFh9Aw08pQRtrmd2A2fk2lni9ldRuA5TB7YKQkIawFJo5Fgi9glktsBTJOyhi9OZgcoKn2PHP0pSdQ4KveUyBXQiaTMWa3+/L97gzrZWWDxKjagjfVQH3lu+43a8WzQnW9/2UEm4aZ6SASW246Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+18HRPHLBLitNO7kfZNBei1yd0mOFN2N2Zd51p7KyTQ=;
 b=Yh3iSmPTOHx4MyRFKe5kYeqaTFHltavL0GelNj4728yixky+UzVjgjJuPICDlZa/oj+m/KLKExTYTt29ttIrLmFojXCsNkLs2M5hA1MVYmU0OY3hTOyq//4bhiRbOAsPDGp+JJyJuxBDykjY2Mzb66ThtmmNfFP4L28Gveu7fO84bEDxsqkfIRFIOU++0ofQa7/HnC4wpwEq4tq0d5SI7OHWmNNPLT9Lw49rDcpBS14WkakBEG3KmReWLNJOducUEzWgzgLzvXusATaFNqEiYqHrJ8+Waayuri9btV/DVXl3g0MO/U3TElVFoFyQ3kXuRuuZmDXKdrD4j4qQn23KgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8164.namprd11.prod.outlook.com (2603:10b6:8:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 02:55:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 02:55:41 +0000
Date: Wed, 1 May 2024 19:55:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v5 4/4] cxl: Add post reset warning if reset results in
 loss of previously committed HDM decoders
Message-ID: <663300ab61745_138462945@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240429223610.1341811-1-dave.jiang@intel.com>
 <20240429223610.1341811-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429223610.1341811-5-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:303:dd::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a97143d-63d3-4f2a-16c1-08dc6a535aa8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8gZZK9+uNXnEa1TGS/lnqlEKNj1DgQq/bAOgLKWdm6lsD8YSfPNuRx/GyYBn?=
 =?us-ascii?Q?JaAd1dz0SHdDS+HGAhmXgNthHtoADzBjRZ6Fw5xCyFtK/7mG6F0g7JF8mHk0?=
 =?us-ascii?Q?uNzo3MzNRtYxjsDsmM+cIT5L9RRSKjM87+2MnV4YxHDY+AQkgeiE7w3byY6h?=
 =?us-ascii?Q?NGcN+rmPe3xytf+f8CNg/VauRTyDwQtbQ5/sFqTZBHlXQH4RoPgUtGYNXyVg?=
 =?us-ascii?Q?5VztUPzDmaA+FCrEXnLg5cQjUWxFmONQful0AwmhtDozq3FGwlveWfUIXhzr?=
 =?us-ascii?Q?56m6od/JCZ6GBqZ9xfKOjWi5J+OD9dP41Ov4IFR/sADWK3sxSzh9gy7uJ7cY?=
 =?us-ascii?Q?HdX9zblRHtS9Z/ccQ0YaYArM2eqMY7ssyg/XNqb24h9vwSYsB37cvvUrOoll?=
 =?us-ascii?Q?wxCnnEOv8IuAz4Fb7r1k6iIVob9Q8R6gJAqhumdDRKLDPbhAzRI0Ob6VYtWU?=
 =?us-ascii?Q?6be6HgV7zMnoItADls86DQrqhRpeP1v3hhvC9qUEjUfKy63YFgtzvAC68YSR?=
 =?us-ascii?Q?Xh1jo2KEK+g8gEbBUyiFCe5lDTfh9BNT9ntGBYTO9Yonub9vu77qUasqDlts?=
 =?us-ascii?Q?9hSQXX1IAcU6Oz5sT6zOkjt4re6f/XXTyLvm8UR3/kWfqtxSzMNDocNADpRZ?=
 =?us-ascii?Q?z/D2Ow4Hecnc0+c7GYSCTYCQT0q4zS+VI/RaT4jUH2wKkxw+LwQOftvlcEaL?=
 =?us-ascii?Q?ASbp9gGDSdYrYamz2sstfLiRx1gsUakMcgaGnfHYc4960IihpQkZdkSBSKSh?=
 =?us-ascii?Q?GtuBGFrm+sc3rLBWoSHVWpdd793rrm6xwgqTTpOa2mGgIen9aAvbtWworiHY?=
 =?us-ascii?Q?sm40muEZnrIN1Zo6IOBsGDZGJRds4wBrmkiQ8DtxgRkSEV099zoOSsHkatVI?=
 =?us-ascii?Q?xBt7tbtxDjcexUjFDVfZiKDtlPx7FxJrZrjg32h6mxLIMiYP1iQcjrGJ23fE?=
 =?us-ascii?Q?OickADbft0ZcVgiN8NmprWRnbZduh3GGfHO/30bhLoJg26j70R5TdOKE05U0?=
 =?us-ascii?Q?cEjUv8DQ2sj3iprQnWYrL7vrQHqq+QPvtwjT1+uhd2XXDzJxyYmYJH2Sdv+C?=
 =?us-ascii?Q?V2vGyl8CstGR3DgNoOOEMyyBvaHvvXGbtIBJJtFHWrrI+lnjKSnj59y5VBUG?=
 =?us-ascii?Q?3ULt1sNe0KGLTg61EGoxf+aNQDVTfXpUNLk5Va4J8wz+Jy8MHYTPUwNJX+0G?=
 =?us-ascii?Q?7iwtjH0aed2V3uAKwpbI+ZjyTTR/S/GiV+gBY0x+U2DryS0iQKaFVkyCuNdE?=
 =?us-ascii?Q?B5fvOQFYOHb4da0vaapgmrqjd8v+7z6B922v02SZ7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/FAkKHmVHQAzleylJomecVijh8YBgqb40QLFBSz4wAXrlUF/lWqZqIBHtOad?=
 =?us-ascii?Q?AhvaJuj3Wtu4Tq5MWWhbnePFZAte9SNDpIJZIMm8jbsGE2LAzokt7ydwTqRC?=
 =?us-ascii?Q?RWMFhR0V1MCVi7cthfJP8fYthzVaKeBn67xIwEJIC96nfIBPeZ0Q7MFo1+BK?=
 =?us-ascii?Q?N1+UP/3WDMJ/ChBC/0MNyzMQLND2nUAxesg6RveHTo2s+mK3CRxoTVdvqbre?=
 =?us-ascii?Q?Dg/olWVOubMM7peagojKq1FvkPaaZ553cO1tTZJ0mKLz0zR5+8o4GkLOqYto?=
 =?us-ascii?Q?AJRPw9k82DKroM0oIbWNKSu6gPc9nop8whepTHkPt1uoWn8iVlqPtrmF2Y5j?=
 =?us-ascii?Q?kky8hvc8BxL106/e9ACVIhTRW0xVbRVy3pElVAQCrOtD/nSMXVbGV4WGz9pl?=
 =?us-ascii?Q?swisrd/BZgiBVBk2NnpnR7Hmox7qd6++ej2Jp5M/Cr+IsEXgxstQpqw82evk?=
 =?us-ascii?Q?XHBfixdtleBrhjWHR+4yzQ76h4TfZajFi5kCIORMcWLYjbPNWuQqWcI9/e5z?=
 =?us-ascii?Q?b9wX70WBRUgURn+zGHLU2lm4WzEgswTU/uDOmM2gk6ztdNGhxbSSWJn7ka+6?=
 =?us-ascii?Q?QThE15v8SC/cG5TX5Hxwbq9Qgl0p7sX9B6EqmHdCcCmCuuKRpCIpfOWx7Inn?=
 =?us-ascii?Q?ugiI6w0exEyNOt8E6MCKCsOoSEEJNdzyTBqWiDr001pRdWiopS5sEygBAFi6?=
 =?us-ascii?Q?HLkQDT/izDBRYt9SqKux023wqKf2k4FOj5tIWFuZI7c4NROsmMvvbyxW9V9E?=
 =?us-ascii?Q?wqPbA50UEB1r5CngWwFksQ8arltExfLSU5EQddbCIroP/goWwI3IOOrgaB8I?=
 =?us-ascii?Q?xJXDw8RHQXuYl3vkVtpcsb2o8ydnuoqOngnyyKHSJZHNMbSCp1cm2giueZBb?=
 =?us-ascii?Q?o62W7lcSD6iSQsUQHpkYZUkSaAqRdMbMHdUtlsD4ijm68wxziiUZwNpwhK5c?=
 =?us-ascii?Q?4aCrh+9WmN+xELFxQ7dq6TufHWaG3E2RHTscmt5Zhwy8OnGgTmTXXUNxMimR?=
 =?us-ascii?Q?Rg3OyXsRFH972o0FD3Eo5j2mqgMlMkf3eWCigTCJKQFDD7yUsWYefvSkGLNG?=
 =?us-ascii?Q?jRDUCfeCmtSa5Vfj8v47MkjpN05t1qpK/rVYTn2C/1x72Jm/Grt6evlZaJ4o?=
 =?us-ascii?Q?E+HMllmn4g9HUW3Zqd1UP4CPZTNHqH1u1HzTEoVVYFcyw3/hqXGdObs5nMVI?=
 =?us-ascii?Q?3ZM+Bj/Ec7K0F/rpTB/1iRoqTBTUeYvNftBYXUnIXkyRReNwRl0u6g/JGaAy?=
 =?us-ascii?Q?zN7a8qERw01BePblMwN3rrA1pQO/WxctmLCSXcDgS56dYBGtfVu1OG3h6RlO?=
 =?us-ascii?Q?y96KX+bW01fcBVZsHjmZ7oSBByH2hSVcgwDW/WwuY2baDfJULhlvcABP0O5d?=
 =?us-ascii?Q?vhstVJP3EvytPC+AisTiF/HYuap5g/VPXaM2HevKKncqMnBY7D5CZOCBH4Qo?=
 =?us-ascii?Q?3zkhbLJIeG73rD05vzzY8CP7TXwAnM4HeXbN32Yk5u88tRy5QbG/eSIKGKhX?=
 =?us-ascii?Q?C6HhN36e1tAN8vpGE/Zhwfv2Rie4BcEYYhtAW39waGLbDpUaaIJ1RHCi60T8?=
 =?us-ascii?Q?QZjtHofqyq1MK/4apggYz2exk2+JOzbqgHTQ3dk4ti9n0mG1fPl1SNNIsea3?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a97143d-63d3-4f2a-16c1-08dc6a535aa8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 02:55:41.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYbqmH3es/TmFV7zSg2QoAjrtTDzsrl1/8MA8Iecvk0brkjmNiVBR8waNvmo9Zl3I+eCZKdJJB1baevQsQ49aakiJtAUqnkErbjc4TU7GFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8164
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> SBR is equivalent to a device been hot removed and inserted again. Doing a
> SBR on a CXL type 3 device is problematic if the exported device memory is
> part of system memory that cannot be offlined. The event is equivalent to
> violently ripping out that range of memory from the kernel. While the
> hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> register and the kernel currently does not unmask it, user can unmask
> this bit via setpci or similar tool.
> 
> The driver does not have a way to detect whether a reset coming from the
> PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> detect is to note if a decoder is marked as enabled in software but the
> decoder control register indicates it's not committed.
> 
> A helper function is added to find discrepancy between the decoder
> software state versus the hardware register state.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Simplify retrieving of cxld. (Dan)
> - Add lock to device to prevent racing disabled cxlmd. (Dan)
> - Promote dev_warn() to dev_crit(). (Dan)
> - Move LOCKDEP_NOW_UNRELIABLE to LOCKDEP_IS_OK. (Dan)

Yup, all of those got addressed:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

