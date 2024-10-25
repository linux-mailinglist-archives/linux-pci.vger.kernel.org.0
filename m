Return-Path: <linux-pci+bounces-15371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8EB9B11E6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD8D1F2227B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85CF20F3E7;
	Fri, 25 Oct 2024 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJXOUwgY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6E217F52;
	Fri, 25 Oct 2024 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893075; cv=fail; b=h98idCYrRzrafpnLFwyrvb61eudHt6oPFpfVr3YzijBeP9IOAOP2USL6vWUZ3g439+6BzHQZoICivXoEHUEWJCQJ/HBAltirM6CB2pbCEBnA04uNF7XhsX+LovCs47oz4CObbJrFypkXwNNUwqC9BHqQd06djyeKbI2Mwjx/3bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893075; c=relaxed/simple;
	bh=b+AcW5z+LhuxH8S4a6rgeC+p3lNIPIrjSHwqh1CNDKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSwkUj1OTrm1EAsvgv+oT7Jq1esto/yzqDb1gbVCf/B58O1mM04NMp2BGoVLyzoTL0+nY8w2aGcZHpM5y/+ONQpNVk0Jie2WCD19EhjRHVcvxPXK+bPXmK1/vm8wP6V1CSR3Xrs4gNo0/SXYDNyJA8uml+5o4ZdiJm0UaFinPO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJXOUwgY; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729893074; x=1761429074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=b+AcW5z+LhuxH8S4a6rgeC+p3lNIPIrjSHwqh1CNDKg=;
  b=IJXOUwgYAbYOPE9DvS7+DsiPmNGBbyIKLd5W2KN3sYdi/CRJmtu8/TPS
   X2F0D4Gp39Vj8bQfH889nNEjVLoxDTcLFzoSuPToQ2G0V+hHlRfZGS9uw
   Ps0tHnGzmrCW0lRbL1gL2DZUQ0R6rnAipVH5OrDtnoW4pMEu7mfOw88qf
   4l9UqlbG7Llru2aooihYGF5i9H3dtKt2ElWzHij4En4z6BXhLoEVZOIiz
   1olx0kKpxYZGSaPn9rfneNXYmldshgQOB2dF/fhA8lDRZdKTCy/EkZNrk
   zkvsJayT31OJFb52uoTqm7WV5I5CcafdUA2JI2VhfdT0L0thrk+yxCZK9
   Q==;
X-CSE-ConnectionGUID: mgHRsXp3RkGHULX5Kn8rmg==
X-CSE-MsgGUID: Ctnc3kznQTuyIz7ZMO8myA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29683405"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29683405"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 14:51:13 -0700
X-CSE-ConnectionGUID: xOA1yq0DSQuWWn7xj0d1og==
X-CSE-MsgGUID: XlM93+VVRRGLe77MUcIwiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="81492888"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 14:51:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:51:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 14:51:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 14:51:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1hSppBsaAQsTI8Ht+jNgyTfLeZIlgY5anTt19GT9VJ3Fw1+ZTIZ5d8ZqC0nUUjgM58Un7ywqy0fE5JWwJGooqTQXUARw4n+lagwux27sRw/4PaPkHprlTAIPdcEw8t24c0Y4AtRmfSWt3vK/QZO+QFOlYaG5rLfzm+QSevP6+hPsDQszfTep/jC8BmvRyJ6ukZhOg3yDAl8teZDXdQakbbdC4P8mvouUhp7zn9kHxvr/rx9SqE7zHqEmF211+1EzZIZ+Z8jJ5ebm1IGan5vFKGl6RG6URUmRPwZJnotT2CX4JJHmSA97sXxGnnugNdkltQW8sUodlqA2Ip2CYPlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0eyaZpCfnN0MwjPBmAOWVxef3FSGSOq9l1UFOMvkO4=;
 b=arirohtlEk6yOaCxEvqUEb5nCLZImSi/PsXsi25ijEyHwifjJUhoBEExZ6EYBlZrx7JwnCia/tE6OI7NjfUbYLVOkR0FIfMpPrfWnHdbyu8viZ6Zpx4hwbRFCLoty3B4+r7rqpG5gZ5nbkOBZMtkLgq8Xpn/CzTObSYsqT4q2SqXqcukWKSeBayBc4cI8sR57bQn22LxaejsJQgIwTqdVg0qFfTfKI5k5Nt/T7dPDBi6wSzrGu4DJGBApHGWQkKsdkv46dMERYn3uEFl/yX41cswKFwz001KhQpKXJemsV/hbOGkKk1Csh2WpbBVmwbqnYvw9E3cS1hEMnOiP2LwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Fri, 25 Oct 2024 21:51:09 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 21:51:09 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: <linux-pci@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Michal Wajdeczko
	<michal.wajdeczko@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
	<matthew.d.roper@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>
Subject: [PATCH v4 2/7] PCI: Add a helper to identify IOV resources
Date: Fri, 25 Oct 2024 23:50:33 +0200
Message-ID: <20241025215038.3125626-3-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025215038.3125626-1-michal.winiarski@intel.com>
References: <20241025215038.3125626-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|DS0PR11MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d1cde8-6918-44f5-4c6f-08dcf53f2279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emdROEt2YXB1QnFYUS81WDdVV1ZJUFMxWFNZcFpSN1piZTFRR05TSlJrTWdY?=
 =?utf-8?B?WU10Q2I0Mnl1UktaMXdrUjZPR0dpai82Zmc5a01aRWNkS2VPc0pheDRsRUJ3?=
 =?utf-8?B?OUVRSVVmM1N4VTdiV1pPVXM0VVU3aG1ZNUhOeE0wRjY0YnhRd2NmeHNVRXZh?=
 =?utf-8?B?M2JaUDY4NDlyMHNxMkJoZ1V0Q0hqUmRVOGYxUGFLbG05bTVoaEV5RXZnYWli?=
 =?utf-8?B?MlRNS2tKclVsQy9vSWZNejFLTnppMG1MaGhUSUFhcWE0VGZxWVM1eFBWMTJG?=
 =?utf-8?B?VWZ2L2xhSERZQWYrRjVMdEhvczF5WHdlQVcxTkQwVnJaR04wdHBWUFJ5eUly?=
 =?utf-8?B?S09nQ1RJek43anE3WWFQVGsvTjhVNWhiMmI5NmRXNk9NeFQyMElhTXhQLzlC?=
 =?utf-8?B?aUk5enpkR0IxYm1sMlF1WGt2L0c1enhiTU5ULzE5dzJrQ01acTJ6OHp1R2VG?=
 =?utf-8?B?cmZ5N3RreHhGQmFSdHJWR0pUaFNidHV3RTc5RCszbDAzb0h0cU5DN01XS3JV?=
 =?utf-8?B?WVZQbTlIWnAvVURSZ2VycDh0TE1RUEJxTzRDamhSMnA5OVBlZTN2bEJjSldO?=
 =?utf-8?B?b2dTd3hCVjNFYk4zWE9EeUtBdHNaYkxRWmFoRlVEWkVaeml2S1NyaTdwdjRY?=
 =?utf-8?B?eVNJU0x2N0FxVUJEMnNIYlZoVmxrTlg3T1lKOVdIeEUvVmhmMzBDOUkzY292?=
 =?utf-8?B?RytVR2c5SXljYkVWd1dCOGdveXBrQmxrbU1rdzhrVmlGbTNqV2dOa1lDVGQx?=
 =?utf-8?B?T3RTL1ZqOTQwd2JIYlBNVnFCaGwzQVdqb2lGaTMzMmJ6U2tjMWdBLzJ3REhj?=
 =?utf-8?B?bGY0ZGZlTWFUM2kybS9YQXFjMTl4WTNReUZtbVc2MXJ0K2VJdFBPQWVWVFQx?=
 =?utf-8?B?bTc4UjcxRUNQUnN5WGliM2NaOE5WRWhONFlPYThJcG5mOU1Pd3U5cWppSnI5?=
 =?utf-8?B?NDdpaDFwN2lxc1JjTThicUZRNXpkYkFZSm5LVnp1WWlDbll5ZURPcDhuVDJv?=
 =?utf-8?B?cERXNHU0a1NBTm9MdTdIQmlVSlFoNDVZNUJCajRiOEMrL01wMDNNelVia25y?=
 =?utf-8?B?czNzVVRJYTJPb1lyWjJOeUxkc3dOV0t5NEs0VWxsTWFiZEY1ck5JWlNzckVj?=
 =?utf-8?B?R2lNempwSjZjTGVhQWh2ZGs1S2hwdS9SWHNOQmkrK3g2aEs5OEprcTBacTUw?=
 =?utf-8?B?MGxGQ1N4REsvOUhueDVSVG1ZNVNUMEZzOUU2cW5LWVkxenVkKzVmcU1kTG00?=
 =?utf-8?B?TzBjWXA2OWQ4L0VnQytmTWJtNVVZVDNCNmJTTDU5bWtCQjVBOFhGRWdoOXdL?=
 =?utf-8?B?REVnUVlrZHYvZEw0aWlXY0VMK1NBaXpGQ01NMTBQaU8wZlczRkY4TDJZQzZp?=
 =?utf-8?B?L3BIY3BoQkdscEhWdTFTVjhZd1RBdThXMWNKRkIyODFwb2FxSDdES2RwN3lO?=
 =?utf-8?B?RWc3R0hOcFVoKzJZam01b0tVRmRqclpQbHJZSWRtVmdsTGpzUVZoRzE4Nmpq?=
 =?utf-8?B?ZmM5RFNSR1BhMTI0Z1NXVUMzUDZtYUNjVzV6WE9yelNZR0ttSkliVWVSTTVz?=
 =?utf-8?B?aitwRklwK0RkU2JMMGFLdHRyYXF5M0FXTlp6SVp1dHNORUVnS1ZPZlFYSUhR?=
 =?utf-8?B?V0xqRjZ6cVE0ZVg0TThFWGdjMnJxaEwvSWFLUFlkQ2pxandlQVJHZUZ0TzF6?=
 =?utf-8?B?R1RKUC8vVEZJeXBRNHB0bjYrdGMwZ3dpMXhyQW9Ib0wxQW1COVVaclppeTBl?=
 =?utf-8?Q?yomBOsHKE903d4anfxDqXCnI8QqGDaTfFYsVFlr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bURnZ1FGWldBUzlUQmZXZTcxWVZqOExETU5veUlEelFvOWpUN1ZnMHg5c3F0?=
 =?utf-8?B?blo0ZVVOUkpXOTRtdExZMGJPRi9hTE8rRE5JWEtvL1NmUVF0ZDEyTFI4Nkhi?=
 =?utf-8?B?NXU0N3ZzeUNiTTJjenc0R2ZJdzU1TlErTitKdjlsdFR4RFVrTmRYWDR2VFpO?=
 =?utf-8?B?eGMySWlQeUFoNmhlVjB4RWhLeWZDZ2k0c1dHT3FhK0ZNcWhNS1h5UTlUVHB4?=
 =?utf-8?B?T2xMQy9SelRrVXdFUEo2NG84STNxUUdYM3BoQjJrUk5Jd3hMV3VMRDFIeHE4?=
 =?utf-8?B?blVWMmNUaHozQ2tzaStyOERwalBTZTViRU9oSGZkd3FJV2NqQU1JeFVVYlYz?=
 =?utf-8?B?aE1TT1hNT0NxVGxScks4ZGFPRVNEOWpRbnhDQXZxaE1POUJmQXR5UlI0YnBm?=
 =?utf-8?B?dkhqcm01VHpMbGpYaENMR1FIeW5Zb295QnFBamU4R1hBWFowakJuVTQ4cXds?=
 =?utf-8?B?alRRVFFuMGFIaWErZVFyWlBNa3BuemNWVnBseERIa01hUmc4WmNXdStwektJ?=
 =?utf-8?B?UzRpbEl2dGRXVTVZN3ZrcVJQNjAycm94TGhtcE9VZHdGN2pvQzU4c0ZCa1Bu?=
 =?utf-8?B?QnBWK1ZTL1pxSnI1NkxzRmtlUnJQWGVOYVFXbWMwZzJzQlF4QjlqN1cyL0Fm?=
 =?utf-8?B?aWhOOUlnZklmSlFxdTFNSkZMSlJGSys1eFFablQxcEtlVmJMdStRdUdOTERz?=
 =?utf-8?B?STBLT0pZZ3V4Z051VlN5RVJCUDVHOWtkS0Y4bVN2ODNHbXVSQjNDNnZOSHpQ?=
 =?utf-8?B?aVlOQW5TNjdHZUlvYkV1WTdxNjdTWmVEN2RtVkRsWXRMTGVMVzhONU9CZy9h?=
 =?utf-8?B?RC8rQWNLbkZlQXNPcmM1T3MxcU1xVS8vRDBmczcva1NTV3daNHFDeUZxWnFU?=
 =?utf-8?B?K0w0MGtlaDJSOGpDMXNDZVA5ZXRFcTVEbVlYejBhQkZzRFc4UmhmK1gwbkJ6?=
 =?utf-8?B?aE9FYXpIZi90VE5oblpBS3pTNWpHTmk4UXprWWdVRGpINWVsVnFJZnlKRkxx?=
 =?utf-8?B?NEFuS3VWcGwzT3lWa3lCZ1BYdS9TeFF4NmVBREhuOG4vMk1VaTJsSFllSWky?=
 =?utf-8?B?ckhZQWt3NUw0ZUpmK3l4UnRKSWh2bXdBNWswOWt5R2Q4ZEJoY1VXK21wVHEr?=
 =?utf-8?B?MjdGSjdBVGNqbllzL0grL2lSSnorb0dqN1dhczJRaE13SmlUZWMrNzI1enV1?=
 =?utf-8?B?ajZ3ZWFham16dUhFaEx2cDhDYzhpRVI3dHdtejVuN3NYOWVlTUk2Zit2elBq?=
 =?utf-8?B?eHhSaU5iVWpLOG9YVGplbDJ2NExIOUhYb3QzT0ErTWdPbEhvZHA3aEFiYit4?=
 =?utf-8?B?RzlDdFVtYU85VVZpV243NGhHaWxXMjhIbjFTbkxCTDY5aUpjUHNBc2JkZU85?=
 =?utf-8?B?OG9ZWXNoOGlFaHFsOHh0QmdWMUJUeVlJYnNqd21tdTJYSE9Ya0RCaWlWK0Na?=
 =?utf-8?B?UTNVeVJtOGtibnhsV0VWa29tOGk4WndHQzNrek55L3JGRy9VMzlPUU1WN0Nt?=
 =?utf-8?B?QlVvWXVJNVZZd2lnbExOWjU5SU5iejlVSmZ3R0R6UnpNdFRLMVNzWUdtS01y?=
 =?utf-8?B?YTRueXpucENsUXBvNlBYbE5OTmlrbEJkREVxeFFpU3VwcndyRVdjODA4VVRM?=
 =?utf-8?B?anh0M2dRejdhMk5HYWZCbnN2eWxOT2RyOVZmYVhHU3VuT2tadHlHYTF2c2NH?=
 =?utf-8?B?YjkzcDN5YW1ac2tiaTlFTDN4MTc3UllGcUhmenFsSUlYTW9NRWFSM2lndi9u?=
 =?utf-8?B?Z0lVRVBsL3hTdW16amVkMEk1dUovODZzR3QwUXBScXI1OFlEUUIxVnhUdzMw?=
 =?utf-8?B?WWlHVlJKNXFTM3hxR2RONW5IdDF6Y0dmNUFyVGkwa1hQeE1IeHNvME1RZFdR?=
 =?utf-8?B?WGZUcVBnNDBUeXRyeU5WR2xJVG5tL3RKV0ZXVUlzdTBKSWNlWkFKSEpEY1ph?=
 =?utf-8?B?MEtubU96STJHSE9JczRocmgvY0hTMDBqb0dmZXdmKy9MVStvbXBSZjZyNDdS?=
 =?utf-8?B?VTBZNEE5amhMWjBXOHNqUFNJTEo4alp4NVhZMEVlRytieEJXQ3dOeEc0Q1BE?=
 =?utf-8?B?eXJvZm5xS3NEZzR5QlNObU9ZckVWaWhicGlDTVY0aFRSaFlPdnVTRkpXVDlE?=
 =?utf-8?B?a09FeWRLVFdnL3RKNkhsT21CRTlHVzJ4aTBZZkxreUowTC8vdTZ3bmVpM0dq?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d1cde8-6918-44f5-4c6f-08dcf53f2279
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:51:09.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBvm5R8mZf0qTqPDAYKDqz4HtL1XLnNlVt/HkO//D1iTsggTKnsm2nXhMLy5lS9QxQj0jXW5clHg3rcF+5SzUlP/Bd9fJN9OkKYRc97MMnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
X-OriginatorOrg: intel.com

There are multiple places where special handling is required for IOV
resources.

Extract it to pci_resource_is_iov() helper and drop a few ifdefs.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h       | 19 +++++++++++++++----
 drivers/pci/setup-bus.c |  7 +++----
 drivers/pci/setup-res.c |  4 +---
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa9..48d345607e57e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -580,6 +580,10 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
+static inline bool pci_resource_is_iov(int resno)
+{
+	return resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END;
+}
 extern const struct attribute_group sriov_pf_dev_attr_group;
 extern const struct attribute_group sriov_vf_dev_attr_group;
 #else
@@ -589,12 +593,21 @@ static inline int pci_iov_init(struct pci_dev *dev)
 }
 static inline void pci_iov_release(struct pci_dev *dev) { }
 static inline void pci_iov_remove(struct pci_dev *dev) { }
+static inline void pci_iov_update_resource(struct pci_dev *dev, int resno) { }
+static inline resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev,
+							   int resno)
+{
+	return 0;
+}
 static inline void pci_restore_iov_state(struct pci_dev *dev) { }
 static inline int pci_iov_bus_range(struct pci_bus *bus)
 {
 	return 0;
 }
-
+static inline bool pci_resource_is_iov(int resno)
+{
+	return false;
+}
 #endif /* CONFIG_PCI_IOV */
 
 #ifdef CONFIG_PCIE_PTM
@@ -616,12 +629,10 @@ unsigned long pci_cardbus_resource_alignment(struct resource *);
 static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 						     struct resource *res)
 {
-#ifdef CONFIG_PCI_IOV
 	int resno = res - dev->resource;
 
-	if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)
+	if (pci_resource_is_iov(resno))
 		return pci_sriov_resource_alignment(dev, resno);
-#endif
 	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
 		return pci_cardbus_resource_alignment(res);
 	return resource_alignment(res);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 23082bc0ca37a..ba293df10c050 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1093,17 +1093,16 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			     (r->flags & mask) != type3))
 				continue;
 			r_size = resource_size(r);
-#ifdef CONFIG_PCI_IOV
+
 			/* Put SRIOV requested res to the optional list */
-			if (realloc_head && i >= PCI_IOV_RESOURCES &&
-					i <= PCI_IOV_RESOURCE_END) {
+			if (realloc_head && pci_resource_is_iov(i)) {
 				add_align = max(pci_resource_alignment(dev, r), add_align);
 				r->end = r->start - 1;
 				add_to_list(realloc_head, dev, r, r_size, 0 /* Don't care */);
 				children_add_size += r_size;
 				continue;
 			}
-#endif
+
 			/*
 			 * aligns[0] is for 1MB (since bridge memory
 			 * windows are always at least 1MB aligned), so
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c6d933ddfd464..e2cf79253ebda 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -127,10 +127,8 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 {
 	if (resno <= PCI_ROM_RESOURCE)
 		pci_std_update_resource(dev, resno);
-#ifdef CONFIG_PCI_IOV
-	else if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)
+	else if (pci_resource_is_iov(resno))
 		pci_iov_update_resource(dev, resno);
-#endif
 }
 
 int pci_claim_resource(struct pci_dev *dev, int resource)
-- 
2.47.0


