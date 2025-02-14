Return-Path: <linux-pci+bounces-21409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A97A354BE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4891C188FD70
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FD63BBC9;
	Fri, 14 Feb 2025 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdCaOTnn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76FC2EF;
	Fri, 14 Feb 2025 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500514; cv=fail; b=po1H0nDK77HhCiH0bYZqHL7m2fJHGXyU8towp4FkUgg4U+fqx4+xFZInC31PyBxBYhmM86yExoV8gGinFu0tORXFrlYwa9Y2Pc9F0puEjmSgu82IRd6iwja2X2EGZiiMeEqkdDXip7rs/Uxqrq3ORCGgIxFmpaqTLW8rGXvC43s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500514; c=relaxed/simple;
	bh=7Ehj/oi0SdITvg635pJmJHFfVsL4i0rwONsM4PoQhrg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FBzR3a0Sj6/pewBK7F0LwFgFfzeBCBS8oAd5WNOn1k92OapCal73Df5VUrDqAKmDBcp5F0YqJIXL9JPkkru/kykcHiFG4CHfyoLLRG2qka+xdUG7emoXOV7zNDMEwBU5stsRG+9zB3RcQDy1pJnTGpGZSnK9ibOZb3L14nMbHGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdCaOTnn; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739500513; x=1771036513;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=7Ehj/oi0SdITvg635pJmJHFfVsL4i0rwONsM4PoQhrg=;
  b=MdCaOTnnYE5OlVoBtEWu0vnHPUItxhNvuVQKeRawjPHyiD7e8/GRBQs7
   z7iLPfMHusHUn2wDT9O/EBAebia9UZUaXBkvJ1w2wArAMTvJyZt7wW4La
   AGMA4Cvo2ecGKb0BS+J7a4q54TcYAcpSa9YKt3LNqm5mQrFPAeCTG3peZ
   wckLvND1AytGrWZKEIJaj8ncMzIDYt+igo8G7LzHzrqvrtXuDnzhlvv5z
   Ii0MW2V6P8SoOXuqhm5LKzXgO6hwNIT5yB8QbMFRS5sh9+Ahgvz3pGjIi
   X94w5BuWkn+IISZluIKqdiRxch1pId1/v2Ny+vDKfA/kl58gPpESPT2+7
   g==;
X-CSE-ConnectionGUID: 5uv+cdjhT0y8qi/vaNKV4A==
X-CSE-MsgGUID: moaz1jnYS26ZBJqcT0FmJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40161227"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40161227"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:35:12 -0800
X-CSE-ConnectionGUID: +suwEWNUQQ+dE2k+RtWySQ==
X-CSE-MsgGUID: K8xeBHwCQhGLa3YLgvh/uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118535650"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 18:35:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 18:35:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 18:35:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 18:35:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRWfyqXvm2BYVIU6cModli7VgTQ1SMmC4azEMUq/RTUfPmuoiD5L99z/xZzPbMm23pKj7rqbMBdlGqZ4YI/ea92FvUtYSyvVwhUOdO1RsFxukqwtuIxprjUbJr6IrAkvGf/DdWCMQtGx8JKWUnbOWMLYL/M42uMxaDtPWLwKK7foepf8Td152oCivqA2ivYqt2VCNr25rKnQLv4VQB7HTLGGfwenWkRVlyFsWWzCUjQvQf7nY17xgc99arhjsxgrbFDe/x/Y/Qj+aC11ZaU77bZHMzG0kWTO7NXoNZPB8u+581IirxugiFMkHllAjiDt8g7MC99vcDrNweCn5VRiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHCwwSxf30x7BZKgjrM+f+4HEm661M6vy+x82ptYfb4=;
 b=YQ1NNHvbrXNlFKEh1PSvNtSXlkVXmBqOzo3uwsghRPFSTgvbOTF/wk1JD8a1opO1AhdptewZgqOSzGqsSCZFfPZlRRrP6BvG/AEcot5d6pM2OtYHFoFFroFEUPAPSVaGUMXK2YV8tv+dXTBzptSq/cEJBTdEzoqAh2WcN6PJtRaUrCdq/doJ59yfAx2S5Xz3Phcxg2kMSoB4QGcX7eLhqYWc95zSY71zlok42zgXEMpcvMuNpL79afR3Rqp34At6KTxVNlnLXvwss8bZiHoBk9ryki/9tJwQtxH6RKqUC3ojOXFvkZNfLNfs+uJnYB+mpALOuvqjXlyUmzKUdWCq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 02:35:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 02:35:08 +0000
Date: Thu, 13 Feb 2025 18:35:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 16/17] PCI/AER: Enable internal errors for CXL
 Upstream and Downstream Switch Ports
Message-ID: <67aeabd92300c_2d1e2947a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-17-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-17-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 131cddc6-a5d3-452a-814b-08dd4ca0327c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?46iMm2Y21N8UUpjEVjImbbCCgYHw+Aqbc1LlvRkiPdDAF36Ai6BnpwMmLV+A?=
 =?us-ascii?Q?odeNMtLZHUcp3gidDHHbXhekmluvnL0mf56R8lGyN4jrwldACElC/QmGH6id?=
 =?us-ascii?Q?tx7u/OBfOsqUPXJI71bwxw7ish2vBtGGFuOdbPJyeJbcjZ26Q8xedlBBXKUj?=
 =?us-ascii?Q?b3dNwnt11UAZpAFxNDCtPHE9rfQ4wxx+CSzA7wa3fnjjyB04dSmbYNqQT/uO?=
 =?us-ascii?Q?f2wWyRE5GUSKOJld9sa1+KFKal21vgj/f+IljcTPH9JeDMzEKLO9gTthppGX?=
 =?us-ascii?Q?sIASoZ0mRgw1FU8k1ZqT+Vie5Oxh4HlaJsE8TdJS6mwb59EIIPPfvbnDIfhm?=
 =?us-ascii?Q?vbp9huebxiT9weeXZxaxUlhen78dL7vika6qJZ2kFuLJfpOj8vxcz3gjE7jX?=
 =?us-ascii?Q?2IImQ1uJz2TcvVIj1mTwgQUmqMepBJvwqKzp7PEQgrPMHo4S+616ehQUbjMW?=
 =?us-ascii?Q?d0TV4RbccNDfqf7h6XbuBNnWZFf2Rw+Z4qIfmE8RJvTojfx/D59IRgrzAaQf?=
 =?us-ascii?Q?uSp/bRut5nGWsM2Reple57CepQvYR8RdODIolasvJLv0FCUqKe4yYZFrAXQe?=
 =?us-ascii?Q?zSdyyIqaVRJ7BN3jr+wRN26AgQDCkTC2SaeiIiFsjF8DARhnz/dxgJvlVtVS?=
 =?us-ascii?Q?Jd4+6QEPCmwThYT56ThqFheI3XlYKMTHTpYxHSsxK3IXs9QoFsYNDkoMMO0m?=
 =?us-ascii?Q?L8Z1BxtMg0rawVpp2UseSbywDG30umxiYg6AQzXVUUL3XRL+wvra/QbK6frf?=
 =?us-ascii?Q?UzYTKc1KkZ2SCDQ4c+2Mp6cLPquMf1tuMHFf6wp0Rp+BEhyovJ8CqjX7qXoa?=
 =?us-ascii?Q?IcMXsaAmh69QM74pN0wWFjN4j7z9xIkR2U/Ar3fAhfBg4o2z9Txj3iztNNq8?=
 =?us-ascii?Q?1kwGMnVXRYN48X21EdeCWmIF+BdVq5goXKMNXInB7jrA+faS+1bR1c0JJ4b1?=
 =?us-ascii?Q?qUqqtwnyQ6Z3qObj0zBbd0cK1TvrP4qTVs56clGoOWAjzWZzJtcxmCUx+S9Y?=
 =?us-ascii?Q?iGLePZMhK6rRZ2p2yvjMhx5DmG5NcflQCIZODRZPykEgMVeEjFD8lhDlHUJE?=
 =?us-ascii?Q?nTo2rD8Q2QtOvxBvg3H1dl3/gIFdeqRq+hU0QfkTJgfL93QWnZ4T1sqzhr7v?=
 =?us-ascii?Q?tjimNpCKFLPg0VAKb/FevC4scFlcTgnObbDkmQOTj/+SE3VzcVtqSQ6iqA7T?=
 =?us-ascii?Q?br0TQlU0J5zQ49gmGeq/QhE+XXInmPW14M7k8gkB//B55PGSEEQgijkhw6z+?=
 =?us-ascii?Q?jvoR7wtILUDYd1EpIeivLOiQS5eDdNT076Y2n0NSeFMTsuRjc0rA/5khfpPz?=
 =?us-ascii?Q?j+psEpcnHZKB1z7xll3ZUQNK4EzJ67WML9dl//TReps50SWuaaAx449aE8j9?=
 =?us-ascii?Q?8sqpo+Av5Q02nKCGLjzJATT7l44tcpljf7eaXdC+kbkhxUxXyCIoKw3yBzRo?=
 =?us-ascii?Q?gcx3Tvy+Cqs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GWELudlT79ddTUQBObZI3jWr42ce8ITqHUDX/wnpr3js5Y7k2i8PycEvqYa9?=
 =?us-ascii?Q?ex8Ggq26PBP5VPG1KWA+uats8cz36I7bOBTMQ6TVHFs9Ixe8j9TCfWE91UxN?=
 =?us-ascii?Q?pkWPQjJkEIw1ZcI9MO/1xCPaLC2ZNfGUMzWDgfX7jBK0JZY7w1PTqIHGqMua?=
 =?us-ascii?Q?1I1URMPlQX4HAlVvRL45hLdJkvQbq2y1m/5+45fEQM1JizqR8o6+o2tLE0mC?=
 =?us-ascii?Q?sAjl+5hiHG5BiVeuhdptG3DluEQqMZnxAu8aN1uy4r0hmIDiR9zaZ/1lNOs4?=
 =?us-ascii?Q?/TBIckBbMhucXNE0nID36v5ChCqgnIG8ytkN1KnnWL8u5kweLmOP4Pt4mAmx?=
 =?us-ascii?Q?Ndhyct127LvLo1V8lcDGQ7sQi4uEZOV2vXdkVu7yraBajrWda2DbtJMg0xfQ?=
 =?us-ascii?Q?XD1TSCEXynOSW2wVmy1fDk0xxBATggdjDMQEib+QhNa52b5eJpHIffUuw3d7?=
 =?us-ascii?Q?aUlvuyL1/52dn65cXY6ucdP5cM7rVsDDLwuyXcWlLFaibP9FuZrMCr2eGoyu?=
 =?us-ascii?Q?PFv/q9SxS9Ijad02NWzswZ2MAjNoUTJIw7AuG/O+aI5RqyVoByb3LBygBDvg?=
 =?us-ascii?Q?mjVIBSu1rxZ7Dd+jrMn6O3nHRfPDkn2U1D1N/wdn3P4EjGQ7KUseFHrLGk3t?=
 =?us-ascii?Q?jwBcyYSc4HGrBfvTkYtkVq5esGfzaLy66NcEGNRzJ7OA9S2qwUENiAqmxmMQ?=
 =?us-ascii?Q?+CfbYffSh6+QrhAIzs5n/j7dlumuXD3+lCLWSLIpz7C3qyX5CV96JwdHk+xX?=
 =?us-ascii?Q?JuVFPJn022RnxVIHxSR8Hn+5HYUx8YEWMAXDKW8BAgW3wjOwu93VxMv10BYh?=
 =?us-ascii?Q?xhJcmoxtR4+KwMSrIT2LDrBR5iZ/U5KUYcShOi4TYMkAJrNL47+E9DrVs8g3?=
 =?us-ascii?Q?eci4yXwWAq5jUQb3mbCu07a4ar+ssuBOkxXbYY3raEXjoNcQ1mdIioJJrQpp?=
 =?us-ascii?Q?vItp1w1hMVva5NUKIfsSxegq03vo98OmW3QuuOSt1yoSGzEk3sRkIvY0a/kB?=
 =?us-ascii?Q?pTobXkVxFH41K2s7vc1xDmq7ELGPq5Hc4gDsjyalwC67XXpwxh45Y4u/Ar+j?=
 =?us-ascii?Q?rfxr76a/izVDpL7RqceWdY5OQTIfbk581d9KjmpOY5jy6Nzp8cAFcLeyWMQb?=
 =?us-ascii?Q?gum+Dnv391ucMRwAVCuHUcbGpQIkgmZxKtvuE9dgvdUyawYGHO8SXU/D13Mx?=
 =?us-ascii?Q?/G5XfCwFwJ2VgJQM71bTLqMHtjBUok6ezKXPW8wUiq06/d5g9mZml3EQdwFU?=
 =?us-ascii?Q?NBi3pS6Gs/ktMzq0X6TCIEzfF7OMaxQvqHP7n8oC3rzRbdrjayOmPMa7KyIX?=
 =?us-ascii?Q?1K7jw35Rg61ib2St6q8K/fl/Ss27yBhFDRYVoOBTBPvHDn7NkttxCn93Q7RC?=
 =?us-ascii?Q?ao2Np+guwq8XR3tyW0jeVhuEZaQ1us1W8Uzdo9QDmSM/WuCuj0XlmyZF0pRf?=
 =?us-ascii?Q?SRJUjMQQuzUpv+SExFmfokOn3BM98Zj4jmr/XGQxJYBVMq+T+rv1Vm9nH7Xq?=
 =?us-ascii?Q?M3AYYdvuKdldkaBakkoCD/7J014OF2iIlzNlia40rYzu3vlrTWlI43hmRXB9?=
 =?us-ascii?Q?exOuYuHzcWBCVhzYfmlsi2110QK+MRQ+fk08PfxamS6Zn0YjPIe0Pih/Y8VF?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 131cddc6-a5d3-452a-814b-08dd4ca0327c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 02:35:08.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2seFRjQqn0IJjsqUsD5LoqtRHR9pJrABZGhjtQbkn6pZ8KEgbWz8oD5Uw3vfBf7YFW9IfX3+nhKyvsjUQiEtNqN8u3I0X5IRQbRB7w2IW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
> Correctable Internal errors (CIE) for CXL Root Ports. The UIE and CIE are
> used in reporting CXL Protocol Errors. The same UIE/CIE enablement is
> needed for CXL Upstream Switch Ports and CXL Downstream Switch Ports
> inorder to notify the associated Root Port and OS.[1]
> 
> Export the AER service driver's pci_aer_unmask_internal_errors() function
> to CXL namespace.
> 
> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
> because it is now an exported function.
> 
> Call pci_aer_unmask_internal_errors() during RAS initialization in:
> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
> 
> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I wonder if this should save+unmask and restore the prior state when the
cxl_port detaches from the port driver?

I guess we can wait to see if this causes problems since internal errors
should be more predictable / reliable on CXL devices compared to generic
PCIe devices where Linux never enabled internal errors previously.

