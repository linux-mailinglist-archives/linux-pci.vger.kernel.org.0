Return-Path: <linux-pci+bounces-21864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DEBA3D003
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 04:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5831C17CA4E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 03:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7C1D5AB9;
	Thu, 20 Feb 2025 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwwGe1tn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61B10FD
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021457; cv=fail; b=qzYbNUcn8Maiv2wM+kpkUY2nU7GvfSQo5jSWRS03c5oCsNCZUi5wzevdB30fT+UOtXj6XuLJ2rKCX5ZpIM4b9A7xFtXGZBKohLRCjPspP/nYLq1WoEsECpLu4hB1VsKYcLM7OwRn3/hxlmQu1F4nljNRVC7I4NyESEZG11fvZ7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021457; c=relaxed/simple;
	bh=BmFvcymj1Orpu54kek+yJysxQPegqQDg1Dg+qvM473E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n/pUzpV+Gg1qITIGH1+tk7+zyV9PpztIeFsQFZqy4FB+Oj6HY2oHrUX9up5R4a1Ta1Pk0dRZxLsqclhgcfzWNQ9RsN6KuK6B4ndJVbkCjZM+3Aw5zrKM9OnAFVCu0ZeoWpjWA+k+fBcNpLqenQmJYsNot5tr9mhRtfxI5pcbT80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwwGe1tn; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740021456; x=1771557456;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BmFvcymj1Orpu54kek+yJysxQPegqQDg1Dg+qvM473E=;
  b=AwwGe1tnd3DV7zSmcT61wrudmauJxAphRJvsKF/SsF8OIoIfQluTAOUH
   voX5fHHBxFvQb+wlCJKttAsX8kJUxVIhoKA8zBjd0PqRXn28RgBJLpCQR
   +58Qx/7VbYLWzENgwTc1n5xlCjex4JlPS+ig3AHBYK//YMJERNMJTSbGc
   EqMjSeiJMyHljEWZVdPoKKywhfKMYfmffHu95uk9MBV94EgCYBdh92shw
   SiK217V7+MwhXdGSSISjTFfh53/lcfzSMb1GGfNiatLsaKfg7oqdenVaF
   KV/avnGQDolLU23nKrx9bYGGoQHhUaBwKvdkpboFg276/jNcYPOTFvPnd
   Q==;
X-CSE-ConnectionGUID: Gc+NpvRSQ9uHmsxSh/80Vg==
X-CSE-MsgGUID: 8BqTys+fTnC+9fqiIxRZGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40906469"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40906469"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:17:35 -0800
X-CSE-ConnectionGUID: h5kAqC/XRLGliU7tIeKU1A==
X-CSE-MsgGUID: 9GR9q+NvRJahyw6b34A/cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115108340"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:17:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 19:17:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 19:17:35 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 19:17:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRIKcgmLBulUl45r2akw1BW/GAL3/Qfv0qzENv0R6OO3v67FRUDLqGHyWGKSDu8WU6mpAUmO28A+JZwpEnrW1oI6Lrmz2edbT1I3v2nmk6hAi2AOe/1QWDSQEbuyUhWXWKsxAfOYk1baUr4hq+jqS9pvlkcsrvil8b3vPp+bIZfs4pIa0c1SqlZDwPdnVow+VKejFcbNqWYatDuN57pvthezY3jpQ0YdxKcnbUL9Olbs0n5YYOriPYQ7pSFrs+VvRb8tSUy8m7lxq3a2rlAzY78Hc0Z1kgT9paaBICzsxlvWluaUHMGBjj5hUdrC3Q/6vZN9GUzscUAUx68KpyOGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu/GNXK3CokFp0omLpq04/Qmu5xmjvhTu+LD310ReNM=;
 b=Mp4YRQ1oPYVbSj4euIauYlqyFYq0o68VDZgnbmlm6zVgNGKiQRR/raKL7FSyiSiiLnMpgUSmzkHJ9qlNxsvE1eL8HhPL97s9h250WQFKDEXXITpiVoB9AT+kMToT9MamXn/CYcHfNyZhFPX8Z98UtAFaO07E1zzP4kablqDny0h2Yi+6k4hr9EXqbnK829hCEK/v7/0I+sn8dcy6PyNbPm8RaCkf5ys5Fp0yMyJxCja81MGDO8kD8RBbBF3PsZS+frAXR5I4O3CjyBZpeubVDrgZbdtseKX3gR4KB/7i++WOMGIpsYq4k43z/QybUXagfIk3fCwo9OsP3r5Pr62p/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 03:17:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 03:17:18 +0000
Date: Wed, 19 Feb 2025 19:17:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Alexey Kardashevskiy <aik@amd.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <67b69ebcc26af_2d2c29470@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <yq5a34iw1bg6.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5a34iw1bg6.fsf@kernel.org>
X-ClientProxiedBy: MW4PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:303:b4::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0bd973-675c-45af-b52d-08dd515d1542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AxVDi/Qe49fg1tS/jKLIzTTPmtZl1YK2TswjrrVUwgBATBWaPVkQDyk8TlKS?=
 =?us-ascii?Q?EcblLMUe1akigdpP/6spVwPcxFq66gthoS4OJqta0l/AZliTTSjU7za5waBA?=
 =?us-ascii?Q?7O0D3Zbhxp99QTW8FxRpHOtd5zc/DuuQfd4jztTb8AdLAUDMy23AQldNpEjF?=
 =?us-ascii?Q?2masUvru8b1CjP/088LYG70ePgw9c1030Tu/uCPZOREvi3f0i73A3NRVjoUF?=
 =?us-ascii?Q?Bo2aa1guJuzvZ4I8SAYz6wZVpEAeTIWS0th4KkubXETg97eL14Ij4EB6+QT2?=
 =?us-ascii?Q?mIC6qXxoN/0NANv0E3GzxKGCO9OgfxPU6o4qsH/RegcNPhcY2vxIADGoLrSy?=
 =?us-ascii?Q?tXKYST+5cx4ZDxit1uFdlcb+ukfs2UGEPX4VNHNacU7pnDHohmSOBMAJZV/n?=
 =?us-ascii?Q?JDaNCItAmTQxQDMdK3h15QrkoF95+6+ofIYNEOO9pZbGgaTKzjKmE8W41tqI?=
 =?us-ascii?Q?E4FONwdNxXBQcxpKFi6RWGT8vU8IOsX0VLg4P4DKLwz1ka0+ddQhZNHOYrF4?=
 =?us-ascii?Q?TP+gUrCEGEEIQ2LhYeAyEh1oqbNUKHgxgR9XJRIJHrN6dXQsivalCzPHdsPj?=
 =?us-ascii?Q?y/sXhbqw6xya17Funu/IPcO1A/N0nNlp6S5DguYXVTDAg9sMmoU2LxMUiFkD?=
 =?us-ascii?Q?67aV0KYWeQOMRl+mg2skhkErQeE9OZ2H2JROfKWWvzFZzWupGjkMZAqbP9+8?=
 =?us-ascii?Q?k0UCNkJcLI2NlOBHet5eYIbVLImEmfXK3pgVaw0Rvp5Ha9jaunLYJr3FR+0D?=
 =?us-ascii?Q?vJiWgc1vRCVxFtTGi4IY9/I/zWZgVk6jDVagISmurpcRz7M/vQku9JtFyEvo?=
 =?us-ascii?Q?wfqcKk2m2n9dQ6oG5jSddX6Yp0rekPF+B3BHefDOdwR5LudxJf5oBgzGD9tZ?=
 =?us-ascii?Q?8wF6jo4kiSu2gw00mc9XTtCMvthpQ/CtcM4UZuzFjar1DIwu9BvLj/W5dPc7?=
 =?us-ascii?Q?LKwtnhSG9/RWzWH4+vuIftEB7GDHaSuRjv+FkwLSUTqMo3gjTR7hbzgLSYVA?=
 =?us-ascii?Q?4QTBt0neojMlNnXCqtW0jU0DSRRZaqJlM+N6r5UKxz042+IGGX+eccl8KZvX?=
 =?us-ascii?Q?sdPyPjpMYqM3IZqb1T5SPT2N6ED50V0bseDcMX9wB6EWJVajzX75m/j4SmNl?=
 =?us-ascii?Q?frjFebXOWXLew9BkRbZcqNQcfs8U3uJbQ+BI/JEw4CZl2E8Vmtj1dOKh7LQ5?=
 =?us-ascii?Q?pM7kRE508ni4Sx2mdSEMokx+vG89Cr5vPE47oEbhkER1VUP0G/iBcqNbx1Xk?=
 =?us-ascii?Q?/MeVDG+Dj5lM/c4clJT1ChV/u8X9LyOToWQMRZJTMlZNVx1aR4zsjO3x1QJn?=
 =?us-ascii?Q?jWhkN/CtOm1YxyS1KPg32wTFEcMN9bLCGhx6EtFHkgyeil6vqq5K+nlcgLL7?=
 =?us-ascii?Q?Qj/FT5+mhQQ64rRMj2krCay9rQne?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izAJvc7hjawP2cezjYnAd7DuSnesnGlwZLeJvtn0VfppVHAfePAyFX9MFcdg?=
 =?us-ascii?Q?8c4uASF7pUnTWSceqoItFU73QyIjB6jCRy27U1FbRId0wPcXr0m7tbx6Pe2Q?=
 =?us-ascii?Q?lUwxbPyqZzOuEA4e0V1VqEZLXSoZ08d3zN/0Wz2B/EmLviZGbpf7cPL1FQVp?=
 =?us-ascii?Q?LncTPY3YCPC/UyJreNlitnnbNnjv8PDHIji/KltloMQmSixy7VlmKDbzxkOs?=
 =?us-ascii?Q?ZPswZpfpMmBNOZJ0R3lgBVG5JaovskUz5QFc+nwvTJbqx+EhBncFvb4t6wC9?=
 =?us-ascii?Q?WvXbcPPU7P+2wcupjZIa0106u0Bg669IWmk4W8/Xb/2sMKYg7aWebcbxfcaJ?=
 =?us-ascii?Q?P0QvbBlYShU7gOIOm/zxtho6u/Xy5Twl9OiJQyd9YSvNRReinfcd7JxZOPtA?=
 =?us-ascii?Q?/t15jQRFJHlOZCQKa7MFl5hSxdJu/o9Fxf+g55nMcP8fTlIXhHD8dLvAXWP0?=
 =?us-ascii?Q?sxcJESNxmvJRpJLozSefTw+jUSr2ip3+YkErhMq7UcDhg8BnY/Llpcv6Qi/q?=
 =?us-ascii?Q?WeD4PPCAziIS1DKquapk+Z6kVew209HKFFqmNgBL0c7HPMIAvUx2RLrE4Vru?=
 =?us-ascii?Q?+TyJqU0QMjOTjswydZRQF+NJkbZLNY0rZYTelvPWT0Sn2giQtM9CI3GbHMi5?=
 =?us-ascii?Q?FyNPHTOdX/bdmC2MvnulfqK3WdyRb9jU97T+eFgMfaRxkcjgZn2xpnQCiwNe?=
 =?us-ascii?Q?UzUzAm6vavq0HPGnHXy8dhgTaGr8XacR+W0fmA1da4BkpwacXHE2Wg+hA7Gg?=
 =?us-ascii?Q?DGucNBN5Pq3X/j/z1jnlcQtAAATMFxokZnRlhSoY2Nf1KaHlsfEIl8q9zaKH?=
 =?us-ascii?Q?8vDCnsGmL+0SiYCSLty/aqTTeXetfzfwX/hq+kFwp3fFOjxdp14ogsAt1lOd?=
 =?us-ascii?Q?IPMzHUwzsg6Ygm2iZC8uWGz3+kS8kuCQIoR8NPgolIwTPRsCktXMgvOswACx?=
 =?us-ascii?Q?2+4ba5oBlIVRgyaT1LDV078yb6+YLkNYgxYD7c/CHXmL3YOoeC49tL+6Z37j?=
 =?us-ascii?Q?H1DmVbccXCsfC/vyHAXXr+SkeBAvnUFoFonhpiJabHGIEokSZVyzPlFl5tCk?=
 =?us-ascii?Q?MZ5rrSHnA3gloLSg2sCHIjtAN9xwdEtr3qv3WBZc+t2Xi4D5nzpxZY5wXWFS?=
 =?us-ascii?Q?wa4RHQWn8ENKmQEnEIO1x49OM4v0v8LLK5gXxaMN858LsA4L0xL6yBG9Jm2e?=
 =?us-ascii?Q?zZSwhz7yKMAWywfxCNyBQE0gusQbxjG1GQXx7HsftDTXtgqPpWlO9DzgP6bT?=
 =?us-ascii?Q?ZUV/Kx2KytbZbo8B1R3duywSV/rFx30/jpMJmY6r+KjbzJJIYV4+5TFe5n9Q?=
 =?us-ascii?Q?/TRwQMibZREdukKvMc1TvHQ7bUMkEkLuDCp/k6qcziH5b61dCEQI2EZDSCTL?=
 =?us-ascii?Q?3MDpznJ+EE7OgKea5qSAtoZxfj66DmnkkPDKCZxx7PF8Ej5PdQqPB5ESHzTZ?=
 =?us-ascii?Q?Fhx/uSHE3d8MHgCrmFuNkkkFmmaNKDQR2qzh2u8jIleIASIG5/LNUvOT3vzF?=
 =?us-ascii?Q?bu8rzh6NVKZLaiOXEgx7JZncrcyMYxYOAfUXBWieFNejY6nPn8UDjcg6iAGh?=
 =?us-ascii?Q?eeYZMnHrIuMTU6g/m5U+XDCPWR7BzT3zeeOfO5s8xN2Nyk/iop9FgcjZ+PUg?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0bd973-675c-45af-b52d-08dd515d1542
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:17:18.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ+KhD/FagENKZuxX2urcMnjMErD87fyj6FHam6tc9TabZg8w7xpVAfTxGB01oQmfwmLJgG8BPk2xQWuw8HdMw2U1WH1aFcVX8LZkDyxeWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> 
> Hi Dan,
> 
> > +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */
> 
> Should this be
> 
> #define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	((((x) >> 16) & 0xff) + 1) /* Selective IDE Streams */
> 
> We do loop as below in ide.c
> 
> 	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
> 		if (i == 0) {
> 			pci_read_config_dword(pdev, sel_ide_cap, &val);
> 			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
> 
> -aneesh

Yes, good eye, and excuse the delay while I worked my way back to this
patch set.

