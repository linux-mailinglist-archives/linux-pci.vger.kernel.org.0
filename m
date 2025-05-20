Return-Path: <linux-pci+bounces-28144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A34ABE607
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3A77B6F23
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8821FAC23;
	Tue, 20 May 2025 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6kuFxRv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5325A2C0
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776444; cv=fail; b=jCrZKGb+HbQZmAUXtKjSUR3jfU0Bc7d9uc/DjXBQB1LvJ3Rwv2v87Wy/m4vyylNl6WT9qGE5ArqCSX4kcKUft5rE8Xqe606HvMlcEHBD6xfRATJybFH7Iqr/CuquJuajD27qVp94TmNR3RE9AktCEvxpCjIucmzQ6WwCWnoH8Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776444; c=relaxed/simple;
	bh=eDS8J1RdfcIuIlCkdL5YkCifzURCkxGpLD1+RmqFtig=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R3JJ941pNWBzdf0MqzuvdNiqHJG6sxccZjcPGDOqo3LSgSB71o52Y+0HevVWiXldraRX51a84Kb5HnigL1bWgJDe0Cjf5jwQX//NDg2TKQM/I+5Q3q1SCdXxpnJRQik8hfpUbHwFa+1Xn/3fvb2dZeylaun/cFq8tXQ7vVmHtj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6kuFxRv; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747776443; x=1779312443;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eDS8J1RdfcIuIlCkdL5YkCifzURCkxGpLD1+RmqFtig=;
  b=e6kuFxRvjcP2976aIWqf9oUZGqgH1T7C66yM1hWH/GEwzJdqQEb9PQlb
   1/oAp6ESz78Qtx2wamJ/SX83RbqWB1CE3c3X8t5f7PDhRfN/aFwldCMkL
   zX3/NEa7JTvWOsUyb1qnWeIZnb5lzH1OfV1zZ+Mqu2SltFkaQhtfh0yJw
   VP822OUcfmbGF1nv6bGCKnXfw4w6yxyFJWqw+JOmgOAjPe/0PkNBuv7g6
   jEqWHzoFdHIPCDyP78Z6uqrenfgAtmSVWA3nu/cMWaiO5T3ZeHMCOL0TZ
   De2k0nYyjtGiB72p4P+P5kdnd1t2JkmvUz9aX2B0XzGpcm6fWc8Gf02e8
   w==;
X-CSE-ConnectionGUID: 2zjYlmdNQ8e09vOJOdhyHQ==
X-CSE-MsgGUID: BfqeKW4ASHyM5bajXyQ7CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49434009"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49434009"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:27:22 -0700
X-CSE-ConnectionGUID: aR39/nOlS8WKmYwNfzBVrw==
X-CSE-MsgGUID: kqIUGzj7SFen5L3GgFDdBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144555746"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:27:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 14:27:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 14:27:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 14:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQuTZTE8Dl6+NnIn+FDwFSQmlLTL4hbgzSvUnDchkh59on3bsInNtxPKPQO13YiGJoE0nh1JG8dWGTxzmDv0C99U6NNGpcLlvBdchqS/BivKile3SjXrKvLDFHlNOCzxgpz0RRmA/ls6RtzSVOMscCkggWeYZGCJoGRvlsB4OBA8gnfEe9ja45pX/YN1FG8R79yzCUu5/wPSj0kwOVdSBAZJmS25SCVsOdD6C3NRg/3xzHkT6uEE7LjqmFjBEfD/ez6S9wW9FxzlrHsJuMlt8iIpFrs709BeUeRhYWc1nZhgEfLcr8jWHIbz4ZOM8iRu+xbYby3N2QH9ZO/cjmQ8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9kPmdeNygcIWeFizMkUdQRoXLU26IhAlbLFVctbNZY=;
 b=ucOXpAC3sXLtYxR9aJeu3Sa729X9pFFRYEcSOuQXtdbMI+th//DPKzQFsEZMWcNx+qPhcsFohMEnq5PAch5Z/0SirGztY2QsmEk5BAX2WZVpEJsaA4Moi7AVSeGRofo8SHt3GLybhHM1haT+HfsYuHrIxw+7FfG/QW8NS+2hPbJ9vkW6GECdUmcLe+Q/lFazRDOQVxd81j1tEZV2XNdXxBgi35tRHog/0L7VbKoMd9nfWcEfR2nksrvdLCyIPreT7iyMsUNEii3yajP55HugCOfE25xw0cf+mtpHbEuvB8BTfeHmzGSLu/Fh4KaVKVpQnZkPso1Q6/YvrsVLLMiCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 21:27:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 21:27:17 +0000
Date: Tue, 20 May 2025 14:27:15 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>, <suzuki.poulose@arm.com>,
	<sameo@rivosinc.com>, <aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
Message-ID: <682cf3b327327_1626e1003a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
 <yq5att5f4osr.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5att5f4osr.fsf@kernel.org>
X-ClientProxiedBy: BYAPR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::47) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9dd1eb-1762-4740-a354-08dd97e518e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kRJJ6GOdRJyO7m5BHy1LzgAbjt4C6LKqCchvCZr4ui4XQash6N+lsKxxXcBt?=
 =?us-ascii?Q?J71xnJeOcEBP0j0Zx06CcnWfjnZn8xP4naDAuNwZTIpJ2pRsK9eRltpag4YE?=
 =?us-ascii?Q?yRByh14maC4h1INxIFZzgTIvn1E7xotdhatnFyQth13PHJcrQTR+4M9ftB1Q?=
 =?us-ascii?Q?DCk7cxCQnRayp+hgmdqDYneQi/8AAyHsV7wJ7S9Abk+wimoMc4FqwSzT/lgA?=
 =?us-ascii?Q?Wqj6IFY/9W5FDCOieHkx+fMjSQA5q0T2Z9beG4pl84uHwX0mPLzJjDE8gfQT?=
 =?us-ascii?Q?g1PM5xUMXotY+QvF6FJxpHTWcsYqQDpnjB34r9c4WNXmPd5qs6y0PTqzLQRG?=
 =?us-ascii?Q?sxR38os/OTYiOM2fPUZjHN6mAMldKY0lmTqY9WRAHtaKhpFAvSDIz+0YKfqY?=
 =?us-ascii?Q?W05gL7/9ucKpvz9NUkNFeICUBB01Jz2nb3eQNEXKbarkYA1rnBrqvnj1EVcP?=
 =?us-ascii?Q?8EelqGOuzx+hIZeOsgvlcbU3jb5rjOCcrLvXzkNxM58jrTVAXIwAVt3JbX6y?=
 =?us-ascii?Q?86BENTMZb2ebb+k+DgA/HJqaSyDpVx+dpn+Gz4XqyRTSdyIDJKNc3XelVIpH?=
 =?us-ascii?Q?tsL3MwfOBVWtPukU5oYimgPQa1U3RXGYoHgPLbRq0MBInZrzBaXvouZfangy?=
 =?us-ascii?Q?EQhhyHKeXPzjXWzRBJXaDcNMo4QNHORvHlIjS/KBqKCJ7v62XE3JP1mX7vMH?=
 =?us-ascii?Q?mNEU5QY2JC2G7supBO8qTcL/1RMBT21xk6YkK62uOsDpygm333BGlyG2NH3f?=
 =?us-ascii?Q?8bu2MK3Z4QMneGXh5x7YkySFD0S0tu6Z0ucm/j/ObyAln8BagdWoCz/GTh8g?=
 =?us-ascii?Q?mrOy7UAqWYVs90q8WHL+NZiPrWU2p56aXiV+OaFNoY8blBEJPwStgWjDxCSO?=
 =?us-ascii?Q?UV3HvwFgxlbtYH9xD0+rr6/BdEWtERJlpGyxm6h8taYc1ufVAh4uEynN8Imy?=
 =?us-ascii?Q?si71BaBTLSe8WmUhEXjjwtIBI/SlV6I4Bmz3WdZiQZjoBjIYWymRlzlarHPP?=
 =?us-ascii?Q?sG5DfLlgVUTnBFTxALwDfCzmrezCO1jHxAjn3a6KGPDNpApYVYQJF0s/NnWQ?=
 =?us-ascii?Q?rLdjPDGku1Hea9od6C7jdb/TSAUJmBu98YYEEu2+ZcCXi42rl6YcxjUv79pn?=
 =?us-ascii?Q?JVVba9izzEiskfX12O9rhED4xkzjIpV3y6Bd/S9cUKXi2msZDJoyaGhtDa97?=
 =?us-ascii?Q?ylckInfd+KIt2GnqTTE7sbzdpOFHLbj7fI8EYV5OZM+z6QM0w1+Ip410IeeM?=
 =?us-ascii?Q?KbDwLdc+yK8CNBvJy7bMuXoAsNRWhVurLvwrIv5It0qc8APLmNYT//g6nS8x?=
 =?us-ascii?Q?wwv7ZAe/O+3hvSVzmtOB1SY7puehwLourGwOa7dfFGpXylVju302YrGR/2QC?=
 =?us-ascii?Q?vth/3WvgPd1rgw5tBzEMrbobNCpMlXxua/P0cq8WBw0oPYa+FMOqWsC1Zn7/?=
 =?us-ascii?Q?1jj7JadosNE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+WV71wTAVIf+EA2Ujba5a59/g2m8QCDiQf4sdPrIExW/mCqQ5AvPB/v2PUrU?=
 =?us-ascii?Q?wIcauKaSxtEwI+q1FIIwAw/2J3povNWI5kbltzJFuJbFnCU2+QQpbtHHzkDh?=
 =?us-ascii?Q?RD2X/a5WaDLbpfb4r6JD8dndMYlkG3g18GpFUsDe5GY/d7l6/Ln57aab/wT9?=
 =?us-ascii?Q?JWOsyDXBTquT16tSxw/q9Kby3d7IZcWm8JJteDRpc7taIXhpS1pRLwwq2EK4?=
 =?us-ascii?Q?nHpbSQvNnbLSzZ6HTCzLCg7AJ2MKgm07BLjWHa3AMUGHZxiegyLKZaDchPgD?=
 =?us-ascii?Q?ti6ACShVAqnqLysfbHqFo8NmV2mjxR8PDJIQbFfNjLKX9mnZX2ozQGPo3031?=
 =?us-ascii?Q?NnzUYSQPie/4+ETovwLtaunOOEgH/svArFtdw8SycODLBMGU+fsgQhfKdYyA?=
 =?us-ascii?Q?P5YNNQPWJfir+2tjtvLSoj2mHqA96qop3dPSwyezmIrxGRGz8T1V7vB0wZIl?=
 =?us-ascii?Q?twWCvJrnttpcuNQxrlSQkrM9Zx9Dz/9Xa0P8xCPjq3HDa0vR6F/sYpx2jnYe?=
 =?us-ascii?Q?EqQEGrY3x5i416ryj8piXIGtfiAg6IVZda613Ydn5HgoX8e6c5/l9eoa/91A?=
 =?us-ascii?Q?DLh065Nuq8dEiCjjBxmxVEkARyyrpwsE0dfp1J+Gtc1d+0j1qxKgwQBFdyYA?=
 =?us-ascii?Q?MontwmuttSjzVqlUW9A1PaPp1A53SURTutsf0R+rLX1AYkz3EQ4rFMxgCBVa?=
 =?us-ascii?Q?hBxnogKWf4C4xrxshBuU21PRjrHBK3BT54jYp9rH74W2x/pdG1p5NvdvwQZr?=
 =?us-ascii?Q?o1FIU0BwZJR5YkhOhj6iXEpKBd2tP0YvIkl+zWWufMackqyp5A96hZ5i/CFN?=
 =?us-ascii?Q?zLIGT1Qio1WCOs/8n2f00WKdYYhMsMyTkD1hUDIMsWphIXLm8t4ZzaYnDthF?=
 =?us-ascii?Q?9Uip/eA0YeQl9SOxwr+GGx3rHsUyZwHWsqWEvFEcJ9Bzg6+MaSeQTV+uvT1D?=
 =?us-ascii?Q?2+Dib0O35gkwV5VSEv1ABwMbK1OCEY4f4ulMCLJ+9GaJ1oFc0NEQH0bDjbbk?=
 =?us-ascii?Q?UxLf5VjHYYJq7Dn4K41d1mjcfKyLTNt9su1MO6dQ2PZZSn0Nq9YeTychbmkV?=
 =?us-ascii?Q?kFrDY/oz9cFaFljkK3mcQZYMftaOQo8mWvXNHQEEYikl4lDOA6MpsYS4yg6l?=
 =?us-ascii?Q?Rf7bJvzJ5sbBlyHl3QbST+Am2195NfLFfEcBLKl7LjvEdsoi+HknEQB/A2TY?=
 =?us-ascii?Q?bT4rt/Gv4nybZSfnbkuwpxL+l+NiHj2NCV7u9zlbGHYAj58tuB7UMX2KuSE1?=
 =?us-ascii?Q?mwjH9PDWaUwRq39K4a8iw18KZgf9qZCZ6kl/yoEz5qsmTk5fyVLlM0IIjK2q?=
 =?us-ascii?Q?jjfVi2Eoj1yT8pjF98F4lCv+pzeAvCcwCV/krdLomhYjC9yDBBaF3XBir57e?=
 =?us-ascii?Q?B+Hm1jkN2lfgEcPgUkHLBXisCOvY+bnvgvsLSzFEKPdPfRXEM/HFpd8/nFr+?=
 =?us-ascii?Q?dbdZVInbnS0PiVGXz6nMHUCnVmQq/NRQAeifSRSY2ssXaqJcKmezmgyxA8YA?=
 =?us-ascii?Q?vkRjsl539w3ECYlbKwuW2+8Ck9dt3sYpyRGGAUBSECPmWyrLfNCa9EPDA6e1?=
 =?us-ascii?Q?PWOCzpy5eH/JSxE0YgS8EmKehBeL+hUtQgWwp7DfuNpZ8yv/qCWua+FdulQa?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9dd1eb-1762-4740-a354-08dd97e518e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 21:27:17.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdyDnc7LBgSue6YGidSQN47iStH78apKs/sPrMTvqj2pGRHGDaADuTash+HfWD0kEuxEGkIvB7D3sOJV8yQ0SBk0ApltqwJ1idp0/WEpg8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > 
>  .....
> 
> > @@ -558,11 +675,11 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> >  	if (!pdev->tsm)
> >  		return -EINVAL;
> >  
> > -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> > -	if (!pf0_dev)
> > +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> > +	if (!dsm_dev)
> >  		return -EINVAL;
> >
> 
> Can we do the below?
> 
> modified   include/linux/pci-tsm.h
> @@ -38,7 +38,6 @@ enum pci_tsm_type {
>   */
>  struct pci_tdi {
>  	struct pci_dev *pdev;
> -	struct pci_dev *dsm_dev;
>  	struct kvm *kvm;
>  };
>  
> @@ -56,6 +55,7 @@ struct pci_tdi {
>   */
>  struct pci_tsm {
>  	struct pci_dev *pdev;
> +	struct pci_dev *dsm_dev;
>  	enum pci_tsm_type type;
>  	struct pci_tdi *tdi;
>  };
> 
> And update dsm_dev during ->probe(). That will avoid these get/put()
> operations in these functions.

That sounds reasonable at first glance to me, and might even kill the
need for pci_tsm_type because:

PCI_TSM_INVALID: !tsm || !dsm_dev
PCI_TSM_PF0: pdev == dsm_dev
PCI_TSM_VIRTFN: is_virtfn(pdev)
PCI_TSM_MFD: pdev != dsm_dev && PCI_SLOT(pdev) == PCI_SLOT(dsm_dev)
PCI_TSM_DOWNSTREAM: is_upstream_port(dsm_dev)

