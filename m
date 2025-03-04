Return-Path: <linux-pci+bounces-22901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6855BA4ECDF
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D96188FE80
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80CE253B75;
	Tue,  4 Mar 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCoCWF91"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791672512FF;
	Tue,  4 Mar 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115509; cv=fail; b=qdjYc58XtpSIQj3trokT0Q24hLTmVOrXAwiD758PSrBwJUKCc65YJXk8iLbHt9aQmdSW5Nu9CSRiVhBPJMflZ78Wv7rsa9PVBL5r8yzT1YE4aijMBH1pbgWunmbknhIcEYTRIQv9r42nFj7tSbcZ9KdVBwl8MB3c1RRFZ53PmBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115509; c=relaxed/simple;
	bh=mNG7GwHqujihhB3KGck6vdiyoQGqLEJ7qrIUs2E8HMc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iyAzc2ztCIp0bNQEYWWU+0Xt9gOc1rdF7mkiQ5FYUceaLgYcrUXyOXzfIGySEM/An3E2yz26IUo/GlbOiATrOpx847zMrcaGmuznIeRc4ItBFw9B4uHDbWCfPlAXWz5m1XIN7DWwbYEyrOpq1jzJrpi3CM7GI/9PWart2hoOdiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCoCWF91; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741115507; x=1772651507;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=mNG7GwHqujihhB3KGck6vdiyoQGqLEJ7qrIUs2E8HMc=;
  b=BCoCWF916S1I0ETX0ekup7N3TQyEGHz17eNaeB6z2co+qryCQ0s1QSra
   V4ejEeiHnsbA2SfMyf8eljctP2/wshyduZCp9gEXqu+mkndRQKyvGz8d4
   7Vth1hHAVTU8WIiAp2BJvVCnFWn0CqAivqV2eCw1MJ0R2CE5MR2lRRw9P
   IgDdfVDzOa4Cnx/UAHnQ5OE216Kq22ZhUMG7BESkDeW1Mu6oWHTK8FVY3
   RLFKmp7d2DCnISk7VxYz+BrnaFa/rLyGhiRCIxIjAuUxqo9y428NoIi/V
   qTbelnAuTFcEguLH9xtU5d0QHbF912godQa/17XvYXl86VrmntCfReQhw
   Q==;
X-CSE-ConnectionGUID: fth8sI9hTIGqnrIQatXTww==
X-CSE-MsgGUID: wBNjoctzRu2mCq6DPxJfew==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53451472"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="53451472"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 11:11:46 -0800
X-CSE-ConnectionGUID: SH8R2h59RZWWH8RyYeT9NQ==
X-CSE-MsgGUID: VGEraej6QWaGcymsghxp0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118359580"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 11:11:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 11:11:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 11:11:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 11:11:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gccXVhM25df+UDyWtuv4YqB0n3WhiVU7wnXmst7Kmn6o1oeob6PWRBb1gDXA9IapPSf1u6ay0TEdVV6RWtgdz9TC0/vFeIdnyU6d4ZgC/HZJ6s9T80yf7yYYoQlPnpSXLd0k/h7R1/t8GfKYdjvp7FAHE+PiPNRGqAS7XJ4if3TyrcMMeF8aE3JpRI+hrPjL1cx30DOmJ1bUn5mq9Us/Ba9UF66I1B9F81TGewin1E6Pn4dfc7bv2u34ZF5mFq0ah6fd+4glurX2dTKXa2OySApjRCoizN3G3A3ng8PPUsRout1PI1NK+Wdw9G6xYACtEQliMI+oEx0fkCM57HaTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fepJAS5fMLpYTjHYu1mGuGRMHyAi21aZfKU7vEoaA8=;
 b=odSZqozY3KZ97sxhsWW/uuvsqC0qo/NI8i+PWBACqwGqLFU0u9xqaRD74AchYDDH/4WIvuMLQRTEl4fzBLkyPBpJ/WaVTzcsvgOIu/TeHxF+mzNdQo3a/H3Ckkyj4DavnJD7ufppIRQM8oYjVD2wGnBwbRXkc80SfOCOG5SH+jLG3N0wFZ6JCLNQ+uVuPz6EKUmX3MZJwz/Vk5JvZ5EkbjCHyeD//E+uWlGUseWzXak5pfzyfZBupsEL4C4NnPILYmNm/ahaz9m8LAnmoFAP28vCWJ+KGzTbuzm/eT+YspO+aEjNSQDt8alWPtlHuSuybMOUlEO+RfrxHuzUjpPbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 19:11:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 19:11:26 +0000
Date: Tue, 4 Mar 2025 13:11:29 -0600
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
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 03/17] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
Message-ID: <67c75061c48ae_1327329491@iweiny-mobl.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-4-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:303:8f::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 5208df0e-9f18-408f-7b16-08dd5b505c2e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JidD8Y41stkGztu+oSef29hiuUL4mabsAgaqEIA6IgycrP314H1RGcqR0rRC?=
 =?us-ascii?Q?BM+ZuwlVtMVvPWmbXN6PuPaMfZMF/qkabIxH9CcjxTXmUaWqm+payV1CoE06?=
 =?us-ascii?Q?G/9l1wThrtTwTu0pcV0mP6KoyyQHCd05uSXw1Q70nibwhH4fAQwj0zTmoU8C?=
 =?us-ascii?Q?J83++hAkSPd7kY8IDBh1Jl9DXhyXFa7WtVqA+wu86K3vPC6dQ8SuChOgGJKL?=
 =?us-ascii?Q?qXC/L9PB+f9jy3DEMcavxAEmowG3YIK97WfGkea33RdGtAOpkFuX88yS+t6g?=
 =?us-ascii?Q?zss5V1g++3bXuY2VrWYPzfoABljXV+5ktucxBrPkZ314iLePTz421UJQ+u94?=
 =?us-ascii?Q?mvBmubArF25jeHaa2uWdUsKiYEDRRcjNbrBJWbmuqBVPBxeWJM51qTFUfDkJ?=
 =?us-ascii?Q?aDkcobq+xuV/MaIo78RZKJWS4PutUvlEUlJNbak9u/LE5hmv5YzMxaQ3b44m?=
 =?us-ascii?Q?yu16Zb9LG9woJrfkIQD+zT/kTdB33fyqUml3fJZYOyGaBTBKf0aJxH0b4roM?=
 =?us-ascii?Q?1/pXTt8Wvo+m8YAZxQTNRdXsxJdExmsCmdVdsA4gFS8wkG/T4ZCyfS04xW9T?=
 =?us-ascii?Q?F12PbqstGMeCy72xBHBsFqD05F/D0QQJ+4RDUsgPX0i192mDc3Vtoy9oQTTw?=
 =?us-ascii?Q?z6FDeSCkpuHtd/y25chGhQ2S1IVxTS2XjS0AP4v0pj0wukGfZUL9g4W1P9uy?=
 =?us-ascii?Q?CvCrTPjf6owxUqVLiI7OK3Z5Uul8rSQTc1BjKcDuhtSuMXFsxxKXG0q7hDh/?=
 =?us-ascii?Q?P9hKVjRQN9e4KafMf2n1rCOMhF+zq2ENpqslcIJWXKSq4uZZZQjj2IhginvS?=
 =?us-ascii?Q?k6HVQmc6VLNeqPvq9lTtBG2aXMAPYjsIc9Cjnc/EUM/L78ahd3yYRlszIQ2t?=
 =?us-ascii?Q?EVtK4a0DoRVP+054zJQylxiCu77VYbOSl16+rdQi6mgVgxT54FNL5yUtcao4?=
 =?us-ascii?Q?BnXeT/UJcWEpnS3hcPIMxiXcZ2m9dZZ2vKYwPqV3t/RAKuWX14NG8jDomtsV?=
 =?us-ascii?Q?QVpTojbqkohAIl83Db/3H7eRly3ptr2xClSMCFtJ5yTJoqy0tpo92buospWd?=
 =?us-ascii?Q?MnheL87mGbiK5CEYXCFryO3YbPXR/XPbfeOiPheGVny13Sdm2ALIiS2E67yE?=
 =?us-ascii?Q?zW33YfBS2bIVjfZoRZtmxduIy9gyGUqp5yfp7ChVKsjoWpYtPO8MiFUn/evS?=
 =?us-ascii?Q?I0xreKxU0b5uaFUMBvDPhwhvWnq0eBKEkduu7FmuSWcZwupR57KPLx+ekxM7?=
 =?us-ascii?Q?45TyYg2IOPW/rAmg/9c4x+Fnj8CvNZwli3fLMX83kEEu3dQqumD6lteQ2AYU?=
 =?us-ascii?Q?m1OdDGxixiHi/0zdbfRW7MvFN5fMUmonFhJTgMWgVQRV8uGPK12/VRlccEAQ?=
 =?us-ascii?Q?e8tTmcJ7SXZuH79mSMNoi0j9rgfc1DWpP8MyRLCzWoYneld55EZu57dDqB++?=
 =?us-ascii?Q?/f5fAbQPmp4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4GqkRYGbjkFvj3/sRbZe5fYlgKCe+32ssvrmo5ZoQp0Ad+/AL3cs2pjE9cEo?=
 =?us-ascii?Q?zC65gNYphn4VZPvNQbBqMhjprTGjZoE5bsJ0wiZoVwNeaXLUzg2qB5seDH07?=
 =?us-ascii?Q?r2i6rW6C0CCScLXptIfNfydqkfpqXuviT144JkTPnVzZyo/Yj9pJHdOcy0ZD?=
 =?us-ascii?Q?J4Mo/hLhnGVN5PirV++O5juEM2BbNL+7ek9bCU1MrS68Zc/AUsqSYrbZOook?=
 =?us-ascii?Q?etqM5idowDTUprSIxtPjBpzIDsjw4xIdfe/+k2W7RbBMSRelpG9mBKdYVh3g?=
 =?us-ascii?Q?q691skzlnMrI86TDHr8RCuC/tDFPlwLVRlmBySlBZKmHlHfMuO+jWhyxlAwJ?=
 =?us-ascii?Q?r3Zv+rNpEhz785K5A9KLvf+VihEZCOpqpdqUXfn/ZdvY2zvAv3UjWQN3C1/x?=
 =?us-ascii?Q?7LeOG3edjZ1671AxDl0oTrqR3mk9vJl3nMQiRQgMhPKkyQhHe4Vx8DoPepfP?=
 =?us-ascii?Q?37rlnIUwqJoV/iNkSp1vI1r6YfFA4OBxV2NVkVtW+ML5BD8/cJNIlY4FJmIm?=
 =?us-ascii?Q?KVrVQPAe7Msf2HMjBNrpUWy/sj0gesBDj7Tmof724aQIY4a/R0HAJQiPWLOG?=
 =?us-ascii?Q?hVeY6gQRlDOSa9nKi2dZBbZPgBmCGkUeGIOuVmYugIbPKt1yQxgo9cL76DhL?=
 =?us-ascii?Q?w3YviM+Ilj14HbMB3AU1wB4QpvInzZiH6J3WJWQ8WboOP6P8TFaj/og2uZSW?=
 =?us-ascii?Q?eMXwxHSD1P/8B5+2vszaXPjKHpb2ZbRBWsigYdYLVtyy81Mg2QD4nkoOH/XY?=
 =?us-ascii?Q?CWP7mOUefobdRTu0GthK/t2M02Bn++m3IzUKvrqR7MoDVk9lDl76lROfw2Xn?=
 =?us-ascii?Q?zKeEnvTT2lb0OzkcNDFBy9ZpblJYscDpuoIeZOWmqYBJtocF4XXDXHLDQy2a?=
 =?us-ascii?Q?vB0rOIDdmr42djBIjU4N+ubSukwpt84u/Klr6EyGrVNTcMpjdXhtzvGuFBCN?=
 =?us-ascii?Q?Gm8JbeYjoVXcuQFJS7NXksfzPYi9IEwZCaQFokCtFzPGmV301UU6b/z5eBcC?=
 =?us-ascii?Q?HxT8+uwPQfCSRV9sr4e3Z8L2Ljw0lcMCy/g44ezAGZlefpof26eeD94unsFu?=
 =?us-ascii?Q?qShLk8jsSysXiZ/40CigzvzAd60+gP2Ydi0LLogdV1vDDIaABCH/vtBRVzD7?=
 =?us-ascii?Q?BDfEtJflRN8ndwdQORMWPf5iiTWASP0SdfhsJEvs3tT9lbH/NDNep+504/fq?=
 =?us-ascii?Q?paNla/HypSqweneGf/cR4P5dKaQgB60r9dcfYNp5qMcTpQAZawucqtSGh6Nc?=
 =?us-ascii?Q?8eEfhI7oIG4NbY7x3x+hrA5urGkgUZ2RPDmbautrs1QDyWfKYMGtO2J65Fid?=
 =?us-ascii?Q?cFRr8QmJE+W8KWYFKtZ57KgBSPce+b7wmakPIpdOBdq455m+1fCJ/np4pjAk?=
 =?us-ascii?Q?ZDwd22QDnY/IeKNb52a4ru09OG69YEUHfMONkiIP0R9mQPFx40CEnKRjJbt5?=
 =?us-ascii?Q?whzfBrDw9TC64atomnP6LyKrLaV/KWwtdd50x/j4cWpNH2cntEA3fTHQTjfr?=
 =?us-ascii?Q?ZLG/N1rxi7bKlQs+tBSkdJ5c6krlLLTdeRF2Knwh9JxCvx4+qrwg1xLGM+b2?=
 =?us-ascii?Q?r9T+dllCXnDuM486JzjfrX1vKpeKd3GVskV0TcDE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5208df0e-9f18-408f-7b16-08dd5b505c2e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 19:11:26.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvpNd7MDYcRxKeVqyQbenqSHR/gSHjIIgVclgxlhGA+mCAFpcKtrjk6RtY9hkoEVBxmTaUvaXhjuf9JGu9hOIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5865
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices and CXL port
> devices.
> 
> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
> presence. The CXL Flexbus DVSEC presence is used because it is required
> for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> Flexbus presence.
> 
> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.
> 
> Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
> Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
> CXL Extensions DVSEC for Ports is present.[1]
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

