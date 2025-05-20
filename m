Return-Path: <linux-pci+bounces-28141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93592ABE5D1
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F212F3AD916
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B91252906;
	Tue, 20 May 2025 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3pUIOUM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48772505C7
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775535; cv=fail; b=Y6dn9ZCHwfxApav95ZjUuCuc1F5F8pP3dOxQeufGE2mW+aouP4k7VJ7YI2WjPunQH6qmcp7URmw6VDcrlm7JlvEpu/6KFShGnsY3t1At4A8OR8dvX82oVVAkpgqumNf0IQtr5JBlz0YO0YE3bdW/50rUUl345Z5aKd0e3I8Mt/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775535; c=relaxed/simple;
	bh=3J7bqTGbJXyALplLke+z+2J+IbXSsegXLv/yoGGxmuE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c57B2KubZLKqkqc+7usDvGvP4q8H9XDsTNjldVlh9tIiYcO/LIeHHuGB8grtMiGXWO3yH9Z0PmChVcKtORHQiLtxYmZ5hYiB2pFrHdMtgBRQnJHHdTrsnXoeVmqn7kJFMwBV5RMNdWrj9Fk6yjCAzB8vBPTGzoHOE4CAb5Sy4Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3pUIOUM; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747775534; x=1779311534;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3J7bqTGbJXyALplLke+z+2J+IbXSsegXLv/yoGGxmuE=;
  b=U3pUIOUMklWwJEnTCoG8xNJ01UtVvybikaeyo9t6fJ5b979diuOLD1NP
   mWqDW/VTzZToeyTe2NtS0vD4WJSmbRAsL9Ufs68SlSO5c5xydCTYZiN6R
   7+Rp0QqIhnQM0JZg7HlwOZRoJSW6Q7VGwa6Q9GvahzaA9tGM0Er/PZhu4
   1fTPPACx97CNw8LXs4kYAjO3K9nJM9F8D6IDcr4NfzjhXy4J7+mZFOPU4
   hWiCJ2dIQPa1ynwV9I3TkuGYsOxXzFTv6NuWi6Hkj03+RPO0B779WOK8O
   JbJ4uaKhrMXCN/CUfBNcyL/ies3Q8sfht2XGDsugIsYeLJklJ5xDcC2zo
   g==;
X-CSE-ConnectionGUID: bzZz1wT3SI2ET8sU5Tu69w==
X-CSE-MsgGUID: ZbmVK84fR6K180nwOg8sVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49629777"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49629777"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:12:13 -0700
X-CSE-ConnectionGUID: oFHRXHNQQrqTjphuECye5Q==
X-CSE-MsgGUID: uxr1T+KMQXiZaTalJTUapA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144772026"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:12:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 14:12:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 14:12:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 14:12:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8Kzcz1N5w1BvscUSCu/5SFPPw8zPF7NSZ2cT1YkmVGjOPCrX8qBYLIC1oyhiaYT0/PR9g5FrMchCwiyHCBYS1rnfpVPgZQzsEflbGNrpV7QuBZhsHlLguQ4iShRZhmW57Slyxv6ZmPyAb7wTPXBrMRXIxqRdv0d2p8hGhuXfbJ6RB2qZY2/Lpy+wuclkwjQLNzd2zGPFSRsD5l3n9/zJTwuacWsy/RqapPtiiGxkLB2TQoyEBbW+BlYgaecg2qu4h3UFAhMrv1MZY6oy+uXWlOnjLMh7TVQbtHpijNfYfiln+rzjj9B3ucNvgMQWYqioa6DVngg5YbmFfSe6wddcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi2J4POVRSCoN3SROy9T9tK6M8nmmDscDqXAqGWqkas=;
 b=yVGJIoGboYsNPnDUvG/9vxJ7ORP2gnkaw4m6CJUNIzryGh8dlxVA7kg0PmENwSKXMjiYL/zexUMo1pfsTvbGi887j/NkyBPzShMVQNZhDPLFRzpusLZ/+mUsXa4KQ+yhHsWIVGjidPckPopijYX5eufKal9jGcWIqEI8m7fswk50/30P33oA8e0rJHsMlA8RFHHMRHsVMDsGphpeOxeB6enqYRQMgbX29otDR+dYf7PylN+reM5SoblerS1jDdAOgS+nyGFiKJmKfuAflFCl0vmVk8yWlB+KXTkHq5Bc0cSfZUYKYsuRu9khxEYVz3tpEGwDQBhXiapsiqmNN2y53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 21:11:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 21:11:28 +0000
Date: Tue, 20 May 2025 14:11:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
Message-ID: <682ceffd717b4_1626e1006f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
 <363a3220-e43c-4965-b138-b85f09a5907b@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <363a3220-e43c-4965-b138-b85f09a5907b@amd.com>
X-ClientProxiedBy: BY5PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: 0644130d-7ea2-4f50-59e9-08dd97e2e2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YkS2x0e2z9twGnwnYxNanDTRGDVBS6pBV49Q33RCGLALxs/z/ctmsGJP8YaW?=
 =?us-ascii?Q?IiyGkMDmNSxmKS1L2e0QkC2OTLiUKkjinCw9dRnBuTqIF/fEqtoqybEofigT?=
 =?us-ascii?Q?C/tTyPgamtXHKFJ+GV1XV9jvILg4orSDRlke0ULiF4cXmUxq3+LBKC0do2mz?=
 =?us-ascii?Q?AC1IrCNkGhusXQhGEEMaossOqELjWKn3iZJ9CzzDjLLjNfXRy7PYdH2uYEJO?=
 =?us-ascii?Q?u8gFWojKO2F/5s3+gneEz4rii4ZPxz6QQVnLmQcwleLaPpphWJ1CzFvqCVK+?=
 =?us-ascii?Q?/y9c2nrj+tKdTlLniKi3v049yG0C/htHPQdFDb6hoQ4+fEL7hGO0Y2uzGiFq?=
 =?us-ascii?Q?D4nuRdGeNg7P1LRk6Qdhpuw/13TmJLgtkjhUoPIuMRQuQVAdzNlYRY3a6vxd?=
 =?us-ascii?Q?DmustHHVsebbpcgI2a6ZxiLN+JySkx7P4nKtinK9TMqDgqH0ut2H1aKoMcW1?=
 =?us-ascii?Q?PFXMUSntIZUPXLCP9yRVf9zIhiK8Kw/kRaH3Me7dD5egSGeYkKSaxKCTudZD?=
 =?us-ascii?Q?h9Q60kKCse0AR3bNocrCaePuEDhDwFOtYZwS2CezAZQf7byQsopjuc9mLg7z?=
 =?us-ascii?Q?QjONDCxPSseuqvmduVL0EtgyMB1F9Mec4GBdGRDgY0Dc7spm875BYKSw573v?=
 =?us-ascii?Q?07Bi4H6km15mjdmFQPZZ/VpmjgigkDfLPFo1YV1FlUTHUbU705Gz63r5kQyx?=
 =?us-ascii?Q?3wWwNJHdMN9J9hKL6tJcGcpJqrSJ07nbLCTkLIeAufdF6NREA3S9alUGz7pO?=
 =?us-ascii?Q?97nBYrcFHRkjZ5QSdz6kwpCdExWwq1b796umbGKaD6xL7CP5TvjAKSiwupVZ?=
 =?us-ascii?Q?D8gM5Rwld26dbJIvk9sAmYXw/kwE4SDyvfAkmBObYbPtxVzOaLIaX6CMbGCh?=
 =?us-ascii?Q?EPz+v3jw9ptLyixtODAUO2pjXdJCNNVkgECzLZgy5QvqT73XT2TyS1b3ZdlJ?=
 =?us-ascii?Q?n3JC+F5SnttEjGgkErsp4DLsNRd3NNO2YmFU1PvZK1QuQtAOlEOg7rCyiz6L?=
 =?us-ascii?Q?2qk0SgBpyqLgwyDMEvrNfInhqowTs8I2LK0uOU4HX3H78/QTeM+RoURxhC8O?=
 =?us-ascii?Q?W0Wul1HM7yQ/UkFd3zGUwHlB1A9/Byi2NS22mntX51dWntcKsrHvwUa2n2bg?=
 =?us-ascii?Q?tuFZuWpCsCOnOnI/c+BPV0hK4paURheWOJC4o46I8yPZA1FWKpxm7xG+B+yx?=
 =?us-ascii?Q?riqAHcyEAsf/85NkdPiz7GilmePI90X+TYUOnnS85huXqZXG9GHocXfVZQEy?=
 =?us-ascii?Q?fw0VmUNSBLIin3SO7hD+KZ0TPQrFsudbAcmOpXhw+uUK1eAtGdkL2LBpWyn6?=
 =?us-ascii?Q?WqSeejcbzTjnbvq1xoByRXRTlo8KJ/jFTO5V4Vy76YBVDkzOiahTB051xdx0?=
 =?us-ascii?Q?pWfaQcg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K4RGqsmYXbKWCYq9kz2SFO2qoYS/zHiNWRixkNeiz2O1av/40kdjuILP+sDA?=
 =?us-ascii?Q?kHTRF+Lq6bATZSZT8jvdmyNYBlH5/vDkUoECuHyiCPvAMZYn832D2V9sg7ds?=
 =?us-ascii?Q?PKuh2YWmK7CkGpbLh87A4db2wdAdeV4LvA2RJKX60vxOpKBKD59bniDUNVZN?=
 =?us-ascii?Q?dxAGLwvxX0549tZa0u96lYQacgxLeQQVG4oZzRWmFCMLkMh922hXOLMCz47+?=
 =?us-ascii?Q?WPGJnIWsg9wzsO2RdNAwbn9JOoZwdoNLlUnK6Q6awjsV6Z/hIbq9/jOn+byG?=
 =?us-ascii?Q?lS5Dv+6fzCKqYtudgcwhYSS4jNt2H238AY4NS2TGWs6I/jJ9Vroij59PEAZj?=
 =?us-ascii?Q?xCN50vt61fm4mIgo8wITJhdj678XCZCHFtcVNyylvGNjuBSJet2cvkfSyfcY?=
 =?us-ascii?Q?XHeGER0MV7k+h2zbSffAA4J6+a/Pp0Uc2pYKcafS7DKG9fOFQpBP9uraLEfq?=
 =?us-ascii?Q?EKFwBlWYqV6VKa6SnuZ+179L2+my+lIQaICVRhsb+CYnDJwHAeoYhlfiBmtJ?=
 =?us-ascii?Q?yy/u4oOBX8BjT06cc6TJzKKUI20K1IF9zWop8c6kv7A+J/2B4dxDvkglopWN?=
 =?us-ascii?Q?i+709AiQ/hKPJK3xsIqR/m8QBUBkzr3hE7+i8eQxTjMZwQSb7ZWN4u1kuKSL?=
 =?us-ascii?Q?wvRwpWAU+UhcjkNcV/LAmM58kScW09iTgUH4yfsmfyBS88xUGU2GRtuh5n1R?=
 =?us-ascii?Q?9qVP+3NTyWBDkO98ovGJbFzptdzwy5cmW2cB1FAiHXHc97NL3ibqo3EnidUV?=
 =?us-ascii?Q?LZAxfZQeRxGmyWjYlnKyo6tuH1pskaNYC2rLO5xWhQgKJUpHLYk71FliCsDx?=
 =?us-ascii?Q?Pfop2LPmNCjG9PwPgCF0e/pkujkAxRaqHRVPXcIILu5rG3dha+xorEr/CpK1?=
 =?us-ascii?Q?6n5oT1p3lM7nD+pPuUOKq8+MJd/Vo4R7EO7LO/QXw/YjIeuGVbfwMvKDA1aO?=
 =?us-ascii?Q?j9D6ag69BAtk23b90tpT9pqNi3oK4sig0QYgL1PrjYkonqYmacpwCsQn+GFD?=
 =?us-ascii?Q?LCofx6KFewxS4Mwc9gkjzyXO8NE/19Wb41NQL6SGEllDeBQ5/Qc39TnvGxQM?=
 =?us-ascii?Q?ZXyWNpapv92t9b3zFlzSvDRMkxZfUNUxW85tYNBRKb/mnowlYPRNGDsbZ7s0?=
 =?us-ascii?Q?AcNlv2JgvhbIfFZqkHrjFNz2pZ1fnk6Xqamq91yjbG4odL4OhfCS1/qPLg5k?=
 =?us-ascii?Q?0Zn5BVTH6JrW/inZA8R3k2qfdtbBYVsbo8nsUmkD/o8vU9VZvcVCO/uuHbki?=
 =?us-ascii?Q?z/ZjNm73dyf7f7p1NsIFlVW7sMq0K8nW1zy8BF3Pzw5AaV/m4llx1zjF3+ow?=
 =?us-ascii?Q?XP3JILbJ+z0D3D9jX/pn1zrze7AOOlDhSTK/1yLdmyqkdQIAAcAfJcHR4Pov?=
 =?us-ascii?Q?FmKaEFiw4BFyL70md5KDHryC470KQPK8OrO9ALq8uyaEUBZC/0sFIHHs6nFj?=
 =?us-ascii?Q?1XcqpW+4U8emgCOmzi2CDVtnMeSiIkfoA+299/LSHGiATk4rDlQBrijM4Gax?=
 =?us-ascii?Q?9xg+0hB2j+uJzyOjmiiF8i7dhHDpiG11aIYP1bR2SNeVc7udYlwbjf3Ug5Hi?=
 =?us-ascii?Q?fIRC+QmBeiFDYkUwcIZbFUf1F/MUMBntypF86DLGXz6U4O+3e1/epLRBGX1N?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0644130d-7ea2-4f50-59e9-08dd97e2e2f3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 21:11:28.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFj+CJrzDag7v4/sIs6tERCIX+mhxITMbSgPai+4NigDqe09WjsxIheFD5K+9g/pDg4ycVs7ka0M9JWck4Jwi7E7HB4bgxBBrrVciElSfHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5322
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 16/5/25 15:47, Dan Williams wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > 
> > Enable PCI TSM/TSM core to support assigned device authentication in
> > CoCo VM. The main changes are:
> > 
> >   - Add an ->accept() operation which also flags whether the TSM driver is
> >     host or guest context.
> >   - Re-purpose the 'connect' sysfs attribute in guest to lock down the
> >     private configuration for the device.
> >   - Add the 'accept' sysfs attribute for guest to accept the private
> >     device into its TEE.
> >   - Skip DOE setup/transfer for guest TSM managed devices.
> > 
> > All private capable assigned PCI devices (TDI) start as shared. CoCo VM
> > should authenticate some of these devices and accept them in its TEE for
> > private memory access. TSM supports this authentication in 3 steps:
> > Connect, Attest and Accept.
> > 
> > On Connect, CoCo VM requires hypervisor to finish all private
> > configurations to the device and put the device in TDISP CONFIG_LOCKED
> > state. Please note this verb has different meaning from host context. On
> > host, Connect means establish secure physical link (e.g. PCI IDE).
> > 
> > On Attest, CoCo VM retrieves evidence from device and decide if the
> > device is good for accept. The CoCo VM kernel provides evidence,
> > userspace decides if the evidence is good based on its own strategy.
> > 
> > On Accept, userspace has acknowledged the evidence and requires CoCo VM
> > kernel to enable private MMIO & DMA access. Usually it ends up by put
> > the device in TDISP RUN state.
> > 
> > Currently only implement Connect & Accept to enable a minimum flow for
> > device shared <-> private conversion. There is no evidence retrieval
> > interfaces, only to assume the device evidences are always good without
> > attestation.
> > 
> > The shared -> private conversion:
> > 
> >    echo 1 > /sys/bus/pci/devices/<...>/tsm/connect
> >    echo 1 > /sys/bus/pci/devices/<...>/tsm/accept
> > 
> > The private -> shared conversion:
> > 
> >    echo 0 > /sys/bus/pci/devices/<...>/tsm/connect
> > 
> > Since the device's MMIO & DMA are all blocked after Connect & before
> > Accept, device drivers are not considered workable in this intermediate
> > state. The Connect and Accept transitions only proceed while the driver is
> > detached. Note this can be relaxed later with a callback to an enlightened
> > driver to coordinate the transition, but for now, require detachment.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   drivers/pci/tsm.c       | 160 +++++++++++++++++++++++++++++++++++-----
> >   include/linux/pci-tsm.h |  15 +++-
> >   2 files changed, 152 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > index 219e40c5d4e7..794de2f258c3 100644
> > --- a/drivers/pci/tsm.c
> > +++ b/drivers/pci/tsm.c
> > @@ -124,6 +124,29 @@ static int pci_tsm_disconnect(struct pci_dev *pdev)
> >   	return 0;
> >   }
> >   
> > +/*
> > + * TDISP locked state temporarily makes the device inaccessible, do not
> > + * surprise live attached drivers
> > + */
> > +static int __driver_idle_connect(struct pci_dev *pdev)
> 
> Do not need "__"...

I am ok to drop. The thought was to make this nuance stand-out more, as
one more level of indirection than typically necessary, but no need to
push that preference.

> > +{
> > +	guard(device)(&pdev->dev);
> > +	if (pdev->dev.driver)
> > +		return -EBUSY;
> 
> > +	return tsm_ops->connect(pdev);
> > +}
> > +
> > +/*
> > + * When the registered ops support accept it indicates that this is a
> > + * TVM-side (guest) TSM operations structure. In this mode ->connect()
> > + * arranges for the TDI to enter TDISP LOCKED state, and ->accept()
> > + * transitions the device to RUN state.
> > + */
> > +static bool tvm_mode(void)
> > +{
> > +	return !!tsm_ops->accept;
> 
> tsm_ops->accept != NULL

Yeah, that is a bit more idiomatic.

> > +}
> > +
> >   static int pci_tsm_connect(struct pci_dev *pdev)
> >   {
> >   	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> > @@ -138,13 +161,47 @@ static int pci_tsm_connect(struct pci_dev *pdev)
> >   	if (tsm->state >= PCI_TSM_CONNECT)
> >   		return 0;
> >   
> > -	rc = tsm_ops->connect(pdev);
> > +	if (tvm_mode())
> > +		rc = __driver_idle_connect(pdev);
> 
> ... or just open code it here?

I will do with dropping the "__" and keeping the helper with the
comment to keep this function less busy.

> > +	else
> > +		rc = tsm_ops->connect(pdev);
> >   	if (rc)
> >   		return rc;
> >   	tsm->state = PCI_TSM_CONNECT;
> >   	return 0;
> >   }
> >   
> > +static int pci_tsm_accept(struct pci_dev *pdev)
> > +{
> > +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> > +	int rc;
> > +
> > +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
> 
> Add an empty line.

I think we, as a community, are still figuring out the coding-style
around scope-based cleanup declarations, but I would argue, no empty
line required after mid-function variable declarations. Now, in this
case it is arguably not "mid-function", but all the other occurrences of
tsm_ops_lock() are checking the result on the immediate next line.

> > +	if (!lock)
> > +		return -EINTR;
> > +
> > +	if (tsm->state < PCI_TSM_CONNECT)
> > +		return -ENXIO;
> > +	if (tsm->state >= PCI_TSM_ACCEPT)
> > +		return 0;
> > +
> > +	/*
> > +	 * "Accept" transitions a device to the run state, it is only suitable
> > +	 * to make that transition from a known DMA-idle (no active mappings)
> > +	 * state.  The "driver detached" state is a coarse way to assert that
> > +	 * requirement.
> 
> And then the userspace will modprobe the driver, which will enable BME
> and MSE which in turn will render the ERROR state, what is the plan
> here?

Right, so the notifier proposal [1] gave me pause because of perceived
complexity and my general reluctance to rely on the magic of notifiers
when an explicit sequence is easier to read/maintain. The proposal is
that drivers switch to TDISP aware setup helpers that understand that
BME and MSE were handled at LOCK. Becauase it is not just
pci_enable_device() / pci_set_master() awareness that is needed but also
pci_disable_device() / pci_clear_master() flows that need consideration
for avoiding/handling the TDISP ERROR state.

I.e. support for TDISP-unaware drivers is not a goal.

There are still details to work out like supporting drivers that want to
stay loaded over the UNLOCKED->LOCKED->RUN transitions, and whether the
"accept" UAPI triggers entry into "RUN" or still requires a driver to
perform that.

[1]: http://lore.kernel.org/20250218111017.491719-20-aik@amd.com

[..]
> > @@ -558,11 +675,11 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> >   	if (!pdev->tsm)
> >   		return -EINVAL;
> >   
> > -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> > -	if (!pf0_dev)
> > +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> > +	if (!dsm_dev)
> >   		return -EINVAL;
> 
> A bunch of changes like this one belong to 12/13.

Whoops, yes, missed that before sending.

[..]
> > @@ -135,6 +141,8 @@ struct pci_tsm_guest_req_info {
> >    * @bind: establish a secure binding with the TVM
> >    * @unbind: teardown the secure binding
> >    * @guest_req: handle the vendor specific requests from TVM when bound
> > + * @accept: TVM-only operation to confirm that system policy allows
> > + *	    device to access private memory and be mapped with private mmio.
> >    *
> >    * @probe and @remove run in pci_tsm_rwsem held for write context. All
> >    * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
> > @@ -150,6 +158,7 @@ struct pci_tsm_ops {
> >   	void (*unbind)(struct pci_tdi *tdi);
> >   	int (*guest_req)(struct pci_dev *pdev,
> >   			 struct pci_tsm_guest_req_info *info);
> > +	int (*accept)(struct pci_dev *pdev);
> 
> 
> When I posted my v1, I got several comments to not put host and guest
> callbacks together which makes sense (as only really "connect" and
> "status" are shared, and I am not sure I like dual use of "connect")
> and so did I in v2 and yet you are pushing for one struct for all?

Frankly, I missed that feedback and was focused on how to simply extend
PCI to understand TSM semantics.

Part of the motivation is reduce the number of details that
drivers/pci/tsm.c needs to consider. I.e. there is only one ops object
to manage. Can you share the lore links for the comments that convinced
you to change course? Maybe those folks can chime in again here, but I
might have been too focused my tdi_dev object model concerns to notice
those previously.

As for repurposing "connect" that also comes back to question of whether
userspace needs to see or care about that nuance. In the end "connect"
is "prepare this device for follow-on TSM + TDISP security operations".
If the "accept" attribute is present userspace can infer that it has
more work to get the device operational in the TEE. So the interface can
indeed be more verbose... but to what end?

