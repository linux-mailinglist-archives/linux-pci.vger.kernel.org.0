Return-Path: <linux-pci+bounces-7224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B578BFD4A
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 14:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A871C20B01
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA17E42055;
	Wed,  8 May 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="As3UJ1MH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478C3EA71
	for <linux-pci@vger.kernel.org>; Wed,  8 May 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171909; cv=fail; b=cVk8H0oYn6HXuXHdHxDqaa7G+wP17Og41rNLwJVICfzirrAe9nP33Up1QZL9RV52qNMKJA8TW2N68bvGvXM8LKsocgpol3Oi71kdyPNxMQasfJR/dTpqPSSdrpem1R7F9HFK+e2cJNF20YNWKV57inkVx/V7LJSYWiyCHMEc014=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171909; c=relaxed/simple;
	bh=4BhUc0BiTJsLbVQbgKHVrOceOGYpHI2nfj9LGAmh4NE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDfsdTwunBL0EQDopOtqzwcfIp/f7NhkFVfT09C8sGVsYEHK6VCzUIZs/6KXl5bj6di2fbtLLsYs1FOOju/d0CW6pwi6Tr7M6G29i0Uc4wS5u6l7JFKD2TBVM12xEUmQ/61yWdO0K3lrXokuj4NX/LxcUjU45srjFwAdQ9ZoO6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=As3UJ1MH; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715171908; x=1746707908;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4BhUc0BiTJsLbVQbgKHVrOceOGYpHI2nfj9LGAmh4NE=;
  b=As3UJ1MHhL7JWAbCdgfgnPB0NCZFdnRK+ZkYjM/6Ygb7XTHZ4X1dFhnb
   PGsws7asL+XV62HPMvgfnPG8ZRVGPgFHlog2U+Tej8lozzEgLSZbTDui8
   n3jzOBwjrshTxfnmjnb9ctHPFYQeVvyLHdOMbAH+oYwV/vGSoSiRo2uVd
   nq5a1my93gpT+JRciS0uINlK9NHFjmwGrJRUs8xrIzakgK7aOcMGHS7Co
   blwgoicX8uTd6QSsuk3CJEOpk2psHIolbmLFPNfGWn1PYHo+/dQ6cThuz
   xYpnUMibnONgIFMsWdeBsoKHElzy6vZaY3qKnQXWoEc9XuyAQzXggoghL
   Q==;
X-CSE-ConnectionGUID: dSKPNXTJTNmEGc0FSpTDYQ==
X-CSE-MsgGUID: +DOElVWwSKum6abisKXeKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="33534202"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33534202"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 05:38:27 -0700
X-CSE-ConnectionGUID: gUTR3lhtQZy1rZ1IqLzdlQ==
X-CSE-MsgGUID: Zq9uRwQBTmGbT9gy3VsjFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28744484"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 05:38:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 05:38:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 05:38:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 05:38:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 05:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5pz0usFvhAGcFT9JqM3cehMCeIuzt1dzwDF9czqVtHUeE/AqgJ9/GGiAubknLUkA2ad3weDohso55yruQcN/Ql4qJJtEfLnoNIZKUeM2pfEzEekp6LYscShPR5/HbNj2KUSVoxV62gGjZG42jPO2FFZFwn7MowrDEdRHKz/r9P536ED4yK2LYeV90HzZ57HNhc7LXY4F3GS5uAVfKNirag0KDDnXsYDot96SKbbGHOeeLuhqokD+NBZar9A0+v2acckTw4iR2fr9QVJdoKN+KxO6mjEnBFdNEgYL8Uxl/Hqx6oYgEQV0CZd+u1i0s9bxdPBqtnNM/Xix0kvUVz4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07JhjmKAqkPmOn/ouX1W9BeuRqgglzApolhdOajuitE=;
 b=NO1Zd70AyScOS7vUa8D+x2Cx/DHQnLGswEKtgGC90mmIZmD43Xr/aYU+ciriktMyzgsRuiYK33m2s6yRHjZrXDc6YpQEwNCyhPQ1TO76pqmb0adGA2Em0QnYrgHKYOAIE1kopPUir/kQBOVL5hzB/JHeJCRYnSWjmqM+0ggzmCTITThkF4Ts1XmsX+3CfdnpZ+5G0AZAnCB3Xm0OIOyeX6r+xe5g+gMNhL2MQY9RQF4m0Ds9Xp1GeoG1tsaXZIGJxQMPYo+heHwVVQt6yGqyPmJi2EfsmB7th6GGBGX4c/oVUoiDIPvW1ebeLCN8VeMytai6d3FeSNb07BmNvD72LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by DM6PR11MB4580.namprd11.prod.outlook.com (2603:10b6:5:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 12:38:23 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 12:38:23 +0000
Date: Wed, 8 May 2024 08:38:19 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <lucas.demarchi@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/5] drm/i915: don't include CML PCI IDs in CFL
Message-ID: <ZjtyO_b4jNV5togr@intel.com>
References: <cover.1715086509.git.jani.nikula@intel.com>
 <bebbdad2decb22f3db29e6bc66746b4a05e1387b.1715086509.git.jani.nikula@intel.com>
 <Zjow5HXrXpg2cuOA@intel.com>
 <87cypwln2w.fsf@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87cypwln2w.fsf@intel.com>
X-ClientProxiedBy: BY5PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::45) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|DM6PR11MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: d24e85ec-b97c-4745-cb86-08dc6f5bbfe8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kRIscxZnutTNIxo61stfofWDkPFEzPfPp0gz1/Bl7w5J2D2DrK2+1KM5aBRq?=
 =?us-ascii?Q?vheTUa6So0glqCwjtI2GO2eK1KgVMMK/mSj2ruuaunl8dT1N0vkr3KWOmcfV?=
 =?us-ascii?Q?fO5HgyGzJ/fw1mkoIWfJaK4kBNuQMtiKYL60XUevpoKvyhW9OijLDVIknKU2?=
 =?us-ascii?Q?F3aT3B3n78ZfDIV3r/gV6tRPyofg799rkRrJ4+qXqjj+jWUQnfzgrkp4WbSF?=
 =?us-ascii?Q?o9cQa0qnhokm72NRb/9VkGMNrUVewBz0qe+va087jhqAfAswhdDesFM78Wa8?=
 =?us-ascii?Q?Y9OxNRLlxvkJeXzA7OMOefzQ8E2E99KYmkxtkx3qndD4KXrsyHtcnFjhIpey?=
 =?us-ascii?Q?44vqxZccq8riNOv2vjqJ8znpcJnX5JstaKrLTpGoW5PW0fLpwwMNU/+t6b/J?=
 =?us-ascii?Q?hNK+vLW5QIn6Ny6PfF3O2gfKKwt7w0yLXimRoxziwSWyLvCPQO5rAO2Od4Vh?=
 =?us-ascii?Q?KlDFskXOE7yNGEFJZ+CbrZjuDg2ZbbkLn7VWlwUo58IyDPZg2sO1gjAbCIhv?=
 =?us-ascii?Q?WkqeAc3a8U7pyULIB00obZ96xfMbQdkGodX93odHhk+2cjwD3RQopo/cUKBr?=
 =?us-ascii?Q?18q9JR/QWn8t4KpAU441P8UgUv5VzxgbMi5cBcXYcsQOibkqnUtM8eFlUz9e?=
 =?us-ascii?Q?X1UfZRQNwZhcgr7Wte/aS1CQ5WNBbDy/V56/Njmljde5bkF9esSWAQ29Ak3g?=
 =?us-ascii?Q?tfHsNjc3795UY9gJWbhckI0FF3fHzDVjHMoxNB/LewORP4zsp4eW4svEc2Gu?=
 =?us-ascii?Q?a81Pf3T8u9/Vzum2a9wEil8lMlJmhcpaACExywv7+b3BG3qyMkZKKlDaUN0V?=
 =?us-ascii?Q?FmSHCtKax5EINfbmBoy+e+UVCykOfJyXIfapISc1ILOcKbShqF9D8iU+k5Ev?=
 =?us-ascii?Q?QA1buRbio/RzC/4G9FeOiLtqNVE8VvccdPd8N6yKpeZNjgq6rptttNgIXHw0?=
 =?us-ascii?Q?GbelsDYbvWA0QqEoPCUj0ndKjfp9563jDSAnALqE9LaSNRlKHW87/AJIRa1s?=
 =?us-ascii?Q?1nHtTmfrSwV5JZ4hYrm/MIIpnPK/S8VUi/huOapt1YJBBebbx7tWi3pvemR4?=
 =?us-ascii?Q?E5z9v8npEqd3ubj8HCxvsEW8B5G9EeQQVuOzRqEhioND0XbugkksbQxVNKu+?=
 =?us-ascii?Q?tX5Fk5AlKSs0WRL0Z032paWFPRMjRWnXID7I8I12B8kYYD11JgBsakMRAuRi?=
 =?us-ascii?Q?SFVP4lT9plVWwwEv2rZKL4QF8zQyivcjo1rQViovqUaP36Il+rKuZdDRCqEf?=
 =?us-ascii?Q?BivqvrwpkKp8zKuDL4SuLz62qV+nK+LvV53s4cwZHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mUhpJbNOCwnsFJ1U0WtzZ7lhKNtOA+oKA5Hg4t5AB+kPXQWP375Qdy6iNB9E?=
 =?us-ascii?Q?ZcdxE7/3Vd5cybdFMJc0UFv0sEySDXPIVNvogdCnOuFZj8btrv+qZZCggG7Z?=
 =?us-ascii?Q?geOGhgXadqv8FduqYyOb6kOA+wURCT5iaZwxCmV9WEW9TWq9OScoSIAMTnC+?=
 =?us-ascii?Q?2PAeKXzFKQbWPSsaUkuMEgn9EGB7gTSurKKArjaBigZrg1U6fVmJ3NRYT0ee?=
 =?us-ascii?Q?H/be1ZrWT8XQ8JWC4t3X/fjLNIY93xVhF3PP4CrgqZO7PJg4pQTREjN9Mvps?=
 =?us-ascii?Q?hO3AE93CMtdbKcSg8w3HMPD8F23O18tuEk9IvxVBymdWQnojP3/fDNmZ8MRN?=
 =?us-ascii?Q?bmCLUVFI4+O6LN2FB7hRHQHqzvCGkwwTxQ7m/KGDwHlNgnCQlPO1mEK9IEyO?=
 =?us-ascii?Q?lXcHK1iyNWzmivjn6cnehJPN+E7paXrDEmRJQAdF0veE77t3dwCncineK1B/?=
 =?us-ascii?Q?B6cP/ngtH/Jeu3dYl4emRDtrj5ng3ezcUPnod/lByVjDZorBuF9WIpJB8oVB?=
 =?us-ascii?Q?FtaPc4QIFzXGl47yUUKCw51esDki6DSVo6V94k90gIpohm3XsLFUOqio7qye?=
 =?us-ascii?Q?hQr3yekO4gr9tIQbr1mnwQZJguzvzSU3dgtpVmTZTmCcgSeJO3JM6koeb3Op?=
 =?us-ascii?Q?vlglaaruL+wM5oZhDc49hbSqxcPfXX6A5290qrXDlvZFuauJuLcdchUapu3+?=
 =?us-ascii?Q?5qW1yttmZSVhKg+F4OpqEDrqRXjBMOtxfJwMAxn6oGq8hX4iOuhM25/MDdaS?=
 =?us-ascii?Q?g0KWGwXQcAcvAYS0G829avlK+j+hxzCr68lhuEarIT0uc2duSahFMLcMsX/x?=
 =?us-ascii?Q?NrLDadYYJ1669DWIb4xTJV61q9ToUc8asAL4s6+6bdompBT9irQba3Beg8Gv?=
 =?us-ascii?Q?1cmbO/iyHyL1Ayg1AKXnLnxjil1+8whRfq15PsfvKdCHEuuV9UYMr0l72dZh?=
 =?us-ascii?Q?RWEs6BabcTG6fij3lMZuRMClP0TDyk14m+Z287g5ueuSAeU55JmGbE7QAmhu?=
 =?us-ascii?Q?k5wMZ8U06OMgFjDDHY0ZTJzWu/Y/6hH7KWXWFcS92MziWU3b6g6aFnQsgX9U?=
 =?us-ascii?Q?HIfjuDZsFm2GpR1T+BmWVrz+Je0utTs5RFX46Vur4poI+9okMvol9228O/SY?=
 =?us-ascii?Q?NvNMMSAZS5lA8cPuZ46bJovWx05BGG8klEhV7M662rvnZccCl4JUScq1k5R8?=
 =?us-ascii?Q?yTuwCsNVwFHBxmAVTy4SVCDfd4wE9NKURgkUjs/TfMJ5rBVgLMRRd60Uxdhm?=
 =?us-ascii?Q?huvJo7bqCL4wAY4Khyfz0f/VgmyySnpJ6B/JwSFpqZhbMX6TsSov9mO4yiXk?=
 =?us-ascii?Q?otDSuob8c2hz1Nt0EYE/mRe5cuyu5puatVnTpNIA6M874vIJiQlXX94Q3hWm?=
 =?us-ascii?Q?CJnWW166hAR/JxL/hjppHy+zVC3+fSWcDDErVLjWGQYzWYsm2CIg92erX0Zf?=
 =?us-ascii?Q?grMvQ7juZVugErrkXQ77eISIOZRS3IgIXzDjc2CWq3PQPIbD84PTty8KyUXH?=
 =?us-ascii?Q?4yPeANMqMxfAsk8nJJ6kZWzUFR8Xd0z+gQgqvq1Vxv3ABlsoWj0q4APsYYjr?=
 =?us-ascii?Q?SHOcRZU0bPgzqyc5edHGjRtkP8/qQSaILGQjHvsW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d24e85ec-b97c-4745-cb86-08dc6f5bbfe8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 12:38:23.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QKx1otD1+o5qDDh0ddAue8zYd7BBK4ETqRjmiqMDw92IdcG1md5icY23HwrenrHJFfC+gNg8U3Ml7LP2LMmYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4580
X-OriginatorOrg: intel.com

On Wed, May 08, 2024 at 11:33:43AM +0300, Jani Nikula wrote:
> On Tue, 07 May 2024, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
> > On Tue, May 07, 2024 at 03:56:48PM +0300, Jani Nikula wrote:
> >> @@ -535,11 +541,7 @@
> >>  	INTEL_WHL_U_GT1_IDS(info), \
> >>  	INTEL_WHL_U_GT2_IDS(info), \
> >>  	INTEL_WHL_U_GT3_IDS(info), \
> >> -	INTEL_AML_CFL_GT2_IDS(info), \
> >> -	INTEL_CML_GT1_IDS(info), \
> >> -	INTEL_CML_GT2_IDS(info), \
> >> -	INTEL_CML_U_GT1_IDS(info), \
> >> -	INTEL_CML_U_GT2_IDS(info)
> >> +	INTEL_AML_CFL_GT2_IDS(info)
> >
> > Why only CML and not AML and WHL as well?
> 
> Mainly because we don't have a separate enumeration in enum
> intel_platform for AML or WHL, while for CML we do. We don't even have
> subplatforms for AML or WHL. So we don't need to distinguish them.
> 
> That said, we could also have a rule that anything with a name needs to
> have a PCI ID macro. Could lean either way.

Fair enough. Let's go this way.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> 
> BR,
> Jani.
> 
> >
> >>  
> >>  /* CNL */
> >>  #define INTEL_CNL_PORT_F_IDS(info) \
> >> -- 
> >> 2.39.2
> >> 
> 
> -- 
> Jani Nikula, Intel

