Return-Path: <linux-pci+bounces-27824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1EAB959B
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E91BA3B27
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC29221289;
	Fri, 16 May 2025 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8Ph6BpS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85D1F463F
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374478; cv=fail; b=ihE93rcuO79uY+ED9nGLBc9Cnt0m/Yoq5u4/zwr+QQjHrEhblfCbzkObbnpT9jErpRgUzLf5rUXdBASPQEoB7z37FtaiwKJVFZ7w4l2ATZk3Lt/yfcAKMUmnVzYIVin5JOXxUzTWR6WgiMH5HgMado0I59nosE0dlBu6e1bGa5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374478; c=relaxed/simple;
	bh=2I6C1ZRiwcXzNeLg+cFFXNLG5Ti0b3YRbhUl/yYRvoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PqJ4iJn2bzQke5BoBF6gjrgojDoUFUwA0gQYG+HbhlNhc3nwAROcGFk+kUvq1O+nR/1vzqtLQsf2D+nBVuwp6dlD2jgR8DtdT/VqgmiKfY/hUxhpHE6nuThHeHiudIh3dzpuxz9HZVWUnVxFPYe3wKFFd+0CrmJIJn/60pld+NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8Ph6BpS; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374476; x=1778910476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2I6C1ZRiwcXzNeLg+cFFXNLG5Ti0b3YRbhUl/yYRvoc=;
  b=T8Ph6BpSh4aLcp4taMkW7ZDtWeHZtTUgWL/iffAMAlP5QkFm4OVUyxt2
   XRaNNslnFJcH8W5LZkyxhaLDk8DYDF/ySJML251YqJ0fm/8HQk3lB7n2Z
   4DD28MaX8bhVBu9qfz2WZ9ICOZLeaIkbx1OD2WTs74HnqGAL0TvyHLn5P
   IM3AMs8fGA19Rjh7sMggrohSgCXRe9ymSuWLNiPLLOaePplPC5SCMSok0
   aqef3yv0MIIvquWP/lWNMS0oyVCZ+mGPDiI8lcrVQdcbh9P4zJmQJOMXS
   hyTzOVbnu+faCXjZv6RPnPPHxYRWHy6OlbhgPgXUsFAwZZ1rcSab8mTAj
   Q==;
X-CSE-ConnectionGUID: dnCbTb9QTQCFw6iKPvjnjQ==
X-CSE-MsgGUID: sAvKfVpfQ6uSSi3sn8Ltig==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36952792"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36952792"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:56 -0700
X-CSE-ConnectionGUID: ybpKFRzYTLKa/vywy3/S2Q==
X-CSE-MsgGUID: HsIV3NrXRrO7axeIb/w8DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139084706"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:47:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:47:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9Z8QPIZk45kmmRB02M8g6ISuTGlv2o3WZ7OYJf2prEIr04fJcKwBqQN17B/ggVkXvCTgmey6MOgGSqZsQHz8zG9FnUWIgPDevwCGHRMEyadwnthkHUnydzD2YDsK9yJPFqG+VYab2Bhzl/zsUCdqDhosob2nsPb8EMS857Cx1f1Oox7pY/x9qXCGBUpq3ve4gxVlik97eyZFI2M4jcIvkTgU/BCfuW++70RSs/bf8RKap0NiI/P3TKqTnWqYiTCW89KGoOpFAGH+e8B/kSg5VodBD5OIfhwQ5SDPn/GX9rJ+k2nnd5FTpK/XNyxnG6LYxmPs0DC/JwRUOFYux8EBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TJPUVlsjWHOjRVZkXPzCoSJvod4VAEcKrb4R/PzyuQ=;
 b=ubUJbVSdMkFJXWKMLdGkORb1eEONiTlUXnoX24drYDGs9H79skP8fNTaTiVMR/22+1Te6pMa8OSOapEHZywppQbQxGWlopDMa6KSAY8JROUVEaKN+70I+kpY2G/QpPJVKd7Q3GO/6s+KeOx9NJDU/oqAVDmYdq39KEJuMSmPh5sCXB4qtog6DjBnrIHGdLGixjURB+JWrQ9qj1aNfq/ZUF8hEw7niRia4QSQs3/PUtTy3u/b/Yc7HRW93L93S9NyidORfsTi4Vp9Qpe3FlP9TdMBsmffeaFY8rkhcN5HbaGLwajfDsc1tzFc5eBK6IJJHS229+o8CxOkDbLxdY3g9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:47:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:38 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Yilun Xu
	<yilun.xu@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 02/13] PCI/IDE: Enumerate Selective Stream IDE capabilities
Date: Thu, 15 May 2025 22:47:21 -0700
Message-ID: <20250516054732.2055093-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516054732.2055093-1-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcdbde8-9197-4d08-e2c4-08dd943d2a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tDeJzfOqR1Al6en6zCTQ4/fpGoKfuosu4jCSIoYvXbm6y02IiPwqaIAeINl7?=
 =?us-ascii?Q?k9dC9/gJDMqofM72bZQbohXvzEt42tnVObn6UVY11jcUOiRUeZc26urlORjH?=
 =?us-ascii?Q?x3ZnV/YHJOiS7PhNfj/MbaOiXIr/uRuindQdm7NQDrT77/yfrkHWN0vl4wvv?=
 =?us-ascii?Q?Dc62o1YV//otsXuMh+TmMermazK8FA1a3F587z4x2bhiXE/jC1CUe9xYoXwt?=
 =?us-ascii?Q?VNyg13RjL7ghcSQdsBtw02KhnGotIx3Qoibs1TvxeLM+V2djgL7bpG7rLiTV?=
 =?us-ascii?Q?CZKTQaevW2Xz1cUgbj19UVgXWoDt8lhChsxJIvlNFrmayYkgmO0aPHZLsax6?=
 =?us-ascii?Q?6YuRIRleDBZ7+cv1DOUlbjvamzE9u9KLDN47fUHPqFJrBVACuvcf8tfUzBRK?=
 =?us-ascii?Q?MXFSwxrvsYvjzBP5REgkG9E/CUHF/vhgfYH2MT34ZOIDgdtKT9T8bEmdp314?=
 =?us-ascii?Q?YYGQ9kg88uP7YwLd2kAAR+GL4b1zhs5mhpQjoMEvZOKz3mEAOPNDEg9219fo?=
 =?us-ascii?Q?jbhNpx3L8GDxUGXEgCw9CX3u4hrEhIdJW5Epuk7emZFO59+WihUL3pM8HoIs?=
 =?us-ascii?Q?hzQ6T/vFxuvRX3Ioxz9q4bUeLCdqE++MLbMhaM6Egt3mQO2n31Av9IpfbtAG?=
 =?us-ascii?Q?9Nvqln3Lzvz4OKEwm5ziaMNbR5+ock2WQRrskaCGo9M3VZsD5KGzpHBxoM9X?=
 =?us-ascii?Q?xmQrvYHxiBH7sw68EFwPzzbC1iiUZYmnHWbwWUjBCcghB2MHdTO/T4U+52hM?=
 =?us-ascii?Q?cX/9yh7vKD1wrUuYPJWHKCrPSsylgzI8t4iQGpOH9UP+yUzTdVQQ5nUSIK5a?=
 =?us-ascii?Q?tA3aQ+vl3JHQ6TKtGoz/bnJPy3Ie+ysq/CUXgGjlM3CPHxY6kg/GJhuHU7CU?=
 =?us-ascii?Q?CX0orAZ+yHEIcxKkxr1eawqYNfcsC3mOUQq9IxcM+KJNw0OkHMWIcUzBi/Pq?=
 =?us-ascii?Q?5OqjEe1MBY3epfEGpBbyRCzbmNPlhfIVvSCm6s9hSJoKUmXA7zR6JQ9m4YyA?=
 =?us-ascii?Q?yc8GVm0dQ2OuUt9VY5MXR89/GhNMfeQIudRBARLGQejqiY1yiWa8Ak7Fo/5D?=
 =?us-ascii?Q?UpHfYYwuFZU7wTJsfwbjaimA+0rYjW/gQKT0+br3VgPxd09KLn9FOSsCEn4k?=
 =?us-ascii?Q?0qN3IiWhk04JzF62h8TzPRVOM8FdDRTJZBD+02PCYXxI03CAbscSZX0PSlyj?=
 =?us-ascii?Q?FJ0I/ybpst3rkqieK5V+6XZNH6rFr/IPDsCHHrvH1+okedBGiP0Z3mlr0N7O?=
 =?us-ascii?Q?LmygGOZ5wWaJMbxbXNEtsZI7+ve7iUp3/F3pYZZKH2Jn1VdK5kJknnHF7qKC?=
 =?us-ascii?Q?ekhwBfDN3Ao8ZIu3QED4STdmUv26t87OlelqGK/n9rrugG/M7P2uIw67puZK?=
 =?us-ascii?Q?5riqYLog/6TrvD5AOUO1tK3w2UMD96w6CDuNa2DAFDLj5OoQrO1OPeAKfx3x?=
 =?us-ascii?Q?n5aYFvkmEJs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s73DvlGFyHOrxQOzf00p0agj9P6xgoDyuhtoTOwsGBjWyKhSbXexZFA3aBZI?=
 =?us-ascii?Q?142iZr7WbTxLCS5qv2whAH9QeLTUThIzJavYQfEvIZhIwtFI+W30DDdgO/2V?=
 =?us-ascii?Q?oYmRYX0LjG/TaVbUX3rFTvDmkIiYYEOg5szlZrYKCU71zQHEmNN61EppOZm+?=
 =?us-ascii?Q?Xtg5wxQZTRfRiaxn0jZpByLBZZf2PCZqvNFQ5C5te89gf495G/0IgwDzx4LA?=
 =?us-ascii?Q?l5ceb2OYI1OtQU3pDUkdZVA3YzXjmBW21r0LBtD3EJua1YRkGYhe6HC/cYID?=
 =?us-ascii?Q?XxcFIlw1kMZS9+8p/2XVxA2Zl5Zhap1lWK4XTiuoaR+po+edSYHN6xX3surk?=
 =?us-ascii?Q?NxJKQyRIjOXaobz7G9pkuNMVNxCP6VQIGBxvPpAu8xi6kc4yN6zXssgkr0ko?=
 =?us-ascii?Q?5Bg7rBoK08rILB5dO4wTTfb7iOtx+0xwkO3uOg62P0Pq9GW8cEqBbRgWZ8c8?=
 =?us-ascii?Q?gQAA30xdxdgTPL2wMpsjrGbVEJwkx3FzdT84WyqbWTNWBrcrfp9FtkKtZ0Rt?=
 =?us-ascii?Q?LdZWd7bJ6u3wXt0END8hHLALlv4jZjUC05xVV+EiXiEwex8aBI1CEbvpnIWF?=
 =?us-ascii?Q?rChjO8mwWWLHtSlTRm+z+LvsmyTi1n6TKMnwRgV+7eylWHPvaw8jxo0LCEj2?=
 =?us-ascii?Q?/6KyCiqP9CwApEKU323+4BT56tVJk/Hz0CBOWSvjdiM6ZCkutM0ZZS5T6h8S?=
 =?us-ascii?Q?L108nTcSsqA1Cpe/KCCyzLjTQsHnE628awxv11wZkaPUV6WF/ZRPjyV/WyFf?=
 =?us-ascii?Q?rbmkYIRl+aR9VZJlWXPtp+mgATM86Ei/XjOyMJMdJg9TZ41adZRWwYF2fMEu?=
 =?us-ascii?Q?d0yqZ6gXlzi7q+y7cwaxodHPMqYQYDMLDSgUyIIDe6JYXowoBaEnOgz4UABg?=
 =?us-ascii?Q?I61hiCaiBpHUgWTKcuMQIiUNQsNT4A5f1jBFjnRfq6typcOGPjjCiVmTEQHJ?=
 =?us-ascii?Q?aUp0N1Pgzfv42aep2MQjLcNEwGHX1fbOuyxhPQ0qrgXxef5zBx+/gy2p/NhA?=
 =?us-ascii?Q?ZwGXwWoO+lsLqXjH7Gdta7ZzEVzUuKf42gG+Vhlw0UeY3kg2GndeUxeTKMjY?=
 =?us-ascii?Q?ixOBap5uKkiXbE6DSe15hsIEdjvHgtNPKqvKhqcnFFRl2i+AAFvyoNZ8Qtl3?=
 =?us-ascii?Q?uYRnX5ItNkYjd7cg2GoSdTbhwD3jUpJ81iip2md7u3ckbGgRFrmdtx+y4xR/?=
 =?us-ascii?Q?p0pbDIFS/rjnZClcwr0/OpIhEQ+ePUwQ6leZpE1LOa2UKn1kRonULHov9/RL?=
 =?us-ascii?Q?syhuXcfwCps+20xlh3XKzt9rP+iQmCi9KXa/laflbBz9s9HSFeoVfBkfzt4V?=
 =?us-ascii?Q?qnaUAZsK1lj8IFrzXpqb6pN+A0bvOilHNakKhCI7Cz0V/kr9fIFt9/wMJRiX?=
 =?us-ascii?Q?ArBTAUg59Q/ggGDrfJMgtks9LuAff4iMNaCt3rXuDURk754EEfJTBpTBQHd8?=
 =?us-ascii?Q?IyylKhk9FCScLuKuv/n1vKSeBRj2cGi2gT1+XdNc9NNixO1tQ3szg5l0mMu7?=
 =?us-ascii?Q?9bQFNgKhwqjf67rpW5BaqrlM9aRNHGiPhF/nH6/1DibgnVC+N9d1jQGhxIUx?=
 =?us-ascii?Q?T4L7r39+hATm+vEo561dJqMPJygOul8fvWcyohdBKm/HE3dluXpY/7OQ3kml?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcdbde8-9197-4d08-e2c4-08dd943d2a74
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:38.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSN1x1VM990NGpQIFePx0xD1qh+GEUkFHCPGFXq9i+OODfDAlj4vlSmpPE8cXs55R7/VYxGZFlJtcNRpGI8QjJXYGpaXfZhnhfSUjfonY68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

Link encryption is a new PCIe feature enumerated by "PCIe 6.2 section
7.9.26 IDE Extended Capability".

It is both a standalone port + endpoint capability, and a building block
for the security protocol defined by "PCIe 6.2 section 11 TEE Device
Interface Security Protocol (TDISP)". That protocol coordinates device
security setup between a platform TSM (TEE Security Manager) and a
device DSM (Device Security Manager). While the platform TSM can
allocate resources like Stream ID and manage keys, it still requires
system software to manage the IDE capability register block.

Add register definitions and basic enumeration in preparation for
Selective IDE Stream establishment. A follow on change selects the new
CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
both a point-to-point "Link Stream" and a Root Port to endpoint
"Selective Stream", only "Selective Stream" is considered for Linux as
that is the predominant mode expected by Trusted Execution Environment
Security Managers (TSMs), and it is the security model that limits the
number of PCI components within the TCB in a PCIe topology with
switches.

Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Co-developed-by: Yilun Xu <yilun.xu@intel.com>
Signed-off-by: Yilun Xu <yilun.xu@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/Kconfig           |  14 +++++
 drivers/pci/Makefile          |   1 +
 drivers/pci/ide.c             | 100 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   6 ++
 drivers/pci/probe.c           |   1 +
 include/linux/pci.h           |   7 +++
 include/uapi/linux/pci_regs.h |  81 ++++++++++++++++++++++++++-
 7 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/ide.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index da28295b4aac..0c662f9813eb 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -121,6 +121,20 @@ config XEN_PCIDEV_FRONTEND
 config PCI_ATS
 	bool
 
+config PCI_IDE
+	bool
+
+config PCI_IDE_STREAM_MAX
+	int "Maximum number of Selective IDE Streams supported per host bridge" if EXPERT
+	depends on PCI_IDE
+	range 1 256
+	default 64
+	help
+	  Set a kernel limit for the number of streams. The expectation
+	  is that the platform limit is 4 to 8, so the kernel need not
+	  track the maximum possibility of 256 streams per host bridge
+	  in the typical case.
+
 config PCI_DOE
 	bool "Enable PCI Data Object Exchange (DOE) support"
 	help
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..6612256fd37d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_PCI_IDE)		+= ide.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
new file mode 100644
index 000000000000..98a51596e329
--- /dev/null
+++ b/drivers/pci/ide.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
+
+#define dev_fmt(fmt) "PCI/IDE: " fmt
+#include <linux/pci.h>
+#include <linux/bitfield.h>
+#include "pci.h"
+
+static int __sel_ide_offset(int ide_cap, int nr_link_ide, int stream_index,
+			    int nr_ide_mem)
+{
+	int offset;
+
+	offset = ide_cap + PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
+
+	/*
+	 * Assume a constant number of address association resources per
+	 * stream index
+	 */
+	if (stream_index > 0)
+		offset += stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
+	return offset;
+}
+
+static int sel_ide_offset(struct pci_dev *pdev,
+			  struct pci_ide_partner *settings)
+{
+	return __sel_ide_offset(pdev->ide_cap, pdev->nr_link_ide,
+				settings->stream_index, pdev->nr_ide_mem);
+}
+
+void pci_ide_init(struct pci_dev *pdev)
+{
+	u8 nr_link_ide, nr_ide_mem, nr_streams;
+	u16 ide_cap;
+	u32 val;
+
+	if (!pci_is_pcie(pdev))
+		return;
+
+	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
+	if (!ide_cap)
+		return;
+
+	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
+	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
+		return;
+
+	/*
+	 * Require endpoint IDE capability to be paired with IDE Root
+	 * Port IDE capability.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
+		struct pci_dev *rp = pcie_find_root_port(pdev);
+
+		if (!rp->ide_cap)
+			return;
+	}
+
+	if (val & PCI_IDE_CAP_SEL_CFG)
+		pdev->ide_cfg = 1;
+
+	if (val & PCI_IDE_CAP_TEE_LIMITED)
+		pdev->ide_tee_limit = 1;
+
+	if (val & PCI_IDE_CAP_LINK)
+		nr_link_ide = 1 + FIELD_GET(PCI_IDE_CAP_LINK_TC_NUM_MASK, val);
+	else
+		nr_link_ide = 0;
+
+	nr_ide_mem = 0;
+	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM_MASK, val),
+			 CONFIG_PCI_IDE_STREAM_MAX);
+	for (int i = 0; i < nr_streams; i++) {
+		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
+		int nr_assoc;
+		u32 val;
+
+		pci_read_config_dword(pdev, pos, &val);
+
+		/*
+		 * Let's not entertain streams that do not have a
+		 * constant number of address association blocks
+		 */
+		nr_assoc = FIELD_GET(PCI_IDE_SEL_CAP_ASSOC_NUM_MASK, val);
+		if (i && (nr_assoc != nr_ide_mem)) {
+			pci_info(pdev, "Unsupported Selective Stream %d capability, SKIP the rest\n", i);
+			nr_streams = i;
+			break;
+		}
+
+		nr_ide_mem = nr_assoc;
+	}
+
+	pdev->ide_cap = ide_cap;
+	pdev->nr_link_ide = nr_link_ide;
+	pdev->nr_ide_mem = nr_ide_mem;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..10be2ce5e5d5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -511,6 +511,12 @@ static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { }
 static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCI_IDE
+void pci_ide_init(struct pci_dev *dev);
+#else
+static inline void pci_ide_init(struct pci_dev *dev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..1b597b6e946c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2619,6 +2619,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
 	pci_rebar_init(dev);		/* Resizable BAR */
+	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd77e96..14467b944da9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -532,6 +532,13 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
+#endif
+#ifdef CONFIG_PCI_IDE
+	u16		ide_cap;	/* Link Integrity & Data Encryption */
+	u8		nr_ide_mem;	/* Address association resources for streams */
+	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
+	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
+	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	u8		supported_speeds; /* Supported Link Speeds Vector */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ba326710f9c8..90affa69edb0 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -750,7 +750,8 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
+#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1220,4 +1221,82 @@
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
 
+/* Integrity and Data Encryption Extended Capability */
+#define PCI_IDE_CAP			0x4
+#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
+#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
+#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
+#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
+#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
+#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
+#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
+#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Cycles Support */
+#define  PCI_IDE_CAP_ALG_MASK		__GENMASK(12, 8) /* Supported Algorithms */
+#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
+#define  PCI_IDE_CAP_LINK_TC_NUM_MASK	__GENMASK(15, 13) /* Link IDE TCs */
+#define  PCI_IDE_CAP_SEL_NUM_MASK	__GENMASK(23, 16)/* Supported Selective IDE Streams */
+#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
+#define PCI_IDE_CTL			0x8
+#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4  /* Flow-Through IDE Stream Enabled */
+
+#define PCI_IDE_LINK_STREAM_0		0xc  /* First Link Stream Register Block */
+#define  PCI_IDE_LINK_BLOCK_SIZE	8
+/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
+#define PCI_IDE_LINK_CTL_0		   0x0               /* First Link Control Register Offset in block */
+#define  PCI_IDE_LINK_CTL_EN		   0x1               /* Link IDE Stream Enable */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR_MASK __GENMASK(3, 2)   /* Tx Aggregation Mode NPR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_PR_MASK  __GENMASK(5, 4)   /* Tx Aggregation Mode PR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL_MASK __GENMASK(7, 6)   /* Tx Aggregation Mode CPL */
+#define  PCI_IDE_LINK_CTL_PCRC_EN	   0x100	     /* PCRC Enable */
+#define  PCI_IDE_LINK_CTL_PART_ENC_MASK	   __GENMASK(13, 10) /* Partial Header Encryption Mode */
+#define  PCI_IDE_LINK_CTL_ALG_MASK	   __GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
+#define  PCI_IDE_LINK_CTL_TC_MASK	   __GENMASK(21, 19) /* Traffic Class */
+#define  PCI_IDE_LINK_CTL_ID_MASK	   __GENMASK(31, 24) /* Stream ID */
+#define PCI_IDE_LINK_STS_0		   0x4               /* First Link Status Register Offset in block */
+#define  PCI_IDE_LINK_STS_STATE		   __GENMASK(3, 0)   /* Link IDE Stream State */
+#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000   /* Received Integrity Check Fail Msg */
+
+/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
+/* Selective IDE Stream Capability Register */
+#define  PCI_IDE_SEL_CAP		 0
+#define  PCI_IDE_SEL_CAP_ASSOC_NUM_MASK	 __GENMASK(3, 0)
+/* Selective IDE Stream Control Register */
+#define  PCI_IDE_SEL_CTL		 4
+#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR_MASK __GENMASK(3, 2) /* Tx Aggregation Mode NPR */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_PR_MASK  __GENMASK(5, 4) /* Tx Aggregation Mode PR */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL_MASK __GENMASK(7, 6) /* Tx Aggregation Mode CPL */
+#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
+#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
+#define   PCI_IDE_SEL_CTL_PART_ENC_MASK	 __GENMASK(13, 10) /* Partial Header Encryption Mode */
+#define   PCI_IDE_SEL_CTL_ALG_MASK	 __GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
+#define   PCI_IDE_SEL_CTL_TC_MASK	 __GENMASK(21, 19) /* Traffic Class */
+#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
+#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 0x800000 /* TEE-Limited Stream */
+#define   PCI_IDE_SEL_CTL_ID_MASK	 __GENMASK(31, 24) /* Stream ID */
+#define   PCI_IDE_SEL_CTL_ID_MAX	 255
+/* Selective IDE Stream Status Register */
+#define  PCI_IDE_SEL_STS		 8
+#define   PCI_IDE_SEL_STS_STATE_MASK	 __GENMASK(3, 0) /* Selective IDE Stream State */
+#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
+/* IDE RID Association Register 1 */
+#define  PCI_IDE_SEL_RID_1		 0xc
+#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 __GENMASK(23, 8)
+/* IDE RID Association Register 2 */
+#define  PCI_IDE_SEL_RID_2		 0x10
+#define   PCI_IDE_SEL_RID_2_VALID	 0x1
+#define   PCI_IDE_SEL_RID_2_BASE_MASK	 __GENMASK(23, 8)
+#define   PCI_IDE_SEL_RID_2_SEG_MASK	 __GENMASK(31, 24)
+/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
+#define PCI_IDE_SEL_ADDR_BLOCK_SIZE	    12
+#define  PCI_IDE_SEL_ADDR_1(x)		    (20 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+#define   PCI_IDE_SEL_ADDR_1_VALID	    0x1
+#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK  __GENMASK(19, 8)
+#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK __GENMASK(31, 20)
+/* IDE Address Association Register 2 is "Memory Limit Upper" */
+/* IDE Address Association Register 3 is "Memory Base Upper" */
+#define  PCI_IDE_SEL_ADDR_2(x)		    (24 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+#define  PCI_IDE_SEL_ADDR_3(x)		    (28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+#define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.49.0


