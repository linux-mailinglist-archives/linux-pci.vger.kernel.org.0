Return-Path: <linux-pci+bounces-33651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D32B1F165
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 02:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED151A60959
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 00:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ED71EB39;
	Sat,  9 Aug 2025 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kv3eQOzO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCB2F24;
	Sat,  9 Aug 2025 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754697947; cv=fail; b=KLnVZ5AymqCFgfaaNQgyZY64Cl0KXeWMrOr50tWTpJ2BJp7uh6iDE6RdWgwqjYBg+6y9TrC+SAT7wRNd+I4Y177qD1xaF8wDPFHNrsIlGXaj43KA8F40z95QAAsn+QzWs4kCK9JrB6Hx/3ngdYisd9U6ePs+e6CdTmeq0K/3CPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754697947; c=relaxed/simple;
	bh=4TvOWjw6DphVyO3XGASo42/w5Rk5z4y54RLojDEoI30=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Z384PGWrZcBdRjAzagOJ6u9h2kSWau1x+3RgU050YtUcvdCWbCb4HdGGLYnEDCltElOsoSpAZJUvg9rNtjGqdCN7rEq1AMTHrrFKbg0LhWM84P/Zv9k9LU3M9qJgRwQLln3hhEbyKPJ9WKFxhHcVrgyBXlNbFSSRDRfW64p//x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kv3eQOzO; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754697946; x=1786233946;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=4TvOWjw6DphVyO3XGASo42/w5Rk5z4y54RLojDEoI30=;
  b=kv3eQOzODaNfsUpD3aLJo4PogRCyRwz60yuLSlwBLkk+C2zAR1ch5Ipt
   J6DuEDZEqFYXKdR2EufcjM02B6LElyhJcT2weV30PQ9SBVHSp7ugVC+q1
   9HHnOpHYGwyZ9fKYxH20uLWx9+YAl5rET4HhLL0gqc1ug5FK0d376wjEN
   N77m902ZYOjgpeGRVCNI/S6HctTj/iBAdcQwMDF5v+XymzKt3Hoy2ECZ0
   aH2anziGk1V+cgNw6ZFogDEKRs7qNaOabC399l63CNzbMm1wV62iNWdO5
   fc7tzNnE2gnlqN2+ZzWWDzkvVFiRxfkSvXFX3gyp+v4VuvGN0uNBeQUgz
   w==;
X-CSE-ConnectionGUID: AXGLXwhcTxScbdswGQ17tw==
X-CSE-MsgGUID: Dv2+pthyRbOK1HpuU233Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="79611182"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="79611182"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 17:05:45 -0700
X-CSE-ConnectionGUID: 8xOlo+zrRSuiN6lyTy2y1A==
X-CSE-MsgGUID: 1whiKVOBTvONqdxZjCaxtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165810387"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 17:05:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 17:05:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 17:05:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.48)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 17:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keex3B1DSDHq/Ty1u/fvesa8qCjQLfHLORugjyIC2ib4h70YKaG7LI5tu2U7om60iCe/EACuJvIhZ7y5uIwzCvqxInXoRXjcEyxHfclwdSfq/pEVypu+TXqQ0J4nt0+mMbxOEk7sseM7J7s7qggZtl6p/vJxCgINuR4s8Zo3pRgkgiZZuikomcsQqEkSnAkC7CGtyjNbCT0iVN5tsLXqOtUS/0ImRuoTdC8k/3KKA3sUGwWmEvDgg+QXod2HaNZ/8GQQwms1FBUbR7cp32bv71HeR7vjslPU2ehhicWDeHBNKTbDN6RRT3XTSkgR17UtIVWrmuAddTI+hxYlYGCnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMee6lvyx3NRg+u5dYNB9Sw1ZWGNew+KlOYJ74RpANI=;
 b=N1TCTurRJ5AM+NO6/+MZalvh7y9irQ8xhAQbp/KTmWxQRczY52yrBS1PjwOcDHs8QNnHYX+Aw22nWkpQlTsmmiezxxQy+e6Ax++oJ5+yO6krhfQGRsaPrVEQaDl2IBAsa6pRY/Hm4YfWnvg70EyZoVx6hzHiVsJIItlHl8q3amaS5j/oWSY/ObfW/1I+mzP2naocD1OXNiy8SmVaVI1Iy8030uBpgysNk2aJLNkUCi/wLuEbzPDGBx9RbWWHJC3KVxxi+I9KBAc+fGyM2BS/Q0nQ1HSnblciQQQnEttr5qsQOD3mn0NiAv3EP/IUpnXWIYHLLDna/hbz4kYvnjFHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6038.namprd11.prod.outlook.com (2603:10b6:8:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.18; Sat, 9 Aug 2025 00:05:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 00:05:40 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 8 Aug 2025 17:05:38 -0700
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, =?UTF-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Message-ID: <689690d2a07b4_cff991006c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250807220656.GA64413@bhelgaas>
References: <20250717183358.1332417-7-dan.j.williams@intel.com>
 <20250807220656.GA64413@bhelgaas>
Subject: Re: [PATCH v4 06/10] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb95077-1b33-428f-29c5-08ddd6d879c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnE3dEJKbldSN1l1Q0V3WWg5QmZIWXhsaVRQVDhjcDJwem40Wkp3dE5TMDJ6?=
 =?utf-8?B?Q09FZVFFUnUwNjJOVXZQeWpTRHB0TFJnMWVVNXRRb0NlcHJFRktwOWtEbi81?=
 =?utf-8?B?QUg5cTFPbExCWXNnSUpEMHlFZHpRdEh6ZzJ2TEdyODJUSHcxUmN2SzYzOUNm?=
 =?utf-8?B?em53RDg4ZXRsYzYwQUQ2dlJGa2NPL2g1bW1GdTMrSkh6Y3I1Y2Vjb0dqZUR4?=
 =?utf-8?B?aXNMZmV1YmlsYy9KUTd5TUJPa01IVGo0Nmt6WHBqNVY3ZmhGd0ZyNVdVemlN?=
 =?utf-8?B?Z1k5SUtlYnJwYlhiVjNZTmtCTitOazRXYWhjbmxxRVB6YU53NTNRQ2hkYmVX?=
 =?utf-8?B?U2VTOHdkcFd5S29BMDdOS013WFNZSDNTQUh4WGRGTG5CbjgveU9kekx3Y29R?=
 =?utf-8?B?UmlzaGlxWFlKbk96VmxLZ0FOMDlxM2xYS1JuK2JlTUFWNEwwU28vT3VnR3NE?=
 =?utf-8?B?RWxQZ3k0dEIwMFVFVy9ZVnl3SkpjSnc3Qy9XanpCUnRSVXFwVE5ZR1Mza3Jp?=
 =?utf-8?B?bW40bVpkZy8rdmFYaVVUbDBzSm54bmVIQ1ZKa3dTaVUrQ01RbkFkNzg4WWdD?=
 =?utf-8?B?TEhXakxab3RFZmpGTkhDdWNVMkRQZ1dlRnJ4S0k1VURIVm1JNG5LKzMyY0Rk?=
 =?utf-8?B?WURUKzNFamc3MytsaUpnU3oxODREeVRUeUthd3QyUllUUTJraUM1bDFiZVRG?=
 =?utf-8?B?VXlPNnJySmpSTktsZWdoWGdWUDhDQVQ0N2o4ei8zNTdrc3RRaFFsWGMvNUVN?=
 =?utf-8?B?RFVENGgzK2pIb3VGUDQraUZBRUVJL0d0djU1Qnl0ZWlJbzF0akZWbWVULzJx?=
 =?utf-8?B?RFBramQxLytmaENQa3A0RmVqQ2J6ejZuZFlRWFJvK3BDUTRZb0xtMk9KSTYv?=
 =?utf-8?B?Z2ZqSUs0SlNQSnZ3WGRpd1ZxWDNkREdRaER0N1pqc3cwRHpmVGRaUFhhRWZ1?=
 =?utf-8?B?TzZOT2hwYTVZUVl3VU9TSDRndE5RUmFUekJlU01uZFN3ckU0eTd6dHl2Y0dU?=
 =?utf-8?B?NXdRRVpCMTBQazNPdGptVC9UU2VKQzlKUjB3VFB6TG9WVC9PRE1pZVBPVThV?=
 =?utf-8?B?SEJhV2MydmJZVFJGSkdMQUtHejkrMVNkZ1ZENjhzL2E0REJyaDNJa2dOVytY?=
 =?utf-8?B?ZmwwOUlRMloxUkRUMW43NGxOYlNPT1NkTmFVQi9naXFjRzhJOUY3azJhOVUx?=
 =?utf-8?B?aGNkakFBZXBMdWtyQXg3MXYycTFlQXBBS0hMVGZwVWRDSDJUN1JkNjVnRlZq?=
 =?utf-8?B?TWRVcmYwZDh5WVl5eCtmd1Q5bll0WjFUVytXQVRsdmRJcTEzeWI5NHhFSFF5?=
 =?utf-8?B?aE52ekpHc2dQcFo1OXdNM1lEaisxSHBnckhzVjE4eldsVWRscUdQY3Z4ZXlL?=
 =?utf-8?B?dkU3OGpWVHhDaUhlK2xsbmZLWVF3cE9ObzM5aE1nZU9RdWFzYmdjbVdualJk?=
 =?utf-8?B?emZPcUpRVjB5SmVkSDZKaCt4Ky82Smd1SjF4MFlpR0dzZURZZXVyQWNJRTNY?=
 =?utf-8?B?b2xDZFF1cU9XZ3FOQkNIS1pmNUJrSk1XNllpT3dpdEZRQ1B4anZKZ0hrYjdk?=
 =?utf-8?B?SmlBZDBzaTVoQklxOVhuaWE4enVDUHI0MjFGa3FGOFY5VmM2WlA0Qk1ZbUwv?=
 =?utf-8?B?M3NDTlM3NXgrS0dhN1ZDTWNmaVZWaisxWitKei8wVkJ3WnhiNmpGcmZ3RzI0?=
 =?utf-8?B?WVhnTG9wNTIvZlkyVlJJYzFGbnh4OHZvQ3J2MFlFclJVWWluak9JNmJhOVVj?=
 =?utf-8?B?bWloM0tKTTRsS3ZCZzhaaE5NK3VuZkxwUzhtOEJUcC9XM3VmUGxuWnYzcDhh?=
 =?utf-8?B?S1d1aG9FdUcxVTZtNEppcFRiRTVVbDEwVTZNaSt2bmtxR0ZKQTIvNDlXbzY1?=
 =?utf-8?B?bkdNbytxd040bXdYK25Oc1l0eFAxSXl3aUFUSkpDS3B2ZkJtQjZiQ2V1MENy?=
 =?utf-8?Q?PAcfzacL3fo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVpYWVlid2pVR012UHkvUDRiZnRHUEhYRjhzL0hrQlc2MkpKM3Rmb0svRDdv?=
 =?utf-8?B?aCtYSDcwTUJFaHBSR2plOG1TTjd2OE1URlVlMFVXbW54eVdaczFxMmRwQWUz?=
 =?utf-8?B?VE0zOTBHV2FtMGhIMVMreFhXSWYwUlcwNHVyNldjbkNiTWV6ME9rUG51Zkl0?=
 =?utf-8?B?TXk5VUFjeC80TGhPNVpqazFmWmdieU1DL0dPWHFLalk0aU5ZRnNhczQ2MVdu?=
 =?utf-8?B?cnZCMDJtOVFjOCtLWk5vU0lkbVgzZS9kM0JkbnM1QVB2eVpQL2ljNkVqOGo4?=
 =?utf-8?B?ZGErM0cvSk5IR0NwWStjTDVCT09ib3k0ODJjR09UYkV6VW1RWHhiZkk1d1Q5?=
 =?utf-8?B?dGJXam1wNk5FV3NzUUpkVk1IRGJVeU9SelQwYjBjTEN3ZlU2MkljN2hrc292?=
 =?utf-8?B?MEc4ekFIdUJQdHJHdSthbFZHenU4N3BYOFZ2dC9lYXQwUHFxcGl0c1UvZmtY?=
 =?utf-8?B?M25oM1Y0Z0kwNWpoNmwyS2dLVlBlQVBmbERwL3k4SXlNMGFVTHZEZ25VZkdB?=
 =?utf-8?B?RzRsQlVBaDRMaUxLL1VqZFpuMXFIbU5vakdwaTRhd2tkZE5kRU11Y2RDaWVU?=
 =?utf-8?B?UE5QRUJuSmcvdTBoVFVvUDQvR1gvK0VEem1JQmRSKytjSnBwKy9JUzMwc3dh?=
 =?utf-8?B?VFVvTzZJNmhLT0QydEZ4VU1oZzZiSzcyV0FRN1FnUWo1K200ZjF3UDAxZW5O?=
 =?utf-8?B?UnhMSUJaZU9RM2I1OGJkelhqU0ZoRy9NQXEwd3hvWldvcjVBVXhrMlRTbTlp?=
 =?utf-8?B?MllROFZxeTBaWEVMU3hhTVpQVkhnM01JL002Wk5IQ2M0YUJ5ZjRXTU8vTVJQ?=
 =?utf-8?B?N1Y1bXhHM3YveWh6WnFwOTI4UGswY0h2L2hkVEVnK0E5bnNLVEI1RjVheG9Z?=
 =?utf-8?B?R0tYNmJlc1czOG53SUNsTGxLUGJjL1VXekRxcWJQc1h1blN5M3pML2VBMDV3?=
 =?utf-8?B?NTNrOUNwZlBwdWRiVVJMaVdraHNEZHRFaG9BUFNrbFc4NTFzYlVTTFpVNytn?=
 =?utf-8?B?L0ZybzNCaVNkalN4cGZTRWNNVm05V2FCRHEvQlhjeTlJbFViQjVySE1aeHpL?=
 =?utf-8?B?R1RsZ3g0R1FXZldIQ29nb0RvSVhmaGczenpmMmFueS9JSE9xTVc2MmNubXVK?=
 =?utf-8?B?cWQyVWV0dWRuQndZRFhNWHRIYmdrUXpla2RDRVE0Zk1CU1FseFhiVU1uZTFr?=
 =?utf-8?B?dmhUUjdhM1dPNlhKd2pNU29TUVFlWEljWGtMWUdUeGNDUU1PM0tPTTZ2d0o1?=
 =?utf-8?B?T2ZSanJXLzlaeTQwelZQU25VUFZGdmZWbzc5cDUvbEc2SGoveTNNUUZob21m?=
 =?utf-8?B?OFdjcDRUQ0dsaktCQjVIYktCQ3NadHFNSVZSWEtORlF0VGEra2c5RGZ5OEtL?=
 =?utf-8?B?K2d3eWluVlVMKzBqUG42MHk2YWUrR0ZtOXJ0NEh2OGc2d3dQb0dDaVYwMEVM?=
 =?utf-8?B?bTdQVVBLNEdKZjZhbnJZNy9nN09KNVd2a0Jmd2NwSzdlVk9ZeHlxTC9DTG03?=
 =?utf-8?B?TnQwZzV6cFRoTmJhRHJjWmJPVHNOS2FhdUd2dG9CaVRybGNKUFhXemIvVzhW?=
 =?utf-8?B?ZnBzTXJJMmtzbXZ3UkJ3OGRyWm9kYm1qK0JOeFd3aWZvdC9Cc1hNRnlvVnJN?=
 =?utf-8?B?WFV1cDdPK0p0QzIvdWU0dWMwL0N6cE9wWDRiSkZkZitQbkY3bG5RUE8rM2lp?=
 =?utf-8?B?UVpZWHI5elBNOTRXWGk5bVkxWi9ERkJQZW9Ha0pDOFVpWTY5cktLYWRlM2E0?=
 =?utf-8?B?Uk9DL2kwS0dLTStKWDFraDBXcDFEZ0lURWV6QWo3SkZQWjlMMW5lYTZUSlJW?=
 =?utf-8?B?cTIxWjJIaTlLZFR2SE9YQWYyRVZBeVczS2IrM09WQndkbW9KNHZ6S0RvVEwx?=
 =?utf-8?B?bjJISTVoWmdFczcwTkNteXVUWTVZNGM3d21SWGNGbnUrTGdOY1VnZ1lmNC9D?=
 =?utf-8?B?TjAwWUhTLzZEUFd2dTNWOU9PMGJPZDNUZUZyUVkzYUV4VHU1Z2RGcnd6bnpp?=
 =?utf-8?B?akdrRTEzSGFUVUpVcGY0OVZ2Q1Jva2p2cmxjMTZpVmRQL0tSUllCVS9jdndz?=
 =?utf-8?B?cmRKeFQ0dUVtYjN5bU9Bc2txc3F6aUIzbWROK2x4YWQ5SS91ODFOeURVaWh6?=
 =?utf-8?B?dkcwRnF6SkhZZERTaDU1UjFjbWpvSU9aWEJjZ1hwcElxMFVmclEya3JpMXA3?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb95077-1b33-428f-29c5-08ddd6d879c8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 00:05:40.2250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1pxqki7CgnAveItYg9RCuTuEpf4GoINwiUn8tbFk4FeFMPdxZlcklcFLYiz25Y5fF/M1NWOQPEYeFt1CamOZgn7du2zAeBpW8fAAhP93kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6038
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Jul 17, 2025 at 11:33:54AM -0700, Dan Williams wrote:
> > PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> > enumerates new link capabilities and status added for Gen 6 devices. One
> 
> s/ added for Gen 6 devices//
> 
> I know the "Gen 6 device" terminology is pervasive, but the spec
> suggests avoiding it because it's so ambiguous.

Ok.

> 
> > of the link details enumerated in that register block is the "Segment
> > Captured" status in the Device Status 3 register. That status is
> > relevant for enabling IDE (Integrity & Data Encryption) whereby
> > Selective IDE streams can be limited to a given Requester ID range
> > within a given segment.
> > 
> > If a device has captured its Segment value then it knows that PCIe Flit
> > Mode is enabled via all links in the path that a configuration write
> > traversed. IDE establishment requires that "Segment Base" in
> > IDE RID Association Register 2 (PCIe 6.2 Section 7.9.26.5.4.2) be
> > programmed if the RID association mechanism is in effect.
> > 
> > When / if IDE + Flit Mode capable devices arrive, the PCI core needs to
> > setup the segment base when using the RID association facility, but no
> > known deployments today depend on this.
> 
> So far this mentions a lot of facts, but only the subject hints at
> what it does.  I guess it just captures the Flit Mode status, inferred
> by Segment Captured?
> 
> I'm OK with basically just saying *that*, and moving some of the
> implications to places where we depend on them.

Agree, too wordy. Trimmed to:

PCIe r7.0 Section 7.7.9 Device 3 Extended Capability Structure, defines the
canonical location for determining the Flit Mode of a device. This status
is a dependency for PCIe IDE enabling. Add a new fm_enabled flag to 'struct
pci_dev'.

