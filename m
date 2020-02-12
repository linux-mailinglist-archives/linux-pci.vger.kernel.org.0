Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBF415AB14
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 15:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgBLOip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 09:38:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgBLOio (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 09:38:44 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5554420724;
        Wed, 12 Feb 2020 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581518323;
        bh=lp4tT2A5d7K0UV6Qb0AwY6/DDxCjUy6M9QdT0owJzCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nep5Zdkj7vA4x39wNseluGA2PnIx5G+Ao2TwZm15ocC3SGPE+TeBNArkuXx4WwL9/
         4PEqV4120CcVoHgirhxC7Kn/n6O4dSH98vRNkaaSJIQ2zsDWQe/F0j+CiKgQDIAn3J
         wMs/zE1ViTLxGnZr4RvvvyKgU1/aNX0q/TFJhNJI=
Date:   Wed, 12 Feb 2020 08:38:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v14 0/5] Add Error Disconnect Recover (EDR) support
Message-ID: <20200212143842.GA133681@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581119844.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 07, 2020 at 04:03:30PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
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

Hi Sathy,

Bad timing!  Linus tagged v5.6-rc1 on Feb 9, shortly after you posted
this.  Would you mind refreshing this so it applies on my "master"
branch (v5.6-rc1)?

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
> Kuppuswamy Sathyanarayanan (5):
>   PCI/ERR: Update error status after reset_link()
>   PCI/DPC: Remove pcie_device reference from dpc_dev structure
>   PCI/EDR: Export AER, DPC and error recovery functions
>   PCI/DPC: Add Error Disconnect Recover (EDR) support
>   PCI/ACPI: Enable EDR support
> 
>  drivers/acpi/pci_root.c   |  16 +++
>  drivers/pci/pci-acpi.c    |   3 +
>  drivers/pci/pci.h         |   8 ++
>  drivers/pci/pcie/Kconfig  |  10 ++
>  drivers/pci/pcie/Makefile |   1 +
>  drivers/pci/pcie/aer.c    |  39 ++++--
>  drivers/pci/pcie/dpc.c    |  92 ++++++++------
>  drivers/pci/pcie/dpc.h    |  20 +++
>  drivers/pci/pcie/edr.c    | 259 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/err.c    |  35 ++++--
>  drivers/pci/probe.c       |   1 +
>  include/linux/acpi.h      |   6 +-
>  include/linux/pci-acpi.h  |   8 ++
>  include/linux/pci.h       |   1 +
>  14 files changed, 441 insertions(+), 58 deletions(-)
>  create mode 100644 drivers/pci/pcie/dpc.h
>  create mode 100644 drivers/pci/pcie/edr.c
> 
> -- 
> 2.21.0
> 
