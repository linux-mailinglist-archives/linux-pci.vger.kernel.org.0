Return-Path: <linux-pci+bounces-17138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4DC9D486A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 08:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4AEFB22206
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE7154BFF;
	Thu, 21 Nov 2024 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpkiSn5c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953331AAE37
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732175979; cv=fail; b=nMQqfBMHZR0dEGowpTscnx76gLwAnAj2k0d18c9Y471MM8vxQCPl31mg3OHLXziVZTEmSOpd/f/HQ7vCReMqG7DvJlUOujYEqfqXZn9YxNSUJwnAwL6i0LDLbsuk7i8WPGczXOQkGUy+qtbNi9JA2HhdtcRhkMDhXCgWrjwSCDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732175979; c=relaxed/simple;
	bh=o5tdu02C0SLR+6Ze5hq6reXuPnJK6X/31poYjK1PU6A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q9cZg74f1ueUauGVEWNV3nhIjuFYhuyU2rPUCxA4vH7ne8DOxaaHB78ULLmQoEQ9C2y1CZEp7ueXmBdiPZLUfLaQ3/bzj27McAoMXyyBsPez8FmzGtcotGon+fdDyRHazKmcMPLFZcEH2+QQPM6BxeCU+ePADRJijuq3WwkXvn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpkiSn5c; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732175976; x=1763711976;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=o5tdu02C0SLR+6Ze5hq6reXuPnJK6X/31poYjK1PU6A=;
  b=mpkiSn5cfydqGsj3Wn5bOi3MQKxXUXvC8qWZNSaAX4sPjndT6ZQZKUVA
   vChoIng2DeG1OTTD501HozByZSRUvIe1WRvtIsiz+uD0Xwq8EHHut3XuI
   mI3cwiwGtXZX1cvOXIbTW5lz7xiWPkNOo67JHWCH9izEOUyTMHNhDewdq
   H+HrooUopRk8XGO4LjLe3bczh6SMMEp+u9uJr0ZYak6eAHrFbfFFAsx1B
   MJSPnwhXNjf2fxoHEw/U4O/CVUyQJSTFQsdcIFtXvWpBiTSd09Y7+DnSE
   nAaZw4LYJ73Z9H+mkt6XEkqyEtsOe544pz1GQ4U5r/a8hscOkRj9lwzDs
   Q==;
X-CSE-ConnectionGUID: xdUPvaJiRmOXf5m54V3NMA==
X-CSE-MsgGUID: 8ywQB8TkR2ipEIiM/blWyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31662965"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="31662965"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 23:59:35 -0800
X-CSE-ConnectionGUID: 5l3EFgEoTVeW0wCt06C9zg==
X-CSE-MsgGUID: v7b0fFdwRB6eFBmZV0zmBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="127702270"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2024 23:59:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 23:59:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 20 Nov 2024 23:59:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 23:59:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjXSaeJ87/mKv3QYCyEKCspSA26CybQo6W4/Q1sFeWQG6U0mq/YzPh1jawhUPlQsWqZKoJ/m7WrqvNmr/wIYQt8y3JBqS9EML050SUn5d9w+/NqCs+MuPw1pi4YiaJJd9sz6+rMHThfbFa8YXAzVnKtk2T5dpCoBCw29bkniWPiyQ2vz0arUPQUKfO6wffCLO2qljVOpNvTlHOXQtYUYgnoUbsNAKP9wYCSkanKaE1lXWgcvUFi1sFz+bqcwOB0O2JpYbSG6PyevtsQeqBoKwUF45+dof/P6m9Npb04byF/yLLOsfJ3fEf3DX2w3Yt0rQYf07ombTgMIo3deMKtG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3h68qY1EhRrWWc0/MlE3is2/misr9/DVhicIOh5k5A=;
 b=Ttl16Sjm7tTui9gcbw62tFyoWaVVgw1MpjP8QkSxVE0i9JM3xCIHIsAM/UhtxkYQeTNDT6jpsqqI/KBNyEe+kaWz+yR9RrnKalH+zhLNtPUErZ4cuzOZec4mMLXk0ypcLQPqxscpsIDDKPGtrHecY+g4G2Wr2fpv53UyN93ba8YY9m9TlMQH2tskhfdU/MWiLOyItyJD8Q4TQnHxvAC7pSjS4DYf6fDorvGGgG7FvHIV7mwK0QOuBlDIiCnoD7ZImZFCTWxMbYH5O5nRSqZsansfvOR6EO5h3DDSm7L257uN3av4QTvrFYcfnYa8Roa3jWXB9qk37x/SZI6B8rUIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5413.namprd11.prod.outlook.com (2603:10b6:208:30b::16)
 by DS0PR11MB7441.namprd11.prod.outlook.com (2603:10b6:8:141::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 07:59:31 +0000
Received: from BL1PR11MB5413.namprd11.prod.outlook.com
 ([fe80::cf37:1b32:9fb5:a956]) by BL1PR11MB5413.namprd11.prod.outlook.com
 ([fe80::cf37:1b32:9fb5:a956%3]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 07:59:31 +0000
Date: Thu, 21 Nov 2024 15:59:22 +0800
From: Philip Li <philip.li@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: kernel test robot <lkp@intel.com>, <linux-pci@vger.kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [pci:controller/rockchip] BUILD SUCCESS
 592aac418ebdf451fe9b146bc2ca6dfc96921af0
Message-ID: <Zz7oWi6vpOh8WxqZ@rli9-mobl>
References: <202411180006.ahFN8muC-lkp@intel.com>
 <20241119151925.GA2263235@bhelgaas>
 <Zz65FRrnhF6EwVQf@rli9-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zz65FRrnhF6EwVQf@rli9-mobl>
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To BL1PR11MB5413.namprd11.prod.outlook.com (2603:10b6:208:30b::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5413:EE_|DS0PR11MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6e44b5-41e8-4a4e-fb1a-08dd0a026e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2t1bktqc2k4ZzFIei92Wk5tb3N2ZVZaZEw1c2lhSVo0K3hSKytTREIweUJO?=
 =?utf-8?B?VVFSM3BhSHQrVXdyTDJqTE52SGYvRUdwS1BxQWJOVVdiWmJQOGVSK0wwcVVQ?=
 =?utf-8?B?eDVhS0RaM2w5ZnMxcEs1ZEJZdWpkSGp5bWhZdGptU3JEQTZaeTJPSXpjdzhR?=
 =?utf-8?B?UUp5U2s3WXRuTHhXc3dVQklaQzcrN2pDSVpXaXRzM29iWkhpcjZENFJ4ZWF3?=
 =?utf-8?B?ZXJlUDdjd3M5ZlhsMUFoWUszV2ZUL1R5ckdVcnEvakIxK3loOWdHTEpBRnIv?=
 =?utf-8?B?aXlza2cxMGREdStEc0EvTll6MjBFeHBjMy9rVFRMWkFxbDhIVW5QdWMvejY5?=
 =?utf-8?B?SXVyNnlOVjdaeDBwVzVnMCt1UUNBTzc2TlZpaHI3S28vdWMzV0RsaEVoZzZP?=
 =?utf-8?B?SXVTWko0VEI4UjlwZFdmeHRxTWNmM0kwMUgvVGZBNkNvMXUreHorKzF5c0Qw?=
 =?utf-8?B?MlpTVU5wWjJKUWFUcndETWNodVNGQ0ZKRmxsQjVoYi9FTURjRHN0TlMvZ3FN?=
 =?utf-8?B?cnJjZUJ2eFpQbGNMWC96QWZ1OUFRY3NmSXd3Z0xIVHdYRnlTZlFjWVM5dVU4?=
 =?utf-8?B?UFBHWS8rc2ZQWmttS00vVjNqK2g1NHV6czdjT09QbEhzOUtPWDlrakR2WG1h?=
 =?utf-8?B?NFphdkJaR1R5SmpKSHJGTTNaSUxiVURXL1FTSDBpTnlENWIzQUJFSHF1SkdJ?=
 =?utf-8?B?ejdhcVk0Vkl2a1dZRFRvSmtFM0JTOXhjdENBN3VIeVF1UWxQWGV2SzM4R2Zq?=
 =?utf-8?B?THNZYm1aUFByTjBMNmlMc1pHWm9OT3Mzc1YrVnpCV3d2Y0w5Q2Z4ZldCMFJm?=
 =?utf-8?B?QSt3L1ZGSEtId3grSzRiYzF2UkFwSlVVOTJiczNRWGkxd3ExK0IrWnFmbTBC?=
 =?utf-8?B?c2hWUkMzQVdoeXFLM2pTMkJPNlBSRGx6Y0U2c0NSM1JwTGNDQ0VBdDNFRDJi?=
 =?utf-8?B?ZGlaVGt6cURVajZLWXg0bGdMRWhMWDIxaTQ5eTRKVHJkT1NVUmNiWS9rdlM3?=
 =?utf-8?B?ampJcTMyNXF6RDhwRnhnbkdBaDJmQy9RZGluNzlNQ3Z5WTVSUjN5a0ovdG1Q?=
 =?utf-8?B?azFDTStWSDBiV2ZIMzFrZjY4SzVjK2M1Ky9TbDlpVTQvcEIzQ2NKcGZsMEc0?=
 =?utf-8?B?OGZpVFhHSWZ0ZTNyV0U0SmQzSUhZTWgyZlAycWgzb2EzNEx0V2JwVTdyUVFQ?=
 =?utf-8?B?UHg0K2sxeFhWUjdObmNINTBLRHFQZXI5ODFpYVI4US9FU1R5anJtb2ppSGl6?=
 =?utf-8?B?TjRSU0hrSkxBRE5SNnVNZUhwUjZ3UFdhd3RETm42alVBdTlkaVIxcENvcG14?=
 =?utf-8?B?YTAwdlAxZStYSlV3ZW1XbE52djVjQ1JERUZSYXhycHN0L3NpYlBueEgxTkVH?=
 =?utf-8?B?M2ZicTRuZEpWTFlyY2hQc25FL3NLdUdjajdaVVdCSHNWa1J2emN3Ukc0UkR1?=
 =?utf-8?B?aCtUVnBiajhuVFlyblVXY2VsWWdMNlZzWmZlWUxhazU4LzhrbExiR3doWURx?=
 =?utf-8?B?bWxScmJ6QnFOS3ZISUJZL1AyRmpRYmhtcFJBdUE0eWpLMlJuUzhBYmlRMDNL?=
 =?utf-8?B?L3hYbjNNOTRiUFN6ZTI0c2dTWmQrWWR3UzVIMTg4NDE2aGxQVC9lSHNkR2Y1?=
 =?utf-8?B?WHRKSk9lZGkyKzIwOWxxaHlaQ3RlNHkzUGJlWDAzblJPL0tyQ05YUFA2Tk9a?=
 =?utf-8?B?Ym1YcC9xY1hWTUhUVm4xclBDQzgxZHFmTFMrRWNXU0FGdDU4QTlwNmc2MFFw?=
 =?utf-8?Q?ICLu2DllPDa6HNyL5sFYHc7VZ0iceYaBNKiLFnO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5413.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGZibmJRcmFiZ3BDOHlGcnBjZFFmVlBCMXo5QWltelNjaENiYk5sTWpiMjBW?=
 =?utf-8?B?cXo0NWZXZHBGNCtmRG5DWUJJYmNxOGhaMm1peWJDSFZtOTQ2NmRzaHRXekI4?=
 =?utf-8?B?VW1SMTlUVVBIS1ppNXJlcEVpSVo1eW5ZU0F2QkEzOTlKeUhKZ0w2K0VLNitO?=
 =?utf-8?B?ZzN3WmVBSnREOE5GUmlXRW1wbGp6Mnl5bkM0NWtzUnVaY0lTSk1LbFYxa0FD?=
 =?utf-8?B?YlZsU2RxdmtJOUVscmxDallzZVJEcnQvdUNWbWdjN3VOTmFsWTYxMjNmL3NF?=
 =?utf-8?B?Ly9zNDRWVXVZNEdpU3ZRM2tRV3duQXM0WmxXRlNTbWVpdjdJZm5OZ1ErWXc3?=
 =?utf-8?B?c2k4aTB5MCtMd1dtUkhjQkJrWEZBMTBjVE9PNStTaFBEK1VsSS84ZW5BejJE?=
 =?utf-8?B?K3E0RzRETTJISktlOXpRS215ODA1NDlzRFpJcklSQTF3ZVdNOUFzS2Z5T05z?=
 =?utf-8?B?TkZCYkFtSXBDNlZsZTRra2JHT2FZMllTS0U2OTUyZHYvRzh4RFhvZDJaYTJV?=
 =?utf-8?B?dmQrVUVhbGNsQmpOTFJhbnp3ayttVmNjL0JELzVVdEJmQmZXNnNGZzM1K3Z5?=
 =?utf-8?B?NGcyb290NnlYZEZUcGVWMUs1QmhrYmpXUTdUWGRkemZhYlpPVWZqOXp0S0Nh?=
 =?utf-8?B?c0h2ZUVqMFFRU1VFTXB1cUNlaHZJMWgzenVyNWw1MkQ3SDVIUHJBTmh0R3px?=
 =?utf-8?B?c3RLWnJKNlhRSG5qeWRpVnJCdkplOXkxRWdlMGJaUzcwNHdTUjROa3RGb29q?=
 =?utf-8?B?MWFGdGRXTjdxeTc2c1YwcWNvOTFrK0lKY0tCYnc1UlBPdjhPWnhrYUluS0hs?=
 =?utf-8?B?VW9pcUVzMnNzbWlQRHl1Z004dkF3TWpoTEtiTFp4UWdzNHVST3l3VGVKVkVN?=
 =?utf-8?B?Wi9WUmljWHRrTmRPZlVuNXZqRlo3dzd2bHNvRkw0cmJIdzBWQjdibDU3SHpR?=
 =?utf-8?B?ekRJaXFvOEtsODJsY2JmWEovWGZ6VVAvYzF0SjQyWUdBdnkzcjFQK1dLaXZ2?=
 =?utf-8?B?YUp2UGVoY3pmMzVXMVFkRU5GQzZoY1Q5MStoOFREYnNzeFdvUVp4MEhXWENq?=
 =?utf-8?B?VWZuRW91eEl5Z0M4eUdTK3RSNEFQYXZlcC9MZXVKNHF4Vjd4M08rK2hXODhS?=
 =?utf-8?B?ZVBGMWZkMllhOXRlODVFNzRVYzVUTTNiazVQaDBadlJJZ292Y1lacmZKMnJN?=
 =?utf-8?B?eEttSEkyZHNqdVJsWkVHN0dBUGI1eUR2S2lrZVVBQ1RFV1djZU1zN1IwMXZK?=
 =?utf-8?B?c2owZTlGQW1ROHFCWldMNnZJZWo2NFUzVEd4MnFmZkxDL1BZSVpZNmhFU3ND?=
 =?utf-8?B?T2xuSlNFbzh4cHQzY1UrcWUwZEROazh1M1hJamVrbUhiTEFDYVpwQUJvRXBO?=
 =?utf-8?B?UUx2VFhxQ2JwaU11ZGpadENBQkR3N21rYVRPQlRGMUppQnExL1ViWWNWR1N5?=
 =?utf-8?B?aExldlhROUtZMUNZZUJiUktwaUI2ZnFQQXgrNm4xOHFKUjFHVkpPV3lVL3lU?=
 =?utf-8?B?eVYrZXRVLzBVMjlUTzZsMUJUU29aMjhyUGhhVjJnRzhuUldPaENseThsRmpx?=
 =?utf-8?B?MUx4L1M1TGU2bkUzdW53TUFBeVhxVWNMRXd1TzVmM2NveVpOc3drTVc0czAx?=
 =?utf-8?B?RzFpSnVLVU0zalp1MG5oWlVNTmIwWUNRWEYrRzB2SkNXL3p5cExqaU9QZUk2?=
 =?utf-8?B?Tk9aak5sZGtoRXhsYXJzOVVxY0RXemFqWHRvSzlYb21EU2kyU0RWdFErRDRF?=
 =?utf-8?B?clQwVkd3NjZSbGlaU0QyY2VDbW03ZU5qeVdsYWpYR3V6U2hBM2JTWnNjVnow?=
 =?utf-8?B?L2xDSTJPK2lZUEI0dmRxMU5Zci9WYkpqVnF0ZUV1WWxFSE9XTThkKzF5eVZw?=
 =?utf-8?B?OTRtTXZrMTZreUNaVG9ZMTQ2UzNiSEVua29XOUl6K09yN2VKM0lVSVdvOUZV?=
 =?utf-8?B?MTBzMHZGU2N1d2RydTlpVG0rVUsraXQ2aDlxUkdnb1d3SkN2U2FnS28rczNU?=
 =?utf-8?B?RVpHNTc0YTNCaWRkK2lINHhNbHI2RTh2RC9rN0VuRlpTZ1oxcnVNQko3SGQ4?=
 =?utf-8?B?OHh6QVlKY0lxVm42UHFXays4NGpudnU2bEFPL1Zlc1VnMWdxYjVNZnkySy9X?=
 =?utf-8?Q?M+pJFSecqIFtgg8SS4lKYkNp+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6e44b5-41e8-4a4e-fb1a-08dd0a026e30
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5413.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 07:59:31.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfIWvrAm/p5Jab/o7B8lg7jZmRnlb6x029obBcd5rCaG/zxrFwkYJ4a+gEBhVt+pePR38fns2B8LAD5vIMMGoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7441
X-OriginatorOrg: intel.com

On Thu, Nov 21, 2024 at 12:37:41PM +0800, Philip Li wrote:
> On Tue, Nov 19, 2024 at 09:19:25AM -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 18, 2024 at 12:01:12AM +0800, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
> > > branch HEAD: 592aac418ebdf451fe9b146bc2ca6dfc96921af0  PCI: rockchip-ep: Handle PERST# signal in endpoint mode
> > 
> > > x86_64                           allyesconfig    clang-19
> 
> Let me double check this why it is success.

Sorry about the confusing PASS info here, i have confirmed the error is
there for head 592aac41.

Below is the explanation

Early on around "Date: Thu, 14 Nov 2024 17:57:46 +0800", the bot sends
out mail "[pci:controller/rockchip] BUILD REGRESSION 337657a3c24c92befb3ed11d6f15402faa09f7dd"
with 2 bisected reports

    https://lore.kernel.org/oe-kbuild-all/202411141106.4hI5VqIa-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202411141621.uwFAKZb2-lkp@intel.com

Later for the new series with head 592aac41, it considers the bug is already
there (reported before), thus is not newly introduced by 592aac41. So it marks
build success.

This tries to mean that the success is no new issues are introduced, though there's
build failure when building the head.

For example, when a branch is based on another branch, that base branch could contain
build failure, but the newly added commits doesn't add new failures/warnings. Under
this situation, the bot sends out "BUILD SUCCESS" mail.

Hope this is helpful, and let me think of whether we can expose more info for situation
like this to avoid confusion.

Thanks

> 
> Actually, the bot report "implicit declaration of function 'irq_set_status_flags'" at [1]
> with sparc64-linux-gcc and sparc-allmodconfig, when the head is 337657a3c24c92befb3ed11d6f15402faa09f7dd.
> 
> [1] https://lore.kernel.org/oe-kbuild-all/202411141621.uwFAKZb2-lkp@intel.com/
> 
> > 
> > How can I reproduce this build?  Do you have a packaged clang-19
> > toolchain?
> 
> The clang package can be found at https://cdn.kernel.org/pub/tools/llvm/files.
> 
> > 
> > The x86_64 allyesconfig build succeeded for the robot, but when I
> > build on x86_64 with gcc-11.4.0, I get an error:
> > 
> >   $ gcc -v
> >   gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
> >   $ git checkout 592aac418ebd
> >   $ make allyesconfig
> >   $ make drivers/pci/controller/pcie-rockchip-ep.o
> >     CC      drivers/pci/controller/pcie-rockchip-ep.o
> >   drivers/pci/controller/pcie-rockchip-ep.c:640:9: error: implicit declaration of function ‘irq_set_irq_type’
> > 
> > irq_set_irq_type() is declared in <linux/irq.h>.  On arm64, where this
> > driver is used, <linux/irq.h> is included via this path:
> > 
> >   linux/pci.h
> >     linux/interrupt.h
> >       linux/hardirq.h
> > 	arch/arm64/include/asm/hardirq.h
> > 	  asm-generic/hardirq.h
> > 	    linux/irq.h
> > 
> > but on x86, arch/x86/include/asm/hardirq.h does not include
> > asm-generic/hardirq.h and therefore doesn't include <linux/irq.h>.
> > 
> > I'm confused about why the robot reported a successful build with
> > clang-19.  It seems like that should have the same problem I saw with
> > gcc, so I'd like to try it manually.
> > 
> > Bjorn
> > 

