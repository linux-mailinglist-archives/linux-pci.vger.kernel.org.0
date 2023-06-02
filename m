Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653B2720A2F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 22:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjFBUVW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 16:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjFBUVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 16:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0621F1B5;
        Fri,  2 Jun 2023 13:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C7D660C55;
        Fri,  2 Jun 2023 20:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B27C433D2;
        Fri,  2 Jun 2023 20:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685737276;
        bh=gy+GKIB8wBKms5xw12H7bdeX00I9GSSZF+zA2BKmxPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jRNmjODirwoXcqf5yVLu4jP3gVFM69xE3sq/5l2zU+95FFFj3mfji/kM4+ekfh3uo
         EJyJQMbItTYkA1obSrK/qVCgjxn/ARrLoQX0zX+DBVJHvRNQrtHf95WDAzK0GZU/2y
         A5W5YsQuWcr4nqqqke1CoaACHC+TyY+ooHL//++BOdI7cB7urAT30pXFCSSuHimsUA
         uSc6DsTNqkxcx1kE4bpj/tZzHnp5TLSQr8BdsXXli2zGDQnHNe5Wtd7OW23RZbmiEp
         2RoZtlRaL82BaL/BmkmaTDTkrRHrnE7WcvwCEPg5lBNoN1Qc1LDy2yECN3vA4783tN
         VrqVVKcQAyPBQ==
Date:   Fri, 2 Jun 2023 15:21:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Call _REG when saving/restoring PCI state
Message-ID: <ZHpPOzT0nm+vddPq@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602031122.18350-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, Len, linux-acpi]

Hi Mario,

On Thu, Jun 01, 2023 at 10:11:22PM -0500, Mario Limonciello wrote:
> ASMedia PCIe GPIO controllers connected to AMD SOC fail functional tests
> after returning from s2idle. This is because the BIOS checks whether the
> OSPM has called the _REG method to determine whether it can interact with
> the OperationRegion assigned to the device.

"s2idle" is a Linux term; I'd prefer something that we can relate to
the ACPI spec.

Maybe a pointer to the specific function in the driver that has a
problem?  Based on the patch, I assume the driver uses some control
method that looks at PCI config space?

> To fix this issue, call acpi_evaluate_reg() when saving and restoring the
> state of PCI devices.

Please include the spec citation: ACPI r6.5, sec 6.5.4.  The URL has
changed in the past and may change in the future, but the name/section
number will not.

> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e38c2f6eebd4..071ecba548b0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1068,6 +1068,12 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  	return acpi_pci_bridge_d3(dev);
>  }
>  
> +static inline int platform_toggle_reg(struct pci_dev *dev, int c)
> +{
> +	return acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
> +				 ACPI_ADR_SPACE_PCI_CONFIG, c);
> +}

You never check the return value, so why return it?

The function actually doesn't *toggle*; it connects or disconnects
based on "c".

This looks like it only builds when CONFIG_ACPI=y?

>  /**
>   * pci_update_current_state - Read power state of given device and cache it
>   * @dev: PCI device to handle.
> @@ -1645,6 +1651,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
>  int pci_save_state(struct pci_dev *dev)
>  {
>  	int i;
> +
> +	platform_toggle_reg(dev, ACPI_REG_DISCONNECT);

I would expect these to be in the PM code near the power state
transitions, not in the state save/restore code.  These functions
*are* used during suspend/resume, but are used in other places as
well, where we probably don't want _REG executed.

Cc'd Rafael and PM folks, who can give much better feedback.

>  	/* XXX: 100% dword access ok here? */
>  	for (i = 0; i < 16; i++) {
>  		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> @@ -1790,6 +1799,8 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_enable_acs(dev);
>  	pci_restore_iov_state(dev);
>  
> +	platform_toggle_reg(dev, ACPI_REG_CONNECT);
> +
>  	dev->state_saved = false;
>  }
>  EXPORT_SYMBOL(pci_restore_state);
> @@ -3203,6 +3214,7 @@ void pci_pm_init(struct pci_dev *dev)
>  	pci_read_config_word(dev, PCI_STATUS, &status);
>  	if (status & PCI_STATUS_IMM_READY)
>  		dev->imm_ready = 1;
> +	platform_toggle_reg(dev, ACPI_REG_CONNECT);
>  }
>  
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> -- 
> 2.34.1
> 
