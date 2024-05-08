Return-Path: <linux-pci+bounces-7225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A498BFD69
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 14:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970841C22F1D
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 12:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7513F8F6;
	Wed,  8 May 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChzS4hb9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CA47F5B
	for <linux-pci@vger.kernel.org>; Wed,  8 May 2024 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172100; cv=fail; b=JjOkt0Ib42aK078bWBqwcMgA5Pw4KYbL+jIszZ3+oUl3ZQG2cev5hBIF7ztXOTbazu3tvQNxj9AgQ4r49YyhBY3vUE7rMmtF9K8pfRaBn2RSoO3XcqXjMGicWtiNAVXCdh7xgpQjJ3NaoEun1KAbdfOfXYXT+obH+98q70shvXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172100; c=relaxed/simple;
	bh=mGX9LULBWSsEwmhl29oD2SSCxDcGGo/VfWllAKPsNhY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=poI9dagrAugypEd9yzVVTEFqgv2YoTdbswSNHqFcsEscy/F2wqJ5fWphEfNSVt906RkNTikWTJX6NAoTJm6JVDIf23ceEHI17QLzmAIXnTluRSe7THKhUugBFSrvZanPm4N2Gxu5JbnjV/Z3JFpjnx6Os3xmiWXyiuuHfnz9u4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChzS4hb9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715172099; x=1746708099;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mGX9LULBWSsEwmhl29oD2SSCxDcGGo/VfWllAKPsNhY=;
  b=ChzS4hb9gbRUMU9+wsiyJk/Sce/7jua9fiut9Y9VnWehpoLjEAbS3tpB
   R2KHCFih3Zs6aF/bDx23yDMrSn3uYwB0KpbhaAAXOzIKa9EG3z9w8hIlb
   eS8nASMSaL3YvbZtYBdiSV9vH8M6VsCh68IbRrnSfxGc7PnnwcCL9wyQs
   A8nbOnjqOQZxlD42kiFyFGAU82pqybX631cUAC7lF0f6JWATBwVrO/FDl
   X3Vnk6GX+94AkPO4GxCLonPxUtCqR2dXRIgNuZB+gO5p6FePVA9bzAbEC
   Ad2V2kK6VdeMQKfWTSP1Edr15rxRsQ9XvpHwgdQP4c8IaiywmdNc7zbZY
   w==;
X-CSE-ConnectionGUID: xx/J9yPNTRmOOHpnSKbGdw==
X-CSE-MsgGUID: tlMVD9VKQx6igx+Lr6VcTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22419555"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="22419555"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 05:41:39 -0700
X-CSE-ConnectionGUID: 62+udsDESDGukAK2dqzdXA==
X-CSE-MsgGUID: Cr10o5TvRu2Pmm+MSx9BlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33419004"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 05:41:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 05:41:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 05:41:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 05:41:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 05:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0TTbkwuxizMmQpw1fPJ4GehvxCM0Il7K5QTkUJU6z99JTVi99UI3mBxuwQ2GCpeV8Ygeyu39T5QhYr95p6qlcxRsE/6u7dWQgkH5vrhLYe4hsjv2KdnMHFqV4qMmXFOIZ6nrB8QgWXmRRVWzh98EXgpILIrWKLTo3Lm3CQrHyiMbOIQnufhKPeqcvYPc0QeBF3KASuwhETXAKOD8jgcUPWmTqQmjEiMorlWurR7FdaLKjY2aDoT5sSANhsYaGPejV42RCmugTaRMX6tDGvzpCQqZBkvIoJBW48ELtFAXUSro0gkG2dpURv5RmYw0pmbyRx1lgCdOMyb/P6XDdlBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4N4MxMuCJLMGtVeF0YN0xEvyNMWuAS66yPPH3hZMmo=;
 b=eAQ/cMbiQ568MWQlfD27L7Nk+mp/uRw+e3OQiCY1+eTBnBf3Nj2nBuCbI6awRcgV/nr4+RZ2n/dQbKJwBx05iYa2SdaSYHI1zjV1lN4uz0Sau+iDCS2ndl/Q9yn8EtxG0SYbUmKiuKQfvWHC2ngtRz/r8ORGR+SSoA4aALZjR2yBu9L4JhO9yuH+7fO7A9uuIShAOrzI6XogWiPyqr0wDEmV45oros/qzKI8TOIMbmpwGN8feCASQzIQy9WuhZPY5Aax6nUdooGEYSSnhkFtxhTu8cmP0s8X4YCw4K4mN9kTXUhABODc5oIVIITaLIauySmWIklrf8hcRURtXGx4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by DM6PR11MB4580.namprd11.prod.outlook.com (2603:10b6:5:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 12:41:35 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 12:41:35 +0000
Date: Wed, 8 May 2024 08:41:31 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <lucas.demarchi@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/5] drm/i915: don't include RPL-U PCI IDs in RPL-P
Message-ID: <Zjty-5FsEwAyc_ch@intel.com>
References: <cover.1715086509.git.jani.nikula@intel.com>
 <697b354c2f12f923867cea2ad8f6628737716949.1715086509.git.jani.nikula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <697b354c2f12f923867cea2ad8f6628737716949.1715086509.git.jani.nikula@intel.com>
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|DM6PR11MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d41afc-ded1-436d-d521-08dc6f5c326f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zmjUyG0pV0iIkU+yf74w8pX7IWccVMxllrW8/SpAiiSni7lvrBvShapMSEt8?=
 =?us-ascii?Q?8UF3dt4OAIXmIYUJ0DVAvqGVDhYi2uBeH87SGojwAeYXDVs3fJgthDZwKogC?=
 =?us-ascii?Q?r2JQz3LkEKOHsLEP4PA8fRyP3XO2xT1SDgx9AynH8/0KkRpTmdqxDhBikSW3?=
 =?us-ascii?Q?8HmlWYZs9gbpjwzJqrQsKii89KUGQUNR1Uogpk8gBGJBC70a/qP2CXXP+Sai?=
 =?us-ascii?Q?d1/V8bdAf3F2YSQLyHHka83MdfBCcQyeIHILPXNSI5Qc9ZIm5HRpg4UYJryc?=
 =?us-ascii?Q?wf3SlnK87SJNZ6/jgKcdFOZBzTr7Y/JPJbJs/d733If7/UnqstVWM6ri4Ivq?=
 =?us-ascii?Q?HhAS1Nrius+J+GO72fIxI74cAe2wGOGX1wOpCaAErEx8jSTHYL0BAT0C0627?=
 =?us-ascii?Q?ghRQGvCfgOF1PXfPFscufR9v6tWH2YoPtbBAtEka7PKNprXWwtEqk6y9HZTt?=
 =?us-ascii?Q?csvF7Qwwr/VqEn2K8LRQoKHNLP5dibColroUksvzOqXD/80tehhdYPCcUwea?=
 =?us-ascii?Q?5GHJHd5byhOsPkIxIRAPHShtF0E9r5IDoITuXrxTXtUolbUWEeHDzimBlR80?=
 =?us-ascii?Q?T3NZh5Jm4aHwnL5nxYjSjLw5uKQLOcDQAqM6NVSGucHnYgJyOshKdHRyVrhx?=
 =?us-ascii?Q?2Q9oH8Fy+9QnBuLKUx1awqtESuKSn0Hcb8lnQ2UfPWySUCq8YneFjAE0dlHa?=
 =?us-ascii?Q?JfngQvKgxhULFwaCFlYrodi45rdslzb+FpX6KKEoa1EtBGirbRbzB1ZKhkoV?=
 =?us-ascii?Q?PjeBmYDfX87ZMso/oc8TltrGthOKESfg2QjIDTvOlF+Hcxg9oakUBO7Tghac?=
 =?us-ascii?Q?if1N4E0hrxWUebFD36enV0tF7xH/1dowjaBEd8b0U6kK2Rk9zlt27pAN5pbv?=
 =?us-ascii?Q?KJh6+W1yJZ/oiK05+/MOuAdwl7OVVZb/Jj/JxVa53/FIfWK2Q2homh0mffUf?=
 =?us-ascii?Q?SQYXhjsVoTovFdkQ2k2kmci7XUGg0sy6ZsDQ7VL806XnMObvuA1oiZXolcxw?=
 =?us-ascii?Q?mtuJQzNd8R5BjgtDpFUzCwSOT7+x1TOfF4ygvb+mVxs3NREvU/LAK4S3ShwF?=
 =?us-ascii?Q?b8IELhBcUN5MznEB8G1WLm9/O7/6yTLRU906qGCj3jBUx4TihOfd+Zln7sUG?=
 =?us-ascii?Q?wAtvMWVlceAE8cu7yYVPFXTBgmN+lwSgQAPgDH8sHwQgOjBx26IEYneBiVyU?=
 =?us-ascii?Q?KdcGAz83ffnUjbX8YLbPCUr9yLQrxpZwTJ8UD2xXi0C1qhD716ObEIucMZMa?=
 =?us-ascii?Q?/Mtr/15Y38U2d08g71IiZcL+ADFXhJFnkKTEPoTOBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmy13WyZspvbbCCMQLlngQVjAKEznpvr0K/M7IPRbRdkihapR+v6s1qPr1DD?=
 =?us-ascii?Q?eSu1/gkdF05OouLzG2gXicN+h0pW/rfbHXyMtfUvQ9cSRL9Jx7LJZtuxbiff?=
 =?us-ascii?Q?kxlmUHR2nDg62pldnopQWCPWSJJvyOFxFUbV42OESrHQIFtNmHtswux1spEk?=
 =?us-ascii?Q?Ss7doDNWkkmL+T0SPjtVriK0lVW5LGLJt00n0egMBNuZE/z8sRDpEFbsTwHk?=
 =?us-ascii?Q?kpxEUgoraG97bsnnPOxvQ3RerBrnf+nhvPSyM1JB5panchmSl0DnyEU93Y5I?=
 =?us-ascii?Q?UPa7maVQJAb73eB8273akwSCpWYeDcrHf5Hlpk6Bf4QPupmiOsdqP6EK/i7+?=
 =?us-ascii?Q?rl78WNGBwrebpuZYsdjqojuXVzo90uW4pn+E9bS48gOI+7Dn7OZceGdpRQEX?=
 =?us-ascii?Q?OKrnAzSvovaFDsUIn+i9VxjSE2DmbICisl9yTTWBqwsY3gg1VNj5m3DKDbCX?=
 =?us-ascii?Q?qR1zm9VhHtc6UnMIi16cYUUKEySB3QFVZJaNv4Sq1Dw7Zoo+fiGfFRtU+ItC?=
 =?us-ascii?Q?L0kUCh8lcw0T9w6Bg7KuvczW2jvfRzSzl8fpVFYaErPsXads6n9sbgpuiiIa?=
 =?us-ascii?Q?/Hwfy9xC7v3q8H9h6jh8zVUAEiJ8yuRabJvu8rMiFPQz0uReV8G0c/AOxyJc?=
 =?us-ascii?Q?f1jz95bCAhHWcYSE0OZERAPRCE+h1iazEAZiNFA+RkrYArxD/dqfsImFxIki?=
 =?us-ascii?Q?Ux8ggZDAGEN8gtT6tTYTEqeCtsWTALoxzMRyFtHzvEOLdv5/voMX3VGcdljW?=
 =?us-ascii?Q?beqle55DHmxr2nRGO+ykwjNOs+o63r8cBQ0UKzPX/7NPt7DRJAGkS+OAqvDF?=
 =?us-ascii?Q?bNEHyl21XzmCeCVch5gAEu3g9kt/aIKQYKKcvz8+whYVvt4QO+OfCfGXaIrF?=
 =?us-ascii?Q?Qxg99Wqg9E3gNXxDdD8+FzDt5ktRm9Yra0D8iDnEVA08PAkm5LPhnoCkyHks?=
 =?us-ascii?Q?DyliMwvRq4e9q4Duln8rCcLK11aJgSgTnbzLAU8WbKDaD9jl+D1j6uQprGUR?=
 =?us-ascii?Q?3USxiZFi9BGJrgTIUy0QM2v34GP5iW2wVF3+F4spa5dWKLHSXPqK20DwU9ER?=
 =?us-ascii?Q?ASuoyXcJ+fTLeMl8mAIXFOC0GyyVBiZ7Bt0XdqQpX19iKXTrfVDeOng74OrT?=
 =?us-ascii?Q?CC/UFzB9Gt+/DsX2kqDlZyYIq/EwwzGvV0On9nAI9rdc8fEcn9CnW6zQfySM?=
 =?us-ascii?Q?BmzTr+3UiRenB5IFjKNFvwPZL1mTSy88Gkt2kKanhIvNlxhI5GKJzI3FBnPZ?=
 =?us-ascii?Q?cjUcRoNqPOGvpDSF55NM/udfSN5x9wN91nHzo8qVs0nP0eSm889kh/YED6vy?=
 =?us-ascii?Q?zdgrr7L5hd2lhPUGzuw2hUAsGx2lrc2HIbQj1T3+Hyvzhwo4+aW3tHJADYRe?=
 =?us-ascii?Q?CcJgK52WkmJIDg8InpuTmvuVp95oroWLbwrL4U9ZRPTCPaGqRPQ5coFWJorl?=
 =?us-ascii?Q?/NrW+Gv18Yc/Sr2tlIY66prmOPNVbpgoc3UBXIlulqUOlblgI8aEgG1JOoSk?=
 =?us-ascii?Q?vIkOhTuLZ0eihfUCvJ4y/OvVyT8uDty14YzNa7k88DpfjPJv8Sf2LHrAKZCu?=
 =?us-ascii?Q?Ekzm8Te/3LrlxrW5w+9zgxOgmh6ieyCAS/2Jzcd4X8tlg57L1FM8662cvE7P?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d41afc-ded1-436d-d521-08dc6f5c326f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 12:41:35.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lj+/B7RRglr1PrzLjf2nPRmpLVy20M2GcB5lcSWDrec/awORLBeZx7/4POfIiSnvyWe8+k9ueNmFNC4iLgdMMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4580
X-OriginatorOrg: intel.com

On Tue, May 07, 2024 at 03:56:49PM +0300, Jani Nikula wrote:
> It's confusing for INTEL_RPLP_IDS() to include INTEL_RPLU_IDS(). Even if
> we treat them the same elsewhere, the lists of PCI IDs should not.

This shouldn't be required for the end goal, right? Since Xe is doing
this as well. Anyway, it looks like the right thing and we should
probably change Xe too.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  arch/x86/kernel/early-quirks.c                      | 1 +
>  drivers/gpu/drm/i915/display/intel_display_device.c | 1 +
>  drivers/gpu/drm/i915/i915_pci.c                     | 1 +
>  drivers/gpu/drm/i915/intel_device_info.c            | 1 +
>  include/drm/i915_pciids.h                           | 1 -
>  5 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 2e2d15be4025..549227d15691 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -559,6 +559,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>  	INTEL_ADLP_IDS(&gen11_early_ops),
>  	INTEL_ADLN_IDS(&gen11_early_ops),
>  	INTEL_RPLS_IDS(&gen11_early_ops),
> +	INTEL_RPLU_IDS(&gen11_early_ops),
>  	INTEL_RPLP_IDS(&gen11_early_ops),
>  };
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index 3aa7d1cdd228..342b439b0ee4 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -843,6 +843,7 @@ static const struct {
>  	INTEL_RPLS_IDS(&adl_s_display),
>  	INTEL_ADLP_IDS(&xe_lpd_display),
>  	INTEL_ADLN_IDS(&xe_lpd_display),
> +	INTEL_RPLU_IDS(&xe_lpd_display),
>  	INTEL_RPLP_IDS(&xe_lpd_display),
>  	INTEL_DG2_IDS(&xe_hpd_display),
>  
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index 405ca17a990b..a16fb09061e2 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -867,6 +867,7 @@ static const struct pci_device_id pciidlist[] = {
>  	INTEL_ADLN_IDS(&adl_p_info),
>  	INTEL_DG1_IDS(&dg1_info),
>  	INTEL_RPLS_IDS(&adl_s_info),
> +	INTEL_RPLU_IDS(&adl_p_info),
>  	INTEL_RPLP_IDS(&adl_p_info),
>  	INTEL_DG2_IDS(&dg2_info),
>  	INTEL_ATS_M_IDS(&ats_m_info),
> diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
> index a0a43ea07f11..b119923f8be2 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.c
> +++ b/drivers/gpu/drm/i915/intel_device_info.c
> @@ -182,6 +182,7 @@ static const u16 subplatform_n_ids[] = {
>  
>  static const u16 subplatform_rpl_ids[] = {
>  	INTEL_RPLS_IDS(0),
> +	INTEL_RPLU_IDS(0),
>  	INTEL_RPLP_IDS(0),
>  };
>  
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index 5f52c504ffde..1b9cb6195637 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -699,7 +699,6 @@
>  
>  /* RPL-P */
>  #define INTEL_RPLP_IDS(info) \
> -	INTEL_RPLU_IDS(info), \
>  	INTEL_VGA_DEVICE(0xA720, info), \
>  	INTEL_VGA_DEVICE(0xA7A0, info), \
>  	INTEL_VGA_DEVICE(0xA7A8, info), \
> -- 
> 2.39.2
> 

