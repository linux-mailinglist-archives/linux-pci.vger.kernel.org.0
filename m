Return-Path: <linux-pci+bounces-8196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB678D89C4
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 21:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7191BB20150
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC77137748;
	Mon,  3 Jun 2024 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7NbjmLf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992D3A268;
	Mon,  3 Jun 2024 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442109; cv=fail; b=oImBfuWJ7dHWEt4BIoZ5RUXUR0DQb6dQyR8YQ+hBy90G4BFbpRKT3CP6qLTzwSXLqRQsuhqxDLTp5/ooT2T4HsvCX5Vhg3+Ko7J2LcWRWiJKqIZc4rjbJ8wMiu/5vo2/RWtqdbHpje0KrJxf2MRMghPL60uDbefJLLY2LADTnd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442109; c=relaxed/simple;
	bh=KDF8NPFhBYh4v1qTxVX0qBG4dWY+XeqUGFU5g8fstCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dfBNpikhJFJMqUxJUdHU/fHOV/vfmKZxEBELE1hcW6WilXFZMX/wJwD7cWaGYUiUn2rmoEuFpgk8wnzIZhBpxp6cO95tzFURd74HlnVKrqUPMguQw9doSzLBPYvVPqWonSHPbtL+Q5swzJ4ydeP7P0+L4g7NYPAjcG+uy7Ypi/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7NbjmLf; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717442107; x=1748978107;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KDF8NPFhBYh4v1qTxVX0qBG4dWY+XeqUGFU5g8fstCo=;
  b=T7NbjmLfr4p33BjfYMvuJl9ipOI29uxl6/vxrzKtX/du2a5/w3uMVTbN
   pBezBfzYGpHTcQmKiAgEeHKEFXaN89pdhD+yWm2b6IcC1IzzLBaVXn5wn
   baOcSnqXhme1tBcvfzd8xBZMqUfoIiCso8LK/TViKMDn54tFkyZ089W8N
   OuivwI3aEBCAKvGHL8pnS5MfxSQCAE4drrL2d3/IVDAHBo6Vksq8e4LlB
   TKUdWnoVfw1BoZ0Q2+VMa8mV4YP7qP38/7o2atYpLpMlFRuzSv1auUxTv
   9EnhzTN8Osv9qF1cHPLQwFrNPWmSKObX7bU9XyRk7ofbpoTWko9s/C9uA
   Q==;
X-CSE-ConnectionGUID: hY05C/zBRqyfFZYyptEf1w==
X-CSE-MsgGUID: wP0Y8ea0TNyTC4ROP4S5zQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13703506"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13703506"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:15:06 -0700
X-CSE-ConnectionGUID: ET9/LhSySs2tQhU+FgcxLg==
X-CSE-MsgGUID: Rw5P3g2UT0elnqAWcNzEzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41901994"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 12:15:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 12:14:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 12:14:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 12:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV5Sz28uQj5ZpPoOyB5t+F72itf4+csq43zIv7OS3Fqa386xXAm027JJ27ct8Gmat+HqOHDJ3ltTPXeDZA64Os+ShHk9kDSvYFWhvwesaxBZP2b/Nu/Ej4Zsnji7ELWbn47QhwDRQdFrjMYmXwpS2NEjG2bQFgWnAvr8Agv8/gJwnhG8V4J5TP727OQK6L85PaGppSCSGv0ub+H8/GFgh5bjSidsX9FbfUIa63n9yxabGJAvNMhDDdLO+ac4ORbSoG93cyY8/Z1i7RkyY9e7cvMVtiBatDptI+7arTmk2u1ku71jMX7e9OU8YGBh5qj7ZG2sdrLf+nHtyF3RZVRa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgoVXb02gh8WWv4P8QXjX42mmRDIlLJlsAy0k+VioXs=;
 b=j48JqgsrAXGdgfHwTDuJ4RXyMPLP31yJQdTgB/ClgCslwO58wzGoBgs7u1AvvDsOsM1BoBRFv7mUeh9i4xY03AqExyfIiQJlN7evZYyti5iYG1leh4D85G7+QZbgdowJSZNzUYvNpMq2wM98DfJIyIa//758iI1P6UOJdt2tbuEBLbmO5Wvk33sEPo5+dorXTVHy9X/Zp8onDRIa0kRzTK3+89K4xRNXjAz/BnLnUoBWxcQZMshFaEfrFPsr2o5PrFCN2Fdpc21WXRkKN0bOuzzB9uHRpWt8A+jd2wjqgvkSsA/+SMZLPk2ivYNu4K5FEFshrD4ZaxXrmXJoDLBoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Mon, 3 Jun
 2024 19:14:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Mon, 3 Jun 2024
 19:14:57 +0000
Date: Mon, 3 Jun 2024 12:14:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Kalle Valo <kvalo@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
	<regressions@lists.linux.dev>, Jeff Johnson <quic_jjohnson@quicinc.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
Message-ID: <665e162ec4b2d_2a90e294c8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240603165342.GA685076@bhelgaas>
 <87wmn5ubfo.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87wmn5ubfo.fsf@kernel.org>
X-ClientProxiedBy: MW4PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:303:16d::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: e90c5c52-3f94-4b56-68f5-08dc8401750c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q1KPP6OfOMrz3BENRG4lJ/l9vrqq/1Oo62kLrivPnfOwE3ZrkqP8G7bDpSV2?=
 =?us-ascii?Q?Z8icRzQOPR4IRY9elewOYUEMVnasxew7WvMMs7OjdNnF0YuxpvohqFiNQ4Da?=
 =?us-ascii?Q?WzaeGWJB0SzGm/i2nqAnN6FFv/C/oLu6BcKij9MU3xZKIJYKZTMxCuA9e+vA?=
 =?us-ascii?Q?SnPkSPvh223/jWLZ4oRO7tBI6b4WfLngYeAZdr7ehk+hzjPOoYy5QXBbiXQ1?=
 =?us-ascii?Q?dHmxXwhDXe54m3VlUvZIbSLty7LiRdb3RzsR0DDu+9rLVR9yQHv+h35QKHlb?=
 =?us-ascii?Q?jZsVbC6K9MGnrafk3/wD7M0pXdyRMPXdomLLOAqQNE3rdJp667CzUYMXtXXs?=
 =?us-ascii?Q?ngmFM983+2G88oYErYSD4zNgRTi2fcpBzQE0TEKT11P+xB/0A2gVxRbBV7MS?=
 =?us-ascii?Q?7CcQD6rGb84yQvDCT5mG5p17YHVO2eKf1oPFqNXdEr2LuPM+kzfGKIUiGX67?=
 =?us-ascii?Q?vS8yHCzSo/pSmG9CueDzQb/z65vyd/PsS6vOC2FP0qaWPEgwlinJdzgBwh9s?=
 =?us-ascii?Q?Disygzh0p8LH3JiDEc/NZjSNNcwIULQNV4TWdO+MHLnyFIzoKfpfKVir+6TJ?=
 =?us-ascii?Q?qqgkH1tME8IsiiO17kWvMZXD/lNgPVW7/0/ty1CnfpaigQ4L4KoMkiMbUeJe?=
 =?us-ascii?Q?U9EMYrxZ3jzDzbvJwK4ZAacmQxus+QAk61+VgchdrpqJEw8p7SskSvxudwCX?=
 =?us-ascii?Q?+gGepm1pGTeBRgWZouXsj2H5/FhDRFIHwdA9WJJdFruLkiE/DPvcWf21m1+Y?=
 =?us-ascii?Q?YPJUx1UcxvZdcSYlVq91xqFJ16tQpvu3q7VLKbSN7eGELT0pffM4RyCPLGXN?=
 =?us-ascii?Q?87m7osccUNqvNjGFpuNYz/DJuUPyJIlpaz8w3w8Z7/marJTkmirftOc9oXyF?=
 =?us-ascii?Q?PWk2S0S7TuNC/LjBKHzqKVe0WogGxpH5O5mLsJQ/rD7vtOkqH+WsKHznvqYp?=
 =?us-ascii?Q?FgtY5qRw54N8tp+3Ddf9FYOqnDFgmMtXTDVs5F/X7F1P2zVKtfhuCs63+Y8b?=
 =?us-ascii?Q?vDrfHoxNEQns5ImINp+/2eJAjyheoCMZNiA/5ZwNVioNdAwT/9Sv/2nePDpv?=
 =?us-ascii?Q?0pIrw8gWXsVw/6L9aDNBsPJJD5a9xz6A9/hsvMyFknWHXI2hNDd25ZD8GFb4?=
 =?us-ascii?Q?h7elZLGxpGbqSOqbMOaoxgN6YIl2LiTU+3j4GUQNwjJz6LMZhlR+8iUh7TpN?=
 =?us-ascii?Q?GSFbMIShPArMqipLKiw4GqscQXEZXC+SnSqPmf4s+aiIcir+6xU8TUhnEv/y?=
 =?us-ascii?Q?tjgoTJM3brmcea5gVJNskkdOmTQfuhfr8xE9O559uQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IImEXUR+TluzgLIQ7/55bP0LEFtJ1URok6sXyyXrYsP/Hm3QHA9FBFXUaRlF?=
 =?us-ascii?Q?lCOa8DJ7K+myK/dm3/xZs+WMJ5ayTjP4+06/Yns2RbTKShQfJEaFkUWfHUba?=
 =?us-ascii?Q?qWgIgYKibAnd+E/zqINcZptrMHba8KYXcPV8TMlYGEmxZCqVj9BU4urJZLSi?=
 =?us-ascii?Q?3UnW5OKEbxlN0FBUP9fNy8/7pZdrQrz4MtFTGSiG5oyzyiCZ6pMI/YrLhwHN?=
 =?us-ascii?Q?jTaYKjiH9skjSp+4YzKT7f80fDhNL/LoMMlEESOIpSNXxzLNfdGNeKvH12mO?=
 =?us-ascii?Q?A9g1/eiXM0j/53hh7JBkd4Ee1I7+L9jAbo1VpXDKBLgtYQb0wkNnvtoDubtS?=
 =?us-ascii?Q?O0x5QIcG6X1Rg4wZAgwWx6dyk3peH+rCTIqlC4e8c7rbwytnwo2FMGMgNiHM?=
 =?us-ascii?Q?XnJGgqXa4LV2K0LmDzFgUVCcjygMnS/9oYntjijZkpb1wdQCwqQwAFAYCYcv?=
 =?us-ascii?Q?1XHuWIszlB0qPXeoye2cibaqSLjmGwBsNTEcXN65sOhfudhjD3uCuWyBgS+t?=
 =?us-ascii?Q?K4jBHTs0tSjcRnsNRm6Kw5qM95tBdMrBmQ2YP4f7IgNAU8jnJIxTOcu92rF/?=
 =?us-ascii?Q?keNR8OZZzFsNExjNYlmvLbnhFe1NQ8CXH75/tu0W4sRxNEVoQ3N+LeLj82kr?=
 =?us-ascii?Q?ECg+DF1YYEi+8wvUREAxtjA+KIU2H2kWLvMoK60iryadvPuBPIAEwnGUrU0k?=
 =?us-ascii?Q?ovxgLDdwGr4/Vbb8K+HNUpov2DTDVZop0VQwHo/nkDZbxf1DpQ+TnjTBl2Ud?=
 =?us-ascii?Q?kbKbRKM59mCgB/1Ex8tEcNLHR90LvDJjBH4NadgAVvi9/wsEDnOwQk+MW1iv?=
 =?us-ascii?Q?njxM2y2OzBOfnAH4prz1JwL3lTb0+Vm/AZIOpQI/1ZPmCCBBxfsfVoa6YrMn?=
 =?us-ascii?Q?dAFhUBFZguXz0ZTZqt+6INw62iWfUycg6RfgTs5DP1vdw6nuzQp131OSsF1j?=
 =?us-ascii?Q?HsIWNcijODUSNN3e4JTkcfalVZMelHnqc1iuw+1dxe4nleBN9R8g/uO6lkkp?=
 =?us-ascii?Q?74IYs2EcygM+riiH1e469PZzenIPBTeDBaOKVCCuc6q9fDkMKINistNdaHx1?=
 =?us-ascii?Q?/v2F+SPqEwOCn2p5U/OxfDZzD6/0LvW8zQ8z5Q3kaFx9YRhqxJpGMQTKKc/c?=
 =?us-ascii?Q?ZiEB8D+Pa/CvRozcMIgq97/HkEC/DUIb8gKDr8/zj6I62Tb6W2iOVAmMhtuB?=
 =?us-ascii?Q?8yM3VELhuKUvzr6/nKID0ClGAI4LHB306D9tYVbTB+mDdGwc7iFft2YKNofr?=
 =?us-ascii?Q?ZTMw9HQ2h9E/EBg8x37B/MXg7OlBgSG+D7E5ampE6RkOdo1KX9rq+FYLJ9MQ?=
 =?us-ascii?Q?4LAS2wdH/yZjoDF7VqGgkmNY27bidoP6OskEJUohce+nYON+vp+NE+06KR39?=
 =?us-ascii?Q?G6sewZxrlLFmvmYvPvkTiiDTnLHKO/LtOZCPCNAfqx3YhcvusWhYDWw7vrP8?=
 =?us-ascii?Q?D6uZO8DDvOJ1oRSK/497+4emenG9YCiFvozHY2Wxs8N8HYHpIiVx0g9mhqFA?=
 =?us-ascii?Q?fvS9Ir4AdiBULndUjbtRbRZfMVCzDT3INKxzcdd1TxZ08eViegl4p2wl81Ir?=
 =?us-ascii?Q?PX/MNk/8IS/LQIvL8mFwRp2kdBzsC8bMiHMv0rQaiRb2QY8cm6DlNkkgvRfY?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e90c5c52-3f94-4b56-68f5-08dc8401750c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 19:14:57.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5O7I7j2geDc3oXzypZnr7qfM1xygkDfxyZzWa6WolWcoIAiscfRD8vMlWjMjUEJ5+pkhLcZ5BihZrxjqapA+4QekTYQAWzoZRRBFg3cvuC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6219
X-OriginatorOrg: intel.com

Kalle Valo wrote:
[..]
> > Thanks for reporting the issue and testing the fix!  Can you please
> > respond with your Tested-by to the actual patch(es) you tested?
> 
> Not easily as I'm not subscribed to linux-pci list and I haven't
> researched how to import mbox files to my mailer :) So feel free to
> ignore my Tested-by tag in this case.

I have had success with "b4 mbox" and importing that into Evolution, but
your mileage may vary with your mailer setup.

