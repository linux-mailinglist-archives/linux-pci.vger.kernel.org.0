Return-Path: <linux-pci+bounces-34860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE2FB378E4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B94C1B67C32
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D8630DEA9;
	Wed, 27 Aug 2025 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMNZA7j8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1830BF55
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266792; cv=fail; b=u4rC2l/KFdd/ARIQKlKG0FWFylzjxoM/dpC/K4mezpVVrYCFmcgGWfSHvImzq8YEcxpWvkoQ0IrtFQQiPINnso0DvFLxRHgDYyE4Yn9nJlRjUIxaGmfoxXvtAr6+0h5f3sRoDK8jFsS8rR0Xd4m1RL8B25mZ17sN8VjTrZWbUVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266792; c=relaxed/simple;
	bh=9VK1PqkheHtgGAFbRmaykRNgO6tdvxyK03lPWQRcxPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGVp0LJBfwDmDuvfL5aTElPWDABbgnLPAlQaekjVskx6lkza5v2L8SNskSWRt9JUzNce/IVlSEb96wQV+sOOkTOrNw3sxfXJITOPFQGtjDqulVDtfx3tiTw9O7fQAA6xR/GkfjbLDXYoWPYnD8XovspEyjxk6ZGuWl0lmdM6Lb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMNZA7j8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266791; x=1787802791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=9VK1PqkheHtgGAFbRmaykRNgO6tdvxyK03lPWQRcxPY=;
  b=VMNZA7j8ybv3LbbvTC9l4pEnnEzWevIZ+OZvvcQ32hyXrQX7fg3kq6ye
   LxtJmMrqFfyeJ/noFf2r/viVuaJ3CbN8ukpteiHz9ZXQjoK7AhOZNjgXB
   L62aWNOVLRbU2CReigNoHqAla9my2M8TRrpfQoro2EhcGvqdXSnPtenxj
   WzF3+qChV6w6f/GT4fdauXJPSdnJbg5pmgWPaQtaBGCsD/3a/0ijN8V3k
   4xzuO0ft0K/57NvDI1mXbSyrOA4baZ/zTUHhQgdqjmHbctAptHlP9ISJ3
   Q09t6frQgKc1CsZXEa0NO+5vFVFQlJFZAMyxSmZQlCsVx6HcxVg2SvVyf
   Q==;
X-CSE-ConnectionGUID: A+s3jZVKRxy/GQMOrudr9g==
X-CSE-MsgGUID: cTPI2N3+SAq2cRROgSxhjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="61150979"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="61150979"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:10 -0700
X-CSE-ConnectionGUID: 85J60CBIQ4+HLSG/yFDkzQ==
X-CSE-MsgGUID: KBYkK7GDSZ+nT11VXwkZwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="175043344"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:53:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.79)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR2mu1Wl4M5UGSx11iaVcI7ceUBwAtNP6AXumGpn+4cpjkXfDNq2RPQXfavll0P7ezB6hldZYd4Reh0cpEJO14/r4VQApY8Xdz3Qy1aIZqH6gmDl1TFIS0JfpEt1Ibzfi70IZja5AmuNVGZpPiRO4+8P+rbxecYxYccgtXjK7jd27LnizCIR48EI+5LV9XCHzoto6yaDqnErZqM7HNrQtzNH1qV2+Bpc/ltUVkL714cMzLxGyhvVxtwqYL1j2GQvy8PsElQEy1iEGbxXWe4iqFAaf8HIyUpVF9YVMqCyToc81Xa2Ngrtr4ohnrV6KxjPlVfQWgAYh9fHc7H//vDdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U53aRon291NCt+9bVuqw/8MGdshvFADTewyi6EH8604=;
 b=ah/qXH73lZre9blqyfxYKi0JFMZCEt6D+19aVvmWCd+sugEDjSkn1Q7vA+bywk93LWGzGED2pvJZf6b6LEtIjWRFoR4JWdn9sLaWX6lQYZhllbwU3LnxLrp57ZIyXK9iPcm1FdakqPuc3XufYuAU11Atf1sHhknRoiIsQvsyyE7XeOVzfg0SKkgNfaOQ4BznMTFkgX7mdtNohH2qS/G+7p5QIbEK9z3Hd+dSojuek4IHiPInHakv3VPBsP2Bg0WYjXkot6NIHQFuVukqF+AU0ejqiTxo8lLSnviIEvHTScqDyDWlntCewhJ9DsMB0p5h+aWjlubbSoDY0HFf4BS/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:53:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:53:02 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>
Subject: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for instantiating TDIs
Date: Tue, 26 Aug 2025 20:52:53 -0700
Message-ID: <20250827035259.1356758-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035259.1356758-1-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba687e8-4039-41d4-5c90-08dde51d3887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ClVHLB7oFE5zKrKKN73PCirreNBJakvnB0CdzIQov5Smi6YThfnoBKYicDOw?=
 =?us-ascii?Q?+v/dNNvFPG+xxoOV008DqNREl0WhpP69KjxSj+2gdMPcHXXuBjs2Z9oS+2ja?=
 =?us-ascii?Q?Ku6Yd0mXJdIlp6jCg/B9sktnMX7qM/OL96hZYH8EXvpZeFEsFcHqUlnDpT8E?=
 =?us-ascii?Q?yiJgMNSY1vKEJnGrJpVOzHAEqkRsnarzRkvEzuDqM1wijL/NChAWH38hsPLx?=
 =?us-ascii?Q?OQZdwgORIdUQyQwKX3LI/O5A1HMKclsho4IeowQW2J4aQmZx2IBZnk9SSC5t?=
 =?us-ascii?Q?i84w0lYilMmYz1yvFZG9b9T3KM96Z3H4TcivsVJIXqUR9x2yjHPTDKC/6Bv4?=
 =?us-ascii?Q?PxI8j7F1XqlN2bIopeBQ+PRHTL/iUeGoyT7ZkP4GB/AkYQ+3G9Vlg+z1s/WS?=
 =?us-ascii?Q?RLuXO5sAHqkaBZF7CNrxdG8CqHfedFMMJI4ch90KxgPoczyBNqNtBRnMle/2?=
 =?us-ascii?Q?+T7IMFZEOtmE0DBVM07EPbSrCqOFBG3cL9wP0glHpVM9esg3jI9uauQP43Dq?=
 =?us-ascii?Q?C72TOIgpxL4L2zQ3hMpvp3LCd3HxVSCjsoaiD6I/9hJb54gp+fzLxyY3OMq+?=
 =?us-ascii?Q?/skdlwR4l1s3pyp+21IExrVU+9zyE1s/Pm1iP0LQE1FRkMXSNRRLONHQpxM0?=
 =?us-ascii?Q?1QLfW/iE5HFkz6u1MdMPygYeGr0x6SlCuE7DTEXxmpBHOu1lU83jyUbIcbN6?=
 =?us-ascii?Q?8FC0GVVZOUFfXehgqYJbluPZpbK+AOtZSoE6abUGl7yUWISL/0/DbbURHsa4?=
 =?us-ascii?Q?PUr1+aqdTm5DQ0WKuy/U3F/lW6Zz6NM4GSdRceJF57awTr/tWAI/IXs558/D?=
 =?us-ascii?Q?cBfqMIAIcBeuc9aBNrHT4phccFkF6mT5h/1ABHyjthJprCwnrMXqFVvVOodR?=
 =?us-ascii?Q?hy2BI8b8FU3XczKgqyIo19VG7znmwELJKp2QSaaKSN8GFdmwnuGnVDUQyqZE?=
 =?us-ascii?Q?kgj6nkzIkhuAz4IU6b3bGMwKCUPTWIjLw3UB0uQEiXDoGvbrsVjrxZA6jxPv?=
 =?us-ascii?Q?kv2fmBIh8PR4rB3/cJwNG2xwjDG/ahbB9Bb/7j9cWDChWCYTvHkiFqm3WtEL?=
 =?us-ascii?Q?TE/uTZF5UZLASvfcKN9y8X7fQK3+u93MVUfpF7sKY+avhEAcA6G6S7qul4hH?=
 =?us-ascii?Q?JKBCAzll5P05s00d2VcFDLD0Ob/lZMYSH+ymoZuBvLa5+6yjUeiud1IqQtDt?=
 =?us-ascii?Q?Jn10hAdfUx+6S+QiQHcIujTu7wBcY0ns8YQOW4AU333E5hg0IcynOx2OVorr?=
 =?us-ascii?Q?+0IyRKPJnaNtyK7JqkMvw/lc8a3IOSvcKqbYEZhhLBU9K8UYLcG60E9M6CoN?=
 =?us-ascii?Q?c+wHL6ty1gsc9zInZV/O1/U9STqDxEiTCGCuUvkTzdFV5bDDeQ6Un70Ed2ZT?=
 =?us-ascii?Q?tOWfwcfahWIg4lhfECph33nb6EcCcYnuWDnXqvSykLzt+X+s4sMQupkf93Lb?=
 =?us-ascii?Q?VcVswSp9//A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DNSIlGus80o1B7IRmLl3qCddr/6Fe51MH78C8LsvLE/BVHR3TYYKKpowbSZ9?=
 =?us-ascii?Q?Bev+XS0uvK/TcIW6ok6jG95egOURq72zYOgLbRKfds2/17OSJ+yv4fWD/0/X?=
 =?us-ascii?Q?FxnZNIF3OEwrvJnYsiIgOX3QMDrRLzZ/+eSR+SRcS8vIkEWbgBgBV0sW3LxV?=
 =?us-ascii?Q?/Sy5uWg1f914/r6MBjDND5ta0L0NmegNXzcIjjvDvm6l9jS+37TU7gtPNv44?=
 =?us-ascii?Q?joNozm6Gfn4rtY57fB6Y06NWiE/fu6Ucskt2qR8bHiYi5amYccqQtaYomi5x?=
 =?us-ascii?Q?NeHQT8ziS5mjGuzWPnfW1G0UCvivBJlmXnIDAQMk7XxKMqGOkaFNhSd/1ohA?=
 =?us-ascii?Q?bqPUXKnez7Z9orLs/63eSlIys0y7N1jWQ2xVh3gZarH6n91XRE8+ajAul9wu?=
 =?us-ascii?Q?GR3ztlPxm8n7lVTVGOhkOCLh1+iiwnhMMB4Zp1Oe7apcxa6FS9sa2FfPfiWe?=
 =?us-ascii?Q?cONw+H/wVi4ssaryjYJ10PlBK/7iP/W8PteU3k5fP/tiTEy33f7fOQiJLBfW?=
 =?us-ascii?Q?4eseG5jSrX3CSJp/DcShci2lVFmFc2F/m9DOo3J0Phw710jmxi083Hb8Ukdh?=
 =?us-ascii?Q?8ejIbxs+V3QOhcmNPfhwt194Nv+Dngqlhm7AFsOug85mDz7hNGY5sFNZL+jv?=
 =?us-ascii?Q?xDeWNOafYIXgGKMPtwNnwA2rxquHex64vhya2sofMvEy01CbuZpN2dy5ahsg?=
 =?us-ascii?Q?WSSPM9hLtUnHVqxUlW6jpNS3bD3vx7lBgNztigNdcv/UDs4uYOzDGivRVmbg?=
 =?us-ascii?Q?L/XI5FAHlDU+WLfG1gh5GxjzmL3rOdJT1m0nxyqTqKeBRBG6tQ3hWU7P5g5D?=
 =?us-ascii?Q?9dHjbrE9egTUwVRZmB1vSVilATUgpC3p7sq4YpK+iI0FBRxmbNQhQoj0Sxhx?=
 =?us-ascii?Q?Ev1Obx2TJ8DFys9rnlthxlSDSV1bdk8GoQMB4Pq36kinHtao1SblJBRnfDWh?=
 =?us-ascii?Q?HP5XaMVp0GEAEVwt+2JtZNBLCxD52+lnwPdDy40OlutPKJRAl45b7BKsX98k?=
 =?us-ascii?Q?Nl/riouFDMSSwSDg7NRkNgR00r5FnJKq8l3WIQp/yR+ODGbpKx54d2cUOJLM?=
 =?us-ascii?Q?JnIhewQbdpWksNEkU+gAttFXEfezeexAa2A4VI4YA/ueighursmYOGFz6xgq?=
 =?us-ascii?Q?1Bv/sUdRkw5ryosBRhq8EviacPrRAAoZ7uZA7wJrPeQ6b3c+mPnFO769ReCE?=
 =?us-ascii?Q?lvxIQ2uk4V564ymT7HgP9LSim+ho6Sb6V4hJzsRqQB2wHqS74cm2zqbUozBa?=
 =?us-ascii?Q?UUrGqFVWKi+drua69QccRcJsFtmBRyxk+75H5cMuQvtCqsCNyhe9NwuPgmdp?=
 =?us-ascii?Q?Jas72bJJhBVUUZi/4VGGZeSFsT885lS008nUEqaOaKRk5rTcbxa/lKP6NNNj?=
 =?us-ascii?Q?QPfqUc+uftowkPvLXHmuqYvkvDcYYf89ENVQXnYGnoJZyCYNrFATC9vKqzRj?=
 =?us-ascii?Q?uPugHsyUd0sWdhvk3CF4GOChi/yEH8JQpGJX5Is661P9TDA5kMoBd96/GN6l?=
 =?us-ascii?Q?uGBk4BgszYRIyA/47M+kEyyNBeb0ZV5MgGijSDiqYp1qFzVdKUzUPws3Tkan?=
 =?us-ascii?Q?z8ho+HzcGURs5F/A//io3U9bvIASMRGC87bDaYkRbgnK7w1jClZwW5hhSAF/?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba687e8-4039-41d4-5c90-08dde51d3887
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:53:02.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feQaN+id3FcX8l2OdEdRcLPzxg3VuD2hdBbS5Q+SnpYUqmN2ZiWKEoBPdKEkQka53hypeR4kbV7iIkOQxP2iu+4Rrwan7kIseu20y9JujPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

After a PCIe device has established a secure link and session between a TEE
Security Manager (TSM) and its local Device Security Manager (DSM), the
device or its subfunctions are candidates to be bound to a private memory
context, a TVM. A PCIe device function interface assigned to a TVM is a TEE
Device Interface (TDI).

The pci_tsm_bind() requests the low-level TSM driver to associate the
device with private MMIO and private IOMMU context resources of a given TVM
represented by a @kvm argument. A device in the bound state corresponds to
the TDISP protocol LOCKED state and awaits validation by the TVM. It is a
'struct pci_tsm_link_ops' operation because, similar to IDE establishment,
it involves host side resource establishment and context setup on behalf of
the guest. It is also expected to be performed lazily to allow for
operation of the device in non-confidential "shared" context for pre-lock
configuration.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/tsm.c       | 95 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tsm.h | 30 +++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 092e81c5208c..302a974f3632 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -251,6 +251,99 @@ static int remove_fn(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
+/*
+ * Note, this helper only returns an error code and takes an argument for
+ * compatibility with the pci_walk_bus() callback prototype. pci_tsm_unbind()
+ * always succeeds.
+ */
+static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
+{
+	struct pci_tdi *tdi;
+	struct pci_tsm_pf0 *tsm_pf0;
+
+	lockdep_assert_held(&pci_tsm_rwsem);
+
+	if (!pdev->tsm)
+		return 0;
+
+	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	guard(mutex)(&tsm_pf0->lock);
+
+	tdi = pdev->tsm->tdi;
+	if (!tdi)
+		return 0;
+
+	pdev->tsm->ops->unbind(tdi);
+	pdev->tsm->tdi = NULL;
+
+	return 0;
+}
+
+void pci_tsm_unbind(struct pci_dev *pdev)
+{
+	guard(rwsem_read)(&pci_tsm_rwsem);
+	__pci_tsm_unbind(pdev, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_unbind);
+
+/**
+ * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
+ * @pdev: PCI device function to bind
+ * @kvm: Private memory attach context
+ * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ *
+ * Context: Caller is responsible for constraining the bind lifetime to the
+ * registered state of the device. For example, pci_tsm_bind() /
+ * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
+ */
+int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
+{
+	const struct pci_tsm_ops *ops;
+	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tdi *tdi;
+
+	if (!kvm)
+		return -EINVAL;
+
+	guard(rwsem_read)(&pci_tsm_rwsem);
+
+	if (!pdev->tsm)
+		return -EINVAL;
+
+	ops = pdev->tsm->ops;
+
+	if (!is_link_tsm(ops->owner))
+		return -ENXIO;
+
+	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	guard(mutex)(&tsm_pf0->lock);
+
+	/* Resolve races to bind a TDI */
+	if (pdev->tsm->tdi) {
+		if (pdev->tsm->tdi->kvm == kvm)
+			return 0;
+		else
+			return -EBUSY;
+	}
+
+	tdi = ops->bind(pdev, kvm, tdi_id);
+	if (IS_ERR(tdi))
+		return PTR_ERR(tdi);
+
+	pdev->tsm->tdi = tdi;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_bind);
+
+static void pci_tsm_unbind_all(struct pci_dev *pdev)
+{
+	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
+	__pci_tsm_unbind(pdev, NULL);
+}
+
 static void __pci_tsm_disconnect(struct pci_dev *pdev)
 {
 	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
@@ -259,6 +352,8 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
 	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
 	lockdep_assert_held_write(&pci_tsm_rwsem);
 
+	pci_tsm_unbind_all(pdev);
+
 	/*
 	 * disconnect() is uninterruptible as it may be called for device
 	 * teardown
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index e4f9ea4a54a9..337b566adfc5 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -5,6 +5,8 @@
 #include <linux/pci.h>
 
 struct pci_tsm;
+struct kvm;
+enum pci_tsm_req_scope;
 
 /*
  * struct pci_tsm_ops - manage confidential links and security state
@@ -29,18 +31,25 @@ struct pci_tsm_ops {
 	 * @connect: establish / validate a secure connection (e.g. IDE)
 	 *	     with the device
 	 * @disconnect: teardown the secure link
+	 * @bind: bind a TDI in preparation for it to be accepted by a TVM
+	 * @unbind: remove a TDI from secure operation with a TVM
 	 *
 	 * Context: @probe, @remove, @connect, and @disconnect run under
 	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
 	 * mutual exclusion of @connect and @disconnect. @connect and
 	 * @disconnect additionally run under the DSM lock (struct
 	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
+	 * @bind and @unbind run under pci_tsm_rwsem held for read and the DSM
+	 * lock.
 	 */
 	struct_group_tagged(pci_tsm_link_ops, link_ops,
 		struct pci_tsm *(*probe)(struct pci_dev *pdev);
 		void (*remove)(struct pci_tsm *tsm);
 		int (*connect)(struct pci_dev *pdev);
 		void (*disconnect)(struct pci_dev *pdev);
+		struct pci_tdi *(*bind)(struct pci_dev *pdev,
+					struct kvm *kvm, u32 tdi_id);
+		void (*unbind)(struct pci_tdi *tdi);
 	);
 
 	/*
@@ -58,10 +67,21 @@ struct pci_tsm_ops {
 	struct tsm_dev *owner;
 };
 
+/**
+ * struct pci_tdi - Core TEE I/O Device Interface (TDI) context
+ * @pdev: host side representation of guest-side TDI
+ * @kvm: TEE VM context of bound TDI
+ */
+struct pci_tdi {
+	struct pci_dev *pdev;
+	struct kvm *kvm;
+};
+
 /**
  * struct pci_tsm - Core TSM context for a given PCIe endpoint
  * @pdev: Back ref to device function, distinguishes type of pci_tsm context
  * @dsm: PCI Device Security Manager for link operations on @pdev
+ * @tdi: TDI context established by the @bind link operation
  * @ops: Link Confidentiality or Device Function Security operations
  *
  * This structure is wrapped by low level TSM driver data and returned by
@@ -77,6 +97,7 @@ struct pci_tsm_ops {
 struct pci_tsm {
 	struct pci_dev *pdev;
 	struct pci_dev *dsm;
+	struct pci_tdi *tdi;
 	const struct pci_tsm_ops *ops;
 };
 
@@ -131,6 +152,8 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
 int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 			    const struct pci_tsm_ops *ops);
 void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
+int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
+void pci_tsm_unbind(struct pci_dev *pdev);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
@@ -139,5 +162,12 @@ static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
 {
 }
+static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
+{
+	return -ENXIO;
+}
+static inline void pci_tsm_unbind(struct pci_dev *pdev)
+{
+}
 #endif
 #endif /*__PCI_TSM_H */

base-commit: 4de43c0eb5d83004edf891b974371572e3815126
-- 
2.50.1


