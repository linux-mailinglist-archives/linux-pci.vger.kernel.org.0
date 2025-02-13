Return-Path: <linux-pci+bounces-21397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A989FA35209
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 00:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4213AAD47
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2327541B;
	Thu, 13 Feb 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fze4OOh8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBC2753F5;
	Thu, 13 Feb 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739488558; cv=fail; b=W27dm6G81EafQGFOjv6wFGX7QayM69t9Z1Xi2gQObpru82YIpnwYkZ1QKoiYfs87/Ld33Vxq5tNHxoCE6K+a20uHkwAsEYf878lelndllsbEL2VILmg4/7qCtJlZCxbVOc8iD882MHOBLlYoCb8syRfhRxM2k5grGBk8ZDAA6k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739488558; c=relaxed/simple;
	bh=yhqp78H5OtULd1a8af5fApAtTL0amNdx2hzQHm1dDgU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cPTsEWlv0FM+QKUvfXohToBE4eHd6dubKKVCpl4Fx4WMSksjgVxuO2KhHVCBYwLMQT1dHjIa5KLNIxJ/L6BwpAeHNodTcynRgSVn93PYJ0g90IhDa3a2iq2PiA7vYeqr+Fb8bVNV9baAZby0q6nn66/u51A/yZt0p6aT1BCjQmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fze4OOh8; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739488556; x=1771024556;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=yhqp78H5OtULd1a8af5fApAtTL0amNdx2hzQHm1dDgU=;
  b=Fze4OOh8E/lscsAAT8PlKatMo0XqOfblamyUXRtowuyGIyoZJcYazuP/
   FdMOYVEkNm+l9IjG5o0ozx3fOfWLOa52oCBtkGv4juVy24v8G7Prj7qs7
   35Y8TjPZ9bAaL/mjr4s1n4QG13IJk5ofef55v66dENNsNdNbbueQ6+ntz
   6JTNeC7L1fk93j1wuJnuhcVhxmIStwnoYtfCnXL1LkPGa0B9m/r0f+HIN
   IuU4YShEKWZqUHWbJ2U2pJfwzHfG0cO4PUIQYFWNDnRmXnexjhgZzW9c7
   p8El6pjDuIDIFCWJro5w1QlsdQFfEpZwgZ3IREIzzkTi3Xnw6sI3EfTSG
   g==;
X-CSE-ConnectionGUID: TP5Zr1RNT5yMxdm5DmgWgQ==
X-CSE-MsgGUID: COD6nRBPQ0CmX4AFwlgAOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43987709"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="43987709"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 15:15:56 -0800
X-CSE-ConnectionGUID: 2gWfZEHuQiakXe554OtcXA==
X-CSE-MsgGUID: wUTgxg27TTyKoRLa9A6aTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118494448"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 15:15:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 15:15:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 15:15:55 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 15:15:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbZSXhV1zmd1GEY7Rc0tiBgD09aqH68dP2id0JuWtYDoyY1F4Ug87lJUknhWPMLrA+rv5kJRR+rcq0ykWWsZYhWJpk+jXUQNv2FBEwL1tiiGA8NXFA291+Krf+zKhz+NxynT4pQJPpHioAaG5oDZ7Hiu27mL3QR/pNIfRLzQFnHgLHWiFlGjD77VigQ/6ZfQ+Z5YwjnBlv9XFxiiFJ9icIG6o8pjoZWwb6+KdQj4DVPZmGn9tFKVegYjkS/VHLzPF3nqRV62Hol4jMAUMRJtzN4x2zJu0fxfrsQkbIJ21cYyy7TjHs8Y5T1BJQyRpGc/N8BoyWsGC/4wqIifZYzxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrrqgFXWxaRSNFNUFVKoimFrz0QRRELMPXA1Cyx3KpM=;
 b=apQPRXNhvuG36g6cvrvYdGp69iqU6WH4etw2GhMpPBv6FEbxk092Ziu6YGZfpNhb2Za6caaZLiySzmf0U7+V1E+0BCDJW6CkEfjgof0Lh3WoqE3zW3PZFfoClNhYWaQYcbH7QxVp1nx6ZA+zwMoP76+GNPB0+9TdFp0iGrupFA10HnhZnrT2dDvVtgKGNT0Dn0QBJDh4sEzgWZr+BeTxOeUQotJlmTf1B58t5eh7fPC3OxVLyVEPLK1+XeKgGIioLtAgBPQ0s5/rq/hSBFkBbU4kq3/2mX0AGCQh1YK7yj8vkRbjhSRo6GLRYbAOaJV6U43tbzRB2btPtRchLiQE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 23:15:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 23:15:51 +0000
Date: Thu, 13 Feb 2025 15:15:48 -0800
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
Subject: Re: [PATCH v7 11/17] cxl/pci: Change find_cxl_port() to non-static
Message-ID: <67ae7d24bfedd_2d1e294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-12-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-12-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYYPR11MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e55dd33-841c-4be3-62d0-08dd4c845bc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SCgiLOKBS0KtXt6DRftq19bOTkxJu2Z3PIorhD/EYUGoAf76lrlPcQ1DXnOG?=
 =?us-ascii?Q?jjNwVkS5Ifep9lsIOedr2Y4zTbYw5UTP++zuY6smKaDxATP3lkjdE6KQCyDf?=
 =?us-ascii?Q?Mia5HD2AR4fp36rGTSNuYJ6zfFsjnsmdLgSzHUszhuc7HYbBcjjNiSImQkEa?=
 =?us-ascii?Q?txYYdRciThPzg7u2tQIYmKQDDtVEZ6ZHYmaeSgW/JJIiFTqu5jfEJLvXfZtC?=
 =?us-ascii?Q?VZfBu5biRJQnN/uATGw4oUEq7ATbFkKlfKMRBMQeqEDSNydMlu/DCa6rZ5mQ?=
 =?us-ascii?Q?wAELP0Z5FobjgOLtJSFdNvuReTKbOt2mFIm0nwPbMQOtw4mQhuzJzwxCJE1y?=
 =?us-ascii?Q?zx8N4M5tCyY4vL9luoqnanpcDTJK7xLyXHSL1xMjpH2ylkkc0qgwLsMAt2uJ?=
 =?us-ascii?Q?SLlbJMFc15psPrmaXZY1Q/OxaVVzAqklNxWNQ6rpTsdvH6kIDHRCtOO1E9VL?=
 =?us-ascii?Q?+S6OwWucN/mnWUja0fbrOGcYTLoQMzRTJln05zqwtZO115XMVsAAk6mBaLv7?=
 =?us-ascii?Q?0A0U6bAMIqcpfeQXLzYyUVaW2OQ+YiJyTPtbAer8BE9R0qMfURkoNn8+3aqV?=
 =?us-ascii?Q?c/hC5/p4hks7zwWkSsf/Am1NSK9NcJfjbACdu1Mpco+cpfprlxuq7YI8NBWv?=
 =?us-ascii?Q?gF8Naxm6R+wT43Wv1JSFa8AdtR7wnZZ0RarIGFIo1BRqdIGYX2mK4JI9sP3M?=
 =?us-ascii?Q?DObqXiggqM1a7sibDF4s7vu9qCpG2eeE1TVIN6jCRzFwql6XPs6KZAKoM0re?=
 =?us-ascii?Q?6L6l4+cI9YtZdsUO7NfP/qdodjk+3J6OiXVrImOyumZCW/6HEXFFoIV+Rfxz?=
 =?us-ascii?Q?Y88YZBoxkP6jxp/rDcTnhV/tkhS1r/4HMymRNEBO3tjXzFss6reJSvhrQoBK?=
 =?us-ascii?Q?wjQ9oePRCkqJUt6pLaypbfakq9eyKVcn2arOLe9zbgZwOg3XY982I1Px0dRD?=
 =?us-ascii?Q?/DrEa897ccKtHjFUX5XurwEACKqjZIyWmE67Dw+dwxhWdGTndnQ+X3WtEymt?=
 =?us-ascii?Q?HpgGvfSguzQLg/Th95LQCizK5fHBp6HA7zJ7qLLWDKSA56sOfS32l0SByTVE?=
 =?us-ascii?Q?UZMZFwSmqPJUCYrwj2UeR+svOuAFtMafEH6qfIq4vUPU+dqROdXWHdO6oxdh?=
 =?us-ascii?Q?XbsUbW5VmuLqW8uCizR/dXuwk3Qt4ktKqiUQTHXNkm70pugZg7SCxVkv2NAN?=
 =?us-ascii?Q?2m9U8WDvGgmN5KmwHpSsRwHOuzwikSgvvVeEaMfvHWjYG0rcxtoHHTxNrUCO?=
 =?us-ascii?Q?xaXSJ0/FyhWU7nnG6XqPLt4V3Jw5IQiJUHZ9tE7UujjnOSsG46+7puaLuzwY?=
 =?us-ascii?Q?w7cMMjyU++APRsnrbdmc5+j51x52rt2Je9By46Zovv9R1uk/DLVHbhZuVziM?=
 =?us-ascii?Q?2l/NyLckVhyVh81LYurIQhI6hwA53vnDl5hJyLa3gdSwRyrHAPdYliKO7A4i?=
 =?us-ascii?Q?4oM0rK09uZI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5T6NVkaooERG3v1TxmU09JSNSSL40Af0X9CP7HF+brQ8lWWVi+PuCc8Su4yR?=
 =?us-ascii?Q?XUZdp4yx5inhCxX/bO0DDs7+a/3HBLOzSgMYHB4x+Ay8I2vWd3fL/cmA9QuW?=
 =?us-ascii?Q?r45yk3c9nFhvjEH9xX0MBsGZQvc2fR6alw4N+Ak9YzgMXmGF1a4iK4/Kd6vh?=
 =?us-ascii?Q?0GlwaeaGG9TriozcbUp0kykMPq2KF3M691jwApLvXg3y2zIZy9hdK4ot2qcC?=
 =?us-ascii?Q?FEf353N8cQUfL1nMewTt4s2Fp4X3P8AzRNvg1jAAbE1NtGyE2waz0AnZGZ7T?=
 =?us-ascii?Q?3U/eMEQ6lQUVxwhz8trwpd5Z6Yn1C+OmdhotHpLxstUrS8WYfGoh7nMQb0cI?=
 =?us-ascii?Q?LWodsg5Epuj4abpoMRySuNI7JvHHZwYNl38Vtd52v/X4JNHUXPh33lHh/H+g?=
 =?us-ascii?Q?OKhgkeQ9LRWMrugkZfkfusqcD8q0sEAB7l6b2HvVhnQvuLUIn/5DuG1WhAx4?=
 =?us-ascii?Q?iTb2fFP42J/b0NkFVx4Qj2iLT7wKhuTPSqbEMcfAbor3SvfbADNW4v1nxG/E?=
 =?us-ascii?Q?tp0MwVWyfL7bc3/bGXnXeYYUhD7o+vMEGkvPKAvbVmalsBK2Gke5mXDL4ZgV?=
 =?us-ascii?Q?7Q62ZprhOOZQMy4Kklb6czVNAWnFw+oN1knchV5S/49Axro5Mn2ncG7jjBnO?=
 =?us-ascii?Q?h8g2bhoJiCPm0J5TVXh9CpXED2qgz7WIJkke/Q94sc+lGFi6sqO4wNsMdBPr?=
 =?us-ascii?Q?+nm7Q3TuZm/MxvCsz7QVURRARQtf5d5J6Lu72UfQaKAhoR3AHi64poMIzt9s?=
 =?us-ascii?Q?htoepKAfpX+1wsFtMfJUN/xGLEa5c8n4ebT7cEtybMnzcznd3qZRiqPo7Nuy?=
 =?us-ascii?Q?n9uatMZB3uOPUjM4aaSeqnosoh8m9edNHys7ME/vlWnuYkDCRKrVnkh1KMfB?=
 =?us-ascii?Q?Qp8Le9WAEIHHQpve2z+Xcfw3tnw7ARZgCXwk+9L0lpwb1r8FJykgLN0N/Li0?=
 =?us-ascii?Q?jVSZhphcz1ShsnM5mrjSC9XERWi3D7N1t6U8NqLGWUTN2F9rUvjBdwNirV9O?=
 =?us-ascii?Q?rEs/2mf9ZPXePQt6YAx32o3ffi50QEyC8Lb3MYZjjmhuRI7t+eyYWyhtABN+?=
 =?us-ascii?Q?Fk2JeZOLlMiiWtfis3sW+zwCCZvJZwOAwhV0BXJpLX7fa0GmjCSkDOw4paHh?=
 =?us-ascii?Q?VaucK3yj0ztNcQNG8EcwnRjm/UwcVpr+eOhZVW+aCcneqVntbuA6CUtGpFz/?=
 =?us-ascii?Q?8BxoW3Vxgl+VPrwqv2xLAWqMrapU4yTml2a+PGVyWnrrsWFzEwbqehLuuEh6?=
 =?us-ascii?Q?hruwKO6O6QE2AynulkjrRolZwnePDN6tT63xZMUPh0QOiukxL9penzOudr6E?=
 =?us-ascii?Q?ViTmIzWggVLfXhHca8Ivwpf++3cpmwhHqwS0X3wpH38vt9UbAe3CHpW4AFv7?=
 =?us-ascii?Q?MYMqS6RV/R04Z0Ha9M/PJ9Wle8EofvovkYL7lK5CItrfpx3OYooR8jO2jjc7?=
 =?us-ascii?Q?GvITCduZm6ZmgYV/460UgHLKaDYL7Ottn9EFgUs+aN+mJxj/vTXOxp80dHCl?=
 =?us-ascii?Q?LdRwLHZBtIy27cQdh9R5Or089z67weBu9dz84wsCNtB1fXdwTpO5FhmEx3i9?=
 =?us-ascii?Q?dDHra7JnXt0cxHJIk5SfLbkjiYJLpTO72zuDlwNJKZvQAGVtKPulirgpS3RY?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e55dd33-841c-4be3-62d0-08dd4c845bc7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 23:15:51.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+rfFLxUHRpDRnUUr9WvoiQ7dRtz2VwVrlD4wEAmGk0Z01Wg38EpL5BG8ZsBgvWrqgtf0A65egXqqMQeIsOh9yEHq0ooLNu12Ink62yf81Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL PCIe Port Protocol Error support will be added in the future. This
> requires searching for a CXL PCIe Port device in the CXL topology as
> provided by find_cxl_port(). But, find_cxl_port() is defined static
> and as a result is not callable outside of this source file.
> 
> Update the find_cxl_port() declaration to be non-static.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/core.h | 2 ++
>  drivers/cxl/core/port.c | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Looks ok, but this tiny patch has no justification by itself and should
be squashed with the first consumer.

