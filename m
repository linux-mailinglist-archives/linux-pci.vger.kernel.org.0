Return-Path: <linux-pci+bounces-32436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F5B09400
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79F4188BE50
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B066A215075;
	Thu, 17 Jul 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jk21E5ak"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404A20C480;
	Thu, 17 Jul 2025 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777258; cv=fail; b=qYY6TS0NUTosdmNlylISHXommwrafl4WBu+Dhe6/IUY1/WgjiVEhN3ycgr6EZ+EtYd+Hi8eFyLomixqVHWfsGm40sTrZ7LmU9BPvTmvQh0QvSgp+BzEwk86YFW7bSeOWZgSTWYY4q9xZBd4iSAZp3G78hATjmKEZsn0KSSzWVeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777258; c=relaxed/simple;
	bh=QFI8HJK4dFzbwAJvau4vSUdpu6JqHdZRbf1WQqa6ySg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=INp9o2Z6uOfdfZokRc91eVwWcL5e6hnCeSP1KpNus4DQueA1dRXvdX7j6enJ6rmjfHMjD4KaIm+O/nK15GwAukjWFUCur8ZFxS/dnwCxzlDnA6oA3qjRcM/yA2kct1j4qapZpLoH+iFpwTElm4/W8BwpLHu9WgNoN3w/kcEiDt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jk21E5ak; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777257; x=1784313257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QFI8HJK4dFzbwAJvau4vSUdpu6JqHdZRbf1WQqa6ySg=;
  b=jk21E5ak/B97y8/bFP5f4o0FnkezEAyJh1/mgXg40AHn+2WXvkIuEmFR
   AvGB7ZjiyyzufJjT5ABAOzEEiH6nDcz1qa5X6xAmpVwVdoF+tyT7cG0MW
   tx72/HVgQu1+IiK0w/0SkbCf+n9v/lb2hMmSwr4R9IdcgIza+r6vOdTPv
   vlzh6DZZI4ETylFpKdbGXtPNF15Q22eNvAp7d3A6R9EZVFeMRBop/kAz3
   GYkmmr2KfuNcA+V/SVCcrpiTDrRjo0d/muCG8lJuhrii2j+RBsubY2RU3
   QWqHylODFB5DyPFZZJPNOXbnllBojeO7snzOkHqWSNzD/iuhHy2dfIMdL
   Q==;
X-CSE-ConnectionGUID: PRccnPN6TxiwBsOY05Agfg==
X-CSE-MsgGUID: TNS8RBbxQbygyj2VNdFRtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54924053"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54924053"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:13 -0700
X-CSE-ConnectionGUID: zXjFbw56RMyjQ0RqFKvPIw==
X-CSE-MsgGUID: CGIXkzUMSG2M6qIXHcB7wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157254603"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:34:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6q+SmU0j3D9yiTrUgDc0pYlMWUOwDO76GJEs61m24Xwbp4EHWXEc9W+PhowCDe+0lC7Kz9PkCDmCoSPf411QNudMKgO/vuh6jzRWcuiUlalrbHMZnnz15D/H78cxqaKySsq5nYwBQtfHKedUynERIG6xHSyFPQkNVKqFD8lX/3iI5n4A4DrSw0h/Vd2GVrkg6RE3X9pbRh8MmWmbEiicVswTExQGl2tKDijt35BbShBuO785p1IBFzT3YwZEBrhHW22vkZdVw9cSbAMmC52QhaxHWSmqJgaPMuYWJE2vOmBaxOJgsi5hXD8DjDETOt7J29GbJGHIsBa218GbE2UeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1xBH+xuabjfjpyhPSgBgyOpgvAwquo333DCYBPWgJg=;
 b=n2a1ed0KlWN/994KFvN6HvFe2CjNbjyafKhnbdiOE30ic+pq8NoU7F+A44EnJ+ZM9/OPbxonJNGRqoqOLAfGc0Y0zYg19/YT0bvFAS+8C8cmTDvfX+ggn06lSECCxtKDVZ69UW3z4JLjHkYEhLpSzpFWxczhRVTt3YsCoiOR2w0C52XoMibeTMXreoqxle4fRvOVUz3d2F7S12pEQg1OB+qY5CAvnIH9XkflnFn3jFk36fwECeYNIbPVDqE9JtTtMZkeXr97CZfXhI3E/hdYmuUP4PkVejCJVbLs1rWSJj/6LVAlwgOzuXIvoMx8rIXpYnUNCZcx9Yq09FM3+iFXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:34:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 18:34:03 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Yilun Xu <yilun.xu@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, "Aneesh Kumar K.V
 (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH v4 01/10] coco/tsm: Introduce a core device for TEE Security Managers
Date: Thu, 17 Jul 2025 11:33:49 -0700
Message-ID: <20250717183358.1332417-2-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: acbcffa9-8da6-4dc6-48d7-08ddc560812c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pxyM8BXsgxUYEibs7CVJSwWcBCGDE1tddOT1yUn/i2fz191eUJQCtajF4nX5?=
 =?us-ascii?Q?O/HdsJTjayfIJNqwtW9AYxbH67hbRCj0SAvky6PSXxsI/4T+lNnZ1wnRBOd0?=
 =?us-ascii?Q?/Hr2dubuiAxYJipRHBDqDWvF0XLHq7oqxZQn7RQeeWH7046U3DNAqC3CL44j?=
 =?us-ascii?Q?mW1oXuV+ebbljKEcP/aHdzvdnJTIdIYakl3jwIRTcltsrXKYAY63/sMudSTO?=
 =?us-ascii?Q?rdW1oXJkavP+aO/SE6Kr1K8PWBn0JoZLbyuAeI3Rb6TyLEbuGd/0Dmaz7YNF?=
 =?us-ascii?Q?gcZ0PrCkv/p+gI83MOaU5OfMpAmWpnYKFtrmfPPreuYUUS1hYmYVNikmoJd7?=
 =?us-ascii?Q?zyi3XElXG7NsI1DQtLXlraaP+4Sv+s5VOd7LrTjcn9rJVX5SSeDYLc/O4jOw?=
 =?us-ascii?Q?40zbJ6bozPiD+TRPmlt8YSwOm8pLqn/9XFSKq0vk9Y0VbEZiAMfU/a2OZ5P8?=
 =?us-ascii?Q?yDKRflt06wmKQmCRocACT3DQx20ZwRk2JKTG2Ny+MRnFAQDPnQ4yb1cjjLWs?=
 =?us-ascii?Q?Q6vtzsWGmpLlVVUAnFwjmtN4mKNiXIDZUIbmq4NrRMqT2DeO7gnyZfMhSfsd?=
 =?us-ascii?Q?Ca99zsltlFoHPouGYL+2ufPOryumCaiVAGHcXdJcBteFRoKBWZuZrmXeitb2?=
 =?us-ascii?Q?232aq6H7/PRtjH2+XRzdQAlq/iIO+q1tMrgstabfi/JoJTZF7fEWA79SrX1P?=
 =?us-ascii?Q?Z5rZgf+70CBR7HFixAh+CPH3nfYE3JaGszkrBBJJE77GEzK55ulp+WhSZtOP?=
 =?us-ascii?Q?DYA5EAKjazDw0WTZMK4Ak8LrXEtYEwshMJ7pXsGxeJUNrKX1kgalhxf/hpWo?=
 =?us-ascii?Q?Rija9JXWcaEEt9A1DRSDGhHVELAPy39j59BFuxeq0PteJjijmqxY9Q5ANPuu?=
 =?us-ascii?Q?xEmDk9pCHQkIqh+HAzsnoGK11mBELE/ABYqxUiodzCKAo/2IRfT8kXDephyH?=
 =?us-ascii?Q?wtTZDEEN5Ql/+/ZC8BqBSWNiDjQox7Nv4fQSq0Er0hhCDKsqpaUHdHSrW6Y9?=
 =?us-ascii?Q?qYVWtqpCa+T/OWP5ziZ1dwF7i2VZlZBST/s0ET54Ecs0hKE58kptg08OW0vU?=
 =?us-ascii?Q?4YbDasV09nCo9fpZOYkBZsL6wtnk+Pe4tnUR776npCqOiTSh0/oH78/DOBB4?=
 =?us-ascii?Q?P+3Z1KKkYBFbYhTJa14k1FBy/wRC8ETN+CVCtggF0c7GIL/dqG/hCzIOxqsB?=
 =?us-ascii?Q?5czCi0QpbAkFB8og0HEqWaDONEamZn6k518z/VnAJsNepDaJJiI5PIdLIXmq?=
 =?us-ascii?Q?+9HDSlHPVVmFv1RvsZWYQD0ASNl3cX2pa5scIU+ttDWnUCWTLRehbYZeXxHN?=
 =?us-ascii?Q?C5+z8xw5Zf9xXmFfmr4AFBJiEZbwZaajEl7c4NI4zvmts/ASLdl5r89poYU0?=
 =?us-ascii?Q?BoagdWtfHEzJq/T+mGHeH+wiOeYKgiK3zSSzvUXEyEaf8w+DSZJaZkB3AYuw?=
 =?us-ascii?Q?Ddkc/4OjnA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TKi/baO0rgTpighF9gojFKY0uV7LASYU9zMGFpF4vtNUuZY2ClEtHlUSRJy2?=
 =?us-ascii?Q?rOHGCandQ97PSaej2CAkIiyrVe7ystVDAypBzhlIRgNbTovgJ8gzCaNAe/SF?=
 =?us-ascii?Q?erTTe2DM01OJO1MANMd8gF1o+mWWZeEfxiMCV8SgCnLEuzSPkNMQ2F0nG4cE?=
 =?us-ascii?Q?oy2lOo8dNn5IRoU5NETRAUcs+EM5c+gAJFCYD36pSdM+7M0gBYVjC73k47Fa?=
 =?us-ascii?Q?amHT+xL4H+fzrwNUzlp2bv8hJa6BtLKgMYehwfOJj+rUguo7jVm5Ly+PID2J?=
 =?us-ascii?Q?XSKKKmlWayqkC4wZJcYOVX7JaxS6uwLX4vBGrtJSJ9kcdebwkyhpDgQRm7Gq?=
 =?us-ascii?Q?7gZHOUTQehPIcvz9ic3//6N96dso9SV9kvdGvtb2hDuU7kbx5cAtKWQv5ErO?=
 =?us-ascii?Q?5b2xPLppZgkHxyQ0CNAItdv44vuH1pLhwKtofrqhcqVWOeyblVCSIc6CfK6c?=
 =?us-ascii?Q?2XegDZhiR5q4R+rGURg1IxtFaOI+x6BkAI6bRaRPK5fi1SefhbCr6nXFI+gU?=
 =?us-ascii?Q?j3AnvW4EII4oKAO4gMbUSOJF0yn188P7JjaKmPvIu3sjebtYMLJiN656MsGO?=
 =?us-ascii?Q?CAjGPs6a3rD0l9xdnfwgg5SAA5ZqzGm9xCSUmij4yVkDESD/zElkE9EPEkNR?=
 =?us-ascii?Q?xgaTdeKAqgw+SR0aySBUYr/qkHAJhWG1V24LecZRK9AnE41iWlp9i3NYVeBX?=
 =?us-ascii?Q?+eYcnuxYvYXbjPDuJzx9HzsR6SpFFCKFVBzIdiF4kGcO2+MGwIFOeIvYkPDO?=
 =?us-ascii?Q?eCnVwzpPWuOuHrjBBnJxfqZSggUgt0GQ/fd4pgfb1ZiAukNNStUIC+53up+T?=
 =?us-ascii?Q?VtxXL2z6nUPz0eYZg0dFh5o7JhgFp3pO6M/JrGhFFeStarfKaN8qqqUsz7gt?=
 =?us-ascii?Q?YRYKt/B/EHrhbrnZmzDox0ih9SZkWyU2tlkM0C7BVmyOQ5c9cByfmcPCitBC?=
 =?us-ascii?Q?kSVfE58ABQXAMrQZOXu9Z3b9xbZZMykv/HTDZkiEGDjrz5pvGn8zufAeoU9L?=
 =?us-ascii?Q?XPZSFdUUrmLF2MxeJLbIeg7e+uvA783WKgh+zMB25O5lTH3GHnV0qFIMC1uc?=
 =?us-ascii?Q?jt0FgSlt5irzibtHeMsC/OpKrW1424jJyo+yb21pcO3jskIw4WhXFhS/kfGV?=
 =?us-ascii?Q?+L/pmgxlcnjomGm2ZhL1vu663YsTgEmqVq9ujdR36AiYY6t1GS3oNfOcboA7?=
 =?us-ascii?Q?PHMmiHTjfpQQRNWjEtQ9VFhSoiVzWfAdR2ioXV6eHCzuKWJdEpjSJxxNbSMv?=
 =?us-ascii?Q?DAI/QR1SmH7gExspxOScF0Y4/RM4hP4h/QtzNi/CAxqxwgpgngYatflgv96v?=
 =?us-ascii?Q?rSl92uhtBXDOfFrdYIafon69AoUQWSfk086Eo2GqZbq4Ua1rHKLeBuIkKcQY?=
 =?us-ascii?Q?oR9d941Jfc0isjRmgc/dU6PVLnDrpwoVlCwvIHuildz6JiWWZa3srWBHR8wA?=
 =?us-ascii?Q?PWVc+WhWljmxU0GJtG1kbHFyVDznpV+IQOIfwIcDzu1snHP0R/mh4W83prs1?=
 =?us-ascii?Q?+mKaf3/ynbXVS3ukqORiHdakoTDuvpnoETb4cJf8DtR1w+W5QN/BWSr0wlj/?=
 =?us-ascii?Q?ZMHH+mKA5VbgtB0ue3aQidNUFdkRAibFeCKJbx0ddXLzkzxmEnxXIRKv6f+H?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acbcffa9-8da6-4dc6-48d7-08ddc560812c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:03.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjEmPzn7PBqn+GUH2+EpPYNUdSVX6T1PhpPzJR2oxnwez8GEukTzpDjXJC91dGqNaydii3XyvGIoZ8kTcR02iZB2yXO7760C8fK8Mt/VSfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com

A "TSM" is a platform component that provides an API for securely
provisioning resources for a confidential guest (TVM) to consume. The
name originates from the PCI specification for platform agent that
carries out operations for PCIe TDISP (TEE Device Interface Security
Protocol).

Instances of this core device are parented by a device representing the
platform security function like CONFIG_CRYPTO_DEV_CCP or
CONFIG_INTEL_TDX_HOST.

This device interface is a frontend to the aspects of a TSM and TEE I/O
that are cross-architecture common. This includes mechanisms like
enumerating available platform TEE I/O capabilities and provisioning
connections between the platform TSM and device DSMs (Device Security
Manager (TDISP)).

For now this is just the scaffolding for registering a TSM device sysfs
interface.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: John Allen <john.allen@amd.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm |   9 ++
 MAINTAINERS                               |   2 +-
 drivers/virt/coco/Kconfig                 |   3 +
 drivers/virt/coco/Makefile                |   2 +
 drivers/virt/coco/tsm-core.c              | 113 ++++++++++++++++++++++
 include/linux/tsm.h                       |   5 +
 6 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 drivers/virt/coco/tsm-core.c

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
new file mode 100644
index 000000000000..2949468deaf7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -0,0 +1,9 @@
+What:		/sys/class/tsm/tsmN
+Contact:	linux-coco@lists.linux.dev
+Description:
+		"tsmN" is a device that represents the generic attributes of a
+		platform TEE Security Manager.  It is typically a child of a
+		platform enumerated TSM device. /sys/class/tsm/tsmN/uevent
+		signals when the PCI layer is able to support establishment of
+		link encryption and other device-security features coordinated
+		through a platform tsm.
diff --git a/MAINTAINERS b/MAINTAINERS
index b6219e19a749..cfa3fb8772d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25241,7 +25241,7 @@ M:	David Lechner <dlechner@baylibre.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
 
-TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
+TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 819a97e8ba99..bb0c6d6ddcc8 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -14,3 +14,6 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
 source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
+
+config TSM
+	bool
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index f918bbb61737..c0c3733be165 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -2,9 +2,11 @@
 #
 # Confidential computing related collateral
 #
+
 obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
 obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
+obj-$(CONFIG_TSM) 		+= tsm-core.o
 obj-$(CONFIG_TSM_GUEST)		+= guest/
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
new file mode 100644
index 000000000000..1f53b9049e2d
--- /dev/null
+++ b/drivers/virt/coco/tsm-core.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/tsm.h>
+#include <linux/idr.h>
+#include <linux/rwsem.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/cleanup.h>
+
+static struct class *tsm_class;
+static DECLARE_RWSEM(tsm_rwsem);
+static DEFINE_IDR(tsm_idr);
+
+struct tsm_dev {
+	struct device dev;
+	int id;
+};
+
+static struct tsm_dev *alloc_tsm_dev(struct device *parent,
+				     const struct attribute_group **groups)
+{
+	struct tsm_dev *tsm_dev __free(kfree) =
+		kzalloc(sizeof(*tsm_dev), GFP_KERNEL);
+	struct device *dev;
+	int id;
+
+	if (!tsm_dev)
+		return ERR_PTR(-ENOMEM);
+
+	guard(rwsem_write)(&tsm_rwsem);
+	id = idr_alloc(&tsm_idr, tsm_dev, 0, INT_MAX, GFP_KERNEL);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	tsm_dev->id = id;
+	dev = &tsm_dev->dev;
+	dev->parent = parent;
+	dev->groups = groups;
+	dev->class = tsm_class;
+	device_initialize(dev);
+	return no_free_ptr(tsm_dev);
+}
+
+static void put_tsm_dev(struct tsm_dev *tsm_dev)
+{
+	if (!IS_ERR_OR_NULL(tsm_dev))
+		put_device(&tsm_dev->dev);
+}
+
+DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
+	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
+
+struct tsm_dev *tsm_register(struct device *parent,
+			     const struct attribute_group **groups)
+{
+	struct tsm_dev *tsm_dev __free(put_tsm_dev) =
+		alloc_tsm_dev(parent, groups);
+	struct device *dev;
+	int rc;
+
+	if (IS_ERR(tsm_dev))
+		return tsm_dev;
+
+	dev = &tsm_dev->dev;
+	rc = dev_set_name(dev, "tsm%d", tsm_dev->id);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = device_add(dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return no_free_ptr(tsm_dev);
+}
+EXPORT_SYMBOL_GPL(tsm_register);
+
+void tsm_unregister(struct tsm_dev *tsm_dev)
+{
+	device_unregister(&tsm_dev->dev);
+}
+EXPORT_SYMBOL_GPL(tsm_unregister);
+
+static void tsm_release(struct device *dev)
+{
+	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
+
+	guard(rwsem_write)(&tsm_rwsem);
+	idr_remove(&tsm_idr, tsm_dev->id);
+	kfree(tsm_dev);
+}
+
+static int __init tsm_init(void)
+{
+	tsm_class = class_create("tsm");
+	if (IS_ERR(tsm_class))
+		return PTR_ERR(tsm_class);
+
+	tsm_class->dev_release = tsm_release;
+	return 0;
+}
+module_init(tsm_init)
+
+static void __exit tsm_exit(void)
+{
+	class_destroy(tsm_class);
+}
+module_exit(tsm_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TEE Security Manager Class Device");
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 431054810dca..a90b40b1b13c 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <linux/device.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_32K
@@ -109,4 +110,8 @@ struct tsm_report_ops {
 
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
+struct tsm_dev;
+struct tsm_dev *tsm_register(struct device *parent,
+			     const struct attribute_group **groups);
+void tsm_unregister(struct tsm_dev *tsm_dev);
 #endif /* __TSM_H */
-- 
2.50.1


