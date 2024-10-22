Return-Path: <linux-pci+bounces-15075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2459ABA24
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 01:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D08328473A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB621CBEAB;
	Tue, 22 Oct 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SF2YYKaM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A01547E9;
	Tue, 22 Oct 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729640652; cv=fail; b=KuW2nWBc/rZ6HXW4MlcZVh6YzG8Z8lHJ1Rg2LU52JKpWMTwLPVCi9Ckvjty4siKP/E6YgBSoVthjGgOthLiH91u4CMMh+fVbCCb0wPmMD0CKwFSi82SbdQMnKp/nA8lbuyLg7T/JLGT6hEmJNVH5QOTQ92mrUGvrWyved1VkwQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729640652; c=relaxed/simple;
	bh=HbSrLz25Qa78xBe4ov08HWnj3yIawNCx1BwogIhwD48=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cco40gT1u1GaBR/aXAEapVJhXCKvaY89tF6lig7X27ChmC92Rl6j4A38PFmjS86dtY9RAOHALZDfjmthir16Slt+HGy78i9izSo6q0iRRqISMFb6yAcNvSo09ghpHA1cFTMegCrGjgVH5CmjNa09r3xN3+ZyLBpSVBOBfUMX+jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SF2YYKaM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729640651; x=1761176651;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=HbSrLz25Qa78xBe4ov08HWnj3yIawNCx1BwogIhwD48=;
  b=SF2YYKaMiexRQ+TxVEaADfHhSCFyEHUrsVloCWJKB7x+IvYMo++rnwB1
   DzROFAFYGVM3k0YJcMO9nekPP4LACSw1SbmKZhQPNtBx4PTTPhAZBv8ch
   ctNICByQd5SbG1wFPvdYMmTmck0SbEyGgly4Tx1Zx2kd6XmSqbGu7kJ21
   QU9rQwg5fJx5vNMc/THw7TXpn3cyzbbwswORqd5Cnc6Qn22ISquUTDtMC
   E4XbmwS/02SGJfjuMrAwcPL6vG4r4f12rhSSohgw/4FZt/+ZLVt7RDM3U
   AkTU/06OTkVkBxGieRpvzf8nkZkjOINPOZgEtYf1qXpOJn8Ys00Z3SOgQ
   g==;
X-CSE-ConnectionGUID: TiPmZeuMQGu9q/4wYFdryw==
X-CSE-MsgGUID: 40HAKDW1Q8iR/tNbg6RcEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="32063585"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="32063585"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 16:44:10 -0700
X-CSE-ConnectionGUID: lMih+y9tT2upUDQIClKRdg==
X-CSE-MsgGUID: YKfqBaCcShK2eqB8/V8EvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="110820283"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 16:44:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 16:44:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 16:44:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 16:44:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 16:44:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2rfeY+6zGikOhCGKWQfbPlFz67QELz0zWMbMn/eZNXBcEy1Y96RqKItuJ6LHToJo7FC3zSUGY9jWZrSwzhI6JUi+mrUtt45dMk2WiV4F6efmrcW1fholjA3R/XEQ8Cn7prvyXVbBUvcs3bYRnY7YSR+Y1O7VI2k7k7ILtMLKrEO7qpbrBORh//HpS6vOPqHsUWi/slHEtoaN4Rgq1YPTqeH7ffph90KvpyvBoAHrksmqcgjubzQeWhcG09HG17TP8z3BgsnYh0q0vQpAqywEETBqAxn/VpH0efUJnL4wCqy1g0AkdI3OiGhvbuqzxf5YYASN0Jnz5Zx6++jbT2JdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1cNAhI5JoWmJVFKuGxemJW9ELNHKrY3b7kYcWu+cjY=;
 b=s2I1PbRqZHdmz0d8MYlu/3+a5TZN2rQ9ORJCLkubc0ZTx4FV/kEMhd3P8pplA9h/GzyAvxDL3vfjsV0MD98OogAFKH51Dk/UxmMZO66Q4PhQQ/GI5mine0XSRRKsYfpd78KntoFMpYHh53SNOowF62Axx3HQJkMec7CaqwhwUevJrB0ZEKAK/BruyjCCjGRrPX4ZUr+rwl3aDQQexZbqKQgsetAq0x7JYdt8isofOJ6ragMpzSSR/aQYwh1v8uvbluWgs/RhxTFwQEqVmlnOBBCe6CoplWh2MEPHuyeoGgI4TpQ+x9tVRkesWyJZ0EqF42CpCpRwCLBxElulBNPJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 23:44:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 23:43:59 +0000
Date: Tue, 22 Oct 2024 16:43:56 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <Terry.Bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 01/15] cxl/aer/pci: Add CXL PCIe port error handler
 callbacks in AER service driver
Message-ID: <671838bc84b33_4bcb294fa@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-2-terry.bowman@amd.com>
 <671705b5bb95b_231229468@dwillia2-xfh.jf.intel.com.notmuch>
 <0cceca3d-f69e-4277-bc9f-2556fd212ebb@amd.com>
 <6717dc2ec6c90_231229487@dwillia2-xfh.jf.intel.com.notmuch>
 <b3fea77e-1103-40ab-b7f2-adc545273be6@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b3fea77e-1103-40ab-b7f2-adc545273be6@amd.com>
X-ClientProxiedBy: MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: defa89bf-de4c-4b31-0282-08dcf2f366af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hM61x55/FRRyvKU0JLYyLaUqynmWtSZxiHgZN21FHKcb2ziYyG9SVWxiYq4V?=
 =?us-ascii?Q?AzB15xpn9cyTTG8pliifaG5uhIqRNC+G5FspUM3UuJSNvB5SDwSsZYJKePDa?=
 =?us-ascii?Q?Cq7/askKFnLcVGpZZnnfqbeX45N85yG3e6y03MHvFrk27CvSxMZRgl7JZsI5?=
 =?us-ascii?Q?hXEvO9EWqmRViP2fML7zb1gg171jtVuIhgcwwKvqPB+O2r1g8Zg4dshwUxsV?=
 =?us-ascii?Q?j6OuHqn7LumywGCDG+Y/1b2CAve/bf3Q+Qfo8KUPIcJq/4BZBemWg5Qg/PGB?=
 =?us-ascii?Q?mdrvkVkrLE0bbYFdgLg3JQKJUgrsieu8pAGo+ID1RDZE3jFVJRPvYRptRKfT?=
 =?us-ascii?Q?EndeJuWNo16XWSF67hIotLcZRoB3Xla5Ogugt2umXQ2Sv33fKPleDKk2jqvL?=
 =?us-ascii?Q?FO8IyV6JK47JWKicfmGvmwRHV5GDSXebJzqKyyrzQ5YJTVUDpabC3v6s6Gc2?=
 =?us-ascii?Q?IZf1VFIdbF1ImhO919h5cQDCqAgjD24fzbBQKpsjG1I6wCUDZzZmoovewnY0?=
 =?us-ascii?Q?+fOR47LrBkDbVTiZSiO4QqaPbySNxOSR4cW3DGyJueI6WgXzHhDumghjs3qb?=
 =?us-ascii?Q?hdnc3f6Bll0qQKCEpFt5JI23USSNc5AtqGIQsHo4NDnVFzPbu+KezbGOs442?=
 =?us-ascii?Q?Wm6LwYlnaroqZ/H0IJbeBUP51c3/pJ1HtkDBYc2dlXN3C3doE+URLGtV1ZPm?=
 =?us-ascii?Q?b1hmhJHe7I/fX/jmIIKawt+TimNAMozrfnIKiJ2eGmveW76x8QrW03BoIoDh?=
 =?us-ascii?Q?nncdSiHYKpXv7j44+5PNzWG8GphhrNq5SxEFMOPIMOXf4LEZHJ21SnJj65Sz?=
 =?us-ascii?Q?vzogrOdsmH4HSU6tPjJhmg9TS7VD+/mH41b/DmJF1Yww3WabHZHvnRoU+yjH?=
 =?us-ascii?Q?MYqq/C83Eeje973M5v3nNsyyPuKz8I+WPVwzw3+2z9WQnq94gAZoxmvGrh5P?=
 =?us-ascii?Q?zcV1lwICT+kBI4ratOkdp0p8F2OAicRzrA7jeKQo4Gyx1X/ZpGmLorSN4K6h?=
 =?us-ascii?Q?vIonpqFijvtnE4OWJmtBt4h7LUVQaB+ukfdBn3UppF/Xx4hraOV3j2hdmIwb?=
 =?us-ascii?Q?62WHT3nhFgFLOHWVDn/jNWEURgdXZuvx3++QyMF32amGpREn0H029E7nQVRj?=
 =?us-ascii?Q?K9SJtnByPUP3V9kTARasNUqNN5lQSYrF0gwKDwkrbXwOQrpWRR6Krzer0epL?=
 =?us-ascii?Q?VrltrqjJjnUtFeYObiqi6Mrc0DCYMNuKA4byCbKoFFwfXC7SJezqgdWDtMDP?=
 =?us-ascii?Q?pXcoQ0B4r8Y+mEXy19dtIe/7wnhXjQ1fyt8mc0TlrN9agcZarcbZxjLeFv/4?=
 =?us-ascii?Q?veGcjPgTp37JlFXKeyN/fNXiVoxq+ft2dZPu9tISqSZkv4oa3Up5M7XkEjD7?=
 =?us-ascii?Q?oBEsDQM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ra1hoeVqTaH19MEreaSmBOqGAQuoqZhrq4HwWn2xmG/Q53Gu+qA11Ehpmw4?=
 =?us-ascii?Q?F1HjoeNSVF1n0J8GGUWihyARW3lIGrRPsXTPksYKPwtPuB3G49PqYVgjao0Q?=
 =?us-ascii?Q?B40ZfedfXOBJ5VHRu6i4EAc3H9drBjzQI9Adl4GHifIdtoi1Py/1V8l1Fbm+?=
 =?us-ascii?Q?S/ECdg6y1nfVhhFRhu1fb6hLwwmePmqp0Lcnm6NtpqFmT36TnvFK26gFCwOz?=
 =?us-ascii?Q?7s13nq6mm3s+aaaOqhyL9Y5i4N7h0TAuKqZHjhkuKq5Pswpd+Ea9XYISeAs5?=
 =?us-ascii?Q?7dcNxNPSb4OkbOQGQeVbYtYIJAgbDJuv0vsDqTHR4JI1cfBdw74CJDDDPtjo?=
 =?us-ascii?Q?peY4Qy3Gl/G4oz4c55eluKX0oMrb4SFnnOKf/OLaf0zsR5JxFjM1Prs8Lv4r?=
 =?us-ascii?Q?nIlUpmgnSdTHBnIaDKONY9PLaghWr9E0UXRJQzMjvbTG4Ccc6ZQEReSeQ4Hz?=
 =?us-ascii?Q?MOIS9jbnQ/n1bh5TR1yrnpLnC7z0NJ1wJFBF9aeXl2RVqdS652r/A84hH5Hd?=
 =?us-ascii?Q?eQcKZB7Q6UgMvLs9TWy1Mv5nRxlChIwdHQvBVr5dA8vZKu3lyt93j8TR0jnK?=
 =?us-ascii?Q?qLs8OPkwcNfn9lgLvXiXc684PgM4wgJylAtw0GnEepwHgkmx0v2aD/xPUJFa?=
 =?us-ascii?Q?L8KXfAlD9ZcfBYhtkaWfiHIjv8OX2uIVqx4iWaiC4jBXd7Im6jbI8yof81L9?=
 =?us-ascii?Q?E0YCqPyMZeV/GVRYAVX69SAQTXjgTRCojOg9jitVKoOOdc6eb2wJDn5EYXcy?=
 =?us-ascii?Q?Q6o2SbSJoijFFOFq0/cfeRpf9oVD74k8SBBteX61xN3ghR6xg69NnjHGjL+f?=
 =?us-ascii?Q?rIhtd0eJd0l1b3IG5D/WRcICOza7/HZ4r3tYCbZi7Udddg1z5bjwMl++KyBR?=
 =?us-ascii?Q?lVeRx8N2Af6zxS2pkqKTyG3x+BautmQvzElPTSjKGigaC4tQI2WKijYRXXV1?=
 =?us-ascii?Q?8Ckx6TJgQbYiys1L0kgxD/VeOEwh/lbXqFEZlA/F6ZAZDFqHQs0LEfUCV8IF?=
 =?us-ascii?Q?/cIiaA0gglueNg6ROu9m49oXjaKS2hYq62MQWK4uNGKbMdCLA4Xb2Bi/I8BH?=
 =?us-ascii?Q?LTLutKLuYM6N1i9pWjy4lYlpay1LLjMRKh8XfHY9ii8gcNuMDpPJP4pF6MtF?=
 =?us-ascii?Q?SBN0InUdV63WQcYtsKMry/Mzga+4Hpv7oLYJAYZBGPDYIWE+UeW/qPXup3Qf?=
 =?us-ascii?Q?wHu/6t39bla6rFcyORmVI0/bBxLNCNsC2eqFdQKjdi5ZGnR14AcQNGlsjR9H?=
 =?us-ascii?Q?miIP3hN9fiE4RyLe0xna3+r18w4ynKNBrNF++jsWovLPi+QeV8H/p3NKvOqa?=
 =?us-ascii?Q?mdt3hbUuGYrDQRjAuIUaNvlpVVxt7tUmG9zGjUTmEWfMDTXMVGHc5biEXaGr?=
 =?us-ascii?Q?C4LhGK4/nTEr8gZ545I3pGfH6/rvYuUK4WcXSVtKTmXuoMfUHU20DsWJ7v20?=
 =?us-ascii?Q?6z//6COOlfMBgdryv8a1K7AHVAA8y6unjW0jqnzz7/tWTyTSp1QLIJ46tj8h?=
 =?us-ascii?Q?KN5BkL1a80/u1Qz3sAu/GAJl4Yy6vpUC0N+Ight/2Z02pKBOoCyGReFRKEAQ?=
 =?us-ascii?Q?3yV+QRc0FCmT1LRUIeXqZ/WPXoY8+WrCx+6NQ7AxLdsBqgvY1vXruMUo0GNh?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: defa89bf-de4c-4b31-0282-08dcf2f366af
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 23:43:59.4882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0HbVSB/Pfn5R2aYFeeEbLPMdwgGcfGtkvpcBH8MCNEEkBBjF8EMm1XjqeDt0y89MTuL9QZvmzDWvds5ZtHVlxwl3JFsnDMR6F1M1974UgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com

Terry Bowman wrote:
[..]
> I was referring to reusing separate instance of 'struct pci_error_handlers' for CXL
> UCE-CE errors.
>
> One example where it can be reused in infrastructure is in err.c's
> report_error_detected(). If both PCIe and CXL errors use 'struct pci_error_handlers'
> then the updated report_error_detected() becomes a bit simpler with less helper
> function logic.

report_error_detected() is concerned with link and i/o state
(pci_dev_is_disconnected() and pci_dev_set_io_state()). For device
disconnects, CXL recovery potentially needs to span multiple devices.
For i/o state, CXL.io could be fully operational while CXL.cache and
CXL.mem are in fatal state.

CXL considerations do not feel welcome in that function.

Ideally a PCIe developer never needs to see or understand the CXL error
model because it is off in its own path. In other words, if someone
maintaining pcie_do_recovery=>report_error_detected() for the PCIe case
needs to go find a CXL expert each time they want to touch that path,
that feels like a regression in PCIe error handling maintainability.

> But, it's not a reason by itself to choose to reuse 'struct
> pci_error_handlers' for CXL errors.
>
> Looking closer at aer,c shows there is no advantage in this file for using 'struct
> pci_error_handlers' for CXL errors.
>
> If I understand correctly you want a new type introduced, 'struct cxl_error_handlers'.

Yes, mainly because the bus state and the result of the recovery tend to
be a different operational model. If a CXL error fits the PCIe model
then it can be sent via pcie_do_recovery(), but I expect that only
applies to a handful of correctable errors like CRC_Threshold,
Retry_Threshold, or Physical_Layer_Error. Almost everything else *seems*
like it has a CXL specific response that would confuse
pcie_do_recovery(). 

So, in general new operational models == new data structures and types.

> And will contain 2 function pointers for CE and UCE handling.
    
Unless and until we define a CXL Reset flow, then yes, I assume you
mean ->error_detected() and ->cor_error_detected()?
    
I do think there will be some limited fatal cases with CXL accelerators
that could be recoverable if the accelerator knows that the memory error
can be recovered by resetting the device without surprise data-loss.
That work can wait until those failure cases become clearer.

I imagine something like CXL error isolation for a host-bridge dedicated
to a single accelerator might be recoverable, but anything with
general-purpose memory is likely better off with a kernel-panic (see the
CXL error isolation discussion:
http://lore.kernel.org/e7d4a31a-bd5e-41d9-9b51-fbbd5e8fc9b2@amd.com).

