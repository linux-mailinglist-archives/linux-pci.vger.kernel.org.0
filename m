Return-Path: <linux-pci+bounces-32855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A351AB0FD28
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 00:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2573A354F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 22:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37AA2586DA;
	Wed, 23 Jul 2025 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JR2W98C/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257EF221F29;
	Wed, 23 Jul 2025 22:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753311400; cv=fail; b=j8k2ETg1RWkAeOu1ONYmZE4yWDv8Jh1MmuX0IWlwbwFYFOvk0Qo8GSl80frvJ1/9WvADs27BmDr+znWokfc6Gy68FRG/TP6yPZz6BEXDNDuJWfofcw21XCqsSfRDDJIlrIf7NyJl2Z5kDjd2z+9JRPJndz5QZe4ITFwqZvNyImU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753311400; c=relaxed/simple;
	bh=+W4LFtvc0i69MDof4iAf7wN6lVGDDEEocjzeQVqwBTw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nHCmCTFjcg45XRYolxC/XKDCcHMSl0IZNLSfNrLjF6X5y6+AspRjfP89+FR1n1V+MZDECVBSChqThbuzSqGKihtJp6c3NrfrIsvdKTT1ZyHigWEDz0OGZ6rgO+//G03cdqNWoaBfh6nBTtscmB6Ow3F6KvtvyzXbpWnvt/OqcKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JR2W98C/; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753311399; x=1784847399;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=+W4LFtvc0i69MDof4iAf7wN6lVGDDEEocjzeQVqwBTw=;
  b=JR2W98C/6XDwTiNY6Zr0mBA72aeEGv7FNewbamuP5B6a6nxwKO9qhfbq
   S7kucI1E4FLnhkSd8r3akCoTIx4alpC8sp4aJnZzDDB1zR3DY1nkUlyb7
   Cr+av+EvaEyuAwUhzMiEpkn7sutfmtJrCXPH4zJydMbX8ge0/3snIIr6c
   JKQR7GzfYKbhL2P6UbnfZUHaRLGuWoOvy3s/Gn22+0wPIEcGcaXcI4gec
   N6BYuzBJmDOx49TH36Pw0AwS0YtcRrlVnAPA3fN0UIzKoOJ4tJ7PWkgB4
   Fdi4KzFEmgXFBeJT/hJMl6cYpsNFu2jmHu2v9+TY7YVF4NWZWM4KWJFh8
   A==;
X-CSE-ConnectionGUID: Zj64Fp57SsKVyD54iBNthA==
X-CSE-MsgGUID: F/tHBHsMRt2/0IMmNwFaUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73188144"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="73188144"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:56:38 -0700
X-CSE-ConnectionGUID: xBBMJh9WTUiAaRowTLZdRQ==
X-CSE-MsgGUID: KIEfNHt/QXC8cIeAD1IfYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="164070365"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:56:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 15:56:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 15:56:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 15:56:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LL4sxmmKw8rRVMAR9VWK/Ac/YcvAi7EMOtZ1vj+0uR6ghCWMKyVNRYwrIvHQW7O72UNjSm+kaQ8huVzuCj2HrplHYeJ2///3C9e4jY3cPAgu/nTECdE3YKCi7TvF2060tDGK68PtR2Ng/2SFgCRx3bwRME0AoTw68805zLmLcja4B3lMqe2ELUKL7gDcQSMYaiB7weYZA1d82EKVwms+bsL0fo71/Bx0y96E9f1N3N4y9q7NbsXEfzwPvOO3FgqnypFyS+5DM4aI1GsR98/TelG4/3ctxZLXeEaryFVOljHyVNz67COqdJQ+wYTkNcTfm5OlGUZPV/s/8idVF7joKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LbLHkHja80hYTdutvVUYILou2LEaWSjzLYlZBdYGGg=;
 b=fbn9S4CmnokGWZoxDYaFBu7FcFGRVyfdCNVIVJUyEHPekkcAStRjoTpxXz6iU4fVld2b8EgyvObro8+v+moNSr+N4ITrk2u21jLth2NeQxXR1hAeAaMSnu27cnsFv+Yv7l+mdaAR0Ty5fWRq0BOpcyUuN8s+h5It0ygUT8Db0u8KbDjJKnFP2S273F090zG8nRyDjT2HsBGE7f+8IHE6qf9eR/65rDxGEom85RE81EV19xQlZLePMUQ1t6TcdqmP40UDbjmzxlmwAXsnv26bsyT7tQlejWcGPmhkehyQJDknGBAyAi9vofqFKZldoGzk41HlSkE7DBicORKfx4kjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5771.namprd11.prod.outlook.com (2603:10b6:a03:424::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 22:56:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 22:56:04 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 15:56:02 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <terry.bowman@amd.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <6881688297812_134cc7100aa@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250626224252.1415009-4-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-4-terry.bowman@amd.com>
Subject: Re: [PATCH v10 03/17] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 316984cc-8138-4721-4126-08ddca3c1a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnVOVGs3VFR3TWhsRTEweUhPSFdiOGpoaGQ1RVRUd1drdTNEMVhnejJ6ZEF6?=
 =?utf-8?B?ekVCamR2TjBaK0crUXd0MjRZdGd1dmpQT28rdzAvY2FwZzRBSnlDWFpRSHdu?=
 =?utf-8?B?MnVjZkJhRit1Z3FoZFl0U0tpNHcxMWdkOUNSaFdjTHhiMHU1c0x2VFpHMnhw?=
 =?utf-8?B?aTdhOHBDMk80ODE4RmFCdTlqak04RXk5UUNPSEh6T0ZUZ0dTSjBFQkk3WFhR?=
 =?utf-8?B?ZjV6cGVQaGhZYWxUd3VWWFBtUHlZcm5MQmNNOEtLbVN6ZkxwbTlNRDNGZzBZ?=
 =?utf-8?B?WFIyQjluQTNmeUVxa3RZbDZqRHhZS3NraXlzOFkzSjNMOVlKSDN3a3pWbTgv?=
 =?utf-8?B?Mmp3MkR3VUZ4N0ptc290SFU1ZFR5bjFIT0Q0RmdSUlNhaE1WakZLOHB6WFpZ?=
 =?utf-8?B?aEptZDBBdU8yeHFQOHJDbFF1cG1oSmZwZUFJY2M5cVJ0cVpCbVpGSEdxZXA3?=
 =?utf-8?B?WkRTMGQ2M2JsQ29FK2M1TFg2SmhaUU9CTGhZeEJaSWhNU01aSDNtNHZiYnFz?=
 =?utf-8?B?TXJ4TDIxR003ejZUQjBLRlJseklpSDVtd3JLdm5MNVo2TVdSUUIwVTFvZ2pO?=
 =?utf-8?B?VUhqTjUxZkRab3pWYXdLaW1SNTlCUVRScnlJOXJHTHAvNFpSUzdrZFdFaURY?=
 =?utf-8?B?aDlKcE5qN0oxbVNuT055NGJObTd2a09mZlZ2ZGl1RU9HNG9xWXRoZmlGYWdy?=
 =?utf-8?B?ZXJtSlQvc1VFL2U1RDlKanhqaTdBUmEwK1d3NUQ5N0ZUZE5MSU56ZkdXbENm?=
 =?utf-8?B?UUsrTFFzeVlVZXJaMnVHV3JQLzNheGdiaDdzQmY2TFYrNTlJQ3VTM3B1MTMy?=
 =?utf-8?B?UnlRSGIrdW91NEdmS1ZUNUNDeEk1Zy9pOS9YK2NwY3RIZFdiSTdqYlVBV3lE?=
 =?utf-8?B?S3BPaEo0MWdOYTJpUUE0b2NOK2xOMFhlQVY0L1BSN2VGVGcrWFBKZk43Smlu?=
 =?utf-8?B?Q25mT29HMWpMQmkvOVA5OGRLWDgwZ1BYekZUMDRIVk52aXFlUmhOb3R4TWEx?=
 =?utf-8?B?WVRpOUkzalhHclAzTXAraTVTalZub3c0allNMDhLNERDK29HU1FpS1R1K29Q?=
 =?utf-8?B?TG14cUE0TXNzbjdtSUo4WGFjakNkZHMxcmY0dTgwZklJNXQvK3lLMUJCdHRv?=
 =?utf-8?B?WC9DNlhTZVZmWTdPcndOcTFJS0RXM1Fmbnk1MXBqRTMvZUlNZE1LaGNnUzMz?=
 =?utf-8?B?QnU3VXcyTkJGM2hCZzdIbm9DWkRKN01wWldxSWFlK052eFpIbmN1cEEycE5R?=
 =?utf-8?B?c2xaeU9zdXZQQnVSV2JqdUQwSVJ1YWMyaW1WcUJlRnl6bXZrakZiaXQrZC8z?=
 =?utf-8?B?TGZuMWJKWXlNQUZINXlMZTlPN0dGOGE2cjNPSFBQK1dKejRpWmNMNElsR1Zk?=
 =?utf-8?B?SlRPUTZWNzhLNTZOKzhJaHpqNGYreWQ0V3k2UkJtYzlvV2VKck1wU2RJd1ZB?=
 =?utf-8?B?SEJpNmhlVnBKRDJWdXNWMDF5VUFkRmk5VVJQUXZGNWgwdjFzUWN1dHBWRGdO?=
 =?utf-8?B?cWNIUmJ0bkUzNml0cVp5MUJHV3hHL2ZuVlZKNlhMaG4yaTgycXNhRU9YYjZH?=
 =?utf-8?B?QWZZbUlyV2FTbGk5WUdQY2dYZFVyNjFKcFJDL3ZEdElQdVl0WXN3Z29QeHdZ?=
 =?utf-8?B?SlVDNlN4cW5vUTFXazQ3T3R2SGt0cEFybGUxM29QK0lWSnJFUUVmNlc0TjY2?=
 =?utf-8?B?c0NoVnZZTlI1eld5ZXJDTzFIVGFEdFRKNU5hRkxESkFyWWNJcE5Ra2w4aVhq?=
 =?utf-8?B?ZElqeFlxQjFidjA5N08zd2l6V1lqQSs5VWtlbXp2cUpZdTF4Y2sxMXdweUVl?=
 =?utf-8?B?VTVDUXN5aFJJenFnNDNuVlJBTGNKUGRUd0ppL2Q1NkhsVGozQkJqb1F3bVZ5?=
 =?utf-8?B?dkh2NXR2bFZXMDZLR2h5THRtRFRHNlo0dlNkNC9FS3dKZk9NVTdrTkhseTQ0?=
 =?utf-8?B?NXRYQWh3bmRxQnRxUGVjTEdlTzNNSGxGUHBTTC9hT2pka3FNZVNEZFE1ZmNy?=
 =?utf-8?B?K0hUdEVkYit3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjZHSjllY0VBbnZ2TXdVaTlwNTE5NmI2UXhuS05hNFhmUzF4eEwvWjR4T0ov?=
 =?utf-8?B?UnI0Y0s3QWlIbkFXalBhUDMybkFzU3NDKzdrVVFaYzJzOWdSdnk3Sk5aRG9a?=
 =?utf-8?B?aXRKdU52TVIvV0loTC8yMDg0YldXa2t5d1N5YThRUis3amphMVFEZ1JqOVJi?=
 =?utf-8?B?bFZRY1dXZjY2UVJ0WmNGODUvVTQ1d1MrTzdLdlc4RklkMElyaDVpMFp3QWVk?=
 =?utf-8?B?K1Z5VXVUMkxwNGREcHhURnJqb0k4bFZEL0JQTU1nSWQybHlZeGFXUGQ1VDlB?=
 =?utf-8?B?ZFVsUWVjOHJ3Sis3Tk9rUXI2YTZFZVVneUZabG15RUVidGxtaEtEZEdDWklz?=
 =?utf-8?B?UnZwR0xqejRJLys0MS9sZjhGeGxaOTVRbmtySHBDTzdqTTdKd0FwbFRtRXox?=
 =?utf-8?B?YzAvYm9JMThjRVhkeEZCVU5tbW52bktjUVIyWWZiaW5JRnlZdS83QkV3eTV5?=
 =?utf-8?B?Y25CcnEzUUk2VDd2SGdhRWJ0ZzF0V2w4SVJSUTBFTk9ib0FUQWxNYXp0QSt3?=
 =?utf-8?B?cmVRRzJTbUJoK2FWMHh5YmE3a09QY0ZRYmZyMDRnZ1lhMkloQS96dUZ6blV4?=
 =?utf-8?B?TlluVFZSRDNGY1lpSU1LWlFBS3h1SVB0bHVjTGFGNCs1bS92WEVFRWRxVExu?=
 =?utf-8?B?NjdkZ3BWSzVTQnNSS1hhdGUzUDQzTFBOYnFIWU5McDQ4ZVlFc083MU5HUHE1?=
 =?utf-8?B?bmwzbkhmN2FtK0RJUlJEZUorcGRvOUZVWXZSSGpBeUI3MkFOdWJRKy9yS0Uv?=
 =?utf-8?B?cUVLelRVK2FqTnQ1TytFKzhxVzQzK3NSQkd4NWl4blRmOG53WnVVMkJGQkdY?=
 =?utf-8?B?SXh3K3lqcDVNcVNncStkaURjQVBjN2UvOGFpL1hzeGduYVhlUFNCc01RS1lC?=
 =?utf-8?B?dHRxKzdneVh2RGhjMWRCZGlQMGJWNURUMFNUNjNsRUYzaXdrMlpZaCtESFIw?=
 =?utf-8?B?aWg2QXdYTVpvWnpSTzR3enV2cGJTZlFNS0M4RXBlRHBWM25YNXRldVJhMmpz?=
 =?utf-8?B?dFVFT2ljb3lGU2FEaVVFNjZyb0RrbWZIMmNLeHFmeWJnQ2VHNmlYZ2JudUZy?=
 =?utf-8?B?UWo5RGF6UHRGZUxiM0JCYnpuMnBFbG5xVGpUMlVBdG1jRVIxRDVWeTB6VHN2?=
 =?utf-8?B?a3BJRWlpU2RyeU9ZNUJ6eDZ1aGdzdVE5SzVYVFVxQ0hiUDZpdlJTaWpNc09H?=
 =?utf-8?B?RXlweU11SlBvSzdOZFBwUHEzYjRPU2RmOXltZzhGK2xhZWtWTER0MWc2QXN5?=
 =?utf-8?B?Vjk5QmEvN01DOS9tMEJ3RDMydjRYK3dEQUgyUUFpVm9KZE1KT1N4bjVtbHhB?=
 =?utf-8?B?aDd5MkJBb0VhblJGcmpmZUdHUW5RQ1F6WURZZHZ3aEE0T2FyYTNnUVVvcmZ0?=
 =?utf-8?B?OFk1cStDWGI1MGlCYVhKT1hXSURmZnc4U09XcFZKZUhuSXJaRGFRMUlGSnk2?=
 =?utf-8?B?UFRPTHpMdjFod0Q2eU52RHppWXpqdjd0RWxGSjhwNUFVUlorMGNaQ05qaFpO?=
 =?utf-8?B?RklmSThHR2YwZG4ycFZMcFpNVmVxRmg3U0dNTEhDRWVPNzdrYzlGUjZ4d2g0?=
 =?utf-8?B?aTZScUY2aHdUUnlnNlF3MVNCdlFkQTloQ3FRWFFVSExUNlRicUZ5ejVPQ2dj?=
 =?utf-8?B?Tk9wcXdzWW1SKzJPZjQ0dGF5N1NiaEUyL1Z1L2ZDTUFha1VObkkvejFjbjk1?=
 =?utf-8?B?KzE5aFR2cVVBU0pQaVU3SUExOEpIR2RXbTJtTjFPQko4RXY0QUVjYmx3c1lR?=
 =?utf-8?B?SDVpQkFMZnlKa0pCVUJQWU95MkQ1MzkzclltVmFsTFZySVNERUk4ZUUxNWpq?=
 =?utf-8?B?VSt6YlE5Q3BOa2lrcVVOa01ncEpVUmVTOWJiMUhFVFdDeEd5c1kzNEI2ZjJF?=
 =?utf-8?B?bFpmaXhRR0RxUEsweWltQU5rdFhRMEpSOHM2SXBoZllBRkJwTk5YMERmRHIw?=
 =?utf-8?B?UllNRGQwdDdjZXE2NUJhOW9VeUREOVpibitweUtOSlhzaXV4bUtxeTFnRHpj?=
 =?utf-8?B?c3Y2ckp0WTRuOTBUb1RJY000RlJ4YlVBZnFUMmxydjd3Ni9xY25iR3RpOXdI?=
 =?utf-8?B?Q24wKzVZQ3dSK0sxOWpRWXRkekNsZkFzcWdaTnRkYXJScFdkYXZBUUhKalhw?=
 =?utf-8?B?VDB0d2dpR01aMXVlcHphdG5XYmh3eWpla3M0WHR0RlBmRlcwUllEb2FySG12?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 316984cc-8138-4721-4126-08ddca3c1a12
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 22:56:04.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbgGUOn9jD0EnFfmHyl08cc/ZRIG//uXa0N6Vod34Ziug9mOW1aUdFDmQQgIWpwFJkEPWAxeqQs0IsK8iMloNcqiS67th9rtkQBFT5nOkvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5771
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
> Type' for CXL device errors.
> 
> This requires the AER can identify and distinguish between PCIe errors and
> CXL errors.
> 
> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
> aer_get_device_error_info() and pci_print_aer().
> 
> Update the aer_event trace routine to accept a bus type string parameter.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Looks good to me, and agree with Shiju's remove the extra trace comment.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

