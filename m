Return-Path: <linux-pci+bounces-27827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E824AAB959E
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760DB500C79
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E83022154D;
	Fri, 16 May 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkEZUK62"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937D221DAB
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374487; cv=fail; b=FryvA9NS/WZDQG1zsn3vEpmil5WCLUyCbPnTEGlVvmIYfLNIRYpOCeMwqJqUJv8vRszWCaBGyUYcMXVr5NIFBDEb/QT+vyL4HrToOka9+GE+mapY77wZkqrdGvwLO76Cl8lVS5J8tiNg2g4WF0fGKfqJ/iuegxMr+WY78Jaa0O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374487; c=relaxed/simple;
	bh=vg4YNKQPtWHxdfgfch1MS7fQQOJmINrqRSnt17G/h+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jcZvweWMENAKBLUX/Dsrsruw8RCg0iVtGJ+2fHvrsThcG7zK7+ktfabV9ut0uywK/hhenGUfzcr6dpMxkVTRV8bUYLHRl0xn3E1zlhwkxivorrbsn5s9syjic1/sZaRl29OJ8DpzIDahheQHFmlyKDNQk+C3QqsaoWg35QDK2ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkEZUK62; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374485; x=1778910485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vg4YNKQPtWHxdfgfch1MS7fQQOJmINrqRSnt17G/h+0=;
  b=MkEZUK62NBspdNZJYztsXYsx/w0DNbreUedoC35jhgKyco5WHa/juSBn
   YMjsP4PqXfGInnmCEEn6rAqkaee6b4oS1G0OLntdZ1l30n8SkdYO1IAH2
   Fkgi3YBOsrfEQoumnAOWKWsiRHPCpoc7xWEMB7d9/sd/0QbA245H7UQlf
   MzEO5JfN89Wtdc6LOEZCteUoi8bWD1NaVfIhGHyAJWfa/0GKgkRh8fAM7
   OU8cpknuG6llVZm96vdvgwiBkIcXec1Vn3RqknoL87BXEdnS+7Y+l/ZMV
   CjEao013iHPPO9eTf1qkibSjk/58agsFgCKq9Hft6CpSZAb5yoNfPJoeU
   g==;
X-CSE-ConnectionGUID: 27rCqo8WQ9uoXGAZwR2aMw==
X-CSE-MsgGUID: b0SnTVMmSh+ZDhyozVuRUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36952834"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36952834"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:48:02 -0700
X-CSE-ConnectionGUID: e8s49qlAROSctShTZcvDlg==
X-CSE-MsgGUID: 4PnacpxQTeiOk6tDzZfACA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139084722"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:47:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:47:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3rXOMIlqcUtYydzVtiD1Eg+lAK9Ek2op23NmOaOe9xAq73rKphM/NL+YCOY8hzgSsD6rTGEBw9Y2ayFA1D6/1UApSyWLTmrADsLPmI67Gm+tqx5IinTcf2ntzQtINP2e2bJap7slUlu3LxRDRJ7c3U+MHDtEubSEjalIc/bLpk+xNd1fV3D8BrL4SmWlr2TOT9mcDe6CDdi3IsnQiaQCmJLry0DrQ73uStlxJWwZdsm3v3I9V3lPvqNnYCfRZPjtltgUGgh3RpvfCjKn4z6sx/Hi4WCxT1QTQ3QiugEflWZijPMSGNV8mK1J7kWICwFmnvOIh7IXR4GIINp3gObVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYooa4P1GDSRPpgRwdxVyq/cwLt5qW0kQpV65S7nHuQ=;
 b=N75T/DJT5vUPfWftvXGJd0fXZFRxW82iJQixcPVsratvpdxIG+FNXY64F+lREESKPhtUeTqDnWJts+1aEekOF32VQPHAEd9SB32o+lblfuwFNpo9yZVR2pO+X8PF4eeIWr0pxmWzAOYMfIRyJF39IWxB4tXkSk10ZquRA47Gk2cGT4lMnwXVu4tDIJnYdQ3DggouybsnWRbT2EQKKtO7RbRM5Ff+Hoyx16yJqTab8z3gamvPzNWG7wVQquchhw10sf87gqXMR76PvlOQWYvkOwTCf9+IplJw3zVm3YlxzhGPTjQkJU1D5Mz3d7whj+HmypWD5FSYg6kChrnoLK3+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:47:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:41 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "Dexuan
 Cui" <decui@microsoft.com>
Subject: [PATCH v3 04/13] PCI: Enable host-bridge emulation for PCI_DOMAINS_GENERIC platforms
Date: Thu, 15 May 2025 22:47:23 -0700
Message-ID: <20250516054732.2055093-5-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: f695d57a-4b54-4351-a6af-08dd943d2bef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KwfquzcSu0pqvCD37PF+W2z41m+DjcgqRzjAoxn8jW7JWaj4u/9RHSsVz9wX?=
 =?us-ascii?Q?iJtuKRA5PodvEVfK9SXHRVhsjimE39ETdlJO2xU5qP6ZY76j9XX9pWoDrtIp?=
 =?us-ascii?Q?YG0UIrx/2xw951M4cBchLP3KL3mKo+2887brOzhl0NqTTzL7TmfqIUCxKtBG?=
 =?us-ascii?Q?PdHll0+siwP08R4j9rWDd4za/l+Y9ypBYYv7mmqvCcHGwD0sWlDb3U2mQ5EN?=
 =?us-ascii?Q?a+VZNQx4YxBSaaYr9mcxX2WX1pCv9quFdPKzcs1JY0kjFjXVXla6lpHaMaa0?=
 =?us-ascii?Q?JTDFCbmgoKCwt/SSidmb1o4k+uGjrn2u5w2lWRhFQTBxqaYehjWtDFaIQxZC?=
 =?us-ascii?Q?MchmgQP0QIakdGayYAPNmBAyyx6xX/7UYUNhbtIRjMhf2Zyx7V57iqSjxETW?=
 =?us-ascii?Q?ou54nFrWL1usf51GH+CZhm+dXQqbjB4KQUw3qPNR4bw6mtHNkVco2Idk8k68?=
 =?us-ascii?Q?Do3pI7h8XE1PLsq5YcSDGSbG7lLVW1a76ENFeScUApdQceGdbt0IQ2WNrc6S?=
 =?us-ascii?Q?gpypKgBm0EcER+DyL/Y2qLcAI86vS1qxRJu+LRi9OZLIxGhOAXS+vbsc6229?=
 =?us-ascii?Q?dzltKgP3i7aNMr+Pg/KeozaAoc0P0VeNtWFjn/I/ygtWsofUygVWDOxQP/gK?=
 =?us-ascii?Q?PbbAN0MjwfZB7aNIZY5Km6FoFTWr8FyIo6o35Nya8XMVGAaOisT151X6Rr8/?=
 =?us-ascii?Q?3FWoYS149APv+CZRngLtRnmRlQ/IG8nRQNxsH8KMe3Hy+QuRrbV+LCW8AzYK?=
 =?us-ascii?Q?R48kxLwQyeAMUbShEzctcUf0Ta/dWkqYe5voVnPJtMOpFOlJYX42i5CQZ8zv?=
 =?us-ascii?Q?67sgpZrEbDzTSmTdGBC1vL8MtdosEg8jz514FLBvraCldehJQK6eBT6MSYNy?=
 =?us-ascii?Q?hzTX6v5LQawuWMG6v22ZMVyH7DUPcG49uEUl+7rG8zcrv3mbRBHqc+5s+N1X?=
 =?us-ascii?Q?DC0BOYCaHLltKH8ENC0jBxhHUDRYEPWspSo98S5D3FR1e5rCU6Dz4SICfcb5?=
 =?us-ascii?Q?/k7Ba0XMB8DAWnq6pj1dIFWBBqvzFEx1huWS06JrHBVTjExxL87aTLGXHC3Y?=
 =?us-ascii?Q?IJ1E71Oam01KT9P6NtnM7n67NzhGSdLaCCoYxIHj1nIeaYIU6uhHyY9hArO2?=
 =?us-ascii?Q?W0UGSlKaTNQt0r0kHM0nD42Xz+aE9DHuOb3bg+T8WAX7XkbRVWXRQjtciXZA?=
 =?us-ascii?Q?QxsZxljW3iqcb3HZp+NZbmd88sUhP/WN0Clf8xJPdtZwqjjzXOva8VbdotwH?=
 =?us-ascii?Q?sGVVVUB0pZA97fOR4f04T4KF12UWhMSzGPEmVHcS3hShhrSfynLb7B++ELC5?=
 =?us-ascii?Q?KfYQ+p9ZGulRflMCb7x8vf2CvX0lawb4aosqWgzKzJyGInOZmaVuAN0BkEkq?=
 =?us-ascii?Q?R0t6UXYT5jx0519a82oQImiqCrzovvj9br6aY8bHCKIItZYXAQqpUdStyR6d?=
 =?us-ascii?Q?OETymz8rYFg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pbd9Yw/3GiMBR0lonRmDbasPkw9P2U22P26HCvjf0djCQZ4tEUeShOJIe6D6?=
 =?us-ascii?Q?6LTTleRcA9Bt6+msBIfWFU1jIvI+mu8mMtrCQ8JauyqjrPJrh5TZWpo1SRM9?=
 =?us-ascii?Q?KoPQpEb5M25dixBB6Rq4wweLSVOh+fh1Kx/dwUkxhOuoW/XPlujHVeEr7g2V?=
 =?us-ascii?Q?N6t96RIFOhM2Vwefsc23mIE/w8yiqE6i+ssdasnocZmtHDN8EgAqyF2Mg3eV?=
 =?us-ascii?Q?/F73gZnFagC2mjfjlCL0l6EBGkN36Tf9kmdRXMKq7+eLlYNHeRHNO0ISpU5o?=
 =?us-ascii?Q?OlDHiiBNEi9/y2phhxbuELav5e+DvGD9K8cgRH6i8iNEr5winyFrkgqgJzln?=
 =?us-ascii?Q?yLpHtIPCLcEIfPdPg6H4c2Uf3c9pai3s49bTZp2IaEF8zJTpoWas7hwNAuPB?=
 =?us-ascii?Q?GQBq8wad5lsRH2+AGNjoW6MBHDJYuL3uVaPXfky9st9VMV+9CrSGs8zsId9X?=
 =?us-ascii?Q?VECpqIGY4NHf2zRMyXrI9icOtLkDPL5/mbMUCsVoIXKB86AblU540wWpkEjv?=
 =?us-ascii?Q?Yff4jRlS37pGB5T1vejWrdZGp5sxDyMYvI6fiBoMLhdQCJm4pw1b+pqYdJCX?=
 =?us-ascii?Q?s4ukglslBlyPwShlug+UcUYtEHwB0WP3kCjnEZqLDc7FeHw3pvk4zs6IDhfH?=
 =?us-ascii?Q?WtOvrgynPB0ENfYovt5boZnFvnJZAU/dA83RjhpeZMhCP1YlVLkSYBdGycAJ?=
 =?us-ascii?Q?PuWA1vg6+3z1N24cwIpIO5dkqJPh6gM8Ab3O/RQv35x6hiXYfxRqXIBstvnI?=
 =?us-ascii?Q?xUP7NJJ0u86dstLmMSiAaMWs8DJW45GP+5L56RqSHjLQJAB71wQcEK2J9lha?=
 =?us-ascii?Q?cDUUk96euHFpRjnup9G3B7Q7z1+MHEJwg26zaUR4jDUzKRENkRBMp+j2XHbK?=
 =?us-ascii?Q?unm/VcFKl1o327I1OitzGXOqXxaEsF4siFMAW+pqAK18mH9hUXdNpjef2A3g?=
 =?us-ascii?Q?w9M8cdHdRGGEedG+rsde5PZOSJLa6+XYdHfjBhfnMB+5fl7oecU3UWF5LAHs?=
 =?us-ascii?Q?cL93gEh/FG2/P4iyVe9fAgwCRi9SM5pp2S1qL9B9y9fYw6A5VhWuxZnIAOdO?=
 =?us-ascii?Q?XYn3IUUjEFlmzFsyMVhjooNPZnQGl0ElPBfQVJ7JNnj6SGx1Vt4496ODzuJF?=
 =?us-ascii?Q?B8CV+GCgGqCZ3qFONA8hWsspWY5PV1DjP5Igq4eeaZl4qUmWaIr5xjBP5JA7?=
 =?us-ascii?Q?/GIU+uiK2GCxTXp9qBeS8+u1U152QjpcGwKuHTvKIAk582raREPGWHgEC6k9?=
 =?us-ascii?Q?BoJPX8b5RhGp1/TXJBJmg2FUiSdu1oMFpLnynVG87stUxJR8AnqXxN4+UI3D?=
 =?us-ascii?Q?MfHhmqrLKGQeX9jPGXXzFIOsNqCt4hQP3f16P0l5vg8mTsbA93+2HWgRkKNZ?=
 =?us-ascii?Q?WoC2SOzWfZfLjNTD7F4YwkZkHpS5KrUY/tJbIN+xF1QAw7BPPqecuhn/QLWR?=
 =?us-ascii?Q?SxJ/IT3ikSc3A06/QcuZ1tnwWE03H1i6alkZdZdTmbi1NLyx3sVkRYhh+lVL?=
 =?us-ascii?Q?RccrK7f4oHBurTM0gxszRJSRqVrNAY3JP93jHLb3d9PbAZ2RcgZw8dmSgqK+?=
 =?us-ascii?Q?4iLgL2/diEQy0V/+xKKOqINX4TvfeDbYoTKqWi9LmGaEj9XJSq7CQTmk9qer?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f695d57a-4b54-4351-a6af-08dd943d2bef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:40.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5AX303LdBrXYLebZGVlQVh44knNGqjeh9tBknY45DtACyLAogj92OX+BmXA6db0YJq/AHORMGoTfwJq3BvAij8n+wMtHa5rzbx9+1rGFv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

The ability to emulate a host-bridge is useful not only for hardware PCI
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
index ac27bda5ba26..8b624da2fdd7 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3574,48 +3574,6 @@ static int hv_send_resources_released(struct hv_device *hdev)
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
@@ -3659,9 +3617,9 @@ static int hv_pci_probe(struct hv_device *hdev,
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
@@ -3795,7 +3753,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 destroy_wq:
 	destroy_workqueue(hbus->wq);
 free_dom:
-	hv_put_dom_num(hbus->bridge->domain_nr);
+	pci_bus_release_emul_domain_nr(hbus->bridge->domain_nr);
 free_bus:
 	kfree(hbus);
 	return ret;
@@ -3919,8 +3877,6 @@ static void hv_pci_remove(struct hv_device *hdev)
 	irq_domain_remove(hbus->irq_domain);
 	irq_domain_free_fwnode(hbus->fwnode);
 
-	hv_put_dom_num(hbus->bridge->domain_nr);
-
 	kfree(hbus);
 }
 
@@ -4097,9 +4053,6 @@ static int __init init_hv_pci_drv(void)
 	if (ret)
 		return ret;
 
-	/* Set the invalid domain number's bit, so it will not be used */
-	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
-
 	/* Initialize PCI block r/w interface */
 	hvpci_block_ops.read_block = hv_read_config_block;
 	hvpci_block_ops.write_block = hv_write_config_block;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24..aea6bf37a360 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6713,9 +6713,50 @@ static void pci_no_domains(void)
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
index c090289b70be..e4a7bb8b415f 100644
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
index 72d07ad994fa..8962bf133316 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1894,10 +1894,14 @@ DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
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
2.49.0


