Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C9D3ED9C9
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhHPPXj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 11:23:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:2329 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhHPPXd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 11:23:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="195463816"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="195463816"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 08:22:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="675624125"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2021 08:22:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 08:21:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 16 Aug 2021 08:21:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 16 Aug 2021 08:21:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE6BS+1xZxtOzS4V4weE6NF7NJUGnrRCHwt+qZjzVIL9XhLB8pFtlmW0Y4JuHMv/GZoy3dbd4ChCg7ADwghv2LfL6MdbLq2QgX9u12obizu9ZB7SRd+OY8tJaez0pkcpWsJ4l7+gXnKRfYVnJGG1h+XF+y0vM8c6HmOt/OOiRtz5ncRJIfmk9PtX25GXHSgMrFh37t8eV3Rmgdk9cgNjiBbHU6cuUVVl2oaUGfzhaZMdGBeXYZCRTNdFM/IIJvH7xSoxUvdm4eQ85QvfkGiL58JwYMVOnrKd0yiAnuLplusC29rQWLG5N0KA2fkBBgs8XwJ3sAy/SEy9U4ZqsQhVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMyC9trz+FSMXVddLU1jkccA3dlY4GzR3EXZLYXOa/c=;
 b=CGhvkSe1/umgceOuAN8WcMwCUtfgPCcs6ZPsqtPkAlZ9mqWOcQuJmBe864Xj6z0DE6KOh6SvjxKJlEo++cx5V8lIZB9mzrOfZ6jytiFhPYoSfBKnPstocgkIf5IA4vxjm9blOTi6TVCP/W3PrB1VxkFnm33nJCQtaoJt7QrEOOwHjA4trETGUfEv76OBJIfNFrM8ZBd21UC14OUnLe5nxi6fqAW3+SWuZXTbXXk0h5vFN5L1iJWRC4CKuYZAKA5s79gkEabaqQ41vfQX/I/WcQ/JV2YbcPU+tqUEZAiGp2hrVHeN9xRYRZhGNSe+p87Pl/rY3TA63zYGqn7JcrMudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMyC9trz+FSMXVddLU1jkccA3dlY4GzR3EXZLYXOa/c=;
 b=YaSXsr0rF2YW2n8R8z7TGV9qvD8AqIABZtGk12b7PXcxOLkcZYFEiXY/BrJ9gSDcGnBYUdB1aOiO8uQinIFJQs0+5Y7ttaoD7RGBFfq42n2YIrryt5fGwrP9FxHks/SnrReG6Pk48HO7FjcnJnQ6812B08NGLBmysg0AQ6R2dXc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2746.namprd11.prod.outlook.com (2603:10b6:5:c9::10) by
 DM5PR11MB1596.namprd11.prod.outlook.com (2603:10b6:4:b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.19; Mon, 16 Aug 2021 15:21:58 +0000
Received: from DM6PR11MB2746.namprd11.prod.outlook.com
 ([fe80::95c6:8d41:62e6:24c7]) by DM6PR11MB2746.namprd11.prod.outlook.com
 ([fe80::95c6:8d41:62e6:24c7%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 15:21:58 +0000
Subject: Re: [PATCH] PCI: vmd: assign a number to each vmd controller
To:     brookxu <brookxu.cn@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1628951656-17148-1-git-send-email-brookxu.cn@gmail.com>
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
Message-ID: <eaa96887-81fc-01bc-630c-04783d5a2a61@intel.com>
Date:   Mon, 16 Aug 2021 09:21:55 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <1628951656-17148-1-git-send-email-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To DM6PR11MB2746.namprd11.prod.outlook.com
 (2603:10b6:5:c9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.123.78] (192.55.52.194) by SJ0PR05CA0199.namprd05.prod.outlook.com (2603:10b6:a03:330::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Mon, 16 Aug 2021 15:21:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 730f14ef-263e-4c7c-ab50-08d960c996a8
X-MS-TrafficTypeDiagnostic: DM5PR11MB1596:
X-Microsoft-Antispam-PRVS: <DM5PR11MB15964A054E1D107A9B308E3F98FD9@DM5PR11MB1596.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eKFnMFxHl+K4Kvo3gWu8sqzA043S/cYSZ+w8fjX6/nJnbLeV6FpAMHbJkttjlWhqYK9KZcO5W1Vti8xxFsWqktep7PoBa4RPj61iYwMFM98CzaqhSsIP7RIOxUUiA6monxcYeCxSmPMIc8Iw3xqP1g4yp8iAvppKG8AatutDQ4ab9hTlcuh60GwQQ8lR52kFWLffwTSATyTneM9uiT2eKK1/76FB31pGOLa58CYN+B8580sNqK4RNhMn40vI8QCbW87r8+xsR/pgLb017B38ckyDQ+IlhR0Iacx1TD7iS79fpCiGaWgsKNJ5B99F4X6ySJgRxJ2lD3KoFUnhZiLtxM/h4UjIuu81HLl4U1CKf0rca12/aIvJmC+OfPdKY5HfJ2gCno3iF74xBXru62o2gfI8uRtjdJXumnrPHU1UPyB0xEYYDcOqLqxznkyOfoGCUqCKpHeoqdiwlNTgciu9GTCeQVGhIkwzU/DvyRJLZ3PsvqiKLzGYo0ZgxtyJn1FWsL/bjQK90AR65AoDoTgMygmdnsRUHDEDLHCeHPlvDeVvpBMfUN71KsWHa4CBZPVgiaJdk5oqPzWzwFSOfFJmodllSfrX2pzcGj7oaPBWdBL/ucaCz3+9tYo/+33Rs6tDyztsq6GJG4tij1KhBOlq7aIL4eQlM/2AXsll4FCslX5b/QayasTs7AfMV5bHgi2kMCeBwTjhIDW+JppDIw53T8JzYmL4fRifKgBmMZ+pXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2746.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66556008)(66476007)(26005)(66946007)(83380400001)(956004)(31686004)(508600001)(36756003)(5660300002)(53546011)(186003)(316002)(110136005)(6486002)(31696002)(86362001)(8676002)(8936002)(38100700002)(4326008)(2906002)(16576012)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXk2cDhuRkoxSzdoWUR4dGJUcE4rSGhaMHhXZFBPMXB6aFAvTUwvRTR1M3dW?=
 =?utf-8?B?aVBBMXRhVXB5MlN3QTB5VTZFUXF5cjJZTVZHc1hkNTNUdHl0S2EwdVE2MUlV?=
 =?utf-8?B?T0NsaS9VdW8wM2d3Y2c4Q29yTnA0em9laHUwY2trSkpCYkRSOFNCdlVlQzFK?=
 =?utf-8?B?c0c0VkQ1UE96a1dFM2ZINmwzVDhJZE1UK3NDK1NmUk9oaFB3VFd5b2dHR0d0?=
 =?utf-8?B?T0hYdmlUbFArR3JoMXlrdzRiczFUMVo2L3FCY0hGamRGc2JkYzZLLzQrMlBz?=
 =?utf-8?B?UUtvZ1dMd2lhVEp5YzJaeUxJVEpGNmdqN1Vrc3dLNXVCRnlGejRkQkpPSHUz?=
 =?utf-8?B?bzRuUWZBM251Q1FyTWdQRHZmTXpvRmY3Tk9DbS9NQndwbVNGTTZJZStXdTlv?=
 =?utf-8?B?MG9PMm5Lby9xMkxRUEVpa1Z1NW56YkdXS1JTbEQzTXp3TVIyNmlrZklvVHNh?=
 =?utf-8?B?d25oTUI5eVc3UEZIZXV5RTdNRmpGNnpJT0trUFlFN2NWOFVLaVR5a0t6blV5?=
 =?utf-8?B?YjlBVVc0Skx2YWFUUU9ERmdnam1RS3pENHZWREhycjZOcG9zUzM4Q3ordjdo?=
 =?utf-8?B?dkdsY3FLN09NdzRvMTBsTlZ6OHFwekZNb3ArUGpabjFYcmc0ekdGMUovN1RV?=
 =?utf-8?B?Q1lmWHFycWYwSEJBa25QRFhoajJOV3oxMlZOQng4ejNLWWFHMmFjSndUeis2?=
 =?utf-8?B?Rk15MzJoR2c1WXhFV3ZNcC9QWCswNWY1Y3Z2MWZkeW0yZ1MyZ25ROU5VYmVn?=
 =?utf-8?B?TFBaMjVrWGxQdUlRVmdFLzN3R05sQWRUYnp3eVI4MGpQNk9wd05ZMHN1RkZF?=
 =?utf-8?B?aCt6aWxlT1hzb3Zac1FPVmpYczdUZUhPMFJHbWpkQ291WnNiRnBaZFQrYk1K?=
 =?utf-8?B?ZTBDd01TY1EvOVUraVJXY2VpNWZrdUROaXF4cTRKVWxBOVhIcmdhc0xjMXZH?=
 =?utf-8?B?dUZsbzhpT2FPWFI4dDZOemVhVUFqNmpDOFFxVnJlUkg0OVJ6ck1vbDQ4UFlE?=
 =?utf-8?B?UzhUd3M4UGFCQ2FuSktsMXNZQTR5NXd4Q2gyMWRodVFjeFZYK2hSOEFJcmZq?=
 =?utf-8?B?WmIzOVIwL1pRUUE0c3YxUGgvTFBVdUlreGtqVk1ra2liQ1NWbFY1TC9vcHpH?=
 =?utf-8?B?SU5NYlNnQU5IRnkzdTJNV1pNOGxVL3NJMVE5eVNlUXBINmhXVVIya2F4bzVO?=
 =?utf-8?B?N3Uxa3BxT3lpNnJPTEJaaU9zMUpCcTFDK0wrUE9sUmhKdXJ0MHJ1RHVsZytB?=
 =?utf-8?B?SGtuU1RhbXNud0JaZGJGY0U3RXE3M0drVDJLQ0Yrb0s0WkRJVEJzUnJlaDR4?=
 =?utf-8?B?TzNZM3F2Rkd4RGFDbGlLdDlUUEVrY3c5NTY2UkZuSnA2Ukt3SER6SlN1bEJP?=
 =?utf-8?B?Tmcya3RWOHZqMlpkaWNBUkdvL1Y4R0VCbTBpRE1XTnNKeUFUVEUxNDhoc2ZF?=
 =?utf-8?B?aGhGaDRzdW5lVkpud28rWER5Q2lOSmRzQXJTaG1iS2h3OVRjL0pmT2J1dXdY?=
 =?utf-8?B?c09pODB5NXljdlJtak01d05CRmYxY21oS1JObWNHMzBKUFZJNnVFYW4zTHdw?=
 =?utf-8?B?aUtDa2cxYndTOEMzS2NBMVRCR2tXRUJRd0FOdlVkdzNVWEtlU3VmNGJ4UVJl?=
 =?utf-8?B?bHBQLzNEVmRXTFFVTURNY2V2SVYrS1Q3SXVsVkR3dHUvOU5YckgweWFmNWx6?=
 =?utf-8?B?bG5Tc2o4WS9OMFVRek5ieHlYM2tiNCszWG1ES1Nxb29vWTM2S2kxMGQvREw3?=
 =?utf-8?Q?FU3fDx1jT2HZJnhwntdkBjV/dwb9nfJ8rkxkmMM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 730f14ef-263e-4c7c-ab50-08d960c996a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2746.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 15:21:58.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfbBri09iqIU7XAXgs3C9eSsTjyC8z2rPqC0IGsQXmUcSOlG1/NFij5N1PspI9WvaHLEVcw1/tGkk05mUmunM4IavrFkzqbb4hnNV0WDy6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1596
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Xu,

Thanks for the patch

On 8/14/2021 8:34 AM, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> If the system has multiple vmd controllers, the current vmd driver
> does not assign a number to each controller, so when analyzing the
> interrupt through /proc/interrupt, the names of all controllers are
> the same, which is not very convenient for problem analysis. Here,
> try to assign a number to each vmd controller.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  drivers/pci/controller/vmd.c | 58 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e3fcdfe..c334396 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -69,6 +69,8 @@ enum vmd_features {
>  	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
>  };
>  
> +static DEFINE_IDA(vmd_instance_ida);
> +
>  /*
>   * Lock for manipulating VMD IRQ lists.
>   */
> @@ -119,6 +121,8 @@ struct vmd_dev {
>  	struct pci_bus		*bus;
>  	u8			busn_start;
>  	u8			first_vec;
> +	char			*name;
> +	int			instance;
>  };
>  
>  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> @@ -599,7 +603,7 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
>  		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
>  				       vmd_irq, IRQF_NO_THREAD,
> -				       "vmd", &vmd->irqs[i]);
> +				       vmd->name, &vmd->irqs[i]);
>  		if (err)
>  			return err;
>  	}
> @@ -769,28 +773,48 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	unsigned long features = (unsigned long) id->driver_data;
>  	struct vmd_dev *vmd;
> -	int err;
> +	int err = 0;
>  
> -	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
> -		return -ENOMEM;
> +	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20)) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>  
>  	vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
> -	if (!vmd)
> -		return -ENOMEM;
> +	if (!vmd) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>  
>  	vmd->dev = dev;
> +	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
> +	if (vmd->instance < 0) {
> +		err = vmd->instance;
> +		goto out;
> +	}
> +
> +	vmd->name = kasprintf(GFP_KERNEL, "vmd%d", vmd->instance);
> +	if (!vmd->name) {
> +		err = -ENOMEM;
> +		goto out_release_instance;
> +	}
> +
>  	err = pcim_enable_device(dev);
>  	if (err < 0)
> -		return err;
> +		goto out_release_instance;
>  
>  	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
> -	if (!vmd->cfgbar)
> -		return -ENOMEM;
> +	if (!vmd->cfgbar) {
> +		err = -ENOMEM;
> +		goto out_release_instance;
> +	}
>  
>  	pci_set_master(dev);
>  	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) &&
> -	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
> -		return -ENODEV;
> +	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32))) {
> +		err = -ENODEV;
> +		goto out_release_instance;
> +	}
>  
>  	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
>  		vmd->first_vec = 1;
> @@ -799,11 +823,17 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	pci_set_drvdata(dev, vmd);
>  	err = vmd_enable_domain(vmd, features);
>  	if (err)
> -		return err;
> +		goto out_release_instance;
>  
>  	dev_info(&vmd->dev->dev, "Bound to PCI domain %04x\n",
>  		 vmd->sysdata.domain);
>  	return 0;
> +
> + out_release_instance:
> +	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> +	kfree(vmd->name);
> + out:
> +	return err;
>  }
>  
>  static void vmd_cleanup_srcu(struct vmd_dev *vmd)
> @@ -824,6 +854,8 @@ static void vmd_remove(struct pci_dev *dev)
>  	vmd_cleanup_srcu(vmd);
>  	vmd_detach_resources(vmd);
>  	vmd_remove_irq_domain(vmd);
> +	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> +	kfree(vmd->name);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -848,7 +880,7 @@ static int vmd_resume(struct device *dev)
>  	for (i = 0; i < vmd->msix_count; i++) {
>  		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
>  				       vmd_irq, IRQF_NO_THREAD,
> -				       "vmd", &vmd->irqs[i]);
> +				       vmd->name, &vmd->irqs[i]);
>  		if (err)
>  			return err;
>  	}
> 


Looks good to me
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
