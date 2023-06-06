Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4F724CF1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 21:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbjFFTXp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbjFFTXp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 15:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2428FE60;
        Tue,  6 Jun 2023 12:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC698615CD;
        Tue,  6 Jun 2023 19:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD1EC433D2;
        Tue,  6 Jun 2023 19:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686079423;
        bh=p8Lxm7KhOJb3okWKEtpax6TjOrAnMjaevyCE24B4Rsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uH3ckJHJyod97p6orOKxPw6toM0mWCflU8PdXsuaWn57L2r0+/v3GJl1S12qrYqQ/
         58QjPK9Pe/NSrJF+UMB3lUHsq/rTDAGHyw2hn50DK8bwfgqhOr1f/9w80lk9RQMs+1
         tBYl++W54ZaPExo5uvuKPfNnl7DWN99kCA527+fkeqnlXvpw7QDK2kca3mv07w+/pR
         9gFVJW/0MnJnyNEgzg6cEdYXFCON+31dkvjswKkYoNTphiQYGJUYreDKLGWzgemTQv
         A7uZ4VKdSDeWMmhJjst4OGLuaetVuxcW+/xaeJ/1Ly5E3OHDaSSNgHoeL2TWmfcAjN
         U9wtwQ3oRctaA==
Date:   Tue, 6 Jun 2023 14:23:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Call _REG when saving/restoring PCI state
Message-ID: <20230606192341.GA1130972@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606162321.34222-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 06, 2023 at 11:23:21AM -0500, Mario Limonciello wrote:
> ASMedia PCIe GPIO controllers fail functional tests after returning from
> suspend (S3 or s2idle). This is because the BIOS checks whether the
> OSPM has called the `_REG` method to determine whether it can interact with
> the OperationRegion assigned to the device.
> 
> As described in 6.5.4 in the APCI spec, `_REG` is used to inform the AML
> code on the availability of an operation region.
> 
> To fix this issue, call acpi_evaluate_reg() when saving and restoring the
> state of PCI devices.
> 
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Handle case of no CONFIG_ACPI
>  * Rename function
>  * Update commit message
>  * Move ACPI calling code into pci-acpi.c instead
>  * Cite the ACPI spec

Thanks for the spec reference (s/APCI/ACPI/ and add the revision if
you rev this (r6.5 is the latest, AFAIK) if you rev this).

I don't see text in that section that connects S3 with _REG.  If it's
there, you might have to quote the relevant sentence or two in the
commit log.

You mentioned _REG being sort of a mutex to synchronize OSPM vs
platform access; if there's spec language to that effect, let's cite
it.

Ideally we should have been able to read the PCI and ACPI specs and
implement this without tripping over problem on this particular
hardware.  I'm looking for the text that enables that "clean-room"
implementation.  If the spec doesn't have that text, it's either a
hole in the spec or a BIOS defect that depends on something the spec
doesn't require.

Doing this in pci_save_state() still seems wrong to me.  For example,
e1000_probe() calls pci_save_state(), but this is not part of suspend.
IIUC, this patch will disconnect the opregion when we probe an e1000
NIC.  Is that what you intend?

> ---
>  drivers/pci/pci-acpi.c | 10 ++++++++++
>  drivers/pci/pci.c      | 14 ++++++++++++++
>  drivers/pci/pci.h      |  2 ++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1698205dd73c..abc8bcfc2c71 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1209,6 +1209,16 @@ void acpi_pci_remove_bus(struct pci_bus *bus)
>  	acpi_pci_slot_remove(bus);
>  }
>  
> +void acpi_pci_set_register_access(struct pci_dev *dev, bool enable)
> +{
> +	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
> +	int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
> +				    ACPI_ADR_SPACE_PCI_CONFIG, val);
> +	if (ret)
> +		pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
> +			val ? "connect" : "disconnect", ret);
> +}
> +
>  /* ACPI bus type */
>  
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e38c2f6eebd4..b2f1f603ec62 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1068,6 +1068,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  	return acpi_pci_bridge_d3(dev);
>  }
>  
> +static inline void platform_set_register_access(struct pci_dev *dev, bool en)
> +{
> +	if (pci_use_mid_pm())
> +		return;
> +
> +	acpi_pci_set_register_access(dev, en);
> +}
> +
>  /**
>   * pci_update_current_state - Read power state of given device and cache it
>   * @dev: PCI device to handle.
> @@ -1645,6 +1653,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
>  int pci_save_state(struct pci_dev *dev)
>  {
>  	int i;
> +
> +	platform_set_register_access(dev, false);
> +
>  	/* XXX: 100% dword access ok here? */
>  	for (i = 0; i < 16; i++) {
>  		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> @@ -1790,6 +1801,8 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_enable_acs(dev);
>  	pci_restore_iov_state(dev);
>  
> +	platform_set_register_access(dev, true);
> +
>  	dev->state_saved = false;
>  }
>  EXPORT_SYMBOL(pci_restore_state);
> @@ -3203,6 +3216,7 @@ void pci_pm_init(struct pci_dev *dev)
>  	pci_read_config_word(dev, PCI_STATUS, &status);
>  	if (status & PCI_STATUS_IMM_READY)
>  		dev->imm_ready = 1;
> +	platform_set_register_access(dev, true);
>  }
>  
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ffccb03933e2..78961505aae2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -703,6 +703,7 @@ void acpi_pci_refresh_power_state(struct pci_dev *dev);
>  int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
>  bool acpi_pci_need_resume(struct pci_dev *dev);
>  pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
> +void acpi_pci_set_register_access(struct pci_dev *dev, bool enable);
>  #else
>  static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>  {
> @@ -742,6 +743,7 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  {
>  	return PCI_POWER_ERROR;
>  }
> +static inline void acpi_pci_set_register_access(struct pci_dev *dev, bool enable) {}
>  #endif
>  
>  #ifdef CONFIG_PCIEASPM
> -- 
> 2.34.1
> 
