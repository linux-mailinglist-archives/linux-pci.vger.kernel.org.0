Return-Path: <linux-pci+bounces-40845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30076C4C5E1
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 09:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AC218858ED
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673F32F5479;
	Tue, 11 Nov 2025 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJpD0g84"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836B26738C;
	Tue, 11 Nov 2025 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849071; cv=fail; b=DbYtSwRWNs/zmCiC+i4Ffv88hsnr/HltPGOt6UyQ3/HkrFZCarhqzup6U1dpSB3YoqKl7NFLxVrsOOoFdY3kGEIvHzvMmJNx/1qf+acjjW5PIJG6Yt28oBS5bwqnqUh9SfZHD7CYt3EwZa5wmY5FI3pORxSyV2D2FnYX+PJZYzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849071; c=relaxed/simple;
	bh=7SUtFxiGtCczqt0qgGLaWEcTyeB9y6bPRhEK4aQcteg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bauwWlPjjEwcVS39eFUUza8R6SYRvCVGITEPMdGl4CFCPcqSs6QqNmLfZs2KNQ7itm9tRKHf4+O6pzylu2Gtb+/jrRjK7PYIhJcubpvEa6VHP2bt8UcgZVhx/PA8WEm5RQI1Gg2g08+9W96hHEMrGQtZHLE7G2pYPAoMPg1wOAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJpD0g84; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762849070; x=1794385070;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7SUtFxiGtCczqt0qgGLaWEcTyeB9y6bPRhEK4aQcteg=;
  b=CJpD0g84fBzw7UAVMlahnGvEnOz3PXY4ii16Cx3MXCUSEiL+8CrkOUAR
   RwLy+rmyQaWOoGd8H9mamGfccceTG7ouqPnUaaq/Hxzf9v+/Gk9xGTEqy
   7SUxBaIqv+BxL+/UN2dX+4v8+sDB+9A+Oc6C4sfg8Vcs/HNRYOPRSofka
   xfIvaDf7Cuy5kn6pHGWJHtg7+61ERhlhZl3XhfN6RNu4MJ62AitDNyNoR
   gCDPtPw8UVuExD19xhil2GrdzY8JMobpmtgsI07iBwFLVDzduGbn9rbox
   RzTZpWVVvP24cCwMPXi3PB8Pi+z55WB9lB93FxAZwO1y8uN2Rj5ghIdzW
   w==;
X-CSE-ConnectionGUID: 6ctK85d8SNenSYlzaDyBdw==
X-CSE-MsgGUID: evf+IezLRMKDQ1ni3lAobA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64949229"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64949229"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:17:49 -0800
X-CSE-ConnectionGUID: DL5vZttGQr+AzQXWUWDfhg==
X-CSE-MsgGUID: liszMSOHQtGHwFu/rmRVSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189339524"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:17:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 00:17:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 00:17:47 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.30)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 00:17:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYZo5b8iUndeU4IFHhHeldTyjX43SO3jO17bYEVnK5WUnagnMQ8AVIxsqS36JdwjkIQZyV+NgUjl2mUq6mz/vE22wwR8AIu67tcS04ehhkVW9VxwOm6scnrNJcRoXu66o1wQ9188rj/Zokc27FKQEhbVPdJZSzN2Jea8CJZcFXBENQpAp6fSyCYia/7typ9fqBi3HuehpNuzrJq3ShEg/pu2lRGxTzVIa0rb/X5mFqaQSbrA++LhslAxz6fnWSJgxfXkel7EFB+rN8nqVzFUKE2paj00FVDxOUXY5hZ1NG8of/NpMpbpDzbNHGtbqMrvL/SMTTkG2OPdXmMPZdquNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PRdAS5DtDGa/Ji8lW+moWDbU5KNc4Q0vkk6xUejFRg=;
 b=KiplpBhXeQuwrRTQQ615GjPPdEM98eW7MJe8HPEhzhku3sLPcBbBn4BG8DsrRW91U68hs62AWoB3DgE+vhc0FrWZzNN0TPOJ1SevOtFvXDuehneh5iKEbsaPu7u+EDNqhZaCbDHTgfndhrwj0OHTsSwID7BIfcYPfMDMUTyh8+fFAbxIo77cqlBKwhdjYO4O4WlAtWzB+9bxJeLnIZQYrS5AUtlO8ce7XE4LxWxYkXXWzbWv73y9iMA8U6ml9DSlALMW+XNlHJ+fYSXFT41DwJciQ5C3J1bl/0SVzzN5nxSG/063KeIIEIXS6l+hTOF0+7J4JbDO/g5g2uV3SMJxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by CH3PR11MB8704.namprd11.prod.outlook.com
 (2603:10b6:610:1c7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:17:42 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:17:42 +0000
Date: Tue, 11 Nov 2025 00:17:36 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 10/25] cxl/pci: Update RAS handler interfaces to
 also support CXL Ports
Message-ID: <aRLxIJiqPjSCqYl-@aschofie-mobl2.lan>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-11-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-11-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR11CA0094.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::35) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|CH3PR11MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: aee83b85-d08b-4473-becf-08de20fac88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uQ/OtMFzZOnwxc3eHLdBTgdVgyfi6gLicjT+t7P94lhJElrjwsVBmrEaXklk?=
 =?us-ascii?Q?azSLsM6rC6fnjyEAU+F70RS7iZ3V+pD4eoeYy8oWR0LvleOtXEcAjVwtL5qi?=
 =?us-ascii?Q?zbIFvmZcDrZJ+EQX11YLXWTXXhoX2kIZtbTfvhm69SIhVpMe18oUNcBQMmll?=
 =?us-ascii?Q?Yva8m9lYeMA0OYMlGAKYNVlyayN9SE4FeBr4eCGlCV6aKnccM8i1CJMuIKf3?=
 =?us-ascii?Q?Q0O5oj4mw4EY8a25sKxPtCYIRduPuu4Is5J9e/XScgFTYOlinhhOD9cYWZPM?=
 =?us-ascii?Q?O1eTrrsn85h7cWQ8KvajUcrcd4jmIBiI1ONL8s+sprIOJyHXHUuu2uyEjONT?=
 =?us-ascii?Q?gJh1Dlac2DAIlKlP/379TUr+XiL4I6Km82xNbDirvyguWuObYdw5DVWzbQBG?=
 =?us-ascii?Q?mSlW3JeZxiEOt2KlvY7XVgvQ7fLCZYd7nHtHUDTu4apvM3l9orbEI8zHK6vo?=
 =?us-ascii?Q?enTh2IPz6cjybH0enFfWlVDNTvgKVMgsvk6ZpU9g+2VtvusnypeKgGfy6t8W?=
 =?us-ascii?Q?NV+qAcOElDtQh1VO/8K/0eU1Luy+JDJG1gNXfyQ2xV91kncKaJK2EZH61yW+?=
 =?us-ascii?Q?5uzQ+srcYDKwv9ECb30X73V2PvJ9snqc0F9gq3PQArybGJOPYZLGODo8UuzG?=
 =?us-ascii?Q?pksztRIC0C5BvsIIByvOVD+vBsBUyRYpE1kQdyux1/La1rJ3mPkRvuODVbI2?=
 =?us-ascii?Q?8Dh+lEfiNcezEAzV4GcTqI02QdRLnASXwldhk2sG5H4CPV6nhfw28Vx0AKtb?=
 =?us-ascii?Q?qckP4qXjLmuXZ3Sxv9p0kMpHYp4dnp/s6CLqwUNUbst2e102H6fMRRsixKHh?=
 =?us-ascii?Q?+ICEGPk8356fGvyEd6b1xkQux5Bgx2Knr894Dvd+HfusG1QpshUWw2WNUskM?=
 =?us-ascii?Q?X907eBezaUavv2y+JLW9BMnIOeZc8iE7g9Q/c8FlGUa25oN5jOQnuVWOjya0?=
 =?us-ascii?Q?uricnAWDlTIIOQkumXWbsnWv8IQAsY2GMWCcIj63PI3eNv6OD8yiCtDjjNfw?=
 =?us-ascii?Q?RW2aicIUnqKgyWGNHwVegTToYAyT59InWXfxaqqgj2XE00W8k2TtmiaB4LR7?=
 =?us-ascii?Q?PPJAWwQQlqXvP3lvTIEXzWllvZS5AWPEosuCyV2uTCU320OFMsCfB13OM23W?=
 =?us-ascii?Q?yIgoh2O7bpL2a7IBwWqXR65tmu5zZwnebmXuMeLiXTbsUrtd8M5YMDAviKsf?=
 =?us-ascii?Q?IZoaky2dWOkRReyiKvtmcVA3NKHZhdXRPlqbF7HyS472VLA2iO6+f2Kg4MMD?=
 =?us-ascii?Q?ERBxua2FHHgrqVnTShKzbaKG016xxaSnuNdq7ZPatfUkPCmsGTcvQ0JF6THs?=
 =?us-ascii?Q?26vzAmZ/pqWsTucIaT6H6GeNT0OmZZ7hSVGJ7oaMq5ftioerfXPI1yPD83E4?=
 =?us-ascii?Q?DikiC37mr/aeS6jUhWaAFDcRD5GM9ed2FLOZIHheJHdjKDExmPi4/ptr4go4?=
 =?us-ascii?Q?2I9o3P51uJnFpE1YCQh3rMpp+15j3AdD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lz9FBKyWBdH0Rq8KKZC+Wiu19LPJE8qOXZX+qP0gTjd1yRIDcxWMwCBpwyU8?=
 =?us-ascii?Q?zQ+QFum/boLicdMKrIOMuO/Z/Y9zZHwSGMgFqykXiWV5wTlOeXH4iC0MwPOR?=
 =?us-ascii?Q?RfrETp+Ttu08+dLGcAN0f00zsgi1IQKiNcQrFyjxZJVqAdfRK7d8+X1x0cTZ?=
 =?us-ascii?Q?RWaFaYeyoMtl9w7HqOIbqnIq/9Bd7s8FKDQ+mBs6N6yovjg8igqeD5CTNS4k?=
 =?us-ascii?Q?1at+I+EhGfBy/kfnz98nN8nUJ2wh447do3bgAHb8a26YI9YcWjeN/lxgVuqy?=
 =?us-ascii?Q?gS3Pyeon88bpSh69xWjfCyvbRGw8Nkz9jlnGRASHyIOQxM44rhuUiy1Xhi0T?=
 =?us-ascii?Q?3iZJkOO4fAyA35Oef7SlwiRMONXipA/ftCmxUyVUeiS0qRS32vCz/u7XghYc?=
 =?us-ascii?Q?FVLL9lH8FKjbA7dfbdllHwzJ7efogdxIOY964TxxFR/pF4ncPGQlMKY8LW18?=
 =?us-ascii?Q?eAwgZXSXMDa2kXpbmXIAzah8r6csjw1nBHQOrRurctOfkOyXvMRErUQmUAyu?=
 =?us-ascii?Q?tFs18HwZi7Zy4dJupIXsQQcswE6ebyem5mDAQ8SfoGBSuOYZRya8eLq53o5O?=
 =?us-ascii?Q?BNB6VGCGqeRpVehsYBjolrWM31w5K5oJskgWLqaWqN2mMHZE7reMhi9uVPWY?=
 =?us-ascii?Q?SVA9S0IwsRbGzDWfTona7ztX/N/Pdco37Pn1kdR+XFWJbYfDKinasZ4KCdUG?=
 =?us-ascii?Q?e6KePOHteeHr7WADr2Qib/V6RzZiHdhXoDYhV2obAvR2W0hoif5dwSMJn12u?=
 =?us-ascii?Q?sEh3aAnh+SHl4ur75M9/FPG5+WsrTSs/QUFZ2dFxE7X1UIawLrWpbXiOP7kH?=
 =?us-ascii?Q?VOiBEHUz2z7BHWavVkbndLOeDwBa1voQ5eMTFpqn0K3dW8aRKoAZHnshJhWs?=
 =?us-ascii?Q?GEjdMEX9GXWmJzKihopT/3yXEc3yXZ8qsJhAk2gTU1Dsaseri319Urczh7oU?=
 =?us-ascii?Q?Pi647nT2kjA4k3oRjgwMS6s5j0D9pLIGOq/ALNnWQITXAWI26OrtZzoP0IpL?=
 =?us-ascii?Q?rw5+ysYLUG+FI4X0XH/AqSn6gSyk6cjgeX3TfVe2KXapjkqdzfDrTs50vM/Q?=
 =?us-ascii?Q?DYiUrEK7wZwMkQ1+qpVXKm0wVemU/9e1LYR9cVZxGZ1/XDBiebitLDvSU3Gm?=
 =?us-ascii?Q?QQ6d/kJwFX4xWKiY+DXzL+7cd/sqxTlOQdjMt/QeKT/OOaeyfRciXEIG5Anb?=
 =?us-ascii?Q?Qadrb9T12wU7uVdDBW2Vm6YY8tRyhBKiyeNXtcTMSdDfF4ItKoERTCXkEKMr?=
 =?us-ascii?Q?kfSXOVDdTC/wo09A+koLPzyFsUKeyUZ9ykwPUZQ56+4+NW/v/JZoHdHpjXjm?=
 =?us-ascii?Q?ipNegTcOPiOeTFzcJ5jCepR9YujJ3ACJVKkF2J0Ibo/+790QTYu1wO8Q1yP8?=
 =?us-ascii?Q?ot/UqnD3N7KXCJRvdHeMYQrUODc7CtOuKMRIMC4xhazIk2GmITN+YWY+kZiH?=
 =?us-ascii?Q?EJF43kMcGh4+xVk6g5ZzZrxbTW/lZk++sJ68Js6GswY4M3X6MtEMfNkzvuZ2?=
 =?us-ascii?Q?5X+KLcayEbx5Ep8Uho3eXKcQ+nCeTqtyIE1HxBmO9xTyQGgmyr9+15jWSYaD?=
 =?us-ascii?Q?lv0KRQF0aBVOblIHK/lEN3HI2sZbmlWkAsr8BIlB/DAL0oay4uqTvwgVbOU+?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aee83b85-d08b-4473-becf-08de20fac88b
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:17:42.1476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToUDBBuc4xKeV2gYIFx7lAa+Z8uZKogI9XNxQ7xR7ktfiqGIFdRqzKKxSFNVrPRxxcPxdQg5kHiIMhF581EaOGmHelJC9mDkkZggqSrVbLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8704
X-OriginatorOrg: intel.com

On Tue, Nov 04, 2025 at 11:02:50AM -0600, Terry Bowman wrote:
> CXL PCIe Port Protocol Error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe Port Protocol Errors.
> 
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL Port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
> 
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
> 
> No functional changes are introduced.
> 
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
> ---
> 
> Changes in v12->v13:
> - Added Ben's review-by
> ---
>  drivers/cxl/core/core.h    | 15 ++++++---------
>  drivers/cxl/core/ras.c     | 12 ++++++------
>  drivers/cxl/core/ras_rch.c |  4 ++--
>  3 files changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index c30ab7c25a92..1a419b35fa59 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <cxl/mailbox.h>
>  #include <linux/rwsem.h>
> +#include <linux/pci.h>

Duplicate include above.

snip

