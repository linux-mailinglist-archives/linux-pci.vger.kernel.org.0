Return-Path: <linux-pci+bounces-41199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 307D5C5AF3C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 02:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCE0F4E5327
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869822566E2;
	Fri, 14 Nov 2025 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WguQTuCZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53C2550AF;
	Fri, 14 Nov 2025 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763085092; cv=fail; b=pS141H0xvy/zTPDfWKTCJXvvrS96JmpJJCCRcZTmfcpShux3V8mNlWTun8ARgdEByUwr+afBcOl60vTHMYI0Kj01TCrJ+g9CUPCd05UgDj5KeZmxwIDpC5rd/1sX3zvetEEMFpyM6ngxD2r9COVF81r/KAZSvP0h1hlRi+iBd14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763085092; c=relaxed/simple;
	bh=MsCeXZ7JvDrHnF6/HYLiTXv8TdE4/viALgA+87HMRak=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=eK4d89U9TfDBzJZ775ZgoQdRqAfFpAWrcrejhifB0/XQoUlI76rF7AdKXA+xosRHpySZRSjw3T/z7r5VialaMwx9R83TkYV6LL7KCtj/LSZQhXZIILMco3FqIn8jprtZw4AG22QwCOa9ue9OEky6S5FOQMvXxM2004IVXxvYjxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WguQTuCZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763085091; x=1794621091;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=MsCeXZ7JvDrHnF6/HYLiTXv8TdE4/viALgA+87HMRak=;
  b=WguQTuCZzSkGjsbpiKdcg1BkY9gEOOCuoRG3VcbsK7AwJKZUC0wRsmUl
   HtQf3C1tmz2B1uL8RtLC9B0zvOZGn4mJ8g8T8E77gn/sVIOVOoFCFFsSU
   a1gqtr+X8QURYy6Y6WuYLSiNEWAtHFbzUZScETaUSejqX7I79thg5wLTy
   HmtTDrb6CE79lgW7hB2lDMZUKa6HJ8C3uMG4WWHDJyFKuRq0Y2zc5s9ZQ
   dQ2VPXgz3V1nWwT9nzcbWVEgJpWyX8e21a/RoQhkSssk6LCyXCUcIeip6
   FQq95oJT8Dbqm+T9kifXwowsMjvDISmqZ7M49eanwceHDCnlzkPHzl5hU
   A==;
X-CSE-ConnectionGUID: mXG44eYDQkSRL5Im95OKfQ==
X-CSE-MsgGUID: mdIij8ljSf+HS/A7zEv/Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="64382331"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="64382331"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 17:51:30 -0800
X-CSE-ConnectionGUID: UtCzHglOQr+J5WfimHoPbg==
X-CSE-MsgGUID: 7o4S7PPtRFq3cU7/2bvBeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="190426278"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 17:51:29 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 17:51:28 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 17:51:28 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 17:51:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=migQSjfyIOmYVN8VIVP6AaTSkNdz4yUfxTMh3KyFk/oFvW677aKeXh6mpl4GgBjUVvWfrJ3VwCS4GwV+1RLA3DQxQVU7h5tTA/JbYvvR1HQWgA1vVtsKNLpi9O1dUw9v0Pu3Bl+FqlVdzFq42pYYh4ERQ8TBb3QMUb4Kd9xOxUni1C/4mGIarCAiQg/zgZOs/NNEACQ9JKapdaj6+TzBDgpfypF9xpJyFO9QjulDmHRh+9gIX/G+ZRm89iFT/hjDLX2CmkYbuttA3O97lVRuGrel0o5f+6XwGtuvMYBUIj8vNjOyw63D1pe3xB+ix7yXawuujSoHLuSQdOn+KNMrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPnbclblpYKhvZxGVR4NqLFDRj4j08OrDud4LhA3L1I=;
 b=KcOHPcoEUn9j+Rjvp3vNlTRTmz/T92DQzjFQ/hArqF4aATAfzXfIrIgyEMB3WEINHLbAc8MtGPvhouwRuhZpl54Vrmcp96tH5OKPXZCUPT75+IQAvPfSjYAaAhNCZZklw4cEsJdzIvp1E8O1Lz388bgwKlw8+yFYH43lSXQdzQVwgq5SKBWMNWVlxa2h3OQ/7Ae3YRTHTa4i2+ZIzoWeUKmHSB2TYzEh77XYS/p4xTTPnP8R8TALu4WzwP7dxoDExUTcBqIxR7nE4P8Wt8n51BI5wFdiendnSZ9T8pKH5RS/BNMJc5LXngfWeS0CSAJ5zjyUWvgWRu7QtEtA2WLEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 01:51:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 01:51:18 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 13 Nov 2025 17:51:16 -0800
To: Alexey Kardashevskiy <aik@amd.com>, <linux-kernel@vger.kernel.org>
CC: <linux-crypto@vger.kernel.org>, <linux-pci@vger.kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Dan Williams
	<dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Eric Biggers
	<ebiggers@google.com>, Brijesh Singh <brijesh.singh@amd.com>, Gary R Hook
	<gary.hook@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Kim Phillips
	<kim.phillips@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Michael Roth" <michael.roth@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Xu Yilun <yilun.xu@linux.intel.com>, Gao
 Shiyuan <gaoshiyuan@baidu.com>, "Sean Christopherson" <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>, Alexey Kardashevskiy
	<aik@amd.com>
Message-ID: <69168b145da7f_10154100fd@dwillia2-mobl4.notmuch>
In-Reply-To: <20251111063819.4098701-2-aik@amd.com>
References: <20251111063819.4098701-1-aik@amd.com>
 <20251111063819.4098701-2-aik@amd.com>
Subject: Re: [PATCH kernel 1/6] PCI/TSM: Add secure SPDM DOE mailbox
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f20e8aa-7278-4b8c-3f00-08de23204d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3FsaGc3eER1Q2gvb1ZrK212UlB3TXkxR3dvVkZLUEhqV2F5WDUrcnFnV0pG?=
 =?utf-8?B?eHZ5ZnZjTXdjb1hZSGkxZnFDRUtEZENwcHA4VlVlMHNBRVY0VHhNRGhMeUpu?=
 =?utf-8?B?VmtCc0ZZblg4QUtrMVg3MVRZd1M4dWVIR1FpVUpLL21oeHpFT0FGZGQ0NnYy?=
 =?utf-8?B?TkNpSnAwOFIxTVFCSkd6NGVtSDgrTzBnVnlQdWZHTE1JUU1janRWREhNRjMx?=
 =?utf-8?B?K1Y3V2o1ZFBvMXBVUEdSbFN4OXo2SXg0dFBLQWY1ejZ5QVN6cWtjQ3NVUDlh?=
 =?utf-8?B?b25WYlFEZG8yb0ZlbkNucXNmeG91VUQvYi9INHB5YkJuWE0rOHFyZG5wK2hR?=
 =?utf-8?B?SlYwYjRIamZoZ3JPcUtBYWFwcFVyTDhCUWFuYWI5RXA3SDZhRU1xOHNKRyta?=
 =?utf-8?B?MmtjYTQwdVRiOWVGclJQcFVSZmFxUzBKZjlwKzkxeWwyZmlLbnhIR01IWUVo?=
 =?utf-8?B?ZjVWTzh1Q0QyNmNOY0NKaVZKT0R2Q3BIRmNucU9oNmw4Q0NrMFBEaGY1RlRG?=
 =?utf-8?B?ajZWZ2hnWUxzVk1JYVBGTjMrUkxjWjBRczVDYitoMnJHc2RXbStpWlA4T2du?=
 =?utf-8?B?UFJXTncrVU1rVFFBQVUycUJ4R1NWbUhZRXZYQlBlck0xUEpEdDZoWnZSV0ta?=
 =?utf-8?B?Y3NKa2lhQjF4Y3R6RUQrM3lmS0pZZFlIRnhiekI2ZEhrdENUYjhVME13ME8z?=
 =?utf-8?B?SUpCRFRnMzNzMFg5OVk1cGgwdTJaOVJrZUxOZWhlc3ppa0pSbVVwYWVQVU9Q?=
 =?utf-8?B?aDN4ZCt4VjNUZVpXS0ZTY3JlMkdRVmlOQnhPb1hSZXN1Mk5HQ0Zkb0ZhSExK?=
 =?utf-8?B?ejRFN3BmeEpnV0lWakRvU1U3Y2FqTjc5M1psZUN4V2xFdy9uSlc5MXJLM3dX?=
 =?utf-8?B?ZUs0ZXN0cXdLb0tObEZCdDFmd0VBWTZ0TkRGbUVUZ2VuUFdDZG5MN1NibHNr?=
 =?utf-8?B?cmRnNTBuMkZ4VTM4YmRqZEFjS1ZkTHVhZ2RXTkNJR0Q5Q3hBUmhJL2ZiYURX?=
 =?utf-8?B?dy9zOHdMVk5md0J4dllUU1J1aTE2dDFiSy9Qa3F4aWFLUUdrMkF4NFZaV3VH?=
 =?utf-8?B?aHU1L3VpVEF2VXBaRkJQdkdjemNla1B6UUljdGhuWHYvQk02L0ZNSjNIUytN?=
 =?utf-8?B?UGdtMG1VeGoxclkxLzhTbytQVzFiLzRhRFVPdklOUkhSUjc3SVgvWVRiMXBq?=
 =?utf-8?B?T1hFL0QwQnVVTlQvOHQvUWdpL2hscVovVWg5L1NtVE94d3JVQTJjTG42NGhP?=
 =?utf-8?B?enphQk5qakpzVkMzK0FtUU5VTkNTS0hlUzdzMkZhZGNjNEpkOUVjZVM0N2dx?=
 =?utf-8?B?QXRoSHUyRVhZK2M5bmRWWjVUNFVMR1VKY3pKMUxMeklmUk1zWU1wWE5yTDNX?=
 =?utf-8?B?L2VpT1V4dDBLZGJkQ0tycmdscTFBbDN6TTd5RGg5L1ZPc2YrNW51eTN0cUdq?=
 =?utf-8?B?N242Tms4NGx4TkpqNnNqSEJjSVdCN2pIQ1BmR3plNkNhRjBDZTRxS2dqQkxW?=
 =?utf-8?B?QUpOZkdpV0ZQTnU0VGgzaE9HRXlkQUpqaDhoajlKNnJtVVBZSmJGeXE5T3lp?=
 =?utf-8?B?dU1Ka1prSUFDR0FlVFVpdnVZWnF3dnFQa2sxWWp1WDU2TXZEVXhUMjROOHhy?=
 =?utf-8?B?bnpManVDOENRUDFlQzJWM280amNOZENDZzg2TWJILzdEVGsxTUdNOUJZVlpp?=
 =?utf-8?B?SVhpU0ZiWmxVSFFlalArdDhGam1pQ0hSaVVrTnBBYkFrMU5SWHBJRi9kWnJk?=
 =?utf-8?B?RThhc0h4UmxFTmN3TFF1YmhwNko2SkNqOVZ1QVovNkxNY1NPQ0VpUkRRTEds?=
 =?utf-8?B?Y2Ira3dXaXRMZDN4TEsyRTNNRG9YSnJLRkZncE43U3dCM2FCRjgvaFFGcWQ4?=
 =?utf-8?B?M3RiQTVZRmtRdWllZVhCak1vY3YzNFNBeEdzWFhGcXZ0Wmo0d0s4SSs0WXAr?=
 =?utf-8?Q?7uQhtyxQCMa/3tsfbwCsyv82eaPvJdKM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBKdHZoSzZuazRZdlpVRmRuV0VPWURZVC9qa0FqTEFTckd1S1hMWHVxdnF3?=
 =?utf-8?B?OC92KzAzN2dFUjVONnUzNUFNNUJISEU0SlZOYWlqUE1xT3FjWWFNek1zUzBo?=
 =?utf-8?B?VkxtY3BsUEo1N0lXUjhHdnVkOXhYeHBRbDhNYitqTjdNUTlBemMxR3Z2b3Rp?=
 =?utf-8?B?ZUl0M0hVN2J2aG1JWHZxS2tJa3dwbTQ0c3o5R2ZjejhOam1wT0luM1c2NFVJ?=
 =?utf-8?B?OUFxNGFzTzlxRUtJK2lvSUdFRElYbWgydjVVU3BYSWpObSsxUFU3WXA0Wjg3?=
 =?utf-8?B?TVVWbllCRWRVd09zSEIrbmVQbVhpOXdGcWRkOVJxM3ZRbDlPSmUxY0xSTENa?=
 =?utf-8?B?Q2NsRTN0M1hHYkZkeEJwR0JMMWk2RFdFcUdPV3ZyQmkxR0ZzNWl2Z3FkR3Nz?=
 =?utf-8?B?Yi9GUm9QdExXUnJDSm50Z0JnU2JwZUtPb2UzVDdGZm45OFZUVkpqRDI0Q1lH?=
 =?utf-8?B?aWdvOWszM1RNUHpFaGtENVpYZ05uREpwbXQ0ZjV1WlRGZjIza3VxbDJLVWo2?=
 =?utf-8?B?ZjBobGVYbVcwbVJyaFpZSHRoWmlDdjRXY1RzNWNSRHZvRVVleXpycGU5R0lT?=
 =?utf-8?B?Tzk4dmFWVUR2eFl3L3daaHdPcHNQVlFzcnVWSXpzL2tWRXl3TDIvaHhNTGpw?=
 =?utf-8?B?bWlaSHIxYjROKzMxQms5MWZZQndWMGw3Unh6Q2U1ci9MU29YdFlPbnpNelBn?=
 =?utf-8?B?T3BDWTRYWFJBUE85SGcyYm1oT0hNbzBjSzFQN2RwajlhN3hXTFdyeGFHV21B?=
 =?utf-8?B?Qkp1TDFQMDZJNmlJeWNPOEpkZXJOWXg2WmpWbVhkYU1FR0Nnbmwra0pxYmlI?=
 =?utf-8?B?N3FVRmUzM05jZzR6RnNSVVdiYjcrUi90NVBnaldJNG9aRkZkSjhQWGJhT1NJ?=
 =?utf-8?B?K0Fxd2ZWaE5LSlp6ZDNqd0lFb0MvMjlWSDlvTFZTalpnWVlpTlhxWDZheG1k?=
 =?utf-8?B?YXRDQmZ1RjJPdzBkMm9YcjZGRFJLeERrUnVlSHA0NGNiaGJydGlYNFR3T1JB?=
 =?utf-8?B?ZTVBQmxSUmFQMXJya3ZsUWUreE93UVF0TEt2OHY1QVRxbXVqdndsSnpLQU1D?=
 =?utf-8?B?OVJCbjdzelZiSWlUdEQxQXlpZDYycitWUldiTmtUSjU1dHBEVjB0Z05Fb0pL?=
 =?utf-8?B?TEJKTnNRZjArallXVC9ac25CUlpnMFZ5ZVV3WExlYjl0Qmpqak1od0pnNTRx?=
 =?utf-8?B?bjJ1VlpXbHpzcTIyeU5oLzJIUkEzUzVscUozeDNHUEE1S3VRTllRUmplT2la?=
 =?utf-8?B?NThJOCtiUTZudkdraFJSNTV0UnNTV2RVU1Y0c1d6TDN6MlArbW1URjFCYXU2?=
 =?utf-8?B?blpIbkFNM29UamowTFpVODNYZEs3cHFVRU5VeUlMalVTMyt6YmVIR2hRTVFh?=
 =?utf-8?B?YkpEWG5jcExxREhiVnhnc2pIWDVSUWRSWTdKREtMc0dUZUFFeWVyaUtIRGlj?=
 =?utf-8?B?Y1N3elhGckF5Rk5PU0hDS2trVTBYSnNvTlJJaWd6d1dFQTMwYlErTUdUVFda?=
 =?utf-8?B?TVRBMmJYNnRQQlVsL1dYSkpTdW1pN0NkMEtBdEZXYnkvWVhJY2VpMnJlQUt1?=
 =?utf-8?B?TTRhZXdmWWRtMit3QkIyMTR4QXlXS3JTV1FQYWVmU2FoYUJseWEzbmlyNXE5?=
 =?utf-8?B?NWFiejZQMndUSFFTV01SWEFvZkF4ZjQ1Q3JkUUpNZG4xUVdBYUliSWM4SU9q?=
 =?utf-8?B?NjdyLy8yVzF6bGZLcXhQekpvUjgzTEd0bUlWRDJMK0NKR0NGSFRvMWUrV09X?=
 =?utf-8?B?cXJpOVVJTnJpUFZ2cHNFODFmekVXekczcnE3RHVwbWtKditZTlpCOFRuZVQv?=
 =?utf-8?B?Rks3NU1qUGdpNEtqNFZZZ2xZMHRtNGZIelBjRlMxRWI0a01nR2gxN3NRMkd6?=
 =?utf-8?B?QkR1c085c3JRaVU2eG5iaExnQTRYQ2RoSFM1dEtkWW5xOTBmNVhsNDJEajhR?=
 =?utf-8?B?bFB1b0tXRm1BNnU0MEozRlpTbUllUTVjc1luRVdBMVpjeE1xd3RSQTl5K1VD?=
 =?utf-8?B?UGg1T3FaZFE1SnBFbS80enIyYlJLa0w5WG5GbUg5MS81T0wzUlZIeVdnOExk?=
 =?utf-8?B?anVOMEFCa0tqS3RlQ1poZ3NhVHhxOVZ4RS9qampBYmEyeGRYNmZ2NmtqQ2Y0?=
 =?utf-8?B?U09pYVJpUkNBS3JoRzYvdXkwYjZIN3ZmbDBBckpKajJNcGxhUlVPYXNsQ1dT?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f20e8aa-7278-4b8c-3f00-08de23204d6d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 01:51:18.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBWojHNt5kuOO6vAuufI8erWrDxhofpfUhWdZRFoNzXdRsG3ld8C/MNUthgKcyq/eSgDE3Ag13jVMRMjVxosJb9/Y9fmOu5es5yR5Phs7hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> The IDE key programming happens via Secure SPDM channel, initialise it
> at the PF0 probing.
> 
> Add the SPDM certificate slot (up to 8 are allowed by SPDM), the platform
> is expected to select one.
> 
> While at this, add a common struct for SPDM request/response as these
> are going to needed by every platform.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
> 
> (!tsm->doe_mb_sec) is definitely an error on AMD SEV-TIO, is not it on other platforms?

I think you just happen to have a multi-DOE test device, or a device
that has a PCI_DOE_FEATURE_SSESSION DOE and not a PCI_DOE_FEATURE_CMA
DOE.

> ---
>  include/linux/pci-tsm.h | 14 ++++++++++++++
>  drivers/pci/tsm.c       |  4 ++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 40c5e4c31a3f..b6866f7c14b4 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -10,6 +10,14 @@ struct tsm_dev;
>  struct kvm;
>  enum pci_tsm_req_scope;
>  
> +/* SPDM control structure for DOE */
> +struct tsm_spdm {
> +	unsigned long req_len;
> +	void *req;
> +	unsigned long rsp_len;
> +	void *rsp;
> +};

I would only add things to the core that the core needs, or all
implementations can unify. You can see that tdx_spdm_msg_exchange() can
not use this common definition for example.

> +
>  /*
>   * struct pci_tsm_ops - manage confidential links and security state
>   * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> @@ -130,11 +138,17 @@ struct pci_tsm {
>   * @base_tsm: generic core "tsm" context
>   * @lock: mutual exclustion for pci_tsm_ops invocation
>   * @doe_mb: PCIe Data Object Exchange mailbox
> + * @doe_mb_sec: DOE mailbox used when secured SPDM is requested
> + * @spdm: cached SPDM request/response buffers for the link
> + * @cert_slot: SPDM certificate slot
>   */
>  struct pci_tsm_pf0 {
>  	struct pci_tsm base_tsm;
>  	struct mutex lock;
>  	struct pci_doe_mb *doe_mb;
> +	struct pci_doe_mb *doe_mb_sec;

See below, pci_tsm_pf0 should only ever need one doe_mb instance.

> +	struct tsm_spdm spdm;

Per above, just move @tsm_spdm into the TIO object that wraps
pci_tsm_pf0.

> +	u8 cert_slot;
>  };
>  
>  struct pci_tsm_mmio {
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index ed8a280a2cf4..378748b15825 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -1067,6 +1067,10 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
>  		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
>  		return -ENODEV;
>  	}
> +	tsm->doe_mb_sec = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					       PCI_DOE_FEATURE_SSESSION);
> +	if (!tsm->doe_mb_sec)
> +		pci_warn(pdev, "TSM init failed to init SSESSION mailbox\n");

So it is surprising to find that a device supports PCI_DOE_FEATURE_CMA,
but requires the TSM to also use the PCI_DOE_FEATURE_SSESSION mailbox?
A PCI_DOE_FEATURE_CMA mailbox is capable of supporting secure sessions
and IDE.

When a device supports multiple DOE, the VMM does need to pick one, but the
hope was that "first CMA DOE" would work, but apparently you have a
device that wants to violate this simple heuristic?

What happens on this device if you use the CMA mailbox for IDE
establishment and secure sessions?

