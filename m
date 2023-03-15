Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C956BBF1F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 22:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCOVcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 17:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCOVcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 17:32:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1E44B824;
        Wed, 15 Mar 2023 14:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93CC4B81F64;
        Wed, 15 Mar 2023 21:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D22FC433D2;
        Wed, 15 Mar 2023 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678915921;
        bh=1yr1STeVAoHQASUgLr2QZ7ZFDSNV2vz78T2hPTdLHnM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L0WHiniQKrtg00MFmDaqvRBlldkwXDp108BX93NFfIRoFfPSgTtB+5/LtJZ7oBmy6
         pZjabTdupeu0efc/RPGmf5/H7YaroLezq2b6PA3d0UTsFjedYKIqRjNdaXTQOvoXQv
         EDRD4MQavdewbYf3KXryrWdUi2OCmEN6AinzXBwj7FPWlQdEFKgHRpfunGUEf+26be
         /eVCfxkldPglrWp0jOiKSKwsO6jFNndXYiGC09AHDLrzIBuVzb+yP80/Fy+XNaL16L
         Kl96lI+51tH1UsGXYwZ3Ur32oi62cwhUS1sWbCinSRdUnrM55g74soQ5EpLgH4mbP/
         s2VGmve6HX2yw==
Date:   Wed, 15 Mar 2023 16:31:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhuo Chen <chenzhuo.1@bytedance.com>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/9] NTB: Remove pci_aer_clear_nonfatal_status() call
Message-ID: <20230315213159.GA1788435@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928105946.12469-4-chenzhuo.1@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 28, 2022 at 06:59:40PM +0800, Zhuo Chen wrote:
> There is no need to clear error status during init code, so remove it.
> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>

Can you send this to the NTB folks?  It doesn't depend on anything, so
no real reason to merge via the PCI tree.

To help reviewers, ideally the commit log would mention where the PCI
core clears the non-fatal errors so the driver doesn't have to.

> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 0ed6f809ff2e..fed03217289d 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2657,8 +2657,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  	ret = pci_enable_pcie_error_reporting(pdev);
>  	if (ret != 0)
>  		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
> -	else /* Cleanup nonfatal error status before getting to init */
> -		pci_aer_clear_nonfatal_status(pdev);
>  
>  	/* First enable the PCI device */
>  	ret = pcim_enable_device(pdev);
> -- 
> 2.30.1 (Apple Git-130)
> 
