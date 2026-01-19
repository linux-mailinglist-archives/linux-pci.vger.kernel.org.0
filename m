Return-Path: <linux-pci+bounces-45226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F4069D3BBFC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 00:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6EEA302A385
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 23:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A782F25F4;
	Mon, 19 Jan 2026 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbJV7K/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01217234984;
	Mon, 19 Jan 2026 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768866294; cv=fail; b=IQP2jiRAjM7cYHGt90cQlB4IO/IV+eiNzBepS3xX3TnNIEN0xH730ucOlfBG6gpuo1CVGkJzKL1qG/TzsYvzn5jsp50/sVnG0hD9baJUnXpQlkRyt40l7YRbasr6dJt8BoP5dCm6sYF/8DHUz/8e/VB/G31de8uIK6W3x0K/Q5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768866294; c=relaxed/simple;
	bh=kt8TIxM0wyldmdukxbXPh6bAL4IjGLB2425gvEOdw00=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=n7QGZ5DSQfP1xfkfUn16URm4hwqyFlTerOdADUHGmd0QTitWr1fIeu75AphNKYPgV0gpcdvwVd6HIFM94mqLpPs6oT5LZokT5nXNPHVapR1CK3jK69ZP76QAc/aHpJ/4SPkZkcXADAuqZ4iVjF90IZIrUAGkOWjNA+9r3MyLyJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbJV7K/o; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768866293; x=1800402293;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=kt8TIxM0wyldmdukxbXPh6bAL4IjGLB2425gvEOdw00=;
  b=QbJV7K/oggonaPDpSjynUolRmsYKJtXbsdVryuxBWpsVdzoQppnBtryv
   geDxixX2PUX/eWgZXh68ShcGU6y+MGW8DDZunQE+qeLN7dwlUxOzQlo/G
   NPF5BduzoBjiZU+lEZGwsKRAl/VRt6QNBct0s4tiDQ2ZVywzQFUdsLqSp
   GoXqxmdFUv3G9SLD6PX59w2m/MxRqIUVYpVu2XjZE0YlHD8t44lZA+HUl
   CiXFVm3ri5XEHDa0ffy84lPIGJxOpAtExYnxAF41hlRrtXP/8rw/w/4Xx
   psLlZ5edQSDtT+LoN6gQ02ZPPWvHp6vzb8ye8yrf+ZKwD7lwco/WLoa9b
   g==;
X-CSE-ConnectionGUID: YOg8NrbYRSCGOvCSQKp4GQ==
X-CSE-MsgGUID: vc65JCnKREGC6jGHplZzXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="57631096"
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="57631096"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 15:44:52 -0800
X-CSE-ConnectionGUID: QDDtD6zJROmfd+tS8oSBJQ==
X-CSE-MsgGUID: 3Ze3ercASAet9KeIZVaHOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="210106573"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 15:44:51 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 15:44:50 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 15:44:50 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 15:44:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDVrdcK1M14sFzuKGR8zLBknV9PpiuV3btvmtqhf5BtKHxiWshQsSuStttx0qZrrFmZ+gWPJQkGsSQrxSrQo4zH4MxgQehC5biSJD2VFA6NqPAaM6mOorVyGgpJnGDWuUMYk4DvLDzb0uHoK9Qr5m+JtAJka1GusV8KLuz1CdGCro/Gs9TbltW+nI+eYzYy6qnhsCjVrlDSaLUqsnlQnthE4L6NXUFu7ZVWrnfa4mA+97tNmqZx0x1+c1nOp3RunaqoEVs1qmBIpVieEXLEHEDp3jWXjNHWkU6k2kahF6mOoJu0XywEI2+R1b4E7b5o2tugp5byAJj1F8pKp78N0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BasyCW7bFOXeKyxff7nXEvpa8oh78pL4G2pCUXmRKMA=;
 b=SLw+KhPRTcf34BpfQymRajQGXoZR2/71QRXGrTMwUxf6ruaNWzzbgcZUVJUzp23KhbgrGvJ2gosW94vAaryIhncuqCzTv9NXq5ggxCxmwcD8lSIFO9me6eWN5pTRPX9fj6quvrw5Nkyio1MS1iwhWhJAeLLj3MypIxnqbWId3GyGToOtTS1OC/d7ZQBqbUXCUKZ7A83J/cAhCoiec+w9OPXusMNRV7Wr7Q0orYaF8WIUltObmfrUL+dzvqsYHQDRAS/XUyVeHeN8F7urYIoJvFf0xoKZxUg8zXiCUoYydqGoGJ/spcwgeDShf6BeLWc58d62ZqJyvBklPbOUOEoEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 23:44:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 23:44:43 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 19 Jan 2026 15:44:41 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Message-ID: <696ec1e9cd598_875d100f4@dwillia2-mobl4.notmuch>
In-Reply-To: <20260114185358.00004dce@huawei.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-3-terry.bowman@amd.com>
 <20260114185358.00004dce@huawei.com>
Subject: Re: [PATCH v14 02/34] PCI: Update CXL DVSEC definitions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4e9225-0b2a-412e-6ead-08de57b4b850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWxuTjlZaEx6SEFIQzJpUW91dG9BQWd3Z1U2WnRaWjVxNUdJZE5Ia0lsM2R6?=
 =?utf-8?B?TWx1cjk3TFhjeUtSamlnRTU4bGNIRVlndFZNejMvR2FYS2ppS3l2OHNZY2dV?=
 =?utf-8?B?T0xnMjVxazdJRkpUWjZkQzR0UEZ2YlRWcGVsOHJ0VVcrSWNkWDRvOXI1cFl5?=
 =?utf-8?B?VVpadGMyenRLR1NvdmhIOFNZMnE1ZHgyaVoxL0dCd2I5dFcxaU5lc3JOYVVt?=
 =?utf-8?B?NjdNUW9Dd3ZSYzcxU3o5dy9ENGdINnRzdXVpRUZtUEZ6MGM2TUZhbnBsL3ZK?=
 =?utf-8?B?VFJVWHJGa1huYWViZFJsSFJjVHo0TjVMRGZmWGoxcTdHelVqMFpVVXhCVk5h?=
 =?utf-8?B?dXR5dGMvbitrMWsvdk9aYnoydktVNFB4eDlVOFlKem9OUWp2bjR5TXVWWDd4?=
 =?utf-8?B?bURhZE1MdDFkRkhFUk9OckxieUYyRjZFZjN5ei9CZlhHNEVVMThNTGtiQkFS?=
 =?utf-8?B?N2NDRzIyWE1xOGhQUFNVb3EzcXNkak9YNFpHbVIyWUl5b3Z1SWN6QWJpSUFO?=
 =?utf-8?B?RVZEVGlGcml2ODRSaWMzYS9DbGRFbGt2MUtSZVhFRkVZOUlKSU5PelZBNWNw?=
 =?utf-8?B?TGVFakVBVDhGNGVoQnRaZklhUU84RllmY1dUR3pCekdFd0VXRHF3b3BKVWcx?=
 =?utf-8?B?RU1Lc3RiWEZDdDVteDdNTFB1dmtLZndTdHVVa2lnMjczTnVlTElnSzFPcGRo?=
 =?utf-8?B?UjRKM3Y0OGxmYXVjZnVYSTVsT3dNVTVMdVVhQXdKS3N3QmN1UmJLaG1Bblph?=
 =?utf-8?B?VUlOYm13cXo5Q2ppc0pQZWZzbG1QeFhVZ2dpRm00UUFmZVgwQmJyUEcvOGRl?=
 =?utf-8?B?aE4wRlZ4VmJJUHJvYk9YUmQwTFV5c2RPRjlyVGFaWTBjNSsyVzluV203eTNR?=
 =?utf-8?B?bmZzd3MzTWJqWStxZmp5RXFEOUpoRFl1ek5NYmUvb3JPR2YyaTRMVHNQTjZ6?=
 =?utf-8?B?MEsyTUJEMUtIaEZOMnlCdVZhaGdxeHE4QXozYm51OUJYdnREeUhLbk5lOGJY?=
 =?utf-8?B?R1BPVk9JbElYSXRUQ1EyakdsVGZqQnhBV20vUjNWWG9taERRWnBkUHJldTdv?=
 =?utf-8?B?bFB1UDV0RlgrRlNLS1ZXc1F6c3pOQ2lIdGt0RWNzVXFGK2JhMHNUeDZSd1hV?=
 =?utf-8?B?ZDlEbzYzSzdxZEoxa3VTdGsra0RGeVo1WURKYThxa1lYckcyaEFFUmJIZlBT?=
 =?utf-8?B?QXlFVEU2OFVVU0hLbWFhNXUrYzlXYTI5QjFnRVo1L09RSVZKV3daMWtJVmF0?=
 =?utf-8?B?SDNpUFhHSFI2Q3Zad1ZHa3hZRXJGM05tZmQ3eHJ6RWpkSU80TzFFMXdORlJQ?=
 =?utf-8?B?YWpENmVzQ2g1WjlJNmE5eDkxK3RNZ0VMcnR2SVV6SS90b3dGMm5ZVG51NUVm?=
 =?utf-8?B?dkozQ0lUVFNNUkp1QUlHZHdpc2J6OHdUVUJOUWRNcmp1Z1dDNEVUVjRnWVdj?=
 =?utf-8?B?dzVOQk1KUml0QWh3c2p3Q1pCSUhYV0x5aFBaTEw1WG14a3RQcTFnZUVsd05Y?=
 =?utf-8?B?WUJmWHFYY25TNGV4UTZLanM2SERZMnBmb2c5MEllYjdpbnN6RmFVa2R0cDJB?=
 =?utf-8?B?OVZyK1hQRmg5TWRCTTFXYnJEYjFSTjRleVpyc3UvOUtQYjA0cVBKdnpoTU5v?=
 =?utf-8?B?RjIrVkZkV01zL2UyTmRDVkhPNXFNdU05eGhtRGpoOFhkV0s1Vk9MOWZIZTZn?=
 =?utf-8?B?K0J4MzBveGJsYTNJWTF1ZGtrbjZzQU9LeCs0YTR1anhDZVYvZFZlakdZVVBN?=
 =?utf-8?B?bE83bGkyazBCY2t3N0s2OUcyRkdWSWxXM0dVd290blg4S3lDZ25UQ045dS9v?=
 =?utf-8?B?WHNUYWJqMmZnOE9PVzJ0dXg2NW1Ua1QvRWpjd0xGaVpZNEg1cWVDV1RnUUVY?=
 =?utf-8?B?cnAyQWNpVmMyM3NERFhxWFplSTFFUEQvTGxMSVpWVTVJQStVanpMZFFLSVpZ?=
 =?utf-8?B?cmNLOGQ3S0RpMzU1UHAvQUxhdVZwZGxIc28vdEovYk1SQzc5SExMb0tCZlFp?=
 =?utf-8?B?RmcrbXJLSXBYYWVhZTQvd1IreitDWTNrQkd2Ynd0MU5ERVFnL2lKYVBGc3JR?=
 =?utf-8?B?eE9uV3dxNWxCZzYrbk1BWnRJNStvbWs5ci9pTm1YY2cvMXNiTEZzVlVFZVNv?=
 =?utf-8?Q?bonI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE9jcnQydlVsbjduZmduWVY2bXVMYjdTUFpsTVlGWmxRemxOd3U3b0w2TjlN?=
 =?utf-8?B?Z2hIdjNpTkZVRWNwSkJwdXZQLzdqYUVaOVU4TU1QMm5QYnhjRGRybGhOc0do?=
 =?utf-8?B?MU9Ba3ZxQXJHNk8yKzFoZDFCQUsra0VqM0Rjb3F2cXl2WHJXZjFLdGFVZnV2?=
 =?utf-8?B?NXE3ZXpzRFdmaFoyQ2d6Z0s4RnJlOG5YUXFMYzRhV3ZiRmRuenZpUkwrR0pB?=
 =?utf-8?B?b0wvRC96SXFYVk1XRmVtb2Q4SFRJQk1iMW9NVEhWN2VjNXFMMDBXdDNRdzFk?=
 =?utf-8?B?Q3J1dUl6bmsvalNOdERUNWkxUCtMK0IzNUEySE8vR21XRXFhRzl5VjR5ZVBO?=
 =?utf-8?B?KzZmbWJsZFVLdXpPTlZ6TDNLN2FjKzJJRVF1ZXFwUFFON0xJSzFHSEwwRWk3?=
 =?utf-8?B?MGlLUVhRMktULzNCK216aDltVzhKSE9TVTZoTW1tSDhjK3pFYWFlaTRGd0cz?=
 =?utf-8?B?MVJ3b1hLb3BvSXE5VWw4U08rZ1Z6bmhZZ0ZMVUR3SFRaUnhraThPYlhVY1Rx?=
 =?utf-8?B?VUdRNTBUUTBqSkpjcmVubXhBNTBLdFJjV2Vyc0NYQUpxU20weTY1bjd2cFdL?=
 =?utf-8?B?S0NHaWVGaDVwdVo2ZHduN0JKZzB0MHBCY3laYU9DYUFvZVVObnowVStwT0xR?=
 =?utf-8?B?a3Npc1QzUjdTRnV0SmxIU3FjeitpQmZaanVUSHo3T1Y3dVZQUzV5SHBGcHdk?=
 =?utf-8?B?bmVJdVBXT1dyNE41Q0dNTmRrYkVZNTJ1czVTUVBzbXhBbjQ3UHNaSXJWWlp2?=
 =?utf-8?B?eGZXVjRlbDBzajZ0MnNpMEFZczJWQWVwQ0pMbWQweEJlV2ZRak9LM01Oc3lF?=
 =?utf-8?B?cGxRQlU3ZEJqcWJYd3RCSE9NUEd6VkRIMmhLWGllNzBEZ2hzejNlamJ3ZXBK?=
 =?utf-8?B?bVRBTmJUMjQ2QkVYTGhOcmt4SktBQ2oreWp6ZEJGaitFQ1pyVGFBYU96T096?=
 =?utf-8?B?ZXc4T1NibWJrd3h6eGl3MVFPUHBvQ1J2NEpJRGVTMzcwV1gweTB6aFlMc0p4?=
 =?utf-8?B?NW5odjNOMXdXM0dpYW54eUVxbFFUcEhGdkNjeC9TY1JGODhja2FMTGFuYUJ0?=
 =?utf-8?B?NzErSFpZblZtTVZDRjJMbnBDd0hiWnZDQXoxT29nMFY5Um1rRDM4MEJSSW82?=
 =?utf-8?B?Vlc4c2JITDJEcXVxWGphcDVXcHU0MWh6TDEvWkNJTDE2WHdYWUlBSzROMUdH?=
 =?utf-8?B?MGpaL1BVVUtVYTZBR1RUNjlPaU1qU1ZlNnlYNm9XZm1hUDl3dG4xOGpPL2F2?=
 =?utf-8?B?WWFwSVpWRGluTkpJWVJ2amdvNGUzYzFGYkNIeng1ZUE5amMvODBiZVRLRjVi?=
 =?utf-8?B?RThLMjlYTXF6WXZtOE01SnNkRm94NHpRZ0NMVmN0RDVLb3UrL0pCTEgrSk5Z?=
 =?utf-8?B?ek12YUN4cm1GendyQ2Vxd0ZGcU1GQkdORkNjVWs5NEdybloyQ2h1Sjl3YVB3?=
 =?utf-8?B?UmNtR2tqSnVjUEUwU2plSkFqbUt2OWRPdCtQU0xSMXNDalFoejRMMXZ1OEVK?=
 =?utf-8?B?ajhvMkZFMHRXdzJTNzB3aTkzTWxxOTY4Y21nMXlxeEYyY2RpV1FXaDloemJ0?=
 =?utf-8?B?djR2dFg3QlZ1OXB2b1ZXa2JXWDhkR3lRYWdmajdia3lTejgyaW1Lbm9oQm9J?=
 =?utf-8?B?djNtVURhZGJLU3cwbm0rTUc2bXJqTHovRmU1UTVsazBXdHZocHBnSWFNSDNy?=
 =?utf-8?B?VFlFZ3o3eFJoYnNhNlJwYStnelJTbDB1YitrT0hTRE5LdHRkNTc2dzJ5WmFW?=
 =?utf-8?B?TEU3N2pZRlB1ZXR2QVUvSVZUUjVMR2NKMFJML2JoN0FxL3JEUm5pa3JjQXRS?=
 =?utf-8?B?dWZPelNtVWV2NXhFSHNOM3lOc01PSnNzc0dETy9hUjhXWFJ0SHgwMXdpcHRR?=
 =?utf-8?B?RUhCWkFldXZvZ1MwbFByYzhHNSsxc2cwWms1ZVJkbXNPVURPWTg4Ymt1c1BB?=
 =?utf-8?B?a3hrS2l0dnZJSG56SWpIRXVxMk9ZMlpVSE5zbVhIUWRSdFAydGIvR21UdzYv?=
 =?utf-8?B?djVjMDlkLzcvRW9MM3JuSEhzU2pSdzEwZ0tCR3lzaG54U21xdEFma0N3WTJy?=
 =?utf-8?B?SG83UDdSWW1GUmZwQlBjVFF6Z2kzTXZsdGlXeCtOdEZHMThhYTF5R3NlMFhO?=
 =?utf-8?B?eUttV1dtZ2FZTm9TdHVhcTZLdVNDZWN4MkVwdFN6NmNrYzBuU0xJZUFvaHdq?=
 =?utf-8?B?UzQ2ZEtnQTBDYWRCeE9QUG5FZ1JlRC9jdjN2ZTU1U3REUi95S2NhWUpFTGR4?=
 =?utf-8?B?UzRZK3ZoMVQ2SGRsUW5qZEo4MVRmbThwaXZPYWtxMG52dUhJYnhEcVJHczFD?=
 =?utf-8?B?NXl6MDI0S3BuVFltbHo3T1RKUHowczZYNm01SEJWNXYvZFR4LzB0bW9ZclhF?=
 =?utf-8?Q?2l3qO1LecSrzpgUo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4e9225-0b2a-412e-6ead-08de57b4b850
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 23:44:43.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anclRfdQQGjdXa9iN0X5VLd7gONPn5PwxBZqgjlDNP8aUrb5dSf1VC3doBqzv5dUgFO/abtKXmjSl8iIKF8YO7xxensVFUlBrhzE1ctWVks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 6c4b6f19b18e..662582bdccf0 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> 
> 
> > +/* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
> > +#define PCI_DVSEC_CXL_DEVICE				0
> > +#define  PCI_DVSEC_CXL_CAP				0xA
> 
> Why drop the _DEVICE_ bit of these I'd kind of expect
> #define  PCI_DVSEC_CXL_DEVICE_CAP
> to indicate which DVSEC it is in.

We got by without the redundant _DEVICE_ in the name to date, the port
DVSEC has the _PORT_ differentiation. In the interest of not needing to
review another version of this simple patch I vote leave well enough
alone. Will leave it to Bjorn if he wants to override.

[..]
> > +/* CXL r4.0, 8.1.6: GPF DVSEC for CXL Port */
> > +#define PCI_DVSEC_CXL_PORT_GPF				4
> 
> Nothing like ambiguous naming in the CXL spec as the
> following fields sound like they are in the CXL_PORT dvsec
> but they aren't.  Well the spec avoids it with GPF_FOR_PORT
> but we don't want to go there.  I wonder...
> PCI_DVSEC_CXL_PORTGPF maybe to avoid that?
> 
> Sigh. It's probably not worth it and does look horrible, so stick
> with these.

Not seeing a siginficant improvement in the suggestion.

