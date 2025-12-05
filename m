Return-Path: <linux-pci+bounces-42672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4600CA5ED9
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 03:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66488312404C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 02:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ABA1EBFE0;
	Fri,  5 Dec 2025 02:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMrdTV6R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12627E0E8;
	Fri,  5 Dec 2025 02:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764902985; cv=fail; b=rcxDLH+qnLHGx23SOJo5/o6NmrozQiu+P+1XXgz0moArxaMT/hH7kHoLTIPtuEr0Zqjs3KzHR8BZKIH8InMSjMnw41M6irkF25dSsi91/DQrtCEZfoEd0+UfafWtz/PwURNHMmokmqAEvMBR6dNYHEMpTfnzyTvgSKE9ajrJqnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764902985; c=relaxed/simple;
	bh=Z7gPOpr/vkL1o2w72pqLL4HH5z9oHhqNU+ZeC6+bbmk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gN9FjbVya+sNP3cDZeXngXB0ynzIXjY/mtSZa73VCuECFol4ddEYYKW2MnTGCq1l1iHm0e/BLER7BpvaITt1gUr+BA3txkA2pjUmPJT3dLVq0RvZlzzZ4hc2eU89c/IJ2uOFwxdDAojCEWAKJliAF2xmWgSNmhUbK1fC8weLFQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMrdTV6R; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764902984; x=1796438984;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z7gPOpr/vkL1o2w72pqLL4HH5z9oHhqNU+ZeC6+bbmk=;
  b=KMrdTV6RWx5SdZoCumKUuIZOI8Ms79zTcD7Uzhgyx+ZugCNigtPGvgWy
   UudgIMdPRYxdie+I3c1IFRPCcs2dPqSAaNQo7AMzl9/vA6xBvXPNoMP+F
   LzroGlEsp8gWeTxScx+etPUmd6SWw+9xVaeF5XxVL3cBikmvNNJKHOiIH
   N0rq/LgmIVJhOkjgWiErQx0G0N1e43n0SS6YsnuB2HrqG2P2Obnm5JTX0
   zLoEJkwGyyFtmzGTj5q6DFPTGLGR2drlwSeISZWyF6VD7a+8gY+37arNJ
   7Th6J5cbw1Cjd8vnIKtppk2UxgCG2kqgyhtrH2eQoNENjWtkScMraDQ0d
   A==;
X-CSE-ConnectionGUID: Pd5w8wwjTM6xXVZirEgk4w==
X-CSE-MsgGUID: CTWHSKiwTr2ds/XcAfNi0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="67011057"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="67011057"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 18:49:43 -0800
X-CSE-ConnectionGUID: G/5SyDxXQae4ejZMXmGStw==
X-CSE-MsgGUID: dPEK2UtmTWueAc4G0Cb7Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="200126080"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 18:49:11 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 18:49:10 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 18:49:10 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.50)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 18:49:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y30tlTNBmT12AMvvyBivR/wzENSpDXrBvcFp0VNAMDgvCFVkGNzcqd1oln4+Th0M6DC+CYvrcjz0JuqMVe7QhdFQwkVYTWgyQ0doxupuMI+ab92bUTnKyAufsbePAQ6khpbPnpjld+sR/c+9DvhFqazxaVpnlAPHKWwtcUPYw9RH0woLKUV6hHDgX2cIWUDyEuUb+epD83Xo92RGlTiG+MAN8GG7uWa/G7adHGAxieBXOZkJdHJetDMM19tDV0YBkyqEtHYAd7N8Lx8/11/wSjucu2FDfD3ZnghE8QY1uczjDv11o8IscpkAh+jaoFKZvxKN5qs/70ObExvt5XsH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1165d4E5wEsj7BG+iK+pR1GlvQa9dgAleAIHqdDURLU=;
 b=Ojx5h3G8deaFHnKsBXiwI9O4w4Jjd8eMm+w/2NxgKBOykPX4NXZUXZghq/cB4D8YC1LhIDsWQ2HdLipukclDv2jLHeRI8CRsHSFwHKUU+le+qB6VxazjJ55bYo2igtJy0V8oFWPovna6gt8bQbJYRDbgpvMbmhhQ98gaHrzOfnxFGaqyGIlYNyD9yw2d4FNt+HrW36yLXLN4OgnNkFDGfByLXJGtXc7hZVkgT6zz038xnVlncEU/KlTgIuZE/X3V1ps5gWHjsBOqdVNQ6MWXt0MQ6/4EddVwELZ1o3kmUfswqNyUM4rs94PxR/u+AU9NismM8pS4Bxomdfj8+1v7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB7991.namprd11.prod.outlook.com (2603:10b6:510:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Fri, 5 Dec
 2025 02:49:08 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 02:49:08 +0000
Date: Thu, 4 Dec 2025 18:49:04 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH 2/6] cxl/mem: Arrange for always-synchronous memdev attach
Message-ID: <aTJIIDzBot05PtD_@aschofie-mobl2.lan>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-3-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204022136.2573521-3-dan.j.williams@intel.com>
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2886a5-ff34-48e8-3f49-08de33a8dcc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wvyrPfjDUNlfE2Sc/lyx8lRJHPeEesGLhCZw/FLrdpFUIlOMyLKUSRBFcD4I?=
 =?us-ascii?Q?OxkcXmuOnXTMPGSIFbEIgkaCgJxRNzxy8MFAINJqhj7SL9v+32s70WfodJyy?=
 =?us-ascii?Q?MQsTbRVkjW9WX10dWJEFhdEpdr1cla20E6Yr1Nn6B/6bMIXC0URZ79i750fg?=
 =?us-ascii?Q?4KvHEOe2rqjGlU4hW3teE0qyYv/hiqWLw12bM+5mlPZyXTBa4vl8/kL5uOSr?=
 =?us-ascii?Q?qfS/Ej9MYawyp2WzO74sRdHtdVXQK0hzghSHxV2eJCPl3aylAymd5PMBVoVw?=
 =?us-ascii?Q?HH42HFqtF9l89fFT9qrICtwYUnv1rZvkwpHo2VEethf4dS4pDAOVLy2UwCo0?=
 =?us-ascii?Q?Au898Xa+6XpWhIcEZHkTX7uRI3BmJk4vSaPCYsyi7WXs4QVdYNXOEDgXvnPg?=
 =?us-ascii?Q?ww+J+AKWW002ETW44wzriEFmM903GbNiECpUnK4KdP5fKNq34c4xDppP4g4N?=
 =?us-ascii?Q?IuLJaPde14F6iFqpZQVIcE0WMpY7HqZ7r5iorDHUqZNMDSArhfI5fkBpYYdS?=
 =?us-ascii?Q?ToQw9TBEuQuFEK87jBkmtL4S5ei+TbOIyFaEhfCy6WGytKd1rCuT/D7NPAv+?=
 =?us-ascii?Q?9GM5f1li8ZQS2dNeYo+e/aEfucENlEBWL3nBU+zY6j73xPEk4Wbt7FqFSAwO?=
 =?us-ascii?Q?y8blPZWKJF9KP9Vqrf+eYTSSTYj1/Eq+jLWlrRQNbC/cEVSEVugHoKOYooPF?=
 =?us-ascii?Q?nUHYfp3K3Vtd1Fb1Wej8P4/A/cQ2qI5moowGdxqHWCDZKf6bnny4DRdq2zUi?=
 =?us-ascii?Q?uipxpnM57XDbhreao2p5YbfZI8+L4iFROpJVqf0lmKrMgB8uMjgOMac6fhjd?=
 =?us-ascii?Q?75IkNzMKEK1ceW/ZTicvyZg1qfMbwyVozm0yuVZ0gVDVJjOiLc7fJwXGoRfw?=
 =?us-ascii?Q?ZIuqHx05k2wyOwA8u3vdFRaKUOSPacVF8KDwD8uro+zkBddSt7jCY+Pa4RbF?=
 =?us-ascii?Q?bPgkDl0LTX0eJwGN7jeC4QTUiFs1qVQ1HTrdO+F5nqw9tHIVJephxvNoYZqv?=
 =?us-ascii?Q?GarnAFTQuZDJ2TzvJr43x2vS/JQomXrgvXAcf/D0hGOccBrd98TSwxeLh7Wv?=
 =?us-ascii?Q?KGjSChvCUDDGywSohPEBPqpRsCJ6KHLQhKG8zG6EEgDmIbXPS8ZU0LuvUFsY?=
 =?us-ascii?Q?WWx4ZST7/Yt+gcxGRA11enUG2wR8mLqJgPSixkJC+qTPe4V5gOX/UDihOgYF?=
 =?us-ascii?Q?j1gt6Eb5CMbr8txidfh/i9J08mf91C+EUjn5yYRQR2bVKUgYVGNbzBEhsixr?=
 =?us-ascii?Q?WLnawtwkWiPPp8PZKqKRKaW9pX2PLHg2rPxs8NSEhZHTbEpUUIpcx+xsQZs9?=
 =?us-ascii?Q?mQ9W0PgdH//2MIO3oe4hkuYJH+9TShzXWNIWCsbhKi67Ca9++0XfR0AOG8/U?=
 =?us-ascii?Q?DZ4wGfGpxKwner8X7c96oPU8wfsVNAj/RF7uy8FxKfCops/5HD3hbrGc6Gey?=
 =?us-ascii?Q?vzxul1kbx9mRBCny6CcpZ4l5y4g1C63Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1I6+8nxz7BtPP/MyP2BaIUgyHshGnfoz5Tw5hf7t8vet9c374XkpPe5MfRko?=
 =?us-ascii?Q?RlUxhG0oQ1DqhrNUZIc1Su0/ux4JCdjPERkBwPNatMCAf4PTRVl9sxr5bNpF?=
 =?us-ascii?Q?i4GjTV+RYaj64ZrS1HxAtH1Xv81oPmJelvxOirXvJpZXjFlqXwoZ4m2Wt4Z8?=
 =?us-ascii?Q?qKKyflDgf5l8X3TTtqHH7ijDH2Wlpky7weK29yv9MxmY/bwSDJ+dayh9upfR?=
 =?us-ascii?Q?QqXmxMb3ozHQafr2fBPtCtFPaMu9KycrtWB84ank0QFJVHlDOgjP/ihdKP4D?=
 =?us-ascii?Q?/SUqQoR72FJhIZ9uvR1/YJnqBpqWmO63+NHGtZkMRGtzaO6c80w2yVWgbK+R?=
 =?us-ascii?Q?N/HldVqqVJ4RSqosKwxF629N9MjWoA0y8BU+4vPRM75OgzGP3JuQycTqLl3O?=
 =?us-ascii?Q?0Sc314IFf6vJxJ7pIq8J/DWDZk1gK4GOdnuoViQZ8TZ+HZePBi+Njc/3fB2A?=
 =?us-ascii?Q?5sjnkMT5bcu1xkO1tUt8TrtMhayxSFsKOSCigpVGVWNgodKA0VPeCheBmHrx?=
 =?us-ascii?Q?j//XDAJSsIw9RA7uDJeB4Sw6O3yhVwkXJhmiyIv4WQme6bMekUH5kgvK4WDq?=
 =?us-ascii?Q?7NYojv+ZAEqSt+HDRhwSbRSZ1AG986dcYT6ESFEe4WNAT617zhbbMeMMuZ6g?=
 =?us-ascii?Q?gPk4Sha3pgpRrV16ceIUzSsCsMi7It0gU6V+QAylodEWVFGM/YUyxJ9kvHq6?=
 =?us-ascii?Q?fBS4hH5raKsobFNupaCz3+K95QsN8Hd5iIIGO2DpN8Y0z3rtT8JluhYwez3f?=
 =?us-ascii?Q?oO8rW/+kiyxhiw3BckXDWfH7WNlYvWveVIr7+iVjLDRfOLpJAIUl9X2hJY1s?=
 =?us-ascii?Q?2GPvU9VN66qxDQ16i+fqvumqTLoeEz5VFe9vZuSJT38J+g66CwOaB2VCrUaS?=
 =?us-ascii?Q?dlo73NhdNaukD/7kbOHoGe6HKSJqARcocXmvuFElogLoojiL0E5eq65dSTf4?=
 =?us-ascii?Q?VANV6vSHi3r/yf93rk0RwhmT8yRPgTlMtIkPclkE5HBles2lDbdbaIKGXH4N?=
 =?us-ascii?Q?FboTp4b8pUlxeITKBGoR6cEaE9kKtMet5RCnu2N1xK/SDlD8WaT+O3pVtQei?=
 =?us-ascii?Q?h1tiTEuyLniy2pkWMosERm9sH2XEZZrqwDqsswh2kZN1idtqbMNXC3KV1w5x?=
 =?us-ascii?Q?jWzyTS3f7YYU2c1kfRHW9Byoh/uv2vMHRiusUwocb5i2lyReJt/jifs1Y+/2?=
 =?us-ascii?Q?lfGUiWZ7eK2Ojns03uNgX2fMvFDgOBwcO0NAtG9aE/QftZZu/EmP0IGGcVwR?=
 =?us-ascii?Q?fFaJHVQ+vNgk0WF9ZCHWhuPGXB2EJSIipqboTodL2dVOtcjPL7+E6n4WJGTH?=
 =?us-ascii?Q?Izl70IvIBmt21JPbpjFtO0g5gBcjj0Yl6yb84evbB58NRD01j5R+uDQ0KPIS?=
 =?us-ascii?Q?FQ7lj3W5SCvfBrPtDmPQf4weY7QSNZgjg3tqetVq7LrGgu2GuICxXvNrOuSC?=
 =?us-ascii?Q?EoAw8vWppL5E6afG67wwltAvxJWcaqGQ+/WIwev7nObEz5OGoMOA/8JEbABJ?=
 =?us-ascii?Q?OI+ia4P+Ep82408mZCUTmwkcDQ2EvLnMzLFgaNmbnBs0j/9npomKqhQKu8lt?=
 =?us-ascii?Q?OW4M7c5wRRAmGLfxnUP4i+YEqdRbtkXX1pFJmuGe0LVwpz6imi/raVMcFX1Z?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2886a5-ff34-48e8-3f49-08de33a8dcc1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 02:49:08.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 991UEx3lbxWb7DE7zRnV07kIaA5pq5/XWDGuimrHy2QyjOQpCHuA5KI2uVxzqSfSDKuM4r98wawLz0fxhJAWBrIvqaB2a4476ywwqd6WBkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7991
X-OriginatorOrg: intel.com

On Wed, Dec 03, 2025 at 06:21:32PM -0800, Dan Williams wrote:
> In preparation for CXL accelerator drivers that have a hard dependency on
> CXL capability initialization, arrange for cxl_mem_probe() to always run
> synchronous with the device_add() of cxl_memdev instances. I.e.
> cxl_mem_driver registration is always complete before the first memdev
> creation event.
> 
> At present, cxl_pci does not care about the attach state of the cxl_memdev
> because all generic memory expansion functionality can be handled by the
> cxl_core. For accelerators, however, that driver needs to perform driver
> specific initialization if CXL is available, or execute a fallback to PCIe
> only operation.
> 
> This synchronous attach guarantee is also needed for Soft Reserve Recovery,
> which is an effort that needs to assert that devices have had a chance to
> attach before making a go / no-go decision on proceeding with CXL subsystem
> initialization.
> 
> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
> loading as one reason that a memdev may not be attached upon return from
> devm_cxl_add_memdev().
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I did test w this set as a whole, but only giving the Tested-by Tag
to ones exercised in my testing

Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>



