Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189B56CF633
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 00:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjC2WKB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 18:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjC2WKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 18:10:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C456059DA;
        Wed, 29 Mar 2023 15:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EBFCB820F8;
        Wed, 29 Mar 2023 22:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834D0C4339B;
        Wed, 29 Mar 2023 22:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680127769;
        bh=Pkw+JnlC6QcBvC6P1F68Al5nhlo1P1BkPpRe/KS8NyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lBEMRaFdPEO3+9GcLR/ts2W9xwoGi9D+NUoBcP2zQ9THqzbAO0y+qB7+zmosEFz/7
         4KVb49bU3JsXn1j0xcJLfIO6I5wVYdReixvd0qnwFmBH/gybNaJ9FW01WOSyfIGW/u
         N1KuR6WIDDyknzMKhR3y88EzySa3JS8Iul0Wk64qkKyala8roZpPJUPLW3cC7rlzJo
         TMh/Sywy+V22ayxXw+W6YWRSMrZhBeXW8aJQ6M1S8Pwr9/aFKwZO5qDHKKKhzj06Aq
         IibXSyZp7xtQAizxozaZDcejnuy2YxBnbrDaB6my7Y6+OQlZxrbCuu0rQKkQRW8bxX
         Qu1b52UGrUqcw==
Date:   Wed, 29 Mar 2023 17:09:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Message-ID: <20230329220927.GA3086137@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315235449.1279209-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jonathan, author of 068c29a248b6]

On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
> OS owns AER") adds support to clear error status in the Device Status
> Register(DEVSTA) only if OS owns the AER support. But this change
> breaks the requirement of the EDR feature which requires OS to cleanup
> the error registers even if firmware owns the control of AER support.
> 
> More details about this requirement can be found in PCIe Firmware
> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
> If the OS supports the Error Disconnect Recover (EDR) feature and
> firmware sends the EDR event, then during the EDR recovery window, OS
> is responsible for the device error recovery and holds the ownership of
> the following error registers.
> 
> • Device Status Register
> • Uncorrectable Error Status Register
> • Correctable Error Status Register
> • Root Error Status Register
> • RP PIO Status Register
> 
> So call pcie_clear_device_status() in edr_handle_event() if the error
> recovery is successful.

IIUC, after ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR)
support") appeared in v5.7-rc1, DEVSTA was always cleared in this path:

  edr_handle_event
    pcie_do_recovery
      pcie_clear_device_status

After 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
OS owns AER") appeared in v5.9-rc1, we only clear DEVSTA if the OS
owns the AER Capability:

  edr_handle_event
    pcie_do_recovery
      if (pcie_aer_is_native(dev))      # <-- new test
        pcie_clear_device_status

So in the case where the OS does *not* own AER, and it receives an EDR
notification, DEVSTA is not cleared when it should be.  Right?

I assume we should have a Fixes: tag here, since this patch should be
backported to every kernel that contains 068c29a248b6.  Possibly even
a stable tag, although it's arguable whether it's "critical" per
Documentation/process/stable-kernel-rules.rst.

> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>

I assume this report was internal, and there's no mailing list post or
bugzilla issue URL we can include here?

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v1:
>  * Rebased on top of v6.3-rc1.
>  * Fixed a typo in pcie_clear_device_status().
> 
>  drivers/pci/pcie/edr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index a6b9b479b97a..87734e4c3c20 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>  	 */
>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
>  		pci_dbg(edev, "DPC port successfully recovered\n");
> +		pcie_clear_device_status(edev);

It's a little weird to work around a change inside pcie_do_recovery()
by clearing it here, and that means we clear it twice in the AER
native case, but I don't see any simpler way to do this, so this seems
fine as the fix for the current issue.

Question though: in the AER native case, pcie_do_recovery() calls
both:

  pcie_clear_device_status() and
  pci_aer_clear_nonfatal_status()

In this patch, you only call pcie_clear_device_status().  Do you care
about pci_aer_clear_nonfatal_status(), too?

The overall design for clearing status has gotten pretty complicated
as we've added error handling methods (firmware-first, DPC, EDR), and
there are so many different places and cases that it's hard to be sure
we do them all correctly.

I don't really know how to clean this up, so I'm just attaching my
notes about the current state:

  - AER native handling:

    handle_error_source
      if (info->severity == AER_CORRECTABLE)
        clear PCI_ERR_COR_STATUS              <--
        if (pcie_aer_is_native(dev))
          pdrv->err_handler->cor_error_detected()
          pcie_clear_device_status
            clear PCI_EXP_DEVSTA              <--
      else
        pcie_do_recovery
          pcie_clear_device_status
            clear PCI_EXP_DEVSTA              <--
          pci_aer_clear_nonfatal_status
            clear PCI_ERR_UNCOR_STATUS        <--

  - Firmware-first handling: status is cleared by firmware before
    event is reported to OS via HEST

  - DPC native handling:

    dpc_handler
      dpc_process_error
        if (rp_extensions)
          dpc_process_rp_pio_error
            clear PCI_EXP_DPC_RP_PIO_STATUS   <--
        else if (...)
          pci_aer_clear_nonfatal_status
            clear PCI_ERR_UNCOR_STATUS        <--
          pci_aer_clear_fatal_status
            clear PCI_ERR_UNCOR_STATUS        <--
      pcie_do_recovery
        if (AER native)
          pcie_clear_device_status
            clear PCI_EXP_DEVSTA              <--
          pci_aer_clear_nonfatal_status
            clear PCI_ERR_UNCOR_STATUS        <--

  - EDR event handling:

    edr_handle_event
      dpc_process_error
        if (rp_extensions)
          dpc_process_rp_pio_error
            clear PCI_EXP_DPC_RP_PIO_STATUS   <--
        else if (...)
          pci_aer_clear_nonfatal_status
            clear PCI_ERR_UNCOR_STATUS        <--
          pci_aer_clear_fatal_status
            clear PCI_ERR_UNCOR_STATUS        <--
      pci_aer_raw_clear_status
        clear PCI_ERR_ROOT_STATUS             <--
        clear PCI_ERR_COR_STATUS              <--
        clear PCI_ERR_UNCOR_STATUS            <--
      pcie_do_recovery
        if (AER native)
          pcie_clear_device_status
            clear PCI_EXP_DEVSTA              <--
          pci_aer_clear_nonfatal_status
            clear PCI_ERR_UNCOR_STATUS        <--
      if (PCI_ERS_RESULT_RECOVERED)
        pcie_clear_device_status
          clear PCI_EXP_DEVSTA                <--

>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
>  	} else {
>  		pci_dbg(edev, "DPC port recovery failed\n");
> -- 
> 2.34.1
> 
