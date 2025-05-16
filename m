Return-Path: <linux-pci+bounces-27829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71256AB95A0
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257347AFC47
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3630C1F463F;
	Fri, 16 May 2025 05:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6iIYSYO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441421C9F1
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374501; cv=fail; b=caLV6JnDub7S4MFp6k1udU95EX2yyhv5iG9lRB9lLAifEqv89PFuCPiL0nDXBFL+0moTxHMhx7JE7YfOjslXHOU6poQne9hPjfMQhI1RCYw9YNU3gEQWkSQGH91HkBivaoDTsq15j3qHWckzt3bOf3PL3m/rFYDsfFIi6cpRfu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374501; c=relaxed/simple;
	bh=tp2yQ2bdQpifCYF1apYL3Q5jQvWLdN8M4iOczfpNZ7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TnZGjDdj4DY2aQz8H4vE83FZ9kOcYQHp67VBn+DeTlgrVXrhKTSSbKocsUOkXykXRBiNZ38YI9NLJ/4gBGhBdu3/bv3Ur18YYFdQzRaQCX62tjQC6A9Tzad2+jAlUYBB9CORTaE6LhZWIbn28S8zmtJyLjYB5orkVplVDCUuCrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6iIYSYO; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374499; x=1778910499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tp2yQ2bdQpifCYF1apYL3Q5jQvWLdN8M4iOczfpNZ7M=;
  b=a6iIYSYOE2Oiq1Z3p3dr/ioQOVBygi0NSv3etiDCdPnl3oOjaTCxa9ON
   qL5sIrWROvskDA9fA4rKZRmAKDrlLwscQjrS0rYCmCa3mhBeworvtUDPG
   m7jLKzRjRvZmnFAe8kwE8dZfrzYvshbPprXGIrtyGmPam3qRreobwnwcm
   XI9DkeKLeinnuuyAPSBqNKMkx5YhDEe1Fc9B8RuBMY947fnFnufccNUgz
   KgT045UK4aKpegrUuF6AdD7ld8SgKlfzWmez23tU5IjpS/yyQfzvFUDyS
   Kwqr+UfpEAj+/zmaHwvsbjl7isJUVdidAdQGOh5ghH8866DfVI9DMpcMh
   Q==;
X-CSE-ConnectionGUID: wn/W2jJ3QvCzMcBxCIxj6Q==
X-CSE-MsgGUID: sPAiOuy+SnSGwMPwpwSsPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="66884863"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="66884863"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:48:18 -0700
X-CSE-ConnectionGUID: aIHXdDnbTpK2b91bAs5Qhw==
X-CSE-MsgGUID: TPAyoMS5SfCDog3Qqxe2iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143709029"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:48:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:48:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:48:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:48:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUXL8I2jAwKl83eWU8AvtUb2p0SYH5uhsFdlihGIRrxEq/ykCYW5ygwQO6fzN9YYTJEw12MTOYqpMWqBUKT0BKori9Ett/EHjiq8EKnnQdwK+M6pWEZa12yclpV3MuPCPrvbbYOoVHe+hq4pFJc+0RzZgIx9gZiO/cswSX3CGh9xS78Zq2GPj2JYZSJfxPMVCSY9sfoTy99VRYJw1ZtAIEmLQIRwX+CtDIOt8/MHUv4k4NYvQXbADF8XuOA9lGP/1GITfJjZLc8d2mhvwk0yctDrcBiIPgstiMFcO+kw+cX9GSro+BUTS9cXaCzFvUIiT+V2N6rX3fOTcXIXKTcaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkU4byCBme4rwkZJxhCMSSIuTaDknvgpZ5qzZW1B6R0=;
 b=mjLcaEafSP7cuocB+MlrSveRarTjeJdaz1Nz1FoLNVsT2J0fNUzwZQcVnGMzSiHXlysOnQgTLGWYeG6WOc3FLGZmL64Ir6U/8wDGYmKdPRND5vx4XfgkDl4Gic43B3+Fc+InX53FMRYzhjDVdqqOPR/TYB3D1FW4jYrSF4o/W1f1rTOf50bO6HxjYKihR0P51R5Kbk8UhoJOrlW2Kqr+fdE7mgedkQ8Lmh6pyD6xc6u8/UaZMa2a92rn+6OQ/j2WQjBfNLkJDqx4P0CKaYy0ifi9Del2SSGFmbxiG79I0SQ7n5Gqb20I+CALggC2PyjTXuIA0LDie7f+4gvc342nEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 05:47:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:46 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v3 09/13] PCI/IDE: Report available IDE streams
Date: Thu, 15 May 2025 22:47:28 -0700
Message-ID: <20250516054732.2055093-10-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516054732.2055093-1-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: 615651e7-45a3-4b6d-997e-08dd943d2f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yFP2NvKNQvDBUfUDvp/Zqo7Tl0ncwGvXeH4NC3W/w1CJFHBhZg9j6720EO1I?=
 =?us-ascii?Q?6foQBaTvqSXr3KlmdmXHZp4dUe6wI+y2S+mJEwVW0pDSLqJrghPqFEiEd3AR?=
 =?us-ascii?Q?B2R+1xKJAmAbS2q5lhKbGWZ0OvOyjZeKhYZDnsB3e4yZh6s7BkGJhzotGKfA?=
 =?us-ascii?Q?U7Nr8sJ2Z1spGRoB7a7SurPnLhI7OABkRCVvvXqL4ei8gVN841azONvd7Az8?=
 =?us-ascii?Q?JCpeUw3pkXjVpyffdXryj7eXgsgDifqFP+2c7F3TXBh2zfvp1z3mZEga7BSo?=
 =?us-ascii?Q?X8otvgSzNGCupRPw5tW2hTkrtmI42tXSEC9+PlUmjkq3Z0HML1RB45rl6uau?=
 =?us-ascii?Q?Adz8FcYuDn+gNz0oSIE/h3PUOO6JRN8LgWiH8ttgcaceVuMmzWJacMKSujjN?=
 =?us-ascii?Q?vt7YklVigToaPL1/vqCpenRhSQ7+JojL3LxKVEyz0MMigCPBCBG0RArvarea?=
 =?us-ascii?Q?HasUZCp3D+vehpPg2jTljmbGGyJnlmKGWbazrVRR6dFg7p+iueduVA0kwnvG?=
 =?us-ascii?Q?1i7+c+VlsVDd77uwOSCd0mWKNg6o3uZxUPf338u7bRQwqba3PPRBufZnZskN?=
 =?us-ascii?Q?KVxAWSqtoeo+vYeez4GH4Qhw6rSIrjdKOHVQd7S5josW/ox98T+9XB6Mvg0r?=
 =?us-ascii?Q?FRw1tItrE0wq4EE/Evkhj+RokTxitEyIakFf/R3Q0uh61MkbQT72aWLj3Cb2?=
 =?us-ascii?Q?ka9RgH76kxprHQgHPQ3uhIESMPXDTW+KQTlkei1Ro/tsID++h2c+9snkxZED?=
 =?us-ascii?Q?wGoxFNrgL7Yy/NHHzc81CD4UIBw91LZO52nFAqWqDDu35E7Dlm3hRr6b6rg2?=
 =?us-ascii?Q?BsvjHx+mmM71Usw7mj4fR9HL4LI6zON7NuksmpCa4bq4AE2b5pCoEs5ScWlU?=
 =?us-ascii?Q?0OU7QY38VELuOkBucAZWFOLJwXKswtydsFqc6mFB6dDuNHEenVC8vxVA5i02?=
 =?us-ascii?Q?KdDPoyux3PBoixPceQZkRmVHcbh3XjFTl6bTpvwZyiMjRWp23iqvgukEOPJT?=
 =?us-ascii?Q?yo9i1geyW2LGAw06jbkbOF3GmFtRrrNqeybYSGsuVbMwCJboDfU4B45U9RoT?=
 =?us-ascii?Q?aNfMiDw819MKrULTjSZ2lP1JNzljPHlv1yfkchZk0DqocpFnBQ0epvrrBo74?=
 =?us-ascii?Q?QePhhJIMSnDODY88wV863PjBmYTCzM0g06e05x71XSwF+b2rqQX9g8dJv6LK?=
 =?us-ascii?Q?tDYPkUJ1E2JGcJTUSgQDELvvQNp7fb2fXebqpFzmz4+sQ/3joVTf1e/Glprd?=
 =?us-ascii?Q?3gTa23FRx5Ps5CRRfg2TI2+fUdF+A/zvPWT2IMmFlVSBVaZXzb04q0PPxMSa?=
 =?us-ascii?Q?pGuDaZR04q49/7WKvRIQ0gKdxoP2jpcs7LLkIzhkba3rEuXtR4M2uTkHrWTo?=
 =?us-ascii?Q?cbmkfPabZEJ0dtrD7DJDOdpFrtvOF6yPVEYDxhDitxFQV1inXPnwb+/ffo1f?=
 =?us-ascii?Q?MuZjVKWukjk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cNWhze4xs6SWgDVwMuDEdBF6v5k67Zpo79u1jxwNbbZ5fLLr6osGIVS9xq80?=
 =?us-ascii?Q?gSmp9Y+R7pxqPFmQtOokpWGrr1or2IxFWBf5EaRxWg9bZsNOU3Dmf75oU4lO?=
 =?us-ascii?Q?gEHEUHIFJESXWy+yPc0zSQotdc6N6TNQqeqx/j0eAR1wMQ/yhjBkdZdlWvyc?=
 =?us-ascii?Q?ODgazuCGEq4obHyVkzlKxVIBAaM9FyXVbsF6CjGPu+/adN7/XKWJYyXq7FXI?=
 =?us-ascii?Q?9z+V1fPMK2czf3o867GFe24LlQDsdiIYUr1M1lEvOGLGqsUEBV6P1FSxrbMP?=
 =?us-ascii?Q?MTVFAmQUmShL7IrtUJx92Xs9OOTbY4v6tkqnmqTWe61Cag8/tciai9AIh8GG?=
 =?us-ascii?Q?wus+veJ63L7TZY4LXHEl9i9clmrpw4ITMPmWh/s8BdLr2Ii9c/vd4BHdgNEN?=
 =?us-ascii?Q?ruoCm2vi3qcqsKfwG265aiVnGXzwZN2RU4OalNgcu5JzS5bIuhAww9QobcF5?=
 =?us-ascii?Q?Ifd4Ayl2caTLYnXYNZOBVbbO0USvsuaXq134FrrT3gVUKv9DxNryaLZGRda0?=
 =?us-ascii?Q?omrDSgT2CxxQ078icPe4e3ttnFP/zjc0B+e0AGakr9uwlpWLXh70hhe8NS9C?=
 =?us-ascii?Q?Ag9wgNRQtiOELDSzsjWahXkMAsDU03UesOoJQbsqNSpcuLE4muvaFfT3bwhL?=
 =?us-ascii?Q?T6HRgT/Nl6ygffM4bDBFQB4rkpSyJqDDzm9oXXnGBoxEld9QYrFSX7HOzFOL?=
 =?us-ascii?Q?9EHep8ztVpfIMbuc0n8FMaIHzrNIlp+sqWPhG2FP5yieFLgZt5ATh2r3NpCO?=
 =?us-ascii?Q?ijCOfDrwYyaenIlbXMiQYW2P4q9zDjY4LFmXUsES75a6urHTMtteLScB47NM?=
 =?us-ascii?Q?+Sgue38HliQYTuYVKzl+Dbwnyjbt6ke8m/t1LBcEPMF8PdtAFfznay9Cl6iP?=
 =?us-ascii?Q?wKABHUh6y3643ByYUF1u2wHeBoXqt9DFFBhYeqkac2gnr0yjnTqTpHp3HlWE?=
 =?us-ascii?Q?T31nZdKDAWoYslyfxfRDbLxF3BthhiKx85VuDmI0fjyy2RdqW5dADnnXXiUI?=
 =?us-ascii?Q?fEte9ES9B51UzH562jzkO3x4eQW5Oz7Ej8ZoY7/5i6XKKZHS6NY5gHOLwNb/?=
 =?us-ascii?Q?ydMltA5Zo07C5GT3Mvu4T+vHVT41Elmj+3VeTPCJDd87TxP+HlwRYaJM60Sh?=
 =?us-ascii?Q?O9QUpP7WGZ1qaJJot4r3jVsRmiYzEFKKn2aeqzEFDOjVcQtJejfv/OEeLwYv?=
 =?us-ascii?Q?X99JD9XHcmEhGHfDxkckK6v2//ClLero47kBRIaXLMhVg5Rxp1lNrWaihcGu?=
 =?us-ascii?Q?nu94c4GMrPcXLvpRIGBAMihnBVL4mzhe49lORkSYFSqY0u5Y+lYTDt8ldeYp?=
 =?us-ascii?Q?1tiikCVfMrn5xBadqAmWD4+CnyPhlyCvsQewEB7HYugVxAWBGZZWmFU4C5S3?=
 =?us-ascii?Q?p/E4QnTCkdBzY8fQPL1KvPzHSm3WQptIMdCC6q9u39z5aQOHEzK8/uKd9cq7?=
 =?us-ascii?Q?JafigqQWO/+9OsvvHRgR1vOLfbdshRWEL/8Fz+9tVLqD/OKci5s0vfCBzJJR?=
 =?us-ascii?Q?+mnrM+JiOSFmt1YY+szuPB5JB1zQkFSxT20+VMyhY0G4yS4gS7c1Rm3Q9OTJ?=
 =?us-ascii?Q?R1L0ORUfD8U4/qx01AJ6w6gqCnuc/nD2M7VwqO6S4rtS8OfPgEcWfT1NPcZd?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 615651e7-45a3-4b6d-997e-08dd943d2f33
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:46.4059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JC2y1sGCFweWcNWme+kAg4ckcnxU6sYLJZTOyfeG7IS4+H4J6hF57tc/RpFo7GBvkMoVehZNBE8o6kbPiW9JB5f8sQM2NkGiTwAJ1/P4rvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com

The limited number of link-encryption (IDE) streams that a given set of
host bridges supports is a platform specific detail. Provide
pci_ide_init_nr_streams() as a generic facility for either platform TSM
drivers, or PCI core native IDE, to report the number available streams.
After invoking pci_ide_init_nr_streams() an "available_secure_streams"
attribute appears in PCI host bridge sysfs to convey that count.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge | 13 ++++
 drivers/pci/ide.c                             | 59 +++++++++++++++++++
 drivers/pci/pci.h                             |  3 +
 drivers/pci/probe.c                           | 12 +++-
 include/linux/pci.h                           |  8 +++
 5 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
index d592b68c7333..382866a21703 100644
--- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -36,3 +36,16 @@ Description:
 		stream resources shared by the Root Ports in a host bridge.  See
 		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
 		format.
+
+What:		pciDDDD:BB/available_secure_streams
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host bridge has Root Ports that support PCIe IDE
+		(link encryption and integrity protection) there may be a
+		limited number of streams that can be used for establishing new
+		secure links. This attribute decrements upon secure link setup,
+		and increments upon secure link teardown. The in-use stream
+		count is determined by counting stream symlinks.  See
+		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
+		format.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index a529926647f4..b7561ac03405 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -464,3 +464,62 @@ void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
+
+static ssize_t available_secure_streams_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
+	int avail;
+
+	if (hb->nr_ide_streams < 0)
+		return -ENXIO;
+
+	avail = hb->nr_ide_streams -
+		bitmap_weight(hb->ide_stream_map, hb->nr_ide_streams);
+	return sysfs_emit(buf, "%d\n", avail);
+}
+static DEVICE_ATTR_RO(available_secure_streams);
+
+static struct attribute *pci_ide_attrs[] = {
+	&dev_attr_available_secure_streams.attr,
+	NULL,
+};
+
+static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
+
+	if (a == &dev_attr_available_secure_streams.attr)
+		if (hb->nr_ide_streams < 0)
+			return 0;
+
+	return a->mode;
+}
+
+struct attribute_group pci_ide_attr_group = {
+	.attrs = pci_ide_attrs,
+	.is_visible = pci_ide_attr_visible,
+};
+
+/**
+ * pci_ide_init_nr_streams() - sets size of the pool of IDE Stream resources
+ * @hb: host bridge boundary for the stream pool
+ * @nr: number of streams
+ *
+ * Platform PCI init and/or expert test module use only. Enable IDE
+ * Stream establishment by setting the number of stream resources
+ * available at the host bridge. Platform init code must set this before
+ * the first pci_ide_stream_alloc() call.
+ *
+ * The "PCI_IDE" symbol namespace is required because this is typically
+ * a detail that is settled in early PCI init. I.e. this export is not
+ * for endpoint drivers.
+ */
+void pci_ide_init_nr_streams(struct pci_host_bridge *hb, int nr)
+{
+	hb->nr_ide_streams = nr;
+	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
+}
+EXPORT_SYMBOL_NS_GPL(pci_ide_init_nr_streams, "PCI_IDE");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7f763441f658..3e556e4ad9b9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -513,8 +513,11 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
+extern struct attribute_group pci_ide_attr_group;
+#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
+#define PCI_IDE_ATTR_GROUP NULL
 #endif
 
 #ifdef CONFIG_PCI_TSM
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 56704e851224..93be55321537 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -640,6 +640,16 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
+static const struct attribute_group *pci_host_bridge_groups[] = {
+	PCI_IDE_ATTR_GROUP,
+	NULL,
+};
+
+static const struct device_type pci_host_bridge_type = {
+	.groups = pci_host_bridge_groups,
+	.release = pci_release_host_bridge_dev,
+};
+
 static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
 	INIT_LIST_HEAD(&bridge->windows);
@@ -659,6 +669,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_dpc = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
+	bridge->dev.type = &pci_host_bridge_type;
 
 	device_initialize(&bridge->dev);
 }
@@ -672,7 +683,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	pci_init_host_bridge(bridge);
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1c901904ee4..5f37957da18f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -662,6 +662,14 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data);
 
+#ifdef CONFIG_PCI_IDE
+void pci_ide_init_nr_streams(struct pci_host_bridge *hb, int nr);
+#else
+static inline void pci_ide_init_nr_streams(struct pci_host_bridge *hb, int nr)
+{
+}
+#endif
+
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
 
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
-- 
2.49.0


