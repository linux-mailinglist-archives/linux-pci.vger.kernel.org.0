Return-Path: <linux-pci+bounces-41705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6682C71876
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 01:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4A5DC2961C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 00:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC00A1547E7;
	Thu, 20 Nov 2025 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ltj9ARwK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC813DDAA;
	Thu, 20 Nov 2025 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597857; cv=fail; b=B9vNOgAtAplBqtTcI2ChGw4E1v3MQFlznFw2iLGSyfWNlpFbG53i7wuwmoCrQ2hMR04s9l+Z49g5hZMwO4t0P30JjkW8VkBbCCbPjnK41e1HXjwVvmdGqHtJDGQzxWoz5B2AkA1qopZB9sDZdxu8T6HopUc9XUFmu6l1EdTNZEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597857; c=relaxed/simple;
	bh=6b+Ry4rxARTnUXx5oCfvpcWPORMOEDKyW6Ni7n9FmpM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=r2FrJvBkk7+euKlvLPLTy6FJhZu8z4rVKJ5T/5UTWhSyB3VSRgAMbZNaIkm7Gkp7sE8MpNyyuOeVTK3EM8rdAwMPyGF1a3qMgM1AXrC0eLi9tHtj7cSWq/QkIuXqHJDHLvV1NrbCF7FancN/tn3iLhtkZ+CARbY4hxMdbfmOsI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ltj9ARwK; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763597856; x=1795133856;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6b+Ry4rxARTnUXx5oCfvpcWPORMOEDKyW6Ni7n9FmpM=;
  b=Ltj9ARwKSDFV74L7qm93FQmNNBefcMx9jJ4vFkAVDSr34h4AGUoWP+dV
   76wEqj4XsZb/Um/3HGSP/gPNdRUSTOSpSq/3RM04P5m1/yqmEzKNdEI70
   YQVXytFpOORSaYQhh2pm52aU2B/Y6CSX4YozOrjwNSwC1qRwSjTsuWG4C
   2ncW+l369pmuLp9c/iTe8bbblpKCvrSPHbpbS4rljgGu0WSMXI7phRI5x
   CX2QCrkS0jRL9w/AzwSqSxBxyHndELBuQvHb72UBETmZmmkJNWqpq1Tn4
   /aL7EutzSqwyDE9pdQNrHAIMxuSkMLcYmYQyEOIfaTGfWUXfOz/ZhAWsI
   g==;
X-CSE-ConnectionGUID: JY6lc4cBREaKE4zy9rH6tQ==
X-CSE-MsgGUID: Li8psnbTQfqlE1pvAMRViw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69523358"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="69523358"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 16:17:35 -0800
X-CSE-ConnectionGUID: Dc1HXC++Rdu02PQS+RW2lQ==
X-CSE-MsgGUID: lwu1B/AETAe++v90IqzWVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="191639076"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 16:17:34 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 16:17:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 16:17:34 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 16:17:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tz6CNGphRh7kojMQMLF37eygT5vFe7pdzhH8Jrn71LPO5ifK5Rviq2hAo79UKWNxeHWJR/Jr2vpvpQGwpC0cVzP5w9eZzBFzns0mzEzhY4dOjS7li2CqDzTNnNpg8emu2IXlHeEABBbymHGNEUGlcyVnK+cjBe5ZVa4N8HpVEC45Uu/e9DMQEvzw94fqbS+WmQNDtId/7B6O8ezL5xegI5RUyvD23NJKQKlUMx5+o51aAQYzYzFKazhBA7lPCvAPTkyU8/uR3hqVW3b8WlogmqZlw1UM7ORk/DXwrkRIy69Ftv5R90ihhjpkFxTKEH+5+KB/nSg1d0Ppkie/EI+ITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kx/2ZTaUDKKl+C58IEkatbJfMtqcBodSS6VYp1rFgA=;
 b=EGW4iPXvZHhcccU9I3T9RC8wJp5cSTYnJ9Z0+Pb85oukUfywt3lA7b+x9NyvOW3IhlXy0evJJ7FCO1kuRmehvkUDzpRXkNKnxJKbVgmAoOkseJTF4yD73hayG10LNBlNvxjp5kzHFa04/lxSPDZVA1Mj0nw9JWXhqie/hqKsNhSChqJd9ukfbX4M7mTPYl5GPTvXDVnp02yxOLp37V1yUMR/cgamqEkKnP2vnoC1rXnFSWTYHheqHsIHbH2H/fd3Mg0wXsCm1yGSB5+IzE2zjlJ+Tz58flPPUsTi9j49uCNqk2HOGkvL6WdIHmS9HEbzAaLlZF6uPxSL7maHQnQDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6620.namprd11.prod.outlook.com (2603:10b6:303:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 00:17:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 00:17:31 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 16:17:29 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <691e5e19c94d0_1a37510063@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-16-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-16-terry.bowman@amd.com>
Subject: Re: [RESEND v13 15/25] CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:40::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 60461c55-8477-4533-461d-08de27ca326e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHVqcGhIRExHTlM0V2c0TTJiNUxKc0M3UmQxUVZyaDR6U0FDTy9wTlJydkdq?=
 =?utf-8?B?VWd4MnJiVEUxMzUwRnBRYU9KcTJldTg2V2hHbkRrUkZOS0hLNTJxcUhka3NR?=
 =?utf-8?B?NkNCbGVMSTNad3FJQ0xsdHdoSU1PR0dSS1dHUzZQQ25zWWdnMnZIbGhOak9Z?=
 =?utf-8?B?R1JJdDRySHFkL1RDaEpFZlBwamJBTEtkcnVrL2w5RjFQaDhoNFFqOHFmaUNq?=
 =?utf-8?B?YjNNdEZGWUpGaUt3eGJFcTg4MEl3N21Ob2dUc2lWOFlOVy9XaUtSM0lKTHJj?=
 =?utf-8?B?WWFNbFdUajY4S2J3RFRCV1prcUhsRlliN3Z6RXY2ZjVKQ2k5R28wcExrS2tK?=
 =?utf-8?B?Q3E5dTlmSnRaN0dBOW9QUnBHUHJadVFadUMxYlpoS2dMZThicW1RTlc2TGMx?=
 =?utf-8?B?WmRLd2psY1lCNUMveHpOcGtXb3ZwZi9pZS9zTytFbTRwVndEYUd1a0V5cHJU?=
 =?utf-8?B?LzAwTjFmMVU1NVJ0ZkNwQ1RNRG84RXNWZGxtVUZ4VjdrSHVWMkJDM1JtQ1N6?=
 =?utf-8?B?NG9Meld0Z3MxdWxEV3RXTjVCR0JtOGpGdGp0VVNxSGk3TXJFQVJ1MDdyQktX?=
 =?utf-8?B?QUU2SklvVXRSZUllS3J2N0xnK2lzMmc0Y2dUa09jL1JDMXBpVzRnWGpyV2U5?=
 =?utf-8?B?eGZJdXZ3N3BjYXZvbHdpWjE1K1JnekVmZmVlSU11bStsSlcwdjF4VXBSeHdy?=
 =?utf-8?B?SC9LUkdFb1AxSy9LNWcrMmtaNWxOS3I2OVdaSHg3aHk3NTl0T2NtUHVaWWNR?=
 =?utf-8?B?K1ZrTnFMNlZ3RTZnNHlsdklzdHFXRGVMcjZvdVhtQUlXVnNZdTBtVHBzSlVr?=
 =?utf-8?B?UUNMRG5hR3ZVMHFheEs5eUxHTnZQWldCd1lBZ0J3dzh3eTRndDh2ZUgxQ0Nk?=
 =?utf-8?B?V3czTkNqKzdPYXJneHlROHBDTnBGL21YeUlWV3EwTWp2UkZYNVNkZUNkSmcy?=
 =?utf-8?B?SjBKRVg3cDRHYng3SkEzTkUrN29VazN1QVFUakJFUkJXcDJYeEhEdExWRXV2?=
 =?utf-8?B?c2ZkWnFzSkpudGR6SEMxZG9SaWR2eHozdW1pMm5yZlNUeUl5UmhDd0QyRnVW?=
 =?utf-8?B?N2JNaG95U0JwTzJ4c3ZQUnNlT1VFN1U5UytLQjFBQnJVRWk5a091VTVEK1RN?=
 =?utf-8?B?andHKzR4SFhnSkY1TzZtMjZBV0kwTTdmSUt3UENScXdzaGVCRFZlQkxXOSt3?=
 =?utf-8?B?VzFTS3FmNGxmRWJYR2NHdjJ4K2hYaWtWL3FockhEbE0rZ2tRVGFjKzA5WHcv?=
 =?utf-8?B?SzIyOTBVekFUR0trbXZwQUxuckJFY1NuM1lkSFhFd3g4d201YURYNWJneGhV?=
 =?utf-8?B?K3VGM2R4VW52eVlzNUhCV3k5ZkQxRVc1Q1U3OWJKNXRRczZ0YVBEQ3NGMjJ2?=
 =?utf-8?B?ampEY3BXcHJJUkZBc1dsQmc5NlZBdEpEaVZFUU1NYVNzcjhlL1ViR1BSVmJq?=
 =?utf-8?B?eEpVQTUwZFNDenJxLy9vM0I1QkFDSTBGSXpCZndJN3FISE92NlpIcCt0S3VN?=
 =?utf-8?B?cXJGK0I4ZjUvM3AxVmxlL3pFU0hwUjVhaG1tWGFJbFdzU2xJNjB3eHB2Rmh1?=
 =?utf-8?B?MEVQdTZwMWpNcE5sd0M3anlhdWNYZmtVT1YrOGJsYWFKS2syL1dka1pwL1p5?=
 =?utf-8?B?N0gzSnVuWTQ4YjNoeDAwNzkwRUJJTVJzdXdxUk1IN0Rvd3Fqdit0R3Q3bkVT?=
 =?utf-8?B?b2VuSkVzK3oyMUY4WEF2Z3RwWkgrb3JLOFJEaUhYVFVLZnZ5ZkM1MXJxcWE5?=
 =?utf-8?B?U3RKaUx0R09MT0phU2RYQ21DamZ4V1EzcllPUDVBVU52cnhUaUhJdDBDUUUr?=
 =?utf-8?B?RThXTVRlcVZPTWlJaDkzVHN6dDA3NEd6THpGbWtFcWU1SGJWb1h3Z3RyVExV?=
 =?utf-8?B?anBUOHpZVTJDdHRqVjZ0ZHU4ZkZnNHhSYlZjcklaaXl1UTdlYmFuc28wdU81?=
 =?utf-8?B?amZqQjcwZnpRMzhsRnY0ZVlHdHFKZW02ejhxUTB5WUJhNm9MMFQxdlZmVHA3?=
 =?utf-8?B?cm1pS05aUWlLNUJnWUxGbHY3bzJod1FKODQ4aEdjcU1lRXVhbUFsZk1FNmpI?=
 =?utf-8?Q?9ekjpK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWJWOVZ6ejhzUUpCOS9RdTdEQmNJNWtobW8zOHVOaWg2TmJIM1ZWNnVDcTRk?=
 =?utf-8?B?aXA3MW81cXl4dWNQMTYzaE1XN1dyN0V2NnVmc3hQK0tTVi8wdU4zUVd5Q2l0?=
 =?utf-8?B?VjZYOFhuZy9GWVRUNjVqRkZwYjBXU1lFVE9LWFdpY0dMTFFkSVFXVW1iZWNW?=
 =?utf-8?B?VFZwZiswQXMvVE5xaXprTEtiWERtVTg5NFpFaXorZFBZSTRBMlFFVms0bG9t?=
 =?utf-8?B?RTV6Qkp4bTdpVlgyS3RyWmdEZitVMXBwUEdUR2J3cjNoL3VwbGFCS1NZNTd2?=
 =?utf-8?B?QzZrTjZ1Y21MYkFKeEU0bWdhMWVxZVJIbVZ5dDVLSmxkWk42YVJuVWM1ckZS?=
 =?utf-8?B?bjJxRFhZajVvZmRuYnJGTzhGWXVsdngrVWFrSFRTWFlkWFF5UmVPZDFxRTFC?=
 =?utf-8?B?bS8zcWtTSmViTGVxdjFCWlRlR3YwVXBIcnk5djA5dnNRVnk5VmZCcUcvdTQw?=
 =?utf-8?B?TDF4NVBQRHlYa01hMjUzNUZRVG9xYm96WGVOT3l0MG1BSTRMcndVZ2hqRzF4?=
 =?utf-8?B?R3RBMHg0N3NXdzVyWDFHUVA3WlU0YjdBS2FSWUk3K1k5OHJFWll6UDBScjdX?=
 =?utf-8?B?dUpYaDV1c05DZ0JuQzY5YjIvYW1XZTdaQXNRd1FZazRGVEhydmxoUDIzajhR?=
 =?utf-8?B?MXhQNWhJdmZCancra09zY2Y0ZDNKOUhTbzJRT3FKdmZrbGxJQVpZeDdWdDdI?=
 =?utf-8?B?NFRJZWJrcWdJU2wrdWtCNnV1OFpuSTVPYzRuMDBQOW9QT1VxRUZHTFlTdFE1?=
 =?utf-8?B?NlJKaGZqSDVhUG9Lb1k2UG5BK2xTODllMUxxZDZTdjE0YkM1OUJzeERhQlJR?=
 =?utf-8?B?V3dQLzI2OFlQbm5QeUt6eU1kMVNMeFFxcTZqRzRMUk1RcDZEUEJ0Y2RicS9s?=
 =?utf-8?B?WEtTQ3VCN0JtZnVubnQyZkJvWkNFa3hRVE4waVUyeXlhalJyN2x1cnlodGFT?=
 =?utf-8?B?V3NRRlYzSWMvaHZHQVhjL1E1OEYxRjVjWEZva0htQ0Y2a0ZpLzRXSkFaWkhS?=
 =?utf-8?B?aXlmS2hJUTVrQzdJOVlUbXo2dHk5YU5idnRPNzZxREdXVDRXQUV2M3B3MU9H?=
 =?utf-8?B?RnZBZTEvK3NxOHpPZDBGUllzZXdCTm5GODBxQU1aL25MQ0ttNEsxcDUrWmM3?=
 =?utf-8?B?L2M3Z09xclVlN1JiMWhZOCtINi9NUW5kdUlWaWlGd3lQdkhQMU9sY2QyUlVR?=
 =?utf-8?B?MERWM3FFeHptUks1YzNrTERlVmhGNW00aHNock4zcmIvTGRtRlgxZkR4enow?=
 =?utf-8?B?bFI4Z0NjdmNNbGREK0cvVmpvNHoxeEZwY2MrQUxMK2dvbFBJUW1JcTVSM1ZL?=
 =?utf-8?B?T0Uray81bE9mdkM2aFlQcWlZaGJkem5lazNldG5vL3dwSXh3cjhxbUlsTy9N?=
 =?utf-8?B?RDllR0l6aDVXWVlRUDlFMmxRbmxSb0dPcUJrQUxXZDVSZ1RMT1Iva2lrWUxP?=
 =?utf-8?B?ZWVSZTJYaFc3RkxmZjZLOVRuN3IxT2xvV1JiMzdrYzBNYUQ2UVEwNWdHSFdk?=
 =?utf-8?B?Slh4SlFoNWJ2OERwQTg5QVF5OVJjQTlzNkVJVERvbUpHOWltYTBycTJCWnFj?=
 =?utf-8?B?aXJQM3prelQ1NzFmNnpSL0swYjRMTWVNa1BFbGFvUnlYeUlKQUw0eWN6RFhs?=
 =?utf-8?B?SU01R0VXZHMwZ1JTN2o2bHNodjlPMUFJTGloWHlNNjY2Ri96ejRkUTRhUEZM?=
 =?utf-8?B?SDRNck82L3kzcHRsSG5BYWRLcTErTnFSZ3Zjc21zak8wbHRSTUZrRVlkOHQz?=
 =?utf-8?B?WGN6VjViNVpTejNaUytzVWc0WnRONnlDWEtkYmxCajNMK1F3OHptOVI0elU3?=
 =?utf-8?B?anA0NDQxOFpMWExhT0NUS0R1U1pERVIrS3ZHMmFDUjlyZ2N0UElycldwZ3lI?=
 =?utf-8?B?dHNENjdIeFJFaVJWQ0dpeGlLRmVYWU5oblJVQXNMZkRpL3ZWd2NObndIVFgy?=
 =?utf-8?B?SHJvQTFrLzRjeEhMWGQ5QmJIajNXVTRxTFhnUTJjUkF6VkdZeEI1TFlEK1pt?=
 =?utf-8?B?V251ZkVSVElmV3g4TERhR0dSdVBxcUpwSjY5Ymhpc2FURHV1eG9uWFpVSGVD?=
 =?utf-8?B?ZnRTWUhEUFpiQVB3Y1psUEF5NmhEZnFIZFpRbkx4UlhMYitldzViN2JLV0Vh?=
 =?utf-8?B?SnE2Zy9DM3IzV1YxN3lzK3Y3ZU9hTlFRUkxBSHdjV2RlT0JUV1UvQTlZeG03?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60461c55-8477-4533-461d-08de27ca326e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 00:17:31.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmuE0AhtLO3LXQGMeBwPkq1zycYty3MeKsSUZ8m+iyV8ZmMFaQ9Jt80YogYqOSyIAzINWfk11GFgB70qfG1NcB73JlQBm4cddA/UpsEKk/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6620
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL driver's error handling for uncorrectable errors (UCE) will be
> updated in the future. A required change is for the error handlers to
> to force a system panic when a UCE is detected.
> 
> Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
> be used by CXL UCE fatal and non-fatal recovery in future patches. Update
> PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.

I would also note that this starts to bring Linux PCI core native AER
handling with ACPI GHES CPER_SEV_FATAL handling.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

