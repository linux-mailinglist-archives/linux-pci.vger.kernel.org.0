Return-Path: <linux-pci+bounces-28575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06630AC7973
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 09:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ED017321D
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 07:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AAE256C7F;
	Thu, 29 May 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBR/qrYC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575CEC8EB;
	Thu, 29 May 2025 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502709; cv=fail; b=SWE9EloGI9cS9BiGSL+kQNzg3np7LR8Sdyny3zzcTPPC3n30cdRHHuwF3+KuU+3f7jHeV2TJ+Cbh/7BrJwjdPxXcVmrfsYfzQLdCHoeirb5r5tPLScqtBym/nRxVjGSoXgOutKR+kwVEYmtzZ93KXQoXp0xUl6NHyn2dw3hqYCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502709; c=relaxed/simple;
	bh=VfpvQ6emcpDO7ILl18A/qmzbfs6+f39GyaSh1UqTE+M=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKuLNTZx7mrdpYtbMhrAyxkEsXw+bHG4tURc1raosuH90u37AbB2YfmX7JXkr6otLWnNG2men5D0yA6BEFY1G1Ys/sDXg4kKuBtxMiDMRcr1klVhtW1Iur28mX/9KssJubApph3iHsSCLT2qP9p5tg/i9sl/NXk1Nc32af/nBTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBR/qrYC; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748502707; x=1780038707;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VfpvQ6emcpDO7ILl18A/qmzbfs6+f39GyaSh1UqTE+M=;
  b=fBR/qrYCbAicJr2YfMH0mCf7C7lBwo6l9AuU0ugRDE4HFrrJ8iNVJZFb
   3re/KEzLW1pya+A2f9kabiyu6jEvpdTxny8eLmG1sHV89fL59M6KdLRrh
   sX8pdhMpFFG8cgO+2iw4f4Wd3hgLv85A23ZtgHfUj4ayOsp0RvLeFcOSc
   rlUbe/JgPzd32iQwfHLxYgr1pKzxU4hsxw4RLPfzuAJQpeQBZUi5zlqYz
   g3KgenUvyQcvnNZgnqMj/QleF7deo22TAiaQnIBU0/HGTgJ8nH9CPI8it
   O0aZBdBAkP+ctqC3TeH75i2KSUV9iMX2HId8rcM2DL1jkY6d5U//JHKxx
   Q==;
X-CSE-ConnectionGUID: q1td3EAtRjKE1FswnyKUEw==
X-CSE-MsgGUID: B/iE7Um7Qs238LFuM3Pcmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50476644"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="50476644"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 00:11:20 -0700
X-CSE-ConnectionGUID: wrPkyp2wTge6R3IphScr9w==
X-CSE-MsgGUID: BmwXDZjrTM6QlugztMWipA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="180676539"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 00:11:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 00:11:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 00:11:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.50) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 00:11:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGdupfpn9LnDNmwt2o/cxMCnGrBTTpxdxj7cliTLq3hkrZ1r5dvIuqjcbcXKxbrUWhSRZ6plJMs/QkkUxWjJuC0dzhGK4TzIqnHfe/WpPjAU9oXc+3Pd8ZYk3jw4xitqJ7kACLsRIuiMLe7kGzj9/WEE/WGSYfPEuo8FTlPdEkwEk3bk6wMpkwnKscclqvjWEaVa/Vba+/4hTjaLq3Mpxj85OVh3H2Jw29Id24aksfQW5yp6eG8kiU3nnl13+w7VNlJ5yjVQJF6g0NNNtCtNagPoayt8CFlxLsu1nrsSABcTmSc0PukrXJ/sTPtw80gd5QA4zuwiaHCQLo8AmJAAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM11LU6AmK23ZixCXOIYb/Nfn30nvRAZoVUpUcZ1df8=;
 b=tTvKAkaMSX9Fm9nN7D5MK3SmCyfl/glaJL4chP5L/xuJ/O1a25Xh4i01CHUFgY6clepZZnbkGpEHKVb/EzIBOQBpDV6w2BHh676GJ9mbZaGXTymRaG0Knd6MeY7res+g/T7FcaSwRsb1gLKY8b78WLy/e34dn5Ui1OtVZGUf7uNgWBTdfZ8izLPcTDpwE4WnZ20NGh8SteDQQwB4rMDuZncG8yV/DuDF9dJ9Bwy6/XfFQEw3bDq21C1Rp1rxoBS7/LaiVgXPlgGoZZtf32FG7UXGN/A5vfOdWsLuMzkCgKJw4FasjAIEGSPHRXFe5d+VggM3HOxk0KYBt8eXVN2Q0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 07:11:17 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 07:11:17 +0000
Message-ID: <d73fdbbf-699d-48cf-948f-f8cf678ce165@intel.com>
Date: Thu, 29 May 2025 12:41:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
From: "Nilawar, Badal" <badal.nilawar@intel.com>
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
 <b5a54c14-a6b2-4a91-9618-c03cc4e775ed@intel.com>
Content-Language: en-US
In-Reply-To: <b5a54c14-a6b2-4a91-9618-c03cc4e775ed@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::21) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|SJ2PR11MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e47083-d8a8-4fa1-52de-08dd9e800112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHBDbjY0cE9SbmtVNWdLdkNtYk5FcEJtV25NV1Vsazh1QmxwSDl4NGJMRnpM?=
 =?utf-8?B?RTM5WGg4enNFQ1FvZ1pmRlY2bWFwNFhkRzFSeStBUE5FYzZmVndreFdQcmVh?=
 =?utf-8?B?bVArZWJWSTZPVURJcGozeVBab3dSL2JTZjhKeGFxdzVtMmVYZllsUy9wdEtS?=
 =?utf-8?B?TVNkVGJyQ0padzFrbVBTYWl6bkliWFNYRUg3TUpZSE1hVXg0Z1NQTmxja0ZG?=
 =?utf-8?B?Q2xqNXY4b3h3MHFHVGJqK2hyZUhDbEJITWJmK1Q1Y1BtNWgwdURGaU44OHJ6?=
 =?utf-8?B?N04xcVVkSzlYRGM5bnhLUTVUZnVyWlIrWlNQOW5WK1k2TXhOQURYUTVOU2JM?=
 =?utf-8?B?eVdWSjRKcXl5bFZoR3hZUFUzaXpmREZxb3gzWDJqdDZFQ0hiQmpnSnQ0Y1Rw?=
 =?utf-8?B?M2g1N0VxcXpOanNtSS9rU0NzOG4xaFU2L20yY0xEbGZFTEt5OEd1N0lmUW8x?=
 =?utf-8?B?VFdGSElUenRSSnk5SHhHT2J3VzlxVGJYMzE4RCt0Vlc3TGZyYXRBUTBvTTlE?=
 =?utf-8?B?YVE4eDJReWNXRUhQb3poL3ZTVUR0K1BvRTNuTUZPc0RrU1VEZ2dBYlVaVm5w?=
 =?utf-8?B?OEhySmFYcHd2d0NIQklmS3RRSFYvOWdzSUtEVlBlc1ZIZmNDVVozcElMR1k5?=
 =?utf-8?B?VDRCK2RBNGgzSnpBNU9UdHdYS1lhNS9WMUoxZHFiZndEaEowU3BZQ3c2YU16?=
 =?utf-8?B?MFpJUWl0OXd3bVRTekh5VEl4b3R6R203NmxyR1VWaFFkb2o5YzVaT0lYZm83?=
 =?utf-8?B?K2o2S3ZPWUNTdHQ5YWgvSmsvZW5nZ0lKU3YxcndEUG91ZE5MWll1T2MzOEV3?=
 =?utf-8?B?OUVac1hsVGZHRWgxMmpmbmo0c2NFMC9RdDhOVE1Mc2ljTTZNcldUc2xUUDlG?=
 =?utf-8?B?emIyekQ3RHU1RjUyQThzV3UrdCt1UlpJNG9Iamp4elFzRG5Fam1XbmdBUFNX?=
 =?utf-8?B?QnVqQ2RPY2tkVm5kWk92YnZkN2QzQUxJTFRkbG5MTkJHVVZjOXJINFlGMlB2?=
 =?utf-8?B?VFpsdzZURWc1NHB5ZG5SZEwwRmlOcXNPSExsek5FZ3dZWmhHZWdaWG9tdm41?=
 =?utf-8?B?QmhuWk1GKy9iY0YwRTJoMGU1OG03WlA0djBzZS9ycjRESUI5azFXc1BOZEFS?=
 =?utf-8?B?RUdZaW1uR0FVQ3BmTXRXd2pTR0JLdmlHQmNJNm5PZkNGNHNyMi9XVkMyUFow?=
 =?utf-8?B?ZjFiVDBabm41b1JtMGZVYS81ZXhWMzhjTFByVHZML1VTbzhGNVducFk4bFlH?=
 =?utf-8?B?QU9GVzNQNDZqYkhGSW51OU5YZ1p6VXhVeGpZZmpSdEd6VUdpYkVxekE5V3l3?=
 =?utf-8?B?USttdnFYWlRWNG1ndURibTZjbEpOUWdra1hyTmFDcDRBRkYxWW5FNEhJN2tv?=
 =?utf-8?B?U2I3ZFdmUm83VUNoSktucWQ1WnVLWWJ6RWlnODVlWWdyai9zMzVsbWVubzVS?=
 =?utf-8?B?TkhOaXh1QnJYVlh1eWhsdkN4bVA3VkM2SE51MXE1NVdlYjlFOWcyZGJnK2J3?=
 =?utf-8?B?YzJIUnByNXlpa1ZsNEFTUWx0SWVhYTlpamphRldXZ1NDWnI5cS9kQm5ZbXRB?=
 =?utf-8?B?S1NKVnMydWlvb05lQmxwWEc0V2llY1NOVzJ5OXZ2MmhiUlA3V2tUQUxIYmNh?=
 =?utf-8?B?YWs1ODBXeWlqbDBranFkeFYvYWVnbXFUZGVMSUdzVXkvaytXRGlqUnBETXFE?=
 =?utf-8?B?Z1JMbjdhUzFZOEc1cjhadWlYUVpXbGoyd2IyY1VwTVFkVlFDeTViQWo2Z1c2?=
 =?utf-8?B?V2VZNkpHeFdvd1dmUSt1SmFobjlKM3U0Sk9KYlNVMEYwMEh1U1V3c3BmRDBQ?=
 =?utf-8?B?M25ZNjdNZlV3dWVkdkFSOEtrSEtuYnZJTGdtVXZyc254NHBncTgvbjlyS29I?=
 =?utf-8?B?QnFRZTF5ZlFyeW40OERDaVNyTDhtL2NFMkovRkVPV0dYcUpXeGltdmNrSnNZ?=
 =?utf-8?Q?eX3y894XvwY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0RVa2JTSkpPQzZWOU1wUC9VWVdqYk00TFpOS2pmMllSMU9SbFBDeWFTdjVq?=
 =?utf-8?B?Vi82UE5uV2ZDVG44Y0t5VWVIZHl3dkplNnZpVE1TdUUvNEpVdmlUUXhmQ1Zt?=
 =?utf-8?B?QWtoV1V1MHQvNzUzNTVac3NHRnZrS0dnK0tUQy9BSDA4WlhZclpDbThMSFF5?=
 =?utf-8?B?RHZHei9Kak9aNlFiWDFhUmdCT0JyV29UV2xqSFo4dE9HMG52blFNZHR4L0kw?=
 =?utf-8?B?R25pNmUxSnFKYS8wNFV2R2kvUm1EcURySHdJMWxhVmIvNzhNL0FPTzN5alVY?=
 =?utf-8?B?SFNTUnlNZmU0Y3MrSHVFczBWdEpRa1pvQVIzbXhObUJDaGtVNlQ1ZzFOYy9h?=
 =?utf-8?B?aisxY2JaYmZlcHQrelJFSWt3SkxJRFZpemZBODkzVTJ6OC9lYjRzTGd3Qkor?=
 =?utf-8?B?Qk1CRTJHVEdKTERiRmNpd1NRVWlMdW1oc2ZiaEl5bGxlVWdhWllrRUh1MDF1?=
 =?utf-8?B?bjNTQzZTbms5L2syVW9Iei9OdytoZ3pPRHFEUXFyZjNOditEbmlNNU94V0sw?=
 =?utf-8?B?MU1EaHpXSFl2S3BuTVp0d2hWUWdOdkxsR2Y4ZnRlNitiNUVNclYrTThKMmlh?=
 =?utf-8?B?emxFOWFtZ3pWendhcUhNNFN6U2hhM3UrSmxBaTA2QUk5dGFicGhRdWQrK0dV?=
 =?utf-8?B?TWNibHJOWXVLUVptQkJyZ2RyVmtZS0FvWis0bHE2SnorY0hBdERiSFlZek12?=
 =?utf-8?B?Z1NvNVI3NnBPU2owS2FEbVdjMHFHdEVSU1d0cTRmeW90aG1iMUY0UU50bENE?=
 =?utf-8?B?Yk8xbE9yU0UxblR1Y09WWENZemNGT0VKUUh1OGhyY2lHMzR6V3pRTEhLZVBl?=
 =?utf-8?B?dlo4R1FWTW8zQ1kxQlNGaWdYemU0N0pWYnRlZmU0UTZOcXpWeFdxU29YYmVo?=
 =?utf-8?B?dXFiK1MxakxIV25LcGlxcFFBOGZ1K0hRSDloR2NQT21BQ1JZcWdsYjFpVWgy?=
 =?utf-8?B?ZzJPQS9UNW5CNXZRSWMxWWZHRTBPSHRURnZJWkZWUWl6bk91aHQ1OGhtUyts?=
 =?utf-8?B?ei9IQXNNaU5CTWhJMlUxL0tUSjA3TXBzQXdZUnBZT3lpUURlS3Z3RWVER0N1?=
 =?utf-8?B?N2NkRFFVbmxCR0crOWMrdEY4Q254eGpaTjFrdlUyVFRNenpxaDc4SUQ5RXVH?=
 =?utf-8?B?ek4xdWZtSk9xbzRYQ3k0UE9OVGN5SVVrUWV4WXZqeGc1M0lNOW1vK29BSFdx?=
 =?utf-8?B?bVEzU3dlOUFyYndHZVJTU1lZWWhEcUp1a0xZbE9ZTndYYlRyZC9YMmxINVRm?=
 =?utf-8?B?ZEdLL204OXAvNXJhRCtDZXpnanBRSGdHMzlPZ1NCS1JROEkwUzJscU4rTUx0?=
 =?utf-8?B?Zm52eUJqeEl3NnREajN1ZlZManhsLy8vTEhnUHVtQTM3czJncVJZeUN0akNW?=
 =?utf-8?B?NWN3UEJSWXF3bVhTb2tyUDNRL21QUG04ek9DVUQyMlhLeUo0b1oxRWNHNWRP?=
 =?utf-8?B?cmZjd1dCT1BxK3kwTFZvUUt4N3pEQkNZTWNuTlIwYmtvc2MxUVVyVHpKYk5n?=
 =?utf-8?B?Ty9zNzJtakkwM1ZPdGFGKzdYOGQydU4wdzlFamdsRVNheXlYUC9yNUlKbjRC?=
 =?utf-8?B?YnFlTFNIdFdqNW1EeHdYVGNHaWMwbmhWQVBkck50ZitMaVhERjFRMEE1b1Iw?=
 =?utf-8?B?bjJ6VXJQU1VOeVR4d2ZwN2ZVMW1yNnRqejg5aXY4TGcyc09lTUtpUjNHNS9n?=
 =?utf-8?B?bEtIZ0EyNFFiN1ZtWmxGUmJRYUFmZ3ZmNHNNelFranliTG8xSGpnRDRNZ2Vj?=
 =?utf-8?B?QkxyM1gzcEQwZGZ4L3Z4MFNQbUt2Z0VkRXRVOWRPcWYydkFLeFI1UW4yTWhM?=
 =?utf-8?B?SWpIWWdEM1VyUngrSDZNMmdRQ3FpR0N2ZU5Nd0RVeXc2YlpwcHFLZDJ6c2ox?=
 =?utf-8?B?NFlzY1hmZzJKVDR1bGhIOFBoOER5REdlbmlPam1LSlJwRE9uMWJReFpHelRQ?=
 =?utf-8?B?VmJnZHBRck9Jd2hHM0s5QzNQUjBJSU9HTEpQVkdpNnl4L21NbzdxN1c1WS9k?=
 =?utf-8?B?VjhYU1FiVXVsVkdEL1BJT2hIWUczdUF4R2d6OTJObm5iS0dyTkxwdmlDb2F1?=
 =?utf-8?B?TEl3SlBkN2U0WGY3VG1WTGRrR28wQjBrdnVTa2xESW82L2xGeTVXVVF0MU02?=
 =?utf-8?Q?EKhf3tgDiuqtqx9/Va195bKSv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e47083-d8a8-4fa1-52de-08dd9e800112
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 07:11:17.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/3NIHorqg7vKDfQdBuGsnS4ZwLGeWM9nzv0jCJCEckL6/2ltEqZd5PTiXHZSJ8NOMHVERwsR0w1eywosrgo1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com


On 29-05-2025 11:48, Nilawar, Badal wrote:
>
> On 24-05-2025 11:30, Sathyanarayanan Kuppuswamy wrote:
>>
>> On 5/23/25 12:01 PM, Badal Nilawar wrote:
>>> From: Anshuman Gupta<anshuman.gupta@intel.com>
>>>
>>> Implement _DSM method 0Ah according to PCI firmware specifications,
>>> section 4.6.10 Rev 3.3., to request auxilary power needed for the
>>> device when in D3Cold.
>>>
>>> Note that this implementation assumes only a single device below the
>>> Downstream Port will request for Aux Power Limit under a given
>>> Root Port because it does not track and aggregate requests
>>> from all child devices below the Downstream Port as required
>>> by Section 4.6.10 Rev 3.3.
>>
>> Add some info about why you are not adding this support?
> Scope is limited to enable the use case of VRAM-SR on BMG GPU. I will 
> mention this in cover letter.
>>
>>> One possible mitigation would be only allowing only first PCIe
>>> Non-Bridge Endpoint Function 0 driver to call_DSM method 0Ah.
>>>
>>> V2(Bjorn/Rafael):
>>>    - Call acpi_dsm_check() to find method 0Ah supported
>>>    - Return retry interval to caller
>>>
>>> Signed-off-by: Varun Gupta<varun.gupta@intel.com>
>>> Signed-off-by: Badal Nilawar<badal.nilawar@intel.com>
>>> Signed-off-by: Anshuman Gupta<anshuman.gupta@intel.com>
>>> ---
>>>   drivers/pci/pci-acpi.c   | 87 
>>> ++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/pci-acpi.h |  8 ++++
>>>   2 files changed, 95 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>> index af370628e583..76b19525535f 100644
>>> --- a/drivers/pci/pci-acpi.c
>>> +++ b/drivers/pci/pci-acpi.c
>>> @@ -1421,6 +1421,93 @@ static void pci_acpi_optimize_delay(struct 
>>> pci_dev *pdev,
>>>       ACPI_FREE(obj);
>>>   }
>>>   +/**
>>> + * pci_acpi_request_d3cold_aux_power - Request aux power while 
>>> device is in D3Cold
>>> + * @dev: PCI device instance
>>> + * @requested_power: Requested auxiliary power in milliwatts
>>> + * @retry_interval: Retry interval returned by platform to retry 
>>> auxiliary
>>> + *                  power request
>>> + *
>>> + * This function sends a request to the host BIOS via root port 
>>> ACPI _DSM Function 0Ah
>>> + * for the auxiliary power needed by the PCI device when it is in 
>>> D3Cold.
>>> + * It checks and evaluates the _DSM (Device Specific Method) to 
>>> request the auxiliary
>>> + * power and handles the response accordingly.
>>> + *
>>> + * This function shall be only called by 1st non-bridge Endpoint 
>>> driver
>>> + * on Function 0. For a Multi-Function Device, the driver for 
>>> Function 0 is
>>> + * required to report an aggregate power requirement covering all
>>> + * functions contained within the device.
>>> + *
>>> + * Return: Returns 0 on success and errno on failure.
>>> + */
>>> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 
>>> requested_power,
>>> +                      u32 *retry_interval)
>>> +{
>>> +    union acpi_object in_obj = {
>>> +        .integer.type = ACPI_TYPE_INTEGER,
>>> +        .integer.value = requested_power,
>>> +    };
>>> +
>>> +    union acpi_object *out_obj;
>>> +    acpi_handle handle;
>>> +    int result, ret = -EINVAL;
>>> +
>>> +    if (!dev)
>>> +        return -EINVAL;
>>
>> Is retry_interval param optional? If not may be a check here for non 
>> NULL condition is needed.
> Yes its optional, its up to caller weather to retry or not.

I will make this param mandatory and add NULL check here. Then its up to 
caller to decide whether to retry.

Thanks,
Badal

>>
>>> +
>>> +    handle = ACPI_HANDLE(&dev->dev);
>>> +    if (!handle)
>>> +        return -EINVAL;
>>> +
>>> +    if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << 
>>> DSM_PCI_D3COLD_AUX_POWER_LIMIT)) {
>>> +        pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", 
>>> DSM_PCI_D3COLD_AUX_POWER_LIMIT);
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>>> +                      DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>>> +                      &in_obj, ACPI_TYPE_INTEGER);
>>> +    if (!out_obj)
>>> +        return -EINVAL;
>>> +
>>> +    result = out_obj->integer.value;
>>> +    if (retry_interval)
>>> +        *retry_interval = 0;
>>> +
>>> +    switch (result) {
>>> +    case 0x0:
>>> +        pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>>> +            requested_power);
>>
>> is this not a error?
>
> No its not error. BIOS Firmware can deny the aux power request.
>
> Regards,
> Badal
>
>>
>>> +        break;
>>> +    case 0x1:
>>> +        pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
>>> +             requested_power);
>>> +        ret = 0;
>>> +        break;
>>> +    case 0x2:
>>> +        pci_info(dev, "D3cold Aux Power: Main power won't be 
>>> removed\n");
>>> +        ret = -EBUSY;
>>> +        break;
>>> +    default:
>>> +        if (result >= 0x11 && result <= 0x1F) {
>>> +            if (retry_interval) {
>>> +                *retry_interval = result & 0xF;
>>> +                pci_warn(dev, "D3cold Aux Power request needs retry 
>>> interval: %u seconds\n",
>>> +                     *retry_interval);
>>> +                ret = -EAGAIN;
>>> +            }
>>> +        } else {
>>> +            pci_err(dev, "D3cold Aux Power: Reserved or unsupported 
>>> response: 0x%x\n",
>>> +                result);
>>> +        }
>>> +        break;
>>> +    }
>>> +
>>> +    ACPI_FREE(out_obj);
>>> +    return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>>> +
>>>   static void pci_acpi_set_external_facing(struct pci_dev *dev)
>>>   {
>>>       u8 val;
>>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>>> index 078225b514d4..1705d03bfe26 100644
>>> --- a/include/linux/pci-acpi.h
>>> +++ b/include/linux/pci-acpi.h
>>> @@ -121,6 +121,7 @@ extern const guid_t pci_acpi_dsm_guid;
>>>   #define DSM_PCI_DEVICE_NAME            0x07
>>>   #define DSM_PCI_POWER_ON_RESET_DELAY        0x08
>>>   #define DSM_PCI_DEVICE_READINESS_DURATIONS    0x09
>>> +#define DSM_PCI_D3COLD_AUX_POWER_LIMIT        0x0A
>>>     #ifdef CONFIG_PCIE_EDR
>>>   void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
>>> @@ -132,10 +133,17 @@ static inline void 
>>> pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>>>     int pci_acpi_set_companion_lookup_hook(struct acpi_device 
>>> *(*func)(struct pci_dev *));
>>>   void pci_acpi_clear_companion_lookup_hook(void);
>>> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 
>>> requested_power,
>>> +                      u32 *retry_interval);
>>>     #else    /* CONFIG_ACPI */
>>>   static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>>>   static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>>> +static int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, 
>>> u32 requested_power,
>>> +                         u32 *retry_interval)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>>   #endif    /* CONFIG_ACPI */
>>>     #endif    /* _PCI_ACPI_H_ */
>>

