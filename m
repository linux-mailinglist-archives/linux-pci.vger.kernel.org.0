Return-Path: <linux-pci+bounces-27826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC453AB959D
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C90D1BA44AD
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC0221728;
	Fri, 16 May 2025 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0pugd6L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2F21C9F1
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374485; cv=fail; b=iB2+31qDwDzbGG2xfFXcI7XqMkzStbz2nOypnRaZqw99JQnrYpncSG+Zp1Kbi8ENBVpA0kFwfawodKdTeAwZtDm+vkmS7gGOGYgLLnqLZUhurnzZyKKfBzvi1UARBVIzQMla+FtydVbxUTqqppyaI2QTVKv7ep2if3Maaqg+Zn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374485; c=relaxed/simple;
	bh=5Z855sBnYUEBg0yT6WYVwqi6Ut0HB6iOCte95qt3PfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6ZwabGk4kJv/zjWI43KWQm1P/kGjXatZIpKJCm/qrxQFOIQNEshRXabcTb70nVh5RlHF2Htb/GjnFPBJfhBkKjlnwElsWUHnh7Sy4Otgl2IC7fKCSq2XUteXyLF11rgVCA0BnnGX1W5j4pRbcfJrY/2h+W6YrttutlajM6w5Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0pugd6L; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374483; x=1778910483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5Z855sBnYUEBg0yT6WYVwqi6Ut0HB6iOCte95qt3PfA=;
  b=l0pugd6L16ZnSTA+hccH4UnSCWuYmagsOSljs4yt+7oboLY+EaIHRGc4
   KJeYqYSbEI+n+b777YiBBQ0EYBYAytfUlAHQT/5qBkyTViiiE64pNYW4R
   lh/E2/n6Cz2S2bFu0fydDgmqtpvo2CuJMao7RVbUjlJq7GmpY6m5A4zJ4
   t37iGM2A9jOdS7PwWC4TApcBu0dKOqmhpwNjItfdoTv6OWg7byqe4Izge
   dUMDzepHQJigkHXpobo11jTXC+E788Pnh6l7/E+6vgzdTkzNL2Myqah8C
   Inzr+fDcNCFOw/CyWXg8veCYOOR6aITeZ2PZ06QtgsgFc5F268MHSxQGD
   w==;
X-CSE-ConnectionGUID: 7qLr+P12Tgqm4LtwXSJn9Q==
X-CSE-MsgGUID: oyS4xh9pSgK4f8oMX50gkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36952812"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36952812"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:48:02 -0700
X-CSE-ConnectionGUID: OE6JReFuTESuNEjFwDwYGQ==
X-CSE-MsgGUID: Ur4aq352QUO6OhhSWYGk8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139084708"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:56 -0700
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
 15.1.2507.44; Thu, 15 May 2025 22:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps7W0QFg7fP93myookGNwTGX9EqUNlwNoKijbJ9LASNUS9PExp1+3sdLXClGDcBD88mrFS+KJ8AazoO0RCuxGv4MFNLGac6R90czuBsGWngYPPncQTioSWifjh01KX/u+h++1R1Wx83gO152W1aYEnhYCkPTFpKmOeayNwTIA7FoW/e2rWAho9XlwkGf1g8G1pD7kZX0XJaN+sz4sugfmciYAnuQW/7NHVhPvvmewAL+MYAKkkZii/z9noM2yGe8miwO1DlcHhS+gW2WsYA75+49n+nBDjtJAZRb7E7Y+ev9SroCFTsCgaERKIpdbdyEZLQx2MqUXVG+g3IUV5Jk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUssmWXlp4ajI0KO/Vq27vFbtgSCHfM08Y0P2v8LkgI=;
 b=IUyk9E0l2Apst2m0cm+7nH8KuJQ1Ava9m4Fw1JMshbQ0oet56T5y7WUAjmRFr4UakcgYE17zj31X5eXb4lVukQOKUOIOwc2kgha17sXs740qih9aUJVnyBXfzJooAp/CgfzALfl4G6C/juK+0ve+DalXQVvkhGCwMXdN6+EYFMfBW9eccp4QGNEZ1ZkcHLyddet9x5qZLSodQ8e7tRX/6vtjFis0rP5j4DalOz2rmbXN2rsVmZuPJEtlbRE9k1Xp2AhOyJSRfaq8LDG0GDtz5EOjnyUJg4jPv6MpVqOVicVSsViD/Ec7Bo++arqqmNvAWiEGSEoP/cl3wHCNbUK40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:47:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:39 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
Date: Thu, 15 May 2025 22:47:22 -0700
Message-ID: <20250516054732.2055093-4-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7c5e620e-194e-432d-c9a9-08dd943d2b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G+fBsuzNc+LpvSajoDag9udUoBV0YhWxDOK32edtlfdxYDD5RS87eOcsYPbB?=
 =?us-ascii?Q?yrgurDrbKbrSgY/Hbew9+O/GtxeAgJsrs7EuDiI0d47QgJyyWWdGyKU3VlnS?=
 =?us-ascii?Q?eVVk3JS6i0HkeRyN6vVYc6QYKpHtpyNiLCyeD99qewFxFxdfloHTv+lTUA8S?=
 =?us-ascii?Q?OSnqS/81EnPHnl+kbNNN64/3CSmog2EMP4l9fI52G8Hgl2MpIyMnoja06wth?=
 =?us-ascii?Q?GhRtXzoIpvnTbR2vIssKcEPO3X79FEgWXMWl+2CcytLPvkL0TVISf4UYdbia?=
 =?us-ascii?Q?yCnxToWTMczn0qOqKmSSeXR5neMv8uJVHGdrWN+rkdKwzxXCXhRHudRrloVQ?=
 =?us-ascii?Q?LM18eDDK0mG7jX3AJ6jclWXhYz9RBKxgJGtaaPMlz+JJaf/y1YINTqpWnRWa?=
 =?us-ascii?Q?o34snPKBE6OtzmZFAjgOCF1y5wVJOHIk5WDwEuIoQ9YMatwl+36QpDi45vFQ?=
 =?us-ascii?Q?UL70H38dHyqWcLlRDoTvnU6g3KKEhzE6min8YteoP5l6tIi2af6kfuHP7vBx?=
 =?us-ascii?Q?AlGpF7Xkku1onl9keytiFg3RY7Y3FIOWr4GNJHtxim0SuTqjzNvABLYjEGTn?=
 =?us-ascii?Q?qvP1bBoMVsAe4ZpOreEDs4RGEimacFeYmg6zTTGQNf81zik4rf/x02P7FPIL?=
 =?us-ascii?Q?f1DJp19xypffZSHiYCLWWb2qQVlMJIj70sqHzmmtoUF5uufXeg12i8PDCItG?=
 =?us-ascii?Q?ZAEP3cg2ilB+ZMVQ+cD+aS3+A2jRT/wKBKip3VeYdvcy0KkuXT73bPm+ImlQ?=
 =?us-ascii?Q?EwW5bAOtNUW7PpVg4g+yQZejzOxfAPWkpIZIHleKt0szCKh+QNACHoh6Ey3u?=
 =?us-ascii?Q?3Cr5EhMox/oF7b8movy7QftPSO5Rq0X8ZnOLVPU7b7BxSEovOIPrbvY/wI10?=
 =?us-ascii?Q?LLCwuLZd3y3dltFlUM2KJaGKilzdw0ZvDqsCvDGn13+1sKhjELTUk4tFsQVs?=
 =?us-ascii?Q?MF7dyLBfrSxzZTg0e0so8jZOyY7LROwlYzIYPPj9zjzTO1k1NXfWDWHP2vX3?=
 =?us-ascii?Q?yEy94Hz4ZL3jyuLx9nfq4dYOlUev5XMt3CTPoubhW9Ei69w3CjLvp5lmR9+S?=
 =?us-ascii?Q?vpUyLjt0PpGywGXywnYMoaICaNPdg3NVQRhWKzvSZ4u53YYJQwm4xgbSQSnw?=
 =?us-ascii?Q?5IHneJOyGLTwNi/4eZQkD3r68KpCuYLNLWFEky0sqiJzB8FcvAQ9a+2uLiPO?=
 =?us-ascii?Q?Zhq/yXA0ntLABerLF634erWnN5mK6HUGgSBjYpQFx8/onMd9/9VqLgUyhOJO?=
 =?us-ascii?Q?DrohxePEsDvBCKpEACDRaTJeW/bqUe/Cr9Pr1Mfq98CnS69LHZpPm38cXyOM?=
 =?us-ascii?Q?o+E4M3ffFRIzRQc16SUfY2OxAZrEvoT0DClBuvHnGvC38qK23CT7VKrJm/JJ?=
 =?us-ascii?Q?h4JDra/vPhbMPIi3sJYY3O/WPU9w/Qam3NtJkzT+vr8e4013WHn8iSp1Dtg7?=
 =?us-ascii?Q?hNMWl2zoOco=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vNeaLZtCeaojkKXOtFB254tguPrT8CW+Ht6Bm34hGUWkgwehoJqB0wO49DDQ?=
 =?us-ascii?Q?IlN/DWYpRSJ5OwSjbN0QRrf+paMbg1RdQA//qQJNefpUfl5BI6d7JB009P0l?=
 =?us-ascii?Q?px2igdBEy8FLcLUleTffGOh3eoKUXwMEjS2hBRp0TkoyXCr9uQRqNZv3N5PL?=
 =?us-ascii?Q?RCKMu7WM5tF3puisoW3eiCkBPuZ/Pdwi3LgUzEcjnBhkqXIeOn4mT2XucSze?=
 =?us-ascii?Q?qlL0ptIU3xm2j4vHmYz5Q9zwgdZwq4wUqvarMRlvt6O0vtuyAbIyuzrruVW+?=
 =?us-ascii?Q?VtmMvhJUj1ae4rz7+7hQNcbdz6kbsfJ7LLtHdZqBuOWauCd6X8287A+QyqI3?=
 =?us-ascii?Q?waPivbnKYwNYEHexlf3TiqxVjyHWI201ovIRSLuwyDibuf49aIVDhmGijisC?=
 =?us-ascii?Q?ncYgjwJRsPekOh7VBPK4NIqLThLrQbofnpXq4GNZtFWGVFg+N9n46isLEU9C?=
 =?us-ascii?Q?wTZSjSWXW1bJMVLNg+xXiXOJPWbW05+P13cgi6+fyNjVWpPWT3FS81McpHOT?=
 =?us-ascii?Q?tWhKhp37ApIfHpp+bwIyS7P3jB7bfCpdmLn3oiDW/ODDUPpKzeqeKGwwRu74?=
 =?us-ascii?Q?dq+RX/hHnKhgjjCc89010oXur/rAyEwfM10kF++43p9kWR6afjRkvhokgEMf?=
 =?us-ascii?Q?eQpAomgzyAA/DyiNgIVOgZaesH7P7Uhx89LFsNclOWR3Pz7inNK8bLHMgkkO?=
 =?us-ascii?Q?NTbG3FS2TpOMw3qZJz9n1xYVi7L6yKgMDmReSC2N5HGNe/K6sEsEi4vzq4SG?=
 =?us-ascii?Q?e3VwoN0xnVw1kDl0Rk+U6IDvvKqesKR5dt7Qg32QVJ3TzwcY7CEY7g6kbBzC?=
 =?us-ascii?Q?be2+DKBPPJKegrTeK1v2REzha5Jbg92AEftLTTLHf6agOnLKhTR60Bv9Z1bw?=
 =?us-ascii?Q?z1wChIhDZFlY/xgwaw58KPVSt9KJC88hDXEclM5rhT0JY2ZuxUQRYoE6nxy+?=
 =?us-ascii?Q?YAj/HD2Un0oD1p+A84Iljo5noE3C5qGDg1VGkLAc34N6QRuv8CWZ2qE6K+Yz?=
 =?us-ascii?Q?+GZIMzHjZsIE6fZVJ/D8Edlm5StYX2O22atf5mrCgYRG/FxW5Vz6vPOnv3KF?=
 =?us-ascii?Q?1vm5PQENhQ3T6p053d8QXdGLc/TpPfq46ind9pWXQZFQReFyLhf37vPqRQoE?=
 =?us-ascii?Q?pAM58Qq4w6rEdFY6WF/1LqdIPJtgUmoxNtWDNSDVs6iVCc2VMFarAql9aoI6?=
 =?us-ascii?Q?QMO2YcBSbo7mhiRZ23gmic5sAjQWmMhtL6JYNTfxUHNr3+A2DSsz5Z4Nja81?=
 =?us-ascii?Q?sNJI9Ib68YIY0wEQKB31M2R352oTCNzg0R+n1wD3aRqA/VwDke8lzYCvf5rD?=
 =?us-ascii?Q?K7JKDCcw/BMCkKc7LY64iFtjUX0gxDsWWfOKWCGr/fJRitGE0TGJa4gl//hz?=
 =?us-ascii?Q?XIZgie+xpQdRyhIJOT9P8t6N1BhMfMb+DSv/YvgwxoEZVvmYpqlOCFeK3OPZ?=
 =?us-ascii?Q?lNtizJYSN6+ef6uzlgLEyItS32eE/Z0Ssz/A9/S6thfCI2FQNydsY0anCSr/?=
 =?us-ascii?Q?MNNdfrk5GZ4XINPXy4uepH/IKDaowgdsW6Fxn07b3gUJ608RgrDNoFWKAweg?=
 =?us-ascii?Q?2rU0PnD5lqGrWeRUj8quoDSi2wbveYY5xOwnDZ4miWeWKaUgudNMSJVzCVoC?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5e620e-194e-432d-c9a9-08dd943d2b17
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:39.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo1JQWyBjfddGeSHTkX2OsdumCIvOpsbu+TKgQH0brrJwfzn0CCreygOQkEa/Q8Izvu6kxhPQEF/aq+DtB9k7OmtY5P8dQXqpc9Bi8he7FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

The PCIe 6.1 specification, section 11, introduces the Trusted Execution
Environment (TEE) Device Interface Security Protocol (TDISP).  This
protocol definition builds upon Component Measurement and Authentication
(CMA), and link Integrity and Data Encryption (IDE). It adds support for
assigning devices (PCI physical or virtual function) to a confidential
VM such that the assigned device is enabled to access guest private
memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
COVE, or ARM CCA.

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
Userspace can watch for the arrival of the "TSM" core device,
/sys/class/tsm/tsm0/uevent, to know when the PCI core has initialized
TSM services.

The common verbs that the low-level TSM drivers implement are defined by
'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
defined for secure session and IDE establishment. The 'probe' and
'remove' operations setup per-device context objects starting with
'struct pci_tsm_pf0', the device Physical Function 0 that mediates
communication to the device's Security Manager (DSM).

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
 Documentation/ABI/testing/sysfs-bus-pci |  45 +++
 MAINTAINERS                             |   2 +
 drivers/pci/Kconfig                     |  14 +
 drivers/pci/Makefile                    |   1 +
 drivers/pci/pci-sysfs.c                 |   4 +
 drivers/pci/pci.h                       |  10 +
 drivers/pci/probe.c                     |   1 +
 drivers/pci/remove.c                    |   3 +
 drivers/pci/tsm.c                       | 437 ++++++++++++++++++++++++
 drivers/virt/coco/host/tsm-core.c       |  19 +-
 include/linux/pci-tsm.h                 | 138 ++++++++
 include/linux/pci.h                     |   3 +
 include/linux/tsm.h                     |   4 +-
 include/uapi/linux/pci_regs.h           |   1 +
 14 files changed, 679 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 include/linux/pci-tsm.h

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 69f952fffec7..1d38e0d3a6be 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -612,3 +612,48 @@ Description:
 
 		  # ls doe_features
 		  0001:01        0001:02        doe_discovery
+
+What:		/sys/bus/pci/devices/.../tsm/
+Date:		July 2024
+Contact:	linux-coco@lists.linux.dev
+Description:
+		This directory only appears if a physical device function
+		supports authentication (PCIe CMA-SPDM), interface security
+		(PCIe TDISP), and is accepted for secure operation by the
+		platform TSM driver. This attribute directory appears
+		dynamically after the platform TSM driver loads. So, only after
+		the /sys/class/tsm/tsm0 device arrives can tools assume that
+		devices without a tsm/ attribute directory will never have one,
+		before that, the security capabilities of the device relative to
+		the platform TSM are unknown. See
+		Documentation/ABI/testing/sysfs-class-tsm.
+
+What:		/sys/bus/pci/devices/.../tsm/connect
+Date:		July 2024
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) Writing "1" to this file triggers the platform TSM (TEE
+		Security Manager) to establish a connection with the device.
+		This typically includes an SPDM (DMTF Security Protocols and
+		Data Models) session over PCIe DOE (Data Object Exchange) and
+		may also include PCIe IDE (Integrity and Data Encryption)
+		establishment.
+
+What:		/sys/bus/pci/devices/.../authenticated
+Date:		July 2024
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 09bf7b45708b..2f92623b4de5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24560,8 +24560,10 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
+F:	drivers/pci/tsm.c
 F:	drivers/virt/coco/guest/
 F:	drivers/virt/coco/host/
+F:	include/linux/pci-tsm.h
 F:	include/linux/tsm.h
 
 TRUSTED SERVICES TEE DRIVER
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c662f9813eb..5c3f896ac9f4 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -135,6 +135,20 @@ config PCI_IDE_STREAM_MAX
 	  track the maximum possibility of 256 streams per host bridge
 	  in the typical case.
 
+config PCI_TSM
+	bool "PCI TSM: Device security protocol support"
+	select PCI_IDE
+	select PCI_DOE
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
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c6cda56ca52c..6bd16a110916 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1811,6 +1811,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCI_DOE
 	&pci_doe_sysfs_group,
+#endif
+#ifdef CONFIG_PCI_TSM
+	&pci_tsm_auth_attr_group,
+	&pci_tsm_pf0_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 10be2ce5e5d5..7f763441f658 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -517,6 +517,16 @@ void pci_ide_init(struct pci_dev *dev);
 static inline void pci_ide_init(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_PCI_TSM
+void pci_tsm_init(struct pci_dev *pdev);
+void pci_tsm_destroy(struct pci_dev *pdev);
+extern const struct attribute_group pci_tsm_pf0_attr_group;
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
index 1b597b6e946c..c090289b70be 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2620,6 +2620,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_tph_init(dev);		/* TLP Processing Hints */
 	pci_rebar_init(dev);		/* Resizable BAR */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
+	pci_tsm_init(dev);		/* TEE Security Manager connection */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 445afdfa6498..21851c13becd 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -55,6 +55,9 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
 
+	/* before device_del() to keep config cycle access */
+	pci_tsm_destroy(dev);
+
 	device_del(&dev->dev);
 
 	down_write(&pci_bus_sem);
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
new file mode 100644
index 000000000000..d00a8e471340
--- /dev/null
+++ b/drivers/pci/tsm.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TEE Security Manager for the TEE Device Interface Security Protocol
+ * (TDISP, PCIe r6.1 sec 11)
+ *
+ * Copyright(c) 2024 Intel Corporation. All rights reserved.
+ */
+
+#define dev_fmt(fmt) "TSM: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/xarray.h>
+#include <linux/sysfs.h>
+
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pci-tsm.h>
+#include "pci.h"
+
+/*
+ * Provide a read/write lock against the init / exit of pdev tsm
+ * capabilities and arrival/departure of a tsm instance
+ */
+static DECLARE_RWSEM(pci_tsm_rwsem);
+static const struct pci_tsm_ops *tsm_ops;
+
+/* supplemental attributes to surface when pci_tsm_attr_group is active */
+static const struct attribute_group *pci_tsm_owner_attr_group;
+
+static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
+{
+	struct pci_dev *pdev = pci_tsm->pdev;
+
+	if (!is_pci_tsm_pf0(pdev) || pci_tsm->type != PCI_TSM_PF0) {
+		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");
+		return NULL;
+	}
+
+	return container_of(pci_tsm, struct pci_tsm_pf0, tsm);
+}
+
+/* TODO: switch to ACQUIRE() and ACQUIRE_ERR() */
+static struct mutex *tsm_ops_lock(struct pci_tsm_pf0 *tsm)
+{
+	lockdep_assert_held(&pci_tsm_rwsem);
+
+	if (mutex_lock_interruptible(&tsm->lock) != 0)
+		return NULL;
+	return &tsm->lock;
+}
+DEFINE_FREE(tsm_ops_unlock, struct mutex *, if (_T) mutex_unlock(_T))
+
+static int pci_tsm_disconnect(struct pci_dev *pdev)
+{
+	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
+
+	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
+	if (!lock)
+		return -EINTR;
+
+	if (tsm->state < PCI_TSM_INIT)
+		return -ENXIO;
+	if (tsm->state < PCI_TSM_CONNECT)
+		return 0;
+
+	tsm_ops->disconnect(pdev);
+	tsm->state = PCI_TSM_INIT;
+
+	return 0;
+}
+
+static int pci_tsm_connect(struct pci_dev *pdev)
+{
+	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
+	int rc;
+
+	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
+	if (!lock)
+		return -EINTR;
+
+	if (tsm->state < PCI_TSM_INIT)
+		return -ENXIO;
+	if (tsm->state >= PCI_TSM_CONNECT)
+		return 0;
+
+	rc = tsm_ops->connect(pdev);
+	if (rc)
+		return rc;
+	tsm->state = PCI_TSM_CONNECT;
+	return 0;
+}
+
+/* TODO: switch to ACQUIRE() and ACQUIRE_ERR() */
+static struct rw_semaphore *tsm_read_lock(void)
+{
+	if (down_read_interruptible(&pci_tsm_rwsem))
+		return NULL;
+	return &pci_tsm_rwsem;
+}
+DEFINE_FREE(tsm_read_unlock, struct rw_semaphore *, if (_T) up_read(_T))
+
+static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	int rc;
+	bool connect;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	rc = kstrtobool(buf, &connect);
+	if (rc)
+		return rc;
+
+	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
+	if (!lock)
+		return -EINTR;
+
+	if (connect)
+		rc = pci_tsm_connect(pdev);
+	else
+		rc = pci_tsm_disconnect(pdev);
+	if (rc)
+		return rc;
+	return len;
+}
+
+static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_tsm_pf0 *tsm;
+
+	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
+	if (!lock)
+		return -EINTR;
+
+	if (!pdev->tsm)
+		return -ENXIO;
+
+	tsm = to_pci_tsm_pf0(pdev->tsm);
+	return sysfs_emit(buf, "%d\n", tsm->state >= PCI_TSM_CONNECT);
+}
+static DEVICE_ATTR_RW(connect);
+
+static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (pdev->tsm && is_pci_tsm_pf0(pdev))
+		return true;
+	return false;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
+
+static struct attribute *pci_tsm_pf0_attrs[] = {
+	&dev_attr_connect.attr,
+	NULL
+};
+
+const struct attribute_group pci_tsm_pf0_attr_group = {
+	.name = "tsm",
+	.attrs = pci_tsm_pf0_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
+};
+
+static ssize_t authenticated_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	/*
+	 * When device authentication is TSM owned, 'authenticated' is
+	 * identical to the connect state.
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
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
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
+static bool is_pci_tsm_downstream(struct pci_dev *pdev)
+{
+	struct pci_dev *uport;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	/* "grandparent" of an endpoint is an Upstream Port (or Root Port) */
+	if (!pdev->dev.parent)
+		return false;
+	if (!pdev->dev.parent->parent)
+		return false;
+
+	uport = to_pci_dev(pdev->dev.parent->parent);
+	if (pci_pcie_type(uport) != PCI_EXP_TYPE_UPSTREAM)
+		return false;
+
+	if (!uport->tsm)
+		return false;
+
+	/* Upstream Port has a 'tsm' context, probe downstream devices. */
+	return true;
+}
+
+static enum pci_tsm_type pci_tsm_type(struct pci_dev *pdev)
+{
+	if (is_pci_tsm_pf0(pdev))
+		return PCI_TSM_PF0;
+
+	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
+	if (!pf0)
+		return PCI_TSM_INVALID;
+
+	if (pf0->tsm && pf0->tsm->type == PCI_TSM_PF0) {
+		if (pdev->is_virtfn)
+			return PCI_TSM_VIRTFN;
+		else
+			return PCI_TSM_MFD;
+	}
+
+	/*
+	 * Allow for Device Security Managers (DSMs) at a Switch level
+	 * to host TDISP services for downstream devices
+	 */
+	if (is_pci_tsm_downstream(pdev))
+		return PCI_TSM_DOWNSTREAM;
+	return PCI_TSM_INVALID;
+}
+
+/**
+ * pci_tsm_initialize() - base 'struct pci_tsm' initialization
+ * @pdev: The PCI device
+ * @tsm: context to initialize
+ */
+void pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm)
+{
+	tsm->type = pci_tsm_type(pdev);
+	tsm->pdev = pdev;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_initialize);
+
+/**
+ * pci_tsm_pf0_initialize() - common 'struct pci_tsm_pf0' initialization
+ * @pdev: Physical Function 0 PCI device
+ * @tsm: context to initialize
+ */
+int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm)
+{
+	mutex_init(&tsm->lock);
+	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					   PCI_DOE_PROTO_CMA);
+	if (!tsm->doe_mb) {
+		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
+		return -ENODEV;
+	}
+
+	tsm->state = PCI_TSM_INIT;
+	pci_tsm_initialize(pdev, &tsm->tsm);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_pf0_initialize);
+
+static void __pci_tsm_pf0_destroy(struct pci_tsm_pf0 *tsm)
+{
+	mutex_destroy(&tsm->lock);
+}
+
+static void tsm_remove(struct pci_tsm *tsm)
+{
+	if (!tsm)
+		return;
+	tsm_ops->remove(tsm);
+}
+DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
+
+static void pci_tsm_pf0_init(struct pci_dev *pdev)
+{
+	bool tee_cap;
+
+	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
+
+	if (!(pdev->ide_cap || tee_cap))
+		return;
+
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+	if (!tsm_ops)
+		return;
+
+	/*
+	 * If a physical device has any security capabilities it may be
+	 * a candidate to connect with the platform TSM
+	 */
+	struct pci_tsm *pci_tsm __free(tsm_remove) = tsm_ops->probe(pdev);
+
+	pci_dbg(pdev, "Device security capabilities detected (%s%s ), TSM %s\n",
+		pdev->ide_cap ? " ide" : "", tee_cap ? " tee" : "",
+		pci_tsm ? "attach" : "skip");
+
+	if (!pci_tsm)
+		return;
+
+	pdev->tsm = no_free_ptr(pci_tsm);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
+	if (pci_tsm_owner_attr_group)
+		sysfs_merge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
+}
+
+static void __pci_tsm_init(struct pci_dev *pdev)
+{
+	enum pci_tsm_type type = pci_tsm_type(pdev);
+
+	switch (type) {
+	case PCI_TSM_PF0:
+		pci_tsm_pf0_init(pdev);
+		break;
+	case PCI_TSM_VIRTFN:
+	case PCI_TSM_MFD:
+	case PCI_TSM_DOWNSTREAM:
+		pdev->tsm = tsm_ops->probe(pdev);
+		break;
+	case PCI_TSM_INVALID:
+	default:
+		break;
+	}
+}
+
+void pci_tsm_init(struct pci_dev *pdev)
+{
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	__pci_tsm_init(pdev);
+}
+
+int pci_tsm_core_register(const struct pci_tsm_ops *ops, const struct attribute_group *grp)
+{
+	struct pci_dev *pdev = NULL;
+
+	if (!ops)
+		return 0;
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	if (tsm_ops)
+		return -EBUSY;
+	tsm_ops = ops;
+	pci_tsm_owner_attr_group = grp;
+	for_each_pci_dev(pdev)
+		__pci_tsm_init(pdev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_core_register);
+
+static void pci_tsm_pf0_destroy(struct pci_dev *pdev)
+{
+	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
+
+	if (tsm->state > PCI_TSM_INIT)
+		pci_tsm_disconnect(pdev);
+	pdev->tsm = NULL;
+	if (pci_tsm_owner_attr_group)
+		sysfs_unmerge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+	__pci_tsm_pf0_destroy(tsm);
+}
+
+static void __pci_tsm_destroy(struct pci_dev *pdev)
+{
+	struct pci_tsm *pci_tsm = pdev->tsm;
+
+	if (!pci_tsm)
+		return;
+
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+
+	if (is_pci_tsm_pf0(pdev))
+		pci_tsm_pf0_destroy(pdev);
+	tsm_ops->remove(pci_tsm);
+}
+
+void pci_tsm_destroy(struct pci_dev *pdev)
+{
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	__pci_tsm_destroy(pdev);
+}
+
+void pci_tsm_core_unregister(const struct pci_tsm_ops *ops)
+{
+	struct pci_dev *pdev = NULL;
+
+	if (!ops)
+		return;
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	if (ops != tsm_ops)
+		return;
+	for_each_pci_dev(pdev)
+		__pci_tsm_destroy(pdev);
+	tsm_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_core_unregister);
+
+int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
+			 const void *req, size_t req_sz, void *resp,
+			 size_t resp_sz)
+{
+	struct pci_tsm_pf0 *tsm;
+
+	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
+		return -ENXIO;
+
+	tsm = to_pci_tsm_pf0(pdev->tsm);
+	if (!tsm->doe_mb)
+		return -ENXIO;
+
+	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
+		       resp, resp_sz);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
index 4f64af1a8967..51146f226a64 100644
--- a/drivers/virt/coco/host/tsm-core.c
+++ b/drivers/virt/coco/host/tsm-core.c
@@ -8,11 +8,13 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/pci-tsm.h>
 
 static DECLARE_RWSEM(tsm_core_rwsem);
 static struct class *tsm_class;
 static struct tsm_core_dev {
 	struct device dev;
+	const struct pci_tsm_ops *pci_ops;
 } *tsm_core;
 
 static struct tsm_core_dev *
@@ -39,7 +41,8 @@ static void put_tsm_core(struct tsm_core_dev *core)
 DEFINE_FREE(put_tsm_core, struct tsm_core_dev *,
 	    if (!IS_ERR_OR_NULL(_T)) put_tsm_core(_T))
 struct tsm_core_dev *tsm_register(struct device *parent,
-				  const struct attribute_group **groups)
+				  const struct attribute_group **groups,
+				  const struct pci_tsm_ops *pci_ops)
 {
 	struct device *dev;
 	int rc;
@@ -61,10 +64,20 @@ struct tsm_core_dev *tsm_register(struct device *parent,
 	if (rc)
 		return ERR_PTR(rc);
 
+	rc = pci_tsm_core_register(pci_ops, NULL);
+	if (rc) {
+		dev_err(parent, "PCI initialization failure: %pe\n",
+			ERR_PTR(rc));
+		return ERR_PTR(rc);
+	}
+
 	rc = device_add(dev);
-	if (rc)
+	if (rc) {
+		pci_tsm_core_unregister(pci_ops);
 		return ERR_PTR(rc);
+	}
 
+	core->pci_ops = pci_ops;
 	tsm_core = no_free_ptr(core);
 
 	return tsm_core;
@@ -79,7 +92,9 @@ void tsm_unregister(struct tsm_core_dev *core)
 		return;
 	}
 
+	pci_tsm_core_unregister(core->pci_ops);
 	device_unregister(&core->dev);
+
 	tsm_core = NULL;
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
new file mode 100644
index 000000000000..00fdae087069
--- /dev/null
+++ b/include/linux/pci-tsm.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PCI_TSM_H
+#define __PCI_TSM_H
+#include <linux/mutex.h>
+#include <linux/pci.h>
+
+struct pci_dev;
+
+enum pci_tsm_state {
+	PCI_TSM_ERR = -1,
+	PCI_TSM_INIT,
+	PCI_TSM_CONNECT,
+};
+
+/**
+ * enum pci_tsm_type - 'struct pci_tsm' object types
+ * @PCI_TSM_PF0: function0 that hosts a DOE mailbox that comprehends an
+ *		 Interface ID per potential TDI
+ * @PCI_TSM_VIRTFN: physfn-0 of this device is "tsm_pf0"
+ * @PCI_TSM_MFD: function0 of this device is  "tsm_pf0"
+ * @PCI_TSM_DOWNSTREAM: immediate Upstream Port of this device is "tsm_pf0"
+ */
+enum pci_tsm_type {
+	PCI_TSM_INVALID,
+	PCI_TSM_PF0,
+	PCI_TSM_VIRTFN,
+	PCI_TSM_MFD,
+	PCI_TSM_DOWNSTREAM,
+};
+
+/**
+ * struct pci_tsm - Core TSM context for a given PCIe endpoint
+ * @pdev: indicates the type of pci_tsm object
+ * @type: pci_tsm object type to disambiguate PCI_TSM_DOWNSTREAM and PCI_TSM_PF0
+ *
+ * This structure is wrapped by a low level TSM driver and returned by
+ * tsm_ops.probe(), it is freed by tsm_ops.remove(). Depending on
+ * whether @pdev is physical function 0, another physical function, or a
+ * virtual function determines the pci_tsm object type. E.g. see 'struct
+ * pci_tsm_pf0'.
+ */
+struct pci_tsm {
+	struct pci_dev *pdev;
+	enum pci_tsm_type type;
+};
+
+/**
+ * struct pci_tsm_pf0 - Physical Function 0 TDISP context
+ * @state: reflect device initialized, connected, or bound
+ * @lock: protect @state vs pci_tsm_ops invocation
+ * @doe_mb: PCIe Data Object Exchange mailbox
+ */
+struct pci_tsm_pf0 {
+	struct pci_tsm tsm;
+	enum pci_tsm_state state;
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
+	 * DSM to accept TDISP requests for switch Downstream Endpoints.
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
+/**
+ * struct pci_tsm_ops - Low-level TSM-exported interface to the PCI core
+ * @probe: probe/accept device for tsm operation, setup DSM context
+ * @remove: destroy DSM context
+ * @connect: establish / validate a secure connection (e.g. IDE) with the device
+ * @disconnect: teardown the secure connection
+ *
+ * @probe and @remove run in pci_tsm_rwsem held for write context. All
+ * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
+ * for read.
+ */
+struct pci_tsm_ops {
+	struct pci_tsm *(*probe)(struct pci_dev *pdev);
+	void (*remove)(struct pci_tsm *tsm);
+	int (*connect)(struct pci_dev *pdev);
+	void (*disconnect)(struct pci_dev *pdev);
+};
+
+enum pci_doe_proto {
+	PCI_DOE_PROTO_CMA = 1,
+	PCI_DOE_PROTO_SSESSION = 2,
+};
+
+#ifdef CONFIG_PCI_TSM
+int pci_tsm_core_register(const struct pci_tsm_ops *ops,
+			  const struct attribute_group *grp);
+void pci_tsm_core_unregister(const struct pci_tsm_ops *ops);
+int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
+			 const void *req, size_t req_sz, void *resp,
+			 size_t resp_sz);
+void pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm);
+int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm);
+#else
+static inline int pci_tsm_core_register(const struct pci_tsm_ops *ops,
+					const struct attribute_group *grp)
+{
+	return 0;
+}
+static inline void pci_tsm_core_unregister(const struct pci_tsm_ops *ops)
+{
+}
+static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
+				       enum pci_doe_proto type, const void *req,
+				       size_t req_sz, void *resp,
+				       size_t resp_sz)
+{
+	return -ENOENT;
+}
+#endif
+#endif /*__PCI_TSM_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 14467b944da9..72d07ad994fa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -539,6 +539,9 @@ struct pci_dev {
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
index 9253b79b8582..59d3848404e1 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -111,7 +111,9 @@ struct tsm_report_ops {
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_core_dev;
+struct pci_tsm_ops;
 struct tsm_core_dev *tsm_register(struct device *parent,
-				  const struct attribute_group **groups);
+				  const struct attribute_group **groups,
+				  const struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_core_dev *tsm_core);
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 90affa69edb0..7e9a6a130711 100644
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
2.49.0


