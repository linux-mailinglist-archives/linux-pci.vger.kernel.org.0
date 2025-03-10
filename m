Return-Path: <linux-pci+bounces-23348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4A0A59DCD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 18:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898D43A8A7B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F02237A3B;
	Mon, 10 Mar 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuwBtEvX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525F232792;
	Mon, 10 Mar 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627421; cv=fail; b=RdSkAfmS7pH03JF5LUH2sILkCiBKODyRNkvOIsFtqVDHanivYPKEC0Qui8QbndO9szIssmxtfE7hHmQTIeo0wfcDEQTAwI/9mk6CghUp8Lls4i2pEhFvSFRBixR7kVzJPQ593ZbbgfUVv9Ig72X3JklhKevEkn8wxh7ovYvIu1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627421; c=relaxed/simple;
	bh=ij0j3UWxE21hkhFtFC/aujud1RYH5bAsyjFVVRwpVMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MjydAGhwWSxroRFItFvSDdZ9NGpfMX3QlcF6MHubKJh/YiN6soxfAYbZGqjba0lyKVoE2Jiwa4E6SVzJJ7YkMefwbBitkgkuYZ5xxteNo580lhdR77IIqVxONq4Ev0ZNCNX9hcBsVzdX6HaQKaD3/wX0o6APmttvFFX1WxvmxN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuwBtEvX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741627419; x=1773163419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ij0j3UWxE21hkhFtFC/aujud1RYH5bAsyjFVVRwpVMA=;
  b=fuwBtEvXjE3kr0HDHmRKpCKh1WAsbPzjP0hUELtRCqK3oPYPlnDQ5FTq
   vAxIvNkk51eSqZlGMNvfABGQxN0wxoECVVINRYPJ5y29vUXn35NAEHmzn
   CYvbbqI1RLW6K/qsX5GLrzhp6uBTvcKUfxiBmIVLDHrVW4T48KKCSCcm6
   9Y8+INDn7dCNd675Ul20meOoBcBkSjuMRm04Uq/Ubb3wXcdGuk0WWLPrD
   yfEqKkrdk+RhOHzVAKyOcGqY5vXlp3n012YZNKhGU0jTA3Vgcr+o++aGT
   X7Jdd/N4xpibB0FkF3Q76Zp/nTKQK4T4FizwOIjX65QueLJHWYrO7dUO/
   A==;
X-CSE-ConnectionGUID: ldjw9oC8Q0ix7nfJl81JBQ==
X-CSE-MsgGUID: sMcYgmF9TzeQ1Ii9rPNWsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42350175"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42350175"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:23:39 -0700
X-CSE-ConnectionGUID: IwLDByCYRHuNJdT1Brhs8w==
X-CSE-MsgGUID: 8xRo/KaqRkqs3yqwr7gzLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120544320"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 10:23:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 10:23:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 10:23:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 10:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhAt7vkteeGC2VVOxRRyBxEieLTb2QuoCAerX68Q/ynT49r0y8T0TmNFoJi7yYtVKb1UFHqHU90/nbOvqEnedjElFCs1Hdj1W+3DHw+nsHHXH+x2vWRy4/qBMSpfjlkqAP6cKG+eO6f6aFU4i+jO3/dUzKG+6H1p2dmdICHz2tPBb9dkNP/hP3wRLUTz10KbqyE7ueVZ9hh6BJiyTRrlym5nQ8bswS977TKj+DtNEk9A1kxl17YOy4yLOFbNIToafnv2ZZCI4r9mC2XNmwIj1JOwmvDxGUua8YbJGVCVSlWF7nrPZIJAPM75JkvqT1sy6+fogyfo5KpVW+B3nD0A4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YrhbX8F9vlz71ulNO5GxcWKJ5fiETx2NxAe/JLxoz4=;
 b=bUOT8rv+oag4g8Gi4+WZtQJUWzF9pVbLhFN2GsvJMDCIOKIUZ0ysH9nvW/VMRUBow1Vf2ZUbKaUqX06K1t/3RGn5HHMJEp7wIwt13KS7pf3j6k2p2ZgkGt3YdancRHi2V5ZBzMLcmAthuurKYxGqz1f8T0yHP/eYvCkXDRIjSnWU8+u4TM0KDeF8eylGPtjV8nuxfAMafZsLaXE9QuAfkuvc5nIFgPjPvgLSzvzqMeSE8octmmsVOwcTP3Au/wFOkbCThFpoE1SmtkXsQiHezZQSIiCW1qBS0WCrWdUPUhDyI3IHIgR1LKqbLTpRvOagsdZqE3DVjUy22rjAupPB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8427.namprd11.prod.outlook.com (2603:10b6:806:373::19)
 by SA1PR11MB7061.namprd11.prod.outlook.com (2603:10b6:806:2ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 17:23:34 +0000
Received: from SA1PR11MB8427.namprd11.prod.outlook.com
 ([fe80::b156:b61b:d462:b781]) by SA1PR11MB8427.namprd11.prod.outlook.com
 ([fe80::b156:b61b:d462:b781%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 17:23:34 +0000
Date: Mon, 10 Mar 2025 13:23:29 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Anshuman Gupta <anshuman.gupta@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <badal.nilawar@intel.com>, <kam.nasim@intel.com>
Subject: Re: [RFC 3/6] drm/xe/vrsr: Apis to init and enable VRSR feature
Message-ID: <Z88gEQxr301VcJia@intel.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
 <20250224164849.3746751-4-anshuman.gupta@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250224164849.3746751-4-anshuman.gupta@intel.com>
X-ClientProxiedBy: MW4PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:303:b7::25) To SA1PR11MB8427.namprd11.prod.outlook.com
 (2603:10b6:806:373::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8427:EE_|SA1PR11MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: 56850fc5-b198-4d2c-f1db-08dd5ff848d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YrQoBhYcPpVSRrg2SYrirrfUtSFukGJrDc0JR4yfs76huFC/H2AFts0Hqbeg?=
 =?us-ascii?Q?o3hpVZmW+q2wYy7vboDMQMJtb+8A28P3UNyS+3hD6DnTrOT9qiYdzPQlvwBC?=
 =?us-ascii?Q?I2NALA+N2p6rjqAIyBZNbbY0g29enSlKUKEahxEBEROJzC4Fjnqy4uI1QSAX?=
 =?us-ascii?Q?FjHvktmnY3gMBU2TH6lVXlbnHCPVuHzQ4HUJcNG8/BFNzPj6L2EoekJVf/NW?=
 =?us-ascii?Q?GM7nQHFmnFdOotkjBoxiCwDR4Azm5sHUW/FqaaaStd1o1z2MNvQiUV5uuX6f?=
 =?us-ascii?Q?9KMbO3jUK8bgvz4lWwXl/WJoDrJ0saA9Yshm3I8fGaFylBOB9ZZFE3FtZHoy?=
 =?us-ascii?Q?QO+r+K0Gb1YZ+Gphqyx12rkXmpfsN9/eBEl7phge/zwhjcK3hHgGfgAi3Xq7?=
 =?us-ascii?Q?gE3FVaMy/78Guo/2ygpdyt/UoHK11wSCNh0fci4ETh3lpTkLC5Sd6MNNKgrN?=
 =?us-ascii?Q?Id9x8hVNY3LKdU65IoIEuISF1zfpjJ6CR6CG45ZbzYLGXnMDHW0szBGinm/R?=
 =?us-ascii?Q?kaEFNPJ0XizithtswcXryLNDWe642ixSA4hSTK2NAnLZN/Dj0MPf8u+yfWwp?=
 =?us-ascii?Q?+josUZfVTRA8h/gQXF7f+qWKPd9/nIYkKlKux/Mxxkiltm//y9D1mvm4Ryhb?=
 =?us-ascii?Q?Er0gbcTvxKB6U+MfyCm06uxcCbc7S6acJ/hgkQPdia8RwB8cePqZVLY7/oI1?=
 =?us-ascii?Q?mf0+bqN9wdBj+3innIbH4yhQEpLaxd/XkczzJ5UIEOlyp1tWUsJJVlSXoPEf?=
 =?us-ascii?Q?0PfpCB4AuDYExdAgRBa6cHxEZy3mdCy+URFFfWz7khtpy+/XZhMoOzjxR5Of?=
 =?us-ascii?Q?pf6GrNIo2Fjw5JXaWww9fWjNIOlkWEWhDC9um5YEX23zHBPTAsMm362r09vI?=
 =?us-ascii?Q?UTH1oNeZtqQrQuLIqyJNUrcJ0QeaBkLCbM1TgX2Qn1IVqIv4FlvrDh3qIlGR?=
 =?us-ascii?Q?GgpcPlp5Wj0EIGeDhKhoup80yXiU8ezANQc8B9lz8CctHRnYZxlRWUojE6VH?=
 =?us-ascii?Q?pws30Q/g6+naS2sIyOuNms/hTDLc9osfOc7+N8W4b4/AXRSlH1lqFoMjF+1V?=
 =?us-ascii?Q?ls1q6IQSqIEr1sAOgwAU6g3U8dYdKY3I+SBzGxcPMERz8Fha5ioqG+NYqxGJ?=
 =?us-ascii?Q?v+Jrrke9i7NmxsWIrwcyjhju6eTgS3Q2BQEhMeVGV/odTO361bF4cjPXyDvp?=
 =?us-ascii?Q?+xDHQXo/yPJXlDl2CBTJ+g7ZYUNEKmjtIuvqC5TZn8IgOufMIj38BRErO+k/?=
 =?us-ascii?Q?IDsckXSn95mA8ZGgt8XFT7sFh8BTXk31FTVz1pqTYsKG7cGs44G5czTUu5I5?=
 =?us-ascii?Q?xdtNRbFO7Aq0mREMrdSrqEwcOx4yzSRRuqTU6J5j/7a34i8zm0mnW2WcpcvB?=
 =?us-ascii?Q?wwIuj2G0N1fMWidfbLEMsrwp8ykH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8427.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qeDVNYr2kQvQhuPc7Hscvm99XJK8JOgSZahmMS9BnHEoS/cqpClwmkG5EPNf?=
 =?us-ascii?Q?6jfTdxVVplNobIgMkAH4u7pS2kTzNo7xzrzqmhxrGz8/7BvjY4TVxU/SxZwR?=
 =?us-ascii?Q?DJjCMztokQuRJgG7TTVbSlxLRbYUXtAAlXz0DklGW45KMW0WG1z4Qokl7Gln?=
 =?us-ascii?Q?CM7UjdFfC/YuTGeQ3l8qu1H+RHfeRip4xGr1VKem+28LbSnbPGBmKwB0pIBz?=
 =?us-ascii?Q?OZct8eGCnUqdnNSEoMBaEniKZsX06HVaqNC/KJ69HUBkt0Z0DI1N+6Tdzufp?=
 =?us-ascii?Q?CUVRqQ96ri/5prbCtg2RkxhIqSv3tZ5MNdY7I/Gnur+M4+tqY8vM+AbH6/b4?=
 =?us-ascii?Q?5W/eYj11E+wt2u3JZdIX54YNHQzskQqjzIGhfyPhFpcDEW3DeFL0bNPsL7iF?=
 =?us-ascii?Q?A8NFFWM/fP1vSMK/5EiyHdryFX1dAKvMi1Xyc7RTtJqkB88iVhneL3YfDf9P?=
 =?us-ascii?Q?NhIzhl1/NbBAfXXDXNXzfL2v/p6pakGfEv/4YTSM2eAF/CvcuzdPWId6FRQ9?=
 =?us-ascii?Q?ca6fmWU0ktzG7nOjtRmus3g/JZI6lq/XFHYUUlux0QsIbAY9hkVIweAjMdzo?=
 =?us-ascii?Q?kWvkqNzj2yleI5XLUVgg1FNs1ylg7Q5K9pak+/FNcsWsyO6XhIzEu/Xco5Jo?=
 =?us-ascii?Q?7j9iRy8KUq47VS/3lGNYVlvoLInTc4y0cgxTf6Q2LnBu/y/pGgzapJ8tln51?=
 =?us-ascii?Q?wv06rYa+jLqMP7qXxLxMF3Ckb3gZ3lJhRpqva2ElgAnRZVYC4MERF52Dg5iU?=
 =?us-ascii?Q?xEpqkulYGjgm/vGA9M8NonHfuaZaVLoPSBjQmPPyfUzo4PTzsCzsZDWy7WIA?=
 =?us-ascii?Q?lylGh7HywMI11JEd1EIE2YA9GiGP/ejzPN66FUmpSoGosBfDqI4k9giyuOz1?=
 =?us-ascii?Q?BeP62I3ROITpTjwxk/XBVXnw31/24IkgOuMpFRbbzN+BN3FmyD3HVDdxgRWX?=
 =?us-ascii?Q?uwaOeL97lSxKaEY5pEb2y1JN51I1/HgClH2lUiVW8O22+McYuWLbA4A9Bl0h?=
 =?us-ascii?Q?R7QcQZyM79lAMdO/6KsI6PIHm6Aby50k5josOSGl8lxaEpgsyLsVcAS+1QNE?=
 =?us-ascii?Q?RN58GihXwoEWsCzOAYF/r9oX8aOm8nv8Ag8R907FI1PYZvxAK/vC1LOiJq3d?=
 =?us-ascii?Q?S5ggvA7IAk7nMOjQsInyffCavKQ0PR0e5hhcIUgbVSp2BOx3622NWfeK6c5e?=
 =?us-ascii?Q?tsugiKabCdcya4qUK464yePauVbfDdIoU4BqEe4cMfuSWbZP+wOUrI3xi2Er?=
 =?us-ascii?Q?4dsqlM5+IgH8+07oE3Uh2ciJ7e0QMSkTAYhLpqWoRHn8D6eJtbYQvAWen6p0?=
 =?us-ascii?Q?Z1z/WpGDKHIkwgU/yzgiAgTJV6O/d+Bw0gtCb5qlQArTx6lHiXcOHrGmxTcm?=
 =?us-ascii?Q?G/qGVVxUWHkFPuNBFIEftYnEcJrhS3X0c3VGNmc7TdZ1fUIt83hzFdgjaIyq?=
 =?us-ascii?Q?/sojf2yGgLtqDmQzZyRh5ByY4uXQ/BpSDiKVh9wejj7a/uaJiFLwZtUO/6N1?=
 =?us-ascii?Q?zdr3WbSIPr8cX6HM+ZkyInxClmd7vxbb8jSLUj7MNTe5Ts9y6BqedBraQ2wZ?=
 =?us-ascii?Q?bmCZcfbP8AWztON9eocrjZ5ZUSQxn0GyEmFOZ2/hDMd6eZERyfyvGKtWx+qL?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56850fc5-b198-4d2c-f1db-08dd5ff848d8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8427.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:23:33.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmwJ1ygIdhhGUdB4zceC9asn03Ze6kfIMI866fkIWBePvv9kOr3S4Q89o6g/nKAzwVDZ/C2pptGKfnzQ9PT/QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7061
X-OriginatorOrg: intel.com

On Mon, Feb 24, 2025 at 10:18:46PM +0530, Anshuman Gupta wrote:
> From: Badal Nilawar <badal.nilawar@intel.com>
> 
> APIs to enable and initialize VRSR feature.
> 
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_device_types.h |  1 +
>  drivers/gpu/drm/xe/xe_pcode_api.h    |  8 +++
>  drivers/gpu/drm/xe/xe_pm.c           | 91 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_pm.h           |  3 +
>  4 files changed, 103 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index c2ab2c91c968..da7946b75cd5 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -7,6 +7,7 @@
>  #define _XE_DEVICE_TYPES_H_
>  
>  #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
>  
>  #include <drm/drm_device.h>
>  #include <drm/drm_file.h>
> diff --git a/drivers/gpu/drm/xe/xe_pcode_api.h b/drivers/gpu/drm/xe/xe_pcode_api.h
> index 2bae9afdbd35..17a90b2c6737 100644
> --- a/drivers/gpu/drm/xe/xe_pcode_api.h
> +++ b/drivers/gpu/drm/xe/xe_pcode_api.h
> @@ -42,6 +42,14 @@
>  #define	    POWER_SETUP_I1_SHIFT		6	/* 10.6 fixed point format */
>  #define	    POWER_SETUP_I1_DATA_MASK		REG_GENMASK(15, 0)
>  
> +#define	  PCODE_D3_VRAM_SELF_REFRESH	0x71
> +#define	    PCODE_D3_VRSR_SC_DISABLE	0x0
> +#define	    PCODE_D3_VRSR_SC_ENABLE	0x1
> +#define     PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY	0x2
> +#define     PCODE_D3_VRSR_PERST_SHIFT	16
> +#define	    POWER_D3_VRSR_PSERST_MASK	REG_GENMASK(31, 16)
> +#define	    POWER_D3_VRSR_AUX_PL_MASK	REG_GENMASK(15, 0)
> +
>  #define   PCODE_FREQUENCY_CONFIG		0x6e
>  /* Frequency Config Sub Commands (param1) */
>  #define     PCODE_MBOX_FC_SC_READ_FUSED_P0	0x0
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index dead236355d8..32583651988f 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -23,6 +23,7 @@
>  #include "xe_guc.h"
>  #include "xe_irq.h"
>  #include "xe_mmio.h"
> +#include "xe_pcode_api.h"
>  #include "xe_pcode.h"
>  #include "xe_pxp.h"
>  #include "regs/xe_regs.h"
> @@ -85,6 +86,92 @@ static struct lockdep_map xe_pm_runtime_nod3cold_map = {
>  };
>  #endif
>  
> +/**
> + * xe_pm_init_vrsr - Initialize VRAM self refresh
> + * @xe: The xe device
> + *
> + * This function reads the AUX power and PERST assertion delay from pcode.
> + * Then request host BIOS via ACPI _DSM to grant required AUX power and PERST
> + * assertion delay.
> + *
> + * Return: returns 0 on success and errno on failure
> + */
> +int

why not void?
we are not checking it anyway...

> xe_pm_init_vrsr(struct xe_device *xe)

perhaps xe_pm_d3cold_vrsr_init()

> +{
> +	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct pci_dev *root_pdev;
> +	int ret;
> +	u32 uval;
> +	u32 aux_pwr_limit;
> +	u32 perst_delay;
> +
> +	root_pdev = pcie_find_root_port(pdev);
> +	if (!root_pdev)
> +		return -EINVAL;
> +
> +	/* Avoid Illegal Subcommand error */
> +	if (xe->info.platform != XE_BATTLEMAGE)
> +		return -ENXIO;

I wonder if we should do a has_d3cold_vrsr flag for this, or at least
move this check earlier.

> +
> +	ret = xe_pcode_read(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
> +			    PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY, 0),
> +			    &uval, NULL);
> +
> +	if (ret)
> +		return ret;
> +
> +	aux_pwr_limit = REG_FIELD_GET(POWER_D3_VRSR_AUX_PL_MASK, uval);
> +	perst_delay = REG_FIELD_GET(POWER_D3_VRSR_PSERST_MASK, uval);
> +
> +	drm_dbg(&xe->drm, "AUX POWER LIMIT =%d\n", aux_pwr_limit);
> +	drm_dbg(&xe->drm, "PERST Assertion delay =%d\n", perst_delay);
> +
> +	ret = pci_acpi_request_d3cold_aux_power(root_pdev, aux_pwr_limit);
> +	if (ret)
> +		goto vrsr;
> +
> +	ret = pci_acpi_add_perst_assertion_delay(root_pdev, perst_delay);
> +	if (ret)
> +		goto vrsr;
> +
> +	return ret;
> +
> +vrsr:
> +	drm_err(&xe->drm, "ACPI DSM failed, VRSR is not capable\n");
> +	xe->d3cold.vrsr_capable = false;
> +	return ret;
> +}
> +
> +/**
> + * xe_pm_enable_vrsr - Enable VRAM self refresh
> + * @xe: The xe device.
> + * @enable: true: Enable, false: Disable
> + *
> + * This function enables the VRSR feature in D3Cold path.
> + *
> + * Return: It returns 0 on success and errno on failure.
> + */
> +int xe_pm_enable_vrsr(struct xe_device *xe, bool enable)
> +{
> +	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
> +	int ret;
> +	u32 uval = 0;
> +
> +	/* Avoid Illegal Subcommand error */
> +	if (xe->info.platform != XE_BATTLEMAGE)
> +		return -ENXIO;
> +
> +	if (enable)
> +		ret = xe_pcode_write(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
> +				     PCODE_D3_VRSR_SC_ENABLE, 0), uval);
> +	else
> +		ret = xe_pcode_write(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
> +				     PCODE_D3_VRSR_SC_DISABLE, 0), uval);
> +
> +	return ret;
> +}
> +
>  /**
>   * xe_rpm_reclaim_safe() - Whether runtime resume can be done from reclaim context
>   * @xe: The xe device.
> @@ -330,6 +417,10 @@ int xe_pm_init(struct xe_device *xe)
>  			return err;
>  
>  		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
> +		if (xe->d3cold.vrsr_capable) {
> +			drm_dbg(&xe->drm, "vram sr capable\n");
> +			xe_pm_init_vrsr(xe);
> +		}

perhaps move this piece of code entirely to the init function itself?

>  	}
>  
>  	xe_pm_runtime_init(xe);
> diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
> index 998d1ed64556..c9f176912b46 100644
> --- a/drivers/gpu/drm/xe/xe_pm.h
> +++ b/drivers/gpu/drm/xe/xe_pm.h
> @@ -35,4 +35,7 @@ bool xe_rpm_reclaim_safe(const struct xe_device *xe);
>  struct task_struct *xe_pm_read_callback_task(struct xe_device *xe);
>  int xe_pm_module_init(void);
>  
> +int xe_pm_init_vrsr(struct xe_device *xe);
> +int xe_pm_enable_vrsr(struct xe_device *xe, bool enable);
> +
>  #endif
> -- 
> 2.34.1
> 

