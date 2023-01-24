Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD64678D61
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 02:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjAXBZ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 20:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjAXBZZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 20:25:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2D1CF79;
        Mon, 23 Jan 2023 17:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674523520; x=1706059520;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3W6bgf59w159KPEnBadqF6ftabz2Gy3gNCigaj1A7H8=;
  b=GGRimC1t3L5Ax7qMI6j4Lp+eat/6thUkfChuPNA5KFCnShRNIZ+OUiWO
   EyadOCrWIJqNLJz/lUVj+5sd89rQfCUq9Kr1aJKXmA+qDC8GbimGxnqV4
   YrKM4da9hZ4sYigxK6nZnRjEw0d/zojZZ43vZ4OjOlxsGE65gUyR5Drg+
   eYJoGJlBeZZH0UPBFnCk4B9yAVBhIDJHbAs/hzXi1gTMWxMz7O2/foceK
   ElCKNPjc8ZvodMctoyADS/uxMOxwbDoHYwcGRVyyJ7U6+PI+nz7R0H45A
   82WcWneDGHSCAClhmyeOwsyRqUjoNuAgKX0LErgRCRuCcPseg6EjdMdHW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="412438339"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="412438339"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 17:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="655251561"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="655251561"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2023 17:25:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 17:25:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 17:25:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 17:25:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QufWJf0xEq6Q34P+WMmHKlPYbyCPXHp/ask1FJWASfxU3WlalR/+sLhOey9Ljjq2oBgY53Z4UhfZeuc1eAlPP5wYbTH2gnQjzdnQ34hD8uj5dkaiDLSbJl+Z3j/RzJniTXtaX/laD3CJ4Z5gK99VovZ8rv6nv9qFz6P88oUA2ZuK2eTC114LgyH9HSqBMFTf5qJT+VuEbBioZ88Wb4jPVJ5dicdqgkgwDwLqqNfb5CEXHzTMN9MIRhmnOcwG5wCI2VK4tYyquW6az7UyUCDawOQZBrPaU5QA/iLfjisdHNnnqHy35lPEhjd/CTpRREnje7Z/Mtml4hBWJGn0wDiD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgsUSUliJ6fgbhvPuEhzEfJj7C/ZXq6i30NoRFR77HQ=;
 b=VBA2nuvQNGtNR+NjOS8G3CftgqN3USf64gk5ozyhuJ7pda/UZLf29USvNxmzSe5z8+kcK1qEaboFo7tZbrgYa9AJk1ioYsbN5KjyieuXdRK+gU80XQv+YguukN0s4lZvcYSuWTBxlx7+7kzRraYAqpGfAt0NsOq+Ex5ozGOrcU+CJ1d19ucTlOQWb9ywaPITGH9w0fShVRd4ONiNq6V9BBGIBmoE/BWlATF+Tx7wjqwumLfXSuwwG7WlzZTJW7GCzCGX7YbLAgDWd76XJq/H6P/7pVJGNmGM+pszRpwN+gCG9avmNU0AXhMAHGqyP9SqQwagnjiZKDIp6i0xLmubCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB8015.namprd11.prod.outlook.com (2603:10b6:510:23b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 01:25:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 01:25:11 +0000
Date:   Mon, 23 Jan 2023 17:25:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] PCI/DOE: Make mailbox creation API private
Message-ID: <63cf3373e213c_5cca29410@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <3dca6f956342707fb69cba94a771f3d4d2f5f3b4.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3dca6f956342707fb69cba94a771f3d4d2f5f3b4.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: BY5PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:a03:167::46) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bab0c2c-471e-4dfc-d850-08dafda9d637
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82F6aFGTMbdDVEuOZUdJqU2xMke+vRHl1cUBmr/lRykynb4y1S2MzKu+apvbNIw+xKKunahFsFERi5Ttk38mk3SwBkLP+AkKjMgfLq/MYxWU3jLU6rndlymhA8AIGiOI1eYVoswdvRcu93GUtl77KH09eAeuNnBT8RtqVgkxwvMG9Nr384jhJN7iHnlFuE/qS8CK8SZLUaOJQAb8g2UUNiJ3a6kYGGMgrmZk6O0rK7uVkztMRKu4vBlie/8wRiNE3rJb7zMMkjjwCQ9BhvMySCGiWMoBoVXB5NB/SXFzwxeEML8NaOivLkEx05k/zpquNYdxf9CWMRBKeJfVlrd0vx+qFoKI/vhzzVuTgpU/cP6YpqxlVm74irEg6WhlFX5IbLKpZyuR7QujSySwmM7rPXtSivVTaZ+pWR8kgiXxc+m5AKpSuiNNctllO6DCM92hopd0jA6drgQr3hZtmZChO9u9msiPu8gNMgJGQKgYtzdbydcEVCXXI6dejEVaLC0bFvlCNgaYK2iwimH09sBk/XkWtYPTRMFHEfnGqPCUw4NCSED9Jo6wiiocULyWnhedRMptPXYtaMM2AW66MVUiKtxzmiitlJ1V4JAJM2GOXjspFDgJQtdrSLnZSHgwY2vuWUXjc/jDvlI2g6qsGt0DXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(41300700001)(86362001)(82960400001)(5660300002)(8936002)(4326008)(44832011)(2906002)(15650500001)(38100700002)(83380400001)(110136005)(478600001)(6486002)(66946007)(26005)(6512007)(186003)(8676002)(6506007)(9686003)(316002)(54906003)(6666004)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLFhF5rUP4t3khBoSCtQ3mxkr5PSMynWLIiF0WJTFSdvxTRLzlEKLGe0yMX1?=
 =?us-ascii?Q?7tx8bLqnBGLCS+4fJMdhKtZRJEK1pxZcRkPUik1qVIGqo6ODKEtqPIDXdFdo?=
 =?us-ascii?Q?zeY0aJS/LJrfwmJUe/6yPD4AODpVo6uI4WSfkr2HxnKhz7AfmOMLAaX3nUtM?=
 =?us-ascii?Q?iIXHz2yLFIo17f8ZTjbnHlTnBzm1x67NjTcRSsF8MvEftj1ibJa627eVFXBx?=
 =?us-ascii?Q?KunXKPMfvKmyykRNmw2dz6Qy7koqcmbu6PrGzjcbx9FIJYnfp+g9NdAChCzg?=
 =?us-ascii?Q?Xld2QrxW14NwY/nfgrPxGmF6y9atUfdTc4G31DXfzpNEUg7Pkf8ELodpl9f7?=
 =?us-ascii?Q?gOKCfhrdrMYsTHz2t+vFHFlxBimd9IFrblA/QElhCWrf0Lyp3hhADyfIk2Oh?=
 =?us-ascii?Q?Rqev9Lr2y75g425WbV6cTkJbR6Mh4ANJn3xtk/k61ZEk21XGzUk1FfNtncO0?=
 =?us-ascii?Q?4guh/PTPoJYr7f0pRPP43ZA1/fcBDpk5tvzo7aeIHYsM30smJRVrPDuWBHwR?=
 =?us-ascii?Q?Ll2xtBl57OuuhMlNVMUOFz7+sWU2a77gJcv4NEyVjgCW1eLX2qRpUl5kw6Yw?=
 =?us-ascii?Q?37mgWPXPEKVFmJc2fKOigBSJcl7Nm4lhF4TsVQTYrXju+3mmaP5wFV1osyBA?=
 =?us-ascii?Q?oJMy9+iUIDZPKdSVseWbTprEiyJb96WUiwszAtMH4DjZNP1txyuygzp/31o/?=
 =?us-ascii?Q?xaYG0LadoeiDyZW05ETb3nFd8YLbhOQdjmyHk0QhU/5ja0locvv73g+LGvdZ?=
 =?us-ascii?Q?QtP83NURAcASiHocKrmnxSR9UcsW7gtBF6reNbm6dpUG0fejlfB88NdiCtOO?=
 =?us-ascii?Q?NnKGzLpOwyykT6PRW+ncEkeZ9YpYeEfjdwDbyMbdZoOOmOa5Bc+jiXBRju5k?=
 =?us-ascii?Q?qa+w20EwUd85d3SyocbMqLT8nnHOUpD4qXQWptiNtu9hw8Lyma4RFL/8fr1b?=
 =?us-ascii?Q?VlVxPUai4DE2MIGVHoORk/+pgAOaplmfA6+dQWm86Fq/4bH0OvyenNqhfusB?=
 =?us-ascii?Q?HY0w+dY+Xd4GGwK36r5E2RWgk8md/RfuoNvU2c8xX/veEq/sVJGoso0iLhtT?=
 =?us-ascii?Q?/5ckVPnjuKaGI2ozHXYMpzhc9ajMkT8rdhE0rNljYNNxJGn82JpsiUgyeWzY?=
 =?us-ascii?Q?5qa3twpnjkcmsRX0utXAhuzXU6YQMyDH4lpMXBZ3QdpKgqrkk9VNfjITYtUQ?=
 =?us-ascii?Q?eWVv2vlbXnsua0W5OE4TQB3pTniECCvLT/KkLbcbIXngHnmfmGFP1A4DciXU?=
 =?us-ascii?Q?snFvkEiWUDVpqcsXW+lAM+qByhw6hSVX8ZTyCT4BX3FBJX6GjEV1tZGWzcKN?=
 =?us-ascii?Q?Wf0g/bsRQsnDBPeUZnXbBc5eLVsy58UaWbsmbL08OWX4XJaoaKWOpTWdDyGb?=
 =?us-ascii?Q?DHXKMr+lpPhH3mAMYA53EntG5wEco9mcNfTuVt5vAm12V22og5eJxIRIKuJD?=
 =?us-ascii?Q?M7DZUrg+XTrcQVMYs7nEU4u8bQr6yOG/jlSHkUrYSMT9wdAS7k//QU8tPJkm?=
 =?us-ascii?Q?hCcip+q44vE2fad3L/EH/Hp2fcMdko4Hb+lpnn5SeNonZGjzV9/UoS6GsdSJ?=
 =?us-ascii?Q?V4+9VENaGRnDmqU4P9d0hdq8diLkBbRJzHndkmERmKLDk5Brxev2hWzRu1d/?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bab0c2c-471e-4dfc-d850-08dafda9d637
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 01:25:11.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+TKPnoa/my+q57Svg5zpT+VWomHRGFF5y4lQsHP+wgayHtrXUaWfghQoNTN49c3r/fao9MSxR6droSAj256tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> The PCI core has just been amended to create a pci_doe_mb struct for
> every DOE instance on device enumeration.  CXL (the only in-tree DOE
> user so far) has been migrated to use those mailboxes instead of
> creating its own.
> 
> That leaves pcim_doe_create_mb() and pci_doe_for_each_off() without any
> callers, so drop them.
> 
> pci_doe_supports_prot() is now only used internally, so declare it
> static.
> 
> pci_doe_flush_mb() and pci_doe_destroy_mb() are no longer used as
> callbacks for devm_add_action(), so refactor them to accept a
> struct pci_doe_mb pointer instead of a generic void pointer.
> 
> Because pci_doe_create_mb() is only called on device enumeration, i.e.
> before driver binding, the workqueue name never contains a driver name.
> So replace dev_driver_string() with dev_bus_name() when generating the
> workqueue name.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  .clang-format           |  1 -
>  drivers/pci/doe.c       | 52 ++++-------------------------------------
>  include/linux/pci-doe.h | 14 -----------
>  3 files changed, 5 insertions(+), 62 deletions(-)
> 
> diff --git a/.clang-format b/.clang-format
> index b62836419ea3..cb1c17c7fcc9 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -520,7 +520,6 @@ ForEachMacros:
>    - 'of_property_for_each_string'
>    - 'of_property_for_each_u32'
>    - 'pci_bus_for_each_resource'
> -  - 'pci_doe_for_each_off'
>    - 'pcl_for_each_chunk'
>    - 'pcl_for_each_segment'
>    - 'pcm_for_each_format'
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 06c57af05570..0263bcfdddd8 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -414,10 +414,8 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
>  	return 0;
>  }
>  
> -static void pci_doe_flush_mb(void *mb)
> +static void pci_doe_flush_mb(struct pci_doe_mb *doe_mb)
>  {
> -	struct pci_doe_mb *doe_mb = mb;
> -
>  	/* Stop all pending work items from starting */
>  	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
>  
> @@ -457,7 +455,7 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
>  	xa_init(&doe_mb->prots);
>  
>  	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
> -						dev_driver_string(&pdev->dev),
> +						dev_bus_name(&pdev->dev),
>  						pci_name(pdev),
>  						doe_mb->cap_offset);
>  	if (!doe_mb->work_queue) {
> @@ -501,56 +499,17 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
>  /**
>   * pci_doe_destroy_mb() - Destroy a DOE mailbox object
>   *
> - * @ptr: Pointer to DOE mailbox
> + * @doe_mb: DOE mailbox
>   *
>   * Destroy all internal data structures created for the DOE mailbox.
>   */
> -static void pci_doe_destroy_mb(void *ptr)
> +static void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb)
>  {
> -	struct pci_doe_mb *doe_mb = ptr;
> -
>  	xa_destroy(&doe_mb->prots);
>  	destroy_workqueue(doe_mb->work_queue);
>  	kfree(doe_mb);
>  }
>  
> -/**
> - * pcim_doe_create_mb() - Create a DOE mailbox object
> - *
> - * @pdev: PCI device to create the DOE mailbox for
> - * @cap_offset: Offset of the DOE mailbox
> - *
> - * Create a single mailbox object to manage the mailbox protocol at the
> - * cap_offset specified.  The mailbox will automatically be destroyed on
> - * driver unbinding from @pdev.
> - *
> - * RETURNS: created mailbox object on success
> - *	    ERR_PTR(-errno) on failure
> - */
> -struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> -{
> -	struct pci_doe_mb *doe_mb;
> -	int rc;
> -
> -	doe_mb = pci_doe_create_mb(pdev, cap_offset);
> -	if (IS_ERR(doe_mb))
> -		return doe_mb;
> -
> -	rc = devm_add_action(&pdev->dev, pci_doe_destroy_mb, doe_mb);
> -	if (rc) {
> -		pci_doe_flush_mb(doe_mb);
> -		pci_doe_destroy_mb(doe_mb);
> -		return ERR_PTR(rc);
> -	}
> -
> -	rc = devm_add_action_or_reset(&pdev->dev, pci_doe_flush_mb, doe_mb);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
> -	return doe_mb;
> -}
> -EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
> -
>  /**
>   * pci_doe_supports_prot() - Return if the DOE instance supports the given
>   *			     protocol
> @@ -560,7 +519,7 @@ EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
>   *
>   * RETURNS: True if the DOE mailbox supports the protocol specified
>   */
> -bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> +static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
>  {
>  	unsigned long index;
>  	void *entry;
> @@ -575,7 +534,6 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
>  
>  	return false;
>  }
> -EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
>  
>  /**
>   * pci_doe_submit_task() - Submit a task to be processed by the state machine
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index d6192ee0ac07..1f14aed4354b 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -15,20 +15,6 @@
>  
>  struct pci_doe_mb;
>  
> -/**
> - * pci_doe_for_each_off - Iterate each DOE capability
> - * @pdev: struct pci_dev to iterate
> - * @off: u16 of config space offset of each mailbox capability found
> - */
> -#define pci_doe_for_each_off(pdev, off) \
> -	for (off = pci_find_next_ext_capability(pdev, off, \
> -					PCI_EXT_CAP_ID_DOE); \
> -		off > 0; \
> -		off = pci_find_next_ext_capability(pdev, off, \
> -					PCI_EXT_CAP_ID_DOE))
> -
> -struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> -bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
>  struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
>  					u8 type);
>  
> -- 
> 2.39.1
> 


