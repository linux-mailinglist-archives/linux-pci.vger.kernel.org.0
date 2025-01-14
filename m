Return-Path: <linux-pci+bounces-19790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63F4A1157A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039B91666EC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B911CC8B0;
	Tue, 14 Jan 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UduYiPMu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C11D63DE;
	Tue, 14 Jan 2025 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897631; cv=fail; b=YO7Hia/0VqNFptcyj02HxeYC3Da7IIV1ukByxEWYzBZP6X34SpGbo//aOtfmzHHe+hl7kMiW0gaiFPowofIVrwbK95BEWKfXaAnu+6nRFFMKbhjWLCjL3zlBP8q6kBTudsn6NqnUEHDJT+kyXAXE15JTw33iYGo/r22Ki+MXy8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897631; c=relaxed/simple;
	bh=g3YHUzOx0SUsXvMF39zOKZXkPKJxD/Z+G9ECdTmjrQg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xh2D6Vvc9TjBFZHtdzk13zwYEb5jRbGMmtv0Wmh4FVRugowEr4aPgTo1suOdA5sPmQ4BWbugLSEdeHTpljyu5rsemwMlQuEFjV5ftkcISwn3YMy1tuJpjS4MHNae8ZIdqR53sJht8yBLywryQ+qVGXG6DZY894o4E6y420/mEMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UduYiPMu; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736897629; x=1768433629;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=g3YHUzOx0SUsXvMF39zOKZXkPKJxD/Z+G9ECdTmjrQg=;
  b=UduYiPMuNJ1kxHkYNZlry5soWHXlOLKAhYuTupvbKfPwXfAN8cAba9Qn
   jbP7QXMWDS8hK0ngpuwl01KBcQDBGVGDWxfcSMuOHNGC/pCmgXhook0Rw
   V+SVlALwCUCn9hzbQmTa6Im602YzSgtgrtzr6JSDAtd1g+pPrIeu0Etm+
   n4zMor4ghwBvWqH3HNHy8F4FJjsgGIy4ouBj+QjLGH6toz+TyCAN9mB11
   3MIKq+bHxpNFEKrZ9HhVGVzRWHMaRP+ORV+o77pGQrFO3NdjhdfgbzVIF
   TxM1Lew6k4zN9YN7w+DwPGgdbPeVbudKhZF4sGnDm+NiYX2EA5DsLx2h4
   A==;
X-CSE-ConnectionGUID: 6scyPzLDSx2gF5PvqR2hFw==
X-CSE-MsgGUID: MqlGA+0fSm6NroMOseETkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47799962"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="47799962"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:33:49 -0800
X-CSE-ConnectionGUID: tyG4ucwkSkabJpitYP8zew==
X-CSE-MsgGUID: 31ANWd9aT5K7+NcgE7lQEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="105544674"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 15:33:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 15:33:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 15:33:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 15:33:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPwaMQ+rskgJNcwWctdG+/y8evdYf2XRfoLf6K73Jni+uuVyp/DyxNdQmXFycSTl687AhrmjBkrSb8CGbt7wgzKkpN5TGAPYUrAYOHqjnm0kod+XQe6pC0rtj6Jrwf0msEnCh0lJNXiJuxMQjKXunNN2aO3mw6nOSjP61/eB4kxHCw3lici+mx7uTP0C99YnzEw5Ie8+yrqILml4ZGlPgGzWa8+piIIDi9orqGATlExK58YyXKI1Wvk3HrdbKSfpJiJGt7YAQ+aVcl20gh/bQpzmwBjY52e+TakRL9GW89BROOwUxhqZs/enKOQ14Q57W3cxGw/HiXmivNzH8zTDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBQyt9rGMZ5rUU84KycTRPfsNJhe9L/Irf+9pckQT2c=;
 b=di9q6H9RbES3JUQdDUFU9YCw73oRfNABaP+guxPsYNc7xSAuAHkSxz7S3wufPf1UimeU0YhhEGn+YO2N9Vnb16Ipcc+sOtArkBvFzqtDjCsr9/TxTYs6URBctPnfgqqaAS+AZuCQt0I2WjXacffU0/rIbWUfK6jEAZc9YAp/oCJMDfJjd+qJcZ5VmpWNM0Il45ta6OgPF6t1Q7f2JtqVA43KEJQnZrIGrJmw/jiJ7QfgwgwHWDSbNx6SNPBF2E5YMuAa+jbNJ6l2xAcURjA4ZEEX7lWjyLY5lCo/+vbzM4SNbQe9co072qnQqCG01DEyXhiSO+EwmS19iBBKt9o/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7478.namprd11.prod.outlook.com (2603:10b6:510:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 23:33:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 23:33:44 +0000
Date: Tue, 14 Jan 2025 17:33:39 -0600
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
Subject: Re: [PATCH v5 03/16] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
Message-ID: <6786f4531d23_195f0e2946a@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-4-terry.bowman@amd.com>
 <6785a691b56f2_186d9b2942@iweiny-mobl.notmuch>
 <a2fc0134-5b6d-4778-aef2-4447c50eb430@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a2fc0134-5b6d-4778-aef2-4447c50eb430@amd.com>
X-ClientProxiedBy: MW2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:907::29)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: f653f916-987e-4fd5-362b-08dd34f3e2e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oHh4N8aMaTTFLZCtp0Sucn814E9LjnA6TD1JWG13rU9ZX+9PzPD5TPCDnvxA?=
 =?us-ascii?Q?uJH1VVJ7WNClopjUdjf8FkxsefBNnTNkCbFi4uUt9vzAMpNbPWpW2s0T1dGQ?=
 =?us-ascii?Q?oUOsNSbMa0ru/yBDWlQxy2L+oH82sR3dESEDqz8isXWNIik3ubyE43gxCxgQ?=
 =?us-ascii?Q?H9PLlFLCTSbSHixnHwzTb4znIL2nAFJxQ8eJ2E27zxr0cqD+ncBOcSlYHVR+?=
 =?us-ascii?Q?sbM9Wmrw7fSwFYveVV/r0uQ1I5NtCMTjo/LNzSg/yVMsy8H8qcHJC62PCfa2?=
 =?us-ascii?Q?gRV3S9tgqH+VW3RiAuQiPmJtviETSzMldM1P+HG2ZrgrPBd+MqrOnxTz5nIN?=
 =?us-ascii?Q?q6Gr9S2e1/Cu1YUNKV+v/IrPwbpfIrjK4hqMeE8dszv8l3CgDrqHM9GoLGUj?=
 =?us-ascii?Q?6oTpLe/7OPo1C/O/Zo2hJl0zH28fSsJSfr61Hks2xjdnkltepp5gazGuDeYV?=
 =?us-ascii?Q?ZAYVTETXNzYkWzZc4+0OhiB7pxymDiMS09eWngl9c3cqbdXII5X04JqDKJ+0?=
 =?us-ascii?Q?XSZDg3XNrQR/ldkoxhh2D1bqp7jDslfBOJzlgSIpv4aQWI8y+6B2imIb/fcF?=
 =?us-ascii?Q?7YVcWzu6i3YZkqPAG+Mjc8N8FWr3GGKkgEKo43cz37GUHY2cdtVXZNqd+4BN?=
 =?us-ascii?Q?OIjDv08+FE8d4iMmIikTkT/2Sfp8WZHr+2/pW6TPg7DX7P1WOAAEHTGgcQBi?=
 =?us-ascii?Q?fFPPE8FFJxNeTWZHsTUOcLeZvsHQTk/Bo9FM8yM8ABA42GpVaBzxaLqo+PGg?=
 =?us-ascii?Q?jRBJKk2vafvMT5ZLf9ku1vhqymQnmkEFKMZb6m4qAM9uvm4MQKCVUcuteNRB?=
 =?us-ascii?Q?mN0XxPdP1gGPlncQOIWJyt9JrLHMA4LJXur5EaR6ADM1FDmWhmVA3+hohhGP?=
 =?us-ascii?Q?kZoNS8PVytcMWIOCxmmSweXmdyyIcmYiud47QgD/dwSp44B0xvvgd5MJkIa0?=
 =?us-ascii?Q?4hlyAZboYVzuY8TLT/7n7FogB2dDrfC7I6lReO8SMtwFWyHHTx9E//jEZSRz?=
 =?us-ascii?Q?s77DR4ANlz1L3DbSYvYpytC9LBvwGVAJng4R1x9YoI7cGMd6QL5VQnQ7xcXD?=
 =?us-ascii?Q?qd6tm7hCpeMSJYFjWBZJYypI39Yh3sRHaN6lb3qW+6lviiElUW073/Q9y8+x?=
 =?us-ascii?Q?W4Eo/8F1eYTgpJJLz5Zv3PNgO65OLVYdN1z7Jwa/CSpnWAefxoCreebiumPh?=
 =?us-ascii?Q?hudYItyfJ2I4/MHrMcCtFp6awj3YOgmMIPl8D1u/nCfI5mzzrrWYFlo5A9Gc?=
 =?us-ascii?Q?IR2RHQYk+oShoGze6f5W6IKMBEHPpxFMrEycTDYAXoq+vlPf1Aym38qctan0?=
 =?us-ascii?Q?hjqzg803TnJB99cFUVIFdTRpbUcxvEeprevHzQ8UMXhsFkmR1/i0CowdDm3n?=
 =?us-ascii?Q?Tao4rNCrwdjZZ8Txi3pirx91yMHigiry1rzGr3ea0sek7JZ8ZNTWMiW0qZMu?=
 =?us-ascii?Q?tFPEh3sJ0KY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x8Q7ECKrpbfrHbrUJRVXN0gIpP6uOhcqWxsOGj7fII0iMnxw0bxvT9j0KGaH?=
 =?us-ascii?Q?L7Uj1cPOHl0hl9JZYs3tzL4YA6uaP58Ve/awvL3SGV4o5goquoenZ3UTVbyC?=
 =?us-ascii?Q?+OWF94gYFM6d2bh3YrGJbPZg0hEtGeB0QS1xki/Wo8UTYuFQD15TT6pmQdQz?=
 =?us-ascii?Q?QtH9y105tkstIYE5XmVqZ6nPrhJs8gxJxlUKH70n4+zNqFAYagtAYJbCVInc?=
 =?us-ascii?Q?JeXvfbOro1mDwAxiJ3RPZXZHsZmDi2vNhHXIJnSuvzGrGzoweCcYnC4xR059?=
 =?us-ascii?Q?OTIDj6LOQwizFeAbzHLPwqtQOrLs31OxaRfzb6MvWxJC5b4/wqDXdP5YdQeO?=
 =?us-ascii?Q?Hdex+k7UCzp/kFGSJ49dQamcZYGaFNqWVfgtHA3A0OOVRHtG2jv1Q2FizpGn?=
 =?us-ascii?Q?KSHL9/5M/9rF9ccECEnKuoGTGvdhbS3xd6XFT4t/JCuy7kcKM2Ym/u6vJSo7?=
 =?us-ascii?Q?OMy0SzU0Idb9GvwrsNoPeQy0VfqH0ZFWYoIP/FTDAjrzpCD48+E/bI+7fPXx?=
 =?us-ascii?Q?LsD0s9b6XajTusGi7oYqLZDH/YSTR5uHRjJLZuwqHt4hWFZH1ZRoHUZGuYEN?=
 =?us-ascii?Q?EKHOqsOHZK/85Iiz4z2TcQfxPPLdiIM2UbXUXiXIbjp+sUXhHL7/aAJQtifp?=
 =?us-ascii?Q?P8LZXqIAsUBzD8CMkXLa+a668Mij/+jhaIX+YKZQtLCWfWf7AvoyUncJGJ5C?=
 =?us-ascii?Q?ofa/X1lEbqkk8gvjx8nwVZsiHBj34ocGZ5rXcCc+yH07sI0qcIw/kTz7mUVl?=
 =?us-ascii?Q?EQI+GpQUw6PN/Semd1JXjjH9AYGkL7Yblv5LUzwOk3pJ8sJWIwf3XI0GUY4X?=
 =?us-ascii?Q?pOiD5oL6+d15uQQozjKo+QBhoq2xY3nmptWd64zz6aiywLppxgjrDSbuLfra?=
 =?us-ascii?Q?ruMI9TngyEDNkfpYQ0CEJX/zici6QEJljSb+X4ilV0n/4le7KF6IkISV1Sl9?=
 =?us-ascii?Q?jhdJioszGguh8jJ87R/H7fFc9k1VgyXaRY/KpClaCJ85mfTB/QCkvgNH5Wch?=
 =?us-ascii?Q?mz0q+UJ5DtSv30jQgx0zQIHEhi4MWiMZUiz7gXaJL2Mr8sLXd3jpL8xHGIxy?=
 =?us-ascii?Q?X25JSQw7piJCXUjo3P36OC35dh7Prm2hTphDa5ZgjTB3iaJrCj51JBgzIHH9?=
 =?us-ascii?Q?PJqJRHZY3b7OysPLmW0n7au4lH5096ckMhOwvK8TEZw5KSFd70XWF1Q9VUlm?=
 =?us-ascii?Q?/gzj98jWq/pdRyxBvunhnYZuxfhaGvvojn6RaQLH+gznAovPZHXejXtwArzd?=
 =?us-ascii?Q?8roypC1Bf7sv8EWC3HEiw87M+rKMdT5SmSPaXouWb6vp0NNG6UXLw24l3mxb?=
 =?us-ascii?Q?xtB93wfm1FPMzli5uJTT32JXEjk7EnEk8TuLaJlZXd2jeMEdSpTfLcye1nI1?=
 =?us-ascii?Q?VwEAXUR1SYGtc7Z3u3lYhnJBs3Awe9Yrqp+GeKiAKnrIiA/KmHXZhuMOq1bB?=
 =?us-ascii?Q?AOeWLYLVVXlluYtm+UIuOMchqVyb1u544FcHv7ehhuBWiVSMx6j6RQjutzld?=
 =?us-ascii?Q?y7CrF4ypN9eMbKGPkuY1yR8NM/sFwMup6pTImqY5nbU2DnfpJ/WF3MPD1r0k?=
 =?us-ascii?Q?CdRg/BS6yzUgPOM1NGO1qycTYL5zTIBJf6UmLCJq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f653f916-987e-4fd5-362b-08dd34f3e2e9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:33:44.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJWNtRhD4kWQaowgbY7emtCdx34U196vxBbw2MH+/WgZAGZYtzg+nLmf2dhIiOeDKaW9gL2Lp5ldssgLB86iQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7478
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> 
> On 1/13/2025 5:49 PM, Ira Weiny wrote:
> > Terry Bowman wrote:
> >> CXL and AER drivers need the ability to identify CXL devices and CXL port
> >> devices.
> >>
> >> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
> >> presence. The CXL Flexbus DVSEC presence is used because it is required
> >> for all the CXL PCIe devices.[1]
> >>
> >> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> >> Flexbus presence.
> >>
> >> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.
> >>
> >> Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
> >> Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
> >> CXL Extensions DVSEC for Ports is present.[1]
> >>
> >> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
> >>     Capability (DVSEC) ID Assignment, Table 8-2
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> >> ---
> >>  drivers/pci/pci.c             | 13 +++++++++++++
> >>  drivers/pci/probe.c           | 10 ++++++++++
> >>  include/linux/pci.h           |  4 ++++
> >>  include/uapi/linux/pci_regs.h |  3 ++-
> >>  4 files changed, 29 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 661f98c6c63a..9319c62e3488 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -5036,10 +5036,23 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
> >>  
> >>  static u16 cxl_port_dvsec(struct pci_dev *dev)
> >>  {
> >> +	if (!pcie_is_cxl(dev))
> >> +		return 0;
> >> +
> >>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> >>  					 PCI_DVSEC_CXL_PORT);
> >>  }
> >>  
> >> +bool pcie_is_cxl_port(struct pci_dev *dev)
> >> +{
> >> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> >> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> >> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
> >> +		return false;
> >> +
> >> +	return cxl_port_dvsec(dev);
> > Returning bool from a function which returns u16 is odd and I don't think
> > it should be coded this way.  I don't think it is wrong right now but this
> > really ought to code the pcie_is_cxl() here and leave cxl_port_dvsec()
> > alone.  Calling cxl_port_dvsec(), checking for if the dvsec exists, and
> > returning bool.
> 
> Hi Ira,
> 
> Thanks for reviewing. Is this what you are looking for here:
> 
> +bool pcie_is_cxl_port(struct pci_dev *dev)
> +{
> +	return (cxl_port_dvsec(dev) > 0);

With the type checks, yes that is more clear.

Ira

[snip]

