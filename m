Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA97778424
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 01:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjHJXaL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 19:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHJXaL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 19:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F7270F;
        Thu, 10 Aug 2023 16:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACE9F64195;
        Thu, 10 Aug 2023 23:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D000CC433C7;
        Thu, 10 Aug 2023 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691710209;
        bh=W8E2PvzLoHi5b1V9JOv50GqRdSe3slZAVElO1A4fYkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Yad3ZL7vMirYjOQt4WncLO9hc777fWRgQrrWxkfyoBs2TGzmCi+oKKIj7ESsPZ7qw
         Aku4+ZzKRkvP6aYrMEwG/JSR1Qzxdnq8yxRfWEm9EfmWsSV75bdbXk1wiS/JIYag/3
         RtSCfl0fF9qfAkIGizcgmeBmqYVVnbH2vz5DOLp+EKq3Yh/be1SdXqVKha7J92n7J5
         c6E5GvbSVgr0gB3RDGPxVDAdGi2UWkAxLTbpbYLWPEaV9eWqO8MWtdjNr4Z3efiJ/B
         g60XUPdestbiogVwPZSP4oiUZbmzOrwtM0b2BV4oeHDVVqnv60oQcDSzlmE6rNzwGf
         7lb3aWcUvDX8A==
Date:   Thu, 10 Aug 2023 18:30:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, bhelgaas@google.com, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH v3 4/5] ACPI/PCI: Add pci_acpi_program_hest_aer_params()
Message-ID: <20230810233007.GA41830@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704120544.1322315-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 04, 2023 at 08:05:44PM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> The extracted register values from HEST PCI Express AER structures are
> written to AER Capabilities.

In the subject, the prevailing style for this file is
(see "git log --oneline drivers/pci/pci-acpi.c"):

  PCI/ACPI: ...

And I'd like the subject to tell users why they might want this patch.
It's obvious from the patch that this adds a function.  What's *not*
obvious is *why* we want this new function.  So the commit log should
tell us what the benefit is, and the subject line should be one-line
summary of that benefit.

This patch adds a function but no caller.  The next patch is one-liner
that adds the caller.  I think these two should be squashed so it's
easier to review (and easier to explain the benefit of *this* patch :))

> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  drivers/pci/pci-acpi.c | 92 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h      |  5 +++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a05350a4e49cb..cff54410e2427 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
>  #include <linux/rwsem.h>
> +#include <acpi/apei.h>
>  #include "pci.h"
>  
>  /*
> @@ -783,6 +784,97 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>  	return -ENODEV;
>  }
>  
> +/*
> + * program_aer_structure_to_aer_registers - Write the AER structure to
> + * the corresponding dev's AER registers.
> + *
> + * @info - the AER structure information
> + *

Remove the spurious blank comment line.

> + */
> +static void program_aer_structure_to_aer_registers(struct acpi_hest_parse_aer_info info)
> +{
> +	u32 uncorrectable_mask;
> +	u32 uncorrectable_severity;
> +	u32 correctable_mask;
> +	u32 advanced_capabilities;
> +	u32 root_error_command;
> +	u32 uncorrectable_mask2;
> +	u32 uncorrectable_severity2;
> +	u32 advanced_capabilities2;
> +	int port_type;
> +	int pos;
> +	struct pci_dev *dev;

Order these declarations in order of use.

> +	dev = info.pci_dev;
> +	port_type = pci_pcie_type(dev);
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> +	if (!pos)
> +		return;
> +
> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
> +		uncorrectable_mask = info.acpi_hest_aer_root_port->uncorrectable_mask;
> +		uncorrectable_severity = info.acpi_hest_aer_root_port->uncorrectable_severity;
> +		correctable_mask = info.acpi_hest_aer_root_port->correctable_mask;
> +		advanced_capabilities = info.acpi_hest_aer_root_port->advanced_capabilities;
> +		root_error_command = info.acpi_hest_aer_root_port->root_error_command;

Except for this new code, this file fits in 80 columns, so I'd like
the new code to match.

> +
> +		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncorrectable_mask);

I'm not sure we need to copy everything into local variables.  Maybe
this could be split into three helper functions, which would save a
level of indent and a level of struct traversal (e.g., "rp->" instead
of "info.acpi_hest_aer_root_port->".

  pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, rp->uncorrectable_mask);

or

  pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK,
                         rp->uncorrectable_mask);

If you have to define a new struct acpi_hest_aer_root_port, you could
make the member names shorter.  But hopefully you *don't* have to do
that, so maybe we're stuck with the long existing member names in
acpi_hest_aer_common.

> +int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
> +{
> +	struct acpi_hest_parse_aer_info info = {
> +		.pci_dev	= dev,
> +		.hest_matched_with_dev	= 0,
> +		.acpi_hest_aer_endpoint = NULL,
> +		.acpi_hest_aer_root_port = NULL,
> +		.acpi_hest_aer_for_bridge = NULL,

Drop the tab from the .pci_dev initialization since the other members
aren't lined up anyway.  I think you can drop the other
initializations completely since they will be initialized to 0 or NULL
pointers by default.

> +	};
> +
> +	if (!pci_is_pcie(dev))
> +		return -ENODEV;
> +
> +	apei_hest_parse(apei_hest_parse_aer, &info);
> +	if (info.hest_matched_with_dev == 1)
> +		program_aer_structure_to_aer_registers(info);
> +	else
> +		return -ENODEV;
> +	return 0;
> +}
> +
>  /**
>   * pciehp_is_native - Check whether a hotplug port is handled by the OS
>   * @bridge: Hotplug port to check
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a4c3974340576..37aa4a33eeed2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -713,6 +713,7 @@ void acpi_pci_refresh_power_state(struct pci_dev *dev);
>  int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
>  bool acpi_pci_need_resume(struct pci_dev *dev);
>  pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
> +int pci_acpi_program_hest_aer_params(struct pci_dev *dev);
>  #else
>  static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>  {
> @@ -752,6 +753,10 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  {
>  	return PCI_POWER_ERROR;
>  }
> +static inline int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #ifdef CONFIG_PCIEASPM
> -- 
> 2.34.1
> 
