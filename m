Return-Path: <linux-pci+bounces-22603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CABA48CEB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 00:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF54C188F5D0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 23:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A632C6A3;
	Thu, 27 Feb 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3feoAiD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD81BC2A
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700003; cv=fail; b=Z7h6RUMsN+vt9+WVI3tkrqUIy4NYgDDmhA56bde2ZrAOGFeW2wo2rMflTpdLbouUMLcdOnv6b0Wtmqdgg82f6PsShBTKCIxAYb4pW20+4x8OxCBLUJlA9v2a3xx3w703JnMJs7IWam/5K4tFxksdu1YwlnYu/Nd4r3VtJySKK8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700003; c=relaxed/simple;
	bh=m9isW/heL2kEPLTls9+EGq+O+YwzN+dZ/RNa1TIiZZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oalUQmTJMShbjmyTDU/EXrRglOZpAAj3Hy7BLzVn0QEP0Huw1pE7TmKi94AVj1dIoTKoxIzjB/qfphjO/2o3K5ntApKKh2p/qQ3Gs4o7YmyfxbUIkkjXeXaD/UjmIy4+6HxyKwJc7ncwX8fd26S+JpgzQwox2tiRrxmPVnO05Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3feoAiD; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740700001; x=1772236001;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m9isW/heL2kEPLTls9+EGq+O+YwzN+dZ/RNa1TIiZZI=;
  b=A3feoAiDBiCgLM9K/TW3X86XDqWnLuV3S5YCoGdtdReb3NLZfm3uHGYQ
   vP9z3MQnPmd4L3DePS80S6bJlIspT9MJ2kPBGZCJKK1DbxYzc+Mzpaf7z
   +RVP8ZFJk20igWvHXgEQhMS8mgQPNRIdRr2Jw1tgAh5UTMIN8mG6aXJSW
   JkYKft7z23ntRWzve7yOah4VQ0bKwaS7ea0mUJKYegXTrsMYq6Y//zCK8
   dxyx4IOnalWTpfiZMz92VHB3Fwv0JH8BRzKUOozGkOEILiSXemaK3vXMq
   xZSDyMjlOiAgeQzc8JF92QDyyGJiX8LHjJj6q2aqS/e17M+iBZ4z2kZEY
   Q==;
X-CSE-ConnectionGUID: J19bohXGT6qAAuFmgOVX1A==
X-CSE-MsgGUID: 6zSxVYaSQjC85veHr2sphQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40860442"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="40860442"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:46:40 -0800
X-CSE-ConnectionGUID: xZnXQkh4RbWK67+82kBtEg==
X-CSE-MsgGUID: FZ4+jJHtSXC++AiXh97Ubg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121297776"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2025 15:46:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 15:46:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 15:46:32 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 15:46:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3t74C1J9Of746hJta4UPIhZ0BHE4QuznPDO9kN/3lDyiqTr70ARqKziE21wB8UQBrtnzC8nmEKt7JO5GV2fex/IWM7ToZVSyv0ylz1ShVdDdkghlWZRMK2Xx41jLaJv83hdLaGh1OTaWsG+34H7fL2dAQErCVJEYtetowjd2uzSD3VeoKNh+INfblbUC9ybzDP98ftkJ32IwY3pnR9uNazKgzgSIyzU4j57okTTI2m5RWjKHCvo2t81z7WvS7r6FOd4DLQe/FHWNErNLGMJUXG1hNGy7zZNU1bKsdzwT8sf9iQLhmKjDBkSJO5wUYi3uf8bO8JDLOzc70yNzGKGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gslqM5bwsoKdrOu4/E6ccXV+41zsns5L12uVOA+eIEw=;
 b=JBc7xo2/mbNjV6H2iu7RksOu9d2mUubwyGtim7ZnDhCspv8kYM5SbOocq6C6JvJakllaPqnDkLGxSSpfhKT4gpmZREdfaahfxIlghahNAsE8iq/c4LiEoomP54bge0Z2hvvi3rqanvHMvQrMnf+UCTqK4iNgOEor5wVOs4nyrhrb9DHxrPe+yE8s8DGW/SKKYN8OCtxhFmSr78snQDucnsVfO/gd8kGp9UmElac2b2u4cuVZBEHYlat3d4CyQt7UCuVIVx9WG7XhSEMfupW65/n2ORdb0ZZEqFPt0ZcBXj7iI6+7KBcd+DH6c7JHi99W4UYbb307MlclDqn8Qv2ijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 23:46:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 23:46:27 +0000
Date: Thu, 27 Feb 2025 15:46:25 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <67c0f951180ed_1a772942@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <2e7f85ea-40ce-4b38-acd9-56c02718771c@amd.com>
 <67b76f5663f7f_2d2c294e2@dwillia2-xfh.jf.intel.com.notmuch>
 <fb236418-eaf7-4ff1-bf69-70b003be4ea1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fb236418-eaf7-4ff1-bf69-70b003be4ea1@amd.com>
X-ClientProxiedBy: MW4PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:303:b6::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: e0666356-fbbc-45e8-e373-08dd5788f3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dL1SgmdP/YolYoUCfb5VaoRUvc7iEr1xxpHO8WHFqDMKQ93qr8U3Bdx2ECke?=
 =?us-ascii?Q?HL52CBDkW1GJRRRewR0901vVvgnXRsAXZooLN0uIeK/r5qAZI1MHuy6+MGVz?=
 =?us-ascii?Q?u1DlqcVe5dGQasIgFhjddtFkxWYntLguNE6ptcRyvE3AjOkWshiBE1hw6Rvz?=
 =?us-ascii?Q?qL/GUbn1utAs5rBNe66oog1oXWn1/h4K15TjRDCl5qKrlZfLyLjohqGJsu6K?=
 =?us-ascii?Q?lf0Ng9S4ip6ASzfe26P3HEX3XRAm3+dYnpnycoV+DOUc6+qo/pmfMcxidEn+?=
 =?us-ascii?Q?5sk9m79RLiz1VoN/jwZUV1MxCDZ4LCQNwdffC2KVwuOd8rL6xp2ISiLKWcpC?=
 =?us-ascii?Q?wJc3hrcFUqC/C15Qw2XPrEuwl9EoBj4kuPBKGYpTKPhxUNYgx5viJEoZTe+h?=
 =?us-ascii?Q?hofaihcQOYZiGwS7m8gDpC3GfHNwUaFUdzuO4snmv6YzbZgSXFArUbPcVttA?=
 =?us-ascii?Q?H3AiA5DVionGIJe+Pd53zg6j4K+FjteOmcEvRe3CeFUIt5utQAZqOMyoIXps?=
 =?us-ascii?Q?xQaQj3E2sEzgbZ2DE7q7buyuRq/OHMvwijZVBGPtbw1hVgCW/5IQIX5myNuB?=
 =?us-ascii?Q?JTjYf8QDUz3JLr/tSLuKz6Z7KGfkArKIawJhXe5S1wcoESmDq0cdolsdVTgv?=
 =?us-ascii?Q?Tb/HnEoi7w6ggdaNFg2/9erweV0EN9jRdQy0Go6R8Qw02ROpBaQuOzm2ePbv?=
 =?us-ascii?Q?SlL4wr2iMJRqVabEF5pokdyONU0QpZJ1TCcfvGbvkL1drWDq9ZvvhcDcu4u5?=
 =?us-ascii?Q?8TWhoeGQB1ZeVsJlOg+xRBsht6n0XAJITVM3e0ZoG6Oe6KGnBFieghEn4Oca?=
 =?us-ascii?Q?b4y76XtKMSVFC6zN9eCHpg5BroJa0aO5MPHq7fvRVMvIiiSgkKfVB/2qfiXu?=
 =?us-ascii?Q?MLF4fq1CWWMp0x+obJ0BshOcrPkgtnvAiDpi7NTNpKft3Jicdp1Tk5svn3t/?=
 =?us-ascii?Q?hbx4/l+Nr6oGz8x0dnN6wjDR4wG9zwYUff137fwL9r23iadPKMBKbbOUZNVO?=
 =?us-ascii?Q?GcON3pvJgS2m5S6SMTw/G3cWhtkBM5/s/MZX5KV10TpLai1xt9+jXuqg2hPS?=
 =?us-ascii?Q?Wn8ovl7U+Sj8J97YhUy7Z0g+u0OCVinfKzVVxEUE/IplQlQUWr/CTH7WKVux?=
 =?us-ascii?Q?j/kBSpwbp5Sp/maUMfBkSD+BzwtybrooPahAxDO6q1cA2x8qa/ZM8+0R0YEq?=
 =?us-ascii?Q?dqcCl15sFb7aF+uOINpoU1IOlUtMEq5P+ZgBbbtuR5I+Vi3mCe5oL9KNCM9w?=
 =?us-ascii?Q?AP6BHhfEmxQjk9rlB/y1qzXLoEm31w3dOkNeHAa/xJC6yhlylCw5dagruuXC?=
 =?us-ascii?Q?sJnrfMoq1mqoikOpw5TIx8930x3TBu0MA3jP4U80Pmxl0liZifpkpathfaX4?=
 =?us-ascii?Q?jq4bd7g3oMbGgDE9a67QdcDoVHfW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jBYkCn1YxQr+VBpAGpAsEP28vuFH+SCY3hXvgw3WWSi0+pb95QDcj/oYnR7p?=
 =?us-ascii?Q?d9FoqU9iwO6AsLx3cvV5vdr4rL+JQ6BfU/83+9QmH3Dk+M01JB+6ZHe7x/c1?=
 =?us-ascii?Q?v2bU40MANOsO807CGCr/F8KpSmxFNOPcBJMLaP/IYQlBYkpJT3hllwtWCny2?=
 =?us-ascii?Q?rUo0Q4CCpqZ8v4CmKCoHKDwpUdDLVgckM7C8agcTv3e8xFp8sVtg8x/L0CEq?=
 =?us-ascii?Q?9xi0yk2v30CEHd+nRa/33HuK/NolMEVwqKfRfShk+K4d0cb0rFeozAfBeSOR?=
 =?us-ascii?Q?BV8+dehCgsTJCsF4xktITcxdl58z7Fcebtc8VoQQ6xCk36q+mews2gZToAFK?=
 =?us-ascii?Q?O6ixOj9ReiP9h05WzXTSme+yverof2NvrQhElk52c/wy8QW/vXJJllg0VHV3?=
 =?us-ascii?Q?7cRfj3ck+NibEtMH1rDzKPnJTYkEuAZnHRsh4kfCYOmpM7SmFR/MJRyuoAsL?=
 =?us-ascii?Q?ayAdOTROnUHGHxrLhDTyREiylliOHxtHKl64r3TVAbAUGoKB4EX8jn52a1u0?=
 =?us-ascii?Q?1YUDAFSNzBqe18gEEAOSDabqCWIOoBlbppnpfjbWHPNJ3Rxs1TeQNaOji9Ag?=
 =?us-ascii?Q?TEV2VjW6QQho5uN61PfJ1L7B+3D57v1MvFziIL8L8OGCzDi9r+b0z1+Y11mX?=
 =?us-ascii?Q?SLRwKVstBP4Xh5TakMq0zzKVh129ZJCJr0dM3uinS+0+8ANbQXUPWsIQSsgi?=
 =?us-ascii?Q?IW9TyzfqGFu3RSb9elxJHPrhlZLRg9uXS/7bxOGL7poah38DPloKcK5qy+4L?=
 =?us-ascii?Q?vkOl31XP0JcHsAWP/+tw4j7om8NIcfpWSi/4Q530DN2F8CA2hE44n2xBp1lV?=
 =?us-ascii?Q?aCLCUnoHZ485Bh9vgH9oi8Uhqc6b8o8dLiGAwhj/YCOYY3PsPOg5LaJVR9sA?=
 =?us-ascii?Q?Hq9dK03MEZXSx22WtKFTNwEkk91eB3+KOey4i8xNjpOxg+y7dc3vCV9R44YK?=
 =?us-ascii?Q?oitSEyO/r0NEw6VskaAS9pkpriAXTxeyHinwrDzwcU/zSvoZznU0cZJOtVuW?=
 =?us-ascii?Q?c6LiafxbhYJFVpb29Mjuzbld5Ye/F6Xj2Tzd8hjd1H2vYDZXOS2HoMIZzJ4X?=
 =?us-ascii?Q?iTwmFakKuvpo1JPITYI2uBufLtBsTGtX5nDEi+TLBmsLJ+gWIjWtxB+6eC/6?=
 =?us-ascii?Q?/ymUirp2HUrOlWUWbR7CV0h3Nsbj/R3Ug45G4FM2gEhI9ZAqMfGQgeMokx3P?=
 =?us-ascii?Q?M9ZTIgPZARHRf1EuT56GWneWJXkh8DfLmcRhAVuIeyEg0Cup2XnUoDlg93T1?=
 =?us-ascii?Q?ag+WFRbCXQnF4cPWnKDoz6WsopwSq/xhoebtLk3ykXU16n6m7d/IqaIZ4MFs?=
 =?us-ascii?Q?Vr7nhuLYPK3XNcClyVLvx00Ze0ZnhBJzRYhTqsxCshGvVK2A+EeT8EwFVk60?=
 =?us-ascii?Q?3Mkh9LRfvKUT5trAAubDXX/G8on/Gvp822TTRIctng72Zjljg/b63Sd4rnW3?=
 =?us-ascii?Q?dx+8Yo72IRPFqQEBayMtoeEjZub++4I2UHlIJaiNTpWC+7lU/NMzGw38vHyC?=
 =?us-ascii?Q?W8FJODsiz/hTPM/T9LBaGcWp8kqSa9q9REEasaxU1w7c9Pd3VqqOFqtjtvUK?=
 =?us-ascii?Q?NS/YGUhsKwb3jgrKgT2WHai+cKdmWcCTFStgN/4uHpx9HTJTHwpcLjd2iDyE?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0666356-fbbc-45e8-e373-08dd5788f3c2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 23:46:27.4431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbxTKQ9um1tbpRS/5eiu0Tdx16/BltA9Mo5lCaGzJFsmNnXXPLH/SLXaDQtJWD4EerCdHOhoemDZm0zfRYU3axD2b/0n4Qlr7E/mWY1BGLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 21/2/25 05:07, Dan Williams wrote:
> > Alexey Kardashevskiy wrote:
> >> On 6/12/24 09:23, Dan Williams wrote:
> >>> Link encryption is a new PCIe capability defined by "PCIe 6.2 section
> >>> 6.33 Integrity & Data Encryption (IDE)". While it is a standalone port
> >>> and endpoint capability, it is also a building block for device security
> >>> defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
> >>> (TDISP)". That protocol coordinates device security setup between the
> >>> platform TSM (TEE Security Manager) and device DSM (Device Security
> >>> Manager). While the platform TSM can allocate resources like stream-ids
> >>> and manage keys, it still requires system software to manage the IDE
> >>> capability register block.
> >>>
> >>> Add register definitions and basic enumeration for a "selective-stream"
> >>> IDE capability, a follow on change will select the new CONFIG_PCI_IDE
> >>> symbol. Note that while the IDE specifications defines both a
> >>> point-to-point "Link" stream and a root-port-to-endpoint "Selective"
> >>> stream, only "Selective" is considered for now for platform TSM
> >>> coordination.
> >>>
> >>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> >>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>> ---
[..]
> > 
> > Whoops, was moving too fast, fixed.
> 
> just double checking - fixed 0x000fff00 too, right?

In fact I have dropped error prone mask definitions and "getter" macros
altogether after other comments from Yilun and Jonathan.

I noticed that back in v6.9 Paolo had the good sense to do this:

    3c7a8e190bc5 uapi: introduce uapi-friendly macros for GENMASK

...so now all the IDE defines that need a mask are using __GENMASK in
v2.

