Return-Path: <linux-pci+bounces-21308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D932EA33023
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 20:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3BC161EE4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845311FF7BE;
	Wed, 12 Feb 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+kgBsJB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F91FCF62;
	Wed, 12 Feb 2025 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389923; cv=fail; b=BU/q3dICAzoc/pb6AuG3qe4981yqSozpiMXCQb7myR2pR30fDWP3G5eMFdR0SFHTVopPoMnequz7LvNUYePOhgWe+J4t7jSpjIAH1dUrYUXOMQi1KsaDkLplx5hvE77GX8xyLgmOsJExd/q3VaetstQySoWwVQoVExfuMiDvMbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389923; c=relaxed/simple;
	bh=Nt+llfCEYr8jir4sLkTwr1tQ92ZkX+GImGtOXn/r0KY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NJG9IoWTzgDVNHIBYLGETOQLnswOGILDdSJqfZw4L8z3/hEqJdoO/+tn3YPR3V5Ib4Lx2sZ80J4zkEochCCKpmySYg5tVKet7A0W6y7ecrQhIyL0zrykGq8+V+o3ELs4RbLbdIBOekSe/n9QVz0SHwO63EMy7dcXyGKi90sYah8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+kgBsJB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739389921; x=1770925921;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Nt+llfCEYr8jir4sLkTwr1tQ92ZkX+GImGtOXn/r0KY=;
  b=I+kgBsJBvDrW691E9rrKOAngoIeN93QeyIs14C87V61QW4JJYw0XVNHJ
   aNhJsJpCdh9ZqKkd+DxR5fw8F7JT8TLcjA1OKyqiRMu3jlM5Be/BPB+50
   6EJjTurI4TQtWgniNaDKcZ3bBCd9P5GznRDQnARGbG0p8daXAcbjoMGpX
   uiPcU3+hgGyrreDQLaPhEH5H/8nFrbpbqJqwL+Ywie04eF/heu9kOkqzf
   UjebeGbWNCTXyHwLRBLshrSHKjqbGrS5vyuqwsaLuK8lBhlxlIBxg1Rms
   9lpaPdIg8OkYzTGUGYK/gTPEYSx/rPUCMBOYtgTdo9qSI8I3ag37/IsgC
   g==;
X-CSE-ConnectionGUID: 7oasG3kYRGmDUBPeKcVFBw==
X-CSE-MsgGUID: lYNu56dcRGGi1kJc675KQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50716923"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50716923"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:52:00 -0800
X-CSE-ConnectionGUID: yth8j7KtRaaoqDuX14O9Dg==
X-CSE-MsgGUID: VymWtpYBQ8+ZBDVD+3X1dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="112887906"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 11:51:59 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 11:51:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 11:51:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 11:51:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epjxeLgGQkhRBl5IRf+SEB0RpBVpEfy6YcLl8aK7HHgneF58KruJZItZE6ozAMtla4ZP5qUvVvwp8Q8MsAI5GTYh4iGtsR0NYg0zbLjN/hW7uGBTuGtzA6Us3KMmivzu8uZ1jYiS7BKkeJJgoo8TR9tnoJJLVOarKFKOv0FdQTJd5G2CYJjDtu92DGaHAuvjPqbFcW/qiojFbiN4kL82QapXpu/tlqkkmfg/hvi1Hgp0j+fQYGJZjW3k+S02jwo1EIFgQ/5FBvr2fQEgieIed9xg4HhuT30dgul6EDdhoOOsL16Kp98UcE/ZGMTfyUjn9/ivhmW1rrG5BOfAEYqkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAwAkU1l8Qyw0BkFM61aY0VOJv62N4xgBLQJCK5ELzo=;
 b=ICGTOsgiIH20Xo/T5KGuRCIhthvDoFtwnA7gQdnZkOADTNCPYWzBoYe1kTbwciM76zmJGEcpXVqMsmpfeNqA9JW402AKeDF5RAR7e0Jw4Z2/sZrK8KEjw4WvwsWEQ/Uu7MbqrXPIc4e5hZ0SsGJqou3R2xF5QXUz9a5pbIbL/RvHW+AwgBMU30GSQk987RfdipzUXjBwp9CL80dS0A0FXyNllFy+CGfX4VU/IHZz5ISoRqAxEqfot9LCtlLKhTHO4vTRARNZLV0kSyrkuochNbAJ8eeCoCORW5V6iOkxZOx6E3R1HkSH+EsnVyTWzLiV2ekWVDm4abn9PLArUuEatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7826.namprd11.prod.outlook.com (2603:10b6:930:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 19:51:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 19:51:39 +0000
Date: Wed, 12 Feb 2025 11:51:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 03/17] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
Message-ID: <67acfbc83ba44_2d1e294c5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-4-terry.bowman@amd.com>
 <67abd04519e67_2d1e294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <7600b0ac-673c-4e1e-a9ee-d56efe386f99@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7600b0ac-673c-4e1e-a9ee-d56efe386f99@amd.com>
X-ClientProxiedBy: MW4PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:303:b9::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6d3725-8514-42a7-8506-08dd4b9eaa93
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2K1cTDZTHxbZjjVhoMsW5trOQPCYe86LwoWURWdnHJkbiiGtHJlzWyU7seVm?=
 =?us-ascii?Q?+Oo/+0vaSz6DmkGAjOavMIE7r9SI6rt412eIGWZSfq50+u+SzN8hFZA+KBak?=
 =?us-ascii?Q?Va/HG7DoTNtTfrjIkNFLl8hFMdyDjIikJquTAllJx0FStLdTXsgTmNM+F50V?=
 =?us-ascii?Q?fAP4751OWtDTB/gKPRmIHj7lOYz62Fkd/pC/03LKA61TdQwN8heysPKPFSOZ?=
 =?us-ascii?Q?U0FY/3K8mRdKC54KLgliKWexNP0Y1j4CBfDT4YF8yT9CBx8zpZ7RUwPsdOvJ?=
 =?us-ascii?Q?7DBG3z/mMcvR6uEBxdYjEUg6E8zpPU6QTvbPoTnK6IIvEDQ43H9H6yt+g25f?=
 =?us-ascii?Q?JIhsjJrb+rYuzigoYmA5pYVmueCtBF/ZrvGh30tDRqUXR1gENRX4W96amEhz?=
 =?us-ascii?Q?63p8mN56y8Iyll1rB7Jc75x7FwCcWBnDgQGD20p/fT7BrshtV2Zo58jUwBJv?=
 =?us-ascii?Q?i8kPZZ2O2esKML5KkzJQAiilAq3hQjfm6D0/46I5762zQ96Fo7NDFIMrZ85l?=
 =?us-ascii?Q?zuf/rXIhjbypbOrwUA9TYkerz7TpOEpig379gelT55T53Ndix9AdSQXhKh6I?=
 =?us-ascii?Q?0bq3XIxnu55YNqeTUDXHuI7LaI0/pxj0qyIVF8NTTxlxRkDAaIcPPXOFFV8f?=
 =?us-ascii?Q?AaTAiTXChwzbtBCthBEOZnp/vpPMfmgAJOmbzzDdFIBHRwlxJ/dm1RMyJtLx?=
 =?us-ascii?Q?aK1Mr1DLnyCQLgxNJFrcApYJeFue5vMJazBQIYP0JOCdTHWTE6KqBlcRlbS/?=
 =?us-ascii?Q?33b/3nZvlf2kAMS9MwfoZxTlRaia9jJtj8sQmd8+KH1GRKBoXwnwiN0RFtgm?=
 =?us-ascii?Q?AXsrI5UeNoGT0gQSoWa5vCwce/3Er7aWGN1oxzA4nANZIuPte6DoosJL8H50?=
 =?us-ascii?Q?DNxXvGGVff6w6kMgxSda8DPzVAOOz0FnqJV7pnkU8sQ87xqDWCUuhrjehJ8J?=
 =?us-ascii?Q?Uak6YyLEC2VFtx4XM1eTL1ILKks5srQmeE1flU4+6NosuFvXuQvzKWlhnaT8?=
 =?us-ascii?Q?RszKNkyIVTbfL7RrPxl/Tx8ki6Uy5SsP3tecOABYiYhWYfAtvH58lMeCUt0O?=
 =?us-ascii?Q?sn8PB3N0klcV61Vf84Bf3rZhetfATfF38LlGd+ZFdpB+eIcE/SrKGGh9roPi?=
 =?us-ascii?Q?quLz8iCApO6xo5pBM8KOCH52a4LNWF6Xo0uUbt+YJ5RKib5bfuYCU9QKq8DE?=
 =?us-ascii?Q?1nQqwMsuKVYNt35aOHWci8dSno5y/cBfZRXhrQtHaXA/63G8kBso+RquJEQ0?=
 =?us-ascii?Q?H8T5yKsnLB38S7EGsjWhYIcd7tQviRMbDkdpi7/rJnYWmzW+zSE3Rx8fln/6?=
 =?us-ascii?Q?p7WZZCXkgluxaPZwkSMeU3qKEb7ZBYzlyH/Wjr1vPc3UgV5R6hSgB1m0Gj9d?=
 =?us-ascii?Q?UoxQgLgVjnKgIIjiGf5352386lJp60sQ0O49I9tgija92xiWcdhpQW+bXlIP?=
 =?us-ascii?Q?StKwMGwpcFo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vdm2128wdk0wyo4lxeeOZLA7ViF80uvvkFI41UMyZKCZshjIlQ0n/Yo0BeXZ?=
 =?us-ascii?Q?c5Gh9LGgTA8Y1h2DIrd4YyU3IHv6DqdRWan+l90+Q7heLzhelnclp29NJ6R6?=
 =?us-ascii?Q?c/ZeI6pgJRpvz/2TjNBtMdY8KHiAD02c5Jl1hi25SuzLVN8gVtqSKe9znzLZ?=
 =?us-ascii?Q?ZL+6ySBRUWA5CWQIaOWMgereDZNul6Ww9mlooGokbPkZgC8yEMVnE2P+53uT?=
 =?us-ascii?Q?P3iPtSWoTXNgz7hoK2NQa+mtnd1Okep1ySFoCrKIr36RDdR0EdP4NzT37aaC?=
 =?us-ascii?Q?rrjbFivV8ac5Mz92DA01kkOXrjsDNnbeUORL27iQpOyLrA73/4YZlx3r0Jlo?=
 =?us-ascii?Q?x1ENSGv6xsNeotVi09V3CWm/Y7pPZtJzZE93BENAeSVZFeBpOtImNkybj7YT?=
 =?us-ascii?Q?mBGFkDKiJFIroofL8DYXj5HzMtKSd2npivoi6/hl4RlrJTTxwFFSXWBCGQk3?=
 =?us-ascii?Q?IWx8J60PrXPeXmrMlx5TOcaOuVx0Wn8Pu6dEwdeCswIu9LGlaXMnQ9HgLNQ+?=
 =?us-ascii?Q?Iu0uCOcjEZupVEl3YGm1TuIS6Y+B+vgd84gK0fqvV9vjZE2NCm8i25YtTLJT?=
 =?us-ascii?Q?iBuPil/2twsf66BumOgv9h7eoBt8gHIEPwlC90dWPHvdGqs0guWJska7+0NF?=
 =?us-ascii?Q?az5W4VB5pJ26THCRZD5LcZ0lA7ZObVxMr39d7AO3PF83WPdTD+d/fzB82Atj?=
 =?us-ascii?Q?O1E5k6g2nOn5LOBWQGM+v2hHNONvgf1M3b1hw+6e321kVhhF+tLeOx0TD7Q/?=
 =?us-ascii?Q?EBKF1CkibDg6AA4Gal7Z6fV2a+HoCkUAMATOw/LZlygAx3m6YasuXqBII7V4?=
 =?us-ascii?Q?+VtqB/fjgvSehMwHZVb1FAVpmdJ4+Fba/OjLlFoa8R8+jNCNHBs01c8vIXlG?=
 =?us-ascii?Q?frQ/26lrESEIzS6DTVWOM/Bhty5j3dh/z5qMhvKyhVTvZrUy+XWPfdKm6tWP?=
 =?us-ascii?Q?I85X5xhbcc1Cw8Cv4p/XZoroZ5h0UZo9HbD6edp9egAFI3Ebqe80q0OpgY3P?=
 =?us-ascii?Q?ftFrZRg/zfXiXeQL7aZUyQdCck7h95UZNmuulBvQis2q/GRfZ0g0vwcWG7Fo?=
 =?us-ascii?Q?xDu5UCxN7VMm3iRO+KGbB7wBr8+fAvcC0Dz64qYz2JCLcOpDvhfd+JyhSnLo?=
 =?us-ascii?Q?mlTTpFfPFMDej6hH7tRO64qM4xoYUXVgPRWTBLwvD+DukLN4fHEzsN+grsRy?=
 =?us-ascii?Q?qTANW2SDJMBnwCyCI1kKEvCHk+vuZlDPUrnD3MXbyQwoZBEsemaeSbzLlUPa?=
 =?us-ascii?Q?JFaRAU4GUNDTgACRAxP3F9jMGyUYt3aqCRq3MeVQyGL8cb8l/R36l2KHQS9d?=
 =?us-ascii?Q?+X4Wf5IbrKQSFiKF0twqL45e2WUKx48Z3zbGvaaLiwf3kHrwo+4mZdAScAGe?=
 =?us-ascii?Q?eexGK/bvoKlezRLr2IKakByORSUn5bAG3az5nx+FJFjzvsR9LvRWRJl69XeO?=
 =?us-ascii?Q?JZGhJwMwKJK81cZzHKtPm6uRtbZQHvrTjrr1Pzpcac9/SaAWGHbjfN5E4inR?=
 =?us-ascii?Q?i+qxrBpTdMvZx2t5v1kKqcIOmCfWFsa3KC5nOFpSaEIAfPUVRuJei5keqEp0?=
 =?us-ascii?Q?fgOc6LfZI7FP+WGDeyR5+hDOP4R+u7j7cKb6ol1CxyIP08oNjoNBD9jqlJUF?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6d3725-8514-42a7-8506-08dd4b9eaa93
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 19:51:39.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOwGRbSJug9FENYx3P/WUp1txT4LuBmP2CtLPwI+QQ1Kkc4nKhKiXnfhmqz9rQMsJOHKEVPe9f19O9cODbVMC94AjVZRLM7zX7IpQne1Qp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7826
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
[..]
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Ok, I will add the comment.
> 
> Would you like for me to add the enable/disable internal error logic to cxl_port_probe()? I can but want to confirm.

If it's quick, go ahead. Otherwise I think it is ok to leave it in
aer_probe() for now if only because this is not the only place in the
CXL stack that needs to be fixed up to honor the fact that DVSEC 3 and 7
are only reliable post link-up.

I.e. the other places I know of are:

- cxl_acpi: fails to probe for cachemem component registers on
  disconnected root ports

- cxl_switch_port_probe(): enumerates all dports even though not all may
  be link up yet

So, in the interest of moving this set forward, that wider fix can be
deferred to a later rework series that address all the dynamic DVSEC 3,7
issues.

