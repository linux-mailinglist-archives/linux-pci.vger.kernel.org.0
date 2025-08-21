Return-Path: <linux-pci+bounces-34440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ABFB2F0C3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 10:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1001F16C598
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D635B2EA48F;
	Thu, 21 Aug 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgItUGwp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420E2EA475;
	Thu, 21 Aug 2025 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763871; cv=fail; b=XFNJg/LYaD9iKk59Zpm2zfqghfIjowjXfk5iQDLh3/x1GaoPuPkaSXdrvEnb6btl5UsTx6T2FWRwzZT27M0uB4cjYjQDiM1XWQ8KMVYPiPE+slZi9yAU16Tqk2nYwc791uWBWTS76U+CRVPZ8+h7lxxXWyPj0RFw7c8c1kRhPrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763871; c=relaxed/simple;
	bh=voBvJkxSLryI4laWJI8ANNUN+/uBYaCwDU09/IOyGqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JwmJdp/zgPH2Cc8jhqTLSfX3/srZN9uogbIXkCZLFpCumjiFZXjmg34/PJ1zSVAAsjCFZMyNB7Z1ZPg1s2VKkgbt3yJI2flN4uT3oVFwdF/BHJnW3KbnZriJToJ3DwjtX80rnriXYQNSce+D9RbrpGuvRwlE4vxTaH6Zxx0ydOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgItUGwp; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755763870; x=1787299870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=voBvJkxSLryI4laWJI8ANNUN+/uBYaCwDU09/IOyGqA=;
  b=ZgItUGwpvlGL2nAvfBgBUCDuZQy/XWwKxPan91mvSnWxpMFDBN8Z7CQY
   sU0MUV0c8h5PaVXwSBRtrChBRgzTieAnHtQTOb2KsAbb+qXS8JkJDvcMd
   IvY2sWbavLufI9lFPe6mjVp4CSn78ywiEPgzD+9o5hUdhrRiZqETg6spe
   Dwx78UeJqgPkBIAuiSzYL3eKQpfC7KxFjTqw2TryndJmqg0fvIIJW88d+
   yI2lm3C3S9o16Y9VrcngiyIDNCU9yC1B0UT76RPZdwRdCOTPRE2EbJjfm
   YOIy4t+9QQXY1sW2GNlJ+HJ22OkEUcHC/ZnuyoOKC78tHvsL/yMs3PYNn
   g==;
X-CSE-ConnectionGUID: ogSxwTdQTRWTlXhrVXDaVA==
X-CSE-MsgGUID: 0XKo+fdsS0ypO2gcVmoWhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61684262"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61684262"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:11:09 -0700
X-CSE-ConnectionGUID: GwFhfnJPSJWYjwA6VpQnrA==
X-CSE-MsgGUID: 2pKJVL8uQbaGQQOy/br1OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168711169"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:11:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:11:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 01:11:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.79)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:11:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4sjSSFTlI8gA103akoN5Wa4TfqP+u/JjSjE8m0W4U2WS0O8Y1ETX/MX8uwB6Zbsx3WLvOaKeAOd1biHNxZv8wtNmLRJ7pNm4F99Rhq8KluBLqBDLK/XRj0WSD37LViCDf1IIUhaRQYBbLXsXA9v3iiSRiYVb6iOyaUC1lCWSBAd3eHPtC7n72MMa1ftDRIbwSLh8Mxy5Orz5ikTL40Fp6Q+D13B76gQspePg+gEMfTwdxaYjzvyMHmU0T2Zuf7fT4EPYQDS3SCKQ59X973k0JEO5Nscfa8JM/FuF9aFG53XbI7R5yHb/o94Yb+h29BhgZRpnwP/0pjr10q3EdRLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fKWptvpOY/YOa6fywgJnpO+Ur3ioNbffCB709MuQKQ=;
 b=pUZiLtwMVe8OQfpziAXBdajqOv+/il6w2qxAlZ9wSv3QOv7xKNT+pehZfE5E/JYUQeZ705WN8XBYDqQfeoMlv8AIZI3WSK+46M2iSXDHZRNPXk+gzeWlI6xbEgrlbzIfvAg3rVZXFgj+4lPAjozXYx+x/1CgwqOztIO+dzLP+dYWk61LexF9/RMBS+Fddri1MrXG88AMCiwJ8Jc/WKczhXnvelKDSZjkQ4U9obGhMfFD6wFRbI0A/vh0bi72JckjBdykHkMHcwHGXzDvrkuxA8XI4NQcDhX9nX+J+89927FWLWnixYTpqyhrJdhHRB3fZswcSnUs5hvCozzIbkS3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8232.namprd11.prod.outlook.com (2603:10b6:8:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 08:11:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 08:11:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"will@kernel.org" <will@kernel.org>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "yong.wu@mediatek.com"
	<yong.wu@mediatek.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: RE: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Thread-Topic: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Thread-Index: AQHcCxPRj0zb6W5cHUaGmJqSwKG0krRohb6AgAAtjgCABBvC0A==
Date: Thu, 21 Aug 2025 08:11:05 +0000
Message-ID: <BN9PR11MB5276262E1925E2CD8AE037EF8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com> <aKNhIr08fK+xIYcg@Asurada-Nvidia>
In-Reply-To: <aKNhIr08fK+xIYcg@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8232:EE_
x-ms-office365-filtering-correlation-id: 967c0acd-0d24-42f4-dc2e-08dde08a46fe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fiWpRFRynaNde93ZtHcn/CUDKyuigBT43ZVHbkIt7vl3ByDPQJntar5MEcoY?=
 =?us-ascii?Q?+IHEgbLSDdt+g+9rZe9md4nRNpWb/LbziTuQXSpysg7/xEbcIvLodNjSLVL5?=
 =?us-ascii?Q?MFMcYHsvRFKcf1xcE+751CB/BC+NfT/cMKbltUAywjvym6xBDWlsxKWe5M3U?=
 =?us-ascii?Q?DSg6QNXxU1cmXIU1i8OwCOMYxm0NuRePKEVjYA5fsO1u0nE8ksawJ5p98yPj?=
 =?us-ascii?Q?0bqeO+uiq4zi+hRGuXLxm0K4yaYc8d807iNpoCktcbesAhGJolrkoVKrAWjB?=
 =?us-ascii?Q?HiNuRPyXYEV3zh5D2X0AFoWyy37bP1/F0Dzt4jOHmU4u9+2MZtZRJuma/Y4t?=
 =?us-ascii?Q?dR3x5RBVzCUbmiCDgTcAN4ZUY7Gdq2xbHNROzdKhPyXFj/6qHngUtPD+UEnW?=
 =?us-ascii?Q?qQmqP6e43FqYIATjrRV1Uqh8joK+AUOZb9CKq2T3YNcde6wKi0B6kynFQPUS?=
 =?us-ascii?Q?3tLB91vMA/GAfV0fCaXUYfgpy01sE1+ISR3fHW/08CscWPL6Pqy/aJFUAIMv?=
 =?us-ascii?Q?X4RabmrKrqzP6wnAYY+YlBdfyjCgwZAp0nODOZhw1hOY0cZ3FyAjUdYOnuOc?=
 =?us-ascii?Q?GKcejgbg04bgZB3VybqM9VXzO8noaHn2LhzB/opudgZDtPjs/18r+waX847V?=
 =?us-ascii?Q?/Ea8z/xt3is+wrzD62uehRqc9X71hACCchvpBpxXA442WTMuDcGBTfoqVyzn?=
 =?us-ascii?Q?W1IABxm4Dz3aeL8LFo23bKOPblH7qSS4MB8J4RPpaNebm+58vr0VU3JnXINr?=
 =?us-ascii?Q?6DlyEkUXJbtaBmbcOsGZSzRzz3jNnIUf43GKIdKIgP7O+fFCuRxj3yz/kfy0?=
 =?us-ascii?Q?vKxGd+PhQykoYLhKI+2PAYEZ6BM7uPr6ER9xGr+kXaFvHOkrFHjhxSKQaYJv?=
 =?us-ascii?Q?0mZSNeY0gF2JVdwTHxBvk4bwKTjlJJraRXfoImLsxD/rFszrEv4PK602Y+mL?=
 =?us-ascii?Q?mYY+buN3/YETfVI8TlSGzHAI9LRAA1MZFACuqU5GU2HL56R4ktcUa1z/DInB?=
 =?us-ascii?Q?kJmv63WwREkNgi7TXssYd0gXch7rQ8TjWvQxxoBwGrqml0JpdcjynA91AdwZ?=
 =?us-ascii?Q?JPMeRzj5ETNrUxtycJVKU6UYFHfOsr3iXaX+YzTD/1mv+pdZLh0JDaPyy2s9?=
 =?us-ascii?Q?myzm6ym2jmQs5vyBIoO3zxbhBCcjdysFvLOqaottIbT+OMIHP5kiiSqCde6e?=
 =?us-ascii?Q?AkVch2abYuwfgMrRZrupyA2l39uoBMhw2nCO3SiMYkr/Jd3YCm6TKPfVCgNR?=
 =?us-ascii?Q?1YBK33nPP5ZHfFtMF16td3p0Y7Irb3PI8buPuwH+mL+CSnFUOKY5P7lzWaPa?=
 =?us-ascii?Q?YNZN34wgsjuPPzXotPtJ3k90lKRUJFcw9URKwPY2B62OkKLY/abn1UgS2mpu?=
 =?us-ascii?Q?dWQuANWJEOkn3npTUjfZnU9KINaAz8xuzR6BEkB7ANUV4mMlF+IBOtrETD/7?=
 =?us-ascii?Q?jcDol5AqTXXe3RkM0RDmZDDb8mxmZwWZ4zYPiLi4rSMXRoG7ZvsW7Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZJwblIWBf1RT2zKv48oPNrEBQ8sc793gBaMqREvlceqfF6mC3UdPMcfWcu0B?=
 =?us-ascii?Q?t+bbpdyiGVdqP4+5KcVKGtI8vPUC72j0BkrqAsru2jIaSvwQsh9idJd+naQB?=
 =?us-ascii?Q?Lal/TmgvicXIPv0tVnuJF9ietuF4Xi5vXfaw34UV7QuTyIfAizktd7ocwYOT?=
 =?us-ascii?Q?fTxPeGHj11BYcPNY2XCM5Ya9WNBzXqYUx5xrN/9WsiJuL7vr2+4lmCV4kDc5?=
 =?us-ascii?Q?E8FdzfRf2VEWIU4tFyro2AoNyzbMY5Tv+pJ5qumOvne+v6ebgwZ8/YGZRS6t?=
 =?us-ascii?Q?3BOKaBpTAiwBeriS2mHmjhdMJtOkNvDM2Gj1oQBtfT3xGavObX7ekfcHovWJ?=
 =?us-ascii?Q?fcEJcyG4ho7il6/+e+zXPTwJsHbEdi2eZQcXbOEaX5X4516Gyt9eSveYZEmv?=
 =?us-ascii?Q?s+rWZWWv2IQETQmYFiOYywdSAyLLgeHXeC973ZW3EK82lL+wP7xcd3dwSvrt?=
 =?us-ascii?Q?48dmdU0+rxfGx9nbws25Ch90TOK76fdqRCNvJDAtT+11E6ZH30UJJxFwdC1Q?=
 =?us-ascii?Q?XfZluxNtPDRnvNIGJjyQ8U16e/Hj3CzE1CXGVl67NwwM7Rdel7WvBEpQpX6v?=
 =?us-ascii?Q?/jFppEKBVgWx/Uy86+TtKekVjttga0RelEdMD0FKvq/XFJMiT4VeuP8T7JVg?=
 =?us-ascii?Q?/7Njjiy3Igqr3jiVv7v3WgDE228Q5D7CZxfKku6ZVWXpmj5xX/cO4RRjzf+L?=
 =?us-ascii?Q?htl1Y5KMYDr1/+vIQ940J0eL5plGL91z2D0TEnqS2fFbu3hYFzSqTPqBIYUf?=
 =?us-ascii?Q?a57ssxCLVW0xr28xskn8WseT3GLDPl8M4ozFII2x6Hq3Y4PM/C/VCXg19AXv?=
 =?us-ascii?Q?e8MYJtNCbKHFGrpzTIgEO6iSBM+IIP+NnGdyt4v1OXLzosGv7ZI3T/LN2cDx?=
 =?us-ascii?Q?vVG9PuXXm3C3BF43DBqylF8e06VCFGGiPF5mx3tLzUB2FqBwF9QX4X/93YlC?=
 =?us-ascii?Q?QjRkknjGFo+97kedjHDQTENNJEKJvxSZ1S6IBqGAWLvEQ5XXulpfsrdQi/iI?=
 =?us-ascii?Q?pCLnELfyvmSeqX6OxYfwWyg3LTz2AJWU+tKzARnlz9BxvSP6US2BNXjEVOsA?=
 =?us-ascii?Q?olHh3YXlsHfxWXQfBdeh+e0gyOZkWuDlRuzWJNx7uLiey0Halcismapp/C6O?=
 =?us-ascii?Q?fEzqN39du9SJjJHHrKhw+p2+lKDVRPheQoSY1r4gCselx30DTQbBVVpu6Zqr?=
 =?us-ascii?Q?fdwosdynOvAouRZYTwCc5mAiW9NoM6zDfH8ZlgoP20UPBxH/nQ3MEOPsCnhR?=
 =?us-ascii?Q?VH2BLoJ82YMxHmfv73gR1hS7pxq85CUrfsy1nVjWoqINdySwBiRcaePqH0tA?=
 =?us-ascii?Q?17Fstd8O/57Q20zTJZUY0QLZSrGPBpihHKkbEjD5VHvK/FX9XnzlsxrPY/B3?=
 =?us-ascii?Q?6CaGfLFQ/be6ZyRCTq61tEbAL8Z5Ptfas16K8k4nq4PBuP0TaLboQGou+Pu0?=
 =?us-ascii?Q?eFOvZk8u7u+9vU4ffLj+Gu9FzhUWjcCces/gCfMXLRTI3uhih+MyyeBNaMym?=
 =?us-ascii?Q?+e5x+qkg9PSH5eiR6f21uZBd+16s5Z220yS9QjriOBw2hXAJhynWP3ewCUur?=
 =?us-ascii?Q?P44aUf8BLSxZyLYGgjc/gj/A1g8ZU4/JgtfFcGee?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967c0acd-0d24-42f4-dc2e-08dde08a46fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 08:11:05.7435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekJgjuvm8OengaBXq5hgzIag1AGTn+wWmkXwst+2hYIxL9Rh5ub0wiBJrjFHCCVYAZRNFhTCr8gmUnvyIlhPaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8232
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, August 19, 2025 1:23 AM
>=20
> ... I found that in SMMUv3 driver, iommu_get_domain_for_dev() is
> used to get the RID domain for an SVA domain:
>     arm_smmu_set_pasid()
>     arm_smmu_blocking_set_dev_pasid()
>=20
> These two are already given an "old" (SVA) domain pointer, FWIW.
>=20
> So, we may change to passing in the old domain as you suggested,
> yet we still have to fix the iommu_get_domain_for_dev() in order
> to reflect the RID domain correctly for the driver that calls it
> (or even potentially) in some group->mutex locked context where
> the RID domain might not be naturally passed in.
>=20

Out of curiosity.

arm_smmu_blocking_set_dev_pasid()

	/*                             =20
	 * When the last user of the CD table goes away downgrade the STE back
	 * to a non-cd_table one.
	 */
	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
		struct iommu_domain *sid_domain =3D
			iommu_get_domain_for_dev(master->dev);

		if (sid_domain->type =3D=3D IOMMU_DOMAIN_IDENTITY ||
		   sid_domain->type =3D=3D IOMMU_DOMAIN_BLOCKED)
			sid_domain->ops->attach_dev(sid_domain, dev);=20
	}

why cannot downgrade apply to the case where the RID is attached to
a DMA domain?

