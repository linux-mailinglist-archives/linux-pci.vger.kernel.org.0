Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDB84EB632
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 00:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiC2WuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbiC2WuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 18:50:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D2564ED
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648594103; x=1680130103;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=dnz9bBLqYECghcBbHYz+u+/115qB8Ma6DgD4F948W/8=;
  b=OziNulYyWG+xDcF7Ww6T8a3Z0nIeWzsaZ+RdQCI8HjWc/EUmZZRVBPLM
   NUx6Mrb6z/JPy+rtMHd/1kXKzSGMjqyZrimB17XalzrLAJ/poccdAKmwf
   4TI6bAEUEUjs3t7oFHjTaYeutnn1j7u/v8hACc4DlolR05rSi5ppO8mt7
   BP4qIuv9whoLpt/wDqauVqxCF0SiJYKPmvQpnE8f7Xs3RDXoyXrFsflbq
   Eph/AlDVpd/xu17jiPTGRKlseVlJmN+KrQQL9gh3Jk/oZi2Yn73giXdIs
   EwmTEApCDO2LbhxeS/yFzgMOLDDXT5wQ5YVxZl0olENRcF32gEyN3sD5I
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259579176"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="259579176"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:48:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="521642721"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.64.125]) ([10.212.64.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:48:22 -0700
Message-ID: <8eddff32-1347-ad09-642c-951a69c82388@linux.intel.com>
Date:   Tue, 29 Mar 2022 15:48:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] Allow VMD to disable MSIX remapping with interrupt
 remapping enabled.
Content-Language: en-US
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20220316155103.8415-1-nirmal.patel@intel.com>
 <20220316155103.8415-2-nirmal.patel@intel.com>
Cc:     linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@intel.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20220316155103.8415-2-nirmal.patel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/16/2022 8:51 AM, Nirmal Patel wrote:
> This patch removes a placeholder patch 2565e5b69c44 ("PCI: vmd: Do
> not disable MSI-X remapping if interrupt remapping is enabled by IOMMU.")
> This patch was added as a workaround to disable MSI remapping if iommu
> enables interrupt remapping. VMD does not assign proper IRQ domain to
> child devices when MSIX is disabled. There is no dependency between MSI
> remapping by VMD and interrupt remapping by iommu. MSI remapping can be
> enabled or disabled with and without interrupt remap.
>
> Signed-off-by: Nirmal Patel <nirmal.patel@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 3a6570e5b765..91bc1b40d40c 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -6,7 +6,6 @@
>  
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> -#include <linux/iommu.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -813,8 +812,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 * acceptable because the guest is usually CPU-limited and MSI
>  	 * remapping doesn't become a performance bottleneck.
>  	 */
> -	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
> -	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>  	    offset[0] || offset[1]) {
>  		ret = vmd_alloc_irqs(vmd);
>  		if (ret)

Gentle ping!

Thanks
nirmal

