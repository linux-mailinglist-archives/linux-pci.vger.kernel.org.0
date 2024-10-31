Return-Path: <linux-pci+bounces-15672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902799B75C3
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F41C28598F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E74153828;
	Thu, 31 Oct 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XozHCtu8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19DD14F123;
	Thu, 31 Oct 2024 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361146; cv=fail; b=WCZIrVbT03hvqnwDO2vNP7XMv9E6wInH4+InfK1AELiUzprjb1iHmcTd+l1eWrbwYi2ZorRWnpfLtMhW/cHnZWM1pRh/E1qsaDcBaqm2dVfdaSTLd8BlkzTaP82bkwBSF1Ue5tuowUmQBFuJvkElES73OGAgjgWJ96rckDkNhTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361146; c=relaxed/simple;
	bh=PUkMr1lP2Wd/Pq895kbWNEJ2uEKbplsMO3OwCw8phJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P3mVy4H/+nLwWG55BjK/oSFTfmdtkH1qqn8u+jpoQ7YenwcDCm5I/RipLbiKXcQoqwwuzLJ3Uu4CcknUCVg3AO/eFjuuDukyO1+Mdt0Ml5j3DNavkFVEbMjBjawCaYiyenjinrOjOxVcskneVBJsOXRVKm6ZLCgVQ32ofWpY2tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XozHCtu8; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730361144; x=1761897144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PUkMr1lP2Wd/Pq895kbWNEJ2uEKbplsMO3OwCw8phJc=;
  b=XozHCtu8zl4qB/w+8wPadU01DM2KvzAAoFQDZKFQBi++EE9YK0kfpRoU
   NrBBPKSJKkgiiMBQLtxi/r+IYGSm4wDaH1IlUmZqWAzy5KvBh9JsfA9Tn
   Ya6+48aeTlwITZKK1AoZjttA5QEfrPgXN3/rQNVfKPtcQErC8gm+HNJyB
   v46zNx/enAyiGepbfsyFLx7yk+vt0Dg2DawWeXA3ZhryfL+u5YJ/MmPMR
   q/pOaLA8UC4QGdPWtK/5PmPqraOgvlBhpkXHLNnRD9VjI/AY63vaVkOGD
   vNzl4RThZRcSWB+xXl9ZGwZ9FWdV1LAaj5sl9MEgna7+k6/I4nz4INPCG
   g==;
X-CSE-ConnectionGUID: 8Im4k1b4T0OamF2iK9l6kw==
X-CSE-MsgGUID: D5Y5/1oYS3mV/Gz2OL0LdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30301054"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30301054"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:52:23 -0700
X-CSE-ConnectionGUID: sVa+C/uNSou/MZu34fUtqQ==
X-CSE-MsgGUID: wyI5zpshT1GqVDq5Jo91sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82713448"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 00:52:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 00:52:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 00:52:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 00:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVjxjp+T36hLn9DvykQDYx724k4TdAhjyinTVRqiaw6F8LTxl4IhsW33m42TFAiImUhbfaRJr2L8dz3huMyYbJbfoyCm04d4z3ML/CbkkjatCNfNWYIJOQ6xWDgNqT+GXeuMruGaUp/wvgOeyPdfV4tAwfkCHABnfuNdXM2Lm2udGwnQb+4T+b2CmlXjIU2xMWiAbmbDo3poMfgbdgvpHzkkhBLkWLgg14WbqHo2k1dgwv9I7SvaI+C8yN2NfrTR0ec/4YS0NvFr7zGtThdCfpZ/NquT4Y6iXLPgUBOOZ4vgHcINhoXE2anJ+00Mq3/6+es323k0O5VdAoK2xfah+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLpqbtK+S3Wp2urjb9egG5xmttpx6CL/S6nIqDAJqqk=;
 b=TlQNJFdUyLcgOe+xwo+V3mm/obMqawL51xyy4my8s694KCTAAwMfzOe5O7tjDTT5+ZAEdjaXgJrJ5t0i6RoL/Cn0gv/9fnlJFYmj5IR8EHnqH+DzXnskYsB+5/qJwJbDX9mQ7yaWsIj+S5jk4a8cCVt9RerytA5S6oFCZzGGNbq2wDtAQwCkEkyqhLfMqvxx8lzOrFVMXG/p7/xaaif6DTWbwlcf9TkHScBJvC7bFP1Y9kKKJg66+SA1krFQ66dOxPLPhhF01N7YVat5n6K0QUXVzj0HomGdJnAu8Xe3Z/lKe+K50LP19KQDe2EGD9tkcHkp69tKbgFk3e5LWKwbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DM4PR11MB5993.namprd11.prod.outlook.com (2603:10b6:8:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Thu, 31 Oct
 2024 07:52:17 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 07:52:15 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck,
 Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"avadhut.naik@amd.com" <avadhut.naik@amd.com>, "john.allen@amd.com"
	<john.allen@amd.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>, "richard.gong@amd.com"
	<richard.gong@amd.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "clemens@ladisch.de"
	<clemens@ladisch.de>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>,
	"carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: RE: [PATCH 06/16] x86/amd_nb: Simplify root device search
Thread-Topic: [PATCH 06/16] x86/amd_nb: Simplify root device search
Thread-Index: AQHbJXBT50ZjIdLza0uHiTQFIEI1yrKgh1dg
Date: Thu, 31 Oct 2024 07:52:15 +0000
Message-ID: <CY8PR11MB7134D716377B0C5E40E5C8FF89552@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-7-yazen.ghannam@amd.com>
In-Reply-To: <20241023172150.659002-7-yazen.ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DM4PR11MB5993:EE_
x-ms-office365-filtering-correlation-id: 3f546f9f-f84a-45e4-6f87-08dcf980efef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KAHnojp/HV93DOWF5oatIU5lyhUDd4HtMuWs8idh1NABS4xDhvAdcbnXiZHH?=
 =?us-ascii?Q?XO5lnglndvhFZ8oMOl5Atjx+JCGFf48nTsUpplQ41juZ8lULAP5BGTWjJi7y?=
 =?us-ascii?Q?Ozh1/FwIcmSAM52r1gd1ssun8KPNUX1V5cOJ5vfJQ0pX2pdirK2wFsmK3Ncw?=
 =?us-ascii?Q?AV9j9XO+/JBkBa8tr9wcZYw/YvVCwit1LYpsKq4SuIigLEsf1XnOE9FA9U2E?=
 =?us-ascii?Q?cWOZ0WBVFrw9sfjE3u96PaEIaqjVFDfQJBC7i7UVVylDd4MBZa+na+b1i5hr?=
 =?us-ascii?Q?XuOLaznKCmN3i1vlbdjk96yIKwJtmHpo9fsTBGOaVvoWY6pfAY//PSI0w4Ph?=
 =?us-ascii?Q?oyBzagGqKWcfZIAhjxqYLBDxSVADr9+6B6Ke5lJaWQ30CAoTuDNi0wpFmqud?=
 =?us-ascii?Q?+nMjusW03+lNQ1deWvosdbjNQeDLdDQ0SnTOGlltYjFgEEWzeU2KXvmgAuAo?=
 =?us-ascii?Q?7GcyWtkFub0EAsxlSOmOFBdFzuEZ7WEdBbRWsVDJ7PjLL+WKcbYs4aH0mdPJ?=
 =?us-ascii?Q?cMqH4J9e/QoFRjfQ9ei/M8pWtzka8kO2GAcyVAxUamHKjS5xlvs+IdhjHMcZ?=
 =?us-ascii?Q?5A4PhmVDQ7jem7n2+uaUaITrouvdBqqhocVXkXQqnstP8hksXPUYEX/RstSq?=
 =?us-ascii?Q?VBtbpvNhLuDqlr/O8Sv0BgPnl4Q8sMeqmTrmopC8GG0RLOlnFXCHKZJsYnVP?=
 =?us-ascii?Q?yRRrOzem2ivwJ3CAc6UVEsmK9AJZomDmsWvafnS6QDmaD4SGPoUwmaQ7GhHW?=
 =?us-ascii?Q?xGTPAIUeRPWGtI396i7KA8tfYeRMtY1W1ihdk/b6DprRHTDUr0MHg8nxc+IV?=
 =?us-ascii?Q?nV7zncVpuQ9yGgD1oZ/c/tzTDqLQHUPu7jl1Hepc7NtNMFHUEXPyflSTKLS0?=
 =?us-ascii?Q?IbwfN75GIgQ0f2LrENzB8qtDxgeFuosGVbz3Tq5b6xcBKXgf+ATsa7z92u3m?=
 =?us-ascii?Q?njLsgVSYn+j9HvuLe/b626aZKL0Fjcl5DYcxHMxYiO7NVTo0QJqE6BiSN6Ye?=
 =?us-ascii?Q?rC11gJ26+7HPxxOHSmJX6PYz9KvZuUX1oYRi6aI93wPWBJinOVwd7AWlEGK9?=
 =?us-ascii?Q?1bu9gubnDCg4xW0L3jHYpmsQl0/xUJnrTRf64aIWfLXUaarIVFqQ46D7afnr?=
 =?us-ascii?Q?5M9Hg8Z3ckwGgrWpKMP5cJyVhMTprdEAzzNJdfuzyIi/mrbOaY5e1a0O0xLq?=
 =?us-ascii?Q?D5FPMnoY8R0w25pxQtGuzhkLF3Cj/kXnL4mhxlwCTyIeq4q25EABxkdnTceN?=
 =?us-ascii?Q?paz/yNPprFNnB/V6XPCPbhjABBvYRB2NVd3ycz7Dx5FTW49S5L2AOfqFXTvd?=
 =?us-ascii?Q?whrTNfMlYc/g6PTCPnAd3iLLawBeXtcPA+x+XIZFY0SKYwyzwx/T5vlv51Fa?=
 =?us-ascii?Q?Rz1J8rY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cnw+8wn0YwCVvk61Zz2dB+yIzDBntFEiZJ60APP6fMY0asYCJ9w1nZmXvVso?=
 =?us-ascii?Q?LTj40AvYiURElKnK/H7LtvtLRZ+4WzV5q7ej0w92tqfT71idxTnBvbNDeczp?=
 =?us-ascii?Q?dF0+XZzno5DVp9u3h2EnL5oI9NDv4gs2tTpbf/pQplErREZq9L2z4zwC+7RB?=
 =?us-ascii?Q?1nt7J90kAfhn7uNBpxRhaA/fCkPD2Nl7B0y35xCqiDZ1Bf6ljoC9cyVqS7yN?=
 =?us-ascii?Q?lMRl1th5YF8Jh4gU/kMyWxG9zvUWmALT3E3jzwIe1F9alzc0u45zSKQTI5rM?=
 =?us-ascii?Q?Wp5ACVDfILdeCRMrt/6v1kdwdsaQSuibDCinKTThQ0ocVyHnobiGjALJUE9S?=
 =?us-ascii?Q?DWBkinH9tdyjTj1S7c+72mjmn5seyv8+4jWWnMrJrWrGA2GjSvC/VSioHpJS?=
 =?us-ascii?Q?RbQLYk9MjgMZBu2RD4cotDJUuVHtbVsFCrgtIftGwavoSshw0o8lpSNhCaD+?=
 =?us-ascii?Q?rdocAN1UP0HGoHH8kJi0vdQ221l3MErwJ6kw8f6ItYnM2z9+vKlL846murCo?=
 =?us-ascii?Q?mdxJcTBTNa8b7mVGYda0bYusn/kZhckkVnwGlFMHtI0wOZtBAaMGpWSr1QQk?=
 =?us-ascii?Q?dOHnbybAShJjiEvcq3XTEBZKzQTRpvKByI5EKL4LpUMt5oM3GOH1zBiQwTf9?=
 =?us-ascii?Q?sIgzmQUmCFI0LDDCbW6XbwJTHW2j1KsxuYT075sJg/ffh9AEdAQeiT/P4xiS?=
 =?us-ascii?Q?ck+8mP5Z2f6GQ8iM12GRU3midwdUFRLLAPCligLG9s822sCyr3fZ0gBQoJNJ?=
 =?us-ascii?Q?9EmPXfyfUGp+3jtkQefq25Rddc9PQ+US1ASLlng9xWqi7oPKsSzpyxoXH149?=
 =?us-ascii?Q?ZK9EbAZQ6RnPVsVkPAKNwTVY2lGQX/KIM8oZVvVGwZunPWOozythyiu8NjCl?=
 =?us-ascii?Q?X09N4cySZScmsaLjNqHwuU3SusiBwDHSUWH6JNJKYACxBUfQJ44krxlD8EZB?=
 =?us-ascii?Q?2BVvMnPtJxl6iYV/0ScAEfxpQ7Vfw+KZMOYDpRlSZhqc1KiLlogsC8o2c3PK?=
 =?us-ascii?Q?AR8o8m+DtDFtcz/pFIhiBEBk1u1YurwPjWv79GymbQrbmjhIl5KggOBNbWla?=
 =?us-ascii?Q?L9xsNlnQaE1bfzH9/h7ECiI0MZIox4Eo1yXfVjCsReJUXmNVxWg8sig7JZma?=
 =?us-ascii?Q?sL50csbsOifKNoAID8BOj6HcDqRTYl097TxgBbcCtRRbVLwH6EhXFpDCdD9U?=
 =?us-ascii?Q?MjXC1KXHK6bgc+AOZ+KcJyRcivyAzI1Q6mIAHnocgFC/y8GYGEQzuWJpwkzE?=
 =?us-ascii?Q?Tk0JE5BUwJVZFTnvhqXMkiWHg2gwGPbMLlG7CA0o4+ctZHd594dPy4J3kOjQ?=
 =?us-ascii?Q?2mxFcRkZKFL0LJmYnM7iPy2P6oePaYqvappjxM/Wt+bnq52UkCtxgziftNnE?=
 =?us-ascii?Q?CU+E9eGXBssLVhtkURaoRL89Uw+VAsGgorD7/6tJ3gGznfn3tKzVwghZaiov?=
 =?us-ascii?Q?9jbydlZCmBkatm5SQjckO90nrOJ4WV/dUc09GzE82WvUIQV0U1xRl+Mnqbw+?=
 =?us-ascii?Q?Z3TSYhsQO7GkxdUiRaSXZZSRRBsNZ1VvY45WcuXOAo6iRDV19Yi96g813W2d?=
 =?us-ascii?Q?iBgSOWLqaTsGMfyiP2OVzd4UwccDRYdMlDNqFyF+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f546f9f-f84a-45e4-6f87-08dcf980efef
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 07:52:15.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vyCq3ga9Mygttab4h+qhq07UcQQXiSdcMZAIhXCB6S1hHP3kghYJty+V1EQghq6LW9n3gRzfMu5rhqe28ebnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5993
X-OriginatorOrg: intel.com

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]
> +struct pci_dev *amd_node_get_root(u16 node) {
> +	struct pci_dev *df_f0 __free(pci_dev_put) =3D NULL;

NULL pointer initialization is not necessary.

> +	struct pci_dev *root;
> +	u16 cntl_off;
> +	u8 bus;
> +
> +	if (!boot_cpu_has(X86_FEATURE_ZEN))
> +		return NULL;
> +
> +	/*
> +	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
> +	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
> +	 * this Data Fabric instance. The segment, device, and function will be
> 0.
> +	 */
> +	df_f0 =3D amd_node_get_func(node, 0);
> +	if (!df_f0)
> +		return NULL;
> [...]

