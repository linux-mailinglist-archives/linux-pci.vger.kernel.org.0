Return-Path: <linux-pci+bounces-9211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BDD915933
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 23:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007AC1C20DAE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 21:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8134962C;
	Mon, 24 Jun 2024 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khFtqFqi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69D1DFD1;
	Mon, 24 Jun 2024 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265613; cv=fail; b=q6FedyJtE4OZtf/c15S3el3gHyf4erRlt2JD/22QJyWUT3LhBe9pP6iLRAhZI8wMNS7JnQFgNSgqa0iyu6WEdYlSKX7vYBmyIwZ7n5aI01gargEAJLw6bBze2Sxnu5v/2jcvZYpXsYAahw2yft7iNLJ9XoL+x0OMMlacE5+DMro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265613; c=relaxed/simple;
	bh=pc9qORuynFYg/WESt22G1L9B0BmC96vonyc6ASYqtLA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LPrFe6Qvk0cCsJDmCTWw/QzgwjADGn+D9qe45HG1D6f8e/lxsi94k0wRSq8OPBEU8OfCZflhCH5DNKwCWB67a6gGEt8SWvhtWUYGtAF29F9tkWgqa/2Fzug8hgAFlo0fiAg6B15diUphP51aND0oZmKRj6zEev4T5WlnR4NSGuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khFtqFqi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719265612; x=1750801612;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pc9qORuynFYg/WESt22G1L9B0BmC96vonyc6ASYqtLA=;
  b=khFtqFqix8U4bhZ8NVBtS4pC4JItvCYAtIcWD5zRfuXmmYQdlOfYhZjb
   zDzG+V5wfPWf69/1EMFJSyTzeUhLanZ8yBix1+jMLqexokgAxh88E34Wa
   eM/K9aO2tOGV17aFgSoTqlLMSYhw1ppw+pZneloWr7Y43XpqHmDQ6gWgT
   YO+N9Wf4DrhWnReqcFQf2BjzCoLQhtvhRvuKd4tncCFVSzft4P3RLRRL7
   8qVMQXgmsrNcF3COYtsqhWhmtNscp0a8Mv9gph3HakQ0WYf6YwGmODXCt
   HbWzvTbKVEEmSOGmhFlgi+kuQcEaovpKB1ckiv+dZoSKWME9CvF/mLLss
   g==;
X-CSE-ConnectionGUID: 7QTkkL4pSLCcWD4s/yHAfg==
X-CSE-MsgGUID: Ki9s91HwS82KoeknBX8EpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33717129"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33717129"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 14:46:51 -0700
X-CSE-ConnectionGUID: h0+XGbh7Sx6W/AxMJRR+OA==
X-CSE-MsgGUID: R7GzrskaQ2m8qFxMOY+dUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43411981"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 14:46:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 14:46:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 14:46:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 14:46:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkeZDIaeA+aIx04Hrly1hQ9iFlidkzd/9lOJ8QCFv5Kq04JpZ6USoyIjupGT/q4v5U3PP3P1yY1wHPwpiIEQVMXgnaCeMqT9hkFeHMzAVZlHoRJ4jtbyWVntnSUWF5XTL5OsjmgmbPn6c2HpZWcRBHRPrG1OdeM++gW2Y2EzNY11aBAgDfXgbeTIIELgnkTgEdLQ5VQUjH21piYr7fE2CC0991ZhxMjyVBLQ3MeV5YNXzp73GmUEPEFobqSjtZznjzMQ6tGzMmN6dftaLYAt+w6FrvTDo7Ag1EsDRJVAVpZeVe8DCuuaXoxwb8PcJkausLj90DgeqX/PdrCZ6o51GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weRvFE5bPu1MdGYwCrF0pn5Kw+pHdE1+LiE36UlpnDA=;
 b=eWU+c0Yrcme3BvID8WMbAf+H1sbui3MOGv7gXjsoWnEq5N93+7simoGvhFb8MqnDOwu0noAeR77MPLci2nLclfuXDLQkoLwskNIOMFdnQDdoj12mhiyN7lqfytxd/jZbUGcje9IxH5KibBMTFJLCLZvsdJczOE96y6pItswBBl6rFRzpjBy8qQ+0+FrEI3voGFswbloMH5a+Jnaqg8gT6QFAPokRSVyxt0H89J9MVSY9St+gYOx/aC+XHgi8Bc2C6Lv+fGxFS+K3iCB4W8NLkVqhoMgYrnB2YTyYnp6U0XTUdhZZp/4HvlN08Vwe7xLgd9Cpyrk5iUkUl6RYGb1Fnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8658.namprd11.prod.outlook.com (2603:10b6:610:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Mon, 24 Jun
 2024 21:46:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 21:46:47 +0000
Date: Mon, 24 Jun 2024 14:46:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <Terry.Bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 3/9] PCI/portdrv: Update portdrv with an atomic
 notifier for reporting AER internal errors
Message-ID: <6679e94411f1d_56392941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-4-terry.bowman@amd.com>
 <6675d622447ac_57ac2942c@dwillia2-xfh.jf.intel.com.notmuch>
 <ce191d03-c228-4f1e-b96a-0388220bc586@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ce191d03-c228-4f1e-b96a-0388220bc586@amd.com>
X-ClientProxiedBy: MW4PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:303:b5::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 390b6bd0-fa5f-4eb7-ed04-08dc949725cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013|921017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?agukuCX2T1wj0YfkY5lK0lPqaedKG/IlUKGL8TnovAiHrDIAc1dXbiRZzC5a?=
 =?us-ascii?Q?0951/0fOSJ5NLoLJzmwUnG/xoiixvD5H7c933eMLOVUybsoy/Qkf1OanKRDc?=
 =?us-ascii?Q?uhfJLKBOfvmGC4Pzvbd5tJCaUGclcuzSkGIxWIM6ECOTAHAH6piXKkSXPEHX?=
 =?us-ascii?Q?YKig5ICGML5R/dKaBi+9aQCIqmoESf32FqGpCsn0mqL7xOpsG5HUjoe8rr3H?=
 =?us-ascii?Q?G+P4kqT1vsymGhrKxEoqOZxIN/SRhnuyssUBGqAh7Q2JwPSbWnS74YZZhlmP?=
 =?us-ascii?Q?Iwu0ddYOH9SFpXL9FVHVvTxa7e17vaBfaXdHpp1xPaJh2UamLoaaKhcyF4In?=
 =?us-ascii?Q?ZGIkMq2oMHUAVAODYYjfXQCBFhnGx4ANUX77UemqoB03zjJSeY1PaI177gIh?=
 =?us-ascii?Q?fJaL9dzHIUaQ6eIadDC5vF65zxiChqEXu+fUL0JTOH+xG8bcrIgdtXTI63pM?=
 =?us-ascii?Q?VN3Nqc1TBsV+ovCf/kKp5O6C/oa1WmrLRNHQHz509R/DIt2cU1hUMKPOZXbL?=
 =?us-ascii?Q?XYgg01Ksv8ifehsNEJoN/n97HmecPTtn7g3JSLVdXKOqRJODOx0aR1/sMJuO?=
 =?us-ascii?Q?04asy5U6YBHTe6+hKEBENUYGH62wDBqXW0Rygij6jAZbAQP6sjolFcwr2NWM?=
 =?us-ascii?Q?RV675vC8gt/f5QOljIxztnjAWTUWVaL+6K5qNFdfIp1Vtqkd50wHogIGIyWM?=
 =?us-ascii?Q?FjpBGuqAHgGngSXICyw+GOkXNtfH00DAfM0b/Mor6sRiIypTkdOODs8gtIIr?=
 =?us-ascii?Q?Bst+6TkMMU8XljRZJGrpvKv6QXajtfW/yOICFkk2JTPq/yJ6I8uMcDRNzQ11?=
 =?us-ascii?Q?8dS6tu23Mq489qEYt0/JzhSDCqzwyNIE9C4wjztNCEJMs2EDRnV86FZz82fU?=
 =?us-ascii?Q?8oMcKK+uwUeDHOh9l5Diwjx1AuOhmi1QcFLT5M4IsEN2MaZ+Sw+Nc994pOlN?=
 =?us-ascii?Q?faom6S/oAzp2hw+wQchtOqZhuinay7lRwQU9tJNomPjuZarbvLb4+/26bKox?=
 =?us-ascii?Q?s7Wt5qMEbCL5yB6Iy7NI4wh2EwsSr+v0VwK2ch2oJWRRm3Oe5N+3uSqAavaP?=
 =?us-ascii?Q?7iOaP1WMJUngT8wlOCn0Gl1/uZqk5M77XnYw+nhyM1ltGbLd5g17o/NrKPUB?=
 =?us-ascii?Q?fMEhVhehGngOK6rYY4FxmDjlUBJcpfV1Dm/BvCJLF9l3NigseW/QdvO59EOn?=
 =?us-ascii?Q?Cp1DAELUlUDgRD/+gJe/OpU+Dd5GnepKw+TO0Hoqz9U20W8+AfsUAQZEYupH?=
 =?us-ascii?Q?K5UQ/UknRCCLg+XVrujoFm9+i5HSbSP+iZG5mYt2mzR2fz7WWBkVuw11o70l?=
 =?us-ascii?Q?DzbnP5pjkP3fktcGgJ78vgxin8hO9fDsqmui3ADRgm0foYTO3Zg4VfbnmLXQ?=
 =?us-ascii?Q?9AwPYsE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C3cKN5EhnCNFGXdSeGdgOLmcYbjk4KRApFjn3guUfWkD/98lz9ol30bT3Kjq?=
 =?us-ascii?Q?gUAxblc19JeGBcHJVdoJCDcb8tmQ7HunKgnNg7+E6hhbby7WIUJkBQvVJFGp?=
 =?us-ascii?Q?w3fIMGtTyR5x75rE4fQJO+z7uy0ukhzNzVPuED+ApmojmBCRls+iuUB816I4?=
 =?us-ascii?Q?bBQlNtapqOPZcxm8+U1vQCydX5FpoiBpJK8oEyCx8yu/8zJkXuKxo9Vmra4q?=
 =?us-ascii?Q?g0LE9EEs5r6HlfO/5H9uoJVLMfVmpI0wV0Wbr/Ceut2CAzJgCHbGmm85e2m3?=
 =?us-ascii?Q?LSa0JiV0mxtJ9RvWdbhitgo1nASRGgakWzQ+mavERH+fO33b5oynKgGGrSc2?=
 =?us-ascii?Q?RPyIqX5OjTBmczaSFPsoDvYGNrUa8zPsIt+d1DbnTAZdSE2WbfJLFh92K5h5?=
 =?us-ascii?Q?RJ7GD0BdM/Ts0i/U5FRJRssOrEHWaN5ziwUGQWtLHxYNfcJcZRfTQXj2jRP6?=
 =?us-ascii?Q?+ZwlYYXCaH9DeXLcQytuSi3iu8AEWLA/FgazdBOY6JFgs7AHv5MQ3SCnn/zN?=
 =?us-ascii?Q?yfFiSaQKOYTKqxtZuNi0GHoQIlWJvNe9w7OUEhkCCekPE08N8/2n7E7/2YZk?=
 =?us-ascii?Q?R9eoE55ijK9Zw7SnuEBcuD/HqL4qxdJUt3ve8NAabt3+VYnfxY8obfNbIsgu?=
 =?us-ascii?Q?1R2mTT2DmyNabelJSo7OGvFJr5EE4lXjrcCO2LTELkooj8nLTiUI9mhUycT1?=
 =?us-ascii?Q?Ne584fL1vPvAtZYYzncRimT7uYkn+xfAVLyAr36gSSc6GUT5KcpjnjsdbQt5?=
 =?us-ascii?Q?iHOlxuQYXCfpuZ5OUOxtNfZqHcMBa3iU3Ok3986eDj0ErKPA/4NBvfOg+hDA?=
 =?us-ascii?Q?owLmOFy1rtb9djW2jKhCo090Js/ygrLU2hXXFS6xvuoOBrPMJgt2TaauR2HH?=
 =?us-ascii?Q?0wKTw9k4fLTKRMkBLbh4p2JnnM9jXNgw7wEIOHvajOzyCuZUA+kBqcU1M20o?=
 =?us-ascii?Q?mbBWUt8s9fb3a3yUpPlvA7IvaYPLfEjQuz2ZDmQDEbh6TYx6gCPggaC/M0Ny?=
 =?us-ascii?Q?bY4hPPGz73c011qPKxjJVwksHJJVOl/mhuQ4D6r/N5qr4Ez+ptxiaulUtrOi?=
 =?us-ascii?Q?lFRnr0ctAdOxyWNR+c1OWkilLBbKwVeMDwutSO150xNydn1Tw48ylbYK0/mt?=
 =?us-ascii?Q?Q3DROE/FEyybk3+LXXHbttEHq9KEsp2iFKGts5iy3Cz674kxtUno/22SfUUc?=
 =?us-ascii?Q?K2S7GCOtonqbvTlgC0LNzze6pf+dwE6L0WjE3Udlnk6UM1csE35ed9slEjZZ?=
 =?us-ascii?Q?hFo/QZp47cNiCuowrXyjqQ5J/2HIUU/BYY0dlge9H61C9KsCM372n/fCblUk?=
 =?us-ascii?Q?ausCd8QlkewhSZqZVugrZ1IBV7DrFx8tuY5ygOoMpky9+/ipgJN6ZMKHPfrK?=
 =?us-ascii?Q?EAnIayEy1Dm0PILl7rgnGdUovaCZMj9FXI5vGq0mTNjvgcicYvyLgWUVyOOr?=
 =?us-ascii?Q?qG5+B4kRT3mbBBOF7AMua4tTOVTLlpH7bfoD80JAy7Pio2Z1jxW4S9HuvKeo?=
 =?us-ascii?Q?DKEV6/yyDcGY2aC82ud+Whlot4W+su8qOLuvI2IrDEiQT19q2b+wx0U1QzlO?=
 =?us-ascii?Q?j4xmj6EyJ2XbLL++bcMv+b8OQ2FacqXgCC2rRzVH0n4Cd2Tmql7i7fMW3mpr?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 390b6bd0-fa5f-4eb7-ed04-08dc949725cf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:46:47.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qw1VXlISFuRm3Nq6buSHqkD7bAlcT5RoAFLoes9+tH9znirq4CtGwjsqUKXTVrqm+DRSM0s6glZKx1Sk12/C7fRfA0M6SsUGZTj3MdfLpBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8658
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Hi Dan,
> 
> I added responses inline below.
> 
> On 6/21/24 14:36, Dan Williams wrote:
> > Terry Bowman wrote:
> >> PCIe port devices are bound to portdrv, the PCIe port bus driver. portdrv
> >> does not implement an AER correctable handler (CE) but does implement the
> >> AER uncorrectable error (UCE). The UCE handler is fairly straightforward
> >> in that it only checks for frozen error state and returns the next step
> >> for recovery accordingly.
> >>
> >> As a result, port devices relying on AER correctable internal errors (CIE)
> >> and AER uncorrectable internal errors (UIE) will not be handled. Note,
> >> the PCIe spec indicates AER CIE/UIE can be used to report implementation
> >> specific errors.[1]
> >>
> >> CXL root ports, CXL downstream switch ports, and CXL upstream switch ports
> >> are examples of devices using the AER CIE/UIE for implementation specific
> >> purposes. These CXL ports use the AER interrupt and AER CIE/UIE status to
> >> report CXL RAS errors.[2]
> >>
> >> Add an atomic notifier to portdrv's CE/UCE handlers. Use the atomic
> >> notifier to report CIE/UIE errors to the registered functions. This will
> >> require adding a CE handler and updating the existing UCE handler.
> >>
> >> For the UCE handler, the CXL spec states UIE errors should return need
> >> reset: "The only method of recovering from an Uncorrectable Internal Error
> >> is reset or hardware replacement."[1]
> >>
> >> [1] PCI6.0 - 6.2.10 Internal Errors
> >> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
> >>              Upstream Switch Ports
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: linux-pci@vger.kernel.org
> >> ---
> >>  drivers/pci/pcie/portdrv.c | 32 ++++++++++++++++++++++++++++++++
> >>  drivers/pci/pcie/portdrv.h |  2 ++
> >>  2 files changed, 34 insertions(+)
> >>
> >> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> >> index 14a4b89a3b83..86d80e0e9606 100644
> >> --- a/drivers/pci/pcie/portdrv.c
> >> +++ b/drivers/pci/pcie/portdrv.c
> >> @@ -37,6 +37,9 @@ struct portdrv_service_data {
> >>  	u32 service;
> >>  };
> >>  
> >> +ATOMIC_NOTIFIER_HEAD(portdrv_aer_internal_err_chain);
> >> +EXPORT_SYMBOL_GPL(portdrv_aer_internal_err_chain);
> >> +
> >>  /**
> >>   * release_pcie_device - free PCI Express port service device structure
> >>   * @dev: Port service device to release
> >> @@ -745,11 +748,39 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
> >>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> >>  					pci_channel_state_t error)
> >>  {
> >> +	if (dev->aer_cap) {
> >> +		u32 status;
> >> +
> >> +		pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_UNCOR_STATUS,
> >> +				      &status);
> >> +
> >> +		if (status & PCI_ERR_UNC_INTN) {
> >> +			atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
> >> +						   AER_FATAL, (void *)dev);
> >> +			return PCI_ERS_RESULT_NEED_RESET;
> >> +		}
> >> +	}
> >> +
> > 
> > Oh, this is a finer grained  / lower-level location than I was
> > expecting. I was expecting that the notifier was just conveying the port
> > interrupt notification to a driver that knew how to take the next step.
> > This pcie_portdrv_error_detected() is a notification that is already
> > "downstream" of the AER notification.
> > 
> 
> My intent was to implement the UIE/CIE "implementation specific" behavior as 
> mentioned in the PCI spec. This included allowing port devices to be notified if 
> needed. This plan is not ideal but works within the PCI portdrv situation
> and before we can introduce a CXL specific portdriver.

...but it really isn't implementation specific behavior like all the
other anonymous internal error cases. This is an open standard
definition that just happens to alias with the PCIe "internal"
notification mechanism.

> 
> > If PCIe does not care about CIE and UIE then don't make it care, but
> > redirect the notifications to the CXL side that may care.
> > 
> > Leave the portdrv handlers PCIe native as much as possible.
> > 
> > Now, I have not thought through the full implications of that
> > suggestion, but for now am reacting to this AER -> PCIe err_handler ->
> > CXL notfier as potentially more awkward than AER -> CXL notifier. It's a
> > separate error handling domain that the PCIe side likely does not want
> > to worry about. PCIe side is only responsible for allowing CXL to
> > register for the notifications beacuse the AER interrupt is shared.
> 
> Hmmm, this sounds like either option#2 or introducing a CXL portdrv service 
> driver. 
> 
> Thanks for the reviews and please let me know which option you 
> would like me to purse.

So after looking at this patchset I think calling the PCIe portdrv error
handler set for anything other than PCIe errors is likely a mistake. The
CXL protocol side of the house can experience errors that have no
relation to errors that PCIe needs to handle or care about.

I am thinking something like cxl_rch_handle_error() becomes
cxl_handle_error() and when that successfully handles the error then no
need to trigger pcie_do_recovery().

pcie_do_recovery() is too tightly scoped to error recovery that is
reasonable for PCIe links. That may not be reasonable to CXL devices
where protocol errors potentially implicate that a system memory
transaction failed. The blast radius of CXL protocol errors are not
constrained to single devices like the PCIe case.

With that change something like a new cxl_do_recovery() can operate on
the cxl_port topology and know that it has exclusive control of the
error handling registers.

