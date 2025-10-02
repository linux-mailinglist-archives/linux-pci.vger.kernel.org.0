Return-Path: <linux-pci+bounces-37442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA27BB46BD
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 17:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCB819E2FED
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1C1238176;
	Thu,  2 Oct 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXVVaoGo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C13398A;
	Thu,  2 Oct 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420730; cv=fail; b=MYqIPlKC2LAtuUhGCjtw7LvFF79TquuCCFDuqcXezr2gVfzwUHWnLA/wxittQmovFHqDvv8FvokjZimhgghrPZPRSKsoLRqceLgqyWBC1BMI7wi8vvoFjTMXa/are4VD0P+CFbquGofzkGBAf7qMsx7wIgd2/cxiJHTw2Sv/jJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420730; c=relaxed/simple;
	bh=+czVQiedbeJtlVztaEILohjR3shbvHi0XoQt94ET580=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=hGCYtrtvGQPoTjq/90dOn0U8bcUmNHdF8hPof1dTLfd+RgHlCqh54qsoqH9SLsP2NEBo+JJJBWg8Wk+3sD9slBKnoPlyvi6nf5oDmcpLazemP3qDWru+OA67EeagAU0VMbOscgDIR3mRouG/7H6ooPu2xn7dhUGAKC2vdRZ9ZGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXVVaoGo; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759420729; x=1790956729;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=+czVQiedbeJtlVztaEILohjR3shbvHi0XoQt94ET580=;
  b=fXVVaoGo04FMET9er58OBjCTdh9k0zzyiq6SkoLgV53ZO5ZiCLICbIzc
   9LYpwNopIcDmYPeHRgVE0XXNWJrVcQTRaVqQF8wYWcGA2wDgu6WRUqQ+6
   SjQgDz6er4hxe4HXkoMSMYpJYcWxzXYdD/R7nBhAfAjNHULZHSQNmlLBo
   GIial3W5m6VeXDTAzP6QswhDV+BpEZhltqz1GD7rFYQeBezE1waLG0xz/
   deGbxQ4mbHoyOJ+vKYuHRfvDmzCTDZAxkki0AzcjhuMXC9NldEw740bJ7
   Egwv7WoRBAGy1RE2vIjPraeqSXqkonNXtJzvHMTXnH7gi6bmY8Bv0Ohno
   A==;
X-CSE-ConnectionGUID: YvE6Sn7wRaqvI23BV+Hl+w==
X-CSE-MsgGUID: O5JQNhCBRhWn4LghFh3IHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72382685"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="72382685"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 08:58:48 -0700
X-CSE-ConnectionGUID: vPdT2uPXS3ac4fYKyVchnw==
X-CSE-MsgGUID: y+Tm/6biQUWytOq76XkiaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="209767148"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 08:58:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 08:58:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 08:58:47 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 08:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bS/Mryj1BVH+8wEW7nRivtTQTO5Y7l0xJusmZJuQt01AAzHx2me9MfwP19qWUdM9ofMp5w2nbve1PM3jHlgD3v4WapBntjzHr7SW+LMoam41rSYYgOi2HQ0kLCkryw5sWWeUXEavY9qkAWY3Oc07Pxzfsdj+KbCqhsS7/sx9n4aG8j8ay+rI3xOK7jCzuKnmuL2j8u++EpSCcgKEHlF4h+ykCT8Qfnm1aPwl3Ep/CcUZoNu8uOczmL0anH7nxUa28zX8uZi8SyCp/kPX6sA2bRhJaMgADu6ziRauuGMiG6qhiUJhai169hTWbYWBzJoXjE+AcaIfnGTZV+usVjdFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nA1K72PifTXxIf0U0XB63J2YRjhPQAwDY6J28URLf94=;
 b=ZVpKbuCHdMMQ7Syxn7u8g7EtxTffghXO7nY0apV76OJMLumm6DLYZNXs1FeD68oU+ulj7QGPSgEe8hG7naDiLrwl5XggnrhA6z0r4nWNtdmjo5IiiwNT2xhOasTnBdgAUFtpfwE729ZAw/W3pZ816kpWwjJ/TF855W6UdVCepUUjHF2sBNsYZWc7ybz7r8rMoSrecBMfGkGdykMsuBxICgsgl61/Zy1v+Y3V0SaYtcchzqxiBa2725LuC149aiPPGtWM6SDop3zI2h6JZLyL2282/PrYxUABnvhPrO/YJHj02OL/IrGJ4fXhs7+8Hya4UeuCo4Hp7HxscJQb6FyX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DS0PR11MB8072.namprd11.prod.outlook.com (2603:10b6:8:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 15:58:38 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9160.014; Thu, 2 Oct 2025
 15:58:38 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 2 Oct 2025 08:58:36 -0700
To: =?UTF-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
	<dan.j.williams@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<aneesh.kumar@kernel.org>, <bhelgaas@google.com>, <aik@amd.com>, LKML
	<linux-kernel@vger.kernel.org>
Message-ID: <68dea12c352c0_1fa210071@dwillia2-mobl4.notmuch>
In-Reply-To: <481228e4-72d4-bfbb-5e25-660bfea1327d@linux.intel.com>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
 <20250928062756.2188329-3-yilun.xu@linux.intel.com>
 <68dd8d20aafb4_1fa2100f0@dwillia2-mobl4.notmuch>
 <481228e4-72d4-bfbb-5e25-660bfea1327d@linux.intel.com>
Subject: Re: [PATCH 2/3] PCI/IDE: Add Address Association Register setup for
 RP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DS0PR11MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 1009dfb8-8040-4637-c1a0-08de01cc8cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXVwcnR6M1hKNE9GR08rSGRRd3RGbGtJOXpoN1lQd1k4WEhnRDgrZUV4ZWF2?=
 =?utf-8?B?QnV3QTUxZ3FTdXFIUndvc2hFN1ZiN2VBSmJNQjVqdndjUEQ0TjlHWHZibGJG?=
 =?utf-8?B?bmc0ZUhQQ2NIR1NuSHdxbFJPcWNKWEtqTW55aUdDdW5qVEl1RFFqWndqTkgx?=
 =?utf-8?B?VS9wa2k3Rm9mZU9aWWxOeXhxNDhvWkd6ZS9oYXIrMjZaREhNQlkvb1BUR0ZE?=
 =?utf-8?B?UmQ4S2ljZnNBMGNCZFRpK2ZGNmlCeFdDUWNzSXlxNm00T0lkb3dZNmRhaTZR?=
 =?utf-8?B?MUZZZUUxS0ZlaE4zdnFPRzF3TXZueWdNa1VYRDgwSUdiallra0lIeWxuZGg4?=
 =?utf-8?B?a2hmaG5uN1d6cVRDV1FUWVVvM1RaRnQ3dk9jZkYwRDY4TUEvNFhDdXg3UExo?=
 =?utf-8?B?dHVUeGlKQlI0ZDFWTktCdUFOVlFTWmE3SEFST2x6eEFFaUlLYkxqUEpRd2JS?=
 =?utf-8?B?WHRsejZSc3A4cWJHWEFzWE40NUNHOEJIaTJ2ZjA3ZlI5M1dMTzh5VU5uWkZj?=
 =?utf-8?B?RWpxbDNyMzIzTzczYVBtQmFIVmpqWkRwblNpSy90YUszU3hvSXlEbVZqRFd5?=
 =?utf-8?B?TVNUZC9sa3l3b3lNNDc3NDU5d0srQnh3Vk1peWgxcHhNN3QvTEpGS2NnSEY3?=
 =?utf-8?B?Si84OU80dE8yS3VtNzFqMjJFMlRxeXBmZnZKem5HQU5Oell2d0lVZW1MRzlJ?=
 =?utf-8?B?Q1pxdml0ci9JYzN2RkR3MCtqeVkyM1ZjYStkR0pvN0JNVlhFeU4rQWNxMmgw?=
 =?utf-8?B?cTBhbCsvVDFGd1pteXdvSm5IcEkzQkNoOFFSc09ZQnVMWEYzdHJiU3MvWEVh?=
 =?utf-8?B?emUrdXQzTG9IaEVvN3RmSDQwM08wNmViOHFLRk84RGdmODQvS3FrVnlKV0hO?=
 =?utf-8?B?cGFoWk03M0R6TmpiVUZoTzlCWDFLdjF2YlgvY0JLcDJHM0xBWVpiY2tmZkF4?=
 =?utf-8?B?dGtEZHhPeDRDdit3OFdEUHpRVzdleURBb2dLVGVzcEt5Z3NMM3dmRUtzN1lU?=
 =?utf-8?B?SzB4ekxpdkJlVjVYMWo5VEcxN1VKTXdZU3dGelRVS21hUEhNazFpanlPMmhs?=
 =?utf-8?B?UlRYbjIzSWpFMzdQakZIRzdSam1oQkhsMVM3YmF4dlczS2FJNEN0NEw3UWor?=
 =?utf-8?B?ZWIybDhBdmcwUDZOZkhqKzZzU1hTaTRIVS9uVVl6bXBNY1ErM1krUXRMRVF2?=
 =?utf-8?B?V3ZzemY2WS9qWGFRZjhnZVN2N09ab20xTXBxSkkyc1pEMWVvdk5ZSU05d0lD?=
 =?utf-8?B?T3Y1bDdqNjNxSHMzRlBHT3lYNVVRL2RCNXJvTGRUWkRRRUkrNkwzMHJZRm9n?=
 =?utf-8?B?b2FYWVJudS9Xbm1ENUhySUlpQk9oSnNyR2J4NHlrc2dsYnBNR1REMmlYWTl5?=
 =?utf-8?B?V25PNEpHOGczU0orbkUwaTZEVVZoN0djK0xOY2lDRlYvZ0xKenJ6NUhodytk?=
 =?utf-8?B?Rnp6YXNzTjN3cGJxekZKTFRkY0RKWTZ4WmhRVGVLQkJQcEZXZzBZa3RBcW9o?=
 =?utf-8?B?VlhlM2hOTEd0emFRM283Kyt3QkZYam5nUlB1N0x2aEdyTGhrL1o3ZGlEWmRy?=
 =?utf-8?B?Zks2eWdLNDl0bGVMRmVGZ0txbmZHTE9IdWprL2ZyT0NwR2padHI5K1FlMnJ5?=
 =?utf-8?B?M0NtMjdpajJWaFNHcjBwRWt1TXhwVUlDSDBnMGQxWU1CV3ovRWROelhoMmk4?=
 =?utf-8?B?VmhhVGhOYklpL25GcXlWOVFGUzZjZVlEZS9pbEVWajJDMnVJTVFTdEYreG5t?=
 =?utf-8?B?TzFLVXBYNE9pK0QxSmc1NVFhRVJTWG5UQ1hqSmtxbmxlS2pxNkhkbkxWSVRQ?=
 =?utf-8?B?NUVRRDJEa0pBZTJRck5yQ0VrN2t1R2ZMVFVRV05oQ3Z3UXUrS0orQ3RnY0VI?=
 =?utf-8?B?ZzA0bFBmaWpKREtIaHRCUXcxOUdCUHVUc2o0bUwrc3hsYTdjcGRhTmo0SE9n?=
 =?utf-8?Q?u8a9IenbhZcYAAGG4s583xVZYJhF3b3M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajRHSUdFdXB0UzVYYlVWbEdlN3NCYjRFbmJGYXlTUisxbk0wekFCQm9BbUYr?=
 =?utf-8?B?YmlTeXV1QTlUbExMVllSODM0SXJCZ3FDSGVpZ0F5VGYyT2M0VEtncDhrNmtJ?=
 =?utf-8?B?U1E2NFE5RFNJZkdIblN5ZTJLS1E4TGxkcklWNXRHU3h6Z1dTanF4cHJraE44?=
 =?utf-8?B?OHNYUkcwQ0NQbnhOOTRMYmhzYkhlc2VUeWZWWUsvTkxPQjM4c2d1T1BlUy84?=
 =?utf-8?B?YVhObHcxeHd2R3pnZVhCWHpDN05zRVVFS0I3bXEySXdmVVMrRG55R1E3aVFw?=
 =?utf-8?B?d0ZzZzNwaU03K1Z5eS9rNTdCS2wraURXK1hTZTVtaU50ODREcmF1dGRMdlho?=
 =?utf-8?B?QlJ5YjhMNjdxd2hJQllxZGpLcVpnZEl3Si80aVhwUEV1Qks2Q0toc1NPYW1t?=
 =?utf-8?B?Q29pRzFXeFF0aVFvNzhzUEFHYXVkM3I4eWhuK0M4eFVUMUpqUVNqT29qYUhH?=
 =?utf-8?B?V3BNUVY5eUY0NDgrMHJhTmtzVitTZ1FsYnlCa1FEOFRZdGtFdVNMZTA5bjRp?=
 =?utf-8?B?UlVjT3VUVHJwN292QndzMk0vbGl0RjVHeldBRVBka2V3ZzFTRWxXOE9rNmFo?=
 =?utf-8?B?NXRTUlJ4ZWlvR1l4UzRiYXhOSEJmZzhNb3RqWWI1YmxaRFRiWDViM0p2dlp6?=
 =?utf-8?B?SE56QmUyT3hWMjk0MGNiVXU1ai9yclRwUm5ZMDcxdjRVR1p2K0VOS3ViQStz?=
 =?utf-8?B?UUtJc0tBVkp5VDB4WExYdFJQWWRHL1BXVzhyL0ZxMmhtY1l0bTU2Ynl1aFlE?=
 =?utf-8?B?RjJJSFZPSGJGTDdHc0dkcEo2SWxPRlRuV1NPRitGTWJtU0tHTGJuNG1tV1ZT?=
 =?utf-8?B?dlE1WndWRUFuRjJGMGswRUkvYkphbTFEUU1rQ2QwQ0hIZVJnMi94NDBNcWhs?=
 =?utf-8?B?RmhFZ1B1RTV4YnZwN2dBdm0yT3FSU1lWYlIwWmh2Sko5Sm5xbmlWL2V5MTdL?=
 =?utf-8?B?VUx4VUo5dEpmUmpQUGU2bVN0R2ZHRzBXRWRlZkx5bHZoUXhuQzYzbEhWZEcw?=
 =?utf-8?B?SktmcFdlSzloRjJkOTFjUTBYZ3k5YTArNVFLQUs5enc2Z3lUWkliZG5jc1l2?=
 =?utf-8?B?STM5Ukhacm1ka1RxRTNJKzlZVlpqdVlwS3dCUVg2UXpGNXB4UGU3RHo5OUxI?=
 =?utf-8?B?Mk1aSndveC9rSEluQlBRaHRRcjUrWmk1VWJ5bk5uZGZ4WjNBazRKWWRtVFc2?=
 =?utf-8?B?RXBaUHZGNzBIK01lMXRmdWthSzVnVUxZNnkxRlpIYzZiSzJVWkFvUzVpcW83?=
 =?utf-8?B?dFdyWXZJSWJqYUozK0F4RWViTEdSZ1RlWFRUdEFJc1Z5NlkvbUFORE1NRlBN?=
 =?utf-8?B?Kzl2bTA1Wi9kVVNjUCtuR1dXNTduakErSGJUY0RRL3BXSXZ4RUJ3TEZ6V3ZS?=
 =?utf-8?B?ZjREc3JWcDhjM2dyMjdLK0UwSitvYS9uT0NkbVVWeVBvb2RycnZkQjJYMTk4?=
 =?utf-8?B?UmRKNEJvaVFYa0N4eGpXa3YzUUFNUGp3MFBNdTFPOUJOd2NqNnN5THlmVm5r?=
 =?utf-8?B?eVpkdS9CMnB2STBOa1BtczkrTjFYdC8xdUM2SEJSaTlTMzR1ZEtqV0gyN3FZ?=
 =?utf-8?B?RHp1TGdmTCtWWFVJeEhuQmlLanYvUDA5VVVtUStaMGJzUzhRdk1zbnZTenRU?=
 =?utf-8?B?Rmxwc3Z5R25xOHlQajRyUHRrRXdaelZyc0pCdzVRUVhhOUxVMVI4MWtGYmxx?=
 =?utf-8?B?TE9XdituUzNmd0pXbHZKcjhPcDYvaUhHbzM5ZFl5dko3ODNuSXlhR3lJUThl?=
 =?utf-8?B?bnlXUVlRYXVtcU14a3Y1SytWUGNZYnBCZE43YXNSYVh1bFgyRXhLWXd5ZzhZ?=
 =?utf-8?B?T1FnOHNyNzVibGdSUS9walNlWk1mQ0FNemw1Ym8xWDFYTGlJT3RMc25RZUE4?=
 =?utf-8?B?Qm5CdzVkR0pnTFY5dStXaVo3Sm16VnRleW9xZ2FpQVNJZ0RrMkFldlNSanhY?=
 =?utf-8?B?d2pvRWJoMnl5ODd6TzNMbUdwMnBlT0ZLMWlGMFdMWTVuSkJNRkgwby9jcGJS?=
 =?utf-8?B?dHN6SkxvVWNkakg4SUZ6dy9KblR1NUhWZEVMRm5NY1NEdFMrclJ2T01HYjZr?=
 =?utf-8?B?bXQ3b3JxK2JURTlKbG9sMWlPb1dtSE1IdEpQd2RxTklDT1IvSVQ0VlFBK0JU?=
 =?utf-8?B?WlpDRE1XSDhtVkMrMGd0Si9CYktPTk1UVHV3cy90WlE4ZnNZSUNPalpUQ0wy?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1009dfb8-8040-4637-c1a0-08de01cc8cdf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 15:58:38.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTj7HIRnXoXAVOl4UHTsIAR/aM8+nTM17PizPlA1+dvGniHI4HPhrxNVoBDliqk7gx5i8kY9IQIJQQc4/JTekpIzrWnBOAlKuRlx+ccl/vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8072
X-OriginatorOrg: intel.com

Ilpo J=C3=A4rvinen wrote:
[..]
> > > @@ -206,6 +210,24 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_=
dev *pdev)
> > >  	else
> > >  		rid_end =3D pci_dev_id(pdev);
> > > =20
> > > +	br =3D pci_upstream_bridge(pdev);
> > > +	if (!br)
> > > +		return NULL;
> > > +
> > > +	res =3D &br->resource[PCI_BRIDGE_MEM_WINDOW];
> > > +	if (res->flags & IORESOURCE_MEM) {
> >=20
> > Per Ilpo this can now just be a size check.
>=20
> I don't know why you said this about size as you implemented it below=20
> correctly using res->parent check (inside resource_assigned()).

Oh, stale comment. I wrote this, then read your suggestion about
resource_assigned(), updated the proposed patch, but failed to come back
and adjust this stale comment.

Sorry for the confusion.=

