Return-Path: <linux-pci+bounces-35144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FF1B3C386
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 22:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F9BA01A28
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0200D20B7F4;
	Fri, 29 Aug 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSYLyYcs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755B233721
	for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497622; cv=fail; b=WBB7kDzTGVmkJS3zT7qmnuao3vlO0g3oMkfhse4r2K1BXR9XKmONbQ7df+ud60pvBjiid8KJwu1rdJmCMj41KnE6wK7ufTcSdUygQ7DERu1D4y0tapHgIQbP6ZKulM8XqL68P0ISZ9A/QKgIjyuoJ+asYJmdIDdi5/rHd06ubCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497622; c=relaxed/simple;
	bh=BZMbMW/uOclEm2CIZ3xXWDq6h/ECf24hdSEyzMU5JpE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=eO1mUB0KU9vellNNmv9JqDx1/9WyfZGSHXVnoan/2Xa0RUESAs8rXxRHl+vLw6erZWc7MuWxhmm1jKTDFaG/sTplgHfpM1Utpc+JPGI3OJPhI6L1DIJS9up/47n17ctUyyiDM2UGuTvFOdpqY631ksnHwDr1RrGt4xf9WS+VnTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSYLyYcs; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756497621; x=1788033621;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=BZMbMW/uOclEm2CIZ3xXWDq6h/ECf24hdSEyzMU5JpE=;
  b=lSYLyYcsdeZDKZB7R2CHRGs3SmRpjJPA/I0kxuQ1JkyNl0i3u6jG4am+
   wJUiZzdIBUx9mEUsIJYA9E6qEsXgFwRsfqxAKibzxHxGW8KWIa43j+H9P
   NWTmqkdtckCgNBbbqUDCiXveXP4i9yjzIp0MoVpgR9B7yKiIlInQnvZ6u
   5r0SyLG6pD7Kr7/Jm2KzESohLGwPVddarg3KSDSJSKWByP2AmE9dxpd4n
   NZ2T0MopL+MoHiyN8l74ZqAxxjQ6FZKDr3NxoOhSt0fpBPK78GFyyELCN
   SEPoP/nfTuKMhnBAhaqIgfTVqfCf7tq2M3mS3AaBTTLvOVx7ufiHOoCuD
   A==;
X-CSE-ConnectionGUID: wWa12ktNR1OJmn2lB+KHwQ==
X-CSE-MsgGUID: lZD2YC1rTw2PvhiQ2T/wNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="84197715"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="84197715"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 13:00:21 -0700
X-CSE-ConnectionGUID: Z3dhisMMTSO+qn3lEt6Xog==
X-CSE-MsgGUID: K+HCcoYkSFiGs/AdTLbCnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170849611"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 13:00:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 13:00:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 13:00:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.59)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 13:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2vz1p1y+VfQZXXk1cxTdedIleLYGE1m9MaTPOx9lugK8zidmGpxPRk9LWldU7zyuYNYEOAUfYfN8bx/ukM8AChBEAErtLnjRNRUec6Bgget5qTuOusKGjlf8EQBBMu1mvtKWO97cZxOB+mQVNI5MRNxMqCkkU+EdrtA7D/XTmgz8Z0zS3XVd5pthic9xpbsLY2KAltUySOJjrXJ2g5Hz0fkhSPyWJg2t30/61qhRKWCvMZysjS8gBLklDfqBM7dPzKTkTknLK9ghBtm32UjG8Jy+vIBGb9SOHyLCpLlRo5pX9cWwKVSoh1Euj2ENtTLWka8TOsqdzWolSKKNBmNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL9K+Lqbk+FwL9Orckz/Sf+bSnd0RHNYVq+ORXaMKCI=;
 b=LvPVPxjMDy1/6P7aIZl7ILYha2XlJFw+9xMyOTiI1vWtnFX2/R866kvOp04na4+o8lJSphWUededB+o1fl9FBrKZuvOmFR8uoxeAzvSgtj3ZKjBkraJFTSltmMMLhL/BunJ3sJ10bjiztAAiI9WRwG0csfG5sy+MwB7OGUGzaDU8jmBrdni0fiSdB/5mVT1bOoqVPxWuNTVDzJA6IYudC468OyZeDdYKOKWzP6tmjCZXKPuVJ5vjVeZDy+KWAuUm+hN4JIcjyxKaSitUda1JkyrkGAIUoDmbl/sWP0NMrT8RPR42j0aVYcZIDJxfNF04kRfXktha1zaFu/j08f5VWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ0PR11MB5102.namprd11.prod.outlook.com (2603:10b6:a03:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 20:00:12 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 20:00:11 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 29 Aug 2025 13:00:09 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>
Message-ID: <68b206c9e3f43_75db100e4@dwillia2-mobl4.notmuch>
In-Reply-To: <20250829160217.GL7333@nvidia.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-7-dan.j.williams@intel.com>
 <20250827123924.GA2186489@nvidia.com>
 <68b0cc4632fc5_75db10074@dwillia2-mobl4.notmuch>
 <20250829160217.GL7333@nvidia.com>
Subject: Re: [PATCH 6/7] samples/devsec: Introduce a "Device Security TSM"
 sample driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ0PR11MB5102:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a75a8e3-2e9d-4945-5f6e-08dde736a99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2xVQ3JrTjBoMnRyL2g1RmREK2ZQQ0FoY2FralRmNVo2QjhkU2FoY2dPcnVI?=
 =?utf-8?B?eW5qcnA0VWN4N1B5aGc3YnFnblNYSGRLZ1FRcUZScytMYWhzcEltMVNqY3RC?=
 =?utf-8?B?NlRXOXpwd3BESXJvZTI5cTdDOE1oaXNTRzFLTll2YTZ2NC9xMTB6VktyS2hF?=
 =?utf-8?B?VGJ0WEx3MVRpMWY5aHRFa24reGhna2NtR3FxRUpKRXFaSGZSMUdidXNhcWx5?=
 =?utf-8?B?OG05M1RSUGh0Y2hZdHNsT0xNUGNWOWlBcnFhbUVBZ1JGUnBKNURockxKeEcr?=
 =?utf-8?B?UHpDcWdHOE5pTHFsSHQveVQzWjNHbzM1ejA5a2hlNUJRbGVvdExpM2U2ejBy?=
 =?utf-8?B?MllsRkRyMjdnVXFrbDVlZWswRHBTK2hjZjlJNGsvZE9UWmZiSFMzZ21MM3Vs?=
 =?utf-8?B?amFObHp1dHo3bHJIdi93aS9pem1oU0NubEQzOUVPQ1RUcVNMQUIwK2l4RjJo?=
 =?utf-8?B?VXVadlpsT2xidXk5eFV4RmZjV040WHZSamtVN2o3SWRyQm56cHN4Z3pWNjFB?=
 =?utf-8?B?S0FhV0hjd1BFTzNNUy9tSVhJa1krcHpudjFRYjdXUlkrQlFCS0ZqVHlrOEts?=
 =?utf-8?B?ZWNiNHRUMURhTUpQOS92ZVVHWHJWUS81c3hTNE1JZGdWVVpGSk9CRWtWWFlo?=
 =?utf-8?B?VWdodVUrdFJsZER1VzJhTXltaUc2UWdlWFhyOHNSdHdGaHc1WWNiT1ZrL0pa?=
 =?utf-8?B?T0pZMC9OYkxxMVZuckFDQnFldDEyYkhaWnBMNjNSdjNhTGpSdkkwcVZjOFhT?=
 =?utf-8?B?d2N5Q3YrN2VHZjhFdUJ4R3ppRjNjczE0U2dtNWQrcUJ3UGtUOCtoWkI2Nzlu?=
 =?utf-8?B?N2pwczk4ZS9mQXpITkxzNlNhVlgvUDRrVUJUR3FDYzhaNXAwVXdzNi9UMjEv?=
 =?utf-8?B?SmRDM1dmN1RONlJjS0pwS0J4Y3pDL2grSUcxUGE2WXpKQ0g3WWc4WDRaTldC?=
 =?utf-8?B?QzFwQnRrbW1GUDdJNlJVWU8xRC9mU1FpcjNxZXd6TVowMlVvQ2NvbGpCUitP?=
 =?utf-8?B?Z0dKYkEydWpLbmlpM3lzL05GWlRaK1QrNGFZaUpYSTc0Qm84NERmN0F6U1JK?=
 =?utf-8?B?eDVVWVY5VmpsMHFxbTR5dEFlb3p4RmJFVzVFbWJ4ZlprbDk0R3VnZENPWEdC?=
 =?utf-8?B?L1ZvejRRc1ZTbC9MejNpUjZ4VmFKeTJjQlJxOVZjS1BRb25DY3J2Szc3SWpQ?=
 =?utf-8?B?d2dlbWh6aCtJcmtxMjhsVWhoL2pNcjg0WnVzVDR5TXl6V1BGejYvd2pVb2Zx?=
 =?utf-8?B?N0MwT1ZhVnhnOUlLcWhsNUZ2cnVBU3hmaVlCWGIxQ0NkdmdnWnhXY0g5REdD?=
 =?utf-8?B?eEtoSm5Da215czZHMFdEQ2RIL1FsZGMrZ3VFNHJrMUF1OEVwL1BieUJySXRS?=
 =?utf-8?B?SlRjRDcrTzN0NUxoa0RCSDlIQzYrY3VYTE8ySjlLVGpnV1RMb2FITG5aSmdG?=
 =?utf-8?B?NGFLSzRVVWpXNFJPZDFQb0N5UVlCT3lwOE1MZ2xoM3FHbzFKQ0QzQ2JONlJk?=
 =?utf-8?B?b2ExaDVKa2t4K29tQ28xclo4N3FGTmt0aDBXUWlGdGFDbFcvdklmdTB0S25r?=
 =?utf-8?B?eGRESXJqazdqcUR5d1JxZHczaGdGUnRHUXBiR0FtNU9UL3lQMHh3RkZJM1pv?=
 =?utf-8?B?bGRHbytRa0Y0bERMN0dyeGkxTFBRNmQyKzBiMnF0UFVQMWZLQS8rN01pOVVh?=
 =?utf-8?B?K09CK0dLaHFKcHp4eDFTbUU5ak1RRElKaGlCY285L1JsOUREMmVOOWcvdW9L?=
 =?utf-8?B?bThsODNHZ2Zod0h1eXY1UHc4QUR6NGlPQVQ0aCtxTEZ4VXpiYUphWHAyVjE5?=
 =?utf-8?B?RTJhQXlHUVpPVWdrSDhXdEJrbFJxalVqS2VQeWliWVZIcFBUN0lsSFVBUUNX?=
 =?utf-8?B?clRPOEtlS2g2c3JXc2tSV2E5THk1azdHMStndnMxSS9OM3VsbDNaRnhiaWQ2?=
 =?utf-8?Q?TTgcLsm7LkM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekRHSWlSbjhENlNVZUpuaEdJRlZiWVZIM1VNQUpGL3lhdUh5b1dVbldwL2Rq?=
 =?utf-8?B?YkZObjU2Y0lDdm94SmVVL1lIZzRSelRUZ3pIZlFMaWo1Y09JSE15ek5iRm1B?=
 =?utf-8?B?RzZvaGhzSWFjc1pVeTR2Nzh2Rzg3b0RFeTBiSUhPLzBFZlpxSkVFdzNQVUNR?=
 =?utf-8?B?cGtHR0ZObEh5OU0vYjdoeHlYZURJeEVqM3Y0Q2xyd1UxekN3UG0xY2ZLMi9L?=
 =?utf-8?B?Q2ZtQjhDcFF2OUc3eE9Nb3FGUm5wWkxIZ3lwTTJad29kSndJWlM2cDR2UkVt?=
 =?utf-8?B?ZDgwQzNNK0VDcmVkWVJMeDQ3UWdnNUN6eEpoZWpISEMxME4wRldOeFYyWDFF?=
 =?utf-8?B?di9RL3F2TXN6M3I2Z01JcUFHME9jWnY3MWZ3d0pWOHF2UHZHbmIycFNEU2lL?=
 =?utf-8?B?cXl3L21Rb3VsZW81eVlmQjhZY0hmY2RHUit6akN3VDdnOGtSVzZQNWN0K01B?=
 =?utf-8?B?ZkNJWTFNUXRPVkNiQUZ6eWZvTC9ubnFDL0EvcWJhTTZkRVNMV3ZwODFmZGtB?=
 =?utf-8?B?dzY2aHNWS1RyY1ZqYjJWaXhyUFh3Q1U2VDZ0dmhnTW9tamg1RGE3b1QvMlY5?=
 =?utf-8?B?WVgwZWFqaXYxcU5qb0tKNUhQTi9nTVpGUWhzaE9hbnc4S2xpMXZuMnVRT0Jn?=
 =?utf-8?B?eXhsaVZEVkxKRUNyb3VBbEt1bGN0Ym5NeHk4ZU9QVjB0bGFudlVlTnpVcFJD?=
 =?utf-8?B?T2lSa3Fwem53ejJqUW9hZk1UK0ZrTlF3N1c1ZkdZSjRCelZBRXZjWFcydFZ0?=
 =?utf-8?B?dmZrZXVnMlB0SE5JNFRBNUZtZTdYWW5SUmpsNGQ2N2ovVFEvd1lvRTBVUlJM?=
 =?utf-8?B?dktNNWRjK2w5MWJLVEtWZGhwN3JRM2JnRmd1RCtMQ3gwcElHOXpjUk1MSlZK?=
 =?utf-8?B?bW5jdTNrNHQ4UWJ3OWV3VGZGdnJORjZFNmlnTWQ2UDVHRGdTTEV4VUl0TzBv?=
 =?utf-8?B?YTQ3OUh6UVU2Q2s4U0Z1ZmhGS2pCTldjRTc3elp4OEFSdkl0U2xOdk9WTnpy?=
 =?utf-8?B?NlUrTUJwV1E0SkZmTnRWNjU2cjYrQk5DMENXczQrUWJQeDFuRkdidXVibUEz?=
 =?utf-8?B?Z2Y5S1NXcEZIVytpMGhwNVF3VUZQSEs5V2JmUTltSDd1cGR1MmR5VWwzZjRa?=
 =?utf-8?B?TkIzZmh4Mjg0QXFOQkZMa3Q1dFkxY0FnZU5YenMzaGpQRzNVRkpJc1FxRFlm?=
 =?utf-8?B?T3V4TUpPMFhQb0JpNC9hd1dmQ01EN1RUbmMvb2VIZjZrNXRFMWtnYU0wemxL?=
 =?utf-8?B?RmlGemNiYnRBUFE4MjhRTDNKajNGeUVPSnI2K1o1ZEJxRzcvMTVuUEdlWW5k?=
 =?utf-8?B?cGRkZ2Q3cnBBWDRzQXd5VmNGKzdnQVZUNTRycGVCY0g5Qjg2YlVFc2s4ZFoz?=
 =?utf-8?B?WHEwZ1NSZE1pa2svbzFMaW5Ec2xaRVhJQ05oa3RNZGNzMEh2T0tzYVJLZ3A4?=
 =?utf-8?B?SWlIV1VoVzY1cjlnRG95cVozYmQxRGEzWDZScUpaOE9xb1g0TDRGbzFxREFl?=
 =?utf-8?B?L3ZMaU1OcXczblBoYnZpRnZCTVRtRHUzV1E4UTExa0QvNTJ2SnhHQWRTaFpT?=
 =?utf-8?B?bEhjeWxKZ2FlMTFDaWpjeHo0L245QnhxZjNtcWlsVWNHRHdua0FnbHl0cjRk?=
 =?utf-8?B?eVBsZTFNK2FGMW0vNnRmZEFTcGRuYkVIUnRDUzZOeUJaMllDZGZ1aVpTZVo0?=
 =?utf-8?B?TVh0WXhKZE96Um4wdzNldlRpZEh5MnlGcG1pR1UwQmJEeWZTQ0MyRVRxck9n?=
 =?utf-8?B?bWFqZEVaMWNoc3N3dUVGQmZBSmxaS3JOTkpmSi9mSS9ZWTI0Ui9IMGNiejhi?=
 =?utf-8?B?ZmF0TC9mNSs3U294TU1FS05DVWQ0N2RZQTYxMDdMaVd6Q0VjbEVMWk16Uk9G?=
 =?utf-8?B?c3Vpb1dibWVOVlUxWkY5VzFoUWpSeUprOXg1NHpLWi8xOWNKbHFEOWZIaTRu?=
 =?utf-8?B?QThiZEgycGhWcmdOU1VCTHNUQ2pXOEZJRFBJN0hCOXJZR1Vod0t6NGdHaFVQ?=
 =?utf-8?B?djliOXVIcUJRT3NSNU1jL20vMkZTc3UyRUp2eSs0K254MDNtaVBGNURmY21j?=
 =?utf-8?B?RUw4WmxjVUxkZTNOTkVNdjBuVkpsY0hZMGdTcm5Zc2lodk9keXdsWnBRaU9N?=
 =?utf-8?B?VlVQVEVkcWZiQklUT0I3dXpIQjQ5cm5SL1I3VlRuWmlick5JNktJc3Nhcjln?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a75a8e3-2e9d-4945-5f6e-08dde736a99f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 20:00:11.8728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8AeopbGT66ZauZKf7/cIEggIResFkMIZbzvTHwJ+Ro3ZuYJZk3lLisBGFvadumoRyRcFdZ0gEcA73jXf+qzpNZKQPoXr1WtFFI8xX1TojI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5102
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Thu, Aug 28, 2025 at 02:38:14PM -0700, dan.j.williams@intel.com wrote:
> > > device_cc_probe() doesn't save anything, doesn't this just get into an
> > > endless loop of EPROBE_DEFER? Usually the kernel will retry these
> > > things during booting?
> > 
> > Hmm, no, deferred probing retriggers after a one-time boot timeout
> > (extended by driver registration events) and after any device
> > successfully completes probe.
> 
> So it is not "endless" but it is also not "single probe then wait till
> accept". I'm not keen on using this mechanism, I think the things
> people want to do in the T=0 mode are going to be time consuming and
> repeatedly doing that time consuming step is not a good idea.

It would only ever run multiple times if the driver is built-in or
loaded early, which is also mitigated by disabling autoprobe like you
have below. So that problem is manageable.

Now, I do think it is worth exploring a convention for "cc_prepare"
drivers, but as long as userspace is prepared to rebind post accept it
does not really matter if it got to that point by cc_prepare driver,
probe deferral of enlightened driver, or plain probe error plus retry.

> How about this instead:
> 
> 1) Drivers compiled into the kernel are "safe" and can freely bind
>    at will during early boot

Agree.

In the past this idea has been met with "but but typical distro kernels
have lots of built-in drivers that *may* be unsafe", and the answer is
"yes, a VM image with a CC aware / specific kernel config is a
requirement".

> 2) The first thing the initrd does is set
>    /sys/bus/*/drivers_autoprobe to false.
>    This stops all kernel driver autobinding.

Makes sense for the buses userspace is prepared to manage.

>    Maybe we also need a small kernel change to allow userspace to make
>    drivers_autoprobe false for all future busses too.

I do think we need a mechanism to say, "no more dynamic device
enumeration", but a coarse and future promise "no autoprobe of any bus"
I fear is going to have a long tail of problems especially with design
patterns like "faux_device" and "auxiliary_device".

As far as I understand, these CC environments do not immediately have
secrets to protect at launch. Also, not sure how many are ready to
validate the launch state of the TVM that early. I think it is more a
case of allow everything by default to start (whatever is in ACPI, and
T=0 PCI devices). Later the relying party either says "no, you have
enumerated devices that should not be there", or "yes, launch state
looks good, lock device topology, proceed with the performance
enhancement of converting some PCI TDISP devices to T=1 operation, here
are your secrets".

That post validate model saves us from a long tail of fixes for
subsystems that may be surprised by a new userspace acceptance loop. It
is userspace responsibility to validate device topology relative to
relying party expectations, and likely for the device topology to be
static for the duration of secrets deployment.

> 3) Userspace then evaluates what devices are present, checks its
>    policy, loads modules and issues /sys/.../bind operations.
> 
>    We need to close the general security gap I gave earlier, userspace
>    policy should be able to implement the statement:

The gap is present when secrets are deployed and if secrets are deployed
pre-accept the TCB is already broken.

>      mlx5 is allowed to bind to a RUN device after measuring and
>      verifying it, and never otherwise.

...and if userspace binds mlx5 pre-RUN that is not the kernel's problem.
I state that explicitly not for you, but because of the rejection of the
"device filter" in-kernel mechanism previously.

>    a) For non-TDISP devices userspace checks if a driver is "trusted"
>       before binding it, a fancier CC only deny list stored in the
>       initrd.

Yes, necessary.

>    b) For TDISP devices userspace runs through the
>       prepare/measure/lock/run sequence then binds the final
>       driver.
>    c) Something something RAS driver restart
> 
>    Basically userspace policy is entirely in control if a device is
>    "accepted" by the ccVM or not. The kernel won't auto bind
>    a driver to a physical device. It would be driven off of
>    uevents, I guess through new CC focused features in udev.

Yes, the only quibble is whether that "kernel won't bind" is more a
"userspace shall lock and validate device topology" at a certain point
in the boot flow. Userspace may need to be prepared for some unaccepted
devices to bind before that point.

>    I think the needed kernel support is already here, the main gap I
>    see is that the modules.alias does not include the driver names, it
>    just has the module names. We ran into this with vfio (see below)
>    so it would be nice to fix, though it can be worked around like
>    VFIO did by making the driver name == module name.

Yes, I think that is reasonable. Multi-driver modules are not the norm.

The kernel problems to solve are "accepted" flag and maybe documenting
to driver writers / udev developers strategies to handle the "prepare"
problem.

> 4) Userspace sequences the special "prepare" pre-T=0 drivers, perhaps
>    discovered through modinfo matching similar to VFIO:
> 
>    $ grep vfio /lib/modules/`uname -r`/modules.alias
>    alias vfio_pci:v000015B3d0000101Esv*sd*bc*sc*i* mlx5_vfio_pci
>          ^^^^^^
>    PCI driver but special for VFIO usage. So I imagine a
>    ccprepare_pci:... driver variation.

Novel!

>    Userspace can inspect the modules.alias, find if the device's
>    modalias has a ccprepare_pci: match and if so it will bind/unbind
>    that driver before going to locked/run. When it reaches run it will
>    find the pci: match and bind that driver which is the operating
>    driver.
> 
>    Policy if the ccprepare device should even be permitted is also
>    controlled by userspace.
> 
>    Userspace sequences all of this based on its policy to accept a
>    device and push it to RUN, not the kernel, again probably
>    through some new CC features in udev.
> 
>    The kernel side of this is a commit like cc6711b0bf36 ("PCI / VFIO:
>    Add 'override_only' support for VFIO PCI sub system")

Yeah, that looks like a viable option for these complicated drivers.

For RAS I do still like the property of a driver that will field errors
also having everything it needs to take a device from reset back to the
ready-to-accept state. That can be solved later, and maybe the outcome 
is "cc_prepare" is incompatible with "recovery".

> This is much less kernel change and gives the big thing CC needs -
> driver binding policy decisions in userspace.
> 
> > > As we discussed in the prior chain we need to have a policy decision
> > > before auto-binding drivers at all in a CC environment, I don't see
> > > that in the code though the cover letter talked about it??
> > 
> > The aim was for the "'struct device' has an acceptance flag" discussion
> > to settle before starting a "device-core policy for unaccepted devices"
> > discussion. I am ok to put more logs on the fire if there is an appetite
> > for that.
> 
> Sure, I think you shold drop this patch from this series and have this
> series focus only on creating an accepted struct device environment
> that a driver can bind to and operate.

You mean drop the device_cc_probe() piece. The rest of patch is starting
the work of a "accepted struct device environment" with a single flag
that MMIO and DMA infrastructure can reference.

> This is a long journey already, once this basic support is landed we
> still need to do all the arch support to enable DMA/IOMMU/etc as many
> followup series.
> 
> The questions about when and what drivers are probed can be left to a
> different series, at this point it will be usable for development but
> not secure like it should be.

Agree. Especially because attestation interfaces are not part of this
series yet.

> The device_cc_probe() type issue should be solved in yet another
> series, IMHO, and that should come with a really strong justification
> why the kernel needs to do anything at all, vs just rely on userspace
> as I outline above.

It is trivial for a driver to open code EPROBE_DEFER so
device_cc_probe() is not putting any burden on the kernel besides
documentation, but I will drop it for now.

> > I was hoping to put the onus of that on the vendors that think they need
> > this Enlightened driver path. The path of least resistance for device
> > vendors is design the hardware so that it can be locked without needing
> > a driver to take any configuration action ahead of time. Otherwise,
> > explain to users that they need to adjust/replace the eventual udev
> > sysfs script that does:
> 
> So if we already imagine changing udev, lets imagine the above
> instead?

That's the whole discussion, what are the udev requirements relative to
the secrets deployment event.

