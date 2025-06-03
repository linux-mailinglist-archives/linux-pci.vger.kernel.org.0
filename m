Return-Path: <linux-pci+bounces-28921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B79ACCFDD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 00:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DBE16355A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 22:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A81C2253F2;
	Tue,  3 Jun 2025 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JaWs/0o1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E318DB24
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989631; cv=fail; b=qci0yD3sayEssv209V/jzuQyPsIRbRMYp1ubp+hik3PFraMN1p4+3a6gg8zXbD+2USYtNE2Kp8JRX21yaHjm4bNuXHWux2A9ynr6ok4R/qkfzwGqrFtCeztK8kfeg8vA6r4XYtSc06nrkEQ9ErS0so4HHCY/iEh0PykmS3L3EY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989631; c=relaxed/simple;
	bh=wNpEWFFXTRfFLJ0amFJc+StQAdeVHSJ+0y25klEMr7M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VpT0i5ozvBpAXrX5jXHXJL3Gash7GD3ApXzXqB3bKfDXQmIl9wKNhY/Q/+VKdlz2/ml/SthBgklE6DT1HwRFaVtcH2H8M8Bh38F+4FIK7rv0+uPZR4GMKxGEDPs89oO6hz4D31pKvfKuqd8a6WXHM/m15ysb1NZPDpQFpqFlD18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JaWs/0o1; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748989629; x=1780525629;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wNpEWFFXTRfFLJ0amFJc+StQAdeVHSJ+0y25klEMr7M=;
  b=JaWs/0o1+BCzsTGByxaGLnWvfeIncnSiTuZ1uWT0o0CAPAFGSz5qXIM9
   0R93DtPiLZkut9T4xLopOW30EIeyl8VM24DMeIJlxKr5Mo6HbUNBjtC6Q
   1bmvotMJhIP5d9kZmTvVm0+1RhfMpnRBLS1POmDZdwFN1L2/Sb6ZYUl4X
   RDJOG20wixpprPKILuBe/O2zTwEioy6K+JhummiYqL/+eeS8cfQl4ski1
   LrC/146BEAirg6mtxZeHD80IZiF7qSeYo2f2SDiqv5HKA1B2Q0+DUby3g
   UZHXmGo5EQe24WFqCdqp0pqWx8tI4dEHYtoOTt/YOs8iHetjwbtkayFyt
   w==;
X-CSE-ConnectionGUID: 9VUfSAPJS7qst/8/Ty0glQ==
X-CSE-MsgGUID: tWdisD8ET8qWrde7CNCdkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62441326"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62441326"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:27:08 -0700
X-CSE-ConnectionGUID: 2maN9cTOQhO2n7qNDWqEBw==
X-CSE-MsgGUID: jGQfDZvjT6iT3DfJ6BvNYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="149884265"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:27:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 15:27:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 15:27:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 15:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwoPeh0vLPFcGOypp7nuH6WToL6Ri2aYGgZ35ArEGvxlVptmCIjkd/SCG1D+Y0OUcxJwkUYBP/H2/tHtDuCvvwiNwNyVG2FKD5+WDKMl+FRRoXlZQYk22ljI0ToI4udnastIk7lWBYQebut6I9QxWzR0oeiBGvn/nSowS08855QuBvDMqoSHIzvSrvcyV4pZ4Ivyl54v+WJ2kCIUQTmfzRzaDmsEXAlI7sbpiE9G/w8FjdGi1GTabd2ovmxWOlCBqAyyXqDKfLy3lhbNX7K4DH5LPFbvkirFSeKmtvCm3eTw45xe9Ig86MRA26EhcKyoCXJdyDLZDUc/FXOBqv1CPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4UT7pqtNmAf7bweHx31/zbVg7y7Mig87EXOI/LmVME=;
 b=U8quf+yjuMoY34fIny7v4WTE6DAZkBvOFBG0ni4z/4nFvL0KAvLNPTS1DR3nVSvswbWTtGIkjvdqD8uF1jMrxfUjRZKiPu8rf12GJ7JFlRHyqHliDz+3ngR3IjRocZEoHdexpJDyw9ZTEVjaH14Q0UjOJMALRfjpSjm44AI5KmK3K6WumcHu/DlsLUl473FUzD78GlkHbqnoCourVNbQknrks8unmcsK7cguuSTkw9VwGP1yDTK3lmv28SEalZbQ1Vsx8FoqDRi003RoJVxTQmYDpshP57/d1e0D3GzSqKWVhPfZtiet1Rc8E+tT67iaj+navsGQzcHqFMENTDkmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7347.namprd11.prod.outlook.com (2603:10b6:610:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 22:26:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 22:26:50 +0000
Date: Tue, 3 Jun 2025 15:26:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
Message-ID: <683f76a7324e3_1626e100df@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
 <363a3220-e43c-4965-b138-b85f09a5907b@amd.com>
 <682ceffd717b4_1626e1006f@dwillia2-xfh.jf.intel.com.notmuch>
 <cc0e125a-a297-4573-a315-89f4f95324c4@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cc0e125a-a297-4573-a315-89f4f95324c4@amd.com>
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8588db-63d5-4a05-85a4-08dda2edbc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gpxXAfjW5ewfwnJ1GMcFjDf5WwMEn2t1cS/8tpVNuiXTfvVjdq+SWJWX98xA?=
 =?us-ascii?Q?hUtpBB5SDY6N5lk0mxL41iPSXIIvksApOkjnsch1H5oPHyhctkVhwhZTCTLm?=
 =?us-ascii?Q?2/NypfSM+Huw8O9pQCqtupZdywnC1LdXGeUXXIgNnqYQT3vmjDVijVaC6lpq?=
 =?us-ascii?Q?FgDdCIoV3T+QBIBoMaAcicp5QnmdFi6i81tmlwQttCjDPmcVqbOlOi9T887y?=
 =?us-ascii?Q?71vD8IvyJ/deYWNgAd78V+p7FuFoGWN/xTpQo8vcem9mIzNR3dSDtT6G0Vsu?=
 =?us-ascii?Q?BE1loFrcsW1SiaY7Y/GUZJiiphzajiRCQQa7fVRh0Pps8eY4LoD4UfwwYxWj?=
 =?us-ascii?Q?ymIXkpXhWZ/v3nvPQuGQtuhYml42rnuq5UKBVhWVpRidrjSFITbE61qzQGxQ?=
 =?us-ascii?Q?0ikt6rJQl4iT9R0TOY1MmqdG8J6pQsc2VZF0v1FbT6Wqr8J5yiSRo6GTMaOd?=
 =?us-ascii?Q?3Gf/JShQyPc87Km2seXSikcnKcRhj72ghkmnw55heFtLC9jZR+6m1QJeM6rr?=
 =?us-ascii?Q?Shk0PPLdT6K2UymJHEur5uxmUhj6lnEUegpKLpk3xizxC1RmJnF1hzhrwqxx?=
 =?us-ascii?Q?2yvTEh7RHLe+V6G4ZlceROk0FY0XExuf/XF0KnUF6jFttAZR8FZdq5kuhLyZ?=
 =?us-ascii?Q?Dn4CIDplSrciW7nCESwMxM5VNFXl0TqWpLQgiPK2uWIg69RfS65zW4nmuxoT?=
 =?us-ascii?Q?+3a56istiK1CEegiktPIyj7H8umFz4V0A2uhaDVITSM7J7PwlsYNslIvO1ou?=
 =?us-ascii?Q?yFWqH5TPIh3L96rboHVgSOSQWqucKK+JMiWbZocU5J7wU+88BZF8Rjd+FZsC?=
 =?us-ascii?Q?n/j+8MQimNtb5YI2xsTNVwPDagxzV7F30ukTQk2Fq2OsgwaRXD3b/6ABXYn7?=
 =?us-ascii?Q?QehykcVXIiPsj8AvdGTaIziNdEGgONlDklVXMmTcQxK+y+qnMLX8Fow0cqAO?=
 =?us-ascii?Q?itOoy2Mjpd1f4gQsDCVe0IV2dqa2/g+w+lnNBHjBbeDbJZ++n45r/P7W94Kx?=
 =?us-ascii?Q?lqfPspHFFLey2LHDSw2EDmIhUUdq1waU/0UPWnaszvuQnN7CEtephMzZC+x0?=
 =?us-ascii?Q?GrJ05AMxCqi2CdklijoCQ/LlSgeboXAdVPBAWrnHxh7CicovHgW3ZUbC6H0L?=
 =?us-ascii?Q?mEiT+NbWSD4k0Qm1yZ/H3FNu6FWpIlJ0/v8CGYlHDiazfKpIQJwn0KI531mx?=
 =?us-ascii?Q?vxJfDhLmfb87Loa5PSmX90hf+sSRfvVfLfd5slaIZGpzuk+QmRj3yO9vMOkA?=
 =?us-ascii?Q?FwK596OmUHdIMiuZVHRIXycrx91/TYUEk2k/2N8ZoQ5TzqaSwbX1F89+AN48?=
 =?us-ascii?Q?Kn2SufN6RxUhBG9bOcByfn7GbVtOCwnom9H86RSeAdMjsr6VIGNhwPoDutVH?=
 =?us-ascii?Q?hkZGD82M680x/vQt6uugV3z7AowB/1uHRhh7tHWMflBYfA5fHKya+CKRMCA3?=
 =?us-ascii?Q?ooiOH7PRIGk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QmkfIBkGh4qo+NkM+VMzKKa7zaVwY/VnicJGt5T52WoN4r5LIkZP3tQR6zBn?=
 =?us-ascii?Q?DD5j6eeX3wl9azd3msmsIuGVNu7YnfhLoqW7a1nHs59RvmCCBscPXsfXTJ3Y?=
 =?us-ascii?Q?5o+y1CET8cDOt7WDCjXHXUhDJIfCPYpTgsKm8bDkMBlJwF+gBJ8CjO3p5GfP?=
 =?us-ascii?Q?qXzpl7RFhhnRbnhkYLH5SeIEqsA3ut3tCO8Kz+heeyP51IM2UikHtjjzlEHm?=
 =?us-ascii?Q?Y+AWRTj1AS8p4aPOaR7wLEuTRYCy258js2oaMEhxcYOSobrU5/yGbP2WyANX?=
 =?us-ascii?Q?6fIIrUSVK8tC+BCr1n/7QjFg4lAy8glYsdD3p8+yLDpXYgNwjWnEvY26KJdc?=
 =?us-ascii?Q?+dsmEAcZ0m710w+GAahqpFXSpvm45LkNCkFZIvrqL5ov1Mi8lNl+ES4AbvOQ?=
 =?us-ascii?Q?rI3FrPIH/Ks01m7opbX6HIhuNTvl3fy7vVBbo9W2Kl9xs0auqCqfrkx2cRrD?=
 =?us-ascii?Q?9sBKA4M9UdTWcHkU16lxYSzYu/thTJmmdQijYIuhxQoS2MdUiIx55jgNj7xd?=
 =?us-ascii?Q?vw8yvtmHtsVeooQfh54MsbInSY6FC4Bd0G9IyHjPUOxgokj5XUdsHZPi/HWh?=
 =?us-ascii?Q?pMKNY5wabHK+dXVHjvrrYiGJvqaqt1wmqmp7vRw7BXIHq8IAJ5r5IXx1i8fu?=
 =?us-ascii?Q?PtkmfUhZFTn/B5auUI9s1sYtVJCTRJ+80XUFK2QN0LvHCaPnbDbhb9azcGFs?=
 =?us-ascii?Q?ap/KWMOKqQNVg5ZxzEC7o+LjO1XkGBJCXI5gJQTC4MaIT+FN/d/+aESFPawC?=
 =?us-ascii?Q?4gcR80vy1SGsqrPtCi0EBVrg0dMgd28hLoixY6L+Eu1Nnx/VmFm9kYWreI++?=
 =?us-ascii?Q?/9rkhMhbntl4cmGtsg7thCqgcdmAhDALVx9e+Jw7IIV/B1EiID9pkKRZfS5k?=
 =?us-ascii?Q?o0rXXuVMHsSI1eOxU3Ed1pzZJHFo4Z4pmIqeV6ejKb6bFmc8T8csTUm+oEvd?=
 =?us-ascii?Q?mzLFPULrFhPjVENxxiDW5NREK1nLvHlDlosbb5fJD+25Nj0m+LftzIJ99eu6?=
 =?us-ascii?Q?9kpezt71cnTPArbqjt+W6tJg0mjJCt0lCrGYaQNSPZlmnk5bFEGX9G0ppue7?=
 =?us-ascii?Q?OnIfc4eNYGnvlk5DVdKIRPydiiMYRhwek79OyL/c7rNHvjvJCTdQWnBcfTqb?=
 =?us-ascii?Q?TMFgKaI8dGtsz295Hu+U4iaN+fhUoklThNb4jaq6A6hq0+sCx6rH/XpNWvsW?=
 =?us-ascii?Q?kEPJACL7orsIQmIIgb4/GmddNJukkVnvPI//TUykTlbODQQVSDtY11sjvwOH?=
 =?us-ascii?Q?VrjEA/koieEB/DtbofSzwL9XxSwYN60z/Eu6c4cuhfhxJbKWLXgF0FGVZAjp?=
 =?us-ascii?Q?J1eT7IHraPUpMkPsL6A9JwToymMUFBBPzfNqJL48YqZ1nBjQCv2L3a7AhD1s?=
 =?us-ascii?Q?03SjJkVM7GSg6XHEgFyRb7jset6/NHiyDRnS8B0ddqII5LCBFgindgiJNe5o?=
 =?us-ascii?Q?ZUqRw9NNKm9Ghqcl0rWrmCEDA3UUxtuTSW56kFyJvlNYIwjAe+37r2cpa6mf?=
 =?us-ascii?Q?SosqHQccV+iyqt+9W4RJLWXlKC8t5UcnUfUdUrqDDs9fHm5NVAlEgcJAWycn?=
 =?us-ascii?Q?hDssLcGQQyja817d/5Q1YnETMiiovVgbSt1Jd4iqlAxWJWgXvkC+vBbc8NAy?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8588db-63d5-4a05-85a4-08dda2edbc49
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:26:50.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkpnxLQvA4sdvr8LU6Kd6Of4jbpgNr9trObpmOPXTXkp6mlZiiLKGWAi1TN+rKmfelGgZmxH8DFRhX0rOZMjMgF3H0GrMo4jGWRC+KWq33E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7347
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >>> +static int pci_tsm_accept(struct pci_dev *pdev)
> >>> +{
> >>> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> >>> +	int rc;
> >>> +
> >>> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
> >>
> >> Add an empty line.
> > 
> > I think we, as a community, are still figuring out the coding-style
> > around scope-based cleanup declarations, but I would argue, no empty
> > line required after mid-function variable declarations. Now, in this
> > case it is arguably not "mid-function", but all the other occurrences of
> > tsm_ops_lock() are checking the result on the immediate next line.
> 
> Do not really care as much :)

Hey, what's kernel development without little side-arguments about
whitespace? Will leave it alone for now.

> >>> +	if (!lock)
> >>> +		return -EINTR;
> >>> +
> >>> +	if (tsm->state < PCI_TSM_CONNECT)
> >>> +		return -ENXIO;
> >>> +	if (tsm->state >= PCI_TSM_ACCEPT)
> >>> +		return 0;
> >>> +
> >>> +	/*
> >>> +	 * "Accept" transitions a device to the run state, it is only suitable
> >>> +	 * to make that transition from a known DMA-idle (no active mappings)
> >>> +	 * state.  The "driver detached" state is a coarse way to assert that
> >>> +	 * requirement.
> >>
> >> And then the userspace will modprobe the driver, which will enable BME
> >> and MSE which in turn will render the ERROR state, what is the plan
> >> here?
> > 
> > Right, so the notifier proposal [1] gave me pause because of perceived
> > complexity and my general reluctance to rely on the magic of notifiers
> > when an explicit sequence is easier to read/maintain. The proposal is
> > that drivers switch to TDISP aware setup helpers that understand that
> > BME and MSE were handled at LOCK. Becauase it is not just
> > pci_enable_device() / pci_set_master() awareness that is needed but also
> > pci_disable_device() / pci_clear_master() flows that need consideration
> > for avoiding/handling the TDISP ERROR state.
> > 
> > I.e. support for TDISP-unaware drivers is not a goal.
> 
> So your plan it to modify driver to switch to the secure mode on the
> go? (not arguing, just asking for now)

Effectively, yes. In the non-TDISP case the driver handles the MSE+BME
transition, in the TDISP case the driver also effectively handles the
same as BME+MSE are superseded by the LOCKED state.

So TVM userspace is responsible for marking the device "accepted" and the
driver checks that state before enabling the device (LOCKED -> RUN).

This also allows for kernel debug overrides of the acceptance policy,
because, in the end, the Linux kernel trusts drivers. If the TVM owner
loads a driver that ignores the "accepted" bit, that is the owner's
prerogative. If the TVM owner does not trust a driver there are multiple
knobs under the TVM's control to mitigate that mistrust.

> The alternative is - let TSM do the attestation and acceptance and
> then "modprobe tdispawaredriver tdisp=on" and change the driver to
> assume that BME and MSE are already enabled.

My heartburn with that is that there is an indefinite amount of time
whereby a device is MSE + BME active without any driver to deal with the
consequences. For example, what if the device needs some form of reset /
re-initialization to quiet an engine or silence an interrupt that
immediately starts firing upon the LOCKED -> RUN transition. Userspace
is not in a good position to make judgements about the state of the
device outside of the Interface Report.

> > There are still details to work out like supporting drivers that want to
> > stay loaded over the UNLOCKED->LOCKED->RUN transitions, and whether the
> > "accept" UAPI triggers entry into "RUN" or still requires a driver to
> > perform that.

Yes, I now think entry into "RUN" needs to be a driver triggered event
to maintain parity with the safety of the non-TDISP case.

[..]
> >>> @@ -135,6 +141,8 @@ struct pci_tsm_guest_req_info {
> >>>     * @bind: establish a secure binding with the TVM
> >>>     * @unbind: teardown the secure binding
> >>>     * @guest_req: handle the vendor specific requests from TVM when bound
> >>> + * @accept: TVM-only operation to confirm that system policy allows
> >>> + *	    device to access private memory and be mapped with private mmio.
> >>>     *
> >>>     * @probe and @remove run in pci_tsm_rwsem held for write context. All
> >>>     * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
> >>> @@ -150,6 +158,7 @@ struct pci_tsm_ops {
> >>>    	void (*unbind)(struct pci_tdi *tdi);
> >>>    	int (*guest_req)(struct pci_dev *pdev,
> >>>    			 struct pci_tsm_guest_req_info *info);
> >>> +	int (*accept)(struct pci_dev *pdev);
> >>
> >>
> >> When I posted my v1, I got several comments to not put host and guest
> >> callbacks together which makes sense (as only really "connect" and
> >> "status" are shared, and I am not sure I like dual use of "connect")
> >> and so did I in v2 and yet you are pushing for one struct for all?
> > 
> > Frankly, I missed that feedback and was focused on how to simply extend
> > PCI to understand TSM semantics.
> 
> That was literally you (and I think someone else mentioned it too) ;)
> 
> https://lore.kernel.org/all/66d7a10a4d621_3975294ac@dwillia2-xfh.jf.intel.com.notmuch/

Ugh, yes, it seems that joke: "debugging is a murder mystery where you
find out you were the killer the whole time." can also be true for patch
review.

> "Lets not mix HV and VM hooks in the same ops without good reason" and
> I do not see a good reason here yet.
> 
> More to the point, the host and guest have very little in common to
> have one ops struct for both and then deal with questions "do we
> execute the code related to PF0 in the guest", etc.

Now that is a problem independent of the ops unification question. The
'struct pci_tsm_pf0' data-type should not be used for guest devices. I
will rework that to be a separate data-structure, but still keep
'pci_tsm_ops' unified since the signatures are identical.

> My life definitely got easier with 2 separate structures and my split
> to virt/coco/...(tsm-host.c|tsm-guest.c|tsm.c) + pci/tsm.c.

Here is the reason my thinking evolved from that comment. A primary goal
of drivers/pci/tsm.c is to give one "Device Security" lifetime model to
the PCI core. That means TSM driver discovery (host or guest) lights up
TEE I/O capabilities in the PCI topology. That supports "pci_tsm_ops +
mode flag" vs separate registration mechanisms for different ops.

I also am not perceiving the need for guest-specific ops beyond
->accept(), as part of what drove my reaction to that RFC proposal was
the quantity of proposed ops.

So today's "good reason" is the useful programming pattern of "push
complexity from core-to-leaf". Where the low-level TSM driver needs to
be "mode" aware for some operations.

