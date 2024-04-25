Return-Path: <linux-pci+bounces-6681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F5F8B2B21
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 23:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379181F2121B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 21:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B15D155726;
	Thu, 25 Apr 2024 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvL8kgIW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA501FC4
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081400; cv=fail; b=J6BtFcnFcigJbIrUDhdCiPCVFBq6lu89Q7tvZYFaYPD2K7sdU3Kcqj5/lGU4hqhGLbKliRh6WCLi2xRUrgGENNp8jI/EyFedo/mch43VZD6GSYs4Qc8desd2PFbBJGbpTD+bOe330F70oZR93idz25M5RO/iSipgUp9Z7nZ5dQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081400; c=relaxed/simple;
	bh=OuagDUZxWtbislRRbCdQAdMoAZI47g9S6HzKQ3sCjAE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EbAnq/TuR3qYaslEDPWhEbZqNcH8H9EqjwDTxHf+Ha2di8jZ/x0DlLmfm4ZBXIUdTOOTTQA+NaxF1DTBm/eLM42vFCsOzhLe+3PnSj8wRIMP1e5fXKkJ1Kgna+Qq9rPxrmJ0djw08w2bPIUVH5xFlNVZSj/Z6xsH8ogmRFsGsUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvL8kgIW; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714081398; x=1745617398;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OuagDUZxWtbislRRbCdQAdMoAZI47g9S6HzKQ3sCjAE=;
  b=WvL8kgIWUxNqXwGGCNaTsrRlPWWOtBdQM03JUcGB8gDkzQg+oTE9Vtvn
   WVPnBX3db8skPFuSPmPU5qXpeb2nPmOoRztFchPCsUj84f4ie8qFV/1t+
   qqmBYZzqugT0BU+vdL+IvSvKpmwLjhL1H53o6mbVtyaiXSTEpVjYDeocN
   0jttYPwuEWAXB4yXEzBFWFaoSbIzg7z0p4G/aDsC5byBDMrWJv3iOf+G0
   Mts5/tIsgQwOO2tLUl/vwXr/JTZnZGC3xNcA4+3aD0ikYu1BHTeCKLfwC
   vuXBnl7gAFRlMrkcOJbFKBSTpaFzGWHlyPTkwJSk7SPE0RJT9XoHi7BVG
   Q==;
X-CSE-ConnectionGUID: J/Yu+n1xQsWlXh/VOOnphA==
X-CSE-MsgGUID: v5kk1sLtR+SFdMwvjmzgSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9669779"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9669779"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 14:43:18 -0700
X-CSE-ConnectionGUID: JtmaW9UHRamgC5qCMiMQZg==
X-CSE-MsgGUID: KeLQyb0gTPS/u54/sK82TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="56390672"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 14:43:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 14:43:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 14:43:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 14:43:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2C/9tYK5OMzJA0K+OL//gW0td8J5bGGOD8A62gy0AvlUAoBQKaa2kPt2Ygf/uE7/6IEsRvGPY7FXsggNF7fpYEM205/+NGRMUf5AtYaJmmR99boFaVrEwJOYnboa369ozmx9oFaxYdJm20G86oE7C4qwM2bWqqJ8/1CowECmJk6d7ol4g7sLOnR6HOBLt1nfvpjCnF3y/JoFCBwO1XJ2jjLE8px+074F+LmfXsscU6Lo8YMyzlnFh1OpZsVdBCU10cNziCdbp9PEMWU6lzmuGPK9tSf2Na33CqM74bPMlgDI8hPLlfTWtAz98JJnu1hTTf/moaVxBiO62otfd+IHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAnRFoR9kuf+qPbQ5WPlcKRRghnzJZbeu014fINnR3Y=;
 b=AUjtG4zaIZUWJIbxF0qFFuvjD5Tkob7j5OoFPlJEeQRXcAgnqHujzsXo11JHDBdPwgHUBMcE5Qe+ZysJqg5etB98UK2sr533Tmlvk6AUxmtGhfxKnAgQi3257NrbG6wZPyuvaahfHoqxWFJtWAeweeAbZuY9yKONVp/GqsynZWiKIYE/vs10/x5OhctKs7SulIjrmQ0fmb+8ONbe76S+0GvQducv4PhZr0z3FCwfrDYO2h54g9kDgOQOIuTxWcVajHSEGSDZjRHjQK3sQEmw1H26u98OT0cQ9vU/0TZrdwOeUJA0jik+g8C07sX5GvoLhG3hfy0CDWs/k3OruFwY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by IA0PR11MB7331.namprd11.prod.outlook.com (2603:10b6:208:435::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 21:43:09 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 21:43:09 +0000
Message-ID: <935baf43-791e-4c8e-9566-e05335e74cea@intel.com>
Date: Thu, 25 Apr 2024 14:43:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, "Kai-Heng
 Feng" <kai.heng.feng@canonical.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20240425172447.GA511062@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240425172447.GA511062@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:303:85::25) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|IA0PR11MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4689d9-ce72-4029-641a-08dc6570b2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVFqMmNWdWI3UllGKzJxZVJhOEMzLzhTNXZkcWVWOVc5RzZ0RXkwby8rcGFp?=
 =?utf-8?B?R3NaTnlVNlVwOFI2SWhUY1BWKzdPWVQ0emtxSHVlek9qTkt5ZWRvbnI5MW5h?=
 =?utf-8?B?WHByeDBvbllCN2hGbFV3SW5ISnQ5eUc4VHhtN2o5VFhUeFc5VlJ3bkh6Ukcr?=
 =?utf-8?B?YmlpdW1xbjJ0elBORkxLRTlTMmZzWHNRdVJqY3hmdnFSME1MTG1BTVhLWDYx?=
 =?utf-8?B?aDJMREMxblVLOEt6VEovN05aWlhFUXFmUzhwS0psZitmWEZoS0pISXhBRVdk?=
 =?utf-8?B?L2E3TmltSTFrLzZKbnhSRjlnaTJxazIrV3JBSEE0TlhOMGlMVTk0K2crSmJJ?=
 =?utf-8?B?S3poTUdHSUw2SzFuVmZZdm43N0d6YUVIYjI0OGlSYlkzdEtBb3FzSWdhNnM1?=
 =?utf-8?B?WUVqMkNqdDRvcFFYNWJTY2tZNTdTVEh6VHp4WlpPMFlvcEJmZE9QbnBQMGdq?=
 =?utf-8?B?Ujh5ZFdtV2grdDFOTWd6bXJJd0hxNXR0TzdrN2s3YUhqL09vQjJxa0wraXVt?=
 =?utf-8?B?cmFGWEtFYk13Ujh3bmlJNGMwRkVsQVJ3OTBXaUd1VWNZOUQwcHdPZ3RyM0Jy?=
 =?utf-8?B?cHhXWXlFUXRpakErd2lWeUtWSStxcVo4c2svWENNK0ZrbWNFOFhVbDIvQ2VO?=
 =?utf-8?B?VXNzcG5Xc1FpM2htQXFXY2trU3Rvd1pIWlp3SDkzRWVQTmp3ZGlCS0ljU3Va?=
 =?utf-8?B?OVg2UlZ5RFYyVlFNYnVDYkc1djNXWldvTDlIQ256emV0NTdENTRxQURBMDJo?=
 =?utf-8?B?bUsxU05udjhWYzR3cC9HSzM3QzdVMmx6Wml3OExLUmxHaE41WXhWbXBoeUtN?=
 =?utf-8?B?M2JVMVRSaW5UWUFLbU4vcXJnTVBWZEs0Zk9OdUlxaTl5eXlLMlhndUhOMUZM?=
 =?utf-8?B?RVFuNVFNblFPb1dVSWh3YlgyODFkVWFnVnFTeHJtTk44TXJDak1oK0dMd2lQ?=
 =?utf-8?B?Wlc2WHFoZDlGY0tXSysrUjFEUTNYODFaa0c2eUx6U3BtMjhBS3NZZENOb3ZY?=
 =?utf-8?B?U0l3SXJBUlQ0ajdvVVJmcWcwbEVpSVVQMXEreHZrZ0RBSVMyZVN6ay9XaHgz?=
 =?utf-8?B?RHVFOWhvR0pkeVVibnJUZW15K00xdVFMdmZ4Y2R3Wm1zRHp3dDNXMUtGVTZQ?=
 =?utf-8?B?NWwydXY1WXBFR2YxQXpzZmJRT04vMkZFM2p6U2FFRkhkektZZk13RzRSZDlM?=
 =?utf-8?B?WGlOWlZ0Z0hPQ0NlSlVwTjhKT3h2Q0tiNTNUQWpOanZ5d1c3QUNyTUdIc3Vl?=
 =?utf-8?B?R0NYM1JEam5CZ1FBa2hHU0JRb3VhSzFnbTBWYkJyYVMza0IzWHVmVHB4M3Bt?=
 =?utf-8?B?cG0ySk1qQXdweXBXdldMTnRMUmRSVmc4d1JJWG5nY3pCUmovWGV1R0pzVTBZ?=
 =?utf-8?B?RHN2SWlPYkpUMkF5UTQ0bHZubkd1bytRdTMwS0xsbko0MVNJMlRkTS91NXJX?=
 =?utf-8?B?K2h6YnRTckp5SHd1SVVYSzRlK0JBOFdCTGJKTlhkYmljYWxKbkI4ZFJHSUp4?=
 =?utf-8?B?TzY5anVKUnpiT0lOQ2dqN0h0cUxoYmlMa3dJV0dJZEROSnB3ZHc0VjJ3RldN?=
 =?utf-8?B?NDg5ekJkWXdVRnRKSDUvRnVmd2xJYWI4QSsyTkgwSXBGWnRHOE96a1VkSWs0?=
 =?utf-8?Q?SdiU0/pr6n7VXBvG77g8yO/A8JbwGAqggqVFx8HxBPEM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1J1V2JDSk9keG8wbTA3MnRQa1VFaHNPZmZoS0Eya3RqZHhVem12NjZ6VGpW?=
 =?utf-8?B?dE1SNzNGRDkvaDZXZUEzOXNjaXM1SlNCSDZ1dzZuUlF0NUxMMXNSdDhsY2kx?=
 =?utf-8?B?Rlc0V0VWYkptTlkvcG9IWlYxUnh2dkx0KzNRc1JLRjBML0xEL1ZPcE5Sc0hz?=
 =?utf-8?B?L3Nrb2plYk5NTW80REFCWERFT2FaYkFIN2hHN2N4MkQ2QXEzL0w1U2pveVAx?=
 =?utf-8?B?Y0pwU0tpZzJCUGJxQXE3ZndEMWhscUtTVnE4UnFEOGJxMnordFBWcE5vZTdh?=
 =?utf-8?B?bVN0OWhJUFhqWlRBVklVUEMxWUZUUUQwWHNaRWV0RjFNaGNaUnJ3bXdxRVZz?=
 =?utf-8?B?SlZ4YUYwQTk2Y0RuYTRHWndQMmVuNkJUMkZiSE5NdC9leGViTFh3LzVYVklj?=
 =?utf-8?B?V0ZMRVpBU0wwRE5CUk5ka09WWldTeFVmUkw1Z3JHVUJNVjU3TElqcXd0emFx?=
 =?utf-8?B?a2tld3RlQSs2M2VPdGhwRC9XZVArYWZlZm1LUG11S0JUNndHNmRNd25QazRG?=
 =?utf-8?B?TWNFYXBzaUppOFRkNkdScmxHa2RSR0I3a3I0UlUwRFFKTHFiOXkwNnhUWGVE?=
 =?utf-8?B?cFNlMjZPWVR4RUwraWgvcXd6S21XUTJBaXdmbFVhbVQ2UWlyZUNGSDNDcXNs?=
 =?utf-8?B?cVY4ZEdXenFmdGZCQXp4Qkd0MUtTV0l2MjFZUldTYXEzSjBsZjdiRm5URGoy?=
 =?utf-8?B?OEF4VEw2R3FvcS95WGlQL1VKeFpYM2gxSjJYZ05OTzZmY1V2eE5lVmFjRTlH?=
 =?utf-8?B?dGQvTTBySlpXLzBkOWIzdHQvYjBQc0xaeGRuZXROd0xMQVVSZXpzdzYyS09U?=
 =?utf-8?B?UjFsQ3hJOG1FWDRYTlM4MHFzdTlSMUY4UmFBT0pFdnlFRy9yZTVsaGtCME0v?=
 =?utf-8?B?NEt6TlBMTXNIN0JsR3JEYUx4ZEh4alJub3kwS1pFRW8zU0RrWmNVRGNrTXh3?=
 =?utf-8?B?TEU1dDdyYTY3Z0IzdUhoTmtBSW40bGJWdTZ0bTZHY0FwdHF3UzFqMFFGeWNh?=
 =?utf-8?B?Ui9uNEpyT21WRXZ4aGxQWGtmR09GU3Ewc1JjU1ErU3RqUDlib3BSS1JEdW9D?=
 =?utf-8?B?UGp0cGZiTW5ndUZHMXNTSVVxQWQ1YllQQ0RqMGkySDV5d0lPYlVlMFV1a25M?=
 =?utf-8?B?T21iWGl1RU1iNkRxdCtVMUl6aERaQ0laWHJiTE0xWnhOOCsrVERrcUtVQnly?=
 =?utf-8?B?VlhYNHBIcVdhQUdDVUNJNURaL2lrbWZsbFZaMXhxQ0Z1QjVYeHRYR0xoVlMr?=
 =?utf-8?B?TjZMNVJBOGRvTEc3ZWZnL09ZOXkxa1dKNVh0REI1UmNsV3J6em9mN0gwc1R0?=
 =?utf-8?B?WkdSZy83bGxRRmNRa1JCUDZ1KzNzalZ3KzM5WmtxeHdEUS96S1RaVlAyRGJL?=
 =?utf-8?B?OU1NOUZHcnE2UTRMOVJrTEM3Y3dhOTB3ME5yL0hLYU5BWVFIeHZBVWd2M2JH?=
 =?utf-8?B?NGN6ZkROSFNqa1RrSkRIcUNpaDk3OHE3SVZLQVRaa3ZpSmdOTVhoL3FXZG16?=
 =?utf-8?B?Zk1wWmpFa2R1d2p6dHFFbnFLT2tiQlhZOVEweXR6ampCcmRtejg4WE92NEdQ?=
 =?utf-8?B?aDNMOGd0bzVWSFZWTjM3a2FXSiszc29XTjVJZkVkOXhUY2h3M3NNc3JQOVFQ?=
 =?utf-8?B?M0xlcG14K011ODRranoxMGxmbERRNDhVSk10dTZ0Y0Npc3l6VVBkaERQOUpv?=
 =?utf-8?B?VHhRZHpCNnhMTEk3bll0NVdkWnNQUWhnbWNkc2cwbnc3SUZaVVBKR2gvZlgv?=
 =?utf-8?B?UUY2TllVYzdGcTdMbUhzSmczZ3crK2NBTStuZ0NENGpjbEVJcUpreHlDYWgr?=
 =?utf-8?B?L3YzWXUyejBwOTdYOHRteFU3cmpWRjBNOEZiRkxYc0JiMmFoV3JIOVJyQTc4?=
 =?utf-8?B?UERNR3pObkRjNWo1M3pzR1BjOVhLa1hoRGNmZHkyNnlURTd3NitLUnZLbTVy?=
 =?utf-8?B?Qm0yVDFGVE1URk1CWE41cmVHYXBKZi9LWFBIbGxnTUswY1I5b1JqQXlCcVRR?=
 =?utf-8?B?UVM2eUY2QmMya3hLZFpMMzhubEQ1eTJlUCthaVVlaEYyWCtRb1g4ekhQQ3kx?=
 =?utf-8?B?MmJROWdyc3ZEOVg2Z0xlWEJDQTMvc3VjZDhRVTN0QlRNZlA1K0NVbVM0Zm5t?=
 =?utf-8?B?cklReWRrQmRRcDgwTmlTczBsNmhSWG5mM2lyZDRLdmxRLzlNSmNZVEo5TjJJ?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4689d9-ce72-4029-641a-08dc6570b2d0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 21:43:09.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGmnQaop9mJA8Ka/jCACCRuHl8961ikC5M+0S/9Lcg4Maewv/xMr25f7xLf1eyZ148VVToNrnVDshKvSB9psPvqJUxiR86J4N0mkIoEWOrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7331
X-OriginatorOrg: intel.com

On 4/25/2024 10:24 AM, Bjorn Helgaas wrote:
> On Wed, Apr 24, 2024 at 02:29:16PM -0700, Paul M Stillwell Jr wrote:
>> On 4/23/2024 5:47 PM, Bjorn Helgaas wrote:
>>> On Tue, Apr 23, 2024 at 04:10:37PM -0700, Paul M Stillwell Jr wrote:
>>>> On 4/23/2024 2:26 PM, Bjorn Helgaas wrote:
>>>>> On Mon, Apr 22, 2024 at 04:39:19PM -0700, Paul M Stillwell Jr wrote:
>>>>>> On 4/22/2024 3:52 PM, Bjorn Helgaas wrote:
>>>>>>> On Mon, Apr 22, 2024 at 02:39:16PM -0700, Paul M Stillwell Jr wrote:
>>>>>>>> On 4/22/2024 1:27 PM, Bjorn Helgaas wrote:
>>>>>> ...
>>>>>
>>>>>>>>> _OSC negotiates ownership of features between platform firmware and
>>>>>>>>> OSPM.  The "native_pcie_hotplug" and similar bits mean that "IF a
>>>>>>>>> device advertises the feature, the OS can use it."  We clear those
>>>>>>>>> native_* bits if the platform retains ownership via _OSC.
>>>>>>>>>
>>>>>>>>> If BIOS doesn't enable the VMD host bridge and doesn't supply _OSC for
>>>>>>>>> the domain below it, why would we assume that BIOS retains ownership
>>>>>>>>> of the features negotiated by _OSC?  I think we have to assume the OS
>>>>>>>>> owns them, which is what happened before 04b12ef163d1.
>>>>>>>>
>>>>>>>> Sorry, this confuses me :) If BIOS doesn't enable VMD (i.e. VMD is disabled)
>>>>>>>> then all the root ports and devices underneath VMD are visible to the BIOS
>>>>>>>> and OS so ACPI would run on all of them and the _OSC bits should be set
>>>>>>>> correctly.
>>>>>>>
>>>>>>> Sorry, that was confusing.  I think there are two pieces to enabling
>>>>>>> VMD:
>>>>>>>
>>>>>>>       1) There's the BIOS "VMD enable" switch.  If set, the VMD device
>>>>>>>       appears as an RCiEP and the devices behind it are invisible to the
>>>>>>>       BIOS.  If cleared, VMD doesn't exist; the VMD RCiEP is hidden and
>>>>>>>       the devices behind it appear as normal Root Ports with devices below
>>>>>>>       them.
>>>>>>>
>>>>>>>       2) When the BIOS "VMD enable" is set, the OS vmd driver configures
>>>>>>>       the VMD RCiEP and enumerates things below the VMD host bridge.
>>>>>>>
>>>>>>>       In this case, BIOS enables the VMD RCiEP, but it doesn't have a
>>>>>>>       driver for it and it doesn't know how to enumerate the VMD Root
>>>>>>>       Ports, so I don't think it makes sense for BIOS to own features for
>>>>>>>       devices it doesn't know about.
>>>>>>
>>>>>> That makes sense to me. It sounds like VMD should own all the features, I
>>>>>> just don't know how the vmd driver would set the bits other than hotplug
>>>>>> correctly... We know leaving them on is problematic, but I'm not sure what
>>>>>> method to use to decide which of the other bits should be set or not.
>>>>>
>>>>> My starting assumption would be that we'd handle the VMD domain the
>>>>> same as other PCI domains: if a device advertises a feature, the
>>>>> kernel includes support for it, and the kernel owns it, we enable it.
>>>>
>>>> I've been poking around and it seems like some things (I was looking for
>>>> AER) are global to the platform. In my investigation (which is a small
>>>> sample size of machines) it looks like there is a single entry in the BIOS
>>>> to enable/disable AER so whatever is in one domain should be the same in all
>>>> the domains. I couldn't find settings for LTR or the other bits, but I'm not
>>>> sure what to look for in the BIOS for those.
>>>>
>>>> So it seems that there are 2 categories: platform global and device
>>>> specific. AER and probably some of the others are global and can be copied
>>>> from one domain to another, but things like hotplug are device specific and
>>>> should be handled that way.
>>>
>>> _OSC is the only mechanism for negotiating ownership of these
>>> features, and PCI Firmware r3.3, sec 4.5.1, is pretty clear that _OSC
>>> only applies to the hierarchy originated by the PNP0A03/PNP0A08 host
>>> bridge that contains the _OSC method.  AFAICT, there's no
>>> global/device-specific thing here.
>>>
>>> The BIOS may have a single user-visible setting, and it may apply that
>>> setting to all host bridge _OSC methods, but that's just part of the
>>> BIOS UI, not part of the firmware/OS interface.
>>
>> Fair, but we are still left with the question of how to set the _OSC bits
>> for the VMD bridge. This would normally happen using ACPI AFAICT and we
>> don't have that for the devices behind VMD.
> 
> In the absence of a mechanism for negotiating ownership, e.g., an ACPI
> host bridge device for the hierarchy, the OS owns all the PCIe
> features.
> 

I'm new to this space so I don't know what it means for the OS to own 
the features. In other words, how would the vmd driver figure out what 
features are supported?

>>>>> If a device advertises a feature but there's a hardware problem with
>>>>> it, the usual approach is to add a quirk to work around the problem.
>>>>> The Correctable Error issue addressed by 04b12ef163d1 ("PCI: vmd:
>>>>> Honor ACPI _OSC on PCIe features"), looks like it might be in this
>>>>> category.
>>>>
>>>> I don't think we had a hardware problem with these Samsung (IIRC) devices;
>>>> the issue was that the vmd driver were incorrectly enabling AER because
>>>> those native_* bits get set automatically.
>>>
>>> Where do all the Correctable Errors come from?  IMO they're either
>>> caused by some hardware issue or by a software error in programming
>>> AER.  It's possible we forget to clear the errors and we just see the
>>> same error reported over and over.  But I don't think the answer is
>>> to copy the AER ownership from a different domain.
>>
>> I looked back at the original bugzilla and I feel like the AER errors are a
>> red herring. AER was *supposed* to be disabled, but was incorrectly enabled
>> by VMD so we are seeing errors. Yes, they may be real errors, but my point
>> is that the user had disabled AER so they didn't care if there were errors
>> or not (i.e. if AER had been correctly disabled by VMD then the user would
>> not have AER errors in the dmesg output).
> 
> 04b12ef163d1 basically asserted "the platform knows about a hardware
> issue between VMD and this NVMe and avoided it by disabling AER in
> domain 0000; therefore we should also disable AER in the VMD domain."
> 
> Your patch at
> https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/
> says "vmd users *always* want hotplug enabled."  What happens when a
> platform knows about a hotplug hardware issue and avoids it by
> disabling hotplug in domain 0000?
> 

I was thinking about this also and I could look at all the root ports 
underneath vmd and see if hotplug is set for any of them. If it is then 
we could set the native_*hotplug bits based on that.

> I think 04b12ef163d1 would avoid it in the VMD domain, but your patch
> would expose the hotplug issue.
> 
>> Kai-Heng even says this in one of his responses here https://lore.kernel.org/linux-pci/CAAd53p6hATV8TOcJ9Qi2rMwVi=y_9+tQu6KhDkAm6Y8=cQ_xoA@mail.gmail.com/.
>> A quote from his reply "To be more precise, AER is disabled by the platform
>> vendor in BIOS to paper over the issue."
> 
> I suspect there's a real hardware issue between the VMD and the
> Samsung NVMe that causes these Correctable Errors.  I think disabling
> AER via _OSC is a bad way to work around it because:
> 
>    - it disables AER for *everything* in domain 0000, when other
>      devices probably work perfectly fine,
> 
>    - it assumes the OS vmd driver applies domain 0000 _OSC to the VMD
>      domain, which isn't required by any spec, and
> 
>    - it disables *all* of AER, including Uncorrectable Errors, and I'd
>      like to know about those, even if we have to mask the Correctable
>      Errors.
> 
> In https://bugzilla.kernel.org/show_bug.cgi?id=215027#c5, Kai-Heng did
> not see the Correctable Error flood when VMD was turned off and
> concluded that the issue is VMD specific.
> 
> But I think it's likely that the errors still occur even when VMD is
> turned off, and we just don't see the flood because AER is disabled.
> I suggested an experiment with "pcie_ports=native", which should
> enable AER even if _OSC doesn't grant ownership:
> https://bugzilla.kernel.org/show_bug.cgi?id=215027#c9
> 

I don't have a way to test his configuration so that would be something 
he would need to do.

> Bjorn
> 


