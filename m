Return-Path: <linux-pci+bounces-34862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA26B378E6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C0F1B67F21
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF89330DEBC;
	Wed, 27 Aug 2025 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="begxiv0F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA930DD3A
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266793; cv=fail; b=GFlTDAsQyijxeZItUUq5kwpqSAvMW0kTmo+5ROul4KBDhb3YjtveVJdR/KEI1oBnJYEu/i5IeNc+1NI5l3FhpPH45kps5SsrXFWHsBkqfRWlFf/r4guif37+tJIC2T6q36U8/LYrwoQr3SNmmzuIYOcNQuIqpYOiqJvVeCU7+JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266793; c=relaxed/simple;
	bh=dlTcrj/ycXfmv5YrkGpuuPZMTRtkVZKKQXvKdRb9XmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRjBr7vXA35tKUY+bwxBNKxJ0XOqgZR4ptkxGoCRXN8Lnrat7Q8C6RbwdDzWE/4MYsi2p/c/q+wr4a6uHUcFROQKGpHdJNigm4vBmYFXFyXzUjjcbKy5Qde9R2JyL8qETVRYmi6QFTn9b9K5e1JlSsug3zV9zk67Wjlb/OtUGTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=begxiv0F; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266792; x=1787802792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dlTcrj/ycXfmv5YrkGpuuPZMTRtkVZKKQXvKdRb9XmY=;
  b=begxiv0FQ304o/UN+Tjip3m0A7k3PXjCmZFnYsXZtcdsMUHiY1/hYt7a
   x9e3VZ1bywl3A8LLS9F2xf2UbxSWZ8McAqpjJOYV736K7o4AnpzGVfgY1
   TbWfA3rc+cID1A0CMlxupl00SC8+RC+rGyD8UCKqEFnTD32TpruERwlcQ
   2NRj6s6gsUjSS13vbgkHPOIgcKYojFKHvzyazAM5fSkmkJ1y3otC/8Cpb
   vLb1bYcQ6Tri/pFPJPO256oVhERj/IciDIKqqbHBE03SA9oJIZ3uw75Rr
   PzoweBQxvUosVD7fY60WiWzMM/cxiutPAtXcuyyKtRfQdzkzOy5fjpL/L
   g==;
X-CSE-ConnectionGUID: /LD4Qd26Qvi3/ZT2My+zrw==
X-CSE-MsgGUID: l/SF8a6ASXWJgAz/nsXwxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159275"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159275"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:11 -0700
X-CSE-ConnectionGUID: Tj83YaWRSAmiApM3GDOy5Q==
X-CSE-MsgGUID: TWAeZte1SNqJg8qnmCFP8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685408"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:53:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.75)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFVDFcLFcEeNG39jAS8fo2hX1hQEzN+RG0VFKcuoHczFQtwy46Er9NQYCHPnG9mlnXrbIb6S/k0NGJ0EEgjQW7SytxoJZ5ODxMRojJlEkfrnFENtH8F7rpaOSZw4fYUtDhM0psVeLDITs18LkWbo/aKsXmxTtzLkmiCm0uEuea8ttxq7wGYpq37aUsks1LTX5ZbDogYVkHuzsTEzYJVjQ2/xcklEbBmI9imufmqf8IV6LxeokMjxQppv3ijw7/4SMN4xVZcuuV/nyoYHvVGsbdC3K4ZfXMAUdWnw0CVghrrGBhbH1oZQnDESgD1b96mFsxd5ewZG6uGvqm/wUeFcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VN048Qv/T23XLnLNgsEp2Kaoqxj+d8Pi4K8j6LZquU=;
 b=DMwVgF/ANZOHMyMAOUex25EXrU8YUgQnVL7Kj8sB3TD2XgIe6DWyANavmAbtz+4oP6F0cFIK2eI+I45Gx6hk9U4qnwzmy8G9umLK8Rzdb9LhQoDuhIB/WDm8UHeu0iCU6hLFdh4aRMD6MtrTh9AUX9ITTJcf7JyuQ5ViAZrNSQX9a8EcTCc/QXpySQllbOaGKyJl4IG4HTGPosAGJnljbgLnX62hVaDewixc/Bq6tcZS5kckR4T8TdQLfA/rWhRQI22uVg+WQKSUxAG4gI5sfHyHNe4N9kQDAv4zI7GLtLG9nfSLSiJ4uHtGfv+jnaFvQGshcTHhzIS5zI9QpCFkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 03:53:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:53:07 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>
Subject: [PATCH 6/7] samples/devsec: Introduce a "Device Security TSM" sample driver
Date: Tue, 26 Aug 2025 20:52:58 -0700
Message-ID: <20250827035259.1356758-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035259.1356758-1-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb2b265-25dd-450d-1012-08dde51d3b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e8xE12om1U0SJhS1aQdRwTICvhhYRVO3L1SqhWVtDxhHZoVCptKvt9fHweXI?=
 =?us-ascii?Q?W2eT38RycaVmGPRzPD5/rBnEPZa3vffl2v+A881nwNf17ZZ7OHVDnHXuk875?=
 =?us-ascii?Q?1qxGb62qIP8CIa/wdFy/J2BQNZVUU9Toh/bNre8HgsHBRAhxXDxbIkCdxzN7?=
 =?us-ascii?Q?JVXLYBVwugiq1hiKHkzrbbEG5zCq8ZLRMkuR83+EakCmd95Vqc1Lg1+qB1Sl?=
 =?us-ascii?Q?g1N2T1PxdbwSr47OQXan5dG5QlJVKCr3dsySOoM76wmHPkxWWOiulSkX/EQH?=
 =?us-ascii?Q?VwAAOVOB8lXmA8iAoNXRAwyzeh1+P/HUt+9+BnMyO9uQLiC3hKSR49PzHHhf?=
 =?us-ascii?Q?vecW7Oymcp6PgWpvoZBrPqp4+CbeC2R23h2jAwDG+8HLwIovcgr93Ptzigwf?=
 =?us-ascii?Q?NK1e68KqQv8H/WaWGB91+rbWNyx9AQaJqWc1S4PuKNljY0i1DDygZHyPj1nu?=
 =?us-ascii?Q?p4W6rOxZgP7DT0IuuqTzCrwC1SOaI85pbmpaUcx1Jt6dbRINhgp1XzyT4PUo?=
 =?us-ascii?Q?FrRkNPnCQ5GPdE7HOaUdjEWexwfOxK8IJNkMb3BH/hJendSZm3AI7NcQBqOo?=
 =?us-ascii?Q?cxybdAh8maXp7a5wfeWIeR1VoEjQrZ/eUPY/3hUrdgnNvHdUv3avTSYHbpwO?=
 =?us-ascii?Q?FChgK6v2HG5k/PyjlxFI9FAqeUHqtgjM9z9/wisZFcH0ODYq5plA6R+2iBrT?=
 =?us-ascii?Q?G/IPlBv0D2evOOkySpIIL3iTzsLu0Ni86PztnW11ML2iPvIuLVpkOfXlQ37d?=
 =?us-ascii?Q?z/YlwYpUfQxbmq+566pwCGNqCUzPzIp1zuzjgWHfLgnqJa2A7TaNtcNA+R1B?=
 =?us-ascii?Q?hkHUcFQgT9YBNQq7yP6lE+sYZo8QaVWp4wAn3jsXZ+eu4ZOdYi81En8oEMQ3?=
 =?us-ascii?Q?K1k5ZmcCycb571OOuDFyuOSwntl1U0T9vinPhCm79Yuv0O2CYNqSptfGcs8Y?=
 =?us-ascii?Q?VYoyBoX6LRQKPSsHstXNkVtck51mM8yiLePJL9aMWMHATtphwrfy6d4SotAS?=
 =?us-ascii?Q?BouywvIMD/eMNCM6Sc+72V5RwgrDLO0mP7SdDsNg24WTKzhAg8A6PdRTXICq?=
 =?us-ascii?Q?Uxz4SZySfSo4FHtKOOja3FnliFxsHSVSlz27oYwht9Qo6iVbADEn/m09dgVe?=
 =?us-ascii?Q?vyxcj2zTGrpmuUDfDIGfKiy85cqvZD/fAr++H2/D3PbYA504Ik3wczdBAnwI?=
 =?us-ascii?Q?sycBOtidbj+dUENwYCADDYE06UqI4FB9M8J+RKQkJGSukRHASslFjDqzyOoJ?=
 =?us-ascii?Q?gpSP3D2UH1TA3iHcxJqqIOc5r2+WLXQZq+0vlDufmp6d8nEHrlV6S0MCHm4r?=
 =?us-ascii?Q?Oy8EdW2g7P1ZyrSKdTZixb+mX0X2gycwp2rF7+abrIw4AX5FMbMILabnuQid?=
 =?us-ascii?Q?ydUUJRM3CWwXXSNHG3a/IwNpTWB766/qtIPR/EshnrmJcZWgPMFwaRdV8Wpw?=
 =?us-ascii?Q?J4FR0OxniEY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bwUx3lSagTziy8uG8WzmwN7hC9le5pKm3aUfTCr8NdwZg2ytHh+FIFdJtopO?=
 =?us-ascii?Q?uzvisTssyMneWgZPbMvIMu07Cgb7eRTvm0Qw3YmEL5/3G3aVCbhekeNsR8js?=
 =?us-ascii?Q?c0zR97AtYPv6/10dEdnB3k2U82/I/dt680cdTNFKorN8Lidp/5Y6SrtgJ/pm?=
 =?us-ascii?Q?xRzwfpJrCpmEs62QeTltV4qdpzVGOOn+gmhwhLEsI8W4ahpLBgM5Whkb3zyY?=
 =?us-ascii?Q?OVr7KwjIoMWx8ff0o8RKttupTbXYU8/OL6kQvF3EYDv+P7zIztRZTZA20mWu?=
 =?us-ascii?Q?+6hwlyJ9w/vLYAN5+wldWKlBZlfLh7fNMx/rS9wGWI8/XwfESUKYxTBBYel7?=
 =?us-ascii?Q?5Cq5M1nhcaOa9Xl5qR0r9pTz3WPTdSfH6JdEai7UTkO3feWwF5Dm/HOaaZsV?=
 =?us-ascii?Q?JW15iBUtgdn0FZwTAz8e6FlCDyh1PYH9l4mYGwdtIDeNsZGVtVlHOQ+kEW/l?=
 =?us-ascii?Q?LCcOjInIPOw0yXl6oeO2jG7x++LP/xAVzJVvIi4KlNfG2gvhrjkiMUdcn70f?=
 =?us-ascii?Q?NITZkz/jKlyT4DbCIxkQAiUviIN7N1MvZXZzh90HNBy6tnH0lGyRd7vV9iBu?=
 =?us-ascii?Q?fRNugJPoKdVCkx5EJvv3TwoqEEbGEyEst12bh+wqzQrsi6lahC+LrETSfp5f?=
 =?us-ascii?Q?BWBPhafUFSHfnKUulNDTMWlSBHI0g9GAgZq7X/6k6ASnDLSj677ymdJcaQk/?=
 =?us-ascii?Q?gidEicKVAOivq4y/hKLGusZL7Y9PNlZRF3qNz6YQn0FTmh9Z9VkArzBjBrr9?=
 =?us-ascii?Q?N1WE3O2y9urke8Pbt3CQR7TkAZJllxrrTdaHjmW1Daix/VXEf5sggbWBEspo?=
 =?us-ascii?Q?DjDb41AVMPCA6hv93laXH8BcjPt08iQa+xaNqlN9OazmTBEYcU1P66mFvIZb?=
 =?us-ascii?Q?u5/2T6j1zLJRquvy40Gg2uL6gAbygMeUPfEiPoBsewUJrkB3oGHMZ5DaGX64?=
 =?us-ascii?Q?VeaLnarrmdunM4DyuzYo6OUUq5vy1AB09znj9V6yJ5foFVPkGHw4NCdRMeZ7?=
 =?us-ascii?Q?dsW2vqLJPnmZFi8FpLfg+cAfQflJS6ZAmhjfq+ZbXZrYRfGX5cW2oyDz1qwr?=
 =?us-ascii?Q?vynOOtz2laJAkXLOdxVCZXcbxkRbauRmK9dfe/rgJzRG5PlbEdlPASkDyctl?=
 =?us-ascii?Q?RQv105f4HhvEW2Sg1UzK7jgcJBYnbvQavzHsbnsRTYqeQFnLunX0VM7TzXKv?=
 =?us-ascii?Q?Ew76T2zLRvYN1pwjNB4ANe59gxjVL6LEIehx41edef8lpxDPQg+v/6duTN9F?=
 =?us-ascii?Q?//xwDMdbG/OQrH/B+bWcNr2Nbtrt2pHunfynCBNLFFNo5cVi1hyh2XHL2ywq?=
 =?us-ascii?Q?yIX6u75yTeHrH2/YygSSDoC+3yRK6nYAF6Hb3tRph2M+86OrCMR8EwozAUes?=
 =?us-ascii?Q?MsxrXEMKkfLEI845JASAY4Ue6/fLWZb3stpgU9m/csd1qS4AnXmAiT9cRfqV?=
 =?us-ascii?Q?xwUl7yPJ/hk60Cq9wehh/OYGCry9MMAcLpMwo8Ryau5aXWc++n2DRW5qpZBO?=
 =?us-ascii?Q?VE8bXEC8UX1Um0gr3Ks+e48dAOBVxZwQ9XwkYyAWmuwt9kfCchMl9FJlANvY?=
 =?us-ascii?Q?TZJbHp8qMthkA0nCX8/64Bsjyv0YNZm+PZ+4ME4fO8fBPTJpWE/RhqT9XzTm?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb2b265-25dd-450d-1012-08dde51d3b6c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:53:07.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxghAEMXKKkyVS1P0SFl70q6TqFNBLptPCpSZUXtY4MiK4V+dO1ytg54bZBX2FZGvZPygXoSRjrl5RO91eTN5kyAXXwR9aJnUqDpRME48YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
X-OriginatorOrg: intel.com

There are 2 sides to a TEE Security Manager (TSM), the 'link' TSM, and the
'devsec' TSM. The 'link' TSM, outside the TEE, establishes physical link
confidentiality and integerity, and a secure session for transporting
commands the manage the security state of devices. The 'devsec' TSM, within
the TEE, issues requests for confidential devices to lock their
configuration and transition to secure operation.

Implement a sample implementation of a 'devsec' TSM. This leverages the PCI
core's ability to register multiple TSMs at a time to load a sample
devsec_tsm module alongside the existing devsec_link_tsm module. When both
are loaded the TSM personality is selected by choosing to 'connect' vs
'lock' the device.

Drivers like tdx_guest, sev_guest, or arm-cca-guest are examples of "Device
Security TSM" drivers.

A devsec_pci driver is included to test the device_cc_probe() helper for
drivers that need to coordinate some configuration before 'lock' and
'accept'.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 samples/devsec/Makefile |  6 +++
 samples/devsec/pci.c    | 43 ++++++++++++++++++
 samples/devsec/tsm.c    | 99 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 samples/devsec/pci.c
 create mode 100644 samples/devsec/tsm.c

diff --git a/samples/devsec/Makefile b/samples/devsec/Makefile
index da122eb8d23d..0c52448a629f 100644
--- a/samples/devsec/Makefile
+++ b/samples/devsec/Makefile
@@ -8,3 +8,9 @@ devsec_bus-y := bus.o
 
 obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_link_tsm.o
 devsec_link_tsm-y := link_tsm.o
+
+obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_tsm.o
+devsec_tsm-y := tsm.o
+
+obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_pci.o
+devsec_pci-y := pci.o
diff --git a/samples/devsec/pci.c b/samples/devsec/pci.c
new file mode 100644
index 000000000000..4661529fe10c
--- /dev/null
+++ b/samples/devsec/pci.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 - 2025 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+static int devsec_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	void __iomem *base;
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return dev_err_probe(&pdev->dev, rc, "enable failed\n");
+
+	base = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base),
+				     "iomap failed\n");
+
+	rc = device_cc_probe(&pdev->dev);
+	if (rc)
+		return rc;
+
+	dev_dbg(&pdev->dev, "attach\n");
+	return 0;
+}
+
+static const struct pci_device_id devsec_pci_ids[] = {
+	{ PCI_DEVICE(0x8086, 0xffff), .override_only = 1, },
+	{ }
+};
+
+static struct pci_driver devsec_pci_driver = {
+	.name = "devsec_pci",
+	.probe = devsec_pci_probe,
+	.id_table = devsec_pci_ids,
+};
+
+module_pci_driver(devsec_pci_driver);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Device Security Sample Infrastructure: Secure PCI Driver");
diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
new file mode 100644
index 000000000000..4de2d45db4c3
--- /dev/null
+++ b/samples/devsec/tsm.c
@@ -0,0 +1,99 @@
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
+struct devsec_dev_data {
+	struct pci_tsm_devsec pci;
+};
+
+static struct devsec_dev_data *to_devsec_data(struct pci_tsm *tsm)
+{
+	return container_of(tsm, struct devsec_dev_data, pci.base);
+}
+
+static const struct pci_tsm_ops *__devsec_pci_ops;
+
+static struct pci_tsm *devsec_tsm_lock(struct pci_dev *pdev)
+{
+	int rc;
+
+	struct devsec_dev_data *devsec_data __free(kfree) =
+		kzalloc(sizeof(*devsec_data), GFP_KERNEL);
+	if (!devsec_data)
+		return ERR_PTR(-ENOMEM);
+
+	rc = pci_tsm_devsec_constructor(pdev, &devsec_data->pci,
+					__devsec_pci_ops);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return &no_free_ptr(devsec_data)->pci.base;
+}
+
+static void devsec_tsm_unlock(struct pci_dev *pdev)
+{
+	struct devsec_dev_data *devsec_data = to_devsec_data(pdev->tsm);
+
+	kfree(devsec_data);
+}
+
+static int devsec_tsm_accept(struct pci_dev *pdev)
+{
+	/* LGTM */
+	return 0;
+}
+
+static struct pci_tsm_ops devsec_pci_ops = {
+	.lock = devsec_tsm_lock,
+	.unlock = devsec_tsm_unlock,
+	.accept = devsec_tsm_accept,
+};
+
+static void devsec_tsm_remove(void *tsm_dev)
+{
+	tsm_unregister(tsm_dev);
+}
+
+static int devsec_tsm_probe(struct faux_device *fdev)
+{
+	struct tsm_dev *tsm_dev;
+
+	tsm_dev = tsm_register(&fdev->dev, &devsec_pci_ops);
+	if (IS_ERR(tsm_dev))
+		return PTR_ERR(tsm_dev);
+
+	return devm_add_action_or_reset(&fdev->dev, devsec_tsm_remove,
+					tsm_dev);
+}
+
+static struct faux_device *devsec_tsm;
+
+static const struct faux_device_ops devsec_device_ops = {
+	.probe = devsec_tsm_probe,
+};
+
+static int __init devsec_tsm_init(void)
+{
+	__devsec_pci_ops = &devsec_pci_ops;
+	devsec_tsm = faux_device_create("devsec_tsm", NULL, &devsec_device_ops);
+	if (!devsec_tsm)
+		return -ENOMEM;
+	return 0;
+}
+module_init(devsec_tsm_init);
+
+static void __exit devsec_tsm_exit(void)
+{
+	faux_device_destroy(devsec_tsm);
+}
+module_exit(devsec_tsm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Device Security Sample Infrastructure: Device Security TSM Driver");
-- 
2.50.1


