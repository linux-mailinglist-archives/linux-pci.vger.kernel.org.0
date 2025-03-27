Return-Path: <linux-pci+bounces-24867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C576A7378A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3167A4296
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90621A42C;
	Thu, 27 Mar 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUP1kQzc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887562192E4;
	Thu, 27 Mar 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094686; cv=fail; b=X6H5gjgrfcCAFTNpXEpyIyfVjSuyeq+FDR6Ye8NvfMPySqraUqEFyyVCUzJ+gAR5fbZiJgPKpBeXgq+4GH8xdSSC8DdftmrDNmHQFcZ5q4+M4JPzYS98mAxP+/APdS1OJXEeqtq5qDqP5zfPU5HDqjB0Tw6ob7D51b/oDISMMd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094686; c=relaxed/simple;
	bh=Z6bqfZ4vyudtzWa+JEz/3wzl60cZJz2TKjaFYR4sOns=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pzi/4nT+jZYak35V/2n+M5n4G3Y9fa7uU3DM9xyxG7IoA6Fr3kc791Cut/RymxeKBCenXWj4lAyr/ozHVqIn4Iy3/rHo5Iiihl7rMBIRF0bhqFzFPOL853jwqEIpASsSoBeJzGbORLbKwhrvOGOOtbMTARsfgG/3xFqv74t8rCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUP1kQzc; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743094684; x=1774630684;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Z6bqfZ4vyudtzWa+JEz/3wzl60cZJz2TKjaFYR4sOns=;
  b=bUP1kQzcTVF/6M1D8zKeXEbPxdb1CSGT1iwHKyrIBWTnamV+fnd+R6zD
   x7NjK5kJzudGfOqgzm1ltxIVFz5ELaczpkMPp6+rQPUiednPopP4V+hhf
   BA6/d014x3hK6y3EeAD0ILtOgFpFP+P6I7tJoarOZm0KtlX1qLMseMrsb
   7U5jhwuq8SYWxgpmZsOE5Yl4V3sePN7IEE838izfyl2JdtiP5ZJeAv7GW
   qDGi/dj0/x05f87NnXfLIhK/CK2TM9/zglMoTRLeihv4rmYW0AuG5+b+0
   BZghbSK512ovUpKEjbZzF2tcejEHIvUMETrGES6VJGX8BHz4mylkMglEz
   g==;
X-CSE-ConnectionGUID: w1JlRozPQgW+HLME4kxmFg==
X-CSE-MsgGUID: PH+G3egOS2+2ihPqI0or1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44602070"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="44602070"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 09:58:04 -0700
X-CSE-ConnectionGUID: mZ0wuWlBS7OhP2xfJm6yZA==
X-CSE-MsgGUID: UaTAzMVERqqrb6aLfTeawQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="130267277"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 09:58:03 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Mar 2025 09:58:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Mar 2025 09:58:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 09:58:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en+nejPxob5Fn2ZmbYOr97jYUIkejbzPYz0Y/MbhYsFTWk2axACGVWaoeWt/3HGTLkIDzM1o9KOZLBzuMoBNrTidBQ9LjJNXF7MOn+MeDXgjOdZ6BOVuycyEXfimIdtigEJk7Ajnf18+zGTEnzij5K10XxkgQk2OzQ+TfKm2+h3rVnYinei0HHAJ2AKL19T5VbnWsUUsPv6hf80ja29IAnwY5GkW+S2kiy6YfVCn5gm454kTf90yNsMmBAOGc6MdtFBzXJ+ZvQif7l+/tnhYPpHAlbxUT92UJzjB/iVJ/AFNwGJ14Us/Ss/mLaWy5DtMZVGjT938VqgYFfWSjdba5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twui5rLy32vAyAce9lPiMXN7cdMP3SuF8D0IRTdR9Ak=;
 b=L2WPzLmykxlxF7OMzUWeWWaoMxEcbEtqeHLdh6/HktoH0rDByRUpceEh/YgNcJrxg4soD9oSpMqKaHMsF4dMH5iKvfOGtrKzAgteS4DxEZDdVt7tmooeDbnQeR0pQsMVn65ZoiqgBxvuUjksgXfqCxh8Zg11J9YwW6jDvUfG1wbCfMHMmqz9cDdJ3pDwqSMWHCQX2IjsGGp/QqNrV9wwRDH2H+n9zYabjaGMhMS1U86E0XcbxYCwcYRg/J/bFd/KbRkB/nKw1ObTIWpAN/XCpC1sOVeMfJ7budZR1lIi7uU8h8tAxhaNOIJZIAk0Ie+OueCDQGC1HnrXUVQuL8gzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:57:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 16:57:59 +0000
Date: Thu, 27 Mar 2025 11:58:14 -0500
From: Ira Weiny <ira.weiny@intel.com>
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
Subject: Re: [PATCH v8 02/16] PCI/AER: Modify AER driver logging to report
 CXL or PCIe bus error type
Message-ID: <67e583a6af077_160b72948b@iweiny-mobl.notmuch>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-3-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:303:8d::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 00674ad5-1398-480a-e732-08dd6d508721
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QXwfhETHHttXyX0Za1FkSroiLscUt6P90nJW9X0PzRQv2pgRMcJunS1e3Vu1?=
 =?us-ascii?Q?9TR3VmbZ/kJjkqf/T9NieKQnw9OzdQvHr5uTbdDoEfMnm3pis/adodrLRrdA?=
 =?us-ascii?Q?QhHDWVfzZ7zrXy+QbdJE/gZnN9QWMETnfSfho31W7JRPp/eElT0iuODPxhBv?=
 =?us-ascii?Q?8116iHDvNvUXa+gw8nxVLAz1ZqEt+XUs2BsnAotfNg7bjRTQVo9fGgVZr1tB?=
 =?us-ascii?Q?2mMWTUuhzfeIuvMglWIsxgvt0Xw26dlNbgVnGkSeuRdS/F2RtBmrkgX8RJE+?=
 =?us-ascii?Q?rDEtEQxGWZ1aSiwAWNKTH6C9+tZJKh+paEUYc6wQQtjjnPYDVzpKR56dfMws?=
 =?us-ascii?Q?2TP8CfokGdSnSyv+t5JLz3CDcJTl41yJvOtdDKZCqkBJv8jMWycqP0YnYsZ7?=
 =?us-ascii?Q?xW6PPfsmDzY9WvAbXuTE7oHKJyQI5MvLRpKfXvZlkNqJ40x5isclO5Jj+BWm?=
 =?us-ascii?Q?HPhy/it94u4Erag6kOEZLnC5FvDAmTcE2WKBVRNuwXtpRsOIBjeYhrNOUE+X?=
 =?us-ascii?Q?G1shyB8T8mZC4lGcMddXkvMeF2uQz44dvsWVHfJJD05HScH/YJYaq3I7su9a?=
 =?us-ascii?Q?0YM5aXlzk+soM+Lcxt0uYOcLAINCrQ0yjMmYBJXy6ApvFeA8tRXfxo+zb+LP?=
 =?us-ascii?Q?uIfYkV1B9/F5jPb274CC48oH+cpHPaZGRSj1c3EgoDPB9tLi7vorsMoYfj/S?=
 =?us-ascii?Q?tT3W8q5403ZvpAuaV34o9ZU9Vvv5GvzIPxa1VBP+7jEJw9WZ4UhcTptA9Aha?=
 =?us-ascii?Q?213rGpWWqO0U1ys+CEwT01MgM/v0aBTxDVfx7Azo7wSMRI/dAp4+j8q3D3gk?=
 =?us-ascii?Q?AL3I6hbmsHDGcNbz6NeIxTeYxdI4xgecC9YhEOki4yu/wVQgouGq3ZEOm/We?=
 =?us-ascii?Q?eRaaGyY3xk7Q3mLDdVdksDDddXpeC8yNAjJWV/G6rdiEWt583oQghGtOLSfU?=
 =?us-ascii?Q?xXUbPQyMK5uG00UE2GLGvpbuhHUp5r5q4wUeucG8wtJJcLKkJAv1VRWKj+l0?=
 =?us-ascii?Q?pG3eWW8uVZUwkV8uW8dF570UqIbeIPydhMFhItNg2tO7mqkTHUYVUllcgEeU?=
 =?us-ascii?Q?JGQHKJWkEoanFV3NaUXaI+mJUoEVVUHYA+S/j3sKIf8w07umat9Cx4DVtZX/?=
 =?us-ascii?Q?ho2HWu+Q4VkQB2iQplocZpm1oxFVbesZZc67Ov7ZRgm7xXFogKpZKW5HaXOk?=
 =?us-ascii?Q?ln0L5x9QxK7UK8+mBLaeG07xUeVCIhrQg0UmgyQkYkyi7K5cAHuFERcOEJTI?=
 =?us-ascii?Q?2Lhs8gETYoz6qqQa1MbVYlu/XsIEU1j0IbBt1R/gUoZZ8MTWbnuDfI9WeBbj?=
 =?us-ascii?Q?uEpMJnTPTpvQ+xXzENwQfq8B4woQhaZge+majyOwySoblod/6QPwV7szRDiy?=
 =?us-ascii?Q?ftdL0EvBODwWIzW2tyTWCNeRE0rZAsnzxXzWHuG8Qvz5UCvDzJgtWpjjCoPZ?=
 =?us-ascii?Q?FNpS7VHUdJvqgJS4uU3PdvVx+NZRKWsD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nz/nazAupSUcLYxqJZaZCYA/KEf0H0xsDQIrZdjZWq+q5uudFxBDsNSofDYm?=
 =?us-ascii?Q?HIF5YXkiAl73uwjx1IK18X2TNQbym0uY1Qf4pguSKrUkXRFr+xX6TQLvFByr?=
 =?us-ascii?Q?d+58HZ2GOgqNSt1+EjNi9eau4wnmmaQEVr2xtfTlhuFtouv3i8KVi5VCnvRi?=
 =?us-ascii?Q?l3V7Qajsc1Rkj9dVYdfhob+h8vD24JD5/7d0PwiyabP+f2+wj4F6e1+hUMOT?=
 =?us-ascii?Q?AjmCNWKjyWC433L1/P/+g46e7sNp0+2NJ+46al0ZiOqCqe/2cZrFp6hZU5S8?=
 =?us-ascii?Q?+5GVtvzRb4goB1S+MOqSOSYlyAF59BW78RMq6jn5GCD6b06oNIA1b+Fe51kt?=
 =?us-ascii?Q?6eBLBPv5r6NUpSYomPwklfykU/8d+MrR9uv5+CSqrJc+UbYn/BL0ZN7YGH3Z?=
 =?us-ascii?Q?81FXhNuPFMrkR2asQW6Fkgw8iHKbHAio/s/hkknCmDLUs18F+Jb2RZGk2o5D?=
 =?us-ascii?Q?Q2Qjx+5mTe06zEV3CQLdYu6usMIrVYsAu3GUC+3Gcw0dLBx5khmSAVdEX7rT?=
 =?us-ascii?Q?jHGHvSGaJgCQ2OPoD8PVVV2PhqjbA+2EAAwI1Kt1vuzZzQgzLMRlT4LUGnWH?=
 =?us-ascii?Q?db8M+sDVr4oAft6elu6UyzbYxIa1dewP+StdYBztp/aB/M0pOSlje78HAGgh?=
 =?us-ascii?Q?TwoEkHXmboNq0MnkhsoMWZhsO6hbfTB5AI/JZz6UVyuQa9+s/uBEVEQv1avS?=
 =?us-ascii?Q?AzhGb12CKfHZecnsbRSckv5JfN3kHF7tCkuqvVdy52zduP6aFfLl31oez7NJ?=
 =?us-ascii?Q?Vt7HxpI70z1kX5kLAYi5+6zd7jcwkToqmh0nR7abzT4izalOSD2lfVfvaVZ3?=
 =?us-ascii?Q?eO/w9QZlEJs8jVTwVNObP/XjGpmwMV0jMBhOFuxe7DY12f8ErOSz8cIqHZ/s?=
 =?us-ascii?Q?NPLezSrCVE/bsuXnyNtYOuHI7dkpuC2nBRqX1RdMn8UAazb3Rpulrcz1De66?=
 =?us-ascii?Q?A0HqYKabbyvuGqxfIgUuW/pNEpy1eVGcrBVtW6Pm4NqgsxasioYmn96fW8ts?=
 =?us-ascii?Q?LlBiHN1Q2rutT+UvwfpOq5bAYTusXOvfaXeCRlNUOP1co5g8/wMWkHePdJbn?=
 =?us-ascii?Q?5wL8bZax72RppK0gPlAn+QQpmNiG4tUx/x17mg+V/QoAvCWDHZ6OcE10nn2W?=
 =?us-ascii?Q?Rnm9LJ0Gs3MpqwybuIRl6G30zO43qn7seHDG99dmRx2nIjjhd4mrFT9kLfbW?=
 =?us-ascii?Q?eZXL9DlH+4ZzqJZkPtG14yjwHdD1pG2WAiwFvGqJjUuizsGn8SBj1oFnk/sa?=
 =?us-ascii?Q?ScTpJvDBAjx6GwIZUZqBuM/LSvJP8wCmbsrRh08rU8hRIKUMJ8bqX59fDsM/?=
 =?us-ascii?Q?cANPLecjPzWpEEYAkFGGKXxQEpPXlpsFRwfyYZlx7Kht/fel29ZzDFbyAje/?=
 =?us-ascii?Q?oP9e3SYPMZpUXAIDoSYSanB7oG2a3VZsr5I8sEFlUDtBupHBLBGCtL/0SMIJ?=
 =?us-ascii?Q?t0LM5kVr9HzcWp6yGP7Fmi6zeP9BkEcFObnYtb4iM/4SfsoFqzNUrlosEr2y?=
 =?us-ascii?Q?CWsi40vQlgX3eNVHkjq/efMlWGhJkwMD6CpCLo6GOzkGb/TRX9LDj/jPi93O?=
 =?us-ascii?Q?QAaumHIr2Br8FZ5ky0JpKK4IdIrr2zc69EdfqDcr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00674ad5-1398-480a-e732-08dd6d508721
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:57:59.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxEpTMMhiO//MFnwkQ9aVasbKcTja2dIJzpGdjYVPNV5NGHZxEkRpvlVT/RaPdlO9p/83P3xNPeN4XBfbs6/5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
> Type' for CXL device errors.
> 
> This requires the AER can identify and distinguish between PCIe errors and
> CXL errors.
> 
> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
> aer_get_device_error_info() and pci_print_aer().
> 
> Update the aer_event trace routine to accept a bus type string parameter.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

I'm unsure how Karolina's new populate_aer_err_info() will get the new
is_cxl flag.[1]

Generally though this looks ok.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[1] https://lore.kernel.org/all/81c040d54209627de2d8b150822636b415834c7f.1742900213.git.karolina.stolarek@oracle.com/

[snip]

