Return-Path: <linux-pci+bounces-9254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 260DD91728D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 22:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A446B1F220F0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88416B39A;
	Tue, 25 Jun 2024 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHRgApjD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5C632;
	Tue, 25 Jun 2024 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719347536; cv=fail; b=LyN70X9C2f7tPqDUFB5lyx3pfwMlIki0bcy2pitD92Tz4rK19WbR64up+GzsS34da15xNXCfwPtMPI1bq7sO50MSH8U/Gxro7WLkoxjOtOzDGha70PObXtXePiE3L6eSpdS7toWFe917aFUI0TPJFi5/I54WvIcNDH96d5MZu9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719347536; c=relaxed/simple;
	bh=QPysDPExLurSE/r3rXl1cuLuvGUUcz5MHWbYbDfKXzY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MmyOdkDRu6sw6OvAnDC6sEz0+2qpbtaZCjsYl5HEQLFAzUlbo0qR4+BrbmWlzXqOCQ7u0MDKcjOkMJQSA4K5CcP0pExiVKxraJ72MVABWPnCdZGSEUuD8893lqk7y90vd8ZpA57qNrFmb7ZuTToT2hpQqGUWXUd/K9gOHnc94ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHRgApjD; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719347536; x=1750883536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QPysDPExLurSE/r3rXl1cuLuvGUUcz5MHWbYbDfKXzY=;
  b=BHRgApjDakXRhfm7rY5H2OT0o8pUcgvBe9+GkGkxo73QXgbTSkxc2e/2
   xljkkZyMbBiDYQxm47bbw2boXqB+qNodA+aRyCpZW+9QTMwxS2HmYWro3
   Y48Tfl2CMk/J29FFj8JsECGHc1xcKaElvkIxl3XKVHPRT3Vl2O0MBTMv3
   QuLoOpExKB1PmWZJ7i6eOObPRnVUYy0qwv5XNkyHhqVC7mNLoMFQ4jqEs
   8bvN8R2Q1OczWaQpfb7fMF7LGcDoGfIovSc6YvxohK48li4uURLaD/61g
   0ddQazbBq1I+CGj6Q08MeqUxyMKQ6jb+0JIz8ER0scHR6xpka+qWi/grY
   w==;
X-CSE-ConnectionGUID: xWzfvPG/TxSp3HJ8CO0/yw==
X-CSE-MsgGUID: R1nCSZdQTYewsroB7b5J5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="26979294"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="26979294"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 13:32:14 -0700
X-CSE-ConnectionGUID: v2PawBV4QL+f2efSh6IW7g==
X-CSE-MsgGUID: IVbqxPR+TjqitxevnsQSlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48354387"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 13:32:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 13:32:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 13:32:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 13:32:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 13:32:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTYvhFQvF+5kZBfdIgWgJoFCnkzL+kxFuVHyL/j9S5zPdpK5GPKYmT3dPDEJ3hx32mmXZyKT3iyuuQShoI8x9jnn/BGVkqfJsx+J4acUZRDPxVHi/rjN80+EhvuCN9i/irOESWxirdiFmWPKfIheUtmVluj1uWJVDSN+fxfhlgZKIDwccYNsWZ8D8mM5tWgxtdNxL89DpX/vOVmGE4pkrQ+4erpt0zuD+gzMGS5VFDkrc9YBDZ+FXcXFvIrsz1brN9TMvgal+nFhNWAZLkTU2FDdC5mEO4tY8tFu8yD0wQq6mXVhxgjVPz8miMzdDyTQYLi8nRYtW+KmAlNU59apgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvlJGj2j7GAEqDf7LaYU6PnFJt60J4aGa7sLq0F86Fo=;
 b=PgKBshAWbyGfaasAfbE0JYdfM/PtNistSReY/Fqa6P2b78zVam8p7UEZimHKHFyZjJ9XvQ31nD3j7rVUavYp0EuNS6ChDHZ2ZamFX7EOdrA9NdOjyGkuO0TlNJM9DGXUuVxoUoTw0oZChST2MLbY74lQ76GcEgF9b6RBvZL4zo0thLNa8L54R8Xj89cxxe98DC1232tITnVqcg7GdkFl29rqqfB/YHN302SLkd8VjzwtX7t00+7JbH0sxOXTlkh0AebPwwA8SnhpwLWjoEyP0RuuyO1DW1DpBLKqbi0PPwksGUYxGjbLN2glxeFruTyxd09farXvLFjvHuCJo94gUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by PH7PR11MB6649.namprd11.prod.outlook.com (2603:10b6:510:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 20:32:09 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 20:32:09 +0000
Message-ID: <3ea8faab-f731-4464-9811-c93e638f0cb6@intel.com>
Date: Tue, 25 Jun 2024 13:32:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: vmd: Drop resetting PCI bus action after scan
 mapped PCI child bus
To: Jian-Hong Pan <jhp@endlessos.org>
CC: Nirmal Patel <nirmal.patel@linux.intel.com>, Bjorn Helgaas
	<helgaas@kernel.org>, Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, David Box <david.e.box@linux.intel.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Mika
 Westerberg" <mika.westerberg@linux.intel.com>, Damien Le Moal
	<dlemoal@kernel.org>, Jonathan Derrick <jonathan.derrick@linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@endlessos.org>
References: <20240624081108.10143-2-jhp@endlessos.org>
 <20240624082144.10265-2-jhp@endlessos.org>
 <20240624082458.00006da1@linux.intel.com>
 <897ead26-be10-4bb3-b085-1b8c97d93964@intel.com>
 <CAPpJ_efs9nHrTx=N2NwtmN=py3CFg62izcgJrUkcMDd_ErR5VA@mail.gmail.com>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <CAPpJ_efs9nHrTx=N2NwtmN=py3CFg62izcgJrUkcMDd_ErR5VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45)
 To CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|PH7PR11MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: bb99e2a8-a3f0-4264-a2f3-08dc9555e2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S09PTTRtSVYwS1JjbnJ0V1oxVmRDb216a3h5VnhldURwY2FuUi9qM3lsbEd6?=
 =?utf-8?B?TURYTVNyR0gvcGZMZVcyMHRFdVBIUHlvTGpIeGxTbGRQY1NKTFVkb05LZDBM?=
 =?utf-8?B?MW9RQ25RTVhtcmVUKzE4WFZoZDNVd1Y1RW5mTU5RZ0lwdmNxTzRzN1hjdEF4?=
 =?utf-8?B?a0w0aUN0NkY4dFMyeGFldzRjV3J2MitBTm9Ia2lwWHpqWDMrMVdlMTAyTm41?=
 =?utf-8?B?NzJwSjc3ZHJEMERKN3VLblRhQThRZ3VIcXRMcnZET2Z1V0J3WGR5d0V6N016?=
 =?utf-8?B?Wkkvc3JIQkwrWFlUMXlUbkZoQWtSSk9JV0pYRzdEcTE1aGVHZitCRVRRelJC?=
 =?utf-8?B?TG9PNEQ3Nlg3MW1XU0E0QXNtSXpxNS9RTTd4MVNnOWxCcG1HcjJzU1BaMndn?=
 =?utf-8?B?R01DMzdiS2ZiTWgzRllxbkdhOFBsOVBsMitpMDZjaWZwZTBBekFvaWJjbUJH?=
 =?utf-8?B?MlBEaGlXZHZpbXNTYi9xNEV2bVB5Q05ZMzV1dDFaQ2RVR29YQnJiNFFYTlYv?=
 =?utf-8?B?Y1NTVDFXT3N1SE9GQjRQTWJqekNqZ1grZHFMVjVhMHBsaFpjZ2JjYVJEWTBJ?=
 =?utf-8?B?VHBpT0k5K2RONmVxVzIvRWxJdFlyK0tLc3BiK1JCYU9FZ1owUkt5a1MxTG5E?=
 =?utf-8?B?em90OCtBcU9jNEMrZDEybzZMTFhEejZiekFxZEJPOHVycjJhandudm00bHNl?=
 =?utf-8?B?Tld1ZW53RHdFemx3QnEzY1pSOE1sa0FEaytWZFBSY3NFQkx4UkJRNzdEdTla?=
 =?utf-8?B?WTJ4bFVFdDJML3gwQjEzcmZjRjRJSkJJZTVodVAzM1hYdGNhQTI1OGhtMGJ6?=
 =?utf-8?B?dk1KMUJaclFkblZKZnpmNndhRXZFN0t1MXp3UVV5eFdRRDJRb2xERnNvNlhF?=
 =?utf-8?B?SHdsOFZvYnI0Vno2QW9lQktvOThVRy9yNWR3VHloZWdtRFFHMjYyVkkwMmVS?=
 =?utf-8?B?OWI3WUx3Wi9wZVRINU1xUDZaREhKKzRpeW5lMzA0U3RTVUQ0aEpCUlVqMllW?=
 =?utf-8?B?c2JCQzJtanRmS0dqZC9lMkJBQU5pcWozYmtYYTdjM2xTUkhNbnVzaC8wRXNL?=
 =?utf-8?B?L01tNzZTTmROWGF6MWgvelFudHkxaENWenVySTBaa3lhc2VsOWpka1d2REFY?=
 =?utf-8?B?MTJtWU5FbXdKMnlSVkZSZGFKMERYTktiL1QwaE91RzkzcFZwa09mNW42Wms5?=
 =?utf-8?B?bk94S1RTVjhyWkN6bzM4R0xDWXl0QnlFdTJ4ZG5vKzl1ZXYrT2Fud0dtck50?=
 =?utf-8?B?NDE1eWN1TDlxbVQ3SVJJbzM1b3NKcldzQURLMjVUQXBUc2JhYWEzcnlEenBM?=
 =?utf-8?B?M1FwSUxxaDNpQUxwRXRJNHQyL2tBNzU1QW0vcnk3L1RIbEZ6WUFxUGRBN0hJ?=
 =?utf-8?B?VmhTamR6ZDQwY3BobHVSZWY3ZVpFd0dsTEllN1VXdS91SHluVEZGVG5ST3lw?=
 =?utf-8?B?dWtuWThxSUc2M1Jac0NXMmJhWnRHc1ZzRC9Na2xNWkRoMHV3SDNienlsWnYw?=
 =?utf-8?B?SHhSNVNIZVFpSngyckRRbGlDRVhZbXFIdmEwN2dnbWkweVMzUFkxL0VCQm9W?=
 =?utf-8?B?cFRsR3ZKbE03Zis5eWJQeC9EUTVIMGV6aTBhMGZCOEZpM0VObkVRU2Fub2wz?=
 =?utf-8?B?K0ZsUThONXhEZ1ZFN0d2d3gvU1k1RzAyVVFsSkp0OThXbXdoSXVESjdqQk5I?=
 =?utf-8?B?eHFZcWVUOUJ0cklQQ0ljUmxWWFhTWWRYUC9UV1l5OUI5RXVKYzMycDcxd3lk?=
 =?utf-8?Q?U0e6vxQW6Lth7HWpQ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkR3elljL3pLSmN4S0dwVVJYWVc5SUJlamhRUTZBRWU4c2xyaWNWQjkxbWlX?=
 =?utf-8?B?T090VXM2SmVtMk9kbWFuWEd0ZzFoZjBNaXBqZk4xNVg5aUR6emRPaTltNXFM?=
 =?utf-8?B?enBRSENGUzVVN2ZoeW80VEd3Tzd0M0tYM3pIWTRlOUk0NUtncnlKTVFadU44?=
 =?utf-8?B?Rmk4MzVCVGNGMFpjYmxyYlBqbGZMQ1c1VGd3TCtwMXBwWnYrbDVYL3Z4Yzk3?=
 =?utf-8?B?d1Y5dlpQaWs5ZDNSMnd4WDZKUnl0QkZOMTh6bWV5QWowYnl4WDYyNDlYVmZu?=
 =?utf-8?B?Z005bm9iT296TE1SRjFtaFpFSlNjRk1lQW5MUTVJbmpJVnArcWpPS1NZMjdm?=
 =?utf-8?B?MVZqVS9tQmkwb3Y1Y251YVh3WVBYSENOd0VtU1V3c01EVFBqYVorMkZNNW83?=
 =?utf-8?B?V0lPVHRpdXJ6RVRtekZpL01ROGhueWF5akdTQ0dnUTVVcm51THNmdGoxdlE4?=
 =?utf-8?B?V2ZiY2hsYW5MeE90WFc1M3N4OGlZa0FzSzdOcXMxWW00V0NlcjNJaCszZjRs?=
 =?utf-8?B?QWRWY2pqajExQXh0c2RyU3ZWZTNYWGNnSUIwOTlCYjZpZ3VqSVBMUXM3SDNL?=
 =?utf-8?B?UDZvc0l0VE5qVDNna2MyNHY1N2xqdlpiTGVXTjVWWTB4dDlvM0twcUFWQ3pK?=
 =?utf-8?B?aXpLSHJETWd1eHJNTHA0UkM2Ym1wSnFWVko4a3pxQjN5M0FOWWs1dEQ1RGdU?=
 =?utf-8?B?TzZFeW9JNFNCZWRoYnc5a1k2aDhmRkZOOFY5VjdGbVROQWg3MGNPRTV0d1kz?=
 =?utf-8?B?T0UrVVNoZGNSbDkxNXJKNmkyUlZmR3lKcGFseFB1TGJvRENVYXJHeWF4b3do?=
 =?utf-8?B?a1p1N3BrZ0tDdTlLQUJTMzAwanVWRnpPNnM1YmRtcVV1MjVydk5BRkR3c0tK?=
 =?utf-8?B?TTNjV2VaQlBJL2UzamMxR1h4TVEyMjNwSG5FeU9VOHNYWVMwVGdSNlhtWko0?=
 =?utf-8?B?S2UrTitQbm9XZ3dTYnEzbzlNSDFuRXNIb2lqWlM2Y20zMjg0THpIc3VBNllm?=
 =?utf-8?B?N2ZnM3Vqd2x5RlpKT2JpanJaSFk1ZlV0S2liZTdPUnhnM1J2NzBWb2NEV0M3?=
 =?utf-8?B?SGp2NFRzZVJTMlFNMXVZSkJ1aEtOS1RTN1JwenF6QjkrNXFUZElpTjlWNUFJ?=
 =?utf-8?B?aUM4K0wrSWc0RVBNekhqazdIOWk0dWdQK0Y4ZWNtbTFiaXJLUkM5WWFxV3px?=
 =?utf-8?B?WDdJUG13U0RqbU1saGE3Z1M4NVNuRTJ4ck1LVVdkaEc0c2hSZWt4ZTJGbVNT?=
 =?utf-8?B?RlNJQzMwUEZNQXJ1NWdiaEM5czRxajAzekFpa3FXeGhvQlNoZENEdkRBVFBh?=
 =?utf-8?B?NlhOMktYZkJKWmhDV1M2cE1ZNWw4OFVOZkpoeGR6d1NWQjV5emtHU1dxRGt6?=
 =?utf-8?B?NEkrTkdvSVJrMk9sRnZlRVJ2WmJ5WkdTQW5MeDRKRkovVjhtcjVZdzNEY2d0?=
 =?utf-8?B?YjYxa2l4TEFWUnVoYTdHVFZKU1pLVU12Y3kvaXc5eDlEK2ZmL3NNVDhWNUlU?=
 =?utf-8?B?a1E0MzhYT2tXdC9DdkF5czc0WWlDMndMKzZ6ZDJxeGdrU1RiK2VreUNwZ0hi?=
 =?utf-8?B?UUZINWIxUDNRZGNwNzNVN1NBQytnU2Y5eDlCU3Z4SVdLRmxhaUtGazRaRGJ2?=
 =?utf-8?B?eVlSbGFtRWp4dzZXOHMxY1hYRWlrZHBNbzN6ZVRKWnJMT3FIV0F6Y1F4NTNr?=
 =?utf-8?B?b0VaNG5VMy9jeFN3a1RKSkF4QmdBUVJzNHM3cWVhMll6aDZ2eUx1amM1WkNx?=
 =?utf-8?B?L0lKWTVXMUJiRVBnbEZla2ZXRFY2QVBhL3FhYXVYdVZESmk4Y05qeTN5SWtH?=
 =?utf-8?B?cXhBLzJoNVlaV0xXVmIxUXFsZURzRXVkb0djejlmamcrdkpjditOcDVKdnkr?=
 =?utf-8?B?Q0NETm9XVS9CTG9uNTFSL3hXbDdtNWR1ZFh4YktPYzZmVWd0aVpQc0NoZzA5?=
 =?utf-8?B?V2ZVVUpxdzB5TU94TkRURmNramVIb0lUS2pmTmdRWjd0ZVhKbThoQWhFZGlG?=
 =?utf-8?B?SGJzQzdzSUJUQ0JoNTdaTEY3TEwvb2hlWUFFQWo3aytRYTJVQzAvR0p5T3Jy?=
 =?utf-8?B?NWE5cTN1N1hJZEVLL0VXU2dNU3MzNGlreXVHRTRhczdyUXRQU2ltWGdCcTVs?=
 =?utf-8?B?T1I4VHZqSzFid0ErQW05TzA3WXUxNThUZ25WMGhMOC9xMnFuNkZwTmdLcVAr?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb99e2a8-a3f0-4264-a2f3-08dc9555e2f0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 20:32:09.2968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afotB7SwFB+0VaPip7C+V2lVupJgKvTIplh4LI9VBNflAGTJQDZGd0vIY+COBTXVseNu4s4f7QaH2O9ZqwWW3unYs9b7IsUIxLJ3Yz1S/8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6649
X-OriginatorOrg: intel.com

On 6/25/2024 3:31 AM, Jian-Hong Pan wrote:
> Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com> 於 2024年6月24日 週一 下午11:39寫道：
>>
>> On 6/24/2024 8:24 AM, Nirmal Patel wrote:
>>> On Mon, 24 Jun 2024 16:21:45 +0800
>>> Jian-Hong Pan <jhp@endlessos.org> wrote:
>>>
>>>> According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the
>>>> PCIe Root Port and the child device, they should be programmed with
>>>> the same LTR1.2_Threshold value. However, they have different values
>>>> on VMD mapped PCI child bus. For example, Asus B1400CEAE's VMD mapped
>>>> PCI bridge and NVMe SSD controller have different LTR1.2_Threshold
>>>> values:
>>>>
>>>> 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
>>>> PCIe Controller (rev 01) (prog-if 00 [Normal decode]) ...
>>>>       Capabilities: [200 v1] L1 PM Substates
>>>>           L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>> L1_PM_Substates+ PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
>>>>           L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>>>>                  T_CommonMode=45us LTR1.2_Threshold=101376ns
>>>>           L1SubCtl2: T_PwrOn=50us
>>>>
>>>> 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
>>>> SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express]) ...
>>>>       Capabilities: [900 v1] L1 PM Substates
>>>>           L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>>>> L1_PM_Substates+ PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>>>>           L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>>>>                      T_CommonMode=0us LTR1.2_Threshold=0ns
>>>>           L1SubCtl2: T_PwrOn=10us
>>>>
>>>> After debug in detail, both of the VMD mapped PCI bridge and the NVMe
>>>> SSD controller have been configured properly with the same
>>>> LTR1.2_Threshold value. But, become misconfigured after reset the VMD
>>>> mapped PCI bus which is introduced from commit 0a584655ef89 ("PCI:
>>>> vmd: Fix secondary bus reset for Intel bridges") and commit
>>>> 6aab5622296b ("PCI: vmd: Clean up domain before enumeration"). So,
>>>> drop the resetting PCI bus action after scan VMD mapped PCI child bus.
>>>>
>>>> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
>>>> ---
>>>> v6:
>>>> - Introduced based on the discussion
>>>> https://lore.kernel.org/linux-pci/CAPpJ_efYWWxGBopbSQHB=Y2+1RrXFR2XWeqEhGTgdiw3XX0Jmw@mail.gmail.com/
>>>>
>>>>    drivers/pci/controller/vmd.c | 20 --------------------
>>>>    1 file changed, 20 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/vmd.c
>>>> b/drivers/pci/controller/vmd.c index 5309afbe31f9..af413cdb4f4e 100644
>>>> --- a/drivers/pci/controller/vmd.c
>>>> +++ b/drivers/pci/controller/vmd.c
>>>> @@ -793,7 +793,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
>>>> unsigned long features) resource_size_t offset[2] = {0};
>>>>       resource_size_t membar2_offset = 0x2000;
>>>>       struct pci_bus *child;
>>>> -    struct pci_dev *dev;
>>>>       int ret;
>>>>
>>>>       /*
>>>> @@ -935,25 +934,6 @@ static int vmd_enable_domain(struct vmd_dev
>>>> *vmd, unsigned long features) pci_scan_child_bus(vmd->bus);
>>>>       vmd_domain_reset(vmd);
>>>>
>>>> -    /* When Intel VMD is enabled, the OS does not discover the
>>>> Root Ports
>>>> -     * owned by Intel VMD within the MMCFG space.
>>>> pci_reset_bus() applies
>>>> -     * a reset to the parent of the PCI device supplied as
>>>> argument. This
>>>> -     * is why we pass a child device, so the reset can be
>>>> triggered at
>>>> -     * the Intel bridge level and propagated to all the children
>>>> in the
>>>> -     * hierarchy.
>>>> -     */
>>>> -    list_for_each_entry(child, &vmd->bus->children, node) {
>>>> -            if (!list_empty(&child->devices)) {
>>>> -                    dev = list_first_entry(&child->devices,
>>>> -                                           struct pci_dev,
>>>> bus_list);
>>>> -                    ret = pci_reset_bus(dev);
>>>> -                    if (ret)
>>>> -                            pci_warn(dev, "can't reset device:
>>>> %d\n", ret); -
>>>> -                    break;
>>>> -            }
>>>> -    }
>>>> -
>>>>       pci_assign_unassigned_bus_resources(vmd->bus);
>>>>
>>>>       pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
>>>
>>> Thanks for the patch.
>>>
>>> pci_reset_bus is required to avoid failure in vmd domain creation
>>> during multiple soft reboots test. So I believe we can't just remove
>>> it without proper testing. vmd_pm_enable_quirk happens after
>>> pci_reset_bus, then how is it resetting LTR1.2_Threshold value?
>>>
>>> Thanks
>>> -nirmal
>>
>> To follow up on what Nirmal said: why can't you set the threshold value
>> in vmd_pm_enable_quirk() since we look at LTR there?
> 
> Looks like setting the threshold value again in vmd_pm_enable_quirk()
> is the preferred direction?
> If so, I can prepare for that in the next version patch.
> 
> Jian-Hong Pan
> 

Yes, I think keeping all the LTR code together is the best thing.

Paul

