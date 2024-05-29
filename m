Return-Path: <linux-pci+bounces-8061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A82E8D3EEC
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 21:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055A51F231EB
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DD4161302;
	Wed, 29 May 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmKOB37S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A415B13E
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011270; cv=fail; b=f8b8+6NO8UzgIW33e9gwOqIx+SPzgNHnQejI182BrgGhWObzJFNHTthQ5ht92bMU+XKUqrKyQ1ADuEHhn7qOOdw5cXnCC5IIjp0KjY02+xCHmNQ5udKsoZR+gxeNxp3HqXO9f3wM8K1+9ixKYzHRNZAZLQIkjlgy5qwm/7X9wbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011270; c=relaxed/simple;
	bh=2Y+uivvu3Z5igLt6Qx8nPpgTJJwbakwOH742ZLDMa9M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/iQgkEnz/BAuEUkmSLFQT9CiF2eSztES9Ek+JivwkWhJquqXoyenxnKMyj7HNhabjt+Fbd5K1WcSjEQM2SIt6EDtX4AdmtzsWAfZl8GXArPh50Fbqpl4JUe/NQ7E9yRKLNr6tmYxGY5oy8nYuAAb6I9lZ18aqj+DCop0WQ8f/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmKOB37S; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717011269; x=1748547269;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2Y+uivvu3Z5igLt6Qx8nPpgTJJwbakwOH742ZLDMa9M=;
  b=HmKOB37SRlst1YRN+U2ldZKpcYqdB+QmgTvEyAocaT57/8uRfzaXNTpy
   XzhpGjlatt60PicFLGnAJIT7N94f+MyHQBarTZxRo2CbsMkNjqZEDTurX
   Gmc0YBeWAC5QOgvldws51+tZMjD3PV1g2uq3OqhMVWjgC6r86A+KCyegW
   8KrCDxfvpKq+I2KGOAbvxNlhf3jCOG1Fof07VPuj8urWgAknWHlvH+Dtq
   sMBg0gAFbxczysYHdQPTYwbPXU5pgmpQsdJBFa+mOX75vl9VU3TdjpvF7
   wACfxZM9MA0lDwAnXimfO0wLoWIzDPqXVdCwP9IDsoirLEtLBowjPaxxk
   Q==;
X-CSE-ConnectionGUID: zBdNvDIySDmMM9YFxeHu1w==
X-CSE-MsgGUID: 5MRh4MmbSSG77FaknIxtSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24572581"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24572581"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 12:34:28 -0700
X-CSE-ConnectionGUID: YtK6CaNiSJua+2gNSg9HJg==
X-CSE-MsgGUID: e7rG+U1QQ5eDjKZuvpS06w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="40450442"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 12:34:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 12:34:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 12:34:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 12:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf7ZGcG+AhGXOgTe1nxlPyoM9nffHxZBFtvg9OADNIcTdd2qnvMSP7mlv6m5kBO7M/JXB6GSB1eXk2GU9jCrLj6KiBIHFEh1+YhB3qf8940I60M5lMBZAwxoYMAam3D0xz36zTkU0Y8NjLeWACKyxznUr7J1EonYKkQ4dgD1L51ZzNzFfuMQuFEpmkVgcxlGMNsje+2s/G6v0bgE/wHkOTj82zeoqb4iIo+LLAqEUuCr6Tyt1DympeLimfDcVQKSRPB69f2/20TnGRjJzVuGqZgueAcT2bNaNKsYulSgF9giNr8n+HCjmdtqTb90TWG3Q5qlhPmdb0zOtmVB33RsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfXHR2AdADa7u5E2MTsC3lmlYl67iKDNX1fTC275+NI=;
 b=dqDzHpxDjjbOVAWoWhJiWNBBHF4sQn37KEB4pbJYAuWmOIqVkwsVIGj7ax8+K2fqVpN4hExB2mn93diFPfmP5xIUIul0ft/KbsfO/ovQKZEdoZRjKbG0LKnBsHB5j6kvCGQE6ZIBQPizfQQ6U5VAzVmh50dyK2ZgmoMOD+m0w8KKHuBtWhphNDbZrDH9+hfVFnjDLQhBD5FMGHYmyizPCjEly+6m43UAiL8CLmOL024D//KpHfJLfA+yXDjVKk7fPQEbtDpJU2FYR6xc1CggG7Snvf4Z2yXRD5tmW9x92DQoLCspyKOTEKvbNihiKup2RnIm6krJYpuClhW755dLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7928.namprd11.prod.outlook.com (2603:10b6:8:fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.27; Wed, 29 May 2024 19:34:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 19:34:21 +0000
Date: Wed, 29 May 2024 12:34:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Imre Deak <imre.deak@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: "Saarinen, Jani" <jani.saarinen@intel.com>, Jani Nikula
	<jani.nikula@linux.intel.com>, Nirmal Patel <nirmal.patel@linux.intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, =?utf-8?B?5p2OLCDmmJ/ovok=?=
	<korantli@tencent.com>, Jonathan Derrick <jonathan.derrick@linux.dev>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>
Subject: Re: Lockdep annotation introduced warn in VMD driver
Message-ID: <6657833b3b5ae_14984b29437@dwillia2-xfh.jf.intel.com.notmuch>
References: <ZlXP5oTnSApiDbD1@ideak-desk.fi.intel.com>
 <20240528155228.00005850@linux.intel.com>
 <877cfdkpom.fsf@intel.com>
 <DM8PR11MB565579189DD400BACDF5493CE0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
 <DM8PR11MB5655FA22F73644AD0520EC16E0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
 <5fbf60dd-4ad1-43f1-a3e5-451e9481883e@intel.com>
 <ZlddFhB0ZiFpcCUH@ideak-desk.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZlddFhB0ZiFpcCUH@ideak-desk.fi.intel.com>
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c13b502-5c9a-4935-d527-08dc801656f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cGNw8SDYpg5zHE0niyexLDVXPR6d4TEn7tz8cN+qOZ3IfEbdaEPgk4XjwoZo?=
 =?us-ascii?Q?lB3l7apDO1k2os2rFGrBMgUeUFZSBCnaA0mltz9UGjkkohLc8by3CdOCsIhR?=
 =?us-ascii?Q?Mfee1hvwUAM1Tgg9j4xZp33emWyJcioV5jutOKiURUKf2GlOa1Gl620gnJA/?=
 =?us-ascii?Q?e4Mde4ENAqtN1u+4ytuiQzcykc0j/Jj3nBUZHe+dVRLqCkYIvxatfwSikPkf?=
 =?us-ascii?Q?xPGWgrnfER20tDDgZ55wRgIKnvdf2jxugHVJtBre3wX0hcmyaGUvYr+pB6r6?=
 =?us-ascii?Q?o2ALmg/vB9P10CXb+CRp8M4pN6FYE3nKNLH0znb6Kfplnt/kwCwMjhGBGkRZ?=
 =?us-ascii?Q?aNBeXWdR+UIL7Z0Dz0dLhyDb0hvsIFsHWxQx4Lwm7aDrGw41atazoAbMUVE0?=
 =?us-ascii?Q?gDqg3c5vjRVKRXHNFFZIIWIFJw6T5Lby03hWX7L9fjRZCBHUmVxLWFJkL17a?=
 =?us-ascii?Q?MAixlUohtQUTb6VDvPmluAkcI9fQ2/4O+Foe5iv1P+/Pvx9tmZ6Tg32KmMFe?=
 =?us-ascii?Q?FLLmxcaRN6zqoTJVMq1KlIi9HBfPP+HUpAY2NC1HmLrfi4yrv1pK7gCOaLca?=
 =?us-ascii?Q?5Yml3jt9p9u2CAUgij7i/rZ/yKdxS9moYISXIK9ecIACq5BHhB0pf7sOBxmr?=
 =?us-ascii?Q?ymTIl1JOB8ymTitcv3xY/NEEIUK8dS2iu9mn7M4QN7Nn2n0iGsSycr+yCW5c?=
 =?us-ascii?Q?OuRAdukgeMyFbHehkI/ye9VkQ3zyxWg3YTIR0N2/tUX78MkHRI5XSk0upQwz?=
 =?us-ascii?Q?gvZCdMQqQLtwY32UvnjnFEFuT5t0THP6oKuWY0zxK3GB2LJFhyBf+GjKpUmB?=
 =?us-ascii?Q?6q31NCCeh8LaxQN3tc1G+wZIt0DW4+1KaZBhEPKkdq7dnv9EeYkVkolN5JLE?=
 =?us-ascii?Q?ITj4nfGFklbgFNg9ACJE9erqFUWiW0oZtQRJpBUiTkWMbS/NgHRxyo9YAZok?=
 =?us-ascii?Q?iWyKsj2SgFQUbNWPpHBQx2FFWAair7r/eXvHp6wKqjO5xr096+4MUkaomhFk?=
 =?us-ascii?Q?cFlwySGNXI2GE3ID7Y32cR94Ro0BHr03uUeyRjMhqF84HlDsuNaokeT1uuQv?=
 =?us-ascii?Q?ZyM2sq4v1rveh864g9nUKRyMP1djpCbVwvctwCqFLwEu3f7ack6xF7ic48wX?=
 =?us-ascii?Q?t54BLlE1uloMsk0QeXbcx1FjragqXwdfPGOp2/XIzDkhe9tsK0fUhqI/BpoT?=
 =?us-ascii?Q?jU8C916/xOVds9Ogod5ns1XFnG8ZVz6HxDMzP0ARk0I6HSm+wTBOnZ2KJd0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rh7ZBVuMOdHxUyul6JTVLm7sdeG//Z1E6BbAyRw5komlZETIpEFk8+zeDcIC?=
 =?us-ascii?Q?hdwGTMLKSeDHPj2MV6GhdIbEoPq8+/3SbrIx4csqL8PdGnAf6on4EcC5GILC?=
 =?us-ascii?Q?8LFvmbEgUg4Y0djujbAR+sE5loJceIGWMRnplPE5isW1Mhsfm3f8xXyUlsny?=
 =?us-ascii?Q?Z7cyhxN//7qkntcIXYoscrdIQbvfxDYQSHeNeCUe96UhapVZpz46NMHUdW5p?=
 =?us-ascii?Q?ulrRS2p+qRDnN/XXJBStoizexxgqB9clBgXKCa6xjv5Mb9+x4Hkmd9OcR5lC?=
 =?us-ascii?Q?LL8c6eaXi0wV4I4fQTEIkZxlxyQrt788us/Gpx5WYgjpl7lOxWcu8Bx42l0Z?=
 =?us-ascii?Q?Nx+VL9Do+yzhcE/x/o6lSWUBKxluOU0yY63FQdb3r+4q9eWltkqN11nMn68g?=
 =?us-ascii?Q?j17XS4XJimc08IymwBETRGXKSXAKYz3D2fsiDNyLOFDgLZ/aomEDrUqOW+wb?=
 =?us-ascii?Q?gQ8PxqtvrYhF3A9k4srDq4ZTENYHxEEmrTqigTHtM4moKg698uGWRiIdpnY+?=
 =?us-ascii?Q?uN27qPVRHlCThUEDe+I1Is0vlq2A1jMl9jfVCOBNPl64IS9j1AXjFNyN5qBM?=
 =?us-ascii?Q?UmPyBYtxLeEBZSqzBghmOweE1q3UXJIJ9wlZY2XcCDc7kna2F46AuS0auA7R?=
 =?us-ascii?Q?5rKad3T99pRWHFK8ZAqlXpquefOz0BaeIki8CzCVuN1JXuTcp3kRhBpANnCs?=
 =?us-ascii?Q?sz677qCA16k7NGqj4L6Qcawblnf1driz/ky+avXLnSF+izFpL9/46UsydpzA?=
 =?us-ascii?Q?ht2T/mBaOMTfaJfY9j4dADZjHJtwqvDmLyxRe7+ZqMU9mcpmj/s3pH75/8Ju?=
 =?us-ascii?Q?1tq04kbfO0f4VliXuFHI1Rrpy8+Zw2B8+t5Pcw4n1i1jxlKz3XzCIqAegCcx?=
 =?us-ascii?Q?I8W1xImDCB7EKMvWVhuSX7Yutxuwnk7MtYP8KB2nBle82rDgHfOF+3PnaxGa?=
 =?us-ascii?Q?1wMS9Ao1Vw0NXMtX9tFO8Xtrmo+tZwrPnfa4s2PC+2IJXlNemLlObRyDjYeg?=
 =?us-ascii?Q?WC0Lu4etvwdBbMuMgbtFzoOBAINpsQvHEbDSgeG/LUIEdyyzqnLd74ZOaroQ?=
 =?us-ascii?Q?u75iwDeQ/WrhdyEim/xgHCvqf4UmUuH8votfEMgDX+cTondlCmCHQelCeCVW?=
 =?us-ascii?Q?AWxkn1mZX7+KFDg1IwkvZtPyWb/479tUMVBRk9VWNUFcfSV9ncfXEokV5xIb?=
 =?us-ascii?Q?qSfO0eIL9ydlqZGYfX+ai+r+ypuda1qmzS3+aLjT/W0aO6mJ6B/Jt+PT7MhK?=
 =?us-ascii?Q?SPhBfXft7hIBhYvFp1EfbKbPWuUUI6RG0haR0wiiLY+Rv1fh4CK3qYAVWHA4?=
 =?us-ascii?Q?Kb9g9w+6zdmr6c4OURG263lkrUz22+N5Vj4nTiD4DDyhVUBQ0VI2ShNQP/B2?=
 =?us-ascii?Q?g9ZWQWgHaKm7zztA7PefLcZz0qXSoSHOtszpZUmRI+10J+RbWklDjq5+/R5O?=
 =?us-ascii?Q?jHembQgsObQp3yXxH19ilyh8wJxgOiBNapBKD1HqJfMaYvjoHm6UDNIEZaau?=
 =?us-ascii?Q?9Qj9xT2JZCLRF94DtiNLyhT9RF35Peu3NDDOGxh6rlO7e5WajQgh8avuYi8K?=
 =?us-ascii?Q?lEFNxxHp3BOhyXNqTPVHCf9zb1641NAaJzQQVRNIxOuftTdPyuW6b9o5AZp6?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c13b502-5c9a-4935-d527-08dc801656f3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 19:34:21.8285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqyx4xu+BZo8LKXFY12YTGive+0N1rG7oQKBO2iHr36lbiTvODdCR2Kh/WdRzQRGnjLx0XXi9jYf6HS3Ec5VoxBwLK4P18cYOoaJyKiu7dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7928
X-OriginatorOrg: intel.com

Imre Deak wrote:
[..]
> > > Also Imre tried with 2 PCI patches together https://patchwork.freedesktop.org/series/134193/ 
> > > And still not good for those 4 systems (mtlp-9, bat-dg2-13/14 and bat-adlp-11) :
> > > https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/index.html? 
> > > Dave, Dan, thoughts? 
> > 
> > Can you provide the dmesg from the failure system with the 2 patches applied please?
> 
> For the above 4 machines, mtlp-9 not having the originally reported WARN
> (at pci.c:4886) only some other lockdep issue, while the other 3
> machines having both the originally reported one and the other lockdep
> issue:

> https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/bat-mtlp-9/boot0.txt

This one does not seem to implicate cfg_access_lock at all. I wonder if
you revert the lockdep annotation completely if it still fails. I.e.
this is a new lockdep report for v6.10-rc independent of this new
cfg_access_lock annotation.

> https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/bat-dg2-13/boot0.txt
> https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/bat-dg2-14/boot0.txt
> https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/bat-adlp-11/boot0.txt

These are all identical and are pointing out that vmd, via
pci_reset_bus(), has long been performing an unlocked secondary bus
reset that userspace could race and confuse the kernel.

I think the fix for that is below, but this is an increasingly spicy
level of change that gives me some pause, i.e. teach pci_bus_lock() to
lock the bridge itself:

-- 8< --
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59e0949fb079..ac3999bc59e8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5442,6 +5442,7 @@ static void pci_bus_lock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pci_dev_lock(dev);
 		if (dev->subordinate)
@@ -5459,6 +5460,7 @@ static void pci_bus_unlock(struct pci_bus *bus)
 			pci_bus_unlock(dev->subordinate);
 		pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 }
 
 /* Return 1 on successful lock, 0 on contention */
@@ -5466,6 +5468,7 @@ static int pci_bus_trylock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (!pci_dev_trylock(dev))
 			goto unlock;
@@ -5484,6 +5487,7 @@ static int pci_bus_trylock(struct pci_bus *bus)
 			pci_bus_unlock(dev->subordinate);
 		pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 	return 0;
 }
 

