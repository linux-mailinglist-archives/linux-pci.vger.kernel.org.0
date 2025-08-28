Return-Path: <linux-pci+bounces-35067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1C6B3AD44
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 00:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B8C1C8593F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0F5196C7C;
	Thu, 28 Aug 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCOJQ6BD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6594D29ACC0
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418841; cv=fail; b=Xk9G+RXXXciqUh0l3HpD9UubWy3k4XE0Fth5oMH8OSw+hB7TqcHgLPLSTJ6Vo2t39gl54Dhhvk9VQNJulbFKXOe1t/VrFZngCxAKQZO0D2s2G89P7ETfkKLEzI7ZMf7LU0ZVnZNXgB7utl6zj4iUstKu4UgpIzgG4fKQjxnyFps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418841; c=relaxed/simple;
	bh=TVcOlQz6kdDaM9wnEe0PawLa/fN4NdK7S6pr+S+V8z4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=iCtZIZDXXZpy6PWddhk8PufKAxLOFNWrU4bAvaXTzWGkYOmbKx7O3nMkFesZWyC4weEpJHrJlA11MkFV3oHv6TJf2SeqUtaAPkM2Zqj3XMr+t4Y83H3Lt3+fKBFzE0ynd6xAQOfpF+VUy/WNA9d5e8SAQszni25OmOQFyGAupoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCOJQ6BD; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756418839; x=1787954839;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=TVcOlQz6kdDaM9wnEe0PawLa/fN4NdK7S6pr+S+V8z4=;
  b=GCOJQ6BDAzqSHHhpMrXaVBEje1gXst+iZSx2KAtLLuBEyufAUOKLX6mf
   OGybfF9uif+XMmZrGFrBH7LuB2D3tz0/MYFBLTRkIOsTxCop55Ba6WbIJ
   AOFwU/99dkeHgxmzD8xmHo131ebaw5+yDsXkQvUbs3zZrsR2pHdHEHoEK
   5g539cl8yi9/L2OuT/65WN4Bj/J2yH3UrxyCqG171m4mDTCTycocHfHFC
   dRhJ2rjh4lEYNZN1qMtmmHxh/NgC4Cb1KopyUHFOkhePt1QVNThXIgJ9t
   L82KTu5TpcN2xk3d37wH1JpDpIQ/Rnyt4dHGLsAtdvxO3I4ZFvd+st3Hr
   Q==;
X-CSE-ConnectionGUID: WeoKc2deQoONIZT7e25TQg==
X-CSE-MsgGUID: 5XcQk1+KRzaL9N1yGtw2+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69296727"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69296727"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:07:19 -0700
X-CSE-ConnectionGUID: X8MA10jRT/OK8AdW1r9uSg==
X-CSE-MsgGUID: btKfQkiPQ5mFMXNJdvwmow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175504807"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:07:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 15:07:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 15:07:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 15:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+2zDPIWZ27f9xDrJQisJgCZrIlcUhUlL79cX1UHuu8TsniholieG3DTrArmn2xTchEuX6U4aMCgglXMVqb1yHTZup34ECGVNPSqqsdHhdQJJ/32sBr8N6fxGlxdCE8oGB4Q9hUvrele1mhfETDoaTsQt39BvLds3gZcj60i2HWwtkWnmpaKysRcLfvXXlUXEHRlyz3mKNEouPibQrTVLQM+HKuktGeI83H7g7ko6hCx6Vt6LLGQGcZUanUL+xhoFsCrucJNxFY9ONnXfAOW3BMZJsMA5GUQUdgAOmFoIMI9FvavyoSeAyjHUIIKYw9OBHCGNfn1BxaZcywX9sAc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpJeH7yFMR2eSjFE2SZXjU3pKaYpfK3p0Cbb4EENI6A=;
 b=zO94xgMM/TyAbimA8VnWpnJcQQvIEtnHMm894XcapdZapgEdrvFjQXFqdTsJ4rRadftKJ3nqIgSjuKniBDJ956+4xaezJrEFkWnz+wztkKFrx5HtmWf8rFaTRQNNomHdXJ+xISGM6dKY5xcTsU8n27JnKchxLctSr69cp3nQNnusyMtllQ17oQDp+4l4F9LB5WiylBT5q9w1EuKw7Dzlcp1bS9o22WH16hl8oSM3UWhMGgifncKzjQdf0+SFh3xGDeHgDwxOyIH09FFMcOUXNyOGMd2is+gkKlNqBX3vlWH4AzP/7sTjU2JIxDtzfGn5wGLS3U3uNsvWpwULpIBMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5875.namprd11.prod.outlook.com (2603:10b6:806:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 22:07:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 22:07:11 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 28 Aug 2025 15:07:10 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>
Message-ID: <68b0d30e2a18c_75db10050@dwillia2-mobl4.notmuch>
In-Reply-To: <e680335b-bd40-4311-aa13-58bc2b0b802c@amd.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-3-dan.j.williams@intel.com>
 <e680335b-bd40-4311-aa13-58bc2b0b802c@amd.com>
Subject: Re: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e91c4c-293c-4c52-1412-08dde67f3d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3hoZnNWYkZXR3J0K09QcVp5c0ZHaG5DWTRoSXRFNGN5a3ZrNjZPRjY5MC9v?=
 =?utf-8?B?WEZhVnNDMjlYSEZQZEFwK1kyZUs0YUNlSWxsZHk4c3BLYkhyU0tXRlhnVFJP?=
 =?utf-8?B?T3htQVI0QjBOWDdDVEZ1S2hsZTRvVy9IQXE0WWEwWXFYVFRTYXlYa0x0Sm5J?=
 =?utf-8?B?QlFWU3FLY0FYS3V3UXI2cUdzL0ZxY1Q1MnAvU3lpL0R4ME1DUWJvMWdoU1Yx?=
 =?utf-8?B?Yko0djhDYlZYWTlQUnN1Y3hKdHdOWFlhODBQbG5JdGNOQUJ6MVdPRThEa0U3?=
 =?utf-8?B?djhmZ1duSXgyUnM0eis5ekxMbFlNd1QrbGxVcGMzRnBlaEdsMms2VXFOdmM5?=
 =?utf-8?B?T2MrdFExRlltS2l1VnRkRS9IWjJYRlhWWER5Qm81T21UN0lWSHVvTFpSdi8x?=
 =?utf-8?B?dWVzUDBYTHVucGljWGRFMy9aWDJuWDBsS3VNME85Qjd4NkRtMDArSjNCeHVo?=
 =?utf-8?B?eSt2eVowcmxyaTJpTjZvUmI3NGFWTkczWVdaUGlNQkxQTUI2cFBtUHdNeTBL?=
 =?utf-8?B?WFFuZ1hHQnlScnNuaDlPOUV2V2V1UVVlM1BLem9jQ0F0UVM0TDVZazN0cnc0?=
 =?utf-8?B?RWRGK0svanZzeDBrcjdtZVdmcWhBOE1ZdVhtcXlucVk4cnFCQWJVUElZalZF?=
 =?utf-8?B?bEpXd2RlcTl1WStUZnBYRUxuV3IrR1BzZ0ZiMEhYWlREa0pEZWNlYmZTSHJx?=
 =?utf-8?B?VlhqYnRFYW1jVml4QzdXSDEzRlhickdrSWtIalVuQ2hyRUpLMkFvWlVkY0lj?=
 =?utf-8?B?bkNYRjNEREJleWRMLytPUzIybWplb1ZUNUdlV3J0M3RuL3ZtYWc3V2thZ0FD?=
 =?utf-8?B?bGo2MHNCK2I2ZTMwT2oxMHhHbG1vZGg5ckpNRG16c3B5dy96N0t5bnNsV0h3?=
 =?utf-8?B?MGRaOWp1aFpnb1B6a1lHN1VHdVFuQ2JHR0xiVDdkazVac0ZZYVpZRjBVMjhG?=
 =?utf-8?B?RjBlWWVPOWpxbWtPbWliSGpNV0ttUFJ4b2dxWDZlN2tTWWIxbjVYU1V4Z0Fw?=
 =?utf-8?B?dG5oRyt1U2hPOHVKRHlTeTA5eXlFWnp3c2owQy8wMmljamYvT3dMVk01b3lW?=
 =?utf-8?B?bGhsSW8xUEV0WkJ4ZnFHaTFDYXpIN2dFaWs2VWpmTXcxaXd2NVR4T2pWVWk4?=
 =?utf-8?B?dGpOa1hzZFc2TG1TdGM1eFZEZFVxNTM3U3NuRFVmcU82TnkzRzd5cGYzaW4z?=
 =?utf-8?B?WWs1UkFUbk5ralNpK3Bodm45T0J1S0ZKU050aWhzMTFBWHBvL3hta1IzM3Qr?=
 =?utf-8?B?TzZXSlBZNHBRNGpYTDZYaXNwamRpTDlFR1lyZ3BXbnBFM0dEK1pVY3RPQXZy?=
 =?utf-8?B?TFBNSFZBNXNvdGFJaVFLTFZicEhscW1pWlErK0p0VkVvZlpjU1RoeE9YYWdF?=
 =?utf-8?B?aDgxZHZQLzVpMlhnNlpwTmt2YjlXVUNGNWJRYUh3b1VGL1NEbzI4NW1GM3pu?=
 =?utf-8?B?UWQ1NytaVkZEcG1CdzkyYWxiRi9rVTQ1NGdSVEdseTBIMFgvL1BDd21xNjVO?=
 =?utf-8?B?SGUyOVVSWDZMdTIxQms4TUJKMlZESjAvRVpNRUY2N0RIdk1kZ2ExTFdtTEVO?=
 =?utf-8?B?VmExUXVtQmdoenNzNkFMWGRBWmd3dW9ubFlRN2JEb25zMzRLZ1NteGlDOTdx?=
 =?utf-8?B?Vk9RZU9GS1YwTTcrbm5OUDh2alQ0NWljaUZWMm1qakVqWGVRdmlqeXhtNFpX?=
 =?utf-8?B?c2lhenliNVJYOXpId1VjM1UxOC90VlA2SVJBZHk0OE1HK3FlVjM5NGJqZDNP?=
 =?utf-8?B?M3hERjNlSVFkbUFZbUVsaW9uaU1qbVdjQXNXUnFLSWNKMlJNeXNWbEhBeFpY?=
 =?utf-8?B?K24wbDFEeTZVTkxSemxMemE5Qzl4UlhrbjBvWE40L1lxSnQ3Z3o4ZE9Zc2or?=
 =?utf-8?B?MFAydFcvVkJGM1dYVmdxQ0pOZmw3eHM4ZWR0K1ZoRWJaZzVkV0VMOGFpUk01?=
 =?utf-8?Q?7HCu/2iJ/ME=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVqNm93c3puV00yQlB5MVBjYWZhSjljT1hOK3pFcEZLdVR4MHNuZG91eE1F?=
 =?utf-8?B?TjNmcWlNbmZUS1pHL1lGUHJTdmtqZFB5VnF0dVhtUnUwU1VwU2VvMmNLUElZ?=
 =?utf-8?B?Q2RyWllHTGd1aXJDc2pOb1gvV0l0RmVSMys0U0lwS2NkUGdSYzRWVHZOL0Iw?=
 =?utf-8?B?alJxNTkrY1E1UjdtUHloeGdZUnQwby9JSDNYakFQcjJiSW5QY2M2Yk02WFVY?=
 =?utf-8?B?MzMzZk9UeFJCdGJKZ3dpWXo1R1NuM2o4S3dnYVpDcXdYYnN3NGVCTklsRTBt?=
 =?utf-8?B?UWkrU293Ukd4QWdOb1BESlVtd0trTTBVSEQ5cEEwTkIrb0c5Wkg5eGtUVVh0?=
 =?utf-8?B?d2VzMEdSWHhpakFianRpOURiVTl0cm0wSGR6aW5mSjl1NmVlclZ6c3NEMW80?=
 =?utf-8?B?UWt4aTk2UnJObWR3aCtZRFdXM2VnYnNoS29OZ3NYSWJNbGdDbXB2c0RYdEVm?=
 =?utf-8?B?V241ZGpIOHpWMitqcXdGSUx3aGpYSHl1WXZDNzdmd3QveXFuUkVCYmdYdE9V?=
 =?utf-8?B?YWpaNHZDMVkzNFRycC80RDlNSEEvQnUxeWI5L0lkT0lEWkRxT2hlUHM1ZzZI?=
 =?utf-8?B?QkRCR1ZvZHJ1R3FmaHdmMHNMakdheDlleElIYTZLMGdWb25EbHNuSy9PS1BK?=
 =?utf-8?B?Ni9VSS90L0FEQVg5MGVPRWhOMWVORys3RXFwR2k2UjJXbVhGTUt3OUVJZGNO?=
 =?utf-8?B?WG0yMHVNcnZEQUNNejg2TWdJc1BHdjUzYmU4OW5zeUoyTnRwdTBWdUF5dlg2?=
 =?utf-8?B?L0RlbVh6blFzZGR5MUgyamVpQklMVlBEdStNaTFVT1dIV2FGY1VKMWlPS2xO?=
 =?utf-8?B?WThUTVpWNFlrMWhBU3VLSURWc3RVdm9JandmdGJjMVNNODVIVUNkQXl5RGpF?=
 =?utf-8?B?amFTbVFVaUhWMFJCZEtkWU4rRXpOUnBPeXFNYVpNdng5bXRCRW5MdUswWVA1?=
 =?utf-8?B?ZkpGbDJodW5abGhjc3RXcnZpK1VYRlBwK0c2aC9Idm1GSWlkbDZHZmh2cUlW?=
 =?utf-8?B?bHRjUGlrNjhvSGprV2lTamFRb01sTHBWdGxmbmt0d2dJS0V2Sk5tVlJPUnIw?=
 =?utf-8?B?bG42THVpUkhJN3dGMVFPQmdvNkpEb1UvMm9lY0doRVJqQWFabUpBSXh6OXp5?=
 =?utf-8?B?bTBVZEtsUDN4R2t5N0JHV1pYTmNGVmpYaHdlaWF1WE9GSnBGOG9wME5ZVy9p?=
 =?utf-8?B?MzFhUndhNzBsWC9KdFFKTHF0YnhpNm9PYmFyQk52bHJxQ3VEUWlRRDBTeVBK?=
 =?utf-8?B?MjZEcFpuRnlVWWs2NHhnY3l3aXAwcjdyVHEyNWNaYUVLNEZFejI0MFVwamVq?=
 =?utf-8?B?dnkrRXY4eHBHeWMrUVNmbjhMK3htYmNvbmNzcm5ZZDhMR2c2SVV3QVI0dUg1?=
 =?utf-8?B?SGJaeFJVUWNIWEcxTlpSZ2hHOGNXeHJhS3BNSUdJOWFQa0l4ZXYvZmpveDJ2?=
 =?utf-8?B?aTFYeGFkeHd6RFp1andtNDAxUHRwWlZkNng1eGhTbk5BYUVQRWFJTzdJQUht?=
 =?utf-8?B?NU9WNW5aTHllMncrRVpkd1NwTGZWa3hIN0hQMkJ4WnA0c0kyRjBmRmlJaXdN?=
 =?utf-8?B?Z3pna25rbzE5N2JOcnVGUGZnUndPK1k3WHdhNnR6MUx3OUt5VDdvT3NNMVNB?=
 =?utf-8?B?RHB1aUQ5emJjeUhUUkx5bVEvTVRGeHArNWtRSTQxcmduQWVVbmhJNnJXZ0Mw?=
 =?utf-8?B?NWRqMTkwR2Y2N0dMbjRDSitCWkl6VUFoYTZBcTZ0MHAwcEZOeHlrcEVSMk5C?=
 =?utf-8?B?OHd1cGZxWUFLV092ZjBYRnZudW1tZXhKSFV5RHd1ZVJYUE1LWGFLNUJHdjNF?=
 =?utf-8?B?SEwrWjlWWVRJNndjRDhWR1dISkRyMWsyVmZBblNTSnZlZ1Y4ZmdpTEZXdWJo?=
 =?utf-8?B?VTdGMktrQWVDWnJ2SXFWV09zUlhYR0JnTXFGU3VuQWRvWmJmM0dWV3JsckEx?=
 =?utf-8?B?N2l0SHVZRHJRZkJ6ak00NE5NajRkQjd6ei9YQ1VxMlZGbFFoSjEvY2ZUUnZK?=
 =?utf-8?B?YXk4UXpvdk9UcEhhZ09TSHViemttZy9SdUNEYjJraWxUVHo1NU1sOWRveTEr?=
 =?utf-8?B?c2RUb2VwOGlBQVNKdHprQkdVTnUyMWQ1S0paWCtDcE1SK1NaZGE2dlpRU0hu?=
 =?utf-8?B?dmp0SVgwT1lHQ0hwcmM5bUtLSk14RmpSVnZaRXBtSkpxTHpaUElUSFZZdWxx?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e91c4c-293c-4c52-1412-08dde67f3d2d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 22:07:11.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYkfmEshjUN4fDhai4WLMIZVPbRwwuQb3y018zKfr1gGMvz1UAjzH+ro7fQg1Mbtg37A8jK5YGlBVdx8/WCEoWwjwYbxJyhnVOaDU2EymuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5875
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 27/8/25 13:52, Dan Williams wrote:
> > A PCIe device function interface assigned to a TVM is a TEE Device
> > Interface (TDI). A TDI instantiated by pci_tsm_bind() needs additional
> > steps to be accepted by a TVM and transitioned to the RUN state.
> > 
> > pci_tsm_guest_req() is a channel for the guest to request TDISP collateral,
> > like Device Interface Reports, and effect TDISP state changes, like
> > LOCKED->RUN transititions. Similar to IDE establishment and pci_tsm_bind(),
> 
> s/transititions/transitions/

Thanks, not sure why checkpatch spell check sometimes misses words.

> 
> > these are long running operations involving SPDM message passing via the
> > DOE mailbox, i.e. another 'struct pci_tsm_link_ops' operation.
> > 
> > The path for a guest to invoke pci_tsm_guest_request() is either via a kvm
> > handle_exit() or an ioctl() when an exit reason is serviced by a userspace
> > VMM.
> > 
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   drivers/pci/tsm.c       | 60 +++++++++++++++++++++++++++++++++++++++++
> >   include/linux/pci-tsm.h | 55 +++++++++++++++++++++++++++++++++++--
> >   2 files changed, 113 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > index 302a974f3632..3143558373e3 100644
> > --- a/drivers/pci/tsm.c
> > +++ b/drivers/pci/tsm.c
> > @@ -338,6 +338,66 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
> >   }
> >   EXPORT_SYMBOL_GPL(pci_tsm_bind);
> >   
> > +/**
> > + * pci_tsm_guest_req() - helper to marshal guest requests to the TSM driver
> > + * @pdev: @pdev representing a bound tdi
> > + * @scope: security model scope for the TVM request
> > + * @req_in: Input payload forwarded from the guest
> > + * @in_len: Length of @req_in
> > + * @out_len: Output length of the returned response payload
> > + *
> > + * This is a common entry point for KVM service handlers in userspace responding
>
> KVM will have to know about the host's pci_dev which it does not. I'd
> postpone mentioning KVM here till it learns about pci_dev, if.

Oh, this was a copy paste mistake that I meant to cleanup after Yilun's
clarification [1]

[1]: http://lore.kernel.org/aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050

So, the plan is *not* for KVM to have PCI device awareness.

> > + * to TDI information or state change requests. The scope parameter limits
> > + * requests to TDISP state management, or limited debug.
> > + *
> > + * Returns a pointer to the response payload on success, @req_in if there is no
> > + * response to a successful request, or an ERR_PTR() on failure.
> > + *
> > + * Caller is responsible for kvfree() on the result when @ret != @req_in and
> > + * !IS_ERR_OR_NULL(@ret).
> 
> Uff... So the caller (which is IOMMUFD vdevice) has to check and
> decide on whether to kvfree. ioctl() is likely to have 2 buffers
> anyway and preallocate the response buffer, why make IOMMUFD care
> about this?

No, iommufd does not need to preallocate the response buffer, the
response buffer is allocated by the responder.

This follows the example fwctl because this guest_req() transport is in
the same class of kernel bypass tunnels. No need to reinvent a common
device RPC transport mechanism.

> > + *
> > + * Context: Caller is responsible for calling this within the pci_tsm_bind()
> > + * state of the TDI.
> > + */
> > +void *pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
> > +			void *req_in, size_t in_len, size_t *out_len)
> > +{
> > +	const struct pci_tsm_ops *ops;
> > +	struct pci_tsm_pf0 *tsm_pf0;
> > +	struct pci_tdi *tdi;
> > +	int rc;
> > +
> > +	/*
> > +	 * Forbid requests that are not directly related to TDISP
> > +	 * operations
> > +	 */
> > +	if (scope > PCI_TSM_REQ_STATE_CHANGE)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> > +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> 
> Why double braces?

Because of the assignment used as truth value. The evaluation of the
ACQUIRE_ERR() result in the assignment was a compactness choice that
PeterZ made in his original proposal [2] that made sense to me, so I
carried it forward.

[2]: http://lore.kernel.org/20250509104028.GL4439@noisy.programming.kicks-ass.net

[..]
> > @@ -50,6 +51,9 @@ struct pci_tsm_ops {
> >   		struct pci_tdi *(*bind)(struct pci_dev *pdev,
> >   					struct kvm *kvm, u32 tdi_id);
> >   		void (*unbind)(struct pci_tdi *tdi);
> > +		void *(*guest_req)(struct pci_dev *pdev,
> 
> We have pdev in pci_tdi, pci_tsm and pci_tsm_pf0 (via .base), using
> these in pci_tsm_ops will document better which call is allowed on
> what entity - DSM or TDI. Or may be ditch those back "pdev"
> references?

Not immediately understanding what change you want here. Do you want
iommufd to track the pci_tdi?

> > +				   enum pci_tsm_req_scope scope, void *req_in,
> > +				   size_t in_len, size_t *out_len);
> 
> 
> Out of curiosity (probably could go to the commit log) - for what kind
> of request and on which platform we do not know the response size in
> advance? On AMD, the request and response sizes are fixed.

I don't know. Given this is to support any possible combination of TSM
and ABI I took inspiration from fwctl which is trying to solve a similar
common transport problem.

> And the userspace (which makes such request) will allocate some memory
> before calling such ioctl(), can "void *req_in" be "void __user
> *reg_in"? The CCP driver is going to copy the request and response
> anyway as there are RMP rules about them.
> 
> And what is wrong with returning "int" as an error vs ERR_PTR(), is
> there a recommendation for this, or something?

Keep interface innovation to minimum and follow an existing pattern.

[..]
> > +/**
> > + * enum pci_tsm_req_scope - Scope of guest requests to be validated by TSM
> > + *
> > + * Guest requests are a transport for a TVM to communicate with a TSM + DSM for
> > + * a given TDI. A TSM driver is responsible for maintaining the kernel security
> > + * model and limit commands that may affect the host, or are otherwise outside
> > + * the typical TDISP operational model.
> > + */
> > +enum pci_tsm_req_scope {
> > +	/**
> > +	 * @PCI_TSM_REQ_INFO: Read-only, without side effects, request for
> > +	 * typical TDISP collateral information like Device Interface Reports.
> > +	 * No device secrets are permitted, and no device state is changed.
> > +	 */
> > +	PCI_TSM_REQ_INFO = 0,
> > +	/**
> > +	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
> > +	 * UNLOCKED->LOCKED, LOCKED->RUN. No any other device state,
> > +	 * configuration, or data change is permitted.
> > +	 */
> > +	PCI_TSM_REQ_STATE_CHANGE = 1,
> > +	/**
> > +	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
> > +	 *
> > +	 * A method to facilitate TVM information retrieval outside of typical
> > +	 * TDISP operational requirements. No device secrets are permitted.
> > +	 */
> > +	PCI_TSM_REQ_DEBUG_READ = 2,
> > +	/**
> > +	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
> > +	 *
> > +	 * The request may affect the operational state of the device outside of
> > +	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, and
> > +	 * will taint the kernel.
> > +	 */
> > +	PCI_TSM_REQ_DEBUG_WRITE = 3,
> 
> 
> What is going to enforce this and how? It is a guest request, ideally
> encrypted, and the host does not really have to know the nature of the
> request (if the guest wants something from the host to do in addition
> to what is it asking the TSM to do - then GHCB is for that). And 3 of
> 4 AMD TIO requests (STATE_CHANGE is a host request and no plan for
> DEBUG) do not fit in any category from the above anyway. imho we do
> not need it at least now.

While the TSM is in the trust boundary of the TVM, the TSM and the TVM
are not necessarily trusted by the VMM. It has a responsibility to
maintain its own security model especially when marshaling opaque blobs
on behalf of a guest. This scope parameter serves the same purpose as it
does in fwctl to maintain a security model and explicitly control for
requests that are out of scope.

The enforcement is market and regulatory forces to make solutions are
not bypass security model expectations of the operating system.

