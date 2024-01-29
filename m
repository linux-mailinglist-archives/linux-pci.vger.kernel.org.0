Return-Path: <linux-pci+bounces-2705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57AB8401CE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0DF1C21E51
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE854792;
	Mon, 29 Jan 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxRhbUTB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B859158;
	Mon, 29 Jan 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520892; cv=fail; b=PMtT4zeghZ/pTHQIdjaRm8Cja44ml5UnxkGuvC2ptLQ3aKvrR7rg7xsfGZRTB0OqAVbYjEfZgY+e3ruQ8St13IHw4EEyeGQNdETezqYM9jEtqAAPtIdpPlJm06OI788aa4o54iI7yomBu8jCgVa9SVWKAec/+lDNABGCdYqb/EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520892; c=relaxed/simple;
	bh=pwKjl5mXK7djdyTxjv9jXx6KbuB9WU0ulGq3eX7sGeA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mwCt+kJtHU27kytUr2nLBMYnFXwYxH8pV2/i7SVExgbiweai9aa6GUOzKjxkhBsHOaIxDwgBLSKymyWLG5ZWANCm7qHMANAdv7Zj27paTOsG4tJe5gV/e2ux1lNIwb+bdWvhkk+solt2OzkLYPPR4LTBnPeuz41LNdkAkEcmMpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxRhbUTB; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706520890; x=1738056890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pwKjl5mXK7djdyTxjv9jXx6KbuB9WU0ulGq3eX7sGeA=;
  b=FxRhbUTBScpBV0IsyHO2jeLlWFll62DuVSshSesldp69NPCdXiMjYAlF
   NnhEcYNwgdukwerHmRR8JfSuJzfvImmK3WAhxwRJ4WPioOWPLI9DbA0GR
   mVNnY+NK+RBCKo3oSPaDxbfWn4JAcHschil2QnIiq/SKYJD+tx09AzDtl
   E1+RfRtevunE0qTASGNCbVBtPT90Q0t9sRVxJt226bW4XhSK1wg+h6tKW
   Frhd+jrpkRaFkEUZZs0qhF55XuLdRt74V339t62V+nOWGIYmN+p+O5qbL
   2HTbto6eDJP2XtuRjH49b0koDUlm2OL/TVUWSsThX3hd44u8/JP/yD5Wm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="434067514"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="434067514"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:34:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="36075769"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 01:34:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 01:34:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 01:34:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 01:34:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4Tfg7raQbw7stpvGvGr1ygpkeIw6cUWxp+Nir50l+CyRL0JAsxR9uFdlFMUB+67ZdSwNszbPs81OMrlwimLsqaAuUY52gpvGkXZyhoUdxwMPazDni8rJN3F9dvwzkHGkQU7aSEnTPniljocCexasnQbJ79HkuIAOiYqhnpOafpSa4u6aymnHqcAUxu5an8RlOgdaeL/BleT9BSxmkeyuXyUf69p8Adl+9l5d2CZXKj8OS+4yg5nv3edv9kQmuxcuINKXUL5r25a2Jw97w9hZoZKDybAzXcTgHvx96s2NDHXLzFGl0gDgl6x9U4M+8TtepYo2k9FHSFk5eVSGlgfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVe3EZOGf2Lo9xt1E7yEH6J78JqzbY77iC9c8ZfQAjU=;
 b=HTUUJs+Mj3xH+9JlT3R+QrDpm+aOwsg/C/9k2B72ccJkmhX6lmD5feUMb8QR1ffZWr2dXf1j27DSPdK2vTnLsjn+gDqIDiO5LMtiIE8GKQ4Li1qV6ojJdxjZAZOM4+B7VLI2kGOH+RE3Kc38RyZgEWDkLD/ESHRYDQZuRKYOn7nF20FRAuPq0LGdpqsfoX43LSaxkOhMxQxMne7nQbPijoq4yP+bqomcHHMJB2kd4qVaonDruK+5OcOH65U5oKVBpUMxK50YZox8v9YchSX6NXRvWzILJGYYSJ14T6t9TXFL8vYyAjou+d7IJudIOtssAXBtJ8rurj1wbquYRroyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Mon, 29 Jan 2024 09:34:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 09:34:45 +0000
Message-ID: <b7a8ee11-7fa7-4240-9d52-651f17bfe213@intel.com>
Date: Mon, 29 Jan 2024 17:37:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/5] iommu/vt-d: simplify parameters of
 qi_submit_sync() ATS invalidation callers
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, <baolu.lu@linux.intel.com>,
	<bhelgaas@google.com>, <robin.murphy@arm.com>, <jgg@ziepe.ca>
CC: <kevin.tian@intel.com>, <dwmw2@infradead.org>, <will@kernel.org>,
	<lukas@wunner.de>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-4-haifeng.zhao@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240129034924.817005-4-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 37692daa-5e29-4b0a-8b60-08dc20ad8747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rw+7zwfl1riKqNv7N6GPilGRetmowOJAsrTbjhmrbnz/C7U3d1MTR5CMNbnPMME1rDTr0tjNxOP1Yfp7nLbqoRi1AHO25K5wNoG8HUcbzZk6C4wNKXaL6EybxdBqs4A1TAKBMgOBmMhK8jh+Ka5gKn5957SCFz2CUhSoOjNPZ3neIAg04phA9krKtPHzK75c/vR5wBjbB0l2gLdc++JqrdcgJkHzG5quGPEKHsn5fTKWMsk54klZS1UNmWXf5U1zY0EqWPgZDQNnuLvacd5KMiErNnjs2gNLMDxmy13EjIFoLd+Sxm+NwP/S1izO0bsOG0ReTo0Keb5wDOCo7sr9c2JXooENsU/r1rrwF6mMm+AB8rEpbkXOuwkztWnslpKsJs+djrXEWSW4G8IdfPE4NHqcAvYIxStRWUu8W/GzwcVC6CEvIoMKEWrwg1PZy3fmSw+F6xyzQXbjID9vsmhIiWaEzjYmRZZO4j8TPP/FlhKbStGOgEuMJVoU97zJgh6pP446dV7nCaidCg8cVDL0CtDpO9AguufK1zb1ZLi8egwrpaS5slyVqECA2KlYZPJozXCY8DQrOdrZFRK71aylmuRU2BsQph+0/kxQGTkGWti3llALjeBrtGREIsEmjHT0YvVVZNvTv+LlqfPW+gL98A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(82960400001)(38100700002)(83380400001)(26005)(2616005)(6512007)(478600001)(6506007)(53546011)(6666004)(6486002)(316002)(31696002)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(7416002)(2906002)(5660300002)(36756003)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWRBS3ZqWkc3dEVLbW5Yc1l3aXZmeDNhR2FOV21WQkV5a2xxZU0xR01vY2JL?=
 =?utf-8?B?QWl1djVmdzBTdjRhK1JUUjRsV3EvUll4RUF3Y0N1bHpLQnd3NzA2ZGRyRWF3?=
 =?utf-8?B?RCtFR2FXeW1mZEdmMjVQTU5nVHY0akVxNVh6UHpwSGZMV2tjWmZHWDBnRzlV?=
 =?utf-8?B?ZU9QZm9DazFKckFkSkg4NVdUMGhoc2NnNDFVaUpESFNZYTRwUVJuc0pFSTVD?=
 =?utf-8?B?RmRtNkVFRy8wS2RoMUVINDJmVzRnTFUrUlJDL3dmSktqc2MvRFUyUzd0TEN0?=
 =?utf-8?B?T1B0TVYydys2TkQ5S3NaUmpOdVRZY2tvZHV6enVYR2gvU3BKdTJpOEdzRE91?=
 =?utf-8?B?NW56OHdMTXdQdDhieTgzOFl3SWxZMERxODJDd1Z3S2Vya3VxSFlRZUNsWEw0?=
 =?utf-8?B?TG1YUjJDT2Fmc0wyeGh5UzNndTBLL3JOUGdCU2FhRlo5RXNNR01QNDJyczJY?=
 =?utf-8?B?V1NPQklUMElNZ281SllSQlhMVmR3MUlheE84M3plc1FIQXZqUlk0NzRFMkMv?=
 =?utf-8?B?RjNxS0l4RFhkYnlvakFkOGozUWhEU2RJZVNXdDZVYVlNVUVLQndYV0ZoMldC?=
 =?utf-8?B?dmxFNzluTmFEZEZDMmN3akVNQ056eXFrUThvSkgySXlXTzcxZFJxNTJFRnF4?=
 =?utf-8?B?R0ZQQ1VnQm5lQkUrdkdvd1BEcDlRTXgyaTBoRVd0QTNlTTEwUFRablpZNVp6?=
 =?utf-8?B?WmhsY3RKSU1tUDFyckhOVUtLU0M2b05rQy9INjFMcVEvL1RPMUJIa0grSlMx?=
 =?utf-8?B?NitkRXZmVlN1dW1ueUZFTVNFYlFuR0x2Q01iN3dvTzR5UEF6WjdUcHFIOUlP?=
 =?utf-8?B?NXpKUkJQOG5FdExldEtBNjRBKzhXakxCN3FiSVVaeTA3QmdaUXUrY0QyYzhu?=
 =?utf-8?B?UStvdXo1SkIyVzBaQ0lYMXhwYytnb01heGJleVJMSlo1bStPcFlST0U3R25M?=
 =?utf-8?B?dzdHSnk3MHUvVUdJSmhOUk9xdVZRTWVrY0tabG9hRXF5Q0JCSytla0lWdGw2?=
 =?utf-8?B?djZjR1MrNmxMZnd5NnVHMlBEdEsrMnRhOXlUZkZRaFI1MXFON0o0bUI5NE5z?=
 =?utf-8?B?cHNUUWVxbk1tYVJ2b1QrWmUxVmh5dEs3MUxqVDlGUUpOcGtPc1AwdHgyK1p0?=
 =?utf-8?B?TUlvVmI0b25iT2l1a1lkRzdlVmdFbmlORmNaU2twWnc1MVRTOTA3SlpQdklu?=
 =?utf-8?B?ckp2ekxtcFhZa1d6akRNQ2QwWDJxazhjcmwzb005K3BkcEwzNzZjKzVVbzNN?=
 =?utf-8?B?Sm85Q0orZDNFV2IzeG9DUENEeEFxWGt0ZWhLNnNvUWFKWXFrWkhld3RXc0VI?=
 =?utf-8?B?eDZwQ0JlU2k4SHlLeWFndzVEK0hOSmJzUkFmVFNTck1HeUhjQWkyZExiWnBX?=
 =?utf-8?B?cTM2aWlZN1pMeGQxZkN4dm1QK1ZEQ1F1L0plMklVS1FSMWh2SDhsSklNcktX?=
 =?utf-8?B?R21qSzBtb3ZPSWVDOXo4TmdqYWhSTElNUHdDMVc5dm95WGVKNU1BQjl3QWl4?=
 =?utf-8?B?a05pNUtkR1VWTFFUSTJrdFlqd0p2TzBCaUNBTUlpd1FZTGhEd202SDBvK3Qz?=
 =?utf-8?B?T3pndThTUDdiWGM1N0Qzd3I2ZHY5cEx5cm1qVnhTbm9Kckw5dWxEYlV3dnVl?=
 =?utf-8?B?Nll0bnYydFZYb1Y1WnV6UzRWaTR0V1U3MGR6d1pnYWRXaFNGY3hUUDE5S1ZW?=
 =?utf-8?B?Z2R5THhldDJPay8zNXJNSXQ3OHVqWjdxbFlKcE1iY1JKNEVZN0pUSkVnWDZv?=
 =?utf-8?B?Wld1K0RVam1zMG9zWTZNcUNqYldPcnc2bndKZ1hDem1yL3Q0Y3BaclVBYkow?=
 =?utf-8?B?cjg0ajllaVZyZGtuaXdwQk0zdi9mOFB1WDdrdzNwQ1g1d0R5d1FDbmlqa2Er?=
 =?utf-8?B?N3BKTUNRb1RGQ1RxcUhyeUgxOXRWQXdVSGREU1h4RE9sWmdBYmxrWFEyL25s?=
 =?utf-8?B?cjdINWRIb1V3K2pLb1VtUlpwcGl4dk1nRHVkUUxSd1NuK2dJci9YODYvZHVs?=
 =?utf-8?B?WDNiNHBWUzVHWlpjZXR6Vy9leFZwWU02V3NJZTg4ZDV4S0MyN1hSMTg3RDJi?=
 =?utf-8?B?UEYyaG52K0d4TGgwbTR5VWpmOVlWKzVIdm9za1pqdjk5UzNvcFRtTzNBN3VI?=
 =?utf-8?Q?XoqeQd2Y+oDHI79XXq90oJTP8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37692daa-5e29-4b0a-8b60-08dc20ad8747
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:34:45.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8KEo2mQF6zKI960Ok11radY3nleK0hVte4cm5/eMKY/na3RSUswmgm834A2eAPiYw9DRjBDM4rhW0OJ+RlKgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
X-OriginatorOrg: intel.com

On 2024/1/29 11:49, Ethan Zhao wrote:
> fold parameters back to struct device_domain_info *info instead of extract
> and pass them, thus decrease the number of the parameter passed for
> following functions
> 
> qi_flush_dev_iotlb()
> qi_flush_dev_iotlb_pasid()
> quirk_extra_dev_tlb_flush()
> 
> no function change.
> 
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c   | 26 ++++++++++++++++++++++----
>   drivers/iommu/intel/iommu.c  | 29 +++++++----------------------
>   drivers/iommu/intel/iommu.h  | 17 ++++++++---------
>   drivers/iommu/intel/nested.c |  9 ++-------
>   drivers/iommu/intel/pasid.c  |  9 ++-------
>   drivers/iommu/intel/svm.c    | 17 ++++++++---------
>   6 files changed, 49 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 23cb80d62a9a..ab5e1760bd59 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1517,11 +1517,20 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>   	qi_submit_sync(iommu, &desc, 1, 0);
>   }
>   
> -void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> -			u16 qdep, u64 addr, unsigned mask)
> +void qi_flush_dev_iotlb(struct intel_iommu *iommu,
> +			struct device_domain_info *info, u64 addr,

If you want to fold the parameters, why iommu is left? info also includes
iommu pointer.

> +			unsigned int mask)
>   {
> +	u16 sid, qdep, pfsid;
>   	struct qi_desc desc;
>   
> +	if (!info || !info->ats_enabled)
> +		return;
> +
> +	sid = info->bus << 8 | info->devfn;
> +	qdep = info->ats_qdep;
> +	pfsid = info->pfsid;
> +
>   	/*
>   	 * VT-d spec, section 4.3:
>   	 *
> @@ -1590,11 +1599,20 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>   }
>   
>   /* PASID-based device IOTLB Invalidate */
> -void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> -			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
> +void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
> +			      struct device_domain_info *info, u64 addr, u32 pasid,
> +			      unsigned int size_order)
>   {
>   	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
>   	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> +	u16 sid, qdep, pfsid;
> +
> +	if (!info || !dev_is_pci(info->dev))
> +		return;
> +
> +	sid = info->bus << 8 | info->devfn;
> +	qdep = info->ats_qdep;
> +	pfsid = info->pfsid;
>   
>   	/*
>   	 * VT-d spec, section 4.3:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6fb5f6fceea1..e5902944b3db 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1310,16 +1310,11 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
>   static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
>   				    u64 addr, unsigned int mask)
>   {
> -	u16 sid, qdep;
> -
>   	if (!info || !info->ats_enabled)
>   		return;
>   
> -	sid = info->bus << 8 | info->devfn;
> -	qdep = info->ats_qdep;
> -	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> -			   qdep, addr, mask);
> -	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_NO_PASID, qdep);
> +	qi_flush_dev_iotlb(info->iommu, info, addr, mask);
> +	quirk_extra_dev_tlb_flush(info, addr, IOMMU_NO_PASID, mask);
>   }
>   
>   static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
> @@ -1342,11 +1337,7 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
>   		if (!info->ats_enabled)
>   			continue;
>   
> -		qi_flush_dev_iotlb_pasid(info->iommu,
> -					 PCI_DEVID(info->bus, info->devfn),
> -					 info->pfsid, dev_pasid->pasid,
> -					 info->ats_qdep, addr,
> -					 mask);
> +		qi_flush_dev_iotlb_pasid(info->iommu, info, addr, dev_pasid->pasid, mask);
>   	}
>   	spin_unlock_irqrestore(&domain->lock, flags);
>   }
> @@ -4990,22 +4981,16 @@ static void __init check_tylersburg_isoch(void)
>    *
>    * As a reminder, #6 will *NEED* this quirk as we enable nested translation.
>    */
> -void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
> -			       unsigned long address, unsigned long mask,
> -			       u32 pasid, u16 qdep)
> +void quirk_extra_dev_tlb_flush(struct device_domain_info *info, u32 pasid,
> +			       unsigned long address, unsigned long mask)
>   {
> -	u16 sid;
> -
>   	if (likely(!info->dtlb_extra_inval))
>   		return;
>   
> -	sid = PCI_DEVID(info->bus, info->devfn);
>   	if (pasid == IOMMU_NO_PASID) {
> -		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> -				   qdep, address, mask);
> +		qi_flush_dev_iotlb(info->iommu, info, address, mask);
>   	} else {
> -		qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
> -					 pasid, qdep, address, mask);
> +		qi_flush_dev_iotlb_pasid(info->iommu, info, address, pasid, mask);
>   	}
>   }
>   
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index d02f916d8e59..f68f17476d85 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1037,18 +1037,17 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did,
>   		      u16 sid, u8 fm, u64 type);
>   void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>   		    unsigned int size_order, u64 type);
> -void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> -			u16 qdep, u64 addr, unsigned mask);
> -
> +void qi_flush_dev_iotlb(struct intel_iommu *iommu,
> +			struct device_domain_info *info, u64 addr,
> +			unsigned int mask);
>   void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>   		     unsigned long npages, bool ih);
>   
> -void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> -			      u32 pasid, u16 qdep, u64 addr,
> -			      unsigned int size_order);
> -void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
> -			       unsigned long address, unsigned long pages,
> -			       u32 pasid, u16 qdep);
> +void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
> +			      struct device_domain_info *info, u64 addr,
> +			      u32 pasid, unsigned int size_order);
> +void quirk_extra_dev_tlb_flush(struct device_domain_info *info, u32 pasid,
> +			       unsigned long address, unsigned long mask);
>   void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
>   			  u32 pasid);
>   
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index f26c7f1c46cc..d15f72b55940 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -78,18 +78,13 @@ static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
>   {
>   	struct device_domain_info *info;
>   	unsigned long flags;
> -	u16 sid, qdep;
>   
>   	spin_lock_irqsave(&domain->lock, flags);
>   	list_for_each_entry(info, &domain->devices, link) {
>   		if (!info->ats_enabled)
>   			continue;
> -		sid = info->bus << 8 | info->devfn;
> -		qdep = info->ats_qdep;
> -		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> -				   qdep, addr, mask);
> -		quirk_extra_dev_tlb_flush(info, addr, mask,
> -					  IOMMU_NO_PASID, qdep);
> +		qi_flush_dev_iotlb(info->iommu, info, addr, mask);
> +		quirk_extra_dev_tlb_flush(info, IOMMU_NO_PASID, addr, mask);
>   	}
>   	spin_unlock_irqrestore(&domain->lock, flags);
>   }
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 953592125e4a..5dacdea3cab7 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -208,7 +208,6 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>   			       struct device *dev, u32 pasid)
>   {
>   	struct device_domain_info *info;
> -	u16 sid, qdep, pfsid;
>   
>   	info = dev_iommu_priv_get(dev);
>   	if (!info || !info->ats_enabled)
> @@ -217,10 +216,6 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>   	if (pci_dev_is_disconnected(to_pci_dev(dev)))
>   		return;
>   
> -	sid = info->bus << 8 | info->devfn;
> -	qdep = info->ats_qdep;
> -	pfsid = info->pfsid;
> -
>   	/*
>   	 * When PASID 0 is used, it indicates RID2PASID(DMA request w/o PASID),
>   	 * devTLB flush w/o PASID should be used. For non-zero PASID under
> @@ -228,9 +223,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>   	 * efficient to flush devTLB specific to the PASID.
>   	 */
>   	if (pasid == IOMMU_NO_PASID)
> -		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
> +		qi_flush_dev_iotlb(iommu, info, 0, 64 - VTD_PAGE_SHIFT);
>   	else
> -		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
> +		qi_flush_dev_iotlb_pasid(iommu, info, 0, pasid, 64 - VTD_PAGE_SHIFT);
>   }
>   
>   void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 40edd282903f..89168b31bf31 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -181,11 +181,10 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
>   
>   	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
>   	if (info->ats_enabled) {
> -		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
> -					 svm->pasid, sdev->qdep, address,
> +		qi_flush_dev_iotlb_pasid(sdev->iommu, info, address, svm->pasid,
>   					 order_base_2(pages));
> -		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
> -					  svm->pasid, sdev->qdep);
> +		quirk_extra_dev_tlb_flush(info, svm->pasid, address,
> +					  order_base_2(pages));
>   	}
>   }
>   
> @@ -227,11 +226,11 @@ static void intel_flush_svm_all(struct intel_svm *svm)
>   
>   		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 0);
>   		if (info->ats_enabled) {
> -			qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
> -						 svm->pasid, sdev->qdep,
> -						 0, 64 - VTD_PAGE_SHIFT);
> -			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
> -						  svm->pasid, sdev->qdep);
> +			qi_flush_dev_iotlb_pasid(sdev->iommu, info, 0,
> +						 svm->pasid,
> +						 64 - VTD_PAGE_SHIFT);
> +			quirk_extra_dev_tlb_flush(info, svm->pasid, 0,
> +						  64 - VTD_PAGE_SHIFT);
>   		}
>   	}
>   	rcu_read_unlock();

-- 
Regards,
Yi Liu

