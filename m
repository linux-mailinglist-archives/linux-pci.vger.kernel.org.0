Return-Path: <linux-pci+bounces-17137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B289D46DE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 05:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FA5B2140C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 04:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70C2309B2;
	Thu, 21 Nov 2024 04:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1lQla/E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB7230992
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163888; cv=fail; b=JFJqV0EZx8TPJAOCDRgGjh4s0L1XSdixOk8c6QZBqdFUl5jCq6+zdLmnCXmDKnanloj9hEUoPZ11wptkr3Tex+a02ClveFHipYdCSUDGkuxEgXdK5pp+uvjde59v2K/jduSJqiVVNx217rDTXeuk8cr4LvhGlo6auNKNZCpNQSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163888; c=relaxed/simple;
	bh=/8WDKlNFoG3UpweCwzpdOY/ZiRTNaiFUXrrybUJEvEI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gzcXhxvBU/9VLgkwuiyZWrFCdq99zmERd2lA48fHrGvqn0OXT3xI41frkPlspbeVALkRVRos3mPocQZwLom+aGfhFzWG7yvAMj6xqnBJwY9F6rusE+NbJn5zawrFbUzkFka5G3oxrHBF7GwwNJnKXWJTJDpgCyn4lVVjw7zEU44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1lQla/E; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732163886; x=1763699886;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/8WDKlNFoG3UpweCwzpdOY/ZiRTNaiFUXrrybUJEvEI=;
  b=D1lQla/Ee66UE159NAQfOfJMIgVDlFW3eU8VltwU/hKd+vKfCjpi/pUh
   jPfCBBUtHp6xi6IWJ2juJ+xUZ7nSCXtjis/ndApDtZAF86o6r3Dv3WPxK
   AKSuH/c1lE240pJelgnTL5aC8BFQDeUKKU6tZakwcoN/c64OfI0uy3wqF
   p7CgqGEV7gw47QCvNp5Ls4K/oXalXvfJQRc/RVbKNf7hKDDJXF0/vkSpL
   WzHto+5MU58VShYutRz3dcTvjOWrArutw9oINpCakSCoxKTrqPK8F0xCf
   gTbektcFmtDp2BL22IIL0mKBdVAS/o5RyR70EKBzMRH2+DNo4BQIWgXbs
   A==;
X-CSE-ConnectionGUID: PFWnMB1QSEmy6mMraJY4Gw==
X-CSE-MsgGUID: qA3OotRaSnKIpBJsvHDYtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="35114277"
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="35114277"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 20:38:05 -0800
X-CSE-ConnectionGUID: +m9iyPy8RHGxQ0EfSkeqsQ==
X-CSE-MsgGUID: Cdvoqy2SSd2Lfpipge4iew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="94192364"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2024 20:38:04 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 20:38:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 20 Nov 2024 20:38:04 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 20:38:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5/hY0oLDSceFN7VkZC2aOCOusIzah6gSrr2ixkr/dKVfN2rLVZkZDIfzs1PYCxSrd7K46KOj2nc01AMElybLy+2Dwk8KASE9NYK/kKZHAWghbmt56a5prK0WNs9HphHUAPmqkQIPsev9EYYi/y4l/l7IU2F2Y1Ku58rkuq14aS3pOEYhlfiHT5woGqn0JjwS0kbKDaSow3hBxhyyhSKAczJqNsK25+Hezhq0j9UfFfX0TM0rwHrut72AlDUwDaHak0PGdGGF1qtekLTswSD+y5yX2P7aZwMotQZfVTQF3pGRXVZw1KsC1DKVX1ph2stDfvEVXgLu+aTCIIqgzOZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vfFhATgqhJIV6sSq8zric6Sb/KdtFFTVH56W3ndaNk=;
 b=D/rl0KXBa/5sCjjWLgzOpjsjoQScydPsBz9Z0vQUT7cVvWmGxePcOgzIFyRnJiY41H9itq/WNmfoALWzA8MRGW/ErsiFbgtzNjtpaOV0XxiMbUwolAvNGghmRP2kuzjg+NT6BnhW/A95BB0hGJlYAb/FxkdpnruV5uGe02Rv7nFTXdpf1Pf042wrsekNLUbSY/oIl3eRV0JF9YTOuE/CNErEPM+AdbFpg+wxl9vIZuBTbfHwR6+lJbD7V1R1dfR47W8jA+t0/W5zON1TotVesunFfAOcNvubTYwK4PfdnpNdsivEPdAwc7xCBNAQEb4Ei7+UaDJ7s4RJuF8W4C7EQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 04:37:50 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 04:37:50 +0000
Date: Thu, 21 Nov 2024 12:37:41 +0800
From: Philip Li <philip.li@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: kernel test robot <lkp@intel.com>, <linux-pci@vger.kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [pci:controller/rockchip] BUILD SUCCESS
 592aac418ebdf451fe9b146bc2ca6dfc96921af0
Message-ID: <Zz65FRrnhF6EwVQf@rli9-mobl>
References: <202411180006.ahFN8muC-lkp@intel.com>
 <20241119151925.GA2263235@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119151925.GA2263235@bhelgaas>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CO1PR11MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: d8567886-6df4-41bd-d2a7-08dd09e6412f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zm5WRGd1eTd3Ty9ET24yMy8zNkxxUW9zMkV4aHNXVnFTTHhEakk1dUNrQkY3?=
 =?utf-8?B?RE8rc204OGxYbUtMUUI2RG1sTTUxMUZTVCtkVE5jZEgxaUhjMWFLTFo5aXVH?=
 =?utf-8?B?VlY5dkp1SFVRZ3lNR0t5NmlOTmdzMEJMWGZLekVZQlMxejYway80emJpVmlW?=
 =?utf-8?B?aHlMYWRGalBMc2k0bWpUeFV5SmlWSnBGMlplMVJFazR1a2pzMjB3bDFaZ3JS?=
 =?utf-8?B?T2FLdmRjS0c3WERpT2EwRU5BR1A4S0pneEd2d0xlSXV5WnZScDV2WUJIM0Ix?=
 =?utf-8?B?MzdkZHJVK3dNK2JHbzZabVRWemxVTWVSWTdSUS9rY2d1N2Fsckx1YnhUNmRN?=
 =?utf-8?B?cW14bzJQRDZvY080Rzl6MXg4OFhCeGtqdHUxclpSbXdrSS9KVjVJeUR2THlh?=
 =?utf-8?B?Y0x4NmZKR3pqbVcrQ0tXR0FJTlE2WTNpNzArVjVUd3ZnZnZ4WGR5SWVOMlRG?=
 =?utf-8?B?Ymh2MnYxZ3ZSK0YyQkxYakJTR0I2Uy9PSWRVRFUwb0g5U1UvZVVZWkxXVExP?=
 =?utf-8?B?S3lWS0dUUklva1l1U1c0MkdGeHVDQUt3bXVsMGhLVCtJcWlpSzZmc29aMlYv?=
 =?utf-8?B?Mm5Ha1hrVWxnejFrZ0FyRWF6Q0lLVDZ6V3VRU0w2clNuUlFLb2lubUFOMXoz?=
 =?utf-8?B?eUpOSTNMUHB6K1R3UzZHSGphUUdwTG13ajkyc0VzRjJPRUFwWmpQKzJCeVI3?=
 =?utf-8?B?TWErT21uQTF6aGhQYys4RVI0Z1BGaXFhV1F0WDAvN1FQeCtIeFFnL3hGbHR1?=
 =?utf-8?B?ZWtLVTNZMFd0bEdWZVBOZkd0Q1QzUWEvbHBxTFdCa2JIWGYvMUdoT1RTTEhS?=
 =?utf-8?B?WVdqdFZ4RHVrblp3RGVIK2g2WlRUTjdZcjU5cU94SWhqakpabGdvNXNhZWhD?=
 =?utf-8?B?Q3RRRjVqQzEwUWIrZ1RScUhGRGc4cVR2T3hJYUtCQ0xUa0t0WXljcjdLenhu?=
 =?utf-8?B?RmhsSCtnMHhvVmYwaE5rWUdhdzM0bHZaVzljeHRIeTZGc0RBdXc2U3d3YUxz?=
 =?utf-8?B?elMrSEJLWm1uOVMvNEljK1kvL2V3cVNWbVpZdElvckthQzlwUWxVWmpTVHli?=
 =?utf-8?B?a3psNFRRTWhrcDlwZVpSdTZGQ3dLUnE4VENMMVpLY2t0Qm5pclNkeDFzajN6?=
 =?utf-8?B?UkRTZlhBb3kzWkxFejdxd2tRQkxvOWtPdWNPdGxzQmhySDQ5b2J3bzVOcUFx?=
 =?utf-8?B?bEtTNVA1RUtNd2JmME12Uis1N2toNkFCT2dNWCtZMlR2dWk3RlNFbE1KbEpq?=
 =?utf-8?B?Ui9sRGM4VC9rWnAwN05tZHR5cktNdjV3VmJvaW1wY1BHeDgxdnNLZVpZK1dU?=
 =?utf-8?B?ZTlGOW15VkFtUG53MG5Pd1Zqb0Fyd2JxbU9taW9wTDNJRkN5YVlTZDVGUCta?=
 =?utf-8?B?UVM0L01EN0FjSnZTZU9jMUhBLzdvWWdpTHVaQ1NTMUJuaytISTh6WjYwbUtt?=
 =?utf-8?B?Zk9lMzR1WHFJQTRrVU95SWJNYVgxak9sWXFCMUhSeXRMUGVlc2pKR2c2Z1Mw?=
 =?utf-8?B?TlI3dU9NOEtrL3VTT210M1lLbnRNMVRFTHBQMXBSeXpaNkdrZHFSRDN0T0ow?=
 =?utf-8?B?M2VLck5jUkZ6bmFUWVFPTTBTQktnbjZWREM4ZW9rdHk5YVVYNkRTZVZVcFFi?=
 =?utf-8?B?WkZibjcvaU9TK3hvS3hwRFMrMU0xSWkveW4vOTlmMWVqN2c0OWJydVVpZmpv?=
 =?utf-8?B?V3pGeEo2VVpzSmJGMlRHZW1tb1BteGk5SEh3TkxpRFJoUlYzcTlGbVV2TENF?=
 =?utf-8?Q?NH5+wcmlf3g5+8TXKMfyhq2r6u5LYN0ax3TDnaE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0dJRm5ONDNnV2pLcWJ3MFVaaFZjekgwenBxQ0h0MnAzdHZ4SU1aZ0ZQYWk4?=
 =?utf-8?B?SkQ3UmExVlJCSmhMUTBDb1Y1Z1dqRm52VWF0cWQvYWJVWlVXKzd4bEQvNHBm?=
 =?utf-8?B?UFhxSzZkcDZQUWFWSTFsUlVycXgyZVliVE1zRVIrdTlyS3NoYTV6MXQ1TW1B?=
 =?utf-8?B?Q2MySzVnT2VKcDZ0Vk5tNUdWMmFaT3ZWUUdmK3E2VmZqMmIvOFZFTXJpUElR?=
 =?utf-8?B?NFUwcWIxSGJGMS9ZU0dBUjBCWEFyZ29vS0V0cld2WUFlenY0SHMybGNQRm16?=
 =?utf-8?B?OFhWTVlIRWNSdlhTQS9DM2htWUl0QW9EK2dScWwyYUNkVXZxQTlvSzBKNUNx?=
 =?utf-8?B?L0Vka0NORnZXWDAvanlZREVxN0tPamJlOHBPNjlrNVErOFhtWmxGYVV0NThv?=
 =?utf-8?B?dWFsaUtEWWZJZk5OZWVaUW1nR0hRdXpyWDBSS1JQd2FHV3FOdThhL2tvSVFX?=
 =?utf-8?B?c0haTzhyNzNmSVZDVXcxSCtEejQ5cG1jekZKVmh4dUFrM3dGZHlVUTI5SFU5?=
 =?utf-8?B?aHlDUzQyNmYxUm9ZUnZFckd5cVhwcFdSRXJwMEgrSmZnaHBDWU5LVXpuU0tR?=
 =?utf-8?B?MTRHYXo0eXk3L3lzbGdGVDFTZzR4UDRyU1o4TEMxTDRXL2ZRZXRNTzh4L251?=
 =?utf-8?B?RC85UzMxL3YyclZreHV1U2llSVREZ3V4WWFuNG9IYWFjeXMycUo1UVo1K3dj?=
 =?utf-8?B?MlZyWUo0c2x0NGRuTTZoL2dDZ09lYVYzTGoyQ3dnZVltWTZlRTJmT21xQnZS?=
 =?utf-8?B?TGVySS9udWxDb2g5TVoxdTV6YUp4YTdnQ3pFK1A4dzJpWDRSWEgzWnRSNzNW?=
 =?utf-8?B?NXo2UzJNc0lRbnI5MXFxTndtc203THY0cTdVaTJsV3V0RXlrVnArN1d2QTdu?=
 =?utf-8?B?RStZQ0ZMaExTb296VWVGK3gzc1RlTzErbEFTWGRkRUpub2pZdDRaK3FXV3A2?=
 =?utf-8?B?NXJYZ3ZGamZ3NENoL0YrbEtFcW15d1BySWdDTTZ1RTJrL0dLWFZDQitwVFNm?=
 =?utf-8?B?ZUVCbnlKTktPN1I4cmF3Ukc2UEZLWTN1MllrZSs0Zmo1V3dSM1VsTW5XS1VW?=
 =?utf-8?B?bENNUDcwMy9GUnVEZTFxRCs5VWxMK0lURFhmNWE5NGZhVkpjVEhtZXlqbERM?=
 =?utf-8?B?cXZjZXdlQkhGZS8vbUFIelUyR3pFOXBoc2pCVXhqdEwwNW1OTC95cld1WCta?=
 =?utf-8?B?cGIrbERlRDl1aDdWYkVzaGVmTWJKdE4rVmNvWGVZdWdpelFrUjloVFM3c2Yy?=
 =?utf-8?B?SWx1ejQzVnorSCsxVHoyeTZKTlowQUdJWHVOWExsRmxuc1JHWXlNekM2RS9V?=
 =?utf-8?B?VkFmbHphWXRPYlFSK2c0Ym9BKytlSFBGdi94SndsNjk4b0xxVHBOVWMzMElN?=
 =?utf-8?B?YmY3VE1jS2RaSTBBNDhqSlpPSnQyRXdHNGJnT3gyN2owYS94YU5tN3l0NEJI?=
 =?utf-8?B?SUpVUmNTL0xYZU80M0syUWh5VHdSY1dNTFp3NW5VSUZpZWFQZVdCNDMxbzRJ?=
 =?utf-8?B?QUh5YVA5U0UyVjFmc0ZSaUZtaUNuWXUvcmVvNDJwemFXUDYzb3NYMmVlREhu?=
 =?utf-8?B?VHN6aWRlcVo3WTZPR3pyTW5aYzVoTlB2MFVuY3V2ZTlZbVEvUlNsV0VzWDF0?=
 =?utf-8?B?WnpmVlp3Tm5UTUVpWjRUUTY4UCtMU29BKzNTbDByRnlVNVFiTlB3ZG1NbG1x?=
 =?utf-8?B?M1VuVVVBL21FVTFNVFF5ZzZYb21zcHhkQzczbDRrQVhlRk1XVEN1c0NFSXht?=
 =?utf-8?B?K1ZVSjNKeWZmd0lkbVErRXZ1TlVZOEdyZng3QVluYXVySHdaUlFvRXZFdSs1?=
 =?utf-8?B?Z2RsSVF4RDEzeFUvOE9JUjl4bnVacTZMMHd0Uk9raGlTdHYrLy9nUzZITFY0?=
 =?utf-8?B?eFVSb2tndW1sbnNkMENqN2EwTHNYMmlQOVNvUUFzaDZFd0dlY201M1o5clFq?=
 =?utf-8?B?OWtndjR3MkVBb1czT01uR2RqYnhtcStxc3duNlpyOUtKSXIxVVpiM3lrTTRB?=
 =?utf-8?B?TUd0MC9EQjB3dGZJQ3dLRlJPMitCbEVjTElnV3A0OWt2cEZBL2gzOEs5VThi?=
 =?utf-8?B?eUNpaWRPWG9WeS9Zc3FMZllMaXZ0N2hnVVB1WU1FbTd0d3JnUWdTK2p0VW1D?=
 =?utf-8?Q?G/9obXQTA0BpkoY8b2X+hMjPL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8567886-6df4-41bd-d2a7-08dd09e6412f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 04:37:50.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdCrfjYv89A01HTOO5XqdFBvKuZDjuro7y0sOLxGgY7h1NqmWNPz3fXJlpM0sZO/ax035jiS+Z0w6mA0yXe4xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com

On Tue, Nov 19, 2024 at 09:19:25AM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 18, 2024 at 12:01:12AM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
> > branch HEAD: 592aac418ebdf451fe9b146bc2ca6dfc96921af0  PCI: rockchip-ep: Handle PERST# signal in endpoint mode
> 
> > x86_64                           allyesconfig    clang-19

Let me double check this why it is success.

Actually, the bot report "implicit declaration of function 'irq_set_status_flags'" at [1]
with sparc64-linux-gcc and sparc-allmodconfig, when the head is 337657a3c24c92befb3ed11d6f15402faa09f7dd.

[1] https://lore.kernel.org/oe-kbuild-all/202411141621.uwFAKZb2-lkp@intel.com/

> 
> How can I reproduce this build?  Do you have a packaged clang-19
> toolchain?

The clang package can be found at https://cdn.kernel.org/pub/tools/llvm/files.

> 
> The x86_64 allyesconfig build succeeded for the robot, but when I
> build on x86_64 with gcc-11.4.0, I get an error:
> 
>   $ gcc -v
>   gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
>   $ git checkout 592aac418ebd
>   $ make allyesconfig
>   $ make drivers/pci/controller/pcie-rockchip-ep.o
>     CC      drivers/pci/controller/pcie-rockchip-ep.o
>   drivers/pci/controller/pcie-rockchip-ep.c:640:9: error: implicit declaration of function ‘irq_set_irq_type’
> 
> irq_set_irq_type() is declared in <linux/irq.h>.  On arm64, where this
> driver is used, <linux/irq.h> is included via this path:
> 
>   linux/pci.h
>     linux/interrupt.h
>       linux/hardirq.h
> 	arch/arm64/include/asm/hardirq.h
> 	  asm-generic/hardirq.h
> 	    linux/irq.h
> 
> but on x86, arch/x86/include/asm/hardirq.h does not include
> asm-generic/hardirq.h and therefore doesn't include <linux/irq.h>.
> 
> I'm confused about why the robot reported a successful build with
> clang-19.  It seems like that should have the same problem I saw with
> gcc, so I'd like to try it manually.
> 
> Bjorn
> 

