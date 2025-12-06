Return-Path: <linux-pci+bounces-42716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72593CAA0EB
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 05:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06EFC3162C63
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 04:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68D02248B9;
	Sat,  6 Dec 2025 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8JuRDtg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F62BB1D;
	Sat,  6 Dec 2025 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764997024; cv=fail; b=LuBLJs0TAK/SsvVapadKUACHCAELugwuEy592xDKBF5Nm8hl7jsj+STeFEqgOcM9QSDUDBsHCxmDdPb1B2HMjOs8ikbSpKDNwhnWb7BSs2x9zufFVa1cBCbvXO/+fHw6tJp4BAtY7EDKYL3RESQzIfljsxNppbi6UpAOPVrLiUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764997024; c=relaxed/simple;
	bh=skSLs5r6fh7MV1B42zcRCa9GTVl4aDp+F7v3jPVclPI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=M5s1GaPcfh9+dK85Ogxw97C0i0/BKle3khU3mSLcogzSp61FdHYNncsm/74P/pDtDU39OF/Cjr6zALCjf8FMpm71vFVX/N/DMyU5h/5Z3GvPp9yh0b9YWjryEkUccjxZOXCv1F8ejIrpMWpBdAdXeU92dfq3FZJ/kvEQKk6cuJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8JuRDtg; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764997023; x=1796533023;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=skSLs5r6fh7MV1B42zcRCa9GTVl4aDp+F7v3jPVclPI=;
  b=M8JuRDtgs9eDkn0iQngtF963VtENuWEhXc1kBIMPdRgeBrf02l3fPR/r
   Q+XBQ/mCl+j63fmMhvrY8pD5odbCmocY28r/DCMGGnge6GSP9uRx/gsQy
   TezU5Ja3j/o1c8h4s+7C9f2YnAc2M1bSF+Val0mXy2AYV1qbP2j5I32a6
   AMXruC98Ms3prqYR3jyRONN4qcMWQSPA6NPk/j2iXz0aHx2AW9/DYjpyj
   OKfcHVLeqslyUC+iuTfJNopX071aIaFLNXQcI+pPQ3J7EQ+QbG5m5ib3t
   4pvO2FzuYW4L5NHAtqNW5qFO48JVVCxT5dAFnutxFLDP/ns+Lrf/kes2v
   g==;
X-CSE-ConnectionGUID: A1Ma79lNTcabNqjYD+pX+A==
X-CSE-MsgGUID: jIr3NgVIT4yGgvXZRg1+Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="77651181"
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="77651181"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 20:57:02 -0800
X-CSE-ConnectionGUID: gXLDDd9WT06Fkaw2adK+9Q==
X-CSE-MsgGUID: h72HoQhxTi2XNrOtsPTkDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="232834480"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 20:57:01 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 20:57:00 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 20:57:00 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 20:57:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1yVAhlBQm970RKrgz97LzN6CHOcoclm2FK5d4b5H1OfT++nmbSXf6qcuIqvKSINzZNfHflzVZuq9ecURpLQFlQyU429vJ8U6hPT977e7kxDCaVW/6/TmJzRbncZLL2IceDHnVA8BGuQENtcI0bokR1QyVBODodKZKj0B+JiLTDNfY72pRvdnIlw3jTa2vX47W8x6FD79gNp6DwqJgJugkrYI8Y+eKs+8yqmCF37po0C4mRywELI5Vu3aaZoRk59T7RgepGrXlUh+mYruVtOMDXeVIaIqAqtM5h4Y/vJmFCksBBtPvDPrG8mwNByhIK3Vof/B76adfBjiTIBuwRkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yxAg82sIXL3CbcsTPe7JyMG7etY6Cpr2gTlzRUoVok=;
 b=R46EeOsgFP/iqm+1bkXhnFHBmY8UvVB2jydcmrK+631BPi5djBINefOtNpwZ3F/EVZERUV5GVUyIvSJCL5MYuB65uETm+i7tnJk6Mz0em87lFrDIZ/j9N0+1cZ9jJKgToTSuR5tWJCnPebPkYO/kQZG3CosvnpGRuqntgwdMpcctSp4w1g1h6uXhsqKV/MSdKJ7pFy8aOxFe/8VVGPF6C8tfA9LR26cie6U7/hWPgNnFuZ+jpAFNf6P2YOpkB8vvHLHo//WksQtNxpCjPMutAQZldkSu7PvpzARhf6law0GnRBABp7Z8yjqgTnymE5d62Q09lwsvK6U3vuUm9+cTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4568.namprd11.prod.outlook.com (2603:10b6:208:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 6 Dec
 2025 04:56:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9388.011; Sat, 6 Dec 2025
 04:56:53 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Dec 2025 20:56:52 -0800
To: Bjorn Helgaas <helgaas@kernel.org>, <dan.j.williams@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <6933b7946874f_1b2e10067@dwillia2-mobl4.notmuch>
In-Reply-To: <20251206015613.GA3303517@bhelgaas>
References: <69337bc4d1943_1b2e100a9@dwillia2-mobl4.notmuch>
 <20251206015613.GA3303517@bhelgaas>
Subject: Re: [PATCH v13 01/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 73049daa-7714-4ba7-723c-08de3483e001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTJ0bms3S0dtVTlJRzNSUXhLa0pEVHhYajN6dzRFM0M0anRWSDN2aTZEWGx3?=
 =?utf-8?B?bk1MRUlXS2t4bE5TU0k5bEJmNVM1MVpFTkVRc21mQU96Zlc3ZUtqbFowVHhj?=
 =?utf-8?B?Si8rMGZIb1BvZ3kwcjZvZ2l5OEJHTjZDS1FKZUxaOW55NiszTGt3eVU5OTFU?=
 =?utf-8?B?Q0d4a3NJY3VZRVFPdlhoL0h1NEIxclZ4QXZoRFVlaVBpdHNNRlhIb2g3cHRS?=
 =?utf-8?B?cWM1OTYvVWFDN2ZTejFPc2xzT2tnaGhCOW5ZcG5TSytldnBXMUtkcUNXYnlJ?=
 =?utf-8?B?c2x4V084MmZhUHgzbWZiaVlUNXNBSzlmNzZMMmQrNWRBZ2Ywb1FhRjdQK0I2?=
 =?utf-8?B?NjgwOWdrOCt5K2dBMmNldHJXdXkrOWpNV2hRQ3Q0dlc0eG5DbFFHVnFZOEpq?=
 =?utf-8?B?TUZocXFRbHFhMVVtTUVhYkJHclMrS0ZkdU9SekV0L1FSOHVtWGlvN2JjaC80?=
 =?utf-8?B?RVpVbkN0dFd2N25zTWZXR3k4NmNoMkIyaXMrZm5lWm1OenZMQUlHTlBJSG11?=
 =?utf-8?B?NXhYZkJMUkNTQXVaYWdUdHhlem5iUEtKeXAyKzhWZGhTdU12STAwM3J0Ni9F?=
 =?utf-8?B?ZWNicWNRbEMrcFpSUGJTL3JWdVRyTnRESDNNZnhMWnlxb1BXa1h1QzFlbUty?=
 =?utf-8?B?UzZ4aTRKUEtPSXVNUXljaHRoaUlqYWQvR3ZFUnRtSmZ5azlGS0ZIRTZPTU1S?=
 =?utf-8?B?bVkvbDhxTGRXVmVZM3JnV0RvYzVlWFprRVhZNTVPOVh0Q0gycmRVMUdRUVVX?=
 =?utf-8?B?Mmp6MHFQMU0zQjBPT3hDOFRST1AyRWhmbUgxQWpRd0FndGhsK3dhV0NWcHRK?=
 =?utf-8?B?ZUdySExqR2s2cER4TXp6U2dMcVJzOHBKcjh2Rm5Sb2hnbFdZTTJGYy9EZUNC?=
 =?utf-8?B?aFFEWFJPK1BLZHUvTWFZS0xDaXZmTis0eUZGOW5qK2E4L2p1RVc5aHRLRE5a?=
 =?utf-8?B?YkFwNGhCb01wdDNCdXU4dWorNERpblpLWjJkWEU0cjFEWnMvRDZWK09NQmNy?=
 =?utf-8?B?RzdQTkx1M1VhV0RocmtkMHhUeGo5T2xkY2MyZ2I5dFNqZTNiYUFhMTd2aW9V?=
 =?utf-8?B?azAyaStOQzNVKzNPQ09hVmZibGFZZ0dyNWp3V3FwVE5pb0ZXa3RYYjVVRG5F?=
 =?utf-8?B?RXd5YVJBYTF5MFVWSnlWc2VGM3hnV3h5Z2FERmN0V2RuamJkMlUwQkN6OHFq?=
 =?utf-8?B?Nnh0ZFFjWG14elQvY3pYaEJlME9jYVpIUGdqRkowaGo5Y29GRHBFNnVtTEM2?=
 =?utf-8?B?NXNWck1Ma25lYS83Q05zZmZVcVZZL20xWEdpWnc0YXBsV2pQUktFUyt6dHNm?=
 =?utf-8?B?WTRXa0p1eEE5a2hxNWhEUHVhQmdxb1NISXVKNW9nNGNFaHRkZHVFNkFycGtO?=
 =?utf-8?B?ZDZVamhHaUNkeTBBdldPOW5RbGt0RXIyeTNYdjAwVzF4azZhTzU5TnZIb1g2?=
 =?utf-8?B?L0tDanFWTXF1WmplU1ZJZE1GV2c2M2VvZWFtNDFGT3pJemYxSnNDS3pzS0dG?=
 =?utf-8?B?bjB4U3M0dVR6ZTB4QnhzOHhNZ3B6ZHZEK0hnTktYbGpkSDRzbi96N0FCS0Rt?=
 =?utf-8?B?ZmUrdG4xUXhJb0VVcXEwT1lmbnFlRHIzQjhWR2EyRkJoY0IwOVdpellKaXFP?=
 =?utf-8?B?WWJ3YkZxY2NqYzIzZmRxbjVlRmFoTUFSL1RGSGNNTzZNcytubFFaZFFNL0Vm?=
 =?utf-8?B?OWcvYlYyMmk4Mmkwa2hnZG5IaGhMMTVYZFlXS2s0UXUxNm1oQU1EZWxYVUNi?=
 =?utf-8?B?TXJjNzUvck1RQzNPbHA2TERyTHNiTmFiNkErMUtPcHpPSHozTE5yOTlBV1p6?=
 =?utf-8?B?UTd1ZU1yRUM3aDNoemhiQ0dkNk96cS9ZQ0RZOGxVYU9kb0N4MFRlZUdlcWFP?=
 =?utf-8?B?bXFnUUVMdDNMaFkvTmlJNFVrcnQzaUNFbDVkRE1PRjYyaVo4N0doOVZoSlda?=
 =?utf-8?Q?8Vb3OICWE9sZQ5XyVzwWSSZXBwwN6BQn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBRbWNwV1dxRXlxNVpjZ2lYOFduWlpPcHlyTnhNNmtURWp5ZEpZRS8xcXhU?=
 =?utf-8?B?Ykl1TEtuWnNFMFBkSHZTRTJJVHltZkpFM2ZmalZwcE1VUWFKYndrWHI2dHFy?=
 =?utf-8?B?SFNneU1VYW1CejJOSmFrU2NuZ2NFWWlnY05EK1o5VU02ak1pbGYrUDIrTC9m?=
 =?utf-8?B?NXgzeW5DUkw2V2tPUXlqTDBqVVZVc3o5K3ZkNmxkVXlKc0ZlbU5vNiszNGEx?=
 =?utf-8?B?blllc1BTYkRoVGRiTnVRc1RWRWE2U1pTTWNLTTZwN2oxR09IMWJsL0kwMkpX?=
 =?utf-8?B?UzNKVzYrV0hBRFNRTmJsUUtmUDlaZFFRSGxOZHpKekVZOUtoNWhjZFNIWndY?=
 =?utf-8?B?c2pFQmVQcnMrd25rV1lOb0FNeDJ3d0pjRGRMK2dVM3daOXp5QTNOQXZkMndr?=
 =?utf-8?B?Y3hDdkROTm5FMFdGam0wOTRmQ3pTWnNSeEYxTE1uaWJ6eTlUWDVxOFZmMDlK?=
 =?utf-8?B?R1k1azdwS0xIcHdic2VXT09Dcy9tQUpyeldacFBzZ1BBRTlNd0tUdTJEUUZ6?=
 =?utf-8?B?eWgxeWkrYVBaUnZPVExuZ2pIeUFDeUNRZ2NXbEJ4dDU5cHN2eHhtMjRsS0pw?=
 =?utf-8?B?NGZwclJudnpJKzl1aDIyNVNlVTF6K215eW1tRUt2blA5YkZHZTFXbjVOYU9X?=
 =?utf-8?B?a2EwNlhmZm92Q0ZEbUI3NW1QN1UrT2tLQkdlVmt0QmQrOUlzVndtTTJNaGYr?=
 =?utf-8?B?RVJUNEJYdUUrWkVBQVd5MERRS2F5YkhXRGFEQmx0RktXZUhGVjRhdVJWVTc1?=
 =?utf-8?B?VDI5TzU0ek1TMytsOG14bXJENlRZaVlGSkJiZFo2OXdhWmVkckVUT054Nmhw?=
 =?utf-8?B?dEhxRXhyWVZUbkFWMlNSV2Z1Rzk3bG15cE5vNE5OcmZuYkUwWFhmQmRhM1Vu?=
 =?utf-8?B?dElXUTkxRzB1K2RKckVCWjJjREVteDYvT2JoeWRsQ3MwMitwb3NCVDg5d1B3?=
 =?utf-8?B?L3VlcDZuMmZiMk9ZRHBvOE5zck0vbFdWNmNoaUxVOEZEcngwdC9rQkN1Vml3?=
 =?utf-8?B?TTJuVDYyd0pUeHBqOHVmb2JwSlFNMjlqQVRkOXRtZDlPVVJCRGxtNXgveUxZ?=
 =?utf-8?B?Rlg0Vm1XSlVNWi9UV2lFN2I2OUVrQWF2NVRsL1JnbENhd1Vka1BXNEwwS3h3?=
 =?utf-8?B?a3VEd1FwSVlVMlJIN1loYk51b1E3bkpqNjZhNms0RHNpUUIra2tWckZ4OC95?=
 =?utf-8?B?ZlkxT1Z5YlhubU9NaFI3RmpaZmpLMVpMcFlpZG9HQ0ViTURCWXpCQnpGdDNT?=
 =?utf-8?B?RXpOeWdjT2x4WElDakxENEFZUzNhbXJGRmlzTTBKWTBRcGg2Q1RSU1hYdUFx?=
 =?utf-8?B?blZqK21NV2lwRHBobTFiUHQ4VTdVMm5aTXVBZ2VRRzd2RnQvZkhaVFhhZ0JN?=
 =?utf-8?B?VTlHWHRYQlByOHN2YWhEbkRVL1N3ZENHYmNqYjQ2di9qZWk4ODFmS1JXRXhj?=
 =?utf-8?B?V2Q3ZnZhTHpDWkhWajNyR01FbUk0QzVUSXRndmZ4TnZZRFhpSFNJeGk1bk5L?=
 =?utf-8?B?YVZDZmxJbXp0ZTlkeEFBRThTRS83NVFJdmhRZGZGMHI4RnVFcGZvMTc0cy81?=
 =?utf-8?B?YWJEQ3dHTCtrZ0hzK2JaVzhGN1lGbkVYYzJvQ0FHandwbWc0Vno1Qll4bWNH?=
 =?utf-8?B?VWFkSzBDN3RmRy9MdkdEZlgvQ3oxRlVtUngzbnZjMHArbmNyR2tUUFdEOXZB?=
 =?utf-8?B?OERDT0VDenhvOTFmbXdXeXFrL1RyVW5wR2lnT2U3ekN1L01TcTBxT00xcHZi?=
 =?utf-8?B?WnlYNUJHMzZjdDJKaEdIWnRnTjNqZTZkd1c1b3FtV1RwYWhjV1FBTDc2RlZt?=
 =?utf-8?B?L3VoU3pmZVdmOVVGMVA1dlBGSUViWXI2Z01FSGRkaTJUNW13MFFRS3VjRW13?=
 =?utf-8?B?T0FSWTQreFpvTXVyZlFNb2ZVMGE5WDk2VUY1MHBnUWZnT08zenEzU1FFNTlw?=
 =?utf-8?B?NmU3ODJNYXFqTUtHUDhQOHZJdzNTZ3A5WFZ5STYyWExIWlpyMWJ4dTFnTjk5?=
 =?utf-8?B?NzE4d1ZYUTVZVVJCbGQ3MEEzRE1iSG5IVWc5T1FSWXR0R1N0bDQ4aHJqd3lZ?=
 =?utf-8?B?Yk91cFptVXlpYkM4UUc1bHM3c0pLT0lGYnlKYm4vRi9BOGs1LzdpTnF5T04w?=
 =?utf-8?B?UDlTVndZYnUzb2FGVWI3emNzOVlBNU9Ka3RKOFZueVZ0c1BESHZ6WTlJNER3?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73049daa-7714-4ba7-723c-08de3483e001
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 04:56:53.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZEfCrFIhYIJIvI7V+dGdp0tz5lsEuKlfPDCtlUu8Es1OX0GPXL4T+THVPqWvLtK4F7awk+C2fyAkzC8i3wKd5svX0+PsJOP9pSNb3wwhq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4568
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Fri, Dec 05, 2025 at 04:41:40PM -0800, dan.j.williams@intel.com wrote:
> > Bjorn Helgaas wrote:
> > > On Mon, Nov 03, 2025 at 06:09:37PM -0600, Terry Bowman wrote:
> > > > The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> > > > accessible to other subsystems. Move these to uapi/linux/pci_regs.h.
> 
> > > > +#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
> > > 
> > > Looks like a functional duplicate of PCI_DVSEC_HEADER1_LEN().
> > > 
> > > Why __GENMASK() instead of GENMASK()?  I don't know the purpose of
> > > __GENMASK(), but I see other include/uapi/ files using GENMASK().
> > > Maybe they're wrong?
> > > 
> > > Same questions for _BITUL() below.
> > 
> > See this commit:
> > 
> > 3c7a8e190bc5 uapi: introduce uapi-friendly macros for GENMASK
> > 
> > GENMASK() for a long time was not available to uapi headers since uapi
> > headers can only include other include/uapi/ headers, not
> > include/linux/. That commit made some common kernel bitfield helpers
> > finally available to the uapi side of the house.
> 
> So are the uses I see here wrong?
> 
>   git grep "\<GENMASK\|\<BIT\>" include/uapi/

Yes, but the build failure for userspace can be mitigated if it provides
a replacement defintion. For example, the project for CXL
user tooling locally defines:

util/bitmap.h:34:#define BIT(nr)                        (1UL << (nr))
util/bitmap.h:31:#define GENMASK(h, l) \

...to supplement the missing kernel definitions, but those predated
2023. Paolo solved the problem globally with 3c7a8e190bc5.

Otherwise, userspace projects that do not already locally define
GENMASK() but include uapi/pci_regs.h would start seeing new build
failures when they update kernel headers.

