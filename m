Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5611512971
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 04:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiD1CYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 22:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiD1CY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 22:24:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEC07523D
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 19:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651112474; x=1682648474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eKJbLZoyax/Q818wKrZ047RuosRX2q4jB+7lPxpSzeQ=;
  b=c6cfcZCa4apz7wt/LvznEKKq68UsXMwnfeCA5AUf+Z+uRqWwq6FysY7P
   lmqBcmkhoeZTDr6C+rPZRiDabxT+mbFKuzsMmXDSGbI+SMW4ZFNyJmDx3
   zQaSsyrm014paNOzY9/tvpWnajPRpCeeFdDj0AD7vKwJDDox0ScChhFlO
   A/BeWkbVK3mDJ7QL97WNuMr4zSjQUaZMz07UBkh7+5GoWpdtg8RWSIgtx
   ul47FWJawDSYFJyWnQc0eMuXX5Kt1EbMTyLE5blJWUfPAnsYRd/AQdfpm
   nLd3CLc7R8z75A/3IOO2y6U14bFVtyHngXXuvzNAOr7JHOmSNqqnzOhBB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="246693253"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="246693253"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 19:21:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="731130922"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.209.170.14]) ([10.209.170.14])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 19:21:13 -0700
Message-ID: <b2b73869-9889-a70f-73a9-bb7215ab7daf@linux.intel.com>
Date:   Wed, 27 Apr 2022 19:21:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Content-Language: en-US
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org
References: <20220405171005.45586-1-nirmal.patel@linux.intel.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20220405171005.45586-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/5/2022 10:10 AM, Nirmal Patel wrote:
> VMD creates and assigns a separate IRQ domain only when MSI remapping is
> enabled. For example VMD-MSI. But VMD doesn't assign IRQ domain when
> MSI remapping is disabled resulting child devices getting default
> PCI-MSI IRQ domain. Now when interrupt remapping is enabled by
> intel-iommu all the PCI devices are assigned INTEL-IR-MSI domain
> including VMD endpoints. But devices behind VMD get PCI-MSI IRQ domain
> when VMD create a root bus and configures child devices.
>
> As a result DMAR errors were observed when interrupt remapping was
> enabled on Intel Icelake CPUs. For instance:
>
>   DMAR: DRHD: handling fault status reg 2
>   DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
> v2->v3: Update commit log.
> v1->v2: Split patch into two separate patches. One applies the fix and
> 	other reverts the commit 2565e5b69c44 which was added as a
> 	workaround.
> ---
>  drivers/pci/controller/vmd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index cc166c683638..3a6570e5b765 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -853,6 +853,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)
>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> +	else
> +		dev_set_msi_domain(&vmd->bus->dev, dev_get_msi_domain(&vmd->dev->dev));
>  
>  	vmd_acpi_begin();
>  

Gentle reminder.

Thanks
nirmal

