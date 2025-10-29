Return-Path: <linux-pci+bounces-39719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE373C1CD93
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52E03A979F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EBC225397;
	Wed, 29 Oct 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aD5od4/9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF62DEA7E
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764251; cv=fail; b=Ux6zCOgGIVbHkjSYCTPiRPylckKn0lrDavqlHeq8OAjVVTzFpto2a+QdH9J/3JTf3rzN7UIxxdLL0c4UCFJyc+VZVuBlUea3AKggoJXcj4rddiSduuDKwm6IXDDPdoJnYUbNJz5LX3hYz0qtp2dTIOdor9rV70KF74jNXdXlRJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764251; c=relaxed/simple;
	bh=OB0VdPhrt7O3pUKZvHezzm4d8/CXGFYDbSbRBJQ04SQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=A/DrQz4R4NiToXbYRGLQchNsI7YTK/xKD6TiQzT2LP2+qLHegyGZ9PbUhGC0dXbMECAzs4J1eAJp35cepr312Z7Plt8KBLcYeABtpYExsMSIlKxnXgqWGUgjUT6trOCdDuKstKPI9/wmHm/UlpInZe83z62cIjzK88rGJDsG1Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aD5od4/9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761764250; x=1793300250;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=OB0VdPhrt7O3pUKZvHezzm4d8/CXGFYDbSbRBJQ04SQ=;
  b=aD5od4/9rbtvmIJYFqj2OzWnWZuKvupHogloflDoc9+hmZpRWwcIArzv
   LjDBx8oNQNbZ6sOQvkhVCi0FbeBHg5NMr97UZuoHoCLy1lyqRFYeprcls
   0243aLFE0aYT5Q8xsKcSNRLqG2g2Evnc/gUyyHxbjwk1l9pt1wByz4wsd
   xfxF2h1C6P2npBebKTS18V8Y5m5mAeIwRNfAFvDUHhYo8U/3vVaOThSEp
   ZPWinM0iEIstpX8EvbX+r+uIzvOLqniwRf9Z0hsW+p5hF8qarKZhnVW5l
   n/XT2PZkQU98qrk3OqMQFwwl7FQlS36pszMVoJVg26XH2oNjetGGZ17C+
   g==;
X-CSE-ConnectionGUID: HkvU8WKjQWSk2yRhQYA4Eg==
X-CSE-MsgGUID: EoybaEjKQlOhP/WmF6sg+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75242200"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75242200"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 11:57:29 -0700
X-CSE-ConnectionGUID: D0ImcmcVTKSPpmlZ9LLNbw==
X-CSE-MsgGUID: wa0SD4TQQ0aKH+j5MgOebA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="189817543"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 11:57:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 11:57:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 11:57:29 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 11:57:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzCvWUTcH8/l6ijX7+SwgqUqHfd9Njs8wo8aV5GJ5W+6Zz7nilMskyEnFFtpbs2D/rqQmyzCY9Tit2xSHzsQmMhmzLeA983tU9oUiuKozQw0LbBxajSs+j6M2vcUw8+y+vDg9Qt1H1WWDYhcSOwF2eYxzRnxKfCN/xVkRWnjUuk5pI1irEpZffWOxYRjHROfr+MvvVgYDkCJ5xYF1JMTYcLcVS9+yRdakkgNuJGzt2OmFL76/JnSA704zfErbMVGh2Q+ngMVaoWlyQf3n9UMaJw1Mi56AlkXPU54Wczeptee3TxVL77AfIFxTtib31eDzm7O7s1G+8XMDfB2OO+5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGavv/8PTm7pPBytPxCpci3rImXSrSSdrEAroVexP1M=;
 b=oYcW1hZOsfKZprkCn9Zo0pIfqifABvKgv4k/LTGASH+Zv+CUu8B1c9hOelLP5ctjgFgL89YkSR8etsXRJo52dQQhVOHY2w94LoxyveW2P5+c1KtGUBUg7v2AGMeomudBY1g4slhFSCVDsCWPbR34jwotRcHnN01FSw/KNXPTAj0ow7v1yBsjNluXhDrVgYUWDD+f8PW9VbVvsP2GaAmsGLi4TmiV+Sr7pMXXonlfm0U+SHelP4bsKegT0t0HWSzG6VxrR6l2njV97mYo6fzpKc+DpZLjFKOBUWBiLrDJt2UpHy0tsrA1ytH2DJVB9dKN45O1NMSTh5k2Jixg0XqPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYYPR11MB8357.namprd11.prod.outlook.com (2603:10b6:930:c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 18:57:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 18:57:17 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 29 Oct 2025 11:57:15 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <aik@amd.com>, <yilun.xu@linux.intel.com>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>
Message-ID: <6902638bd1890_10e910046@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5a3476q5wk.fsf@kernel.org>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-8-dan.j.williams@intel.com>
 <yq5a3476q5wk.fsf@kernel.org>
Subject: Re: [PATCH v7 7/9] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYYPR11MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b1b965-f17c-4ef3-bbec-08de171cfae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjFLNjlwVFI5dlE1SWdOdmJXejJoNzlWTFh6SE9vQWVvWkt5Y0JZOTNCTCtq?=
 =?utf-8?B?aVRWbUsvS2cxSy9mY3ZHbUVzNFc1SmwxdmxhMklKWS9DY3B2amFsWUtvZDdE?=
 =?utf-8?B?TFI1N1dzZUdxRHVvdktOcmpPZUtSamhXQngzbU1PM2xtdnZ5dCtjZHZNYjVh?=
 =?utf-8?B?TWpqU2lrQnR0T0tJYkVnaGVFcTNqMW5iLzJyZXR1UlRNOVk5aS8vNVVyVXlL?=
 =?utf-8?B?ZTBMcS9oN2xYZDRuVThHV3ovRXQrMkpBZkhTbFc3SFpqOTI5U2o0TDhJc1lT?=
 =?utf-8?B?SS9ldWVzWDluT09LejhYRG1vRVBXREwyU1hzZGlCTWVJWGlRcGpUYzVrUWRu?=
 =?utf-8?B?aURDUlpWNnVtTlQwTzI5aVV0MEx2dzBsZzR5ZWltRW5VWE1VbkVmTkp3TjVj?=
 =?utf-8?B?Z0ZMVDJyUkU3SW1YY2RzaGFCWUZmYklYMmk4eTN3ZS9BRnRXMUNUTHZNWXpF?=
 =?utf-8?B?M3RqRk1VT1VBb1VSaUZ3VjZvaHRRZkdLQTRIZzNHNWVJeHp1L3JFZTFydzE3?=
 =?utf-8?B?U3RUbkFlemU1dDNKVEdKQkxKRFpxeE13dEhqRW1CeFlKNlZQcGgwLzFXK1lU?=
 =?utf-8?B?NTJhQzczd0RWdVdDUVU2SFp6a3NPeEZXUjhOZ1ZWdVlKUW43SVhjTkpBQlpo?=
 =?utf-8?B?M2JYYzYvYW5XbmhlQm9TUXIyRFY1alhDQ25JSXQwZ1BTalVnR3k4QmZyWlBa?=
 =?utf-8?B?Wlk4WnRDcXVnNVpSRzZWZzgyK1p0bmVmc2tYQ2hXQUF6cHUvallpZVlmcHBs?=
 =?utf-8?B?VEZNa2RLa3VOMXd0RGN5bnVkbVZFK203bjBoTHYxeW9SbEIvc1YvMkh2TE03?=
 =?utf-8?B?WkVGY1hkNXhJTjNSejdLWnM3MTVIb2FST3N3Tkw4VDhMalRvVTNOK0l0ZVFj?=
 =?utf-8?B?YitzQk44ditHVmh0dVpTRnBNcnBJdjEyS2pXRElnQTIwRUdWRGErbUh2M3du?=
 =?utf-8?B?L3VaSFU4bzluRmZ4aEo3S1o3UUxuYW51QmlIMEhFUG9sYzFjcGZma2Q0UldC?=
 =?utf-8?B?K2h2bCt2VmYvZjFkVlU0ekhaclVlRlNJSUNsTXV0RW02Q3FsREU5bkw1Q1Nn?=
 =?utf-8?B?RXhXTkRYSkRlUjJ0VWNMQmJ4WEdjRGhBNXFFWHJ5Zm1UTEd1NndCcFBLK09V?=
 =?utf-8?B?NW92MG9paUc2NEhaTDNrZ3BzNUFFYmQzaXBHVmM3Q3BkenVPQ3F1VHpHTmxV?=
 =?utf-8?B?dnJnUy9WUVA1RjczOEhzdzlUdnNEdkM2VTMvLzZGQzkxMGRDUHRtaFdPaE5U?=
 =?utf-8?B?ZTdHNDQwM24wb1hCT0d1cGRXb1FuSkxBMVlyRVlYaGNMMUVGUXBDY2hMODlP?=
 =?utf-8?B?UFVpa0pzR05lY1ZmWUR4ZGRiTWtyUFFmUnlaM2N6OGVWVDFIVlVTR21Gemxx?=
 =?utf-8?B?UlU1NHc3d1BkWXZVT0dYMFBadTNnZWhXb1ZOaXA2Qi82dWtKV3A1V25oMVcx?=
 =?utf-8?B?YXUvUFhjZy9kSWsvUCt2aHdMNVZ4ZVVOWEx1bXU0OW14LzVpSHFXNEpZNTVo?=
 =?utf-8?B?bDVBZEtKNFpPWFI2UlZMU2ZoOTdXcHovSmNxM3ZGVURkSnA2Mms5c25EVzNn?=
 =?utf-8?B?RjY2NXY2Nzhrd2tTYnBNbFZhaTZaYmoxNlprejB2TG8rc3M4YXFQK3ZPOUFD?=
 =?utf-8?B?ZjRBT255WCtTRjc2SnRCSXRpUVI3Q0hGUUFIQ0lpNWs1MkpYUjYrMGNFeElC?=
 =?utf-8?B?TWRZTkVIa09oY0wrQW1xaVZUVGFuYnFwejJtdWJUU2swZkJQc0tvejZpa0hK?=
 =?utf-8?B?bWFwN1VXVFQ3SEZuYUhlWWEvbDZ2T01MZkd2VTcvY3Nid1RMalo3eDhna2Qx?=
 =?utf-8?B?bERRVndxRFdqa2RKU1l6NWdGcFBmcmY3dDI4WnNpUFIyc1lKRFhXRzBQak5B?=
 =?utf-8?B?eHBLVmN6YVoybDhuQm93a05OVlNFVnJsUlErb1I5VWFya3Y2Q3RTL0hwVkho?=
 =?utf-8?Q?+U/0pfSHVZdo5UESiLd7OtSmFF6HMN92?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3k1ZEtTY3NTeUZOc2RPbEMwQkM0QzFaMnN1TGhPZWdtcWcxQldtRGRmczZD?=
 =?utf-8?B?elNkcHZjS3dpelV2SzdTVTdiWnUvaDRybGlvV1ZQODhCc3Z0dXJ3WjBrOGlr?=
 =?utf-8?B?amx2VnhQRjBHMXBydFdTN3VOUGx0UWc2djRZcXRLK1lyZWxaY0tSN3JYWWx2?=
 =?utf-8?B?WjIyRVhyUGJHenpUODRvWEx1Y1U1Z2hoUW5ZQXZRSjYzMEwrcW1EVm5kRHVN?=
 =?utf-8?B?SEgvRVB6S0U2OTZvWjhFQVFMN05QZlA4MmNlcmRxY1lpdDdLbzErMS9YRDZW?=
 =?utf-8?B?c2VtL2VET2Fhc0Q0QnRaVXdGMllkVWwxeDE3SUVVcDFHRU1IYmhKem9jWVJX?=
 =?utf-8?B?anZ5Y1VlSkQ5OVNDczZ3NTBWQXAvc3Z6MnFwQmorU241U1J3cXc5T0IxZlo3?=
 =?utf-8?B?ZVZWaW1rTVFQK0l2STFiSnJsYWltd1B6SWVteXhKeVBWZkNnWXorUmxZTWFi?=
 =?utf-8?B?M1dYRlJHUGpQejV2Uk5kNEV1R0NnU2pBdEs4TllMR3N1Qk9ZYTZwWER4RnQ1?=
 =?utf-8?B?cGhadHp3dURPNXl1dlV0WXgxUVowdjhYNDE3T3gzakJuamhiMHJFcEdTcEpZ?=
 =?utf-8?B?OFlsMC8xakwzeGVzcUZZaklHN0ZMMFEyS0g5SHFmaHBkcUlxeG5jdmhIR3Ay?=
 =?utf-8?B?ekUvTjFYL1NxZk9ra0RBUHZsUi9DczhnaHptZTAreGxwWFJBUGpJUVVMM3Rl?=
 =?utf-8?B?WUhNSnNINVJhK0N1WHEyRUJiQnFFZ0p3bDJURlU3UHhXSWRPemNNUmh2bzNi?=
 =?utf-8?B?d1RsMlAvNld1THlJejc3TE9McDR5MzNhaFBLTjNQM3I5S1RNQzZNSkpIOWVN?=
 =?utf-8?B?ZWxWUmR4bmtyVnlJQ0RHMUlQZlRWSVZQQ01hcGorVVhFV01FUStURHl4NHRC?=
 =?utf-8?B?enhMWmk3MDZCRWVCSGk0MThJUlJ5cHJyakZjUEdXV0ViT0ZkTlFGa3JhS2RS?=
 =?utf-8?B?ZzMrN3BRYXJDV0tWUXBuS0FLaWU4NnNFWSszOUQwaWNPYngzNUpkbS9HY21D?=
 =?utf-8?B?cGUxbTJSR0ExMXlIVXFDelNUcXRGYzcrUkhFOWhKQ01oV1FPSVhJcW81aFFp?=
 =?utf-8?B?ZGErL0JjZEVjZHMxZkxJU1YxZ2EvV3R6UFNQS08vb2srVStPSitzUUs0dHhz?=
 =?utf-8?B?T21uSDlKVUlFZlpoVmxWUkxEdS9jY1JRL1ZKaVY1TmdGVzFQT3dDYStVcjd2?=
 =?utf-8?B?c2xoMGRlZTg2aXdjbjBCS1hnZ1NZTDZURHV5NVhrMERpdFY1N0s2UkxRak95?=
 =?utf-8?B?dTd3c2g2VXIwVTNROWFaUEE4REJaZGpibkNXTk9MOEwydlJlT2x3UlFpN0xD?=
 =?utf-8?B?cVg1bUtEeVo1NDczZTdKc3d2ZEJxQUhvelVJek1NZUJTbGUxWC96ejQ4M1pl?=
 =?utf-8?B?cUpMM1BOZ1J3ZUk4TGZsN3pnc1E0ZXYwYjJJVUV3ZlZwVGtaWnZ4Y25hczBn?=
 =?utf-8?B?anBCUzNrTUJHbzB3NWNuZnBKSHJ4NHNuSW9tdUk1RFpIRUZsb1FzcktnV0pv?=
 =?utf-8?B?SG4zT3V5N2RBbm1DcjFQOVQ5SnltS1RxYWNaYmNFa25GNkd4RnlDZkJudEpq?=
 =?utf-8?B?elVacEx6OWhFVUV5OVRDM3hpT21GbDE0b1RndGdMK251QXBsK0JSWmd2d3k3?=
 =?utf-8?B?UUNhdjFQYlRSVUk1L3UrcXlLMkNFZFhvNDEwSUZnZHdUQzBMYkRQcllvMTlz?=
 =?utf-8?B?N2cwKzRHVkxhMkpDOTl1Sm9HV1c5YTdMd3gxVWV2b3pNWUpVM0Vrak9YdFlK?=
 =?utf-8?B?WU5YTXJWRlpCWUZqM0hGZW5ZUmpsZlIwMHhDZVUyeitEUlVBSjJxUlhKUWox?=
 =?utf-8?B?N0hrZE1oSllDS0IvbnpMK2VKZmNUdTh4R0FpVi8vbXg5Ryt2WHFVWEFhZE5r?=
 =?utf-8?B?a1M3U1dmaU1EdWlOZTg3dDlWQ3ZYeEFDcGM3K0UvR0hHZ0lwQ3hhYStNRlFX?=
 =?utf-8?B?b05IR04wY3RpTk9nRy8wMGtlOEQzKzVJS0tuQ0FDUEt3OWRid3lxY1d0cUx0?=
 =?utf-8?B?SXpEZjhDQTB4ZWlBR2d3blpVdHF1aGFPcGpDdkhmVFlpemxBTHhNdi9LbFVK?=
 =?utf-8?B?SnB5NmVDU09leFIwSm1oSmtDY1FhR2IyZkV0K09aUkxJVmg3ZzBWamRIelFU?=
 =?utf-8?B?dXVZOU9MTG42eTdKR01FUTMweStwdHhNeGxFMlBHblIzcys3cnoxT1RBcGhi?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b1b965-f17c-4ef3-bbec-08de171cfae8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 18:57:17.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXZyWGqW1IxcTqWbfS+Z8FqKmAmvE5ZWHtGxkMCjFZbQkcmWr4OQvuOZvM+oPYqCOhfgJpVLi4EzxG8RLY8APb2sEMNsCKCCmSSFFpB/09Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8357
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> ...
> 
> > +DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
> > +static struct stream_index *alloc_stream_index(struct ida *ida, u8 max,
> > +					       struct stream_index *stream)
> > +{
> > +	int id;
> > +
> > +	if (!max)
> > +		return NULL;
> > +
> > +	id = ida_alloc_range(ida, 0, max - 1, GFP_KERNEL);
> > +	if (id < 0)
> > +		return NULL;
> > +
> > +	*stream = (struct stream_index) {
> > +		.ida = ida,
> > +		.stream_index = id,
> > +	};
> > +	return stream;
> > +}
> > +
> 
> We do
> 
> struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
> 		&hb->ide_stream_ida, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);
> 
> and the default value for hb->nr_ide_streams is 256
> 
> void pci_ide_init_host_bridge(struct pci_host_bridge *hb)
> {
> 	hb->nr_ide_streams = 256;
> }
> 
> That overflows the u8 max argument for alloc_stream_index and results in
> a NULL return.

Ah, I missed this straggling u8. I missed this failure because the
samples/devsec/ implementation sets the host bridge pool to something
less than 256. Will fix.

