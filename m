Return-Path: <linux-pci+bounces-29627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A2BAD8162
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430081899D0B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 03:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD0B24DCFC;
	Fri, 13 Jun 2025 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlwXMK0+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10424886F
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784014; cv=fail; b=giuchPRCNMfzUIV89V0WnXzUl25SNC2qFA7RUYunCY2S0qVTIpuPnFJ9FDOzBM9lQalkn0BcuSj0TgnJxLkAyoU1XvYuDpfyfpE19yS2TI4AI+d1yWfNXblms1TgQIbTlyO2tswHP86/CVQY8geOlVOpAvMujddX8SZ5PCFdNIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784014; c=relaxed/simple;
	bh=yP3epcPI1RhL46REoAyazFnbfEyJsXP3Ii0Ui+dyv40=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bkviEvVMbvvC0HTyoc+VVOP6wddA52dua1pZn3edcR3ONPgxbq/e6vaJPGOdDWimyvUgeoLF5+nRC5BxRkO137pqApup5q9Tl6p1EyNNPvdMygIMz6y36VWaa4UXjLUZp3vJ57i5vH+56N5VjXHW0lul6tzmvkH95hue7KKpGOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlwXMK0+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749784012; x=1781320012;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yP3epcPI1RhL46REoAyazFnbfEyJsXP3Ii0Ui+dyv40=;
  b=LlwXMK0+dSKmNZRxqFmmIgD4yddhXZZcsYtnJTvkEYpfFMtDrLvxR0po
   HMkKSPlTJFnQlg5mviH2NRok8YOToJ1FZ5hFghPa5uC6iEiBVnwLoetNF
   D7WCqFm2k5JJ95GcUdvevkVIgj/8fVe6D0yIPjcbM+k5mLQUFqe4bRV51
   /la2OeVoBdaDNBv9sTFlvKE+sULZgY52pYCx9izhSfhVHp79fKG24VpBa
   +R9f587x9gNAeukubjGPSSBdksFRRru3rlS4cgLYIZ7AoGkAOtwqcLFE5
   1nbYmN6EHwA1i04JhV0WTwozkJulE4xtr+PTcYOuBfKfkj9ugtqmru4vO
   g==;
X-CSE-ConnectionGUID: VG9xpJvCRIah39H75KhFOA==
X-CSE-MsgGUID: Y37VYglKQcSwFLs/Z0Hxhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52135988"
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; 
   d="scan'208";a="52135988"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 20:06:52 -0700
X-CSE-ConnectionGUID: cvi4EpgjQz+7JLjV77HECA==
X-CSE-MsgGUID: Dpj6aPxnTECjm2Dk8YVwpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; 
   d="scan'208";a="151529015"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 20:06:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 20:06:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 20:06:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.59)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 20:06:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Td3SksIQsH9pqZYMe7gjnlP4uNKE1hV5IY1OW6anwHJSz3IpqsA3+GqIXVWeTd13Sj2oa1AqrzucOcd52r9oxlXfnR5QZFq624AHAZYrlnRtY1iiiABbojfGXtoy2uWZidUCtL4phLb+J/gHawf6jcEAUM07J7rci34QjIx1FBU6nzMqd4/Kb55wmuvhlorDHIJDr0xHiHW2RughGcoERyadj3g26QmDUIKNwUwMecL4KdZaGIVmY113X2EMdbWUx1gL3dhCm6uzHtBptMzPFXRlrs80Xle7OKpieXhdS/PPBfvih0+zCCOj8HfinlRY4wsocvOcegmNFLzJe3i52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/z8dKgwZWgMEgYhiM+h6/rLxBh+GuZdVmpGY7biNL4=;
 b=V99xc8nR1IBBGKVWmCHaM3MUQEO1CwLUXHWt3K/i1AisRieDFS7vxNxklqBc5EbFcIwzcGqDlCz5jskUZm4tCPQq3O4qd9oWuwHRgG/xBuqYSNrVQ9bsRX7SrYzwiGZhesIM60WHJ+NXkjYgXypXdlw4u773LVQC+uDsEEp6fkeGeczohWTD7pcSDMnN1DV4OpYzEDBG3j3jJWDA+VI4D+n+XWW9ziX3cIKSvRVuzMCd1dw5oB3jwN96/B8aWFI1gVturSsdAiaUr3giCEM+y8HLW5VBjDXD+iwbbfxkOuS4LFL1C+abcGTUy5/6lLp+8I05V+zg/xZNYDU0RVnHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8113.namprd11.prod.outlook.com (2603:10b6:8:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 03:06:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 03:06:34 +0000
Date: Thu, 12 Jun 2025 20:06:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <684b95b6cfe92_2491100d4@dwillia2-xfh.jf.intel.com.notmuch>
References: <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <5d8483bb-ceb7-4ef3-920c-d6286a7de85d@arm.com>
 <683f7b6fec30f_1626e100ab@dwillia2-xfh.jf.intel.com.notmuch>
 <53c7523b-5cf3-4047-831f-12e0422cdf5d@amd.com>
 <683fa6f622abb_1626e100e0@dwillia2-xfh.jf.intel.com.notmuch>
 <683fa76214ebf_1626e100e1@dwillia2-xfh.jf.intel.com.notmuch>
 <60812b1e-d01b-40ef-9e59-c6ab970e17e2@amd.com>
 <68439c325a714_2491100f2@dwillia2-xfh.jf.intel.com.notmuch>
 <dcd28de4-010d-4919-8db0-64e807726ad1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dcd28de4-010d-4919-8db0-64e807726ad1@amd.com>
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8bb9a5-5ebb-4176-9abf-08ddaa274d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Ihmdsx7HoLN8mC2zjOUAtrjjgB7UFSDcE0yta0OglI5Ue+71YC2J6U43eou?=
 =?us-ascii?Q?ln8mQZVTJPAlXggea8CHovXWtateEE86NXm1Yo44t7DRSzhDLw4TYYW39L0Y?=
 =?us-ascii?Q?k8JdiSsuGi3z8rkwK/UEJUQNsQA3OmPXCOFbhAgrpT2fXuqolhoA6v+BM90+?=
 =?us-ascii?Q?aB9pM4wSpODCB2z0dC6E/lroB32FijKjlE9mK4jP+F9U/YfHtVoxuA+vcWfY?=
 =?us-ascii?Q?D0J3RPe9eWCikMppoUfS6Sox9MrufTBqYV3vwhxVwcoHj3p17mM1hxPslSqj?=
 =?us-ascii?Q?JRrIjCQ09Pn0R1iBiprOkVoca7Rbtcrt40PUiwtZtN8nK9FY4e5TYMjJHqGC?=
 =?us-ascii?Q?nVJHjHdatz6P+5TJ7u3ncb3hSBsIt+Fu38j/GFyFoVb0F3QcNXizciTxF4Nf?=
 =?us-ascii?Q?VV3QyuWdUeBdLkPtQYUOa3+gC9CTgsZ544i2dubkdkO5vaDJyAuLTnSfVNlc?=
 =?us-ascii?Q?tm2Jb84PT34RDay9bXva5hSr1lnTCJxXyXxD/eKZ2/AJ/xISZk/OBhI/BWj3?=
 =?us-ascii?Q?w37fKXMpCF8J0yZyD0BWUGiCe/dtV/ENs3FL/Ou+bVu3bbzUKXBmlD+EX3eN?=
 =?us-ascii?Q?9XgRrSvjWA9U5swSW1X316anvJIj3fZKCaezw1Mm5zEGe2VJjmL4PSm+0Jkz?=
 =?us-ascii?Q?3G4ZSJvjCnSOZvXDR0zAj1cvo3UmV61NjzCQcpLP23ScKgfD2GMq484nCY/F?=
 =?us-ascii?Q?ygNHU6NZ5/Mh0fmeTNZ5x6y2edR9VsfO2Ih9Dg88Y9yjLLHgR9QX+L6cnOPe?=
 =?us-ascii?Q?hjMOCt3H3W8DFnEO8/b7SZjkxaLiXMxIWb756mOGNwmd29QuGTjDEzhf0QJz?=
 =?us-ascii?Q?kWkbkORVpoEd5/gY7dwT84npEJJ7v02dXs8/L1ZkLMXqpxMSaF3s1db26zF0?=
 =?us-ascii?Q?bf1Gu6FIeD/554LvP1zLFsgs0Ru7KKFRHDvpfR97ExxUBJ6ngsldNc+TiUGZ?=
 =?us-ascii?Q?qbqum8EIUcar9BqmBUWEkB391qbXtPyZNfeyzFGHSanN48TiIkezB25fdXvT?=
 =?us-ascii?Q?lDlgGJGUN14aC3l8zPTYxzcUbBZ3UPblIsYKP7DOpvCJrSJgo1nrsIObiSOJ?=
 =?us-ascii?Q?IONZtbJunQNnmica8/3+JyE3c9e9gYrL4K09B+WqjU8VZ3ZAO4hHEI0VFv5l?=
 =?us-ascii?Q?BcahHl0uf0BZAVsUQpAt/69BRbEcaVw0roux5OFKd8e6U/N3dG66qdxedzO+?=
 =?us-ascii?Q?aAo9ZqRPcw7xVjh52t3CDFOqQfcN2VHtd+F3VL6qaPhePx/rPoij4/RQRqVI?=
 =?us-ascii?Q?mQysaqqZzM8a7TnvCOa87ZWR0PB4INkrL1xr6in+LVPFyHgUQMg/OY6aot0M?=
 =?us-ascii?Q?iTkSVa+CXvXiIied9McPdW4P/O3bs8b2u+WHObZvUQlORiaJ2tpsOAHnQV8r?=
 =?us-ascii?Q?tfH1GmiTQKqWkGEkSoyL7ZpZMUHMoTKAI8CUr9FMymhJ3LnmNALRqvt/2Z4Z?=
 =?us-ascii?Q?5eBp6pgM8Y0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ON3pwUFI4/HdTcWRXK6eGGKxcHy8lK4EoqalXOdNXcXqwu+YBKvDG8Ms4f6?=
 =?us-ascii?Q?XYRf4Siog03twwCDcyN+5EsFnf6hCbHQMP2YUmjLqbEU9yreO3p+357L0SF5?=
 =?us-ascii?Q?pkXtEbBG5YoBsRcCyFKPkOgKsqHFRAnYgJh/UEH1jDRxs7uIGddj0/PCMyX4?=
 =?us-ascii?Q?OxqsXSqVydyBT7AUlcdOisf4jQHoH1A5OhuQNBSPGr64xTorqA1k15kAR+Ur?=
 =?us-ascii?Q?F+Y3Mqn/iDWLxfoNDXCSPdhovIsyeyxKOEAS5naiSA+oAn1oL+TnajPiByiN?=
 =?us-ascii?Q?KUKCX/bzOimtPqF7wC8rQZErNVteUnsZpdLt2OS0sTINNSeuNbFRo73+zXlO?=
 =?us-ascii?Q?cic9MKP6RFnVlwvL6vi+/OPk76TE0GJSndBAdfLzkINup7EzVxjoI+W0yJ6H?=
 =?us-ascii?Q?DtTrLl9yzISNvoYXXjqEBK2GqvvTqFnFKsscbC1ydULdojKGByTwkNGU/2d0?=
 =?us-ascii?Q?zah58egpuyvtDofYeStpKp0Y448aS0zDLurvix5lkV7ha8OMGzvSGH81kL4N?=
 =?us-ascii?Q?7p1+57T++ZcDqwF6HDwk9kOMPnFHPBGboln55/j3PJtm8nCMtNcnxjlZ0qbG?=
 =?us-ascii?Q?TGlyRRkLPrp18ckHSfC835mnyN6BbjavnkjBm6P/xWsAMx+n2OurUmRMFkyP?=
 =?us-ascii?Q?R+3iyhYRi65ff02oGdG1DP0NGyG4Lh57b4uFI7GteumYlWYODl9WhVCW/yg3?=
 =?us-ascii?Q?IOgdlphH3AJpQM83Now1YnVLQoJECAE00NPLcCTzDd3/74Ls3Ruo0rLyYfKZ?=
 =?us-ascii?Q?4tDIUrRNhgFaBazhs9vGhw+pw/Fjlw+rG3Qc5v/Spdl+InAhkxcMrYwvUtWt?=
 =?us-ascii?Q?vsInkhRSdAn8NuQQfVe8o/5JxbUTY/cWQgqxC48Cp86PQB6MDII8xQ11bGwF?=
 =?us-ascii?Q?FL54Y0WQYIGFKE5cl3BzCn2bwhUEq1I/VGV+AMPrn/YsdaU08GM2qXSoGLDv?=
 =?us-ascii?Q?JvrVmk5FlLIArfFRt1IRXofDuZmJWMwDzrYBhSHtpjeM7ouqiye2149bKncy?=
 =?us-ascii?Q?4uzuDMVSTxcB4M6GeEFanXoHbUSC1x0h5q2PYRolW3hqNGZzipspvP5twFd1?=
 =?us-ascii?Q?aXJNA/x3qo7dgZr6voPlbKIWoopNI6k9ag5Tm7p/3dZGllogt8I2OPCAT+h0?=
 =?us-ascii?Q?4CIT3t2oxDn5VhUXNrbwmo/1vcacIQmGW24TWb9xa9a3kmt225FQmhkE1gOv?=
 =?us-ascii?Q?7oOOEBIVGr13aIimNe+UkJBCRYaRRPYWvHrsxAnmkmp7Zs8hOcfcLhQ/B5dL?=
 =?us-ascii?Q?O6sEmJzlxcfdHPMF1iZVhTgp9QaqG2SZ05Y3iSyCqeV4/F7TfqHkEXpxSVjO?=
 =?us-ascii?Q?NJ4CaIakPxQpsBltGq27Z8W7mh/zVvA1oCo8aWA16IOfoZrqu1A+1zSaXPAI?=
 =?us-ascii?Q?/fmZOtv5nMaa/mYaXvkMbVr3O63w1o9aO7gYp3Ig8AnjTtj7J94Iqapxd+RR?=
 =?us-ascii?Q?rSfOnLzRFoNnMXc0ZQUV35HxqEgvbIVRfFFaIQrgcYEKdRYzAVWrkhHHeTVQ?=
 =?us-ascii?Q?Vj0hyp9lkfqbamTBTcGck77BxwBN0K1fKM0GEcG/g/KV92c9LGIYNy9dGBg9?=
 =?us-ascii?Q?QBWjiqXee+8htHcr8nBDvVpQAxPKGQ7IWOfgGt5QlyFNJx0Ye+hVGkPEMgID?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8bb9a5-5ebb-4176-9abf-08ddaa274d8b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 03:06:34.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGbbdbAIMtLwwZdBW7davbKvZTmximgk29iZ5BJHZyEWbRzW4mdZDxGOUVMdM8wqQgLWOvzt5dFvJzn0QFnENpyIjOZxB/YR0ePjqbTP+IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8113
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 7/6/25 11:56, Dan Williams wrote:
> > Alexey Kardashevskiy wrote:
> > [..]
> >>> but the point is still that we
> >>> have not even got one implementation of a bus Device Security protocol
> >>> upstream, let alone multiple.
> >>
> >> And my point is that TSM does not actually do anything with PCI except
> >> SPDM/DOE which can happily live in a library or DOE (and called from
> >> CCP or TDX drivers) and the rest can be just "device", not "pci_dev".
> >> I wonder if+how nailing TSM to PCI makes your life somehow easier, it
> >> is not going to help my case. Thanks,
> > 
> > The goal is not to solve Alexey's case, the goal is to solve the TDISP
> > enabling problem in a way that all impacted subsystem owners (PCI,
> > Device core, DMA, IOMMU, VFIO/IOMMUFD, KVM, CPU arch/...), and all TSM
> > platform vendors are willing to accept.
> 
> Right, so I need to understand how this TSM makes your life easier.

The goal is make other subsystem owner's lives easier.

I read Bjorn's ack as "oh hey, you added new PCI/TSM functionality in
the same way all other new PCI device capabilities get added with
lifetime bounded by pci_init_capabilities() and pci_destroy_dev(), and
the sysfs attributes follow normal PCI device rules too". I also expect
I have an implied ack from Lukas who also does the same lifetime for
native authentication.

Now, they are free to change their mind if new information makes them
rethink this, but I have been operating under the assumption this
question is settled. I read ARM folks as tentatively on board as well.
Greg did not balk yet either.

I expect other subsystem maintainers want to see vendor consensus before
weighing. "Ongoing debate" almost always == "wait".

> I did show my complete solution, still waiting to see yours or any
> other really.

This is a fair criticism and I hope to share more soon in the meantime
Yilun and I have been working on the skeleton pieces and samples/devsec/
to unit test the proposals.

> For example, DOE bouncing.

The tsm operations and bind have been taking up all of the focus. What
are the specific concerns around DOE bouncing proposal? The only
criteria I currently have in mind is:

* if there is common boilerplate lets make that a library helper
* a TDISP operation / state change should be atomic regardless of how
  many DOE messages are involved.

> > "TSM" is literally a PCI-introduced term. It comes with a full
> > device-model and state machine for a protocol that we, OS practitioners,
> > have a chance to agree what it means. If another bus wants to do "Device
> > Security" ideally it would map as a strict subset of the TDISP model. If
> > / when that happens it is easy enough for userspace to see "oh hey, bus
> > $foo now has tsm/connect and tsm/accept mechanisms too".
> 
> Quite a chunk of it is in the SPDM specs which have all sorts of bindings. No strict PCI.

Agree, but most of the interesting potential for shared code there is
buried within the TSM implementations with TDISP we mostly sit behind
TSM calls.

I note that Lukas has spdm common code in lib/spdm/, but all of protocol
work there is not usable for TDISP since TSMs run that protocol.

> VFIO started as PCI and look at it now with all these platform and mediated devices.

Yes, and VFIO still has specific support for PCI semantics... but the
meat of your concern is below.

>   > Just like the evolution of the "new_id / remove_id, and authorized" bus
> > attributes, other buses add workalike functionality as a matter of
> > course. Other buses can add "TSM" mechanisms to their device model,
> > "TSM" is not a device model unto itself. Similarly, nothing stops
> > 'struct pci_dev' properties to be promoted to 'struct device' when
> > needed.
> > 
> > I note IOMMMUFD has the bulk of all the interesting cross-bus shared
> > work to do here and it already has a generic device object model for
> > that purpose. It is another example of "extend existing objects with
> > 'Device Security' properties", not "add a new tdi_dev object to manage".
> > 
> > I am frustrated that we are still spinning in this philosophical debate.
> 
> That's because I did not do very good job explaining my TSM, my bad,
> I'll do better, it is too bloated now, and violates sysfs, and should
> integrate with Lukas'es work, my bad.

No need to apologize, this stuff is complicated and I needed significant
changes from v1 to v2, getting better for v3, but v4 still needed.

> But having this all in a single built-in (1) with PCI nailed down (2),
> globals (3), one tsm_ops struct for both host and guest - this
> frustrates me.

These are good review comments, and need to be addressed.

> (1) means annoyingly many reboots vs rmmod+modprobe

Once you buy the idea that a PCI device capability should have lifetime
bounded by pci_init_capabilities()/pci_destroy_dev() and attributes
defined by pci_dev_attr_groups() then the built-in design comes along
for the ride.

I do not agree that this near term developer ergonomics issue, for this
core infrastructure piece that will eventually settle and be slow moving
thereafter, should affect the long term design.

That was also another motivation for samples/devsec/, i.e. stand up an
environment that can quickly target different corners of the TSM stack
by restarting QEMU.

> (2) TSM does not IDE (the platform calls the IDE library) and does not
> do DOE (the DOE library should, called by the platform)

The rationale for this organization is that IDE is not required. TSM may
have knowledge that the link is secure by other means.

> (3) bites every time when there are development bugs

I take this as par for the course for PCI capability development. I also
expect the bulk of the development complexity to live in the low-level
TSM driver, not the TSM skeleton.

> (4) leads to ugly "if (tvm_mode())" checks and bugs (when missed), been there, done that with my first TSM, did not like it.

Fair enough. I will take a look at replacing tvm_mode() with guest
specific ops structure. It likely still ends up being the same ops
signature though.

> 1/2/3/5 are not necessary, do not really make anything simpler and
> most likely will requite untangling later.
> 
> 
> Say, there are assumptions already made for IDE which I believe we do
> not have to make (like, same number association blocks in all streams)
> but it is internal IDE detail, can be changed later if needed, but the
> API is sane so I am ok with the limitations (thanks btw!). But the TSM
> just is not there yet imho. Hope it all makes sense. Trying now to
> move to v6.16-rc1 + dmabuf + this series as we speak

Which dmabuf series are you trying to integrate? There is yours,
Yilun's, and Aneesh was looking to publish a third.

> so you'll hear from me soon :) Thanks,

Sounds good, the whole goal of this is get to the point where 2 vendors
agree and they can drag the 3rd vendor along.

