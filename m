Return-Path: <linux-pci+bounces-7358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8668C25CF
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 15:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E7B2822B7
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C8612C520;
	Fri, 10 May 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlYy4mNW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026B12BF39
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347910; cv=fail; b=JVo/bX1QQsDFmEghp+vxmmHbCEO3iPUPVXXHp+wbJNgZ4aGRMIKUSjCLZcsPiRTVIDqqtX5Cgq/62Cxwcjhdde5YfzvAtCpm558/Ng5Bygy8hC3iEyo1eM4J6WK6CCd928bW125GVudY83bRKaO3NGiWoN4uXMNdcVKEA/+GUHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347910; c=relaxed/simple;
	bh=DPL2KD7CvmadMW2ZdyczplMypVgFoj4AMITk9rlBvC8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SkQ8h1OXri3+TWM2BeE4C9kRQG9f+x2rIQC5/EOClh/5JdyIOaWHiQ64WpHZrozShWCklJewoC/bI96ETtSE+gLcBg0OIQ7aWrV06+1bVBdDPwnS8InN5yZYnSzeREMb4D7+gkl8gVcAj/vQabipMjn+KQPH0f98UwvOZJis5pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlYy4mNW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715347910; x=1746883910;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DPL2KD7CvmadMW2ZdyczplMypVgFoj4AMITk9rlBvC8=;
  b=hlYy4mNWszoGvV0L9Lym8oyfeqNtH40+fA90DkQep7sL/MgtYXUOqXbz
   orhMjkK4wWPARM9sm1TuO1k3EmA5r/uS1KjQYk29ymvD6RJNXmFR52586
   Urqap4kZBLPx2bDFmd5EiT7FU1ASYxrqhn77vb9VATxfmXPxkWNk4+Bcg
   tjqbliHEJU1VkYL4eKNYEdNz5pK9TLNseyFosBsD3QNgmrsNEDlml/u0F
   MDJQLFITEpizTGfpMf5FXDZ1g5IRxG5kpRGo3k6WDL2UtbBO+zFI7MczA
   ijUDO2n0tRC7+wmV17sH2KIJ6fCTxU7WMmCRSgkIy8bzjOfPLMw+97XNN
   w==;
X-CSE-ConnectionGUID: vwZShQSMR7G4ysBPBnlxQQ==
X-CSE-MsgGUID: Sy/tUq83SN2Jjayp9xz3Pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28811442"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="28811442"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:31:49 -0700
X-CSE-ConnectionGUID: HBLP7QTwROae05Hhw8l1CQ==
X-CSE-MsgGUID: m+wW29cjSOqkhZRNPrJHPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29723920"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 06:31:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:31:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:31:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 06:31:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 06:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b76rLzIA4PMoe845SxRMU9363OZCVcRvL2PEkRSApt+bgCnvazicSzInqDnz9FSRpwnohoa5euPyCuY2jmrplpZPjWROd8LcZSCgrDlqawYvpCg0F3o2rhZUKR+1JktYtExjIuT17bbwMYfC/+pygBhVyNL6UGYrYXgU4Npvkh6rhgutVuhxKr3IrRorD3l6OM8Yn9y7Jl2MLORTWTZOx4Flp8FA0J4MhXPBIi+hNnZv52QIZD6N/jEzI/a7FvfQ24oI02KmYeiLGJs8K1hOTbbCcSAORa4382iOGF22O10fdHLhR1jNNpk8HnCxn9zVtqtcNCHZriwYTsCMbknXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLm+wdOEpoxKGQOpRzSTKLaleSCho35H/0CaLRFotJk=;
 b=EwoOGaU5ZJsqaQMRevCvuWPSWHmnYkJa53jpoLX2zEEgmb7VUhXfrMrgZXDXpJhuSB2zQGTvP123RQrXxH2TMsL7Bfeg/h2S1SLjKmMjRMG/jVe2wf5z0r52AJ1P0f9QtzcxQtd70vEq166yIrB8oFrtc4l8LSCRdb0GQGpYXICOiLBhCuBdqTOhZneNcO13PNiopxaWnj38Kd5yPkZl9nzSLa1rBecKEp1/yDbMR/bszg5uT4WWCX6tyeHKhjb6UuFNOiUVb9Eu8RcEHJ4/ZfZiYdUUAJvFQ2b5Ii/YWx4Da31F7HlUZ9oG0uz+oIQfcyZJmD6fKH64u0K4tCoz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by DM4PR11MB5310.namprd11.prod.outlook.com (2603:10b6:5:391::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:31:44 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 13:31:44 +0000
Date: Fri, 10 May 2024 09:31:40 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/8] drm/i915/pciids: add INTEL_SNB_IDS()
Message-ID: <Zj4hvMUY_j0693hx@intel.com>
References: <cover.1715340032.git.jani.nikula@intel.com>
 <ffcb2d954ad9bca78ccd39836dc0a3dc7c6c0253.1715340032.git.jani.nikula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ffcb2d954ad9bca78ccd39836dc0a3dc7c6c0253.1715340032.git.jani.nikula@intel.com>
X-ClientProxiedBy: MW4PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:303:6a::30) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|DM4PR11MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8b499b-fe7e-49af-294b-08dc70f588f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?igTTbz7e6sZi8NXoOBR9cxQftn4dt1r3sRgFJ7GcYebupOzPjtd2JtIF0uMa?=
 =?us-ascii?Q?JweStQr+7jShRG/SzY9wjIqdF9M21VXGV6KcYbsYhF2ewr2zEpzcwsIyC7lt?=
 =?us-ascii?Q?/kBblt3bteOK5rFZB8gwpMPUu+h11e0mcQs8C+RQqy+Xs32ktHLSwIiRnvRn?=
 =?us-ascii?Q?l6jFaTujzJ5VvSYlzHeNsYIe2rT8C8ua70UIH8zWpFlglNj/nF5XeYXR3Apo?=
 =?us-ascii?Q?31mYFPMQ7cCAbI4z88eKZwj6VPKSAFkoiNAPrz81NhEQY5qClgPcshzybjMW?=
 =?us-ascii?Q?yoWPqFKQwX7qGb0K4ecpLbaAG9alcBYP6/xozjKk6FXDnJYKEQtSA7uymyRO?=
 =?us-ascii?Q?a+nDPlGht54EE21gceknosfFt7B4mXVzZBM/G75sFdULt5ZcFFt5p8Nsw0E+?=
 =?us-ascii?Q?5ynWOI1D2dwX87p8mP0nM/2sAYn8TzYvpeA1J2/B33/IX4U4JHWfgMKAUJhj?=
 =?us-ascii?Q?bz4lBZWNVi87Z5xKQh5zXglwzpykwmDWWHkf1sgIv2BKdfb9yPMVlxn/frLJ?=
 =?us-ascii?Q?UkcO9N6/hMNsia9bqzWUbJqgbtGLsu0CtXmmRDosdbJz0xzh8KVCX2RTJJMN?=
 =?us-ascii?Q?DQ7EBhIEbVWCEc93mH5YmBlR42eBNR9yhrgKKL84P+8bw7N9H2nPEMmSfkEc?=
 =?us-ascii?Q?Y8PrARmDHuLrQoTd9izpISWlR/WaBbs86MZsD2AOJc6S2Y8XkcbUwsqGawyx?=
 =?us-ascii?Q?yl5ZYJhjS9e3dRD/VHIHJrfQv3OK3ZYTUSKQldTNJo2s/p6rNiSHQTTBKOiT?=
 =?us-ascii?Q?dQ6KeXCsFCsirbVSVWKlwMXINK/8vae2avsLuFHGG8FLurd8Q+833K2LK1Hr?=
 =?us-ascii?Q?OlGyAEaMcqgM6ygapj1+Vi6EPW6QUvgjwJgEH+HDWKZU/z6EOI81cUEkIJXE?=
 =?us-ascii?Q?8b9qbNAhHFNCALu8DG6X6yMxFWfigfMjj7aQByXPit34F45k57YhPKo5bOJC?=
 =?us-ascii?Q?maEockTwEJYQLp7neryjvwbfn8UnoVgmnr/LvnhxXvQ9ke9fBP4Au+2fmo1g?=
 =?us-ascii?Q?TlucKADDKikpPwi13RzegXDLkDRtCik+KaYMVpkLUBBaw/CMbq8MS1nU0yMd?=
 =?us-ascii?Q?LXE/et55PKdxMxYw4BcW+UNh0opXDCsYk1DxuI6f1vCLLOaPLbr7SnuLBP+Z?=
 =?us-ascii?Q?Bj64C6hEyp3mrosdNA4GbpQvIV+Poe2GGaTUE5MZybEOAtJ3Evlp28OEkoa3?=
 =?us-ascii?Q?ccudCtLAY2MMMF4uufx1fWdRFZ6A5iVrE9ZsA33EjgH56XUojZRQJhLLVVo7?=
 =?us-ascii?Q?02cwWQFM5iCzwXL3bAeIJlqHrKmE2l78HWCxMakVGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SSH1H9VoXH2MDM5/H5ZwdeQ6M1YDtyLvCHJAwiwFMReJysBWW2Gmt55Uaeb9?=
 =?us-ascii?Q?Bo37czjkaSOgEZ0xhDTpWXbbuPAD+uWwb/6jQy2/Y5CllPK0Yn6M45oTEXAE?=
 =?us-ascii?Q?md/lnMpboUOreGO9xrnt2rn8haApJhD5JU1gPSzSD9pY2+Ynfii/GGu/lVLH?=
 =?us-ascii?Q?Pnmp4nHUPzz+5AawhC5YDw54gzDqQk+O0ngiccgG0PXCQbkjy0XD4n4ROSkM?=
 =?us-ascii?Q?uKc4QzOYJLcw+n/GMFSDj7PruAesnKdqkWejEeJZNl++8TBmdVyw/ULLBuVd?=
 =?us-ascii?Q?GHBeANQ2npgrFNs96X/2PRjYsNGAWcQ6fhTHudoGBRUazf/YpzayibMhux4t?=
 =?us-ascii?Q?5/auSlRJVKro7V7psrBpvmygq/4EiXgmftIUav/5GuTSrsSFH53CMEnVUsdg?=
 =?us-ascii?Q?Xqqp0zMFfeSXp1M78l7OOspE0MTu14wjw3hyEHGfCLuDO1yI0CRxHqenNN2M?=
 =?us-ascii?Q?QRplTOHB4i4f3a3y9y47+WG1Y9Gh96+JRwAcKAJkTapkucTgyrVsLNAKa29p?=
 =?us-ascii?Q?xmwuOFqIs742zeF8WbhP5TLlrP43DkxfAWO95UgxsJOeh1H4SnSuzwnOw/ch?=
 =?us-ascii?Q?bfwKmDdRLCse8xTig+kEFfNW6mjEFOMv9D6X9AHsKgEkEYF3quW+kna95I49?=
 =?us-ascii?Q?sSAQs7YwPL8oKx5wuZgCy0AyHt2qTC8RBrJd3Srmfw7x43H6MbAwWPtT5yXx?=
 =?us-ascii?Q?8xY0Pb8d9J97iyygRQ6DWCQ8VS1xeGYQtsW3dgEMG7EJT4ephjtk6RbgOz+4?=
 =?us-ascii?Q?NKiaozjT5PaBn7rDLvlNJNt+OGwfBLW3G2qNFPelP1X7E1npg+iQilH8Hzop?=
 =?us-ascii?Q?wtMJo7VQE29EdLLf9q1vEB2RCTLNt/dKaiTr+ZlfZnXUCvdy1by6YpFufMeW?=
 =?us-ascii?Q?QyZKTu7vsCQRyTq6dRWC/HUfkvqkuZpqu/88Fq3NT3HiQWxTyM5VP0rzlWMj?=
 =?us-ascii?Q?pYpx2xvg0PNDLprBfrnoPpuuAIk+vEqDrjXmJzRHGCV/rjxmBoWGCIgLc3f3?=
 =?us-ascii?Q?knIHEXgcIiyHxGW0yRdQtSIjvA57u1grro2tyi0S4V0xtATKdDkOSc9sg4/o?=
 =?us-ascii?Q?+CnDwllVrcfQciDRWhKJhDbfXsAGklaS1OIdIy+789MfclvjieUWJcjb+2p3?=
 =?us-ascii?Q?972zgyZ//5qylrlO06cPsItbFLFuDJi8swoP/cY+YWZCvp2LJ0Y+8TN0nCps?=
 =?us-ascii?Q?IpdxLLWaGNJdlWUei+AtFcmG1m+HLQDU4InS2ZR4PTqVLDFmyTqPXZrGl4VJ?=
 =?us-ascii?Q?cBpO2ulJQjE5PWYp9jXKRr5jc0XMp2iQCIBfuS9VrDzzjY8BC7i8AbNfTjpC?=
 =?us-ascii?Q?wFw6WxbK1QsI7s1urQ5JzwamFg71huto6Lm3HY76F8YKn0ezrb5i1HbGP2su?=
 =?us-ascii?Q?ENEOEbydckBDfKV/+zeXPZclZ+cY6S9ALRYwcQ74ygpRRwhIMAnwu25mbTSd?=
 =?us-ascii?Q?ncpUqSCwpMqFmuPBdEc2g1XvkuUNO3OJo54d/Cyy9kEvcGR4Ml7XOFvnNB9y?=
 =?us-ascii?Q?O6ashKjCvloMIMch9fRJVa1rPyW330gsB+Dfrq/LKPMf7pdK2ERGF7k6UVXM?=
 =?us-ascii?Q?wr3U+8W9FxIEg91hWXP0Kev1A02fucJLEwbJNtyNMC5mEd+yUqwtcRoO1eA/?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8b499b-fe7e-49af-294b-08dc70f588f6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:31:44.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpRI43mRhwTyq6s02O2TSmpNQ7UB5F3/fNxEHKvTDSkChssURYfN1jVB9FoUMiCsxbAs57L4fcH0bDlCwt/WYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5310
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 02:22:16PM +0300, Jani Nikula wrote:
> Add INTEL_SNB_IDS() to identify all SNBs.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  arch/x86/kernel/early-quirks.c                      | 3 +--
>  drivers/gpu/drm/i915/display/intel_display_device.c | 3 +--
>  include/drm/i915_pciids.h                           | 4 ++++
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index d8419d310091..23ded9260302 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -534,8 +534,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>  	INTEL_GM45_IDS(&gen3_early_ops),
>  	INTEL_G45_IDS(&gen3_early_ops),
>  	INTEL_ILK_IDS(&gen3_early_ops),
> -	INTEL_SNB_D_IDS(&gen6_early_ops),
> -	INTEL_SNB_M_IDS(&gen6_early_ops),
> +	INTEL_SNB_IDS(&gen6_early_ops),
>  	INTEL_IVB_M_IDS(&gen6_early_ops),
>  	INTEL_IVB_D_IDS(&gen6_early_ops),
>  	INTEL_HSW_IDS(&gen6_early_ops),
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index 052fd1c290c3..c40d12ca386a 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -818,8 +818,7 @@ static const struct {
>  	INTEL_PNV_IDS(&pnv_display),
>  	INTEL_ILK_D_IDS(&ilk_d_display),
>  	INTEL_ILK_M_IDS(&ilk_m_display),
> -	INTEL_SNB_D_IDS(&snb_display),
> -	INTEL_SNB_M_IDS(&snb_display),
> +	INTEL_SNB_IDS(&snb_display),
>  	INTEL_IVB_M_IDS(&ivb_display),
>  	INTEL_IVB_D_IDS(&ivb_display),
>  	INTEL_HSW_IDS(&hsw_display),
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index 05f466ca8ce2..0d48c493dcce 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -151,6 +151,10 @@
>  	INTEL_SNB_M_GT1_IDS(info), \
>  	INTEL_SNB_M_GT2_IDS(info)
>  
> +#define INTEL_SNB_IDS(info) \
> +	INTEL_SNB_D_IDS(info), \
> +	INTEL_SNB_M_IDS(info)
> +
>  #define INTEL_IVB_M_GT1_IDS(info) \
>  	INTEL_VGA_DEVICE(0x0156, info) /* GT1 mobile */
>  
> -- 
> 2.39.2
> 

