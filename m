Return-Path: <linux-pci+bounces-27833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8974AB95A4
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833AD4A370A
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DAB221289;
	Fri, 16 May 2025 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGwQ7lHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7F221F28
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374553; cv=fail; b=GC2KlPSGUA1a4GeRI3if37Kfvw6zCv+I2czWjPQfgCv27GMSFtUnOic27s1+X9UWMVanUk2D7z2YPMHWVGAK/HV4ISoqlMliE2tEUcgywyctsf2AD0ZyXw3z4zPfqBs207RS5iK4CbT5IUerUfqnqLB64r8KsWmGwCIdIIKyfMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374553; c=relaxed/simple;
	bh=g8vg3gt1mdTl0aIupRVMbyTMczCx9f7dh2dJiMTH3B4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fbXuZ5OugmC1aHKuSXqfoClokJpJXjb8ZeajRdbvBxZ0YKdVPYBY+bq2sIz+x7WRsDdR+4G4pcQNBZViRwbegpAkJQXu500s8b3o42O0b10ZNWsuTEtxvtIfjW8EC3ZDFy+c+9AaDwzt0m8rNyuUPKE++stdL0W6iTEpwDp+yN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGwQ7lHs; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374551; x=1778910551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=g8vg3gt1mdTl0aIupRVMbyTMczCx9f7dh2dJiMTH3B4=;
  b=WGwQ7lHscBOqFXSZ+IMB0yaMW5bKsSV9G54X/+cP8qVvUTjPg+au5Fv0
   079R3GYlu1VsGZh7l+m+eb9BawieHCM1vhLzYWrv2PB36nBIW0W2FCe9T
   r+ZxLgbZOY84eOIanJQulnPJbQQ5Coci5vieiMh7VDg8B+tYSEKn7XigI
   lBGIOEd7XLpe3g+bynPv7O3jyX2PVLeh1rfTgeGmUQGvEyaiooFgtVpkj
   VZ3ZEms5oQgFyyfJSNWs2wEcZJfTXICyk4zMdAiObfnEV/K1SOOGRqH3Y
   7plBpwHA7hCyesQZVs/hQtRv5vwobIYx1bVJ56tBOyPtI+zsZkkFFrW3d
   w==;
X-CSE-ConnectionGUID: siYapk1nQtSmTVUo1PMdSw==
X-CSE-MsgGUID: S/f/eBJxQIefZu2rC+IpFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36953053"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36953053"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:49:08 -0700
X-CSE-ConnectionGUID: 66xVy3xZSfWq1tSr8dY6PA==
X-CSE-MsgGUID: Pitjp5IXRnWuO9uwBFOH8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139084856"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:49:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:49:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:49:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq/T40R7BnhOebwyysG8XuQK7OfbhPO8KiNkYgRGW7lMGneeOlQMzHCA9teyuZRc7ywivccQqx/kZHEMa/r3nnDxCVM6i58isbQOG31bmv7HFJsJJ83MILFQtTyzu7l1Ucb9guU/7htdZiYF74o7SC5zg4ypzQIaQ06I5qeDPD+FqggF32axsYbBGyuSH51GAUdzpjX3wp1TDCqIwZHgfFLNuj1YcKb2Uq6F+Cb7DB4ssnmdmYGbjI/pmsEci/nv1uVGaNJxv5XDEhczOsnavkGyitwQar5UuGlG0vNbYcxxbAcWzWOWBFx9Iv8p4kCLWo+zzrKe0ul2Ud1Xd6afwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiRIec7YdSSHz0CfuLG07jQkY7b144NVfqJJGdrPd/c=;
 b=RxsmgczM0Q4qIHYsloXVgQ1i68fGPS9K6MXpiNSvWpGJOy+eDUS0JqMAPpx/GCQz/KMKlKtxIT/FfabRe9VSDDP1YiMbRLZl5UC1vozpbmd6rP8OkRTANvndYe8Vvj9PVEQjJ1SfaluN9CPj+1g3qACEYmiFe5kTO8ZPDPgwAY+xKUeXR+o8pOOjYbyIJ6drY3ISZS8xaC7blVVgkJAO053r/QgJ8O54hZkXJiy68vvMymHxHBfctXu6JVFWdRs/yg9w62zcgQm92dH7h2LEb75iVY1YC9Cyjfn9xldUn7tiVY0amqeV9eX9m4wsZAt44iftuZMfIxYub4OZI6cgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 05:47:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:49 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host TSM driver
Date: Thu, 15 May 2025 22:47:31 -0700
Message-ID: <20250516054732.2055093-13-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ce4b5e6-ffde-46dd-9b17-08dd943d3104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gVp6EjzDhcie21ezfqoBvo8bI3oCCspVFGthTGClBVOzzUvXJyOq57q0qftm?=
 =?us-ascii?Q?Fxl0/H012m4m15zpprCZgfzSXfO4gT1Jf77YIss1dEOnDpALo+EOWZ2ddCgK?=
 =?us-ascii?Q?0TA/27uAPP2g/pCOIdCyhY+PT4sMzumO0YYhknP4rulSoljoXQnKHaS7mSjR?=
 =?us-ascii?Q?wAsPRH39MfbuWIevOrAAkJvFYahj4ze7qu8gmNO8msqoPGbj43fQvn5EyTq6?=
 =?us-ascii?Q?NSbinXZz4oPeHb7h0aMCDZ7zTAi55KbrWb7rGz0c7wi+kvPks9Q4jAZEUomi?=
 =?us-ascii?Q?rqs9rXfAMTYtq208Qy8hjxStJQxS8qoUcMhT8MleuLI0cHe/JiZM3KNDknx/?=
 =?us-ascii?Q?6UaOkYu0Sqy7mNFajrpIihrOvlrb9bDiEBNfJExCCJXs9Aw7EPKc8+b2GvcD?=
 =?us-ascii?Q?SIMPsjdoXmHjdq+lVIzN2dbN7IFncfkDwIz48CAWKA7KBStU8zKlaQ/stxVO?=
 =?us-ascii?Q?VZi4ZsCQq/SZvoTydKFCvfgQPoSzopn9UdAQWV8Y4toeVDO4Nf0RtU7gdsXG?=
 =?us-ascii?Q?zzJp6KAxal6GxWfeQAF0pq8B2QpEMkf3O2wvfffLSeRmscnMPBdJrqMu2WkB?=
 =?us-ascii?Q?BXV+ZJz8QemunJ5wzxGN6mAyN6V9XGmcrUNO86NcOBRSYev+VZdxga/Ve8Wb?=
 =?us-ascii?Q?0Mlm98TdgoHfWhl97l6xLooYQZrmjOG1HuYbulr1ct4kyD6d92Eybu8KA1Dz?=
 =?us-ascii?Q?1ZlTVDEVKSOpTUjBUue3LPZkM9B3DofY2VKDz/UDJr7unxrCWunnBLGrk3B5?=
 =?us-ascii?Q?SYt6Z9qjupkmJLACfBvhlgOTkqrksxTqbD+9ammDUEEGu2S8al6gPUOGQ76D?=
 =?us-ascii?Q?97VBWDtSEzfiPaQknb9QNPA9hHOj10Pad0ZrWlzHyAF2KXHgD8tjfXS5hdhv?=
 =?us-ascii?Q?H7iz4VKh78r5B7s4EBSwqhqzUcQlF4ltwlfMSef/CoMC6Tv38UYx0DhE8yDu?=
 =?us-ascii?Q?b3rIEvjO+D50NlkQ1UmjZLil9UJ8r8NmfiwOSjV/LGwwipxLKJdZp+EDPla0?=
 =?us-ascii?Q?6tIHdwTOn0js9JCQgoz/kbJ7jOBXNt5E8UImo9U+Y61nnrQdnlJIxkD0izx4?=
 =?us-ascii?Q?fkYLvuKkMA02PHZnNX1/ooFjukJP5ScoD1x4YUnLQ0Kbs69ttetkyHj6/+ae?=
 =?us-ascii?Q?0D8iOcuWI0EcN7FVd9f6NexdW7/yusak3C5vmPn6HMkARnbLMZwvbGbnPxEQ?=
 =?us-ascii?Q?Rsz15I+VUkebSbTdP2fRy2+LfBKgBYMzz0uWs5M8XngMC7aIqi7dGxYwp3rP?=
 =?us-ascii?Q?x0/F0quJ0+WjrQGWK77kMp7LqvrUBoult/fA5Ewv72h6VqdoumX6JCujB6Fw?=
 =?us-ascii?Q?oi7kkPaKIPkUe79t2uuAlNhB72OUHviA6mJ8uBQOtHKfRSLPLKX/meVhHNsu?=
 =?us-ascii?Q?jXd8zvLIHJUOq6YyC/Em3HBpDMSYFpTXLKz1Qn+FlKmCS70+y4jYQEntvabT?=
 =?us-ascii?Q?JAFkrccHfg8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ImOtVqHjyHY4fGgsYhACUv/fO5ar7LmHrux5L3A47Zms3BIgGCTXJW5wDF+?=
 =?us-ascii?Q?luFnicomGejCj4HiO8uEEA1MzHdS5BCJpv/7C8libwzIURUHctFMW8NNXr2R?=
 =?us-ascii?Q?kwxx2KZxlcZJBX/xm6r0Hn72uTaLIoyqA8Uf4hWoNPLZWtsLl0+HHCjbDeND?=
 =?us-ascii?Q?5Nt8v+zSIftho3Cgq/qc/f21Isz0y5NQ64Vgz098sPgRW/spIkvchktNjz+h?=
 =?us-ascii?Q?q8vlURGt44S/awVRf9jvsRoq0XD/TBb3FdAx9ZsD0mLCaGmoNjiJ9qq4K/q8?=
 =?us-ascii?Q?t6fijktKfRatwcIEQxFBacBl+hgIZhM9XaLuBGt3ekH+1iZ9gPzk7XM4AGfT?=
 =?us-ascii?Q?dPI2KdSao/wqt+AWHSsIJtADIhxinTCW6nYjdMpAKxEwFQ4wD0+UOZZWkmm8?=
 =?us-ascii?Q?pEpdnNd9wft9mUswkOawXHkEHBJyaRIMceVVyQM+7NnryYt2yuuskDFcxYS+?=
 =?us-ascii?Q?xDno3UpVx21+gvjYPJHGg3MTsmM1DzbvzjsFdPoxeQP4miocZ6ZPs7rcZnBW?=
 =?us-ascii?Q?oKS1ceqtWMqEdq135bT31yBuAOpdPZYIYKj5gv1OG8Nv5E0oIe+rEMw+Qyw4?=
 =?us-ascii?Q?4pOFKgi2uYj8dWX0qPdRajOF9FZAhm1BLbZGqcnWb3fZl5q28DsFcMKCxBZe?=
 =?us-ascii?Q?qBlcBYGU6mYarEDTr333+wpym7F7aVlwpIzMmuxPScn3zuN5U67UbKjckjGF?=
 =?us-ascii?Q?4yv1Um7JBDLzUDAue4LrnjNnKJ1CZAaDW/jmm9cL4lTbLdm4g02XD/E9SynJ?=
 =?us-ascii?Q?Slhu7iQOCrdrwmV/J6duLFaegp5apZhWMwnYkXvvs+NsC3U6covfUqoFQMOJ?=
 =?us-ascii?Q?1BailYAxN5dVk5kMyjGTDwTK3s27rYa1Br4SyhLBel6lyVwjiA17322ZbRfM?=
 =?us-ascii?Q?qHVsoyP6cK3koexctgJ0xNuC81SP38lwLNF6jgx9c4MfX7xX6VjdM05GZ2PY?=
 =?us-ascii?Q?UWeCnxrPevq9dD47nJeaQy1pirdsKTxcI2MF/kj5jDqEU4nGyQfT8YdDfc8+?=
 =?us-ascii?Q?Rv6l8UIQJDtiVVU6nMUh9fKUVYeQaygJJcmqIT4eVB+Y6DI/1m4cQD0iJbVC?=
 =?us-ascii?Q?wzE08PX/NWQTaTH8RdSAwYR1Z3gXKSGx3rlzy1HS12In70FNiUe9bxEHAbb4?=
 =?us-ascii?Q?pUzkG6iYrn6iiS4ySv1OhDinTLLzidIoHpnwQkjXjdvSwlUTZ3iXcJmjrJKI?=
 =?us-ascii?Q?TBQZfWwf8De26y2muGFiHDF+V0C96YSYiznmgFAyEsrflu7vO4SVnuw98+ba?=
 =?us-ascii?Q?vJCP3WqGOSXp6IH+N+LScaGTp1eNRX94+C6XpumNzU2fVQyemAimwgExPZKI?=
 =?us-ascii?Q?k5L+IXLvcrSKLNBhEG+m0JMjulgyg959bh5enQR3t9ntFkvOxqA2n++30f5W?=
 =?us-ascii?Q?SjaWy21cjYs07GnaTJ5ImzNfbBcy5vwzi73MkdS/DlHqhdr49HfSELIwQdVb?=
 =?us-ascii?Q?IPnshcx0RvkEUiPVHWaFDrI04lzpX4g3QYl+IqzxxlWSH4WQtjLz7tLpwjNt?=
 =?us-ascii?Q?S91nZvpvbqq8+CzIkMK0EKASJBJZrR/COUx1FmyMszlcAJL8rav1/lU5xoSx?=
 =?us-ascii?Q?5xXbhiwfbine4l+bJ0fm+S5NFlwMm7ll9PVyVwsClfMKsBUK8euilg4v61mc?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce4b5e6-ffde-46dd-9b17-08dd943d3104
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:49.4474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oH3rNWPA/bSApVdyh042nciLP2lqL1rI6uG8NvKS49gkt+zaYt7fP5uQjh6iubsEaXq9Wl7JSvGyf3E31QEJZd21kpJCi8UPf6wTrIKEbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com

From: Xu Yilun <yilun.xu@linux.intel.com>

Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.

pci_tsm_bind/unbind() are supposed to be called by kernel components
which manages the virtual device. The verb 'bind' means VMM does extra
configurations to make the assigned device ready to be validated by
CoCo VM as TDI (TEE Device Interface). Usually these configurations
include assigning device ownership and MMIO ownership to CoCo VM, and
move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
TDISP message. The detailed operations are specific to platform TSM
firmware so need to be supported by vendor TSM drivers.

pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
to TSM firmware about further TDI operations after TDI is bound, e.g.
get device interface report, certifications & measurements. So this kAPI
is supposed to be called from KVM vmexit handler.

A problem to solve here is the TDI operation lock. The TDI operations
involve TDISP message communication with devices, which is transferred
via PF0's DOE. When multiple VFs or MFDs are involved at the same time,
these messages are not intended to interleave with each other. So
serialize all TSM operations of one slot by holding the DSM device (PF0)
pci_tsm.lock.

Add a struct pci_tdi to represent the TDI context, which is common to
all PFs/VFs/MFDs so embedded it in struct pci_tsm. The appearing of the
tsm::tdi means the device is in BOUND state and vice versa. So no extra
enum pci_tsm_state value is added for bind. That also means the access
to tsm::tdi must with the DEM device (PF0) TSM lock.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/tsm.c       | 227 +++++++++++++++++++++++++++++++++++++++-
 include/linux/pci-tsm.h |  64 +++++++++++
 2 files changed, 290 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index d00a8e471340..219e40c5d4e7 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -50,10 +50,65 @@ static struct mutex *tsm_ops_lock(struct pci_tsm_pf0 *tsm)
 }
 DEFINE_FREE(tsm_ops_unlock, struct mutex *, if (_T) mutex_unlock(_T))
 
+static int __pci_tsm_unbind(struct pci_dev *pdev);
+static void pci_tsm_unbind_all_vfs(struct pci_dev *pdev)
+{
+	struct pci_dev *virtfn;
+
+	for (int i = 0; i < pci_num_vf(pdev); i++) {
+		virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+						     pci_iov_virtfn_bus(pdev, i),
+						     pci_iov_virtfn_devfn(pdev, i));
+		if (virtfn) {
+			__pci_tsm_unbind(virtfn);
+			pci_dev_put(virtfn);
+		}
+	}
+}
+
+static void pci_tsm_unbind_all_mfds(struct pci_dev *pdev)
+{
+	struct pci_dev *phyfn;
+
+	for (int i = 0; i < 8; i++) {
+		phyfn = pci_get_slot(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
+		if (phyfn) {
+			__pci_tsm_unbind(phyfn);
+			pci_dev_put(phyfn);
+		}
+	}
+}
+
+static int unbind_downstream(struct pci_dev *pdev, void *uport_subordinate)
+{
+	if (pdev->bus->parent != uport_subordinate)
+		return 0;
+
+	if (pdev->tsm && pdev->tsm->type == PCI_TSM_DOWNSTREAM)
+		__pci_tsm_unbind(pdev);
+
+	return 0;
+}
+
+static void pci_tsm_unbind_all_downstream(struct pci_dev *pdev)
+{
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
+		return;
+
+	if (!pdev->tsm)
+		return;
+
+	pci_walk_bus(pdev->subordinate, unbind_downstream, pdev->subordinate);
+}
+
 static int pci_tsm_disconnect(struct pci_dev *pdev)
 {
 	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
 
+	pci_tsm_unbind_all_downstream(pdev);
+	pci_tsm_unbind_all_vfs(pdev);
+	pci_tsm_unbind_all_mfds(pdev);
+
 	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
 	if (!lock)
 		return -EINTR;
@@ -392,8 +447,12 @@ static void __pci_tsm_destroy(struct pci_dev *pdev)
 
 	lockdep_assert_held_write(&pci_tsm_rwsem);
 
-	if (is_pci_tsm_pf0(pdev))
+	if (is_pci_tsm_pf0(pdev)) {
 		pci_tsm_pf0_destroy(pdev);
+	} else {
+		__pci_tsm_unbind(pdev);
+		pdev->tsm = NULL;
+	}
 	tsm_ops->remove(pci_tsm);
 }
 
@@ -435,3 +494,169 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
 		       resp, resp_sz);
 }
 EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
+
+/* lookup the 'DSM' pf0 for @pdev */
+static struct pci_dev *tsm_pf0_get(struct pci_dev *pdev)
+{
+	struct pci_dev *uport_pf0;
+
+	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
+	if (!pf0)
+		return NULL;
+
+	/* Check that @pf0 was not initialized as PCI_TSM_DOWNSTREAM */
+	if (pf0->tsm && pf0->tsm->type == PCI_TSM_PF0)
+		return no_free_ptr(pf0);
+
+	/*
+	 * For cases where a switch may be hosting TDISP services on
+	 * behalf of downstream devices, check the first usptream port
+	 * relative to this endpoint.
+	 */
+	if (!pdev->dev.parent || !pdev->dev.parent->parent)
+		return NULL;
+
+	uport_pf0 = to_pci_dev(pdev->dev.parent->parent);
+	if (!uport_pf0->tsm)
+		return NULL;
+	return pci_dev_get(uport_pf0);
+}
+
+/* Only implement non-interruptible lock for now */
+static struct mutex *tdi_ops_lock(struct pci_dev *pf0_dev)
+{
+	struct pci_tsm_pf0 *pf0_tsm;
+
+	lockdep_assert_held(&pci_tsm_rwsem);
+
+	if (!pf0_dev->tsm)
+		return ERR_PTR(-EINVAL);
+
+	pf0_tsm = to_pci_tsm_pf0(pf0_dev->tsm);
+	mutex_lock(&pf0_tsm->lock);
+
+	if (pf0_tsm->state < PCI_TSM_CONNECT) {
+		mutex_unlock(&pf0_tsm->lock);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &pf0_tsm->lock;
+}
+DEFINE_FREE(tdi_ops_unlock, struct mutex *, if (!IS_ERR(_T)) mutex_unlock(_T))
+
+int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
+{
+	struct pci_tdi *tdi;
+
+	if (!kvm)
+		return -EINVAL;
+
+	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
+	if (!lock)
+		return -EINTR;
+
+	if (!pdev->tsm)
+		return -EINVAL;
+
+	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
+	if (!pf0_dev)
+		return -EINVAL;
+
+	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
+	if (IS_ERR(ops_lock))
+		return PTR_ERR(ops_lock);
+
+	if (pdev->tsm->tdi) {
+		if (pdev->tsm->tdi->kvm == kvm)
+			return 0;
+		else
+			return -EBUSY;
+	}
+
+	tdi = tsm_ops->bind(pdev, pf0_dev, kvm, tdi_id);
+	if (!tdi)
+		return -ENXIO;
+
+	pdev->tsm->tdi = tdi;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_bind);
+
+static int __pci_tsm_unbind(struct pci_dev *pdev)
+{
+	struct pci_tdi *tdi;
+
+	lockdep_assert_held(&pci_tsm_rwsem);
+
+	if (!pdev->tsm)
+		return -EINVAL;
+
+	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
+	if (!pf0_dev)
+		return -EINVAL;
+
+	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
+	if (IS_ERR(lock))
+		return PTR_ERR(lock);
+
+	tdi = pdev->tsm->tdi;
+	if (!tdi)
+		return 0;
+
+	tsm_ops->unbind(tdi);
+	pdev->tsm->tdi = NULL;
+
+	return 0;
+}
+
+int pci_tsm_unbind(struct pci_dev *pdev)
+{
+	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
+	if (!lock)
+		return -EINTR;
+
+	return __pci_tsm_unbind(pdev);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_unbind);
+
+/**
+ * pci_tsm_guest_req - VFIO/IOMMUFD helper to handle guest requests
+ * @pdev: @pdev representing a bound tdi
+ * @info: envelope for the request
+ *
+ * Expected flow is guest low-level TSM driver initiates a guest request
+ * like "transition TDISP state to RUN", "fetch report" via a
+ * technology specific guest-host-interface and KVM exit reason. KVM
+ * posts to userspace (e.g. QEMU) that holds the host-to-guest RID
+ * mapping.
+ */
+int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
+{
+	struct pci_tdi *tdi;
+	int rc;
+
+	lockdep_assert_held_read(&pci_tsm_rwsem);
+
+	if (!pdev->tsm)
+		return -ENODEV;
+
+	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
+	if (!pf0_dev)
+		return -EINVAL;
+
+	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
+	if (IS_ERR(lock))
+		return -ENODEV;
+
+	tdi = pdev->tsm->tdi;
+	if (!tdi)
+		return -ENODEV;
+
+	rc = tsm_ops->guest_req(pdev, info);
+	if (rc)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 00fdae087069..2328037ae4d1 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 struct pci_dev;
+struct kvm;
 
 enum pci_tsm_state {
 	PCI_TSM_ERR = -1,
@@ -28,10 +29,23 @@ enum pci_tsm_type {
 	PCI_TSM_DOWNSTREAM,
 };
 
+/**
+ * struct pci_tdi - TDI context
+ * @pdev: host side representation of guest-side TDI
+ * @dsm: PF0 PCI device that can modify TDISP state for the TDI
+ * @kvm: TEE VM context of bound TDI
+ */
+struct pci_tdi {
+	struct pci_dev *pdev;
+	struct pci_dev *dsm;
+	struct kvm *kvm;
+};
+
 /**
  * struct pci_tsm - Core TSM context for a given PCIe endpoint
  * @pdev: indicates the type of pci_tsm object
  * @type: pci_tsm object type to disambiguate PCI_TSM_DOWNSTREAM and PCI_TSM_PF0
+ * @tdi: TDI context
  *
  * This structure is wrapped by a low level TSM driver and returned by
  * tsm_ops.probe(), it is freed by tsm_ops.remove(). Depending on
@@ -42,6 +56,7 @@ enum pci_tsm_type {
 struct pci_tsm {
 	struct pci_dev *pdev;
 	enum pci_tsm_type type;
+	struct pci_tdi *tdi;
 };
 
 /**
@@ -86,12 +101,40 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 	return PCI_FUNC(pdev->devfn) == 0;
 }
 
+enum pci_tsm_guest_req_type {
+	PCI_TSM_GUEST_REQ_TDXC,
+};
+
+/**
+ * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
+ * @type: identify the format of the following blobs
+ * @type_info: extra input/output info, e.g. firmware error code
+ * @type_info_len: the size of @type_info
+ * @req: request data buffer filled by guest
+ * @req_len: the size of @req filled by guest
+ * @resp: response data buffer filled by host
+ * @resp_len: for input, the size of @resp buffer filled by guest
+ *	      for output, the size of actual response data filled by host
+ */
+struct pci_tsm_guest_req_info {
+	enum pci_tsm_guest_req_type type;
+	void *type_info;
+	size_t type_info_len;
+	void *req;
+	size_t req_len;
+	void *resp;
+	size_t resp_len;
+};
+
 /**
  * struct pci_tsm_ops - Low-level TSM-exported interface to the PCI core
  * @probe: probe/accept device for tsm operation, setup DSM context
  * @remove: destroy DSM context
  * @connect: establish / validate a secure connection (e.g. IDE) with the device
  * @disconnect: teardown the secure connection
+ * @bind: establish a secure binding with the TVM
+ * @unbind: teardown the secure binding
+ * @guest_req: handle the vendor specific requests from TVM when bound
  *
  * @probe and @remove run in pci_tsm_rwsem held for write context. All
  * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
@@ -102,6 +145,11 @@ struct pci_tsm_ops {
 	void (*remove)(struct pci_tsm *tsm);
 	int (*connect)(struct pci_dev *pdev);
 	void (*disconnect)(struct pci_dev *pdev);
+	struct pci_tdi *(*bind)(struct pci_dev *pdev, struct pci_dev *pf0_dev,
+				struct kvm *kvm, u64 tdi_id);
+	void (*unbind)(struct pci_tdi *tdi);
+	int (*guest_req)(struct pci_dev *pdev,
+			 struct pci_tsm_guest_req_info *info);
 };
 
 enum pci_doe_proto {
@@ -118,6 +166,9 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
 			 size_t resp_sz);
 void pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm);
 int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm);
+int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id);
+int pci_tsm_unbind(struct pci_dev *pdev);
+int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info);
 #else
 static inline int pci_tsm_core_register(const struct pci_tsm_ops *ops,
 					const struct attribute_group *grp)
@@ -134,5 +185,18 @@ static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
 {
 	return -ENOENT;
 }
+static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm,
+			       u64 tdi_id)
+{
+	return -ENOENT;
+}
+static inline int pci_tsm_unbind(struct pci_dev *pdev)
+{
+	return -ENOENT;
+}
+int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
+{
+	return -ENOENT;
+}
 #endif
 #endif /*__PCI_TSM_H */
-- 
2.49.0


