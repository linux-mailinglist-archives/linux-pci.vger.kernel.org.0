Return-Path: <linux-pci+bounces-28574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E7AC7899
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 08:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75605189C391
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 06:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C7253F31;
	Thu, 29 May 2025 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKA31D/s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7481C8638;
	Thu, 29 May 2025 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748499561; cv=fail; b=PoxxKUEz8MfNaAVbdEJpX4etSKK7M51bXWyy+D+8wR4ZfTBMcoXWQkFBFZI0kDAMMGKrZSmqjcItgqD6Y1VeN0KoEgfPK0wXBLpU+/jKkZdO1cFAo/YXCauOcUFlKzg1QiAJanHB3GogOtHUuCbnBu7vC+MFOkQ5nUN6DazdeEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748499561; c=relaxed/simple;
	bh=JAKvVsJdGqxUiykKLD6ByLQ3tXxbDASNa8R8twZNvzU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IUly/OBirEiCzJg6EefSEk6Yyv2Qvv+62HqNfJvUAgHZvACNkjBhnEeEne4wRQ2eiiu4vvVXSavayFjNwtzPijTmLM5Yq1wL9vI4NprxiL4aEn+zzYcsj2PrcVB+vF82S7qGIyaiLV6zWQoAquP/8GOoTYIdSGaCuoqPiao90Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKA31D/s; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748499560; x=1780035560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JAKvVsJdGqxUiykKLD6ByLQ3tXxbDASNa8R8twZNvzU=;
  b=WKA31D/s96xCisFrZO/J7c5vlYAU3LpWAUIXZWUL4VyUsNIq7VkHYRTC
   XQs7uY4Xy+UwY5V889yGUuGnqc17cl/aj+LebRR83VzfJGvrRrUxQlt7p
   phM4dVKLF6vAXTUJU91fMBasdzFo/tVV4SMZqOmeliIiKSxfesJYqVK1h
   GhvE4PO9gecJw3Ajz04ShYD5z0KDxf2b92hB2sWaZGb/ZQA9BTAg/+Vca
   WQTN+SQptNq56YJno0W/7X+bOIoNpaP14hgEBkMEAU27I2v8pxnWIxb0m
   YIEKblZ+Xup1zHxmpEFzG31fbQc8q8RixPQO/tKuRWUgbQ3XHb58X5wmQ
   w==;
X-CSE-ConnectionGUID: hpl9roEkQEG6AWMc7fJGhg==
X-CSE-MsgGUID: t+blLf+wQ6WYe5i4pXhogA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="49663196"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="49663196"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 23:19:17 -0700
X-CSE-ConnectionGUID: 2KDdevX6QleJl4LPZjlnww==
X-CSE-MsgGUID: 7t8mH7iBS2+zPVef7MTpYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143938294"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 23:19:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 23:19:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 23:19:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.52)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 23:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utlaO4foXKHlm/if4SFcf2Nbqr82iDF42ZPMs0MnrNoPOVtaGt5vAJYBH1Azk2E2NdaddZ3CG/Tu1W/WDYJUEi/QQ5LFHlwgm52V4xklUgRvL2AEM7guKNGL9Si3vWEkQbw5CWiNQuY+PSO0CKEzv89okBBTDyX23d3mB0t6lUy29BRAthr/HkRLoW/YH3N3PGdYt1rSCLrQnw+9s32s+bbKReQPCVmrjlZvFpW+9GF/5bV/g85A7RryjcdBVcAb/MmoM7ibQ+Yk9/w4P6GnJH1ruJxAqT3d7YtfyGq+hK56Gu4kX3ARzVokoa1jEUloWCNwz1efRlMOe5c1Za8XQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL1xv3vSEhndvetAFbpR5wNVh9fjU1AF2lguzF6WJkA=;
 b=Rorw6zVB+fZE+wcWIM3drOdFEN4NN0mNmeE4NEkCG6H+6rxtBk8RZScaWleS6NaCogtfmjRvQNHShn/Ds9kENL6MeWL8Qt3XpJJdGzijeqbGCaJdzPgTYJIHLdjucxVCaa6rEvaYc7gL85T/xiiHJOF8WIsoYTHKOYoMxxKRpdN/bbvKmwlte0QhSDhPBsmJSvnqogZDSzIGTxmG9Opos51V4GFcTc6XT371lIZ6pGqj9F99+Ilz5njRV+emnY5YeSrFsZMgU3r1FH7jjOcik8Mu0pmSGfLnOVQb58xqUhlzhIHCuiWqJwsOikX2Um8qDRETEk37T8XmuhkOmQGx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by MW4PR11MB6982.namprd11.prod.outlook.com (2603:10b6:303:228::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Thu, 29 May
 2025 06:19:09 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 06:19:09 +0000
Message-ID: <b5a54c14-a6b2-4a91-9618-c03cc4e775ed@intel.com>
Date: Thu, 29 May 2025 11:48:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250523190155.2623462-1-badal.nilawar@intel.com>
 <20250523190155.2623462-2-badal.nilawar@intel.com>
 <e9b74268-7b5b-432f-9a4b-9566b0a62ca0@linux.intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <e9b74268-7b5b-432f-9a4b-9566b0a62ca0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::6) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|MW4PR11MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 407c611d-28ef-48b3-2aee-08dd9e78b89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU9ISG4vYmlTdEIwWXJ2MCs3SFR6VE1DY2RtSHQ2aGVBcUhFbUt1a3czbFkw?=
 =?utf-8?B?L0xIQTVIMzI0bUYveGMxT1NUelpHTFRSSjlCMmREK0lLUDh4aGxwd1RYYXpZ?=
 =?utf-8?B?eXIrdWNTVXprRFExL0ZmMGlKdVB6b09yRzBGUWc4VG5nSTJEb2FqdzFLTHc0?=
 =?utf-8?B?bWpVNU1GZ1B5NGFETU12dDZia1VvbHZWM01PZ0lxZXZMb1RQcmx2aGdsN0JD?=
 =?utf-8?B?a1NhbW52TGo0RVphbGtMYVJ6OHU3ZCs2S2ZkZDd3U0hESzlSeXlPeU9nd2p3?=
 =?utf-8?B?a3NDZmw5aVhwcWtGV1VVd3poOXdlazBjYi9WaGtCOTM1d0ZvcWRpazF1U3J1?=
 =?utf-8?B?ZUZZYXhyLy9CdFRhYTV1bGVMSnZKbElxZzZXVlB1UllUMUVHY2tTbmdoNkVs?=
 =?utf-8?B?VTNtTzlvdnZUWVdINXRXYlJQR2xrVjdidHVKb0NFc3g5OGkvc1lkMnYvNnlP?=
 =?utf-8?B?VjJOK2Fqdzl0b3UwbnhwS2N3QVhvNFJNeXY4NU1MRHZVc2dQN084ODVEU0pE?=
 =?utf-8?B?Q0J0RHNGTS83UGJxV3VoQk9SVHNkdW13aXB3VHJLejhrd1NxV0tNUlkrSEc3?=
 =?utf-8?B?Rmx3Nkg3ZlNMSXZMekJCSE1TZnFOd3lEUEZGalcxWXdSSTBuY3J5UVJXM3Zu?=
 =?utf-8?B?Z1o4MkpuT1BkQXlpa0thZWJmNHNzM2tHVVNOZloyZ3R3U3RUVW5NRFZsSDUx?=
 =?utf-8?B?RFNnekRsTXlvUVIvY29HcUgzS3BvUUxVdjlndklmU3NieDdvNThqVWxLOWp5?=
 =?utf-8?B?TVNDdGR2b0hSbE8vQjQxbDZOS0xMSk1pT2U0bnVEWER1NXo3QUR3dDZnenFh?=
 =?utf-8?B?Q1dSdTBQRnhhNnJLMWF2UkJhTkYzekprblBabk8vZGx0THBTR2JuZTRqNjZm?=
 =?utf-8?B?UUxBQ1FHQUJkZW0ySmxPazI1ckMzUk1WZ08vMmcxc1RlN3ZXcFJKd0JKZ0Zm?=
 =?utf-8?B?NEZ6UVFyYUJzSi9rUzdoQStPRG5FVDlHUEI1RVFUTm56ZzlJV2tKTUhOaUZr?=
 =?utf-8?B?YktnQTV6RWkrTUlJaGpKMWlJc0NEOXl1dHBzMTRkaTNDZjlDVHlrZk9vSkIy?=
 =?utf-8?B?aHgrL2xqTStra0RuR2xFcHRNN1pQOExrTy9iRWppd1hlN0RmQUNFcW5TTFlK?=
 =?utf-8?B?UXhOSVkxd0ppdFRSbUp5ZCtkTFJyUVRqZThnTkdvVTVpWUR0NzJnOTUyUDVy?=
 =?utf-8?B?VFlrWkdWdVR1SG9UaG9aazFoaEVkTDhJcU9hb241RzNKQXlhVkY2RDhtOVM5?=
 =?utf-8?B?eHFFdWR6NStDTndVL0FZZU4xa1ljSE1XMklESndOQVNRN0p4SUUrc01BZjNl?=
 =?utf-8?B?Z254TGR0a0FzakJKVVNkdzJsUGU4QTE2bzBKWFFhdmZkQ1R5dkpLVXM3Mm50?=
 =?utf-8?B?NzZLU1lUTWg4Z0F1RG5lZHN2bS9henVqbFZ5ZmpxOHI0Qnh1dXd2SVI2NHdQ?=
 =?utf-8?B?TkpqVE5RUnFxZFpnMFEycU90ZTM2elpKYWpNdkNnd0NvTXNPUHA2MkFhMmxu?=
 =?utf-8?B?YzRwOWd4WmlqK0VSN0o0ZVduRjdoRVI5U0VEblIxWEhiM1BlVTJaMWRkOG56?=
 =?utf-8?B?NHBvazNnNkpjVEY0VTZYN1ljQ2QvODNBK25GbXpreVprVGl4R2RGZ3g2VS9m?=
 =?utf-8?B?VzlVKzdQUWdTK0FjR0laU2ZETFQxQ29ienIzbE1abEZWT3dkTUg3aEJrSThk?=
 =?utf-8?B?cjRsd0ZZSXJ2QlNPKzFCL2I2QWVVVzkvQytoTXIrL1NFOW04MmdPKyswbHNo?=
 =?utf-8?B?WTJBQjBjMWtObzBDWHhTUnJDUkJYQ1RHUFRHU2pabGNURUZocENGbURMTkxI?=
 =?utf-8?B?RHE3MG1jcVgybVNaMFhlSWkwS3IrbUZUQmdnLzVOTEZPM21GVXZjV01rV0pG?=
 =?utf-8?B?OHZCam96Z2ZneTN1bERxeEg4TmZ6amhxNWtTYVlZbU1Oc0FrZEc2Wm5JK08w?=
 =?utf-8?Q?6KrMtWn9CBc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkcwdDhCQ2VEVEhvZklmVjBvQ3lnOVh3ZTFOb2M0WW5zZTJTZ2ZCdUVORjk5?=
 =?utf-8?B?ajJWM1pRa0U1L1YycmJuVFp4Q0crZ25JamdnSEEvcDhBOE1XOGdtT1MzWEVv?=
 =?utf-8?B?UFBnaVA5SVYyUzlWblVscWFwOXlYN0h6ajM0bXJXc3M2OG5wRjBCZmVPcEE5?=
 =?utf-8?B?TWQvSzF2dngySWh5TG95N0FyeGo2MnRnOEdxTUdTckY4dGRmazlMT0l6L05U?=
 =?utf-8?B?RFdRamNSdjBBNTFLNlFYcHhiNnppbEJYSDlZWitiaXlzR1BxNE1RZGFLWjc2?=
 =?utf-8?B?MVFlMFhZWkQ1bkxMNW4rVVUzWEZ0WjZ3SVdNMzJ5WU5pdlBsU3VRL0Rpd1g3?=
 =?utf-8?B?WUFZdy9tUmpQTkYydmpIaUp2bi9JVlhwK0JTTTZ6R0F4UXp5dy9XcDBrYnhV?=
 =?utf-8?B?WHlmcjFnZFdHTHZDYTN1VkpVTWVqSklqZDhJdXRldDJHTHVUS3hoNUtkOExS?=
 =?utf-8?B?bTVvREUvYnh0WHJ3eEVkNnlUeWJDaWIrbkx2RGU4N0Nsc2ZRY2pjVXM3RWFv?=
 =?utf-8?B?TzZTUjBpakZtUGp2K3RUU3A0SzE3SUVHYVVrYUtUb2k3RGIyaUFacnluZEtr?=
 =?utf-8?B?d2JGMUJUaEhyc3dCSEU2YTV6UG9OK0NRTzQyYkg1dldueTl6OHlBOW10T0l2?=
 =?utf-8?B?SEVNRjRaVWNJcjB1WFlQd01oeGRnOTRPRXg2UVJrQWhVMGVlbis2NlB6bHY3?=
 =?utf-8?B?aDRNMGdmQzRwdE9EeHJTMkd2SGFDeVFtTE5QcU8zeDRPRGlQUGZNVlM2RDdX?=
 =?utf-8?B?c3lXbS9iZFdZUWNmcnJ5c3kxdmxqT0RNS1hPYU9JUGh6cWkwSjNtczVqSjVG?=
 =?utf-8?B?dGZMbXZOcThZRFpnSmRLcWQwT1NseERzRFpuRVNGa2NTamI4U2YvZEJURXhs?=
 =?utf-8?B?eGpvc0dHYjR5RnA2RzZuV2x0aHhrUklyZnlUZUlCa2c4MW82dEFsWlEwUlVh?=
 =?utf-8?B?MHh2WXZZV2JIKzZ2SzZvN3EzbDQ0NitGT0pCV0MwQVVHcXBlT2VrL1VXbGVE?=
 =?utf-8?B?R2xuZ3ZyOEhQYmNJbm0xdTF4RE1JcUJrS1E5Q0Y5aWVKSC9vWllOcXpvWGRO?=
 =?utf-8?B?Y0x3TzFyNXMrYlZBZ0lESlI1YVNhd21SQlhzdGtDc0dUcktZVzZoaExwMHEw?=
 =?utf-8?B?cCtFU3JjYUZtci9wdy9jeWExZ3djVDRZWGtnbXZQVU50a2ZESmJ6YmcwTXJL?=
 =?utf-8?B?TE5aQUV2LzBBcTh1a2c5a09Tdll5YWFOTXVXeUhpMnNweE44VjR6L0VOQW85?=
 =?utf-8?B?ckNqVk9QWmZodkphaEFnTENSNHVpT09LRTZ1S25tOXhTcFRpWUxwOXpNRTdS?=
 =?utf-8?B?Tm4vY1QzUW1aOWdHL015QXhoU3A3eStVRzlSQU8rR2dLRWltaFI1czdQYUVt?=
 =?utf-8?B?dnQ1M2RVT0Ewc2N4SWREM2hkYTlCYTEwU005ZExMd3NtMVN4SFYrVjhnampi?=
 =?utf-8?B?SzNhemJlVXZ6d1NIWERRTGN1bDFjcVVFQ1hPMmRqckZTWWpzR2Q2Y0k5N24x?=
 =?utf-8?B?T2drZDRZMWh4ZE05RDNFa3VPczJ1SFJwZWJ1bUlSTTdBVS9xbGVRNHJxcW55?=
 =?utf-8?B?OHcxT0pyZURUdmthMzgvbU02YVFKQkNMVUNzSENZKzVQYnB2U25xM1BxMTg4?=
 =?utf-8?B?emFjOElaaG54OHIvRXJuR3A3Y3JYSlhmUHYyWEhFc3RJWFoveFFPVjZaaVlx?=
 =?utf-8?B?SDBhKzc3R1RqcWMySWdHbGxDTFNuNE5aNHZsVEpuOSt2dmQ1bWM0OEVMTWFx?=
 =?utf-8?B?MmlQTFBkYkVwTjlvdmFXcXArL3E2cFBmTXFvUXR0Nm1CV0FSMUcyd2FzRTZy?=
 =?utf-8?B?SFpQaGNrZnNuR0E4bmlPc0RlWGNVK2N5NzFIOWx0bkFNN0pYM1pIRGtjVklG?=
 =?utf-8?B?L2F2Vk9IajM1c0dENG5tNHFTbU1nNVhQUzhaZUlkbmU0TEJTZlk3U1FQR0Q0?=
 =?utf-8?B?OUFIa2NxREV0ZWsrOWxmWEVDbUdRWEZTdzRJMkl5dXhFTTY1M0xKdTFpOHNQ?=
 =?utf-8?B?V3lCclViTndiUHNsalRjYVNhcGo3aFpQV25tNlFVRWJnVm03TVRlRUlaT01W?=
 =?utf-8?B?ZDN6enFrT0dzekxuYy80MktTVlB3YVozL2lTdlplZlZTRjBRbnFEVUx6MXNH?=
 =?utf-8?Q?g40Qu8/v1oGsFISsvNWZHtt6c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 407c611d-28ef-48b3-2aee-08dd9e78b89d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:19:09.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lsnsbsiupEbfScBhBhGhUuwdaJqUGRF1w53VRj1pkt0NZSe/DCkf3zt9lwKzDoL8hQ+xrrXcOll+7A3jupBDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6982
X-OriginatorOrg: intel.com


On 24-05-2025 11:30, Sathyanarayanan Kuppuswamy wrote:
>
> On 5/23/25 12:01 PM, Badal Nilawar wrote:
>> From: Anshuman Gupta<anshuman.gupta@intel.com>
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
>
> Add some info about why you are not adding this support?
Scope is limited to enable the use case of VRAM-SR on BMG GPU. I will 
mention this in cover letter.
>
>> One possible mitigation would be only allowing only first PCIe
>> Non-Bridge Endpoint Function 0 driver to call_DSM method 0Ah.
>>
>> V2(Bjorn/Rafael):
>>    - Call acpi_dsm_check() to find method 0Ah supported
>>    - Return retry interval to caller
>>
>> Signed-off-by: Varun Gupta<varun.gupta@intel.com>
>> Signed-off-by: Badal Nilawar<badal.nilawar@intel.com>
>> Signed-off-by: Anshuman Gupta<anshuman.gupta@intel.com>
>> ---
>>   drivers/pci/pci-acpi.c   | 87 ++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-acpi.h |  8 ++++
>>   2 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index af370628e583..76b19525535f 100644
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
>> +    if (!dev)
>> +        return -EINVAL;
>
> Is retry_interval param optional? If not may be a check here for non 
> NULL condition is needed.
Yes its optional, its up to caller weather to retry or not.
>
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
>> +        *retry_interval = 0;
>> +
>> +    switch (result) {
>> +    case 0x0:
>> +        pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>> +            requested_power);
>
> is this not a error?

No its not error. BIOS Firmware can deny the aux power request.

Regards,
Badal

>
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
>> index 078225b514d4..1705d03bfe26 100644
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
>> +static int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, 
>> u32 requested_power,
>> +                         u32 *retry_interval)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>>   #endif    /* CONFIG_ACPI */
>>     #endif    /* _PCI_ACPI_H_ */
>

