Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E876E3D29AB
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 19:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhGVQFz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 12:05:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:34005 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234810AbhGVQFH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 12:05:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="233508677"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="233508677"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 09:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="415538658"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2021 09:45:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 22 Jul 2021 09:45:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 22 Jul 2021 09:45:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 22 Jul 2021 09:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYiSYI0C9Tyw7h0/9i1aYnut5sxu+PlpBCFHDxlLIBy/L3wwsOZFdy0ibVvkBb4Yrn6b7pzXsTpSalo2tbXD73a1KTHmoekl6y3mnTd7a/Gc05g5BZnxx76rsHivHpbXWpra2g5HI1RWwreC5HoAks8FAxGrD1o75OHplQEi/lQi68C6SoVQTYln6B8AS5+QccDixDsQE9oK4XEb7JssOFFN0b1KLmG7fIoHwF7lWFQ9Ke29Sj59EABXNLCrzfmg/K4TPWo9flkexv4wbpAklVbSzCDT9CG3k+NFMHzkbLJd964FXzI6slV42N76bP3e9HoN9b0K+Tl2kSgYb/wFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIYWWQBTJ8mJAOJ/Emid+TGkC2w2XHvePpZQuJFz1Zk=;
 b=K0/gS8yIK+vhM67FJVfmttvfAQEsRDDxfI2OGekokEp51PhK3n9V+/wjXlzgftSQj+Xtg7Nw+LvkgLeF6Nd9pHNS17jn63o5WS6LC4BByyq6AVW5Z9wu/K632UXpzVir7MB8H8BTGHZR/fmV4GDzw9dwA1R0uwsjzFLc5v82K3CQRiQHmBLnOyKuLkJKehhD9DN+AP6bhwpoCgugpLLuf3RKnWwkq4psZFBaNgtdaVxmucTQ3iXez5JcnMEkxxsTJjXgSgAG6o7lcavJfXAazKdWXB3Aqg4KEZFXVCnXDje36i+2tZzW1yPJe3A8k4PAaLKo1sjuN+bDlyi5cMsHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIYWWQBTJ8mJAOJ/Emid+TGkC2w2XHvePpZQuJFz1Zk=;
 b=xwL9QQCrYigAsjZ8cdElb3+Vp6KH26UL/yoImnYFoYpikzDqYkUVPJki9re7UZSmOA3HwSOZb3qyIdWJecJm5l+9PLvJsQSj1pw71F0zmGlzzT9W6UAHUL/t2fMG0L8ATgVgbeFUa8QPZShyyiQQJXikNmXZ1clVogqclTrwHyQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2746.namprd11.prod.outlook.com (2603:10b6:5:c9::10) by
 DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Thu, 22 Jul 2021 16:45:39 +0000
Received: from DM6PR11MB2746.namprd11.prod.outlook.com
 ([fe80::c996:e6e3:47bd:92a9]) by DM6PR11MB2746.namprd11.prod.outlook.com
 ([fe80::c996:e6e3:47bd:92a9%7]) with mapi id 15.20.4352.026; Thu, 22 Jul 2021
 16:45:39 +0000
Subject: Re: [PATCH 2/2] PCI: vmd: Make use of PCI_DEVICE_DATA() helper
 function
To:     Cai Huoqing <caihuoqing@baidu.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210722112954.477-1-caihuoqing@baidu.com>
 <20210722112954.477-3-caihuoqing@baidu.com>
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
Message-ID: <f2aeb584-6293-78ce-e5aa-4bde34045a86@intel.com>
Date:   Thu, 22 Jul 2021 10:45:35 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210722112954.477-3-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0082.namprd19.prod.outlook.com
 (2603:10b6:320:1f::20) To DM6PR11MB2746.namprd11.prod.outlook.com
 (2603:10b6:5:c9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.123.78] (192.55.52.194) by MWHPR19CA0082.namprd19.prod.outlook.com (2603:10b6:320:1f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 16:45:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b29b9870-da21-473b-591d-08d94d3022fc
X-MS-TrafficTypeDiagnostic: DM6PR11MB4754:
X-Microsoft-Antispam-PRVS: <DM6PR11MB4754D9C1D0AAE1F0201CD4F998E49@DM6PR11MB4754.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YbI7y/hG3c1QG3Qs8+WIPB89UuyM2l864Ff8T+gh+mVqKW83Yxrzt9DdlM64TcS6gwa8JSPi5OPIpP13Uk89YRzJeyuJQvGODWYO5VwdR0N7VklPRdarSh4PaSosPgAo16WFKQZmWdj7ES0rEF01bk7N0G+tXaCeB4l1mU5hyzz5Njne5k57F6yy9jpDRIzWqKGCSC6K/hgN9A9iC5SIqfttHKPCeJlJEtitTlXUow+qxMnKwedAklldQycUAPE4/Y1v4i96vGu8cGkzREg1gxlhon4ddofhE55n+t5FBwRiAjuRuSqPpe6whRz8MGUwzvl2dVUqxlqcdoDr95OGEE0AZhwxbvLwFxqjxeNUsx5uA9FYcE+h6QQjs/bvioBO7t4TDwyesRgUkwqz+Nwe55K5f4coXiF/vy5s+P60uS/retxnQBFlDVbCS/ci6Byj18u7H0Wis3YLe/fFC87Pjgf3qvD1H6NfN5UqAKCi4s9CLZrjEoWawym0SHYQT9ev46H/zvp0JrMnEV9keNp1dLVaRnBZtM0Wb0luHikIUUqLhcj1iokyfNZkB14X74pO0K71D6RiXXf/x5xiPJiiRBaLGFH3xoJ3CeLT6NIFHGD6nwmO3mOMc7ZW9wxdIAHhsEsvX+HnfTixtjzvoUkBwvvIY6OcflezRQRRv9W7A/vAqdTl4kZoZfoo3h7gWlV+mW4kaU8bCA4+odX1EdLvRPliieP6Njl/3AnkB5jah9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2746.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(86362001)(6486002)(6916009)(26005)(6666004)(956004)(8676002)(2616005)(8936002)(31696002)(478600001)(186003)(83380400001)(5660300002)(2906002)(53546011)(4326008)(31686004)(54906003)(36756003)(316002)(38100700002)(16576012)(66946007)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtGM1loM1VzVG5PM3EyQU1RZkgvVVlhZno0WmdITHFveHV3YjZ4VkduaVdh?=
 =?utf-8?B?VkZQcW9zVGFxN0lwU1JFRzhTaGhhSHZKRzlHK1l1Y21zZlFTS0FxV3Z3elpo?=
 =?utf-8?B?YzFCYmpic1R1R2xVa3RTWDU3eG9EdStVVlJFK0VtSGwwOUIrV010d2s2bzV5?=
 =?utf-8?B?eGdnV21oakZFLzcxN1VkQytwejB6Y2RmTklNL2N5ejFXdWQ5cnIvV1N1N3JG?=
 =?utf-8?B?VXRTVXB5MFB1RFF1aGZuTk9tVjk4Vlh2Y1Raelk5aGVrVzUyaVBvWUdVOHZx?=
 =?utf-8?B?cE1LOTVMSUUyTmpvU3RFai9yUHhIT0tOUGxUeEI1dEZ0VGpoSkhZZ0VVWkMy?=
 =?utf-8?B?TDZmNjhsT1dzYVREZ2FJSVpuZjErY21wMWVDMU1OWENzdEtaM3NRaElPd3JU?=
 =?utf-8?B?ZnhNaWZncm10b1BCRkFkQXg5OVFoaTc0LzFTYWo0MDdtK0VXbkJEcFh2RllK?=
 =?utf-8?B?UE1mT0FpM3NmOWhlS2ovMWFVTmNxK2Vla2tKaWZWdm1KSEtkekJDWlRaWkgz?=
 =?utf-8?B?Y0t1UW1KUXFwZDZ4TjNGRUVHbnBBNTBxY0U4Q09uMjBSZzUwbnk0clk5YjdE?=
 =?utf-8?B?WUZEd1NyOSsxOTlyeTBBTmNGTE9PSzZoSHpBRlFzZlJZYUxlYzN1QzFSVjlU?=
 =?utf-8?B?U0pSVURtMXZDK2d2Z3h3MUlzaFhrQXJnTmdtajl3RC9TTTVUaE9yWjRWU1Yz?=
 =?utf-8?B?c0drYTd2UE5HV0EzT1pLdVpkOHpyNmp0clRNNFpkY1R4elV5UnJ4UGdMUCts?=
 =?utf-8?B?NEt0b254eWN3WEVVZHZpSDdISnRuYkZ3SEMyakNEc3hBdFFtSWR4SDdrMVhj?=
 =?utf-8?B?dkNFajk2Mmw2SkZqVDk4WHl2eXBNUlhiL0FCeW5wSXVLYUg1NkRobjZ1MzdD?=
 =?utf-8?B?Rlo1bzRBM1dCdWZKOWNSZUFDMk5WREZNZjVIU0F6Y1pvcm5rRldZUlVydzRv?=
 =?utf-8?B?dENGbWE5aXNwSVdSc21GcWk4dmU0VWtlZVVaaW5sNkc5Z1NTbEY5U2NRWlBp?=
 =?utf-8?B?NDFoSURCZXg3RjUzUlNDdFJIT3p6WUkwYXJObm8yNDgwQUJaVGRhWVpSQlRB?=
 =?utf-8?B?TnB6VmJ6cmU2MlRGd1k3NWszWVFqU2xTcU1wRmZSMUw4Q056VTZlSEZyZzFJ?=
 =?utf-8?B?akIvVmpqUG1CT1pCWVZVckVBS2FKMFRxWXJXTTdjOUpYZFAzR1diejUzTUZx?=
 =?utf-8?B?OHc4WkEwZE9OUFlqVXZlL3BEbjltVEF4N3loQUVXSHU2b3dsclFVZHc3eDdR?=
 =?utf-8?B?ME55SkpxdDZ0RGh4QkZXNWFxbGdUYjc1Wk85aHhrcVFBSXIzc3lpeUJJdktm?=
 =?utf-8?B?djFpRDdVbkt5dkl0L2hGR2QxK2sxNVJaS0x3Nkx2M3FTRis3cllhU2dVNzhY?=
 =?utf-8?B?MDJRRjdyYXRXMC9ySG41QXJTaEt4YUlNYVpzRGh6U2VUdXJBYks4SWJiR25B?=
 =?utf-8?B?SmFiRUZpUGREYkxOQUxQZlQxbTc2TGhId043eWVNb0ZwREp6bHpaRWFxK3NN?=
 =?utf-8?B?NDBsUzlSTUFBdnBHRzA2K1F6VW0wQ0NDeG5oZ3JIYkhUOERTU3ZYbHA2YlJH?=
 =?utf-8?B?NWp6THhPL0J5YXcyQ0R0eXd4UGlCWHM4Q3RsUzVkNE1raTQxQ3ROWncwd1J3?=
 =?utf-8?B?TWF5cVhueGE5bkU2SGg0b2xUalVlT09PQmVTQ1haSk85RXhwOFhERjFpbVRD?=
 =?utf-8?B?T0liNHIyMWZNNU5IR2RnVUMxNXdyZy9kVDN4TThwVDN4Qm5NVVp0T2VKR2Ey?=
 =?utf-8?Q?vS3dEodsBpzfvngST0TBnlgJad2oNUk/FTyYWM3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b29b9870-da21-473b-591d-08d94d3022fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2746.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 16:45:39.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79aflZ1+CNdpDKOUtOZl64UkHD8vmydEGfdefzCN8iP3n6UrKcBZmVSZDh8pyObQdNyoTmcuZVXILLiDzc4c4v0MvDH+9PxwlGqrfu8J4WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On 7/22/2021 5:29 AM, Cai Huoqing wrote:
> We could make use of PCI_DEVICE_DATA() helper function
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/pci/controller/vmd.c | 38 ++++++++++++++++++------------------
>  include/linux/pci_ids.h      |  2 ++
>  2 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e3fcdfec58b3..565681ed00a1 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -859,25 +859,25 @@ static int vmd_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
>  
>  static const struct pci_device_id vmd_ids[] = {
> -       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> -               .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
> -       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
> -               .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> -                               VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -                               VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
> -       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
> -               .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -                               VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -                               VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
> -               .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -                               VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -                               VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> -               .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -                               VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -                               VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -       {0,}
> +       { PCI_DEVICE_DATA(INTEL, VMD_201D,
> +                         VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) },
> +       { PCI_DEVICE_DATA(INTEL, VMD_28C0,
> +                         VMD_FEAT_HAS_MEMBAR_SHADOW |
> +                         VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +                         VMD_FEAT_CAN_BYPASS_MSI_REMAP) },
> +       { PCI_DEVICE_DATA(INTEL, VMD_467F,
> +                         VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +                         VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +                         VMD_FEAT_OFFSET_FIRST_VECTOR) },
> +       { PCI_DEVICE_DATA(INTEL, VMD_4C3D,
> +                         VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +                         VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +                         VMD_FEAT_OFFSET_FIRST_VECTOR) },
> +       { PCI_DEVICE_DATA(INTEL, VMD_9A0B,
> +                         VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +                         VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +                         VMD_FEAT_OFFSET_FIRST_VECTOR) },
> +       { },
>  };
>  MODULE_DEVICE_TABLE(pci, vmd_ids);
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4bac1831de80..d25552b5ae3e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2954,6 +2954,8 @@
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR         0x3cf5  /* 13.6 */
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1       0x3cf6  /* 12.7 */
>  #define PCI_DEVICE_ID_INTEL_IOAT_SNB   0x402f
> +#define PCI_DEVICE_ID_INTEL_VMD_467F   0x467f
> +#define PCI_DEVICE_ID_INTEL_VMD_4C3D   0x4c3d
>  #define PCI_DEVICE_ID_INTEL_5100_16    0x65f0
>  #define PCI_DEVICE_ID_INTEL_5100_19    0x65f3
>  #define PCI_DEVICE_ID_INTEL_5100_21    0x65f5
> 

This is fine with me

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
