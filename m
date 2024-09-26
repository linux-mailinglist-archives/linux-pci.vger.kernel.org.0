Return-Path: <linux-pci+bounces-13565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96C9875D7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0581F2124E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0B64595B;
	Thu, 26 Sep 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hulzJVYh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452643AB9
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361815; cv=fail; b=rSuJPatoDS3gQgiSpA/LScAhgs/bRoe9qfD7TJ2vaftBd82x0rkmY+RVgqhZtLNrW9veiXltFYAzleKCM2pjY1iqvytCaRN8GWavbjkAPf7A1FFnVgNu1gwygCg93iTmqlnoih6IWwsazHLQBI/7DOwKQfKPVy4AvRlJQQTf35M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361815; c=relaxed/simple;
	bh=rWUnahWLkU3/BHwF5vKChq2pcGQVRZMm65E0PfXKw8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y2CVqDUYZ6x3tcfhNcOD6G/2JT23xvWNZAjaLpJNK9esk9yy0BMMpmrxwatUrLA48pl1Tr8WMauR5t/Naq5TcYxNI5rbKfJBRd1wfRZNcfjxfeQliihl7uq2bPJArjycrtmy9NqeJaIrIHHxKF+JCu0DRvFWZys/vTm2WlyNZFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hulzJVYh; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727361814; x=1758897814;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rWUnahWLkU3/BHwF5vKChq2pcGQVRZMm65E0PfXKw8Y=;
  b=hulzJVYhRD9g4hIm86eBKqUFT90er6906mysmgIixM+HFA7IXRr1Cm//
   pqp36+xgSKj73XuS50zyqggcOjAvNdbi9PO8X41DCCG6lliuh+qI7Tlub
   k2IIWD8KtR6DwoTRffv4gNLIcXS2exTxFC3qBoE6XPuVqsc1Z30oPzk0d
   ZUtyl1xKvcN40BqQhIXQh+WGpeCUsxdMDRWmGakIfZG1azrOAEaOgYnKg
   y0lg1ynolJBnaqR5CU2OMi79DYQjKm4Xe8/OakLX2RdO7gfw74nVJscPc
   2bqFi0A+2yRf0OfqMXyoupuTdirXk5lBtFNi2DgdSrGjU8VmlcOQs3cOi
   A==;
X-CSE-ConnectionGUID: vWHHRsUzQaKU0ISs0wBFRg==
X-CSE-MsgGUID: uD++xNEETSixSoYHAjYZSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37821009"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="37821009"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:43:31 -0700
X-CSE-ConnectionGUID: fwuz+P+NQcKHWXJEM2ikoQ==
X-CSE-MsgGUID: 2bBRDSfbSuydTULYJ6ZW3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="77013512"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 07:43:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 07:43:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 07:43:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 07:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5cU0ssfbiWhYj3/VdLmA3a9La+/nO7IvwTmUSXWOtEu56zDfIrdA+I6Gszus5Ny2LEhdMawLg0yuISv1hFuQWr7ghsBxnDRvqqYfZmyOaA69gPHfKSB204KpGIsCZBskSynC72/5lRcGAVdUgfPjk9TxqlnnnL9a3eMwbCnbT1rzjnmNhJvdkDq4LU0mUX41yTITnF4bGJGJdUecqAzGCHYEtAuawLo9eC0jvPD1aE+GpzoqSgmqrxV0MTKNnIa95Ql4rBy5JESYBW9aAwJIccbZbshNNmul76Jx0Ysc1Cua9VxjRY/+RZswb3+f7Ng2Ha0K0mNcbbjlpIAxzjS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjlu43+eIY1V7TBFvTPJn7sxpaW+upHPuf1twPnRKc4=;
 b=m1w+IZ66JaNqxH3lXcWZpdYPPffcVWTdljoQtfsnqRe30wJuqy3FpNLHVIauHMMJv/kO1AjUcxJQLkyyxqrfcYMScJkQKwYHr17J0UoBrd05YZ6X/osMu+/pZvr2qgOdNDzlf0hCYJw7UiG686/v7UfUqqEV3GaM6F9nxb7gXXSaNIufhUvjyM/IbFPtu8zbkfaXPAtpHzC8AKp/pXg+EH3gtcSjOP8RDNEEkb4VoahcYumEB73YYG6nZ9FyWQw2Kn7EmMOepe/B55OYH2zNwng2xbGydaLMfHTN7ho5FHqTLHHTrTP6rpt9j/M2Bgr+C8vhRpMuJtBwdeKNIJTEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by DM3PR11MB8683.namprd11.prod.outlook.com (2603:10b6:8:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 14:43:26 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7962.022; Thu, 26 Sep 2024
 14:43:26 +0000
Date: Thu, 26 Sep 2024 10:43:21 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/6] drm/i915/pm: Hoist
 pci_save_state()+pci_set_power_state() to the end of pm _late() hook
Message-ID: <ZvVzCbkfUkDb_0Ch@intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
 <20240925144526.2482-3-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925144526.2482-3-ville.syrjala@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:303:8e::15) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|DM3PR11MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fadeb8-c7f6-4b45-308d-08dcde3993a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Q20jU19VfM6nDxu9aB2ew23BAiSvMHcuX4bmS21SEhwc8bPQx7yZWs6F2B?=
 =?iso-8859-1?Q?/aOBXZN660NIF9butTIQa4FAYuGcnIhQZj8uvtUeRxHSWKAC3cKmhVoksh?=
 =?iso-8859-1?Q?EfOn7jdA2da8f9QshW7tlzJFGxe+wgfrlksic9TCG514X5MvNXfQihxlnf?=
 =?iso-8859-1?Q?4cRPZy9pzAZuE0Fp2lB3rpqoTuxQUA5Nkf0nOeEG9RkawsWx7L7Vm0388V?=
 =?iso-8859-1?Q?2ud603M//vIlVzuorc4DjvEH68Mw86I56DXYMi+BIm48JFMr+o+vMfrUh6?=
 =?iso-8859-1?Q?ckrOGAMAjJvEYgzD+EzJMp8Xr1dFp65I9seRvmleUOF+sJdpATeagsEW+y?=
 =?iso-8859-1?Q?n7v9BAcJwjU7d5vYXjhgW8rz8ypIPVOZ3CqpCOE1IdoKutGQEi3g1LjRcV?=
 =?iso-8859-1?Q?xov5Vs/lY3/olOmPgenpcpe3pb4ZKpnFHWJ7BNPBKVR09B4h9CufeB/tIH?=
 =?iso-8859-1?Q?9dS4oI6vjBleEFV1eLsueU7cA5JFdnuyBVhPfjAGB3oXi1uu8hQ0rTdryj?=
 =?iso-8859-1?Q?fB721xQ/ZCUrttDI0t2sPGeTo7XzBagppaFGnTTLwVCtiRwGsgEjT9chtJ?=
 =?iso-8859-1?Q?E8FmjdS1D2BJ8rmu8agi9stAz7TE/o84oJCzB7lY8GFDF1Wv4c5rPS/0of?=
 =?iso-8859-1?Q?DdLr8DJQr+CdC6oFCHM+PMKNjBIKyXeI0/ttSM+fXoH6VF2i0riRP7LKKH?=
 =?iso-8859-1?Q?l9OIRFNbOPngFni0gx5SoPZghHwjsxGNQvP5eLg/fdQvcHffRS01fOd+Ck?=
 =?iso-8859-1?Q?D4YxsW2it9YI0DTFsTof19CKdCbVfmdmg8odrywLrmzz3lDbwM5l/sPACk?=
 =?iso-8859-1?Q?tAl/t4c25IvuWKULwN7F9A8k9W22kMQx3sCLuhScY2EEuQGPWk+Q0AP6u4?=
 =?iso-8859-1?Q?pkdPuchH+FpzvjCa7zy3O8+0wiOXhSg1KE22EGMo+SvcNy0pYXlYDx1VFv?=
 =?iso-8859-1?Q?XefGf1kTG1Px6Vg2mSD+B3260QqByoQb2dGTpb5oagBdiCdW4XTWKa9jmA?=
 =?iso-8859-1?Q?D/7vxddRSjZmIa2MWpGs6UQFsulFa7yEDiHR65eRGJ+ThmzUT5/8LXcEqi?=
 =?iso-8859-1?Q?hTBuuz40fP6TxzgVzSuqrheVR3MONp4557oJbPv+oF2OwZRShcAcDM5Bjp?=
 =?iso-8859-1?Q?Yp320ECfE7+rAWyfH3vlBPsNs83NlBQaPXHccuYDC8fqb5P0HhrSbUbHyF?=
 =?iso-8859-1?Q?BdklKHRfXKAhA/OFnof048un+9RoPgWbQr862rpCE/646VA5B4s3E05tTQ?=
 =?iso-8859-1?Q?KYiO2K0HT6FOXcmXzBQIVxyNsCu2UTGoLi6Z5yFYRQojDUMTnrCrRkcTYA?=
 =?iso-8859-1?Q?iWbQh0jSrw7sgHHfxww3Dv6SGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GUKXuFhD9ZHs7wRjsjw/aVQ8MdJWcW+0pwPuQlLyTCvhOeHSOwIWT5zBRZ?=
 =?iso-8859-1?Q?n2hocY/f6zWHk0bld5g47zgsXmOWOAi7+XQlwkhX3QLMraJnbyI6BdsOc7?=
 =?iso-8859-1?Q?HXTPKk3QlmQJJvX1JBsD6lSNq3tiuuvOAVJeWgItLGppVYGiiQSGLJYDxs?=
 =?iso-8859-1?Q?DlVSJPPWvKxCEXr/6xXBaq0XP1Ua+9hI0pefRSV7BFCzm6qQ/RnaIky/JY?=
 =?iso-8859-1?Q?YiQW2aLe7faqIWcOhPJckxlkiKH4cuO2Txww/n2K3qbv16jlQvn+U1evw9?=
 =?iso-8859-1?Q?szpvgcHMyuXlIzSQJ+5Fk+HOSKpLV4EAMKZjMvLax/m/+lgm/66LbdH33V?=
 =?iso-8859-1?Q?w1c4rZndUQ356jZicxvFMcpPSNnvgaZOXG73sFN99Bi7bvD/ILnPr6BcMy?=
 =?iso-8859-1?Q?kni/AKpAG9VjVe3ynO5tS5YMKzYWw4GkUmsEHwpk9sPGb1flVFTgNhdr/R?=
 =?iso-8859-1?Q?b4unYNUQPdq9NBOV1wvIQDTnmKzj9MzUO/5FeaoH2Zc/Rnh7cIa9uGBNLj?=
 =?iso-8859-1?Q?644HndfjXGilToGof1h8c8Qiy7j226wpoclaXewwdZC0K0GxHK3ZZvmQot?=
 =?iso-8859-1?Q?rfOmLaTBmWXTuqCIZUAmTBYcXVu8BJupfNRYuFAfSHZTfSNE/pDJBYhrOo?=
 =?iso-8859-1?Q?qZIaGgQBeC2falXVq8hI3j+yuWjob/CMuX29tN5CdwOobyYEKKq9Z/ccYs?=
 =?iso-8859-1?Q?DZP0KU/yfCLxYtyxQcxyN46sDIaz8y98yV7Iz7ah2MTMvVvG51ObR9Te1L?=
 =?iso-8859-1?Q?fCbytBEnvre3ZhOnmK27sgr53Hzw1ohE4bqMCtqMai6670d1aekPWVuPBC?=
 =?iso-8859-1?Q?nF044YQlHx7lJ6z+mP6ZZn5TjxmgzDYVDguaF7mct8GwxQzE2UywqxE1H6?=
 =?iso-8859-1?Q?gbiEbbwE1Kv5jKXbywlsAkBW/lEunwz+VDRaeEpadoMnF6L31z9/hnjvZe?=
 =?iso-8859-1?Q?OEjmkVkjOwTTTTGSI1ahRNv7vES+YxAqVejKRmtB58t6bIuJgohvcHeQw+?=
 =?iso-8859-1?Q?JDujqEbBm34C+QGakGMxxhIPBQoHSz6b/DDAOkeQZaVg8m5yoFXoD8XVZI?=
 =?iso-8859-1?Q?ny6gPLXREKhMAHmWig0Oirrlhp83FwzHVWtH6FEgTXcr4j5aL+15Ut1DDL?=
 =?iso-8859-1?Q?utpVWdMTQd6O9SfILPPkUcv7uIlFjvwULvVxo1xpXLYuGeAhorJs1d8lgi?=
 =?iso-8859-1?Q?qJs21UvGiZS6zYutesvQq8kqA1zrz0S1oNIIJj0FwZKIEgO17YynN8ewCS?=
 =?iso-8859-1?Q?YahEzPmrtQ8lcX5zVXG61MOxmLt1hV+HKTYPEdli3R/95yWZMqCLts62Ye?=
 =?iso-8859-1?Q?MR8KDzLljvc7snWd+wcj6OY9GxcRdOypfNJkp43jvRYrT+Y511jVnXAstd?=
 =?iso-8859-1?Q?QHouitXXgc+TW6mGJYzWrqJ9bRznVRqVYK6KbLENlom6ijgacLdY+gjUJ2?=
 =?iso-8859-1?Q?xxklWQSp3EPH+nPpR7/YD5DhgHcbwMLwUwWTz4TyKbd134eHJTGAjJ05Cc?=
 =?iso-8859-1?Q?WZvafSpCQKW0vpZv9zuGtHJnQ1mJMuV8RO7kjuYtPFHrhjdJyswa4c/lQC?=
 =?iso-8859-1?Q?1NEiD+ppR7wKrNoO3mjhq4SmV0fH2tXLvTSuJmcogkYPgdc8XmNZB+xNhr?=
 =?iso-8859-1?Q?YPWu+zaFeJTfuYlL2F5JLd1kgE92p6b7fb3JDtiNIssTu6Qg1mB5480A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fadeb8-c7f6-4b45-308d-08dcde3993a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 14:43:26.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW3a/Zf09+gCpibXteYD0XZsFNGEuh+7ckUpJDcYZ7pB8XZli8iUXMf7HgNdAzsQxGoHC67XI9646f3xKZDb1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8683
X-OriginatorOrg: intel.com

On Wed, Sep 25, 2024 at 05:45:22PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> driver/pci does the pci_save_state()+pci_set_power_state() from the
> _noirq() pm hooks. Move our manual calls (needed for the hibernate+D3
> workaround with buggy BIOSes) towards that same point. We currently
> have no _noirq() hooks, so end of _late() hooks is the best we can
> do right now.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/i915_driver.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index 6dc0104a3e36..9d557ff8adf5 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -1015,7 +1015,6 @@ static int i915_drm_suspend(struct drm_device *dev)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(dev);
>  	struct intel_display *display = &dev_priv->display;
> -	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
>  	pci_power_t opregion_target_state;
>  
>  	disable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
> @@ -1029,8 +1028,6 @@ static int i915_drm_suspend(struct drm_device *dev)
>  		intel_display_driver_disable_user_access(dev_priv);
>  	}
>  
> -	pci_save_state(pdev);
> -
>  	intel_display_driver_suspend(dev_priv);
>  
>  	intel_dp_mst_suspend(dev_priv);
> @@ -1090,10 +1087,16 @@ static int i915_drm_suspend_late(struct drm_device *dev, bool hibernation)
>  		drm_err(&dev_priv->drm, "Suspend complete failed: %d\n", ret);
>  		intel_power_domains_resume(dev_priv);
>  
> -		goto out;
> +		goto fail;
>  	}
>  
> +	enable_rpm_wakeref_asserts(rpm);
> +
> +	if (!dev_priv->uncore.user_forcewake_count)
> +		intel_runtime_pm_driver_release(rpm);
> +

why do we need this?
probably deserves a separate patch?

>  	pci_disable_device(pdev);
> +
>  	/*
>  	 * During hibernation on some platforms the BIOS may try to access
>  	 * the device even though it's already in D3 and hang the machine. So
> @@ -1105,11 +1108,17 @@ static int i915_drm_suspend_late(struct drm_device *dev, bool hibernation)
>  	 * Lenovo Thinkpad X301, X61s, X60, T60, X41
>  	 * Fujitsu FSC S7110
>  	 * Acer Aspire 1830T
> +	 *
> +	 * pci_save_state() is needed to prevent driver/pci from
> +	 * automagically putting the device into D3.
>  	 */

I'm still not convinced that this would automagically prevent the D3,
specially in this part of the code.

I would prefer to simply remove this call, or keep it and move it
here to be consistent with other drivers, but also add the restore
portion of it for consistency and alignment...

> +	pci_save_state(pdev);
>  	if (!(hibernation && GRAPHICS_VER(dev_priv) < 6))
>  		pci_set_power_state(pdev, PCI_D3hot);
>  
> -out:
> +	return 0;
> +
> +fail:
>  	enable_rpm_wakeref_asserts(rpm);
>  	if (!dev_priv->uncore.user_forcewake_count)
>  		intel_runtime_pm_driver_release(rpm);
> -- 
> 2.44.2
> 

