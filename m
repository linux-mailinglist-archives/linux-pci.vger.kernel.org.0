Return-Path: <linux-pci+bounces-35708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9369B49E20
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 02:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9553B5681
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 00:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97E1F130A;
	Tue,  9 Sep 2025 00:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxwwgJV3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E251E9906
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378558; cv=fail; b=AZ197S9G1UklxtGONAxKM6nVDkcDUftVsPqCoMbjxm/EDuCFSqnTTQRwOk5PMKhyQfmS20kdmPiRIC08h+qiJiwd+6tvRK1dIqzhME6Hp/JPYzhwRLmTJChtNGJQwaJWq9jNe5jH/CoPfZ0aaO71eLbxgG2zByVlsR0g2GSvkIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378558; c=relaxed/simple;
	bh=/5ydBEeuJb44FymfwHWbIvbXObgPSJKQ5oqLtIn8l+w=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=EfhoKdFHYBrskLDsbF0mOU6br7UyjPcHlGqvwy89eXZxQ4ieGZfWuZ2BL32R/5rlKFlnV63BeIugARVrkJLS48lTYZWysuSWFs3ogY51qM52NQfG/yeg7aOSQrmdd2VANlLoc7MmKApdT1ERH5p5SLb8fgOnFeTQCloloqlewX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxwwgJV3; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757378557; x=1788914557;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/5ydBEeuJb44FymfwHWbIvbXObgPSJKQ5oqLtIn8l+w=;
  b=kxwwgJV3vFoEU0X55Ujes6/w8drz6s8C/pB7SmCXDxqIwogelwSdYKkn
   fCLH5OqONjny0oHX72C4pzcK6qE/uHA0ij/222jy8APJjeoL7euhyWkhP
   Hia+DcVXW3JqqsVXrXOm7pfnx90FodictnYhazZbRivcSF11GEdDMDmKZ
   ZN1MKAQRekqQ/VsrRiMKqRu+gU9nYaZ6IhwSWzhWgvEgUbvho2owvtogo
   OWvWMte880zRv8DSZviJZDsbwxoseq9EvPZJM9Re+lZlMhoLhFeTn4p0n
   hjNLe6Z0UvyTdZwG2yhDP1BvU2dq5svl67w6hALjyuoJ8RnbjRX1HTPI8
   w==;
X-CSE-ConnectionGUID: aJhdQNTpSVWrQD1YYy1owg==
X-CSE-MsgGUID: /vGxDc0zTgaG+C1/zrQf9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="85098426"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="85098426"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 17:42:36 -0700
X-CSE-ConnectionGUID: ckpQCWi0RBaplNgIPVuHWQ==
X-CSE-MsgGUID: zFK1GXcFTgG5/9ycNoSMyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="177281058"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 17:42:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 17:42:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 17:42:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.80)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 17:42:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgoTVV8lDTpUWKUixAnX7CAJviV5T/PxRmTmHJD4JJ2UA4cGL/764+rF1/FfGXAS1W7p2kKwNRbSyhDiAx3bZu9dB3oF3HojUXICpZCIT7dnlPjO39a4xpy2HUcytlYn5l+GuPP3ul0AwfF9eNzoEnEDm1hfovFdaVuaM2FbB7WhfDYgDfSxN9IiKKmbIaCNLj2fMpKOIuXHJOVRQZSi33XSLw8qtmEVRL8reTydxwfVzMS/Foz1MalXF6kH9yRTXS6maRzYIy/Zw6B1T7g55DGZIZiSdkkhq+Z2jz8P+rS/o6nrxUK/D4xQSel0EJPuCzjpG7SdaPIqPR503xy5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db589kuSRVo3xh0BFsftjkHjWzM/kn+SRtyV5aH6SJ8=;
 b=jrGF57m8k5m5ICC61uC2dAobp3Ydsx2dp2wxI7Fk2NNRqDMscC8m3N9bZTPzoNb9Wi9txTLrL98qzG6QUkWDmk1abjTGWJK9apWXidOGigapuEkGyfVjHQglRy43+LgGsd7beGAQuDvMTFSMKGOEpNXTt8N51HCYXFbCCpXpZ0YAgv8ZZFNbCjIcny60x4KCLTLEwzaDsRNO7O/G4Ch1DDOBAFL17eEXOl0pYMPVa9cP65trtu1C27t7G3eXlQc4FaMUq6pyGG26yNn3gkcMwguRsTjtgXw15E+RzKsjCg/szXRvYGihr1VxYKqwTa+ooxBmHcLnmeEixynG+2+eaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 00:42:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 00:42:32 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 8 Sep 2025 17:42:30 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Message-ID: <68bf77f66810e_75e310029@dwillia2-mobl4.notmuch>
In-Reply-To: <58ed4f53-5620-4faa-8276-cf73c93b84cb@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
 <68ba3f725b284_75e3100a5@dwillia2-mobl4.notmuch>
 <14144093-c3e3-49a1-96d3-acd527cfe32a@amd.com>
 <68bb95a07043f_75db100bf@dwillia2-mobl4.notmuch>
 <58ed4f53-5620-4faa-8276-cf73c93b84cb@amd.com>
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5cda0c-8238-4422-efd6-08ddef39c2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXJXMkVWaG5FdFcyT2ZmSXBYWVg0b0JTdk80bEVGa2RFWldJaU5IVWwvSVhP?=
 =?utf-8?B?Tnp2c1RMdU1yQ3hsSnVEVTBZSkdSMTNsd1g1Q3p2UTBJVXNTSGptSU5qMGF0?=
 =?utf-8?B?Ym4yK1FHZmxYOGgrdzl4alQwM3l0Qm1kZ0c4WGlzdm80cHI4RDRpS3U1WHoy?=
 =?utf-8?B?ai9ZTmJpTHpjaXZNalpiYXltZ2g2Q09sYWorRGpOU01jQWJ0MzFuZTZCUXU5?=
 =?utf-8?B?VUczVFR4VGVYRmFGVTIwdHh5MzU3UFlQZzVnczFDVjk4Tld1ek16bHVxcWN2?=
 =?utf-8?B?OVlPeTF1VmRxNmxkalRDODlmUkl5NTVWZmhocmRGQjhUMDJta3VtMGtnQUtP?=
 =?utf-8?B?ZExOeWdTN0h4RE1EU0Zwb1FnWG9vUHYvWDFpWDhWenBYaGJJYTZGWXNBNDRM?=
 =?utf-8?B?OThFTW5XRDFOOGRFaFB2WnRaTmk3dHBaK3NRUjIzZkZWRDNnbVhDcVRER1FF?=
 =?utf-8?B?eXVCN2t5MkRXajhvNE5jZHczV1FlZTdJOGpXeUk4aGhRS1c4SU9lMzdsVy9P?=
 =?utf-8?B?enlVbE5TMngvaWlvZ3kyajEvZ1VmdlFoNndZQVVsb1VXekExWUMwVHFsaXRB?=
 =?utf-8?B?V2kwMTU4cDRZREQxM0N1bmhKazl2TzVvRUJNWEFnY1NRUFI4V1VjMUJYbVZa?=
 =?utf-8?B?QnQrVy9TMHZ5T3ZrbkVDakkvT2ZZbzdlTFFmMjlMVDliQmF3VWxNcWx2OEZT?=
 =?utf-8?B?eFpDL05DN2JyU1p4WE9uNjZqVHlvMUZPMFF5VVlhRitHT0V2OTNnOFZoelY1?=
 =?utf-8?B?VU9EeVkrZjZValc2ZWhPK2JiT1hDZHE3QUR2emUvQTFPVUxIem1uclQ1RnNT?=
 =?utf-8?B?cnRQcGV3d3lOZ3pNOTIvQUZxbXFPRnFjMUN6Nkh5K1poZEZGVDY5M0puR1lH?=
 =?utf-8?B?VkFWS255OHREYVhBeThzRXNONFVZSUsvMTlIYnhET09MZ1M3dldTRWE2SnBp?=
 =?utf-8?B?WmNrYzVWdDg2UnJVOFc0RExvZFZlY1RXbGRCUEF4KzBGVng4WVg0bUlzQkZs?=
 =?utf-8?B?Nm9ZU1Z2dGpxb1MyQkQveWdWa1BONU1tSVIvdE1naFc1OFRuYy9ndmE1WWh3?=
 =?utf-8?B?MHJyTUV5eFdteFdMNy91MlUxTU9GcCtaaGdISHp5eCt5dzc4Z2QvN3FkVitu?=
 =?utf-8?B?emZOTC9XWHVVdHpRTmVjVjRMVitLMkZ6dklVRFZydkxSbTFHU3FJemtkSVpU?=
 =?utf-8?B?dFRNTzFlY0R1RXpEaFhoNDVCRE9vSldNYXZzQk9Jd1dsQ21CTEZjSXhVQ3ln?=
 =?utf-8?B?QkRxaUtaWUFXdFRYeE1BVU0rYnA3QmEwNHNxemlOaEdlQVA2TUQ2VWI2aXpw?=
 =?utf-8?B?ZitOekpNMUVJQmw3OWIrb0pPdmVpNkxCNXVQZDBVb0I4UFc1M3UzeWlLbVcw?=
 =?utf-8?B?QjlyVGxqZUd2WXNMYTlSeW01MytSNHJFV1Z2QlFoa1FrbnVFTU9JbGd6UHda?=
 =?utf-8?B?RGVuaXRKRC9zYzAraTV6T0xuQ0FUTDNyV3NRYVdQL1I3SjZUYzJzeloxY2p4?=
 =?utf-8?B?NXVmcSs4WDdLMDNManVsaWgrdndlN3ZEcktXenFtc0dUUm80L2EyQ0Q0NFBz?=
 =?utf-8?B?NWxUZVkyQjFXSG5IT3h6dFprdERkVys3bi9nNW5BQUs5d2JzVXhHZUk0UWh2?=
 =?utf-8?B?ZG9RMmxyUFordzZnd05HRVdCSUF3NjBpQThBZGxwMWdLbjRsU0VDSTdENm01?=
 =?utf-8?B?bjMvR0pKOXJpbU5QYWhXZFBCdXd0YWcrT0VXYTllanhrMUdIMExmM0V3WGt3?=
 =?utf-8?B?ODhtQUxRdGluOHViZmJ3b3Y0L1pHODg0cWsyejhzaDFwTmgrOEpWcUtxbG1C?=
 =?utf-8?B?UUdBVHoyWGpXcFU5TVJvRGdvNVFhWTdjRlBKcHV1aU5OY0d1VUljTmlGbDdh?=
 =?utf-8?B?U0xVWUpsT2NlcEhKNFlyVEN1bXd6ZytqZEgwNHhTRUUrWGx6Q2dOVEZPQ2Ni?=
 =?utf-8?Q?x27KeWDbEzY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVUYlZMQWtzNklDVXZMc0p5eHZiU2NkN0hZTWQ1dTUwUEJoKzBrNW01d0xk?=
 =?utf-8?B?bFhEOU9EQTc4L1c5Q2dBTXZ0Y0VBd3dLL3JUMWpXMFVXUEUwTlFpSVRUZVhp?=
 =?utf-8?B?cUY2MHAveDYwdUxDbVVBWklna1dFaGoxY081ZTR5U2h4UGJZTEd2U3NJbC9i?=
 =?utf-8?B?N0ZXSnJLQ0lQNXE3WnN3aDNZRW5teXlLM0grdVVkVFdzOHNIZXAwZVRTbzVL?=
 =?utf-8?B?Yk1jbTAvSmovRUdLbnAzbFNMZGtuNEtIWmN5dFFZR3lwdGZXY3BhcVRkQzdr?=
 =?utf-8?B?b0VyanhxQXc5OEU2V0JNNVpFNnd3UFRHWkx5aXpXTXBLVDI2NVlTZzhvczNq?=
 =?utf-8?B?YUp0UUtHaE1ZSTlIYmphN0JCNXhwenpPakxJYko4K3ZtazdLclNFUDBMR1Js?=
 =?utf-8?B?bEJPblMzOU94QTVOcnp6UzJPa3hRcDdES2dSQkJEeHc1bzkxS3dmbG5zZUts?=
 =?utf-8?B?VnZTQTc0UjhZeTUwYnlNemFaL0U4ekkybHRmMHpybXZOOGRNMi9GbG8rVmZm?=
 =?utf-8?B?Sm9ZWGJVak5tbTBTOHdyaVJVc1p1eVJzUkdYYXR6a1VES2pNZ2FWNVhYRjZv?=
 =?utf-8?B?Yk5Jc2g0UThEdnk0TU5xUnRSUEVNN3FnekRBQWdPK29VSit0bFlMWmFRUkN1?=
 =?utf-8?B?bUh1WnlBZ0UwbFJhOEZyckovWXUxOEZHMUx2bGdveWRmWmUrR1VQOXJzYjAx?=
 =?utf-8?B?Y1RqajlWRThKM0huaEtOOGo3RjBNdUc0aitSQkRSSFBnVmJtaHV4ZklodzNL?=
 =?utf-8?B?YmNUVzVpMnFHQ2ZIM05NTW9wc0ZOSlFXVEpHTFBYUmdMYUlLNXRSN1ljbmVB?=
 =?utf-8?B?NXhLRFU3WEd5MHArQUJ2Yzh5dkFHMzBOUGV2LzVHYmVpMTBUZVRQSVUzZkFL?=
 =?utf-8?B?cFhuYUl2YS9MUmVzbTAvYlpOREk3NFFUZlE1R05JTFpDVDFyOWlBQ2ZWV0RX?=
 =?utf-8?B?Vi8zUVFyRDlQVnY1WlltQldrRlhBcjBId3p1L1V1K01IRGpSVFBRdmVFcHRt?=
 =?utf-8?B?UWEwbGtDYUU5WnJqN3N4T2ZPd2JQSkRBdDNBR282WS8wdjYzaVJRaEdlVFcy?=
 =?utf-8?B?TDMyYk03dFVvN2NUMEUyYnNMSTUzK0VNR1o0VEZQSWE3OGsxQ0VYZk1nd2to?=
 =?utf-8?B?a2pGS2ZoMmpILzR6bEZzVkczdlZtUTNCV0xtU3Y4Qi9ndUlDWEFMcit0NEFX?=
 =?utf-8?B?c1FNM21wWEpDaVFadmZSdFJoWFRxL0FWRzBOcmRJUEJIcWN6SXhOS093clZw?=
 =?utf-8?B?eXZWQUhQeVFvQldud0dVNlhOY25oM2ZLV0o4MXdjU3BORGJRL0EzTUljTTlB?=
 =?utf-8?B?RzR1VlJJUmx2aGJobmd2M3pkQmVBMlVHaVFBalFQWHZBRE41WGJzdlFGR1lU?=
 =?utf-8?B?NnZBNXYrQXFsVGQwUUFkN1pRcGhFYlN4S2t4bDhwU3c2bnlyakZYaTg0ZDVx?=
 =?utf-8?B?MDlGQzVJcnFnQUtmeVhYYVg5M1RkdTlFdzFzRUVQV0hmbEcxbkZRUXRVSjV3?=
 =?utf-8?B?MzZ0OXdPK2hDc0hKNTQwV3owdW14MXpDaEswRVJ6K3NSL2E1YlpsVWNRTjdq?=
 =?utf-8?B?TndzcWRKMDNHMzRnbUxsSHoxK1BSUXVnR3JPTXEyOWNRSmxFVU5OR3JpcExI?=
 =?utf-8?B?WVJDODlCWFY2RzE5Y2dRb0dIZ2tmSjlUalZ4Q21BaDU0SVZvenk4OEY1Ukor?=
 =?utf-8?B?ZTZGQitWdXpidlNZemswMEtvU1o2OHNSMjJxd0NCbUwzNVZhV01DTk1aQWxJ?=
 =?utf-8?B?NzJXanpLZ0E0QVo0TnQ3anlzVXFRKytoRVFmRTFFZVEyTllDOXRjcE5LNUM2?=
 =?utf-8?B?L0JmaWFzckxHMFpIWjJUNGQwdjR5ZjhPRHN1NXFZdW55WUdLVGxaVHFZTXZk?=
 =?utf-8?B?ZWoyakc1VEczREdSQnQzVGNzVVV6ZjJ1QlRlQWIwaytBbXRITzlwN3lMQ1Qv?=
 =?utf-8?B?c0NQSHBTNHVwa3YrN2hYNFozSlFQeDI1eWo5S1V6b2VSSzFzcyswR1JZSGVZ?=
 =?utf-8?B?QitTNDM2T05qL1NFcHZLWHhic1RqMzlJWWdvZXR2QUNmRXRSNUt6ZEs3L0hr?=
 =?utf-8?B?MDZBbzNJdzBnVStIclRCaXVVdjV5QWtnOW8xRTMxWWd5SlJYM0VLRlZOM0Uw?=
 =?utf-8?B?TDhRK2hKN2w5UHNyQk4zMW4vbXFLa3ZiN3hYQThGY2doMUN3dmRyUEE3dkZG?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5cda0c-8238-4422-efd6-08ddef39c2f0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 00:42:32.0445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFBNMG9M6BJJK26iHT+j/LilpAoNps4qZJcruH4zi4kLjot+M7qnxV0Pt2TiF/GDVASc4B1Gn7Kk1uienYhVeVkwLge3tXOXTNOMew1Aap0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 6/9/25 12:00, dan.j.williams@intel.com wrote:
> > Alexey Kardashevskiy wrote:
> > [..]
> > That is reasonable, I will leave the error detection to the low-level
> > TSM driver.
> 
> The helper should still return an (unique) error though as this path
> is "not recommended" and the TSM driver might want to print a warning
> if it is not for a known device which does "not recommended" thing.
> 

Easy enough.

