Return-Path: <linux-pci+bounces-27825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48882AB959C
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7F0500AFC
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330341F463F;
	Fri, 16 May 2025 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2O6vXk4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C22206B7
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374485; cv=fail; b=oRP9iaVVF8EFdDvx42CSTNRFhTA3pTaCbp1JWBjyRqUCaWxVXj8gmf85uHNewC+bL/MARQzWjPxKGItT/sFt68NtqXWkm1oAqiaQr52TZZtkgXeYuOOU6Tr3DMdGYpjPpuprhEzm0fOhqndxkbmrn4uVM/rDAR5h3NUKOqmyYH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374485; c=relaxed/simple;
	bh=7usiYIj3ZJOIc5b2zkZ9CsReSX/7KdreBUplCkqI/qM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kDHoFRs+MiSaqSUS1bB9reKUkRCeHLWZSRQOEhe+LeSxI9OJhWlze58FqYOn8mtaOtJFtyU7bnNpk2ms7S6MrUeMFw4szSFi8QW3hrX7bSMbASXIILk3WvoWtA6R3EOR6AAmEbPSiPcg45yc4AbDEKmvbrG9tkNX532K0TUR4T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2O6vXk4; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374483; x=1778910483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7usiYIj3ZJOIc5b2zkZ9CsReSX/7KdreBUplCkqI/qM=;
  b=P2O6vXk45Cfk1KUjvzsnyp5O1P1IyIeDz9BlYiwwmr9wb2NLnl7gju8P
   EU0FCMCeBBryNUn+o5RbCWtew3qh3uxpRypC7Ucd1qvzcxfCYd6B5ZVt5
   7Y9VRe7+Q0dpv1FyDgFy5/e04n0Mz4w1jMLDt1hiKprLYOatC/b7b1cD2
   HJByb1SSWAPDBPFKj5tS9yWgJDSkYV5rcJnpeRn0Bti2T3amOwQAUNws8
   KpoAzhhKVyl3f3cmk9XfKywHkhzn3PVrhgElizvZE02iX7MRcwACHVzO2
   7Jn4+STvCaIIS4DLGPAWyq+kKB3gWWv1KOJQtwqrGi+hCXNaRZFIoKQxc
   g==;
X-CSE-ConnectionGUID: 8+Ar2agoT0OrAmzD3ujcNg==
X-CSE-MsgGUID: gxXr+jo9RzyGFNzHFLdHUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36952819"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36952819"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:48:02 -0700
X-CSE-ConnectionGUID: yhDbhYUVRm+cGERnY6dzDw==
X-CSE-MsgGUID: KFT78bJnR3SlEVFMOZMnyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139084723"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:47:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:47:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsqkiJGj1pgNwCT/bvBY44rbGCylW1whqpJhArNiWxka1HzQt+vEFdhnbRg1CPyQhSBr6DiEWGYhRGs3u3FC+HJtHWpqvAhOPc/S21T9EHp3YyQo1zAeiZsWvUKdFjNdELrSbHKHnRZjmcrDNUshKQwhLxRDlNT4kUcrNmE6OrIZP/I2eBQGW6M6xOW5jSWkFp8SJrmzH32DAnIgOEm1D2pchQWZbI9GAQGptmV+0MctdNB2FSqokgck+zKUl6QCMruEb29l5dvoeJQ4OJT9J/stoGfRe11ZFu/VzJkJItaFxRY2yEl2bpUkuF87yQdmdVJiiqDPqUzPsjWZ8gbGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmPD1JBo/CmRZPrI5VQPd40oMWq7sJ4+HtfhTjNqFI4=;
 b=GzvZabvtT95SdUvWU637VBLuh2W0DJDKbfUgk6QNs21RwKnuokWCmB/NL1+2hRaCTvicZGICPO9CJSNCOKDqr2oTjC50fCNvXhK+k+f1QZGb+3kb/bGCKYSFgIc1/weTAtG/Oe1W9PuC/1idNgNc2tc4fz7MrRWOMgSlMSazJrBMhEQGKxKd107v/dJZ+/B3kQu8CGJfT402ZnvyodBMNP9XosdJ/IVtlxlO7WPBxrhnHw2hU1AhVFQtEXRX2f6Br8/WmBdgpcp/GydEwqK6pwQ6rkSBwhhcPGfvNLLpVu63Fi7xHKPk6Wili2sgaw5Ow6hagPBnFXXod9fksubSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:47:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:42 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Nirmal Patel
	<nirmal.patel@linux.intel.com>
Subject: [PATCH v3 05/13] PCI: vmd: Switch to pci_bus_find_emul_domain_nr()
Date: Thu, 15 May 2025 22:47:24 -0700
Message-ID: <20250516054732.2055093-6-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: e315c9ab-5e6e-4e83-dd36-08dd943d2c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SXH9BmkOT6q1gvMfLXP1HDTZcO87d52hlPDGaRNykFtGwpafw/SP29EdgXQ1?=
 =?us-ascii?Q?QljCj+HdG0Ak0/Je5Pbo8rbxBRWOEGzisC7ygB2+vlSU7SXUYNBmJ8FJL7I4?=
 =?us-ascii?Q?YWqiTNEoy152g29+BJJXyKssLi1J5GnPgmxIQf4+7INTnDEYSy5WRqvsM/TG?=
 =?us-ascii?Q?Y3sN86Cd/YnEgW0hB8E2AtuQdQ5oiysE5YPjzQaM+5XWC74xd47WqOpQyo6p?=
 =?us-ascii?Q?dxdMRPasvtczCgBBpCVYMoOc1bA/1+/p2wFuJfC3LKdWd5XJiMi5FM6yod6k?=
 =?us-ascii?Q?6aYYzyGEwGPOk1Dn5Bw/53sdFem9wFj7FIJOMhHLypz2n0NmaEKdcZqWsyje?=
 =?us-ascii?Q?+3AEJNkJB7VBq0pu5A80NRPcbJ4tIX2t0pNdHe83fX/yjJUivGervT2/QeZj?=
 =?us-ascii?Q?KB7w4y6TINY0tohCG7PR9Ttsb91iOIFF69qwIvj6wl906WWgMwULMwzNafWu?=
 =?us-ascii?Q?m02PxYIS0aZWKDlKBrNLIU/eW+ptwLh/WsdZkC9ZLFc0YzxukiCOeiGuLlsm?=
 =?us-ascii?Q?CzknXy3zKx7rRD7uje8VGdXxeyEpwD1sKCNGcYKMBMSAUWpkOIbc2q/farcj?=
 =?us-ascii?Q?e37mZecuHkzjB6lnTTGhF4mnxEEWARxPKKc9ej5sE17cLtrsZQRJ6W/4Cdlb?=
 =?us-ascii?Q?A/Zn2ErBLpcTczWOXrnqwih5GW0SwVbZs/jfJwOlAFH7T2vOkgFv0w70DxYs?=
 =?us-ascii?Q?QIkBDPS37u2UsiWF62jYTj3B4ZYPNlKAmE/mFGMLbIyBDP+yGYUawhQNl/sv?=
 =?us-ascii?Q?82fI1twze15QS2lNysoT6W4u4sQh9916MaJXYRmi28lqsd2Ql2H4v0154Be7?=
 =?us-ascii?Q?/BOyhVBXxkA3ZNjPrvRRutis3bcGiQ1cJ5UHt0V/xl3gHhWs5sOeaxY+veGj?=
 =?us-ascii?Q?0ujUkDNhWxOGIBGbSPUsz/FHg07sRBDGr3Ypw0j8gFbG2jO4+daKfDdJRiFY?=
 =?us-ascii?Q?494JBKdZo9E5fj4ddR5roT8l3BbMm/7VaFl2eD6iJMGf9cHL7XCLk/BtDkAE?=
 =?us-ascii?Q?kf6KAmZjozj3vc/q/Q93TDyjBy7BF5MA/Patx3luv7Z1kjwEpUcfV7WlaKKS?=
 =?us-ascii?Q?GZJI73/vJJsEsTnS7wanD7eD2U/BSOlPwxF+VX0+OHMm8rkvbkpisDr45dhG?=
 =?us-ascii?Q?erE4ELuZyLefC+vN8p4TSRBDVn0jMKBy+q/UCUaE9bYU4Ds9qhi9LrV2GSJ0?=
 =?us-ascii?Q?3k6vXY6a5sfTqcnkf788ArAQd2URlUhUW66v0XbB+9QwMJN7ekxUamB0zo7W?=
 =?us-ascii?Q?/hjBLT8UPl32C2mTDFGALzw60VFo20ddEsobg4+Wpx40tMo8lHJI/pCN0a8E?=
 =?us-ascii?Q?FzW3glYOlod/bLNzDtguM1zUaUCQq7UHnIiB2DoaOeUXx9E9yogztiMTYXfr?=
 =?us-ascii?Q?FUt42RevE5XszMJsO/daa0LFaI0JyAVlVvpRtkrAZJZJ+0XD6xwRciEddiAl?=
 =?us-ascii?Q?ZiYmrzSHXSY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzeC91eWBCLo0ioekQbxWTPp69Sx3Gi5x2vhdW5eQThu8zytqzjOzju74t7I?=
 =?us-ascii?Q?1xHP3fQx4aIkzUS3huQUfCmpHPkLTfxjrunzcER1mRdgXaxsqHkDylYt8W/B?=
 =?us-ascii?Q?i0cnhu+aXeQJWptI03gqdkdYf26ZEqIfbIQLZqiES+ZxbKaW1rtvN5Hd0jw1?=
 =?us-ascii?Q?VzfpAuAOivnMdPtYyNUJO4E2kgneL8OkWrYc7kEknk6ysZe8EgGTp8OCrJuE?=
 =?us-ascii?Q?Qhe1Rp7M2SH0Z2uQbxMeuHdXG9e9ymghtiao8rwvAGRo1dAvM+Q83nz7RUhc?=
 =?us-ascii?Q?oB3v45+kb06jmc2Ugr7QzhLSRHFKzndQOmy19Nirt3ztyEiiqZgxF0Z2v5IN?=
 =?us-ascii?Q?Gdr2egEYP7dMFWPZKj2OyX2fTRHTdcpGneCCdlJ9uD6fzKjh9aNDWSQSgZMy?=
 =?us-ascii?Q?kmOltDbjLgg1oRLfloYimdgS2/UHFX7d9C4LzwJH7iw/QyyAzNE2KasRBwg/?=
 =?us-ascii?Q?zfxg1xoQVd2aWJKWfbP1ta1pyi62rkeJduSTiC2Ib4vAm0OwGGH54iWcjIhL?=
 =?us-ascii?Q?FUOcC/pV9eVsEQ1lL2Ln9pcpAgN8BgXMfeyAiisDqjKvxf+4tMfXBxa47fwL?=
 =?us-ascii?Q?ROrJOqI/2G966j0UWGY2KAytRSI0g7/yD8f+1xCQOS09RN3h5DVFANuWdWkt?=
 =?us-ascii?Q?W8gW6p48xRNLFCgeoZTmY3KUuGqDjzW26VYq7/QxGEvbPf1nMgDYnFmmG6hN?=
 =?us-ascii?Q?50bXIB8agr+GGDCtRS6VW4JE5afI49yQ0zY6PtVGsZwfRZbnzFTK1elGCmS5?=
 =?us-ascii?Q?VYSJP87yzQpc3UgWG3jV+bqd0dq1UlDlm6cjvNboOx/KeROVYfjtQW4pozcD?=
 =?us-ascii?Q?LX2sjSgh3ITzZKxcNQY5nwReBab77LulMZePHMRYx+rs4Q2RyNXVUPp1BJn3?=
 =?us-ascii?Q?XG6hB0qzWQ9O/N6UKxrkbHW1CzNY5K1He44zYElCpUvnQ4Xbr0Kpb/EvPl19?=
 =?us-ascii?Q?4AL07ORQ4PEMGdeJpn7nhFr6m/9qgRxa9rAdzjmaLnTnrBLcmBVB2Gu8YDoj?=
 =?us-ascii?Q?py8CPl1zg6ZHUkOndKiN43WJ8vmEc01Ndk7FP62kODUKj9hFXkJ4VGYLKDSR?=
 =?us-ascii?Q?zBk0CJgEGTuXh5ZP0wBHJ/pxDh1Qe64KsK4mkV0bgKAnFl664vougQ+gbi7T?=
 =?us-ascii?Q?6FqmWoXty1iGZ+82sJZPWiMQDq/MTe6kG7KIp/9w6ktMYQQH6viOox5TXZkv?=
 =?us-ascii?Q?s0TcsCY/QNnh3xhOhjkRGzQK4WsRHMFI5vbLWWRH4cg08dRSOrMWzCnX/NVu?=
 =?us-ascii?Q?iW6R2qWsaOzREUQcev2dSH8I+vdGU/0JotBJH+R+KTZUHRQwKQbCK2qLYrTZ?=
 =?us-ascii?Q?fUg0Tf66tv5UtK1l0i3xR86DlS9NRrDHwwtuF5Gw+CZVKIekWxC803qG16TE?=
 =?us-ascii?Q?Bo+CschF/Pu5xaQJIrbfEQSeT6Qmdi1RwcKxFqx4QpuKH+ou4dadr6XQv+Tk?=
 =?us-ascii?Q?rl4DlpaavVi0Pk4ikoiFtkqrRvWFL1iv7OPWupv6D3P8TLGLsTiwPOPeUjon?=
 =?us-ascii?Q?D+qDFuqVw4GtmCIc/TgE1M5vEsIioEO9shlwwGJLkUpcTN742cjT15rAdfXu?=
 =?us-ascii?Q?3UQiZJACEOvLm+mw7/gz3Qh+bMkUBasCcRUfdqFH52mWd2Og8gjOhERUY+BY?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e315c9ab-5e6e-4e83-dd36-08dd943d2c92
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:41.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddX9IT3L7WTkru+T6LPSz2J5hJxyiBmZImea/e40OZA1tqbXhO7UbvjMUcPmCHqBDoysF5PPwnLpsj09Q3ft+Pq0Cdr91BeFVV9l0tG3538=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

The new common domain number allocator can replace the custom allocator
in VMD.

Beyond some code reuse benefits it does close a potential race whereby
vmd_find_free_domain() collides with new PCI buses coming online with a
conflicting domain number. Such a race has not been observed in
practice, hence not tagging this change as a fix.

As VMD uses pci_create_root_bus() rather than pci_alloc_host_bridge() +
pci_scan_root_bus_bridge() it has no chance to set ->domain_nr in the
bridge so needs to manage freeing the domain number on its own.

Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/controller/vmd.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8df064b62a2f..f60244ff9ef8 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -565,22 +565,6 @@ static void vmd_detach_resources(struct vmd_dev *vmd)
 	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
 }
 
-/*
- * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
- * Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of which the lower
- * 16 bits are the PCI Segment Group (domain) number.  Other bits are
- * currently reserved.
- */
-static int vmd_find_free_domain(void)
-{
-	int domain = 0xffff;
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL)
-		domain = max_t(int, domain, pci_domain_nr(bus));
-	return domain + 1;
-}
-
 static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 				resource_size_t *offset1,
 				resource_size_t *offset2)
@@ -865,13 +849,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};
 
-	sd->vmd_dev = vmd->dev;
-	sd->domain = vmd_find_free_domain();
-	if (sd->domain < 0)
-		return sd->domain;
-
-	sd->node = pcibus_to_node(vmd->dev->bus);
-
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
 	 * due to some missing interrupt remapping plumbing. This is probably
@@ -903,9 +880,17 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
 
+	sd->vmd_dev = vmd->dev;
+	sd->domain = pci_bus_find_emul_domain_nr(PCI_DOMAIN_NR_NOT_SET);
+	if (sd->domain < 0)
+		return sd->domain;
+
+	sd->node = pcibus_to_node(vmd->dev->bus);
+
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
 				       &vmd_ops, sd, &resources);
 	if (!vmd->bus) {
+		pci_bus_release_emul_domain_nr(sd->domain);
 		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
 		return -ENODEV;
@@ -998,6 +983,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
+	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
 	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
@@ -1063,6 +1049,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
 	ida_free(&vmd_instance_ida, vmd->instance);
+	pci_bus_release_emul_domain_nr(vmd->sysdata.domain);
 }
 
 static void vmd_shutdown(struct pci_dev *dev)
-- 
2.49.0


