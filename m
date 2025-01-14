Return-Path: <linux-pci+bounces-19775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 509B3A113CE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B37188AE80
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1C20F090;
	Tue, 14 Jan 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edSXHQ5Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8B20CCD1;
	Tue, 14 Jan 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736892194; cv=fail; b=DVIR5lEs/L+akM2Cjui4ZTADTDbzTZai0Tevgi/8edrL7J+CoGk1PchLrm3+Vt+xr4hO3zeulsBtZxxXFih3Qi8KeZnZyEQQc0v6cuOe3QF4zF/TVdC9fcU4+jkKVeNPWQ9furmH36imr+Ci/P+NLin/NgATdeb9wEMKT71ckCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736892194; c=relaxed/simple;
	bh=QMffI2RgRPYkX8Xmg3VZaAiyj8zoNojAq7vzzy+9Hes=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WkcsVkjUNJV3Vy4H3XBZuPCHEyuCSM+eu5MOz0g/X+26y88NYg9f9Bm1e7CCEudHSbLIWD5CTRF2w2zu+F4XrF2LDX6WCgOHKP3Oy8iNayq1ZQLDNJkeJ01j5tOvSCYJYrZ++ZV2gdYsICssi5izu3B1ejCZtudHbtGp0xJ/Z64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edSXHQ5Z; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736892192; x=1768428192;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=QMffI2RgRPYkX8Xmg3VZaAiyj8zoNojAq7vzzy+9Hes=;
  b=edSXHQ5ZDrDtSsz1CQrmDsY3SA1Ocwa6rauiTaHLJEZoHfUPgsroadEM
   ZIvHHkaW0BsLhVXhs8zmLiSw0wnoHUUKsjDVJLvXfvyor2eFyFrcpX2Gg
   OGjxg0dWbcuwHJGXOaVaoZDpAzxSHCmNYZK91+74Rx7kC99T0kTaKYXbU
   BpnAZuqneb51T+/1bdJ3eClhe/ZwY7UPuSmLXLjoWivBdAbdYz9klyC1v
   Yvli+jXGHw15Nl/ipGH7wY5ElA7csvgs+4kB8VA58Hu88jOXwfRo8w0l7
   qntJ4R85G84es1f/9/eIN36BD+w895a0eB01Q80msP1NiSyqlgvXOLWwT
   A==;
X-CSE-ConnectionGUID: OKPt2McaQZGGk+OnpHN7MQ==
X-CSE-MsgGUID: JP3+2Wk/S5yj9+kiF6z1sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36420908"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="36420908"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 14:03:08 -0800
X-CSE-ConnectionGUID: JaXp/84ZRwuh8fGnTBo8QA==
X-CSE-MsgGUID: 7SS7DCHnTECy1LWgdBKI+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="105116116"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 14:03:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 14:03:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 14:03:06 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 14:03:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGddxPGs3AGOiHe6WzPuk9QHEX1aiapYGYORDoKDTVikuVFpqxIXbEceZvkP+1DYF75l9SRltExv4v+lQZbAHaAdxJeXDxP0RCZt/CdeWxM9kJJEUzRG4qYTpqctbWZebP2pUQHcmJDI4ZO6/pw31AmtADEPZOmnc8xf5g0ZlVdgFix04KohQaXgPJap6uOvzbSIKpVKNDH/lyxhuEmx65dGAMfHwgFqqzkAlR8/VQdZVgDAXdnWHJsq8StpZw5yCkt4ds8+ULm2zFQQs7JABaa3xmfITbzrI1AMeKqzWupQZt2ZrMM+7Hzdj+Rks0TkprFxTwQmRaVDiln5loHxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfuVACbGs9rBHYShX+y5E6Qmhga8Ls6tSTrNcVz+Dcs=;
 b=SCy959Y/FNsehyOtC0+GYiTFpIfHWFnn8aZsiloWFeMKlmMkvsgBsNPg2/mj67EjMVSFJdV/tTwboePsTuQ7VUt3mbkSab25pWyF65SxUhbuKg+c8PUx/xwjtTVT4UNxF1w/FP8tkptDfd5s+1Jn0G8SieJqE1gLCIh2nXJx0nTXd8MYFzMtZVjiT9T8mH1EXEdhcn3/Mg9Bj8/ZIA+FZ3LUD5O0qXPhJJcUPxQNDkjDJyit7JyCWG1WocctJOYv92zKQRtjxMKy/8RTKVFZ5ymS1H+eytNLCqceR+BVqlLvZTsKUSnMxlEiIn5irpjnefPUWXRJuOSwRGxWkKVjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7363.namprd11.prod.outlook.com (2603:10b6:930:86::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 22:03:04 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 22:03:04 +0000
Date: Tue, 14 Jan 2025 16:02:58 -0600
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
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 09/16] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
Message-ID: <6786df12594c5_186d9b294ba@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-10-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-10-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0354.namprd04.prod.outlook.com
 (2603:10b6:303:8a::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fa0aa6-1f1a-41e2-3bf0-08dd34e7385b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ot511XoepxG6Sxu6kxmpI4vXC+lgqsjUQveuVlH/Rk9G3PQENdXw8zP3y3t?=
 =?us-ascii?Q?ePUOF/DKwjMz5m1d4SOFspuzulX90FhYdUidE5giOijeE+N0pcx5yQcplF/e?=
 =?us-ascii?Q?TBmfTSjZtme1YuDCfg0nI5BeRv9iSkd/bDSZkSw1zfpz3h1x7loTq2VOCcFs?=
 =?us-ascii?Q?/KCioSB/NlS0jXQwTzVr2s+iagn/h7T7OwHPaOv9+s91CAYFoQx7pXcd2v+D?=
 =?us-ascii?Q?0IxMSxkqHt7dP4r090WLtkNkO+iNePO3wioAXume3LCgFvXRKU0ldYANvF5o?=
 =?us-ascii?Q?cluiBAeQHdUULnQqlNpU1HMrDUnnu5nogHp5mZBw8TpULiDQKXBFQe3TPpBx?=
 =?us-ascii?Q?zsowLq7rhv+GeCGKLNDAH3v0pY0rQD9ZPH+RmFP1GdrZO7dI7DsN6ggYUB5E?=
 =?us-ascii?Q?PDLHe5Z58NxojaPJoHnaNGoIeNmTZz/EAxBF3uNhGR8TKGKt27XKiKQzzBaa?=
 =?us-ascii?Q?CrTBNgtzCqyUNh06KtlQ4KcZPGZk5bKEmd3fVJuhoKrfGRX4eXv06yOD6V0x?=
 =?us-ascii?Q?C5A5q0mSpw22Z7adiI0mlxz42hgak9Uj4V4LRUXt/YlJreCyWs8MI6PdEdlL?=
 =?us-ascii?Q?kDU7w7aYh8RcVxEV13cME9kUcuSTeaLLw5+Joae/FhuaKSv++DGwwzyHW88P?=
 =?us-ascii?Q?cLXykV6f0kzGpyZTjwNIQ5B6Xb87qihbYDziLhHVz8R4GnpmYLKYbvKMyIGt?=
 =?us-ascii?Q?D+Lso4ijdFfEAu66KuT3KW4ZG8AfZc46qjZW7hktaPCr2jyFOAyoCrZXSKiz?=
 =?us-ascii?Q?MwPBoJ4p9/dD2FW0siFuFhvOaTI8uQ3QUh4KPN8tpb63ChQK5tI8hcMWbWqZ?=
 =?us-ascii?Q?oul2NU6wkyoJmg0qWDG6TC8SP8ZSVxmu1A/mZtWirm5SVnBX0mrIWyC8Ec76?=
 =?us-ascii?Q?zr/m3D5NQ/QfJS+KQUyQLfaK007SZBnIYsw6Uu7TtkTlihtyqReURVjQ5mZW?=
 =?us-ascii?Q?B1feetOXJEDy3r3PDs1Vlt+rNER2ZVTVo4EkD7sCTMFFowDvPA1KWkzUMiB0?=
 =?us-ascii?Q?BvNALh9DuXSw37Zk687UH7R2erde65H/vtfMsuorE9tsmUFK2iDcoVoNdrYx?=
 =?us-ascii?Q?SgSuvfkJnSLSGDm2uTI3RyNkpbGGf6rjLiw801D2rrxNMiRO8nAc/elsGcmZ?=
 =?us-ascii?Q?wgCn0ZPvT8uv/uruToYy7o0zc5N3Ns7fmDMliU1aPBVKVnlL/h+OkcKfVShX?=
 =?us-ascii?Q?O5pnwYN2vwNsupidNYaupBoMylaEPqBh3aNwpRYozgLs2IT/5zVzlxQkRbIE?=
 =?us-ascii?Q?6xnw+fDM5NsU8VyTIJzAHYSseWqFkucw8RhC69TwvhfOYEioDt5B461pOnrL?=
 =?us-ascii?Q?YW8lPH6VU5o7cakCLAQcJAwg4iqZjvEAvTqudRJUx+A0hpTfGRYVeJhKmrgT?=
 =?us-ascii?Q?p+lZSmVZwBY/jhp6z8/YipY/nUSxXYNET1PksIfcX/dnuSXHOCmVFsbCXh1+?=
 =?us-ascii?Q?XGsH3H/NVTs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iDapugnyM+ALHWW/3RT7MWo4XCObOiSb0D6teln+85b18vUrJ1lXwIS3klnW?=
 =?us-ascii?Q?sPc25IkBtzexYsBEYMabJJRu+inCKMuavRISqFNKaGCEs2QIkkFHKmfmPZ0W?=
 =?us-ascii?Q?+ORQr3i2shHxQZG1rT8T0G1Tj23iJJD2dn7pjwR2xrSmS8LpZWAbyKxoraOJ?=
 =?us-ascii?Q?WZ8dbsZAzjxIfSv076AcR1LjOYvqHHnAbSelOD//Hkova+iyx7cR3pljofsX?=
 =?us-ascii?Q?uC7+B7/w0pKpU5pnVnvVlY2NomhLhyJGYDSKDOE2b3k1TzAA+w14XIX2ImAh?=
 =?us-ascii?Q?zVVjHOt0Yt51poVx9q5ssH0XKMmcKMjJkUXrPXGq7FbC9N8l69F8wAzEQhEe?=
 =?us-ascii?Q?XBOL0HIEzVMkncxCS+wwVY4JvY9NOIg6VPzIQo7htg0KMay0O5RbB+pYp/LE?=
 =?us-ascii?Q?3ZwS2zBfGDH942lEqE0nvejkP8qDSUtXTYxfW8R0Ell8Yrjt07gM5vEvIBNM?=
 =?us-ascii?Q?Ls8imsH716rmqza8nxfdVMHhBubMCwJlBkkVvjCswrS4iBQ2jIcIbhkvM9yq?=
 =?us-ascii?Q?U1dvwBmxeKJwLFanl8B+ow6IGB/JHCZ1cABxnLfbBd5lHlDcPEwuopA+SFnN?=
 =?us-ascii?Q?HDB3jf9A6oVBDNSSwHrJMpMwpSCc7AlfLTfK6d0RixAONRPGm8MI9SWy7I7c?=
 =?us-ascii?Q?T59bmK8wHDlL0cJGsrQwm9tC5pZk9I8s8tcgUOGpjKQhTEem2iOqWV0C9rj+?=
 =?us-ascii?Q?JCd1TaUD3QMeiC3rmj8WiX5Pt2oaDVTKdiIB7rqVYd9WtIYmq+dYQ8+W7Zku?=
 =?us-ascii?Q?otmwEkjPuCGTq3bKQemHbP/+oC0jhfZ1YdHQ6qdwXfBdBmohJnQqxU5udoX8?=
 =?us-ascii?Q?mtnsCE0gWbH+H6ELUk8VX0hu7So8qRV9NkKBu5z5EBeey+GeuWAB8Erlihuf?=
 =?us-ascii?Q?QvxjcP+k1QkEUydg9jAcd4QknFiE775UhlmJMBygj829T31XkcrUIHNandJa?=
 =?us-ascii?Q?mkVdGDEaxf/ProZSZ+YUc2ghWmty1DUja0BkmePkjd9SSrVA6xMyRvMgFJTh?=
 =?us-ascii?Q?0ffUAPX/MWvckQiOjaeAt6SyFnyYBpNjh/pUvpfJWwlNrlF8gHxPhB7eD0Ui?=
 =?us-ascii?Q?fGW5ORQ2iHdEF/lSzbB0t3j1boQ1iXbqiI+Y6uZrRe7RvHfBUBVeFIGqx95F?=
 =?us-ascii?Q?u77UY9xQ9nVVZqcUw3oDStgv1S3FhgoNNQl7Gb9aVQ1NYoAmXyQ7TKw8Qt7b?=
 =?us-ascii?Q?FBH77/jHYR3geGCbxO2C0983aETwzCrV4/zHabeHWNckdZPZ5zv3DCd2UW96?=
 =?us-ascii?Q?SDfYaJ037c2BfyEOvYHkqSHKG0aRfQD7prWqle4znVkZ5C+e/oHsnB/0NPhQ?=
 =?us-ascii?Q?3Bs7NochyqTgvbasjp6PbJk9RivCf10Y2Tat4E1Gsv0o3OHSMBJT3wVgKA4H?=
 =?us-ascii?Q?0fUtviOYyTjDk7DyOlp6J1Cnp4pO5av9uDpmZnMrf82HCIz2MsmvPvrjJt4j?=
 =?us-ascii?Q?h8hCakdDdFbot956vdUCFpZTkJUQns0libLLE4CBIflfKuQo1JvKpwSuOmfi?=
 =?us-ascii?Q?JiacB5bhAzkX9QKWNeCPr0cgNEx+PlfTI4YS7gnDqvox0zyHqyj6o9PSE029?=
 =?us-ascii?Q?4YlB25L4l83ih+i+WrJ5Dp+y46kVe1Z+otTUXo6v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fa0aa6-1f1a-41e2-3bf0-08dd34e7385b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 22:03:04.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +USoMJOtkP+RbBnWEK0sSOZWQOx4RWnvXmsPPvAnxYaiUVksBFigYx44jwKodxliKp++BkRoyNzb8+XXRWjYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7363
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
> 
> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
> pointer to the CXL Upstream Port's mapped RAS registers.
> 
> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
> register mapping. This is similar to the existing
> cxl_dport_init_ras_reporting() but for USP devices.
> 
> The USP may have multiple downstream endpoints. Before mapping AER
> registers check if the registers are already mapped.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 15 +++++++++++++++
>  drivers/cxl/cxl.h      |  4 ++++
>  drivers/cxl/mem.c      |  8 ++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1af2d0a14f5d..97e6a15bea88 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -773,6 +773,21 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +void cxl_uport_init_ras_reporting(struct cxl_port *port)
> +{
> +	/* uport may have more than 1 downstream EP. Check if already mapped. */
> +	if (port->uport_regs.ras)
> +		return;
> +
> +	port->reg_map.host = &port->dev;
> +	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> +		dev_err(&port->dev, "Failed to map RAS capability.\n");
> +		return;

Why return here?  Actually I think 8/16 had the same issue now that I see
this.

Other than that:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

