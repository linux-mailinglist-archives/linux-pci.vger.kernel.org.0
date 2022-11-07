Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD6061FF73
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 21:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiKGUTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 15:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiKGUTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 15:19:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06942F7;
        Mon,  7 Nov 2022 12:19:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98EE1B81699;
        Mon,  7 Nov 2022 20:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07399C433C1;
        Mon,  7 Nov 2022 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667852384;
        bh=J0UXkVzO74PzEmahXkyDakfXpq9GdBVANIZS4JBIabY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GrreA9y4BZm6UYdW1E4zflzDpJc1GrO2dKmQFyRwDRbk4cvq1Xfj+mrtS2ynsBjQa
         9s324hUArW8HJXY+zFxNKyjkwLQq3qHifLtW2ChW/ONBe6W60Dbg2MG8hJDHnTkyb6
         LZqmCB+lnM84pKgSvwzvcH2molVI8JBu8usnSCVRcnqFldWh97J8Q+Z158SVXAqADI
         28Urvzyu1FXjgVeS5rozS6VIvR0UFKC7jSkscnCPpkRzKq1T/mKI+N3WDFjkAmmJcF
         jrVgpOofDajzXrc9+t9hXGiRBOKoFk14nPDuO1IpPyy5KpS3FHj1Spstym+OoAVKHC
         zC9XPkiUzG+dw==
Date:   Mon, 7 Nov 2022 14:19:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Francisco@vger.kernel.org, Munoz@vger.kernel.org,
        Ruiz@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Disable MSI remapping after suspend
Message-ID: <20221107201942.GA415315@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107182735.381552-1-francisco.munoz.ruiz@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 07, 2022 at 10:27:35AM -0800, Francisco@vger.kernel.org wrote:
> From: Nirmal Patel <nirmal.patel@linux.intel.com>
> 
> MSI remapping is disbaled by VMD driver for intel's icelake and

disabled
Intel's
Ice Lake (at least per intel.com)

> newer systems in order to improve performance by setting MSI_RMP_DIS
> bit. By design MSI_RMP_DIS bit of VMCONFIG registers is cleared.

register is

"MSI_RMP_DIS" doesn't appear in the kernel source.  Is it the same as
VMCONFIG_MSI_REMAP?

> The same register gets cleared when system is put in S3 power state.
> VMD driver needs to set this register again in order to avoid
> interrupt issues with devices behind VMD if MSI remapping was
> disabled before.

Should there be a Fixes: tag here?  I guess the failure symptom is
that a driver doesn't see interrupts it expects?

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e06e9f4fc50f..247012b343fd 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -980,6 +980,9 @@ static int vmd_resume(struct device *dev)
>  	struct vmd_dev *vmd = pci_get_drvdata(pdev);
>  	int err, i;
>  
> +	if (!vmd->irq_domain)
> +		vmd_set_msi_remapping(vmd, false);

I suppose this is functionally equivalent to this code in
vmd_enable_domain():

        if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
            offset[0] || offset[1]) {
                ret = vmd_create_irq_domain(vmd);
        } else {
                vmd_set_msi_remapping(vmd, false);

because vmd->irq_domain will be NULL if we disabled MSI remapping at
probe-time.

Maybe the vmd_enable_domain() code could be rearranged a little bit to
make it obvious that we're doing the same thing both at probe-time and
resume-time?

Should the vmd_resume() code *enable* MSI remapping in the other case,
e.g.,

  if (vmd->irq_domain)
    vmd_set_msi_remapping(vmd, true);
  else
    vmd_set_msi_remapping(vmd, false);

I don't know what clears PCI_REG_VMCONFIG (which enabled MSI remapping
IIUC).  If it's cleared by firmware, the current patch depends on that
firmware behavior, so maybe it would be good to remove that
dependency?

>  	for (i = 0; i < vmd->msix_count; i++) {
>  		err = devm_request_irq(dev, vmd->irqs[i].virq,
>  				       vmd_irq, IRQF_NO_THREAD,
> -- 
> 2.34.1
> 
