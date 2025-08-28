Return-Path: <linux-pci+bounces-35068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F217AB3AD54
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 00:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1757F1C860F6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 22:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E702D060B;
	Thu, 28 Aug 2025 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+2wdFgJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C542C3770
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419257; cv=fail; b=X8HJcPZ+tqEnTSOtRZ9Vfu/0SIMzBfNChpfHb4nEQwvYXvA9ptaG5OzhTh8F/7YtS2pAHV67polDVMQFxN2tDjSU1oOWu8XaXbIj+N8l2vIIFp1OrQScF8e7e5tI5O9vbiwhtDAWKn4fq7CnI3ANYHBT6cC7ayj5XJ01Qo4zBFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419257; c=relaxed/simple;
	bh=EWHMAnFg0JdC1JvFrP4W0USO2W71LCNKM3T7CXhiWy8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=kPF3ANQCwKorSAgOgDQiWSllyrW/oZmfS2kWQ/J0XQwBJ24tmSoq/talmLxI8y54nBUcQbAmPmqljcjZ/QpOVcR61VtFDSEZDVrw9pThmp9FQl1YOkwSzk/rif4yxLTiNFyNPXykOR/AxXemaWRx2Ge0/5ZGO0pF2aL0pmR32Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+2wdFgJ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756419256; x=1787955256;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=EWHMAnFg0JdC1JvFrP4W0USO2W71LCNKM3T7CXhiWy8=;
  b=b+2wdFgJNef978vRM988Eb5+piN5BviYIImniO86c1TK/XL2mMOmPFrn
   +WdQmKMWNYu3SQubowMQEaTu/0FFhXk72AK+nUIxkOHpRxLRxsfFTxVhH
   JsePKGHY+LHF54Ajhdtr8aD0oeXu5L6CTEkW0Sa/Nt0lEPI6uX08k6quZ
   yRuMCPuQHT4XQ3/R6ZgkcWdGIH2QjHi+7mVHq6nQO8XerrTiA00WCJlHt
   B+XJTmphAFCNs6vetAJzQ871AdP88sR5YGeD5sLsSbQ3TvuWnnBgTMwck
   0h5kBEGZeg0aT4w1Oq2NGl9PKid1S/Sp2I1T2uOf7YYO/hGtWct3mSTq2
   w==;
X-CSE-ConnectionGUID: 21OeBs1STnK0qUIJOXVvkQ==
X-CSE-MsgGUID: ab8Wz5aXQO+/LHFkZfTdTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76302485"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="76302485"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:14:15 -0700
X-CSE-ConnectionGUID: S1CqSyRER/S/OW1rMg9Q+w==
X-CSE-MsgGUID: qh5/lLJ8QQ+MLEE4PSQlpQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:14:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 15:14:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 15:14:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 15:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Enq2AUtX7TFdkDMWafNytG/AF+Df0AEIt9OeUpgbprc2YPcfzSaS1Dw/gCP9pNPugvuVFaqikgSJ1VdFG7iYhF9Qc+k5ZH7J+Yc3Feqstx5XpPeiLMooXdcBc/RiHaCUpwaZ/RRXyPyRwRQZSoDbNhw4q7OXFbed5AOASRO78HI/ctU8EWzZs0hh3hFRHmxx+gr/iZy49QNkOaK/TuI3gmbC4IEPMC+pvzsKxE1glXODz7JGc2LhyZA7hJz1qVwUR9zoVIeBRfoCxJk0NiKCgTXszEYSt7cogSiKJNyevTi2YILx3RCG4eun58QBEtLR0nSDIBvgkEgiAqFY1XzKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQirCmt1nFtzPUYmKL2nGuXCRJ0OjX7Y9Azk3nKJcnY=;
 b=pcv6DxAmruEKDry1fiNtNo0wXat5T5aaFvQoBLZong2mCHTcL3xhqqUp+ruNkNzXN87Fr+GX4b2Ro3zfzO6DRNzRWkX0RJkw5rDBg6VwUhpvkPaIyd1Wc5+X303nNEyyVaroGFtfzQkHcaNSUTGyWtJeb4vNfsug+kljB8a7/HtvIYeQJgRe/pUdYOFvkWBxrncCGANJz/XElk7tw3i1Tyr+iMJG/w+wmxF38Xv8CZisQQH4jy0NQhYppQETvrruICbcqFLS0jMAUugUTlJt7XZU65iyqjrGcEcB0Gbqc/0+Zs34cJaHiKAJNJLsIMINVW3N66LmPK+k6yc3k2MR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8005.namprd11.prod.outlook.com (2603:10b6:a03:523::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 22:14:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 22:14:08 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 28 Aug 2025 15:14:06 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <68b0d4aea5bcb_75db100ea@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5awm6nppj0.fsf@kernel.org>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-3-dan.j.williams@intel.com>
 <yq5awm6nppj0.fsf@kernel.org>
Subject: Re: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ed58e5-0dc2-4771-84d1-08dde680354a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnI4bmwxSFJ4OFBXT2tGQXpWSGpsTTFqYUJaZjB3enJod3BDMzJ5ZHJvR3ll?=
 =?utf-8?B?MEdHbUN0YkZ0L25Mallyb1JHdTRNZWIwVS8yblRjdnNmQTRnRkdYQ2ROMFBR?=
 =?utf-8?B?V3BWZkwxUktKMlZnRURuVjNKYnlyZEgyTFl1bitXdTNCR0wvdngxaEMxQVdo?=
 =?utf-8?B?ZjZ0L0Y0U1g3cUNManVYNnNHUjQyS1p1R2tZY0lCanNKdW9oR0VxRHBxRy9W?=
 =?utf-8?B?YmdzQkFGaFJsTkIvR2U0ZVNtMThVNnJMem1yb0dacDd4TnowU0kvVXFWbmV4?=
 =?utf-8?B?VXVKWjhqeUJVd2dZZEVjMnV4RjFESWRDQXBXeHJqSUxCdDN0d21weUVTZVhl?=
 =?utf-8?B?MkNDb1hWMkpRUFFzZGpCM0pCZUlLT3JHSWtEbWh6cGI3cWh3NVRzMlNZZHdj?=
 =?utf-8?B?aFZ3UDIxdW5sRUgrR1ZPZ0hPRmlWOGNVQlNlYTF0WGpvSXVaSWRmK0NwZnJD?=
 =?utf-8?B?VmM4UmVmNXJDZEVFZWY4Uy9rNTZubWdQQ0c4SHhUNENlSll1WGY4RDhCa0JY?=
 =?utf-8?B?OUdRL0FUVXV5ZmlKdVhkQnY2b3VmZEVSdWE3OGRYbEFBbTdjNVc1aitLT2pN?=
 =?utf-8?B?MXVoZjFvOEt1MnVZKzNieXhIRVVhLzdmMnladkNiQ2J5V1QvaXV2Mk1xWi9u?=
 =?utf-8?B?NHovUlZLNlJranptYldzbzVqZ091SlBTVzQ5cVlvc1IrNEt3SFc0ZzVJN0t2?=
 =?utf-8?B?MFRtV1FxMEZDNGpreDFQZjFOdUJTQUVzSHpzYlV3cVg4NHFUaXE1Y2NpM3JE?=
 =?utf-8?B?ZEJPcFJHd08wMGNmZ3lMSmZocXk5VGhZaVNFMlk5RkR3eW5KejdMcWxHc0c4?=
 =?utf-8?B?cm5GSitGaDdwa0F4SVhrV0dsN0YyZEdydzVGRG1oREZqdS8zMmRsV0RvVGE2?=
 =?utf-8?B?WitMQURvMjArdzRCdHFQSzdvMlRwRG4xbHdNOXJ4ajlKZ3JHcDM1R2dVT1gx?=
 =?utf-8?B?VUsraWhSaWcvcm8rTXVIbFA3dHBMMW5LVGsxSSthNzBLZmZ0Um82K2NweCtk?=
 =?utf-8?B?SmhzTTZBK1BYWHBPMXB4S1h0QUsrTzZrWUFNR3VmYmpCSnBOalozWDNLREFJ?=
 =?utf-8?B?VUJKRW0zUnpaNzBDNU1razRUUzVFVkNxRVJ2YXUxWHo5ZUNZM09FeFJaVlln?=
 =?utf-8?B?dE05d2dncUdvMzVVZFVWcThqNVB3NDgzaWtON3NOaDdHQTR0S0pyZ2ZTWTY1?=
 =?utf-8?B?SzVTN01sUVh3TGsxZlNQSlpmaSthKzZyT09hUWI3dEFESUxWc2cxMklkMzB0?=
 =?utf-8?B?cFo0L1RqMTNsNEx1Y3V2dU5qSFVVTCtWblIwaWhtaXRxdlJzeDVSaGh5YnRq?=
 =?utf-8?B?aHB5Z3U0RTNSM01PM3NXRW11MG80Ukk1QmU4SHp5N2xDbTFoODQ3WmJ6Z1dF?=
 =?utf-8?B?S0lSd2JzR0s2K2xIOWZPWnpyeWxNYmNKTEdVb0E5bkpTQlBzYzRXMHdWdkVy?=
 =?utf-8?B?N2hzRi9hSXJtWEFTMnU1U3NGVlN2RUVLVnczUksxYWlOY0svYkNOWE9qSEtJ?=
 =?utf-8?B?SkNNTEdDalQwcHlDMnZ6R0NJdnlXS1RmaHZBYjM4bURueWpHNXgxbzM0c25r?=
 =?utf-8?B?aEY5RzkvY0JNMzRONWpLczhVR1ZvWFhjOHpCbTNEZ2FUY0ZwcTI2UERLRTZ6?=
 =?utf-8?B?MGJvVC93MEZGaEFxYytVYXdaSUoxUWdiMzF4a1QxdEV4ZTFlNjZDdllwSmQ5?=
 =?utf-8?B?MTlkbVFLM3c5RTVjWGtqUmo1Nytrb3FvYnBBcjVmOEJmZjhzTlJFa21wTlkz?=
 =?utf-8?B?WmNKT1NweGtVTWlEZTBEaDdMY3l3akQwaEp1UmxKZXFVamUvTjhUV2FJZnUv?=
 =?utf-8?B?bEpzMEFCVG5nZGpkMGdNazlVUGkzSHpUYmhBejhNcGsvTkE2M1lqTWwyY292?=
 =?utf-8?B?UCsyM3FRVkZ1SDRJd2Zoa1hqRlBWM0dydDlFWWQrL2V6d0E4M0pQbmQ4bm9Z?=
 =?utf-8?Q?aX92LVmBqc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2N5TVNyNGRTdWxST3pxMmRGM3BGbGM5VkpTTGZQK0ROYnRaQUxDbjR0TnhR?=
 =?utf-8?B?K0luNWZxQUIvRGE0T0NJY3RDc3hJWCtYVUo1bXZNclJ2dCtaaGZzQ3RhbWM4?=
 =?utf-8?B?c2hSM2JwKy94OCtyblJUcUtCd0FzN1JUQXpCeHdxcmJTbTB4N0ZkTVJyaktD?=
 =?utf-8?B?ZTJPV08yUk5Jb05FQ25UdkZYV1kybzZ6WlMzU1dFaFZGVW9HcDBXMkttMzFW?=
 =?utf-8?B?dFRaTjYxQ2FBUU1lQ3F6T3o2UytUeXRDVVNJWWlwSmVISG9iR052V2dNMkNF?=
 =?utf-8?B?Q0xMaGNpeDI3L2tiR3pzYWw4WjNVdkVoVEV4bXd3RFpnMDhFS3FsTnJPbUpv?=
 =?utf-8?B?OVNnOUF2N1RXSUY2SG5PV2FJTi8zTzU1T0tXUW9hMWdlMG80Q2VkYTc2TWl6?=
 =?utf-8?B?UmtRRXhBa01vWmU0QnZ6RDdJdFp0RzBBMTZpSVVjSTFsL25CV2l5ZUFreHFx?=
 =?utf-8?B?QWtzUkpFdDR2U0JxbXNXZVdzQ0xJS2tJM3hnU2M1Y1c0bjZidTVqYW1LN0dj?=
 =?utf-8?B?S0VZUzFOa0FHc1ZJaHZjckFtWnpqNWhMWXcwbVpSQ0x2VkNjZ0FZVGNwR3VS?=
 =?utf-8?B?NTIzS214MUNBOVRqM2FoM3BqVnQ4R0ZMSXI3NkNKK3duSUNwOXBIZll5RXpY?=
 =?utf-8?B?UXJtT09mMUx1M29GcE1oYXRZQlpVNVpUNTZKV3drVTd1MWZoNklsQWVqUWJ2?=
 =?utf-8?B?dmFCK05jMG5VaHVkQndXbUp0SC9CdmwxVTRjV1BkcnBkMmNuY2RIUm5NN2w1?=
 =?utf-8?B?d1pORjRHVWdScTRudjRsZStoZUhXcFdPZEt0MSt4UnhxcUkxb1hmTkE1ZTMr?=
 =?utf-8?B?S1NDYUhaWHBNbjFmVDIvSklaOHNrZVpUZHU4bUdHcW5tQ2ZVdmxtQTdjU1V1?=
 =?utf-8?B?MEpwaGIrelNpSGgraUtyTkVJRWsrMFlGQWw5V28wc25iTm16ZU9lMTBaa3VJ?=
 =?utf-8?B?VnhSSFVhUm5kVWo2WGRqamlyc3JVVWhSRzJ5c3BBYVkxcTl3WHhyOG83QXNN?=
 =?utf-8?B?VFpjYzZwd1FNdVVOZXVZbkhJNHFrM05WekFJRnB6Q1p2ODJienByOTRZeVZ0?=
 =?utf-8?B?L21ER1I1LzFmNlAyK09KV1poYmRUM2RmV2doWFczejk5QkFZd3hRZlprRG5q?=
 =?utf-8?B?MG80WWhqaHNLc2dxY2V4S0RlQnJMUDFjdXRLNW9JUERzK050OUxzRHY1ZUxQ?=
 =?utf-8?B?VXVDMytmb1VEc2F3N3o1WWFtTUthd1FoZ1Nib0JvMUVRanBTWDZJUDhIUjk5?=
 =?utf-8?B?VXhqQmFzU3RHUVJuZ2l6YWNUY2srYmNDRm1xWHlrQndlODJPSVFGTnhpVVVi?=
 =?utf-8?B?aGdqS3B4aXJFYjBKTEtFMUdXMlc1V0pxMWZBQjF6MG0rZ1dlODN5RWdEMnhz?=
 =?utf-8?B?TmUydE90NXFpQUZ2dklLN1dVZFl1bE9Ic0hwL3k5SmlRU0R6dXRiNkZ0bElE?=
 =?utf-8?B?T01QNjlzdTNiT1BDSGo3NkNiNHJ0S3ZYcHVtWXcrUTlVdDNPcTRsV3Nvb0RR?=
 =?utf-8?B?UUpvREpxZ3J6NlNEMUtYV2lIa3ovN09hejRzbzQ3MHkwQmVPdGlHaUtPUmtF?=
 =?utf-8?B?YXJnbVdXZmM1S0QxTndTVmFPa2NVQVMxcWp0aDlXVXdqaVFMaXUxWjExeUov?=
 =?utf-8?B?cHNqQWkxdkcrQjVwMkVjSERtOU1HdXZTWHcwNzVhYVVFMU5icWYxNTRybjJI?=
 =?utf-8?B?Ri9iT0dhRlhocFpTNnJ6UWR5VlFWbzZodUNob0VuT1JPUHJubmZxQzZRcmhG?=
 =?utf-8?B?QkdVeit1Q1hYSGw5MTRjL1VKdFVNMGp2RDhFRlN3Q0l6MDhLaTFxeEk3TDN4?=
 =?utf-8?B?NWl6Q05ncHJRLy9BaWNWbmROL2JmRmlud2RRcWc4QUMvd1E4dGVvK09kaGsy?=
 =?utf-8?B?eFc0VTVDOEYyUkFiTEpmeGdYL3N4VVZ1K2xTeWJIU2ZKR1kwdGhIOTNiNWNj?=
 =?utf-8?B?VDM2d3Y3dXZPY244em1EUWs0REdCaTlpQUtyVTZhdGxRellRSG96N2ZjajV0?=
 =?utf-8?B?TCtwVkRDTXhsS0tOelMxMWYxSjc4aFRhczRGbmozb3BZQXRmY2EvcjlvQmIy?=
 =?utf-8?B?OCtrd3ZvOFoyOXF1OEZ2VWc1bjRJM0V1M1lBZ2I5OVlUZW93TEIxUDZyN2Rt?=
 =?utf-8?B?dUdSWmx0b25TdjJzUk42REpzTGttdkJsT3hNOXJITU40K21iMjAvY3ZhU0M5?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ed58e5-0dc2-4771-84d1-08dde680354a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 22:14:08.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCbLxA25absGEVoNhiOUpzGGm4uG5LC35SVQE0JpmxqCtj7N7CdIavPgbPgHgesH5q2piNHb6g/6blmAF+b6eGahAkd83Wk0dfPVuxeMS4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8005
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>=20
> > +/**=20
> > + * enum pci_tsm_req_scope - Scope of guest requests to be validated by=
 TSM
> > + *
> > + * Guest requests are a transport for a TVM to communicate with a TSM =
+ DSM for
> > + * a given TDI. A TSM driver is responsible for maintaining the kernel=
 security
> > + * model and limit commands that may affect the host, or are otherwise=
 outside
> > + * the typical TDISP operational model.
> > + */
> > +enum pci_tsm_req_scope {
> > +	/**
> > +	 * @PCI_TSM_REQ_INFO: Read-only, without side effects, request for
> > +	 * typical TDISP collateral information like Device Interface Reports=
.
> > +	 * No device secrets are permitted, and no device state is changed.
> > +	 */
> > +	PCI_TSM_REQ_INFO =3D 0,
> > +	/**
> > +	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
> > +	 * UNLOCKED->LOCKED, LOCKED->RUN. No any other device state,
> > +	 * configuration, or data change is permitted.
> > +	 */
> > +	PCI_TSM_REQ_STATE_CHANGE =3D 1,
> > +	/**
> > +	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
> > +	 *
> > +	 * A method to facilitate TVM information retrieval outside of typica=
l
> > +	 * TDISP operational requirements. No device secrets are permitted.
> > +	 */
> > +	PCI_TSM_REQ_DEBUG_READ =3D 2,
> > +	/**
> > +	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
> > +	 *
> > +	 * The request may affect the operational state of the device outside=
 of
> > +	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, =
and
> > +	 * will taint the kernel.
> > +	 */
> > +	PCI_TSM_REQ_DEBUG_WRITE =3D 3,
> > +};
> > +
>=20
> Will all architectures need to support all the above pci_tsm_req_scope
> values?

Are you confusing this new "enum pci_tsm_req_scope" proposal with the
previous "struct pci_tsm_guest_req_info" proposal.

>=20
> For example, on ARM, I=E2=80=99ve implemented a simpler approach [1] by u=
sing an
> architecture-specific pci_tsm_req_scope / type. This simplifies
> the implementation, as I can access `info->req` and `info->resp`
> directly within the same callback, without needing an additional
> structure to carry arch-specific request types like
> `ARM_CCA_DA_OBJECT_SIZE` or `ARM_CCA_DA_OBJECT_READ`.

So both of those are both PCI_TSM_REQ_INFO scope.

The observation is that Linux already has an opaque blob passing
mechanism wrapped by a security model, fwctl. The proposal is just
reuse those mechanics, skip a wrapper struct for the arguments, and let
the low level handler be responsible for response buffer allocation.=

