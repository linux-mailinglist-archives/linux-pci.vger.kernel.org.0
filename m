Return-Path: <linux-pci+bounces-40177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD01C2E8F1
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BF634F2135
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA91E9B37;
	Tue,  4 Nov 2025 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWdJ1MCd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD71624C5
	for <linux-pci@vger.kernel.org>; Tue,  4 Nov 2025 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215238; cv=fail; b=DtF6W9zbMvZMTSPlaaTtcMzj2uv8psnjyCh8I1fk9155GS556NBxtOPiT5b1UMxU/IL69YZTlScLpzweiWQ01UFT9EvIwaJpHmCloaR+3qKXRG9eJfhNSMC6QaNotiI1GiM4l8sNQrciHkymZRQlLPKNB4GGszOKm9jNxwlN8Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215238; c=relaxed/simple;
	bh=Iux/RH2Y0/+saQx+T0kLGD7dr5HaGKKKGjeMxZfTMfo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Pwi5N17IdKVpM6wR+/XQ3yujyivk8lZxj+rXQt/ye3ZMSlOd8SD/URfcygYm9dDH9ZOSpFUDHwNv9PSyZNy2oErtnl9HHTYSxXShPHHvkHyxckBYJLFc1TywTX6HSI+3TnhXrke5Gb6mU/YIba8NIX0x50KdfAnUOecWuf2a30M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWdJ1MCd; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762215237; x=1793751237;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Iux/RH2Y0/+saQx+T0kLGD7dr5HaGKKKGjeMxZfTMfo=;
  b=JWdJ1MCdlWgPWMbCP1JvlbJ62U53J4Gl0X23RIVBoGR6TxiNHrhFoRmX
   WWkBQievK6stP9DHO6mY6eYttgfpsBXEUuLDLJRse/L5miuH60EAQIexH
   q+eF4O6+0eHxvXVBKTtNDh47B/T+8YN9VSPYS1YgBx/PGO3SU8IhF47Q6
   +9RmbEjNOCCbbNZTkc+CsTrWLomNJaIa7njtwQkUkm0n5SoTgJaHk2F2B
   H3VYAFtrLpBx0OumSErZI6e5FG0zPLTzzUeN2MC02kJm2v47Nb4apTsdf
   wEi3IIHg2RmKR4WyX/8TKihukyjOXoCwav+oy45+JUsur3mdVoqaR47V5
   w==;
X-CSE-ConnectionGUID: TY+kjZvAT/GA0eHOGYi2tA==
X-CSE-MsgGUID: xzIX6YkzQzCuTDeiA2h4Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="67956672"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="67956672"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 16:13:56 -0800
X-CSE-ConnectionGUID: cChmzD3gTEaLYY0/xOzXvg==
X-CSE-MsgGUID: ANjrRKAYQfGu/EN4nWmf3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="191094554"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 16:13:56 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 16:13:55 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 16:13:55 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 16:13:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVrrpI+FwIWAVgx9q19GATDZDpeAtx9PiliFZO6dE9nShJd0FPFipwr9cxhbjmvIxb52cQn1gIny6whRyLIoOuRr1dFgP3pmx06Rd3ulnJF0I5ExzlweUQu6eEIj/Kjl9CVJgreERQN1J1fyvW+s7xVgBCAOfpmZEj7PWoJzHbFE646An1Xs2R7bydKYSR8GIWEwqao8m/oOjSkqTczaGr57a4AFhYznTp6F17aOK/h7azRUqjJr4kP0+Z6ulOR+A79I2sgvYGPj9qMkIfwKlgSLroWUXmfDMOpsa+OgYVQblw4Budd9OF+iSydb5gXtW2/g+2IrvFHyjqiab8qQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x50muPfsKP+6BT3DxWBAQoLrAc++TrQgLlgo82RFlY=;
 b=XKRYJjKEKDQk2mvtZ82cCcqsZ8NUY71/j7rYM+nIJH4Y0Sedvz7KQhSzZmFtcAB1sDVugsclgw03OxYkbiTBLiiVh20TntQnfEr5kLyxUmEanggtcTDoqvjYAWTLCvimJHCU+lpovhgYxC0YL+851MsB8+6eL/iJ12BQJvQ5xkhpYKeYiDJablTu1vZgjF/ayQP6LXjNd5OgcNcddvW2kj8oF8durPxSebr9PrJ+MtMJZGItuoL5Im6GXbyAqAd7YffAsuu2xusR/k1aD26ZimXUDFyTe7TCeBLs2S4WGy9+IqNCkQM9i960TL5H7eouEF4Z23cZ7BT+tIGxFI7uCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8300.namprd11.prod.outlook.com (2603:10b6:a03:548::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 00:13:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 00:13:53 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 3 Nov 2025 16:13:51 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <6909453f94ad5_74f591003a@dwillia2-mobl4.notmuch>
In-Reply-To: <20251030114353.00007c92@huawei.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-28-dan.j.williams@intel.com>
 <20251030114353.00007c92@huawei.com>
Subject: Re: [RFC PATCH 27/27] coco/tdx-host: Implement IDE stream
 setup/teardown
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5ff202-c576-4ac1-8a43-08de1b370972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEM0bSsrcVlOb014dyswWlFsY1Z4a3hsbUhQeUN4MDgwU3U2dmdxbGRiNTlx?=
 =?utf-8?B?UXFJU2M0M2NnVzFESHNZQ29aR2JvZFVmYVhEVDhMMVpveXNjczI5cmg5d2VZ?=
 =?utf-8?B?b2YwN0pXWG5WVTNocjNETFJERjNGbjhPUENLK1lzUFBRY1UzUmZNcWFCTzZa?=
 =?utf-8?B?andSK0M2ak16SDRwaDhXOHVyZHhqbXBRc01HMFhYcEJya1QxVE84MjdnK0Jl?=
 =?utf-8?B?TUVidldqRkQ5SzY2V3p2MGNZOEVQejNJWGhNZ2ZpUFFOclNXMEIrRGhYTWZC?=
 =?utf-8?B?dnVDRGw1Z1dJeVFxNThnQUNOVytJWktZNWs2VDQwSE1Dc2o2bURLell1Ukp1?=
 =?utf-8?B?NEN0OFA2MTJjRWpVcVZwOG10Zi9MYUNtbXc4NjFEZHVjUkMxWVNrR0ZPdTVF?=
 =?utf-8?B?c3gybUUwM2x3aDJKdFdIQkMxSk55cmhPUkY4bndVaFlETnFidkNzWTFNSjh4?=
 =?utf-8?B?bmNlM0M4K3F5NldMTmFOQnZSaXFMMGREZWlUTDF2RkRtT2EzVEtsdU9ycEJN?=
 =?utf-8?B?VXROWlFzUHRCN0pna0ZheUxINEZMMzdYS3loYzR5aGxTb09EblJVSU5RQ1Js?=
 =?utf-8?B?WGk0M1dUSThXU1gweG4xMjRhanRTSWNkWmt3MVZKbjZvdnFzVEgya09rdlAx?=
 =?utf-8?B?d1JKNkd2U2RDYkdyMVg1d3AxUzd2RVBtODAra1cwK1NyS05ObzBmd05IYnBo?=
 =?utf-8?B?OVpQNHIxZU1Ca2M2TXlrZzYzTEw2WURNb2dxQjZlVWhOK2k4Rk1mYzJicGhH?=
 =?utf-8?B?UmN6cTBUSUdUWUpwNnFDWTVyemZrdWF3d1V0ZFRkTFJNNGxtNldHRTY1RTNY?=
 =?utf-8?B?S0x6eW5md0h1UGpGYXZFWEZSdHBOdFJ3T2ZZRzdhZHJQZ3QxNE9iS3JqL0hX?=
 =?utf-8?B?aW5wVkVETElyeitHeDdtTmx2ZXVBY281Y215Skl2Z0V0L0V5bVc5WFZId3do?=
 =?utf-8?B?SzlvQStjVUpMSnp4UDlNa0trK1pFUWZhemlqSHZZWVcyRXdKOTlLQlVCYk45?=
 =?utf-8?B?azUwWDRFZEIvWDNsUnp6dEVWWi9KODRqVGsyOVVzQmtsSDEzVnpFSFVxRFFH?=
 =?utf-8?B?ekFFcVl3MDk1cUFJM011c0RPYTBTWGsxSEtnQUlxalVheVFNTGZpQlE1SnB0?=
 =?utf-8?B?ZmpLZHE0Vm45NlVoRGJ6YkMxZ2pxQ3VYbnRERmRweTlFZUNoMUNZUkYveXdr?=
 =?utf-8?B?TU9yNWNFS0VGTXY2QlhKL3RrRk5ETkdNT1ZQSk4wMFdqQmVKVmQyc2NkN1pJ?=
 =?utf-8?B?OFJReW1JNkFhS01LM1o5a2xZNFRSTWU3ODNLa25VUGM5emRNT1ZJOTlhbTFB?=
 =?utf-8?B?T05DSUN1NlJSSEJRcHB1dmxVK1hXTDhWcUJtaXFMbW95N3dwdjJsWXVDa0dF?=
 =?utf-8?B?aFdiZmZXeUF6bVhPOFViRTJrVU1SZUtFRU9xRmozNGxwSloxSS9sbGxYZXF1?=
 =?utf-8?B?M3dhWDMzV0pKOHNkWC8vbngyY2N6TlcvM2NWTStBWWQwOUdIbjFzR3pUVHJt?=
 =?utf-8?B?cDRPU0pzTjJtVlNSUUVNS21acUNSSmtnRW1EbURZenZHeUJCNm1ValFsSDRu?=
 =?utf-8?B?STVFb095K0RrcUNEK0Y4aDRaZE1taGVwS3AwYWFLb2NSWDlVL014NmxzVWR2?=
 =?utf-8?B?WTljTnVmaDR6U2lHZ2xIbGhkcytJK0hCRnNZRFNTVGlPTi9RTlEwWDg4NFg3?=
 =?utf-8?B?aWhvbStDRjFSbkRyazdyUVYzeVBZWFczOWhjYlpzaUVVdmtqRHVCODhnend0?=
 =?utf-8?B?M2h1ZnQ2TmlzSWQxSEUxRFNYVlJFa29Id3h4bk04UkJoVXZ0em9KTXZXSWJw?=
 =?utf-8?B?dGlMeTBCNlJCR2VwOHMrS1hSVWNlMytnd0NqWmVLZ093ZjM1d0U1SFI0b0di?=
 =?utf-8?B?T1FWL3MwWUYwYWpZeVpaTjY4Y2JJd1Q2MzVMUUVpbkxid0QrWFdHT3ppWm5n?=
 =?utf-8?Q?HIJogZFzQxsL0u1VVNzs347alWlpILou?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U01BTERqMGhUUUo3a0pCN29ETEEzSzQ3cmNuZkNZMkxzaEozbUI5ajU4WUFP?=
 =?utf-8?B?WEUySmNGdUtHdktIcmNBbjd2RE5tcjk5VnFOdmQ0Z0RmZkdkbk1uTlpoK1NO?=
 =?utf-8?B?NGpaL2pNZk8zOTBCeXhtb3h5M29CWVZBcjBuazNXdzFlU1kydWZTYnNldzh4?=
 =?utf-8?B?cWprSHNMK3djSzVhMWxGUDFyUExVZU5ja0tVZlZuT0IwOHRzR3dBdXlFeCtO?=
 =?utf-8?B?RmZQNnhoQXlVRVRla21OMy9uY0plTnpKRS83T3plM0xQeGhhNWdtaXZmWG5Z?=
 =?utf-8?B?ME0ycW5abjYxTXFHbTdQQXF2eVhpNVpHYWliQm9KNWZjSEFGQ05yS1djNXBI?=
 =?utf-8?B?RiszLzFUQS9JdmhMVEY0U3lFMnM0NnlZcnQrM25VNWt0YWQzY29xcHNHUUs2?=
 =?utf-8?B?KzdlNk5WQk54RDFpUlFwOENzc0EyMTRIZEpFUmQ4Rk5UQng1MHdmUVJZa3p6?=
 =?utf-8?B?S3hhY1hOTHhsZEwrVW9iSzNVcWpGK2lKS2wxZEFWTEJrMm9pSHNCckhwbEU1?=
 =?utf-8?B?UHZsay84aDFCVUM2L0tCb25ZUkVZL1ZlbFZuaW84WU9KVUc1ODd5Q0VwL2tx?=
 =?utf-8?B?RmhzcjRBbFBHaWZmQStub1g0R0NKbHhyQkVBWjVQWVRlaldRakpTZHJ4SGJs?=
 =?utf-8?B?YnpXWnlSRkl2ZGd1TEJVdEs5cFV5by9wTnI3OVpiTHVNYzA4c2dwQWRFS2dl?=
 =?utf-8?B?RUcwYjNLeE56QkRSamtDajdxc0o3WCtMRE4rY1NLTlBNVnFVTXlDNkF4Z3VI?=
 =?utf-8?B?bUZDcDZ6WmdGbUtSZmRhRGdCc1o1OExnc3ZCRnZsS0tOMi9UWGRxOStVaTdD?=
 =?utf-8?B?blJVdmFBTTJEMWRIS0xLQnVzaFBkZk91UVFHTnk2K1ZKT0RRYzlhMGptK01i?=
 =?utf-8?B?alI5L1IrZDdRSXlsRFQ3dWdjNUlzV2R3SjZwWTZPVW9nT0IzNWl5V2p1RXZL?=
 =?utf-8?B?bnpNb3Y1ODJsZ2puamhPTCt5am9NUDRPSi96MnBhVDV2eW9iZEVyeE9zbWRt?=
 =?utf-8?B?WkUyellvL29vQW0yR0dXZkJuL2ZBU2VBZ3RjU08yZWM4NXlWTlg1Z0gyaTVv?=
 =?utf-8?B?RUlhUlR5K0VNMnRBclRFNmgvY0hteUFlZGtvSk5aS0JrTjRXS3ZxQzNha2cx?=
 =?utf-8?B?M090cmxnVHBoMldpWGVOSHAxRnIwN0VhcUsyTUtRd0FzTWxHQWQxaS9RTmxD?=
 =?utf-8?B?V0JaclE3ZjMwd2V1VUtENnViSmpiYUErK1JvOTd6UmdJdFFsaGZyd0F0M0sx?=
 =?utf-8?B?MUhzNXU1ditoRVZhQVdyaVp5UU1HYjJMczRhWWhPUFVaOTY3ZVJiS29jUTNo?=
 =?utf-8?B?WlQ4SWxDTGFrN2VTbTFRaHZvN1BJdDhpRlNXVi9JeDlzR1pvNXIxQ0l1NWc3?=
 =?utf-8?B?U3N1MjBBMGQySi9tZEdBYWl4bUFPekRraFNOOVNqaFNsTERZbGE2ci9QcFNZ?=
 =?utf-8?B?d1pxMDdDcjlMZzRXNUQ0MlBaaE9iSXQ2d3UrUElvaUhGbC9PcXZqRlB2VUly?=
 =?utf-8?B?bkVycS9wdXJVNUJqajZFVlgyck8zVjQyQTdGYmswWDNEcHR1dHZMMXp5bFg4?=
 =?utf-8?B?Wmo0NkVscHZ6SUZEdHNkVWVIMUZ6UC9RZ2QzQ3Z0RTRJZUgxZ2Z2SjZQRGZs?=
 =?utf-8?B?dHQyZ1hpWGdmWnYzaDQ3d2RPMWVvYi93UVR2bTBYNnNlbzlaZy91dFZZTEY0?=
 =?utf-8?B?R1F0QWVaaTdxK3NiQ3B3NVJjTDBEQ211ZE5jU2YwdThTM3NJRjhDNmY5a3Ev?=
 =?utf-8?B?ejA0QnNWVFdDN2MzMDlBSkloL3RXY0xxUDZuZE5xT2hWdTU3UnhGTEhVbGVL?=
 =?utf-8?B?Rlh0d2FmRUNjMFQyYW44b2NRY3JhVWN1RGZLMStxRmQ5Y0YwQWUyOFc2WkU2?=
 =?utf-8?B?Y1lkeEhteGxLSS94bktvRFNmWm4vcytyS09pUDVEU1FLMldKQ2EyZzVVZFhS?=
 =?utf-8?B?UThpdnFEK0NSNys4em9Ob2xQYUljb1lXOTVJdG9QYXJQQ053QVJ6RjF0bzc1?=
 =?utf-8?B?VWd5RlFXNzJsWEpRYzhldlNacEM4Z0N0MjlEY043SS85ckhvMit2YVVjOERI?=
 =?utf-8?B?Y0ZOOThJbUNHVFdYaSs1b2dTOFhrZWNzSHl1T1RRV2thUk8yVmRhYjBkbEZS?=
 =?utf-8?B?K000ZEVtNkRTOWtXeVNsOWVxNG51MWp1aXpZK3BQQnhTYzBVblhON1ZzZzB2?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5ff202-c576-4ac1-8a43-08de1b370972
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:13:53.0846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQ62z6mvV2yPXdETcXUXcoDNIhO9hslnSinotIdBRataHH0SYBmIPW3E+zz2gxlScMj2ZwKCJwyS08OAjMglnPGVVhrXvomSuJ2fHfK7s3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8300
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 19 Sep 2025 07:22:36 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > 
> > Implementation for a most straightforward Selective IDE stream setup.
> > Hard code all parameters for Stream Control Register. And no IDE Key
> > Refresh support.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A few small things in here.
[..]

Ack to the comments here and previous ones.

> How is this set in any path that gets here?  Looks
> like it is only assigned right at the end after all error paths.

I think some of this gets cleaned up naturally by switching to an
__free(pci_ide_stream_release) scheme similar to the sample
devsec_link_tsm_connect() implementation.

...but yes revisting this function's organization was on my list of
things to do before v1.

