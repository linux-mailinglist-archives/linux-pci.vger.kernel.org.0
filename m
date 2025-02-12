Return-Path: <linux-pci+bounces-21253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47969A31A71
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA447A1690
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B617C2;
	Wed, 12 Feb 2025 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DF+p5HZM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E815A8;
	Wed, 12 Feb 2025 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319911; cv=fail; b=SneBy2GyzAUVkM49SNVzoxp1SBS65iGIc5tYgqzKuVk8fNZHf8yhC9YfLBm0ZMaaQU/+z7PaAyCQS91Um3tCu8FxnUEct3WCOppo+Ge7n0NuEr84bUR/O5+aTGD2DYG7FKoqyuPfZXZMzcDLbMYkd9M1+8PnCOlD4HUNxZ/M1cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319911; c=relaxed/simple;
	bh=70m6gwFgg1HTDLUxePN9RGX+WH1opz6qRp/UhEGztH0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dMrbFkdsXQlU138eRjXYfojRmzKQS3e0IEI7LgfWX+wiUVWAyMBxYDTRlQPyF7qmah0fsdSZRuQQoAtRy+xrrKT2OHKt+za6jRH4BWOeHRmr3XudUUY6Vcud81mO3voqV/CG1bOlJA7phTkHVAIcRwujld6NRu+U332vtxIbJEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DF+p5HZM; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739319910; x=1770855910;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=70m6gwFgg1HTDLUxePN9RGX+WH1opz6qRp/UhEGztH0=;
  b=DF+p5HZMTANwv6DqPC3ILm/MSeqwLlBKIdpIMvpjUQb4+COZi6Ipfnj4
   05bCIlcfMBUdCdRvx28TEsSuVb1cVEhbI2TvfsUppeJGBCNp0z8yWaXZG
   m81S5hkt9PdveBr0gKAKVj1hfEx5YMfv0Oxxx8YpnAYJnrusOd3R6LDtN
   v820FUS4+GHWv3YSEiCk8liCIiUlcsBSzxO1kC4EzBbJxAyXoYIha10C+
   Lsxh2aLsIlBSE/goxV/ae5b4WqLbvMhRHVRKgl4qBwQQnf5DVCZl7GzK8
   MgC3E1T2NYeB43sm7u8Xn8a2JLfDXlLWsOb+gC9dBoTszCnjGC+EzRLgD
   g==;
X-CSE-ConnectionGUID: uXonc7PLQUyFIA00DLyNow==
X-CSE-MsgGUID: tBcNywnhRJG/Ml+w4cCAvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50599934"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50599934"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:25:10 -0800
X-CSE-ConnectionGUID: ysikuN/vT3+aeBzsWk7tvA==
X-CSE-MsgGUID: 4UpCiXPvQAaM6sjQG0meaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149845855"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 16:25:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 16:25:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 16:25:09 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 16:25:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnaj2tBeErYjrSKcfuTKg3ea7J4F/mrVuUhYo2Lc1lePdg6e6fCU0S90Q04fvzheNoWRbbmv694R7HN/hb9lCMMt+rFl3IxEvpdLmCvHEKaC8LjVmu0Ky7pa4hzQgYMepykWaXg33S0lFoH10xdXHAza9DbNOoYt/lSSGF55aV37RZ0wBj2DSuU/nNmREjre+JyRFBQoPp20ftHbMY5/MeErZJdiw3ECitf5oQqQ+BFSvy+ijJW6fdYtZ4NPKqxxqVe2yFkZN2QRm6YvAOfjo3XHH3FE/GAAMN5JVbD9MFAzc3f27HuCKMzzdpeanzi9rVATTdI4oOZEAxuzBUADIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo3C8kU6/guOv4/nxToirpM9cqDhqoIO4bmgY3lcL3Y=;
 b=hrpGYqUmmPZ7WL1EBk3Jm1xBxNYLA7E7uqZYzrC5UY1Z5mTrJNzbAY2oUiNmeIjtBaqgECxw7Z96bQaZ7p3zoshh+GKJXa2E06o05CGogzMoDODII8b4TNvEAgyuGp5Do6YSHbi9MQ4T2ovFhKjQvhzWCFIdh4YVUsGnx8vD85RaorIrJtI+yP8c/H8D4ggM6flr7ZYgnNsT8sqZudBDlwJ1CBdCPEE/fPKMF2Mx9PMc2fJILnAbOytoHbnEkM84cuUhchLCK3IdUjyvbJfEkJcjTuJF6aelXaAmsqEOKCo5VR5OSyoJpf3om4H0sPw+8AG5/5yGxes0ARFEJ4cVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6092.namprd11.prod.outlook.com (2603:10b6:930:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 00:24:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 00:24:40 +0000
Date: Tue, 11 Feb 2025 16:24:36 -0800
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
Subject: Re: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
Message-ID: <67abea44d80f3_2d1e294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-7-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-7-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: ea884bda-e117-4e85-eafe-08dd4afba3b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R2wess7G8x2fMGmpqrketFEeBwTrgtXpD8aiQ8p1occlFT+d2rkdRRz2dTxE?=
 =?us-ascii?Q?728XAVZu3196uYrJkVQBv3SIfNU59c+Xl6Y8qEfYZjh5tdaZdtndwVTiHZ+L?=
 =?us-ascii?Q?aDoJIFCmfRgfNgzJe7MporoVKtz/Urf79Pr82zUZ+P+BrUJD6MsK4qjpTupq?=
 =?us-ascii?Q?YIjvcfcp0HpI1WcYqBB3wOD6ysS7QAf6MVrnl5RIyRl3sK4k3QvJyewUSDT4?=
 =?us-ascii?Q?9rY4tNkzfWRCCpM4dANXVFYybOOfyDayDRwQFSi0ovccdsZq0cxHHXTJjUS2?=
 =?us-ascii?Q?8wptmDR9ssEDikU5PrwexCDB3g16vGV77EY+/qlvXtu0SaKXksf80qnF7E2h?=
 =?us-ascii?Q?AqGdqH3lDsXhMB4UX925FmI+CKaw7xJpKBx/TYrQak+4hcXRKD3x2OuR407o?=
 =?us-ascii?Q?e010+im+DHWdg6m9+eetRJw+YC9NsV1wAdZtYyHSZqICBr7d9LxHm9qHbfhG?=
 =?us-ascii?Q?259c3jWjqpGphMKp2Fn12RICceepJjVPoFljAxQLXhlEXv+RvLg2NQkWHkmM?=
 =?us-ascii?Q?lvYa/bBHf64Fswj2HbU0LX079eGacGd1sPlNaqdO56BEuPL7r/VWQhGvfpOz?=
 =?us-ascii?Q?yXzr5TuVnsxqMXlfWFVoOTCoZ1WjKCxz70Swk9gTv/6+bX7FgKu228iEOEde?=
 =?us-ascii?Q?rAIdYmCJq9eMGUly0JIryum3w4+s5yQrl0W/o8UU0Op1dQ4dEdoaZ9VRCIy4?=
 =?us-ascii?Q?hK4SP6GLzvEGOsZap4+u1aSLtsZSLKxii7/kWpgJaU4e9ijTSciELjZWpMH3?=
 =?us-ascii?Q?l5/hIlsqdJGt7r4ebVdmlC7esyrHGq1oRNFoWmVkU0mAUoVDbKMpC7zC2MGB?=
 =?us-ascii?Q?LXOtPzPiNnqQpsdE6zrPSfTLYqeTiqagU/bKJLaPdWRIYOPY3pGOcFw8vDLs?=
 =?us-ascii?Q?BRhKfSDuMOjMmkL9NWcE8jlyZ3KSBxRAsYIhSNhnaCYSl1n3Z04yRmBRiN3f?=
 =?us-ascii?Q?hL3qdwJN2Q708Y7AEZzx42v8sWSpbc9t/Y59C9GQhag5XwCcIzYF272bJk2s?=
 =?us-ascii?Q?v8P/Snu41hBIIa+U7NZ3+gJc8s77gtu3/42o0LJv785zn93WTHpceFHVmEQk?=
 =?us-ascii?Q?SCHJHvBfxdrR+wjEmlsr9CQYCJQhfp9Lz8xrh2E59yMPQtE37vV7yq66xRG/?=
 =?us-ascii?Q?mk2kzfWGc1DBTgvg3vI4nU963HpE9In2R7+myE/XaeBa+XzJeiwQ8MFR7Xl6?=
 =?us-ascii?Q?wH22zO3kgAIcd3e1dpqQlkZW26FKYvK1ogxag+ibB8eOL2NpMy4UAvCciGsj?=
 =?us-ascii?Q?+49BcQlyr6S8nCOOM/2Rg5V91bzs/0h4QcylBtxuD2OwkrNg57fSffKOQAaG?=
 =?us-ascii?Q?Zucb4gohDjRbX4D0uPS6wzk0XF510JN6fUiS/LsebSoDbJAuR7x0h9nfNQQl?=
 =?us-ascii?Q?dkeqg1eSKzMl+ek4d90TR5LTVIJNzAY7mPuXaQVdSdgAKkuucoli8Tmv64Py?=
 =?us-ascii?Q?zBMrZbhYyWU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vz2im0XUzOcJv2+aGOJ7Il/FergELFa2ZnL97hJatS26spwj0M8JfaXrZftc?=
 =?us-ascii?Q?qotosO9DrO/AuqrdGX+kqxuPB6WdxNLmyMhr0lvxKbF95p4Q7B0OvPdGoyda?=
 =?us-ascii?Q?tP1SHXGP5gn+e6gO7gfc2NS18/LWH3nJ+pZ5pocb+othhDVhHapfIS73+P7a?=
 =?us-ascii?Q?0+n5b23+NYW/yoqzFkEnZqZs08/hPRqvCQkz0F02dxiKkT5RVFmISvE28Nds?=
 =?us-ascii?Q?mvGYKpCOXNKQcoMcdUU4u76oxYMt5IelkJHvEddU1UQyaWI+Hjx7zfsKDQrZ?=
 =?us-ascii?Q?2E7kxkMbVXGpjRtZyvfLJaQbZRuNaQ+i+E/o20fwdFNrCq5Uh5TKS8ur4oXu?=
 =?us-ascii?Q?JMpkObKQpBvR+k/YexZPbsJeD9WfkhaCwaKZomr4+cnrbS9AC7ZRYTtMx4LF?=
 =?us-ascii?Q?xBWiGXHefHjsMtUm0B7dlADIakRLESqj3727gRMdCG6ohBmeXbpghUPPH991?=
 =?us-ascii?Q?NEDiGW/9P8l4VkNTaHp80070Qjm+sVk3myhisz40h+7k5OTMTaobU/bYIJAF?=
 =?us-ascii?Q?9eJBKv/7BnB6tGfa/oNWbwjR5Nb3OmVq6FA9ZlKKvmyOQGh14PaYWM71Ab2j?=
 =?us-ascii?Q?pW9vA5H7JycYsTLlXTlz3fZ4Pnf1Dh1I9vOPln4htqe8tk7DztGQ+ku6LbVX?=
 =?us-ascii?Q?rhO9QV6D9Bh5Q1MRosM1YDhvSsWJuShNnY/TddIixL3QUJCpTwQmQlBWxDNf?=
 =?us-ascii?Q?83I9mvf6Q+bXhPdnJRkdXZJTSgLBn/RTFpDDx+pEv5IG/lAwTgkq4NObzkD0?=
 =?us-ascii?Q?jBBW9OSR8YkSOtKyD41tIppP6Vparz/7MLUqbB2i6YT8MwEuGWTH7BMYGCBV?=
 =?us-ascii?Q?ml0wiMOTSTruS7EW3+vOPeNQKa3LaT1mz00nobEvuFC5cPwSZLSe+QlDZrXB?=
 =?us-ascii?Q?Bihj5TkvV3u5yGueaVX5vh12CFotZQBdu6SDBuipsSSuKA2U4iC61OqJz+1I?=
 =?us-ascii?Q?Ox994OAzbsUnWAT2SQI4XGz5FNxgx6TZ/3tjTNtI28jdw6EcPWqp3jk8V70a?=
 =?us-ascii?Q?Ws2GSOAKI4y0nAb3UC7ZvhzTKtRV7T8nqVtubdfS05msJmjb48yV8+1wprZq?=
 =?us-ascii?Q?eFn7z+x6nJMHj9wmtG3xACPeOjJQH/0qQdah+CbO7sIyCsCJLqhXExXTFDbM?=
 =?us-ascii?Q?7ugKZQ76KXFzM9u/mMo/nzuTGNsJW/xEXLMJRbLUD3eBqPz6qu2XafsM3ZRo?=
 =?us-ascii?Q?1+yp/tYg4YH9W6YUsx1bSaefXGHM82eHvQrCAJhTSf9Ts3U8ciVMkQNq57Fl?=
 =?us-ascii?Q?5kFVHaTmDe+d2DFx0WcywFbFH8bF1iYd6sZjqn6aKUf1nxNAtfu4NaUKvDLs?=
 =?us-ascii?Q?8jqoIVYnKxQZuK4inSAmjZd2xFGb9mYaWMmidXcT3TcpwYQq0ZHOPXM4f59w?=
 =?us-ascii?Q?sRzm0fMuINjFDfdlebOdoiFyx18/PtW6Wu9U1KUE3CkuQMVjR40yw6upU2ft?=
 =?us-ascii?Q?Oy8b73PwLoIg3sBba2GMKdrRWf63FF2uIs0ndu2BwR9lH766/hljTh8A7IF1?=
 =?us-ascii?Q?SnKs7hM1IFA+StHpjqzmc/+2sUFSn3yHi5mSwkQrZH6r6XS0eGDNJzf1PIOF?=
 =?us-ascii?Q?sZ87xfLS7+KgAl1KV5eUxjlBbaHBvXHj4jHUoaLugjjXTFrZXDlYvpzQ1X92?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea884bda-e117-4e85-eafe-08dd4afba3b3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 00:24:40.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5D1RnjmFyf2IkI9iF1jAej0l54yNz95/6ljX6Fb4Usb+48eLVwR47+sYxArVbJnHFQrxcbcopUq3WbCSjfBmzl/8x+SiJvdNNGG9I2tfRtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6092
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
> apply to CXL devices. Recovery can not be used for CXL devices because of
> potential corruption on what can be system memory. Also, current PCIe UCE
> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
> does not begin at the RP/DSP but begins at the first downstream device.
> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
> CXL recovery is needed because of the different handling requirements
> 
> Add a new function, cxl_do_recovery() using the following.
> 
> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
> will begin iteration at the RP or DSP rather than beginning at the
> first downstream device.
> 
> pci_walk_bridge() is candidate to possibly reuse cxl_walk_bridge() but
> needs further investigation. This will be left for future improvement
> to make the CXL and PCI handling paths more common.
> 
> Add cxl_report_error_detected() as an analog to report_error_detected().
> It will call pci_driver::cxl_err_handlers for each iterated downstream
> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
> indicating if there was a UCE error detected during handling.
> 
> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> fatal. If a UCE was present during handling then cxl_do_recovery()
> will kernel panic.

For what this is:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...and perhaps it addresses my concern on the prior patch that
->error_detected() is responsible for the safety of checking that in
fact a CXL internal error / UCE was detected.

