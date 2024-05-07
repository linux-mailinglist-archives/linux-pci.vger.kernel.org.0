Return-Path: <linux-pci+bounces-7179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E58BEB7B
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C0B1C21E55
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091F916D331;
	Tue,  7 May 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5yD18v7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24616C84E
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106493; cv=fail; b=oClYWTxtYUFkCRYyRLr41pWlm7z77iH61SyeaKxFhDA0KOMtTY+/ebZ5OAme9v7bFbiQOQU3eBYQhOcq/jv0QrKdONiB2uf5p71jxyegYv4FgK6eQfCVX2YnFwBw8+G53DIGR8EPPV1zvYA61FUkHrT03+B6X7dzhDGVoAQm9KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106493; c=relaxed/simple;
	bh=c1FbzIHeJNVeUam3q6IP/Wvl9FwVG+iU66uePp1wUdA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nNHyY686xWGohOOPjqYET9P4usfarx7k7cgUzx2u37EYyftMLZ+IoRnN0KYfFwwe7lfpy5Oz8RB322qsJ+yJFgQURWMuUKDEpTq2c0TWEYhpGFTirOZiIXtGrpHUfz83yRHQcjZO96f/F3OlYAPuXRfY8XIhk0qWnu2tOCAcT5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5yD18v7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715106492; x=1746642492;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c1FbzIHeJNVeUam3q6IP/Wvl9FwVG+iU66uePp1wUdA=;
  b=P5yD18v7972OoDm1q/I9iHRF002T5x3lgv0Qt0/CxLqfD+U9+iWF4doI
   Rg8X/tkVIV2Pn0SIq8inzXwET0+x2m2U6sbVRursEPFlA6iTqA1kZImSJ
   9IgV0ihMWxRwAyZGaZdmgbpP65B5MJHpafBsUK52vZENHZ7b+fk+o1DLW
   34TRQviEzSk2TcRtvBU4EC+5AIU6N1JwikdaDyKCBenQaDgiqL2GPOejm
   /MmEluCz4mOXhmnj/tH7yPvWQzTpy/VnRkKy/lqoEwigZVQfHs0r1n2D7
   Rr5Fp0z+z+0YQXl56B4qBCuShwveZDMdjKaO8shCr9m1/6IXDOPQ21ric
   g==;
X-CSE-ConnectionGUID: 3hRkTsj+SOqaREg1pss27g==
X-CSE-MsgGUID: n5nfHAniQDSzR/ZIhwssQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10781757"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10781757"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 11:28:11 -0700
X-CSE-ConnectionGUID: pXzP1dBvQSG2SuY5zRg6CQ==
X-CSE-MsgGUID: w6qscYReRKevRdp/Uyylgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28673520"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 11:28:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 11:28:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 11:28:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 11:28:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRqJDpIXEjdqL3zrf+Ww6NvxiqrSD3HppxyXX4vAY17WtXn0TEk7EIjvCX37lKfz+oJBfz7Qt15F1x/B/A0fWwTrK7fI3HQ8Cr82qBsCbNDK0Geh2Og5HonIKqeT71zj3ENZCYPWB9YaSnoil+VpWyLWba3T/ZZgPYeL8LMQQXePG245tqC+6zBHlrDDQeJglVBxZPGmSXVv07fHQRN2DuuUNk1sH+IQNK0tswSUTGAk/QxHNPveX6TSURujz8ZLDPT/DnmKSpMixFOWwvCaKuLSE8MRhIxoWyEL167t53cIHP7RGqy57hgxdDgsL55WkvYvn1Pe1UbN4yOnRG0PvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCqKXbK1PCWUZ/gCUfSKF/vqIN1IU4l11pcU8Bg16NA=;
 b=HqUpl4DkJJADqH4RW3hUVas4BLwA2k6RwaymON0BWmL3/aECuJZnq7AXvAk38s8rNx6g07B0loxcwrOnP0c6yRQwBFULHXUWwQ5n42QqD6zQRXMXmw0q4Um9Q7/aseALCN+0eIFyqWcoCNElr1v+/jhICXnrqFpFxROHyKqpyPQFNNJp+o1c5k9DdYEt0gHAUyPOUNCuzsD6jtptSbYkvd3zGeeDV/APLQsANJhsnCgeDh10joOU4fWArmlb5bcL2hMLMLvLce/UXyH2QCrFoZ1boYHrnO+cmiQ57QOsaFgshuY2n7S7zgdtRC5IIaZq6O+1vcYBUxKA0xfe5+wK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6494.namprd11.prod.outlook.com (2603:10b6:8:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 18:28:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:28:08 +0000
Date: Tue, 7 May 2024 11:28:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>, <linux-coco@lists.linux.dev>, Wu Hao
	<hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>, Lukas Wunner
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <kevin.tian@intel.com>, <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <663a72b5d0910_354c429496@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
 <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
 <fc201452-080e-4942-b5a0-0c64d023ac6b@amd.com>
 <662c69eb6dbf1_b6e0294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZjnqZRPaijFxO9rh@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZjnqZRPaijFxO9rh@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 3269c036-0631-4bc6-2a3c-08dc6ec37169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zmedbx2Fg3b1IeeqNzOphm0NcRaHvfWND6wr7hB16PMCUIl5Lj0hWmxb64ge?=
 =?us-ascii?Q?7+fXsWpHPJig0gLRgWR86xQ/PVro2ltMwvRsAMYsqqMUX3ZuU4NHfv9Bwhpw?=
 =?us-ascii?Q?VFwGO2qrTXyHjhCIQghjF58gTHWY/xzyAtFe4ffr9Lx2Pzl2CN6iZqbdElzm?=
 =?us-ascii?Q?AxkH4bC++2rgvp9fOQIQfA10zh1zwIYSZIC2ffHWS7RILIuK+g6pvLmrXH6k?=
 =?us-ascii?Q?cZ6n68yug0hTCKZTwR6DIq+SzW9Xg6oDPWgkMOrMaRReX1sGWlVN5UjozFXk?=
 =?us-ascii?Q?/pOYBc/VIQyKAzta8F4NxMy5YAt/aXAR40J6XgOok7H+HaUPTgtlNOVHGtOJ?=
 =?us-ascii?Q?tow+q+3EFp3YIy0m58lLeAr11AWLGIY517e1CrXOzcTZ4eXS0rW/KeNdjlYR?=
 =?us-ascii?Q?wbagpu9CUrLKv37LfIKt1MJcgWUa5XzE2YJyLqUuFN582JUYXlT6ZcayW6YT?=
 =?us-ascii?Q?C6edQIrMMlWBTkL1NtspMwMXCFAtrYgIlW7SgnLMMZ/0AjM+ezUa3mcZfPXS?=
 =?us-ascii?Q?Ozrbf6c5nUN2NZ26cEUlvqU2hcFkZCxWLfF5wGeR7eyqW11gc0fHRWqG+S7q?=
 =?us-ascii?Q?tYtCoTRKDjbvIxIZSl8LQPcDvvxjyYUSUdxu8C3nMloxNdQpFkezcDnEdeAB?=
 =?us-ascii?Q?f3MHI562ejbC8YOVHvmbC/TnKoUOX1pt8ODUkwB3Ldga94/bMZf1ycsNlm9n?=
 =?us-ascii?Q?4RpWWOX7ZkrHIQdsYLeSfDQzbh8vf1LDa5dOVF6NSrsUGILLzCTHpD/FYcer?=
 =?us-ascii?Q?adfIKgYbXxofL2560aozn8Tk8aBCnDq0BdPsbbgQnhJg1ntm99deIf9zG8+c?=
 =?us-ascii?Q?X039ZD+4W6vU2RHtejxofXJTyWiVL1V5/uWMQCduQ9/XRQeKfLyELgn6Ih1J?=
 =?us-ascii?Q?FXQSMbR/YPFxK0u6mADGjEBF5V52WoqjTphLtAk8g55RP3MkaGTql0Bn2k8J?=
 =?us-ascii?Q?qGEDMYzibpqBJKxNGHsKjiOlB1FUngbvt1b3X8eizIzjFvwiMSCEM5mxGwX6?=
 =?us-ascii?Q?C6oxTBvUZvxWRQo9Rmraw87KR8lKXV/oPjaFeL34yIYhQ80756vRJSagctT9?=
 =?us-ascii?Q?0vP09nP6Ldo4NuwAsZ4cR9pbnAvKgLil3MG99YN+jlnCgQat+TMSwVEk1ZIv?=
 =?us-ascii?Q?MGHxdqZcPF1//+8qRNP9WpfIJtr4CbqT7I6a57xxYhy+lc91Tl193EYVH5zN?=
 =?us-ascii?Q?s1qBecw9VphsQVjz2qBQicipJhbE4wuJjQezyZJDsTDkLWGWB6DdVPkmEsbI?=
 =?us-ascii?Q?UJpUGjIwv7venyFVuo8LsicaSfkxeiB6LcXV1Wzbrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hi0YpeNwooLsfmwLoWKHiv6GoABa7P4DIHJcSNFaMlUOe5AocATvBCWiS5OC?=
 =?us-ascii?Q?ByCV+dIlgnKBVj0bWL7b4FVcRoMIhjDviLnHNRDwvvven6pdXJMx69OBBXTg?=
 =?us-ascii?Q?uowIufWM2hIaJCuNCGhQ7mCPOtlFv1/GK+aeUSgXrLNeM4XE7xIb2bk68jlR?=
 =?us-ascii?Q?RgZXoJXeVZh7eJKN1I5kGWR/zK7tUaWjNO3t52fJPhGn3Ni6JVaRdN7bL8f9?=
 =?us-ascii?Q?5dcJ09mSoGJd3f0eae+gGeihi45D+ILbQIPfkUjYluYExKZ9Y3Xw0K4rKfGF?=
 =?us-ascii?Q?EV4W7Y6/fQbUcvdtvFF6j8CiHSZwTJLG2+ep3AOQGVNejjpMYHZL6EDi+UGO?=
 =?us-ascii?Q?EhEXXFlSjjsb9iWCbUbPNJfIhPHK+AWOwUeZ8LwCaxBiWH8Az/bEY8bqxS0j?=
 =?us-ascii?Q?5dYOcNeiE+xr1APO9d3OLdcADRlemN+AORc7/r/WnZqBq713n8uVRCUA1FBi?=
 =?us-ascii?Q?oJh1wi+AszlpNl0nBM5tYrH8T2lP2+M9GmdNprcz/fZGWxY95xq35JAds8iK?=
 =?us-ascii?Q?uTIre4a7jhkNwvK4HEPJv6eLkbzsCX4UooqxEJYBFSRWoUo7eGFmqHOBbeZN?=
 =?us-ascii?Q?tjFdaRVCtBjrA+t4U1HCSSpj2LaMmVagEjh0abXYmbtnpwXjd/KRdw0g01Ef?=
 =?us-ascii?Q?TPNl8q/bGBe5qPOOMVq5v+it/bWKE5o1MoR76HGzgRu+WCdpECEKl5UzR+PX?=
 =?us-ascii?Q?ykVGmUy8ULscl+GYE4NOlIvKhNsuWXcHBjUhQ6PWr/KW7Wkhn0iqklD3b946?=
 =?us-ascii?Q?DyY4pQPGSpJWdZiYgsFRTCKFiVoPGcftJPDcOuWPaxQVWz5GLjxyMIYGXSg9?=
 =?us-ascii?Q?F6UUbEkB1in+BHI8UXcxU+DZ5YTAP+bXSTBNgLtiCsBn6nfP1/CXqVRXjlJE?=
 =?us-ascii?Q?9XredHi5F6B420XRNoNUnDScw+Gvk96QOKyLkRT2l0GXuNJwzKl1TKilQbwr?=
 =?us-ascii?Q?BH91DWg9PZ3X7IRHRQZZW/c+Jqzrl2MG4C6CuT1z8tjmYSh1UyGeAxJT+fGP?=
 =?us-ascii?Q?0v75iEs5FNIhGES9Hz+lmeRGQBN0H4ImxwdYbjcm+12kiBJ3+CBwSotssrp6?=
 =?us-ascii?Q?8kFOCHPHlPwr9zEfTOiDDyuq16UkCKweLPliIY0wiqKiA9U8ehbgwHf4jURG?=
 =?us-ascii?Q?EbbAtkarCP0I6bEA5T3TZwlcn96WxzPLJZVOQ3iMPWIdT0guVMTjgac2wKA7?=
 =?us-ascii?Q?t2mseqggmM0Ih/zyntEQPqFTHTaNon9wI2oc6unwwVe8oI69o1ot5k48yWXZ?=
 =?us-ascii?Q?zJmQZU/8/67NClpO0f4O/CbvyCZX5+1e3DR8XidtlHneZcber9PkKHB9XCPW?=
 =?us-ascii?Q?EdZoWJEWwE5wAC0P8ixdS+uRzNRaDPOVjNvk4oWyWrz9Idv1W14thmmZtCaV?=
 =?us-ascii?Q?uCEBxhUnilBKAogpfKMNuCpp6nqRLIzRhPIwPY4FLMWeVaU1njS8gcr2z7Jh?=
 =?us-ascii?Q?H2X4qFPT/DTQ01H3Pr/AowCZ5/vqRb+OQ36B2Sl3k9P/xnd0aC0AKkEXIzli?=
 =?us-ascii?Q?B+vJfIQ0tJE5gzKcZwJgsH7FTC52tJw+c8+6GIoK9/3lcjm3rIT6MmO4JdlZ?=
 =?us-ascii?Q?dqkodRhFlixGtqsxRHIk9ukEedexL3NLUfsXy63HDe2XX3bzT994zVjYEEPB?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3269c036-0631-4bc6-2a3c-08dc6ec37169
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:28:08.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6e5z5IyJkwFjF/WbohDdNl4NyOdrK9WOynxue0dysvhTVfqn6HFRD5bNPEf0zGdiuUsRxX5tS0Db7mifXI2uuVogio71QcQ90xneBgeFeL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6494
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> > > > +
> > > > +/* collect TSM capable devices to rendezvous with the tsm driver */
> > > > +static DEFINE_XARRAY(pci_tsm_devs);
> > > 
> > > imho either this or pci_dev::tsm is enough but not necessarily both.
> > 
> > You mean:
> > 
> > s/pci_tsm_devs/tsm_devs/
> > 
> > ?
> 
> I don't think the concern is just a renaming. My understanding is, we
> already have a struct pci_tsm embedded in struct pci_dev, we could loop
> and find all TSM capable devices by:
> 
> 	for_each_pci_dev(pdev) {
> 		if (pdev->tsm)
> 			pci_tsm_add/del(pdev);
> 	}
> A dedicated list for TSM capable devices seems not necessary.

Not the first time this criticism has been raised against pci_tsm_devs.
I think for_each_pci_dev() is potentially wasteful, but it is trivial to
add back if for_each_pci_dev() scanning becomes too expensive.

> But my concern is about VFs.  VFs are as well TSM capable but not
> applicable for tsm_ops->exec(TSM_EXEC_CONNECT), maybe not applicable
> for tsm_ops->add() either.  One way to distinguish PF/VFs is we only
> collect PFs in pci_tsm_devs, but all TSM capable devices have
> valid pci_dev::tsm pointer.
> 
> TSM capable devices in Guest should not been collected in pci_tsm_devs
> either.

Yes, for this initial phase of the enabling only PF operations are
relevant.

