Return-Path: <linux-pci+bounces-40154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA4C2E6A3
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 00:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E31A3A9998
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 23:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304472D47F6;
	Mon,  3 Nov 2025 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRWOneJi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C262142E83
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 23:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213105; cv=fail; b=lGF/+8QWOWt8KKnlJBL7oQElejBOSkMw1z9WN8TmBsZ7bmdbU7Yr2qwgBqo8fkwzXS/s8oQEEv/ZNe5Ul3c7n1cvYwlVlTZ6flGB/LB6Xbz4gt21q1IQ7LG5cE3m51wfh/jmKlt+0Qo+1sIAh9kfmpEtcqCj2PyEvB9sZw03GLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213105; c=relaxed/simple;
	bh=yjNqNgS6x0P93WvvGMrdp79VzkXJ9Oh0zuUirbihRrY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=b61P1R5lIwVnZI2rWV04X8CM7FOz7iE1KTS2qeeQrWuOyUBWxSNPemlwiT175ieV+u7zkiKHKpeRRTh54leohcfNhp63ieFnvDt84gQliDP9DKi5J0xvC9rZnY43W6C5+SC49BpWhlnlpaVotGnYyJ7w/DN/63Hyv07NKXM/48A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRWOneJi; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213103; x=1793749103;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=yjNqNgS6x0P93WvvGMrdp79VzkXJ9Oh0zuUirbihRrY=;
  b=XRWOneJispMfnEaS0idZaLqkSLRYfWzXcjPkdKPcBurN8yniFMoKwvEy
   z0nn6fTwHe+Pvgd97HptZGDdT3jU/t5jED//aZigNyjpY0rFqsf/FoRrl
   eyoT/VPT+hnfIPyPT5ZttKLeilMgUNGiwgAN6lcdfPpIZH1UhxijAAoNR
   dncxhOvLvDcXkDckyH9v+z6Qg3Dywtun7+S3qpxGYmulwksK+DsfkF1I4
   r2gEgRHj1xyha0o4H5LNES5F7Vm+5RCxEf2V5qbWKwgZuVvnPHU6fvG9W
   ihKXuXzCvD6CesvcjDs5j36REJ9IELCPSw4h5AGMKSpRT0JckmUsnWLCX
   g==;
X-CSE-ConnectionGUID: 2qcZcwU1SK2t2lB2kSSGVA==
X-CSE-MsgGUID: zkCc1blfQRC7WCwFi4Gbng==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="66912732"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="66912732"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:38:23 -0800
X-CSE-ConnectionGUID: P5aDlhueRXa1grzHZzRCjQ==
X-CSE-MsgGUID: Fex6UY2TT9mtW82Dpmvacw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186677603"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:38:22 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:38:22 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 15:38:22 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:38:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVbucUdglxUcQzlwQ2yuVEWjkte+8VX8QEQa1PZEc0Owge/o9DuwGFA6VsHHjKgpYrPionoMz1PLwshMCe8US5PXXFHwANX1OLm1P2sUE1fJP5ZHwX7G9iiO/U8H+iDEjF4xsYi6ynqotsLHBjkWyVarHH/enkVpVE7yCEQkMZStEHlH1GeiMueSfveDUFG0qqK0qHYXpAhUeoJi4bQxvCTtr+jaToyxg7XjVXugyxkfVEXkguBcN424coSJu4z8MUWYMIFx3mtNe3W9KC4w4ud5/K+EFudcDM1VAbUUSWIM9tYaNg3LKTSIteihbCem9rUk+mjBLN0TpX0h75Sa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2eqc/vQkKzf7Na1V689hd01m4MpTH7kO031DYxk6ns=;
 b=IVr/CQtmW5hXT06ECLP/vFLyMHeuVFE5hOFISjlHhXB0A8OL03nhjE+mQaBMmoOGLkkiSckVGjr9pZHDUGfgM0Sxu5hWscDJoQdvuNn5QvkvWdwI+qG7vgqFquJhhcYdeAI+5oa9qdXA1qQz4ip58uXJyLtE6S8h930RO9jL14/NzmqGY4Nis++IgY3L2AZxmtYwnyn+UF52pnnnUuwC/e2M7fPUbP57+nG5oZRxKb6+dPUlyviiVRuiTx10YYHwgv6l5dOmbcsGIeQh/JfMivrihzoPtBVjZyXnWIVVJjsUTPCWh/wMRwgIR/+Czx0S1nNPBNHs8obQUwEMD/iP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:38:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:38:17 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 3 Nov 2025 15:38:15 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Zhenzhong Duan
	<zhenzhong.duan@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <69093ce7a61de_74f5910012@dwillia2-mobl4.notmuch>
In-Reply-To: <20251030112411.00006734@huawei.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-22-dan.j.williams@intel.com>
 <20251030112411.00006734@huawei.com>
Subject: Re: [RFC PATCH 21/27] x86/virt/tdx: Add SEAMCALL wrappers for SPDM
 management
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e7d464-18c8-4097-af17-08de1b321052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TU8yMWFKRXNoVUVsUkJNSk4rZk9iMFN1ZDJzakl4Zy9vakg4eUVRZXVzcVVJ?=
 =?utf-8?B?UEt5R3lsNHVRUzJ2UlV6UGN5VzJJeXdvbFFzVFl0QTVQZ3RmQ2pJVnVKcEJh?=
 =?utf-8?B?K0ZZamF4YzVWQVNlLzBzSXU0R1BVQWNKdWc4QmVNTlNvaCtka28rSVVlUnl5?=
 =?utf-8?B?dEc3cHVTOWVIVzRNVFV1UWZOMGZ6UkZyeEU3cjdzU09mYWJ5eWR6SkJkeXk2?=
 =?utf-8?B?OVBpdzNPNTg2TEtrQnpla3k5bnpOMWNyTVFTYkd0ekF6YzA1WjFHcW54bFo2?=
 =?utf-8?B?emh6eVVQREgvY3Q5c2JYS0RCYm9JVm5iWUo2OEprYmlMNGJBL2t1bXM5UDF3?=
 =?utf-8?B?dGJqMnlkVlJzTFR1Tnh5a3hsVWx6YWVDRlpsUDhBSDk4OS9rNGZyV09ZMitt?=
 =?utf-8?B?SG9LREJtbTFGZXdBaUpDYTM2eUk0Qk9OTkJrZXU5dk9VOGlkSzFqWlJwSVli?=
 =?utf-8?B?d2ZvZXlDZ1FtVUdPc2Vib3hlcDJwM0JacjRzR0RhQU16bmRHOTJwQ2pCOFpo?=
 =?utf-8?B?cC9zbERmWXF4TjVGRUIrOFdiUThVcHEzYkN3eWVBRW1qanBXWi9OK094d0cx?=
 =?utf-8?B?WWV0QW9UQjRnVW5mTGNwTVNVdzk5bWJXMjYwZE5XNEVVRm1XNGhQRTRXakZt?=
 =?utf-8?B?cXNFbkV5cytXUXZrV3RLd2xxOTBqanBWOFA1ck5IWVJ6aVVZYndxODJ1MVZM?=
 =?utf-8?B?akdwUnVOZTYxYmJBbXExdDA1dm9hQi9WL2NWOTBkc1EwbXlIaUZTK2JKKzRN?=
 =?utf-8?B?SWlCbldCOTJwdUxxRktNbnk1cEVSWTZ5SS9sSmhCRVNLTjRWZXFpM0tzL3NZ?=
 =?utf-8?B?SmVVM2s0M2RQeVFrRlUrUHpTNHZMVCt4UnZKVGdEcjNrSDBkTktuM0RKZkxw?=
 =?utf-8?B?bjFaT2g0NjBQYURzc1hXNFozcTI1Vnowa3kxZW40UkpHMFp6amJySUc5UTJq?=
 =?utf-8?B?RHloRnVLcVNXU0tCRm9qWVpxMHpkL3RZaElhSEhoYTlZS01rNTZRZWxHQjBF?=
 =?utf-8?B?aWlnVGRFT2Q5bWphN0JNNS9pajV5bFFQU2tHY3RmMEUzQ0VnQ0NFNGl4VlNr?=
 =?utf-8?B?T0swUkNBaHZoWSsxMm1xdkVhaTJNYjJCYjJ1OVZ5ai81ZDBKTHZ4aDhKYjVo?=
 =?utf-8?B?aGNOamVtUkRlcnhmdkNRc3J2eGNwL0VVU3pqbnc0ZjcwbkU1bXFIa2RQZjg5?=
 =?utf-8?B?c08vU0djbDlESDdFRHpGWkZVSmUxVjJIVHM0bVRhYS9UMjhwdTFJUlQ4RWtI?=
 =?utf-8?B?aWNFTTVkK2pFSCt1dVpuY0d2Zmw1L1IzSDZKbW55a295bEhNU21GRDFFR1hp?=
 =?utf-8?B?QXluMGpKWEtEaFZFd1k1RXhTbEduZlYyZUl1cElRaWsvY3VhVDloUU1wdXFL?=
 =?utf-8?B?M29Yb2JFOVVmbTg3UjJHYXR2UEhydGJVRmFIQ29QZEYxM2k5aEcvNWE3Qnhu?=
 =?utf-8?B?RTVwL0M2cTV3bnhGdlF2eFpjTkhSalg5YTczbmZnZ1h1T0hZcVk2dVZDalBX?=
 =?utf-8?B?OGNtc0k5K1M2NDdMdFFIYWlMTG51bjN6dmJZaFdNM1FRWGhySEViVW5yeEZJ?=
 =?utf-8?B?UG9FZjhrZUZrSjFZS0VHVk9zYm1xSnR2QW5KR2lVUlRhSUluaytMbW83Uk40?=
 =?utf-8?B?RUdwQmdMUm5jTFE3cnVEalAxS1FjYVNubU9OdHVIdzZTQzgraGphQVpQWUR5?=
 =?utf-8?B?ZUtIVFJEazZqbE4zbFJpbE5HNjIwS1ZYSlA4OE0wUGc1ODRpMGxEVDJtdUl5?=
 =?utf-8?B?N1BSVGVFOCtVRll0YUJJbHJqWG1ZRzZwWFJGYWVNNmNPTE1ndWM0TEp0aExK?=
 =?utf-8?B?OTgxczA4Z3NiME9qZFJQZHZlbklrMGtjbGd4Y0syMk43ODYyRkUzcjBaRU1Y?=
 =?utf-8?B?enNWVWU1aGtnMEhuZmkzdUZjM25tY09JK1RLRUNCNmt3TVh0ZmZ1WHhlZmth?=
 =?utf-8?Q?HbewTGutMLuz6vohcNmx/nCw9pPIr5A3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWRKWmovT1lodGl4aU9tMDJCN083RUdEemsrdzNTaEZoTTRyYWhta0ZLLzNl?=
 =?utf-8?B?YTN0OG11ekZPSU1aMDB0dkovR0V6dUtIVjd4cldvbUs4QjZQTGFwS1Bza1lo?=
 =?utf-8?B?V0t2eFpBb2MxRzZHbEx5emg5Si9rV1dYUXVzT1plTzd1QWFZMEFIblNsUktn?=
 =?utf-8?B?R2FBREdMTmUxcm1xc1B1Zm4zd2JzVVQrbGFKQTJCaThxVS9CcDZXZUMwWWpu?=
 =?utf-8?B?ZzBBNEFxdElmYkdtQzQwakZWZ1VJK2xDdGtKWFFpQWpnZmlNOGRWaUlFMXFu?=
 =?utf-8?B?T2cyV2VhQnlJYUJvSTB2eDZzRWorUUVxK1hsbWFsMW43YThKNTlMVlZCTUl4?=
 =?utf-8?B?QTR3eW9SZVUxV3gzeTVkc3QrK2t1K1JyRlNEWlEzSzdtM1FBN0pudEN6UGtj?=
 =?utf-8?B?cjdLbXVJYzdkc3lKbm92MUxCYTFqUkJhN1N3MndRVEtnR21Cb1k1bnZoZWJ3?=
 =?utf-8?B?eFNpUXVlZlJzeVVNUWhVaHNGcFVPeDg3bTZRKzVFSEp1WGpsT3NNVTJHNXpZ?=
 =?utf-8?B?d1NkVW1oUHM3S3FTdmZ5SkxWbTF4QkVKaHh4RnNhTUUyWXdHVllvV2xyWjI4?=
 =?utf-8?B?bitqT1JLc05rV2c4cFYwTll4bFFpK1FPdDJVYWtSN2xpbjNXMC9DbU1sR2w1?=
 =?utf-8?B?NlpEUGlkTnBUK0xma21Yc1REMStZZEZudXdYR2ZDbW1ZcER3UjNiQk5CMFdQ?=
 =?utf-8?B?T0hPTGJmY0t4cXBDYk1SZDA2d1MzdmtlUWtFaThOazhNaGlQQTlCRHV2OEho?=
 =?utf-8?B?VEF5QXl6bGhMZGc4ZFJua2I5RHhNUndqajV1RzhoVWFkbElCVmpyZnJwc3Zu?=
 =?utf-8?B?U1MwbGE0M1RXUE1zdUF5VlIwcm1aSDdPRFJMcitEWkh1Umw0cTR4ZUFSZFp4?=
 =?utf-8?B?UWpsemp6cC8vak5QbUtxczBEVzJkSTd3dlhKbVF1eEw4SmQ0TTF2RHNWMlI2?=
 =?utf-8?B?OFZadHZKR1F0U1dZQkNOVWFkRU8zVjNra1lpUmNNRVV4K3dUQWpBYTNPZjlX?=
 =?utf-8?B?MitsR0pLbkVXS2RNTUluRVFXby9Rd2xXMzFBYkt0ZkE4bC9XMXFPU3VFQno0?=
 =?utf-8?B?bHE0MUQ3Rmo4TVZIWklNTHFpQVQzN3dzRkRNWDA3Y2FwcUM5OHZkck45a3Ix?=
 =?utf-8?B?a2JMOGJMZFZSZGw3R2hXR25hMllMUDZvejNkVDFsZU1KSXNESngwbXlUbUVZ?=
 =?utf-8?B?MDNVRkFvUmJtVkNWcldMdGkzaFpZZFZnNXVlWGlYcVlLaWU5ZWE5VE1nRVdS?=
 =?utf-8?B?azlVVkNLVW5Dbm9mU00yNUloYTdiQnFWWFcvT056NEp6dTl0MHFYTEsramVI?=
 =?utf-8?B?eGlaUXNEM0tXTlhJRTJSbEoxVGdmRHFEZE1LQjRHVnMraUMwNjhzM3JBaXVQ?=
 =?utf-8?B?bllKbnVCcUc2Rzg1c2l5M2hlckNZVkRPQ2h2b1NDVm1sZTlHSTN6LzBGYkVO?=
 =?utf-8?B?VmFNOUtiRE82dkNacWl6MExSSEtXNVBiZHhYK3Q0SEc0aFZiUGtUZ29ZYnQ2?=
 =?utf-8?B?MnpzaGp4NytZTGtZeGpzRjV3UWpwaWtmU0cxQ3pqS296MTZXQ3B4VTZqTElm?=
 =?utf-8?B?VEtSM0J5dUZRK1BxV2YwMU5KU21rN0pZOGRlb1JTYzROWDBGeDdlT3lKUDNr?=
 =?utf-8?B?K1lDbGwwRzh0QXVadWMySUF0UlltVHR2TnZyQmdoRXBGdlZjcVVVaXRHdnBu?=
 =?utf-8?B?SlkxeWlpNUczaVhFTVdYR1FGRmVYZWRmWlhEVHd6OExQaDA0MEt5TjVOa2pp?=
 =?utf-8?B?aXZDK2FBZThvS1UxR3J6aEw1cjJRTHloRUp0Q0NkeU1tTnBuekswVGVhT2FK?=
 =?utf-8?B?aTFXRmczQmtwVXdtRENXc1l2c21yMXZxV055LzdpSmFNVTdJUUdXVGpOZlE1?=
 =?utf-8?B?bjJPeHRKZXI1aFFkWGVVc2VOVmNQRUhQVU9XdmdpTTBDaXlJZ05LN1RibkRm?=
 =?utf-8?B?ekc3c1lWQ0RMcVVGNFNVdFNhY25Xc2NCaGtMWmR1TGRtaTB0c3ZtS0ozM1JB?=
 =?utf-8?B?Y3R0bXMrTzYyU0RDWVU0clkyZVFCb2dyVG0rRnpQUVg3OWMvKzdZay9sSVg3?=
 =?utf-8?B?VE03Q1hlRk1SM1l4OUYvVlN1dnFrZ2grRjJUcWdCNVZhYStabUJIR2NhZVVU?=
 =?utf-8?B?RWg5ZGp5cDBDeFJlSFdSNmxXMHVTVWVEc2ROVGxYRnhuckRwYTBNWTZXVE9Z?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e7d464-18c8-4097-af17-08de1b321052
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:38:17.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukZacpG2GtQkRkdFqijXNMbZSYVe+INiJCfxC8tro49fubIFpWqRU8YR9FMUbdBTfNaAoTL06+VPyT18q+Fy2pGj1zlJyEoBfZTIgrlTUXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 19 Sep 2025 07:22:30 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > 
> > Add several SEAMCALL wrappers for SPDM management. TDX Module requires
> > HPA_ARRAY_T structure as input/output parameters for these SEAMCALLs.
> > So use tdx_page_array as for these wrappers.
> > 
> > - TDH.SPDM.CREATE creates SPDM session metadata buffers for TDX Module.
> > - TDH.SPDM.DELETE destroys SPDM session metadata and returns these
> >   buffers to host, after checking no reference attached to the metadata.
> > - TDH.SPDM.CONNECT establishes a new SPDM session with the device.
> > - TDH.SPDM.DISCONNECT tears down the SPDM session with the device.
> > - TDH.SPDM.MNG supports three SPDM runtime operations: HEARTBEAT,
> >   KEY_UPDATE and DEV_INFO_RECOLLECTION.
> > 
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 0f34009411fb..86dd855d7361 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -2390,3 +2390,136 @@ u64 tdh_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
> >  	return seamcall_ret(TDH_IOMMU_CLEAR, &args);
> >  }
> >  EXPORT_SYMBOL_GPL(tdh_iommu_clear);
> > +
> > +union hpa_array_t {
> > +	struct {
> > +		u64 rsvd0:12;
> > +		u64 pfn:40;
> > +		u64 rsvd1:3;
> > +		u64 array_size:9;
> > +	};
> > +	u64 raw;
> > +};
> > +
> > +static u64 hpa_array_t_assign_raw(struct tdx_page_array *array)
> > +{
> > +	union hpa_array_t hat;
> > +
> > +	if (array->root) {
> > +		hat.raw = page_to_phys(array->root);
> 
> This is confusing me. I'd be inclined to set hat.pfn with appropriate masks
> shifts etc.  Or just do it with field masks and FIELD_PREP() etc

Yeah, its a hardware-ish ABI should use bitfield.h macros not C
bitfields.

