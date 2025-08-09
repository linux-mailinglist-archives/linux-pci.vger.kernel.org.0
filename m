Return-Path: <linux-pci+bounces-33654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAC9B1F1DF
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 03:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383AF1AA6C40
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 01:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2FD274B4D;
	Sat,  9 Aug 2025 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FySdH9p0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8324676F;
	Sat,  9 Aug 2025 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754704372; cv=fail; b=hFS79+SjIEHEz7ZfK3d25kf7m0gfrEIhn6B6jGyTGxUE3plYrgTN584IIu9BQmjoZ8VYZyXU28CdtrSOVbfAcrrn9DbQCDFcLRO5XYrbl1yt8dXywVtCEUlxSSHNeDqJoYkBjZATMgbGQ3zZqBo3XtKXKweh566xfjIfmqgzgdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754704372; c=relaxed/simple;
	bh=4al3a917nD5p505yO/yYG1XN4bmC/UK4bcNRyu24HAA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Jz1tfANJeWw1kcMlTl/f8tG3499PD5zeO/Ncrv0ZVg5tjem+Rm2073GIa18EPNhMMPabg79iNPBAfSGSDJ7ixhGzp9oi7XJtAtld8jKKHl00QxD88SBhBgGQGCleHRjqarLQvzdQnpbFB27fyC+oSoFkkhPCjQyGhwkZ7m48jyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FySdH9p0; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754704370; x=1786240370;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=4al3a917nD5p505yO/yYG1XN4bmC/UK4bcNRyu24HAA=;
  b=FySdH9p0Fe+mQE1ekLlGW4ZN2cLlqVboJ9ZrONozr2z9lPQ2/ynHW2yV
   QqhqDbjm6bcqOMCNwyaYv2BpirAOhFZGQ+y/gZ5ooa/uM3YImtysL9D0k
   I/Eh1hXhsLS6X3eyOQum4TsZaYzcZjQ/0ybtPImfbKOvH82JP2/4e7Qjl
   zWdQzBbr75LTelYe4ErknoEEqGg3wlporgfdVh85jHzVEf/WK+lw1p5CQ
   Oiuw2eKVhEBaUPuhpFVNqDtiW2rQJoYYjAzrHsbWvNaizq31iJoujwShp
   4F248jRMqCsbfvdW4zRtta4Too+9D7a5pkc1QcVbMpttqPtwUXuiwTbLN
   w==;
X-CSE-ConnectionGUID: ZZz5bNQtTMSX99/ibvhyjA==
X-CSE-MsgGUID: tbSxXGDsREmqqhezwhrwrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60854341"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60854341"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 18:52:50 -0700
X-CSE-ConnectionGUID: AEkxjS0yTYGIdeH270fL9w==
X-CSE-MsgGUID: wpj0N988QkS1/uisqjuF0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166252969"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 18:52:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 18:52:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 18:52:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.72)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 Aug 2025 18:52:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O62/bTSe5w2udpzVnmQ8iPiCCuQFntgpZ6RvS0K/uky7biHsGCZQUZSj8d6izfLhHkHG3YjR+FQRtAHMmt7iQm40e2bnop905C4wwYj9f0oHy4JNO2+PsksRZEPuF1Kf56AnSR0UDAnZpMPqAdzxRlzktYe/9BoPeVB/NOeRexZK6zaYtMwf8S3xBc/iJnAqaoLH9i0Nn+9kLEdB72H7hNduQuEvDw1Uko1V6Clk6oL0tQ/67TufspAaqzWflkXOKvv+UgQpknUGA4eRO4C5JeD3VjM1ufxdhex34S8owcGBQCxs8q9uJ0OhbAXsh3nWfvbHSV1DM1IlH9kZne9xow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hxfvbTsS2amQCW6oXntJm8RxIcEfiGD0U9HCmmwP9E=;
 b=qGxOfhbN3hNvtnrzNx1ijybeR6GFqj2bGe2ZK0EekEXFn7LvglgT1yOQCi/SVw2McwJja+ct4/gERyVmKryPVA1zcPLxILBYYL3Zfg4HabY42pnww4ioJrXFAAU/LfuiYeT1HT2Uwsi50ek0hXojkk8OOsJHchL5JrlIX7ZhO3gKxxpCn25eQ3rLkeve9f5I7FjYVFffGJmDrd/faNWyPoX1a/FqF4jgwq58R+YJt1MXGVUasXHXv29tFFNr5iHQQRPvOVIaPFEOQUzXw8TFYB+pei2K1HUVuNCzPnf20zqPDjCmrX0P99BvQnWXkJkjLQtwHp7zb1geXaYbayevoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB9081.namprd11.prod.outlook.com (2603:10b6:208:56e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Sat, 9 Aug
 2025 01:52:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 01:52:46 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 8 Aug 2025 18:52:44 -0700
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Yilun Xu
	<yilun.xu@linux.intel.com>
Message-ID: <6896a9ec60926_cff99100ee@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250807223839.GA65567@bhelgaas>
References: <20250717183358.1332417-8-dan.j.williams@intel.com>
 <20250807223839.GA65567@bhelgaas>
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d17e06-c96c-448f-820f-08ddd6e77039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFVxSDVWY3NscnlHY2lPOC93anY2TEJRNTFhc3JKbzF0ZjVNajNtRmVkN0VI?=
 =?utf-8?B?Y2pETFVFOXNRNnU4RVE2b2lLNGhYaXRhSHhEdkx1R2NqNkQzZEpyc0RJOUtz?=
 =?utf-8?B?N1F5Wld6WE0xZlhVcGRXZERFeVdoMWxRN2JZdHJUekVuLytKSXN0ZmNGdTc0?=
 =?utf-8?B?cFpIU01OVWdLU1JWMkhsVlNHZWdVWGR6SUMzQjRFV1NkaVg1OEJmTEpkZVcv?=
 =?utf-8?B?T29zWkE2b1ZlblViVFlpaHBOa3ZacUpUanFScVg4bXN6dFRZUzBzUUp5V3ZO?=
 =?utf-8?B?V1FBSTRyVG5pdjdLUTcxMEFCOCtNc1o2R2JCeHk5bUZ2UjNuVkVnL0p1b21q?=
 =?utf-8?B?MXBQaWtGZU9KcEtiZFAxWUgyVFoybXROdS94N0tlU2swSTQ0YzVwUnBYMG1X?=
 =?utf-8?B?T3BncDRNZklVNnY4T0FUbThHWDZQSkdXcW9DbUgvSk1iMGgrSkNrSkJZNTVD?=
 =?utf-8?B?akFzMkM5NElXR1VFT04zR2hER1lLYkRxMFMyNzF1U2RjV1ZSU0pXSmJ3K3ZF?=
 =?utf-8?B?TmE1UXpnRkluMll3ZUl6VGgvNkJyNm84emV1dU14S256djJIQmcvTVI4bmpB?=
 =?utf-8?B?RmZPZkxYaEVFTDRvN3ZWNUNIK1JjU3NiNWFRcFRXNE9UQ0pGOHl6ZHJrem12?=
 =?utf-8?B?UGk4WFgwUjNURWFsMWczZnMzN2pYVTUzekFOSlVmRmlFZWZFRU1yN09hY1E4?=
 =?utf-8?B?dXljeHc0ZUtRNTZ4YmdpMnlGNjBXNHNlbjJkMGd5V2hFc2xJeS9xQWtUVnBK?=
 =?utf-8?B?Y0lLbDdBRzl1Uy9TMjEwZW1OU0FVSXJucC81YzR2L2hwTVVSSSsxeGVGT2xQ?=
 =?utf-8?B?cmMzRDcxQlhyNTluOU5ONEI5RzhTZngrSGJLYzdkNFhiSnFGWXFkK2NhTE5H?=
 =?utf-8?B?ZlZPTys2ODRFdWUwRE5IeW5lV3gxdUpSWHNZeUtlTHc5R25VcjA2M0hSRkNR?=
 =?utf-8?B?UHBMTkxJckg1aFB6VDF5ZWRqdDN0ZkdOZDJYMTEzUVpHc0VrYlR4dlBXV0Er?=
 =?utf-8?B?S3lsQjRmdTdTbTFJK3BGVWQ1SytuTlFpYXhaSkV2VXFIUmZVc0ljbHorb0RC?=
 =?utf-8?B?aXN2QXVIVEtBaHBkV3hEWHlHZDVNSW1RVjE0M214azhBdlZWa2pCQlpQNGFz?=
 =?utf-8?B?VzJzb254akVLaWpNTUh2TUtOZG5hYmxmNnFjN3V1cThjSk0wS1REbW9YU0ov?=
 =?utf-8?B?a09Nd3JraXZWSDByazhRTDh0QlFXVkI3RW1mSDIzTEdDZjhXdUdmdXZTNEd6?=
 =?utf-8?B?NnZrMUtiTkFGRHZOUXlmeHQveEVGZmg4aVNpdlFOS3JPOVhjdGRBSzdodDdR?=
 =?utf-8?B?K1JnS2dYb1piOUtNUXRBS0ovenE3RFdrYzVuTTQ5Lzl0U3VITUp3dWZ6T2Nm?=
 =?utf-8?B?ZXV0Y3FXdUZpbjNyb3pGbGhRRjVlUkZzTmhPNHRwakVaODUrRmhIL2NvWGs2?=
 =?utf-8?B?bURCaUQzL09LSGdHZFlrQ1FvaDZ3NU41TjlCUHFEWWp3YmpVdjZIT0xvaEp3?=
 =?utf-8?B?L3dlZ2FERXdDbm5hRmNMZzBPekRJVFVDeFZWV0J5REtRZzl4M3kxZllHMEt2?=
 =?utf-8?B?ZmpHWFZuVVdNWDFyZm82WnhQMEFlYWJTbzlKejVyTGVEaWE3Um5MVGhtNzds?=
 =?utf-8?B?bkRGREdYV2hjdk16VU9QNTR3ZlBkeS9qQkRzUU10OWM5Z2NvbnM5Q2xhSVNB?=
 =?utf-8?B?MGpkRXlIM0dRcnRoc0xNM0cySHM4cllCRHUzejNSaGFqVkc1UFpwQUxJbnIy?=
 =?utf-8?B?eGNRRGFxR0hubjQ2b2VLcnBwTlRGMnBVcHhzeXpKTlc3VldKRG1tMUF2MmhW?=
 =?utf-8?B?ZEh4bjNuVHN3TE1lcUs3dGh5MFIrQjFwQ0duMjl6Nll6eDRKb3Q5Z0dheWY3?=
 =?utf-8?B?ZG8wWWw2TGo3WUdqRXdTYUsySUZReTE5RnZGTFNNQnkrVHBvdUZqS3RMSHRl?=
 =?utf-8?Q?0fUXHL6P1Z4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2FBbHEvY2laUE1PL3BuRzh2NUlQR3RNUGcxK05aV3pNVEFmZGhEQUNlMUJ0?=
 =?utf-8?B?SnRvNTZWWGY5SWJHZk9BTTRBMWhpSEZtdTNCVWhwSXNiL0NOOWl6RDBkMjEw?=
 =?utf-8?B?SjI5cnprS2QrckJndGVoUzlJUWEwZkh1VmRzbHR6K1cyTnA3aFc1Z0RpeWV3?=
 =?utf-8?B?c3A5Z1B0bjNuSnFoSlBHMENTVDEzZVY4WFMxYUdiM2tkMEV2WlNpTVBqS2Z1?=
 =?utf-8?B?ZzQ2dUpkQWdCdU4yK1YxT3QxSDZQVjFFMTF5OUc5dVBZRU5jWHZyL0M1L0JF?=
 =?utf-8?B?RElDOUlBRGpkVmRVU0RLRDk5VDNTZE00UjA1U1RnVzc2MEE5OUcvSEgySG1H?=
 =?utf-8?B?ZWNlNEpoeXRLZEVyV2hrOWJBQVpUMXc4WXh3L3FudUJzNS9tRW9Ub0g1T0lG?=
 =?utf-8?B?QWpXL09MM0hkbzBwVkpaL0JrMXRrcFkrTHhuSlgxbzBNa3RnN2hONmJGSFpN?=
 =?utf-8?B?VnZyWkdBTTA3Qk8rSktwU2ppMEI0QkdVendIZFBVMnBhcDgvOEFDRC9CVmdW?=
 =?utf-8?B?NUo1RkgzbXI2SmxjM3QzdHV1VWhzUUk5TUZQbWZUSGZwNXQ4S1EyMUJxek9u?=
 =?utf-8?B?S2VUK0V6aWpIUnJ4N1ljL1huaDA4ZHFYWlR1MDlTOEFqczZBbndVWktEL0d6?=
 =?utf-8?B?bktMY1FtS3FjYWpreDZJYlZ0Zis2T2VmcE9GcG0xM09Kb2N3Ykh0VTJmbmVS?=
 =?utf-8?B?YkIyKzdWOFFNbUVQN3pkT3RraVg2NDFmWFhOQ0JVVTRtSDZKWVRDL29rckty?=
 =?utf-8?B?QlpZSUFLbHJLMFRoS3h4SjltY0t5ZmN0Q1JEdUExcnQ5d3RJNzZsWVNXeVlt?=
 =?utf-8?B?UTVTa205MGJJOVJKL0hhTk01Uk1jU1FKbE5QUk5aVDFkakFld1lVaEZXVUZn?=
 =?utf-8?B?dkdnREtLUExhL0hJOVdvTGttTGNEM2hQUVBhTk45VHBxYlR3cGNETG9ya3lZ?=
 =?utf-8?B?cC8vK2VHazVxZmVXWGMyQXhtaEJMdEFVSGIvcm9sZVhoSFZ5ZkZtU1U2YkRy?=
 =?utf-8?B?cC9COE83TmJodzNmaU5kbE0rVkxxTUtyKzFqQmpaelN3MlBtQTBmRnB6bHZG?=
 =?utf-8?B?Tzl6RmVJR0FBclhXY3ZSbndrYlYxNTA5cHAzVXNBVlk3clQwQXRuTHY4MXM0?=
 =?utf-8?B?bkxqdEp1WSsvMEFWbit4U0dUV1hMRXRNZGZFd1Nyb1NSYzVLYUZCNDBRbEVq?=
 =?utf-8?B?S0tYUVZlVUs4MS9aWmFXNFR2SUZiNkV4MVdoRVptd1RxM1doUnFGMjlJTUpx?=
 =?utf-8?B?UnoyOXE3aEo5anYzc1pVUWRHMXZmVVZ1MGRhRGw3YUJVdTEySVVFbmVkU2tM?=
 =?utf-8?B?WCtRMHF5cHBPYy9BUnNYUTA1NzJLY3UwS3BUbCtITVJPS3FGbjlhYUU1cUxt?=
 =?utf-8?B?NU1uK01RQnB5R2hEYThXQXlIYjVHMjlWRjFoZlYvSTVSOGJiV0ZoOHUyUHdU?=
 =?utf-8?B?Ny9md0NXbTNBK01oVHpOOVI1YzdQNHlUdnNFVlJTNWNOVml1aW0yVE15Y1pN?=
 =?utf-8?B?Um5BN1E5QlpZazhPUm5hVkd5eFhKc3N1ZWlSc3ZiM2tYdTU0dkdPN1VEWEJq?=
 =?utf-8?B?aXNvYlhvcVpOdUZYZjlCdTJqSkh2QURFRHF2YXVUUnMrSnp3T21tVjlrQ201?=
 =?utf-8?B?YzNUTGFNMVVZdVc1YitoalhZT3NVVlNQS1dnZ2RPNlNXTHZ3WFdYcU9Yc3Rs?=
 =?utf-8?B?K2pYd1pLRkIrRVplUFpTT3F3RzUyQlhLdnl1SWtoQWREdE51c3BwNFI5bjlJ?=
 =?utf-8?B?enN4cGpGZXg5dWlEZnBVSmp1QVhKSm5TazAxSWNIL2VsajkybHNqZlVXdVRu?=
 =?utf-8?B?T0NVT2pJRGFkSFdBcmhUNlNXZGZhd1VZNHBDN3FxSmV4ZGhRVEhBRHdhZG5s?=
 =?utf-8?B?THFoNmZXSXlNMEpybkw5Rll4Z3hnVjIrVWplT3pGYUtEc25URUJ2NVNVRUJ0?=
 =?utf-8?B?bUdGc0tiVEFqaFNJa0NqTFZKODVXdzVBcDF1dXYxRXhTNGhMc0pLbUpqNUFJ?=
 =?utf-8?B?TjFMMmlGOEpvUW5wUkxwWFR5c0VLZGxDMFRsVkpvRVI5NjYrTldwRENxSHZq?=
 =?utf-8?B?WmNTaWpHNFZyaEtKNmdIMVM1dXZOVWFDQ3NiNU9kcDhjcVJBV0Z6LzEzZnA3?=
 =?utf-8?B?WGh6RmFjbG5WVzVXQ09sSjhUSlJDL1NjNWEyLzNTWnVqNElwZE9Xa3JRQ1Va?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d17e06-c96c-448f-820f-08ddd6e77039
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:52:46.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oye0c4CQHLPKVEdZmdRCNZ77rlDjQmXagrn3d5POzsgVNNucyL+dtsVoBZtsYtL6GNu4DL/xwKAYBQeWUiFhkw6AuW62nSHmYA+NvkJwIuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9081
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Jul 17, 2025 at 11:33:55AM -0700, Dan Williams wrote:
> > There are two components to establishing an encrypted link, provisioning
> > the stream in Partner Port config-space, and programming the keys into
> > the link layer via IDE_KM (IDE Key Management). This new library,
> > drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> > driver, is saved for later.
> > 
> > With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> > this library abstracts small differences in those implementations. For
> > example, TDX Connect handles Root Port register setup while SEV-TIO
> > expects System Software to update the Root Port registers. This is the
> > rationale for fine-grained 'setup' + 'enable' verbs.
> > 
> > The other design detail for TSM-coordinated IDE establishment is that
> > the TSM may manage allocation of Stream IDs, this is why the Stream ID
> > value is passed in to pci_ide_stream_setup().
> > 
> > The flow is:
> > 
> > pci_ide_stream_alloc()
> >   Allocate a Selective IDE Stream Register Block in each Partner Port
> >   (Endpoint + Root Port), and reserve a host bridge / platform stream
> >   slot. Gather Partner Port specific stream settings like Requester ID.
> > pci_ide_stream_register()
> >   Publish the stream in sysfs after allocating a Stream ID. In the TSM
> >   case the TSM allocates the Stream ID for the Partner Port pair.
> > pci_ide_stream_setup()
> >   Program the stream settings to a Partner Port. Caller is responsible
> >   for optionally calling this for the Root Port as well if the TSM
> >   implementation requires it.
> > pci_ide_stream_enable()
> >   Try to run the stream after IDE_KM.
> 
> IIUC this patch doesn't actually add this as a "flow"; it adds these
> interfaces, and I guess it's up to callers to use them in a way that
> establishes this flow.

Right, common helpers for low-level TSM drivers to use with an example
of such a driver (without all the arch specific complexities) in
samples/devsec/.

> Maybe indent a couple spaces and add blank lines between them?

Ok.

> 
> > In support of system administrators auditing where platform, Root Port,
> > and Endpoint IDE stream resources are being spent, the allocated stream
> > is reflected as a symlink from the host bridge to the endpoint with the
> > name:
> > 
> >     stream%d.%d.%d
> > 
> > Where the tuple of integers reflects the allocated platform, Root Port,
> > and Endpoint stream index (Selective IDE Stream Register Block) values.
> 
> > +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > +What:		pciDDDD:BB/streamH.R.E
> > +Contact:	linux-pci@vger.kernel.org
> > +Description:
> > +		(RO) When a platform has established a secure connection, PCIe
> > +		IDE, between two Partner Ports, this symlink appears. The
> > +		primary function is to account the stream slot / resources
> > +		consumed in each of the (H)ost bridge, (R)oot Port and
> > +		(E)ndpoint that will be freed when invoking the tsm/disconnect
> > +		flow. The link points to the endpoint PCI device in the
> > +		Selective IDE Stream. "R" and "E" represent the assigned
> > +		Selective IDE Stream Register Block in the Root Port and
> > +		Endpoint, and "H" represents a platform specific pool of stream
> > +		resources shared by the Root Ports in a host bridge. See
> > +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> > +		format.
> 
> s/tsm/TSM/
> s/endpoint/Endpoint/
> 
> For "(H)ost bridge", "(R)oot Port",
> 
>   - Could use "Host bridge (H)", etc, which makes spell checkers work
>     better (trivial, I know)
> 
>   - What's the format of these parts?  From the patch (and the commit
>     log), it looks like they're decimal stream index values?  (I don't
>     know enough to know what stream index values are, but presumably
>     users will.)

I clarified that a bit:

"A stream consumes a Stream ID slot in each of the Host bridge (H), Root
Port (R) and Endpoint (E)"

Presumably users that are debugging why they are unable to establish any
more streams can use this to discover, for example, "oh, I have resources available
in my Host Bridge and Endpoint, but the Root Port is out of Stream
slots".

> 
> > +++ b/drivers/pci/ide.c
> > +int pci_ide_domain(struct pci_dev *pdev)
> > +{
> > +	if (pdev->fm_enabled)
> > +		return pci_domain_nr(pdev->bus);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ide_domain);
> 
> Not mentioned in commit log.  Maybe it doesn't need to be.  The only
> call I see is in this file, so it looks like it could even be static.

True, not sure why I thought this would be consumed by TSM drivers.
Fixed.

> 
> > +/**
> > + * pci_ide_stream_enable() - try to enable a Selective IDE Stream
> 
> Do or do not.  There is no try.

Ha! It does always enable, it just may immediately transition to the
error state if one of the partners is upset about something.

> > + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > + * @ide: registered and setup IDE settings descriptor
> > + *
> > + * Activate the stream by writing to the Selective IDE Stream Control
> > + * Register, report whether the state successfully transitioned to
> > + * secure mode. Note that the state may go "insecure" at any point after
> > + * this check, but that is handled via asynchronous error reporting.
> 
> Maybe recast this as "Return:" instead of "report whether ..."  At
> least, I assume this reporting is done via the return value.

Yup, that is better.

> 
> > + */
> > +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> > +{
> > +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> > +	int pos;
> > +	u32 val;
> > +
> > +	if (!settings)
> > +		return -ENXIO;
> > +
> > +	pos = sel_ide_offset(pdev, settings);
> > +
> > +	set_ide_sel_ctl(pdev, ide, pos, true);
> > +
> > +	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
> > +	if (FIELD_GET(PCI_IDE_SEL_STS_STATE_MASK, val) !=
> > +	    PCI_IDE_SEL_STS_STATE_SECURE) {
> > +		set_ide_sel_ctl(pdev, ide, pos, false);
> > +		return -ENXIO;
> > +	}
> > +
> > +	settings->enable = 1;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
> 
> > +++ b/include/linux/pci-ide.h
> > + * struct pci_ide_partner - Per port pair Selective IDE Stream settings
> > + * @rid_start: Partner Port Requester ID range start
> > + * @rid_start: Partner Port Requester ID range end
> > + * @stream_index: Selective IDE Stream Register Block selection
> > + * @setup: flag to track whether to run pci_ide_stream_teardown for this parnter slot
> 
> Wrap to fit in 80 columns like the rest of the file.  Add "()" after
> function name (below too).  Jonathan mentioned the "parnter".

Done.

