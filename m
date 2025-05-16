Return-Path: <linux-pci+bounces-27831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60FAB95A2
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC071BA44BA
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D185288DA;
	Fri, 16 May 2025 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fx9cvJCR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C065E21C9F1
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374550; cv=fail; b=piUvIuvtDCIe7AyzwJ67NfGQ0LV9SkUODxiW2TJrgs+FPHtf+oj68XjEAKT8PrTOMe1DvwPWAg/Y9S07SwQq4VbnGoO3M9Eypj8AD0YCKixMSREXBCqGYsb5EBDvrL5N9joOCdkE1uARF78opF3I2ZXCpzkarT7zLjbnCG6m6Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374550; c=relaxed/simple;
	bh=nsF5lFnioVybHszrDqRMfJ/zKg2oYKd4eyyWJjmY0mU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKqglSc1/j5Ux5xnOzxXBK41Kli2FBsEPhav/ShoFWBN+24hzz/6Sla5jSXcVu1EIeah1FobrWHHixairPOe/zwN6XrH8piAzr3Zq9A/WGBCL3iyojL7BjonW7G0NNKG2tyoji4RBro17A7qWQVATMCLiup8qCldPZEEFXeZSQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fx9cvJCR; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374549; x=1778910549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nsF5lFnioVybHszrDqRMfJ/zKg2oYKd4eyyWJjmY0mU=;
  b=fx9cvJCRSPBR/3x54mwk5PppVSO2u+lQMu+5a6aEars8AeuebVOdCAhE
   WXqguDHou+xhZbWbsqdZHhjvgpEy/PF3ZYXpAS7yCxp/c09ZGAOevURaS
   1Axp14y91X7iFzsWHsnNmixFwGcA7YCznYtX34/3XijOYEzAHFgdjECAO
   YixJSvYIMzLvHCpa/bbIANzVrT6+Riexg5f/jAP83aleI3WX3kwbEcfWh
   6CBVscqQzxHaDZn+eQQDhWHJcAh1rhp2YsD9tYZfUAl+JC+CVRULIHJ+p
   tX1uXSz8X2xlVsfHujhqvou7WgGulD4XGD9uM1OzHlECjTz7csCixXwW4
   w==;
X-CSE-ConnectionGUID: lEdfKIRURRqHtNnQcESshw==
X-CSE-MsgGUID: pPbgNDVaTN+k7ht95ee8xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="66884894"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="66884894"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:49:08 -0700
X-CSE-ConnectionGUID: UYYYyxakQx2AXmBAdKi1TQ==
X-CSE-MsgGUID: fnQIQjnmRROgzVBG0/nEcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143709070"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:49:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:49:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:49:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:49:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efjoiZKUjsBqNgbrcfjzUBKUMvsEx6hRuBp6BwKSb7H3+34oIAdifRugKzi81zj02RWgSsqTg6DYS4iSGmKZWlvzXt6S/5b7SvmKlcZQNr+0BqXSdT0Y0pA8M304pIx/dQqJ70BnrPYbsrAESK62Z9TjBNRh+AsSGgqtf/H0+PJHY2TLNqvcYEhU5aayVkFj5X3cLVwp4tt/RjpjRFufgNXCjLsTER4vqu4NM095hIXpJac1m3qhZ2vYlGdLl+TN/hqEoQCfmyn2TfwCq/Gj+5ofrJ+bvD2MAadKyHn4REPgfo9L/5VmXIcWd/f+oirXgR6KQAWyJhsHQppc08+j8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4Mkp+okgD6Q6//XGt8JHgqKaJ+9nJQog9GnZu2C+Ew=;
 b=qlwA9TK3s6UWFt6wSv8vkrKxiYDj3wy/pJB2vS7CsCOXliX+UDuPFMMBsWIlJErxHe4Ne3ncmv4PWiWpgN9aINeIW411SyxkZnpib02yH9ug7wao6SDRDkbE9GtQlxNJi7QakqHAlsthkwfg0fWMQXAJeNfS5wdvAOVjmi2CsCY9ILzQWoTMLV0AorMeVUdhgNEmDNhVZvEXF8vqWl1rxHiUTiP0Qmog+DfU5j3MsR+EEQBmJhWb5Se7lg2H2cjAYLebQdoauszBlG8l7M3JLROlxdTDZ85x2wKtxWVSN72RgSzWKrOCinQ2p0sceFqNuS+1yfbUCo048GHhILUo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 05:47:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:48 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v3 11/13] samples/devsec: Add sample IDE establishment
Date: Thu, 15 May 2025 22:47:30 -0700
Message-ID: <20250516054732.2055093-12-dan.j.williams@intel.com>
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d41b2d5-b827-4450-a258-08dd943d306b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DBRsTavrk2dOV+5OB6rYGQwdDFXUZCS0yP3azEYjPDerqNpe6FjOdCTs3sRK?=
 =?us-ascii?Q?PYCe8L8sU/zmS1JL0qi/szqdhUXmiA+D5pp9WL1HuyKgFa359lccLQxQ7yj5?=
 =?us-ascii?Q?SCJ+iL3vAO2xxAnPiQeeYODy/+S67Nf1KI4jUoX3jebnYfwfzWotB8OvoqfV?=
 =?us-ascii?Q?4ZAxSvSB7RcFL/0qMDKInIRYC3eAYHoT0vHXIZuYIopG7tfHftK82hIbeIt9?=
 =?us-ascii?Q?MibyXRS1QGw1ihm6KINYGUO7eIJ+aCyM9+sBMRnJLlG5zdD7Sw+pU1uQ7eAM?=
 =?us-ascii?Q?LEkeoT3Pm6hoKZk8eoZWIVBHeOswZ0QGR4rXCIHEC+moA0KZMTi9ExvI7XjM?=
 =?us-ascii?Q?eHuminbfeljQhOy6J7RWbpfH151H2gJ+1FI3LcA+oarnmXaW3MRMiMCxF09H?=
 =?us-ascii?Q?RalJDzexlZCv4vVyRukswd8j5Flh3a6XtKv6UJzWpafYRjYXsdEdxIo5GLhG?=
 =?us-ascii?Q?YFNog2D3cll4DNRz6URXqcs3sBOqTNkF36gnF+xhIboP7jKtdgseAihDtEPD?=
 =?us-ascii?Q?eW+O/G+xQZBW0lFCMF4jFTDNlZwS16FZvl8ilI2jPjXVb6sQ2IYPucL7InEU?=
 =?us-ascii?Q?Px5Nqow3Pr+hUZxIsXCE0yUbOhHocm0Bqc/ZGMw/x7jEFOblHNi5WzfGHlwx?=
 =?us-ascii?Q?xjC489Ksu8BbWDS+rBFzSiY3bE6h5CQIpIOq4WHP5KSg61vfBZ65hnfKqL5T?=
 =?us-ascii?Q?Lpt3dQ4UfmIqigsduOdnvF9t+OgsRlzzVV04kvtPNpnoF/GrCjPdCLUQW+J5?=
 =?us-ascii?Q?4dgjvWZEKPjoFG7IMpsMpptIkLDlPNGV0tzaX5PNdDR65dkVIpILoOjf0Fh5?=
 =?us-ascii?Q?L2bdxLzHN/d/IKNu/Qp4GKOhtj8US5ghpoIjl9KcuNHDWkXjZxQDHBmVNiIW?=
 =?us-ascii?Q?Pcafs+FQBOxTzZRva8KbVu561JsxwmaBdbuEVw72YwyCu+C9nbBPO3JRV2Es?=
 =?us-ascii?Q?8S62+qg8jUPqHJxRByXHiT/MjFlz1IKofGYfJMqq0xcFO813OEeWjeG1Hh8n?=
 =?us-ascii?Q?OwvEyr381xirwxOJhnQQT653i6rLLDpSdOK88KnLVgWbo1nmOKr1egUy1+G1?=
 =?us-ascii?Q?SFI2OIp4xIgE5Zc7JBArk4zJt4PHtSmCwvfbOQT8VANBtmwsEudRKnmy5/KJ?=
 =?us-ascii?Q?cDrNMG0RF3tDED+VwbNrvQtG06s+a+ZkM2QXUXQADzC6ticBL8qannhlXSrM?=
 =?us-ascii?Q?zXhgZBY6A1xNVBlTVvyjOWGEAsBvb4324Tb0Bc/adFmlUyYnBcq/C2dN/wNV?=
 =?us-ascii?Q?iALG7kVItbP0uLr8TRuEHELDntyGdZPOjl0upaXqmv0IcPSc6Ucgz1qfx9ee?=
 =?us-ascii?Q?GXrBejtTwyp7hmBN6cw1lqXwmiD5x1Fs+Ix8w9rLmaKYsqAV94g4Jur5dq0r?=
 =?us-ascii?Q?op10gy2X8OxVlaCjpdT4fGXoHMmgMl46LNgH0undiet2JJJQNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h88aG37Tl9Oy8ez2C557jmLIGuqbX5X6vVY7InZR9E5Vohn2y/AJu25M0wPq?=
 =?us-ascii?Q?M2PNXhr7VpKSgc1tbmHNtMSmFURZ6KhEpdVqICoc4Lu/8ViKZEFc2REXtqv7?=
 =?us-ascii?Q?FrpFuW6fAydbC1SWgSXOzxE+9EESUQKSbskb125atiVNbeF3qtF5LhleMFeU?=
 =?us-ascii?Q?5CnzK5aO8jGCSnlNQul0kFEUSrG+rddRq3Ddd0CT7ymeksJ0/RHGqyjKZkqi?=
 =?us-ascii?Q?+zMxpT8JrkfvnZQdI2TNHyFkJ3Ey2e3jjrcbt9IeuZg0i5dYBCNOkhKLDikg?=
 =?us-ascii?Q?vfJ1IAtb2JmYnck2D7ZPsPEDmatroO76rSmfSpoIDLduRMlR367wyFsW1srQ?=
 =?us-ascii?Q?7w8O9+AWXuzZlO7T8RFk87w0ar1p7z5sUvicJkTSUloIt9Q2y/9idOwJlg4h?=
 =?us-ascii?Q?QRecahRn2mhxPh5BSJRlMqjTj6l4q8AZI67mIiEDNpMciQZ7Q+5EhFYA/JW+?=
 =?us-ascii?Q?CCDbfvZTQsQRrI9Mf/Qk8C1W0qz8kp6ifhg4kOHOof4UK5rGdLwpkUySsk5a?=
 =?us-ascii?Q?77l5F0z/ZgGWc8Ye5nvYWXTsYEpsKvkT2vK9Q2kqJXmm+oOfimsebzVgLAsv?=
 =?us-ascii?Q?8FtFO8QH7GxfcUlsapya95PeubsWJk+pZas4s2XvHLxosyIrkis6bf3waPE0?=
 =?us-ascii?Q?rc3EX3sRFmZ2r/BxF45HdLGggd7hAz700GxHnN82TEXlbmuHFZmcwQvgE2N+?=
 =?us-ascii?Q?upDgg5GOla2cLIvAa77rBAHgzDNMd7jbhmwqInRj20CO/fvuYEl3dAy+w2JN?=
 =?us-ascii?Q?yaR3ltHQ8bNjdG5hh4g4Zdqrw8P+7Lj+jEjNnEsn4w9Gq/W2tYK1ixn9UjMQ?=
 =?us-ascii?Q?lK+HVL8pwNpfDbRGFm5ZZwgFaWobeagTc6l9WJ2oUaJzCz9+d8m6uvVj3W4Y?=
 =?us-ascii?Q?Y0BVTqckbbgEV9HS4ynWTbKmWAxuRDgTc/SrRP2Tam2agVTuLtW09zSylPov?=
 =?us-ascii?Q?wkhHjWWJVzRjF7BGh/3IqwPnmjchu3MVA0XMEmIBV0BZt8jo1Ybip74NXixQ?=
 =?us-ascii?Q?c4GWNTEQltFegKNYrIXawh1XV1cmagzdew2VLXTEBArlmsHK7EDeGAXHmdkA?=
 =?us-ascii?Q?QeLC4Gx2d21tcz7f7rGk9kJsqOUh/m11erRtMYR380dIPgJngf18r/5Hif2t?=
 =?us-ascii?Q?ekq9jdN3TeUtbm9U0dFdxfO9tubYcMPoRHWmZg2hWsTRjrFZ60fHH3YShICi?=
 =?us-ascii?Q?Fj8wzkUEp9iJUKiHSpbsXIeKw5mQwAk5Bt3v67x3EvnQLz6E5asWyZdaECUJ?=
 =?us-ascii?Q?YbSvHYyHH65u9TNJWcGaVy6XtAKRFBhyz4r8iyPVfK7aTudCbl0quVcW0hcc?=
 =?us-ascii?Q?8lREUydHupCHhE79sOOA6jteBbzfI2KpK5X8+O7uaSI68+ztVc1F+cBZtf5F?=
 =?us-ascii?Q?Gsjeg8OVISeRKXqr6jZuv6EDxxbsXTrLzzrVCr4/FkZTQvi4qBoDPqS5l3lD?=
 =?us-ascii?Q?Ga52Gnqanf2cdwp/JH1mZ3JoCbs/hs8JVW4XMBgMou6pZAGXb3mNP4kg4UB5?=
 =?us-ascii?Q?bGhKOsI+Mv+/ytFAmKXdPGhmGTxlBBugNpDnai59dbFD+BMdVK86V/09E9pb?=
 =?us-ascii?Q?hdFDTugkuZ9h1igKvB6z4GEx/HJG/oT2rsToPkk2HN2d20F2U9eSi+x1t98n?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d41b2d5-b827-4450-a258-08dd943d306b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:48.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAAOWwOJW/Hx72H7fG1VdRMSZMseyiZOnN7xgOZyyD8wgyNem66KsZDF4ShlgD8ONWaIpmWVoi4s+Vxz8U0Xm5f807Z4hk3YcQ1jdjLZ8LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com

Exercise common setup and teardown flows for a sample platform TSM
driver that implements the TSM 'connect' and 'disconnect' flows.

This is both a template for platform specific implementations and a
simple integration test for the PCI core infrastructure + ABI.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 samples/devsec/bus.c |  3 ++
 samples/devsec/tsm.c | 77 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
index 675e185fcf79..efd7a650b20d 100644
--- a/samples/devsec/bus.c
+++ b/samples/devsec/bus.c
@@ -15,6 +15,7 @@
 
 #define NR_DEVSEC_BUSES 1
 #define NR_DEVSEC_ROOT_PORTS 1
+#define NR_PLATFORM_STREAMS 4
 #define NR_PORT_STREAMS 1
 #define NR_ADDR_ASSOC 1
 #define NR_DEVSEC_DEVS 1
@@ -662,6 +663,7 @@ static int __init devsec_bus_probe(struct platform_device *pdev)
 	hb->dev.parent = dev;
 	hb->sysdata = sd;
 	hb->ops = &devsec_ops;
+	pci_ide_init_nr_streams(hb, NR_PLATFORM_STREAMS);
 
 	rc = pci_scan_root_bus_bridge(hb);
 	if (rc)
@@ -704,5 +706,6 @@ static void __exit devsec_bus_exit(void)
 }
 module_exit(devsec_bus_exit);
 
+MODULE_IMPORT_NS("PCI_IDE");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Device Security Sample Infrastructure: TDISP Device Emulation");
diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
index 7a8d33dc54c6..aa852ac1c16d 100644
--- a/samples/devsec/tsm.c
+++ b/samples/devsec/tsm.c
@@ -4,6 +4,7 @@
 #define dev_fmt(fmt) "devsec: " fmt
 #include <linux/platform_device.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/tsm.h>
@@ -50,6 +51,10 @@ static void devsec_tsm_pci_remove(struct pci_tsm *tsm)
 	kfree(devsec_tsm);
 }
 
+/* protected by tsm_ops lock */
+static DECLARE_BITMAP(devsec_stream_ids, NR_TSM_STREAMS);
+static struct pci_ide *devsec_streams[NR_TSM_STREAMS];
+
 /*
  * Reference consumer for a TSM driver "connect" operation callback. The
  * low-level TSM driver understands details about the platform the PCI
@@ -74,11 +79,81 @@ static void devsec_tsm_pci_remove(struct pci_tsm *tsm)
  */
 static int devsec_tsm_connect(struct pci_dev *pdev)
 {
-	return -ENXIO;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_ide *ide;
+	int rc, stream_id;
+
+	stream_id =
+		find_first_zero_bit(devsec_stream_ids, NR_TSM_STREAMS);
+	if (stream_id == NR_TSM_STREAMS)
+		return -EBUSY;
+	set_bit(stream_id, devsec_stream_ids);
+
+	ide = pci_ide_stream_alloc(pdev);
+	if (!ide) {
+		rc = -ENOMEM;
+		goto err_stream_alloc;
+	}
+
+	ide->stream_id = stream_id;
+	rc = pci_ide_stream_register(ide);
+	if (rc)
+		goto err_stream;
+
+	pci_ide_stream_setup(pdev, ide);
+	pci_ide_stream_setup(rp, ide);
+
+	rc = tsm_ide_stream_register(pdev, ide);
+	if (rc)
+		goto err_tsm;
+
+	/*
+	 * Model a TSM that handled enabling the stream at
+	 * tsm_ide_stream_register() time
+	 */
+	rc = pci_ide_stream_enable(pdev, ide);
+	if (rc)
+		goto err_enable;
+	devsec_streams[stream_id] = ide;
+
+	return 0;
+
+err_enable:
+	tsm_ide_stream_unregister(ide);
+err_tsm:
+	pci_ide_stream_teardown(rp, ide);
+	pci_ide_stream_teardown(pdev, ide);
+	pci_ide_stream_unregister(ide);
+err_stream:
+	pci_ide_stream_free(ide);
+err_stream_alloc:
+	clear_bit(stream_id, devsec_stream_ids);
+
+	return rc;
 }
 
 static void devsec_tsm_disconnect(struct pci_dev *pdev)
 {
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_ide *ide;
+	int i;
+
+	for_each_set_bit(i, devsec_stream_ids, NR_TSM_STREAMS)
+		if (devsec_streams[i]->pdev == pdev)
+			break;
+
+	if (i >= NR_TSM_STREAMS)
+		return;
+
+	ide = devsec_streams[i];
+	devsec_streams[i] = NULL;
+	pci_ide_stream_disable(pdev, ide);
+	tsm_ide_stream_unregister(ide);
+	pci_ide_stream_teardown(rp, ide);
+	pci_ide_stream_teardown(pdev, ide);
+	pci_ide_stream_unregister(ide);
+	pci_ide_stream_free(ide);
+	clear_bit(i, devsec_stream_ids);
 }
 
 static const struct pci_tsm_ops devsec_pci_ops = {
-- 
2.49.0


