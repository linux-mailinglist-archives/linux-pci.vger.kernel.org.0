Return-Path: <linux-pci+bounces-32290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9FBB07AC2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E091887D39
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFCE2F5C4C;
	Wed, 16 Jul 2025 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGgPeCNr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729C2F5C43;
	Wed, 16 Jul 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682144; cv=fail; b=eVh7OjVOEe4LlFqurC+VrhBgVjVboNPHeJL4tS7igBCGSu+VdVvdh87/qAO+L8Kd01yK5sR4IoumKLBfRGt36edYey6SgUX3BrLdM4CR4eqrHFGgJivwyhtK1k6ixlHVtVI6wM/k3FLGOj9eZX6119MKteVKLkpsbgoz/UKCyJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682144; c=relaxed/simple;
	bh=QgnhJfqP6JtP5RXIyDQe3iNyXA+rX3HxScmoJeA44dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IepyN5+i6gW12bNQV54VskHurX1zjqqdlCbgMlKWajdQEYR79yhOsfxQ3RiSePhv42tEBokjCUqYvEEuFwb7RAW0y7KAd8xEr9GC66FdfA98tN7AyA/KJ7XhHoXB7O+o49peEP2uSW3MCoYEKXDG7rNq4RUJXH86m2AnDDAU/mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGgPeCNr; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752682143; x=1784218143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QgnhJfqP6JtP5RXIyDQe3iNyXA+rX3HxScmoJeA44dM=;
  b=kGgPeCNrFTOMQo1Xtaj+gfxYLU+YBMtoUolaCbSpYnMBanDQ+tzfNqcC
   ghXBj56/sROGUabiqQZeVmfX72+BIXLhyFKEqUi2nhsPJ9cYkUwSYaK8y
   sMS3HDJshwkZ6i/fYZVtqiP3ziQuC7hiu0hLZZzxIuRccpLQD5jik+Gdk
   gwN9erGKOW/xCJwcJG2gWmYKPPHfFDtRcWws5v5moHhb4QYyB32F49r9Q
   6V5tpO2rHn4OSqy6k1JBHIn8JKdqZiTO/10ZP/h22WFM36zegPL8OZP3a
   VnLyQ8qzBCvFk7/qa8R3AYM9wSFZH+JyaXJsdAdsnyywzvSMkrLkbz952
   Q==;
X-CSE-ConnectionGUID: lewU3vcyQF6ETHTSWflA+g==
X-CSE-MsgGUID: KvhpavZfTuCumrZPDoH2ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54153038"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54153038"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:08:54 -0700
X-CSE-ConnectionGUID: 6Gae5GpmRvio40qQ8id8Qg==
X-CSE-MsgGUID: OFVMuX7FSAy4pF92Q3h/8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="181232947"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:08:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 09:08:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 09:08:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 09:08:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qynmbSLdK0LzNxQAGCqWK+OivnpL3aaR2b+LGDoA9HdyAn+qqzaxv1AJ4z6gagEAAHZx45z68C+fNbHZBKkl4+9nUnyJ/Vvhy6oY1kFnnydLe8Y+eFngWc/Wi9fXbdgzfNBymPapXdu0lrwWtufvFNgcHfBf9/54ucQYmiMbT9wm137bAw1/XIjb+b1qh4DJ9Vwe9WEpW0U3gKBqiaS2LPHhcJBQHBNjOn8hIkCPwYv5kVN/dBHfY0srg92iC0SqoS8b9itFoiXhoPYCdJUfDbm6MlDgStxk3uskXOMvt27Z5ELzvOEuV33V6+RQv0R3i2hgUl0rfw1vwPvijbu5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfXzJJHf+R4OoJRw4hy9lCTENRNt/oh4M/kOW1ZPE6E=;
 b=a7R1u9dRoAXzVBQVZ/FwC/mUitVl8+0cpiV+kD++bgqX3gwryh0coeZnSqKo46SinRMdPunIQZGMShguSVh9VUn/mFpmMWsQQy0vAxXlnbtJczsJw7GX1/VGbll8u/UvAk6vbaAlldbyZo9/lNIYi8BmAtWSZiqCdhng7uZXAN4xjnVHk3G8/ewY67b8EtZxeJavhU27yIHRQlDHgyUP7/Ry6Upl+RKtzBsLPgOI9r1tKmgwgq4ooYz1EmQP/eMN8I4IPWvGLhWAaJ6gmPTb2FDjKvtzd4++gjwZid31Vih96Ja1zQEJMYjmJISEb8uZg45xu2b0qx+ueNKnifi4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 16:08:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 16:08:40 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<linux-kernel@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, "Suzuki K
 Poulose" <suzuki.poulose@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring
	<robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>
Subject: [PATCH 2/3] PCI: Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms
Date: Wed, 16 Jul 2025 09:08:34 -0700
Message-ID: <20250716160835.680486-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716160835.680486-1-dan.j.williams@intel.com>
References: <20250716160835.680486-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9c9368-252e-49ae-a7e9-08ddc483077e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fqri+FQwY6G0BClNfNVglVlHywrAhd3UZh5lXZVHpxudGtg69juTuYzVKstv?=
 =?us-ascii?Q?KXyHvgUGXnCfd427iF2rJ+m2829G4Jf/+iTI7buassHWMfNX58/WwRy5F01x?=
 =?us-ascii?Q?QI6xPFMQuXYpai6oM/ipTIuqGXeNVfByeT/xMb+8TmCTEGHm6FUx74xzpGtC?=
 =?us-ascii?Q?UIb1tCms1aZWjzIHq9VIzs6MNb0/KqWGLL9lmd612eElcpnlly+Kq91Z5N7K?=
 =?us-ascii?Q?uKiYiewGaHiewzLv2WC4shURg3cXCmCuGMTmWFDy8koTc+FhehWQh+ImzxaF?=
 =?us-ascii?Q?8icTrTXXXwUZqQag1PpVrCbR/YtRrfGh5tLcVqTPZx5BE3m/ORQjtcPnEl43?=
 =?us-ascii?Q?TxRz6kE69e9nRbW1TLYmiLeSgv4bI6t46FiAlVysdpOjQ4Zbkn5AasbBeLja?=
 =?us-ascii?Q?ITQiWA0Ijgw7mOG+O+b35KVM8BbNs7dxCNNwFc9OvArOfCeCgDrBLkbcd460?=
 =?us-ascii?Q?UaSMcxJYNXrW18/rrHhhfdr6I/zwXPlw00FbyPGBUm9ZznpTSjTE6GDJTzZJ?=
 =?us-ascii?Q?aggdJlWhAzR7T2ThkZJjdSB3EjSvLDvsv2B7ZCz2mPkHikCzb+JgCUlvgCAH?=
 =?us-ascii?Q?/Obor50I5Z17M9uuxpIZQp9ZHi2nx5eIEHTnArRjvmaHXBpV3wPoH/JqVONP?=
 =?us-ascii?Q?rc3/xoMRwvL1vvrGViv0EaOYKX0bZA4UmrW6J98A3ybRu2wYTbOr6K1SU1Vk?=
 =?us-ascii?Q?TyjacyV0aBsr+7I28LnmkjKZIM6kq1vUxvkWBZYc7UkkAKzPoUVsVnz9xV5g?=
 =?us-ascii?Q?TCzxPUFpZeS3lfX/K3+bZeypVrzTMOFIP6ASzt5HJagKVTTYs6z/XkNAJUlT?=
 =?us-ascii?Q?bfWMcPGl6jm5MakK2QxlF3ObXC/44+z6WbvySPrrpwzbUkXlWZlPamKU4jx/?=
 =?us-ascii?Q?nOPrXDGxTUJyqLsmOS4pbaYcBBNB65LlMtaLRYuSjVLCIB6MCjY/tP6RepVu?=
 =?us-ascii?Q?Bd8KSeMHhf0ynOwKC4e9ViDLRh321KP22+5t3JE15bNvDYywIN050ZnRj+8l?=
 =?us-ascii?Q?aGq6fq/wMVesNfprmS+mEneSgX9ADXamg83+SMiWUZrDAAFZBCvdefS67f+m?=
 =?us-ascii?Q?q7lcjrHDoq7zN93uq1l98v9Y2CWqK3c48fSRYRyiMdgv68kXT+8iFfbQgjXH?=
 =?us-ascii?Q?ms5uUrL6LYtQvnXPcAB3T+SKTXcLD8YmfDayZDUr/ECS8y9ISml9HCsTPRv/?=
 =?us-ascii?Q?zULgwhZniKzoOjm9RK3qfiOu8x47lA1o3LEiLiGg0soe4tlMxp9bz4FZ7Qbp?=
 =?us-ascii?Q?70hjjduFZN2jdQ0Z1mrLq5wbA/uxpdenWL0gjtnTCDHQT/OPJsk9dj6bD2cJ?=
 =?us-ascii?Q?xpsJzRZjwlOW3MD23OqcDv5SJep7GpCJjxaJokjzu2LtYxhhjl50bmn7PloL?=
 =?us-ascii?Q?omHOsohPIVUAykbjGzIa46lt8fbNSOAFxbaNG7Vx1Xh0YWwt0krttGZ4nl1B?=
 =?us-ascii?Q?kuqvAfFzeCc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WB+IQVpXD4ZjF1DD0MPn/n7a3L72x8WimXE0NHwkiVyubfD3znkgIeqYMHYQ?=
 =?us-ascii?Q?/HWuljhip7WbCyVabpDE/dklJWgw9cEkWMUMfTl/OeGYzCInMyXKyhK3PyLW?=
 =?us-ascii?Q?BNeuoKWfTVDbWE+3pi5pSk/NiUim3REnkH0SWQBHDxGbomj6dLaW1iZSTRir?=
 =?us-ascii?Q?mQZtiK2CzKPFgbkgZsvh6BrS6ytYqlAFu7uJIqiS6r1nppYrf/+RKI84DfPB?=
 =?us-ascii?Q?pilWG2WD8IUGMlvbE//GOmbHan+xPL21QJigUNsdlswTtprYRQyzkIAGw6Te?=
 =?us-ascii?Q?v168l6KWPDkn9fkGMw1xnpp5sUAQuj9SjFlUgubgXT27+Or4263d++Ktxj5w?=
 =?us-ascii?Q?eSaB+yCGVoyETf8lpu3vBm4rMCATQmE4z2rjLwwb+nLCcaSt9CA2xSXu0Rwy?=
 =?us-ascii?Q?IFtAYZiCYzqENf18yn3x/vjgtCxdjRqIMwsDbTz5tdJedEYZEtTuHqcfyixF?=
 =?us-ascii?Q?CQF4A/Ne0QfX0F4zcHjqDR5V8eFpeB7i4xGYt472YlDFxFwt5zhfCkO+lGXJ?=
 =?us-ascii?Q?MvREEyHMIQbfc6YhcyKiMTcmjkY1z2SwYsDv420XHEnNN7zDIIioe2dkwqvA?=
 =?us-ascii?Q?MUR62O0X7MMfDn5RNa8RQwpolzYuzgS3Vp0CT2vpzNE40sF8x8TF2h5YFCMH?=
 =?us-ascii?Q?9cKGT3+5TIwmTHWcm8/PIn3vLg09BEDuBtGx45/o9NAP+tj0SnxgTJXxnxlt?=
 =?us-ascii?Q?G8wt58h39CrXtDHiejo+DoSwNn9HK+/NvJj81u84sqZ1l4wjijj1djwV2h/F?=
 =?us-ascii?Q?zHuZfp+7Zx6/JSbxKR2zvWv5lwwjG5IVMg3VRlN6Ge7d58Z/4eDVzbFNbTMq?=
 =?us-ascii?Q?9TtwyX/7k/26Vcg5L1NfgqtNTBJ3FdLwfaZ0z9esSPl3hitIgJRYKpF0s/Hk?=
 =?us-ascii?Q?uRNPIlE6wafmu7rr3KYiQDeUn59d77pM9+WP0jl8n3tlsIJC03Hj2Uq0Wf6Q?=
 =?us-ascii?Q?6GT1pVSVu1zR4i0aeqYCStV/5ogfC2RyCGaqOU3fZtO9WawhCp2tndHD0Cww?=
 =?us-ascii?Q?1MRs4Y6YpX/ykQP5tJqvpBbJuCGSTFWqoF2TyTDz3VMa+v/vG/hSzuNgPeek?=
 =?us-ascii?Q?DjlAD/gB8zBeV+JvobO6L5/LKcXpDcTTsqFMZ1OQ6ZXHNyeYWFo6ocz8S/Ou?=
 =?us-ascii?Q?j3QCl0PHtGjnzL7Swy02izJE5sZjE8IT7wLWAi52jiBR6EP6BzqMxyv1ijK2?=
 =?us-ascii?Q?Js8eSl+fCsjv6/QWn7Jc6IjQg6FKHS2lv+n8u3azLll+zj7CaoewVaAh5QsZ?=
 =?us-ascii?Q?ZanU7S5RfOA/LDkpITqxNnCTHr8WzpKc6Juz1viYuLIq8B8vG12gGZlOUlrX?=
 =?us-ascii?Q?FhPMBg7D9IzYZHWS4OU/mwcFLcw8KB2tiyB1tDA2EvLuIUnzuUNi1NmKZ5qq?=
 =?us-ascii?Q?dKlar6uQjuLqTjpY3XTsTBiy0StP8NiZke3ZRrsTtlgyMvo25e+38BovdFRy?=
 =?us-ascii?Q?gtL/Snxlgws5zl9cMOX7qWqtK1OYOWZdDwuZXLK8pn6oebDhZ6PjDixbPlaA?=
 =?us-ascii?Q?FSJHUROPDMgPT2Un6Vxe/wpxUwjMlzIGM20ORUWKkcLi4Wh9BMo97LRM9BeK?=
 =?us-ascii?Q?cY69gAY7o/PYx1wq16lnXIhfsSZ9YS1+9eH6sdszEBL7lm/EEC8EU7GWY1J3?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9c9368-252e-49ae-a7e9-08ddc483077e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:08:40.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4hflDAeNdgM1e+2ij/2mB+i1abQYup1oH7stNfXZN5fYD0tAy/NumZEAL1ZFWhmO7qiaAcN/NTSbAYjP4y/s0dbNcFp+tk1a5jTKDsxWaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
X-OriginatorOrg: intel.com

The ability to emulate a host bridge is useful not only for hardware PCI
controllers like CONFIG_VMD, or virtual PCI controllers like
CONFIG_PCI_HYPERV, but also for test and development scenarios like
CONFIG_SAMPLES_DEVSEC [1].

One stumbling block for defining CONFIG_SAMPLES_DEVSEC, a sample
implementation of a platform TSM for PCI Device Security, is the need to
accommodate PCI_DOMAINS_GENERIC architectures alongside x86 [2].

In support of supplementing the existing CONFIG_PCI_BRIDGE_EMUL
infrastructure for host bridges:

* Introduce pci_bus_find_emul_domain_nr() as a common way to find a free
  PCI domain number whether that is to reuse the existing dynamic
  allocation code in the !ACPI case, or to assign an unused domain above
  the last ACPI segment.

* Convert pci-hyperv to the new allocator so that the PCI core can
  unconditionally assume that bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET
  is the dynamically allocated case.

A follow on patch can also convert vmd to the new scheme. Currently vmd
is limited to CONFIG_PCI_DOMAINS_GENERIC=n (x86) so, unlike pci-hyperv,
it does not immediately conflict with this new
pci_bus_find_emul_domain_nr() mechanism.

Link: http://lore.kernel.org/174107249038.1288555.12362100502109498455.stgit@dwillia2-xfh.jf.intel.com [1]
Reported-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Closes: http://lore.kernel.org/20250311144601.145736-3-suzuki.poulose@arm.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/controller/pci-hyperv.c | 53 ++---------------------------
 drivers/pci/pci.c                   | 43 ++++++++++++++++++++++-
 drivers/pci/probe.c                 |  8 ++++-
 include/linux/pci.h                 |  4 +++
 4 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ef5d655a0052..cfe9806bdbe4 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3630,48 +3630,6 @@ static int hv_send_resources_released(struct hv_device *hdev)
 	return 0;
 }
 
-#define HVPCI_DOM_MAP_SIZE (64 * 1024)
-static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
-
-/*
- * PCI domain number 0 is used by emulated devices on Gen1 VMs, so define 0
- * as invalid for passthrough PCI devices of this driver.
- */
-#define HVPCI_DOM_INVALID 0
-
-/**
- * hv_get_dom_num() - Get a valid PCI domain number
- * Check if the PCI domain number is in use, and return another number if
- * it is in use.
- *
- * @dom: Requested domain number
- *
- * return: domain number on success, HVPCI_DOM_INVALID on failure
- */
-static u16 hv_get_dom_num(u16 dom)
-{
-	unsigned int i;
-
-	if (test_and_set_bit(dom, hvpci_dom_map) == 0)
-		return dom;
-
-	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
-		if (test_and_set_bit(i, hvpci_dom_map) == 0)
-			return i;
-	}
-
-	return HVPCI_DOM_INVALID;
-}
-
-/**
- * hv_put_dom_num() - Mark the PCI domain number as free
- * @dom: Domain number to be freed
- */
-static void hv_put_dom_num(u16 dom)
-{
-	clear_bit(dom, hvpci_dom_map);
-}
-
 /**
  * hv_pci_probe() - New VMBus channel probe, for a root PCI bus
  * @hdev:	VMBus's tracking struct for this root PCI bus
@@ -3715,9 +3673,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 * collisions) in the same VM.
 	 */
 	dom_req = hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
-	dom = hv_get_dom_num(dom_req);
+	dom = pci_bus_find_emul_domain_nr(dom_req);
 
-	if (dom == HVPCI_DOM_INVALID) {
+	if (dom < 0) {
 		dev_err(&hdev->device,
 			"Unable to use dom# 0x%x or other numbers", dom_req);
 		ret = -EINVAL;
@@ -3851,7 +3809,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 destroy_wq:
 	destroy_workqueue(hbus->wq);
 free_dom:
-	hv_put_dom_num(hbus->bridge->domain_nr);
+	pci_bus_release_emul_domain_nr(hbus->bridge->domain_nr);
 free_bus:
 	kfree(hbus);
 	return ret;
@@ -3976,8 +3934,6 @@ static void hv_pci_remove(struct hv_device *hdev)
 	irq_domain_remove(hbus->irq_domain);
 	irq_domain_free_fwnode(hbus->fwnode);
 
-	hv_put_dom_num(hbus->bridge->domain_nr);
-
 	kfree(hbus);
 }
 
@@ -4148,9 +4104,6 @@ static int __init init_hv_pci_drv(void)
 	if (ret)
 		return ret;
 
-	/* Set the invalid domain number's bit, so it will not be used */
-	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
-
 	/* Initialize PCI block r/w interface */
 	hvpci_block_ops.read_block = hv_read_config_block;
 	hvpci_block_ops.write_block = hv_write_config_block;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113b..833ebf2d5213 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6692,9 +6692,50 @@ static void pci_no_domains(void)
 #endif
 }
 
+#ifdef CONFIG_PCI_DOMAINS
+static DEFINE_IDA(pci_domain_nr_dynamic_ida);
+
+/*
+ * Find a free domain_nr either allocated by pci_domain_nr_dynamic_ida or
+ * fallback to the first free domain number above the last ACPI segment number.
+ * Caller may have a specific domain number in mind, in which case try to
+ * reserve it.
+ *
+ * Note that this allocation is freed by pci_release_host_bridge_dev().
+ */
+int pci_bus_find_emul_domain_nr(int hint)
+{
+	if (hint >= 0) {
+		hint = ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
+				       GFP_KERNEL);
+
+		if (hint >= 0)
+			return hint;
+	}
+
+	if (acpi_disabled)
+		return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
+
+	/*
+	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
+	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
+	 * which the lower 16 bits are the PCI Segment Group (domain) number.
+	 * Other bits are currently reserved.
+	 */
+	return ida_alloc_range(&pci_domain_nr_dynamic_ida, 0x10000, INT_MAX,
+			       GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(pci_bus_find_emul_domain_nr);
+
+void pci_bus_release_emul_domain_nr(int domain_nr)
+{
+	ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
+}
+EXPORT_SYMBOL_GPL(pci_bus_release_emul_domain_nr);
+#endif
+
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 static DEFINE_IDA(pci_domain_nr_static_ida);
-static DEFINE_IDA(pci_domain_nr_dynamic_ida);
 
 static void of_pci_reserve_static_domain_nr(void)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..e94978c3be3d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -632,6 +632,11 @@ static void pci_release_host_bridge_dev(struct device *dev)
 
 	pci_free_resource_list(&bridge->windows);
 	pci_free_resource_list(&bridge->dma_ranges);
+
+	/* Host bridges only have domain_nr set in the emulation case */
+	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
+		pci_bus_release_emul_domain_nr(bridge->domain_nr);
+
 	kfree(bridge);
 }
 
@@ -1112,7 +1117,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	device_del(&bridge->dev);
 free:
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	pci_bus_release_domain_nr(parent, bus->domain_nr);
+	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
+		pci_bus_release_domain_nr(parent, bus->domain_nr);
 #endif
 	if (bus_registered)
 		put_device(&bus->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..f6a713da5c49 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1934,10 +1934,14 @@ DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
  */
 #ifdef CONFIG_PCI_DOMAINS
 extern int pci_domains_supported;
+int pci_bus_find_emul_domain_nr(int hint);
+void pci_bus_release_emul_domain_nr(int domain_nr);
 #else
 enum { pci_domains_supported = 0 };
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
+static inline int pci_bus_find_emul_domain_nr(int hint) { return 0; }
+static inline void pci_bus_release_emul_domain_nr(int domain_nr) { }
 #endif /* CONFIG_PCI_DOMAINS */
 
 /*
-- 
2.50.1


