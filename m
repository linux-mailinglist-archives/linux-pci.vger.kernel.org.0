Return-Path: <linux-pci+bounces-15664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFE49B7161
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 01:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44131F21F5D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 00:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76061EEE9;
	Thu, 31 Oct 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZaivwkF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440C28379;
	Thu, 31 Oct 2024 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730336019; cv=fail; b=cxKpmh6B09IulXhwuk4+BtEtYIh2evMQFICVZdbXFwEBE7KlzQ6lUX0mM7w5IuvjErZd3rU+gtGd/U7/DSzr+8iQ793U03elgsd6MFb4P5ojf1Oj3To995xzszHIsDaYktDD2TxetmZqUn1qJj2vw5FRcHfVDXyXHIbgOJakbcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730336019; c=relaxed/simple;
	bh=ZNsH9HurspWmoC9qPgQn0uTuAKDWPly56yJucXsKV3s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rIAUbL28NAWcmOktw2VVPNFR3EtVXsXLy9USzaOKUUadyntEZXCU0WBYO4VKkkMHV2GFOMocAd32tU0f2Wg+tF6iJu0BW06klsv1GC6tGghlwySvf9ACtTi+bb+MJF+gfEfanjEENOWiemfVboHqM6WJosoZvvGQ6jlK29yBsMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZaivwkF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730336017; x=1761872017;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZNsH9HurspWmoC9qPgQn0uTuAKDWPly56yJucXsKV3s=;
  b=LZaivwkFbyol+sOt4VWlkxo+4K+XqDltp7mvznwxFmog0D6LWvUsjVuo
   5fNlpllrBFrQKoKPdC/oGKZribSkjur7oT35CmtDEG7/vXbX6OjlAjdF3
   5t0HSN33vXZoN+7YoI6ScGY4GbJP67YRsOIKb/igM7JhuAKbanetxDu31
   6p7DW2gUkHi5uhCCMw0sdZaO4Cfe8jrJAnctBUamJsyt7sBvV1GgfHR5N
   tDHUsMCx5WJsRuYbzAHdmPE3WfzgDxL8gZW7Z20T4htE58+Wg8FgP03Tf
   t+kD/kKaTu8hvi9deJsB4c969DLdkZpHooSyBY1zmnV9hFqipl0CDahjB
   Q==;
X-CSE-ConnectionGUID: kTjJwAaPRcuR075n1lNzRg==
X-CSE-MsgGUID: bMoT46IHRauKnMtCA5buBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30167248"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="30167248"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 17:53:36 -0700
X-CSE-ConnectionGUID: tw0ko2J1Ry2r1R8CmKjOFw==
X-CSE-MsgGUID: Cj4R/CVgQJ66ljOJBNnWAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="82021572"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 17:53:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 17:53:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 17:53:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 17:53:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q971s0RA8u20NG/WMpOjk8FS2dbtsSvD+6QNmKIw3Y0T53j9mjczI2UaikVF8uidlvV9eHDKJibgDzD9MWfGEotCTOfLTtMnqRd7d/RD2+BRV4o/bGQEgp5VPrsuAimwVwRY+e4qvaXHUB1jP7B5pr9l9BbpqBF7Z7b51sAYHye1pFhzXUobP1cxHUTJrB1WN1fJqOQ0hp3E4+lCVU3LeBtV3XgBt7XviibPgYjqtNd57350UgnMwuh5eD/NHK6QP3uNMdSs7nV9nTasJgl9ABjLRV3MtXxPeB5L8A/P+Ik1630Ia/I8k1FFUXN/owWNR5Pp5TKaNdvM3EDYNUj7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ad8NIfOOBWNml+IwLRZ0xNYkZnp/gKxQxVLSTI2+Q8=;
 b=QaYtfheYQ40UZ3sRp9C+anxgbq2Q4paJrfmhWOep5Y2kEoccyI+T7wFqCWfFzaMzFa+cqwWK/T6btA+uOiUP3K8pww+8bBoYU2xPsJFGrcCJ3QlK+2ocBTneYOprK1LbnIoM2R5Z3TEFNHiaRP4lApmqgKzayut3TCZSi98h5cLX8zKGrn8NnOL3M6sf2/9UF9zns1K4MCl4AkmPtgEBt9Iaai/+PJEeCQk6RtTBqZJ6ELSYBlmqNyWaIoR+vFYAkcbvy3tNDL/TUQ0j9EFB+YVZmsGXSV8asW3rQYRDPb0hBTifvb/mZFTQNHXE4O6LFz1j3Y5dtJUmGDXYhERR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA0PR11MB7864.namprd11.prod.outlook.com (2603:10b6:208:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Thu, 31 Oct
 2024 00:53:32 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 00:53:32 +0000
Message-ID: <c2894e47-f902-4603-84e7-a9aca545b18c@intel.com>
Date: Wed, 30 Oct 2024 17:53:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] x86/amd_nb: Clean up early_is_amd_nb()
To: Yazen Ghannam <yazen.ghannam@amd.com>, "Luck, Tony" <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
CC: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "avadhut.naik@amd.com"
	<avadhut.naik@amd.com>, "john.allen@amd.com" <john.allen@amd.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "Shyam-sundar.S-k@amd.com"
	<Shyam-sundar.S-k@amd.com>, "richard.gong@amd.com" <richard.gong@amd.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "clemens@ladisch.de" <clemens@ladisch.de>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "naveenkrishna.chatradhi@amd.com"
	<naveenkrishna.chatradhi@amd.com>, "carlos.bilbao.osdev@gmail.com"
	<carlos.bilbao.osdev@gmail.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-4-yazen.ghannam@amd.com>
 <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local>
 <20241029143928.GA1011322@yaz-khff2.amd.com>
 <20241029150847.GLZyD6f-Hk6pRTEt2c@fat_crate.local>
 <SJ1PR11MB6083AA7B2E28F2DA24E4B456FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20241030142138.GA1304646@yaz-khff2.amd.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241030142138.GA1304646@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA0PR11MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 98638dfd-614a-4c0e-3726-08dcf946716f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWR4VE0wSnU4OEpEY0xvMldtcmVpZjYwdzVPa2tJZ3pJYllwVTd3TlZmVDVi?=
 =?utf-8?B?U2VkbkpPS1JSMVJPUHA1RVMrbHc1VmVLMFJBdm1BbUxKcU4yWERzQWhrV0Vr?=
 =?utf-8?B?a3oxT1VaZnd1U2E1T0htZk13QUNlVlY0Vm16Zmk5REkwdW1FRGFPelFMQ0pU?=
 =?utf-8?B?cGxJSy9QOWhiSnlZTVZjaXV4NG9ZeDFNM2VlajBXSXJsOS9YYkE0YVVJN2hk?=
 =?utf-8?B?SmxkOVByb0VrWm00MmNoZGxxYlowbThRZ3VuZTYxeGF2NEpwTjc4cWxPaVhE?=
 =?utf-8?B?Qm42Tmo0SkVYSEY1WUVGc2tZZkpXSkhLWTY0L3N6bFhKUWI4UUNBY2s4L3hq?=
 =?utf-8?B?bC92TXBEVmUrWVB3T1I0dnBkTVE5TGhPRjBIcWVZUk9XTTBSUlpTR1VGNlBT?=
 =?utf-8?B?cnphcmxDbnV4emxBTDM0WHhxWmJKVjVCSkZ1N1Y2VTNjOW5IZ3BwcThzZ1Fw?=
 =?utf-8?B?aXkzTjJkR0JLOE4xbVc4YnAyVkNmRUY2QVFhaTh6cWlHQjN5TERIY3FsVW54?=
 =?utf-8?B?UFNEU0hjRnV5Vkx0Sno1bmwwTVdQdGNrMTZFdTRzSUhjSitQVEp2R0dSWmR3?=
 =?utf-8?B?NUdzT0tSN0dVZUhOclkyQSt4ZVc2aDdaczlMQnRZeVVmNER6bExFNWxTME1w?=
 =?utf-8?B?L0xKWnZ3bVRPSFdCK3JuWW5RRnZneDZNZk1GTml1cWtlVlpPUDhIS2MxVXo1?=
 =?utf-8?B?YzJEUUdGUE5EYUx4bGtSb1VwYWo5VklCNC8zd25wWnA3bWkzNGhGUHhaSm9C?=
 =?utf-8?B?SDVDTjZSc1g0MDNLTFlKd3ZtVVRmMUllbkkzKy95SytxRzI1cEVoOUgwWXlU?=
 =?utf-8?B?dTM2Q01yY2tUWmwzY2RZbkV0THVlWmFtN3cycnVINXl0Q0trdktyNVhVdCs1?=
 =?utf-8?B?Zks2WkVILzh5U0NsbVVTeDVSeWZydnVvWW9yamhnOXEvTDQvUXV2Ukp1Y0pl?=
 =?utf-8?B?RlRUUWVOZmRSQzBCbVZEeGQrTVpMUjE0UTd6WVFmWGcwNHFpdHlmQyt3ZmFn?=
 =?utf-8?B?WWhEZEp1TEJHWnZNejNoUE9TZzNMdkJCWFZ6ZDFtWTZDazFqUmg0LzdTTWV0?=
 =?utf-8?B?cnBlbWpvckZxeVd3RVg4YkZ3M2JjOTl0MlRseVNlaHpuV2pMckF0cG8wTjk1?=
 =?utf-8?B?RXFIVUsxNWVmZGh1WUV3YXJlQm0xUnBTZWVyMEdYbWNxU0V4OUJvclovRXh1?=
 =?utf-8?B?K0FKRnZWd3YzT05qRDJYNmJKS0xhQWx1ZVQzUnlVVFBDNWRHaDZhYVBPa2NR?=
 =?utf-8?B?YUF6SVdIdGE4WjROdTRxaVFIUnEwL1p6M1Fqa00xaWNlR3VSbkJkd3FtYnUv?=
 =?utf-8?B?Rk9DUDMxN2k3Rm04cWZtU0ZoVXdmSmJwMkMxRXVvck9EcEtLMHdxMmJCekNO?=
 =?utf-8?B?a203RUt6U2ZnZkoxRnQzTlBkbWNqYWRGeFFPWlZVWTdqb2RpQ0E3Wm1oam0v?=
 =?utf-8?B?UXhtRFJSc0pLYWxOanVEZFJlL3JrcDI2bHQ2N3Z6NFNTUHcxZEc1Rk03K3dk?=
 =?utf-8?B?cWd0OGZjaUZQRXl5aDNtUmxBM0hrYS9uaUlpbEVjSDFjU2FsMk5Sb3hHYW0v?=
 =?utf-8?B?MWI1K1Z4T3hrVTJEVm16aHlBRTdUMDljYmxUaFFSOGs5Q0xoV1pyUERROU9V?=
 =?utf-8?B?SDk0anNqY2NSejlXbDNTRlFibmdsbjRYbTY3bHloNzh3Y1BhZVp2WjB2RXBH?=
 =?utf-8?B?NzlPd0hSZmh3ckpiaHYxZVFpdERNQzR1ckFsVCtOb2U5STVFRmJMS1ErVFdF?=
 =?utf-8?Q?pv9TN0eLOkM0MPlzPSKKzHK8+2AkdmoVFTrTbGG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWYrVlJDc3hrTTArUkNXVE42UjBmdjRYOXMra3ZmZVNYQWxnRVZEWHdzbTk4?=
 =?utf-8?B?RGp5N0dvM2tLU0kzSWJkVFRJVGNGOW11K1VvckFGU0NkSFpjOXordXRvdlB2?=
 =?utf-8?B?SGVnUXYrWHVUR2VpMVgzOHNQU3pGclBlNzFzMDZmeDdKN1F6TWtoRThLOHJT?=
 =?utf-8?B?ekdKMkZZNmRyd1FsY3ZtT2lSWDg0OUhMTTZ4WXgwQ3RYR1lsTXVicDlkL3B6?=
 =?utf-8?B?cGlDNElLOE9oZ3o5anZDZHF0azlES1B1RlJLS2JJeU9YWWh1cTVXWlNIZlQ4?=
 =?utf-8?B?dVVrb0ZicUpaMGdSOWVaYlVCN1MrdkllNXJiZ0NBNEZGOFduWUdCK2lPMFJT?=
 =?utf-8?B?V01LSEdrVmsyNmgxMjFzcmkrNGdNZFBnSEJUTXVpZENvYmw0YmdsZ2VreXd5?=
 =?utf-8?B?a3IvdHo1KzJMbEs4NXh4UlFHTHRjOGhsTWdDUlZKWUxkdzFqZjV0b3d0VGh6?=
 =?utf-8?B?M083TVJZelAzcE10Q0FPT2NDSEtzb2JRT2lTRzVBVGZBWUYvRUx4OHRCVVBG?=
 =?utf-8?B?eDlTZmdMeVRlSldsS3BRNzAvM0pJSWpPS2c5QVZwYnRTUCtpc3BQZTFDaDJh?=
 =?utf-8?B?UzlidDZXNmpXZXVPRXJnMGJlSE55V2laZkdLcFpRK08vRmNMQ0hTMXpsRWZX?=
 =?utf-8?B?b0VVblVwUzZUd1lzZEpmWTQ3dTBTejVrN0lZUUdFNjI2S3FBVm1aRUpEc0VZ?=
 =?utf-8?B?VVQ0V2hZK2tKRUpucnkzSmVFZ1pQQXZUTmVPenN1M2FMT290djE1SGdiVis0?=
 =?utf-8?B?ZURlY2FOdlBxVFVCcmZIRVBTQzBCZU5jNjloMkV3Y2ZtQnZyeVdiSDlMVTg4?=
 =?utf-8?B?WXZaSzRWeS9FbE9kT3QvaDVkMTBkQi90aHREQVd0ZWhrWk94SjltWVRHNG5Z?=
 =?utf-8?B?L2N6a0ttSUZsODJNekxTMGgxcDlCQVVNSVVuTm9JT0hzQXJBQTdweUU3eUJh?=
 =?utf-8?B?NXZOUHdJZUFGQm05U21adFZQMzVyd0JrdmpFbW1OYncwTlB1dWJUTG81SVJ4?=
 =?utf-8?B?aE5CbnhCRWZoaUlDQzlsRWwrK1lRSUlMbFhRejFmWnhKK3BEb0J6OHlwVCtv?=
 =?utf-8?B?MldTWFFLV2J0Z1dWQ3NpTHhHVUtzQzM3eWRnWUtyRWR1dW82N3JQUVJhRHJr?=
 =?utf-8?B?TmVnaUhyQUlFY05oMGVPV2tCWE13WnExSWk2b1FMNHNwb0tlOTd1ZFNjMWtJ?=
 =?utf-8?B?cmpiREdDMXg5ZkxBNUFaeXZtQ2hjdGxKaXpxTStLZlA0WjZwZzVIdXZwSGFs?=
 =?utf-8?B?bXhxOFFjUkZERmxDaTVwREZYSExUVjdaOXZ2RDlwR0RGRXpSaUtCNHlUdDFj?=
 =?utf-8?B?Q3dvemsyQkRDcjFTTUZHR0Q1NXByM1RIaTVUbWhWMHpWMGF3d0RMMFVLdGxv?=
 =?utf-8?B?MGc3TkpxRklZZEFrMjV1b2FPNUE5SlA2RWUwbGRqTE5YbWxRa3p6cm9pNlVw?=
 =?utf-8?B?RHFpSWpNNUNKd2JkY255UzZrNFg3enl4L3I3cFhyTVY3bGFHc3BhanVhWTJB?=
 =?utf-8?B?dzdYVmtYcURUVmJpSFViWndsT1k5ZU9CcHpvWkFXaDNabzFVMit0RytyeEVG?=
 =?utf-8?B?RDJiRTUxcCt5UEtKa3JlOFJxeDNHT0VlY3c3R3lnSkROaDJaRWJ3NGZXd2NK?=
 =?utf-8?B?aTlQd1hFQXNsc3lGUnBrNzdOeENCdVp0RFB3MEVPMzU0ZTczaGo1c0lZNm4y?=
 =?utf-8?B?eHZpL2J6Y3U3TWhnMlBlTmVYdm8rZWVxL0J6Ym5ZTTNSQ215S09zd0JCSngy?=
 =?utf-8?B?aURXbU5aelZ5ZHlLdjdnVW95dzNLZVRxcFcvM1cvbmY3elhueTNqZFZ0L2U5?=
 =?utf-8?B?bVdKd0F5RDEwSGRJMkJlU1EwOU5RRGgyM1NCeTVtK0Y3MkpINGhJZzB2RDhj?=
 =?utf-8?B?cTFxQml6dDk1RkVHK3gxUFdvMG9VUkgraDVXNVdWQ21FMmhBNldVakNWb0I2?=
 =?utf-8?B?VVJPdkVmZHVqYnY0OXV3TFc1N0ZvbGlaQ0k4RGpwa3NScHZVNS8zc1F4Q25Q?=
 =?utf-8?B?dGEraVlpa2JFZHVIR3VUMVZ4cVdrOEVuTnBLR0orL2tWazlFRE5GN2p2WGJG?=
 =?utf-8?B?cEdkUzFycFh3UHF5VVdMOUh1NnNZMUVJWG1Pblg2TUlhOXBHRERFOEFhYVZz?=
 =?utf-8?Q?smolNCHmExITAKAq61Bx1njgz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98638dfd-614a-4c0e-3726-08dcf946716f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 00:53:32.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBOmShD7wXgeteMuw+weC3cjxfSIfGwF5DQm4naUsNMU9vXVXT+Tv/CAun5AWYK6pJgM2oH2DZRT4vu0PCdpIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7864
X-OriginatorOrg: intel.com


> On Tue, Oct 29, 2024 at 04:15:33PM +0000, Luck, Tony wrote:
>>>>>> -       if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>>>>>> -               misc_ids = hygon_nb_misc_ids;
>>>>>> +       if (boot_cpu_has(X86_FEATURE_ZEN))
>>>>>
>>>>> check_for_deprecated_apis: WARNING: arch/x86/kernel/amd_nb.c:395: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.
>>>>


Do the comments in cpufeature.h need updating? It seems to recommend
boot_cpu_has() in most cases and suggests using static_cpu_has() (which
is used by cpu_feature_enabled()) only in fast paths.


/*
 * Static testing of CPU features. Used the same as boot_cpu_has(). It
 * statically patches the target code for additional performance. Use
 * static_cpu_has() only in fast paths, where every cycle counts. Which
 * means that the boot_cpu_has() variant is already fast enough for the
 * majority of cases and you should stick to using it as it is generally
 * only two instructions: a RIP-relative MOV and a TEST.
 *
 ...

 */
static __always_inline bool _static_cpu_has(u16 bit)


> 
> And if not to checkpatch, then maybe it can be included in the TIP
> maintainers' handbook? That is, if others are using it or something
> similar.
> 



