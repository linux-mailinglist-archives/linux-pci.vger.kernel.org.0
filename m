Return-Path: <linux-pci+bounces-23263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B22A58A88
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 03:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5123716948F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 02:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752CB1A23A0;
	Mon, 10 Mar 2025 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRaurJ4N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C31386C9;
	Mon, 10 Mar 2025 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574627; cv=fail; b=m12Gpg6nYzfRKaJToI29ueDELD/ofbKtbZ2ehu/Nn25TrrvNw+ztkulUK1v3QJLEfUdUJihJOczeWJDbBG5XeulcUwk1FPSxb58bruXnvbcuZJCTJwJliMyL/vlKUb12MNhZ/Bm7JEiy0WabiusEhdw4i+fBZnKy0saSuIWkt38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574627; c=relaxed/simple;
	bh=QXbHdrw7YF9QSdIbBYL9fDPTOlmwsBvaZxl0XOh4BPo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jKz1TjaciIztXiIGHEoOYgI4VNUJslR7PfNt1IPxeAaqZc9yQ6ZKgxvolt2NeQUBXJeJL/RuokTAF6sYNgkb5gU9BlSaKKKLsSPV+u/zv5foIkusukVtJvuMuiQ5kBMN038nEM/IiNKzqhwlHR7Bk2nLTeRgrvcWGZhN6I4I7eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRaurJ4N; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741574626; x=1773110626;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=QXbHdrw7YF9QSdIbBYL9fDPTOlmwsBvaZxl0XOh4BPo=;
  b=iRaurJ4NrILCkLhES0gX5FVO/AdBkgrKg1V9Gwd6Ii1qqpHHio0sq+bG
   3SymaJ9A1qCNFelchclwl1ALAcYnHbEiyiYQ4SUTjirzovCu1wZrS+7Gj
   3iAmc6aChLZysZVVm/MdADMgbyhnP3aPAiKJSq1wKOxQQ3HfBRvkz7tRg
   eOjSANab6gj9YvSv5BHYDOK89KoGhmQY9bhvKMRjh1+rDOzQgqW1fZoqa
   XfEzrRiCVuXLc/5Nnjh5GazEkQO6LyiqmcMNt2x5jhbn/eT0dCdpq6H80
   hC1bYYEMfE7on8e1FxecO/220+HmOgPevSMktn7rOA4dW0SPenLAoS1Ks
   A==;
X-CSE-ConnectionGUID: hCGQSjiCSHe51g63FADf0Q==
X-CSE-MsgGUID: L4Gjw3NyQnGC+euStgcgyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42669001"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42669001"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:43:45 -0700
X-CSE-ConnectionGUID: u2qw1yLpRPaXYuuQl6E6nA==
X-CSE-MsgGUID: zfQfb/diSPe4sq4DYMEi6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119853239"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Mar 2025 19:43:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 9 Mar 2025 19:43:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 9 Mar 2025 19:43:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 9 Mar 2025 19:43:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/G9pYYsTMuW5DOjHHvYORscEC/D5PvbUK93Pge7sL98zv6scNLhB0wCNxluhT2VpgYXHR894OW3rkmMTxikwCTzT6yH9OxRJWHkAYaki3c+Q5WQZPvCvRS++cjzfutxmKxbpupYfGwaGmB+cr3Yj/eWdRWDkESJyfxLTKH+mP2IxeBmA8P1T3BRE6b+GToJBsAAK/xEywCMJo/Sia5p/nDEVFsvSUJXf1BJIIyMnf263WJwbkrv+S9AYbKTKIblcxNVQPuud4pwMWwwrQGfjuoSx+n7PXxUvH05/fsFq/kk0WNtOsbilJhcoVb9sniUjkNBfG/HoXZSXjEO0XEeHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5w0a5crJnLim/q/domd/uIm5d2hC7SXW54zHju0gH0=;
 b=wq4ZtVb/KQUTUhk7pf+J97YDAIVMTjarrpgHk3wObHs0KGoKtFtHuhWYnxsUY15mjcyb4WjsIsN7LYEcjz4ysedzRk/CawCyRkjuT+zGp9E9KvQzU6CkNtauaFCL4h+fbRY+k19NCHyPuVKdISbeohsTAOoBrwaadzemPySki9Tpdr28JHn63k/fXowQWp+othGImf7jr6+iAXqlShQnPf8tihbdoeUq7I6vymYJwgxJCCvuM/J6CnR9o6wbJpDPe9FSkNk4or6mqooy3Rd0QK8CuE0uTFNejl14zpfclcLbvc5A+s1wmGpSB4B//KPtM2K1P0MPyh+EwMsRNAKlpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB8108.namprd11.prod.outlook.com (2603:10b6:510:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 02:43:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 02:43:26 +0000
Date: Mon, 10 Mar 2025 10:43:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Philipp Stanner <phasta@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Bingbu Cao
	<bingbu.cao@linux.intel.com>, <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>, Philipp Stanner
	<phasta@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] PCI: Check BAR index for validity
Message-ID: <202503101027.bf280c9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250304143112.104190-2-phasta@kernel.org>
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 0257bbdb-12aa-4c02-b6ce-08dd5f7d54fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JGn/KANvggQS735FwAlFrADqGuHJluAMuu89FhW3DJZMPySdv0pgM0rOi4rb?=
 =?us-ascii?Q?uYRNptBbsSYBUZaMELVPuU0rsN/rNI4V+7G+S3wtazVftMz00HxNPQUILOY7?=
 =?us-ascii?Q?POyPA8MQ0QT4eWiC80XmirNNc8UPIrU+T9qoqi+mDHgyB6MLgchpehgJ87I7?=
 =?us-ascii?Q?/NmjwF11NVX2Oh2toJ23C2qq48EEtxvPgGI07xi+SicXDhtaoTU9ADEq+WvI?=
 =?us-ascii?Q?z8c0GaPML1g6ADUQMm9d+Rcdx9+coQT8kWShXuMk7acOBoSQ3eY3wE/ErAPm?=
 =?us-ascii?Q?Qxyr7398n9XVGUd0oYgQnDpgUb/ILyWdDhANVuYr2rfg2qvYhtnv3NNuzhDo?=
 =?us-ascii?Q?WIDmN5rLN0Bt0ZoPNEsj3cNhsJKE+tTa1sMWviCl4LnuXn2MBFirM/N8de54?=
 =?us-ascii?Q?fb+n1IcU09nYm462jDobJm0XYWQaSu+jY3r13Ol47kf8aDBfmOLOAbGg5jTa?=
 =?us-ascii?Q?p7xrBwGKqTGf91DyBSvMbMiUnsdfShj3SLxgfg0Pq3uj+MMZ7kvjKqDwSAHr?=
 =?us-ascii?Q?Y7z9f7dD+9a/WMC3GsZzBN09ygDYYo8crUiwj7GBTYUDQLdhSDM24BRJhKMa?=
 =?us-ascii?Q?m09bGnWGSrbvxgHQ+DAqoz0Qro1op9wcKp8enQPWGwbUcKFq+YxTp00NZIIO?=
 =?us-ascii?Q?pXpJoRRH1f2mjwbMz5s4lakZjEXQBOIu74E2a2ly67GGaRLYxVI7J8LdzEK1?=
 =?us-ascii?Q?dlc8NXRDNGx/RN+wZYiwURq7+GGbEKsDaxCI6FjsEzLmHsnxvlsHMsPzE9mj?=
 =?us-ascii?Q?4cVjhyYGzEsZJXtj32GFWP5EX9JTY/I/K6z5OdazJLD5E/bY92B/2SB25mn1?=
 =?us-ascii?Q?ukwKWrE6sIy7vxReZ9HPHoDp6hkMwll7tvkEDuvkhaJQ9mNgHK02+SIbGcDx?=
 =?us-ascii?Q?s+hIcKyZUouCXugFXr9k4RaibUiujP+hMCLFl7xTrizgFTU4DmLLV2THyGGv?=
 =?us-ascii?Q?vN5IOhkAar0PSUptRg4re20v+d/i4VGM25koizjACDR51zxBWCbPVD9C1OpJ?=
 =?us-ascii?Q?wqQi5grvUFA+GgYT9y4h4n00d1zrz3eW536F2kc+GClVr6vyr0iDiMykmPXL?=
 =?us-ascii?Q?VDHdKiB4hmUE6Q3ixoiuKQBDAB2j8EHUNNmwbT2R9xRtAPEKJ/jFDearKYJH?=
 =?us-ascii?Q?0NfYDw28s/T3/FUo2zyCFU43Q3ItXDthPqQUN6LZQdkNo0wtei1tXb0ihVPc?=
 =?us-ascii?Q?ksithLSfQYqHgoxa1oCHd1FkU+t06H0PqGM73iv/b+Ie/0dWvvUfoCAk45m7?=
 =?us-ascii?Q?BJDAD9l1YYDsKn9j6iJe68TqN/Olzvdn+wEdIknF6h15By8UEkZDuBMUYq3M?=
 =?us-ascii?Q?QWZA2Z4uydEL5C3xewEnmc2TEpkoD9SkCjdis1AHD1OBzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1k/t8GkfeYC80pzZPaiQH4sDxqpqR00g/EQebXnv9Rx4L1qX9giF2V0b/THl?=
 =?us-ascii?Q?YVOBanQywq+/bSx7YXusm5W1V0sgYyPMNoWqXfSYaahFvkw3amkJMK0mXw2H?=
 =?us-ascii?Q?r1L7it2bTdc54iZkq3SSreBwpElcg7n6keJ2RWI9WWmDsF7LN3gw0adcO8x3?=
 =?us-ascii?Q?2KLTS26igA5HRRem+asrHkvJ1Ohf3rw/jrS4vrvWcG9SGblOD00PneSqZMuQ?=
 =?us-ascii?Q?I1bS/bavo6P9WsUIjS/SaRxPhzizvtjOhBGxzRcqP+/mi0RDyvU9aAvz8iO2?=
 =?us-ascii?Q?/W1lFc8aRdi760GU0UwWTVoVponhTgT3aEwJlucU7o4K7OpgD48PsFMY7y4l?=
 =?us-ascii?Q?AIhyyeLEXsQZsYwperf/jb8afIjxgrop6E48fCSl+x/Fjscc+QGp3ux3grA/?=
 =?us-ascii?Q?lmT3gs+MkS+IwCmHuV4l+FUPOv3PekVk+0DYqI1xgaOfboV5H2+Z31qCWtRb?=
 =?us-ascii?Q?qKRXwx/7EvByiwQRzyngpreIl7eultiSe8oh/AQQlfP8O7tqK8HqVBne2i/y?=
 =?us-ascii?Q?Bbyjl4jYeMLnkMCeNYT9TcRILaOPDNaamQTeQPv0Ch/HYmqHEBoRnFwvPz+p?=
 =?us-ascii?Q?B7dayV9f7/y6+gI8LZZ+ZQSYqrRLCD906WzjPf67v+CHlz4b1dmVo67ZTkQz?=
 =?us-ascii?Q?dELoyb+59pP9is/W0w7elfKh7ycBgztlDQzxGb6bAjghdroQ+QCCakceL7ZB?=
 =?us-ascii?Q?BLEOuH+ouzKihqM0Lw2+0pqh3u6C7VaAPbjiwO5dlK3MfaScxaHM4lD62c74?=
 =?us-ascii?Q?oU5BCsOckdrj3ygIPA8eYznM6adzIqxADvGZFzjeeONjy1BOc9Jqx9TjBD3L?=
 =?us-ascii?Q?ZfxdDxQf/gjdFV9Rh6cMgD1dmtSbDYOwc0hlHZaCQpWbdhyiX8nBQoqYBAnm?=
 =?us-ascii?Q?juZJ8jBZJIw07dZ27oBGi4oTOiBw3Xq68CfuA1nkNlxmaHI6+vOEzHWb4K/n?=
 =?us-ascii?Q?t9ap8X3eva++y/Gyp3PJvmWs03iPCSgChtaQDkGcaYZ0zkryj+ZYK+KIfz8/?=
 =?us-ascii?Q?jOkZ4ec1D54x6Zq1kmeJvk0uo2OFCcpFn5FUElPl6/GELncLUhu7owObp0cS?=
 =?us-ascii?Q?M04f6JO6R1t+D0RirJ81JgaYpPztYYnoNsUDUvAm84MLX/qrAzhM8lxxfHXh?=
 =?us-ascii?Q?AkzCSfyWvZzq7yJqxKtseGv757KERWqmYNkiiT4peWY2I3FSNAxkAOhMfz4j?=
 =?us-ascii?Q?xni9a1dWNz0phHFgWoWp81W3khED3qvmzcHoU9afUR5LjaHvbZ9mHzQzR5c+?=
 =?us-ascii?Q?ztFCJnbnRIN84+/0d56sPfNFLJgVC3IlLTzl5B7SgDtdzKOp3oNoio7tRU9L?=
 =?us-ascii?Q?E1K6OQkY7qDnN5oDkiUtvK4OUMNJkRb8HrXJKk5L6CYIvzJCTuw7jDlr5JSg?=
 =?us-ascii?Q?gVyTxNxdFiq21+UMHy1IAn2UaGn+8CBHnMAMyLcij77oV44xvjpGYK0rwTy7?=
 =?us-ascii?Q?AHWn5vmxTYyGRilDH6yUu4DYy3s5yn0/YsLpY/+lSRjgjyqtYQ6Q4cn0XtTo?=
 =?us-ascii?Q?doDOo9MBaLszddp/7cVAmDiiD8A0TkbA25NLIaG4rYvZIOAAE924vTy/S6nR?=
 =?us-ascii?Q?3VDpF/Z4BIze4PXSGmlWsRvazlINqdgJ3JA4vDDc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0257bbdb-12aa-4c02-b6ce-08dd5f7d54fa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 02:43:25.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSLKpXhl//l35d+zvt8d/9miGg/pQZqN3ivN8SOqDATUHfngsQcetnHj9M93+cisaHzpzLx9ZCz05T4ocwnaQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8108
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "last_state.load_disk_fail" on:

commit: 21ad75d75a0d6b1a30159d17f355120912a92a46 ("[PATCH] PCI: Check BAR index for validity")
url: https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/PCI-Check-BAR-index-for-validity/20250304-224213
base: https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git next
patch link: https://lore.kernel.org/all/20250304143112.104190-2-phasta@kernel.org/
patch subject: [PATCH] PCI: Check BAR index for validity

in testcase: hwsim
version: hwsim-x86_64-53303bb3e-1_20250303
with following parameters:

	test: group-35



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503101027.bf280c9-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503101027.bf280c9-lkp@intel.com


by this commit, we noticed persistent error while loading disks:

[   50.323405][  T314]
LKP: ttyS0: 286: can't load the [  183.977924][  T314] LKP: stdout: 286: can't load the disk /dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4171000P800RGN-part2, skip testing...

which doesn't show on parent 12c8c13635385a which bot chose as base for this
commit:

* 21ad75d75a0d6b (linux-review/Philipp-Stanner/PCI-Check-BAR-index-for-validity/20250304-224213) PCI: Check BAR index for validity
*   12c8c13635385a Merge branch 'pci/misc'

if need a different base, please let us know. Thanks!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


