Return-Path: <linux-pci+bounces-27830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52D1AB95A1
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8A11BA47F4
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B565E21C9F1;
	Fri, 16 May 2025 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7zcl1Yj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2EE221728
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374504; cv=fail; b=dwhZEuxjWKawFgQfgEDmvErWbZ6v7nWo6uva8rdtBox69JfTkv3X2MEe+pEhmhUzHGoJafbGBXfZGaGIiQKjWG8OvfmLGvqJ+RdIeBoHow2jP0J/ULYU/u/Y8cOVarQdZFUqK+0c/lr+/xIehzVJV6/XWJSQ/qC/WC634zSZ4+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374504; c=relaxed/simple;
	bh=NdMN2/8wkZDiwJiwer/F5GLAnCjybO3qlTZgGoz4t9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQG9FZ56th3sh0VPSz0m7jWuqaskm4jPBW0r0hoTBFl3qT5DMZ7Q8LaFujyObn3vGPdj6nA+XfAC4grxHQTrL+HJ6GfSP4cOiMZeMpYuu3z67WJHPQCnBpAnAq7IWXPoJi0/O+kjVil2x6PQWQOrw9Vtg1aKyg8E3f9uAKVkfHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7zcl1Yj; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374503; x=1778910503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NdMN2/8wkZDiwJiwer/F5GLAnCjybO3qlTZgGoz4t9c=;
  b=M7zcl1Yj9C16u8whkofKIkoOMZBfNZXGbM4Lno1kwNr2FByghclSU6sq
   vSRJq5N4PcukalyyPp6ek7mNX2txmZnal80hldT4p5oWTGoSXWVtdyzF4
   eaDLaXvwHHSAL2gEMEtQDIgm7f8nlfzyHA4qsO6L78tqWL+Zh5Nhplwth
   k989HGEqAOgoW432vAb56M2ykm0kc9JEnGW+fOenQgajpiI7TGmmAY85U
   8C1QmKcS/wLXoNA1xllpFySyFb3TXhw4tuSrMi4h1Wp9apkPwlK1BgJJo
   wAaxMdA5XHr//a45cKST4Bu/upZ+oZui5lBJY1aEM0pJHORu5USwA7cDc
   g==;
X-CSE-ConnectionGUID: GL9Yc6KIQ+yAAdvjb0+Yeg==
X-CSE-MsgGUID: W1uc36mORk+ahCUB1/kjhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36952873"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36952873"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:48:20 -0700
X-CSE-ConnectionGUID: Fu7fm2AZRMeDnEkjdqhhxQ==
X-CSE-MsgGUID: 8kjnOginTKmwAgeMZdEqOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="169654677"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:48:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:48:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:48:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:48:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HT6ua0DUOvpVUlwtI4p7CdWqFWRpMvlSIrGtOQk5ftTcI+cVXuD3eLIp1zpeqgfMOViWXsQvTKDCbhL3kyzdcX12bP2gexRBbvSPG08KL3CfOMHTfa/nMkGXz61RuxdjLoFuoXY9NSd5V74QtyYlTxzkQhQDPk5Y7dl3vfUaTwgczYySyNS/L74YzgbH/bhesFtQf6ok8kWhzPdnBmpjPXXpkFq/EQUM1T99t2jZupWE6htjhKi4YhYSHT4xSKNTmU6VbAGHTvZrI1F4zTvxNfOjtp1B4mr3ZoLbt25oxPSyUJcJIv6gwilWa9hX6P/rLG6h2hoLYhJ2hHvU2kX6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+8HVlNvvmdTqImWx3m+Noz+GN3UiefygEz/6du5lEM=;
 b=SLgSj6iddhTP7EPkMNjy66xP6fhr3L8DQa1ehXfzvh93Fd7Ilm2/oH3bQmJAKpaut3Onpri/KWbEgISC7thNaUuQVTuAAbljWManys0JD08Zf7Xh6VLi4rKO6a45gpaaaOnuoA+8x/phwOs23/DKFjsaYxrYs5bVc5TDaspO8fkdgApXUTxkLA7ufuJcHQIYTuQsRr3zOQ5VNXDWzRBOyjL4OqW7+UEnU3lA+QfNnmN1BEu4o0mWnLR7CDHjEWsZ3GAESRituaR6XtRAHvG9w4jfBPSKlK5eyM+PEx4tUfiX4LfuZnScaU/zruQ6VJJjYMHcbkIMUYv7APasP7u+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 05:47:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:47 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>
Subject: [PATCH v3 10/13] PCI/TSM: Report active IDE streams
Date: Thu, 15 May 2025 22:47:29 -0700
Message-ID: <20250516054732.2055093-11-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5aecc3c4-3ca9-4680-8c0b-08dd943d2fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P54m30fj7O08HdCmgQN/LKWMX8UNoSeQcQV09/ERKFLB4UTBRJsJQeGlk08T?=
 =?us-ascii?Q?D8I6R5CVMZR0WL6MiwVcDoKE7CKZKJlu0Ep5JzmqcxTZ/jVzoiir7g2prmeX?=
 =?us-ascii?Q?5lvzkr1/PypQC8FlzorDd2PVObMgQdg5hj7Ex6TcrBXdUk8xWSNbLATs0KpM?=
 =?us-ascii?Q?PBLCq4MF31Rdxqn9VZ0RxZ8elTz0YOGd8P0jyKDpQ8hsQb489EGqcVD+/Ezv?=
 =?us-ascii?Q?QONkmLqDVHpaKRrecfxBi56zGNqLS1pGjMkskbSpxvdFA/+X6Mo5uJqhBQno?=
 =?us-ascii?Q?mWDRVov1LvdC2On1p4JL2i29N75mirWL1co+xZUM7zCQ859K5xB1ByVIIwui?=
 =?us-ascii?Q?0aI1LLODLAqy8YaDRLxdRcs6kfgy7+2SmpsT4d/E3WvX2PrJregGbu/GlQhF?=
 =?us-ascii?Q?Bvw+ksldZQfv2iob0QQ9oauD47Dw+0YHzJ66sIAS1wsapfYHBLLv++j+v/+c?=
 =?us-ascii?Q?39uOxREnVgOlEkSFgVpKD5ZbqZWOm8qA7+wcU9JdHcuXVy4/6SUCGRmQWHul?=
 =?us-ascii?Q?sZGVV9upIO/GC2HF01MG9sn+HrtubUVqJNvVjKU2YKQe1oKkl2BBqb6Fuc6D?=
 =?us-ascii?Q?3LV+B/Wn9Kjnvfoqu5kUuzKglMgcgfxZTaqpW7+Kh4QAoTxICpcEnFMBW7z9?=
 =?us-ascii?Q?ZBaK3XPSXl6z+dyOOsHNPsPLIny+Kui83BLgS3tvqpq5qNmPE/bj/7p6c+eH?=
 =?us-ascii?Q?xTBFhVcPsghzFlKtRswOUuD6RfpR8s5DyqL6GC7S2wr4rKe7VxJQgV2kaPel?=
 =?us-ascii?Q?Fjy0uH7NjJeW7FSy+PLXkNaleZbwlgpY9QA6xGQD9Sm0OxzadZaQyGViQ0e4?=
 =?us-ascii?Q?dySB+byaklBw71JBsbvan55bt1Lb5VhEbw4W8Jlw7eagNJ3R0Zq1HQEp8s9h?=
 =?us-ascii?Q?vjEg9p6FMst6zLs1Z8kbYAzcR+Q9kMzYiD/579a9pYeB1ZI6FHy/ybYDZoJ9?=
 =?us-ascii?Q?IHsMQmbj6TXz+xuGkPPI2PM+TRnYirBf+Sw8TQJBDFTS/00zPwp232KOn+vI?=
 =?us-ascii?Q?3Ty5bO1y0wA04oy0rn0PJeHfU4dJ7+9+s7pPuY2z7KiXm5KB0LipCkxYKb3Y?=
 =?us-ascii?Q?YyTnpKjhotCV47RZqMn5jkpfJg7xv65oPh00WfqgdZsb8sYgpRAyaMQe2SQN?=
 =?us-ascii?Q?SZeoIXoB1VhI2afv3aEJn7cW/mVMTzJ1vpt6FmUJlHXSyxqDWHWgGZ4glGQp?=
 =?us-ascii?Q?MetrYhDg+57a+sGqgfs2qRJ0gjyoCqNA29VIYtEOG1ovKf/w0ePQ47JId0Lc?=
 =?us-ascii?Q?QpekrZFBjZDPAL4YSdfjZChSlGnmQ9dDQc8LuO7QSUGwMOHMaToPHL60tkoI?=
 =?us-ascii?Q?EjjJ3htmhATAVR9Wpn0dqg1hzRrFX2gzDvHrRy0+d73tK6DoOTDw9gl6D6+N?=
 =?us-ascii?Q?7D/iW6i4oxmdqbmgl4rPyIvRqz3hrlpIcaVmA9E4LBpF394tXYHqNXW1skFU?=
 =?us-ascii?Q?ho5IcZRCQok=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lc79HfFOQwGIbTWDaJ1RgsM6x9yNPER6TvyWrkoDowGr/WbXKJJZ5K+7bJoY?=
 =?us-ascii?Q?sYlTe9gneMOktKXRF5PZv1unhr6vVQaYA2gm6V5qSMTACRZ7PK/k00iErZYO?=
 =?us-ascii?Q?LDGcXNrBdMKvkVA+QOaitlKwTcYE/kf7rsnoBTDfznZwRh2cnIyvWeR6WNH4?=
 =?us-ascii?Q?LyGZz+qbIFxjf/DhqO5uKW52WYFD5Z74ghY7e3Pxzd5I3yeJnFS6lQZw/1jA?=
 =?us-ascii?Q?uuTj/WgCkrTazch7Hzj1XugTKDMYuTkEAmDW/3a3iI84AKXKa8wK5ru0NUMV?=
 =?us-ascii?Q?IDfm382eLvJhAA+X/v1FCDkruBDo5eh7P3WLZxSY3YNKHguUV0AOmev/+L99?=
 =?us-ascii?Q?SZYxUcJEuw+z7D0mFZUuNW1iO5bdnkku/aCZdAtYIewPm7xw1cRLghYktUl5?=
 =?us-ascii?Q?X8G5OjoDaB9982qoawcbcVH3Ss5SqCY0GX35NFEysVe/RS1KxLXQIUKDkqLT?=
 =?us-ascii?Q?xKFvskztfSYGF0nq0Kdb9RdOjZwyhiQor0ICuTFyIb0s6ONMO58jmpYOFrAL?=
 =?us-ascii?Q?78VJN+5QJCnlHFLyYiQAzGZyQgdl4oxllv/avM1F1jh/FyiYvgD8DTsUCltd?=
 =?us-ascii?Q?Cp2HM1uxnJiRazEVipvvST4MZA/5LwmOOnuYjzUegf4FlA+10urFT6YwvW4r?=
 =?us-ascii?Q?+pPUXrZUmKYCTOk10sa/TxAKq9jlkYIsZB7zEQH8AbVI4qBRkbZcTRm70yvX?=
 =?us-ascii?Q?RwU8uF/GwSoWC0D+/UjxzaUvRD4TkIDGLrFld0ekz+OjAqYMD9aBlpgV3SoH?=
 =?us-ascii?Q?x5+DnAi2ReQ+8jVA+CNlEYHA94Cve3lLywX+adhR0hHcII3keShE5aWwn4N7?=
 =?us-ascii?Q?Zwo+NbUVMNsLWC/IeWHWVxfsV6mQHWEqz4S9qEBIV5rC56RyQ4kdPQE3zN7/?=
 =?us-ascii?Q?jaIAz2j4o3MtBO2yMMLO3YzCrS8QiS7uFUz5QW8wSyvVK6T1McjudhLSJqiT?=
 =?us-ascii?Q?917ev3M/rlGjvvHDXZZRHUCw9XsUCLbwi2w8USn0qeH0tkv/jOyxtUOERSUk?=
 =?us-ascii?Q?AiaKsUXehke51xkGf75/X+WbPKWvWBtcBkbJ5ddhEDFJPyORWCXSa/2N/OVY?=
 =?us-ascii?Q?bpkUheT4nI8Xpxzehd/P86usQUAYrWBpgjCmEfhd95XKhUF+rgvwI9U5QePC?=
 =?us-ascii?Q?toUMCEljMVeFM5Lsy/dgoRrng2E6E0bVnrXrRJFMNny/SQ3/SHV1C3kel9Me?=
 =?us-ascii?Q?BWX2RmNAZsGSHduCJ0JMToCx5MlTWFgLRcVbg++iUR0Ux0QhVn+1hJZp+a1g?=
 =?us-ascii?Q?TQa1qllfRza1zgpQZpFdYFDqDGoHODS+cWn9A9eXGO8MM/Gfi/NG+w+8YpHg?=
 =?us-ascii?Q?qwEg6vCPgvD8UzDHBSDZZRt+4697YlFxNNllPy8JRQA9JXPNUcrd5+LbhAy5?=
 =?us-ascii?Q?Z59BaZuAIIRnfqAtf8rpxk9f/PyTeywjY/4mGvkW9IzBsK45bSARTUpTk23c?=
 =?us-ascii?Q?zPS/HV/TT/LXXiPTQDKTB8eAiLL1mG6ZP9ytdiaK9PLug/n18ZTL26W/azAB?=
 =?us-ascii?Q?tSoJwDc6M6NSGq24//0NCnYNQwbxN0G3erKFnsg7R0dMFW/lmi/ZbZ/VMDIg?=
 =?us-ascii?Q?P4PiQaByDsDBmQMxMuInC2LDd1gG1ba8HyN9uZjus6BxQYQ8xzAdpIwy1L1S?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aecc3c4-3ca9-4680-8c0b-08dd943d2fca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:47.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP8+earw8+s0oc0ULBywe9DVlQ83e3h6/jwTTqUr4tinLi9NeN9EeqhyNbToDiUNyo1+iwaFTgD5aK4b7E+X2YxioqnMHDgdtje8GlJLeiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com

Given that the platform TSM owns IDE Stream ID allocation, report the
active streams via the TSM class device. Establish a symlink from the
class device to the PCI endpoint device consuming the stream, named by
the Stream ID.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm | 10 ++++++++++
 drivers/virt/coco/host/tsm-core.c         | 17 +++++++++++++++++
 include/linux/tsm.h                       |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
index 7503f04a9eb9..75ee2b9bc555 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -8,3 +8,13 @@ Description:
 		signals when the PCI layer is able to support establishment of
 		link encryption and other device-security features coordinated
 		through the platform tsm.
+
+What:		/sys/class/tsm/tsm0/streamN:DDDD:BB:DD:F
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host bridge has established a secure connection via
+		the platform TSM, symlink appears. The primary function of this
+		is have a system global review of TSM resource consumption
+		across host bridges. The link points to the endpoint PCI device
+		at domain:DDDD bus:BB device:DD function:F.
diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
index 51146f226a64..bd9e09b07412 100644
--- a/drivers/virt/coco/host/tsm-core.c
+++ b/drivers/virt/coco/host/tsm-core.c
@@ -2,13 +2,16 @@
 /* Copyright(c) 2024 Intel Corporation. All rights reserved. */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/tsm.h>
+#include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 
 static DECLARE_RWSEM(tsm_core_rwsem);
 static struct class *tsm_class;
@@ -99,6 +102,20 @@ void tsm_unregister(struct tsm_core_dev *core)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
+/* must be invoked between tsm_register / tsm_unregister */
+int tsm_ide_stream_register(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	return sysfs_create_link(&tsm_core->dev.kobj, &pdev->dev.kobj,
+				 ide->name);
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
+
+void tsm_ide_stream_unregister(struct pci_ide *ide)
+{
+	sysfs_remove_link(&tsm_core->dev.kobj, ide->name);
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_core_dev *core = container_of(dev, typeof(*core), dev);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 59d3848404e1..915c4c8b061b 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -116,4 +116,8 @@ struct tsm_core_dev *tsm_register(struct device *parent,
 				  const struct attribute_group **groups,
 				  const struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_core_dev *tsm_core);
+struct pci_dev;
+struct pci_ide;
+int tsm_ide_stream_register(struct pci_dev *pdev, struct pci_ide *ide);
+void tsm_ide_stream_unregister(struct pci_ide *ide);
 #endif /* __TSM_H */
-- 
2.49.0


