Return-Path: <linux-pci+bounces-40846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6317DC4C633
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 09:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603F91894F06
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD662BE024;
	Tue, 11 Nov 2025 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTf6kN/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3DF2EC54A;
	Tue, 11 Nov 2025 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849432; cv=fail; b=swmAd0lDDdBNBBLrQxl6YlF6TL4HE8sqj+PSwRwKlZIQO8ucqhTkTQNjHRql7TIVWRAkZOSWFa1bSFe7J/2v8SzyPmns6MdyhV76+JlN1nNPmX/8uQcw1zVywnl7ZzcEdY9ARCwOfvCd3No750YrWKB60eo2rl+Xy3p0K7yEcnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849432; c=relaxed/simple;
	bh=FuCQ6Nmr1aZb3FdLCkkjdFSxm3CkNV5dbcU9MMy5HI8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f04CpthzDcdGyrGjt86pJTa0cbdELwrM/0cQmkpP9ilWBnn15eIc5Y0llkLaBMnHcJMKjOUgCxwHA1kdfMcMY7hSqCzxlUtNBB91/qOs2B+EGC3RfRsX0lQV3kp1J7cKkAKcvvK51r0gPq68swE4ue4LGTSFACFLKdvbN+HYcNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTf6kN/w; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762849430; x=1794385430;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FuCQ6Nmr1aZb3FdLCkkjdFSxm3CkNV5dbcU9MMy5HI8=;
  b=dTf6kN/wYj1vzLVQCNsX86pv5XTCrOlUX8f247iHlX0oFizFkyv3yZT6
   7mMfCTpvFSHNZpEb7/BhRUqd/PE2/a6DMo4e2vBWMvIbG9meXDQz42gp6
   UOzdnLkqqHzYxAcLdiisu6WWvwt/NEtVNtJtRWuMCfuZjQi1dRaOG/0zU
   ZmShSnvwm3ade0VJgth5NVsYUqKDXx8eu+1kTl+16ztKNfD3B9IZbr+W/
   K2TKoi4E4Oq3wUb5LM5gF4Pvureq4curZrNHAe8FM+H+qVJ0c68SdIx8o
   5xDq+LZdOU7b5zITYyZIOHqXtJrtvVkbao63SxQgAfvCihYDyZCcAM3hx
   Q==;
X-CSE-ConnectionGUID: 7XGh4gq1QGuNVLria2O10w==
X-CSE-MsgGUID: K7awkHmcRbuKprF03dTUhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64824982"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64824982"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:23:45 -0800
X-CSE-ConnectionGUID: k29DDuNOSiWa1YYfve0/NQ==
X-CSE-MsgGUID: j0QMf2fVQoOWmyl1LU3SGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193286025"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:23:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 00:23:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 00:23:44 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 00:23:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IybGAowl2vFVFya+IIzivv6VmQX67rCuMkhIETV90rZLmKxunNhGbz5MrAloQStzqThvDHaXQQkGb7y/deWEzKzvRHfN1BKWIzrm8t4u757dXK9pjULJyO6Y677JfDQdjiFVbzzosDlt77KNQmaGnwiys/iEC1Ch34awqgvVWXscuKQxa9pCnxFeKTNgPg+Y6LlaPRfEL55dwzBgjW6BKWAGrirgh+TLmnnmPEsMog0loSFXel8fdyTdhH8MA4cPB0aOaQZQzVxOy2Y9Yf1nMdLLI6gNzHDCVpGbsvZqzhXrHVC/tI04ojoKCfwPVaF2X7KR21bE3d9rEUuCNzoupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUzziGw14RYV2S+Ly2BM9VfgZkFfjemY5O+v/xOZfWs=;
 b=XyYNXDpPJk0TX9tR0k1XJtihmwP2PE3SsfRj0AYucc/9IObOx0kQlOtDWan3vNIk6T6X98FQZT9IQjihCROmGi5Z1nShPOAj4JwQ6KVqycHb0VYkmd5KqMF/2HSadHdlqNevJd/S0TErZjCO9UVl2Vz18SnmvujlO05Q32vIHNlhL6rCmAfkxNb1sPXxmfcSFgkfzll8hF9/IjK4mez1P1HYiiu1qZFCsx4xS7ej/OsFPZIhPK5rSvGMiG/pjvV5Wo1HJBnhc928HpaqSqpo/UidH9m36yJL5LQ3HWCfFBdPMJog6i44Gm0IqX8bZy+7A3Qt18pvow9pPHcImChx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by CH3PR11MB8704.namprd11.prod.outlook.com
 (2603:10b6:610:1c7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:23:37 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:23:37 +0000
Date: Tue, 11 Nov 2025 00:23:33 -0800
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
Subject: Re: [RESEND v13 14/25] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
Message-ID: <aRLyhVJ2UYKnE47w@aschofie-mobl2.lan>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-15-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-15-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|CH3PR11MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: d92f23c7-ad7e-4d9c-f39f-08de20fb9c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jgu8jHEQxDgJMfyPMBJOMC5Z8wBhO6haP3uPUlVMR3PALOKJADi0dIGIO1KK?=
 =?us-ascii?Q?rOh144Y7cbeaOCtFyRvpdqJSXOUdx90syaJNNRXtBUYPkq4ZJ0WBwcfnYt5K?=
 =?us-ascii?Q?fWPVlaIAKhXgndK1LSyvL5xTTP5sGQuJwWl6jPHkHQuHvpf7Wwp10kqxxTLt?=
 =?us-ascii?Q?H3GxryzNr6Uh7oPdpiaPyFrZ0vTYa09QbVJUKDu3kFbnCp7+F0pt5KQN3rl/?=
 =?us-ascii?Q?CE1DeFWNUMwDB1BtSYyh3NUUQQAVPEbi+smtaVw9xtXp5rw/Dlx5Lm/Hj8RG?=
 =?us-ascii?Q?Sjd790s3e4q02rgvu3Sn6/A+4q2ImiOHBUmedEfet5AYpL+N9jKPA3aEpAHe?=
 =?us-ascii?Q?98FSmED85AZw0G6BExhGCyIR5/WtY0lH2mPk8hjSl+Xd+Fb8dZtJ9vd7wtzW?=
 =?us-ascii?Q?ELi73w0LbNztGvI2KohabmZlBS0w3wsC+96f4DwpUz/IUp2HShYHK4E2nzWH?=
 =?us-ascii?Q?s0rITtWtfI61jafDSSzxh+cgWIIdQ1BIw0JnUH5s0qzCbU9hnKgm6MbUI9KA?=
 =?us-ascii?Q?Ovl5TYh3Z5InTxnSa7ZLXalfn5wkCzFLsADNceY9zpI36iQyoPWJWw5meZgf?=
 =?us-ascii?Q?nTq4BYACJhG7cI7D8wcUZpuMz3RYjNjglOv25Y3EHRgAob6sLbVm3BraWqCz?=
 =?us-ascii?Q?F0WA9v0aIhyYZoSZKQ2gZF/EXnLit0u5GGcRu88rqjWgTOdPl/niFITGm/rb?=
 =?us-ascii?Q?TxuC6kt2V7I5osQDr7ES/QbQD7q0CXwLlYLSAtssKQZaf/knxmEouizUbY5y?=
 =?us-ascii?Q?rwoY3AF0TAmEeHT0w3Mc5KVm/atPw/0OnUBKGNLpy+Y4CTR1pcc/BXIRa0e9?=
 =?us-ascii?Q?KTKHAJOrmcEJKnxJdLrsWoPXWqfynnisOtWmbiX/Ci7W8xfpCg08+0gYdxHQ?=
 =?us-ascii?Q?xlmQCMjgiYXoV2mJLUIMNVW24iQJyQRYkN/vm5ZdHmgrnVlKUSJe5mys4NA3?=
 =?us-ascii?Q?aQ/T40v5ArJq60agVl0IEWDj/xd694Bh77x34jvwWPnbEMPVyU8DleA8nRBp?=
 =?us-ascii?Q?BQtvqx7GfLHTVo0wECgpyyiAx6cE9CuH/inR+i4R1u+EKLYSCc/v2Kdd2iYu?=
 =?us-ascii?Q?D4tmuZ1UQ1w88MNC+fpwlYfokSnDtW9x5DRp6Mex74f9hMO8nD+zHz+zsnBQ?=
 =?us-ascii?Q?stCdv78knBUXLUuIRw7Xca+5Xkb080SG1PTtWGzqiwR/fZEqur9o8wHT7+98?=
 =?us-ascii?Q?E/Ba56R8aWG0gfRmT8KECsNfFHMJehGqSavFud8vb6tDX5Xx0Pt9kWMjb2sM?=
 =?us-ascii?Q?88CaF1wcgB0pMGg9NmJAChtrV63dtbq+6Tn2+mI2QuQ8b+SOfgc8sT0+Ccu1?=
 =?us-ascii?Q?3V8V/MbGqYRVgRHNomZwjAyWp10Fodj2IpDOtEOokCg1GsV4oEKJ09Pri6sK?=
 =?us-ascii?Q?URkvps9CXejOLNZPWdb9ikKF7bc2DsDdXFg8msj39Jqkqtufw8M8qYLLCk2Y?=
 =?us-ascii?Q?oRpWtbf6YtnvttISTsj3z8Ve65LSb4QZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a4MiGIS0gOeb7T7e6oqd8haTI4DqQ9DBm9iAQmfg7vsanmUzOZgMNm3MP01p?=
 =?us-ascii?Q?2n5raamNQyGU8gzo3//prbvxTLkFQJxhYDwXhbE1TVUadmbMvQfBozx9xOmv?=
 =?us-ascii?Q?YqgbfLhhb3/f9BEeaqBdzN1E7RtRuGyDKJk/oKU9RK184VB/GzamYtdtrO1q?=
 =?us-ascii?Q?xWjb5nJ2Q+MeZG3t2wN1fSc3C6Y/PQ0dtCnXypqLpzO9XNeIxsPiuLrz5lly?=
 =?us-ascii?Q?kzxf74P4bGY1xXJGAwOucQrjxRfDluGsECXoiwyGgcuvrhfq0jnsxVuvRSel?=
 =?us-ascii?Q?NAs6bDnGufcu45yW9ZyWo6zb+OA1diHi4Pyo0mIZYqR9KgrU/khSTm2467NB?=
 =?us-ascii?Q?ByeJpUXlN2ClFoKcKHd76cutZLxTNzDYktDYU8A3ag86CfLzRbK3klY2eJ1y?=
 =?us-ascii?Q?53g8cZLYdQJyvrRJDVlrR7lTj8pGfsGcrta6PshSxHIyx/clpORtmj/rjqfU?=
 =?us-ascii?Q?4WjyQq8sQ8MX7cOlCHPodOgM/QNzUdpu+yTh9f1ah8v1OlECBdfgzu0C+aPy?=
 =?us-ascii?Q?KPITz7U5ksg427/Et76pGyui4NJpbNLodLbzaO45Eiq/3JgLFMGtmXafpXcH?=
 =?us-ascii?Q?RqSsp8J7xzbwuv33o3FC/UHQF3ZdkUTInn7F/9XjILvQVpuKK2gnVpqCquc3?=
 =?us-ascii?Q?FqOYYJO1P3mYCuIDnYUDM7x5qw3SQjpGPryK8wEJ9B5my2TJSiTIzw4LY6Mh?=
 =?us-ascii?Q?uhV6NR+77fGor6aI2VqxK5ZimPFJE7KF4gy546YGK6v+F0qLAwf4ImgtrkWw?=
 =?us-ascii?Q?9+E+1WgJ0EMx+L60aMklPf/83EsbKXHRMGBmSDtg/LLwX723e958r4CsppHt?=
 =?us-ascii?Q?wzKMGRXdah5LAmR2XZ7KNClNqX1L1YMx7/j+xy+jqxsN6ks44DIwxPITiUiP?=
 =?us-ascii?Q?2Un58F2C7TZoLxBIgwbmdYfRe3yaPuD8fjj/z13IJwarDsRrjDFY9Nk99slW?=
 =?us-ascii?Q?7yW0u41ejRQKvGAeChNQZu8dgHCA4Io1R+zuvJfWPc+muWfwyBkW7vxR2yCR?=
 =?us-ascii?Q?6oS4OEXnRCOfC6xK6xUx+/T+vqJ0eps+JN2cm0zOvB9RniI2ctYYtyB+GwPf?=
 =?us-ascii?Q?VY/QbbUuJ5e6VYYxES/M1pHfR8kDaK9lqUWIcojaPNQ+GP/xprmILyln5DO1?=
 =?us-ascii?Q?7UPSCVoNTySzF5c70/VwoKDcZHOE1wv595G6bQjs5BEYRUKHUOQxB9IJzzVC?=
 =?us-ascii?Q?TjzzKD0OJ7wW8IpBxUcYdVvIcsfdhyAaBSB+JHTHsuekhMoY3WX/Jeq1hZUh?=
 =?us-ascii?Q?t87Iv0RlXfRybPZJxlCrYKQ8jrruAyj9ChbtzpVooeOdZq44QOa/y+g+2tVQ?=
 =?us-ascii?Q?gDKltFhM1iI2ksgk7Mjs3D7g9K4OVjBM43dr1Nn6E8BvAEBl5jhUKdLCFTTi?=
 =?us-ascii?Q?12ag/SlzW/1KssvOCj/g30h0gg/WbBwIF3jhi+DFc4UYm3SfJP+bekeQztyO?=
 =?us-ascii?Q?T4FkZjeazeGU8XOEBhY/s8/kUJiPzXmg+C8cHMjWj7dLjCOvCk3uqrr50CPd?=
 =?us-ascii?Q?VoPuKYiCrvTIko4/Huql3DtLqvVucl7GXmOnpOJfi+0ZETrnm52TWZOICsBF?=
 =?us-ascii?Q?sVUcHc7/YvovFZ4sMLYVurQqMxRrJ9ArheE8NE+Zd1ONLH9MT6MIbbLxGIsb?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d92f23c7-ad7e-4d9c-f39f-08de20fb9c36
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:23:36.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkmaszBLw28eXC7a4mDB1kHNWNFRgfN/JpzzTeKW9K3qO3YTsGaWCNL10AhaeefIg+NyI33MOY2FwxGfWr8+aLC4gnixJ2n9UL5WItkQJPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8704
X-OriginatorOrg: intel.com

On Tue, Nov 04, 2025 at 11:02:54AM -0600, Terry Bowman wrote:
> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
> mapping to enable RAS logging. This initialization is currently missing and
> must be added for CXL RPs and DSPs.
> 
> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
> 
> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
> created and added to the EP port.
> 
> Make a call to cxl_port_setup_regs() in cxl_port_add(). This will probe the
> Upstream Port's CXL capabilities' physical location to be used in mapping
> the RAS registers.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>


Terry,

This patch needed some cxl-test support:

Attaching what is needed to 'Make cxl_*_init_ras_reporting() work
with cxl-test"

It adds a mock version of cxl_uport_init_ras_reporting(), simply
following what existed for cxl_dport_init_ras_reporting().

The other changes apply a method that avoids circular dependencies
that the above patch introduced: cxl_mock->cxl_core->cxl_mock.
This method is a Dan invention that DaveJ first applied it here:
d96eb90d9ca6 ("cxl/test: Add mock version of devm_cxl_add_dport_by_dev()")

In my tree, I inserted and tested this after this patch I'm replying
to, but I think you'll need to combine them, or split some other way
so no patch introduces breakage.

--Alison


Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/port.c              |  4 ++--
 drivers/cxl/core/ras.c               | 12 ++++++------
 drivers/cxl/cxl.h                    |  5 +++++
 drivers/cxl/cxlpci.h                 |  6 ++++--
 drivers/cxl/mem.c                    |  2 +-
 tools/testing/cxl/Kbuild             |  1 -
 tools/testing/cxl/cxl_core_exports.c | 19 +++++++++++++++++++
 tools/testing/cxl/exports.h          |  8 ++++++++
 tools/testing/cxl/test/mock.c        | 25 +++++++++++++++++++++++--
 9 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 48f6a1492544..f0fc917f9575 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1195,7 +1195,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		}
 		port->component_reg_phys = CXL_RESOURCE_NONE;
 		if (!is_cxl_endpoint(port) && dev_is_pci(port->uport_dev))
-			cxl_uport_init_ras_reporting(port, &port->dev);
+			__cxl_uport_init_ras_reporting(port, &port->dev);
 	}
 
 	get_device(dport_dev);
@@ -1625,7 +1625,7 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 
 	cxl_switch_parse_cdat(new_dport);
 
-	cxl_dport_init_ras_reporting(new_dport, &port->dev);
+	__cxl_dport_init_ras_reporting(new_dport, &port->dev);
 
 	if (ida_is_empty(&port->decoder_ida)) {
 		rc = devm_cxl_switch_port_decoders_setup(port);
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 19d9ffe885bf..90bfb32cc3c5 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -141,11 +141,12 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 }
 
 /**
- * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
+ * __cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
  * @host: host device for devm operations
  */
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+void __cxl_dport_init_ras_reporting(struct cxl_dport *dport,
+				    struct device *host)
 {
 	dport->reg_map.host = host;
 	cxl_dport_map_ras(dport);
@@ -160,10 +161,9 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 		cxl_disable_rch_root_ints(dport);
 	}
 }
-EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
+EXPORT_SYMBOL_NS_GPL(__cxl_dport_init_ras_reporting, "CXL");
 
-void cxl_uport_init_ras_reporting(struct cxl_port *port,
-				  struct device *host)
+void __cxl_uport_init_ras_reporting(struct cxl_port *port, struct device *host)
 {
 	struct cxl_register_map *map = &port->reg_map;
 
@@ -172,7 +172,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port,
 				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
 }
-EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
+EXPORT_SYMBOL_NS_GPL(__cxl_uport_init_ras_reporting, "CXL");
 
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b7654d40dc9e..995e20a88d96 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -940,6 +940,11 @@ u16 cxl_gpf_get_dvsec(struct device *dev);
 #define DECLARE_TESTABLE(x) __##x
 #define devm_cxl_add_dport_by_dev DECLARE_TESTABLE(devm_cxl_add_dport_by_dev)
 #define devm_cxl_switch_port_decoders_setup DECLARE_TESTABLE(devm_cxl_switch_port_decoders_setup)
+#define cxl_dport_init_ras_reporting \
+	DECLARE_TESTABLE(cxl_dport_init_ras_reporting)
+#define cxl_uport_init_ras_reporting \
+	DECLARE_TESTABLE(cxl_uport_init_ras_reporting)
+
 #endif
 
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index a0a491e7b5b9..846cf0935252 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -82,9 +82,11 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+void __cxl_dport_init_ras_reporting(struct cxl_dport *dport,
+				    struct device *host);
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
-void cxl_uport_init_ras_reporting(struct cxl_port *port,
-				  struct device *host);
+void __cxl_uport_init_ras_reporting(struct cxl_port *port, struct device *host);
+void cxl_uport_init_ras_reporting(struct cxl_port *port, struct device *host);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d2155f45240d..782fdb552865 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -167,7 +167,7 @@ static int cxl_mem_probe(struct device *dev)
 		endpoint_parent = &parent_port->dev;
 
 	if (dport->rch)
-		cxl_dport_init_ras_reporting(dport, dev);
+		__cxl_dport_init_ras_reporting(dport, dev);
 
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6905f8e710ab..fe80a811fdef 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -9,7 +9,6 @@ ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=devm_cxl_add_rch_dport
 ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
-ldflags-y += --wrap=cxl_dport_init_ras_reporting
 ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
 
 DRIVERS := ../../../drivers
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index 6754de35598d..5a071afa46fd 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -3,6 +3,7 @@
 
 #include "cxl.h"
 #include "exports.h"
+#include "cxlpci.h"
 
 /* Exporting of cxl_core symbols that are only used by cxl_test */
 EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
@@ -27,3 +28,21 @@ int devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 	return _devm_cxl_switch_port_decoders_setup(port);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_switch_port_decoders_setup, "CXL");
+
+cxl_dport_init_ras_reporting_fn _cxl_dport_init_ras_reporting =
+	__cxl_dport_init_ras_reporting;
+EXPORT_SYMBOL_NS_GPL(_cxl_dport_init_ras_reporting, "CXL");
+
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+{
+	return _cxl_dport_init_ras_reporting(dport, host);
+}
+
+cxl_uport_init_ras_reporting_fn _cxl_uport_init_ras_reporting =
+	__cxl_uport_init_ras_reporting;
+EXPORT_SYMBOL_NS_GPL(_cxl_uport_init_ras_reporting, "CXL");
+
+void cxl_uport_init_ras_reporting(struct cxl_port *port, struct device *host)
+{
+	return _cxl_uport_init_ras_reporting(port, host);
+}
diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
index 7ebee7c0bd67..f3bcba8bc11b 100644
--- a/tools/testing/cxl/exports.h
+++ b/tools/testing/cxl/exports.h
@@ -10,4 +10,12 @@ extern cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev;
 typedef int(*cxl_switch_decoders_setup_fn)(struct cxl_port *port);
 extern cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup;
 
+typedef void (*cxl_dport_init_ras_reporting_fn)(struct cxl_dport *dport,
+						struct device *host);
+extern cxl_dport_init_ras_reporting_fn _cxl_dport_init_ras_reporting;
+
+typedef void (*cxl_uport_init_ras_reporting_fn)(struct cxl_port *port,
+						struct device *host);
+extern cxl_uport_init_ras_reporting_fn _cxl_uport_init_ras_reporting;
+
 #endif
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 995269a75cbd..776b951aab1a 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -18,6 +18,10 @@ static struct cxl_dport *
 redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
 				   struct device *dport_dev);
 static int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
+static void redirect_cxl_dport_init_ras_reporting(struct cxl_dport *dport,
+						  struct device *host);
+static void redirect_cxl_uport_init_ras_reporting(struct cxl_port *port,
+						  struct device *host);
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
@@ -25,6 +29,8 @@ void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 	_devm_cxl_add_dport_by_dev = redirect_devm_cxl_add_dport_by_dev;
 	_devm_cxl_switch_port_decoders_setup =
 		redirect_devm_cxl_switch_port_decoders_setup;
+	_cxl_dport_init_ras_reporting = redirect_cxl_dport_init_ras_reporting;
+	_cxl_uport_init_ras_reporting = redirect_cxl_uport_init_ras_reporting;
 }
 EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
 
@@ -35,6 +41,9 @@ void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
 	_devm_cxl_switch_port_decoders_setup =
 		__devm_cxl_switch_port_decoders_setup;
 	_devm_cxl_add_dport_by_dev = __devm_cxl_add_dport_by_dev;
+	_cxl_dport_init_ras_reporting = __cxl_dport_init_ras_reporting;
+	_cxl_uport_init_ras_reporting = __cxl_uport_init_ras_reporting;
+
 	list_del_rcu(&ops->list);
 	synchronize_srcu(&cxl_mock_srcu);
 }
@@ -257,7 +266,8 @@ void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_endpoint_parse_cdat, "CXL");
 
-void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+void redirect_cxl_dport_init_ras_reporting(struct cxl_dport *dport,
+					   struct device *host)
 {
 	int index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
@@ -267,7 +277,18 @@ void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device
 
 	put_cxl_mock_ops(index);
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
+
+void redirect_cxl_uport_init_ras_reporting(struct cxl_port *port,
+					   struct device *host)
+{
+	int index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (!ops || !ops->is_mock_port(port->uport_dev))
+		cxl_uport_init_ras_reporting(port, host);
+
+	put_cxl_mock_ops(index);
+}
 
 struct cxl_dport *redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
 						     struct device *dport_dev)
-- 
2.37.3


