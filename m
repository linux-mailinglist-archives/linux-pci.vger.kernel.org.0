Return-Path: <linux-pci+bounces-33599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46BDB1E088
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 04:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5B47AEA4A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 02:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521C645;
	Fri,  8 Aug 2025 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkhvDSLI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5972616;
	Fri,  8 Aug 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619443; cv=fail; b=cz4ORQhUyDqk6GT9gsYWmlO5b5HKIWsmCkTqYzNTzcvj7pAOVBbkm5RjKsIPEV9qt7wDrdysU1/XminVTJYyI0aHlStQH3D1SW6XExavZnyOFyZrP0f0dWoHUvGqZsXh1w/yTv3xA1xTdvb8TTchIk1e/Uw2Ox4KunBIWNeQfrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619443; c=relaxed/simple;
	bh=BAq3oiaHgdU8OGurac4uyAgCCWJwb3aUHfc2r/Nuuek=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Y7GYBw8VFQ3Ta3DnLT8Q0rzgDTai6aYsll2cA8zTNWJqDdLE0J8YfSwO3ybri+qLy559eImUs0LLD09SMPPmD4vmZzZUuEkylTBd+vSNgMwRY3gTGQRth3NPuYssj0Wwa0uJkMc7D3WmyYCYmFpV68bb9luUvbGekgyJHL38GuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkhvDSLI; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754619443; x=1786155443;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=BAq3oiaHgdU8OGurac4uyAgCCWJwb3aUHfc2r/Nuuek=;
  b=dkhvDSLIn4KMeNCaf6t7Sthnf4au/xU4T/uQGe64M0OIJpPG3ZGEZgEH
   nba05yMOhr3CJcJjIbvlV1r9w9D7uRAOleQLArO/zVf9jh2ovPn2mGpUG
   p54Ex+w/L3yHHWQX4XlcxIJcHEs2EWizNt2Huu0WGQ6w9uCWWuU2wnK5c
   7nmCntRggOm5192OT/+l8R/HFvKGGKzGdcXZvAHmOVoqCb9RSdLUp1173
   J333pAHxTib7xhHvLuKMO7uEpSZI8IW8f3sTvaquay5jy9oKxiTt6CNh9
   JucQNlA7n4AkcVTwkucGavC3Y+nJMLmMsbXkJNqxfPdW88ijKfmLWtXPa
   Q==;
X-CSE-ConnectionGUID: /OstMQUCS+e5Nwvci5JXgQ==
X-CSE-MsgGUID: B8QpQEhwSm+23xdzK760+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60593662"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60593662"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 19:17:22 -0700
X-CSE-ConnectionGUID: C2SyYoRNRm2T3GtKrWpBoA==
X-CSE-MsgGUID: HAhDbQwqTpaf7qqN/97pwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="164876775"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 19:17:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 19:17:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 19:17:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.88)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 7 Aug 2025 19:17:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hvzk+7Q3TYdQbmip/l+qzj5LYqsKzxy8Qv8tn7BL+8XJVUzB5PCGtrQNAsacKkzNPpLo/bFDkOqnO4sFAMorAAHS40eCtZmxBIKFJdvViFwpwhX7Xe1U30oa4G90USHFUZua3xGmrMntFWQeE5w136iP5PZVHObOGoAJU/ftMjUicLkvcFYGCZvvyLsAf+WXvpgFxG89rQmG2MERSoe9hh1hvHXlY1HPDPxcTi0GF4EpWV78AtiVi6kxtIVP6pnGBpgX77FN0zFb8+2gUFDsnlCi/UWhKH4HXjNKHPty4aju5/YnarjPXYWGgEfeq60jml/HZXmu5+wbbgcBqog8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK5H7MUNbQAl2rUIlE3+hiFXOUP9kcRBqRcu1/IEhM4=;
 b=pLt0j81v8iEHudXz0QpFGVPLmTrGaMx+3ftAfv9jbEfD5+F4lmgyIYVQIGvQo6F8rtcBACURhqDAm7fWBiCeaupuCgBy4uZx00lwxkR6T6UPzrzRHeKHsOM6s2cqI0hD9Q8Jnod0evDYlC35Wbsv5QenIj0tLP9E21KJWpn1lkbe666M2sMegfLxoeAuI/aXIxth5xoYT+eN8oyUinF6+21saqEDbBtGlwHp4PXL6tVClHk9/FNqG0pX1AENNPdIXpE6oeNUNYdiZfvsnLmI6b6DM0NyE/rdy3fJRm3/ZLXdh+JmIfw2RmFcKMtecQAR3znZUN44BcclcJ8cVH1kWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4934.namprd11.prod.outlook.com (2603:10b6:510:30::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 8 Aug
 2025 02:17:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 02:17:13 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 7 Aug 2025 19:17:11 -0700
To: Bjorn Helgaas <helgaas@kernel.org>, <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Yilun Xu <yilun.xu@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Message-ID: <68955e275b7a8_184e1f10070@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250807225331.GA67035@bhelgaas>
References: <68952ab060b6d_cff9910033@dwillia2-xfh.jf.intel.com.notmuch>
 <20250807225331.GA67035@bhelgaas>
Subject: Re: [PATCH v4 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 5028e856-7403-4402-5d68-08ddd621b010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTBvSms5Y0hMT0J5MitiSW1xYkRlTXNMTXkyOG5tclptMlVlOEhVZmtHNjFX?=
 =?utf-8?B?dVp1YWdxekQwMUFEV1ZTcTBmaVBwcGlFanA3N1JaRmFZRERic21PaUFsNGtq?=
 =?utf-8?B?N0R6cllkTW51TG54MFFWTmZKRm9IazVUSnc0dmsxTENIUlQ4Q3ZXNU9OMG1T?=
 =?utf-8?B?dkRETEpYNHR0a09NSkhjZDVZeEJzcEJYdU5ORGVNMW1MWGhaQVFkdkoyTUNO?=
 =?utf-8?B?NUJGeDVSNDZMRzJYT2o4ZzhETWM3SGZQajYvd1VzNUtCVjk3bnJNRHJWRTBv?=
 =?utf-8?B?ODhOdkUwVWkzZlBVcUNNenl2OWNWcWdXeERVVE0xSTlYaldwMi9OR004akpW?=
 =?utf-8?B?Y2FYWldRMG5wdmFHQm5JMFRZV0FsWTJTNkxkT0tBdkRWanNXeEdKQTl3YllY?=
 =?utf-8?B?ejFpNWwyV01tRTVNWnZQZjZVWWEwS0ZhM0hydkxPdFBWWEY2OU5wNzVBWGlq?=
 =?utf-8?B?TWtLSGV3MmNCMTBEZVZ5UjRwN2VkUjlpb2ZyM1AxVFZNdjJlemNUSnBqZmFn?=
 =?utf-8?B?RVZEam1jZE1TbmJzYkpGNm04ODIxdUJYL0lKZjVQQklNZFpKQVhzZE45VzR1?=
 =?utf-8?B?anBkYmpaWEQ1VW5WV3ZEN2NNS0krQldWZ2J5YjJnQkUxNGRCdjVvTDNkUlFs?=
 =?utf-8?B?TjJrdzlxLzJaYnRMcUtLb1ZrSE5uUEpoRGZpdVhNcDJKOG1MSm9zTkI2b0Iz?=
 =?utf-8?B?NUJ2WVIyam0vY2IyNzFRQlFML3hrL2lhWjJZaHV3K2taSG1YZXlUSXQ5N2Ft?=
 =?utf-8?B?QmJFYWZvK0l1LzJuUnJScVFTekZncUtCRjV1WTBzWGhSckUzelZJeHk1WkM3?=
 =?utf-8?B?SW5XSjlPMEVjQWp0QzEvdFc2ZkowRldRbEZ6dTQ2Vi95RGZJWHJEdG5rWjg0?=
 =?utf-8?B?eGZaZWl6UHgrTmF0N2xzbm9Mb2VGbmI4bjlSSXZGeFR5MGpaMThmaVJ4WWZk?=
 =?utf-8?B?QmpDRFlaQnptaGtkcU5lV0xwQ2IrSGkxMEIvYWUwZm1HaU8xeWZxRlkzaFZv?=
 =?utf-8?B?bHNyU1FIaU9WcFFmTXhWTEcwcDZjZjNjSzZOb01FelZ3YlFyV25wV2J2TzFu?=
 =?utf-8?B?QXZndHMxeUwwam9rWUo3MTZPblhCbC8remZGL0N0YWQ2NWtEdWtwdjhDVjRK?=
 =?utf-8?B?dmc2MEJocEJ4UnhyZmtoY1NMMlJmNjlEaDVxZGxEMEtBR1dYbm9xUklwYXVs?=
 =?utf-8?B?TnRvOWZKSGhFeFdYc0tELzZBVGlMSUl6UjRjbFlhR2lzREl0Q3NQNEI5N2R5?=
 =?utf-8?B?bGlyTXZoYjc4Z0hGanYrc1lvVVBxcXo5V1YvS29pdXljcEl4RzM3c1krMTNl?=
 =?utf-8?B?aCtHQys0ZERMSlltRVUyV05XSmxwaWtLbnJEcElGcTc4c0IxNnZESit6Sm9r?=
 =?utf-8?B?azdTZG5Ha3A2bWlGazlzN0M1Q2lKR2E1VW9KUG9hakgraXFrL3dQZDNVWDJL?=
 =?utf-8?B?cVI3aTg1Y1dOVjgvMmVpbUZTazg1WTA0ejFMc1pmdTJwekR2UnlOMG1PWGVS?=
 =?utf-8?B?NEpWdmtuSFFiSGxNWjcrVE8xR3YrdHpybGlMTXZEVTRDZUt6ZDdtVG9zT3pv?=
 =?utf-8?B?RDFMVmxPWXU3M1ZsaGRyWi9DMURQZ0Q2N2J2eXF3b2hHa3BsSFhKc0tnL1l4?=
 =?utf-8?B?S05VZFJDUFRqd2VVWkZGSXAva2VhWVdSU05ZamNXQnhud1g1TFUxSUxoalQy?=
 =?utf-8?B?VVYrZHY3M2l0TGo3emdObUVob04wMmRVZ3Z0aXZpblZaQURGYkpWaWdjUS8x?=
 =?utf-8?B?Yk90dFdmZklja0xzeFRjUW52MnpuYXJnc3RuSERndVZob2JPWTZOK0IwWng4?=
 =?utf-8?B?dEN3ZGRrcE81Y09KQWlsamVUWXhXcVh2MUJiOG1QM3g3Z2lTKzNQSXFSN3FX?=
 =?utf-8?B?Mm9ZZU5PNlRjL0I1SEpRRVJPRlJ3a3ZhdHVtZWdTdDYxZGtOSThSWmsrQ2NI?=
 =?utf-8?Q?eGwrh2PbGHA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE4xMFU1TmdjQjZYbzdGSGd3eStkaHhmODVRa1VpeUk1c05FVFB0TGMwMGJu?=
 =?utf-8?B?MDVwTkhvSjQreC9sQ2RVSVpLUVJRdFhlOHkxbG1ocU44MHFRTGlHWXFXUnFa?=
 =?utf-8?B?MnAzSHh5L3Zib0xZaFZYWUZsTWswcXVBbWxSSmE3b0xNN1BDTGptWm9ET3E0?=
 =?utf-8?B?UXR4YUtiNFRuM1FVa05WeHdCQ3pKRVR4dDRpYVZNVFVEL3lCVlVUdGxOMHBr?=
 =?utf-8?B?N3lmcXNvRCtsc094RElhamJVTHZlYjdLWlV2YXlMdnI0enR6dlplWnVCWm8z?=
 =?utf-8?B?Y1AvMnkrbG1iSXVsNXFGRkoySU4reHd5MGlLa01Ob3g3OXRnVXJYWmdkYkNC?=
 =?utf-8?B?TWpIdll2VS9XNGtVbW41dnZLY2VwV25ML3BHNDJvWXpFR2dxa0FQdzhTZkk5?=
 =?utf-8?B?Tm16dDBaZWZNclNQMXZya0NsMjVqaUoyWTJjeHRBTnFjK1dXb0c5aE5HcGZT?=
 =?utf-8?B?bFJSVHpYbjk0NDZtcnhhSU8zZmR5bFlocERuSFhHaFluaFE3YVVqNE9BTkkx?=
 =?utf-8?B?NkdneVBtSGxIMEFzWFViTnhsU3hpaWVJd29WeDRidlpPdk1rZHJ0SFZ5MWVN?=
 =?utf-8?B?ME9hdlpsakhYTzhCTlViU0VXNDUzTGR1YWtBRHMvZ3FPNmpRZUE4WWY3SHNL?=
 =?utf-8?B?Nm81cStlQzJ2WFU3NWlUeHZ4dUIwRjdsMUFIbGhlRmI4OVR1YWZvcVJSaTVm?=
 =?utf-8?B?WHdmWGpvcVNzdTlCWVJWZnJ3dVFEWCtQRGtraUxmVS8waGNMREVoZk1UeTR3?=
 =?utf-8?B?Z2ZvaEZCRzF6OWJUQXZaVzc4bUoyNXMxT3pHdzVtdkJqbzZrK3dCOThkRGZU?=
 =?utf-8?B?SHZuU0F2ckEwTDRoNzQrQUoyS081d1pNK3BOcm53VEFJK09XRlp1d2RSZTNv?=
 =?utf-8?B?ZVJKTFVmbzY3Ti92MWUyeFdDMjBkSmViOVRNRVdwd1RHZkVXbDBBZzk5ak1z?=
 =?utf-8?B?LzFuaGdOTkdxQ0swS1RSYVJmY1p1L3dxdGh6ZU0wenRhRTZDSTd3QkJsajhs?=
 =?utf-8?B?N0lZdzJEQmlBb1diNFdMN1Z5dHJtVVZGeHJwUlRuOGxkNFJFVzIrOUdxZDc1?=
 =?utf-8?B?RFpnalhobU9zS01EaklGaUNMbG0wTk1FaldMbG0wK1JYN3djb3JiODFZaXBT?=
 =?utf-8?B?NzFXT2NHZHZSemE4bnAweVM1VXlTaWZNaUlSYmhPV0Z2RmsrRzBnSnRicnIy?=
 =?utf-8?B?STQwRjlrREJBQ0pXLzRlVzZ3cU5nQzlMc0FEU01oUlpGbjB6SUowNUtqTzJF?=
 =?utf-8?B?bWNVY0xqMisvRGtUZGZXc2ZTWXF3dGhKUlh4SDZPeHZLUUxLdUZ6VUdVODdB?=
 =?utf-8?B?TjFESmhXOXpLaUxCRkIwMEV4ZUFNVHpqK0NMQXR6Nk1jRUtzZGJkSnREVGJO?=
 =?utf-8?B?R2gyajlMVUVNYVdweWl6d1dVclpYOXJOVkRHcUhPUzAzWHNRc2F4WVJWUUY4?=
 =?utf-8?B?ZDNnZXN1Q09sK3VQM0VMWGY2N2RwNDhCYkdrTmJxRER0Vys5MkttN3JkeHBO?=
 =?utf-8?B?Yk5OQi9XQjQzdktxZUZxR2tLbmp3Ulk1QUV2Tzh1bFNGZ1c3d0FLS0twUGl2?=
 =?utf-8?B?ZUUyUW5mUEpxa2hHeGhzUmpDUTBvUkRRbjlIc2t0N05JRDlMSTFrQmVzaWto?=
 =?utf-8?B?aHF3QUJuZnFtSHNRMXNTbGdSbldpV1BablcwNlVzOXo3bmd1R1lKNzBBYmhW?=
 =?utf-8?B?ZW4rUHprbW5rWWtkM2hrT0ZJN0c5R3FDQkJxdXRVcWVqYnVJNkNaTVVRQXZU?=
 =?utf-8?B?Q1RjNkd0cWladmNOdVd2d3BLYzE5NForZmpYVGx2c0kxckljNTJUWktMT202?=
 =?utf-8?B?Z1FPYVJ6T1BqcUJSMHpZZ1hGYXRhb1laUEVuRkVPdGpabW45L3cyUHF2dkZ5?=
 =?utf-8?B?ZHY2YUVmaWpGbExNVGtlSTFtOStHdXYyNHkyMHlSUGpxYXlQdkxacWlMcEhF?=
 =?utf-8?B?R1g4NWdFd3ZiZktyMW1uZ2hHcGc2NjhDY1RWUXdVOUI1Y2JIcVJMdjBkYVUx?=
 =?utf-8?B?YmFXNFJoM0VnelpJVUV3Vm91VGRZVnJRVjR0dnU3SlZJYUlrUjR5YnJpTDJB?=
 =?utf-8?B?WkxRZmRlbzlZVmJSaTFJS0ZtK0UxbWl3Nm9iOGQ4Z1FxdGZhVDRGcWI3V2Q5?=
 =?utf-8?B?VkZEOXJ0bU5ocnVEOHNESzFKaVBRaS80a1BpRnN3dHZWeDVQQ2dIY0xwaHgy?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5028e856-7403-4402-5d68-08ddd621b010
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 02:17:13.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPy5PUOmNkqKVZ2k26GTmCytmgS/1oPIQ1y09NvbVQnFpweN/nCNqCqJmN/pjrlK+w0oFn+zTmATiGlALfQ2vwNAG5SLvwU3DKB8eDf0Uyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4934
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Aug 07, 2025 at 03:37:36PM -0700, dan.j.williams@intel.com wrote:
> > Bjorn Helgaas wrote:
> > > On Thu, Jul 17, 2025 at 11:33:50AM -0700, Dan Williams wrote:
> > > > Link encryption is a new PCIe feature enumerated by "PCIe 6.2 section
> > > > 7.9.26 IDE Extended Capability".
> > > 
> > > > +++ b/drivers/pci/ide.c
> > > > @@ -0,0 +1,93 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > > > +
> > > > +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> > > > +
> > > > +#define dev_fmt(fmt) "PCI/IDE: " fmt
> > > > +#include <linux/pci.h>
> > > > +#include <linux/bitfield.h>
> > > 
> > > Trend is to alphabetize these.  And I think there should be more
> > > #includes here instead of using other things pulled in indirectly:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submit-checklist.rst?id=v6.16#n17
> > 
> > In this case I think it was only missing a:
> > 
> > #include <linux/pci_regs.h>
> > 
> > ...but more includes are needed in follow-on patches. Added those and
> > alphabetized.
> 
> I assumed dev_fmt was used by dev_printk(), but didn't go back to
> look.

Yes, but it is interesting from a "include what you use" perspective.
This file is only using pci_info() defined in pci.h. It just so happens
that pci_info() is a wrapper for dev_info(). So it is a bit of a
layering violation to know that dev_fmt can be used to prefix
pci_<level> messages and must be defined before any include.

I could add a pci_fmt, but it would need to accommodate these too:

drivers/pci/pcie/aer.c:15:#define pr_fmt(fmt) "AER: " fmt
drivers/pci/pcie/aer.c:16:#define dev_fmt pr_fmt
drivers/pci/pcie/dpc.c:9:#define dev_fmt(fmt) "DPC: " fmt
drivers/pci/pcie/edr.c:9:#define dev_fmt(fmt) "EDR: " fmt
drivers/pci/pcie/err.c:13:#define dev_fmt(fmt) "AER: " fmt
drivers/pci/pcie/pme.c:10:#define dev_fmt(fmt) "PME: " fmt

