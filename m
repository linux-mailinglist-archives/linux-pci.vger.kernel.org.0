Return-Path: <linux-pci+bounces-13131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C974977025
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 20:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C0B1C23D38
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572D91BE874;
	Thu, 12 Sep 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdkN47Tw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9831AD259
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164629; cv=fail; b=TF0BGpJfyGSsuJjytUyedIL6arqE+b6Favn79tmaUT0b1iXn+JmuqmuKaNlCaIkYl6WEoA6SBVLzWT/ipxJ7m97Uv7uGvpBZG4PU65cMAvsB/Z8gS54MgwN8CvVG+LyomHYm4uhdqx1K2htlPoWgkiQqbwQXGtZ9VhREI7gKp1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164629; c=relaxed/simple;
	bh=yPV+HwHf+CWYy54mCOBqcoA0jNzhdLEtIupNqvUyCfI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bMsZbnfPI6Dp+UTRGLI6rXFHIHZhJSOIt8gfNFh49jop9FlBRrIyTrlXN2Z/OE5NP8+Au0zcTQ6FW23rcVV5cZi39gR7JaZjvkYFxGY307tfZDwkKXLQYHjXAh9JTDpnBMxF6s+D4FPpalvorXrUKzhJ/nco3uUHFDXS3sl5Q+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdkN47Tw; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164628; x=1757700628;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yPV+HwHf+CWYy54mCOBqcoA0jNzhdLEtIupNqvUyCfI=;
  b=TdkN47Twx5pedx5XThLj3cwVDKVCX00NDlWIU+3gO3H2zWNldsyGH/EP
   2cK6F/NKqlHfQ/eU4Jrk59OZsLr+LOScW3LScBJRUHNDYyfCZL35gvYWS
   ZPM5qAq/iA8v+NWrFA+PqnikUqWIh8mdUDd2aBPSjBrTzwbGwFMcfbcIQ
   isIQTqzIZtd1LwosIEybI8Ews3WNppebvp0tWsTYXK38WvEcFbSG8yR0i
   mWU5jdJWwmoQHzTGTBUxz3aWA5mUG/NuDyrvRr4oPaJdd/ednzEZn+Fa/
   Y7cC1s/4OseajC4l5pGnaYlQN/SmmtpdSn15hpD6I/Eqm9mnTe54YJQG1
   Q==;
X-CSE-ConnectionGUID: /Vn2sQQVQG+B78BEoYM/Zg==
X-CSE-MsgGUID: IzkM76UvSm2csCEhc8/PXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25166576"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="25166576"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:10:28 -0700
X-CSE-ConnectionGUID: Ke+fOZyoQH23hmBs/yKj4A==
X-CSE-MsgGUID: fkUniuhTTuirwgBANrDqNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="98489510"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 11:10:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 11:10:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 11:10:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 11:10:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 11:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rfd2pZ0iNR9UeOtN5Z6d+vtgwAw3sN+t3jVPTyC/60CYAq4xYH4m3Tr1syudnjyek49te2BrUvFTEaOAbsoBdYcWcSSpQxAyFrSyb4oRXCyHJ2ofIbsH1QmeFBR7Exd7X2/sE0alMP9/GuEJJsyc7pyqzKO8iy8PxcAtUaOw1sgTT/ruV07R9LDhDi71uV1YmMuqPzONxbjSX8yqg66USbDldmF3rWGFvLybTQJiT4vmvX3atL7M9inMsGb7cKbo97Ea+KJPpqpKegHD47GDHwdx692NC0DahJeZLXdeNjYNymBESh7rEe6+Fc7ClSQ16AZW+urdAsVKLzavXOmtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPV+HwHf+CWYy54mCOBqcoA0jNzhdLEtIupNqvUyCfI=;
 b=Z0c2BUMLqynm3JM5sDrRfwAv/paJMAzys4PYvazSM5IWc8LTSl3UmCZxgGe+Qo4MAj7rE7ZoTzbNi1luZQmt+sL4ZvkTTRfHtTTR2XxZguZ+uKHBvulBWfrRH9SyTNUNXzpLg081yBU8WuONrr/PQkCVKU5OY4epXZ0sQBz7rFmvvPYuT4RqwZ2INdtlHy3K+9XENuUnQogYBLgE4QbEpDoOq+MoUOSMu7MbXYDKiSG2SPAYohQm/blhMaE1xldE15eXqcOHIJivTWwCjoFJUtlpF6RaRfe4AUixbFH3VDlnlTqM0E4/cP1pTkjY0Cla50Cpr3UFyc7dDHNDNt9Wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8099.namprd11.prod.outlook.com (2603:10b6:208:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 18:10:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 18:10:23 +0000
Date: Thu, 12 Sep 2024 11:10:21 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Nirmal Patel <nirmal.patel@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<paul.m.stillwell.jr@intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD sub-devices
Message-ID: <66e32e8d5e19a_3263b29452@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
 <20240822094806.2tg2pe6m75ekuc7g@thinkpad>
 <20240822113010.000059a1@linux.intel.com>
 <20240912143657.sgigcoj2lkedwfu4@thinkpad>
 <66e320bd9c800_3263b29421@dwillia2-xfh.jf.intel.com.notmuch>
 <20240912172534.ma3jc7po3ca2ytlh@thinkpad>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240912172534.ma3jc7po3ca2ytlh@thinkpad>
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 673d3752-a6e6-422b-2c10-08dcd3562bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?whwztBEs0l7eSRZBA9fDTnrdUasc38hPLq8h4EH0KV6OV2huqDRILrcOkjd/?=
 =?us-ascii?Q?HTXDQBpZ5dZXNzBjA2K8sTpwoCS+pIXWhBXO9+80CSs5oOfVEl46mrL1X5k5?=
 =?us-ascii?Q?UVlX6QGrdeNCpMzct8KQvf2f8IPq+IEVzaQQu11rTALHkAxjB8G7zntdy+S1?=
 =?us-ascii?Q?NjOdYcJr51M0sA/kc1l/19KfRFqUqYlU7mj6dju5bhDOFK5WAAtONm68fTfm?=
 =?us-ascii?Q?QKXWrJ1iJDNBBURMs9KWbRdwO1TGwNdhE/i8sFKhF07FmqHyaq6LLAndLW3k?=
 =?us-ascii?Q?5kwAKynFKv3nfIuoQQ9MSeE2bTpA85aTvKooT+h1s9d2knNnnkTy12ghbKAC?=
 =?us-ascii?Q?VFRvdA+1JI/nMcTAhvktl2jczol3OE1jowqwR+y6U77QnzB66H/5ZqvTEggS?=
 =?us-ascii?Q?2yx1uRKVE6GWWlmO32GhRDIQJbh4/O7C75I2PD4+9iQ0sbWBY5q0fZ7/NOE4?=
 =?us-ascii?Q?WBGLK1dG+jspdSYbh5xgPnhAt+oixnZp3WjJcLIhFJ8BaKIMtPHnVQEKd46N?=
 =?us-ascii?Q?quDFFCfh5HuLJsQqaR2o1wKV5EKyfo/EnP33EiFTI0l8qCWKkDB2rHc6eU1Y?=
 =?us-ascii?Q?YUgtuuk8h2cdGdidBeqGX3BzmNLF76rihaOWobBf0qeltalAlFNjXg3v9Va6?=
 =?us-ascii?Q?pGdtu9udTwyw09i3aJ0wqfT1MjLWpv2eW0sa+8/1K4ObrY2v+pn1RIs4FLg5?=
 =?us-ascii?Q?7Y1cVk3H+/p6VFJOM83J4HtgRwQ78Zjy7TucF45ceYzDZEZ8rHFoAF1nyfki?=
 =?us-ascii?Q?zhEuVCYf+TurZetbe5X59srcOKcP4+Zu4BOevF2IUNRSjf20n/S90OJL5uXB?=
 =?us-ascii?Q?CLTSs0yMCefpnu4hX9WUwblQLIO5Ye/gnYU9eIG/yUjellQxolyXZOwRQOY8?=
 =?us-ascii?Q?sMXKvSXNPc8Mu1mozpA6Cqd6Ogzc+RwKgk+qFWi+1bq/41rp4pjvBoJ+IO4H?=
 =?us-ascii?Q?xbNYZ2+yl8vBnmkBamkh/599PpO4VwVuXqrwTVaa5b6DRC7F8cxdy+mze/b4?=
 =?us-ascii?Q?soFvCuRTHw5zJl3FP6RvAlwRyg08XkdeicHxYtrRmUa2EdkKqwszkBcj9J2L?=
 =?us-ascii?Q?IJ8ia7M0yoYuCMcLNw5fe6LkZVZz/aKJKSZDMju/Z01fXmtYMEm+Q4YRiJvJ?=
 =?us-ascii?Q?QUh1gq91gg6oj+Tc7JperQGFw2GTEQyx9doU6U84x/X9w5aqnyGKScTtCi3/?=
 =?us-ascii?Q?HwgE5rwJO1QXc894dAdbD+VYVEITk75YTG0UVYo+vFgQ7hQSWw3297fGapJt?=
 =?us-ascii?Q?opARg+VBqDvT96QSvpuj9tqFh2Y7a1/yFWIc2ZpHREDDwAgTszj7gkV+IMid?=
 =?us-ascii?Q?+bG3ze5Bumv+Oe8EJ6gZAHu23hxBp8dg2FBJd1tWVEXkqQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4JbbNVfJC/JDIMu75rnW9NLukPJONCdvN91+7sA0qz0cpXD4l0g6I8GfE7Ga?=
 =?us-ascii?Q?Dxv0/+s/sVPOWiJctzHOpg59BaiQD3MDlq9jcv/7bRQmWMjyXMQiCmeSj4Pm?=
 =?us-ascii?Q?uNsr77i8/XPTuhN4U5oABAxMnymYjNWtO2MW7bBmmhqgMtAtb+teT7vL8q6k?=
 =?us-ascii?Q?xPqold3spFFKd2pD3cosgsLJ+VxpQ+kE4dPWU3CGsi7aLtjlKJzrb7uifyce?=
 =?us-ascii?Q?qc68426CWLLlkBG6sgpEJTW90GTaK37TCxkWZ93US/GJSiQez/h7DgWQqSdD?=
 =?us-ascii?Q?YSYw1o4I9ZzvckOntoHBhG2h+2EVelDug4l5sHaus/saOFtkrOPQjz2FnCiO?=
 =?us-ascii?Q?HlSYg9ZUBfacnCDDsc+7TRbVh9Ukw40dwvNhie6RYNm3vQRgT2lwQroo8fdX?=
 =?us-ascii?Q?vb5RW5ji6nmtC6LrGILPVvASQjWKrrFEWosW4GYDQE/l3KdxU5y8RF1kw+fp?=
 =?us-ascii?Q?HCYdermPjfTk131VNEiaqnDAjXhjyxmhKrUcF2m3q/mCbFN6sBlppC0MWFBm?=
 =?us-ascii?Q?TSkJ/4Q9gNj/Momwv1NhMNaKa+3xosZtpAhqxE4vAxK5vfYaBGc5djoTYQcU?=
 =?us-ascii?Q?9Th3YnR+1ZZYN/ouqmk4nN6Fv6Ts7/f0cLdBCcKBLo+tuYdRb/UtCPbBC9tj?=
 =?us-ascii?Q?WPn2D5SLSK8PB5thM+HsEsyKxmxkCy/Rfut//7N3sqyBnuSAVPU2AjSUumQi?=
 =?us-ascii?Q?NFl8TdRr5ChYPqZTHgDVQ3LvSwagJ8+yQrMRlt9WjrFyxm8acYTa4MaNwpxr?=
 =?us-ascii?Q?t+A+9XKriFLys5HfxGUnkLJ7qfmqofo9F2PHch4UdO+zem83R3nb+Ywrg+hb?=
 =?us-ascii?Q?7VDwveOI9XxVuq9il7wO6CfRL2V8tYEIehL/YY54GqLSkOR/1LxDoOs9x9xA?=
 =?us-ascii?Q?Hx0PTJvGmm4pjqUQT4IYwNygMJqMQ1Yosl61Hd8sxCh/lcJZo6PUZrOzY2BO?=
 =?us-ascii?Q?bwWN1voywHm7EhcpsW020OX5V/Wt0wHHbDz7o8/ioY5IrSrGUliiObmkx45g?=
 =?us-ascii?Q?9FCCIWSt2H+u6BrXSOAVntPsXxlkZ8H9KaRg+6mhIf6XshMuyzPh7I8/Q1+l?=
 =?us-ascii?Q?uIjraIZafuCKGf/d/t1CruNT3HeeDPYxF5TY/9fnCYcSAy74sb9vlmXDfFNj?=
 =?us-ascii?Q?c3eUI7K1bhBoU3TvYxY4aEFoM54ilxFUVNhEA0RriSEyuuyvGXZHR/GNRGBN?=
 =?us-ascii?Q?OMO+GrjWccxvCQP2+3siNe8AKJ3wVfAIznr9HLemdU00rAyVSro1eQNK9Y3l?=
 =?us-ascii?Q?5K9rIKQTzz/HhvQJXBfAMRStHiHmb3YoR3r8gDm/B9eNzl6pKY6zy7nrHKRX?=
 =?us-ascii?Q?rAUwubiByF0Lo5Z/10lvixpZtby5dfRNSfPElz4YqfkNT6Z7INqBI6B/kNU5?=
 =?us-ascii?Q?lFGY8EgoqwBNEeBOyogxIkO22008ecNc/Kl9bxrEEequ5/tS+cUy8kciDCeU?=
 =?us-ascii?Q?A+ErnVT8wNKIHDdxKiLSjuZw7o59JrdOknrH+WYk73o6vvxGtEFk3NU2t02V?=
 =?us-ascii?Q?W0K3pNnpQqDUQblczH4C3DMn/QeVxJmO+unguiZJ7obDC7J+B0SoO9xjT/pK?=
 =?us-ascii?Q?tUN0n2idTxWBZ7Gyi/YjMkiacibr8uzH5GMQvVJCAel1mLQIR6Abhi9bY8tY?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 673d3752-a6e6-422b-2c10-08dcd3562bc4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 18:10:23.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzgZi0oQtPnBkhkrWlcdgT0K8V/fP70m0iRbLFKd7w3CmzPzUY4oAe6H5HXu3df9DjmmGEWGAMgV+/1cZ3K1rh+IKk7pRguqQjzz+HRtlbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8099
X-OriginatorOrg: intel.com

Manivannan Sadhasivam wrote:
[..]
> I don't think the issue should be constrained to VMD only. Based on my
> conversation with Nirmal [1], I understood that it is SPDK that makes wrong
> assumption if the device's PCI_INTERRUPT_LINE is non-zero (and I assumed that
> other application could do the same).

I am skeptical one can find an example of an application that gets
similarly confused. SPDK is not a typical consumer of PCI device
information.

> In that case, how it can be classified as the "idiosyncracy" of VMD?

If VMD were a typical PCIe switch, firmware would have already fixed up
these values. In fact this problem could likely also be fixed in
platform firmware, but the history of VMD is to leak workaround after
workaround into the kernel.

> SPDK is not tied to VMD, isn't it?

It is not, but SPDK replaces significant pieces of the kernel with
userspace drivers. In this respect a VMD driver quirk in SPDK is no
different than the NVME driver quirks it already needs to carry in its
userspace NVME driver.

Now, if you told me that the damage was more widespread than a project
that is meant to replace kernel drivers, then a kernel fix should be
explored. Until then, let SPDK carry the quirk until it becomes clear
that there are practical examples of wider damage.

