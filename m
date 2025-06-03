Return-Path: <linux-pci+bounces-28924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C55BACCFFB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 00:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE741189506F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 22:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A140155C82;
	Tue,  3 Jun 2025 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNgW8t/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F152C3253
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990853; cv=fail; b=iK9EJtb0wGj668cOGEFGG8VnGhdrxeGh+mY/hPPBJ4ctOPAOgRM/yWn5bdYMt5cujFhL+efCEro34Q/c+7WnW/7SHnTmcrWA1Fr7s3UtEo8VKJ/wyRn9TXIxO1S/PbNp6I5+a1yrIfVjn7x4HASGrgZwBQOQZ6uQUfbdrhhagDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990853; c=relaxed/simple;
	bh=YX7ghB8uvqOd0xptxwbkq4BLxHwO+UWObp2lTTMwhAA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lJlEk5IRAk/Sw1aMO9hEylu1MX3WKoamF3EQfa02QrQMqmDucePsWHOyt4OjqoU77dUeYQAptSBDJ+Mz8RF8TPYILZp8DOjrYcndTQkYdjxBFQMJlScZiwOLLp/nV7p1eQWVQz9ociNTOjbY6u7BbXZKMdIp1kyzGaHqItZYrkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNgW8t/w; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748990852; x=1780526852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YX7ghB8uvqOd0xptxwbkq4BLxHwO+UWObp2lTTMwhAA=;
  b=BNgW8t/wyQDWQkiPTjZusHznQAIK9uV6cDUvjOHeYk1ylIg+pWR4Um2A
   Gg+c5epfMTBt1RJ1E+tCGkwu+D4MAvWECMJcbzSPL9wP7ost8avwf3czh
   zCyDtQSzR3iOXjivMVs8USqt4ikaCWQ8s6YeHaSA6SL3PqsMhyOPqd0VG
   vwwdpK0CJA4fZlZBNg9+E0JEgR673U5NDwjEBEI7g6YrjqEOqsPVSg2Bl
   xsi7DIdJRs7KfzefpV2YWZm3O2FT3r7SZhJO+Y6Wp7EXnO1q52IYmN6In
   6eJPea3IAS0aUeEgJaiorfZAc3hMiNRH2NP/vTYvGno0Y9UD8pdcGaDRm
   g==;
X-CSE-ConnectionGUID: IVQU8erHSva3rUrfMg/l9w==
X-CSE-MsgGUID: Lr6NCK8nSYeAEOq0lzQLtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51051219"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="51051219"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:47:31 -0700
X-CSE-ConnectionGUID: cCzYoYEVTa27fXBOzrXVHg==
X-CSE-MsgGUID: dmqFkIQHSDa14UCAvwvINw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="144964258"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:47:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 15:47:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 15:47:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.80)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 15:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPA+nIEA1ditvNcgYFMXrGEbvDz+Dsdz/VrclOvoGsG0zkRCeNox2XjCNtSda/88z/uyR7uOVgGMfJGhGWxQ9T3X5pdjkzLHkjcQSwBdqSvnRjr4FROV8Xqs8HiDLWoTwztZduDDtG+lOJQAnnakUJt+5QXzBVxwV/L7ZVjRvmGHyomzZw/JcG5yHy/8HZOx3iViFiWxH/QkmDVZQwm+z/QcQfmd1DUs8BS62lDT5KDUn598/8YtF6uSniKY2FaW6GISGqGIs4EtHWkYNB0r5btjJG2WU9I0BriIzEbnn7pUBXIAswrTMai3MuDaq7mxnLuONCvQ7hShYS1+s8PnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19u1mdOTc50O5W4oZLylxs+DXUxw+FDykOxd653sIVY=;
 b=PMZQ6KQjGas0r6idAbL6dcy2uurrk/vRCmmYrlWugjDvbRwFtQlh9ZrXjyZqPbdWuMWygKIduJm318cz6O0cBWC39FO97VXyis8hpy+ULCBSILqCJgoW7465l24sYr9BFZiWQClaGQIY9eJX8C+5i7FkGgeV76mJ3XfLr7rPN6vf/6gwezPC/RffKIsafa7zT5uZdRmaBUyHWSPYfYSW/LKzculc+X1XBEp4cm3Ke+3h7OkQwMXbyfGrKahl6FdXs7Mz2xMPnjuKmNMOzYbQJmztb0OPPBJei9rj4+KlxRH8phaDYM0oysMEoEx8/393C8+vreFJMyoYjasdSxAVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 22:47:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 22:47:14 +0000
Date: Tue, 3 Jun 2025 15:47:12 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<sameo@rivosinc.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <683f7b6fec30f_1626e100ab@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
 <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <5d8483bb-ceb7-4ef3-920c-d6286a7de85d@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5d8483bb-ceb7-4ef3-920c-d6286a7de85d@arm.com>
X-ClientProxiedBy: BYAPR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:a03:80::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbebf37-0846-43bf-74a6-08dda2f09588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TeBRSJjW1unMzAAlerLjxaaBhB8b8bMqMV3jHZpZR7rfWiPRrFNMfL9bZECR?=
 =?us-ascii?Q?EivssiWgvzuKlRgKa6GfmJn+WFtwl500WCezj997A9VOefUPUaqQoblJBPqF?=
 =?us-ascii?Q?IzmycqJG5/1XZ+8lzuOFbA16ibA5hqdDts4yriTMpJpHjc0wgnfL/Ni7S0Gd?=
 =?us-ascii?Q?/RN8kv326suY3PPQ7D7eOVj8BkBDSsmSa5jE6fyJeB/LZR4XCUSEjpieBguK?=
 =?us-ascii?Q?NAT3LlpupZAmUuMblTGtW7mkPvduIPQ2QfNRGnQIfxPzTNEQd+UKUt4aWPEh?=
 =?us-ascii?Q?sp1nI53mwobMBDqiBOBVZuKciVWFMA+lLNN8q3jeyDz886wTlBXXPz4VqMRU?=
 =?us-ascii?Q?Vo12xcq7vgBoAu9WA2ssBsLjr073aR1rE3pTbIBS8XcME3mi95LZDAB3ftvp?=
 =?us-ascii?Q?IRoQdBH9rGtki9k7lgcAmMwkMrL693B/PcgSFzGpa2t7zqmjvOyhrOZI6Oqt?=
 =?us-ascii?Q?pWPsZ9NUHyI6Xdnml9A5mu5UdDS8D+AAr49J+kymvoEOIq/NFedM1+uAq/jH?=
 =?us-ascii?Q?7YHujnSyhDaVpl9or+OKgMnhR+1/FyPWyacp5O8VuvFDBC83huUnjnzlY8Pi?=
 =?us-ascii?Q?WyFXqzIxt72Qe5vrxAutIKdrsgZy5gu9iqCXsHKhCcxA2RMu9+N8TIeOkSR4?=
 =?us-ascii?Q?LT5V/oZTkQSfgDH+yFXfXBAppr+DVP4tK58s81Pbhz6cpUyoDs8IRorUT8Du?=
 =?us-ascii?Q?6E6dykEx6UEFC3oB2Z4RTOz1N8UhOtcuwH+NhtEBZMzEneNWbwslELgItPQh?=
 =?us-ascii?Q?tIIBDE0AA3HNNN2ZkNgiLRzZjbDugh0J4uuVSY0CpMWgaUsxUVwcGs/4nIfr?=
 =?us-ascii?Q?Z0vqq8/E9rO+OS7gNuJlGHSiEe3pz03ELaUiy6G4JydpZrLugTeOohR+5T/P?=
 =?us-ascii?Q?ZTYKslKEOx/weCJYf/onRyeGq7XZ5f8hbw2ff3awmz+GHkogWB3xBReINRQG?=
 =?us-ascii?Q?+5tbYb0Zag4iODRdfOxqnQap4zUbIa+5xb803sL2wbtrPOpOkbZV+szLa6Va?=
 =?us-ascii?Q?6OtaPwQmK0HastL+Jr8Ir+bQqKKfJahB2ZRzu9mrV6ohNpx15Ahapjd06Cue?=
 =?us-ascii?Q?Apv9QG+tx6reeSdGS2vixBCxyghTvvGxg6870RG6/VZO+CAcdCkL6xGdaywz?=
 =?us-ascii?Q?23JrcjbZix7hzhRb2VF5yVpOj0g9GSkCr2iSntFsEzoFo3QN61gk13vHB92a?=
 =?us-ascii?Q?liGoMdW/zz5Gh11ENuVWizauGfO0VbY+6ym+Lswnzcw44uaqjOIvhrU13/Af?=
 =?us-ascii?Q?EvV58lzA7wMlS0J65IdiyWo6qokcFF5/95yDPWn0gLsClhg+azp8fWmVacub?=
 =?us-ascii?Q?N0zt4/lzFHbwtSejs9XtOKYWMEWrPLGZQ14ls89D9wZuQUPRHRLv5iFkKT97?=
 =?us-ascii?Q?eHigqgvq/+/qqvL1QzHSX7ShtjnlBpDao/eytCgA+Scmh3vMpBkhzEiAZGWF?=
 =?us-ascii?Q?5gb4NDUfc40=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AM32mxvaDJukKNVbJkezRHF/1/HstQZ3GC8oZ4Nkoa3apCulDPoxiRU7cPhg?=
 =?us-ascii?Q?MZ6AEVlVDQX5Ne066BQD/G+QwVp8KIcwfnGKYbavGeap1dIJr4qc3M/QmCkE?=
 =?us-ascii?Q?J8n8M2Sh+J50RypW1dUOeGbYlbljRKu+3ZPkHGtkH2fyxvm1XkhQCyYg5P8g?=
 =?us-ascii?Q?laEbPlfiLjK2bFgjjMZPPjEqTslxLiJ1sBATjny6uTx5v25i0QxSmiwXZKSz?=
 =?us-ascii?Q?3JlLt8MxJ66M8avKGYnEeMglJidnOzZEHfmQFRwFKvgfxu/FxfYsLGZ/Kipt?=
 =?us-ascii?Q?DNtUSlpRSzqh+YNat5JAyLJoHIroq2TzqtJ2BUoTsEBWSEyyc7DvDn/w2KjQ?=
 =?us-ascii?Q?pICkzsBF6xGCphDOYMvq8sJMxfyTll9n7ec4pIwfnebXdrJYf5sqRDeBafR3?=
 =?us-ascii?Q?u4hJrAyS7JC+RlBCOwujc81DOs/gFzNBfossr/tYe/bQuc59KR40QE/qoQ6d?=
 =?us-ascii?Q?xwPGQEpAWCzTA40wwBvlUeOQyfil+l/msvjWzEF0TFeq7RljAidOmu+e/QHR?=
 =?us-ascii?Q?TUGCw5PA5q8UFFmiI6dQrR8PjphwK3eYQXVWEKZ8ZuTbvxzBNJr6D/8lIHLv?=
 =?us-ascii?Q?5Btdl/72QHSomZIg+Z+tZteyA5Q5eICsQz5RaFUjus8FvYqOuh4x8e4wO6aR?=
 =?us-ascii?Q?EI5NUvkU7zhKCUbv5KunnMQdDQW5bpCnRHQCENt3DsWy77W78pce7jOspTUb?=
 =?us-ascii?Q?gpv9pDCU2AZCnwVSbnd7ZzPW7jAqUPeoqmQ+xNRassDI+qIpEn3W/PL8pvx5?=
 =?us-ascii?Q?gbdroXbSbTtYyisdvMI2/qI/omDDhB29CV7DidG6wjsHN4UWr+yfcu2CadVY?=
 =?us-ascii?Q?Krck4ENZP7i0hiBLh0p4SfcwALyF/lpnwRcldpDUWEtTVL2UrP5xAWJAZoV/?=
 =?us-ascii?Q?NGKoYcK9b5pCiYWuneK+8N17E75KK33kXodcoi81innQp90jbrnCT/KIZRvA?=
 =?us-ascii?Q?dKuf8/HEfv4n8a7MmxfMH+ZdADiInT1yhtD1I7q+3XdeDWM4OSrU12EqAe92?=
 =?us-ascii?Q?50WfOhUPvyaAwfb1v7Pyrr7mty5BMSdawJimYVmSN8CQ+FCz21VqJVjawUx4?=
 =?us-ascii?Q?HD7EFIE0zVAyIMsQBVM+1YhOfabCbriMabTUygxWA/r2SsPz30IDW2n7Tblb?=
 =?us-ascii?Q?+BzgddO7XUz0Hd2J99SnxGQTpljMa7xjCNkfGfEp5DwZkXhlz5Cvyy5UmaRs?=
 =?us-ascii?Q?7JOS57I5qou2geHnp5w55wENuszipxtFWDEDQLaVwhFJTmrQ301g8Q2EM9hP?=
 =?us-ascii?Q?7ez0rxjowsM2N6EFP9WodwWCHmAf+g+aPFpYg/XpHQtKnd0q7DZxoz0/MsWc?=
 =?us-ascii?Q?0YjWYHJ4HrE32hlaazwCp1cG25OExeWITDHtIjYiWCgzQ+zcHUC9j3HS9pWP?=
 =?us-ascii?Q?1GtjGKflcVLF0spTOIMe6L/flxUnq9iVECqXyROH8jW/zJQCf+3izwh6H3DV?=
 =?us-ascii?Q?lRGvnRlS59k9bLjYoP4GgIR5IyO6hOvmF3/sn80phIFlG974/Gg/45PRq61d?=
 =?us-ascii?Q?NNMF+imh3jejIwikXuBIBZ2yNrDc8qa39zENzJ48Ui22VzC1DdAM24mHlUuD?=
 =?us-ascii?Q?9Lwj9ciajXa6BZUAR2FE49afn7E79eGOVAoK4weQeqfhdzK9qT/5HdELvvY+?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbebf37-0846-43bf-74a6-08dda2f09588
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:47:14.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OcrmeTks5iF9sJeMpXI+vqU/0zvIrlq6Cc5bg8yH1IcHYOJ5sPrBOHEtoF0CvaTYbtoJbS3msvvDYKgLfz/P36jP438a4m/elXOB/+fxdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
X-OriginatorOrg: intel.com

Suzuki K Poulose wrote:
[..]
> > Ok, something like this? and iommufd will call tsm_bind()?
> 
> Remember that there may be other devices, AMBA CHI based devices
> being assigned. Not sure if they pretend to be PCI or not.

I have been thinking about this especially with the relative ease of
creating samples/devsec/ given the existing Linux infrastructure
emulating PCI host bridges.

Why not require PCI emulation for non-PCI devices? The tipping point is
whether the relative maintenance burden of not needing to maintain
multi-bus Device Security infrastructure outweighs the complexity of
impedance matching those other buses to PCI.

Make "PCI" the lingua franca of Device Security.

