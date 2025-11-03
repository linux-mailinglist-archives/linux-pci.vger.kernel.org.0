Return-Path: <linux-pci+bounces-40151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2007DC2E5F2
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 00:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1732189571C
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 23:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51092FD669;
	Mon,  3 Nov 2025 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxyfUu/L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250572FABFF
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211108; cv=fail; b=fgy8ypWHICLteJq6217lwm2AvggAgj8ajJNLIMdkOBrozK6T2hRgIj7t9i0MZCP7Np5Pf5u0TwIwwS6+WF6TZ7P61ylGV890woLyAsjw1F5096lWwvpAeKKe+WJDDfUPgszWl3VNT5yOengfy5wlc6ykH5bk8DVZtxD/FQ44DKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211108; c=relaxed/simple;
	bh=iJQK+fyP8Au46U2nVf+HiTSiCP6j4Ctrsu+3vsMZsc0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ieHPEa2xfEkvfuwPTzbhRif032Ja4mlpaVKRq2/KPh/LtVUbs7zf1Q88BEnf4coQh7dXdQj4BVPk7+cn19Gelxgl3jLGK5qnD4SpZpmod4B5nUp/t6xWr7MVg9SJJqp7nkSbgNh7s9dBCo4H+n1fjNRBq0ZFhQtIhD2HJLd4ZQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxyfUu/L; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762211107; x=1793747107;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=iJQK+fyP8Au46U2nVf+HiTSiCP6j4Ctrsu+3vsMZsc0=;
  b=GxyfUu/LzSO2WlPCEGcuka/sLjSeSYPFWVzkM++ABnA6vymmvojtCDB0
   80/BTs5RU0hOfw+vzxLvNrrJB1TH6ipd5UafPIUVPGQNHkJd3fuMIwkds
   cT95GGvR5KXUX0UtEIv0iGWWauJwfMWKQMHufjtQ0sYe4SBM5j3rEu/EA
   zuRMplTJpuaDABUR4j/La9HEPno/tZ5L3ORucuc38NEBFGd76Y+pGmIrC
   uUvhmS0jOuREqOJWbdao6EWyl4egOZD1ElUsL8RVY0i0Hv2LaDsWqkzkT
   uCkWJZbvXeSfT+3fX0ZdzwNW3aw4y7r8ef2aNHHQt5nMhFWA9fd2kNzIP
   w==;
X-CSE-ConnectionGUID: 8VNKOClISVSrxrYzVENYOg==
X-CSE-MsgGUID: kg7CzQcnS/S8ummtWza+BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63310378"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="63310378"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:05:07 -0800
X-CSE-ConnectionGUID: M0yXGW2WSn6HBTgPS5AAxg==
X-CSE-MsgGUID: Y0PMoSmBTu+hExvGIpMrEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="187712548"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:05:07 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:05:06 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 15:05:06 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:05:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdvkwrz6/XWTSTxj5h0+h4T7d32LNtKGoNzC63QZVB9ASJjDCKGZTpejdvwzTVwqnsw3vCR1VEnlFNi0iRWutMFhYM0CawevQuFUhiE/TzaufuhxiMPIXhazz6My9s9FQlaPbFgnc86tm+OvUU6s2htPIwOXnCjIp+iCklIlFRy5K6sjS93fDzQ7hvucQ60lRDAjaSjoYlV7BU2UsDORyEfhprybfYVkmNW473hQtxFwuzfwI87hd1FopLkEF9QfSJc2GbTlX2B3Fbs0KV+IyAP0wJDSVC8TMPm0myQID1Vvsd5AkMGH+Ecfkq5T40VjEIfuZ78NND8Q4xLeY52bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPJvbY71BUIW6SZN28QfW9AQBZZ32lpcW9NFcosKr/s=;
 b=PDFyZ5QeiruGIn1zbAxQYXwIE9WwqKz3z8Q9hbgpjNMuI2MVV67xdgh5BIrrmsnXYY/ARMuI7XwQ0jK0t2O8KFWZsTCQPaR8cxUoLdlzKMq6CQ/X9Pw+UJkDnib+yXIlxzLXL8rlt2LbYdr1+kYOi+xg6IO6misV5pE2U5DRrslLc8OuYBn7/rA2+RgZBmRRuz7XCMNvfnXDNHGSpH2pusFh0F0aA2esHVBSh/XEsAmyF7P4wxZ5wN1LwT6rFe+Rjs1u2yHj2r5JzdODFzPUeehpmXtm+dypWYpA8DR8fOj0lLhOrn2psf2oGSlbYwoJvYPU4YUgw/0dDFIqh4nfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB9130.namprd11.prod.outlook.com (2603:10b6:208:56c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:04:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:04:58 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 3 Nov 2025 15:04:57 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <69093519763ab_74f591008@dwillia2-mobl4.notmuch>
In-Reply-To: <20251030103131.00007678@huawei.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-4-dan.j.williams@intel.com>
 <20251030103131.00007678@huawei.com>
Subject: Re: [RFC PATCH 03/27] coco/tdx-host: Support Link TSM for TDX host
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a07f0c-18bd-408c-e80a-08de1b2d6957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3pReTlYcmtLclJFK3A3d25xa0txS21jWFVWc29jajQvSmZKZnNtUEtaSjdP?=
 =?utf-8?B?ZWJValdsM3o0Wm1tNnBqRkV4S05CWGtTeGtzWFg1VW5qcElMdnFrb3hIeTVI?=
 =?utf-8?B?UzJqWUt1VTUvcWRXNkhWQVQzR2EvcEtlN2ozVDNQTk9xYnBhTUJRNmRvcHph?=
 =?utf-8?B?cG9sT3pqN0ZPdEhFeWR0Y05OT1h0Umszd0lVTFpBZXZpOFBuc216WWJJd3VU?=
 =?utf-8?B?VEJFcW5jaDZJaEJkVVcwVmo4NjZ1ZXBVS05Rc3pCUSsvMTF4UmQxbjFCWVdS?=
 =?utf-8?B?RU41cjVQeUgzSTl2bkZBVm5OUFBUclpkZ0dwZ2x3czlMZytmTllwR1lidysr?=
 =?utf-8?B?OHEzUlRCTzdiWGFMOGFVYVN4WktlWGRGVXlHMjhYZFliZFlpNllyOEtmVUkw?=
 =?utf-8?B?SDlqS0lEWFhVczhaWUhFZDdyVG1jNDN5YjFMQ0pnTmUrQkN5ekV6dS9GaWxJ?=
 =?utf-8?B?L0VIYWZaQkhhNU1IVTBocUxnRFBmeVd5eUR6OUZuWWhFOUV2dlNQdjlXWEtT?=
 =?utf-8?B?MGVwUWIwdHFIanJNZmhpczFtOGtYN0JXYXBxVzBhdktLSkpOSThaNkJUS0dP?=
 =?utf-8?B?bUs1RGtQSHU1bWQ1WTJFRDhXQzJhdUl1UlJPbkR4aEZadjRqNkdmaWtVRDd4?=
 =?utf-8?B?ZXlCODQ3bnNEb0RzM29jRHFJMlYyZWo2aWJmd2MvS1BZRzRMVTdFRWVLZnJB?=
 =?utf-8?B?VHJJODNMK01iYndqWG9xdy9GWGdFdlRBZUhvVUVINmErM0doaE5jamdvWm5w?=
 =?utf-8?B?M1RGZkdwZjVrYVpLaXJEZE40Z01BOGxuY2EwOTVxenZubWNuMkpza2NENk5R?=
 =?utf-8?B?a2ZKUHljVkNzNnN2Qm9Kc0ttSStIMnJidndIeUVWeWpzRXl3T0RWQWFvZmhx?=
 =?utf-8?B?b1g2MW1iQjRsZzM1aEZGWjBCU2xTS1o3MTBnMC9PL3R0S05mU0YwSTNGMDdN?=
 =?utf-8?B?ZTQzcUVicFNIM0U4RXcrdzd2aUZNMjhsVEc5ZXhZcFlKZytyK0JjRjk0RVNQ?=
 =?utf-8?B?ZERSSWVMQ1U0eFZNWHpyTWNmUnl3bGx0Mm1VQmVYdTVidlZEU0swMVZ0NytJ?=
 =?utf-8?B?ZjRJTEtSQUMwYThzZUVpRVZyRFB5MGcwY3JwcmVOU01ZZis4cmlmSFFDV0dE?=
 =?utf-8?B?UTNJZGg2M3VySENNekM1L2RBMFZmWjFFSDlwWVMvS2pDb2ZiajhOeU0vOEYw?=
 =?utf-8?B?dVNOcW8zdTZ0aFd0WCt4djZtNWIxUmp5cGtWQnRLaEtxVEZLbytiS2VwWkJE?=
 =?utf-8?B?RlkvT1FPRTNxaFlHeEd2aTFIZGRvS3Vpdm9BNEZObDdadTlyNFEwb00zOVIr?=
 =?utf-8?B?UDlua01QNG13eGFWamFvOU9vUWMvL0l1VDY2ZitEeXpyRUc4QXZMd25YNVZO?=
 =?utf-8?B?SW9oM0ZVRmxmN29yTzBmZitPZWxPdUhzYkhmUjZDbjhyN2ZERnh2Nlg1ZnRI?=
 =?utf-8?B?UHQ1OXMrbzJ1TXFDVFZNNlFGVE5QQm5leFhib1BkTUdJRlB3TklLdG1Eam14?=
 =?utf-8?B?ZVBIUkFpTWRqbTVJUWxXK1lSeVVETEtqQnVOQmxXZjBjR2ZhTk1YQ04xSTZL?=
 =?utf-8?B?OFlaSCs1SE1pTm9YdEpmcmJMb1BFT1JOQ0gwRW0yUDAzaERWTGMweFIvdHNj?=
 =?utf-8?B?cFQzQU9qYTJrdVdXcElDeFBUQk0rWTk3V3lNN3owWnlQRlZ2RUFXeWlxUUNu?=
 =?utf-8?B?Vmtvejl5ZU5nSVozL2FzLzEyYW5tOVNtdEw3T2hNcmFndUxJNDdhVXNHempq?=
 =?utf-8?B?VnpLWFJaZGE1ejJKVFBCb1BYZkhQWjgvRnIwSGxZc25yc0ZzTGRWOGdIb3lp?=
 =?utf-8?B?bXdBcUt6Mjk4d2pRMi95RmFrcWVaSVhQb2Z2dmVBVWVKZVQzeEFCL3Jpc2s2?=
 =?utf-8?B?cm1ycisxbmY2Slh6ZkNtRzBWRVlkdjRxMExlcWd4Q0R1cEhOUnZGMHJYTUR5?=
 =?utf-8?Q?LuR38rAR3tQXi8KKDFYCXrGlMX7mIHxa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGc0bXlKWTlDRWkzVDd5SndtVStERDNZdzZkb0szM1h4NFMxdjNsMW40VEdn?=
 =?utf-8?B?d1R6UEpYRDFpVlZNbkJHYXd0V0pJaVJNZmU3VWFSMXlOeWE1cDZ2WStEeEVV?=
 =?utf-8?B?UWYzM1RLdEFna0VNdkpuUDYxeVU5NFFjdGR2OUl3NFplaDltd0pEaS96MGw1?=
 =?utf-8?B?d0NSdytFRUNRWjdINEN5c1htNmYrZkpSdTV5ckFBSlJhT2JVUk1VY1RqdDky?=
 =?utf-8?B?TC9JQUhJdUVnMi9DUnpuWjhldVZNOGNnN1BsUEd4Z2hDRDhJV3lEL2lWTk4x?=
 =?utf-8?B?dk9GaWEvQXNqbW8wTjcrbkpYaTdHK1RiWUE5YVgwSkpaKzJpSjRwUDdQVTBv?=
 =?utf-8?B?TkxjTDMwekNtQzVQa0xmTHpXOHVxcko1UmpDR1hieHFrcE9NU2prRDNLN3BV?=
 =?utf-8?B?UGtabld0dW9vUzJCektQb3FVQXFqWkxURVVwcHUySHhoUU1FM2lkZkdIYk5K?=
 =?utf-8?B?akdPNXgwLzdneEx4YXhjblZYelV2MWk2MFhnbUVKcy9LT3IvajBNZ1Z4ZzRI?=
 =?utf-8?B?WTBnazZYUk51UWRrQktMWTFXdHFvY0JMQVNqZzBOcVUzazUxaU9QcWZSODBt?=
 =?utf-8?B?cmlaNlpsdlpUZWpSR0NTY05jZ3ZRczB4b0dLdG9xbXlKZGxtUms5TmVKQ01Y?=
 =?utf-8?B?WU5ZRlFRdGJkSTZxZ2I2eG1wWkZ5YzhWN0JaRnRjOWZuREpvUVdYa3lQOWxv?=
 =?utf-8?B?RnpCSmZWN2IvZjFOT0l0SlpabDRhUSsxZWpOTUptUVRLVW40NU56bHdxSUhk?=
 =?utf-8?B?OElvbEMxWVR3SVp1RVBBZnpRbGFaajdFY01hdXAwaHl4VllCVE12cUc4YWtn?=
 =?utf-8?B?UnVra0J4ZzhIdlc0UWpxSnkvc0xnSUhLSnZRckIza0J4NnZhdVdKWjdKMlZk?=
 =?utf-8?B?NkRyV1pBQTRWdjlRZ016VkNETTBRRmtkVW1wSm54UXZMc2dsOC95R1huM2c0?=
 =?utf-8?B?ZCtaWDZwb201eDNhay80a3BPemtCakw1dWJmaDBZSSsrUWZuU29TTGlDSHc5?=
 =?utf-8?B?M2ZLeG5vem5KREdVOUU2ekE2MERZZ2ZvYUI3dGI0KzRPZkk2REgxSEp3a01Z?=
 =?utf-8?B?dTVTeWEySXBlZ2dPMHVWL2tRanROVUZYcmIyVzN5cEtpeG9abFN5bXZsUDJv?=
 =?utf-8?B?QWdqSEdJN1c3bWFKNGY2K2FqODBRS3pGWFhsNm9CeW9rb09SenNjczN4aWNT?=
 =?utf-8?B?b3VQc0lBTzVsZ0Fia3VKb2t4b05iSWo1OUhsMko1R3lJa0RMWWJ3RTlqbkJE?=
 =?utf-8?B?TWJjUVRYbUdiVHJOa3pTeW9CbytMY21QTjNiV01zYkE1OUkvUk5TUFFKb0hE?=
 =?utf-8?B?VWRHNzRMK0hNV0NMUWlsLzQyUUpUODBUY2dkUkZNazc1N1gzaVR6Z3R3eE1K?=
 =?utf-8?B?NWZIbUQrZUVIY3lNcnliMDFSWktlbEJzVWl6bGMvQ0JRZzd2OVp1d1AzdTZv?=
 =?utf-8?B?blpHMWgzKzMxZmkrd2FLTUZOa2c1c0RhQ2poNnViYTZYZlI3Z0ZyQmlLOWU1?=
 =?utf-8?B?a2U3cEllczVIZTFiWnJ4TFdqV2ZET1pkYmhlU1RqeFY0MitQNjRZcnc0OG53?=
 =?utf-8?B?QnRZTE5NTUYxRGppNVlYWlVhdU43RnIrTVBwMUNwU1BlZVlMUDdqMWJ2elVa?=
 =?utf-8?B?U2tHSzFnUER3OVJhZTRtMzFkdEwvK0tpdU1IbGtGcVc2dU9acENjSk04WXR0?=
 =?utf-8?B?dDdEdGE0dEJpZ2oxZUMza2I1TE9TaUNHUWF0Z0lOTjNJRXdPSW00dHFFTDNX?=
 =?utf-8?B?QmFkbWhZRGV4Z1prdm1YWEN6anNlU3dHL0xsZkEzcVA2YTFXeSsrVmhtMERh?=
 =?utf-8?B?QUo3ZkhmZXNGVUxrc2tDb003NWhsQTNMeG9oTWpERnVITGdQM2hEcGEyNDFP?=
 =?utf-8?B?aXRmRWhabjJ3cG84VHVmZHIrRXFrSjFFdjFsWDRJTzlvVnRtRjV0bWdIWFVI?=
 =?utf-8?B?dHRjQmwwL3ZzZjlNV0E1bWVodUp3TFpMWnJ6SGpiL0wvLzdJWWFSRTV0UTJC?=
 =?utf-8?B?QnZtcjZWcnNhUnBycS9XU3h2Z0IwU2QveEtvd0RyTjR6NThVeVFid3BuZkdW?=
 =?utf-8?B?SXQ4Z0NkOUdLMjh4U2lCbHJIcTFwQmRSZnpsMzZDaU9RWDVvWVlMU0tHVW5m?=
 =?utf-8?B?RkdRQ0taOEIrVHFIWW9vQVFpa2haTlpBYzBzZVJ6L05uZUhvZ2FLcllweXF4?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a07f0c-18bd-408c-e80a-08de1b2d6957
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:04:58.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcxrAanu/0yoScS1HnpCw16jAQ319WlAmN8J+8gfomGuvmeiYqgIIXugkfS1cYSvYpjIe/9gq7l/es5T57G0nzP2CFzSgN8RNvisRCt1e10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9130
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 19 Sep 2025 07:22:12 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > 
> > Register a Link TSM instance to support host side TSM operations for
> > TDISP, when the TDX Connect support bit is set by TDX Module in
> > tdx_feature0.
> > 
> > This is the main purpose of an independent tdx-host module out of TDX
> > core. Recall that a TEE Security Manager (TSM) is a platform agent that
> > speaks the TEE Device Interface Security Protocol (TDISP) to PCIe
> > devices and manages private memory resources for the platform. An
> > independent tdx-host module allows for device-security enumeration and
> > initialization flows to be deferred from other TDX Module initialization
> > requirements. Crucially, when / if TDX Module init moves earlier in x86
> > initialization flow this driver is still guaranteed to run after IOMMU
> > and PCI init (i.e. subsys_initcall() vs device_initcall()).
> > 
> > The ability to unload the module, or unbind the driver is also useful
> > for debug and coarse grained transitioning between PCI TSM operation and
> > PCI CMA operation (native kernel PCI device authentication).
> > 
> > For now this is the basic boilerplate with operation flows to be added
> > later.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/x86/include/asm/tdx.h            |   1 +
> >  drivers/virt/coco/tdx-host/Kconfig    |   6 ++
> >  drivers/virt/coco/tdx-host/tdx-host.c | 145 +++++++++++++++++++++++++-
> >  3 files changed, 151 insertions(+), 1 deletion(-)
> > 
> 
> > diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> > index 49c205913ef6..41813ba352d0 100644
> > --- a/drivers/virt/coco/tdx-host/tdx-host.c
> > +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> 
> > +static struct pci_tsm_ops tdx_link_ops;
> > +
> 
> Why is this needed?

I think Yilun was staging some infrastructure early, will clean this and
other stuff up for the v1 posting.

> 
> 
> > +static int tdx_connect_init(struct device *dev)
> > +{
> > +	struct tsm_dev *link;
> > +
> > +	if (!IS_ENABLED(CONFIG_TDX_CONNECT))
> > +		return 0;
> > +
> > +	tdx_sysinfo = tdx_get_sysinfo();
> > +	if (!tdx_sysinfo)
> > +		return -ENXIO;
> > +
> > +	if (!(tdx_sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
> > +		return 0;
> > +
> > +	link = tsm_register(dev, &tdx_link_ops);
> > +	if (IS_ERR(link)) {
> > +		dev_err(dev, "failed to register TSM: (%pe)\n", link);
> > +		return PTR_ERR(link);
> 
> Might as well use
> 		return dev_err_probe(dev, PTR_ERR(link), "failed to register TSM\n");
> as that will pretty print the error for you anyway and saves a few lines of code.

Makes sense.

