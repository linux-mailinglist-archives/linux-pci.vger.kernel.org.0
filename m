Return-Path: <linux-pci+bounces-21408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CABCA354B7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D532516D7B7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7777F11;
	Fri, 14 Feb 2025 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwMFxYFI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5443AB7;
	Fri, 14 Feb 2025 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500197; cv=fail; b=O9JzG4RDyKy+pOAQVtAhUnywEKx2LRRNuFCHmGeJQtu5mnkjhUIqsgoBj7OfThMThSwCWisvBHi5Hv1RMKwqLObIeUumqB0BsrGIzP+YMpt4rTDp1zO0XyAarZ8y4aN3Y32LLH0Kv6DK1b/vZxS/TJcwxLrMdWfIydhGrYzhr68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500197; c=relaxed/simple;
	bh=aqvK8Cp7HS2SgRQpRnfCyxtC9AxkO4QLWXNgtbA/yEg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AvzqzzPiP7CeIiw2fgro0OxFWxLO2cFRoNHLgVu1mjNsOfycw6WNNZr8sbvTgCfzkNYlJ8KuVFJQI3vfM2nrJ/3NvbwIqgvlsdYe+NSUhVq4Aq509tENdKaDjPgIVqlRaBx0CKBt5n15C02iazJQ34INea11qRqaCacyTxv/NrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwMFxYFI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739500195; x=1771036195;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=aqvK8Cp7HS2SgRQpRnfCyxtC9AxkO4QLWXNgtbA/yEg=;
  b=FwMFxYFIcUfwcyxxE9nh7bieAEHWh7LGsb4TxMZu7WQ24CyjeagmZiDW
   M3AcrnQWMwFJvOfaziPln14VTtA2DXY1XHmU0XXD8NCpglLzxlxyPae7k
   d+ULgvChJAOJa3bNadFqxu23xnm/8/tT6RFcxnOYdaYvhZJwJQNUq8MGM
   W7lVh1RbFOV9Ukd5B+O4hRHZBqgODn5uIgXLZKaYVJWPSxBd+lK+Itpuh
   3dfON06BhUSsgMM3gsWRVzoACm9DjVxHtg91THPfEJzGSSBD0CY4/bcdW
   S7J41HD3yLQ6WFaH26J9WhmublaoeK6fUJ76un0poaBMEO+00UKYa8sda
   g==;
X-CSE-ConnectionGUID: KywwJNAERri/fdSOjLeG+w==
X-CSE-MsgGUID: aOWKs4OOTb+9Hwb0kB1jmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39941142"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="39941142"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:29:54 -0800
X-CSE-ConnectionGUID: DGJrUDWASXetnuCpOxscTA==
X-CSE-MsgGUID: hp+Mo3n8TdmJ8n8TTmWLKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150503174"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 18:29:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 18:29:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 18:29:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 18:29:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcDr/pfr9JIeUz0ZLcLJk5tmtMFbjPOCUBQkfovnAp2YM/ThNSc5BiruKV8pKvu6KYEJCXOKB6Q0cTBlUInPogKVuJk6vWSj2UZ76CfWsFBJKNanBZ9M88gsDhlDvTd28ezr9uKQv8vYWiVH/5W5/NEsaxWHRFX1uqe/BOdPBq5p9npnlDP9SKNv4pkppK3stkI8xCR0Pn4b6D/aTEg3k4CPna5G5hfTUpGzU1hPOpiK+B1SBFa7F00AgHKNBrTx25pkVLO1Qf6oHaEKJ3hFUtg/JuOebOW7dHR1ETn4gF+ZrqGjjPDuuDiPtCYv8Z7jMDm3ZBjvU8oiYMi4KkC9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UawjgormUeQVSnDtUgf07C6MdXaEjU5AhRSYKfcoZw=;
 b=SyrF+PL5ZTLmkNYq5NuZiYpfGF7XD+ar6t2Q30a1v05QGCWOu1F4hdsEMS4mEwWm9DjreW84q118K9TP/RjFyh/TSgYHCe1vMAYz/Mw81fxQ8Q1Vgf/zXascZy0lc5XdwrHXHzw90C6H/uLs3L+o0Fh+wqrQ5+N0sHwyLUg2VEFtjsbYVnQRRz41PT/rXOOGqDWOo27DFISZ1MfcxYhcJc+YnqALed65IZb9EOUDJJ5ri6VHNch4sM2/8rYpV9Lo3fCi6hx0e2tQQ6o2VPJ2W515PngK1CJWDvg+vHd6yqeCfkZyyVVSBVDweh7WmFte+qV81PmgrMrofPCUsn2Aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8006.namprd11.prod.outlook.com (2603:10b6:a03:52d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 02:29:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 02:29:37 +0000
Date: Thu, 13 Feb 2025 18:29:34 -0800
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
Subject: Re: [PATCH v7 15/17] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
Message-ID: <67aeaa8e4fce3_2d1e294b8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-16-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-16-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:303:86::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: bd14402d-4fc1-4aee-f3d1-08dd4c9f6d44
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VrFCnGh7xNNHPH63xHVGrG6khnGtS2Snmu7L5D1Mwpfp/+MfDIYIzIsKJX9O?=
 =?us-ascii?Q?qi2vPj1Irsqtni/5F3ndTVfaNVHVxrQO7/dzVt97BE5eWu2yaooYWl2PsY2e?=
 =?us-ascii?Q?3FEdx/3/r4Manf1yvaLpj9P1lAnzYmRNH/sGeT++L7kJMaWfj0I5jwlDkIrd?=
 =?us-ascii?Q?osquw0UUDyYQ4ozF7ghEGgZcDlWMx7LrUwnFBN6y5xICbKt3ZcdY7aavWaKH?=
 =?us-ascii?Q?OOoj0mIWhbZCDq6I4RrfpnTTh0eXG0CuWcvNF07Td5ye3DjEVuzryrhd9YXs?=
 =?us-ascii?Q?+6i2/whORMRnkO/jLLF+tde1gKOdLqGefrNJ3GV6HAKIRKwxivh6DTEE1WPc?=
 =?us-ascii?Q?2FkiyVvepSsUuYlUv+j/+o5XwbVCQQSzGOytQ1/dsO6fWXEMcPkNefhZMEtv?=
 =?us-ascii?Q?fdeVzi9zCFY/m2zNbgwFKLnCuKOzZZ8C3WusyGk19fVLO7nTHjWakVqLdPEQ?=
 =?us-ascii?Q?vxpOiVHpaK2pnbV4wdatqLQ3ttKZOvOoe6COwAgRD8C3rFL7d3Rg4QfUi7uH?=
 =?us-ascii?Q?UV4++opD4hCQPFbzEQLyfSRKejE/h4EZLo8+31S4Z0j2B6PBZ13WlnWxve4J?=
 =?us-ascii?Q?83kWxsxgmm6XFnqP3YuGBNik9LPE5iUg8Er89nr4GV3f7NnlBRJv69s9SVjI?=
 =?us-ascii?Q?P/qTdN2OcQrwxtJVoVy4rF7z73yLYnPin7ODJlIPbojtnkOYh3J8HJxnKLcb?=
 =?us-ascii?Q?ADEFYQGDN2OHL1kRU/hy1fzQ93ugrAdZVuqZoKpE4ZP00Oj+ohAJPYPFd7Xy?=
 =?us-ascii?Q?0H6e8LzCejVZbEWEShn4BlOxkwgfOvMSDIw0sBqOxi26yK9XBmuXSkx+2zb0?=
 =?us-ascii?Q?btG6gISe9HJVzllBlSHfmEjJVhnF/pD2n4WEmvXCN9wZ54ZJwUa2QJ7Nmbnr?=
 =?us-ascii?Q?+uadYXgkad4wOwRUHJSrQ8uF84xLdMnxJwpiEOBpE48a5748zUdZeZx2HOSE?=
 =?us-ascii?Q?mj5fKfXH34bydqHKAo1RCpv3oJ6RPSuB5bKE+krn2k/a0NkY18nYidlVAXiz?=
 =?us-ascii?Q?3DpGIvUzZzuhpSCyJGUZSI7FzzUHREW1R8b+XgbExKDdy98o87nDms2S5Ykr?=
 =?us-ascii?Q?wF4wFEZmkjLHJqEazCRUM+/PXn9GzKs9KR0c9vkIM0UcR37KDd43Mh7Blam6?=
 =?us-ascii?Q?qoePc5B9WhKv/fjCuhDtwWhJDDp8uCtJGXv0++RWGlK9ym6t5vCq6yePA0Ss?=
 =?us-ascii?Q?C5XIV6wzpqwGUwKS2qx7Xgj3Tl+IlMfxn3cWJD1yFJ5g+UyobI+3MYWLdhWw?=
 =?us-ascii?Q?RI8RbltwXYxlJvN7lTEBu5LS2ArObuTVmAnq/H1C4bkaPA0a55CdLugIMJId?=
 =?us-ascii?Q?3oOEsmkbr3fBq6QQF8mJZzZXFvbQQPjUfoDZ4HI+O3X/YrxWin5wGf0TzuyK?=
 =?us-ascii?Q?wxHumUHGmVQ4FnblsIz8eEaz+SWSNDiYT/82KHUxJMgdUac+Scv0LQkaTcmk?=
 =?us-ascii?Q?w9OF4OTnufE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H/EZi7GDAIC4aakzDo3B6Bt4mllaA8WStHRLQTrpW0u81kl3iEdQ7haUHH8X?=
 =?us-ascii?Q?Ko/9g19Vhx+RG1bRPzKeOtRBK7b6e0deWtjfbecXIwVQZMKYImeknXvabXuJ?=
 =?us-ascii?Q?wX/4N4LgWlzzaZNQFJg0ncTivNL5z51GF/Ol3xp/rsi4Eenzdpgh37ktjmlg?=
 =?us-ascii?Q?VfDShBpfk2N/SXt2zVd4cnhxZszPTfhSdwMcCjlDQKSe121LpmOmsAqEZ+aF?=
 =?us-ascii?Q?5u8Wqvij9WRS3Rhdvcu669JZi3U8l1u4mRhJPUt2zayZkLbWdALMAZGO9EaC?=
 =?us-ascii?Q?EkIjAPslE9+nv36abk5qN9QRIriZC5zgwLgP7Ig5qaKsNEIB2nitExQFjChx?=
 =?us-ascii?Q?upQ+61fyZ8llczy7Za2k47VqQLM5X6gLo77RVHl/2vr2i7gR9zoFvXvAgUyh?=
 =?us-ascii?Q?xlovFBc0lxO0IRchPSWqXNi1AUiwRNBwvO/afJVo+nwCNwei+LaQGqqCHF+h?=
 =?us-ascii?Q?eiVHUcSU3eZNNqrrnN8iepBV48Extwi3iXPsgAQLyncdU2VSbHL4pRjDa7wK?=
 =?us-ascii?Q?hSkSgE9oSlppJ/pbnQDFzCLWVN7cKlfn/42uNh7n7ggctz3j7q4EFRBe0vJO?=
 =?us-ascii?Q?FlrYPhjJF9Wc4GhQ92mgfwyTM+qyOTX8GmQKmVC81JNiFl3WFqM3/7Iakz//?=
 =?us-ascii?Q?wrXTHqAmxwB15uDGyu68zbDPSWZ2Kd8iR2eBogh1SiEvhYuQsA7CPPtyIfvM?=
 =?us-ascii?Q?9otQ1Rtz9009D6hmr6E0bwZ8ayHShm5uDPSqv3B0MpGr1KahANIKNMZ/oaXk?=
 =?us-ascii?Q?nXI70QpQl/mjPTagAh6Ngc1SIF8LU1VrKvFjHdHrcZfcE4TRLvFzROPIswdC?=
 =?us-ascii?Q?YI4zD93xBgeHoqAVHBXULOEU1mFo23tiLGXe3a9iLAErwgIBQ25JlzctpTIA?=
 =?us-ascii?Q?f3/msGw6LGl5hMk1QGxs3+VXBiHidY0JkMBj3SA3uRnePi+Ja4QOjNyogcx/?=
 =?us-ascii?Q?UEGB/TSfK2sGeBdpWbQA9WRaAeDw/dTmcx2jVVFiZbApEK6737lGramqHC7S?=
 =?us-ascii?Q?C2KWag9hFczMdch8Dvksc2HSHR78Bwqd/RFdQaVgtVl/N9WFmshMm7m5LaoT?=
 =?us-ascii?Q?32jTeNe3JHZ62vgJ7Hmt0RyvwO2IALxncMlcutgIdhjCn3YcJtzDCb0AvMCu?=
 =?us-ascii?Q?2++3/FyABZZPTQvpcJP1mzVCm/6m0TWizsrkD8lFi0tGhLA+TDTE3xcwHEKu?=
 =?us-ascii?Q?DZH6w4XomYNjmWewmcTZssKBEyWSLbtOrH6tV4WRgOAHyNzDQaNxhJF6/IgX?=
 =?us-ascii?Q?eS4y7/MzniuyQMM9EGz8aXPFeJNWsu3PMcHJtUq5x31WptkV4BiUKSdOXFxl?=
 =?us-ascii?Q?yWHjETaA1LdhdaYtOCk9dVxFFb/6Kqacv08ISowSZ7vtHi8ljk6r3QpgEDaV?=
 =?us-ascii?Q?m0CHX4bTObKnEOaEEpC7mVFONIK/qHmlln0jMiNJvpdy23M8kMd3QcltW09f?=
 =?us-ascii?Q?kv/BG1GX9oiycEiYlZ+2oRr8n0pcC5S+jC461QpmUezMLiSP1XgDlcCsIe4g?=
 =?us-ascii?Q?dRFkPxUSnPIOn67sv8z6Pf9OlPxrbYmJ0Bh0zD3d3+3mceYZ2dcbWvAnAHzU?=
 =?us-ascii?Q?LoW6YY2fkhZDQmwxNVCd6cEpZXq34SMalfgA7ujcnSEzjDiLk+Jr9hrtsy5q?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd14402d-4fc1-4aee-f3d1-08dd4c9f6d44
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 02:29:37.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mOv9jXc1ld+v6RzF6nSRzyiEf/uol6v1HikM+rNU3+TeGz/USSwmDzUwkF69E3lCafz8at14vZloDLITR5nfOcBf4Z6w69xit2JrkWRTro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8006
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
> The handlers can't be set in the pci_driver static definition because the
> CXL PCIe Port devices are bound to the portdrv driver which is not CXL
> driver aware.
> 
> Add cxl_assign_port_error_handlers() in the cxl_core module. This
> function will assign the default handlers for a CXL PCIe Port device.
> 
> When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
> pci_driver::cxl_err_handlers must be set to NULL indicating they should no
> longer be used.
> 
> Create cxl_clear_port_error_handlers() and register it to be called
> when the CXL Port device (cxl_port or cxl_dport) is destroyed.

This is another complication that naturally goes away with
cxl_error_handlers are instances that get attached to 'struct
cxl_driver' instances rather tha 'struct pci_driver' instances.

> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/pci.c | 59 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f154dcf6dfda..03ae21a944e0 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -860,8 +860,39 @@ static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
>  	return __cxl_handle_ras(dev, &pdev->dev, ras_base);
>  }
>  
> +static const struct cxl_error_handlers cxl_port_error_handlers = {
> +	.error_detected	= cxl_port_error_detected,
> +	.cor_error_detected = cxl_port_cor_error_detected,
> +};
> +
> +static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
> +{
> +	struct pci_driver *pdrv;
> +
> +	if (!pdev || !pdev->driver || !get_device(&pdev->dev))
> +		return;
> +
> +	pdrv = pdev->driver;
> +	pdrv->cxl_err_handler = &cxl_port_error_handlers;

Nothing is holding the @pdev device_lock(), so @pdev->driver may go NULL
immediately after reading it.

Also, it is possible for a 'struct cxl_port' to exist even though its
uport_dev (pci_dev) is not attached to a driver. This would seem to
result in unpredictable behavior from one kernel to the next as the PCIe
portdrv situation evolves.

Lastly, I do not like the precedent of not being able to read a 'struct
pci_driver' template and be assured that it captures all possible error
handlers, or even worse, this unceremoniously overrides a PCI driver
that thinks it knows what the CXL error handlers should be.

