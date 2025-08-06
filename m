Return-Path: <linux-pci+bounces-33483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2BB1CE26
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00980627BF9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0579A1F4727;
	Wed,  6 Aug 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ck5ocMqn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4501F4C85;
	Wed,  6 Aug 2025 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514015; cv=fail; b=B4jQeL+4vKeREVFV0A51ijYZCgYyR2LzG0s8oWp1Eb5tNdAAlkrPNkFPv99T+00N07MwcTyMfU/gUt/R5NmkpDs4bhjorBum/ufK7eWHH6hpN91GpUY21w13fX0vS2SViVZXTHaQdz54PWLEScutqLxEBtUq/QBSGZM6pCgbuVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514015; c=relaxed/simple;
	bh=kPN5J4AXY/vqN2H+ZLwf+fgPToXAjDVgDjMOeUl/BVo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=n23J5f1idSCf0FWG1QFjVfDxf3960MilnomJN9IPTC1v56ZeO1B6fsjXpPGbITDXKPSWpKuVg9zlrvj/cheI41djv605YkVvo2D80kvzcyFVOm4DPaviWG6N5qDQ494nIv2tAC5tUanSaBb9DrinukWjssKDD3OaIB9yZODOkTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ck5ocMqn; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754514015; x=1786050015;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=kPN5J4AXY/vqN2H+ZLwf+fgPToXAjDVgDjMOeUl/BVo=;
  b=ck5ocMqndFDVccqAYwEes8xsu7DkWwju4fHLaRTldFXusL+dTZYx99+T
   wma+FnhqvCF5YyuyaVPHFPiJi2FahnIu/o9c5ASlxtuqS1ehKcofCAD8X
   djkBAUv6MaaWOkDrVG8EQ2Lh8/yWo4BchLwUEM2NhfpHow2t6y7jzUl2x
   IenQZpOLt//RqbnwY2JJE7YuNTHMLaa2HitEGJivXh7uOAfB+aWCqgh3P
   SXZGPT7QvcICvOnG9M0sB6dugUVyKsIwQf16H+VncG0NCDq5Yy/uv5wX/
   Absdk75129EMb+56PLaLCwxDsrud8xoyVD77iVh47wKWSiwXYg/VbZvyL
   w==;
X-CSE-ConnectionGUID: eOKT47WWTw2EAwnUZNBo/Q==
X-CSE-MsgGUID: 271ggRkrRDqowczObGyQEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68293947"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="68293947"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:00:14 -0700
X-CSE-ConnectionGUID: P0OgAoveRVKNd8uEKhqZyg==
X-CSE-MsgGUID: CjZgImQERxuRFNHzu8z4Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165239525"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:00:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:00:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 14:00:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:00:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb1OXnLdpeHkNmMqCz2Djm9+/tmDlzAdVe75+ZeSNnsxjd8fwyjIQrRQYgtSGE8HubMwfVbX0u83a+GmerQCRJsAj+WKFoYQc2AjAYLZPYY2XurfshARpKskqf8fctcPd3gMUTqejtToqDn9eMVSBzqINCXNa6RMeWtAErpoO6qrx3OYfQhKEXpybBTJifu7Kjt0Nb3rsJ76DGLniRGwSgTLi9BSZSGm9YUrFYZ/Hch4ksVVeb+WVuYMMqiVE5OfioxkangZzwNEn3j5O36yMpnBFCt1yBLXi52XlrARcPyeQhhoCKi53sdVljZLoRAPcXRvnpUZmXDiMl6KcTKqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/NKIHh2rdCUMBvbX1XLPKNJZdbWqW1za0ZiqxyXF1U=;
 b=a6R/VqDb1UW96viVfvXhIfGZvP9DrtUGW/5rZ24SoDBmDt2ViOGSQ/9x6BjoPFGAldjbc/OZ8rrF5/Bl606Yn7Nx2wHfagy3nWiK9YM7qA0YkB1Db880cCPqAVdTcgrU2rP4f1tajmQJ3HrFDXnzq5T8mxz5c86FN8G1MqQtvIhZmXYk1snw+fHj3x+3Ze0A0V6W/dspHPM329UDPEr82D0/NsFo9/K46pdhQ78V4uLqhGoq+LZ85J/LL6Act/59MTYLWFRTqnwVFMwO9vINd3mUqHGx1KvqS0Q85CqzZNWyhuOv1lO5so0F99ZzLEX/IkaawVnGNlsLKvspxphMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7477.namprd11.prod.outlook.com (2603:10b6:510:279::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 21:00:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 21:00:10 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 6 Aug 2025 14:00:08 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, =?UTF-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Message-ID: <6893c2584835d_184e1f100bf@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250729162310.00001fbb@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-7-dan.j.williams@intel.com>
 <20250729162310.00001fbb@huawei.com>
Subject: Re: [PATCH v4 06/10] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acd5f95-0e69-429c-678d-08ddd52c3b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3lsbG1id1lpaXBacFlJL0MvZmhERmZUUDdTUEV4ZUR0aTU2ZWU2VWdzbDNK?=
 =?utf-8?B?UXBJNzB6Q2xCa2s1VGNObTU3cjJtaER5WnhjYWRCbllHL3Nud21DQlV4QUpB?=
 =?utf-8?B?a1ZMWGJ0d2kxM1lrYWdXZEdqR3h3cDFmb0ZmaU04QXZJT24vZlZzcnJDWmdR?=
 =?utf-8?B?TmJXTVA4NjIwL3d3TXpGTVBmSEFoSVFHK0ZpUWlTc2hvOTJzSXNnWE1sVzJz?=
 =?utf-8?B?MlVKMUpmbnhhVEdYazQ5NXE1a0ZnbW13M2NJUGdaTVZFR1d1SE1KYW9yUFpi?=
 =?utf-8?B?VUwxekpRcWVZOFdDQjVEaTFraVM2RWRiZjJYRnpvRjM5dTVsRVd1dXFQWG5t?=
 =?utf-8?B?Ui82UWZCMzNwQVZBRVhZb0V0ZFhBWmJwOE5sWmRVNkhzSFV6K0xSN1F0RHBW?=
 =?utf-8?B?b3lTUGpFODQzMzdBU09pckkvZmduU0o1OHEzM2FHeVZodVR4MWxJMHhDRDE5?=
 =?utf-8?B?Rkk5YmhsQUNwekNwZ1h5dTFUdEpadE1LVGFKYjk4cFdocEZpaDMzMWRkU0Y3?=
 =?utf-8?B?VFRZejVjcG1TQnNiTDFhREVDd2xIMWFXVnp3SzU5VHU5eXpSTXFFeEJzNTVj?=
 =?utf-8?B?dkoxWWJELy9JN3JQUWVxQ1o0ZnFTM1Q1bTk4OTBUSmdwMGRxNHY3cGsvZnZY?=
 =?utf-8?B?VUZndmR5TldjOFRzUys2Slp0QklUa0pVVlRXQVFwUTREcm9ITlo1NzRqbzc0?=
 =?utf-8?B?NzFpa0d6V0Jqd0d0emxwczA3WEEyTlRJdU0zRng4U1ZvWEVpNmlvdGlmOHd4?=
 =?utf-8?B?WjNLbzZQWHJ4SC9oZVdBVkxLTjZZL3o2dlp4K3RrOTJwSVFucDlpVXlrWFBh?=
 =?utf-8?B?aFQvaVhvS3l1VWpQdEQ0SnQ0YTQ1WUVIVktvaDR0L2JleFJka0FMY25rZWdK?=
 =?utf-8?B?VXc3dTFSQ2oyeUl6NkZkVE53QmRvelFFTlpkRmpIZUtrTXZKQVZhbS8zbXhE?=
 =?utf-8?B?eTBZbysxNkRqcDBBVVJWSTY0aVQzNHdnR1p6RTZqM0phTE1OTm5WdDd6eHpX?=
 =?utf-8?B?aWhsNjI5K3NmbURkMi9nem9oTHRPc0pqbHpZZXNHRFNicVlpNmovaE5yNi80?=
 =?utf-8?B?djZtcFZZRHNMbHYyK2M0UHo0TVNXUlAwdVVNaE1vNm9LTjQrMm9oYjk0aVIy?=
 =?utf-8?B?S29ISUFVMmZaRGlvZGU4SCtZQlZXd0NGRWtJY3ZMWmEyb2pRMmNiVlJET0FV?=
 =?utf-8?B?OURDVGhReUl5bEJKUENCc0p3V2RwOTBpSG1NYUttWlJ1aUxVOXhVY3QzRTdt?=
 =?utf-8?B?cVpXdnlZeklNZWY4RnJGb2tBVnpwYmZmNS9YRGRmdjF0eStWT3N5UFp1Ykgw?=
 =?utf-8?B?WEhHMDFYYkpNYTZjMm1SU3VtU1VwaE5sdUUxREhWaTFFSkJtR05rWmpjcEZ3?=
 =?utf-8?B?OUZmRGlwaWw5bTJiNE1kRllHSHl0UUNpVDVuaWdKR1Zld1BCRUgyRG9MQzJ2?=
 =?utf-8?B?Q1locEMwTC94NGYwWEhNNWVHYW9iWUh6YXVJMHd3VmJDaCtheVU0clRscUsz?=
 =?utf-8?B?NXljdjRKZ0tYL2VqUmd6OSt3VytvSDdHL3dmek5HZHExdithZnp2aTBHbFEr?=
 =?utf-8?B?T0NEZ0svVWRKVTR6MlQrYkFkNjZyeGpEUVZDNTQwZXhpVHl3ejZsaU4zMFZ1?=
 =?utf-8?B?cm5aMnJSZHNYengzc2VCcU1XUUhlNXk2bFpzS3BlOFFESkdNdlF1T3Y2Qnlj?=
 =?utf-8?B?d1V2Z0RLNFYrK0xreVBsbEpST3JHWUpONHZpamVCRGdQRGdJMGlsQnZKTmdH?=
 =?utf-8?B?Sk9SaWFqdmVpd0hhZHJla2dNZlAzUm0yVzBsaUh4a3d5RGI1b1M5WStjWCtE?=
 =?utf-8?B?eC8zMC9MTmRWeUFFTjdxbG0wQmxpanJRaE14Y0YvUHZqU2dMcDRKSmt2T1FQ?=
 =?utf-8?B?OC85RnB5VzZJbGlCQjg4TTA1cUZCUVJTTC90NXZCMmN3dDJZSEpNR0tESXFq?=
 =?utf-8?Q?7zQcCUkqh/E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjV4RHd3dTIvYkdGQnZ2ZmM5L0plc1loMGxieExMbENaN0JVeDh1K3R3b3FG?=
 =?utf-8?B?TCtEb2c1clBpcmkzSllMYlRvVGs4c3RyUjRUd3dlem4zS2dnTHZyL1AzOWlt?=
 =?utf-8?B?Q040R0pueW1YYXMvN05HYm9MYmtKNGVuWUFpYmxBWDhIQzIzSmlGM3Y4dnIw?=
 =?utf-8?B?bEpERFNId1prcTFuS3psblNwYnh4Z2VqY2NobEcwazhtemliUTNpcGFEb0Fh?=
 =?utf-8?B?bVVlbkMzTGhrcmNKaEtlT09DWEsxT2xZRm1xZnMwVStEN29Mc2hTdXIySU5Z?=
 =?utf-8?B?cFBMR1NabjN3NFVJNEpVcTVrUzNRT0tOMnZZNVBQRDVjWERrN2VrQmdteVpx?=
 =?utf-8?B?d2YzRWYzbm9ESlNyUUZjRkpJeEY2dGhFVjU3WVVJd3NZSlNQeXdBN1lobjdU?=
 =?utf-8?B?bzFuOGlnd1dtbEdyamp3NUJEMURmMUNSN3R6Q1BRZU9Ibm5DemZEMy9nUzRP?=
 =?utf-8?B?ejVoUEQ3TUJXVlNGZFpEbG5SbTF1MnpXbVlwL2RtOEwzcHlCcGg2Q1JCRFdZ?=
 =?utf-8?B?NWgwVnJ6bzNIRUJKMGJtaTNqRERzQm1vdU9Mcmh4djdsa0pieXltWEFXU3da?=
 =?utf-8?B?cnlVakdaMDMxZGpBOUxsTml2bUI4d0lFL2Y0eldQaE9waGlsaytTcVRPeVZN?=
 =?utf-8?B?NkNqWEE0MGczZ1VnOWxucU5SYmZWUWlkNDI0amtMYW9qVkJGc0lGNTUyOGZ2?=
 =?utf-8?B?UU05RVZSbVpzaVZYdS93NlVxWkxYRVFHNDVXMW9Ib3p1WDBuV2k2OXluS0w2?=
 =?utf-8?B?SzhFZkJiRjJKaUVzSWUzZ1lRQ2NiU0tLNjN0ekdYc0JheU1SNVpJN2xIMDRk?=
 =?utf-8?B?NGFVckZzMnBwaUxoK0dZeEw1ck15MS9zcjlUWEhHM2kwV285aVFCYS9nUGo4?=
 =?utf-8?B?M2RqZ0grekhtMU5RNzBjVXAydy9MOXhLVEZlak9TNnp4RXY4SG5WU0RaZ0Jk?=
 =?utf-8?B?UFN4c09HSkZDVkxubzNlOWN1cERHZDRjTTlHTFZEQi9kcU40dmdJY0hYUGlZ?=
 =?utf-8?B?WlBDSUJkOExtVmRSaUFBVndlUWdPdVExdmRReER0K2tEYkplNVp1bkJMbFo4?=
 =?utf-8?B?ektRWjRjb20xdTlzQnVYT25nZ1JWbkZOWnUya3NqZTBFSFJQajBxNGdaUnJX?=
 =?utf-8?B?ZVFzNk8vYVd6WGpQTENYSk82TXdRS0VOajR0aVNMSHphakl4SWJGV0NVTHhQ?=
 =?utf-8?B?Y2RTcklsTUxYcFFWU2JBQzczMmNQL0pDTlFoS0lGU0RhL2hLRTBPU2xQYVV5?=
 =?utf-8?B?VVpCaXdndUxrMlYzSEo3UjEwYU9kVldoVi9RT1J5U3BQby9IWnlwVG5VbHAv?=
 =?utf-8?B?bHJaQkN3U1d5aUxmQUE3eU5NMFBnRG9MbGZTTkNtMGV4UkcybmR2dFNuMjdN?=
 =?utf-8?B?RjZqT0J1azFVckd4UTB6UnpTck9FSHo0MExuUDhLMzFWWWNhcVlHL2NEOTNu?=
 =?utf-8?B?bmt1MG1UOEptWjRQU1gxUHdESWx6WEloY0JLRFdMdGtDNDNaNEg5U2VvUkVH?=
 =?utf-8?B?Q3k1ZFF3MjlIYlZ1N3dKWFRFc0J0SVVNMXpGVmF3K0MwVHZtS21qdUE4S1Rl?=
 =?utf-8?B?ZEx5SHNzY0FUNEtpcnF6dGU2ZGZhNE50bktreFpVOTBSTEdMRFdxQ0tic2R2?=
 =?utf-8?B?UTZBL2RkamgzUG9ZUk1SWDdtZWxOc3g0T3ZzZGZmaDZIVUpaLzFlV3l3cjQ0?=
 =?utf-8?B?NXphMUZxNVdERGlZb1M1Yjh2QmMxeXB1RFRUU2pkYkdpaHlaTDVFTW9pSVZN?=
 =?utf-8?B?eDN6RDZkU0ppZ2hITGo3RHRWcDhweEVvYWE5N3AxQmdXWlZqUitwMmVyaHhk?=
 =?utf-8?B?T2JpVzBXblBTUGlaQjlNVUZrbHcvODdsWUMrVzE5Q0VWd0tqMG1pVDhBKzNZ?=
 =?utf-8?B?b01GbUx4VGNFanJVYXNnNW5vQWZBNzU4TGtWNS9VaFNER0RHdUJRb3kzM0Rv?=
 =?utf-8?B?N0JyUXlrbjlUbEVua1NKZXk0NXdUcTBuZmdMV2d2NDU0SUVJNmZIY1B0bmJ6?=
 =?utf-8?B?Nm14OS9PS1JBSW1LQ21IbW41eXBXSWh6OFpac2VjUUhUelNTL2RPZCt2aklY?=
 =?utf-8?B?VmVzQ09DOUdqd2dUU2hpSmJNS093a3N6b1QySTRRSDZpaWlMMkcwalpLS1M5?=
 =?utf-8?B?YzlraTNvaEZqWktOeWxUdWhpd1JhVnl4Tm5CektZVUk4cU81VWhZaDNNQ0xX?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acd5f95-0e69-429c-678d-08ddd52c3b24
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:00:10.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALrRYi93ywOudEplJVRfT48KqJIOpeoA67QZkT10jt5PgIwRTB/LIwnhgKriP+Iwt23iEPIt7Hsgp9T9DCpYKNoTztquonHwooXB0DlN0Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7477
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 17 Jul 2025 11:33:54 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>=20
> > PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> > enumerates new link capabilities and status added for Gen 6 devices. On=
e
> > of the link details enumerated in that register block is the "Segment
> > Captured" status in the Device Status 3 register. That status is
> > relevant for enabling IDE (Integrity & Data Encryption) whereby
> > Selective IDE streams can be limited to a given Requester ID range
> > within a given segment.
> >=20
> > If a device has captured its Segment value then it knows that PCIe Flit
> > Mode is enabled via all links in the path that a configuration write
> > traversed. IDE establishment requires that "Segment Base" in
> > IDE RID Association Register 2 (PCIe 6.2 Section 7.9.26.5.4.2) be
> > programmed if the RID association mechanism is in effect.
> >=20
> > When / if IDE + Flit Mode capable devices arrive, the PCI core needs to
> > setup the segment base when using the RID association facility, but no
> > known deployments today depend on this.
> >=20
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>=20
>=20
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index 1b991a88c19c..2d49a4786a9f 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -751,6 +751,7 @@
> >  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management *=
/
> >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> > +#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status=
 */
> >  #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
> >  #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
> >  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
> > @@ -1227,6 +1228,12 @@
> >  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_T=
YPE */
> >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_D=
ISC_RSP_3_TYPE
> > =20
> > +/* Device 3 Extended Capability */
> > +#define PCI_DEV3_CAP		0x4	/* Device 3 Capabilities Register */
>=20
> Similar to earlier cases I'd make these 0x04 etc just to copy local style=
 + match spec.

Done.=

