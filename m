Return-Path: <linux-pci+bounces-35707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50AB49E1F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 02:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA83B3B5E67
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 00:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BF51F4C8E;
	Tue,  9 Sep 2025 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKo80Lfp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004C1E9906
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378519; cv=fail; b=abrpMT3XSU58b+EFp7KNH8gL15TwWGrh/FeqDCGctfdAdkU6hHph9Rr66VjhivlrYBt4OsrOBQl9hfkCjmnZpeIxQ0D+dZsH8P3+G4ohYhqvr2jw84T4YbNYwdnDFqdEk/c3axBb49QhGZifSzeEsSkm0AJsYbW0v0TUe7U3eEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378519; c=relaxed/simple;
	bh=1oTTp3rLqtDEEaN2QuJ/1mH0PUyntke/+WjZX1sNRZQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=gxgybI1Ds0ujEBTpwdbmBEgyop1n66TygoFvCtsGFwVBmRD8yY152ZFQDIONvW/ZnzU1gTO4KzQlPJF9IVTM+xWrC0oWksOkXi+PZLDPEd0ZnNq/lhNMpTrGW0R8MzaUIoft742PvKYHE7UhbjPSTn/RbFZ7LF0oLsZsVCxTSlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKo80Lfp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757378518; x=1788914518;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=1oTTp3rLqtDEEaN2QuJ/1mH0PUyntke/+WjZX1sNRZQ=;
  b=kKo80Lfph/U1pDPcZI3YBy5oKfzW+OgpJ59xAkoZXcka54v9v4S7e9lv
   vPDYfaPdYWgA2ZbL0DGacOImbOlS/2l73TmJuXm3w5RtKeBoR68698HJb
   tSwQLrmuwG/eOJNTrvkBQvEUt+G3ubRR37ghJTbBGnlLIbhaEXiK51PpZ
   pBQ22UgpEoZ6PgbSjJsLEWX70M3CNt9L11Vi6DxD0fhyqv3Bgn4Hj6xKC
   nHk1JO5FFtSMiFn37Ol+UFqPR6eRoOiwdcfpkKG17w6BtEk1/XEo/KAQA
   bFQ8WVi6ghtPeRuR3bonTElllR/pwMVwR3S8vsbnDYpcHE4ZIck/QwL0z
   Q==;
X-CSE-ConnectionGUID: 46JImWyaSzeV4gwb3RoK5g==
X-CSE-MsgGUID: eHbiUSA+Q7mDOQsqG0hLhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70270718"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70270718"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 17:41:55 -0700
X-CSE-ConnectionGUID: FBxo8BJgR0mMvihMSu4y1A==
X-CSE-MsgGUID: F6SRn/KJTsKqJB5j6LFg5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="173311452"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 17:41:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 17:41:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 17:41:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 17:41:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8j1IlBWu69yjWaFgPg6yXMI5O+nB94kU326/+6b/QwBUo7/h6NYWHZ5wLeEj+fNW19avejexKgoUnvyJPrqumYwcbf5PXC7RDg/XIhJNgmn5w9wZMoyjMFPaPuE7llczhiZim0u0diGMg/OEnKfxBCZLa5hPFqoaUUNPqOrDUSOAZMKA7dBYetqqhjG2JnQRP68shLIwUyd7xkFIo+6j4dsyLNTJLAD5l/PFRbZmbEl7YP/WMGJGrlkFf8BfVNFfuiJu07poTEbmCVip77dRM9eQJNWyJYfz8N6jxL61wktzFM6n0U5y1STMtpzgSDoT/2DnSJxPU/MyIA8KIjTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HQ6b6k7f2gCDjJ11HuJ6RluTUFOp3Q8oh4oC9b59XM=;
 b=lV7YzQ14aj1E9gfC4delTegj4OT1RNJ4bcZWZICKJ6zm5dCJvLYFdshtSy/tORTfGAlWvb17NKwxxsiYy2pAJesVnTh17AMDOPnXSPHvnD0PxOcgJyDXjOnUs2bursa53SXDmspPUJGUE82UzxagmUsPDOmpYw5jw7AErPyoAOFnj58RC+5GkSYeWBFhiWAmYIHKBA9nJrQcf8pkFWF3562jp21T+JgfO9YIFbXgC6dJOKsP4rKN/AguV2lOJi0z81HLar+eV14K2Igh4e+FcYS7TvOpaobSKEYfFiX9Kd3llK00LUIqGYvANGr4LrxLiXtjnHFBC81roMdmDM0r7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 00:41:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 00:41:46 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 8 Sep 2025 17:41:45 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <68bf77c923ff4_75e31005a@dwillia2-mobl4.notmuch>
In-Reply-To: <70c5399e-debc-48ed-a60b-e1921c111690@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
 <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
 <a7947c1f-de5a-497d-8aa3-352f6599aaa8@amd.com>
 <68ba33dfac620_75e3100a0@dwillia2-mobl4.notmuch>
 <67382369-d941-48dd-92f6-8bbad7b26b60@amd.com>
 <68bb97518dea6_75db10067@dwillia2-mobl4.notmuch>
 <70c5399e-debc-48ed-a60b-e1921c111690@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f42f733-dbaf-4bd1-6662-08ddef39a7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGVTdjg0dFBzRzl6cmdzenhkSGdqY0o1d3ZsSVZIdmJHNExLV1JBZ3p2V1M5?=
 =?utf-8?B?NDN4WlRMbGVwejFHTk9QcDRidzM0UzRBU1BRTDRNZ1cwdWpkRHNLYW16WG9X?=
 =?utf-8?B?UTRKWXhzMlNuemw0Z3BKTi9lL05EdTVXV29XREF3aWpVZjBkSTgyb0tUeWJ4?=
 =?utf-8?B?V2pwN0gzZlFVZUpIRU1JM0J4bUh6blVKWVFBU0owcEZMODFtT3ZhWWxtb3kr?=
 =?utf-8?B?Y1hRT1JzMitFT1l6alBTaXhNTXBhTUtFcFNxOG9DZTd2M0FCUjZtZ3NPOGNV?=
 =?utf-8?B?R3p5WktFOUpFZmxmV09IZ2ZmMDNFSlpNSytnYjRZNlkvSWk5QXU2Rmx0bS9w?=
 =?utf-8?B?eGdEVmhIalFUV1VxVEpRV296ZFh4dUlHdTd2V1VMeTU2SHFHREdBTVBmT3lp?=
 =?utf-8?B?MkZnaDZMWVZ4MGx1SnBWY1lPTm5ZVi90RlppclVGWkRQbVZuMnB2T0ZlOGY5?=
 =?utf-8?B?MW5qT2pZbTk5dkZnZnhSN1hZbHJOeG1oanRVbDJBNVlKdXJxMnhYblA4RTJE?=
 =?utf-8?B?V3FqUHdpZXNZNXlBQTBEQnAvK0JVTCtTSHBIT011ZHhIWTlhYWhQU3lnNXp5?=
 =?utf-8?B?aUtHWG5iN3dlcEdZSFNmSWVCcEhjWXpvQTVuUGpsZ3ZWUDZCU2pWU20vL1BK?=
 =?utf-8?B?RFJDZ05GWFVDL1FmUFEwNm5DVGoxazgySnljemVYUm1WcjVjeWxSYW5LNHFU?=
 =?utf-8?B?VkthZmQzZ0RSVDcxUFJ3SUtraTRSRFFIZ3l2NEpXYjVhbWc2Qm5hK0NmRTVi?=
 =?utf-8?B?a1R5MDRtNFJabHFWTWo2U2ZibFdOQ3liVnYzb2RkOW1nQVY3NjIraFhmamlH?=
 =?utf-8?B?SzNoR29DMDFNVmNELzlrTzd2Q3VkUWhuVzVLLzZiT0xsTmxORVMyelJoVnA1?=
 =?utf-8?B?Q3BOTE5BbGpyRzRBQ2Y2NzhXMTlkbzFtVXVrTWlYak5ITGl5UXNhM0FsOXZs?=
 =?utf-8?B?RGt4SDlxZ2hpSit4NHpXbkc2czhNZVlMLzVCUTNSS3l1ekR0M2FpMTVQRlRN?=
 =?utf-8?B?V09VNWNUVGN0M09hYjBzaU9BaGNIT1BNYXNYR3I5WDl2b3pYbVlHdnl2Unox?=
 =?utf-8?B?NGp0V1hsWkl4anE1cFZnOUxkN1Jna1lDOXhKZFpEeWZxcDYvL3pXQUNUaFNq?=
 =?utf-8?B?Um9KSzdFTllLZlJrdzFBamZzSDdXdUtsbExRd3Nhai85bDFpNjlKSk81T01N?=
 =?utf-8?B?UGNxdlJtcDVDZzJjMTdITzdXZm92MlBpV0RzeHpSVlU0NXNwS04ydUc2Q1dy?=
 =?utf-8?B?Nm8vYzh2Vm9KNDZFTlJaa1ZiZ3hMU28yVnUxdFdNbHgrZkMxZlE0UHlrL0Jx?=
 =?utf-8?B?UkxCVHNndDc2RVFoSHczNGZud09DWUVyKy8xV1FnaHFzZlVENmdQS01iTk92?=
 =?utf-8?B?QzBMaTVPR20vZEY2UXJUQjFaKzVlZ29weENVaDFuV1RhUDdiK0sxek1kK25S?=
 =?utf-8?B?dWdXMURRN2t6L2Y1MnVNN0tVTnFWTTE2OHJrS3hkWTB5VXMwT0NMZ0dBNHZl?=
 =?utf-8?B?TmZHVVVGMmFDZXZBSEwxc2VLS0JEcHVRVWJBNld0dC9iczAzOUwrQ2V6dWJY?=
 =?utf-8?B?TEFwN0R2R0E1UHZkMm1EUW5rdFNHWXhpbmI3bEU0ZjhIS2xCcmFMYk1oU3hQ?=
 =?utf-8?B?WXhuUjhFT0t2MUViN3NjbFB5ZUhjTUt3R2JNS2kySXRiZUJnbHVaM2RVK3NW?=
 =?utf-8?B?ZXdHdUJkQUxsR05GaFZEb3NCL3d4TFR0OGd1Sk9MRmFsUlBUUXk0ek9WQkgv?=
 =?utf-8?B?N3hKYjNGbzJMdlFuRFZ1b3pCUkxFMm1hQllmakZxaFAwV21PaHV1YUtnRjV4?=
 =?utf-8?B?bWJCbkEwMDNVTXR6SHZ0QWJSb0FCTCtNZkJjVzJjaDlRMmZOQkE4R3I0RUZT?=
 =?utf-8?B?NEU3UFRscHdwVFh3dXlucmc0aUUwbldENEx2eS9ZVy9Eck1hRlhRdytBRVdv?=
 =?utf-8?Q?rQGJJ4DqZuU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWxyNUtHTXRibXhhWXkreUNMYWwxd3NWZkhnV0VVS2ZQVlhlVnU5eWRHODlZ?=
 =?utf-8?B?dTVvckM2SDdmd2dZK1lGRHluVmprcjVPVGxLREtUK3ZGZ0JkS2pqYVRRZlFD?=
 =?utf-8?B?RkNPNVJqV0pjT3o5cXE3Z3p6ckIxS2pzbVg1K3pUeW40SW5nRDZndVc5MkNH?=
 =?utf-8?B?dWtHdCtYejZSeDV6dmpjSUhDbHNmQTczM2sxekNwaUt5cllPRDZkS3BGVTNN?=
 =?utf-8?B?NG5WOHNjUFlvNytSMVRmMlFtd0lqOFVlU0tPWWQ1V0xHMFJMK3BGSHBrRmZY?=
 =?utf-8?B?T1FKdDZKMS9WVWtpcHgrMzVDSnN2ZTB6V0gwcjJsbklGSGxhcXNEVmtPeXF1?=
 =?utf-8?B?djQ4M0ROQUV1dmYrTllUc3VZeXFma0taV0gxZjNVdklEclF6OC95cmd1ZjB6?=
 =?utf-8?B?NlMyc1dlaERWYkY5bEFEK0xMajJuVWN6bmg4eEpQM1BJcmJJVE02eG43Nkt0?=
 =?utf-8?B?a0VWa0h6SysxZWZaMGFoNC8va1hiamF2WmlaSGRHQnNzY2FsR2liNWtHcDc5?=
 =?utf-8?B?MkxVTVprTThHUDBNWWRWMHFnL3VZOWdXN1NSZ3dXZWZCK0FnTWdSRFRxa3lT?=
 =?utf-8?B?MldSRnFDQ1k5Umk5c0hmRXJDblErWk9VUzZuSCs0R0pvYjJKT0o0S1ZvY0xi?=
 =?utf-8?B?WmNHKzdvbXZXQUpiaGNjWEhsQzMyNEhDdFBFczEvYkx4bURGOXAwTnYweCsw?=
 =?utf-8?B?WjZpQUF1ZEU2OWNpNHlIMzczSE84WGl2MTV0QXl5emlHRzhkaTFXRmladGFY?=
 =?utf-8?B?dWc2dzBNMTZaclAyTVR3Uno1Njh0LzlwbVhIR0duQmxaWk1HdzFVNTh2cXkz?=
 =?utf-8?B?N0l6WkZOUjZmaThkOWYreTlSaTVmaytpb2ZwbGNRVXdVU1U2TXhoS3gxcThm?=
 =?utf-8?B?STJpMTBWVDYrQmRuTmFzbUFqR0g3eS9CTlNpWWI3RllGMEFNMGJiOVZsaEpM?=
 =?utf-8?B?N0E1aUZmcFRWZjFxUk1rZ1ZpMjI4ZzdDQTFVOEJMQ3FPZlFIVjdLZUpZTEt5?=
 =?utf-8?B?Q25zdHRBL1pobFZzVjg2S3NPQzJsKzBibUZTa1BzSGk3WndDZDJ3NVhYMlB2?=
 =?utf-8?B?eXBBWW5XNWtOTytPNmZuOVNYYWZ6OW94djN0RktQZEtSTk9VdGxGR3hEK3Bz?=
 =?utf-8?B?eGpmUE00eng1R1FKRHJyZE16MkRTd2NtUzNFSFZzS3F0TTNnL0phWHNsQkRL?=
 =?utf-8?B?akR5UzVPNXJ6d3V2RXdhcThTVUxhRGZ3cjlVdDExaiszNlg5NEpQY1BKQW9r?=
 =?utf-8?B?bDRyajRiVFk3VUZXRDVmUVBRSnJTaGphM0Q2emh5NEVSTlN3c0kxdDQ5WGc5?=
 =?utf-8?B?TmZveHVoV3lvWTlVM2F3d0x5SkNLOHpORHRpcEFHeGY4Umt1M0E0L3hhSUEy?=
 =?utf-8?B?emhIYVVkUnhtQTA0ZzlrQXJnZ3lZMmpIbFAzZGpQWlZQbWhnY3NwKzVxR2Yx?=
 =?utf-8?B?QTV1K09kcHg5MTNKWXkwVUlpbkxpVUppV0pJWGZ2WW1YajQ2STV6a2Evc0Ew?=
 =?utf-8?B?cDRhRnUwY3pGcjNHdmlFQTBmT1pJdEJVY2xFbzVvL0cvTVdKRFdIOCtCbUpS?=
 =?utf-8?B?K2lncE1Ta3ovVFNqaGxMcENRdlgvdXRyN0xEZlhrd2R2Uzgyd0RIaVpldko3?=
 =?utf-8?B?elQ0bEZuZkpNYjNLTzB2MnpNNWFXUDkvTnBodDVlVnFEME4vRWVUVmp1Q1d3?=
 =?utf-8?B?cURHdGVDUUN1NVI4czR6bTMwMy9iSjhRU1c2V093NWJtTWdBL1RNUnljSTZE?=
 =?utf-8?B?eGh5bWU0SGZqc0sydWkxMlZaTUZ0YzVvUmpIYTBIREV2cFo0REdjbUR5b0V4?=
 =?utf-8?B?V0NyY2JaZTJQNG9rdGJhSm85dkJDMklGQ3lYREg2Tlc5Y1RFeEdiTDREemxR?=
 =?utf-8?B?MW1RT1Qvbi9PTHJsYTkwdDQ5cTR3VXoyOU0wditIa1dqdFdrMGRrYnR3Y0xH?=
 =?utf-8?B?NHBpdDFUdGlidWlZelJUWUI0NTh2ZmQ3Y29SaE11QVJ5ZkxyRWZzTVN5NTZN?=
 =?utf-8?B?Y2dqb0FHRzFtcGx1NCtjaEdIYWFZR1I5eHNyUDlnQXZtSi9DME5jbEU1ZG4r?=
 =?utf-8?B?WC9yZGJGY1BhcjVPajdjV1lHK0s2ODhaSUNhZm1CZ2NHNlQxZFdsV2cwQWtL?=
 =?utf-8?B?RnQ2WHYzMDMrcWdjVmVqTDEwV2V4a0IwQjR1d1l1Q3NReTFrdlFsNU9nckc1?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f42f733-dbaf-4bd1-6662-08ddef39a7c9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 00:41:46.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zQU5PaBB0q3Jgs437XL+xXaEFCO943HAfT8cbvRZ10snOHVblXUK+ld3ispOTYVDL5tng62O08c3XjMZnodcoQ7DByccFc3I3RSO5zqQ9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> > So PCI_EXP_DEVCAP_TEE means that there may be a DSM,
> 
> This bit I am not sure about. A bit hard to believe that PF0 is always expected to support passing through to a CVM. Thanks,

I am losing track of your specific feedback, or what changes or being
suggested here is the summary of what the spec assumptions and what the
core supports:

Spec assumptions:
- DEVCAP_TEE on a physical function is independent of IDE cap
- SPDM for IDE and TDISP is only allowed on physical function 0

Implementation assumptions:
- IDE without TDISP is a use case
- TDISP without IDE is a per TSM-DSM pairing implementation decision
- An upstream switch port DSM can manage downstream endpoints
- Guest needs some indication that a PCI device can attempt to be
  locked. Either device or VMM emulation can set DEVCAP_TEE for that
  purpose.

