Return-Path: <linux-pci+bounces-356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87D8011ED
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 18:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE461C2084E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C6522080;
	Fri,  1 Dec 2023 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnWAqvMF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B99EAC
	for <linux-pci@vger.kernel.org>; Fri,  1 Dec 2023 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701452536; x=1732988536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qoaWpQp5qy6+O9TelPuk8t8jAoU9PoHEl1kRuuDXdrs=;
  b=dnWAqvMFWUQM7SwtSm/R58U8Jui4LFf3u041AI/mzrjImBOtTLIjLOOR
   bg8x+15EZhWJhn/2Y6YOBiSDdfofByRouNcurq1Xf1IqYjrA3tS+NXgIf
   L+GLMM+IPFzUe9ZA7dZXkTinyHoWPWJKXoH76qSW5pLSSyKLUMFXGKUib
   u5pIWvc6BrYJYWHNmbMgm5QA8LrrTFuVj9g5qIr8OPvyPhncKjVdx8+iF
   YpeoF0wCSZLUK2vawdHcv7uqRItr/8pN+Jv+DUr5OAixNoN8SBOijX8sh
   CAQ4qqsZmxnIJqhJwNti1ejdbSpowpvV6DK+mOe0ChGIhNTLBEBK/5+SX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="396327283"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="396327283"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 09:42:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="719592010"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="719592010"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 09:42:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 09:42:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 09:42:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 09:42:12 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 09:41:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay99p7FAUSkDs7r+aQaNJf18vlARrFJYrMwNetk66bwn2F0+hYzGE3aMFZOkva4nZXtfXB050fLGx4und8I1ONyQ2qa4QlTpi/6wKSoVqOTQCWOdXWmO1zw1CQpxTD6vXsij5AOBWxjOqU3h1qiJ5KkaEEj6p4ZMHxXiB5iM+e3IbqXgQQRXmuH/HWiHunFBS1ejw4ZkanGWl4I/ZbGEXGZjguC0bF5Y0WQLK0UjonhShbi0vAN186zhDCKG0U7uvRnDVvMhdImD85aCon8DWFYv0n1oR6G2/kX4hq4KZDpnpzbzWbAr1C/Kc7rummT9PTi0/eJh80EURbVwMIY8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhXDf9rTBe4FCov7Ibt1LuMzoKfQqDWVK5pS17lb4Bg=;
 b=jK517AyDbKqbhAks6m0ce+ZUta25sZ6FXIZO0zeZpb6c5+cTxXWjmO4H2K/vcIk6PIu5KHFghZ39iAaQkYp2v2AD6iaM8M19BWH9wxN2rTUA6p73XDUBxtGAUMEhfwtGK51A67LaySuPplst3X4naLfdHzB0ID9CDgAHuU9EP3tdnkR8YQsDcB8CdExA0XtCX2vKWiNt8DyLtE2lMGFLdOhl2b2Ufv60Silleyv5c+Ao8pfGHoHg4Gj3Iuu9CekefEQOIrIEOfh3lE6ZDG9zyVBqotcLehQiGrLM7Swqd35zXawTT/g4Fw9yP0VY98brmPh9WzfuLHKax4VtHlUGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB5897.namprd11.prod.outlook.com (2603:10b6:806:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 17:41:50 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 17:41:50 +0000
Message-ID: <16f60cfd-f061-4f8b-bcdf-7ddf5063489e@intel.com>
Date: Fri, 1 Dec 2023 10:41:48 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/2] NTB: EPF: return error code in the error path in
 pci_vntb_probe()
To: Yang Yingliang <yangyingliang@huaweicloud.com>, <ntb@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <jdmason@kudzu.us>, <allenbh@gmail.com>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <mani@kernel.org>, <kishon@kernel.org>,
	<bhelgaas@google.com>, <yangyingliang@huawei.com>
References: <20231201033057.1399131-1-yangyingliang@huaweicloud.com>
 <20231201033057.1399131-2-yangyingliang@huaweicloud.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231201033057.1399131-2-yangyingliang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: a71f92cf-5fd0-4c5e-841a-08dbf294cc4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22RoT5S8pnm/joMzYXFY/4uAXZ4NMXEgTr1lz8gtrWIhUEfBcZq6xlu/TX6uEAeaDYInsDubl5AN4Tr3oADcTy4cvMESybl36ATqeLHrewCAFKSc9IfzqN5R0OBr+uHn25YrR79V9nqusb1VUjwSDwejY1nr3z6/kS/sV/kn0y3hqVpcTzl2gKMnR8F2Rf9KxGoFw0WFg+ZAg7/+r1EKeFc4AkK/bLuzfZQOupXHWI8FmuEnVPSWnfoL9+ix2VCcFMm2O+bpjnQPxEoxHW3hX59F/sNUG01tAmktE0sPn71VazO2yGpOPHh5cGr2A/djbs7zksaUsrkTSeb+Ghj4Xmbg8uWIqcZRtk5gCH1FfH2aR8LLIN42OLojEp02k/ZT3H/0IYB3DB7CBK5CtXVCn151e55tTipxST6t/V71BlFhfoJKhqVKTJgKiiTXbldoI2dELLuW41u/Hwtc1siM8dnKB0trbu5c9kREnKO0cfHDnSEMbfDQx2bQaIH6nHWpGGlw+EuuXHgUts4LKDk83m1zTD8/dubYu5zMFXlcKK86Wa6AKIoksf0/B+ui5whYfiFqAX1NziDnJbZ26rrt5QAFGd5x2PD33vcJorjFBhfnaXPUUpks1zmD+FsxSyldxZLxRn6Rs40zQAHGMBYd866GlS0B7sGunQF4E8ps7Fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(5660300002)(86362001)(7416002)(2906002)(4744005)(82960400001)(53546011)(6512007)(83380400001)(6506007)(2616005)(38100700002)(26005)(6486002)(478600001)(36756003)(41300700001)(66476007)(66556008)(44832011)(316002)(8676002)(8936002)(66946007)(4326008)(31696002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNEZ1BlVkhJWnE0TGljTjZRNjBmUy9PQ2tGbmxPdlc5REUyVjVablB0UWRY?=
 =?utf-8?B?TXVaTExlNmpYZE9NaDBLS0UzOTJ5TE5YOElRd2J5UXVMbUdkMWE5a1B5UlY3?=
 =?utf-8?B?RDEzN2c1NlhiS1RyMjhzTGtwWHQwc0RFbERRdmlvYWhxbC95VC9pK1BGU2lM?=
 =?utf-8?B?Z1o3TXBGUzdmN3E5UzVCRGJNaWRSN3RwNTF4bzZGRkloWVBleStTWGtPc3BT?=
 =?utf-8?B?S1lzMDVHV3VRZlpydis1NW56YjJEU05RWU1qZnhwN3ZNQno3U1puNE1mdU9h?=
 =?utf-8?B?dExxcGd0ZVRkUm5mc0hlZlQ4WFU2eG9nWExUenhsc0JTMTV6WmRvVXVXL2Uy?=
 =?utf-8?B?S1dIQzRtQXMrWTMwMVJRQjRwZnhJZ0pTUkpiWTNRSHVJdDQ3Q1JOc3Rra2V0?=
 =?utf-8?B?ODQvWUd5Q2xEV2thN29sT1J0NG41eGd2U2Y4NEtRelVVTFB3UTI4THoyTDhZ?=
 =?utf-8?B?Z2hJbktGcUIvZmJrdUZLdHJkeXpCYVdRUXB2UXlKOFdtMXBOWldtTC81R3Za?=
 =?utf-8?B?aVpJMTZtL0JyNFNNRUxyazBLS0M3VEVUd3JhS1BSVm4wZVZCTm1HU1F6QWJi?=
 =?utf-8?B?YWpLZkErcDdVam9ZY3c0VzBEeTdqQ3dlMXE3TGM4TkRlMzVMRXVXa1czeXln?=
 =?utf-8?B?Q1R3cnJrSjQ0THZKZXJQcUJzOUo0RnptMisyOXdPWG16Zm9ZaVhHMWhYd3pl?=
 =?utf-8?B?N09wdFNlOUhwUXBhUzV0Rm5ORzQ1NWlKaVNKNGN1eHNaTERyWUFNdCswOTE1?=
 =?utf-8?B?M3JoaHVZREo3N3dHU1pNQmpISVY1RkcxNTdqMWFNeEFvMEppUGo5dGx1eWJl?=
 =?utf-8?B?cDNjZXNpR2d6eDFMQlpvOUV1TW1pS1pHUTlMQy8xTjRpZ0VQbnBkYnFEelVi?=
 =?utf-8?B?WjZCQktRc2tPZ0orYzVSWFFiOWZTRlNKeXc5Q3BobG0wOHdLZVJaRWZzNUtV?=
 =?utf-8?B?eWIwa2JKNDRpTnZiWUJSMFU1Yko3T0dkNXZkZS9zWlJ1UjNyQmUvOVFyUUJm?=
 =?utf-8?B?eitBS2lPUjZDNk93U3lCQ3NwZTNCbE9vdGVEWXV2bitMTGtNRjdjd1JtVnBE?=
 =?utf-8?B?NEFGa2I1TVNkK243c2xJWVcxaC9WRTZUQXhkUXZMaU9NWWZOZ3VQc0o4ZVY5?=
 =?utf-8?B?ODVyNUdKM04yY0VnUS9ORVEwUUxEK0dEd3RrMHZKSTBoaHhoOTlzZm5sayt1?=
 =?utf-8?B?dVVzcmR0TXBHd3dzcm9ETm80QWhsK0dBakFGcllOeC9wMWRJKzdvNmx0TUly?=
 =?utf-8?B?WWJhWjZDUU82L1loem1BZnhtTU4rcjRJQ0FWRXdWMTQ1NG01V3FmeHpaTFBy?=
 =?utf-8?B?NDhWL2hSbDNIU29PRUdnS3lmUmVDcVJlYzFQaVV3YW56RVRqbVk3OVF3MGMy?=
 =?utf-8?B?WFhPd2kyUzVlYUdjY096ZlVBYmZYdHljNm1ONStoUjY5NDZVdk5pMFU0S0N6?=
 =?utf-8?B?K2JzWDM3SzdIQ0g4aXM5N0h1Tnp0cjlqTzZoOW9GR1p3N041ZEdtbyt4eWll?=
 =?utf-8?B?RXBZVU9UR0ZUU3JrUUZMT1RDWE1iYndFVVNxd0NlbUlLdEdBekZYSmJrLy9N?=
 =?utf-8?B?UDJvZVkrN2Y0eEo4N1llcFBpZmlyU1VvL0NCYWpRcTRiSGUydUZlQlJBL1Vh?=
 =?utf-8?B?R1NXNHNCb2ZIUTgyUjd1aXN4RUhNSlhIaHZ6eDd0eTZtNUplTHZ1NlQ1aTY5?=
 =?utf-8?B?bHZHOGRIMlRLaEU4eWlhdFVNRDBYVDFKclY4bzAxVzBLeG9KTVNRcjVWSlpX?=
 =?utf-8?B?dTZyMUl5MXhzUURvZm8rTS9CaEU4MUVNWjBCb09hNFlsVTg2Mm5MWDB4RmFX?=
 =?utf-8?B?Vm96dVRnWGU1ZERGRGdjR2ZNK1pTWGtLaUZxd2RoSEs4TWd5aVFrMUcyNkcx?=
 =?utf-8?B?V0N2b1ZZbVRveDdURElGMU9QMHlBSXBNWE5iTkdpdWlXWFRnSVozSEVPamhC?=
 =?utf-8?B?S3RSdTNXN21ZanFGMm5uK0xjSGUzaWJRLzNkNnVtR0ljV1BHMzg2NEx1Ymkz?=
 =?utf-8?B?QWZpVmZvTVpNRTNSSW9LTHJLMHBTaE1UdWVsWGoyK0hkS1Q4T3JReVFqWXV2?=
 =?utf-8?B?RDQ3UGg1SFpwdGhkeTdQRHNwZVg1c2NCcXFBUTNWK0JUTzJITEtkakRRLzdO?=
 =?utf-8?Q?DnnFplIXHJ8vphf6nCk5F5U17?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a71f92cf-5fd0-4c5e-841a-08dbf294cc4a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 17:41:50.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wolDgKW3fmQ6K0jbcF+XXVpXol8AMkRew5MNIeB71fzsf+FFpsXG0uFAHoWn4g+HLTKnB50oHMouFMGoGYGiog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5897
X-OriginatorOrg: intel.com



On 11/30/23 20:30, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> If dma_set_mask_and_coherent() fails, return the error code instead
> of -EINVAL.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 2b7bc5a731dd..c6f07722cbac 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1272,7 +1272,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
>  		dev_err(dev, "Cannot set DMA mask\n");
> -		return -EINVAL;
> +		return ret;
>  	}
>  
>  	ret = ntb_register_device(&ndev->ntb);

