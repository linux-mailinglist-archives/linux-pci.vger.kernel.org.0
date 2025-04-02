Return-Path: <linux-pci+bounces-25146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57623A78C57
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D8E3AB8D4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC3234989;
	Wed,  2 Apr 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqIN/wIP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFB6236A72;
	Wed,  2 Apr 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589736; cv=fail; b=WkShs84t3DLRigqFnw7w2M1tE7JrOpsghBVeUMpwaMurLTg/IFFFKhgF4hBnHDIPpkwiy2MTDV5gVlTW0hirlzcXHkgsvswGSppfix2BQb/O62IrpvxR9dOAoDlqxPoBkW/GiMtTjpNrqHpCCAotvdFII4fjdU6Lg3EZqtu+Icc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589736; c=relaxed/simple;
	bh=0zZg99lprG40leU+I7z7TVl1RiIPkZ49E6Ryg2ExI98=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H3CJYSRI0sWpoNADV07JJA4a5iRC1NpXfx/6GfvuzoUOSPSyaHWE66OThybANasiU590QPG2wmf1wQxF4BgDNG8F3uQXTEJONN+5uZLGPIFBBnzuGlVUM6WT0Rn0OLFSnrD1JZLRKD/yyZ5sRW3XDqnzvLy2dAa1CD3Vl5D/vyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqIN/wIP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743589734; x=1775125734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0zZg99lprG40leU+I7z7TVl1RiIPkZ49E6Ryg2ExI98=;
  b=AqIN/wIPXzNMB1QFQjm9pD1ePvlG61XnS+inE55/2B5RHWAp5BIB1TT9
   moB1GGJEfxPV6TRMDwF3woMa5zHeyXNMfAXdVByGGOeqRdDuq2bB8K9dZ
   JQCTyZZZEXmV4cLTQHJSf+LrMV0728fTx4ZCZTO9ywKQoJa3LUP6+ghCF
   yEOH36vQweLb7iz+ixMZm0ImzNGrYT+UGA2Dxv6Drb5hmJAjzupk4r3G8
   Qz54HITZvnj5gVoPmRbqK1Y4VBr70xGXjrVin07Wvs2RVZjOjy5FMIa+T
   9SgHWOeBTf2vAxtFwiOo2Y8lM0e82RfzOQF++/28nr+WCFhcVsemNy4qy
   A==;
X-CSE-ConnectionGUID: 3JlwO6foSv2BRNC+kgDsHQ==
X-CSE-MsgGUID: dgzCngMDQV60p/jGaPyYDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="44093559"
X-IronPort-AV: E=Sophos;i="6.14,182,1736841600"; 
   d="scan'208";a="44093559"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 03:28:54 -0700
X-CSE-ConnectionGUID: hyGk7KExRIiAHp1Kd36DMQ==
X-CSE-MsgGUID: 5hniF4VVRgKR7UDG6u7alA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,182,1736841600"; 
   d="scan'208";a="127560615"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 03:28:54 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 2 Apr 2025 03:28:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 2 Apr 2025 03:28:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 03:28:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYf0yiisp2GVa4jcf1otsDLAuyrBWdWIeOI3cejCVo+3EANW1NZfUkcxAd9eo+ii9usI6ZmwQfayrst3SoN00YFZsZhsTkOfZQ9ORoqpPFTGDFodHnWzbFognxLgPHeQI+rFvxQLzHauea8u+7bKrwLcaVWqoDTO3E3aE3ssxGVd0kq+cGGfjlrZbVc9OzTxp5jLTOzR+y2/5EOQQOFxZhtSt9TearZpVfArmSSq3pmqnLYYqQNuOzUkGdBZ7tpwJbjRUhfH38ADjhYIXKnFuyDN7R1KWoPl4qzGVRSabblFTnww0MyxoF/IiOT6vx7b6Ev0STlUOVwLorqKI7rtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2OVIIsj5674QVO8gRcxgQqvPMgUvWzKwUCwDPrGG8E=;
 b=QHQ2gOvqH512f0SSvKlOeFixuIH5rDHRtxcf7jqyT7qT4bo+KjRDkGsgAnB3e2nowd0Sui6aop2wcpg0QX3z8QBCmUwfX4DCkGNGNkB4jrkDvLGRzIO9Bf2RAxqD8SsfavVedmKpWFEJYyvjmP3evrXor8firxLt/7vknsAXdnxkPzeie1mh/Z+KH1+bu4rfPTTDMU5UL5cFTQ8eHmWazLG6r5biFJ5oJDK/Q0JIhoBJPR4jMD4pnkQrkrooZYNPAT/lDAIHkRrOfm7YrgOy4d8VvZs6+rBWgVSmSX7NcNQdnzZPmoaNZphXA0YTCi16cpDJZjXq548j4HwCwFrfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5703.namprd11.prod.outlook.com (2603:10b6:8:22::5) by
 BL1PR11MB5237.namprd11.prod.outlook.com (2603:10b6:208:310::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 10:28:35 +0000
Received: from DM8PR11MB5703.namprd11.prod.outlook.com
 ([fe80::f734:e507:3083:e454]) by DM8PR11MB5703.namprd11.prod.outlook.com
 ([fe80::f734:e507:3083:e454%4]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 10:28:35 +0000
Message-ID: <ebd79f62-a7e1-4b8a-9d75-22bbecfd4b36@intel.com>
Date: Wed, 2 Apr 2025 15:58:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [10/12] drm/xe/pm: D3Cold target state
Content-Language: en-GB
To: Anshuman Gupta <anshuman.gupta@intel.com>,
	<intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <bhelgaas@google.com>,
	<ilpo.jarvinen@linux.intel.com>, <lucas.demarchi@intel.com>,
	<rodrigo.vivi@intel.com>, <badal.nilawar@intel.com>, <varun.gupta@intel.com>,
	<ville.syrjala@linux.intel.com>, <uma.shankar@intel.com>
References: <20250401153225.96379-11-anshuman.gupta@intel.com>
From: "Poosa, Karthik" <karthik.poosa@intel.com>
In-Reply-To: <20250401153225.96379-11-anshuman.gupta@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::8) To DM8PR11MB5703.namprd11.prod.outlook.com
 (2603:10b6:8:22::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5703:EE_|BL1PR11MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: a355dc09-aca3-4385-953c-08dd71d11f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXFxcm1ZeUFXaWtrT2ZFNjZsZTRJRTBuU1graFNka1p0QmpoaENCL1ZpSDZP?=
 =?utf-8?B?dldpVTUyMGJFWmY3TFczTzQ3WThCTjAraGQzLy81WE9vMnZYQkwveTU0ejlE?=
 =?utf-8?B?RzVlZU1FOUdQc1hmSXJBaUVpNWZreC9Va0VPMFhsN0lScFFBMStSU0RqZkVh?=
 =?utf-8?B?RGcyUlFjcVpNaUQxSlJVS1NkcDcyMU90MHB5eFNIM2xSbHcrVFYxYk1vT1JJ?=
 =?utf-8?B?dUNWMC9Ed29HNjBGczJSNHNpL3VURHpvbGZ1QVpxSXdTZVZXaUhBb1pDNk1K?=
 =?utf-8?B?WG9GY1lMMVcwZld6N2NLdG9rQ212SjZWWU9CYTlDR1JXZTNmZ0oxSkJHNDlo?=
 =?utf-8?B?eDlQODI0QWtVTlJHRnA4UVNQTUlUK0xaSnp3ZUZuZm1vY2R2eWxHSTdtbmww?=
 =?utf-8?B?WHFrUWxyZ09DVk4zVGxZc0Mwb0NreFF4aGF1ZDNlK3dkVm9XYk1Lc3JGVmM5?=
 =?utf-8?B?dWJlVWlhN1pWbWpXM1hIcTFlRm1jaGFFREZna2p4dmkrM01YWml3Ym9xcnd1?=
 =?utf-8?B?MkNlejdNd3dVKzZHNVpFcUx6bC9zMnNqVmRGYU8vOUlISHp1U09ETk5UUDBJ?=
 =?utf-8?B?MjFCSFA1TnlvM2ZRcE5rQ2phOWE0OUNYWThxSk0wRllxN0pqYXF6aVIxRWdG?=
 =?utf-8?B?TUhDRDlkeWduTXNweGZXQlZqVkVsWERBQWNMVC9YenVTL2dvNXg3TXZHVUhJ?=
 =?utf-8?B?RUdTUTRXaXBtdEp1ZnJKeGE2RUtrRllsVDhkRXJTRjBHWERudC9DYzN5d2o3?=
 =?utf-8?B?Q20vNWo1NHMvc1NORjhEdWRSMy9Hb0xvK3N2MURGRHpMdjlqdkFYbUt6dmRX?=
 =?utf-8?B?QXhwRHozbmNQVTF4ZUkrZVBBQVlXM1hMQjZMTVlQSVJmMWhOZE1FTnNGZE1z?=
 =?utf-8?B?aThxTjNBandweFhncnFqdWRzSG5TdW5CYW1XK1kwaEVUdnc5WExYbTduUVlY?=
 =?utf-8?B?R1lYbG0rK21xZ3pWa1BDOFY5MDI2QnA5VVNiUnZ3RXd5NW1sOEVVcDRIWFFn?=
 =?utf-8?B?MEJBbU1aWk1DM0V3c1ZsMWgvWE1HYXF5Z24yK0pmQ0R3a1NUbldGN25PcVQ0?=
 =?utf-8?B?Q0lQc2tzL1BPSHV4bk9DZHAwMEtKZUtxM1Z5N1BML05wTWd2eTEvMklPUnlM?=
 =?utf-8?B?RUhoK1JuTjdBZkppQThiVmo3QzhHeVF6b1Y4TGNkQ2ZsbHpSN1FDZ2JCOGtP?=
 =?utf-8?B?NEJ5NHpxc0NYd1VuUjc3NUFKSW5OQktMTnNCeVhCQ0lnaXNRZG12d1NVbmhy?=
 =?utf-8?B?bVlnRTdNMURjWG01aEdEbmV2U3pTbC9mVVZ4UWRDcFFQV3p6VER6Tm9UaWIx?=
 =?utf-8?B?czgrSkMrYkhhSlNjek5xdWo4TjRPcEtIRmIraFRneWZxZWlCUW13VWJodzZj?=
 =?utf-8?B?UHAxSWV4SGduL1dQRXRyVUNtK0ZlVUkvU2ptakthTXhJK09TbGEyeUJvSXIx?=
 =?utf-8?B?cy93SVZPYjdEWGpFeGVIU0h6MVlFbG9jS01xeDNkMDUwVllMYTZWL2dQR2xX?=
 =?utf-8?B?ZmFYaElublczQit3WVZ6Wituc2lBZWNnZHZSdlhmU21QQW1FeXZFZU5PSmJ0?=
 =?utf-8?B?bHFjSzFiSGFHc000VlVlQXRCdk9oZXBlVGE0SUZBTVpucXZuMnpnTmk2L3Ju?=
 =?utf-8?B?VXBLTjd0RkVFdGFMcjNmemNObEttcXpvaHAzUWxSNUFER1N4cHhaWnJIZ09D?=
 =?utf-8?B?eWorRWVSMEhlb3JRTjB1TFMyUTVsWDlRMlhRWnV3ZjJkVkhkM0R3M3dDRjV1?=
 =?utf-8?B?ZUlCclB0ZUx6L1pJd08xZ3hyTG5zQ1Jzd2pNekM2WDlkWjBWMXR0MlQ4czVL?=
 =?utf-8?B?Yml6NEZLbGNnMjNuQ2p2REZOK2UyRTVPeVBrWEo2L3UxMkVuZmxrUDBWb29i?=
 =?utf-8?Q?+KU8gUs2/X3NO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U01TaGRsZFN1dCtrT3lTSUVCSHJVUlJVbXFJQ0x4Vmk4UGtoSHdVemM0d2Zn?=
 =?utf-8?B?aUEveGlzR1FlWDZBRENxQ3g4VGVWWE9KSjgrVm5uMXBqREtONjJpQW5oTDVj?=
 =?utf-8?B?dDNjRFRkdG14U1QxZ29kMlROanJHWlRYR2E0RTVCU3Z1YXdTMENRY1pwOTBT?=
 =?utf-8?B?Z3krbVowUTVibmtiR0laUktMTzVhNTA5dlFWZ0N5UXpkRlM5UytXNVF0K1JO?=
 =?utf-8?B?M2o0VTBhV2lEeW52dmM3b1FCcDZnbHZNYlJiK2VOc3NDMHhBeTh0S2YvSlhN?=
 =?utf-8?B?SnlwSXJMRXhwckFKUldNY1ZZbDBIbGNKL0I4MElrUS9TRExFR3BFMG9WYzEx?=
 =?utf-8?B?d09OQzJPcGlTM2xXVzV3YUpaVnRNbjNPQkUwZXpNaWxoMUpQeXMxMW5DVndt?=
 =?utf-8?B?Y0t4K2I5TEgrbWxURUZ2cDR6U0xvNUpkaDhOQ3N6Mnl3TGtKcXlWTnBHVzdn?=
 =?utf-8?B?U2hLMTlZY1hWUGlOeFd3RDRIOTFPSjFsbVVVc3IzWG9yN09vRSthdEplSEhY?=
 =?utf-8?B?aGx6eUpaeDhZUEdQNkE1TEIrT0p4eW9iME5ZM0JPYnBwK3lBV24xWlhxV2E5?=
 =?utf-8?B?RnBWWFBsYmlnRURLdGtPMWEyZGNaZTV4WkkvTm5FbnoraW1jWFdsTktIb3VC?=
 =?utf-8?B?R0Z4TmZyaUlZblNYVXJmU0xuN29UZlo2bFJzSG00cnAvekEybGMwNW5vdEVy?=
 =?utf-8?B?MjhBZVlod2haRVdnSFpIc05BbXNzcnk4c3JCbzZDTEs3ZUM1aUZZeDU0bi84?=
 =?utf-8?B?dXk2ZWluS3EvK2N6SVV4U0xSd0o4bFEwV21FbDh3bzMxVi9KTU12TVpEZDRN?=
 =?utf-8?B?eEpGZ3lrdVhmWEF3RjRKZm5wT1orb05QaVl1YmZTQUhhcnpaZ1dVajlLNmZX?=
 =?utf-8?B?VG8wSWdlckdkQWs2enE4R1ZCTGpxU1VGVVJtMW5SNnNZV3pac3ZmMnRDTlly?=
 =?utf-8?B?dlZHRUxiZFBnc250WDdIV0V0MTNRdXh1UDdmTXpMTFVPMFQ2bzhSWnBQOXRu?=
 =?utf-8?B?a21OQmdtSExvektTeWRXajRYWHU4dnZNcEo3em9hQWRHVnZxTW41ajNoSm0z?=
 =?utf-8?B?VnJQbngzcmtCTUZRSGkyOWNYdE11MjFXdmUrakxvSTlkdlFBRFJwMUxHRGJm?=
 =?utf-8?B?bkVrVUJWdzRub1lUZWdTU1JUWVNkMSt4VWo1bXNwOS8vRlRtRFlualNPcDE5?=
 =?utf-8?B?WldiUmVaRUZ3M29SQUFqNGpacGdGNGZZWlI2SWVPcUF4T2FpUmtmVHV2VW9O?=
 =?utf-8?B?Wm05SHlaMzRwNFR2bzA3blRMTXhsYWlrL0hmVzl6YlRuVW80RSt0RVpOSlpZ?=
 =?utf-8?B?endINkVuRjROWS9DakF4cnIxdDhCaGZYRWFsZDhsSEluZVZaZWw2MjhPQkdn?=
 =?utf-8?B?aWFIeXBsUEtPR2pDc0l2RjhBcXRQMkt2c0U5ZSs4aGZsZEg3WG94Z3FyTDRy?=
 =?utf-8?B?SEZpQStxNU5OUGhyS0Q0MEJwRG4yeEFwSGRlQnJOS0VMcVM1TW1tQjJQc2J0?=
 =?utf-8?B?cTVMMXVwMWlEbE1kbVgxTDJ5WnE2RHBJZG9XRytac2kwbWx5bTdYOHF0aU8x?=
 =?utf-8?B?b1g2bm8zdlZLYTA4cDZtNXRSQXdTdi9qemk4UDhKb2pkQ2gzQXJhYjRVMHpm?=
 =?utf-8?B?c2Z6ekxJY3BCZjdpZnptN3luaXhFbFJjUWdQZjlsK0tQb0NOTlRLRytYRGI4?=
 =?utf-8?B?bkpRVHllQ0VtMVV3eE5KMFkrVnNUTVh0SlRqT2N3MU45UnFNSURNM1dWbGlP?=
 =?utf-8?B?V2drcFFNVHQvM1M1a2ZsQ1FscmlDUkJsL0grM3p2RCtPSTVXUUtsMnhXNmkw?=
 =?utf-8?B?RjNxc29TanYzVlMvdjcwZVVlaGs3c3hjVjlxOVZJNEx5QkVMUXY2VmUwMlVX?=
 =?utf-8?B?L3FSRlhmOUY4YnZoTURWSkhSYzM3SE5wV09hT2p4OUNLb0ZLelFkeDRyWXRu?=
 =?utf-8?B?ZVBGelZQczRyK1doemxxK0dnRURjdTNsMWFQTDFwNUNzVzhOUWZQVXZVNm0w?=
 =?utf-8?B?NXdSRVkrRmRFZElMVzRleUwxbWh6c1JIWmxJWDltOEFUSTFLTHNqUjVyak9m?=
 =?utf-8?B?QTE2b0dzYmdidjZETjJSSjFZdHFac0txd3k3TmlmV2hHQlJkYmNSMmZ2cjBX?=
 =?utf-8?B?M1lqejFGdTMxUDhrdmYrTkZ0MjlXR0hUaWxXZHBUTGRnVCt5WmNOWVdHUXBW?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a355dc09-aca3-4385-953c-08dd71d11f6e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 10:28:35.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScUMA2IZpn7PZWiIQGeyFKLzW5iky4e5QLuBuCV/QATyDwgta12xoE4S4kf6OJWvMI8lwZ9uNH2nUSsrgnpIqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5237
X-OriginatorOrg: intel.com


On 01-04-2025 21:02, Anshuman Gupta wrote:
> Trade-off D3Cold target state based upon current vram usage.
> If vram usage is greater than vram_d3cold_threshold and GPU
> is VRSR capable target D3Cold state is D3Cold-VRSR
> otherwise target state is D3Cold-Off.
>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_pm.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index d4149a2eace7..5db9313ae269 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -148,6 +148,14 @@ static void xe_rpm_lockmap_release(const struct xe_device *xe)
>   			 &xe_pm_runtime_d3cold_map);
>   }
>   
> +static void xe_pm_suspend_prepare(struct xe_device *xe)
> +{
> +	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
> +		xe_pm_d3cold_allowed_toggle(xe);
> +	else
> +		xe->d3cold.target_state = XE_D3COLD_OFF;
> +}
> +
>   /**
>    * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
>    * @xe: xe device instance
> @@ -163,6 +171,8 @@ int xe_pm_suspend(struct xe_device *xe)
>   	drm_dbg(&xe->drm, "Suspending device\n");
>   	trace_xe_pm_suspend(xe, __builtin_return_address(0));
>   
> +	xe_pm_suspend_prepare(xe);
> +
>   	err = xe_pxp_pm_suspend(xe->pxp);
>   	if (err)
>   		goto err;
> @@ -927,10 +937,14 @@ void xe_pm_d3cold_target_state_toggle(struct xe_device *xe)
>   
>   	if (total_vram_used_mb < xe->d3cold.vram_threshold)
>   		xe->d3cold.target_state = XE_D3COLD_OFF;
> +	else if (xe->d3cold.vrsr_capable)
> +		xe->d3cold.target_state = XE_D3COLD_VRSR;
>   	else
>   		xe->d3cold.target_state = XE_D3HOT;
>   
>   	mutex_unlock(&xe->d3cold.lock);
> +
> +	drm_dbg(&xe->drm, "Xe d3cold target state %d\n", xe->d3cold.allowed);
the variable should be xe->d3cold.target_state
>   }
>   
>   /**

