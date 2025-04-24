Return-Path: <linux-pci+bounces-26644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8352A99F1F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B71316FF63
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697FB19CC39;
	Thu, 24 Apr 2025 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efZGdI7f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26B1990D8;
	Thu, 24 Apr 2025 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745463730; cv=fail; b=iCZ8sLOiIeZxEDJ2Ng1ajm1PsRtIEhixBSheM4SCfFPRzkktEKYEloi5XP0AQyfmYhFbzktYnVVZ2fiPnu3LqQMWQbG/47INbesQQLowXOaThZU7xXVi6aCC6sMFa+ubc4uLv3MgVA9RfzF/D0QaErUGXPr3ryrofm6a5h1pbvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745463730; c=relaxed/simple;
	bh=oJwWqoL+vbcIbsGqbFAVdUs1geUsBloFbZWfRABWYs8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=razJDpirKZdVL9zdiMmfWDMa+Fx5yYk0B2Ta2eHRv2KthLvZRaXwg4kG8mhfEZqXQAtPEwlP/NLFvN+MjFZHRpXF7V/MN4DkuxFGCAfxCMuNQBTgTtW1bWMkEiHzpCRNx4xHvzlt2n1P35Nq1GJKdKY1rWeWDe+/fBKCTOYtBlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efZGdI7f; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745463728; x=1776999728;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oJwWqoL+vbcIbsGqbFAVdUs1geUsBloFbZWfRABWYs8=;
  b=efZGdI7f/gnPcFg/Fat7k5EjOX8myW4QamNbJk2bG4m5GzA9uijhBZ4j
   kC+FUExNmG/VsT+INJx8SacWiZrWE714EfQO8BqK7YtrR9f7x3kyvvbzP
   PUgr9sciyqNh2gEV1tPtgqHLjaMUr98EzZJ++/vGsmxhsL5hKGPmAHi5j
   3BWR3tbl07QfS7vYlwsy4RC3pC7ygNgfmyQdNIC9xUpnAU7YXjX0Qw5jo
   JIlCiUcORoMaqKy/Ds7rehhHuU1r33d7UF7m3XaeLa6mf7iZf1P5TpuVT
   Imkm+5p76U+GmrY0i9qiW1agxrgbqbgIyOyM7xvanvlQx9ZZmAGR+5cbr
   w==;
X-CSE-ConnectionGUID: ufGDCYaWRku3+1A4fVdLUQ==
X-CSE-MsgGUID: S3A6yBQbRJStE1n7OcIkJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57275575"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57275575"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:02:07 -0700
X-CSE-ConnectionGUID: z2Jki/dTT1+HUeo6Yz7OUA==
X-CSE-MsgGUID: 4BiQ+PbnTb24lSX9b1KT6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132465612"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:02:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 20:02:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 20:02:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 20:02:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX9J3k7+Mv6b5ZcKI2B8BgDQoianfvQDmvFvAhZAdr9xVYvgEhVdCgixD7Z8i0EilD/kfpt0dlFoMHi1cN95uY7D8MFbblSvlVwF7Aq9tGDjCjQ5/FknvewpPPQ4vpn5m+N9TWkXxxc305td0UyjBJO7n+DJX2YyK0LvbwiNiePElkfVvQ4dbxp48EZfsfKG+LFlpo+bl/IxVXPX5xg4Y7srtwH1YHgvm4H4DXoe3E5chVkH7tBuGLx0kVBcjBFSjmAAUzyKR8rYtCYtUAIT3WI61hH7ehIlewbcxcnVgME5goHiI1R09XV1ksIYCNfwJhH58NNRTjVI/aDMXtEGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/JFLXjKr5Li8MdKFjnDfoC61TaPbkBEhBPLOCaeX9o=;
 b=wlh1OI6F4VFp2l4B5HANfOCYdz2CtzTRmaXlu672TcBq+xbAD9rDYuICcoGEK+G9SWM764YrqsTVdDW4BN0lrpjf9Y2KVS2yg9JJ7okBFcvskELvrlXKlpP1DRTv4Q672S7mhmF7MWsxLF8fMpJY8v5890VojUSQUDw4mL8M2k8+36GuDCQMqjLnJLrsJ61SgUGTteeXlF7sKVKJN0OYfx7p/rLMQeKWcqy0DmV8jeiTyI4wVwkOTddtK8980f/rxcB57t0SRLwOy7KOS2a4LmW8NdZDLSqD0fi7sBIwccdimPMmrXprCN+rqYYy+HwuLlN8xU441v5V8ytmM6xMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 03:02:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 03:02:03 +0000
Date: Wed, 23 Apr 2025 20:02:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, <corbet@lwn.net>,
	<bhelgaas@google.com>, <kuurtb@gmail.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <vkoul@kernel.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<sanyog.r.kale@intel.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <dan.j.williams@intel.com>,
	<andriy.shevchenko@linux.intel.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<Dell.Client.Kernel@dell.com>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 7/7] sysfs: Remove transitional attribute group alias
 macros
Message-ID: <6809a9a82dc0b_71fe2948c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
 <20250423175040.784680-8-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423175040.784680-8-david.e.box@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:303:84::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0bcc22-7b3e-4a56-919a-08dd82dc63b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MgN3ofCWW7ErpTN1n1+olhTXJt1mKqon3To8nqSDamutRi4jsz3DaNtL3EOr?=
 =?us-ascii?Q?I7+X4ltxyByvQ1IZhPmBPPE/ypeSfEIkATUGXbCoLagWAm8Lq+bdAUlqZ2es?=
 =?us-ascii?Q?LBC3i1GaqL9nwR6LpvMT87CgPUqKb4J44lOFFk4zGJtLBAGhgKlsW45jibgB?=
 =?us-ascii?Q?o4GRtZMbLZ836rqo48g2sge+dqWS9mV3ASDBwsP1qwq2eykD3zDJO7blVlfi?=
 =?us-ascii?Q?BVUDBSNGRmX680f138TySVP1asSgaJz3Uu5YMgMjBW7w9usszwSJxkPPrsst?=
 =?us-ascii?Q?mBxlgBpEl2jax/puyVMbXQJr4bw0/8h8n8Y9GcFRbVXlkXL2FZPXvAvoAd2b?=
 =?us-ascii?Q?dX4lYb0vY06Vrz1REVQa1oEW5y4asAhMfFXk3CcIO85xJeZ0Awy/Nbc0mkU5?=
 =?us-ascii?Q?j7Nu9ZGhzCfWrf+yaax19zcedXqo+R70mR+pVne/MEsPOM8WxCLEBhcss0LZ?=
 =?us-ascii?Q?DHdEgIhT+prPFWZAAGYZwSZQHLO/jAmaGLPfIhMlbCOEpmD1QzeyVNY4FnEl?=
 =?us-ascii?Q?7yX3W29K9mckMtKdPRTThSzD+o0ExJSDuKzLpJsPulr0znGOzndVxy3EeTci?=
 =?us-ascii?Q?o6upZq1GbPREyktHNCKJC2Tks7g7+swn+ff8bkg2tAB6efCibII9AI4B6dVD?=
 =?us-ascii?Q?CIedjdI5nGLTZdj43oIP8n3jVMGRrZJ6xBN5QKX1couE427dFfvCIg2MJzDm?=
 =?us-ascii?Q?WdKW4aUT+Kd+MUoDohbciG02W65RYWsgWeh3txyuzWjLPKtD3PcQzlwpkVaP?=
 =?us-ascii?Q?qsAgPw5wZ2BRQIJG4b6WajeteOhNYINB1UepFS656kI1y7izEyb8iNjs00S8?=
 =?us-ascii?Q?RjHvn64j2mvedpU8cvyMoQToSDtFS96+3dBo/xcIaTJNepFosrxcoRC8qM95?=
 =?us-ascii?Q?2dUW4vqpzDTkZ8axtpWb+JHvFCkT2f9rWcejAPjSddynh8pmh9v7kxSZWiAg?=
 =?us-ascii?Q?kL4vytg6RHPB7MvDSVBLxW0FVIrtch983eXgIDNo0Zz2oyg3j1EX4uh118/Z?=
 =?us-ascii?Q?lpWGVSB9Y13hnzCryUpAYMoJcdd1C3+8DUIj/HqzB9Dc2TQuZXB8ElnCiOZd?=
 =?us-ascii?Q?DM+EAxeahFSy9ivuFFq3XreGgXw4oRHkHjZCNijzOusfNFwlCirRfqfxjIFK?=
 =?us-ascii?Q?NML4iZ9CAkz9pBWrv9n2Pn1dgGmeSAbA0+5A3bc2h1CuNFMqZHG71iTxxXIW?=
 =?us-ascii?Q?xRScpkUZqt2r/S3cpO1k5D/YHEsuwCAd+z7Ov9L6Z5dCtwJVlIQcnBKjkFK9?=
 =?us-ascii?Q?JRBdbU5JsAYwUMK7vu45Db3NkgBfX7021etIIZHIjdHDjvZZUBCy7O+RDbkv?=
 =?us-ascii?Q?++L5K+b1u5/AswIWaBkOzjYjbRchWKXGdqZGhi/ngSrLfn9p21+VecqC1xjn?=
 =?us-ascii?Q?4grluOQAywJ2RlCfhbZEjxK7ACwQyYQ9guC/TRN6QBFgrAu4XAYcRVjloxdY?=
 =?us-ascii?Q?raQ+DXkwzVGxHtDrjelHYO3YtTep0LRdFLZuLWDfhsRSdvmCdj7fvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmiiHfUcuH5AGuLvHN+o9MkMTcrN35MbF9qWRRzPyp8bst87IJGDf0+0PbJw?=
 =?us-ascii?Q?ucPNVSePZ7WKs5pAks0V9xbyZtxqBkqz7Gx5JsX8zkDUaOqkTnx6YmFhQN3o?=
 =?us-ascii?Q?1cukPoF01HJr/amd4B4CEOH2gQJTm6xzWFWrqZX7w/Rm59MQ8lraA8VOxqdt?=
 =?us-ascii?Q?WzKHlcvxhnw1C64PNaSvgl42YTWNdDleNEACnfLVdLsRocn6GkkOIXwj9bAb?=
 =?us-ascii?Q?zKyqmsE8zIm4Or6ogoDXTT+7i80GXcHKcUPAF6sv+a1ZTOZO1xkmwhpD569i?=
 =?us-ascii?Q?bf6lQmNAgI6QEo6DZv1G8M0E3nDX9XQlaVuweKUL2/jPCyp3sDzU3QVBxJlU?=
 =?us-ascii?Q?Qm/Kog+aylWMPLuNGC+nOKF9YnwpRg7ZUrC2xsHiIaQl8dB/inooXxbKGeP2?=
 =?us-ascii?Q?Pz1sy7CwvcR2Tq4FByIOoh4kq3pRwOPsTSYIXbhmX2VbUMXLDsD3ORlNTPry?=
 =?us-ascii?Q?nxcRiNGQXBA+K72mSwv0BshONZ9i2k60Q57B+rHXdXpJRRT44HCWdMtgfvl0?=
 =?us-ascii?Q?9FBvCy/L2b/3oxM67spSlrU1GkZ0bdyjGg/YJ/BZfWa4xl8r1MlS7dnHTP1p?=
 =?us-ascii?Q?YKfCCGSbVVhVu04r+4PsAduvrmEVnK2M/uBm4cqPIgoZAHjx8qX7srcP/49W?=
 =?us-ascii?Q?QT4msag6q6/OX4w4m5xYxj4qFTqjqqxUSeUHr9ajP+Q6vJjTXah1k2HavX9M?=
 =?us-ascii?Q?inSUDl6rXJgBQMNcHxNkG/yY5qQJOF7ma3n9ea/oYJCOLDKDJuTwphl8abx1?=
 =?us-ascii?Q?Gonbo4hs8qGfFOKHS9U1UiWCBTcoJXiwT9eaTo5QvwvCPGq1dhUtgLsXGvn6?=
 =?us-ascii?Q?iC9fZIb5j8ytDjTXydLwszlTXNMxU5qDXt3wr08oACs76WEoQS6ZZEjc/UTQ?=
 =?us-ascii?Q?9O9RtFYuLCphrxFNQzdbuzEXAwzVb8k4GiygfP1DQfL9pqZ8RzvmVojycbqD?=
 =?us-ascii?Q?tbyTiFFQF59gouHGW3K2TL+yU1UCEpU8qFZYihibAlXa3zT4uTF6e5xi5xKt?=
 =?us-ascii?Q?TPNra1EeVgnL8KOtp79t4jaEEBW2nAzl/ReIFIgwdHQWU8Tk/WgewfbR6AuH?=
 =?us-ascii?Q?bHx0Q3Vs32M04jYMUAJsUomunA8Bj3XdkT+tPKeNigr5z/8mduHQTGbOx6TC?=
 =?us-ascii?Q?sG5IVb9JupRJxqHJn6fOVbn7aCou/1TmXW/oijMwzK/tTiEwxqwOnc27qx7b?=
 =?us-ascii?Q?l7UqbTHurhmT/gIuCeaPSbdRCDO9HFtp23QYgwTsFp+rkWDnxcS0jfH2Q0b4?=
 =?us-ascii?Q?u0B112m5M/tRFaXxA92Ml1VvRF1nl65RteRV5+JqHQZd2ILALnATgxAYASQH?=
 =?us-ascii?Q?gFceB5jXEFa3Kjtv80l3Absig4aGnnxnXgZ+ePdE3Bnsw0TPpAMOEIOAryAA?=
 =?us-ascii?Q?JTFneBSzCAfsID8hSnatutUiO2szbixTGUH5ibv4Ghb+QShK1W4bv8Mn1+MV?=
 =?us-ascii?Q?C9Z0nSlE57WurijVBbQB45STtyFtlbOgKdkfAL0/TEYdqKY+BwkfzC3semoU?=
 =?us-ascii?Q?Q8M27tXnM0ndZ4VkvuqTBm8S/gE8+8ryNU4+acZAqSgck2fAePn0Qhnl8C14?=
 =?us-ascii?Q?Ey84ocC34PGs845KXEXPnmnFqSycMjVo/8T7I7zfAjTlVRLO7dMQcjKTtW4E?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0bcc22-7b3e-4a56-919a-08dd82dc63b4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 03:02:03.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3DFCiF0xU69QJu4I+o4b8HdFzhIbpvqsTzwnhkSwyewX+dZCDJcqhJkSlnuN5gHyRlDvmmJa8BFINEr3M4XPGjRM+0d6WTLujHhOL2aLSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

David E. Box wrote:
> Remove transitional macros used to alias named and visible sysfs attribute
> group definitions. These were temporarily introduced to ease migration but
> are now redundant due to the adoption of the new encapsulated
> NAMED_ATTRIBUTE_* macros across all relevant drivers.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Appreciate this split just in case there is some lag in the acceptance
of the individual conversion patches.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

