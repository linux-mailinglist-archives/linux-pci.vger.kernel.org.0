Return-Path: <linux-pci+bounces-21407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29DA354A4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F191E16CA84
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFC23A8F7;
	Fri, 14 Feb 2025 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmlHwXlG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4FF3C17;
	Fri, 14 Feb 2025 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499697; cv=fail; b=aqub0f2/GHjLrNwno+3QfFJ7MeOA2I5bZcQQdYjSF360m5zt6Q3Eku84F08Gnkp76DBJmxXjfxrEXlL8Ti/zA8RlGMo4PF3QkGRggCm0uagjhGnYJ/g8iqYsbv0kI1aJy3b1tB2kFf54KA+6LU+6OJriKXfi7JrJB5xC3XatL6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499697; c=relaxed/simple;
	bh=kg0oEL0X2d2HTpQE/Vc8Ld7agNj0hWvEA21FWlg6lrc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hBiNt2nvdDk6PcLnRfmh8fP/kVGDhowlUKKlJtKCfMoCBi+02oOTCx2Kpwn+etcnCb3IwLvpf/+RlZ8nO9Yq4FNGcBaFNplOzJUwi+u1kdCRfWZU9D/SDMawpVhvkLLduRajTq4tVVLi094fLOUq1OVVLIFXttZ1lRrLDt2HqLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmlHwXlG; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739499694; x=1771035694;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=kg0oEL0X2d2HTpQE/Vc8Ld7agNj0hWvEA21FWlg6lrc=;
  b=MmlHwXlGGaPEKAKu/YxGKnEvz3z4WBN2K3uRaZOEXberrfQE3c9R3zXa
   G5LDRLsA14El2ifAur0ERvof8FGl/qd+wr5QJFx63HDqZweoqP83e5j3C
   fnX2Qk6hLggFL67eMgP4gfNp6GcfhP8bqFLT31AgkYP9R4hqFha2r8xKf
   +Gf+QYzv8rPnKY+RYitp5NjPEMGbKI1gj6tzeCUMkNAYkJ0b5BOWMFv5u
   Qr9K+9Uu4uRNmbhFhwY9UeEm/JLQNQYrdGUFiFjZjsLyWjpEhsGLKWxCy
   kZh6pmS/sXWzeCFaBtPqCdfnhoswTV/WpRDa29SQnr8lwXUgImeaPHKwK
   A==;
X-CSE-ConnectionGUID: FruYImS6TjSdeNyeqRJ1Kg==
X-CSE-MsgGUID: VeQiI2R9Sr6roPkdPkr2RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44166397"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="44166397"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:21:33 -0800
X-CSE-ConnectionGUID: HXmltPqVQeGAsSmf9IrjZA==
X-CSE-MsgGUID: ny2dtxnMTdO25hbLHka7KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113812457"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 18:21:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 18:21:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 18:21:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 18:21:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqOfKRM5UVuh7UZ3o3VZkYtD6gkdEgotsQS141jj1D9U8HPP6rT3VK/vTRxkXqaRn3D7yyaOD1vkf3rOxI/Jzvtn0Nk6cPXBVYbSS3dLvLznur1X6RyvEOhW6KP/YNjuRJRg5B5vB1CeEk1lQWlOW9fWZeULJrHMk/rfPRA8O2MC7ubWy1/NEHvbKwJta6rV0Q1mwa68Yszfg+wln13UMtPh1U5sS3tlN8fFa3N4+fn7VHzRIjkEanVkVBTCF2tHiDz8VbCiMddPQUDQo+RzKAFiUqV54Yss82srKBjDE1ODKVyE9qcr7hXqKF+U6Yj9F+Fbna2+zPptBiMbD3b9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R7F4xmtyMy1O150mKCC4Kbc123z286BrxjWMwi4NSM=;
 b=I5VvmGOfpLo0i96QpUSq8QetdAxn/NpI4ud/jEgwu/If6gspA7Y+ixQzFdK26dwls1koggsvVgyEE68y8Pb1JZX5avbHCEAy4NeEm4XNeiajUmO3U13R0pdU3XxpsJxQG2TLECba05sB+Bybkvf/LGsbnszk3SmBfrGu1DFPPnwx0hEeDa6p9G8rCLijBuAf4JsYolbQQjjl48SGv4u7W/0H8XnAkgmN9vzSCZaZyKWMmhXp1bsEmwJTKB7uKt2A0RLjNLzPtiMXKyeVR1mDbCLgaJc/ahPwmrXyON5M64O+JLlFKZFrRcA4MNnVkV+C70Nc8WZlTjf8CEkuBU9t1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 02:21:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 02:21:15 +0000
Date: Thu, 13 Feb 2025 18:21:11 -0800
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
Subject: Re: [PATCH v7 13/17] cxl/pci: Add trace logging for CXL PCIe Port
 RAS errors
Message-ID: <67aea897cfe55_2d1e294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-14-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-14-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:303:8f::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 360e7b0f-d54c-44e6-3a37-08dd4c9e41bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xLS/bI35ie7cPlQK0IdbeozbwXpHF/5Q0AUehWtMGpuxLTAct7VUAXzb8A1N?=
 =?us-ascii?Q?LVMI5/qQ0Ap4oN+RMcRJKah7xnBLzC95Ps8/22E54ZN9mKQdOlMmitcinB7F?=
 =?us-ascii?Q?+KKefIm33pvfrX3sjaAgeWZmgAoOkLs7hsAjUr18gFeNsSbwuaMCvIcIqLOC?=
 =?us-ascii?Q?ZnR/beWTgVCMIAKlPuCijgOkm1XZjUH6t1ONjJpEpPPLPUEM+F+lL3vCwMHm?=
 =?us-ascii?Q?kx6j6UeTVgoF6Wm09OLn4TpGRPo/cjXTjGdYhINEEdqIAI+eKvrFDAS9nlom?=
 =?us-ascii?Q?ra7lPe9OaBAKxQA4HCDildOD4e3N1rCUNBTCMV001ec6M4eyISEipSKvgrWQ?=
 =?us-ascii?Q?kY02RJKtv0dgmROpWw6Qumfue+pIHaAwy2mCQDleMGvDWWeNUPRJKt5sYUol?=
 =?us-ascii?Q?wC15p4SsxRZNYtSYWcux3+nkUy2eA/u4fhBSDs3ygGIzhaVxtSBMAy6L/6P2?=
 =?us-ascii?Q?Uv6a/WJfFLdjtLJSOsmFW/VRupebbhVvUOinz68pjKy3Rlsul6oY5qqtZDtS?=
 =?us-ascii?Q?PWip61MNN5CYBkJhDbjTnjUhyUgr1kPOeJj31g6ki86WgeBgxRQI62RccT6h?=
 =?us-ascii?Q?wC8dq19emdfk/ptaQYzepYU6oGiaGOfi6mZFZ40MC4/whj+WPwLmOnsc3IOx?=
 =?us-ascii?Q?5/4cjfL7YX6Gsis5f9NSaaIPzx+pRpqjrj3QEfJvO+9N8gybtJastvz24VTT?=
 =?us-ascii?Q?QeOJNlbM9rtM1ZnNUZiAViyopBFfI/cOrb4tkcZ6GTMP6pXN6aDF39+eIsUA?=
 =?us-ascii?Q?TkD5NV2WNanoJouLFBnn8ZVwj5FdQd3Mu0GrEzupPcXWL4U5Am9CamqOvfWz?=
 =?us-ascii?Q?umfNHc+fpEWBQfe1iiZs4NRjvpva5YXy+EFxcQAy3z9oFVNn+mstg6tQH9hf?=
 =?us-ascii?Q?F0IBFsHcUGO1g3RmLmjcWdxldtCCTMeZjRRnJHnngc3afhVr5r1RfhaHStfX?=
 =?us-ascii?Q?Qlxcc7i2WlbA+EKMXSqSHRxkOzBJGJlSTq7aDC0z+hQvlJ0jniGT59u6865N?=
 =?us-ascii?Q?asKMrygQINmvwht6bbVmWE35wUaz+14buyTZY7iahItDavJKodCQDwn27q/s?=
 =?us-ascii?Q?1hBx9d61mPeWxz/myx4qCd4tYt9dtW4NlU4o9cIqJX1S0Zx0JglZsWs1jloB?=
 =?us-ascii?Q?yR8gSOx+98fZxlFPCaZp3zk361kb3DRz/E/PJmZMu4rr4il8NcvDf0d8GdjC?=
 =?us-ascii?Q?GXTNYauPqDLQEBag/R3HBq+WjUxrBivFSveYa4SJU0K07kt2fWnQsoirPOlB?=
 =?us-ascii?Q?AKwd8U7FCL+d4PW91/PKudgPpngBbXBA/F4aUHw/Ts4QyFtx2iPMWanYNNiE?=
 =?us-ascii?Q?XjtMv1S6koTMJ0HgUbj8E042Ihm5E7q0e8QSWW/5xpy9twhJYZ4MoshA+w03?=
 =?us-ascii?Q?/y/dJxPKG5JiafbFRESyc+EExhOYm0wGH0AaT/sYOTg2/2NnoJvF5IlzpNcN?=
 =?us-ascii?Q?GQF3QDfHHB8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fhb9JFYMfXX963uoKMuxJ8dS5I3bLSB/AjH4Jf/N2RuzJFpnsXAbfKu1DJ2E?=
 =?us-ascii?Q?JmEXAZYveW/EXNiEEp7J0vVLeqjURP910D6NAtOCqjJS9++hxU5Vid+a0qn5?=
 =?us-ascii?Q?qsd8F6jSniEzA0msxAZBv8yuF3eLkQwAYjRP0fePkvto0Y52YCUv9Ul+Mv25?=
 =?us-ascii?Q?aPpSyp1W3D8YhSO0yqXYY8d15uXvsHYoq09qpUKYgonwOPdcis+0dGcfLQjt?=
 =?us-ascii?Q?JHHU1CovW+OHFgcy+8mfD4hBxW2lTDrUDDVzbWoqZwfMJ1Jo4ySZMlL3AzsD?=
 =?us-ascii?Q?GqwIhxqtAa6EJiDvJ4xIMdO2T7LGmU6b/sF7MZGIT339Qs8j14eVdT58EIYO?=
 =?us-ascii?Q?4Hqa/r0qZOyjuZNbpm7JfVc2XudECoXu00ei3zRuzbiveUg8YTppf4phqtdN?=
 =?us-ascii?Q?aEKjYW86mU4vjU4FoWmA0oPGwDo9dlt6A9Mh1bRhPcOUeVZ1cgizgIIwd/Vl?=
 =?us-ascii?Q?Jk6Bq/Yn3DWp9wMml227BauMjRqJQuZ0SkJdsIGxi5JuRLPb9dObFH+XuktI?=
 =?us-ascii?Q?FfX1QneIEQNdQXYaLd5SZRh7DBwRjHk9RK3xdSymKpmSyV1eMW0VFHu0HoUj?=
 =?us-ascii?Q?7i+aJaj/G8F52s1oqwkJ/ILndIp+f+/K9vSNMgoxeTYwbMPFT2nKkFNhwnIU?=
 =?us-ascii?Q?Xz5LAKoZtv3DMsItoPs/urmjZb2KtNuf3kR33mFn5+C1YH7W6qKjHwLufglR?=
 =?us-ascii?Q?EgrUCpz3aCNSK88scofb15rVMJiQ3wVa+EVQzEHgV/jqSUabWFpaQ25jxOGh?=
 =?us-ascii?Q?DYFQhhX9khnykI/eNlG9OfwIdusOEtJUpZsZSQz7tufXk9FmvuXtl3ptsYo7?=
 =?us-ascii?Q?gLvcT2022/wwUR65HNOgUp2m/djAldvl7s/4tVIeHJyPkYH+drjMjFiFDpdE?=
 =?us-ascii?Q?a08oyasq4k5x7M/nDPIEbjmH0wuvPL/bGGukbIVilIX523S0MTAOP2LtG3qx?=
 =?us-ascii?Q?JUITTQupQtOHUP1WVCd8ptTr8rBcyMhB4K5ebCgEzQuoqOd7/tFFjd2jBzyN?=
 =?us-ascii?Q?sPz5hXpTQFaGYNtrgY46kNYHGmGwjJVj7XqJxPPOtxS0v0mSG4NjyRL39EsL?=
 =?us-ascii?Q?xRk3TzifwmiHG03VOJwZ4O0xiAoaGaRb4Iocib0mbe+e2sePc6SXtQxPWjTY?=
 =?us-ascii?Q?+brPHL5Xzm4A5FIDj+xZaOQkOeZl/nx1J53PqICDUm+pV/S+5NdTi1m8IPq7?=
 =?us-ascii?Q?BCS8ZKXRJxQmffpXruwp342aQvGw0zttxsI1qJD+E9grqznTO4WCAwKCR12W?=
 =?us-ascii?Q?hWTDuX4nn7FVdnvSHWh6wSkywPiqp4tE45BCCx5rL+QwNuJJgb6hcuJWFX0M?=
 =?us-ascii?Q?0bm3KqWSFoxzWzzBYE/mXxpNmk3DAt6ggzQYvoFurwlC61GXG6gCm2Mn4cEn?=
 =?us-ascii?Q?YSgklf09rN8zmIngh6u0fa/ek5tvj2BRLsk0HRDis/M2pR3Mn88G7MhdQVky?=
 =?us-ascii?Q?k34KmwiEWocthdrFzn1rPZ9Urqqh4C5npaPNjzQVYVbrN8CiDGB3dvuuw/ab?=
 =?us-ascii?Q?addT6sCHXU91PeqMRAbpTC4OgNM/e2xUjZqJK3w/YBTZXrNBs2aY49J/9nFC?=
 =?us-ascii?Q?9f1muCKofyiuKmcQCyQkjQQ6WuAqsci7Zj3VNZ+wVP9B+FcCOxFgghMVXeoy?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 360e7b0f-d54c-44e6-3a37-08dd4c9e41bb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 02:21:14.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5isXhH1Hd3w6tfG2xAJTb3K3EAmXqW7uFXsD08H4bAV6KQqlEHNhcdvB/6dMHQPd9XAWsc5dxlvl9njehw/zY2cjx/9UTSGRZiHFEfgXY4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL drivers use kernel trace functions for logging Endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
> the CXL Port Protocol Error handlers to invoke these new trace functions.
> 
> Examples of the output from these changes is below.
> 
> Correctable error:
> cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'
> 
> Uncorrectable error:
> cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'

Oh, so this solves the problem I was worried about earlier where it
looked like protocol errors only got notified if the event was a memdev.
I still think it would be worthwhile to make this one unified
trace-event rather than multiple.

