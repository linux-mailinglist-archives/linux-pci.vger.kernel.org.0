Return-Path: <linux-pci+bounces-7279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8198C0A6C
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 06:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E851F281578
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 04:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC213AA27;
	Thu,  9 May 2024 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdMchBiA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB4D26D;
	Thu,  9 May 2024 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715228381; cv=fail; b=uRcRFBVip87wkdusX33hiCAt2rwX40N1wqpYeYEHFXJWHXv8xvNUz2CVIW9k3XJqgkOxbtLuh4G7p35I9HO7iR4fa7J7qRus8NPpQlRgYM3RilKQiGWzIRDWLBJLfPqrcci+arNHQ/wXy6PtvVuSe9F7OoEbIHkGVAtc0jvo2Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715228381; c=relaxed/simple;
	bh=M1LY6Ic3fum6RSPT0Y+1o2dduytCW9xZu2sIRdT3sVg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oKcHWNPGLm7pU5DYNs8e/mrRaVoKNRnP+uv8dq6j6OcYbW+cyBSwWcig5WPuAZCz78mt+NIzIfB8P5ZN4Hh2CElNBss0+C45UbegkKnFP0SMTnNKVEcDQRWdCyK50Tgg8PC9BVXwO5INc6QGD1xgyYgMUQifFSF72hX5N7h0ABc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdMchBiA; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715228380; x=1746764380;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M1LY6Ic3fum6RSPT0Y+1o2dduytCW9xZu2sIRdT3sVg=;
  b=IdMchBiA159Ti3A20rpEBRX5QvHeyzpCcGtaAC62KqeLU/q8GYw3437Z
   Y2BfpL3IlbRMdgf8ev8Sl0OQ2LxSXx+kvrjn45XDnG1t2QURJMjVNAf8y
   ZJ8/WOFxGg31onxKhhPOoQuFmOkaIkgr0MMdLXgYTFmZ5ek6eN64KgN1t
   zRhmKrj7MfFN0shnalCUDdFtLSjKuzxrhhkYaMgLpmxzSnAFi5Q8fUMXM
   gczcs+7YE6MPYIgD8ViAxJ+jwh3UhOJXPnwpaEavWmOgUtDqDD0FzhC08
   eJiAVAitRTEK2cfbNQkve1kJxvt2F6TT8rqMZdIgt04+qwIf28UAd+Ipd
   w==;
X-CSE-ConnectionGUID: wvVM2pqLTluRST2v/TLRqA==
X-CSE-MsgGUID: uaFo0DRkRYKAD5WgCG4F9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="33635013"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="33635013"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 21:19:40 -0700
X-CSE-ConnectionGUID: 8s46y4kVR7KGVseUDkbvnw==
X-CSE-MsgGUID: afV/8OE1SO+xrwkSBic3Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="33584557"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 21:19:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 21:19:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 21:19:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 21:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vir7xgsq5oKdSMUBdTT3PB2ammftJiL4MSZjQLkdHTWvNgarohB340S0Lc8ntTALpCxGcYGz1U0oCvE/Si0tLCvXHwMvxmPN2iFLzv4g7Oef5qozab6gMPbw5CjZ4VQaMRfivyhb5lUqCs7G9sjrGYhh5JcerAONk7jm/29QDx0gaQsMaHi9kGmFssecHl1p3GKBHLA3YxFEKlufqwMXeo5Ykh8y7PYgmT4ZC3TwKL/rwG94BpAcS4Rf0z06cNgrVuB/0cpfAK+GTqfWetzQZ3TBYaOgkR/xVYA6xnH29nJm3CZDRVkM80hBI9eAVC2UmiM8bz7P7JmYxgo0NRZ8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xVnYrVu2ljv6GkeTnpgML3QY1tV6GKlTp/ahQswxzE=;
 b=dLnwYpY5KNdsd9+pROxrd1FIrS3pTejFg9nZpHigafu4UqOKLonaYJLwzwkmYiR1EF6sGcA+gr6z4HfcWnA2mO/nO2YHyP+hH5geaEzidQthlH49hMN1AyNhOD+9awW3suKFPd5aDvU1pTPIUjbpVSpPT76W1QSIZh41Nuye2u0m985ge+qZJN8HYJ3JXY9kFBWPM2Ik1kT8YeuvFqLjx142SM0zAZflWvdQ44ENjZkGTsca/KEWuwJ/qm6CgqomVyKNpqDPeMrGmuMGXXzcihobpAHkj5GEiErwSBTzfDtId0/GdcThVd9IywXvB9SoeLlvqLyheghWfsW2/j6SNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 04:19:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 04:19:35 +0000
Date: Wed, 8 May 2024 21:19:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Adam Manzanares <a.manzanares@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "gourry.memverge@gmail.com"
	<gourry.memverge@gmail.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	"rientjes@google.com" <rientjes@google.com>, "ruansy.fnst@fujitsu.com"
	<ruansy.fnst@fujitsu.com>, "shradha.t@samsung.com" <shradha.t@samsung.com>,
	Jim Harris <jim.harris@samsung.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Message-ID: <663c4ed43bc59_3d7b429436@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
 <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
 <66396c1938726_2f63a29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zjp4DtkCFGOiFA6X@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zjp4DtkCFGOiFA6X@bombadil.infradead.org>
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c4b97c-130b-4578-c619-08dc6fdf3c11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+XqTTR47ls2qxRTigivRJNY4ff2Q4cpnPYyvk1d+51yzF8KEadBs3mJba9Ao?=
 =?us-ascii?Q?3FRnFNYXKfc6382ybozuq9ysvlZRJTN5KLOrKjS142ql6/dwaGghS9PiyZHm?=
 =?us-ascii?Q?9/J+6JPDwzMgVCrikmfixQz5xfvLqxlq8STa0hUuxQZBwzfO3aOcZHG/PXS9?=
 =?us-ascii?Q?QtIPfoVZ72V5AlETAv3jpuUkDgjA4DPYjPoVh2oLIE5hR2U/fcb8shYd8tYr?=
 =?us-ascii?Q?P0pAbzFJhSlpd2JF/sNJUSUCE2iMrKNFInWXEQq59QINI8JhmH65scByekRp?=
 =?us-ascii?Q?C7Kvw9YFqDJfwHUR3hM1EiMY78J8fjs2Mkyx9LrUils07C6uZFU7NMVq/Aej?=
 =?us-ascii?Q?eixuwB+pNhLbEQLb/EYZwufTKzMfKem6/0hx43tX3vjIm++dyyX5GaPI1rWX?=
 =?us-ascii?Q?JJ4m2FXdRAhJraRMsETZcH2E20NI1yfyPEvF1Ialv38M37mzoDlLA4DbvdyF?=
 =?us-ascii?Q?a0A7KJZWtplZSY2KiNR/x+oImd+pDTakKjX/d/z8Lx52HRTez75vFDW+gTmO?=
 =?us-ascii?Q?gTule0mTieHhNpS1ZrB6I/z+r2CfFh1TvoFKHqWGhMyz8fW/zqte9+jIUvJG?=
 =?us-ascii?Q?p7OP4W4kGbDwXFpq0FqoBYrPD8Dxbn+HMszWDAM5ZRR2NrZNZn87Z+QHNqpK?=
 =?us-ascii?Q?0gCobQvdIdm2ZPEXPjuU9UJVMNBDHzpF+2JjOyFEdgtvuGAtk6/EDkzpxGx3?=
 =?us-ascii?Q?RZcIqNKQ/kVtrvnSnW7FCClxvfxM7nyk6y340ZI6hqsWSOB+WDhBA+EXJaKw?=
 =?us-ascii?Q?5/s/VFdBqv6p7QpQIwnLxaRssHKExVWv63As31Qpu8e/3OqCZ82pVSyIhog+?=
 =?us-ascii?Q?og8ZMvOeTFrW+KCIT9ZUkGEfQttOpkOnkAEcbSVyWzJy1eVAbX327gBWyOZj?=
 =?us-ascii?Q?Mo1v3Nfz2I+ZFfmFBVPKS89u/MxOvmp9U6GzgLsJvMWhqlzw+JouXJa9jCd8?=
 =?us-ascii?Q?2Ht4RUPvtgCcHu3E8CQgc/6k71l8hBymM+ctBHNcjLt65mnv81Cqx4tLTQ2O?=
 =?us-ascii?Q?xek+6DymbZnAgMefZmtgeyoBPjNovhzn8eeNtD3EpNL/gsfYwJZgaMZVW+J6?=
 =?us-ascii?Q?D4rdKgWxHe0u0aG0Z63Af+W9OJSL5t03wG6rNCtRT1JgQk9yaLh/v7x2U0j4?=
 =?us-ascii?Q?kNSIyF6hsvOnWBOXjcQk7F3rbqH1ziHxI3CWxETj9cw4dz+XeEHPQyvuGmuB?=
 =?us-ascii?Q?oMyl/Vyugcz1nF4Apf0+kz9tkH5Eu2WYOXoZgVzV9vuDRCftUOLpv/Jcmps?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D3xA0+pBLQO8JPRhbtfW4AueJLes+MyrhSFdUcQOV6ipZdBIBoxZsdcu9Dve?=
 =?us-ascii?Q?XrhnSLcDezfAZth5w0OUHYVVCVON5DUjQVsAI0q8nuyDyXRRAFpCrHbpvQUC?=
 =?us-ascii?Q?fncv42LmyIX/XrdIm5YaDB2RZDOfYH3xGlmt0TfFDM7Mx3bYploQzfjWgApG?=
 =?us-ascii?Q?SwSHmLLeYGFoA6kUpWbZHpol3mMcLfqrCKtclqGqnn1tftjys11RspEh/pYx?=
 =?us-ascii?Q?oS7rpQuRW+XuI2jGCT4w6y9ztMuEPiYZudjVlsdZ2+dvXB8+wkZUYA1A7nut?=
 =?us-ascii?Q?J6vhoNWA5eplhHVvsmR0lwt7HcRfJMrOijbjr+7ClhlR6fc8df71GT2mhBYJ?=
 =?us-ascii?Q?eFGlXYzb0UP/Mx2DhR8LSfPtYJBxhctwneskR8WVGfAAYtk96GsSjwCcbtSZ?=
 =?us-ascii?Q?Zt2HKw5Ssyc5s+kBKojTlt3sKvJMF3n0AcRUjV94JYpIiFTzoCW2obynJjHY?=
 =?us-ascii?Q?heUU1wCHTJZz4EeV90yQm3SZtBi4QSkP2GsCokse3Z3uDQQDhRFh4kTlt3xH?=
 =?us-ascii?Q?xHXJ9T+qhCmMvgudwrygEj33VnQJczXGw6XFS8lAa3+chh517FdQaCcAv2/g?=
 =?us-ascii?Q?Z7oLTuf5pROOpPP1fjJvIwdlSOyUXmvklm9pHQ76NQ94W1SRqWi7G61DvjBu?=
 =?us-ascii?Q?6h+hGBAra2ShrtSIoqpyGILHvx+SRKfBvTVnA77ivItEKTjyEapSRpQH5t4V?=
 =?us-ascii?Q?XF0VhwQnumCSt3s9P4UFVhy3ieTtwYXXr+KuCZkLj3vg/CSqssEfE7Y7seGt?=
 =?us-ascii?Q?s65bZSOrrC2IoWv2NUqCDc/FebzA2FRg6PepAXj85Gh8fBa6tB/6Uzmk82Nt?=
 =?us-ascii?Q?kr1kdxN6Mh0malP+gS6fHIiV1khc5St6ZW58sQfVrP4W9LsVUEuTUdpzb78P?=
 =?us-ascii?Q?wvdEhXJFb4Y1vGqSuUNeCKS8dGjZBUmABPCMfZfFsOqRLxG8fbR9eKFr9PCf?=
 =?us-ascii?Q?+GL/kogPr7yil38fFCMXgaYig1fxkpq3WUdjFJaH9GgSQgqrKu6tu0Egheot?=
 =?us-ascii?Q?U2adVKXp2msidgzlpt3vxupYvVMvFdzBANSWpIihxd5zAC+4f1P+L+/nYjk0?=
 =?us-ascii?Q?9u7xYcVWZeU4ps8BkolWn9VhDv/7x90vmv/wnJ7onJUH11PoItafbabatlf/?=
 =?us-ascii?Q?tUZ9VlIElfG8ceJDGpJEUNd17jdTHjkeBEYKRmzVCndMrb5kGpaIZ9h83zZa?=
 =?us-ascii?Q?prQmFD94o6D/Le4QFLxRN6Ukn+QULwmYrZ7qw/bVIBeF5ELOXCopXNl4bO28?=
 =?us-ascii?Q?uTrmBBxi43ZyQ9vbixW7OR1lKO0v8XlZugSppx7VVOwYuRDYmlZNHBZmT6td?=
 =?us-ascii?Q?ZIYxW6VBB2fckDnJ/FcAShutEgp5SYtDh5gsJutmLgJT0ROsc8Wz++Cba2U8?=
 =?us-ascii?Q?irusIZHEfMmArCUbedNSfilsWt0Y5dUwemiR227scZM/30Vn7gxi9iYvPdze?=
 =?us-ascii?Q?/gpZit+s9PWNldSs/IcDyw3OLCGfqtedBZwKYjIMQne35bfiELvXshjf3z8i?=
 =?us-ascii?Q?6eQaWwtTQIYzsHt0lJECyS+rXiGEAr4N/g4C6so0iQ6cgM2RerxkbWSlYPDJ?=
 =?us-ascii?Q?NXnwIoMtJWVu29w3Xi4AEcffBomm5etvvYPS7Vwz26GHCkVA4+3tvBw7IxQm?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c4b97c-130b-4578-c619-08dc6fdf3c11
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 04:19:35.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg+LsHkCbq/l2mfUAaczUi0jsNMMhaqY4ccwU5gqhZ/SYp+ANV91+P8iwqzyr0iP8bFPk1w+3rkiQl885wuYIeHm1MYxLP2FATZNUfPh7ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com

Luis Chamberlain wrote:
> On Mon, May 06, 2024 at 04:47:37PM -0700, Dan Williams wrote:
> > For testing I think it is an "all of the above plus hardware testing if
> > possible" situation. My hope is to get to a point where CXL patchwork
> > lights up "S/W/F" columns with backend tests similar to NETDEV
> > patchwork:
> > 
> > https://patchwork.kernel.org/project/netdevbpf/list/
> > 
> > There are some initial discussions about how to do this likely we can
> > grab some folks to discuss more.
> > 
> > I think Paul and Song would be useful to have for this discussion.
> 
> I think everyone and their aunt wants this to happen for their subsystem,
> so a separate session to hear about how to get there would be nice.

So much so that it sounds like BPF folks are already working on a way to get
this integrated with KernelCI?

Below is an excerpt from the Q&A portion of an OSSNA KernelCI talk that
alluded to this, but I am not sure who was making the comment:

https://www.youtube.com/watch?v=dxeaPCmkiXc&t=2077s

Hopefully folks who have more details about that BPF work will be around
next week.

