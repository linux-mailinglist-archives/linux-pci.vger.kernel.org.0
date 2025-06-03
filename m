Return-Path: <linux-pci+bounces-28906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC8ACCD8A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 21:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F241188DF31
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15013D3B8;
	Tue,  3 Jun 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5xOj1bK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2C1ABED9
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977979; cv=fail; b=fnklHBIcPpdDymkd5RItgWaUOmQbrFua5/ZAEKkpiaXdVNFcquq4k6fj6nWKUqx3GjPgY5HGptDSnMoD04VNoSVi19W+9uCU8GPWtsVi3qf8J+fgZS7zbO/cGbw0yWKNiTKReZTIpGkkICZxL+5qtbOqfzm4EcV9CWtJSuDGUEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977979; c=relaxed/simple;
	bh=hKprQJrWCkaBBPA5ADBBfY0pR4rOPcqEi6EhN48KHXY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pgQ6YZMLwILaG5KdxdatN5+Is/igh8z4oMQoGu4Gdx3LA+OhiNA/2Uxgut+NyZ+wecBxgY6Cf6RmlU1C+zGcqyMMDpQA4jc19ByAyZoAYxcDO28QY/ftkfEyC3EXD3EHhVK5slBrMe9YDMbl5TmnBpAMevQGDMwpyvruYfMTJBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5xOj1bK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748977978; x=1780513978;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hKprQJrWCkaBBPA5ADBBfY0pR4rOPcqEi6EhN48KHXY=;
  b=L5xOj1bK3CqE+HGYtPxD/lJYTjggk88gIluCbLU5PMCXji0Fs8ZnxKKP
   sXu+jN9ht4KS59KlgejNknFhRqk0Q5ISt5jC+j+cBZnNSpRXKxiNcaHEL
   +yaVVPYnUF4Rjz43tKJqNFPzRAYcf4JvQKT+OcYKM7vmluAPE+neQRQ+H
   +XAxzifVhd8BGySiNhLznXxOJihbwg5wE7A4Lo5ojeoY9baM8syqjomPY
   yLoS+LOfooObGChnICr/ouEgTrS4Qnk+fpDVOeOP4Bi+0T1dbqXr1mcNR
   PWowfDO4gWoiiG4ZNeR2beVGik4zsfGQ8L7EI8rQKc5axHOUYoGenNBNA
   A==;
X-CSE-ConnectionGUID: W6GnCQiNSRy3ZaDH7Ka0Kg==
X-CSE-MsgGUID: ta8EdvfFRkGWOt4QVTGwUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61701508"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="61701508"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:12:57 -0700
X-CSE-ConnectionGUID: E5mWsV26RvqzU2jyxfq+xg==
X-CSE-MsgGUID: 4omefRfMQd6jpuPnjs3uuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144840354"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:12:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 12:12:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 12:12:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.74) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 12:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuyA7DBwSOF3d78RZIG8EUjyppeH1r7YiDWMNcIymtugnwLhZu15AKeUBzH0o6KxC7rDJ/KGwN1sQVNjsCrPcP6RyDZSe6y4BKxEX1vbFspezC8dTiRDN+oAYMLPkVz1DXNWrPVsFWqsl6nmq38aQVmLhHd3ULN26LhvwNx8WixDWDSCfSfrvscKpPm4LWZhiqP1NdyPOKAoDX9Ka4WPpQTthFQII8s+wZ4+LZylj7ih3AY78dkvXz0mVB3PLDXAZzOb2igcVOa+FAZwXusioSmHAYXD/esSML6dBJ/zbUY4QdSh8ACQlnkIWdR0HyfFYfPASLA2xHijB+8lCYaXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wklZjaU0VwuO9nSlcRKsP4sufaQhhs0ZO1FR7rIIYkE=;
 b=eNQP9MIdG5nyjzaxMbVLfr5iq8lPQHX0nhUPjX93c3mYT8IndkU3gg52S9TZ0FwvNjL/ajLcI77OcA2i2QknktA11h9oBTvC3sBGHp3TMjNfzWzPkNBjgZ2NR77qawFDrMgVM0lMMDX1HnbRn7X0+xI9ShdelCgJpHXAPSdwg/MB8byu0S4MFHYgjF1REjT7xsoUGauU3njnd5ju/Q2Gdv2Bp/sv5rKwext7ssjx5nrVCmXUk0U7bRVNMY6rr767OLNLhzur1GNODJBnDcgRap6pq12U9CA4G81zdetWoBq7qkJpFSTL8ki6X2Lg1z8kUBFSpLsXBrmle6yxmZU3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8708.namprd11.prod.outlook.com (2603:10b6:610:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 19:12:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 19:12:40 +0000
Date: Tue, 3 Jun 2025 12:12:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <683f4923bc4cb_1626e100b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
 <682ce21c17363_1626e1004e@dwillia2-xfh.jf.intel.com.notmuch>
 <aC2c1SggkqKSO1st@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aC2c1SggkqKSO1st@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a977896-033e-4db8-ee28-08dda2d29c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ze0Fk4TK7L12gVHw61qwtU7FX+dJQerQsFOw6t2p4Nw/0ATRtwTl5s7DbxAv?=
 =?us-ascii?Q?WQnrrX7IOUsBDtu/ZMbkvhZiB56xmqtH7NuFmvQqIBkP+xkJXrj1R/haDrKU?=
 =?us-ascii?Q?pMIha4bDCdMygXl9ch8bfe9kIBUqTCXutRLdPUDXwGNLfTthUH/HGnNiUGuG?=
 =?us-ascii?Q?VkrSWA0h8r7o0E/UCHb7IeD78aBx/jHKBTHUlPxZxsWIyJfebnZ0aKBKtkQl?=
 =?us-ascii?Q?eqagzC9QzIHEbr8x6jok0EOIc8+SAH7Il6aKhdDaMGirI/y4lpwvLljjIj5O?=
 =?us-ascii?Q?d0w/C46PU98mqcp2UJi+SWuBC1AF44QicZgOd02wObv9VxchApPNGkC6tqVJ?=
 =?us-ascii?Q?E8/Cr6TH+5l0mf71PgMUY+jDJ7IiaggZrwfUPgzNev4oRrR8Qr0gqjVjC+4v?=
 =?us-ascii?Q?26zeSQ4vAMocvG+Ts0f0iS0LKf88H7XF4s7/b58Uw26j5TZU2O1F3V9oklL6?=
 =?us-ascii?Q?cI8lPEsn85jHQzfk6VX7WFSWDAGprwimjR/1Lecz2oW4kPFvUvm1EuJqnPVv?=
 =?us-ascii?Q?hMBAjKQkoGP58zUV3ztsMA6v04qwPgmQqvLtN0kKiBqYs8iFQoqul94NeDVE?=
 =?us-ascii?Q?xlzp8NYtLs1EgYySUBztzIutdZBoGqKpXcnxTJJEYcRYs6BIO1Z7hDFEc8Ug?=
 =?us-ascii?Q?NPplRebd797uVpMQLqDLvbGUMKFgYwYObMKEX1g+PoyO0OTYHqw5TRQoc56N?=
 =?us-ascii?Q?UJ5d/3cNm5GzaDGiY3yM/aBN1BKcQnCykg9WDMNDrXgo6zFZHvnUsf8Gy6py?=
 =?us-ascii?Q?dCCARhDIJMk+vzSrkyakUKW7DNu5It9yXLaAM1OhDbpVZa6gP7n3KJORBXwf?=
 =?us-ascii?Q?Ir4uB8kuU25HGn9wUCsna6Xf1NObRw+/L9BYAtbr1gY8EyA5Ix9hs8i/1yzf?=
 =?us-ascii?Q?1akoqK1WOrivNLFRg1Qh23D2CusaEEevDnPns8Vlx2gOSy2qK57VN3ppGHFc?=
 =?us-ascii?Q?nU1lL23/rCqjID0Q/24oTsca13usr70zrkb4tzERp+uuqKapL/4KprrL6sJH?=
 =?us-ascii?Q?P8sSZ5P2n+mvO1d8BgTofoX5GreuuPffdWV9LLbKB1b6yjcSSAEv4N7s4o0a?=
 =?us-ascii?Q?pK+iqOfENlWV5UYWOAnkAMYMMj2fE97aqEGmlSf/L+RrnvjQNXJZgPjJ+J2e?=
 =?us-ascii?Q?jhvG0jEagYWrTpiLn2XqTA231O9DMNwwbDlKUPmNT5a0csdM5xIg23mAh+Cs?=
 =?us-ascii?Q?xNn1KsB0n0NPECg5d/Q2hrEK1lgrVa5H/cEcwG2t1ya9EWo7xMHmJzAdPjMr?=
 =?us-ascii?Q?DQz5fRcaHHzLPVUW4DSn8KoV/i41iHXOzibcKIY6GaNYlFap76SA+os8SJe0?=
 =?us-ascii?Q?eoL35MZrjYKwOkf80o+saAX/n4rC2YnfqmMUMWQZRV6qmnQvuqAIu9szoZBT?=
 =?us-ascii?Q?JhyfY+J5sCrRbCWwhwrD5vjDh2AZOgeSIHGS5175GWge5sIJUdM8xiXFQqsV?=
 =?us-ascii?Q?PhG4m3MBW+E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mNOBVKGyTS2CILLlUTfJRENK6/TTsWmUmq5h8hV/4C2gzHoUsDfGbu0UQmsH?=
 =?us-ascii?Q?4M0rR8yAKj4XSFStNlGaR34oN+35s7bkqTHjt78ZM8hsPG3cx3Pj1jRqO4zx?=
 =?us-ascii?Q?rmbT672sBrejbak2wS6VhWats8gIzP3KQW/s5tUf1mPXtJC7RyOX0leM1pQY?=
 =?us-ascii?Q?9Xd3xjobZN8op6X+cZd/98hC8AtGC+jXCWuvNt+ftCEfgP3xSBEV6Gmg9My/?=
 =?us-ascii?Q?+/0Bnp7ZVE4HS1xEt6aBaxMMcpO3qAGKBRy77XW4QgDgNrSvHlh8hK4kVZJU?=
 =?us-ascii?Q?jCCfyDi6qtvtKAYcY5hBnDQJmGR0Ml+xCjm+yGrTvJqEcsEIn69OdlLuJ1SS?=
 =?us-ascii?Q?hxQn/1Y9GsPhmXrf6S+NygHM6e3pDJ8f61KR/qxGYpaeDt8NVb66467MzXaa?=
 =?us-ascii?Q?daSFdp8dLLpAp2fw4rjWn8WAJHF+MK663QsuTFYFv+PTchRVTOgPrlx61qNJ?=
 =?us-ascii?Q?GNnF8SAusD5NZ1Cl9UUozBcHlHGhM+pwJfBsaT6OXIRWn4tF+KyZL+cvLvLJ?=
 =?us-ascii?Q?l4kgd+dFezfUinumfI2UCBEnW9pMFsqcTihHUhoextW7Pbl2JYmE3Wsxd34a?=
 =?us-ascii?Q?tv0+bXY6a8ClQJtGOKb3EKNjc4riHB/8qjH+q5BvtyLJeSxfJ+9aDzpHGKLs?=
 =?us-ascii?Q?boK2/f5/CcUjywS3uY5+2O0pGHoHxtQz0TmLv116EJ+rqDSqr3gEraW9tpDJ?=
 =?us-ascii?Q?KWeFCh7tCkPqQN9CtePmnK1N1icWCQKQ968ssODrMbPZxNh84Mji1N8YcLos?=
 =?us-ascii?Q?mYpUR1jdujA/npVAgVpij8mGUrzNf+ThiNrtk+mqIw4KHZR6blLd24Gsk5hr?=
 =?us-ascii?Q?pXndcsVhi12TSToTs9cJ/Hmi3oW5c7Zly+TdjebRPPd4ZfTu2o5UfmQq8FA/?=
 =?us-ascii?Q?DyKC1yW3z/IBIcbOk8DGvfecJ81NdI6mu1r/C+q+kYzWHsQjjKLf4JD7rrdk?=
 =?us-ascii?Q?5OdndGpOUf6AtMqDnDSWUcVpuKr2P1TapZLfXIUv2WpLFJHkGGhLrVfBI22V?=
 =?us-ascii?Q?SrV4hhBtkwudt3vOhzjcIwTbvBXMBIvnItzPlaIAsIH4ndhNevJrzGBwwid2?=
 =?us-ascii?Q?5r+QXFeHpa0LKd9rx2Lr5qOOAWMxN+Gr2/8BkjRfTpTIF/Tafr+YvYODgV8d?=
 =?us-ascii?Q?cF85SpFTfL53dyeme+7lHExWAyLpF0Y2PuDJNy4IKLamC8EJ19n3LQQWfWIo?=
 =?us-ascii?Q?bZj8WyMuQqEcfECWgKxj2ke/Hf6naSGv8EvE7LnpmU2kwNkt+tVauXeYvXsh?=
 =?us-ascii?Q?lcfT4KRbYFNgWN2SVLEFLq+GORPla6L9UmbB513N6NU5nIH2D8RSvHpcL3Hu?=
 =?us-ascii?Q?bmWcj67K//OJqYpKgI2lOM2aMt55XP9Msm3bguE/6Aux2LhyaH9SZV29qdqP?=
 =?us-ascii?Q?aeJI5xGRxZU9nHd7lkG1y5f9x50SKOElyK6nAxFmUUWyacepFH4Ko0+YcCna?=
 =?us-ascii?Q?ldOMukW+wF+/tdUIC0GrMzubC0wnNVaX8kQN23TEMtXaHP22X9UhPg8Oxplz?=
 =?us-ascii?Q?TblKD8t/nNFasTj+MLkaEXl3LBhQE9MOPHuXyQauV8ZXw99gkwlHzhKDhKRI?=
 =?us-ascii?Q?Z9kbCKU6PNo7xlM3z860vpmAzcdSaZldlMwT2Sa89WD0otbHBivxZxvZqkLJ?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a977896-033e-4db8-ee28-08dda2d29c4d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:12:40.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daNnEyyeWKRvnPNDr+ueXyE/Twb5S0zWpsw8nwaUa4rxWtNzme076mHzlzmWmzAS8X3KGhk/lIL885OPXaA39dnxaHcje5o7NeCmv2YEmdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8708
X-OriginatorOrg: intel.com

Xu Yilun wrote:
[..]
> This field is intended for out-of-blob values, like fw_ret. But fw_ret
> is specified in GHCB and is vendor specific. Other vendors may also
> have different values of this kind.
> 
> So I intend to gather these out-of-blob values in type_info, like:
> 
> enum pci_tsm_guest_req_type {
>   PCI_TSM_GUEST_REQ_TDXC,
>   PCI_TSM_GUEST_REQ_SEV_SNP,
> };
> 
> /* SEV SNP guest request type info */
> struct pci_tsm_guest_req_sev_snp {
> 	s32 fw_err;
> };
> 
> Since IOMMUFD has the userspace entry, maybe these definitions should be
> moved to include/uapi/linux/iommufd.h.
> 
> In pci-tsm.h, just define:
> 
> struct pci_tsm_guest_req_info {
> 	u32 type;
> 	void __user *type_info;
> 	size_t type_info_len;
> 	void __user *req;
> 	size_t req_len;
> 	void __user *resp;
> 	size_t resp_len;
> };
> 
> BTW: TDX Connect has no out-of-blob value, so should set type_info_len = 0

2 comments:

No, I do not think 'struct pci_tsm_guest_req_info' needs the
sophistication of a "type-info + type-info-len" scheme. Just make it a
64-bit @fw_ret property. The kernel has no need for that value, and
there is nothing to indicate it needs to be larger than 64-bit. Both
ends of the pipe understand what @fw_ret might contain.

Yes, this envelope definition belongs in a uapi header.

