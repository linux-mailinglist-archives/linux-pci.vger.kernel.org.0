Return-Path: <linux-pci+bounces-37831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14EDBCE683
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 21:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753EC400E37
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D31289E36;
	Fri, 10 Oct 2025 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhBMGPXs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26287175D53;
	Fri, 10 Oct 2025 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124954; cv=fail; b=a51zdbtSWgM6uxJHbsazEi2PdMT4ICsgEGUwkuRmGrcWmLAoqFFUHBy9lRS4uY/RDPEoT7ZfIGl4Ewr9Ovb+t7gS4Am+2ssizo5uKMfh6eJ7yqa4CFrMSmV5UAmBLoFQj2PypRsbRos64jwRrShKx0gaRrP8YmrfG9WhJ+0sRp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124954; c=relaxed/simple;
	bh=A6Rbugz3j/ligo7fNRyYYQGVMjdd+DAoS81/zxfLZDQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Lb/nKYd5yHJHBuGIcb3d7q2bCHUxg+YUKpAZg8suYdlMp8JX6uThdYEdvm4MdtwL/uj/EpW8zVKGsHY/hKhc68/OYfTrIpAp+7oMjUJwvtnSy/21hnaH9bBA6B/ulc+c+y8SIqv4hv61foR/2zSZ+HXfZTSxrSXvhSUTmIm7qm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhBMGPXs; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760124953; x=1791660953;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=A6Rbugz3j/ligo7fNRyYYQGVMjdd+DAoS81/zxfLZDQ=;
  b=hhBMGPXsHkvw0vx801w37oMlggylICs11hHJg6A5r/rUunz69ezSZqp2
   v2mOLLIpaMyapuwRW9bAGezokrm8GvK+OrMyKdrqZt2ASOhBnP9w+8rrH
   NhMgc5ThGbDOC0NfG9Hyc0Sg+XSkKKHVCZhc7xWS9NToxfEmG0N9O9Byu
   aIioJrnAXcaKVRHf28OGA5nHugemp3irjkwVwFwcfO7flFEI/LLfWtn9R
   JBMEMZAyulJzbjCNkVNBa0O9c2Q2F+cjKLlPCNQcbvZbVmRMgJ24zzVWk
   buecb4JbB0e5A3DlIdv7Cx78qa0mQTbaIU8+5xHFHOO8uxFpyGjHLC7w2
   g==;
X-CSE-ConnectionGUID: Tn6whJLqQqCN1JvvSE2FrQ==
X-CSE-MsgGUID: Q0KrUinrQX6rKVR83sFngA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="49910170"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="49910170"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 12:35:53 -0700
X-CSE-ConnectionGUID: QMqcmEFTSN2Wgz08BAvyLA==
X-CSE-MsgGUID: +GK04sWASlSrPRoSeICnOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="211698782"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 12:35:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 12:35:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 12:35:52 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 12:35:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l28D48bBX2BNUCqx20xSUHxcWhyiEy3gxJvmJbHU536IINQ3ayagEBA/lNs+zQQ3fdzlJlSDYN1kFE+MaAGOvt5VawgN8aVPTDU6Bdtvf2OACAHXyuPC+P3zvOse3SXpTzETlNobDA8Z03F+XZpES0GvW0qq0rkivpaqrZGuLEWh9ujxN9raTl5Ll+fIEo6ETIwoADHbFA5XqVKBRUOOI/21DdMVX06Y1gRwwZG/ma+fIxVkSTtOaudLttNnaoErho/hZyP2M6cwPhziMgVHuXDj6h1x8zPt7dNeiNcR4dK74yPG/Wed/47CUGqaejPoSavWKpmUSgRE1p7qtidB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfRKQJTZxRQ2nfCDtsNmHVGyuNQ4uY3ezLXPOFV1agQ=;
 b=RI0d4yyUvO4hD9iorVqKVlgh+MeOokZrePvcRI8uBvZKZxCWJWk+xnXCdBNEo9iDWN/ZwBQ7OEaYVKw2vKJjtElhq315QMXViVyWc6Rf3ZQxoV0mUV3W7OeFnz7it5GQcxiPVV1KAEKyRODZDCULzctTx78zE8KUH3kja/4oowag+LFuEL9NAVMW/XM3xEjw1M0x2U4w9Bb8TGCQ6xvDzUpOQwNy6MyayEREsVCHM3cVGDcvtQtgK5zSgGCKs7YJf5lQUGM51N2L1gOl9LAbW7+248j5477GXWAM4ZdNxtZ6X5xNQ+6bJuH3wRYbxhSuIT5isU2/WAbBlkZLXj2uLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 19:35:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:35:49 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 10 Oct 2025 12:35:47 -0700
To: Xu Yilun <yilun.xu@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>
CC: <yilun.xu@intel.com>, <yilun.xu@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<aneesh.kumar@kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<linux-kernel@vger.kernel.org>, <amerilainen@nvidia.com>,
	<ilpo.jarvinen@linux.intel.com>
Message-ID: <68e96013eef19_19928100aa@dwillia2-mobl4.notmuch>
In-Reply-To: <20251006034538.2240772-1-yilun.xu@linux.intel.com>
References: <20251006034538.2240772-1-yilun.xu@linux.intel.com>
Subject: Re: [PATCH v2] PCI/IDE: Add Address Association Register setup for
 downstream MMIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:a03:80::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bc9a15-374a-45b1-4a45-08de08343770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|3122999009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVZvVjJtNVNXTkZzbUI0TEJZRG5SQ2N0bFVQNlVRbk85c1FNS2dEdnZkV1J5?=
 =?utf-8?B?em55Q0pGSzRsVnU2eVQxaTBFZ2R5ZmI4eEpmNWxLMG0xaEhBQUpuOHRtZmpT?=
 =?utf-8?B?Qy9xbzFPYjE5Si80WGVESnQ0WU41TjVWeHNkeEtxcmRYdnhxMEpnbFB4bU1T?=
 =?utf-8?B?YUxVempxUDFndHR3eWIvaU5ZSGJ4eDdROUtTQ2xiM0tBUWFZOU5VT1pBM0ZB?=
 =?utf-8?B?NFVlUUlMN3NIMGNkckRqN0lsT1Z1Yno1V3VyTkllT3g2bExZWW9TQUY1ZHJB?=
 =?utf-8?B?SjZSVlZacFVJU1NNaWp5NE4xaXNGVHhJd0JBaFdMYWt2TkpyV056WDNQc1Q4?=
 =?utf-8?B?SSs2bnBMakc0WkRmc1AzZU12dE1odVRtMXpJU200emY2RXFQVC9CTFdzL2Na?=
 =?utf-8?B?Uk0vazMwTDYxeERzZW5abFVCM1N2SEE4ekhOOUF2TXNIaHpqOCtUNzNsMWY5?=
 =?utf-8?B?azZ4STF4VXVRaWtOTHJyekJBd0Q4RlgrUHBERHhrSXFIMkVqZStwSGdiOWtN?=
 =?utf-8?B?S2xlNW1STjBNTjA1TnFiWGYxUForTWRsdHd0SGsrTlZsS1gvYnhVbjJ2STdD?=
 =?utf-8?B?M0F0MjQ4Qkw0K1RKc0kzMytzaWovTmpTN2dIM1hkUXpTTTh5YUJHQk5paHpY?=
 =?utf-8?B?V2p0c1M2ZitpcmFCWWp3MnNtNVVNaTlqRVFCTlh3LzR6ditKcEZFVUdhL0VN?=
 =?utf-8?B?NzM1WjJSL0tPTzNITWk3ZXlBbWhuUmo1QTJRL3A3NUROdzV6dGM1TFY4U3p6?=
 =?utf-8?B?TjVIMUkvK09rcTBjYy9wdE9BUDIzU2pVTjcxaXF6ZWtIcDdyRm1waHYzV29y?=
 =?utf-8?B?b2xBMlE2YXYxdEFnbEI4WHRWTndadzg3ZytoVzRYbVFDWmU0YXhldkFwSy9G?=
 =?utf-8?B?K1c1Q3J2ODcrTFd2ZitVRGJncldZUHA1S3l3eWdrbW5HL2NSM1QzMStMSkJB?=
 =?utf-8?B?N0hNbWRpQ01zSGxrMERpRDFXdThRRWhiSWxoZ3FGT0ZxT3IrUmJLbVprK240?=
 =?utf-8?B?ckRtRWE5b2pGZmwyOFhQQVA3WnN3Tms3bkU0U2EvV0ZaK0JkNnhUVUE3cS9i?=
 =?utf-8?B?d2xDQmY4WkxodmNSYU1nT1BVZDhXbUF1Nm9WYU5QUi9DdzNacDJtNXJqY3ps?=
 =?utf-8?B?enZXZmY1bmZZdEFYR0tnQWw3NjZZQzlUSHMwc1gxcHNqL1M2QnY3eUVaRVpw?=
 =?utf-8?B?VFBJN3NETWkvR1Z0ODd4ZHd4K1VVaE1UQ1RiRStlSnhoT04rY0hLdmJXSkJP?=
 =?utf-8?B?cWZuNVlHWHlqNGJsZUJVa2M4S3JLajN4L0VlcVRjaXJkcVZGR2tWTFluRk9x?=
 =?utf-8?B?MHpjV0hPZ1ZsVUp2ZVNFMDNvYTV6d21uSWhDVnUxVzlQcGhMYXJpR1BDSGU1?=
 =?utf-8?B?YUE1dkNqSzU1UVIvTUp4a1Q5V3FhNmhvcjM5RjgwNkcvM0R4SjB2NUdxSFV2?=
 =?utf-8?B?c0c1Zk05OFpEUlE1Y0o3VFpkWTFXcDVxdHVZYmtlMG9Sb3NKYm5vY2tvVlNl?=
 =?utf-8?B?czJscXcvdlE0YWErbkJ0a0hiWWZydUlxTkJpTWFkVUVQQ0VXemNuNkNodE5y?=
 =?utf-8?B?VWlIMHNUbUhhTDUyL0pMeFRlWjlzMUo5UjhPTjNhWW1YYVBVTHZ0UGN3R1Rp?=
 =?utf-8?B?cFV5Q3c3UUtQeVNSOEhDWlZPUWo2NU54bW1COTlycGhhelVLdWRibTZYbEdr?=
 =?utf-8?B?WkhlY1JwM3RZckpvU09xcW1VemhUS0MwVWZUcnMvc1FtdGRPMTJQbWM1azNl?=
 =?utf-8?B?T2VSU3dSMXVmNk9DWngvdVUzZnkyRUExZDJkTFA5UmZLdXdmN3VSYjAzRWpo?=
 =?utf-8?B?NWtvNGhMRE54MjBxSytscnk3R2YyVmJXcDFaTEF5bmV2Tk4vY3NHQUxCWXNx?=
 =?utf-8?B?dXdicnp3cDRkZzlhWmxWQmh3TUlTR3dNcVJ0b215RFdtZHRWbVpLQXRyQkF0?=
 =?utf-8?Q?gn4QLgmhQ+5wUXGNVyAdfEIdSxEKlNBA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(3122999009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3VkdUQ1cXAwZnNmbnU3TlZGKzNaaU5lVDNzMzFJbDRXc0R4RnVrbWV5cE1m?=
 =?utf-8?B?RTBCak9Eb1g1U00zQUpmTTdnTUkrWGdXSDcyUGhIOGZqNVdNM1dEQ0FNS1Jj?=
 =?utf-8?B?RVpmMlRaYjhaUlhXTDhieGdMcUYrTExCKzBqZG1VakRWaUovYUN1d0VQN2p1?=
 =?utf-8?B?VDNxKzZicG1EekpXeWI0enVocDEwNlZIdk9Za0dGWERWOGhJTGR0L2FuSll5?=
 =?utf-8?B?WUt1WXdobXZ0V29ISlA0b0s2eFdvR0ZWYXNaNjFSZjFqb2RMbDVTbmthNWRP?=
 =?utf-8?B?QWlBR3NJWEtNSkZndTdPSENoT1VEcHk5ZittdG8relRQL1pvMzNmRm03YWVj?=
 =?utf-8?B?R0ZMTWZsejlQVFhGMGtucFljb0N1b3RqZDlmVk41Sm1UbUw3cUc2ZkRONm1q?=
 =?utf-8?B?cE5vU3BsNDJMZ1ZGdjJha3BBQW5iVWJEdnVoOGs1dkdaaXRZbktJZ0RhTjl0?=
 =?utf-8?B?UFBjWStKalkxc081aXREV3dlaGMzV3dQL3JoYzd5MHg2REtPY1A1M0NPNndi?=
 =?utf-8?B?OFpodzgzckM5WGVEL0FXRGlvWm5JRFdlZnE1ZkZMaG5oTkY3b1VVK2ZTRHpa?=
 =?utf-8?B?ck9tRjdOWDh6VzhseWlhTDJRN2VZZWRMRkN5N3MvUDJCN0M4YVNIMFRieTVE?=
 =?utf-8?B?Yk93VGI0Q3pWSy9GMC9PMis3dzRQekpDN0ZSNHAzYjlWNDQ0ME8vOVZrOFAx?=
 =?utf-8?B?NEptTDNKaXY3S1RKT0lPVkV6T251N3M3SUs3N1FiU29EWnZSa2VDQ2VPZkNo?=
 =?utf-8?B?Rjh0Z3ljTmR1cUxVcmczQVhNd1NNbmhqRWJZQ2ppN2RNQ3M0WlZlVnlkL3M5?=
 =?utf-8?B?VTBDbFpQenZoTjl4MmFuUFZkcGRnVUM5QXVKUTl2OUFZUklqREJ4N1ZOTG1j?=
 =?utf-8?B?Q2FZR0xNMm4zR0JIcUU1WGNVZ3FOczQraWg4eXU2Sms0bXc5RmpaMXZPSm9l?=
 =?utf-8?B?ZUVtSDJ2UWI0WVlHUHdxNHRIZnpPQVVHWXNha1RaODB4cFQweWplQ053dUor?=
 =?utf-8?B?QThMZTNueld2cUduNFlQYzdwVGd0cXJtZW1LcWI1Q0w2MzNxanNTbzlubnla?=
 =?utf-8?B?N1Z2TVBiVk5VMHE3K3lUc01XNFZlUWJrL0hRQWxmM3dZU2Y4U3hWTG5WQk1z?=
 =?utf-8?B?cjVhWElDNUJQOVh1QlAyUmJPanBWTDdiUFcwcmlJUlA3WmRkQVo1dk8vNGh1?=
 =?utf-8?B?N3VHbit4ZkwrSGI0TWoxdWZxajdKTjdwVkRIVS9mcmg0SW5VOUpGT0ZZLzFI?=
 =?utf-8?B?WkFLek5FSjlSZEZRc3Y0K2NQMEorWkRGd2NHY0lLMzNZVkQ0SWt3SENSS2hE?=
 =?utf-8?B?cUlkUFBrQXJBbjIzMmlEMVBmZ2ZQQVhTT09na3NUbjBOdEkvMGtVSU9KVEhx?=
 =?utf-8?B?eWVGbDVCanJDRWFyUXdmVnQ5bVM0U3NVaUJMbVJlYlZZVUdiNktvNGFLNDBq?=
 =?utf-8?B?QXE3U1lRQnRlNVJubVJvaUhCTnFmZEZ0ZVlicFdGZ1RjMFRwaE1hU3J1WUVH?=
 =?utf-8?B?R2ZHY1R1ZXcxYUZlcC9pVE1jdUptbkhqUm9FRmFsR0VqRzdvSTl1c01COTBs?=
 =?utf-8?B?NjZnVzVNRTBwanlHTzNGM3Z1RjNIR1VhMk1VTmprQkw1N3RXcU5PZXg5eU15?=
 =?utf-8?B?RW01SnUvcFBIRWpkeHpDbFlkNm4yN2dmRU5mcERWMzVPZnFidGZiVE5xQUI4?=
 =?utf-8?B?dnNBL0NIbkEycXB5VkRiM0pSRmJTWEpRTVlOU3d5NS9kYmRBdS85NHF3ZHlr?=
 =?utf-8?B?emU5aWhhandwU0JISGlYb015MWFNYUlhK0JzdUgrMElIbStQTnFTaUhQS29O?=
 =?utf-8?B?L0o2cjBiWFlQMUJITkM3a1hWK1owdG9Td1VkdVFzMXVpSkMzQzN6WHYxZGN2?=
 =?utf-8?B?ZDNQRGk2ODR1Q0MwQ3k3KzFzQnpuMEgwUTg4YkFpM0pTYkQ0aTV4SXNHMDhG?=
 =?utf-8?B?UnFidnJqNmNpUVg0UUdNKzVJdS9WQWx4bmdGN3laOTg1STZlWC9UamgrRWVJ?=
 =?utf-8?B?TXowWGNOT2NILzdQcjV6YldXYVAxYnpUSmlYbXU3WERCWVc0bkNRN1pUU3Vq?=
 =?utf-8?B?ZER2Q1dQTUh1SFRyUGVBb3pxaE53eHdyOUhCVzNOWlN5V3VnMXRwdU5ERkZn?=
 =?utf-8?B?Y1FLaWxwUTdjT25mQlM2OVZTOU5NckNDem1kNCszQnNQUWFKSXFSTURUUTBp?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bc9a15-374a-45b1-4a45-08de08343770
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:35:49.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nScrpdrG4FvxDfraLrvTAtd3Vqs+IuOPi8G9DzRPRhuKgqp/EONBfo1fll+mAY1S3QXUF8F2cTFrwYGzLYH5G8Z8oRoZqQKl6s2Np5spFY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7309
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> Add Address Association Register setup for downstream MMIO
> 
> The address ranges for RP side Address Association Registers should
> cover memory addresses for all PFs/VFs/downstream devices of the DSM
> device. A simple solution is to get the aggregated memory range and
> prefetchable-memory range from directly connected downstream port
> (either an RP or a switch port) and set into 2 Address Association
> Register blocks.
> 
> Just like RID association, address associations will be set by default
> if hardware sets 'Number of Address Association Register Blocks' in the
> 'Selective IDE Stream Capability Register' to a non-zero value.
> Alternatively, TSM drivers can opt-out of the settings by zero'ing out
> the probed region.
> 
> If the directly connected downstream port provides both memory range
> and prefetchable-memory range but the platform only provides 1 Address
> Association Register block then setup the former first. This follows the
> PCI bridge specification precedent where memory is mandatory and
> prefetchable-memory is optional. Priortize the mandatory one. If the
> platform can't fit into the default setup, TSM drivers can always change
> the setting before setup. E.g. zero'ing out the memory range so that
> prefetchable-memory range could be setup.
> 
> The Address Association Register setup for Endpoint Side is still
> uncertain so isn't supported in this patch.

This looks good Yilun. I will append it to the end of the v7 posting of
the PCI/TSM base series.

I will likely split the resource_assigned() introduction to its own
patch with a Link: to the rationale provided by Ilpo, and perform some
other small fixups. Like I notice I defined the rid registers as rid_X
and the address association registers as assocX, so I'll drop the "_".

