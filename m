Return-Path: <linux-pci+bounces-35452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827DDB43D76
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D82B7C397B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77293043CA;
	Thu,  4 Sep 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZA7DErbu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCFD14AA9;
	Thu,  4 Sep 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993376; cv=fail; b=EEbVXbi1rN0UgP1vhXv9hqjKGqWyHiW6aWV+3sXLJCY6Yut5EtAPSsksBNdRmSCuJ76dRMT/Jpj4AWP9gMIbBxb0gdAoctZC6aS7uJgiLNa4x5MsyKOas3JgMLy9n2wYh8Ak0xAlq3KWylZugHooRd1XeoQABm9UrQmpqhpxwug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993376; c=relaxed/simple;
	bh=POS/dUa8xxKLTWCe2hPor6USEGiu9emGkcLb/S4NQK0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f/vxSN0+QS+VQUJi/SKsEruzikytRvpMJGkegMHAtPvP0L+49DpXaeEmRIFx+84fTVHb9eQrFJp/kOOSVmSLDfqivbOtnJ7sKaklnZwrVP4Ppry5BjPkDGA8NczWdej76h42NiuyjUYUQLa9dHQ1DZ4/KAJhH+flQRq/wPsYtzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZA7DErbu; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756993375; x=1788529375;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=POS/dUa8xxKLTWCe2hPor6USEGiu9emGkcLb/S4NQK0=;
  b=ZA7DErbuA2SjCvOcIEMmicpSb8Obyvcz78j+XMe+Auk5VOCXXMueCPuy
   weGa9YsUX7ZTlHFCSXbzHhWa+mAEtf5J5WIRRKlYlp96qTS1fusmhzwNX
   +NgS5XlGV9FUBZUcwioXMUmU7/51d4zXxeCNr7IW7wNUvR58oKBmWCTXG
   kdtZf+GPmk2/klDJ8eJhxmTEjI5nnKo8AWckk2eBWArMQCrBFfp83R1Td
   xLk+WEgiE68fZ8LFgC9wk6rLihSGlZoxhWZPO3aFe/ybq8xhyUB9yxX17
   0dNSiYPQmeDjuR9f3m7dkY6yhQdxOAQn2zcNOJOlEfMv/70E3qMCBNdfU
   w==;
X-CSE-ConnectionGUID: /xMWNY44SIazgD0HzYsAFg==
X-CSE-MsgGUID: LkmQ8AWuQS2a8fcKpeN2kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70759758"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70759758"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:42:54 -0700
X-CSE-ConnectionGUID: 2bLViFjJTradVh1HME7veQ==
X-CSE-MsgGUID: edykYSzDS4S0EzJEYIi7Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171131997"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:42:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 06:42:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 06:42:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.55)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 06:42:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qhe7NvbgBTwbCrM4CBVJ8GXTgTpHBBJeL5on/oZfxHhj6eXWT5yPNBFnYjjdiiG0L/2K5ohldmTEoU5znlh2KQQokKAxH23hEGNBLUeRokEkJ8sqJAC4GICr3UlGE7c8uDtb1uUBwxqTSBE8bMOVbS6V6AYMvUnuGJ1oIXCe55kPMO0oBlqZzQpDp+yz+a1q2/GUyE0jsHqqGonmENzQKG/80ZvoB5n5QQII/dILTgBDg/RM5obl+kKErLevlinomP9dspWl6nbaWkpNWy5KASUCoZkhgvc3O78YHno5kNSp29MK8N7jTubqw/VxzHw2BLriiBACAuxS8bl4L89TuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HvM+kL6jrFr8XvfQnKlg01okEXAz8OcM3cUi+OlVJA=;
 b=g48Fx/ISA2PHyFYd0wfocLvd9d50ISg0PlQauh4q27jllgEKxWQTu7grT6y36Xj0YohiVJbXAOaiyfWvoXt8zwfCWM+TPzRK+jU1owDF69vs/iX0njRsp+7MjCdLshBq423Ir/YEeyhzOda5Q2MPVumBA7chGpmXBYxF/EZ9r2cBn7Y0KjkSIkAPGReSbfU3U8sZa0vkI2x5E50sT7ZgwX1YzisxQ2aRhkPwEdktb30LsSHkiDraD7YelFHrEjddA3HJTiYxqbf3pKNBPVYl9NrtyiKcR10UT5lXNY6xUFIdx0rRae5WDm4qC9yIPhlfqD//l0zu8ZOurDq20fvVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17)
 by SA1PR11MB7063.namprd11.prod.outlook.com (2603:10b6:806:2b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.29; Thu, 4 Sep
 2025 13:42:51 +0000
Received: from CH0PR11MB5249.namprd11.prod.outlook.com
 ([fe80::a665:5444:d558:23c3]) by CH0PR11MB5249.namprd11.prod.outlook.com
 ([fe80::a665:5444:d558:23c3%3]) with mapi id 15.20.9052.027; Thu, 4 Sep 2025
 13:42:50 +0000
Message-ID: <a5df543c-1c0e-4279-8d17-3d4f67686580@intel.com>
Date: Thu, 4 Sep 2025 19:12:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,06/11] drm/xe/vrsr: Initialize VRSR feature
Content-Language: en-GB
To: "Nilawar, Badal" <badal.nilawar@intel.com>,
	<intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-7-badal.nilawar@intel.com>
 <b0092e98-4f2d-4d29-8200-ef71099786ee@intel.com>
 <1c71973c-a171-4d58-b985-2afe5521bdd6@intel.com>
From: "Poosa, Karthik" <karthik.poosa@intel.com>
In-Reply-To: <1c71973c-a171-4d58-b985-2afe5521bdd6@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::11) To CH0PR11MB5249.namprd11.prod.outlook.com
 (2603:10b6:610:e0::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5249:EE_|SA1PR11MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b65f43-be4d-49b8-216a-08ddebb8f063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THBnQTVCdjU4aWdxNXRaMjhWSnRMUHhNTUlZbTgrNVVwSHJQRy85S1p0M3NK?=
 =?utf-8?B?NXFwOFlxbndHZEx5OTR3dEY2WUdXeGVRZnBNclNmQzkxQko0SWNKNEgxSTg0?=
 =?utf-8?B?U3BFQm5tYXlVUGxzY3l2YnVGU3ZCR0RGanM0NVc5c0JBMWQ5T2dSci9PR0Fi?=
 =?utf-8?B?WFkvNEdGVXkxTVVKVXZhNTkrZllSTFFsbXVOWjNBU3FQdmxaNWZQamRlVG1W?=
 =?utf-8?B?U0NQZjB1MFNzL3psNmlnNnJSekM2OStqcHM2OEZJeFpXWnpmRk1RT3FlMEZ1?=
 =?utf-8?B?cGk5WURoQ3o1dzdiUEtpeDh0cVdEamo0Q1JLZWtqdVdwQ2xJLzBEcGx3eTBt?=
 =?utf-8?B?QkpPVXErdURKL0tZclVyM2lIbHRrRnExR1hsVGVqc2V6K0RISjczRkhXcUpx?=
 =?utf-8?B?U1AvelB4SHA2T2s2NlNSYktZNUlmdUlMVUw0M3VOcGUzTWFZb1M3OWx3dTM3?=
 =?utf-8?B?UzgvaUNNdXYvTHE2YlpXaXZINC9jM0w5T1dONmZLVlZxWHpqMHFNL2Vickpj?=
 =?utf-8?B?Z3NnaEhKTUdKajAvTUdNZURTN0VYTXZSNzhmOW9oMUphQTIvYkhiSGUrTEpK?=
 =?utf-8?B?SFN6QnFsMUpwT3J1bE90NUMvb3ZuQUdoUkI0QmwxY2d3ZUlsSHVTVjN5WCtk?=
 =?utf-8?B?YWh4YzJrVnRreC9Fay9hemUwak8zaHVSaWxlS2RnczVta0JhU1hWK1hjZ1ZK?=
 =?utf-8?B?c3gxM2N2eEU4TXVQZ1lwbDI1M2plcGRQR3l1MzBCRW94N3pBNm9zVkt0NTk0?=
 =?utf-8?B?Z1JMMHJRaTE5M3ZQMjdOUmdaVURlUlQ1UGxzeGlCcjRpUEJ6R3RKQ21mWGF1?=
 =?utf-8?B?N2pRbDYrSktnbWJLeEtiWEhJR1ZoYnhvbE9tYTlVVkNkNElzVitCY0oxckw2?=
 =?utf-8?B?S1NTbkxPMkcyQUlXdC8zQkptenVmbE1oV2ZZNWRTdk0rWXdMMXQzVURtdlJ0?=
 =?utf-8?B?dUlRK3BBbWhwNWIyZUMyL3ZZOVBxQlFvb2s1a3NnRjRVZVhONytrc2RoYThx?=
 =?utf-8?B?NGE3MnF1VU9selFKZkZ2QytEeXBwOWZpMWdsb2hJT3JaQXlaZVB4eGZIQ29m?=
 =?utf-8?B?T0loZ3l6c2xtODZobjZkOVlxVVJFOXBJUDA4TE1JektjRzBLZHV6dytKVjll?=
 =?utf-8?B?TTR5N0czZkNBT1hHajI4c2lWREdteHBWSU5GZGxZZ1RRbWkwajVSNlZvYVpZ?=
 =?utf-8?B?dGtzM3djSC9taG03Rzh3WkYyTFFmK00zaVVUYkdIR3JNdTdZQ3F4dklWZms1?=
 =?utf-8?B?NnJDNFkxem9nanBOUXBITGpiZlpUbGRXL3FLcUFnSFZKLzBZR3YwLzN5ZUNT?=
 =?utf-8?B?RTZrVTkvdXBIT0VLTVB5UzF1Z3BINHRLdCtnYnlPZGpZZHZ0WnZDWnJSOTMz?=
 =?utf-8?B?dDBXTXRTRGk2NHBMZ21lM1dwcTBkN2dkZ3NtRDhLclhGa3dGY28wbU1SYWVC?=
 =?utf-8?B?TysrMEtyaGZRR0RFcTlHeEg5enhlQVJ5OXdLbkZWRkhiTDE0TXZrUjlYZG5X?=
 =?utf-8?B?VFNsejNza0x1UjExY25nRU9QL1JscElOUHFLWVZtNGN5ZlErVWhUYlZvWC8z?=
 =?utf-8?B?TE9ZVjU1SmJ0cDFxbzJsNUR3RDJRc0E2enQwQWtzMUpUc1VCODl0bDJ0UEFP?=
 =?utf-8?B?QWVWK2FneTMvdk5JdDJKZGhqaG9pL2xPeWZ1Tm5POFNYZGJHeEwyRWgwZkVU?=
 =?utf-8?B?TnRNcGRlOW9TWXBkUHBlOUQ3M2lpcVZNS0Z4ZGN1NDFNQlNONVE2cW03Q2lN?=
 =?utf-8?B?dE5zM1ZhWVpyT3grRzdPbUQwT1M3eGRiWUw2Q1ZjbllDRFQrdWxSYjIyZmpI?=
 =?utf-8?B?aEozNkpLdE1Gby9UbXM5ZTdma21qK05jd21WbVZGUEhoeE1RWWZ1cXZGaVhV?=
 =?utf-8?B?TXh1WW5obHRnZ2VJVUVhVjN2cStCcjJIazFwWU50b3JwMjI2WjJ5cXRvZmVN?=
 =?utf-8?Q?llhcohytERs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5249.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3E5REdrVWVZeERtRlNzd3dxTU1jWUxIYVBrRmxUbFRuOXB0OWJ2bEFWTkZT?=
 =?utf-8?B?bGlGeTZPcVFTemVVckxoZ0loOWk3UTAwK1RuMDYyZUFVTmpiMDV5ck5YcFdH?=
 =?utf-8?B?NkZCL0E0eGpOSG4rVUJ4dGZ2OWRTTDRwZW9BSGtPM0FBWk81VFd0VHdpdGth?=
 =?utf-8?B?b01MUEhobGVrNDJnbTEzM2pFdkluNC9WNUdSSUN4TGphTUswRnB3QTBmT0Rv?=
 =?utf-8?B?Znc5THZ0VWYxT1lXZmFTNWpiaHdMc1p2cHYxeEFaeHJidFZxSEVianFxT1ln?=
 =?utf-8?B?UEE2dC9zbkYrcjZqUEpUSUNPc3RGd3VnN1cxbldwQUF5MlVLejB6TE9BeEcr?=
 =?utf-8?B?T2hZVUk5NVpkNU1tSnRuQzdsVlpIVjZHWjNXQ3M5ZGxZR1pNdlFtUUVGeUJC?=
 =?utf-8?B?N3gxb240cTk5d2VlOGR4R3VkaTlqR0cxaVArZnl2Qkdkb1V3NHY4dzRLOWhx?=
 =?utf-8?B?NVRjODZmNmdETmpjVDZDN25PMFZ3VXJXSGxBaVkzbEN0S2lyakRTaUV4V0Y3?=
 =?utf-8?B?WDlERkN5N2pEQ1VOd1llcFFpMnoxYVlia3FleGdnd0tuVGtDclhueEhEbk13?=
 =?utf-8?B?ZjZndlVQNVhyT04razFwSUd3L2g1QjhlY1lGQUZzMTc5ckMzWEcxK3p6YzlQ?=
 =?utf-8?B?MVBVZGY5TnpUeXpzTGhsdnZwNmtNOXBJYlFybklDL2N5UGpqQzJ5VW5UaE0w?=
 =?utf-8?B?QlVabGxtNURNK3N0blRPcjRVYStUQ0ZHWHppOE91bGlYY2t4R1ZRN2o1TGxJ?=
 =?utf-8?B?K1JDelpRb1M1WGt3dElqQ1V0RUdaTFFLTkV6ZzZVeVN4UUdDMFhoR2pZVVl0?=
 =?utf-8?B?Q0RMVUE0eXFjcnpDK2xHcEVzeXdOUmpSbzBZZk8xcEpIWXgrTkNUb0VpQkdh?=
 =?utf-8?B?SkxBQjkzQTkvVVgxSXp3MkJrRlZOV1J5bURXbHJZZVNpWnhBZm45MTJGbEJt?=
 =?utf-8?B?SVdQK2lrV1VFYlZicUJKM09yenJqOFZzODZVdjFpcm9JTVV1aGIwSnkxWXBX?=
 =?utf-8?B?Z3BUS1YzYkUycUhKZS90UGV6dGtRQ0QrM0FsT1FWTXByM01kL0k5cVJDQ0Rl?=
 =?utf-8?B?a09Sci9CWEpndUozbGpIZlhKZG44N0lYdmVvMzgrcFlDSllMekJHc1kzQzhp?=
 =?utf-8?B?WTR4S0NKSmRmRFBNQ2JUeEl6Ri9hN3c0RkgrTmZheWtNcVJRaFkyRUFKb1JZ?=
 =?utf-8?B?b0N6T05Oa3QvdFRYb2p4VkZtYlkrUlRWQW9HR0ZuUG5kZElJeDNjUmJmdzFI?=
 =?utf-8?B?L1JCNElYZ3pDbVllL1d4TGxFcjlDdkN6M0J3dSsxUmtIdmRwc1dEVU9QN1Bs?=
 =?utf-8?B?WHNOSnNBdUJWL1BIZXM2Vk9SNW9mR0NNRkwrNHdQNEFHQUZpeWh0a2pyM3N3?=
 =?utf-8?B?UlgyV3FEQmNReHlKNnBkVkpXWk0rRWorWTVUNXIwQ2hmRnUxY3cyK3JRRjJk?=
 =?utf-8?B?djZ4ZjVQSVlmLzZVT25sZFZXajdFT05PZUV5bGxMWERLOGdzQkU5UUZ0MDdy?=
 =?utf-8?B?MzNGNnF0SWpsS2VoaXVKUmJsVkM5MmpOMElHbkFDSHQzaitPL3NUTVJhS09Z?=
 =?utf-8?B?OFZ0S3JsQXhPNFNVcEEyVlNuRFNna2JGeXJSYlFsMFpvam96cWhYdlRkWWln?=
 =?utf-8?B?UkV4bThabWR2cGIzU2JtSkdhdFNyU01tOUh6MWZlOXErWVoycFQ3bWhnSTRY?=
 =?utf-8?B?dm9OdEF6VFRQZzVtb1o5bXRqSkcwMzV2bnlZMVBwTlBRSmZvbWF5TzJnbVRZ?=
 =?utf-8?B?MjBkTVlNQXVPdDd3ckF4TGU2cHlaaitvWHp2YytEZm1GQ3ZuUy9oY2gvUTVI?=
 =?utf-8?B?OTJqdnYwV1JJcjkxZFdONWhOTzM5U1Bza3RGN0s1bktlb1BVOTF4Y2RoaFRz?=
 =?utf-8?B?aS9YeVF0WWExRzN0ZjdIQ1RsdjB6Tm9DOUtRRzBWRDRjNlNQUzdKWUFDM253?=
 =?utf-8?B?Q1NXazMyNkx3eHhXTkV1MnkrcHZzWGkzUjJtZnJDc3dtRDNIZC93NWdPNHd0?=
 =?utf-8?B?bkFHWFNoRkRKV1BNTEIxNnJQS25qK3U3TmcreDdOUHBKNTNnbll4N0FleVZS?=
 =?utf-8?B?b0hxTVRGQnQ1Wm10YW9VSnJ5MnZLeTk2OTJSWGZOVE1IQ2pmOENEZE9tV1Y1?=
 =?utf-8?B?RTlSUWhZL0JhL3NmVTkycjRjWHM2ZXhVQ2RuQU5GSktDUEhTOEhzYjVSUlcx?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b65f43-be4d-49b8-216a-08ddebb8f063
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5249.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:42:50.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXzUS34FuIVQUSeyscge6yS7BjP+Lq8BrA7nlFsyU9VNA+ZD/A2kTNC0MZ5O/jhIrX0bnOtzjop7O7ysK5LFyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7063
X-OriginatorOrg: intel.com


On 03-09-2025 19:09, Nilawar, Badal wrote:
>
> On 24-06-2025 15:58, Poosa, Karthik wrote:
>>
>> On 29-05-2025 16:46, Badal Nilawar wrote:
>>> Add the API xe_pm_vrsr_enable to initialize the VRSR feature,
>>> requesting AUX power limit and PERST# assertion delay.
>>>
>>> V2: Add retry mechanism while requesting AUX power limit
>>>
>>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>>> ---
>>>   drivers/gpu/drm/xe/xe_device_types.h |   1 +
>>>   drivers/gpu/drm/xe/xe_pcode_api.h    |   7 ++
>>>   drivers/gpu/drm/xe/xe_pm.c           | 105 
>>> ++++++++++++++++++++++++++-
>>>   drivers/gpu/drm/xe/xe_pm.h           |   1 +
>>>   4 files changed, 113 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_device_types.h 
>>> b/drivers/gpu/drm/xe/xe_device_types.h
>>> index 3a15b3a252fd..5f9a1a358468 100644
>>> --- a/drivers/gpu/drm/xe/xe_device_types.h
>>> +++ b/drivers/gpu/drm/xe/xe_device_types.h
>>> @@ -7,6 +7,7 @@
>>>   #define _XE_DEVICE_TYPES_H_
>>>     #include <linux/pci.h>
>>> +#include <linux/pci-acpi.h>
>>>     #include <drm/drm_device.h>
>>>   #include <drm/drm_file.h>
>>> diff --git a/drivers/gpu/drm/xe/xe_pcode_api.h 
>>> b/drivers/gpu/drm/xe/xe_pcode_api.h
>>> index 127d4d26c4cf..f54ef03799d4 100644
>>> --- a/drivers/gpu/drm/xe/xe_pcode_api.h
>>> +++ b/drivers/gpu/drm/xe/xe_pcode_api.h
>>> @@ -43,6 +43,13 @@
>>>   #define        POWER_SETUP_I1_SHIFT        6    /* 10.6 fixed 
>>> point format */
>>>   #define        POWER_SETUP_I1_DATA_MASK REG_GENMASK(15, 0)
>>>   +#define      PCODE_D3_VRAM_SELF_REFRESH    0x71
>>> +#define        PCODE_D3_VRSR_SC_DISABLE    0x0
>>> +#define        PCODE_D3_VRSR_SC_ENABLE    0x1
>>> +#define     PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY    0x2
>>> +#define        POWER_D3_VRSR_PERST_MASK    REG_GENMASK(31, 16)
>>> +#define        POWER_D3_VRSR_AUX_PL_MASK    REG_GENMASK(15, 0)
>>> +
>>>   #define   PCODE_FREQUENCY_CONFIG        0x6e
>>>   /* Frequency Config Sub Commands (param1) */
>>>   #define     PCODE_MBOX_FC_SC_READ_FUSED_P0    0x0
>>> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
>>> index c9395e62d21d..278f2eeeaab6 100644
>>> --- a/drivers/gpu/drm/xe/xe_pm.c
>>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>>> @@ -5,6 +5,7 @@
>>>     #include "xe_pm.h"
>>>   +#include <linux/delay.h>
>>>   #include <linux/fault-inject.h>
>>>   #include <linux/pm_runtime.h>
>>>   #include <linux/suspend.h>
>>> @@ -23,6 +24,7 @@
>>>   #include "xe_guc.h"
>>>   #include "xe_irq.h"
>>>   #include "xe_mmio.h"
>>> +#include "xe_pcode_api.h"
>>>   #include "xe_pcode.h"
>>>   #include "xe_pxp.h"
>>>   #include "xe_trace.h"
>>> @@ -260,6 +262,107 @@ static bool xe_pm_vrsr_capable(struct 
>>> xe_device *xe)
>>>       return val & VRAM_SR_SUPPORTED;
>>>   }
>>>   +static int pci_acpi_aux_power_setup(struct xe_device *xe)
>>> +{
>>> +    struct xe_tile *root_tile = xe_device_get_root_tile(xe);
>>> +    struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>>> +    struct pci_dev *root_pdev;
>>> +    int ret;
>>> +    u32 uval;
>>> +    u32 aux_pwr_limit;
>>> +    u32 retry_interval;
>>> +    u32 perst_delay;
>>> +
>>> +    root_pdev = pcie_find_root_port(pdev);
>>> +    if (!root_pdev)
>>> +        return -EINVAL;
>>> +
>>> +    ret = xe_pcode_read(root_tile, 
>>> PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
>>> +                PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY, 0),
>>> +                &uval, NULL);
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    aux_pwr_limit = REG_FIELD_GET(POWER_D3_VRSR_AUX_PL_MASK, uval);
>>> +    perst_delay = REG_FIELD_GET(POWER_D3_VRSR_PERST_MASK, uval);
>>> +
>>> +    drm_dbg(&xe->drm, "Aux Power limit = %d mW\n", aux_pwr_limit);
>>> +    drm_dbg(&xe->drm, "PERST# Assertion delay = %d microseconds\n", 
>>> perst_delay);
>>> +
>>> +retry:
>>> +    ret = pci_acpi_request_d3cold_aux_power(root_pdev, 
>>> aux_pwr_limit, &retry_interval);
>>> +
>>> +    if (ret == -EAGAIN) {
>>> +        drm_warn(&xe->drm, "D3cold Aux Power request needs retry 
>>> interval: %d seconds\n",
>>> +             retry_interval);
>>> +        msleep(retry_interval * 1000);
>>> +        goto retry;
>> Instead of indefinite retry, can you retries with count, ~3 times, 
>> after which we can return failure.
>
> Retry count is not needed because as per PCI firmware specifications, 
> section 4.6.10 Rev 3.3. Firmware is not permitted to return a value
> in this range more than once for each _DSM instance (located within 
> the ACPI namespace of a single downstream port DeviceObject),
> unless there is a subsequent invocation of this function before the 
> previously returned retry interval has expired.

okay, so -EGAIN shall be returned only once from the firmware, right ?

>
>>> +    }
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = pci_acpi_add_perst_assertion_delay(root_pdev, perst_delay);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static void xe_pm_vrsr_init(struct xe_device *xe)
>>> +{
>>> +    int ret;
>>> +
>>> +    /* Check if platform support D3Cold VRSR */
>>
>> This can be rephrased to, "Check if Xe should support VRSR for the 
>> platform."
>
> Here with has_vrsr we are checking if DGFX platform support VRSR or 
> not. If supported, VRSR will be enabled in Xe kmd.
> I think let's keep the comment as it is.

"platform support" here is confusing, as there is another check below 
in xe_pm_vrsr_capable for actual platform support.

I think we may not need need has_vrsr at all !

xe_pm_vrsr_capable should suffice.

>
>>
>>> +    if (!xe->info.has_vrsr)
>>
>>> +        return;
>>> +
>> Can you add a comment here also, viz "Check if GPU firmware supports 
>> VRSR" 
> Sure, I will add.
>>> +    if (!xe_pm_vrsr_capable(xe))
>>> +        return;
>>> +
>>> +    /*
>>> +     * If the VRSR initialization fails, the device will proceed 
>>> with the regular
>>> +     * D3Cold flow
>>> +     */
>>> +    ret = pci_acpi_aux_power_setup(xe);
>>> +    if (ret) {
>>> +        drm_info(&xe->drm, "VRSR capable: No\n");
>>> +        return;
>>> +    }
>>> +
>>> +    xe->d3cold.vrsr_capable = true;
>>> +    drm_info(&xe->drm, "VRSR capable: Yes\n");
>>> +}
>>> +
>>> +/**
>>> + * xe_pm_vrsr_enable - Enable VRAM self refresh
>>
>> as this function does both enable & disable VRSR, this can be renamed 
>> to xe_pm_set_vrsr(xe, flag)
>
> IMO, _vrsr_enable() is a more suitable name than _set_vrsr. Since the 
> subsequent patches don't involve disabling VRSR, I can remove the flag 
> and retain only the code for enabling it.
> Note that VRSR is internally disabled by pcode upon exiting D3Cold. 
> Therefore, in subsequent patches, VRSR is re-enabled each time before 
> entering D3Cold.
>
> Thanks,
> Badal

No need to change the implementation, let the enable flag be there for 
future usage, just update description to

This function enables/disables the VRSR feature on the GPU.

>
>>> + * @xe: The xe device.
>>> + * @enable: true: Enable, false: Disable
>>> + *
>>> + * This function enables the VRSR feature in D3Cold path.
>>> + *
>>> + * Return: It returns 0 on success and errno on failure.
>>> + */
>>> +int xe_pm_vrsr_enable(struct xe_device *xe, bool enable)
>>> +{
>>> +    struct xe_tile *root_tile = xe_device_get_root_tile(xe);
>>> +    int ret;
>>> +    u32 uval = 0;
>>> +
>>> +    if (!xe->d3cold.vrsr_capable)
>>> +        return -ENXIO;
>>> +
>>> +    drm_dbg(&xe->drm, "%s VRSR\n", enable ? "Enabling" : "Disabling");
>>> +
>>> +    if (enable)
>>> +        ret = xe_pcode_write(root_tile, 
>>> PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
>>> +                     PCODE_D3_VRSR_SC_ENABLE, 0), uval);
>>> +    else
>>> +        ret = xe_pcode_write(root_tile, 
>>> PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
>>> +                     PCODE_D3_VRSR_SC_DISABLE, 0), uval);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   static void xe_pm_runtime_init(struct xe_device *xe)
>>>   {
>>>       struct device *dev = xe->drm.dev;
>>> @@ -374,7 +477,7 @@ int xe_pm_init(struct xe_device *xe)
>>>           err = xe_pm_set_vram_threshold(xe, vram_threshold);
>>>           if (err)
>>>               goto err_unregister;
>>> -        xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
>>> +        xe_pm_vrsr_init(xe);
>>>       }
>>>         xe_pm_runtime_init(xe);
>>> diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
>>> index 59678b310e55..ba550281b130 100644
>>> --- a/drivers/gpu/drm/xe/xe_pm.h
>>> +++ b/drivers/gpu/drm/xe/xe_pm.h
>>> @@ -35,4 +35,5 @@ bool xe_rpm_reclaim_safe(const struct xe_device *xe);
>>>   struct task_struct *xe_pm_read_callback_task(struct xe_device *xe);
>>>   int xe_pm_module_init(void);
>>>   +int xe_pm_vrsr_enable(struct xe_device *xe, bool enable);
>>>   #endif

