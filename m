Return-Path: <linux-pci+bounces-18497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CEE9F2EF3
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 12:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654CA166D17
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C020100C;
	Mon, 16 Dec 2024 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuEeu79T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160834C7C;
	Mon, 16 Dec 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347831; cv=fail; b=E6ximZlbG8qnni4ZN64QWEmaZAuSsyr/LQxqZMkJg6KH9lyGP49xthobW5FqxtHnA7EqZr20bfT2LcUrxH/GJCSMMJcJFYFM6+5ITWEw3N5eQ1kHwKMCU8QEvwWDYfpO1QhFh6K5HsxWqUuTp9BuLYZbdql25M3QoQ36tOP2aTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347831; c=relaxed/simple;
	bh=8+wedpxAleKTuJb4t75Hl2Hg3HnY8/cbVQIhH36ne88=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g6Qu5sf77NTVV/Na7WMqpP8Eu78S6T+K5Hp00jjH0ldF2jp7QMBImZT7j6Y+EDvHq4RDXRKdZn3vqrmCpUrPI3JiAxXtUvxQ1ikUiKWxPveroPYxz+rDJWTR0U87PrleWHU8Cn/OWt9s+btWuWFyZpbLT8rmwfXu7Obohlsc6wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nuEeu79T; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734347829; x=1765883829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8+wedpxAleKTuJb4t75Hl2Hg3HnY8/cbVQIhH36ne88=;
  b=nuEeu79Tm0PV7m46O5/2cMC8K7jABlIOQacMqxiNRL2B+Q74sQIx5wiy
   NZxBriRGkHWjIX0vmniIDfVqrmbkEz5LDUb32UWm0qHRsdtVzF0Df2uz/
   p4wfNdj/Vo6BjYJp9fUL39pwDmXLmkqafsigER8G+ZQMxQH3TbRRq63OE
   kKXRbEC944NpV93+AKVaChkhSI1LeJQhFwiiKgrtX1Assa25rYL63KBpK
   BhfKHP7YYOxbYdUtvb/wIR6Et0lWHSgcr5pgdskvKa0uillb9TxvI6FFH
   D2oC9FgLc61lLS0jFJ+gA27iBS1aPcgoEB7h2LHOvHsF4jCdbAZkjltAV
   A==;
X-CSE-ConnectionGUID: FQ1rjzw5T1Whdb2Om+LANg==
X-CSE-MsgGUID: npvgNAj7S3aSyvCsmx9xgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34872385"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34872385"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 03:17:08 -0800
X-CSE-ConnectionGUID: BuEJdJAVQoCyMCBoO4G75A==
X-CSE-MsgGUID: rmgZBD1MSju75lCLNFEtZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="97732676"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 03:17:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 03:17:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 03:17:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 03:17:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFACJgoRmkoaVP8rkDVR5VKm6xbK4zjFNZdWcSULhjtBh4FhIAGzDiVy+tOVIXtppbegg13dj+Cv3987hDgCoR9sRCkfUDkOP0WirYQxWgoLA3jEnaJ0TLFYWBlOYmJmMSAc9SlelCbJlnI9b5dzs9fm63pTd8PX/2RE6fdxN9RUZKSCUdJREOXSGklZsFir9D7mhgI7laIVGG+QSD/DA1LRrMdKHy/hxITmcopGieoFphUNxWCM5yg/6Hkreqo9/nX4yTpVHctvuV1BYmDJq0oHPWWNdYFjIm46VBTVKtjHpn4ecr99ywIMbA74/L11Q4/DsSVw31MKP5QoctdAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmkeG9q/3lcDLQbRuxhRAh+3cD8Eh7B0qPN1ezRjAzE=;
 b=JhYcN+5DEu9o14RIs2Qq7Qort86X24wrrYkxUbCfrufapsPVvI98iXcpjLlhw6t1msYsFMiDgyf1J2OKDMY9VvrGi+g4j59hp1pJ61HGo3ZmL2aEGOZmx51nVql8+bmtXULRacDv5XALJJbGYHdbo0Vj6MS4o3dk8gsmBIaq3VCcR/XZh1+00T/xSpaS3t19KGV9ihiZRagHnoMuruFk8IqE0dSTpKxD7cQldOOHYZc4IsE98sSd933T8kymFpbFG+7bUQaeu377Uo6zEgTVoB7NNLhH6KK/lUECEKfOZ5bM5ei7T2gEzNulDMDA1xlki6hl1KKZ+P91Dyp9oXkqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by MN2PR11MB4680.namprd11.prod.outlook.com (2603:10b6:208:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 11:16:59 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 11:16:58 +0000
Message-ID: <231abdb7-3b16-4c3c-be17-5d0e6a556f28@intel.com>
Date: Mon, 16 Dec 2024 13:16:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3] e1000e: Fix real-time violations on link up
To: Gerhard Engleder <gerhard@engleder-embedded.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <bhelgaas@google.com>,
	<pmenzel@molgen.mpg.de>, Gerhard Engleder <eg@keba.com>
References: <20241214191623.7256-1-gerhard@engleder-embedded.com>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <20241214191623.7256-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5949:EE_|MN2PR11MB4680:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bb534c-c9d4-4890-644c-08dd1dc32821
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXJiVjFTOGNMSW5aZ1RrREFta2JsRjFTUWNGaWRJMWxGRGhRdGluWkV5ZXR3?=
 =?utf-8?B?aTd6eGE2anAwNk9IVUdJc1RoNURjSlRGdnRuUmVONXk4WlF5NUxQT3ozTmIx?=
 =?utf-8?B?c3gxK1ozMWtabEo1MEI0VXdXdERPaTA0ajZJckxQOVJlZ3JCcjRQai9ZaTBl?=
 =?utf-8?B?SG1XNXNpVU9NOWltS25GUFYzUDQ5QWdjZ1JqMERDTHI0NnlDOW1PcFFpczNY?=
 =?utf-8?B?VFJYRnVKN202aU1LZGIzTFYyV2dNZ3lLcmdXalB0UUR0d2s0ZGs2YmkvaTEz?=
 =?utf-8?B?YTJxdytSeE5vMzVqZVN6N0FEQm51MHpxaWZVejRnM1B6MjhEV3hyQUZ1WCtq?=
 =?utf-8?B?L3pSSEVUMjdWbUZzeHFJV1VYUFhXZmJuRWRsdDdaTk5qVnoyVisxQ28wOHRH?=
 =?utf-8?B?WkFxR1NEVnovWC85TkNnTVJ0WmZrbmNyMnRXalVNTThWcEF0OVlpdVIrTkoz?=
 =?utf-8?B?cWJiRVFTZVc3MWlsbDJlSEp2R3Q2NjFLekQ1bGZ0LzNLbERncHo3RmRMSUZL?=
 =?utf-8?B?VDZTRXIrbHdBV1VLV214d2s3dDRyV2ZReDZsWFJIb3NHT2hHQkxJL1hjNEZT?=
 =?utf-8?B?VFcraW1FYWxNOG1nOTJYc2pHL0NTM09HR0pESkN1bUo0REJibUFEK1dad01E?=
 =?utf-8?B?K2lqaGtyTk5XQ0ZKeHZhYS9ldkcwdVJtRTdWZTJqby9DUzhZUk5Md1BWcUFu?=
 =?utf-8?B?RGxBNTlvcWcrQnhZSHh0RUxLcUltY1VqNjN0MFNJbVhpZTY1QWlOanplYk9a?=
 =?utf-8?B?OE9BSkhEd1k5RU1KNVV4amFkU1dMZ3dTMVAyd3BqeUdoamxRc2czTUpVbzBr?=
 =?utf-8?B?OTBBNi8yVHhTTXg5OG5wQmY2TGliZ3IwT3F6Y2I1eTJnelQ5RXRTMXRMOTlo?=
 =?utf-8?B?SVdTQ2JvZHJGUmNkRVV3TElkYjJQeDlPVDBNY3V3WnAzMFNWUnNUM2h0U1ZJ?=
 =?utf-8?B?VGduTVBkWUMxVlhwVVFWN0dERldiZFJYcXJQdmpHbnY4V29HWkxaY0J1Snhw?=
 =?utf-8?B?c0R0YSs5NFZqa0ZKWVlZVmtteSs3bnNQOFZ1TFE2MHJsV1V5TFJhVnRuMlN1?=
 =?utf-8?B?NnlyUUtIbHNzWTBxejBZUEF6dUJlVTVTUWxOTXI2WDk5UFpNU29PNWdYYnJJ?=
 =?utf-8?B?b3JPaUlXZUdEcDdyRHlnYk1VaDFxS3dZZXdoeTlPQjVSeWlhZkp5eER3djhT?=
 =?utf-8?B?UGF5Z2NCYjVYQU1DNGNQanc2dW1TSnpYMXhaWTV6VnlxWis3Ni9lUEVMb3NH?=
 =?utf-8?B?M3lwcHgrMmE5TVIrQmp1M0RRRkRZZEoybVhQdWZnQzRBVHk0RW5QdVp1YTYz?=
 =?utf-8?B?OXl6MlFPaDNvSUUvYjZDWTRCalNuTVFQM0pRU0d2Y0IraC9LTkxIbStzN2po?=
 =?utf-8?B?cDdIRjBqZ0xTWHdyc0szc2wzb2tGM1NXSkxvTlVkcmJ4dUdqVG9lZnRlbUVO?=
 =?utf-8?B?eWExTktrRWpYS2E0RHVLdkh6ZGdwOGZDYmtYVjVmdFMvNmlhNVZJbVJ1eHF0?=
 =?utf-8?B?L2MzRGhCejV2cEpJQXdXUldkNUdqeHVaamJGeHpNcHUzNHJiY29yRG1hNW0w?=
 =?utf-8?B?RnI0L1ZUWHhxN2NVUjFOVTZIS3pjRnBrZVVRZEZ3SmlsY2dtVGl3SE05L3Vk?=
 =?utf-8?B?dEJpOE5qaU82eVhjOUNUTEpWTjRZamRudWN6c294RHZZeGxyZllud2ZEcUlY?=
 =?utf-8?B?NjYvTG1rMkt4UHFtVUFHcGJDS3o2OEs5YnpmK2piU0FzTzY4Q1lEVUJRSmE5?=
 =?utf-8?B?UTBSSGo5Z0E5N0hJenJDcUZQN1lkaFgxVkxTeVlaZFREcmJ2MDB0ZlRmWkVz?=
 =?utf-8?B?RVI0K0ZkMGt2YkxCRThsUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0g0anZYZEdlRHlVREk4NmdLUWp0L2VMNmt4SnlocmI5RkdKb3pnRWQrYVNQ?=
 =?utf-8?B?Rks1VnltS1Nsb1Z4SG5vUDNVTU5RNXpmWTdkd2wyTHBLMHhRd2pqTGdOTFhY?=
 =?utf-8?B?aUJVbklPQzdtbkY0aXNiaUp1QVgyZE0xTDZRZG1ycjRqZlg1ZDZvNDVQWWdk?=
 =?utf-8?B?Rk1NR3o0ei9uNE8zN2N4Yi9Cb3ZQdGRtU3VyampJRTdxa0ZQRE1NSVNBTk51?=
 =?utf-8?B?bHVoNGl3RHJpc2dUb0J3eTBVZGRnWjN6ZFEvRkJtNWpUanZBMGs1cjZ5WG04?=
 =?utf-8?B?VEY3WnlpMzUxK2N1bUR1LzcyZTJDQjlNMlRXMUUwUlFaQ2NXNmlwRDMyMXAy?=
 =?utf-8?B?c1pVRGxZVDJwZnJuVldqOVNwMkl6WUZBcWZDajhiWHUxWElBdkcwQjFQOEVa?=
 =?utf-8?B?WHdYa21HbU5Camg3a1V4Rm1IYm96MUozQWRtN2dSRk9nUGtCQ2VCbVdBMHY3?=
 =?utf-8?B?a3hHSlArOTlWcE5TdVNpV0R0Z2QzWWVmd1pwdHZsNG9mRUFLaDk5V3VZYTZy?=
 =?utf-8?B?NkxsU2diaUJTRXZ6VGZCMGR1SXM3WjVuWmZSRDlNSGhFZGRHZVNRc3FWRWY3?=
 =?utf-8?B?UU9haDMwZVc4dzdYN1d2M1JUdDQwSVlNVFFvSWxxd3l5ek9FbXV1L0s4SEtU?=
 =?utf-8?B?a0UwTnFNSm8zSWpvV2NBbThwVkcvU28rNzFZMWI1WjBKWG9MMjZ6c2dCV1JF?=
 =?utf-8?B?UVJjMGtGTS9hUm85LzNnUGRDUndtbzZ6U002VHVZeUEwSVB4aDhzMEgyUlR5?=
 =?utf-8?B?ZWRZWndpRFA4dDdHUEJmd2F1NEd4TDhoRHlrYk5mQmxOdlVnSnk3Y1EyT0hI?=
 =?utf-8?B?dEs4OTB2SGFYZGdSZ0gxOUFKMk1CaWplK1dVMkg3UzFYL2xwd2FnZUVaSE9W?=
 =?utf-8?B?MTMrTWtIMmt5YjJFQkN3NmJhV1BRQ3p2aDFUcEdQNm9yTUk5VU95WmZpS01W?=
 =?utf-8?B?b0hwK0JLa2ZVZkU1OHdUZ3h6dzVrMktKY1JnKzQ5SlJ1S0xMdG13ZEdFNmNh?=
 =?utf-8?B?eWZENStCcERrSUd5disvN2pMb3NNY3Q0ZFV3MlRFdkYrc2ZWeXJxeFh1QVlQ?=
 =?utf-8?B?ZXFheldwQlV0bTh4bDFraUlhTExMRG5oZ0NZenNTQkI3cUh3WFQ4a25TaW10?=
 =?utf-8?B?RmtpTnRsQUpZZnlQR25taTMzN3grYkNtVnFYcDd6aUNJLzA4ZGVQQ0Zheldw?=
 =?utf-8?B?N0xmMHVSNW5DVkVoeFk3MzZXV200aGpjZy96R0Q0YW10UlFnOEN5czFXSXhH?=
 =?utf-8?B?NG5rb2RvYlhBUnp0UEw4VU9LRlYxeTlVZmZTaTd3QnRwRDlxUStNV1E1NGlK?=
 =?utf-8?B?ZzlNeFF1VHlpZ2h4RURkY2JxUkl5dkw0bG5TdENFNUhKb3JZUXo3dTFFSldp?=
 =?utf-8?B?Tit3WlFOY0xKM2wyVW1oaDlXR2lsbHdOR2s0VkxsdjJTd0d0UWNQTWN1ajlo?=
 =?utf-8?B?UmlLSzQvdnIxN3QyYlZNT0xQblg3Rzd3RUJJbkh4cnhrS0loVSt3RmxKdjlo?=
 =?utf-8?B?RE1rcTcxVkZKbzMwZE5ibkdOYnNtMVEwR2NBZFEvcEdheWh5dHdKNVNCSGxV?=
 =?utf-8?B?aElIWnVLWDVpMVVKVXFuQkZLYmYzc0lnMGxEOXUwZjJnOXp3MjBoa243d0Y5?=
 =?utf-8?B?OW1lRXlSb1JITUNRNk1UODYyMVJiYzRBZmlEeGhVU0NWS3hUa2NLWG5yaGFZ?=
 =?utf-8?B?L1QxMEZTdHB0dWw4Tm1mZW9ya2V1NDk0M0tZNzVZQjVqaGd1bVlaL0R3ZG0y?=
 =?utf-8?B?ejBSYTBFODRqWkcvUXA5OGF1VnlzNDRrOThDTURPZ1FyWDY5aW0zelEzRWV3?=
 =?utf-8?B?akk5U1VoVzE1dVZpN0VsdThTenlLWUdLeWNQNXRsdmNkWW9NTzlZVXpSZmhm?=
 =?utf-8?B?RGM4WXVMay9GcEl3REYrbGpvQmZwZUZ6Y2M0MkY0Q1ZlNUppUDB6U25ldXZv?=
 =?utf-8?B?WWxrUWlxR3B0Y1J2dTZFZStlVW02SjVIMnQ0ZmxzQmF4RHVSR0FLUFBnNytu?=
 =?utf-8?B?aUs1dE1GNDBlOFhRUk1EM01RaDJjN241emRaVHpKNE1na29ZT2Y4NDFiRWVO?=
 =?utf-8?B?SnlVYlplWkRlYWhjaWJRWmtabDJyZi9SZkNtQW53RUFaeEh6QksrMlE4cXdL?=
 =?utf-8?B?MkZSR2Jnbk8wSHN4MTk2ZEJjS0dCSUsxTGtVZk9sQ0w2eEtYQy8yZUYxNllZ?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bb534c-c9d4-4890-644c-08dd1dc32821
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 11:16:58.8578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ou27iF8eswEnHnbdAXv0GbXVPigdPYLi5rccuQnS6oajfeS2HgIaEYYVtn+b9D9nEOzr3Hj4PSSVIzqP82xuy4uWJmatVJBNGVMPTJNocJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4680
X-OriginatorOrg: intel.com



On 12/14/2024 9:16 PM, Gerhard Engleder wrote:
> From: Gerhard Engleder <eg@keba.com>
> 
> Link down and up triggers update of MTA table. This update executes many
> PCIe writes and a final flush. Thus, PCIe will be blocked until all
> writes are flushed. As a result, DMA transfers of other targets suffer
> from delay in the range of 50us. This results in timing violations on
> real-time systems during link down and up of e1000e in combination with
> an Intel i3-2310E Sandy Bridge CPU.
> 
> The i3-2310E is quite old. Launched 2011 by Intel but still in use as
> robot controller. The exact root cause of the problem is unclear and
> this situation won't change as Intel support for this CPU has ended
> years ago. Our experience is that the number of posted PCIe writes needs
> to be limited at least for real-time systems. With posted PCIe writes a
> much higher throughput can be generated than with PCIe reads which
> cannot be posted. Thus, the load on the interconnect is much higher.
> Additionally, a PCIe read waits until all posted PCIe writes are done.
> Therefore, the PCIe read can block the CPU for much more than 10us if a
> lot of PCIe writes were posted before. Both issues are the reason why we
> are limiting the number of posted PCIe writes in row in general for our
> real-time systems, not only for this driver.
> 
> A flush after a low enough number of posted PCIe writes eliminates the
> delay but also increases the time needed for MTA table update. The
> following measurements were done on i3-2310E with e1000e for 128 MTA
> table entries:
> 
> Single flush after all writes: 106us
> Flush after every write:       429us
> Flush after every 2nd write:   266us
> Flush after every 4th write:   180us
> Flush after every 8th write:   141us
> Flush after every 16th write:  121us
> 
> A flush after every 8th write delays the link up by 35us and the
> negative impact to DMA transfers of other targets is still tolerable.
> 
> Execute a flush after every 8th write. This prevents overloading the
> interconnect with posted writes.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> ---
> v3:
> - mention problematic platform explicitly (Bjorn Helgaas)
> - improve comment (Paul Menzel)
> 
> v2:
> - remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
> ---
>   drivers/net/ethernet/intel/e1000e/mac.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index d7df2a0ed629..0174c16bbb43 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -331,8 +331,15 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
>   	}
>   
>   	/* replace the entire MTA table */
> -	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
> +	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>   		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
> +
> +		/* do not queue up too many posted writes to prevent increased
> +		 * latency for other devices on the interconnect
> +		 */
> +		if ((i % 8) == 0 && i != 0)
> +			e1e_flush();


I would prefer to avoid adding this code to all devices, particularly 
those that don't operate on real-time systems. Implementing this code 
will introduce three additional MMIO transactions which will increase 
the driver start time in various flows (up, probe, etc.).

Is there a specific reason not to use if (IS_ENABLED(CONFIG_PREEMPT_RT)) 
as Andrew initially suggested?


> +	}
>   	e1e_flush();
>   }
>   


