Return-Path: <linux-pci+bounces-35423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F80B431E1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90DF3BFE37
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 06:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E10502BE;
	Thu,  4 Sep 2025 06:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKSpFRq2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8141758B;
	Thu,  4 Sep 2025 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965724; cv=fail; b=UFXSSaYcB9Ra80VKbXI2A6cUDEZZ3PzkhNlOLstpe/2uWP/kVWn6J6GmY0ai0GpYKiJOiixEZucBIhpHdPsDyRWjMVVk3owMScYfeEPuso6s7J0HwmDGE63g8wVQIo6Ow3Ek/WXQytttR5da5HSADaug6EL2+ELtTW5XgNQ4KpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965724; c=relaxed/simple;
	bh=kfRVhSDi6EgX3XZHJy1ZeId+T/gIj/FrHhaqCutbH0A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sGBEHxwqp6gwSc1lFFOGf7yI5R9wyaikVNmJjTKucgROK9l/PxMEPdi5P2E3qkQMagAOvx5MbtGZsRIVIvzlEBLVBIbRRb0eRbIuvA9Yw4vlPnT67uwaLQHQunTfoAwdLFXlBmluKj5JEVxqXlPi78c995GCtsh0jYWp5JUZufA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKSpFRq2; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756965722; x=1788501722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kfRVhSDi6EgX3XZHJy1ZeId+T/gIj/FrHhaqCutbH0A=;
  b=iKSpFRq2BGIFHEtptwJhtv3szSpxpeoLJ+GjmoaRlfuduaLzWJLjjYWN
   fvP4G8MQfT2PZ3esw+hBycgzHzNu8HEoSftljfqFpV0vrAXnRWIoPOPGG
   EVyCllhHHODio0Jx3zwoGSCB1ZicqgNk7YKQ85WBNpUnJgnrY6laCAbKx
   Yo+yttAoirLvQgxuxqtRK56zISdEbinKhGv9T5r9Pmi4sQq33as8gCeGd
   mV4n6KJATRXFHh070j/KSiSHFau+CGkmliQbrOMw49ii8hc56jgERdS1u
   B+CNY+ccKk6M0m6tQmUAejPJPztzwdTvO+aAudfQNVhVX9xqtpu+PII4F
   Q==;
X-CSE-ConnectionGUID: ZqAx5IDkQsG8EGJ+p/Ozhg==
X-CSE-MsgGUID: JzfrY98TTaucfoshFl3FRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59148005"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="59148005"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 23:02:01 -0700
X-CSE-ConnectionGUID: ZJlupLWSS3qs+B0bWl7yMg==
X-CSE-MsgGUID: dxzgqKfWQzqnneLUqgbtuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="172250151"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 23:02:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 23:02:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 23:02:00 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.58)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 23:01:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfYSUtGrQIVuos79me0CE9E0uDkfTHcsAxdnU5/cLDLSvnbKRJCKtUsygKZRV2bqGRTymmRLRZHCcjhvugwA5lvSyzpQSxn204ku1pudtykiVaVi9HkS1yi/6r7ttloIIYTecGgGXmXos/4xmJ8+KTU2JvsU+Xe3ozZz9DxofYGuVgmPbXoFLjTc5CCssU3y5St+or4dY2tu50T1zqjd1DKp6pxoS39qA95yUKnOFVEHBw60UiYbd1jETF7Z3AS08PGsMXZ77bokCbcN7BjTgV3jCuMr7k5Et3I+qOVi0eJujTaFD7tmvsB02D+9O0QHQEGy3Eubn7EUQUCKllV7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z256Y/S4lL3V0p3T7BOE0AQaKoCXBttPG88vhxWgqzU=;
 b=TSguI8jOEoWq+wIu0cdc1WFWFz2YEH4/qDhcivhUmATZceFD/usFHK6IlXky37yfGpsiQzrsie9HgihBEMIRU2xvQ5AC82l0e8aNGclDDh2dr5ClslqcAZ9QJYu8HvWfOOzMAIMUISMEqCouopXn4WDHz+VyyPNW02j9f84sgVy3ssL1D4DM0atWdJ7kf1HaPEY08LawLidlIKB5KsGBxyl0KRU1MAkvV+xrOtXBUPT0DeLGlT08OUMxBk0OMaWGnc3WvuiwLYB7t71baydqJwekcFiDhCr9Cqi3qgHiHUSpDIg//0b4IpTnSWJvTtb0Y+8z4iQ0RDiKVk2QPwCVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17)
 by PH3PPF383C22AA3.namprd11.prod.outlook.com (2603:10b6:518:1::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 06:01:55 +0000
Received: from CH0PR11MB5249.namprd11.prod.outlook.com
 ([fe80::a665:5444:d558:23c3]) by CH0PR11MB5249.namprd11.prod.outlook.com
 ([fe80::a665:5444:d558:23c3%3]) with mapi id 15.20.9052.027; Thu, 4 Sep 2025
 06:01:55 +0000
Message-ID: <61bc513c-f1ea-4f2a-8ab1-c6a34389f4fd@intel.com>
Date: Thu, 4 Sep 2025 11:31:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,10/11] drm/xe/vrsr: Enable VRSR
Content-Language: en-GB
To: "Nilawar, Badal" <badal.nilawar@intel.com>,
	<intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-11-badal.nilawar@intel.com>
 <bd981a4a-e678-429d-8526-abd9290906d1@intel.com>
 <dee7db73-5a6b-47f7-bf4d-2ef45d8018c1@intel.com>
From: "Poosa, Karthik" <karthik.poosa@intel.com>
In-Reply-To: <dee7db73-5a6b-47f7-bf4d-2ef45d8018c1@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::11) To CH0PR11MB5249.namprd11.prod.outlook.com
 (2603:10b6:610:e0::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5249:EE_|PH3PPF383C22AA3:EE_
X-MS-Office365-Filtering-Correlation-Id: d88aa80c-2714-4d99-6d1c-08ddeb788c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkpYaVRiTTN2UFdVenc3U245V3FoeE93aS9MaVdKZGJkOFduZlFDR1VTYXdr?=
 =?utf-8?B?ZlgzWEc3NjNodjJRY1ZReUx2bU8yTnBGUTMvOU5yRVI1S3hWZEViSTM3amxD?=
 =?utf-8?B?dG52bnd2ejFVMk9SZXJMWis1MklhK1hZZlE0U2FDVjhtMXEvbUlXb1hVdVUv?=
 =?utf-8?B?ak40a2x1RFhsT3hHZUNUOStLNklxck5LaU1aaW1iMklJQTBVNTB4RStsOW1P?=
 =?utf-8?B?WTExSU40bjJ2UGhxRDl1SnU4UVhOd2oydHZneXJkRFdpbWsrWEZwRXhlWWVV?=
 =?utf-8?B?K3B1UXM4TW9mazhqc2k4Sy9va3dtOHZEVzRON0lIWU9DYm8wakdpelZ1c2x1?=
 =?utf-8?B?N3AzR2ZjWGgwdmFtamVySjdzZklDemVmVVdjeW1hamJLUjQ5WnhVelIvVHl4?=
 =?utf-8?B?d2JzdHpVblRYWHJFZ0w4a2VRUkFrY0tsbjVUejIxTjF6VVl2cGttdEZVd0J1?=
 =?utf-8?B?ZWdWUzdrbER2eDZEclZsWWhPN3VNdTNXOVZlSmt3Uisyb1ZXZ25MT2wrRVlr?=
 =?utf-8?B?TjdMTU83c1orSkcxdEhvVmNwVEZHSlVITXgzNzRocXlRNGFqRTlTMFVmYUtu?=
 =?utf-8?B?VHNZdDV0MzRDOXA5OU5GczBjMmVnL3IxUi8zMktHT2JldTA2TDNMQkVpL3hv?=
 =?utf-8?B?Sks5eW84VUg1VVB2Ynp0QWRjcThMTXdZK2hGb2hMUFdtTzVuUDBDa0Q1U0xh?=
 =?utf-8?B?ZnhZV1RpZzRhWGFxbmhKQ3NMSzhRRTFaalJ6Y2NLbVhBL3V6dWY2KzFOMTJh?=
 =?utf-8?B?R3MxUjM4UXErbUlsdWcwc01rTlZROU9qQndydTgyc2VWN0NXdE9wdHlCczhT?=
 =?utf-8?B?Wmx2LzBuRk1PM0lHdUplSXNmdkZILzhkVXFxY09tVlVPZ2U3UVVuVUlDY1RU?=
 =?utf-8?B?WTJsUjNURUc0Ykc1TXR5YUdNOVFQdXVQWUd3YVdiWXdxeWpFWk9jZFdRS2V4?=
 =?utf-8?B?UnJSL1NkREJFdHFaVDZtNW9lUitHMXpEMzZ1V3NSekJmbVJWekF1M29DMWU5?=
 =?utf-8?B?UURZaVBEN3pBOVdVb2dRM21CV2sxNXRFaWtranFOYldMTVNVMWdudWg3Smxh?=
 =?utf-8?B?ZGRybEF3OEg5YUh4eUcwbVBFSlE4aUQ4bnh4NVBlVGRUZEs5ZHBXWHkyYWJs?=
 =?utf-8?B?YXcrU1UyenYwVmVidGxBSDMrd2V4MTBzRnNsL1dGcjlMT0Y2MzBHNGZGU0NQ?=
 =?utf-8?B?M3V1UER6dDRzWnd1RjlqK05POWV4TjhkM0ZORTNVWncrYzhXSi90KzBYV3Z3?=
 =?utf-8?B?SkN2S0d2ZkcxeURkWi9UZ2NXdWlDN1NOK1pldDJCYU5nWldLSW5CU291dnNq?=
 =?utf-8?B?bG94a1FnM0NZQnRQelNqcHJ5UWxteHova1Bjbk1XWVp0OGhDOTVaOWgrT0hS?=
 =?utf-8?B?SXhmcGpoNzJrM0pqZWphVEpXRTJzMGM3TFdCUE5ENDdxZUFRaWpCQWwyMFYw?=
 =?utf-8?B?UFhIMDIrNjBFV2M2YUViS1hOdVljd3F6dkVXWkJXcVY4YlN0WEUyY1RHejNs?=
 =?utf-8?B?WWhnMUZiUVRDVGxJL01TdlVIMzR4dlJxWVAwTXFKMXZHNUo0czlvenNsYlM3?=
 =?utf-8?B?Y1c2NlVrZVkyTDlVeWlWVER2eDdPTzNUTnBBa0crVDhZWnJpSzdydmNlTVgv?=
 =?utf-8?B?WUdJK0pTZVVDOHhTZ2lhNk1Jc1h5RWhON2k0STBnZ05zRVJuYnZGZjRnODdV?=
 =?utf-8?B?ejBhNW1jTFE1RTArQm42ZGxycmVHelc4cTRwTkJ5amI5MWxMN1lTenA4YldL?=
 =?utf-8?B?cEg5M3FxamdHd3NpUnFYSHZvcFBkdnd4RFV2azVmMW5FaFhxc1ovZzJGRnc5?=
 =?utf-8?B?aDN4Q0RZU05pWHUwbGNseStLemVkMEQrVUpLSmhkM0RpNnBjRUg0T3hMUE96?=
 =?utf-8?B?VGhNengrRjdic1lmeGNBYTZDK09UM2xiYXRmckRMMmdra3JxVFRrZzNVaHVV?=
 =?utf-8?Q?IlPOtu/ELyI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5249.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnpoSmJBZCs1S3lRRE8rMzVQNU1yOFBkMkwwcGhMMGFFZ3lHbnZJVE5YTm1l?=
 =?utf-8?B?UEhRZDhwQ01DTFJGR3RxZVRLNFFTYjlWWmJDSnF0aldubUVYVzBONjM2SmZ5?=
 =?utf-8?B?WFloN1RXdUpJcGtGdER6SzVHakhCa1daNDBCbjFVbThwYUZneTRsY3QxaVNq?=
 =?utf-8?B?RTNrNm93eTVLQWMydlMxWEszMHc3Zm9UTlFKVk9HUm45RndiTjJvVDFWYkI4?=
 =?utf-8?B?WFUwTC94czZSZDBwRk1kMGpLd2xOZlg1N09BcDFLcVRMWTByNmk4RGRnUmV4?=
 =?utf-8?B?dUFKNWE0ZlM0L3ZwRHVHdmkwUGxQMmc3Mmh3ZWZCZGpHdTE2cDBwTlhJYjQz?=
 =?utf-8?B?bjBJazFVd1pPeTIxbFYySXVMbENXQkE2R3RGYWdMajlhQkVrd3JueS9maU5t?=
 =?utf-8?B?b2QzTExvWjhqNC83NW4wYU5aQ1Y5QWwybVl1Q0ZqditmeXNVVCtQMDZqaDhI?=
 =?utf-8?B?QVhMT1lUUkZBMnNuNG1FZU1OUE5tVWlJcnJDdGhUZFdxWC85WVhmb1MvajBs?=
 =?utf-8?B?Sm0yVXRQVm9pZTNPVGFRc2ovZXVZQ0tYekRTbVZsVUQ2UGtVQko3UmZhTmVG?=
 =?utf-8?B?aGwvUWE1aUxDcVdjazRMN202bC9OazFXZm9MZnIzRnh2V0V6aVZidFNyZVRr?=
 =?utf-8?B?dVh6MlhQend6cUhGcE9OSnlOM3psNWR0MUFPTHZFa0JmT3N0Q1FOOTlHNVdY?=
 =?utf-8?B?ZnF1bkp4MmRHd2JENkQ4QlBxNjA1OEVBZFJvSC9pbGVkNUhrS1ZCQk4zY0Er?=
 =?utf-8?B?bjVzU2thc2QvemFzc1ZVL2NuSjgxK0lyWU1ENDFBSDFROWM3ejlCZ3NGa09u?=
 =?utf-8?B?RC9tT2g1WTJHOUNQbjhjcmcyZ2NTMWJvTFVtbm1RZDBLdDRBaXNPNFFzOUg0?=
 =?utf-8?B?TUNEUWNGalNSeGpuMHJxaVJ4UnhlS1ArMDdxTWVKUjYxZFo3YjVtNC90bXhC?=
 =?utf-8?B?VzlBUTk2QWdwUmFQSWVMakpNMzYrQkdYUDlJeUxIZUNjS1VpeDNVMEhYOHZV?=
 =?utf-8?B?WnhaTmZMYkZKdG9rZy8yQzRBaEhOS2FJRG5KRTI0Ujc0Sm9YRE96QjNmM2Zj?=
 =?utf-8?B?MGtUUlMyV2NVYW8yaHgrT3g2Yk1Yb3ZzUkFXTjJibXNZNnFqU0F3ZnYyS3hN?=
 =?utf-8?B?Vk5LRHdzRnNtQmZkQXVGWGMyM2QyUi82NDNwVlhUM2tNeTlTT1FEK1NCY3Z4?=
 =?utf-8?B?bnFJdVYrWG1QWTY0cDVkL2h3Y2FmdUNGNUI2ZkJlUXpKZjNYK1BhT21OM0lo?=
 =?utf-8?B?VlAvL2lNY0pnc3B1eUR5Nys1WEovczBGaXpzSDZSbVJKV0ZJQ0RNKytiU0Ru?=
 =?utf-8?B?a1U2b1dmR2lTYWp3M2J4dGp1Nm9HbWp6MUJjTktGdU1HVFlpVnRVRER1bkxL?=
 =?utf-8?B?NC9zYzI0QkhRbkZRYzd4S3d4RTFvMDdjUndML1BCU3MrOXdEM1p5VXdLZ3g0?=
 =?utf-8?B?L2Rya2NIN3J1eE1pRStMd0FIVk5MR2ZqelRkOVZoejJRcjBzSlc5THEybVkx?=
 =?utf-8?B?Z2haSHhwcFI2UnNMY0hmaFl6R1d2N0taZFJSMnhla2puYWIxZXIrWG41bWE2?=
 =?utf-8?B?R1VBb2JIL21EQ1h0cGc5a1BYaHdCNndPV1R3dEh3RDh0ZE9NSThyRXQ1WTND?=
 =?utf-8?B?aCtoQUY1cEoyN0VDTGF2d05qbStIYkRId3Y3a0I4ejU1ekdnaHIvSVJpcElq?=
 =?utf-8?B?emRvNXFyY3VxVUdVWE9KZ25YVXc2Ky9MVFp3Q0Zmc08zNkhhRWpBYlFXZlFm?=
 =?utf-8?B?TUlLVENPdFhvVUxac2JkckxQMEtSaDM3MGJyOUM0YUxZS2hDZG1xOUVJS1R2?=
 =?utf-8?B?azZxUFlmYlo2SWZnVlFKSU14QU1PM0Fib2F1cFFPWFg0bXlabmFXZEd1REpI?=
 =?utf-8?B?UmYrcU9RdlV6QWpsbjZlck9jcXJMcW93cEdPOGRaMVExYWZmaUtnUUpYeExM?=
 =?utf-8?B?SlFRL0p5ZjBCWjUyMEM3NjBGR2JBVm0vOGVBTnl1VytXUDhVMW10TU5wMml0?=
 =?utf-8?B?d3paZXIweSsvYXhhY1ovU1poa1ZxWXlJN0FwM3VUL2ZaeXVkNHMwWXlIOERL?=
 =?utf-8?B?SldjVEI3U3BRUE9Hd2p2c0dxNWJjNnF4MmxDZWc1bWkwTmpheDZmT1M1V0c0?=
 =?utf-8?B?YVNGeDhXbEUzeSt6SWE5UWtKK1M2c2dmYktOUFNCVWdackdGTHVzc1dHQ3V5?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d88aa80c-2714-4d99-6d1c-08ddeb788c91
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5249.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 06:01:55.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1B+XmQsSNOM5GDUTXKQhl+Oxoe/hlXF+/BzTP7r5g8ABKgng94ThpUkos+K8URe9T4hQadCjbMGatswvRF4iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF383C22AA3
X-OriginatorOrg: intel.com


On 03-09-2025 19:46, Nilawar, Badal wrote:
>
> On 24-06-2025 17:15, Poosa, Karthik wrote:
>>
>> On 29-05-2025 16:46, Badal Nilawar wrote:
>>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>>
>>> Enabling VRSR in runtime suspend and also in System wide suspend.
>>
>> This can be rephrased to -
>>
>> Integrate VRSR into both system-wide and runtime suspend-resume flows.
>
> I will drop gerund.  So it will be "Enable VRSR  in runtime suspend 
> and in System wide suspend".
Okay
>
> Thanks,
> Badal
>
>>
>>> Also fix couple of typo in xe_pm.c.
>>>
>>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>>> ---
>>>   drivers/gpu/drm/xe/xe_pci.c |  4 ++--
>>>   drivers/gpu/drm/xe/xe_pm.c  | 46 
>>> +++++++++++++++++++++++++++----------
>>>   2 files changed, 36 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
>>> index 5ae1df345416..fdf878594fb0 100644
>>> --- a/drivers/gpu/drm/xe/xe_pci.c
>>> +++ b/drivers/gpu/drm/xe/xe_pci.c
>>> @@ -926,7 +926,7 @@ static int xe_pci_suspend(struct device *dev)
>>>         /*
>>>        * Enabling D3Cold is needed for S2Idle/S0ix.
>>> -     * It is save to allow here since xe_pm_suspend has evicted
>>> +     * It is safe to allow here since xe_pm_suspend has evicted
>>>        * the local memory and the direct complete optimization is 
>>> disabled.
>>>        */
>>>       d3cold_toggle(pdev, D3COLD_ENABLE);
>>> @@ -943,7 +943,7 @@ static int xe_pci_resume(struct device *dev)
>>>       struct pci_dev *pdev = to_pci_dev(dev);
>>>       int err;
>>>   -    /* Give back the D3Cold decision to the runtime P M*/
>>> +    /* Give back the D3Cold decision to the runtime PM */
>>>       d3cold_toggle(pdev, D3COLD_DISABLE);
>>>         err = pci_set_power_state(pdev, PCI_D0);
>>> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
>>> index 1e061bfc3e52..19596d467298 100644
>>> --- a/drivers/gpu/drm/xe/xe_pm.c
>>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>>> @@ -147,10 +147,12 @@ int xe_pm_suspend(struct xe_device *xe)
>>>         xe_display_pm_suspend(xe);
>>>   -    /* FIXME: Super racey... */
>>> -    err = xe_bo_evict_all(xe);
>>> -    if (err)
>>> -        goto err_pxp;
>>> +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>>> +        /* FIXME: Super racey... */
>>> +        err = xe_bo_evict_all(xe);
>>> +        if (err)
>>> +            goto err_pxp;
>>> +    }
>>>         for_each_gt(gt, xe, id) {
>>>           err = xe_gt_suspend(gt);
>>> @@ -162,6 +164,12 @@ int xe_pm_suspend(struct xe_device *xe)
>>>         xe_display_pm_suspend_late(xe);
>>>   +    if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
>>> +        err = xe_pm_vrsr_enable(xe, true);
>>> +            if (err)
>>> +                goto err_display;
>>> +    }
>>> +
>>>       drm_dbg(&xe->drm, "Device suspended\n");
>>>       return 0;
>>>   @@ -203,9 +211,11 @@ int xe_pm_resume(struct xe_device *xe)
>>>        * This only restores pinned memory which is the memory 
>>> required for the
>>>        * GT(s) to resume.
>>>        */
>>> -    err = xe_bo_restore_early(xe);
>>> -    if (err)
>>> -        goto err;
>>> +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>>> +        err = xe_bo_restore_early(xe);
>>> +        if (err)
>>> +            goto err;
>>> +    }
>>>         xe_irq_resume(xe);
>>>   @@ -214,9 +224,11 @@ int xe_pm_resume(struct xe_device *xe)
>>>         xe_display_pm_resume(xe);
>>>   -    err = xe_bo_restore_late(xe);
>>> -    if (err)
>>> -        goto err;
>>> +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>>> +        err = xe_bo_restore_late(xe);
>>> +        if (err)
>>> +            goto err;
>>> +    }
>>>         xe_pxp_pm_resume(xe->pxp);
>>>   @@ -616,7 +628,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
>>>         xe_display_pm_runtime_suspend(xe);
>>>   -    if (xe->d3cold.target_state) {
>>> +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>>>           err = xe_bo_evict_all(xe);
>>>           if (err)
>>>               goto out_resume;
>>> @@ -632,6 +644,14 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
>>>         xe_display_pm_runtime_suspend_late(xe);
>>>   +    if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
>>> +        err = xe_pm_vrsr_enable(xe, true);
>>> +            if (err) {
>>> +                drm_err(&xe->drm, "Failed to enable VRSR: %d\n", err);
>>> +                goto out_resume;
>>> +            }
>>> +    }
>>> +
>>>       xe_rpm_lockmap_release(xe);
>>>       xe_pm_write_callback_task(xe, NULL);
>>>       return 0;
>>> @@ -669,7 +689,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>>>               goto out;
>>>             xe_display_pm_resume_early(xe);
>>> +    }
>>>   +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>>>           /*
>>>            * This only restores pinned memory which is the memory
>>>            * required for the GT(s) to resume.
>>> @@ -686,7 +708,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>>>         xe_display_pm_runtime_resume(xe);
>>>   -    if (xe->d3cold.target_state) {
>>> +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>>>           err = xe_bo_restore_late(xe);
>>>           if (err)
>>>               goto out;
>>
>> Please rephrase commit message. Other than that, code code flow looks 
>> fine.
>>
>> Acked-by: Karthik Poosa <karthik.poosa@intel.com>
>>

