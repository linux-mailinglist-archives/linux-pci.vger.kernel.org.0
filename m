Return-Path: <linux-pci+bounces-2531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2706883B313
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 21:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C231D286E46
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 20:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2B412AAF3;
	Wed, 24 Jan 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIE1c8J0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2EA42AA9;
	Wed, 24 Jan 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128293; cv=fail; b=e5HXDQp/hXM2d+sAC9O9nrjpE42L6aMotdee2VMedJoVKclbahgxPiMRz1dGC92xdtq/X7GCMZjgIUhVRigfu385Kj9R0MQ5bp5TrBo4039bsE9h1LKA/5Kpfm+WmOoNg37XRX0uyjEZM2NQwtbTv2PphrHvzq/z8h4TE6E11Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128293; c=relaxed/simple;
	bh=fi1tkCHMzvhXsah0g/sdO+6+XyIxDPKb5vCoOxWzo/M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZODZkdZN5Vrp+bJvnWKo8/Pd9ico90j9HFESYE2TUSXFTQzvyHbnFt/X6hYRA2z6dKitJcR32j3dGnpqqDu/upC9V5QU4GZiO68FD3BY4Y1u7EKkzh1UT8s6TdMyMI6yP8S8YH0PwHGU71sbMSQ/Jt0uiLNgqWAlRXF/zLlYWpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIE1c8J0; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706128290; x=1737664290;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fi1tkCHMzvhXsah0g/sdO+6+XyIxDPKb5vCoOxWzo/M=;
  b=lIE1c8J0iu6dsC7Y6aPIvMlMF8lbaIat72Wz3uPkcpfbR4SeLVShAOkV
   tJcuOM9L/2BVuYXFHISGTi+HbZhpO1f8ALvxbEknSYIYyrFet53VRW0wG
   Xpade8uSfG4C4wQvdgZR/uUv/W5g5Wf4rtZyi/iMeYt8VQWVHGBrjmLX5
   2t+wpl18UbHymyDmxHWXBG6X/qAkbA0DGW/3BRpghkYF+s2JQsdCfxNo8
   XWZMd8yrfLZkla5UC8RgBPLL0lxrnu3Ak4M7hU03K5qJYWUQaE4Qmu5vU
   Ve3z/N9JBpff/bnhw/bqwbDofLb+iYTYH/lRvVULvLCl2dWsfUwfGg8oY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401616376"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401616376"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:31:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="736061472"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="736061472"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 12:31:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:31:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 12:31:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 12:31:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjsD/LMmUbtDSYt4eeCKisJ2M5c/eyAhqey3CiQ8OnHGQwKJf3EMOSYTtBUC/Z5BCVUHORKAjIt4v6PrCdhfSNRIzKUJKRUX65ZYko+0X65XPAJO1sZxdTyb6b61BVRCbqnsW3fITvmkEJdAtTj0HD1TKv1GqQv9aW3LgH1cXWzL7WCVhU8pm7AWX8/Lgxk7SfN/NErla2z915tOqm7Nnowa3UVMC2BW5HSKCfIAsAo8/ec/Jim6kuaz8tyJD2yBvo2dbJxf9QL6C/PUJcsUx91tW8gJMLHLyN7xdym63jC9KPwrGltSQ5oOVgsjbdFQWpuPA9UtIzz/mav9A0Jj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbnjJqIyOQw0HJxpgN39ohLAalid0meGIXq2CKHWZFk=;
 b=E2cQrw3BLSVbsH4pDvccvZzOwo3FJX2J/mDdQdTjMht1//cRXnt5Aho8uRQVvQMUM5teCaj+M5UIHbhprepVfSMfqBVsh/ArE6P+lrBpslDLbP4/p76Iy6YyBJMuhQckBLOoKassm3p6Eo9kqTxP9XF9pfgymV8CClz7DydulXE0phuuGT0eQTJKePpAznl14Bb4EuoKiSK50akfF3R/AGhA/lZibiLCqZtWxPMiyGsf5OKq/E9wWt6/gkUYPdc1YkK4+H5dIDywokXprwg4nyn6nqZP8KNlXDCBVpOvoGcC6nId9bp2GzVbIlrBfuUGDQ2/VgXDNof4n1YTow8Mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7051.namprd11.prod.outlook.com (2603:10b6:510:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 20:31:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 20:31:25 +0000
Date: Wed, 24 Jan 2024 12:31:23 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Alistair Francis
	<alistair23@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<Jonathan.Cameron@huawei.com>, <lukas@wunner.de>,
	<alex.williamson@redhat.com>, <christian.koenig@amd.com>, <kch@nvidia.com>,
	<logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
	<chaitanyak@nvidia.com>, <rdunlap@infradead.org>, Alistair Francis
	<alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Message-ID: <65b1739b2c789_37ad294f5@dwillia2-xfh.jf.intel.com.notmuch>
References: <CAKmqyKMMKJN7HU_achBc8S6-Jx16owrthwDDRWysMZe=jymnMA@mail.gmail.com>
 <2023083111-impulsive-majestic-24ee@gregkh>
 <2023083139-underling-amuser-772e@gregkh>
 <2023090142-circling-probably-7828@gregkh>
 <2023100539-playgroup-stoppable-d5d4@gregkh>
 <CAKmqyKOgej1jiiHsoLuDKXwdLDGa4njrndu6c1=bxnqk2NM58Q@mail.gmail.com>
 <2023101113-swimwear-squealer-464c@gregkh>
 <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
 <CAKmqyKOOSBF7qDpqAp6nn3+3wAnaGmqu88Fk3KY58fmgQ-44Jw@mail.gmail.com>
 <2024012321-envious-procedure-4a58@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024012321-envious-procedure-4a58@gregkh>
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 54881e8f-9dce-47d1-9e69-08dc1d1b6f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfuMkTTJ4pDTjRqealPZJjCZ4h0h/QClfVU1qx4s0ZR4svyldSsNHtCZBAB944wd8j2v/SzGoaBsC9npmT4mBRDMtZs2Ifb1O9VryedJzsIQzE/e/l4WgI8LSoOu6UrS5mYm6sgwyBHEU9VsQbvQDA7NcxmRErJdZjlo16CqSkdduAOakTQ6ldAnEzcQcX38XlH7/Q3n+28HMVLxFmsT9P/3Gn083ATwKsMB83/vRzpUhm4HD0B6UHJjlAT+r4HQQ18AcFZ+lJWvJC0V9SPs66LrQWR0yzJ2eSZRWy2Pu7f/2i+b3zU+Pr6DeFgPuqroovrOe5j4y4XR9g5WqalSbME5C9kxVC62uPFmO/hsKwU5CndDzmzuI8kAyFmyoj2K3CbCH+8ExmchU16r98y/HR12Rr6UkovUHcOz5b8lBtFy51WvQyGabjvoLaC2toC44X7r6I/ocKiEmPw/ALN3v1Q2RWyeoIzjy0adVIptvtwQOhv7FcoIur5CVuXbRGXoTsRfTgebkozBzo8Qdi//mLRAl4+Tla/Ch3/OkjB3JWVif8ssDaV2dct3pOTVfMLu3fEt8SKTIXjJwC8OoOarOuENV87u51giKhv6uY3Rm1Vt/Tp4x02LLiXAJ18he6enquy5hM2RQUZDmfb+enl/VWamhqS8cOGoZffbklJAX9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(66556008)(66476007)(66946007)(316002)(110136005)(5660300002)(7416002)(8676002)(26005)(8936002)(4326008)(83380400001)(2906002)(6512007)(9686003)(82960400001)(53546011)(6506007)(478600001)(6486002)(966005)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tSGcvaxGA+1xIQZrCIDXmv0TDmIZRfoPpkuLHLfxMmCvPR3XLxgOQKL+BVJw?=
 =?us-ascii?Q?P7Ya1RnOrchBHyq9BXAKQa0iAGjcePEVeZnFhFs0naaLQ8zn+zS9sSctsJov?=
 =?us-ascii?Q?nR2IqWfNlFhEwfCgLGQFAt8xXLArQwjis+NO4pS8Qgrs2g8OE9FZfoKOBywh?=
 =?us-ascii?Q?b7SyUbmQNM8SovEXfuSg7w/U4qA/dKRvbZwJv9GMd1C6Ig8dYAItXFv8zoUx?=
 =?us-ascii?Q?xZZNwFeJjqmdpHxms3eknzUQJ5hFQ82BwvSKeLGsm0C2RbZoxB50JqJQgMwd?=
 =?us-ascii?Q?Aw7WoPqMtgPNhAdzA5I+t7X+kBk6wmsrRR4atiYfVR7NTUS9LZoFycF4HIpH?=
 =?us-ascii?Q?5lfKWzPkVBl8QiwqlXyMlCZ/azKsxeJqhGwSQH8bgRZ7rjHwzUdkqbKGe8d2?=
 =?us-ascii?Q?dFKzVjtzMe+jss/9KuXMI3ydrplHochNymg8urP0aM6oHHxaKLFuIwwjl4Zu?=
 =?us-ascii?Q?nXjeufkE6LOwBy0/ebnk8Wzo/Vcr2/UFXHX2KvNyps1IF36OOajInvyZqAkX?=
 =?us-ascii?Q?8SVuaXU3tNR6H3QmNxshqS/5PLFe3cTvyXx8WUk40YkaOC0/0MNOpVsWJdBN?=
 =?us-ascii?Q?LHLcE4Fo4lX3jV1AWgrkEmRPwBGyOV+Dhj34jfigXrMyZBnwkp2fPc1HYr+i?=
 =?us-ascii?Q?EcRX16xF9QuRahaB/YmQmgXEi7xGc6TYRF9Fcox8CFNEMHZZ8s9hYmCZFguE?=
 =?us-ascii?Q?khRvhtM7EtDGrM6SSY82VTKmj3rdVt48G4830v7TaYV03lvZAikAfZ7Z+OSL?=
 =?us-ascii?Q?6bbi9aqh75u8whj4gOtv9GEC6chWl5PTnvV0wduXFWTcQPoHS8qo/du9KZrh?=
 =?us-ascii?Q?7d9oWJ3DDJJ2KiNaSidWtgzyoql3AFJO1Ky2MTPMZr7kzNf8kCNMwiWPGhRC?=
 =?us-ascii?Q?ldAtaW8z/9D23H+Otzui9eOoGmNRz/OB4Em9JC1hJu9AYu0lK70qUyybq3pz?=
 =?us-ascii?Q?9n9s+rCMRkKmbeDdlHePNbQWmvrshBIWIkeN1u/IKOpAk2+ip5POa/w0oU9e?=
 =?us-ascii?Q?WBUVTPlWZBzoU6e9+6yH6RtVBshEqRu9/YvfhDc6xifMBV/pVZua9MXIZ+Na?=
 =?us-ascii?Q?sHqC2ESjbiLyjur0CX+cAlHEmTJnc4VbfrudHaHrCi2rTVdWl9E8QpoqZKT0?=
 =?us-ascii?Q?zzztVEPz6HsgkimYF9bsRNjmXIUZ1Fvaf1dffaCG+sSLlfjGYGCrlMlJgcuW?=
 =?us-ascii?Q?87QaeRLKPPNI9bDiCpWJtxs6FrOTvHPwcT4/t3dxRuw9UQH+V+vaMKbRN5CJ?=
 =?us-ascii?Q?CiDYiyMeJn2nSyxM7xIl/G2VL+sqBLhIb3IaKqCYawc3pg0o6UHlIF/7TVm8?=
 =?us-ascii?Q?4lzZw/MiQinBGfGsZZmzxMfzFkDZvMbKdCvWEBqaWxsjs7UjOOHYR+IxJjA+?=
 =?us-ascii?Q?496BHOXSEZqe/XgQlnfwEO4YYjdvMoZXqN7NOcSbJly6HUHvGjPCYDmrTK4w?=
 =?us-ascii?Q?Qdcvoui4xD53tkI76DUN048zr3FcOu/g6L3Hf5TaxrYfkurHdUPOpzvYNNKT?=
 =?us-ascii?Q?ySzkkNKL+7qYp0LGmzJg0XI46z09XPVl+zlNsEsAh+7ixEB0+yxH4WkvbyID?=
 =?us-ascii?Q?ZZvmi8AcmwSwttaafG2VJHQBDuF1yTqQVAB+LW8oS3G+mBlbNt/Ro7IF80sb?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54881e8f-9dce-47d1-9e69-08dc1d1b6f95
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 20:31:25.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3OnBqj/Ot4inxDnKK1+oO4xqrW0ij2zP1aQJez2XXQhFreNJSaG5Z2BDdnGoGPv/RuAgqoHiIxT+d0wrsWyLQpO2myiqt+MNj53idwmGNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7051
X-OriginatorOrg: intel.com

Greg KH wrote:
[..]
> > 
> > Hey Greg,
> > 
> > I wanted to follow up on this and see if you are able to provide more
> > details for reproducing or if you are able to look into it?
> 
> Last I tried this, it still crashed and would not boot either on my
> laptop or my workstation.  I don't know how it is working properly for
> you, what systems have you tried it on?
> 
> I'm not going to be able to look at this for many weeks due to
> conference stuff, so if you want to take the series and test it and
> hopefully catch my error, that would be great, I'd love to move forward
> and get this merged someday.

I mentioned to Lukas that I was working on a "sysfs group visibility"
patch and he pointed me to this thread. I will note that I tried to make
the "hide group if all attributes are invisible" approach work, but
reverted to a "new is_group_visible() callback" approach. I did read
through the thread and try to improve the argument in the changelog
accordingly.

I do admit to liking the cleanliness (not touching 'struct
attribute_group') of the "hide if no visible attribute" approch, but see
the criticism of that alternative below, and let me know if it is
convincing. I tested it locally with the following hack to make the
group disappear every other sysfs_update_group() event:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3e817a6f94c6..a5c4e8f3e93b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2022,9 +2022,20 @@ static umode_t cxl_region_target_visible(struct kobject *kobj,
        return 0;
 }
 
+static umode_t cxl_region_target_group_visible(struct kobject *kobj)
+{
+       static u32 visible;
+
+       if (visible++ & 1)
+               return 0755;
+       return 0;
+}
+
 static const struct attribute_group cxl_region_target_group = {
+       .name = "target_group",
        .attrs = target_attrs,
        .is_visible = cxl_region_target_visible,
+       .is_group_visible = cxl_region_target_group_visible,
 };
 
 static const struct attribute_group *get_cxl_region_target_group(void)


-- >8 --
From 18d6fdf1465f4ce5f561a35797c1313276993af0 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Jan 2024 20:20:39 -0800
Subject: [PATCH] sysfs: Introduce is_group_visible() for attribute_groups

Add a method to 'struct attribute_group' to determine the visibility of
an entire named sysfs group relative to the state of its parent kobject.

The motivation for this capability is to centralize PCI device
authentication in the PCI core with a named sysfs group while keeping
that group hidden for devices and platforms that do not meet the
requirements. In a PCI topology, most devices will not support
authentication, a small subset will support just PCI CMA (Component
Measurement and Authentication), a smaller subset will support PCI CMA +
PCIe IDE (Link Integrity and Encryption), and only next generation
server hosts will start to include a platform TSM (TEE Security
Manager).

Without this capability the alternatives are:

- Check if all attributes are invisible and if so, hide the directory.
  Beyond trouble getting this to work [1], this is an ABI change for
  scenarios if userspace happens to depend on group visibility absent any
  attributes. I.e. this new capability avoids regression since it does
  not retroactively apply to existing cases.

- Publish an empty /sys/bus/pci/devices/$pdev/tsm/ directory for all PCI
  devices (i.e. for the case when TSM platform support is present, but
  device support is absent). Unfortunate that this will be a vestigial
  empty directory in the vast majority of cases.

- Reintroduce usage of runtime calls to sysfs_{create,remove}_group()
  in the PCI core. Bjorn has already indicated that he does not want to
  see any growth of pci_sysfs_init() [2].

- Drop the named group and simulate a directory by prefixing all
  TSM-related attributes with "tsm_". Unfortunate to not use the naming
  capability of a sysfs group as intended.

The downside of the alternatives seem worse than the maintenance burden
of this new capability. Otherwise, this facility also brings support for
changing permissions on sysfs directories from the 0755 default for
potential cases where only root is expected to be able to enumerate.
That may prove useful as PCI sysfs picks up more security sensitive
enumeration.

The size increase of 'struct attribute_group' is a concern. Longer term
this could be reduced by consolidating the 3 is_visible() callbacks into
one that takes a parameter for "attr", "bin_attr", or "group". For now
the support is gated behind CONFIG_SYSFS_GROUP_VISIBLE so it can be
compiled out when not needed.

Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/sysfs/Kconfig      |  3 +++
 fs/sysfs/group.c      | 50 +++++++++++++++++++++++++++++++++++--------
 include/linux/sysfs.h | 34 +++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/fs/sysfs/Kconfig b/fs/sysfs/Kconfig
index b0fe1cce33a0..d5de8e54a06f 100644
--- a/fs/sysfs/Kconfig
+++ b/fs/sysfs/Kconfig
@@ -23,3 +23,6 @@ config SYSFS
 	example, "root=03:01" for /dev/hda1.
 
 	Designers of embedded systems may wish to say N here to conserve space.
+
+config SYSFS_GROUP_VISIBLE
+	bool
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 138676463336..0a977064e118 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -127,16 +127,36 @@ static int internal_create_group(struct kobject *kobj, int update,
 
 	kobject_get_ownership(kobj, &uid, &gid);
 	if (grp->name) {
+		umode_t mode = S_IRWXU | S_IRUGO | S_IXUGO;
+
+		if (has_group_visible(grp))
+			mode = is_group_visible(grp, kobj);
+
 		if (update) {
 			kn = kernfs_find_and_get(kobj->sd, grp->name);
 			if (!kn) {
-				pr_warn("Can't update unknown attr grp name: %s/%s\n",
-					kobj->name, grp->name);
-				return -EINVAL;
+				if (!has_group_visible(grp)) {
+					pr_warn("Can't update unknown attr grp name: %s/%s\n",
+						kobj->name, grp->name);
+					return -EINVAL;
+				}
+				/* may have been invisible prior to this update */
+				update = 0;
+			} else {
+				/* need to change the visibility of the entire group */
+				sysfs_remove_group(kobj, grp);
+				if (mode == 0) {
+					kernfs_put(kn);
+					return 0;
+				}
+				update = 0;
 			}
-		} else {
-			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
-						  S_IRWXU | S_IRUGO | S_IXUGO,
+		}
+
+		if (!update) {
+			if (mode == 0)
+				return 0;
+			kn = kernfs_create_dir_ns(kobj->sd, grp->name, mode,
 						  uid, gid, kobj, NULL);
 			if (IS_ERR(kn)) {
 				if (PTR_ERR(kn) == -EEXIST)
@@ -262,6 +282,20 @@ int sysfs_update_group(struct kobject *kobj,
 }
 EXPORT_SYMBOL_GPL(sysfs_update_group);
 
+static void warn_group_not_found(const struct attribute_group *grp,
+				 struct kobject *kobj)
+{
+	if (has_group_visible(grp)) {
+		/* may have never been created */
+		pr_debug("sysfs group '%s' not found for kobject '%s'\n",
+			 grp->name, kobject_name(kobj));
+		return;
+	}
+
+	WARN(1, KERN_WARNING "sysfs group '%s' not found for kobject '%s'\n",
+	     grp->name, kobject_name(kobj));
+}
+
 /**
  * sysfs_remove_group: remove a group from a kobject
  * @kobj:	kobject to remove the group from
@@ -279,9 +313,7 @@ void sysfs_remove_group(struct kobject *kobj,
 	if (grp->name) {
 		kn = kernfs_find_and_get(parent, grp->name);
 		if (!kn) {
-			WARN(!kn, KERN_WARNING
-			     "sysfs group '%s' not found for kobject '%s'\n",
-			     grp->name, kobject_name(kobj));
+			warn_group_not_found(grp, kobj);
 			return;
 		}
 	} else {
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b717a70219f6..31f3dd6fc946 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -77,6 +77,12 @@ do {							\
  *		return 0 if a binary attribute is not visible. The returned
  *		value will replace static permissions defined in
  *		struct bin_attribute.
+ * @is_group_visible:
+ * 		Optional: Function to return permissions associated with
+ * 		directory created for named groups. When this returns 0
+ * 		all attributes are removed on update, or otherwise the
+ * 		directory is not created in the first instance. When not
+ * 		specified the default permissions of 0755 are applied.
  * @attrs:	Pointer to NULL terminated list of attributes.
  * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
  *		Either attrs or bin_attrs or both must be provided.
@@ -87,10 +93,38 @@ struct attribute_group {
 					      struct attribute *, int);
 	umode_t			(*is_bin_visible)(struct kobject *,
 						  struct bin_attribute *, int);
+#ifdef CONFIG_SYSFS_GROUP_VISIBLE
+	umode_t			(*is_group_visible)(struct kobject *);
+#endif
+
 	struct attribute	**attrs;
 	struct bin_attribute	**bin_attrs;
 };
 
+#ifdef CONFIG_SYSFS_GROUP_VISIBLE
+static inline bool has_group_visible(const struct attribute_group *grp)
+{
+	return grp->is_group_visible != NULL;
+}
+
+static inline umode_t is_group_visible(const struct attribute_group *grp,
+				       struct kobject *kobj)
+{
+	return grp->is_group_visible(kobj);
+}
+#else
+static inline bool has_group_visible(const struct attribute_group *grp)
+{
+	return false;
+}
+
+static inline umode_t is_group_visible(const struct attribute_group *grp,
+				       struct kobject *kobj)
+{
+	return 0755;
+}
+#endif
+
 /*
  * Use these macros to make defining attributes easier.
  * See include/linux/device.h for examples..
-- 
2.43.0

