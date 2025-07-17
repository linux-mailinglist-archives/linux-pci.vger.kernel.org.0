Return-Path: <linux-pci+bounces-32442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9532B0940E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5B0188D5D7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE99301155;
	Thu, 17 Jul 2025 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBym5bk6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE7F209F5A;
	Thu, 17 Jul 2025 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777267; cv=fail; b=qNzEWmSoJIlACFqcw976QDmFECTOgwq1eG86BNECGSpA0JPz+nrQOJPgougb7nVPZjBHsEEGW3zZ1mrnBkjudNGbuOZqqnmWJ1/X8FpUIfU45kue4Iw46efrYMd56GF0dd7SctfpRsGWFwS4OZNJSLWov+nb/wrqO5U5lNEuM1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777267; c=relaxed/simple;
	bh=Vf6NT1EZ82FlGfK8b4qR0IrXS3s144AB8vhZ/6phDxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0IwsKDE0c5Vqqk8vZQwkkPKPLDeG6fFt/1YdCtgCDaDMOjXEVM042FYQDnFw5UyKj6s3Oodu8smmgs6NKNwA+4KYv6Yn2Gr4OvKJg0qsethvMacOMRiBLqbqRaW3L3+oAge0zL/C+rxEnbq/A3e0GAJUf5/z4d3vewDO4HU0es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBym5bk6; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777266; x=1784313266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Vf6NT1EZ82FlGfK8b4qR0IrXS3s144AB8vhZ/6phDxY=;
  b=OBym5bk66hI04OKiL3OZIkpy0FPKu1AlhZJhvo+dWWB3qZ84rjheq7te
   xCU1KyHqud/eVT/H/Mf91Y0MVaxUZr0V6Vw/06ojvtKrIflUytmh7KWyU
   5/XS+Weqj6b6w9BeUwSpV7Z5E4L8i+nP+7FRPwbPn4dxKizf/nuXv8zbt
   BNxYU0OG9YoL/JRGp5RKF7/8p3NfTPYgPcyrgGRORP/Sz88TxgQflJyWl
   0xNN82HmrvcwqyJ+XzpUzf9g+ThMsXK8wqyrDjPF6O0p5cAfVmFDPypJG
   Jhdph+nzEeimCaOK2y6SbkLW3K81qF80Q9BrAhNMZoXxw5ud3zNLCHR0I
   w==;
X-CSE-ConnectionGUID: c2/IeuNXRlKcRuKsJrW0WQ==
X-CSE-MsgGUID: 0kUkbPWWSQyfyYvES+1PgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54945714"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54945714"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:26 -0700
X-CSE-ConnectionGUID: 4HNoOzlOTmSf/vO1N4cUzQ==
X-CSE-MsgGUID: iBnyZmr+QAms6OMP5Ro1uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158222636"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:34:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvN0D6bUfkbrvCbX5NV35c/QGUZgtCddajHZQen8i7e+TrZQ2giLos+f4DIcwY/MwujK1m5a6qcdZBUm2Dfg2w0Q1w1daoy/s1pLusccLRkK0wtX/I91IhflGWvNKKQZDSQCpKWiDvMSoiHgHhzNvL7EXwfzsc/yGOLL4W3bqr+3qlqj84r4F/NduvLXDI08wesNmVUbO1Y1m5p1lIijbKk5NEmOXNGJ/T7MJ1uTmi9POjl/Byq0T0hc9lr5PFsFL/rfW7rebD8u635zIWRYDy/MGm5o7S7o/sTXIuPjNxXHBGi8T4NX5D+69adJ6eqSdocG1vf8Ghd3ZpcfgwQFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0hEOJ02+zpFahMVeXC4n8ulAZAKbn3+gQLhanJ5/ko=;
 b=rkFomUrOiFYWtprrTq7tnrE1O944nsZK9i71Nph2ZouoETYf0+nrYsLCJCj7mFN5c17Nt8lvCUTriJieKyDC0h/4GKTSzjT8EyfYwQYX1SbCHPh3FHiD/BN6zM/U5Hdv7bkpMlGYo+RxR1FGgi3sHgwGiJm01GfLpgtGZZHn7gQXanFuAsb6YJ5Rtdq5Wm/7brmqT4MpajNo+WSyqChJAZ0AUYJKMfIIUNeOXkWAPTRaDBRxvk7CwiSfzmQVN54wCXLDgOkyHmLBj/AaIdooE+fu+nb111tQj00Xh+cULrQ51+VpH+Z59bol67GxaKOrnxrLK/0WfPS0ZljJvl5hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:34:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 18:34:11 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: [PATCH v4 10/10] samples/devsec: Add sample IDE establishment
Date: Thu, 17 Jul 2025 11:33:58 -0700
Message-ID: <20250717183358.1332417-11-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717183358.1332417-1-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: af15a120-dfda-4824-499a-08ddc560862c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hshg4qp21H88qYTsFQCBwgTjvyPWF+hBqf/r+Nf2Yew/K8KOUJfdLu4/zt7x?=
 =?us-ascii?Q?488asTv9M2cmIBRaU6ImrRvRiVOrxJ5R7Rg0bU2PgCVju5OUmGOlDwWp2YOh?=
 =?us-ascii?Q?+3lp0DagSb9tVnyJLi4mSCfFrOltmDJiciqgqiuq//jWbtuPiNqWbJ4C3B/r?=
 =?us-ascii?Q?O0zjBl4tCl2C8Tt986KIsyda0pfm7rwkLaK3zhdE4Uw+UaxoTT83pKBMqyaQ?=
 =?us-ascii?Q?JYI0v01ki9HwxD/NTtb/04AcmGqmxshsYx/O/IdCo1hs4m1uWARDEGflYavp?=
 =?us-ascii?Q?6kni+DKlaEiM1AhQFcfsoBW5zvz/5rqvRG0sZNVo35gyjnM5z1ZE5CHnWBlb?=
 =?us-ascii?Q?7lGxK+DQ+n4FJGl4R5PN5mpuD2TU9+nYrDQPR3q+QtwlEPTQGGfsPL5wu9jk?=
 =?us-ascii?Q?d9h3rkjEeHKgp273qtPsV4I2ZgJdQa7eLA1f5a/YNwppv70WRBoF46E6cSHa?=
 =?us-ascii?Q?nTH6KNnxOeOIggxTckbWRMdQ4uxHjIXWRUGuf3tjrzf0EjsF3bSmj6IYEmqX?=
 =?us-ascii?Q?EYVoR/p1bPAOVTc8ARXVV5+BD3gaTzA4T5knbnx4oS2AAQcQVkjridUkdPzm?=
 =?us-ascii?Q?krCIw/Tz1OeGlYZgljrOEY0HXjQIB4TF93AuwFH1RTlkLjnufbCTCEHiiMY5?=
 =?us-ascii?Q?mtA2I1/MtbJRiAwM9gfDBkIWRZ9zT/kp8wRS32YnTEtUkVRL1MppWG9JLm2T?=
 =?us-ascii?Q?T5zQWVlLbva2x2dDGm7HIP9d7HnGsbVdiacYR7T72NskUT7HYHIh62xTnBoa?=
 =?us-ascii?Q?788NX/ZDsH1oDtdh1TP46x1f4YwiE8tVgQweIEiDKkUjAdMpGo2HtwdlifX5?=
 =?us-ascii?Q?UhcOnFQLD5DNk2yCoJldqJgxuQxIODEsGgacIqQG8q7JlOHg1XmCCy3OP3f1?=
 =?us-ascii?Q?/1zuo0n/GqxbZq4Cy+VfqjiVcL0Vkf8/pXWCdB/52uKTgE4LRXO9QYzMOGaB?=
 =?us-ascii?Q?CjP7FvzGApswATGNMquErxnI+4eq/dLhOiXVxshaExPXExB57t4mYvhH5V0i?=
 =?us-ascii?Q?ck3onFGbpsT2JUhayGfkZvl/PMJ5CIbP80Lx3YdNwVbe0UiTG/uwzZOYq/bi?=
 =?us-ascii?Q?0rmaMb5kq0UhIp8eXY3BWV9hJWR1qet31/hBSe6C8V4sUIG2SPYYsbplx3EF?=
 =?us-ascii?Q?AwBeCDz7JNWdYZaGxo9j91GDwaqaXCezvIXaiFoJJveriJVYuJoVos51PuC0?=
 =?us-ascii?Q?tsJlNPT1Co1QZqs9oWkF4L+dQ9IEptkehHVNdFEENWTJ4sIpxVKd4r/RxZH3?=
 =?us-ascii?Q?xVeLQjeIP5hfikTHrHiFS7SuUVW8GcO+ceb/oQNVtSz/Ka4NHhmsJvFcubNB?=
 =?us-ascii?Q?q5B09zR5sgoBPJhZM6Y0TSaoPl7k+JiYhxsI00wQfMcXez5omgSmH0Mi1Tej?=
 =?us-ascii?Q?TdA2t2XJ9ykpA0MaqiCPfdpbgMrdSg0V5KHsTXqTRJvCR4ccgDN8FkBolXIZ?=
 =?us-ascii?Q?j4EuSS/Rv08=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ttcIKHy93YJsOyBVjy3jP9yGLOAV98Z98Y4dZtR4ezC02GaB0YeRU6s6VI06?=
 =?us-ascii?Q?TiLBfr7MZcgJG3EQEhTe90CA9mRa8Px6smKlAb394gt43Zv7PyQIb+mo0j8d?=
 =?us-ascii?Q?Aa6uSihj8ISsy3FqxYli7vA6ezeTxAyvyeNz9BYQC3L5G/JM3iQvq+Kpy17m?=
 =?us-ascii?Q?GpUQDIM+IjzmuHnc+b+1qedRTMfM3jWXklz6em+BMc6Kri4CBnIn1jKfH7Gl?=
 =?us-ascii?Q?duJ1IGkr/mp3qtpw9X6OwCvDLjh/I+RoU3+5XUiLY1ShzzUn3JK1Ys/zm08V?=
 =?us-ascii?Q?RbdtPsbmy5P9NjAaCc5AdzyI+UUnewJDJDPBQwbAkXBE7bLctV0YAJzlGP7N?=
 =?us-ascii?Q?hxj4/j663DKByDwrV/J0PWAYhNa0ze0PIsDM84ZwUN1uVyQcjUZZ4iqjCNE9?=
 =?us-ascii?Q?N14q4UstDVwP5cPy/HZJNVEDiFW9ft3aMi9YXC7A6ioQ0aEKRRXYgl5nrQVC?=
 =?us-ascii?Q?Jbktq4za6Y19bFIxQyEPTHab7Af51pqnFFzHTUFfEm9bJhFvpx1nbgggVWYs?=
 =?us-ascii?Q?nb1O5cUOo4p8RiIMEeVHvgBXNNPaem3QZG3BVIzX1CY/Nh/dLe9OblUyE0vq?=
 =?us-ascii?Q?QB2MHvXjRs7xWGbq6QMFuoCqQkK/+OLWHz8aD1mVrGlouW09OYoq5sWk5kt9?=
 =?us-ascii?Q?AJjJtwoDskj4y0nQ/zaOO59/eTxDuiZGDcR4TRbOCr9iFrgO8oC+Jos6u6RL?=
 =?us-ascii?Q?M5wrzwOfB2PLvPWFTCR/n3f1Fl6eaHXdPRIeWT0FyEhBBjvBGcDIbMiwQB1L?=
 =?us-ascii?Q?8kfnKQkuMWhNJpJ9Xztt2KvvJsdSoSfbTPty3XzSarPz0OgHSZOJ8Brfad+o?=
 =?us-ascii?Q?Si+KxMnPstY3Z9Tjcl1+ibvkDPBRWDy0A/xtxoQYErLseiC5p6jxlLD2Y5Vj?=
 =?us-ascii?Q?vIuuQq2iHXb6Jja1rM7CuBh+/yfipbI2t6J6MbGombjkDFUgwgW2eVuVJc/C?=
 =?us-ascii?Q?jaP3oxI6P58gSyViuzBj3pCXr5RxHVomBu3hHA03bsE5TZzsZlmW9iWUGjBv?=
 =?us-ascii?Q?X/8J0sNunjDJpl2EFWjtyZNx5fJQN980z4WqSNpFSdrbTQ7sb5frU07gTcfv?=
 =?us-ascii?Q?7ePCfPfclpvenDUhSzjCHBQyqUlJL8WHQXX3sZlQJYnIZWuPtx6YiFYrZsSf?=
 =?us-ascii?Q?3G6M/4vMPofVybTm6MEf4JBJlNv8Iy64nXgD02mfkDMhxguEuFrm3NPX+mqx?=
 =?us-ascii?Q?9ZXDPWpbnj+8MMsVEwOkSqahVb/7fhcAfy8vWEPWFlv7gGW+AqU/quXbdlxC?=
 =?us-ascii?Q?pSp5M+5W1t98Qi2YuFyL4EuFFxHGUlnyTtsYdGEfSlIT84qQ53sd6IQbc64F?=
 =?us-ascii?Q?2WiynleWQYSSiwk8KWw9o4Y6Jfm+h/OO/bl861KIPtG66FdsW0x4k2OCRcW9?=
 =?us-ascii?Q?khoKb+vby10KITo2Droe/ybLwvBdTlJ56c/aukDx0FAYkBSY467ud+L5FjPM?=
 =?us-ascii?Q?4SiwO7YY0BDu8Q+pXhnPlR8iqniuu4DxJnMYKNFHBeAoe1yxvnyelMrgWXxy?=
 =?us-ascii?Q?Hudg2LCZRzhEJq0wOJ/4xhmn6wjX4cAs3xxcVAOkDQgbfEKwD89YFQLcpLWs?=
 =?us-ascii?Q?4QgERxhs5KIN1cxYCKPjMMCXdOo4vTPrqWXwL4FN7yCjJsTDvrQO7pgVUsCN?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af15a120-dfda-4824-499a-08ddc560862c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:11.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDPXSdqxOhJpeWkSoxtuikwZ4dxF59SIJ+JwEPsnaP3CRkuqnJ6Sw4aAC8k8CAurO858kNjSoYnvaWZ8rk/E0K5NjZxbCWyo7W1q6dzoALA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 samples/devsec/bus.c |  3 ++
 samples/devsec/tsm.c | 70 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

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
index a4705212a7e4..b93396ca0c92 100644
--- a/samples/devsec/tsm.c
+++ b/samples/devsec/tsm.c
@@ -4,6 +4,7 @@
 #define dev_fmt(fmt) "devsec: " fmt
 #include <linux/device/faux.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/tsm.h>
@@ -92,6 +93,23 @@ static void devsec_tsm_pci_remove(struct pci_tsm *tsm)
 	}
 }
 
+/* protected by tsm_ops lock */
+static DECLARE_BITMAP(devsec_stream_ids, NR_TSM_STREAMS);
+static struct pci_ide *devsec_streams[NR_TSM_STREAMS];
+
+static unsigned long *alloc_devsec_stream_id(unsigned long *stream_id)
+{
+	unsigned long id;
+
+	id = find_first_zero_bit(devsec_stream_ids, NR_TSM_STREAMS);
+	if (id == NR_TSM_STREAMS)
+		return NULL;
+	set_bit(id, devsec_stream_ids);
+	*stream_id = id;
+	return stream_id;
+}
+DEFINE_FREE(free_devsec_stream, unsigned long *, if (_T) clear_bit(*_T, devsec_stream_ids))
+
 /*
  * Reference consumer for a TSM driver "connect" operation callback. The
  * low-level TSM driver understands details about the platform the PCI
@@ -116,11 +134,61 @@ static void devsec_tsm_pci_remove(struct pci_tsm *tsm)
  */
 static int devsec_tsm_connect(struct pci_dev *pdev)
 {
-	return -ENXIO;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	unsigned long __stream_id;
+	int rc;
+
+	unsigned long *stream_id __free(free_devsec_stream) =
+		alloc_devsec_stream_id(&__stream_id);
+	if (!stream_id)
+		return -EBUSY;
+
+	struct pci_ide *ide __free(pci_ide_stream_release) =
+		pci_ide_stream_alloc(pdev);
+	if (!ide)
+		return -ENOMEM;
+
+	ide->stream_id = *stream_id;
+	rc = pci_ide_stream_register(ide);
+	if (rc)
+		return rc;
+
+	pci_ide_stream_setup(pdev, ide);
+	pci_ide_stream_setup(rp, ide);
+
+	rc = tsm_ide_stream_register(ide);
+	if (rc)
+		return rc;
+
+	/*
+	 * Model a TSM that handled enabling the stream at
+	 * tsm_ide_stream_register() time
+	 */
+	rc = pci_ide_stream_enable(pdev, ide);
+	if (rc)
+		return rc;
+
+	devsec_streams[*no_free_ptr(stream_id)] = no_free_ptr(ide);
+
+	return 0;
 }
 
 static void devsec_tsm_disconnect(struct pci_dev *pdev)
 {
+	struct pci_ide *ide;
+	unsigned long i;
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
+	pci_ide_stream_release(ide);
+	clear_bit(i, devsec_stream_ids);
 }
 
 static struct pci_tsm_ops devsec_pci_ops = {
-- 
2.50.1


