Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77043522F02
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 11:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiEKJKv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiEKJKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 05:10:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B0B01002
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 02:10:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D69071FB;
        Wed, 11 May 2022 02:10:43 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A9383F73D;
        Wed, 11 May 2022 02:10:43 -0700 (PDT)
Date:   Wed, 11 May 2022 10:10:36 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Message-ID: <Ynt9jJU78JnIiZ7z@lpieralisi>
References: <20220502084900.7903-1-nirmal.patel@linux.intel.com>
 <20220502084900.7903-2-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502084900.7903-2-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Adding Marc, to keep an eye on IRQ domain usage]

On Mon, May 02, 2022 at 01:48:59AM -0700, Nirmal Patel wrote:
> VMD creates and assigns a separate IRQ domain when MSI-X remapping is
> enabled. For example VMD-MSI. But VMD doesn't assign IRQ domain when
> MSI-X remapping is disabled resulting child devices getting default
> PCI-MSI IRQ domain. Now when interrupt remapping is enabled by
> intel-iommu all the PCI devices are assigned INTEL-IR-MSI domain
> including VMD endpoints. But devices behind VMD get PCI-MSI IRQ domain
> when VMD create a root bus and configures child devices.

I would encourage you to rewrite this log, it is unclear - granted,
I don't know intel-iommu internals - but IMHO if you explain the
issue and the fix thoroughly this could avoid repeating what
you have to do in patch(2).

Please describe how VMD handles IRQ domains and how you are fixing
that.

Thanks,
Lorenzo

> As a result DMAR errors were observed when interrupt remapping was
> enabled on Intel Icelake CPUs. For instance:
> 
>   DMAR: DRHD: handling fault status reg 2
>   DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
> 
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index eb05cceab964..5015adc04d19 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -853,6 +853,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)
>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> +	else
> +		dev_set_msi_domain(&vmd->bus->dev,
> +				   dev_get_msi_domain(&vmd->dev->dev));
>  
>  	vmd_acpi_begin();
>  
> -- 
> 2.26.2
> 
