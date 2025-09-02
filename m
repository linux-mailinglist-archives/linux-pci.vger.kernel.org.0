Return-Path: <linux-pci+bounces-35301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B640FB3F4F4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2706518985BE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 06:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B892D593E;
	Tue,  2 Sep 2025 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vo2q37RK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F7E573;
	Tue,  2 Sep 2025 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793094; cv=fail; b=A3ci7W7Xgi9dVxOZesL0p1/X63W/9oWd+iyvoIzQ0M7tb6aM0NlBWARWclzlNLjUcUwquBRsfazbm5X4u6/Uiu1KIqdCjbgzWyCK2ynx2/jiEMZHFaubFxSi/s7hDj1yqxutdnMzOhSPRByELRLSeZMYSB8goXR0Lc2ALK0tGNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793094; c=relaxed/simple;
	bh=3LmWeYNXr2bYg2SjivJtd2cDVDbj5XaUczhOKSNKvp8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NTHLZlxhjkqhJwjqG2BAjKHqRb5f42QGdZH0Hdwhh1C37mYK1zD8XEbjNs13P5apih3hpGI8AgTY7dEz2+pk9sjh3bhTJambxHTOVrdf0izf0qk3snCP4EnET8BXhrmwMmP7Zab8Ja4/grvA7uVQj+REch6P8MHi8cB9mxe6Pkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vo2q37RK; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756793093; x=1788329093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3LmWeYNXr2bYg2SjivJtd2cDVDbj5XaUczhOKSNKvp8=;
  b=Vo2q37RKAekWZiVS/WefBL5ksgKxMWZHrX7KDYdPT5U0hlJI5FhEEtjM
   hcCXCQ4CGfs1RCkrnTFCimG6VhSR6AABeXmE0l1SQRpcr7TG8CLWuzj3d
   LsjTcvk/0OWO0iywXfpJCclUC4GKkoA/Gr6eke9tLtR/Lh+qn7709VIcb
   j9YOJPJ1wQVGNdd7vf8JmsuVne+lJp7x1Co+X1gi88uBWTrkaI2WtwBOQ
   71Zl5QlCPB6hRHfmbQ+B2g7kbz3UgjutAeBMh/RvmxBjSoNLDMY5wu+gC
   EUijdiB4MbOQoyqUvRZ3K47sd6xpqHu201v1dlT056CXYW2rsoqSjgMgs
   g==;
X-CSE-ConnectionGUID: bjj6vUjuT5SJlm4ie3Jy2A==
X-CSE-MsgGUID: KJ295sIqSkOIz+pPiLzlYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="58252863"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58252863"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:04:51 -0700
X-CSE-ConnectionGUID: ca5AliOhRCaZPVeE6OLRpQ==
X-CSE-MsgGUID: 7gwfEJ6IRj66F/X/ikOaww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170447844"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:04:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 23:04:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 23:04:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 23:04:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1iEku4B+zHMvDCYW/HJLHb2kRr/Bq90d/n9p6IqdsOn5oJNBwsv5TJ9uSF48MKUADiFK37+NMD80P0FIhx6r7K9sdqtokpTZ9edBzSig8p+Yd+ILdxrG8PzQ/2Vl/t8rF5guh6fVkHtWNzOSeav07OMqfdHgq8hznOslhOyEWU+bypw2ZrlSI83QCDTYe3tfBOApMJNo5k8O4Ydwaca299bWOMdsLD2tD+LK1NKrtQLFvu4MNTHXuujz5Et2M5Pusa0gSe1qRTcqQJzYIjZ6SbX6bIUf58QoTy32qQxlUqKyorTApfK7OKMW3ineHcULWnUPmdHUwk8kAwWiRBr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5VuO5bHxN08OWlC4VsWru7bR9M9ucbAKbyvfJvQ/20=;
 b=YnpLlo3i834ZMJAfGD+JkxZStHkrSDc5pdwt5/r1X7IaEVZvIL1ua6BiJWNO7svmvpP5s4iN1lpKdicXlGm2CvDIkex41T0y1EmV1Q+gq6fm9P8uGi3Np0SnykpBEcQa4EtG44KctzXXgNG0UZ72DrUjFIaJxhvyAVwUAZ23JZLFaLVYhrWcYzT+Dzh+19PG9xL7sY9K1mCZxWEQ0oN/kdQSi1wdviE/qo1uKvcynWxGxEvoiugpYmnkhAMASgE41lBTBDLFHgn73Yn+gfr+tQtu3VJt39Sk1CisBZHAQ1lgQa47goqoGFUof9yPqQg5YewvJgRBCTXaCoUSSezGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by LV8PR11MB8770.namprd11.prod.outlook.com (2603:10b6:408:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 06:04:45 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%7]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 06:04:45 +0000
Message-ID: <7c8b72f8-b07e-4c18-9aa9-d971caefbbb2@intel.com>
Date: Tue, 2 Sep 2025 11:34:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
 <20250529111654.3140766-2-badal.nilawar@intel.com>
 <1c5ddf3c-5184-45aa-878a-48df2c5d6aed@linux.intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <1c5ddf3c-5184-45aa-878a-48df2c5d6aed@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::18) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|LV8PR11MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: f81297a8-a560-49d5-ee5d-08dde9e69dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rit1MGVtSi9YcEJpWkNNRlhnYjZSM1NZM0hLN0dFck1IMksrZ2E3U2VkOEkx?=
 =?utf-8?B?RnplWGJnd2x5amRUNXJVQ2l3RlN1ZDR4Nm5xRlNqRVp4YUhGU3BlK3B1MGxM?=
 =?utf-8?B?aGpKTFplRXNsMkcyL0hHQU93d3JpZytxYXQzYWRFVHY3RURtTFI0MHFwbEZ5?=
 =?utf-8?B?VmY0TC90RllzTGNkWjd4WnFHVHk1Um1Pa3plWjdoSEpNZkttTzl2STZqYTZq?=
 =?utf-8?B?Qy9kRXNpSWlxakE4eVBUeFBJbVJvZWNkRFBhR1Z4a3QwRFBhTjJ4WlprZGpR?=
 =?utf-8?B?Ylh2V1pZM2pRYUtsYTI2amZCZGNuRmN4cVVCOHpON3cxZWpXWjBPYmhLSThj?=
 =?utf-8?B?SGtaalFKcFJoYlp4eUpnQ2RPM2ZIeHhxNEZoVnF6a0RHbzVUZTRqNS92M3hF?=
 =?utf-8?B?dzBMZ0M3QjdsVHlBK1hRS3Noc1B0RzExVU9TRXF3UzI4UGtuUGJRSjgvQ3Bh?=
 =?utf-8?B?YzQwQ1lsR25XdmQyM1JlaW5nSjlOejdGa0ViV1QwbUNHbXp6ZzNTdWpNb1Zt?=
 =?utf-8?B?VXIwdmN2K3RZanM1UGxRZmR3dFVKcFN5bDF1RThIUll5bjNibXlxVmdFeVI4?=
 =?utf-8?B?QnZSSFNnN3gycTBwL09VZk5PSmVEYlFkNnc4Sng2V2hBeHYyVVhxTllEZnNq?=
 =?utf-8?B?eW5HV29LVWttUXlNZTVuSUlTMHJxalp6eFBYTGs4NVZJYTlSeXBiWUtBdXJp?=
 =?utf-8?B?MXZRK3V0bmtVZVhSRTFqM3dQdmdxblhrR1NRNEJBQURxRXdhRFk4NWpERlht?=
 =?utf-8?B?Z3B0ZDhJRjRPT0hSZnpGTm81aTlXalB4VTQ3WkhaNjRWTkJOb0xZWjBPUXlP?=
 =?utf-8?B?c05xL3psRUlabmNadGxmcEwxYktCZG02QnNWNEc4THN3R21hbUI2M3JFMUps?=
 =?utf-8?B?MktsVGJjbzBoWTA5cEVJQlB4akF3QUtkWTdydG8vRmlmcW1nRkFDbFV4NVJn?=
 =?utf-8?B?cURESDZwMGF1eGdLNld3RzNHbXlraWtWQ3lDTy9TWmhWZGpnNHB2aHpuZktV?=
 =?utf-8?B?dTRKRUloSUFTZy9jSDVzQThNR2NvbUV0OXNROTM3UWVRVzNZNVg4QVg1VjQy?=
 =?utf-8?B?VXE1Y1Q2a0dPdGtTMnJJZ1UvcWZFcktmNUxxT251eVhRdFlvVFROc09vRXBC?=
 =?utf-8?B?bG1RKzdLRjhwRkUwME8zTXJ3akVzRitjQ0IvYWFZVFc0RnEyemI3cU4wdnBk?=
 =?utf-8?B?Y2E2eW01ZmNoQUgrWEd2NE1va0dCL25BWk5FZEtnVkhQc0NEMzhETGpIZWdr?=
 =?utf-8?B?emRrb3lIa1l3SHR5RjQ3czh1Qk54L2Q4aU1YNmlIa1RHU3NUKzhmNjh4YW5l?=
 =?utf-8?B?Qmo5dkg1SzhTTGlKaC9rQ2FuN2REeXZ1RW94NWRiR0lqTXBlOHZNcHVTWDd4?=
 =?utf-8?B?L3hYVFhvakdaOUhIVjVDT3Q0YWFzbG1qUHB5c3BmMVlMWjRuWndaWkdPR1hN?=
 =?utf-8?B?cjBSNlNaYlFpblB1UjExd2R5YVppa08zTU1aekpGeDlBM2NyMG52SXhMUktN?=
 =?utf-8?B?ZlBrS2g0elZQRWloT01KUGJkNi9QeGUxeU1pNmxVNTZkVzhqRzQxZFErOVBP?=
 =?utf-8?B?MUVzcGRQa2FHWWRvWWVzWXFXVHhNdyt6SFNTdVh3bkVDRCtWeDVNVTNXLzdq?=
 =?utf-8?B?QU8vTWNiTG5COFBubE1NWXhNT25vUC9UUVN2Wmc2Q0duQ0dFMUhaYVkvYjRh?=
 =?utf-8?B?UFk1RkNjeEZydkgzT0tnNmRGZFN4MEo1WjBvUlBnN0ExbDZ3NXpsV2tpVnpK?=
 =?utf-8?B?NFhyMGltb1h6M2JRTlBsZEtyYWNsWm1VVy9QNThWMDZZQ3VoVDdJc0NURUg3?=
 =?utf-8?B?MW0rWlBMNDZINFRNS2RrWlJSOFBmeDZGeFQrbzJZdUhMWXNTQm1kMVZWaGMr?=
 =?utf-8?B?MnV4OEhzcjN0d1lnSk1BVnM1cXpEclhwejJKZi9CZExuODNRblFwVkdHZVVI?=
 =?utf-8?Q?8iq0Yf0qSJM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkVxVy9ZZXlXTVRjZjd2VDd1OG5TcHpaZzFRT2dMOENRYmNVcFR6bkZVTGti?=
 =?utf-8?B?cGliRlN6dEpYVDJMMHRKTEVBbnZqbnZMd0dESlFTTTUxVGdHVy81VWtMR29C?=
 =?utf-8?B?VC9mOG1XRllUUnRWRno4c1doZ2hiWVYwTlRENkFJVERmc2dvNzNGRndaVVlv?=
 =?utf-8?B?ZTU2Q0x4ek16bzJsZUJISU9vNXJ0K1R6bE5RS0k4OXhSWHFuYy9STUordk00?=
 =?utf-8?B?Mk9qUGZuTzJlQldPTFpDc3BQdGlWK0VpeEIyTGdsU2NCSWIxaXRBbktmaG9x?=
 =?utf-8?B?Mjc3VSs3NjdkZWpyQmNneEdycnM4WmlrbzlGa0FzenhjYVhKM01iTW42bENk?=
 =?utf-8?B?cHlpY21MZnZCTU1RVVZIbGluTG0wcU42Njd4UHZvZEliQTZONmhsbGtRaVFs?=
 =?utf-8?B?YTROUG5kTE9LVVdxTHdkWDFuYVdBQWVXN3dvSkZBNEZnazlvWExmM0l3eWhK?=
 =?utf-8?B?YWVTejVOOVlYNHpMRXFQWXU1cUJFOW5UTjEwdlNvbmNDbU9za3lmVXNYeGhn?=
 =?utf-8?B?ZWpNQ2JQMHZxNnZRdTh0YTRpMzBvb05mdUJSRnp1d2hKZHVTOTdaZC9uc0FQ?=
 =?utf-8?B?MVBpSGZFNDM2UHdjREEvYVljUmpzSjY5YUQ0L0ZXU1VvWWNCMUZYQW0zVmNE?=
 =?utf-8?B?YlpURUw4bHJLQVROY0Vad2lGdjlMNGZpaGFNYnpqaFVMQzVhOFVmdHp0cUxM?=
 =?utf-8?B?bm5neS9OL0dMZzZNaDNrRDlVTkg2NnNZQThpY01xeVBIRmp6Zk1TQnM3NEdp?=
 =?utf-8?B?K2tZa2svUUoyRkNJYkxYeFFUWlgyMnpGcWNvbXp1M0NpZUlkbG03NUZIZE0y?=
 =?utf-8?B?R1RoLzRDQThseUlONTBEWGoya20xdFgxYSt6OTM1UzEvdVdpYUhhV2tOOVZG?=
 =?utf-8?B?cUp4Zk9qdlU1UXRmbGJGbzNpZ0Rad0EyMHBhUmhWc3dXT21WZ01jWnArTGwz?=
 =?utf-8?B?UUw4cnFCRG1zTDVMT0dwY2tFcThycjIvVEhRY2tTeWpnUmVGekJ3d2FjUzJa?=
 =?utf-8?B?c0FGcFZjV1AvRnBkU3hnMGU3cEtrdUp2NXhLS3B4emNwWStHSEs4dlFDTkxk?=
 =?utf-8?B?YldkS09oZW9tdmEyaW4yTnVITkNXZFFoS3RLQVByUDdILzJvTlB3Y1BiRmIz?=
 =?utf-8?B?UkZJL1hyMVA0NFZiZm9VSHJFU0V1ZXJBTyt0ZENCVWYydk5nZzdpSE9mL2tV?=
 =?utf-8?B?T3MxZzJzYkJhdWZnUldCVDFUUmJlNE00eEovODFhNWxCN2UxZ3Z0RkJuNXN6?=
 =?utf-8?B?anBteFdOV3dqOGcvSTErYnJDNFovYkdtL2F1UmlUc0F6UFFLSzlvVEt6RGJB?=
 =?utf-8?B?alUzQjNHQzN5Z25RaFMwd3kyMTlqZVk3WEx2Z0VnS3lqaDRoV1RBajh0UlB3?=
 =?utf-8?B?UzNONUppQ1dFV1VhalZudldGZlA4Y2ZSbGtjbXpTRmhCU0h6U1pXRjZBRWtN?=
 =?utf-8?B?SVhCZFhTQ0JwaXRidm1BeXZDRGNzd0JoY1VVYm16VlBPdm5xZi9YK0k5OXZL?=
 =?utf-8?B?Qml0d3lGcDhSczlKYzVIR1MzeStibHFDdnBDQVFwWXRRanJLUFhGeHlpYTFX?=
 =?utf-8?B?eTMya3ZZS21EV1lMK1VxTWpCWElFb3p1eThZNy8vOHpjZHh3TFB3MlVGdEl5?=
 =?utf-8?B?cUtyRkhWRW1rajF1dE1sOWdQR2VGU2tjbkFWMTZIallzYW5Hck94U2NKdjdt?=
 =?utf-8?B?bXJUblh2UDV3c01nTFpYc3ozbWhzQ25pTkJlaDVnQ1dTUjAwdE5WRnBMSVBo?=
 =?utf-8?B?MW5FK3FHVjN2L1Z5WGwraG12UklUZlMrR3paMjB0Ym1jVTlHSE5xWTg0QmJW?=
 =?utf-8?B?ME1FcmNUQWt4dEdGQ2ptclkxd2ZHczh1N0UyYkFvSE1pZmkxR3lpMENiR096?=
 =?utf-8?B?bitVMXZOOEtVandMS1hOV29hanFtV2RSbnBPbkV5Y2VmZEhzY0VtTVpWT3dq?=
 =?utf-8?B?QUVxaDMzbEsrc3dUSG9tZ1BIdmVSN0NVSXp2YlJhYjBEU1pldGw4VjUrTWg5?=
 =?utf-8?B?ZUIrMk5ld1U1V2ZNdnNnVVE2VDhsUlZPZVR0SGp4TXUzWDVUWEFnRUZyTndK?=
 =?utf-8?B?WVFwNVlkMjU4OGdUUlJTVEhqUm96d2pybmZObVNYWFFVdlJ3Y3kvOFprelhj?=
 =?utf-8?B?QjVLWE03aE9WcjFlUjRHOVBqMkVqdERFMVZTTzFqdk1GREg4VnVMc1JmTFRx?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f81297a8-a560-49d5-ee5d-08dde9e69dba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:04:45.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O58ZkRXQoF6x+n4IPr2lz+QeMM9I97oPYAPUdiIpbI7r8VhQgsrzr0z6dsvogX4FslAVkJa3kRNNLW25GE9wxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8770
X-OriginatorOrg: intel.com

Apologies for the delay in response.

On 30-05-2025 03:06, Sathyanarayanan Kuppuswamy wrote:
>
> On 5/29/25 4:16 AM, Badal Nilawar wrote:
>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>
>> Implement _DSM method 0Ah according to PCI firmware specifications,
>> section 4.6.10 Rev 3.3., to request auxilary power needed for the
>> device when in D3Cold.
>>
>> Note that this implementation assumes only a single device below the
>> Downstream Port will request for Aux Power Limit under a given
>> Root Port because it does not track and aggregate requests
>> from all child devices below the Downstream Port as required
>> by Section 4.6.10 Rev 3.3.
>>
>> One possible mitigation would be only allowing only first PCIe
>> Non-Bridge Endpoint Function 0 driver to call_DSM method 0Ah.
>>
>> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>
> If it is Co-developed by above people, you need to add Co-developed-by 
> tag followed
> by Signed-off-by tag.

Sure I will add Co-developed by.

>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> ---
>> V2(Bjorn/Rafael):
>>    - Call acpi_dsm_check() to find method 0Ah supported
>>    - Return retry interval to caller
>> V3(Kuppuswamy)
>>    - Add NULL check for retry interval
>> ---
>>   drivers/pci/pci-acpi.c   | 87 ++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-acpi.h |  8 ++++
>>   2 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index af370628e583..87f30910a5f1 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1421,6 +1421,93 @@ static void pci_acpi_optimize_delay(struct 
>> pci_dev *pdev,
>>       ACPI_FREE(obj);
>>   }
>>   +/**
>> + * pci_acpi_request_d3cold_aux_power - Request aux power while 
>> device is in D3Cold
>> + * @dev: PCI device instance
>> + * @requested_power: Requested auxiliary power in milliwatts
>> + * @retry_interval: Retry interval returned by platform to retry 
>> auxiliary
>> + *                  power request
>> + *
>> + * This function sends a request to the host BIOS via root port ACPI 
>> _DSM Function 0Ah
>> + * for the auxiliary power needed by the PCI device when it is in 
>> D3Cold.
>> + * It checks and evaluates the _DSM (Device Specific Method) to 
>> request the auxiliary
>> + * power and handles the response accordingly.
>> + *
>> + * This function shall be only called by 1st non-bridge Endpoint driver
>> + * on Function 0. For a Multi-Function Device, the driver for 
>> Function 0 is
>> + * required to report an aggregate power requirement covering all
>> + * functions contained within the device.
>> + *
>> + * Return: Returns 0 on success and errno on failure.
>> + */
>> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 
>> requested_power,
>> +                      u32 *retry_interval)
>> +{
>> +    union acpi_object in_obj = {
>> +        .integer.type = ACPI_TYPE_INTEGER,
>> +        .integer.value = requested_power,
>> +    };
>> +
>> +    union acpi_object *out_obj;
>> +    acpi_handle handle;
>> +    int result, ret = -EINVAL;
>> +
>> +    if (!dev || !retry_interval)
>> +        return -EINVAL;
>> +
>> +    handle = ACPI_HANDLE(&dev->dev);
>> +    if (!handle)
>> +        return -EINVAL;
>> +
>> +    if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << 
>> DSM_PCI_D3COLD_AUX_POWER_LIMIT)) {
>> +        pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", 
>> DSM_PCI_D3COLD_AUX_POWER_LIMIT);
>> +        return -ENODEV;
>> +    }
>> +
>> +    out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>> +                      DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>> +                      &in_obj, ACPI_TYPE_INTEGER);
>> +    if (!out_obj)
>> +        return -EINVAL;
>> +
>> +    result = out_obj->integer.value;
>> +    if (retry_interval)
>
> Since you already do NULL check at the top, you don't need above check.

Sure, I will fix it.

>
>> +        *retry_interval = 0;
>> +
>> +    switch (result) {
>> +    case 0x0:
>> +        pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>> +            requested_power);
>> +        break;
>> +    case 0x1:
>> +        pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
>> +             requested_power);
>> +        ret = 0;
>> +        break;
>> +    case 0x2:
>> +        pci_info(dev, "D3cold Aux Power: Main power won't be 
>> removed\n");
>> +        ret = -EBUSY;
>> +        break;
>> +    default:
>> +        if (result >= 0x11 && result <= 0x1F) {
>> +            if (retry_interval) {
>
> Same as above.

Ok

Thanks,
Badal

>
>> +                *retry_interval = result & 0xF;
>> +                pci_warn(dev, "D3cold Aux Power request needs retry 
>> interval: %u seconds\n",
>> +                     *retry_interval);
>> +                ret = -EAGAIN;
>> +            }
>> +        } else {
>> +            pci_err(dev, "D3cold Aux Power: Reserved or unsupported 
>> response: 0x%x\n",
>> +                result);
>> +        }
>> +        break;
>> +    }
>> +
>> +    ACPI_FREE(out_obj);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>> +
>>   static void pci_acpi_set_external_facing(struct pci_dev *dev)
>>   {
>>       u8 val;
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index 078225b514d4..6079306ad754 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -121,6 +121,7 @@ extern const guid_t pci_acpi_dsm_guid;
>>   #define DSM_PCI_DEVICE_NAME            0x07
>>   #define DSM_PCI_POWER_ON_RESET_DELAY        0x08
>>   #define DSM_PCI_DEVICE_READINESS_DURATIONS    0x09
>> +#define DSM_PCI_D3COLD_AUX_POWER_LIMIT        0x0A
>>     #ifdef CONFIG_PCIE_EDR
>>   void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
>> @@ -132,10 +133,17 @@ static inline void 
>> pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>>     int pci_acpi_set_companion_lookup_hook(struct acpi_device 
>> *(*func)(struct pci_dev *));
>>   void pci_acpi_clear_companion_lookup_hook(void);
>> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 
>> requested_power,
>> +                      u32 *retry_interval);
>>     #else    /* CONFIG_ACPI */
>>   static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>>   static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>> +static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev 
>> *dev, u32 requested_power,
>> +                            u32 *retry_interval)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>>   #endif    /* CONFIG_ACPI */
>>     #endif    /* _PCI_ACPI_H_ */
>

