Return-Path: <linux-pci+bounces-34852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B0B378DB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9E01B672C8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427330DEBC;
	Wed, 27 Aug 2025 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YehzCQ8C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B230DD38
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266700; cv=fail; b=MvRhowNqsdho7IOdN2W9fCXhT0D5JSO8irmAZUcEhah2DfgT5CKr/y6POe+A+duljRTKDEjYaj6gLyGmDj/PV9uNNl1VKlLSE5ucLCT+hCthlVX9XbBDx7N9Y+dAkID4UEAbSbGhxKuS/ssnhMxJFGKSJhYDyLHqPJSjxPLrGs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266700; c=relaxed/simple;
	bh=AfhT00JRQy2igOCnRLSpd71PMZDuqmN9fg5zgyz/6Ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AASJh845/zYs1kI3jRvU+DoDokYapZdqSdwq/Ia940akENs0z/FONZm15rLZ+ihqlq3EdqTX7Bff0D9xOg1LekmHBW/i/o9VK217pW9HXcZy3sJ/qgX8vweyxQtPiHvA8VONlng5Kcz3IINoTYbRs/dvRxtiQDpBY07cVVpDfVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YehzCQ8C; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266698; x=1787802698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AfhT00JRQy2igOCnRLSpd71PMZDuqmN9fg5zgyz/6Ko=;
  b=YehzCQ8CTd1VrIE9fcdc7l+L/t/t+gPMmNfKwkMgtW5yHEjjazUjLoyj
   TwscbIVJD8nSviCKgx3pZVFG/wlMmurb/Dcm17ocT1dsC1AEOprCUKjkP
   YbGQ9siIreudkvHTsh7Avim1kQ5JbeIw46Py+FTuE43JkMJISbUc8RneG
   uEJnlv6SI3qRbYpYqHnimqC4PMnP2r7efG29qIkJXrUZeUXNb4KVVL275
   WQu7r+KldFnAPc6wpEMwk1j7k1HuFCYRb3chAIdqzaNYzaVyDe/7YhmxL
   Q9n7xJxFDtLu3Y5igCOJvjZ6E7xggjJmzWlHAsjD+b0a10Yoqqg0TYKFl
   g==;
X-CSE-ConnectionGUID: e6ZBIr1yTyazSGQBMb9jQA==
X-CSE-MsgGUID: I9ruVvg3R/GbyMJS/lKPGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159128"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159128"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:36 -0700
X-CSE-ConnectionGUID: Wi1EGsoaSwCIRSvoouYE+Q==
X-CSE-MsgGUID: Tq30eTvXRBCKHE1DhdungA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685108"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.72)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSE5oRCLJuaZ/UB97suLMLlWdUSlgIqdE0P4FOwy7ikWiaodjELE9sfna4ZSO36dv5qEbAxzTkcB+U+aIzT4cl7xDIua4be66CXjnEN9Y+0YF83swhUv4JaOI/ZSnym1cH7lV+B+hhUeZRwShEOU2UMVnBRu7XB2JFbBBcyl3JsMXDZHd2TvlY5wGbNhs6v/MYS35p5N7SfVxqqE3UG7HMgQvggeZZl/kgybgQgEzOX+m/BEY4+qSt3hShntiDBEU8plTMFY/cVCemRJlQwDdwHa62SHQ2piPKJR998NyY2xOJAI5xKS+FGos3M9r72KVgTPr+ASS4gc0ethPnlrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGoCq2maex9C6/MVwmmVRUH1YzHipu4VX4dwblnR/0c=;
 b=U6Cu88557YhZJsXhzAD1yxBsDWeQJco6vZ4sVM3+Ns7o2nEIJ+VMaEwtBTrP5qVUrRy02pfsXW6JUQ5ufvY3lzhmbn7CVW8CkYsOWvD1QF4YQbc2vJQSlYHJYhH87h0u4AuQqV3Nwk3IVaYUGfQtR/Ao/qGfOqQlhEy4sOf9LmQRKLhnDrOu0ub+tYEH91e5WS+SO5IdLs2h22rnTph223VPydBO65xwXSgJDYRMKxR6mfUSYYAIReOgfZW1jB5gZogaepIdWSCrKcZsFaMkJ1CkZHSoBsIWroQHZaJB5xr1v6MHaLfk2TXZU9q6Us4a7d3ZpE93cLYhqfqxFp/ccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:51:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:51:33 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Subject: [PATCH v5 05/10] samples/devsec: Introduce a PCI device-security bus + endpoint sample
Date: Tue, 26 Aug 2025 20:51:21 -0700
Message-ID: <20250827035126.1356683-6-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035126.1356683-1-dan.j.williams@intel.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a11b94-4322-4a35-0725-08dde51d037f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?96UFzTnpYJeePqLwyDJVQY66RCsBn+00M+0VOxsGpopm1PC7nnwP+WC+kldw?=
 =?us-ascii?Q?M/4Ry78E4zTFF2QZyED33tLoI44Lm6MFWMhRglf8sC29WcGD+L8zfbAzz1U/?=
 =?us-ascii?Q?K0ZHO1hWYBd0IJfEQp+aiFZ4aGJHadxjHyxl8bRD9sA7DJ8MQhbnwvUjnjBZ?=
 =?us-ascii?Q?4aMdkJUItdLBFvMxVQ0DgCs1Fyx0G1liGxbDiOMF2M/1wvvhPk9UwzlU2w5w?=
 =?us-ascii?Q?O/ctaP3wACEwIHQRSx7MvS0SmWrjjvxf9dwsW/7KyW9vD/Ug5wa5ZeDNAaXu?=
 =?us-ascii?Q?dzONly9MLgL25L/5+XYX7JzdkhhPAPIYFB3+bN9LE7WP9qZYc4xwITVIvJXy?=
 =?us-ascii?Q?K0y+n9s8+HlXPe+XF6PdrfR52np7+8RCRxxgMdJrYC/t1GEV+lDrdHvXDfoR?=
 =?us-ascii?Q?WUweGB+XTPwOux4OKKN5hGGvZmjgc9HKt1lXoAYcrmJmVAYvSc+oC/BKuH4E?=
 =?us-ascii?Q?lVS/r3KzLMnhDFqJya8Tgd2sirGLXvTK47LmXJhrnmXQ1t9lzHrQOAPVcDZk?=
 =?us-ascii?Q?Ud+NSnQbZJqT8yrOnF0rwxS+DPkVoQ5Fzgsv4EUbzPj5yrxS0rYOx1Csl0P0?=
 =?us-ascii?Q?BBdpXPxC8l0PeFV4lVI5fLnc5+3Pk6kIH3jiu0uosVnMqdfzI7V6CH5sb4m9?=
 =?us-ascii?Q?Stz4Iuv34oTN8ThQlYTOpB7iuk36gCZoVV8x/snVItyFf/BRe4Pm5QoCORjy?=
 =?us-ascii?Q?Axh9iJjC3vsJ1LFsf5yQIhlIOCUEJ5giDpK/2Jr3Z3KCXWlG3MCzxQ5cbgIs?=
 =?us-ascii?Q?vP+MFTiK+oLwEsPoyKwsZB5iLfz3W4bar5/EHwTUVQ+0tjvGNTzBIAWHry3F?=
 =?us-ascii?Q?O4JsxbBkryIZr6JeZVD+vvD0wbfDopH9X4g1BVQjkfRfTYRUqBsSUIRfATG6?=
 =?us-ascii?Q?dv0Vu2ae7fGnFWlGVCaxc2OQ35lEuiRnz9rK/xqkQxQKck8XEbqDpfV0T204?=
 =?us-ascii?Q?zlkdFLuGM0dTYU3WFDB7+me6BRAQDfCTAnbQKlnbjdB9t3iijXs5vUh7rYm9?=
 =?us-ascii?Q?EWU5V8QjM3Vb+NeUEMtj2a5Alh+ormwxmpMKYfWF2wrS1vT4Myg2CE/oRWql?=
 =?us-ascii?Q?IvrPGPE5XPFbWUNVeSjQHxK52y6N1KHGreCCH0dKoTu3SA1vNNRW8LqUbLYj?=
 =?us-ascii?Q?j+xw2RGLBgUNxXsk3CF/2R3hk2IB1lhoi0kKQF/ZsQ5UkX6I9NLyivrP3rk+?=
 =?us-ascii?Q?4sgcuzZwfSJdvBMyXAfB7B3X9JUbEKKIHOHhOt/hnPg8+6LfnPHIqklBFwob?=
 =?us-ascii?Q?XaGm/J+bajg3AHSOh5fu0z8R1dyym14OiX5MtJIjzSFbXZkynM5mmbWYzTzM?=
 =?us-ascii?Q?aFpfl/ak7kn8zdPwOgAjW4ELyYgwAWu5GRFB7qSR2M+VIbi1D6Hb3RibExsw?=
 =?us-ascii?Q?W+1UDryGA0NurxugwFi/pZYViv/TEixQ9ABqgXJFOLneDg8JQiOii89Kskaw?=
 =?us-ascii?Q?3m8dxeCmf1I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BN1XMeFAKLriwxeYfeN3KVkCHwOXi8BhJPtYVErhMt/f+dfTFQ+VY6I0yRyP?=
 =?us-ascii?Q?WXm7mZxUBaGQabdlXSoy6LuJ0WdsSfiNTjJS8PKzIXqN0QLOyGgMKET6sD/o?=
 =?us-ascii?Q?ybn9S4SEqY2eI4vYpW1zxla3nC/s1WtLnZXNdOr6h3RJaXbs2f/gs4TehIo7?=
 =?us-ascii?Q?l4fJoke8xRARUii7rGu0xUXpcjcP275CZ5vhdwCHcY1DXOFwjeC/DA/u/Ffe?=
 =?us-ascii?Q?fMMPmO09qFITXt0Sqgw5yYGg0Hj6l/oIyaxmHMx7uvId69ucUBVCoJe6BgAZ?=
 =?us-ascii?Q?IB1xs1vJtAMv5If/7U4pGMxAXoaLm+shF7i9fHDZAbxr/bzDa4UUgBe8PJJM?=
 =?us-ascii?Q?rXlvRQERUx4mrbJEZVyo0YyUb8eb7Rykf7sdSBsKLMEuE9VMAiKn84YOMTDH?=
 =?us-ascii?Q?SlkXIqXsB6EHwBs50pcKEigTQg8NM0sMx8HGVgRmBKO14THlZqSmT4vLQkw7?=
 =?us-ascii?Q?zfrk316jJ65DfYL+FRm8T0jEESXldSy8Z7GgJ80CvZLI8Ycta7BS48xtNVHh?=
 =?us-ascii?Q?H3k5tjdjSgvLHCew+b+kyXUv2c8srirs5hpQjCVXGASBt/Tgir4NCmkAGHgw?=
 =?us-ascii?Q?ZBeWfP59VX/jAnk6ApagUeIJ5mhx1D9rqOcORbIIq0bAHID0G5bYFbeDNHGq?=
 =?us-ascii?Q?DcuY7wpq6capBmOXDJ5fgce3r8p8Eo2Q0Gt7JQ6mvcbYfzEumzO2Ri98kw4y?=
 =?us-ascii?Q?tcv+AxObtenyusHQBcXEa72l+svDrTzoDb1nGpnny7kCzpAvf6+2Z00zK/t3?=
 =?us-ascii?Q?8oOmyjTK3ujnNXLezFRWGx6MyPdLfxbWGEGUoOCqc4VvGL8FjrSvaZXaPfAd?=
 =?us-ascii?Q?SX7TFuLKXuNkGxckc26PhCeW3+rcGA+mQeorMKG1EHUsZkiSxrXXLN/k9lgt?=
 =?us-ascii?Q?3QboWZaj/Fm6nZzUmVB3OLv4QR4CsKirPocLp2rORR9uCXjuT0t+iDQhz8BT?=
 =?us-ascii?Q?DzvX8OmZr9Sl2aU01TBfDzsW9mJPErCWEHnH6C9nXXWxdfISJF64VDB//E+j?=
 =?us-ascii?Q?DaA6wKr/OvSImzMWKelqo7rPx2COYEiRMykQFLn0Oza7KpBn7taJpRIUnfAO?=
 =?us-ascii?Q?KgiH4MSHXwq0mY/ImYAgsRRDs4KN49tE+wDcqNXwgwC5bmTpjTt2dBwKM/Nl?=
 =?us-ascii?Q?u3eIvDGzF/DURAF7P2LF4y7o5L1r/0umHDbjQB7y1RzqmBvewG+wlIHhvs+b?=
 =?us-ascii?Q?yzjLFj4LGlM37qAc4kpKlGnr+vHFylqIVJkjZq2osC8Sg4rYN3hcCrmKxmWq?=
 =?us-ascii?Q?QKeD8jMjPeQGkaMyIUxB2a9GnOrLNCVW8ov05UAUMjyL2E/hX5kg1ZDMTS9t?=
 =?us-ascii?Q?R3XlpRbNT8V/CTQpsPn+jYOJrDTSrUeio2FZqHx+bfqb1ZNd4m6Hax1kDzaM?=
 =?us-ascii?Q?V23N7ejB+TwkJZaCCNoA7FOX6jPtDTUg0Y6qWe6h3xfEX0nOWT7jA7ImWnse?=
 =?us-ascii?Q?7n9zDJ/OOEOeM4UM2+0jSV5LQarsCu3xueNGUJEGhlqhL62F7U6VVaBA6GCe?=
 =?us-ascii?Q?xXZS37p+yaVWCVbV36d1g/7jQrzJwzSnpF/SeiXeyDgKxvmZ9moVhnz+8rlv?=
 =?us-ascii?Q?ye17wRmmbcyPO3xk4YSuV/ex2TDRh+4MRLIEHjSMI0VaprNa9QEsknyRYpgo?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a11b94-4322-4a35-0725-08dde51d037f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:33.3785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLks5ABNYQWxsDLECD97Lgmon3ihg3V0VeaW3Nsln44nknH9NVihmeGC+6lq7ZYn4th9zH0FY3OQkSxQGMkEze4fUjuU1pzKXyUBs48AP6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

Establish just enough emulated PCI infrastructure to register a sample
TSM (platform security manager) driver and have it discover an IDE + TEE
(link encryption + device-interface security protocol (TDISP)) capable
device.

Use the existing CONFIG_PCI_BRIDGE_EMUL to emulate an IDE capable root
port, and open code the emulation of an endpoint device via simulated
configuration cycle responses.

The devsec_tsm driver responds to the PCI core TSM operations as if it
successfully exercised the given interface security protocol message.

The devsec_bus and devsec_tsm drivers can be loaded in either order to
reflect cases like SEV-TIO where the TSM is PCI-device firmware, and
cases like TDX Connect where the TSM is a software agent running on the
host CPU.

Follow-on patches add common code for TSM managed IDE establishment. For
now, just successfully complete setup and teardown of the DSM (device
security manager) context as a building block for management of TDI
(trusted device interface) instances.

 # modprobe devsec_bus
    devsec_bus devsec_bus: PCI host bridge to bus 10000:00
    pci_bus 10000:00: root bus resource [bus 00-01]
    pci_bus 10000:00: root bus resource [mem 0xf000000000-0xffffffffff 64bit]
    pci 10000:00:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
    pci 10000:00:00.0: PCI bridge to [bus 00]
    pci 10000:00:00.0:   bridge window [io  0x0000-0x0fff]
    pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
    pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
    pci 10000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
    pci 10000:01:00.0: [8086:ffff] type 00 class 0x000000 PCIe Endpoint
    pci 10000:01:00.0: BAR 0 [mem 0xf000000000-0xf0001fffff 64bit pref]
    pci_doe_abort: pci 10000:01:00.0: DOE: [100] Issuing Abort
    pci_doe_cache_protocols: pci 10000:01:00.0: DOE: [100] Found protocol 0 vid: 1 prot: 1
    pci 10000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
    pci 10000:00:00.0: PCI bridge to [bus 01]
    pci_bus 10000:01: busn_res: [bus 01] end is updated to 01

 # modprobe devsec_link_tsm
    pf0_sysfs_enable: pci 10000:01:00.0: PCI/TSM: Device Security Manager detected (IDE TEE)

 # echo tsm0 > /sys/bus/pci/devices/10000:01:00.0/tsm/connect
    devsec_tsm_pf0_probe: pci 10000:01:00.0: devsec: TSM enabled

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS               |   1 +
 samples/Kconfig           |  19 +
 samples/Makefile          |   1 +
 samples/devsec/Makefile   |  10 +
 samples/devsec/bus.c      | 734 ++++++++++++++++++++++++++++++++++++++
 samples/devsec/common.c   |  26 ++
 samples/devsec/devsec.h   |  40 +++
 samples/devsec/link_tsm.c | 174 +++++++++
 8 files changed, 1005 insertions(+)
 create mode 100644 samples/devsec/Makefile
 create mode 100644 samples/devsec/bus.c
 create mode 100644 samples/devsec/common.c
 create mode 100644 samples/devsec/devsec.h
 create mode 100644 samples/devsec/link_tsm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f1aabab88c79..c1ad1294560c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25623,6 +25623,7 @@ F:	Documentation/driver-api/pci/tsm.rst
 F:	drivers/pci/tsm.c
 F:	drivers/virt/coco/guest/
 F:	include/linux/*tsm*.h
+F:	samples/devsec/
 F:	samples/tsm-mr/
 
 TRUSTED SERVICES TEE DRIVER
diff --git a/samples/Kconfig b/samples/Kconfig
index 6e072a5f1ed8..8a52fd08031a 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -324,6 +324,25 @@ source "samples/rust/Kconfig"
 
 source "samples/damon/Kconfig"
 
+config SAMPLE_DEVSEC
+	tristate "Build a sample TEE Security Manager with an emulated PCI endpoint"
+	depends on m
+	depends on PCI
+	depends on VIRT_DRIVERS
+	depends on PCI_DOMAINS_GENERIC || X86
+	select PCI_BRIDGE_EMUL
+	select PCI_TSM
+	select TSM
+	help
+	  Build a sample platform TEE Security Manager (TSM) driver with a
+	  corresponding emulated PCIe topology. The resulting sample modules,
+	  devsec_bus and devsec_tsm, exercise device-security enumeration, PCI
+	  subsystem use ABIs, device security flows. For example, exercise IDE
+	  (link encryption) establishment and TDISP state transitions via a
+	  Device Security Manager (DSM).
+
+	  If unsure, say N
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index 07641e177bd8..59b510ace9b2 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_MTIER)	+= damon/
 obj-$(CONFIG_SAMPLE_HUNG_TASK)		+= hung_task/
 obj-$(CONFIG_SAMPLE_TSM_MR)		+= tsm-mr/
+obj-y					+= devsec/
diff --git a/samples/devsec/Makefile b/samples/devsec/Makefile
new file mode 100644
index 000000000000..da122eb8d23d
--- /dev/null
+++ b/samples/devsec/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_common.o
+devsec_common-y := common.o
+
+obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_bus.o
+devsec_bus-y := bus.o
+
+obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_link_tsm.o
+devsec_link_tsm-y := link_tsm.o
diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
new file mode 100644
index 000000000000..07cf4ce82ceb
--- /dev/null
+++ b/samples/devsec/bus.c
@@ -0,0 +1,734 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2024 - 2025 Intel Corporation. All rights reserved.
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/device/faux.h>
+#include <linux/module.h>
+#include <linux/range.h>
+#include <uapi/linux/pci_regs.h>
+#include <linux/pci.h>
+
+#include "../../drivers/pci/pci-bridge-emul.h"
+#include "devsec.h"
+
+#define NR_DEVSEC_BUSES 1
+#define NR_PORT_STREAMS 1
+#define NR_ADDR_ASSOC 1
+
+struct devsec {
+	struct pci_host_bridge hb;
+	struct devsec_sysdata sysdata;
+	struct resource busnr_res;
+	struct resource mmio_res;
+	struct resource prefetch_res;
+	struct pci_bus *bus;
+	struct device *dev;
+	struct devsec_port {
+		union {
+			struct devsec_ide {
+				u32 cap;
+				u32 ctl;
+				struct devsec_stream {
+					u32 cap;
+					u32 ctl;
+					u32 status;
+					u32 rid1;
+					u32 rid2;
+					struct devsec_addr_assoc {
+						u32 assoc1;
+						u32 assoc2;
+						u32 assoc3;
+					} assoc[NR_ADDR_ASSOC];
+				} stream[NR_PORT_STREAMS];
+			} ide __packed;
+			char ide_regs[sizeof(struct devsec_ide)];
+		};
+		struct pci_bridge_emul bridge;
+	} *devsec_ports[NR_DEVSEC_BUSES];
+	struct devsec_dev {
+		struct devsec *devsec;
+		struct range mmio_range;
+		u8 __cfg[SZ_4K];
+		struct devsec_dev_doe {
+			int cap;
+			u32 req[SZ_4K / sizeof(u32)];
+			u32 rsp[SZ_4K / sizeof(u32)];
+			int write, read, read_ttl;
+		} doe;
+		u16 ide_pos;
+		union {
+			struct devsec_ide ide __packed;
+			char ide_regs[sizeof(struct devsec_ide)];
+		};
+	} *devsec_devs[NR_DEVSEC_BUSES];
+};
+
+#define devsec_base(x) ((void __force __iomem *) &(x)->__cfg[0])
+
+static struct devsec *bus_to_devsec(struct pci_bus *bus)
+{
+	return container_of(bus->sysdata, struct devsec, sysdata);
+}
+
+static int devsec_dev_config_read(struct devsec *devsec, struct pci_bus *bus,
+				  unsigned int devfn, int pos, int size,
+				  u32 *val)
+{
+	struct devsec_dev *devsec_dev;
+	struct devsec_dev_doe *doe;
+	void __iomem *base;
+
+	if (PCI_FUNC(devfn) != 0 ||
+	    PCI_SLOT(devfn) >= ARRAY_SIZE(devsec->devsec_devs))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	devsec_dev = devsec->devsec_devs[PCI_SLOT(devfn)];
+	base = devsec_base(devsec_dev);
+	doe = &devsec_dev->doe;
+
+	if (pos == doe->cap + PCI_DOE_READ) {
+		if (doe->read_ttl > 0) {
+			*val = doe->rsp[doe->read];
+			dev_dbg(&bus->dev, "devfn: %#x doe read[%d]\n", devfn,
+				doe->read);
+		} else {
+			*val = 0;
+			dev_dbg(&bus->dev, "devfn: %#x doe no data\n", devfn);
+		}
+		return PCIBIOS_SUCCESSFUL;
+	} else if (pos == doe->cap + PCI_DOE_STATUS) {
+		if (doe->read_ttl > 0) {
+			*val = PCI_DOE_STATUS_DATA_OBJECT_READY;
+			dev_dbg(&bus->dev, "devfn: %#x object ready\n", devfn);
+		} else if (doe->read_ttl < 0) {
+			*val = PCI_DOE_STATUS_ERROR;
+			dev_dbg(&bus->dev, "devfn: %#x error\n", devfn);
+		} else {
+			*val = 0;
+			dev_dbg(&bus->dev, "devfn: %#x idle\n", devfn);
+		}
+		return PCIBIOS_SUCCESSFUL;
+	} else if (pos >= devsec_dev->ide_pos &&
+		   pos < devsec_dev->ide_pos + sizeof(struct devsec_ide)) {
+		*val = *(u32 *) &devsec_dev->ide_regs[pos - devsec_dev->ide_pos];
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	switch (size) {
+	case 1:
+		*val = readb(base + pos);
+		break;
+	case 2:
+		*val = readw(base + pos);
+		break;
+	case 4:
+		*val = readl(base + pos);
+		break;
+	default:
+		PCI_SET_ERROR_RESPONSE(val);
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int devsec_port_config_read(struct devsec *devsec, unsigned int devfn,
+				   int pos, int size, u32 *val)
+{
+	struct devsec_port *devsec_port;
+
+	if (PCI_FUNC(devfn) != 0 ||
+	    PCI_SLOT(devfn) >= ARRAY_SIZE(devsec->devsec_ports))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	devsec_port = devsec->devsec_ports[PCI_SLOT(devfn)];
+	return pci_bridge_emul_conf_read(&devsec_port->bridge, pos, size, val);
+}
+
+static int devsec_pci_read(struct pci_bus *bus, unsigned int devfn, int pos,
+			   int size, u32 *val)
+{
+	struct devsec *devsec = bus_to_devsec(bus);
+
+	dev_vdbg(&bus->dev, "devfn: %#x pos: %#x size: %d\n", devfn, pos, size);
+
+	if (bus == devsec->hb.bus)
+		return devsec_port_config_read(devsec, devfn, pos, size, val);
+	else if (bus->parent == devsec->hb.bus)
+		return devsec_dev_config_read(devsec, bus, devfn, pos, size,
+					      val);
+
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+#ifndef PCI_DOE_PROTOCOL_DISCOVERY
+#define PCI_DOE_PROTOCOL_DISCOVERY 0
+#define PCI_DOE_FEATURE_CMA 1
+#endif
+
+/* just indicate support for CMA */
+static void doe_process(struct devsec_dev_doe *doe)
+{
+	u8 type;
+	u16 vid;
+
+	vid = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, doe->req[0]);
+	type = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, doe->req[0]);
+
+	if (vid != PCI_VENDOR_ID_PCI_SIG) {
+		doe->read_ttl = -1;
+		return;
+	}
+
+	if (type != PCI_DOE_PROTOCOL_DISCOVERY) {
+		doe->read_ttl = -1;
+		return;
+	}
+
+	doe->rsp[0] = doe->req[0];
+	doe->rsp[1] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, 3);
+	doe->read_ttl = 3;
+	doe->rsp[2] = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID,
+				 PCI_VENDOR_ID_PCI_SIG) |
+		      FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
+				 PCI_DOE_FEATURE_CMA) |
+		      FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, 0);
+}
+
+static int devsec_dev_config_write(struct devsec *devsec, struct pci_bus *bus,
+				   unsigned int devfn, int pos, int size,
+				   u32 val)
+{
+	struct devsec_dev *devsec_dev;
+	struct devsec_dev_doe *doe;
+	struct devsec_ide *ide;
+	void __iomem *base;
+
+	dev_vdbg(&bus->dev, "devfn: %#x pos: %#x size: %d\n", devfn, pos, size);
+
+	if (PCI_FUNC(devfn) != 0 ||
+	    PCI_SLOT(devfn) >= ARRAY_SIZE(devsec->devsec_devs))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	devsec_dev = devsec->devsec_devs[PCI_SLOT(devfn)];
+	base = devsec_base(devsec_dev);
+	doe = &devsec_dev->doe;
+	ide = &devsec_dev->ide;
+
+	if (pos >= PCI_BASE_ADDRESS_0 && pos <= PCI_BASE_ADDRESS_5) {
+		if (size != 4)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
+		/* only one 64-bit mmio bar emulated for now */
+		if (pos == PCI_BASE_ADDRESS_0)
+			val &= ~lower_32_bits(range_len(&devsec_dev->mmio_range) - 1);
+		else if (pos == PCI_BASE_ADDRESS_1)
+			val &= ~upper_32_bits(range_len(&devsec_dev->mmio_range) - 1);
+		else
+			val = 0;
+	} else if (pos == PCI_ROM_ADDRESS) {
+		val = 0;
+	} else if (pos == doe->cap + PCI_DOE_CTRL) {
+		if (val & PCI_DOE_CTRL_GO) {
+			dev_dbg(&bus->dev, "devfn: %#x doe go\n", devfn);
+			doe_process(doe);
+		}
+		if (val & PCI_DOE_CTRL_ABORT) {
+			dev_dbg(&bus->dev, "devfn: %#x doe abort\n", devfn);
+			doe->write = 0;
+			doe->read = 0;
+			doe->read_ttl = 0;
+		}
+		return PCIBIOS_SUCCESSFUL;
+	} else if (pos == doe->cap + PCI_DOE_WRITE) {
+		if (doe->write < ARRAY_SIZE(doe->req))
+			doe->req[doe->write++] = val;
+		dev_dbg(&bus->dev, "devfn: %#x doe write[%d]\n", devfn,
+			doe->write - 1);
+		return PCIBIOS_SUCCESSFUL;
+	} else if (pos == doe->cap + PCI_DOE_READ) {
+		if (doe->read_ttl > 0) {
+			doe->read_ttl--;
+			doe->read++;
+			dev_dbg(&bus->dev, "devfn: %#x doe ack[%d]\n", devfn,
+				doe->read - 1);
+		}
+		return PCIBIOS_SUCCESSFUL;
+	} else if (pos >= devsec_dev->ide_pos &&
+		   pos < devsec_dev->ide_pos + sizeof(struct devsec_ide)) {
+		u16 ide_off = pos - devsec_dev->ide_pos;
+
+		for (int i = 0; i < NR_PORT_STREAMS; i++) {
+			struct devsec_stream *stream = &ide->stream[i];
+
+			if (ide_off != offsetof(typeof(*ide), stream[i].ctl))
+				continue;
+
+			stream->ctl = val;
+			stream->status &= ~PCI_IDE_SEL_STS_STATE;
+			if (val & PCI_IDE_SEL_CTL_EN)
+				stream->status |= FIELD_PREP(
+					PCI_IDE_SEL_STS_STATE,
+					PCI_IDE_SEL_STS_STATE_SECURE);
+			else
+				stream->status |= FIELD_PREP(
+					PCI_IDE_SEL_STS_STATE,
+					PCI_IDE_SEL_STS_STATE_INSECURE);
+			return PCIBIOS_SUCCESSFUL;
+		}
+	}
+
+	switch (size) {
+	case 1:
+		writeb(val, base + pos);
+		break;
+	case 2:
+		writew(val, base + pos);
+		break;
+	case 4:
+		writel(val, base + pos);
+		break;
+	default:
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int devsec_port_config_write(struct devsec *devsec, struct pci_bus *bus,
+				    unsigned int devfn, int pos, int size,
+				    u32 val)
+{
+	struct devsec_port *devsec_port;
+
+	dev_vdbg(&bus->dev, "devfn: %#x pos: %#x size: %d\n", devfn, pos, size);
+
+	if (PCI_FUNC(devfn) != 0 ||
+	    PCI_SLOT(devfn) >= ARRAY_SIZE(devsec->devsec_ports))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	devsec_port = devsec->devsec_ports[PCI_SLOT(devfn)];
+	return pci_bridge_emul_conf_write(&devsec_port->bridge, pos, size, val);
+}
+
+static int devsec_pci_write(struct pci_bus *bus, unsigned int devfn, int pos,
+			    int size, u32 val)
+{
+	struct devsec *devsec = bus_to_devsec(bus);
+
+	dev_vdbg(&bus->dev, "devfn: %#x pos: %#x size: %d\n", devfn, pos, size);
+
+	if (bus == devsec->hb.bus)
+		return devsec_port_config_write(devsec, bus, devfn, pos, size,
+						val);
+	else if (bus->parent == devsec->hb.bus)
+		return devsec_dev_config_write(devsec, bus, devfn, pos, size,
+					       val);
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+static struct pci_ops devsec_ops = {
+	.read = devsec_pci_read,
+	.write = devsec_pci_write,
+};
+
+static void destroy_bus(void *data)
+{
+	struct pci_host_bridge *hb = data;
+
+	pci_stop_root_bus(hb->bus);
+	pci_remove_root_bus(hb->bus);
+}
+
+static u32 build_ext_cap_header(u32 id, u32 ver, u32 next)
+{
+	return FIELD_PREP(GENMASK(15, 0), id) |
+	       FIELD_PREP(GENMASK(19, 16), ver) |
+	       FIELD_PREP(GENMASK(31, 20), next);
+}
+
+static void init_ide(struct devsec_ide *ide)
+{
+	ide->cap = PCI_IDE_CAP_SELECTIVE | PCI_IDE_CAP_IDE_KM |
+		   PCI_IDE_CAP_TEE_LIMITED |
+		   FIELD_PREP(PCI_IDE_CAP_SEL_NUM, NR_PORT_STREAMS - 1);
+
+	for (int i = 0; i < NR_PORT_STREAMS; i++)
+		ide->stream[i].cap =
+			FIELD_PREP(PCI_IDE_SEL_CAP_ASSOC_NUM, NR_ADDR_ASSOC);
+}
+
+static void init_dev_cfg(struct devsec_dev *devsec_dev)
+{
+	void __iomem *base = devsec_base(devsec_dev), *cap_base;
+	int pos, next;
+
+	/* BAR space */
+	writew(0x8086, base + PCI_VENDOR_ID);
+	writew(0xffff, base + PCI_DEVICE_ID);
+	writew(PCI_CLASS_ACCELERATOR_PROCESSING, base + PCI_CLASS_DEVICE);
+	writel(lower_32_bits(devsec_dev->mmio_range.start) |
+		       PCI_BASE_ADDRESS_MEM_TYPE_64 |
+		       PCI_BASE_ADDRESS_MEM_PREFETCH,
+	       base + PCI_BASE_ADDRESS_0);
+	writel(upper_32_bits(devsec_dev->mmio_range.start),
+	       base + PCI_BASE_ADDRESS_1);
+
+	/* Capability init */
+	writeb(PCI_HEADER_TYPE_NORMAL, base + PCI_HEADER_TYPE);
+	writew(PCI_STATUS_CAP_LIST, base + PCI_STATUS);
+	pos = 0x40;
+	writew(pos, base + PCI_CAPABILITY_LIST);
+
+	/* PCI-E Capability */
+	cap_base = base + pos;
+	writeb(PCI_CAP_ID_EXP, cap_base);
+	writew(PCI_EXP_TYPE_ENDPOINT, cap_base + PCI_EXP_FLAGS);
+	writew(PCI_EXP_LNKSTA_CLS_2_5GB | PCI_EXP_LNKSTA_NLW_X1, cap_base + PCI_EXP_LNKSTA);
+	writel(PCI_EXP_DEVCAP_FLR | PCI_EXP_DEVCAP_TEE, cap_base + PCI_EXP_DEVCAP);
+
+	/* DOE Extended Capability */
+	pos = PCI_CFG_SPACE_SIZE;
+	next = pos + PCI_DOE_CAP_SIZEOF;
+	cap_base = base + pos;
+	devsec_dev->doe.cap = pos;
+	writel(build_ext_cap_header(PCI_EXT_CAP_ID_DOE, 2, next), cap_base);
+
+	/* IDE Extended Capability */
+	pos = next;
+	cap_base = base + pos;
+	writel(build_ext_cap_header(PCI_EXT_CAP_ID_IDE, 1, 0), cap_base);
+	devsec_dev->ide_pos = pos + 4;
+	init_ide(&devsec_dev->ide);
+}
+
+#define MMIO_SIZE SZ_2M
+#define PREFETCH_SIZE SZ_2M
+
+static void destroy_devsec_dev(void *devsec_dev)
+{
+	kfree(devsec_dev);
+}
+
+static struct devsec_dev *devsec_dev_alloc(struct devsec *devsec, int hb)
+{
+	struct devsec_dev *devsec_dev __free(kfree) =
+		kzalloc(sizeof(*devsec_dev), GFP_KERNEL);
+	u64 start = devsec->prefetch_res.start + hb * PREFETCH_SIZE;
+
+	if (!devsec_dev)
+		return ERR_PTR(-ENOMEM);
+
+	*devsec_dev = (struct devsec_dev) {
+		.mmio_range = {
+			.start = start,
+			.end = start + PREFETCH_SIZE - 1,
+		},
+		.devsec = devsec,
+	};
+	init_dev_cfg(devsec_dev);
+
+	return_ptr(devsec_dev);
+}
+
+static int alloc_dev(struct devsec *devsec, int hb)
+{
+	struct devsec_dev *devsec_dev = devsec_dev_alloc(devsec, hb);
+	int rc;
+
+	if (IS_ERR(devsec_dev))
+		return PTR_ERR(devsec_dev);
+	rc = devm_add_action_or_reset(devsec->dev, destroy_devsec_dev,
+				      devsec_dev);
+	if (rc)
+		return rc;
+	devsec->devsec_devs[hb] = devsec_dev;
+
+	return 0;
+}
+
+static pci_bridge_emul_read_status_t
+devsec_bridge_read_base(struct pci_bridge_emul *bridge, int pos, u32 *val)
+{
+	return PCI_BRIDGE_EMUL_NOT_HANDLED;
+}
+
+static pci_bridge_emul_read_status_t
+devsec_bridge_read_pcie(struct pci_bridge_emul *bridge, int pos, u32 *val)
+{
+	return PCI_BRIDGE_EMUL_NOT_HANDLED;
+}
+
+static pci_bridge_emul_read_status_t
+devsec_bridge_read_ext(struct pci_bridge_emul *bridge, int pos, u32 *val)
+{
+	struct devsec_port *devsec_port = bridge->data;
+
+	/* only one extended capability, IDE... */
+	if (pos == 0) {
+		*val = build_ext_cap_header(PCI_EXT_CAP_ID_IDE, 1, 0);
+		return PCI_BRIDGE_EMUL_HANDLED;
+	}
+
+	if (pos < 4)
+		return PCI_BRIDGE_EMUL_NOT_HANDLED;
+
+	pos -= 4;
+	if (pos < sizeof(struct devsec_ide)) {
+		*val = *(u32 *)(&devsec_port->ide_regs[pos]);
+		return PCI_BRIDGE_EMUL_HANDLED;
+	}
+
+	return PCI_BRIDGE_EMUL_NOT_HANDLED;
+}
+
+static void devsec_bridge_write_base(struct pci_bridge_emul *bridge, int pos,
+				     u32 old, u32 new, u32 mask)
+{
+}
+
+static void devsec_bridge_write_pcie(struct pci_bridge_emul *bridge, int pos,
+				     u32 old, u32 new, u32 mask)
+{
+}
+
+static void devsec_bridge_write_ext(struct pci_bridge_emul *bridge, int pos,
+				    u32 old, u32 new, u32 mask)
+{
+	struct devsec_port *devsec_port = bridge->data;
+
+	if (pos < sizeof(struct devsec_ide))
+		*(u32 *)(&devsec_port->ide_regs[pos]) = new;
+}
+
+static const struct pci_bridge_emul_ops devsec_bridge_ops = {
+	.read_base = devsec_bridge_read_base,
+	.write_base = devsec_bridge_write_base,
+	.read_pcie = devsec_bridge_read_pcie,
+	.write_pcie = devsec_bridge_write_pcie,
+	.read_ext = devsec_bridge_read_ext,
+	.write_ext = devsec_bridge_write_ext,
+};
+
+static int init_port(struct devsec *devsec, struct devsec_port *devsec_port,
+		     int hb)
+{
+	const struct resource *mres = &devsec->mmio_res;
+	const struct resource *pres = &devsec->prefetch_res;
+	struct pci_bridge_emul *bridge = &devsec_port->bridge;
+	u16 membase = cpu_to_le16(upper_16_bits(mres->start + MMIO_SIZE * hb) &
+				  0xfff0);
+	u16 memlimit =
+		cpu_to_le16(upper_16_bits(mres->end + MMIO_SIZE * hb) & 0xfff0);
+	u16 pref_mem_base =
+		cpu_to_le16((upper_16_bits(lower_32_bits(pres->start +
+							 PREFETCH_SIZE * hb)) &
+			     0xfff0) |
+			    PCI_PREF_RANGE_TYPE_64);
+	u16 pref_mem_limit = cpu_to_le16(
+		(upper_16_bits(lower_32_bits(pres->end + PREFETCH_SIZE * hb)) &
+		 0xfff0) |
+		PCI_PREF_RANGE_TYPE_64);
+	u32 prefbaseupper =
+		cpu_to_le32(upper_32_bits(pres->start + PREFETCH_SIZE * hb));
+	u32 preflimitupper =
+		cpu_to_le32(upper_32_bits(pres->end + PREFETCH_SIZE * hb));
+
+	*bridge = (struct pci_bridge_emul) {
+		.conf = {
+			.vendor = cpu_to_le16(0x8086),
+			.device = cpu_to_le16(0xffff),
+			.class_revision = cpu_to_le32(0x1),
+			.primary_bus = 0,
+			.secondary_bus = hb + 1,
+			.subordinate_bus = hb + 1,
+			.membase = membase,
+			.memlimit = memlimit,
+			.pref_mem_base = pref_mem_base,
+			.pref_mem_limit = pref_mem_limit,
+			.prefbaseupper = prefbaseupper,
+			.preflimitupper = preflimitupper,
+		},
+		.pcie_conf = {
+			.devcap = cpu_to_le16(PCI_EXP_DEVCAP_FLR),
+			.lnksta = cpu_to_le16(PCI_EXP_LNKSTA_CLS_2_5GB),
+		},
+		.subsystem_vendor_id = cpu_to_le16(0x8086),
+		.has_pcie = true,
+		.data = devsec_port,
+		.ops = &devsec_bridge_ops,
+	};
+
+	init_ide(&devsec_port->ide);
+
+	return pci_bridge_emul_init(bridge, PCI_BRIDGE_EMUL_NO_IO_FORWARD);
+}
+
+static void destroy_port(void *data)
+{
+	struct devsec_port *devsec_port = data;
+
+	pci_bridge_emul_cleanup(&devsec_port->bridge);
+	kfree(devsec_port);
+}
+
+static struct devsec_port *devsec_port_alloc(struct devsec *devsec, int hb)
+{
+	int rc;
+
+	struct devsec_port *devsec_port __free(kfree) =
+		kzalloc(sizeof(*devsec_port), GFP_KERNEL);
+
+	if (!devsec_port)
+		return ERR_PTR(-ENOMEM);
+
+	rc = init_port(devsec, devsec_port, hb);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return_ptr(devsec_port);
+}
+
+static int alloc_port(struct devsec *devsec, int hb)
+{
+	struct devsec_port *devsec_port = devsec_port_alloc(devsec, hb);
+	int rc;
+
+	if (IS_ERR(devsec_port))
+		return PTR_ERR(devsec_port);
+	rc = devm_add_action_or_reset(devsec->dev, destroy_port, devsec_port);
+	if (rc)
+		return rc;
+	devsec->devsec_ports[hb] = devsec_port;
+
+	return 0;
+}
+
+static void release_mmio_region(void *res)
+{
+	remove_resource(res);
+}
+
+static void release_prefetch_region(void *res)
+{
+	remove_resource(res);
+}
+
+static int __init devsec_bus_probe(struct faux_device *fdev)
+{
+	int rc;
+	struct pci_bus *bus;
+	struct devsec *devsec;
+	struct devsec_sysdata *sd;
+	struct pci_host_bridge *hb;
+	struct device *dev = &fdev->dev;
+
+	hb = devm_pci_alloc_host_bridge(
+		dev, sizeof(*devsec) - sizeof(struct pci_host_bridge));
+	if (!hb)
+		return -ENOMEM;
+
+	devsec = container_of(hb, struct devsec, hb);
+	devsec->dev = dev;
+
+	devsec->mmio_res.name = "DEVSEC MMIO";
+	devsec->mmio_res.flags = IORESOURCE_MEM;
+	rc = allocate_resource(&iomem_resource, &devsec->mmio_res,
+			       MMIO_SIZE * NR_DEVSEC_BUSES, 0, SZ_4G, MMIO_SIZE,
+			       NULL, NULL);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(dev, release_mmio_region,
+				      &devsec->mmio_res);
+	if (rc)
+		return rc;
+
+	devsec->prefetch_res.name = "DEVSEC PREFETCH";
+	devsec->prefetch_res.flags = IORESOURCE_MEM | IORESOURCE_MEM_64 |
+				     IORESOURCE_PREFETCH;
+	rc = allocate_resource(&iomem_resource, &devsec->prefetch_res,
+			       PREFETCH_SIZE * NR_DEVSEC_BUSES, SZ_4G, U64_MAX,
+			       PREFETCH_SIZE, NULL, NULL);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(dev, release_prefetch_region,
+				      &devsec->prefetch_res);
+	if (rc)
+		return rc;
+
+	for (int i = 0; i < NR_DEVSEC_BUSES; i++) {
+		rc = alloc_port(devsec, i);
+		if (rc)
+			return rc;
+
+		rc = alloc_dev(devsec, i);
+		if (rc)
+			return rc;
+	}
+
+	devsec->busnr_res = (struct resource) {
+		.name = "DEVSEC BUSES",
+		.start = 0,
+		.end = NR_DEVSEC_BUSES + 1 - 1, /* 1 RP per HB */
+		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+	};
+	pci_add_resource(&hb->windows, &devsec->busnr_res);
+	pci_add_resource(&hb->windows, &devsec->mmio_res);
+	pci_add_resource(&hb->windows, &devsec->prefetch_res);
+
+	sd = &devsec->sysdata;
+	devsec_sysdata = sd;
+
+	/* Start devsec_bus emulation above the last ACPI segment */
+	hb->domain_nr = pci_bus_find_emul_domain_nr(0, 0x10000, INT_MAX);
+	if (hb->domain_nr < 0)
+		return hb->domain_nr;
+
+	/*
+	 * Note, domain_nr is set in devsec_sysdata for
+	 * !CONFIG_PCI_DOMAINS_GENERIC platforms
+	 */
+	devsec_set_domain_nr(sd, hb->domain_nr);
+
+	hb->dev.parent = dev;
+	hb->sysdata = sd;
+	hb->ops = &devsec_ops;
+
+	rc = pci_scan_root_bus_bridge(hb);
+	if (rc)
+		return rc;
+
+	bus = hb->bus;
+	rc = devm_add_action_or_reset(dev, destroy_bus, no_free_ptr(hb));
+	if (rc)
+		return rc;
+
+	pci_assign_unassigned_bus_resources(bus);
+	pci_bus_add_devices(bus);
+
+	return 0;
+}
+
+static struct faux_device *devsec_bus;
+
+static struct faux_device_ops devsec_bus_ops = {
+	.probe = devsec_bus_probe,
+};
+
+static int __init devsec_bus_init(void)
+{
+	devsec_bus = faux_device_create("devsec_bus", NULL, &devsec_bus_ops);
+	if (!devsec_bus)
+		return -ENODEV;
+	return 0;
+}
+module_init(devsec_bus_init);
+
+static void __exit devsec_bus_exit(void)
+{
+	faux_device_destroy(devsec_bus);
+}
+module_exit(devsec_bus_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Device Security Sample Infrastructure: TDISP Device Emulation");
diff --git a/samples/devsec/common.c b/samples/devsec/common.c
new file mode 100644
index 000000000000..de0078e4d614
--- /dev/null
+++ b/samples/devsec/common.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2024 - 2025 Intel Corporation. All rights reserved.
+
+#include <linux/pci.h>
+#include <linux/export.h>
+
+/*
+ * devsec_bus and devsec_tsm need a common location for this data to
+ * avoid depending on each other. Enables load order testing
+ */
+struct pci_sysdata *devsec_sysdata;
+EXPORT_SYMBOL_GPL(devsec_sysdata);
+
+static int __init common_init(void)
+{
+	return 0;
+}
+module_init(common_init);
+
+static void __exit common_exit(void)
+{
+}
+module_exit(common_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Device Security Sample Infrastructure: Shared data");
diff --git a/samples/devsec/devsec.h b/samples/devsec/devsec.h
new file mode 100644
index 000000000000..ae4274c86244
--- /dev/null
+++ b/samples/devsec/devsec.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+// Copyright(c) 2024 - 2025 Intel Corporation. All rights reserved.
+
+#ifndef __DEVSEC_H__
+#define __DEVSEC_H__
+struct devsec_sysdata {
+#ifdef CONFIG_X86
+	/*
+	 * Must be first member to that x86::pci_domain_nr() can type
+	 * pun devsec_sysdata and pci_sysdata.
+	 */
+	struct pci_sysdata sd;
+#else
+	int domain_nr;
+#endif
+};
+
+#ifdef CONFIG_X86
+static inline void devsec_set_domain_nr(struct devsec_sysdata *sd,
+					int domain_nr)
+{
+	sd->sd.domain = domain_nr;
+}
+static inline int devsec_get_domain_nr(struct devsec_sysdata *sd)
+{
+	return sd->sd.domain;
+}
+#else
+static inline void devsec_set_domain_nr(struct devsec_sysdata *sd,
+					int domain_nr)
+{
+	sd->domain_nr = domain_nr;
+}
+static inline int devsec_get_domain_nr(struct devsec_sysdata *sd)
+{
+	return sd->domain_nr;
+}
+#endif
+extern struct devsec_sysdata *devsec_sysdata;
+#endif /* __DEVSEC_H__ */
diff --git a/samples/devsec/link_tsm.c b/samples/devsec/link_tsm.c
new file mode 100644
index 000000000000..46c9343815e3
--- /dev/null
+++ b/samples/devsec/link_tsm.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 - 2025 Intel Corporation. All rights reserved. */
+
+#define dev_fmt(fmt) "devsec: " fmt
+#include <linux/device/faux.h>
+#include <linux/pci-tsm.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/tsm.h>
+#include "devsec.h"
+
+struct devsec_tsm_pf0 {
+	struct pci_tsm_pf0 pci;
+#define NR_TSM_STREAMS 4
+};
+
+struct devsec_tsm_fn {
+	struct pci_tsm pci;
+};
+
+static struct devsec_tsm_pf0 *to_devsec_tsm_pf0(struct pci_tsm *tsm)
+{
+	return container_of(tsm, struct devsec_tsm_pf0, pci.base);
+}
+
+static struct devsec_tsm_fn *to_devsec_tsm_fn(struct pci_tsm *tsm)
+{
+	return container_of(tsm, struct devsec_tsm_fn, pci);
+}
+
+static const struct pci_tsm_ops *__devsec_pci_ops;
+
+static struct pci_tsm *devsec_tsm_pf0_probe(struct pci_dev *pdev)
+{
+	int rc;
+
+	struct devsec_tsm_pf0 *devsec_tsm __free(kfree) =
+		kzalloc(sizeof(*devsec_tsm), GFP_KERNEL);
+	if (!devsec_tsm)
+		return NULL;
+
+	rc = pci_tsm_pf0_constructor(pdev, &devsec_tsm->pci, __devsec_pci_ops);
+	if (rc)
+		return NULL;
+
+	pci_dbg(pdev, "TSM enabled\n");
+	return &no_free_ptr(devsec_tsm)->pci.base;
+}
+
+static struct pci_tsm *devsec_link_tsm_fn_probe(struct pci_dev *pdev)
+{
+	int rc;
+
+	struct devsec_tsm_fn *devsec_tsm __free(kfree) =
+		kzalloc(sizeof(*devsec_tsm), GFP_KERNEL);
+	if (!devsec_tsm)
+		return NULL;
+
+	rc = pci_tsm_link_constructor(pdev, &devsec_tsm->pci, __devsec_pci_ops);
+	if (rc)
+		return NULL;
+
+	pci_dbg(pdev, "TSM (sub-function) enabled\n");
+	return &no_free_ptr(devsec_tsm)->pci;
+}
+
+static struct pci_tsm *devsec_link_tsm_pci_probe(struct pci_dev *pdev)
+{
+	if (pdev->sysdata != devsec_sysdata)
+		return NULL;
+
+	if (is_pci_tsm_pf0(pdev))
+		return devsec_tsm_pf0_probe(pdev);
+	return devsec_link_tsm_fn_probe(pdev);
+}
+
+static void devsec_link_tsm_pci_remove(struct pci_tsm *tsm)
+{
+	struct pci_dev *pdev = tsm->pdev;
+
+	pci_dbg(pdev, "TSM disabled\n");
+
+	if (is_pci_tsm_pf0(pdev)) {
+		struct devsec_tsm_pf0 *devsec_tsm = to_devsec_tsm_pf0(tsm);
+
+		pci_tsm_pf0_destructor(&devsec_tsm->pci);
+		kfree(devsec_tsm);
+	} else {
+		struct devsec_tsm_fn *devsec_tsm = to_devsec_tsm_fn(tsm);
+
+		kfree(devsec_tsm);
+	}
+}
+
+/*
+ * Reference consumer for a TSM driver "connect" operation callback. The
+ * low-level TSM driver understands details about the platform the PCI
+ * core does not, like number of available streams that can be
+ * established per host bridge. The expected flow is:
+ *
+ * 1/ Allocate platform specific Stream resource (TSM specific)
+ * 2/ Allocate Stream Ids in the endpoint and Root Port (PCI TSM helper)
+ * 3/ Register Stream Ids for the consumed resources from the last 2
+ *    steps to be accountable (via sysfs) to the admin (PCI TSM helper)
+ * 4/ Register the Stream with the TSM core so that either PCI sysfs or
+ *    TSM core sysfs can list the in-use resources (TSM core helper)
+ * 5/ Configure IDE settings in the endpoint and Root Port (PCI TSM helper)
+ * 6/ RPC call to TSM to perform IDE_KM and optionally enable the stream
+ * (TSM Specific)
+ * 7/ Enable the stream in the endpoint, and root port if TSM call did
+ *    not already handle that (PCI TSM helper)
+ *
+ * The expectation is the helpers referenceed are convenience "library"
+ * APIs for common operations, not a "midlayer" that enforces a specific
+ * or use model sequencing.
+ */
+static int devsec_link_tsm_connect(struct pci_dev *pdev)
+{
+	return -ENXIO;
+}
+
+static void devsec_link_tsm_disconnect(struct pci_dev *pdev)
+{
+}
+
+static struct pci_tsm_ops devsec_link_pci_ops = {
+	.probe = devsec_link_tsm_pci_probe,
+	.remove = devsec_link_tsm_pci_remove,
+	.connect = devsec_link_tsm_connect,
+	.disconnect = devsec_link_tsm_disconnect,
+};
+
+static void devsec_link_tsm_remove(void *tsm_dev)
+{
+	tsm_unregister(tsm_dev);
+}
+
+static int devsec_link_tsm_probe(struct faux_device *fdev)
+{
+	struct tsm_dev *tsm_dev;
+
+	tsm_dev = tsm_register(&fdev->dev, &devsec_link_pci_ops);
+	if (IS_ERR(tsm_dev))
+		return PTR_ERR(tsm_dev);
+
+	return devm_add_action_or_reset(&fdev->dev, devsec_link_tsm_remove,
+					tsm_dev);
+}
+
+static struct faux_device *devsec_link_tsm;
+
+static const struct faux_device_ops devsec_link_device_ops = {
+	.probe = devsec_link_tsm_probe,
+};
+
+static int __init devsec_link_tsm_init(void)
+{
+	__devsec_pci_ops = &devsec_link_pci_ops;
+	devsec_link_tsm = faux_device_create("devsec_link_tsm", NULL,
+					     &devsec_link_device_ops);
+	if (!devsec_link_tsm)
+		return -ENOMEM;
+	return 0;
+}
+module_init(devsec_link_tsm_init);
+
+static void __exit devsec_link_tsm_exit(void)
+{
+	faux_device_destroy(devsec_link_tsm);
+}
+module_exit(devsec_link_tsm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Device Security Sample Infrastructure: Platform Link-TSM Driver");
-- 
2.50.1


