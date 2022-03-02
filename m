Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDAD4CAC4D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 18:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbiCBRmP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 12:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244121AbiCBRmO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 12:42:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E3D048D
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646242890; x=1677778890;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=IYd4wKC0zAYvyCaUlSdz2tFpFRVunOLiqv4HHT1p6oI=;
  b=AcvnvOmlugxXFAK08hk2hlVmdVuyDJriXQfw/qoir9gfRga9MHiH4lP1
   Qcy0Rf/oZ7dSIbSeOb/voEVghgjWloC9FqL9qVJpIss8+GdrUHnun4KgR
   +TLn9zCaDZ+sOLRbOvO8gNpRA43ojlqSRV4arXxHIMcSyFobwmlZnWmVQ
   R+MJ3OH8QVV3eWCpWZAayLbu9URpy9lREH9l3ZUhYo+ssPdr72xiY3LUa
   46tWAvbnkBVRl1hYXz8BhNlCZLpLMD0p2vnj/FanRUgzLsj5FPIWPVcmQ
   W8EnCLBqwuAdcACwXK5MCvczcphdu+ejv7ivoSg79SWNuqOxsrHmF87WG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316675779"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="316675779"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:41:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="576187938"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.108.7]) ([10.212.108.7])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:41:28 -0800
Message-ID: <358b0673-f90f-78ca-be66-51d5f76cc42b@linux.intel.com>
Date:   Wed, 2 Mar 2022 10:41:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] PCI: vmd: Assign vmd irq domain before enumeration
Content-Language: en-US
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20220223075245.17744-1-nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20220223075245.17744-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/23/2022 12:52 AM, Nirmal Patel wrote:
> vmd creates and assigns separate irq domain only when MSI remapping is
> enabled. For example VMD-MSI. But vmd doesn't assign irq domain when
> MSI remapping is disabled resulting child devices getting default
> PCI-MSI irq domain. Now when Interrupt remapping is enabled all the
> pci devices are assigned INTEL-IR-MSI domain including vmd endpoints.
> But devices behind vmd gets PCI-MSI irq domain when vmd creates root
> bus and configures child devices.
>
> As a result DMAR errors were observed when interrupt remapping was
> enabled on Intel Icelake CPUs.
> For instance:
> DMAR: DRHD: handling fault status reg 2
> DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00
> [fault reason 0x25] Blocked a compatibility format interrupt request
>
> So make sure vmd assigns proper irq domain. This patch also removes
> a placeholder patch 2565e5b69c44 (PCI: vmd: Do not disable MSI-X
> remapping if interrupt remapping is enabled by IOMMU.) MSI remapping
> should be enabled or disabled with and without Interrupt remap.
>
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index cc166c683638..c8d73d75a1c0 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -813,8 +813,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 * acceptable because the guest is usually CPU-limited and MSI
>  	 * remapping doesn't become a performance bottleneck.
>  	 */
> -	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
> -	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>  	    offset[0] || offset[1]) {
>  		ret = vmd_alloc_irqs(vmd);
>  		if (ret)
> @@ -853,7 +852,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)
>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> -
> +	else
> +		dev_set_msi_domain(&vmd->bus->dev, vmd->dev->dev.msi.domain);
> +	
>  	vmd_acpi_begin();
>  
>  	pci_scan_child_bus(vmd->bus);

Gentle ping!

Thanks

nirmal

