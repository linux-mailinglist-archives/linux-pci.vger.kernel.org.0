Return-Path: <linux-pci+bounces-26694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD2A9B1A9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 17:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3443B8A5E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712A115B54C;
	Thu, 24 Apr 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fn5KKVZh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D52701C1
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507246; cv=fail; b=RVAg4vzHYpwbJ0NOIP/0elIW2p6HaYDDwd7e+2zaWSE6YOMMHXn/vV/yfKAugS0oK18jR+55mPDT2QnrxM82H+Z92ZDJrFuUe2SMcmznhzJY2grfDkxmJbS+ptlTUYpbtdjr0uOLrYviYbWaOKTXx2YpigZ2TMLF66sRO/BmjZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507246; c=relaxed/simple;
	bh=vhv4NCWTSHelOyHiJ+BxFQxxj4QXTgE0JHfLfEBiDbQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JZOKn5GikloXcci//dC/S1dsOXt0tY5g+47zZwjfUt50CAsCb7enH/UE/8ZXTC4OumLOgefKi1l8b8gCkW4EgFY0RlkcA9GmTl7p+XTAVdl3uJ+YVne/jYOqSNXDSEBXCRnHOIar8k56VyWQnzBagHV7fl/LG1ijPM+2f9gHHuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fn5KKVZh; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745507244; x=1777043244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vhv4NCWTSHelOyHiJ+BxFQxxj4QXTgE0JHfLfEBiDbQ=;
  b=Fn5KKVZhNAATJFbatzc/gm0asilkwpc8f28KoLWlQiwwxRG66929Qlgq
   gLJb7WEZIZUPblGUxdn3ZHXGPIldu4z0VDWPDbz+cgaloJKfxoooH7PD6
   buEwycN5X95uwotuxWEeC33MnO8aZsf58smNc9RgyE2I+sEdHzxk8sZ5H
   pQEnMnvCRAtMWRv4ahdWoiAdcFhYH5zsNS4CzdLtUg9E4qOhr4wQBIYMy
   e3L7Z+wyTpd/f2lrwpdP6DorI5CwgyLCJ04TybMt9Ed9GTlswJu70bZcJ
   ffmKv2Ga+0nliyK17r3XF7myY0klTe49Yc2fh50NHTSvt78cPEX0dKWeJ
   w==;
X-CSE-ConnectionGUID: dVVRWnuJQ3KUkoRISoT3NQ==
X-CSE-MsgGUID: 9WguKzvxSTaqeX6QPe/joA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46860385"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="46860385"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:07:23 -0700
X-CSE-ConnectionGUID: w46vTFalRWiKgqNBaZHL6Q==
X-CSE-MsgGUID: jUKv4YiPShOHjg64pCEsCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="169859515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:07:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:07:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:07:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:07:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GysLMJJplo+ox6sCzEd5Sq4old8OiQ0Uttul7Yq8FHvA6tB0QUyMmZIRjseK1YAbMiWIihODZ0/YvHpsLJ9ZZC3Ccr+441evjY0+ztCz7PilGfkEy+JzXd59FAxaG2fO6vArqQUfB5R4Kxc79mNan7ieiqsPQKpBwnD/9VLeE8Ku+Oc5LBW+kKSLol06jHX7cMDRhsxeaFcF7hdw6qY87Ewvi7gFWQQCcNUC7T6C0wttKKW8uQUJkbUfnuGTbBZKrZWgx5iQ+aE0235RaoCmkRNQK+JoaRZuwP0xhIEtqSiyHsq9Jed+xkl2euhttpYz6PtCRHHkfsBSgH5m7Xn/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwN0095fx07dupF0Yd4sR8KoUXITKW0HlNE8ytLUe40=;
 b=s9MnXzETbUGVTlQRjXbdzW4KFNYMn7edSTNyg5BIjgxYZ8d/vEtVzX+DH7quMcip1CUhUUEzyzxyTlMLGnIsw6+XpqZFoU2yDMNfGdqQEmtXxgOvQ9OSlNS9S5ZqDSTfFxkxRcLMmiy/Eqjgxz92WG9WtB1i7/33vLfVBo5bSLyNuM6Cupk8DJ5QlLVDyit6exxmvshrbbo7B0kb8q59rxCYLSXXxm+q6BO2ZJPwGm8shdt10G2xUPuiNYQCbaYpY8TFAum5SmwB0AcvwVnFmKQ3hLEoyskuzq1u9pSEwSuuuyVn0M5Yx37AzWP/VXypI+7998CwT5XhPWIrewtewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 24 Apr
 2025 15:07:17 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 15:07:17 +0000
Message-ID: <18b0cabc-6f84-45f2-97db-4f5e2a938aad@intel.com>
Date: Thu, 24 Apr 2025 17:07:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
To: Mario Limonciello <superm1@kernel.org>, <mario.limonciello@amd.com>,
	<bhelgaas@google.com>, <huang.ying.caritas@gmail.com>,
	<stern@rowland.harvard.edu>
CC: <linux-pci@vger.kernel.org>, <linux-pm@kernel.vger.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>
References: <20250424043232.1848107-1-superm1@kernel.org>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20250424043232.1848107-1-superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::15) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|SA2PR11MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 38edb99b-f807-4a41-0335-08dd8341b419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTZPbG13eE8xeDh6enlYMWF5RHBqbm9iYm5wKzlZTEErM3VhMkdwQjZKR05m?=
 =?utf-8?B?SGVlQ2lJdjhTN2NyUDliandBbE5mTStKZ3I0bEI5QlBIWG92OTR2ZWROWGtG?=
 =?utf-8?B?M3ZqakVlbXNZdXFPV2hiTXRYYnRmY2VtL1NnOVVySktRcGk3Qm5xbUN4NTE2?=
 =?utf-8?B?RG0wTG5DcWRrM0tCUFFUMlZGcXMzVDgzM2JXMHlvOThXS0FxSGtmM2IvUjc5?=
 =?utf-8?B?ZzA4N2xsSUtsMStyaVUvUTZQY28wVjBmakVvbFViWkVCQldNNjI1aHBEQWxW?=
 =?utf-8?B?UFVlQWh5eGV3Z1JvV1Yyd3pJVkpOV0UvSEFTN09hVlRkODYrallDQmdiQVBq?=
 =?utf-8?B?d3c1TjcrWDZYdFRCelFGUUxJRGxjKzdTcFNDSk00MXNnZzFDN25oRHNSQlRH?=
 =?utf-8?B?Ym11MUJGMVVud1JTdHBuenNZeWVwTTlvZ0srSEJESnorcitTOExCM2F3MmZR?=
 =?utf-8?B?OE54UVQvKzBHZ2ZKZWFwTHRkK2t4R1lNVFkyK21Bb2hURkxGRXB2TlhNUTFW?=
 =?utf-8?B?M3UxUzB0NG9ReUcwVnBINXRMZUNKODdQaHJoWmx3b0lVOWYyNzhwTEJOc0F0?=
 =?utf-8?B?dWozc3NIcFVMbis1bCtSb0J0YjRBQ25ycnRqZy9IcWJXNDRjNWtNMUpGeDht?=
 =?utf-8?B?U3pob25mMkpVSVFMUXB0d0tJeUFQYWlONVQ5R1FQRTR2cFkyNTgvRVFteGdS?=
 =?utf-8?B?MWJrcEpkMU1NblAzc0FxcE90MElrbHdmRFhBSndyS1FqaHRwMVhOU0JaV2or?=
 =?utf-8?B?cHpBUEF5ZVlDZWwrc2loNEQvaWJUVmErKzRoUkc0eDh2MGpuZHgrenNmVldN?=
 =?utf-8?B?a0QrTXBPcnd3eVhyRmNualZMZWxTWjZmS2ZYNnVVOEpnOHZHUzZpQjlWeTMz?=
 =?utf-8?B?V0lJSTJtcmh2UWNpMmVJOE9qck56K0NNMHg3Vml2aWQ2cTdVd2ROY3VaMmVy?=
 =?utf-8?B?VGhUYlJZY1BXSUFoZFhFT3o3NDFHUSswV2txR2tyRTlab1p4THlzS3l4UXlL?=
 =?utf-8?B?K3JHaW9oaEtHQ3VocTE3RzlDTmNRUWk5eml1bmVnem9WNFBpRUNYTGpBSnVh?=
 =?utf-8?B?YnA4azFkMCtuYThBcEE4N1lrLzJaRTdiK21nQTNHRE9tektQWi91L3gvc0tp?=
 =?utf-8?B?NzVxMmJ6QWxnZTFYM0FGaHpnR2psRUMyVTdkaTk1cDJGVlBpY05ob3RWd3cv?=
 =?utf-8?B?RDN1V2o1cXRaMUFBaHQ5bDFjS21zNzU4MHlTalVNZG5VTDBoaU9vYjlQWmov?=
 =?utf-8?B?cnpKQS9sdUFDV2k2cTVjUHhNSGRhc284aEEvQ09hU0J6VldHS0RPUkFWSlRp?=
 =?utf-8?B?emlFMms2ZWlJRmo5eEZidzBieVorZ2hWWngrSU9BcjBJZUtJQ0FSTEhHYUIr?=
 =?utf-8?B?T0JFUzJJMEFWL1NEVUFmcUNFQ0JRNUl2TU1nSjU3NUIvRWFWR3dWNFdDdUhH?=
 =?utf-8?B?eWgxODZEai9sZXdGUDVicXBZVmhzNno0cXpvRmNoVlJUK0dGdU9IVXpuM3pT?=
 =?utf-8?B?dFhGS09DUWgrYkxJZmw0RnlhYmJ2MWlLL3QxN0ZwSWNnMXpNdy9QT3lDVThW?=
 =?utf-8?B?R0xvT1V3S0Jvd1NGVEpBeHVZTVRPZ3NsQTkwMXhGdlh1d1dyUVJyeGRJbHcw?=
 =?utf-8?B?b0hvbTEzUTBzdUMrWDlrMWdtVU1sL2YzT3l4SWdrZURZNm5yZExhbE9SejUz?=
 =?utf-8?B?cko5Z2JLZUZsT1NhaDg0TVJBd0MzTkJ4dHJ0emswdFN2dlJjQTV4MTMwY3Vq?=
 =?utf-8?B?U3FFK3Q2WExOd3o3RUl6WmVid09IUUpGQlRLZXhmZ2lhRm1ZMUNQdTR6cmRw?=
 =?utf-8?B?OHJrRW1WTWlDMzVDcjVLSFdhYkgwTUNaK0h1VkhLdmpUSDZBa3JseUhXc1Ba?=
 =?utf-8?B?dzdMcVU5cFIzNjd0OVNiT0NMbVFnSXh4YWUvU0tqTWppaW9yQ2NwUjNkNkox?=
 =?utf-8?Q?8dq5F5soQQ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFnZGY2alhhUmNhYm5FVS81Y01qbmdSWGdvUkRYNDBPOW42bEhTc2loSlRK?=
 =?utf-8?B?SGJlbzlCSlZNalNVSmc5YUNiNWYvdEsxN1pSc3dOa2JSWkR4L3RDNWJPMVhX?=
 =?utf-8?B?dGZLU0RBZVVnSjJybzhLeDlma0xObFMzZzdJeEEwemN6MjZpdDhYUVNZU0pt?=
 =?utf-8?B?TS9WcXFqNG9RZzRPc1ZET2ZrTG9sL0VIbiswNjBnaEtzdUpadWNzZ2g4WFBK?=
 =?utf-8?B?czh5K1JVNzFIM3ZQbHlVR2NSbjUwSnFVenh4V0Z2OFZiQ0FNSEhScW9EdEhm?=
 =?utf-8?B?bnA0OThLN2Z1b2JFdVhCcHF1SzdsM1NhY0VLbEVUOWFFN0hzcDd3OHE0K214?=
 =?utf-8?B?NmJKWVVZWmdHdXR4bGc5ZVh6ZWZXQXA5UG44eHhXYThzSXQrckp4Z0NMUEpx?=
 =?utf-8?B?WXlCN0xJNXhtbjB6L2FrdGhaNjdtaU5kdy84cGYreWdlaFZ5bFZaNGQxanQ0?=
 =?utf-8?B?T3dtL3dKcG5xYi93c3BGUjA3SE1VWDVSeCtobGxzRkI0dVA5SE5aYWNoNzh1?=
 =?utf-8?B?aFhrcCtUZDNBdlQyMGFSNllCdEpsUGtIaTIraHprUnRKSjBMd0xJdzBLVFhX?=
 =?utf-8?B?Zk9YLzIrQ1kxaks5Ni9oV1BTTktieStoaDVIT1Z2ekF4bjFRWklDQXNoZ3l4?=
 =?utf-8?B?Z2lCa25aYVByZHhCYW1vZ1Y3TEVmOXA4b0Q4Q0xydGVkWWF5UkRNTHlha3ZS?=
 =?utf-8?B?aUZZSGU4cGNoVWJBeW5hS0RTZTBIRDQ2L1hBVUhJN0Z5T3pGcU9LMXAyV1dF?=
 =?utf-8?B?UFBibHdiWFR5KzRKei9rOENVZnBHcjlBYlpjVnUvUWo3UmtRNWpjQWw3SkV1?=
 =?utf-8?B?Qm5yY3lhM3JIalV0STB6Vy9xTVpCMEV2d3lSbHoxbjlOQnZ5TTRmZ3d5ZEUz?=
 =?utf-8?B?MHdoREJpMnpyL1Y4QmszdldNM1BEYjJteThzM1Bmc2hpTnd3MUNsR3NBWHF4?=
 =?utf-8?B?b1NTbWxmbVRuakNNemtuSzJuSE51UGs1K05YTFFneitrU0R4ZXgvaWtHYjJ5?=
 =?utf-8?B?OUg3U2wyZzNVdEhhYmhLajZpR0JjV1FXTmI5RXNVbGh5aFNzTWp5eWx0L0Jo?=
 =?utf-8?B?VzU0T3VTbnk3Y3NlTUgxU1B4ZVFxdFhtWXpZTVZYazYwOFFlcjdjTTN6MXRG?=
 =?utf-8?B?SmJsWE4vN0JyY2pmK0NmbUpRcnlrMlJTdTJkMmUxZGhFUDhOMFRVaVZIZ3ow?=
 =?utf-8?B?TDMwK1ZnUVRFZkwra1FpdDRYTHdMdlJOcHp4OGhpMEZQaXJSMm1FYk5JaE1t?=
 =?utf-8?B?cm1iV0tqOTRuYm5laFo3UThibm9OTWozbGE0SGNCeEt4ZWt1N0N0STB5Nmhs?=
 =?utf-8?B?K2w4cFBYalFSVHlibmtHWDZrbHo2Vm1JSkNYRjJOZ1ZDOTJzd0hPZFlUeHBw?=
 =?utf-8?B?ZTRsKzUxRlhnWlpnNXB4N2tZcnhVMnROOU0wY0FtMHJOWTY5NTlNZDlYOFFE?=
 =?utf-8?B?UWEySXg2UTZPOUN1YS94WHF3UVRPOGNEVWlrUEx6cGExNGxGMTEvQmlBZ1NJ?=
 =?utf-8?B?Y08wdGJUWmc3WUs3T29jTElXRTVUL2M5aE1WcXkzeE1jQVgreXcwRFBJRUJo?=
 =?utf-8?B?aVNMRkZaaWN0dnRkWHJKdlN4WHVHOEJWekNHTWRRQlhwYVI5cVR3VlFpcFVt?=
 =?utf-8?B?S0NjL2UyR1NzTDNSc1o5WXdvdWJhRk1BR2NUZjJlY0NRWHVNbWh0a1Qrbkxn?=
 =?utf-8?B?OVMwUEhnSkdXOFRrNmM3ZVgzb0ZNWE9hWVRqaUtCSnUzR1hvVWpobFEvNHdK?=
 =?utf-8?B?anJZK1A4RjNQcHUzQWRCVW4zMDBzOTNTM2loY0hFN09ZTHlFWE9sZUZMRmFJ?=
 =?utf-8?B?S29EWS9lZjRHT0w2Z3V0eSs3K0VpSGZoeDc0T1FGWStHVXM2K011TU9SZzRn?=
 =?utf-8?B?TCtrNFhVcEZEbVhGYld0U2I1VlYrcFhJWkptaGZBckJ6bi9Kb2lsRC8va0lV?=
 =?utf-8?B?bDhVTDNCOFA5RjkxK1MyS3dkdm5SbmpQM3VUbk5NVDRMYkpxYkdTd1Y0bkdP?=
 =?utf-8?B?UUJ0cVJsNTM3SzBzQkRmRnlCNWFvMUJ2c20zSW85NFdSQ3Z6QXRkSEo5TmZB?=
 =?utf-8?B?SWIvOExjd3U0bjN5VlhkMGhoNVlNR0RzQ0lZak53V1lVVHpPd01tRDRiTE1r?=
 =?utf-8?B?TkxpWCtEZ0ZZVGJzeHZJcmFZK09heHkxVk5HeCs1VmlvWFYzSC9OVFFKRGpm?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38edb99b-f807-4a41-0335-08dd8341b419
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:07:17.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2ExritpkTBydNOxBTeWnegOOwrkXqW4c7t1pptyFhh0XMfzBIy7HmG/Q3nKz63Z9S/etNiyA/h05fGoSc9M/SmzHF3PMHoqZWRS3ldSg1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
X-OriginatorOrg: intel.com

On 4/24/2025 6:31 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> AMD BIOS team has root caused an issue that NVME storage failed to come
> back from suspend to a lack of a call to _REG when NVME device was probed.
>
> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
> added support for calling _REG when transitioning D-states, but this only
> works if the device actually "transitions" D-states.
>
> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
> devices") added support for runtime PM on PCI devices, but never actually
> 'explicitly' sets the device to D0.
>
> To make sure that devices are in D0 and that platform methods such as
> _REG are called, explicitly set all devices into D0 during initialization.
>
> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>   * Move runtime PM calls after setting to D0
>   * Use pci_pm_power_up_and_verify_state()

You could give me a credit for this suggestion.

Anyways

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>


> ---
>   drivers/pci/pci-driver.c |  6 ------
>   drivers/pci/pci.c        | 13 ++++++++++---
>   drivers/pci/pci.h        |  1 +
>   3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index c8bd71a739f72..082918ce03d8a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -555,12 +555,6 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
>   	pci_enable_wake(pci_dev, PCI_D0, false);
>   }
>   
> -static void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
> -{
> -	pci_power_up(pci_dev);
> -	pci_update_current_state(pci_dev, PCI_D0);
> -}
> -
>   static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>   {
>   	pci_pm_power_up_and_verify_state(pci_dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e77d5b53c0cec..8d125998b30b7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3192,6 +3192,12 @@ void pci_d3cold_disable(struct pci_dev *dev)
>   }
>   EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>   
> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
> +{
> +	pci_power_up(pci_dev);
> +	pci_update_current_state(pci_dev, PCI_D0);
> +}
> +
>   /**
>    * pci_pm_init - Initialize PM functions of given PCI device
>    * @dev: PCI device to handle.
> @@ -3202,9 +3208,6 @@ void pci_pm_init(struct pci_dev *dev)
>   	u16 status;
>   	u16 pmc;
>   
> -	pm_runtime_forbid(&dev->dev);
> -	pm_runtime_set_active(&dev->dev);
> -	pm_runtime_enable(&dev->dev);
>   	device_enable_async_suspend(&dev->dev);
>   	dev->wakeup_prepared = false;
>   
> @@ -3266,6 +3269,10 @@ void pci_pm_init(struct pci_dev *dev)
>   	pci_read_config_word(dev, PCI_STATUS, &status);
>   	if (status & PCI_STATUS_IMM_READY)
>   		dev->imm_ready = 1;
> +	pci_pm_power_up_and_verify_state(dev);
> +	pm_runtime_forbid(&dev->dev);
> +	pm_runtime_set_active(&dev->dev);
> +	pm_runtime_enable(&dev->dev);
>   }
>   
>   static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62a..49165b739138b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -148,6 +148,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);
>   void pci_dev_complete_resume(struct pci_dev *pci_dev);
>   void pci_config_pm_runtime_get(struct pci_dev *dev);
>   void pci_config_pm_runtime_put(struct pci_dev *dev);
> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
>   void pci_pm_init(struct pci_dev *dev);
>   void pci_ea_init(struct pci_dev *dev);
>   void pci_msi_init(struct pci_dev *dev);

