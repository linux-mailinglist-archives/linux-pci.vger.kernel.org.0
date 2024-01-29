Return-Path: <linux-pci+bounces-2704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B703B8401BA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 10:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A16B21526
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4808C55C3D;
	Mon, 29 Jan 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNXj2Gys"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689056440;
	Mon, 29 Jan 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520618; cv=fail; b=uumVHHUl5e2KvTcAu0mOkjoTzZ6WscKQkdryDWnQ4pCRBH2DlH0T0e3mB0qwv6Q0ErFoIEAkN1UkLxiGgkTvgtV4vJRGArJz2tJDdRvSVA0NjZ+XkyND6E6RGGjJXmjNG1qnmygEWyF9yrC1j+eoBPAsVqP6ccOi5MgMEga9Amk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520618; c=relaxed/simple;
	bh=uehg18cG3uf2BpytZ7D5iRCjOxenS0VHaSgVEB21JoM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GWP04I6hn9GSKN8gWTBtFz2FUdyOpduwVBVPRjlNR7YlYYo095xKicFnIUOxWYExGfdwXRShbiN42EpzqWdTjM+aYruSqDTudnOfsP4fpT70iN4YhaHgEWntnztFoGOJXqgmwJwY+MkfR2lLsrFgtst+TT51Agi5GnMjtfQ/WQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNXj2Gys; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706520615; x=1738056615;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uehg18cG3uf2BpytZ7D5iRCjOxenS0VHaSgVEB21JoM=;
  b=KNXj2GyswFjpbzchydPGTNCoSaRM/37csaP5h/JLpc2Jrnhyi65/kwgF
   W0RudJM8AWEYfCbrtwJ/+wW3WXncQOpbsuBiSr+ppUSZAJ7ZbtZ9AdzRw
   v+M32rAC+sQmSW8zENQT+oHC6TgLdIe8oTYne0gOH4U4afQ88antoKGqA
   WdAg8vU9LJfH+jkjD+geKhyPyDxpz6ENCwa6XLORLysUygpXtSmcax2Z0
   GVWcx7JbGMrvM9FDyRn336RmUD8rDe0GnvwZ3HXg5b32fAHxnheq6ORFI
   8Iew9eeNDGfCPJt/lxPO5Vx3irhrh5MQPyUhDGJ9NSDQmbWvJRs6kdoQ/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="393336797"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="393336797"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:30:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="29460730"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 01:30:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 01:30:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 01:30:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 01:30:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F84qUz7+VTa2+4np0OFRPVKY29mkaMMsARcz0Sbh6ezN0OwG0UvwkheuAPk4EUhzweYF0AA7kmI41VR2kiBxrIlT45+e3lq9pzzy7ZxwRq8vUDEZwfrnlO8Z+EX0klZ0ZNsxOwn43TaAtgiR/59h2g0ZhGdRG8qMz/as05d/fn6n/rH0J9j0O/Yig/b8Is339nIriEpxZoBZFipTOh2/ur8+ZLeD3k5cP/UxpGq0RG6JczcDVjSkMZw9PgNKAfT3l9BmibB9sj/dC7EOAWhw/2cwtu0e1TepgCNr9Cv1wUKOG2OasvxsgP6qcHrxQ+QnuH4L5ZeUpJbQ1/lHyv9kKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxAZRBQLvd+CzmXQXQn0TU8zRy1OFV82QRoWTGGoZBw=;
 b=Ellla3DdTyxKBzWPc1dB6FZo6qGOnuabNdAaSFpffuousmx2uaugY9Emix4iJm66/VMOLqot28rs5pJsWZO2qiXFy3S2XVKqul+eyz2mETQnt7kLq0MmZsjZOdAz+gSzUO/7Iv8fDFf54OtM2bfQUqeYOglD/1kHw13oHywW1Z76sXEIYn6xMVn/z4ibKxeQHDV9lSab1UvHNiv5Zj0sflabzJHzBjeA+Uqt3hATsTZxrjfCrXFmgep6zKOs10Gd5JH/wZu8pargjfzkH03CHhMsNnj33bftuUVKIQ8sgHm1qlJNQR1Yg4fnJWPcjxeffxjxljFFkUTz1IOZl4XtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Mon, 29 Jan 2024 09:30:12 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 09:30:12 +0000
Message-ID: <bfbf7847-6a47-4a1a-a04a-1151b7732e84@intel.com>
Date: Mon, 29 Jan 2024 17:33:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, <baolu.lu@linux.intel.com>,
	<bhelgaas@google.com>, <robin.murphy@arm.com>, <jgg@ziepe.ca>
CC: <kevin.tian@intel.com>, <dwmw2@infradead.org>, <will@kernel.org>,
	<lukas@wunner.de>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a1ebf0-a2ce-4366-053d-08dc20ace478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Rd/rdPBaFDhnZeOFFr5U/BTG/gv8diRhgT2561ytI96jHTE3XtLLQVogjxOe4P2yHkN6ID6+QL+UDx88hD7gmZ9lnSnrq9D4eQCT9MFmNkmtWJPJsO3Qbkh1xME0iTGe/QwHeOXVp+TnEmtjkDG2ZrwDvIc1ikU7qGSufGqIlq9JYfXwpqoqwnR4mqaNGDfZQtaFI0xo4mXfsZuGoX88L51iUoygtWjZyOH9JHdibvJUghzIgMvOZqjuO8P+kFEH3k4MLxV8YNUTe8qbo4NnJDyNlgRjC2+ce5nDxycQT7GwVVqiwXhVlSFw+a3NfDQRs7+RBQ73n+UemGUg+jA+oTRkfOG/HyG4rxRVFY3TViIr5emBQnr0qpHuu8nh0062FWmEECTY2PwX8Zxu2VRsWZxrPS5DqEZfvojO7IC/hHYet724zJvBIQFjMV0eXxQ8PzDAx7OYgQeMnR434Xx0bOfdxyXJGTVC95Il3T1VYzRRoU3O2C+350haFOwqlEARDRd2x7OcW/6996Q5KRO3s9JVbhKDtGHefNweOcjrm2SjhKYZiUBV0bd5GLGFyClRr6ntPoBIee6/M6dGbfnngfJiYDvhVYiONFrpniAOkzAHv311Z97WakG8ktcpXvoB11ZFZJiaKyRMDUtBoN+nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(82960400001)(38100700002)(83380400001)(26005)(2616005)(6512007)(478600001)(6506007)(53546011)(6666004)(6486002)(316002)(31696002)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(7416002)(2906002)(5660300002)(36756003)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0VKM09tQXRUclVMcnkzaDZWZmVDaGFXazFZdUQ0amlvcGdLVHJwVjZtcUJG?=
 =?utf-8?B?QmNrQm1nS2RvbXBmY0VKWDZEOWV2TEhNM0s5T0xmTDdBa1NHcWk0ODNNYklu?=
 =?utf-8?B?M3NxVHBYNTRoTFo2RlFYVlAxdTRidmg0N1Bpalo3VkJYejBIeTQyTUpscExn?=
 =?utf-8?B?Nk5VYUFEVGV2TDQrbkVEWDg0TUk3NUZXMXpFRU9LSTZUaVVZV1VhenBXM2Vo?=
 =?utf-8?B?MWxvOVA4dmk3RzNLc2VGNzV1WmNCNk1Tc1NNZnpxSnRWVE51MThPbnd0VXdo?=
 =?utf-8?B?ZlFTRFVCbFIweWhoN3dkWm5LNlc3Q2J6TVVrQ2ZUZkRKR2FNWDNZVjNsRUNx?=
 =?utf-8?B?MnlBWXd6SjJGb0JodnpjOEpaMEpEMm54WjRXRUdqdVJRMExGMUo2akoxTjFY?=
 =?utf-8?B?UlArRnIzK1RKazRKUmRsUEpYeFFuQWVCYi9Md1cvRmlGblFjdTNoMmJQSnBP?=
 =?utf-8?B?UWpEQUxGc1puOWVUVm1FUENCcXdOSzhRZWFOSFVXSlA4bW9uM2N0UTFrMFFj?=
 =?utf-8?B?cUh3elEraDMvYnBLNHNOdTB4ZURFSldqMU1waStWS0F5UHZpRGlqOTdQMms3?=
 =?utf-8?B?QzYySk1KdE9LQ2Q0QmZnQzBma1psU0Q1RmR4ak9oWVo2bkZuK0l0aDdHWncv?=
 =?utf-8?B?cmphK0twVFJzVnQxNE93UVdQMFNYVCtSRkRtVXFlaGtqckpkM1NHMDJvZVFF?=
 =?utf-8?B?bmJJbTN4K2lBNERaTW9lTnhRenRDdkN2NXNyaTJia285dEZYdzlNZW42Y3lx?=
 =?utf-8?B?WTdDQ1BNUHRxNzhTZE5RamdTc1JJNzhZdlgxeUhUUG9KUm5DR1kwand2cXJU?=
 =?utf-8?B?dzZhL2hFZFZPdm9GY09pdnhneTNCOXAvTTRmSUlSZUVhek5YU3NHRk1pL3Rq?=
 =?utf-8?B?Yk9QR1RrRHlzTjB5NnUrbExlcjQ2UjgwTjRnWER3OW82eHYrT1F1RnRUS3Zz?=
 =?utf-8?B?S2NKTmg3T05VTFlkMXVhd0gzdmE0alArR2kyMzgyQ3RqUjlYdUpoRXY5ajda?=
 =?utf-8?B?MS9Cb0I4eGswY3FpYW04REZ6eWNXVUl6bDVzUnUvcHhrWjFXSmVabTI4THpp?=
 =?utf-8?B?RkJTTTBuSHRLMmI5cWRKbjhZWnMxcmhmaGhJMVRYbmljVjdtcVJKM3hHelVK?=
 =?utf-8?B?RzBPbU5LR2RVYW5nMEhOL0QwcDJKeCt1UCtEUmV3VmxZTW1FT3VlK1RMOXgz?=
 =?utf-8?B?QVg2TytISWd5bWVtK21pbmdlbExWWVBoYnFnVzBWSGdzeTgyRzZTYitPV1R4?=
 =?utf-8?B?YmlENUFuRlk5a3FZOTZGMjFLUE5SU1JZMi80OWJxWFRrOHBFbVpDNTF3L2l0?=
 =?utf-8?B?ak40WkNSSytUK3ZlQzFLZTg5VUkyOWhHSndrT2pEVVpBZjJXdXdHSGVYZzhm?=
 =?utf-8?B?MWY0RkYvTVd4UTY4bWFUemgzMWVvVVN6MVpmSzFMMlZta3JnbVd6YWZZZi9p?=
 =?utf-8?B?enl1SWRKT3FTL3NyRFRUeFpvV3YrcFV3VUF3SFhNR1ZHdmJETXVpOThtcis2?=
 =?utf-8?B?TkQzQkxxb05aSnBJeUtjVkhSbWRSV21ocUhTdDNJclhuZEpLc3U0RmUzM2VI?=
 =?utf-8?B?ZlFpdzRSR0YvUlM4TFo1VzFPU1dKVU9iS3AzR0FFRFNpTWdmcVRLR2d3N1E4?=
 =?utf-8?B?eE5lMVIzU29ZZStxajdBMytJWHRJRy9YRlJwRm5ra0NLSFh5ZVlWaDBjWUt3?=
 =?utf-8?B?T0pUdS90Wk1XMUdPdXhwWXphbHgxazBzUXRQVDlKaTBFZ0dPSW5VOCtRRXZo?=
 =?utf-8?B?YkNDNk00RCtYN1JLOUNEWjk2Q0VScXhWSVVyaitSSjhhSzI3TzNxV0xJNW5j?=
 =?utf-8?B?ZDB5QkRDYjgraDBMQmFWZnhDYmVrcVhVWlMwR04zNFhoK2VtU2JuM0FMNmsv?=
 =?utf-8?B?eGdhMjJVVEdqYXhaZEoxcGgyb3lBdkk2bHZKQ2hUTmhCbWFBWC96aHV4M3lZ?=
 =?utf-8?B?SDRuVjZ3VU1zQmRyMDYyUUE3SWh6RDRmeUxsSzM3YWY1c2Faa05UYmdRTXhv?=
 =?utf-8?B?MFNrWTU1UUthWVAvM1NVeHJCMFhaYTVGSGFURlp6WjRZdVhhTzAvam9HL2s3?=
 =?utf-8?B?dEFFTHdUeXdQT0dmaDJ0UnlORnFmVEQ3eW1XekphK2lKTWxCWTZ2c25URk5v?=
 =?utf-8?Q?9bCYlsH2K78DkTbMmVDSUDC5/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a1ebf0-a2ce-4366-053d-08dc20ace478
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:30:12.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sb1izzkLoEncT0QKXkt9uI3RlY4hcc2LlL3XX9cDgL5rHSNAmvH83BWo9v6Oz/JDO53snG17jvdlndx29Oi5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
X-OriginatorOrg: intel.com

On 2024/1/29 11:49, Ethan Zhao wrote:
> Because surprise removal could happen anytime, e.g. user could request safe
> removal to EP(endpoint device) via sysfs and brings its link down to do
> surprise removal cocurrently. such aggressive cases would cause ATS
> invalidation request issued to non-existence target device, then deadly
> loop to retry that request after ITE fault triggered in interrupt context.
> this patch aims to optimize the ITE handling by checking the target device
> presence state to avoid retrying the timeout request blindly, thus avoid
> hard lockup or system hang.
>

should include a Fix tag here?

> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 814134e9aa5a..2e214b43725c 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1272,6 +1272,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index,
>   {
>   	u32 fault;
>   	int head, tail;
> +	u64 iqe_err, ite_sid;
>   	struct q_inval *qi = iommu->qi;
>   	int shift = qi_shift(iommu);
>   
> @@ -1316,6 +1317,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index,
>   		tail = readl(iommu->reg + DMAR_IQT_REG);
>   		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>   
> +		/*
> +		 * SID field is valid only when the ITE field is Set in FSTS_REG
> +		 * see Intel VT-d spec r4.1, section 11.4.9.9
> +		 */
> +		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
> +		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
> +
>   		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>   		pr_info("Invalidation Time-out Error (ITE) cleared\n");
>   
> @@ -1325,6 +1333,16 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index,
>   			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>   		} while (head != tail);
>   
> +		/*
> +		 * If got ITE, we need to check if the sid of ITE is the same as
> +		 * current ATS invalidation target device, if yes, don't try this
> +		 * request anymore if the target device isn't present.
> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
> +		 */
> +		if (pdev && ite_sid && !pci_device_is_present(pdev) &&
> +			ite_sid == pci_dev_id(pci_physfn(pdev)))
> +			return -ETIMEDOUT;
> +
>   		if (qi->desc_status[wait_index] == QI_ABORT)
>   			return -EAGAIN;
>   	}

-- 
Regards,
Yi Liu

