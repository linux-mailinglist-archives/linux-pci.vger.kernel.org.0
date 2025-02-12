Return-Path: <linux-pci+bounces-21318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E96A33304
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F889167980
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBB2211715;
	Wed, 12 Feb 2025 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9/fNwzN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A32063F4;
	Wed, 12 Feb 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739401201; cv=fail; b=DR/ZZahE+cjEuVtyFZuAtC6sW4h2LS9uyJjK/E+MQ4U/dsDvTNp8pTlkSNqWgQayOk/liQCTqqr2Xdj9tsXmgwgm1SK1xHQi6yKLg+8N60zkgQFf3q8kK7vsUtGjkDpO9tNQXuekULAJfgm9mb8Q0L3Kn2AtvmyW3M0GK2/zoMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739401201; c=relaxed/simple;
	bh=K3dUNSE68qYPN4/lJPGtmOcl1Q+lC7z61yvGuj4pmcc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m1lZEqKxGvNEuMd1ERSpQ+eGNKF7i/h6FgU1EUPcsYyrUvIyC/OddWBbX74qc8STrdkZaRb+bb+lQf0TrDnBcT49FtX8e/exakb7FeIyK+SoNcEeWsmdI+gEmJJgKSUXPGocSojlkaYQ0QqnKsiLgEpgBpn85YdMJNpJ7RoH7lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9/fNwzN; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739401200; x=1770937200;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=K3dUNSE68qYPN4/lJPGtmOcl1Q+lC7z61yvGuj4pmcc=;
  b=i9/fNwzNb0wpUSqbPhnG8d6Me8W+C9DziV2BrIBwJO+ouB8WGweSalmG
   rbOM+Ie1TAX/NUho2tavukr3ss0XMKysqJjUuqX8fCw0rEI0iHxHWIn8v
   nd7Tra9M0HgmTCM9eWh/Gsw6EEti5p1aSJC6mh9w0LZXUtvuqJJt+gCPV
   9BT5EZuxCz3aZrTwIVVOh1wG633j9aSgBs/Fsylg2939ao3OkC/ZZ2wWM
   FR6u/QJOGuMcD6a1EKFjqgQ5vjRuvipMFcZSgUnCDBET7h9fG56GTdhBw
   RWoAPKTkiN5XIpZpWMsdVm14SeRdcTLRFrWNVESGbsvWTm9LQUJ0E9JOJ
   Q==;
X-CSE-ConnectionGUID: P0+th/I7Te2yzb6d6HM37g==
X-CSE-MsgGUID: HK5xgwu6RmCbmu20weWKxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40209784"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="40209784"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 14:59:59 -0800
X-CSE-ConnectionGUID: zBzpSXvtQ8+9kiwDb4e3Ew==
X-CSE-MsgGUID: jp16s7kKS9eB79Smo+NZww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="117969154"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 14:59:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 14:59:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 14:59:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 14:59:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK8nxA7b+WyYCrJkEupPIgWKYCWSd85WpzITG85M8qx+svQ7OxxnElYNTk5/YQj+PxLW39nKZNSL8dg1/Qatz1ajzVrt64LhOslV8xR6MurgGz/spVmkrY+X02C7/oKXtOgtvMFKZQOZGfiHtOCDLzBJL5ZHl2s5lgvsT+qyyUUqEBwPKA6t5hRgvjnoURwnXevL32BvHWJV7vLFoEnKiK+H0n4Z8l03a15wqllOJLVlBs6+QurIbdzhRaJUQwB8g2mi5JH1viI+dw4/yIU0xFiRxUDeM5Ib1Egt1BB6/VNTGP4esPemaSKVwkFscI7aNEz17gMUAm/6miQs1+xozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tflYUZJ9ln0wJwHbkgFGtWq62V7QTdb0ZkXa78qRKrY=;
 b=ixd1nqhOGDs8t0aL2+BlnxD+uqpnNNfq8AhRH+mQacHK8x6kGqTSYRy11NtzX/V08+XmmxBKpfIae2B1HaryfyHw5vcIOA/UkHPv2bg6kTS/9uxrulicj6xIDrAvkD5OnqS8nvEDhd3Lj4F4H8TvqtV2chWAMG9T2HrlutOwGcKFcG54aFRIBRlV6+AQQUZc84QOkODW8fyxtgIQPjmQ/rbY8jHo73fxiaBiehsRZdtOl8y/X+2z3/jgX7e1sCnyYKRvjl1oroSWLxjM1wyoqFZJBIoz1l+2yEMfCLKgDXXXkEETUwqBXLBIZWmK8bxZbGvtNvVpy6CiExWl5cx0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 12 Feb
 2025 22:59:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 22:59:41 +0000
Date: Wed, 12 Feb 2025 14:59:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 10/17] cxl/pci: Add log message and add type check in
 existing RAS handlers
Message-ID: <67ad27da2f65c_2d2c294b9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-11-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-11-terry.bowman@amd.com>
X-ClientProxiedBy: MW2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:907:1::41) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd3b199-c229-4cf4-5906-08dd4bb8ef01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5kl1mAilU5Wl8YZdUPL51qmkn2uDot856AD6C8hQ094josnc6nlWhlNMZspd?=
 =?us-ascii?Q?RLD3VM04J6OyLNv+83a9gW39qXs209957vPPAgoO/0NjhUQXv2WLfow7Cnkb?=
 =?us-ascii?Q?q4TcFSSWJclIzWc3fmclYw/gYDol+duuP13i+dgj5VFgHMOoTv8n94PtXTo1?=
 =?us-ascii?Q?sg32Om70/Tuhb9hCB07cc0OWEVwfKVRu8KolLCbUSoRdvPm8oq7fBjLve23t?=
 =?us-ascii?Q?RqBJxl+LQ5kt8fYaFnuYo+vcsOxZKWqMAtyKE5dK0PT8/3bkqm2jvtqnLTOR?=
 =?us-ascii?Q?AI0l9/5x90OoqY0BohawLrtpToE0iqGELodzdXL1joDqucVlN3cc7a6W0q+U?=
 =?us-ascii?Q?Dn3WgT+i2nrMCINGiPJi2UMp8G1sVK9hW8RFpJMKXJEloQL/XXLl9DI5z2iE?=
 =?us-ascii?Q?SKFF96A3wZQ7UQbOPGTeqoKwX/Gq5s0tO4YeOUk6cAROusBNsYQQBaGHCeVE?=
 =?us-ascii?Q?++/JN4ZKz1JgMCw87onzSJ5z0VNPGc7Y6oJcCpq6v9ibcH+uQJSdMD721Xls?=
 =?us-ascii?Q?vAk763/UbuGTSe6IEqndhALS+LOQLo9KNWhcTBT+Q/szZzQJjYABjaYsDIXM?=
 =?us-ascii?Q?VjoxNlY8bmr9WnoHZdy52DTSa8wUXHG1Ja+nWgG/QQ65K2rEtSdLia7//Eld?=
 =?us-ascii?Q?dMdbd2A3plCGnqSyjie5uRi/Dj/bs6XZrGe9shk3jXjgwwTkh3Y4mbbqiQ29?=
 =?us-ascii?Q?h36yPv8/MVzYPz6AIWwuRZFX5quEcKczKSKhYuZPG2BQp14264Tb8T2sPQBB?=
 =?us-ascii?Q?vbJheKaDc1FJM7rM734d6OpJnkDnpS21kQ0Z8n21Y50KjIr9QezOiAnu6V9/?=
 =?us-ascii?Q?ZkO+NlxFerEkmHsCiEt55Fv4ti0dvpPrGZyrpzCsj2IZSJqAjX6tDPdN90uH?=
 =?us-ascii?Q?z6+i0hw8mBKXnyD3DtpQ0GHC2HOi8+8l3mO2SEXVqDAngb/lwj4KCCQQp2HS?=
 =?us-ascii?Q?yqd884nUeRt75xe9142AJkGzSTx8HnyrilWi3kSTaglvLhW1SgffgESgAJAI?=
 =?us-ascii?Q?ogS9EGuisl6Kw+t+kdPKNDhFLiL9kykw9G9s41vLKKk+Lxbk3xvsWV0ka3Xg?=
 =?us-ascii?Q?sDrkFzQGG2r8tixHFFPzZ1l7DzHav8yZVwW69f4nf9xBvvCm1x/wDjk8gwhp?=
 =?us-ascii?Q?wV7OA8K6L3EENHVnqPb0kxu5uRoe03FEoNf6VRVPZZOw+Gz8bQ3MufGgVVBk?=
 =?us-ascii?Q?LQwJiVDnIfwsnFGos5VQHi7HwB2gaaOxhKiVU3Lq+AKnizL5e1oWDpM1kEgu?=
 =?us-ascii?Q?X9WzMHyDcJWpijNKVuGtQZFzvqVHGbQvlxtni1KLlj2fAQP2EwQy1V9FCDho?=
 =?us-ascii?Q?KVqUBztCFFf/GvUlNgpuGKWerOEVuAzMEAsomNbQv8cK0pZ2WNj2Cxuer2Wd?=
 =?us-ascii?Q?ErMJRsrlYXiwIuUH1AQQZ5ddcc8IJb+OtWmtuhj9p7B69YMmehNmT/ZJPHFC?=
 =?us-ascii?Q?jYp/2fAQaxU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qK/CuQjD4TX/0dCcguMnPDZNcpNKGnmSWkMGO8yM67YqnJOKtCpPCCS9vSEC?=
 =?us-ascii?Q?zXGCzuFWaJ344XonqLd6iKtRtpCUCf7wuUCmkUsK4vw9XjaMqGNQOX0MZ+Hq?=
 =?us-ascii?Q?oTvyU7CLnx9ibkraKe9AiJUeL8JhXZtiSeHOK/ZxUmsqs0GvnWS0w2n9+uZO?=
 =?us-ascii?Q?hp4T1GijKy+av3aoUwtTA68CdVETx+MKIrJHNoJZnFLXtt1ToxEy8Co4T6/m?=
 =?us-ascii?Q?AzEN8uOKCviC6WEw2gz5R1B4W0b0BQ9MVneeLml4PlK+MkM7+r0QXR2QbiJd?=
 =?us-ascii?Q?YF5W0Ok+scPCAPbYEtf64YqbEIYYbcZJGJc6d4CYDH6+lA0sPP+VZ8GQWdB1?=
 =?us-ascii?Q?u2COPlr45W7aOd9GKoCoryO14DWxLStJ1EmqKh5RlJI84MEAxFEgkLN5WoD9?=
 =?us-ascii?Q?0DM6Va1Y2sum/5K4Yqkk0o6j/nEj+Rm7Ib5PN7PrOWJ+jHo8avc9Ue0upq+r?=
 =?us-ascii?Q?Hvv4R59RdNehgqzE/XklmKuYFIYCOPqykyck6C1JlHRxPZfjSTnYGnUeHHZg?=
 =?us-ascii?Q?3ujLQH3md94T4C2h+QyVQPPXIS88ctdZ+2kzO1SHJdGoarBUy9xBfXQWadkG?=
 =?us-ascii?Q?cmHxHCpcsMKm6RdSaJX43/Qgdkc1MisjrmegwvA5N6eGSb3sJI+c+/N7WHll?=
 =?us-ascii?Q?H68JpQd3rKnb6ZLu9AV2SRKvWc15KWbP5E06QWPKv8aQoGCUk6UI9c2glyPU?=
 =?us-ascii?Q?PFaWu9fRLqFqHFr0kVK+s3MJIXw7TPZzakVk/gS1fucQA3CKelAcOq76j47C?=
 =?us-ascii?Q?Im3VCaz16wRzprY6Gl1FAN3ZiWLVvDJqSkOLD1gscAnrJEWmvs0jhaOLp7jn?=
 =?us-ascii?Q?1/0QIDJhrjkWzOdI8b/mH4fkx7bjDXGRJRLcARnMil2flTMnlTyX1XzrV5Kd?=
 =?us-ascii?Q?hs2pV4FYCpmk7Pcz7J3NjpL3Xz5U12oB5HFMZw0HndnaH5O5bwPlecuGViBJ?=
 =?us-ascii?Q?vopYfCTqTf4DCC7mjtr3pNcw42JQBjVD9q93NO0/mpvo/BVTmH8sJ1j4pTov?=
 =?us-ascii?Q?e5kDpdYX0XchFCTRig2ySKTvLhXHnUD79h4S33skIwg40xHL5Jp3dyWH76JB?=
 =?us-ascii?Q?dTfEJ3KRA9VrbJS8ScBwQeG0WfC6xOo8CAifL9yjlKdK9oDsNFqSwMUmREX6?=
 =?us-ascii?Q?XGzc1ZGfb/x/x/apfBBsy01Nhy4T0sWa9+Sp0u+HV5E0N3bCgHYTuDhjmS+5?=
 =?us-ascii?Q?pnnEpE3zeiysJsF51xAx0Zsxg4MHjf0HCvdDm4hBwL13Pl8SMvjt3GXQ+pmx?=
 =?us-ascii?Q?rJwzfoEcUyQn2LfV8O93viBndscNmPHgldOD6H4Wcv6OOEMXHxLAVv1Yxzps?=
 =?us-ascii?Q?41v2VXXuwkCoYsnolJVmxXs6f6kfy04XvRgDrwwIuvFKAUiklX0Eeg3bPZJs?=
 =?us-ascii?Q?g9Pm84YOaev0aadQRs9xTuND5LKJQ1nfCaAxvyiAVMFo7wEstcdQIHkd++GS?=
 =?us-ascii?Q?BpDBw6NUsrNAj2ESa3Ki2MbdbPh6midHLObhxF+hbL3hrQKV0BphrYUNQzXX?=
 =?us-ascii?Q?g0VCsOjFfnSglqCPEKHHhwNR2xNeoK27Kk26GdmZ0FXmfVA6fNqlBWyfH8bk?=
 =?us-ascii?Q?piuJClRTNlQ4Rk+NRhmIAMbUI74mmJttFr2abClSeODJe1RJW3pUt2GIePpy?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd3b199-c229-4cf4-5906-08dd4bb8ef01
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 22:59:41.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBsc4rFyXJpqQMBCn8K7hOZ/4kOJ5LrEBB0inuX97l3pAiSKPXCFwrgZjB7uM5YYjVdhxrej590I9ERu6fhOf+dXYYZG1vM1z1hIWxvLijQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed in order to help debug CXL error handling. Update
> the CXL driver to log a warning message if the RAS register block is
> unmapped.
> 
> Also, add type check before processing EP or RCH DP.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/pci.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 69bb030aa8e1..af809e7cbe3b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -658,15 +658,19 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  	void __iomem *addr;
>  	u32 status;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>  		return;
> +	}
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	if (is_cxl_memdev(dev))
>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);

I think trace_cxl_aer_correctable_error() should always fire and this
should somehow be unified with the CPER record trace-event for protocol
errors.

The only usage of @memdev in this trace is retrieving the device serial
number. If the device is not a memdev then print zero for the serial
number, or something like that.

In the end RAS daemon should only need to enable one trace event to get
protocol errors and header logs from ports or endpoints, either
natively, or via CPER.


> -	}
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> @@ -702,8 +706,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	u32 status;
>  	u32 fe;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");

Is this a "never can happen" print? It seems like an oversight in an
upper layer to get this far down error reporting without the registers
mapped.

Like maybe this is a bug in a driver that should crash, or the driver
should not be registering broken error handlers?

