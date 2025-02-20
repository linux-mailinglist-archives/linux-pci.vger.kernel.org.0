Return-Path: <linux-pci+bounces-21863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD8BA3CFE7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 04:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090543BB3F9
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524021E1C36;
	Thu, 20 Feb 2025 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpLkAC5+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140011D79A6
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021007; cv=fail; b=Efug6zvs0PV1ZlCpg37hvh6FsbED1LiXog5sJuvD5/7nhExhU0i2e6LhrXc4brTOimC0TCbxRtlSWqyJMCw0wp2qABkj+UTQArR2AKS+XjM3uzaL/3yC29tCFvIOk2+En+3UGQh5qQ117CVlcup79HFeXWruxqBCbDfhBVRwlLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021007; c=relaxed/simple;
	bh=lf3pe7+pgkwqoYJMark8bLtct4BFDLVYtw68Qor2D1w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GQtX+6fw6Je30wpzSgfWTjQ2QEHCQv8IeWA0dZzYCmLM0l1GrO0NvG17Wa9SvXlIzZ5oHcmW9VaazWtT6Utw9z2TmZhSpvv2o1t2avTEIPjVQiMBs7VT87CsB8KMBv/SvalaNfHQG0v/fzaaq8TQjQHVT/od0DdlakF3UP8hR34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpLkAC5+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740021006; x=1771557006;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lf3pe7+pgkwqoYJMark8bLtct4BFDLVYtw68Qor2D1w=;
  b=MpLkAC5+rSPN7qP5/kYtOJlifTw9xnC6NME5axzdgoubWh7NYLTrRqZL
   U6+I5DqArEbR3u9C0c5GcEMY/XQx0aF/K8KvPPqsynCo1p+sqMB56gRDQ
   lFVg7qaw4Re6qq8t+1uBkgfvMggZTGKNvmrWKM+pLX9i2qTdlytYw0PRf
   rSo5O/0/Ric4cMp2WMG7Q8eu/0Y42HjBfqK8SsEa3BBkx+MPBAKVCuoVA
   YFcHzIrOOyxst4x9HKH62VIqN/YUcVkdtm1/TJsqTaxUKZ65nbRiSm/Kg
   PiiEgXmoUpiaZHigkrChUWWBZP7cfF+9VwX/i9QpH5ras+1K8bXyvMGrP
   g==;
X-CSE-ConnectionGUID: 94lAoAosSGS924oY7Sjh0Q==
X-CSE-MsgGUID: wzPFrSiISVq87BLTuNV2OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40905775"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40905775"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:10:05 -0800
X-CSE-ConnectionGUID: OLYv0Jx2SOGY8di3QX0FdA==
X-CSE-MsgGUID: M/f7iR0CS5WCL6aTi70nBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115107651"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:10:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 19:10:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 19:10:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 19:10:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWfqG+lDxkwXjAf43xCBgl9fNIvm6AoVjLlbfYuEh3c/E+/ewnChyMAjZ6IPWS4Yd2TdIG8N0RQILLCJiTMI7thfsaEOZ6LBbPc9CJfiMeqkv2k5yHTQrySFE/5T+ukmKUiAZrIGdJjL56boJxdQUKJYCOO1y/qkHOmLqA2zK49BQnY8uzpLzN3TymJJvSzGPa5B1+9arkb4xxwWG6gMyhhmR8OJi+jJYItrTt5aMZ92+ChnpuCoTIfxuF4AFuGLlUBm49XRlDYtoyI4zKd13+e7tC29wW+61iBGcYhlZvnGPBVIPJK2QZRcK5q7o1TCT3cqh9dhjeXLOWEEylEW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL17vFD/IbZC8Xj1+kVlLTVsjeWhTpzlvsVF4YyZ7+o=;
 b=MfsgCwa/g2+ejqfnWDOgUiSDVJV5i8j/pu3cQ+zTZt5jKXQoIOaAhs4iliOAmbL6WilVJljmcUGQAButoKiK7y5zlmqoN+mC1vVV0ldfNsxIObVe2OrqgjQcDwPtpQd2Zz9RIL1H7v13y0W7VfJqNdl2KwZcKM7Dhc6ZHNdPmk4I31O78kNeAj88GOBc8FFL9Gk23lpx0F7q7+ipIsGfGOvyfNtY2KMub/yvOQXzHdTAvkv0HkHBRHN93yorXA1yyST6L+hU6KgaaVuv8BcC2mb+fNnVUljAsnSuzk9yNsXH2cWQA7LVwRaiO50lSi2s49LwXsW9xCND3z/lYcwoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 03:10:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 03:10:00 +0000
Date: Wed, 19 Feb 2025 19:09:58 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: <linux-coco@lists.linux.dev>, Lukas Wunner <lukas@wunner.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Message-ID: <67b69d067c08d_2d2c2945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343743678.1074769.15403889527436764173.stgit@dwillia2-xfh.jf.intel.com>
 <37f7c14e-e104-0508-4a41-e62d9e36ec47@linux.intel.com>
 <67b69be755d6c_2d2c29440@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67b69be755d6c_2d2c29440@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 658c50ab-1c70-4651-9025-08dd515c103d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?WASdXyI2aN5aGTvo4qf6lIIByqDN/CCSMGwI1F2g0s9jSaJAJv0yK0iEU9?=
 =?iso-8859-1?Q?Y8/AsCwA2eAqrsYcrrXS6hbRNzJg90EjvfY8liW5uRm57TCLQfRYXThOXf?=
 =?iso-8859-1?Q?QO0wlvaaYQ+eaIMKA8w78SUaVsDz/JFPlsAQwLIjtlHz/ryd6y3XPnntMl?=
 =?iso-8859-1?Q?7hSEWrc0s/W7vpyEzPX3/IfbCsvYdIRgA0mrZXSBvdxXK5grs9kDRvnenk?=
 =?iso-8859-1?Q?1HDAznaGMm5yc3M1r665xN64RY7rkRV7gd3coyOznP4tVc2v4XpBRkfw0/?=
 =?iso-8859-1?Q?u/18VUb+t4wNOVslu1k75Pgvpbxe6lQNw7NMKCHoaldk3Pcom36c46jMMB?=
 =?iso-8859-1?Q?L+tPKiNFgsbuwau081Spwf5siOafqwHFiFAztJpPlH9EpWT/FeGGeZa5V0?=
 =?iso-8859-1?Q?QtDJlPOTtwAnvmwbv1JLMPY2gvGVpwItXWtwo4hxf8KvvLkV6Jspi5nGqB?=
 =?iso-8859-1?Q?qwRhPoPQu9tKH4Uz1Tx/WKlb/IL9CTLP3WnEWN8SG+WYZrkIWOdQOadLru?=
 =?iso-8859-1?Q?kIhH6BERdPPoP0LVlUULCrXXYBfc1z4Qn4zpUo1HKgmOa5Coe3WH5mEJxm?=
 =?iso-8859-1?Q?NBbx9Ph6jR6jOiyvkUJjcpaxdQxQqpncFiRSOtQfMPFDhqhWiw0/8iHjfH?=
 =?iso-8859-1?Q?uS/0BZARnBCEWgcdOutlQDstFqdZB/1dKhYCnnUkaJuiODvZ2PqSUr8DBH?=
 =?iso-8859-1?Q?bFPUlb8shMoYhp56VC3rlM6x+i3c+tUM/NOFT/r+poVuS3OBZ87l2NWD7i?=
 =?iso-8859-1?Q?WIkiyqY3dEZzlj8cKcrrCOWagPc5fm14FCYZVTeKNtus/CR0nj702fOfaU?=
 =?iso-8859-1?Q?pxy1DaxkIRRm9kiJbJmz/T4WAJiyNpWQmIZL8lGuOBVzBJSzqS1lK8fuLa?=
 =?iso-8859-1?Q?vPqZeF74pBiEx4qPbl9vDUroUVuIcKQLfQxp8tTXRgDwBhK3mdcnt7vOl2?=
 =?iso-8859-1?Q?9ddjY7NnxMxGO6uzYdYJjObHsVa36YXwl5AXbOoJMy2h3m8pgGvaMgdzHe?=
 =?iso-8859-1?Q?/jXJaqgEtE1+yyzTL9BKBO4cB542EZq+gPgD1rIKjtKoPdLYixfT2JO3bR?=
 =?iso-8859-1?Q?PbFnsOFWUcY05NlYLfD4vwM7RIzvS8McA/WeWeDgmo5KTQDQEiRX67nQGn?=
 =?iso-8859-1?Q?pmXyH+ECo/1nSPPSawwWqY3UpSafqddtQRB6s3DzeWzniuddiEtDzEhKHn?=
 =?iso-8859-1?Q?vsylOxE7kAenLg5yVWKsPkt+sVksxnEk+g3N5Qs6Ldj2ga4yssSf4f+NHH?=
 =?iso-8859-1?Q?zd7f5mZgT11V202NdGMrDcU6Hizl1rOM0E1KNhMLz4onpz9pHp9qj9FgQ7?=
 =?iso-8859-1?Q?2V1hqJ9ftkLRdCegvXP/AsN8rM09KZWHAnqml3uT8YSFFQagmPp3Q1M1PD?=
 =?iso-8859-1?Q?Th2rShLrYERolgcE50+195KMP51hVm9DKuCriniV8Vdz6fAby0Ykoe+Qn4?=
 =?iso-8859-1?Q?MFUI5H+S1oYkG8mc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?s5rLJW1c5wk3r3/yKWnt9vnTgFJgsFFKTkjUV+H99QZfyD2xk9UG2+mmQA?=
 =?iso-8859-1?Q?xznsuivMYOtNasAsqUbV0gQHRlmh/gXh5QnHRcIBXenjKwkCFczBRY7r0g?=
 =?iso-8859-1?Q?JzxrG6uHbx0Ud7pT0uhQRQl8qT4gEybQaU2wEEZ+JUcr8U6WxaLUXWDLGA?=
 =?iso-8859-1?Q?wrRLxlmzFLcmrMG0M9CyFLcg55tnJI3JQUA7in2Qhcgm3bat1IQGwVnRaj?=
 =?iso-8859-1?Q?0kf1OJuAQs3TCK6v2NMH5OPeaQVJOJY/OP2EmLjLEqKvB9Y4NMYZbTWA6S?=
 =?iso-8859-1?Q?n8Dws1Uy99qdgjyiv9q2J8Hpqd5w++gqj+9khU8zNLHpD6dbzBqBpCIxf9?=
 =?iso-8859-1?Q?ob2NllHXDe855jE3QxXnqogZmZpjb/SPqFnM0k0Ox+vX3UJAfh8IJowRqI?=
 =?iso-8859-1?Q?4I56MuBPubTr1DM4muiDHsUJERWh6j221IwuH/f98d2G3kNp4dXFn+2Zzy?=
 =?iso-8859-1?Q?va4NPGZQpvb51ICcXlODmLYUVSzYFU1oj7ZBJRx5j2TgadKNzn/JP3vUUA?=
 =?iso-8859-1?Q?Y3ukr1uV7vGQ+pr0p3vcizdZGZjGf5g0TpxiroBn/cD8iaP7tbDjaebZLy?=
 =?iso-8859-1?Q?5qV7KD8EU0eqNl5POYBGjx4MGNNjsnNQ89pUoF2CaJrozMflP8SMO6vGQO?=
 =?iso-8859-1?Q?Lidy2KOLqbQLA4Sv8+rgxjwXvOWxeJ8+8hdCb1GTsOyX9CE9vH7aqt625F?=
 =?iso-8859-1?Q?HXtIS8zfCfFO13ip23vcfbCL3ieWhRUqaIjfL9VQgsmNMji5Q3jzZCNGqJ?=
 =?iso-8859-1?Q?ue1G7Wp7Q+aZ4NzA5QtmnYH0iCTCtTzkm217BFGTQu7HLs7jsP/LXI7uFA?=
 =?iso-8859-1?Q?3wIg6rYLX49CfwzR26l1U0bLAXAphWmOU9oL4jk80jymzCtOSKQEmQE6OW?=
 =?iso-8859-1?Q?fqEl3JVPFGgkvJlrvQnKVlg/ntrJwXHkcctVjluEPil2anVv9zKGbK6RTm?=
 =?iso-8859-1?Q?+8dwXyOgF6FnB1KS55HeaHSWfskLCjqnp4ZgNuj2f/gHjEA/mfaWB45ztU?=
 =?iso-8859-1?Q?VCcHnrRxCHSIu6IrNuo4WRjiPxGOEmpS9u4vP7B1dpqVc7ODdEx6xWIorF?=
 =?iso-8859-1?Q?/Lm5lIWRzxS5N4rktb82tycVqp7nSXwN5/oB4yeAkghD10HEzHyO4W65Be?=
 =?iso-8859-1?Q?fXcZn4nnGMynmdXjLNS4jBHcs/FVeErF7nccv5q0vQ1HT9DtbCYmeOYOHi?=
 =?iso-8859-1?Q?k5rQujc53aaEqjdEgFhBmRA/QQPTUwArclgjJ3Kdg8LA6+vVQWNHEVUT1p?=
 =?iso-8859-1?Q?ZiZjaTz5bUORLtfv5F3QZdHKbGgmOta+2METyJvnIv/eGqf6iz/p6ySNAG?=
 =?iso-8859-1?Q?a2DbiJUVr7xfPr7IrApBpc1nZv5fksjmkutF+4dy/uTJmXhsdddrHQcQH8?=
 =?iso-8859-1?Q?HdZ7VyAarSFY1xGuOUTYse12jq3Ct12KwQTohqMFO6opI9D/40O+GnKN1C?=
 =?iso-8859-1?Q?gJzCsprnsD8rQ9bLnLLqMn9bUHMNdtFKGdqi30pBwEi9f5rHt3+o+A8Bja?=
 =?iso-8859-1?Q?7xb4wjv+U/y1rK8LSrZGeELlJks8PT14SoQ/4ojhPRqi0qgKRBCGYzl/2P?=
 =?iso-8859-1?Q?MnIxaXJ+3X+al1yDLt68yHyFL9Rd+IG7WTalkADg+uh7+b6rEq+cwurdYg?=
 =?iso-8859-1?Q?TjHUwSf5feWt8rsMWx64hWIp2sWc2vJBw0QmLgT389Pgot9WrPX2lkdA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 658c50ab-1c70-4651-9025-08dd515c103d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:10:00.8818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgYfZWGu/ekNWBqvVMcCa7o8ldLinbkHq0N1o/YC3A0o2Ig+3vcQX3xV9+US7E7LyJrP1pPo8ztUdb8N1c7ifJ8yMCLmQSswwn4VPMpLEAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ilpo Järvinen wrote:
> > On Thu, 5 Dec 2024, Dan Williams wrote:
> > 
> > > PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> > > enumerates new link capabilities and status added for Gen 6 devices. One
> > > of the link details enumerated in that register block is the "Segment
> > > Captured" status in the Device Status 3 register. That status is
> > > relevant for enabling IDE (Integrity & Data Encryption) whereby
> > > Selective IDE streams can be limited to a given requester id range
> > > within a given segment.
> > > 
> > > If a device has captured its Segment value then it knows that PCIe Flit
> > > Mode is enabled via all links in the path that a configuration write
> > > traversed. IDE establishment requires that "Segment Base" in
> > > IDE RID Association Register 2 (PCIe 6.2 Section 7.9.26.5.4.2) be
> > > programmed if the RID association mechanism is in effect.
> > > 
> > > When / if IDE + Flit Mode capable devices arrive, the PCI core needs to
> > > setup the segment base when using the RID association facility, but no
> > > known deployments today depend on this.
> > > 
> > > Cc: Lukas Wunner <lukas@wunner.de>
> > > Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > > Cc: Alexey Kardashevskiy <aik@amd.com>
> > > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> [..]
> > > @@ -1210,6 +1211,12 @@
> > >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> > >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> > >  
> > > +/* Device 3 Extended Capability */
> > > +#define PCI_DEV3_CAP		0x4	/* Device 3 Capabilities Register */
> > > +#define PCI_DEV3_CTL		0x8	/* Device 3 Control Register */
> > 
> > Should save/restore too be added for DEV3_CTL?
> 
> Good point, yes it should.

...although only when the kernel adds a use case to write to DEV3_CTL,
for now the use case is read-only for DEV3_CAP.



