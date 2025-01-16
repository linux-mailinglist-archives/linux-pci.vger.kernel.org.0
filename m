Return-Path: <linux-pci+bounces-20018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C843A14429
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 22:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58AD016B292
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFF11C3BFE;
	Thu, 16 Jan 2025 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iubdmYhZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBDC19343E;
	Thu, 16 Jan 2025 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063824; cv=fail; b=XMz/XyEvjHhFaU/vfWuztl31yb4mz771/WfduAZDHnKBmK+A/g99acJJ5qmKEykU5JE/NiX9yMEju8O+9KRdkOtckmlqjjq8Mn8NW4qMNZsU/ONfOeOQu8+jtyhSMpTp3mTY1yxA8QrcNyeqyckc7zzOt5dpl4WTIbMnE7biA8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063824; c=relaxed/simple;
	bh=b3jFi5nVvMbh5LhtuVuLnTTtZZJi8CTd3vJPKob+1sE=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YiF8ABH2X8OxkGcMX+LwE8Yx543G57Hj+KBWMUJkjHscheoRweaS6o1OKsJZR8ASFMJ9kkzgqdu+I8p5kE1dOMUvKCVvfgQw2NFmZxfhMDkCW49cKxkJHBxuHtqlHRHR0GNdzvr8DNvSdtPpP102VyyPgy5REMZRI3yp9UByips=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iubdmYhZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737063822; x=1768599822;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=b3jFi5nVvMbh5LhtuVuLnTTtZZJi8CTd3vJPKob+1sE=;
  b=iubdmYhZPZqNuAMrRnPXARdaCjVgmUXNrouKdH8IXTjCVABihxsb5sQh
   eB/kIR9aXUyEGfnTOxaT44Mzmcf4l1nEp2nUe4c0yowJL69MHGZZE7QOz
   iPtjBfi1VhhSoYwcu4o/4opiq/YKuR595uvHUQV7iibJqra7Gy1rVqxoC
   KN93pA/e0F3JhKzbA3kSBBiGVG3pYJxDXBmHkH6g39p097t/D8IPYuHHK
   VA6obTZQmET9GWHHsFGX9GiFQ3YG/mOiDJ2FOWheD4gLRGnUjSEqg2GJd
   9BuqVvOcPOuI6wiRCD1fxw+XhX2HVav1JiAlQQGavkl/sZWWTb2Q4uUek
   A==;
X-CSE-ConnectionGUID: 5wP+dYOHQmelSYE+QxyR4g==
X-CSE-MsgGUID: 9OuR73OMTS2uf+9iochfKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37359011"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37359011"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 13:43:41 -0800
X-CSE-ConnectionGUID: 4TkZh2RZRoGOVC2Rd1ttsQ==
X-CSE-MsgGUID: cLg9d17DTySGVGe8RBRZRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136486696"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 13:43:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 13:43:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 13:43:40 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 13:43:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qjd8JGC+7Nrr1rhI9jE+UnTmsrNouYvG7HAXQzh4gBC98TRy02gpNmwPtmShkBK8GItl54dsvkkd9relu7x/ETfCLcg/VlVcBexB0hOOsYjOa5WziSJyv7YWIKfnfcztxNGcvJcCZicqrRaf7Nn3YTLf+S1w9aK+qWBbY/rlHQebkgrLmlp5WDqxwImEYm0coItYU85vpgqQxqHD7LNF0taRq3WDUj6RQZlTr5KMc4KxpkDp4MtQCyotNDmOmvBEvZkPyNerOnR9YtV0EaRBaKGx/5MZQ0ZNR0Lb4ac6rMPclcalF8OPeQ/ZmclWq6Ed95lLGTrmxGCqUoEqaHh9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4o4FQvdeiCU8WmsVN/QzjRL1KJro3mVqPZn5SbAusI=;
 b=hbSQxmTJjEk+hryvBFt4m9DiVvgafjIS5tIWaCXD5u/OOEX8qHtBwsfxCncQP44+1ARJTJ+w6O962J5fwr8RLdDCnfM+QFZa7Fl/6UiNdpQmk/nGzeD6d+5sj2YDvGOTn1dS4ayvVUzIEzg9KCdUM0Qqu0Wa4uOA1PhzuAsMV//v4/33zbZQcHOkVTD+m2vQzpkuye1qiiIdFXhpneCTWGDkRGF2OmJpCU+0XmHa7Jw9jzsmt2SJpi+/UMPKvB6Nc60q77SO3SSgxoS6af5Q1CAwY/8BIyw+9HOZYKjYIpr3akXmxIR/hPMe1jRtoIbrUwT/Fo9RgyWQov0/9XfhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 21:42:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 21:42:55 +0000
Date: Thu, 16 Jan 2025 15:42:48 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 16/16] PCI/AER: Enable internal errors for CXL
 Upstream and Downstream Switch Ports
Message-ID: <67897d584caf5_1be60929453@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-17-terry.bowman@amd.com>
 <6786f2a7b2b7f_186d9b294f7@iweiny-mobl.notmuch>
 <e3df211d-b699-401f-ac00-1715f7a2d15f@amd.com>
 <6786f7301088a_1963352947c@iweiny-mobl.notmuch>
 <28d730b5-77fc-4d5e-864f-03c0cd4ed4b3@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28d730b5-77fc-4d5e-864f-03c0cd4ed4b3@amd.com>
X-ClientProxiedBy: MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 158b1423-ba9d-4258-29af-08dd3676bc5f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?uNONNOLWb8NGsZwn+EXNBi7NUwh3QJy7Vue83DeHMQvWXsFhr3USUTgmyC?=
 =?iso-8859-1?Q?9+78PoFbkysRYqPKQp0osGw0BwWtS1wpt0m97EhCTnD6CVRUVXZ4OuhYIU?=
 =?iso-8859-1?Q?24Qr9P6o3Fj1S4W2sk+P+qEw+T82iWqNW63O9P9FXWzjPKoxR29FTUN2LC?=
 =?iso-8859-1?Q?nHWDOySnaquJ/YuzQJfHW1p6UzNrXhC4eyRAW7QpsSq2b9BN3AxvYR74Wn?=
 =?iso-8859-1?Q?60wr9/txEjFVAcCQhO5TA2lu3wA2OWmRFoWLQFi8/2abuSKydFaJOWTvoF?=
 =?iso-8859-1?Q?KED8pKznXafoNc1JtYfiLjXu2n7CLRSYAV2Uo9mUvifWKQFjazOX6WIjje?=
 =?iso-8859-1?Q?SVK9ou8eiPomqySjosuJ6Ma7cWX8FPO/cUDjNm6nl6MCeyjFxW+DtFeQ+M?=
 =?iso-8859-1?Q?CaL1Sx36GPsbHkSX3d/HNNz5j75S8udmx/gFlrvo4idRig/L9TTQ+k6Za4?=
 =?iso-8859-1?Q?F9A3Hcb/eXO8zrGCTbtdpFVDWqKZibovH+PcAEnKNxjLWmgxzkxLU6qys9?=
 =?iso-8859-1?Q?UwJi7mXxxkAVUMEJVuq5xPHKooOGOIKDPl9GiVuY5e3xOdSkZWD0w/zk9H?=
 =?iso-8859-1?Q?/CHhrfTrPqawMpXmwYKYni1ULG7Oh49ARomaURYFuzdDJAZ3RnyROsmpa/?=
 =?iso-8859-1?Q?HxWYdfVxivs/HdFd1EcNGC/5eZqelE72gJAdXdaHBgiw7T+T2qbK773O+I?=
 =?iso-8859-1?Q?YndpnxqT2d4L95qge9AlO035Zbp3yJZ2xwCYLFHb1KHy9Cwax/B60DgbFW?=
 =?iso-8859-1?Q?yBCxpQEyLN0IE4JJW9Ka0OiHH/p8tN/nYMvlrQuz0ASffgivFDJamDlGnq?=
 =?iso-8859-1?Q?SOGw6yjucFlgOJHtRX+y802PjEhYSoZO5EgscL6i+ACD9nJF42BU+sdp9T?=
 =?iso-8859-1?Q?6zhiLEiVfNXyUQhDfc7w4hZ9YmO0aLdfYgjNKq6r+1lJBNvPbL5fMirgKA?=
 =?iso-8859-1?Q?baJZC8mMMi7JMRYA++LNwGHsFsyRJfUHMKKvthVPido7ZPOM4KgFC9ulIj?=
 =?iso-8859-1?Q?05pW+k/U8/lAa1LZpqTKhm5aCNL6Z2ta0+r9TCd6vnTzRN8qMQ98kKDsej?=
 =?iso-8859-1?Q?Hk6qHTve8vjuR/rs6ut1gZhazKpW18z+Vjzu0Su/ObUlZBLEdb1a4xwPHP?=
 =?iso-8859-1?Q?oGY2rFGzDR1g/DPWGbrD1LLpDNWwGcZ2CDJE1Z5KmpqdEO9GXnzc1ck1gf?=
 =?iso-8859-1?Q?R+Q8Bxi6jp1DAtlrWHmcYPrLdothjFl1j45feeFCuXWkJOH6uVzAiSqtUc?=
 =?iso-8859-1?Q?bZxPTpYFaAfE0QUGVGGL0vW5BzFsLA7u+RrWwR+5GdQyFQsHYBNH61PA8g?=
 =?iso-8859-1?Q?bDDOBfpZVTOGxE30ri4HuWcLpev1YdHr5A1tyt7w7Gf+USh1rUYTZe5lh0?=
 =?iso-8859-1?Q?M7e1sJy1tztmeliccO1sqGicFhJMYxeWZ96TWvXdsKsneBkFo8xjz5GFbb?=
 =?iso-8859-1?Q?5JJU/XHLXT8Mg1BZTzkmPFnPruOVAV3i5W/9Bj81xpTrsj2KC+bJkzYAH3?=
 =?iso-8859-1?Q?0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?elfOI6wO4RbBvda+uoRu7Qd7nsGpM5CJHXP+7wfIv3GtIQ7a8os/7URIV1?=
 =?iso-8859-1?Q?h5G5jufqGlO5blxgH97kxBPtmcLL/xqdHMmpqp4vUbt5HNfYlAyGlSmJoW?=
 =?iso-8859-1?Q?ZB7gDhrYpI83iiVsMex8sf2M/E/8MBQnE8m0/zAGTr2y0JIS3ajkkr7GMs?=
 =?iso-8859-1?Q?80rDZeWn/kGkDL5b6lRMb3foj/PNS2xgIrzoWlqrXuzPFAQjinBX8q4gz4?=
 =?iso-8859-1?Q?NT9BXXpYacxX1Lyxr1RB2vWf7NSYZ3vjpMpbaPKdJElhMixbgqCahYdeXA?=
 =?iso-8859-1?Q?lof0cOSbnn82782wbuVCp6Ezx3mxKeYpNaoV/wXbf6poX48F1v5E+6/N4y?=
 =?iso-8859-1?Q?NN5+XjFAnEU8P8548v5s3dKX54r8/+Drv7wa4YN+IbP77ozFpwyZ8sSm9G?=
 =?iso-8859-1?Q?LEVU98Qge8XxTVZnAZkQwZwMn0Fm0YAUP1h51yiv4kGD6xiP6zprJLomIl?=
 =?iso-8859-1?Q?ehcxWgWXZECvvo2ENVVqAXxdlvHDxfHtkwDXPBnAKIPuBgSl5a0u3wzoWZ?=
 =?iso-8859-1?Q?ueeDlsKyy414Z3TQdWV+uWM9SU1hFcNln24msZ5HQJWB3fGvFfjfftkWn7?=
 =?iso-8859-1?Q?/8Wn10qkTzQTJtDcMrgwDrhQIoof0sTSB7E36luWmER4VXZ+0HAiONuftO?=
 =?iso-8859-1?Q?et8L5bNT+cG1Q/GlucpvYVvh8NWEXc2F10QfTdjZy99V7/quQfbFiRZYpK?=
 =?iso-8859-1?Q?29sm2WiA5Orot5i30qRKELsrMvWA/NL+RiSZoI1oiNY7uJokVz81rNdC06?=
 =?iso-8859-1?Q?26URiNlUJsPiWx++EnyjUyLnq9z7u1gy8faxtnIi7GJ861Igh0JAZfMnY8?=
 =?iso-8859-1?Q?Hqk0S3oQnUwVfEEIO3D1HCWeo82Xc0nV9VZYiQhHbOPpILZsAjVvbGfQ8L?=
 =?iso-8859-1?Q?vP5GGiwI2pUygkYd5sPwA/dIxAHw232GVI/23ZiTHFNK29kR+Tt2oxt8P1?=
 =?iso-8859-1?Q?UcCK1JyjHIIlKe2FLkPQdvmVkF+mX7VFTCeN336uviVc565VmVQlBtOm4Y?=
 =?iso-8859-1?Q?wUn36HGXr6ggcGcmshnlhkF5TGBwrCMiK8PDKkvzEiNYDFGHaFal8Ha0xo?=
 =?iso-8859-1?Q?3EuneLVQ49pXWWQKJfgFvOCPui/SOLIFGA2pSnc+xqg4B/Vb9S7aK2Joj6?=
 =?iso-8859-1?Q?kDcdc1T2asPGZe1Ymb0AhM/3l3gs2S5tmx1eZ+TktU3YF4KuHuZxyHqAYQ?=
 =?iso-8859-1?Q?a88swU0afujFuf7EPIUW+1T1Xjep80U6kaWOW2kWpyq7kBWSH7+Je1xXcj?=
 =?iso-8859-1?Q?4QLobkvf+RCwEVpWZaMEpq72idKp/XkEvlK7Y+r7Smu/aW63w6nJn1BCYB?=
 =?iso-8859-1?Q?sPOB1WRD6wf6kUYdOeLis/1BKWPe0ezjgrDxROCOtmubwmJb9Ecd4AaJ7o?=
 =?iso-8859-1?Q?fHyvb/7cy6GrwWc49Aj7qyc/whVP/kHH5g0ZZfWusf7RkWTzVVDjetf7IZ?=
 =?iso-8859-1?Q?k6WfTacHcXvEfdpt2WkSUXaWgKjdpGyaeoo5rntPmQsXmRa5BPaIePxs2M?=
 =?iso-8859-1?Q?mmKDQoVX/KJcTM9OhOdsk0anRMIt4A+D8IzWhqaiQa5vICrwgFlAMCYIwP?=
 =?iso-8859-1?Q?OXueJ3N+4EEUhCKTEuNNUt6b5rvw9k9Fthzt18JR5feQL3YShJqxUh8cC5?=
 =?iso-8859-1?Q?lhbksDOK6yfR3a9YPk+XjaPFC8cRAc43vM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 158b1423-ba9d-4258-29af-08dd3676bc5f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:42:55.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wnrk1MnXZ4YLQOtxagp44APQnJ3etqsJjhaTPwa4ICF3twEMsVBY6jWyTd++gGcds+VBP6qL8wIXwxzTNczV5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> 
> On 1/14/2025 5:45 PM, Ira Weiny wrote:
> > Bowman, Terry wrote:
> >>
> >>
> >> On 1/14/2025 5:26 PM, Ira Weiny wrote:
> >>> Terry Bowman wrote:
> >>>> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
> >>>> Correctable Internal errors (CIE) for CXL Root Ports. The UIE and CIE are
> >>>> used in reporting CXL Protocol Errors. The same UIE/CIE enablement is
> >>>> needed for CXL Upstream Switch Ports and CXL Downstream Switch Ports
> >>>> inorder to notify the associated Root Port and OS.[1]
> >>>>
> >>>> Export the AER service driver's pci_aer_unmask_internal_errors() function
> >>>> to CXL namespace.
> >>>>
> >>>> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
> >>>> because it is now an exported function.
> >>> This seems wrong to me.  As of this patch CXL_PCI requires PCIEAER_CXL for
> >>> the AER code to handle the errors which were just enabled.
> >>>
> >>> To keep PCIEAER_CXL optional pci_aer_unmask_internal_errors() should be
> >>> stubbed out in aer.h if !CONFIG_PCIEAER_CXL.
> >>>
> >>> Ira
> >> Bjorn (I believe in v1 or v2) directed me to remove
> >> pci_aer_unmask_internal_errors() dependency on PCIEAER_CXL because it is
> >> now exported. He wants the behavior for other users (and subsystems) to
> >> be consistent with/without the PCIEAER_CXL setting.
> >>
> > I see...  If PCIEAER_CXL is not enabled why even set the cxl error
> > handlers and enable these?
> >
> > I guess this is just adding some code which eventually calls
> > handles_cxl_errors() which returns false in the !PCIEAER_CXL case?
> >
> > Ira
> 
> Re-sending because I somehow sent from Outlook earlier.
> 
> cxl_dport_init_ras_reporting() and cxl_uport_init_ras_reporting() assign the error 
> handlers and are within #ifdef PCIEAER_CXL. The stubs are in cxl.h.
> 
> Correct. handles_cxl_errors() returns false in the !PCIEAER_CXL case.
> 

That is a bit convoluted...  But I'm not sure how to get the cross Kconfig
dependencies set to eliminate the set up.  :-/

So I guess it is fine.

Ira

