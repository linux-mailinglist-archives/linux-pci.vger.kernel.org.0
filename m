Return-Path: <linux-pci+bounces-7725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A618CB353
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 20:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9281F22A81
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 18:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B2238FB0;
	Tue, 21 May 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOo1Su9m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A823775;
	Tue, 21 May 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315118; cv=fail; b=cX4qc6PYTfVP6ZApuDi99BPYTG/HXKMXMRT8IE32kf1DYpD/meFXjbnjlI4/vi3dEY1qvbK3kAmVknE8uewcDSapR+1Kk2sZD9Z63KEx6HY/Lg/BtbRhp3ku9fdt7c45+AEyYt+fUIKyWGn4K23fMM+zY9DbppeWhaMAX8+XRKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315118; c=relaxed/simple;
	bh=cGIHjmyJXwP8vw/yB0DG9qOmMbYhCfZlMqhUeevji8U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FdRKVZdDOxSmBAd2JVsQKIbwIuSjPsJ7CcBqbjLA0YBPKmoLd+TibmvkXvpvzKG3J+kiKggox0E5dfqGg4fgikztiOHkVtOfOrOqbuJQ6MJ9ZML9dgiiERUabE/X2R3s5ahxMTMzegSz5XBeR6am6Ng/0gCKdtmMwFd5hs4Vafc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOo1Su9m; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716315116; x=1747851116;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cGIHjmyJXwP8vw/yB0DG9qOmMbYhCfZlMqhUeevji8U=;
  b=AOo1Su9mTwr4joNcT43p9/9QHr1cHI0A23LbA+OGxOQfC/fdHNkNNQUE
   d4rHYeA8dBqi03fU7zzuZF/7N9TSAR7lSqxXfRemafWrVLjEhmUbyVmtR
   XtdpYBfTrz57mwnpNdD71/UtPY/7jpfdhBYq0Sa3/o3Dzvk89UaGz8j50
   GAd7TK1PuO44dYpvaw0iERFPaR2gc9hniPyLpS20bkqtlxYFrvKp9OcMz
   nKvI1t3UK9GBtknrNU/OxmOR0cDqnuugI3MmniimWJSrJFdp0kZgxR0NF
   wNRBDGBvYPGKKHWmiub0cmXxcmO8lDthI98BEii7tMD23hKzittJaWWkC
   A==;
X-CSE-ConnectionGUID: 7KFX0WwZTPKeGrcMUnnb6w==
X-CSE-MsgGUID: 9GH33otbTEWDR7GovjGrMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12704714"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12704714"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 11:11:55 -0700
X-CSE-ConnectionGUID: KL+c8waqQMaxgY9eKOJSxg==
X-CSE-MsgGUID: Ump0C39dQEikB54HpA5kFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="37841261"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 11:11:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 11:11:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 11:11:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 11:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFRJLCtW6vjBR0rYCXk3MgutjIxFW4dGO5IfqMs/PP28BlhHx/gt/0DNlPXoxeZw6+cEe6EbGA+xcneg7H6OIsSLFVZIcSDtkmG5xxrWakyOQvbhp/JlegRqxBEBthkqdX09nmB8X9qY0f15wUHsfgvjeWS1JGroxeUSwK727e8iC8fF2zBCa0LiM8VFnIi6Uf3rzlr5hHLifEhSHGQxp/kYZN4/M7OZ/n6k1DJ1stvLY6roYjVxLwaJxaVD4gFT8nww1VuU0gmU43MXUz8IQSmutZrwmm+rGVPDPJlwxS0lVI3p86xRGfEYX+hsv4ov6dtfz5whjgjBtWuPMogFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGIHjmyJXwP8vw/yB0DG9qOmMbYhCfZlMqhUeevji8U=;
 b=maZypzh+kgPbU2Rzgap/NM77ziMRfDmzgcYdjEeIXzHlaEYXpmU2ZWK4vw6SsFaB4Zv24LL/fyXeu7bAThYzBAPbMNkihmtrOzOTbco/hVwayAaGmzKoFuSfUyCzxSCw99/hn0dnrrV1S59/jWGyBbxW3M/vMsov/j+K+YZKYC+LyfAmIRwEHUy2Fu7GYQ+FC45MQ19RLm1taEtXjWZmwfZz0voBOrW03iGjzGLYhU8i01A4lgyY35MJwOKwSzt9nhl/ZtUGG8NZcLYwLeUoTwpkHUheWVDbP5NtlmuVL1T4bB/zl3jJJGMdiOjMJZi1xGrljV0pEVuU0oebf4kbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8248.namprd11.prod.outlook.com (2603:10b6:208:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 18:11:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 18:11:48 +0000
Date: Tue, 21 May 2024 11:11:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Vishal Aslot <os.vaslot@gmail.com>, <dave.jiang@intel.com>
CC: <Jonathan.Cameron@huawei.com>, <alison.schofield@intel.com>,
	<bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <lukas@wunner.de>, <vishal.l.verma@intel.com>,
	Vikram Sethi <vikramsethi@gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Message-ID: <664ce3e1a25fe_e8be29431@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <E1AAAE3F-E059-4C57-BC23-6B436A39430A@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1AAAE3F-E059-4C57-BC23-6B436A39430A@gmail.com>
X-ClientProxiedBy: MW4PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:303:83::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efa5bf2-98c0-4332-017e-08dc79c17b60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk9QSnF3dDdhODZvR0FHamxhUGtucVJJRHdUL2lpNFBUdkQ2VG9yV054aXJE?=
 =?utf-8?B?YkV3L0tEV1pudjJTUXJHR1EzTTd1djBCMmJDWDhlVk1NakNKSGVFVjBqdTVa?=
 =?utf-8?B?YXorUXV0NHpucCtjREdLMnd1aGdQajhFZ1gwMTEvdDJQblZ2elJiL2NtNG5u?=
 =?utf-8?B?Rk41WGU2S1dhMjd5UFFOMlFwRkR1K09TVy9RRlMyYmxKRmRwUk5QRERMZ29m?=
 =?utf-8?B?cmpzWDNHT0dCQlZGSkRacTIvRkFUNmRHYTVkR0dCZng5dHlaU1RkTHAvWXJU?=
 =?utf-8?B?R1J4U3A3eXBWcjU3ZE9IUnd1eFRIUFBKck1aZXRGQVBvYy9VZVZHR25lcHY2?=
 =?utf-8?B?Z2RGZS9ZRFVFU3dON01xNnRaN2d4QmxHNlNQMXJJcVBubko1cWtiMVpNK1NT?=
 =?utf-8?B?TXhjb0orRXRkN3V4WmcyNUNrYkNHaVRmYXJQWEVVRzlFRFFjV3c3QWFvaGNH?=
 =?utf-8?B?bE1QQTlGVEJVMlZ6S2FqUmRZUHQrK1JheGRKS1oxOWRnNTlBcTNmQUpPUzFU?=
 =?utf-8?B?VEJ5TzRCL3QyRWZsbHNFYmlLQlRweFVCQjNTdUNjSG8vUG1MdHJ0MDhIcWlO?=
 =?utf-8?B?RFhKK3JCeE5uZjdwQjhvakFYWGN5L3hvKytzdnM1eFZmRnllV3I3N1BuNjRF?=
 =?utf-8?B?RC9JUEJqTkp5VzNUNmdVOVFhV0VhS0NjSmkxM01FQ0xGbUZtaVQ3QWhldkpv?=
 =?utf-8?B?M29sV0N1OFlvWHdvZ25Zd05qMEpVSFhiSzdkUjhvTFlhU2NnRTVWZncrbENI?=
 =?utf-8?B?ZWhDT1c0dEJFOS84ZHBQMi9RaTBoV1VyZFVZOSt1ZmpoSEZRTEhtMm1mWjJy?=
 =?utf-8?B?WnpEV1RvOE9ac1A1T2lHbnJVaVVyamRqbTc0dHFvVWZlNXlPSkFqOEFSSnA2?=
 =?utf-8?B?WlFOSDNJM29iNDBnaVJ5ZW00OWJEQTE0UklZZjVpSXdkc1JUNS8weVB6TG5F?=
 =?utf-8?B?SU5UUGxIVlhCeVZRcHVUMHNWNmdzMEp5QWlPbEVGc1ZIVWRMbTFURDVJaG1p?=
 =?utf-8?B?UXZrNDRMaHZzSlVwekVZR2VuKzRMRE9JejRMS0dlY01DWkhXVXJNOTlIbjlw?=
 =?utf-8?B?MVNyWHNRNVlCdnZUcFh1bHZobitaQVBSWnVocFdBU0VJUzV4QjJuQ1VhbWhB?=
 =?utf-8?B?Yy9hb3U4U2cxbUdWcEZUZTlkNG9DaGcyQVZHazhXOUp5R0p0VnFJQmkxSlhl?=
 =?utf-8?B?M1hGSFBNbURPYU54Uk9JaGhrbTB3RUpLOTZFMGVvQTFsMDFrSGcxQWllMlRI?=
 =?utf-8?B?Ym1xN0k3aGdDRzl0QWxVSHZEZ0RLTmlwQWdDKytYNTMvZS9JdU5VYkVTK3U1?=
 =?utf-8?B?K20vWVZ6cGk5MThDN2M4K3JSUEZoZ0F6U1U4RVdQcnpMK29Sd1NPa0xUTk1n?=
 =?utf-8?B?QTNGT2ZrWjRDV21GMjcrQUZrME9wdWplTTJjR05SZzFtU2Y1QXhnRUNPU3pF?=
 =?utf-8?B?RTRmdEdORHh5K1kvRnEvSml2Y0hxVitjTTViYjVqT1lidmtzSVVORE03UTJ5?=
 =?utf-8?B?NmxweHdVcGEvaFowR1UreXpnL3VsRkRibURYbU05RUtpMG9jeWhDUmxZTjcz?=
 =?utf-8?B?OUVNa3NHNEx4eEVPNVRsU2ZDSWRTUzNYdkVVRmxQRXZhYklJdmNDcEU5MU1T?=
 =?utf-8?B?TU5lWVdjYlhTTGtoYlhFelZlQ1UwQ3pnMEtERWc2b0JxaUx0TVE1V1hUYVpH?=
 =?utf-8?B?TERqeVdBcVd6NWVWcEdjdGN2VHM1K2htRjV0dkhQcUZpL2Nrc2M0R0t3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTIrdFFLdElEays4dlVxK2V2NzRKbVpJUG9LMXg3MnErZzhhL1FzTCtjRzJW?=
 =?utf-8?B?Tm9Ib3JoblBnVVBxMDU1UHoxZlczekdWOGl1ODRPakpHaDl6TzM4V0lDV3d0?=
 =?utf-8?B?Zkg4d2h1YlVlRGZtcm1CY0RTRzF3SkViejRnemZKV01BeEx1YzBqQ0ZweCtr?=
 =?utf-8?B?dm4rcnpoVTVIeEU4b3ZMR09SWlYzRVNIK3NCc0dDblZNYlBsYWlieDZicVpF?=
 =?utf-8?B?dTFpK1UzTmw5aFBxZ2N6bkNNRlZLa1graDFDUEd5VTlDUGE3T1doeTM4OEFt?=
 =?utf-8?B?cUtLU2k3WkFTSnJTUHZiL3ViYXlSRVhzSk1Xd21jOWR2eXFKSFVlM21HWFE4?=
 =?utf-8?B?R3pjYS8wY0NobW1XNUkvNlF5RkgzRUpOWFdOem9mNCsxSU9vaXM4WloxSXJo?=
 =?utf-8?B?dTE5MUYreGlhSFJST2JnSEh0K0x2MEU0OTU2TjhCUndScmpSOTdreHZoUEhq?=
 =?utf-8?B?bXp3bFY1bXNFZ2hNcEI1TGRqMzB1blQvRmpsd2J1MlYwM01nWFl1VS9NL0NX?=
 =?utf-8?B?QmJHVmthV2VkM0ZmSjRlY2tqc08rVWZsTFJIdlZmb3RSZVZ0TmlWbDIxUlhN?=
 =?utf-8?B?R08zbTJ0cmp6R3JRUGxlU1VTYjhFemZ4ZUtvN1hwM2d4L0FRczN6NTFJeDJN?=
 =?utf-8?B?a1VLUWdzRVgxRzlFUm02eGxHSThDU3hVckhlVU9wU1Mrc28wN2w3Q04xUUhO?=
 =?utf-8?B?VzZTV2xZYm1sM0RvREhXN1pkVGpLMkVZYmVQQWFQS3Zad3MrdUFYREkwMDhv?=
 =?utf-8?B?Tkk2TEY1eHQ5WVVXL1JRcDRWOGExZmxibU0ybkhvVnBISnhrSjUwWUFxRlpo?=
 =?utf-8?B?MjNocldNd3hLNzZueW5wRnI5Y045bUZ3RGRMUE9TMzJsM1N6TElCM3BGcGRC?=
 =?utf-8?B?ZmlWOW5MazZOQmdmclNJbEY0eGhrdU9pRzhGdDhJazM1N0owa2hvc1B3M3Vy?=
 =?utf-8?B?SVRWcForSmVqN2h0YnNmNi9KQmNCTi8rWlhmOTBqdk5ZcmkxYVVhZG84V3lF?=
 =?utf-8?B?NnZHbnYxN1AraitpL09xY044elQyZ1ZvUmFBZTJvS2FtczV6QzVvZ2t5eEov?=
 =?utf-8?B?ZXNOeWNMckpIOEFTVUluNEZEVFB4bEhCZkVsaXVINStEREFBemdqdDRCaG5j?=
 =?utf-8?B?MDhLdi9VRWdObUxyQ3l6WE5qbjU1Qll5d3FvN0w0YlZmbk5OYURtV2U5dDZF?=
 =?utf-8?B?SjZhbzFEcnUvajg2YnNxTmVrUnRlY2RidGYwOEg2ZDdQZVVpRTdHQ3dqcjBE?=
 =?utf-8?B?eS8weXhjNXBtQ0V6aWFXQmU2c3dsb29ZTHY0dDBBeTVZd0taei9OYmlKTFcw?=
 =?utf-8?B?YXlEaWROSStKcDZzQkt2a2pZdk55MFJtY0N2NkJRZ3ZrRnk5VjBQTHZJMkZU?=
 =?utf-8?B?QjJ5NC8zdjJJSEgxMXFIYzdTdG5oL21MMTNHY1hYcWM2VTVmT1E2UlQxM1Zx?=
 =?utf-8?B?bWdSdG9pN3YxR3AyOXJPWlRpRjV1M2RtdE8wZzgyQWtCMGtDWCtpWTZNd3lC?=
 =?utf-8?B?TURnT0dLcXdYMG5HTm84RDlRQ2o2V0MvV0lxRHpFNHFkNGNnN3k1Z0h6cDlO?=
 =?utf-8?B?YW5wMjB5U1JEcXNwc0pVRWhmbWwwR3AwL3JwMUZld2VCemNCUUNXclBUMzZr?=
 =?utf-8?B?WTFsSFNvTlQvNWV6R1Q5L1V5LzA4aEQ3VUNkNS9wZ3VOckVVSmtDbWR4YjE3?=
 =?utf-8?B?ZjBYL3Z3N1VYYkRydDl0T09mQStKU3pjZ0N0S1U1KzhES1RqYW5iKytkTUZX?=
 =?utf-8?B?VjdvV3Z3UkozT0I3QUdDREJaaTdXaTlQd1FQeXhCNHpWaTdGckR3SlFUMGhw?=
 =?utf-8?B?TjYwSnBSZVVBUWEzaFA4WG5Lb3ViTHJaYk9Zbk9kc0k1cURmalRoYU9TeVVj?=
 =?utf-8?B?UUR1cVZ0NFZleXhDT2tiZ2l4RzB5ZG5WajRvcUtWZkRqR2NxS0QwYmNRTU5z?=
 =?utf-8?B?Ty9JSE8xNEZ1SUwrd2RteXlFZWpCUnNlQVNZZVpTWjNZYitaaU9iNXVWMWEr?=
 =?utf-8?B?T3BrTkVhVzlwRTJ3MTR3Q3A4RFpPQXZ4QldKTEdMWTVqM0V3U3FQZmRFSVMr?=
 =?utf-8?B?TnZ0UU9Vck9BcmhoaWJnTzltR2RyU3NMRlNDTmJheTdmbGtpaUc0OTJRNXhm?=
 =?utf-8?B?Mlk1amNjS1FIT2YrMG9OVXFuaVJDc1k2aUtDaXVwcHhQVWYyYjNWTFpHcC9i?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efa5bf2-98c0-4332-017e-08dc79c17b60
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 18:11:48.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/v8oqi6WuV90v/Ivv3BWv5Mu6yCveXkLCKUgUmEsoHiUAvkq3X4OLn9cx1JFx5olVpJL+sDBtY22Lg+sBzCB7ZQxj8hGFxO2vRWrBI8GlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8248
X-OriginatorOrg: intel.com

Vishal Aslot wrote:
> Hi,
>
> For T2 and T3 persistent memory devices, wouldn’t we also need a way
> to trigger device cache flush and then disable out of
> cxl_reest_bus_function()?
>
> CXL Spec 3.1 (Aug ’23), Section 9.3 which refers to system reset flow
> has RESETPREP VDMs to trigger device cache flush, put memory in safe
> state, etc. These devices would benefit from this in case of SBR as
> well, but it is root port specific so may be an ACPI method could be
> involved out of cxl_reset_bus_function()?

In short, no, OS initiated device-cache-flush is not indicated, nor
possible (GPF has no mechanism for system-software trigger) for this
case.

Specifically that section states:

"...it is expected that the CXL devices are already in an Inactive State
with their contexts flushed to the system memory or CXL-attached memory
before the platform reset flow is triggered"

...so if reset is triggered while the device is mapped and active then
the administrator gets to keep all the pieces. This SBR enabling is all
about making sure the kernel log reflects when the administrator messed
up and triggered reset while the device had active decoders.

