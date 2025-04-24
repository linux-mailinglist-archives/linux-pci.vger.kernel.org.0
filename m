Return-Path: <linux-pci+bounces-26635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522CA99E52
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E474623F8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82CD2E645;
	Thu, 24 Apr 2025 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtEzHOvg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4C2701C3;
	Thu, 24 Apr 2025 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458545; cv=fail; b=TpVuOIojGvPPNbVYOHCDkLJcW51VoOwQae9bNZV1ZkAuL7KgWq8x/7ZMb+DH1/ZmW8QVw/B4jmkZFfPTNFoDLvhwAktU8PejYhzLGqun4MV6v+ZdGChcqlmxVYZiGgi8ioB4zX7iiDc0RzQuFxSBzuUOMAmc+RdrpTmHJPRwAo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458545; c=relaxed/simple;
	bh=Dzm47R/DZbB2TOb6m5ubZOVlKzV4zQFaMsVQYTtZus0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ifikXtTUN+iJGuu8u2bn5vSahQpsKO+R+5sgrHj46I05bXatgqs2V8jAgnE5McN3WDYAIVPQ0GE3grURqY5jNNL2VlSdUJoDT+kKN0C/BejrUDlv9K+YAFTe5VqzRd5JUb2/2IhNHII1sQkD9hk4FCe5dwkurkWez+viGJIYgUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtEzHOvg; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745458544; x=1776994544;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dzm47R/DZbB2TOb6m5ubZOVlKzV4zQFaMsVQYTtZus0=;
  b=MtEzHOvgb+RRawfkAttKAcFIjDirj9BolxgsWs/jq7dFPIvKVC/X738S
   9j88NgTP0Em6lRzfK6jSAuekK9FxNv/eY0JX2LXNMcXGIjUpgbqNbHgf+
   z8B88g42r8I1S8pP5pfGIBCs4utdKJb3wfgVsXb/enAIY4zIjhHBRB6Tp
   xoaIX765bYNX8I+ZuLz78YmHT6i3p14WFygWtlnH4vmIM5mEHwUquVxOI
   e80Ma/4HP41F+8/KH9JIpiQ9uwIeza8EsFMKMwhJxFfL9UIUBPuV8WpWI
   4JQVvy5Fx83NpQL4l5JMhwwEyKRANsKpwFNmTpq9qNYYh88/4C3y7JKLG
   A==;
X-CSE-ConnectionGUID: mWol45kGR7ORMCgq60jJpA==
X-CSE-MsgGUID: 9lwgBBygQ1ediru9re62Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46781341"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46781341"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:35:44 -0700
X-CSE-ConnectionGUID: gC4KUmyATeeiDFy4AsHEiA==
X-CSE-MsgGUID: FAWROWmTRIuY66pUidAJaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137326607"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:35:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 18:35:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 18:35:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 18:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6Ju7S1dVoHgofkPr0eg6a42XE264ACBw37CESQbz7hdOG+ymLl0vqVeGqbO7HqzRBN8cGClEwEXSKCp+uI//40sRlyjX+m4vO/uX3Cs4KxD8tIbl3hQa6Lgm1jDKniltAVZfngGr4QvVWN2Bqq+8onL+4mbQq4opyNcGBEF4eQESrsLu8Rys5+3GmyJHC+jiSQiCfKBcz04py7xRhXXEAjPVOt4nxY2J7hFEoU6UznXTnyGgJQSoW71/hFVVPARKz3w3DSV2aOI38WJYE10R/o5jZY1GUlbfQk0knXXuz8ilEZzLjlgj4uu0amPcdGcPSNQAu/1WU4rTWJildqkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=746JsnillCUTxzlWMKjIpd2XCst6PrmbNqqNP5+DW54=;
 b=XAgieTTqrxBFjP/TJzEj8YIBAVavGMACErvaIS0Mw6C8u8Xof+V9cwA7ho1GKp6ZGV2d4nw+F4qoMUEqcNAAEirG/NKm7MeyFbcICCIZ3fFOEaA1CN/fSliw8/olRf+0yS5nBhAlwLqRVQYikKUt3I7pR2MCKWAFXB4ME14FWkK05wyLsPIFYeaYMbRyG16xpsvoVl5GZM2xqReCHczlIrHSH/XkZlK/YO25Fa9Wy69nJzthibMZsDHehPsvv2bnFing62wGgB1gjV+yG2s5ZE+PeDBkZ7Z6Q7HchniPB6Punh2CUPoj0TZ5HNeAnRRwXi0AfPwuG0peK0mTEN3qOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6092.namprd11.prod.outlook.com (2603:10b6:930:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Thu, 24 Apr
 2025 01:35:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 01:35:12 +0000
Date: Wed, 23 Apr 2025 18:35:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, <corbet@lwn.net>,
	<bhelgaas@google.com>, <kuurtb@gmail.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <vkoul@kernel.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<sanyog.r.kale@intel.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <dan.j.williams@intel.com>,
	<andriy.shevchenko@linux.intel.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<Dell.Client.Kernel@dell.com>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 4/7] pci: doe: Replace sysfs visibility macro
Message-ID: <6809954d881f2_71fe2943@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
 <20250423175040.784680-5-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423175040.784680-5-david.e.box@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 660aa354-4186-41cf-0a4a-08dd82d041a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ltoPg29m5D6mWqsq6pNuA2lCon64Mu4+HmSPp51csRxLKm/6NVmdirYcsF/h?=
 =?us-ascii?Q?PAlJLTEruY3DInDsUMKRYBMc3HbWDsJFO2z5aqPVgqX2N9xnUh93VsGJ2Y8I?=
 =?us-ascii?Q?hKjNWOWq/AV9b6diP0HsGAyomjUsgIvJzYI+ngl/mfjMHWENXWvXL0VaPAuy?=
 =?us-ascii?Q?Qwu6VslQBQohsDOmFtRjC4DR4cyfAHdoTA+B0riWvWvf4jRGa3yREPQ76FML?=
 =?us-ascii?Q?JZUTExqoxKCdWDQT6AhmvEgPKC6AMuyA9ALspbZAy3Sp8qhqZVKbIbpDngd8?=
 =?us-ascii?Q?QhtTS6Z5+u3HceTiTTxR23W8wBOrAaToHj/BBEHij5HZx+pjr0gQuhpq9rKg?=
 =?us-ascii?Q?oT4PTBy9EGSd8+TglXr5r18geYOAWdz6eP2QU1zCq5VFOYYaZvsdK/j4u9Gq?=
 =?us-ascii?Q?nS5GY12nboxKwdrxFvueKQCRaCNXodDZ2X78sqTG7lhTx2U9rGe8snx9qxVG?=
 =?us-ascii?Q?GP9jev2doDmT3OX8osOj+MSF/GbTeRzOgDmVzK4ipgRMO9YRC/WDd6ZOV1ZJ?=
 =?us-ascii?Q?AtI8aWN+o2SiW5n4fSbIObcBUxJmwyMD07TiQkRoSpfWagY4dQPPSCvleUo1?=
 =?us-ascii?Q?eI33Hcr5ieJ4/5qtzQ1vgwuiHO+b8xuZpC8HhAh6wyueAyT7BxBIO3p4sHy0?=
 =?us-ascii?Q?jyhvZ+hln/MkhfPja83r7WlF1IU8IoEi0Bjy36ywaQPbjj/3d/XWH1sRedGy?=
 =?us-ascii?Q?OJjxEf2TPk1yZ2xoov/wc7iwQfPEIZORe0/MdOh/a+co2/zFgZ2kI5m2OJVi?=
 =?us-ascii?Q?RmAf3FUu3ku0m1MVfk82klWz8373DWi9Q2fKSUqJlmvj6gi70miaoiyiGhm0?=
 =?us-ascii?Q?sCaknHcIq72Y/oumB9Ui2DdeOXsF3Rzi9LXp29xUZpm0lv49nadOlCxZrq0t?=
 =?us-ascii?Q?2hn0BRvIMfEb2x9PtNLftpMNv9PEC2WdFnTkNsvcHYil2AOFUgLzAXNNZLLj?=
 =?us-ascii?Q?Lf9P4dsw1FEtc57mw5lSfik9GooikYqII9KWIwBHHVrUWAtr/oZAJkjVIjAP?=
 =?us-ascii?Q?/hR/LKUvEwHy3scjD0GWHgiMSzbBYXwyUk+sPPat7qSg57ZiMliEa18u2Vcw?=
 =?us-ascii?Q?EwocKRX923m2bZ/xOqAS90GnCcldtkXV1Vm+W2gxDsrUWUpQO8bPjwrOeqIL?=
 =?us-ascii?Q?IbkT/dq+Jzw8eEDJEQzqLZddYMNw6sCEGrUFwF647xk3H6G1ARv7FLpV9ku6?=
 =?us-ascii?Q?nterchUgNMZDL0HStKDtIlxp7PVWr8XnSYPRaFTtIs8RS70EpzPlwZniPPKI?=
 =?us-ascii?Q?sDY+IHx0UdaTFWjEqyWzk11Ri+lJ1PaipInbqc77YEg0g+xZcZwAjLebL/gY?=
 =?us-ascii?Q?oSc3+CGgt0gNWDTAdcpnqtB7+RcChwufV+PhqGWba4xdR5USKP/LEYJL2q78?=
 =?us-ascii?Q?ZFtvhQpQ0CvKaJL/yCRnKCOQs8czTi3ET0EX/hIOcRCVJV+2GW0tIGFTWSaw?=
 =?us-ascii?Q?ugx9tHorLe0Y5hZAfmBy4K6rpQaWujzRdC5o+TWoLBGhRuItWFbzcw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?URjVaVMi+LArx9fVARKpnU/hwCUYaZatZuTul78EC0nlNXaPCtSrD2gqwUWk?=
 =?us-ascii?Q?ZTmrFc2mAYJSaxVAb4X56oVXebwbCEviTwNVYukMhyWpO4lLVs0dF0FEPH1j?=
 =?us-ascii?Q?hHRWiW3gHv8DFcGK4M6k4DfJacUM0SWo8ivTtF7G/bzUrlXA4anqvq3GH2sc?=
 =?us-ascii?Q?MGOyzHnHwczrwo2IfiiEhRCEmk9et3gFKLjyNKB+WIhFYi4YaT3JO7PKx5n6?=
 =?us-ascii?Q?Zr8VtOcUCwek0uvFaMtiNPssoZAtIbxS7NP2ZWbcOn/H21Y74inZKoyTe7Vu?=
 =?us-ascii?Q?wBKmiOFTdmOdUlQacbvVZqYCVLLPR2wzBZe3KEKYPHegsFLTE75roAKPH1A+?=
 =?us-ascii?Q?RWYqi0m5unxTwLTDgU7VdptavvjiQidLP2xhVk8XeiRUjdR6WaGkKypfHLoy?=
 =?us-ascii?Q?4vD0WHlSuShGBUbCnj0B5qM4mNvE788DEUwn0exTedoZYXi6kH0wF/bLphIA?=
 =?us-ascii?Q?B9AMSVAzg1vdPIOOSN8BiXHfXCzppvZZ617/rMjauBdd0CHxaLDilk+l9uyi?=
 =?us-ascii?Q?R4DoyYaS5vV2/o2BRk6hIpUEZAaUskGrf1ur/YTOtCTBrvAf6OU6U3QrmJcF?=
 =?us-ascii?Q?xovjXCppAfrkXNcqFBBEKQ41CJ+4H0w78TpZN+R3iLfCRFxdfcFD7amepwFK?=
 =?us-ascii?Q?VrKVnD9FF1LaHCDSfw9/1EzuwODXfL26OECleS4LtIqRqLaUIBCJBntB3yHA?=
 =?us-ascii?Q?Lhm1S8C13ss2WtXEAiE135olq0+iqezvdqdZ0LykwOZI3cPSs9hTnNuVr6+o?=
 =?us-ascii?Q?jgY2ZmFLmjz7VUa4GuDGnHIIVHPTVXpGn4yBZIuzrR81Wgm664EFb8JuT7Fw?=
 =?us-ascii?Q?eN1jphWsbJce3opn+3oAnb8j8bWxAIQmnh4h5t42zB8JwQxxnxLium9Y5+qu?=
 =?us-ascii?Q?txavegyoemXLOYYoedL/ajt6iNUCPA9GjiMhFkuF0h12sQIULs8Kh/9yLJ1h?=
 =?us-ascii?Q?fOr0j85UWAV2oyHyKOAul1Y31rS4FOFZtrgvf58gS1Mqje+gPbJovhYykGIr?=
 =?us-ascii?Q?lK00pGPBT9ideCPez+ck3dt4S/jXHYJZWFC0wAAfjNbnGybdv73/qEbpIS19?=
 =?us-ascii?Q?sI1UlGP1hSbFEN+MHLRjSw1M5/w6DU9yel6osh4FeX/tXMTiGleTtOTfO/cH?=
 =?us-ascii?Q?FW0gnCqXCPatOPMc/H/97LdzKHbDaMgJ+Ir59kMWVH8Db/vq5bC8qP+Hx7wQ?=
 =?us-ascii?Q?Cp3DH0j8qkniRvHD1mODUhCQKTmC7qVvnRUHrWgCkXzkpxgkyYptM+xCMit9?=
 =?us-ascii?Q?+FowwjvDrbcACeThnh6+zqiI3OhXf25nyLNEmWNLHqsCgb3ZTYa5z3FDybnK?=
 =?us-ascii?Q?JPnxVi19ssm6wQNVXQuhUJoHgzPZKqPnS4P8FkHST93KW2x6aPEg2lwxzX5o?=
 =?us-ascii?Q?sC7sQaIqDEGmWrN2V7ESNsnP9d2gmvPGbHN3w1rkJGnfDSgMQKrqKCHrcote?=
 =?us-ascii?Q?GDQV0P6LXOB/pzR5Niqhyt9XcLuI2xZJEcdWE825r/x/eJI/L2RWoNKKY+Xj?=
 =?us-ascii?Q?S5SJdm0wFr9HRuM/nprjqAKpEHbQb1zIKl2xrpluDH0rPJENpbHiLIU/B89n?=
 =?us-ascii?Q?BrELOc/PdYaeQ1Ad9TYRmv1rzzAFenBz+nu5nvbCPzxFRYoAvHCmbMvh4uPv?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 660aa354-4186-41cf-0a4a-08dd82d041a5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:35:12.5075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1Uc44ZHxTaoSDh7zDMH4Z7jWiIPLnObaEo8lpQE2DAU9Cns3YV1Fu0wi/URdC6zbljmUzTi6/NoKXSucri2KbnWlFa7T2bB4PgjyzbmW+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6092
X-OriginatorOrg: intel.com

David E. Box wrote:
> Replace deprecated DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() call with the new
> DEFINE_SYSFS_GROUP_VISIBILITY() helper for the pci_doe_features_sysfs group
> in drivers/pci/doe.c.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/pci/doe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index aae9a8a00406..18b355506dc1 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -119,7 +119,7 @@ static bool pci_doe_features_sysfs_group_visible(struct kobject *kobj)
>  
>  	return !xa_empty(&pdev->doe_mbs);
>  }
> -DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs)
> +DEFINE_SYSFS_GROUP_VISIBILITY(pci_doe_features_sysfs)

Looks correct to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

