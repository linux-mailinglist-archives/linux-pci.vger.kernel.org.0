Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD619999E
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 17:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgCaP2L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 11:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgCaP2L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Mar 2020 11:28:11 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E6A20786;
        Tue, 31 Mar 2020 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585668490;
        bh=9gN//mK5UVb5oI3675OFZkQpiGmGfQCLZ6fYeaTLgLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1r9MkWGlOPY96fqtKnM2NBPRjsmfKiQMOYaho9XyNIOp8DN3Jd+m1a7zgHGkQHmxp
         0E1m6QNrVrc1OYrM6tSru/Ix/Lrz0X9kqlE7957qM/ccql63xLUO/zX89HkvU3oDON
         u8oy/odLzsadpqX42oyDC9d9dB3OahRqlBPA/+FQ=
Date:   Tue, 31 Mar 2020 10:28:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v18 00/11] Add Error Disconnect Recover (EDR) support
Message-ID: <20200331152805.GA188783@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 23, 2020 at 05:25:57PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> This patchset adds support for following features:
> 
> 1. Error Disconnect Recover (EDR) support.
> 2. _OSC based negotiation support for DPC.
> 
> You can find EDR spec in the following link.
> 
> https://members.pcisig.com/wg/PCI-SIG/document/12614
> 
> Changes since v17 + Bjorns changes:
>  * This version is based on Bjorn's review/edr branch.
>  * Moved {pciehp,shpchp}_is_native() function definitions to pci.c and
>    removed it's CONFIG_ACPI dependency.
>  * Modified dpc_reset_link() function to return PCI_ERS_RESULT_NEED_RESET
>    when hotplug is not supported or enabled in kernel.
>  * Modified reset_link() function to handle PCI_ERS_RESULT_NEED_RESET as
>    valid return value.
>  * Moved the implementation of reset_link() function to pcie_do_recovery()
>    and renamed function callback parameter from reset_cb to reset_link.
>  * Moved the order of pci_acpi_add_edr_notifier() and
>    pci_acpi_remove_edr_notifier() calls in pci_acpi_setup() and
>    pci_acpi_cleanup() above wakeup capable support checks.
>  * Used acpi_check_dsm() to check whether given _DSM is supported or
>    not in edr.c.
> 
> Changes since v16:
>  * Removed reset_link from pcie_port_service_driver.
>  * Removed pcie_port_find_service().
>  * Added pci_dpc_init() in pci_init_capabilities().
> 
> Changes since v15:
>  * Splitted Patch # 3 in previous set into multiple patches.
>  * Refactored EDR driver use pci_dev instead of dpc_dev.
>  * Added some debug logs to EDR driver.
>  * Used pci_aer_raw_clear_status() for clearing AER errors in EDR path.
>  * Addressed other comments from Bjorn.
>  * Rebased patches on top of Bjorns "PCI/DPC: Move data to struct pci_dev" patch.
> 
> Changes since v14:
>  * Rebased on top of v5.6-rc1
> 
> Changes since v13:
>  * Moved all EDR related code to edr.c
>  * Addressed Bjorns comments.
> 
> Changes since v12:
>  * Addressed Bjorns comments.
>  * Added check for CONFIG_PCIE_EDR before requesting DPC control from firmware.
>  * Removed ff_check parameter from AER APIs.
>  * Used macros for _OST return status values in DPC driver.
> 
> Changes since v11:
>  * Allowed error recovery to proceed after successful reset_link().
>  * Used correct ACPI handle for sending EDR status.
>  * Rebased on top of v5.5-rc5
> 
> Changes since v10:
>  * Added "edr_enabled" member to dpc priv structure, which is used to cache EDR
>    enabling status based on status of pcie_ports_dpc_native and FF mode.
>  * Changed type of _DSM argument from Integer to Package in acpi_enable_dpc_port()
>    function to fix ACPI related boot warnings.
>  * Rebased on top of v5.5-rc3
> 
> Changes since v9:
>  * Removed caching of pcie_aer_get_firmware_first() in dpc driver.
>  * Added proper spec reference in git log for patch 5 & 7.
>  * Added new function parameter "ff_check" to pci_cleanup_aer_uncorrect_error_status(),
>    pci_aer_clear_fatal_status() and pci_cleanup_aer_error_status_regs() functions.
>  * Rebased on top of v5.4-rc5
> 
> Changes since v8:
>  * Rebased on top of v5.4-rc1
> 
> Changes since v7:
>  * Updated DSM version number to match the spec.
> 
> Changes since v6:
>  * Modified the order of patches to enable EDR only after all necessary support is added in kernel.
>  * Addressed Bjorn comments.
> 
> Changes since v5:
>  * Addressed Keith's comments.
>  * Added additional check for FF mode in pci_aer_init().
>  * Updated commit history of "PCI/DPC: Add support for DPC recovery on NON_FATAL errors" patch.
> 
> Changes since v4:
>  * Rebased on top of v5.3-rc1
>  * Fixed lock/unlock issue in edr_handle_event().
>  * Merged "Update error status after reset_link()" patch into this patchset.
> 
> Changes since v3:
>  * Moved EDR related ACPI functions/definitions to pci-acpi.c
>  * Modified commit history in few patches to include spec reference.
>  * Added support to handle DPC triggered by NON_FATAL errors.
>  * Added edr_lock to protect PCI device receiving duplicate EDR notifications.
>  * Addressed Bjorn comments.
> 
> Changes since v2:
>  * Split EDR support patch into multiple patches.
>  * Addressed Bjorn comments.
> 
> Changes since v1:
>  * Rebased on top of v5.1-rc1
> 
> Bjorn Helgaas (1):
>   PCI/DPC: Move DPC data into struct pci_dev
> 
> Kuppuswamy Sathyanarayanan (10):
>   PCI/ERR: Update error status after reset_link()
>   PCI: move {pciehp,shpchp}_is_native() definitions to pci.c
>   PCI/DPC: Fix DPC recovery issue in non hotplug case
>   PCI/ERR: Remove service dependency in pcie_do_recovery()
>   PCI/ERR: Return status of pcie_do_recovery()
>   PCI/DPC: Cache DPC capabilities in pci_init_capabilities()
>   PCI/AER: Add pci_aer_raw_clear_status() to unconditionally clear Error
>     Status
>   PCI/DPC: Expose dpc_process_error(), dpc_reset_link() for use by EDR
>   PCI/DPC: Add Error Disconnect Recover (EDR) support
>   PCI/AER: Rationalize error status register clearing

Applied to pci/edr for v5.7, except these two:

    PCI: move {pciehp,shpchp}_is_native() definitions to pci.c
    PCI/DPC: Fix DPC recovery issue in non hotplug case

>  Documentation/PCI/pcieaer-howto.rst       |  23 +-
>  drivers/acpi/pci_root.c                   |  15 ++
>  drivers/net/ethernet/intel/ice/ice_main.c |   4 +-
>  drivers/ntb/hw/idt/ntb_hw_idt.c           |   4 +-
>  drivers/pci/pci-acpi.c                    |  40 +---
>  drivers/pci/pci.c                         |  40 +++-
>  drivers/pci/pci.h                         |  13 +-
>  drivers/pci/pcie/Kconfig                  |  10 +
>  drivers/pci/pcie/Makefile                 |   1 +
>  drivers/pci/pcie/aer.c                    |  40 ++--
>  drivers/pci/pcie/dpc.c                    | 145 ++++++-------
>  drivers/pci/pcie/edr.c                    | 251 ++++++++++++++++++++++
>  drivers/pci/pcie/err.c                    |  67 ++----
>  drivers/pci/pcie/portdrv.h                |   5 -
>  drivers/pci/pcie/portdrv_core.c           |  21 --
>  drivers/pci/probe.c                       |   2 +
>  drivers/scsi/lpfc/lpfc_attr.c             |   4 +-
>  include/linux/acpi.h                      |   6 +-
>  include/linux/aer.h                       |   9 +-
>  include/linux/pci-acpi.h                  |   8 +
>  include/linux/pci.h                       |   6 +
>  include/linux/pci_hotplug.h               |   7 +-
>  22 files changed, 471 insertions(+), 250 deletions(-)
>  create mode 100644 drivers/pci/pcie/edr.c
> 
> -- 
> 2.17.1
> 
