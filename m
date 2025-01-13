Return-Path: <linux-pci+bounces-19702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA9AA0C5DD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 00:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A9D169881
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 23:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471161F9EAA;
	Mon, 13 Jan 2025 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PftKLirT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB761160884;
	Mon, 13 Jan 2025 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736812190; cv=fail; b=RGGw398Gp1k0m19OdCVFRwj3pHBlQS89NpasNkok/wlBtKNP+XS1Qzw5DekjIT7QCw1QuXk4RpgOiqGx80m/Q6b/6eQawIVTMzy0thSfgyTDPPBLQd0Il3oJjC35ICBQxGP7aFi0nmASltFs6U78yzEtzWaydsjOS6o82+LmEps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736812190; c=relaxed/simple;
	bh=iAy29D5Uh+0o3OFVo+2by+l+ju36pNuBko6rkqcKydw=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=McgWZwPRPbowbGRp7h2W5qSBcnSUdpEnw3UGp+ZzeRcoUmEBPOOaPXMfSTgQhoWl36PonPjCEbSQ/5hQO/hPNDoSN8X3DXCvNXcI6LBq8riiZV4vGZdJ0A1uABgMuLPcdMFs30rkn3Fg9RxCvcAflei4jaorz1grQrrp22G0Tsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PftKLirT; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736812188; x=1768348188;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=iAy29D5Uh+0o3OFVo+2by+l+ju36pNuBko6rkqcKydw=;
  b=PftKLirTnpIHmblZcS57pzJAcw9Ad1MWJlcbRH4LEOMBq3Ylt+enAQIy
   AhhyB2L6vPWtfvlNTMl17AZfCsKhxEPWNXlpWwnV8b2QcJkg60Z5ePifu
   ZnlG/fc549p9sps1BFvVUCPPZm+aG2Gts6EbSOz+Ja75pY5BCtfyhiLKK
   Bbpafnx48l9y3wGHZnasbeVUSkOTab2Mt+W/+u+ixORXI/I3TsjRcbbD5
   qbU3tGam8IgJUkC/rbOMgdSYPHoYciJIWP/hWFs1NQHQN7yG0wOqqqPuY
   6Vq1cMg+sRMfs7Kfbuyp/9ut3keXDA9IE0Cp02m+ztsqsCvFPUlR+09lE
   A==;
X-CSE-ConnectionGUID: S1u8BdNZRje/NKIazB5zSg==
X-CSE-MsgGUID: hI8RUIE9T46Paoupzrr5gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="62467896"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="62467896"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 15:49:47 -0800
X-CSE-ConnectionGUID: 9DHr8Uo9TziPXy0K3Y6Vjg==
X-CSE-MsgGUID: empD03ifSnafyKEKOuMHHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108685755"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 15:49:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 15:49:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 15:49:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 15:49:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hN233FVMskptQU8J6Rb+FjVHqVTZtPUGgogst7w9z/ZJP9DCo7PwHb5l2mIZjry9WuUv+sPyypT08ZbJXddYrtesEODAXjIJyXQZ5eoOiO0ZF2jR/Zy5qLnb9NSOsUmeQES6+kcJUJj4jVKvLmd6lsZhASK/KpTmwD9FLXWdyxWXbrUDaqX64K3FIkwSt8t1nY9b2JKxzr7N0zBGgIcOSROOyKBv5iAB8+0FWkD5GYn3YwYBKCfWQ0STVaoeHZ9hiUpmnpOMQ0Xz398e6OnPvc43T3KEq+Z1GlGU8BBWHE+LCcHgmqfTut3zMIgipZOcbvYP6JL8CKnxiS60cVvjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O53wEq0jAEWUz8UzmXbO4rMmj2+wm7Fv11umPQWZ9aM=;
 b=xyPtVBXyRIJEE/5o/iD2XeZlb8cYCQ2Ufstjx7VE0HRc050z0+2Tt/+oPK9SzTNRjAR7rYzxuJx+CDxDJ0s4kBP87s/RVQUlEtfrhHg4+CeT3CvQybAkp46Km56M/1JPpSjDreGxmIWFIgwL0En+d24vTIwC8jRZ1d+dqT4CKUaJ1rwmT7qRK2ckShwmjnj5wl/6V4LrzJRj2WRC2VP3LFirxKRGgu/VcSmsUSMCKn00ur3xNztfGjMRYQlGOoXt+dzvWwDJKysyQsYm4bRbz7j0+MP00836X20LYQOJv7F+SIV2nYwv3hrTZF2D5CnKO+jEUQ8UG2nboflX/h4usA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6884.namprd11.prod.outlook.com (2603:10b6:510:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 23:49:43 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Mon, 13 Jan 2025
 23:49:43 +0000
Date: Mon, 13 Jan 2025 17:49:37 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 03/16] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
Message-ID: <6785a691b56f2_186d9b2942@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-4-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0436650e-b95f-4471-b93b-08dd342cf42d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oYE9af2dNdV3jh8MP+Ear7ULr4Rd9JFhLVdr5H0sNE5GFsm/jU4C7vwv7B8b?=
 =?us-ascii?Q?Fb227N8XUmRYp6NZEs7D5EKnPd7IsxvevzROVag4RkRHNQCyBvUXNHGy+LXw?=
 =?us-ascii?Q?7UhaD2HvyK8IOsL8hjMhlSxwsLEVVL6UVKfjik/aKNIoVVH9BNBcM0Cjji0+?=
 =?us-ascii?Q?d6MH7B27YTZE1LJDriqlEZdekBwQ+FyjBR3ZoMoz6I2xmQn+9ttTLbQ966Pt?=
 =?us-ascii?Q?UrGmrLYS/43GzSz1S7dmuvV1KmaWV53kqpIXETSXOwWNbg+QLlx6U+MAngTz?=
 =?us-ascii?Q?wA0MAseL2s2vYlCwuqztk1TXnVeaynmArBKnwZoLEWks4lmS32bj0lhOjtWx?=
 =?us-ascii?Q?IqAXWmuCuS1deqB3Ah9YZ1ba3vD0xbvt93f22i1JJWBFJwKazW8qpwlKw9vn?=
 =?us-ascii?Q?oVX/qO1rI3j4Fe6vrxDJ96gpetEbxOthkM27N6M459wyY40K1clOdwNnx/2D?=
 =?us-ascii?Q?dc47VuG+Sq0M67dzQQxhNiyBPVsUjmdMksmhI2yxE9qdfWyfNDeZb7ohMixw?=
 =?us-ascii?Q?PeHgBkVTqJuZbnVv8YtiN89siHWimD9DyUBAZZ6VRnmbni3xEw16d+wGKQ90?=
 =?us-ascii?Q?h/wpd4xcsqDQvU7pHIqCxJNRZvRYP2X3I2AVdcjbS0Y3kVbTZjoQtFDCByds?=
 =?us-ascii?Q?AdtrUmo9dkHdCHDYaKECa84AVRVeVLS7GmsJN5I6ERmKVw0uDmh4MGMRZk6m?=
 =?us-ascii?Q?vFhqipr7Zb41P3o6HleCzfH7fOEU/BEfJTgCWUN44qVGDCxqYPLf7UGCp5MG?=
 =?us-ascii?Q?g3BRy2Tgy/IUuWA31gDA9qJQ+SEQc7+ZDxRB+/ImAfsUxJPqekN6j5mnQfGF?=
 =?us-ascii?Q?RjRDcliKFCoxp0nSxfPF4eZJxdbBTflK9fkLkzBu2sCuMyK+pjCqIxL1XaVW?=
 =?us-ascii?Q?eVz5le5rNJbK7NB5gDjV7hkSv5/srZ9p6uXXlQeWVtqe8lSvGV9/GNVtKEOm?=
 =?us-ascii?Q?6ob2zVr4zJfWuKvIMkEgTNdjAkkf/rtZOWn0NynKWFiOXqwoYzjV9gotK43T?=
 =?us-ascii?Q?+lmecTQJSZpUu7eCgY+n4GzZqzp3wJewIu1CtRwAu9ek2yyhInk1ldFrx5Ci?=
 =?us-ascii?Q?kH/J6H470B6eY8QSgr4ctIfflYmkBOxjTtR/ymYa5i75jIqd6P8l4vVZq5gH?=
 =?us-ascii?Q?zAcn59+mVKi4UhmQ0nYWLDhzpU6pn6p3f4vufSJ4nC3hUj2D9dhy+JwK7vtZ?=
 =?us-ascii?Q?NR2A4u4DqbxL5ZgWUzNXxJVXFG3ilCxjiLFT689Nn20HF3E3NSWOCiRKUEc8?=
 =?us-ascii?Q?2fB/4UTsSENpJZb0fyCVZ0HINTOPwQywMpHUvK0eD5HJrwsxKV9RfFobLkJB?=
 =?us-ascii?Q?DuGncfLYMJvKxQfkH9AQ4IETpLXPMpqY3RKnDIFnZP+iG7g8z14hySnOdxck?=
 =?us-ascii?Q?ZIvH5lS97zDRugXu6duX8x0LgUWfc5bYODehHNJQRu0xaZfgj74lEHEzqOsD?=
 =?us-ascii?Q?05inJI9o5Io=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HRYXWLInj1ykvxZ/AdPUsa/mrnkj5AppFTXPXI3e6NiiG+au1Ra8x9WUhGvu?=
 =?us-ascii?Q?rEVT6SRyvv7RLYSI+M/qS610rmdEjradmdJwZalBOacCR0/ZUYuW+hiUCKkP?=
 =?us-ascii?Q?sfH+XiKy+Pp15+AZKX+OLlwG9YGNeLqsKSqWqjkHNq2sSC0swD0bvWUnTeHR?=
 =?us-ascii?Q?6YdHWAKilYLEd6NzkjcIzC3sjHDmFVf/x0IOby28zqO2a5hc0v0Fwe3m7Bi2?=
 =?us-ascii?Q?IWJA1LkrDmwNHZJcwbf+yjTrs8pKXOOYtvYqvq+zno1R18dzcGVyroneD67m?=
 =?us-ascii?Q?vvwgNxJfbyobjokQx3xcW0F/k9IBsjYcvswIoQTtlqd014zrTIotgbULXp8g?=
 =?us-ascii?Q?FX47Htua++/1YqMZVD3Vr08knmV1MkkiyRsPlmJUwUMrCTXWNvbqG0K+Cl9N?=
 =?us-ascii?Q?b8OiZwldApx4m7Nt+8qme15Caf8gYOTqKNXvtxzuIXdEqquLBg4XtrHIPskk?=
 =?us-ascii?Q?l7X8U6udkvc8Ag/BbOSnbJdYkf8x3AWb+KlwWjhIPrGG7jghOhAJBI/pEcnH?=
 =?us-ascii?Q?O/sSKxp3katunaxDd98rn11kG7m1GVLy2qDEwL3vtebBN7osk4VixuQP0x4V?=
 =?us-ascii?Q?KvUb641gsh++XsT1avrzTNjWimRLA7rWLYXuylwUyU/iN9uSlMHnrHNHWeit?=
 =?us-ascii?Q?fNMdfBLmFDHFvJO+eimUjiaEAFRQzFbLj5m6fUrPmfI2WWMcmp8wlU237upV?=
 =?us-ascii?Q?f+b/YYG4lwgGAmn1Ugj9rMvyLx4Vvq1Qrpl6FKXfIXn5LBQVjl4QdcrY7iOE?=
 =?us-ascii?Q?39bJOGn4zknSDeU1KhaqsEA0XSLaZKU4tasvYpTvuuN9Z9biWJzhRqr0CXhB?=
 =?us-ascii?Q?ZKYPAPY3IxuemRc0MvEh3YhchHuVFiiQW0bvHxgvYtQdHnlXpn2UO1FMaEVJ?=
 =?us-ascii?Q?s3wEqkkvYO+VcuTPIXM2SaEzSvETS/x6Rmcr1hy7zA2GkG3pjL78oLzvrZr1?=
 =?us-ascii?Q?R4dT4PlXAGLYJ0d3Cb2ZGjEjMl1b2/EXkk2FDIn7FOnB30AkCJt19gmeoY/n?=
 =?us-ascii?Q?AFALtX5/MvV1K/SgLlHN2sg9yRbq7E6eVBJFHJLfLlQJkdcpedsqLTBwY4QO?=
 =?us-ascii?Q?HTuTdaSrEiK4aAFjat+FTYLW8N7Ug3p3eseQWq+6Eg3XWY6OjSwTKSjYL0GF?=
 =?us-ascii?Q?8LmsHFnyWQ3AY5TWjE91D3ZckrRlkYUqfnUTxFa10VqYrdB+c1t2Cz45CvP3?=
 =?us-ascii?Q?NgX0XkOQ1cLJH9duf7Bv2JpsTVlpkH5PRLq2/xvTPQIMxeUHKDX9xKCt0034?=
 =?us-ascii?Q?pSLRMh22jHG6VSsuPQRBdSbJNwqzbq7n89vptT1iTxzVC26jYZutgQ/aOiD/?=
 =?us-ascii?Q?l9u10GfLlPp7Y32LdmhAPJQ515O/LkRrwnB9XT9rEjNLpadwjxjjhX1on9KV?=
 =?us-ascii?Q?etL06J8RfeXcH568NW/fwYsoYjSpk2OuYKz/kEQFTVtYXzvz448pScdoVn+z?=
 =?us-ascii?Q?odTk1KgQuanrnIlahfdPGNRrMj6vf+k+US6HO76gBrU4uaLvMGlXZcxXB5B2?=
 =?us-ascii?Q?5bvQmzz3vtCqMBhjaHZfDiUIKRHndOqCYI9sLjw5ioLb7TC4qdEmVVM1D/L2?=
 =?us-ascii?Q?5WL68xUKSoJ2OmurdR8D/gcpggqisd76ERqUgMIQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0436650e-b95f-4471-b93b-08dd342cf42d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 23:49:43.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUq3TA99di4FXhTTuQ2eVYh2Jn4r1HycuoNskF+Uo66nHSB5ltOQrCVrvPyKfVuYilAeyBxKs9FdGHuLlINxKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6884
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices and CXL port
> devices.
> 
> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
> presence. The CXL Flexbus DVSEC presence is used because it is required
> for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> Flexbus presence.
> 
> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.
> 
> Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
> Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
> CXL Extensions DVSEC for Ports is present.[1]
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/pci/pci.c             | 13 +++++++++++++
>  drivers/pci/probe.c           | 10 ++++++++++
>  include/linux/pci.h           |  4 ++++
>  include/uapi/linux/pci_regs.h |  3 ++-
>  4 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 661f98c6c63a..9319c62e3488 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5036,10 +5036,23 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  
>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>  {
> +	if (!pcie_is_cxl(dev))
> +		return 0;
> +
>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>  					 PCI_DVSEC_CXL_PORT);
>  }
>  
> +bool pcie_is_cxl_port(struct pci_dev *dev)
> +{
> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
> +		return false;
> +
> +	return cxl_port_dvsec(dev);

Returning bool from a function which returns u16 is odd and I don't think
it should be coded this way.  I don't think it is wrong right now but this
really ought to code the pcie_is_cxl() here and leave cxl_port_dvsec()
alone.  Calling cxl_port_dvsec(), checking for if the dvsec exists, and
returning bool.

> +}
> +

[snip]

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e2e36f11205c..08350302b3e9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -452,6 +452,7 @@ struct pci_dev {
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially
>  	 * execute DMA attacks and similar. They are typically connected
> @@ -739,6 +740,9 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +#define pcie_is_cxl(dev) (dev->is_cxl)

This should be an inline function which takes struct pci_dev * for type
safety.

Ira

[snip]

