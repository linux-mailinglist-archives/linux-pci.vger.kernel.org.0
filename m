Return-Path: <linux-pci+bounces-33323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E3B189FA
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 02:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACE51C25576
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 00:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA21254262;
	Sat,  2 Aug 2025 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mswJWB4z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF14182B4;
	Sat,  2 Aug 2025 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754096085; cv=fail; b=GgGp8jgjpkLubE/RupwZecSpLmhaorgTPbe42hnPKm7mNOF35puRPnOOfh0GE9Bf2Hj+4vGhbRpMvMfsmuIpKqY7i43vv1Zz2zG1LT2chXuaudbGdgKULq9xLgfDUbsAk5a0zpvNqCCGkulh+QbC/xZnfmOU5thBXDCEilbFyWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754096085; c=relaxed/simple;
	bh=cwW4oxYRL1nZ8DqEOQ9iDjTZYVoxy4ESLryQdipXPxA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=cMxXmE3R+NH+gdLz43q9r82jWQJfzEeWXLV/7ozqWR0Kh/pxpBVyKfJbjCl+EoaJ9RjhOtmrmyM9K/e8ju5fUnRGfSsZdQoQaTI1wZTSUKzYEUF0AIdye7mWYd35PudEZiquLKf8WijYUmkohgiLyynXpWVgB+tsGMLMQFsr9v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mswJWB4z; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754096084; x=1785632084;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=cwW4oxYRL1nZ8DqEOQ9iDjTZYVoxy4ESLryQdipXPxA=;
  b=mswJWB4zGytA4MH31a5izh9akKiWVrTXO6ZTRsu8Mh+YJRXlezKVV2D1
   GKEx5wcxmgVTnlQgYp/PS617gTA6hGliwEYNoYo2VDZ5lSjqtvMqcTzOy
   CY9V7Z+/7fTjyUsX6EGIpUUmh2nsGD0wO0/h6jytHP0D89AJFtqwGkzCx
   7U7/Ra1vHawi/RqIhCe22TBjMwrxw1EZagjXxstME1Up4F9OtMBjrTOmd
   msCLvtJVOAPmHRyyNEtf3XDbXeLtMSCxX75kg428xHeyOmjp7PfcDeyES
   62GwMqkcGEoIenCVMWS+rCQ17Tc5DlT5XCIxztvxC9SJByRZbV3AaSFqL
   g==;
X-CSE-ConnectionGUID: KuA62HVfRu+pqCZllI5U2g==
X-CSE-MsgGUID: rsvKuDruQYWb77NYArGOww==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="67143052"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67143052"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 17:54:44 -0700
X-CSE-ConnectionGUID: NmdZdt/cTlW/PylpauNhPw==
X-CSE-MsgGUID: uLxaLaEdR0maWkx5jzr50Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="167960049"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 17:54:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 17:54:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 17:54:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 17:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQ6E2CicHTMVi9IC7X7tNxUeF/ZJ94A9VKjqf4Q791hqlYJPyg8RRjfRsACvhrpwrxs7x367FTBUFAqF/VdI99xZ7FYuPAgj9hGnxZR9p+xTSiU9uOia77GqL0ctDsu8jo+StXWj2NnvHF3DzjQjPgKZF2yoM/2ARjR+N2at5fwYhCOWyUjeJVhT55/k9AgWi54/Aic+eCzxdDutYzM//e+XDFmrdHnpygIAbborGCQ4d2juewwKsqBQqCowf9w1S494E4/UKRe2iwP+OLhR8M0nENJ8uzQjOuPJsNhRyQdgPU7CmqU3zvhB0vI4/aqX1kgq1TIZQN7eqBQVsKxwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE/DVRoC3HJpPtd8+7gR4h1KhvhrT0u+L3e0agpYTvQ=;
 b=neiiKBHTpd60n1Rz0t/HwWg5AZhRmsBqFw6V8/3GmeAaG0G2kWCiAKkoPe9uihdqbpOw9IGGjZSfEkq3MX9shHL7hN1w62v6Y7SlOW/twOHE81PlDvYXkVvXYPnM4u7frj02Cjq+Mgd19Os0tx6duzyP0oZTqgoq8XeKUBsw+kwj2tNkky4+BiKtXw+dqOM+fGkjYLFXedux/BQz+mhFsrGEQFh2BOj5MNuZJ//+S8DwtYgl2Hs4XEltrIansGprikuikUjWZJGIjSb/VzbKAhy2hPvXAguWVMPWXSPOnnF522xyPG1194OBx3pwRkvGX20XrVAP6OhRZN+azFtfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Sat, 2 Aug
 2025 00:54:12 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.8989.013; Sat, 2 Aug 2025
 00:54:11 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 1 Aug 2025 17:54:09 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aik@amd.com>, <lukas@wunner.de>, "Samuel
 Ortiz" <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	<gregkh@linuxfounation.org>
Message-ID: <688d61b1c4c8c_55f09100f4@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250731121133.GP26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250731121133.GP26511@ziepe.ca>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a70455-65d4-41ca-c80d-08ddd15f1848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDkzUXdrT3ZISC9kdWVMaXZhMXAwekhJMlc1VmxUMkhEK2xYT2xzRnpuTWZN?=
 =?utf-8?B?YXMrRndlTEN5K3huVmVTZkZMeWdHYUZEbjB3STd4T2VqTjZmTjNWTDlKc25S?=
 =?utf-8?B?TGxzeHdHNUdTZ0Z5Mk1ORzRPams0WXlRU0xCbW1FV2E5bnYvQkxDeUNMbStW?=
 =?utf-8?B?TWNWb3dCcU15dUlVTzNudGhmYk1SZXNla2RDbWNMNWlXVHBxb1UvUnZOa3pG?=
 =?utf-8?B?UFQ5UGlvWkhEc051eWl5TC9KRUV2b3ptYmloeXphNFFZeXRPRVJId0NoVThl?=
 =?utf-8?B?TnVNYk9YQXRSOS9sMlFlMmF5RG92RDJiL2cxWm5rSW95ajM4VlMrZ1hOL1p0?=
 =?utf-8?B?NjRLdlNqaDBBTWZLcS9vbHY4bWYzczRNMy92OXg0VXFONzYyY3JETEs3Sjdp?=
 =?utf-8?B?YUlEYlNQbUVhV054b095blgwRlFTd2NHQWEwaVZjSm0xRmEwOFVRaUpGSnVR?=
 =?utf-8?B?eWZmRllGam1FdmprNmF1YUJnaEsxNFJGSWx3R0RKd3BrVWdra0dlQ2xhTG56?=
 =?utf-8?B?VERPZTlEcHArRFV5K3NwOElCZHA3MW51NEFIa0JreEgzSStmbm1xR0lnT2NB?=
 =?utf-8?B?cXFKK29zcWwyK25vVjRPdXo4NlU2LzRMN2NYWXg1bXpVVlJQNWlHd1UwekdE?=
 =?utf-8?B?OU00cVZIOXVFbFExMm4wbVp0Vktod2hPakx2RHRTZlVmMVBrOWM0WW4xRGhr?=
 =?utf-8?B?MTZOR2UrRlBXemFSUHQ1UGxCNWV5bjVySDduOWlTVWpNUWI4Sjk4MlBnZmNC?=
 =?utf-8?B?RTNFL04wU2YwcElaNUdmWmlnTi82dnE0NUF6YTQ1ZXdYNlBBUmpFWE5HbE1j?=
 =?utf-8?B?Z1FHcWRCVGlyUjMzbzZ5THZoWE5NeEVkeDRGaGdIbmxZQjVKejhyS09nR1VL?=
 =?utf-8?B?K2JVZ2d3WUlyaEp6MnBRREgvSlA1bFJsMFVCSXRGUjBTeGtjUkZNNHNhN3Ux?=
 =?utf-8?B?QVNUcVBZenU2K0FCazhCMHdNVnBHaVdNbnZLQnAvVFh3TFhTSEYzNi9nTmxZ?=
 =?utf-8?B?NXJUK3ZvL1gydStSaG9ETTdjVHZTc2VPM3hId3d3bFhTTnZSdWlYWDZUak9J?=
 =?utf-8?B?SlVJdFBOSDhpaDBqVGhUcklvNW5SbGFGcitjSEs4NmNTZHN6K0k2aEZzMzBD?=
 =?utf-8?B?OFUrSVB4LzNvUzRETUdWMUhMSVdxYm5VZUg5M0hKSHNiaStaU2EzM2FOSWtB?=
 =?utf-8?B?SUFlaEx1YzlRUUNESWdZWVU5dTZSN0pndXNWOERKQ0psS3Q5QnhwdHVyTHN2?=
 =?utf-8?B?UTdBcU5URlhocHl4YWprbWRVOTRjL0Q5cG1Ob2lXaUVsRHlCUVIvMmlvNkdP?=
 =?utf-8?B?MXc3MFNVK0p4UklZZGRwQnM3MnZpeXA1cms0M3NUR0xkT3orOVJQbS9vWkN3?=
 =?utf-8?B?MkU3QUR5YmJGRmo4RUtDT2k1d2NJa2RLMEwyeVcrSnFQYjl4N2VQZ3ltTHRV?=
 =?utf-8?B?dFZscEJpQzJhVjFTcnc5cnZIYzhwUi8yVWJBRWwzbk5GWjBPbXlDbTBUa1hW?=
 =?utf-8?B?V1FoejlYZzdkNFhxd25UaHRRRmROVUlIMDd5bzdUeUpOSGtpbElkTzNjbUIr?=
 =?utf-8?B?bEJZZXpGeDNvVGZmQ0NOTEZVMDUvYU9qc1ZVakpaYmR5WnpVUTQrb2dmWDBs?=
 =?utf-8?B?K2dnUE5hZ2xGdXNDOGNKdE0xTmlvSmJVdGh0Sk04cm9lMENXNGltZnQweEJr?=
 =?utf-8?B?MmVnT2JkY0paenZVZFI5WkVJWUx2Sm9nY0RCem1oYUtMQjN6WXlyYTZpQ1Nl?=
 =?utf-8?B?dks0aTN0Q2FlZE8rUW5jVlNpL09LS2NtdFY3ak9iWmlYd3Q0WFlRUmw2YXZv?=
 =?utf-8?B?cVlEZDNwY283cWZnMXRWNmRQOE9iTGZTcWlRYTFxVmhvYkhuTEs2REJQbmtj?=
 =?utf-8?B?RldjNzYzZnVVUjVXeEhVYzRTQXNCYThYT1hKN21LcFZvc1dMN0pOSWhvUmpn?=
 =?utf-8?Q?OfbRhV1A/bM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bksxR3FmOE1ZNDY0K0tyY1I4cjk3bHhHZ0tMMG0xNFRmS3dZSmEzZjhwaUhz?=
 =?utf-8?B?eis5c2g2ckJvTU9PNXB1Mm52OVZnOHhZclNrUGUzUUNOaHlBUDBua0JJSyti?=
 =?utf-8?B?Zld2MVNvWGQ5V1d2clZaVnNuZnREajhocSs5S3AvODNoUFVZTEVBQmplaWFQ?=
 =?utf-8?B?OGs0M0xzeFRvZjk2MzdoNEFLaWRPNS9tVFdsNzdFUGlLeG9zR2UzNlVkL3hX?=
 =?utf-8?B?dk5qYi9QaE1rT0hlOWZTVHp4di9rQXBJdGhEeTJkYzczVFJKWEVlbnQyKzli?=
 =?utf-8?B?dEI1bXU4SFhjTXV1L0tqazlQazdhaEZMWkc0OHFxWjJJNHlZaGplTGhJTW1G?=
 =?utf-8?B?NU9NUWZjaVY5K2NXL2lxZkMzN0w3L2J4RU5rL1orWDVXL1M1eFc1WE94Y3NW?=
 =?utf-8?B?TUlwZ2wwUFltejBqZG5iMUxPU2VBL2RNQkNIcnJXdlJ4Y0NkdHZ3dVRMRnI2?=
 =?utf-8?B?L2tuMW02d3dVeUJsWm5rWU5nYmUrZUdSMkErNkEvOVkxVHF5Ukl4b20wUlhQ?=
 =?utf-8?B?TDgrRXBpL0NhbmFKeTQ4VUVGWWtKWDJrTUVGaEJoTmxjd0tBbm5aSkV3NzBz?=
 =?utf-8?B?VkJzUHU5MUhaeElsdXNzNStGUUZiZEFjT2dvNUJYUWdLdldyMTAyRzhSaXpH?=
 =?utf-8?B?djN5L25VQTA4RFdMVXN4L25WQW40YVVadnFTYXdsRGMxNUJLYXJlVmJuTFN2?=
 =?utf-8?B?dUhBaUNXOWRVWm41N1ZCVmtWZjR1R2ZzR2NDRjVoOEI4b0ZkTm5xUGdMQXNX?=
 =?utf-8?B?cFRUbVdBaS9VZHFhbkthMytLZzl1bi9WZ1FGMk8xNlo1ZzNISDhhYW1WR3hk?=
 =?utf-8?B?eDhGTEt2QXorc2hROU9id0p4YTlQazBlMndwZ21hLzJsbk5WbjJzSWR4bVNV?=
 =?utf-8?B?RitBeUR4KzNwUFJMazNnSkxaVVNsWnV4R3BhaHNDcEJuZ0R0eDBKNUJVSGZq?=
 =?utf-8?B?aTlMeTQ3MHBwYXZ1RGV2T1NMODhCRW11ZHJtVXFLMk5YMGtLWmlXMENaNUNX?=
 =?utf-8?B?b3Q5MktVOG1uQVlreThDMFkxalBneElQNVJOSnZwRVk4NlVTVmJGeVprdUR4?=
 =?utf-8?B?RnZCdFJJWVVERU00VEtra1kxdmxzY054NkFEdjUvR0NjUnNvdFpQRU5oOFE1?=
 =?utf-8?B?VkxOVkZCbktwZjcwMWpGcVorSW1WTU5sVDZHcURIck4xZ2NnaEhXZlB2RFNX?=
 =?utf-8?B?L3BDRGN0blFKRmg0MU0ybmV4QzlieHhLU0J5MGdTM210aXc1WGhvckIvQ1dm?=
 =?utf-8?B?aERUeG00MVZtU2RCbW9DQTc3dnVSbWVBMC9oWGlWMDFaYy9YSWxVWHZENlRM?=
 =?utf-8?B?T0pRZ2dxRzA3SEJ4UW5XTGpBbktYenU1elFNRUxMOXdya00wbm5QN2REUTBK?=
 =?utf-8?B?bndIU3ZWMkFKb3dDSDVLeXA4Nmh3VytLZjlTdTNVanVaUWpITktUTk5TSFFP?=
 =?utf-8?B?aGs5UTdPU1prK0grT1hia1BIbU5oV2VnZzB5V0JMdlFTOWx4SFhVS240MGFx?=
 =?utf-8?B?b1p1N1RvdFJUM2QraVpzOHlWRkl1SlpZVnpKQ1lGMEtQY0h6LzhxUmtWL0RW?=
 =?utf-8?B?Ums3eDVGUGlTSkJnNithVVpjaTNqUWFUdTA0Qi9zV1EvOUxLWTVNUkF0KzRv?=
 =?utf-8?B?WURNU0VVVDdFaVg5YnQ0N011MHNtU1ZMMUZkMEY4REhhMEEwSXlkZlBHOVhz?=
 =?utf-8?B?MklTUzBNbzFER3RYMzVYVW42NnJ5aXpva0hBQk5mV3BQZ1F5eWNMWnliUDVB?=
 =?utf-8?B?T2JSaXBJUFhFUElheHMrcE9TMTc4d01vWm9sQjdUdkgwTjVsVTFYcmtmQ0FW?=
 =?utf-8?B?b3F6dVdGZkRsVnV0QXN0a0poSEpBTjJOVE5PSkhNN2cyc01pMW43VnA0NFpU?=
 =?utf-8?B?R0NHcHZpZHc3U0V2MTVWVkNsdUs0dmpQeDZwRWRZbWxaelNjMlNwR1FwRHdm?=
 =?utf-8?B?S1BrY0E0b1BkSzdEemR5UzlMZFR3YWhUK1dXQi9FMTJZOEk1RDJjenpDazhi?=
 =?utf-8?B?NitQazdQa0dDZW9XTXluRXJOL01iMXZxTldCQndPUEkwVm1sQUMzM3lxckxr?=
 =?utf-8?B?ZHhPLzgrTHJuVVNDSnFBY3VzdkRRMVFWMTgrdU11bVJQVnhWaTcyRWhKeDJE?=
 =?utf-8?B?RVN6K1Nra0NOYzQ3REQ4WWR1SHdMVHJFMmFtMmFFR2R5UnhReGloRmxOZU4w?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a70455-65d4-41ca-c80d-08ddd15f1848
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2025 00:54:11.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yWLQNOo1c01qyZEvxe5q/YgDk0YDPJMKuXW9qcbkCh6rylZ9cSg9dRLjP8Qqt/2HlgqXo1+0T8wP2F+DrnmMnQBVd3InyZ5ykQP4N3Fxi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Wed, Jul 30, 2025 at 11:38:27AM +0100, Jonathan Cameron wrote:
> > On Wed, 30 Jul 2025 14:12:26 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:
> > 
> > > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > 
> > > > On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:
> > > >  
> > > >> > +static struct platform_device cca_host_dev = {  
> > > >> Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
> > > >> platform devices being registered with no underlying resources etc as glue
> > > >> layers.  Maybe some of that will come later.  
> > > >
> > > > Is faux_device a better choice? I admit to not knowing entirely what
> > > > it is for..
> > 
> > I'll go with a cautious yes to faux_device. This case of a glue device
> > with no resources and no reason to be on a particular bus was definitely
> > the intent but I'm not 100% sure without trying it that we don't run
> > into any problems.
> > 
> > Not that many examples yet, but cpuidle-psci.c looks like a vaguely similar
> > case to this one.  
> > 
> > All it really does is move the location of the device and
> > smash together the device registration with probe/remove.
> > That means the device disappears if probe() fails, which is cleaner
> > in many ways than leaving a pointless stub behind.
> > 
> > Maybe it isn't appropriate it if is actually useful to rmmod/modprobe the
> > driver. 
> 
> Yeah, exactly. Can a TSM driver even be modular? If it has to be built
> in then there is no reason to do this:

For example, CRYPTO_DEV_CCP_DD, the AMD PCI device driver that will call
tsm_register(), is already modular.

> > > The goal is to have tsm class device to be parented by the platform
> > > device.
> 
> IMHO the only real point of that is to trigger module autoloading.

Right. For TDX, and I expect CCA as well, the arch code that knows that
PCI/TSM functionality is available and can register a device, may be
running too early to attach a driver to that device.

I.e. I would like to just use faux_device, but without the ability to do
EPROBE_DEFER, for example to await the plaform IOMMU driver. It needs to
move to its own bus so the attach event can be handled at a better time.

> Otherwise the tsm core should accept NULL as the parent pointer during
> registration, it probably already does..

Yes, NULL @parent "just works" with tsm_register().

However, I expect all tsm_register() callers to be from modular drivers.

