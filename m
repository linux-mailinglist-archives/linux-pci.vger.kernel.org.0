Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC92288D5B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbgJIPxN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 11:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388745AbgJIPxM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 11:53:12 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78CD72225D;
        Fri,  9 Oct 2020 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602258791;
        bh=c0Oco5+Y93BuKExeQgRVmoPcdBSWarHJTrDoTYOek08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rZiOE8gb5C44MTvAkf4Sx2DrcDm34ccnDEzGv+Wac8wQqBn8lCZTe0SJPkEjxSRQm
         NEKTobyHHPUUQg94/Y5MnMDhpqNqJul00KBsBORURG6vYFIU40j7MJ5JnTOGnc9KGK
         1FTyMOoUk5M8VjVp4Z0DPx68NieX8md2/TBCyeFI=
Date:   Fri, 9 Oct 2020 10:53:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v8 00/14] Add RCEC handling to PCI/AER
Message-ID: <20201009155310.GA3477892@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 02, 2020 at 11:47:21AM -0700, Sean V Kelley wrote:
> From: Sean V Kelley <sean.v.kelley@intel.com>
> 
> Changes since v7 [1]:
> 
> - No functional changes.
> 
> - Reword bridge patch.
> - Noted testing below for #non-native/no RCEC case
> (Jonathan Cameron)
> 
> - Separate out pci_walk_bus() into pci_walk_bridge() change.
> - Put remaining dev to bridge name changes in the separate patch from v7.
> (Bjorn Helgaas)
> 
> [1] https://lore.kernel.org/lkml/20200930215820.1113353-1-seanvk.dev@oregontracks.org/
> 
> Root Complex Event Collectors (RCEC) provide support for terminating error
> and PME messages from Root Complex Integrated Endpoints (RCiEPs).  An RCEC
> resides on a Bus in the Root Complex. Multiple RCECs can in fact reside on
> a single bus. An RCEC will explicitly declare supported RCiEPs through the
> Root Complex Endpoint Association Extended Capability.
> 
> (See PCIe 5.0-1, sections 1.3.2.3 (RCiEP), and 7.9.10 (RCEC Ext. Cap.))
> 
> The kernel lacks handling for these RCECs and the error messages received
> from their respective associated RCiEPs. More recently, a new CPU
> interconnect, Compute eXpress Link (CXL) depends on RCEC capabilities for
> purposes of error messaging from CXL 1.1 supported RCiEP devices.
> 
> DocLink: https://www.computeexpresslink.org/
> 
> This use case is not limited to CXL. Existing hardware today includes
> support for RCECs, such as the Denverton microserver product
> family. Future hardware will be forthcoming.
> 
> (See Intel Document, Order number: 33061-003US)
> 
> So services such as AER or PME could be associated with an RCEC driver.
> In the case of CXL, if an RCiEP (i.e., CXL 1.1 device) is associated with a
> platform's RCEC it shall signal PME and AER error conditions through that
> RCEC.
> 
> Towards the above use cases, add the missing RCEC class and extend the
> PCIe Root Port and service drivers to allow association of RCiEPs to their
> respective parent RCEC and facilitate handling of terminating error and PME
> messages.
> 
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #non-native/no RCEC
> 
> 
> Jonathan Cameron (1):
>   PCI/AER: Extend AER error handling to RCECs
> 
> Qiuxu Zhuo (5):
>   PCI/RCEC: Add RCEC class code and extended capability
>   PCI/RCEC: Bind RCEC devices to the Root Port driver
>   PCI/AER: Apply function level reset to RCiEP on fatal error
>   PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
>   PCI/AER: Add RCEC AER error injection support
> 
> Sean V Kelley (8):
>   PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
>   PCI/ERR: Rename reset_link() to reset_subordinate_device()
>   PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
>   PCI/ERR: Add pci_walk_bridge() to pcie_do_recovery()
>   PCI/ERR: Limit AER resets in pcie_do_recovery()
>   PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
>   PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
>   PCI/PME: Add pcie_walk_rcec() to RCEC PME handling
> 
>  drivers/pci/pci.h               |  25 ++++-
>  drivers/pci/pcie/Makefile       |   2 +-
>  drivers/pci/pcie/aer.c          |  36 ++++--
>  drivers/pci/pcie/aer_inject.c   |   5 +-
>  drivers/pci/pcie/err.c          | 109 +++++++++++++++----
>  drivers/pci/pcie/pme.c          |  15 ++-
>  drivers/pci/pcie/portdrv_core.c |   8 +-
>  drivers/pci/pcie/portdrv_pci.c  |   8 +-
>  drivers/pci/pcie/rcec.c         | 187 ++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c             |   2 +
>  include/linux/pci.h             |   5 +
>  include/linux/pci_ids.h         |   1 +
>  include/uapi/linux/pci_regs.h   |   7 ++
>  13 files changed, 367 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/pci/pcie/rcec.c

Thank you very much for your work and patience with this series!

Applied to pci/err for v5.10 with the following changes:

  - Make pci_rcec_init() void since return value was unused.

  - Reorder pci_rcec_init() so rcec_ea is filled in before publishing
    in dev->rcec_ea.

  - Split pcie_do_recovery() patches up a little more.  My hope was to
    make the "Use 'bridge' for clarity" patch more of a pure rename
    patch and easier to review.  Not sure I accomplished that.

  - Log messages and uevents with "bridge", not "dev", in
    pcie_do_recovery() to preserve previous behavior.

  - Rename reset_subordinate_devices() to reset_subordinates() for
    brevity.

  - Fix kerneldoc issues (reported with "make W=1").

  - Fix whitespace (lines didn't use the full width or > 80 columns,
    etc).

Please let me know if I botched anything.
