Return-Path: <linux-pci+bounces-27821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 058C4AB9598
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CD51BA4455
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822BC22154D;
	Fri, 16 May 2025 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gthrMX5O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333A221289
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374471; cv=fail; b=kq/VXC46xVAFnNCIQb184G8E3IvbKpTqF2tNkWZRfMreDu32bS9tfnYN6ZRvI8ZTBxfoOtnb01E7XW8PcCQVannmL+bJ6/neQ6YidxhJ0PhCDpe/a+bXK5quuSf8fAjcvX7afWdicS4zk2hDkwnezJzKA6rRaSYcwkEdQl2vhO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374471; c=relaxed/simple;
	bh=cQlukaf9a+p7R+ijWOlKiKphaZ62mXzzYujn8XYYxKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGbaK1FkcMmBAPCmICxQBdf3QPBA2ub/nN4cbcTxukJ9kA/U8apWs2Nba/3fPn497dcZcnByi8Jc++taiPyB4inE4qAE0SKUB++vKMltFl2pgq+hiPMOk4eDMmnm5gP8W/EwQpExYO+vSzpBKQ9lu0picDPraOD+Em8WbHL+sjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gthrMX5O; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374469; x=1778910469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=cQlukaf9a+p7R+ijWOlKiKphaZ62mXzzYujn8XYYxKY=;
  b=gthrMX5OZEeXjesH/pqJqyOg6ahRfgRJGTkqMPcD+1hGw977PcnmRQUW
   7nOAQoT6pR5m19p9K+Yjc1ItnyAmDDfrGYJkaIq/z0kWFP4aLuTrHSDc9
   zAZXhSMMY1E+gTFHOUK4jVMxWVc830EygUsIZ4wb7IriUwoSaW2cV6Wld
   6fuPLn53sz4Cr8BPAvmlkTfWSsCSQvo5D52yWrYydIFdBuqZlzjzGSc+u
   QkDeQ3lZ/9Zb7Gzj2rT/QEO5ftMf4EOYlSFFIlH6hj+G1b7g4v9z5BqeR
   XxZ4JoSV0qEnPo8/dTKyrvO6Aq/izMa/LA2E5a3l2ROyzce1ECZNg4kxK
   A==;
X-CSE-ConnectionGUID: J0s04+fOTs+g+PV91SZ/CQ==
X-CSE-MsgGUID: P3KK+R/kR2i0yGaBCFxwDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36952763"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36952763"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:46 -0700
X-CSE-ConnectionGUID: ZjXJySKwRr2TMvuW8O9qAw==
X-CSE-MsgGUID: 6RcR67fJSLe7AujG+wrvig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="169654630"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:47:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:47:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:47:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2OzK4ag9QDpzizYENsMWXJQhY6Tmi6qdTcH/NMQMYkxRvBvSJXDtBkNwalyeerCfWTINdGUihMr4J7r4fukbp64AJP2r9qwVjlPuQH8YeG+jwMl/JZ4YbtvG4B2ni1D7isH6y2lIS2fTEs7bnk9BuVDI6Hdsyk4MlMMKaSR0A2V19Bg3b5A4LMK1jsM+ZJvyuJ1UbCfQHJ/qZ4Nv1P/05j6ZcQPp5oiqmGKwXQSqLuf588w+TpnqDTl1P2gWSWM8qjxaSp6AqYSZSIJwtFqBnlEkJtjXv2iqMU+Lu+tD9L1QpethKDaQI4yXYOR5hUHqRAFOexAE/hGS+GyWjhfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DleBelsqhb3QknfS8gQVPWtIf4HRMKWrRm+hksAFs8c=;
 b=CEPV8fRFh219rUu/38YBmktmChnBv8aYBAREY2LO8mfIgkdhTkxga9UkPb5CXtpbiA4W0Y87p45FZ88f+6BbLcafKQ4CWd+BsUHxruwk76Y8EsY4CmB3i0AZmhgvQM2nmeB8l/QBY14WjsOrQJ3yAp6WRzG6UezJCJlM7Il3V3srOEQQ0yFV007/a7atOwDkZ/o91sq5BrgSpQ65LwqViJNY4rqTo4nYKai1Tge6u0Bcc4Adnvuwt5+WmZdVlFbB02xv9466DuJWn+o9367rjD408H+yIWnngHLvM3VsH16F8GdPqiWO5icAo0EDYe7MD9QUYMeZf7FXdim+NW40cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:47:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:37 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, John Allen
	<john.allen@amd.com>
Subject: [PATCH v3 01/13] coco/tsm: Introduce a core device for TEE Security Managers
Date: Thu, 15 May 2025 22:47:20 -0700
Message-ID: <20250516054732.2055093-2-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: bc6453db-4b9b-4bda-7f4b-08dd943d29d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kMRv0eTqZck3sRwApjcyKhpmeb8LyRgZUfq+AiII64lPccquOw9+lcpEaeyW?=
 =?us-ascii?Q?RB21z6sjFSp5XOlF+0wV4mxxoeC2nQ/cvGfHArTIDczdXJjCLkQ0YXg6Bqst?=
 =?us-ascii?Q?SQ+x/n0BXBfm9dRmmOseJJ925oTJPwELgJJ6PrWmipvYQPVOkxIhQsedj2yy?=
 =?us-ascii?Q?b/fntKhS0y2s7Nd+l0oMltykxLERHunT/JXy2ExqYBrHrYcabRWsG8nHkuTW?=
 =?us-ascii?Q?B+wYUZ0FmEw1OxgpiKm0MO6ENJqxcRIS1C6JSxRn/TUCqnL9GDpOEAUs4tMR?=
 =?us-ascii?Q?XJ2BJtXh/PXMJRet2E/USdd7dQa7CrLFUM4HVqjjisKtsoXmgs81zCQGY3VM?=
 =?us-ascii?Q?QzztVYb+ly9ZqMIDyAv4rKbipbuR51MZSdqyfJ4vEGkG4rZwhlESIi7gRcdl?=
 =?us-ascii?Q?Dv+xrrVVmV5CzTKDbJ6diD8D4ORYFaWEvHQtatSHj9I9gAIvLAHtLUAB/5tC?=
 =?us-ascii?Q?UtGm9Hqd2gakjQIjw6HmBUUYJdcsnemHtXvsPtjhHxjxn+MJim6lJTR3tN94?=
 =?us-ascii?Q?JIx/ALDzScSd7i7pwkYRE07Byepsa1ARn7EZDlijJAv04Zs2AiUq5E31d9p9?=
 =?us-ascii?Q?8tDWABLxjERpkW2fqlx1nP9DJbZ0gcHWSUG75Pza0QAEF3p5Fgk/57RctJNQ?=
 =?us-ascii?Q?/lxHnPdVasG4YdoSCAnjOZEvomSZ8M21lVp57sjfezHYAcS3WmYd6vDsfsG/?=
 =?us-ascii?Q?xnZ2LLs3L6wsZ+wZxoXjv4sIZhr2tt3XvhbYy1gtPGSCiq+7Gis2jmugcsuv?=
 =?us-ascii?Q?NVa/VazBfWtukuMiGbltz0BfW5Engv7Nxtc/WT55neIKmTnIf2k8116EL5HJ?=
 =?us-ascii?Q?t83XpQ1+RmEWsolu8JfiRY3iOhXZKCH9oHlWpuLgddppDGgu54WH4Cl0+P8W?=
 =?us-ascii?Q?NBEzSNYS2v7kzwCpW2V3B34O86XpAdvFvSGeoshHtbkO7XlBpmFaqulXLB/e?=
 =?us-ascii?Q?Shi1YxhTavA5r7dmMuUc+nzsDgZdm4UmB29N5S2fE65WcoLjTAlabQpVB9qE?=
 =?us-ascii?Q?kDIHcA2LDPt++FgfYsADJgmqIYPOenwMzoD7Uy9lkRklNd2rMhBEjacAEOf7?=
 =?us-ascii?Q?oiyytrV4ua5Pt947+QRzrul1DMLYcl2BSjzPc1fm7lq6xPVQn6miRux1GuHv?=
 =?us-ascii?Q?6qVSQqupgL3/A67/ZEjfxMN6nc3ui0w47Z2S6L+9yYa2POPqQG4RmatjgO5y?=
 =?us-ascii?Q?wvR+gsT3NPLIqNdv2p46GVU4+NEEz8gmwZyTiZ49oyKtg3p14VwYuOLJ/hsZ?=
 =?us-ascii?Q?Np5zLAMy+Vf/wnsxM7t1Cl8gvTjjJQzgKHF6Wex1F1lntyzGEaTsYqpVRTmn?=
 =?us-ascii?Q?fxnCz1ZFt80rodlknlMDMcO9/ah15S9TT/c80vSX/gPU/rrmXVL/boRBQS+q?=
 =?us-ascii?Q?RxQySV8YG6VPrOir5JxY0Mbs1k34aYMNdheDGYhrKI3puKefqqUSBVia2TC+?=
 =?us-ascii?Q?DbDvvuGF8Zw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uLhtrnQtOlUEjY/eN8xfEOD+bsdQl6OPJDMiv91EIDJI90vCbek/IQ8Fsntu?=
 =?us-ascii?Q?+H8tvSdhsWfRbZXVfEh8b2dMWtAikougu4hnbBnO3tZUDtW8sosXFcrY7Z8n?=
 =?us-ascii?Q?csbD7jf4ELzD57iTxQmbT/kcUJE1H608PR0NHU+mG76Wvaes/24yv7sW/BmH?=
 =?us-ascii?Q?+zpgHfNwPSLwRKsyM4SRwscsq6zUj3yD7LFr9jZtvB7JAERH+Foh2eoq6hPH?=
 =?us-ascii?Q?7j3qZIi3yn6Prg+R2cjmfOHSk7omFIMRcO7HuRL4wf5dbyD4HQlDIPJJ1eH4?=
 =?us-ascii?Q?Qxa64hU3DFHB2zVFOB/njBZUKF/lqTVfkBQ9r+2E9D8wyV9uoZHot4mSXdoV?=
 =?us-ascii?Q?FHx/skHOUpJ4ShhO3xnCPCfDQTEzmqDzm4SATzX83zOJujwEykCQeEWnIzJI?=
 =?us-ascii?Q?jeI/7yfYtSnh8pig4FMEEPc2OW+5W23yfyEY/wgxfZSX0JoxkBaJ+exkQwy8?=
 =?us-ascii?Q?25MkTwLkFoAX3kt3dCKsXCdG4+rlr3AGXDBAoBsx1gJvbtPdSxWp8kYhcvjI?=
 =?us-ascii?Q?8V3GDB2iz8BHaoiQX9d0x6tX78Xm0+IfYx2Q+Of0mpLHaC+xFYdESQsuGAAZ?=
 =?us-ascii?Q?oHqqnVv3yH8g5nHk2KEXQFhBn2Tx9jfVRntZRHPVL4sJj6QRobUoz2mnhNls?=
 =?us-ascii?Q?Htgj5Og6E0Eac0R96yoBBsXayjkngOTaSK5c/De73i8/ojFRxk/DImCk1v3+?=
 =?us-ascii?Q?Y0gbmxDjC7ZumWUssJhRhWjBkAWaoR9etlFPN8e5LB4OOUKnoJKmTpcc1yEO?=
 =?us-ascii?Q?4vKhiL9yftRCT89zCozluCn4S73JVqoOgRJWvenRSqI3hrp+cgOGtOiJxDGY?=
 =?us-ascii?Q?aTZL7FZIfeAtnpkcHatTYwTVNkXm9/dxjdXfO1djNFyJLxOOyb5Q0I65MwaS?=
 =?us-ascii?Q?40/vFsyYw9SSZNyjm8YU0A9MfLEr0RxtMzcZnZ4WYY2/ShC0jup0zVnbVqVg?=
 =?us-ascii?Q?WmRVueskHic1wht5iodu0gT1CgoFXj06NmvlDyd1CgTAusLQ74qyaMjhBdFd?=
 =?us-ascii?Q?EQ7mEVSqvNO6UqrYihj6RxNFjjUC4fHT+++wwRct1kpri1ZZ1ZrRtGAKlWot?=
 =?us-ascii?Q?K+nZnCyeWIaECeVOoO/AaekDyK0s2E8IC26wqda4fs9TJX3+oAI51mshOF+C?=
 =?us-ascii?Q?KEdBPU+mBDfbV+XWDSlLy8mnyLMHQpjwOD3igGut3TbTeHChemCajEdUQyDi?=
 =?us-ascii?Q?Yeh1lADPatChAnoNk7MGI1iNd3+9meO6ZAAtakhltci9shy2BmYP5w7vVas3?=
 =?us-ascii?Q?g3IynxNTbWdxT1YJB/FbRFV91Ml/NZnJWTB/KWCBiOA8bYR+SY2JNEqComHl?=
 =?us-ascii?Q?Cr1o7/KXH/aKjwIkNZWPZ3M/ortmN9+S53hg215GIKen9jrKStrJG7M5Vo9i?=
 =?us-ascii?Q?vsxjby+Un+F052D5DeE3KFBUyN6heZeyaXauFISEsPbYLKIqKE2BGeBOoGJ0?=
 =?us-ascii?Q?7zgJc9alQr16sVNzNyvJZligOqfHjXqfLHDOzTQjyMH1iWExsYXa9U1tALZP?=
 =?us-ascii?Q?NwWkD+X91kCREbWM57xmfBlK7mPy1Za/Jwxf8VBsT0rYWdx5SVET83koLqFn?=
 =?us-ascii?Q?Eo1srcDu/4DTIsKuTz39Xg7nOEKeE1pGRq8IH1LsRUAWaa5U2Krcpfqd3SR5?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6453db-4b9b-4bda-7f4b-08dd943d29d3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:37.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVaLiY5UrwaQoM2OFYb/8V1HpIOK3z5kK8yhgQht7IT+aLvR9vOEsM7vPGMfC8SwO2c8BXYG3y5u/Qx65W4q0axpNsrYOjmXUnSH+OoZ7/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

A "TSM" is a platform component that provides an API for securely
provisioning resources for a confidential guest (TVM) to consume. The
name originates from the PCI specification for platform agent that
carries out operations for PCIe TDISP (TEE Device Interface Security
Protocol).

Instances of this core device are parented by a device representing the
platform security function like CONFIG_CRYPTO_DEV_CCP or
CONFIG_INTEL_TDX_HOST.

This device interface is a frontend to the aspects of a TSM and TEE I/O
that are cross-architecture common. This includes mechanisms like
enumerating available platform TEE I/O capabilities and provisioning
connections between the platform TSM and device DSMs (Device Security
Manager (TDISP)).

For now this is just the scaffolding for registering a TSM device sysfs
interface.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: John Allen <john.allen@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm |  10 ++
 MAINTAINERS                               |   3 +-
 drivers/virt/coco/Kconfig                 |   2 +
 drivers/virt/coco/Makefile                |   1 +
 drivers/virt/coco/host/Kconfig            |   6 ++
 drivers/virt/coco/host/Makefile           |   6 ++
 drivers/virt/coco/host/tsm-core.c         | 112 ++++++++++++++++++++++
 include/linux/tsm.h                       |   5 +
 8 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 drivers/virt/coco/host/Kconfig
 create mode 100644 drivers/virt/coco/host/Makefile
 create mode 100644 drivers/virt/coco/host/tsm-core.c

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
new file mode 100644
index 000000000000..7503f04a9eb9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -0,0 +1,10 @@
+What:		/sys/class/tsm/tsm0
+Date:		Dec, 2024
+Contact:	linux-coco@lists.linux.dev
+Description:
+		"tsm0" is a singleton device that represents the generic
+		attributes of a platform TEE Security Manager. It is a child of
+		the platform TSM device. /sys/class/tsm/tsm0/uevent
+		signals when the PCI layer is able to support establishment of
+		link encryption and other device-security features coordinated
+		through the platform tsm.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1ca9233ccf..09bf7b45708b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24555,12 +24555,13 @@ M:	David Lechner <dlechner@baylibre.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
 
-TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
+TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
 F:	drivers/virt/coco/guest/
+F:	drivers/virt/coco/host/
 F:	include/linux/tsm.h
 
 TRUSTED SERVICES TEE DRIVER
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 819a97e8ba99..14e7cf145d85 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -14,3 +14,5 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
 source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
+
+source "drivers/virt/coco/host/Kconfig"
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index 885c9ef4e9fc..73f1b7bc5b11 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
 obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
 obj-$(CONFIG_TSM_REPORTS)	+= guest/
+obj-y				+= host/
diff --git a/drivers/virt/coco/host/Kconfig b/drivers/virt/coco/host/Kconfig
new file mode 100644
index 000000000000..4fbc6ef34f12
--- /dev/null
+++ b/drivers/virt/coco/host/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TSM (TEE Security Manager) Common infrastructure and host drivers
+#
+config TSM
+	tristate
diff --git a/drivers/virt/coco/host/Makefile b/drivers/virt/coco/host/Makefile
new file mode 100644
index 000000000000..be0aba6007cd
--- /dev/null
+++ b/drivers/virt/coco/host/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TSM (TEE Security Manager) Common infrastructure and host drivers
+
+obj-$(CONFIG_TSM) += tsm.o
+tsm-y := tsm-core.o
diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
new file mode 100644
index 000000000000..4f64af1a8967
--- /dev/null
+++ b/drivers/virt/coco/host/tsm-core.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/tsm.h>
+#include <linux/rwsem.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/cleanup.h>
+
+static DECLARE_RWSEM(tsm_core_rwsem);
+static struct class *tsm_class;
+static struct tsm_core_dev {
+	struct device dev;
+} *tsm_core;
+
+static struct tsm_core_dev *
+alloc_tsm_core(struct device *parent, const struct attribute_group **groups)
+{
+	struct tsm_core_dev *core = kzalloc(sizeof(*core), GFP_KERNEL);
+	struct device *dev;
+
+	if (!core)
+		return ERR_PTR(-ENOMEM);
+	dev = &core->dev;
+	dev->parent = parent;
+	dev->groups = groups;
+	dev->class = tsm_class;
+	device_initialize(dev);
+	return core;
+}
+
+static void put_tsm_core(struct tsm_core_dev *core)
+{
+	put_device(&core->dev);
+}
+
+DEFINE_FREE(put_tsm_core, struct tsm_core_dev *,
+	    if (!IS_ERR_OR_NULL(_T)) put_tsm_core(_T))
+struct tsm_core_dev *tsm_register(struct device *parent,
+				  const struct attribute_group **groups)
+{
+	struct device *dev;
+	int rc;
+
+	guard(rwsem_write)(&tsm_core_rwsem);
+	if (tsm_core) {
+		dev_warn(parent, "failed to register: %s already registered\n",
+			 dev_name(tsm_core->dev.parent));
+		return ERR_PTR(-EBUSY);
+	}
+
+	struct tsm_core_dev *core __free(put_tsm_core) =
+		alloc_tsm_core(parent, groups);
+	if (IS_ERR(core))
+		return core;
+
+	dev = &core->dev;
+	rc = dev_set_name(dev, "tsm0");
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = device_add(dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	tsm_core = no_free_ptr(core);
+
+	return tsm_core;
+}
+EXPORT_SYMBOL_GPL(tsm_register);
+
+void tsm_unregister(struct tsm_core_dev *core)
+{
+	guard(rwsem_write)(&tsm_core_rwsem);
+	if (!tsm_core || core != tsm_core) {
+		pr_warn("failed to unregister, not currently registered\n");
+		return;
+	}
+
+	device_unregister(&core->dev);
+	tsm_core = NULL;
+}
+EXPORT_SYMBOL_GPL(tsm_unregister);
+
+static void tsm_release(struct device *dev)
+{
+	struct tsm_core_dev *core = container_of(dev, typeof(*core), dev);
+
+	kfree(core);
+}
+
+static int __init tsm_init(void)
+{
+	tsm_class = class_create("tsm");
+	if (IS_ERR(tsm_class))
+		return PTR_ERR(tsm_class);
+
+	tsm_class->dev_release = tsm_release;
+	return 0;
+}
+module_init(tsm_init)
+
+static void __exit tsm_exit(void)
+{
+	class_destroy(tsm_class);
+}
+module_exit(tsm_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TEE Security Manager core");
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 431054810dca..9253b79b8582 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <linux/device.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_32K
@@ -109,4 +110,8 @@ struct tsm_report_ops {
 
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
+struct tsm_core_dev;
+struct tsm_core_dev *tsm_register(struct device *parent,
+				  const struct attribute_group **groups);
+void tsm_unregister(struct tsm_core_dev *tsm_core);
 #endif /* __TSM_H */
-- 
2.49.0


