Return-Path: <linux-pci+bounces-33643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B941CB1EDD0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 19:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5375B7A1B37
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296831C84A0;
	Fri,  8 Aug 2025 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B400MWYA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EC35948;
	Fri,  8 Aug 2025 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673982; cv=fail; b=OF2xbMbKjqQl6K6UDyGKpaPUmwSPQQjoxiRzUSw1jK9PjqhhDzz0kDpBuAhtKtKogQ2H3XUjPH4f78AP5oVmCxKUZg1HFZpxVO1E9xoSXbIoEb6n3avPtGD+WSOEeq6sS7KuRnbmTXqlySDp2A75VYkK5zgqCecoOpOxku3LPHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673982; c=relaxed/simple;
	bh=OxyAwJUGwtHflFjvtsbtkJ0si6T8mzjkhcWkTaPkAII=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=txbX8qg6P2fErd66r2p/9DfXdDfvZOSNUOS1HW2fb5DNd6CbHYZimWjQap+Jz+0ywqzpLw5EBAfw8OwmK57lhMQxagWF7uVc/LnJvaOojGoh4yb/x1dFxRIJEZdMRS7rTZcMaVKv/J8U3g6aoTH2NB4g9uGh8Y4PQJHEO9AO9cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B400MWYA; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754673981; x=1786209981;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=OxyAwJUGwtHflFjvtsbtkJ0si6T8mzjkhcWkTaPkAII=;
  b=B400MWYAWz/bIrTOUKFCbJHjE3OFpIGd5WjtywVvqW2vVciTtW7XsxC8
   jjNG6qlgdt+la1APMHV73A5uMVAwleSEO7hAcrftpAfIdeA/BomS3tkCM
   HpvRRZDu36DmqTAaJGVEmt0KkHiUpmd4eGiVz/RHIeTW7ls+Y6lJVE8PC
   SGNQ3u1G4ZFPX+GtGOhwBq/O/NbiUWplA38no4Y9aNB1Sv9CM1/scU91a
   bNSCCBDaL5J9ifurwtbmaf6qipCpnP64zcDNH3rUJUsQvdTegNPzCFNoG
   d4mW5XxZT2hKWGOtorVxeTGUbbzDUN3jpZ8LTVTiCK+bFT/goGe9duUry
   A==;
X-CSE-ConnectionGUID: 6urEJiZ0RdSfAjlg/gb9pQ==
X-CSE-MsgGUID: ySsKdqQ4Swe2lBeS1vACmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68109437"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="68109437"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:26:20 -0700
X-CSE-ConnectionGUID: 6t0nXCu/SGmlyvstl9oqzw==
X-CSE-MsgGUID: tgtQBxVrR6+TGX8s5of8sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165387152"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:26:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 10:26:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 10:26:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 10:26:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKsEf6FHjNzMe5eLh9droa3zb0jYl/4fTm+nrRFPow7l7ffB4Soe0HrDe2dpID7clRAF+YCD3SchoG0j/j+TC62b8lSH2TcfHCZC8ih9L1XUpuGlY+3E3rsGw92cwT9qFBFazdMJeGVOZLTu/DuINPXuFh64SjRSYZCpP7o/w9AFNF77gp8oPpWVD2NoWcHh18u1j2BAzfIzrknC09HnnCBWJXlGFp6uuv/Pj1W1dhcUKEq3f9BWt5KzTuEZqjkfrXQ7gM1TDYdx696WVN3CeyZ0A9ovhXehcVFM+b0dOIF+ypqTeudsKpsDdlwhQs+3nW04DrmLkB+zIKtEqPqgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xpn2ILYkVc3FTqJRJ1YrgKJq8Bm1u6PNaRY2ISG2KkY=;
 b=FUsGrL+hkusgjOmW1yNGmABcsBOXSSAWUNid13lo9L4nxWnb3DxOOKusbk9t470M7l0cCWcDkHJsWSaG5Iu5v9on4MDBegmsNqdV91FAFUAYy5mQgIAmhVe1RyXEbJuVcBTE3l7X+/jbOKe0/IqiwyWeaXrNqqctfTCmuw0p7Dxtuf5GO8tW7E+mNeRQJrbh4pmLsmILM+CxvebXzZnhPIUuTLVqAR7ObeKaVsPtH2jcodeki+7VH8BDgDdq5fd3fxcRsLVqfyJSLCYoQ29QnbgrZV+IWBcEu5ti8moScLwShdTZpbzQokUuyjESIqUGta9Cj4v5oHKDLMkJXC1j1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7973.namprd11.prod.outlook.com (2603:10b6:806:2e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 17:26:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 17:26:17 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 8 Aug 2025 10:26:15 -0700
To: Arto Merilainen <amerilainen@nvidia.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Yilun Xu
	<yilun.xu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, "Aneesh Kumar K.V (Arm)"
	<aneesh.kumar@kernel.org>
Message-ID: <6896333756c9f_184e1f100ef@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-8-dan.j.williams@intel.com>
 <9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com>
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: e925bbad-867b-4e97-f36c-08ddd6a0aea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUlRQnM3UjZUZytNZnJDZHFPRTBFaDk0aW5hbXo5anQrdi9GSWlZNlVXTjZw?=
 =?utf-8?B?M3Z5SGl2amlLR3ZWaU9kZllSamF3clVKUElSbkFYL2JvRWJ2QnhYclFGcks1?=
 =?utf-8?B?MGZYOUV4QTF2WXlzdUhUZ3MrN3dKTnlxQ3FFSHBIbjJBWFB2NTFoRVNlcmNC?=
 =?utf-8?B?NlhZWHYrWENOZ0NlYXRKN2RzWXBDYUIvcGhFNWdueWRHVHlkRnlEanhGK0xs?=
 =?utf-8?B?T09uZnZnYUh4QmdCUWlJOGJIL0prQkhad2dja3hyWmhVMkpwQVU4dnp3NEVl?=
 =?utf-8?B?cXc0RU9KSWNHL3ljdkVENzVmMUZablg1QnR5U2RkN2FLclB6WWl6NlpKWlJO?=
 =?utf-8?B?dXZxUHdYdWZtOUZaRTgzZDBZL0JiMmZBaDBiOW5BY0ZiUUlwYWhlclhWRXAw?=
 =?utf-8?B?d082VlZUZ0RqQWRoOXUwTzgzYWJFQWpBcVRTdXk0dFVuWStnWUR6QldmcXFo?=
 =?utf-8?B?M29FeXVBQllvbUVYQlFUYUVmekwxUWZOZ1Yxdm1aazY2akNiNXpya0JWeDNL?=
 =?utf-8?B?amMxbXkyb1UybkN6emEvcDlBQU1JNCt1alg2YytYWnJOSlFFdWlKNC9QTVlF?=
 =?utf-8?B?UFRCSitBNlB4MVhjS2dTUEk1a3hOaXVFMEZLSWloY2pka3ZFS1NPZTFZWjAv?=
 =?utf-8?B?OFBTQkx5UDBoVGl6L0dDOEZNNjR4TlFVbk5aeG1aYVhsUGE2b3p1Smt5c3ly?=
 =?utf-8?B?RDF3TDN3M2ttRTZlQnptTkRXdFJTdndkK2lHUWdoZGRRdERBVjI4TzFiazdX?=
 =?utf-8?B?d2lvT2hOVnlESElGenRhNTdBYzUvQ1BiSnlQMFU5VWlObGdBYVdnS0tQZSt0?=
 =?utf-8?B?VlQzQ250aXJUckNxZXJxN3JrZVRSbVlqYW5uUCtNanVGS3hZd1VoWEdGYkps?=
 =?utf-8?B?V211dHRKTG1vNjZ2L3hMNEJtTlE1cDAxZmxiTDNodEVCbEFvRWpMRm84Q2hG?=
 =?utf-8?B?OU85b1orNjdOalE0eXA5S0lUc2U1cWpzVVljSElaQ2lJSXh6OWp4Y29sdWJO?=
 =?utf-8?B?Sm10bmhCSm1tcFc3bm54cXR2aFlLRmZvL3Iyb2kxeG9kRG44UGpRMlNKZlc0?=
 =?utf-8?B?TmM4RG41THJXemJSWVdyZklqUmRGb2lRRXpTU2lRMEtjQlcvS0FFd1h5SWRQ?=
 =?utf-8?B?T2Z6R0J0bjVLNXQrYUJ6Mmcrc0NsdDg3UG40WCswVklVbFZEK1FJelBHTWp4?=
 =?utf-8?B?N0NWZmNYaEUwNTVEZEpId20zdkxLcXJ3MElVWlh3NENEWkVVd3RkTlYxTzVI?=
 =?utf-8?B?WDZNZmdIbE14WjhLWm9jNVlzMERPazNPdW9qWWtTK3RHTWpWSXpXRXE5a1p2?=
 =?utf-8?B?M2NiWWdhVXpQYXZLb21YaVBGZnRLOHM1VGs3bHdseko5cDdwdU8xbFhaOERE?=
 =?utf-8?B?U09FeG84a2w1ajBZS29HSDluTWhSUFV5eGc2ZE5LN1hkZTZXSmZTOVl5bjVu?=
 =?utf-8?B?V3hDSGV3OTRRWms2SytmdnZTR3M0MXlnejJFbmlGb2k1Uy9xemdMVXRGSDZO?=
 =?utf-8?B?cmdCSWV0aWNxL0YycW9VcjFIMUdKRWJERzAwakY3dWkvVEljK2p5bExOT3RZ?=
 =?utf-8?B?bFNtNW1xVmRhUzhJWjlvRjR3eVpjM1VMQ3dnNUFXSjJnSTZLSHJjby9TNnNj?=
 =?utf-8?B?VmdmbThOWEN2ZDBtQVlrYmVaNU9wSWplVzc0dXRhZlFLNGp4U3cySzAyMXhQ?=
 =?utf-8?B?bUtqdFUzbkcwQ0dOVUdKR1NKbTdkVjdNakx6bStyMXEvOGVmcTN4SDRoV1ZG?=
 =?utf-8?B?RG9Kb0ttOFVwWmRoczZDSndrZGthOCtvL2tNTjV1THBXdnYzWkE3OE1ERkEz?=
 =?utf-8?B?WXRJTUFFaEp4Z2x1YlpXTkJLNHQra3Y2aUkvMXFFcnU0Y0lrNVZOVU00WmYx?=
 =?utf-8?B?SjB3NG10ZFJoS3B0M2ljTkRhRXVXeHFacStwaVNFQktzNk1ibmx4TU9XY2Vm?=
 =?utf-8?Q?77moQpH3d7c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnRTUDRRSW1yVlFaTU4vUXM3ZHEvRi9yU2ZqNFg1OTZxTE1qeUVhRFlDOHox?=
 =?utf-8?B?WEErOC9WTUJmajRWUHN1RG5IUkNzR1Vla2NZL0czT1NYWmx0bFFBOTArSGdP?=
 =?utf-8?B?YVMyZ3E4NUp3c2FQKzNFRjhYMVlla0Z3aWhkNE1QVkJud0NCdnRTdTRESllj?=
 =?utf-8?B?SlhOb1NlSDJtU0dkSjB6L09DMlVSVUVWR2JnUmNiQS9WdVI2YUZhQkl2cjI4?=
 =?utf-8?B?SlNUL2NFZmt4L2JFQXBZYmpZMFAya2x2anRVUkhUWVIvNzl0UWo3L0dUS0NK?=
 =?utf-8?B?TFNVUXlCTmQ0eDRSdnBhNFpjYzdrem44MGo0c2RZNFhaTmhyZ1lLRUk4MENt?=
 =?utf-8?B?SW9GNWpHU0xBbjlCclJybmlVYVBZV3RIRUJWdy8vR2Q5RkRrSEZBWjJDcGo0?=
 =?utf-8?B?V3NmQjQrUEptQXQ0RElGcWVJaVNzN0FWRGJsTFR1cUFJdjhRUmRCZlJTSXVV?=
 =?utf-8?B?eTF6R0dkbjNtT0hNRGdlcktwY0JYL3B2Wlg5WjZscW04NlE2V1d4cDE5SjJu?=
 =?utf-8?B?V1QyU0NGYTRUNFVZZDZVTVZCQTdqVXZ0TzlMbmpST1FsS1dHcjBtMnFuN2RP?=
 =?utf-8?B?cWF0ZjdMbzQ2cGo0d21XRXFrYVZsTFc5MHRjanRDQWVWc0R2VXVnTGFnRktS?=
 =?utf-8?B?WENCRGVpUmd5Q0g5Z3U4OFZEODVpekFoM0lEMEVuVHJlVkpaNGYvdWZKVDhY?=
 =?utf-8?B?YUpHWUNtVnNuVHZlY3pJWFlYbVVYS1ZLVExFdHJ3SXF5QzB5QnUxdUlmL2RP?=
 =?utf-8?B?L0l4M3JPS2xhc1NwRElRV2hyZzVUMUlpdGdrOE56UlB5cCtDTXRFOTZVa3Jr?=
 =?utf-8?B?WTI5dktWaHdtelN1am1vMGs0c2NDUmF2Z0R6UUhCampRYlFndTloNmtWb3ZM?=
 =?utf-8?B?ZGMrQmtobkFUSXRPT0dvcVlCY2tpd0ovSGMyQmlxTDAvUUVRNVBrV1NlM2hn?=
 =?utf-8?B?Y3diZEZUODJ5VDNMRkFkOVFhRnk5WWZyWFBJRVRiMExxTzUvWWZSMnJsdXBz?=
 =?utf-8?B?VDBCaC9HdmJZY1NRSlJkdWl5NVVJNm9XYmJheWNBQTVJSG1CdkFCa0MrS01C?=
 =?utf-8?B?ZGhkTksyOGZBQ3BxRmRIUmNYS2dSZWxxVUF4d2xkdzZxVXY0UlZ4UHJyUmtn?=
 =?utf-8?B?c2JOYU9rMTRDTHN5VEpBUDJFdjRjc2VSNnl2dkdEUkU2NVg4MUtsVE1JczEz?=
 =?utf-8?B?U2svMXhENkpBb293R0VaZzc2ck5PbkIxTXZFd003WXl3Q3ZXTEpvVWlKVDZm?=
 =?utf-8?B?NU5EWUFtbzB0eW5QaUtEM2hzczcrVWM3RFNON3dmTThkUThBeURkRzRFSHlI?=
 =?utf-8?B?TjdNOExzVG5JZDc2R0gvTmpQS0dnYnk2V3MyZDg5ZFZkOXdJYVNCN0ZRQWRo?=
 =?utf-8?B?SEI2UCtaeEdWZDRtVHoyUUk5QlRmdVJsOUdOMkpPZmZUOG05ME1lVWJZSytz?=
 =?utf-8?B?QmFHS1lxUi84WFlIR1g4d3ppYnhudzU5ZnVIanBhRERxZ1JlcGRrZTc5MWVu?=
 =?utf-8?B?RTJPZkRtbHhqT3hGcHpuMlU2NTd4cjNuRUJ5THRRQXFvYVU5ZXg5MFR0T3JI?=
 =?utf-8?B?bjZncUg4T2ZrSzN0c01lNiszWVVOQmlZZ1lIWGZvam1aakllMnFGRnRiZDQ1?=
 =?utf-8?B?aDVpaUlRRklmZHJSL3FSQWUzMHV0U2QvNE92OTZUeTZ0b3BEaUtpNnduaWdR?=
 =?utf-8?B?aHdGQnFMSWk0Y0xuZUZoaUlFSUh5RjFuRTk5azBLR0JWZmo5OEh6alNYK1Zw?=
 =?utf-8?B?ZTl0OU5LVFpFUlEzYmUxSGJNZ3poSWhiMXYwSWRHUWlmNEZjMzZkZ1Z1WTdl?=
 =?utf-8?B?R1dkNlRGc21qM1lQWU9TMUliV0pVMUtlOHJLT1lVR1BNRTZVVVFUOTZzOTFv?=
 =?utf-8?B?TWJDSG90QlQ4YXJVZEZXRWZLaE9tOUczOUtCZFh4OVZXSzN1OUpMbFpROUxH?=
 =?utf-8?B?TlcwTkxGclBHS2hTQThiaE1EUWdKdlM1TXFqZVNZaS9md0tKUXZZS2NTMElx?=
 =?utf-8?B?WUVzOXdJNm1XWHRnSWROSHhHWTNGYzNOcWhXQ0IwbUVXUHFZOEh4eGdjalhi?=
 =?utf-8?B?c3loQU1zc0ZiTGZ5Yk1UYkZQOGYrcCtWcnUxRHZyd3gwVE10Vnh1VWpwY2VS?=
 =?utf-8?B?ZUN1MlZjZ1Y2NjlWTFJIMDh4bTE0TjEvejdMOE0vUHZxSGw2cVRCbnN2dGla?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e925bbad-867b-4e97-f36c-08ddd6a0aea0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:26:17.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx6b97v4VGAdpRWKByMx/AA4kLOrJBJzlPUBROTeaUFc+57jQUpqIo8zVqj6uH0BLrT7b4SHky2gTVqkGHsy3u7OCrzxW5pQz2ni2IHiBb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7973
X-OriginatorOrg: intel.com

Arto Merilainen wrote:
> On 17.7.2025 21.33, Dan Williams wrote:
> > +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
> > +			    bool enable)
> > +{
> > +	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
> > +		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
> 
> If I recall correctly, setting the DEFAULT bit is allowed only for one 
> SEL_SID instance at a time. If we consider the root port, wouldn't this 
> prevent having multiple IDE capable devices under the same RP?

True, I'll drop this from the next version. We can circle back to this
when ATS is considered, but that is not in scope for initial enabling.

> > +		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
> > +		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
> > +		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
> > +
> > +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> > +}
> > +
> > +/**
> > + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> > + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > + * @ide: registered IDE settings descriptor
> > + *
> > + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
> > + * settings are written to @pdev's Selective IDE Stream register block,
> > + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
> > + * are selected.
> > + */
> > +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> > +{
> > +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> > +	int pos;
> > +	u32 val;
> > +
> > +	if (!settings)
> > +		return;
> > +
> > +	pos = sel_ide_offset(pdev, settings);
> > +
> > +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, settings->rid_end);
> > +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> > +
> > +	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> > +	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, settings->rid_start) |
> > +	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, pci_ide_domain(pdev));
> > +
> > +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> > +
> > +	/*
> > +	 * Setup control register early for devices that expect
> > +	 * stream_id is set during key programming.
> > +	 */
> > +	set_ide_sel_ctl(pdev, ide, pos, false);
> > +	settings->setup = 1;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> 
> The first revision of this patch had address association register 
> programming but it has since been removed. Could you comment if there is 
> a reason for this change?

We chatted about it around this point in the original review thread [1].
tl;dr SEV-TIO and TDX Connect did not see a strict need for it. However,
the expectation was always to circle back and revive it if it turned out
later to be required.

[1]: http://lore.kernel.org/67bcf19bd1c7a_1c530f29449@dwillia2-xfh.jf.intel.com.notmuch

> Some background: This might be problematic for ARM CCA. I recall seeing 
> a comment stating that the address association register programming can 
> be skipped on some architectures (e.g., apparently AMD uses a separate 
> table that contains the StreamID) but on ARM CCA the StreamID 
> association AFAIK happens through these registers.

Can you confirm and perhaps work with Aneesh to propose an incremental
patch to add that support back? It might be something that we let the
low level TSM driver control. Like an additional address association
object that can be attached to 'struct pci_ide' by the low level TSM
driver.

The messy part is sparse device MMIO layout vs limited association
blocks and this is where SEV-TIO and TDX Connect have other mechanisms
to do that stream-id association.

