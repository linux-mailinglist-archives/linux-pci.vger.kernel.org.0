Return-Path: <linux-pci+bounces-7362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E48AC8C25D7
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 15:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525A2B21037
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2327E583;
	Fri, 10 May 2024 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5rhI2s/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45B5339E
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347999; cv=fail; b=YPqh77yMKgZmMXMYPyn0BysHvm0gGiV2+D8lQ7d2tQuGbfHhfN1SAoz0c/I5w1UyuHRuw7SLMarHqVQiclpDgyEpzV/4+zbATl4Z2mtSdJbBTKjLbjXFGLXWzP9gnE91kOFv8gPHEFeSqEDxnPEHm8QYhGXWp3gpgNLZrnjheU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347999; c=relaxed/simple;
	bh=UA+FSuSgO1IpcATshe/XviAYAe8wfLBjAos3wxUuccU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BQNWqm4U2bGngsuTxJcAKKw9RUivmFr0yygab4kHwS0dodq+AGW/9pYYEuOAR/M4B8mpFfnz24sylmjNhEmdjvW3bPj9K4gHgHc5WpmplBM7RnJfakyxTbOM6eLrRl+CdZwvLkatYC2UicypANGV+PWJeG9EzLcV58//0UhKFXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5rhI2s/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715347997; x=1746883997;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UA+FSuSgO1IpcATshe/XviAYAe8wfLBjAos3wxUuccU=;
  b=V5rhI2s/tVz6br36eD1Ygr6qHOPb2mBZrWeSTvPFxJ9hSJY3R0jii0wp
   T+ceWgdUeua9Rqsn+9J5JWJhSmEgZA8pYCRxE98Ma3vWWlaVe2Jtygb0G
   egehxMh4TeXFPlDQ+TYNVO1VnLYwfs0n+l3cs+Q0eRPh5sTp8c2pByGBa
   ODvMzOtoKRPN6stTKBriIdjmx+OAgiedhgu5SuNYTkkxwdwFXth842qgI
   BFM6Hc3MVvPW+LBKH2/h4KC0g652baFqXwYBZ9+O2elhOcKhPGX8LdTSp
   Yau9IspGsPF+ER6gXMUyfzcBiqVg8aumnjEvEKXlOLhBrF5iG2L5mKadl
   w==;
X-CSE-ConnectionGUID: rhxpaV7qRSSc19gWE61ikg==
X-CSE-MsgGUID: PAiRQcg7Sv6ZN3ZIB80/7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11490934"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11490934"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:33:16 -0700
X-CSE-ConnectionGUID: +m2P4acETnm2sBaO9uGBiQ==
X-CSE-MsgGUID: B/CggSNKSpKlK/Az5TDFow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30170306"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 06:33:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:33:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:33:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 06:33:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 06:33:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THUweLEpt5uY5PUewhaV1cTLPlftC/4VXxeEoe2Er3EMOCFDPnA/bHwLHcTO9fwC/VBtzwZ7/gws5LcxW1hYvin6v29uN4bQXdh7R++Aeq2mRtZX0z4ZIneRESrlhB5VoYNPZ4AynH98u2h1ROsGQjyLt/niEa4xuJ67yo++eJNRt78XWSeC6UkqvxXJ8zB1wa09mzHVGNthXKZItfiiQ5ApGvrkeh8dDrsot0Kt3UyT1WT/wtKhf/jPfN1/VW4gI2FxSN22//ekXPQXxuDlVgHJTgsePROasZBWUHLNKxSrao58ERCeEMKZQ14YKidfEmkJsmm3H2IoegB497l9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8us/cCs2wFsxLKfcXkdHOjRJ21VGdIGxAl6Wzaeuf4=;
 b=Ou7inNIlKNS7Pp6uRL8wY72oGSD8HfYZfd9tZ3o9ApvUyH8m7hzEdCaI7JIGVpnuSM1/Q/IdUnr2LSUyXj2RLrGzUmr0P3Eh6zIvmskYxNpv5UkNJAlZjLzUmbl9jflKNhz2F+2MwQR4qk/I3h3pNu2PVpW6xvZnMnmDrTSDx90m0lN+LnCJbQlHEb2NpQpZ+uAMADi8B9VbfZzncq+/FZWKs5v9VHOew2Yss20yxGyLekPc6t9a/ujZswOGHcMbPd3a2k84xcEN04ofEfigbr3GJwk6W8GrDjbE1bb8LmOYqdoh1iFWkF6Rx5tGSgs2vq63cfwyg3Rg5ARX7nnyrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by BL3PR11MB6386.namprd11.prod.outlook.com (2603:10b6:208:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:33:13 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 13:33:13 +0000
Date: Fri, 10 May 2024 09:33:08 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 7/8] drm/i915/pciids: remove 12 from INTEL_TGL_IDS()
Message-ID: <Zj4iFDXSriO9HaxI@intel.com>
References: <cover.1715340032.git.jani.nikula@intel.com>
 <044a5c553dc4564431bbef197d5e2dd085624fc2.1715340032.git.jani.nikula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <044a5c553dc4564431bbef197d5e2dd085624fc2.1715340032.git.jani.nikula@intel.com>
X-ClientProxiedBy: MW4PR04CA0343.namprd04.prod.outlook.com
 (2603:10b6:303:8a::18) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|BL3PR11MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe8f415-7f2f-4cd1-8d4b-08dc70f5bdc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e0MOI9uW7bAUvLxF2S7q8+GEmpdB4fzzbXfLuP26hfBnrmZWDaqAiEdbPhBt?=
 =?us-ascii?Q?VpXLvyZjXdF0wy/s5SdRc9Tgw2egZM10FboRii/IOOAcfEaCu8HUCW2nCKnG?=
 =?us-ascii?Q?07u1tYrFpJUjWpJlk6pfEdDdLfeAP/6ct69hzuAn6p2bvn6xnONNYoAkVQl2?=
 =?us-ascii?Q?KTs75iLk5HuuLtn1CsTRxkLvl3CmibulrdsJr8ykgwgYYMWRJQU73E5nwCIC?=
 =?us-ascii?Q?QQ0FhlxLMjsCY1b5ymp3q6qdOEp2jlOLLyF7AsdFtzBTHzuuhCYD999bBReF?=
 =?us-ascii?Q?0VlwBWwtJb20hoMug2zqPYTvhVy4LHBln+Cyr1QqghviNi2+7ZOcx8796deU?=
 =?us-ascii?Q?XOiUYVQQ929jS9sdUnkqBf6PLxgqUxwk/dLPs726kHjDY7SKMEtEATtb/BKl?=
 =?us-ascii?Q?jFMDiZLNtHH1HjbSka1W9VA5I9VofCH2Cix7TmXG28nyFYUu3vADgT6vng+U?=
 =?us-ascii?Q?O/84uRzSmG9BtLPS/S3FkmuWNq24WdbHJEsoTDawAB/aboeLh3TJZH6Vz8Td?=
 =?us-ascii?Q?OlrjgqpY/z+xqfm9r+QIeMTw7WWq/cFFi2NibofHGh4FLp9r24AfdQa1vq4c?=
 =?us-ascii?Q?QYkS7BzuLumAhw+HZvM/gJxDhceFVzVxfAXdBG7zH9vnkgAYlcpyoQSZY8EI?=
 =?us-ascii?Q?RUhIllVgib+tSKKh8KqKqOx4GUpVpNIqYY75V/h36iBhT3znGCls3YPM4PdK?=
 =?us-ascii?Q?LCwBC2kf7I/aB/L7EYmzh/KeB4LvyWmb59eKds5URhNRFPzhlVwKLcCvc3MO?=
 =?us-ascii?Q?W0McZKiQV8NhyzaD0K0Uo45lrZFWZYnfhJf6CzEQ0emxSRQeFtpVGzinDbXi?=
 =?us-ascii?Q?sFlSm5glXmxtwjYgDJ0vKABMJV1NPB9QD0Kyo/29CpzqHSbawqNCp8fQg6kD?=
 =?us-ascii?Q?ESn4j4bAR+jFNl8VFV1EcB8Fb4N7h24JsPQ+jAmM2LYEg0Ryf6F0VnXKatQF?=
 =?us-ascii?Q?DBjDXM9SO39XIK1O8+ZIJetWcH3dXV7ACL+f4x1wHg057LOXQlrtKooE+D8P?=
 =?us-ascii?Q?8oNs/E9M/HArT/x9PhBsExEkTIpG6nM1kmGmMQ8Vtz2SUVbdCtr8kemxWgm3?=
 =?us-ascii?Q?UvQiwKDP8LzQMVSaTVK15XPhTyz4loDKLHHk0kTJQqMmuJe/8wigUejI2FQc?=
 =?us-ascii?Q?Yv5sltTjVwDRvKAMjO4HzdMcXR0YreXg3vJp/ezCeB+q2d9QmGHfkq8nOJwI?=
 =?us-ascii?Q?Noy0wLcIrLwjLAX0ZfPZqc3hbl7jzWD8KbzL5PQzFEJaCsQYyhUtI/LlnaqD?=
 =?us-ascii?Q?6AB5IMqurmMUM5QNwOOg6+LM4DM/UNdlAjxE6Ugu4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4xJvfz5q2xVzCz5nyfhX6ScqTbTi24Q7avkAKIOt8+w3PcOJueVQVX/KKUas?=
 =?us-ascii?Q?M28bFwXxWRx9OmqEPCec+aXXMa9G3hO8bEgg1Nt0c6sS/ImDGYg3aIPfi+li?=
 =?us-ascii?Q?vJCr9wSGiKugvUS24vwosneu0It9S2N8u3WBFL/RjyYrisdUL+MNLcA0nU+A?=
 =?us-ascii?Q?HH3h15gLNgavTVyhjivDsa40NzTQ5EVwU2Lk76CPESxbas4HvJUXWiobP8y5?=
 =?us-ascii?Q?7apmE2MHEPRyEuLeGyzfInKvH7YggL2dkLi2+NRdzOIdwkhS/CHOF7CY/N/E?=
 =?us-ascii?Q?4a+vGyRmwSLD1jDASj1fcQJk2tzD4R6l1x4JWGWOxGnf/c9ZKxFSZOr0C2ZU?=
 =?us-ascii?Q?ExfEwhr8FN9O/KyB4c7TRekhwqly8MQaPZAdTmETL0wfdCWJv1IGy3dPYcLs?=
 =?us-ascii?Q?AZugnBRE3B8moPDXQGwxrElUSkPJxlRl6uQH50qaM0nKscE5ZhGmNqo+pxdl?=
 =?us-ascii?Q?jdxiBDLE6+C8DEBRcZm/1ftUFzGD6tmXbenBinAKatddWsGup2EQQVKwAc8x?=
 =?us-ascii?Q?rwCqOqvP8i9wnJmo8aX1cKG8IR01JdW85K7GfCyleQuv6Hd3a0eu+WMSGfHC?=
 =?us-ascii?Q?aotB+OOFlRQ8hG0szRzD0isNfxgizu28LmAOvpyPhEaYBc9Qb+VQfQrhorox?=
 =?us-ascii?Q?lBfTDOPxQ8syFcurg9T8Lf45A/hETtBl9rZLoayOAj1W/Dj4GKiL6ntxxbR5?=
 =?us-ascii?Q?xGoU8ijaCUuVsyQE+UQiUOz/tx23Jf36I+iGb6BUPK/NSBXW2fRxDtU4x/sj?=
 =?us-ascii?Q?oG+SLLfOFmAwN23SZUnDfHszK47FOb9yj5wKgUaU0BNQ7fCL4JigWgmt3Ej9?=
 =?us-ascii?Q?vE5FVkKU0DJpRegvr4AlYxS/4Vo8vHawvfyiQXBhktfOmXmkvPg1b10ou5fM?=
 =?us-ascii?Q?9L54rmRUkN8ndRUa3OBsa4hOqu3vuDrx07PdKBYXBra6XCTiJEc90/t4S5zX?=
 =?us-ascii?Q?QJlrKSF+S9uO8PgkR2gBcnZwROC2XXMCva6wQs8XoUjwkRDko3QlpAV3Ov1V?=
 =?us-ascii?Q?IetBfDKY8tptupnXZRLAXrwjN9xiG6k7mZNr2qJk59X+IePeqWwWRXmfSJ1g?=
 =?us-ascii?Q?akWCwxjsKx66iWvE2t3e7gymyK8EXqRGqCPcz08r5dsHXuMTJH5suFZFf+MY?=
 =?us-ascii?Q?DDOiwx7dwaWRsGr2XrLiXZC0vm36iBpejDkAVOsKKLAZM/iKmvVSAvs8lpYJ?=
 =?us-ascii?Q?tnBpYF0ZRJQOFibSvHBCvHiVvXkP0UZepw4HpoKNH5ApkCQ86/iEO1D/8tcF?=
 =?us-ascii?Q?37d532aOHT2NtiVWU45jwwUMi6fg13tT/CPYMSt/bF8opdDvFaHS/FnpRewp?=
 =?us-ascii?Q?pW+vlR8O8s2VM+bad1Zdyb/DCvCLgjwRAeEok9ZvyE4Php7FepPg9x+bo+a6?=
 =?us-ascii?Q?04meAkffTDcWV8tlZspF2BAzGo9T01WeFgV7O+6jfgz6KpjwkB0XGHMQn1AC?=
 =?us-ascii?Q?BMxdat51FLJp4apRymqB8e5TNzH+A74E1sJ7SXaatWpO40KDcw6JnyBRTuBC?=
 =?us-ascii?Q?Folx8tSKeIC1jukZ0XWOBS1p/UlynqUFIdSm72xP7tauTK32JlRqgx8/BI2W?=
 =?us-ascii?Q?LnS+yDU2zclrRlmfxmmjqgHdUURhtLwiDVeEXUGdHNf6OsAxT5lLYO+cKVZk?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe8f415-7f2f-4cd1-8d4b-08dc70f5bdc7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:33:13.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIJIlaVbm1OD0J6rbPDi7Q/OCT6Bx7KQg3LPGirA0yk/C5eTJnlF3hrSCxAYZPH49q2s129Z9fy4neDSloJAMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6386
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 02:22:20PM +0300, Jani Nikula wrote:
> Most other PCI ID macros do not encode the gen in the name. Follow suit
> for TGL.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  arch/x86/kernel/early-quirks.c                      |  2 +-
>  drivers/gpu/drm/i915/display/intel_display_device.c |  2 +-
>  drivers/gpu/drm/i915/i915_pci.c                     |  2 +-
>  drivers/gpu/drm/i915/intel_device_info.c            |  2 +-
>  include/drm/i915_pciids.h                           | 10 +++++-----
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index c150bb6f1a39..b2b9cc3b9545 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -550,7 +550,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>  	INTEL_ICL_IDS(&gen11_early_ops),
>  	INTEL_EHL_IDS(&gen11_early_ops),
>  	INTEL_JSL_IDS(&gen11_early_ops),
> -	INTEL_TGL_12_IDS(&gen11_early_ops),
> +	INTEL_TGL_IDS(&gen11_early_ops),
>  	INTEL_RKL_IDS(&gen11_early_ops),
>  	INTEL_ADLS_IDS(&gen11_early_ops),
>  	INTEL_ADLP_IDS(&gen11_early_ops),
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index e47896002c13..fb4c4054207e 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -834,7 +834,7 @@ static const struct {
>  	INTEL_ICL_IDS(&icl_display),
>  	INTEL_EHL_IDS(&jsl_ehl_display),
>  	INTEL_JSL_IDS(&jsl_ehl_display),
> -	INTEL_TGL_12_IDS(&tgl_display),
> +	INTEL_TGL_IDS(&tgl_display),
>  	INTEL_DG1_IDS(&dg1_display),
>  	INTEL_RKL_IDS(&rkl_display),
>  	INTEL_ADLS_IDS(&adl_s_display),
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index 06b1d50ae47c..fa56113ed1ce 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -860,7 +860,7 @@ static const struct pci_device_id pciidlist[] = {
>  	INTEL_ICL_IDS(&icl_info),
>  	INTEL_EHL_IDS(&ehl_info),
>  	INTEL_JSL_IDS(&jsl_info),
> -	INTEL_TGL_12_IDS(&tgl_info),
> +	INTEL_TGL_IDS(&tgl_info),
>  	INTEL_RKL_IDS(&rkl_info),
>  	INTEL_ADLS_IDS(&adl_s_info),
>  	INTEL_ADLP_IDS(&adl_p_info),
> diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
> index a0a43ea07f11..64651a54a245 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.c
> +++ b/drivers/gpu/drm/i915/intel_device_info.c
> @@ -173,7 +173,7 @@ static const u16 subplatform_portf_ids[] = {
>  };
>  
>  static const u16 subplatform_uy_ids[] = {
> -	INTEL_TGL_12_GT2_IDS(0),
> +	INTEL_TGL_GT2_IDS(0),
>  };
>  
>  static const u16 subplatform_n_ids[] = {
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index ecfd7f71e2e7..42913d2eb655 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -620,12 +620,12 @@
>  	INTEL_VGA_DEVICE(0x4E71, info)
>  
>  /* TGL */
> -#define INTEL_TGL_12_GT1_IDS(info) \
> +#define INTEL_TGL_GT1_IDS(info) \
>  	INTEL_VGA_DEVICE(0x9A60, info), \
>  	INTEL_VGA_DEVICE(0x9A68, info), \
>  	INTEL_VGA_DEVICE(0x9A70, info)
>  
> -#define INTEL_TGL_12_GT2_IDS(info) \
> +#define INTEL_TGL_GT2_IDS(info) \
>  	INTEL_VGA_DEVICE(0x9A40, info), \
>  	INTEL_VGA_DEVICE(0x9A49, info), \
>  	INTEL_VGA_DEVICE(0x9A59, info), \
> @@ -635,9 +635,9 @@
>  	INTEL_VGA_DEVICE(0x9AD9, info), \
>  	INTEL_VGA_DEVICE(0x9AF8, info)
>  
> -#define INTEL_TGL_12_IDS(info) \
> -	INTEL_TGL_12_GT1_IDS(info), \
> -	INTEL_TGL_12_GT2_IDS(info)
> +#define INTEL_TGL_IDS(info) \
> +	INTEL_TGL_GT1_IDS(info), \
> +	INTEL_TGL_GT2_IDS(info)
>  
>  /* RKL */
>  #define INTEL_RKL_IDS(info) \
> -- 
> 2.39.2
> 

