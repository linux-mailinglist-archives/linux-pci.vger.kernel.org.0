Return-Path: <linux-pci+bounces-18674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E29F603F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 09:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3916188927F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 08:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB733189B9F;
	Wed, 18 Dec 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfWr9zTg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF726165F18;
	Wed, 18 Dec 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511050; cv=fail; b=LlgBJ7zAgtZYL0VWwma1POuYX02EK1/MZAdA+H9PLqszp564R99UAWJ0wSI6MPWD0jFyTFdYEextEIoYpoE5NYDF0KHZx0gx8UWaZMGNwQ1nSm02RyDDmPGoQm4P2UKWunUTDNN65Vy/BFJ8/mtvPJlC406wY4H+KtDmjlCLet8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511050; c=relaxed/simple;
	bh=s6kYcpTi43DPf2oBjT/tq7aT5JwTh7ByaJT1imn+0Ko=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rHvbYhG3LxKDTFyzPfHfGa4sxPxK0Z6hVum8gmZc1dvptNEIv7RoE4+KxpyIHe2au88ReLbw73SXa7RKtONfWyM4IJRQbUJ3utqKDlT+oLyP714fdXldd1hz9WiJXnxzNcv9XCUs4hBD8123y6t68qgmnZ61K8Wr8IECXTHb7gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfWr9zTg; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734511049; x=1766047049;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s6kYcpTi43DPf2oBjT/tq7aT5JwTh7ByaJT1imn+0Ko=;
  b=FfWr9zTgxb/6u3HUNWt0vx/zGcPun8TJK5qjtxwivQOCFw1B8ZM97ciX
   gzgc+QtSSIvtatLSs0RAOduryFvLi0sH6fDSn7O75ndjzdJ9vXQ6EhfjI
   zQ81cuCOoBjoJnP8YSCt6S5b2v4dGBIFFvsgdUSCDgdFkBwltezu+rHDe
   jQBp5GtP5xh6p79A78qzh+8Xrqqtxkwyf1OFXklLP20WsluPrUi7Est/r
   hRz9jm99+rFXNOrNs6CF+5SoqbkXg5DjiMZu7b2DcdcAJunAB3LYrdo6v
   IauPzEXuYD5oP8JImfpYoonHbRi+UVu4jRbSwRff0MwvQrey5RimMgnmM
   g==;
X-CSE-ConnectionGUID: h7Zn4G6STqaZ7dkiPrT8xw==
X-CSE-MsgGUID: f1d4ykI4QKKZb+cXp5WCCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34304484"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="34304484"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 00:37:28 -0800
X-CSE-ConnectionGUID: +z1trfFlQamuv898Z+b0mQ==
X-CSE-MsgGUID: nA552VkyQEisKwTKgCVjZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="97699515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 00:37:28 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 00:37:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 00:37:27 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 00:37:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JN1HXtxShzaJcWvH3dT5Lp0oNwEEeO9AyP1vafH8g9dhAH2gEYP8bWlmfY/l6C0pHHFWV62tEcGA5kCLj7J+lL54ZZG4LH8dww7Fsqp2ADZP8RDRvbYvEbsMm1ee6Pyzb6rQciJ1fBPWE1d6hSqFl/hdcXJxj1p6XiSjbOHA3Ze6OK6MunNKg/5oTM+CIS2P9p6uQmAgQ9RFo2V2FhI9USur8NbchpbjkojSYYalfK0W+MUZWMU6/FGYTZf88u28+ApqgQjH7lE90l6i9bONLNTfvk8zP/UrSUNf9YfZaKG0DsONdx6GUM2K3g2+gswwTAlZVjz2378l4jDibpmucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR9ljUtVlppuKRINQ8Tye0EdpdCF9XsJuIo7/olrliA=;
 b=iBAsgRxFqZ9AMAcFsWLZxoK7caI6CMEbBGYmxvlboiUW53Rf8gp034qYzz00GmcZgkOLJ1+M3HMFbL3j3rwwt9c5H/PnKVT9fPEsee53H7Lw5MdGIwCJaCDhuqGV3fRf8n//JyeQzTVN6xiuy6kigbnNpgGhGoCaBMqYtTkrLbEkgcP2Fl4lzYCovkxjDIdz9Mb0rbEBeHDRvA+PFkQQWIEuq7cvZ1MQOcdfmi4KEMEXv8sw2x/IdopFyzbqh9Caz0ua2KedjnBJDO2Hpsq6AwtdZ99+IKSzxtgKX20d9vwp20QlEW5rkuqaQygPJLCmdF6Sf+TEp/GkqjrinbzlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY5PR11MB6188.namprd11.prod.outlook.com (2603:10b6:930:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 08:36:30 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 08:36:30 +0000
Message-ID: <57948d32-bd6f-473c-a7e6-90185ea41986@intel.com>
Date: Wed, 18 Dec 2024 09:36:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3] e1000e: Fix real-time violations on link up
To: Gerhard Engleder <gerhard@engleder-embedded.com>, "Lifshits, Vitaly"
	<vitaly.lifshits@intel.com>
CC: <anthony.l.nguyen@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <kuba@kernel.org>, <linux-pci@vger.kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <bhelgaas@google.com>,
	<pmenzel@molgen.mpg.de>, Gerhard Engleder <eg@keba.com>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>
References: <20241214191623.7256-1-gerhard@engleder-embedded.com>
 <231abdb7-3b16-4c3c-be17-5d0e6a556f28@intel.com>
 <047738af-69af-49aa-ae91-7dbca40ae559@engleder-embedded.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <047738af-69af-49aa-ae91-7dbca40ae559@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY5PR11MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 26dbec6a-f609-4d37-6645-08dd1f3f11ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVNUQ3BxTk1vNEtLbWdoVzE3TjJXS21LbHVjbDVNT3VLRGFpQW9hWjAvWlY5?=
 =?utf-8?B?bzZnWUVJNzdJSUNadTVpVmxNRzQ3alF4N3VuRlZ3M2RGd3huUjZBYkFoWmxE?=
 =?utf-8?B?aDFnT3NMNTR5OTY3SXlWdk1IaTk5ZVl4NW9VUzNDc0lNNWdPd0tOS0c0TEZP?=
 =?utf-8?B?MnhsVHVhTWZQa2JLL3FNWDRiS2tuVFZSU3NQZzlmdUJlLzdDMmNRbzRkNTYy?=
 =?utf-8?B?RmQ1dGZPeDFxRmhac0lrV21MZk4zVXpsbXdFaWFBM3lpR3lqTCtyM3BnblVs?=
 =?utf-8?B?bVVTNTRRdWlMYlRTVVE2eENJTVNTeEhGV2d5RmNYSmpnTDV0ZWkwa0hPbW9q?=
 =?utf-8?B?T1NOczRXSFE3RFNEemg0aEx2NTRNOWRMQk9nUnQ4OUZrdExyM1h4eVErVlVJ?=
 =?utf-8?B?NS9rVGhXVCtESFkwRGFybDJrcVRLeGJkWkQ1akk2R1pzeThmYWZkMm5ZYk1j?=
 =?utf-8?B?dTFleTNRK2dVbnVzcEFXamIwMUM3d05venEyaEhpblBaWG5CQ2dFVHZULzVl?=
 =?utf-8?B?OEs2NXlkRStmcFZMcGZSWUx6MEVadFZJckZqS0NMR010RTRuZ1E3eHk1b281?=
 =?utf-8?B?ZC94TUM2RVVRdmtOSzh5Q0NqMnI0amZRQmU2Njl6VzZ6V3l2YS9hdE55c1pz?=
 =?utf-8?B?Y1N4ZmkzK1Q0V1RIRGhyZksvQmtDZHo3YlV3eWkyYWh5K203RzV1elFUUTB5?=
 =?utf-8?B?ckNmY0NROEJmQ0R1KzlJbGNVTjFqY2hjSE5xbmJSZzRKNGFVeEFFV3Mxa3ho?=
 =?utf-8?B?QXhvYjZOcmJRZnhpMWw5VGtIclNTRFJBUGhRcGdSMFVyZ0QrSUtYeXplalJH?=
 =?utf-8?B?VTFsM3JhMWZNSy9oNzd6bFdocHJHMytZSGVWa0pMNnZDZ0pudkE5UE9hNDJS?=
 =?utf-8?B?YWdGdklTRUJENERYUFJNdzd4eHZWblRHNHFNRHByc2xva25nN1B1SFRibUQ5?=
 =?utf-8?B?K2NvMUNla2pvWDZiLzRjZVl6VFJaVHlBU2ZOUDlka2R1Tk5KSW1uR2Z2QWxq?=
 =?utf-8?B?WkpWR0Y2VUJxMjZUVW91S1hWYmJHa2xCYXRpTDNEaEIwamxFOGlsMmduZE5L?=
 =?utf-8?B?UU1XN2lxdFVrUWYzaTZObld5RTF5aHoybWpIcERYdjZaQlprWjRURU5ucm8r?=
 =?utf-8?B?R281cFpDS0NGbHZXbkxuSys2VTdTd2Z2SWdtbVNhLy9UZ0l2NE1iVGRsZ0FK?=
 =?utf-8?B?UktYYkJkeDVURWt4VmxqeFlaQTJ6VytuMDlZaWUwZHVSdmk2dkEzbmNObUFt?=
 =?utf-8?B?dlFjbmdsWkFGdC81OXF5M2VZdmN0Tk1UMmwxcjRvWVRBNUprRUlzeFlWYlMr?=
 =?utf-8?B?blVyT0tVeFUvQ2pWeEVvYm5RbGFwdTdhb3VHUzZWU3JGY0JaZ0VOR3lQUmtv?=
 =?utf-8?B?L2Q3TXErdUY2akRzSTdqTmlqT1FPdFFHK1JRa2M1QUFKYWZCRmZyeklTWEsr?=
 =?utf-8?B?NDlqS1ZyOU44bTdqNTZ5NW1BeTBka1JmaElpNFRtSjBVRGdYendrU2Vnei9G?=
 =?utf-8?B?NG9zT0p3eTRyczFMa1daVkFadC9aOFduMGVoamJpZGtzdDVpN2dGcFVIOGtn?=
 =?utf-8?B?NFk2SS91VGVYZXBUTTA3S1pOOEhLSzRqVmVKbHZ1YXF2aFZTYXJoZnc5UXFk?=
 =?utf-8?B?Vm9ZUHExcDA3Q0NIOWlkZzlwdHdoQkFmTVN2MXcxckFUekFxMVh2N3cwWldp?=
 =?utf-8?B?VnpGdStRbG5kWFV2TGRvajN5L2VOSVBaQ2IyWDhkbDlxZnprQXh1ZVlnemY2?=
 =?utf-8?B?NWczM2N2L3RyR3pqRG9pQlpPaDIweDhXQ1crZW4vaWU4LzlxaDd3c2V5b2Nv?=
 =?utf-8?B?bnpRaGY4bXFXaThkOS9ScFdhMSsrTDdzV0ZaSk5ZRWZjdHJETWRDUlZFVTRB?=
 =?utf-8?Q?L1MHjxZMLUZvy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aitTc2J5eCs5OFJvZHV0TVVKZ0ZKVXZTZ0Rmc1VZUkZEV0JkTXlnM2RYOTNH?=
 =?utf-8?B?WW9taTJySzhZYUVDb1FlQzNsbnFLdmxYRGV2Y3pjUDNHT0V2NVpyOEczTk54?=
 =?utf-8?B?cTFwWit1SUF3UDFxYkwwbGUzejIvTXRlMDJJcGNmNkptaWZKQnR2VGoxUU5F?=
 =?utf-8?B?ZVpsMkJsQW9UNWI4MGozcmpHdyswRFRxVDBpc0s2eTF0N1d5UkthemE1aUg2?=
 =?utf-8?B?QnFmeTlDa3VacEgrYkhVWnIxSFFpamtuTGsyTlNha1JSQ3IxR0tpMmUrRnh5?=
 =?utf-8?B?Mm91enNXRnJId2p5TjJkS2JjTURLdU1WVEhQZnlaNmprVUp6VHQ0M1haWENt?=
 =?utf-8?B?L3MwOEJuQ2h1WUhHellaRGdrdGdXUnFNL2FlVWw1ekZNZmN2eHo0bnBrdnBH?=
 =?utf-8?B?clRqMms0Y0JIWW1KVUt1K1RjMjRzZzBpREhkdFo1OFdLU1lWOHpyL1ZFWndC?=
 =?utf-8?B?UFMydCtocnVjSjFLckJ4Y1RCZC91L3RnVnZVYWdqL2l0Q21MeXhJOGFKWkdj?=
 =?utf-8?B?T0Q0WmZjSmV3VU9pOGZNTU40N0FkSzZlZkgvczVBRGxXSVZKeW5DOURPUUFQ?=
 =?utf-8?B?QXJ1VHY4ZjdrYkFlakNGcWRqRW5ZTG9xUlNNVmQ5cUhaRTlvSjRLSFJETEtE?=
 =?utf-8?B?NFBibDNIdEp3NWVoaXJXVVNKTjRicUp2a1g2YW1rVEc4ZmQ0dzhwbGlWcWlG?=
 =?utf-8?B?Wm92TFJYRzNkZVN1cDFpSk5pUEwrcHNmQkZCaWJuOTZvUXRwNHFUdWQvbTc1?=
 =?utf-8?B?V0tmVHRMZUNCL24yUUp6NGQzblM1a1dlM2N6bjA0QW93bFA5a1VnNTVzbTJS?=
 =?utf-8?B?Wm9EMExWY0crWnNXdnFyTWY1TGNqSkFETERKOGNMUzA5QlVjc2RoVjI4Wmkw?=
 =?utf-8?B?MkZldWdOQ3RBMVpBZkZOQUdBWFZabHZTVkpVZWZad2xOaER1SmhQMU44YUJx?=
 =?utf-8?B?V0F4SEpMWU9iVE9vNFlSL1JQeUxVazBvNnRTd3g2TEljd0VEZFFIVEpwOW56?=
 =?utf-8?B?VWNmdnVFL1hrcFNrVGR3S1dRT3VQSWNxbElYNk5yVVRETHRmd0Z4akcrbzc4?=
 =?utf-8?B?SnZsdHJ6ZmxobVVCdStIY0g4Tk1hMWJaKzdTSkNjYnJlN0ZRN0cxYlJTR25K?=
 =?utf-8?B?bVBEYnV0aE0xSGU4YjducmJkd1VoS29abEZoS0pnSUVzZkVuMUtlTnFMYi9x?=
 =?utf-8?B?QXpONWFwWlBzd2VSOThIQldlYjBHbHhOZVJoeXgyUHI4WnA2eE8raTV2NEg2?=
 =?utf-8?B?NE05dmxMY1lKWU1XWk5RcndPaWJVQVJBLzArWVN4YXcyUHp5S0t5MUI2THFm?=
 =?utf-8?B?bnFqYTBMWFZFclJXTGp3U2ZsUzdDeGhxM2x6eUdOWFY2NWhsYk13amt5eW5u?=
 =?utf-8?B?dHhhaFp2ajNqRWhGUmdCeWF5N3p3elJIZ1hRUjBBNzRMSldXQ0psYnZybVBy?=
 =?utf-8?B?UkxmUWp4akcrQ2NyTkJ5M2YvamwvUUFiWGh6OVZMUXdYZG04enVFcWROc2tN?=
 =?utf-8?B?N2htNmMxQTFzNWhBS254R2FXRDIzUDZ5QzZzVGpKRnI5Y3d2aTg1ZVR4ZGZy?=
 =?utf-8?B?NWhsNHdRMDNmZUg0Y2o4YWNTYjQ1U1RnWUlTdnN1VmdveWRaRzE2K1ZSK0xm?=
 =?utf-8?B?czQyUHNWQ1F6UzduQnIySTlpNUpqYXFPS3p2d08wV3B2bG5sWFdSZVFpMEM2?=
 =?utf-8?B?dUFxendtVlhxK3ltSDhGQTlLblF2ZStPemJacHFTZ0dFQTlyL0NFd0NWRU93?=
 =?utf-8?B?VEFQaUtCQnROaHYyNE5oenpVVkFVWnk0R1NvM3hBT2U0Z0xZYyt0V2s1Qm4r?=
 =?utf-8?B?WkNHcFU5ZkxpS28yblcyanNUVE9yMk9HS1pIMjlocHJaU21LZXVnZTVXQkd1?=
 =?utf-8?B?YjZQb1ZoMXJaWmNoWWp5VHBLSmxRN3dxNGp3SmpoL2MwanJvQ0QvVHhWczNy?=
 =?utf-8?B?dEYvNUVSajBCang0cFlySmFXL25MQzUyY2RoYUVwL1kwUUFGTWVaUDI1S2xO?=
 =?utf-8?B?YTVsbFJVcE1SdmZDNit0UHkraEJsKzR1RWpyTCt0NXliVnlPVkl2TlZFaURj?=
 =?utf-8?B?WHAyTUVpTWZFc1JLb013aFZWaVBTOFkvMnQ0dG0xcC9Wci94Z3FZamp0bktr?=
 =?utf-8?B?THhyMjNReEFCZ3NCc2pRMDFXeWo2cmpRN2Z0VVhBeVZJRFE1cUtLRkJibXVi?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dbec6a-f609-4d37-6645-08dd1f3f11ca
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 08:36:29.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myGvCov4kuFpFcLao6nDkn5ECBWRAu5JwgNR9qEK2OQH2cxQ6wbensDpm44nyWLOcEPMuljJ5PGIw+SsFmUD/WgyNePTQYo9Buz2129mIJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6188
X-OriginatorOrg: intel.com

On 12/16/24 20:23, Gerhard Engleder wrote:
>>> @@ -331,8 +331,15 @@ void e1000e_update_mc_addr_list_generic(struct 
>>> e1000_hw *hw,
>>>       }
>>>       /* replace the entire MTA table */
>>> -    for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
>>> +    for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>>>           E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw- 
>>> >mac.mta_shadow[i]);
>>> +
>>> +        /* do not queue up too many posted writes to prevent increased
>>> +         * latency for other devices on the interconnect
>>> +         */
>>> +        if ((i % 8) == 0 && i != 0)
>>> +            e1e_flush();
>>
>>
>> I would prefer to avoid adding this code to all devices, particularly 
>> those that don't operate on real-time systems. Implementing this code 
>> will introduce three additional MMIO transactions which will increase 
>> the driver start time in various flows (up, probe, etc.).
>>
>> Is there a specific reason not to use if 
>> (IS_ENABLED(CONFIG_PREEMPT_RT)) as Andrew initially suggested?
> 
> Andrew made two suggestions: IS_ENABLED(CONFIG_PREEMPT_RT) which I used
> in the first version after the RFC. And he suggested to check for a
> compromise between RT and none RT performance, as some distros might
> enable PREEMPT_RT in the future.
> Przemek suggested to remove the PREEMPT_RT check as "this change sounds
> reasonable also for the standard kernel" after the first version with
> IS_ENABLED(CONFIG_PREEMPT_RT).
> 
> I used the PREEMPT_RT dependency to limit effects to real-time systems,
> to not make none real-time systems slower. But I could also follow the
> reasoning of Andrew and Przemek. With that said, I have no problem to
> add IS_ENABLED(CONFIG_PREEMPT_RT) again.
> 
> Gerhard

I'm also fine with limiting the change to RT kernels.

