Return-Path: <linux-pci+bounces-22399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18595A45290
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 03:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC3316BCBB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75901B87E1;
	Wed, 26 Feb 2025 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T93Zrc6O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D320B7FA
	for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535211; cv=fail; b=Tt3HVVyHceKS6ZlQ8EYmZjG2bSMHVFyN2+eQWNjP5AeCXcpnBZ6UtGVjp0+YjAdSGDbwFE8P3b/BurM8T12JwbKl8NKERP3ZmjNlNdmTHU/BMmyzoZNmOkT6XE2QVP3QxL5Yrf9LCvsUzVoyixGiJYaXr+30e1AkFS9sECRv6NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535211; c=relaxed/simple;
	bh=UreVfm1cCBQjFP5bBsys6MbCU/pJOCchcURR0l6p9Ww=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iCcfR9ZCoVtMUq3aaJZxFroMHvWLOGOD37/TmK+kA0vr7JuyWoDrjjgx1AOVKmAEAumX2dscoF2oMGMSNCtTt8y8bXJKhu6OWhwUbRuvMmFLiRaI5zqNU63+4RSzLHMgiM0z6k9Cy+4am+FS5N6x+hlNizsVd+FUS5Gu/8ceJ6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T93Zrc6O; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535210; x=1772071210;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UreVfm1cCBQjFP5bBsys6MbCU/pJOCchcURR0l6p9Ww=;
  b=T93Zrc6OivjwV6pYuGK+c4rg7u8EIqJ6l41/ivXWexTNB8LbiNSwwOGQ
   8uKcUtGofdXnp60kcClPO8Pe1R9N+vMXTO0F5WIug5a2W1oVwaigOlkaM
   OZcKA5GScofgGADYQZvjVVU2LCLnBjufcdo/38tkOybxs94AOimAA19AR
   SPN+k4WHDczgs5/fwTI7SH5X+R8Uc1aqGWtlP6n9gUPbMp20WEtrHhoD0
   uViHiwPII2ftNZ8n14PFtyk08KnTX6awMiIf9+3aRFilK8cjKaRHi+tg2
   0Bv05XHPCQ81H9uhCgXlHnXNaD6u2CJYEAXy6N7hhG71ePAPgpT6nPZjA
   w==;
X-CSE-ConnectionGUID: bLEH4u2uRCir/LFmrOesfw==
X-CSE-MsgGUID: I+5KH6jBStaRXkVviyk28w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52789026"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52789026"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:00:08 -0800
X-CSE-ConnectionGUID: xyGsabSdRu+BLycNKebNgg==
X-CSE-MsgGUID: sKoBR89USLiKmZGCN1OcqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121660866"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 18:00:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 18:00:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 18:00:07 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 18:00:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpqEplbF/gJHq470w/+yU9kXOFYD+XWHinJxIlPHlrmR/s6rQS9UBrveqU4gd5p9QSxn+ZtVNeB8cyi2/qTFkSQ0O9cu1tyEdgiemLHs3V78wQPdWqN5jFUP5T7z73U2MWeDDClwW5c8VqzPCUlw/VaanIo+0HdAkJBuPYC6AcQQJhCSRqRFSj3btnL7GPHRSzlqPA7hM/R87t1seJd8D2OXosG4rpvru6n7g7p2AR3e1pSLfp6h3bgQ/6oTAcbgHwyuYtVt0yUB2q8OUUQNNzajbCSM5+CbIJ9jzeG0+Wr4S1EuVFKtgr5cezPhRSW5TFcU8NNJpAujv5Pd7wDnNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nExjn9vJ7wSI2o9PrsMO4eVHk4Vk0zCo9I7RYuekaa0=;
 b=qEzTmEr+7OkMVIWmcP2e0QUZ5EePaiM7ZaLaDoFgoB+PNVJaPzy3ojd92BvSsLpXxZIJM9sIBImWul7Bm4w0jTaPcHFF1w1VjXYQCB+YwpMCwb9XFw7laOKquTUP8ObPGWT5GlhKefnFrUwfLoUk/wz/YFEpa8EJLF31ixYBo4HVCiqjE0NiO22A3np14gTC7nMk39BmOZd28KrmK22gedakxOLes1JBGOn/ja5pwrEGWgl6O6y6x5gbP7t+skRJPPQso8ezMuNZmRm90LhVceW7sXGWVNciK/oX/os2gdrrTrrkDNlIelq4Uv4Int/6w42nXc8wlcU2zJ56yl86xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 02:00:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 02:00:02 +0000
Date: Tue, 25 Feb 2025 18:00:00 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 06/11] samples/devsec: PCI device-security bus / endpoint
 sample
Message-ID: <67be75a01ef00_1a772944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343743095.1074769.17985181033044298157.stgit@dwillia2-xfh.jf.intel.com>
 <20250130132129.000027ad@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250130132129.000027ad@huawei.com>
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 71cd097a-ed6e-441c-b8d9-08dd56094863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VNj2MyYb6R2Lcfyf2Dz94oKNSQCGqOAvvz9YJuNrjmuOwumTY2VFP0h22KSB?=
 =?us-ascii?Q?CfmQiCW3LPQwBXvZpnXHBd58bVP0KYJ/I/nAyKKLJ6N7zc+HH4tdnK+N10zW?=
 =?us-ascii?Q?U4gKxVQpCYwgJbC5MRCwNVC7WK7/LecwF4hBlqRjTK3fAZLF2B3PCQHc4v+G?=
 =?us-ascii?Q?/GiFLURMnFCnCy6R3Mgj8TJeyMT+j0mYOeSpXdns1uRRe4p05gvCRwrCPeQg?=
 =?us-ascii?Q?dInsCjq1Zhtyya7rCPZJNlByEZhdMMBTGEmJrj2fNBk0XStHHRgVma0t2Qqb?=
 =?us-ascii?Q?Gjj45ppMCD51TNSdZg5Q+DC+4U1WwM+pMHa4Bfdf6JU8gC4G+L9WZ1hucJ00?=
 =?us-ascii?Q?bKmFHNzJhgeoWEWFnBQ+/uDThR7HzjXhFoRtH5U4QT7Wnta9Vj+giOmP2Fa6?=
 =?us-ascii?Q?lOq+3vJp+MY5M/iWTsbRK7BbpvvyXiKYxZ2JBdc2kVdq1hayWW2vXFtWxHgQ?=
 =?us-ascii?Q?AE7DlUuZcnhsk76Dtyi1TVn5zUacgyBublVzHYpaPJ5F+faqAdx5M4iwXY4k?=
 =?us-ascii?Q?e2fZG/xDdpWV48dll+OfI5dDICABYtKI1p28atbv7kve0MySAyDnf0RGdiJw?=
 =?us-ascii?Q?H6/uHQCz6TLu6TQcu29keRp1NmI+hCONUsyW0uuBAk2Kzsa366f8ytBTMQEh?=
 =?us-ascii?Q?/d9HfQR1gZahHvmP3Sl0IbB5KqoT/esJrtHF/jbXywD7EwLuT7Z/tDdSzSAg?=
 =?us-ascii?Q?Ohtph+PcEkykQVxq3f0m3olPj7i67v8Po3yMSwmM+cTJGLvxGNt+aT5I7cJh?=
 =?us-ascii?Q?MRzZsWcgaqFzRQ+D6+hrbxSQcEQz1ge95ky0KWzF1lVLG4e6QTu5L+uAdvVY?=
 =?us-ascii?Q?mbeBDSRsMC92LL+eXxI5dYJaVh8VlbrAomK8yS9M9wEPeuthNsSfaDdyij54?=
 =?us-ascii?Q?/N3A+gwa7gbnL5hdbYR3uLxjdkBkCzf54LyiCUI+myBtI7QKmxw+VU+b1+XS?=
 =?us-ascii?Q?z5PDbngdoOzkFze55ifcoOrtT0muT0aGv7He9gHd6YCimZKi97KElSYUFxn+?=
 =?us-ascii?Q?M4LeVXmuZ3TUpB3ZDrVQhhJ2OPkD9yin6CM9IgK5Jyc0j9bOWkjB8lAQEFg8?=
 =?us-ascii?Q?wBorvbcO6lUjn3i+EJyVuVCRMsZwdQjMDeB3ZkDmRg5LbI7TGFHFvYB4ILzb?=
 =?us-ascii?Q?Ai7PhjHS2EMcyH9JyuC6eegFJHDT998qvzfYoXKbwMa523f7UvYuHiaqUQ//?=
 =?us-ascii?Q?ZJYfVrnETkFANAzxj7a+WkuU6tkozPvHoytxKhFn4OUSg1/vkWZQAzi6hjq8?=
 =?us-ascii?Q?pYm7AHgM1t6DKMQPgdtsLNuBw0pFuklStzHTzQGPkRM7tPPqf8t4mUc5M8Qp?=
 =?us-ascii?Q?hpCFztTgiyLlAsE6TnucAxdLy91pco2CJEpo5pw/PKGCM0q4ZILArstZfF0z?=
 =?us-ascii?Q?V0aE1ZLhxqqlhOzGeLogkoKL/cMG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8+M7vLwOlADqC9hUp4JQmVJEAHnXsPYzJ3yJ6z9nQlzRBzU/+9BaRZps4ZT?=
 =?us-ascii?Q?yF7Tcd7an0iX+VL4APg7THjunAxUpJYLxLb8F28w0ETJ4j7R+oA1/DhE3KLb?=
 =?us-ascii?Q?9PzA21XXw3VEBhwcKj8Ki8PCKikuwROVU/etWLYqplNK1Gy5ucHZHjV/7idt?=
 =?us-ascii?Q?ykdek5sm+kkM+ba4b+0y9G5f3uACsKbyCWjJUiAMayzwFm0kF8mOplUgSdRG?=
 =?us-ascii?Q?Th6Xt74myIQaJJ7DjiEHlCO3Xpr4c56inO3r55bZhWVGsyhMEhPLEzu35jNs?=
 =?us-ascii?Q?tINQ+iyyveP53YvbKMAojCb8p9AjWpR1oJibmWe/cncFNh0H6eWobaSjsiJe?=
 =?us-ascii?Q?7ZE/QB9yKECYGHd9qPJrTmkhetO8jo2KoUTpgcjdTpKKAUgA3AwFQeCN66ez?=
 =?us-ascii?Q?o93IZUZs+hRwuNlQcoWLRDQf8OQ1ZJPH0NfhC3dzs8Hq82Q/O8/6714al5eP?=
 =?us-ascii?Q?4RYetkr7hiRVMZexWBen5uoSVktRUju9U01DIOOSg7DaVibSNCMM52nkkoOy?=
 =?us-ascii?Q?nPFkm7CofZ3bDaYQATcI7RClL+HIYTu39cBMlntKHEOdmONXBb+RZHsymCOL?=
 =?us-ascii?Q?wSKMEuNhTqzNH6zGHzWqvcdpOGBc8jtbWTOUI+nO+EzAXq7wip19yLpp3cXH?=
 =?us-ascii?Q?CFF1FVxYs4QOoYOuPsUSLfbEYZs6/ChWfHzQL0fWsMPSEy7ZOXRpH8kTwkoa?=
 =?us-ascii?Q?2VKSmbK/b+iYM0cQh1TG3pAyplSmjjYD/SfkSYh36n0A92QWFbTkH17+42GU?=
 =?us-ascii?Q?U0nu7Wx7MenwoQSL+BnnOsdTWS0AzCNzb1Yl33MTVw5fRR3Np4fdr5m7o25V?=
 =?us-ascii?Q?pqCs/AYn3kLmaHkb+ZU5eNjGF8kBA3Oxrmf5bATS7lsAHe5sQ9X0lkFnFbYy?=
 =?us-ascii?Q?n9uv6NkzWg3UJuJC8XLY8V3Hrrql2Lrk0m1TisWlI3mmI1Xs7sMM6lnmyMKl?=
 =?us-ascii?Q?ucK8G9gAQ+Av8J7w5Gkuwtx6yWxxpKuALxM1Xq+GcOvXijWvLG/99Iv4i9cc?=
 =?us-ascii?Q?zuYhGFxhEOT1+8i3xbELcqisX6GyYGwd/Pr/lyc9OhJe/+22dtdBDB58+nfU?=
 =?us-ascii?Q?TUXOOaOlfbjmU25vIhBRlJmPcS3rDAALblRwa0y9P0A4BolWKlCdzEjncon7?=
 =?us-ascii?Q?ifLos8nMJfGo5AxDMGqI2kVWwdqkJAl+oH05htKUKaYGTidIj0LNMeWa5APS?=
 =?us-ascii?Q?YXuy8vfLfzAYrmu6ANY4Hmn8sGyMTG2zBX/TeaQxKAkFrsjR2mnGCLUYtVkS?=
 =?us-ascii?Q?AT+gl/0mfbt4YYDBBlOms+g38ss6uhq1b2wwHHvGddqMo0eg7PhStJwZOSl5?=
 =?us-ascii?Q?DpRWQiN1zPtSTfK0ZO30ZyML/ZkTgbwApnZRQTtns53L1+aGuLidV8Hrjxvl?=
 =?us-ascii?Q?XUBoBGsYOS9W/2XIC2GAuMHvhdLo9bIcksWKvARebjymBcZ5xh7hTbHPNQdQ?=
 =?us-ascii?Q?Jk8XVA5ce0Vxb6c/Z+pNdv16LuplArBQF/047UnbP9jUDJxEt3tbog3avsAF?=
 =?us-ascii?Q?gkTZ52N2saUmAsVb00FB9SJlrcCUruBzdfMzXbmQnKqBOHE1EVsBe3UCJsDj?=
 =?us-ascii?Q?Nze5+kUJppHoS/L4nnKdeBxHzq54WLGD3ZBUd4gl7ctuS8PiPpcHiybroWRD?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cd097a-ed6e-441c-b8d9-08dd56094863
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 02:00:02.6975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTBJyN7We2U3I3adSgY9H40609gXqvSOUwWlDUg3K4hVbRmH2FCuOudYYZoY0QssXYMVucWJ1Fdl44BrIIEuPwSHXhtftn92wupjqAQyUIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5764
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 05 Dec 2024 14:23:51 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Establish just enough emulated PCI infrastructure to register a sample
> > TSM (platform security manager) driver and have it discover an IDE + TEE
> > (link encryption + device-interface security protocol (TDISP)) capable
> > device.
> > 
> > Use the existing a CONFIG_PCI_BRIDGE_EMUL to emulate an IDE capable root
> > port, and open code the emulation of an endpoint device via simulated
> > configuration cycle responses.
> > 
> > The devsec_tsm driver responds to the PCI core TSM operations as if it
> > successfully exercised the given interface security protocol message.
> > 
> > The devsec_bus and devsec_tsm drivers can be loaded in either order to
> > reflect cases like SEV-TIO where the TSM is PCI-device firmware, and
> > cases like TDX Connect where the TSM is a software agent running on the
> > host CPU.
> > 
> > Follow-on patches add common code for TSM managed IDE establishment. For
> > now, just successfully complete setup and teardown of the DSM (device
> > security manager) context as a building block for management of TDI
> > (trusted device interface) instances.
> > 
> >  # modprobe devsec_bus
> >     devsec_bus devsec_bus: PCI host bridge to bus 10000:00
> >     pci_bus 10000:00: root bus resource [bus 00-01]
> >     pci_bus 10000:00: root bus resource [mem 0xf000000000-0xffffffffff 64bit]
> >     pci 10000:00:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
> >     pci 10000:00:00.0: PCI bridge to [bus 00]
> >     pci 10000:00:00.0:   bridge window [io  0x0000-0x0fff]
> >     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> >     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> >     pci 10000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> >     pci 10000:01:00.0: [8086:ffff] type 00 class 0x000000 PCIe Endpoint
> >     pci 10000:01:00.0: BAR 0 [mem 0xf000000000-0xf0001fffff 64bit pref]
> >     pci_doe_abort: pci 10000:01:00.0: DOE: [100] Issuing Abort
> >     pci_doe_cache_protocols: pci 10000:01:00.0: DOE: [100] Found protocol 0 vid: 1 prot: 1
> >     pci 10000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
> >     pci 10000:00:00.0: PCI bridge to [bus 01]
> >     pci_bus 10000:01: busn_res: [bus 01] end is updated to 01
> >  # modprobe devsec_tsm
> >     devsec_tsm_pci_probe: pci 10000:01:00.0: devsec: tsm enabled
> >     __pci_tsm_init: pci 10000:01:00.0: TSM: Device security capabilities detected ( ide tee ), TSM attach
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Hi Dan,
> 
> A few minor comments as I was reading this. Mostly just trying
> to get my head around it hence they are all fairly superficial things.
> 
> Jonathan
> 
> > diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
> > new file mode 100644
> > index 000000000000..47dbe4e1b648
> > --- /dev/null
> > +++ b/samples/devsec/bus.c
> 
> 
> > +static void destroy_iomem_pool(void *data)
> 
> There is a devm_gen_pool_create you can probably use.

Indeed there is, thanks.

[..]
> Similar to the case below. I'd rather see a per dev devm_ cleanup
> than relying on unified cleanup and that array having null entrees.
> Should end up easier to follow.  Might require devsec dev to have
> a reference back to the pool though.

Done for ports and devs.

The arrays are used during PCI bus operations. This made me realize that
I should be putting the device and port allocation *before* the PCI bus
creation to make sure those arrays are dead and idle before the they are
invalidated by the port and dev devres actions.

[..]
> > +static int init_port(struct devsec_port *devsec_port)
> > +{
> > +	struct pci_bridge_emul *bridge = &devsec_port->bridge;
> > +	int rc;
> > +
> > +	bridge->conf.vendor = cpu_to_le16(0x8086);
> > +	bridge->conf.device = cpu_to_le16(0x7075);
> > +	bridge->subsystem_vendor_id = cpu_to_le16(0x8086);
> > +	bridge->conf.class_revision = cpu_to_le32(0x1);
> > +
> > +	bridge->conf.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
> > +	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
> > +
> > +	bridge->has_pcie = true;
> > +	bridge->pcie_conf.devcap = cpu_to_le16(PCI_EXP_DEVCAP_FLR);
> > +	bridge->pcie_conf.lnksta = cpu_to_le16(PCI_EXP_LNKSTA_CLS_2_5GB);
> > +
> > +	bridge->data = devsec_port;
> > +	bridge->ops = &devsec_bridge_ops;
> Maybe 
> 	*bridge = (struct pci_bridge_emul) {
> 	};
> appropriate here. 	

Sure.

> > +
> > +	init_ide(&devsec_port->ide);
> > +
> > +	rc = pci_bridge_emul_init(bridge, 0);
> 
> return pci_bridge_emul_init() unless a later patch is going to add more here.

Ok.

