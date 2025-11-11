Return-Path: <linux-pci+bounces-40848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ADAC4C6A8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 09:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F00188D0DD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39592BE024;
	Tue, 11 Nov 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkHoZoCg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66F26AA94;
	Tue, 11 Nov 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850083; cv=fail; b=Yr0WvxgPTblNRgi8VM82sIUArO5Pkqku4r/X4y/c4PWoB+S31a5HUNP7qWf7aJAHJEVwkBcRrakHMlLyHJz73GdSgGLe6CDliCSCSXaYGjgrNEQwQ/R5tkKx2xLGCHrzkIgRDiAW9GxvbwRLiDbHqEDbZBGbH3DDXkcbfcR80aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850083; c=relaxed/simple;
	bh=1wQYo9OVNRWFWnA3Mk4hRExVxImMGw7RZ6+Qi5UeLFA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DKy3a9HTFG2paEesaIGQJzYyMzgOybzdGK3559xnbOPWMA7gTMGfMo7KYrkN2RKlLb8tPWkN8Bu4wciA9bQiw9nsK5i1aC3NeExI8fUZRhXlV+7W7edYNZh/7X16RF8yDBhDsNz1/sZ+3rL+LWqElVKg/LMv+B+U17pctBxvISY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkHoZoCg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762850082; x=1794386082;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1wQYo9OVNRWFWnA3Mk4hRExVxImMGw7RZ6+Qi5UeLFA=;
  b=XkHoZoCgmN/1K9W1C4oDFyN+tKrGYDX3aJomkys8MHtKz7G+/DaFetII
   UWPiBKH0uXGD3M2zJrxpx2NxY4NTXJ/WmOza/KS6AlDM+KPWo7g+Jco7A
   B/LBxOIiJrkI6nSNOVsBE+IoJgl70e/Hp7vx9EaIOyxtag0M17E72kJ1U
   +qMF1tuN1+ox4U8PUb1zoQrhgtzTKEKJN3W9+DnKGR8qA+j9bgS0IDjiy
   2SmoqFx2X74wAJr8pkyTBo/P/RAUvEugTPlLoQz9b57eWcmnOhLQLsjcQ
   u+R48Sg+IX0lpRqtd84wlY2GWB00nKIqwD0V6m6XEjKAKhMjJ7Iuc7Zge
   g==;
X-CSE-ConnectionGUID: /ecVsbjLS16mBzdY43K+dg==
X-CSE-MsgGUID: xDMn9f2NShqiLd5aCn+zjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75204467"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="75204467"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:34:04 -0800
X-CSE-ConnectionGUID: 7lu2UZ2kScO/Icd5+0ARpA==
X-CSE-MsgGUID: Gj7hFKv1RouM6mDPIPAm7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193287661"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:34:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 00:34:03 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 00:34:03 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 00:34:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIAkdnROZYp22YUqD4vtHpEGcOJEwbCVbsinxmy0Dgfz3GvrlqrMYwpUp61wPlsEbw1F/CRpcCXpzaOC8KiiuGGZS0jNKRPugEU9frfsxXsR+vz/cDLh+NSp4VHfXEfgSa3y+7n50+Lli+tcynWgkEMI0LjRgazXFm1CivUqf4IGtZur2BjaOixX1DiO52K51jca3D2TSxhdxj8DbzzSXw7+Yqs5SPrHgZcOx8X5TliOVE40dVLizjgZSAZgOl1mpQVOYTZQpuHSzmef+ktnYLi0vXZEIqSseFwSHXm1vq2JysCzH3CjXGSuTQXS76wdqJ21HmQMZFfr8N/G/uVSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHDIa4pRylSmX4gCykj1fX3dVHV3hpPVVF09OxfyOwk=;
 b=R/OoucvWYDrJr4wYEVBeYgVlD5cv1qEzkgqCGz3vZX4YbhIat3+8TNiUeeZ8j6KQqXVnoA03RAXkVkBKAHB3cNtTx+LMoLhgMUpFW/3qiC1zx1XMYn25craFaD2FisxwjgVuHsq+aQ3krMsuaKTTvi9TGsIvtWzS3E3N+qagCVq4QLQKhKd1KuPFmkoqfTnSt7jGk3clPiz9cuSWF47P5nVbwQtj+f3+CEtSCS6v8bPHZtcJ/udAU6g8+ykROSXqYEoggZ7IgH0ISr2QolSkGsOgG/SBJL+t2TkwvpQLhrPsMgA2ll7fh86idpdm5r6jY+XwTAqV5ESwvIt/Ci+mwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by PH7PR11MB6499.namprd11.prod.outlook.com
 (2603:10b6:510:1f0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Tue, 11 Nov
 2025 08:34:01 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:34:01 +0000
Date: Tue, 11 Nov 2025 00:33:53 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aRL08Y8g35xAzGLA@aschofie-mobl2.lan>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-18-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::15) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|PH7PR11MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd2dcf8-9ce6-43f9-e2cd-08de20fd1073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZoCVp4522p5LzEJlX9apIBHyhqrbSYod6JDGtZwKOYFYxbB1RqICaqkPw8K5?=
 =?us-ascii?Q?7/mMaQuwEGOI/tE+YpiBsnjS04e7JGECJ6y7A5sb/Z4BMZRj0ODDdyib08qB?=
 =?us-ascii?Q?pUax8sGCouGBtrgNaM2J5cYTM5An+g8UV+XFuun9U8Qe9J8/8l402IO29D9b?=
 =?us-ascii?Q?vkcricDqlY/z1ooheavFVGZLiWxB21K+Wa1C25boAKgt2XSp7CV3+/FlMOC9?=
 =?us-ascii?Q?NQ2qBo8hjwhFhbS+FQpg1TsAhc/2pCO/H5RHc3urUFOKyk4j6+UMWTvMUl3J?=
 =?us-ascii?Q?N7uJNxZKiPPy4asfWO6Z7W1fV8L6lvuJTtHWc3cO9oG+hM8vbeJz1Iiywti7?=
 =?us-ascii?Q?OjK8J482RM24VDkvWE9XaR3PoBhHTFUXxasLVhHJhMy75Jaya5BKj5df6AHb?=
 =?us-ascii?Q?4E5xOdutHSyDtWzwungUWyTtj+IVSygPlKRWcYcTs/ehkacRk/j9SlyvADAq?=
 =?us-ascii?Q?/k45DLPPwajx3305Ys/3FdODBmfi3q682f32MeCS/LXFwFenYV9LOuOGP+v3?=
 =?us-ascii?Q?2iDZJKTLMhDpUq6/BxyEghDacHUecR6RwNx1dS8IS91aRBGyxQhZUBODJenV?=
 =?us-ascii?Q?Ycpy7N+2obmYL6jzQFdPRZdCS6QgWw02vARcmJFOlWUZpqWBnreBt5XzJmXm?=
 =?us-ascii?Q?s56Nb7miqf/blX5hh5OxEL0tRSPdbWY7+DyzbNPSImV1qQrh4TW3gk6mh8Wo?=
 =?us-ascii?Q?f042XYCBZzPt78kbB6Y64L7jxZ4FxkUVmvdoZ1hssLW2qDluGJCeEs7Nko6h?=
 =?us-ascii?Q?Y825rxeuLaJBve5Sv5VJnE1/rH53KyyEDhgkyGeW1IOGMVpQfJk7QTu9OH13?=
 =?us-ascii?Q?fDyvzfl0X13iVecZh6ZqfVwn5K35bXh3vpQ8JYh31M5BU7XfG8pkQiF/371o?=
 =?us-ascii?Q?s4Ox3AKPAz2fDUTDje+QOlLwl52cwj9CcQhXEjRR7pXg4YBUD8bxo+rOdxRM?=
 =?us-ascii?Q?cs9+ZcxBu9HaIWHMMSI8j3RuL3Kig9cZVPIxz9PSgmtNpCGGWAZPyluEYcns?=
 =?us-ascii?Q?ukxdG4O1ZHAJGusdLans0i6Qv0tj9tPb4jtey9bEJVjMeHJ8F1hJ23b2M/cf?=
 =?us-ascii?Q?RSTyf8ddF4vfHVZ+t8zxsbSOsiXF8THBWgsBOkcd3yTzUoaPV8pLIpGiLrNb?=
 =?us-ascii?Q?W4ewr2tOUW+f7X+naBeWbWCzZoupF39u0NhJlU12ZNWO58jaV62cVvyNKgiY?=
 =?us-ascii?Q?rsTlFHZUAlIyjG1R4ajeh/BbTA5amYgNHf0WCiEang+lBuIt6b0+vWFTjyFF?=
 =?us-ascii?Q?WGj+DUzKTVUxoqRHT6Hwh7/mCuhjMKJW/c21yj5LYUBv6wk+yLo/Vv4LIcZa?=
 =?us-ascii?Q?k84UVpu/AiDdunbWjLUfhMasSjBY0I6MHRuI25qJQsZehGrrAOACvLZ+uuQx?=
 =?us-ascii?Q?wTbfNm9dkJhJ7c0OX1wwzzP0SmBQ1OKwtc92lcoMq5aV8Hm2hF3mQ1AucLqy?=
 =?us-ascii?Q?oVtWn74lr3qx5yjhmaLalJlG4mwZWBM7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lhgLB3rvChX/bPGnDryNg30nDIjuEyN0MoKHG0O2r0G1Zq8O3uzPpBrmIWmt?=
 =?us-ascii?Q?R2NxuFmrusX2S1oZ30FIJznFiyaMqgOxH5tfFMW6jazsuZgmn2aL/wesET67?=
 =?us-ascii?Q?tD6b75zZn/YeqnYDXH0vVvYvVCvNM/GU805tYXsQWssphWU24aO42EIU4BPv?=
 =?us-ascii?Q?FjLaTmfaIqREtA5JJpIXFo4VRQFrFdNgmXXKxPfh05oVAPqWyRYxa16hcq6z?=
 =?us-ascii?Q?Zp0ELbMN2IiaqenTDOAJy1LvgyPZuJv6ImL/QyHvutAGL/efVAnRs9B7hLGQ?=
 =?us-ascii?Q?fYK7wNLXzI0W8ahFMkUEwwS2fj1SZJ0fMIf5tCthxgEvo0Ml14c7nA10ssGo?=
 =?us-ascii?Q?wYoFVZg2pZBIbgW5J17wSQE8K7Tai28U7+vZ+Qx+wuysndTXB9gDRNcyjYRY?=
 =?us-ascii?Q?sQSv1GnIV0hgt+xgMc3j4CPTYGrMzzBTpvEacAItnOQan8O0gRNtQbt3XQk1?=
 =?us-ascii?Q?3k2J/Al5db3giaa3DEoG9gkHx2SFO+sVRDAeFQsK/5j39H4oJy7ZaJGxqDXr?=
 =?us-ascii?Q?tN7Q5j+RO2QMKBvYEDnL45qjMszB2HGAo+dgoI6prAhR23xTzCJzhVnorSUU?=
 =?us-ascii?Q?Zwlcj6v+QgEWvKhLadT+5ln8laPi78loiMrHFGXVaSEXQiot4dQSpXxOeN2w?=
 =?us-ascii?Q?SPMSX0OT3KfYVYShmHZSFgtZ3UzMSaarxIgeSv9YfPiuyfV6yzXPbFeKhR5S?=
 =?us-ascii?Q?szIKDAe3NHrgBiKeCZBlG6ZT6fiivMaOAoixsj1Bam9odKld33uEdM6NBXir?=
 =?us-ascii?Q?rkG4EFUr1PIzOPA//K5PVydNiKKsveWTeU1jldUcGxxA10dhls26ejBnFsQQ?=
 =?us-ascii?Q?OoaaZgl5e15waPfsknlVT8bnooOF9g1+9nKMetzRomOqSV6oSeYNwQ/xcvHI?=
 =?us-ascii?Q?rpfGkVWR17HJemOblOb4OTnhld6UDtdMI2waskPM5bOx4/seHkXf36todk0E?=
 =?us-ascii?Q?iNUNp9pQnsEWpLvFXw2bW8aF9iK3ODsylZo+UiMgPDnePUqLxny3j/nbL8BJ?=
 =?us-ascii?Q?uSiENQvz8lKvdcFiLoIDkFyQMhVv08dL5kBC+tE+qP2nf8GsWsIa+EfLxUYE?=
 =?us-ascii?Q?7RJh0LWRxMgCtUcMD3XiedUhcz8sptorolU0jHDtSPIJc2ogZ3hOiXHRFE+y?=
 =?us-ascii?Q?ZhLwH6oFPSoSWa9DAMDtLhH8ZL1VZ90L1VtJHU38nLnxC05UK+MpfABRgSyF?=
 =?us-ascii?Q?RzCZv2wdlhKJNyooTQz/ITpdVFinpwT4ccBND38nGipYykWLkdJmycrV8P/P?=
 =?us-ascii?Q?/SIu9RkMZcP0PfZEsE/Op0CUYzJpoU4/pbnr/5onokIa+EfdWwNABpEPp7tJ?=
 =?us-ascii?Q?7nmo2BwYH6n18avTHIwFhLORS14mvIq6t3fzPUtfbEC61RtiuKOUnRuolRfi?=
 =?us-ascii?Q?kgsEYZoAMKkP82pSLid567GWm3SU2pEnwc/CraF9wVnfVFo3IBvMIrIZGkQh?=
 =?us-ascii?Q?1Jc+9rPhsKpMbBmmMGea460Ln8tJ1G3kgmAllTOKPddV7WnA9CfaZQK8zHmM?=
 =?us-ascii?Q?I8qCLcNix+4UaP9UT1y7RfjlF29VTyBbKM0Z+IQn8Sn3uDf8gAa8Awq6yGfd?=
 =?us-ascii?Q?iR6Vw/ckwqAzSbHnXvA9XEbrTIU2+6s+OyszQL3Gpjb3tpP4YMinJmQGXMWM?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd2dcf8-9ce6-43f9-e2cd-08de20fd1073
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:34:01.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5QPKzItEzwwdvni35KD15sOdgeoLbQCKMPGu1EmEXsLybUEaJerEMBbzZ6l/BOExT8Xs3I0PZz4/Z+eD1ePy3glULdwMkMCKqJ38upO5tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
X-OriginatorOrg: intel.com

On Tue, Nov 04, 2025 at 11:02:57AM -0600, Terry Bowman wrote:
> CXL devices handle protocol errors via driver-specific callbacks rather
> than the generic pci_driver::err_handlers by default. The callbacks are
> implemented in the cxl_pci driver and are not part of struct pci_driver, so
> cxl_core must verify that a device is actually bound to the cxl_pci
> module's driver before invoking the callbacks (the device could be bound
> to another driver, e.g. VFIO).
> 
> However, cxl_core can not reference symbols in the cxl_pci module because
> it creates a circular dependency. This prevents cxl_core from checking the
> EP's bound driver and calling the callbacks.
> 
> To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
> build it as part of the cxl_core module. Compile into cxl_core using
> CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone
> cxl_pci module, consolidates the cxl_pci driver code into cxl_core, and
> eliminates the circular dependency so cxl_core can safely perform
> bound-driver checks and invoke the CXL PCI callbacks.
> 
> Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
> parameter is bound to a CXL driver instance. This will be used in future
> patch when dequeuing work from the kfifo.

This one was troublesome in cxl-test, more circular dependencies.
I noticed you and GregP chatting about it, so I simply remove it from
the set for now (made all callsites true).

With it gone, the set builds cxl-test and passes the test suite.
I'll watch what happens with this one, and can take another look at
the cxl-test issues if they persist.

A bit below...

snip

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/core/pci_drv.c
> similarity index 99%
> rename from drivers/cxl/pci.c
> rename to drivers/cxl/core/pci_drv.c
> index bd95be1f3d5c..06f2fd993cb0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/core/pci_drv.c

Needs:
+#include "core.h"

Compiler is warning: no previous prototypes.

snip

