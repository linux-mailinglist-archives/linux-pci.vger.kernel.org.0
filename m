Return-Path: <linux-pci+bounces-34850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A9B378D9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05897C1AFB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83CE30DEAC;
	Wed, 27 Aug 2025 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HY0Ceij7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DA30CDA0
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266699; cv=fail; b=KSgJL/1Eax7/b98PajCbPT7/0bnIiw2DqbGLPXjQai7kzqERukxMWLwcd7uqfcH5TPBA2pfkei0ePpXG81fk6zOmfYGWyJzpw1CfAYe7IYhXOIU3JWq/GsgOjyBjfK/nisthxelCOGbDTQap6HLDObGUJVH8OZbyEE0vQ6stBPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266699; c=relaxed/simple;
	bh=AkE0SbFC1uSMlqlh2mJ3zagpH96O9kbeZVZTgAF8yH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZasR2o9Xe+OqQ/+fDqNPiMydHt4DvEhbr+ll2i2HbVvnuzK2v1iLWvhbXNjJtxkh0obPR54ItXmRyIu6o49NuoURDl2+VFa4nWMWHZ5SjeRMNaIlLxU3n/3mW0FBv/ZHLE2gDr6P+Ng/pLVYR0rUxFZfpc6z/ouyJZZbdVa/Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HY0Ceij7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266697; x=1787802697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AkE0SbFC1uSMlqlh2mJ3zagpH96O9kbeZVZTgAF8yH8=;
  b=HY0Ceij7avfpfSMvEbiNKfOCMjqGv705KcNuTSJwjoKjJ8ZGe6zCyr5C
   fvZzjXOUIoLx/7TDARApXjSIZlEMqdh3I2/z8OfVShYaKkIpqHHlLhczy
   Ng4Kps/NvvSuBSU37zoYZ6unFZMFDrp6vn2qCszYad4j+KCmq5y94GkxA
   1rIKzCVayIduLoJhPOt8VftvToT8hSEE3zgDU85xCp7dlLRPLxtPqQ/z0
   xjJ4w0Q3fo43Pp1GthmaKBvdcLtgOBgorIXIsar/HtxjQA5SXnMNlhqr9
   JhZsthE5FaVyyehgGlnmpRp64AqqaZRrrmTbUFTdYg+1HI8hplTKusqCx
   A==;
X-CSE-ConnectionGUID: 86IqaDSuQWyZ0qtAQj2Pyw==
X-CSE-MsgGUID: SBaa2llZQGS9FsNZS+5UDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159120"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159120"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:35 -0700
X-CSE-ConnectionGUID: EyBxWFejQt+PObb32gI4GQ==
X-CSE-MsgGUID: bt04NuH/SBqAKcPdCQl4DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685098"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.72)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc66PXqrspQQ6dV2okj46mha65HwOzBco2p0+U9Tt+p0PIYPuEi3JEqlKFiP+nW7/fKqc1CiGvsLUq1Qpu744dVwJFzLf8mA81VaPO3vQiY3XjBG07+XyO3J/uI8wfuD/aFDC0Smcn0lDNSVSK2gAOMyByeefnnxUci0RHZ9QdIXMoWVkCMjKMB/KTsgENStngt413bTUx+a6/71zPZqbEqLwvVw6N+zFsAs3sZMAPXFY54BVsvy9X17sG6ZqpOz2n77T2AVDDWGoSfpBsvJN+wic7r5oX+4YHiwSBZPc8xOMuta6uTEb5UVLW/+8bzfu/8eC9tbztB8580v8Oe0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2/Ua5zGAlJGV22v+FsM+zF0TbYa5rcEZoXcal6wRac=;
 b=S5+fqaf7ojKjOF+gvLalLPZvWtWLdzPOiirRGHcqBLva+c1sZESEq0pgxJQetTPJNw8LNKEF8D7bfNHUA2XcDpDKTPscDOVxDXyo8BE8MDCVtYqiMAMOc+XGLZEQmQRyssITtFzpdSE+6mh/+iXRR8shClP+cF/mkW8HuyfPJfKP6vbbFxfwv0Ty5EzBm3PT5VpmEZkrhD6DqZ83FFOO9quBnNUw8xa76mDZELDks3uOla9e9yli4WRhtWkUr+2xoYHatNLmU22qF2fWBo9KH9vvsdiiOcAIJpV4VhQweARqT7YjyV/hhcOXtAUJQ2J0V5sBvb6etDEVUIpm3ddlvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:51:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:51:32 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Date: Tue, 26 Aug 2025 20:51:20 -0700
Message-ID: <20250827035126.1356683-5-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: fdcecfa9-5f9e-4a6b-6858-08dde51d02fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wyxgvwywma5JDeIMj4l2stoy2R7756DJCDsiqimdR4pFJuA7Kwgogv0KH6p+?=
 =?us-ascii?Q?cyheUEJUVlgiPajkut6J4lDCnr3QavxZgHjsymJ8MaiN10WsDJCw4elvqxf7?=
 =?us-ascii?Q?9Z2M7ehRH4dQpqpchVAdLYUE7M7+gN5GZ9y36caVCLe07SW/lSL8SRVE998k?=
 =?us-ascii?Q?xoYq7FA6cIjKsJbBY+KZfqRVrUDm3ookvwPYodUIKoZtw1svqjz+Dm84kiqo?=
 =?us-ascii?Q?YV3RR5sB2/tsDzZcHNDyXfc99cfmygeExARVNo3mFWYYvtaq05G3ZVquHKVQ?=
 =?us-ascii?Q?ju5/Vklw8UiQypPYUB9V44k+iFi1FlX5TyV2tyAansS6YCIgPueI97Mdve3P?=
 =?us-ascii?Q?P7gNMTJ2vH9gI3C5V0YMpM5kwA/8nl3GQMDkL1gFsl0/iuVOE4S05Qr3o7LS?=
 =?us-ascii?Q?jHx+lZZGpLQQf8jJpNVM8M3QhoQWTZPCB2BI1+j1IJHOfdbARk2sMHA4RaZR?=
 =?us-ascii?Q?B3nsu9tU/IWKvBFxZqraXNpEy5SPD7SUWZYfqJ29kh438gGaKryWyaR9ohhc?=
 =?us-ascii?Q?naehy2H6TTEkb4pp9MC8d4u/Txc9bMTZyGwfm3WeRnrWRtkgYxV+/WKFRYjH?=
 =?us-ascii?Q?E5E1vUVUsoEx4FElVUcx1hP8TsbipkoC+4BI84cYUmBEFdQ6OdGPJbHLgsUn?=
 =?us-ascii?Q?qMyGcm6RZsSFXiv1ozEbQzOVcGiYgCdzka/X6moULK5bExoMp6fB9KD3Q8IV?=
 =?us-ascii?Q?DN3JnXEfTAEXhr9xZru7D3BYblgTmpo2GUj9x7/JJs4iQkRo8IsFRgfUkjT2?=
 =?us-ascii?Q?Zp9r0B6D0L2bvfkXPif0v90DkCF9zvDWMh3xlp1pjSVhgNip29kC9s+B4v9j?=
 =?us-ascii?Q?lcfF1JFHScFj0oMklLMBlurV8PvQmToZdvE6ocug/AHxz5WbP12ituOlTtLy?=
 =?us-ascii?Q?7bc4NWrscQNm7FzAEG5zP3ewHjr42qU4KeKekHdp+KG9RnXY/Gab5RL6yDM+?=
 =?us-ascii?Q?WHPo2Cc0WVx0UobB2bIHCVdyCx8G0y4xiLjjlEhFdDC+scGKewDqPVNu5JdN?=
 =?us-ascii?Q?cAdR7FjRKCwwbCPmW87Gp8r4i+9WMpXiVADgaCdLcvCscuOYK8im37Yo0RGy?=
 =?us-ascii?Q?HrVXM1052NHZXFyFV6j+y6tGEaHKBKmWFuZvK1/98hf8kZb89lsOUPsPW4Op?=
 =?us-ascii?Q?DADGzYebCTCe73ABMG4eNtU6E1Qr/34qLK5UtcA8ecR8aVRUd96nlAUAWlW0?=
 =?us-ascii?Q?T61vX1tXIgHtEHv3Y6o+R5LBO+7Z45cCi06I5ky8DUrspVL324Ehn069pifr?=
 =?us-ascii?Q?4X9YC5uuwm4BcbvYXHAQp60twnS2yMDIEDht0sX2XaHE9/WxeR2yE4NevfOu?=
 =?us-ascii?Q?zz5hUias+OXXn8ZKK4wYYUeeVNC1iFIkZiChWiY2sGhnnHD4YnpoHqxUtMeo?=
 =?us-ascii?Q?q8HxZyFVDAjhgbzOsAThT2W/RXZ4fsZdCG+mGjK/VNwwWr3kHxU9QGO0IIHq?=
 =?us-ascii?Q?RrpsjC5iB2c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q4pKq/N+2e6ULLNQPXY2+OuirzNMboOyRDqwdGFqKfJEfiZlcu9ljKWWv8YP?=
 =?us-ascii?Q?trBETgD1iJiJh1zy9cobssr7xMyh/5tyk9VAI+3Tc5/FqX+8R54+n+xml5+K?=
 =?us-ascii?Q?+I7tPseKdhN1bJ7DMEv3i2SF4yFA30SLznpFkAMDjEv6q2vu/n/TADAfN9ub?=
 =?us-ascii?Q?yFCDy0R4ZoBlYDnPbJWiPuz593zxu6oGVAAGzdwAu/GQ16VYZgeCZ0nc3+jb?=
 =?us-ascii?Q?2CICbovsDw48RV8UaIn+Rh30C/Q6p+jrY3hJaMmoI4TTb0RU7jaLSBoFtlXF?=
 =?us-ascii?Q?FHY0MDumo9LasKFoUXMNiYVqT4o3j9JMocdOmttIb3iGDH0gQHz2Y3B9IE7O?=
 =?us-ascii?Q?wBL2QxZtWSfB/RbvIX3HNPsmoD7HpV210/Mv4MPPBR8p8AI9+3d10EUXvYS1?=
 =?us-ascii?Q?4dqpeuKWjHTXGoDAsJvPW4tdP/wYzaqRoCsOMEF4p5rVB7DzBXh2fQu8V+ez?=
 =?us-ascii?Q?Pok3Ww0At6fYEwkVXES54jtziMZ3OqdGgBXO/zs8s1skLXsjRTTvLrQMg012?=
 =?us-ascii?Q?bQEhhBaYz91FELPkjy9rqyl7751SWPKfsh9P6zwb73QO9FvuuBIIp2JGpiZ9?=
 =?us-ascii?Q?NWbEb+zew9cPMnAdmiF2Mg+oHAsq3kE8LCHTd46ofQ3YyP9SQ5vTXsndu7Vl?=
 =?us-ascii?Q?7O7NxecCJjpyStDHlYzWjIptwLjmMYPVlmu1FII6P5NHzb4fxvlLy2cJn4OD?=
 =?us-ascii?Q?SBFjwuXmzs9YS9jrTTuwZAtDTeUD6A8F8RNsYBkErupAUTMCzcIp6xg+aNn/?=
 =?us-ascii?Q?HYjJ9q69z302VfuZh5gDxKtcpSOEMQ8wDsaTVUtwhcCmTIXuSxulHxuAb8i9?=
 =?us-ascii?Q?Uk8RVWkWsQjGmvY7qKD5f7V6W9vPIw9hV/tgjYsaDfOUk1d5ig1kUn4AuV8V?=
 =?us-ascii?Q?LScDdzQDVN2yKrMZ3MlNE+fRcNNm2hbudpXI1d4pdAO4W1mn4KYbmkZaGLPr?=
 =?us-ascii?Q?SgioISmCXWUCE+Z+kFUXKB7eeEHCKwQn6iNtTKCQGZ++4oOtkBBVtucP3Fjl?=
 =?us-ascii?Q?x2DMSYVhVsmgvn7qPSY0kWYFlON41o72tM3UATRCEZydg6Ug+5Eyb7JYKact?=
 =?us-ascii?Q?La85PA/ensufvm92PWNkJhBAUTrtA1kgvg8/KpfN0UOOnXezz2pa5ISqzaxO?=
 =?us-ascii?Q?Vzegnei+Yzw5ZmhRmZcQzjiS0DFJD2xfm1gp0Hz6oQ4OJOKBf5WJ19zn5peD?=
 =?us-ascii?Q?MU+H9QQBVFfF54Lf06BbRzxtKE7mLAAQVqfkCL57lk6tiuIjc0JCTASGBwaW?=
 =?us-ascii?Q?q/lBpRYrnkAZCspe60jOCIv2FQShZm9oTULpb0NBRn4V8T9lgrW0e3eeUnIH?=
 =?us-ascii?Q?8JHqpboDy5DLK8P8YhlZOv2hJ3aB5hv22ZutE9aybLSYBwHVBP1G5b7jYISg?=
 =?us-ascii?Q?HhZ1kMPqpZTqaOLEeK424F1LnEM9YH9g66JlRWbWp7CeAvvGwNBVwK0BChDM?=
 =?us-ascii?Q?s9iyUJ44DbS9ggp1mS9oejJcsTkgVukChg16PreXfmjtYPTJ0+ZsFucEXKIk?=
 =?us-ascii?Q?Ig4PXM/BvFK97zUwxCmJB+LYRL2O2hweHpzVJKuYeNfLFYv4335QSIfo7iBB?=
 =?us-ascii?Q?lAt99aDOhHqvcVKwEfQP7x49W6J6s/IeHEGsAwjSX2XgaPQYGL1/5QYjKeHI?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcecfa9-5f9e-4a6b-6858-08dde51d02fa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:32.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sr7z4agxGXfBZNgcd2KZP4DJr5sT8//SqFooer2yjVLkpbgfVoIFFnVeQ08OW6GpMWVTZwyp48g2BWrpe9NU1pZnkZvM/+et5Y/6fCnfaak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

The PCIe 7.0 specification, section 11, defines the Trusted Execution
Environment (TEE) Device Interface Security Protocol (TDISP).  This
protocol definition builds upon Component Measurement and Authentication
(CMA), and link Integrity and Data Encryption (IDE). It adds support for
assigning devices (PCI physical or virtual function) to a confidential VM
such that the assigned device is enabled to access guest private memory
protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
CCA.

The "TSM" (TEE Security Manager) is a concept in the TDISP specification
of an agent that mediates between a "DSM" (Device Security Manager) and
system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
to setup link security and assign devices. A confidential VM uses TSM
ABIs to transition an assigned device into the TDISP "RUN" state and
validate its configuration. From a Linux perspective the TSM abstracts
many of the details of TDISP, IDE, and CMA. Some of those details leak
through at times, but for the most part TDISP is an internal
implementation detail of the TSM.

CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
Userspace can watch for the arrival of a "TSM" device,
/sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
initialized TSM services.

The operations that can be executed against a PCI device are split into
two mutually exclusive operation sets, "Link" and "Security" (struct
pci_tsm_{link,security}_ops). The "Link" operations manage physical link
security properties and communication with the device's Device Security
Manager firmware. These are the host side operations in TDISP. The
"Security" operations coordinate the security state of the assigned
virtual device (TDI). These are the guest side operations in TDISP. Only
link management operations are defined at this stage and placeholders
provided for the security operations.

The locking allows for multiple devices to be executing commands
simultaneously, one outstanding command per-device and an rwsem
synchronizes the implementation relative to TSM
registration/unregistration events.

Thanks to Wu Hao for his work on an early draft of this support.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  51 ++
 Documentation/driver-api/pci/index.rst  |   1 +
 Documentation/driver-api/pci/tsm.rst    |  12 +
 MAINTAINERS                             |   4 +-
 drivers/pci/Kconfig                     |  15 +
 drivers/pci/Makefile                    |   1 +
 drivers/pci/doe.c                       |   2 -
 drivers/pci/pci-sysfs.c                 |   4 +
 drivers/pci/pci.h                       |  10 +
 drivers/pci/probe.c                     |   3 +
 drivers/pci/remove.c                    |   6 +
 drivers/pci/tsm.c                       | 601 ++++++++++++++++++++++++
 drivers/virt/coco/tsm-core.c            |  49 +-
 include/linux/pci-doe.h                 |   4 +
 include/linux/pci-tsm.h                 | 143 ++++++
 include/linux/pci.h                     |   3 +
 include/linux/tsm.h                     |   6 +-
 include/uapi/linux/pci_regs.h           |   1 +
 18 files changed, 910 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/driver-api/pci/tsm.rst
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 include/linux/pci-tsm.h

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 69f952fffec7..e0c8dad8d889 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -612,3 +612,54 @@ Description:
 
 		  # ls doe_features
 		  0001:01        0001:02        doe_discovery
+
+What:		/sys/bus/pci/devices/.../tsm/
+Contact:	linux-coco@lists.linux.dev
+Description:
+		This directory only appears if a physical device function
+		supports authentication (PCIe CMA-SPDM), interface security
+		(PCIe TDISP), and is accepted for secure operation by the
+		platform TSM driver. This attribute directory appears
+		dynamically after the platform TSM driver loads. So, only after
+		the /sys/class/tsm/tsm0 device arrives can tools assume that
+		devices without a tsm/ attribute directory will never have one;
+		before that, the security capabilities of the device relative to
+		the platform TSM are unknown. See
+		Documentation/ABI/testing/sysfs-class-tsm.
+
+What:		/sys/bus/pci/devices/.../tsm/connect
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) Write the name of a TSM (TEE Security Manager) device from
+		/sys/class/tsm to this file to establish a connection with the
+		device.  This typically includes an SPDM (DMTF Security
+		Protocols and Data Models) session over PCIe DOE (Data Object
+		Exchange) and may also include PCIe IDE (Integrity and Data
+		Encryption) establishment. Reads from this attribute return the
+		name of the connected TSM or the empty string if not
+		connected. A TSM device signals its readiness to accept PCI
+		connection via a KOBJ_CHANGE event.
+
+What:		/sys/bus/pci/devices/.../tsm/disconnect
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Write the name of the TSM device that was specified
+		to 'connect' to teardown the connection.
+
+What:		/sys/bus/pci/devices/.../authenticated
+Contact:	linux-pci@vger.kernel.org
+Description:
+		When the device's tsm/ directory is present device
+		authentication (PCIe CMA-SPDM) and link encryption (PCIe IDE)
+		are handled by the platform TSM (TEE Security Manager). When the
+		tsm/ directory is not present this attribute reflects only the
+		native CMA-SPDM authentication state with the kernel's
+		certificate store.
+
+		If the attribute is not present, it indicates that
+		authentication is unsupported by the device, or the TSM has no
+		available authentication methods for the device.
+
+		When present and the tsm/ attribute directory is present, the
+		authenticated attribute is an alias for the device 'connect'
+		state. See the 'tsm/connect' attribute for more details.
diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
index a38e475cdbe3..9e1b801d0f74 100644
--- a/Documentation/driver-api/pci/index.rst
+++ b/Documentation/driver-api/pci/index.rst
@@ -10,6 +10,7 @@ The Linux PCI driver implementer's API guide
 
    pci
    p2pdma
+   tsm
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/pci/tsm.rst b/Documentation/driver-api/pci/tsm.rst
new file mode 100644
index 000000000000..59b94d79a4f2
--- /dev/null
+++ b/Documentation/driver-api/pci/tsm.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+========================================================
+PCI Trusted Execution Environment Security Manager (TSM)
+========================================================
+
+.. kernel-doc:: include/linux/pci-tsm.h
+   :internal:
+
+.. kernel-doc:: drivers/pci/tsm.c
+   :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index 024b18244c65..f1aabab88c79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25619,8 +25619,10 @@ L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
 F:	Documentation/driver-api/coco/
+F:	Documentation/driver-api/pci/tsm.rst
+F:	drivers/pci/tsm.c
 F:	drivers/virt/coco/guest/
-F:	include/linux/tsm*.h
+F:	include/linux/*tsm*.h
 F:	samples/tsm-mr/
 
 TRUSTED SERVICES TEE DRIVER
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 105b72b93613..0183ca6f6954 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -136,6 +136,21 @@ config PCI_IDE_STREAM_MAX
 	  platform capability for the foreseeable future is 4 to 8 streams. Bump
 	  this value up if you have an expert testing need.
 
+config PCI_TSM
+	bool "PCI TSM: Device security protocol support"
+	select PCI_IDE
+	select PCI_DOE
+	select TSM
+	help
+	  The TEE (Trusted Execution Environment) Device Interface
+	  Security Protocol (TDISP) defines a "TSM" as a platform agent
+	  that manages device authentication, link encryption, link
+	  integrity protection, and assignment of PCI device functions
+	  (virtual or physical) to confidential computing VMs that can
+	  access (DMA) guest private memory.
+
+	  Enable a platform TSM driver to use this capability.
+
 config PCI_DOE
 	bool "Enable PCI Data Object Exchange (DOE) support"
 	help
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 6612256fd37d..2c545f877062 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_IDE)		+= ide.o
+obj-$(CONFIG_PCI_TSM)		+= tsm.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index aae9a8a00406..62be9c8dbc52 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -24,8 +24,6 @@
 
 #include "pci.h"
 
-#define PCI_DOE_FEATURE_DISCOVERY 0
-
 /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
 #define PCI_DOE_TIMEOUT HZ
 #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5eea14c1f7f5..367ca1bc5470 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1815,6 +1815,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCI_DOE
 	&pci_doe_sysfs_group,
+#endif
+#ifdef CONFIG_PCI_TSM
+	&pci_tsm_auth_attr_group,
+	&pci_tsm_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 56851e73439b..0e24262aa4ba 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -525,6 +525,16 @@ void pci_ide_init(struct pci_dev *dev);
 static inline void pci_ide_init(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_PCI_TSM
+void pci_tsm_init(struct pci_dev *pdev);
+void pci_tsm_destroy(struct pci_dev *pdev);
+extern const struct attribute_group pci_tsm_attr_group;
+extern const struct attribute_group pci_tsm_auth_attr_group;
+#else
+static inline void pci_tsm_init(struct pci_dev *pdev) { }
+static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4fd6942ea6a8..7207f9a76a3e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2738,6 +2738,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
 
+	/* Establish pdev->tsm for newly added (e.g. new SR-IOV VFs) */
+	pci_tsm_init(dev);
+
 	pci_npem_create(dev);
 
 	pci_doe_sysfs_init(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 445afdfa6498..4b9ad199389b 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -55,6 +55,12 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
 
+	/*
+	 * While device is in D0 drop the device from TSM link operations
+	 * including unbind and disconnect (IDE + SPDM teardown).
+	 */
+	pci_tsm_destroy(dev);
+
 	device_del(&dev->dev);
 
 	down_write(&pci_bus_sem);
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
new file mode 100644
index 000000000000..092e81c5208c
--- /dev/null
+++ b/drivers/pci/tsm.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TEE Security Manager for the TEE Device Interface Security Protocol
+ * (TDISP, PCIe r6.1 sec 11)
+ *
+ * Copyright(c) 2024 Intel Corporation. All rights reserved.
+ */
+
+#define dev_fmt(fmt) "PCI/TSM: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pci-tsm.h>
+#include <linux/sysfs.h>
+#include <linux/tsm.h>
+#include <linux/xarray.h>
+#include "pci.h"
+
+/*
+ * Provide a read/write lock against the init / exit of pdev tsm
+ * capabilities and arrival/departure of a TSM instance
+ */
+static DECLARE_RWSEM(pci_tsm_rwsem);
+
+/*
+ * Count of TSMs registered that support physical link operations vs device
+ * security state management.
+ */
+static int pci_tsm_link_count;
+static int pci_tsm_devsec_count;
+
+static inline bool is_dsm(struct pci_dev *pdev)
+{
+	return pdev->tsm && pdev->tsm->dsm == pdev;
+}
+
+/* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm == ->pdev (self) */
+static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
+{
+	struct pci_dev *pdev = pci_tsm->pdev;
+
+	if (!is_pci_tsm_pf0(pdev) || !is_dsm(pdev)) {
+		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");
+		return NULL;
+	}
+
+	return container_of(pci_tsm, struct pci_tsm_pf0, base);
+}
+
+static void tsm_remove(struct pci_tsm *tsm)
+{
+	struct pci_dev *pdev;
+
+	if (!tsm)
+		return;
+
+	pdev = tsm->pdev;
+	tsm->ops->remove(tsm);
+	pdev->tsm = NULL;
+}
+DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
+
+static void pci_tsm_walk_fns(struct pci_dev *pdev,
+			     int (*cb)(struct pci_dev *pdev, void *data),
+			     void *data)
+{
+	/* Walk subordinate physical functions */
+	for (int i = 0; i < 8; i++) {
+		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
+			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
+
+		if (!pf)
+			continue;
+
+		/* on entry function 0 has already run @cb */
+		if (i > 0)
+			cb(pf, data);
+
+		/* walk virtual functions of each pf */
+		for (int j = 0; j < pci_num_vf(pf); j++) {
+			struct pci_dev *vf __free(pci_dev_put) =
+				pci_get_domain_bus_and_slot(
+					pci_domain_nr(pf->bus),
+					pci_iov_virtfn_bus(pf, j),
+					pci_iov_virtfn_devfn(pf, j));
+
+			if (!vf)
+				continue;
+
+			cb(vf, data);
+		}
+	}
+
+	/*
+	 * Walk downstream devices, assumes that an upstream DSM is
+	 * limited to downstream physical functions
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
+		pci_walk_bus(pdev->subordinate, cb, data);
+}
+
+static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
+				     int (*cb)(struct pci_dev *pdev,
+					       void *data),
+				     void *data)
+{
+	/* Reverse walk downstream devices */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
+		pci_walk_bus_reverse(pdev->subordinate, cb, data);
+
+	/* Reverse walk subordinate physical functions */
+	for (int i = 7; i >= 0; i--) {
+		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
+			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
+
+		if (!pf)
+			continue;
+
+		/* reverse walk virtual functions */
+		for (int j = pci_num_vf(pf) - 1; j >= 0; j--) {
+			struct pci_dev *vf __free(pci_dev_put) =
+				pci_get_domain_bus_and_slot(
+					pci_domain_nr(pf->bus),
+					pci_iov_virtfn_bus(pf, j),
+					pci_iov_virtfn_devfn(pf, j));
+
+			if (!vf)
+				continue;
+			cb(vf, data);
+		}
+
+		/* on exit, caller will run @cb on function 0 */
+		if (i > 0)
+			cb(pf, data);
+	}
+}
+
+static int probe_fn(struct pci_dev *pdev, void *dsm)
+{
+	struct pci_dev *dsm_dev = dsm;
+	const struct pci_tsm_ops *ops = dsm_dev->tsm->ops;
+
+	pdev->tsm = ops->probe(pdev);
+	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
+		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
+	return 0;
+}
+
+static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
+{
+	int rc;
+	struct pci_tsm_pf0 *tsm_pf0;
+	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
+	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(pdev);
+
+	/* connect()  mutually exclusive with subfunction pci_tsm_init() */
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+
+	if (!pci_tsm)
+		return -ENXIO;
+
+	pdev->tsm = pci_tsm;
+	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+
+	/* mutex_intr assumes connect() is always sysfs/user driven */
+	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
+		return rc;
+
+	rc = ops->connect(pdev);
+	if (rc)
+		return rc;
+
+	pdev->tsm = no_free_ptr(pci_tsm);
+
+	/*
+	 * Now that the DSM is established, probe() all the potential
+	 * dependent functions. Failure to probe a function is not fatal
+	 * to connect(), it just disables subsequent security operations
+	 * for that function.
+	 */
+	pci_tsm_walk_fns(pdev, probe_fn, pdev);
+	return 0;
+}
+
+static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return sysfs_emit(buf, "\n");
+
+	return sysfs_emit(buf, "%s\n", tsm_name(pdev->tsm->ops->owner));
+}
+
+/* Is @tsm_dev managing physical link / session properties... */
+static bool is_link_tsm(struct tsm_dev *tsm_dev)
+{
+	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
+
+	return ops && ops->link_ops.probe;
+}
+
+/* ...or is @tsm_dev managing device security state ? */
+static bool is_devsec_tsm(struct tsm_dev *tsm_dev)
+{
+	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
+
+	return ops && ops->devsec_ops.lock;
+}
+
+static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tsm_dev *tsm_dev;
+	int rc, id;
+
+	rc = sscanf(buf, "tsm%d\n", &id);
+	if (rc != 1)
+		return -EINVAL;
+
+	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
+		return rc;
+
+	if (pdev->tsm)
+		return -EBUSY;
+
+	tsm_dev = find_tsm_dev(id);
+	if (!is_link_tsm(tsm_dev))
+		return -ENXIO;
+
+	rc = pci_tsm_connect(pdev, tsm_dev);
+	if (rc)
+		return rc;
+	return len;
+}
+static DEVICE_ATTR_RW(connect);
+
+static int remove_fn(struct pci_dev *pdev, void *data)
+{
+	tsm_remove(pdev->tsm);
+	return 0;
+}
+
+static void __pci_tsm_disconnect(struct pci_dev *pdev)
+{
+	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	const struct pci_tsm_ops *ops = pdev->tsm->ops;
+
+	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+
+	/*
+	 * disconnect() is uninterruptible as it may be called for device
+	 * teardown
+	 */
+	guard(mutex)(&tsm_pf0->lock);
+	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
+	ops->disconnect(pdev);
+}
+
+static void pci_tsm_disconnect(struct pci_dev *pdev)
+{
+	__pci_tsm_disconnect(pdev);
+	tsm_remove(pdev->tsm);
+}
+
+static ssize_t disconnect_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	const struct pci_tsm_ops *ops;
+	int rc;
+
+	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return -ENXIO;
+
+	ops = pdev->tsm->ops;
+	if (!sysfs_streq(buf, tsm_name(ops->owner)))
+		return -EINVAL;
+
+	pci_tsm_disconnect(pdev);
+	return len;
+}
+static DEVICE_ATTR_WO(disconnect);
+
+/* The 'authenticated' attribute is exclusive to the presence of a 'link' TSM */
+static bool pci_tsm_link_group_visible(struct kobject *kobj)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return pci_tsm_link_count && is_pci_tsm_pf0(pdev);
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_link);
+
+/*
+ * 'link' and 'devsec' TSMs share the same 'tsm/' sysfs group, so the TSM type
+ * specific attributes need individual visibility checks.
+ */
+static umode_t pci_tsm_attr_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	if (pci_tsm_link_group_visible(kobj)) {
+		if (attr == &dev_attr_connect.attr ||
+		    attr == &dev_attr_disconnect.attr)
+			return attr->mode;
+	}
+
+	return 0;
+}
+
+static bool pci_tsm_group_visible(struct kobject *kobj)
+{
+	return pci_tsm_link_group_visible(kobj);
+}
+DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
+
+static struct attribute *pci_tsm_attrs[] = {
+	&dev_attr_connect.attr,
+	&dev_attr_disconnect.attr,
+	NULL
+};
+
+const struct attribute_group pci_tsm_attr_group = {
+	.name = "tsm",
+	.attrs = pci_tsm_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
+};
+
+static ssize_t authenticated_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	/*
+	 * When the SPDM session established via TSM the 'authenticated' state
+	 * of the device is identical to the connect state.
+	 */
+	return connect_show(dev, attr, buf);
+}
+static DEVICE_ATTR_RO(authenticated);
+
+static struct attribute *pci_tsm_auth_attrs[] = {
+	&dev_attr_authenticated.attr,
+	NULL
+};
+
+const struct attribute_group pci_tsm_auth_attr_group = {
+	.attrs = pci_tsm_auth_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_link),
+};
+
+/*
+ * Retrieve physical function0 device whether it has TEE capability or not
+ */
+static struct pci_dev *pf0_dev_get(struct pci_dev *pdev)
+{
+	struct pci_dev *pf_dev = pci_physfn(pdev);
+
+	if (PCI_FUNC(pf_dev->devfn) == 0)
+		return pci_dev_get(pf_dev);
+
+	return pci_get_slot(pf_dev->bus,
+			    pf_dev->devfn - PCI_FUNC(pf_dev->devfn));
+}
+
+/*
+ * Find the PCI Device instance that serves as the Device Security Manager (DSM)
+ * for @pdev. Note that no additional reference is held for the resulting device
+ * because @pdev always has a longer registered lifetime than its DSM by virtue
+ * of being a child of, or identical to, its DSM.
+ */
+static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
+{
+	struct device *grandparent;
+	struct pci_dev *uport;
+
+	if (is_pci_tsm_pf0(pdev))
+		return pdev;
+
+	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
+	if (!pf0)
+		return NULL;
+
+	if (is_dsm(pf0))
+		return pf0;
+
+	/*
+	 * For cases where a switch may be hosting TDISP services on behalf of
+	 * downstream devices, check the first upstream port relative to this
+	 * endpoint.
+	 */
+	if (!pdev->dev.parent)
+		return NULL;
+	grandparent = pdev->dev.parent->parent;
+	if (!grandparent)
+		return NULL;
+	if (!dev_is_pci(grandparent))
+		return NULL;
+	uport = to_pci_dev(grandparent);
+	if (!pci_is_pcie(uport) ||
+	    pci_pcie_type(uport) != PCI_EXP_TYPE_UPSTREAM)
+		return NULL;
+
+	if (is_dsm(uport))
+		return uport;
+	return NULL;
+}
+
+/**
+ * pci_tsm_link_constructor() - base 'struct pci_tsm' initialization for link TSMs
+ * @pdev: The PCI device
+ * @tsm: context to initialize
+ * @ops: PCI link operations provided by the TSM
+ */
+int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
+			     const struct pci_tsm_ops *ops)
+{
+	if (!is_link_tsm(ops->owner))
+		return -EINVAL;
+
+	tsm->dsm = find_dsm_dev(pdev);
+	if (!tsm->dsm) {
+		pci_warn(pdev, "failed to find Device Security Manager\n");
+		return -ENXIO;
+	}
+	tsm->pdev = pdev;
+	tsm->ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_link_constructor);
+
+/**
+ * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' (DSM) initialization
+ * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
+ * @tsm: context to initialize
+ * @ops: PCI link operations provided by the TSM
+ */
+int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
+			    const struct pci_tsm_ops *ops)
+{
+	mutex_init(&tsm->lock);
+	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					   PCI_DOE_PROTO_CMA);
+	if (!tsm->doe_mb) {
+		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
+		return -ENODEV;
+	}
+
+	return pci_tsm_link_constructor(pdev, &tsm->base, ops);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);
+
+void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
+{
+	mutex_destroy(&pf0_tsm->lock);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
+
+static void pf0_sysfs_enable(struct pci_dev *pdev)
+{
+	bool tee = pdev->devcap & PCI_EXP_DEVCAP_TEE;
+
+	pci_dbg(pdev, "Device Security Manager detected (%s%s%s)\n",
+		pdev->ide_cap ? "IDE" : "", pdev->ide_cap && tee ? " " : "",
+		tee ? "TEE" : "");
+
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+}
+
+int pci_tsm_register(struct tsm_dev *tsm_dev)
+{
+	struct pci_dev *pdev = NULL;
+
+	if (!tsm_dev)
+		return -EINVAL;
+
+	/*
+	 * The TSM device must have pci_ops, and only implement one of link_ops
+	 * or devsec_ops.
+	 */
+	if (!tsm_pci_ops(tsm_dev))
+		return -EINVAL;
+
+	if (!is_link_tsm(tsm_dev) && !is_devsec_tsm(tsm_dev))
+		return -EINVAL;
+
+	if (is_link_tsm(tsm_dev) && is_devsec_tsm(tsm_dev))
+		return -EINVAL;
+
+	guard(rwsem_write)(&pci_tsm_rwsem);
+
+	/* on first enable, update sysfs groups */
+	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
+		for_each_pci_dev(pdev)
+			if (is_pci_tsm_pf0(pdev))
+				pf0_sysfs_enable(pdev);
+	} else if (is_devsec_tsm(tsm_dev)) {
+		pci_tsm_devsec_count++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_register);
+
+/**
+ * __pci_tsm_destroy() - destroy the TSM context for @pdev
+ * @pdev: device to cleanup
+ * @tsm_dev: TSM context if a TSM device is being removed, NULL if
+ *	     @pdev is being removed.
+ *
+ * At device removal or TSM unregistration all established context
+ * with the TSM is torn down. Additionally, if there are no more TSMs
+ * registered, the PCI tsm/ sysfs attributes are hidden.
+ */
+static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
+{
+	struct pci_tsm *tsm = pdev->tsm;
+
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+
+	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count) {
+		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+	}
+
+	if (!tsm)
+		return;
+
+	if (!tsm_dev)
+		tsm_dev = tsm->ops->owner;
+	else if (tsm_dev != tsm->ops->owner)
+		return;
+
+	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev))
+		pci_tsm_disconnect(pdev);
+	else
+		tsm_remove(pdev->tsm);
+}
+
+void pci_tsm_destroy(struct pci_dev *pdev)
+{
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	__pci_tsm_destroy(pdev, NULL);
+}
+
+void pci_tsm_init(struct pci_dev *pdev)
+{
+	guard(rwsem_read)(&pci_tsm_rwsem);
+
+	/*
+	 * Subfunctions are either probed synchronous with connect() or later
+	 * when either the SR-IOV configuration is changed, or, unlikely,
+	 * connect() raced initial bus scanning.
+	 */
+	if (pdev->tsm)
+		return;
+
+	if (pci_tsm_link_count) {
+		struct pci_dev *dsm = find_dsm_dev(pdev);
+
+		if (!dsm)
+			return;
+
+		/*
+		 * The only path to init a Device Security Manager capable
+		 * device is via connect().
+		 */
+		if (!dsm->tsm)
+			return;
+
+		probe_fn(pdev, dsm);
+	}
+}
+
+void pci_tsm_unregister(struct tsm_dev *tsm_dev)
+{
+	struct pci_dev *pdev = NULL;
+
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	if (is_link_tsm(tsm_dev))
+		pci_tsm_link_count--;
+	if (is_devsec_tsm(tsm_dev))
+		pci_tsm_devsec_count--;
+	for_each_pci_dev_reverse(pdev)
+		__pci_tsm_destroy(pdev, tsm_dev);
+}
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index a64b776642cf..6fdcf23d57ec 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/pci-tsm.h>
 
 static struct class *tsm_class;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -17,8 +18,28 @@ static DEFINE_IDR(tsm_idr);
 struct tsm_dev {
 	struct device dev;
 	int id;
+	const struct pci_tsm_ops *pci_ops;
 };
 
+const char *tsm_name(const struct tsm_dev *tsm_dev)
+{
+	return dev_name(&tsm_dev->dev);
+}
+
+/* Caller responsible for ensuring it does not race tsm_dev unregistration */
+struct tsm_dev *find_tsm_dev(int id)
+{
+	guard(rcu)();
+	return idr_find(&tsm_idr, id);
+}
+
+const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev)
+{
+	if (!tsm_dev)
+		return NULL;
+	return tsm_dev->pci_ops;
+}
+
 static struct tsm_dev *alloc_tsm_dev(struct device *parent)
 {
 	struct tsm_dev *tsm_dev __free(kfree) =
@@ -42,6 +63,29 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
 	return no_free_ptr(tsm_dev);
 }
 
+static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
+						 struct pci_tsm_ops *pci_ops)
+{
+	int rc;
+
+	if (!pci_ops)
+		return tsm_dev;
+
+	pci_ops->owner = tsm_dev;
+	tsm_dev->pci_ops = pci_ops;
+	rc = pci_tsm_register(tsm_dev);
+	if (rc) {
+		dev_err(tsm_dev->dev.parent,
+			"PCI/TSM registration failure: %d\n", rc);
+		device_unregister(&tsm_dev->dev);
+		return ERR_PTR(rc);
+	}
+
+	/* Notify TSM userspace that PCI/TSM operations are now possible */
+	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
+	return tsm_dev;
+}
+
 static void put_tsm_dev(struct tsm_dev *tsm_dev)
 {
 	if (!IS_ERR_OR_NULL(tsm_dev))
@@ -51,7 +95,7 @@ static void put_tsm_dev(struct tsm_dev *tsm_dev)
 DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
 	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
 
-struct tsm_dev *tsm_register(struct device *parent)
+struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
 {
 	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
 	struct device *dev;
@@ -69,12 +113,13 @@ struct tsm_dev *tsm_register(struct device *parent)
 	if (rc)
 		return ERR_PTR(rc);
 
-	return no_free_ptr(tsm_dev);
+	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
 }
 EXPORT_SYMBOL_GPL(tsm_register);
 
 void tsm_unregister(struct tsm_dev *tsm_dev)
 {
+	pci_tsm_unregister(tsm_dev);
 	device_unregister(&tsm_dev->dev);
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 1f14aed4354b..7d839f4a6340 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -15,6 +15,10 @@
 
 struct pci_doe_mb;
 
+#define PCI_DOE_FEATURE_DISCOVERY 0
+#define PCI_DOE_PROTO_CMA 1
+#define PCI_DOE_PROTO_SSESSION 2
+
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
new file mode 100644
index 000000000000..e4f9ea4a54a9
--- /dev/null
+++ b/include/linux/pci-tsm.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PCI_TSM_H
+#define __PCI_TSM_H
+#include <linux/mutex.h>
+#include <linux/pci.h>
+
+struct pci_tsm;
+
+/*
+ * struct pci_tsm_ops - manage confidential links and security state
+ * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
+ *	      Provide a secure session transport for TDISP state management
+ *	      (typically bare metal physical function operations).
+ * @sec_ops: Lock, unlock, and interrogate the security state of the
+ *	     function via the platform TSM (typically virtual function
+ *	     operations).
+ * @owner: Back reference to the TSM device that owns this instance.
+ *
+ * This operations are mutually exclusive either a tsm_dev instance
+ * manages physical link properties or it manages function security
+ * states like TDISP lock/unlock.
+ */
+struct pci_tsm_ops {
+	/*
+	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
+	 * @probe: allocate context (wrap 'struct pci_tsm') for follow-on link
+	 *	   operations
+	 * @remove: destroy link operations context
+	 * @connect: establish / validate a secure connection (e.g. IDE)
+	 *	     with the device
+	 * @disconnect: teardown the secure link
+	 *
+	 * Context: @probe, @remove, @connect, and @disconnect run under
+	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
+	 * mutual exclusion of @connect and @disconnect. @connect and
+	 * @disconnect additionally run under the DSM lock (struct
+	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
+	 */
+	struct_group_tagged(pci_tsm_link_ops, link_ops,
+		struct pci_tsm *(*probe)(struct pci_dev *pdev);
+		void (*remove)(struct pci_tsm *tsm);
+		int (*connect)(struct pci_dev *pdev);
+		void (*disconnect)(struct pci_dev *pdev);
+	);
+
+	/*
+	 * struct pci_tsm_security_ops - Manage the security state of the function
+	 * @lock: probe and initialize the device in the LOCKED state
+	 * @unlock: destroy TSM context and return device to UNLOCKED state
+	 *
+	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
+	 * sync with TSM unregistration and each other
+	 */
+	struct_group_tagged(pci_tsm_security_ops, devsec_ops,
+		struct pci_tsm *(*lock)(struct pci_dev *pdev);
+		void (*unlock)(struct pci_dev *pdev);
+	);
+	struct tsm_dev *owner;
+};
+
+/**
+ * struct pci_tsm - Core TSM context for a given PCIe endpoint
+ * @pdev: Back ref to device function, distinguishes type of pci_tsm context
+ * @dsm: PCI Device Security Manager for link operations on @pdev
+ * @ops: Link Confidentiality or Device Function Security operations
+ *
+ * This structure is wrapped by low level TSM driver data and returned by
+ * probe()/lock(), it is freed by the corresponding remove()/unlock().
+ *
+ * For link operations it serves to cache the association between a Device
+ * Security Manager (DSM) and the functions that manager can assign to a TVM.
+ * That can be "self", for assigning function0 of a TEE I/O device, a
+ * sub-function (SR-IOV virtual function, or non-function0
+ * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
+ * DSM).
+ */
+struct pci_tsm {
+	struct pci_dev *pdev;
+	struct pci_dev *dsm;
+	const struct pci_tsm_ops *ops;
+};
+
+/**
+ * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
+ * @base: generic core "tsm" context
+ * @lock: mutual exclustion for pci_tsm_ops invocation
+ * @doe_mb: PCIe Data Object Exchange mailbox
+ */
+struct pci_tsm_pf0 {
+	struct pci_tsm base;
+	struct mutex lock;
+	struct pci_doe_mb *doe_mb;
+};
+
+/* physical function0 and capable of 'connect' */
+static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pdev->is_virtfn)
+		return false;
+
+	/*
+	 * Allow for a Device Security Manager (DSM) associated with function0
+	 * of an Endpoint to coordinate TDISP requests for other functions
+	 * (physical or virtual) of the device, or allow for an Upstream Port
+	 * DSM to accept TDISP requests for the Endpoints downstream of the
+	 * switch.
+	 */
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_RC_END:
+		if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
+			break;
+		fallthrough;
+	default:
+		return false;
+	}
+
+	return PCI_FUNC(pdev->devfn) == 0;
+}
+
+#ifdef CONFIG_PCI_TSM
+struct tsm_dev;
+int pci_tsm_register(struct tsm_dev *tsm_dev);
+void pci_tsm_unregister(struct tsm_dev *tsm_dev);
+int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
+			     const struct pci_tsm_ops *ops);
+int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
+			    const struct pci_tsm_ops *ops);
+void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
+#else
+static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
+{
+	return 0;
+}
+static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
+{
+}
+#endif
+#endif /*__PCI_TSM_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6fb0e8a95078..78c1e208d441 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -545,6 +545,9 @@ struct pci_dev {
 	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
 	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
 	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
+#endif
+#ifdef CONFIG_PCI_TSM
+	struct pci_tsm *tsm;		/* TSM operation state */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	u8		supported_speeds; /* Supported Link Speeds Vector */
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index aa906eb67360..c99d85fe56f4 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -111,6 +111,10 @@ struct tsm_report_ops {
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_dev;
-struct tsm_dev *tsm_register(struct device *parent);
+struct pci_tsm_ops;
+struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
+const char *tsm_name(const struct tsm_dev *tsm_dev);
+struct tsm_dev *find_tsm_dev(int id);
+const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev);
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 911d6db5c224..4a32387c3c4a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -500,6 +500,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
+#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
 #define PCI_EXP_DEVCTL		0x08	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
-- 
2.50.1


