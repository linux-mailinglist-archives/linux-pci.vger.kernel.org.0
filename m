Return-Path: <linux-pci+bounces-32434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14198B093FB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EB618879D6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51193209F5A;
	Thu, 17 Jul 2025 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPOfPwK9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3020ED;
	Thu, 17 Jul 2025 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777256; cv=fail; b=kR7PWolLMEFEFBaHV5gcQHsZWCREvkFEFpEIRp/JLMcp/GxuQerGQ+I0iCukNCJYv8D6fdOsDW/MSGkVyofWOL8RDRu6Oh6I4+go8lXn+YbjSWpAfM9Kd2ycctQmfVAm/p5NTq2jPlbyDHB1Kzy9yyjwLWHj+YlAboebQdyBDII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777256; c=relaxed/simple;
	bh=z3HqKNswQOXo/dVVRa+09npNML6gvL6sJRDbj9Jf9Bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t03Cqa6RTn5mCI86Pc+AsKjUa8rcRCTBk3ooAL7QcdphMuPsZX2NCZA2dRw9QbSeu8Xv7yDubcD+cPSDdlTgxWL4ekon9V0QMEyldYEQ8WWB7z+ydEx6gm/NSNyt6qhxrGZWRJYyjvs9eSR0wqnH+4OwaeJcR2tXOqT5hQ/YFjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPOfPwK9; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777255; x=1784313255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=z3HqKNswQOXo/dVVRa+09npNML6gvL6sJRDbj9Jf9Bo=;
  b=lPOfPwK9Tgy2IWY2eSz5yGfASvJwGOleLH5VbyTpeknpS104izzCL9wR
   c0FWzoTLBtbYvvhNWzjiglfWX3yHj9iu0AoKFxAr3Q3fOQVDMYS2j6reK
   hbMpzHnLZPoWFWyUMkDk4CuW6jYEtaZDHG0SmMp95B4CyGpt0Nw/1VxkL
   N+1iUUgQ8mvh9IYvRywfKPprt/C7/rNbDQ78PC7T2lyVMYMkY7KjaHar0
   FKaYPGV4ajWsK9ylPWpkaFpxU5WamJhMPjaEJQYkZEgWjU+1D6Vo8U3nA
   /NF0vufii+xPlHaaRg0g+xaflzEsxgR3B7lOEpI24dMBxt2s6mrhat9iR
   g==;
X-CSE-ConnectionGUID: LncdcJMpTkeuC2Iu4E96+g==
X-CSE-MsgGUID: uJd0Yux/RzWocV6RuGmYmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54924062"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54924062"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:13 -0700
X-CSE-ConnectionGUID: pvM29X/TTl2f7HmoLZXGPg==
X-CSE-MsgGUID: YpkYFz4nTKSW6s9FfWOOXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157254613"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:34:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcpyf0kh6kqhC5pjsaq6bLUfGeIzGI4xSreE6BBIM8VEOqTWUCynXPzppalpx4vQP9CDlgnCaWdKAkqX41Sg4KH8+3fMUZ1NyJgIeSj5NfZGnve4VdDAQHuud+I/tOF+5D7stKmIZlbaAYWAchB917eRXaQ9tvf+YGC4Ji0bBCgOtfOdM1QplBCW9mPoBPQ/aiZ2w2iXn6cggoAFUofNHSeMl/ktimAKTC2TmjSx7d3ALwbegblBs1UCTur1f1Q4Z3jFTysX0Vp+UBF/gFXq+V5FaFxrEtiG4g7sCEbryeCpuWe2tYhrp1DnJvEHh1u5GotUNZM0PjcjdR+9quUTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbWEZQTmr3QiLm/0ySTcCEK/GVJAIf1o58ex6NKvEME=;
 b=fCNdCn8UQZxJRuX7tv4++XRXrylsL1/xuL/l4EcEVY3QZ8dpeGUhF+LWFGbz/egBxRXsSNm/ochmDQNTE84nAKizHclc8g3tf+qxy7Q33WlyrAGvaMUqNI3V0/i2YTGnMztnvh9nGEXlYouc3rrR3wFXvYs96gf26DltkOyu5Xm5CghEDzwEA1hRhYidP2gr/IBv6bmRkidgKCUGtux+9fsG+r/KloqcS4yiuPvE4B/XbiFAj8/DLT0VO1yLvfkPbFGyG53yuAUASZqaNlO0PgQ1FbLbqOX2KIjYG4lMFLCsnocjyMyD1WcdCY12TQqxr0VXKi2v2GZv1Cuc1gp7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:34:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 18:34:04 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Yilun Xu <yilun.xu@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Subject: [PATCH v4 02/10] PCI/IDE: Enumerate Selective Stream IDE capabilities
Date: Thu, 17 Jul 2025 11:33:50 -0700
Message-ID: <20250717183358.1332417-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717183358.1332417-1-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 114ef056-c5df-4188-ba13-08ddc56081bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XdyAGlCHRetNOzdIP13i4lyO/zNhjWFcB5ApDFKeBFpoD/4N+T35AoU0/y9u?=
 =?us-ascii?Q?5WEm0FKZf9OjQipg0RDRWZFCJSbgR7b+5x7X2cUBc30oJIPotx+RWtn8rfry?=
 =?us-ascii?Q?qosleMtcrieyzGoXCEAezJV3W6B7JQcQ2KZeBDd1nnm80f6Ad7GJsx5ZwQyr?=
 =?us-ascii?Q?NugfgInPCNaliO/SRwwzAOZlPZKbUVpMR9lX10l60QyZVLPgFcgyhOr4P12G?=
 =?us-ascii?Q?IeWxm6n/Ux9boX1LKTMPTGCavwCrwC+2sFJfJ9mKBqQu1hh0oja5Owegew7M?=
 =?us-ascii?Q?JLDhq/1eRO3M3ozrfodwObm6hHC9M8ClwEfTX+Hpbg4+AXWk+dwbzqsTBNyp?=
 =?us-ascii?Q?R10TZkych7myCccXDZbt8JIN7acymaXHW0v+XaENIjpGtlN0K8iO4CmgIexX?=
 =?us-ascii?Q?xELUEtFuiQBy0PBOmh49OgJg/SiIt6fLBcGnMJlPU6pv0wovrdnhmRaAsGJF?=
 =?us-ascii?Q?kJQoBP7ayac7d9AnHSJl5CiQJ2PMgqIqT3rRtlDuMDoXq6TD7Ih4iLws0i7B?=
 =?us-ascii?Q?G824RbLsY39SpH1QvygetpdObzwoYKy/XSkQ4B5cCbTwwLzJZ8IF5r9SG8Qb?=
 =?us-ascii?Q?5QbR9sP5lm/yD1OQbo2jpIreFQOHyB3cgG7a+p+0TDBhKRmwOQ5roU/W0/Py?=
 =?us-ascii?Q?/bDqQDmXyxAUBNwQY+6o7R4RtmshHL6qm7fNb8k1ULEbmq9vIgPd2JJvS8VK?=
 =?us-ascii?Q?jx25HXbdGNZA7pTEYs2SLSTJRkAemAXmB7dDhhlVcaRLPT3uLj9MudEeP61B?=
 =?us-ascii?Q?oUBHmIap/Wzcik3i4H6AtCUMA0eTN1Yr/ttu0cL343ysFlaTU2JPOpoToo5z?=
 =?us-ascii?Q?HNRV2mQTHnMg/5l8BuUgxD8T2NE3/0Gt/tMuqFl8w6Pd/2cV/xvh8C0ipIpM?=
 =?us-ascii?Q?COJAnrbR0Rk9P9fGfIFGhnq5jVhwJQPEdqR+dQGe5m7608Dh4lfl6UJjwwPs?=
 =?us-ascii?Q?To8gXvdq7J5+Jn0COhExz8Bc+A89CIU5tj0yA65E9KeRbLhjODq+aDH6P9cc?=
 =?us-ascii?Q?YV9TvfcqV2lcS66cjey21aNSgcGqFQzcgQGbIpVZECxR3Zy2suxEqFmKDe5Z?=
 =?us-ascii?Q?9P3ayVEJoxpN77J0FCDCbM5NNnbvostBpFV+bnrYWspGMQmdAB2qhafCo1S+?=
 =?us-ascii?Q?P8YaHP/uGJgIZeq/WmQjQGlmZJHwm7h6juBafQAVHQwQCy+2e/njs/hFholp?=
 =?us-ascii?Q?gpSGcrLBo2a3zGNfJZhvlB5TFbKDpUYjKOao3MNzk+Ms0CtgENGw/HPp+X3D?=
 =?us-ascii?Q?xftOP6Xlrn+mpvpGKpd1fXRx+ObPIT2RgZex9EQinhME2w4nyo602Pnos4WH?=
 =?us-ascii?Q?RpIK6LGVous1V4FzB79ZRkpHgJoG+hrL0CPGr73MmbZ9HgeWNjg5vQzJ/F9m?=
 =?us-ascii?Q?WgV12fq0CoqbUSpmrodY+94PLgnk7zpwLMKUh82ecE549MjIXKCZ7iN9Wsku?=
 =?us-ascii?Q?LhbxB2H7sWU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aoga1Tl7DERMwEKUkp20R8q6PPhjx3ffM75Gph+HdIdShipF6s7C35k8OD5v?=
 =?us-ascii?Q?KDspj+mB1YI23ffpsTiz62uSmoL/ZR2LwGXK0t+1gPvM+C7HfievqKH18eDp?=
 =?us-ascii?Q?+xok+Qsjtz9kO2JJpF8a3HQ4EXbAQKrclfOi70ChxCJfYoyBB9vq02fCLcDO?=
 =?us-ascii?Q?7GBXJc96oGFZQcdlDkfXyY1Uk9aBcl+hSSQ9nwK5bm4uALqn8whUblRVZB6l?=
 =?us-ascii?Q?y4ms8d6hunyw+Tndy3wkvs6qrPZ4kekAFt+ZrDnDM6cQy5h7psdfjDeht3Aj?=
 =?us-ascii?Q?2F5c8qMq/fsjhLEAPYyiquYf+XJNY+nCszriU1t/VRmjSXu04HHA+IFLEtiM?=
 =?us-ascii?Q?oNOZAMo38i/lgG7pZVRV+tX3sLbxq0l+YvI4E1ygi7jBiw6yX7ngxc4ieaKT?=
 =?us-ascii?Q?jmOBJl682ay3b9BmFU8i2CVveqIbXJb9tbeIRiwG0iN3crSi0Y4pF8ev+5uK?=
 =?us-ascii?Q?rSpM3xMPcRhcU6BcbD+wnzb3VLJOW5JEnU6uVYE3ARXXb77HQKMfM1ve6iXV?=
 =?us-ascii?Q?2VBGaviN3zFhOsRJInK68j0K89cu8JE9dFP0UqXD5V7aCfE5ieEl643+Ucky?=
 =?us-ascii?Q?0bQtdfCzozWaxt5+IfeSsEJdR27OhWkrEPwe2jNtsu/wRrwIIIJaw2qic66I?=
 =?us-ascii?Q?xtCrAFNxGujXhYhG/yEopgq2/7fW29O6dh9ZCOa8eqA3b1zO1Lblmu8TnP6M?=
 =?us-ascii?Q?scusHKFcn4hSqrCE7Up2huloHXX2/zGKTvhSQalNumeD+lFlo9hv6iXXFoUw?=
 =?us-ascii?Q?X+fUwV/FIY3+dOhYKQ2SkHnPqYhhE8yHtBPDNdsW+Rl2EGzZWJGP9Q5QOCn5?=
 =?us-ascii?Q?OFt1rkrS+xuKuYnDKVkXied5XpdAWtKPov5HdrZZxh3XXXoG6idipThDeofM?=
 =?us-ascii?Q?mGthG1hKsUF82KqBglHIGt8PRKzjnpg8JXByU1uJ6aLrjiG3P7E//Emro4nH?=
 =?us-ascii?Q?sVTp/+yXI69fwo/p5zQ/v8ekilfYUe8qYVtQLW79HNl+8eCjWL8wrXnELWUZ?=
 =?us-ascii?Q?sW2G6NoHGKJNP0Vci24KS343valHb/vke34bNdDoa2GFwanE7Z4TZTyxE8r1?=
 =?us-ascii?Q?srKligmFVLZhhye9ZXxKfK3WpPVeiqiLC7HEi5rmlw77uru5TuH4qiAM5YH2?=
 =?us-ascii?Q?2pPcSIG3tSqHYqGuqEVoi37GIl44t3tlx7ZX4krkVEko26V8ueT3qrIp967C?=
 =?us-ascii?Q?6Onc8MYmq/p8WGZrH85iwPhz/QDi5gOgfy2bw/18ox5qaoGLxMP2xT1PitkW?=
 =?us-ascii?Q?IXlOheyj6nY5f3I1pB3plWZi2ZikS3If1eFJuEWcULdAKYZ0RzN5fdfmOsvp?=
 =?us-ascii?Q?1eZTplBEuK04qBoJ3fi1O3zKnT0cZl98of6GDyy72kg1G40+erbWlHebOHSR?=
 =?us-ascii?Q?SkYa9+Ie5cw+bLC8W4dah+xdDPuDJkTvd2OYUjpHS2uskdAEIezJH8ltaEAM?=
 =?us-ascii?Q?RGONqJW3dMUUoD/fLQdFDcIBkAT22wy+tUPR3UEYQDdQkRuBH6FDLn/jXt9n?=
 =?us-ascii?Q?wPLN1uyDW8YCjNN7WMGHb/YpaLI5roJSjBOGDXVGIHt1QmcvrzJUni/WV20s?=
 =?us-ascii?Q?z11JQE3LtNUbRR5sKnt43xtG/0xdyplkrawZUo/WAdCC54cXga34Ri0vdzDt?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 114ef056-c5df-4188-ba13-08ddc56081bf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:04.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzxrEsKutAMORzQmTjHwu9VPVyrEljG65c+pw5TCgwmSViJSAe/p6GQ1a8iMM+viqWkR0mdlUOBqbxH7zuL0GMftqYP4JK+zosx/7mnTwms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com

Link encryption is a new PCIe feature enumerated by "PCIe 6.2 section
7.9.26 IDE Extended Capability".

It is both a standalone port + endpoint capability, and a building block
for the security protocol defined by "PCIe 6.2 section 11 TEE Device
Interface Security Protocol (TDISP)". That protocol coordinates device
security setup between a platform TSM (TEE Security Manager) and a
device DSM (Device Security Manager). While the platform TSM can
allocate resources like Stream ID and manage keys, it still requires
system software to manage the IDE capability register block.

Add register definitions and basic enumeration in preparation for
Selective IDE Stream establishment. A follow on change selects the new
CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
both a point-to-point "Link Stream" and a Root Port to endpoint
"Selective Stream", only "Selective Stream" is considered for Linux as
that is the predominant mode expected by Trusted Execution Environment
Security Managers (TSMs), and it is the security model that limits the
number of PCI components within the TCB in a PCIe topology with
switches.

Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Co-developed-by: Yilun Xu <yilun.xu@intel.com>
Signed-off-by: Yilun Xu <yilun.xu@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/Kconfig           | 14 ++++++
 drivers/pci/Makefile          |  1 +
 drivers/pci/ide.c             | 93 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  6 +++
 drivers/pci/probe.c           |  1 +
 include/linux/pci.h           |  7 +++
 include/uapi/linux/pci_regs.h | 81 ++++++++++++++++++++++++++++++
 7 files changed, 203 insertions(+)
 create mode 100644 drivers/pci/ide.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9c0e4aaf4e8c..4bd75d8b9b86 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -122,6 +122,20 @@ config XEN_PCIDEV_FRONTEND
 config PCI_ATS
 	bool
 
+config PCI_IDE
+	bool
+
+config PCI_IDE_STREAM_MAX
+	int "Maximum number of Selective IDE Streams supported per host bridge" if EXPERT
+	depends on PCI_IDE
+	range 1 256
+	default 64
+	help
+	  Set a kernel max for the number of IDE streams the PCI core supports
+	  per device. While the PCI specification max is 256, the hardware
+	  platform capability for the foreseeable future is 4 to 8 streams. Bump
+	  this value up if you have an expert testing need.
+
 config PCI_DOE
 	bool "Enable PCI Data Object Exchange (DOE) support"
 	help
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..6612256fd37d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_PCI_IDE)		+= ide.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
new file mode 100644
index 000000000000..e15937cdb2a4
--- /dev/null
+++ b/drivers/pci/ide.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
+
+#define dev_fmt(fmt) "PCI/IDE: " fmt
+#include <linux/pci.h>
+#include <linux/bitfield.h>
+#include "pci.h"
+
+static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
+			    u8 nr_ide_mem)
+{
+	u32 offset;
+
+	offset = ide_cap + PCI_IDE_LINK_STREAM_0 +
+		 nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
+
+	/*
+	 * Assume a constant number of address association resources per
+	 * stream index
+	 */
+	offset += stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
+	return offset;
+}
+
+void pci_ide_init(struct pci_dev *pdev)
+{
+	u8 nr_link_ide, nr_ide_mem, nr_streams;
+	u16 ide_cap;
+	u32 val;
+
+	if (!pci_is_pcie(pdev))
+		return;
+
+	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
+	if (!ide_cap)
+		return;
+
+	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
+	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
+		return;
+
+	/*
+	 * Require endpoint IDE capability to be paired with IDE Root
+	 * Port IDE capability.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
+		struct pci_dev *rp = pcie_find_root_port(pdev);
+
+		if (!rp->ide_cap)
+			return;
+	}
+
+	if (val & PCI_IDE_CAP_SEL_CFG)
+		pdev->ide_cfg = 1;
+
+	if (val & PCI_IDE_CAP_TEE_LIMITED)
+		pdev->ide_tee_limit = 1;
+
+	if (val & PCI_IDE_CAP_LINK)
+		nr_link_ide = 1 + FIELD_GET(PCI_IDE_CAP_LINK_TC_NUM_MASK, val);
+	else
+		nr_link_ide = 0;
+
+	nr_ide_mem = 0;
+	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM_MASK, val),
+			 CONFIG_PCI_IDE_STREAM_MAX);
+	for (u8 i = 0; i < nr_streams; i++) {
+		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
+		int nr_assoc;
+		u32 val;
+
+		pci_read_config_dword(pdev, pos, &val);
+
+		/*
+		 * Let's not entertain streams that do not have a
+		 * constant number of address association blocks
+		 */
+		nr_assoc = FIELD_GET(PCI_IDE_SEL_CAP_ASSOC_NUM_MASK, val);
+		if (i && (nr_assoc != nr_ide_mem)) {
+			pci_info(pdev, "Unsupported Selective Stream %d capability, SKIP the rest\n", i);
+			nr_streams = i;
+			break;
+		}
+
+		nr_ide_mem = nr_assoc;
+	}
+
+	pdev->ide_cap = ide_cap;
+	pdev->nr_link_ide = nr_link_ide;
+	pdev->nr_ide_mem = nr_ide_mem;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..1c223c79634f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -515,6 +515,12 @@ static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { }
 static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCI_IDE
+void pci_ide_init(struct pci_dev *dev);
+#else
+static inline void pci_ide_init(struct pci_dev *dev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e94978c3be3d..e19e7a926423 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2625,6 +2625,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
 	pci_rebar_init(dev);		/* Resizable BAR */
+	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f6a713da5c49..3fac811376b5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -532,6 +532,13 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
+#endif
+#ifdef CONFIG_PCI_IDE
+	u16		ide_cap;	/* Link Integrity & Data Encryption */
+	u8		nr_ide_mem;	/* Address association resources for streams */
+	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
+	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
+	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	u8		supported_speeds; /* Supported Link Speeds Vector */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a3a3e942dedf..ab4ebf0f8a46 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -750,6 +750,7 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
 
@@ -1230,4 +1231,84 @@
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
 
+/* Integrity and Data Encryption Extended Capability */
+#define PCI_IDE_CAP			0x4
+#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
+#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
+#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
+#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
+#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
+#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
+#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
+#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
+#define  PCI_IDE_CAP_ALG_MASK		__GENMASK(12, 8) /* Supported Algorithms */
+#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
+#define  PCI_IDE_CAP_LINK_TC_NUM_MASK	__GENMASK(15, 13) /* Link IDE TCs */
+#define  PCI_IDE_CAP_SEL_NUM_MASK	__GENMASK(23, 16)/* Supported Selective IDE Streams */
+#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
+#define PCI_IDE_CTL			0x8
+#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4  /* Flow-Through IDE Stream Enabled */
+
+#define PCI_IDE_LINK_STREAM_0		0xc  /* First Link Stream Register Block */
+#define  PCI_IDE_LINK_BLOCK_SIZE	8
+/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
+#define PCI_IDE_LINK_CTL_0		   0x0               /* First Link Control Register Offset in block */
+#define  PCI_IDE_LINK_CTL_EN		   0x1               /* Link IDE Stream Enable */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR_MASK __GENMASK(3, 2)   /* Tx Aggregation Mode NPR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_PR_MASK  __GENMASK(5, 4)   /* Tx Aggregation Mode PR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL_MASK __GENMASK(7, 6)   /* Tx Aggregation Mode CPL */
+#define  PCI_IDE_LINK_CTL_PCRC_EN	   0x100	     /* PCRC Enable */
+#define  PCI_IDE_LINK_CTL_PART_ENC_MASK	   __GENMASK(13, 10) /* Partial Header Encryption Mode */
+#define  PCI_IDE_LINK_CTL_ALG_MASK	   __GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
+#define  PCI_IDE_LINK_CTL_TC_MASK	   __GENMASK(21, 19) /* Traffic Class */
+#define  PCI_IDE_LINK_CTL_ID_MASK	   __GENMASK(31, 24) /* Stream ID */
+#define PCI_IDE_LINK_STS_0		   0x4               /* First Link Status Register Offset in block */
+#define  PCI_IDE_LINK_STS_STATE		   __GENMASK(3, 0)   /* Link IDE Stream State */
+#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000   /* Received Integrity Check Fail Msg */
+
+/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
+/* Selective IDE Stream Capability Register */
+#define  PCI_IDE_SEL_CAP		 0
+#define  PCI_IDE_SEL_CAP_ASSOC_NUM_MASK	 __GENMASK(3, 0)
+/* Selective IDE Stream Control Register */
+#define  PCI_IDE_SEL_CTL		 4
+#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR_MASK __GENMASK(3, 2) /* Tx Aggregation Mode NPR */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_PR_MASK  __GENMASK(5, 4) /* Tx Aggregation Mode PR */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL_MASK __GENMASK(7, 6) /* Tx Aggregation Mode CPL */
+#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
+#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
+#define   PCI_IDE_SEL_CTL_PART_ENC_MASK	 __GENMASK(13, 10) /* Partial Header Encryption Mode */
+#define   PCI_IDE_SEL_CTL_ALG_MASK	 __GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
+#define   PCI_IDE_SEL_CTL_TC_MASK	 __GENMASK(21, 19) /* Traffic Class */
+#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
+#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 0x800000 /* TEE-Limited Stream */
+#define   PCI_IDE_SEL_CTL_ID_MASK	 __GENMASK(31, 24) /* Stream ID */
+#define   PCI_IDE_SEL_CTL_ID_MAX	 255
+/* Selective IDE Stream Status Register */
+#define  PCI_IDE_SEL_STS		 8
+#define   PCI_IDE_SEL_STS_STATE_MASK	 __GENMASK(3, 0) /* Selective IDE Stream State */
+#define   PCI_IDE_SEL_STS_STATE_INSECURE 0
+#define   PCI_IDE_SEL_STS_STATE_SECURE   2
+#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
+/* IDE RID Association Register 1 */
+#define  PCI_IDE_SEL_RID_1		 0xc
+#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 __GENMASK(23, 8)
+/* IDE RID Association Register 2 */
+#define  PCI_IDE_SEL_RID_2		 0x10
+#define   PCI_IDE_SEL_RID_2_VALID	 0x1
+#define   PCI_IDE_SEL_RID_2_BASE_MASK	 __GENMASK(23, 8)
+#define   PCI_IDE_SEL_RID_2_SEG_MASK	 __GENMASK(31, 24)
+/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
+#define PCI_IDE_SEL_ADDR_BLOCK_SIZE	    12
+#define  PCI_IDE_SEL_ADDR_1(x)		    (20 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+#define   PCI_IDE_SEL_ADDR_1_VALID	    0x1
+#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK  __GENMASK(19, 8)
+#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK __GENMASK(31, 20)
+/* IDE Address Association Register 2 is "Memory Limit Upper" */
+#define  PCI_IDE_SEL_ADDR_2(x)		    (24 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+/* IDE Address Association Register 3 is "Memory Base Upper" */
+#define  PCI_IDE_SEL_ADDR_3(x)		    (28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+#define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.50.1


