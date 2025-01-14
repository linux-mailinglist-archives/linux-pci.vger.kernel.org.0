Return-Path: <linux-pci+bounces-19795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4EA1159C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32D17A1041
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FFA19B5B8;
	Tue, 14 Jan 2025 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZA+54Tw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E914883C;
	Tue, 14 Jan 2025 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898370; cv=fail; b=PwadJID43x3b2Fcoc9ffuNuRTrUNE7VQh95MFtSlODLWqNnrhJCW6fVV2LP7uTWJ8b1sSnTioTiN01EmQ+Ob4aOSJjZ3TwaLIqRSatqCWV5803fYGWK7SvHEI41wN5saRROAE/52syV9gVm8BG6zmZRIh/ee+LtKbPg1FnONnGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898370; c=relaxed/simple;
	bh=ZR2doMWYWL+TGLOLC14LD/dQJwOnDgDWOOHTHY7sAqE=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MpJJWM7F0kDQSpf5ksk09p3HYlVR/QFQWSmruK0GJK3p0sOjgTkPZ0nbb3K8SFQav3o1aPNOPFrVLXibyS4p/LKn4Ph3eW8tKqL8QKXAEYR6D1MFSOT/85AInttMRfFPyBoKihdYDyEUt0oPcDWdgumgHjWB4sYOZMVvgP2B2MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZA+54Tw; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736898369; x=1768434369;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=ZR2doMWYWL+TGLOLC14LD/dQJwOnDgDWOOHTHY7sAqE=;
  b=WZA+54Tw/TLEn62sxxB/oyUwV3koVgFKOPgL+abpEOWD3RCBXN4PCKAJ
   tRDhgbjZOn+xSXyYzZCZcE0D4ZN7r4Q3ftPXFB57clglCm/51J22pXnf5
   9oNbiFt7gS4nJQK5n6w23nRokn9XhUAbpF5nkIz41TTvXAqfWdOMt0Irg
   xNvRQNpUplr8NjeA2pJaXuwh0H3AGWXIYsiQYGvV1iILeCkpsIfftMcEK
   Oe7BDFZVQybgh3uE7MiyTCQ/UVFvqzLLYm/CYe8xiWlqI92yCY/xhiwdN
   HblPDs4t9JBKf9cS8s7UZk+x/Q+QNgd7fdu5Yb3KoJWjOvvLOXG+a3Abp
   Q==;
X-CSE-ConnectionGUID: 2kAX2U8qRgOqskSS4fwEMQ==
X-CSE-MsgGUID: mqFnOt/SQN6Teh7vFM0nSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="48602065"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="48602065"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:46:08 -0800
X-CSE-ConnectionGUID: Sv15Yn75QhGku9dIVoae3Q==
X-CSE-MsgGUID: Juq2i0jYRmugMLjJK4FDEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105827030"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 15:46:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 15:46:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 15:46:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 15:46:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbMMtTn3HgVGfYrRzcnLAS1A4liCplrnprunq5ewD8P/WXv7/xBF4xF6dPpJBZ+4GVuOtD9vH1zd7SMs3fTOT948pMUjYY2Igzi4bK8uYF0mgCIBU4D0/bchdkhQeLs5RsqzCu2baV5Ezi8a3zEsN2UGW4I2C27y7omM6evhMatFyz4Rjay/QkmCY2KLiz95NTTCKffH34xSS5Vzd+JiNHfFpWoOlvlIY6BSDSjDbDCtifbbtSOXpCP5Uy+AEUGVSTdFpcWXasL+ltZPjav2vidoVgePhy06KvNTe7Zi4Ldzka4CGuPSTEj0P2vdMoQvpMRWcg4ZPLw2SjhOYNP36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TKs6fGY1XNrkuLBA5BPFichFL+DPDvEWRlErGvv9cc=;
 b=g7g7zwcdb3ceHa2rhDSY7gbwAoXLxKfmQxpTakRr5tbRdqijPypy7IV12kNsl+Do73PqFmQw0PWxDM+HtxSI02YYVK0/J4xC0u34QxhpVfR9B7kUqb3OAnpFQMQoE5niULXc6K+u3erI53nsjOE03xUWO6CvBTFAFJjTrFdLn3SlnTTTc69HzqMa2WfC5bKfqmZhc+TOaSI7GF0BTmWKWh1kGVBGfj5piB/ATqSnSN8SyimRuCd19gVYxz8w+4RJZReG6OJIvRXmBLOMMwaFw9PUzjLMDiVRBqwu+Izg72+WApLINZywGiDid8jZqQ6wK0egDqFYKxZgI74nCtvaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4561.namprd11.prod.outlook.com (2603:10b6:5:2ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 23:46:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 23:45:58 +0000
Date: Tue, 14 Jan 2025 17:45:52 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 16/16] PCI/AER: Enable internal errors for CXL
 Upstream and Downstream Switch Ports
Message-ID: <6786f7301088a_1963352947c@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-17-terry.bowman@amd.com>
 <6786f2a7b2b7f_186d9b294f7@iweiny-mobl.notmuch>
 <e3df211d-b699-401f-ac00-1715f7a2d15f@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e3df211d-b699-401f-ac00-1715f7a2d15f@amd.com>
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: e4bd8814-941b-4fde-6af2-08dd34f597e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rHySfncxWQPqyEX45Zha2eHbRpQKobn2fK6+u3xzVVXYx6R0Mcs7jskf2qd+?=
 =?us-ascii?Q?v4o0RciHs8QQ3diPLyzQCGEtBuyWD2nJHHdP3xvgNY44mCbqi4n3cZmx/Ibu?=
 =?us-ascii?Q?v89Hvd5pXH6GaxaqvIY65e5s4whiqMO+Ar07WW9A0Sy/C+2UHSUF6rq3Va66?=
 =?us-ascii?Q?oFEHPLvi81+UcZfmFqoP76iFhsKwUyrGCAahHbtYdv68nIS08xGf+zG+Picx?=
 =?us-ascii?Q?9ytf5UgKs9i5cqpOdB6lCMMnfTsFXLqMgC1xdPcWmymlrNNRNyBisNmlz6na?=
 =?us-ascii?Q?J/8ajwQhQu0UBXD2qYeGTZJyCSroxKqrSfGwav+06q2fk+HJW9byCneX5N3x?=
 =?us-ascii?Q?2IHt9mIl0h6+J+PkDFBllzMD8I7wCju+hkjoTGOO67rRgNO4erbTOFleTCaH?=
 =?us-ascii?Q?ssZjpBaARxk6w7iOxMQacG+rpg56W1k1PDYmE6ERxGM3yqfh1gLphCrxob64?=
 =?us-ascii?Q?Nxr2pygisBhuBHZpEdsJXIlwT3bjAQmeDKuuvuVUZAqb9vJKqWSU2RknxwdW?=
 =?us-ascii?Q?aMLjpKgeTM8ydwAQCDp1/1ntuI/DuTLnBXnAHpsjsEj1uBrpMpOmJJnk4PXl?=
 =?us-ascii?Q?psD0f5dIaAqkBPbmME4FcET0Vod4+0Yc28PJ6K/ehV4p//qgBKVCOsc3qD8i?=
 =?us-ascii?Q?P942uBTokyC7vg2ZN0zCtII15qnpUse0i/OIyVYCPl03HsJQeSm3SuwQmeFz?=
 =?us-ascii?Q?uBbZo14taLfy8EC2qZQBbw4kaQmdEtDgnVDVQvWFjruMOdE5YekQGn32dM7F?=
 =?us-ascii?Q?MMdtR9Qm7FWebGMvX7V7q8yPlERbxpD56hREumamUVPU3G1ik8fTR5X1Zdlk?=
 =?us-ascii?Q?EmLV80wC7dAMfF0JDDiP8vM4w8UgxpuL8A77IUn0Vh34hwFA/bRishq2ptu5?=
 =?us-ascii?Q?Yidmh/XgxcjC7MfrjfcUcuitGmgiEcm3u+ybc32wMHlOh3+4oJet7hs7JyPC?=
 =?us-ascii?Q?45p81c3Iq8IPL+kKBwM00JgAWjisOtm7I6BtF85GodM54RmK2NbXmawEfTDh?=
 =?us-ascii?Q?19pyMQmLcIEj5oPbofDPNgvrfF6+zAghP3lfO3CAD12l7EO2bWimCwgtYTDA?=
 =?us-ascii?Q?Jz/OHBHm5+oPJGOqtyi5SmA6TJwrri8Yqnur7BdV+j73+7S/hpAzO1iDbwRZ?=
 =?us-ascii?Q?gFd85y76d/Bz3POiag8nC/rf8ItS4h5yzdk1lML8c/PSJYUvzqC6/giQN15+?=
 =?us-ascii?Q?4gFIkVSZ1kBo/LMtkXKKItqD4UHh+rzw9frMxiRl9fDRza+DSXU2m5Htm7ZN?=
 =?us-ascii?Q?AhxUhEImHh8OE3Cf2EQoVQf5ONPJDX9RjQQmWv3c55/n3zrlZ8abjesWmStu?=
 =?us-ascii?Q?Yr2zg4H0qpQCXjgMDrloLUGwwP7Jv9y/PLzXH9VDM3IGLGh459obS2vEyrX+?=
 =?us-ascii?Q?wgkswG/DQoRtm/GWKqhi2FZH/r8nlMCU5IL/8sk2v1OK9ioqnAwqq+t2Arpr?=
 =?us-ascii?Q?Rpf8+r6c7+0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ji5DKoU8sbAOEXVSHKZBHnjRCyHMk2PBcQUicY6UOkwSv1lyJgcLHXqjZVBP?=
 =?us-ascii?Q?T9a7ve2C46vjLMPSKkAPPVAU7DaDqF5lKaLWM3oQD0Hlnrbv6rcWbZ09TY6i?=
 =?us-ascii?Q?KA1q3ONGWZrJ5KjCTlzqeAq5bHhFbrj9TFmZzvTW8tQbOiNbIGJZuyGXedBq?=
 =?us-ascii?Q?Ilhu0QlC3473BvhiGCMvdhmQhU04ur1yEP5arcdW3bY96opZuTw1hQH9jb1C?=
 =?us-ascii?Q?ji3/uzNLglv1Z20yDCCwP+LU7tHxgUywagBuP4oUPnFAm5evSytTtn86e8bf?=
 =?us-ascii?Q?huxE3iOz5cNKWNl0oIVp8gqETlYCOzcKmN8/1hs7t1rd4tK9xGOM8gqTjrjN?=
 =?us-ascii?Q?2renZ1t7ftHswvenoLZCIxgnjixTSqxUIP8/CSiP+vfGjxT+yqqFUDikMogt?=
 =?us-ascii?Q?P3c/y13sSGW0ZYn5I/NM4Jv6wpZvlJzZVbQck5SUtfzjGtwLcoMIWLrqBtV9?=
 =?us-ascii?Q?xWAQJo+ddbXNqkvDVBb30TF8uMBPR3Sht29SNt7iSMmWszmDb90s+aW6vO80?=
 =?us-ascii?Q?LnU16rCzyRjP6wbntgsT5x74En29PVAIbVbo7qpOlroytJvx3ZYNYKYtNtKC?=
 =?us-ascii?Q?2kid36BzR3oD8VhzZBbgvNNzc+HVgWpMFG+R/SugqZVHUMZlVQd3LqBCBi12?=
 =?us-ascii?Q?0o/HegRp73Ce/GnrZjjNr1i9ytEXVRr6gwSewbF91/yHQhyzQpvKRcEX4iN+?=
 =?us-ascii?Q?FOfpAG40twrBmzkkmchk7OnxuMVV6BO7YqwmRRABfH6FA5TBIi9oF2MrQtNh?=
 =?us-ascii?Q?rh2D+YiVj6KV0A7lOnXoEB9KdHjvfklIFjQbJez01nrsbxI0sEnby+8JcK86?=
 =?us-ascii?Q?Qqdj0sN9mcQTgQvcIKR9VyR5wWAwaxyOu1nSfcrHkNwCRIYSuCZ3fXAOjTJR?=
 =?us-ascii?Q?KQ6R6xD18ZpWy3PnsJqTXDB+Ew21IC26dWax/NpEq2afE9RtRZfLJfBK7IWX?=
 =?us-ascii?Q?V4JkE3Le81cjmnPiDzGMlhioiFxQowPQzgROvSBbM1Hes/4eWk7tBgCjByjd?=
 =?us-ascii?Q?825MufFbEKS9KJTjYZSh0hlXdZ1xfo66qMZqkBCjJBX5lw3ayr35801cdCuU?=
 =?us-ascii?Q?aNx0yNP29vuKeUhLTTB4PenxZOD2BX4SefbyPVt41SlEW0y7UEz+2Adv1wvZ?=
 =?us-ascii?Q?plN5R9e07pCiKSq7yIvmOty8hMhek2202mialB15kgej47ZtD0Es3dhSQ3+k?=
 =?us-ascii?Q?Jy4d4spDpKDrSZNFqEj0GCPoRNgPbSo/OEMMBxE5XnmAbFGLP/jdyS9mezla?=
 =?us-ascii?Q?oZ+G+PCHHqnAhKw3vtexZMmB0qx4azoPMSoUVhkuHkn1RhLCNWsUWSdCiYZ2?=
 =?us-ascii?Q?ISVqzTLEBCaY205F6u7mmGBZ8Rczcwv+M6tWHSqS0Ne5CvRq4Ke1D3UmUjOo?=
 =?us-ascii?Q?zn+PwfA2NMn+I/7Yk6mHOxL7JgA5NE7cre+v2TJjE4sQunagA/m5Rsy6dzNL?=
 =?us-ascii?Q?LJNBCmRVbS3bmrFD+XlomRY/H4GtY/B8vHfyzS/nxJV6S7bjdFF7w60oNrG/?=
 =?us-ascii?Q?ZL8FheQxHH8NtvSU5n0gi9ee3TJBMdOuTRPhdg/k6YJKpMNAvoPln9SXzYQF?=
 =?us-ascii?Q?AdbH0qvzB7NSA+mVTiw24jDLDV5YDjeNZaU4V/8j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bd8814-941b-4fde-6af2-08dd34f597e9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:45:57.9738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5TOON7xmHVUiSgYMJMbhWzv6Aj174aza5jKHy8hyHwX83ZeSwHJlqUYgWxVPNjduSFljwIl2ibESf4cGbCvWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> 
> On 1/14/2025 5:26 PM, Ira Weiny wrote:
> > Terry Bowman wrote:
> >> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
> >> Correctable Internal errors (CIE) for CXL Root Ports. The UIE and CIE are
> >> used in reporting CXL Protocol Errors. The same UIE/CIE enablement is
> >> needed for CXL Upstream Switch Ports and CXL Downstream Switch Ports
> >> inorder to notify the associated Root Port and OS.[1]
> >>
> >> Export the AER service driver's pci_aer_unmask_internal_errors() function
> >> to CXL namespace.
> >>
> >> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
> >> because it is now an exported function.
> > This seems wrong to me.  As of this patch CXL_PCI requires PCIEAER_CXL for
> > the AER code to handle the errors which were just enabled.
> >
> > To keep PCIEAER_CXL optional pci_aer_unmask_internal_errors() should be
> > stubbed out in aer.h if !CONFIG_PCIEAER_CXL.
> >
> > Ira
> 
> Bjorn (I believe in v1 or v2) directed me to remove
> pci_aer_unmask_internal_errors() dependency on PCIEAER_CXL because it is
> now exported. He wants the behavior for other users (and subsystems) to
> be consistent with/without the PCIEAER_CXL setting.
> 

I see...  If PCIEAER_CXL is not enabled why even set the cxl error
handlers and enable these?

I guess this is just adding some code which eventually calls
handles_cxl_errors() which returns false in the !PCIEAER_CXL case?

Ira

> Regards,
> Terry
> 
> >> Call pci_aer_unmask_internal_errors() during RAS initialization in:
> >> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
> >>
> >> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> ---
> >>  drivers/cxl/core/pci.c | 2 ++
> >>  drivers/pci/pcie/aer.c | 5 +++--
> >>  include/linux/aer.h    | 1 +
> >>  3 files changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index 9c162120f0fe..c62329cd9a87 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -895,6 +895,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
> >>  
> >>  	cxl_assign_port_error_handlers(pdev);
> >>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
> >> +	pci_aer_unmask_internal_errors(pdev);
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
> >>  
> >> @@ -935,6 +936,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
> >>  	}
> >>  	cxl_assign_port_error_handlers(pdev);
> >>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
> >> +	pci_aer_unmask_internal_errors(pdev);
> >>  	put_device(&port->dev);
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index 68e957459008..e6aaa3bd84f0 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -950,7 +950,6 @@ static bool is_internal_error(struct aer_err_info *info)
> >>  	return info->status & PCI_ERR_UNC_INTN;
> >>  }
> >>  
> >> -#ifdef CONFIG_PCIEAER_CXL
> >>  /**
> >>   * pci_aer_unmask_internal_errors - unmask internal errors
> >>   * @dev: pointer to the pcie_dev data structure
> >> @@ -961,7 +960,7 @@ static bool is_internal_error(struct aer_err_info *info)
> >>   * Note: AER must be enabled and supported by the device which must be
> >>   * checked in advance, e.g. with pcie_aer_is_native().
> >>   */
> >> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> >> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> >>  {
> >>  	int aer = dev->aer_cap;
> >>  	u32 mask;
> >> @@ -974,7 +973,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> >>  	mask &= ~PCI_ERR_COR_INTERNAL;
> >>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> >>  }
> >> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
> >>  
> >> +#ifdef CONFIG_PCIEAER_CXL
> >>  static bool is_cxl_mem_dev(struct pci_dev *dev)
> >>  {
> >>  	/*
> >> diff --git a/include/linux/aer.h b/include/linux/aer.h
> >> index 4b97f38f3fcf..093293f9f12b 100644
> >> --- a/include/linux/aer.h
> >> +++ b/include/linux/aer.h
> >> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
> >>  int cper_severity_to_aer(int cper_severity);
> >>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
> >>  		       int severity, struct aer_capability_regs *aer_regs);
> >> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> >>  #endif //_AER_H_
> >>  
> >> -- 
> >> 2.34.1
> >>
> >
> 



