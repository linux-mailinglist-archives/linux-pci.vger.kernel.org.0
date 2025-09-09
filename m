Return-Path: <linux-pci+bounces-35711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7154DB49EDC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 03:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2B31B2728E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 01:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9670830;
	Tue,  9 Sep 2025 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3goXct+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49988239E97
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382772; cv=fail; b=WkDIMSCIX/wBCFV4CZ/wgACD84a4Q2z7PLdNfqvo3zjiMGf5T9BSRFR4Ub0ArJHaIBg9WY+cQ5XcAb/ldytpU8q5Zn0I1coaATsbYbSrKAksc+IUSSRFjyfo3GXqxF3R3TCPwWZodJzl8BiZsxOfUvaSk8TjtrR9LOuUZIOrPh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382772; c=relaxed/simple;
	bh=z6YWOKZ+3H4ENdsl68Cp5hngSXuew3pHSEdQoSE3o48=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=kMFWM7ybwI8Akl9iH8NeYkTOBhCm76FNSgYNAwEFO7BdR+LYqlFQYD8+VHyFjDr9nteJ8eVSBJ5i6q2Gd5425GOcT+4Q9rbZQmyxpu3xsAOD/QvhcJWMjC4xnf5gIHf1mb2AzZnT7N/7svumYWDyXPXETvGSG3wWQmd4+o7uMTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3goXct+; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757382770; x=1788918770;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=z6YWOKZ+3H4ENdsl68Cp5hngSXuew3pHSEdQoSE3o48=;
  b=U3goXct+AmUxPh/d4+4pgB+nEfBCcFb0sxNCGLOoAb5l3P5tZmlHKHHi
   xffoS9O7vQyfib3WOQvJwEWIplh3Combj+cCwBN3KfF/XDX9V8DTw7m+m
   GXeRg3Ag6B8hQCKHc8LlVx4NNIKhenbWKwYJ96IPX+0wTLkD+gtM+hmVZ
   C/nCc8i3WNFE4Qrsr1FQtVJ9BgW94kksxdQxniJdkm6pib09pRVsdxkU2
   XvXAr6+WEQUhgVGKmDmPocItNYjSoUs+GccS9wyZaSf0ATgNu07P/yv1b
   m3UScDiff5SFsrha/gszHhzLfEuXcWhqnm8kf9BHgucPOJLkBcSEBGH66
   w==;
X-CSE-ConnectionGUID: v+su7dgZSoyWRo5h/T7LPQ==
X-CSE-MsgGUID: 30ZzaUAnSEqOPNPIAsikog==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70353619"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70353619"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 18:52:50 -0700
X-CSE-ConnectionGUID: Ok4Jl66RTRO1Ft/aDXBH5A==
X-CSE-MsgGUID: xocwVNlaTJOzZF+VLeVfPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="177257869"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 18:52:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 18:52:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 18:52:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.72)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 18:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCX4aAvD+F/Jt0BTYbfOfm4jTSeI7qXXId2SJQ3hG0IBhVRd0MixsrfDq5O95SwyVO/bTtVeI3qXF0xd3gD5ZrqySjKIamJhvISU7yW3w6Zv/NBSX5yZHV2s3kLS/xQL8mgyHi6k/kDHGqHo+5utko4QuEv6C3igKGJIYwBvMUM6TfT3davMvVyZt7UACwDkN1dsHVJDj5xYAradF+CAzZMK0mPtaMyp69TKMFCKmvSKhFtQ+q/BykdQ7RYWDycyxdjvqG/beAOWZVTZm20dsCjJ5yut2O9TqDLUQiUtQVwgRZN6PQgb4veqXa+fmWm3zYJrBAcAZRMVYCJJcENApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXCvkyyD0R6/wR5IHbd+P/2qSMTSKDR+IFt4qfKsjSo=;
 b=EFsb7caUR0pgI6zAOgeqZ+j3MBTQjhd/tJbagm8Ua99Q5NvTSGUbmoFJ4xF27SzH/eZjbafwEIieFkGkueoxMvoPKULbbjikiT97sLmq2+tStl3PWJf9Vz7yhCqkEEuOBw8BDX6mw/ahZ45nzHLCVEYgt2UkATyXunPC/IrfHeEyWpt1p/OJvmy4BAFgQ7jQUXFZBPyBfVTmL28AxQWiCPv8yNmuO7EWlP0U2YpUUkpdfc8WloW1fP0ZHzY50o2FuXzxmmWPX1GfCd1+aer5YffEaMt12lXBeqjRG31Jdf5LQaKcp5YE3wRepnG5C76VQkALBi6nRZnzKIyYrfPF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF8EC896901.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::844) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 01:52:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 01:52:46 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 8 Sep 2025 18:52:43 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <68bf886bc9271_75db10029@dwillia2-mobl4.notmuch>
In-Reply-To: <c920fde0-0241-4ca2-a75f-384f6f18a255@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
 <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
 <a7947c1f-de5a-497d-8aa3-352f6599aaa8@amd.com>
 <68ba33dfac620_75e3100a0@dwillia2-mobl4.notmuch>
 <67382369-d941-48dd-92f6-8bbad7b26b60@amd.com>
 <68bb97518dea6_75db10067@dwillia2-mobl4.notmuch>
 <70c5399e-debc-48ed-a60b-e1921c111690@amd.com>
 <68bf77c923ff4_75e31005a@dwillia2-mobl4.notmuch>
 <c920fde0-0241-4ca2-a75f-384f6f18a255@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF8EC896901:EE_
X-MS-Office365-Filtering-Correlation-Id: b08323c9-74d1-456c-57ce-08ddef43928e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1RrbkFFRFdaQzNHWGYxbDEvemR3aDZxSTc3T2RuVmowd0lUS1I4aWZzb1ZN?=
 =?utf-8?B?OHVlMDFqeEFLbGF3cmovNFdIOEE5bzhXZWlFWVg5WGNMSHFtT2hFRWxjeTRj?=
 =?utf-8?B?bEM4eDBRZnl2dnNqWU9yQ29JZ0pTSVFnM1lteFpwcVlBQkVMcDZuL25PNm5X?=
 =?utf-8?B?MmJ1cVZKaGI3Nyt0Mm1Pb3R1NWpaekY5T2FWd0ExTXJyUGtyWVRJLy9qZFp2?=
 =?utf-8?B?RG9XTms0dVBaaXVUR2ZtSU5oaGsvaUJKenZLSGJ4MUVGbUR3ZSttTFhBcGR1?=
 =?utf-8?B?U1c1OTNzRkhoNTgxQ1hscEhKVkxraG9vRjd4K3g1LzlobldjR2Q1QTFWeksw?=
 =?utf-8?B?MFdvN0Jvenh4dlF2QVo4QmxrMFBVcFpETkVtbEVxNEYrVjJxY1R5bkZmbDJJ?=
 =?utf-8?B?S1lNbERadjF1YTlnTFhMbUtaemt4MU9JK0J0MjZKaG41R0pjYnoweGxSQTNu?=
 =?utf-8?B?d3duRlJ1djhiRjRNN2VBUzRLYVluUEJ0RjhRV0FRdEFIT25oVUpCQ2hQSHIw?=
 =?utf-8?B?RG9lOEJTQzdtbzNEMWZ2aHVmdW9VRHpJbGJlVEdQY05jTEF2WVJZcGlmc05Z?=
 =?utf-8?B?TTM3bVZSaHFQc1kwVTd1dkRqUjl6SkxzZkRIMm5oMEw0YXRkMS9VQnI3cGpv?=
 =?utf-8?B?cGdNU0Q1Njh2ZTAyNTc1OFJlaGFxVWJtZy82SnBROGFzTkgyVVQrRm1GcGlX?=
 =?utf-8?B?Y0w3amFhSGJDSjJ1ZDlEUllrckNmcFM5b0VJRGtuV0tieFNsY3FleDRqeTA2?=
 =?utf-8?B?SmFNZk5xWnJxLzJuRUZQTWFlRWVvVHpyNzBnMHpNYWdkK21mcVRzc3lhNEN2?=
 =?utf-8?B?MDZ3RUJ0WlVSbExlWStQMzNjb1pvcndQVDZxTnY1WGZIbVl0Y2d4aWlFam45?=
 =?utf-8?B?bndjTlQ3OEhHTGM2T2gvZnpicG5GQ0g1bEZvRzIvdWhTSHFuaUNSQ1JiejNL?=
 =?utf-8?B?NndDVDJRVjlENkFwT1d0RkNBTkgxbFJlekx0cTZxZmI5YkZlU2JKLzBDcHFB?=
 =?utf-8?B?M0NvbHJGdnRWN1RwTkFsY2ErUTd5cm1LbSt3TW81bW5BV0RkbXBPT1c1UlFM?=
 =?utf-8?B?Ty9uUTEyMjdrVFk1WHhvZjgyOWlDaklzT3c1U2wzcXgxY0JrRXRCdzVVWlNP?=
 =?utf-8?B?SmMvVGJ1VFVQZWx4SGhqRWgyOTJOOHEvNUZQWEMybGJ5K1A5Q1EwazFyV21E?=
 =?utf-8?B?OGlBZGFVb1gybERWSDJGdTFXL2k0TWo0RHNGc0crNGVlajdrWWlRdVVwQmNU?=
 =?utf-8?B?RVc5WXRKQmFXeTJvRlpKNmRvMmthdGVuS2xUYXN1SHk0L2VRL0hRUTA1dkNR?=
 =?utf-8?B?aEJrbk45NzJPSThtVjE2SmRvZHJ4NVNzZnZ2L0prYXlKTE9DNjNCN1Z3UXNq?=
 =?utf-8?B?dGpLd1dMZEU2dkVPQ0FzWTJQem9GZDAwSGxpN2pTVVRDd0J1ZkljODhHY0tK?=
 =?utf-8?B?WFhFbEF2OUhabHUwVnAyRmhPRi9RLzMrUEllWk5XRjdZdVdkYVB3eS9KU2JI?=
 =?utf-8?B?bEpvOXY1a0lkei9DdTZWM0RrcUJxNWRsYnpZZ2poTVBlNlQ1dlZ0K1dlRlA5?=
 =?utf-8?B?Mk41bmJjRmNWSUl4cS9RWHVtcHd6emE2eE1hUXl0cUlzbFNTZDUyQU9QSCtl?=
 =?utf-8?B?V3RYdWozZXNWMGkzMkI1RlZvZWN2cFpvZ1VXZFJXNFV6VlBtS2JYblVFNWI0?=
 =?utf-8?B?MHhQZnAwMDJ1M1U2YnRoOGNQeGpZeEJ6Z3JqcjZzTk9ZYmZBdWNEaFhYTUVE?=
 =?utf-8?B?MjEwaVRzL1RnS3VyVHgyYUpibEFGTGRRUHdxbDZHS1ZtYkZiRnBEQmRIWmpa?=
 =?utf-8?B?L3ZVOTZWMHhUQjJGY0pWMHcrQmR1Z0JTMDdEMjFVaEExVnJVN2pCY1dvYmpB?=
 =?utf-8?B?WmlRWmh5TkxvMEMvL2d1ejcwNmlIbFRtM3I5blZGUS9VMGZwVzNSTW5FSDBq?=
 =?utf-8?Q?fAAF8xL6Xao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNOTDV6ak1NZGxmbFg3RWl4UGx3TWk0NVBhM0lNWHNoVTh4SUxvZmZxMlUw?=
 =?utf-8?B?TVo2VzVzUzZBd25DTDRjVEZNZmprNUlwNU03VWhkcEZpNFNjdVFpaExmWk43?=
 =?utf-8?B?SHdHd2Q2SUhaeGVrT0V0c3lyck1zRFZRQUFzT2dqUDBuY2xIV05yUkxDbFFw?=
 =?utf-8?B?Lzdndm1FMjRvUXNjMURyeFMvYXREbkhqNWFyNklQZU5ySTUzMG9jb1NxUVlu?=
 =?utf-8?B?RGtZZ3lQSmg5VVpYM3E4cDdhWGFKaWVwQTNPTUNEcVdxTERTSFR5ZGtVUDVR?=
 =?utf-8?B?cWpjQU1EQmRkWm5tSlRMR3R4SnZLYmFLV3diOU5qNmVsbi9pTHJnMVZPenZq?=
 =?utf-8?B?Y0h0azJ5Vnp2YitpV29lRVlyZU5vWmErVkFjOHpmV0RoZjRZSlY0ZWRsbjNO?=
 =?utf-8?B?QWdrQzdXMVA1T29LUS9PSGNEWFJqdEU3UEhCTktmSGYrQ3gyTEE2Rk9RWUtT?=
 =?utf-8?B?K1huT05sdStVUTNmZFZYV2U5a1JiRW13U0ljTTJIb1Z1YUxvdkhtMll3YmJO?=
 =?utf-8?B?NW5HS0ZhQmVkYUFyWEdTVytSa1dTRXJXdjVJZWhSRzUvNkZYVVRLeFhSNWUv?=
 =?utf-8?B?RFpnQjVlNkNHL0pTNWNiclFmWE4rU3RXTUVDWWRlQnRTYkYrdG02UEFqdmx1?=
 =?utf-8?B?UGplQXJPR2wwWVZxRVRWamtydytKZ1pjV2I4ODUrYlJsWjVLdG1TSjVPMktw?=
 =?utf-8?B?azlSSEIyTVJOYm4rd1NjcGdzZStiTkJicTA3ajFYbWk4MzcrMHRzUmZ2L21u?=
 =?utf-8?B?R2VsLzdaZ1RNNlNjcExZOVQyNmJOeSt0Vk1ESFd1Z2RDUWx5OThlVVQ0ODFk?=
 =?utf-8?B?MFVJemViNUJxd0dHa1JQV2xmNHBJcnJheVZQTUxIV3IvY2lmUWF2YStGR2RZ?=
 =?utf-8?B?UkZ2S2tIbkNVWkMxRXpOb0FSY0NmeDN6dTBXOXhKQXMzajVpSzluZGtEcXJF?=
 =?utf-8?B?NXBHek40Q3RnSXZLU29LTU9xazNRV2taWTdPVEx3Wk1VWEpsU0hxREVRUDk3?=
 =?utf-8?B?aE15Z0Zxd1lTYUpycFQ3VWEwQzFFU3ZsaGlhakFoWXVvM3lKQUZUYnMwQzc2?=
 =?utf-8?B?NU1MeEo0WHZydXU0RzdlZlUyS2hxQkxiMm5weWlndE9tSFIvTXFwK1RBQjg0?=
 =?utf-8?B?M2V1cnk0M29ra1RqajdhdXZUZUJyUzhaSnFobVFEU2RKR3dGT2N2MWtjSE5V?=
 =?utf-8?B?NkJPU292UHFLVmxBakxDSWk4K2NnY1lKbWxtYlV5RW5NclIyUVkxUVhMUG1y?=
 =?utf-8?B?UTVNa1gvMmRZa3lSWU9QanhjWG50eFMxODluUXpkcHlaL1pDdTVZUytvcFNW?=
 =?utf-8?B?d00rTVkvUjNNallMRHB6ZHpSRCs3c1dpN3h6cHZVNnB3RzVnSnFzajhqODZI?=
 =?utf-8?B?L1dDekpRUXQyZjdBZTFhM2tETGwyQnBNZ3dZMExlaWFIMDd1alJwNlJ1blhB?=
 =?utf-8?B?UllqV3ZDMFhuRXhUeCtQZW15cEZxL2pvWno5VTVBc3IyT29nZTdTOW15Z09E?=
 =?utf-8?B?WFBUVDNHMGxxMHNqRld5VitLZDRBVHd5bjZrZ3gzalIxTGlGN0o1aHhmVjF4?=
 =?utf-8?B?ZXdFa3ZHUi9RQWwvVW5hNGxUcnI0ZzIrVXlpSTVVQmJWSFUvTHlyeDN0SXVI?=
 =?utf-8?B?bEVCQ1I5djRxUWNXeVhONVlGQWRLeUp4YlEvQnQwb2RXSVVpd3FsVmRRUmda?=
 =?utf-8?B?b0c2NGVKVjM0QU9jeDQxbG55UzAyUUJsZEd6WCs4RkVqR3UvNjg1eVNoZzFF?=
 =?utf-8?B?dnNOYlMzNUVVbUhDZ2FGaTFqdmxHaXE5Z2RGemFrZWNHd0dQNEhyNXFJdzQx?=
 =?utf-8?B?TEdySTdVZjRWdTBOamxJKzhoV2xHUVBTRTRqVTdvVWllV1hUSDJsNjd2SVQ1?=
 =?utf-8?B?WVcwVzlUcWVYWUU0aGZFU3ZPRGtrcWpXbFZ1dXpqUGNmSmZvcUlIT2liUVBa?=
 =?utf-8?B?bkt5MHIwaEU2NUQrOHBnNWxKbFFlZ0pCNEJYZTUzRHFmdnpndVcxVkFyRWpF?=
 =?utf-8?B?S2ZwMHdvNkNVREJhQzNpTWVqaE1TdFlOUlNyWnE3OXVVK1ZoR1JyR1ArZDhw?=
 =?utf-8?B?amdSNi96cUNzTWsrVG1NUWxrZDg5ZWRoQXl4T1duQUxHQWV2Mk9LNkw5cHY1?=
 =?utf-8?B?TTdENy9PN2J6ZVZyMnVzcUpmYjU0b0FyV3FmeSszd2lJcEhpQk15M1hXRUpa?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b08323c9-74d1-456c-57ce-08ddef43928e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 01:52:45.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsRhU0+CxaSc9HM7DkRfEbQaxVNrBSJHQSZK5s+QcDXJWdTehpxPHWzfS67/wSZAYE6KXGS9HAfpn7FE5ShrzPAaLQ9uakVqm6TBcB1hM+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8EC896901
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 9/9/25 10:41, dan.j.williams@intel.com wrote:
> > Alexey Kardashevskiy wrote:
> >>> So PCI_EXP_DEVCAP_TEE means that there may be a DSM,
> >>
> >> This bit I am not sure about. A bit hard to believe that PF0 is always expected to support passing through to a CVM. Thanks,
> > 
> > I am losing track of your specific feedback, or what changes or being
> 
> I've reread the thread, I wrongly assumed "tee" is used to decide whether to show "connect" in sysfs or not. I guess I was a bit tired^woverwhelmed when I made that comment, my bad.
> 
> 
> > suggested here is the summary of what the spec assumptions and what the
> > core supports:
> > 
> > Spec assumptions:
> > - DEVCAP_TEE on a physical function is independent of IDE cap
> 
> Right, I just want to make sure that PF0 that manages TEE VFs does not have to have the TEE bit itself.

It does. Otherwise, how do you tell the difference between a device that
that only supports Component Measurement and Authentication (CMA) in
isolation vs a device that support CMA *and* TDISP requests?

Now, the PCI/TSM core will still attach if that PF0 device has IDE,
without DEVCAP_TEE, but that support is incidental.

