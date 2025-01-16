Return-Path: <linux-pci+bounces-19978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E653A13DC3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934073A17EF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB422B8C2;
	Thu, 16 Jan 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+JfIHPX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277A1DB951;
	Thu, 16 Jan 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041762; cv=fail; b=pi0bvar1OJyCik1jS0QVxROltohovYO5F62zSYh07C5dsUwckEBHIAS1ge17AFDSYh7HmJkO3WTAWxiwjAslkUIupXp/UEOVap+ny5xEcLEFqMxHUBarw6i2O5be+MvQzSy8C6Hsrg7/stxJq/cm2b5ME5IgzZm60VNjBLiTWuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041762; c=relaxed/simple;
	bh=rI1ZHs7E4FY+zEWnuDxFgOhrDoON5fF+BTfSZD3P+q0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k/KfwsbzBmz0CFPSCTVRTZQvl3AbygLHsLkoVb1SXdICc9gSQkXicI3W7AI/wAVzeK4Jp0LC3I6vaH/S5mT+JzDYV+xeIWwcoGDbslZPs8CvYys42Pfz2wPvGMNE/x4WNgKpFtpQxoG1btKRHBcFrd0SQWWLgf2I8dQMUOaTCKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+JfIHPX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737041762; x=1768577762;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rI1ZHs7E4FY+zEWnuDxFgOhrDoON5fF+BTfSZD3P+q0=;
  b=C+JfIHPXoPiRoKYC6Lv+oEGGdiDQhB35C5IP8o2QZkf+bxhJXzFgFSj1
   VhSDJK84Nr5fWXdhNqEv8OA+YrAfmaWgCqgoyKaVMiSbWYgHVGTS0GRjS
   4B0lbTTOeUfKH607MNjnQQsS3U6OXLvchcogISYk+0gzwvaXoAbcY07pF
   8P30eETkHfSO3O43vf1/H0qlSWGX2A8ecqsPltYkOMVnO/BEkE5aTQ7IO
   1nd0SyzrTbGJrDkKo5YoPs27+GXt4ObAYVwnaLYWOXFNMBFK466SKjDg/
   Zn0MmkceXWqkPLVUGawvUIEr96RUMnM9alKxpU8+n/eEBlFlxC46jLWko
   Q==;
X-CSE-ConnectionGUID: EwXqAMc7RaWTT7bF5SaC/A==
X-CSE-MsgGUID: GH5XaZr5QNK3cfmbkFV/0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="54979544"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="54979544"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:36:00 -0800
X-CSE-ConnectionGUID: WPPXERKYSUOcwMaUms4skA==
X-CSE-MsgGUID: XVHNzgcqSrCs3RUftrhSXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="106111261"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 07:35:59 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 07:35:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 07:35:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 07:35:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azJXNVQIGVA9p91TrXjcPLP3rXcRr7YdqofZzHV02cxl79FZvpdibKvLCStQ1Vj/U+iXcfX58DNGNnikeKRv+MeosweaiTU6YZTQO6E8/zogwsf4b+leyy/EEgaKbQoG/7SiGKch+YJL/UO7PdNUiKd2G+q3e9HxjaZmVUk8IhQ5wj41gExJJ4TwII4/K1x5CBoNmsdawr1PeVye6oUtMO7DAAAmIiobHuDAcVhAh0ttlFDiMJxwnNYArsoX53DKE+v+y3bRCuR8nK/x9siGSU4Pc++Jh/SnGi+1oQiva7elndnP9Sybifj9JBtBIiDIA54gX898eaGpa9FQ0ffJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NeV/n7KNxdxONSY0tBfb8RTklsUmMasxVlZgL00Yg4=;
 b=tOxwrHbJ26bm9gpcKuQlsBVLOEKvI3h1lmWyyIPC0s7n1k3UNWPFLCrohF8TWm7YJQYU8j9gaMWUgwxa+uw8lBjs0iHY/QVguqdobiD3xyB7HdVovtx+eOWJCvsI8h3F/DdSrLYQ2sE4zMFCd49epvS7LWfMn/ThrrlIb8pqM+mzE2/XY2MYu4t5JStmyzz1LJwj2GAgFVcY6GpxeNYeRanlFN+nAoiLJaOwyx7+ywFuY5/0YZYWbDjwu1PWa3sL5C4O9eXeNdNVl3xX23mN9en3DJsw8mQdEokbcj8w/Vjs6MbJZ+7Xf1DMxxXrr8RioYXhvNvuhissUrt21Kjq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5969.namprd11.prod.outlook.com (2603:10b6:8:5c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Thu, 16 Jan 2025 15:35:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 15:35:55 +0000
Date: Thu, 16 Jan 2025 09:35:48 -0600
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
Message-ID: <6789275458945_1be6092949c@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-4-terry.bowman@amd.com>
 <6785a691b56f2_186d9b2942@iweiny-mobl.notmuch>
 <a2fc0134-5b6d-4778-aef2-4447c50eb430@amd.com>
 <6786f4531d23_195f0e2946a@iweiny-mobl.notmuch>
 <94ea539f-763b-42ae-bf5c-6013edf2f188@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94ea539f-763b-42ae-bf5c-6013edf2f188@amd.com>
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a7fe11-d846-44de-dc36-08dd3643775b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?MH9kLVlmHNcIngweyZK4+ChAoY0dDNOA7omZRHohqFP3+rrBX9hzfurggM?=
 =?iso-8859-1?Q?SzLkTjAEGhaBTWmRWOjVWbHPn7+gygtmGlwT+TUUBnk3HX8GQMrZoHdYax?=
 =?iso-8859-1?Q?uVh8Eh57vHrnp3s/XSE6iqN0PgN7VyfrepHqfmd/CFctxmHa8R3xgOgl4X?=
 =?iso-8859-1?Q?w37jSGBjeejHM6Wi8kJezvuMckjUBGR5u8rtS8qB/EVMmteqcMuLXr38T7?=
 =?iso-8859-1?Q?e8akEbEjnEZGRMrTDSmGDKAWftcfnofgdC6BJQYkbhkUwzVDbKz7mbDdKH?=
 =?iso-8859-1?Q?K473Wyws9VzPfZ4qVvkYT+9V/bKOjOafEo56rO9IMkntz9jS3JxfOKXE1C?=
 =?iso-8859-1?Q?MsC2AZ5aKhZOmHtiYYiYjcn3nbQzyUizyFHV/vwuG4qI4yPyPOZz7MSE7m?=
 =?iso-8859-1?Q?ngEsqZqVhYQUyA1lQKgC3G1A5iYUQZcpszYgeOYRb+Gj98b3C1HOfnlwRD?=
 =?iso-8859-1?Q?nNY/+bd9pGB3l4Xf4+DLNP2VWzr+1Bd1YdFRROsEu5ADpniiKiTnPPsgkH?=
 =?iso-8859-1?Q?uYoYn5UyVU0NEEIfhH6Y/PGNsvGLzJH+WlO6TvdWtFnXJ2kZQnX1YicKPI?=
 =?iso-8859-1?Q?3I2Q31VnE0KFSITe6q/52/mtmva7EU1j/WgMT+OOjbaA0BKqSaXaWGijXC?=
 =?iso-8859-1?Q?983YRuOEvGn7wX0WOBUJZ9HGIJWiDxnkHX3UWIaRwiCU0ot5aZt8zGb4Bt?=
 =?iso-8859-1?Q?COnUKM9vW7Mr2Qh9xzHuEKCRB+Vd5Wq7ik7j3Y0QBjuPUWpmLMjJbvOkDb?=
 =?iso-8859-1?Q?K2pG8xxBzZEtvituFAlSueUmezRzAFUv2mSH+G4CZ/1E8uaTrVeDsIJjgW?=
 =?iso-8859-1?Q?djkwDjakG9XM4B7HU6SREgAZwkrmzf1BYrZkMh4RHy2Q/uuTWRXk+mmA66?=
 =?iso-8859-1?Q?pHZdrHV5AkGaYTAHIp+x8k39ryek3bYQ3myWh29KnzFZ5qbhCeZ2a/EWs5?=
 =?iso-8859-1?Q?PG+pZna4t8p1w8F7ihU5svEiUXb+luDyZaIhZQsbwaR8290ZeoXDkaM9/d?=
 =?iso-8859-1?Q?Xi/Xq/X3axfzYc8hxH3RHd0VHJndlB/YEjIijd36beUm3nCHzhGcxAH4ZP?=
 =?iso-8859-1?Q?BUq0OBIiJcufZGtEkL42ukFLvqiLH4hchFBLOCKuEivpGCu8/8uFLrYHxZ?=
 =?iso-8859-1?Q?ZkZ2g/JIf1qmNAXL8tfTASz5yWjlRQ36YzH+AJWZsWIdlqFd+3+HmLa2gr?=
 =?iso-8859-1?Q?u4mCw5khb0h5SM2WQA/JmkFFuXNKrjQKcJ7OSKBnBdOWtSgsYsyejEc9TU?=
 =?iso-8859-1?Q?ygjQHdoYll8h2sxtvOiyYpgHxtxVjM70qlxtw5gLaI3OQmt66a0qTiM7gU?=
 =?iso-8859-1?Q?hhkdUolkTrG2UTY3mnndV0WOOtnY1gQ7CJmpMLFWkm9NfVyBKcfkH4dhga?=
 =?iso-8859-1?Q?BG/QMmhAQZKAx+N6SaNzH69F9D89aa3G9lyKTGV+DvjlO3Hs+E3r9ybpaZ?=
 =?iso-8859-1?Q?ChTtzgKCxo1hzNG+BPMkPAyrSv05iGWpDVDJZCusYDP5vEQGX95gJS75HO?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?k5aQuE2t4mpZt1st9Qit7BMx4zhWKtgDEFViwBCm0ZQcjwPFSaISZfWMjy?=
 =?iso-8859-1?Q?04IjJnZBJZbilIFEzkAoRNFxdqPIU6ezjQRKXbU68zq/GFQEg64TPzfq6i?=
 =?iso-8859-1?Q?tOt7VwYxSGezMw4IjtPq8WTqYiXza40OgbJ5Zqt4GH2mNz5Fa+syOEtO50?=
 =?iso-8859-1?Q?RFW0b57CeSp7Ow2DPcTqDWQ1lPe5oA9qXo5ZdOmhw76wI/uy6o8zS3d5eH?=
 =?iso-8859-1?Q?ivFRBMUgHKTIZzS+GzRLfkpgxgXIauClpHR0yQPukHVcIMuf6yViWZKERk?=
 =?iso-8859-1?Q?iEbFFAoymL3R7uaMKULGi9pKBb/0EFboeOJOQEnFtp79WjUbjijUOxAz3k?=
 =?iso-8859-1?Q?plsB2JtpwpkJ+qyNtxoz0Pwqhxn6q56cUYNgl+Q43Xy5ret4mFHSAsOaZ2?=
 =?iso-8859-1?Q?cSO1p1CWQiXsua+isUA9263z45A1queUMbHYsujqj/AxYXQ+8eNVRNvFBF?=
 =?iso-8859-1?Q?tkd3qnjLAV0tvM9kNS6oCOzQxL/i38AnDU7ehB9KHFG8Tv3ie/7oa0YNNe?=
 =?iso-8859-1?Q?75hCmEbri2cM2ixKNF3T50kh9XL+QkoEygNjf+ffIhPIcPLbgi0pUaPwYn?=
 =?iso-8859-1?Q?eDEL+aAcMNIf+C4Yt7oZ85eE6YtnZPCV8gb8bu5NIVsQOydTluX7PZVcoQ?=
 =?iso-8859-1?Q?2OgcHHhMYXUXL4/qjnOtE6HvSdAOk7Hh+ZahTjVl9SK6sA0SwJoGarZ5bT?=
 =?iso-8859-1?Q?mPG77JXLbM3pcvXn/2TxpYn1YhHcW/Q8JclrqF7D1EajR+eCjRYjIdzJiR?=
 =?iso-8859-1?Q?EJ9ZD6+pJwQw03YxR4fO8W4181ZT4Evu5HBa6ygdmQsBQtOCbzIF/mxCbY?=
 =?iso-8859-1?Q?NHBLKBpHcka9EFA3rejcppxE2gwGi47haTvBKBtTP+0gVgAVOEl5oGiGyC?=
 =?iso-8859-1?Q?jZ6Dmc2lTzoam9r5HZbaQupeglse+jgoUaf03GMBzw1sErSlv9L+DVYPJq?=
 =?iso-8859-1?Q?Aj1Bf2LOhcp3p3ZDu7Ar9/8itAqhZo90fXh0RgJFl/tsjQvkm3MMPYu2jb?=
 =?iso-8859-1?Q?SxLw6y9PjqUtViU8AVMHJDNAyl9GfRbPBTE8E59xD2MtuQpBzDRQMb1CVK?=
 =?iso-8859-1?Q?pAr8nVh/ZN0Y9kcaJqiHeEb6Ek7J/vWpTWVMidUPc+6PJdWA3pJPDp33V0?=
 =?iso-8859-1?Q?3GVheWwkoZO3x5pwlRGblUeZvzUxEy6eNJP5ON30Iucd52olCS2PwkoP4T?=
 =?iso-8859-1?Q?EhmH8R6fEru6D+iJUpPK52DFjNHN3oGnGVKhXuZtP6+n05Z+g1Y0g1V6Tg?=
 =?iso-8859-1?Q?TPKkV9YblhBgsbH+W0Ir1Dgzh8TkDuK/IOfL+BFAbVUBJG1jZqExZe0Dyh?=
 =?iso-8859-1?Q?h7Yukp38XwNzRr+RoOwIXaruW30MMvMWircXIShJ05fmUzvjTSNjdSfG+H?=
 =?iso-8859-1?Q?gKOmqypXAeNYf6tGgXI2YBW/K7hozc54CFSeiSiyCQntvY8Jowfos+wv1L?=
 =?iso-8859-1?Q?9STqlkew/vL/k6y88+LjEn9+olGM13T8syaTmCI45bz5e11ogD11bOpT4S?=
 =?iso-8859-1?Q?WhU1FhQSe98jUIv0vMaAHDUDD9Iw4MfpmCYxrCxkvhQ5MbFjDs0LNksYkR?=
 =?iso-8859-1?Q?3NR8s5J/JKQHQs7RhZkEbCzASVy7V2spyJd4tKJ6iQDEg7sHsg089p4pZ3?=
 =?iso-8859-1?Q?Za+HO4dqKzH4DC/G8P1NGiT224Xypt/Jpn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a7fe11-d846-44de-dc36-08dd3643775b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:35:55.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlQyYnXDf3EY3Z8mnoYtd6Yikjm7dgJ4jSPS+zd1w6iqagvKFdoeC7i3aok7/Axfrp4ytnVWCzxa50Es4jfxwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5969
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> 
> On 1/14/2025 5:33 PM, Ira Weiny wrote:
> > Bowman, Terry wrote:
> >>
> >>
> >> On 1/13/2025 5:49 PM, Ira Weiny wrote:
> >>> Terry Bowman wrote:

[snip]

> >>>> +bool pcie_is_cxl_port(struct pci_dev *dev)
> >>>> +{
> >>>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> >>>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> >>>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
> >>>> +		return false;
> >>>> +
> >>>> +	return cxl_port_dvsec(dev);
> >>> Returning bool from a function which returns u16 is odd and I don't think
> >>> it should be coded this way.  I don't think it is wrong right now but this
> >>> really ought to code the pcie_is_cxl() here and leave cxl_port_dvsec()
> >>> alone.  Calling cxl_port_dvsec(), checking for if the dvsec exists, and
> >>> returning bool.
> >> Hi Ira,
> >>
> >> Thanks for reviewing. Is this what you are looking for here:
> >>
> >> +bool pcie_is_cxl_port(struct pci_dev *dev)
> >> +{
> >> +	return (cxl_port_dvsec(dev) > 0);
> > With the type checks, yes that is more clear.
> >
> > Ira
> >
> > [snip]
> Since sending the above I made update to be:
> 
> static u16 cxl_port_dvsec(struct pci_dev *dev)
> {
>         return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>                                          PCI_DVSEC_CXL_PORT);
> }
> 
> inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> {
>         return pci_dev->is_cxl;
> }
> 
> bool pcie_is_cxl_port(struct pci_dev *pci_dev)
> {
>         if (!pcie_is_cxl(pci_dev))
>                 return false;
> 
>         return (cxl_port_dvsec(pci_dev) > 0);
> }
> 
> I can change if you see anything is needed.

Looks good thanks!
Ira


[snip]

