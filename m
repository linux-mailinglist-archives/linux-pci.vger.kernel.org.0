Return-Path: <linux-pci+bounces-32005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9CCB02D79
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 00:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4FF7AB8B8
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845911DE2CC;
	Sat, 12 Jul 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFRx50Ls"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953DC183CB0
	for <linux-pci@vger.kernel.org>; Sat, 12 Jul 2025 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752359493; cv=fail; b=VjLqI2VVV39wrlG8mTmwdr3lAWfirI5TlYZg0oKWMWQxk3Mda9TgsymCXhvYKvSCcJT5xRBn8CwSqfsS7DiIhj9yOlLOZHE1JFaaWy5WqfdCewbDfJn03thQ0aiudS/rncH3eQgDwopFzl299wcxSTub/KeEw/jhZNHVMzk4ylA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752359493; c=relaxed/simple;
	bh=tiCVghbHS6T2JIL+0XKN66V1fUtcu0RbfwnxiJrYI+s=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=sC2LREaSyFYIY+6A4xzZGJG8Rhs7frPZpdRhj/wbY8YyVam0rVliAwtf1b5m/+DwyBqT7Qx0jP+6q3MaXWj9oXdMH6iyuzdT8AeW6WsxlHRIfzVhnMTEoEmRGeD/0W99ePlfppdjBCJLao+AJ+BvrPY5UGyilKAVuBhmFE85HOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFRx50Ls; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752359492; x=1783895492;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tiCVghbHS6T2JIL+0XKN66V1fUtcu0RbfwnxiJrYI+s=;
  b=bFRx50LsuT1I0cKZ6rdtmaNbYLYixjPLOCkmQ62Nj1a4HXOPrPTppwCg
   3TXT/An0/G/awfS4olpFTB4ghA4yaQViFVSluR2hLWFwPGmAc+17I8TM8
   YO6BMFRHIUOmzDkieEaMY4dzaw/6JMMdsr8CldrG1dh+swKhvDvjroobA
   SszoPSNMZYYfKhxJlBDuKuD1SAtYeWFlSXi5dUjGU/UVLXZShoYFjQ70P
   QV4VHrYMlvb+fAPDfoSvSLKk+btOdMUue6NE8HZ352Ip0ISdgQZQRzuq4
   2uEyk/uj6k8SJW3uoY+ka0Ni7zApN938090d9E/LR5Us+lbBBmtn0fRTp
   A==;
X-CSE-ConnectionGUID: g1j6MpeASE+MJgAIJBk/0Q==
X-CSE-MsgGUID: KGrCvwwhTi+iSLSKbbPU5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="42244377"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="42244377"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 15:31:31 -0700
X-CSE-ConnectionGUID: j1IKRgSgRu+Gz3FboFWAGg==
X-CSE-MsgGUID: v1Eg15DBT5aNCQqT0gR/kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="193834104"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 15:31:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 12 Jul 2025 15:31:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 12 Jul 2025 15:31:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 12 Jul 2025 15:31:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deruiQB/xbmvbsZwzmHpACWTx/O48jBsQ/ORsIGZou4C7nV22h5QVDmZzyP2i/Cd6IIeHDmkPeE1/7lc5+8fQK5nqWTbLAByTyxywgoqECNDrj+QR+wTjdGXRIVtEA8CB9So4sieNTOcxDSyMG3RvnH+9YDb2KgsaUEf68vD/Q2YWahO2nWKIq+7lhodQ2bI0EI4nR/zMTjTKo7DiItHkxAASj+OArI8BFOmp0/q8UNsnUUFSi81fG00xRqKrdQTJizRz30O2NRTaoubvJhAHtjXYYSpryiTtv5G5L4k+WaOwU/lQ4nKy/5JI2/KgpRoVNkGi4/tms4XVvnO+aLPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xwh4UgNhZOmbdtHg6Slm4u+jfXEWT6pQiI3izokKED8=;
 b=WIbEg/MavOeicFXRxTHnBPTg1sruYrZ0v0oLbldWYmhEYK7NbbCuJ9KS2PU3lXppYg+MmYUuQn/6yfYuILdntGC76IPwy/7M/vGnr/J4AsrLGCAqT9eiar7KysUmNi5sqNn7jI7B/PktemxBRYiagqNuY87oZY0sfl0h7xhK/0wMrYpO3disQFY+iaP6+83BBRqKz2O7u1EEi8BPkbJx2rb66RkVsL0QWoE7qEoR3g5qF6t+0ZF9e/TVbBNnce38F9piYLGAVvCuVHdaFTTnGN+MTToiZBglPN0LDIrRYM7S6WHCtRFgAnxjL4TTl7JAKNtTJnxhelqwccB+vZ8TJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4637.namprd11.prod.outlook.com (2603:10b6:806:97::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Sat, 12 Jul
 2025 22:31:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Sat, 12 Jul 2025
 22:31:26 +0000
From: <dan.j.williams@intel.com>
Date: Sat, 12 Jul 2025 15:31:24 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Yilun Xu <yilun.xu@intel.com>
Message-ID: <6872e23cd24a9_113441003e@dwillia2-mobl4.notmuch>
In-Reply-To: <20250617131602.00001957@huawei.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-3-dan.j.williams@intel.com>
 <20250617131602.00001957@huawei.com>
Subject: Re: [PATCH v3 02/13] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:a03:117::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 070ebba0-ecae-4e86-3d70-08ddc193d688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzEyK29KRlh4RU1sWWZEY1VseFl5SEN6VGl6S0tJcHh5d1BLeVNkajdGaUdt?=
 =?utf-8?B?UG55VzE2TVBWelNobGFvRXZsNExFclZPejdXNVVWb1Q2dUw2TTV6OXBpOEc4?=
 =?utf-8?B?T2NLcnhaUEwyMHBqUUNnWG9vR0VjOFBFVkZmbWFVaTlMOGVhSytHdk11T0w2?=
 =?utf-8?B?WjE5bkpEeGdZWWtUUVFaRVN1MHFZOVB0Y0JPbTF3bmlJc2xSc1I0MzFqWnJs?=
 =?utf-8?B?UXFvUkl4WkhhZTRSUnZCL3g1NExSVUFyVnk4YjE1czcwT0xUakp3SnhWWTdM?=
 =?utf-8?B?YlZPUjZ4MnR3bUZQMEZGbE1YdFg4b2xZMmxpL2RkVTdLNmFmMjdEbFdrUi94?=
 =?utf-8?B?eGE2QXFHOU9SS1A3VHE1eEQ3emNKazhlbFRjWDlXajRTV2VUUWo4aHlXOFU1?=
 =?utf-8?B?K2RScDFIeEltdi9samY4anliSUtUbGN2RUUxRDFHWkNybjF5ZDV0dGdmTUNt?=
 =?utf-8?B?Q0RYYjBxbmtuUHNqWEppUnVobUdRc1pqcEhMcUxBa2MwM0tmc1pTeHRseGdM?=
 =?utf-8?B?TlhrcnREdHpYNXhDVk9TM1JONHJlZlo1bGpBQXFjNEV3MWNPNmtROWtvalRP?=
 =?utf-8?B?N0FWanN1ajc2aDkwcjZoR21WbGxjemlWeWloRU9xQ1pWT3c3Z1RuZlBXai94?=
 =?utf-8?B?bWFyNTI4L3VuM2ErVHVILytiZ1JpSERtSmpzanQrdm5pUWFtZU45OFozRGJl?=
 =?utf-8?B?QjJtSDZnSnpmNTFaRThHYUZOT2EvUnRibmRzYlpWZVJIWVR4dExnVHV0djlH?=
 =?utf-8?B?VU1rWXhNNTczRmxNTm1mcitGSTZNcnhGeHNzU0k0QlErSkY1L1AwUGY0VWdr?=
 =?utf-8?B?MkV3R0x3ck1NaUpqcXhIMThRcTlEdHB0cyt1cDEvQ0hsSTUzaXFXT3RGT3ZS?=
 =?utf-8?B?bDcyLzc3eVF3WkVmQzlCdWdHclBuUmpSMWU3V1hWektiQVZKU2p3dnhWbmV1?=
 =?utf-8?B?aFlmQ3k0Ty8zTjltQUUxOUlzblNqZVc0dkdYTHVNYzVaTE9KMTVSeVRLWCtj?=
 =?utf-8?B?TkJ5QkxNOHpKaGZxTmQwOHdCVmMrUEJJZVRCUk1mbENQbTE2S0ZzYng4R2R6?=
 =?utf-8?B?L1VuMCtvK0tDZzJPVFdDYzZ2dWhUd1BOSUpJeUx1R3MyZjdjczRMdVRuaFNM?=
 =?utf-8?B?UVJoR3I2NFRDWks3Q2hUby9OV2ROQU5LWFV5VHJjYTAxQmlWQVJyNkJMSXMw?=
 =?utf-8?B?QnBJWEtxT1J2dU1WcmJJTklYNjVuM2p4cGlVSUQ3aGhhQ1FJZnhKd3pHNGNa?=
 =?utf-8?B?VTFvbUE3MUZhcHV6Zm8yOHVYTXB5TjNCem0wclBxSnNnM25oL3N0WW5xcU1L?=
 =?utf-8?B?VWlleXZTdlQ0NHpoM2xMV2tUZGhVSWtkWFVUSjNGa29VZUFEUTNRUG5pWVNq?=
 =?utf-8?B?bTlCZVFMUVNlcllPOEpHaGdYN2w1ZFZOTHNPYlVTM3dyRFR2clJCdVVIcnZX?=
 =?utf-8?B?SG1ja3lzSlg4enEzakhhYzF1clk2MjB6cGJMcXZLWGtoUzkxSjFEMWh4OGZP?=
 =?utf-8?B?M2F2elYyU0dkQU9sdElKTC9xU3V4RDFINGhQY3hhYWdFb2hySHdFNU5sWitJ?=
 =?utf-8?B?Rm0rblNkWWtkTytsTmFDVWgrblg1UlYyRGE1cnViMUo1RG5wNk0vOWw3a1Zp?=
 =?utf-8?B?UC9HVWxZQXpjZGh2eW56c0x3VHBidWYwTnliWnQ3OUJmOTFzYjAvemxLaEt4?=
 =?utf-8?B?UFFqeVFPMzRUUHZ2NjNkdkdmQjdieDFyd3ZaMHhGYkFsMUVkdktUU0pPTHlQ?=
 =?utf-8?B?andhZ0I5OHBJd1hsUEZ3dUZHQnhFaGY2Zk82cVF1RHRqQ2Q5VXFNRzlVK1JZ?=
 =?utf-8?B?Y0JRR1hjNGlFSUo4eWJMWXdGTmFpUDNXODlMUGpPS3hYbHd6azdaRC9LQXhk?=
 =?utf-8?B?RzlTZFFxdlhLV1dJeVBmQ2l2QVN3dWUxUVVhTzRBQjMraGZlTEFqeVhpbWZz?=
 =?utf-8?Q?G57SCjyUrEI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWJ2NlJUdE80d2JmZ0tnWHVYQy91cjYvNG1CZXY2MVZRMmN6cVBUY3RxcTJV?=
 =?utf-8?B?Yzh0NUFSZmZxdHRnUWo4S3E5S0JHQ0ZqVzAwemdTTW01RytSaS9CcnhCbzl5?=
 =?utf-8?B?N0o2NWFHdFgwVzNsQ1A1K09TMHBQQVFXRVdIYUVWeTUxSmFmNmdNY1kvZDFS?=
 =?utf-8?B?VDc4clJiNW03NUgzM2hCcStoWEpPazBiMVZVRnY1OVpJRi96NUFGcjhieFlU?=
 =?utf-8?B?WTEvMUNvUUNkSzNQMTlqcU5jRDZOM05HMDMwTlZZa2hFTWpWQi9CYUlHcFF3?=
 =?utf-8?B?WFQwMUZtV2o0Ym5kVHNPTFd4ZFg5ZUtzS2I3SmJmQWYxYXk5VUZsSmFMWkk1?=
 =?utf-8?B?d1BxNWY2WlNxWk1hTWVPS0FrejNDWGFLY2w0ZnBkSmdBREgvbXZQcGw4Y2pp?=
 =?utf-8?B?TnRZb0ZKd3ArdVdSd2ZCU1E3OHhVc2ZEVWNxYzZKMExOc2x2dEJVNWUvRGxs?=
 =?utf-8?B?d3RnaFBwWkFyb0hSdklCMDFKUzlOUThOLzhKV2ZCQnlMZTk2VzJYc1hteE92?=
 =?utf-8?B?UWF6VmlNcUxHVGFhL1NOd3BFOTNmdk10dWZDN202QjFvcHpkUnJXRDNzcUtl?=
 =?utf-8?B?OUZLbHFmcDFzaW8zb0dDWjZaMnFvMmp4aSt0UXVTcy9LY2k3ZktWUXlDSnpk?=
 =?utf-8?B?dlJWbFp1cGVXUThoTW9icFdyUXZFckUxNjhlV1diaVdUVFdSSFA5THA0cW4x?=
 =?utf-8?B?UlJ4Qlp1RVNHR1IwRElEelpQWjRkZjQrNzc5U2pUUmxoMWx4ajJwWnh0QlZG?=
 =?utf-8?B?RUV2UW91RU1RaGZWRWVTMjZZaUFIWGRTSmZRZ3k5Z2QzTk5OWjN5NmdTUDlF?=
 =?utf-8?B?Q29EYUV2Nm5pMFVEL2hQTUMrVVlHT1RuOWQxWkxuanNweXR4anJiT2RnY2ZP?=
 =?utf-8?B?V1VXYk9XcG9QK29mRTBWWlh4ZS9EZGZtN3JZU2JoZEl5Y0F5TFRwTU5ZUnJp?=
 =?utf-8?B?c1A5M1ZVVGVVRVl2QXFOcGtzV2JFU0NiWEk0VUQwMjRHaUNHUU40ajVqTGRC?=
 =?utf-8?B?MU5jTHFMOElqdi9MT1lkSXg2RVNjN2Q3ZndSRjAzaFg1QUMrWGphdXJ3UXpy?=
 =?utf-8?B?Vm5EbDBqd2kzSG5pMi9FUS9yd1BCYkExTTdieWw4alA0MUVNbWhUbmMzVFBp?=
 =?utf-8?B?aFRYZExRaVdOTUNJSHkvK21EMWcvcXhGNW83aTJlSG1TMXJzc1IwdWhMck1G?=
 =?utf-8?B?bDlGSlhwNHMzWjhuUmd1R29Ec1pEN2Q5WS9pSTZlWHluMGlRYmRRMXB4Q1RZ?=
 =?utf-8?B?ajF5VjY5UlM5RzZCYXlVL3R2RlkrUU5iNDJiMzFiMmMxK0lGOUkzWGlyaE1n?=
 =?utf-8?B?Q2kxaHBZcXA3T0tPdjZrakNNTFZ4QnlpOXFqS0RlWE02Y0VFdmEzMkRPelFh?=
 =?utf-8?B?bE1QazZrTE1peDBOZzFxa1gvRGw1aEZqeEZZYkVBcVRHWGFLWVRKL2dLZEZi?=
 =?utf-8?B?YlRZS2U0c3VqdFp1eHk0RjVjUDFmWmZCVWpqSjBtcWlrd1pkeGl3bDlwNENW?=
 =?utf-8?B?Q2tkMmtnZng2OGVMRWxJWVlXYis5Z1k4Rkl0Vk04SEFFd09WM2pQLzdzbHF0?=
 =?utf-8?B?MlJ5OE1BWUNkMEFPSXM3S1BPbjFveG1LSlQvTng5WWhjL3NkdWNLL29lYS9V?=
 =?utf-8?B?dVJvR1llMUYrQlkyS0lvQjRWZHphUmlyR3pEVnJOQXErcmRDNUp3eGJ2N3ZC?=
 =?utf-8?B?Sk9wak9SWExsYVMzZndtdkdFUTVTU3l1ZWZkSUtldlhBYUtnSHJ4akRLNENF?=
 =?utf-8?B?WW5DUjd1eEtwOGtrUmxpTzRwMjRkdVhaMGN5S0czRFFjU0l1UVNwNmVkaTAr?=
 =?utf-8?B?c3hNUi9iUXVWV3JUZmhCcjBRaWJJVEx0aDBLdW5aMjZ2Tkk3RUJiREIxMm12?=
 =?utf-8?B?ZmcxbEJOQk1pMVRuTnlLYlYrZFN0ZXMrbk1GV25ySy81czZCUVk0WldiYXZQ?=
 =?utf-8?B?eGh1Y1gzcEpML3h1cHJMVUtUd3RZZmY2Y0Q2N0JlM0k0NGtEbThxalgvcXk2?=
 =?utf-8?B?SGYySi9lWWQ5OCtHWVV5VWJTQWRiYnR1a3M1U0pUODBwUjZzd00ycHVFbmda?=
 =?utf-8?B?Wm9lMnFUbXQ2T25hWnVGL1VmdlZNTGQrYkxTRDY5akQxTGEwWmpjaXdkc0JE?=
 =?utf-8?B?MENCVVhyZmRHR2hIYlBuNFQ0QnZNQVlVZ0pHTkpOdUorREhEZ3RPdEdndGRn?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 070ebba0-ecae-4e86-3d70-08ddc193d688
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 22:31:26.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6O35WgnZtAquWKo6uFNrtI3koaj1srVwy7QVs2Ou5yLcbBneBOMLFHfqp8Q+FJWY+vfheghMu2dS/WTXa5YE6wZEYLeaWfpFGL652wHZlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4637
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 15 May 2025 22:47:21 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Link encryption is a new PCIe feature enumerated by "PCIe 6.2 section
> > 7.9.26 IDE Extended Capability".
> > 
> > It is both a standalone port + endpoint capability, and a building block
> > for the security protocol defined by "PCIe 6.2 section 11 TEE Device
> > Interface Security Protocol (TDISP)". That protocol coordinates device
> > security setup between a platform TSM (TEE Security Manager) and a
> > device DSM (Device Security Manager). While the platform TSM can
> > allocate resources like Stream ID and manage keys, it still requires
> > system software to manage the IDE capability register block.
> > 
> > Add register definitions and basic enumeration in preparation for
> > Selective IDE Stream establishment. A follow on change selects the new
> > CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
> > both a point-to-point "Link Stream" and a Root Port to endpoint
> > "Selective Stream", only "Selective Stream" is considered for Linux as
> > that is the predominant mode expected by Trusted Execution Environment
> > Security Managers (TSMs), and it is the security model that limits the
> > number of PCI components within the TCB in a PCIe topology with
> > switches.
> > 
> > Cc: Yilun Xu <yilun.xu@intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > Co-developed-by: Yilun Xu <yilun.xu@intel.com>
> > Signed-off-by: Yilun Xu <yilun.xu@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> This has been sat in my to read list for too long. Sorry about that!
> 
> A few trivial things inline.
> 
> Jonathan
> 
> > ---
> >  drivers/pci/Kconfig           |  14 +++++
> >  drivers/pci/Makefile          |   1 +
> >  drivers/pci/ide.c             | 100 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h             |   6 ++
> >  drivers/pci/probe.c           |   1 +
> >  include/linux/pci.h           |   7 +++
> >  include/uapi/linux/pci_regs.h |  81 ++++++++++++++++++++++++++-
> >  7 files changed, 209 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/pci/ide.c
> > 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index da28295b4aac..0c662f9813eb 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -121,6 +121,20 @@ config XEN_PCIDEV_FRONTEND
> >  config PCI_ATS
> >  	bool
> >  
> > +config PCI_IDE
> > +	bool
> > +
> > +config PCI_IDE_STREAM_MAX
> > +	int "Maximum number of Selective IDE Streams supported per host bridge" if EXPERT
> > +	depends on PCI_IDE
> > +	range 1 256
> > +	default 64
> > +	help
> > +	  Set a kernel limit for the number of streams. The expectation
> > +	  is that the platform limit is 4 to 8, so the kernel need not
> > +	  track the maximum possibility of 256 streams per host bridge
> > +	  in the typical case.
> 
> Maybe suggest why a kernel might want to limit this?  Testing only?

Yes, that is the only reason I can think of to mess with this value.
Updated the description to:

    Set a kernel max for the number of IDE streams the PCI core supports
    per device. While the PCI specification max is 256, the hardware
    platform capability for the foreseeable future is 4 to 8 streams. Bump
    this value up if you have an expert testing need.

> > +
> >  config PCI_DOE
> >  	bool "Enable PCI Data Object Exchange (DOE) support"
> >  	help
> 
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > new file mode 100644
> > index 000000000000..98a51596e329
> > --- /dev/null
> > +++ b/drivers/pci/ide.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> > +
> > +#define dev_fmt(fmt) "PCI/IDE: " fmt
> > +#include <linux/pci.h>
> > +#include <linux/bitfield.h>
> > +#include "pci.h"
> > +
> > +static int __sel_ide_offset(int ide_cap, int nr_link_ide, int stream_index,
> > +			    int nr_ide_mem)
> > +{
> > +	int offset;
> > +
> > +	offset = ide_cap + PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
> > +
> > +	/*
> > +	 * Assume a constant number of address association resources per
> > +	 * stream index
> > +	 */
> > +	if (stream_index > 0)
> > +		offset += stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
> 
> Is stream_index ever < 0?  Doesn't look like it.  So why not do this unconditionally
> as it doesn't do anything if stream_index == 0?
> 
> Better yet, why not make all the parameters unsigned given I don' think any of
> them can be < 0

Yeah, they are already all unsigned in the caller, done.

> 
> > +	return offset;
> > +}
> 
> 
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index ba326710f9c8..90affa69edb0 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -750,7 +750,8 @@
> >  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
> >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> > -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> > +#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
> > +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
> >  
> >  #define PCI_EXT_CAP_DSN_SIZEOF	12
> >  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> > @@ -1220,4 +1221,82 @@
> >  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
> >  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> >  
> > +/* Integrity and Data Encryption Extended Capability */
> > +#define PCI_IDE_CAP			0x4
> > +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> > +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> > +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> > +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> > +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> > +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> > +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> > +#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Cycles Support */
> 
> Not sure we care but it's called Requests Support in the 6.2 spec at at least rather than
> Cycles.

Yeah, that's my parallel-PCI upbringing showing. While the PCIe spec
still says "configuration cycle" in places "configuration request"
dominates. Fixed.

> 
> 
> > +#define  PCI_IDE_CAP_ALG_MASK		__GENMASK(12, 8) /* Supported Algorithms */
> > +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> > +#define  PCI_IDE_CAP_LINK_TC_NUM_MASK	__GENMASK(15, 13) /* Link IDE TCs */
> > +#define  PCI_IDE_CAP_SEL_NUM_MASK	__GENMASK(23, 16)/* Supported Selective IDE Streams */
> > +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> 
> If we are going to start using __GENMASK in here (which I'm in favour of) maybe we
> could use _BIT()/ _BITUL() from uapi/linux/const.h as well.  Counting zeros is annoying given
> the spec is all by bit number.
> 
> > +#define PCI_IDE_CTL			0x8
> > +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4  /* Flow-Through IDE Stream Enabled */
> > +
> > +#define PCI_IDE_LINK_STREAM_0		0xc  /* First Link Stream Register Block */
> > +#define  PCI_IDE_LINK_BLOCK_SIZE	8
> > +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> > +#define PCI_IDE_LINK_CTL_0		   0x0               /* First Link Control Register Offset in block */
> > +#define  PCI_IDE_LINK_CTL_EN		   0x1               /* Link IDE Stream Enable */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR_MASK __GENMASK(3, 2)   /* Tx Aggregation Mode NPR */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR_MASK  __GENMASK(5, 4)   /* Tx Aggregation Mode PR */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL_MASK __GENMASK(7, 6)   /* Tx Aggregation Mode CPL */
> > +#define  PCI_IDE_LINK_CTL_PCRC_EN	   0x100	     /* PCRC Enable */
> > +#define  PCI_IDE_LINK_CTL_PART_ENC_MASK	   __GENMASK(13, 10) /* Partial Header Encryption Mode */
> > +#define  PCI_IDE_LINK_CTL_ALG_MASK	   __GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
> > +#define  PCI_IDE_LINK_CTL_TC_MASK	   __GENMASK(21, 19) /* Traffic Class */
> > +#define  PCI_IDE_LINK_CTL_ID_MASK	   __GENMASK(31, 24) /* Stream ID */
> > +#define PCI_IDE_LINK_STS_0		   0x4               /* First Link Status Register Offset in block */
> > +#define  PCI_IDE_LINK_STS_STATE		   __GENMASK(3, 0)   /* Link IDE Stream State */
> > +#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000   /* Received Integrity Check Fail Msg */
> > +
> > +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> > +/* Selective IDE Stream Capability Register */
> > +#define  PCI_IDE_SEL_CAP		 0
> > +#define  PCI_IDE_SEL_CAP_ASSOC_NUM_MASK	 __GENMASK(3, 0)
> > +/* Selective IDE Stream Control Register */
> > +#define  PCI_IDE_SEL_CTL		 4
> > +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR_MASK __GENMASK(3, 2) /* Tx Aggregation Mode NPR */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR_MASK  __GENMASK(5, 4) /* Tx Aggregation Mode PR */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL_MASK __GENMASK(7, 6) /* Tx Aggregation Mode CPL */
> > +#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> > +#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
> > +#define   PCI_IDE_SEL_CTL_PART_ENC_MASK	 __GENMASK(13, 10) /* Partial Header Encryption Mode */
> > +#define   PCI_IDE_SEL_CTL_ALG_MASK	 __GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
> > +#define   PCI_IDE_SEL_CTL_TC_MASK	 __GENMASK(21, 19) /* Traffic Class */
> > +#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
> > +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 0x800000 /* TEE-Limited Stream */
> > +#define   PCI_IDE_SEL_CTL_ID_MASK	 __GENMASK(31, 24) /* Stream ID */
> > +#define   PCI_IDE_SEL_CTL_ID_MAX	 255
> > +/* Selective IDE Stream Status Register */
> > +#define  PCI_IDE_SEL_STS		 8
> > +#define   PCI_IDE_SEL_STS_STATE_MASK	 __GENMASK(3, 0) /* Selective IDE Stream State */
> > +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> > +/* IDE RID Association Register 1 */
> > +#define  PCI_IDE_SEL_RID_1		 0xc
> > +#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 __GENMASK(23, 8)
> > +/* IDE RID Association Register 2 */
> > +#define  PCI_IDE_SEL_RID_2		 0x10
> > +#define   PCI_IDE_SEL_RID_2_VALID	 0x1
> > +#define   PCI_IDE_SEL_RID_2_BASE_MASK	 __GENMASK(23, 8)
> > +#define   PCI_IDE_SEL_RID_2_SEG_MASK	 __GENMASK(31, 24)
> > +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
> > +#define PCI_IDE_SEL_ADDR_BLOCK_SIZE	    12
> > +#define  PCI_IDE_SEL_ADDR_1(x)		    (20 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> > +#define   PCI_IDE_SEL_ADDR_1_VALID	    0x1
> > +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK  __GENMASK(19, 8)
> > +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK __GENMASK(31, 20)
> > +/* IDE Address Association Register 2 is "Memory Limit Upper" */
> > +/* IDE Address Association Register 3 is "Memory Base Upper" */
> 
> Why not move this comment down one line? Match where the def is.

Sure.

> 
> > +#define  PCI_IDE_SEL_ADDR_2(x)		    (24 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> > +#define  PCI_IDE_SEL_ADDR_3(x)		    (28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> > +#define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
> > +
> >  #endif /* LINUX_PCI_REGS_H */
> 



