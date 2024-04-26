Return-Path: <linux-pci+bounces-6699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A69D8B404A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 21:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B861C23545
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 19:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CD118C19;
	Fri, 26 Apr 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4BISC6T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3023773;
	Fri, 26 Apr 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160814; cv=fail; b=LWzVlFEWHa2pV2dpctBYwHaVZa5fR4J0zjcx9oLh2SdmhVQ1gtCnhlQCoaLtpS9weQua0GD7lTJCVIqva1f7Co1t5V6S2aNRQmCR6A5hYXYbSrAyPLQBlf6hAHA7QV5Fupsz1SqfIYkeK0j/RTKV2v4MQLyKRPM5Sj/j70DKtbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160814; c=relaxed/simple;
	bh=Pi7ukKQvRGpfOiyfjith2w72DDgU8773HPpjM8AqRZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uOEbecYpo1iDZEoXIjsvAQ7WIlyqvUEjltms7qodyRSDUnMBoJKlp3iFqv7CpN7KVpVkIq4xTIR9DP26YHIoTBEKZgRVZ/yy1VEnbbcUvcnsbEXHdtishatjlQWOM0mG7zvTtLdouAxhbzcGeTSz2+ncCrBZXqFpMmmd+7QM2zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4BISC6T; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714160812; x=1745696812;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Pi7ukKQvRGpfOiyfjith2w72DDgU8773HPpjM8AqRZ8=;
  b=j4BISC6T0AbKeAhvqwA+5IN7je1BNoMF50xq5N7FKKck9hXjca/wAHTg
   ehyRYErb+Y1pbjIpiRyimLlSFv6+w5aRi3k9QrPsDfCk7sgPJGufpiP0T
   ZUWt3h4SKyD8kg/rEFuuEWzYNCujNyZXGcqj2sIbs8QlGW2K6lFhEwW8H
   2nNoQb8Mw7o/oXv0q92sm29N3awe80fmRz4S+IoKbfyJN2j0YB6jv8ja8
   eHxS6HHED1qK+nwML48hC4NbnubpCGzoHgsjhEskUx+RrIsyJ/9dfNegv
   NB0wJxK/xIFdqsR7JknNnnrSTIM7nlumgybnplcfZlHWH/gWcm//fWe5I
   g==;
X-CSE-ConnectionGUID: XyYNxCXpQ8avh3Vk3K1Rfg==
X-CSE-MsgGUID: 4dmhdEtkQtiXspLek/mlbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="12845499"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="12845499"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:46:51 -0700
X-CSE-ConnectionGUID: xq/rSR4+QIWJ3+jan8rJHg==
X-CSE-MsgGUID: UnpXQBuXQO2Bgy+4LW6Fmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="56686301"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 12:46:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 12:46:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 12:46:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 12:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt9dYv3Ksz9wXcSEmUzPiCIkbQ6DEfR62lBWiUzZZcxmPD56OIc1iqCDr3J64/abOwTY+8rlV9On6G50AiKK3Ijxxjq8vqo4l68RZ0NT58ezCEN0SMI7K788J83iCC8lVEre4bnl3yUrAaHtSxzknXGNdhD3f2BRTmD4hPIE7Fsssx3jBxk1hCMNRLxGg1WFYplQoxV52GF+iyT/9K8WR9can0x99oxF9ndKrzZnx1XBMqWY4I8gLiW6gxWnXIqAzdCAgIRxk3yE/QV5zJmlRWKv/+KPaBYf8LNJZnSqtAWdihh19ZMVLbsdOvlZ2QQv6jXNm0l64V7bBYJjVheoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUnl96QjYyUAwcvs7JGJcmi44xu1OmiWoyotzIH+3rA=;
 b=ZFajWHSHIqulcGK9lHzFHOzSfnV/j6ivO0rKzVybOgd3jzx6J/8QYZodNmrznhtFbNhGoXMdZDifBPuk7mrVSeoQ3iGVHftCvz6LCkTo3Llh0acFJGC2mj4f9dwQwgovkZOSdWt6qoeXRZwQ2ouDwTNLeuziB+FoJvzsLcYsBoqCXd58XKRfQ3mrwE5DKWI3MM1Cus9tF9rpN6uZLmdY0STu4O5CQnyR6UlH/MKue9hPv1sBg1s5WwfSQXQSp9ykSSQXJbnGWBwBlGbATu5i54grzN5YGOThYMJ2/fLHKERh3qDJGdyPLNHbMLqZlUZb/1XQvVtCZolejiEj/HQ03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7790.namprd11.prod.outlook.com (2603:10b6:208:403::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 19:46:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Fri, 26 Apr 2024
 19:46:48 +0000
Date: Fri, 26 Apr 2024 12:46:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v4 3/4] PCI: Create new reset method to force SBR for CXL
Message-ID: <662c04a5d8f5f_b6e02945f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240409160256.94184-1-dave.jiang@intel.com>
 <20240409160256.94184-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240409160256.94184-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: a60d13a5-0101-4271-c8ba-08dc66299c76
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zvhz3PaJBi8txYff182ZtO1XKR3q8DgQKZd7dE2O7AU03JM8XJeWiM5Lvdbf?=
 =?us-ascii?Q?HkB7qTxpmIQ+8VLhvHpk+8KxvTyA/0lvUIlSdmlnLumLPDbvMsjP+9liw+dA?=
 =?us-ascii?Q?feMwhLFxtH166/PIpWRnHE2W44RwhF6cZevzrxVxB7om8ePl/tbuGLswxuNT?=
 =?us-ascii?Q?SZb8fh62gW+abnLiYu+O0ovOk+65s3x6wffFGwdJaYkrLY95RM8k9FHVpgBB?=
 =?us-ascii?Q?oJ3PCgCP9RXwJBy+R2CZuJx6TVoW8MCFSYXKiH2aJY5zeoJlUbYaPcnWoqLw?=
 =?us-ascii?Q?S3yJ2DJmKTwGDO8/DizXONb2HE92+i3b4dynBvRia/HjHPq1aO0V3VBbymdS?=
 =?us-ascii?Q?n4tWt/7MnaR6HoayGmUiWos90NS7fw9nn+9IJkUSR6Jqt8JNWAwr4XG+/qtW?=
 =?us-ascii?Q?5VpnGllrULGnZVPF9/fC+V+m553XnTLH/fWP8Jf9l0dw/rGaBg3IAhnJxGMs?=
 =?us-ascii?Q?rr+7QvRXoXH8DlBm0HwQOoTfcQXeVzT1itaBJ/OGuyAAJhJaRuQLzElfEZaK?=
 =?us-ascii?Q?z0rAQs8u5n0by/2NI7OTjOeoSwvZSqcPxDhWsF+XVtq2nvWdaljkUP4wCyB7?=
 =?us-ascii?Q?0YRMlEN/2uwEN+ZDxcKeXZo3fOYy80Kq/q3ZUUbYrLX7bfgYqDcFKAJDnwRp?=
 =?us-ascii?Q?jHGJ6fVv9PtZ3NnkkFzgiwgCqAmr/y9xIhJ68V7jXC2IiRcr/FL2qJ5JIktr?=
 =?us-ascii?Q?ePPipRu8l7SnUEd29Q+Yk6WuaAENg6/YU0/PngL5ztAWAIVIB6CWqLpv/1C0?=
 =?us-ascii?Q?r25/2DyZ2/nhbkz+k1AM9UrzOgqgBzIR0Zo4IFY8WtgZBSOAS6r2PyVLXpUc?=
 =?us-ascii?Q?oQnaNfqxjDSrIQToO9cUA4aKmqqXTQx5bkXLF3vkV5LRf01/3pmdamfiaseJ?=
 =?us-ascii?Q?3DhTilCx1eMV6vxGr55r9XZxes2cj0yGOkYrqw6VIHjg3eFnULpk6rngOG9i?=
 =?us-ascii?Q?fDM71RnY5FOhlaCwFGc5UBmh/aq/5vcMfUUiaKmqWEb3JNXGMH8tuiC419ir?=
 =?us-ascii?Q?rau35+SxDmbG9hGssc/PQ19inUXfJ+8UmGAYHAdJCwA2fv8Qpiu+E7f3BSIB?=
 =?us-ascii?Q?B7ZlqGdj4ej4T3FxHBIbb7JYF4VHV9abUiVynDeMLvBaqkJUnJ2Vo9siZv0X?=
 =?us-ascii?Q?YP5JUGi8ZLwXU6XksErVO9ckLyjAjc3ThWjNeguikQ65Y8noMQ0CuMPIpo9F?=
 =?us-ascii?Q?VgYKOBxAfAru7/T+nYqRB4rj9nsx9q1LjBGL89Ordh4JQ5px0djwQRKZ9Ukb?=
 =?us-ascii?Q?Sk+2EHHyyVwhWVTwWUUNdDW6Hxef1j9T1gEeCNjbJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cQ3TzgJl4Hq4eTjmXF33lZ8tYSyJGROcj2LfL0GcynKYerbHTksRh425J3qN?=
 =?us-ascii?Q?Tbu4jU2yqjPa1S+BWphACHPHOUcx9SRp8hAqFSA7t28dIGZyNoM+ABNlDBU8?=
 =?us-ascii?Q?g7tki/TlySEzs8Am+0mKtExn2gMj1e1Ab6bEAHAFpOMZebqsJU3aPRMzl0po?=
 =?us-ascii?Q?B/MaQ2rV3R975tYvJT/wEId5NeyjDWvd9b5FnNZjwhR2QP6YxheRs1Zf1C4G?=
 =?us-ascii?Q?xYvgT6AhhUinSlMKUfT94VD+UeI9v3NBnlq4SbAzQziCT/KxLT0etIvFFlz6?=
 =?us-ascii?Q?zJYiprWc/LvFp/D1rWCiacrGUPk0xR80F1gzvqUMQz7gNS2hIhGvaP7vxwn4?=
 =?us-ascii?Q?qCilvTbmaWVkBQUKtdvBsDLsi/WElpgKlE1XXDfVNWIGU4RNm1+lwDCFsQUd?=
 =?us-ascii?Q?26+bBSiOLyZxVFT/pwOs2X0xYxgsGDNBJln1rWF160iaqf2LegRXEGJp/jY5?=
 =?us-ascii?Q?NO4o1v/9A3phmct0k5O3ZAVwFfBNuylfVbTQe64feq3psCJQvQYmZbJtzCLz?=
 =?us-ascii?Q?qbtHnfnMJiuLwz1tV7L8nfsuUUjl/ZaWuTafbV65nuI7Tnd2gTrPK7kS2KZc?=
 =?us-ascii?Q?Xx/E174IAsBN7uQkw5NHKytCHneqUPJNwsYVzwVrXzIWpsEd21e5GrqKsaf3?=
 =?us-ascii?Q?/RUsl0p6xbF73DtDtkihcvbWJ5ZqCqGQBANjhDrhSVVzfcBJSYChW0yXThtI?=
 =?us-ascii?Q?zPMg5p5J/cGqOk866Li4pioXyoLUOZRY/SLLjcAHjuOTibsVq51qrOBwXOyw?=
 =?us-ascii?Q?1V6tAFDXbQH0bj1C1ri/pVXADrTdSwemmfN4vSM5Voc6tt15t25EUpf9UD+3?=
 =?us-ascii?Q?LhBv4gvSxvKw8BSiAg852RUg05F9CxE5/+6te7YxLHzg/jgI8TRd3uh/dhOf?=
 =?us-ascii?Q?361gSwTmQb3TFvESR9OdeaM6eAFM3gTIjQ4JVIUhSQBjgZvLUvbupggGzTI5?=
 =?us-ascii?Q?BHB8FijBHSjVTmYl+frUl5owAu+LmA44HiOWjy1VmcFJ7cD7jeL2IsHhry7L?=
 =?us-ascii?Q?7hFAXsdR2U8uqKdmhnCe9WU0z7mltpkzsods0gvP78PuhKDFSkV7qdtrVrdH?=
 =?us-ascii?Q?crgw0aAcot4G87pWRAP+RYaezkAqO0Wnwnk1PqaJb1ERdNCPjPrVZEloQC1K?=
 =?us-ascii?Q?4AUIXSlmp5RRoAJ1v2oymEhqYaZmRNv5iMkAct9Dqo+yQFYfGlFdT3D+mRex?=
 =?us-ascii?Q?07q6EZdWXjloIAPkDrlgmARywiNE03agmMVEBZJkPU0SKms4j+zhJEMLq3Tp?=
 =?us-ascii?Q?86anOxeUYlNQC2fcKl81MiuQ6LdMY4F4rvYI2CEcO+ku6WC2Si8xKUTCzRnE?=
 =?us-ascii?Q?G3KR9LiqD5jwq9pNY+rg/kqtMhm+YMEeb+3ruWSqCd+O88tW98KftC94gjpd?=
 =?us-ascii?Q?k54blxeA/Gf7dZJt+wjWT2TFhlFzRfKHJEIgFR9F+qCL+2Qwsau1YW3vwgA3?=
 =?us-ascii?Q?kTs7fXdP39DLLusqEhHILmP7adHh9rfn7xFoCBQwKS4Oe+cLCSVQK+Y7M2mk?=
 =?us-ascii?Q?3IMAnjfwHy2Y6+wvW7NqSjQ5pEkDtIQIHPBCBc468rm94SUXDL/V8KlMxV4A?=
 =?us-ascii?Q?A1xThx+Ova6Tah3IxowOsg+Tm1vvba7x7yWwMePFYlaRTI6wtxHD29jNzTvG?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a60d13a5-0101-4271-c8ba-08dc66299c76
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 19:46:48.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xribTiyx6k16sU872fyBrk5GF33B5unhTrfImq9zVDI4vZM7SqCVq/Ouy3N2wq8gzKPVFicfkAQokvJRC7ddlAxY2xePfSIhXxkL2A0Zrdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7790
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> CXL spec r3.1 8.1.5.2
> By default Secondary Bus Reset (SBR) is masked for CXL ports. Introduce a
> new PCI reset method "cxl_bus" to force SBR on CXL ports by setting
> the unmask SBR bit in the CXL DVSEC port control register before performing
> the bus reset and restore the original value of the bit post reset. The
> new reset method allows the user to intentionally perform SBR on a CXL
> device without needing to set the "Unmask SBR" bit via a user tool.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Use pci_dev_lock guard() on bridge. (Dan)
> ---
>  drivers/pci/pci.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  2 +-
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 570b00fe10f7..3b4f7b369287 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4982,6 +4982,44 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return pci_parent_bus_reset(dev, probe);
>  }
>  
> +static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
> +{
> +	struct pci_dev *bridge;
> +	u16 dvsec, reg, val;
> +	int rc;
> +
> +	bridge = pci_upstream_bridge(dev);
> +	if (!bridge)
> +		return -ENOTTY;
> +
> +	dvsec = cxl_port_dvsec(bridge);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	guard(pci_dev)(bridge);

My concern here is this sets up a pci_reset_function() locking order of:

    pci_dev_lock(@dev)
        pci_dev_lock(pci_upstream_bridge(@dev))

Compare that to pci_reset_bus() that does:

    pci_dev_lock(pci_upstream_bridge(@dev))
        pci_dev_lock(@dev)

This also highlights that the pci_dev_lock() performed by
pci_reset_function() has long been insufficient for the
pci_reset_bus_function() method case that could race userspace when
pci_reset_secondary_bus() is manipulating the bridge control register.

So, if the goal of the lock is to prevent userspace from clobbering the
kernel's read-modify-write cycles of @dev's parent bridge, then the lock
needs to be held over both the cxl_reset_bus_function() and the
pci_reset_bus_function() cases, and it needs to be taken in
upstream-bridge => endpoint order.

